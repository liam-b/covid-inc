class Disease {
  public int population = 1000;
  public float healthcareCapacity = 0.1;
  public float personSize = 10;
  public float personSpeed = 7;
  public int recoveryTime = 200;
  public int deathTime = 100;
  public float chanceOfDeath = 1;
  public float chanceOfDeathWithoutHealthcare = 1;
  public float chanceOfInfection = 1;
  public float socialDistancingProportion = 0;
  
  public Disease(int population, float healthcareCapacity, float personSize, float personSpeed, int recoveryTime, int deathTime, float chanceOfDeath, float chanceOfDeathWithoutHealthcare, float chanceOfInfection, float socialDistancingProportion) {
    this.population = population;
    this.healthcareCapacity = healthcareCapacity;
    this.personSize = personSize;
    this.personSpeed = personSpeed;
    this.recoveryTime = recoveryTime;
    this.deathTime = deathTime;
    this.chanceOfDeath = chanceOfDeath;
    this.chanceOfDeathWithoutHealthcare = chanceOfDeathWithoutHealthcare;
    this.chanceOfInfection = chanceOfInfection;
    this.socialDistancingProportion = socialDistancingProportion;
  }
}
