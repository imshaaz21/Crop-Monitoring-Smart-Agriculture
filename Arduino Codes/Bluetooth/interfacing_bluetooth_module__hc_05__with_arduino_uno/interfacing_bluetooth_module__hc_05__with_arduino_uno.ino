#include <SoftwareSerial.h> 
SoftwareSerial MyBlue(10, 11); // RX | TX 
char flag;
void setup() 
{   
  Serial.begin(9600); 
  MyBlue.begin(9600); 
  pinMode(13,OUTPUT);
  Serial.println("Device Connected");
} 
void loop() 
{ 
  digitalWrite(13,LOW);
  if (MyBlue.available()){ 
    flag = MyBlue.read(); 
    Serial.println(flag);
    if(flag == "z"){
      MyBlue.write("FROM");
    }
    MyBlue.print(">");
    MyBlue.println("110");
    MyBlue.print("<");
  }
  delay(20);
} 
