void ifFlipSet() //animation player
{
  if(animFlip1||animFlip2) //einzelne karte flippen
  {
    float progress = constrain((millis()-tStart)*0.01,0,1); //wann in der animation sind wir grad
    
    if(animFlip1)
    cardSizeXField[flipSelectedX][flipSelectedY] = lerp(cardSizeX,0,progress); //karte runter sizen
    else if(animFlip2)
    cardSizeXField[flipSelectedX][flipSelectedY] = lerp(0,cardSizeX,progress); //karte hoch sizen
    
    if(animFlip1&&millis()>=tStart+100) //animation1 stoppen nach 100ms, value zur sicherheit überschreiben, kartenvalue ändern, animationstiming reset, animation2 starten
    {
      animFlip1=false;
      cardSizeXField[flipSelectedX][flipSelectedY]=0;
      fenster[flipSelectedX][flipSelectedY].faceUp = !fenster[flipSelectedX][flipSelectedY].faceUp;
      tStart = millis();
      animFlip2=true;
    }
    else if(animFlip2&&millis()>=tStart+100)  //animation2 stoppen nach 100ms, karte auf size setzen zur sicherheit, input nicht mehr blocken
    {
      if(falscheAntwort&&millis()>=tStart+1000) //wenn fehler gemacht wurde, extra timer für einwirken
      {
        println("falsch");
        animFlip2=false;
        cardSizeXField[flipSelectedX][flipSelectedY]=cardSizeX;
        
        falscheAntwort=false;
        tStart = millis();
        animFlipAll1 = true;

        tStart2 = millis();
        animFlipCorners1 = true;
        
        blockInput=false;
      }
      else if(!falscheAntwort) //normalfall wenn richtig
      {
        println("richtig");
        animFlip2=false;
        cardSizeXField[flipSelectedX][flipSelectedY]=cardSizeX;
        
        blockInput=false;
      }
    }
  }
  
  if(animFlipAll1||animFlipAll2) //alle flippen
  {
    float progress = constrain((millis()-tStart)*0.01,0,1); //wann in der animation sind wir grad
    
    if(animFlipAll1)
    for(int y=1; y<6; y++)
    {
      for(int x=1; x<6; x++)
      {
        cardSizeXField[x][y] = lerp(cardSizeX,0,progress); //karte runter sizen
      }
    }
    else if(animFlipAll2)
    for(int y=1; y<6; y++)
    {
      for(int x=1; x<6; x++)
      {
        cardSizeXField[x][y] = lerp(0,cardSizeX,progress); //karte hoch sizen
      }
    }
    
    if(animFlipAll1&&millis()>=tStart+100) //animation1 stoppen nach 100ms, value zur sicherheit überschreiben, kartenvalue ändern, animationstiming reset, animation2 starten
    {
      animFlipAll1=false;
      for(int y=1; y<6; y++)
      {
        for(int x=1; x<6; x++)
        {
          cardSizeXField[x][y]=0;
          fenster[x][y].faceUp = false;
        }
      }
      tStart = millis();
      animFlipAll2=true;
    }
    else if(animFlipAll2&&millis()>=tStart+100)  //animation2 stoppen nach 100ms, karte auf size setzen zur sicherheit, input nicht mehr blocken
    {
      animFlipAll2=false;
      for(int y=1; y<6; y++)
      {
        for(int x=1; x<6; x++)
        {
          cardSizeXField[x][y]=cardSizeX;
        }
      }
      blockInput=false;
    }
  }
  
  if(animFlipCorners1||animFlipCorners2) //eckkarten flippen
  { 
    if(animFlipCorners1 && millis() <= tStart2 + 1000) return; //1000ms warten
    
    float progress;
    if(animFlipCorners1) progress = constrain((millis()-(tStart2+1000))*0.01,0,1); //wann in der animation sind wir grad, +1000 wegen delay
    else progress = constrain((millis()-tStart2)*0.01,0,1); //ohne delay wegen reset bei 2ter animation
    
    if(animFlipCorners1)
    {
      cardSizeXField[1][1] = lerp(cardSizeX,0,progress); //eckkarten runter sizen
      cardSizeXField[1][5] = lerp(cardSizeX,0,progress);
      cardSizeXField[5][1] = lerp(cardSizeX,0,progress);
      cardSizeXField[5][5] = lerp(cardSizeX,0,progress);
    }
    else if(animFlipCorners2)
    {
      cardSizeXField[1][1] = lerp(0,cardSizeX,progress); //eckkarten hoch sizen
      cardSizeXField[1][5] = lerp(0,cardSizeX,progress);
      cardSizeXField[5][1] = lerp(0,cardSizeX,progress);
      cardSizeXField[5][5] = lerp(0,cardSizeX,progress);
    }
    
    if(animFlipCorners1&&millis()>=tStart2+1000+100) //animation1 stoppen nach 100ms (+1000 für delay), value zur sicherheit überschreiben, kartenvalue ändern, animationstiming reset, animation2 starten
    {
      animFlipCorners1=false;
      cardSizeXField[1][1] = 0;
      cardSizeXField[1][5] = 0;
      cardSizeXField[5][1] = 0;
      cardSizeXField[5][5] = 0;
      
      fenster[1][1].faceUp = !fenster[1][1].faceUp;
      fenster[1][5].faceUp = !fenster[1][5].faceUp;
      fenster[5][1].faceUp = !fenster[5][1].faceUp;
      fenster[5][5].faceUp = !fenster[5][5].faceUp;
      tStart2 = millis();
      animFlipCorners2=true;
    }
    else if(animFlipCorners2&&millis()>=tStart2+100)  //animation2 stoppen nach 100ms, karte auf size setzen zur sicherheit, input nicht mehr blocken
    {
      animFlipCorners2=false;
      cardSizeXField[1][1] = cardSizeX;
      cardSizeXField[1][5] = cardSizeX;
      cardSizeXField[5][1] = cardSizeX;
      cardSizeXField[5][5] = cardSizeX;
      
      blockInput=false;
    }
  }
}
