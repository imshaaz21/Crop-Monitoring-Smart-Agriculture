const int Pin=0;
const int limit=480;


void setup() {
  Serial.begin(9600);
  pinMode(13,OUTPUT);
  
  // put your setup code here, to run once:

}

void loop() {
  int value;
  value=analogRead(Pin);
  Serial.println("analog value:");
  Serial.println(value);
  delay(1000);
  if (value<limit)
  {
    digitalWrite(13,HIGH);
  }
  else
  {
    digitalWrite(13,LOW);
  }
  // put your main code here, to run repeatedly:

}
