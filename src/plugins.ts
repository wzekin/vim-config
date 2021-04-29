interface PluginConfig {
  [1]: string;
  disable?: boolean;
  opt?: boolean;
  config?: () => void;
  run?: (() => void) | string;
  requires?: string[];
}

/** @luaTable */
type PluginConfigs = PluginConfig[];

const plugins: PluginConfigs = [
  {
    [1]: "wbthomason/packer.nvim",
    opt: true,
  },
  {
    [1]: "scrooloose/nerdcommenter",
  },
  {
    [1]: "nvim-treesitter/nvim-treesitter",
    run: ":TSUpdate",
    requires: ["nvim-treesitter/nvim-treesitter-textobjects"],
    config: () => {
      const config: Bufferline = require("nvim-treesitter.configs");
      config.setup({
        ensure_installed: "all", // one of "all", "maintained" (parsers with maintainers), or a list of languages
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
    [1]: "tpope/vim-surround",
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
