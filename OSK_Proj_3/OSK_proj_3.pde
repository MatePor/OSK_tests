final String[] instructions = {
  " --- TEST 1 --- \n"+
  " You have to click the red circle. \n"+
  " After every success it stays in place for a little less time \n"+
  " You have 30 seconds \n"+
  "Good luck!", 
  " --- TEST 2 --- \n"+
  " You need to decide whether the color name matches color of the letters \n"+
  " Click on the right side of the screen if YES \n"+
  " Click on the left side of the screen if NO \n"+
  " success = +1 point, failure = -2 points, no clicks = no points \n"+
  " Colors change faster with every success \n"+
  " You have 30 seconds \n"+
  "Good luck!", 
  " --- TEST 3 --- \n"+
  " You need to wait for the red color and click as fast as possible \n"+
  " Your result will be the average of 5 tries \n"+
  " If you click before the red color appears your time will be 2 seconds \n"+
  "Good luck!", 
};

int MODE, OFF_D;
long T_START, T_STOP, TIME_INT;
long t0, t1, dt;
float TIMER, TEST_TIMER;
int []scores;
int [] avgScores;
int [] bestScores;
String [] aNames;
String [] bNames;
String [] data;

boolean inst, test, fini;

// test 1
int ellR;
PVector circPos;

// test 2
color [] clrs = {
  color(0), color(255), 
  color(255, 0, 0), color(255, 255, 0), 
  color(0, 255, 0), color(0, 0, 255)
};
String [] col_names =
  {
  "BLACK", "WHITE", "RED", "YELLOW", "GREEN", "BLUE"
};
int ic, in;

// test 3
long rT;
int tries;
long times[] = new long[5];
boolean goClick;

// summary
float [] barLeng;
String NAME;
boolean saved;

void setup()
{
  fullScreen();
  rectMode(CENTER);

  if (width > height)
    OFF_D = height/6;
  else
    OFF_D = width/6;

  // PROPS 
  ellR = 2*OFF_D/3;

  MODE = 0;
  // TEST TIME
  T_START = 0;
  T_STOP = 0;
  TIME_INT = 30000;
  TIMER = 30.0;
  TEST_TIMER = 0;

  // PROPS TIMING
  t0 = 0;
  t1 = 0;
  dt = 3000;
  circPos = new PVector(0, 0);
  ic = 0;
  in = 0;
  times[0] = times[1] = times[2] = times[3] = times[4] = 0;
  rT = 0;
  goClick = false;
  tries = 0;
  
  NAME = "player";

  inst = false;
  test = false;
  fini = false;

  scores = new int[3];
  avgScores = new int[3];
  bestScores = new int[3];
  aNames = new String[3];
  bNames = new String[3];
  barLeng = new float[9];

  for(int i = 0; i < 3; i++)
  {
    scores[i] = 0;
    avgScores[i] = 0;
    bestScores[i] = 0;
    bNames[i] = " ";
    barLeng[i*3] = 0;
    barLeng[i*3 + 1] = 0;
    barLeng[i*3 + 2] = 0;
  }
  
  bestScores[2] = 10000; 
  
  data = loadStrings("Results.txt");
  
  for (int i = 0 ; i < data.length; i++) 
  {
    println(data[i]);
    
    String[] res = split(data[i], ',');
    
    if(int(res[1]) > bestScores[0])
    {
       bestScores[0] = int(res[1]);
       bNames[0] = res[0];    
       println(res[1]);
    }
    
    if(int(res[2]) > bestScores[1])
    {
       bestScores[1] = int(res[2]);
       bNames[1] = res[0];    
       println(res[2]);
    }
    
    if(int(res[3]) < bestScores[2])
    {
       bestScores[2] = int(res[3]);
       bNames[2] = res[0];   
       println(res[3]);
    }

    avgScores[0] += int(res[1]);
    avgScores[1] += int(res[2]);
    avgScores[2] += int(res[3]);
  }
  
  if(data.length != 0)
  {
    avgScores[0] /= data.length;
    avgScores[1] /= data.length;
    avgScores[2] /= data.length;
  }
  
  saved = false;

}

void draw()
{
  background(0);

  switch(MODE)
  {
  case 0:
    showMenu();
    break;

  case 1: 
    test1();
    break;

  case 2:
    test2();
    break;

  case 3:
    if (goClick)
      background(255, 0, 0);
    else
      background(200);
    test3();
    showTimes();
    break;

  case 4:
    showSummary();
    break;

  default:
    break;
  }

  if(MODE != 4)
  {
    if (test || MODE == 3)
      showClock();
      
    if(test && MODE != 3)
      showScore();
  
    if (inst && MODE != 0)
      showInstructions();
  
    if (!test && !inst && !fini && MODE != 0)
      showReady();
  }
}

void mouseReleased()
{
  if (MODE == 0)
  {
    MODE++;
    inst = true;
  } else
  {
    if(MODE != 4)
    {
      if (inst)
      {
        inst = false;
        if (MODE == 3 && !test)
        { 
          rT = int(random(1000, 6000));
          goClick = false;
          TIMER = 0;
          t0 = millis();
        }
      } else if (!test && !inst && !fini && mouseX < 2*OFF_D && mouseY < OFF_D)
      {
        test = true;
        if (MODE != 3)
          T_START = millis();
      }
    } else
    {
      // summary
      if (mouseX < 2*OFF_D && mouseY < OFF_D)
          restartTests();
      if (mouseX > width - 2*OFF_D && mouseY < OFF_D && !saved)
       {
         saved = true;
         saveResults();
       }
    }
  }
}  

