import org.gamecontrolplus.gui.*;
import org.gamecontrolplus.*;
import net.java.games.input.*;

int window_width = 800;
int window_height = 600;

int brightnessPicker_x = 0;
int brightnessPicker_y = 400;
int brightnessPicker_width = window_width;
int brightnessPicker_height = 100;

float lumosity = 300;
float max_lumosity = 300;

int max_saturation = 150;

PFont instructionFont = createFont("Georgia", 32);

Table table;
String tableFile;

float offset = 0;

PFont debugFont;
int[] picked_color;


ExperimentData experimentData = new ExperimentData();
Joystick joystick = new Joystick(this);
ColorPicker colorPicker = new CircularColorPicker();

void setup() {
  colorMode(HSB, TWO_PI, max_saturation, max_lumosity);
  size(window_width, window_height);

  joystick.sliders.setRange(colorPicker.x, colorPicker.y, colorPicker.x + colorPicker.width, colorPicker.y + colorPicker.height);

  debugFont = createFont("arial", 10, false);

  picked_color = new int[2];
  picked_color[0] = 250;
  picked_color[1] = 200;

  colorPicker.setup();
  colorPicker.draw();

  experimentData.initializeTable();
  experimentData.setNextColor();
}

void draw() {
  background(0);

  mouseInteraction();
  joystickInteraction();

  displayColorPicker();
  color currentColor = getPickedColor();

  displayColorIndicator();
  displayColorDisplay(currentColor);

  displayLumosityPicker();

  displayInstruction();
  displayDebugInfo(currentColor);
}

color getPickedColor()
{
  return get(picked_color[0], picked_color[1]);
}

float ruleOfThree(float value, float oldMax, float newMax) {
  // e.g. oldMax   1       value 0.5
  //      newMax 255 -> newValue 128
  float newValue = ((value / oldMax) * newMax);
  return newValue;
}

void joystickInteraction()
{
  if (joystick.isActive == false)
  {
    return;
  }

  // colorPicker
  if (colorPicker instanceof HorizontalColorPicker)
  {
    if (
    mouseY > colorPicker.y &&
      mouseY < colorPicker.y + colorPicker.height &&
      mouseX > colorPicker.x &&
      mouseX < colorPicker.x + colorPicker.width
      )
    {
      picked_color[0] = mouseX;
      picked_color[1] = mouseY;
    }
  } else if (colorPicker instanceof CircularColorPicker)
  {
    CircularColorPicker circularColorPicker = (CircularColorPicker)colorPicker;

    float relativePositionX = colorPicker.x - joystick.sliders.X();
    float relativePositionY = colorPicker.y - joystick.sliders.Y();

    println("X = " + relativePositionX + " | Y = " + relativePositionY);

    float distance = dist(relativePositionX, relativePositionY, circularColorPicker.outerRadius, circularColorPicker.outerRadius);

    if (distance < circularColorPicker.outerRadius && distance > circularColorPicker.innerRadius) {
      picked_color[0] = joystick.sliders.X();
      picked_color[1] = joystick.sliders.Y();
    }
  }
}

void mouseInteraction()
{
  if (mousePressed) {

    // colorPicker
    if (colorPicker instanceof HorizontalColorPicker)
    {
      if (
      mouseY > colorPicker.y &&
        mouseY < colorPicker.y + colorPicker.height &&
        mouseX > colorPicker.x &&
        mouseX < colorPicker.x + colorPicker.width
        )
      {
        picked_color[0] = mouseX;
        picked_color[1] = mouseY;
      }
    } else  if (colorPicker instanceof CircularColorPicker)

    {
      CircularColorPicker circularColorPicker = (CircularColorPicker)colorPicker;


      float relativePositionX = mouseX - colorPicker.x;
      float relativePositionY = mouseY - colorPicker.y;

      // calulcate saturation by distance from the middle
      float distance = dist(relativePositionX, relativePositionY, circularColorPicker.outerRadius, circularColorPicker.outerRadius);

      if (distance < circularColorPicker.outerRadius && distance > circularColorPicker.innerRadius) {
        picked_color[0] = mouseX;
        picked_color[1] = mouseY;
      }
    }

    // brightnessPicker
    if (
    mouseY > brightnessPicker_y &&
      mouseY < brightnessPicker_y + brightnessPicker_height &&
      mouseX > brightnessPicker_x &&
      mouseY < brightnessPicker_x + brightnessPicker_width
      )
    {
      lumosity = ruleOfThree(mouseX - brightnessPicker_x, brightnessPicker_width, max_lumosity);
      lumosity = constrain(lumosity, 0, max_lumosity);
    }
  }
}

