int card(int x, int y, int card, boolean face) {
  textAlign(CENTER);
  textSize(20);
  stroke(0);
  String s_text = "";
  String kul = "";

  int k = floor((cards[card] - 1) / 13);

  pushMatrix();
  translate(x, y);

  fill(255);
  rect(0, 0, cardWidth, cardHeight);
  if (face) {
    if (k == 0) kul = "♠";
    if (k == 1) kul = "♣";
    if (k == 2) kul = "♥";
    if (k == 3) kul = "♦";

    fill(255, 0, 0);
    if (k < 2)fill(0);

    if (cards[card] - k * 13 > 10 || cards[card] - k * 13 == 1) {
      if ((cards[card] - k * 13) - 10 == 1) s_text = "J";
      if ((cards[card] - k * 13) - 10 == 2) s_text = "Q";
      if ((cards[card] - k * 13) - 10 == 3) s_text = "K";
      if ((cards[card] - k * 13) == 1) s_text = "A";
    } else {
      s_text = str(cards[card] - k * 13);
    }

    pushMatrix();
    translate(-cardWidth/2 + textSize/2, -cardHeight/2 + textSize);
    text(s_text, 0, 0);
    text(kul, 0, textSize);
    popMatrix();

    pushMatrix();
    translate(cardWidth/2 - textSize/2, cardHeight/2 - textSize);
    rotate(PI/1);
    text(s_text, 0, 0);
    text(kul, 0, textSize);
    popMatrix();
  } else {
    back();
  }
  popMatrix();

  if ((cards[card] - k * 13) > 10) {
    return 10;
  } else if ((cards[card] - k * 13) == 1) {
    return 11;
  } else {
    return (cards[card]- k * 13);
  }
}

//----------------------------------------------------------------------------


void back() {
  stroke(0);
  backArt.arrow(-15, -65);
  backArt.star(-15, -33);
  backArt.clover(-15, 1);
  pushMatrix();
  rotate(PI);
  backArt.arrow(-15, -65);
  popMatrix();
  stroke(0);
}

//--------------------------------------------------------------------

void stack(int x, int y, int count) {
  textAlign(CENTER);
  pushMatrix();

  translate(x, y);

  for (int i = 0; i < count; i++) {
    pushMatrix();
    fill(255);
    translate(-1.5*i, -2*i);
    rect(0, 0, cardWidth, cardHeight);
    back();
    popMatrix();
  }

  popMatrix();
}

//---------------------------------------------------------------------------------

void chip(int x, int y, int val) {
  textAlign(CENTER);
  stroke(0);
  int coinXSpace = 10;
  int coinYSpace = 5;
  int coinDiff = 50;
  color coincol = color(0);
  color col = color(255);

  textSize(20);


  pushMatrix();
  translate(x, y);

  fill(col);

  for (int i = 100; i > 0; i -= coinDiff) { 

    if (i == 100) {
      coincol = color(0);
    }
    if (i == 50) {
      coincol = color(0, 0, 255); 
      coinDiff = 25;
    }
    if (i == 25) {
      coincol = color(0, 255, 0); 
      coinDiff = 15;
    }
    if (i == 10) {
      coincol = color(255, 0, 0); 
      coinDiff = 9;
    }
    if (i == 1) {
      coincol = color(255);
    }

    translate(coinDia + coinXSpace, 0);

    for (int j = 0; j < (val / i); j++) {
      pushMatrix();
      translate(0, -(j * coinYSpace));
      fill(255);
      circle(0, 5, coinDia);
      fill(coincol);
      circle(0, 0, coinDia);
      fill(255);
      circle(0, 0, coinDia*0.7);
      fill(0);
      text(i, 0, textSize*0.2);
      popMatrix();
    }

    val -= (val / i) * i;
  }

  popMatrix();
}

//--------------------------------------------------------------------------------
