
;CodeVisionAVR C Compiler V3.52 
;(C) Copyright 1998-2023 Pavel Haiduc, HP InfoTech S.R.L.
;http://www.hpinfotech.ro

;Build configuration    : Debug
;Chip type              : ATmega16
;Program type           : Application
;Clock frequency        : 8.000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 256 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': Yes
;'char' is unsigned     : Yes
;8 bit enums            : Yes
;Global 'const' stored in FLASH: No
;Enhanced function parameter passing: Mode 2
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#define _MODEL_SMALL_

	#pragma AVRPART ADMIN PART_NAME ATmega16
	#pragma AVRPART MEMORY PROG_FLASH 16384
	#pragma AVRPART MEMORY EEPROM 512
	#pragma AVRPART MEMORY INT_SRAM SIZE 1024
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x60

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU SPMCSR=0x37
	.EQU GICR=0x3B
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0060
	.EQU __SRAM_END=0x045F
	.EQU __DSTACK_SIZE=0x0100
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.EQU __FLASH_PAGE_SIZE=0x40

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETW1P
	LD   R30,X+
	LD   R31,X
	SBIW R26,1
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __GETD1P_INC
	LD   R30,X+
	LD   R31,X+
	LD   R22,X+
	LD   R23,X+
	.ENDM

	.MACRO __GETD1P_DEC
	LD   R23,-X
	LD   R22,-X
	LD   R31,-X
	LD   R30,-X
	.ENDM

	.MACRO __PUTDP1
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __PUTDP1_DEC
	ST   -X,R23
	ST   -X,R22
	ST   -X,R31
	ST   -X,R30
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __CPD10
	SBIW R30,0
	SBCI R22,0
	SBCI R23,0
	.ENDM

	.MACRO __CPD20
	SBIW R26,0
	SBCI R24,0
	SBCI R25,0
	.ENDM

	.MACRO __ADDD12
	ADD  R30,R26
	ADC  R31,R27
	ADC  R22,R24
	ADC  R23,R25
	.ENDM

	.MACRO __ADDD21
	ADD  R26,R30
	ADC  R27,R31
	ADC  R24,R22
	ADC  R25,R23
	.ENDM

	.MACRO __SUBD12
	SUB  R30,R26
	SBC  R31,R27
	SBC  R22,R24
	SBC  R23,R25
	.ENDM

	.MACRO __SUBD21
	SUB  R26,R30
	SBC  R27,R31
	SBC  R24,R22
	SBC  R25,R23
	.ENDM

	.MACRO __ANDD12
	AND  R30,R26
	AND  R31,R27
	AND  R22,R24
	AND  R23,R25
	.ENDM

	.MACRO __ORD12
	OR   R30,R26
	OR   R31,R27
	OR   R22,R24
	OR   R23,R25
	.ENDM

	.MACRO __XORD12
	EOR  R30,R26
	EOR  R31,R27
	EOR  R22,R24
	EOR  R23,R25
	.ENDM

	.MACRO __XORD21
	EOR  R26,R30
	EOR  R27,R31
	EOR  R24,R22
	EOR  R25,R23
	.ENDM

	.MACRO __COMD1
	COM  R30
	COM  R31
	COM  R22
	COM  R23
	.ENDM

	.MACRO __MULD2_2
	LSL  R26
	ROL  R27
	ROL  R24
	ROL  R25
	.ENDM

	.MACRO __LSRD1
	LSR  R23
	ROR  R22
	ROR  R31
	ROR  R30
	.ENDM

	.MACRO __LSLD1
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R23
	.ENDM

	.MACRO __ASRB4
	ASR  R30
	ASR  R30
	ASR  R30
	ASR  R30
	.ENDM

	.MACRO __ASRW8
	MOV  R30,R31
	CLR  R31
	SBRC R30,7
	SER  R31
	.ENDM

	.MACRO __LSRD16
	MOV  R30,R22
	MOV  R31,R23
	LDI  R22,0
	LDI  R23,0
	.ENDM

	.MACRO __LSLD16
	MOV  R22,R30
	MOV  R23,R31
	LDI  R30,0
	LDI  R31,0
	.ENDM

	.MACRO __CWD1
	MOV  R22,R31
	ADD  R22,R22
	SBC  R22,R22
	MOV  R23,R22
	.ENDM

	.MACRO __CWD2
	MOV  R24,R27
	ADD  R24,R24
	SBC  R24,R24
	MOV  R25,R24
	.ENDM

	.MACRO __SETMSD1
	SER  R31
	SER  R22
	SER  R23
	.ENDM

	.MACRO __ADDW1R15
	CLR  R0
	ADD  R30,R15
	ADC  R31,R0
	.ENDM

	.MACRO __ADDW2R15
	CLR  R0
	ADD  R26,R15
	ADC  R27,R0
	.ENDM

	.MACRO __EQB12
	CP   R30,R26
	LDI  R30,1
	BREQ PC+2
	CLR  R30
	.ENDM

	.MACRO __NEB12
	CP   R30,R26
	LDI  R30,1
	BRNE PC+2
	CLR  R30
	.ENDM

	.MACRO __LEB12
	CP   R30,R26
	LDI  R30,1
	BRGE PC+2
	CLR  R30
	.ENDM

	.MACRO __GEB12
	CP   R26,R30
	LDI  R30,1
	BRGE PC+2
	CLR  R30
	.ENDM

	.MACRO __LTB12
	CP   R26,R30
	LDI  R30,1
	BRLT PC+2
	CLR  R30
	.ENDM

	.MACRO __GTB12
	CP   R30,R26
	LDI  R30,1
	BRLT PC+2
	CLR  R30
	.ENDM

	.MACRO __LEB12U
	CP   R30,R26
	LDI  R30,1
	BRSH PC+2
	CLR  R30
	.ENDM

	.MACRO __GEB12U
	CP   R26,R30
	LDI  R30,1
	BRSH PC+2
	CLR  R30
	.ENDM

	.MACRO __LTB12U
	CP   R26,R30
	LDI  R30,1
	BRLO PC+2
	CLR  R30
	.ENDM

	.MACRO __GTB12U
	CP   R30,R26
	LDI  R30,1
	BRLO PC+2
	CLR  R30
	.ENDM

	.MACRO __CPW01
	CLR  R0
	CP   R0,R30
	CPC  R0,R31
	.ENDM

	.MACRO __CPW02
	CLR  R0
	CP   R0,R26
	CPC  R0,R27
	.ENDM

	.MACRO __CPD12
	CP   R30,R26
	CPC  R31,R27
	CPC  R22,R24
	CPC  R23,R25
	.ENDM

	.MACRO __CPD21
	CP   R26,R30
	CPC  R27,R31
	CPC  R24,R22
	CPC  R25,R23
	.ENDM

	.MACRO __BSTB1
	CLT
	TST  R30
	BREQ PC+2
	SET
	.ENDM

	.MACRO __LNEGB1
	TST  R30
	LDI  R30,1
	BREQ PC+2
	CLR  R30
	.ENDM

	.MACRO __LNEGW1
	OR   R30,R31
	LDI  R30,1
	BREQ PC+2
	LDI  R30,0
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD2M
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	PUSH R26
	PUSH R27
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	POP  R27
	POP  R26
	ICALL
	.ENDM

	.MACRO __CALL2EX
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __EEPROMRDD
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z
	MOVW R30,R0
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	CALL __GETW1Z
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	CALL __GETD1Z
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __GETW2X
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __GETD2X
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _storedPassword=R4
	.DEF _storedPassword_msb=R5
	.DEF _OldPassword=R6
	.DEF _OldPassword_msb=R7
	.DEF _NewPassword=R8
	.DEF _NewPassword_msb=R9
	.DEF _ReenterNewPassword=R10
	.DEF _ReenterNewPassword_msb=R11
	.DEF _ChangeAdminPasswords=R12
	.DEF _ChangeAdminPasswords_msb=R13

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  _ext0
	JMP  _ext1
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

_tbl10_G103:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G103:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

;GLOBAL REGISTER VARIABLES INITIALIZATION
__REG_VARS:
	.DB  0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0
	.DB  0x0,0x0

_0x0:
	.DB  0x50,0x72,0x65,0x73,0x73,0x20,0x2A,0x20
	.DB  0x74,0x6F,0x20,0x65,0x6E,0x74,0x65,0x72
	.DB  0x0,0x45,0x6E,0x74,0x65,0x72,0x65,0x64
	.DB  0x20,0x49,0x44,0x3A,0x0,0x25,0x75,0x0
	.DB  0x45,0x6E,0x74,0x65,0x72,0x20,0x50,0x61
	.DB  0x73,0x73,0x77,0x6F,0x72,0x64,0x3A,0xA
	.DB  0x0,0x59,0x6F,0x75,0x20,0x61,0x72,0x65
	.DB  0x20,0x41,0x64,0x6D,0x69,0x6E,0x0,0x57
	.DB  0x65,0x6C,0x63,0x6F,0x6D,0x65,0x21,0x0
	.DB  0x50,0x72,0x6F,0x66,0x0,0x44,0x6F,0x6F
	.DB  0x72,0x20,0x69,0x73,0x20,0x6F,0x70,0x65
	.DB  0x6E,0x69,0x6E,0x67,0x0,0x50,0x72,0x65
	.DB  0x73,0x73,0x20,0x23,0x20,0x74,0x6F,0x20
	.DB  0x45,0x78,0x69,0x74,0x0,0x4D,0x69,0x6E
	.DB  0x61,0x0,0x41,0x62,0x64,0x6F,0x0,0x53
	.DB  0x61,0x6C,0x61,0x68,0x0,0x5A,0x61,0x6B
	.DB  0x69,0x0,0x57,0x72,0x6F,0x6E,0x67,0x20
	.DB  0x70,0x61,0x73,0x73,0x77,0x6F,0x72,0x64
	.DB  0x0,0x49,0x6E,0x76,0x61,0x6C,0x69,0x64
	.DB  0x20,0x49,0x44,0x0,0x45,0x6E,0x74,0x65
	.DB  0x72,0x5F,0x49,0x44,0x0,0x45,0x6E,0x74
	.DB  0x65,0x72,0x20,0x4F,0x6C,0x64,0x2D,0x50
	.DB  0x43,0x0,0x45,0x6E,0x74,0x65,0x72,0x20
	.DB  0x4E,0x65,0x77,0x2D,0x50,0x43,0x0,0x52
	.DB  0x65,0x2D,0x65,0x6E,0x74,0x65,0x72,0x20
	.DB  0x50,0x43,0x0,0x43,0x68,0x61,0x6E,0x67
	.DB  0x65,0x0,0x53,0x75,0x63,0x63,0x65,0x73
	.DB  0x73,0x66,0x75,0x6C,0x6C,0x79,0x0,0x45
	.DB  0x6E,0x74,0x65,0x72,0x20,0x50,0x43,0x3A
	.DB  0x20,0x0,0x45,0x6E,0x74,0x65,0x72,0x2D
	.DB  0x6E,0x65,0x77,0x20,0x50,0x43,0x3A,0x20
	.DB  0x0
_0x2000003:
	.DB  0x80,0xC0
_0x2020060:
	.DB  0x1
_0x2020000:
	.DB  0x2D,0x4E,0x41,0x4E,0x0,0x49,0x4E,0x46
	.DB  0x0

__GLOBAL_INI_TBL:
	.DW  0x0A
	.DW  0x04
	.DW  __REG_VARS*2

	.DW  0x02
	.DW  __base_y_G100
	.DW  _0x2000003*2

	.DW  0x01
	.DW  __seed_G101
	.DW  _0x2020060*2

_0xFFFFFFFF:
	.DW  0

