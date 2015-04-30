abstract class ColorPicker extends Picker
{
  public ColorPicker(int x, int y, int width, int height)
  {
    super(x, y, width, height);

    pickIndicator.setOffset(this.getStartX(), this.getStartY());
  }

  public color getColor()
  {
    return image.get(this.pickIndicator.relativeX(), this.pickIndicator.relativeY());
  }

  public abstract void draw();
}

