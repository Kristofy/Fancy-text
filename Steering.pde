int W, H;
boolean push = false;
CircleManager manager;
Point Mouse;
float Friction = 0.95;
void setup() {
  size(1280, 720);
  W = width;
  H = height;
  manager = new CircleManager("Sample", 5, 1.4);
  colorMode(HSB);
  Mouse = new Point();
}

void draw() {
  background(0);
  Mouse.x = mouseX;
  Mouse.y = mouseY;
  
  if(manager.state == manager.SPAWNIG){
   for(int i = 0; i < 15; i++)
    manager.Update();
  }else{
     manager.Update(); 
  }

  manager.Render();

  
}

void keyPressed(){
 if(key == 'r'){
  setup(); 
 }
 if(key == 's'){
  push = !push; 
 }
  
}
