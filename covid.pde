import shiffman.box2d.*;
import grafica.*;
import controlP5.*;

import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;
import org.jbox2d.common.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.callbacks.*;
import org.jbox2d.collision.*;

PApplet applet = this;
Box2DProcessing box2d;
ControlP5 cp5;
World world;
Graph populationGraph;
Group diseaseMenu;
Textlabel deathTally;

void settings() {
  size(800, 800);
}

void setup() {
  //surface.setResizable(true);
  cp5 = new ControlP5(this);
  diseaseMenu = createDiseaseMenu();
  deathTally = cp5.addTextlabel("deaths")
    .setText("Deaths:")
    .setPosition(16, height - 110);
    //.setColorValue(0xffffff00);
    //.setFont(createFont("Georgia",20));
  
  reset(new Disease(800, 0.1, 1, 7, 350, 1, 1, 1, 0.8, 0.1));
}

void draw() {
  background(30);

  box2d.step();
  world.draw();
  populationGraph.draw();
}

void keyPressed() {
  if (key == ' ' || key == ESC) {
    if (diseaseMenu.isVisible()) diseaseMenu.hide();
    else diseaseMenu.show();
  }
}

void reset(Disease disease) {
  box2d = new Box2DProcessing(this, width * 10/800);
  box2d.createWorld();
  box2d.setGravity(0, 0);
  box2d.world.setContactListener(new PersonContactListener());

  createWall(new PVector(-width/2, height/2), new PVector(width/2, height/2));
  createWall(new PVector(width/2, height/2), new PVector(width/2, -height/2));
  createWall(new PVector(-width/2, -height/2), new PVector(width/2, -height/2));
  createWall(new PVector(-width/2, height/2), new PVector(-width/2, -height/2));

  world = new World(disease);
  populationGraph = new Graph(world);
  frameCount = 1;
}

void infect(int val) {
  diseaseMenu.hide();
  reset(createDisease(diseaseMenu));
}

public Body createBody(BodyType type) {
  BodyDef def = new BodyDef();
  def.type = type;
  return box2d.createBody(def);
}