#define __GLOBAL_INI_TBL_PRESENT 1

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  GICR,R31
	OUT  GICR,R30
	OUT  MCUCR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,__SRAM_START
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0x00

	.DSEG
	.ORG 0x160

	.CSEG
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;char keypad();
;void ChangePasswordUser();
;void ChangePasswordAdmin();
;void EE_Write(unsigned int add, unsigned char data);
;unsigned char EE_Read(unsigned int add);
;void initializeEEPROM()
; 0000 001E {

	.CSEG
_initializeEEPROM:
; .FSTART _initializeEEPROM
; 0000 001F // Function to initialize EEPROM with default values
; 0000 0020 // Default passwords
; 0000 0021 unsigned int defaultPassword1 = 203;
; 0000 0022 unsigned int defaultPassword2 = 129;
; 0000 0023 unsigned int defaultPassword3 = 700;
; 0000 0024 unsigned int defaultPassword4 = 426;
; 0000 0025 unsigned int defaultPassword5 = 79;
; 0000 0026 // Writing default passwords to specific EEPROM addresses
; 0000 0027 EE_Write(111, defaultPassword1 % 255);
	SBIW R28,4
	LDI  R30,LOW(79)
	ST   Y,R30
	LDI  R30,LOW(0)
	STD  Y+1,R30
	LDI  R30,LOW(170)
	STD  Y+2,R30
	LDI  R30,LOW(1)
	STD  Y+3,R30
	RCALL __SAVELOCR6
;	defaultPassword1 -> R16,R17
;	defaultPassword2 -> R18,R19
;	defaultPassword3 -> R20,R21
;	defaultPassword4 -> Y+8
;	defaultPassword5 -> Y+6
	__GETWRN 16,17,203
	__GETWRN 18,19,129
	__GETWRN 20,21,700
	LDI  R30,LOW(111)
	LDI  R31,HIGH(111)
	RCALL SUBOPT_0x0
	RCALL __MODW21U
	MOV  R26,R30
	RCALL _EE_Write
; 0000 0028 EE_Write(112, defaultPassword1 / 255);
	LDI  R30,LOW(112)
	LDI  R31,HIGH(112)
	RCALL SUBOPT_0x0
	RCALL __DIVW21U
	MOV  R26,R30
	RCALL _EE_Write
; 0000 0029 EE_Write(126, defaultPassword2 % 255);
	LDI  R30,LOW(126)
	LDI  R31,HIGH(126)
	RCALL SUBOPT_0x1
	RCALL __MODW21U
	MOV  R26,R30
	RCALL _EE_Write
; 0000 002A EE_Write(127, defaultPassword2 / 255);
	LDI  R30,LOW(127)
	LDI  R31,HIGH(127)
	RCALL SUBOPT_0x1
	RCALL __DIVW21U
	MOV  R26,R30
	RCALL _EE_Write
; 0000 002B EE_Write(128, defaultPassword3 % 255);
	LDI  R30,LOW(128)
	LDI  R31,HIGH(128)
	RCALL SUBOPT_0x2
	RCALL __MODW21U
	MOV  R26,R30
	RCALL _EE_Write
; 0000 002C EE_Write(129, defaultPassword3 / 255);
	LDI  R30,LOW(129)
	LDI  R31,HIGH(129)
	RCALL SUBOPT_0x2
	RCALL __DIVW21U
	MOV  R26,R30
	RCALL _EE_Write
; 0000 002D EE_Write(130, defaultPassword4 % 255);
	LDI  R30,LOW(130)
	LDI  R31,HIGH(130)
	RCALL SUBOPT_0x3
	RCALL __MODW21U
	MOV  R26,R30
	RCALL _EE_Write
; 0000 002E EE_Write(131, defaultPassword4 / 255);
	LDI  R30,LOW(131)
	LDI  R31,HIGH(131)
	RCALL SUBOPT_0x3
	RCALL __DIVW21U
	MOV  R26,R30
	RCALL _EE_Write
; 0000 002F EE_Write(132, defaultPassword5 % 255);
	LDI  R30,LOW(132)
	LDI  R31,HIGH(132)
	RCALL SUBOPT_0x4
	RCALL __MODW21U
	MOV  R26,R30
	RCALL _EE_Write
; 0000 0030 EE_Write(133, defaultPassword5 / 255);
	LDI  R30,LOW(133)
	LDI  R31,HIGH(133)
	RCALL SUBOPT_0x4
	RCALL __DIVW21U
	MOV  R26,R30
	RCALL _EE_Write
; 0000 0031 // Add more passwords if needed
; 0000 0032 }
	RCALL __LOADLOCR6
	ADIW R28,10
	RET
