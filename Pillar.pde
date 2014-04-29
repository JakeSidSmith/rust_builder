class Pillar extends Part {
  
  Pillar() {
    this(0, 0);
  }
  
  Pillar(float x, float y) {
    pos = new PVector(x, y);
    planks = 2;
  }
  
  void move() {
    pos.x = round(mouseX / (buildSize/8)) * (buildSize/8);
    pos.y = round(mouseY / (buildSize/8)) * (buildSize/8);
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
      translate(pos.x, pos.y + w/2);
      beginShape();
        vertex(-w/16, 0);
        vertex(-w/16, -w*0.75);
        vertex(0, -w*0.75 + w/32);
        vertex(0, w/32);
        vertex(-w/16, 0);
      endShape();
      beginShape();
        vertex(w/16, 0);
        vertex(w/16, -w*0.75);
        vertex(0, -w*0.75 + w/32);
        vertex(0, w/32);
        vertex(w/16, 0);
      endShape();
      translate(0, -w*0.75);
      beginShape();
        vertex(-w/16, 0);
        vertex(0, -w/32);
        vertex(w/16, 0);
        vertex(0, w/32);
        vertex(-w/16, 0);
      endShape();
    popMatrix();
  }
  
  void setDragged(int newx, int newy) {
    dragging = new Pillar(newx, newy);
  }
  
  void setPart() {
    building.add(new Pillar(pos.x, pos.y));
  }
  
}
