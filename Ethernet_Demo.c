/*
 * Project Name:
     Ethernet_Demo (Ethernet Library demo for internal Ethernet module)
 * Copyright:
     (c) Mikroelektronika, 2012.

 * description  :
 *      this code shows how to use the Ethernet library :
 *              the board will reply to ARP & ICMP echo requests
 *              the board will reply to UDP requests on any port :
 *                      returns the request in upper char with a header made of remote host IP & port number
 *              the board will reply to HTTP requests on port 80, GET method with pathnames :
 *                      /               will return the HTML main page
 *                      /s              will return board status as text string
 *                      /t0 ... /t7     will toggle RE8 to RE15 bit and return HTML main page
 *                      all other requests return also HTML main page
 *
 * Test configuration:
     MCU:             STM32F407VG
                      http://www.st.com/internet/com/TECHNICAL_RESOURCES/TECHNICAL_LITERATURE/DATASHEET/CD00220364.pdf
     Dev.Board:       EasyMx v7 for STM32 ® ARM ®
                      http://www.mikroe.com/eng/products/view/852/easymx-pro-v7-for-stm32/
                      ac:ETHERNET
     Oscillator:      HSE-PLL, 120.000MHz
     ext. modules:    no.
     SW:              mikroC PRO for ARM
                      http://www.mikroe.com/eng/products/view/752/mikroc-pro-for-arm/
 * NOTES:
     - Pull-down PORTD/L at SW8, and put SW10.7 in VCC position (board specific)
     - Close pots PA3 at J8.
     - Turn ON PORTE/H LEDs at SW15.8.

 */

#include        "__Ethernet_Intern.h"
#include "TFT_objects.h"
#include "hardware.h"


/*******************************************
 * functions
 */
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





/*
 * this function is called by the library
 * the user accesses to the HTTP request by successive calls to Ethernet_Intern_getByte()
 * the user puts data in the transmit buffer by successive calls to Ethernet_Intern_putByte()
 * the function must return the length in bytes of the HTTP reply, or 0 if nothing to transmit
 *
 * if you don't need to reply to HTTP requests,
 * just define this function with a return(0) as single statement
 *
 */
unsigned int    Ethernet_Intern_UserTCP(unsigned char *remoteHost, unsigned int remotePort, unsigned int localPort, unsigned int reqLength, TEthInternPktFlags *flags)
        {
        unsigned int    len;            // my reply length
        char tmp;
        // should we close tcp socket after response is sent?
        // library closes tcp socket by default if canCloseTCP flag is not reset here
        // flags->canCloseTCP = 0; // 0 - do not close socket
                                   // otherwise - close socke

        if(localPort != 80)                         // I listen only to web request on port 80
                {
                return(0);
                }


        // get 10 first bytes only of the request, the rest does not matter here
        for(len = 0; len < 31; len++)
        {
        getRequest[len] = Ethernet_Intern_getByte();
        }
        getRequest[len] = 0;
        len = 0;
        UART1_Write_Text(getRequest);
        UART1_Write_Text("\n\r");
        if(memcmp(getRequest, httpMethod, 5))       // only GET method is supported here
                {
                return(0);
                }

        httpCounter++;                             // one more request done
        
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
             /*len =  Ethernet_Intern_putConstString(httpHeader);
             len += Ethernet_Intern_putConstString(httpMimeTypeHTML);
             len += Ethernet_Intern_putConstString("var AN3=") ;
             len += Ethernet_Intern_putString(dyna) ;
             len += Ethernet_Intern_putConstString(";") ;*/
             len += Ethernet_Intern_putString(dyna);
             
        }

         if(getRequest[5] == 's')
                {
                // the text string replied by this request can be interpreted as javascript statements
                // by browsers

                len = Ethernet_Intern_putConstString(httpHeader);              // HTTP header
                len += Ethernet_Intern_putConstString(httpMimeTypeScript);     // with text MIME type

                // add AN3 value to reply
                WordToStr(ADC1_Get_Sample(3), dyna) ;
                len += Ethernet_Intern_putConstString("var AN3=") ;
                len += Ethernet_Intern_putString(dyna) ;
                len += Ethernet_Intern_putConstString(";") ;
                UART1_Write_Text(dyna);
                UART1_Write_Text("\n\r");

                // add PORTD value (buttons) to reply
                len += Ethernet_Intern_putConstString("var PORTD=");
                WordToStr(GPIOD_IDR, dyna);
                len += Ethernet_Intern_putString(dyna);
                len += Ethernet_Intern_putConstString(";");
                UART1_Write_Text(dyna);
                UART1_Write_Text("\n\r");

                // add PORTE value (LEDs) to reply
                len += Ethernet_Intern_putConstString("var PORTA=");
                WordToStr(GPIOA_ODR>>8, dyna);
                len += Ethernet_Intern_putString(dyna);
                len += Ethernet_Intern_putConstString(";");
                UART1_Write_Text(dyna);
                UART1_Write_Text("\n\r");

                // add HTTP requests counter to reply
                WordToStr(httpCounter, dyna);
                len += Ethernet_Intern_putConstString("var REQ=");
                len += Ethernet_Intern_putString(dyna);
                len += Ethernet_Intern_putConstString(";");
                }
        else if(getRequest[5] == 't')                           // if request path name starts with t, toggle PORTE (LED) bit number that comes after
                {
                unsigned long   bitMask = 0;                   // for bit mask

                if(isdigit(getRequest[6]))                      // if 0 <= bit number <= 9, bits 8 & 9 does not exist but does not matter
                        {
                        bitMask = getRequest[6] - '0';         // convert ASCII to integer
                        bitMask = 1 << (bitMask + 8);                // create bit mask
                        GPIOA_ODR = GPIOA_ODR ^ bitMask;     // toggle PORTE with xor operator
                        }
                }

        if(len == 0)                                            // what do to by default
                {
                len =  Ethernet_Intern_putConstString(httpHeader);             // HTTP header
                len += Ethernet_Intern_putConstString(httpMimeTypeHTML);       // with HTML MIME type
                len += Ethernet_Intern_putConstString(indexPage);              // HTML page first part
                //len += Ethernet_Intern_putConstString(indexPage2);             // HTML page second part
                }

        return(len);                                           // return to the library with the number of bytes to transmit
        }

