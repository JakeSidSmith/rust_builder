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
