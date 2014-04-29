class Foundation extends Part {

  Foundation() {
    this(0, 0);
  }
  
  Foundation(float x, float y) {
    pos = new PVector(x, y);
    planks = 8;
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
      translate(pos.x, pos.y + w/4);
      beginShape();
        vertex(-w/2, 0);
        vertex(-w/2, -w/4);
        vertex(0, 0);
        vertex(0, w/4);
        vertex(-w/2, 0);
      endShape();
      beginShape();
        vertex(0, 0);
        vertex(w/2, -w/4);
        vertex(w/2, 0);
        vertex(0, w/4);
        vertex(0, 0);
      endShape();
      translate(0, -w/4);
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
    dragging = new Foundation(newx, newy);
  }
  
  void setPart() {
    building.add(new Foundation(pos.x, pos.y));
  }
  
  void mouseReleased() {
    println("Released Foundation");
  }
  
}
