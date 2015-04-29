abstract class ColorPicker
{
  int x = 0;
  int y = 100;
  int width = 100;
  int height = 100;
  
  PGraphics image;
  
  public ColorPicker()
  {
  }
  
  public void setup()
  {
    image = createGraphics(width, height);
  }
  
  public abstract void draw();
}
