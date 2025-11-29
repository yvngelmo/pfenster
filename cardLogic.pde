PVector cardPos(int x, int y)
{
  PVector cardPos = new PVector();
  
  //kartenpositionen setzen auf screenspace
  cardPos.x = width/2 + (x-3)*70;
  cardPos.y = height/2 + (y-3)*110;
  
  return cardPos;
}

PVector cardHovered()
{
  PVector cardHovered = new PVector();
  
  PVector cardPos0 = cardPos(0,0);
  PVector cardPos1 = cardPos(1,1);
  PVector spacing = PVector.sub(cardPos1,cardPos0);
  
  //welche karte ist gehovered? based auf cardPos und cardSize
  cardHovered.x=round((mouseX-cardPos0.x)/spacing.x);
  cardHovered.y=round((mouseY-cardPos0.y)/spacing.y);
  
  return cardHovered;
}

void drawCards()
{
  for(int y=1; y<6; y++)
  {
    for(int x=1; x<6; x++)
    {
      if(fenster[x][y].enabled) //wenn karte enabled ist
      {
        //karten drawen based auf cardPos und cardSize
        PVector cardPos = cardPos(x,y);
        
        fill(255);
        rect(cardPos.x,cardPos.y,cardSizeXField[x][y],cardSizeY,5);
        
        fill(100);
        if(fenster[x][y].faceUp) text(valConvert(fenster[x][y].val),cardPos.x,cardPos.y);
      }
    }
  }
}

String valConvert(int val)
{
  if(val==0) return "7";
  else if(val==1) return "8";
  else if(val==2) return "9";
  else if(val==3) return "10";
  else if(val==4) return "J";
  else if(val==5) return "Q";
  else if(val==6) return "K";
  else if(val==7) return "A";
  else return "-";
}

void flipCard(int x, int y)
{
  flipSelectedX = x; //werte speichern für ifFlipSet
  flipSelectedY = y;
  
  tStart = millis();
  animFlip1 = true; //trigger ifFlipSet
}
