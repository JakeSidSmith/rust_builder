class Part {
  
  boolean flipped = false;
  PVector pos;
  int planks = 0;
  
  Part() {
    pos = new PVector(0, 0);
  }
  
  Part(int x, int y) {
    pos = new PVector(x, y);
  }
  
  void move() {
    pos.x = round(mouseX / (buildSize/4)) * (buildSize/4);
    pos.y = round(mouseY / (buildSize/4)) * (buildSize/4);
  }
  
  void display(float w) {
    
  }
  
  void setDragged(int x, int y) {
    
  }
  
  void setPart() {
    
  }
  
  void addPlanks() {
    totalPlanks += planks;
  }
  
  void removePlanks() {
    totalPlanks -= planks;
  }
  
}
