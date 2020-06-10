// final project - word search puzzle
// 108061203, Célia
// May 13, 2020

/* color palette */
color white    = color(255, 255, 255);
color yellow   = color(240, 232, 174);
color seashell = color(253, 243, 238);
color green    = color(130, 152, 101);
color lblue    = color(168, 199, 230);
color rose     = color(233, 162, 173);
color blue     = color(129, 182, 237);
/* other global variables */
int ss = second();
int time = 0;
int blur = 0;
boolean stopTime = false;
int correct = 0;
boolean stopClock = false;
int STATE = 0;
PImage img, img2, img3, img4;
PFont mono;
drop[] d;
StringList inventory;
String str = "loremipsumdolo25rsitamet,conse5cteturadipiscing;"
            +"elit,sed(doeiusmod)tempori7ncididuntut;laboree"
            +"t:doloremagnakn110quaametvolut6patconsequ0at$ma"
            +"loremips1umdolorsitamet,consecteturadipiscing5;"
            +"risnunccong00ue;nisi,vitaesuscipit.netusetmaleu"
            +"adafamesac;turpisegestas.";
ch[][] grid = new ch[15][15];
int startX, startY, style;
boolean stop;
boolean flag;
int totalu;

void setup() {
  int i, j;            // loop indices
  /* general sketch setting */
  size(1200, 800);

  noStroke();
  strokeJoin(ROUND);
    background(seashell);
    textAlign(CENTER, CENTER);
    mono = createFont("Century Gothic", 43);

    /* initialize the inventory (given) */
    inventory = new StringList();
    inventory.append(" ");
    inventory.append("taylor");
    inventory.append("impulse");
    inventory.append("convolution");
    inventory.append("laplace");
    inventory.append("noStroke();");
    for (i = 0; i < 15; i++) {
        for (j = 0; j < 15; j++) {
             grid[i][j] = new ch(str.charAt(14 * i + j), 0, 0, 
                  51.5 + 46.5 * i, 51.5 + 46.5 * j );
        }
    }
    testPositioning();
    fill(yellow);
    rect(40, 40, 720, 720);

    d = new drop[400];
    for (int k = 0; k < d.length; k++) {
      d[k] = new drop(); 
    }

    img = loadImage("neww.png");
    img2 = loadImage("newww.png");
    img3 = loadImage("homepage.png");
    img4 = loadImage("arrow.png");
}

void draw() {
  background(seashell);
  switch(STATE) {
    case 0: home();   break;
    case 1: gameOn(); break;
  }
}
void home() {
  image(img3, 0, 0);
  if (mousePressed) {
    if (mouseX > 760 && mouseX < (760 + 217)) {
      if (mouseY > 570 && mouseY < (570 + 112.5)) {
        STATE = 1;
      }
    }
  }
}
void gameOn() {
  fill(yellow);
  rect(40, 40, 720, 720);
  for (int i = 0; i < 15; i++) {
        for (int j = 0; j < 15; j++) { 
          colorBingo();
          grid[i][j].display();
        }
    }
    noStroke();
    textAlign(TOP, LEFT);
    textFont(mono, 65);
    fill(green);
    text("word-search", 780, 85);
    text("puzzle", 985, 150);
    fill(blue);
    textFont(mono, 35);
    for (int i = 1; i < inventory.size(); i++) {
      text(inventory.get(i), 800, 275 + (i - 1) * 40);
    }
    textAlign(CENTER, CENTER);

  fill(yellow);
    rect(790, 485, 360, 18);
    stopTime = myClock();

  if (stopTime) {
    println("correct: "+correct);
    if (correct < totalu) {
      image(img, 50, 50);
      textAlign(TOP, LEFT);
      textFont(mono, 26);
      fill(green);
      text("press any key to restart ;)", 800, 550);
      textAlign(CENTER, CENTER);
    }
  }
  if (correct == totalu) {
    stopClock = true;
    img2.filter(BLUR, blur);
    blur = 0;
    image(img2, 50, 50);
    fill(seashell);
    rect(800, 500, 1000, 600);
    textAlign(TOP, LEFT);
    textFont(mono, 26);
    fill(green);
    text("completed ;)", 800, 550);
    textAlign(CENTER, CENTER); 
    image(img4, width - 100, height - 100);
    if (mousePressed) {
      if (mouseX > 1100 && mouseX < 1160) {
        if (mouseY > 700 && mouseY < 760) {
          img2 = loadImage("newww.png");
          blur = 0;
          time = 0;
          stopTime = false;
          correct = 0;
          stopClock = false;
          reset();
          STATE = 0;
        }
      }
    }
  }

}
boolean myClock() {
  int s = second();

  if (ss != s) {
    time++;
    ss = s;
  }
  
  if (time <= 60 && !stopClock) {
    noStroke();
      fill(blue);
      rect(790 , 485, 360 - time * 6, 18);
      if (time > 30) rain(6 * time);
    return false;
  }
  else return true; 
}

