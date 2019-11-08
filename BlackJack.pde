int cardWidth = 150;
int cardHeight = 210;
int coinDia = 100;
int textSize = 30;
int blackJack = 21;
color green = color(50, 210, 0);

int cardCountP = 2;        //cards on player's hand
int cardCountD = 2;        //cards on dealer's hand
int money = 100;           //Start money

boolean gd = false;        //game is done
boolean gameBegin = false; //game has begun


void setup() {
  size(1500, 800);

  betting.x = width / 2;
  betting.y = height - 40;
  betting.col = color(green);
  betting.margin = 10;
  betting.padding = 5;

  for (int i = 0; i < (13*4); i++) {
    cards[i] = i+1;
  }
  shuffle();
}



void draw() {
  int ptot = 0; //playe total points
  int dtot = 0; //dealer total points
  int ACountP = 0; //number of esses for player
  int ACountD = 0; //number of esses for dealer

  clear();
  background(0, 70, 0);

  //--------------------BOARD---------------------
  //Draws player money display
  stroke(green);
  noFill();
  textAlign(CENTER);
  line(width - int(coinDia * 5 * 1.2), height - 180, width - int(coinDia * 1.5), height - 180);
  triangle(width - int(coinDia * 5 * 1.2), height - 180 - 25, width - int(coinDia * 1.5), height - 180 - 25, width - int(coinDia * 3.8), height - 200 - 25);
  fill(green);
  text(("money: " + money), width - int(coinDia * 3.8), height - 187);

  //Draws betted money display
  noFill();
  line(int(coinDia * 5 * 1.2), height - 180, int(coinDia * 1.5), height - 180);
  triangle(int(coinDia * 5 * 1.2), height - 200 - 25, int(coinDia * 1.5), height - 200 - 25, int(coinDia * 3.8), height - 180 - 25); 
  fill(green);
  text(("bet: " + betting.bet), int(coinDia * 3.8), height - 187);

  //Tutorial text
  pushMatrix();
  translate(width - 290, 30);
  textAlign(LEFT);
  text("Controls:", 0, 0);
  textSize(10);
  text("Write bet with numerical keys", 0, 15);
  text("Press 'confirm bet'", 0, 30);
  text("-------------------------", 0, 45);
  text("hit 'h'", 0, 60);
  text("stand 's'", 0, 75);
  text("reset game (not currency) 'r'", 0, 90);
  popMatrix();

  //Shortcut text
  pushMatrix();
  translate(width - 120, 30);
  textAlign(LEFT);
  textSize(20);
  text("Shortcuts:", 0, 0);
  textSize(10);
  text("add 10 money 'p'", 0, 15);
  text("minus 10 money 'l'", 0, 30);
  text("enter bet 'ENTER'", 0, 45);
  text("confirm bet 'c'", 0, 60);
  text("reset bet 'r'", 0, 75);
  popMatrix();

  //Stack of cards
  stack(width/6, height/3, 52 - cardCountP - cardCountD);

  //-------------------DEALER---------------------
  //Places one face down card and rest face up if game is in progress
  //if game hasnt started, show nothing. if game is done, flip the face down card
  if (gameBegin) {
    for (int i = 0; i < cardCountD; i++) {
      //Checks if card is an a
      if ((card(width/4 + i * cardWidth + i * 10 + cardWidth, height / 3, 51 - i, true)) == 11) ACountD += 1;
      //Counts total card value
      dtot += card(width/4 + i * cardWidth + i * 10 + cardWidth, height / 3, 51 - i, true);
      //Displays face down card
      if (i == 0 && !gd) card(width/4 + i * cardWidth + i * 10 + cardWidth, height / 3, 51 - i, false);
    }
  }

  //Turns a from 11 to 1 if required
  if (dtot >= blackJack) if (ACountD > 0) {
    dtot -= 10; 
    ACountD -= 1;
  }

  //Win condition of having 5 cards while under 21
  if ((cardCountD >= 5) && (dtot <= blackJack)) dtot = blackJack;

  //-------------------PLAYER---------------------

  if (gameBegin) {
    for (int i = 0; i < cardCountP; i++) {
      //Counts total card value
      ptot += (card(width/6 + i * cardWidth + i * 10, height - height/3, i, true));
      //Checks if card is an a
      if ((card(width/6 + i * cardWidth + i * 10, height - height/3, i, true)) == 11) ACountP += 1;
    }
  }

  //Turns a from 11 to 1 if required
  if (ptot > blackJack) if (ACountP > 0) {
    ptot -= 10; 
    ACountP -= 1;
  }

  //Win condition of having 5 cards while under 21
  if ((cardCountP >= 5) && (ptot <= blackJack)) ptot = blackJack;
  //Game is done if player has 21
  if (ptot >= blackJack) gd = true;


  //-----------Dealer AI & win condition------------ 
  //checks different win conditions
  if (gd) {
    if (dtot < ptot && dtot < 17 && ptot <= blackJack) {
      //gives dealer extra card if dealer hasnt lost
      cardCountD += 1;
    } else {

      textSize(200);
      //Checks if player has won
      if ((dtot > blackJack && ptot <= blackJack) || (ptot <= blackJack && ptot > dtot)) {
        fill(0, 200, 0);
        //Gives douple money back, and displays plyer won
        money += betting.bet * 2;
        betting.delete();
        betting.bet = 0;
        text("Player wins", width/2, height/2);
      } else {
        fill(230, 0, 0);
        //discards bet, and displays dealer won
        text("Dealer wins", width/2, height/2);
        betting.bet = 0;
        betting.delete();
      }
    }
  }

  //----------------Money system---------------------
  //Number input by keyboard, confirms bet if amount is under what the player has.
  betting.disp();
  if (button(width / 2 - 105 / 2, height - 45 - 30, 105, 25, color(green), "Confirm bet", true)) {
    if (money - int(betting.getVal()) >= 0) {
      betting.bet += int(betting.getVal());
      money -= int(betting.getVal());
      betting.delete();
      gameBegin = true;
    } else betting.delete();
  } 

  //Displays the chips the player has, and the chips player has bet.
  chip(width - int(coinDia * 5 * 1.4), height - 100, money);
  chip(100, height - 100, betting.bet);
}



