int window_height = 500;
int window_width = 500;


//int picker_size = circle_outer_radius * 2;

int colorPicker_x = 0;
int colorPicker_y = 0;
int colorPicker_width = window_width;
int colorPicker_height = 100;

int colorPicker_circle_outerRadius = 150;
int colorPicker_circle_innerRadius = 100;

int brightnessPicker_x = 0;
int brightnessPicker_y = 200;
int brightnessPicker_height = 100;
int brightnessPicker_width = window_width;



float lumosity = 300;
float max_lumosity = 300;

int max_saturation = 150;

float offset = 0;

PFont font;
int[] picked_color;
PGraphics picker;

void setup() {
  colorMode(HSB, TWO_PI, max_saturation, max_lumosity);
  size(window_width, window_height);
  background(0);

  font = createFont("arial", 10, false);
  textFont(font);

  rectMode(CENTER);
  noFill();
  
  picked_color = new int[2];
  picked_color[0] = 250;
  picked_color[1] = 200;

  picker = createGraphics(colorPicker_width, colorPicker_height);
  drawColorPicker();
}

void draw() {
  noFill();
  background(0);
  image(picker, colorPicker_x, colorPicker_y);

  mouseInteraction();

  drawLumosityPicker();
  
  
  color currentColor = get(picked_color[0], picked_color[1]);

  fill(0, 0, 255);

  text("R: " + ruleOfThree(red(currentColor),       TWO_PI, 255), 400, 50);
  text("G: " + ruleOfThree(green(currentColor),        150, 255), 400, 60);
  text("B: " + ruleOfThree(blue(currentColor),         300, 255), 400, 70);
  
  text("S: " + ruleOfThree(saturation(currentColor),   150, 255), 400, 90);
  text("B: " + ruleOfThree(brightness(currentColor),   300, 255), 400, 100);
  
  text("DBG: " + lumosity,                                  400, 130);

  drawColorIndicator();
  drawColorDisplay(currentColor);
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

void drawColorIndicator()
{
  rect(picked_color[0], picked_color[1], 5, 5);
}

void drawColorDisplay(color currentColor)
{
  fill(currentColor);
  rect(420, 330, 40, 40);
}

void drawLumosityPicker()
{
  // draw brightness scale
   // for (int lumosity_line = 0; lumosity_line < max_lumosity; lumosity_line++) {

  for (int x = 0; x < brightnessPicker_width; x++) {
    float currentLumosity = ruleOfThree(x, brightnessPicker_width, max_lumosity);
    
    stroke(0, 0, currentLumosity);
    line(brightnessPicker_x + x,
     brightnessPicker_y, 
     brightnessPicker_x + x,
     brightnessPicker_y + brightnessPicker_height);
  }
     
//  for (int lumosity_line = 0; lumosity_line < max_lumosity; lumosity_line++) {
//    stroke(0, 0, lumosity_line);
//    line(brightnessPicker_x + lumosity_line,
//         brightnessPicker_y, 
//         brightnessPicker_x + lumosity_line,
//         brightnessPicker_y + brightnessPicker_height);
//  }
  
  // indicator for current lumosity
  float currentLumosity = ruleOfThree(lumosity, max_lumosity, brightnessPicker_width);
  line(brightnessPicker_x + currentLumosity,
       brightnessPicker_y - 2,
       brightnessPicker_x + currentLumosity,
       brightnessPicker_y + brightnessPicker_height + 2);
}

void drawColorPicker()
{
  picker.beginDraw();
  picker.colorMode(HSB, TWO_PI, 1, max_lumosity);
  
  for (int x = 0; x < colorPicker_width; x++) {
    float hue = ruleOfThree(x, colorPicker_width, TWO_PI);
    hue = hue + offset;
    hue = wrap_hue(hue);
    float saturation = 1;
    
    picker.stroke(hue, saturation, max_lumosity);
    picker.line(x, 0, x, colorPicker_height); // way faster than point
  }
  
  picker.endDraw();
}

float wrap_hue(float hue)
{
  if (hue < 0)
  {
    while (hue < 0)
    {
      hue += TWO_PI;
    }
    
    return hue;
  }
  else if (hue > TWO_PI)
  {
    while (hue > TWO_PI)
    {
      hue -= TWO_PI;
    }
    
    return hue;
  }
  
  return hue;
}

void drawColorPicker_() { 
  picker.beginDraw();
  picker.colorMode(HSB, TWO_PI, 1, max_lumosity);

  for (int x = 0; x < colorPicker_width; x++) {
    for (int y = 0; y < colorPicker_height; y++) {
      // calulcate saturation by distance from the middle
      float distance = dist(x, y, colorPicker_circle_outerRadius, colorPicker_circle_outerRadius);
	  
      // if the distance between inner and outer circle radius, paint the circle
      if (distance < colorPicker_circle_outerRadius && distance > colorPicker_circle_innerRadius) {
        float hue = atan2(150 - y, 150 - x) + PI;
        float saturation = 1;

        picker.stroke(hue, saturation, max_lumosity);
        picker.point(x, y);
      }
    }
  }

  picker.endDraw();
}

// event
void keyPressed() {
  if (key == CODED) {
    if (keyCode == LEFT) {
      offset -= 0.1;
    } else if (keyCode == RIGHT) {
      offset += 0.1;
    }
   
   drawColorPicker(); 
  }
}