void displayDebugInfo(color currentColor)
{
  textAlign(LEFT);
  textFont(debugFont);
  fill(0, 0, 255);

  text("R:   " + ruleOfThree(red(currentColor), TWO_PI, 255), 10, 20);
  text("G:   " + ruleOfThree(green(currentColor), 150, 255), 10, 30);
  text("B:   " + ruleOfThree(blue(currentColor), 300, 255), 10, 40);

  text("S:   " + ruleOfThree(saturation(currentColor), 150, 255), 10, 60);
  text("B:   " + ruleOfThree(brightness(currentColor), 300, 255), 10, 70);

  text("DBG: " + lumosity, 10, 90);
}

void displayInstruction()
{
  textFont(instructionFont);
  textAlign(CENTER);
  fill(0, 0, 255);

  text("Bitte wähle nun " + experimentData.ColorWord + " aus.", window_width/2, 50);
}

void displayColorIndicator()
{
  rectMode(CENTER);
  noFill();

  rect(picked_color[0], picked_color[1], 5, 5);
}

void displayColorDisplay(color currentColor)
{
  fill(currentColor);
  rect(420, 330, 40, 40);
}

void displayLumosityPicker()
{
  // draw brightness scale
  for (int x = 0; x < brightnessPicker_width; x++) {
    float currentLumosity = ruleOfThree(x, brightnessPicker_width, max_lumosity);

    stroke(0, 0, currentLumosity);
    line(brightnessPicker_x + x, 
    brightnessPicker_y, 
    brightnessPicker_x + x, 
    brightnessPicker_y + brightnessPicker_height);
  }

  // indicator for current lumosity
  float currentLumosity = ruleOfThree(lumosity, max_lumosity, brightnessPicker_width);
  line(brightnessPicker_x + currentLumosity, 
  brightnessPicker_y - 2, 
  brightnessPicker_x + currentLumosity, 
  brightnessPicker_y + brightnessPicker_height + 2);
}

void displayColorPicker()
{
  image(colorPicker.image, colorPicker.x, colorPicker.y);
}

float wrapHue(float hue)
{
  if (hue < 0)
  {
    while (hue < 0)
    {
      hue += TWO_PI;
    }

    return hue;
  } else if (hue > TWO_PI) {
    while (hue > TWO_PI)
    {
      hue -= TWO_PI;
    }

    return hue;
  }

  return hue;
}

// event
void keyPressed() {
  //println("Key pressed");

  if (key == CODED) 
  {
    if (keyCode == LEFT) 
    {
      offset -= 0.1;
    } else if (keyCode == RIGHT) 
    {
      offset += 0.1;
    }

    colorPicker.draw();
  }
}

void keyTyped() {
  //println("Key: typed " + int(key) + " " + keyCode);

  if (key == RETURN || key == ENTER)
  {
    //println("Key: Return/Enter");
    experimentData.enterColor();
  } else if (key == TAB)
  {
    //println("Key: Tab");
    experimentData.writeTable();
  } else if (key == DELETE)
  {
    selectOutput("Output file where filename equals the VP_ID", "fileSelected");
  }
}

