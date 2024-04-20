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
    homeDirectory = "/${if pkgs.stdenv.isDarwin then "Users" else "home"}/alex";
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  home.packages = with pkgs; [
    texlive.combined.scheme-full
    docker
    python3
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
        proxyCommand = "ssh -W -Y %h:%p timberlake";
        forwardX11Trusted = true;
        serverAliveInterval = 60;
      };
      rickybobby = {
        hostname = "68.133.25.172";
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
      mobilejeff = {
        hostname = "minijeff.acvlabs.acvauctions.com";
        user = "alex";
        proxyCommand = "ssh -W %h:%p rickybobby";
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
      # epkgs.reftex
      epkgs.pdf-tools
      epkgs.org-roam
      epkgs.ein
      # epkgs.preview-latex
      epkgs.leetcode
      epkgs.projectile
      epkgs.flycheck
      epkgs.doom-modeline
      epkgs.treemacs
      epkgs.rainbow-delimiters
      # epkgs.all-the-icons
      epkgs.nerd-icons
      epkgs.zenburn-theme
      epkgs.pyvenv
    ];

    extraConfig = ''
      (require 'package)
      (add-to-list 'package-archives
                   '("melpa" . "https://melpa.org/packages/") t)
      (package-refresh-contents)

      (require 'pdf-tools)

      (require 'leetcode)
      (setq leetcode-prefer-language "cpp")

      (require 'company)



      ;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
      ;; and `package-pinned-packages`. Most users will not need or want to do this.
      ;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
      ;; trying to suppress emacs macos warning (package-initialize)
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

      ;; (use-package doom-themes
      ;;  :ensure t
      ;;  :config
      ;;  ;; Global settings (defaults)
      ;;  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
      ;;        doom-themes-enable-italic t) ; if nil, italics is universally disabled
      ;;  (load-theme 'doom-xcode t)

        ;; Enable flashing mode-line on errors
      ;; (doom-themes-visual-bell-config)
      ;; ;; Enable custom neotree theme (all-the-icons must be installed!)
      ;;  (doom-themes-neotree-config)
        ;; or for treemacs users
      ;;  (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
      ;;  (doom-themes-treemacs-config)
        ;; Corrects (and improves) org-mode's native fontification.
      ;;  (doom-themes-org-config))

      (load-theme 'zenburn t)

      (setenv "PETSC_DIR" "~/Repositories/petsc")
      (setenv "PETSC_ARCH" "arch-darwin-c-debug")
      (global-company-mode t)
      (setq company-idle-delay 0.5) ; set delay to 0.5 seconds
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
      (global-auto-revert-mode 1)
      (setq reftex-plug-into-AUCTeX t)
      (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
      (defun open-link-in-eww (link)
        "Open an Org mode link in eww."
        (if (string-match "^http" link)
            (eww-browse-url link)
          (browse-url-default-browser link)))

      (setq org-link-frame-setup
            '((file . find-file)
              (wl . wl-other-frame)
              (elisp . find-function)
              (elisp . find-library)
              (elisp . find-variable)
              (gnus . org-gnus-no-new-news)
              (docview . doc-view)
              (bibtex . bibtex-find-entry)
              (bbdb . bbdb-redisplay-records)
              (w3m . w3m)
              (http . open-link-in-eww)
              (https . open-link-in-eww)))

      ;; (load "preview-latex.el" nil t t)
      (defun smarter-move-beginning-of-line (arg)
      "Move point back to indentation of beginning of line.

      Move point to the first non-whitespace character on this line.
      If point is already there, move to the beginning of the line.
      Effectively toggle between the first non-whitespace character and
      the beginning of the line.

      If ARG is not nil or 1, move forward ARG - 1 lines first.  If
      point reaches the beginning or end of the buffer, stop there."
        (interactive "^p")
        (setq arg (or arg 1))

        ;; Move lines first
        (when (/= arg 1)
          (let ((line-move-visual nil))
            (forward-line (1- arg))))

        (let ((orig-point (point)))
          (back-to-indentation)
          (when (= orig-point (point))
            (move-beginning-of-line 1))))

      ;; Bind the function to C-a
      (global-set-key [remap move-beginning-of-line] #'smarter-move-beginning-of-line)
      (with-eval-after-load 'company
      (define-key company-active-map [ret] 'company-complete-selection)
      (define-key company-active-map (kbd "RET") 'company-complete-selection)
      (define-key company-active-map (kbd "TAB") 'company-complete-selection)
      (define-key company-active-map [tab] 'company-complete-selection))
      (require 'lsp-mode)
      (add-hook 'python-mode-hook #'lsp)
      (with-eval-after-load 'lsp-mode
        (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\\\.pyenv\\\\.*")
        (lsp-register-client
         (make-lsp-client :new-connection (lsp-tramp-connection "/home/awstone/phonetic-flashcards/venv/bin/pyls")
                          :major-modes '(python-mode)
                          :remote? t
                          :server-id 'pyls-remote)))
      (add-hook 'c++-mode-hook #'lsp)
      (add-hook 'c-mode-hook #'lsp)

      ;; Optional: Use lsp-ui for additional UI enhancements (e.g., inline documentation, diagnostics)
      ;; (use-package lsp-ui
      ;;  :commands lsp-ui-mode)
      ;; (defadvice yank (after indent-region activate)
      ;; (if (member major-mode '(emacs-lisp-mode lisp-mode clojure-mode scheme-mode haskell-mode ruby-mode rspec-mode python-mode c-mode c++-mode objc-mode latex-mode js-mode plain-tex-mode))
      ;;    (let ((mark-even-if-inactive transient-mark-mode))
      ;;      (indent-region (region-beginning) (region-end) nil))))

    (defadvice yank-pop (after indent-region activate)
      (if (member major-mode '(emacs-lisp-mode lisp-mode clojure-mode scheme-mode haskell-mode ruby-mode rspec-mode python-mode c-mode c++-mode objc-mode latex-mode js-mode plain-tex-mode))
          (let ((mark-even-if-inactive transient-mark-mode))
            (indent-region (region-beginning) (region-end) nil))))

    ;; Ensure global-display-line-numbers-mode is enabled last
    (add-hook 'after-init-hook 'global-display-line-numbers-mode)

    (require 'projectile)
    (projectile-mode +1)
    (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

    (require 'flycheck)
    (global-flycheck-mode)

    (require 'doom-modeline)
    (doom-modeline-mode 1)

    (require 'treemacs)
    (global-set-key (kbd "C-x t t") 'treemacs)

    (unless (package-installed-p 'rainbow-delimiters)
      (package-install 'rainbow-delimiters))

    (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

    (add-hook 'python-mode-hook 'eglot-ensure)
    (add-hook 'js-mode-hook 'eglot-ensure)

    (add-hook 'emacs-startup-hook 'treemacs)
    (add-hook 'emacs-startup-hook 'treemacs-select-window)

    (setq tramp-connection-timeout 10)

    (require 'projectile)
    (projectile-mode +1)

    (defun my/projectile-lsp-setup ()
      (let ((proj-root (projectile-project-root)))
        (setq-local lsp-pylsp-server-command
                    (list "ssh" "draco"
                          (concat proj-root "venv/bin/pylsp")))))

    (add-hook 'python-mode-hook #'my/projectile-lsp-setup)

    (require 'pyvenv)

    (with-eval-after-load 'nerd-icons
      (nerd-icons-install-fonts t))

    (set-frame-parameter nil 'fullscreen 'fullboth)
    (menu-bar-mode -1)
    (scroll-bar-mode -1)
    (tool-bar-mode -1)


    '';
  };
  
  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
