import org.gamecontrolplus.gui.*;
import org.gamecontrolplus.*;
import net.java.games.input.*;

int window_width = 800;
int window_height = 600;


int max_saturation = 150;

PFont instructionFont = createFont("Georgia", 32);

Table table;
String tableFile;

PFont debugFont = createFont("arial", 10, false);


ExperimentData experimentData = new ExperimentData();
Joystick joystick = new Joystick(this);
ColorPicker colorPicker = new CircularColorPicker();
Interaction interaction = new Interaction();
BrightnessPicker brightnessPicker = new BrightnessPicker();

void setup() {
  colorMode(HSB, TWO_PI, max_saturation, brightnessPicker.max_lumosity);
  size(window_width, window_height);

  //joystick.sliders.setRange(colorPicker.x, colorPicker.y, colorPicker.x + colorPicker.width, colorPicker.y + colorPicker.height);
  // reduce size of circular colorpicker to ensure that the joystick pick will always be inside (instead of being slightly outside the edge)  
  joystick.sliders.setRange(colorPicker.x + 10, colorPicker.y + 10, colorPicker.x + colorPicker.width - 10, colorPicker.y + colorPicker.height - 10);

  colorPicker.setup();
  colorPicker.draw();

  experimentData.initializeTable();
  experimentData.setNextColor();
}

void draw() {
  background(0);

  interaction.mouseInteraction();
  interaction.joystickInteraction();

  displayColorPicker();
  color currentColor = colorPicker.getColor();

  displayColorIndicator();
  displayColorDisplay(currentColor);

  brightnessPicker.display();

  displayInstruction();
  displayDebugInfo(currentColor);
}

float ruleOfThree(float value, float oldMax, float newMax) {
  // e.g. oldMax   1       value 0.5
  //      newMax 255 -> newValue 128
  float newValue = ((value / oldMax) * newMax);
  return newValue;
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

  text("DBG: " + brightnessPicker.lumosity, 10, 90);
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

  rect(colorPicker.x + colorPicker.pickedColorPosition[0], colorPicker.y + colorPicker.pickedColorPosition[1], 5, 5);
}

void displayColorDisplay(color currentColor)
{
  fill(currentColor);
  rect(420, 330, 40, 40);
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
  interaction.keyPressed();
}

void keyTyped() {
  interaction.keyTyped();
}

