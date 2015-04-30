public class JoystickHat
{
  public ControlDevice device;
  private ControlHat hat;

  public JoystickHat()
  {
  }

  public void setHat(String hatName)
  {
    hat = device.getHat(hatName);
  }
  
  public float X()
  {
    return hat.getX();
  }
  
  public float Y()
  {
    return hat.getY();
  }
}

