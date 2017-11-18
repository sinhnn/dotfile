-- Imports
import XMonad
import XMonad.Prompt
import XMonad.Prompt.RunOrRaise (runOrRaisePrompt)
import XMonad.Prompt.AppendFile (appendFilePrompt)
import System.IO
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import System.Exit
import XMonad.Util.Run (safeSpawn, spawnPipe)
import Graphics.X11.ExtraTypes.XF86
import XMonad.Actions.GridSelect
-- HOOKS
import XMonad.ManageHook
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.InsertPosition
-- LAYOUTS
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace (onWorkspace, onWorkspaces)
import XMonad.Layout.ResizableTile
import XMonad.Layout.ThreeColumns
-- Rename the layout title
import XMonad.Layout.Renamed
import XMonad.Layout.Tabbed
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Layout.SimpleFloat
-- Layout for IM
import XMonad.Layout.IM
import Data.Ratio ((%))
import XMonad.Layout.Reflect (reflectHoriz)
-- Grid
import XMonad.Layout.Grid
-- Find nearest empty work space
import XMonad.Actions.FindEmptyWorkspace

------------------------------APPS------------------------------
pdf           = "atril"
mail          = "thunderbird"
compose_mail  = "thunderbird -compose"
chat          = "pidgin"
web           = "firefox"
music         = "audacious"
video         = "vlc"
tor           = "transmission-gtk"
file          = "caja"
term          = "xterm"
dic           = "goldendict"
screensaver   = "mate-screensaver-command"
dosomething   = "/home/sinhnn/.local/bin/music_random_playlist.sh"
--Note: get window information by "xprop"
-- MAIN KEYs
altKey   = mod4Mask
winKey   = mod1Mask
----STATUS BAR
--dzen2
dzenLeft= "~/.xmonad/dzenLeft.sh"
dzenRight="~/.xmonad/dzenRight.sh"
autostart="~/.xmonad/autostart;"
myDzen = dzenLeft ++ " | " ++ dzenRight ++ " | " ++  autostart
--xmobar
xmobarBar = "bash -c \"tee >(xmobar -x0) | xmobar -x1 | ~/.xmonad/autostart\""
--- WORKSPACES
myWorkspaces    = ["1.1:main", "1.2:main", "1.3:main", "4d:doc", "5f:web","6s:mail","7a:music","8r:win", "9g:img"]

-------------------------------------------------------------------------------
-- MAIN --
main :: IO ()
main = xmonad =<< statusBar myBar pp kb conf
  where
    uhook    = withUrgencyHookC NoUrgencyHook urgentConfig
    --Statusbar: dzen2 or xmobar
    myBar    = myDzen
    --CustomPP -> what is begin written to the bar
    pp       = mdzenPP
    --Key binding to toffle the gap for the bar
    kb       = toggleStrutsKey
    -- Main configuration, override the defaults
    conf     = uhook myConfig --uhook myConfig

------------------------------------------------------------------------------
-- Configs --
myConfig = defaultConfig { workspaces         = myWorkspaces
                         , modMask            = winKey
                         , borderWidth        = 2
                         , normalBorderColor  = colorNormalBorder
                         , focusedBorderColor = colorFocusedBorder
                         , terminal           = term
                         , keys               = keys'
                         , handleEventHook    = fullscreenEventHook
                         , layoutHook         = layoutHook'
                         , manageHook         = manageHook'
                         , startupHook        = setWMName "LG3D"
                         }
------------------------------MANAGEHOOK------------------------------
manageHook' :: ManageHook
manageHook' = insertPosition Above Newer <+> (composeAll . concat $
    [ [resource     =? r            --> doIgnore            |   r   <- myIgnores] -- ignore desktop
    , [className    =? c            --> doShift  "5f:web"   |   c   <- myWebs   ] -- move webs to main
    , [className    =? c            --> doShift  "6s:mail"  |   c   <- myMail   ] -- move webs to main
    , [resource     =? c            --> doShift  "6s:mail"  |   c   <- myMail   ] -- move webs to main
    , [className    =? c            --> doShift  "6s:mail"  |   c   <- myChat   ] -- move webs to main
    , [className    =? c            --> doShift  "7a:music" |   c   <- myMusic  ] -- move music to music
    , [className    =? c            --> doShift  "9g:img"   |   c   <- myTor    ] -- move img to div
    , [className    =? c            --> doShift  "9g:img"   |   c   <- myGimp   ] -- move img to div
    , [className    =? c            --> doShift  "8r:win"   |   c   <- myWin    ] -- move img to div
    , [className    =? c            --> doCenterFloat       |   c   <- myFloats ] -- float my floats
    , [name         =? n            --> doCenterFloat       |   n   <- myNames  ] -- float my names
    , [isFullscreen                 --> doFullFloat                           ]
    ])
    where
        role          = stringProperty "WM_WINDOW_ROLE"
        name          = stringProperty "WM_NAME"
        -- classnames
        myFloats      = ["VirtualBox","Xmessage","Nm-connection-editor","Write", "Msgcompose", "Zenity", "Yad", "Xsane"]
        myWebs        = ["Firefox","Google-chrome","Chromium", "Chromium-browser"]
        myMusic       = ["Rhythmbox","Spotify","Audacious", "Vlc"]
        myChat        = ["Buddy List", "Psi", "Psi+", "chat", "psi", "Skype", "Pidgin"]
        myGimp        = ["Gimp", "Dia"]
        myVim         = ["Gvim"]
        myTor         = ["Transmission-gtk"]
        myMail        = ["Mail"]
        myWin         = ["Wine", "Playonlinux"]
        -- resources
        myIgnores     = ["desktop","desktop_window","notify-osd","stalonetray","trayer","gnome-panel"]
        -- names
        myNames       = ["bashrun","Google Chrome Options","Chromium Options"]

