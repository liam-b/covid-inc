static class InfectionStage {
  public static ArrayList<InfectionStage> stages = new ArrayList<InfectionStage>();
  public final color col;
  public final String label;
  
  public static final InfectionStage INFECTED = new InfectionStage("Infected", #d47272);
  public static final InfectionStage HEALTHY = new InfectionStage("Healthy", #91d472);
  //public static final InfectionStage QUARANTINED = new InfectionStage("Quarantined", #d4d272);
  public static final InfectionStage RECOVERED = new InfectionStage("Recovered", #729bd4);
  public static final InfectionStage DEAD = new InfectionStage("Dead", #444444);
  
  private InfectionStage(String label, color col) {
    this.col = col;
    this.label = label;
    stages.add(this);
  }
}
