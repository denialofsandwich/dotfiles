local compare = require("cmp.config.compare")
compare.python_kwargs = function(entry1, entry2)
  if vim.o.filetype ~= "python" then
    return
  end
  -- needed because cmp sometimes gives you the same entry and you must return nil in that case
  if entry1:get_completion_item().label == entry2:get_completion_item().label then
    return
  end
  if entry1:get_completion_item().label:match("%w*=") then
    -- return true to pick entry1 over entry2
    return true
  end
end

compare.python_dunder = function(entry1, entry2)
  local _, entry1_under = entry1.completion_item.label:find("^_+")
  local _, entry2_under = entry2.completion_item.label:find("^_+")
  entry1_under = entry1_under or 0
  entry2_under = entry2_under or 0
  if entry1_under > entry2_under then
    return false
  elseif entry1_under < entry2_under then
    return true
  end
end

return {
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")
      -- opts.completion.autocomplete = False
      opts.experimental.ghost_text = false
      opts.sorting.comparators = {
        compare.offset,
        compare.exact,
        compare.scopes,
        compare.score,
        compare.python_kwargs,
        compare.python_dunder,
        compare.recently_used,
        compare.locality,
        compare.kind,
        compare.sort_text,
        compare.length,
        compare.order,
      }
      opts.mapping = vim.tbl_deep_extend("force", opts.mapping, {
        ["<PageDown>"] = cmp.mapping.select_next_item({ count = 8 }),
        ["<PageUp>"] = cmp.mapping.select_prev_item({ count = 8 }),
      })
      opts.window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      }
    end,
  },
}
