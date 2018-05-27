#line 1 "C:/Users/Santosh/Desktop/Ethernet Demo/Ethernet_Demo.c"
#line 1 "c:/users/santosh/desktop/ethernet demo/__ethernet_intern.h"
#line 37 "c:/users/santosh/desktop/ethernet demo/__ethernet_intern.h"
typedef struct {
 unsigned char valid;
 unsigned long tmr;
 unsigned char ip[4];
 unsigned char mac[6];
} Ethernet_Intern_arpCacheStruct;

extern Ethernet_Intern_arpCacheStruct Ethernet_Intern_arpCache[];

extern unsigned char Ethernet_Intern_macAddr[6];
extern unsigned char Ethernet_Intern_ipAddr[4];
extern unsigned char Ethernet_Intern_gwIpAddr[4];
extern unsigned char Ethernet_Intern_ipMask[4];
extern unsigned char Ethernet_Intern_dnsIpAddr[4];
extern unsigned char Ethernet_Intern_rmtIpAddr[4];

extern unsigned long Ethernet_Intern_userTimerSec;

typedef struct {
 unsigned canCloseTCP : 1;
 unsigned isBroadcast : 1;
} TEthInternPktFlags;
#line 63 "c:/users/santosh/desktop/ethernet demo/__ethernet_intern.h"
extern unsigned char Ethernet_Intern_doPacket();
extern void Ethernet_Intern_putByte(unsigned char b);
extern void Ethernet_Intern_putBytes(unsigned char *ptr, unsigned int n);
extern void Ethernet_Intern_putConstBytes(const unsigned char *ptr, unsigned int n);
extern unsigned char Ethernet_Intern_getByte();
extern void Ethernet_Intern_getBytes(unsigned char *ptr, unsigned long addr, unsigned int n);
extern unsigned int Ethernet_Intern_UserUDP(unsigned char *remoteHost, unsigned int remotePort, unsigned int localPort, unsigned int reqLength, TEthInternPktFlags * flags);
extern unsigned int Ethernet_Intern_UserTCP(unsigned char *remoteHost, unsigned int remotePort, unsigned int localPort, unsigned int reqLength, TEthInternPktFlags * flags);
extern void Ethernet_Intern_confNetwork(char *ipMask, char *gwIpAddr, char *dnsIpAddr);
#line 1 "c:/users/santosh/desktop/ethernet demo/tft_objects.h"
enum GlcdColor {_clClear, _clDraw, _clInvert};

typedef struct Screen TScreen;

typedef struct Image {
 TScreen* OwnerScreen;
 char Order;
 unsigned int Left;
 unsigned int Top;
 unsigned int Width;
 unsigned int Height;
 const char *Picture_Name;
 char Visible;
 char Active;
 char Picture_Type;
 char Picture_Ratio;
 void (*OnUpPtr)();
 void (*OnDownPtr)();
 void (*OnClickPtr)();
 void (*OnPressPtr)();
} TImage;

struct Screen {
 unsigned int Color;
 unsigned int Width;
 unsigned int Height;
 unsigned short ObjectsCount;
 unsigned int ImagesCount;
 TImage * const code *Images;
};

extern TScreen Screen1;
extern TImage Image1;
extern TImage * const code Screen1_Images[1];
#line 46 "c:/users/santosh/desktop/ethernet demo/tft_objects.h"
void DrawScreen(TScreen *aScreen);
void DrawImage(TImage *AImage);
void Check_TP();
void Start_TP();
#line 1 "c:/users/santosh/desktop/ethernet demo/hardware.h"
sbit LED1 at GPIOB_ODR.B1;
sbit LED2 at GPIOB_ODR.B2;

const code unsigned char httpHeader[] = "HTTP/1.1 200 OK\nContent-type: ";
const code unsigned char httpMimeTypeHTML[] = "text/html\n\n";
const code unsigned char httpMimeTypeScript[] = "text/plain\n\n";
unsigned char httpMethod[] = "GET /";
#line 12 "c:/users/santosh/desktop/ethernet demo/hardware.h"
unsigned char myMacAddr[6] = {0x00, 0x14, 0xA5, 0x76, 0x19, 0x3f};
unsigned char myIpAddr[4] = {192, 168, 20, 60 };
unsigned char gwIpAddr[4] = {192, 168, 20, 66};
unsigned char ipMask[4] = {255, 255, 255, 0 };
unsigned char dnsIpAddr[4] = {192, 168, 20, 1 };

unsigned char getRequest[15];
unsigned char dyna[31] ;
unsigned long httpCounter = 0;
unsigned char AN3[31] ;
unsigned char remoteIpAddr[4] = {192, 168, 20, 13 };
#line 101 "c:/users/santosh/desktop/ethernet demo/hardware.h"
const code char *indexPage =
#line 125 "c:/users/santosh/desktop/ethernet demo/hardware.h"
"<!DOCTYPE html><html><title>AJAX Testing</title><h1>ADC Value from EasyMX Pro : </h1><body> <div id=\"demo\"><button type=\"button\" onclick=\"loadDoc()\">Change Content</button> </div><script>function loadDoc() {  var xhttp = new XMLHttpRequest();   xhttp.onreadystatechange = function() {    if (this.readyState == 4 && this.status == 200) {      document.getElementById(\"demo\").innerHTML =         this.responseText;    }                      };                        xhttp.open(\"GET\", \"query\", true);  xhttp.send();                           setTimeout('loadDoc()', 500); }                                        </script>                                 </body>                                    </html>";
#line 43 "C:/Users/Santosh/Desktop/Ethernet Demo/Ethernet_Demo.c"
void LED1_Function()
{
 static char led1_status = 0;
 led1_status = ~led1_status;
 if (led1_status)
 {
 LED1 = 1;
 }
 else
 {
 LED1 = 0;
 }
}

