class karte
{
  boolean enabled;
  boolean faceUp;
  int indexX, indexY, val;
  
  karte(boolean enabledSet, boolean faceUpSet, int indexXSet, int indexYSet, int valSet)
  {
    enabled = enabledSet;
    faceUp = faceUpSet;
    indexX = indexXSet;
    indexY = indexYSet;
    val = valSet;
  }
  
  void set(boolean enabledSet, boolean faceUpSet, int indexXSet, int indexYSet, int valSet)
  {
    enabled = enabledSet;
    faceUp = faceUpSet;
    indexX = indexXSet;
    indexY = indexYSet;
    val = valSet;
  }
}