; .FEND
;void main(void)
; 0000 0035 {
_main:
; .FSTART _main
; 0000 0036 // Setting Port C for keypad input and output configurations
; 0000 0037 DDRC = 0b00000111; // 1 pin unused, 4 rows (input), 3 columns (output)
	LDI  R30,LOW(7)
	OUT  0x14,R30
; 0000 0038 // Setting internal pull-up resistances for keypad pins
; 0000 0039 PORTC = 0b11111000; // pull-up  resistance  to avoid floating  for keypad
	LDI  R30,LOW(248)
	OUT  0x15,R30
; 0000 003A // Setting direction and initial state for different pins on Port D
; 0000 003B DDRD.2 = 0;      // Configuring INT0 (Admin) as input
	CBI  0x11,2
; 0000 003C PORTD.2 = 1;    // Enabling pull-up resistor for INT0
	SBI  0x12,2
; 0000 003D DDRD.3 = 0;     // Configuring INT1 (Set PC for user) as input
	CBI  0x11,3
; 0000 003E PORTD.3 = 1;    // Enabling pull-up resistor for INT1
	SBI  0x12,3
; 0000 003F DDRD.1 = 1;    // Configuring Motor pin as output
	SBI  0x11,1
; 0000 0040 PORTD.1 = 0;   // Setting Motor pin to LOW initially
	CBI  0x12,1
; 0000 0041 DDRD.5 = 1;   // Configuring Alarm pin as output
	SBI  0x11,5
; 0000 0042 PORTD.5 = 0;  // Setting Alarm pin to LOW initially
	CBI  0x12,5
; 0000 0043 // Setting up External Interrupt 0 (INT0)
; 0000 0044 bit_set(MCUCR, 1);  //MCUCR |= (1<<1)
	IN   R30,0x35
	ORI  R30,2
	OUT  0x35,R30
; 0000 0045 bit_clr(MCUCR, 0);  //MCUCR &= ~(1<<0)
	IN   R30,0x35
	ANDI R30,0xFE
	OUT  0x35,R30
; 0000 0046 // Setting up External Interrupt 1 (INT1)
; 0000 0047 bit_set(MCUCR, 3);
	IN   R30,0x35
	ORI  R30,8
	OUT  0x35,R30
; 0000 0048 bit_clr(MCUCR, 2);
	IN   R30,0x35
	ANDI R30,0xFB
	OUT  0x35,R30
; 0000 0049 #asm("sei");      // Set Enable Interrupt (Global Interrupt Enable)
	SEI
; 0000 004A bit_set(GICR, 6);  // Enable external interrupt 0 (INT0)
	IN   R30,0x3B
	ORI  R30,0x40
	OUT  0x3B,R30
; 0000 004B bit_set(GICR, 7);   // Enable external interrupt 1 (INT1)
	IN   R30,0x3B
	ORI  R30,0x80
	OUT  0x3B,R30
; 0000 004C lcd_init(16);      // Important to initialize the LCD, Give it the number of characters per line
	LDI  R26,LOW(16)
	RCALL _lcd_init
; 0000 004D initializeEEPROM(); // Initialize EEPROM with default values  (call only once for  initializing)
	RCALL _initializeEEPROM
; 0000 004E while (1)
_0x13:
; 0000 004F {
; 0000 0050 // Application code loop
; 0000 0051 //Please write your application code here
; 0000 0052 
; 0000 0053 // Display message prompting for '*' key entry
; 0000 0054 lcd_clear();
	RCALL SUBOPT_0x5
; 0000 0055 lcd_printf("Press * to enter");
; 0000 0056 // Wait until '*' key is pressed
; 0000 0057 while (keypad() != 10);
_0x16:
	RCALL _keypad
	CPI  R30,LOW(0xA)
	BRNE _0x16
; 0000 0058 lcd_clear();
	RCALL SUBOPT_0x6
; 0000 0059 // Clear LCD and display "Entered ID:"
; 0000 005A lcd_printf("Entered ID:");
; 0000 005B // Reading ID digits from keypad input
; 0000 005C id1 = keypad();
	RCALL SUBOPT_0x7
; 0000 005D id2 = keypad();
; 0000 005E id3 = keypad();
; 0000 005F enteredID = id3 + (id2 * 10) + (id1 * 100);
	STS  _enteredID,R30
	STS  _enteredID+1,R31
; 0000 0060 lcd_gotoxy(0, 1);
	RCALL SUBOPT_0x8
; 0000 0061 // Display entered ID on the LCD
; 0000 0062 lcd_printf("%u", enteredID);
	RCALL SUBOPT_0x9
	LDS  R30,_enteredID
	LDS  R31,_enteredID+1
	RCALL SUBOPT_0xA
; 0000 0063 delay_ms(1000);
	LDI  R26,LOW(1000)
	LDI  R27,HIGH(1000)
	RCALL _delay_ms
; 0000 0064 //lcd_clear();
; 0000 0065 // Check entered ID and process accordingly
; 0000 0066 // Check if the enteredID matches predefined IDs
; 0000 0067 if (enteredID == 111 || enteredID == 126 || enteredID == 128 || enteredID == 130 || enteredID == 132 )    // enteredID == 111 || enteredID == 222 || enteredID == 333 || enteredID == 444 || enteredID == 555
	RCALL SUBOPT_0xB
	CPI  R26,LOW(0x6F)
	LDI  R30,HIGH(0x6F)
	CPC  R27,R30
	BREQ _0x1A
	RCALL SUBOPT_0xC
	BREQ _0x1A
	RCALL SUBOPT_0xD
	BREQ _0x1A
	RCALL SUBOPT_0xE
	BREQ _0x1A
	RCALL SUBOPT_0xF
	BREQ _0x1A
	RJMP _0x19
_0x1A:
; 0000 0068 {
; 0000 0069 // Clear the LCD and prompt for password entry
; 0000 006A lcd_clear();
	RCALL _lcd_clear
; 0000 006B lcd_printf("Enter Password:\n");
	__POINTW1FN _0x0,32
	RCALL SUBOPT_0x10
; 0000 006C lcd_gotoxy(0, 1);
	RCALL SUBOPT_0x8
; 0000 006D // Read the three digits of the password from the keypad
; 0000 006E pass1 = keypad();
	RCALL _keypad
	LDI  R31,0
	STS  _pass1,R30
	STS  _pass1+1,R31
; 0000 006F pass2 = keypad();
	RCALL _keypad
	LDI  R31,0
	STS  _pass2,R30
	STS  _pass2+1,R31
; 0000 0070 pass3 = keypad();
	RCALL _keypad
	LDI  R31,0
	STS  _pass3,R30
	STS  _pass3+1,R31
; 0000 0071 // Combine the entered password digits into a single password value
; 0000 0072 password = (pass1 * 100) + (pass2 * 10) + (pass3 * 1);
	LDS  R26,_pass1
	LDS  R27,_pass1+1
	LDI  R30,LOW(100)
	CALL __MULB1W2U
	__PUTW1R 23,24
	LDS  R26,_pass2
	LDS  R27,_pass2+1
	LDI  R30,LOW(10)
	CALL __MULB1W2U
	__ADDWRR 23,24,30,31
	LDS  R26,_pass3
	LDS  R27,_pass3+1
	LDI  R30,LOW(1)
	CALL __MULB1W2U
	ADD  R30,R23
	ADC  R31,R24
	STS  _password,R30
	STS  _password+1,R31
; 0000 0073 lcd_printf("%u", password);
	RCALL SUBOPT_0x9
	LDS  R30,_password
	LDS  R31,_password+1
	RCALL SUBOPT_0xA
; 0000 0074 // Retrieve stored password from EEPROM based on enteredID
; 0000 0075 storedPassword = EE_Read(enteredID);
	RCALL SUBOPT_0xB
	RCALL _EE_Read
	MOV  R4,R30
	CLR  R5
; 0000 0076 storedPassword = storedPassword + (EE_Read(enteredID + 1) * 255);
	RCALL SUBOPT_0xB
	RCALL SUBOPT_0x11
; 0000 0077 //lcd_printf("%u", storedPassword);
; 0000 0078 delay_ms(1000);
	LDI  R26,LOW(1000)
	LDI  R27,HIGH(1000)
	RCALL _delay_ms
; 0000 0079 // Check if the entered password matches the stored password for a specific enteredID
; 0000 007A if (password == storedPassword && enteredID == 111)
	RCALL SUBOPT_0x12
	BRNE _0x1D
	RCALL SUBOPT_0xB
	CPI  R26,LOW(0x6F)
	LDI  R30,HIGH(0x6F)
	CPC  R27,R30
	BREQ _0x1E
_0x1D:
	RJMP _0x1C
_0x1E:
; 0000 007B {
; 0000 007C // Display admin authentication message
; 0000 007D lcd_clear();
	RCALL SUBOPT_0x13
; 0000 007E lcd_printf("You are Admin");
; 0000 007F delay_ms(1000);
	RCALL SUBOPT_0x14
; 0000 0080 lcd_clear();
; 0000 0081 lcd_gotoxy(5, 0);
	RCALL SUBOPT_0x15
; 0000 0082 // (Code for displaying admin welcome message and actions)
; 0000 0083 lcd_printf("Welcome!");
; 0000 0084 lcd_gotoxy(7, 1);
	RCALL SUBOPT_0x16
; 0000 0085 lcd_printf("Prof");
	__POINTW1FN _0x0,72
	RCALL SUBOPT_0x10
; 0000 0086 delay_ms(1000);
	RCALL SUBOPT_0x14
; 0000 0087 lcd_clear();
; 0000 0088 PORTD.1 = 1;
	SBI  0x12,1
; 0000 0089 lcd_printf("Door is opening");
	__POINTW1FN _0x0,77
	RCALL SUBOPT_0x10
; 0000 008A lcd_gotoxy(0, 1);
	RCALL SUBOPT_0x8
; 0000 008B lcd_clear();
	RCALL SUBOPT_0x5
; 0000 008C lcd_printf("Press * to enter");
; 0000 008D lcd_gotoxy(0, 1);
	RCALL SUBOPT_0x8
; 0000 008E lcd_printf("Press # to Exit");
	__POINTW1FN _0x0,93
	RCALL SUBOPT_0x10
; 0000 008F delay_ms(1000);
	RCALL SUBOPT_0x17
; 0000 0090 if(  keypad() == 10){
	BRNE _0x21
; 0000 0091 
; 0000 0092 lcd_clear();
	RCALL _lcd_clear
; 0000 0093 ChangePasswordAdmin();
	RCALL _ChangePasswordAdmin
; 0000 0094 } else{
	RJMP _0x22
_0x21:
; 0000 0095 lcd_clear();
	RCALL _lcd_clear
; 0000 0096 PORTD.1 = 0;
	CBI  0x12,1
; 0000 0097 continue;
	RJMP _0x13
; 0000 0098 }
_0x22:
; 0000 0099 }
; 0000 009A else if (password == storedPassword && enteredID == 126)
	RJMP _0x25
_0x1C:
	RCALL SUBOPT_0x12
	BRNE _0x27
	RCALL SUBOPT_0xC
	BREQ _0x28
_0x27:
	RJMP _0x26
_0x28:
; 0000 009B {
; 0000 009C // Display user authentication message for ID 126
; 0000 009D lcd_clear();
	RCALL _lcd_clear
; 0000 009E lcd_gotoxy(5, 0);
	RCALL SUBOPT_0x15
; 0000 009F // (Code for displaying user welcome message and actions for ID 126)
; 0000 00A0 lcd_printf("Welcome!");
; 0000 00A1 lcd_gotoxy(7, 1);
	RCALL SUBOPT_0x16
; 0000 00A2 lcd_printf("Mina");
	__POINTW1FN _0x0,109
	RCALL SUBOPT_0x10
; 0000 00A3 delay_ms(1000);
	RCALL SUBOPT_0x14
; 0000 00A4 lcd_clear();
; 0000 00A5 lcd_printf("Door is opening");
	__POINTW1FN _0x0,77
	RCALL SUBOPT_0x10
; 0000 00A6 PORTD.1 = 1;
	SBI  0x12,1
; 0000 00A7 lcd_clear();
	RCALL SUBOPT_0x5
; 0000 00A8 lcd_printf("Press * to enter");
; 0000 00A9 lcd_gotoxy(0, 1);
	RCALL SUBOPT_0x8
; 0000 00AA lcd_printf("Press # to Exit");
	__POINTW1FN _0x0,93
	RCALL SUBOPT_0x10
; 0000 00AB delay_ms(1000);
	RCALL SUBOPT_0x17
; 0000 00AC if(  keypad() == 10){
	BRNE _0x2B
; 0000 00AD lcd_clear();
	RCALL _lcd_clear
; 0000 00AE ChangePasswordUser()  ;
	RCALL _ChangePasswordUser
; 0000 00AF 
; 0000 00B0 } else{
	RJMP _0x2C
_0x2B:
; 0000 00B1 lcd_clear();
	RCALL _lcd_clear
; 0000 00B2 PORTD.1 = 0;
	CBI  0x12,1
; 0000 00B3 continue;
	RJMP _0x13
; 0000 00B4 }
_0x2C:
; 0000 00B5 }
; 0000 00B6 else if (password == storedPassword && enteredID == 128)
	RJMP _0x2F
_0x26:
	RCALL SUBOPT_0x12
	BRNE _0x31
	RCALL SUBOPT_0xD
	BREQ _0x32
_0x31:
	RJMP _0x30
_0x32:
; 0000 00B7 {
; 0000 00B8 lcd_clear();
	RCALL _lcd_clear
; 0000 00B9 lcd_gotoxy(5, 0);
	RCALL SUBOPT_0x15
; 0000 00BA lcd_printf("Welcome!");
; 0000 00BB lcd_gotoxy(7, 1);
	RCALL SUBOPT_0x16
; 0000 00BC lcd_printf("Abdo");
	__POINTW1FN _0x0,114
	RCALL SUBOPT_0x10
; 0000 00BD delay_ms(1000);
	RCALL SUBOPT_0x14
; 0000 00BE lcd_clear();
; 0000 00BF lcd_printf("Door is opening");
	__POINTW1FN _0x0,77
	RCALL SUBOPT_0x10
; 0000 00C0 PORTD.1 = 1;
	SBI  0x12,1
; 0000 00C1 lcd_clear();
	RCALL SUBOPT_0x5
; 0000 00C2 lcd_printf("Press * to enter");
; 0000 00C3 lcd_gotoxy(0, 1);
	RCALL SUBOPT_0x8
; 0000 00C4 lcd_printf("Press # to Exit");
	__POINTW1FN _0x0,93
	RCALL SUBOPT_0x10
; 0000 00C5 delay_ms(1000);
	RCALL SUBOPT_0x17
; 0000 00C6 if(  keypad() == 10){
	BRNE _0x35
; 0000 00C7 lcd_clear();
	RCALL _lcd_clear
; 0000 00C8 ChangePasswordUser()  ;
	RCALL _ChangePasswordUser
; 0000 00C9 
; 0000 00CA } else{
	RJMP _0x36
_0x35:
; 0000 00CB lcd_clear();
	RCALL _lcd_clear
; 0000 00CC PORTD.1 = 0;
	CBI  0x12,1
; 0000 00CD continue;
	RJMP _0x13
; 0000 00CE }
_0x36:
; 0000 00CF }
; 0000 00D0 else if (password == storedPassword && enteredID == 130)
	RJMP _0x39
_0x30:
	RCALL SUBOPT_0x12
	BRNE _0x3B
	RCALL SUBOPT_0xE
	BREQ _0x3C
_0x3B:
	RJMP _0x3A
_0x3C:
; 0000 00D1 {
; 0000 00D2 lcd_clear();
	RCALL _lcd_clear
; 0000 00D3 lcd_gotoxy(5, 0);
	RCALL SUBOPT_0x15
; 0000 00D4 lcd_printf("Welcome!");
; 0000 00D5 lcd_gotoxy(7, 1);
	RCALL SUBOPT_0x16
; 0000 00D6 lcd_printf("Salah");
	__POINTW1FN _0x0,119
	RCALL SUBOPT_0x10
; 0000 00D7 delay_ms(1000);
	RCALL SUBOPT_0x14
; 0000 00D8 lcd_clear();
; 0000 00D9 lcd_printf("Door is opening");
	__POINTW1FN _0x0,77
	RCALL SUBOPT_0x10
; 0000 00DA 
; 0000 00DB PORTD.1 = 1;
	SBI  0x12,1
; 0000 00DC lcd_clear();
	RCALL SUBOPT_0x5
; 0000 00DD lcd_printf("Press * to enter");
; 0000 00DE lcd_gotoxy(0, 1);
	RCALL SUBOPT_0x8
; 0000 00DF lcd_printf("Press # to Exit");
	__POINTW1FN _0x0,93
	RCALL SUBOPT_0x10
; 0000 00E0 delay_ms(1000);
	RCALL SUBOPT_0x17
; 0000 00E1 if(  keypad() == 10){
	BRNE _0x3F
; 0000 00E2 lcd_clear();
	RCALL _lcd_clear
; 0000 00E3 ChangePasswordUser()  ;
	RCALL _ChangePasswordUser
; 0000 00E4 
; 0000 00E5 } else{
	RJMP _0x40
_0x3F:
; 0000 00E6 lcd_clear();
	RCALL _lcd_clear
; 0000 00E7 PORTD.1 = 0;
	CBI  0x12,1
; 0000 00E8 continue;
	RJMP _0x13
; 0000 00E9 }
_0x40:
; 0000 00EA }
; 0000 00EB else if (password == storedPassword && enteredID == 132)
	RJMP _0x43
_0x3A:
	RCALL SUBOPT_0x12
	BRNE _0x45
	RCALL SUBOPT_0xF
	BREQ _0x46
_0x45:
	RJMP _0x44
_0x46:
; 0000 00EC {
; 0000 00ED lcd_clear();
	RCALL _lcd_clear
; 0000 00EE lcd_gotoxy(5, 0);
	RCALL SUBOPT_0x15
; 0000 00EF lcd_printf("Welcome!");
; 0000 00F0 lcd_gotoxy(7, 1);
	RCALL SUBOPT_0x16
; 0000 00F1 lcd_printf("Zaki");
	__POINTW1FN _0x0,125
	RCALL SUBOPT_0x10
; 0000 00F2 delay_ms(1000);
	RCALL SUBOPT_0x14
; 0000 00F3 lcd_clear();
; 0000 00F4 lcd_printf("Door is opening");
	__POINTW1FN _0x0,77
	RCALL SUBOPT_0x10
; 0000 00F5 PORTD.1 = 1;
	SBI  0x12,1
; 0000 00F6 lcd_clear();
	RCALL SUBOPT_0x5
; 0000 00F7 lcd_printf("Press * to enter");
; 0000 00F8 lcd_gotoxy(0, 1);
	RCALL SUBOPT_0x8
; 0000 00F9 lcd_printf("Press # to Exit");
	__POINTW1FN _0x0,93
	RCALL SUBOPT_0x10
; 0000 00FA delay_ms(1000);
	RCALL SUBOPT_0x17
; 0000 00FB if(  keypad() == 10){
	BRNE _0x49
; 0000 00FC lcd_clear();
	RCALL _lcd_clear
; 0000 00FD ChangePasswordUser()  ;
	RCALL _ChangePasswordUser
; 0000 00FE 
; 0000 00FF } else{
	RJMP _0x4A
_0x49:
; 0000 0100 lcd_clear();
	RCALL _lcd_clear
; 0000 0101 PORTD.1 = 0;
	CBI  0x12,1
; 0000 0102 continue;
	RJMP _0x13
; 0000 0103 }
_0x4A:
; 0000 0104 }
; 0000 0105 else
	RJMP _0x4D
_0x44:
; 0000 0106 {
; 0000 0107 lcd_clear();
	RCALL SUBOPT_0x18
; 0000 0108 lcd_printf("Wrong password");
; 0000 0109 // Activate alarm
; 0000 010A PORTD.5 = 1;
	RCALL SUBOPT_0x19
; 0000 010B delay_ms(1000);// Wait for 1 second
; 0000 010C PORTD.5 = 0;
; 0000 010D continue;   // Restart the loop to re-enter a valid password
	RJMP _0x13
; 0000 010E }
_0x4D:
_0x43:
_0x39:
_0x2F:
_0x25:
; 0000 010F }
; 0000 0110 else
	RJMP _0x52
_0x19:
; 0000 0111 {
; 0000 0112 // Handling the case of an invalid ID
; 0000 0113 lcd_clear();
	RCALL SUBOPT_0x1A
; 0000 0114 lcd_printf("Invalid ID");
; 0000 0115 // Activate alarm in a specific pattern
; 0000 0116 // (Code for activating alarm for an invalid ID)
; 0000 0117 PORTD.5 = 1;
	RCALL SUBOPT_0x19
; 0000 0118 delay_ms(1000); // Wait for 1 second
; 0000 0119 PORTD.5 = 0;
; 0000 011A delay_ms(1000);
	RCALL SUBOPT_0x1B
; 0000 011B PORTD.5 = 1;
; 0000 011C delay_ms(1000); // Wait for 1 second
; 0000 011D PORTD.5 = 0;
; 0000 011E delay_ms(1000);
	LDI  R26,LOW(1000)
	LDI  R27,HIGH(1000)
	RCALL _delay_ms
; 0000 011F continue;       // Restart the loop to re-enter a valid ID
	RJMP _0x13
; 0000 0120 }
_0x52:
; 0000 0121 
; 0000 0122 
; 0000 0123 }
	RJMP _0x13
; 0000 0124 
; 0000 0125 
; 0000 0126 }
_0x5B:
	RJMP _0x5B
