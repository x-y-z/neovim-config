local dap = require("dap")
local dap_utils = require("dap.utils")
local default_args = {"--interpreter=dap", "--eval-command", "set print pretty on"}
dap.adapters.gdb = {
  type = "executable",
  command = "gdb",
  args = default_args,
}

local function get_executable()
  return coroutine.create(function(dap_run_co)
    require("snacks").picker.pick({
      source = "executables",
      -- Directly specify the finder and command
      finder = "proc",
      cmd = "find",
      args = { ".", "-executable", "-type", "f" },
      -- Transform the raw output lines into picker items
      transform = function(item)
        item.file = item.text
      end,
      actions = {
        confirm = function(picker, item)
          picker:close()
          if item and item.file then
            coroutine.resume(dap_run_co, item.file)
          end
        end,
      },
    })
  end)
end

-- not using find
-- local function get_executable2()
--     return dap_utils.pick_file({executable=true})
-- end

local function get_arguments()
  return coroutine.create(function(dap_run_co)
    local args = {}
    local new_args = default_args
    table.insert(new_args, "--args")

    vim.ui.input({ prompt = "Args: " }, function(input)
      args = vim.split(input or "", " ")
      table.move(args, 1, #args, #new_args + 1, new_args)
      coroutine.resume(dap_run_co, new_args)
    end)
  end)
end

dap.configurations.c = {
  {
    name = "Launch (GDB)",
    type = "gdb",
    request = "launch",
    program = get_executable,
    cwd = "${workspaceFolder}",
    stopAtEntry = true, -- Optional: stop at the beginning of the program
  },
  {
    name = "Launch (GDB) with input",
    type = "gdb",
    request = "launch",
    program = get_executable,
    args = get_arguments,
    cwd = "${workspaceFolder}",
    stopAtEntry = true, -- Optional: stop at the beginning of the program
  },
  {
    name = "Select and attach to process",
    type = "gdb",
    request = "attach",
    program = get_executable,
    pid = function()
      local name = vim.fn.input('Executable name (filter): ')
      return require("dap.utils").pick_process({ filter = name })
    end,
    cwd = '${workspaceFolder}'
  },
  {
    name = 'Attach to gdbserver :1234',
    type = 'gdb',
    request = 'attach',
    target = 'localhost:1234',
    program = get_executable,
    cwd = '${workspaceFolder}'
  }
}

-- Repeat for C++ if needed
dap.configurations.cpp = dap.configurations.c
dap.configurations.cuda = dap.configurations.c

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

