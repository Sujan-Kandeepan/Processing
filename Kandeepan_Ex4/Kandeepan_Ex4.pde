/*
Sujan Kandeepan - "Alphabet Soup" (delicious)
Exercise 4 - Tutorial 08, TA: Grant Holt

Note: program may begin to slow down/lag if too many letters are drawn at once,
a simple fix is to clear the array list (spacebar) to take some load off the CPU.
*/

//global variable declarations
ArrayList letters = new ArrayList(); /*array list (non-fixed size) to store all letters,
                                       used so that letters are preserved even with redrawn background*/
boolean firstKeyPressed = false; //boolean for whether a key was pressed the first time to exit start screen
char typed = Character.toUpperCase (key); //records characters typed and converts letters to uppercase
color beet = color (155, 0, 75), //beet colour (purple/magenta)
      background = color (153, 0, 0), //background colour (tomato by default, changes with number key presses)
      broccoli = color (180, 215, 140), //broccoli colour (light green)
      broth = color (180, 110, 0), //broth colour (brown, slightly orange)
      carrot = color (255, 128, 0), //carrot colour (orange)
      fish = color (255, 160, 135), //fish colour (pink, slightly orange)
      mushroom = color (210, 195, 175), //mushroom colour (light grey)
      pasta = color (255, 222, 173), //pasta colour (beige, used for letters)
      ramen = color (130, 40, 0), //ramen colour (dark red/brown)
      rawon = color (70, 60, 25), //rawon colour (dark green, slightly brown)
      shrimp = color (250, 175, 70), //shrimp colour (dull orange/yellow)
      tomato = color (153, 0, 0); //tomato colour (slightly dark red)
float angle, x, y; //angle at which letters are rotated, (x, y) coordinates for position on canvas
String flavour = "tomato"; //message indicating soup flavour (tomato by default, changes with number key presses)

//setup() method for initial state and values
void setup()
{
  //window setup
  size (960, 720); //canvas size 960x720 (720p, 4:3)
  background (tomato); //default background colour is tomato
  smooth(); //smoother edges/higher resolution for text and shapes
  
  //start screen - title
  textFont (createFont ("Sitka Small Bold", 100)); //entire program uses Sitka Small Bold font, title is 100pt
  textAlign (CENTER, CENTER); //align text to centre horizontally and vertically
  fill (pasta); //text fill colour is pasta, as in letters found in alphabet soup
  fill (red (background) - 75, green (background) - 75, blue (background) - 75); /*change fill colour to darker
                                                                                   shade of background colour*/
  textOutline ("ALPHABET SOUP", 480, 300, 2); //draw title outline using created textOutline() method
  fill (pasta); //change fill colour back to pasta
  text ("ALPHABET SOUP", 480, 300); //display title in middle of canvas
  
  //start screen - subtitle
  textSize (35); //decrease text size to 35pt
  fill (red (background) - 75, green (background) - 75, blue (background) - 75); /*change fill colour to darker
                                                                                   shade of background colour*/
  textOutline ("Begin typing letters to add them to the soup", 480, 400, 2); //draw subtitle outline using created textOutline() method
  fill (pasta); //change fill colour back to pasta
  text ("Begin typing letters to add them to the soup", 480, 400); //display subtitle directly below title
  
  //start screen - prompt to continue
  textSize (25); //decrease text size to 25pt
  fill (red (background) - 75, green (background) - 75, blue (background) - 75); /*change fill colour to darker
                                                                                   shade of background colour*/
  textOutline ("Press any key to continue", 480, 600, 2); //draw continue prompt outline using created textOutline() method
  fill (pasta); //change fill colour back to pasta
  text ("Press any key to continue", 480, 600); // display prompt to continue at bottom centre of canvas
  
  //letters to be drawn later
  textSize (100); //increase text size to 100pt
}

//draw() method for interactivity and dynamic events
void draw()
{
  //always fill background after start screen cleared
  if (firstKeyPressed)
  {
    //canvas background
    background (background); //apply last saved background colour
    
    //top bar on which heads-up display text lies
    fill (red (background) - 75, green (background) - 75, blue (background) - 75); /*change fill colour to darker
                                                                                     shade of background colour*/
    rect (0, 0, 960, 75); //draw rectangle along top edge, spans width of canvas and is just tall enough to fit text
    
    //soup flavour display
    fill (background); //change fill colour back to normal shade of background colour
    textAlign (LEFT, CENTER); //left horizontal text alignment
    textSize (36); //decrease text size to 36pt
    text ("Flavour: " + flavour, 10, 32); //display flavour on left side of heads-up display
    
    //prompt to change soup flavour using number keys or clear letters from soup using spacebar
    textAlign(RIGHT, CENTER); //right horizontal text alignment
    textSize(24); //decrease text size to 24pt
    text("Press number keys to change soup flavour", 950, 20); /*display prompt to change soup flavour using
                                                                 number keys at top right of heads-up display*/
    text("Clear letters from soup using spacebar", 950, 50); /*display prompt to clear letters from soup using
                                                               spacebar at bottom right of heads-up display*/
    textAlign (CENTER, CENTER); //re-align text to centre horizontally and vertically
  }
  
  //displaying letters - letters appear anywhere on canvas without touching edges
  textSize(100); //set text size to 100pt
  for (int i = 0; i < letters.size(); i++) //for loop to go through entire array list of letters
  {
    Letter l = (Letter) letters.get(i); //calls letter stored at index i in the array list during each iteration of the loop
    l.run(); //calls run() method for letter that was just called, a letter is drawn on canvas according to what run() method contains
  }
}