void keyPressed() {
  if (int(key) >= 48 && int(key) <= 57 && !gameBegin) {  //numbers 1-10
    betting.addChar();
  }
  if (int(key) == 10) {  //Enter
    //if plyer has enough money: bet it. if not: discard bet
    if (money - int(betting.getVal()) >= 0) { 
      betting.bet += int(betting.getVal());
      money -= int(betting.getVal());
    }
    betting.delete();
  }
  if (int(key) == 8) {  //Backspace
    //deletes last charectar of numeric bet input
    betting.back();
  }
  if (!gameBegin) {
    if (key == 'p') {
      //adds 10 money to bet if possible
      if (money - 10 >= 0) { 
        betting.bet += 10;
        money -= 10;
        betting.delete();
      }
    }
    if (key == 'l') {
      //subtracts 10 money from bet if possible
      if (betting.bet - 10 >= 0) { 
        betting.bet -= 10;
        money += 10;
        betting.delete();
      }
    }
  }
}




void keyReleased() {
  if (gameBegin) {
    if (!gd) if (key == 'h') cardCountP += 1;        //hit
    if (key == 's')gd = true;      //stand
    if (key == 'r') {
      gd = false;
      shuffle();
      cardCountP = 2;        //cards on player's hand
      cardCountD = 2;        //cards on dealer's hand
      betting.delete();
      gameBegin = false;
      money += betting.bet;
      betting.bet = 0;
    }
  }
  if (!gameBegin) {
    if (key == 'c') {
      gameBegin = true;
    }
    if (key == 'r') {
      money += betting.bet;
      betting.bet = 0;
    }
  }
}


int mousex, mousey;
boolean mouseClick = false;
void mouseClicked() {
  mousex = mouseX;
  mousey = mouseY;
  mouseClick = true;
}
