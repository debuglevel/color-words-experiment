import org.gamecontrolplus.gui.*;
import org.gamecontrolplus.*;
import net.java.games.input.*;

int window_width = 800;
int window_height = 600;


PFont instructionFont = createFont("Georgia", 32);
PFont debugFont = createFont("arial", 10, false);


ExperimentData experimentData = new ExperimentData();
Joystick joystick = new Joystick(this);
ColorPicker colorPicker = new CircularColorPicker(); //HorizontalColorPicker();
Interaction interaction = new Interaction();
//BrightnessPicker brightnessPicker = new BrightnessPicker();
SaturationBrightnessPicker saturationBrightnessPicker = new SaturationBrightnessPicker();

void setup() {
  colorMode(HSB, TWO_PI, saturationBrightnessPicker.max_saturation, saturationBrightnessPicker.max_brightness);
  size(window_width, window_height);

  interaction.setup();

  //joystick.sliders.setRange(colorPicker.x, colorPicker.y, colorPicker.x + colorPicker.width, colorPicker.y + colorPicker.height);
  // reduce size of circular colorpicker to ensure that the joystick pick will always be inside (instead of being slightly outside the edge)  
  joystick.sliders.setRange(colorPicker.getStartX() + 10, colorPicker.getStartY() + 10, colorPicker.getEndX() - 10, colorPicker.getEndY() - 10);

  colorPicker.setup();
  colorPicker.draw();

  //saturationBrightnessPicker.setup();
  //saturationBrightnessPicker.draw();

  experimentData.initializeTable();
  experimentData.setNextColor();
}

void draw() {
  background(0);

  interaction.mouseInteraction();
  interaction.joystickInteraction();

  colorPicker.display();
  //saturationBrightnessPicker.display();
  color currentColor = colorPicker.getColor();

  displayColorDisplay(currentColor);

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

  text("DBG: " + 0, 10, 90);
}

void displayInstruction()
{
  textFont(instructionFont);
  textAlign(CENTER);
  fill(0, 0, 255);

  text("Bitte wähle nun " + experimentData.ColorWord + " aus.", window_width/2, 50);
}

void displayColorDisplay(color currentColor)
{
  fill(currentColor);
  rect(420, 330, 40, 40);
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

