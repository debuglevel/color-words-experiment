abstract class ColorPicker
{
  int x = 0;
  int y = 100;
  int width = 100;
  int height = 100;

  int[] pickedColorPosition;

  PGraphics image;

  public ColorPicker()
  {
  }

  public void setup()
  {
    pickedColorPosition = new int[2];
    pickedColorPosition[0] = 0;
    pickedColorPosition[1] = 0;

    image = createGraphics(width, height);
  }

  public color getColor()
  {
    return image.get(pickedColorPosition[0], pickedColorPosition[1]);
  }

  public void setPickPositionAbsolute(int absoluteX, int absoluteY)
  {
    pickedColorPosition[0] = absoluteX - x;
    pickedColorPosition[1] = absoluteY - y;
  }
  
  public boolean isInRange(int absoluteX, int absoluteY)
  {
    return (absoluteY > colorPicker.y &&
      absoluteY < colorPicker.y + colorPicker.height &&
      absoluteX > colorPicker.x &&
      absoluteX < colorPicker.x + colorPicker.width);
  }

  public abstract void draw();
}