; .FEND
;char keypad()
; 0000 0129 {
_keypad:
; .FSTART _keypad
; 0000 012A while (1)  // Infinite loop to continuously check keypad input
_0x5C:
; 0000 012B {
; 0000 012C // Activate column 1 and deactivate other columns
; 0000 012D PORTC.0 = 0; // column 1 is activated by 0
	CBI  0x15,0
; 0000 012E PORTC.1 = 1; // column 2 is inactive by 1
	SBI  0x15,1
; 0000 012F PORTC.2 = 1; // column 3 is inactive by 1
	SBI  0x15,2
; 0000 0130 // Switch case to check the row values based on the pressed key in column 1
; 0000 0131 switch (PINC)
	IN   R30,0x13
; 0000 0132 {
; 0000 0133 // Check for specific row combinations in column 1
; 0000 0134 // 0bxrrrrccc
; 0000 0135 case 0b11110110:  // If row combination matches, indicating a keypress
	CPI  R30,LOW(0xF6)
	BRNE _0x68
; 0000 0136 while (PINC.3 == 0);// Wait for key release
_0x69:
	SBIS 0x13,3
	RJMP _0x69
; 0000 0137 return 1;  // Return the value 1 corresponding to the pressed key
	LDI  R30,LOW(1)
	RET
; 0000 0138 break;     // Exit the switch case
	RJMP _0x67
; 0000 0139 case 0b11101110:
_0x68:
	CPI  R30,LOW(0xEE)
	BRNE _0x6C
; 0000 013A while (PINC.4 == 0);
_0x6D:
	SBIS 0x13,4
	RJMP _0x6D
; 0000 013B return 4;
	LDI  R30,LOW(4)
	RET
; 0000 013C break;
	RJMP _0x67
; 0000 013D case 0b11011110:
_0x6C:
	CPI  R30,LOW(0xDE)
	BRNE _0x70
; 0000 013E while (PINC.5 == 0);
_0x71:
	SBIS 0x13,5
	RJMP _0x71
; 0000 013F return 7;
	LDI  R30,LOW(7)
	RET
; 0000 0140 break;
	RJMP _0x67
; 0000 0141 case 0b10111110:
_0x70:
	CPI  R30,LOW(0xBE)
	BRNE _0x67
; 0000 0142 while (PINC.6 == 0);
_0x75:
	SBIS 0x13,6
	RJMP _0x75
; 0000 0143 return 10; // '*' corresponds to number 10
	LDI  R30,LOW(10)
	RET
; 0000 0144 break;
; 0000 0145 }
_0x67:
; 0000 0146 // Deactivate column 1 and activate column 2
; 0000 0147 PORTC.0 = 1; // column 1 is inactive by 1
	SBI  0x15,0
; 0000 0148 PORTC.1 = 0; // column 2 is activated by 0
	CBI  0x15,1
; 0000 0149 PORTC.2 = 1; // column 3 is inactive by 1
	SBI  0x15,2
; 0000 014A switch (PINC)
	IN   R30,0x13
; 0000 014B {
; 0000 014C // 0bxrrrrccc
; 0000 014D case 0b11110101:
	CPI  R30,LOW(0xF5)
	BRNE _0x81
; 0000 014E while (PINC.3 == 0);
_0x82:
	SBIS 0x13,3
	RJMP _0x82
; 0000 014F return 2;
	LDI  R30,LOW(2)
	RET
; 0000 0150 break;
	RJMP _0x80
; 0000 0151 case 0b11101101:
_0x81:
	CPI  R30,LOW(0xED)
	BRNE _0x85
; 0000 0152 while (PINC.4 == 0);
_0x86:
	SBIS 0x13,4
	RJMP _0x86
; 0000 0153 return 5;
	LDI  R30,LOW(5)
	RET
; 0000 0154 break;
	RJMP _0x80
; 0000 0155 case 0b11011101:
_0x85:
	CPI  R30,LOW(0xDD)
	BRNE _0x89
; 0000 0156 while (PINC.5 == 0);
_0x8A:
	SBIS 0x13,5
	RJMP _0x8A
; 0000 0157 return 8;
	LDI  R30,LOW(8)
	RET
; 0000 0158 break;
	RJMP _0x80
; 0000 0159 case 0b10111101:
_0x89:
	CPI  R30,LOW(0xBD)
	BRNE _0x80
; 0000 015A while (PINC.6 == 0);
_0x8E:
	SBIS 0x13,6
	RJMP _0x8E
; 0000 015B return 0;
	LDI  R30,LOW(0)
	RET
; 0000 015C break;
; 0000 015D }
_0x80:
; 0000 015E // Deactivate column 2 and activate column 3
; 0000 015F PORTC.0 = 1; // column 1 is inactive by 1
	SBI  0x15,0
; 0000 0160 PORTC.1 = 1; // column 2 is inactive by 1
	SBI  0x15,1
; 0000 0161 PORTC.2 = 0; // column 3 is activated by 0
	CBI  0x15,2
; 0000 0162 switch (PINC)
	IN   R30,0x13
; 0000 0163 {
; 0000 0164 // 0bxrrrrccc
; 0000 0165 case 0b11110011:
	CPI  R30,LOW(0xF3)
	BRNE _0x9A
; 0000 0166 while (PINC.3 == 0);
_0x9B:
	SBIS 0x13,3
	RJMP _0x9B
; 0000 0167 return 3;
	LDI  R30,LOW(3)
	RET
; 0000 0168 break;
	RJMP _0x99
; 0000 0169 case 0b11101011:
_0x9A:
	CPI  R30,LOW(0xEB)
	BRNE _0x9E
; 0000 016A while (PINC.4 == 0);
_0x9F:
	SBIS 0x13,4
	RJMP _0x9F
; 0000 016B return 6;
	LDI  R30,LOW(6)
	RET
; 0000 016C break;
	RJMP _0x99
; 0000 016D case 0b11011011:
_0x9E:
	CPI  R30,LOW(0xDB)
	BRNE _0xA2
; 0000 016E while (PINC.5 == 0);
_0xA3:
	SBIS 0x13,5
	RJMP _0xA3
; 0000 016F return 9;
	LDI  R30,LOW(9)
	RET
; 0000 0170 break;
	RJMP _0x99
; 0000 0171 case 0b10111011:
_0xA2:
	CPI  R30,LOW(0xBB)
	BRNE _0x99
; 0000 0172 while (PINC.6 == 0);
_0xA7:
	SBIS 0x13,6
	RJMP _0xA7
; 0000 0173 return 11;
	LDI  R30,LOW(11)
	RET
; 0000 0174 break;
; 0000 0175 }
_0x99:
; 0000 0176 }
	RJMP _0x5C
; 0000 0177 }
; .FEND
;unsigned char EE_Read(unsigned int add)
; 0000 017A {
_EE_Read:
; .FSTART _EE_Read
; 0000 017B while(EECR.1 == 1);    //Wait till EEPROM is ready
	ST   -Y,R17
	ST   -Y,R16
	MOVW R16,R26
;	add -> R16,R17
_0xAA:
	SBIC 0x1C,1
	RJMP _0xAA
; 0000 017C EEAR = add;        //Prepare the address you want to read from
	__OUTWR 16,17,30
; 0000 017D 
; 0000 017E EECR.0 = 1;            //Execute read command
	SBI  0x1C,0
; 0000 017F 
; 0000 0180 return EEDR;   // Return the data read from the EEPROM
	IN   R30,0x1D
	LD   R16,Y+
	LD   R17,Y+
	RET
; 0000 0181 
; 0000 0182 }
; .FEND
;void EE_Write(unsigned int add, unsigned char data)
; 0000 0185 {
_EE_Write:
; .FSTART _EE_Write
; 0000 0186 while(EECR.1 == 1);    //Wait till EEPROM is ready
	RCALL __SAVELOCR4
	MOV  R17,R26
	__GETWRS 18,19,4
;	add -> R18,R19
;	data -> R17
_0xAF:
	SBIC 0x1C,1
	RJMP _0xAF
; 0000 0187 EEAR = add;        //Prepare the address you want to read from
	__OUTWR 18,19,30
; 0000 0188 EEDR = data;           //Prepare the data you want to write in the address above
	OUT  0x1D,R17
; 0000 0189 EECR.2 = 1;            //Master write enable
	SBI  0x1C,2
; 0000 018A EECR.1 = 1;            //Write Enable
	SBI  0x1C,1
; 0000 018B 
; 0000 018C }
	RCALL __LOADLOCR4
	ADIW R28,6
	RET
