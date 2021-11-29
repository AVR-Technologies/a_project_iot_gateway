#include <Wire.h>
const byte i2cAddress = 8;
const byte inputPins[4] = {12, A1, A2, A3};
const byte outputPins[4] = {8, 9, 10, 11};
const byte analogPin = A0;

byte outputStatus[4] = {0, 0, 0, 0};
struct Input {
  byte digital[4] = {0, 0, 0, 0};
  float analog = 0.0;
} input;

void setup() {
  Serial.begin(115200);
  Serial.println(F("booting controller"));

  Wire.begin(i2cAddress);
  Wire.onReceive(receiveEvent);
  Wire.onRequest(requestEvent);

  Serial.print("input digital pins:");
  for (byte pin : inputPins) Serial.print('\t'), Serial.print(pin);
  Serial.println();

  Serial.print("input analog pin:\t");
  Serial.println(analogPin);

  Serial.print("output pins:");
  for (byte pin : outputPins) Serial.print('\t'), Serial.print(pin);
  Serial.println();
  Serial.println();

  for (byte pin : inputPins) pinMode(pin, INPUT);
  for (byte pin : outputPins) pinMode(pin, OUTPUT);

  for (byte pin : outputPins) digitalWrite(pin, LOW);
}

void loop() {
  for (byte i = 0; i < 4; i++) input.digital[i] = digitalRead(inputPins[i]);
  input.analog = analogRead(analogPin);

  Serial.print("input digital status: ");
  for (byte _status : input.digital) Serial.print('\t'), Serial.print(_status);
  Serial.println();

  Serial.print("input analog status: ");
  Serial.println(input.analog);

  Serial.print("output status: ");
  for (byte _status : outputStatus) Serial.print('\t'), Serial.print(_status);
  Serial.println();
  Serial.println();

  delay(1000);
}

void receiveEvent(int _length) {
  if (_length == 4) {
    Wire.readBytes(outputStatus, _length);
    for (byte i = 0; i < 4; i++) digitalWrite(outputPins[i], outputStatus[i]);
  }
  else {
    char _buff[_length];
    Wire.readBytes(_buff, _length);
    Serial.println(_buff);
  }
}

void requestEvent() {
  Wire.write((byte*)&input, sizeof(Input));
}
