setscreen ("graphics:640;480,nocursor")

%Declare variables, any price variables should be real because cents.
var pptries : int
var gladbagprice : real
var canolaoilprice : real
var mascaraprice : real
var lintrollerprice : real
var tylenolprice : real
var macncheeseprice : real
var userpick1 : real
var userpick2 : real
var youwin : int

%Display instructions screen, let the user have enough time to read it.
var pickapairinstructions : int
pickapairinstructions := Pic.FileNew ("pickapairinstructions.jpg")
Pic.Draw (pickapairinstructions, 0, 0, 1)
delay (7000)

%Draw the background on which everything will be displayed.
cls
var pickapairbg : int
pickapairbg := Pic.FileNew ("pickapairbg.jpg")
Pic.Draw (pickapairbg, 0, 0, 1)

%Draw white box behind title logo.
drawfillbox (150, 380, 570, 470, 0)
drawbox (150, 380, 570, 470, 7)

%Declare any fonts that will be used throughout the game.
var font15 : int
font15 := Font.New ("Arial Black:10")
var font16 : int
font16 := Font.New ("Berlin Sans FB Demi:20")

%Draw the title.
var font14 : int
font14 := Font.New ("Berlin Sans FB Demi:50")
Font.Draw ("Pick a Pair!", 190, 400, font14, 54)

%White background behind items, or else the colour of the items will get corrupted.
drawfillbox (120, 42, 600, 120, 0)
drawbox (120, 41, 600, 120, 7)
%White background behind prices so when they need to be erased, they can be erased without taking the bg away.
drawfillbox (120, 120, 600, 155, 0)
drawbox (120, 120, 600, 155, 7)

%Draw the platforms on which the items will be displayed, put a black outline for each.
drawfillbox (200, 0, 120, 40, 54)
drawbox (200, 0, 120, 40, 7)
drawfillbox (280, 0, 200, 40, 44)
drawbox (280, 0, 200, 40, 7)
drawfillbox (280, 0, 360, 40, 26)
drawbox (280, 0, 360, 40, 7)
drawfillbox (360, 0, 440, 40, 54)
drawbox (360, 0, 440, 40, 7)
drawfillbox (440, 0, 520, 40, 44)
drawbox (440, 0, 520, 40, 7)
drawfillbox (520, 0, 600, 40, 26)
drawbox (520, 0, 600, 40, 7)

%Draw all the products.
var gladbags : int
gladbags := Pic.FileNew ("gladbags.jpg")
Pic.Draw (gladbags, 120, 44, 1)

var canolaoil : int
canolaoil := Pic.FileNew ("canolaoil.jpg")
Pic.Draw (canolaoil, 200, 42, 1)

var mascara : int
mascara := Pic.FileNew ("mascara.jpg")
Pic.Draw (mascara, 280, 41, 1)

var lintroller : int
lintroller := Pic.FileNew ("lintroller.jpg")
Pic.Draw (lintroller, 360, 41, 1)

var macandcheese : int
macandcheese := Pic.FileNew ("macandcheese.jpg")
Pic.Draw (macandcheese, 440, 41, 1)

var tylenol : int
tylenol := Pic.FileNew ("tylenol.jpg")
Pic.Draw (tylenol, 520, 41, 1)

%Label each one of the platforms with the names of the respective products.
Font.Draw ("Glad Bags", 122, 20, font15, 7)
Font.Draw ("Canola Oil", 202, 20, font15, 7)
Font.Draw ("Mascara", 282, 20, font15, 7)
Font.Draw ("Lint Roller", 362, 20, font15, 7)
Font.Draw ("Mac and", 442, 20, font15, 7)
Font.Draw ("Cheese", 442, 5, font15, 7)
Font.Draw ("Tylenol", 522, 20, font15, 7)

%Draw the message box in which I will ask/tell the user information.
drawfillbox (100, 200, 610, 350, 0)
drawbox (100, 200, 610, 349, 7)

%Tell user to go ahead and pick a pair by clicking on the colour palletes as a reminder.
Font.Draw ("Go Ahead, pick a pair", 110, 320, font16, 7)
Font.Draw ("by clicking on the palletes for each item.", 110, 290, font16, 7)
Font.Draw ("First click the item you want to match,", 110, 260, font16, 7)
Font.Draw ("then chose 2nd item with the same price.", 110, 230, font16, 7)



