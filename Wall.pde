class Wall extends Part {
  
  Wall() {
    this(0, 0);
  }
  
  Wall(float x, float y) {
    pos = new PVector(x, y);
    planks = 4;
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
      translate(pos.x + w/4, pos.y + w/2);
      beginShape();
        vertex(-w/2, 0);
        vertex(-w/2, -w*0.75);
        vertex(0, -w);
        vertex(0, -w*0.25);
        vertex(-w/2, 0);
      endShape();
    popMatrix();
  }
  
  void setDragged(int newx, int newy) {
    dragging = new Wall(newx, newy);
  }
  
  void setPart() {
    building.add(new Wall(pos.x, pos.y));
  }
  
}
