%Set the graphics to 640 by 480.
setscreen ("graphics:640;480,nocursor")

%Declare Variables, prices should be real because cents.
var tries : int
var chewybarprice : real
var chipsahoyprice : real
var pastaprice : real
var quantity : int
var total : real
var userproduct : string
var userproductprice : real
var moveon : int
%Variables for bullseye game.
var target1 : int
var bullseyes, btries : int

%Variables for use of mouse.
var biXMOUSE, biYMOUSE, biBNUMVAR, biBUDVAR : int
var biXVALUE : int

%Assign values to integer or real numbers that will be used.
tries := 3
chewybarprice := 3.00
chipsahoyprice := 4.00
pastaprice := 2.00
target1 := 0
btries := 2
bullseyes := 0

%Display instructions screen, let the user have enough time to read it.
var bullseye1inst : int
bullseye1inst := Pic.FileNew ("bullseye1inst.jpg")
Pic.Draw (bullseye1inst, 0, 0, 1)
delay (10000)
cls
%Declare any fonts that will be used, and set them to desired style.
var font11 : int
font11 := Font.New ("Berlin Sans FB Demi:20")

var font12 : int
font12 := Font.New ("Arial:10")

var font13 : int
font13 := Font.New ("Berlin Sans FB Demi:15")

%Set blue striped background.
var bullseyebg : int
bullseyebg := Pic.FileNew ("bullseyebg.jpg")
Pic.Draw (bullseyebg, 0, 0, 1)

%Draw white box behind title logo.
drawfillbox (110, 380, 530, 470, 0)
drawbox (110, 380, 530, 470, 7)

%Draw Title.
var font10 : int
font10 := Font.New ("Berlin Sans FB Demi:50")
Font.Draw ("Bullseye!", 150, 400, font10, 12)
%Picture next to title.
var bullseye : int
bullseye := Pic.FileNew ("Bullseye.jpg")
Pic.Draw (bullseye, 420, 380, 1)
drawfillbox (150, 393, 420, 398, 12)

%Middle box platform for middle item.
drawfillbox (250, 0, 390, 40, 14)
drawbox (250, 0, 390, 40, 7)

%Left box platform for left item.
drawfillbox (250, 0, 110, 40, 54)
drawbox (250, 0, 110, 40, 7)

%Right box platform for right item.
drawfillbox (390, 40, 530, 0, 50)
drawbox (390, 40, 530, 0, 7)

%White background behind items, or else colour of pictures gets corrupted.
drawfillbox (110, 42, 530, 150, 0)
drawbox (110, 41, 530, 150, 7)

%Import/Draw: First item, second item, third item.
var chipsahoy : int
chipsahoy := Pic.FileNew ("chipsahoy.jpg")
Pic.Draw (chipsahoy, 270, 44, 1)

var chewy : int
chewy := Pic.FileNew ("chewybars.jpg")
Pic.Draw (chewy, 130, 42, 1)

var pasta : int
pasta := Pic.FileNew ("pasta.jpg")
Pic.Draw (pasta, 410, 41, 1)

%Draw the labels for each item, their names.
Font.Draw ("ChewyBars", 120, 20, font13, 7)
Font.Draw ("ChipsAhoy", 260, 20, font13, 7)
Font.Draw ("PrimoPasta", 410, 20, font13, 7)

