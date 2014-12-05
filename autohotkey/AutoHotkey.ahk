; This script has a special filename and path because it is automatically
; launched when you run the program directly.
; This file is located by default @ C:\Users\<UserName>\Documents (Windows 8/7?)

; Legend of characters representing keys
; ^ : Ctrl
; # : Win
; ! : Alt
; + : Shift

; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Execute Emacs
; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
^+E::
  IfWinExist ahk_class Emacs
    WinActivate
  else
    Run runemacs ;; Emacs must be in %PATH%
  return

; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Set active window as "Always on Top"
; And remove active window title bar.
; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
^*:: Winset, Alwaysontop, , A
^(:: WinSet, Style, -0xC00000, A

; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Volume control
; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
F6:: Send {Volume_Mute}
F7:: SoundSet -10
F8:: SoundSet +10