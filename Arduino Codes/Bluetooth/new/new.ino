#include <SoftwareSerial.h>

SoftwareSerial bluetooth(10, 11); //RX, TX
int input = 10;
void setup() 
{
  Serial.begin(9600);
  bluetooth.begin(9600);
}

void loop() 
{

  bluetooth.print(input);
  bluetooth.print(";");
  Serial.println(input+10);
  delay(1);
}
