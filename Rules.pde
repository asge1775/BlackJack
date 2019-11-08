boolean[] cardb = new boolean[13*4];
int[] cards = new int[13*4];

void shuffle(){
  
  for(int i = 0; i < (13*4); i++){
    cardb[i] = true;
  }
  
  for(int i = 0; i < (13*4); i++){
    boolean b_r = true;
    while(b_r){
      int r = int(random(0,52));
      if(cardb[r]){
        cardb[r] = false;
        cards[i] = r + 1;
        b_r = false;
      }
    }
  }

}
