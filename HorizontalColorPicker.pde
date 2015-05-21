class HorizontalColorPicker extends ColorPicker
{
  float colorRange = PI/2; 

  public HorizontalColorPicker()
  {
    super(0, 200, window_width, 100);
    //super(100, 100, 100, 100);

    this.pickIndicator.relativeSet(this.getWidth() / 2, this.getHeight() / 2);
  }

  public void draw()
  {
    image.beginDraw();
    image.colorMode(HSB, TWO_PI, saturationBrightnessPicker.max_saturation, saturationBrightnessPicker.max_brightness);

    for (int x = 0; x < this.getWidth (); x++) {
      float hue = ruleOfThree(x, this.getWidth(), colorRange);
      //float hue = ruleOfThree(x, width, TWO_PI);
      hue = hue + interaction.offset;
      hue = wrapHue(hue);

      image.stroke(hue, saturationBrightnessPicker.max_saturation, saturationBrightnessPicker.max_brightness);
      image.line(x, 0, x, this.getHeight()); // way faster than point
    }

    image.endDraw();
  }

  public void joystickMove()
  {
    interaction.changeOffset(joystick.sliders.rawX() / 5.0);
  }
}

