public class SaturationBrightnessPicker
{
  int x = 100;
  int y = 200;
  int width = 200;
  int height = 200;

  float max_lumosity = 300;

  public int[] pickedPosition;

  public SaturationBrightnessPicker()
  {
    pickedPosition = new int[2];
    pickedPosition[0] = 0;
    pickedPosition[1] = 0;
  }

  void draw()
  {
    colorMode(HSB, TWO_PI, 1, brightnessPicker.max_lumosity);

    // draw brightness scale
    for (int currentX = x; currentX < x+width; currentX++) {
      for (int currentY = y; currentY < y+height; currentY++)
      {

        float brightness = ruleOfThree(currentX-x, width, max_lumosity);
        float saturation = ruleOfThree(currentY-y, height, 1);

        float hue = hue(colorPicker.getColor());
        hue = wrapHue(hue);
        //println(saturation);

        //stroke(hue, 1, 300);
        stroke(hue, saturation, brightness);
        point(currentX, currentY);
      }
    }
  }
}

