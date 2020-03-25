class Person { 
  public InfectionStage infectionStage = InfectionStage.HEALTHY;
  public int infectionTimer = 0;
  public boolean isSocialDistancing = false;
  public World world;
  private Body body;
  
  public Person(World world) {
    this.world = world;
    
    isSocialDistancing = random(1) < world.disease.socialDistancingProportion;
    if (isSocialDistancing) body = createBody(BodyType.STATIC);
    else body = createBody(BodyType.DYNAMIC);
    
    body.setTransform(randomScreenPosition(), 0);
    Vec2 vel = new Vec2(random(-1,1), random(-1,1));
    vel.normalize();
    vel.mulLocal(world.disease.personSpeed);
    body.setLinearVelocity(vel);
    body.setLinearDamping(0);
    body.setUserData(this);
    
    CircleShape cs = new CircleShape();
    cs.m_radius = world.disease.personSize / 2;
    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    fd.density = 1;
    fd.friction = 0;
    fd.restitution = 1;
    body.createFixture(fd);
  }
  
  public void draw() {    
    if (infectionStage == InfectionStage.INFECTED) {
      infectionTimer++;
      world.healthcareCapacityAvailable--;
    }
    
    if (infectionTimer == world.disease.deathTime && infectionStage == InfectionStage.INFECTED) {
      float chance = world.disease.chanceOfDeathWithoutHealthcare;
      if (world.healthcareCapacityAvailable >= 0) chance = world.disease.chanceOfDeath;
      
      if (random(1) < chance) {
        infectionStage = InfectionStage.DEAD;
        box2d.destroyBody(body);
      }
    }
    
    if (infectionTimer > world.disease.recoveryTime && infectionStage == InfectionStage.INFECTED) {
      infectionStage = InfectionStage.RECOVERED;
    }
    
    PVector pos = box2d.coordWorldToPixelsPVector(body.m_xf.p);
    fill(infectionStage.col);
    circle(pos.x, pos.y, box2d.scalarWorldToPixels(world.disease.personSize));
  }
  
  public void contact(Person person) {
    if (infectionStage == InfectionStage.INFECTED && person.infectionStage == InfectionStage.HEALTHY) {
      if (random(1) < world.disease.chanceOfInfection) person.infectionStage = InfectionStage.INFECTED;
    }
  }
  
  private Vec2 randomScreenPosition() {
    PVector pos = new PVector(random(-width / 2, width / 2), random(-height / 2, height / 2));
    return box2d.vectorPixelsToWorld(pos);
  }
}

class PersonContactListener implements ContactListener {
  void beginContact (Contact contact) {
    if (contact.getFixtureA().getBody().getUserData() instanceof Person && contact.getFixtureB().getBody().getUserData() instanceof Person) {
      Person personA = (Person)contact.getFixtureA().getBody().getUserData();
      Person personB = (Person)contact.getFixtureB().getBody().getUserData();
      
      personA.contact(personB);
      personB.contact(personA);
    }
  }
  
  void endContact(Contact contact) {}
  void postSolve(Contact contact, ContactImpulse impulse) {}
  void preSolve(Contact contact, Manifold oldManifold) {}
}
