class CircularColorPicker extends ColorPicker
{
  int outerRadius = this.getWidth() / 2;
  int innerRadius = outerRadius / 2;

  public CircularColorPicker()
  {
    super(100, 100, 100, 100);
  }

  public void draw() { 
    image.beginDraw();
    image.colorMode(HSB, TWO_PI, saturationBrightnessPicker.max_saturation, saturationBrightnessPicker.max_brightness);

    for (int x = 0; x < this.getWidth (); x++) {
      for (int y = 0; y < this.getHeight (); y++) {
        float distance = dist(x, y, outerRadius, outerRadius);

        // if the distance between inner and outer circle radius, paint the circle
        if (distance < outerRadius && distance > innerRadius) {
          float hue = atan2(outerRadius - y, outerRadius - x) + PI;

          image.stroke(hue, saturationBrightnessPicker.max_saturation, saturationBrightnessPicker.max_brightness);
          image.point(x, y);
        }
      }
    }

    image.endDraw();
  }

  public void joystickMove()
  {
    float relativePositionX = joystick.sliders.X() - colorPicker.getStartX();
    float relativePositionY = joystick.sliders.Y() - colorPicker.getStartY();

    //    println("X = " + relativePositionX + " | Y = " + relativePositionY);

    float distance = dist(relativePositionX, relativePositionY, this.outerRadius, this.outerRadius);

    if (distance < this.outerRadius && distance > this.innerRadius) {
      colorPicker.pickIndicator.relativeSet(relativePositionX, relativePositionY);
    }
  }

  public void mouseMove()
  {
    if (colorPicker.isInRange(mouseX, mouseY))
    {
      float relativePositionX = mouseX - colorPicker.getStartX();
      float relativePositionY = mouseY - colorPicker.getStartY();

      float distance = dist(relativePositionX, relativePositionY, this.outerRadius, this.outerRadius);
      //println("X="+relativePositionX+" Y="+relativePositionY);
      //println("d="+distance);

      if (distance < this.outerRadius && distance > this.innerRadius) {
        colorPicker.pickIndicator.relativeSet(relativePositionX, relativePositionY);
      }
    }
  }
}

