import Control.Monad (join, when)
import Data.Maybe (maybeToList)
import Data.Monoid ()
import qualified Data.Map as M
import System.Exit ()
import System.IO (hPutStrLn)
import XMonad
import XMonad.Util.SpawnOnce (spawnOnce)
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks (Direction2D (D, L, R, U), avoidStruts, docks, manageDocks)
import XMonad.Hooks.ManageHelpers (doFullFloat, isFullscreen, doCenterFloat)
import XMonad.Hooks.SetWMName
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar.PP
import XMonad.Layout.Spiral(spiral)
import XMonad.Layout.Spacing (Border (Border), spacingRaw, smartSpacing)
import XMonad.Layout.MultiToggle(Toggle(..), mkToggle, single, (??), EOT(..))
import XMonad.Layout.MultiToggle.Instances
import qualified XMonad.StackSet as W
import qualified XMonad.DBus as D
import qualified DBus.Client as DC
import Graphics.X11.ExtraTypes.XF86 (xF86XK_AudioLowerVolume, xF86XK_AudioMute, xF86XK_AudioNext,
                                     xF86XK_AudioPlay, xF86XK_AudioPrev, xF86XK_AudioRaiseVolume,
                                     xF86XK_MonBrightnessDown, xF86XK_MonBrightnessUp)

