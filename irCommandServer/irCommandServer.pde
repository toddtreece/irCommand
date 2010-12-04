//  _       _____                                          _ 
// (_)     / ____|                                        | |
//  _ _ __| |     ___  _ __ ___  _ __ ___   __ _ _ __   __| |
// | | '__| |    / _ \| '_ ` _ \| '_ ` _ \ / _` | '_ \ / _` |
// | | |  | |___| (_) | | | | | | | | | | | (_| | | | | (_| |
// |_|_|   \_____\___/|_| |_| |_|_| |_| |_|\__,_|_| |_|\__,_|
// 
// irCommandServer
// Copyright 2010 Todd Treece
// http://unionbridge.org/design/ircommand
// 
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
// 
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.


#include <IRremote.h>
#include <NewSoftSerial.h>
#include <AF_XPort.h>
#include <string.h>
#include <EEPROM.h>
#include <avr/pgmspace.h>
#include <WString.h>

#define XPORT_RX        9
#define XPORT_TX        8
#define XPORT_RESET     4
#define XPORT_CTS       6
#define XPORT_RTS       0
#define XPORT_DTR       0
AF_XPort xport = AF_XPort(XPORT_RX, XPORT_TX, XPORT_RESET, XPORT_DTR, XPORT_RTS, XPORT_CTS);

const char http_404header[] PROGMEM = "HTTP/1.1 404 Not Found\nServer: arduino\nContent-Type: text/html\n\n<html><head><title>404</title></head><body><h1>404: Sorry, that page cannot be found!</h1></body>";
const char http_header[] PROGMEM = "HTTP/1.0 200 OK\nServer: arduino\nContent-Type: text/html\n\n";
String sendstring = String(30);

IRsend irsend;
char linebuffer[128];
unsigned int rawCodes[RAWBUF]; 
int codeLen; 
int lastButtonState;
void setup() {
  xport.begin(9600);
  xport.reset();
  Serial.begin(9600);
}



void sendCode() {
    irsend.sendRaw(rawCodes, codeLen, 38);
    Serial.println("Sent raw");
}

