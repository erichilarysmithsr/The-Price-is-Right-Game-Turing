setscreen ("graphics:640;480,nocursor")
var yoyoprice : real
var mw3price : real
var beatsprice : real
var soccerballprice : real
var higherorlower1 : string
var higherorlower2 : string
var higherorlower3 : string
var higherorlower4 : string

var shellgamebg : int
shellgamebg := Pic.FileNew ("shellgamebg.jpg")
Pic.Draw (shellgamebg, 0, 0, 2)

%Draw white box behind title logo.
drawfillbox (50, 400, 550, 475, 0)
drawbox (50, 400, 550, 475, 7)

var font20 : int
font20 := Font.New ("Berlin Sans FB Demi:50")
Font.Draw ("$hell Game!", 105, 420, font20, 53)

var shell : int
shell := Pic.FileNew ("shell.jpg")
Pic.Draw (shell, 490, 420, 2)

drawfillbox (100,200,200,300,0)
drawbox (100,200,200,300,7)

drawfillbox (200,300,300,200,0)
drawbox (200,300,300,200,7)

drawfillbox (300,200,400,300,0)
drawbox (300,200,400,300,7)

drawfillbox(400,300,500,200,0)
drawbox(400,300,500,200,7)


var yoyo : int
yoyo := Pic.FileNew ("yoyo.jpg")
Pic.Draw (yoyo, 110, 210, 2)


var beats : int
beats := Pic.FileNew ("beats.jpg")
Pic.Draw (beats, 210, 210, 2)


var mw3 : int
mw3 := Pic.FileNew ("mw3.jpg")
Pic.Draw (mw3, 310, 210, 2)


var soccerball: int
soccerball := Pic.FileNew ("soccerball.jpg")
Pic.Draw (soccerball, 410, 210, 2)

var font21 : int
font21 := Font.New ("Arial:15")

Font.Draw ("Yo-yo", 120, 340, font21, 7)
Font.Draw ("$0.99", 120, 315, font21, 7)

Font.Draw ("Dre Beats", 220, 340, font21, 7)
Font.Draw ("$499.99", 220, 315, font21, 7)

Font.Draw ("MW3", 330, 340, font21, 7)
Font.Draw ("$29.99", 320, 315, font21, 7)

Font.Draw ("2012 Euro", 420, 365, font21, 7)
Font.Draw ("Soccer-Ball", 415, 340, font21, 7)
Font.Draw ("$79.99", 425, 315, font21, 7)

drawfillbox (50,30,550,170,0)
drawbox (50,30,550,170,7)

