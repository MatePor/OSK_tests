void showClock()
{
   pushStyle();
   textAlign(CENTER, CENTER);
   textSize(OFF_D/2);
   fill(200, 100);
   rect(width - OFF_D, OFF_D/2, 2*OFF_D, OFF_D);
   fill(0);
   if(MODE == 3)
     text(nf(TIMER, 4, 0), 
    width - OFF_D, OFF_D/2, 2*OFF_D, OFF_D);
   else
     text(nf(TIMER, 2, 1).replace(',', '.'), 
    width - OFF_D, OFF_D/2, 2*OFF_D, OFF_D);
    
   popStyle();
}

void showScore()
{
   pushStyle();
   textAlign(CENTER, CENTER);
   textSize(OFF_D/2);
   fill(200, 100);
   rect(OFF_D, OFF_D/2, 2*OFF_D, OFF_D);
   fill(0);
   text(str(scores[MODE-1]), 
    OFF_D, OFF_D/2, 2*OFF_D, OFF_D);
   popStyle();
}

void showReady()
{
   pushStyle();
   textAlign(CENTER, CENTER);
   textSize(OFF_D/2);
   fill(200, 100);
   if (mousePressed && mouseX < 2*OFF_D && mouseY < OFF_D)
     strokeWeight(15);
   else
     strokeWeight(1);
   rect(OFF_D, OFF_D/2, 2*OFF_D, OFF_D);
   fill(0);
   text("READY", 
    OFF_D, OFF_D/2, 2*OFF_D, OFF_D);
    fill(255);
    text("Training...", 4*OFF_D, OFF_D/2, 4*OFF_D, OFF_D);
   popStyle(); 
}

void showInstructions()
{
  pushStyle();
  textAlign(LEFT, CENTER);
  textSize(OFF_D/5);
  fill(200, 150);
  rect(width/2, height/2, 2*width/3, height);
  fill(0);
  text(instructions[MODE-1] + "\n \n Press any key to start...", width/2, height/3, 2*width/3, height/2);
  popStyle();
}

void showMenu()
{
  pushStyle();
  textAlign(LEFT, CENTER);
  textSize(OFF_D/5);
  fill(200, 150);
  rect(width/2, height/2, 2*width/3, height);
  fill(0);
  text(" - You will take 3 tests. \n - Each one will be scored differently \n" +
  " - Before every test you will see instructions \n" +
  " - Press any key to close instructions and start training mode \n" +
  " - To start actual test click READY button in the top left corner \n" +
  " - After every test you will see your score \n" +
  " - Next test will start automatically \n"+
  " - Press [i] to open instructions. \n" + 
  " - Press any key to continue ...", 
    width/2, height/3, 2*width/3, height/2);
  popStyle();
}

void showTimes()
{
  pushStyle();
  textAlign(CENTER, CENTER);
  textSize(OFF_D/4);
  
  for(int i = 0; i < 5; i++)
  {
    if(tries == i)
    {
      strokeWeight(15);
      stroke(255,0,0);
    }
    else
    {
      strokeWeight(1);
      stroke(0);
    }
    fill(200, 100);
    rect(OFF_D/2+i*OFF_D, height - OFF_D/2, OFF_D, OFF_D);
    fill(0);
    if(times[i] != -1)
      text("Time: " + str(times[i]) + " ms", 
       OFF_D/2+i*OFF_D, height - OFF_D/2, OFF_D, OFF_D);
    else
      text("Time: X ", 
       OFF_D/2+i*OFF_D, height - OFF_D/2, OFF_D, OFF_D);
  }
  
  popStyle(); 
}

