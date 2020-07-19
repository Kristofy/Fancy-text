class CircleManager{
 FontToPoints generator;
 ArrayList<Circle> circles;
 float spawnRate = 100;
 float spacing = 0.001;
 float Threshold = 5;
 float Overhang = 1.3;
 int state = 0;
 int SPAWNIG = 0;
 int ACTIVE = 1;
 
 int range = 400;
 int squareRange = range*range;
     
 public CircleManager(String text, float spawnRate, float zoom){
   generator = new FontToPoints(text, zoom);
   circles = new ArrayList<Circle>();
   this.spawnRate = spawnRate;
 
 }
 
 public void Update(){
   if(state == SPAWNIG){
     for(int i = 0; i < spawnRate; i++){
       _Spawn();  
     }
     for(Circle c : circles){
       if(c.growing){
         float closest = _SquaredFindClosest(c);
         for(float angle = 0; angle < TWO_PI; angle+=0.4){
             int x = (int)c.pos.x + int(cos(angle) * c.r / Overhang);
             int y = (int)c.pos.y + int(sin(angle) * c.r / Overhang);
             
             if(!(y>0 && x>0 && y < height && x < width) || generator.g.pixels[y * width + x] < #202020){
               closest = min(closest, CircleSquareDistance(c, x, y));              
             }
            
           }
        c.Update(closest); 
       }
     }
     if(generator.Empty()){
       state = ACTIVE;
       for(Circle c : circles) c.center = c.pos.Copy();
     }
   }else{
     Point v;
     float d;
     for(Circle c : circles){
        d = CircleSquareDistance(c, mouseX, mouseY);
        if(push && d < squareRange){
            v = PointSub(c.pos, Mouse);
            v.SetMag(1/(d+c.r*c.r+0.01));
            v.Mult(5000);
            c.AddForce(v);
           
        }else{
            c.Repel(); 
        }
        c.force.Mult(Friction);
        
        c.UpdateBehavior();
     }     
   }
 }
 
 private void _Spawn(){
    int try_count = 300;
    // finding closest circle and black pixel
    boolean canSpawn;
    for(int i = 0; i < try_count; i++){
     if(!generator.Empty()){
       Circle c = new Circle(generator.Next()); 
       if(_SquaredFindClosest(c) >= (spacing + Threshold)*(spacing + Threshold)){
         canSpawn = true;
         for(float angle = 0; angle < TWO_PI; angle+=0.4){
           int x = (int)c.pos.x + int(cos(angle) * Threshold / Overhang);
           int y = (int)c.pos.y + int(sin(angle) * Threshold / Overhang);
           
           if(!(y<0 || x<0 || y >= height || x >= width) && generator.g.pixels[y * width + x] < #0f0f0f){
             canSpawn = false;
             break;  
           }
           
         }
         if(canSpawn){
           circles.add(c);
         }else{
           continue; 
         }
       }
       break;
     }
    }
    
 }
 
 public float _SquaredFindClosest(Circle main){
   float closest = 1e9;
   float d;
   for(Circle c : circles){
     if(c.id != main.id){
       d = CircleSquareDistance(c, main);
       if(d < closest){
         closest = d;
       }
     }
   }
   return (closest>0 ? closest : 0);
 }
 
 public void Render(){
   for(Circle c : circles){
    c.Render(); 
   }
 }
 
}
