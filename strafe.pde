void strafe()
{
  if(strafeAktiv)
  {
    //timer
    if(!strafeDelay)
    {
      tStart3 = millis();
      strafeDelay = true;
    }
    
    if (millis() < tStart3 + 1000) return; //500ms warten
    
    //strafe berechnen
    strafe = 0;
    for(int y=1; y<6; y++)
    {
      for(int x=1; x<6; x++)
      {
        if(connectedField[x][y]) strafe++;
      }
    }
    //scene drawen
    fill(0,130);
    noStroke();
    rect(width/2,height/2,width,50);
    stroke(0);
    
    fill(255);
    text("STRAFE: "+strafe+" SCHLÜCKE",width/2,height/2);
  }
}