unsigned int    Ethernet_Intern_UserUDP(unsigned char *remoteHost, unsigned int remotePort, unsigned int destPort, unsigned int reqLength, TEthInternPktFlags *flags) {
        unsigned int    len;                           // my reply length
        char tmp;

        if(destPort != 10001)
          return 0;
        // reply is made of the remote host IP address in human readable format
        ByteToStr(remoteHost[0], dyna);                // first IP address byte
        dyna[3] = '.';
        ByteToStr(remoteHost[1], dyna + 4);            // second
        dyna[7] = '.';
        ByteToStr(remoteHost[2], dyna + 8);            // third
        dyna[11] = '.';
        ByteToStr(remoteHost[3], dyna + 12);           // fourth
        dyna[15] = ':';                                // add separator

        // then remote host port number
        WordToStr(remotePort, dyna + 16);
        dyna[21] = '[';
        WordToStr(destPort, dyna + 22);
        dyna[27] = ']';
        dyna[28] = 0;

        // the total length of the request is the length of the dynamic string plus the text of the request
        len = 28 + reqLength;

        // puts the dynamic string into the transmit buffer
        Ethernet_Intern_putBytes(dyna, 28);

        // then puts the request string converted into upper char into the transmit buffer
        while(reqLength--)
                {
                tmp = Ethernet_Intern_getByte();
                Ethernet_Intern_putByte(toupper(tmp));
                }

        return(len);           // back to the library with the length of the UDP reply
        }

void main() {

  GPIO_Digital_Input(&GPIOD_BASE, _GPIO_PINMASK_ALL);
  GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_ALL);
  UART1_Init(9600);

  ADC1_Init();
  ADC_Set_Input_Channel(_ADC_CHANNEL_3);
  
  Ethernet_Intern_Init(myMacAddr, myIpAddr, _ETHERNET_AUTO_NEGOTIATION, &_GPIO_MODULE_ETHERNET);
  Ethernet_Intern_confNetwork(ipMask, gwIpAddr, dnsIpAddr);
  UART1_Write_Text("Program Starting ...\n\r");
  Start_TP();

  while(1) {
    /*
     * if necessary, test the return value to get error code
     */
    Ethernet_Intern_doPacket();   // process incoming Ethernet packets

    /*
     * add your stuff here if needed
     * Ethernet_Intern_doPacket() must be called as often as possible
     * otherwise packets could be lost
     */
  }

}