; .FEND
;void ChangePasswordUser()
; 0000 018F {
_ChangePasswordUser:
; .FSTART _ChangePasswordUser
; 0000 0190 lcd_clear();  // Clear the LCD display
	RCALL _lcd_clear
; 0000 0191 lcd_printf("Enter_ID");  // Display "Enter_ID" on the LCD
	__POINTW1FN _0x0,156
	RCALL SUBOPT_0x10
; 0000 0192 NewID = (keypad() * 100) + (keypad() * 10) + keypad();  // Collect a new ID from the keypad
	RCALL SUBOPT_0x1C
	PUSH R31
	PUSH R30
	RCALL SUBOPT_0x1D
	POP  R26
	POP  R27
	ADD  R30,R26
	ADC  R31,R27
	PUSH R31
	PUSH R30
	RCALL _keypad
	LDI  R31,0
	POP  R26
	POP  R27
	ADD  R30,R26
	ADC  R31,R27
	RCALL SUBOPT_0x1E
; 0000 0193 lcd_gotoxy(0, 1);  // Set cursor to the second line of the LCD
	RCALL SUBOPT_0x8
; 0000 0194 lcd_printf("%u", NewID);  // Display the entered ID on the LCD
	RCALL SUBOPT_0x9
	RCALL SUBOPT_0x1F
	RCALL SUBOPT_0xA
; 0000 0195 delay_ms(1000);  // Delay for 1 second
	LDI  R26,LOW(1000)
	LDI  R27,HIGH(1000)
	RCALL _delay_ms
; 0000 0196 
; 0000 0197 if (NewID == 126 || NewID == 128 || NewID == 130 || NewID == 132) {  // Check if the entered ID is valid
	RCALL SUBOPT_0x20
	CPI  R26,LOW(0x7E)
	LDI  R30,HIGH(0x7E)
	CPC  R27,R30
	BREQ _0xB7
	RCALL SUBOPT_0x21
	BREQ _0xB7
	RCALL SUBOPT_0x22
	BREQ _0xB7
	RCALL SUBOPT_0x23
	BREQ _0xB7
	RJMP _0xB6
_0xB7:
; 0000 0198 lcd_clear();  // Clear the LCD display
	RCALL _lcd_clear
; 0000 0199 lcd_printf("Enter Old-PC");  // Display "Enter Old-PC" on the LCD
	__POINTW1FN _0x0,165
	RCALL SUBOPT_0x10
; 0000 019A lcd_gotoxy(0, 1);  // Set cursor to the second line of the LCD
	RCALL SUBOPT_0x8
; 0000 019B OldPassword = 0;  // Initialize the variable for the old password
	CLR  R6
	CLR  R7
; 0000 019C OldPassword = (keypad() * 100) + (keypad() * 10) + keypad();  // Collect the old password from the keypad
	RCALL SUBOPT_0x1C
	PUSH R31
	PUSH R30
	RCALL SUBOPT_0x1D
	POP  R26
	POP  R27
	ADD  R30,R26
	ADC  R31,R27
	PUSH R31
	PUSH R30
	RCALL _keypad
	LDI  R31,0
	POP  R26
	POP  R27
	ADD  R30,R26
	ADC  R31,R27
	MOVW R6,R30
; 0000 019D storedPassword = EE_Read(NewID);  // Read the stored password from EEPROM at the given ID
	RCALL SUBOPT_0x20
	RCALL _EE_Read
	MOV  R4,R30
	CLR  R5
; 0000 019E storedPassword = storedPassword + (EE_Read(NewID + 1) * 255);  // Read the second byte of the stored password
	RCALL SUBOPT_0x20
	RCALL SUBOPT_0x11
; 0000 019F lcd_printf("%u", OldPassword);  // Display the entered old password on the LCD
	RCALL SUBOPT_0x9
	MOVW R30,R6
	RCALL SUBOPT_0xA
; 0000 01A0 delay_ms(1000);  // Delay for 1 second
	LDI  R26,LOW(1000)
	LDI  R27,HIGH(1000)
	RCALL _delay_ms
; 0000 01A1 
; 0000 01A2 if (OldPassword == storedPassword) {  // Check if the entered old password matches the stored one
	__CPWRR 4,5,6,7
	BREQ PC+2
	RJMP _0xB9
; 0000 01A3 // Prompt to enter the new password
; 0000 01A4 lcd_clear();
	RCALL _lcd_clear
; 0000 01A5 lcd_printf("Enter New-PC");
	__POINTW1FN _0x0,178
	RCALL SUBOPT_0x10
; 0000 01A6 lcd_gotoxy(0, 1);
	RCALL SUBOPT_0x8
; 0000 01A7 
; 0000 01A8 NewPassword = (keypad() * 100) + (keypad() * 10) + keypad();  // Collect the new password from the keypad
	RCALL SUBOPT_0x1C
	PUSH R31
	PUSH R30
	RCALL SUBOPT_0x1D
	POP  R26
	POP  R27
	ADD  R30,R26
	ADC  R31,R27
	PUSH R31
	PUSH R30
	RCALL _keypad
	LDI  R31,0
	POP  R26
	POP  R27
	ADD  R30,R26
	ADC  R31,R27
	MOVW R8,R30
; 0000 01A9 lcd_printf("%u", NewPassword);  // Display the entered new password on the LCD
	RCALL SUBOPT_0x9
	MOVW R30,R8
	RCALL SUBOPT_0xA
; 0000 01AA delay_ms(1000);  // Delay for 1 second
	RCALL SUBOPT_0x14
; 0000 01AB 
; 0000 01AC lcd_clear();  // Clear the LCD display
; 0000 01AD lcd_printf("Re-enter PC");  // Prompt to re-enter the new password
	__POINTW1FN _0x0,191
	RCALL SUBOPT_0x10
; 0000 01AE lcd_gotoxy(0, 1);
	RCALL SUBOPT_0x8
; 0000 01AF 
; 0000 01B0 ReenterNewPassword = (keypad() * 100) + (keypad() * 10) + keypad();  // Collect the re-entered new password
	RCALL SUBOPT_0x1C
	PUSH R31
	PUSH R30
	RCALL SUBOPT_0x1D
	POP  R26
	POP  R27
	ADD  R30,R26
	ADC  R31,R27
	PUSH R31
	PUSH R30
	RCALL _keypad
	LDI  R31,0
	POP  R26
	POP  R27
	ADD  R30,R26
	ADC  R31,R27
	MOVW R10,R30
; 0000 01B1 lcd_printf("%u", ReenterNewPassword);  // Display the re-entered new password on the LCD
	RCALL SUBOPT_0x9
	MOVW R30,R10
	RCALL SUBOPT_0xA
; 0000 01B2 delay_ms(1000);  // Delay for 1 second
	LDI  R26,LOW(1000)
	LDI  R27,HIGH(1000)
	RCALL _delay_ms
; 0000 01B3 
; 0000 01B4 if (ReenterNewPassword == NewPassword) {  // Check if the re-entered new password matches the new password
	__CPWRR 8,9,10,11
	BRNE _0xBA
; 0000 01B5 lcd_clear();  // Clear the LCD display
	RCALL _lcd_clear
; 0000 01B6 // Write the new password to EEPROM
; 0000 01B7 EE_Write(NewID, NewPassword % 255);
	RCALL SUBOPT_0x1F
	RCALL SUBOPT_0x24
	RCALL SUBOPT_0x25
; 0000 01B8 EE_Write(NewID + 1, NewPassword / 255);
	RCALL SUBOPT_0x24
	RCALL SUBOPT_0x26
; 0000 01B9 lcd_printf("Change");  // Display "Change" on the LCD
; 0000 01BA lcd_gotoxy(0, 1);
	RCALL SUBOPT_0x8
; 0000 01BB lcd_printf("Successfully");  // Display "Successfully" on the LCD
	__POINTW1FN _0x0,210
	RCALL SUBOPT_0x10
; 0000 01BC delay_ms(1000);  // Delay for 1 second
	RCALL SUBOPT_0x27
; 0000 01BD lcd_clear();  // Clear the LCD display
; 0000 01BE lcd_printf("Press * to enter");  // Prompt to press '*' to enter
; 0000 01BF } else {
	RJMP _0xBB
_0xBA:
; 0000 01C0 lcd_clear();  // Clear the LCD display
	RCALL SUBOPT_0x18
; 0000 01C1 lcd_printf("Wrong password");  // Display "Wrong password" on the LCD
; 0000 01C2 delay_ms(1000);  // Delay for 1 second
	RCALL SUBOPT_0x1B
; 0000 01C3 PORTD.5 = 1;  // Activate alarm
; 0000 01C4 delay_ms(1000);
; 0000 01C5 PORTD.5 = 0;  // Deactivate alarm
; 0000 01C6 delay_ms(1000);
	RCALL SUBOPT_0x27
; 0000 01C7 lcd_clear();  // Clear the LCD display
; 0000 01C8 lcd_printf("Press * to enter");  // Prompt to press '*' to enter
; 0000 01C9 delay_ms(1000);  // Delay for 1 second
	LDI  R26,LOW(1000)
	LDI  R27,HIGH(1000)
	RCALL _delay_ms
; 0000 01CA }
_0xBB:
; 0000 01CB } else {
	RJMP _0xC0
_0xB9:
; 0000 01CC lcd_clear();  // Clear the LCD display
	RCALL SUBOPT_0x18
; 0000 01CD lcd_printf("Wrong password");  // Display "Wrong password" on the LCD
; 0000 01CE delay_ms(1000);  // Delay for 1 second
	RCALL SUBOPT_0x1B
; 0000 01CF PORTD.5 = 1;  // Activate alarm
; 0000 01D0 delay_ms(1000);
; 0000 01D1 PORTD.5 = 0;  // Deactivate alarm
; 0000 01D2 delay_ms(1000);
	RCALL SUBOPT_0x27
; 0000 01D3 lcd_clear();  // Clear the LCD display
; 0000 01D4 lcd_printf("Press * to enter");  // Prompt to press '*' to enter
; 0000 01D5 delay_ms(1000);  // Delay for 1 second
	LDI  R26,LOW(1000)
	LDI  R27,HIGH(1000)
	RCALL _delay_ms
; 0000 01D6 }
_0xC0:
; 0000 01D7 } else {
	RJMP _0xC5
_0xB6:
; 0000 01D8 lcd_clear();  // Clear the LCD display
	RCALL SUBOPT_0x1A
; 0000 01D9 lcd_printf("Invalid ID");  // Display "Invalid ID" on the LCD
; 0000 01DA PORTD.5 = 1;  // Activate alarm
	RCALL SUBOPT_0x19
; 0000 01DB delay_ms(1000);  // Delay for 1 second
; 0000 01DC PORTD.5 = 0;  // Deactivate alarm
; 0000 01DD delay_ms(1000);  // Delay for 1 second
	RCALL SUBOPT_0x1B
; 0000 01DE PORTD.5 = 1;  // Activate alarm
; 0000 01DF delay_ms(1000);  // Delay for 1 second
; 0000 01E0 PORTD.5 = 0;  // Deactivate alarm
; 0000 01E1 delay_ms(1000);  // Delay for 1 second
	RCALL SUBOPT_0x27
; 0000 01E2 lcd_clear();  // Clear the LCD display
; 0000 01E3 lcd_printf("Press * to enter");  // Prompt to press '*' to enter
; 0000 01E4 delay_ms(1000);  // Delay for 1 second
	LDI  R26,LOW(1000)
	LDI  R27,HIGH(1000)
	RCALL _delay_ms
; 0000 01E5 }
_0xC5:
; 0000 01E6 }
	RET