//keyPressed() method to be called when a key is pressed
void keyPressed()
{
  //initial screen, before any key is pressed
  if (!firstKeyPressed)
  {
    firstKeyPressed = true; //start screen dismissed, remember this using boolean variable
  }
  
  //after initial key press, enters main interactive program
  else
  {
    //records characters typed and converts letters to uppercase
    typed = Character.toUpperCase (key);
    
    //call draw() method
    draw();
    
    //random angle at which letter is rotated
    angle = random(2 * PI);
    
    //random coordinates within bounds of frame
    x = random (75, 900); //x coordinate
    y = random (150, 650); //y coordinate
    
    //reject non-alphabets, only accept letters A-Z (already converted to uppercase)
    if (typed == 'A' || typed == 'B' || typed == 'C' || typed == 'D' || typed == 'E' || typed == 'F' || typed == 'G' ||
        typed == 'H' || typed == 'I' || typed == 'J' || typed == 'K' || typed == 'L' || typed == 'M' || typed == 'N' ||
        typed == 'O' || typed == 'P' || typed == 'Q' || typed == 'R' || typed == 'S' || typed == 'T' ||
        typed == 'U' || typed == 'V' || typed == 'W' || typed == 'X' || typed == 'Y' || typed == 'Z')
    {
      letters.add (new Letter (angle, x, y)); //add new letter to array list based on specified angle and coordinates above
    }
    
    //if pressed 1, change to beet flavour
    else if (typed == '1')
    {
      background = beet; //background colour change
      flavour = "beet"; //text label change
    }
    
    //if pressed 2, change to broccoli flavour
    else if (typed == '2')
    {
      background = broccoli; //background colour change
      flavour = "broccoli"; //text label change
    }
    
    //if pressed 3, change to broth flavour
    else if (typed == '3')
    {
      background = broth; //background colour change
      flavour = "broth"; //text label change
    }
    
    //if pressed 4, change to carrot flavour
    else if (typed == '4')
    {
      background = carrot; //background colour change
      flavour = "carrot"; //text label change
    }
    
    //if pressed 5, change to fish flavour
    else if (typed == '5')
    {
      background = fish; //background colour change
      flavour = "fish"; //text label change
    }
    
    //if pressed 6, change to mushroom flavour
    else if (typed == '6')
    {
      background = mushroom; //background colour change
      flavour = "mushroom"; //text label change
    }
    
    //if pressed 7, change to ramen flavour
    else if (typed == '7')
    {
      background = ramen; //background colour change
      flavour = "ramen"; //text label change
    }
    
    //if pressed 8, change to rawon flavour
    else if (typed == '8')
    {
      background = rawon; //background colour change
      flavour = "rawon"; //text label change
    }
    
    //if pressed 9, change to shrimp flavour
    else if (typed == '9')
    {
      background = shrimp; //background colour change
      flavour = "shrimp"; //text label change
    }
    
    //if pressed 10, change to tomato flavour
    else if (typed == '0')
    {
      background = tomato; //background colour change
      flavour = "tomato"; //text label change
    }
    
    //if pressed spacebar, remove all letters
    else if (typed == ' ')
    {
      letters = new ArrayList(); //resetting array list by overwriting what is stored with new empty array list
    }
  }
}

//workaround to draw and outline text darker shade of background, used on start screen
void textOutline (String text, int x, int y, int thick) //paramaters: text, x coordinate, y coordinate, thickness
{
  for (int i = -1*thick; i <= thick; i += thick) //for loop with three iterations, variable i ranging from -1 to 1
  {
    for (int j = -1*thick; j <= thick; j += thick) /*for loop with three more iterations within first for loop,
                                                    variable j ranging from -1 to 1*/
    {
      text (text, x + i, y + j); //redraws text on 4 diagonals to create corner/diagonal outlines
    }
    text (text, x + i, y); //redraws text on left/right sides to create left/right outlines
    text (text, x, y + i); //redraws text on top/bottom sides to create top/bottom outlines
  }
}

//new class for letters, used to create letter object to be instantiated in main program
class Letter
{
  //class field declarations
  char typed = Character.toUpperCase (key); //records characters typed and converts letters to uppercase
  color c; //colour of letter will always be pasta
  float angle, opacity, x, y; //angle at which letters are rotated, opacity level, (x, y) coordinates for position on canvas
  
