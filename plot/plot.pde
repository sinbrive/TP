import controlP5.*;

ControlP5 cp5;

// debug trace
Textarea tDebug, celsius;

Serial myPort;        

boolean trameValide=false;
String trameT="$T, 9, 43, 210, 25.0";

void setup () {
  // set the window size:
  size(600, 600);

  frameRate(7);
  // initialisation de la bibliotheque controlP5
  cp5 = new ControlP5(this);

  PFont font = createFont("arial", 15);

  initIHMSerie();

  tDebug = cp5.addTextarea("debug")
    .setPosition(10, height-40)
    .setSize(580, 40)
    .setFont(createFont("arial", 12))
    .setLineHeight(14)
    .setColor(color(200))
    .setColorBackground(color(255, 100))
    .setColorForeground(color(255, 100))
    ;

  celsius = cp5.addTextarea("Température")
    .setPosition(310, 180)
    .setSize(100, 20)
    .setFont(createFont("arial", 12))
    .setLineHeight(14)
    .setColor(color(255))
    .setColorBackground(color(255, 100))
    .setTitle("Temp")
    .setColorForeground(color(255, 100))
    ;

  textFont(font);
}

String[] data={"","","","","",""};

void draw () {

  int x=170;
  int y =195;
  background(0);
  fill(255, 255, 0);
  textSize(15);
  text ("Température Reçue", x, y);
  text ("Nombre reçu", x, y+30);
  text ("Tension Reçue", x, y+60);

  if (trameValide) {
    data = split(trameT, ',');

    celsius.clear();
    celsius.append(" "+ data[5]);

    trameValide=false;
  }
  afficherNombre(data[3], x+150, y+30);
  afficherTension(data[4], x+150, y+60);
}
