float lumosity = 300;
PFont font;
int[] picked;
PGraphics picker;

void setup() {
  colorMode(HSB, TWO_PI, 150, 300);
  size(500, 500);
  background(0);

  font = createFont("arial", 10, false);
  textFont(font);

  rectMode(CENTER);
  noFill();
  picked = new int[2];
  picked[0] = 250;
  picked[1] = 200;

  picker = createGraphics(300, 300);
  drawPicker();
}

void draw() {
  noFill();
  background(0);
  image(picker, 100, 50);

  if (mousePressed) {
    if (mouseY > 390) {
      lumosity = constrain((mouseX - 100), 0, 300);
    } else {
      if (dist(mouseX, mouseY, 250, 200) < 150) {
        picked[0] = mouseX;
        picked[1] = mouseY;
      }
    }
    drawPicker();
  }

  // draw brightness scale
  for (int a = 0; a < 300; a++) {
    stroke(0, 0, a);
    line(a + 100, 400, a + 100, 440);
  }

  line(lumosity + 100, 398, lumosity + 100, 442);
  color col = get(picked[0], picked[1]);

  fill(0, 0, 255);

  text("R: " + ruleOfThree(red(col),       TWO_PI, 255), 400, 50);
  text("G: " + ruleOfThree(green(col),        150, 255), 400, 60);
  text("B: " + ruleOfThree(blue(col),         300, 255), 400, 70);
  
  text("S: " + ruleOfThree(saturation(col),   150, 255), 400, 90);
  text("B: " + ruleOfThree(brightness((col)), 300, 255), 400, 100);

  rect(picked[0], picked[1], 4, 4);

  fill(col);
  rect(420, 330, 40, 40);
}

int ruleOfThree(float value, float oldMax, int newMax) {
  // e.g. oldMax   1       value 0.5
  //      newMax 255 -> newValue 128
  int newValue = (int)((value / oldMax) * newMax);
  return newValue;
}

void drawPicker() { 
  picker.beginDraw();
  picker.colorMode(HSB, TWO_PI, 150, 300);

  for (int x = 0; x < 300; x++) {
    for (int y = 0; y < 300; y++) {
      // calulcate saturation by distance from the middle
      float saturation = dist(x, y, 150, 150);
	  
      // if saturation (i.e. the distance) is less than 150 (i.e. the end of the circle), paint something
      if (saturation < 150) {
        float hue = atan2(150 - y, 150 - x) + PI;
        picker.stroke(hue, saturation, lumosity);
        picker.point(x, y);
      }
    }
  }

  picker.endDraw();
}

