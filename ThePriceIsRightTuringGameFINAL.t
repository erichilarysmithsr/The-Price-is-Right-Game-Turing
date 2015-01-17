%$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%                                                                          $
% Name:  <Jitin Dodd>                                                      $
% Purpose:  To write the program that resembles The Price is Right TV Show.$
% File name:  The Price is Right                                           $
%                                                                          $
%$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

%Set process for music, so it can be forked.
process music
    Music.PlayFile ("themesong.mp3")
end music

%Set screen graphics to 640 by 480 pixels.
setscreen ("graphics:640;480,nocursor")

%Declare all variables.
var username : string
var proceed : int
var userguess : int
var comp1guess : int
var comp2guess : int
var comp3guess : int
var userdifference : int
var comp1difference : int
var comp2difference : int
var comp3difference : int
var productnumb : int
var productrand : int
var loadingcount : int
var productprice : int
var minigame : int
var flag1, flag2, flag3, flag4, flag5, flag6 : int

%Initiate variables to starting values, start randomizer.
proceed := 0
productrand := 0
productnumb := 0
loadingcount := 0
flag1 := 0
flag2 := 0
flag3 := 0
flag4 := 0
flag5 := 0
flag6 := 0
randomize

%Initiate variables for all of the fonts.
var font4 : int
font4 := Font.New ("Arial:20")
var font3 : int
font3 := Font.New ("Berlin Sans FB Demi:20")
var font5 : int
font5 := Font.New ("Berlin Sans FB Demi:40")
var font6 : int
font6 := Font.New ("Arial:20")
var font7 : int
font7 := Font.New ("Arial:10")
var font8 : int
font8 := Font.New ("Arial:20")
var font9 : int
font9 := Font.New ("Arial:42")

%Display title screen.
var logo : int
logo := Pic.FileNew ("titlescreen...jpg")
Pic.Draw (logo, 0, 0, 1)

var iXMOUSE, iYMOUSE, iBNUMVAR, iBUDVAR : int % variables for use of mouse

%Draw boxes around Start and Instructions buttons to find out where to click for mouse commands.
drawbox (145, 5, 264, 79, 7)
drawbox (265, 5, 465, 79, 7)

