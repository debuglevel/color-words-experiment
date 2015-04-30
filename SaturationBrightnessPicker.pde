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
    super(300, 300, 300, 300);

    pickIndicator.setOffset(this.getStartX(), this.getStartY());
  }

  public void draw()
  {
    image.beginDraw();
    image.colorMode(HSB, TWO_PI, saturationBrightnessPicker.max_saturation, saturationBrightnessPicker.max_brightness);

    // draw brightness scale
    for (int x = 0; x < this.getWidth (); x++) {
      for (int y = 0; y < this.getHeight (); y++) {

        float brightness = ruleOfThree(x, this.getWidth(), max_brightness);
        float saturation = ruleOfThree(y, this.getHeight(), max_saturation);

        float hue = hue(colorPicker.getColor());
        hue = wrapHue(hue);

        image.stroke(hue, saturation, brightness);
        image.point(x, y);
      }
    }

    image.endDraw();
  }
}

