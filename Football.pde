import processing.serial.*;
import cc.arduino.*;

int potPin1 = 0;
int potPin2 = 1;

Arduino arduino;

void setup() {
  // Prints out the available serial ports.
  println(Arduino.list());
  
  // Modify this line, by changing the "0" to the index of the serial
  // port corresponding to your Arduino board (as it appears in the list
  // printed by the line above).
  arduino = new Arduino(this, Arduino.list()[3], 57600);
  
  size(640, 512);
  noStroke();
  frameRate(30);
  ellipseMode(RADIUS);
  // Set the starting position of the shape
  xpos = width/2;
  ypos = height/2;
}


int rad = 20;        // Width of the shape
float xpos, ypos;    // Starting position of shape    

float xspeed = 10;  // Speed of the shape
float yspeed = 10;  // Speed of the shape

int xdirection = 1;  // Left or Right
int ydirection = 1;  // Top to Bottom



void draw() 
{
  
  int sensorValue1 = arduino.analogRead(potPin1);
  int sensorValue2 = arduino.analogRead(potPin2);
  
  int rect1X = 30;
  int rect1Y = sensorValue1/2;
  int rect1H = 100;
  int rect1W = 30;
  int rect2X = width-60;
  int rect2Y = sensorValue2/2;
  int rect2H = 100;
  int rect2W = 30;
  
  
  
  int value = arduino.analogRead(5);
  value = (int) map(value,800,1000,150,255);
  background(0,value,0);
  
  
  // Update the position of the shape
  xpos = xpos + ( xspeed * xdirection );
  ypos = ypos + ( yspeed * ydirection );
  
  // Test to see if the shape exceeds the boundaries of the screen
  // If it does, reverse its direction by multiplying by -1
  if (xpos > width-rad || xpos < rad) {
    xdirection *= -1;
  }
  if (ypos > height-rad || ypos < rad) {
    ydirection *= -1;
  }

  if (xpos-rad < rect1X+rect1W && ypos-rad<rect1Y+rect1H && ypos+rad > rect1Y){
    xdirection *= -1;
  }

  rect(rect1X, rect1Y, rect1W, rect1H);
  rect(rect2X, rect2Y, rect2W, rect2H);

  // Draw the shape
  fill(204,0,0);
  ellipse(xpos, ypos, rad, rad);
}