void mousePressed()
{
  switch(MODE)
  {

  case 1:
    if (distSq(mouseX, mouseY, circPos.x, circPos.y) < ellR*ellR)
    {
      if (test)
        scores[0]++;

      circPos.set(random(width), random(OFF_D, height));   
      t0 = millis();
      dt *= 0.95;
    } 
    break;

  case 2:
    if ((mouseX < width/2 && ic != in)|| (mouseX > width/2 && ic == in))
    { 
      if (test && !fini)
        scores[1]++;
      dt *= 0.98;
    } else if (test && !fini)
      scores[1] -= 2;

    int eq = floor(random(2));
    if (eq == 1)
    {
      ic = floor(random(6));
      in = ic;
    } else
    {
      ic = floor(random(6));
      in = floor(random(6));
    }
    
    t0 = millis();
    break;

  case 3:
    if(!fini)
    {
      if (goClick)
      {
        goClick = false;
        t0 = millis();
        rT = int(random(1000, 6000));
        TEST_TIMER = TIMER;
        TIMER = 0; 
        if(test)
        {
          times[tries] = millis() - T_START;
          tries++;
        }
      } else
      { 
        goClick = false;
        t0 = millis();
        rT = int(random(1000, 6000));
        TEST_TIMER = 2000;
        TIMER = 0;
        if(test)
        {
          times[tries] = 2000;
          tries++;
        }
      }
      
      if(tries == 5)
      {
         fini = true;
         int avgTime = 0;
         for(int i = 0; i < 5; i++)
             avgTime += times[i];
    
         avgTime /= 5;
         scores[2] = avgTime;
         T_STOP = millis();
      }
    }
    break;  

  default:
    break;
  }
}

void keyReleased()
{   
  if (key == TAB)
  {
    MODE = 4;
    inst = false;
    test = false;
    fini = false;  
  }
  
  if (MODE == 0)
  {
    MODE++;
    inst = true;
  } else
  {
    if(MODE != 4)
    {
      if (key == 'i' || key == 'I')
        inst = true;
      else if (inst)
      {
        inst = false;
        if (MODE == 3)
         { 
          rT = int(random(1000, 6000));
          goClick = false;
          TIMER = 0;
          t0 = millis();
        } else
          T_START = millis();
      }
    } else
    {
      // summary
      if (key == BACKSPACE)
         {
           if (NAME.length()>0) 
              NAME = NAME.substring(0, NAME.length()-1);
         }
          else if (key != CODED && NAME.length() < 10)
            NAME += key;
      
    }
  }
}

void restartTests()
{
  
  // PROPS 
  ellR = 2*OFF_D/3;

  MODE = 0;
  // TEST TIME
  T_START = 0;
  T_STOP = 0;
  TIME_INT = 30000;
  TIMER = 30.0;
  TEST_TIMER = 0;

  // PROPS TIMING
  t0 = 0;
  t1 = 0;
  dt = 3000;
  circPos = new PVector(0, 0);
  ic = 0;
  in = 0;
  times[0] = times[1] = times[2] = times[3] = times[4] = 0;
  rT = 0;
  goClick = false;
  tries = 0;
  
  NAME = "player";

  inst = false;
  test = false;
  fini = false;

  scores = new int[3];
  avgScores = new int[3];
  bestScores = new int[3];
  aNames = new String[3];
  bNames = new String[3];
  barLeng = new float[9];

  for(int i = 0; i < 3; i++)
  {
    scores[i] = 0;
    avgScores[i] = 0;
    bestScores[i] = 0;
    bNames[i] = " ";
    barLeng[i*3] = 0;
    barLeng[i*3 + 1] = 0;
    barLeng[i*3 + 2] = 0;
  }
  
  bestScores[2] = 10000; 
  
  data = loadStrings("Results.txt");
  
  for (int i = 0 ; i < data.length; i++) 
  {
    println(data[i]);
    
    String[] res = split(data[i], ',');
    
    if(int(res[1]) > bestScores[0])
    {
       bestScores[0] = int(res[1]);
       bNames[0] = res[0];    
       println(res[1]);
    }
    
    if(int(res[2]) > bestScores[1])
    {
       bestScores[1] = int(res[2]);
       bNames[1] = res[0];    
       println(res[2]);
    }
    
    if(int(res[3]) < bestScores[2])
    {
       bestScores[2] = int(res[3]);
       bNames[2] = res[0];   
       println(res[3]);
    }

    avgScores[0] += int(res[1]);
    avgScores[1] += int(res[2]);
    avgScores[2] += int(res[3]);
  }
  
  if(data.length != 0)
  {
    avgScores[0] /= data.length;
    avgScores[1] /= data.length;
    avgScores[2] /= data.length;
  }
  
  saved = false;

}

void saveResults()
{
  String [] outData = new String[data.length+1];
  for (int i = 0; i < data.length; i++)
    outData[i] = data[i];
  
  outData[data.length] = NAME + "," + scores[0] +"," + scores[1] + "," + scores[2];
  saveStrings("Results.txt", outData);

}
