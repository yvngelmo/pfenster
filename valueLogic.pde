int checkHigherLower(int x, int y) //xy ist aktive benachbarte karte
{
  int val = fenster[x][y].val;
  int currentVal = fenster[int(cardHovered().x)][int(cardHovered().y)].val;
  
  if(val>currentVal)
  {
    return 1;
  }
  else if(val<currentVal)
  {
    return 2;
  }
  else return 0;
}

int checkBetweenAußerhalb(int x1, int y1, int x2, int y2) //xy1 xy2 sind benachbarte karten
{
  int val1 = fenster[x1][y1].val;
  int val2 = fenster[x2][y2].val;
  int currentVal = fenster[int(cardHovered().x)][int(cardHovered().y)].val;
  
  if(currentVal == val1 || currentVal == val2) return 0;
  
  int minNeighbor = min(val1, val2);
  int maxNeighbor = max(val1, val2);
  
  if(currentVal > minNeighbor && currentVal < maxNeighbor) return 2;
  else return 1;
}

int checkFür3(int x1, int y1, int x2, int y2, int x3, int y3) //xy1 xy2 xy3 sind benachbarte karten
{
  int val1 = fenster[x1][y1].val;
  int val2 = fenster[x2][y2].val;
  int val3 = fenster[x3][y3].val;
  int currentVal = fenster[int(cardHovered().x)][int(cardHovered().y)].val;
  
  if(currentVal == val1 || currentVal == val2 || currentVal == val3) return 0;
  
  int minNeighbor = min(val1, min(val2,val3));
  int maxNeighbor = max(val1, max(val2,val3));
  
  if(currentVal > minNeighbor && currentVal < maxNeighbor) return 2;
  else return 1;
}

void getActiveNeighbors(PVector card)
{
  neighborAmt = 0; //der wievielte neighbor wurde gefunden
  
  //reset neighbor werte
  activeNeighbor1.set(0,0);
  activeNeighbor2.set(0,0);
  activeNeighbor3.set(0,0);
  
  for(int y=-1; y<2; y++)
  {
    for(int x=-1; x<2; x++)
    {
      if(x==0 && y==0) continue; //karte skipt sich selbst
      if(x!=0 && y!=0) continue; //diagonalen skippen
      
      int setX = int(card.x+x); //gecheckte karte
      int setY = int(card.y+y);
      
      if(fenster[setX][setY].faceUp) //wenn nachbar aufgedeckt
      {
        if(neighborAmt==0) activeNeighbor1.set(setX,setY); //erster gefundener nachbar
        else if(neighborAmt==1) activeNeighbor2.set(setX,setY); //zweiter
        else if(neighborAmt==2) activeNeighbor3.set(setX,setY); //dritter
        
        neighborAmt++; //gefundene nachbarn zählen
      }
    }
  }
}

void writeConnectedToField(PVector card) //connected karten in bool connectedField writen
{
  int x = int(card.x);
  int y = int(card.y);
  
  if(connectedField[x][y]||!fenster[x][y].enabled) return; //wurde karte schonmal gecheckt oder ist disabled? wenn ja dann raus hier
  
  connectedField[x][y]=true; //wenn nicht dann karte auf true setzen
  getActiveNeighbors(card); //welche nachbarn?
  
  //nachbarn lokal speichern damit nicht corrupted wird wenn mehrmals ausführt
  int localNeighborAmt = neighborAmt;
  PVector neighbor1 = new PVector(activeNeighbor1.x, activeNeighbor1.y);
  PVector neighbor2 = new PVector(activeNeighbor2.x, activeNeighbor2.y);
  PVector neighbor3 = new PVector(activeNeighbor3.x, activeNeighbor3.y);
  
  //rekursiv funktion für alle nachbarn ausführen
  if(localNeighborAmt >= 1) writeConnectedToField(neighbor1);
  if(localNeighborAmt >= 2) writeConnectedToField(neighbor2);
  if(localNeighborAmt >= 3) writeConnectedToField(neighbor3);
}

void setCheck()
{
  if(neighborAmt==1) //wenn 1 nachbar: höher tiefer?
  {
    answer = checkHigherLower(int(activeNeighbor1.x),int(activeNeighbor1.y));
  }
  if(neighborAmt==2) //wenn 2 nachbaren: dazwischen oder außerhalb?
  {
    answer = checkBetweenAußerhalb(int(activeNeighbor1.x),int(activeNeighbor1.y),int(activeNeighbor2.x),int(activeNeighbor2.y));
  }
  if(neighborAmt==3) //wenn 3 nachbaren: eigentlich checken zwischen dem kleinsten und dem größten nachbar inbetween außerhalb ODER gleich bei allen drei
  {
    answer = checkFür3(int(activeNeighbor1.x),int(activeNeighbor1.y),int(activeNeighbor2.x),int(activeNeighbor2.y),int(activeNeighbor3.x),int(activeNeighbor3.y));
  }
}

void richtigOderFalsch(PVector card)
{
  PVector cardPos = card; //welche karte?
  
  if(guess==answer) //richtig
  {
    //passiert was wenn richtig?
  }
  else //falsch
  {
    //connected field resetten
    for(int y=1; y<6; y++)
    {
      for(int x=1; x<6; x++)
      {
        connectedField[x][y]=false;
      }
    }
    //checken welche verbunden sind
    writeConnectedToField(cardPos);
    falscheAntwort=true; //animation abspielen
    strafeAktiv = true; //strafe scene
  }
}
