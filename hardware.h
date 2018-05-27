//Initalisation and declaration of variable and functions
//
sbit LED1 at GPIOB_ODR.B1;
sbit LED2 at GPIOB_ODR.B2;

const code unsigned char httpHeader[] = "HTTP/1.1 200 OK\nContent-type: ";  // HTTP header
const code unsigned char httpMimeTypeHTML[] = "text/html\n\n";              // HTML MIME type
const code unsigned char httpMimeTypeScript[] = "text/plain\n\n";           // TEXT MIME type
unsigned char httpMethod[] = "GET /";

/***********************************
 * RAM variables
 */
unsigned char   myMacAddr[6] = {0x00, 0x14, 0xA5, 0x76, 0x19, 0x3f};   // my MAC address
unsigned char   myIpAddr[4]  = {192, 168,  20, 60 };                   // my IP address
unsigned char   gwIpAddr[4]  = {192, 168,  20, 66};                   // gateway (router) IP address
unsigned char   ipMask[4]    = {255, 255, 255,  0 };                   // network mask (for example : 255.255.255.0)
unsigned char   dnsIpAddr[4] = {192, 168,  20, 1 };                   // DNS server IP address

unsigned char   getRequest[15];                                        // HTTP request buffer
unsigned char   dyna[31] ;                                             // buffer for dynamic response
unsigned long   httpCounter = 0;                                       // counter of HTTP requests
unsigned char   AN3[31] ;
unsigned char   remoteIpAddr[4]  = {192, 168,  20, 13 };                   // my IP address

/*
 * web page, splited into 2 parts :
 * when coming short of ROM, fragmented data is handled more efficiently by linker
 *
 * this HTML page calls the boards to get its status, and builds itself with javascript
 */
/*const code   char    *indexPage =                   // Change the IP address of the page to be refreshed
"<meta http-equiv=\"refresh\" content=\";url=http://192.168.20.60\">\
<HTML><HEAD></HEAD><BODY>\
<h1><b>STM32F4 Web Server</b></h1>\
<a href=/>Reload</a>\
<script src=/s></script>\
<table><tr><td valign=top><table border=1 style=\"font-size:20px ;font-family: terminal ;\">\
<tr><th colspan=2>ADC</th></tr>\
<tr><td>AN3</td><td><script>document.write(AN3)</script></td></tr>\
</table></td><td><table border=1 style=\"font-size:20px ;font-family: terminal ;\">\
<tr><th colspan=2>PORTD</th></tr>\
<script>\
var str,i;\
str=\"\";\
for(i=0;i<8;i++)\
{str+=\"<tr><td bgcolor=pink>BUTTON #\"+i+\"</td>\";\
if(PORTD&(1<<i)){str+=\"<td bgcolor=red>ON\";}\
else {str+=\"<td bgcolor=#cccccc>OFF\";}\
str+=\"</td></tr>\";}\
document.write(str) ;\
</script>\
" ;

const code   char    *indexPage2 =  "</table></td><td>\
<table border=1 style=\"font-size:20px ;font-family: terminal ;\">\
<tr><th colspan=3>PORTA</th></tr>\
<script>\
var str,i;\
str=\"\";\
for(i=0;i<8;i++)\
{str+=\"<tr><td bgcolor=yellow>LED #\"+i+\"</td>\";\
if(PORTA&(1<<i)){str+=\"<td bgcolor=red>ON\";}\
else {str+=\"<td bgcolor=#cccccc>OFF\";}\
str+=\"</td><td><a href=/t\"+i+\">Toggle</a></td></tr>\";}\
document.write(str) ;\
</script>\
</table></td></tr></table>\
This is HTTP request #<script>document.write(REQ)</script></BODY></HTML>\
" ;*/




/*const code   char    *indexPage =
"<meta http-equiv=\"refresh\" content=\";url=http://192.168.20.60\">\
<!DOCTYPE html>\
<html><head><title>STM32 Web Page</title>\
<h1><b>STM32F4 Web Server</b></h1>\
<body>\
<h2>LED</h2>\
<p>Click to switch LED on and off.</p>\
<form method=\"get\">\
      <input type=\"checkbox\" name=\"LED2\" value=\"2\" onclick=\"submit();\">LED2\
</form>\
<form method=\"get\">\
      <input type=\"checkbox\" name=\"LED3\" value=\"3\" onclick=\"submit();\">LED3\
</form>\
<form>\
  First name:<br>\
  <input type=\"text\" name=\"tb\"><br>\
   <input type=\"submit\" value=\"Submit\">\
</form>\
<!--AN3 table-->\n\
<table border=1 style='font-size:20px ;font-family: terminal ;'>\n\
<tr><th colspan=2>ADC</th></tr>\n\
<tr><td>AN3</td><td id='adc'><script>document.write(AN3)</script></td></tr>\n\
<tr><td><button >Load AN3</button></td></tr>\n\
</table>\n\
</body>\
</head></html>";*/

const code   char    *indexPage =
"<!DOCTYPE html>\
<html>\
<title>AJAX Testing</title>\
<h1>ADC Value from EasyMX Pro : </h1>\
<body> \
<div id=\"demo\">\
<button type=\"button\" onclick=\"loadDoc()\">Change Content</button> \
</div>\
<script>\
function loadDoc() {\
  var xhttp = new XMLHttpRequest(); \
  xhttp.onreadystatechange = function() {\
    if (this.readyState == 4 && this.status == 200) {\
      document.getElementById(\"demo\").innerHTML =   \
      this.responseText;\
    }                    \
  };                      \
  xhttp.open(\"GET\", \"query\", true);\
  xhttp.send();                         \
  setTimeout('loadDoc()', 500); \
}                                        \
</script>                                 \
</body>                                    \
</html>";