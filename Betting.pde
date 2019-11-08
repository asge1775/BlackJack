IO betting = new IO();

boolean button(int x, int y, int w, int h, color col, String text, boolean show) {
  int margin = 3;
  if (show) {
    stroke(col);
    rectMode(CORNER);
    pushMatrix();
    translate(x, y);
    if (mouseClick && mousex > x && mousex < x + w && mousey > y && mousey < y + h) {
      fill(255);
      rect(0, 0, w, h);
      fill(255);
      text(text, margin, h/2);
    } else {
      noFill();
      rect(0, 0, w, h);
      fill(255);
      text(text, margin, h/2);
    }
    popMatrix();
    rectMode(CENTER);
    stroke(0);
  }

  if (mouseClick && mousex > x && mousex < x + w && mousey > y && mousey < y + h) {
    mouseClick = false;
    return true;
  } else {
    return false;
  }
}

class IO {
  StringBuffer input = new StringBuffer();

  int bet;
  color col;
  int dispCount;
  int margin;
  int padding;

  int x, y, w = 300, h = 30;

 void disp() {
    textSize(17);
    rectMode(CENTER);
    textAlign(LEFT, CENTER);
    noFill();
    stroke(col);
    if (input.length() > 15) rect(x + (input.length() - 15) * 10/2, y + h/2, w + (input.length() - 15) * 10, h);
    else rect(x, y + h/2, w, h);
    stroke(0);
    fill(255);
    if (input.length() > 0) {
      text("Input bet: " +input.toString(), x + margin - w / 2, y + margin);    //skriver hvad der skal i string
    } else {
      text("Input bet: " + "then press ENTER", x + margin - w / 2, y + margin);    //skriver hvad der skal i string
    }
  }

  void addChar() {
    if (mouseX < x + w/2  && mouseX > x - w/2 && mouseY > y && mouseY < y + h) input.append(key);
  }

  void delete() {
    input.delete(0, input.length());
  }

  void back() {
    if (mouseX < x + w && mouseX > x && mouseY > y && mouseY < y + h) {
      if (input.length() > 0) {
        input.deleteCharAt(input.length() - 1);
      } else {
        delete();
      }
    }
  }

  float getVal() {
    float belob = 0;
    if (input.length() > 0) {
      belob =  Float.parseFloat(input.toString());
    }

    return belob;
  }
}
