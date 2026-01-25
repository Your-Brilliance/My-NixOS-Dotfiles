return {
  "rmagatti/auto-session",
  lazy = false,
  opts = {
    auto_save_enabled = true,
    auto_restore_enabled = false, -- Set to false so you can use your keybinds manually
    auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
    session_lens = {
      load_on_setup = true,
      theme_conf = { border = true },
      previewer = false,
    },
  },
}

