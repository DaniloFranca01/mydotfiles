-- Xmobar (http://projects.haskell.org/xmobar/)
-- This is the default xmobar configuration for DTOS.
-- This config is packaged in the DTOS repo as dtos-xmobar
-- Dependencies: otf-font-awesome ttf-mononoki ttf-ubuntu-font-family trayer
-- Also depends on scripts from dtos-local-bin from the dtos-core-repo.

Config { font            = "xft:Ubuntu:weight=bold:pixelsize=11:antialias=true:hinting=true"
       , additionalFonts = [ "xft:Iosevka Nerd Font Mono:pixelsize=11:antialias=true:hinting=true" ]
       , bgColor      = "#282c34"
       , fgColor      = "#ff6c6b"
       -- Position TopSize and BottomSize take 3 arguments:
       --   an alignment parameter (L/R/C) for Left, Right or Center.
       --   an integer for the percentage width, so 100 would be 100%.
       --   an integer for the minimum pixel height for xmobar, so 24 would force a height of at least 24 pixels.
       --   NOTE: The height should be the same as the trayer (system tray) height.
       , position       = TopSize L 100 24
       , lowerOnStart = True
       , hideOnStart  = False
       , allDesktops  = True
       , persistent   = True
       , iconRoot     = ".xmonad/xpm/"  -- default: "."
       , commands = [  -- Check for pacman updates (script found in .local/bin)
                    , Run Com ".local/bin/pacupdate" [] "pacupdate" 36000
                        -- Time and date
                    , Run Date "<fn=2>\xf017</fn>  %b %d %Y - (%H:%M) " "date" 50
                        -- Script that dynamically adjusts xmobar padding depending on number of trayer icons.
                    , Run Com ".config/xmobar/trayer-padding-icon.sh" [] "trayerpad" 20
                        -- Prints out the left side items such as workspaces, layout, etc.
                    , Run UnsafeStdinReader
                    ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = " <icon=haskell_20.xpm/><fc=#666666>|</fc> %UnsafeStdinReader% }{ <box type=Bottom width=2 mb=2 color=#51afef<box type=Bottom width=2 mb=2 color=#c678dd><fc=#c678dd>%bell%  <action=`st -e sudo pacman -Syu`>%pacupdate%</action></fc></box><box type=Bottom width=2 mb=2 color=#46d9ff><fc=#46d9ff><action=`emacsclient -c -a 'emacs' --eval '(doom/window-maximize-buffer(dt/year-calendar))'`>%date%</action></fc></box> %trayerpad%"
       }
