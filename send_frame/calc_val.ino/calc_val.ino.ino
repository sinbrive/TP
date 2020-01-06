int canVal;
float Tension;

void setup() {
  // initialiser liaison série:
  Serial.begin(9600);
}

void loop() {

   canVal = analogRead(A0);
  
   Tension = canVal * 5.0 /1023;
  
   Serial.println(Tension);
  
   delay(1000) ; // attente d’une seconde

}