%Variables going to be used to leave the loops from which item 1 and item 2 will be selected.
%So user can go onto the next loop without an error.
var leaveloop1 : int
var leaveloop2 : int

%Set the variables for leaving the loop.
%Number of tries to 0 (pptries) they will max at 3, and youwin will be set to one when the two products = same price.
pptries := 0
youwin := 0

loop
    %Variables to initiatlize use of the mouse.
    var piXMOUSE, piYMOUSE, piBNUMVAR, piBUDVAR : int

    %Set leave loops in here so that if the first time the pair is incorrec then the loops can open up again.
    leaveloop1 := 0
    leaveloop2 := 0

    %Initialize first loop, wait for mouse to be up.
    loop
	Mouse.ButtonWait ("up", piXMOUSE, piYMOUSE, piBNUMVAR, piBUDVAR)
	%Put an if statement for each item pallete, within each one change the userpick price for product 1 to the price of the product.
	%As well as changing the userpick price display the price of the chosen object above its showcase square.
	%Put leaveloop to 1 so the loop can be exited, if a pallete isn't clicked then tell the user to pick one again.
	if piXMOUSE >= 120 and piXMOUSE < 200 and piYMOUSE >= 0 and piYMOUSE <= 40 then
	    Font.Draw ("$5.00", 122, 140, font15, 7)
	    userpick1 := 5.00
	    leaveloop1 := 1
	elsif piXMOUSE > 200 and piXMOUSE < 280 and piYMOUSE >= 0 and piYMOUSE <= 40 then
	    Font.Draw ("$4.00", 202, 140, font15, 7)
	    userpick1 := 4.00
	    leaveloop1 := 1
	elsif piXMOUSE > 280 and piXMOUSE < 360 and piYMOUSE >= 0 and piYMOUSE <= 40 then
	    Font.Draw ("$5.00", 282, 140, font15, 7)
	    userpick1 := 5.00
	    leaveloop1 := 1
	elsif piXMOUSE > 360 and piXMOUSE < 440 and piYMOUSE >= 0 and piYMOUSE <= 40 then
	    Font.Draw ("$4.00", 362, 140, font15, 7)
	    userpick1 := 4.00
	    leaveloop1 := 1
	elsif piXMOUSE > 440 and piXMOUSE < 520 and piYMOUSE >= 0 and piYMOUSE <= 40 then
	    Font.Draw ("$6.99", 442, 140, font15, 7)
	    userpick1 := 6.99
	    leaveloop1 := 1
	elsif piXMOUSE > 520 and piXMOUSE < 600 and piYMOUSE >= 0 and piYMOUSE <= 40 then
	    Font.Draw ("$6.99", 522, 140, font15, 7)
	    userpick1 := 6.99
	    leaveloop1 := 1
	else
	    Font.Draw ("Please click a colour pallete...", 120, 210, font15, 7)
	    delay (3000)
	    drawfillbox (120, 205, 380, 225, 0)
	end if
	%Leave the loop when a product has been chosen.
	exit when leaveloop1 = 1
    end loop

    %Put different mouse variables for the second loop.
    var ppiXMOUSE, ppiYMOUSE, ppiBNUMVAR, ppiBUDVAR : int

    %Initialize second loop, wait for mouse to be up.
    loop
	Mouse.ButtonWait ("up", ppiXMOUSE, ppiYMOUSE, ppiBNUMVAR, ppiBUDVAR)
	%Put an if statement for each item pallete, within each one change the userpick price for product 2 to the price of the product.
	%As well as changing the userpickprice for product 2 display the price of the chosen object above its showcase square.
	%Put leaveloop to 1 so the loop can be exited, if a pallete isn't clicked then tell the user to pick one again.
	if ppiXMOUSE >= 120 and ppiXMOUSE < 200 and ppiYMOUSE >= 0 and ppiYMOUSE <= 40 then
	    Font.Draw ("$5.00", 122, 140, font15, 7)
	    userpick2 := 5.00
	    leaveloop2 := 1
	elsif ppiXMOUSE > 200 and ppiXMOUSE < 280 and ppiYMOUSE >= 0 and ppiYMOUSE <= 40 then
	    Font.Draw ("$4.00", 202, 140, font15, 7)
	    userpick2 := 4.00
	    leaveloop2 := 1
	elsif ppiXMOUSE > 280 and ppiXMOUSE < 360 and ppiYMOUSE >= 0 and ppiYMOUSE <= 40 then
	    Font.Draw ("$5.00", 282, 140, font15, 7)
	    userpick2 := 5.00
	    leaveloop2 := 1
	elsif ppiXMOUSE > 360 and ppiXMOUSE < 440 and ppiYMOUSE >= 0 and ppiYMOUSE <= 40 then
	    Font.Draw ("$4.00", 362, 140, font15, 7)
	    userpick2 := 4.00
	    leaveloop2 := 1
	elsif ppiXMOUSE > 440 and ppiXMOUSE < 520 and ppiYMOUSE >= 0 and ppiYMOUSE <= 40 then
	    Font.Draw ("$6.99", 442, 140, font15, 7)
	    userpick2 := 6.99
	    leaveloop2 := 1
	elsif ppiXMOUSE > 520 and ppiXMOUSE < 600 and ppiYMOUSE >= 0 and ppiYMOUSE <= 40 then
	    Font.Draw ("$6.99", 522, 140, font15, 7)
	    userpick2 := 6.99
	    leaveloop2 := 1
	else
	    Font.Draw ("Please click a colour pallete...", 120, 210, font15, 7)
	    delay (3000)
	    drawfillbox (120, 205, 380, 225, 0)
	end if
	%Leave the loop when a product has been chosen.
	exit when leaveloop2 = 1
    end loop

    %Do calculations.
    %If the user's first product's price = the users second product's price then put you win on the screen.
    %Set youwin variable to 1 so that the outerloop can be exited, user has won.
    if userpick1 = userpick2 then
	drawfillbox (15, 60, 110, 120, 0)
	drawbox (15, 60, 110, 120, 7)
	Font.Draw ("You", 20, 100, font16, 7)
	Font.Draw ("Win!", 20, 70, font16, 7)
	youwin := 1
	%If the users first product doesn't equal the second product then display message saying not quite.
	%Add one to the try count, delay, then say try again.
    elsif userpick1 > userpick2 or userpick1 < userpick2 then
	drawfillbox (15, 60, 110, 120, 0)
	drawbox (15, 60, 110, 120, 7)
	Font.Draw ("Not", 20, 100, font16, 7)
	Font.Draw ("Quite.", 20, 70, font16, 7)
	pptries := pptries + 1
	delay (2000)
	drawfillbox (15, 60, 110, 120, 0)
	drawbox (15, 60, 110, 120, 7)
	drawfillbox (120, 120, 600, 155, 0)
	drawbox (120, 120, 600, 155, 7)
	Font.Draw ("Try", 20, 100, font16, 7)
	Font.Draw ("Again!", 20, 70, font16, 7)
    end if
    %Exit the program when the tries have reached limit, or use has won.
    exit when pptries = 3 or youwin = 1
