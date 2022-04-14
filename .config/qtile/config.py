# -*- coding: utf-8 -*-
import os
import re
import socket
import subprocess
from libqtile import qtile
from libqtile.config import Click, Drag, Group, KeyChord, Key, Match, Screen
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from typing import List  # noqa: F401from typing import List  # noqa: F401

home = os.path.expanduser('~')
menu = home+"/.config/rofi/bin/"
scripts = home+"/Scripts/"
fontFamily = "Ubuntu"
mod = "mod4" # Sets mod key to SUPER/WINDOWS
alt = "mod1"
myTerm = "kitty"      # My terminal of choice
execTerm= myTerm+" -e "
myBrowser = "firefox" # My browser of choice

keys = [
         ### The essentials
         Key([mod], "Tab",
             lazy.next_layout(),
             desc='Toggle through layouts'
             ),
         Key([mod], "q",
             lazy.window.kill(),
             desc='Kill active window'
             ),
         Key([mod], "Return",
             lazy.spawn(myTerm),
             desc='Launches My Terminal'
             ),
         Key([mod], "w",
             lazy.spawn(myBrowser),
             desc='Firefox'
             ),
         ### Others
         Key([mod], "v",
             lazy.spawn(execTerm+"nvim"),
             desc='NeoVim'
             ),
         Key([mod], "b",
             lazy.spawn(execTerm+"btop"),
             desc='BTop'
             ),
         Key([mod], "r",
             lazy.spawn(execTerm+"ranger"),
             desc='Ranger Files'
             ),
         ### Menus
         Key([mod], "d",
             lazy.spawn(menu+"launcher.sh"),
             desc='Run Rofi'
             ),
         Key([mod, "shift"], "d",
             lazy.spawn(menu+"powermenu.sh"),
             desc='Run Power Menu'
             ),
         Key([mod], "p",
             lazy.spawn(menu+"monitormenu.sh"),
             desc='Run Monitors Menu'
             ),
         ### Restarts
         Key([mod, "shift"], "r",
             lazy.restart(),
             desc='Restart Qtile'
             ),
         Key([mod, "shift"], "q",
             lazy.shutdown(),
             desc='Shutdown Qtile'
             ),
         Key([mod, "shift"], "p",
             lazy.spawn(scripts+"comp.sh"),
             desc='Reload Picom'
             ),
         ### Prints
         Key([],"Print",
             lazy.spawn(scripts+"screenshots.sh u"),
             desc='Screenshot'
             ),
         Key(["shift"],"Print",
             lazy.spawn(scripts+"screenshots.sh s"),
             desc='Screenshot'
             ),
         Key(["control", "shift"],"Print",
             lazy.spawn(scripts+"screenshots.sh i"),
             desc='Screenshot'
             ),
         ### Switch focus to specific monitor (out of three)
         Key([mod, alt], "1", 
             lazy.to_screen(0),
             desc='Keyboard focus to monitor 1'
             ),
         Key([mod, alt], "2",
             lazy.to_screen(1),
             desc='Keyboard focus to monitor 2'
             ),
         Key([mod, alt], "3",
             lazy.to_screen(2),
             desc='Keyboard focus to monitor 3'
             ),
         ### Switch focus of monitors
         Key([mod], "period",
             lazy.next_screen(),
             desc='Move focus to next monitor'
             ),
         Key([mod], "comma",
             lazy.prev_screen(),
             desc='Move focus to prev monitor'
             ),
         ### Treetab controls
          Key([mod, "shift"], "h",
             lazy.layout.move_left(),
             desc='Move up a section in treetab'
             ),
         Key([mod, "shift"], "l",
             lazy.layout.move_right(),
             desc='Move down a section in treetab'
             ),
         ### Window controls
         Key([mod], "j",
             lazy.layout.down(),
             desc='Move focus down in current stack pane'
             ),
         Key([mod], "k",
             lazy.layout.up(),
             desc='Move focus up in current stack pane'
             ),
         Key([mod, "shift"], "j",
             lazy.layout.shuffle_down(),
             lazy.layout.section_down(),
             desc='Move windows down in current stack'
             ),
         Key([mod, "shift"], "k",
             lazy.layout.shuffle_up(),
             lazy.layout.section_up(),
             desc='Move windows up in current stack'
             ),
         Key([mod], "h",
             lazy.layout.shrink(),
             lazy.layout.decrease_nmaster(),
             desc='Shrink window (MonadTall), decrease number in master pane (Tile)'
             ),
         Key([mod], "l",
             lazy.layout.grow(),
             lazy.layout.increase_nmaster(),
             desc='Expand window (MonadTall), increase number in master pane (Tile)'
             ),
         Key([mod], "n",
             lazy.layout.normalize(),
             desc='normalize window size ratios'
             ),
         Key([mod], "m",
             lazy.layout.maximize(),
             desc='toggle window between minimum and maximum sizes'
             ),
         Key([mod, "shift"], "f",
             lazy.window.toggle_floating(),
             desc='toggle floating'
             ),
         Key([mod], "f",
             lazy.window.toggle_fullscreen(),
             desc='toggle fullscreen'
             ),
         ### Stack controls
         Key([mod, "shift"], "Tab",
             lazy.layout.rotate(),
             lazy.layout.flip(),
             desc='Switch which side main pane occupies (XmonadTall)'
             ),
          Key([mod], "space",
             lazy.layout.next(),
             desc='Switch window focus to other pane(s) of stack'
             ),
         Key([mod, "shift"], "space",
             lazy.layout.toggle_split(),
             desc='Toggle between split and unsplit sides of stack'
             )
         ]

