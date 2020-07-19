
class Point{
 public float x, y;
 
 public Point(){}
 
 public Point(float x, float y){
   this.x = x;
   this.y = y;
 }
 
 public Point Copy(){
  return new Point(x,y); 
 }
 
 public void Add(Point p){
   x+=p.x;
   y+=p.y;
 }
 
 public void Sub(Point p){
   x-=p.x;
   y-=p.y;
 }
 
 public float SquareMag(){
    return x*x+y*y; 
 }
 
 public float Mag(){
    return sqrt(x*x+y*y); 
 }
 
 public void Mult(float x){
   this.x *= x;
   this.y *= x;
   
 }
 
 public void SetMag(float m){
   float h = sqrt(x*x+y*y);
   x/=h;
   y/=h;
   x*=m;
   y*=m;
 }
 
}

Point PointSub(Point a, Point b){
  return new Point(a.x - b.x, a.y - b.y);
}

float PointDistance(Point a, Point b){
  return sqrt((a.x-b.x)*(a.x-b.x) + (a.y-b.y)*(a.y-b.y));
}
 
float PointSquareDistance(Point a, Point b){
   return (a.x-b.x)*(a.x-b.x) + (a.y-b.y)*(a.y-b.y);
}

float PointSquareDistance(Point a, float x, float y){
   return (a.x-x)*(a.x-x) + (a.y-y)*(a.y-y);
}
