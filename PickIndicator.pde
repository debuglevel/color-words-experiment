public class PickIndicator
{
  private int[] offset;
  private float[] position;
  private Picker picker;

  public PickIndicator(Picker picker)
  {
    this.picker = picker;
    
    position = new float[2];
    position[0] = 0;
    position[1] = 0;

    offset = new int[2];
  }

  public void setOffset(int x, int y)
  {
    //println("set offset: X="+x+" Y="+y);
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
    //println("absolute set X="+x+" Y="+y);

    float currentX = absoluteXf();
    float currentY = absoluteYf();
    float newX = x;
    float newY = y;

    if (picker.isInRange(newX, currentY))
    {
      //println("x");
      this.position[0] = x - float(this.offset[0]);
    }

    if (picker.isInRange(newY, currentX))
    {
      //println("y");
      this.position[1] = y - float(this.offset[1]);
    }
  }

  public void relativeSet(float x, float y)
  {
    //println("reativeSet X="+x+" Y="+y);
    
    this.absoluteSet(this.offset[0] + x, this.offset[1] + y);
  }

  public void change(float x, float y)
  {
    //println("change X="+x+" Y="+y);
    
    float currentX = absoluteXf();
    float currentY = absoluteYf();

    this.absoluteSet(currentX + x, currentY + y);
  }

  public float absoluteXf()
  {
    return this.offset[0] + this.position[0];
  }
  
  public int absoluteX()
  {
    return int(absoluteXf());
  }

  public float absoluteYf()
  {
    return this.offset[1] + this.position[1];
  }
  
  public int absoluteY()
  {
    return int(absoluteYf());
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

