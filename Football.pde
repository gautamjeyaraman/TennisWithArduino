import processing.serial.*;
import cc.arduino.*;

int potPin = 0;

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
  
  int sensorValue = arduino.analogRead(potPin);
  
  int rectX = 30;
  int rectY = sensorValue/2;
  int rectH = 100;
  int rectW = 30;
  
  
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

  if (xpos-rad < rectX+rectW && ypos-rad<rectY+rectH && ypos+rad > rectY){
    xdirection *= -1;
  }

  rect(rectX, rectY, rectW, rectH);

  // Draw the shape
  fill(204,0,0);
  ellipse(xpos, ypos, rad, rad);
}