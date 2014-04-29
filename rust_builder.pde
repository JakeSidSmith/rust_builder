Sidebar sidebar;
Part dragging;
int buildSize = 80;
int totalPlanks = 0;

ArrayList<Part> building = new ArrayList<Part>();

color partFill = color(0, 20);
color partStroke = color(0, 150);
color partHoverFill = color(100, 150);
color placeableFill = color(0, 255, 0, 80);

void setup(){
  size(640, 640);
  frameRate(30);
  ellipseMode(CENTER);
  textAlign(RIGHT);
  reset();
}

void draw(){
  background(255);
  
  fill(0);
  text("Wood " + totalPlanks*10, width-220, 20, 200, 20);
  text("Planks " + totalPlanks, width-220, 40, 200, 20);
  
  /*lights();
  fill(200);
  //camera(0, 0, 100, 0, 1, 0);
  //box(0, 0, 0, 100, 100, 100);
  pushMatrix();
  translate(width/2, height/2, -200);
  //sphere(200);
  //rotateY(radians(45));
  rotateX(radians(45));
  rotateZ(radians(45));
  box(100, 100, 100);
  popMatrix();*/
  
  sidebar.display();
  
  if (dragging != null) {
    dragging.move();
    dragging.display(buildSize);
  }
  
  for (int i = 0; i < building.size(); i += 1) {
    Part part = building.get(i);
    part.display(buildSize);
  }
}

void reset() {
  sidebar = new Sidebar();
}

void mousePressed() {
  for (int i = 0; i < sidebar.parts.size(); i += 1) {
    Part part = sidebar.parts.get(i);
    if (dist(mouseX, mouseY, part.pos.x, part.pos.y) < sidebar.iconSize / 2) {
      part.setDragged(mouseX, mouseY);
    }
  }
  for (int i = 0; i < building.size(); i += 1) {
    Part part = building.get(i);
    if (dist(mouseX, mouseY, part.pos.x, part.pos.y) < sidebar.iconSize / 2) {
      part.removePlanks();
      part.setDragged(mouseX, mouseY);
      building.remove(part);
      part = null;
    }
  }
}

void mouseReleased() {
  if (dragging != null && mouseX > sidebar.w) {
    dragging.setPart();
    dragging.addPlanks();
  }
  dragging = null;
}