void LED2_Function()
{
 static char led2_status = 0;
 led2_status = ~led2_status;
 if (led2_status)
 {
 LED2 = 1;
 }
 else
 {
 LED2 = 0;
 }
}
#line 85 "C:/Users/Santosh/Desktop/Ethernet Demo/Ethernet_Demo.c"
unsigned int Ethernet_Intern_UserTCP(unsigned char *remoteHost, unsigned int remotePort, unsigned int localPort, unsigned int reqLength, TEthInternPktFlags *flags)
 {
 unsigned int len;
 char tmp;





 if(localPort != 80)
 {
 return(0);
 }



 for(len = 0; len < 31; len++)
 {
 getRequest[len] = Ethernet_Intern_getByte();
 }
 getRequest[len] = 0;
 len = 0;
 UART1_Write_Text(getRequest);
 UART1_Write_Text("\n\r");
 if(memcmp(getRequest, httpMethod, 5))
 {
 return(0);
 }

 httpCounter++;

 if(getRequest[11] == '2')
 {
 UART1_Write_Text("LED2 clicked...\n\r");
 LED1_Function();
 }
 else if(getRequest[11] == '3')
 {
 UART1_Write_Text("LED3 clicked...\n\r");
 LED2_Function();
 }
 else if(getRequest[5] == 'q')
 {
 memset(dyna, 0, strlen(dyna));
 WordToStr(ADC1_Get_Sample(3), dyna) ;
#line 135 "C:/Users/Santosh/Desktop/Ethernet Demo/Ethernet_Demo.c"
 len += Ethernet_Intern_putString(dyna);

 }

 if(getRequest[5] == 's')
 {



 len = Ethernet_Intern_putConstString(httpHeader);
 len += Ethernet_Intern_putConstString(httpMimeTypeScript);


 WordToStr(ADC1_Get_Sample(3), dyna) ;
 len += Ethernet_Intern_putConstString("var AN3=") ;
 len += Ethernet_Intern_putString(dyna) ;
 len += Ethernet_Intern_putConstString(";") ;
 UART1_Write_Text(dyna);
 UART1_Write_Text("\n\r");


 len += Ethernet_Intern_putConstString("var PORTD=");
 WordToStr(GPIOD_IDR, dyna);
 len += Ethernet_Intern_putString(dyna);
 len += Ethernet_Intern_putConstString(";");
 UART1_Write_Text(dyna);
 UART1_Write_Text("\n\r");


 len += Ethernet_Intern_putConstString("var PORTA=");
 WordToStr(GPIOA_ODR>>8, dyna);
 len += Ethernet_Intern_putString(dyna);
 len += Ethernet_Intern_putConstString(";");
 UART1_Write_Text(dyna);
 UART1_Write_Text("\n\r");


 WordToStr(httpCounter, dyna);
 len += Ethernet_Intern_putConstString("var REQ=");
 len += Ethernet_Intern_putString(dyna);
 len += Ethernet_Intern_putConstString(";");
 }
 else if(getRequest[5] == 't')
 {
 unsigned long bitMask = 0;

 if(isdigit(getRequest[6]))
 {
 bitMask = getRequest[6] - '0';
 bitMask = 1 << (bitMask + 8);
 GPIOA_ODR = GPIOA_ODR ^ bitMask;
 }
 }

 if(len == 0)
 {
 len = Ethernet_Intern_putConstString(httpHeader);
 len += Ethernet_Intern_putConstString(httpMimeTypeHTML);
 len += Ethernet_Intern_putConstString(indexPage);

 }

 return(len);
 }

unsigned int Ethernet_Intern_UserUDP(unsigned char *remoteHost, unsigned int remotePort, unsigned int destPort, unsigned int reqLength, TEthInternPktFlags *flags) {
 unsigned int len;
 char tmp;

 if(destPort != 10001)
 return 0;

 ByteToStr(remoteHost[0], dyna);
 dyna[3] = '.';
 ByteToStr(remoteHost[1], dyna + 4);
 dyna[7] = '.';
 ByteToStr(remoteHost[2], dyna + 8);
 dyna[11] = '.';
 ByteToStr(remoteHost[3], dyna + 12);
 dyna[15] = ':';


 WordToStr(remotePort, dyna + 16);
 dyna[21] = '[';
 WordToStr(destPort, dyna + 22);
 dyna[27] = ']';
 dyna[28] = 0;


 len = 28 + reqLength;


 Ethernet_Intern_putBytes(dyna, 28);


 while(reqLength--)
 {
 tmp = Ethernet_Intern_getByte();
 Ethernet_Intern_putByte(toupper(tmp));
 }

 return(len);
 }

void main() {

 GPIO_Digital_Input(&GPIOD_BASE, _GPIO_PINMASK_ALL);
 GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_ALL);
 UART1_Init(9600);

 ADC1_Init();
 ADC_Set_Input_Channel(_ADC_CHANNEL_3);

 Ethernet_Intern_Init(myMacAddr, myIpAddr,  0b10000 , &_GPIO_MODULE_ETHERNET);
 Ethernet_Intern_confNetwork(ipMask, gwIpAddr, dnsIpAddr);
 UART1_Write_Text("Program Starting ...\n\r");
 Start_TP();

 while(1) {
#line 257 "C:/Users/Santosh/Desktop/Ethernet Demo/Ethernet_Demo.c"
 Ethernet_Intern_doPacket();
#line 264 "C:/Users/Santosh/Desktop/Ethernet Demo/Ethernet_Demo.c"
 }

}
