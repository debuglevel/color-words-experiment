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
        offset -= 0.1;
      } else if (keyCode == RIGHT) 
      {
        offset += 0.1;
      }

      colorPicker.draw();
    }
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
      if (colorPicker.isInRange(mouseX, mouseY))
      {
        colorPicker.setPickPositionAbsolute(mouseX, mouseY);
      }
    } else if (colorPicker instanceof CircularColorPicker)
    {
      CircularColorPicker circularColorPicker = (CircularColorPicker)colorPicker;

      float relativePositionX = colorPicker.x - joystick.sliders.X();
      float relativePositionY = colorPicker.y - joystick.sliders.Y();

      println("X = " + relativePositionX + " | Y = " + relativePositionY);

      float distance = dist(relativePositionX, relativePositionY, circularColorPicker.outerRadius, circularColorPicker.outerRadius);

      if (distance < circularColorPicker.outerRadius && distance > circularColorPicker.innerRadius) {
        colorPicker.setPickPositionAbsolute(joystick.sliders.X(), joystick.sliders.Y());
      }
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


        float relativePositionX = mouseX - colorPicker.x;
        float relativePositionY = mouseY - colorPicker.y;

        // calulcate saturation by distance from the middle
        float distance = dist(relativePositionX, relativePositionY, circularColorPicker.outerRadius, circularColorPicker.outerRadius);

        if (distance < circularColorPicker.outerRadius && distance > circularColorPicker.innerRadius) {
          colorPicker.setPickPositionAbsolute(mouseX, mouseY);
        }
      }

      // brightnessPicker
      if (brightnessPicker.isInRange(mouseX, mouseY))
      {
        brightnessPicker.setLumosity(mouseX, mouseY);
      }
    }
  }
}

