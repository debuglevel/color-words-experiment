public class PickIndicator
{
  private int[] offset;
  private float[] position;

  public PickIndicator()
  {
    position = new float[2];
    position[0] = 0;
    position[1] = 0;

    offset = new int[2];
  }

  public void setOffset(int x, int y)
  {
    println("set offset: X="+x+" Y="+y);
    offset[0] = x;
    offset[1] = y;
  }

  public void display()
  {
    rectMode(CENTER);
    noFill();

    stroke(0, 0, saturationBrightnessPicker.max_brightness);
    rect(this.absoluteX(), this.absoluteY(), 5, 5);
  }

  public void absoluteSet(float x, float y)
  {
    this.position[0] = x - this.offset[0];
    this.position[1] = y - this.offset[1];

    this.display();
  }

  public void relativeSet(float x, float y)
  {
    this.position[0] = x;
    this.position[1] = y;

    this.display();
  }

  public int absoluteX()
  {
    return int(this.offset[0] + this.position[0]);
  }

  public int absoluteY()
  {
    return int(this.offset[1] + this.position[1]);
  }

  public int relativeX()
  {
    return int(this.position[0]);
  }

  public int relativeY()
  {
    return int(this.position[1]);
  }
}

