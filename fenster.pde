//animPlayer values
boolean animFlip1=false;
boolean animFlip2=false;
boolean animFlipAll1=false;
boolean animFlipAll2=false;
boolean animFlipCorners1=true;
boolean animFlipCorners2=false;
boolean animHover=false;
boolean animHoverBack=false;
boolean blockInput=false;
int flipSelectedX, flipSelectedY, tStart, tStart2;

//init cardsize, array für flip
int cardSizeX = 60;
int cardSizeY = 100;
float[][] cardSizeXField = new float[7][7];

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
  background(200);
  ifFlipSet();
  drawCards();
}
