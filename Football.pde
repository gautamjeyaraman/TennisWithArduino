import processing.serial.*;
import cc.arduino.*;

int potPin1 = 0;
int potPin2 = 1;
int time = 0; // to change ball speed every few seconds
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

int player1 = 0;
int player2 = 0;

void draw() 
{
  
  int sensorValue1 = arduino.analogRead(potPin1);
  int sensorValue2 = arduino.analogRead(potPin2);
  
  int rect1X = 0;
  int rect1Y = sensorValue1/2;
  int rect1H = 100;
  int rect1W = 30;

  int rect2X = width-30;
  int rect2Y = sensorValue2/2;
  int rect2H = 100;
  int rect2W = 30;
  time++;
  if(time%60 == 0){
    xspeed = xspeed+1;
    yspeed = yspeed+1;
}
  
  
  int value = arduino.analogRead(5);
  value = (int) map(value,800,1000,150,255);
  background(0,value,0);
  textSize(20);
  text(player1,300,40);
  text(player2,350,40);
  
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
  if (xpos+rad > rect2X && ypos-rad<rect2Y+rect2H && ypos+rad > rect2Y){
    xdirection *= -1;
  }

  rect(rect1X, rect1Y, rect1W, rect1H);
  rect(rect2X, rect2Y, rect2W, rect2H);

  // Draw the shape
  fill(204,0,0);
  if(xpos < 0+rect1W+rect1X || xpos > rect2X-rect2W)
  {
    xpos = width/2;
    ypos = height/2;
    xspeed = 10;
    xspeed = 10;
    if(xpos > rect2X-rect2W)
      player1++;
    else
      player2++;
  }
  ellipse(xpos, ypos, rad, rad);
}
