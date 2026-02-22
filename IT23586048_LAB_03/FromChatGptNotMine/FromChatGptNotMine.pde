// ===============================
// GAME VARIABLES
// ===============================

int state = 0; // 0 = Start, 1 = Play, 2 = End
int startTime;
int duration = 30;

boolean trails = false;
int score = 0;

// Player
float px = 350, py = 175;
float pr = 20;
float step = 6;

// Helper (easing)
float hx, hy;
float ease = 0.08;

// Orb
float ox, oy;
float or = 18;
float xs = 4;
float ys = 3;

// ===============================

void setup(){
  size(700, 350);
  resetGame();
}

// ===============================

void draw(){

  // ================= START SCREEN =================
  if(state == 0){
    background(20);
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(28);
    text("CATCH THE ORB", width/2, height/2 - 30);
    textSize(18);
    text("Press ENTER to Start", width/2, height/2 + 10);
  }

  // ================= PLAY STATE =================
  if(state == 1){

    // Trail logic
    if(!trails){
      background(15);
    } else {
      noStroke();
      fill(0, 40);
      rect(0, 0, width, height);
    }

    // Timer
    int elapsed = (millis() - startTime) / 1000;
    int left = duration - elapsed;

    if(left <= 0){
      state = 2;
    }

    // Player movement
    if(keyPressed){
      if(keyCode == RIGHT) px += step;
      if(keyCode == LEFT)  px -= step;
      if(keyCode == UP)    py -= step;
      if(keyCode == DOWN)  py += step;
    }

    px = constrain(px, pr, width - pr);
    py = constrain(py, pr, height - pr);

    // Orb movement
    ox += xs;
    oy += ys;

    if(ox > width - or || ox < or) xs *= -1;
    if(oy > height - or || oy < or) ys *= -1;

    // Collision
    float d = dist(px, py, ox, oy);
    if(d < pr + or){
      score++;
      resetOrb();

      // Increase difficulty
      xs *= 1.1;
      ys *= 1.1;
    }

    // Helper easing
    hx += (px - hx) * ease;
    hy += (py - hy) * ease;

    // Draw orb
    fill(255, 80, 80);
    ellipse(ox, oy, or*2, or*2);

    // Draw player
    fill(60, 150, 255);
    ellipse(px, py, pr*2, pr*2);

    // Draw helper
    fill(80, 255, 120);
    ellipse(hx, hy, 14, 14);

    // UI
    fill(255);
    textAlign(LEFT, TOP);
    textSize(16);
    text("Score: " + score, 20, 20);
    text("Time: " + left, 20, 40);
    text("Press T for Trails", 20, 60);
  }

  // ================= END SCREEN =================
  if(state == 2){
    background(0);
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(26);
    text("TIME OVER!", width/2, height/2 - 30);
    textSize(20);
    text("Final Score: " + score, width/2, height/2);
    text("Press R to Restart", width/2, height/2 + 40);
  }
}

// ===============================
// KEY CONTROLS
// ===============================

void keyPressed(){

  // Start game
  if(state == 0 && keyCode == ENTER){
    state = 1;
    startTime = millis();
  }

  // Restart
  if(state == 2 && (key == 'r' || key == 'R')){
    resetGame();
    state = 0;
  }

  // Toggle trails
  if(key == 't' || key == 'T'){
    trails = !trails;
  }
}

// ===============================
// RESET FUNCTIONS
// ===============================

void resetGame(){
  score = 0;
  px = width/2;
  py = height/2;
  hx = px;
  hy = py;
  xs = 4;
  ys = 3;
  resetOrb();
}

void resetOrb(){
  ox = random(or, width - or);
  oy = random(or, height - or);
}
