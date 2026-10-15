-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function () 
  hl.exec_cmd("hyprpaper")
  hl.exec_cmd("hyprsunset")
  hl.exec_cmd("hypridle")
  hl.exec_cmd("qs")
  hl.exec_cmd("mako")
  hl.exec_cmd("nm-applet")
  hl.exec_cmd("udiskie")
end)
