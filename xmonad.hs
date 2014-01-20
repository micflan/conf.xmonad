import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Actions.Volume
import XMonad.Actions.CycleWS
import Data.Map    (fromList)
import Data.Monoid (mappend)
import System.IO

myManageHook = composeAll
    [ className =? "Gimp"      --> doFloat
    , className =? "Guake"      --> doFloat
    ]

main = do
    xmproc <- spawnPipe "/usr/bin/xmobar /home/michael/.xmobarrc"
    xmonad $ defaultConfig
        { manageHook = manageDocks <+> myManageHook
                        <+> manageHook defaultConfig
        , layoutHook = avoidStruts  $  layoutHook defaultConfig
        , focusedBorderColor = "#111774"
        , workspaces = ["1.browse", "2.work", "3.scratch", "4.comms", "5.music"] ++ map show [6..9]
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }
        , modMask = mod4Mask     -- Rebind Mod to the Windows key
        } `additionalKeys`
        [ ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
            , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
            , ((0, xK_Print), spawn "scrot")
            , ((mod4Mask, xK_KP_Multiply ), toggleMute    >> return ())
            , ((mod4Mask, xK_KP_Add ), raiseVolume 3 >> return ())
            , ((mod4Mask, xK_KP_Subtract ), lowerVolume 3 >> return ())
            , ((mod4Mask,               xK_Right),  nextWS)
            , ((mod4Mask,               xK_Left),    prevWS)
            , ((mod4Mask .|. shiftMask, xK_Right),  shiftToNext)
            , ((mod4Mask .|. shiftMask, xK_Left),    shiftToPrev)
            , ((mod4Mask,               xK_z),     toggleWS)
        ]
