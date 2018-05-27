_LED1_Function:
;Ethernet_Demo.c,43 :: 		void LED1_Function()
;Ethernet_Demo.c,46 :: 		led1_status = ~led1_status;
MOVW	R1, #lo_addr(LED1_Function_led1_status_L0+0)
MOVT	R1, #hi_addr(LED1_Function_led1_status_L0+0)
LDRB	R0, [R1, #0]
MVN	R0, R0
UXTB	R0, R0
STRB	R0, [R1, #0]
;Ethernet_Demo.c,47 :: 		if (led1_status)
CMP	R0, #0
IT	EQ
BEQ	L_LED1_Function0
;Ethernet_Demo.c,49 :: 		LED1 = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;Ethernet_Demo.c,50 :: 		}
IT	AL
BAL	L_LED1_Function1
L_LED1_Function0:
;Ethernet_Demo.c,53 :: 		LED1 = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;Ethernet_Demo.c,54 :: 		}
L_LED1_Function1:
;Ethernet_Demo.c,55 :: 		}
L_end_LED1_Function:
BX	LR
; end of _LED1_Function
_LED2_Function:
;Ethernet_Demo.c,57 :: 		void LED2_Function()
;Ethernet_Demo.c,60 :: 		led2_status = ~led2_status;
MOVW	R1, #lo_addr(LED2_Function_led2_status_L0+0)
MOVT	R1, #hi_addr(LED2_Function_led2_status_L0+0)
LDRB	R0, [R1, #0]
MVN	R0, R0
UXTB	R0, R0
STRB	R0, [R1, #0]
;Ethernet_Demo.c,61 :: 		if (led2_status)
CMP	R0, #0
IT	EQ
BEQ	L_LED2_Function2
;Ethernet_Demo.c,63 :: 		LED2 = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;Ethernet_Demo.c,64 :: 		}
IT	AL
BAL	L_LED2_Function3
L_LED2_Function2:
;Ethernet_Demo.c,67 :: 		LED2 = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;Ethernet_Demo.c,68 :: 		}
L_LED2_Function3:
;Ethernet_Demo.c,69 :: 		}
L_end_LED2_Function:
BX	LR
; end of _LED2_Function
_Ethernet_Intern_UserTCP:
;Ethernet_Demo.c,85 :: 		unsigned int    Ethernet_Intern_UserTCP(unsigned char *remoteHost, unsigned int remotePort, unsigned int localPort, unsigned int reqLength, TEthInternPktFlags *flags)
; localPort start address is: 8 (R2)
SUB	SP, SP, #8
STR	LR, [SP, #0]
; localPort end address is: 8 (R2)
; localPort start address is: 8 (R2)
; flags start address is: 16 (R4)
LDR	R4, [SP, #8]
; flags end address is: 16 (R4)
;Ethernet_Demo.c,94 :: 		if(localPort != 80)                         // I listen only to web request on port 80
CMP	R2, #80
IT	EQ
BEQ	L_Ethernet_Intern_UserTCP4
; localPort end address is: 8 (R2)
;Ethernet_Demo.c,96 :: 		return(0);
MOVS	R0, #0
IT	AL
BAL	L_end_Ethernet_Intern_UserTCP
;Ethernet_Demo.c,97 :: 		}
L_Ethernet_Intern_UserTCP4:
;Ethernet_Demo.c,101 :: 		for(len = 0; len < 31; len++)
; len start address is: 28 (R7)
MOVS	R7, #0
; len end address is: 28 (R7)
L_Ethernet_Intern_UserTCP5:
; len start address is: 28 (R7)
CMP	R7, #31
IT	CS
BCS	L_Ethernet_Intern_UserTCP6
;Ethernet_Demo.c,103 :: 		getRequest[len] = Ethernet_Intern_getByte();
MOVW	R4, #lo_addr(_getRequest+0)
MOVT	R4, #hi_addr(_getRequest+0)
ADDS	R4, R4, R7
STR	R4, [SP, #4]
BL	_Ethernet_Intern_getByte+0
LDR	R4, [SP, #4]
STRB	R0, [R4, #0]
;Ethernet_Demo.c,101 :: 		for(len = 0; len < 31; len++)
ADDS	R7, R7, #1
UXTH	R7, R7
;Ethernet_Demo.c,104 :: 		}
IT	AL
BAL	L_Ethernet_Intern_UserTCP5
L_Ethernet_Intern_UserTCP6:
;Ethernet_Demo.c,105 :: 		getRequest[len] = 0;
MOVW	R4, #lo_addr(_getRequest+0)
MOVT	R4, #hi_addr(_getRequest+0)
ADDS	R5, R4, R7
; len end address is: 28 (R7)
MOVS	R4, #0
STRB	R4, [R5, #0]
;Ethernet_Demo.c,106 :: 		len = 0;
; len start address is: 32 (R8)
MOVW	R8, #0
;Ethernet_Demo.c,107 :: 		UART1_Write_Text(getRequest);
MOVW	R0, #lo_addr(_getRequest+0)
MOVT	R0, #hi_addr(_getRequest+0)
BL	_UART1_Write_Text+0
;Ethernet_Demo.c,108 :: 		UART1_Write_Text("\n\r");
MOVW	R4, #lo_addr(?lstr2_Ethernet_Demo+0)
MOVT	R4, #hi_addr(?lstr2_Ethernet_Demo+0)
MOV	R0, R4
BL	_UART1_Write_Text+0
;Ethernet_Demo.c,109 :: 		if(memcmp(getRequest, httpMethod, 5))       // only GET method is supported here
MOVS	R2, #5
SXTH	R2, R2
MOVW	R1, #lo_addr(_httpMethod+0)
MOVT	R1, #hi_addr(_httpMethod+0)
MOVW	R0, #lo_addr(_getRequest+0)
MOVT	R0, #hi_addr(_getRequest+0)
BL	_memcmp+0
CMP	R0, #0
IT	EQ
BEQ	L_Ethernet_Intern_UserTCP8
; len end address is: 32 (R8)
;Ethernet_Demo.c,111 :: 		return(0);
MOVS	R0, #0
IT	AL
BAL	L_end_Ethernet_Intern_UserTCP
;Ethernet_Demo.c,112 :: 		}
L_Ethernet_Intern_UserTCP8:
;Ethernet_Demo.c,114 :: 		httpCounter++;                             // one more request done
; len start address is: 32 (R8)
MOVW	R5, #lo_addr(_httpCounter+0)
MOVT	R5, #hi_addr(_httpCounter+0)
LDR	R4, [R5, #0]
ADDS	R4, R4, #1
STR	R4, [R5, #0]
;Ethernet_Demo.c,116 :: 		if(getRequest[11] == '2')
MOVW	R4, #lo_addr(_getRequest+11)
MOVT	R4, #hi_addr(_getRequest+11)
LDRB	R4, [R4, #0]
CMP	R4, #50
IT	NE
BNE	L_Ethernet_Intern_UserTCP9
;Ethernet_Demo.c,118 :: 		UART1_Write_Text("LED2 clicked...\n\r");
MOVW	R4, #lo_addr(?lstr3_Ethernet_Demo+0)
MOVT	R4, #hi_addr(?lstr3_Ethernet_Demo+0)
MOV	R0, R4
BL	_UART1_Write_Text+0
;Ethernet_Demo.c,119 :: 		LED1_Function();
BL	_LED1_Function+0
;Ethernet_Demo.c,120 :: 		}
UXTH	R2, R8
IT	AL
BAL	L_Ethernet_Intern_UserTCP10
L_Ethernet_Intern_UserTCP9:
;Ethernet_Demo.c,121 :: 		else if(getRequest[11] == '3')
MOVW	R4, #lo_addr(_getRequest+11)
MOVT	R4, #hi_addr(_getRequest+11)
LDRB	R4, [R4, #0]
CMP	R4, #51
IT	NE
BNE	L_Ethernet_Intern_UserTCP11
;Ethernet_Demo.c,123 :: 		UART1_Write_Text("LED3 clicked...\n\r");
MOVW	R4, #lo_addr(?lstr4_Ethernet_Demo+0)
MOVT	R4, #hi_addr(?lstr4_Ethernet_Demo+0)
MOV	R0, R4
BL	_UART1_Write_Text+0
;Ethernet_Demo.c,124 :: 		LED2_Function();
BL	_LED2_Function+0
;Ethernet_Demo.c,125 :: 		}
UXTH	R2, R8
IT	AL
BAL	L_Ethernet_Intern_UserTCP12
L_Ethernet_Intern_UserTCP11:
;Ethernet_Demo.c,126 :: 		else if(getRequest[5] == 'q')
MOVW	R4, #lo_addr(_getRequest+5)
MOVT	R4, #hi_addr(_getRequest+5)
LDRB	R4, [R4, #0]
CMP	R4, #113
IT	NE
BNE	L__Ethernet_Intern_UserTCP24
;Ethernet_Demo.c,128 :: 		memset(dyna, 0, strlen(dyna));
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_strlen+0
SXTH	R2, R0
MOVS	R1, #0
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_memset+0
;Ethernet_Demo.c,129 :: 		WordToStr(ADC1_Get_Sample(3), dyna) ;
MOVS	R0, #3
BL	_ADC1_Get_Sample+0
MOVW	R1, #lo_addr(_dyna+0)
MOVT	R1, #hi_addr(_dyna+0)
BL	_WordToStr+0
;Ethernet_Demo.c,135 :: 		len += Ethernet_Intern_putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_Ethernet_Intern_putString+0
ADD	R0, R8, R0, LSL #0
UXTH	R0, R0
; len end address is: 32 (R8)
; len start address is: 0 (R0)
; len end address is: 0 (R0)
;Ethernet_Demo.c,137 :: 		}
IT	AL
BAL	L_Ethernet_Intern_UserTCP13
L__Ethernet_Intern_UserTCP24:
;Ethernet_Demo.c,126 :: 		else if(getRequest[5] == 'q')
UXTH	R0, R8
;Ethernet_Demo.c,137 :: 		}
L_Ethernet_Intern_UserTCP13:
; len start address is: 0 (R0)
UXTH	R2, R0
; len end address is: 0 (R0)
L_Ethernet_Intern_UserTCP12:
; len start address is: 8 (R2)
; len end address is: 8 (R2)
L_Ethernet_Intern_UserTCP10:
;Ethernet_Demo.c,139 :: 		if(getRequest[5] == 's')
; len start address is: 8 (R2)
MOVW	R4, #lo_addr(_getRequest+5)
MOVT	R4, #hi_addr(_getRequest+5)
LDRB	R4, [R4, #0]
CMP	R4, #115
IT	NE
BNE	L_Ethernet_Intern_UserTCP14
; len end address is: 8 (R2)
;Ethernet_Demo.c,144 :: 		len = Ethernet_Intern_putConstString(httpHeader);              // HTTP header
MOVW	R0, #lo_addr(_httpHeader+0)
MOVT	R0, #hi_addr(_httpHeader+0)
BL	_Ethernet_Intern_putConstString+0
; len start address is: 20 (R5)
UXTH	R5, R0
;Ethernet_Demo.c,145 :: 		len += Ethernet_Intern_putConstString(httpMimeTypeScript);     // with text MIME type
MOVW	R0, #lo_addr(_httpMimeTypeScript+0)
MOVT	R0, #hi_addr(_httpMimeTypeScript+0)
BL	_Ethernet_Intern_putConstString+0
ADDS	R6, R5, R0
UXTH	R6, R6
; len end address is: 20 (R5)
; len start address is: 24 (R6)
;Ethernet_Demo.c,148 :: 		WordToStr(ADC1_Get_Sample(3), dyna) ;
MOVS	R0, #3
BL	_ADC1_Get_Sample+0
MOVW	R1, #lo_addr(_dyna+0)
MOVT	R1, #hi_addr(_dyna+0)
BL	_WordToStr+0
;Ethernet_Demo.c,149 :: 		len += Ethernet_Intern_putConstString("var AN3=") ;
MOVW	R4, #lo_addr(?lstr_5_Ethernet_Demo+0)
MOVT	R4, #hi_addr(?lstr_5_Ethernet_Demo+0)
MOV	R0, R4
BL	_Ethernet_Intern_putConstString+0
ADDS	R5, R6, R0
UXTH	R5, R5
; len end address is: 24 (R6)
; len start address is: 20 (R5)
;Ethernet_Demo.c,150 :: 		len += Ethernet_Intern_putString(dyna) ;
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_Ethernet_Intern_putString+0
ADDS	R5, R5, R0
UXTH	R5, R5
;Ethernet_Demo.c,151 :: 		len += Ethernet_Intern_putConstString(";") ;
MOVW	R4, #lo_addr(?lstr_6_Ethernet_Demo+0)
MOVT	R4, #hi_addr(?lstr_6_Ethernet_Demo+0)
MOV	R0, R4
BL	_Ethernet_Intern_putConstString+0
ADDS	R7, R5, R0
UXTH	R7, R7
; len end address is: 20 (R5)
; len start address is: 28 (R7)
;Ethernet_Demo.c,152 :: 		UART1_Write_Text(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_UART1_Write_Text+0
;Ethernet_Demo.c,153 :: 		UART1_Write_Text("\n\r");
MOVW	R4, #lo_addr(?lstr7_Ethernet_Demo+0)
MOVT	R4, #hi_addr(?lstr7_Ethernet_Demo+0)
MOV	R0, R4
BL	_UART1_Write_Text+0
;Ethernet_Demo.c,156 :: 		len += Ethernet_Intern_putConstString("var PORTD=");
MOVW	R4, #lo_addr(?lstr_8_Ethernet_Demo+0)
MOVT	R4, #hi_addr(?lstr_8_Ethernet_Demo+0)
MOV	R0, R4
BL	_Ethernet_Intern_putConstString+0
ADDS	R6, R7, R0
UXTH	R6, R6
; len end address is: 28 (R7)
; len start address is: 24 (R6)
;Ethernet_Demo.c,157 :: 		WordToStr(GPIOD_IDR, dyna);
MOVW	R4, #lo_addr(GPIOD_IDR+0)
MOVT	R4, #hi_addr(GPIOD_IDR+0)
LDR	R4, [R4, #0]
MOVW	R1, #lo_addr(_dyna+0)
MOVT	R1, #hi_addr(_dyna+0)
UXTH	R0, R4
BL	_WordToStr+0
;Ethernet_Demo.c,158 :: 		len += Ethernet_Intern_putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_Ethernet_Intern_putString+0
ADDS	R5, R6, R0
UXTH	R5, R5
; len end address is: 24 (R6)
; len start address is: 20 (R5)
;Ethernet_Demo.c,159 :: 		len += Ethernet_Intern_putConstString(";");
MOVW	R4, #lo_addr(?lstr_9_Ethernet_Demo+0)
MOVT	R4, #hi_addr(?lstr_9_Ethernet_Demo+0)
MOV	R0, R4
BL	_Ethernet_Intern_putConstString+0
ADDS	R7, R5, R0
UXTH	R7, R7
; len end address is: 20 (R5)
; len start address is: 28 (R7)
;Ethernet_Demo.c,160 :: 		UART1_Write_Text(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_UART1_Write_Text+0
;Ethernet_Demo.c,161 :: 		UART1_Write_Text("\n\r");
MOVW	R4, #lo_addr(?lstr10_Ethernet_Demo+0)
MOVT	R4, #hi_addr(?lstr10_Ethernet_Demo+0)
MOV	R0, R4
BL	_UART1_Write_Text+0
;Ethernet_Demo.c,164 :: 		len += Ethernet_Intern_putConstString("var PORTA=");
MOVW	R4, #lo_addr(?lstr_11_Ethernet_Demo+0)
MOVT	R4, #hi_addr(?lstr_11_Ethernet_Demo+0)
MOV	R0, R4
BL	_Ethernet_Intern_putConstString+0
ADDS	R4, R7, R0
; len end address is: 28 (R7)
; len start address is: 24 (R6)
UXTH	R6, R4
;Ethernet_Demo.c,165 :: 		WordToStr(GPIOA_ODR>>8, dyna);
MOVW	R4, #lo_addr(GPIOA_ODR+0)
MOVT	R4, #hi_addr(GPIOA_ODR+0)
LDR	R4, [R4, #0]
LSRS	R4, R4, #8
MOVW	R1, #lo_addr(_dyna+0)
MOVT	R1, #hi_addr(_dyna+0)
UXTH	R0, R4
BL	_WordToStr+0
;Ethernet_Demo.c,166 :: 		len += Ethernet_Intern_putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_Ethernet_Intern_putString+0
ADDS	R5, R6, R0
UXTH	R5, R5
; len end address is: 24 (R6)
; len start address is: 20 (R5)
;Ethernet_Demo.c,167 :: 		len += Ethernet_Intern_putConstString(";");
MOVW	R4, #lo_addr(?lstr_12_Ethernet_Demo+0)
MOVT	R4, #hi_addr(?lstr_12_Ethernet_Demo+0)
MOV	R0, R4
BL	_Ethernet_Intern_putConstString+0
ADDS	R4, R5, R0
; len end address is: 20 (R5)
; len start address is: 28 (R7)
UXTH	R7, R4
;Ethernet_Demo.c,168 :: 		UART1_Write_Text(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_UART1_Write_Text+0
;Ethernet_Demo.c,169 :: 		UART1_Write_Text("\n\r");
MOVW	R4, #lo_addr(?lstr13_Ethernet_Demo+0)
MOVT	R4, #hi_addr(?lstr13_Ethernet_Demo+0)
MOV	R0, R4
BL	_UART1_Write_Text+0
;Ethernet_Demo.c,172 :: 		WordToStr(httpCounter, dyna);
MOVW	R4, #lo_addr(_httpCounter+0)
MOVT	R4, #hi_addr(_httpCounter+0)
LDR	R4, [R4, #0]
MOVW	R1, #lo_addr(_dyna+0)
MOVT	R1, #hi_addr(_dyna+0)
UXTH	R0, R4
BL	_WordToStr+0
;Ethernet_Demo.c,173 :: 		len += Ethernet_Intern_putConstString("var REQ=");
MOVW	R4, #lo_addr(?lstr_14_Ethernet_Demo+0)
MOVT	R4, #hi_addr(?lstr_14_Ethernet_Demo+0)
MOV	R0, R4
BL	_Ethernet_Intern_putConstString+0
ADDS	R5, R7, R0
UXTH	R5, R5
; len end address is: 28 (R7)
; len start address is: 20 (R5)
;Ethernet_Demo.c,174 :: 		len += Ethernet_Intern_putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_Ethernet_Intern_putString+0
ADDS	R5, R5, R0
UXTH	R5, R5
;Ethernet_Demo.c,175 :: 		len += Ethernet_Intern_putConstString(";");
MOVW	R4, #lo_addr(?lstr_15_Ethernet_Demo+0)
MOVT	R4, #hi_addr(?lstr_15_Ethernet_Demo+0)
MOV	R0, R4
BL	_Ethernet_Intern_putConstString+0
ADDS	R0, R5, R0
UXTH	R0, R0
; len end address is: 20 (R5)
; len start address is: 0 (R0)
;Ethernet_Demo.c,176 :: 		}
; len end address is: 0 (R0)
IT	AL
BAL	L_Ethernet_Intern_UserTCP15
L_Ethernet_Intern_UserTCP14:
;Ethernet_Demo.c,177 :: 		else if(getRequest[5] == 't')                           // if request path name starts with t, toggle PORTE (LED) bit number that comes after
; len start address is: 8 (R2)
MOVW	R4, #lo_addr(_getRequest+5)
MOVT	R4, #hi_addr(_getRequest+5)
LDRB	R4, [R4, #0]
CMP	R4, #116
IT	NE
BNE	L_Ethernet_Intern_UserTCP16
;Ethernet_Demo.c,179 :: 		unsigned long   bitMask = 0;                   // for bit mask
;Ethernet_Demo.c,181 :: 		if(isdigit(getRequest[6]))                      // if 0 <= bit number <= 9, bits 8 & 9 does not exist but does not matter
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
UXTB	R0, R4
BL	_isdigit+0
CMP	R0, #0
IT	EQ
BEQ	L_Ethernet_Intern_UserTCP17
;Ethernet_Demo.c,183 :: 		bitMask = getRequest[6] - '0';         // convert ASCII to integer
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
SUBW	R0, R4, #48
; bitMask start address is: 0 (R0)
SXTH	R0, R0
;Ethernet_Demo.c,184 :: 		bitMask = 1 << (bitMask + 8);                // create bit mask
ADDW	R5, R0, #8
; bitMask end address is: 0 (R0)
MOVS	R4, #1
SXTH	R4, R4
LSLS	R4, R5
SXTH	R4, R4
; bitMask start address is: 0 (R0)
SXTH	R0, R4
;Ethernet_Demo.c,185 :: 		GPIOA_ODR = GPIOA_ODR ^ bitMask;     // toggle PORTE with xor operator
MOVW	R4, #lo_addr(GPIOA_ODR+0)
MOVT	R4, #hi_addr(GPIOA_ODR+0)
LDR	R4, [R4, #0]
EOR	R5, R4, R0, LSL #0
; bitMask end address is: 0 (R0)
MOVW	R4, #lo_addr(GPIOA_ODR+0)
MOVT	R4, #hi_addr(GPIOA_ODR+0)
STR	R5, [R4, #0]
;Ethernet_Demo.c,186 :: 		}
L_Ethernet_Intern_UserTCP17:
;Ethernet_Demo.c,187 :: 		}
L_Ethernet_Intern_UserTCP16:
UXTH	R0, R2
L_Ethernet_Intern_UserTCP15:
; len end address is: 8 (R2)
;Ethernet_Demo.c,189 :: 		if(len == 0)                                            // what do to by default
; len start address is: 0 (R0)
CMP	R0, #0
IT	NE
BNE	L__Ethernet_Intern_UserTCP25
; len end address is: 0 (R0)
;Ethernet_Demo.c,191 :: 		len =  Ethernet_Intern_putConstString(httpHeader);             // HTTP header
MOVW	R0, #lo_addr(_httpHeader+0)
MOVT	R0, #hi_addr(_httpHeader+0)
BL	_Ethernet_Intern_putConstString+0
; len start address is: 20 (R5)
UXTH	R5, R0
;Ethernet_Demo.c,192 :: 		len += Ethernet_Intern_putConstString(httpMimeTypeHTML);       // with HTML MIME type
MOVW	R0, #lo_addr(_httpMimeTypeHTML+0)
MOVT	R0, #hi_addr(_httpMimeTypeHTML+0)
BL	_Ethernet_Intern_putConstString+0
ADDS	R5, R5, R0
UXTH	R5, R5
;Ethernet_Demo.c,193 :: 		len += Ethernet_Intern_putConstString(indexPage);              // HTML page first part
MOVW	R4, #lo_addr(_indexPage+0)
MOVT	R4, #hi_addr(_indexPage+0)
LDR	R4, [R4, #0]
MOV	R0, R4
BL	_Ethernet_Intern_putConstString+0
ADDS	R0, R5, R0
UXTH	R0, R0
; len end address is: 20 (R5)
; len start address is: 0 (R0)
; len end address is: 0 (R0)
;Ethernet_Demo.c,195 :: 		}
IT	AL
BAL	L_Ethernet_Intern_UserTCP18
L__Ethernet_Intern_UserTCP25:
;Ethernet_Demo.c,189 :: 		if(len == 0)                                            // what do to by default
;Ethernet_Demo.c,195 :: 		}
L_Ethernet_Intern_UserTCP18:
;Ethernet_Demo.c,197 :: 		return(len);                                           // return to the library with the number of bytes to transmit
; len start address is: 0 (R0)
; len end address is: 0 (R0)
;Ethernet_Demo.c,198 :: 		}
L_end_Ethernet_Intern_UserTCP:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _Ethernet_Intern_UserTCP
_Ethernet_Intern_UserUDP:
;Ethernet_Demo.c,200 :: 		unsigned int    Ethernet_Intern_UserUDP(unsigned char *remoteHost, unsigned int remotePort, unsigned int destPort, unsigned int reqLength, TEthInternPktFlags *flags) {
; reqLength start address is: 12 (R3)
; destPort start address is: 8 (R2)
; remotePort start address is: 4 (R1)
; remoteHost start address is: 0 (R0)
SUB	SP, SP, #8
STR	LR, [SP, #0]
MOV	R7, R0
UXTH	R8, R1
UXTH	R9, R2
UXTH	R6, R3
; reqLength end address is: 12 (R3)
; destPort end address is: 8 (R2)
; remotePort end address is: 4 (R1)
; remoteHost end address is: 0 (R0)
; remoteHost start address is: 28 (R7)
; remotePort start address is: 32 (R8)
; destPort start address is: 36 (R9)
; reqLength start address is: 24 (R6)
; flags start address is: 16 (R4)
LDR	R4, [SP, #8]
; flags end address is: 16 (R4)
;Ethernet_Demo.c,204 :: 		if(destPort != 10001)
MOVW	R4, #10001
CMP	R9, R4
IT	EQ
BEQ	L_Ethernet_Intern_UserUDP19
; remoteHost end address is: 28 (R7)
; remotePort end address is: 32 (R8)
; destPort end address is: 36 (R9)
; reqLength end address is: 24 (R6)
;Ethernet_Demo.c,205 :: 		return 0;
MOVS	R0, #0
IT	AL
BAL	L_end_Ethernet_Intern_UserUDP
L_Ethernet_Intern_UserUDP19:
;Ethernet_Demo.c,207 :: 		ByteToStr(remoteHost[0], dyna);                // first IP address byte
; reqLength start address is: 24 (R6)
; destPort start address is: 36 (R9)
; remotePort start address is: 32 (R8)
; remoteHost start address is: 28 (R7)
LDRB	R4, [R7, #0]
MOVW	R1, #lo_addr(_dyna+0)
MOVT	R1, #hi_addr(_dyna+0)
UXTB	R0, R4
BL	_ByteToStr+0
;Ethernet_Demo.c,208 :: 		dyna[3] = '.';
MOVS	R5, #46
MOVW	R4, #lo_addr(_dyna+3)
MOVT	R4, #hi_addr(_dyna+3)
STRB	R5, [R4, #0]
;Ethernet_Demo.c,209 :: 		ByteToStr(remoteHost[1], dyna + 4);            // second
ADDS	R4, R7, #1
LDRB	R4, [R4, #0]
MOVW	R1, #lo_addr(_dyna+4)
MOVT	R1, #hi_addr(_dyna+4)
UXTB	R0, R4
BL	_ByteToStr+0
;Ethernet_Demo.c,210 :: 		dyna[7] = '.';
MOVS	R5, #46
MOVW	R4, #lo_addr(_dyna+7)
MOVT	R4, #hi_addr(_dyna+7)
STRB	R5, [R4, #0]
;Ethernet_Demo.c,211 :: 		ByteToStr(remoteHost[2], dyna + 8);            // third
ADDS	R4, R7, #2
LDRB	R4, [R4, #0]
MOVW	R1, #lo_addr(_dyna+8)
MOVT	R1, #hi_addr(_dyna+8)
UXTB	R0, R4
BL	_ByteToStr+0
;Ethernet_Demo.c,212 :: 		dyna[11] = '.';
MOVS	R5, #46
MOVW	R4, #lo_addr(_dyna+11)
MOVT	R4, #hi_addr(_dyna+11)
STRB	R5, [R4, #0]
;Ethernet_Demo.c,213 :: 		ByteToStr(remoteHost[3], dyna + 12);           // fourth
ADDS	R4, R7, #3
; remoteHost end address is: 28 (R7)
LDRB	R4, [R4, #0]
MOVW	R1, #lo_addr(_dyna+12)
MOVT	R1, #hi_addr(_dyna+12)
UXTB	R0, R4
BL	_ByteToStr+0
;Ethernet_Demo.c,214 :: 		dyna[15] = ':';                                // add separator
MOVS	R5, #58
MOVW	R4, #lo_addr(_dyna+15)
MOVT	R4, #hi_addr(_dyna+15)
STRB	R5, [R4, #0]
;Ethernet_Demo.c,217 :: 		WordToStr(remotePort, dyna + 16);
MOVW	R1, #lo_addr(_dyna+16)
MOVT	R1, #hi_addr(_dyna+16)
UXTH	R0, R8
; remotePort end address is: 32 (R8)
BL	_WordToStr+0
;Ethernet_Demo.c,218 :: 		dyna[21] = '[';
MOVS	R5, #91
MOVW	R4, #lo_addr(_dyna+21)
MOVT	R4, #hi_addr(_dyna+21)
STRB	R5, [R4, #0]
;Ethernet_Demo.c,219 :: 		WordToStr(destPort, dyna + 22);
MOVW	R1, #lo_addr(_dyna+22)
MOVT	R1, #hi_addr(_dyna+22)
UXTH	R0, R9
; destPort end address is: 36 (R9)
BL	_WordToStr+0
;Ethernet_Demo.c,220 :: 		dyna[27] = ']';
MOVS	R5, #93
MOVW	R4, #lo_addr(_dyna+27)
MOVT	R4, #hi_addr(_dyna+27)
STRB	R5, [R4, #0]
;Ethernet_Demo.c,221 :: 		dyna[28] = 0;
MOVS	R5, #0
MOVW	R4, #lo_addr(_dyna+28)
MOVT	R4, #hi_addr(_dyna+28)
STRB	R5, [R4, #0]
;Ethernet_Demo.c,224 :: 		len = 28 + reqLength;
ADDW	R3, R6, #28
UXTH	R3, R3
; len start address is: 12 (R3)
;Ethernet_Demo.c,227 :: 		Ethernet_Intern_putBytes(dyna, 28);
STRH	R3, [SP, #4]
MOVS	R1, #28
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_Ethernet_Intern_putBytes+0
; len end address is: 12 (R3)
LDRH	R3, [SP, #4]
UXTH	R0, R6
;Ethernet_Demo.c,230 :: 		while(reqLength--)
L_Ethernet_Intern_UserUDP20:
; len start address is: 12 (R3)
; reqLength start address is: 0 (R0)
UXTH	R5, R0
SUBS	R4, R0, #1
; reqLength end address is: 0 (R0)
; reqLength start address is: 24 (R6)
UXTH	R6, R4
; reqLength end address is: 24 (R6)
CMP	R5, #0
IT	EQ
BEQ	L_Ethernet_Intern_UserUDP21
; reqLength end address is: 24 (R6)
;Ethernet_Demo.c,232 :: 		tmp = Ethernet_Intern_getByte();
; reqLength start address is: 24 (R6)
BL	_Ethernet_Intern_getByte+0
;Ethernet_Demo.c,233 :: 		Ethernet_Intern_putByte(toupper(tmp));
BL	_toupper+0
BL	_Ethernet_Intern_putByte+0
;Ethernet_Demo.c,234 :: 		}
UXTH	R0, R6
; reqLength end address is: 24 (R6)
IT	AL
BAL	L_Ethernet_Intern_UserUDP20
L_Ethernet_Intern_UserUDP21:
;Ethernet_Demo.c,236 :: 		return(len);           // back to the library with the length of the UDP reply
UXTH	R0, R3
; len end address is: 12 (R3)
;Ethernet_Demo.c,237 :: 		}
L_end_Ethernet_Intern_UserUDP:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _Ethernet_Intern_UserUDP
_main:
;Ethernet_Demo.c,239 :: 		void main() {
;Ethernet_Demo.c,241 :: 		GPIO_Digital_Input(&GPIOD_BASE, _GPIO_PINMASK_ALL);
MOVW	R1, #65535
MOVW	R0, #lo_addr(GPIOD_BASE+0)
MOVT	R0, #hi_addr(GPIOD_BASE+0)
BL	_GPIO_Digital_Input+0
;Ethernet_Demo.c,242 :: 		GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_ALL);
MOVW	R1, #65535
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
;Ethernet_Demo.c,243 :: 		UART1_Init(9600);
MOVW	R0, #9600
BL	_UART1_Init+0
;Ethernet_Demo.c,245 :: 		ADC1_Init();
BL	_ADC1_Init+0
;Ethernet_Demo.c,246 :: 		ADC_Set_Input_Channel(_ADC_CHANNEL_3);
MOVW	R0, #8
BL	_ADC_Set_Input_Channel+0
;Ethernet_Demo.c,248 :: 		Ethernet_Intern_Init(myMacAddr, myIpAddr, _ETHERNET_AUTO_NEGOTIATION, &_GPIO_MODULE_ETHERNET);
MOVW	R3, #lo_addr(__GPIO_MODULE_ETHERNET+0)
MOVT	R3, #hi_addr(__GPIO_MODULE_ETHERNET+0)
MOVS	R2, #16
MOVW	R1, #lo_addr(_myIpAddr+0)
MOVT	R1, #hi_addr(_myIpAddr+0)
MOVW	R0, #lo_addr(_myMacAddr+0)
MOVT	R0, #hi_addr(_myMacAddr+0)
BL	_Ethernet_Intern_Init+0
;Ethernet_Demo.c,249 :: 		Ethernet_Intern_confNetwork(ipMask, gwIpAddr, dnsIpAddr);
MOVW	R2, #lo_addr(_dnsIpAddr+0)
MOVT	R2, #hi_addr(_dnsIpAddr+0)
MOVW	R1, #lo_addr(_gwIpAddr+0)
MOVT	R1, #hi_addr(_gwIpAddr+0)
MOVW	R0, #lo_addr(_ipMask+0)
MOVT	R0, #hi_addr(_ipMask+0)
BL	_Ethernet_Intern_confNetwork+0
;Ethernet_Demo.c,250 :: 		UART1_Write_Text("Program Starting ...\n\r");
MOVW	R0, #lo_addr(?lstr16_Ethernet_Demo+0)
MOVT	R0, #hi_addr(?lstr16_Ethernet_Demo+0)
BL	_UART1_Write_Text+0
;Ethernet_Demo.c,251 :: 		Start_TP();
BL	_Start_TP+0
;Ethernet_Demo.c,253 :: 		while(1) {
L_main22:
;Ethernet_Demo.c,257 :: 		Ethernet_Intern_doPacket();   // process incoming Ethernet packets
BL	_Ethernet_Intern_doPacket+0
;Ethernet_Demo.c,264 :: 		}
IT	AL
BAL	L_main22
;Ethernet_Demo.c,266 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
