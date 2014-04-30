class Wall extends Part {
  
  Wall() {
    this(0, 0);
  }
  
  Wall(float x, float y) {
    pos = new PVector(x, y);
    planks = 4;
  }
  
  Wall(float x, float y, boolean flipped) {
    pos = new PVector(x, y);
    planks = 4;
    this.flipped = flipped;
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
      translate(pos.x, pos.y + w/2);
      if (flipped) {
        scale(-1, 1);
      }
      beginShape();
        vertex(-w/4, 0);
        vertex(-w/4, -w*0.75);
        vertex(w/4, -w);
        vertex(w/4, -w*0.25);
        vertex(-w/4, 0);
      endShape();
    popMatrix();
  }
  
  void setDragged(int newx, int newy) {
    dragging = new Wall(newx, newy);
  }
  
  void setPart() {
    building.add(new Wall(pos.x, pos.y, flipped));
  }
  
}
