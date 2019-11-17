void setup() {
  // initialize the serial communication:
  Serial.begin(9600);
}

void loop() {
  
  //Serial.println(analogRead(A0));
  for (int i=0; i<100; i++) {
    Serial.print("CAN : "); Serial.print(i);Serial.print(":"); 
    Serial.print(" Tension (mV): "); Serial.print(floor(i*4.8));
    Serial.println();
    delay(1000);
  }

}
