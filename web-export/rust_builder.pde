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
class Doorway extends Part {
  
  Doorway() {
    this(0, 0);
  }
  
  Doorway(float x, float y) {
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
        vertex(-w*0.1, -w/8 -w/16);
        vertex(-w*0.1, -w*0.7);
        vertex(-w*0.4, -w*0.55);
        vertex(-w*0.4, -w/32);
        vertex(-w/2, 0);
      endShape();
    popMatrix();
  }
  
  void setDragged(int newx, int newy) {
    dragging = new Doorway(newx, newy);
  }
  
  void setPart() {
    building.add(new Doorway(pos.x, pos.y));
  }
  
}
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
class Part {
  
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
class Sidebar {
  
  ArrayList<Part> parts;
  int w = 48, iconSize = 40;
  
  Sidebar() {
    parts = new ArrayList<Part>();
    parts.add(new Foundation(w/2, w/2));
    parts.add(new Pillar(w/2, w*1.5));
    parts.add(new Wall(w/2, w*2.5));
    parts.add(new Doorway(w/2, w*3.5));
    parts.add(new Ceiling(w/2, w*4.5));
  }
  
  void display() {
    noStroke();
    fill(15);
    rect(0, 0, w, height);
    
    for (int i = 0; i < parts.size(); i += 1) {
      Part part = parts.get(i);
      part.display(iconSize);
    }
  }
  
}
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

