interface PluginConfig {
  [1]: string;
  disable?: boolean;
  opt?: boolean;
  setup?: () => void;
  config?: () => void;
  run?: (() => void) | string;
  requires?: string[];
}

/** @luaTable */
type PluginConfigs = PluginConfig[];

const plugins: PluginConfigs = [
  {
    [1]: "windwp/nvim-autopairs",
    config: () => {
      const npairs = require("nvim-autopairs");
      npairs.setup({
        check_ts: true,
      });
    },
  },
  {
    [1]: "datwaft/bubbly.nvim",
    config: () => {
      vim.g.bubbly_palette = {
        background: "#34343c",
        foreground: "#c5cdd9",
        black: "#3e4249",
        red: "#ec7279",
        green: "#a0c980",
        yellow: "#deb974",
        blue: "#6cb6eb",
        purple: "#d38aea",
        cyan: "#5dbbc1",
        white: "#c5cdd9",
        lightgrey: "#57595e",
        darkgrey: "#404247",
      };
      vim.g.bubbly_statusline = [
        "mode",
        "truncate",
        "path",
        "branch",
        "signify",
        "divisor",
        "builtinlsp.diagnostic_count",
        "builtinlsp.current_function",
        "filetype",
        "progress",
      ];
    },
  },
  {
    [1]: "akinsho/nvim-bufferline.lua",
    requires: ["kyazdani42/nvim-web-devicons"],
    config: () => {
      const bufferline: Bufferline = require("bufferline");
      bufferline.setup({
        options: {
          view: "multiwindow",
          numbers: "ordinal",
          mappings: true,
          buffer_close_icon: "",
          modified_icon: "●",
          close_icon: "",
          left_trunc_marker: "",
          right_trunc_marker: "",
          max_name_length: 18,
          max_prefix_length: 15, // prefix used when a buffer is deduplicated
          tab_size: 18,
          show_buffer_close_icons: true,
          persist_buffer_sort: true, // whether or not custom sorted buffers should persist
          enforce_regular_tabs: false,
          always_show_bufferline: true,
          sort_by: "extension",
        },
      });
    },
  },
  {
    [1]: "hrsh7th/nvim-compe",
    requires: ["neovim/nvim-lspconfig"],
    config: () => {
      /* function on_attach(client: any, bufnr: number) {
        function buf_set_keymap(
          type: string,
          key: string,
          value: string,
          opt: vim.api.KeymapOptions
        ) {
          vim.api.nvim_buf_set_keymap(bufnr, type, key, value, opt);
        }
        function buf_set_option(key: string, value: string) {
          vim.api.nvim_buf_set_option(bufnr, key, value);
        }

        buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc");

        // Mappings.
        const opts = { noremap: true, silent: true };
        buf_set_keymap(
          "n",
          "gD",
          "<Cmd>lua vim.lsp.buf.declaration()<CR>",
          opts
        );
        buf_set_keymap(
          "n",
          "gd",
          "<Cmd>lua vim.lsp.buf.definition()<CR>",
          opts
        );
        buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts);
        buf_set_keymap(
          "n",
          "gi",
          "<cmd>lua vim.lsp.buf.implementation()<CR>",
          opts
        );
        buf_set_keymap(
          "n",
          "<C-k>",
          "<cmd>lua vim.lsp.buf.signature_help()<CR>",
          opts
        );
        buf_set_keymap(
          "n",
          "<leader>wa",
          "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>",
          opts
        );
        buf_set_keymap(
          "n",
          "<leader>wr",
          "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",
          opts
        );
        buf_set_keymap(
          "n",
          "<space>wl",
          "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
          opts
        );
        buf_set_keymap(
          "n",
          "<leader>D",
          "<cmd>lua vim.lsp.buf.type_definition()<CR>",
          opts
        );
        buf_set_keymap(
          "n",
          "<leader>rn",
          "<cmd>lua vim.lsp.buf.rename()<CR>",
          opts
        );
        buf_set_keymap(
          "n",
          "gr",
          "<cmd>lua vim.lsp.buf.references()<CR>",
          opts
        );
        buf_set_keymap(
          "n",
          "<leader>e",
          "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>",
          opts
        );
        buf_set_keymap(
          "n",
          "[d",
          "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>",
          opts
        );
        buf_set_keymap(
          "n",
          "]d",
          "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
          opts
        );
        buf_set_keymap(
          "n",
          "<leader>q",
          "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>",
          opts
        );

        // Set autocommands conditional on server_capabilities
        if (client.resolved_capabilities.document_highlight) {
          vim.api.nvim_exec(
            `
  hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
  hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
  hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
  augroup lsp_document_highlight
  autocmd!
  autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
  autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
  augroup END
  `,
            false
          );
        }
      } */
      const servers = [
        {
          [1]: "sumneko_lua",
          setup: {
            cmd: ["lua-language-server"],
            settings: {
              Lua: {
                runtime: {
                  // Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                  version: "LuaJIT",
                  // Setup your lua path
                  //@ts-ignore
                  path: vim.split(package.path, ";"),
                },
                diagnostics: {
                  // Get the language server to recognize the `vim` global
                  globals: ["vim"],
                },
                workspace: {
                  // Make the server aware of Neovim runtime files
                  library: {
                    [vim.fn.expand("$VIMRUNTIME/lua")]: true,
                    [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")]: true,
                  },
                },
              },
            },
            // on_attach: on_attach,
          },
        },
        "rust_analyzer",
        "clangd",
        "gopls",
        "jsonls",
        "vimls",
        "pyright",
        "tsserver",
      ];

      const nvim_lsp: LspConfig = require("lspconfig");
      for (const lsp of servers) {
        if (typeof lsp == "string") {
          nvim_lsp[lsp].setup({});
        } else {
          nvim_lsp[lsp[1]].setup(lsp.setup);
        }
      }

      const compe: Bufferline = require("compe");
      compe.setup({
        enabled: true,
        autocomplete: true,
        debug: true,
        min_length: 1,
        preselect: "enable",
        throttle_time: 80,
        source_timeout: 200,
        incomplete_delay: 400,
        max_abbr_width: 100,
        max_kind_width: 100,
        max_menu_width: 100,
        documentation: true,

        source: {
          path: true,
          buffer: true,
          calc: true,
          nvim_lsp: true,
          nvim_lua: true,
        },
      });
    },
  },
  {
    [1]: "npxbr/glow.nvim",
    run: ":GlowInstall",
  },
  {
    [1]: "sbdchd/neoformat",
    config: () => {
      vim.g.neoformat_enabled_python = ["isort", "black"];
      vim.g.neoformat_enabled_typescript = ["prettier"];
      vim.g.neoformat_enabled_typescriptreact = ["prettier"];
      vim.g.neoformat_run_all_formatters = 1;
    },
  },
  {
    [1]: "b3nj5m1n/kommentary",
    setup: () => {
      vim.g.kommentary_create_default_mappings = true;
    },
    config: () => {},
  },
  {
    [1]: "kyazdani42/nvim-tree.lua",
    requires: ["kyazdani42/nvim-web-devicons"],
    config: () => {
      vim.g.nvim_tree_side = "right";
      vim.g.nvim_tree_width = 30; //30 by default
      vim.g.nvim_tree_ignore = [".git", "node_modules", ".cache"]; //empty by default
      vim.g.nvim_tree_auto_open = 0; //0 by default, opens the tree when typing `vim $DIR` or `vim`
      vim.g.nvim_tree_auto_close = 1; //0 by default, closes the tree when it's the last window
      vim.g.nvim_tree_quit_on_open = 1; //0 by default, closes the tree when you open a file
      vim.g.nvim_tree_follow = 1; //0 by default, this option allows the cursor to be updated when entering a buffer
      vim.g.nvim_tree_indent_markers = 1; //0 by default, this option shows indent markers when folders are open
      vim.g.nvim_tree_hide_dotfiles = 1; //0 by default, this option hides files and folders starting with a dot `.`
      vim.g.nvim_tree_git_hl = 1; //0 by default, will enable file highlight for git attributes (can be used without the icons).
      vim.g.nvim_tree_root_folder_modifier = ":~"; //This is the default. See :help filename-modifiers for more options
      vim.g.nvim_tree_tab_open = 1; //0 by default, will open the tree when entering a new tab and the tree was previously open
      vim.g.nvim_tree_width_allow_resize = 1; //0 by default, will not resize the tree when opening a file
      vim.g.nvim_tree_show_icons = {
        git: 1,
        folders: 1,
        files: 1,
      };
    },
  },
  {
    [1]: "wbthomason/packer.nvim",
    opt: true,
  },
  {
    [1]: "p00f/nvim-ts-rainbow",
    config: () => {
      vim.g.rainbow_active = 1;
    },
  },
  {
    [1]: "nvim-treesitter/nvim-treesitter",
    run: ":TSUpdate",
    requires: ["nvim-treesitter/nvim-treesitter-textobjects"],
    config: () => {
      const config: Bufferline = require("nvim-treesitter.configs");
      config.setup({
        ensure_installed: "all", // one of "all", "maintained" (parsers with maintainers), or a list of languages
        highlight: {
          enable: true, // false will disable the whole extension
        },
        indent: {
          enable: true,
        },
        autopairs: {
          enable: true,
        },
        rainbow: {
          enable: true,
          extended_mode: true,
          max_file_lines: 1000,
        },
        textobjects: {
          select: {
            enable: true,
            keymaps: {
              ["af"]: "@function.outer",
              ["if"]: "@function.inner",
              ["ac"]: "@class.outer",
              ["ic"]: "@class.inner",
            },
          },
        },
      });
    },
  },
  {
    [1]: "easymotion/vim-easymotion",
    config: () => {
      vim.g.EasyMotion_do_mapping = 0;
      vim.g.EasyMotion_smartcase = 1;
    },
  },
  {
    [1]: "navarasu/onedark.nvim",
  },
  {
    [1]: "nvim-telescope/telescope.nvim",
    requires: ["nvim-lua/popup.nvim", "nvim-lua/plenary.nvim"],
  },
  {
    [1]: "blackCauldron7/surround.nvim",

    config: () => {
      require("surround").setup();
    },
  },
];
export function init_plugins(): void {
  const install_path =
    vim.fn.stdpath("data") + "/site/pack/packer/opt/packer.nvim";

  if (vim.fn.empty(vim.fn.glob(install_path)) > 0) {
    vim.cmd(
      "!git clone https://github.com/wbthomason/packer.nvim " + install_path
    );
  }

  vim.cmd("packadd packer.nvim");
  const packer: Packer = require("packer");

  packer.init({ ensure_dependencies: true });
  packer.use(plugins);
}
