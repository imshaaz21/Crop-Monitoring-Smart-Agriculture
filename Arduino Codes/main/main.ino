#include <SoftwareSerial.h> 
#include <DHT.h>

#define DHTPIN 7     // what pin we're connected to
#define DHTTYPE DHT22

SoftwareSerial MyBlue(10, 11); // RX | TX 
DHT dht(DHTPIN, DHTTYPE);

char flag;
float hum; 
float temp;
float moist;
String data;

void setup() 
{   
  Serial.begin(9600); 
  MyBlue.begin(9600); 
  dht.begin();
  Serial.println("Device Connected");
} 

String send(float temp,float hum,float moist)
{
  String data;
  data = String(temp,4)+" "+String(hum,4)+" "+String(moist,4);
  return data;
}

void loop() 
{ 
//  delay(1000);
  hum = dht.readHumidity();
  temp= dht.readTemperature();
  moist = analogRead(A0);
  Serial.println(temp);
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
//  String data = String(hum,4)+" "+String(temp,4)+" "+String(moist,4);
  MyBlue.println(send(temp,hum,moist));
  delay(1000);
} 
