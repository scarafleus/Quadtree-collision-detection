class Wall {
  
  PVector pos1, pos2;
  
  Wall(float x, float y, float x1, float y1) {
    pos1 = new PVector(x, y);
    pos2 = new PVector(x1, y1);
  }
  
  void show() {
    stroke(0, 0, 255);
    strokeWeight(5);
    line(pos1.x, pos1.y, pos2.x, pos2.y);
  }
  
  void collide() {
    //going to only let the lines be orthogonal to x axis or y axis, otherwise I would have to do a workaround and I just want to get it working rn
    Boundary range = new Boundary(pos1.x - 3, pos1.y - 3, pos2.x - pos1.x + 6, pos2.y - pos1.y + 6);
    range.show();
    ArrayList<Particle> nearby = new ArrayList<Particle>();
    nearby = q.getPoints(range);
    for (Particle p : nearby) {
      /*
      This is gonna get a bit complicated so bare with me,
      I want to calculate the reflection vector of both points colliding using their velocities,
      here's the link I'm using: https://math.stackexchange.com/questions/13261/how-to-get-a-reflection-vector
      For this I will first get the normal vector and normalize that, and then calculate the other two vectors, let's go
      */
      PVector n = new PVector(pos1.y - pos2.y, pos1.x - pos2.x);
      n.normalize();
      //formula I'm using: r=d−2(d°n)n
      PVector refl;
      refl = p.vel.sub(n.mult(2 * n.dot(p.vel)));
      refl.normalize();
      println("refl: " + refl.x + " " + refl.y);
      p.vel = refl;
    }
  }
}
