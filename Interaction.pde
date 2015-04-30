class Interaction
{
  float offset = 0;

  // event
  void keyPressed() {
    //println("Key pressed");

    if (key == CODED) 
    {
      if (keyCode == LEFT) 
      {
        changeOffset(-0.1);
      } else if (keyCode == RIGHT) 
      {
        changeOffset(+0.1);
      }
    }
  }
  
  void changeOffset(float offset)
  {
    interaction.offset += offset;
    colorPicker.draw();
  }

  void keyTyped() {
    //println("Key: typed " + int(key) + " " + keyCode);

    if (key == RETURN || key == ENTER)
    {
      //println("Key: Return/Enter");
      experimentData.enterColor(colorPicker.getColor());
    } else if (key == TAB)
    {
      //println("Key: Tab");
      experimentData.writeTable();
    } else if (key == DELETE)
    {
      selectOutput("Output file where filename equals the VP_ID", "fileSelected");
    }
  }

  void joystickInteraction()
  {
    if (joystick.isActive == false)
    {
      return;
    }

    // colorPicker
    if (colorPicker instanceof HorizontalColorPicker)
    {
      HorizontalColorPicker horizontalColorPicker = (HorizontalColorPicker)colorPicker;

      horizontalColorPicker.joystickMove();
    } else if (colorPicker instanceof CircularColorPicker)
    {
      CircularColorPicker circularColorPicker = (CircularColorPicker)colorPicker;

      circularColorPicker.joystickMove();
    }
  }

  void mouseInteraction()
  {
    if (mousePressed) {
      // colorPicker
      if (colorPicker instanceof HorizontalColorPicker)
      {
        if (colorPicker.isInRange(mouseX, mouseY))
        {
          colorPicker.setPickPositionAbsolute(mouseX, mouseY);
        }
      } else if (colorPicker instanceof CircularColorPicker)
      {
        CircularColorPicker circularColorPicker = (CircularColorPicker)colorPicker;

        circularColorPicker.mouseMove();
      }

      // brightnessPicker
      if (brightnessPicker.isInRange(mouseX, mouseY))
      {
        brightnessPicker.setLumosity(mouseX, mouseY);
      }
    }
  }
}

