#include <SoftwareSerial.h>
 
SoftwareSerial BTSerial(10, 11);   // RX | TX
char inputByte; 
void setup()
{
  pinMode(13,OUTPUT);
  Serial.begin(9600);
  Serial.println("Enter AT commands:");
  BTSerial.begin(9600);  // HC-05 default speed in AT command mode
}
 
void loop()
{
  // Read from HC05 and send to Arduino
  if (BTSerial.available()>0){
    Serial.println("READ");
    Serial.write(BTSerial.read());
    inputByte = BTSerial.read();
    
    if (inputByte=='Z'){
      digitalWrite(13,HIGH);
    }
    else if (inputByte=='z'){
      digitalWrite(13,LOW);
    } 
  }
  // Read from serial monitor and send to HC05
  if (Serial.available()>0){
    BTSerial.write(Serial.read());
    Serial.println("WRITE");
  }
}
