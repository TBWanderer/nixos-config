{ pkgs, lib, ... }:
{
	services.hyprpaper.enable = lib.mkForce false;
	stylix.targets.hyprland.enable = false;
	programs.wpaperd.enable = true;
	wayland.windowManager.hyprland = {
		enable = true;
		extraConfig = ''
			monitor=,1920x1080@144,0x0,1
			
			$terminal = alacritty --working-directory /home/x/
			$fileManager = nemo
			$menu = rofi -show drun
			
			exec-once = hyprlock && sleep 0.2 && waybar
			exec-once = wpaperd
			exec-once = wl-paste --watch cliphist store

			general { 
			    gaps_in = 5
			    gaps_out = 10
			
			    border_size = 1
				

			    col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
			    col.inactive_border = rgba(595959aa)
			    
			    resize_on_border = false 
			    
			    allow_tearing = false
			
			    layout = dwindle
			}
			
			
			decoration {
			    rounding = 10
			    
			    active_opacity = 0.9
			    inactive_opacity = 0.9
			
			    
			    blur {
			        enabled = true
			        size = 3
			        passes = 1
			        
			        vibrancy = 0.1696
			    }
			}
			
			
			decoration:shadow {
				enabled = false
			}
			animations {
			    enabled = true
			
			    bezier = myBezier, 0.05, 0.9, 0.1, 1.05
			
			    animation = windows, 1, 7, myBezier
			    animation = windowsOut, 1, 7, default, popin 80%
			    animation = border, 1, 10, default
			    animation = borderangle, 1, 8, default
			    animation = fade, 1, 7, default
			    animation = workspaces, 1, 6, default
		}
			
			
			dwindle {
			    pseudotile = true 
			    preserve_split = true 
			}
			
			master {
			    new_status = master
			}
			
			misc { 
			    force_default_wallpaper = -1 
			    disable_hyprland_logo = false 
			}
			
			input {
			    kb_layout = us,ru
			    kb_variant =
			    kb_model =
			    kb_options = caps:escape,grp:win_space_toggle
			    kb_rules =
			
			    follow_mouse = 1
			
			    sensitivity = 0 
			
			    touchpad {
			        natural_scroll = false
			    }
			}
			
			
			gestures {
			    workspace_swipe = true
			}
			
			$mainMod = SUPER 

			bind = $mainMod, C, killactive 
			bind = $mainMod SHIFT, L, exec, hyprlock
			bind = $mainMod, O, pin
			bind = $mainMod, f, togglefloating, 
			bind = $mainMod, M, exit
			bind = $mainMod, y, togglesplit,
			bind = $mainMod, u, fullscreen,
			
			
			bind = $mainMod, RETURN, exec, alacritty msg create-window || alacritty
			bind = $mainMod, A, exec, cool-retro-term --fullscreen

			bind = $mainMod, E, exec, nemo
			bind = ALT, SPACE, exec, rofi -show run
			bind = $mainMod, R, exec, rofi -show drun
			bind = $mainMod, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy
			
			bind = , PRINT, exec, grim -g"$(slurp)" - | wl-copy
			bind = $mainMod, I, exec, grim -g"$(slurp)" -l 0 /home/x/Pictures/"$(date +%d-%m-%Y_%s)"-screen.png
			bind = $mainMod, P, exec, grim -l 0 /home/x/Pictures/"$(date +%d-%m-%Y_%s)"-screen.png
			bind = CTRL SHIFT, PRINT, exec, pkill wf-recorder
			
			bind = $mainMod, h, movefocus, l
			bind = $mainMod, l, movefocus, r
			bind = $mainMod, k, movefocus, u
			bind = $mainMod, j, movefocus, d
			
			bind = $mainMod CTRL SHIFT, h, movewindow, l
			bind = $mainMod CTRL SHIFT, l, movewindow, r
			bind = $mainMod CTRL SHIFT, k, movewindow, u
			bind = $mainMod CTRL SHIFT, j, movewindow, d
			
			bind = $mainMod, 1, workspace, 1
			bind = $mainMod, 2, workspace, 2
			bind = $mainMod, 3, workspace, 3
			bind = $mainMod, 4, workspace, 4
			bind = $mainMod, 5, workspace, 5
			bind = $mainMod, 6, workspace, 6
			bind = $mainMod, 7, workspace, 7
			bind = $mainMod, 8, workspace, 8
			bind = $mainMod, 9, workspace, 9
			bind = $mainMod, 0, workspace, 10
			bind = $mainMod CTRL, o, workspace, 11
			
			bind = $mainMod SHIFT, 1, movetoworkspace, 1
			bind = $mainMod SHIFT, 2, movetoworkspace, 2
			bind = $mainMod SHIFT, 3, movetoworkspace, 3
			bind = $mainMod SHIFT, 4, movetoworkspace, 4
			bind = $mainMod SHIFT, 5, movetoworkspace, 5
			bind = $mainMod SHIFT, 6, movetoworkspace, 6
			bind = $mainMod SHIFT, 7, movetoworkspace, 7
			bind = $mainMod SHIFT, 8, movetoworkspace, 8
			bind = $mainMod SHIFT, 9, movetoworkspace, 9
			bind = $mainMod SHIFT, 0, movetoworkspace, 10
			bind = $mainMod SHIFT, k, movetoworkspace, 11

			bind = $mainMod, mouse_down, workspace, e+1
			bind = $mainMod, mouse_up, workspace, e-1
			
			bindm = $mainMod, mouse:272, movewindow
			bindm = $mainMod, mouse:273, resizewindow
			
			# Ресайз
			bind = $mainMod CTRL, h, resizeactive,-50 0
			bind = $mainMod CTRL, l, resizeactive,50 0
			bind = $mainMod CTRL, k, resizeactive,0 -50
			bind = $mainMod CTRL, j, resizeactive,0 50
			
			bind = $mainMod CTRL, p, exec, powermenu
			
			bind = , XF86AudioMute, exec,  ${pkgs.pamixer}/bin/pamixer -t
        	bind = , XF86AudioRaiseVolume, exec, ${pkgs.pamixer}/bin/pamixer -i2
        	bind = , XF86AudioLowerVolume, exec, ${pkgs.pamixer}/bin/pamixer -d2
        	bind = , XF86AudioPause, exec, ${pkgs.playerctl}/bin/playerctl play-pause
        	bind = , XF86AudioPlay, exec, ${pkgs.playerctl}/bin/playerctl play
        	bind = , XF86AudioPrev, exec, ${pkgs.playerctl}/bin/playerctl previous
        	bind = , XF86AudioNext, exec, ${pkgs.playerctl}/bin/playerctl next

			windowrulev2 = suppressevent maximize, class:.* 
		'';
	};
}
