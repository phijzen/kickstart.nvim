local M = {}

function M.find_project_versify_config(bufnr)
  if not bufnr or bufnr == 0 then
    bufnr = vim.api.nvim_get_current_buf()
  end

  local filepath = vim.api.nvim_buf_get_name(bufnr)
  if filepath == '' then
    return nil
  end

  local project_root = filepath:match '(.*/projects/[^/]+)'
  if project_root then
    local config_path = project_root .. '/.versify_cache/pyproject.toml'
    local stat = vim.loop.fs_stat(config_path)
    if stat then
      return config_path
    end
  end
  return nil
end

return M
