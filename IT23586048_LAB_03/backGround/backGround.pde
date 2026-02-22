ArrayList<Enemy> enemies = new ArrayList<Enemy>();

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
}

void mousePressed(){
  enemies.add(new Enemy());
}
