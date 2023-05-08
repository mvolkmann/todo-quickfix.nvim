local M = {}

-- This populates the quickfix list with lines that contain TODO comments.
-- See the YouTube video https://www.youtube.com/watch?v=PdaObkGazoU.
-- M.todo = function()
local function todo_qf()
  local parser = require("nvim-treesitter.parsers").get_parser()
  local query_string = '((comment) @comment (#match? @comment "TODO"))'

  -- Calling parse in a pcall handles the case where
  -- the language doesn't support comment nodes.
  local ok, query = pcall(
    vim.treesitter.query.parse, parser:lang(), query_string
  )
  if not ok then return end
 
  -- vim.print(query) -- for debugging

  local qf_list = {}
  local tree = parser:parse()[1]
  -- 0 here refers to the current buffer.
  for _, n in query:iter_captures(tree:root(), 0) do
    local text = vim.treesitter.query.get_node_text(n, 0)
    local lnum, col = n:range()
    table.insert(qf_list, {
      bufnr = vim.api.nvim_get_current_buf(),
      text = text,
      lnum = lnum + 1,
      col = col + 1
    })
  end
  vim.fn.setqflist(qf_list)
  vim.cmd.copen() -- opens the quickfix list
end

-- vim.api.nvim_create_user_command("TodoQF", M.todo, {})
M.setup = function()
  vim.api.nvim_create_user_command("TodoQF", todo_qf, {})
end

-- M.todo()

return M
