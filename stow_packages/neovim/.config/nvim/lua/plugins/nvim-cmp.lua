local compare = require("cmp.config.compare")
local types = require("cmp.types")

local my_compare = {}

-- Prefer suggesting kwargs if available
---@type cmp.ComparatorFunction
my_compare.python_kwargs = function(entry1, entry2)
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

-- Rank down dunder methods
---@type cmp.ComparatorFunction
my_compare.python_dunder = function(entry1, entry2)
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

local kind_priority = {
  types.lsp.CompletionItemKind.EnumMember,
  types.lsp.CompletionItemKind.Method,
  types.lsp.CompletionItemKind.Function,
  types.lsp.CompletionItemKind.Constructor,
  types.lsp.CompletionItemKind.Field,
  types.lsp.CompletionItemKind.Variable,
  types.lsp.CompletionItemKind.Class,
  types.lsp.CompletionItemKind.Interface,
  types.lsp.CompletionItemKind.Module,
  types.lsp.CompletionItemKind.Property,
  types.lsp.CompletionItemKind.Unit,
  types.lsp.CompletionItemKind.Value,
  types.lsp.CompletionItemKind.Enum,
  types.lsp.CompletionItemKind.Keyword,
  types.lsp.CompletionItemKind.Snippet,
  types.lsp.CompletionItemKind.Color,
  types.lsp.CompletionItemKind.File,
  types.lsp.CompletionItemKind.Reference,
  types.lsp.CompletionItemKind.Folder,
  types.lsp.CompletionItemKind.Constant,
  types.lsp.CompletionItemKind.Struct,
  types.lsp.CompletionItemKind.Event,
  types.lsp.CompletionItemKind.Operator,
  types.lsp.CompletionItemKind.TypeParameter,
  types.lsp.CompletionItemKind.Text,
}

local inverse_kind_priority = {}
for index, value in ipairs(kind_priority) do
  inverse_kind_priority[value] = index
end

-- A custom comparator for kind
---@type cmp.ComparatorFunction
my_compare.kind = function(entry1, entry2)
  local kind1 = inverse_kind_priority[entry1:get_kind()]
  local kind2 = inverse_kind_priority[entry2:get_kind()]

  if kind1 == kind2 then
    return nil
  end

  if (kind1 - kind2) < 0 then
    return true
  else
    return false
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
        my_compare.python_kwargs,
        my_compare.python_dunder,
        compare.recently_used,
        compare.locality,
        my_compare.kind,
        compare.sort_text,
        compare.length,
        compare.order,
      }
      opts.mapping = vim.tbl_deep_extend("force", opts.mapping, {
        ["<PageDown>"] = cmp.mapping.select_next_item({ count = 8 }),
        ["<PageUp>"] = cmp.mapping.select_prev_item({ count = 8 }),
        -- ["<CR>"] = LazyVim.cmp.confirm({ select = false }),
      })
      opts.window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      }
      opts.preselect = cmp.PreselectMode.None
      -- opts.completion = {
      --   completeopt = "noselect",
      -- }
    end,
  },
}
