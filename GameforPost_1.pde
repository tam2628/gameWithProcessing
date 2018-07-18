//We need two players a user and an AI and their scores
int playerScore = 0;
int aiScore = 0;
int paddleHeight = 150;
int paddleWidth = 20;
boolean gameStart = false;
boolean gameOver = false;
int ballSpeedX = 7;
int ballSpeedY = 7;
int ballX = 750;
int ballY = 450;
int aiPaddleSpeed = 6;
int aiPaddleY = 750;

void setup() {
  //fullScreen(); makes the sketch appear on whole screen
  size(1500, 900);
  background(0);  
  gameSetup();  
}

void draw() {
   
  if(!gameStart) {
    textAlign(CENTER);
    textSize(64);
    text("Press the left mouse key to start", width/2, height/2 - 200);
  }
  
  if(gameStart) {
      background(0);
      
      stroke(255);
      line(width/2 , 0 , width/2 , 900);
      
      noStroke();
      //player paddle on the left side and color blue
      fill(135, 206, 235); //the blue color
      
      rect(0, mouseY, paddleWidth, paddleHeight, 3);
      
      //the Ai
      playTheAI(aiPaddleSpeed);
      
      //Player scores
      fill(135, 206, 235);
      textSize(32);
      text("Player Score \n", width/4 , 50);
      text(playerScore, width/4, 90);
      
      //AI scores
      fill(235, 56, 138);
      textAlign(CENTER);
      textSize(32);
      text("AI Score \n", 3*width/4 , 50);
      text(aiScore, 3*width/4, 90);  
    
      //the ball - kinda yellow in color
      fill(255, 204, 102);
      ellipse(ballX, ballY, 30, 30);
      
      ballSpeed();
      ballBounce();
      
      if( ballX > width + 30 ) restartGame(1); //PlayerScored
      if( ballX < -30 ) restartGame(0); //AiScored
      
  }
  
  
}

void ballSpeed() {
  ballX += ballSpeedX;
  ballY += ballSpeedY;
}

void ballBounce() {
  //ball bounces back if struck with the upper or lower edge
  if(ballY <= 0 || ballY >= height - ballSpeedY) ballSpeedY = -ballSpeedY;
  //if ball strikes the player paddle 
  if(ballX <= paddleWidth && ballX > 0 && ballY >= mouseY && ballY <= mouseY+ paddleHeight) { ballSpeedY = -ballSpeedY;  ballSpeedX = -ballSpeedX; }
  //if ball strikes the ai paddle 
  if(ballX >= width-paddleWidth && ballX < width && ballY >= aiPaddleY - paddleHeight/2 && ballY <= aiPaddleY + paddleHeight/2) { ballSpeedY = -ballSpeedY;  ballSpeedX = -ballSpeedX; }
}
 
void mouseClicked() {
  if(mouseButton == LEFT) {
    gameStart =  true;
  }
  if(mouseButton == RIGHT) {
    gameStart = false;
  }
}

void playTheAI(int aiPaddleSpeed) {
  //AI paddle on the right side and color pink
    fill(235, 56, 138); //the blue color
    if(ballY > aiPaddleY - paddleHeight/2 ) aiPaddleY += aiPaddleSpeed;
    if(ballY < aiPaddleY - paddleHeight/2) aiPaddleY -= aiPaddleSpeed;
    rect(width-paddleWidth, aiPaddleY - paddleHeight/2, paddleWidth, paddleHeight, 3);
}

void restartGame(int whoScored) {
  switch (whoScored){
    case 1: playerScore++; break;
    case 0: aiScore++; break;
    default: break;
  }
  gameStart = false;
  gameSetup();
  //println(whoScored);
}

void gameSetup() {
  redraw();
  ballX = 750;
  ballY = 450;
  stroke(255);
  line(width/2 , 0 , width/2 , 900);
  
  noStroke();
  //player paddle on the left side and color blue
  fill(135, 206, 235); //the blue color
  rect(0, height/2 - paddleHeight/2, paddleWidth, paddleHeight, 3);
  //AI paddle on the right side and color pink
  fill(235, 56, 138); //the blue color
  rect(width-paddleWidth, height/2-paddleHeight/2, paddleWidth, paddleHeight, 3);
  
  
  //Player scores
  fill(135, 206, 235);
  textSize(32);
  text("Player Score \n", width/4 , 50);
  text(playerScore, width/4, 90);
  
  //AI scores
  fill(235, 56, 138);
  textAlign(CENTER);
  textSize(32);
  text("AI Score \n", 3*width/4 , 50);
  text(aiScore, 3*width/4, 90);  

  //the ball - kinda yellow in color
  fill(255, 204, 102);
  ellipse(width/2, height/2, 30, 30);
}
