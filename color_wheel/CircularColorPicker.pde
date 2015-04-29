class CircularColorPicker extends ColorPicker
{
  int outerRadius = width / 2;
  int innerRadius = outerRadius / 2;
  
  public void draw() { 
    image.beginDraw();
    image.colorMode(HSB, TWO_PI, 1, brightnessPicker.max_lumosity);

    for (int x = 0; x < width; x++) {
      for (int y = 0; y < height; y++) {
        // calulcate saturation by distance from the middle
        float distance = dist(x, y, outerRadius, outerRadius);

        // if the distance between inner and outer circle radius, paint the circle
        if (distance < outerRadius && distance > innerRadius) {
          float hue = atan2(outerRadius - y, outerRadius - x) + PI;
          float saturation = 1;

          image.stroke(hue, saturation, brightnessPicker.max_lumosity);
          image.point(x, y);
        }
      }
    }

    image.endDraw();
  }
}