; .FEND
;void ChangePasswordAdmin()
; 0000 01E9 {
_ChangePasswordAdmin:
; .FSTART _ChangePasswordAdmin
; 0000 01EA lcd_clear();  // Clear the LCD display
	RCALL SUBOPT_0x13
; 0000 01EB lcd_printf("You are Admin");  // Display "You are Admin" on the LCD
; 0000 01EC delay_ms(1000);  // Delay for 1 second
	RCALL SUBOPT_0x14
; 0000 01ED lcd_clear();  // Clear the LCD display
; 0000 01EE lcd_printf("Enter PC: ");  // Prompt to enter the password
	__POINTW1FN _0x0,223
	RCALL SUBOPT_0x10
; 0000 01EF lcd_gotoxy(0, 1);  // Set cursor to the second line of the LCD
	RCALL SUBOPT_0x8
; 0000 01F0 OldPassword = (keypad() * 100) + (keypad() * 10) + keypad();  // Collect the entered password
	RCALL SUBOPT_0x1C
	PUSH R31
	PUSH R30
	RCALL SUBOPT_0x1D
	POP  R26
	POP  R27
	ADD  R30,R26
	ADC  R31,R27
	PUSH R31
	PUSH R30
	RCALL _keypad
	LDI  R31,0
	POP  R26
	POP  R27
	ADD  R30,R26
	ADC  R31,R27
	MOVW R6,R30
; 0000 01F1 storedPassword = EE_Read(111);  // Read the stored password for Admin from EEPROM
	LDI  R26,LOW(111)
	LDI  R27,0
	RCALL _EE_Read
	MOV  R4,R30
	CLR  R5
; 0000 01F2 storedPassword = storedPassword + (EE_Read(112) * 255);  // Read the second byte of the stored password
	LDI  R26,LOW(112)
	LDI  R27,0
	RCALL _EE_Read
	LDI  R26,LOW(255)
	MUL  R30,R26
	MOVW R30,R0
	__ADDWRR 4,5,30,31
; 0000 01F3 lcd_printf("%u", OldPassword);  // Display the entered password on the LCD
	RCALL SUBOPT_0x9
	MOVW R30,R6
	RCALL SUBOPT_0xA
; 0000 01F4 delay_ms(1000);  // Delay for 1 second
	LDI  R26,LOW(1000)
	LDI  R27,HIGH(1000)
	RCALL _delay_ms
; 0000 01F5 
; 0000 01F6 if (storedPassword == OldPassword) {  // Check if the entered password matches the stored Admin password
	__CPWRR 6,7,4,5
	BREQ PC+2
	RJMP _0xCE
; 0000 01F7 lcd_clear();  // Clear the LCD display
	RCALL SUBOPT_0x6
; 0000 01F8 lcd_printf("Entered ID:");  // Prompt to enter the ID
; 0000 01F9 lcd_gotoxy(0, 1);  // Set cursor to the second line of the LCD
	RCALL SUBOPT_0x8
; 0000 01FA id1 = keypad();  // Read the first digit of the ID
	RCALL SUBOPT_0x7
; 0000 01FB id2 = keypad();  // Read the second digit of the ID
; 0000 01FC id3 = keypad();  // Read the third digit of the ID
; 0000 01FD NewID = id3 + (id2 * 10) + (id1 * 100);  // Calculate the new ID from the entered digits
	RCALL SUBOPT_0x1E
; 0000 01FE 
; 0000 01FF if (NewID == 111 || NewID == 126 || NewID == 128 || NewID == 130 || NewID == 132) {  // Check if the new ID is valid
	RCALL SUBOPT_0x20
	CPI  R26,LOW(0x6F)
	LDI  R30,HIGH(0x6F)
	CPC  R27,R30
	BREQ _0xD0
	RCALL SUBOPT_0x20
	CPI  R26,LOW(0x7E)
	LDI  R30,HIGH(0x7E)
	CPC  R27,R30
	BREQ _0xD0
	RCALL SUBOPT_0x21
	BREQ _0xD0
	RCALL SUBOPT_0x22
	BREQ _0xD0
	RCALL SUBOPT_0x23
	BRNE _0xCF
_0xD0:
; 0000 0200 lcd_printf("%u", NewID);  // Display the new ID on the LCD
	RCALL SUBOPT_0x9
	RCALL SUBOPT_0x1F
	RCALL SUBOPT_0xA
; 0000 0201 delay_ms(1000);  // Delay for 1 second
	RCALL SUBOPT_0x14
; 0000 0202 lcd_clear();  // Clear the LCD display
; 0000 0203 lcd_printf("Enter-new PC: ");  // Prompt to enter the new password
	__POINTW1FN _0x0,234
	RCALL SUBOPT_0x10
; 0000 0204 lcd_gotoxy(0, 1);  // Set cursor to the second line of the LCD
	RCALL SUBOPT_0x8
; 0000 0205 ChangeAdminPasswords = (keypad() * 100) + (keypad() * 10) + keypad();  // Collect the new password
	RCALL SUBOPT_0x1C
	PUSH R31
	PUSH R30
	RCALL SUBOPT_0x1D
	POP  R26
	POP  R27
	ADD  R30,R26
	ADC  R31,R27
	PUSH R31
	PUSH R30
	RCALL _keypad
	LDI  R31,0
	POP  R26
	POP  R27
	ADD  R30,R26
	ADC  R31,R27
	MOVW R12,R30
; 0000 0206 lcd_printf("%u", ChangeAdminPasswords);  // Display the entered new password on the LCD
	RCALL SUBOPT_0x9
	MOVW R30,R12
	RCALL SUBOPT_0xA
; 0000 0207 delay_ms(1000);  // Delay for 1 second
	RCALL SUBOPT_0x14
; 0000 0208 lcd_clear();  // Clear the LCD display
; 0000 0209 EE_Write(NewID, ChangeAdminPasswords % 255);  // Write the lower byte of the new password to EEPROM
	RCALL SUBOPT_0x1F
	RCALL SUBOPT_0x28
	RCALL SUBOPT_0x25
; 0000 020A EE_Write(NewID + 1, ChangeAdminPasswords / 255);  // Write the upper byte of the new password to EEPROM
	RCALL SUBOPT_0x28
	RCALL SUBOPT_0x26
; 0000 020B lcd_printf("Change");  // Display "Change" on the LCD
; 0000 020C lcd_gotoxy(0, 1);  // Set cursor to the second line of the LCD
	RCALL SUBOPT_0x8
; 0000 020D lcd_printf("Successfully");  // Display "Successfully" on the LCD
	__POINTW1FN _0x0,210
	RCALL SUBOPT_0x10
; 0000 020E delay_ms(1000);  // Delay for 1 second
	RCALL SUBOPT_0x27
; 0000 020F lcd_clear();  // Clear the LCD display
; 0000 0210 lcd_printf("Press * to enter");  // Prompt to press '*' to enter
; 0000 0211 } else {
	RJMP _0xD2
_0xCF:
; 0000 0212 lcd_clear();  // Clear the LCD display
	RCALL SUBOPT_0x1A
; 0000 0213 lcd_printf("Invalid ID");  // Display "Invalid ID" on the LCD
; 0000 0214 PORTD.5 = 1;  // Activate alarm
	RCALL SUBOPT_0x19
; 0000 0215 delay_ms(1000);  // Delay for 1 second
; 0000 0216 PORTD.5 = 0;  // Deactivate alarm
; 0000 0217 delay_ms(1000);  // Delay for 1 second
	RCALL SUBOPT_0x1B
; 0000 0218 PORTD.5 = 1;  // Activate alarm
; 0000 0219 delay_ms(1000);  // Delay for 1 second
; 0000 021A PORTD.5 = 0;  // Deactivate alarm
; 0000 021B delay_ms(1000);  // Delay for 1 second
	RCALL SUBOPT_0x27
; 0000 021C lcd_clear();  // Clear the LCD display
; 0000 021D lcd_printf("Press * to enter");  // Prompt to press '*' to enter
; 0000 021E delay_ms(1000);  // Delay for 1 second
	LDI  R26,LOW(1000)
	LDI  R27,HIGH(1000)
	RCALL _delay_ms
; 0000 021F }
_0xD2:
; 0000 0220 } else {
	RJMP _0xDB
_0xCE:
; 0000 0221 lcd_clear();  // Clear the LCD display
	RCALL SUBOPT_0x18
; 0000 0222 lcd_printf("Wrong password");  // Display "Wrong password" on the LCD
; 0000 0223 delay_ms(1000);  // Delay for 1 second
	RCALL SUBOPT_0x1B
; 0000 0224 PORTD.5 = 1;  // Activate alarm
; 0000 0225 delay_ms(1000);  // Delay for 1 second
; 0000 0226 PORTD.5 = 0;  // Deactivate alarm
; 0000 0227 delay_ms(1000);  // Delay for 1 second
	RCALL SUBOPT_0x14
; 0000 0228 lcd_clear();  // Clear the LCD display
; 0000 0229 delay_ms(1000);  // Delay for 1 second
	LDI  R26,LOW(1000)
	LDI  R27,HIGH(1000)
	RCALL _delay_ms
; 0000 022A ChangePasswordAdmin();  // Call the function recursively to re-enter the password
	RCALL _ChangePasswordAdmin
; 0000 022B }
_0xDB:
; 0000 022C }
	RET
; .FEND
;interrupt [2] void ext0(void)
; 0000 0231 {
_ext0:
; .FSTART _ext0
	RCALL SUBOPT_0x29
; 0000 0232 ChangePasswordAdmin();   // Call the function to change the password for Admin when Interrupt 0 (external interrupt 0) occurs
	RCALL _ChangePasswordAdmin
; 0000 0233 }
	RJMP _0xE0
; .FEND
;interrupt [3] void  ext1(void)
; 0000 0236 {
_ext1:
; .FSTART _ext1
	RCALL SUBOPT_0x29
; 0000 0237 ChangePasswordUser( ); // Call the function to change the password for User when Interrupt 1 (external interrupt 1) occurs
	RCALL _ChangePasswordUser
; 0000 0238 }
_0xE0:
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	LD   R25,Y+
	LD   R24,Y+
	LD   R23,Y+
	LD   R22,Y+
	LD   R15,Y+
	LD   R1,Y+
	LD   R0,Y+
	RETI
; .FEND
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.DSEG

	.CSEG
__lcd_write_nibble_G100:
; .FSTART __lcd_write_nibble_G100
	ST   -Y,R17
	MOV  R17,R26
	IN   R30,0x1B
	ANDI R30,LOW(0xF)
	MOV  R26,R30
	MOV  R30,R17
	ANDI R30,LOW(0xF0)
	OR   R30,R26
	OUT  0x1B,R30
	__DELAY_USB 13
	SBI  0x1B,2
	__DELAY_USB 13
	CBI  0x1B,2
	__DELAY_USB 13
	RJMP _0x20C0001
; .FEND
__lcd_write_data:
; .FSTART __lcd_write_data
	ST   -Y,R26
	LD   R26,Y
	RCALL __lcd_write_nibble_G100
    ld    r30,y
    swap  r30
    st    y,r30
	LD   R26,Y
	RCALL __lcd_write_nibble_G100
	__DELAY_USB 133
	ADIW R28,1
	RET
; .FEND
_lcd_gotoxy:
; .FSTART _lcd_gotoxy
	ST   -Y,R17
	ST   -Y,R16
	MOV  R17,R26
	LDD  R16,Y+2
	MOV  R30,R17
	LDI  R31,0
	SUBI R30,LOW(-__base_y_G100)
	SBCI R31,HIGH(-__base_y_G100)
	LD   R30,Z
	ADD  R30,R16
	MOV  R26,R30
	RCALL __lcd_write_data
	STS  __lcd_x,R16
	STS  __lcd_y,R17
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,3
	RET
; .FEND
_lcd_clear:
; .FSTART _lcd_clear
	LDI  R26,LOW(2)
	RCALL SUBOPT_0x2A
	LDI  R26,LOW(12)
	RCALL __lcd_write_data
	LDI  R26,LOW(1)
	RCALL SUBOPT_0x2A
	LDI  R30,LOW(0)
	STS  __lcd_y,R30
	STS  __lcd_x,R30
	RET
; .FEND
_lcd_putchar:
; .FSTART _lcd_putchar
	ST   -Y,R17
	MOV  R17,R26
	CPI  R17,10
	BREQ _0x2000005
	LDS  R30,__lcd_maxx
	LDS  R26,__lcd_x
	CP   R26,R30
	BRLO _0x2000004
_0x2000005:
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDS  R26,__lcd_y
	SUBI R26,-LOW(1)
	STS  __lcd_y,R26
	RCALL _lcd_gotoxy
	CPI  R17,10
	BREQ _0x20C0001
