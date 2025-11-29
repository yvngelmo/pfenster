//animPlayer values
boolean animFlip1=false;
boolean animFlip2=false;
boolean animFlipAll1=false;
boolean animFlipAll2=false;
boolean animFlipCorners1=true;
boolean animFlipCorners2=false;
boolean corner1Flipped = false;
boolean corner2Flipped = false;
boolean corner3Flipped = false;
boolean corner4Flipped = false;
boolean blockInput=false;
int flipSelectedX, flipSelectedY, tStart, tStart2;

//strafe value
int strafe = 0;
int tStart3 = 0;
boolean strafeAktiv = false;
boolean strafeDelay = false;

//init cardsize, array für flip, array für connected
int cardSizeX = 60;
int cardSizeY = 100;
float[][] cardSizeXField = new float[7][7];
boolean[][] connectedField = new boolean[7][7];

//init fenster array
karte[][] fenster = new karte[7][7];

//init guess berechnungen
int guess;
int answer;
int neighborAmt;
boolean falscheAntwort;
PVector activeNeighbor1 = new PVector(0,0);
PVector activeNeighbor2 = new PVector(0,0);
PVector activeNeighbor3 = new PVector(0,0);

void setup()
{
  //setup
  size(768,768);
  rectMode(CENTER);
  textAlign(CENTER,CENTER);
  textSize(32);
  strokeWeight(2);
  stroke(100);
  
  //init leere karten großer array
  for(int y=0; y<7; y++)
  {
    for(int x=0; x<7; x++)
    {
      fenster[x][y] = new karte(false,false,x,y,0);
    }
  }
  
  //init karten & size
  for(int y=1; y<6; y++)
  {
    for(int x=1; x<6; x++)
    {
      fenster[x][y].set(true,false,x,y,int(random(7)));
      cardSizeXField[x][y] = cardSizeX;
      connectedField[x][y] = false;
    }
  }
  
  //fensterlöcher leer
  fenster[2][2].enabled = false;
  fenster[4][2].enabled = false;
  fenster[2][4].enabled = false;
  fenster[4][4].enabled = false;
}

void draw()
{
  background(240);
  ifFlipSet();
  drawCards();
  strafe();
  overlay();
}

void overlay()
{
    //overlay drawen
    textAlign(LEFT,TOP);
    textSize(20);
    fill(100);
    text("[LMB] Höher / Innerhalb\n[LMB] Niedriger / Außerhalb \n[MMB] Gleich",8,8);
    textAlign(CENTER,CENTER);
    textSize(32);
}
