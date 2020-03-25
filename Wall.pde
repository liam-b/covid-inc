public Body createWall(PVector start, PVector end) {
  Body body = createBody(BodyType.STATIC);
  EdgeShape shape = new EdgeShape();
  shape.set(box2d.vectorPixelsToWorld(start), box2d.vectorPixelsToWorld(end));
  
  FixtureDef fd = new FixtureDef();
  fd.shape = shape;
  fd.friction = 0;
  fd.restitution = 1;
  body.createFixture(fd);
  
  return body;
}
