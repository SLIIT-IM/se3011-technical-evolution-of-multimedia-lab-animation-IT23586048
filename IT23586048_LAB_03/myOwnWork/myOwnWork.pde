ArrayList<Enemy> enemies = new ArrayList<Enemy>();

float px = 350, py = 175;
float step = 6;
float pr = 20;

int spawnInterval = 1000;   // 1000 ms = 1 second
int lastSpawnTime = 0;

void setup(){
  size(700, 350);
}

class Enemy{
  float x = random(100,600); 
  float y = 0;
  float elScale = 20;
  
  void move(){
    y += 1;
    ellipse(x, y, elScale, elScale);
  }
}

void draw(){
  background(0);
  
  // Timer logic
  if (millis() - lastSpawnTime > spawnInterval){
    enemies.add(new Enemy());
    lastSpawnTime = millis();   // reset timer
  }
  
  for(Enemy e : enemies){
    e.move();
  }
  
  if (keyPressed) {
    if (keyCode == RIGHT) px += step;
    if (keyCode == LEFT)  px -= step;
    if (keyCode == DOWN)  py += step;
    if (keyCode == UP)    py -= step;
  }

  px = constrain(px, pr, width - pr);
  py = constrain(py, pr, height - pr);

  fill(60, 120, 200);
  ellipse(px, py, pr*2, pr*2);
  
}

void mousePressed(){
  enemies.add(new Enemy());
}
