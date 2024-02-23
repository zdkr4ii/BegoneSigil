#SingleInstance Force
; A script to automatically sell low level sigils and trade the vouchers back for more sigils.
; Script automatically stops when there are no more valid sigils to sell/trade

; Preparations: 
; > Head to Siero > "Transmute Sigils" > Make sure you have "Level 3" Highlighted
; > Go back and Select "Trade Sigils" from "Knickknack vouchers" > Press Tab to open up the Sort page 
; > Navigate to the "Trade All" tab > Filter to your own choice 
; > Make sure you have the Equipped Tag not highlighted and that you are at the top of the filters list
; > Close the window with Right click so that you are back on the sigil list

;how long does it usually take for you to spend approx 999 vouchers? (in ms)
spamtime := 65000 ;varies depending on the machine/user 

;F1 to start the script
;Shift+Esc to stop and exit the script




; I AM NOT RESPONSIBLE OF THE LOSS OF ANY SIGILS YOU WANTED TO KEEP
; Save your game before running the .exe
; Use this script to your own discretion




shirtColor := 0xB3E9C7
BlueBox := 0x142742
CoordMode "Pixel", "Client"

;Main Loop
$F1::{
	loop{
		Trade()
		Gamba()
		Returntosell()
	}
}

; Trades a good chunk of your sigils to vouchers
Trade()
{
	SendEvent "{Tab down}"
	Sleep 250
	SendEvent "{Tab up}"
	Sleep 250
	SendInput "{3 down}"
	Sleep 250
	SendInput "{3 up}"
	Sleep 500
	
	;this part checks if there were any sigils to trade, if script fails to sell any, it will automatically exit the script
	if PixelSearch(&Px, &Py, 637, 678, 843, 694, BlueBox, 2)
	{
		ClearKeys()
		exitapp
	}

	SendInput "{w down}"
	sleep 250
	SendInput "{w up}"
	sleep 250
	SendEvent "{LButton Down}"
	Sleep 250
	SendEvent "{LButton up}"
	Sleep 250
	SendEvent "{LButton Down}"
	Sleep 250
	SendEvent "{LButton up}"
	Sleep 250
	SendInput "{s down}"
	sleep 250
	SendInput "{s up}"
	sleep 250
	SendEvent "{LButton Down}"
	Sleep 250
	SendEvent "{LButton up}"
	Sleep 250
	SendEvent "{LButton Down}"
	Sleep 250
	SendEvent "{LButton up}"
	Sleep 250
}

; Sigil Transmutation 
Gamba()
{
	SendEvent "{RButton Down}"
	Sleep 250
	SendEvent "{RButton up}"
	Sleep 250
	SendEvent "{RButton Down}"
	Sleep 250
	SendEvent "{RButton up}"
	Sleep 750
	SendInput "{s down}"
	sleep 250
	SendInput "{s up}"
	sleep 250
	SendEvent "{LButton Down}"
	Sleep 250
	SendEvent "{LButton up}"
	Sleep 250

	oT := A_TickCount
	loop
	{
		SpamLMB()
	} Until (A_TickCount - oT > spamtime)
	sleep 250
	
	ColorCheck := PixelGetColor(1441,712)
	if !(shirtColor = ColorCheck)
	{
		SendEvent "{LButton Down}"
		Sleep 250
		SendEvent "{LButton up}"
		Sleep 250
	}
	sleep 500
}

SpamLMB(){
	SendEvent "{LButton Down}"
	Sleep 20
	SendEvent "{LButton up}"
	sleep 20
}

; Goes back to trade the sigils after transmuting
Returntosell()
{
	SendEvent "{RButton Down}"
	Sleep 250
	SendEvent "{RButton up}"
	Sleep 500
	SendInput "{w down}"
	sleep 250
	SendInput "{w up}"
	sleep 250
	SendEvent "{LButton Down}"
	Sleep 250
	SendEvent "{LButton up}"
	Sleep 250
	SendEvent "{LButton Down}"
	Sleep 250
	SendEvent "{LButton up}"
	Sleep 250
}

ClearKeys(){
	SendInput "{w up}"
	Sleep 5
	SendInput "{s up}"
	Sleep 5
	SendEvent "{LButton up}"
	Sleep 5
	SendEvent "{RButton up}"
	Sleep 5
}

$+esc::{
	ClearKeys()
	exitapp
}