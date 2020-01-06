int canVal;
float Tension;

void setup() {
  // initialiser liaison série:
  Serial.begin(9600);
}

void loop() {

   canVal = analogRead(A0);
  
   Serial.println(canVal, BIN);
  
   delay(1000) ; // attente d’une seconde

}
