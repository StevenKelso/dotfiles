local augroup = vim.api.nvim_create_augroup("LspConfig", {
    clear = true,
})

local function lsp_on_attach(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    if not client then
        return
    end

    local bufnr = ev.buf

    local opts = {
        noremap = true,
        silent = true,
        buffer = bufnr,
    }

    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

    vim.keymap.set("n", "<leader>dl", vim.diagnostic.open_float, {
        desc = "Show line diagnostics",
        buffer = bufnr,
    })

    vim.keymap.set("n", "<leader>fd", function()
        local params = vim.lsp.util.make_position_params()

        vim.lsp.buf_request(0, "textDocument/definition", params, function(err, result)
            if err or not result or vim.tbl_isempty(result) then
                vim.notify("No definition found", vim.log.levels.WARN)
                return
            end

            local location = vim.islist(result) and result[1] or result

            local target_uri = location.uri or location.targetUri
            local current_uri = vim.uri_from_bufnr(0)

            if target_uri ~= current_uri then
                vim.notify(
                    "Definition is in another file",
                    vim.log.levels.INFO
                )

                return
            end

            vim.lsp.util.show_document(location, "utf-8")
        end)
    end, opts)

    vim.keymap.set("n", "<leader>ft", function()
        require("fzf-lua").lsp_definitions({
            jump1 = true,
        })
    end, opts)

    vim.keymap.set("n", "<leader>fsv", function()
        vim.cmd("vsplit")
        vim.lsp.buf.definition()
    end, opts)

    vim.keymap.set("n", "<leader>fsh", function()
        vim.cmd("split")
        vim.lsp.buf.definition()
    end, opts)

    vim.keymap.set("n", "<leader>fr", function()
        require("fzf-lua").lsp_references()
    end, opts)
end

vim.api.nvim_create_autocmd("LspAttach", {
    group = augroup,
    callback = lsp_on_attach,
})
