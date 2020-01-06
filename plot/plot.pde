import controlP5.*;

ControlP5 cp5;

// debug trace
Textarea tDebug, adcValue, tension_mV;

Serial myPort;        // The serial port
int yPos = 1;
int xPos=1;

final byte  SCREEN_1 =1;
final byte  SCREEN_2 =2;
final byte  SCREEN_3 =3;

color[] col={#FA5858, #FE9A2E, #F7FE2E, #2EFE2E, #F2F5A9, #58FAD0, #CC2EFA, #FE2E9A, 150, 150, 150};

int startValue;  // N de départ pour la courbe

float LSB=0.0;
int adc =128+32+8+4+1;
boolean adcOK=false;
String trameN="0", trameV="0";
float tension=0.0;

int machineState=SCREEN_1;

void setup () {
  // set the window size:
  size(600, 600);

  frameRate(10);
  // initialisation de la bibliotheque controlP5
  cp5 = new ControlP5(this);
  // on bloque temporairement les événements pendant la création des widgets 
  // cp5.setBroadcast(false);
  PFont font = createFont("arial", 15);

  initIHMSerie();

  tDebug = cp5.addTextarea("debug")
    .setPosition(10, height-40)
    .setSize(580, 40)
    .setFont(createFont("arial", 12))
    .setLineHeight(14)
    .setColor(color(128))
    .setColorBackground(color(255, 100))
    .setColorForeground(color(255, 100));
  ;

  adcValue = cp5.addTextarea("adcValue")
    .setPosition(160, 180)
    .setSize(100, 20)
    .setFont(createFont("arial", 12))
    .setLineHeight(14)
    .setColor(color(128))
    .setColorBackground(color(255, 100))
    .setTitle("ADC")
    .setColorForeground(color(255, 100));
  ;
  adcValue.setText("ADC  ");

  tension_mV = cp5.addTextarea("tension (mV)")
    .setPosition(30, 180)
    .setSize(100, 20)
    .setFont(createFont("arial", 12))
    .setLineHeight(14)
    .setColor(color(128))
    .setColorBackground(color(255, 100))
    .setTitle("TENSION")
    .setColorForeground(color(255, 100));
  ;
  adcValue.setText("Tension");


  // parameters  : name, value (float), x, y, width, height
  cp5.addButton("Plus", 1, 350, 180, 60, 20);
  cp5.addButton("RAZ", 1, 350, 210, 60, 20);
  cp5.addButton("Moins", 1, 350, 240, 60, 20);

  // description : a bang controller triggers an event when pressed. 
  // parameters  : name, x, y, width, height
  cp5.addBang("courbe", 450, 500, 20, 20);

  // description : box that displays a number. You can change the value by 
  //               click and hold in the box and drag the mouse up and down.
  // parameters : name, default value (float), x, y,  width, height
  //cp5.addNumberbox("startValue",200,450,450,60,14);
  cp5.addNumberbox("startValue(mV)")
    .setPosition(450, 450)
    .setSize(50, 20)
    .setRange(0, 450)
    .setMultiplier(10) // set the sensitifity of the numberbox
    .setDirection(Controller.HORIZONTAL) // change the control direction to left/right
    .setValue(0)
    ;

  // parameters  : name, minimum, maximum, default value (float), x, y, width, height
  cp5.addSlider("Tension (milliV)", 0, 500, 128, 430, 160, 30, 100);

  // parameters : name, default value (float), x, y,  width, height
  //cp5.addNumberbox("lsb",50,170,120,60,14);

  cp5.addNumberbox("quantum (mv)")
    .setPosition(350, 300)
    .setSize(50, 20)
    .setRange(0, 200)
    .setMultiplier(0.01) // set the sensitifity of the numberbox
    .setDirection(Controller.HORIZONTAL) // change the control direction to left/right
    .setValue(5)
    ;


  cp5.addTextfield("Valeur tension (mV) ?")
    .setPosition(40, 300)
    .setSize(200, 40)
    .setFont(font)
    .setFocus(true)
    .setColor(color(255, 0, 0))
    ;

  // les widgets sont tous créés, on réactive les événements
  cp5.setBroadcast(true);
  textFont(font);
}


void draw () {

  background(0);
  switch (machineState) {
  case SCREEN_1 :
    screenOne();
    break;
  case SCREEN_2 :
    screenSecond();
    break;
  case SCREEN_3 :
    break;
  }



  //// draw the line:
  //stroke(127, 34, 255);
  //line(xPos, height, xPos, height - yPos);

  //// at the edge of the screen, go back to the beginning:
  //if (xPos >= width) {
  //  xPos = 0;
  //  background(0);
  //} else {
  //  // increment the horizontal position:
  //  //xPos++;
  //}
}


void controlEvent(ControlEvent theEvent) {
  /* events triggered by controllers are automatically forwarded to 
   the controlEvent method. by checking the name of a controller one can 
   distinguish which of the controllers has been changed.
   */

  /* check if the event is from a controller otherwise you'll get an error
   when clicking other interface elements like Radiobutton that don't support
   the controller() methods
   */

  if (theEvent.isController()) { 

    //print("control event from : "+theEvent.getController().getName());
    //println(", value : "+theEvent.getController().getValue());

    //if(theEvent.getController().getName()=="bang1") {
    //  colors[0] = colors[0] + color(40,40,0);
    //  if(colors[0]>255) colors[0] = color(40,40,0);    
    //}

    // button
    if (theEvent.getController().getName()=="Plus") {
      if (adc<1024) adc++;
      tension = floor(LSB*adc);
    }

    if (theEvent.getController().getName()=="Moins") {
      if (adc>0) adc--;
      tension = floor(LSB*adc);
    }

    if (theEvent.getController().getName()=="RAZ") {
      adc=0;
      tension = floor(LSB*adc);
    }

    //if (theEvent.getController().getName()=="toggle1") {
    //  if (theEvent.getController().getValue()==1) colors[2] = color(0, 255, 255);
    //  else                                 colors[2] = color(0, 0, 0);
    //}

    if (theEvent.getController().getName()=="courbe") {

      if (machineState==SCREEN_2) {
        machineState=SCREEN_1;
        setFieldVisible(true);
      } else {
        machineState=SCREEN_2;
        setFieldVisible(false);
      }
    }
      // slider 
      if (theEvent.getController().getName()=="Tension (milliV)") {
        tension = theEvent.getController().getValue();
        adc = floor(tension/LSB);
        //println(floor(tension));
      }

      //if (theEvent.getController().getName()=="knob1") {
      //  colors[5] = color(0, 0, theEvent.getController().getValue());
      //}

      // number box
      if (theEvent.getController().getName()=="quantum (mv)") {
        LSB = theEvent.getController().getValue();
      }


      // number box
      if (theEvent.getController().getName()=="startValue(mV)") {
        startValue = floor( (theEvent.getController().getValue()/LSB));
        println(startValue);
      }

      // text field
      if (theEvent.getController().getName()=="Valeur tension (mV) ?") {
        String s = trim(theEvent.getStringValue());
        tension = Integer.parseInt(s);
        adc = int (tension/LSB);
        //println(tension+" "+ adc);
      }
    }
  
  }
