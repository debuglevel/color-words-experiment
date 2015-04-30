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
    super(333, 333, 200, 200);

    pickIndicator.setOffset(this.getStartX(), this.getStartY());
  }

  public void draw()
  {
    this.drawScale();
  }

  private void drawScale()
  {
    image.beginDraw();
    image.colorMode(HSB, TWO_PI, saturationBrightnessPicker.max_saturation, saturationBrightnessPicker.max_brightness);

    // draw brightness scale
    for (int currentX = this.getStartX (); currentX < this.getEndX(); currentX++) 
    {
      for (int currentY = this.getStartY (); currentY < this.getEndY(); currentY++)
      {
        float brightness = ruleOfThree(currentX-this.getStartX(), this.getWidth(), max_brightness);
        float saturation = ruleOfThree(currentY-this.getStartY(), this.getHeight(), max_saturation);

        float hue = hue(colorPicker.getColor());
        hue = wrapHue(hue);

        image.stroke(hue, saturation, brightness);
        image.point(currentX, currentY);
      }
    }

    image.endDraw();
  }
}

