{pkgs, lib, ...}:

let 
  mkLuaInline = lib.generators.mkLuaInline;
in
{
  vim = {

    # Theming
    theme = {
      enable = true;
      name = "github";
      style = "dark_dimmed";
      transparent = true;
    };

    # clipboard
    clipboard = {
      enable = true;
      providers.xclip.enable = true;
    };

    ui.borders = {
      enable = true;
      globalStyle = "rounded";

      plugins.nvim-cmp = {
        enable = true;
        style = "rounded";
      };
    };

    # tab configuration ... don't ask me why every option has to be set idk
    options = {
      tabstop = 2;
      softtabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      
      autoindent = true;

      number = true;
      relativenumber = false;

      wrap = false;
    };

    # plugins
    statusline.lualine.enable = true;
    telescope = {
      enable = true;
      mappings = {
        findFiles = "<leader>pf"; # project files
        buffers = "<leader>bf";
        liveGrep = "<leader>ps";
        diagnostics = "<leader>fd"; # file diagnostics
        # gitFiles = "<leader>f"; TODO: find replacement
        lspDocumentSymbols = "<leader>s";
      };
    };
    autocomplete.nvim-cmp = {
      enable = true;
      mappings.confirm = null;
    };
    assistant.copilot = {
      enable = true;
      cmp.enable = true;
      
      mappings.suggestion = {
        accept = "<C-j>";
        # acceptLine = "<C-h>";
        # acceptWord = "...";
      };
    };


    # LSP and laguage stuff
    lsp.enable = true;

    languages = {
      enableTreesitter = true;

      nix.enable = true;
      lua.enable = true;
      clang.enable = true;
    };
  };

  # keymaps
  vim.globals.mapleader = " ";

  vim.keymaps = [
    {
      key = "jj";
      mode = "i";
      action = "<Esc>";
      desc = "Esc key remap for faster escaping insert mode";
    }
    {
      key = "<leader>pv";
      mode = "n";
      action = ":Ex<Cr>";
      desc = "open netrw";
    }
    # for normal mode
    {
      key = "j";
      mode = "n";
      action = "<Left>";
      noremap = true;
      desc = "remap main navigation keys";
    }
    {
      key = "k";
      mode = "n";
      action = "<Down>";
      noremap = true;
      desc = "remap main navigation keys";
    }
    {
      key = "l";
      mode = "n";
      action = "<Up>";
      noremap = true;
      desc = "remap main navigation keys";
    }
    {
      key = "ö";
      mode = "n";
      action = "<Right>";
      noremap = true;
      desc = "remap main navigation keys";
    }
    # for visual mode
    {
      key = "j";
      mode = "v";
      action = "<Left>";
      noremap = true;
      desc = "remap main navigation keys";
    }
    {
      key = "k";
      mode = "v";
      action = "<Down>";
      noremap = true;
      desc = "remap main navigation keys";
    }
    {
      key = "l";
      mode = "v";
      action = "<Up>";
      noremap = true;
      desc = "remap main navigation keys";
    }
    {
      key = "ö";
      mode = "v";
      action = "<Right>";
      noremap = true;
      desc = "remap main navigation keys";
    }

    # makro stuff

    # faster movement over blocks
    {
      key = "<C-k>";
      mode = "n";
      action = "}";
      desc = "faster movement over blocks (down)";
    }
    {
      key = "<C-l>";
      mode = "n";
      action = "{";
      desc = "faster movement over blocks (up)";
    }

    {
      key = "<C-k>";
      mode = "v";
      action = "}";
      desc = "faster movement over blocks (down)";
    }
    {
      key = "<C-l>";
      mode = "v";
      action = "{";
      desc = "faster movement over blocks (up)";
    }

    # terminal split
    {
      key = "<leader>t";
      mode = "n";
      action = ":vsplit | terminal<CR>";
      desc = "split terminal in active window (vertically)";
    }
    {
      key = "<leader>ht";
      mode = "n";
      action = ":split | terminal<CR>";
      desc = "split terminal in active window (horizontally)";
    }
    # edit terminal window
    {
      key = "jj";
      mode = "t";
      action = "<C-\\><C-n>";
      desc = "edit/exit the termina mode in terminal window";
    }

    # quick curly and normal braces
    {
      key = "<C-k>";
      mode = "i";
      action = "()<Esc>i";
      desc = "quick normal braces makro";
    }
    {
      key = "<C-d>";
      mode = "i";
      action = "{}<Esc>i";
      desc = "quick curly braces makro";
    }
    {
      key = "<C-ö>";
      mode = "i";
      action = "[]<Esc>i";
      desc = "quick square braces makro";
    }
  ];

  # netrw remap autocmd
  vim.autocmds = [
    {
      desc = "netrw navigation keys remap";
      event = ["FileType"];
      pattern = ["netrw"];
      callback = mkLuaInline ''
        function()
          vim.api.nvim_buf_set_keymap(0, "n", "ö", "<Cr>", {silent = true})
          vim.api.nvim_buf_set_keymap(0, "n", "j", "-", {silent = true})
        end
      '';
    }
  ];
  
}
