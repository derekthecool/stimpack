require "nvim-treesitter.configs".setup {

  ignore_install = {  -- Don't download these
   "beancount",       -- (maintained by @polarmutex)
   "clojure",         -- (maintained by @sogaiu)
   "cooklang",        -- (maintained by @addcninblue)
   "css",             -- (maintained by @TravonteD)
   "cuda",            -- (maintained by @theHamsta)
   "d",               -- (experimental, maintained by @nawordar)
   "dart",            -- (maintained by @Akin909)
   "devicetree",      -- (maintained by @jedrzejboczar)
   "dockerfile",      -- (maintained by @camdencheek)
   "dot",             -- (maintained by @rydesun)
   "eex",             -- (maintained by @connorlay)
   "elixir",          -- (maintained by @jonatanklosko, @connorlay)
   "elm",             --
   "erlang",          -- (maintained by @ostera)
   "fennel",          -- (maintained by @TravonteD)
   "fish",            -- (maintained by @ram02z)
   "foam",            -- (experimental, maintained by @FoamScience)
   "fortran",         --
   "fusion",          -- (maintained by @jirgn)
   "Godot",           -- (gdscript) (maintained by @Shatur95)
   "gleam",           -- (maintained by @connorlay)
   "Glimmer",         -- and Ember (maintained by @alexlafroscia)
   "glsl",            -- (maintained by @theHamsta)
   "go",              -- (maintained by @theHamsta, @WinWisely268)
   "Godot",           -- Resources (gdresource) (maintained by @pierpo)
   "gomod",           -- (maintained by @camdencheek)
   "gowork",          -- (maintained by @omertuc)
   "graphql",         -- (maintained by @bkegley)
   "hack",            --
   "haskell",         --
   "hcl",             -- (maintained by @MichaHoffmann)
   "heex",            -- (maintained by @connorlay)
   "hjson",           -- (maintained by @winston0410)
   "hocon",           -- (maintained by @antosha417)
   "html",            -- (maintained by @TravonteD)
   "http",            -- (maintained by @NTBBloodbath)
   "java",            -- (maintained by @p00f)
   "javascript",      -- (maintained by @steelsojka)
   "jsdoc",           -- (maintained by @steelsojka)
   "json5",           -- (maintained by @Joakker)
   "julia",           -- (maintained by @mroavi, @theHamsta)
   "kotlin",          -- (maintained by @SalBakraa)
   "lalrpop",         -- (maintained by @traxys)
   "latex",           -- (maintained by @theHamsta, @clason)
   "ledger",          -- (maintained by @cbarrete)
   "ninja",           -- (maintained by @alemuller)
   "nix",             -- (maintained by @leo60228)
   "norg",            -- (maintained by @JoeyGrajciar, @vhyrro, @mrossinek)
   "ocaml",           -- (maintained by @undu)
   "ocaml_interface", -- (maintained by @undu)
   "ocamllex",        -- (maintained by @undu)
   "pascal",          -- (maintained by @isopod)
   "perl",            -- (maintained by @ganezdragon)
   "php",             -- (maintained by @tk-shirasaka)
   "phpdoc",          -- (experimental, maintained by @mikehaertl)
   "pioasm",          -- (maintained by @leo60228)
   "prisma",          -- (maintained by @elianiva)
   "pug",             -- (maintained by @zealot128)
   "ql",              -- (maintained by @pwntester)
   "r",               -- (maintained by @jimhester)
   "rasi",            -- (maintained by @Fymyte)
   "rst",             -- (maintained by @stsewd)
   "ruby",            -- (maintained by @TravonteD)
   "rust",            -- (maintained by @vigoux)
   "scala",           -- (maintained by @stevanmilic)
   "scss",            -- (maintained by @elianiva)
   "slint",           -- (experimental, maintained by @jrmoulton)
   "solidity",        -- (maintained by @YongJieYongJie)
   "sparql",          -- (maintained by @bonabeavis)
   "supercollider",   -- (maintained by @madskjeldgaard)
   "surface",         -- (maintained by @connorlay)
   "svelte",          -- (maintained by @elianiva)
   "swift",           --
   "teal",            -- (maintained by @euclidianAce)
   "tlaplus",         -- (maintained by @ahelwer, @susliko)
   "todotxt",         -- (experimental, maintained by @arnarg)
   "toml",            -- (maintained by @tk-shirasaka)
   "tsx",             -- (maintained by @steelsojka)
   "turtle",          -- (maintained by @bonabeavis)
   "typescript",      -- (maintained by @steelsojka)
   "vala",            -- (maintained by @matbme)
   "verilog",         -- (experimental, maintained by @zegervdv)
   "vue",             -- (maintained by @WhyNotHugo)
   "yang",            -- (maintained by @Hubro)
   "zig",             -- (maintained by @maxxnino)
 },

  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },

  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
    query_linter = {
      enable = true,
      use_virtual_text = true,
      lint_events = {"BufWrite", "CursorHold"},
    },
  },

  textobjects = {
    select = {
      enable = true,
      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>hn"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>hN"] = "@parameter.inner",
      },
    },
  },
}
