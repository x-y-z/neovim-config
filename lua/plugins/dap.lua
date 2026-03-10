local dap = require("dap")
dap.adapters.gdb = {
  type = "executable",
  command = "gdb",
  args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
}

dap.configurations.c = {
  {
    name = "Launch (GDB)",
    type = "gdb",
    request = "launch",
    -- A function to prompt for the executable path, common for general configs
    program = function()
      return vim.fn.input({
        prompt = "Path to executable: ",
        default = vim.fn.getcwd() .. "/",
      })
    end,
    cwd = "${workspaceFolder}",
    stopAtEntry = true, -- Optional: stop at the beginning of the program
  },
}

-- Repeat for C++ if needed
dap.configurations.cpp = dap.configurations.c

local dapui = require("dapui")
local default_opts = { noremap = true, silent = true }
dapui.setup()

dap.listeners.before.attach.dapui_config = function()
  dapui.open()
  vim.keymap.set('n', '<left>', dap.step_out, default_opts)
  vim.keymap.set('n', '<right>', dap.step_into, default_opts)
  vim.keymap.set('n', '<up>', dap.restart_frame, default_opts)
  vim.keymap.set('n', '<down>', dap.step_over, default_opts)
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
  vim.keymap.set('n', '<left>', dap.step_out, default_opts)
  vim.keymap.set('n', '<right>', dap.step_into, default_opts)
  vim.keymap.set('n', '<up>', dap.restart_frame, default_opts)
  vim.keymap.set('n', '<down>', dap.step_over, default_opts)
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