%Initiatlize loop for game to begin.
loop
    %Draw a box to write instructions in.
    drawfillbox (50, 200, 590, 350, 0)
    drawbox (51, 201, 589, 349, 7)
    %Ask the user to enter the product they want to guess at.
    Font.Draw ("Enter the product of your choice:", 60, 325, font11, 7)
    Font.Draw ("(ChewyBars/ChipsAhoy/PrimoPasta)", 60, 305, font12, 7)

    %Initialize an inner loop for checking if the info is valid.
    loop
	%Get product.
	locate (10, 58)
	get userproduct
	%If the product is _____ then make the usersproductprice the chewybarprice for quantity check.
	%Enter the next step saying howmany of them will go into and 10 to 12 budget.
	%Set moveon to 1 so loop can be exited.
	if userproduct = "ChewyBars" or userproduct = "chewybars" then
	    userproductprice := chewybarprice
	    drawfillbox (50, 200, 590, 350, 0)
	    drawbox (51, 201, 589, 349, 7)
	    Font.Draw ("Howmany of those will go into $10-$12?", 60, 325, font11, 7)
	    moveon := 1

	elsif userproduct = "ChipsAhoy" or userproduct = "chipsahoy" then
	    userproductprice := chipsahoyprice
	    drawfillbox (50, 200, 590, 350, 0)
	    drawbox (51, 201, 589, 349, 7)
	    Font.Draw ("Howmany of those will go into $10-$12?", 60, 325, font11, 7)
	    moveon := 1

	elsif userproduct = "PrimoPasta" or userproduct = "primopasta" then
	    userproductprice := pastaprice
	    drawfillbox (50, 200, 590, 350, 0)
	    drawbox (51, 201, 589, 349, 7)
	    Font.Draw ("Howmany of those will go into $10-$12?", 60, 325, font11, 7)
	    moveon := 1
	    %If the user doesn't enter a valid choice then prompt him/her saying that you need to chose from the choices listed.
	    %Continue loop untill the product is valid.
	else
	    Font.Draw ("That is not a valid choice.", 60, 285, font12, 7)
	    Font.Draw ("Please re-enter a choice from above.", 60, 270, font12, 7)
	    drawfillbox (455, 300, 580, 345, 0)
	    moveon := 0
	end if
	exit when moveon = 1
    end loop

    %Now get the quantity to howmany can go in 10 and 12 dollars.
    locate (11, 10)
    get quantity
    %Calculate the if the user is correct, that the quantity they entered does go into $10-$12.
    total := quantity * userproductprice

    %If they are correct then...
    if total >= 10 and total <= 12 then
	%Go into second part of game, introduce the instructions saying you will have to do so and so, give them time to read.
	cls
	var bullseyeinstructions : int
	bullseyeinstructions := Pic.FileNew ("bullseyeinstructions.jpg")
	Pic.Draw (bullseyeinstructions, 0, 0, 1)
	delay (7000)
	cls
	%Loop the targets, draw a scoreboard in the top left, if the user hits target then add one to it.
	Font.Draw ("Score: " + intstr (bullseyes), 10, 460, font11, 7)
	%Used so that it doesnt show up again.
	%Draw target.
	drawfilloval (100, 100, 50, 50, 12)
	drawfilloval (100, 100, 35, 35, 31)
	drawfilloval (100, 100, 20, 20, 12)
	drawfilloval (100, 100, 5, 5, 31)
	delay (2000)
	drawfilloval (100, 100, 50, 50, 0)
	%Wait for user to click down.
	Mouse.ButtonWait ("down", biXMOUSE, biYMOUSE, biBNUMVAR, biBUDVAR)
	%If the user hits in the location then add one point, if not then take away one try.
	if biXMOUSE >= 50 and biXMOUSE <= 150 and biYMOUSE >= 50 and biYMOUSE <= 150 then
	    bullseyes := bullseyes + 1
	    drawfillbox (0, 455, 100, 480, 0)
	    Font.Draw ("Score: " + intstr (bullseyes), 10, 460, font11, 7)
	    btries := btries - 1
	else
	    btries := btries - 1
	end if
	%Once the user is done with target one then draw target two, let it appear for 2 seconds.
	drawfilloval (400, 300, 50, 50, 12)
	drawfilloval (400, 300, 35, 35, 31)
	drawfilloval (400, 300, 20, 20, 12)
	drawfilloval (400, 300, 5, 5, 31)
	delay (2000)
	drawfilloval (400, 300, 50, 50, 0)
	%Wait for user to click down.
	Mouse.ButtonWait ("down", biXMOUSE, biYMOUSE, biBNUMVAR, biBUDVAR)
	%If the user clicked in the bullseye spot then add one point, if not takeaway one try.
	if biXMOUSE >= 350 and biXMOUSE <= 450 and biYMOUSE >= 250 and biYMOUSE <= 350 then
	    bullseyes := bullseyes + 1
	    drawfillbox (0, 455, 100, 480, 0)
	    Font.Draw ("Score: " + intstr (bullseyes), 10, 460, font11, 7)
	    btries := btries - 1
	else
	    btries := btries - 1
	end if
	%If the use didn't get the quantity of the product correct then, re-draw the message box saying not quite.
    else
	drawfillbox (50, 200, 590, 350, 0)
	drawbox (51, 201, 589, 349, 7)
	Font.Draw ("Not Quite!", 60, 320, font11, 7)
	delay (1000)
    end if

    %Take away one try at guessing the quantities.
    tries := tries - 1
    %Leave the program if the tries are up.
    exit when tries = 0 or btries = 0
end loop

%Determine the different types of winners.
%If user didn't even get past quantity stage then give them nothing.
if tries = 0 then
    delay (1000)
    drawfillbox (0, 0, 640, 480, 52)
    drawfillbox (50, 200, 590, 350, 0)
    drawbox (51, 201, 589, 349, 7)
    Font.Draw ("You Lose!", 250, 275, font11, 7)
    Font.Draw ("You win nothing!", 245, 255, font11, 7)
    %If user got to bullseye stage and hit one of them give them an xbox 360.
elsif bullseyes = 1 then
    delay (1000)
    cls
    Font.Draw ("You're going home with an Xbox 360,", 100, 275, font11, 7)
    Font.Draw ("You Hit atleast 1 out of the two targets,", 100, 250, font11, 7)
    Font.Draw ("and made it past the first stage!", 100, 225, font11, 7)
    var xbox : int
    xbox := Pic.FileNew ("xbox360.jpg")
    Pic.Draw (xbox, 250, 40, 1)
    %If user got to bullseye stage and hit both of the targets give them an rolex watch.
elsif bullseyes = 2 then
    delay (1000)
    cls
    Font.Draw ("You're going home with an rolex watch,", 100, 275, font11, 7)
    Font.Draw ("You Hit atleast both of the targets,", 100, 250, font11, 7)
    Font.Draw ("and made it past the first stage!", 100, 225, font11, 7)
    var rolex : int
    rolex := Pic.FileNew ("rolex.jpg")
    Pic.Draw (rolex, 250, 40, 1)
    %If user got past the quantity stage but didnt get a target then give them an ipod touch.
elsif tries > 0 and bullseyes = 0 then
    delay (1000)
    cls
    Font.Draw ("You're going home with an ipod touch", 100, 275, font11, 7)
    Font.Draw ("Because you atleast got past the first stage!", 100, 250, font11, 7)
    var ipodtouch : int
    ipodtouch := Pic.FileNew ("ipod.jpg")
    Pic.Draw (ipodtouch, 250, 40, 1)
end if


