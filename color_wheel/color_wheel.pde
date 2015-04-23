int window_width = 800;
int window_height = 600;

int colorPicker_x = 0;
int colorPicker_y = 100;
int colorPicker_width = window_width;
int colorPicker_height = 100;

// only if colorPicker is a circle
int colorPicker_circle_outerRadius = 150;
int colorPicker_circle_innerRadius = 100;

int brightnessPicker_x = 0;
int brightnessPicker_y = 200;
int brightnessPicker_width = window_width;
int brightnessPicker_height = 100;

float lumosity = 300;
float max_lumosity = 300;

int max_saturation = 150;

PFont instructionFont = createFont("Georgia", 32);

Table table;

float offset = 0;

PFont debugFont;
int[] picked_color;
PGraphics colorPicker_image;

String experiment_vpid = "Farin U.";
String experiment_colorWord = "Pink";
int experiment_sequence = 1;
int experiment_iteration = 1;

void setup() {
  colorMode(HSB, TWO_PI, max_saturation, max_lumosity);
  size(window_width, window_height);

  debugFont = createFont("arial", 10, false);

  picked_color = new int[2];
  picked_color[0] = 250;
  picked_color[1] = 200;

  colorPicker_image = createGraphics(colorPicker_width, colorPicker_height);
  drawColorPicker();
  
  initializeTable();
}

void draw() {
  background(0);
  
  mouseInteraction();
  
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

void mouseInteraction()
{
  if (mousePressed) {
    
    // colorPicker
    if (
    mouseY > colorPicker_y &&
      mouseY < colorPicker_y + colorPicker_height &&
      mouseX > colorPicker_x &&
      mouseY < colorPicker_x + colorPicker_width
      )
    {
      picked_color[0] = mouseX;
      picked_color[1] = mouseY;
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
  
  text("Bitte wähle nun rot aus.", window_width/2, 50);
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
  image(colorPicker_image, colorPicker_x, colorPicker_y);
}

void drawHorizontalColorPicker()
{
  colorPicker_image.beginDraw();
  colorPicker_image.colorMode(HSB, TWO_PI, 1, max_lumosity);

  for (int x = 0; x < colorPicker_width; x++) {
    float hue = ruleOfThree(x, colorPicker_width, TWO_PI);
    hue = hue + offset;
    hue = wrapHue(hue);
    float saturation = 1;

    colorPicker_image.stroke(hue, saturation, max_lumosity);
    colorPicker_image.line(x, 0, x, colorPicker_height); // way faster than point
  }

  colorPicker_image.endDraw();
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

void drawCirularColorPicker() { 
  colorPicker_image.beginDraw();
  colorPicker_image.colorMode(HSB, TWO_PI, 1, max_lumosity);

  for (int x = 0; x < colorPicker_width; x++) {
    for (int y = 0; y < colorPicker_height; y++) {
      // calulcate saturation by distance from the middle
      float distance = dist(x, y, colorPicker_circle_outerRadius, colorPicker_circle_outerRadius);

      // if the distance between inner and outer circle radius, paint the circle
      if (distance < colorPicker_circle_outerRadius && distance > colorPicker_circle_innerRadius) {
        float hue = atan2(150 - y, 150 - x) + PI;
        float saturation = 1;

        colorPicker_image.stroke(hue, saturation, max_lumosity);
        colorPicker_image.point(x, y);
      }
    }
  }

  colorPicker_image.endDraw();
}

void drawColorPicker()
{
  drawHorizontalColorPicker();
  //drawCircularColorPicker();
}

// event
void keyPressed() {
  //println("Key pressed");
  
  if (key == CODED) 
  {
    if (keyCode == LEFT) 
    {
      offset -= 0.1;
    }
    else if (keyCode == RIGHT) 
    {
      offset += 0.1;
    }

    drawColorPicker();
  }
}

void keyTyped() {
  //println("Key: typed " + int(key) + " " + keyCode);
  
  if (key == RETURN || key == ENTER)
  {
    //println("Key: Return/Enter");
    recordColor();
  }
  else if (key == TAB)
  {
    //println("Key: Tab");
    writeTable();
  }
}

void initializeTable()
{
  table = new Table();
  
  table.addColumn("Row_ID");
  table.addColumn("DateTime");
  
  table.addColumn("VP_ID");
  
  table.addColumn("ColorWord");
  
  table.addColumn("Iteration");
  table.addColumn("Sequence");
  
  table.addColumn("Red");
  table.addColumn("Green");
  table.addColumn("Blue");
  
  table.addColumn("Hue");
  table.addColumn("Saturation");
  table.addColumn("Brightness");
}

String prependZero(String s, int digits)
{
  while (s.length() < digits)
  {
    s = "0"+s;
  }
  
  return s;
}

String getCurrentDateTime()
{
  String d = prependZero(String.valueOf(day()), 2);
  String mon = prependZero(String.valueOf(month()), 2);
  String y = prependZero(String.valueOf(year()), 4);
  String h = prependZero(String.valueOf(hour()), 2);
  String min = prependZero(String.valueOf(minute()), 2);
  String s = prependZero(String.valueOf(second()), 2);
  
  return y+"-"+mon+"-"+y+" "+h+":"+min+":"+s;
}

void recordColor()
{
  color currentColor = getPickedColor();
  
  TableRow newRow = table.addRow();
  newRow.setInt("Row_ID", table.getRowCount() - 1);
  newRow.setString("DateTime", getCurrentDateTime());
  
  newRow.setString("VP_ID", experiment_vpid);
  
  newRow.setString("ColorWord", experiment_colorWord);
  
  newRow.setInt("Iteration", experiment_iteration);
  newRow.setInt("Sequence", experiment_sequence);
  
  newRow.setFloat("Red", red(currentColor));
  newRow.setFloat("Green", green(currentColor));
  newRow.setFloat("Blue", blue(currentColor));
  
  newRow.setFloat("Hue", hue(currentColor));
  newRow.setFloat("Saturation", saturation(currentColor));
  newRow.setFloat("Brightness", brightness(currentColor));
}

void writeTable()
{
  saveTable(table, "data/new.csv");
}
