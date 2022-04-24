// ----------------------- FIRST TEST ---------------------------
void test1()
{
  pushStyle();

  if (!fini)
  {
    if (millis() - t0 > dt)
    {
      t0 = millis();
      circPos.set(random(width), random(OFF_D, height));
    }

    fill(255, 0, 0);
    if (distSq(mouseX, mouseY, circPos.x, circPos.y) < ellR*ellR)
    {
      strokeWeight(8);
      stroke(255);
      fill(0, 0, 255);
    } else
    {
      strokeWeight(1);
      stroke(0);
      fill(255, 0, 0);
    }

    ellipse(circPos.x, circPos.y, ellR, ellR);
  }

  if (test)
  {
    TIMER = 30.0 - (millis() - T_START)/1000.0;
    if (TIMER < 0)
      TIMER = 0;

    if (millis() - T_START > TIME_INT && !fini)
    {
      T_STOP = millis();
      fini = true;
    }  

    if (fini)
    {  
      pushStyle();
      textAlign(CENTER, CENTER);
      textSize(OFF_D);
      fill(200, 150);
      rect(width/2, height/2, width, height);
      fill(0);
      text("Your score = " + str(scores[0]), 
        width/2, height/3, width, height/2);
      popStyle();
    }

    if (fini && millis() - T_STOP > 3000)
    {
      fini = false;
      test = false;
      inst = true;
      MODE++;
      TIMER = 30.0;
      dt = 3000;
    }
  }
  popStyle();
}

// -----------------------  SECOND TEST ---------------------------
void test2()
{
  pushStyle();
  fill(130);
  rect(width/2, height/2, width, height);
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(height/10);
  text("NO", width/4, height - height/12, width/2, height/6);
  text("YES", 3*width/4, height - height/12, width/2, height/6);

  if (!fini)
  {
    if (millis() - t0 > dt)
    {
      t0 = millis();
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
    }
    stroke(0);
    line(width/2, 0, width/2, height);
    fill(clrs[ic]);
    textSize(height/8);
    text(col_names[in], width/2, height/3, width, 2*height/3);
  }

  if (test)
  {
    TIMER = 30.0 - (millis() - T_START)/1000.0;
    if (TIMER < 0)
      TIMER = 0;

    if (millis() - T_START > TIME_INT && !fini)
    {
      T_STOP = millis();
      fini = true;
    }  

    if (fini)
    {  
      pushStyle();
      textAlign(CENTER, CENTER);
      textSize(OFF_D);
      fill(200, 150);
      rect(width/2, height/2, width, height);
      fill(0);
      text("Your score = " + str(scores[1]), 
        width/2, height/3, width, height/2);
      popStyle();
    }

    if (fini && millis() - T_STOP > 3000)
    {
      fini = false;
      test = false;
      inst = true;
      MODE++;
      TIMER = 30.0;
    }
  }
  popStyle();
}

// ----------------------- THIRD TEST ---------------------------
void test3()
{
  pushStyle();

  if (!fini && !inst)
  {
      if (millis() - t0 > rT && !goClick && TIMER == 0)
      { 
         goClick = true;
         T_START = millis();
      }
 
    if(goClick)
      TIMER = (millis() - T_START); 
  }
  
  if(!inst && !fini)
  {
    if(!test && tries == 0)
    {
        pushStyle();
        textAlign(CENTER, CENTER);
        textSize(OFF_D/2);
        fill(0);
        text("Your last time = " + nf(TEST_TIMER, 4, 0) + " ms \n WAIT FOR THE RED!", 
          width/2, height/3, width, height/2);
        popStyle();
    } else
    {
      pushStyle();
      textAlign(CENTER, CENTER);
      textSize(OFF_D/2);
      fill(0);
      text("WAIT FOR THE RED!", 
        width/2, height/3, width, height/2);
      popStyle();
    }
  }
  
  if (fini)
  {  
      pushStyle();
      textAlign(CENTER, CENTER);
      textSize(OFF_D);
      fill(200, 150);
      rect(width/2, height/2, width, height);
      fill(0);
      text("Your score = " + str(scores[2]), 
        width/2, height/3, width, height/2);
      popStyle();
  }

    if (fini && millis() - T_STOP > 3000)
    {
      fini = false;
      test = false;
      inst = true;
      MODE++;
      TIMER = 30.0;
      float wid = width/3;
      barLeng[0] = (scores[0]/60.0)*wid;
      barLeng[1] = (avgScores[0]/60.0)*wid;
      barLeng[2] = (bestScores[0]/60.0)*wid;
      
      barLeng[3] = (scores[1]/60.0)*wid;
      barLeng[4] = (avgScores[1]/60.0)*wid;
      barLeng[5] = (bestScores[1]/60.0)*wid;
      
      barLeng[6] = (scores[2]/500.0)*wid;
      barLeng[7] = (avgScores[2]/500.0)*wid;
      barLeng[8] = (bestScores[2]/500.0)*wid;
      
      for(int i = 0; i < 9; i++)
      {
         if(barLeng[i] > wid)
           barLeng[i] = wid;
         
         if(barLeng[i] < 0)
           barLeng[i] = 0;
           
         println(barLeng[i]);
      }
    }
}

float distSq(float x1, float y1, float x2, float y2)
{
  return (x1-x2)*(x1-x2) + (y1-y2)*(y1-y2);
}
