class Graph {
  private GPlot plot;
  private World world;
  private HashMap<InfectionStage, GPointsArray> infectionStagePoints;
  private GPointsArray healthcareCapacity;

  public Graph(World world) {
    this.world = world;

    plot = new GPlot(applet);
    plot.setPos(10, height - 200/2 - 10*2);
    plot.setOuterDim(300, 200);
    plot.setLineColor(color(100, 100, 100));

    plot.getXAxis().setAxisLabelText("Time");
    plot.getYAxis().setAxisLabelText("Population");
    plot.setYLim(0, world.disease.population);

    plot.setHorizontalAxesNTicks(3);
    plot.setVerticalAxesNTicks(3);
    plot.setMar(5, 5, 5, 5);

    infectionStagePoints = new HashMap<InfectionStage, GPointsArray>();
    for (InfectionStage stage : InfectionStage.stages) {
      GPointsArray array = new GPointsArray();
      infectionStagePoints.put(stage, array);

      plot.addLayer(stage.label, array);
      plot.getLayer(stage.label).setLineColor(stage.col);
    }

    healthcareCapacity = new GPointsArray();
    plot.addLayer("Healthcare capacity", healthcareCapacity);
    plot.getLayer("Healthcare capacity").setLineColor(#d4d272);
    plot.getLayer("Healthcare capacity").setLineWidth(2);
  }

  public void draw() {
    if (world.infectionStageCount.get(InfectionStage.INFECTED) != 0) {
      int accumulativeValue = 0;
      for (InfectionStage stage : InfectionStage.stages) {
        GPointsArray array = infectionStagePoints.get(stage);
        int newValue = world.infectionStageCount.get(stage);

        array.add(new GPoint(frameCount, newValue + accumulativeValue));
        accumulativeValue += newValue;

        plot.getLayer(stage.label).setPoints(array);
      }

      healthcareCapacity.add(frameCount, world.disease.healthcareCapacity * world.disease.population);
      plot.getLayer("Healthcare capacity").setPoints(healthcareCapacity);
      plot.setXLim(2, frameCount);
    }

    plot.beginDraw();
    plot.drawBackground();
    plot.getLayer("Dead").drawFilledContour(GPlot.HORIZONTAL, 0);
    plot.getLayer("Recovered").drawFilledContour(GPlot.HORIZONTAL, 0);
    plot.getLayer("Healthy").drawFilledContour(GPlot.HORIZONTAL, 0);
    plot.getLayer("Infected").drawFilledContour(GPlot.HORIZONTAL, 0);
    plot.getLayer("Healthcare capacity").drawLines();
    plot.endDraw();
  }
}
