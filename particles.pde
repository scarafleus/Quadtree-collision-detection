class Particle {
  
  PVector pos;
  PVector vel;
  
  Particle(float x, float y) {
    pos = new PVector(x, y);
    vel = new PVector(random(1), random(1));
    vel.normalize();
  }
  
  void show() {
    stroke(255, 0, 0);
    strokeWeight(6);
    point(pos.x, pos.y);
  }
  
  void update() {
    if (pos.x > width) pos.x = 0;
    if (pos.y > height) pos.y = 0;
    if (pos.x < 0) pos.x = width;
    if (pos.y < 0) pos.y = height;
    pos.add(vel);
  }
}