boolean positioning() {
  int i, j;
  int t = 0;
  
  for (i = 1; i < inventory.size(); i++) {
    println("begin  i  = "+i);
      stop = false;
      flag = true;
      while(!stop) {
        t++;
      startX = (int)random(1, 16 - inventory.get(i).length());
      startY = (int)random(1, 16 - inventory.get(i).length());
      style = (int)random(3);
      
        switch(style) {
          case 0:
            for (int m = 0; m < inventory.get(i).length() && flag; m++) {
              if (grid[startX + m][startY].used == 1) {
                if (grid[startX + m][startY].c != inventory.get(i).charAt(m)) 
                  flag = false;
              }
            }
            break;
          case 1:
            for (int m = 0; m < inventory.get(i).length() && flag; m++) {
              if (grid[startX][startY + m].used == 1) {
                if (grid[startX][startY + m].c != inventory.get(i).charAt(m)) 
                  flag = false;
              }
            }
            break;
          case 2:
            for (int m = 0; m < inventory.get(i).length() && flag; m++) {
              if (grid[startX + m][startY + m].used == 1) {
                if (grid[startX + m][startY + m].c != inventory.get(i).charAt(m)) 
                  flag = false;
              }
            }
        }
        if (flag) {
         stop = true;
          t = 0;
        }
        else if (t > 5) {
          for (int k = 0; k < 15; k++) {
            for (int h = 0; h < 15; h++) {
              grid[h][k].c = str.charAt((int)(random(200)));
              grid[h][k].used = 0; 
              grid[h][k].n1 = 0; 
              grid[h][k].n2 = 0; 
            }
          }
          return false;
        }
        }     
      println("startX: "+startX);
      println("startY: "+startY);
      println("word: "+inventory.get(i));
      println("style: "+style);
      
      switch(style) {
        case 0:
          for (j = 0; j < inventory.get(i).length(); j++) {
            grid[startX + j][startY].n1 = i;
            grid[startX + j][startY].n2 = j;
            grid[startX + j][startY].c = inventory.get(i).charAt(j);
            if (grid[startX + j][startY].used == 0) {
              grid[startX + j][startY].used = 1;
              totalu++;
            }
          }
          break;
        case 1:
          for (j = 0; j < inventory.get(i).length(); j++) {
            grid[startX][startY + j].n1 = i;
            grid[startX][startY + j].n2 = j;
            grid[startX][startY + j].c = inventory.get(i).charAt(j);
            if (grid[startX][startY + j].used == 0) {
              grid[startX][startY + j].used = 1;
              totalu++;
            }
          }
          break;
        case 2:
          for (j = 0; j < inventory.get(i).length(); j++) {
            grid[startX + j][startY + j].n1 = i;
            grid[startX + j][startY + j].n2 = j;
            grid[startX + j][startY + j].c = inventory.get(i).charAt(j);
            if (grid[startX + j][startY + j].used == 0) {
              grid[startX + j][startY + j].used = 1;
              totalu++;
            }
          }
          break;
      }
      println("end  i = "+i);
      println("totalu = "+totalu);
      println("--------------");
    } 
    return true;
}

void testPositioning() {
  boolean x;
  totalu = 0;
  do {
    x = positioning();
    if (!x) totalu = 0;
  } while (!x);
}

class ch {
    char c;
    int n1;
    int n2;
    float x; 
    float y;
    int flag = 0;
    color bc, cc;
    int used = 0;

    ch (char C, int N1, int N2, float X, float Y) {
      c = C;
      n1 = N1;
      n2 = N2;
      x = X;
      y = Y;
    }

    void display() {
      switch(flag) {
          case 0:           // initial state
            bc = color(seashell);
            cc = color(lblue);
            break;
          case 1:            // selected
            bc = color(lblue);
            cc = color(seashell);
            break;
          case 2:            // hint
            bc = color(green);
            cc = color(seashell);
            break;
          case 3:            // word found
            bc = color(seashell);
            cc = color(green);
        }
        fill(bc);
        rect(x, y, 45, 45);
        fill(cc);
        textFont(mono, 43);
        text(c, x + 45/2, y + 45/2 - 10);
    }  
}

void keyTyped() {
  if (!stopClock) {
    blur += 1 ;
    reset();
  }
}

void reset() {
  stopTime = false;
  time = 0;
  testPositioning();
    fill(yellow);
    rect(40, 40, 720, 720);
    correct = 0;
    for (int i = 0; i < 15; i++) {
      for (int j = 0; j < 15; j++) {
        if (grid[i][j].flag != 0) grid[i][j].flag = 0; 
      }
    }
}

void mouseClicked() {
  if (STATE == 1) {
    for (int i = 0; i < 15; i++) {
      for (int j = 0; j < 15; j++) {
        if (grid[i][j].x < mouseX && mouseX < grid[i][j].x + 45 && grid[i][j].y < mouseY && mouseY < grid[i][j].y + 45) {
          switch (grid[i][j].flag) {
            case 0: grid[i][j].flag = 1;  break;
            case 1: grid[i][j].flag = 0;
          }
        }
      }  
    }
  }
}

void colorBingo() {
  boolean f;
  int i, m, n;
  
  for (i = 1; i < inventory.size(); i++) {
    f = true;
    for (m = 0; m < 15 && f; m++) {
      for (n = 0; n < 15 && f; n++) {
        if (grid[m][n].n1 == i) {
          if (grid[m][n].flag != 1 && grid[m][n].flag != 2) {
            f = false;
          }
        }
      }
    }
      for (m = 0; m < 15 && f; m++) {
        for (n = 0; n < 15 && f; n++) {
          if (grid[m][n].n1 == i) {
            if (grid[m][n].flag == 1) {
              grid[m][n].flag = 2;
              correct++;
            }
          }
        }
      }
  }
}

void rain(int i) {
  for (int j = 0; j < i; j++) {
    d[j].raining(blue);
  }
}

class drop {
  float x;
  float y;
  float velocity;
  
 drop() {
   x = random(0, width);
   y = random(-50, 0);
   velocity = random(5, 15);
 }
 void raining(color c) {
   strokeWeight(2);
   stroke(c);
   line(x, y, x, y + 15);
   y += velocity;
   if (y > height) y = random(-50, 0);
   noStroke();
 }
}
