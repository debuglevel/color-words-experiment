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
    x = map(x, -1, 1, range_X_start, range_X_end);

    return (int)x;
  }

  public int Y()
  {
    float y = sliderY.getValue();
    y = map(y, -1, 1, range_Y_start, range_Y_end);

    return (int)y;
  }
}

