void mousePressed()
{
  if(blockInput==false)
  {
    PVector card = cardHovered();
    if(card.x<6&&card.y<6&&card.x>0&&card.y>0) //nur welche die im raster sind
    {
      //welche nachbarn?
      getActiveNeighbors(card);
      
      if(!fenster[int(card.x)][int(card.y)].faceUp&&neighborAmt>0) //die nicht aufgedeckt sind und die nachbarn haben
      {
        //welcher guess wurde gemacht?
        if(mouseButton==LEFT) guess=2;
        else if(mouseButton==RIGHT) guess=1;
        else guess=0;
      
        blockInput=true; //input blocken damit animation und berechnungen durchlaufen kann
        
        //welcher algo?+algo
        setCheck();
        //ist guess = lösung?
        richtigOderFalsch();
  
        flipCard(int(card.x),int(card.y)); //cardflip ausführen
      }
    }
  }
}
