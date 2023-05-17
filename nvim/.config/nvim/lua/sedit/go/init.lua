local M = {}

function M.setup()
end

-- Gets the current function and prepends a context.Context
-- to the function signature if it doesn't already have one
function M.prepend_go_ctx()
  -- Use treesitter to get the current function name
  local ts_utils = require("nvim-treesitter.ts_utils")
  local node = ts_utils.get_node_at_cursor()
  -- while the node is not a function, keep going up the tree
  while node:type() ~= "function_declaration" do
    node = node:parent()
  end
  -- get the function name
  -- local func_name = node:field("identifier")[1]
  -- get the parameters node
  local params = node:field("parameters")[1]
  if params:named_child_count() > 0 then
    -- if the first parameters is a context.Context, do nothing
    local first_param_decl = params:named_child(0)
    local first_param_type = first_param_decl:field("type")[1]
    if first_param_type:type() == 'qualified_type' and
        vim.treesitter.get_node_text(first_param_type, 0) == 'context.Context' then
      return
    end
  end
  -- add a context.Context
  -- If there is more than one parameter, make sure to add a comma
  local comma = ""
  if params:named_child_count() > 0 then
    comma = ", "
  end
  -- add the context.Context
  local start_row, start_col, _, _ = params:range()
  vim.api.nvim_buf_set_text(0, start_row, start_col + 1,
    start_row, start_col + 1, { "ctx context.Context" .. comma })
end

return M