------------------------------------------------------------------------
-- Some useful variables
myTerminal = "st"
exeParam   = " -e "
executor :: String -> String 
executor program = do myTerminal ++ exeParam ++ program
myBrowser = "firefox "
myEditor = "nvim"
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False
myClickJustFocuses :: Bool
myClickJustFocuses = False
myBorderWidth = 2
myModMask = mod4Mask
-- > workspaces = ["sys", "web", "code", "chat", "docs" ]
myWorkspaces = ["\63083", "\63288", "\57909", "\63107", "\59333"] 
myNormalBorderColor  = "#bd93f9"
myFocusedBorderColor = "#ff79c6"

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
myKeys conf@(XConfig {XMonad.modMask = modm}) =
  M.fromList $
    -- launch a terminal
    [ ((modm, xK_Return), spawn $ XMonad.terminal conf),
      -- My Stuff
      ((0, xK_Print), spawn "~/Scripts/screenshots.sh u"),
      ((shiftMask, xK_Print), spawn "~/Scripts/screenshots.sh s"),
      ((controlMask .|. shiftMask, xK_Print), spawn "~/Scripts/screenshots.sh i"),
      ((modm .|. shiftMask, xK_d), spawn "~/.config/rofi/bin/powermenu.sh"),
      ((modm, xK_d), spawn "~/.config/rofi/bin/launcher.sh"),
      ((modm .|. shiftMask, xK_p), spawn "~/.config/rofi/bin/monitormenu.sh"),
      ((modm .|. shiftMask, xK_c), spawn "~/Scripts/comp.sh picom"),
      ((modm .|. shiftMask, xK_b), spawn "~/.config/polybar/launch.sh"),
      ((modm,               xK_w), spawn (myBrowser)),
      ((modm,               xK_b), spawn (executor "btop")),
      -- Close focused window
      ((modm, xK_q), kill),
      ((modm, xK_f), sendMessage $ Toggle NBFULL),
      -- Rotate through the available layout algorithms
      ((modm, xK_space), sendMessage NextLayout),
      --  Reset the layouts on the current workspace to default
      ((modm .|. shiftMask, xK_space), setLayout $ XMonad.layoutHook conf),
      -- Resize viewed windows to the correct size
      ((modm, xK_n), refresh),
      -- Move focus to the next window
      ((modm, xK_Tab), windows W.focusDown),
      -- Move focus to the next window
      ((modm, xK_j), windows W.focusDown),
      -- Move focus to the previous window
      ((modm, xK_k), windows W.focusUp),
      -- Move focus to the master window
      ((modm, xK_m), windows W.focusMaster),
      -- Swap the focused window and the master window
      ((modm .|. shiftMask, xK_Return), windows W.swapMaster),
      -- Swap the focused window with the next window
      ((modm .|. shiftMask, xK_j), windows W.swapDown),
      -- Swap the focused window with the previous window
      ((modm .|. shiftMask, xK_k), windows W.swapUp),
      -- Shrink the master area
      ((modm, xK_h), sendMessage Shrink),
      -- Expand the master area
      ((modm, xK_l), sendMessage Expand),
      -- Push window back into tiling
      ((modm, xK_t), withFocused $ windows . W.sink),
      -- Increment the number of windows in the master area
      ((modm, xK_comma), sendMessage (IncMasterN 1)),
      -- Deincrement the number of windows in the master area
      ((modm, xK_period), sendMessage (IncMasterN (-1))), 
      -- Audio keys
      ((0, xF86XK_AudioPlay), spawn "playerctl play-pause"),
      ((0, xF86XK_AudioPrev), spawn "playerctl previous"),
      ((0, xF86XK_AudioNext), spawn "playerctl next"),
      ((0, xF86XK_AudioRaiseVolume), spawn "pactl set-sink-volume 0 +5%"),
      ((0, xF86XK_AudioLowerVolume), spawn "pactl set-sink-volume 0 -5%"),
      ((0, xF86XK_AudioMute), spawn "pactl set-sink-mute 0 toggle"),
      -- Brightness keys
      ((0, xF86XK_MonBrightnessUp), spawn "brightnessctl s +10%"),
      ((0, xF86XK_MonBrightnessDown), spawn "brightnessctl s 10-%"),
      -- Restart xmonad
      ((modm .|. shiftMask, xK_r), spawn "xmonad --recompile; xmonad --restart")
    ]
    ++
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    [ ((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9],
          (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
    ]

------------------------------------------------------------------------
-- Mouse bindings
myMouseBindings (XConfig {XMonad.modMask = modm}) =
  M.fromList $
    -- mod-button1, Set the window to floating mode and move by dragging
    [ ( (modm, button1),
        ( \w ->
            focus w >> mouseMoveWindow w
              >> windows W.shiftMaster
        )
      ),
      -- mod-button2, Raise the window to the top of the stack
      ((modm, button2), (\w -> focus w >> windows W.shiftMaster)),
      -- mod-button3, Set the window to floating mode and resize by dragging
      ( (modm, button3),
        ( \w ->
            focus w >> mouseResizeWindow w
              >> windows W.shiftMaster
        )
      )
      -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:
myLayout = spacingRaw True (Border 0 5 5 5) True (Border 5 5 5 5) True
          $ mkToggle (NBFULL ?? NOBORDERS ?? EOT)
          $ avoidStruts $ tiled ||| mirroedTiled ||| spiral (6/7)
  where
    -- default tiling algorithm partitions the screen into two panes
    tiled = Tall nmaster delta ratio
    -- The default number of windows in the master pane
    nmaster = 1
    -- Percent of screen to increment by when resizing panes
    delta = 3 / 100
    -- Default proportion of screen occupied by master pane
    ratio = 1 / 2
    mirroedTiled = Mirror tiled

------------------------------------------------------------------------
-- Window rules:
myManageHook = composeAll [ manageDocks,
                            className =? "confirm" --> doFloat,
                            className =? "file_progress" --> doFloat,
                            className =? "dialog" --> doFloat,
                            className =? "download" --> doFloat,
                            className =? "error" --> doFloat,
                            className =? "Gimp" --> doFloat,
                            className =? "notification" --> doFloat,
                            className =? "pinentry-gtk-2" --> doFloat,
                            className =? "splash" --> doFloat,
                            className =? "toolbar" --> doFloat,
                            className =? "Yad" --> doCenterFloat,
                            className =? "jetbrains-idea" --> doCenterFloat,
                            (className =? "firefox" <&&> resource =? "Dialog") --> doFloat,
														isFullscreen --> doFullFloat]

------------------------------------------------------------------------
-- Event handling
myEventHook = mempty

------------------------------------------------------------------------
-- Status bars and logging
myLogHook :: DC.Client -> PP
myLogHook dbus = def { ppOutput = D.send dbus , ppOrder = \(ws:l:t:_) -> [l] }

------------------------------------------------------------------------
-- Startup hook
myStartupHook = do
  spawnOnce "$HOME/.config/xmonad/autostart.sh"
  setWMName "LG3D"

------------------------------------------------------------------------
-- Run xmonad with all the defaults set up.
main :: IO ()
main = do
  dbus <- D.connect
  D.requestAccess dbus
  xmonad $ ewmhFullscreen $ ewmh $ docks $ defaults { logHook = dynamicLogWithPP (myLogHook dbus) }

defaults =
  def
    { terminal = myTerminal,
      focusFollowsMouse = myFocusFollowsMouse,
      clickJustFocuses = myClickJustFocuses,
      borderWidth = myBorderWidth,
      modMask = myModMask,
      workspaces = myWorkspaces,
      normalBorderColor = myNormalBorderColor,
      focusedBorderColor = myFocusedBorderColor,
      keys = myKeys,
      mouseBindings = myMouseBindings,
      manageHook = myManageHook,
      layoutHook = myLayout,
      handleEventHook = myEventHook,
      startupHook = myStartupHook
    }
