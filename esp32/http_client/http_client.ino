#include "ArduinoJson.h"
#include "HTTPClient.h"
#include "WiFi.h"
#include "Wire.h"
StaticJsonDocument<200> doc;

const char* ssid      = "highspeed";
const char* password  = "highspeed";
const char* server    = "http://192.168.1.26/gateway";
const byte  i2cAddress = 8;

byte outputStatus[4]  = {0, 0, 0, 0};

struct Input {
  byte digital[4] = {0, 0, 0, 0};
  float analog = 0;
} input, old;

void setup() {
  Wire.begin();
  Serial.begin(115200);

  Serial.print("wifi: connecting to ");
  Serial.println(ssid);

  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print(".");
    delay(500);
  }
}

void loop() {
  readServer();
  readController();

  Serial.print("input digital status: ");
  for (byte _status : input.digital) Serial.print('\t'), Serial.print(_status);
  Serial.println();

  Serial.print("input analog status: ");
  Serial.println(input.analog);

  Serial.print("output status: ");
  for (byte _status : outputStatus) Serial.print('\t'), Serial.print(_status);
  Serial.println();
  Serial.println();
}

void readServer() {
  if (WiFi.status() == WL_CONNECTED) {
    char url[100];
    sprintf(url, "%s/esp_read_out/", server);

    HTTPClient http;
    http.begin(url);
    int httpCode = http.GET();

    if (httpCode > 0) {
      if (httpCode == HTTP_CODE_OK) {
        doc.clear();
        if (!deserializeJson(doc, http.getString())) {
          serializeJson(doc, Serial);
          Serial.println();
          outputStatus[0] = doc["out1"];
          outputStatus[1] = doc["out2"];
          outputStatus[2] = doc["out3"];
          outputStatus[3] = doc["out4"];
          writeController();
        } else Serial.println("parse error");
      } else Serial.print("http error: "), Serial.println(httpCode);
    }
    else Serial.printf("[HTTP] GET... failed, error: %s\n", http.errorToString(httpCode).c_str());

    http.end();
  }
}

void writeController() {
  Wire.beginTransmission(i2cAddress);
  Wire.write(outputStatus, 4);
  Wire.endTransmission();
}

void writeServer() {
  if (WiFi.status() == WL_CONNECTED) {
    char str[10];
    dtostrf(input.analog, 1, 4, str);//value, min_width, no. of digits after decimal, char buffer

    char url[100];
    sprintf(url, "%s/esp_update_in/?in1=%d&in2=%d&in3=%d&in4=%d&analog=%s", server, input.digital[0], input.digital[1], input.digital[2], input.digital[3], str);
    
    HTTPClient http;
    http.begin(url);
    int httpCode = http.GET();

    if (httpCode > 0) {
      if (httpCode == HTTP_CODE_OK) {
        doc.clear();
        if (!deserializeJson(doc, http.getString()))
          serializeJson(doc, Serial), Serial.println();
        else Serial.println("parse error");
      } else Serial.print("http error: "), Serial.println(httpCode);
    }
    else Serial.printf("[HTTP] GET... failed, error: %s\n", http.errorToString(httpCode).c_str());

    http.end();
  }
}

void readController() {
  Wire.requestFrom((int)i2cAddress, sizeof(Input));
  if (Wire.available() == sizeof(Input)) Wire.readBytes((byte*)&input, sizeof(Input));
  else if (int _length = Wire.available()) {
    char _buff[_length];
    Wire.readBytes(_buff, _length);
    Serial.println(_buff);
  } else Serial.println("no data available from contoller");
  if (input.digital[0] != old.digital[0] ||
      input.digital[1] != old.digital[1] ||
      input.digital[2] != old.digital[2] ||
      input.digital[3] != old.digital[3] ||
      input.analog != old.analog) {
    writeServer();
    memcpy(&old, &input, sizeof(Input));  //copy input to old
  }
}