myDoFullFloat :: ManageHook
myDoFullFloat = doF W.focusDown <+> doFullFloat

------------------------------STATUS BAR CONFIG------------------------------
mdzenPP = dzenPP  { ppCurrent           = dzenColor colorOrange colorDarkGray
                     , ppHidden          = dzenColor colorWhite colorDarkGray
                     , ppHiddenNoWindows = dzenColor colorGray colorDarkGray
                     , ppUrgent          = dzenColor "black" colorRed .pad
                     , ppLayout          = dzenColor colorOrange colorDarkGray
                     , ppTitle           = dzenColor colorOrange "" . shorten 80
                     , ppSep             = dzenColor colorGreen "" " | "
                     , ppWsSep           = " "
                    }
-----------------------------LAYOUT------------------------------

layoutHook'  = onWorkspace "6s:mail" chatLayout $
               customLayout

customLayout = avoidStruts $ full ||| sTile ||| sMtile
chatLayout = avoidStruts $ full ||| sTile ||| imLayout
-- Typical layout
rt     = ResizableTall 1 (2/100) (3/5) []
full   = renamed [Replace " "] $ smartBorders Full
sMtile = renamed [Replace "-"] $ smartBorders $ Mirror rt
sTile  = renamed [Replace "|"] $ smartBorders rt
-- Application layouts
imLayout = renamed [Replace "IM" ] $ reflectHoriz $ withIM ratio pidginRoster
            $ withIM skypeRatio skypeRoster Grid
  where
    ratio = (2/5)
    skypeRatio = (2/5)
    pidginRoster = And (ClassName "Pidgin") (Role "buddy_list")
    skypeRoster = And (ClassName "Skype") (Role "MainWindow")

------------------------------PROMPT CONFIG------------------------------
mXPConfig :: XPConfig
mXPConfig =
    defaultXPConfig { font                  = barFont
                    , bgColor               = colorDarkGray
                    , fgColor               = colorGreen
                    , bgHLight              = colorGreen
                    , fgHLight              = colorDarkGray
                    , promptBorderWidth     = 0
                    , height                = 14
                    , historyFilter         = deleteConsecutive
                    }
largeXPConfig :: XPConfig
largeXPConfig = mXPConfig
                { font   = xftFont
                , height = 22
                }

------------------------------GRID------------------------------
myGSConfig = defaultGSConfig {gs_cellwidth = 300}
------------------------------URGEN-----------------------------
urgentConfig = UrgencyConfig { suppressWhen = Focused, remindWhen = Dont }