end loop

%Determine the different types of winners and their winnings.
%If user got on 3rd try give them a ps3.
if pptries = 2 then
    delay (1000)
    cls
    Font.Draw ("You're going home with a PS3,", 100, 275, font16, 7)
    Font.Draw ("b/c you got it on your 3rd try!", 100, 250, font16, 7)
    var ps3 : int
    ps3 := Pic.FileNew ("ps3.jpg")
    Pic.Draw (ps3, 250, 40, 1)
    %If user got on second try give them a ps3.
elsif pptries = 1 then
    delay (1000)
    cls
    Font.Draw ("You're going home with a Sony TV,", 100, 275, font16, 7)
    Font.Draw ("b/c you got it on your 2nd try!", 100, 250, font16, 7)
    var sonytv : int
    sonytv := Pic.FileNew ("sonytv.jpg")
    Pic.Draw (sonytv, 250, 40, 1)
    %If user got on first try give them a car.
elsif pptries = 0 then
    delay (1000)
    cls
    Font.Draw ("You're going home with a CAR,", 100, 275, font16, 7)
    Font.Draw ("b/c you got it on your 1st try!!!", 100, 250, font16, 7)
    var car : int
    car := Pic.FileNew ("car.jpg")
    Pic.Draw (car, 250, 40, 1)
    %If user didn't get a pair at all, give them nothing.
elsif pptries = 3 then
    delay (1000)
    cls
    Font.Draw ("You're going home with nothing,", 100, 275, font16, 7)
    Font.Draw ("b/c you failed!", 100, 250, font16, 7)
end if
