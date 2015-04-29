class Joystick
{
  private boolean isActive = false;

  private ControlIO control;
  private ControlDevice device;
  private ControlSlider sliderX;
  private ControlSlider sliderY;
  private ControlButton button;

  private float rangeX_start;
  private float rangeY_start;
  private float rangeX_end;
  private float rangeY_end;

  public Joystick(PApplet applet)
  {   
    if (!isActive)
    {
      return;
    }

    control = ControlIO.getInstance(applet);

    // name of the Joystick
    device = control.getDevice("Joystick - HOTAS Warthog");

    // names of the buttons and sliders we use
    button = device.getButton("Taste 0");
    sliderX = device.getSlider("X-Achse");
    sliderY = device.getSlider("Y-Achse");

    // set tolerance to some value, as a joystick slider will probably never be exact 0.00
    sliderX.setTolerance(0.05);
    sliderY.setTolerance(0.05);
  }

  public void setSliderRange(int x_start, int y_start, int x_end, int y_end)
  {
    rangeX_start = x_start;
    rangeY_start = y_start;
    rangeX_end = x_end;
    rangeY_end = y_end;
  }

  public int getSliderPositionX()
  {
    float rawValue = sliderX.getValue();
    float x = map(rawValue, -1, 1, rangeX_start, rangeX_end);

    return (int)x;
  }

  public int getSliderPositionY()
  {
    float rawValue = sliderY.getValue();
    float y = map(rawValue, -1, 1, rangeY_start, rangeY_end);

    return (int)y;
  }
}

