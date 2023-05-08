local M = {}

-- TODO: I hope this works!
M.todo = function()
  local parser = require("nvim-treesitter.parsers").get_parser()
  local query_string = '(comment) @comment (#match? @comment "TODO")'
  local ok query = pcall(
    vim.treesitter.query.parse(parser:lang(), query_string)
  )
  if not ok then return end

  vim.pretty_print(query)

  -- Will it find comments containing TODO?
  local qf_list = {}
  local tree = parser:parse()[1]
  -- 0 here refers to the current buffer.
  for _, n in query:iter_captures(tree:root(), 0) do
    local text = vim.treesitter.query.get_node_next(n, 0)
    print(text)
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

return M