void showSummary()
{
  pushStyle();
  textAlign(CENTER, CENTER);
  textSize(OFF_D/3);
  fill(200, 100);
  if (mousePressed && mouseX > width - 2*OFF_D && mouseY < OFF_D)
    strokeWeight(15);
  else
    strokeWeight(1);
  rect(width - OFF_D, OFF_D/2, 2*OFF_D, OFF_D);
  strokeWeight(1);
  fill(0);
  text("SAVE", width - OFF_D, OFF_D/2, 2*OFF_D, OFF_D);
  fill(200, 100);
  if (mousePressed && mouseX < 2*OFF_D && mouseY < OFF_D)
    strokeWeight(15);
  else
    strokeWeight(1);
  rect(OFF_D, OFF_D/2, 2*OFF_D, OFF_D);
  strokeWeight(1);
  fill(0);
  text("RESTART", OFF_D, OFF_D/2, 2*OFF_D, OFF_D);
    
  fill(200, 100);
  rect(width/6, OFF_D + OFF_D/2, width/3, OFF_D);
  fill(0);
  text("SUMMARY", width/6, OFF_D + OFF_D/2, width/3, OFF_D);
  fill(200, 100);
  rect(width/6, 2*OFF_D + OFF_D/2, width/3, OFF_D);
  fill(0, 255);
  text(" - Test 1 - ", width/6, 2*OFF_D + OFF_D/2, width/3, OFF_D);
  fill(200, 100);
  rect(width/2,  2*OFF_D + OFF_D/2,  width/3, OFF_D);
  fill(0);
  text(" - Test 2 - ", width/2,  2*OFF_D + OFF_D/2,  width/3, OFF_D);
  fill(200, 100);
  rect(width - width/6,  2*OFF_D + OFF_D/2, width/3, OFF_D);
  fill(0);
  text(" - Test 3 - ", width - width/6,  2*OFF_D + OFF_D/2, width/3, OFF_D);
  
  if(saved)
  {
    fill(255);
    text("saved ...", width/2, OFF_D/2, width, OFF_D);
  }
  
  textSize(OFF_D/4);
  textAlign(LEFT, CENTER);
  fill(200, 100);
  rect(2*width/3, OFF_D + OFF_D/2, 2*width/3, OFF_D);
  fill(0);
  text("Enter your name: " + NAME, 2*width/3, OFF_D + OFF_D/2, 2*width/3, OFF_D);
  textSize(OFF_D/3);
  
  // TEST 1
  fill(200, 100);
  rect(width/6, 3*OFF_D + OFF_D/2, width/3, OFF_D);
  rect(width/6, 4*OFF_D + OFF_D/2, width/3, OFF_D);
  rect(width/6, 5*OFF_D + OFF_D/2, width/3, OFF_D);
  rect(width/2, 3*OFF_D + OFF_D/2, width/3, OFF_D);
  rect(width/2, 4*OFF_D + OFF_D/2, width/3, OFF_D);
  rect(width/2, 5*OFF_D + OFF_D/2, width/3, OFF_D);
  rect(width - width/6,  3*OFF_D + OFF_D/2, width/3, OFF_D);
  rect(width - width/6,  4*OFF_D + OFF_D/2, width/3, OFF_D);
  rect(width - width/6, 5*OFF_D + OFF_D/2, width/3, OFF_D);
 
  noStroke();
  fill(0, 255, 0);
  rect(barLeng[0]/2, 3*OFF_D + OFF_D/2, barLeng[0], OFF_D);
  rect(width/3 + barLeng[3]/2, 3*OFF_D + OFF_D/2, barLeng[3], OFF_D);
  rect(2*width/3 + barLeng[6]/2, 3*OFF_D + OFF_D/2, barLeng[6], OFF_D);
  fill(0,0,255);
  rect(barLeng[1]/2, 4*OFF_D + OFF_D/2, barLeng[1], OFF_D);
  rect(width/3 + barLeng[4]/2, 4*OFF_D + OFF_D/2, barLeng[4], OFF_D);
  rect(2*width/3 + barLeng[7]/2, 4*OFF_D + OFF_D/2, barLeng[7], OFF_D);
  fill(255,0,0);
  rect(barLeng[2]/2, 5*OFF_D + OFF_D/2, barLeng[2], OFF_D);
  rect(width/3 + barLeng[5]/2, 5*OFF_D + OFF_D/2, barLeng[5], OFF_D);
  rect(2*width/3 + barLeng[8]/2, 5*OFF_D + OFF_D/2, barLeng[8], OFF_D);
  stroke(0);
  
  String NB1 = " ", NB2 = " ", NB3 = " ";
  if(scores[0] > bestScores[0])
    NB1 = " (NEW BEST) ";
  if(scores[1] > bestScores[1])
    NB2 = " (NEW BEST) ";
  if(scores[2] < bestScores[2])
    NB3 = " (NEW BEST) ";
  
  fill(0);
  text("Your result: " + str(scores[0]) + NB1, width/6, 3*OFF_D + OFF_D/2, width/3, OFF_D);
  text("Average: " + str(avgScores[0]), width/6, 4*OFF_D + OFF_D/2, width/3, OFF_D);
  text("Best: " + str(bestScores[0]) + "  (" + bNames[0] + ")", width/6, 5*OFF_D + OFF_D/2, width/3, OFF_D);
  text("Your result: " + str(scores[1]) + NB2, width/2,  3*OFF_D + OFF_D/2,  width/3, OFF_D);
  text("Average: " + str(avgScores[1]), width/2,  4*OFF_D + OFF_D/2,  width/3, OFF_D);
  text("Best: " + str(bestScores[1]) + "  (" + bNames[1] + ")", width/2,  5*OFF_D + OFF_D/2,  width/3, OFF_D);
  text("Your result: " + str(scores[2]) + NB3, width - width/6,  3*OFF_D + OFF_D/2, width/3, OFF_D);
  text("Average: " + str(avgScores[2]), width - width/6,  4*OFF_D + OFF_D/2, width/3, OFF_D);
  text("Best: " + str(bestScores[2]) + "  (" + bNames[2] + ")", width - width/6,  5*OFF_D + OFF_D/2, width/3, OFF_D);
  popStyle();
}
