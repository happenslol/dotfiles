local util = require "util"
local nest = require "nest"

util.set_global { mapleader = "," }

nest.applyKeymaps {
  -- Quickfix window mappings
  { "<c-f>", {
    { "k", [[:copen<CR>]] },
    { "j", [[:cclose<CR>]] },
    { "l", [[:cnext<CR>]] },
    { "h", [[:cprev<CR>]] },
  }},

  -- Location list mappings
  { "<c-d>", {
    { "k", [[:lopen<CR>]] },
    { "j", [[:lclose<CR>]] },
    { "l", [[:lnext<CR>]] },
    { "h", [[:lprev<CR>]] },
  }},

  { "<C-n>", [[:NvimTreeToggle<CR>]] },

  { "<C-p>", [[:Telescope find_files<CR>]] },

  { "<leader>", {
    { "q", [[:Telescope live_grep<CR>]] },
    { "e", [[:Telescope buffers<CR>]] },

    { "w", [[:ArgWrap<CR>]] },
    { "f", [[:Neoformat<CR>]] },

    { "c", [[:LspTroubleToggle<CR>]] },
  }},
}
