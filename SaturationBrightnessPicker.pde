public class SaturationBrightnessPicker extends Picker
{
  private float max_brightness = 1;
  private float max_saturation = 1;

  public SaturationBrightnessPicker()
  {
    //    int x = 100;
    //    int y = 200;
    //    int width = 200;
    //    int height = 200;
    // x = window_width / 2 - this.width = 800/2 - 200 = 200
    super(200, 220, 200, 200);

    pickIndicator.setOffset(this.getStartX(), this.getStartY());
  }

  public color getColorSaturationBrightness()
  {
    return image.get(this.pickIndicator.relativeX(), this.pickIndicator.relativeY());
  }

  public void draw()
  {
    image.beginDraw();
    image.colorMode(HSB, TWO_PI, saturationBrightnessPicker.max_saturation, saturationBrightnessPicker.max_brightness);

    float hue = hue(colorPicker.getColor());
    hue = wrapHue(hue);

    int width = this.getWidth();
    int height = this.getHeight();

    // draw brightness scale
    for (int x = 0; x <= width; x++) {
      for (int y = 0; y <= height; y++) {
        float brightness = ruleOfThree(x, width, max_brightness);
        float saturation = ruleOfThree(y, height, max_saturation);

        saturation = max_saturation - saturation; // place max saturation on the top instead of on the bottom

        image.stroke(hue, saturation, brightness);
        image.point(x, y);
      }
    }

    image.endDraw();
  }
}