loop
    %Play file.
    fork music

    %Wait for user to select (click) with the mouse
    Mouse.ButtonWait ("down", iXMOUSE, iYMOUSE, iBNUMVAR, iBUDVAR)

    %If the clicked play:
    if iXMOUSE >= 145 and iXMOUSE <= 264 and iYMOUSE >= 5 and iYMOUSE <= 79 then
	%Erase anything previously on the screen then draw fill for background.
	cls
	drawfill (1, 1, 79, 7)
	%Display message saying, "Come on Down! You're the next contestant on the price is right."
	Font.Draw ("Come on Down! You're the", 10, 350, font5, 7)
	Font.Draw ("next contestsant on", 120, 280, font5, 7)
	Font.Draw ("the Price is right!", 130, 210, font5, 7)

	%Create a loadup bar under the message by drawing and erasing dots to make it look like it's loading.
	%Exit when it has done the full rotation 3 times.
	loop
	    Font.Draw ("Loading...", 280, 150, font6, 79)
	    Font.Draw ("Loading.", 280, 150, font6, 7)
	    delay (500)
	    Font.Draw ("Loading..", 280, 150, font6, 7)
	    delay (500)
	    Font.Draw ("Loading...", 280, 150, font6, 7)
	    delay (500)
	    loadingcount := loadingcount + 1
	    exit when loadingcount = 3 %Fix to three when done game.
	end loop

	%Set background for game screen.
	var mypic : int
	mypic := Pic.FileNew ("GameScreen.jpg")
	Pic.Draw (mypic, 0, 0, 2)

	%Draw a whitebox with a border outline to gather information from the user.
	%This will be used because the text can be visible, and not over the picture.
	drawfillbox (10, 470, 630, 370, 0)
	drawbox (11, 469, 629, 371, 7)

	%Initiatiate loop to gather users initials, and check for mistakes: Name might not fit into the tag.
	loop
	    %Get the useres initials, locate the get statement inside the white box.
	    Font.Draw ("Enter your initials:", 20, 445, font3, 7)
	    locate (2, 32)
	    get username

	    %If the user entered more than 4 letters than make them re-enter it.
	    if length (username) >= 5 then

		Font.Draw ("Sorry that's too long,", 350, 445, font7, 7)
		Font.Draw ("please re-enter your intials,", 350, 430, font7, 7)
		Font.Draw ("maximum # of characters is 4.", 350, 415, font7, 7)
		drawfillbox (240, 465, 340, 373, 0)
	    else
		%If they entered correctly, let them proceed.
		proceed := proceed + 1
	    end if
	    exit when proceed = 1
	end loop

	%Initiate loop for the products.
	loop

	    %Draw over everything with the background and name so that the white message box goes away.
	    mypic := Pic.FileNew ("GameScreen.jpg")
	    Pic.Draw (mypic, 0, 0, 2)
	    Font.Draw (username, 55, 115, font4, 7)

	    %Draw a banner which will introduce each product.
	    %To draw product sign - mid rectangle.
	    drawline (230, 380, 410, 380, 7)
	    drawline (230, 420, 410, 420, 7)
	    %Triangles on product sign.
	    drawline (230, 380, 200, 400, 7)
	    drawline (230, 420, 200, 400, 7)
	    drawline (410, 420, 440, 400, 7)
	    drawline (410, 380, 440, 400, 7)
	    drawfill (380, 400, 0, 7)
	    %Draw lines connecting to edges.
	    Draw.ThickLine (440, 400, 640, 400, 3, 0)
	    Draw.ThickLine (200, 400, 0, 400, 3, 0)

	    %Randomize integer which will be used to pick a product.
	    randint (productrand, 1, 6)
	    %Variables used to determine wether a product has already been randomized and picked.
	    productprice := 0
	    %Add one to the product counter so that it will be showed in the banner.
	    %As well as keep track of howmany products have gone by.

	    %If the randomized product number is ___ and the flag is still open then draw "Product _" in banner.
	    %Then 2 seconds later display product in a box in the centre of the screen.
	    if productrand = 1 and flag1 = 0 then
		%Add one to the total product count.
		productnumb := productnumb + 1
		%Make flag1 = 1 so that this product cannot be picked again.
		flag1 := 1
		Font.Draw ("Product " + intstr (productnumb), 260, 390, font8, 7)
		%Put a 2 second delay before the product shows up.
		delay (2000)
		%Redraw over everything so that banner goes away.
		Pic.Draw (mypic, 0, 0, 2)
		Font.Draw (username, 55, 115, font4, 7)
		%Draw box that will be under the product picture.
		drawfillbox (220, 320, 420, 460, 0)
		drawbox (221, 321, 419, 459, 7)
		%Draw product.
		var toaster : int
		toaster := Pic.FileNew ("toaster.jpg")
		Pic.Draw (toaster, 250, 322, 2)
		%Show it for 3 seconds then move on to next section.
		delay (3000)
		%Re-draw over everything again so that the product showcase goes away, draw the message box again.
		Pic.Draw (mypic, 0, 0, 2)
		Font.Draw (username, 55, 115, font4, 7)

		drawfillbox (10, 470, 630, 370, 0)
		drawbox (11, 469, 629, 371, 7)

		%Introduce product and ask the user to enter the price.
		Font.Draw ("It's a Black & Decker Stainless Steel Toaster!", 20, 445, font3, 7)
		Font.Draw ("Enter the Price of this product:", 20, 415, font3, 7)
		%Set productprice to the price of the product.
		productprice := 40
		%Ask the user what they think the price of the product is.
		locate (4, 50)
		get userguess
		%Randomize the computers guesses, keep them reasonable.
		randint (comp1guess, 1, 150)
		randint (comp2guess, 1, 150)
		randint (comp3guess, 1, 150)

		%Output all the guesses on the game screen in the box
		Font.Draw (intstr (userguess), 21, 45, font9, 7)
		Font.Draw (intstr (comp1guess), 180, 45, font9, 7)
		Font.Draw (intstr (comp2guess), 336, 45, font9, 7)
		Font.Draw (intstr (comp3guess), 494, 45, font9, 7)

		Font.Draw ("The actual price of the Toaster is $40!", 20, 385, font3, 7)

		delay (5000)

		%If the randomized product number is ___ then white "Product _" in banner.
		%Then 2 seconds later display product in a box in the centre of the screen.
		%Do the same for product 2.
	    elsif productrand = 2 and flag2 = 0 then
		productnumb := productnumb + 1
		flag2 := 1
		Font.Draw ("Product " + intstr (productnumb), 260, 390, font8, 7)

		delay (2000)

		Pic.Draw (mypic, 0, 0, 2)
		Font.Draw (username, 55, 115, font4, 7)

		drawfillbox (220, 320, 420, 460, 0)
		drawbox (221, 321, 419, 459, 7)

		var treadmill : int
		treadmill := Pic.FileNew ("treadmill.jpg")
		Pic.Draw (treadmill, 250, 322, 2)

		delay (3000)

		Pic.Draw (mypic, 0, 0, 2)
		Font.Draw (username, 55, 115, font4, 7)

		drawfillbox (10, 470, 630, 370, 0)
		drawbox (11, 469, 629, 371, 7)

		Font.Draw ("It's Weslo Crosswalk Treadmill!", 20, 445, font3, 7)
		Font.Draw ("Enter the Price of this product:", 20, 415, font3, 7)
		productprice := 380
		locate (4, 50)
		get userguess

		randint (comp1guess, 100, 600)
		randint (comp2guess, 100, 600)
		randint (comp3guess, 100, 600)


		Font.Draw (intstr (userguess), 21, 45, font9, 7)
		Font.Draw (intstr (comp1guess), 180, 45, font9, 7)
		Font.Draw (intstr (comp2guess), 336, 45, font9, 7)
		Font.Draw (intstr (comp3guess), 494, 45, font9, 7)

		Font.Draw ("The actual price of the Treadmill is $380!", 20, 385, font3, 7)

		delay (5000)

		%If the randomized product number is ___ then white "Product _" in banner.
		%Then 2 seconds later display product in a box in the centre of the screen.
		%Do the same for product 3.
	    elsif productrand = 3 and flag3 = 0 then
		productnumb := productnumb + 1
		flag3 := 1
		Font.Draw ("Product " + intstr (productnumb), 260, 390, font8, 7)

		delay (2000)

		Pic.Draw (mypic, 0, 0, 2)
		Font.Draw (username, 55, 115, font4, 7)

		drawfillbox (220, 320, 420, 460, 0)
		drawbox (221, 321, 419, 459, 7)

		var tv : int
		tv := Pic.FileNew ("tv.jpg")
		Pic.Draw (tv, 250, 322, 2)

		delay (3000)

		Pic.Draw (mypic, 0, 0, 2)
		Font.Draw (username, 55, 115, font4, 7)

		drawfillbox (10, 470, 630, 370, 0)
		drawbox (11, 469, 629, 371, 7)

		Font.Draw ("It's a LG 47 inch 1080p LED TV!", 20, 445, font3, 7)
		Font.Draw ("Enter the Price of this product:", 20, 415, font3, 7)
		productprice := 700
		locate (4, 50)
		get userguess

		randint (comp1guess, 400, 999)
		randint (comp2guess, 400, 999)
		randint (comp3guess, 400, 999)


		Font.Draw (intstr (userguess), 21, 45, font9, 7)
		Font.Draw (intstr (comp1guess), 180, 45, font9, 7)
		Font.Draw (intstr (comp2guess), 336, 45, font9, 7)
		Font.Draw (intstr (comp3guess), 494, 45, font9, 7)

		Font.Draw ("The actual price of the T.V. is $700!", 20, 385, font3, 7)

		delay (5000)

		%If the randomized product number is ___ then white "Product _" in banner.
		%Then 2 seconds later display product in a box in the centre of the screen.
		%Do the same for product 4.
	    elsif productrand = 4 and flag4 = 0 then
		productnumb := productnumb + 1
		flag4 := 1
		Font.Draw ("Product " + intstr (productnumb), 260, 390, font8, 7)

		delay (2000)

		Pic.Draw (mypic, 0, 0, 2)
		Font.Draw (username, 55, 115, font4, 7)

		drawfillbox (220, 320, 420, 460, 0)
		drawbox (221, 321, 419, 459, 7)

		var Vaccum : int
		Vaccum := Pic.FileNew ("Vaccum.jpg")
		Pic.Draw (Vaccum, 250, 322, 2)

		delay (3000)

		Pic.Draw (mypic, 0, 0, 2)
		Font.Draw (username, 55, 115, font4, 7)

		drawfillbox (10, 470, 630, 370, 0)
		drawbox (11, 469, 629, 371, 7)

		Font.Draw ("It's a Dirt Devil Total Vision Vacuum!", 20, 445, font3, 7)
		Font.Draw ("Enter the Price of this product:", 20, 415, font3, 7)
		productprice := 90
		locate (4, 50)
		get userguess

		randint (comp1guess, 1, 200)
		randint (comp2guess, 1, 200)
		randint (comp3guess, 1, 200)


		Font.Draw (intstr (userguess), 21, 45, font9, 7)
		Font.Draw (intstr (comp1guess), 180, 45, font9, 7)
		Font.Draw (intstr (comp2guess), 336, 45, font9, 7)
		Font.Draw (intstr (comp3guess), 494, 45, font9, 7)

		Font.Draw ("The actual price of the Vacuum is $90!", 20, 385, font3, 7)

		delay (5000)

		%If the randomized product number is ___ then white "Product _" in banner.
		%Then 2 seconds later display product in a box in the centre of the screen.
		%Do the same for product 5.
	    elsif productrand = 5 and flag5 = 0 then
		productnumb := productnumb + 1
		flag5 := 1
		Font.Draw ("Product " + intstr (productnumb), 260, 390, font8, 7)

		delay (2000)

		Pic.Draw (mypic, 0, 0, 2)
		Font.Draw (username, 55, 115, font4, 7)

		drawfillbox (220, 320, 420, 460, 0)
		drawbox (221, 321, 419, 459, 7)

		var camera : int
		camera := Pic.FileNew ("camera.jpg")
		Pic.Draw (camera, 250, 322, 2)

		delay (3000)

		Pic.Draw (mypic, 0, 0, 2)
		Font.Draw (username, 55, 115, font4, 7)

		drawfillbox (10, 470, 630, 370, 0)
		drawbox (11, 469, 629, 371, 7)

		Font.Draw ("It's a Canon PowerShot A2200 Digital Camera!", 20, 445, font3, 7)
		Font.Draw ("Enter the Price of this product:", 20, 415, font3, 7)
		productprice := 130
		locate (4, 50)
		get userguess

		randint (comp1guess, 1, 300)
		randint (comp2guess, 1, 300)
		randint (comp3guess, 1, 300)


		Font.Draw (intstr (userguess), 21, 45, font9, 7)
		Font.Draw (intstr (comp1guess), 180, 45, font9, 7)
		Font.Draw (intstr (comp2guess), 336, 45, font9, 7)
		Font.Draw (intstr (comp3guess), 494, 45, font9, 7)

		Font.Draw ("The actual price of the Camera is $130!", 20, 385, font3, 7)

		delay (5000)

		%If the randomized product number is ___ then white "Product _" in banner.
		%Then 2 seconds later display product in a box in the centre of the screen.
		%Do the same for product 6.
	    elsif productrand = 6 and flag6 = 0 then
		productnumb := productnumb + 1
		flag6 := 1

		Font.Draw ("Product " + intstr (productnumb), 260, 390, font8, 7)

		delay (2000)

		Pic.Draw (mypic, 0, 0, 2)
		Font.Draw (username, 55, 115, font4, 7)

		drawfillbox (220, 320, 420, 460, 0)
		drawbox (221, 321, 419, 459, 7)

		var GPS : int
		GPS := Pic.FileNew ("GPS.jpg")
		Pic.Draw (GPS, 250, 322, 2)

		delay (3000)

		Pic.Draw (mypic, 0, 0, 2)
		Font.Draw (username, 55, 115, font4, 7)

		drawfillbox (10, 470, 630, 370, 0)
		drawbox (11, 469, 629, 371, 7)

		Font.Draw ("It's a TomTom GO 2405 GPS!", 20, 445, font3, 7)
		Font.Draw ("Enter the Price of this product:", 20, 415, font3, 7)
		productprice := 180
		locate (4, 50)
		get userguess

		randint (comp1guess, 10, 400)
		randint (comp2guess, 10, 400)
		randint (comp3guess, 10, 400)


		Font.Draw (intstr (userguess), 21, 45, font9, 7)
		Font.Draw (intstr (comp1guess), 180, 45, font9, 7)
		Font.Draw (intstr (comp2guess), 336, 45, font9, 7)
		Font.Draw (intstr (comp3guess), 494, 45, font9, 7)

		Font.Draw ("The actual price of the GPS is $180!", 20, 385, font3, 7)

		delay (5000)
	    end if

	    %Calculate the difference of users guess and products actual price.
	    if userguess > productprice then
		userdifference := userguess - productprice
	    else
		userdifference := productprice - userguess
	    end if

	    %Calculate the difference of computer 1's guess and products actual price.
	    if comp1guess > productprice then
		comp1difference := comp1guess - productprice
	    else
		comp1difference := productprice - comp1guess
	    end if

	    %Calculate the difference of computer 2's guess and products actual price.
	    if comp2guess > productprice then
		comp2difference := comp2guess - productprice
	    else
		comp2difference := productprice - comp2guess
	    end if

	    %Calculate the difference of computer 3's guess and products actual price.
	    if comp3guess > productprice then
		comp3difference := comp3guess - productprice
	    else
		comp3difference := productprice - comp3guess
	    end if

	    %Determine if users difference is the smallest from all of them, if yes then...
	    if userdifference < comp1difference and userdifference < comp2difference and userdifference < comp3difference then
		%Randomize a mini game for the user to play.
		randomize
		randint (minigame, 1, 2)

		%If the random minigame = 1 then initiate Bullseye.
		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		if minigame = 1 then
		    cls
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
			delay (5000)
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
			delay (5000)
			%If user got to bullseye stage and hit both of the targets give them an rolex watch.
		    elsif bullseyes = 2 then
			delay (1000)
			cls
			Font.Draw ("You're going home with an rolex watch,", 100, 275, font11, 7)
			Font.Draw ("You Hit both of the targets,", 100, 250, font11, 7)
			Font.Draw ("and made it past the first stage!", 100, 225, font11, 7)
			var rolex : int
			rolex := Pic.FileNew ("rolex.jpg")
			Pic.Draw (rolex, 250, 40, 1)
			delay (5000)
			%If user got past the quantity stage but didnt get a target then give them an ipod touch.
		    elsif tries > 0 and bullseyes = 0 then
			delay (1000)
			cls
			Font.Draw ("You're going home with an ipod touch", 100, 275, font11, 7)
			Font.Draw ("Because you atleast got past the first stage!", 100, 250, font11, 7)
			var ipodtouch : int
			ipodtouch := Pic.FileNew ("ipod.jpg")
			Pic.Draw (ipodtouch, 250, 40, 1)
			delay (5000)
		    end if

		    %If the random minigame = 2 then initiate Pick-a-Pair.
		    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		elsif minigame = 2 then
		    cls
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
			delay (5000)
			%If user got on second try give them a ps3.
		    elsif pptries = 1 then
			delay (1000)
			cls
			Font.Draw ("You're going home with a Sony TV,", 100, 275, font16, 7)
			Font.Draw ("b/c you got it on your 2nd try!", 100, 250, font16, 7)
			var sonytv : int
			sonytv := Pic.FileNew ("sonytv.jpg")
			Pic.Draw (sonytv, 250, 40, 1)
			delay (5000)
			%If user got on first try give them a car.
		    elsif pptries = 0 then
			delay (1000)
			cls
			Font.Draw ("You're going home with a CAR,", 100, 275, font16, 7)
			Font.Draw ("b/c you got it on your 1st try!!!", 100, 250, font16, 7)
			var car : int
			car := Pic.FileNew ("car.jpg")
			Pic.Draw (car, 250, 40, 1)
			delay (5000)
			%If user didn't get a pair at all, give them nothing.
		    elsif pptries = 3 then
			delay (1000)
			cls
			Font.Draw ("You're going home with nothing,", 100, 275, font16, 7)
			Font.Draw ("b/c you failed!", 100, 250, font16, 7)
			delay (5000)
		    end if
		    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		    %Back to Main Game
		  end if  %If the usersdifference was not the smallest then put a screen saying we have skipped computers turn.
		elsif userdifference > comp1difference or userdifference > comp2difference or userdifference > comp3difference then
		    cls
		    Font.Draw ("Since computer was the closest,", 20, 340, font3, 7)
		    Font.Draw ("We have skipped it's turn.", 20, 320, font3, 7)
		    delay (5000)
		    %If the usersdifference equal to any of the computers then say it was a tie and mini-game was skipped.
		elsif userdifference = comp1difference or userdifference = comp2difference or userdifference = comp3difference then
		    Font.Draw ("It was a tie, no mini-game!", 20, 320, font3, 7)
		    delay (5000)
		end if
	    %end if
	    %Leave the loop or exit the game when 3 products have been displayed.
	    exit when productnumb = 3
	end loop

	%Else if the user clicked on the instructions button then display intsructions.
    elsif iXMOUSE >= 265 and iXMOUSE <= 465 and iYMOUSE >= 5 and iYMOUSE <= 79 then
	%Show instructions.
	var maininstructions : int
	maininstructions := Pic.FileNew ("maininstructions.jpg")
	Pic.Draw (maininstructions, 0, 0, 2)
	%Create a play button.
	drawfillbox (145, 5, 264, 79, 0)
	drawbox (145, 5, 264, 79, 7)
	Font.Draw ("Play", 170, 30, font3, 7)
    end if
    exit when productnumb = 3
end loop

%Final message.
cls
Font.Draw ("Thats all for Today,", 30, 280, font5, 7)
Font.Draw ("Thanks for Playing!", 30, 240, font5, 7)




