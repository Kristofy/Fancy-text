class FontToPoints{
  private PGraphics g;
  private ArrayList<Point> points; 
  private int n, curr = 0, step = 6;
  
  public FontToPoints(String text, float zoom){
    PFont font;
    points = new ArrayList<Point>();
    font = loadFont("data/CooperBlack-48.vlw");
    g = createGraphics(W,H);
    g.smooth();
    g.beginDraw();
    g.textFont(font);
    g.textSize(W / text.length() * zoom);
    g.background(0);
    g.noStroke();
    g.fill(255);
    g.textAlign(CENTER, CENTER);
    g.text(text, W/2, H/2);

    
    // sample data
    
    g.loadPixels();
    color white = #f0f0f0;
    for(int y = 0; y < H; y+=step){
     for(int x = 0; x < W; x+=step){
       if(g.pixels[y * W + x] > white){
          points.add(new Point(x,y));
          //g.pixels[y * W + x] = color(255, 0, 0);
       }
     }
    }
    
    n = points.size();
    g.updatePixels();  
    
    
    g.endDraw();
    
    _RandomShuffle();
  }
  
  private void _RandomShuffle(){
    Point tmp;
    int index;
    for(int i = 0; i < n; i++){
       index = int(random(n));
       
       tmp = points.get(i).Copy();
       points.set(i,points.get(index).Copy());
       points.set(index, tmp);
    }
    
  }
  
  public PGraphics getImage(){
   return g; 
  }
  
  public boolean Empty(){
   return curr == n; 
  }
  
  public Point Next(){
   if(curr < n){
     return points.get(curr++);
   }else{
     return null;
   }
  }
  
}
