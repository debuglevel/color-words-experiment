class HorizontalColorPicker extends ColorPicker
{
  public void draw()
  {
    image.beginDraw();
    image.colorMode(HSB, TWO_PI, 1, brightnessPicker.max_lumosity);

    for (int x = 0; x < width; x++) {
      float hue = ruleOfThree(x, width, TWO_PI);
      hue = hue + interaction.offset;
      hue = wrapHue(hue);
      float saturation = 1;

      image.stroke(hue, saturation, brightnessPicker.max_lumosity);
      image.line(x, 0, x, height); // way faster than point
    }

    image.endDraw();
  }
}

