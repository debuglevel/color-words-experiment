class HorizontalColorPicker extends ColorPicker
{
  float colorRange = PI/2; 

  public HorizontalColorPicker()
  {
    pickedColorPosition = new int[2];
    pickedColorPosition[0] = (this.width / 2);
    pickedColorPosition[1] = (this.height / 2);
  }

  public void draw()
  {
    image.beginDraw();
    image.colorMode(HSB, TWO_PI, 1, brightnessPicker.max_lumosity);

    for (int x = 0; x < width; x++) {
      float hue = ruleOfThree(x, width, colorRange);
      //float hue = ruleOfThree(x, width, TWO_PI);
      hue = hue + interaction.offset;
      hue = wrapHue(hue);
      float saturation = 1;

      image.stroke(hue, saturation, brightnessPicker.max_lumosity);
      image.line(x, 0, x, height); // way faster than point
    }

    image.endDraw();
  }

  public void joystickMove()
  {
    interaction.changeOffset(joystick.sliders.rawX() / 5.0);
  }
}

