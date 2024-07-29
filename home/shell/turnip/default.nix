{ lib, ... }:
{
	turnip.colorscheme = "catppuccin";
	turnip.custom = {
		colorschemes.catppuccin.settings.transparent_background = false;
		options.relativenumber = lib.mkForce false;
		plugins = {
			oil.enable = lib.mkForce false;
			mini = {
				enable = true;
				modules = { files = {}; };
			};
		};
		keymaps = lib.mkForce [
            {
            	action = "<cmd>Telescope live_grep<CR>";
            	key = "<leader>tg";
            }
            {
            	action = "<cmd>Telescope find_files<CR>";
            	key = "<leader>tf";
            }
            {
            	action = "<cmd>lua MiniFiles.open()<CR>";
        		mode = "n";
				key = "-";
            }
            {
            	action = "<cmd>noh<CR>";
            	key = "<Esc>";
            	mode = "n";
            }
            {
            	action = "<cmd>AerialToggle!<CR>";
            	key = "<leader>a";
            }
            {
            	action = "<cmd>BufferNext<CR>";
            	key = "<A-.>";
            }
            {
            	action = "<cmd>BufferNext<CR>";
            	key = "<A-Tab>";
            }
            {
            	action = "<cmd>BufferPrev<CR>";
            	key = "<A-,>";
            }
            {
                action = "<cmd>BufferClose<CR>";
                key = "<leader>w";
            }
    		{
                action = "<cmd>ToggleTerm direction=float<CR>";
                key = "<leader>f";
            }
            {
                action = "<cmd>lua require('persistence').load()<CR>";
                key = "<leader>qs";
            }
            {
                action = "<cmd>lua require('persistence').load( { last = true })<CR>";
                key = "<leader>ql";
        	}
		];
	};
}
