class ExperimentData
{
  String VP_ID = "Undefined";
  String ColorWord = "Undefined";
  int Sequence = 999;
  int Iteration = 999;
  
  String[] colorWords = { "Rot", "Grün", "Blau", "Gelb", "Schwarz", "Weiß" };

  ExperimentData()
  {
  }
  
  String getRandomColorWord()
  {
    int index = int(random(colorWords.length));
    return this.colorWords[index];
  }
  
  void setNextColor()
  {
    experimentData.ColorWord = this.getRandomColorWord();
  }
}
