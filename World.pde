class World {
  public Person[] people;
  public Disease disease;
  public HashMap<InfectionStage, Integer> infectionStageCount;
  public int healthcareCapacityAvailable;
  
  public World(Disease disease) {
    this.disease = disease;
    infectionStageCount = new HashMap<InfectionStage, Integer>();
    people = new Person[disease.population];
    for (int i = 0; i < people.length; i++) {
      people[i] = new Person(this);
    }
    people[0].infectionStage = InfectionStage.INFECTED;
  }
  
  public void draw() {
    healthcareCapacityAvailable = (int)(disease.healthcareCapacity * (float)disease.population);
    for (InfectionStage stage : InfectionStage.stages) {
      infectionStageCount.put(stage, 0);
    }
    
    noStroke();
    for (int i = 0; i < people.length; i++) {
      people[i].draw();
      int count = infectionStageCount.get(people[i].infectionStage);
      infectionStageCount.put(people[i].infectionStage, count + 1);
    }
    
    deathTally.setText("Deaths: " + infectionStageCount.get(InfectionStage.DEAD));
  }
  
  void destroy() {
    for (int i = 0; i < people.length; i++) {
      box2d.destroyBody(people[i].body);
    }
  }
}
