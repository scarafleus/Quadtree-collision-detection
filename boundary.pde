class Boundary {
  float x, y, w, h;
  
  Boundary(float x_, float y_, float w_, float h_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
  }
  
  void show() {
    strokeWeight(1);
    noFill();
    stroke(0, 255, 0);
    rect(x, y, w, h);
  }
}
