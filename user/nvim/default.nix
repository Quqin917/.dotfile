{ config, lib, pkgs, ... }:
let
  vim-kitty = pkgs.vimUtils.buildVimPlugin {
    pname = "vim-kitty";
    version = "30-07-2025";
    src = pkgs.fetchFromGitHub {
      owner = "fladson";
      repo = "vim-kitty";
      rev = "5c3efc79af70dc2c22cad03e6a7374a5f81205d9";
      sha256 = "sha256-cJIfXv3ImkDlgud/y3Zz4NLWLi65zxcNE5JVGTZlqKo=";
    };
  };
in
{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs.vimPlugins; [
      lazy-nvim
      
      which-key-nvim
      flash-nvim
      fzf-lua
      vim-tmux-navigator
      nvim-lint
      marks-nvim
      no-neck-pain-nvim
      oil-nvim
      snacks-nvim
      nvim-treesitter
      vim-kitty
      comment-nvim
      auto-session
      mini-bufremove

      nvim-web-devicons
      catppuccin-nvim

      # UI
      alpha-nvim
      lualine-nvim
      bufferline-nvim
      trouble-nvim

      # LSP
      nvim-lspconfig
      cmp-nvim-lsp
      nvim-lsp-file-operations
      neodev-nvim
      conform-nvim

      # AutoComplete
      nvim-cmp
      cmp-buffer
      cmp-path
      cmp_luasnip
      lspkind-nvim
      luasnip
      friendly-snippets
      mini-pairs
    ];

    extraPackages = with pkgs; [
      lua-language-server
      stylua 
      luajitPackages.luacheck
    ];

    extraLuaConfig = ''
vim.g.mapleader = " "

require("quqin.core") -- core/options, mappings, autocmds

require('lazy').setup({
  spec = {
    -- Parent directory
    { import = "quqin.plugins" },
    { import = "quqin.themes" },
  
    -- Child directory
    { import = "quqin.plugins.lsp" },
    { import = "quqin.plugins.ui" },
    { import = "quqin.plugins.completions" },
  },

  defaults = {
    lazy = false,
    version = false,
  },
  
  checker = {
    enabled = true,
    notify = false,
  },
  
  change_detection = {
    notify = true,
  },
  
  performance = {
    reset_packpath = false,
    rtp = { reset = false, },
  },
  
  dev = {
    path = "${pkgs.vimUtils.packDir config.programs.neovim.finalPackage.passthru.packpathDirs}/pack/myNeovimPackages/start",
    patterns = {""},
  },
  
  install = {
    missing = false,
  },
})

vim.cmd.colorscheme "catppuccin"
    '';
  };

  xdg.configFile."nvim/lua" = {
    recursive = true;
    source = ./config/lua;
  };

  xdg.configFile."nvim/stylua.toml" = {
    source = ./config/stylua.toml;
  };
}  
