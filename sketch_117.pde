/*
Quadtree

checking every particle against every other particle each frame would require 500^2 computations / frame, with the quadtree it should be 500 * log 500 which is approximately 1349 instead of 25000
-Hannes Richter 3.2018
*/

Quadtree q;
Particle[] pt = new Particle[500];
Boundary b;
int index = 0;
Wall[] walls = new Wall[4];

void setup() {
  size(800, 800);
  
  b = new Boundary(0, 0, width, height);
  
  q = new Quadtree(b, 1);
  
  walls[0] = new Wall(200, 200, 300, 200);
  walls[1] = new Wall(350, 500, 380, 502);
  walls[2] = new Wall(600, 300, 680, 300);
  walls[3] = new Wall(600, 600, 600, 710);
  
  for (int i = 0; i < pt.length; i++) {
    pt[i] = new Particle(random(width), random(height));
    q.insert(pt[i]);
  }
}

void draw() {
  background(255);
  
  q = new Quadtree(b, 1);
  for (int i = 0; i < pt.length; i++) {
    pt[i].show();
    pt[i].update();
    q.insert(pt[i]);
  }
  
  for (int i = 0; i < walls.length; i++) {
    walls[i].show();
    walls[i].collide();
  }
  
  q.show();
  Boundary creativeName = new Boundary(mouseX - 100, mouseY - 100, 200, 200);
  creativeName.show();
  ArrayList<Particle> temp = new ArrayList<Particle>();
  temp = q.getPoints(creativeName);
  for (Particle t : temp) {
    stroke(0, 255, 0);
    strokeWeight(7);
    point(t.pos.x, t.pos.y);
  }
}


class Quadtree {
  
  Boundary b;
  int capacity = 5;
  ArrayList<Particle> ps = new ArrayList<Particle>();
  Quadtree tl, tr, bl, br; //top left, top right, bottom left, bottom right
  boolean split = false;
  int order = 0;
  
  Quadtree(Boundary b_, int o) {
    b = b_;
    order = o;
  }
  
  boolean insert(Particle p) {
    if (p.pos.x < b.x + b.w && p.pos.y < b.y + b.h && p.pos.x > b.x && p.pos.y > b.y) {
      if (ps.size() < capacity) {
        ps.add(p);
        return true;
      } else {
        if (split == false) {
          tl = new Quadtree(new Boundary(b.x, b.y, b.w / 2, b.h / 2), order+1);
          tr = new Quadtree(new Boundary(b.x + b.w / 2, b.y, b.w / 2, b.h / 2), order+1);
          bl = new Quadtree(new Boundary(b.x, b.y + b.h / 2, b.w / 2, b.h / 2), order+1);
          br = new Quadtree(new Boundary(b.x + b.w / 2, b.y + b.h / 2, b.w / 2, b.h / 2), order+1);
          split = true;
        }
        if (tl.insert(p)) return true;
        if (tr.insert(p)) return true;
        if (bl.insert(p)) return true;
        if (br.insert(p)) return true;
        return true;
      }
    } else {
      return false;
    }
  }
  
  void show() {
    stroke(0);
    noFill();
    strokeWeight(1);
    rect(b.x, b.y, b.w, b.h);
    try { tl.show(); } catch(Exception e) {} 
    try { tr.show(); } catch(Exception e) {} 
    try { bl.show(); } catch(Exception e) {} 
    try { br.show(); } catch(Exception e) {} 
    fill(0);
    text(ps.size(), b.x + b.w / 2, b.y + b.h / 2);
  }
  
  ArrayList<Particle> getPoints(Boundary bb) {
    ArrayList<Particle> out = new ArrayList<Particle>();
    for (Particle pa : ps) {
      if (pa.pos.x > bb.x && pa.pos.y > bb.y && pa.pos.x < bb.x + bb.w && pa.pos.y < bb.y + bb.h) {
        out.add(pa);
      }
    }
    if (split) {
      out.addAll(tl.getPoints(bb));
      out.addAll(tr.getPoints(bb));
      out.addAll(bl.getPoints(bb));
      out.addAll(br.getPoints(bb));
    }
    return out;
  }
}
