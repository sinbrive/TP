import controlP5.*;

ControlP5 cp5;

// debug trace
Textarea tDebug, adcValue, tension_mv, celsius;

Serial myPort;        // The serial port

color[] col= new color[] {#FA5858, #FE9A2E, #F7FE2E, #2EFE2E, #F2F5A9, #58FAD0, #CC2EFA, #FE2E9A, #FE2E00, #FA0058};

int startValue;  // N de départ pour la courbe

float LSB=3.0;
int adc =0;
boolean adcOK=false;
String trameN="0", trameV="0";
float tension=0.0;
float coefficient=10;
float celsius_trame=0;

int machineState=1;

Toggle[] togl = new Toggle[10];

void setup () {
  // set the window size:
  size(600, 600);

  frameRate(7);
  // initialisation de la bibliotheque controlP5
  cp5 = new ControlP5(this);
  // on bloque temporairement les événements pendant la création des widgets 
  //cp5.setBroadcast(false);
  PFont font = createFont("arial", 15);

  initIHMSerie();

  cp5.getTab("default").activateEvent(true).setLabel("Binaire").setId(1).setWidth(width/5).setHeight(20);
  cp5.addTab("Courbe").activateEvent(true).setId(2).setWidth(width/5).setHeight(20);
  cp5.addTab("Communication").activateEvent(true).setId(3).setWidth(width/5).setHeight(20);
  cp5.addTab("Simulation").activateEvent(true).setId(4).setWidth(width/5).setHeight(20);

  tDebug = cp5.addTextarea("debug")
    .setPosition(10, height-40)
    .setSize(580, 40)
    .setFont(createFont("arial", 12))
    .setLineHeight(14)
    .setColor(color(128))
    .setColorBackground(color(255, 100))
    .setColorForeground(color(255, 100))
    ;

  adcValue = cp5.addTextarea("adcValue")
    .setPosition(160, 180)
    .setSize(100, 20)
    .setFont(createFont("arial", 12))
    .setLineHeight(14)
    .setColor(color(255))
    .setColorBackground(color(255, 100))
    .setTitle("ADC")
    .setColorForeground(color(255, 100))
    ;

  tension_mv = cp5.addTextarea("Tension")
    .setPosition(30, 180)
    .setSize(100, 20)
    .setFont(createFont("arial", 12))
    .setLineHeight(14)
    .setColor(color(255))
    .setColorBackground(color(255, 100))
    .setTitle("TENSION")
    .setColorForeground(color(255, 100))
    ;


  celsius = cp5.addTextarea("Température")
    .setPosition(310, 180)
    .setSize(100, 20)
    .setFont(createFont("arial", 12))
    .setLineHeight(14)
    .setColor(color(128))
    .setColorBackground(color(255, 100))
    .setTitle("Temp")
    .setColorForeground(color(255, 100))
    ;


  // parameters  : name, value (float), x, y, width, height
  cp5.addButton("Plus", 1, 350, 180, 60, 20);
  cp5.addButton("RAZ", 1, 350, 210, 60, 20);
  cp5.addButton("Moins", 1, 350, 240, 60, 20);


  cp5.addNumberbox("startValue(mV)")
    .setPosition(450, 450)
    .setSize(50, 20)
    .setRange(0, 450)
    .setMultiplier(10) // set the sensitifity of the numberbox
    .setDirection(Controller.HORIZONTAL) // change the control direction to left/right
    .setValue(0)
    ;

  // parameters  : name, minimum, maximum, default value (float), x, y, width, height
  cp5.addSlider("Tension (milliV)", 0, 500, 150, 80, 145, 30, 100);

  // parameters : name, default value (float), x, y,  width, height
  //cp5.addNumberbox("lsb",50,170,120,60,14);

  cp5.addNumberbox("quantum (mv)")
    .setPosition(180, 340)
    .setSize(50, 20)
    .setRange(0, 200)
    .setMultiplier(0.1) // set the sensitifity of the numberbox
    .setDirection(Controller.HORIZONTAL) // change the control direction to left/right
    .setValue(3)
    ;
    
    
   cp5.addNumberbox("coefficient en mv")
    .setPosition(350, 340)
    .setSize(50, 20)
    .setRange(0, 200)
    .setMultiplier(1) // set the sensitifity of the numberbox
    .setDirection(Controller.HORIZONTAL) // change the control direction to left/right
    .setValue(3)
    ;

  // description : a toggle can have two states, true and false
  // where true has the value 1 and false is 0.
  // parameters : name, default value (boolean), x, y, width, height
  for (int i=0; i<10; i++) {        
    fill(col[i]); 
    togl[i]=cp5.addToggle("   b"+i, false, 10+((10-i)*25), 250, 20, 20).setId(i);
  }

  // attribuer des objets aux onglets
  placeItem();

  textFont(font);

  // les widgets sont tous créés, on réactive les événements
  // cp5.setBroadcast(true);
}


void draw () {

  background(0);

  switch(machineState) {
  case 1: 
    screenBinary(); 
    break; 
  case 2: 
    screenCurve(); 
    break;
  case 3: 
    screenComm(); 
    break;       
  case 4: 
    screenSimu(); 
    break; 
  default:
  }
}
