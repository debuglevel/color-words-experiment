int circle_outer_radius = 150;
int circle_inner_radius = 100;
int picker_size = circle_outer_radius * 2;

int brightness_scale_x = 100;
int brightness_scale_y = 400;
int brightness_scale_height = 40;

float lumosity = 300;
float max_lumosity = 300;

int max_saturation = 150;

PFont font;
int[] picked_color;
PGraphics picker;

void setup() {
  colorMode(HSB, TWO_PI, max_saturation, max_lumosity);
  size(500, 500);
  background(0);

  font = createFont("arial", 10, false);
  textFont(font);

  rectMode(CENTER);
  noFill();
  
  picked_color = new int[2];
  picked_color[0] = 250;
  picked_color[1] = 200;

  picker = createGraphics(picker_size, picker_size);
  drawColorPicker();
}

void draw() {
  noFill();
  background(0);
  image(picker, 100, 50);

  mouseInteraction();

  drawLumosityPicker();
  
  
  color currentColor = get(picked_color[0], picked_color[1]);

  fill(0, 0, 255);

  text("R: " + ruleOfThree(red(currentColor),       TWO_PI, 255), 400, 50);
  text("G: " + ruleOfThree(green(currentColor),        150, 255), 400, 60);
  text("B: " + ruleOfThree(blue(currentColor),         300, 255), 400, 70);
  
  text("S: " + ruleOfThree(saturation(currentColor),   150, 255), 400, 90);
  text("B: " + ruleOfThree(brightness(currentColor),   300, 255), 400, 100);

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
    if (mouseY > 390) {
      lumosity = constrain((mouseX - brightness_scale_x), 0, max_lumosity);
    } else {
      if (dist(mouseX, mouseY, 250, 200) < 150) {
        picked_color[0] = mouseX;
        picked_color[1] = mouseY;
      }
    }
    
    drawColorPicker();
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
  for (int lumosity_line = 0; lumosity_line < max_lumosity; lumosity_line++) {
    stroke(0, 0, lumosity_line);
    line(brightness_scale_x + lumosity_line,
         brightness_scale_y, 
         brightness_scale_x + lumosity_line,
         brightness_scale_y + brightness_scale_height);
  }
  
  // indicator for current lumosity
  line(brightness_scale_x + lumosity,
       brightness_scale_y - 2,
       brightness_scale_x + lumosity,
       brightness_scale_y + brightness_scale_height + 2);
}

void drawColorPicker()
{
  picker.beginDraw();
  picker.colorMode(HSB, TWO_PI, 1, max_lumosity);
  
  for (int x = 0; x < picker_size; x++) {
    float offset = PI*-1;
    float hue = ruleOfThree(x, picker_size, TWO_PI);
    hue = hue + offset;
    float saturation = 1;
    
    picker.stroke(hue, saturation, max_lumosity);
    picker.line(x, 0, x, picker_size); // way faster than point
  }
  
  picker.endDraw();
}

void drawColorPicker_() { 
  picker.beginDraw();
  picker.colorMode(HSB, TWO_PI, 1, max_lumosity);

  for (int x = 0; x < picker_size; x++) {
    for (int y = 0; y < picker_size; y++) {
      // calulcate saturation by distance from the middle
      float distance = dist(x, y, circle_outer_radius, circle_outer_radius);
	  
      // if the distance between inner and outer circle radius, paint the circle
      if (distance < circle_outer_radius && distance > circle_inner_radius) {
        float hue = atan2(150 - y, 150 - x) + PI;
        float saturation = 1;

        picker.stroke(hue, saturation, max_lumosity);
        picker.point(x, y);
      }
    }
  }

  picker.endDraw();
}

