int state = 0; // 0=start, 1=play, 2=end
int startTime;
int duration = 20; // seconds

void setup() {
  size(700, 350);
}

void draw() {
  background(245);

  // START screen
  if (state == 0) {
    textAlign(CENTER, CENTER);
    textSize(24);
    fill(0);
    text("Press ENTER to Start", width/2, height/2);
  }

  // PLAY screen (timer runs)
  if (state == 1) {
    int elapsed = (millis() - startTime) / 1000; // convert ms to seconds
    int left = duration - elapsed;

    textAlign(LEFT, TOP);
    textSize(18);
    fill(0);
    text("Time Left: " + left, 20, 20);

    if (left <= 0) {
      state = 2; // go to END screen
    }
  }

  // END screen
  if (state == 2) {
    textAlign(CENTER, CENTER);
    textSize(24);
    fill(0);
    text("Time Over! Press R to Reset", width/2, height/2);
  }
}

void keyPressed() {
  // press ENTER to start playing
  if (state == 0 && keyCode == ENTER) {
    state = 1;
    startTime = millis(); // remember the start time
  }

  // press R to reset back to start screen
  if (state == 2 && (key == 'r' || key == 'R')) {
    state = 0;
  }
}
