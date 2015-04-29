class BrightnessPicker
{
  int x = 0;
  int y = 400;
  int width = window_width;
  int height = 100;

  float lumosity = 300;
  float max_lumosity = 300;

  public void BrightnessPicker()
  {
  }

  void display()
  {
    // draw brightness scale
    for (int x = 0; x < width; x++) {
      float currentLumosity = ruleOfThree(x, width, max_lumosity);

      stroke(0, 0, currentLumosity);
      line(this.x + x, 
      y, 
      this.x + x, 
      y + height);
    }

    // indicator for current lumosity
    float currentLumosity = ruleOfThree(lumosity, max_lumosity, width);
    line(
    this.x + currentLumosity, 
    y - 2, 
    this.x + currentLumosity, 
    y + height + 2);
  }

  public boolean isInRange(int absoluteX, int absoluteY)
  {
    return (absoluteY > this.y &&
      absoluteY < this.y + this.height &&
      absoluteX > this.x &&
      absoluteX < this.x + this.width);
  }

  public void setLumosity(int x, int y)
  {
    lumosity = ruleOfThree(x - x, width, max_lumosity);
    lumosity = constrain(lumosity, 0, max_lumosity);
  }
}

