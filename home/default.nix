{ flake, pkgs, ... }:
{
  imports = [
    ./nix-index.nix
    # ./neovim.nix # Uncomment this if you do not want to setup Neovim.
  ];

  # Recommended Nix settings
  nix = {
    registry.nixpkgs.flake = flake.inputs.nixpkgs; # https://yusef.napora.org/blog/pinning-nixpkgs-flake/

    # FIXME: Waiting for this to be merged:
    # https://github.com/nix-community/home-manager/pull/4031
    # nixPath = [ "nixpkgs=${flake.inputs.nixpkgs}" ]; # Enables use of `nix-shell -p ...` etc

    # Garbage collect the Nix store
    gc = {
      automatic = true;
      # Change how often the garbage collector runs (default: weekly)
      # frequency = "monthly";
    };
  };

  # Nix packages to install to $HOME
  #
  # Search for packages here: https://search.nixos.org/packages
  home.packages = with pkgs; [
    # azure-cli  # Next generation multi-platform command line experience for Azure
    # bear  # Tool that generates a compilation database for clang tooling
    # bibclean  # Prettyprint and syntax check BibTeX and Scribe bibliography data base files
    # bitwise  # Terminal based bitwise calculator in curses
    # sd  # Intuitive find & replace CLI (sed alternative)
    act  # Run your GitHub Actions locally
    aria  # A lightweight, multi-protocol, multi-source, command-line download utility
    bash-completion  # Programmable completion for the bash shell
    bat-extras.batdiff  # Diff a file against the current git index, or display the diff between two files. Requirements: bat, delta (optional)
    bat-extras.batgrep  # Quickly search through and highlight files using ripgrep. Requirements: ripgrep
    bottom  # A cross-platform graphical process/system monitor with a customizable interface
    btop  # A monitor of resources
    chezmoi  # Manage your dotfiles across multiple machines, securely
    colormake  # Simple wrapper around make to colorize the output
    cppcheck  # A static analysis tool for C/C++ code
    delta  # A syntax-highlighting pager for git
    detox  # Utility designed to clean up filenames
    difftastic  # A syntax-aware diff
    diskonaut  # Terminal disk space navigator
    doxygen  # Source code documentation generator tool
    dua   # A tool to conveniently learn about the disk usage of directories
    duf  # Disk Usage/Free Utility
    edtree  # File-tree visualizer and disk usage analyzer
    eza  # A modern, maintained replacement for ls
    f2  # Command-line batch renaming tool
    fd  # A simple, fast and user-friendly alternative to find
    fend  # Arbitrary-precision unit-aware calculator
    file  # A program that shows the type of files
    fzf  # A command-line fuzzy finder written in Go
    gcc13  # GNU Compiler Collection, version 13.x.x (wrapper script)
    gdu  # Disk usage analyzer with console interface
    glow  # Render markdown on the CLI, with pizzazz!
    gtrash  # A Trash CLI manager written in Go
    hyperfine  # Command-line benchmarking tool
    jless  # A command-line pager for JSON data
    lazygit  # Simple terminal UI for git commands
    lbzip2  # Parallel bzip2 compression utility
    less # On ubuntu, we need this less for `man home-configuration.nix`'s pager to work.
    lesspipe  # A preprocessor for less
    llvmPackages_17.clangUseLLVM  # A C language family frontend for LLVM (wrapper script)
    lua  # Powerful, fast, lightweight, embeddable scripting language
    markdownlint-cli2  # A fast, flexible, configuration-based command-line interface for linting Markdown/CommonMark files with the markdownlint library
    ninja  # Small build system with a focus on speed
    nodejs_21  # Event-driven I/O framework for the V8 JavaScript engine
    numbat  # High precision scientific calculator with full support for physical units
    opam  # A package manager for OCaml
    pdftk  # Command-line tool for working with PDFs
    perl538Packages.Appcpanminus  # Get, unpack, build and install modules from CPAN
    pigz  # A parallel implementation of gzip for multi-core machines
    pixz  # A parallel compressor/decompressor for xz format
    plzip  # A massively parallel lossless data compressor based on the lzlib compression library
    prettyping  # A wrapper around the standard ping tool with the objective of making the output prettier, more colorful, more compact, and easier to read
    procs  # A modern replacement for ps written in Rust
    programmer-calculator  # A terminal calculator for programmers
    ripgrep  # A utility that combines the usability of The Silver Searcher with the raw speed of grep
    rsync  # Fast incremental file transfer utility
    starship  # A minimal, blazing fast, and extremely customizable prompt for any shell
    tealdeer  # A very fast implementation of tldr in Rust
    tokei  # A program that allows you to count your code, quickly
    topgrade  # Upgrade all the things
    trash-cli  # Command line interface to the freedesktop.org trashcan
    tree  # Command to produce a depth indented directory listing
    viddy  # A modern watch command
    wget  # Tool for retrieving files using HTTP, HTTPS, and FTP
    yank  # Yank terminal output to clipboard
    yazi  # Blazing fast terminal file manager written in Rust, based on async I/O
    zellij  # A terminal workspace with batteries included

    # Nix dev
    cachix
    nil # Nix language server
    nix-info
    nixpkgs-fmt
    nixci
    nix-health
  ];

  home.shellAliases = {
    g = "git";
    lg = "lazygit";
  };

  # Programs natively supported by home-manager.
  programs = {
    # on macOS, you probably don't need this
    bash = {
      enable = false;
      initExtra = ''
        # Make Nix and home-manager installed things available in PATH.
        export PATH=/run/current-system/sw/bin/:/nix/var/nix/profiles/default/bin:$HOME/.nix-profile/bin:/etc/profiles/per-user/$USER/bin:$PATH
      '';
    };

    # For macOS's default shell.
    zsh = {
      enable = false;
      envExtra = ''
        # Make Nix and home-manager installed things available in PATH.
        export PATH=/run/current-system/sw/bin/:/nix/var/nix/profiles/default/bin:$HOME/.nix-profile/bin:/etc/profiles/per-user/$USER/bin:$PATH
      '';
    };

    # Better `cd`
    bat.enable = false;
    # Type `z <pat>` to cd to some directory
    zoxide.enable = false;
    # Type `<ctrl> + r` to fuzzy search your shell history
    fzf.enable = false;
    jq.enable = false;
    htop.enable = false;

    starship = {
      enable = false;
      settings = {
        username = {
          style_user = "blue bold";
          style_root = "red bold";
          format = "[$user]($style) ";
          disabled = false;
          show_always = true;
        };
        hostname = {
          ssh_only = false;
          ssh_symbol = "🌐 ";
          format = "on [$hostname](bold red) ";
          trim_at = ".local";
          disabled = false;
        };
      };
    };

    # https://nixos.asia/en/direnv
    direnv = {
      enable = false;
      nix-direnv.enable = false;
    };

    # https://nixos.asia/en/git
    git = {
      enable = false;
      # userName = "John Doe";
      # userEmail = "johndoe@example.com";
      ignores = [ "*~" "*.swp" ];
      aliases = {
        ci = "commit";
      };
      extraConfig = {
        # init.defaultBranch = "master";
        # pull.rebase = "false";
      };
    };
    lazygit.enable = false;

  };
}