_0x2000004:
	LDS  R30,__lcd_x
	SUBI R30,-LOW(1)
	STS  __lcd_x,R30
	SBI  0x1B,0
	MOV  R26,R17
	RCALL __lcd_write_data
	CBI  0x1B,0
	RJMP _0x20C0001
; .FEND
_lcd_init:
; .FSTART _lcd_init
	ST   -Y,R17
	MOV  R17,R26
	IN   R30,0x1A
	ORI  R30,LOW(0xF0)
	OUT  0x1A,R30
	SBI  0x1A,2
	SBI  0x1A,0
	SBI  0x1A,1
	CBI  0x1B,2
	CBI  0x1B,0
	CBI  0x1B,1
	STS  __lcd_maxx,R17
	MOV  R30,R17
	SUBI R30,-LOW(128)
	__PUTB1MN __base_y_G100,2
	MOV  R30,R17
	SUBI R30,-LOW(192)
	__PUTB1MN __base_y_G100,3
	LDI  R26,LOW(20)
	LDI  R27,0
	RCALL _delay_ms
	RCALL SUBOPT_0x2B
	RCALL SUBOPT_0x2B
	RCALL SUBOPT_0x2B
	LDI  R26,LOW(32)
	RCALL __lcd_write_nibble_G100
	__DELAY_USW 200
	LDI  R26,LOW(40)
	RCALL __lcd_write_data
	LDI  R26,LOW(4)
	RCALL __lcd_write_data
	LDI  R26,LOW(133)
	RCALL __lcd_write_data
	LDI  R26,LOW(6)
	RCALL __lcd_write_data
	RCALL _lcd_clear
_0x20C0001:
	LD   R17,Y+
	RET
; .FEND

	.CSEG

	.DSEG

	.CSEG

	.CSEG
_strlen:
; .FSTART _strlen
	ST   -Y,R27
	ST   -Y,R26
    ld   r26,y+
    ld   r27,y+
    clr  r30
    clr  r31
strlen0:
    ld   r22,x+
    tst  r22
    breq strlen1
    adiw r30,1
    rjmp strlen0
strlen1:
    ret
; .FEND
_strlenf:
; .FSTART _strlenf
	ST   -Y,R27
	ST   -Y,R26
    clr  r26
    clr  r27
    ld   r30,y+
    ld   r31,y+
strlenf0:
	lpm  r0,z+
    tst  r0
    breq strlenf1
    adiw r26,1
    rjmp strlenf0
strlenf1:
    movw r30,r26
    ret
; .FEND
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.CSEG
__print_G103:
; .FSTART __print_G103
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,6
	RCALL __SAVELOCR6
	LDI  R17,0
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   X+,R30
	ST   X,R31
_0x2060016:
	LDD  R30,Y+18
	LDD  R31,Y+18+1
	ADIW R30,1
	STD  Y+18,R30
	STD  Y+18+1,R31
	SBIW R30,1
	LPM  R30,Z
	MOV  R18,R30
	CPI  R30,0
	BRNE PC+2
	RJMP _0x2060018
	MOV  R30,R17
	CPI  R30,0
	BRNE _0x206001C
	CPI  R18,37
	BRNE _0x206001D
	LDI  R17,LOW(1)
	RJMP _0x206001E
_0x206001D:
	RCALL SUBOPT_0x2C
_0x206001E:
	RJMP _0x206001B
_0x206001C:
	CPI  R30,LOW(0x1)
	BRNE _0x206001F
	CPI  R18,37
	BRNE _0x2060020
	RCALL SUBOPT_0x2C
	RJMP _0x20600CC
_0x2060020:
	LDI  R17,LOW(2)
	LDI  R20,LOW(0)
	LDI  R16,LOW(0)
	CPI  R18,45
	BRNE _0x2060021
	LDI  R16,LOW(1)
	RJMP _0x206001B
_0x2060021:
	CPI  R18,43
	BRNE _0x2060022
	LDI  R20,LOW(43)
	RJMP _0x206001B
_0x2060022:
	CPI  R18,32
	BRNE _0x2060023
	LDI  R20,LOW(32)
	RJMP _0x206001B
_0x2060023:
	RJMP _0x2060024
_0x206001F:
	CPI  R30,LOW(0x2)
	BRNE _0x2060025
_0x2060024:
	LDI  R21,LOW(0)
	LDI  R17,LOW(3)
	CPI  R18,48
	BRNE _0x2060026
	ORI  R16,LOW(128)
	RJMP _0x206001B
_0x2060026:
	RJMP _0x2060027
_0x2060025:
	CPI  R30,LOW(0x3)
	BREQ PC+2
	RJMP _0x206001B
_0x2060027:
	CPI  R18,48
	BRLO _0x206002A
	CPI  R18,58
	BRLO _0x206002B
_0x206002A:
	RJMP _0x2060029
_0x206002B:
	LDI  R26,LOW(10)
	MUL  R21,R26
	MOV  R21,R0
	MOV  R30,R18
	SUBI R30,LOW(48)
	ADD  R21,R30
	RJMP _0x206001B
_0x2060029:
	MOV  R30,R18
	CPI  R30,LOW(0x63)
	BRNE _0x206002F
	RCALL SUBOPT_0x2D
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	LDD  R26,Z+4
	ST   -Y,R26
	RCALL SUBOPT_0x2E
	RJMP _0x2060030
_0x206002F:
	CPI  R30,LOW(0x73)
	BRNE _0x2060032
	RCALL SUBOPT_0x2D
	RCALL SUBOPT_0x2F
	RCALL _strlen
	MOV  R17,R30
	RJMP _0x2060033
_0x2060032:
	CPI  R30,LOW(0x70)
	BRNE _0x2060035
	RCALL SUBOPT_0x2D
	RCALL SUBOPT_0x2F
	RCALL _strlenf
	MOV  R17,R30
	ORI  R16,LOW(8)
_0x2060033:
	ORI  R16,LOW(2)
	ANDI R16,LOW(127)
	LDI  R19,LOW(0)
	RJMP _0x2060036
_0x2060035:
	CPI  R30,LOW(0x64)
	BREQ _0x2060039
	CPI  R30,LOW(0x69)
	BRNE _0x206003A
_0x2060039:
	ORI  R16,LOW(4)
	RJMP _0x206003B
_0x206003A:
	CPI  R30,LOW(0x75)
	BRNE _0x206003C