void setSendCode(){
  Serial.println(sendstring);
  if(sendstring.equals("volumeup")){
      for (int i = 0; i < 35; i++) {
        irsend.sendSony(0x240C, 15);
        delay(40);
      } 
  } else if(sendstring.equals("volumedown")){
      for (int i = 0; i < 35; i++) {
        irsend.sendSony(0x640C, 15);
        delay(40);
      } 
  } else if(sendstring.equals("mute")){
      for (int i = 0; i < 3; i++) {
        irsend.sendSony(0x140C, 15);
        delay(40);
      } 
  } else if(sendstring.equals("bed_power")){
      irsend.sendSharp(0x41A2, 15);
  } else if(sendstring.equals("bed_1")){
      irsend.sendSharp(0x4202, 15);
  } else if(sendstring.equals("bed_2")){
      irsend.sendSharp(0x4102, 15);
  } else if(sendstring.equals("bed_3")){
      irsend.sendSharp(0x4302, 15);
  } else if(sendstring.equals("bed_4")){
      irsend.sendSharp(0x4082, 15);
  } else if(sendstring.equals("bed_5")){
      irsend.sendSharp(0x4282, 15);
  } else if(sendstring.equals("bed_6")){
      irsend.sendSharp(0x4182, 15);
  } else if(sendstring.equals("bed_7")){
      irsend.sendSharp(0x4382, 15);
  } else if(sendstring.equals("bed_8")){
      irsend.sendSharp(0x4042, 15);
  } else if(sendstring.equals("bed_9")){
      irsend.sendSharp(0x4242, 15);
  } else if(sendstring.equals("bed_0")){
      irsend.sendSharp(0x4142, 15);
  } else if(sendstring.equals("bed_mute")){
      irsend.sendSharp(0x43A2, 15);
  } else if(sendstring.equals("bed_volup")){
      irsend.sendSharp(0x40A2, 15);
  } else if(sendstring.equals("bed_voldown")){
      irsend.sendSharp(0x42A2, 15);
  } else if(sendstring.equals("bed_tvsource")){
      for (int i = 0; i < 2; i++) {
        irsend.sendSharp(0x4322, 15);
        delay(1000);
      } 
  } else if(sendstring.equals("bed_compsource")){
      for (int i = 0; i < 5; i++) {
        irsend.sendSharp(0x4322, 15);
        delay(1000);;
      } 
  } else if(sendstring.equals("appletv_source")){
      for (int i = 0; i < 3; i++) {
        irsend.sendSony(0x3C0C, 15);
        delay(40);
      } 
  } else if(sendstring.equals("tv_source")){
      for (int i = 0; i < 3; i++) {
        irsend.sendSony(0x5F0C, 15);
        delay(40);
      } 
  } else if(sendstring.equals("poweron")) { 
      irsend.sendNEC(0xC1AA09F6,32);
      delay(100);
      for (int i = 0; i < 3; i++) {
        irsend.sendSony(0x540C, 15);
        delay(40);
      }
      delay(100);
      codeLen = 35;
      rawCodes[0] = 8950;
      rawCodes[1] = 4600;
      rawCodes[2] = 450;
      rawCodes[3] = 2300;
      rawCodes[4] = 400;
      rawCodes[5] = 4650;
      rawCodes[6] = 450;
      rawCodes[7] = 2300;
      rawCodes[8] = 400;
      rawCodes[9] = 4650;
      rawCodes[10] = 400;
      rawCodes[11] = 2300;
      rawCodes[12] = 450;
      rawCodes[13] = 2300;
      rawCodes[14] = 450;
      rawCodes[15] = 2300;
      rawCodes[16] = 450;
      rawCodes[17] = 2300;
      rawCodes[18] = 450;
      rawCodes[19] = 2300;
      rawCodes[20] = 400;
      rawCodes[21] = 2300;
      rawCodes[22] = 450;
      rawCodes[23] = 2300;
      rawCodes[24] = 450;
      rawCodes[25] = 2300;
      rawCodes[26] = 450;
      rawCodes[27] = 2300;
      rawCodes[28] = 400;
      rawCodes[29] = 4650;
      rawCodes[30] = 400;
      rawCodes[31] = 4650;
      rawCodes[32] = 450;
      rawCodes[33] = 2300;
      rawCodes[34] = 400;
       sendCode();  
 } else if(sendstring.equals("poweroff")){
      irsend.sendNEC(0xC1AA8976,32);
      delay(100);
      for (int i = 0; i < 3; i++) {
        irsend.sendSony(0x540C, 15);
        delay(40);
      }
      delay(100);
      codeLen = 35;
      rawCodes[0] = 8950;
      rawCodes[1] = 4600;
      rawCodes[2] = 450;
      rawCodes[3] = 2300;
      rawCodes[4] = 400;
      rawCodes[5] = 4650;
      rawCodes[6] = 450;
      rawCodes[7] = 2300;
      rawCodes[8] = 400;
      rawCodes[9] = 4650;
      rawCodes[10] = 400;
      rawCodes[11] = 2300;
      rawCodes[12] = 450;
      rawCodes[13] = 2300;
      rawCodes[14] = 450;
      rawCodes[15] = 2300;
      rawCodes[16] = 450;
      rawCodes[17] = 2300;
      rawCodes[18] = 450;
      rawCodes[19] = 2300;
      rawCodes[20] = 400;
      rawCodes[21] = 2300;
      rawCodes[22] = 450;
      rawCodes[23] = 2300;
      rawCodes[24] = 450;
      rawCodes[25] = 2300;
      rawCodes[26] = 450;
      rawCodes[27] = 2300;
      rawCodes[28] = 400;
      rawCodes[29] = 4650;
      rawCodes[30] = 400;
      rawCodes[31] = 4650;
      rawCodes[32] = 450;
      rawCodes[33] = 2300;
      rawCodes[34] = 400;
      sendCode(); 
 } else if(sendstring.equals("1")) { 
        codeLen = 35;
        rawCodes[0] = 8900;
        rawCodes[1] = 4650;
        rawCodes[2] = 400;
        rawCodes[3] = 4650;
        rawCodes[4] = 400;
        rawCodes[5] = 2300;
        rawCodes[6] = 450;
        rawCodes[7] = 2300;
        rawCodes[8] = 450;
        rawCodes[9] = 2300;
        rawCodes[10] = 450;
        rawCodes[11] = 2300;
        rawCodes[12] = 400;
        rawCodes[13] = 2300;
        rawCodes[14] = 450;
        rawCodes[15] = 2300;
        rawCodes[16] = 450;
        rawCodes[17] = 2300;
        rawCodes[18] = 450;
        rawCodes[19] = 2300;
        rawCodes[20] = 400;
        rawCodes[21] = 2300;
        rawCodes[22] = 450;
        rawCodes[23] = 2300;
        rawCodes[24] = 450;
        rawCodes[25] = 2300;
        rawCodes[26] = 450;
        rawCodes[27] = 4600;
        rawCodes[28] = 450;
        rawCodes[29] = 4600;
        rawCodes[30] = 450;
        rawCodes[31] = 4600;
        rawCodes[32] = 450;
        rawCodes[33] = 4600;
        rawCodes[34] = 450;
        sendCode();  
    } else if(sendstring.equals("2")) { 
        codeLen = 35;
        rawCodes[0] = 8900;
        rawCodes[1] = 4650;
        rawCodes[2] = 400;
        rawCodes[3] = 2300;
        rawCodes[4] = 450;
        rawCodes[5] = 4600;
        rawCodes[6] = 450;
        rawCodes[7] = 2300;
        rawCodes[8] = 450;
        rawCodes[9] = 2300;
        rawCodes[10] = 450;
        rawCodes[11] = 2300;
        rawCodes[12] = 400;
        rawCodes[13] = 2300;
        rawCodes[14] = 450;
        rawCodes[15] = 2300;
        rawCodes[16] = 450;
        rawCodes[17] = 2300;
        rawCodes[18] = 450;
        rawCodes[19] = 2300;
        rawCodes[20] = 400;
        rawCodes[21] = 2300;
        rawCodes[22] = 450;
        rawCodes[23] = 2300;
        rawCodes[24] = 450;
        rawCodes[25] = 2300;
        rawCodes[26] = 450;
        rawCodes[27] = 2300;
        rawCodes[28] = 450;
        rawCodes[29] = 4600;
        rawCodes[30] = 450;
        rawCodes[31] = 4600;
        rawCodes[32] = 450;
        rawCodes[33] = 4600;
        rawCodes[34] = 450;
        sendCode();
      } else if(sendstring.equals("3")) { 
        codeLen = 35;
          rawCodes[0] = 8900;
          rawCodes[1] = 4650;
          rawCodes[2] = 400;
          rawCodes[3] = 4650;
          rawCodes[4] = 450;
          rawCodes[5] = 4600;
          rawCodes[6] = 450;
          rawCodes[7] = 2250;
          rawCodes[8] = 450;
          rawCodes[9] = 2300;
          rawCodes[10] = 400;
          rawCodes[11] = 2350;
          rawCodes[12] = 400;
          rawCodes[13] = 2350;
          rawCodes[14] = 400;
          rawCodes[15] = 2350;
          rawCodes[16] = 400;
          rawCodes[17] = 2300;
          rawCodes[18] = 450;
          rawCodes[19] = 2300;
          rawCodes[20] = 400;
          rawCodes[21] = 2350;
          rawCodes[22] = 400;
          rawCodes[23] = 2350;
          rawCodes[24] = 400;
          rawCodes[25] = 2350;
          rawCodes[26] = 400;
          rawCodes[27] = 4650;
          rawCodes[28] = 400;
          rawCodes[29] = 2300;
          rawCodes[30] = 450;
          rawCodes[31] = 4600;
          rawCodes[32] = 450;
          rawCodes[33] = 4600;
          rawCodes[34] = 450;
          sendCode();
      } else if(sendstring.equals("4")) { 
        codeLen = 35;
        rawCodes[0] = 8900;
        rawCodes[1] = 4600;
        rawCodes[2] = 450;
        rawCodes[3] = 2300;
        rawCodes[4] = 450;
        rawCodes[5] = 2300;
        rawCodes[6] = 400;
        rawCodes[7] = 4650;
        rawCodes[8] = 400;
        rawCodes[9] = 2350;
        rawCodes[10] = 400;
        rawCodes[11] = 2300;
        rawCodes[12] = 450;
        rawCodes[13] = 2300;
        rawCodes[14] = 450;
        rawCodes[15] = 2300;
        rawCodes[16] = 450;
        rawCodes[17] = 2250;
        rawCodes[18] = 450;
        rawCodes[19] = 2300;
        rawCodes[20] = 450;
        rawCodes[21] = 2300;
        rawCodes[22] = 450;
        rawCodes[23] = 2300;
        rawCodes[24] = 450;
        rawCodes[25] = 2300;
        rawCodes[26] = 400;
        rawCodes[27] = 2300;
        rawCodes[28] = 450;
        rawCodes[29] = 2300;
        rawCodes[30] = 450;
        rawCodes[31] = 4600;
        rawCodes[32] = 450;
        rawCodes[33] = 4600;
        rawCodes[34] = 450;
        sendCode();
      } else if(sendstring.equals("5")) { 
        codeLen = 35;
        rawCodes[0] = 8900;
        rawCodes[1] = 4650;
        rawCodes[2] = 400;
        rawCodes[3] = 4650;
        rawCodes[4] = 400;
        rawCodes[5] = 2300;
        rawCodes[6] = 450;
        rawCodes[7] = 4600;
        rawCodes[8] = 450;
        rawCodes[9] = 2300;
        rawCodes[10] = 400;
        rawCodes[11] = 2350;
        rawCodes[12] = 400;
        rawCodes[13] = 2350;
        rawCodes[14] = 400;
        rawCodes[15] = 2300;
        rawCodes[16] = 450;
        rawCodes[17] = 2300;
        rawCodes[18] = 400;
        rawCodes[19] = 2350;
        rawCodes[20] = 400;
        rawCodes[21] = 2350;
        rawCodes[22] = 400;
        rawCodes[23] = 2350;
        rawCodes[24] = 400;
        rawCodes[25] = 2300;
        rawCodes[26] = 450;
        rawCodes[27] = 4600;
        rawCodes[28] = 450;
        rawCodes[29] = 4600;
        rawCodes[30] = 450;
        rawCodes[31] = 2300;
        rawCodes[32] = 400;
        rawCodes[33] = 4650;
        rawCodes[34] = 400;
        sendCode();
      } else if(sendstring.equals("6")) { 
        codeLen = 35;
        rawCodes[0] = 8900;
        rawCodes[1] = 4650;
        rawCodes[2] = 400;
        rawCodes[3] = 2300;
        rawCodes[4] = 450;
        rawCodes[5] = 4600;
        rawCodes[6] = 450;
        rawCodes[7] = 4600;
        rawCodes[8] = 450;
        rawCodes[9] = 2300;
        rawCodes[10] = 450;
        rawCodes[11] = 2300;
        rawCodes[12] = 450;
        rawCodes[13] = 2300;
        rawCodes[14] = 450;
        rawCodes[15] = 2300;
        rawCodes[16] = 400;
        rawCodes[17] = 2300;
        rawCodes[18] = 450;
        rawCodes[19] = 2300;
        rawCodes[20] = 450;
        rawCodes[21] = 2300;
        rawCodes[22] = 450;
        rawCodes[23] = 2300;
        rawCodes[24] = 400;
        rawCodes[25] = 2300;
        rawCodes[26] = 450;
        rawCodes[27] = 2300;
        rawCodes[28] = 450;
        rawCodes[29] = 4600;
        rawCodes[30] = 450;
        rawCodes[31] = 2300;
        rawCodes[32] = 450;
        rawCodes[33] = 4600;
        rawCodes[34] = 450;
       sendCode();
      } else if(sendstring.equals("7")) { 
      codeLen = 35;
      rawCodes[0] = 8900;
      rawCodes[1] = 4650;
      rawCodes[2] = 450;
      rawCodes[3] = 4600;
      rawCodes[4] = 450;
      rawCodes[5] = 4600;
      rawCodes[6] = 450;
      rawCodes[7] = 4600;
      rawCodes[8] = 450;
      rawCodes[9] = 2300;
      rawCodes[10] = 400;
      rawCodes[11] = 2350;
      rawCodes[12] = 400;
      rawCodes[13] = 2300;
      rawCodes[14] = 450;
      rawCodes[15] = 2300;
      rawCodes[16] = 450;
      rawCodes[17] = 2300;
      rawCodes[18] = 450;
      rawCodes[19] = 2300;
      rawCodes[20] = 400;
      rawCodes[21] = 2300;
      rawCodes[22] = 450;
      rawCodes[23] = 2300;
      rawCodes[24] = 450;
      rawCodes[25] = 2300;
      rawCodes[26] = 450;
      rawCodes[27] = 4600;
      rawCodes[28] = 450;
      rawCodes[29] = 2300;
      rawCodes[30] = 400;
      rawCodes[31] = 2300;
      rawCodes[32] = 450;
      rawCodes[33] = 4600;
      rawCodes[34] = 450;
      sendCode();
      } else if(sendstring.equals("8")) {
      codeLen = 35;
      rawCodes[0] = 8900;
      rawCodes[1] = 4650;
      rawCodes[2] = 450;
      rawCodes[3] = 2300;
      rawCodes[4] = 400;
      rawCodes[5] = 2300;
      rawCodes[6] = 450;
      rawCodes[7] = 2300;
      rawCodes[8] = 450;
      rawCodes[9] = 4600;
      rawCodes[10] = 450;
      rawCodes[11] = 2300;
      rawCodes[12] = 450;
      rawCodes[13] = 2300;
      rawCodes[14] = 450;
      rawCodes[15] = 2300;
      rawCodes[16] = 400;
      rawCodes[17] = 2300;
      rawCodes[18] = 450;
      rawCodes[19] = 2300;
      rawCodes[20] = 450;
      rawCodes[21] = 2300;
      rawCodes[22] = 400;
      rawCodes[23] = 2300;
      rawCodes[24] = 450;
      rawCodes[25] = 2300;
      rawCodes[26] = 450;
      rawCodes[27] = 2300;
      rawCodes[28] = 450;
      rawCodes[29] = 2300;
      rawCodes[30] = 450;
      rawCodes[31] = 2300;
      rawCodes[32] = 400;
      rawCodes[33] = 4650;
      rawCodes[34] = 400;      
      sendCode();
      } else if(sendstring.equals("9")) {
      codeLen = 35;
      rawCodes[0] = 8900;
      rawCodes[1] = 4600;
      rawCodes[2] = 450;
      rawCodes[3] = 4600;
      rawCodes[4] = 450;
      rawCodes[5] = 2300;
      rawCodes[6] = 450;
      rawCodes[7] = 2300;
      rawCodes[8] = 450;
      rawCodes[9] = 4600;
      rawCodes[10] = 450;
      rawCodes[11] = 2300;
      rawCodes[12] = 450;
      rawCodes[13] = 2300;
      rawCodes[14] = 400;
      rawCodes[15] = 2300;
      rawCodes[16] = 450;
      rawCodes[17] = 2300;
      rawCodes[18] = 450;
      rawCodes[19] = 2300;
      rawCodes[20] = 450;
      rawCodes[21] = 2300;
      rawCodes[22] = 400;
      rawCodes[23] = 2300;
      rawCodes[24] = 450;
      rawCodes[25] = 2300;
      rawCodes[26] = 450;
      rawCodes[27] = 4600;
      rawCodes[28] = 450;
      rawCodes[29] = 4600;
      rawCodes[30] = 450;
      rawCodes[31] = 4600;
      rawCodes[32] = 450;
      rawCodes[33] = 2300;
      rawCodes[34] = 450;    
      sendCode();
      } else if(sendstring.equals("0")) {
      codeLen = 35;
      rawCodes[0] = 8900;
      rawCodes[1] = 4650;
      rawCodes[2] = 400;
      rawCodes[3] = 2300;
      rawCodes[4] = 450;
      rawCodes[5] = 2300;
      rawCodes[6] = 450;
      rawCodes[7] = 2300;
      rawCodes[8] = 450;
      rawCodes[9] = 2300;
      rawCodes[10] = 400;
      rawCodes[11] = 2300;
      rawCodes[12] = 450;
      rawCodes[13] = 2300;
      rawCodes[14] = 450;
      rawCodes[15] = 2300;
      rawCodes[16] = 450;
      rawCodes[17] = 2300;
      rawCodes[18] = 450;
      rawCodes[19] = 2250;
      rawCodes[20] = 450;
      rawCodes[21] = 2300;
      rawCodes[22] = 450;
      rawCodes[23] = 2300;
      rawCodes[24] = 450;
      rawCodes[25] = 2300;
      rawCodes[26] = 450;
      rawCodes[27] = 2300;
      rawCodes[28] = 400;
      rawCodes[29] = 2300;
      rawCodes[30] = 450;
      rawCodes[31] = 2300;
      rawCodes[32] = 450;
      rawCodes[33] = 2300;
      rawCodes[34] = 450;    
      sendCode();
    }
}