  //constructor which is called each time a new letter object is created - object is instantiated and attribute values are given
  Letter (float angle, float x, float y) //paramaters: angle and (x, y) coordinates may vary, colour is consistent
  {
    c = color (255, 222, 173); //set colour of letter to pasta
    this.angle = angle; //set angle of rotation to angle given by class field above
    this.x = x; //set x coordinate to coordinate given by class field above
    this.y = y; //set y coordinate to coordinate given by class field above
    opacity = 255; //fully opaque when shape is first drawn
  }
  
  //run() method called every time Letter object is created
  void run()
  {
    if (opacity <= 1) //check if opacity has reached or gone below 0
    {
      opacity = 0; //limit opacity to 0, do not go lower
    }
    else //opacity is still decreasing
    {
      opacity -= 1; //decrement opacity, eventually it will become 0
    }
    
    //rotate and align text
    textAlign (CENTER, CENTER); //align text to centre horizontally and vertically
    pushMatrix(); //saves current coordinate system to matrix stack so that Processing can apply proper transformations
    translate (x, y); //translate text to origin before applying transformatio 
    rotate (angle); //apply rotation by angle given above
    translate (-x, -y); //translate text back to original position
    
    /*workaround to outline text darker shade of background - applied manually here because using textOutline gives issues
      when attempting with objects inside array, this is fully hardcoded because it is only used once*/
    fill (red (background) - 75, green (background) - 75, blue (background) - 75, opacity); /*change fill colour to darker
                                                                                                   shade of background colour with
                                                                                                   opacity given above*/
    for (int i = -2; i <= 2; i += 2) //for loop with three iterations, variable i ranging from -1 to 1
    {
      for (int j = -2; j <= 2; j += 2) //for loop with three more iterations within first for loop, variable j ranging from -1 to 1
      {
        text (typed, x + i, y + j); //redraws text on 4 diagonals to create corner/diagonal outlines
      }
      text (typed, x + i, y); //redraws text on left/right sides to create left/right outlines
      text (typed, x, y + i); //redraws text on top/bottom sides to create top/bottom outlines
    }
    
    //draw main text
    fill (c, opacity); //set fill colour based on colour and opacity given above
    text (typed, x, y); //draws letter at (x, y) coordinates given above
    popMatrix(); //restores prior coordinate system
  }
}

/* ~~~ REFERENCED ONLINE CODE - LINKS AND HOW THEY WERE USED ~~~
Fading cirles: forum.processing.org/one/topic/fading-animation.html
-Original program demonstrates how to draw small, randomly coloured circles upon mouse click at the cursor's current location which
 fade away after a short time, similar techniques were applied in the making of the fading letters in the soup for this program.
 In both cases, this was done by creating objects in a separate class and storing each object in an array list, and every object in
 the array list is redrawn every frame. The fading effect is produced by gradually decrementing the opacity value of the shape
 over a short period of time. What was changed is that the letters being drawn were more complex than the small circles in the
 original program (letters had an outine, rotation angle, and took the shape of an actual typed letter), colour was constant and not
 randomly chosen as it was with the circles, opacity value was decremented by a smaller number so that the letters would fade out
 more slowly, letters were triggered to appear by key presses instead of mouse clicks and additional code was added to the separate
 class for the letters which was not done in the original program. The option to clear the array list (using the space bar) was also
 unique to this program.

Rotated text: processing.org/discourse/beta/num_1219267259.html
-Original program demonstrates how to rotate text by an angle given in radians and position it at a given location on the canvas, and
 this technique was used to rotate each of the letters by a random angle as they appeared in the soup. This was done by applying the
 transformation using a matrix stack (working with the coordinate system used so that the transformation does not interfere with any
 other shapes drawn), translating the shape to the origin to apply the transformation before translating it back again, and applying
 the transformation itself using the rotate() method. What was changed is that the letters could have been rotated at any angle and
 not just vertically, the position of the text itself was also random and not fixed to just (10, 100), and this entire transformation
 was applied to each letter object that was instantiated in this program, not just one single line of text, and these letters were
 also far more complex, by themselves, than the simple text in the original program.

Outlined text: forum.processing.org/two/discussion/16700/how-to-outline-text
-Since Processing does not offer a quick and simple way of adding an outline to text, this workaround was developed to do this by
 drawing text, filled with the outine colour, surrounding the location where the main text is to be drawn, and then drawing the main
 text in the centre so the surrounding text seems to function as an outline. This was applied twice in this program. A textOutline()
 method was created using this technique which accepted parameters for thickness, (x, y) coordinates and the text which was to be
 displayed, and it was called upon three times in the setup() method for displaying outlined text on the start screen. It was also
 used once in the Letter class so that each new letter which was drawn would have a similar outline. In both cases, what was changed
 was that the outined had a thickness of 2 and not 1 like in the original program (meaning that the surrounding text was drawn 2
 pixels off centre instead of 1) and this technique was applied to three lines of text and one recurring object (letters) and not to
 just one bit of text ("LIKE THIS!") like in the original program.

Processing documentation (processing.org/reference) was also referenced for the sake of learning syntax,
prior knowledge of Java was applied as well in many places throughout this source code. */
