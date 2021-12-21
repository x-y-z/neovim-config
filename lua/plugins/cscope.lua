local opt = vim.opt         		-- global/buffer/windows-scoped options

if io.open("cscope.out", "r") ~= nil then
  opt.cscopetag = true
  opt.csto = 0
  opt.cscopeverbose = true

  vim.cmd("cs add cscope.out")
end
