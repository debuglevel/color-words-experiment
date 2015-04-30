class Joystick
{
  private boolean isActive = true;

  private ControlIO control;
  private ControlDevice device;

  private ControlButton button;

  public JoystickSliders sliders = new JoystickSliders();
  public JoystickHat hat = new JoystickHat();

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

    sliders.device = device;
    sliders.setSliders("X-Achse", "Y-Achse");
    
    hat.device = device;
    hat.setHat("cooliehat: Mehrwegeschalter");
  }
}

