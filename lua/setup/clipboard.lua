if vim.fn.has "wsl" == 1 then
  -- on wsl, "unnamedplus" is wl-copy as far as I've observed.
  -- and somehow, it fails to create wayland socket on the runtime dir.
  -- That effectively disable us from using that.
  -- xsel worked out excellently on my home and work environment.
  -- I assume it works for most of you.
  vim.g.clipboard = {
    name = "WslClipboard",
    copy = {
      ["+"] = "xsel -bi",
      ["*"] = "xsel -bi",
    },
    paste = {
      ["+"] = "xsel -bo",
      ["*"] = "xsel -bo",
    },
    cache_enabled = 0,
  }
else
  vim.opt.clipboard = "unnamedplus"
end