------------------------------KEYS------------------------------
toggleStrutsKey :: XConfig Layout -> (KeyMask, KeySym)
toggleStrutsKey XConfig {XMonad.modMask = winKey} = (winKey, xK_b)
keys' :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
keys' conf@(XConfig {XMonad.modMask = winKey}) = M.fromList $
    -- winKey is used for display, altKey is used for application
    [
    -------------------- Application Keys --------------------
    -- Launching application
    ((winKey,                          xK_Return), safeSpawn (XMonad.terminal conf) [])
    , ((altKey,                        xK_r     ), runOrRaisePrompt largeXPConfig)
    , ((altKey,                        xK_s     ), safeSpawn mail[])
    , ((altKey .|. shiftMask,          xK_s     ), spawn compose_mail)
    , ((altKey,                        xK_f     ), safeSpawn web [])
    , ((altKey,                        xK_c     ), safeSpawn chat [])
    , ((altKey,                        xK_t     ), safeSpawn tor [])
    , ((altKey,                        xK_d     ), safeSpawn pdf [])
    , ((altKey,                        xK_h     ), safeSpawn file [])
    , ((altKey,                        xK_g     ), safeSpawn dic [])
    , ((altKey,                        xK_a     ), safeSpawn music [])
    , ((winKey,                        xK_F5    ), spawn "xset dpms force off")
    , ((controlMask .|. altKey,        xK_l     ), safeSpawn screensaver ["--lock"])
    , ((controlMask .|. altKey,        xK_Delete), spawn "systemctl poweroff")
    , ((altKey,                        xK_l), safeSpawn "ieee_sci-hub.sh" ["--no-gui"])
    -- Killing application
    ,((winKey     .|. shiftMask,       xK_c     ), kill)
    -- Do something: text -> command
    , ((0, xF86XK_Search                        ), safeSpawn dosomething [] )
    -- Audio Keys with audacious
    , ((0, xF86XK_AudioNext                     ), safeSpawn music ["--fwd"])
    , ((0, xF86XK_AudioPrev                     ), safeSpawn music ["--rew"])
    , ((0, xF86XK_AudioPlay                     ), safeSpawn music ["--play-pause"])
    -- Volume keys
    , ((controlMask,                   xK_Right ), safeSpawn "amixer" ["-c", "0", "set", "Master", "1dB+"])
    , ((controlMask,                   xK_Left  ), safeSpawn "amixer" ["-c", "0", "set", "Master", "1dB-"])
    , ((0, xF86XK_AudioRaiseVolume              ), safeSpawn "amixer" ["-q", "set", "Master", "2%+"])
    , ((0, xF86XK_AudioLowerVolume              ), safeSpawn "amixer" ["-q", "set", "Master", "2%-"])
    , ((0, xF86XK_AudioMute                     ), safeSpawn "amixer" ["-q", "set", "Master", "toggle"])
    -- Brightness & Display keys
    , ((0, xF86XK_MonBrightnessUp               ), safeSpawn "xbacklight" ["-inc", "40"])
    , ((0, xF86XK_MonBrightnessDown             ), safeSpawn "xbacklight" ["-dec", "10"])
    , ((winKey,                        xK_F4    ), spawn "/home/sinhnn/.xmonad/toggleVGA1.sh" )
    --, ((0, xF86XK_Display               ), safeSpawn "xrandr --output LVDS1 --off" [])

    --------------------- Xmonad layout and display control ------------------
    -- Grid
    , ((winKey,               xK_Tab   ), goToSelected myGSConfig)
    -- layouts
    , ((winKey,               xK_space ), sendMessage NextLayout)
    , ((winKey,               xK_b     ), sendMessage ToggleStruts)
    , ((winKey .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
    -- floating layer stuff
    , ((winKey,               xK_t     ), withFocused $ windows . W.sink)
    -- refresh
    , ((winKey,               xK_n     ), refresh)
    -- focus
    , ((winKey,               xK_u     ), focusUrgent)
    , ((altKey,               xK_Tab   ), windows W.focusDown)
    , ((winKey,               xK_j     ), windows W.focusDown)
    , ((winKey,               xK_k     ), windows W.focusUp)
    , ((winKey,               xK_m     ), windows W.focusMaster)
    -- swapping
    , ((winKey .|. shiftMask, xK_Return), windows W.swapMaster)
    , ((winKey .|. shiftMask, xK_j     ), windows W.swapDown  )
    , ((winKey .|. shiftMask, xK_k     ), windows W.swapUp    )
    -- increase or decrease number of windows in the master area
    , ((winKey              , xK_comma ), sendMessage (IncMasterN 1))
    , ((winKey              , xK_period), sendMessage (IncMasterN (-1)))
    -- resizing
    , ((winKey,               xK_h     ), sendMessage Shrink)
    , ((winKey,               xK_l     ), sendMessage Expand)
    , ((winKey,               xK_y     ), viewEmptyWorkspace)
    -- quit, or restart
    , ((winKey .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))
    , ((winKey              , xK_q     ), spawn "killall xmenud ; killall conky; killall dzen2; xmonad --recompile; xmonad --restart")
    ]
    ++
    -- mod-[1..9] %! Switch to workspace N
    -- mod-shift-[1..9] %! Move client to workspace N
    [((m .|. winKey, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++
    [((m .|. winKey, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1, xK_2, xK_3,  xK_d, xK_f, xK_s, xK_a, xK_r, xK_g]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++
    -- mod-[w,e] %! switch to twinview screen 1/2
    -- mod-shift-[w,e] %! move window to screen 1/2
    [((m .|. winKey, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

-------------------------------------------------------------------------------
------------------------------COLOR NAMES------------------------------
colorOrange         = "#FD971F"
colorDarkGray       = "#1B1D1E"
colorGray           = "#7B7B7B"
colorPink           = "#F92672"
colorGreen          = "#A6E22E"
colorBlue           = "#66D9EF"
colorYellow         = "#E6DB74"
colorWhite          = "#CCCCC6"
colorRed            = "#FF0000"
colorNormalBorder   = colorDarkGray
colorFocusedBorder  = colorRed
barFont  = "terminus"
barXFont = "inconsolata:size     = 12"
xftFont  = "xft: inconsolata-14"


