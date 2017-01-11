import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO
import XMonad.Config.Azerty
import XMonad.Hooks.SetWMName
import XMonad.Layout
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile

mylayout = tiled ||| Mirror tiled 
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = ResizableTall nmaster delta ratio []
     -- The default number of windows in the master pane
     nmaster = 1
     -- Default proportion of screen occupied by master pane
     ratio   = 1/2
     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

myLayoutHook = avoidStruts(smartBorders mylayout) ||| noBorders (fullscreenFull Full)

main = do
    xmproc <- spawnPipe "xmobar /home/bas/.config/xmobar/xmobarrc"
    xmonad $ azertyConfig {
         manageHook = manageDocks <+> manageHook defaultConfig, 
         layoutHook = myLayoutHook,
         modMask = mod4Mask, 
         startupHook = do
                 setWMName "LG3D"
                 spawn "trayer --align right --SetDockType true --SetPartialStrut true --height 15 --tint 0x333333 --transparent true --alpha 0"
                 spawn "nm-applet"
         } `additionalKeys`
        [ ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock"),
          ((0                     , 0x1008ff11), spawn "amixer set Master 2-"),
          ((0                     , 0x1008ff13), spawn "amixer set Master 2+"),
          ((0                     , 0x1008ff12), spawn "amixer -D pulse set Master toggle"), 
          ((mod4Mask              , xK_a), sendMessage MirrorShrink), 
          ((mod4Mask              , xK_z), sendMessage MirrorExpand),
          ((mod4Mask .|. shiftMask, xK_l), spawn "xset +dpms && ~/.xmonad/lock.sh")
        ]