uint16_t requested(void) {
  uint8_t read, x;
  char *found;
  while (1) {
    read = xport.readline_timeout(linebuffer, 128, 200);

    if (read == 0)
      return 0;
    if (read)
       Serial.println(linebuffer);

   if (strstr(linebuffer, "GET / ")) {
      return 200;
    }
   if (strstr(linebuffer, "GET /?")) { 
      return 200;
   }
   if(strstr(linebuffer, "GET ")) {
      return 404;
   }
  }
}

void processData(void) {
    char *found=0;
    char *found2=0;
    // Look for a ? style GET command    
    found = strstr(linebuffer, "?command=");
    if (found) {
      Serial.println("received command");
      found += 9;
      char *tosend = strtok(found, " ");
      sendstring = tosend;
      setSendCode();

    }
    found2 = strstr(linebuffer, "?channel=");
    if (found2) {

      Serial.println("received command");
      found2 += 9;
      char *tosend = strtok(found2, " ");
      String presendstring = String(3);
      presendstring.append(tosend);
      sendstring = presendstring.substring(0,1);

      setSendCode();
      delay(50);
      sendstring = presendstring.substring(1,2);
      setSendCode();
      delay(50);
      sendstring = presendstring.substring(2,3);
      setSendCode();      
    }
    found2 = strstr(linebuffer, "?bed_channel=");
    if (found2) {

      Serial.println("received command");
      found2 += 13;
      char *tosend = strtok(found2, " ");
      String presendstring = String(3);
      presendstring.append(tosend);
      String channel = String(1);
      channel = presendstring.substring(0,1);
      sendstring = "bed_";
      sendstring.append(channel);
      setSendCode();
      delay(50);
      channel = presendstring.substring(1,2);
      sendstring = "bed_";
      sendstring.append(channel);
      setSendCode();
      delay(50);
      channel = presendstring.substring(2,3);
      sendstring = "bed_";
      sendstring.append(channel);
      setSendCode();      
    }
}

void loop() {
  uint16_t ret;
  ret = requested();
  if (ret == 404) {
     xport.flush(250);

     xport.ROM_print(http_404header);    
     xport.disconnect();
  } else if (ret == 200) {
    processData();
    respond();

    delay(1000);
    pinMode(XPORT_RESET, HIGH);
    delay(50); 
    pinMode(XPORT_RESET, LOW);
    
  }
  
}

void respond(){
  uint8_t temp;
  xport.flush(50);
  xport.ROM_print(http_header);
  xport.flush(255);
  xport.disconnect();
}
