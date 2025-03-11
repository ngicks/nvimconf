if vim.fn.has "wsl" == 1 then
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
