//sketch created by Akshay Joseph
char inputByte;
void setup() {
 Serial.begin(9600);
 pinMode(13,OUTPUT);

}

void loop() {
while(Serial.available()>0){
  inputByte= Serial.read();
  Serial.println(inputByte);
  if (inputByte=='Z'){
  digitalWrite(13,HIGH);
  }
  else if (inputByte=='z'){
  digitalWrite(13,LOW);
  } 
  }
}
