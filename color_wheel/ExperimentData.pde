class ExperimentData
{
  String VP_ID = "Undefined";
  String ColorWord = "Undefined";
  int Sequence = 999;
  int Iteration = 999;

  String[] colorWords = { 
    "Rot", "Grün", "Blau", "Gelb", "Schwarz", "Weiß"
  };

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

  void enterColor()
  {
    recordColor();
    experimentData.setNextColor();
  }

  void fileSelected(File selection) {
    if (selection == null) {
      println("Window was closed or the user hit cancel.");
    } else {
      println("User selected " + selection.getAbsolutePath());
      tableFile = selection.getAbsolutePath();
      experimentData.VP_ID = selection.getName();
    }
  }

  void initializeTable()
  {
    table = new Table();

    table.addColumn("Row_ID");
    table.addColumn("DateTime");

    table.addColumn("VP_ID");

    table.addColumn("ColorWord");

    table.addColumn("Iteration");
    table.addColumn("Sequence");

    table.addColumn("Red");
    table.addColumn("Green");
    table.addColumn("Blue");

    table.addColumn("Hue");
    table.addColumn("Saturation");
    table.addColumn("Brightness");
  }

  String prependZero(String s, int digits)
  {
    while (s.length () < digits)
    {
      s = "0"+s;
    }

    return s;
  }

  String getCurrentDateTime()
  {
    String d = prependZero(String.valueOf(day()), 2);
    String mon = prependZero(String.valueOf(month()), 2);
    String y = prependZero(String.valueOf(year()), 4);
    String h = prependZero(String.valueOf(hour()), 2);
    String min = prependZero(String.valueOf(minute()), 2);
    String s = prependZero(String.valueOf(second()), 2);

    return y+"-"+mon+"-"+y+" "+h+":"+min+":"+s;
  }

  void recordColor()
  {
    color currentColor = getPickedColor();

    TableRow newRow = table.addRow();
    newRow.setInt("Row_ID", table.getRowCount() - 1);
    newRow.setString("DateTime", getCurrentDateTime());

    newRow.setString("VP_ID", experimentData.VP_ID);

    newRow.setString("ColorWord", experimentData.ColorWord);

    newRow.setInt("Iteration", experimentData.Iteration);
    newRow.setInt("Sequence", experimentData.Sequence);

    newRow.setFloat("Red", red(currentColor));
    newRow.setFloat("Green", green(currentColor));
    newRow.setFloat("Blue", blue(currentColor));

    newRow.setFloat("Hue", hue(currentColor));
    newRow.setFloat("Saturation", saturation(currentColor));
    newRow.setFloat("Brightness", brightness(currentColor));
  }

  void writeTable()
  {
    saveTable(table, tableFile+".csv");
  }
}

