
/////////////////////////////////////
void screenBinary() {

  setFieldVisible(true);
  
  LSB=1;
    
  cp5.get(Slider.class, "Tension (milliV)").setVisible(false);
  cp5.get(Numberbox.class, "quantum (mv)").setVisible(false); 
  
    

  fill(255, 255, 0);
  textSize(20);
  text ("Binaire", 160, 175);
  text ("Décimal", 30, 175);

  String s = Integer.toBinaryString(adc);
  s = "00000000000"+s;
  s = s.substring(s.length()-10);

  // affichage de la sortie du CAN
  adcValue.clear();
  adcValue.append(s);

  // affichage de la tension
  tension_mV.clear();
  tension_mV.append(" "+ Integer.toString(floor(tension)));

  // affichage des bits sous forme de recttangle colorie
  for (int i=0; i<10; i++) {  
    //delay(7);
    //stroke(255);
    fill(getCol(adc, i));            
    rect(10+((10-i)*25), 210, 20, 20);  // draw rectangle
  }  



  // affichage de la nomenclature couleur
  textSize(15);
  fill(255, 255, 0);
  text ("Couleurs des poids", 90, 490);

  stroke(255);
  for (int i=0; i<10; i++) {  
    //delay(7);
    fill(col[i]);            
    rect(10+((10-i)*25), 500, 20, 20);  // draw rectangle

    //
    textSize(8);
    textAlign(LEFT);
    fill(0);
    text((int)pow(2, i), 15+((10-i)*25), 515);
  }
}



//////////////////////////////////////////////
void screenCurve() {

  background(255);
  
  setFieldVisible(false);

  drawFrame(20);  // 20 = space between

  drawCurve(startValue, 20); // 20 = space between
}


//////////////////////////////////////////////
void screenComm() {
  
  setFieldVisible(true);
  ////delay(5000);
   
  //cp5.get(Textarea.class, "debug").setVisible(true);
  
  //cp5.get(Textarea.class, "tension (mV)").setVisible(true);
 
  //cp5.get(Numberbox.class, "quantum (mv)").setVisible(true); 
  
 
  //cp5.get(ScrollableList.class, "Choisir Port Serie").setVisible(true);
  //cp5.get(Button.class, "OuvrirPortSerie").setVisible(true);
  //cp5.get(Button.class, "FermerPortSerie").setVisible(true);

 
}

//////////////////////////////////////////////
void screenSimu() {

  setFieldVisible(true);
 
}


///
color getCol(int adc, int i) {
  if ((adc >> i & 1) == 1) {
    return col[i];
  }
  return color(150);
}

void setFieldVisible(boolean f) {
  

  cp5.get(Slider.class, "Tension (milliV)").setVisible(f);
  cp5.get(Textarea.class, "debug").setVisible(f);
  cp5.get(Textarea.class, "adcValue").setVisible(f);
  cp5.get(Textarea.class, "tension (mV)").setVisible(f);
  cp5.get(Button.class, "Plus").setVisible(f);
  cp5.get(Button.class, "Moins").setVisible(f);
  cp5.get(Button.class, "RAZ").setVisible(f);
  cp5.get(Numberbox.class, "quantum (mv)").setVisible(f); 
  cp5.get(Numberbox.class, "startValue(mV)").setVisible(f); 
  cp5.get(Textfield.class, "Valeur décimale ?").setVisible(f);
  cp5.get(ScrollableList.class, "Choisir Port Serie").setVisible(f);
  cp5.get(Button.class, "OuvrirPortSerie").setVisible(f);
  cp5.get(Button.class, "FermerPortSerie").setVisible(f);
  for (int i=0; i<10; i++) {
    togl[i].setVisible(f);
  }
}


void razBits () {
  for (int i=0; i<10; i++) {
    togl[i].setValue(false);
    //println("--"+togl[i].getValue()+"  "+tension);
  }
}
