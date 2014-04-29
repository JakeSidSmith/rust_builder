class Ceiling extends Part {
  
  Ceiling() {
    this(0, 0);
  }
  
  Ceiling(float x, float y) {
    pos = new PVector(x, y);
    planks = 6;
  }
  
  void move() {
    pos.x = round(mouseX / (buildSize/4)) * (buildSize/4);
    pos.y = round(mouseY / (buildSize/4)) * (buildSize/4);
  }
  
  void display(float w) {
    fill(partFill);
    stroke(partStroke);
    
    if (dragging == null) {
      if (dist(mouseX, mouseY, pos.x, pos.y) < sidebar.iconSize / 2) {
        fill(partHoverFill);
      }
    }
    
    pushMatrix();
      translate(pos.x, pos.y);
      beginShape();
        vertex(-w/2, 0);
        vertex(0, -w/4);
        vertex(w/2, 0);
        vertex(0, w/4);
        vertex(-w/2, 0);
      endShape();
    popMatrix();
  }
  
  void setDragged(int newx, int newy) {
    dragging = new Ceiling(newx, newy);
  }
  
  void setPart() {
    building.add(new Ceiling(pos.x, pos.y));
  }
  
}
