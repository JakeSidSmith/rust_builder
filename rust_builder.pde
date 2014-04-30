/* @pjs preload="background.png" */
/* @pjs preload="logo.png"; */

Sidebar sidebar;
Part dragging;
int buildSize = 80;
int totalPlanks = 0;

ArrayList<Part> building = new ArrayList<Part>();

color partFill = color(255, 50);
color partStroke = color(0, 100);//color(255, 150);
color partHoverFill = color(200, 150);
color placeableFill = color(0, 255, 0, 80);

PImage backgroundImage, logoImage;

void setup(){
  size(1024, 576);
  frameRate(30);
  ellipseMode(CENTER);
  textAlign(RIGHT);
  imageMode(CORNER);
  reset();
  
  backgroundImage = loadImage("background.png");
  logoImage = loadImage("logo.png");
}

void draw(){
  background(20);
  
  for (int y = 0; y <= height; y += 32) {
    for (int x = 0; x <= width; x += 32) {
      image(backgroundImage, x, y, 32, 32);
    }
  }
  
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
  
  fill(220);
  text("Resources", width-220, 20, 200, 20);
  text("Wood: " + totalPlanks*10, width-220, 40, 200, 20);
  text("Planks: " + totalPlanks, width-220, 60, 200, 20);
  
  image(logoImage, width-logoImage.width/2-16, height-logoImage.height/2-32, logoImage.width/2, logoImage.height/2);
  fill(255, 100);
  text("Unofficial Application", width-16, height-16);
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
