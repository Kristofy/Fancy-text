int s_global_circle_id_count = 0;
int max_r = 20; 

class Circle{
   
  Point center;
  Point pos;
  Point force;
  float diameter;
  float r = 0;
  boolean growing = true;
  float increment = random (0.1, 0.4);
  float increment_squared = increment*increment;
  
  int id;
  
  public Circle(int x, int y) {
    pos = new Point(x, y);
    id = s_global_circle_id_count++;
    diameter = r*2;
    force = new Point();
  }
  
  public Circle(Point pos){
   this.pos = pos; 
   id = s_global_circle_id_count++;
   diameter = r*2;
   force = new Point();
  }
  
  public void AddForce(Point p){
    force.Add(p);
  }
  
  public void Repel(){
    float d = PointSquareDistance(center, pos);
    if(d > 2){
       Point v = PointSub(center, pos);
       v.SetMag(sqrt(v.Mag())/10);
       force.Add(v);  
  }
   
    
  }
  
  public void Update(float closest_squared){
    if(growing == true){
       if(closest_squared > increment_squared){
          r+=increment;
          diameter += increment*2;
          if(r > max_r){
           growing = false; 
          }
       }else{
         growing = false; 
       }
    }
  }
  
  public void UpdateBehavior(){
   pos.Add(force);  
  }
  
  public void Render(){
   stroke(255);
   fill(map(diameter, 8, max_r, 0, 255), 240, 240);
   circle(pos.x, pos.y, diameter); 
  }
}

float CircleSquareDistance(Circle a, Circle b){
  return PointSquareDistance(a.pos, b.pos) - (a.r + b.r)*(a.r + b.r);
}
float CircleSquareDistance(Circle a, int x, int y){
  return PointSquareDistance(a.pos, x, y) - a.r*a.r;
}
 
float CircleDistance(Circle a, Circle b){
   return PointDistance(a.pos, b.pos) - a.r - b.r;
}
