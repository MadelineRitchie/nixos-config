{ config, pkgs, lib, ... }:

let
  nixvim = import (builtins.fetchGit {
    url = "https://github.com/nix-community/nixvim";
  });
in
  {
    imports = [
      nixvim.homeManagerModules.nixvim
    ];

    home.sessionVariables = {
      EDITOR = "nvim";
    };

    home.packages = with pkgs; [
      bat
      grc
      jujutsu
      htop
    ];
    programs.git = {
      enable = true;
      userName = "Madeline Ritchie";
      userEmail = "2144273+MadelineRitchie@users.noreply.github.com";
      extraConfig = {
        init.defaultBranch = "main";
      };
    };
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    programs.fish = {
      enable = true;
      plugins = [
        { name = "grc"; src = pkgs.fishPlugins.grc.src; }
        { name = "forgit"; src = pkgs.fishPlugins.forgit.src; }
      ];
      interactiveShellInit = ''
        fish_vi_key_bindings
      '';
      functions = {
        edit_home = ''
          $EDITOR -o ~/.config/home-manager/home.nix ~/.config/home-manager/shared.nix
        '';
        edit_nixos = ''
          $EDITOR -o /etc/nixos/configuration.nix /etc/nixos/hardware-configuration.nix
        '';
      };
    };
    programs.fzf.enable = true;

    programs.kitty = {
      enable = true;
      font = {
        name = "JetBrainsMono Nerd Font Mono";
        size = 13;
      };
    };

    programs.nixvim = {
      enable = true;
      extraPlugins = with pkgs.vimPlugins; [
        gruvbox
        vim-nix
        vim-surround
        vim-easymotion
        vim-commentary
        vim-obsession
        lens-vim
        vim-highlightedyank
        close-buffers-vim

        nerdtree
        vim-devicons
        nerdtree-git-plugin
      ];
      colorscheme = "gruvbox"; # consider slate
      globals = {
        mapleader = ",";
      };
      opts = {
        number = true;
        relativenumber = true;
        title = true;
        list = true;
        shiftwidth = 2;
      };
      extraConfigVim = ''
        set mouse=
        autocmd FileType nix setlocal commentstring=#\ %s
        let g:lens#disabled_filetypes = ['nerdtree','fzf']
        let g:indent_guides_enable_on_vim_startup = 1

        let g:lens#height_resize_min = 10
        let g:lens#width_resize_min = 40
      '';
    };
    programs.home-manager.enable = true;
  }