groups = [Group(" ", layout='monadtall'),
          Group(" ", layout='monadtall'),
          Group(" ", layout='monadtall'),
          Group(" ", layout='monadtall'),
          Group(" ", layout='monadtall')]

# Allow MODKEY+[0 through 9] to bind to groups, see https://docs.qtile.org/en/stable/manual/config/groups.html
# MOD4 + index Number : Switch to Group[index]
# MOD4 + shift + index Number : Send active window to another Group
from libqtile.dgroups import simple_key_binder
dgroups_key_binder = simple_key_binder("mod4")

# Dracula Theme
colors = [["#282A36", "#282A36"],
          ["#000000", "#000000"],
          ["#F8F8F2", "#F8F8F2"],
          ["#CAA9FA", "#CAA9FA"],
          ["#FF92D0", "#FF92D0"],
          ["#5AF78E", "#5AF78E"],
          ["#F4F99D", "#F4F99D"],
          ["#FF6E67", "#FF6E67"],
          ["#9AEDFE", "#9AEDFE"],
          ["#E6E6E6", "#E6E6E6"]]

layout_theme = {"border_width": 3,
                "margin": 6,
                "border_focus": colors[4],
                "border_normal": colors[3]
                }

layouts = [
    #layout.MonadWide(**layout_theme),
    #layout.Bsp(**layout_theme),
    #layout.Stack(stacks=2, **layout_theme),
    #layout.Columns(**layout_theme),
    #layout.RatioTile(**layout_theme),
    #layout.Tile(shift_windows=True, **layout_theme),
    #layout.VerticalTile(**layout_theme),
    #layout.Matrix(**layout_theme),
    #layout.Zoomy(**layout_theme),
    layout.Bsp(**layout_theme),
    layout.MonadTall(**layout_theme),
    layout.Max(**layout_theme),
    layout.Stack(num_stacks=2,**layout_theme),
    layout.RatioTile(**layout_theme),
    layout.TreeTab(
         font = fontFamily,
         fontsize = 12,
         sections = ["FIRST", "SECOND", "THIRD", "FOURTH"],
         section_fontsize = 12,
         border_width = 2,
         bg_color = colors[0],
         active_bg = colors[4],
         active_fg = colors[2],
         inactive_bg = colors[3],
         inactive_fg = colors[1],
         padding_left = 0,
         padding_x = 0,
         padding_y = 5,
         section_top = 10,
         section_bottom = 20,
         level_shift = 8,
         vspace = 3,
         panel_width = 200
         ),
    layout.Floating(**layout_theme)
]

prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())

##### DEFAULT WIDGET SETTINGS #####
widget_defaults = dict(
    font=fontFamily+" Bold",
    fontsize = 12,
    padding = 3,
    background=colors[2]
)
extension_defaults = widget_defaults.copy()

def init_widgets_list():
    widgets_list = [
              widget.TextBox(
                       text = ' ',
                       mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(home+menu+"launcher_misc")},
                       font = fontFamily+" Mono",
                       background = colors[6],
                       foreground = colors[1],
                       padding = 6,
                       fontsize = 18
                       ),
              widget.TextBox(
                       text = '',
                       font = fontFamily+" Mono",
                       background = colors[5],
                       foreground = colors[6],
                       padding = 0,
                       fontsize = 18
                       ),
              widget.GroupBox(
                       font = fontFamily,
                       fontsize = 17,
                       margin_y = 3,
                       margin_x = 0,                
                       padding_y = 0,
                       padding_x = 3,
                       borderwidth = 3,
                       active = colors[3],
                       inactive = colors[1],
                       rounded = False,
                       highlight_color = colors[1],
                       highlight_method = "text",
                       this_current_screen_border = colors[4],
                       this_screen_border = colors [4],
                       other_current_screen_border = colors[6],
                       other_screen_border = colors[4],
                       foreground = colors[1],
                       background = colors[5]
                       ),
              widget.TextBox(
                       text = '',
                       font = fontFamily+" Mono",
                       background = colors[4],
                       foreground = colors[5],
                       padding = 0,
                       fontsize = 18
                       ),
              widget.CurrentLayoutIcon(
                       custom_icon_paths = [home+"/.config/qtile/icons"],
                       foreground = colors[1],
                       background = colors[4],
                       padding = 0,
                       scale = 0.9
                       ),
              widget.CurrentLayout(
                       foreground = colors[1],
                       background = colors[4],
                       padding = 6
                       ),
              widget.TextBox(
                       text = '',
                       font = fontFamily+" Mono",
                       background = colors[3],
                       foreground = colors[4],
                       padding = 0,
                       fontsize = 18
                       ),
              widget.TextBox(
                       text = '',
                       font = fontFamily+" Mono",
                       background = colors[0],
                       foreground = colors[3],
                       padding = 0,
                       fontsize = 18
                       ),
              widget.WindowName(
                       foreground = colors[2],
                       background = colors[0],
                       padding = 6
                       ),
              widget.Sep(
                       linewidth = 0,
                       padding = 6,
                       foreground = colors[0],
                       background = colors[0]
                       ),
              widget.Systray(
                       background = colors[0],
                       padding = 6
                       ),
              widget.Sep(
                       linewidth = 0,
                       padding = 6,
                       foreground = colors[0],
                       background = colors[0]
                       ),
              widget.TextBox(
                       text = '',
                       font = fontFamily+" Mono",
                       background = colors[0],
                       foreground = colors[3],
                       padding = 0,
                       fontsize = 18
                       ),
              widget.Net(
                       interface = "enp3s0",
                       format = 'Net: {down} ↓↑ {up}',
                       foreground = colors[1],
                       background = colors[3],
                       prefix = 'M',
                       padding = 6
                       ),
              widget.TextBox(
                       text = '',
                       font = fontFamily+" Mono",
                       background = colors[3],
                       foreground = colors[4],
                       padding = 0,
                       fontsize = 18
                       ),
              widget.CheckUpdates(
                       update_interval = 1800,
                       distro = "Arch_paru",
                       display_format = "Updates: {updates} ",
                       foreground = colors[1],
                       colour_have_updates = colors[1],
                       colour_no_updates = colors[1],
                       mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(myTerm + ' -e paru ')},
                       padding = 6,
                       background = colors[4]
                       ),
              widget.TextBox(
                       text = '',
                       font = fontFamily+" Mono",
                       background = colors[4],
                       foreground = colors[5],
                       padding = 0,
                       fontsize = 18
                       ),
              widget.Volume(
                       foreground = colors[1],
                       background = colors[5],
                       fmt = 'Vol: {}',
                       padding = 6
                       ),
              widget.TextBox(
                       text = '',
                       font = fontFamily+" Mono",
                       background = colors[5],
                       foreground = colors[6],
                       padding = 0,
                       fontsize = 18
                       ),
              widget.Clock(
                       foreground = colors[1],
                       background = colors[6],
                       format = "%A, %d %B %Y - %H:%M "
                       ),
              widget.TextBox(
                       text = '',
                       font = fontFamily+" Mono",
                       background = colors[6],
                       foreground = colors[7],
                       padding = 0,
                       fontsize = 18
                       )
              ]
    return widgets_list

