
local M = {}

-- Executable commands for language servers that may be
-- installed externally.
--
-- Keep the arguments: some LSPs need "start" or "--stdio".
local commands = {
  nil_ls = { "nil" },
  clangd = { "clangd" },
  gopls = { "gopls" },
  bashls = { "bash-language-server", "start" },
  pyright = { "pyright-langserver", "--stdio" },
  ruff = { "ruff", "server" },
}

-- Find an executable in PATH, but ignore Mason's bin dir.
-- This allows the same config to work on Nix and non-Nix.
local function find_external(executable)
  local mason_bin =
    vim.fs.normalize(vim.fn.stdpath("data") .. "/mason/bin")

  -- PATH uses ":" on Unix and ";" on Windows.
  local separator = vim.fn.has("win32") == 1 and ";" or ":"

  for dir in (vim.env.PATH or ""):gmatch(
    "[^" .. separator .. "]+"
  ) do
    if vim.fs.normalize(dir) ~= mason_bin then
      local candidate = vim.fs.joinpath(dir, executable)

      if vim.fn.executable(candidate) == 1 then
        return candidate
      end
    end
  end

  return nil
end

-- Modify LazyVim's existing server configurations.
-- Never create new LSPs just because an executable exists.
function M.prefer_external(servers)
  for name, command in pairs(commands) do
    local opts = servers[name]

    if opts and opts ~= false then
      local executable = find_external(command[1])

      if executable then
        if opts == true then
          opts = {}
          servers[name] = opts
        end

        if type(opts) == "table" then
          -- Prevent Mason from installing this LSP.
          opts.mason = false

          -- Use the exact external executable even if
          -- Mason prepends another version to PATH.
          opts.cmd = vim.deepcopy(command)
          opts.cmd[1] = executable
        end
      end
    end
  end
end

return M
