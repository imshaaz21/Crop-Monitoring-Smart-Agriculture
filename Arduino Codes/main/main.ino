#include <SoftwareSerial.h> 
#include <DHT.h>

#define DHTPIN 7     // what pin we're connected to
#define DHTTYPE DHT22

SoftwareSerial MyBlue(10, 11); // RX | TX 
DHT dht(DHTPIN, DHTTYPE);

char flag;
float hum; 
float temp;
int moist;
String data;

void setup() 
{   
  Serial.begin(9600); 
  MyBlue.begin(9600); 
  dht.begin();
  Serial.println("Device Connected");
} 
void loop() 
{ 
//  delay(1000);
  hum = dht.readHumidity();
  temp= dht.readTemperature();
  moist = analogRead(A0);
//  data = "{"hum
  if (MyBlue.available()){ 
    flag = MyBlue.read(); 
    Serial.println(flag);
    if(flag == 'h'){
      MyBlue.print("Humidity ");
      MyBlue.println(hum);
    }else if(flag == 't'){
      MyBlue.print("Temperature ");
      MyBlue.println(temp);
    }else if(flag == 'm'){
      MyBlue.print("Soil Mositure ");
      MyBlue.println(moist);
    }
  }
//  MyBlue.println(hum);
  delay(1000);
} 