def init_widgets_screen1():
    widgets_screen1 = init_widgets_list()
    del widgets_screen1[9:10]               # Slicing removes unwanted widgets (systray) on Monitors 1,3
    return widgets_screen1

def init_widgets_screen2():
    widgets_screen2 = init_widgets_list()
    return widgets_screen2                 # Monitor 2 will display all widgets in widgets_list

def init_screens():
    return [Screen(top=bar.Bar(widgets=init_widgets_screen1(), opacity=1.0, size=20)),
            Screen(top=bar.Bar(widgets=init_widgets_screen2(), opacity=1.0, size=20)),
            Screen(top=bar.Bar(widgets=init_widgets_screen1(), opacity=1.0, size=20))]

if __name__ in ["config", "__main__"]:
    screens = init_screens()
    widgets_list = init_widgets_list()
    widgets_screen1 = init_widgets_screen1()
    widgets_screen2 = init_widgets_screen2()

def window_to_prev_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i - 1].name)

def window_to_next_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i + 1].name)

def window_to_previous_screen(qtile):
    i = qtile.screens.index(qtile.current_screen)
    if i != 0:
        group = qtile.screens[i - 1].group.name
        qtile.current_window.togroup(group)

def window_to_next_screen(qtile):
    i = qtile.screens.index(qtile.current_screen)
    if i + 1 != len(qtile.screens):
        group = qtile.screens[i + 1].group.name
        qtile.current_window.togroup(group)

def switch_screens(qtile):
    i = qtile.screens.index(qtile.current_screen)
    group = qtile.screens[i - 1].group
    qtile.current_screen.set_group(group)

mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_app_rules = []  # type: List
follow_mouse_focus = False
bring_front_click = False
cursor_warp = False

floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    # default_float_rules include: utility, notification, toolbar, splash, dialog,
    # file_progress, confirm, download and error.
    #*layout.Floating.default_float_rules,
    Match(wm_type="utility"),
    Match(wm_type="splash"),
    Match(wm_class="file_progress"),
    Match(wm_class="confirm"),
    Match(wm_class="dialog"),
    Match(wm_type="dialog"),
    Match(wm_class="download"),
    Match(wm_class="error"),
    Match(wm_class="notification"), 
    Match(wm_type="notification"),
    Match(wm_class="splash"),
    Match(wm_class="toolbar"),
    Match(wm_type="toolbar"),
    Match(title='Confirmation'),      # tastyworks exit box
    Match(title='Qalculate!'),        # qalculate-gtk
    ],**layout_theme)

auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

@hook.subscribe.startup_once
def start_once():
    subprocess.call([home + '/.config/qtile/autostart.sh'])

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
