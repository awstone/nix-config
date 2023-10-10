# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "alex";
    homeDirectory = "/home/alex";
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  home.packages = with pkgs; [
    texlive.combined.scheme-full
    docker
  ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;
  programs.ssh = {
    enable = true;
    controlMaster = "auto";
    controlPath = "~/.ssh/master-%r@%h:%p";
    matchBlocks = {
      cappuccino = {
        hostname = "128.205.211.11";
        user = "alex";
        forwardX11Trusted = true;
        serverAliveInterval = 60;
        proxyCommand = "ssh -W %h:%p timberlake";
      };
      timberlake = {
        hostname = "timberlake.cse.buffalo.edu";
        user = "awstone";
        forwardX11Trusted = true;
        serverAliveInterval = 60;
      };
      carina = {
        hostname = "carina.cse.buffalo.edu";
        user = "awstone";
        proxyCommand = "ssh -W %h:%p timberlake";
        forwardX11Trusted = true;
        serverAliveInterval = 60;
      };
      rickybobby = {
        hostname = "172.101.69.138";
        user = "alex";
        forwardX11Trusted = true;
        serverAliveInterval = 60;
      };
      localrick = {
        hostname = "192.168.1.67";
        user = "alex";
        port = 22;
        forwardX11Trusted = true;
        serverAliveInterval = 60;
      };
      draco = {
        hostname = "draco.cse.buffalo.edu";
        user = "awstone";
        proxyCommand = "ssh -W %h:%p timberlake";
        forwardX11Trusted = true;
        serverAliveInterval = 60;
      };
      regulus = {
        hostname = "regulus.cedar.buffalo.edu";
        user = "awstone";
        proxyCommand = "ssh -W %h:%p timberlake";
        forwardX11Trusted = true;
        serverAliveInterval = 60;
      };
      hal = {
        hostname = "hal.cedar.buffalo.edu";
        user = "awstone";
        proxyCommand = "ssh -W %h:%p timberlake";
        forwardX11Trusted = true;
        serverAliveInterval = 60;
      };
      arcturus = {
        hostname = "arcturus.cedar.buffalo.edu";
        user = "awstone";
        proxyCommand = "ssh -W %h:%p timberlake";
        forwardX11Trusted = true;
        serverAliveInterval = 60;
      };
      vega = {
        hostname = "vega.cedar.buffalo.edu";
        user = "awstone";
        proxyCommand = "ssh -W %h:%p timberlake";
        forwardX11Trusted = true;
        serverAliveInterval = 60;
      };
      minijeff = {
        hostname = "minijeff.acvlabs.acvauctions.com";
        user = "alex";
        forwardX11Trusted = true;
        serverAliveInterval = 60;
      };
      alice = {
        hostname = "alice.cedar.buffalo.edu";
        user = "awstone";
        proxyCommand = "ssh -W %h:%p timberlake";
        forwardX11Trusted = true;
        serverAliveInterval = 60;
      };
    };
  };
  
  programs.emacs = {
    enable = true;
    package = pkgs.emacs29;
    extraPackages = epkgs: [
      epkgs.nix-mode
      epkgs.magit
      epkgs.company
      epkgs.doom-themes
      epkgs.lsp-mode
      epkgs.org
      epkgs.org-bullets
      epkgs.auctex
      epkgs.pdf-tools
      epkgs.org-roam
      # epkgs.preview-latex
    ];
    extraConfig = ''
      (require 'package)
      (require 'pdf-tools)
      (require 'company)
      (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
      ;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
      ;; and `package-pinned-packages`. Most users will not need or want to do this.
      ;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
      (package-initialize)
      (custom-set-variables
       ;; custom-set-variables was added by Custom.
       ;; If you edit it by hand, you could mess it up, so be careful.
       ;; Your init file should contain only one such instance.
       ;; If there is more than one, they won't work right.
       '(org-agenda-files '("~/Documents/1.org"))
       '(package-selected-packages
         '(org-bullets yafolding json-mode magit company lsp-mode taxy-magit-section ement doom-themes)))
      (custom-set-faces
       ;; custom-set-faces was added by Custom.
       ;; If you edit it by hand, you could mess it up, so be careful.
       ;; Your init file should contain only one such instance.
       ;; If there is more than one, they won't work right.
      )

      (use-package doom-themes
        :ensure t
        :config
        ;; Global settings (defaults)
        (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
              doom-themes-enable-italic t) ; if nil, italics is universally disabled
        (load-theme 'doom-xcode t)

        ;; Enable flashing mode-line on errors
        (doom-themes-visual-bell-config)
        ;; Enable custom neotree theme (all-the-icons must be installed!)
        (doom-themes-neotree-config)
        ;; or for treemacs users
        (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
        (doom-themes-treemacs-config)
        ;; Corrects (and improves) org-mode's native fontification.
        (doom-themes-org-config))

      (setenv "PETSC_DIR" "~/Repositories/petsc")
      (setenv "PETSC_ARCH" "arch-darwin-c-debug")
      (global-company-mode t)
      (setq global-display-line-numbers-mode t)
      (setq company-idle-delay 0.5) ; set delay to 0.5 seconds
      (require 'lsp-mode)
      (add-hook 'python-mode-hook #'lsp)
      (with-eval-after-load 'lsp-mode
        (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\\\.pyenv\\\\.*")
        (lsp-register-client
         (make-lsp-client :new-connection (lsp-tramp-connection "/home/awstone/phonetic-flashcards/venv/bin/pyls")
                          :major-modes '(python-mode)
                          :remote? t
                          :server-id 'pyls-remote)))
      ;; -*- mode: elisp -*-

      ;; Disable the splash screen (to enable it agin, replace the t with 0)
      (setq inhibit-splash-screen t)

      ;; Enable transient mark mode
      (transient-mark-mode 1)

      ;;;;Org mode configuration
      ;; Enable Org mode
      (require 'org)
      ;; Make Org mode work with files ending in .org
      ;; (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
      ;; The above is the default in recent emacsen
      (setq org-todo-keywords
        '((sequence "TODO" "IN-PROGRESS" "WAITING" "DONE")))
      (global-set-key "\C-ca" 'org-agenda)
      (setq org-tag-alist '(("@work" . ?w) ("@home" . ?h) ("laptop" . ?l)))
      (org-babel-do-load-languages
       'org-babel-load-languages
       '((python . t)))
      (setq org-babel-python-command "python3")
      (setq org-confirm-babel-evaluate nil)
      (use-package org-bullets
        :config
        (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))
      (setq org-log-done t)
      (load "auctex.el" nil t t)
      (require 'org-roam)
      ;; (load "preview-latex.el" nil t t) 
    '';
  };
  
  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
