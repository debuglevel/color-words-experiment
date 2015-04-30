class JoystickSliders
{
  public ControlDevice device;

  private ControlSlider sliderX;
  private ControlSlider sliderY;

  private float range_X_start;
  private float range_Y_start;
  private float range_X_end;
  private float range_Y_end;

  public JoystickSliders()
  {
  }

  public void setSliders(String sliderNameX, String sliderNameY)
  {
    sliderX = device.getSlider(sliderNameX);
    sliderY = device.getSlider(sliderNameY);

    // set tolerance to some value, as a joystick slider will probably never be exact 0.00
    sliderX.setTolerance(0.05);
    sliderY.setTolerance(0.05);
  }

  public void setRange(int x_start, int y_start, int x_end, int y_end)
  {
    range_X_start = x_start;
    range_Y_start = y_start;
    range_X_end = x_end;
    range_Y_end = y_end;
  }

  public int X()
  {
    float x = sliderX.getValue();
    float y = sliderY.getValue();

    float distance = sqrt(x * x + y * y);
    if (distance > 1.0f) // maps the rectangular position to a circle 
    {
      x /= distance;
      y /= distance;
    } else if (distance < 1.0f) // forces the position to a circle of radius 1 (even if the joystick is tilted little)
    {
      x /= distance;
      y /= distance;
    }

    x = map(x, -1, 1, range_X_start, range_X_end);

    return (int)x;
  }

  public int Y()
  {
    float x = sliderX.getValue();
    float y = sliderY.getValue();

    float distance = sqrt(x * x + y * y);
    if (distance > 1.0f)
    {
      x /= distance;
      y /= distance;
    } else if (distance < 1.0f)
    {
      x /= distance;
      y /= distance;
    }

    y = map(y, -1, 1, range_Y_start, range_Y_end);

    return (int)y;
  }

  public float rawX()
  {
    return sliderX.getValue();
  }

  public float rawY()
  {
    return sliderY.getValue();
  }

  public int rectangularX()
  {
    float x = sliderX.getValue();
    x = map(x, -1, 1, range_X_start, range_X_end);

    return (int)x;
  }

  public int rectangularY()
  {
    float y = sliderY.getValue();
    y = map(y, -1, 1, range_Y_start, range_Y_end);

    return (int)y;
  }
}

