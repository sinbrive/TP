
//////////////////////////////////////////
void screenBinary() {

  LSB=1;

  cp5.get(Textarea.class, "adcValue").moveTo("default");

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
  tension_mv.clear();
  tension_mv.append(" "+ Integer.toString(floor(tension)));

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
    textSize(12);
    fill(255,255,0);
    noStroke();
    text("Choisir l'Abscisse (en mv) de départ ", 400, 510);    
    text("pour le tracé de la courbe", 400, 530);
  }
}



//////////////////////////////////////////////
void screenCurve() {

  background(255);

  drawFrame(20);  // 20 = space between

  drawCurve(startValue, 20); // 20 = space between
}


//////////////////////////////////////////////
void screenComm() {

   
  cp5.get(Textarea.class, "Température").moveTo("Communication");
  fill(255, 255, 0);
  textSize(15);
  text ("Température Reçue", 170, 195);
  
  // affichage de la température
  celsius.clear();
  celsius.append(" "+ trameT);  

}

//////////////////////////////////////////////
void screenSimu() {
  
  // order matters
  cp5.get(Textarea.class, "adcValue").moveTo("Simulation");
  cp5.get(Textarea.class, "Température").moveTo("Simulation");
 
  fill(255, 255, 0);
  textSize(15);
  text ("CAN", 180, 175);  
  text ("Température", 320, 175);
  
  String s = Integer.toBinaryString(adc);
  s = "00000000000"+s;
  s = s.substring(s.length()-10);

  // affichage de la sortie du CAN
  adcValue.clear();
  adcValue.append(s);

  // affichage de la tension
  tension_mv.clear();
  tension_mv.append(" "+ Integer.toString(floor(tension)));
  
   // affichage de la tension
  celsius.clear();
  celsius.append(" "+ Float.toString(Math.round((tension/coefficient) * 100.0) / 100.0));  
  
  fill(255, 255, 0);
  textSize(15);
  text ("Pour simuler régler ces valeurs : ", 170, 400);
  text ("quantum et coefficient du capteur", 170, 420);

}

///
color getCol(int adc, int i) {
  if ((adc >> i & 1) == 1) {
    return col[i];
  }
  return color(150);
}

void placeItem() {

  cp5.get(Numberbox.class, "startValue(mV)").moveTo("default"); 
  //cp5.get(Textfield.class, "Valeur décimale ?").moveTo("default");
  cp5.get(Textarea.class, "adcValue").moveTo("default");
  cp5.get(Textarea.class, "Tension").moveTo("default");
  cp5.get(Button.class, "Plus").moveTo("default");
  cp5.get(Button.class, "Moins").moveTo("default");
  cp5.get(Button.class, "RAZ").moveTo("default");
  for (int i=0; i<10; i++) {
    togl[i].moveTo("default");
  }

  cp5.get(Textarea.class, "debug").moveTo("Communication");
  cp5.get(ScrollableList.class, "Choisir Port Serie").moveTo("Communication");
  cp5.get(Button.class, "OuvrirPortSerie").moveTo("Communication");
  cp5.get(Button.class, "FermerPortSerie").moveTo("Communication");

  cp5.get(Numberbox.class, "coefficient en mv").moveTo("Simulation"); 
  cp5.get(Numberbox.class, "quantum (mv)").moveTo("Simulation"); 
  cp5.get(Textarea.class, "Température").moveTo("Simulation");
  cp5.get(Slider.class, "Tension (milliV)").moveTo("Simulation");
}


void razBits () {
  for (int i=0; i<10; i++) {
    togl[i].setValue(false);
    //println("--"+togl[i].getValue()+"  "+tension);
  }
}


//void setFieldVisible(boolean f) {

//  cp5.get(Slider.class, "Tension (milliV)").setVisible(f);
//  cp5.get(Textarea.class, "debug").setVisible(f);
//  cp5.get(Textarea.class, "adcValue").setVisible(f);
//  cp5.get(Textarea.class, "tension (mV)").setVisible(f);
//  cp5.get(Button.class, "Plus").setVisible(f);
//  cp5.get(Button.class, "Moins").setVisible(f);
//  cp5.get(Button.class, "RAZ").setVisible(f);
//  cp5.get(Numberbox.class, "quantum (mv)").setVisible(f); 
//  cp5.get(Numberbox.class, "startValue(mV)").setVisible(f); 
//  cp5.get(Textfield.class, "Valeur décimale ?").setVisible(f);
//  cp5.get(ScrollableList.class, "Choisir Port Serie").setVisible(f);
//  cp5.get(Button.class, "OuvrirPortSerie").setVisible(f);
//  cp5.get(Button.class, "FermerPortSerie").setVisible(f);
//  for (int i=0; i<10; i++) {
//    togl[i].setVisible(f);
//  }
//}