_0x206003B:
	LDI  R30,LOW(_tbl10_G103*2)
	LDI  R31,HIGH(_tbl10_G103*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R17,LOW(5)
	RJMP _0x206003D
_0x206003C:
	CPI  R30,LOW(0x58)
	BRNE _0x206003F
	ORI  R16,LOW(8)
	RJMP _0x2060040
_0x206003F:
	CPI  R30,LOW(0x78)
	BREQ PC+2
	RJMP _0x2060071
_0x2060040:
	LDI  R30,LOW(_tbl16_G103*2)
	LDI  R31,HIGH(_tbl16_G103*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R17,LOW(4)
_0x206003D:
	SBRS R16,2
	RJMP _0x2060042
	RCALL SUBOPT_0x2D
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,4
	LD   R30,X+
	LD   R31,X+
	STD  Y+10,R30
	STD  Y+10+1,R31
	LDD  R26,Y+11
	TST  R26
	BRPL _0x2060043
	RCALL __ANEGW1
	STD  Y+10,R30
	STD  Y+10+1,R31
	LDI  R20,LOW(45)
_0x2060043:
	CPI  R20,0
	BREQ _0x2060044
	SUBI R17,-LOW(1)
	RJMP _0x2060045
_0x2060044:
	ANDI R16,LOW(251)
_0x2060045:
	RJMP _0x2060046
_0x2060042:
	RCALL SUBOPT_0x2D
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,4
	__GETW1P
	STD  Y+10,R30
	STD  Y+10+1,R31
_0x2060046:
_0x2060036:
	SBRC R16,0
	RJMP _0x2060047
_0x2060048:
	CP   R17,R21
	BRSH _0x206004A
	SBRS R16,7
	RJMP _0x206004B
	SBRS R16,2
	RJMP _0x206004C
	ANDI R16,LOW(251)
	MOV  R18,R20
	SUBI R17,LOW(1)
	RJMP _0x206004D
_0x206004C:
	LDI  R18,LOW(48)
_0x206004D:
	RJMP _0x206004E
_0x206004B:
	LDI  R18,LOW(32)
_0x206004E:
	RCALL SUBOPT_0x2C
	SUBI R21,LOW(1)
	RJMP _0x2060048
_0x206004A:
_0x2060047:
	MOV  R19,R17
	SBRS R16,1
	RJMP _0x206004F
_0x2060050:
	CPI  R19,0
	BREQ _0x2060052
	SBRS R16,3
	RJMP _0x2060053
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	LPM  R18,Z+
	STD  Y+6,R30
	STD  Y+6+1,R31
	RJMP _0x2060054
_0x2060053:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LD   R18,X+
	STD  Y+6,R26
	STD  Y+6+1,R27
_0x2060054:
	RCALL SUBOPT_0x2C
	CPI  R21,0
	BREQ _0x2060055
	SUBI R21,LOW(1)
_0x2060055:
	SUBI R19,LOW(1)
	RJMP _0x2060050
_0x2060052:
	RJMP _0x2060056
_0x206004F:
_0x2060058:
	LDI  R18,LOW(48)
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	RCALL __GETW1PF
	STD  Y+8,R30
	STD  Y+8+1,R31
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,2
	STD  Y+6,R30
	STD  Y+6+1,R31
_0x206005A:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0x206005C
	SUBI R18,-LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	SUB  R30,R26
	SBC  R31,R27
	STD  Y+10,R30
	STD  Y+10+1,R31
	RJMP _0x206005A
_0x206005C:
	CPI  R18,58
	BRLO _0x206005D
	SBRS R16,3
	RJMP _0x206005E
	SUBI R18,-LOW(7)
	RJMP _0x206005F
_0x206005E:
	SUBI R18,-LOW(39)
_0x206005F:
_0x206005D:
	SBRC R16,4
	RJMP _0x2060061
	CPI  R18,49
	BRSH _0x2060063
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,1
	BRNE _0x2060062
_0x2060063:
	RJMP _0x20600CD
_0x2060062:
	CP   R21,R19
	BRLO _0x2060067
	SBRS R16,0
	RJMP _0x2060068
_0x2060067:
	RJMP _0x2060066
_0x2060068:
	LDI  R18,LOW(32)
	SBRS R16,7
	RJMP _0x2060069
	LDI  R18,LOW(48)
_0x20600CD:
	ORI  R16,LOW(16)
	SBRS R16,2
	RJMP _0x206006A
	ANDI R16,LOW(251)
	ST   -Y,R20
	RCALL SUBOPT_0x2E
	CPI  R21,0
	BREQ _0x206006B
	SUBI R21,LOW(1)
_0x206006B:
_0x206006A:
_0x2060069:
_0x2060061:
	RCALL SUBOPT_0x2C
	CPI  R21,0
	BREQ _0x206006C
	SUBI R21,LOW(1)
_0x206006C:
_0x2060066:
	SUBI R19,LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,2
	BRLO _0x2060059
	RJMP _0x2060058
_0x2060059:
_0x2060056:
	SBRS R16,0
	RJMP _0x206006D
_0x206006E:
	CPI  R21,0
	BREQ _0x2060070
	SUBI R21,LOW(1)
	LDI  R30,LOW(32)
	ST   -Y,R30
	RCALL SUBOPT_0x2E
	RJMP _0x206006E
_0x2060070:
_0x206006D:
_0x2060071:
_0x2060030:
_0x20600CC:
	LDI  R17,LOW(0)
_0x206001B:
	RJMP _0x2060016
_0x2060018:
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	LD   R30,X+
	LD   R31,X+
	RCALL __LOADLOCR6
	ADIW R28,20
	RET
; .FEND
_put_lcd_G103:
; .FSTART _put_lcd_G103
	RCALL __SAVELOCR4
	MOVW R16,R26
	LDD  R19,Y+4
	MOV  R26,R19
	RCALL _lcd_putchar
	MOVW R26,R16
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	RCALL __LOADLOCR4
	ADIW R28,5
	RET
; .FEND
_lcd_printf:
; .FSTART _lcd_printf
	PUSH R15
	MOV  R15,R24
	SBIW R28,6
	ST   -Y,R17
	ST   -Y,R16
	MOVW R26,R28
	ADIW R26,4
	__ADDW2R15
	MOVW R16,R26
	LDI  R30,LOW(0)
	STD  Y+4,R30
	STD  Y+4+1,R30
	STD  Y+6,R30
	STD  Y+6+1,R30
	MOVW R26,R28
	ADIW R26,8
	__ADDW2R15
	LD   R30,X+
	LD   R31,X+
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(_put_lcd_G103)
	LDI  R31,HIGH(_put_lcd_G103)
	ST   -Y,R31
	ST   -Y,R30
	MOVW R26,R28
	ADIW R26,8
	RCALL __print_G103
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,8
	POP  R15
	RET
; .FEND

	.CSEG

	.CSEG

	.DSEG
_pass1:
	.BYTE 0x2
_pass2:
	.BYTE 0x2
_pass3:
	.BYTE 0x2
_password:
	.BYTE 0x2
_id1:
	.BYTE 0x2
_id2:
	.BYTE 0x2
_id3:
	.BYTE 0x2
_enteredID:
	.BYTE 0x2
_NewID:
	.BYTE 0x2
__base_y_G100:
	.BYTE 0x4
__lcd_x:
	.BYTE 0x1
__lcd_y:
	.BYTE 0x1
__lcd_maxx:
	.BYTE 0x1
__seed_G101:
	.BYTE 0x4

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x0:
	ST   -Y,R31
	ST   -Y,R30
	MOVW R26,R16
	LDI  R30,LOW(255)
	LDI  R31,HIGH(255)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x1:
	ST   -Y,R31
	ST   -Y,R30
	MOVW R26,R18
	LDI  R30,LOW(255)
	LDI  R31,HIGH(255)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x2:
	ST   -Y,R31
	ST   -Y,R30
	MOVW R26,R20
	LDI  R30,LOW(255)
	LDI  R31,HIGH(255)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x3:
	ST   -Y,R31
	ST   -Y,R30
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	LDI  R30,LOW(255)
	LDI  R31,HIGH(255)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x4:
	ST   -Y,R31
	ST   -Y,R30
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDI  R30,LOW(255)
	LDI  R31,HIGH(255)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 12 TIMES, CODE SIZE REDUCTION:75 WORDS
SUBOPT_0x5:
	RCALL _lcd_clear
	__POINTW1FN _0x0,0
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	RCALL _lcd_printf
	ADIW R28,2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x6:
	RCALL _lcd_clear
	__POINTW1FN _0x0,17
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	RCALL _lcd_printf
	ADIW R28,2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:39 WORDS
SUBOPT_0x7:
	RCALL _keypad
	LDI  R31,0
	STS  _id1,R30
	STS  _id1+1,R31
	RCALL _keypad
	LDI  R31,0
	STS  _id2,R30
	STS  _id2+1,R31
	RCALL _keypad
	LDI  R31,0
	STS  _id3,R30
	STS  _id3+1,R31
	LDS  R26,_id2
	LDS  R27,_id2+1
	LDI  R30,LOW(10)
	CALL __MULB1W2U
	LDS  R26,_id3
	LDS  R27,_id3+1
	ADD  R30,R26
	ADC  R31,R27
	__PUTW1R 23,24
	LDS  R26,_id1
	LDS  R27,_id1+1
	LDI  R30,LOW(100)
	CALL __MULB1W2U
	ADD  R30,R23
	ADC  R31,R24
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 17 TIMES, CODE SIZE REDUCTION:46 WORDS
SUBOPT_0x8:
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(1)
	RJMP _lcd_gotoxy

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES, CODE SIZE REDUCTION:22 WORDS
SUBOPT_0x9:
	__POINTW1FN _0x0,29
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES, CODE SIZE REDUCTION:38 WORDS
SUBOPT_0xA:
	CLR  R22
	CLR  R23
	RCALL __PUTPARD1
	LDI  R24,4
	RCALL _lcd_printf
	ADIW R28,6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 12 TIMES, CODE SIZE REDUCTION:31 WORDS
SUBOPT_0xB:
	LDS  R26,_enteredID
	LDS  R27,_enteredID+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xC:
	RCALL SUBOPT_0xB
	CPI  R26,LOW(0x7E)
	LDI  R30,HIGH(0x7E)
	CPC  R27,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xD:
	RCALL SUBOPT_0xB
	CPI  R26,LOW(0x80)
	LDI  R30,HIGH(0x80)
	CPC  R27,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xE:
	RCALL SUBOPT_0xB
	CPI  R26,LOW(0x82)
	LDI  R30,HIGH(0x82)
	CPC  R27,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xF:
	RCALL SUBOPT_0xB
	CPI  R26,LOW(0x84)
	LDI  R30,HIGH(0x84)
	CPC  R27,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 40 TIMES, CODE SIZE REDUCTION:154 WORDS
SUBOPT_0x10:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	RCALL _lcd_printf
	ADIW R28,2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x11:
	ADIW R26,1
	RCALL _EE_Read
	LDI  R26,LOW(255)
	MUL  R30,R26
	MOVW R30,R0
	__ADDWRR 4,5,30,31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:18 WORDS
SUBOPT_0x12:
	LDS  R26,_password
	LDS  R27,_password+1
	CP   R4,R26
	CPC  R5,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x13:
	RCALL _lcd_clear
	__POINTW1FN _0x0,49
	RJMP SUBOPT_0x10

;OPTIMIZER ADDED SUBROUTINE, CALLED 11 TIMES, CODE SIZE REDUCTION:28 WORDS
SUBOPT_0x14:
	LDI  R26,LOW(1000)
	LDI  R27,HIGH(1000)
	RCALL _delay_ms
	RJMP _lcd_clear

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:22 WORDS
SUBOPT_0x15:
	LDI  R30,LOW(5)
	ST   -Y,R30
	LDI  R26,LOW(0)
	RCALL _lcd_gotoxy
	__POINTW1FN _0x0,63
	RJMP SUBOPT_0x10

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x16:
	LDI  R30,LOW(7)
	ST   -Y,R30
	LDI  R26,LOW(1)
	RJMP _lcd_gotoxy

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:14 WORDS
SUBOPT_0x17:
	LDI  R26,LOW(1000)
	LDI  R27,HIGH(1000)
	RCALL _delay_ms
	RCALL _keypad
	CPI  R30,LOW(0xA)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x18:
	RCALL _lcd_clear
	__POINTW1FN _0x0,130
	RJMP SUBOPT_0x10

;OPTIMIZER ADDED SUBROUTINE, CALLED 10 TIMES, CODE SIZE REDUCTION:34 WORDS
SUBOPT_0x19:
	SBI  0x12,5
	LDI  R26,LOW(1000)
	LDI  R27,HIGH(1000)
	RCALL _delay_ms
	CBI  0x12,5
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x1A:
	RCALL _lcd_clear
	__POINTW1FN _0x0,145
	RJMP SUBOPT_0x10

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x1B:
	LDI  R26,LOW(1000)
	LDI  R27,HIGH(1000)
	RCALL _delay_ms
	RJMP SUBOPT_0x19

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x1C:
	RCALL _keypad
	LDI  R26,LOW(100)
	MUL  R30,R26
	MOVW R30,R0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x1D:
	RCALL _keypad
	LDI  R26,LOW(10)
	MUL  R30,R26
	MOVW R30,R0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1E:
	STS  _NewID,R30
	STS  _NewID+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x1F:
	LDS  R30,_NewID
	LDS  R31,_NewID+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 11 TIMES, CODE SIZE REDUCTION:28 WORDS
SUBOPT_0x20:
	LDS  R26,_NewID
	LDS  R27,_NewID+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x21:
	RCALL SUBOPT_0x20
	CPI  R26,LOW(0x80)
	LDI  R30,HIGH(0x80)
	CPC  R27,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x22:
	RCALL SUBOPT_0x20
	CPI  R26,LOW(0x82)
	LDI  R30,HIGH(0x82)
	CPC  R27,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x23:
	RCALL SUBOPT_0x20
	CPI  R26,LOW(0x84)
	LDI  R30,HIGH(0x84)
	CPC  R27,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x24:
	ST   -Y,R31
	ST   -Y,R30
	MOVW R26,R8
	LDI  R30,LOW(255)
	LDI  R31,HIGH(255)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x25:
	RCALL __MODW21U
	MOV  R26,R30
	RCALL _EE_Write
	RCALL SUBOPT_0x1F
	ADIW R30,1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x26:
	RCALL __DIVW21U
	MOV  R26,R30
	RCALL _EE_Write
	__POINTW1FN _0x0,203
	RJMP SUBOPT_0x10

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x27:
	LDI  R26,LOW(1000)
	LDI  R27,HIGH(1000)
	RCALL _delay_ms
	RJMP SUBOPT_0x5

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x28:
	ST   -Y,R31
	ST   -Y,R30
	MOVW R26,R12
	LDI  R30,LOW(255)
	LDI  R31,HIGH(255)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x29:
	ST   -Y,R0
	ST   -Y,R1
	ST   -Y,R15
	ST   -Y,R22
	ST   -Y,R23
	ST   -Y,R24
	ST   -Y,R25
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2A:
	RCALL __lcd_write_data
	LDI  R26,LOW(3)
	LDI  R27,0
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x2B:
	LDI  R26,LOW(48)
	RCALL __lcd_write_nibble_G100
	__DELAY_USW 200
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:18 WORDS
SUBOPT_0x2C:
	ST   -Y,R18
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:14 WORDS
SUBOPT_0x2D:
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	SBIW R30,4
	STD  Y+16,R30
	STD  Y+16+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x2E:
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x2F:
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,4
	LD   R30,X+
	LD   R31,X+
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	RET

;RUNTIME LIBRARY

	.CSEG
__SAVELOCR6:
	ST   -Y,R21
__SAVELOCR5:
	ST   -Y,R20
__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR6:
	LDD  R21,Y+5
__LOADLOCR5:
	LDD  R20,Y+4
__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

__ANEGW1:
	NEG  R31
	NEG  R30
	SBCI R31,0
	RET

__MULB1W2U:
	MOV  R22,R30
	MUL  R22,R26
	MOVW R30,R0
	MUL  R22,R27
	ADD  R31,R0
	RET

__DIVW21U:
	CLR  R0
	CLR  R1
	LDI  R25,16
__DIVW21U1:
	LSL  R26
	ROL  R27
	ROL  R0
	ROL  R1
	SUB  R0,R30
	SBC  R1,R31
	BRCC __DIVW21U2
	ADD  R0,R30
	ADC  R1,R31
	RJMP __DIVW21U3
__DIVW21U2:
	SBR  R26,1
__DIVW21U3:
	DEC  R25
	BRNE __DIVW21U1
	MOVW R30,R26
	MOVW R26,R0
	RET

__MODW21U:
	RCALL __DIVW21U
	MOVW R30,R26
	RET

__GETW1PF:
	LPM  R0,Z+
	LPM  R31,Z
	MOV  R30,R0
	RET

__PUTPARD1:
	ST   -Y,R23
	ST   -Y,R22
	ST   -Y,R31
	ST   -Y,R30
	RET

_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	wdr
	__DELAY_USW 0x7D0
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

;END OF CODE MARKER
__END_OF_CODE:
