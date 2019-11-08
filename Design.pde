symbol backArt = new symbol();

class symbol {
  color col = color(86, 81, 78);
  int h = 30;
  int w = 30;

  void arrow(int x, int y) {
    stroke(col);
    pushMatrix();
    translate(x, y);
    line(0, h * 2/3, w/2, 0);
    line(w, h * 2/3, w/2, 0);
    line(0, h * 2/3, w * 1/3, h);
    line(w, h * 2/3, w * 2/3, h);
    line(w * 2/3, h, w/2, h * 4/5);
    line(w * 1/3, h, w/2, h * 4/5);
    popMatrix();
  }

  void star(int x, int y) {
    stroke(col);
    pushMatrix();
    translate(x, y);
    line(0, h/2, w/2, 0);
    line(w/2, 0, w, h/2);
    line(w, h/2, w/2, h);
    line(w/2, h, 0, h/2);
    popMatrix();
  }

  void clover(int x, int y) {
    stroke(col);
    pushMatrix();
    translate(x, y);
    pushMatrix();
    translate(h/2, w/2);
    for (int i = 0; i < 4; i++) {
      rotate(PI/2);
      line(0, 0, -w/6, (-h/2)*2/3);
      line(0, 0, w/6, (-h/2)*2/3);
      line(w/6, (-h/2)*2/3, 0, -h/2);
      line(-w/6, (-h/2)*2/3, 0, -h/2);
    }
    popMatrix();
    popMatrix();
  }
}
