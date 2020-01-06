int canVal;
String Trame = "";
float Tension, Temperature;

void setup() {
  // initialiser liaison série:
  Serial.begin(9600);
}

void loop() {

  canVal = analogRead(A0);

  Tension = canVal * 5.0 / 1023;

  Temperature = Tension * 100;

  for (int i = 0; i < 15; i++) {
    Trame = "$T,"+String(i) + ",9," +String(canVal)+","+String(Tension)+"," +String(Temperature);
    Serial.println(Trame);

    delay(1500) ; // attente 
  }

}
