
./logger_task:     file format elf32-littlearm


Disassembly of section .text:

00008000 <_start>:
_start():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/crt0.s:10
;@ startovaci symbol - vstupni bod z jadra OS do uzivatelskeho programu
;@ v podstate jen ihned zavola nejakou C funkci, nepotrebujeme nic tak kritickeho, abychom to vsechno museli psal v ASM
;@ jen _start vlastne ani neni funkce, takze by tento vstupni bod mel byt psany takto; rovnez je treba se ujistit, ze
;@ je tento symbol relokovany spravne na 0x8000 (tam OS ocekava, ze se nachazi vstupni bod)
_start:
    bl __crt0_run
    8000:	eb000017 	bl	8064 <__crt0_run>

00008004 <_hang>:
_hang():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/crt0.s:13
    ;@ z funkce __crt0_run by se nemel proces uz vratit, ale kdyby neco, tak se zacyklime
_hang:
    b _hang
    8004:	eafffffe 	b	8004 <_hang>

00008008 <__crt0_init_bss>:
__crt0_init_bss():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/crt0.c:10

extern unsigned int __bss_start;
extern unsigned int __bss_end;

void __crt0_init_bss()
{
    8008:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    800c:	e28db000 	add	fp, sp, #0
    8010:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/crt0.c:11
    for (unsigned int* cur = &__bss_start; cur < &__bss_end; cur++)
    8014:	e59f3040 	ldr	r3, [pc, #64]	; 805c <__crt0_init_bss+0x54>
    8018:	e50b3008 	str	r3, [fp, #-8]
    801c:	ea000005 	b	8038 <__crt0_init_bss+0x30>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/crt0.c:12 (discriminator 3)
        *cur = 0;
    8020:	e51b3008 	ldr	r3, [fp, #-8]
    8024:	e3a02000 	mov	r2, #0
    8028:	e5832000 	str	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/crt0.c:11 (discriminator 3)
    for (unsigned int* cur = &__bss_start; cur < &__bss_end; cur++)
    802c:	e51b3008 	ldr	r3, [fp, #-8]
    8030:	e2833004 	add	r3, r3, #4
    8034:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/crt0.c:11 (discriminator 1)
    8038:	e51b3008 	ldr	r3, [fp, #-8]
    803c:	e59f201c 	ldr	r2, [pc, #28]	; 8060 <__crt0_init_bss+0x58>
    8040:	e1530002 	cmp	r3, r2
    8044:	3afffff5 	bcc	8020 <__crt0_init_bss+0x18>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/crt0.c:13
}
    8048:	e320f000 	nop	{0}
    804c:	e320f000 	nop	{0}
    8050:	e28bd000 	add	sp, fp, #0
    8054:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8058:	e12fff1e 	bx	lr
    805c:	0000929c 	muleq	r0, ip, r2
    8060:	000092ac 	andeq	r9, r0, ip, lsr #5

00008064 <__crt0_run>:
__crt0_run():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/crt0.c:16

void __crt0_run()
{
    8064:	e92d4800 	push	{fp, lr}
    8068:	e28db004 	add	fp, sp, #4
    806c:	e24dd008 	sub	sp, sp, #8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/crt0.c:18
    // inicializace .bss sekce (vynulovani)
    __crt0_init_bss();
    8070:	ebffffe4 	bl	8008 <__crt0_init_bss>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/crt0.c:21

    // volani konstruktoru globalnich trid (C++)
    _cpp_startup();
    8074:	eb000040 	bl	817c <_cpp_startup>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/crt0.c:26

    // volani funkce main
    // nebudeme se zde zabyvat predavanim parametru do funkce main
    // jinak by se mohly predavat napr. namapovane do virtualniho adr. prostoru a odkazem pres zasobnik (kam nam muze OS pushnout co chce)
    int result = main(0, 0);
    8078:	e3a01000 	mov	r1, #0
    807c:	e3a00000 	mov	r0, #0
    8080:	eb000078 	bl	8268 <main>
    8084:	e50b0008 	str	r0, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/crt0.c:29

    // volani destruktoru globalnich trid (C++)
    _cpp_shutdown();
    8088:	eb000051 	bl	81d4 <_cpp_shutdown>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/crt0.c:32

    // volani terminate() syscallu s navratovym kodem funkce main
    asm volatile("mov r0, %0" : : "r" (result));
    808c:	e51b3008 	ldr	r3, [fp, #-8]
    8090:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/crt0.c:33
    asm volatile("svc #1");
    8094:	ef000001 	svc	0x00000001
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/crt0.c:34
}
    8098:	e320f000 	nop	{0}
    809c:	e24bd004 	sub	sp, fp, #4
    80a0:	e8bd8800 	pop	{fp, pc}

000080a4 <__cxa_guard_acquire>:
__cxa_guard_acquire():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/cxxabi.cpp:11
	extern "C" int __cxa_guard_acquire (__guard *);
	extern "C" void __cxa_guard_release (__guard *);
	extern "C" void __cxa_guard_abort (__guard *);

	extern "C" int __cxa_guard_acquire (__guard *g)
	{
    80a4:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    80a8:	e28db000 	add	fp, sp, #0
    80ac:	e24dd00c 	sub	sp, sp, #12
    80b0:	e50b0008 	str	r0, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/cxxabi.cpp:12
		return !*(char *)(g);
    80b4:	e51b3008 	ldr	r3, [fp, #-8]
    80b8:	e5d33000 	ldrb	r3, [r3]
    80bc:	e3530000 	cmp	r3, #0
    80c0:	03a03001 	moveq	r3, #1
    80c4:	13a03000 	movne	r3, #0
    80c8:	e6ef3073 	uxtb	r3, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/cxxabi.cpp:13
	}
    80cc:	e1a00003 	mov	r0, r3
    80d0:	e28bd000 	add	sp, fp, #0
    80d4:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    80d8:	e12fff1e 	bx	lr

000080dc <__cxa_guard_release>:
__cxa_guard_release():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/cxxabi.cpp:16

	extern "C" void __cxa_guard_release (__guard *g)
	{
    80dc:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    80e0:	e28db000 	add	fp, sp, #0
    80e4:	e24dd00c 	sub	sp, sp, #12
    80e8:	e50b0008 	str	r0, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/cxxabi.cpp:17
		*(char *)g = 1;
    80ec:	e51b3008 	ldr	r3, [fp, #-8]
    80f0:	e3a02001 	mov	r2, #1
    80f4:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/cxxabi.cpp:18
	}
    80f8:	e320f000 	nop	{0}
    80fc:	e28bd000 	add	sp, fp, #0
    8100:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8104:	e12fff1e 	bx	lr

00008108 <__cxa_guard_abort>:
__cxa_guard_abort():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/cxxabi.cpp:21

	extern "C" void __cxa_guard_abort (__guard *)
	{
    8108:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    810c:	e28db000 	add	fp, sp, #0
    8110:	e24dd00c 	sub	sp, sp, #12
    8114:	e50b0008 	str	r0, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/cxxabi.cpp:23

	}
    8118:	e320f000 	nop	{0}
    811c:	e28bd000 	add	sp, fp, #0
    8120:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8124:	e12fff1e 	bx	lr

00008128 <__dso_handle>:
__dso_handle():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/cxxabi.cpp:27
}

extern "C" void __dso_handle()
{
    8128:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    812c:	e28db000 	add	fp, sp, #0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/cxxabi.cpp:29
    // ignore dtors for now
}
    8130:	e320f000 	nop	{0}
    8134:	e28bd000 	add	sp, fp, #0
    8138:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    813c:	e12fff1e 	bx	lr

00008140 <__cxa_atexit>:
__cxa_atexit():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/cxxabi.cpp:32

extern "C" void __cxa_atexit()
{
    8140:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8144:	e28db000 	add	fp, sp, #0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/cxxabi.cpp:34
    // ignore dtors for now
}
    8148:	e320f000 	nop	{0}
    814c:	e28bd000 	add	sp, fp, #0
    8150:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8154:	e12fff1e 	bx	lr

00008158 <__cxa_pure_virtual>:
__cxa_pure_virtual():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/cxxabi.cpp:37

extern "C" void __cxa_pure_virtual()
{
    8158:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    815c:	e28db000 	add	fp, sp, #0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/cxxabi.cpp:39
    // pure virtual method called
}
    8160:	e320f000 	nop	{0}
    8164:	e28bd000 	add	sp, fp, #0
    8168:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    816c:	e12fff1e 	bx	lr

00008170 <__aeabi_unwind_cpp_pr1>:
__aeabi_unwind_cpp_pr1():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/cxxabi.cpp:42

extern "C" void __aeabi_unwind_cpp_pr1()
{
    8170:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8174:	e28db000 	add	fp, sp, #0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/cxxabi.cpp:43 (discriminator 1)
	while (true)
    8178:	eafffffe 	b	8178 <__aeabi_unwind_cpp_pr1+0x8>

0000817c <_cpp_startup>:
_cpp_startup():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/cxxabi.cpp:61
extern "C" dtor_ptr __DTOR_LIST__[0];
// konec pole destruktoru
extern "C" dtor_ptr __DTOR_END__[0];

extern "C" int _cpp_startup(void)
{
    817c:	e92d4800 	push	{fp, lr}
    8180:	e28db004 	add	fp, sp, #4
    8184:	e24dd008 	sub	sp, sp, #8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/cxxabi.cpp:66
	ctor_ptr* fnptr;
	
	// zavolame konstruktory globalnich C++ trid
	// v poli __CTOR_LIST__ jsou ukazatele na vygenerovane stuby volani konstruktoru
	for (fnptr = __CTOR_LIST__; fnptr < __CTOR_END__; fnptr++)
    8188:	e59f303c 	ldr	r3, [pc, #60]	; 81cc <_cpp_startup+0x50>
    818c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/cxxabi.cpp:66 (discriminator 3)
    8190:	e51b3008 	ldr	r3, [fp, #-8]
    8194:	e59f2034 	ldr	r2, [pc, #52]	; 81d0 <_cpp_startup+0x54>
    8198:	e1530002 	cmp	r3, r2
    819c:	2a000006 	bcs	81bc <_cpp_startup+0x40>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/cxxabi.cpp:67 (discriminator 2)
		(*fnptr)();
    81a0:	e51b3008 	ldr	r3, [fp, #-8]
    81a4:	e5933000 	ldr	r3, [r3]
    81a8:	e12fff33 	blx	r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/cxxabi.cpp:66 (discriminator 2)
	for (fnptr = __CTOR_LIST__; fnptr < __CTOR_END__; fnptr++)
    81ac:	e51b3008 	ldr	r3, [fp, #-8]
    81b0:	e2833004 	add	r3, r3, #4
    81b4:	e50b3008 	str	r3, [fp, #-8]
    81b8:	eafffff4 	b	8190 <_cpp_startup+0x14>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/cxxabi.cpp:69
	
	return 0;
    81bc:	e3a03000 	mov	r3, #0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/cxxabi.cpp:70
}
    81c0:	e1a00003 	mov	r0, r3
    81c4:	e24bd004 	sub	sp, fp, #4
    81c8:	e8bd8800 	pop	{fp, pc}
    81cc:	00009299 	muleq	r0, r9, r2
    81d0:	00009299 	muleq	r0, r9, r2

000081d4 <_cpp_shutdown>:
_cpp_shutdown():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/cxxabi.cpp:73

extern "C" int _cpp_shutdown(void)
{
    81d4:	e92d4800 	push	{fp, lr}
    81d8:	e28db004 	add	fp, sp, #4
    81dc:	e24dd008 	sub	sp, sp, #8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/cxxabi.cpp:77
	dtor_ptr* fnptr;
	
	// zavolame destruktory globalnich C++ trid
	for (fnptr = __DTOR_LIST__; fnptr < __DTOR_END__; fnptr++)
    81e0:	e59f303c 	ldr	r3, [pc, #60]	; 8224 <_cpp_shutdown+0x50>
    81e4:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/cxxabi.cpp:77 (discriminator 3)
    81e8:	e51b3008 	ldr	r3, [fp, #-8]
    81ec:	e59f2034 	ldr	r2, [pc, #52]	; 8228 <_cpp_shutdown+0x54>
    81f0:	e1530002 	cmp	r3, r2
    81f4:	2a000006 	bcs	8214 <_cpp_shutdown+0x40>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/cxxabi.cpp:78 (discriminator 2)
		(*fnptr)();
    81f8:	e51b3008 	ldr	r3, [fp, #-8]
    81fc:	e5933000 	ldr	r3, [r3]
    8200:	e12fff33 	blx	r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/cxxabi.cpp:77 (discriminator 2)
	for (fnptr = __DTOR_LIST__; fnptr < __DTOR_END__; fnptr++)
    8204:	e51b3008 	ldr	r3, [fp, #-8]
    8208:	e2833004 	add	r3, r3, #4
    820c:	e50b3008 	str	r3, [fp, #-8]
    8210:	eafffff4 	b	81e8 <_cpp_shutdown+0x14>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/cxxabi.cpp:80
	
	return 0;
    8214:	e3a03000 	mov	r3, #0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/cxxabi.cpp:81
}
    8218:	e1a00003 	mov	r0, r3
    821c:	e24bd004 	sub	sp, fp, #4
    8220:	e8bd8800 	pop	{fp, pc}
    8224:	00009299 	muleq	r0, r9, r2
    8228:	00009299 	muleq	r0, r9, r2

0000822c <_ZL5fputsjPKc>:
_ZL5fputsjPKc():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/logger_task/main.cpp:14
 * 
 * Prijima vsechny udalosti od ostatnich tasku a oznamuje je skrz UART hostiteli
 **/

static void fputs(uint32_t file, const char* string)
{
    822c:	e92d4800 	push	{fp, lr}
    8230:	e28db004 	add	fp, sp, #4
    8234:	e24dd008 	sub	sp, sp, #8
    8238:	e50b0008 	str	r0, [fp, #-8]
    823c:	e50b100c 	str	r1, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/logger_task/main.cpp:15
	write(file, string, strlen(string));
    8240:	e51b000c 	ldr	r0, [fp, #-12]
    8244:	eb0002f9 	bl	8e30 <_Z6strlenPKc>
    8248:	e1a03000 	mov	r3, r0
    824c:	e1a02003 	mov	r2, r3
    8250:	e51b100c 	ldr	r1, [fp, #-12]
    8254:	e51b0008 	ldr	r0, [fp, #-8]
    8258:	eb00009b 	bl	84cc <_Z5writejPKcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/logger_task/main.cpp:16
}
    825c:	e320f000 	nop	{0}
    8260:	e24bd004 	sub	sp, fp, #4
    8264:	e8bd8800 	pop	{fp, pc}

00008268 <main>:
main():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/logger_task/main.cpp:19

int main(int argc, char** argv)
{
    8268:	e92d4800 	push	{fp, lr}
    826c:	e28db004 	add	fp, sp, #4
    8270:	e24dd0e0 	sub	sp, sp, #224	; 0xe0
    8274:	e50b00e0 	str	r0, [fp, #-224]	; 0xffffff20
    8278:	e50b10e4 	str	r1, [fp, #-228]	; 0xffffff1c
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/logger_task/main.cpp:20
	uint32_t uart_file = open("DEV:uart/0", NFile_Open_Mode::Write_Only);
    827c:	e3a01001 	mov	r1, #1
    8280:	e59f0124 	ldr	r0, [pc, #292]	; 83ac <main+0x144>
    8284:	eb00006b 	bl	8438 <_Z4openPKc15NFile_Open_Mode>
    8288:	e50b0008 	str	r0, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/logger_task/main.cpp:23

	TUART_IOCtl_Params params;
	params.baud_rate = NUART_Baud_Rate::BR_115200;
    828c:	e59f311c 	ldr	r3, [pc, #284]	; 83b0 <main+0x148>
    8290:	e50b3020 	str	r3, [fp, #-32]	; 0xffffffe0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/logger_task/main.cpp:24
	params.char_length = NUART_Char_Length::Char_8;
    8294:	e3a03001 	mov	r3, #1
    8298:	e50b3024 	str	r3, [fp, #-36]	; 0xffffffdc
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/logger_task/main.cpp:25
	ioctl(uart_file, NIOCtl_Operation::Set_Params, &params);
    829c:	e24b3024 	sub	r3, fp, #36	; 0x24
    82a0:	e1a02003 	mov	r2, r3
    82a4:	e3a01001 	mov	r1, #1
    82a8:	e51b0008 	ldr	r0, [fp, #-8]
    82ac:	eb0000a5 	bl	8548 <_Z5ioctlj16NIOCtl_OperationPv>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/logger_task/main.cpp:27

	fputs(uart_file, "Logger task starting!");
    82b0:	e59f10fc 	ldr	r1, [pc, #252]	; 83b4 <main+0x14c>
    82b4:	e51b0008 	ldr	r0, [fp, #-8]
    82b8:	ebffffdb 	bl	822c <_ZL5fputsjPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/logger_task/main.cpp:32

	char buf[33];
	char big_buf[128];
	char tickbuf[16];
	bzero(big_buf, 128);
    82bc:	e24b30c8 	sub	r3, fp, #200	; 0xc8
    82c0:	e3a01080 	mov	r1, #128	; 0x80
    82c4:	e1a00003 	mov	r0, r3
    82c8:	eb0002ed 	bl	8e84 <_Z5bzeroPvi>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/logger_task/main.cpp:33
	bzero(tickbuf, 16);
    82cc:	e24b30d8 	sub	r3, fp, #216	; 0xd8
    82d0:	e3a01010 	mov	r1, #16
    82d4:	e1a00003 	mov	r0, r3
    82d8:	eb0002e9 	bl	8e84 <_Z5bzeroPvi>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/logger_task/main.cpp:34
	bzero(buf, 33);
    82dc:	e24b3048 	sub	r3, fp, #72	; 0x48
    82e0:	e3a01021 	mov	r1, #33	; 0x21
    82e4:	e1a00003 	mov	r0, r3
    82e8:	eb0002e5 	bl	8e84 <_Z5bzeroPvi>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/logger_task/main.cpp:37
	

	uint32_t last_tick = 0, free_index = 0;
    82ec:	e3a03000 	mov	r3, #0
    82f0:	e50b300c 	str	r3, [fp, #-12]
    82f4:	e3a03000 	mov	r3, #0
    82f8:	e50b3010 	str	r3, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/logger_task/main.cpp:39

	uint32_t logpipe = pipe("log", 128);
    82fc:	e3a01080 	mov	r1, #128	; 0x80
    8300:	e59f00b0 	ldr	r0, [pc, #176]	; 83b8 <main+0x150>
    8304:	eb000119 	bl	8770 <_Z4pipePKcj>
    8308:	e50b0014 	str	r0, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/logger_task/main.cpp:44

	while (true)
	{
		
		wait(logpipe, 1, 0x1000);
    830c:	e3a02a01 	mov	r2, #4096	; 0x1000
    8310:	e3a01001 	mov	r1, #1
    8314:	e51b0014 	ldr	r0, [fp, #-20]	; 0xffffffec
    8318:	eb0000af 	bl	85dc <_Z4waitjjj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/logger_task/main.cpp:45
		uint32_t v = read(logpipe, buf, 32);
    831c:	e24b3048 	sub	r3, fp, #72	; 0x48
    8320:	e3a02020 	mov	r2, #32
    8324:	e1a01003 	mov	r1, r3
    8328:	e51b0014 	ldr	r0, [fp, #-20]	; 0xffffffec
    832c:	eb000052 	bl	847c <_Z4readjPcj>
    8330:	e50b0018 	str	r0, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/logger_task/main.cpp:69
		// 		// zero out the buffer
		// 		bzero(buf, 129);
		// 		free_index = 0;
		// 	}
		// }
		if (v > 0)
    8334:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8338:	e3530000 	cmp	r3, #0
    833c:	0afffff2 	beq	830c <main+0xa4>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/logger_task/main.cpp:71
		{
			buf[v] = '\0';
    8340:	e24b2048 	sub	r2, fp, #72	; 0x48
    8344:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8348:	e0823003 	add	r3, r2, r3
    834c:	e3a02000 	mov	r2, #0
    8350:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/logger_task/main.cpp:72
			fputs(uart_file, "\r\n[ ");
    8354:	e59f1060 	ldr	r1, [pc, #96]	; 83bc <main+0x154>
    8358:	e51b0008 	ldr	r0, [fp, #-8]
    835c:	ebffffb2 	bl	822c <_ZL5fputsjPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/logger_task/main.cpp:73
			uint32_t tick = get_tick_count();
    8360:	eb0000d5 	bl	86bc <_Z14get_tick_countv>
    8364:	e50b001c 	str	r0, [fp, #-28]	; 0xffffffe4
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/logger_task/main.cpp:74
			itoa(tick, tickbuf, 16);
    8368:	e24b30d8 	sub	r3, fp, #216	; 0xd8
    836c:	e3a02010 	mov	r2, #16
    8370:	e1a01003 	mov	r1, r3
    8374:	e51b001c 	ldr	r0, [fp, #-28]	; 0xffffffe4
    8378:	eb000128 	bl	8820 <_Z4itoajPcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/logger_task/main.cpp:75
			fputs(uart_file, tickbuf);
    837c:	e24b30d8 	sub	r3, fp, #216	; 0xd8
    8380:	e1a01003 	mov	r1, r3
    8384:	e51b0008 	ldr	r0, [fp, #-8]
    8388:	ebffffa7 	bl	822c <_ZL5fputsjPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/logger_task/main.cpp:76
			fputs(uart_file, "]: ");
    838c:	e59f102c 	ldr	r1, [pc, #44]	; 83c0 <main+0x158>
    8390:	e51b0008 	ldr	r0, [fp, #-8]
    8394:	ebffffa4 	bl	822c <_ZL5fputsjPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/logger_task/main.cpp:77
			fputs(uart_file, buf);
    8398:	e24b3048 	sub	r3, fp, #72	; 0x48
    839c:	e1a01003 	mov	r1, r3
    83a0:	e51b0008 	ldr	r0, [fp, #-8]
    83a4:	ebffffa0 	bl	822c <_ZL5fputsjPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/logger_task/main.cpp:79
		}
	}
    83a8:	eaffffd7 	b	830c <main+0xa4>
    83ac:	0000921c 	andeq	r9, r0, ip, lsl r2
    83b0:	0001c200 	andeq	ip, r1, r0, lsl #4
    83b4:	00009228 	andeq	r9, r0, r8, lsr #4
    83b8:	00009240 	andeq	r9, r0, r0, asr #4
    83bc:	00009244 	andeq	r9, r0, r4, asr #4
    83c0:	0000924c 	andeq	r9, r0, ip, asr #4

000083c4 <_Z6getpidv>:
_Z6getpidv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:5
#include <stdfile.h>
#include <stdstring.h>

uint32_t getpid()
{
    83c4:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    83c8:	e28db000 	add	fp, sp, #0
    83cc:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:8
    uint32_t pid;

    asm volatile("swi 0");
    83d0:	ef000000 	svc	0x00000000
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:9
    asm volatile("mov %0, r0" : "=r" (pid));
    83d4:	e1a03000 	mov	r3, r0
    83d8:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:11

    return pid;
    83dc:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:12
}
    83e0:	e1a00003 	mov	r0, r3
    83e4:	e28bd000 	add	sp, fp, #0
    83e8:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    83ec:	e12fff1e 	bx	lr

000083f0 <_Z9terminatei>:
_Z9terminatei():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:15

void terminate(int exitcode)
{
    83f0:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    83f4:	e28db000 	add	fp, sp, #0
    83f8:	e24dd00c 	sub	sp, sp, #12
    83fc:	e50b0008 	str	r0, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:16
    asm volatile("mov r0, %0" : : "r" (exitcode));
    8400:	e51b3008 	ldr	r3, [fp, #-8]
    8404:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:17
    asm volatile("swi 1");
    8408:	ef000001 	svc	0x00000001
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:18
}
    840c:	e320f000 	nop	{0}
    8410:	e28bd000 	add	sp, fp, #0
    8414:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8418:	e12fff1e 	bx	lr

0000841c <_Z11sched_yieldv>:
_Z11sched_yieldv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:21

void sched_yield()
{
    841c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8420:	e28db000 	add	fp, sp, #0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:22
    asm volatile("swi 2");
    8424:	ef000002 	svc	0x00000002
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:23
}
    8428:	e320f000 	nop	{0}
    842c:	e28bd000 	add	sp, fp, #0
    8430:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8434:	e12fff1e 	bx	lr

00008438 <_Z4openPKc15NFile_Open_Mode>:
_Z4openPKc15NFile_Open_Mode():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:26

uint32_t open(const char* filename, NFile_Open_Mode mode)
{
    8438:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    843c:	e28db000 	add	fp, sp, #0
    8440:	e24dd014 	sub	sp, sp, #20
    8444:	e50b0010 	str	r0, [fp, #-16]
    8448:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:29
    uint32_t file;

    asm volatile("mov r0, %0" : : "r" (filename));
    844c:	e51b3010 	ldr	r3, [fp, #-16]
    8450:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:30
    asm volatile("mov r1, %0" : : "r" (mode));
    8454:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8458:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:31
    asm volatile("swi 64");
    845c:	ef000040 	svc	0x00000040
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:32
    asm volatile("mov %0, r0" : "=r" (file));
    8460:	e1a03000 	mov	r3, r0
    8464:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:33
    return file;
    8468:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:34
}
    846c:	e1a00003 	mov	r0, r3
    8470:	e28bd000 	add	sp, fp, #0
    8474:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8478:	e12fff1e 	bx	lr

0000847c <_Z4readjPcj>:
_Z4readjPcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:37

uint32_t read(uint32_t file, char* const buffer, uint32_t size)
{
    847c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8480:	e28db000 	add	fp, sp, #0
    8484:	e24dd01c 	sub	sp, sp, #28
    8488:	e50b0010 	str	r0, [fp, #-16]
    848c:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8490:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:40
    uint32_t rdnum;

    asm volatile("mov r0, %0" : : "r" (file));
    8494:	e51b3010 	ldr	r3, [fp, #-16]
    8498:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:41
    asm volatile("mov r1, %0" : : "r" (buffer));
    849c:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    84a0:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:42
    asm volatile("mov r2, %0" : : "r" (size));
    84a4:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    84a8:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:43
    asm volatile("swi 65");
    84ac:	ef000041 	svc	0x00000041
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:44
    asm volatile("mov %0, r0" : "=r" (rdnum));
    84b0:	e1a03000 	mov	r3, r0
    84b4:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:46

    return rdnum;
    84b8:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:47
}
    84bc:	e1a00003 	mov	r0, r3
    84c0:	e28bd000 	add	sp, fp, #0
    84c4:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    84c8:	e12fff1e 	bx	lr

000084cc <_Z5writejPKcj>:
_Z5writejPKcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:50

uint32_t write(uint32_t file, const char* buffer, uint32_t size)
{
    84cc:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    84d0:	e28db000 	add	fp, sp, #0
    84d4:	e24dd01c 	sub	sp, sp, #28
    84d8:	e50b0010 	str	r0, [fp, #-16]
    84dc:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    84e0:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:53
    uint32_t wrnum;

    asm volatile("mov r0, %0" : : "r" (file));
    84e4:	e51b3010 	ldr	r3, [fp, #-16]
    84e8:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:54
    asm volatile("mov r1, %0" : : "r" (buffer));
    84ec:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    84f0:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:55
    asm volatile("mov r2, %0" : : "r" (size));
    84f4:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    84f8:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:56
    asm volatile("swi 66");
    84fc:	ef000042 	svc	0x00000042
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:57
    asm volatile("mov %0, r0" : "=r" (wrnum));
    8500:	e1a03000 	mov	r3, r0
    8504:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:59

    return wrnum;
    8508:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:60
}
    850c:	e1a00003 	mov	r0, r3
    8510:	e28bd000 	add	sp, fp, #0
    8514:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8518:	e12fff1e 	bx	lr

0000851c <_Z5closej>:
_Z5closej():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:63

void close(uint32_t file)
{
    851c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8520:	e28db000 	add	fp, sp, #0
    8524:	e24dd00c 	sub	sp, sp, #12
    8528:	e50b0008 	str	r0, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:64
    asm volatile("mov r0, %0" : : "r" (file));
    852c:	e51b3008 	ldr	r3, [fp, #-8]
    8530:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:65
    asm volatile("swi 67");
    8534:	ef000043 	svc	0x00000043
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:66
}
    8538:	e320f000 	nop	{0}
    853c:	e28bd000 	add	sp, fp, #0
    8540:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8544:	e12fff1e 	bx	lr

00008548 <_Z5ioctlj16NIOCtl_OperationPv>:
_Z5ioctlj16NIOCtl_OperationPv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:69

uint32_t ioctl(uint32_t file, NIOCtl_Operation operation, void* param)
{
    8548:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    854c:	e28db000 	add	fp, sp, #0
    8550:	e24dd01c 	sub	sp, sp, #28
    8554:	e50b0010 	str	r0, [fp, #-16]
    8558:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    855c:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:72
    uint32_t retcode;

    asm volatile("mov r0, %0" : : "r" (file));
    8560:	e51b3010 	ldr	r3, [fp, #-16]
    8564:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:73
    asm volatile("mov r1, %0" : : "r" (operation));
    8568:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    856c:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:74
    asm volatile("mov r2, %0" : : "r" (param));
    8570:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8574:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:75
    asm volatile("swi 68");
    8578:	ef000044 	svc	0x00000044
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:76
    asm volatile("mov %0, r0" : "=r" (retcode));
    857c:	e1a03000 	mov	r3, r0
    8580:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:78

    return retcode;
    8584:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:79
}
    8588:	e1a00003 	mov	r0, r3
    858c:	e28bd000 	add	sp, fp, #0
    8590:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8594:	e12fff1e 	bx	lr

00008598 <_Z6notifyjj>:
_Z6notifyjj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:82

uint32_t notify(uint32_t file, uint32_t count)
{
    8598:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    859c:	e28db000 	add	fp, sp, #0
    85a0:	e24dd014 	sub	sp, sp, #20
    85a4:	e50b0010 	str	r0, [fp, #-16]
    85a8:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:85
    uint32_t retcnt;

    asm volatile("mov r0, %0" : : "r" (file));
    85ac:	e51b3010 	ldr	r3, [fp, #-16]
    85b0:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:86
    asm volatile("mov r1, %0" : : "r" (count));
    85b4:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    85b8:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:87
    asm volatile("swi 69");
    85bc:	ef000045 	svc	0x00000045
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:88
    asm volatile("mov %0, r0" : "=r" (retcnt));
    85c0:	e1a03000 	mov	r3, r0
    85c4:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:90

    return retcnt;
    85c8:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:91
}
    85cc:	e1a00003 	mov	r0, r3
    85d0:	e28bd000 	add	sp, fp, #0
    85d4:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    85d8:	e12fff1e 	bx	lr

000085dc <_Z4waitjjj>:
_Z4waitjjj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:94

NSWI_Result_Code wait(uint32_t file, uint32_t count, uint32_t notified_deadline)
{
    85dc:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    85e0:	e28db000 	add	fp, sp, #0
    85e4:	e24dd01c 	sub	sp, sp, #28
    85e8:	e50b0010 	str	r0, [fp, #-16]
    85ec:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    85f0:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:97
    NSWI_Result_Code retcode;

    asm volatile("mov r0, %0" : : "r" (file));
    85f4:	e51b3010 	ldr	r3, [fp, #-16]
    85f8:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:98
    asm volatile("mov r1, %0" : : "r" (count));
    85fc:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8600:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:99
    asm volatile("mov r2, %0" : : "r" (notified_deadline));
    8604:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8608:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:100
    asm volatile("swi 70");
    860c:	ef000046 	svc	0x00000046
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:101
    asm volatile("mov %0, r0" : "=r" (retcode));
    8610:	e1a03000 	mov	r3, r0
    8614:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:103

    return retcode;
    8618:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:104
}
    861c:	e1a00003 	mov	r0, r3
    8620:	e28bd000 	add	sp, fp, #0
    8624:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8628:	e12fff1e 	bx	lr

0000862c <_Z5sleepjj>:
_Z5sleepjj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:107

bool sleep(uint32_t ticks, uint32_t notified_deadline)
{
    862c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8630:	e28db000 	add	fp, sp, #0
    8634:	e24dd014 	sub	sp, sp, #20
    8638:	e50b0010 	str	r0, [fp, #-16]
    863c:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:110
    uint32_t retcode;

    asm volatile("mov r0, %0" : : "r" (ticks));
    8640:	e51b3010 	ldr	r3, [fp, #-16]
    8644:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:111
    asm volatile("mov r1, %0" : : "r" (notified_deadline));
    8648:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    864c:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:112
    asm volatile("swi 3");
    8650:	ef000003 	svc	0x00000003
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:113
    asm volatile("mov %0, r0" : "=r" (retcode));
    8654:	e1a03000 	mov	r3, r0
    8658:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:115

    return retcode;
    865c:	e51b3008 	ldr	r3, [fp, #-8]
    8660:	e3530000 	cmp	r3, #0
    8664:	13a03001 	movne	r3, #1
    8668:	03a03000 	moveq	r3, #0
    866c:	e6ef3073 	uxtb	r3, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:116
}
    8670:	e1a00003 	mov	r0, r3
    8674:	e28bd000 	add	sp, fp, #0
    8678:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    867c:	e12fff1e 	bx	lr

00008680 <_Z24get_active_process_countv>:
_Z24get_active_process_countv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:119

uint32_t get_active_process_count()
{
    8680:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8684:	e28db000 	add	fp, sp, #0
    8688:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:120
    const NGet_Sched_Info_Type req = NGet_Sched_Info_Type::Active_Process_Count;
    868c:	e3a03000 	mov	r3, #0
    8690:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:123
    uint32_t retval;

    asm volatile("mov r0, %0" : : "r" (req));
    8694:	e3a03000 	mov	r3, #0
    8698:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:124
    asm volatile("mov r1, %0" : : "r" (&retval));
    869c:	e24b300c 	sub	r3, fp, #12
    86a0:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:125
    asm volatile("swi 4");
    86a4:	ef000004 	svc	0x00000004
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:127

    return retval;
    86a8:	e51b300c 	ldr	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:128
}
    86ac:	e1a00003 	mov	r0, r3
    86b0:	e28bd000 	add	sp, fp, #0
    86b4:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    86b8:	e12fff1e 	bx	lr

000086bc <_Z14get_tick_countv>:
_Z14get_tick_countv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:131

uint32_t get_tick_count()
{
    86bc:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    86c0:	e28db000 	add	fp, sp, #0
    86c4:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:132
    const NGet_Sched_Info_Type req = NGet_Sched_Info_Type::Tick_Count;
    86c8:	e3a03001 	mov	r3, #1
    86cc:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:135
    uint32_t retval;

    asm volatile("mov r0, %0" : : "r" (req));
    86d0:	e3a03001 	mov	r3, #1
    86d4:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:136
    asm volatile("mov r1, %0" : : "r" (&retval));
    86d8:	e24b300c 	sub	r3, fp, #12
    86dc:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:137
    asm volatile("swi 4");
    86e0:	ef000004 	svc	0x00000004
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:139

    return retval;
    86e4:	e51b300c 	ldr	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:140
}
    86e8:	e1a00003 	mov	r0, r3
    86ec:	e28bd000 	add	sp, fp, #0
    86f0:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    86f4:	e12fff1e 	bx	lr

000086f8 <_Z17set_task_deadlinej>:
_Z17set_task_deadlinej():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:143

void set_task_deadline(uint32_t tick_count_required)
{
    86f8:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    86fc:	e28db000 	add	fp, sp, #0
    8700:	e24dd014 	sub	sp, sp, #20
    8704:	e50b0010 	str	r0, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:144
    const NDeadline_Subservice req = NDeadline_Subservice::Set_Relative;
    8708:	e3a03000 	mov	r3, #0
    870c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:146

    asm volatile("mov r0, %0" : : "r" (req));
    8710:	e3a03000 	mov	r3, #0
    8714:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:147
    asm volatile("mov r1, %0" : : "r" (&tick_count_required));
    8718:	e24b3010 	sub	r3, fp, #16
    871c:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:148
    asm volatile("swi 5");
    8720:	ef000005 	svc	0x00000005
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:149
}
    8724:	e320f000 	nop	{0}
    8728:	e28bd000 	add	sp, fp, #0
    872c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8730:	e12fff1e 	bx	lr

00008734 <_Z26get_task_ticks_to_deadlinev>:
_Z26get_task_ticks_to_deadlinev():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:152

uint32_t get_task_ticks_to_deadline()
{
    8734:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8738:	e28db000 	add	fp, sp, #0
    873c:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:153
    const NDeadline_Subservice req = NDeadline_Subservice::Get_Remaining;
    8740:	e3a03001 	mov	r3, #1
    8744:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:156
    uint32_t ticks;

    asm volatile("mov r0, %0" : : "r" (req));
    8748:	e3a03001 	mov	r3, #1
    874c:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:157
    asm volatile("mov r1, %0" : : "r" (&ticks));
    8750:	e24b300c 	sub	r3, fp, #12
    8754:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:158
    asm volatile("swi 5");
    8758:	ef000005 	svc	0x00000005
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:160

    return ticks;
    875c:	e51b300c 	ldr	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:161
}
    8760:	e1a00003 	mov	r0, r3
    8764:	e28bd000 	add	sp, fp, #0
    8768:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    876c:	e12fff1e 	bx	lr

00008770 <_Z4pipePKcj>:
_Z4pipePKcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:166

const char Pipe_File_Prefix[] = "SYS:pipe/";

uint32_t pipe(const char* name, uint32_t buf_size)
{
    8770:	e92d4800 	push	{fp, lr}
    8774:	e28db004 	add	fp, sp, #4
    8778:	e24dd050 	sub	sp, sp, #80	; 0x50
    877c:	e50b0050 	str	r0, [fp, #-80]	; 0xffffffb0
    8780:	e50b1054 	str	r1, [fp, #-84]	; 0xffffffac
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:168
    char fname[64];
    strncpy(fname, Pipe_File_Prefix, sizeof(Pipe_File_Prefix));
    8784:	e24b3048 	sub	r3, fp, #72	; 0x48
    8788:	e3a0200a 	mov	r2, #10
    878c:	e59f1088 	ldr	r1, [pc, #136]	; 881c <_Z4pipePKcj+0xac>
    8790:	e1a00003 	mov	r0, r3
    8794:	eb00014a 	bl	8cc4 <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:169
    strncpy(fname + sizeof(Pipe_File_Prefix), name, sizeof(fname) - sizeof(Pipe_File_Prefix) - 1);
    8798:	e24b3048 	sub	r3, fp, #72	; 0x48
    879c:	e283300a 	add	r3, r3, #10
    87a0:	e3a02035 	mov	r2, #53	; 0x35
    87a4:	e51b1050 	ldr	r1, [fp, #-80]	; 0xffffffb0
    87a8:	e1a00003 	mov	r0, r3
    87ac:	eb000144 	bl	8cc4 <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:171

    int ncur = sizeof(Pipe_File_Prefix) + strlen(name);
    87b0:	e51b0050 	ldr	r0, [fp, #-80]	; 0xffffffb0
    87b4:	eb00019d 	bl	8e30 <_Z6strlenPKc>
    87b8:	e1a03000 	mov	r3, r0
    87bc:	e283300a 	add	r3, r3, #10
    87c0:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:173

    fname[ncur++] = '#';
    87c4:	e51b3008 	ldr	r3, [fp, #-8]
    87c8:	e2832001 	add	r2, r3, #1
    87cc:	e50b2008 	str	r2, [fp, #-8]
    87d0:	e2433004 	sub	r3, r3, #4
    87d4:	e083300b 	add	r3, r3, fp
    87d8:	e3a02023 	mov	r2, #35	; 0x23
    87dc:	e5432044 	strb	r2, [r3, #-68]	; 0xffffffbc
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:175

    itoa(buf_size, &fname[ncur], 10);
    87e0:	e24b2048 	sub	r2, fp, #72	; 0x48
    87e4:	e51b3008 	ldr	r3, [fp, #-8]
    87e8:	e0823003 	add	r3, r2, r3
    87ec:	e3a0200a 	mov	r2, #10
    87f0:	e1a01003 	mov	r1, r3
    87f4:	e51b0054 	ldr	r0, [fp, #-84]	; 0xffffffac
    87f8:	eb000008 	bl	8820 <_Z4itoajPcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:177

    return open(fname, NFile_Open_Mode::Read_Write);
    87fc:	e24b3048 	sub	r3, fp, #72	; 0x48
    8800:	e3a01002 	mov	r1, #2
    8804:	e1a00003 	mov	r0, r3
    8808:	ebffff0a 	bl	8438 <_Z4openPKc15NFile_Open_Mode>
    880c:	e1a03000 	mov	r3, r0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:178
}
    8810:	e1a00003 	mov	r0, r3
    8814:	e24bd004 	sub	sp, fp, #4
    8818:	e8bd8800 	pop	{fp, pc}
    881c:	0000927c 	andeq	r9, r0, ip, ror r2

00008820 <_Z4itoajPcj>:
_Z4itoajPcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:9
{
    const char CharConvArr[] = "0123456789ABCDEF";
}

void itoa(unsigned int input, char* output, unsigned int base)
{
    8820:	e92d4800 	push	{fp, lr}
    8824:	e28db004 	add	fp, sp, #4
    8828:	e24dd020 	sub	sp, sp, #32
    882c:	e50b0018 	str	r0, [fp, #-24]	; 0xffffffe8
    8830:	e50b101c 	str	r1, [fp, #-28]	; 0xffffffe4
    8834:	e50b2020 	str	r2, [fp, #-32]	; 0xffffffe0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:10
	int i = 0;
    8838:	e3a03000 	mov	r3, #0
    883c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:12

	while (input > 0)
    8840:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8844:	e3530000 	cmp	r3, #0
    8848:	0a000014 	beq	88a0 <_Z4itoajPcj+0x80>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:14
	{
		output[i] = CharConvArr[input % base];
    884c:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8850:	e51b1020 	ldr	r1, [fp, #-32]	; 0xffffffe0
    8854:	e1a00003 	mov	r0, r3
    8858:	eb00025b 	bl	91cc <__aeabi_uidivmod>
    885c:	e1a03001 	mov	r3, r1
    8860:	e1a01003 	mov	r1, r3
    8864:	e51b3008 	ldr	r3, [fp, #-8]
    8868:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    886c:	e0823003 	add	r3, r2, r3
    8870:	e59f2118 	ldr	r2, [pc, #280]	; 8990 <_Z4itoajPcj+0x170>
    8874:	e7d22001 	ldrb	r2, [r2, r1]
    8878:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:15
		input /= base;
    887c:	e51b1020 	ldr	r1, [fp, #-32]	; 0xffffffe0
    8880:	e51b0018 	ldr	r0, [fp, #-24]	; 0xffffffe8
    8884:	eb0001d5 	bl	8fe0 <__udivsi3>
    8888:	e1a03000 	mov	r3, r0
    888c:	e50b3018 	str	r3, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:16
		i++;
    8890:	e51b3008 	ldr	r3, [fp, #-8]
    8894:	e2833001 	add	r3, r3, #1
    8898:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:12
	while (input > 0)
    889c:	eaffffe7 	b	8840 <_Z4itoajPcj+0x20>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:19
	}

    if (i == 0)
    88a0:	e51b3008 	ldr	r3, [fp, #-8]
    88a4:	e3530000 	cmp	r3, #0
    88a8:	1a000007 	bne	88cc <_Z4itoajPcj+0xac>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:21
    {
        output[i] = CharConvArr[0];
    88ac:	e51b3008 	ldr	r3, [fp, #-8]
    88b0:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    88b4:	e0823003 	add	r3, r2, r3
    88b8:	e3a02030 	mov	r2, #48	; 0x30
    88bc:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:22
        i++;
    88c0:	e51b3008 	ldr	r3, [fp, #-8]
    88c4:	e2833001 	add	r3, r3, #1
    88c8:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:25
    }

	output[i] = '\0';
    88cc:	e51b3008 	ldr	r3, [fp, #-8]
    88d0:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    88d4:	e0823003 	add	r3, r2, r3
    88d8:	e3a02000 	mov	r2, #0
    88dc:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:26
	i--;
    88e0:	e51b3008 	ldr	r3, [fp, #-8]
    88e4:	e2433001 	sub	r3, r3, #1
    88e8:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:28

	for (int j = 0; j <= i/2; j++)
    88ec:	e3a03000 	mov	r3, #0
    88f0:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:28 (discriminator 3)
    88f4:	e51b3008 	ldr	r3, [fp, #-8]
    88f8:	e1a02fa3 	lsr	r2, r3, #31
    88fc:	e0823003 	add	r3, r2, r3
    8900:	e1a030c3 	asr	r3, r3, #1
    8904:	e1a02003 	mov	r2, r3
    8908:	e51b300c 	ldr	r3, [fp, #-12]
    890c:	e1530002 	cmp	r3, r2
    8910:	ca00001b 	bgt	8984 <_Z4itoajPcj+0x164>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:30 (discriminator 2)
	{
		char c = output[i - j];
    8914:	e51b2008 	ldr	r2, [fp, #-8]
    8918:	e51b300c 	ldr	r3, [fp, #-12]
    891c:	e0423003 	sub	r3, r2, r3
    8920:	e1a02003 	mov	r2, r3
    8924:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    8928:	e0833002 	add	r3, r3, r2
    892c:	e5d33000 	ldrb	r3, [r3]
    8930:	e54b300d 	strb	r3, [fp, #-13]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:31 (discriminator 2)
		output[i - j] = output[j];
    8934:	e51b300c 	ldr	r3, [fp, #-12]
    8938:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    893c:	e0822003 	add	r2, r2, r3
    8940:	e51b1008 	ldr	r1, [fp, #-8]
    8944:	e51b300c 	ldr	r3, [fp, #-12]
    8948:	e0413003 	sub	r3, r1, r3
    894c:	e1a01003 	mov	r1, r3
    8950:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    8954:	e0833001 	add	r3, r3, r1
    8958:	e5d22000 	ldrb	r2, [r2]
    895c:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:32 (discriminator 2)
		output[j] = c;
    8960:	e51b300c 	ldr	r3, [fp, #-12]
    8964:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    8968:	e0823003 	add	r3, r2, r3
    896c:	e55b200d 	ldrb	r2, [fp, #-13]
    8970:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:28 (discriminator 2)
	for (int j = 0; j <= i/2; j++)
    8974:	e51b300c 	ldr	r3, [fp, #-12]
    8978:	e2833001 	add	r3, r3, #1
    897c:	e50b300c 	str	r3, [fp, #-12]
    8980:	eaffffdb 	b	88f4 <_Z4itoajPcj+0xd4>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:34
	}
}
    8984:	e320f000 	nop	{0}
    8988:	e24bd004 	sub	sp, fp, #4
    898c:	e8bd8800 	pop	{fp, pc}
    8990:	00009288 	andeq	r9, r0, r8, lsl #5

00008994 <_Z4atoiPKc>:
_Z4atoiPKc():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:37

int atoi(const char* input)
{
    8994:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8998:	e28db000 	add	fp, sp, #0
    899c:	e24dd014 	sub	sp, sp, #20
    89a0:	e50b0010 	str	r0, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:38
	int output = 0;
    89a4:	e3a03000 	mov	r3, #0
    89a8:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:40

	while (*input != '\0')
    89ac:	e51b3010 	ldr	r3, [fp, #-16]
    89b0:	e5d33000 	ldrb	r3, [r3]
    89b4:	e3530000 	cmp	r3, #0
    89b8:	0a000017 	beq	8a1c <_Z4atoiPKc+0x88>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:42
	{
		output *= 10;
    89bc:	e51b2008 	ldr	r2, [fp, #-8]
    89c0:	e1a03002 	mov	r3, r2
    89c4:	e1a03103 	lsl	r3, r3, #2
    89c8:	e0833002 	add	r3, r3, r2
    89cc:	e1a03083 	lsl	r3, r3, #1
    89d0:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:43
		if (*input > '9' || *input < '0')
    89d4:	e51b3010 	ldr	r3, [fp, #-16]
    89d8:	e5d33000 	ldrb	r3, [r3]
    89dc:	e3530039 	cmp	r3, #57	; 0x39
    89e0:	8a00000d 	bhi	8a1c <_Z4atoiPKc+0x88>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:43 (discriminator 1)
    89e4:	e51b3010 	ldr	r3, [fp, #-16]
    89e8:	e5d33000 	ldrb	r3, [r3]
    89ec:	e353002f 	cmp	r3, #47	; 0x2f
    89f0:	9a000009 	bls	8a1c <_Z4atoiPKc+0x88>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:46
			break;

		output += *input - '0';
    89f4:	e51b3010 	ldr	r3, [fp, #-16]
    89f8:	e5d33000 	ldrb	r3, [r3]
    89fc:	e2433030 	sub	r3, r3, #48	; 0x30
    8a00:	e51b2008 	ldr	r2, [fp, #-8]
    8a04:	e0823003 	add	r3, r2, r3
    8a08:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:48

		input++;
    8a0c:	e51b3010 	ldr	r3, [fp, #-16]
    8a10:	e2833001 	add	r3, r3, #1
    8a14:	e50b3010 	str	r3, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:40
	while (*input != '\0')
    8a18:	eaffffe3 	b	89ac <_Z4atoiPKc+0x18>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:51
	}

	return output;
    8a1c:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:52
}
    8a20:	e1a00003 	mov	r0, r3
    8a24:	e28bd000 	add	sp, fp, #0
    8a28:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8a2c:	e12fff1e 	bx	lr

00008a30 <_Z4ftoafPcj>:
_Z4ftoafPcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:55

char* ftoa(float input, char* output, unsigned int decimal_places)
{
    8a30:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8a34:	e28db000 	add	fp, sp, #0
    8a38:	e24dd03c 	sub	sp, sp, #60	; 0x3c
    8a3c:	ed0b0a0c 	vstr	s0, [fp, #-48]	; 0xffffffd0
    8a40:	e50b0034 	str	r0, [fp, #-52]	; 0xffffffcc
    8a44:	e50b1038 	str	r1, [fp, #-56]	; 0xffffffc8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:56
	char* ptr = output;
    8a48:	e51b3034 	ldr	r3, [fp, #-52]	; 0xffffffcc
    8a4c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:59

    // Handle negative numbers
    if (input < 0) {
    8a50:	ed5b7a0c 	vldr	s15, [fp, #-48]	; 0xffffffd0
    8a54:	eef57ac0 	vcmpe.f32	s15, #0.0
    8a58:	eef1fa10 	vmrs	APSR_nzcv, fpscr
    8a5c:	5a000007 	bpl	8a80 <_Z4ftoafPcj+0x50>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:60
        *ptr++ = '-';
    8a60:	e51b3008 	ldr	r3, [fp, #-8]
    8a64:	e2832001 	add	r2, r3, #1
    8a68:	e50b2008 	str	r2, [fp, #-8]
    8a6c:	e3a0202d 	mov	r2, #45	; 0x2d
    8a70:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:61
        input = -input;
    8a74:	ed5b7a0c 	vldr	s15, [fp, #-48]	; 0xffffffd0
    8a78:	eef17a67 	vneg.f32	s15, s15
    8a7c:	ed4b7a0c 	vstr	s15, [fp, #-48]	; 0xffffffd0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:65
    }

    // Extract the integer part
    int int_part = (int)input;
    8a80:	ed5b7a0c 	vldr	s15, [fp, #-48]	; 0xffffffd0
    8a84:	eefd7ae7 	vcvt.s32.f32	s15, s15
    8a88:	ee173a90 	vmov	r3, s15
    8a8c:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:66
    float fraction = input - int_part;
    8a90:	e51b300c 	ldr	r3, [fp, #-12]
    8a94:	ee073a90 	vmov	s15, r3
    8a98:	eef87ae7 	vcvt.f32.s32	s15, s15
    8a9c:	ed1b7a0c 	vldr	s14, [fp, #-48]	; 0xffffffd0
    8aa0:	ee777a67 	vsub.f32	s15, s14, s15
    8aa4:	ed4b7a04 	vstr	s15, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:70

    // Convert the integer part to a string
    char int_str[12]; // Temporary buffer for the integer part
    char* int_ptr = int_str;
    8aa8:	e24b302c 	sub	r3, fp, #44	; 0x2c
    8aac:	e50b3014 	str	r3, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:71
    if (int_part == 0) {
    8ab0:	e51b300c 	ldr	r3, [fp, #-12]
    8ab4:	e3530000 	cmp	r3, #0
    8ab8:	1a000005 	bne	8ad4 <_Z4ftoafPcj+0xa4>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:72
        *int_ptr++ = '0';
    8abc:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8ac0:	e2832001 	add	r2, r3, #1
    8ac4:	e50b2014 	str	r2, [fp, #-20]	; 0xffffffec
    8ac8:	e3a02030 	mov	r2, #48	; 0x30
    8acc:	e5c32000 	strb	r2, [r3]
    8ad0:	ea00001c 	b	8b48 <_Z4ftoafPcj+0x118>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:74
    } else {
        while (int_part > 0) {
    8ad4:	e51b300c 	ldr	r3, [fp, #-12]
    8ad8:	e3530000 	cmp	r3, #0
    8adc:	da000019 	ble	8b48 <_Z4ftoafPcj+0x118>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:75
            *int_ptr++ = '0' + (int_part % 10);
    8ae0:	e51b200c 	ldr	r2, [fp, #-12]
    8ae4:	e59f31d4 	ldr	r3, [pc, #468]	; 8cc0 <_Z4ftoafPcj+0x290>
    8ae8:	e0c31293 	smull	r1, r3, r3, r2
    8aec:	e1a01143 	asr	r1, r3, #2
    8af0:	e1a03fc2 	asr	r3, r2, #31
    8af4:	e0411003 	sub	r1, r1, r3
    8af8:	e1a03001 	mov	r3, r1
    8afc:	e1a03103 	lsl	r3, r3, #2
    8b00:	e0833001 	add	r3, r3, r1
    8b04:	e1a03083 	lsl	r3, r3, #1
    8b08:	e0421003 	sub	r1, r2, r3
    8b0c:	e6ef2071 	uxtb	r2, r1
    8b10:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8b14:	e2831001 	add	r1, r3, #1
    8b18:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8b1c:	e2822030 	add	r2, r2, #48	; 0x30
    8b20:	e6ef2072 	uxtb	r2, r2
    8b24:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:76
            int_part /= 10;
    8b28:	e51b300c 	ldr	r3, [fp, #-12]
    8b2c:	e59f218c 	ldr	r2, [pc, #396]	; 8cc0 <_Z4ftoafPcj+0x290>
    8b30:	e0c21392 	smull	r1, r2, r2, r3
    8b34:	e1a02142 	asr	r2, r2, #2
    8b38:	e1a03fc3 	asr	r3, r3, #31
    8b3c:	e0423003 	sub	r3, r2, r3
    8b40:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:74
        while (int_part > 0) {
    8b44:	eaffffe2 	b	8ad4 <_Z4ftoafPcj+0xa4>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:81
        }
    }

    // Reverse the integer part string and write to buffer
    while (int_ptr != int_str) {
    8b48:	e24b302c 	sub	r3, fp, #44	; 0x2c
    8b4c:	e51b2014 	ldr	r2, [fp, #-20]	; 0xffffffec
    8b50:	e1520003 	cmp	r2, r3
    8b54:	0a000009 	beq	8b80 <_Z4ftoafPcj+0x150>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:82
        *ptr++ = *(--int_ptr);
    8b58:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8b5c:	e2433001 	sub	r3, r3, #1
    8b60:	e50b3014 	str	r3, [fp, #-20]	; 0xffffffec
    8b64:	e51b3008 	ldr	r3, [fp, #-8]
    8b68:	e2832001 	add	r2, r3, #1
    8b6c:	e50b2008 	str	r2, [fp, #-8]
    8b70:	e51b2014 	ldr	r2, [fp, #-20]	; 0xffffffec
    8b74:	e5d22000 	ldrb	r2, [r2]
    8b78:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:81
    while (int_ptr != int_str) {
    8b7c:	eafffff1 	b	8b48 <_Z4ftoafPcj+0x118>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:86
    }

    // Add the decimal point
    if (decimal_places > 0) {
    8b80:	e51b3038 	ldr	r3, [fp, #-56]	; 0xffffffc8
    8b84:	e3530000 	cmp	r3, #0
    8b88:	0a000004 	beq	8ba0 <_Z4ftoafPcj+0x170>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:87
        *ptr++ = '.';
    8b8c:	e51b3008 	ldr	r3, [fp, #-8]
    8b90:	e2832001 	add	r2, r3, #1
    8b94:	e50b2008 	str	r2, [fp, #-8]
    8b98:	e3a0202e 	mov	r2, #46	; 0x2e
    8b9c:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:91
    }

    // Convert the fractional part to the specified number of decimal places
    for (int i = 0; i < decimal_places; i++) {
    8ba0:	e3a03000 	mov	r3, #0
    8ba4:	e50b3018 	str	r3, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:91 (discriminator 3)
    8ba8:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8bac:	e51b2038 	ldr	r2, [fp, #-56]	; 0xffffffc8
    8bb0:	e1520003 	cmp	r2, r3
    8bb4:	9a000019 	bls	8c20 <_Z4ftoafPcj+0x1f0>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:92 (discriminator 2)
        fraction *= 10;
    8bb8:	ed5b7a04 	vldr	s15, [fp, #-16]
    8bbc:	ed9f7a3e 	vldr	s14, [pc, #248]	; 8cbc <_Z4ftoafPcj+0x28c>
    8bc0:	ee677a87 	vmul.f32	s15, s15, s14
    8bc4:	ed4b7a04 	vstr	s15, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:93 (discriminator 2)
        int digit = (int)fraction;
    8bc8:	ed5b7a04 	vldr	s15, [fp, #-16]
    8bcc:	eefd7ae7 	vcvt.s32.f32	s15, s15
    8bd0:	ee173a90 	vmov	r3, s15
    8bd4:	e50b3020 	str	r3, [fp, #-32]	; 0xffffffe0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:94 (discriminator 2)
        *ptr++ = '0' + digit;
    8bd8:	e51b3020 	ldr	r3, [fp, #-32]	; 0xffffffe0
    8bdc:	e6ef2073 	uxtb	r2, r3
    8be0:	e51b3008 	ldr	r3, [fp, #-8]
    8be4:	e2831001 	add	r1, r3, #1
    8be8:	e50b1008 	str	r1, [fp, #-8]
    8bec:	e2822030 	add	r2, r2, #48	; 0x30
    8bf0:	e6ef2072 	uxtb	r2, r2
    8bf4:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:95 (discriminator 2)
        fraction -= digit;
    8bf8:	e51b3020 	ldr	r3, [fp, #-32]	; 0xffffffe0
    8bfc:	ee073a90 	vmov	s15, r3
    8c00:	eef87ae7 	vcvt.f32.s32	s15, s15
    8c04:	ed1b7a04 	vldr	s14, [fp, #-16]
    8c08:	ee777a67 	vsub.f32	s15, s14, s15
    8c0c:	ed4b7a04 	vstr	s15, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:91 (discriminator 2)
    for (int i = 0; i < decimal_places; i++) {
    8c10:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8c14:	e2833001 	add	r3, r3, #1
    8c18:	e50b3018 	str	r3, [fp, #-24]	; 0xffffffe8
    8c1c:	eaffffe1 	b	8ba8 <_Z4ftoafPcj+0x178>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:99
    }

    // Null-terminate the string
    *ptr = '\0';
    8c20:	e51b3008 	ldr	r3, [fp, #-8]
    8c24:	e3a02000 	mov	r2, #0
    8c28:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:102

    // Remove trailing zeros if any decimal places were specified
    if (decimal_places > 0) {
    8c2c:	e51b3038 	ldr	r3, [fp, #-56]	; 0xffffffc8
    8c30:	e3530000 	cmp	r3, #0
    8c34:	0a00001b 	beq	8ca8 <_Z4ftoafPcj+0x278>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:103
        char* end = ptr - 1;
    8c38:	e51b3008 	ldr	r3, [fp, #-8]
    8c3c:	e2433001 	sub	r3, r3, #1
    8c40:	e50b301c 	str	r3, [fp, #-28]	; 0xffffffe4
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:104
        while (end > output && *end == '0') {
    8c44:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    8c48:	e51b3034 	ldr	r3, [fp, #-52]	; 0xffffffcc
    8c4c:	e1520003 	cmp	r2, r3
    8c50:	9a000009 	bls	8c7c <_Z4ftoafPcj+0x24c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:104 (discriminator 1)
    8c54:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    8c58:	e5d33000 	ldrb	r3, [r3]
    8c5c:	e3530030 	cmp	r3, #48	; 0x30
    8c60:	1a000005 	bne	8c7c <_Z4ftoafPcj+0x24c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:105
            *end-- = '\0';
    8c64:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    8c68:	e2432001 	sub	r2, r3, #1
    8c6c:	e50b201c 	str	r2, [fp, #-28]	; 0xffffffe4
    8c70:	e3a02000 	mov	r2, #0
    8c74:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:104
        while (end > output && *end == '0') {
    8c78:	eafffff1 	b	8c44 <_Z4ftoafPcj+0x214>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:107
        }
        if (end > output && *end == '.') {
    8c7c:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    8c80:	e51b3034 	ldr	r3, [fp, #-52]	; 0xffffffcc
    8c84:	e1520003 	cmp	r2, r3
    8c88:	9a000006 	bls	8ca8 <_Z4ftoafPcj+0x278>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:107 (discriminator 1)
    8c8c:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    8c90:	e5d33000 	ldrb	r3, [r3]
    8c94:	e353002e 	cmp	r3, #46	; 0x2e
    8c98:	1a000002 	bne	8ca8 <_Z4ftoafPcj+0x278>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:108
            *end = '\0'; // Remove the decimal point if no fractional part remains
    8c9c:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    8ca0:	e3a02000 	mov	r2, #0
    8ca4:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:112
        }
    }

    return output;
    8ca8:	e51b3034 	ldr	r3, [fp, #-52]	; 0xffffffcc
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:113
}
    8cac:	e1a00003 	mov	r0, r3
    8cb0:	e28bd000 	add	sp, fp, #0
    8cb4:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8cb8:	e12fff1e 	bx	lr
    8cbc:	41200000 			; <UNDEFINED> instruction: 0x41200000
    8cc0:	66666667 	strbtvs	r6, [r6], -r7, ror #12

00008cc4 <_Z7strncpyPcPKci>:
_Z7strncpyPcPKci():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:116

char* strncpy(char* dest, const char *src, int num)
{
    8cc4:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8cc8:	e28db000 	add	fp, sp, #0
    8ccc:	e24dd01c 	sub	sp, sp, #28
    8cd0:	e50b0010 	str	r0, [fp, #-16]
    8cd4:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8cd8:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:119
	int i;

	for (i = 0; i < num && src[i] != '\0'; i++)
    8cdc:	e3a03000 	mov	r3, #0
    8ce0:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:119 (discriminator 4)
    8ce4:	e51b2008 	ldr	r2, [fp, #-8]
    8ce8:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8cec:	e1520003 	cmp	r2, r3
    8cf0:	aa000011 	bge	8d3c <_Z7strncpyPcPKci+0x78>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:119 (discriminator 2)
    8cf4:	e51b3008 	ldr	r3, [fp, #-8]
    8cf8:	e51b2014 	ldr	r2, [fp, #-20]	; 0xffffffec
    8cfc:	e0823003 	add	r3, r2, r3
    8d00:	e5d33000 	ldrb	r3, [r3]
    8d04:	e3530000 	cmp	r3, #0
    8d08:	0a00000b 	beq	8d3c <_Z7strncpyPcPKci+0x78>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:120 (discriminator 3)
		dest[i] = src[i];
    8d0c:	e51b3008 	ldr	r3, [fp, #-8]
    8d10:	e51b2014 	ldr	r2, [fp, #-20]	; 0xffffffec
    8d14:	e0822003 	add	r2, r2, r3
    8d18:	e51b3008 	ldr	r3, [fp, #-8]
    8d1c:	e51b1010 	ldr	r1, [fp, #-16]
    8d20:	e0813003 	add	r3, r1, r3
    8d24:	e5d22000 	ldrb	r2, [r2]
    8d28:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:119 (discriminator 3)
	for (i = 0; i < num && src[i] != '\0'; i++)
    8d2c:	e51b3008 	ldr	r3, [fp, #-8]
    8d30:	e2833001 	add	r3, r3, #1
    8d34:	e50b3008 	str	r3, [fp, #-8]
    8d38:	eaffffe9 	b	8ce4 <_Z7strncpyPcPKci+0x20>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:121 (discriminator 2)
	for (; i < num; i++)
    8d3c:	e51b2008 	ldr	r2, [fp, #-8]
    8d40:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8d44:	e1520003 	cmp	r2, r3
    8d48:	aa000008 	bge	8d70 <_Z7strncpyPcPKci+0xac>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:122 (discriminator 1)
		dest[i] = '\0';
    8d4c:	e51b3008 	ldr	r3, [fp, #-8]
    8d50:	e51b2010 	ldr	r2, [fp, #-16]
    8d54:	e0823003 	add	r3, r2, r3
    8d58:	e3a02000 	mov	r2, #0
    8d5c:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:121 (discriminator 1)
	for (; i < num; i++)
    8d60:	e51b3008 	ldr	r3, [fp, #-8]
    8d64:	e2833001 	add	r3, r3, #1
    8d68:	e50b3008 	str	r3, [fp, #-8]
    8d6c:	eafffff2 	b	8d3c <_Z7strncpyPcPKci+0x78>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:124

   return dest;
    8d70:	e51b3010 	ldr	r3, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:125
}
    8d74:	e1a00003 	mov	r0, r3
    8d78:	e28bd000 	add	sp, fp, #0
    8d7c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8d80:	e12fff1e 	bx	lr

00008d84 <_Z7strncmpPKcS0_i>:
_Z7strncmpPKcS0_i():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:128

int strncmp(const char *s1, const char *s2, int num)
{
    8d84:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8d88:	e28db000 	add	fp, sp, #0
    8d8c:	e24dd01c 	sub	sp, sp, #28
    8d90:	e50b0010 	str	r0, [fp, #-16]
    8d94:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8d98:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:130
	unsigned char u1, u2;
  	while (num-- > 0)
    8d9c:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8da0:	e2432001 	sub	r2, r3, #1
    8da4:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
    8da8:	e3530000 	cmp	r3, #0
    8dac:	c3a03001 	movgt	r3, #1
    8db0:	d3a03000 	movle	r3, #0
    8db4:	e6ef3073 	uxtb	r3, r3
    8db8:	e3530000 	cmp	r3, #0
    8dbc:	0a000016 	beq	8e1c <_Z7strncmpPKcS0_i+0x98>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:132
    {
      	u1 = (unsigned char) *s1++;
    8dc0:	e51b3010 	ldr	r3, [fp, #-16]
    8dc4:	e2832001 	add	r2, r3, #1
    8dc8:	e50b2010 	str	r2, [fp, #-16]
    8dcc:	e5d33000 	ldrb	r3, [r3]
    8dd0:	e54b3005 	strb	r3, [fp, #-5]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:133
     	u2 = (unsigned char) *s2++;
    8dd4:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8dd8:	e2832001 	add	r2, r3, #1
    8ddc:	e50b2014 	str	r2, [fp, #-20]	; 0xffffffec
    8de0:	e5d33000 	ldrb	r3, [r3]
    8de4:	e54b3006 	strb	r3, [fp, #-6]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:134
      	if (u1 != u2)
    8de8:	e55b2005 	ldrb	r2, [fp, #-5]
    8dec:	e55b3006 	ldrb	r3, [fp, #-6]
    8df0:	e1520003 	cmp	r2, r3
    8df4:	0a000003 	beq	8e08 <_Z7strncmpPKcS0_i+0x84>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:135
        	return u1 - u2;
    8df8:	e55b2005 	ldrb	r2, [fp, #-5]
    8dfc:	e55b3006 	ldrb	r3, [fp, #-6]
    8e00:	e0423003 	sub	r3, r2, r3
    8e04:	ea000005 	b	8e20 <_Z7strncmpPKcS0_i+0x9c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:136
      	if (u1 == '\0')
    8e08:	e55b3005 	ldrb	r3, [fp, #-5]
    8e0c:	e3530000 	cmp	r3, #0
    8e10:	1affffe1 	bne	8d9c <_Z7strncmpPKcS0_i+0x18>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:137
        	return 0;
    8e14:	e3a03000 	mov	r3, #0
    8e18:	ea000000 	b	8e20 <_Z7strncmpPKcS0_i+0x9c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:140
    }

  	return 0;
    8e1c:	e3a03000 	mov	r3, #0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:141
}
    8e20:	e1a00003 	mov	r0, r3
    8e24:	e28bd000 	add	sp, fp, #0
    8e28:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8e2c:	e12fff1e 	bx	lr

00008e30 <_Z6strlenPKc>:
_Z6strlenPKc():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:144

int strlen(const char* s)
{
    8e30:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8e34:	e28db000 	add	fp, sp, #0
    8e38:	e24dd014 	sub	sp, sp, #20
    8e3c:	e50b0010 	str	r0, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:145
	int i = 0;
    8e40:	e3a03000 	mov	r3, #0
    8e44:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:147

	while (s[i] != '\0')
    8e48:	e51b3008 	ldr	r3, [fp, #-8]
    8e4c:	e51b2010 	ldr	r2, [fp, #-16]
    8e50:	e0823003 	add	r3, r2, r3
    8e54:	e5d33000 	ldrb	r3, [r3]
    8e58:	e3530000 	cmp	r3, #0
    8e5c:	0a000003 	beq	8e70 <_Z6strlenPKc+0x40>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:148
		i++;
    8e60:	e51b3008 	ldr	r3, [fp, #-8]
    8e64:	e2833001 	add	r3, r3, #1
    8e68:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:147
	while (s[i] != '\0')
    8e6c:	eafffff5 	b	8e48 <_Z6strlenPKc+0x18>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:150

	return i;
    8e70:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:151
}
    8e74:	e1a00003 	mov	r0, r3
    8e78:	e28bd000 	add	sp, fp, #0
    8e7c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8e80:	e12fff1e 	bx	lr

00008e84 <_Z5bzeroPvi>:
_Z5bzeroPvi():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:154

void bzero(void* memory, int length)
{
    8e84:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8e88:	e28db000 	add	fp, sp, #0
    8e8c:	e24dd014 	sub	sp, sp, #20
    8e90:	e50b0010 	str	r0, [fp, #-16]
    8e94:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:155
	char* mem = reinterpret_cast<char*>(memory);
    8e98:	e51b3010 	ldr	r3, [fp, #-16]
    8e9c:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:157

	for (int i = 0; i < length; i++)
    8ea0:	e3a03000 	mov	r3, #0
    8ea4:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:157 (discriminator 3)
    8ea8:	e51b2008 	ldr	r2, [fp, #-8]
    8eac:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8eb0:	e1520003 	cmp	r2, r3
    8eb4:	aa000008 	bge	8edc <_Z5bzeroPvi+0x58>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:158 (discriminator 2)
		mem[i] = 0;
    8eb8:	e51b3008 	ldr	r3, [fp, #-8]
    8ebc:	e51b200c 	ldr	r2, [fp, #-12]
    8ec0:	e0823003 	add	r3, r2, r3
    8ec4:	e3a02000 	mov	r2, #0
    8ec8:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:157 (discriminator 2)
	for (int i = 0; i < length; i++)
    8ecc:	e51b3008 	ldr	r3, [fp, #-8]
    8ed0:	e2833001 	add	r3, r3, #1
    8ed4:	e50b3008 	str	r3, [fp, #-8]
    8ed8:	eafffff2 	b	8ea8 <_Z5bzeroPvi+0x24>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:159
}
    8edc:	e320f000 	nop	{0}
    8ee0:	e28bd000 	add	sp, fp, #0
    8ee4:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8ee8:	e12fff1e 	bx	lr

00008eec <_Z6memcpyPKvPvi>:
_Z6memcpyPKvPvi():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:162

void memcpy(const void* src, void* dst, int num)
{
    8eec:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8ef0:	e28db000 	add	fp, sp, #0
    8ef4:	e24dd024 	sub	sp, sp, #36	; 0x24
    8ef8:	e50b0018 	str	r0, [fp, #-24]	; 0xffffffe8
    8efc:	e50b101c 	str	r1, [fp, #-28]	; 0xffffffe4
    8f00:	e50b2020 	str	r2, [fp, #-32]	; 0xffffffe0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:163
	const char* memsrc = reinterpret_cast<const char*>(src);
    8f04:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8f08:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:164
	char* memdst = reinterpret_cast<char*>(dst);
    8f0c:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    8f10:	e50b3010 	str	r3, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:166

	for (int i = 0; i < num; i++)
    8f14:	e3a03000 	mov	r3, #0
    8f18:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:166 (discriminator 3)
    8f1c:	e51b2008 	ldr	r2, [fp, #-8]
    8f20:	e51b3020 	ldr	r3, [fp, #-32]	; 0xffffffe0
    8f24:	e1520003 	cmp	r2, r3
    8f28:	aa00000b 	bge	8f5c <_Z6memcpyPKvPvi+0x70>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:167 (discriminator 2)
		memdst[i] = memsrc[i];
    8f2c:	e51b3008 	ldr	r3, [fp, #-8]
    8f30:	e51b200c 	ldr	r2, [fp, #-12]
    8f34:	e0822003 	add	r2, r2, r3
    8f38:	e51b3008 	ldr	r3, [fp, #-8]
    8f3c:	e51b1010 	ldr	r1, [fp, #-16]
    8f40:	e0813003 	add	r3, r1, r3
    8f44:	e5d22000 	ldrb	r2, [r2]
    8f48:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:166 (discriminator 2)
	for (int i = 0; i < num; i++)
    8f4c:	e51b3008 	ldr	r3, [fp, #-8]
    8f50:	e2833001 	add	r3, r3, #1
    8f54:	e50b3008 	str	r3, [fp, #-8]
    8f58:	eaffffef 	b	8f1c <_Z6memcpyPKvPvi+0x30>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:168
}
    8f5c:	e320f000 	nop	{0}
    8f60:	e28bd000 	add	sp, fp, #0
    8f64:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8f68:	e12fff1e 	bx	lr

00008f6c <_Z6concatPcPKc>:
_Z6concatPcPKc():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:170

void concat(char* dest, const char* src) {
    8f6c:	e92d4800 	push	{fp, lr}
    8f70:	e28db004 	add	fp, sp, #4
    8f74:	e24dd010 	sub	sp, sp, #16
    8f78:	e50b0010 	str	r0, [fp, #-16]
    8f7c:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:171
	int i = strlen(dest);
    8f80:	e51b0010 	ldr	r0, [fp, #-16]
    8f84:	ebffffa9 	bl	8e30 <_Z6strlenPKc>
    8f88:	e50b0008 	str	r0, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:172
	int j = strlen(src);
    8f8c:	e51b0014 	ldr	r0, [fp, #-20]	; 0xffffffec
    8f90:	ebffffa6 	bl	8e30 <_Z6strlenPKc>
    8f94:	e50b000c 	str	r0, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:173
	strncpy(dest + i, src, j);
    8f98:	e51b3008 	ldr	r3, [fp, #-8]
    8f9c:	e51b2010 	ldr	r2, [fp, #-16]
    8fa0:	e0823003 	add	r3, r2, r3
    8fa4:	e51b200c 	ldr	r2, [fp, #-12]
    8fa8:	e51b1014 	ldr	r1, [fp, #-20]	; 0xffffffec
    8fac:	e1a00003 	mov	r0, r3
    8fb0:	ebffff43 	bl	8cc4 <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:174
	dest[i + j + 1] = '\0';
    8fb4:	e51b2008 	ldr	r2, [fp, #-8]
    8fb8:	e51b300c 	ldr	r3, [fp, #-12]
    8fbc:	e0823003 	add	r3, r2, r3
    8fc0:	e2833001 	add	r3, r3, #1
    8fc4:	e51b2010 	ldr	r2, [fp, #-16]
    8fc8:	e0823003 	add	r3, r2, r3
    8fcc:	e3a02000 	mov	r2, #0
    8fd0:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:175
    8fd4:	e320f000 	nop	{0}
    8fd8:	e24bd004 	sub	sp, fp, #4
    8fdc:	e8bd8800 	pop	{fp, pc}

00008fe0 <__udivsi3>:
__udivsi3():
    8fe0:	e2512001 	subs	r2, r1, #1
    8fe4:	012fff1e 	bxeq	lr
    8fe8:	3a000074 	bcc	91c0 <__udivsi3+0x1e0>
    8fec:	e1500001 	cmp	r0, r1
    8ff0:	9a00006b 	bls	91a4 <__udivsi3+0x1c4>
    8ff4:	e1110002 	tst	r1, r2
    8ff8:	0a00006c 	beq	91b0 <__udivsi3+0x1d0>
    8ffc:	e16f3f10 	clz	r3, r0
    9000:	e16f2f11 	clz	r2, r1
    9004:	e0423003 	sub	r3, r2, r3
    9008:	e273301f 	rsbs	r3, r3, #31
    900c:	10833083 	addne	r3, r3, r3, lsl #1
    9010:	e3a02000 	mov	r2, #0
    9014:	108ff103 	addne	pc, pc, r3, lsl #2
    9018:	e1a00000 	nop			; (mov r0, r0)
    901c:	e1500f81 	cmp	r0, r1, lsl #31
    9020:	e0a22002 	adc	r2, r2, r2
    9024:	20400f81 	subcs	r0, r0, r1, lsl #31
    9028:	e1500f01 	cmp	r0, r1, lsl #30
    902c:	e0a22002 	adc	r2, r2, r2
    9030:	20400f01 	subcs	r0, r0, r1, lsl #30
    9034:	e1500e81 	cmp	r0, r1, lsl #29
    9038:	e0a22002 	adc	r2, r2, r2
    903c:	20400e81 	subcs	r0, r0, r1, lsl #29
    9040:	e1500e01 	cmp	r0, r1, lsl #28
    9044:	e0a22002 	adc	r2, r2, r2
    9048:	20400e01 	subcs	r0, r0, r1, lsl #28
    904c:	e1500d81 	cmp	r0, r1, lsl #27
    9050:	e0a22002 	adc	r2, r2, r2
    9054:	20400d81 	subcs	r0, r0, r1, lsl #27
    9058:	e1500d01 	cmp	r0, r1, lsl #26
    905c:	e0a22002 	adc	r2, r2, r2
    9060:	20400d01 	subcs	r0, r0, r1, lsl #26
    9064:	e1500c81 	cmp	r0, r1, lsl #25
    9068:	e0a22002 	adc	r2, r2, r2
    906c:	20400c81 	subcs	r0, r0, r1, lsl #25
    9070:	e1500c01 	cmp	r0, r1, lsl #24
    9074:	e0a22002 	adc	r2, r2, r2
    9078:	20400c01 	subcs	r0, r0, r1, lsl #24
    907c:	e1500b81 	cmp	r0, r1, lsl #23
    9080:	e0a22002 	adc	r2, r2, r2
    9084:	20400b81 	subcs	r0, r0, r1, lsl #23
    9088:	e1500b01 	cmp	r0, r1, lsl #22
    908c:	e0a22002 	adc	r2, r2, r2
    9090:	20400b01 	subcs	r0, r0, r1, lsl #22
    9094:	e1500a81 	cmp	r0, r1, lsl #21
    9098:	e0a22002 	adc	r2, r2, r2
    909c:	20400a81 	subcs	r0, r0, r1, lsl #21
    90a0:	e1500a01 	cmp	r0, r1, lsl #20
    90a4:	e0a22002 	adc	r2, r2, r2
    90a8:	20400a01 	subcs	r0, r0, r1, lsl #20
    90ac:	e1500981 	cmp	r0, r1, lsl #19
    90b0:	e0a22002 	adc	r2, r2, r2
    90b4:	20400981 	subcs	r0, r0, r1, lsl #19
    90b8:	e1500901 	cmp	r0, r1, lsl #18
    90bc:	e0a22002 	adc	r2, r2, r2
    90c0:	20400901 	subcs	r0, r0, r1, lsl #18
    90c4:	e1500881 	cmp	r0, r1, lsl #17
    90c8:	e0a22002 	adc	r2, r2, r2
    90cc:	20400881 	subcs	r0, r0, r1, lsl #17
    90d0:	e1500801 	cmp	r0, r1, lsl #16
    90d4:	e0a22002 	adc	r2, r2, r2
    90d8:	20400801 	subcs	r0, r0, r1, lsl #16
    90dc:	e1500781 	cmp	r0, r1, lsl #15
    90e0:	e0a22002 	adc	r2, r2, r2
    90e4:	20400781 	subcs	r0, r0, r1, lsl #15
    90e8:	e1500701 	cmp	r0, r1, lsl #14
    90ec:	e0a22002 	adc	r2, r2, r2
    90f0:	20400701 	subcs	r0, r0, r1, lsl #14
    90f4:	e1500681 	cmp	r0, r1, lsl #13
    90f8:	e0a22002 	adc	r2, r2, r2
    90fc:	20400681 	subcs	r0, r0, r1, lsl #13
    9100:	e1500601 	cmp	r0, r1, lsl #12
    9104:	e0a22002 	adc	r2, r2, r2
    9108:	20400601 	subcs	r0, r0, r1, lsl #12
    910c:	e1500581 	cmp	r0, r1, lsl #11
    9110:	e0a22002 	adc	r2, r2, r2
    9114:	20400581 	subcs	r0, r0, r1, lsl #11
    9118:	e1500501 	cmp	r0, r1, lsl #10
    911c:	e0a22002 	adc	r2, r2, r2
    9120:	20400501 	subcs	r0, r0, r1, lsl #10
    9124:	e1500481 	cmp	r0, r1, lsl #9
    9128:	e0a22002 	adc	r2, r2, r2
    912c:	20400481 	subcs	r0, r0, r1, lsl #9
    9130:	e1500401 	cmp	r0, r1, lsl #8
    9134:	e0a22002 	adc	r2, r2, r2
    9138:	20400401 	subcs	r0, r0, r1, lsl #8
    913c:	e1500381 	cmp	r0, r1, lsl #7
    9140:	e0a22002 	adc	r2, r2, r2
    9144:	20400381 	subcs	r0, r0, r1, lsl #7
    9148:	e1500301 	cmp	r0, r1, lsl #6
    914c:	e0a22002 	adc	r2, r2, r2
    9150:	20400301 	subcs	r0, r0, r1, lsl #6
    9154:	e1500281 	cmp	r0, r1, lsl #5
    9158:	e0a22002 	adc	r2, r2, r2
    915c:	20400281 	subcs	r0, r0, r1, lsl #5
    9160:	e1500201 	cmp	r0, r1, lsl #4
    9164:	e0a22002 	adc	r2, r2, r2
    9168:	20400201 	subcs	r0, r0, r1, lsl #4
    916c:	e1500181 	cmp	r0, r1, lsl #3
    9170:	e0a22002 	adc	r2, r2, r2
    9174:	20400181 	subcs	r0, r0, r1, lsl #3
    9178:	e1500101 	cmp	r0, r1, lsl #2
    917c:	e0a22002 	adc	r2, r2, r2
    9180:	20400101 	subcs	r0, r0, r1, lsl #2
    9184:	e1500081 	cmp	r0, r1, lsl #1
    9188:	e0a22002 	adc	r2, r2, r2
    918c:	20400081 	subcs	r0, r0, r1, lsl #1
    9190:	e1500001 	cmp	r0, r1
    9194:	e0a22002 	adc	r2, r2, r2
    9198:	20400001 	subcs	r0, r0, r1
    919c:	e1a00002 	mov	r0, r2
    91a0:	e12fff1e 	bx	lr
    91a4:	03a00001 	moveq	r0, #1
    91a8:	13a00000 	movne	r0, #0
    91ac:	e12fff1e 	bx	lr
    91b0:	e16f2f11 	clz	r2, r1
    91b4:	e262201f 	rsb	r2, r2, #31
    91b8:	e1a00230 	lsr	r0, r0, r2
    91bc:	e12fff1e 	bx	lr
    91c0:	e3500000 	cmp	r0, #0
    91c4:	13e00000 	mvnne	r0, #0
    91c8:	ea000007 	b	91ec <__aeabi_idiv0>

000091cc <__aeabi_uidivmod>:
__aeabi_uidivmod():
    91cc:	e3510000 	cmp	r1, #0
    91d0:	0afffffa 	beq	91c0 <__udivsi3+0x1e0>
    91d4:	e92d4003 	push	{r0, r1, lr}
    91d8:	ebffff80 	bl	8fe0 <__udivsi3>
    91dc:	e8bd4006 	pop	{r1, r2, lr}
    91e0:	e0030092 	mul	r3, r2, r0
    91e4:	e0411003 	sub	r1, r1, r3
    91e8:	e12fff1e 	bx	lr

000091ec <__aeabi_idiv0>:
__aeabi_ldiv0():
    91ec:	e12fff1e 	bx	lr

Disassembly of section .rodata:

000091f0 <_ZL13Lock_Unlocked>:
    91f0:	00000000 	andeq	r0, r0, r0

000091f4 <_ZL11Lock_Locked>:
    91f4:	00000001 	andeq	r0, r0, r1

000091f8 <_ZL21MaxFSDriverNameLength>:
    91f8:	00000010 	andeq	r0, r0, r0, lsl r0

000091fc <_ZL17MaxFilenameLength>:
    91fc:	00000010 	andeq	r0, r0, r0, lsl r0

00009200 <_ZL13MaxPathLength>:
    9200:	00000080 	andeq	r0, r0, r0, lsl #1

00009204 <_ZL18NoFilesystemDriver>:
    9204:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00009208 <_ZL9NotifyAll>:
    9208:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

0000920c <_ZL24Max_Process_Opened_Files>:
    920c:	00000010 	andeq	r0, r0, r0, lsl r0

00009210 <_ZL10Indefinite>:
    9210:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00009214 <_ZL18Deadline_Unchanged>:
    9214:	fffffffe 			; <UNDEFINED> instruction: 0xfffffffe

00009218 <_ZL14Invalid_Handle>:
    9218:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
    921c:	3a564544 	bcc	159a734 <__bss_end+0x1591488>
    9220:	74726175 	ldrbtvc	r6, [r2], #-373	; 0xfffffe8b
    9224:	0000302f 	andeq	r3, r0, pc, lsr #32
    9228:	67676f4c 	strbvs	r6, [r7, -ip, asr #30]!
    922c:	74207265 	strtvc	r7, [r0], #-613	; 0xfffffd9b
    9230:	206b7361 	rsbcs	r7, fp, r1, ror #6
    9234:	72617473 	rsbvc	r7, r1, #1929379840	; 0x73000000
    9238:	676e6974 			; <UNDEFINED> instruction: 0x676e6974
    923c:	00000021 	andeq	r0, r0, r1, lsr #32
    9240:	00676f6c 	rsbeq	r6, r7, ip, ror #30
    9244:	205b0a0d 	subscs	r0, fp, sp, lsl #20
    9248:	00000000 	andeq	r0, r0, r0
    924c:	00203a5d 	eoreq	r3, r0, sp, asr sl

00009250 <_ZL13Lock_Unlocked>:
    9250:	00000000 	andeq	r0, r0, r0

00009254 <_ZL11Lock_Locked>:
    9254:	00000001 	andeq	r0, r0, r1

00009258 <_ZL21MaxFSDriverNameLength>:
    9258:	00000010 	andeq	r0, r0, r0, lsl r0

0000925c <_ZL17MaxFilenameLength>:
    925c:	00000010 	andeq	r0, r0, r0, lsl r0

00009260 <_ZL13MaxPathLength>:
    9260:	00000080 	andeq	r0, r0, r0, lsl #1

00009264 <_ZL18NoFilesystemDriver>:
    9264:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00009268 <_ZL9NotifyAll>:
    9268:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

0000926c <_ZL24Max_Process_Opened_Files>:
    926c:	00000010 	andeq	r0, r0, r0, lsl r0

00009270 <_ZL10Indefinite>:
    9270:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00009274 <_ZL18Deadline_Unchanged>:
    9274:	fffffffe 			; <UNDEFINED> instruction: 0xfffffffe

00009278 <_ZL14Invalid_Handle>:
    9278:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

0000927c <_ZL16Pipe_File_Prefix>:
    927c:	3a535953 	bcc	14df7d0 <__bss_end+0x14d6524>
    9280:	65706970 	ldrbvs	r6, [r0, #-2416]!	; 0xfffff690
    9284:	0000002f 	andeq	r0, r0, pc, lsr #32

00009288 <_ZN12_GLOBAL__N_1L11CharConvArrE>:
    9288:	33323130 	teqcc	r2, #48, 2
    928c:	37363534 			; <UNDEFINED> instruction: 0x37363534
    9290:	42413938 	submi	r3, r1, #56, 18	; 0xe0000
    9294:	46454443 	strbmi	r4, [r5], -r3, asr #8
	...

Disassembly of section .bss:

0000929c <__bss_start>:
	...

Disassembly of section .ARM.attributes:

00000000 <.ARM.attributes>:
   0:	00002e41 	andeq	r2, r0, r1, asr #28
   4:	61656100 	cmnvs	r5, r0, lsl #2
   8:	01006962 	tsteq	r0, r2, ror #18
   c:	00000024 	andeq	r0, r0, r4, lsr #32
  10:	4b5a3605 	blmi	168d82c <__bss_end+0x1684580>
  14:	08070600 	stmdaeq	r7, {r9, sl}
  18:	0a010901 	beq	42424 <__bss_end+0x39178>
  1c:	14041202 	strne	r1, [r4], #-514	; 0xfffffdfe
  20:	17011501 	strne	r1, [r1, -r1, lsl #10]
  24:	1a011803 	bne	46038 <__bss_end+0x3cd8c>
  28:	22011c01 	andcs	r1, r1, #256	; 0x100
  2c:	Address 0x000000000000002c is out of bounds.


Disassembly of section .comment:

00000000 <.comment>:
   0:	3a434347 	bcc	10d0d24 <__bss_end+0x10c7a78>
   4:	4e472820 	cdpmi	8, 4, cr2, cr7, cr0, {1}
   8:	72412055 	subvc	r2, r1, #85	; 0x55
   c:	6d45206d 	stclvs	0, cr2, [r5, #-436]	; 0xfffffe4c
  10:	64646562 	strbtvs	r6, [r4], #-1378	; 0xfffffa9e
  14:	54206465 	strtpl	r6, [r0], #-1125	; 0xfffffb9b
  18:	636c6f6f 	cmnvs	ip, #444	; 0x1bc
  1c:	6e696168 	powvsez	f6, f1, #0.0
  20:	2e303120 	rsfcssp	f3, f0, f0
  24:	30322d33 	eorscc	r2, r2, r3, lsr sp
  28:	312e3132 			; <UNDEFINED> instruction: 0x312e3132
  2c:	31202930 			; <UNDEFINED> instruction: 0x31202930
  30:	2e332e30 	mrccs	14, 1, r2, cr3, cr0, {1}
  34:	30322031 	eorscc	r2, r2, r1, lsr r0
  38:	38303132 	ldmdacc	r0!, {r1, r4, r5, r8, ip, sp}
  3c:	28203432 	stmdacs	r0!, {r1, r4, r5, sl, ip, sp}
  40:	656c6572 	strbvs	r6, [ip, #-1394]!	; 0xfffffa8e
  44:	29657361 	stmdbcs	r5!, {r0, r5, r6, r8, r9, ip, sp, lr}^
	...

Disassembly of section .debug_line:

00000000 <.debug_line>:
   0:	00000082 	andeq	r0, r0, r2, lsl #1
   4:	006c0003 	rsbeq	r0, ip, r3
   8:	01020000 	mrseq	r0, (UNDEF: 2)
   c:	000d0efb 	strdeq	r0, [sp], -fp
  10:	01010101 	tsteq	r1, r1, lsl #2
  14:	01000000 	mrseq	r0, (UNDEF: 0)
  18:	2f010000 	svccs	0x00010000
  1c:	72657355 	rsbvc	r7, r5, #1409286145	; 0x54000001
  20:	69772f73 	ldmdbvs	r7!, {r0, r1, r4, r5, r6, r8, r9, sl, fp, sp}^
  24:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
  28:	442f696a 	strtmi	r6, [pc], #-2410	; 30 <shift+0x30>
  2c:	746b7365 	strbtvc	r7, [fp], #-869	; 0xfffffc9b
  30:	462f706f 	strtmi	r7, [pc], -pc, rrx
  34:	4e2f5641 	cfmadda32mi	mvax2, mvax5, mvfx15, mvfx1
  38:	7a617661 	bvc	185d9c4 <__bss_end+0x1854718>
  3c:	63696a75 	cmnvs	r9, #479232	; 0x75000
  40:	534f2f69 	movtpl	r2, #65385	; 0xff69
  44:	6d65732f 	stclvs	3, cr7, [r5, #-188]!	; 0xffffff44
  48:	72747365 	rsbsvc	r7, r4, #-1811939327	; 0x94000001
  4c:	616b6c61 	cmnvs	fp, r1, ror #24
  50:	76696b2d 	strbtvc	r6, [r9], -sp, lsr #22
  54:	2f736f2d 	svccs	0x00736f2d
  58:	72756f73 	rsbsvc	r6, r5, #460	; 0x1cc
  5c:	2f736563 	svccs	0x00736563
  60:	72657375 	rsbvc	r7, r5, #-738197503	; 0xd4000001
  64:	63617073 	cmnvs	r1, #115	; 0x73
  68:	63000065 	movwvs	r0, #101	; 0x65
  6c:	2e307472 	mrccs	4, 1, r7, cr0, cr2, {3}
  70:	00010073 	andeq	r0, r1, r3, ror r0
  74:	05000000 	streq	r0, [r0, #-0]
  78:	00800002 	addeq	r0, r0, r2
  7c:	01090300 	mrseq	r0, (UNDEF: 57)
  80:	00020231 	andeq	r0, r2, r1, lsr r2
  84:	00b10101 	adcseq	r0, r1, r1, lsl #2
  88:	00030000 	andeq	r0, r3, r0
  8c:	0000006c 	andeq	r0, r0, ip, rrx
  90:	0efb0102 	cdpeq	1, 15, cr0, cr11, cr2, {0}
  94:	0101000d 	tsteq	r1, sp
  98:	00000101 	andeq	r0, r0, r1, lsl #2
  9c:	00000100 	andeq	r0, r0, r0, lsl #2
  a0:	73552f01 	cmpvc	r5, #1, 30
  a4:	2f737265 	svccs	0x00737265
  a8:	746e6977 	strbtvc	r6, [lr], #-2423	; 0xfffff689
  ac:	696a7265 	stmdbvs	sl!, {r0, r2, r5, r6, r9, ip, sp, lr}^
  b0:	7365442f 	cmnvc	r5, #788529152	; 0x2f000000
  b4:	706f746b 	rsbvc	r7, pc, fp, ror #8
  b8:	5641462f 	strbpl	r4, [r1], -pc, lsr #12
  bc:	76614e2f 	strbtvc	r4, [r1], -pc, lsr #28
  c0:	6a757a61 	bvs	1d5ea4c <__bss_end+0x1d557a0>
  c4:	2f696369 	svccs	0x00696369
  c8:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
  cc:	73656d65 	cmnvc	r5, #6464	; 0x1940
  d0:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
  d4:	6b2d616b 	blvs	b58688 <__bss_end+0xb4f3dc>
  d8:	6f2d7669 	svcvs	0x002d7669
  dc:	6f732f73 	svcvs	0x00732f73
  e0:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
  e4:	73752f73 	cmnvc	r5, #460	; 0x1cc
  e8:	70737265 	rsbsvc	r7, r3, r5, ror #4
  ec:	00656361 	rsbeq	r6, r5, r1, ror #6
  f0:	74726300 	ldrbtvc	r6, [r2], #-768	; 0xfffffd00
  f4:	00632e30 	rsbeq	r2, r3, r0, lsr lr
  f8:	00000001 	andeq	r0, r0, r1
  fc:	05000105 	streq	r0, [r0, #-261]	; 0xfffffefb
 100:	00800802 	addeq	r0, r0, r2, lsl #16
 104:	01090300 	mrseq	r0, (UNDEF: 57)
 108:	05671805 	strbeq	r1, [r7, #-2053]!	; 0xfffff7fb
 10c:	0e054a05 	vmlaeq.f32	s8, s10, s10
 110:	03040200 	movweq	r0, #16896	; 0x4200
 114:	0041052f 	subeq	r0, r1, pc, lsr #10
 118:	65030402 	strvs	r0, [r3, #-1026]	; 0xfffffbfe
 11c:	02000505 	andeq	r0, r0, #20971520	; 0x1400000
 120:	05660104 	strbeq	r0, [r6, #-260]!	; 0xfffffefc
 124:	05d98401 	ldrbeq	r8, [r9, #1025]	; 0x401
 128:	05316805 	ldreq	r6, [r1, #-2053]!	; 0xfffff7fb
 12c:	05053312 	streq	r3, [r5, #-786]	; 0xfffffcee
 130:	054b3185 	strbeq	r3, [fp, #-389]	; 0xfffffe7b
 134:	06022f01 	streq	r2, [r2], -r1, lsl #30
 138:	07010100 	streq	r0, [r1, -r0, lsl #2]
 13c:	03000001 	movweq	r0, #1
 140:	00007e00 	andeq	r7, r0, r0, lsl #28
 144:	fb010200 	blx	4094e <__bss_end+0x376a2>
 148:	01000d0e 	tsteq	r0, lr, lsl #26
 14c:	00010101 	andeq	r0, r1, r1, lsl #2
 150:	00010000 	andeq	r0, r1, r0
 154:	552f0100 	strpl	r0, [pc, #-256]!	; 5c <shift+0x5c>
 158:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 15c:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 160:	6a726574 	bvs	1c99738 <__bss_end+0x1c9048c>
 164:	65442f69 	strbvs	r2, [r4, #-3945]	; 0xfffff097
 168:	6f746b73 	svcvs	0x00746b73
 16c:	41462f70 	hvcmi	25328	; 0x62f0
 170:	614e2f56 	cmpvs	lr, r6, asr pc
 174:	757a6176 	ldrbvc	r6, [sl, #-374]!	; 0xfffffe8a
 178:	6963696a 	stmdbvs	r3!, {r1, r3, r5, r6, r8, fp, sp, lr}^
 17c:	2f534f2f 	svccs	0x00534f2f
 180:	656d6573 	strbvs	r6, [sp, #-1395]!	; 0xfffffa8d
 184:	61727473 	cmnvs	r2, r3, ror r4
 188:	2d616b6c 	vstmdbcs	r1!, {d22-<overflow reg d75>}
 18c:	2d76696b 			; <UNDEFINED> instruction: 0x2d76696b
 190:	732f736f 			; <UNDEFINED> instruction: 0x732f736f
 194:	6372756f 	cmnvs	r2, #465567744	; 0x1bc00000
 198:	752f7365 	strvc	r7, [pc, #-869]!	; fffffe3b <__bss_end+0xffff6b8f>
 19c:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 1a0:	65636170 	strbvs	r6, [r3, #-368]!	; 0xfffffe90
 1a4:	78630000 	stmdavc	r3!, {}^	; <UNPREDICTABLE>
 1a8:	69626178 	stmdbvs	r2!, {r3, r4, r5, r6, r8, sp, lr}^
 1ac:	7070632e 	rsbsvc	r6, r0, lr, lsr #6
 1b0:	00000100 	andeq	r0, r0, r0, lsl #2
 1b4:	6975623c 	ldmdbvs	r5!, {r2, r3, r4, r5, r9, sp, lr}^
 1b8:	692d746c 	pushvs	{r2, r3, r5, r6, sl, ip, sp, lr}
 1bc:	00003e6e 	andeq	r3, r0, lr, ror #28
 1c0:	05000000 	streq	r0, [r0, #-0]
 1c4:	02050002 	andeq	r0, r5, #2
 1c8:	000080a4 	andeq	r8, r0, r4, lsr #1
 1cc:	05010a03 	streq	r0, [r1, #-2563]	; 0xfffff5fd
 1d0:	0a05830b 	beq	160e04 <__bss_end+0x157b58>
 1d4:	8302054a 	movwhi	r0, #9546	; 0x254a
 1d8:	830e0585 	movwhi	r0, #58757	; 0xe585
 1dc:	85670205 	strbhi	r0, [r7, #-517]!	; 0xfffffdfb
 1e0:	86010584 	strhi	r0, [r1], -r4, lsl #11
 1e4:	854c854c 	strbhi	r8, [ip, #-1356]	; 0xfffffab4
 1e8:	0205854c 	andeq	r8, r5, #76, 10	; 0x13000000
 1ec:	01040200 	mrseq	r0, R12_usr
 1f0:	0301054b 	movweq	r0, #5451	; 0x154b
 1f4:	0d052e12 	stceq	14, cr2, [r5, #-72]	; 0xffffffb8
 1f8:	0024056b 	eoreq	r0, r4, fp, ror #10
 1fc:	4a030402 	bmi	c120c <__bss_end+0xb7f60>
 200:	02000405 	andeq	r0, r0, #83886080	; 0x5000000
 204:	05830204 	streq	r0, [r3, #516]	; 0x204
 208:	0402000b 	streq	r0, [r2], #-11
 20c:	02054a02 	andeq	r4, r5, #8192	; 0x2000
 210:	02040200 	andeq	r0, r4, #0, 4
 214:	8509052d 	strhi	r0, [r9, #-1325]	; 0xfffffad3
 218:	a12f0105 			; <UNDEFINED> instruction: 0xa12f0105
 21c:	056a0d05 	strbeq	r0, [sl, #-3333]!	; 0xfffff2fb
 220:	04020024 	streq	r0, [r2], #-36	; 0xffffffdc
 224:	04054a03 	streq	r4, [r5], #-2563	; 0xfffff5fd
 228:	02040200 	andeq	r0, r4, #0, 4
 22c:	000b0583 	andeq	r0, fp, r3, lsl #11
 230:	4a020402 	bmi	81240 <__bss_end+0x77f94>
 234:	02000205 	andeq	r0, r0, #1342177280	; 0x50000000
 238:	052d0204 	streq	r0, [sp, #-516]!	; 0xfffffdfc
 23c:	01058509 	tsteq	r5, r9, lsl #10
 240:	000a022f 	andeq	r0, sl, pc, lsr #4
 244:	02e50101 	rsceq	r0, r5, #1073741824	; 0x40000000
 248:	00030000 	andeq	r0, r3, r0
 24c:	0000028c 	andeq	r0, r0, ip, lsl #5
 250:	0efb0102 	cdpeq	1, 15, cr0, cr11, cr2, {0}
 254:	0101000d 	tsteq	r1, sp
 258:	00000101 	andeq	r0, r0, r1, lsl #2
 25c:	00000100 	andeq	r0, r0, r0, lsl #2
 260:	73552f01 	cmpvc	r5, #1, 30
 264:	2f737265 	svccs	0x00737265
 268:	746e6977 	strbtvc	r6, [lr], #-2423	; 0xfffff689
 26c:	696a7265 	stmdbvs	sl!, {r0, r2, r5, r6, r9, ip, sp, lr}^
 270:	7365442f 	cmnvc	r5, #788529152	; 0x2f000000
 274:	706f746b 	rsbvc	r7, pc, fp, ror #8
 278:	5641462f 	strbpl	r4, [r1], -pc, lsr #12
 27c:	76614e2f 	strbtvc	r4, [r1], -pc, lsr #28
 280:	6a757a61 	bvs	1d5ec0c <__bss_end+0x1d55960>
 284:	2f696369 	svccs	0x00696369
 288:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
 28c:	73656d65 	cmnvc	r5, #6464	; 0x1940
 290:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
 294:	6b2d616b 	blvs	b58848 <__bss_end+0xb4f59c>
 298:	6f2d7669 	svcvs	0x002d7669
 29c:	6f732f73 	svcvs	0x00732f73
 2a0:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
 2a4:	73752f73 	cmnvc	r5, #460	; 0x1cc
 2a8:	70737265 	rsbsvc	r7, r3, r5, ror #4
 2ac:	2f656361 	svccs	0x00656361
 2b0:	67676f6c 	strbvs	r6, [r7, -ip, ror #30]!
 2b4:	745f7265 	ldrbvc	r7, [pc], #-613	; 2bc <shift+0x2bc>
 2b8:	006b7361 	rsbeq	r7, fp, r1, ror #6
 2bc:	6573552f 	ldrbvs	r5, [r3, #-1327]!	; 0xfffffad1
 2c0:	772f7372 			; <UNDEFINED> instruction: 0x772f7372
 2c4:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
 2c8:	2f696a72 	svccs	0x00696a72
 2cc:	6b736544 	blvs	1cd97e4 <__bss_end+0x1cd0538>
 2d0:	2f706f74 	svccs	0x00706f74
 2d4:	2f564146 	svccs	0x00564146
 2d8:	6176614e 	cmnvs	r6, lr, asr #2
 2dc:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
 2e0:	4f2f6963 	svcmi	0x002f6963
 2e4:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
 2e8:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
 2ec:	6b6c6172 	blvs	1b188bc <__bss_end+0x1b0f610>
 2f0:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
 2f4:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
 2f8:	756f732f 	strbvc	r7, [pc, #-815]!	; ffffffd1 <__bss_end+0xffff6d25>
 2fc:	73656372 	cmnvc	r5, #-939524095	; 0xc8000001
 300:	6573752f 	ldrbvs	r7, [r3, #-1327]!	; 0xfffffad1
 304:	61707372 	cmnvs	r0, r2, ror r3
 308:	2e2f6563 	cfsh64cs	mvdx6, mvdx15, #51
 30c:	656b2f2e 	strbvs	r2, [fp, #-3886]!	; 0xfffff0d2
 310:	6c656e72 	stclvs	14, cr6, [r5], #-456	; 0xfffffe38
 314:	636e692f 	cmnvs	lr, #770048	; 0xbc000
 318:	6564756c 	strbvs	r7, [r4, #-1388]!	; 0xfffffa94
 31c:	6f72702f 	svcvs	0x0072702f
 320:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
 324:	73552f00 	cmpvc	r5, #0, 30
 328:	2f737265 	svccs	0x00737265
 32c:	746e6977 	strbtvc	r6, [lr], #-2423	; 0xfffff689
 330:	696a7265 	stmdbvs	sl!, {r0, r2, r5, r6, r9, ip, sp, lr}^
 334:	7365442f 	cmnvc	r5, #788529152	; 0x2f000000
 338:	706f746b 	rsbvc	r7, pc, fp, ror #8
 33c:	5641462f 	strbpl	r4, [r1], -pc, lsr #12
 340:	76614e2f 	strbtvc	r4, [r1], -pc, lsr #28
 344:	6a757a61 	bvs	1d5ecd0 <__bss_end+0x1d55a24>
 348:	2f696369 	svccs	0x00696369
 34c:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
 350:	73656d65 	cmnvc	r5, #6464	; 0x1940
 354:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
 358:	6b2d616b 	blvs	b5890c <__bss_end+0xb4f660>
 35c:	6f2d7669 	svcvs	0x002d7669
 360:	6f732f73 	svcvs	0x00732f73
 364:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
 368:	73752f73 	cmnvc	r5, #460	; 0x1cc
 36c:	70737265 	rsbsvc	r7, r3, r5, ror #4
 370:	2f656361 	svccs	0x00656361
 374:	6b2f2e2e 	blvs	bcbc34 <__bss_end+0xbc2988>
 378:	656e7265 	strbvs	r7, [lr, #-613]!	; 0xfffffd9b
 37c:	6e692f6c 	cdpvs	15, 6, cr2, cr9, cr12, {3}
 380:	64756c63 	ldrbtvs	r6, [r5], #-3171	; 0xfffff39d
 384:	73662f65 	cmnvc	r6, #404	; 0x194
 388:	73552f00 	cmpvc	r5, #0, 30
 38c:	2f737265 	svccs	0x00737265
 390:	746e6977 	strbtvc	r6, [lr], #-2423	; 0xfffff689
 394:	696a7265 	stmdbvs	sl!, {r0, r2, r5, r6, r9, ip, sp, lr}^
 398:	7365442f 	cmnvc	r5, #788529152	; 0x2f000000
 39c:	706f746b 	rsbvc	r7, pc, fp, ror #8
 3a0:	5641462f 	strbpl	r4, [r1], -pc, lsr #12
 3a4:	76614e2f 	strbtvc	r4, [r1], -pc, lsr #28
 3a8:	6a757a61 	bvs	1d5ed34 <__bss_end+0x1d55a88>
 3ac:	2f696369 	svccs	0x00696369
 3b0:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
 3b4:	73656d65 	cmnvc	r5, #6464	; 0x1940
 3b8:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
 3bc:	6b2d616b 	blvs	b58970 <__bss_end+0xb4f6c4>
 3c0:	6f2d7669 	svcvs	0x002d7669
 3c4:	6f732f73 	svcvs	0x00732f73
 3c8:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
 3cc:	73752f73 	cmnvc	r5, #460	; 0x1cc
 3d0:	70737265 	rsbsvc	r7, r3, r5, ror #4
 3d4:	2f656361 	svccs	0x00656361
 3d8:	6b2f2e2e 	blvs	bcbc98 <__bss_end+0xbc29ec>
 3dc:	656e7265 	strbvs	r7, [lr, #-613]!	; 0xfffffd9b
 3e0:	6e692f6c 	cdpvs	15, 6, cr2, cr9, cr12, {3}
 3e4:	64756c63 	ldrbtvs	r6, [r5], #-3171	; 0xfffff39d
 3e8:	72642f65 	rsbvc	r2, r4, #404	; 0x194
 3ec:	72657669 	rsbvc	r7, r5, #110100480	; 0x6900000
 3f0:	72622f73 	rsbvc	r2, r2, #460	; 0x1cc
 3f4:	65676469 	strbvs	r6, [r7, #-1129]!	; 0xfffffb97
 3f8:	552f0073 	strpl	r0, [pc, #-115]!	; 38d <shift+0x38d>
 3fc:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 400:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 404:	6a726574 	bvs	1c999dc <__bss_end+0x1c90730>
 408:	65442f69 	strbvs	r2, [r4, #-3945]	; 0xfffff097
 40c:	6f746b73 	svcvs	0x00746b73
 410:	41462f70 	hvcmi	25328	; 0x62f0
 414:	614e2f56 	cmpvs	lr, r6, asr pc
 418:	757a6176 	ldrbvc	r6, [sl, #-374]!	; 0xfffffe8a
 41c:	6963696a 	stmdbvs	r3!, {r1, r3, r5, r6, r8, fp, sp, lr}^
 420:	2f534f2f 	svccs	0x00534f2f
 424:	656d6573 	strbvs	r6, [sp, #-1395]!	; 0xfffffa8d
 428:	61727473 	cmnvs	r2, r3, ror r4
 42c:	2d616b6c 	vstmdbcs	r1!, {d22-<overflow reg d75>}
 430:	2d76696b 			; <UNDEFINED> instruction: 0x2d76696b
 434:	732f736f 			; <UNDEFINED> instruction: 0x732f736f
 438:	6372756f 	cmnvs	r2, #465567744	; 0x1bc00000
 43c:	752f7365 	strvc	r7, [pc, #-869]!	; df <shift+0xdf>
 440:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 444:	65636170 	strbvs	r6, [r3, #-368]!	; 0xfffffe90
 448:	2f2e2e2f 	svccs	0x002e2e2f
 44c:	6e72656b 	cdpvs	5, 7, cr6, cr2, cr11, {3}
 450:	692f6c65 	stmdbvs	pc!, {r0, r2, r5, r6, sl, fp, sp, lr}	; <UNPREDICTABLE>
 454:	756c636e 	strbvc	r6, [ip, #-878]!	; 0xfffffc92
 458:	622f6564 	eorvs	r6, pc, #100, 10	; 0x19000000
 45c:	6472616f 	ldrbtvs	r6, [r2], #-367	; 0xfffffe91
 460:	6970722f 	ldmdbvs	r0!, {r0, r1, r2, r3, r5, r9, ip, sp, lr}^
 464:	61682f30 	cmnvs	r8, r0, lsr pc
 468:	6d00006c 	stcvs	0, cr0, [r0, #-432]	; 0xfffffe50
 46c:	2e6e6961 	vnmulcs.f16	s13, s28, s3	; <UNPREDICTABLE>
 470:	00707063 	rsbseq	r7, r0, r3, rrx
 474:	73000001 	movwvc	r0, #1
 478:	6c6e6970 			; <UNDEFINED> instruction: 0x6c6e6970
 47c:	2e6b636f 	cdpcs	3, 6, cr6, cr11, cr15, {3}
 480:	00020068 	andeq	r0, r2, r8, rrx
 484:	6c696600 	stclvs	6, cr6, [r9], #-0
 488:	73797365 	cmnvc	r9, #-1811939327	; 0x94000001
 48c:	2e6d6574 	mcrcs	5, 3, r6, cr13, cr4, {3}
 490:	00030068 	andeq	r0, r3, r8, rrx
 494:	69777300 	ldmdbvs	r7!, {r8, r9, ip, sp, lr}^
 498:	0200682e 	andeq	r6, r0, #3014656	; 0x2e0000
 49c:	72700000 	rsbsvc	r0, r0, #0
 4a0:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
 4a4:	00682e73 	rsbeq	r2, r8, r3, ror lr
 4a8:	70000002 	andvc	r0, r0, r2
 4ac:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
 4b0:	6d5f7373 	ldclvs	3, cr7, [pc, #-460]	; 2ec <shift+0x2ec>
 4b4:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
 4b8:	682e7265 	stmdavs	lr!, {r0, r2, r5, r6, r9, ip, sp, lr}
 4bc:	00000200 	andeq	r0, r0, r0, lsl #4
 4c0:	74726175 	ldrbtvc	r6, [r2], #-373	; 0xfffffe8b
 4c4:	6665645f 			; <UNDEFINED> instruction: 0x6665645f
 4c8:	00682e73 	rsbeq	r2, r8, r3, ror lr
 4cc:	69000004 	stmdbvs	r0, {r2}
 4d0:	6564746e 	strbvs	r7, [r4, #-1134]!	; 0xfffffb92
 4d4:	00682e66 	rsbeq	r2, r8, r6, ror #28
 4d8:	00000005 	andeq	r0, r0, r5
 4dc:	05000105 	streq	r0, [r0, #-261]	; 0xfffffefb
 4e0:	00822c02 	addeq	r2, r2, r2, lsl #24
 4e4:	010d0300 	mrseq	r0, SP_mon
 4e8:	059f1c05 	ldreq	r1, [pc, #3077]	; 10f5 <shift+0x10f5>
 4ec:	01056607 	tsteq	r5, r7, lsl #12
 4f0:	1b056983 	blne	15ab04 <__bss_end+0x151858>
 4f4:	8513059f 	ldrhi	r0, [r3, #-1439]	; 0xfffffa61
 4f8:	054b1505 	strbeq	r1, [fp, #-1285]	; 0xfffffafb
 4fc:	6ba04b07 	blvs	fe813120 <__bss_end+0xfe809e74>
 500:	0b058383 	bleq	161314 <__bss_end+0x158068>
 504:	4a1a0585 	bmi	681b20 <__bss_end+0x678874>
 508:	054c1905 	strbeq	r1, [ip, #-2309]	; 0xfffff6fb
 50c:	14058707 	strne	r8, [r5], #-1799	; 0xfffff8f9
 510:	03030583 	movweq	r0, #13699	; 0x3583
 514:	0b05ba18 	bleq	16ed7c <__bss_end+0x165ad0>
 518:	9f090568 	svcls	0x00090568
 51c:	05672205 	strbeq	r2, [r7, #-517]!	; 0xfffffdfb
 520:	09054b08 	stmdbeq	r5, {r3, r8, r9, fp, lr}
 524:	0567839f 	strbeq	r8, [r7, #-927]!	; 0xfffffc61
 528:	0e028402 	cdpeq	4, 0, cr8, cr2, cr2, {0}
 52c:	c8010100 	stmdagt	r1, {r8}
 530:	03000002 	movweq	r0, #2
 534:	0001dd00 	andeq	sp, r1, r0, lsl #26
 538:	fb010200 	blx	40d42 <__bss_end+0x37a96>
 53c:	01000d0e 	tsteq	r0, lr, lsl #26
 540:	00010101 	andeq	r0, r1, r1, lsl #2
 544:	00010000 	andeq	r0, r1, r0
 548:	552f0100 	strpl	r0, [pc, #-256]!	; 450 <shift+0x450>
 54c:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 550:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 554:	6a726574 	bvs	1c99b2c <__bss_end+0x1c90880>
 558:	65442f69 	strbvs	r2, [r4, #-3945]	; 0xfffff097
 55c:	6f746b73 	svcvs	0x00746b73
 560:	41462f70 	hvcmi	25328	; 0x62f0
 564:	614e2f56 	cmpvs	lr, r6, asr pc
 568:	757a6176 	ldrbvc	r6, [sl, #-374]!	; 0xfffffe8a
 56c:	6963696a 	stmdbvs	r3!, {r1, r3, r5, r6, r8, fp, sp, lr}^
 570:	2f534f2f 	svccs	0x00534f2f
 574:	656d6573 	strbvs	r6, [sp, #-1395]!	; 0xfffffa8d
 578:	61727473 	cmnvs	r2, r3, ror r4
 57c:	2d616b6c 	vstmdbcs	r1!, {d22-<overflow reg d75>}
 580:	2d76696b 			; <UNDEFINED> instruction: 0x2d76696b
 584:	732f736f 			; <UNDEFINED> instruction: 0x732f736f
 588:	6372756f 	cmnvs	r2, #465567744	; 0x1bc00000
 58c:	732f7365 			; <UNDEFINED> instruction: 0x732f7365
 590:	696c6474 	stmdbvs	ip!, {r2, r4, r5, r6, sl, sp, lr}^
 594:	72732f62 	rsbsvc	r2, r3, #392	; 0x188
 598:	552f0063 	strpl	r0, [pc, #-99]!	; 53d <shift+0x53d>
 59c:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 5a0:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 5a4:	6a726574 	bvs	1c99b7c <__bss_end+0x1c908d0>
 5a8:	65442f69 	strbvs	r2, [r4, #-3945]	; 0xfffff097
 5ac:	6f746b73 	svcvs	0x00746b73
 5b0:	41462f70 	hvcmi	25328	; 0x62f0
 5b4:	614e2f56 	cmpvs	lr, r6, asr pc
 5b8:	757a6176 	ldrbvc	r6, [sl, #-374]!	; 0xfffffe8a
 5bc:	6963696a 	stmdbvs	r3!, {r1, r3, r5, r6, r8, fp, sp, lr}^
 5c0:	2f534f2f 	svccs	0x00534f2f
 5c4:	656d6573 	strbvs	r6, [sp, #-1395]!	; 0xfffffa8d
 5c8:	61727473 	cmnvs	r2, r3, ror r4
 5cc:	2d616b6c 	vstmdbcs	r1!, {d22-<overflow reg d75>}
 5d0:	2d76696b 			; <UNDEFINED> instruction: 0x2d76696b
 5d4:	732f736f 			; <UNDEFINED> instruction: 0x732f736f
 5d8:	6372756f 	cmnvs	r2, #465567744	; 0x1bc00000
 5dc:	6b2f7365 	blvs	bdd378 <__bss_end+0xbd40cc>
 5e0:	656e7265 	strbvs	r7, [lr, #-613]!	; 0xfffffd9b
 5e4:	6e692f6c 	cdpvs	15, 6, cr2, cr9, cr12, {3}
 5e8:	64756c63 	ldrbtvs	r6, [r5], #-3171	; 0xfffff39d
 5ec:	72702f65 	rsbsvc	r2, r0, #404	; 0x194
 5f0:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
 5f4:	552f0073 	strpl	r0, [pc, #-115]!	; 589 <shift+0x589>
 5f8:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 5fc:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 600:	6a726574 	bvs	1c99bd8 <__bss_end+0x1c9092c>
 604:	65442f69 	strbvs	r2, [r4, #-3945]	; 0xfffff097
 608:	6f746b73 	svcvs	0x00746b73
 60c:	41462f70 	hvcmi	25328	; 0x62f0
 610:	614e2f56 	cmpvs	lr, r6, asr pc
 614:	757a6176 	ldrbvc	r6, [sl, #-374]!	; 0xfffffe8a
 618:	6963696a 	stmdbvs	r3!, {r1, r3, r5, r6, r8, fp, sp, lr}^
 61c:	2f534f2f 	svccs	0x00534f2f
 620:	656d6573 	strbvs	r6, [sp, #-1395]!	; 0xfffffa8d
 624:	61727473 	cmnvs	r2, r3, ror r4
 628:	2d616b6c 	vstmdbcs	r1!, {d22-<overflow reg d75>}
 62c:	2d76696b 			; <UNDEFINED> instruction: 0x2d76696b
 630:	732f736f 			; <UNDEFINED> instruction: 0x732f736f
 634:	6372756f 	cmnvs	r2, #465567744	; 0x1bc00000
 638:	6b2f7365 	blvs	bdd3d4 <__bss_end+0xbd4128>
 63c:	656e7265 	strbvs	r7, [lr, #-613]!	; 0xfffffd9b
 640:	6e692f6c 	cdpvs	15, 6, cr2, cr9, cr12, {3}
 644:	64756c63 	ldrbtvs	r6, [r5], #-3171	; 0xfffff39d
 648:	73662f65 	cmnvc	r6, #404	; 0x194
 64c:	73552f00 	cmpvc	r5, #0, 30
 650:	2f737265 	svccs	0x00737265
 654:	746e6977 	strbtvc	r6, [lr], #-2423	; 0xfffff689
 658:	696a7265 	stmdbvs	sl!, {r0, r2, r5, r6, r9, ip, sp, lr}^
 65c:	7365442f 	cmnvc	r5, #788529152	; 0x2f000000
 660:	706f746b 	rsbvc	r7, pc, fp, ror #8
 664:	5641462f 	strbpl	r4, [r1], -pc, lsr #12
 668:	76614e2f 	strbtvc	r4, [r1], -pc, lsr #28
 66c:	6a757a61 	bvs	1d5eff8 <__bss_end+0x1d55d4c>
 670:	2f696369 	svccs	0x00696369
 674:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
 678:	73656d65 	cmnvc	r5, #6464	; 0x1940
 67c:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
 680:	6b2d616b 	blvs	b58c34 <__bss_end+0xb4f988>
 684:	6f2d7669 	svcvs	0x002d7669
 688:	6f732f73 	svcvs	0x00732f73
 68c:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
 690:	656b2f73 	strbvs	r2, [fp, #-3955]!	; 0xfffff08d
 694:	6c656e72 	stclvs	14, cr6, [r5], #-456	; 0xfffffe38
 698:	636e692f 	cmnvs	lr, #770048	; 0xbc000
 69c:	6564756c 	strbvs	r7, [r4, #-1388]!	; 0xfffffa94
 6a0:	616f622f 	cmnvs	pc, pc, lsr #4
 6a4:	722f6472 	eorvc	r6, pc, #1912602624	; 0x72000000
 6a8:	2f306970 	svccs	0x00306970
 6ac:	006c6168 	rsbeq	r6, ip, r8, ror #2
 6b0:	64747300 	ldrbtvs	r7, [r4], #-768	; 0xfffffd00
 6b4:	656c6966 	strbvs	r6, [ip, #-2406]!	; 0xfffff69a
 6b8:	7070632e 	rsbsvc	r6, r0, lr, lsr #6
 6bc:	00000100 	andeq	r0, r0, r0, lsl #2
 6c0:	2e697773 	mcrcs	7, 3, r7, cr9, cr3, {3}
 6c4:	00020068 	andeq	r0, r2, r8, rrx
 6c8:	69707300 	ldmdbvs	r0!, {r8, r9, ip, sp, lr}^
 6cc:	636f6c6e 	cmnvs	pc, #28160	; 0x6e00
 6d0:	00682e6b 	rsbeq	r2, r8, fp, ror #28
 6d4:	66000002 	strvs	r0, [r0], -r2
 6d8:	73656c69 	cmnvc	r5, #26880	; 0x6900
 6dc:	65747379 	ldrbvs	r7, [r4, #-889]!	; 0xfffffc87
 6e0:	00682e6d 	rsbeq	r2, r8, sp, ror #28
 6e4:	70000003 	andvc	r0, r0, r3
 6e8:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
 6ec:	682e7373 	stmdavs	lr!, {r0, r1, r4, r5, r6, r8, r9, ip, sp, lr}
 6f0:	00000200 	andeq	r0, r0, r0, lsl #4
 6f4:	636f7270 	cmnvs	pc, #112, 4
 6f8:	5f737365 	svcpl	0x00737365
 6fc:	616e616d 	cmnvs	lr, sp, ror #2
 700:	2e726567 	cdpcs	5, 7, cr6, cr2, cr7, {3}
 704:	00020068 	andeq	r0, r2, r8, rrx
 708:	746e6900 	strbtvc	r6, [lr], #-2304	; 0xfffff700
 70c:	2e666564 	cdpcs	5, 6, cr6, cr6, cr4, {3}
 710:	00040068 	andeq	r0, r4, r8, rrx
 714:	01050000 	mrseq	r0, (UNDEF: 5)
 718:	c4020500 	strgt	r0, [r2], #-1280	; 0xfffffb00
 71c:	16000083 	strne	r0, [r0], -r3, lsl #1
 720:	2f690505 	svccs	0x00690505
 724:	054c0c05 	strbeq	r0, [ip, #-3077]	; 0xfffff3fb
 728:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 72c:	054b8305 	strbeq	r8, [fp, #-773]	; 0xfffffcfb
 730:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 734:	01054b05 	tsteq	r5, r5, lsl #22
 738:	0505852f 	streq	r8, [r5, #-1327]	; 0xfffffad1
 73c:	2f4b4ba1 	svccs	0x004b4ba1
 740:	054b0c05 	strbeq	r0, [fp, #-3077]	; 0xfffff3fb
 744:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 748:	4b4bbd05 	blmi	12efb64 <__bss_end+0x12e68b8>
 74c:	0c052f4b 	stceq	15, cr2, [r5], {75}	; 0x4b
 750:	2f01054c 	svccs	0x0001054c
 754:	bd050585 	cfstr32lt	mvfx0, [r5, #-532]	; 0xfffffdec
 758:	2f4b4b4b 	svccs	0x004b4b4b
 75c:	054c0c05 	strbeq	r0, [ip, #-3077]	; 0xfffff3fb
 760:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 764:	054b8305 	strbeq	r8, [fp, #-773]	; 0xfffffcfb
 768:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 76c:	4b4bbd05 	blmi	12efb88 <__bss_end+0x12e68dc>
 770:	0c052f4b 	stceq	15, cr2, [r5], {75}	; 0x4b
 774:	2f01054c 	svccs	0x0001054c
 778:	a1050585 	smlabbge	r5, r5, r5, r0
 77c:	052f4b4b 	streq	r4, [pc, #-2891]!	; fffffc39 <__bss_end+0xffff698d>
 780:	01054c0c 	tsteq	r5, ip, lsl #24
 784:	0505852f 	streq	r8, [r5, #-1327]	; 0xfffffad1
 788:	4b4b4bbd 	blmi	12d3684 <__bss_end+0x12ca3d8>
 78c:	4c0c052f 	cfstr32mi	mvfx0, [ip], {47}	; 0x2f
 790:	852f0105 	strhi	r0, [pc, #-261]!	; 693 <shift+0x693>
 794:	4ba10505 	blmi	fe841bb0 <__bss_end+0xfe838904>
 798:	0c052f4b 	stceq	15, cr2, [r5], {75}	; 0x4b
 79c:	9f01054c 	svcls	0x0001054c
 7a0:	67200585 	strvs	r0, [r0, -r5, lsl #11]!
 7a4:	4b4d0505 	blmi	1341bc0 <__bss_end+0x1338914>
 7a8:	300c054b 	andcc	r0, ip, fp, asr #10
 7ac:	852f0105 	strhi	r0, [pc, #-261]!	; 6af <shift+0x6af>
 7b0:	05672005 	strbeq	r2, [r7, #-5]!
 7b4:	4b4b4d05 	blmi	12d3bd0 <__bss_end+0x12ca924>
 7b8:	05300c05 	ldreq	r0, [r0, #-3077]!	; 0xfffff3fb
 7bc:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 7c0:	05058320 	streq	r8, [r5, #-800]	; 0xfffffce0
 7c4:	054b4b4c 	strbeq	r4, [fp, #-2892]	; 0xfffff4b4
 7c8:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 7cc:	05056720 	streq	r6, [r5, #-1824]	; 0xfffff8e0
 7d0:	054b4b4d 	strbeq	r4, [fp, #-2893]	; 0xfffff4b3
 7d4:	0105300c 	tsteq	r5, ip
 7d8:	0c05872f 	stceq	7, cr8, [r5], {47}	; 0x2f
 7dc:	31059fa0 	smlatbcc	r5, r0, pc, r9	; <UNPREDICTABLE>
 7e0:	662905bc 			; <UNDEFINED> instruction: 0x662905bc
 7e4:	052e3605 	streq	r3, [lr, #-1541]!	; 0xfffff9fb
 7e8:	1305300f 	movwne	r3, #20495	; 0x500f
 7ec:	84090566 	strhi	r0, [r9], #-1382	; 0xfffffa9a
 7f0:	05d81005 	ldrbeq	r1, [r8, #5]
 7f4:	08029f01 	stmdaeq	r2, {r0, r8, r9, sl, fp, ip, pc}
 7f8:	8b010100 	blhi	40c00 <__bss_end+0x37954>
 7fc:	03000003 	movweq	r0, #3
 800:	00007400 	andeq	r7, r0, r0, lsl #8
 804:	fb010200 	blx	4100e <__bss_end+0x37d62>
 808:	01000d0e 	tsteq	r0, lr, lsl #26
 80c:	00010101 	andeq	r0, r1, r1, lsl #2
 810:	00010000 	andeq	r0, r1, r0
 814:	552f0100 	strpl	r0, [pc, #-256]!	; 71c <shift+0x71c>
 818:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 81c:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 820:	6a726574 	bvs	1c99df8 <__bss_end+0x1c90b4c>
 824:	65442f69 	strbvs	r2, [r4, #-3945]	; 0xfffff097
 828:	6f746b73 	svcvs	0x00746b73
 82c:	41462f70 	hvcmi	25328	; 0x62f0
 830:	614e2f56 	cmpvs	lr, r6, asr pc
 834:	757a6176 	ldrbvc	r6, [sl, #-374]!	; 0xfffffe8a
 838:	6963696a 	stmdbvs	r3!, {r1, r3, r5, r6, r8, fp, sp, lr}^
 83c:	2f534f2f 	svccs	0x00534f2f
 840:	656d6573 	strbvs	r6, [sp, #-1395]!	; 0xfffffa8d
 844:	61727473 	cmnvs	r2, r3, ror r4
 848:	2d616b6c 	vstmdbcs	r1!, {d22-<overflow reg d75>}
 84c:	2d76696b 			; <UNDEFINED> instruction: 0x2d76696b
 850:	732f736f 			; <UNDEFINED> instruction: 0x732f736f
 854:	6372756f 	cmnvs	r2, #465567744	; 0x1bc00000
 858:	732f7365 			; <UNDEFINED> instruction: 0x732f7365
 85c:	696c6474 	stmdbvs	ip!, {r2, r4, r5, r6, sl, sp, lr}^
 860:	72732f62 	rsbsvc	r2, r3, #392	; 0x188
 864:	73000063 	movwvc	r0, #99	; 0x63
 868:	74736474 	ldrbtvc	r6, [r3], #-1140	; 0xfffffb8c
 86c:	676e6972 			; <UNDEFINED> instruction: 0x676e6972
 870:	7070632e 	rsbsvc	r6, r0, lr, lsr #6
 874:	00000100 	andeq	r0, r0, r0, lsl #2
 878:	00010500 	andeq	r0, r1, r0, lsl #10
 87c:	88200205 	stmdahi	r0!, {r0, r2, r9}
 880:	051a0000 	ldreq	r0, [sl, #-0]
 884:	0f05bb06 	svceq	0x0005bb06
 888:	6821054c 	stmdavs	r1!, {r2, r3, r6, r8, sl}
 88c:	05ba0a05 	ldreq	r0, [sl, #2565]!	; 0xa05
 890:	27052e0b 	strcs	r2, [r5, -fp, lsl #28]
 894:	4a0d054a 	bmi	341dc4 <__bss_end+0x338b18>
 898:	052f0905 	streq	r0, [pc, #-2309]!	; ffffff9b <__bss_end+0xffff6cef>
 89c:	02059f04 	andeq	r9, r5, #4, 30
 8a0:	35050562 	strcc	r0, [r5, #-1378]	; 0xfffffa9e
 8a4:	05681005 	strbeq	r1, [r8, #-5]!
 8a8:	22052e11 	andcs	r2, r5, #272	; 0x110
 8ac:	2e13054a 	cfmac32cs	mvfx0, mvfx3, mvfx10
 8b0:	052f0a05 	streq	r0, [pc, #-2565]!	; fffffeb3 <__bss_end+0xffff6c07>
 8b4:	0a056909 	beq	15ace0 <__bss_end+0x151a34>
 8b8:	4a0c052e 	bmi	301d78 <__bss_end+0x2f8acc>
 8bc:	054b0305 	strbeq	r0, [fp, #-773]	; 0xfffffcfb
 8c0:	1805680b 	stmdane	r5, {r0, r1, r3, fp, sp, lr}
 8c4:	03040200 	movweq	r0, #16896	; 0x4200
 8c8:	0014054a 	andseq	r0, r4, sl, asr #10
 8cc:	9e030402 	cdpls	4, 0, cr0, cr3, cr2, {0}
 8d0:	02001505 	andeq	r1, r0, #20971520	; 0x1400000
 8d4:	05680204 	strbeq	r0, [r8, #-516]!	; 0xfffffdfc
 8d8:	04020018 	streq	r0, [r2], #-24	; 0xffffffe8
 8dc:	08058202 	stmdaeq	r5, {r1, r9, pc}
 8e0:	02040200 	andeq	r0, r4, #0, 4
 8e4:	001a054a 	andseq	r0, sl, sl, asr #10
 8e8:	4b020402 	blmi	818f8 <__bss_end+0x7864c>
 8ec:	02001b05 	andeq	r1, r0, #5120	; 0x1400
 8f0:	052e0204 	streq	r0, [lr, #-516]!	; 0xfffffdfc
 8f4:	0402000c 	streq	r0, [r2], #-12
 8f8:	0f054a02 	svceq	0x00054a02
 8fc:	02040200 	andeq	r0, r4, #0, 4
 900:	001b0582 	andseq	r0, fp, r2, lsl #11
 904:	4a020402 	bmi	81914 <__bss_end+0x78668>
 908:	02001105 	andeq	r1, r0, #1073741825	; 0x40000001
 90c:	052e0204 	streq	r0, [lr, #-516]!	; 0xfffffdfc
 910:	0402000a 	streq	r0, [r2], #-10
 914:	0b052f02 	bleq	14c524 <__bss_end+0x143278>
 918:	02040200 	andeq	r0, r4, #0, 4
 91c:	000d052e 	andeq	r0, sp, lr, lsr #10
 920:	4a020402 	bmi	81930 <__bss_end+0x78684>
 924:	02000205 	andeq	r0, r0, #1342177280	; 0x50000000
 928:	05460204 	strbeq	r0, [r6, #-516]	; 0xfffffdfc
 92c:	05858801 	streq	r8, [r5, #2049]	; 0x801
 930:	09058306 	stmdbeq	r5, {r1, r2, r8, r9, pc}
 934:	4a10054c 	bmi	401e6c <__bss_end+0x3f8bc0>
 938:	054c0a05 	strbeq	r0, [ip, #-2565]	; 0xfffff5fb
 93c:	0305bb07 	movweq	fp, #23303	; 0x5b07
 940:	0017054a 	andseq	r0, r7, sl, asr #10
 944:	4a010402 	bmi	41954 <__bss_end+0x386a8>
 948:	02001405 	andeq	r1, r0, #83886080	; 0x5000000
 94c:	054a0104 	strbeq	r0, [sl, #-260]	; 0xfffffefc
 950:	14054d0d 	strne	r4, [r5], #-3341	; 0xfffff2f3
 954:	2e0a054a 	cfsh32cs	mvfx0, mvfx10, #42
 958:	05680805 	strbeq	r0, [r8, #-2053]!	; 0xfffff7fb
 95c:	66780302 	ldrbtvs	r0, [r8], -r2, lsl #6
 960:	0b030905 	bleq	c2d7c <__bss_end+0xb9ad0>
 964:	2f01052e 	svccs	0x0001052e
 968:	bb080585 	bllt	201f84 <__bss_end+0x1f8cd8>
 96c:	054d0505 	strbeq	r0, [sp, #-1285]	; 0xfffffafb
 970:	1005830d 	andne	r8, r5, sp, lsl #6
 974:	4b0f0566 	blmi	3c1f14 <__bss_end+0x3b8c68>
 978:	056a0905 	strbeq	r0, [sl, #-2309]!	; 0xfffff6fb
 97c:	0b05831c 	bleq	1615f4 <__bss_end+0x158348>
 980:	05056a66 	streq	r6, [r5, #-2662]	; 0xfffff59a
 984:	6711054b 	ldrvs	r0, [r1, -fp, asr #10]
 988:	05661405 	strbeq	r1, [r6, #-1029]!	; 0xfffffbfb
 98c:	2a056819 	bcs	15a9f8 <__bss_end+0x15174c>
 990:	081e0567 	ldmdaeq	lr, {r0, r1, r2, r5, r6, r8, sl}
 994:	2e150558 	mrccs	5, 0, r0, cr5, cr8, {2}
 998:	05661e05 	strbeq	r1, [r6, #-3589]!	; 0xfffff1fb
 99c:	16054a18 			; <UNDEFINED> instruction: 0x16054a18
 9a0:	d409052f 	strle	r0, [r9], #-1327	; 0xfffffad1
 9a4:	05351405 	ldreq	r1, [r5, #-1029]!	; 0xfffffbfb
 9a8:	0d058310 	stceq	3, cr8, [r5, #-64]	; 0xffffffc0
 9ac:	66120566 	ldrvs	r0, [r2], -r6, ror #10
 9b0:	054a1005 	strbeq	r1, [sl, #-5]
 9b4:	05332d05 	ldreq	r2, [r3, #-3333]!	; 0xfffff2fb
 9b8:	1005670d 	andne	r6, r5, sp, lsl #14
 9bc:	4e0e0566 	cfsh32mi	mvfx0, mvfx14, #54
 9c0:	02001505 	andeq	r1, r0, #20971520	; 0x1400000
 9c4:	054a0304 	strbeq	r0, [sl, #-772]	; 0xfffffcfc
 9c8:	04020017 	streq	r0, [r2], #-23	; 0xffffffe9
 9cc:	12052e03 	andne	r2, r5, #3, 28	; 0x30
 9d0:	02040200 	andeq	r0, r4, #0, 4
 9d4:	000d0567 	andeq	r0, sp, r7, ror #10
 9d8:	83020402 	movwhi	r0, #9218	; 0x2402
 9dc:	02001605 	andeq	r1, r0, #5242880	; 0x500000
 9e0:	05830204 	streq	r0, [r3, #516]	; 0x204
 9e4:	0402000d 	streq	r0, [r2], #-13
 9e8:	16054a02 	strne	r4, [r5], -r2, lsl #20
 9ec:	02040200 	andeq	r0, r4, #0, 4
 9f0:	00100566 	andseq	r0, r0, r6, ror #10
 9f4:	4a020402 	bmi	81a04 <__bss_end+0x78758>
 9f8:	02001205 	andeq	r1, r0, #1342177280	; 0x50000000
 9fc:	052f0204 	streq	r0, [pc, #-516]!	; 800 <shift+0x800>
 a00:	04020005 	streq	r0, [r2], #-5
 a04:	0a05b602 	beq	16e214 <__bss_end+0x164f68>
 a08:	6905058a 	stmdbvs	r5, {r1, r3, r7, r8, sl}
 a0c:	05670f05 	strbeq	r0, [r7, #-3845]!	; 0xfffff0fb
 a10:	2005671d 	andcs	r6, r5, sp, lsl r7
 a14:	01040200 	mrseq	r0, R12_usr
 a18:	001d0582 	andseq	r0, sp, r2, lsl #11
 a1c:	4a010402 	bmi	41a2c <__bss_end+0x38780>
 a20:	054b1105 	strbeq	r1, [fp, #-261]	; 0xfffffefb
 a24:	09056614 	stmdbeq	r5, {r2, r4, r9, sl, sp, lr}
 a28:	1d053149 	stfnes	f3, [r5, #-292]	; 0xfffffedc
 a2c:	01040200 	mrseq	r0, R12_usr
 a30:	001a0582 	andseq	r0, sl, r2, lsl #11
 a34:	4a010402 	bmi	41a44 <__bss_end+0x38798>
 a38:	054b1205 	strbeq	r1, [fp, #-517]	; 0xfffffdfb
 a3c:	01056a0c 	tsteq	r5, ip, lsl #20
 a40:	0905bd2f 	stmdbeq	r5, {r0, r1, r2, r3, r5, r8, sl, fp, ip, sp, pc}
 a44:	001605bd 			; <UNDEFINED> instruction: 0x001605bd
 a48:	4a040402 	bmi	101a58 <__bss_end+0xf87ac>
 a4c:	02001d05 	andeq	r1, r0, #320	; 0x140
 a50:	05820204 	streq	r0, [r2, #516]	; 0x204
 a54:	0402001e 	streq	r0, [r2], #-30	; 0xffffffe2
 a58:	16052e02 	strne	r2, [r5], -r2, lsl #28
 a5c:	02040200 	andeq	r0, r4, #0, 4
 a60:	00110566 	andseq	r0, r1, r6, ror #10
 a64:	4b030402 	blmi	c1a74 <__bss_end+0xb87c8>
 a68:	02001205 	andeq	r1, r0, #1342177280	; 0x50000000
 a6c:	052e0304 	streq	r0, [lr, #-772]!	; 0xfffffcfc
 a70:	04020008 	streq	r0, [r2], #-8
 a74:	09054a03 	stmdbeq	r5, {r0, r1, r9, fp, lr}
 a78:	03040200 	movweq	r0, #16896	; 0x4200
 a7c:	0012052e 	andseq	r0, r2, lr, lsr #10
 a80:	4a030402 	bmi	c1a90 <__bss_end+0xb87e4>
 a84:	02000b05 	andeq	r0, r0, #5120	; 0x1400
 a88:	052e0304 	streq	r0, [lr, #-772]!	; 0xfffffcfc
 a8c:	04020002 	streq	r0, [r2], #-2
 a90:	0b052d03 	bleq	14bea4 <__bss_end+0x142bf8>
 a94:	02040200 	andeq	r0, r4, #0, 4
 a98:	00080584 	andeq	r0, r8, r4, lsl #11
 a9c:	83010402 	movwhi	r0, #5122	; 0x1402
 aa0:	02000905 	andeq	r0, r0, #81920	; 0x14000
 aa4:	052e0104 	streq	r0, [lr, #-260]!	; 0xfffffefc
 aa8:	0402000b 	streq	r0, [r2], #-11
 aac:	02054a01 	andeq	r4, r5, #4096	; 0x1000
 ab0:	01040200 	mrseq	r0, R12_usr
 ab4:	850b0549 	strhi	r0, [fp, #-1353]	; 0xfffffab7
 ab8:	852f0105 	strhi	r0, [pc, #-261]!	; 9bb <shift+0x9bb>
 abc:	05bc0e05 	ldreq	r0, [ip, #3589]!	; 0xe05
 ac0:	20056611 	andcs	r6, r5, r1, lsl r6
 ac4:	660b05bc 			; <UNDEFINED> instruction: 0x660b05bc
 ac8:	054b1f05 	strbeq	r1, [fp, #-3845]	; 0xfffff0fb
 acc:	0805660a 	stmdaeq	r5, {r1, r3, r9, sl, sp, lr}
 ad0:	8311054b 	tsthi	r1, #314572800	; 0x12c00000
 ad4:	052e1605 	streq	r1, [lr, #-1541]!	; 0xfffff9fb
 ad8:	11056708 	tstne	r5, r8, lsl #14
 adc:	4d0b0567 	cfstr32mi	mvfx0, [fp, #-412]	; 0xfffffe64
 ae0:	852f0105 	strhi	r0, [pc, #-261]!	; 9e3 <shift+0x9e3>
 ae4:	05830605 	streq	r0, [r3, #1541]	; 0x605
 ae8:	0c054c0b 	stceq	12, cr4, [r5], {11}
 aec:	660e052e 	strvs	r0, [lr], -lr, lsr #10
 af0:	054b0405 	strbeq	r0, [fp, #-1029]	; 0xfffffbfb
 af4:	09056502 	stmdbeq	r5, {r1, r8, sl, sp, lr}
 af8:	2f010531 	svccs	0x00010531
 afc:	9f080585 	svcls	0x00080585
 b00:	054c0b05 	strbeq	r0, [ip, #-2821]	; 0xfffff4fb
 b04:	04020014 	streq	r0, [r2], #-20	; 0xffffffec
 b08:	07054a03 	streq	r4, [r5, -r3, lsl #20]
 b0c:	02040200 	andeq	r0, r4, #0, 4
 b10:	00080583 	andeq	r0, r8, r3, lsl #11
 b14:	2e020402 	cdpcs	4, 0, cr0, cr2, cr2, {0}
 b18:	02000a05 	andeq	r0, r0, #20480	; 0x5000
 b1c:	054a0204 	strbeq	r0, [sl, #-516]	; 0xfffffdfc
 b20:	04020002 	streq	r0, [r2], #-2
 b24:	01054902 	tsteq	r5, r2, lsl #18
 b28:	0e058584 	cfsh32eq	mvfx8, mvfx5, #-60
 b2c:	4b0805bb 	blmi	202220 <__bss_end+0x1f8f74>
 b30:	054c0b05 	strbeq	r0, [ip, #-2821]	; 0xfffff4fb
 b34:	04020014 	streq	r0, [r2], #-20	; 0xffffffec
 b38:	16054a03 	strne	r4, [r5], -r3, lsl #20
 b3c:	02040200 	andeq	r0, r4, #0, 4
 b40:	00170583 	andseq	r0, r7, r3, lsl #11
 b44:	2e020402 	cdpcs	4, 0, cr0, cr2, cr2, {0}
 b48:	02000a05 	andeq	r0, r0, #20480	; 0x5000
 b4c:	054a0204 	strbeq	r0, [sl, #-516]	; 0xfffffdfc
 b50:	0402000b 	streq	r0, [r2], #-11
 b54:	17052e02 	strne	r2, [r5, -r2, lsl #28]
 b58:	02040200 	andeq	r0, r4, #0, 4
 b5c:	000d054a 	andeq	r0, sp, sl, asr #10
 b60:	2e020402 	cdpcs	4, 0, cr0, cr2, cr2, {0}
 b64:	02000205 	andeq	r0, r0, #1342177280	; 0x50000000
 b68:	052d0204 	streq	r0, [sp, #-516]!	; 0xfffffdfc
 b6c:	2a058401 	bcs	161b78 <__bss_end+0x1588cc>
 b70:	9f100584 	svcls	0x00100584
 b74:	67110567 	ldrvs	r0, [r1, -r7, ror #10]
 b78:	bb2e0905 	bllt	b82f94 <__bss_end+0xb79ce8>
 b7c:	05661005 	strbeq	r1, [r6, #-5]!
 b80:	01056612 	tsteq	r5, r2, lsl r6
 b84:	0006024b 	andeq	r0, r6, fp, asr #4
 b88:	Address 0x0000000000000b88 is out of bounds.


Disassembly of section .debug_info:

00000000 <.debug_info>:
       0:	00000022 	andeq	r0, r0, r2, lsr #32
       4:	00000002 	andeq	r0, r0, r2
       8:	01040000 	mrseq	r0, (UNDEF: 4)
       c:	00000000 	andeq	r0, r0, r0
      10:	00008000 	andeq	r8, r0, r0
      14:	00008008 	andeq	r8, r0, r8
      18:	00000000 	andeq	r0, r0, r0
      1c:	00000056 	andeq	r0, r0, r6, asr r0
      20:	000000ab 	andeq	r0, r0, fp, lsr #1
      24:	00a48001 	adceq	r8, r4, r1
      28:	00040000 	andeq	r0, r4, r0
      2c:	00000014 	andeq	r0, r0, r4, lsl r0
      30:	00c90104 	sbceq	r0, r9, r4, lsl #2
      34:	650c0000 	strvs	r0, [ip, #-0]
      38:	56000001 	strpl	r0, [r0], -r1
      3c:	08000000 	stmdaeq	r0, {}	; <UNPREDICTABLE>
      40:	9c000080 	stcls	0, cr0, [r0], {128}	; 0x80
      44:	86000000 	strhi	r0, [r0], -r0
      48:	02000000 	andeq	r0, r0, #0
      4c:	000001c2 	andeq	r0, r0, r2, asr #3
      50:	31150601 	tstcc	r5, r1, lsl #12
      54:	03000000 	movweq	r0, #0
      58:	053e0704 	ldreq	r0, [lr, #-1796]!	; 0xfffff8fc
      5c:	5b020000 	blpl	80064 <__bss_end+0x76db8>
      60:	01000001 	tsteq	r0, r1
      64:	00311507 	eorseq	r1, r1, r7, lsl #10
      68:	ce040000 	cdpgt	0, 0, cr0, cr4, cr0, {0}
      6c:	01000001 	tsteq	r0, r1
      70:	8064060f 	rsbhi	r0, r4, pc, lsl #12
      74:	00400000 	subeq	r0, r0, r0
      78:	9c010000 	stcls	0, cr0, [r1], {-0}
      7c:	0000006a 	andeq	r0, r0, sl, rrx
      80:	0001bb05 	andeq	fp, r1, r5, lsl #22
      84:	091a0100 	ldmdbeq	sl, {r8}
      88:	0000006a 	andeq	r0, r0, sl, rrx
      8c:	00749102 	rsbseq	r9, r4, r2, lsl #2
      90:	69050406 	stmdbvs	r5, {r1, r2, sl}
      94:	0700746e 	streq	r7, [r0, -lr, ror #8]
      98:	000000b9 	strheq	r0, [r0], -r9
      9c:	08060901 	stmdaeq	r6, {r0, r8, fp}
      a0:	5c000080 	stcpl	0, cr0, [r0], {128}	; 0x80
      a4:	01000000 	mrseq	r0, (UNDEF: 0)
      a8:	0000a19c 	muleq	r0, ip, r1
      ac:	80140800 	andshi	r0, r4, r0, lsl #16
      b0:	00340000 	eorseq	r0, r4, r0
      b4:	63090000 	movwvs	r0, #36864	; 0x9000
      b8:	01007275 	tsteq	r0, r5, ror r2
      bc:	00a1180b 	adceq	r1, r1, fp, lsl #16
      c0:	91020000 	mrsls	r0, (UNDEF: 2)
      c4:	0a000074 	beq	29c <shift+0x29c>
      c8:	00003104 	andeq	r3, r0, r4, lsl #2
      cc:	02020000 	andeq	r0, r2, #0
      d0:	00040000 	andeq	r0, r4, r0
      d4:	000000b9 	strheq	r0, [r0], -r9
      d8:	01e10104 	mvneq	r0, r4, lsl #2
      dc:	14040000 	strne	r0, [r4], #-0
      e0:	56000003 	strpl	r0, [r0], -r3
      e4:	a4000000 	strge	r0, [r0], #-0
      e8:	88000080 	stmdahi	r0, {r7}
      ec:	3b000001 	blcc	f8 <shift+0xf8>
      f0:	02000001 	andeq	r0, r0, #1
      f4:	000003cc 	andeq	r0, r0, ip, asr #7
      f8:	31072f01 	tstcc	r7, r1, lsl #30
      fc:	03000000 	movweq	r0, #0
     100:	00003704 	andeq	r3, r0, r4, lsl #14
     104:	80020400 	andhi	r0, r2, r0, lsl #8
     108:	01000003 	tsteq	r0, r3
     10c:	00310730 	eorseq	r0, r1, r0, lsr r7
     110:	25050000 	strcs	r0, [r5, #-0]
     114:	57000000 	strpl	r0, [r0, -r0]
     118:	06000000 	streq	r0, [r0], -r0
     11c:	00000057 	andeq	r0, r0, r7, asr r0
     120:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
     124:	07040700 	streq	r0, [r4, -r0, lsl #14]
     128:	0000053e 	andeq	r0, r0, lr, lsr r5
     12c:	0003be08 	andeq	fp, r3, r8, lsl #28
     130:	15330100 	ldrne	r0, [r3, #-256]!	; 0xffffff00
     134:	00000044 	andeq	r0, r0, r4, asr #32
     138:	0002ec08 	andeq	lr, r2, r8, lsl #24
     13c:	15350100 	ldrne	r0, [r5, #-256]!	; 0xffffff00
     140:	00000044 	andeq	r0, r0, r4, asr #32
     144:	00003805 	andeq	r3, r0, r5, lsl #16
     148:	00008900 	andeq	r8, r0, r0, lsl #18
     14c:	00570600 	subseq	r0, r7, r0, lsl #12
     150:	ffff0000 			; <UNDEFINED> instruction: 0xffff0000
     154:	0800ffff 	stmdaeq	r0, {r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, sl, fp, ip, sp, lr, pc}
     158:	00000306 	andeq	r0, r0, r6, lsl #6
     15c:	76153801 	ldrvc	r3, [r5], -r1, lsl #16
     160:	08000000 	stmdaeq	r0, {}	; <UNPREDICTABLE>
     164:	00000389 	andeq	r0, r0, r9, lsl #7
     168:	76153a01 	ldrvc	r3, [r5], -r1, lsl #20
     16c:	09000000 	stmdbeq	r0, {}	; <UNPREDICTABLE>
     170:	000002a6 	andeq	r0, r0, r6, lsr #5
     174:	cb104801 	blgt	412180 <__bss_end+0x408ed4>
     178:	d4000000 	strle	r0, [r0], #-0
     17c:	58000081 	stmdapl	r0, {r0, r7}
     180:	01000000 	mrseq	r0, (UNDEF: 0)
     184:	0000cb9c 	muleq	r0, ip, fp
     188:	02b40a00 	adcseq	r0, r4, #0, 20
     18c:	4a010000 	bmi	40194 <__bss_end+0x36ee8>
     190:	0000d20c 	andeq	sp, r0, ip, lsl #4
     194:	74910200 	ldrvc	r0, [r1], #512	; 0x200
     198:	05040b00 	streq	r0, [r4, #-2816]	; 0xfffff500
     19c:	00746e69 	rsbseq	r6, r4, r9, ror #28
     1a0:	00380403 	eorseq	r0, r8, r3, lsl #8
     1a4:	b1090000 	mrslt	r0, (UNDEF: 9)
     1a8:	01000003 	tsteq	r0, r3
     1ac:	00cb103c 	sbceq	r1, fp, ip, lsr r0
     1b0:	817c0000 	cmnhi	ip, r0
     1b4:	00580000 	subseq	r0, r8, r0
     1b8:	9c010000 	stcls	0, cr0, [r1], {-0}
     1bc:	00000102 	andeq	r0, r0, r2, lsl #2
     1c0:	0002b40a 	andeq	fp, r2, sl, lsl #8
     1c4:	0c3e0100 	ldfeqs	f0, [lr], #-0
     1c8:	00000102 	andeq	r0, r0, r2, lsl #2
     1cc:	00749102 	rsbseq	r9, r4, r2, lsl #2
     1d0:	00250403 	eoreq	r0, r5, r3, lsl #8
     1d4:	8f0c0000 	svchi	0x000c0000
     1d8:	01000002 	tsteq	r0, r2
     1dc:	81701129 	cmnhi	r0, r9, lsr #2
     1e0:	000c0000 	andeq	r0, ip, r0
     1e4:	9c010000 	stcls	0, cr0, [r1], {-0}
     1e8:	0002c50c 	andeq	ip, r2, ip, lsl #10
     1ec:	11240100 			; <UNDEFINED> instruction: 0x11240100
     1f0:	00008158 	andeq	r8, r0, r8, asr r1
     1f4:	00000018 	andeq	r0, r0, r8, lsl r0
     1f8:	960c9c01 	strls	r9, [ip], -r1, lsl #24
     1fc:	01000003 	tsteq	r0, r3
     200:	8140111f 	cmphi	r0, pc, lsl r1
     204:	00180000 	andseq	r0, r8, r0
     208:	9c010000 	stcls	0, cr0, [r1], {-0}
     20c:	0002f90c 	andeq	pc, r2, ip, lsl #18
     210:	111a0100 	tstne	sl, r0, lsl #2
     214:	00008128 	andeq	r8, r0, r8, lsr #2
     218:	00000018 	andeq	r0, r0, r8, lsl r0
     21c:	ba0d9c01 	blt	367228 <__bss_end+0x35df7c>
     220:	02000002 	andeq	r0, r0, #2
     224:	00019e00 	andeq	r9, r1, r0, lsl #28
     228:	036e0e00 	cmneq	lr, #0, 28
     22c:	14010000 	strne	r0, [r1], #-0
     230:	00016d12 	andeq	r6, r1, r2, lsl sp
     234:	019e0f00 	orrseq	r0, lr, r0, lsl #30
     238:	02000000 	andeq	r0, r0, #0
     23c:	000001d9 	ldrdeq	r0, [r0], -r9
     240:	a41c0401 	ldrge	r0, [ip], #-1025	; 0xfffffbff
     244:	0e000001 	cdpeq	0, 0, cr0, cr0, cr1, {0}
     248:	000002d8 	ldrdeq	r0, [r0], -r8
     24c:	8b120f01 	blhi	483e58 <__bss_end+0x47abac>
     250:	0f000001 	svceq	0x00000001
     254:	0000019e 	muleq	r0, lr, r1
     258:	03d51000 	bicseq	r1, r5, #0
     25c:	0a010000 	beq	40264 <__bss_end+0x36fb8>
     260:	0000cb11 	andeq	ip, r0, r1, lsl fp
     264:	019e0f00 	orrseq	r0, lr, r0, lsl #30
     268:	00000000 	andeq	r0, r0, r0
     26c:	016d0403 	cmneq	sp, r3, lsl #8
     270:	08070000 	stmdaeq	r7, {}	; <UNPREDICTABLE>
     274:	0003a305 	andeq	sl, r3, r5, lsl #6
     278:	015b1100 	cmpeq	fp, r0, lsl #2
     27c:	81080000 	mrshi	r0, (UNDEF: 8)
     280:	00200000 	eoreq	r0, r0, r0
     284:	9c010000 	stcls	0, cr0, [r1], {-0}
     288:	000001c7 	andeq	r0, r0, r7, asr #3
     28c:	00019e12 	andeq	r9, r1, r2, lsl lr
     290:	74910200 	ldrvc	r0, [r1], #512	; 0x200
     294:	01791100 	cmneq	r9, r0, lsl #2
     298:	80dc0000 	sbcshi	r0, ip, r0
     29c:	002c0000 	eoreq	r0, ip, r0
     2a0:	9c010000 	stcls	0, cr0, [r1], {-0}
     2a4:	000001e8 	andeq	r0, r0, r8, ror #3
     2a8:	01006713 	tsteq	r0, r3, lsl r7
     2ac:	019e300f 	orrseq	r3, lr, pc
     2b0:	91020000 	mrsls	r0, (UNDEF: 2)
     2b4:	8b140074 	blhi	50048c <__bss_end+0x4f71e0>
     2b8:	a4000001 	strge	r0, [r0], #-1
     2bc:	38000080 	stmdacc	r0, {r7}
     2c0:	01000000 	mrseq	r0, (UNDEF: 0)
     2c4:	0067139c 	mlseq	r7, ip, r3, r1
     2c8:	9e2f0a01 	vmulls.f32	s0, s30, s2
     2cc:	02000001 	andeq	r0, r0, #1
     2d0:	00007491 	muleq	r0, r1, r4
     2d4:	00000373 	andeq	r0, r0, r3, ror r3
     2d8:	01e00004 	mvneq	r0, r4
     2dc:	01040000 	mrseq	r0, (UNDEF: 4)
     2e0:	000001e1 	andeq	r0, r0, r1, ror #3
     2e4:	00044d04 	andeq	r4, r4, r4, lsl #26
     2e8:	00005600 	andeq	r5, r0, r0, lsl #12
     2ec:	00822c00 	addeq	r2, r2, r0, lsl #24
     2f0:	00019800 	andeq	r9, r1, r0, lsl #16
     2f4:	00024600 	andeq	r4, r2, r0, lsl #12
     2f8:	08010200 	stmdaeq	r1, {r9}
     2fc:	00000521 	andeq	r0, r0, r1, lsr #10
     300:	00002503 	andeq	r2, r0, r3, lsl #10
     304:	05020200 	streq	r0, [r2, #-512]	; 0xfffffe00
     308:	0000065e 	andeq	r0, r0, lr, asr r6
     30c:	69050404 	stmdbvs	r5, {r2, sl}
     310:	0200746e 	andeq	r7, r0, #1845493760	; 0x6e000000
     314:	05180801 	ldreq	r0, [r8, #-2049]	; 0xfffff7ff
     318:	02020000 	andeq	r0, r2, #0
     31c:	00055507 	andeq	r5, r5, r7, lsl #10
     320:	068d0500 	streq	r0, [sp], r0, lsl #10
     324:	09080000 	stmdbeq	r8, {}	; <UNPREDICTABLE>
     328:	00005e07 	andeq	r5, r0, r7, lsl #28
     32c:	004d0300 	subeq	r0, sp, r0, lsl #6
     330:	04020000 	streq	r0, [r2], #-0
     334:	00053e07 	andeq	r3, r5, r7, lsl #28
     338:	067c0600 	ldrbteq	r0, [ip], -r0, lsl #12
     33c:	04050000 	streq	r0, [r5], #-0
     340:	00000038 	andeq	r0, r0, r8, lsr r0
     344:	900c6604 	andls	r6, ip, r4, lsl #12
     348:	07000000 	streq	r0, [r0, -r0]
     34c:	00000589 	andeq	r0, r0, r9, lsl #11
     350:	06530700 	ldrbeq	r0, [r3], -r0, lsl #14
     354:	07010000 	streq	r0, [r1, -r0]
     358:	000003f9 	strdeq	r0, [r0], -r9
     35c:	061f0702 	ldreq	r0, [pc], -r2, lsl #14
     360:	00030000 	andeq	r0, r3, r0
     364:	00061108 	andeq	r1, r6, r8, lsl #2
     368:	14050200 	strne	r0, [r5], #-512	; 0xfffffe00
     36c:	00000059 	andeq	r0, r0, r9, asr r0
     370:	91f00305 	mvnsls	r0, r5, lsl #6
     374:	be080000 	cdplt	0, 0, cr0, cr8, cr0, {0}
     378:	02000004 	andeq	r0, r0, #4
     37c:	00591406 	subseq	r1, r9, r6, lsl #8
     380:	03050000 	movweq	r0, #20480	; 0x5000
     384:	000091f4 	strdeq	r9, [r0], -r4
     388:	00041008 	andeq	r1, r4, r8
     38c:	1a070300 	bne	1c0f94 <__bss_end+0x1b7ce8>
     390:	00000059 	andeq	r0, r0, r9, asr r0
     394:	91f80305 	mvnsls	r0, r5, lsl #6
     398:	f4080000 	vst4.8	{d0-d3}, [r8], r0
     39c:	03000004 	movweq	r0, #4
     3a0:	00591a09 	subseq	r1, r9, r9, lsl #20
     3a4:	03050000 	movweq	r0, #20480	; 0x5000
     3a8:	000091fc 	strdeq	r9, [r0], -ip
     3ac:	00063708 	andeq	r3, r6, r8, lsl #14
     3b0:	1a0b0300 	bne	2c0fb8 <__bss_end+0x2b7d0c>
     3b4:	00000059 	andeq	r0, r0, r9, asr r0
     3b8:	92000305 	andls	r0, r0, #335544320	; 0x14000000
     3bc:	d7080000 	strle	r0, [r8, -r0]
     3c0:	03000004 	movweq	r0, #4
     3c4:	00591a0d 	subseq	r1, r9, sp, lsl #20
     3c8:	03050000 	movweq	r0, #20480	; 0x5000
     3cc:	00009204 	andeq	r9, r0, r4, lsl #4
     3d0:	00056808 	andeq	r6, r5, r8, lsl #16
     3d4:	1a0f0300 	bne	3c0fdc <__bss_end+0x3b7d30>
     3d8:	00000059 	andeq	r0, r0, r9, asr r0
     3dc:	92080305 	andls	r0, r8, #335544320	; 0x14000000
     3e0:	3a060000 	bcc	1803e8 <__bss_end+0x17713c>
     3e4:	05000010 	streq	r0, [r0, #-16]
     3e8:	00003804 	andeq	r3, r0, r4, lsl #16
     3ec:	0c1b0300 	ldceq	3, cr0, [fp], {-0}
     3f0:	00000133 	andeq	r0, r0, r3, lsr r1
     3f4:	00060707 	andeq	r0, r6, r7, lsl #14
     3f8:	94070000 	strls	r0, [r7], #-0
     3fc:	01000005 	tsteq	r0, r5
     400:	0005c907 	andeq	ip, r5, r7, lsl #18
     404:	09000200 	stmdbeq	r0, {r9}
     408:	00000025 	andeq	r0, r0, r5, lsr #32
     40c:	00000143 	andeq	r0, r0, r3, asr #2
     410:	00005e0a 	andeq	r5, r0, sl, lsl #28
     414:	02000f00 	andeq	r0, r0, #0, 30
     418:	04b10201 	ldrteq	r0, [r1], #513	; 0x201
     41c:	040b0000 	streq	r0, [fp], #-0
     420:	0000002c 	andeq	r0, r0, ip, lsr #32
     424:	0005a808 	andeq	sl, r5, r8, lsl #16
     428:	14040500 	strne	r0, [r4], #-1280	; 0xfffffb00
     42c:	00000059 	andeq	r0, r0, r9, asr r0
     430:	920c0305 	andls	r0, ip, #335544320	; 0x14000000
     434:	e8080000 	stmda	r8, {}	; <UNPREDICTABLE>
     438:	05000005 	streq	r0, [r0, #-5]
     43c:	00591407 	subseq	r1, r9, r7, lsl #8
     440:	03050000 	movweq	r0, #20480	; 0x5000
     444:	00009210 	andeq	r9, r0, r0, lsl r2
     448:	00052608 	andeq	r2, r5, r8, lsl #12
     44c:	140a0500 	strne	r0, [sl], #-1280	; 0xfffffb00
     450:	00000059 	andeq	r0, r0, r9, asr r0
     454:	92140305 	andsls	r0, r4, #335544320	; 0x14000000
     458:	04020000 	streq	r0, [r2], #-0
     45c:	00053907 	andeq	r3, r5, r7, lsl #18
     460:	05d40800 	ldrbeq	r0, [r4, #2048]	; 0x800
     464:	0a060000 	beq	18046c <__bss_end+0x1771c0>
     468:	00005914 	andeq	r5, r0, r4, lsl r9
     46c:	18030500 	stmdane	r3, {r8, sl}
     470:	06000092 			; <UNDEFINED> instruction: 0x06000092
     474:	00000426 	andeq	r0, r0, r6, lsr #8
     478:	00380405 	eorseq	r0, r8, r5, lsl #8
     47c:	03070000 	movweq	r0, #28672	; 0x7000
     480:	0001be0c 	andeq	fp, r1, ip, lsl #28
     484:	05720700 	ldrbeq	r0, [r2, #-1792]!	; 0xfffff900
     488:	07000000 	streq	r0, [r0, -r0]
     48c:	00000579 	andeq	r0, r0, r9, ror r5
     490:	e9060001 	stmdb	r6, {r0}
     494:	05000003 	streq	r0, [r0, #-3]
     498:	00003804 	andeq	r3, r0, r4, lsl #16
     49c:	0c090700 	stceq	7, cr0, [r9], {-0}
     4a0:	0000020b 	andeq	r0, r0, fp, lsl #4
     4a4:	0005f30c 	andeq	pc, r5, ip, lsl #6
     4a8:	0c04b000 	stceq	0, cr11, [r4], {-0}
     4ac:	000005c1 	andeq	r0, r0, r1, asr #11
     4b0:	100c0960 	andne	r0, ip, r0, ror #18
     4b4:	c0000005 	andgt	r0, r0, r5
     4b8:	04b60c12 	ldrteq	r0, [r6], #3090	; 0xc12
     4bc:	25800000 	strcs	r0, [r0]
     4c0:	00059f0c 	andeq	r9, r5, ip, lsl #30
     4c4:	0c4b0000 	mareq	acc0, r0, fp
     4c8:	00000580 	andeq	r0, r0, r0, lsl #11
     4cc:	4a0c9600 	bmi	325cd4 <__bss_end+0x31ca28>
     4d0:	00000006 	andeq	r0, r0, r6
     4d4:	04430de1 	strbeq	r0, [r3], #-3553	; 0xfffff21f
     4d8:	c2000000 	andgt	r0, r0, #0
     4dc:	0e000001 	cdpeq	0, 0, cr0, cr0, cr1, {0}
     4e0:	0000069e 	muleq	r0, lr, r6
     4e4:	08160708 	ldmdaeq	r6, {r3, r8, r9, sl}
     4e8:	00000233 	andeq	r0, r0, r3, lsr r2
     4ec:	0005fb0f 	andeq	pc, r5, pc, lsl #22
     4f0:	17180700 	ldrne	r0, [r8, -r0, lsl #14]
     4f4:	0000019f 	muleq	r0, pc, r1	; <UNPREDICTABLE>
     4f8:	05060f00 	streq	r0, [r6, #-3840]	; 0xfffff100
     4fc:	19070000 	stmdbne	r7, {}	; <UNPREDICTABLE>
     500:	0001be15 	andeq	fp, r1, r5, lsl lr
     504:	10000400 	andne	r0, r0, r0, lsl #8
     508:	000005e3 	andeq	r0, r0, r3, ror #11
     50c:	38051201 	stmdacc	r5, {r0, r9, ip}
     510:	68000000 	stmdavs	r0, {}	; <UNPREDICTABLE>
     514:	5c000082 	stcpl	0, cr0, [r0], {130}	; 0x82
     518:	01000001 	tsteq	r0, r1
     51c:	0003199c 	muleq	r3, ip, r9
     520:	06451100 	strbeq	r1, [r5], -r0, lsl #2
     524:	12010000 	andne	r0, r1, #0
     528:	0000380e 	andeq	r3, r0, lr, lsl #16
     52c:	9c910300 	ldcls	3, cr0, [r1], {0}
     530:	0670117e 			; <UNDEFINED> instruction: 0x0670117e
     534:	12010000 	andne	r0, r1, #0
     538:	0003191b 	andeq	r1, r3, fp, lsl r9
     53c:	98910300 	ldmls	r1, {r8, r9}
     540:	054b127e 	strbeq	r1, [fp, #-638]	; 0xfffffd82
     544:	14010000 	strne	r0, [r1], #-0
     548:	00004d0b 	andeq	r4, r0, fp, lsl #26
     54c:	74910200 	ldrvc	r0, [r1], #512	; 0x200
     550:	00067512 	andeq	r7, r6, r2, lsl r5
     554:	15160100 	ldrne	r0, [r6, #-256]	; 0xffffff00
     558:	0000020b 	andeq	r0, r0, fp, lsl #4
     55c:	13589102 	cmpne	r8, #-2147483648	; 0x80000000
     560:	00667562 	rsbeq	r7, r6, r2, ror #10
     564:	25071d01 	strcs	r1, [r7, #-3329]	; 0xfffff2ff
     568:	03000003 	movweq	r0, #3
     56c:	127fb491 	rsbsne	fp, pc, #-1862270976	; 0x91000000
     570:	00000668 	andeq	r0, r0, r8, ror #12
     574:	35071e01 	strcc	r1, [r7, #-3585]	; 0xfffff1ff
     578:	03000003 	movweq	r0, #3
     57c:	127eb491 	rsbsne	fp, lr, #-1862270976	; 0x91000000
     580:	000006b1 			; <UNDEFINED> instruction: 0x000006b1
     584:	33071f01 	movwcc	r1, #32513	; 0x7f01
     588:	03000001 	movweq	r0, #1
     58c:	127ea491 	rsbsne	sl, lr, #-1862270976	; 0x91000000
     590:	000004ea 	andeq	r0, r0, sl, ror #9
     594:	4d0b2501 	cfstr32mi	mvfx2, [fp, #-4]
     598:	02000000 	andeq	r0, r0, #0
     59c:	38127091 	ldmdacc	r2, {r0, r4, r7, ip, sp, lr}
     5a0:	01000004 	tsteq	r0, r4
     5a4:	004d1a25 	subeq	r1, sp, r5, lsr #20
     5a8:	91020000 	mrsls	r0, (UNDEF: 2)
     5ac:	0696126c 	ldreq	r1, [r6], ip, ror #4
     5b0:	27010000 	strcs	r0, [r1, -r0]
     5b4:	00004d0b 	andeq	r4, r0, fp, lsl #26
     5b8:	68910200 	ldmvs	r1, {r9}
     5bc:	00830c14 	addeq	r0, r3, r4, lsl ip
     5c0:	00009c00 	andeq	r9, r0, r0, lsl #24
     5c4:	00761300 	rsbseq	r1, r6, r0, lsl #6
     5c8:	4d0c2d01 	stcmi	13, cr2, [ip, #-4]
     5cc:	02000000 	andeq	r0, r0, #0
     5d0:	40146491 	mulsmi	r4, r1, r4
     5d4:	68000083 	stmdavs	r0, {r0, r1, r7}
     5d8:	12000000 	andne	r0, r0, #0
     5dc:	000004ef 	andeq	r0, r0, pc, ror #9
     5e0:	4d0d4901 	vstrmi.16	s8, [sp, #-2]	; <UNPREDICTABLE>
     5e4:	02000000 	andeq	r0, r0, #0
     5e8:	00006091 	muleq	r0, r1, r0
     5ec:	1f040b00 	svcne	0x00040b00
     5f0:	0b000003 	bleq	604 <shift+0x604>
     5f4:	00002504 	andeq	r2, r0, r4, lsl #10
     5f8:	00250900 	eoreq	r0, r5, r0, lsl #18
     5fc:	03350000 	teqeq	r5, #0
     600:	5e0a0000 	cdppl	0, 0, cr0, cr10, cr0, {0}
     604:	20000000 	andcs	r0, r0, r0
     608:	00250900 	eoreq	r0, r5, r0, lsl #18
     60c:	03450000 	movteq	r0, #20480	; 0x5000
     610:	5e0a0000 	cdppl	0, 0, cr0, cr10, cr0, {0}
     614:	7f000000 	svcvc	0x00000000
     618:	04ca1500 	strbeq	r1, [sl], #1280	; 0x500
     61c:	0d010000 	stceq	0, cr0, [r1, #-0]
     620:	00822c0d 	addeq	r2, r2, sp, lsl #24
     624:	00003c00 	andeq	r3, r0, r0, lsl #24
     628:	119c0100 	orrsne	r0, ip, r0, lsl #2
     62c:	00000550 	andeq	r0, r0, r0, asr r5
     630:	4d1c0d01 	ldcmi	13, cr0, [ip, #-4]
     634:	02000000 	andeq	r0, r0, #0
     638:	d0117491 	mulsle	r1, r1, r4
     63c:	01000004 	tsteq	r0, r4
     640:	014a2e0d 	cmpeq	sl, sp, lsl #28
     644:	91020000 	mrsls	r0, (UNDEF: 2)
     648:	1f000070 	svcne	0x00000070
     64c:	0400000b 	streq	r0, [r0], #-11
     650:	00031000 	andeq	r1, r3, r0
     654:	4a010400 	bmi	4165c <__bss_end+0x383b0>
     658:	0400000e 	streq	r0, [r0], #-14
     65c:	00000c61 	andeq	r0, r0, r1, ror #24
     660:	000006c4 	andeq	r0, r0, r4, asr #13
     664:	000083c4 	andeq	r8, r0, r4, asr #7
     668:	0000045c 	andeq	r0, r0, ip, asr r4
     66c:	0000052f 	andeq	r0, r0, pc, lsr #10
     670:	21080102 	tstcs	r8, r2, lsl #2
     674:	03000005 	movweq	r0, #5
     678:	00000025 	andeq	r0, r0, r5, lsr #32
     67c:	5e050202 	cdppl	2, 0, cr0, cr5, cr2, {0}
     680:	04000006 	streq	r0, [r0], #-6
     684:	6e690504 	cdpvs	5, 6, cr0, cr9, cr4, {0}
     688:	01020074 	tsteq	r2, r4, ror r0
     68c:	00051808 	andeq	r1, r5, r8, lsl #16
     690:	07020200 	streq	r0, [r2, -r0, lsl #4]
     694:	00000555 	andeq	r0, r0, r5, asr r5
     698:	00068d05 	andeq	r8, r6, r5, lsl #26
     69c:	07090700 	streq	r0, [r9, -r0, lsl #14]
     6a0:	0000005e 	andeq	r0, r0, lr, asr r0
     6a4:	00004d03 	andeq	r4, r0, r3, lsl #26
     6a8:	07040200 	streq	r0, [r4, -r0, lsl #4]
     6ac:	0000053e 	andeq	r0, r0, lr, lsr r5
     6b0:	00090906 	andeq	r0, r9, r6, lsl #18
     6b4:	06020800 	streq	r0, [r2], -r0, lsl #16
     6b8:	00008b08 	andeq	r8, r0, r8, lsl #22
     6bc:	30720700 	rsbscc	r0, r2, r0, lsl #14
     6c0:	0e080200 	cdpeq	2, 0, cr0, cr8, cr0, {0}
     6c4:	0000004d 	andeq	r0, r0, sp, asr #32
     6c8:	31720700 	cmncc	r2, r0, lsl #14
     6cc:	0e090200 	cdpeq	2, 0, cr0, cr9, cr0, {0}
     6d0:	0000004d 	andeq	r0, r0, sp, asr #32
     6d4:	1c080004 	stcne	0, cr0, [r8], {4}
     6d8:	0500000d 	streq	r0, [r0, #-13]
     6dc:	00003804 	andeq	r3, r0, r4, lsl #16
     6e0:	0c0d0200 	sfmeq	f0, 4, [sp], {-0}
     6e4:	000000a9 	andeq	r0, r0, r9, lsr #1
     6e8:	004b4f09 	subeq	r4, fp, r9, lsl #30
     6ec:	09220a00 	stmdbeq	r2!, {r9, fp}
     6f0:	00010000 	andeq	r0, r1, r0
     6f4:	0007ea08 	andeq	lr, r7, r8, lsl #20
     6f8:	38040500 	stmdacc	r4, {r8, sl}
     6fc:	02000000 	andeq	r0, r0, #0
     700:	00e00c1e 	rsceq	r0, r0, lr, lsl ip
     704:	740a0000 	strvc	r0, [sl], #-0
     708:	00000009 	andeq	r0, r0, r9
     70c:	00106a0a 	andseq	r6, r0, sl, lsl #20
     710:	4a0a0100 	bmi	280b18 <__bss_end+0x27786c>
     714:	02000010 	andeq	r0, r0, #16
     718:	000ac20a 	andeq	ip, sl, sl, lsl #4
     71c:	ec0a0300 	stc	3, cr0, [sl], {-0}
     720:	0400000b 	streq	r0, [r0], #-11
     724:	0009340a 	andeq	r3, r9, sl, lsl #8
     728:	08000500 	stmdaeq	r0, {r8, sl}
     72c:	00000fc4 	andeq	r0, r0, r4, asr #31
     730:	00380405 	eorseq	r0, r8, r5, lsl #8
     734:	3f020000 	svccc	0x00020000
     738:	00011d0c 	andeq	r1, r1, ip, lsl #26
     73c:	070f0a00 	streq	r0, [pc, -r0, lsl #20]
     740:	0a000000 	beq	748 <shift+0x748>
     744:	000007ff 	strdeq	r0, [r0], -pc	; <UNPREDICTABLE>
     748:	05ce0a01 	strbeq	r0, [lr, #2561]	; 0xa01
     74c:	0a020000 	beq	80754 <__bss_end+0x774a8>
     750:	00001021 	andeq	r1, r0, r1, lsr #32
     754:	10740a03 	rsbsne	r0, r4, r3, lsl #20
     758:	0a040000 	beq	100760 <__bss_end+0xf74b4>
     75c:	00000ba6 	andeq	r0, r0, r6, lsr #23
     760:	0aa10a05 	beq	fe842f7c <__bss_end+0xfe839cd0>
     764:	00060000 	andeq	r0, r6, r0
     768:	00067c08 	andeq	r7, r6, r8, lsl #24
     76c:	38040500 	stmdacc	r4, {r8, sl}
     770:	02000000 	andeq	r0, r0, #0
     774:	01480c66 	cmpeq	r8, r6, ror #24
     778:	890a0000 	stmdbhi	sl, {}	; <UNPREDICTABLE>
     77c:	00000005 	andeq	r0, r0, r5
     780:	0006530a 	andeq	r5, r6, sl, lsl #6
     784:	f90a0100 			; <UNDEFINED> instruction: 0xf90a0100
     788:	02000003 	andeq	r0, r0, #3
     78c:	00061f0a 	andeq	r1, r6, sl, lsl #30
     790:	0b000300 	bleq	1398 <shift+0x1398>
     794:	00000611 	andeq	r0, r0, r1, lsl r6
     798:	59140503 	ldmdbpl	r4, {r0, r1, r8, sl}
     79c:	05000000 	streq	r0, [r0, #-0]
     7a0:	00925003 	addseq	r5, r2, r3
     7a4:	04be0b00 	ldrteq	r0, [lr], #2816	; 0xb00
     7a8:	06030000 	streq	r0, [r3], -r0
     7ac:	00005914 	andeq	r5, r0, r4, lsl r9
     7b0:	54030500 	strpl	r0, [r3], #-1280	; 0xfffffb00
     7b4:	0b000092 	bleq	a04 <shift+0xa04>
     7b8:	00000410 	andeq	r0, r0, r0, lsl r4
     7bc:	591a0704 	ldmdbpl	sl, {r2, r8, r9, sl}
     7c0:	05000000 	streq	r0, [r0, #-0]
     7c4:	00925803 	addseq	r5, r2, r3, lsl #16
     7c8:	04f40b00 	ldrbteq	r0, [r4], #2816	; 0xb00
     7cc:	09040000 	stmdbeq	r4, {}	; <UNPREDICTABLE>
     7d0:	0000591a 	andeq	r5, r0, sl, lsl r9
     7d4:	5c030500 	cfstr32pl	mvfx0, [r3], {-0}
     7d8:	0b000092 	bleq	a28 <shift+0xa28>
     7dc:	00000637 	andeq	r0, r0, r7, lsr r6
     7e0:	591a0b04 	ldmdbpl	sl, {r2, r8, r9, fp}
     7e4:	05000000 	streq	r0, [r0, #-0]
     7e8:	00926003 	addseq	r6, r2, r3
     7ec:	04d70b00 	ldrbeq	r0, [r7], #2816	; 0xb00
     7f0:	0d040000 	stceq	0, cr0, [r4, #-0]
     7f4:	0000591a 	andeq	r5, r0, sl, lsl r9
     7f8:	64030500 	strvs	r0, [r3], #-1280	; 0xfffffb00
     7fc:	0b000092 	bleq	a4c <shift+0xa4c>
     800:	00000568 	andeq	r0, r0, r8, ror #10
     804:	591a0f04 	ldmdbpl	sl, {r2, r8, r9, sl, fp}
     808:	05000000 	streq	r0, [r0, #-0]
     80c:	00926803 	addseq	r6, r2, r3, lsl #16
     810:	103a0800 	eorsne	r0, sl, r0, lsl #16
     814:	04050000 	streq	r0, [r5], #-0
     818:	00000038 	andeq	r0, r0, r8, lsr r0
     81c:	eb0c1b04 	bl	307434 <__bss_end+0x2fe188>
     820:	0a000001 	beq	82c <shift+0x82c>
     824:	00000607 	andeq	r0, r0, r7, lsl #12
     828:	05940a00 	ldreq	r0, [r4, #2560]	; 0xa00
     82c:	0a010000 	beq	40834 <__bss_end+0x37588>
     830:	000005c9 	andeq	r0, r0, r9, asr #11
     834:	5b0c0002 	blpl	300844 <__bss_end+0x2f7598>
     838:	0200000c 	andeq	r0, r0, #12
     83c:	04b10201 	ldrteq	r0, [r1], #513	; 0x201
     840:	040d0000 	streq	r0, [sp], #-0
     844:	0000002c 	andeq	r0, r0, ip, lsr #32
     848:	01eb040d 	mvneq	r0, sp, lsl #8
     84c:	a80b0000 	stmdage	fp, {}	; <UNPREDICTABLE>
     850:	05000005 	streq	r0, [r0, #-5]
     854:	00591404 	subseq	r1, r9, r4, lsl #8
     858:	03050000 	movweq	r0, #20480	; 0x5000
     85c:	0000926c 	andeq	r9, r0, ip, ror #4
     860:	0005e80b 	andeq	lr, r5, fp, lsl #16
     864:	14070500 	strne	r0, [r7], #-1280	; 0xfffffb00
     868:	00000059 	andeq	r0, r0, r9, asr r0
     86c:	92700305 	rsbsls	r0, r0, #335544320	; 0x14000000
     870:	260b0000 	strcs	r0, [fp], -r0
     874:	05000005 	streq	r0, [r0, #-5]
     878:	0059140a 	subseq	r1, r9, sl, lsl #8
     87c:	03050000 	movweq	r0, #20480	; 0x5000
     880:	00009274 	andeq	r9, r0, r4, ror r2
     884:	000b1d08 	andeq	r1, fp, r8, lsl #26
     888:	38040500 	stmdacc	r4, {r8, sl}
     88c:	05000000 	streq	r0, [r0, #-0]
     890:	02700c0d 	rsbseq	r0, r0, #3328	; 0xd00
     894:	4e090000 	cdpmi	0, 0, cr0, cr9, cr0, {0}
     898:	00007765 	andeq	r7, r0, r5, ror #14
     89c:	000b140a 	andeq	r1, fp, sl, lsl #8
     8a0:	2d0a0100 	stfcss	f0, [sl, #-0]
     8a4:	0200000d 	andeq	r0, r0, #13
     8a8:	000ae60a 	andeq	lr, sl, sl, lsl #12
     8ac:	b40a0300 	strlt	r0, [sl], #-768	; 0xfffffd00
     8b0:	0400000a 	streq	r0, [r0], #-10
     8b4:	000be50a 	andeq	lr, fp, sl, lsl #10
     8b8:	06000500 	streq	r0, [r0], -r0, lsl #10
     8bc:	00000927 	andeq	r0, r0, r7, lsr #18
     8c0:	081b0510 	ldmdaeq	fp, {r4, r8, sl}
     8c4:	000002af 	andeq	r0, r0, pc, lsr #5
     8c8:	00726c07 	rsbseq	r6, r2, r7, lsl #24
     8cc:	af131d05 	svcge	0x00131d05
     8d0:	00000002 	andeq	r0, r0, r2
     8d4:	00707307 	rsbseq	r7, r0, r7, lsl #6
     8d8:	af131e05 	svcge	0x00131e05
     8dc:	04000002 	streq	r0, [r0], #-2
     8e0:	00637007 	rsbeq	r7, r3, r7
     8e4:	af131f05 	svcge	0x00131f05
     8e8:	08000002 	stmdaeq	r0, {r1}
     8ec:	0009460e 	andeq	r4, r9, lr, lsl #12
     8f0:	13200500 	nopne	{0}	; <UNPREDICTABLE>
     8f4:	000002af 	andeq	r0, r0, pc, lsr #5
     8f8:	0402000c 	streq	r0, [r2], #-12
     8fc:	00053907 	andeq	r3, r5, r7, lsl #18
     900:	09e30600 	stmibeq	r3!, {r9, sl}^
     904:	05700000 	ldrbeq	r0, [r0, #-0]!
     908:	03460828 	movteq	r0, #26664	; 0x6828
     90c:	9a0e0000 	bls	380914 <__bss_end+0x377668>
     910:	0500000d 	streq	r0, [r0, #-13]
     914:	0270122a 	rsbseq	r1, r0, #-1610612734	; 0xa0000002
     918:	07000000 	streq	r0, [r0, -r0]
     91c:	00646970 	rsbeq	r6, r4, r0, ror r9
     920:	5e122b05 	vnmlspl.f64	d2, d2, d5
     924:	10000000 	andne	r0, r0, r0
     928:	0008440e 	andeq	r4, r8, lr, lsl #8
     92c:	112c0500 			; <UNDEFINED> instruction: 0x112c0500
     930:	00000239 	andeq	r0, r0, r9, lsr r2
     934:	0b290e14 	bleq	a4418c <__bss_end+0xa3aee0>
     938:	2d050000 	stccs	0, cr0, [r5, #-0]
     93c:	00005e12 	andeq	r5, r0, r2, lsl lr
     940:	370e1800 	strcc	r1, [lr, -r0, lsl #16]
     944:	0500000b 	streq	r0, [r0, #-11]
     948:	005e122e 	subseq	r1, lr, lr, lsr #4
     94c:	0e1c0000 	cdpeq	0, 1, cr0, cr12, cr0, {0}
     950:	00000915 	andeq	r0, r0, r5, lsl r9
     954:	460c2f05 	strmi	r2, [ip], -r5, lsl #30
     958:	20000003 	andcs	r0, r0, r3
     95c:	000b530e 	andeq	r5, fp, lr, lsl #6
     960:	09300500 	ldmdbeq	r0!, {r8, sl}
     964:	00000038 	andeq	r0, r0, r8, lsr r0
     968:	0dad0e60 	stceq	14, cr0, [sp, #384]!	; 0x180
     96c:	31050000 	mrscc	r0, (UNDEF: 5)
     970:	00004d0e 	andeq	r4, r0, lr, lsl #26
     974:	850e6400 	strhi	r6, [lr, #-1024]	; 0xfffffc00
     978:	05000009 	streq	r0, [r0, #-9]
     97c:	004d0e33 	subeq	r0, sp, r3, lsr lr
     980:	0e680000 	cdpeq	0, 6, cr0, cr8, cr0, {0}
     984:	0000097c 	andeq	r0, r0, ip, ror r9
     988:	4d0e3405 	cfstrsmi	mvf3, [lr, #-20]	; 0xffffffec
     98c:	6c000000 	stcvs	0, cr0, [r0], {-0}
     990:	01fd0f00 	mvnseq	r0, r0, lsl #30
     994:	03560000 	cmpeq	r6, #0
     998:	5e100000 	cdppl	0, 1, cr0, cr0, cr0, {0}
     99c:	0f000000 	svceq	0x00000000
     9a0:	05d40b00 	ldrbeq	r0, [r4, #2816]	; 0xb00
     9a4:	0a060000 	beq	1809ac <__bss_end+0x177700>
     9a8:	00005914 	andeq	r5, r0, r4, lsl r9
     9ac:	78030500 	stmdavc	r3, {r8, sl}
     9b0:	08000092 	stmdaeq	r0, {r1, r4, r7}
     9b4:	00000aee 	andeq	r0, r0, lr, ror #21
     9b8:	00380405 	eorseq	r0, r8, r5, lsl #8
     9bc:	0d060000 	stceq	0, cr0, [r6, #-0]
     9c0:	0003870c 	andeq	r8, r3, ip, lsl #14
     9c4:	08040a00 	stmdaeq	r4, {r9, fp}
     9c8:	0a000000 	beq	9d0 <shift+0x9d0>
     9cc:	000006b9 			; <UNDEFINED> instruction: 0x000006b9
     9d0:	68030001 	stmdavs	r3, {r0}
     9d4:	08000003 	stmdaeq	r0, {r0, r1}
     9d8:	00000b82 	andeq	r0, r0, r2, lsl #23
     9dc:	00380405 	eorseq	r0, r8, r5, lsl #8
     9e0:	14060000 	strne	r0, [r6], #-0
     9e4:	0003ab0c 	andeq	sl, r3, ip, lsl #22
     9e8:	074e0a00 	strbeq	r0, [lr, -r0, lsl #20]
     9ec:	0a000000 	beq	9f4 <shift+0x9f4>
     9f0:	00000cee 	andeq	r0, r0, lr, ror #25
     9f4:	8c030001 	stchi	0, cr0, [r3], {1}
     9f8:	06000003 	streq	r0, [r0], -r3
     9fc:	00000f1e 	andeq	r0, r0, lr, lsl pc
     a00:	081b060c 	ldmdaeq	fp, {r2, r3, r9, sl}
     a04:	000003e5 	andeq	r0, r0, r5, ror #7
     a08:	0007490e 	andeq	r4, r7, lr, lsl #18
     a0c:	191d0600 	ldmdbne	sp, {r9, sl}
     a10:	000003e5 	andeq	r0, r0, r5, ror #7
     a14:	07c10e00 	strbeq	r0, [r1, r0, lsl #28]
     a18:	1e060000 	cdpne	0, 0, cr0, cr6, cr0, {0}
     a1c:	0003e519 	andeq	lr, r3, r9, lsl r5
     a20:	210e0400 	tstcs	lr, r0, lsl #8
     a24:	0600000e 	streq	r0, [r0], -lr
     a28:	03eb131f 	mvneq	r1, #2080374784	; 0x7c000000
     a2c:	00080000 	andeq	r0, r8, r0
     a30:	03b0040d 	movseq	r0, #218103808	; 0xd000000
     a34:	040d0000 	streq	r0, [sp], #-0
     a38:	000002b6 			; <UNDEFINED> instruction: 0x000002b6
     a3c:	00086911 	andeq	r6, r8, r1, lsl r9
     a40:	22061400 	andcs	r1, r6, #0, 8
     a44:	00067307 	andeq	r7, r6, r7, lsl #6
     a48:	0adc0e00 	beq	ff704250 <__bss_end+0xff6fafa4>
     a4c:	26060000 	strcs	r0, [r6], -r0
     a50:	00004d12 	andeq	r4, r0, r2, lsl sp
     a54:	7a0e0000 	bvc	380a5c <__bss_end+0x3777b0>
     a58:	06000007 	streq	r0, [r0], -r7
     a5c:	03e51d29 	mvneq	r1, #2624	; 0xa40
     a60:	0e040000 	cdpeq	0, 0, cr0, cr4, cr0, {0}
     a64:	00000d71 	andeq	r0, r0, r1, ror sp
     a68:	e51d2c06 	ldr	r2, [sp, #-3078]	; 0xfffff3fa
     a6c:	08000003 	stmdaeq	r0, {r0, r1}
     a70:	000fba12 	andeq	fp, pc, r2, lsl sl	; <UNPREDICTABLE>
     a74:	0e2f0600 	cfmadda32eq	mvax0, mvax0, mvfx15, mvfx0
     a78:	00000efb 	strdeq	r0, [r0], -fp
     a7c:	00000439 	andeq	r0, r0, r9, lsr r4
     a80:	00000444 	andeq	r0, r0, r4, asr #8
     a84:	00067813 	andeq	r7, r6, r3, lsl r8
     a88:	03e51400 	mvneq	r1, #0, 8
     a8c:	15000000 	strne	r0, [r0, #-0]
     a90:	00000e32 	andeq	r0, r0, r2, lsr lr
     a94:	ba0e3106 	blt	38ceb4 <__bss_end+0x383c08>
     a98:	f0000009 			; <UNDEFINED> instruction: 0xf0000009
     a9c:	5c000001 	stcpl	0, cr0, [r0], {1}
     aa0:	67000004 	strvs	r0, [r0, -r4]
     aa4:	13000004 	movwne	r0, #4
     aa8:	00000678 	andeq	r0, r0, r8, ror r6
     aac:	0003eb14 	andeq	lr, r3, r4, lsl fp
     ab0:	31160000 	tstcc	r6, r0
     ab4:	0600000f 	streq	r0, [r0], -pc
     ab8:	0dfc1d35 	ldcleq	13, cr1, [ip, #212]!	; 0xd4
     abc:	03e50000 	mvneq	r0, #0
     ac0:	80020000 	andhi	r0, r2, r0
     ac4:	86000004 	strhi	r0, [r0], -r4
     ac8:	13000004 	movwne	r0, #4
     acc:	00000678 	andeq	r0, r0, r8, ror r6
     ad0:	0a941600 	beq	fe5062d8 <__bss_end+0xfe4fd02c>
     ad4:	37060000 	strcc	r0, [r6, -r0]
     ad8:	000cbd1d 	andeq	fp, ip, sp, lsl sp
     adc:	0003e500 	andeq	lr, r3, r0, lsl #10
     ae0:	049f0200 	ldreq	r0, [pc], #512	; ae8 <shift+0xae8>
     ae4:	04a50000 	strteq	r0, [r5], #0
     ae8:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
     aec:	00000006 	andeq	r0, r0, r6
     af0:	000b6317 	andeq	r6, fp, r7, lsl r3
     af4:	31390600 	teqcc	r9, r0, lsl #12
     af8:	00000691 	muleq	r0, r1, r6
     afc:	6916020c 	ldmdbvs	r6, {r2, r3, r9}
     b00:	06000008 	streq	r0, [r0], -r8
     b04:	1050093c 	subsne	r0, r0, ip, lsr r9
     b08:	06780000 	ldrbteq	r0, [r8], -r0
     b0c:	cc010000 	stcgt	0, cr0, [r1], {-0}
     b10:	d2000004 	andle	r0, r0, #4
     b14:	13000004 	movwne	r0, #4
     b18:	00000678 	andeq	r0, r0, r8, ror r6
     b1c:	08191600 	ldmdaeq	r9, {r9, sl, ip}
     b20:	3f060000 	svccc	0x00060000
     b24:	000f8f12 	andeq	r8, pc, r2, lsl pc	; <UNPREDICTABLE>
     b28:	00004d00 	andeq	r4, r0, r0, lsl #26
     b2c:	04eb0100 	strbteq	r0, [fp], #256	; 0x100
     b30:	05000000 	streq	r0, [r0, #-0]
     b34:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
     b38:	14000006 	strne	r0, [r0], #-6
     b3c:	0000069a 	muleq	r0, sl, r6
     b40:	00005e14 	andeq	r5, r0, r4, lsl lr
     b44:	01f01400 	mvnseq	r1, r0, lsl #8
     b48:	18000000 	stmdane	r0, {}	; <UNPREDICTABLE>
     b4c:	00000e41 	andeq	r0, r0, r1, asr #28
     b50:	0d0e4206 	sfmeq	f4, 4, [lr, #-24]	; 0xffffffe8
     b54:	0100000c 	tsteq	r0, ip
     b58:	00000515 	andeq	r0, r0, r5, lsl r5
     b5c:	0000051b 	andeq	r0, r0, fp, lsl r5
     b60:	00067813 	andeq	r7, r6, r3, lsl r8
     b64:	2e160000 	cdpcs	0, 1, cr0, cr6, cr0, {0}
     b68:	0600000a 	streq	r0, [r0], -sl
     b6c:	078d1745 	streq	r1, [sp, r5, asr #14]
     b70:	03eb0000 	mvneq	r0, #0
     b74:	34010000 	strcc	r0, [r1], #-0
     b78:	3a000005 	bcc	b94 <shift+0xb94>
     b7c:	13000005 	movwne	r0, #5
     b80:	000006a0 	andeq	r0, r0, r0, lsr #13
     b84:	07c61600 	strbeq	r1, [r6, r0, lsl #12]
     b88:	48060000 	stmdami	r6, {}	; <UNPREDICTABLE>
     b8c:	000db917 	andeq	fp, sp, r7, lsl r9
     b90:	0003eb00 	andeq	lr, r3, r0, lsl #22
     b94:	05530100 	ldrbeq	r0, [r3, #-256]	; 0xffffff00
     b98:	055e0000 	ldrbeq	r0, [lr, #-0]
     b9c:	a0130000 	andsge	r0, r3, r0
     ba0:	14000006 	strne	r0, [r0], #-6
     ba4:	0000004d 	andeq	r0, r0, sp, asr #32
     ba8:	10061800 	andne	r1, r6, r0, lsl #16
     bac:	4b060000 	blmi	180bb4 <__bss_end+0x177908>
     bb0:	0007140e 	andeq	r1, r7, lr, lsl #8
     bb4:	05730100 	ldrbeq	r0, [r3, #-256]!	; 0xffffff00
     bb8:	05790000 	ldrbeq	r0, [r9, #-0]!
     bbc:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
     bc0:	00000006 	andeq	r0, r0, r6
     bc4:	000e3216 	andeq	r3, lr, r6, lsl r2
     bc8:	0e4d0600 	cdpeq	6, 4, cr0, cr13, cr0, {0}
     bcc:	0000094c 	andeq	r0, r0, ip, asr #18
     bd0:	000001f0 	strdeq	r0, [r0], -r0	; <UNPREDICTABLE>
     bd4:	00059201 	andeq	r9, r5, r1, lsl #4
     bd8:	00059d00 	andeq	r9, r5, r0, lsl #26
     bdc:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
     be0:	4d140000 	ldcmi	0, cr0, [r4, #-0]
     be4:	00000000 	andeq	r0, r0, r0
     be8:	000a5316 	andeq	r5, sl, r6, lsl r3
     bec:	12500600 	subsne	r0, r0, #0, 12
     bf0:	00000c2e 	andeq	r0, r0, lr, lsr #24
     bf4:	0000004d 	andeq	r0, r0, sp, asr #32
     bf8:	0005b601 	andeq	fp, r5, r1, lsl #12
     bfc:	0005c100 	andeq	ip, r5, r0, lsl #2
     c00:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
     c04:	fd140000 	ldc2	0, cr0, [r4, #-0]
     c08:	00000001 	andeq	r0, r0, r1
     c0c:	00075b16 	andeq	r5, r7, r6, lsl fp
     c10:	0e530600 	cdpeq	6, 5, cr0, cr3, cr0, {0}
     c14:	0000098e 	andeq	r0, r0, lr, lsl #19
     c18:	000001f0 	strdeq	r0, [r0], -r0	; <UNPREDICTABLE>
     c1c:	0005da01 	andeq	sp, r5, r1, lsl #20
     c20:	0005e500 	andeq	lr, r5, r0, lsl #10
     c24:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
     c28:	4d140000 	ldcmi	0, cr0, [r4, #-0]
     c2c:	00000000 	andeq	r0, r0, r0
     c30:	000a7b18 	andeq	r7, sl, r8, lsl fp
     c34:	0e560600 	cdpeq	6, 5, cr0, cr6, cr0, {0}
     c38:	00000f3d 	andeq	r0, r0, sp, lsr pc
     c3c:	0005fa01 	andeq	pc, r5, r1, lsl #20
     c40:	00061900 	andeq	r1, r6, r0, lsl #18
     c44:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
     c48:	a9140000 	ldmdbge	r4, {}	; <UNPREDICTABLE>
     c4c:	14000000 	strne	r0, [r0], #-0
     c50:	0000004d 	andeq	r0, r0, sp, asr #32
     c54:	00004d14 	andeq	r4, r0, r4, lsl sp
     c58:	004d1400 	subeq	r1, sp, r0, lsl #8
     c5c:	a6140000 	ldrge	r0, [r4], -r0
     c60:	00000006 	andeq	r0, r0, r6
     c64:	000de618 	andeq	lr, sp, r8, lsl r6
     c68:	0e580600 	cdpeq	6, 5, cr0, cr8, cr0, {0}
     c6c:	000008bd 			; <UNDEFINED> instruction: 0x000008bd
     c70:	00062e01 	andeq	r2, r6, r1, lsl #28
     c74:	00064d00 	andeq	r4, r6, r0, lsl #26
     c78:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
     c7c:	e0140000 	ands	r0, r4, r0
     c80:	14000000 	strne	r0, [r0], #-0
     c84:	0000004d 	andeq	r0, r0, sp, asr #32
     c88:	00004d14 	andeq	r4, r0, r4, lsl sp
     c8c:	004d1400 	subeq	r1, sp, r0, lsl #8
     c90:	a6140000 	ldrge	r0, [r4], -r0
     c94:	00000006 	andeq	r0, r0, r6
     c98:	00085619 	andeq	r5, r8, r9, lsl r6
     c9c:	0e5b0600 	cdpeq	6, 5, cr0, cr11, cr0, {0}
     ca0:	0000087a 	andeq	r0, r0, sl, ror r8
     ca4:	000001f0 	strdeq	r0, [r0], -r0	; <UNPREDICTABLE>
     ca8:	00066201 	andeq	r6, r6, r1, lsl #4
     cac:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
     cb0:	68140000 	ldmdavs	r4, {}	; <UNPREDICTABLE>
     cb4:	14000003 	strne	r0, [r0], #-3
     cb8:	000006ac 	andeq	r0, r0, ip, lsr #13
     cbc:	f1030000 			; <UNDEFINED> instruction: 0xf1030000
     cc0:	0d000003 	stceq	0, cr0, [r0, #-12]
     cc4:	0003f104 	andeq	pc, r3, r4, lsl #2
     cc8:	03e51a00 	mvneq	r1, #0, 20
     ccc:	068b0000 	streq	r0, [fp], r0
     cd0:	06910000 	ldreq	r0, [r1], r0
     cd4:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
     cd8:	00000006 	andeq	r0, r0, r6
     cdc:	0003f11b 	andeq	pc, r3, fp, lsl r1	; <UNPREDICTABLE>
     ce0:	00067e00 	andeq	r7, r6, r0, lsl #28
     ce4:	3f040d00 	svccc	0x00040d00
     ce8:	0d000000 	stceq	0, cr0, [r0, #-0]
     cec:	00067304 	andeq	r7, r6, r4, lsl #6
     cf0:	65041c00 	strvs	r1, [r4, #-3072]	; 0xfffff400
     cf4:	1d000000 	stcne	0, cr0, [r0, #-0]
     cf8:	002c0f04 	eoreq	r0, ip, r4, lsl #30
     cfc:	06be0000 	ldrteq	r0, [lr], r0
     d00:	5e100000 	cdppl	0, 1, cr0, cr0, cr0, {0}
     d04:	09000000 	stmdbeq	r0, {}	; <UNPREDICTABLE>
     d08:	06ae0300 	strteq	r0, [lr], r0, lsl #6
     d0c:	421e0000 	andsmi	r0, lr, #0
     d10:	0100000a 	tsteq	r0, sl
     d14:	06be0ca3 	ldrteq	r0, [lr], r3, lsr #25
     d18:	03050000 	movweq	r0, #20480	; 0x5000
     d1c:	0000927c 	andeq	r9, r0, ip, ror r2
     d20:	0006991f 	andeq	r9, r6, pc, lsl r9
     d24:	0aa50100 	beq	fe94112c <__bss_end+0xfe937e80>
     d28:	00000b76 	andeq	r0, r0, r6, ror fp
     d2c:	0000004d 	andeq	r0, r0, sp, asr #32
     d30:	00008770 	andeq	r8, r0, r0, ror r7
     d34:	000000b0 	strheq	r0, [r0], -r0	; <UNPREDICTABLE>
     d38:	07339c01 	ldreq	r9, [r3, -r1, lsl #24]!
     d3c:	01200000 			; <UNDEFINED> instruction: 0x01200000
     d40:	01000010 	tsteq	r0, r0, lsl r0
     d44:	01f71ba5 	mvnseq	r1, r5, lsr #23
     d48:	91030000 	mrsls	r0, (UNDEF: 3)
     d4c:	dc207fac 	stcle	15, cr7, [r0], #-688	; 0xfffffd50
     d50:	0100000b 	tsteq	r0, fp
     d54:	004d2aa5 	subeq	r2, sp, r5, lsr #21
     d58:	91030000 	mrsls	r0, (UNDEF: 3)
     d5c:	0e1e7fa8 	cdpeq	15, 1, cr7, cr14, cr8, {5}
     d60:	0100000b 	tsteq	r0, fp
     d64:	07330aa7 	ldreq	r0, [r3, -r7, lsr #21]!
     d68:	91030000 	mrsls	r0, (UNDEF: 3)
     d6c:	751e7fb4 	ldrvc	r7, [lr, #-4020]	; 0xfffff04c
     d70:	01000007 	tsteq	r0, r7
     d74:	003809ab 	eorseq	r0, r8, fp, lsr #19
     d78:	91020000 	mrsls	r0, (UNDEF: 2)
     d7c:	250f0074 	strcs	r0, [pc, #-116]	; d10 <shift+0xd10>
     d80:	43000000 	movwmi	r0, #0
     d84:	10000007 	andne	r0, r0, r7
     d88:	0000005e 	andeq	r0, r0, lr, asr r0
     d8c:	c121003f 			; <UNDEFINED> instruction: 0xc121003f
     d90:	0100000b 	tsteq	r0, fp
     d94:	0cfc0a97 	vldmiaeq	ip!, {s1-s151}
     d98:	004d0000 	subeq	r0, sp, r0
     d9c:	87340000 	ldrhi	r0, [r4, -r0]!
     da0:	003c0000 	eorseq	r0, ip, r0
     da4:	9c010000 	stcls	0, cr0, [r1], {-0}
     da8:	00000780 	andeq	r0, r0, r0, lsl #15
     dac:	71657222 	cmnvc	r5, r2, lsr #4
     db0:	20990100 	addscs	r0, r9, r0, lsl #2
     db4:	000003ab 	andeq	r0, r0, fp, lsr #7
     db8:	1e749102 	expnes	f1, f2
     dbc:	00000b5d 	andeq	r0, r0, sp, asr fp
     dc0:	4d0e9a01 	vstrmi	s18, [lr, #-4]
     dc4:	02000000 	andeq	r0, r0, #0
     dc8:	23007091 	movwcs	r7, #145	; 0x91
     dcc:	00000bfb 	strdeq	r0, [r0], -fp
     dd0:	28068e01 	stmdacs	r6, {r0, r9, sl, fp, pc}
     dd4:	f8000008 			; <UNDEFINED> instruction: 0xf8000008
     dd8:	3c000086 	stccc	0, cr0, [r0], {134}	; 0x86
     ddc:	01000000 	mrseq	r0, (UNDEF: 0)
     de0:	0007b99c 	muleq	r7, ip, r9
     de4:	09fc2000 	ldmibeq	ip!, {sp}^
     de8:	8e010000 	cdphi	0, 0, cr0, cr1, cr0, {0}
     dec:	00004d21 	andeq	r4, r0, r1, lsr #26
     df0:	6c910200 	lfmvs	f0, 4, [r1], {0}
     df4:	71657222 	cmnvc	r5, r2, lsr #4
     df8:	20900100 	addscs	r0, r0, r0, lsl #2
     dfc:	000003ab 	andeq	r0, r0, fp, lsr #7
     e00:	00749102 	rsbseq	r9, r4, r2, lsl #2
     e04:	000b9721 	andeq	r9, fp, r1, lsr #14
     e08:	0a820100 	beq	fe081210 <__bss_end+0xfe077f64>
     e0c:	00000a67 	andeq	r0, r0, r7, ror #20
     e10:	0000004d 	andeq	r0, r0, sp, asr #32
     e14:	000086bc 			; <UNDEFINED> instruction: 0x000086bc
     e18:	0000003c 	andeq	r0, r0, ip, lsr r0
     e1c:	07f69c01 	ldrbeq	r9, [r6, r1, lsl #24]!
     e20:	72220000 	eorvc	r0, r2, #0
     e24:	01007165 	tsteq	r0, r5, ror #2
     e28:	03872084 	orreq	r2, r7, #132	; 0x84
     e2c:	91020000 	mrsls	r0, (UNDEF: 2)
     e30:	076e1e74 			; <UNDEFINED> instruction: 0x076e1e74
     e34:	85010000 	strhi	r0, [r1, #-0]
     e38:	00004d0e 	andeq	r4, r0, lr, lsl #26
     e3c:	70910200 	addsvc	r0, r1, r0, lsl #4
     e40:	0fe42100 	svceq	0x00e42100
     e44:	76010000 	strvc	r0, [r1], -r0
     e48:	000a100a 	andeq	r1, sl, sl
     e4c:	00004d00 	andeq	r4, r0, r0, lsl #26
     e50:	00868000 	addeq	r8, r6, r0
     e54:	00003c00 	andeq	r3, r0, r0, lsl #24
     e58:	339c0100 	orrscc	r0, ip, #0, 2
     e5c:	22000008 	andcs	r0, r0, #8
     e60:	00716572 	rsbseq	r6, r1, r2, ror r5
     e64:	87207801 	strhi	r7, [r0, -r1, lsl #16]!
     e68:	02000003 	andeq	r0, r0, #3
     e6c:	6e1e7491 	cfcmpsvs	r7, mvf14, mvf1
     e70:	01000007 	tsteq	r0, r7
     e74:	004d0e79 	subeq	r0, sp, r9, ror lr
     e78:	91020000 	mrsls	r0, (UNDEF: 2)
     e7c:	8e210070 	mcrhi	0, 1, r0, cr1, cr0, {3}
     e80:	0100000a 	tsteq	r0, sl
     e84:	0ce3066a 	stcleq	6, cr0, [r3], #424	; 0x1a8
     e88:	01f00000 	mvnseq	r0, r0
     e8c:	862c0000 	strthi	r0, [ip], -r0
     e90:	00540000 	subseq	r0, r4, r0
     e94:	9c010000 	stcls	0, cr0, [r1], {-0}
     e98:	0000087f 	andeq	r0, r0, pc, ror r8
     e9c:	000b5d20 	andeq	r5, fp, r0, lsr #26
     ea0:	156a0100 	strbne	r0, [sl, #-256]!	; 0xffffff00
     ea4:	0000004d 	andeq	r0, r0, sp, asr #32
     ea8:	206c9102 	rsbcs	r9, ip, r2, lsl #2
     eac:	0000097c 	andeq	r0, r0, ip, ror r9
     eb0:	4d256a01 	vstmdbmi	r5!, {s12}
     eb4:	02000000 	andeq	r0, r0, #0
     eb8:	dc1e6891 	ldcle	8, cr6, [lr], {145}	; 0x91
     ebc:	0100000f 	tsteq	r0, pc
     ec0:	004d0e6c 	subeq	r0, sp, ip, ror #28
     ec4:	91020000 	mrsls	r0, (UNDEF: 2)
     ec8:	3f210074 	svccc	0x00210074
     ecc:	01000008 	tsteq	r0, r8
     ed0:	0d3b125d 	lfmeq	f1, 4, [fp, #-372]!	; 0xfffffe8c
     ed4:	008b0000 	addeq	r0, fp, r0
     ed8:	85dc0000 	ldrbhi	r0, [ip]
     edc:	00500000 	subseq	r0, r0, r0
     ee0:	9c010000 	stcls	0, cr0, [r1], {-0}
     ee4:	000008da 	ldrdeq	r0, [r0], -sl
     ee8:	00055020 	andeq	r5, r5, r0, lsr #32
     eec:	205d0100 	subscs	r0, sp, r0, lsl #2
     ef0:	0000004d 	andeq	r0, r0, sp, asr #32
     ef4:	206c9102 	rsbcs	r9, ip, r2, lsl #2
     ef8:	00000ba0 	andeq	r0, r0, r0, lsr #23
     efc:	4d2f5d01 	stcmi	13, cr5, [pc, #-4]!	; f00 <shift+0xf00>
     f00:	02000000 	andeq	r0, r0, #0
     f04:	7c206891 	stcvc	8, cr6, [r0], #-580	; 0xfffffdbc
     f08:	01000009 	tsteq	r0, r9
     f0c:	004d3f5d 	subeq	r3, sp, sp, asr pc
     f10:	91020000 	mrsls	r0, (UNDEF: 2)
     f14:	0fdc1e64 	svceq	0x00dc1e64
     f18:	5f010000 	svcpl	0x00010000
     f1c:	00008b16 	andeq	r8, r0, r6, lsl fp
     f20:	74910200 	ldrvc	r0, [r1], #512	; 0x200
     f24:	0d842100 	stfeqs	f2, [r4]
     f28:	51010000 	mrspl	r0, (UNDEF: 1)
     f2c:	00084a0a 	andeq	r4, r8, sl, lsl #20
     f30:	00004d00 	andeq	r4, r0, r0, lsl #26
     f34:	00859800 	addeq	r9, r5, r0, lsl #16
     f38:	00004400 	andeq	r4, r0, r0, lsl #8
     f3c:	269c0100 	ldrcs	r0, [ip], r0, lsl #2
     f40:	20000009 	andcs	r0, r0, r9
     f44:	00000550 	andeq	r0, r0, r0, asr r5
     f48:	4d1a5101 	ldfmis	f5, [sl, #-4]
     f4c:	02000000 	andeq	r0, r0, #0
     f50:	a0206c91 	mlage	r0, r1, ip, r6
     f54:	0100000b 	tsteq	r0, fp
     f58:	004d2951 	subeq	r2, sp, r1, asr r9
     f5c:	91020000 	mrsls	r0, (UNDEF: 2)
     f60:	0d6a1e68 	stcleq	14, cr1, [sl, #-416]!	; 0xfffffe60
     f64:	53010000 	movwpl	r0, #4096	; 0x1000
     f68:	00004d0e 	andeq	r4, r0, lr, lsl #26
     f6c:	74910200 	ldrvc	r0, [r1], #512	; 0x200
     f70:	0d642100 	stfeqe	f2, [r4, #-0]
     f74:	44010000 	strmi	r0, [r1], #-0
     f78:	000d460a 	andeq	r4, sp, sl, lsl #12
     f7c:	00004d00 	andeq	r4, r0, r0, lsl #26
     f80:	00854800 	addeq	r4, r5, r0, lsl #16
     f84:	00005000 	andeq	r5, r0, r0
     f88:	819c0100 	orrshi	r0, ip, r0, lsl #2
     f8c:	20000009 	andcs	r0, r0, r9
     f90:	00000550 	andeq	r0, r0, r0, asr r5
     f94:	4d194401 	cfldrsmi	mvf4, [r9, #-4]
     f98:	02000000 	andeq	r0, r0, #0
     f9c:	c8206c91 	stmdagt	r0!, {r0, r4, r7, sl, fp, sp, lr}
     fa0:	0100000a 	tsteq	r0, sl
     fa4:	011d3044 	tsteq	sp, r4, asr #32
     fa8:	91020000 	mrsls	r0, (UNDEF: 2)
     fac:	0bad2068 	bleq	feb49154 <__bss_end+0xfeb3fea8>
     fb0:	44010000 	strmi	r0, [r1], #-0
     fb4:	0006ac41 	andeq	sl, r6, r1, asr #24
     fb8:	64910200 	ldrvs	r0, [r1], #512	; 0x200
     fbc:	000fdc1e 	andeq	sp, pc, lr, lsl ip	; <UNPREDICTABLE>
     fc0:	0e460100 	dvfeqs	f0, f6, f0
     fc4:	0000004d 	andeq	r0, r0, sp, asr #32
     fc8:	00749102 	rsbseq	r9, r4, r2, lsl #2
     fcc:	00074323 	andeq	r4, r7, r3, lsr #6
     fd0:	063e0100 	ldrteq	r0, [lr], -r0, lsl #2
     fd4:	00000ad2 	ldrdeq	r0, [r0], -r2
     fd8:	0000851c 	andeq	r8, r0, ip, lsl r5
     fdc:	0000002c 	andeq	r0, r0, ip, lsr #32
     fe0:	09ab9c01 	stmibeq	fp!, {r0, sl, fp, ip, pc}
     fe4:	50200000 	eorpl	r0, r0, r0
     fe8:	01000005 	tsteq	r0, r5
     fec:	004d153e 	subeq	r1, sp, lr, lsr r5
     ff0:	91020000 	mrsls	r0, (UNDEF: 2)
     ff4:	4d210074 	stcmi	0, cr0, [r1, #-464]!	; 0xfffffe30
     ff8:	0100000b 	tsteq	r0, fp
     ffc:	0bb30a31 	bleq	fecc38c8 <__bss_end+0xfecba61c>
    1000:	004d0000 	subeq	r0, sp, r0
    1004:	84cc0000 	strbhi	r0, [ip], #0
    1008:	00500000 	subseq	r0, r0, r0
    100c:	9c010000 	stcls	0, cr0, [r1], {-0}
    1010:	00000a06 	andeq	r0, r0, r6, lsl #20
    1014:	00055020 	andeq	r5, r5, r0, lsr #32
    1018:	19310100 	ldmdbne	r1!, {r8}
    101c:	0000004d 	andeq	r0, r0, sp, asr #32
    1020:	206c9102 	rsbcs	r9, ip, r2, lsl #2
    1024:	00000da6 	andeq	r0, r0, r6, lsr #27
    1028:	f72b3101 			; <UNDEFINED> instruction: 0xf72b3101
    102c:	02000001 	andeq	r0, r0, #1
    1030:	e0206891 	mla	r0, r1, r8, r6
    1034:	0100000b 	tsteq	r0, fp
    1038:	004d3c31 	subeq	r3, sp, r1, lsr ip
    103c:	91020000 	mrsls	r0, (UNDEF: 2)
    1040:	0d351e64 	ldceq	14, cr1, [r5, #-400]!	; 0xfffffe70
    1044:	33010000 	movwcc	r0, #4096	; 0x1000
    1048:	00004d0e 	andeq	r4, r0, lr, lsl #26
    104c:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    1050:	101c2100 	andsne	r2, ip, r0, lsl #2
    1054:	24010000 	strcs	r0, [r1], #-0
    1058:	000e260a 	andeq	r2, lr, sl, lsl #12
    105c:	00004d00 	andeq	r4, r0, r0, lsl #26
    1060:	00847c00 	addeq	r7, r4, r0, lsl #24
    1064:	00005000 	andeq	r5, r0, r0
    1068:	619c0100 	orrsvs	r0, ip, r0, lsl #2
    106c:	2000000a 	andcs	r0, r0, sl
    1070:	00000550 	andeq	r0, r0, r0, asr r5
    1074:	4d182401 	cfldrsmi	mvf2, [r8, #-4]
    1078:	02000000 	andeq	r0, r0, #0
    107c:	a6206c91 			; <UNDEFINED> instruction: 0xa6206c91
    1080:	0100000d 	tsteq	r0, sp
    1084:	0a672a24 	beq	19cb91c <__bss_end+0x19c2670>
    1088:	91020000 	mrsls	r0, (UNDEF: 2)
    108c:	0be02068 	bleq	ff809234 <__bss_end+0xff7fff88>
    1090:	24010000 	strcs	r0, [r1], #-0
    1094:	00004d3b 	andeq	r4, r0, fp, lsr sp
    1098:	64910200 	ldrvs	r0, [r1], #512	; 0x200
    109c:	0007bb1e 	andeq	fp, r7, lr, lsl fp
    10a0:	0e260100 	sufeqs	f0, f6, f0
    10a4:	0000004d 	andeq	r0, r0, sp, asr #32
    10a8:	00749102 	rsbseq	r9, r4, r2, lsl #2
    10ac:	0025040d 	eoreq	r0, r5, sp, lsl #8
    10b0:	61030000 	mrsvs	r0, (UNDEF: 3)
    10b4:	2100000a 	tstcs	r0, sl
    10b8:	00000b71 	andeq	r0, r0, r1, ror fp
    10bc:	2e0a1901 	vmlacs.f16	s2, s20, s2	; <UNPREDICTABLE>
    10c0:	4d000010 	stcmi	0, cr0, [r0, #-64]	; 0xffffffc0
    10c4:	38000000 	stmdacc	r0, {}	; <UNPREDICTABLE>
    10c8:	44000084 	strmi	r0, [r0], #-132	; 0xffffff7c
    10cc:	01000000 	mrseq	r0, (UNDEF: 0)
    10d0:	000ab89c 	muleq	sl, ip, r8
    10d4:	0ffd2000 	svceq	0x00fd2000
    10d8:	19010000 	stmdbne	r1, {}	; <UNPREDICTABLE>
    10dc:	0001f71b 	andeq	pc, r1, fp, lsl r7	; <UNPREDICTABLE>
    10e0:	6c910200 	lfmvs	f0, 4, [r1], {0}
    10e4:	000d9520 	andeq	r9, sp, r0, lsr #10
    10e8:	35190100 	ldrcc	r0, [r9, #-256]	; 0xffffff00
    10ec:	000001c6 	andeq	r0, r0, r6, asr #3
    10f0:	1e689102 	lgnnee	f1, f2
    10f4:	00000550 	andeq	r0, r0, r0, asr r5
    10f8:	4d0e1b01 	vstrmi	d1, [lr, #-4]
    10fc:	02000000 	andeq	r0, r0, #0
    1100:	24007491 	strcs	r7, [r0], #-1169	; 0xfffffb6f
    1104:	000009f0 	strdeq	r0, [r0], -r0	; <UNPREDICTABLE>
    1108:	d9061401 	stmdble	r6, {r0, sl, ip}
    110c:	1c000007 	stcne	0, cr0, [r0], {7}
    1110:	1c000084 	stcne	0, cr0, [r0], {132}	; 0x84
    1114:	01000000 	mrseq	r0, (UNDEF: 0)
    1118:	0d8b239c 	stceq	3, cr2, [fp, #624]	; 0x270
    111c:	0e010000 	cdpeq	0, 0, cr0, cr1, cr0, {0}
    1120:	000aa606 	andeq	sl, sl, r6, lsl #12
    1124:	0083f000 	addeq	pc, r3, r0
    1128:	00002c00 	andeq	r2, r0, r0, lsl #24
    112c:	f89c0100 			; <UNDEFINED> instruction: 0xf89c0100
    1130:	2000000a 	andcs	r0, r0, sl
    1134:	0000093d 	andeq	r0, r0, sp, lsr r9
    1138:	38140e01 	ldmdacc	r4, {r0, r9, sl, fp}
    113c:	02000000 	andeq	r0, r0, #0
    1140:	25007491 	strcs	r7, [r0, #-1169]	; 0xfffffb6f
    1144:	00001027 	andeq	r1, r0, r7, lsr #32
    1148:	030a0401 	movweq	r0, #41985	; 0xa401
    114c:	4d00000b 	stcmi	0, cr0, [r0, #-44]	; 0xffffffd4
    1150:	c4000000 	strgt	r0, [r0], #-0
    1154:	2c000083 	stccs	0, cr0, [r0], {131}	; 0x83
    1158:	01000000 	mrseq	r0, (UNDEF: 0)
    115c:	6970229c 	ldmdbvs	r0!, {r2, r3, r4, r7, r9, sp}^
    1160:	06010064 	streq	r0, [r1], -r4, rrx
    1164:	00004d0e 	andeq	r4, r0, lr, lsl #26
    1168:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    116c:	047c0000 	ldrbteq	r0, [ip], #-0
    1170:	00040000 	andeq	r0, r4, r0
    1174:	00000579 	andeq	r0, r0, r9, ror r5
    1178:	0e4a0104 	dvfeqe	f0, f2, f4
    117c:	a7040000 	strge	r0, [r4, -r0]
    1180:	c4000011 	strgt	r0, [r0], #-17	; 0xffffffef
    1184:	20000006 	andcs	r0, r0, r6
    1188:	c0000088 	andgt	r0, r0, r8, lsl #1
    118c:	fb000007 	blx	11b2 <shift+0x11b2>
    1190:	02000007 	andeq	r0, r0, #7
    1194:	00000049 	andeq	r0, r0, r9, asr #32
    1198:	00111f03 	andseq	r1, r1, r3, lsl #30
    119c:	10050100 	andne	r0, r5, r0, lsl #2
    11a0:	00000061 	andeq	r0, r0, r1, rrx
    11a4:	32313011 	eorscc	r3, r1, #17
    11a8:	36353433 			; <UNDEFINED> instruction: 0x36353433
    11ac:	41393837 	teqmi	r9, r7, lsr r8
    11b0:	45444342 	strbmi	r4, [r4, #-834]	; 0xfffffcbe
    11b4:	04000046 	streq	r0, [r0], #-70	; 0xffffffba
    11b8:	25010301 	strcs	r0, [r1, #-769]	; 0xfffffcff
    11bc:	05000000 	streq	r0, [r0, #-0]
    11c0:	00000074 	andeq	r0, r0, r4, ror r0
    11c4:	00000061 	andeq	r0, r0, r1, rrx
    11c8:	00006606 	andeq	r6, r0, r6, lsl #12
    11cc:	07001000 	streq	r1, [r0, -r0]
    11d0:	00000051 	andeq	r0, r0, r1, asr r0
    11d4:	3e070408 	cdpcc	4, 0, cr0, cr7, cr8, {0}
    11d8:	08000005 	stmdaeq	r0, {r0, r2}
    11dc:	05210801 	streq	r0, [r1, #-2049]!	; 0xfffff7ff
    11e0:	6d070000 	stcvs	0, cr0, [r7, #-0]
    11e4:	09000000 	stmdbeq	r0, {}	; <UNPREDICTABLE>
    11e8:	0000002a 	andeq	r0, r0, sl, lsr #32
    11ec:	0010a80a 	andseq	sl, r0, sl, lsl #16
    11f0:	06aa0100 	strteq	r0, [sl], r0, lsl #2
    11f4:	00001109 	andeq	r1, r0, r9, lsl #2
    11f8:	00008f6c 	andeq	r8, r0, ip, ror #30
    11fc:	00000074 	andeq	r0, r0, r4, ror r0
    1200:	00d19c01 	sbcseq	r9, r1, r1, lsl #24
    1204:	af0b0000 	svcge	0x000b0000
    1208:	01000010 	tsteq	r0, r0, lsl r0
    120c:	00d113aa 	sbcseq	r1, r1, sl, lsr #7
    1210:	91020000 	mrsls	r0, (UNDEF: 2)
    1214:	72730c6c 	rsbsvc	r0, r3, #108, 24	; 0x6c00
    1218:	aa010063 	bge	413ac <__bss_end+0x38100>
    121c:	0000d725 	andeq	sp, r0, r5, lsr #14
    1220:	68910200 	ldmvs	r1, {r9}
    1224:	0100690d 	tsteq	r0, sp, lsl #18
    1228:	00dd06ab 	sbcseq	r0, sp, fp, lsr #13
    122c:	91020000 	mrsls	r0, (UNDEF: 2)
    1230:	006a0d74 	rsbeq	r0, sl, r4, ror sp
    1234:	dd06ac01 	stcle	12, cr10, [r6, #-4]
    1238:	02000000 	andeq	r0, r0, #0
    123c:	0e007091 	mcreq	0, 0, r7, cr0, cr1, {4}
    1240:	00006d04 	andeq	r6, r0, r4, lsl #26
    1244:	74040e00 	strvc	r0, [r4], #-3584	; 0xfffff200
    1248:	0f000000 	svceq	0x00000000
    124c:	6e690504 	cdpvs	5, 6, cr0, cr9, cr4, {0}
    1250:	3d100074 	ldccc	0, cr0, [r0, #-464]	; 0xfffffe30
    1254:	01000011 	tsteq	r0, r1, lsl r0
    1258:	107a06a1 	rsbsne	r0, sl, r1, lsr #13
    125c:	8eec0000 	cdphi	0, 14, cr0, cr12, cr0, {0}
    1260:	00800000 	addeq	r0, r0, r0
    1264:	9c010000 	stcls	0, cr0, [r1], {-0}
    1268:	00000161 	andeq	r0, r0, r1, ror #2
    126c:	6372730c 	cmnvs	r2, #12, 6	; 0x30000000
    1270:	19a10100 	stmibne	r1!, {r8}
    1274:	00000161 	andeq	r0, r0, r1, ror #2
    1278:	0c649102 	stfeqp	f1, [r4], #-8
    127c:	00747364 	rsbseq	r7, r4, r4, ror #6
    1280:	6824a101 	stmdavs	r4!, {r0, r8, sp, pc}
    1284:	02000001 	andeq	r0, r0, #1
    1288:	6e0c6091 	mcrvs	0, 0, r6, cr12, cr1, {4}
    128c:	01006d75 	tsteq	r0, r5, ror sp
    1290:	00dd2da1 	sbcseq	r2, sp, r1, lsr #27
    1294:	91020000 	mrsls	r0, (UNDEF: 2)
    1298:	1130115c 	teqne	r0, ip, asr r1
    129c:	a3010000 	movwge	r0, #4096	; 0x1000
    12a0:	0000d70e 	andeq	sp, r0, lr, lsl #14
    12a4:	70910200 	addsvc	r0, r1, r0, lsl #4
    12a8:	00111811 	andseq	r1, r1, r1, lsl r8
    12ac:	08a40100 	stmiaeq	r4!, {r8}
    12b0:	000000d1 	ldrdeq	r0, [r0], -r1
    12b4:	126c9102 	rsbne	r9, ip, #-2147483648	; 0x80000000
    12b8:	00008f14 	andeq	r8, r0, r4, lsl pc
    12bc:	00000048 	andeq	r0, r0, r8, asr #32
    12c0:	0100690d 	tsteq	r0, sp, lsl #18
    12c4:	00dd0ba6 	sbcseq	r0, sp, r6, lsr #23
    12c8:	91020000 	mrsls	r0, (UNDEF: 2)
    12cc:	0e000074 	mcreq	0, 0, r0, cr0, cr4, {3}
    12d0:	00016704 	andeq	r6, r1, r4, lsl #14
    12d4:	04141300 	ldreq	r1, [r4], #-768	; 0xfffffd00
    12d8:	00113710 	andseq	r3, r1, r0, lsl r7
    12dc:	06990100 	ldreq	r0, [r9], r0, lsl #2
    12e0:	000010cc 	andeq	r1, r0, ip, asr #1
    12e4:	00008e84 	andeq	r8, r0, r4, lsl #29
    12e8:	00000068 	andeq	r0, r0, r8, rrx
    12ec:	01c99c01 	biceq	r9, r9, r1, lsl #24
    12f0:	a00b0000 	andge	r0, fp, r0
    12f4:	01000011 	tsteq	r0, r1, lsl r0
    12f8:	01681299 			; <UNDEFINED> instruction: 0x01681299
    12fc:	91020000 	mrsls	r0, (UNDEF: 2)
    1300:	06000b6c 	streq	r0, [r0], -ip, ror #22
    1304:	99010000 	stmdbls	r1, {}	; <UNPREDICTABLE>
    1308:	0000dd1e 	andeq	sp, r0, lr, lsl sp
    130c:	68910200 	ldmvs	r1, {r9}
    1310:	6d656d0d 	stclvs	13, cr6, [r5, #-52]!	; 0xffffffcc
    1314:	089b0100 	ldmeq	fp, {r8}
    1318:	000000d1 	ldrdeq	r0, [r0], -r1
    131c:	12709102 	rsbsne	r9, r0, #-2147483648	; 0x80000000
    1320:	00008ea0 	andeq	r8, r0, r0, lsr #29
    1324:	0000003c 	andeq	r0, r0, ip, lsr r0
    1328:	0100690d 	tsteq	r0, sp, lsl #18
    132c:	00dd0b9d 	smullseq	r0, sp, sp, fp
    1330:	91020000 	mrsls	r0, (UNDEF: 2)
    1334:	15000074 	strne	r0, [r0, #-116]	; 0xffffff8c
    1338:	000010a1 	andeq	r1, r0, r1, lsr #1
    133c:	79058f01 	stmdbvc	r5, {r0, r8, r9, sl, fp, pc}
    1340:	dd000011 	stcle	0, cr0, [r0, #-68]	; 0xffffffbc
    1344:	30000000 	andcc	r0, r0, r0
    1348:	5400008e 	strpl	r0, [r0], #-142	; 0xffffff72
    134c:	01000000 	mrseq	r0, (UNDEF: 0)
    1350:	0002029c 	muleq	r2, ip, r2
    1354:	00730c00 	rsbseq	r0, r3, r0, lsl #24
    1358:	d7188f01 	ldrle	r8, [r8, -r1, lsl #30]
    135c:	02000000 	andeq	r0, r0, #0
    1360:	690d6c91 	stmdbvs	sp, {r0, r4, r7, sl, fp, sp, lr}
    1364:	06910100 	ldreq	r0, [r1], r0, lsl #2
    1368:	000000dd 	ldrdeq	r0, [r0], -sp
    136c:	00749102 	rsbseq	r9, r4, r2, lsl #2
    1370:	00114415 	andseq	r4, r1, r5, lsl r4
    1374:	057f0100 	ldrbeq	r0, [pc, #-256]!	; 127c <shift+0x127c>
    1378:	00001186 	andeq	r1, r0, r6, lsl #3
    137c:	000000dd 	ldrdeq	r0, [r0], -sp
    1380:	00008d84 	andeq	r8, r0, r4, lsl #27
    1384:	000000ac 	andeq	r0, r0, ip, lsr #1
    1388:	02689c01 	rsbeq	r9, r8, #256	; 0x100
    138c:	730c0000 	movwvc	r0, #49152	; 0xc000
    1390:	7f010031 	svcvc	0x00010031
    1394:	0000d719 	andeq	sp, r0, r9, lsl r7
    1398:	6c910200 	lfmvs	f0, 4, [r1], {0}
    139c:	0032730c 	eorseq	r7, r2, ip, lsl #6
    13a0:	d7297f01 	strle	r7, [r9, -r1, lsl #30]!
    13a4:	02000000 	andeq	r0, r0, #0
    13a8:	6e0c6891 	mcrvs	8, 0, r6, cr12, cr1, {4}
    13ac:	01006d75 	tsteq	r0, r5, ror sp
    13b0:	00dd317f 	sbcseq	r3, sp, pc, ror r1
    13b4:	91020000 	mrsls	r0, (UNDEF: 2)
    13b8:	31750d64 	cmncc	r5, r4, ror #26
    13bc:	10810100 	addne	r0, r1, r0, lsl #2
    13c0:	00000268 	andeq	r0, r0, r8, ror #4
    13c4:	0d779102 	ldfeqp	f1, [r7, #-8]!
    13c8:	01003275 	tsteq	r0, r5, ror r2
    13cc:	02681481 	rsbeq	r1, r8, #-2130706432	; 0x81000000
    13d0:	91020000 	mrsls	r0, (UNDEF: 2)
    13d4:	01080076 	tsteq	r8, r6, ror r0
    13d8:	00051808 	andeq	r1, r5, r8, lsl #16
    13dc:	10d81500 	sbcsne	r1, r8, r0, lsl #10
    13e0:	73010000 	movwvc	r0, #4096	; 0x1000
    13e4:	0010e007 	andseq	lr, r0, r7
    13e8:	0000d100 	andeq	sp, r0, r0, lsl #2
    13ec:	008cc400 	addeq	ip, ip, r0, lsl #8
    13f0:	0000c000 	andeq	ip, r0, r0
    13f4:	c89c0100 	ldmgt	ip, {r8}
    13f8:	0b000002 	bleq	1408 <shift+0x1408>
    13fc:	000010af 	andeq	r1, r0, pc, lsr #1
    1400:	d1157301 	tstle	r5, r1, lsl #6
    1404:	02000000 	andeq	r0, r0, #0
    1408:	730c6c91 	movwvc	r6, #52369	; 0xcc91
    140c:	01006372 	tsteq	r0, r2, ror r3
    1410:	00d72773 	sbcseq	r2, r7, r3, ror r7
    1414:	91020000 	mrsls	r0, (UNDEF: 2)
    1418:	756e0c68 	strbvc	r0, [lr, #-3176]!	; 0xfffff398
    141c:	7301006d 	movwvc	r0, #4205	; 0x106d
    1420:	0000dd30 	andeq	sp, r0, r0, lsr sp
    1424:	64910200 	ldrvs	r0, [r1], #512	; 0x200
    1428:	0100690d 	tsteq	r0, sp, lsl #18
    142c:	00dd0675 	sbcseq	r0, sp, r5, ror r6
    1430:	91020000 	mrsls	r0, (UNDEF: 2)
    1434:	2b150074 	blcs	54160c <__bss_end+0x538360>
    1438:	01000011 	tsteq	r0, r1, lsl r0
    143c:	116d0736 	cmnne	sp, r6, lsr r7
    1440:	00d10000 	sbcseq	r0, r1, r0
    1444:	8a300000 	bhi	c0144c <__bss_end+0xbf81a0>
    1448:	02940000 	addseq	r0, r4, #0
    144c:	9c010000 	stcls	0, cr0, [r1], {-0}
    1450:	000003ac 	andeq	r0, r0, ip, lsr #7
    1454:	0010b40b 	andseq	fp, r0, fp, lsl #8
    1458:	12360100 	eorsne	r0, r6, #0, 2
    145c:	000003ac 	andeq	r0, r0, ip, lsr #7
    1460:	0b4c9102 	bleq	1325870 <__bss_end+0x131c5c4>
    1464:	00001166 	andeq	r1, r0, r6, ror #2
    1468:	d11f3601 	tstle	pc, r1, lsl #12
    146c:	02000000 	andeq	r0, r0, #0
    1470:	4c0b4891 	stcmi	8, cr4, [fp], {145}	; 0x91
    1474:	01000011 	tsteq	r0, r1, lsl r0
    1478:	00663436 	rsbeq	r3, r6, r6, lsr r4
    147c:	91020000 	mrsls	r0, (UNDEF: 2)
    1480:	74700d44 	ldrbtvc	r0, [r0], #-3396	; 0xfffff2bc
    1484:	38010072 	stmdacc	r1, {r1, r4, r5, r6}
    1488:	0000d108 	andeq	sp, r0, r8, lsl #2
    148c:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    1490:	0010f111 	andseq	pc, r0, r1, lsl r1	; <UNPREDICTABLE>
    1494:	09410100 	stmdbeq	r1, {r8}^
    1498:	000000dd 	ldrdeq	r0, [r0], -sp
    149c:	11709102 	cmnne	r0, r2, lsl #2
    14a0:	000010fa 	strdeq	r1, [r0], -sl
    14a4:	ac0b4201 	sfmge	f4, 4, [fp], {1}
    14a8:	02000003 	andeq	r0, r0, #3
    14ac:	98116c91 	ldmdals	r1, {r0, r4, r7, sl, fp, sp, lr}
    14b0:	01000011 	tsteq	r0, r1, lsl r0
    14b4:	03b30a45 			; <UNDEFINED> instruction: 0x03b30a45
    14b8:	91020000 	mrsls	r0, (UNDEF: 2)
    14bc:	10c41150 	sbcne	r1, r4, r0, asr r1
    14c0:	46010000 	strmi	r0, [r1], -r0
    14c4:	0000d10b 	andeq	sp, r0, fp, lsl #2
    14c8:	68910200 	ldmvs	r1, {r9}
    14cc:	008ba016 	addeq	sl, fp, r6, lsl r0
    14d0:	00008000 	andeq	r8, r0, r0
    14d4:	00039200 	andeq	r9, r3, r0, lsl #4
    14d8:	00690d00 	rsbeq	r0, r9, r0, lsl #26
    14dc:	dd0e5b01 	vstrle	d5, [lr, #-4]
    14e0:	02000000 	andeq	r0, r0, #0
    14e4:	b8126491 	ldmdalt	r2, {r0, r4, r7, sl, sp, lr}
    14e8:	5800008b 	stmdapl	r0, {r0, r1, r3, r7}
    14ec:	11000000 	mrsne	r0, (UNDEF: 0)
    14f0:	00001103 	andeq	r1, r0, r3, lsl #2
    14f4:	dd0d5d01 	stcle	13, cr5, [sp, #-4]
    14f8:	02000000 	andeq	r0, r0, #0
    14fc:	00005c91 	muleq	r0, r1, ip
    1500:	008c3812 	addeq	r3, ip, r2, lsl r8
    1504:	00007000 	andeq	r7, r0, r0
    1508:	6e650d00 	cdpvs	13, 6, cr0, cr5, cr0, {0}
    150c:	67010064 	strvs	r0, [r1, -r4, rrx]
    1510:	0000d10f 	andeq	sp, r0, pc, lsl #2
    1514:	60910200 	addsvs	r0, r1, r0, lsl #4
    1518:	04080000 	streq	r0, [r8], #-0
    151c:	00108a04 	andseq	r8, r0, r4, lsl #20
    1520:	006d0500 	rsbeq	r0, sp, r0, lsl #10
    1524:	03c30000 	biceq	r0, r3, #0
    1528:	66060000 	strvs	r0, [r6], -r0
    152c:	0b000000 	bleq	1534 <shift+0x1534>
    1530:	109c1500 	addsne	r1, ip, r0, lsl #10
    1534:	24010000 	strcs	r0, [r1], #-0
    1538:	00115b05 	andseq	r5, r1, r5, lsl #22
    153c:	0000dd00 	andeq	sp, r0, r0, lsl #26
    1540:	00899400 	addeq	r9, r9, r0, lsl #8
    1544:	00009c00 	andeq	r9, r0, r0, lsl #24
    1548:	009c0100 	addseq	r0, ip, r0, lsl #2
    154c:	0b000004 	bleq	1564 <shift+0x1564>
    1550:	000010b4 	strheq	r1, [r0], -r4
    1554:	d7162401 	ldrle	r2, [r6, -r1, lsl #8]
    1558:	02000000 	andeq	r0, r0, #0
    155c:	66116c91 			; <UNDEFINED> instruction: 0x66116c91
    1560:	01000011 	tsteq	r0, r1, lsl r0
    1564:	00dd0626 	sbcseq	r0, sp, r6, lsr #12
    1568:	91020000 	mrsls	r0, (UNDEF: 2)
    156c:	bf170074 	svclt	0x00170074
    1570:	01000010 	tsteq	r0, r0, lsl r0
    1574:	10900608 	addsne	r0, r0, r8, lsl #12
    1578:	88200000 	stmdahi	r0!, {}	; <UNPREDICTABLE>
    157c:	01740000 	cmneq	r4, r0
    1580:	9c010000 	stcls	0, cr0, [r1], {-0}
    1584:	0010b40b 	andseq	fp, r0, fp, lsl #8
    1588:	18080100 	stmdane	r8, {r8}
    158c:	00000066 	andeq	r0, r0, r6, rrx
    1590:	0b649102 	bleq	19259a0 <__bss_end+0x191c6f4>
    1594:	00001166 	andeq	r1, r0, r6, ror #2
    1598:	d1250801 			; <UNDEFINED> instruction: 0xd1250801
    159c:	02000000 	andeq	r0, r0, #0
    15a0:	ba0b6091 	blt	2d97ec <__bss_end+0x2d0540>
    15a4:	01000010 	tsteq	r0, r0, lsl r0
    15a8:	00663a08 	rsbeq	r3, r6, r8, lsl #20
    15ac:	91020000 	mrsls	r0, (UNDEF: 2)
    15b0:	00690d5c 	rsbeq	r0, r9, ip, asr sp
    15b4:	dd060a01 	vstrle	s0, [r6, #-4]
    15b8:	02000000 	andeq	r0, r0, #0
    15bc:	ec127491 	cfldrs	mvf7, [r2], {145}	; 0x91
    15c0:	98000088 	stmdals	r0, {r3, r7}
    15c4:	0d000000 	stceq	0, cr0, [r0, #-0]
    15c8:	1c01006a 	stcne	0, cr0, [r1], {106}	; 0x6a
    15cc:	0000dd0b 	andeq	sp, r0, fp, lsl #26
    15d0:	70910200 	addsvc	r0, r1, r0, lsl #4
    15d4:	00891412 	addeq	r1, r9, r2, lsl r4
    15d8:	00006000 	andeq	r6, r0, r0
    15dc:	00630d00 	rsbeq	r0, r3, r0, lsl #26
    15e0:	6d081e01 	stcvs	14, cr1, [r8, #-4]
    15e4:	02000000 	andeq	r0, r0, #0
    15e8:	00006f91 	muleq	r0, r1, pc	; <UNPREDICTABLE>
	...

Disassembly of section .debug_abbrev:

00000000 <.debug_abbrev>:
   0:	10001101 	andne	r1, r0, r1, lsl #2
   4:	12011106 	andne	r1, r1, #-2147483647	; 0x80000001
   8:	1b0e0301 	blne	380c14 <__bss_end+0x377968>
   c:	130e250e 	movwne	r2, #58638	; 0xe50e
  10:	00000005 	andeq	r0, r0, r5
  14:	25011101 	strcs	r1, [r1, #-257]	; 0xfffffeff
  18:	030b130e 	movweq	r1, #45838	; 0xb30e
  1c:	110e1b0e 	tstne	lr, lr, lsl #22
  20:	10061201 	andne	r1, r6, r1, lsl #4
  24:	02000017 	andeq	r0, r0, #23
  28:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
  2c:	0b3b0b3a 	bleq	ec2d1c <__bss_end+0xeb9a70>
  30:	13490b39 	movtne	r0, #39737	; 0x9b39
  34:	193c193f 	ldmdbne	ip!, {r0, r1, r2, r3, r4, r5, r8, fp, ip}
  38:	24030000 	strcs	r0, [r3], #-0
  3c:	3e0b0b00 	vmlacc.f64	d0, d11, d0
  40:	000e030b 	andeq	r0, lr, fp, lsl #6
  44:	012e0400 			; <UNDEFINED> instruction: 0x012e0400
  48:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
  4c:	0b3b0b3a 	bleq	ec2d3c <__bss_end+0xeb9a90>
  50:	01110b39 	tsteq	r1, r9, lsr fp
  54:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
  58:	01194296 			; <UNDEFINED> instruction: 0x01194296
  5c:	05000013 	streq	r0, [r0, #-19]	; 0xffffffed
  60:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
  64:	0b3b0b3a 	bleq	ec2d54 <__bss_end+0xeb9aa8>
  68:	13490b39 	movtne	r0, #39737	; 0x9b39
  6c:	00001802 	andeq	r1, r0, r2, lsl #16
  70:	0b002406 	bleq	9090 <__udivsi3+0xb0>
  74:	030b3e0b 	movweq	r3, #48651	; 0xbe0b
  78:	07000008 	streq	r0, [r0, -r8]
  7c:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
  80:	0b3a0e03 	bleq	e83894 <__bss_end+0xe7a5e8>
  84:	0b390b3b 	bleq	e42d78 <__bss_end+0xe39acc>
  88:	06120111 			; <UNDEFINED> instruction: 0x06120111
  8c:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
  90:	00130119 	andseq	r0, r3, r9, lsl r1
  94:	010b0800 	tsteq	fp, r0, lsl #16
  98:	06120111 			; <UNDEFINED> instruction: 0x06120111
  9c:	34090000 	strcc	r0, [r9], #-0
  a0:	3a080300 	bcc	200ca8 <__bss_end+0x1f79fc>
  a4:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
  a8:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
  ac:	0a000018 	beq	114 <shift+0x114>
  b0:	0b0b000f 	bleq	2c00f4 <__bss_end+0x2b6e48>
  b4:	00001349 	andeq	r1, r0, r9, asr #6
  b8:	01110100 	tsteq	r1, r0, lsl #2
  bc:	0b130e25 	bleq	4c3958 <__bss_end+0x4ba6ac>
  c0:	0e1b0e03 	cdpeq	14, 1, cr0, cr11, cr3, {0}
  c4:	06120111 			; <UNDEFINED> instruction: 0x06120111
  c8:	00001710 	andeq	r1, r0, r0, lsl r7
  cc:	03001602 	movweq	r1, #1538	; 0x602
  d0:	3b0b3a0e 	blcc	2ce910 <__bss_end+0x2c5664>
  d4:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
  d8:	03000013 	movweq	r0, #19
  dc:	0b0b000f 	bleq	2c0120 <__bss_end+0x2b6e74>
  e0:	00001349 	andeq	r1, r0, r9, asr #6
  e4:	00001504 	andeq	r1, r0, r4, lsl #10
  e8:	01010500 	tsteq	r1, r0, lsl #10
  ec:	13011349 	movwne	r1, #4937	; 0x1349
  f0:	21060000 	mrscs	r0, (UNDEF: 6)
  f4:	2f134900 	svccs	0x00134900
  f8:	07000006 	streq	r0, [r0, -r6]
  fc:	0b0b0024 	bleq	2c0194 <__bss_end+0x2b6ee8>
 100:	0e030b3e 	vmoveq.16	d3[0], r0
 104:	34080000 	strcc	r0, [r8], #-0
 108:	3a0e0300 	bcc	380d10 <__bss_end+0x377a64>
 10c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 110:	3f13490b 	svccc	0x0013490b
 114:	00193c19 	andseq	r3, r9, r9, lsl ip
 118:	012e0900 			; <UNDEFINED> instruction: 0x012e0900
 11c:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 120:	0b3b0b3a 	bleq	ec2e10 <__bss_end+0xeb9b64>
 124:	13490b39 	movtne	r0, #39737	; 0x9b39
 128:	06120111 			; <UNDEFINED> instruction: 0x06120111
 12c:	42961840 	addsmi	r1, r6, #64, 16	; 0x400000
 130:	00130119 	andseq	r0, r3, r9, lsl r1
 134:	00340a00 	eorseq	r0, r4, r0, lsl #20
 138:	0b3a0e03 	bleq	e8394c <__bss_end+0xe7a6a0>
 13c:	0b390b3b 	bleq	e42e30 <__bss_end+0xe39b84>
 140:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 144:	240b0000 	strcs	r0, [fp], #-0
 148:	3e0b0b00 	vmlacc.f64	d0, d11, d0
 14c:	0008030b 	andeq	r0, r8, fp, lsl #6
 150:	002e0c00 	eoreq	r0, lr, r0, lsl #24
 154:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 158:	0b3b0b3a 	bleq	ec2e48 <__bss_end+0xeb9b9c>
 15c:	01110b39 	tsteq	r1, r9, lsr fp
 160:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 164:	00194297 	mulseq	r9, r7, r2
 168:	01390d00 	teqeq	r9, r0, lsl #26
 16c:	0b3a0e03 	bleq	e83980 <__bss_end+0xe7a6d4>
 170:	13010b3b 	movwne	r0, #6971	; 0x1b3b
 174:	2e0e0000 	cdpcs	0, 0, cr0, cr14, cr0, {0}
 178:	03193f01 	tsteq	r9, #1, 30
 17c:	3b0b3a0e 	blcc	2ce9bc <__bss_end+0x2c5710>
 180:	3c0b390b 			; <UNDEFINED> instruction: 0x3c0b390b
 184:	00130119 	andseq	r0, r3, r9, lsl r1
 188:	00050f00 	andeq	r0, r5, r0, lsl #30
 18c:	00001349 	andeq	r1, r0, r9, asr #6
 190:	3f012e10 	svccc	0x00012e10
 194:	3a0e0319 	bcc	380e00 <__bss_end+0x377b54>
 198:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 19c:	3c13490b 			; <UNDEFINED> instruction: 0x3c13490b
 1a0:	11000019 	tstne	r0, r9, lsl r0
 1a4:	1347012e 	movtne	r0, #28974	; 0x712e
 1a8:	06120111 			; <UNDEFINED> instruction: 0x06120111
 1ac:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
 1b0:	00130119 	andseq	r0, r3, r9, lsl r1
 1b4:	00051200 	andeq	r1, r5, r0, lsl #4
 1b8:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 1bc:	05130000 	ldreq	r0, [r3, #-0]
 1c0:	3a080300 	bcc	200dc8 <__bss_end+0x1f7b1c>
 1c4:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 1c8:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 1cc:	14000018 	strne	r0, [r0], #-24	; 0xffffffe8
 1d0:	1347012e 	movtne	r0, #28974	; 0x712e
 1d4:	06120111 			; <UNDEFINED> instruction: 0x06120111
 1d8:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
 1dc:	00000019 	andeq	r0, r0, r9, lsl r0
 1e0:	25011101 	strcs	r1, [r1, #-257]	; 0xfffffeff
 1e4:	030b130e 	movweq	r1, #45838	; 0xb30e
 1e8:	110e1b0e 	tstne	lr, lr, lsl #22
 1ec:	10061201 	andne	r1, r6, r1, lsl #4
 1f0:	02000017 	andeq	r0, r0, #23
 1f4:	0b0b0024 	bleq	2c028c <__bss_end+0x2b6fe0>
 1f8:	0e030b3e 	vmoveq.16	d3[0], r0
 1fc:	26030000 	strcs	r0, [r3], -r0
 200:	00134900 	andseq	r4, r3, r0, lsl #18
 204:	00240400 	eoreq	r0, r4, r0, lsl #8
 208:	0b3e0b0b 	bleq	f82e3c <__bss_end+0xf79b90>
 20c:	00000803 	andeq	r0, r0, r3, lsl #16
 210:	03001605 	movweq	r1, #1541	; 0x605
 214:	3b0b3a0e 	blcc	2cea54 <__bss_end+0x2c57a8>
 218:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 21c:	06000013 			; <UNDEFINED> instruction: 0x06000013
 220:	0e030104 	adfeqs	f0, f3, f4
 224:	0b3e196d 	bleq	f867e0 <__bss_end+0xf7d534>
 228:	13490b0b 	movtne	r0, #39691	; 0x9b0b
 22c:	0b3b0b3a 	bleq	ec2f1c <__bss_end+0xeb9c70>
 230:	13010b39 	movwne	r0, #6969	; 0x1b39
 234:	28070000 	stmdacs	r7, {}	; <UNPREDICTABLE>
 238:	1c0e0300 	stcne	3, cr0, [lr], {-0}
 23c:	0800000b 	stmdaeq	r0, {r0, r1, r3}
 240:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 244:	0b3b0b3a 	bleq	ec2f34 <__bss_end+0xeb9c88>
 248:	13490b39 	movtne	r0, #39737	; 0x9b39
 24c:	1802196c 	stmdane	r2, {r2, r3, r5, r6, r8, fp, ip}
 250:	01090000 	mrseq	r0, (UNDEF: 9)
 254:	01134901 	tsteq	r3, r1, lsl #18
 258:	0a000013 	beq	2ac <shift+0x2ac>
 25c:	13490021 	movtne	r0, #36897	; 0x9021
 260:	00000b2f 	andeq	r0, r0, pc, lsr #22
 264:	0b000f0b 	bleq	3e98 <shift+0x3e98>
 268:	0013490b 	andseq	r4, r3, fp, lsl #18
 26c:	00280c00 	eoreq	r0, r8, r0, lsl #24
 270:	051c0e03 	ldreq	r0, [ip, #-3587]	; 0xfffff1fd
 274:	280d0000 	stmdacs	sp, {}	; <UNPREDICTABLE>
 278:	1c0e0300 	stcne	3, cr0, [lr], {-0}
 27c:	0e000006 	cdpeq	0, 0, cr0, cr0, cr6, {0}
 280:	0e030113 	mcreq	1, 0, r0, cr3, cr3, {0}
 284:	0b3a0b0b 	bleq	e82eb8 <__bss_end+0xe79c0c>
 288:	0b390b3b 	bleq	e42f7c <__bss_end+0xe39cd0>
 28c:	00001301 	andeq	r1, r0, r1, lsl #6
 290:	03000d0f 	movweq	r0, #3343	; 0xd0f
 294:	3b0b3a0e 	blcc	2cead4 <__bss_end+0x2c5828>
 298:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 29c:	000b3813 	andeq	r3, fp, r3, lsl r8
 2a0:	012e1000 			; <UNDEFINED> instruction: 0x012e1000
 2a4:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 2a8:	0b3b0b3a 	bleq	ec2f98 <__bss_end+0xeb9cec>
 2ac:	13490b39 	movtne	r0, #39737	; 0x9b39
 2b0:	06120111 			; <UNDEFINED> instruction: 0x06120111
 2b4:	42961840 	addsmi	r1, r6, #64, 16	; 0x400000
 2b8:	00130119 	andseq	r0, r3, r9, lsl r1
 2bc:	00051100 	andeq	r1, r5, r0, lsl #2
 2c0:	0b3a0e03 	bleq	e83ad4 <__bss_end+0xe7a828>
 2c4:	0b390b3b 	bleq	e42fb8 <__bss_end+0xe39d0c>
 2c8:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 2cc:	34120000 	ldrcc	r0, [r2], #-0
 2d0:	3a0e0300 	bcc	380ed8 <__bss_end+0x377c2c>
 2d4:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 2d8:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 2dc:	13000018 	movwne	r0, #24
 2e0:	08030034 	stmdaeq	r3, {r2, r4, r5}
 2e4:	0b3b0b3a 	bleq	ec2fd4 <__bss_end+0xeb9d28>
 2e8:	13490b39 	movtne	r0, #39737	; 0x9b39
 2ec:	00001802 	andeq	r1, r0, r2, lsl #16
 2f0:	11010b14 	tstne	r1, r4, lsl fp
 2f4:	00061201 	andeq	r1, r6, r1, lsl #4
 2f8:	012e1500 			; <UNDEFINED> instruction: 0x012e1500
 2fc:	0b3a0e03 	bleq	e83b10 <__bss_end+0xe7a864>
 300:	0b390b3b 	bleq	e42ff4 <__bss_end+0xe39d48>
 304:	06120111 			; <UNDEFINED> instruction: 0x06120111
 308:	42961840 	addsmi	r1, r6, #64, 16	; 0x400000
 30c:	00000019 	andeq	r0, r0, r9, lsl r0
 310:	25011101 	strcs	r1, [r1, #-257]	; 0xfffffeff
 314:	030b130e 	movweq	r1, #45838	; 0xb30e
 318:	110e1b0e 	tstne	lr, lr, lsl #22
 31c:	10061201 	andne	r1, r6, r1, lsl #4
 320:	02000017 	andeq	r0, r0, #23
 324:	0b0b0024 	bleq	2c03bc <__bss_end+0x2b7110>
 328:	0e030b3e 	vmoveq.16	d3[0], r0
 32c:	26030000 	strcs	r0, [r3], -r0
 330:	00134900 	andseq	r4, r3, r0, lsl #18
 334:	00240400 	eoreq	r0, r4, r0, lsl #8
 338:	0b3e0b0b 	bleq	f82f6c <__bss_end+0xf79cc0>
 33c:	00000803 	andeq	r0, r0, r3, lsl #16
 340:	03001605 	movweq	r1, #1541	; 0x605
 344:	3b0b3a0e 	blcc	2ceb84 <__bss_end+0x2c58d8>
 348:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 34c:	06000013 			; <UNDEFINED> instruction: 0x06000013
 350:	0e030113 	mcreq	1, 0, r0, cr3, cr3, {0}
 354:	0b3a0b0b 	bleq	e82f88 <__bss_end+0xe79cdc>
 358:	0b390b3b 	bleq	e4304c <__bss_end+0xe39da0>
 35c:	00001301 	andeq	r1, r0, r1, lsl #6
 360:	03000d07 	movweq	r0, #3335	; 0xd07
 364:	3b0b3a08 	blcc	2ceb8c <__bss_end+0x2c58e0>
 368:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 36c:	000b3813 	andeq	r3, fp, r3, lsl r8
 370:	01040800 	tsteq	r4, r0, lsl #16
 374:	196d0e03 	stmdbne	sp!, {r0, r1, r9, sl, fp}^
 378:	0b0b0b3e 	bleq	2c3078 <__bss_end+0x2b9dcc>
 37c:	0b3a1349 	bleq	e850a8 <__bss_end+0xe7bdfc>
 380:	0b390b3b 	bleq	e43074 <__bss_end+0xe39dc8>
 384:	00001301 	andeq	r1, r0, r1, lsl #6
 388:	03002809 	movweq	r2, #2057	; 0x809
 38c:	000b1c08 	andeq	r1, fp, r8, lsl #24
 390:	00280a00 	eoreq	r0, r8, r0, lsl #20
 394:	0b1c0e03 	bleq	703ba8 <__bss_end+0x6fa8fc>
 398:	340b0000 	strcc	r0, [fp], #-0
 39c:	3a0e0300 	bcc	380fa4 <__bss_end+0x377cf8>
 3a0:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 3a4:	6c13490b 			; <UNDEFINED> instruction: 0x6c13490b
 3a8:	00180219 	andseq	r0, r8, r9, lsl r2
 3ac:	00020c00 	andeq	r0, r2, r0, lsl #24
 3b0:	193c0e03 	ldmdbne	ip!, {r0, r1, r9, sl, fp}
 3b4:	0f0d0000 	svceq	0x000d0000
 3b8:	490b0b00 	stmdbmi	fp, {r8, r9, fp}
 3bc:	0e000013 	mcreq	0, 0, r0, cr0, cr3, {0}
 3c0:	0e03000d 	cdpeq	0, 0, cr0, cr3, cr13, {0}
 3c4:	0b3b0b3a 	bleq	ec30b4 <__bss_end+0xeb9e08>
 3c8:	13490b39 	movtne	r0, #39737	; 0x9b39
 3cc:	00000b38 	andeq	r0, r0, r8, lsr fp
 3d0:	4901010f 	stmdbmi	r1, {r0, r1, r2, r3, r8}
 3d4:	00130113 	andseq	r0, r3, r3, lsl r1
 3d8:	00211000 	eoreq	r1, r1, r0
 3dc:	0b2f1349 	bleq	bc5108 <__bss_end+0xbbbe5c>
 3e0:	02110000 	andseq	r0, r1, #0
 3e4:	0b0e0301 	bleq	380ff0 <__bss_end+0x377d44>
 3e8:	3b0b3a0b 	blcc	2cec1c <__bss_end+0x2c5970>
 3ec:	010b390b 	tsteq	fp, fp, lsl #18
 3f0:	12000013 	andne	r0, r0, #19
 3f4:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 3f8:	0b3a0e03 	bleq	e83c0c <__bss_end+0xe7a960>
 3fc:	0b390b3b 	bleq	e430f0 <__bss_end+0xe39e44>
 400:	193c0e6e 	ldmdbne	ip!, {r1, r2, r3, r5, r6, r9, sl, fp}
 404:	13011364 	movwne	r1, #4964	; 0x1364
 408:	05130000 	ldreq	r0, [r3, #-0]
 40c:	34134900 	ldrcc	r4, [r3], #-2304	; 0xfffff700
 410:	14000019 	strne	r0, [r0], #-25	; 0xffffffe7
 414:	13490005 	movtne	r0, #36869	; 0x9005
 418:	2e150000 	cdpcs	0, 1, cr0, cr5, cr0, {0}
 41c:	03193f01 	tsteq	r9, #1, 30
 420:	3b0b3a0e 	blcc	2cec60 <__bss_end+0x2c59b4>
 424:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 428:	3c13490e 			; <UNDEFINED> instruction: 0x3c13490e
 42c:	01136419 	tsteq	r3, r9, lsl r4
 430:	16000013 			; <UNDEFINED> instruction: 0x16000013
 434:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 438:	0b3a0e03 	bleq	e83c4c <__bss_end+0xe7a9a0>
 43c:	0b390b3b 	bleq	e43130 <__bss_end+0xe39e84>
 440:	13490e6e 	movtne	r0, #40558	; 0x9e6e
 444:	193c0b32 	ldmdbne	ip!, {r1, r4, r5, r8, r9, fp}
 448:	13011364 	movwne	r1, #4964	; 0x1364
 44c:	0d170000 	ldceq	0, cr0, [r7, #-0]
 450:	3a0e0300 	bcc	381058 <__bss_end+0x377dac>
 454:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 458:	3813490b 	ldmdacc	r3, {r0, r1, r3, r8, fp, lr}
 45c:	000b320b 	andeq	r3, fp, fp, lsl #4
 460:	012e1800 			; <UNDEFINED> instruction: 0x012e1800
 464:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 468:	0b3b0b3a 	bleq	ec3158 <__bss_end+0xeb9eac>
 46c:	0e6e0b39 	vmoveq.8	d14[5], r0
 470:	193c0b32 	ldmdbne	ip!, {r1, r4, r5, r8, r9, fp}
 474:	13011364 	movwne	r1, #4964	; 0x1364
 478:	2e190000 	cdpcs	0, 1, cr0, cr9, cr0, {0}
 47c:	03193f01 	tsteq	r9, #1, 30
 480:	3b0b3a0e 	blcc	2cecc0 <__bss_end+0x2c5a14>
 484:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 488:	3213490e 	andscc	r4, r3, #229376	; 0x38000
 48c:	64193c0b 	ldrvs	r3, [r9], #-3083	; 0xfffff3f5
 490:	1a000013 	bne	4e4 <shift+0x4e4>
 494:	13490115 	movtne	r0, #37141	; 0x9115
 498:	13011364 	movwne	r1, #4964	; 0x1364
 49c:	1f1b0000 	svcne	0x001b0000
 4a0:	49131d00 	ldmdbmi	r3, {r8, sl, fp, ip}
 4a4:	1c000013 	stcne	0, cr0, [r0], {19}
 4a8:	0b0b0010 	bleq	2c04f0 <__bss_end+0x2b7244>
 4ac:	00001349 	andeq	r1, r0, r9, asr #6
 4b0:	0b000f1d 	bleq	412c <shift+0x412c>
 4b4:	1e00000b 	cdpne	0, 0, cr0, cr0, cr11, {0}
 4b8:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 4bc:	0b3b0b3a 	bleq	ec31ac <__bss_end+0xeb9f00>
 4c0:	13490b39 	movtne	r0, #39737	; 0x9b39
 4c4:	00001802 	andeq	r1, r0, r2, lsl #16
 4c8:	3f012e1f 	svccc	0x00012e1f
 4cc:	3a0e0319 	bcc	381138 <__bss_end+0x377e8c>
 4d0:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 4d4:	490e6e0b 	stmdbmi	lr, {r0, r1, r3, r9, sl, fp, sp, lr}
 4d8:	12011113 	andne	r1, r1, #-1073741820	; 0xc0000004
 4dc:	96184006 	ldrls	r4, [r8], -r6
 4e0:	13011942 	movwne	r1, #6466	; 0x1942
 4e4:	05200000 	streq	r0, [r0, #-0]!
 4e8:	3a0e0300 	bcc	3810f0 <__bss_end+0x377e44>
 4ec:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 4f0:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 4f4:	21000018 	tstcs	r0, r8, lsl r0
 4f8:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 4fc:	0b3a0e03 	bleq	e83d10 <__bss_end+0xe7aa64>
 500:	0b390b3b 	bleq	e431f4 <__bss_end+0xe39f48>
 504:	13490e6e 	movtne	r0, #40558	; 0x9e6e
 508:	06120111 			; <UNDEFINED> instruction: 0x06120111
 50c:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
 510:	00130119 	andseq	r0, r3, r9, lsl r1
 514:	00342200 	eorseq	r2, r4, r0, lsl #4
 518:	0b3a0803 	bleq	e8252c <__bss_end+0xe79280>
 51c:	0b390b3b 	bleq	e43210 <__bss_end+0xe39f64>
 520:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 524:	2e230000 	cdpcs	0, 2, cr0, cr3, cr0, {0}
 528:	03193f01 	tsteq	r9, #1, 30
 52c:	3b0b3a0e 	blcc	2ced6c <__bss_end+0x2c5ac0>
 530:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 534:	1201110e 	andne	r1, r1, #-2147483645	; 0x80000003
 538:	97184006 	ldrls	r4, [r8, -r6]
 53c:	13011942 	movwne	r1, #6466	; 0x1942
 540:	2e240000 	cdpcs	0, 2, cr0, cr4, cr0, {0}
 544:	03193f00 	tsteq	r9, #0, 30
 548:	3b0b3a0e 	blcc	2ced88 <__bss_end+0x2c5adc>
 54c:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 550:	1201110e 	andne	r1, r1, #-2147483645	; 0x80000003
 554:	97184006 	ldrls	r4, [r8, -r6]
 558:	00001942 	andeq	r1, r0, r2, asr #18
 55c:	3f012e25 	svccc	0x00012e25
 560:	3a0e0319 	bcc	3811cc <__bss_end+0x377f20>
 564:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 568:	490e6e0b 	stmdbmi	lr, {r0, r1, r3, r9, sl, fp, sp, lr}
 56c:	12011113 	andne	r1, r1, #-1073741820	; 0xc0000004
 570:	97184006 	ldrls	r4, [r8, -r6]
 574:	00001942 	andeq	r1, r0, r2, asr #18
 578:	01110100 	tsteq	r1, r0, lsl #2
 57c:	0b130e25 	bleq	4c3e18 <__bss_end+0x4bab6c>
 580:	0e1b0e03 	cdpeq	14, 1, cr0, cr11, cr3, {0}
 584:	06120111 			; <UNDEFINED> instruction: 0x06120111
 588:	00001710 	andeq	r1, r0, r0, lsl r7
 58c:	01013902 	tsteq	r1, r2, lsl #18
 590:	03000013 	movweq	r0, #19
 594:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 598:	0b3b0b3a 	bleq	ec3288 <__bss_end+0xeb9fdc>
 59c:	13490b39 	movtne	r0, #39737	; 0x9b39
 5a0:	0a1c193c 	beq	706a98 <__bss_end+0x6fd7ec>
 5a4:	3a040000 	bcc	1005ac <__bss_end+0xf7300>
 5a8:	3b0b3a00 	blcc	2cedb0 <__bss_end+0x2c5b04>
 5ac:	180b390b 	stmdane	fp, {r0, r1, r3, r8, fp, ip, sp}
 5b0:	05000013 	streq	r0, [r0, #-19]	; 0xffffffed
 5b4:	13490101 	movtne	r0, #37121	; 0x9101
 5b8:	00001301 	andeq	r1, r0, r1, lsl #6
 5bc:	49002106 	stmdbmi	r0, {r1, r2, r8, sp}
 5c0:	000b2f13 	andeq	r2, fp, r3, lsl pc
 5c4:	00260700 	eoreq	r0, r6, r0, lsl #14
 5c8:	00001349 	andeq	r1, r0, r9, asr #6
 5cc:	0b002408 	bleq	95f4 <__bss_end+0x348>
 5d0:	030b3e0b 	movweq	r3, #48651	; 0xbe0b
 5d4:	0900000e 	stmdbeq	r0, {r1, r2, r3}
 5d8:	13470034 	movtne	r0, #28724	; 0x7034
 5dc:	2e0a0000 	cdpcs	0, 0, cr0, cr10, cr0, {0}
 5e0:	03193f01 	tsteq	r9, #1, 30
 5e4:	3b0b3a0e 	blcc	2cee24 <__bss_end+0x2c5b78>
 5e8:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 5ec:	1201110e 	andne	r1, r1, #-2147483645	; 0x80000003
 5f0:	96184006 	ldrls	r4, [r8], -r6
 5f4:	13011942 	movwne	r1, #6466	; 0x1942
 5f8:	050b0000 	streq	r0, [fp, #-0]
 5fc:	3a0e0300 	bcc	381204 <__bss_end+0x377f58>
 600:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 604:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 608:	0c000018 	stceq	0, cr0, [r0], {24}
 60c:	08030005 	stmdaeq	r3, {r0, r2}
 610:	0b3b0b3a 	bleq	ec3300 <__bss_end+0xeba054>
 614:	13490b39 	movtne	r0, #39737	; 0x9b39
 618:	00001802 	andeq	r1, r0, r2, lsl #16
 61c:	0300340d 	movweq	r3, #1037	; 0x40d
 620:	3b0b3a08 	blcc	2cee48 <__bss_end+0x2c5b9c>
 624:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 628:	00180213 	andseq	r0, r8, r3, lsl r2
 62c:	000f0e00 	andeq	r0, pc, r0, lsl #28
 630:	13490b0b 	movtne	r0, #39691	; 0x9b0b
 634:	240f0000 	strcs	r0, [pc], #-0	; 63c <shift+0x63c>
 638:	3e0b0b00 	vmlacc.f64	d0, d11, d0
 63c:	0008030b 	andeq	r0, r8, fp, lsl #6
 640:	012e1000 			; <UNDEFINED> instruction: 0x012e1000
 644:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 648:	0b3b0b3a 	bleq	ec3338 <__bss_end+0xeba08c>
 64c:	0e6e0b39 	vmoveq.8	d14[5], r0
 650:	06120111 			; <UNDEFINED> instruction: 0x06120111
 654:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
 658:	00130119 	andseq	r0, r3, r9, lsl r1
 65c:	00341100 	eorseq	r1, r4, r0, lsl #2
 660:	0b3a0e03 	bleq	e83e74 <__bss_end+0xe7abc8>
 664:	0b390b3b 	bleq	e43358 <__bss_end+0xe3a0ac>
 668:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 66c:	0b120000 	bleq	480674 <__bss_end+0x4773c8>
 670:	12011101 	andne	r1, r1, #1073741824	; 0x40000000
 674:	13000006 	movwne	r0, #6
 678:	00000026 	andeq	r0, r0, r6, lsr #32
 67c:	0b000f14 	bleq	42d4 <shift+0x42d4>
 680:	1500000b 	strne	r0, [r0, #-11]
 684:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 688:	0b3a0e03 	bleq	e83e9c <__bss_end+0xe7abf0>
 68c:	0b390b3b 	bleq	e43380 <__bss_end+0xe3a0d4>
 690:	13490e6e 	movtne	r0, #40558	; 0x9e6e
 694:	06120111 			; <UNDEFINED> instruction: 0x06120111
 698:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
 69c:	00130119 	andseq	r0, r3, r9, lsl r1
 6a0:	010b1600 	tsteq	fp, r0, lsl #12
 6a4:	06120111 			; <UNDEFINED> instruction: 0x06120111
 6a8:	00001301 	andeq	r1, r0, r1, lsl #6
 6ac:	3f012e17 	svccc	0x00012e17
 6b0:	3a0e0319 	bcc	38131c <__bss_end+0x378070>
 6b4:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 6b8:	110e6e0b 	tstne	lr, fp, lsl #28
 6bc:	40061201 	andmi	r1, r6, r1, lsl #4
 6c0:	19429618 	stmdbne	r2, {r3, r4, r9, sl, ip, pc}^
 6c4:	Address 0x00000000000006c4 is out of bounds.


Disassembly of section .debug_aranges:

00000000 <.debug_aranges>:
   0:	0000001c 	andeq	r0, r0, ip, lsl r0
   4:	00000002 	andeq	r0, r0, r2
   8:	00040000 	andeq	r0, r4, r0
   c:	00000000 	andeq	r0, r0, r0
  10:	00008000 	andeq	r8, r0, r0
  14:	00000008 	andeq	r0, r0, r8
	...
  20:	0000001c 	andeq	r0, r0, ip, lsl r0
  24:	00260002 	eoreq	r0, r6, r2
  28:	00040000 	andeq	r0, r4, r0
  2c:	00000000 	andeq	r0, r0, r0
  30:	00008008 	andeq	r8, r0, r8
  34:	0000009c 	muleq	r0, ip, r0
	...
  40:	0000001c 	andeq	r0, r0, ip, lsl r0
  44:	00ce0002 	sbceq	r0, lr, r2
  48:	00040000 	andeq	r0, r4, r0
  4c:	00000000 	andeq	r0, r0, r0
  50:	000080a4 	andeq	r8, r0, r4, lsr #1
  54:	00000188 	andeq	r0, r0, r8, lsl #3
	...
  60:	0000001c 	andeq	r0, r0, ip, lsl r0
  64:	02d40002 	sbcseq	r0, r4, #2
  68:	00040000 	andeq	r0, r4, r0
  6c:	00000000 	andeq	r0, r0, r0
  70:	0000822c 	andeq	r8, r0, ip, lsr #4
  74:	00000198 	muleq	r0, r8, r1
	...
  80:	0000001c 	andeq	r0, r0, ip, lsl r0
  84:	064b0002 	strbeq	r0, [fp], -r2
  88:	00040000 	andeq	r0, r4, r0
  8c:	00000000 	andeq	r0, r0, r0
  90:	000083c4 	andeq	r8, r0, r4, asr #7
  94:	0000045c 	andeq	r0, r0, ip, asr r4
	...
  a0:	0000001c 	andeq	r0, r0, ip, lsl r0
  a4:	116e0002 	cmnne	lr, r2
  a8:	00040000 	andeq	r0, r4, r0
  ac:	00000000 	andeq	r0, r0, r0
  b0:	00008820 	andeq	r8, r0, r0, lsr #16
  b4:	000007c0 	andeq	r0, r0, r0, asr #15
	...

Disassembly of section .debug_str:

00000000 <.debug_str>:
       0:	6573552f 	ldrbvs	r5, [r3, #-1327]!	; 0xfffffad1
       4:	772f7372 			; <UNDEFINED> instruction: 0x772f7372
       8:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
       c:	2f696a72 	svccs	0x00696a72
      10:	6b736544 	blvs	1cd9528 <__bss_end+0x1cd027c>
      14:	2f706f74 	svccs	0x00706f74
      18:	2f564146 	svccs	0x00564146
      1c:	6176614e 	cmnvs	r6, lr, asr #2
      20:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
      24:	4f2f6963 	svcmi	0x002f6963
      28:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
      2c:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
      30:	6b6c6172 	blvs	1b18600 <__bss_end+0x1b0f354>
      34:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
      38:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
      3c:	756f732f 	strbvc	r7, [pc, #-815]!	; fffffd15 <__bss_end+0xffff6a69>
      40:	73656372 	cmnvc	r5, #-939524095	; 0xc8000001
      44:	6573752f 	ldrbvs	r7, [r3, #-1327]!	; 0xfffffad1
      48:	61707372 	cmnvs	r0, r2, ror r3
      4c:	632f6563 			; <UNDEFINED> instruction: 0x632f6563
      50:	2e307472 	mrccs	4, 1, r7, cr0, cr2, {3}
      54:	552f0073 	strpl	r0, [pc, #-115]!	; ffffffe9 <__bss_end+0xffff6d3d>
      58:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
      5c:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
      60:	6a726574 	bvs	1c99638 <__bss_end+0x1c9038c>
      64:	65442f69 	strbvs	r2, [r4, #-3945]	; 0xfffff097
      68:	6f746b73 	svcvs	0x00746b73
      6c:	41462f70 	hvcmi	25328	; 0x62f0
      70:	614e2f56 	cmpvs	lr, r6, asr pc
      74:	757a6176 	ldrbvc	r6, [sl, #-374]!	; 0xfffffe8a
      78:	6963696a 	stmdbvs	r3!, {r1, r3, r5, r6, r8, fp, sp, lr}^
      7c:	2f534f2f 	svccs	0x00534f2f
      80:	656d6573 	strbvs	r6, [sp, #-1395]!	; 0xfffffa8d
      84:	61727473 	cmnvs	r2, r3, ror r4
      88:	2d616b6c 	vstmdbcs	r1!, {d22-<overflow reg d75>}
      8c:	2d76696b 			; <UNDEFINED> instruction: 0x2d76696b
      90:	732f736f 			; <UNDEFINED> instruction: 0x732f736f
      94:	6372756f 	cmnvs	r2, #465567744	; 0x1bc00000
      98:	752f7365 	strvc	r7, [pc, #-869]!	; fffffd3b <__bss_end+0xffff6a8f>
      9c:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
      a0:	65636170 	strbvs	r6, [r3, #-368]!	; 0xfffffe90
      a4:	6975622f 	ldmdbvs	r5!, {r0, r1, r2, r3, r5, r9, sp, lr}^
      a8:	4700646c 	strmi	r6, [r0, -ip, ror #8]
      ac:	4120554e 			; <UNDEFINED> instruction: 0x4120554e
      b0:	2e322053 	mrccs	0, 1, r2, cr2, cr3, {2}
      b4:	312e3633 			; <UNDEFINED> instruction: 0x312e3633
      b8:	635f5f00 	cmpvs	pc, #0, 30
      bc:	5f307472 	svcpl	0x00307472
      c0:	74696e69 	strbtvc	r6, [r9], #-3689	; 0xfffff197
      c4:	7373625f 	cmnvc	r3, #-268435451	; 0xf0000005
      c8:	554e4700 	strbpl	r4, [lr, #-1792]	; 0xfffff900
      cc:	37314320 	ldrcc	r4, [r1, -r0, lsr #6]!
      d0:	2e303120 	rsfcssp	f3, f0, f0
      d4:	20312e33 	eorscs	r2, r1, r3, lsr lr
      d8:	31323032 	teqcc	r2, r2, lsr r0
      dc:	34323830 	ldrtcc	r3, [r2], #-2096	; 0xfffff7d0
      e0:	65722820 	ldrbvs	r2, [r2, #-2080]!	; 0xfffff7e0
      e4:	7361656c 	cmnvc	r1, #108, 10	; 0x1b000000
      e8:	2d202965 			; <UNDEFINED> instruction: 0x2d202965
      ec:	6f6c666d 	svcvs	0x006c666d
      f0:	612d7461 			; <UNDEFINED> instruction: 0x612d7461
      f4:	683d6962 	ldmdavs	sp!, {r1, r5, r6, r8, fp, sp, lr}
      f8:	20647261 	rsbcs	r7, r4, r1, ror #4
      fc:	70666d2d 	rsbvc	r6, r6, sp, lsr #26
     100:	66763d75 			; <UNDEFINED> instruction: 0x66763d75
     104:	6d2d2070 	stcvs	0, cr2, [sp, #-448]!	; 0xfffffe40
     108:	616f6c66 	cmnvs	pc, r6, ror #24
     10c:	62612d74 	rsbvs	r2, r1, #116, 26	; 0x1d00
     110:	61683d69 	cmnvs	r8, r9, ror #26
     114:	2d206472 	cfstrscs	mvf6, [r0, #-456]!	; 0xfffffe38
     118:	7570666d 	ldrbvc	r6, [r0, #-1645]!	; 0xfffff993
     11c:	7066763d 	rsbvc	r7, r6, sp, lsr r6
     120:	746d2d20 	strbtvc	r2, [sp], #-3360	; 0xfffff2e0
     124:	3d656e75 	stclcc	14, cr6, [r5, #-468]!	; 0xfffffe2c
     128:	316d7261 	cmncc	sp, r1, ror #4
     12c:	6a363731 	bvs	d8ddf8 <__bss_end+0xd84b4c>
     130:	732d667a 			; <UNDEFINED> instruction: 0x732d667a
     134:	616d2d20 	cmnvs	sp, r0, lsr #26
     138:	2d206d72 	stccs	13, cr6, [r0, #-456]!	; 0xfffffe38
     13c:	6372616d 	cmnvs	r2, #1073741851	; 0x4000001b
     140:	72613d68 	rsbvc	r3, r1, #104, 26	; 0x1a00
     144:	7a36766d 	bvc	d9db00 <__bss_end+0xd94854>
     148:	70662b6b 	rsbvc	r2, r6, fp, ror #22
     14c:	20672d20 	rsbcs	r2, r7, r0, lsr #26
     150:	2d20672d 	stccs	7, cr6, [r0, #-180]!	; 0xffffff4c
     154:	2d20304f 	stccs	0, cr3, [r0, #-316]!	; 0xfffffec4
     158:	5f00304f 	svcpl	0x0000304f
     15c:	7373625f 	cmnvc	r3, #-268435451	; 0xf0000005
     160:	646e655f 	strbtvs	r6, [lr], #-1375	; 0xfffffaa1
     164:	73552f00 	cmpvc	r5, #0, 30
     168:	2f737265 	svccs	0x00737265
     16c:	746e6977 	strbtvc	r6, [lr], #-2423	; 0xfffff689
     170:	696a7265 	stmdbvs	sl!, {r0, r2, r5, r6, r9, ip, sp, lr}^
     174:	7365442f 	cmnvc	r5, #788529152	; 0x2f000000
     178:	706f746b 	rsbvc	r7, pc, fp, ror #8
     17c:	5641462f 	strbpl	r4, [r1], -pc, lsr #12
     180:	76614e2f 	strbtvc	r4, [r1], -pc, lsr #28
     184:	6a757a61 	bvs	1d5eb10 <__bss_end+0x1d55864>
     188:	2f696369 	svccs	0x00696369
     18c:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
     190:	73656d65 	cmnvc	r5, #6464	; 0x1940
     194:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
     198:	6b2d616b 	blvs	b5874c <__bss_end+0xb4f4a0>
     19c:	6f2d7669 	svcvs	0x002d7669
     1a0:	6f732f73 	svcvs	0x00732f73
     1a4:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
     1a8:	73752f73 	cmnvc	r5, #460	; 0x1cc
     1ac:	70737265 	rsbsvc	r7, r3, r5, ror #4
     1b0:	2f656361 	svccs	0x00656361
     1b4:	30747263 	rsbscc	r7, r4, r3, ror #4
     1b8:	7200632e 	andvc	r6, r0, #-1207959552	; 0xb8000000
     1bc:	6c757365 	ldclvs	3, cr7, [r5], #-404	; 0xfffffe6c
     1c0:	5f5f0074 	svcpl	0x005f0074
     1c4:	5f737362 	svcpl	0x00737362
     1c8:	72617473 	rsbvc	r7, r1, #1929379840	; 0x73000000
     1cc:	5f5f0074 	svcpl	0x005f0074
     1d0:	30747263 	rsbscc	r7, r4, r3, ror #4
     1d4:	6e75725f 	mrcvs	2, 3, r7, cr5, cr15, {2}
     1d8:	675f5f00 	ldrbvs	r5, [pc, -r0, lsl #30]
     1dc:	64726175 	ldrbtvs	r6, [r2], #-373	; 0xfffffe8b
     1e0:	554e4700 	strbpl	r4, [lr, #-1792]	; 0xfffff900
     1e4:	2b2b4320 	blcs	ad0e6c <__bss_end+0xac7bc0>
     1e8:	31203431 			; <UNDEFINED> instruction: 0x31203431
     1ec:	2e332e30 	mrccs	14, 1, r2, cr3, cr0, {1}
     1f0:	30322031 	eorscc	r2, r2, r1, lsr r0
     1f4:	38303132 	ldmdacc	r0!, {r1, r4, r5, r8, ip, sp}
     1f8:	28203432 	stmdacs	r0!, {r1, r4, r5, sl, ip, sp}
     1fc:	656c6572 	strbvs	r6, [ip, #-1394]!	; 0xfffffa8e
     200:	29657361 	stmdbcs	r5!, {r0, r5, r6, r8, r9, ip, sp, lr}^
     204:	666d2d20 	strbtvs	r2, [sp], -r0, lsr #26
     208:	74616f6c 	strbtvc	r6, [r1], #-3948	; 0xfffff094
     20c:	6962612d 	stmdbvs	r2!, {r0, r2, r3, r5, r8, sp, lr}^
     210:	7261683d 	rsbvc	r6, r1, #3997696	; 0x3d0000
     214:	6d2d2064 	stcvs	0, cr2, [sp, #-400]!	; 0xfffffe70
     218:	3d757066 	ldclcc	0, cr7, [r5, #-408]!	; 0xfffffe68
     21c:	20706676 	rsbscs	r6, r0, r6, ror r6
     220:	6c666d2d 	stclvs	13, cr6, [r6], #-180	; 0xffffff4c
     224:	2d74616f 	ldfcse	f6, [r4, #-444]!	; 0xfffffe44
     228:	3d696261 	sfmcc	f6, 2, [r9, #-388]!	; 0xfffffe7c
     22c:	64726168 	ldrbtvs	r6, [r2], #-360	; 0xfffffe98
     230:	666d2d20 	strbtvs	r2, [sp], -r0, lsr #26
     234:	763d7570 			; <UNDEFINED> instruction: 0x763d7570
     238:	2d207066 	stccs	0, cr7, [r0, #-408]!	; 0xfffffe68
     23c:	6e75746d 	cdpvs	4, 7, cr7, cr5, cr13, {3}
     240:	72613d65 	rsbvc	r3, r1, #6464	; 0x1940
     244:	3731316d 	ldrcc	r3, [r1, -sp, ror #2]!
     248:	667a6a36 			; <UNDEFINED> instruction: 0x667a6a36
     24c:	2d20732d 	stccs	3, cr7, [r0, #-180]!	; 0xffffff4c
     250:	6d72616d 	ldfvse	f6, [r2, #-436]!	; 0xfffffe4c
     254:	616d2d20 	cmnvs	sp, r0, lsr #26
     258:	3d686372 	stclcc	3, cr6, [r8, #-456]!	; 0xfffffe38
     25c:	766d7261 	strbtvc	r7, [sp], -r1, ror #4
     260:	2b6b7a36 	blcs	1adeb40 <__bss_end+0x1ad5894>
     264:	2d207066 	stccs	0, cr7, [r0, #-408]!	; 0xfffffe68
     268:	672d2067 	strvs	r2, [sp, -r7, rrx]!
     26c:	304f2d20 	subcc	r2, pc, r0, lsr #26
     270:	304f2d20 	subcc	r2, pc, r0, lsr #26
     274:	6e662d20 	cdpvs	13, 6, cr2, cr6, cr0, {1}
     278:	78652d6f 	stmdavc	r5!, {r0, r1, r2, r3, r5, r6, r8, sl, fp, sp}^
     27c:	74706563 	ldrbtvc	r6, [r0], #-1379	; 0xfffffa9d
     280:	736e6f69 	cmnvc	lr, #420	; 0x1a4
     284:	6e662d20 	cdpvs	13, 6, cr2, cr6, cr0, {1}
     288:	74722d6f 	ldrbtvc	r2, [r2], #-3439	; 0xfffff291
     28c:	5f006974 	svcpl	0x00006974
     290:	6165615f 	cmnvs	r5, pc, asr r1
     294:	755f6962 	ldrbvc	r6, [pc, #-2402]	; fffff93a <__bss_end+0xffff668e>
     298:	6e69776e 	cdpvs	7, 6, cr7, cr9, cr14, {3}
     29c:	70635f64 	rsbvc	r5, r3, r4, ror #30
     2a0:	72705f70 	rsbsvc	r5, r0, #112, 30	; 0x1c0
     2a4:	635f0031 	cmpvs	pc, #49	; 0x31
     2a8:	735f7070 	cmpvc	pc, #112	; 0x70
     2ac:	64747568 	ldrbtvs	r7, [r4], #-1384	; 0xfffffa98
     2b0:	006e776f 	rsbeq	r7, lr, pc, ror #14
     2b4:	74706e66 	ldrbtvc	r6, [r0], #-3686	; 0xfffff19a
     2b8:	5f5f0072 	svcpl	0x005f0072
     2bc:	61787863 	cmnvs	r8, r3, ror #16
     2c0:	31766962 	cmncc	r6, r2, ror #18
     2c4:	635f5f00 	cmpvs	pc, #0, 30
     2c8:	705f6178 	subsvc	r6, pc, r8, ror r1	; <UNPREDICTABLE>
     2cc:	5f657275 	svcpl	0x00657275
     2d0:	74726976 	ldrbtvc	r6, [r2], #-2422	; 0xfffff68a
     2d4:	006c6175 	rsbeq	r6, ip, r5, ror r1
     2d8:	78635f5f 	stmdavc	r3!, {r0, r1, r2, r3, r4, r6, r8, r9, sl, fp, ip, lr}^
     2dc:	75675f61 	strbvc	r5, [r7, #-3937]!	; 0xfffff09f
     2e0:	5f647261 	svcpl	0x00647261
     2e4:	656c6572 	strbvs	r6, [ip, #-1394]!	; 0xfffffa8e
     2e8:	00657361 	rsbeq	r7, r5, r1, ror #6
     2ec:	54435f5f 	strbpl	r5, [r3], #-3935	; 0xfffff0a1
     2f0:	455f524f 	ldrbmi	r5, [pc, #-591]	; a9 <shift+0xa9>
     2f4:	5f5f444e 	svcpl	0x005f444e
     2f8:	645f5f00 	ldrbvs	r5, [pc], #-3840	; 300 <shift+0x300>
     2fc:	685f6f73 	ldmdavs	pc, {r0, r1, r4, r5, r6, r8, r9, sl, fp, sp, lr}^	; <UNPREDICTABLE>
     300:	6c646e61 	stclvs	14, cr6, [r4], #-388	; 0xfffffe7c
     304:	5f5f0065 	svcpl	0x005f0065
     308:	524f5444 	subpl	r5, pc, #68, 8	; 0x44000000
     30c:	53494c5f 	movtpl	r4, #40031	; 0x9c5f
     310:	005f5f54 	subseq	r5, pc, r4, asr pc	; <UNPREDICTABLE>
     314:	6573552f 	ldrbvs	r5, [r3, #-1327]!	; 0xfffffad1
     318:	772f7372 			; <UNDEFINED> instruction: 0x772f7372
     31c:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
     320:	2f696a72 	svccs	0x00696a72
     324:	6b736544 	blvs	1cd983c <__bss_end+0x1cd0590>
     328:	2f706f74 	svccs	0x00706f74
     32c:	2f564146 	svccs	0x00564146
     330:	6176614e 	cmnvs	r6, lr, asr #2
     334:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
     338:	4f2f6963 	svcmi	0x002f6963
     33c:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
     340:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
     344:	6b6c6172 	blvs	1b18914 <__bss_end+0x1b0f668>
     348:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
     34c:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
     350:	756f732f 	strbvc	r7, [pc, #-815]!	; 29 <shift+0x29>
     354:	73656372 	cmnvc	r5, #-939524095	; 0xc8000001
     358:	6573752f 	ldrbvs	r7, [r3, #-1327]!	; 0xfffffad1
     35c:	61707372 	cmnvs	r0, r2, ror r3
     360:	632f6563 			; <UNDEFINED> instruction: 0x632f6563
     364:	62617878 	rsbvs	r7, r1, #120, 16	; 0x780000
     368:	70632e69 	rsbvc	r2, r3, r9, ror #28
     36c:	5f5f0070 	svcpl	0x005f0070
     370:	5f617863 	svcpl	0x00617863
     374:	72617567 	rsbvc	r7, r1, #432013312	; 0x19c00000
     378:	62615f64 	rsbvs	r5, r1, #100, 30	; 0x190
     37c:	0074726f 	rsbseq	r7, r4, pc, ror #4
     380:	726f7464 	rsbvc	r7, pc, #100, 8	; 0x64000000
     384:	7274705f 	rsbsvc	r7, r4, #95	; 0x5f
     388:	445f5f00 	ldrbmi	r5, [pc], #-3840	; 390 <shift+0x390>
     38c:	5f524f54 	svcpl	0x00524f54
     390:	5f444e45 	svcpl	0x00444e45
     394:	5f5f005f 	svcpl	0x005f005f
     398:	5f617863 	svcpl	0x00617863
     39c:	78657461 	stmdavc	r5!, {r0, r5, r6, sl, ip, sp, lr}^
     3a0:	6c007469 	cfstrsvs	mvf7, [r0], {105}	; 0x69
     3a4:	20676e6f 	rsbcs	r6, r7, pc, ror #28
     3a8:	676e6f6c 	strbvs	r6, [lr, -ip, ror #30]!
     3ac:	746e6920 	strbtvc	r6, [lr], #-2336	; 0xfffff6e0
     3b0:	70635f00 	rsbvc	r5, r3, r0, lsl #30
     3b4:	74735f70 	ldrbtvc	r5, [r3], #-3952	; 0xfffff090
     3b8:	75747261 	ldrbvc	r7, [r4, #-609]!	; 0xfffffd9f
     3bc:	5f5f0070 	svcpl	0x005f0070
     3c0:	524f5443 	subpl	r5, pc, #1124073472	; 0x43000000
     3c4:	53494c5f 	movtpl	r4, #40031	; 0x9c5f
     3c8:	005f5f54 	subseq	r5, pc, r4, asr pc	; <UNPREDICTABLE>
     3cc:	726f7463 	rsbvc	r7, pc, #1660944384	; 0x63000000
     3d0:	7274705f 	rsbsvc	r7, r4, #95	; 0x5f
     3d4:	635f5f00 	cmpvs	pc, #0, 30
     3d8:	675f6178 			; <UNDEFINED> instruction: 0x675f6178
     3dc:	64726175 	ldrbtvs	r6, [r2], #-373	; 0xfffffe8b
     3e0:	7163615f 	cmnvc	r3, pc, asr r1
     3e4:	65726975 	ldrbvs	r6, [r2, #-2421]!	; 0xfffff68b
     3e8:	41554e00 	cmpmi	r5, r0, lsl #28
     3ec:	425f5452 	subsmi	r5, pc, #1375731712	; 0x52000000
     3f0:	5f647561 	svcpl	0x00647561
     3f4:	65746152 	ldrbvs	r6, [r4, #-338]!	; 0xfffffeae
     3f8:	616e4500 	cmnvs	lr, r0, lsl #10
     3fc:	5f656c62 	svcpl	0x00656c62
     400:	6e657645 	cdpvs	6, 6, cr7, cr5, cr5, {2}
     404:	65445f74 	strbvs	r5, [r4, #-3956]	; 0xfffff08c
     408:	74636574 	strbtvc	r6, [r3], #-1396	; 0xfffffa8c
     40c:	006e6f69 	rsbeq	r6, lr, r9, ror #30
     410:	4678614d 	ldrbtmi	r6, [r8], -sp, asr #2
     414:	69724453 	ldmdbvs	r2!, {r0, r1, r4, r6, sl, lr}^
     418:	4e726576 	mrcmi	5, 3, r6, cr2, cr6, {3}
     41c:	4c656d61 	stclmi	13, cr6, [r5], #-388	; 0xfffffe7c
     420:	74676e65 	strbtvc	r6, [r7], #-3685	; 0xfffff19b
     424:	554e0068 	strbpl	r0, [lr, #-104]	; 0xffffff98
     428:	5f545241 	svcpl	0x00545241
     42c:	72616843 	rsbvc	r6, r1, #4390912	; 0x430000
     430:	6e654c5f 	mcrvs	12, 3, r4, cr5, cr15, {2}
     434:	00687467 	rsbeq	r7, r8, r7, ror #8
     438:	65657266 	strbvs	r7, [r5, #-614]!	; 0xfffffd9a
     43c:	646e695f 	strbtvs	r6, [lr], #-2399	; 0xfffff6a1
     440:	42007865 	andmi	r7, r0, #6619136	; 0x650000
     444:	31315f52 	teqcc	r1, r2, asr pc
     448:	30303235 	eorscc	r3, r0, r5, lsr r2
     44c:	73552f00 	cmpvc	r5, #0, 30
     450:	2f737265 	svccs	0x00737265
     454:	746e6977 	strbtvc	r6, [lr], #-2423	; 0xfffff689
     458:	696a7265 	stmdbvs	sl!, {r0, r2, r5, r6, r9, ip, sp, lr}^
     45c:	7365442f 	cmnvc	r5, #788529152	; 0x2f000000
     460:	706f746b 	rsbvc	r7, pc, fp, ror #8
     464:	5641462f 	strbpl	r4, [r1], -pc, lsr #12
     468:	76614e2f 	strbtvc	r4, [r1], -pc, lsr #28
     46c:	6a757a61 	bvs	1d5edf8 <__bss_end+0x1d55b4c>
     470:	2f696369 	svccs	0x00696369
     474:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
     478:	73656d65 	cmnvc	r5, #6464	; 0x1940
     47c:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
     480:	6b2d616b 	blvs	b58a34 <__bss_end+0xb4f788>
     484:	6f2d7669 	svcvs	0x002d7669
     488:	6f732f73 	svcvs	0x00732f73
     48c:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
     490:	73752f73 	cmnvc	r5, #460	; 0x1cc
     494:	70737265 	rsbsvc	r7, r3, r5, ror #4
     498:	2f656361 	svccs	0x00656361
     49c:	67676f6c 	strbvs	r6, [r7, -ip, ror #30]!
     4a0:	745f7265 	ldrbvc	r7, [pc], #-613	; 4a8 <shift+0x4a8>
     4a4:	2f6b7361 	svccs	0x006b7361
     4a8:	6e69616d 	powvsez	f6, f1, #5.0
     4ac:	7070632e 	rsbsvc	r6, r0, lr, lsr #6
     4b0:	6f6f6200 	svcvs	0x006f6200
     4b4:	5242006c 	subpl	r0, r2, #108	; 0x6c
     4b8:	3036395f 	eorscc	r3, r6, pc, asr r9
     4bc:	6f4c0030 	svcvs	0x004c0030
     4c0:	4c5f6b63 	mrrcmi	11, 6, r6, pc, cr3	; <UNPREDICTABLE>
     4c4:	656b636f 	strbvs	r6, [fp, #-879]!	; 0xfffffc91
     4c8:	70660064 	rsbvc	r0, r6, r4, rrx
     4cc:	00737475 	rsbseq	r7, r3, r5, ror r4
     4d0:	69727473 	ldmdbvs	r2!, {r0, r1, r4, r5, r6, sl, ip, sp, lr}^
     4d4:	4e00676e 	cdpmi	7, 0, cr6, cr0, cr14, {3}
     4d8:	6c69466f 	stclvs	6, cr4, [r9], #-444	; 0xfffffe44
     4dc:	73797365 	cmnvc	r9, #-1811939327	; 0x94000001
     4e0:	446d6574 	strbtmi	r6, [sp], #-1396	; 0xfffffa8c
     4e4:	65766972 	ldrbvs	r6, [r6, #-2418]!	; 0xfffff68e
     4e8:	616c0072 	smcvs	49154	; 0xc002
     4ec:	745f7473 	ldrbvc	r7, [pc], #-1139	; 4f4 <shift+0x4f4>
     4f0:	006b6369 	rsbeq	r6, fp, r9, ror #6
     4f4:	4678614d 	ldrbtmi	r6, [r8], -sp, asr #2
     4f8:	6e656c69 	cdpvs	12, 6, cr6, cr5, cr9, {3}
     4fc:	4c656d61 	stclmi	13, cr6, [r5], #-388	; 0xfffffe7c
     500:	74676e65 	strbtvc	r6, [r7], #-3685	; 0xfffff19b
     504:	61620068 	cmnvs	r2, r8, rrx
     508:	725f6475 	subsvc	r6, pc, #1962934272	; 0x75000000
     50c:	00657461 	rsbeq	r7, r5, r1, ror #8
     510:	345f5242 	ldrbcc	r5, [pc], #-578	; 518 <shift+0x518>
     514:	00303038 	eorseq	r3, r0, r8, lsr r0
     518:	69736e75 	ldmdbvs	r3!, {r0, r2, r4, r5, r6, r9, sl, fp, sp, lr}^
     51c:	64656e67 	strbtvs	r6, [r5], #-3687	; 0xfffff199
     520:	61686320 	cmnvs	r8, r0, lsr #6
     524:	65440072 	strbvs	r0, [r4, #-114]	; 0xffffff8e
     528:	696c6461 	stmdbvs	ip!, {r0, r5, r6, sl, sp, lr}^
     52c:	555f656e 	ldrbpl	r6, [pc, #-1390]	; ffffffc6 <__bss_end+0xffff6d1a>
     530:	6168636e 	cmnvs	r8, lr, ror #6
     534:	6465676e 	strbtvs	r6, [r5], #-1902	; 0xfffff892
     538:	6e6f6c00 	cdpvs	12, 6, cr6, cr15, cr0, {0}
     53c:	6e752067 	cdpvs	0, 7, cr2, cr5, cr7, {3}
     540:	6e676973 			; <UNDEFINED> instruction: 0x6e676973
     544:	69206465 	stmdbvs	r0!, {r0, r2, r5, r6, sl, sp, lr}
     548:	7500746e 	strvc	r7, [r0, #-1134]	; 0xfffffb92
     54c:	5f747261 	svcpl	0x00747261
     550:	656c6966 	strbvs	r6, [ip, #-2406]!	; 0xfffff69a
     554:	6f687300 	svcvs	0x00687300
     558:	75207472 	strvc	r7, [r0, #-1138]!	; 0xfffffb8e
     55c:	6769736e 	strbvs	r7, [r9, -lr, ror #6]!
     560:	2064656e 	rsbcs	r6, r4, lr, ror #10
     564:	00746e69 	rsbseq	r6, r4, r9, ror #28
     568:	69746f4e 	ldmdbvs	r4!, {r1, r2, r3, r6, r8, r9, sl, fp, sp, lr}^
     56c:	6c417966 	mcrrvs	9, 6, r7, r1, cr6	; <UNPREDICTABLE>
     570:	6843006c 	stmdavs	r3, {r2, r3, r5, r6}^
     574:	375f7261 	ldrbcc	r7, [pc, -r1, ror #4]
     578:	61684300 	cmnvs	r8, r0, lsl #6
     57c:	00385f72 	eorseq	r5, r8, r2, ror pc
     580:	335f5242 	cmpcc	pc, #536870916	; 0x20000004
     584:	30303438 	eorscc	r3, r0, r8, lsr r4
     588:	74654700 	strbtvc	r4, [r5], #-1792	; 0xfffff900
     58c:	7261505f 	rsbvc	r5, r1, #95	; 0x5f
     590:	00736d61 	rsbseq	r6, r3, r1, ror #26
     594:	74697257 	strbtvc	r7, [r9], #-599	; 0xfffffda9
     598:	6e4f5f65 	cdpvs	15, 4, cr5, cr15, cr5, {3}
     59c:	4200796c 	andmi	r7, r0, #108, 18	; 0x1b0000
     5a0:	39315f52 	ldmdbcc	r1!, {r1, r4, r6, r8, r9, sl, fp, ip, lr}
     5a4:	00303032 	eorseq	r3, r0, r2, lsr r0
     5a8:	5f78614d 	svcpl	0x0078614d
     5ac:	636f7250 	cmnvs	pc, #80, 4
     5b0:	5f737365 	svcpl	0x00737365
     5b4:	6e65704f 	cdpvs	0, 6, cr7, cr5, cr15, {2}
     5b8:	465f6465 	ldrbmi	r6, [pc], -r5, ror #8
     5bc:	73656c69 	cmnvc	r5, #26880	; 0x6900
     5c0:	5f524200 	svcpl	0x00524200
     5c4:	30303432 	eorscc	r3, r0, r2, lsr r4
     5c8:	61655200 	cmnvs	r5, r0, lsl #4
     5cc:	72575f64 	subsvc	r5, r7, #100, 30	; 0x190
     5d0:	00657469 	rsbeq	r7, r5, r9, ror #8
     5d4:	61766e49 	cmnvs	r6, r9, asr #28
     5d8:	5f64696c 	svcpl	0x0064696c
     5dc:	646e6148 	strbtvs	r6, [lr], #-328	; 0xfffffeb8
     5e0:	6d00656c 	cfstr32vs	mvfx6, [r0, #-432]	; 0xfffffe50
     5e4:	006e6961 	rsbeq	r6, lr, r1, ror #18
     5e8:	65646e49 	strbvs	r6, [r4, #-3657]!	; 0xfffff1b7
     5ec:	696e6966 	stmdbvs	lr!, {r1, r2, r5, r6, r8, fp, sp, lr}^
     5f0:	42006574 	andmi	r6, r0, #116, 10	; 0x1d000000
     5f4:	32315f52 	eorscc	r5, r1, #328	; 0x148
     5f8:	63003030 	movwvs	r3, #48	; 0x30
     5fc:	5f726168 	svcpl	0x00726168
     600:	676e656c 	strbvs	r6, [lr, -ip, ror #10]!
     604:	52006874 	andpl	r6, r0, #116, 16	; 0x740000
     608:	5f646165 	svcpl	0x00646165
     60c:	796c6e4f 	stmdbvc	ip!, {r0, r1, r2, r3, r6, r9, sl, fp, sp, lr}^
     610:	636f4c00 	cmnvs	pc, #0, 24
     614:	6e555f6b 	cdpvs	15, 5, cr5, cr5, cr11, {3}
     618:	6b636f6c 	blvs	18dc3d0 <__bss_end+0x18d3124>
     61c:	44006465 	strmi	r6, [r0], #-1125	; 0xfffffb9b
     620:	62617369 	rsbvs	r7, r1, #-1543503871	; 0xa4000001
     624:	455f656c 	ldrbmi	r6, [pc, #-1388]	; c0 <shift+0xc0>
     628:	746e6576 	strbtvc	r6, [lr], #-1398	; 0xfffffa8a
     62c:	7465445f 	strbtvc	r4, [r5], #-1119	; 0xfffffba1
     630:	69746365 	ldmdbvs	r4!, {r0, r2, r5, r6, r8, r9, sp, lr}^
     634:	4d006e6f 	stcmi	14, cr6, [r0, #-444]	; 0xfffffe44
     638:	61507861 	cmpvs	r0, r1, ror #16
     63c:	654c6874 	strbvs	r6, [ip, #-2164]	; 0xfffff78c
     640:	6874676e 	ldmdavs	r4!, {r1, r2, r3, r5, r6, r8, r9, sl, sp, lr}^
     644:	67726100 	ldrbvs	r6, [r2, -r0, lsl #2]!
     648:	52420063 	subpl	r0, r2, #99	; 0x63
     64c:	3637355f 			; <UNDEFINED> instruction: 0x3637355f
     650:	53003030 	movwpl	r3, #48	; 0x30
     654:	505f7465 	subspl	r7, pc, r5, ror #8
     658:	6d617261 	sfmvs	f7, 2, [r1, #-388]!	; 0xfffffe7c
     65c:	68730073 	ldmdavs	r3!, {r0, r1, r4, r5, r6}^
     660:	2074726f 	rsbscs	r7, r4, pc, ror #4
     664:	00746e69 	rsbseq	r6, r4, r9, ror #28
     668:	5f676962 	svcpl	0x00676962
     66c:	00667562 	rsbeq	r7, r6, r2, ror #10
     670:	76677261 	strbtvc	r7, [r7], -r1, ror #4
     674:	72617000 	rsbvc	r7, r1, #0
     678:	00736d61 	rsbseq	r6, r3, r1, ror #26
     67c:	434f494e 	movtmi	r4, #63822	; 0xf94e
     680:	4f5f6c74 	svcmi	0x005f6c74
     684:	61726570 	cmnvs	r2, r0, ror r5
     688:	6e6f6974 			; <UNDEFINED> instruction: 0x6e6f6974
     68c:	6e697500 	cdpvs	5, 6, cr7, cr9, cr0, {0}
     690:	5f323374 	svcpl	0x00323374
     694:	6f6c0074 	svcvs	0x006c0074
     698:	70697067 	rsbvc	r7, r9, r7, rrx
     69c:	55540065 	ldrbpl	r0, [r4, #-101]	; 0xffffff9b
     6a0:	5f545241 	svcpl	0x00545241
     6a4:	74434f49 	strbvc	r4, [r3], #-3913	; 0xfffff0b7
     6a8:	61505f6c 	cmpvs	r0, ip, ror #30
     6ac:	736d6172 	cmnvc	sp, #-2147483620	; 0x8000001c
     6b0:	63697400 	cmnvs	r9, #0, 8
     6b4:	6675626b 	ldrbtvs	r6, [r5], -fp, ror #4
     6b8:	63695400 	cmnvs	r9, #0, 8
     6bc:	6f435f6b 	svcvs	0x00435f6b
     6c0:	00746e75 	rsbseq	r6, r4, r5, ror lr
     6c4:	6573552f 	ldrbvs	r5, [r3, #-1327]!	; 0xfffffad1
     6c8:	772f7372 			; <UNDEFINED> instruction: 0x772f7372
     6cc:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
     6d0:	2f696a72 	svccs	0x00696a72
     6d4:	6b736544 	blvs	1cd9bec <__bss_end+0x1cd0940>
     6d8:	2f706f74 	svccs	0x00706f74
     6dc:	2f564146 	svccs	0x00564146
     6e0:	6176614e 	cmnvs	r6, lr, asr #2
     6e4:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
     6e8:	4f2f6963 	svcmi	0x002f6963
     6ec:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
     6f0:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
     6f4:	6b6c6172 	blvs	1b18cc4 <__bss_end+0x1b0fa18>
     6f8:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
     6fc:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
     700:	756f732f 	strbvc	r7, [pc, #-815]!	; 3d9 <shift+0x3d9>
     704:	73656372 	cmnvc	r5, #-939524095	; 0xc8000001
     708:	6975622f 	ldmdbvs	r5!, {r0, r1, r2, r3, r5, r9, sp, lr}^
     70c:	4f00646c 	svcmi	0x0000646c
     710:	006e6570 	rsbeq	r6, lr, r0, ror r5
     714:	314e5a5f 	cmpcc	lr, pc, asr sl
     718:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     71c:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     720:	614d5f73 	hvcvs	54771	; 0xd5f3
     724:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     728:	42313272 	eorsmi	r3, r1, #536870919	; 0x20000007
     72c:	6b636f6c 	blvs	18dc4e4 <__bss_end+0x18d3238>
     730:	7275435f 	rsbsvc	r4, r5, #2080374785	; 0x7c000001
     734:	746e6572 	strbtvc	r6, [lr], #-1394	; 0xfffffa8e
     738:	6f72505f 	svcvs	0x0072505f
     73c:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     740:	63007645 	movwvs	r7, #1605	; 0x645
     744:	65736f6c 	ldrbvs	r6, [r3, #-3948]!	; 0xfffff094
     748:	65727000 	ldrbvs	r7, [r2, #-0]!
     74c:	65530076 	ldrbvs	r0, [r3, #-118]	; 0xffffff8a
     750:	65525f74 	ldrbvs	r5, [r2, #-3956]	; 0xfffff08c
     754:	6974616c 	ldmdbvs	r4!, {r2, r3, r5, r6, r8, sp, lr}^
     758:	55006576 	strpl	r6, [r0, #-1398]	; 0xfffffa8a
     75c:	70616d6e 	rsbvc	r6, r1, lr, ror #26
     760:	6c69465f 	stclvs	6, cr4, [r9], #-380	; 0xfffffe84
     764:	75435f65 	strbvc	r5, [r3, #-3941]	; 0xfffff09b
     768:	6e657272 	mcrvs	2, 3, r7, cr5, cr2, {3}
     76c:	65720074 	ldrbvs	r0, [r2, #-116]!	; 0xffffff8c
     770:	6c617674 	stclvs	6, cr7, [r1], #-464	; 0xfffffe30
     774:	75636e00 	strbvc	r6, [r3, #-3584]!	; 0xfffff200
     778:	506d0072 	rsbpl	r0, sp, r2, ror r0
     77c:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     780:	4c5f7373 	mrrcmi	3, 7, r7, pc, cr3	; <UNPREDICTABLE>
     784:	5f747369 	svcpl	0x00747369
     788:	64616548 	strbtvs	r6, [r1], #-1352	; 0xfffffab8
     78c:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     790:	4336314b 	teqmi	r6, #-1073741806	; 0xc0000012
     794:	636f7250 	cmnvs	pc, #80, 4
     798:	5f737365 	svcpl	0x00737365
     79c:	616e614d 	cmnvs	lr, sp, asr #2
     7a0:	31726567 	cmncc	r2, r7, ror #10
     7a4:	74654739 	strbtvc	r4, [r5], #-1849	; 0xfffff8c7
     7a8:	7275435f 	rsbsvc	r4, r5, #2080374785	; 0x7c000001
     7ac:	746e6572 	strbtvc	r6, [lr], #-1394	; 0xfffffa8e
     7b0:	6f72505f 	svcvs	0x0072505f
     7b4:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     7b8:	72007645 	andvc	r7, r0, #72351744	; 0x4500000
     7bc:	6d756e64 	ldclvs	14, cr6, [r5, #-400]!	; 0xfffffe70
     7c0:	78656e00 	stmdavc	r5!, {r9, sl, fp, sp, lr}^
     7c4:	65470074 	strbvs	r0, [r7, #-116]	; 0xffffff8c
     7c8:	72505f74 	subsvc	r5, r0, #116, 30	; 0x1d0
     7cc:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     7d0:	79425f73 	stmdbvc	r2, {r0, r1, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     7d4:	4449505f 	strbmi	r5, [r9], #-95	; 0xffffffa1
     7d8:	315a5f00 	cmpcc	sl, r0, lsl #30
     7dc:	68637331 	stmdavs	r3!, {r0, r4, r5, r8, r9, ip, sp, lr}^
     7e0:	795f6465 	ldmdbvc	pc, {r0, r2, r5, r6, sl, sp, lr}^	; <UNPREDICTABLE>
     7e4:	646c6569 	strbtvs	r6, [ip], #-1385	; 0xfffffa97
     7e8:	534e0076 	movtpl	r0, #57462	; 0xe076
     7ec:	505f4957 	subspl	r4, pc, r7, asr r9	; <UNPREDICTABLE>
     7f0:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     7f4:	535f7373 	cmppl	pc, #-872415231	; 0xcc000001
     7f8:	69767265 	ldmdbvs	r6!, {r0, r2, r5, r6, r9, ip, sp, lr}^
     7fc:	52006563 	andpl	r6, r0, #415236096	; 0x18c00000
     800:	00646165 	rsbeq	r6, r4, r5, ror #2
     804:	69746341 	ldmdbvs	r4!, {r0, r6, r8, r9, sp, lr}^
     808:	505f6576 	subspl	r6, pc, r6, ror r5	; <UNPREDICTABLE>
     80c:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     810:	435f7373 	cmpmi	pc, #-872415231	; 0xcc000001
     814:	746e756f 	strbtvc	r7, [lr], #-1391	; 0xfffffa91
     818:	65724300 	ldrbvs	r4, [r2, #-768]!	; 0xfffffd00
     81c:	5f657461 	svcpl	0x00657461
     820:	636f7250 	cmnvs	pc, #80, 4
     824:	00737365 	rsbseq	r7, r3, r5, ror #6
     828:	37315a5f 			; <UNDEFINED> instruction: 0x37315a5f
     82c:	5f746573 	svcpl	0x00746573
     830:	6b736174 	blvs	1cd8e08 <__bss_end+0x1ccfb5c>
     834:	6165645f 	cmnvs	r5, pc, asr r4
     838:	6e696c64 	cdpvs	12, 6, cr6, cr9, cr4, {3}
     83c:	77006a65 	strvc	r6, [r0, -r5, ror #20]
     840:	00746961 	rsbseq	r6, r4, r1, ror #18
     844:	74617473 	strbtvc	r7, [r1], #-1139	; 0xfffffb8d
     848:	5a5f0065 	bpl	17c09e4 <__bss_end+0x17b7738>
     84c:	746f6e36 	strbtvc	r6, [pc], #-3638	; 854 <shift+0x854>
     850:	6a796669 	bvs	1e5a1fc <__bss_end+0x1e50f50>
     854:	6547006a 	strbvs	r0, [r7, #-106]	; 0xffffff96
     858:	63535f74 	cmpvs	r3, #116, 30	; 0x1d0
     85c:	75646568 	strbvc	r6, [r4, #-1384]!	; 0xfffffa98
     860:	5f72656c 	svcpl	0x0072656c
     864:	6f666e49 	svcvs	0x00666e49
     868:	72504300 	subsvc	r4, r0, #0, 6
     86c:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     870:	614d5f73 	hvcvs	54771	; 0xd5f3
     874:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     878:	5a5f0072 	bpl	17c0a48 <__bss_end+0x17b779c>
     87c:	4336314e 	teqmi	r6, #-2147483629	; 0x80000013
     880:	636f7250 	cmnvs	pc, #80, 4
     884:	5f737365 	svcpl	0x00737365
     888:	616e614d 	cmnvs	lr, sp, asr #2
     88c:	31726567 	cmncc	r2, r7, ror #10
     890:	74654738 	strbtvc	r4, [r5], #-1848	; 0xfffff8c8
     894:	6863535f 	stmdavs	r3!, {r0, r1, r2, r3, r4, r6, r8, r9, ip, lr}^
     898:	6c756465 	cfldrdvs	mvd6, [r5], #-404	; 0xfffffe6c
     89c:	495f7265 	ldmdbmi	pc, {r0, r2, r5, r6, r9, ip, sp, lr}^	; <UNPREDICTABLE>
     8a0:	456f666e 	strbmi	r6, [pc, #-1646]!	; 23a <shift+0x23a>
     8a4:	474e3032 	smlaldxmi	r3, lr, r2, r0
     8a8:	535f7465 	cmppl	pc, #1694498816	; 0x65000000
     8ac:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     8b0:	666e495f 			; <UNDEFINED> instruction: 0x666e495f
     8b4:	79545f6f 	ldmdbvc	r4, {r0, r1, r2, r3, r5, r6, r8, r9, sl, fp, ip, lr}^
     8b8:	76506570 			; <UNDEFINED> instruction: 0x76506570
     8bc:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     8c0:	50433631 	subpl	r3, r3, r1, lsr r6
     8c4:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     8c8:	4d5f7373 	ldclmi	3, cr7, [pc, #-460]	; 704 <shift+0x704>
     8cc:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
     8d0:	31327265 	teqcc	r2, r5, ror #4
     8d4:	646e6148 	strbtvs	r6, [lr], #-328	; 0xfffffeb8
     8d8:	465f656c 	ldrbmi	r6, [pc], -ip, ror #10
     8dc:	73656c69 	cmnvc	r5, #26880	; 0x6900
     8e0:	65747379 	ldrbvs	r7, [r4, #-889]!	; 0xfffffc87
     8e4:	57535f6d 	ldrbpl	r5, [r3, -sp, ror #30]
     8e8:	33324549 	teqcc	r2, #306184192	; 0x12400000
     8ec:	4957534e 	ldmdbmi	r7, {r1, r2, r3, r6, r8, r9, ip, lr}^
     8f0:	6c69465f 	stclvs	6, cr4, [r9], #-380	; 0xfffffe84
     8f4:	73797365 	cmnvc	r9, #-1811939327	; 0x94000001
     8f8:	5f6d6574 	svcpl	0x006d6574
     8fc:	76726553 			; <UNDEFINED> instruction: 0x76726553
     900:	6a656369 	bvs	19596ac <__bss_end+0x1950400>
     904:	31526a6a 	cmpcc	r2, sl, ror #20
     908:	57535431 	smmlarpl	r3, r1, r4, r5
     90c:	65525f49 	ldrbvs	r5, [r2, #-3913]	; 0xfffff0b7
     910:	746c7573 	strbtvc	r7, [ip], #-1395	; 0xfffffa8d
     914:	65706f00 	ldrbvs	r6, [r0, #-3840]!	; 0xfffff100
     918:	5f64656e 	svcpl	0x0064656e
     91c:	656c6966 	strbvs	r6, [ip, #-2406]!	; 0xfffff69a
     920:	61460073 	hvcvs	24579	; 0x6003
     924:	54006c69 	strpl	r6, [r0], #-3177	; 0xfffff397
     928:	5f555043 	svcpl	0x00555043
     92c:	746e6f43 	strbtvc	r6, [lr], #-3907	; 0xfffff0bd
     930:	00747865 	rsbseq	r7, r4, r5, ror #16
     934:	64616544 	strbtvs	r6, [r1], #-1348	; 0xfffffabc
     938:	656e696c 	strbvs	r6, [lr, #-2412]!	; 0xfffff694
     93c:	69786500 	ldmdbvs	r8!, {r8, sl, sp, lr}^
     940:	646f6374 	strbtvs	r6, [pc], #-884	; 948 <shift+0x948>
     944:	74740065 	ldrbtvc	r0, [r4], #-101	; 0xffffff9b
     948:	00307262 	eorseq	r7, r0, r2, ror #4
     94c:	314e5a5f 	cmpcc	lr, pc, asr sl
     950:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     954:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     958:	614d5f73 	hvcvs	54771	; 0xd5f3
     95c:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     960:	4e343172 	mrcmi	1, 1, r3, cr4, cr2, {3}
     964:	6669746f 	strbtvs	r7, [r9], -pc, ror #8
     968:	72505f79 	subsvc	r5, r0, #484	; 0x1e4
     96c:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     970:	006a4573 	rsbeq	r4, sl, r3, ror r5
     974:	5f746547 	svcpl	0x00746547
     978:	00444950 	subeq	r4, r4, r0, asr r9
     97c:	69746f6e 	ldmdbvs	r4!, {r1, r2, r3, r5, r6, r8, r9, sl, fp, sp, lr}^
     980:	64656966 	strbtvs	r6, [r5], #-2406	; 0xfffff69a
     984:	6165645f 	cmnvs	r5, pc, asr r4
     988:	6e696c64 	cdpvs	12, 6, cr6, cr9, cr4, {3}
     98c:	5a5f0065 	bpl	17c0b28 <__bss_end+0x17b787c>
     990:	4336314e 	teqmi	r6, #-2147483629	; 0x80000013
     994:	636f7250 	cmnvs	pc, #80, 4
     998:	5f737365 	svcpl	0x00737365
     99c:	616e614d 	cmnvs	lr, sp, asr #2
     9a0:	31726567 	cmncc	r2, r7, ror #10
     9a4:	6d6e5538 	cfstr64vs	mvdx5, [lr, #-224]!	; 0xffffff20
     9a8:	465f7061 	ldrbmi	r7, [pc], -r1, rrx
     9ac:	5f656c69 	svcpl	0x00656c69
     9b0:	72727543 	rsbsvc	r7, r2, #281018368	; 0x10c00000
     9b4:	45746e65 	ldrbmi	r6, [r4, #-3685]!	; 0xfffff19b
     9b8:	5a5f006a 	bpl	17c0b68 <__bss_end+0x17b78bc>
     9bc:	4336314e 	teqmi	r6, #-2147483629	; 0x80000013
     9c0:	636f7250 	cmnvs	pc, #80, 4
     9c4:	5f737365 	svcpl	0x00737365
     9c8:	616e614d 	cmnvs	lr, sp, asr #2
     9cc:	31726567 	cmncc	r2, r7, ror #10
     9d0:	746f4e34 	strbtvc	r4, [pc], #-3636	; 9d8 <shift+0x9d8>
     9d4:	5f796669 	svcpl	0x00796669
     9d8:	636f7250 	cmnvs	pc, #80, 4
     9dc:	45737365 	ldrbmi	r7, [r3, #-869]!	; 0xfffffc9b
     9e0:	54323150 	ldrtpl	r3, [r2], #-336	; 0xfffffeb0
     9e4:	6b736154 	blvs	1cd8f3c <__bss_end+0x1ccfc90>
     9e8:	7274535f 	rsbsvc	r5, r4, #2080374785	; 0x7c000001
     9ec:	00746375 	rsbseq	r6, r4, r5, ror r3
     9f0:	65686373 	strbvs	r6, [r8, #-883]!	; 0xfffffc8d
     9f4:	69795f64 	ldmdbvs	r9!, {r2, r5, r6, r8, r9, sl, fp, ip, lr}^
     9f8:	00646c65 	rsbeq	r6, r4, r5, ror #24
     9fc:	6b636974 	blvs	18dafd4 <__bss_end+0x18d1d28>
     a00:	756f635f 	strbvc	r6, [pc, #-863]!	; 6a9 <shift+0x6a9>
     a04:	725f746e 	subsvc	r7, pc, #1845493760	; 0x6e000000
     a08:	69757165 	ldmdbvs	r5!, {r0, r2, r5, r6, r8, ip, sp, lr}^
     a0c:	00646572 	rsbeq	r6, r4, r2, ror r5
     a10:	34325a5f 	ldrtcc	r5, [r2], #-2655	; 0xfffff5a1
     a14:	5f746567 	svcpl	0x00746567
     a18:	69746361 	ldmdbvs	r4!, {r0, r5, r6, r8, r9, sp, lr}^
     a1c:	705f6576 	subsvc	r6, pc, r6, ror r5	; <UNPREDICTABLE>
     a20:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     a24:	635f7373 	cmpvs	pc, #-872415231	; 0xcc000001
     a28:	746e756f 	strbtvc	r7, [lr], #-1391	; 0xfffffa91
     a2c:	65470076 	strbvs	r0, [r7, #-118]	; 0xffffff8a
     a30:	75435f74 	strbvc	r5, [r3, #-3956]	; 0xfffff08c
     a34:	6e657272 	mcrvs	2, 3, r7, cr5, cr2, {3}
     a38:	72505f74 	subsvc	r5, r0, #116, 30	; 0x1d0
     a3c:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     a40:	69500073 	ldmdbvs	r0, {r0, r1, r4, r5, r6}^
     a44:	465f6570 			; <UNDEFINED> instruction: 0x465f6570
     a48:	5f656c69 	svcpl	0x00656c69
     a4c:	66657250 			; <UNDEFINED> instruction: 0x66657250
     a50:	4d007869 	stcmi	8, cr7, [r0, #-420]	; 0xfffffe5c
     a54:	465f7061 	ldrbmi	r7, [pc], -r1, rrx
     a58:	5f656c69 	svcpl	0x00656c69
     a5c:	435f6f54 	cmpmi	pc, #84, 30	; 0x150
     a60:	65727275 	ldrbvs	r7, [r2, #-629]!	; 0xfffffd8b
     a64:	5f00746e 	svcpl	0x0000746e
     a68:	6734315a 			; <UNDEFINED> instruction: 0x6734315a
     a6c:	745f7465 	ldrbvc	r7, [pc], #-1125	; a74 <shift+0xa74>
     a70:	5f6b6369 	svcpl	0x006b6369
     a74:	6e756f63 	cdpvs	15, 7, cr6, cr5, cr3, {3}
     a78:	48007674 	stmdami	r0, {r2, r4, r5, r6, r9, sl, ip, sp, lr}
     a7c:	6c646e61 	stclvs	14, cr6, [r4], #-388	; 0xfffffe7c
     a80:	72505f65 	subsvc	r5, r0, #404	; 0x194
     a84:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     a88:	57535f73 			; <UNDEFINED> instruction: 0x57535f73
     a8c:	6c730049 	ldclvs	0, cr0, [r3], #-292	; 0xfffffedc
     a90:	00706565 	rsbseq	r6, r0, r5, ror #10
     a94:	65686353 	strbvs	r6, [r8, #-851]!	; 0xfffffcad
     a98:	656c7564 	strbvs	r7, [ip, #-1380]!	; 0xfffffa9c
     a9c:	4644455f 			; <UNDEFINED> instruction: 0x4644455f
     aa0:	69615700 	stmdbvs	r1!, {r8, r9, sl, ip, lr}^
     aa4:	5a5f0074 	bpl	17c0c7c <__bss_end+0x17b79d0>
     aa8:	72657439 	rsbvc	r7, r5, #956301312	; 0x39000000
     aac:	616e696d 	cmnvs	lr, sp, ror #18
     ab0:	00696574 	rsbeq	r6, r9, r4, ror r5
     ab4:	65746e49 	ldrbvs	r6, [r4, #-3657]!	; 0xfffff1b7
     ab8:	70757272 	rsbsvc	r7, r5, r2, ror r2
     abc:	6c626174 	stfvse	f6, [r2], #-464	; 0xfffffe30
     ac0:	6c535f65 	mrrcvs	15, 6, r5, r3, cr5
     ac4:	00706565 	rsbseq	r6, r0, r5, ror #10
     ac8:	7265706f 	rsbvc	r7, r5, #111	; 0x6f
     acc:	6f697461 	svcvs	0x00697461
     ad0:	5a5f006e 	bpl	17c0c90 <__bss_end+0x17b79e4>
     ad4:	6f6c6335 	svcvs	0x006c6335
     ad8:	006a6573 	rsbeq	r6, sl, r3, ror r5
     adc:	73614c6d 	cmnvc	r1, #27904	; 0x6d00
     ae0:	49505f74 	ldmdbmi	r0, {r2, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     ae4:	6c420044 	mcrrvs	0, 4, r0, r2, cr4
     ae8:	656b636f 	strbvs	r6, [fp, #-879]!	; 0xfffffc91
     aec:	474e0064 	strbmi	r0, [lr, -r4, rrx]
     af0:	535f7465 	cmppl	pc, #1694498816	; 0x65000000
     af4:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     af8:	666e495f 			; <UNDEFINED> instruction: 0x666e495f
     afc:	79545f6f 	ldmdbvc	r4, {r0, r1, r2, r3, r5, r6, r8, r9, sl, fp, ip, lr}^
     b00:	5f006570 	svcpl	0x00006570
     b04:	6567365a 	strbvs	r3, [r7, #-1626]!	; 0xfffff9a6
     b08:	64697074 	strbtvs	r7, [r9], #-116	; 0xffffff8c
     b0c:	6e660076 	mcrvs	0, 3, r0, cr6, cr6, {3}
     b10:	00656d61 	rsbeq	r6, r5, r1, ror #26
     b14:	6e6e7552 	mcrvs	5, 3, r7, cr14, cr2, {2}
     b18:	656c6261 	strbvs	r6, [ip, #-609]!	; 0xfffffd9f
     b1c:	61544e00 	cmpvs	r4, r0, lsl #28
     b20:	535f6b73 	cmppl	pc, #117760	; 0x1cc00
     b24:	65746174 	ldrbvs	r6, [r4, #-372]!	; 0xfffffe8c
     b28:	68637300 	stmdavs	r3!, {r8, r9, ip, sp, lr}^
     b2c:	635f6465 	cmpvs	pc, #1694498816	; 0x65000000
     b30:	746e756f 	strbtvc	r7, [lr], #-1391	; 0xfffffa91
     b34:	73007265 	movwvc	r7, #613	; 0x265
     b38:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     b3c:	6174735f 	cmnvs	r4, pc, asr r3
     b40:	5f636974 	svcpl	0x00636974
     b44:	6f697270 	svcvs	0x00697270
     b48:	79746972 	ldmdbvc	r4!, {r1, r4, r5, r6, r8, fp, sp, lr}^
     b4c:	69727700 	ldmdbvs	r2!, {r8, r9, sl, ip, sp, lr}^
     b50:	65006574 	strvs	r6, [r0, #-1396]	; 0xfffffa8c
     b54:	5f746978 	svcpl	0x00746978
     b58:	65646f63 	strbvs	r6, [r4, #-3939]!	; 0xfffff09d
     b5c:	63697400 	cmnvs	r9, #0, 8
     b60:	6d00736b 	stcvs	3, cr7, [r0, #-428]	; 0xfffffe54
     b64:	65686353 	strbvs	r6, [r8, #-851]!	; 0xfffffcad
     b68:	656c7564 	strbvs	r7, [ip, #-1380]!	; 0xfffffa9c
     b6c:	636e465f 	cmnvs	lr, #99614720	; 0x5f00000
     b70:	65706f00 	ldrbvs	r6, [r0, #-3840]!	; 0xfffff100
     b74:	5a5f006e 	bpl	17c0d34 <__bss_end+0x17b7a88>
     b78:	70697034 	rsbvc	r7, r9, r4, lsr r0
     b7c:	634b5065 	movtvs	r5, #45157	; 0xb065
     b80:	444e006a 	strbmi	r0, [lr], #-106	; 0xffffff96
     b84:	6c646165 	stfvse	f6, [r4], #-404	; 0xfffffe6c
     b88:	5f656e69 	svcpl	0x00656e69
     b8c:	73627553 	cmnvc	r2, #348127232	; 0x14c00000
     b90:	69767265 	ldmdbvs	r6!, {r0, r2, r5, r6, r9, ip, sp, lr}^
     b94:	67006563 	strvs	r6, [r0, -r3, ror #10]
     b98:	745f7465 	ldrbvc	r7, [pc], #-1125	; ba0 <shift+0xba0>
     b9c:	5f6b6369 	svcpl	0x006b6369
     ba0:	6e756f63 	cdpvs	15, 7, cr6, cr5, cr3, {3}
     ba4:	6f4e0074 	svcvs	0x004e0074
     ba8:	79666974 	stmdbvc	r6!, {r2, r4, r5, r6, r8, fp, sp, lr}^
     bac:	72617000 	rsbvc	r7, r1, #0
     bb0:	5f006d61 	svcpl	0x00006d61
     bb4:	7277355a 	rsbsvc	r3, r7, #377487360	; 0x16800000
     bb8:	6a657469 	bvs	195dd64 <__bss_end+0x1954ab8>
     bbc:	6a634b50 	bvs	18d3904 <__bss_end+0x18ca658>
     bc0:	74656700 	strbtvc	r6, [r5], #-1792	; 0xfffff900
     bc4:	7361745f 	cmnvc	r1, #1593835520	; 0x5f000000
     bc8:	69745f6b 	ldmdbvs	r4!, {r0, r1, r3, r5, r6, r8, r9, sl, fp, ip, lr}^
     bcc:	5f736b63 	svcpl	0x00736b63
     bd0:	645f6f74 	ldrbvs	r6, [pc], #-3956	; bd8 <shift+0xbd8>
     bd4:	6c646165 	stfvse	f6, [r4], #-404	; 0xfffffe6c
     bd8:	00656e69 	rsbeq	r6, r5, r9, ror #28
     bdc:	5f667562 	svcpl	0x00667562
     be0:	657a6973 	ldrbvs	r6, [sl, #-2419]!	; 0xfffff68d
     be4:	6d6f5a00 	vstmdbvs	pc!, {s11-s10}
     be8:	00656962 	rsbeq	r6, r5, r2, ror #18
     bec:	5f746547 	svcpl	0x00746547
     bf0:	65686353 	strbvs	r6, [r8, #-851]!	; 0xfffffcad
     bf4:	6e495f64 	cdpvs	15, 4, cr5, cr9, cr4, {3}
     bf8:	73006f66 	movwvc	r6, #3942	; 0xf66
     bfc:	745f7465 	ldrbvc	r7, [pc], #-1125	; c04 <shift+0xc04>
     c00:	5f6b7361 	svcpl	0x006b7361
     c04:	64616564 	strbtvs	r6, [r1], #-1380	; 0xfffffa9c
     c08:	656e696c 	strbvs	r6, [lr, #-2412]!	; 0xfffff694
     c0c:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     c10:	50433631 	subpl	r3, r3, r1, lsr r6
     c14:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     c18:	4d5f7373 	ldclmi	3, cr7, [pc, #-460]	; a54 <shift+0xa54>
     c1c:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
     c20:	53387265 	teqpl	r8, #1342177286	; 0x50000006
     c24:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     c28:	45656c75 	strbmi	r6, [r5, #-3189]!	; 0xfffff38b
     c2c:	5a5f0076 	bpl	17c0e0c <__bss_end+0x17b7b60>
     c30:	4336314e 	teqmi	r6, #-2147483629	; 0x80000013
     c34:	636f7250 	cmnvs	pc, #80, 4
     c38:	5f737365 	svcpl	0x00737365
     c3c:	616e614d 	cmnvs	lr, sp, asr #2
     c40:	31726567 	cmncc	r2, r7, ror #10
     c44:	70614d39 	rsbvc	r4, r1, r9, lsr sp
     c48:	6c69465f 	stclvs	6, cr4, [r9], #-380	; 0xfffffe84
     c4c:	6f545f65 	svcvs	0x00545f65
     c50:	7275435f 	rsbsvc	r4, r5, #2080374785	; 0x7c000001
     c54:	746e6572 	strbtvc	r6, [lr], #-1394	; 0xfffffa8e
     c58:	49355045 	ldmdbmi	r5!, {r0, r2, r6, ip, lr}
     c5c:	656c6946 	strbvs	r6, [ip, #-2374]!	; 0xfffff6ba
     c60:	73552f00 	cmpvc	r5, #0, 30
     c64:	2f737265 	svccs	0x00737265
     c68:	746e6977 	strbtvc	r6, [lr], #-2423	; 0xfffff689
     c6c:	696a7265 	stmdbvs	sl!, {r0, r2, r5, r6, r9, ip, sp, lr}^
     c70:	7365442f 	cmnvc	r5, #788529152	; 0x2f000000
     c74:	706f746b 	rsbvc	r7, pc, fp, ror #8
     c78:	5641462f 	strbpl	r4, [r1], -pc, lsr #12
     c7c:	76614e2f 	strbtvc	r4, [r1], -pc, lsr #28
     c80:	6a757a61 	bvs	1d5f60c <__bss_end+0x1d56360>
     c84:	2f696369 	svccs	0x00696369
     c88:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
     c8c:	73656d65 	cmnvc	r5, #6464	; 0x1940
     c90:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
     c94:	6b2d616b 	blvs	b59248 <__bss_end+0xb4ff9c>
     c98:	6f2d7669 	svcvs	0x002d7669
     c9c:	6f732f73 	svcvs	0x00732f73
     ca0:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
     ca4:	74732f73 	ldrbtvc	r2, [r3], #-3955	; 0xfffff08d
     ca8:	62696c64 	rsbvs	r6, r9, #100, 24	; 0x6400
     cac:	6372732f 	cmnvs	r2, #-1140850688	; 0xbc000000
     cb0:	6474732f 	ldrbtvs	r7, [r4], #-815	; 0xfffffcd1
     cb4:	656c6966 	strbvs	r6, [ip, #-2406]!	; 0xfffff69a
     cb8:	7070632e 	rsbsvc	r6, r0, lr, lsr #6
     cbc:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     cc0:	50433631 	subpl	r3, r3, r1, lsr r6
     cc4:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     cc8:	4d5f7373 	ldclmi	3, cr7, [pc, #-460]	; b04 <shift+0xb04>
     ccc:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
     cd0:	32317265 	eorscc	r7, r1, #1342177286	; 0x50000006
     cd4:	65686353 	strbvs	r6, [r8, #-851]!	; 0xfffffcad
     cd8:	656c7564 	strbvs	r7, [ip, #-1380]!	; 0xfffffa9c
     cdc:	4644455f 			; <UNDEFINED> instruction: 0x4644455f
     ce0:	5f007645 	svcpl	0x00007645
     ce4:	6c73355a 	cfldr64vs	mvdx3, [r3], #-360	; 0xfffffe98
     ce8:	6a706565 	bvs	1c1a284 <__bss_end+0x1c10fd8>
     cec:	6547006a 	strbvs	r0, [r7, #-106]	; 0xffffff96
     cf0:	65525f74 	ldrbvs	r5, [r2, #-3956]	; 0xfffff08c
     cf4:	6e69616d 	powvsez	f6, f1, #5.0
     cf8:	00676e69 	rsbeq	r6, r7, r9, ror #28
     cfc:	36325a5f 			; <UNDEFINED> instruction: 0x36325a5f
     d00:	5f746567 	svcpl	0x00746567
     d04:	6b736174 	blvs	1cd92dc <__bss_end+0x1cd0030>
     d08:	6369745f 	cmnvs	r9, #1593835520	; 0x5f000000
     d0c:	745f736b 	ldrbvc	r7, [pc], #-875	; d14 <shift+0xd14>
     d10:	65645f6f 	strbvs	r5, [r4, #-3951]!	; 0xfffff091
     d14:	696c6461 	stmdbvs	ip!, {r0, r5, r6, sl, sp, lr}^
     d18:	0076656e 	rsbseq	r6, r6, lr, ror #10
     d1c:	4957534e 	ldmdbmi	r7, {r1, r2, r3, r6, r8, r9, ip, lr}^
     d20:	7365525f 	cmnvc	r5, #-268435451	; 0xf0000005
     d24:	5f746c75 	svcpl	0x00746c75
     d28:	65646f43 	strbvs	r6, [r4, #-3907]!	; 0xfffff0bd
     d2c:	6e755200 	cdpvs	2, 7, cr5, cr5, cr0, {0}
     d30:	676e696e 	strbvs	r6, [lr, -lr, ror #18]!
     d34:	6e727700 	cdpvs	7, 7, cr7, cr2, cr0, {0}
     d38:	5f006d75 	svcpl	0x00006d75
     d3c:	6177345a 	cmnvs	r7, sl, asr r4
     d40:	6a6a7469 	bvs	1a9deec <__bss_end+0x1a94c40>
     d44:	5a5f006a 	bpl	17c0ef4 <__bss_end+0x17b7c48>
     d48:	636f6935 	cmnvs	pc, #868352	; 0xd4000
     d4c:	316a6c74 	smccc	42692	; 0xa6c4
     d50:	4f494e36 	svcmi	0x00494e36
     d54:	5f6c7443 	svcpl	0x006c7443
     d58:	7265704f 	rsbvc	r7, r5, #79	; 0x4f
     d5c:	6f697461 	svcvs	0x00697461
     d60:	0076506e 	rsbseq	r5, r6, lr, rrx
     d64:	74636f69 	strbtvc	r6, [r3], #-3945	; 0xfffff097
     d68:	6572006c 	ldrbvs	r0, [r2, #-108]!	; 0xffffff94
     d6c:	746e6374 	strbtvc	r6, [lr], #-884	; 0xfffffc8c
     d70:	75436d00 	strbvc	r6, [r3, #-3328]	; 0xfffff300
     d74:	6e657272 	mcrvs	2, 3, r7, cr5, cr2, {3}
     d78:	61545f74 	cmpvs	r4, r4, ror pc
     d7c:	4e5f6b73 	vmovmi.s8	r6, d15[3]
     d80:	0065646f 	rsbeq	r6, r5, pc, ror #8
     d84:	69746f6e 	ldmdbvs	r4!, {r1, r2, r3, r5, r6, r8, r9, sl, fp, sp, lr}^
     d88:	74007966 	strvc	r7, [r0], #-2406	; 0xfffff69a
     d8c:	696d7265 	stmdbvs	sp!, {r0, r2, r5, r6, r9, ip, sp, lr}^
     d90:	6574616e 	ldrbvs	r6, [r4, #-366]!	; 0xfffffe92
     d94:	646f6d00 	strbtvs	r6, [pc], #-3328	; d9c <shift+0xd9c>
     d98:	70630065 	rsbvc	r0, r3, r5, rrx
     d9c:	6f635f75 	svcvs	0x00635f75
     da0:	7865746e 	stmdavc	r5!, {r1, r2, r3, r5, r6, sl, ip, sp, lr}^
     da4:	75620074 	strbvc	r0, [r2, #-116]!	; 0xffffff8c
     da8:	72656666 	rsbvc	r6, r5, #106954752	; 0x6600000
     dac:	656c7300 	strbvs	r7, [ip, #-768]!	; 0xfffffd00
     db0:	745f7065 	ldrbvc	r7, [pc], #-101	; db8 <shift+0xdb8>
     db4:	72656d69 	rsbvc	r6, r5, #6720	; 0x1a40
     db8:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     dbc:	4336314b 	teqmi	r6, #-1073741806	; 0xc0000012
     dc0:	636f7250 	cmnvs	pc, #80, 4
     dc4:	5f737365 	svcpl	0x00737365
     dc8:	616e614d 	cmnvs	lr, sp, asr #2
     dcc:	31726567 	cmncc	r2, r7, ror #10
     dd0:	74654738 	strbtvc	r4, [r5], #-1848	; 0xfffff8c8
     dd4:	6f72505f 	svcvs	0x0072505f
     dd8:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     ddc:	5f79425f 	svcpl	0x0079425f
     de0:	45444950 	strbmi	r4, [r4, #-2384]	; 0xfffff6b0
     de4:	6148006a 	cmpvs	r8, sl, rrx
     de8:	656c646e 	strbvs	r6, [ip, #-1134]!	; 0xfffffb92
     dec:	6c69465f 	stclvs	6, cr4, [r9], #-380	; 0xfffffe84
     df0:	73797365 	cmnvc	r9, #-1811939327	; 0x94000001
     df4:	5f6d6574 	svcpl	0x006d6574
     df8:	00495753 	subeq	r5, r9, r3, asr r7
     dfc:	314e5a5f 	cmpcc	lr, pc, asr sl
     e00:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     e04:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     e08:	614d5f73 	hvcvs	54771	; 0xd5f3
     e0c:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     e10:	53313172 	teqpl	r1, #-2147483620	; 0x8000001c
     e14:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     e18:	5f656c75 	svcpl	0x00656c75
     e1c:	76455252 			; <UNDEFINED> instruction: 0x76455252
     e20:	73617400 	cmnvc	r1, #0, 8
     e24:	5a5f006b 	bpl	17c0fd8 <__bss_end+0x17b7d2c>
     e28:	61657234 	cmnvs	r5, r4, lsr r2
     e2c:	63506a64 	cmpvs	r0, #100, 20	; 0x64000
     e30:	6f4e006a 	svcvs	0x004e006a
     e34:	79666974 	stmdbvc	r6!, {r2, r4, r5, r6, r8, fp, sp, lr}^
     e38:	6f72505f 	svcvs	0x0072505f
     e3c:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     e40:	68635300 	stmdavs	r3!, {r8, r9, ip, lr}^
     e44:	6c756465 	cfldrdvs	mvd6, [r5], #-404	; 0xfffffe6c
     e48:	4e470065 	cdpmi	0, 4, cr0, cr7, cr5, {3}
     e4c:	2b432055 	blcs	10c8fa8 <__bss_end+0x10bfcfc>
     e50:	2034312b 	eorscs	r3, r4, fp, lsr #2
     e54:	332e3031 			; <UNDEFINED> instruction: 0x332e3031
     e58:	3220312e 	eorcc	r3, r0, #-2147483637	; 0x8000000b
     e5c:	30313230 	eorscc	r3, r1, r0, lsr r2
     e60:	20343238 	eorscs	r3, r4, r8, lsr r2
     e64:	6c657228 	sfmvs	f7, 2, [r5], #-160	; 0xffffff60
     e68:	65736165 	ldrbvs	r6, [r3, #-357]!	; 0xfffffe9b
     e6c:	6d2d2029 	stcvs	0, cr2, [sp, #-164]!	; 0xffffff5c
     e70:	616f6c66 	cmnvs	pc, r6, ror #24
     e74:	62612d74 	rsbvs	r2, r1, #116, 26	; 0x1d00
     e78:	61683d69 	cmnvs	r8, r9, ror #26
     e7c:	2d206472 	cfstrscs	mvf6, [r0, #-456]!	; 0xfffffe38
     e80:	7570666d 	ldrbvc	r6, [r0, #-1645]!	; 0xfffff993
     e84:	7066763d 	rsbvc	r7, r6, sp, lsr r6
     e88:	666d2d20 	strbtvs	r2, [sp], -r0, lsr #26
     e8c:	74616f6c 	strbtvc	r6, [r1], #-3948	; 0xfffff094
     e90:	6962612d 	stmdbvs	r2!, {r0, r2, r3, r5, r8, sp, lr}^
     e94:	7261683d 	rsbvc	r6, r1, #3997696	; 0x3d0000
     e98:	6d2d2064 	stcvs	0, cr2, [sp, #-400]!	; 0xfffffe70
     e9c:	3d757066 	ldclcc	0, cr7, [r5, #-408]!	; 0xfffffe68
     ea0:	20706676 	rsbscs	r6, r0, r6, ror r6
     ea4:	75746d2d 	ldrbvc	r6, [r4, #-3373]!	; 0xfffff2d3
     ea8:	613d656e 	teqvs	sp, lr, ror #10
     eac:	31316d72 	teqcc	r1, r2, ror sp
     eb0:	7a6a3637 	bvc	1a8e794 <__bss_end+0x1a854e8>
     eb4:	20732d66 	rsbscs	r2, r3, r6, ror #26
     eb8:	72616d2d 	rsbvc	r6, r1, #2880	; 0xb40
     ebc:	6d2d206d 	stcvs	0, cr2, [sp, #-436]!	; 0xfffffe4c
     ec0:	68637261 	stmdavs	r3!, {r0, r5, r6, r9, ip, sp, lr}^
     ec4:	6d72613d 	ldfvse	f6, [r2, #-244]!	; 0xffffff0c
     ec8:	6b7a3676 	blvs	1e8e8a8 <__bss_end+0x1e855fc>
     ecc:	2070662b 	rsbscs	r6, r0, fp, lsr #12
     ed0:	2d20672d 	stccs	7, cr6, [r0, #-180]!	; 0xffffff4c
     ed4:	672d2067 	strvs	r2, [sp, -r7, rrx]!
     ed8:	304f2d20 	subcc	r2, pc, r0, lsr #26
     edc:	304f2d20 	subcc	r2, pc, r0, lsr #26
     ee0:	6e662d20 	cdpvs	13, 6, cr2, cr6, cr0, {1}
     ee4:	78652d6f 	stmdavc	r5!, {r0, r1, r2, r3, r5, r6, r8, sl, fp, sp}^
     ee8:	74706563 	ldrbtvc	r6, [r0], #-1379	; 0xfffffa9d
     eec:	736e6f69 	cmnvc	lr, #420	; 0x1a4
     ef0:	6e662d20 	cdpvs	13, 6, cr2, cr6, cr0, {1}
     ef4:	74722d6f 	ldrbtvc	r2, [r2], #-3439	; 0xfffff291
     ef8:	5f006974 	svcpl	0x00006974
     efc:	36314e5a 			; <UNDEFINED> instruction: 0x36314e5a
     f00:	6f725043 	svcvs	0x00725043
     f04:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     f08:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     f0c:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     f10:	69775339 	ldmdbvs	r7!, {r0, r3, r4, r5, r8, r9, ip, lr}^
     f14:	5f686374 	svcpl	0x00686374
     f18:	50456f54 	subpl	r6, r5, r4, asr pc
     f1c:	50433831 	subpl	r3, r3, r1, lsr r8
     f20:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     f24:	4c5f7373 	mrrcmi	3, 7, r7, pc, cr3	; <UNPREDICTABLE>
     f28:	5f747369 	svcpl	0x00747369
     f2c:	65646f4e 	strbvs	r6, [r4, #-3918]!	; 0xfffff0b2
     f30:	68635300 	stmdavs	r3!, {r8, r9, ip, lr}^
     f34:	6c756465 	cfldrdvs	mvd6, [r5], #-404	; 0xfffffe6c
     f38:	52525f65 	subspl	r5, r2, #404	; 0x194
     f3c:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     f40:	50433631 	subpl	r3, r3, r1, lsr r6
     f44:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     f48:	4d5f7373 	ldclmi	3, cr7, [pc, #-460]	; d84 <shift+0xd84>
     f4c:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
     f50:	38317265 	ldmdacc	r1!, {r0, r2, r5, r6, r9, ip, sp, lr}
     f54:	646e6148 	strbtvs	r6, [lr], #-328	; 0xfffffeb8
     f58:	505f656c 	subspl	r6, pc, ip, ror #10
     f5c:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     f60:	535f7373 	cmppl	pc, #-872415231	; 0xcc000001
     f64:	32454957 	subcc	r4, r5, #1425408	; 0x15c000
     f68:	57534e30 	smmlarpl	r3, r0, lr, r4
     f6c:	72505f49 	subsvc	r5, r0, #292	; 0x124
     f70:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     f74:	65535f73 	ldrbvs	r5, [r3, #-3955]	; 0xfffff08d
     f78:	63697672 	cmnvs	r9, #119537664	; 0x7200000
     f7c:	6a6a6a65 	bvs	1a9b918 <__bss_end+0x1a9266c>
     f80:	54313152 	ldrtpl	r3, [r1], #-338	; 0xfffffeae
     f84:	5f495753 	svcpl	0x00495753
     f88:	75736552 	ldrbvc	r6, [r3, #-1362]!	; 0xfffffaae
     f8c:	5f00746c 	svcpl	0x0000746c
     f90:	36314e5a 			; <UNDEFINED> instruction: 0x36314e5a
     f94:	6f725043 	svcvs	0x00725043
     f98:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     f9c:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     fa0:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     fa4:	72433431 	subvc	r3, r3, #822083584	; 0x31000000
     fa8:	65746165 	ldrbvs	r6, [r4, #-357]!	; 0xfffffe9b
     fac:	6f72505f 	svcvs	0x0072505f
     fb0:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     fb4:	6a685045 	bvs	1a150d0 <__bss_end+0x1a0be24>
     fb8:	77530062 	ldrbvc	r0, [r3, -r2, rrx]
     fbc:	68637469 	stmdavs	r3!, {r0, r3, r5, r6, sl, ip, sp, lr}^
     fc0:	006f545f 	rsbeq	r5, pc, pc, asr r4	; <UNPREDICTABLE>
     fc4:	4957534e 	ldmdbmi	r7, {r1, r2, r3, r6, r8, r9, ip, lr}^
     fc8:	6c69465f 	stclvs	6, cr4, [r9], #-380	; 0xfffffe84
     fcc:	73797365 	cmnvc	r9, #-1811939327	; 0x94000001
     fd0:	5f6d6574 	svcpl	0x006d6574
     fd4:	76726553 			; <UNDEFINED> instruction: 0x76726553
     fd8:	00656369 	rsbeq	r6, r5, r9, ror #6
     fdc:	63746572 	cmnvs	r4, #478150656	; 0x1c800000
     fe0:	0065646f 	rsbeq	r6, r5, pc, ror #8
     fe4:	5f746567 	svcpl	0x00746567
     fe8:	69746361 	ldmdbvs	r4!, {r0, r5, r6, r8, r9, sp, lr}^
     fec:	705f6576 	subsvc	r6, pc, r6, ror r5	; <UNPREDICTABLE>
     ff0:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     ff4:	635f7373 	cmpvs	pc, #-872415231	; 0xcc000001
     ff8:	746e756f 	strbtvc	r7, [lr], #-1391	; 0xfffffa91
     ffc:	6c696600 	stclvs	6, cr6, [r9], #-0
    1000:	6d616e65 	stclvs	14, cr6, [r1, #-404]!	; 0xfffffe6c
    1004:	6c420065 	mcrrvs	0, 6, r0, r2, cr5
    1008:	5f6b636f 	svcpl	0x006b636f
    100c:	72727543 	rsbsvc	r7, r2, #281018368	; 0x10c00000
    1010:	5f746e65 	svcpl	0x00746e65
    1014:	636f7250 	cmnvs	pc, #80, 4
    1018:	00737365 	rsbseq	r7, r3, r5, ror #6
    101c:	64616572 	strbtvs	r6, [r1], #-1394	; 0xfffffa8e
    1020:	6f6c4300 	svcvs	0x006c4300
    1024:	67006573 	smlsdxvs	r0, r3, r5, r6
    1028:	69707465 	ldmdbvs	r0!, {r0, r2, r5, r6, sl, ip, sp, lr}^
    102c:	5a5f0064 	bpl	17c11c4 <__bss_end+0x17b7f18>
    1030:	65706f34 	ldrbvs	r6, [r0, #-3892]!	; 0xfffff0cc
    1034:	634b506e 	movtvs	r5, #45166	; 0xb06e
    1038:	464e3531 			; <UNDEFINED> instruction: 0x464e3531
    103c:	5f656c69 	svcpl	0x00656c69
    1040:	6e65704f 	cdpvs	0, 6, cr7, cr5, cr15, {2}
    1044:	646f4d5f 	strbtvs	r4, [pc], #-3423	; 104c <shift+0x104c>
    1048:	69590065 	ldmdbvs	r9, {r0, r2, r5, r6}^
    104c:	00646c65 	rsbeq	r6, r4, r5, ror #24
    1050:	314e5a5f 	cmpcc	lr, pc, asr sl
    1054:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
    1058:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
    105c:	614d5f73 	hvcvs	54771	; 0xd5f3
    1060:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
    1064:	45344372 	ldrmi	r4, [r4, #-882]!	; 0xfffffc8e
    1068:	65540076 	ldrbvs	r0, [r4, #-118]	; 0xffffff8a
    106c:	6e696d72 	mcrvs	13, 3, r6, cr9, cr2, {3}
    1070:	00657461 	rsbeq	r7, r5, r1, ror #8
    1074:	74434f49 	strbvc	r4, [r3], #-3913	; 0xfffff0b7
    1078:	5a5f006c 	bpl	17c1230 <__bss_end+0x17b7f84>
    107c:	6d656d36 	stclvs	13, cr6, [r5, #-216]!	; 0xffffff28
    1080:	50797063 	rsbspl	r7, r9, r3, rrx
    1084:	7650764b 	ldrbvc	r7, [r0], -fp, asr #12
    1088:	6c660069 	stclvs	0, cr0, [r6], #-420	; 0xfffffe5c
    108c:	0074616f 	rsbseq	r6, r4, pc, ror #2
    1090:	69345a5f 	ldmdbvs	r4!, {r0, r1, r2, r3, r4, r6, r9, fp, ip, lr}
    1094:	6a616f74 	bvs	185ce6c <__bss_end+0x1853bc0>
    1098:	006a6350 	rsbeq	r6, sl, r0, asr r3
    109c:	696f7461 	stmdbvs	pc!, {r0, r5, r6, sl, ip, sp, lr}^	; <UNPREDICTABLE>
    10a0:	72747300 	rsbsvc	r7, r4, #0, 6
    10a4:	006e656c 	rsbeq	r6, lr, ip, ror #10
    10a8:	636e6f63 	cmnvs	lr, #396	; 0x18c
    10ac:	64007461 	strvs	r7, [r0], #-1121	; 0xfffffb9f
    10b0:	00747365 	rsbseq	r7, r4, r5, ror #6
    10b4:	75706e69 	ldrbvc	r6, [r0, #-3689]!	; 0xfffff197
    10b8:	61620074 	smcvs	8196	; 0x2004
    10bc:	69006573 	stmdbvs	r0, {r0, r1, r4, r5, r6, r8, sl, sp, lr}
    10c0:	00616f74 	rsbeq	r6, r1, r4, ror pc
    10c4:	5f746e69 	svcpl	0x00746e69
    10c8:	00727470 	rsbseq	r7, r2, r0, ror r4
    10cc:	62355a5f 	eorsvs	r5, r5, #389120	; 0x5f000
    10d0:	6f72657a 	svcvs	0x0072657a
    10d4:	00697650 	rsbeq	r7, r9, r0, asr r6
    10d8:	6e727473 	mrcvs	4, 3, r7, cr2, cr3, {3}
    10dc:	00797063 	rsbseq	r7, r9, r3, rrx
    10e0:	73375a5f 	teqvc	r7, #389120	; 0x5f000
    10e4:	636e7274 	cmnvs	lr, #116, 4	; 0x40000007
    10e8:	63507970 	cmpvs	r0, #112, 18	; 0x1c0000
    10ec:	69634b50 	stmdbvs	r3!, {r4, r6, r8, r9, fp, lr}^
    10f0:	746e6900 	strbtvc	r6, [lr], #-2304	; 0xfffff700
    10f4:	7261705f 	rsbvc	r7, r1, #95	; 0x5f
    10f8:	72660074 	rsbvc	r0, r6, #116	; 0x74
    10fc:	69746361 	ldmdbvs	r4!, {r0, r5, r6, r8, r9, sp, lr}^
    1100:	64006e6f 	strvs	r6, [r0], #-3695	; 0xfffff191
    1104:	74696769 	strbtvc	r6, [r9], #-1897	; 0xfffff897
    1108:	365a5f00 	ldrbcc	r5, [sl], -r0, lsl #30
    110c:	636e6f63 	cmnvs	lr, #396	; 0x18c
    1110:	63507461 	cmpvs	r0, #1627389952	; 0x61000000
    1114:	00634b50 	rsbeq	r4, r3, r0, asr fp
    1118:	646d656d 	strbtvs	r6, [sp], #-1389	; 0xfffffa93
    111c:	43007473 	movwmi	r7, #1139	; 0x473
    1120:	43726168 	cmnmi	r2, #104, 2
    1124:	41766e6f 	cmnmi	r6, pc, ror #28
    1128:	66007272 			; <UNDEFINED> instruction: 0x66007272
    112c:	00616f74 	rsbeq	r6, r1, r4, ror pc
    1130:	736d656d 	cmnvc	sp, #457179136	; 0x1b400000
    1134:	62006372 	andvs	r6, r0, #-939524095	; 0xc8000001
    1138:	6f72657a 	svcvs	0x0072657a
    113c:	6d656d00 	stclvs	13, cr6, [r5, #-0]
    1140:	00797063 	rsbseq	r7, r9, r3, rrx
    1144:	6e727473 	mrcvs	4, 3, r7, cr2, cr3, {3}
    1148:	00706d63 	rsbseq	r6, r0, r3, ror #26
    114c:	69636564 	stmdbvs	r3!, {r2, r5, r6, r8, sl, sp, lr}^
    1150:	5f6c616d 	svcpl	0x006c616d
    1154:	63616c70 	cmnvs	r1, #112, 24	; 0x7000
    1158:	5f007365 	svcpl	0x00007365
    115c:	7461345a 	strbtvc	r3, [r1], #-1114	; 0xfffffba6
    1160:	4b50696f 	blmi	141b724 <__bss_end+0x1412478>
    1164:	756f0063 	strbvc	r0, [pc, #-99]!	; 1109 <shift+0x1109>
    1168:	74757074 	ldrbtvc	r7, [r5], #-116	; 0xffffff8c
    116c:	345a5f00 	ldrbcc	r5, [sl], #-3840	; 0xfffff100
    1170:	616f7466 	cmnvs	pc, r6, ror #8
    1174:	6a635066 	bvs	18d5314 <__bss_end+0x18cc068>
    1178:	365a5f00 	ldrbcc	r5, [sl], -r0, lsl #30
    117c:	6c727473 	cfldrdvs	mvd7, [r2], #-460	; 0xfffffe34
    1180:	4b506e65 	blmi	141cb1c <__bss_end+0x1413870>
    1184:	5a5f0063 	bpl	17c1318 <__bss_end+0x17b806c>
    1188:	72747337 	rsbsvc	r7, r4, #-603979776	; 0xdc000000
    118c:	706d636e 	rsbvc	r6, sp, lr, ror #6
    1190:	53634b50 	cmnpl	r3, #80, 22	; 0x14000
    1194:	00695f30 	rsbeq	r5, r9, r0, lsr pc
    1198:	5f746e69 	svcpl	0x00746e69
    119c:	00727473 	rsbseq	r7, r2, r3, ror r4
    11a0:	6f6d656d 	svcvs	0x006d656d
    11a4:	2f007972 	svccs	0x00007972
    11a8:	72657355 	rsbvc	r7, r5, #1409286145	; 0x54000001
    11ac:	69772f73 	ldmdbvs	r7!, {r0, r1, r4, r5, r6, r8, r9, sl, fp, sp}^
    11b0:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
    11b4:	442f696a 	strtmi	r6, [pc], #-2410	; 11bc <shift+0x11bc>
    11b8:	746b7365 	strbtvc	r7, [fp], #-869	; 0xfffffc9b
    11bc:	462f706f 	strtmi	r7, [pc], -pc, rrx
    11c0:	4e2f5641 	cfmadda32mi	mvax2, mvax5, mvfx15, mvfx1
    11c4:	7a617661 	bvc	185eb50 <__bss_end+0x18558a4>
    11c8:	63696a75 	cmnvs	r9, #479232	; 0x75000
    11cc:	534f2f69 	movtpl	r2, #65385	; 0xff69
    11d0:	6d65732f 	stclvs	3, cr7, [r5, #-188]!	; 0xffffff44
    11d4:	72747365 	rsbsvc	r7, r4, #-1811939327	; 0x94000001
    11d8:	616b6c61 	cmnvs	fp, r1, ror #24
    11dc:	76696b2d 	strbtvc	r6, [r9], -sp, lsr #22
    11e0:	2f736f2d 	svccs	0x00736f2d
    11e4:	72756f73 	rsbsvc	r6, r5, #460	; 0x1cc
    11e8:	2f736563 	svccs	0x00736563
    11ec:	6c647473 	cfstrdvs	mvd7, [r4], #-460	; 0xfffffe34
    11f0:	732f6269 			; <UNDEFINED> instruction: 0x732f6269
    11f4:	732f6372 			; <UNDEFINED> instruction: 0x732f6372
    11f8:	74736474 	ldrbtvc	r6, [r3], #-1140	; 0xfffffb8c
    11fc:	676e6972 			; <UNDEFINED> instruction: 0x676e6972
    1200:	7070632e 	rsbsvc	r6, r0, lr, lsr #6
	...

Disassembly of section .debug_frame:

00000000 <.debug_frame>:
   0:	0000000c 	andeq	r0, r0, ip
   4:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
   8:	7c020001 	stcvc	0, cr0, [r2], {1}
   c:	000d0c0e 	andeq	r0, sp, lr, lsl #24
  10:	0000001c 	andeq	r0, r0, ip, lsl r0
  14:	00000000 	andeq	r0, r0, r0
  18:	00008008 	andeq	r8, r0, r8
  1c:	0000005c 	andeq	r0, r0, ip, asr r0
  20:	8b040e42 	blhi	103930 <__bss_end+0xfa684>
  24:	0b0d4201 	bleq	350830 <__bss_end+0x347584>
  28:	420d0d62 	andmi	r0, sp, #6272	; 0x1880
  2c:	00000ecb 	andeq	r0, r0, fp, asr #29
  30:	0000001c 	andeq	r0, r0, ip, lsl r0
  34:	00000000 	andeq	r0, r0, r0
  38:	00008064 	andeq	r8, r0, r4, rrx
  3c:	00000040 	andeq	r0, r0, r0, asr #32
  40:	8b080e42 	blhi	203950 <__bss_end+0x1fa6a4>
  44:	42018e02 	andmi	r8, r1, #2, 28
  48:	5a040b0c 	bpl	102c80 <__bss_end+0xf99d4>
  4c:	00080d0c 	andeq	r0, r8, ip, lsl #26
  50:	0000000c 	andeq	r0, r0, ip
  54:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
  58:	7c020001 	stcvc	0, cr0, [r2], {1}
  5c:	000d0c0e 	andeq	r0, sp, lr, lsl #24
  60:	0000001c 	andeq	r0, r0, ip, lsl r0
  64:	00000050 	andeq	r0, r0, r0, asr r0
  68:	000080a4 	andeq	r8, r0, r4, lsr #1
  6c:	00000038 	andeq	r0, r0, r8, lsr r0
  70:	8b040e42 	blhi	103980 <__bss_end+0xfa6d4>
  74:	0b0d4201 	bleq	350880 <__bss_end+0x3475d4>
  78:	420d0d54 	andmi	r0, sp, #84, 26	; 0x1500
  7c:	00000ecb 	andeq	r0, r0, fp, asr #29
  80:	0000001c 	andeq	r0, r0, ip, lsl r0
  84:	00000050 	andeq	r0, r0, r0, asr r0
  88:	000080dc 	ldrdeq	r8, [r0], -ip
  8c:	0000002c 	andeq	r0, r0, ip, lsr #32
  90:	8b040e42 	blhi	1039a0 <__bss_end+0xfa6f4>
  94:	0b0d4201 	bleq	3508a0 <__bss_end+0x3475f4>
  98:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
  9c:	00000ecb 	andeq	r0, r0, fp, asr #29
  a0:	0000001c 	andeq	r0, r0, ip, lsl r0
  a4:	00000050 	andeq	r0, r0, r0, asr r0
  a8:	00008108 	andeq	r8, r0, r8, lsl #2
  ac:	00000020 	andeq	r0, r0, r0, lsr #32
  b0:	8b040e42 	blhi	1039c0 <__bss_end+0xfa714>
  b4:	0b0d4201 	bleq	3508c0 <__bss_end+0x347614>
  b8:	420d0d48 	andmi	r0, sp, #72, 26	; 0x1200
  bc:	00000ecb 	andeq	r0, r0, fp, asr #29
  c0:	0000001c 	andeq	r0, r0, ip, lsl r0
  c4:	00000050 	andeq	r0, r0, r0, asr r0
  c8:	00008128 	andeq	r8, r0, r8, lsr #2
  cc:	00000018 	andeq	r0, r0, r8, lsl r0
  d0:	8b040e42 	blhi	1039e0 <__bss_end+0xfa734>
  d4:	0b0d4201 	bleq	3508e0 <__bss_end+0x347634>
  d8:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
  dc:	00000ecb 	andeq	r0, r0, fp, asr #29
  e0:	0000001c 	andeq	r0, r0, ip, lsl r0
  e4:	00000050 	andeq	r0, r0, r0, asr r0
  e8:	00008140 	andeq	r8, r0, r0, asr #2
  ec:	00000018 	andeq	r0, r0, r8, lsl r0
  f0:	8b040e42 	blhi	103a00 <__bss_end+0xfa754>
  f4:	0b0d4201 	bleq	350900 <__bss_end+0x347654>
  f8:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
  fc:	00000ecb 	andeq	r0, r0, fp, asr #29
 100:	0000001c 	andeq	r0, r0, ip, lsl r0
 104:	00000050 	andeq	r0, r0, r0, asr r0
 108:	00008158 	andeq	r8, r0, r8, asr r1
 10c:	00000018 	andeq	r0, r0, r8, lsl r0
 110:	8b040e42 	blhi	103a20 <__bss_end+0xfa774>
 114:	0b0d4201 	bleq	350920 <__bss_end+0x347674>
 118:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
 11c:	00000ecb 	andeq	r0, r0, fp, asr #29
 120:	00000014 	andeq	r0, r0, r4, lsl r0
 124:	00000050 	andeq	r0, r0, r0, asr r0
 128:	00008170 	andeq	r8, r0, r0, ror r1
 12c:	0000000c 	andeq	r0, r0, ip
 130:	8b040e42 	blhi	103a40 <__bss_end+0xfa794>
 134:	0b0d4201 	bleq	350940 <__bss_end+0x347694>
 138:	0000001c 	andeq	r0, r0, ip, lsl r0
 13c:	00000050 	andeq	r0, r0, r0, asr r0
 140:	0000817c 	andeq	r8, r0, ip, ror r1
 144:	00000058 	andeq	r0, r0, r8, asr r0
 148:	8b080e42 	blhi	203a58 <__bss_end+0x1fa7ac>
 14c:	42018e02 	andmi	r8, r1, #2, 28
 150:	62040b0c 	andvs	r0, r4, #12, 22	; 0x3000
 154:	00080d0c 	andeq	r0, r8, ip, lsl #26
 158:	0000001c 	andeq	r0, r0, ip, lsl r0
 15c:	00000050 	andeq	r0, r0, r0, asr r0
 160:	000081d4 	ldrdeq	r8, [r0], -r4
 164:	00000058 	andeq	r0, r0, r8, asr r0
 168:	8b080e42 	blhi	203a78 <__bss_end+0x1fa7cc>
 16c:	42018e02 	andmi	r8, r1, #2, 28
 170:	62040b0c 	andvs	r0, r4, #12, 22	; 0x3000
 174:	00080d0c 	andeq	r0, r8, ip, lsl #26
 178:	0000000c 	andeq	r0, r0, ip
 17c:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 180:	7c020001 	stcvc	0, cr0, [r2], {1}
 184:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 188:	0000001c 	andeq	r0, r0, ip, lsl r0
 18c:	00000178 	andeq	r0, r0, r8, ror r1
 190:	0000822c 	andeq	r8, r0, ip, lsr #4
 194:	0000003c 	andeq	r0, r0, ip, lsr r0
 198:	8b080e42 	blhi	203aa8 <__bss_end+0x1fa7fc>
 19c:	42018e02 	andmi	r8, r1, #2, 28
 1a0:	58040b0c 	stmdapl	r4, {r2, r3, r8, r9, fp}
 1a4:	00080d0c 	andeq	r0, r8, ip, lsl #26
 1a8:	00000018 	andeq	r0, r0, r8, lsl r0
 1ac:	00000178 	andeq	r0, r0, r8, ror r1
 1b0:	00008268 	andeq	r8, r0, r8, ror #4
 1b4:	0000015c 	andeq	r0, r0, ip, asr r1
 1b8:	8b080e42 	blhi	203ac8 <__bss_end+0x1fa81c>
 1bc:	42018e02 	andmi	r8, r1, #2, 28
 1c0:	00040b0c 	andeq	r0, r4, ip, lsl #22
 1c4:	0000000c 	andeq	r0, r0, ip
 1c8:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 1cc:	7c020001 	stcvc	0, cr0, [r2], {1}
 1d0:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 1d4:	0000001c 	andeq	r0, r0, ip, lsl r0
 1d8:	000001c4 	andeq	r0, r0, r4, asr #3
 1dc:	000083c4 	andeq	r8, r0, r4, asr #7
 1e0:	0000002c 	andeq	r0, r0, ip, lsr #32
 1e4:	8b040e42 	blhi	103af4 <__bss_end+0xfa848>
 1e8:	0b0d4201 	bleq	3509f4 <__bss_end+0x347748>
 1ec:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
 1f0:	00000ecb 	andeq	r0, r0, fp, asr #29
 1f4:	0000001c 	andeq	r0, r0, ip, lsl r0
 1f8:	000001c4 	andeq	r0, r0, r4, asr #3
 1fc:	000083f0 	strdeq	r8, [r0], -r0
 200:	0000002c 	andeq	r0, r0, ip, lsr #32
 204:	8b040e42 	blhi	103b14 <__bss_end+0xfa868>
 208:	0b0d4201 	bleq	350a14 <__bss_end+0x347768>
 20c:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
 210:	00000ecb 	andeq	r0, r0, fp, asr #29
 214:	0000001c 	andeq	r0, r0, ip, lsl r0
 218:	000001c4 	andeq	r0, r0, r4, asr #3
 21c:	0000841c 	andeq	r8, r0, ip, lsl r4
 220:	0000001c 	andeq	r0, r0, ip, lsl r0
 224:	8b040e42 	blhi	103b34 <__bss_end+0xfa888>
 228:	0b0d4201 	bleq	350a34 <__bss_end+0x347788>
 22c:	420d0d46 	andmi	r0, sp, #4480	; 0x1180
 230:	00000ecb 	andeq	r0, r0, fp, asr #29
 234:	0000001c 	andeq	r0, r0, ip, lsl r0
 238:	000001c4 	andeq	r0, r0, r4, asr #3
 23c:	00008438 	andeq	r8, r0, r8, lsr r4
 240:	00000044 	andeq	r0, r0, r4, asr #32
 244:	8b040e42 	blhi	103b54 <__bss_end+0xfa8a8>
 248:	0b0d4201 	bleq	350a54 <__bss_end+0x3477a8>
 24c:	420d0d5a 	andmi	r0, sp, #5760	; 0x1680
 250:	00000ecb 	andeq	r0, r0, fp, asr #29
 254:	0000001c 	andeq	r0, r0, ip, lsl r0
 258:	000001c4 	andeq	r0, r0, r4, asr #3
 25c:	0000847c 	andeq	r8, r0, ip, ror r4
 260:	00000050 	andeq	r0, r0, r0, asr r0
 264:	8b040e42 	blhi	103b74 <__bss_end+0xfa8c8>
 268:	0b0d4201 	bleq	350a74 <__bss_end+0x3477c8>
 26c:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 270:	00000ecb 	andeq	r0, r0, fp, asr #29
 274:	0000001c 	andeq	r0, r0, ip, lsl r0
 278:	000001c4 	andeq	r0, r0, r4, asr #3
 27c:	000084cc 	andeq	r8, r0, ip, asr #9
 280:	00000050 	andeq	r0, r0, r0, asr r0
 284:	8b040e42 	blhi	103b94 <__bss_end+0xfa8e8>
 288:	0b0d4201 	bleq	350a94 <__bss_end+0x3477e8>
 28c:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 290:	00000ecb 	andeq	r0, r0, fp, asr #29
 294:	0000001c 	andeq	r0, r0, ip, lsl r0
 298:	000001c4 	andeq	r0, r0, r4, asr #3
 29c:	0000851c 	andeq	r8, r0, ip, lsl r5
 2a0:	0000002c 	andeq	r0, r0, ip, lsr #32
 2a4:	8b040e42 	blhi	103bb4 <__bss_end+0xfa908>
 2a8:	0b0d4201 	bleq	350ab4 <__bss_end+0x347808>
 2ac:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
 2b0:	00000ecb 	andeq	r0, r0, fp, asr #29
 2b4:	0000001c 	andeq	r0, r0, ip, lsl r0
 2b8:	000001c4 	andeq	r0, r0, r4, asr #3
 2bc:	00008548 	andeq	r8, r0, r8, asr #10
 2c0:	00000050 	andeq	r0, r0, r0, asr r0
 2c4:	8b040e42 	blhi	103bd4 <__bss_end+0xfa928>
 2c8:	0b0d4201 	bleq	350ad4 <__bss_end+0x347828>
 2cc:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 2d0:	00000ecb 	andeq	r0, r0, fp, asr #29
 2d4:	0000001c 	andeq	r0, r0, ip, lsl r0
 2d8:	000001c4 	andeq	r0, r0, r4, asr #3
 2dc:	00008598 	muleq	r0, r8, r5
 2e0:	00000044 	andeq	r0, r0, r4, asr #32
 2e4:	8b040e42 	blhi	103bf4 <__bss_end+0xfa948>
 2e8:	0b0d4201 	bleq	350af4 <__bss_end+0x347848>
 2ec:	420d0d5a 	andmi	r0, sp, #5760	; 0x1680
 2f0:	00000ecb 	andeq	r0, r0, fp, asr #29
 2f4:	0000001c 	andeq	r0, r0, ip, lsl r0
 2f8:	000001c4 	andeq	r0, r0, r4, asr #3
 2fc:	000085dc 	ldrdeq	r8, [r0], -ip
 300:	00000050 	andeq	r0, r0, r0, asr r0
 304:	8b040e42 	blhi	103c14 <__bss_end+0xfa968>
 308:	0b0d4201 	bleq	350b14 <__bss_end+0x347868>
 30c:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 310:	00000ecb 	andeq	r0, r0, fp, asr #29
 314:	0000001c 	andeq	r0, r0, ip, lsl r0
 318:	000001c4 	andeq	r0, r0, r4, asr #3
 31c:	0000862c 	andeq	r8, r0, ip, lsr #12
 320:	00000054 	andeq	r0, r0, r4, asr r0
 324:	8b040e42 	blhi	103c34 <__bss_end+0xfa988>
 328:	0b0d4201 	bleq	350b34 <__bss_end+0x347888>
 32c:	420d0d62 	andmi	r0, sp, #6272	; 0x1880
 330:	00000ecb 	andeq	r0, r0, fp, asr #29
 334:	0000001c 	andeq	r0, r0, ip, lsl r0
 338:	000001c4 	andeq	r0, r0, r4, asr #3
 33c:	00008680 	andeq	r8, r0, r0, lsl #13
 340:	0000003c 	andeq	r0, r0, ip, lsr r0
 344:	8b040e42 	blhi	103c54 <__bss_end+0xfa9a8>
 348:	0b0d4201 	bleq	350b54 <__bss_end+0x3478a8>
 34c:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 350:	00000ecb 	andeq	r0, r0, fp, asr #29
 354:	0000001c 	andeq	r0, r0, ip, lsl r0
 358:	000001c4 	andeq	r0, r0, r4, asr #3
 35c:	000086bc 			; <UNDEFINED> instruction: 0x000086bc
 360:	0000003c 	andeq	r0, r0, ip, lsr r0
 364:	8b040e42 	blhi	103c74 <__bss_end+0xfa9c8>
 368:	0b0d4201 	bleq	350b74 <__bss_end+0x3478c8>
 36c:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 370:	00000ecb 	andeq	r0, r0, fp, asr #29
 374:	0000001c 	andeq	r0, r0, ip, lsl r0
 378:	000001c4 	andeq	r0, r0, r4, asr #3
 37c:	000086f8 	strdeq	r8, [r0], -r8	; <UNPREDICTABLE>
 380:	0000003c 	andeq	r0, r0, ip, lsr r0
 384:	8b040e42 	blhi	103c94 <__bss_end+0xfa9e8>
 388:	0b0d4201 	bleq	350b94 <__bss_end+0x3478e8>
 38c:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 390:	00000ecb 	andeq	r0, r0, fp, asr #29
 394:	0000001c 	andeq	r0, r0, ip, lsl r0
 398:	000001c4 	andeq	r0, r0, r4, asr #3
 39c:	00008734 	andeq	r8, r0, r4, lsr r7
 3a0:	0000003c 	andeq	r0, r0, ip, lsr r0
 3a4:	8b040e42 	blhi	103cb4 <__bss_end+0xfaa08>
 3a8:	0b0d4201 	bleq	350bb4 <__bss_end+0x347908>
 3ac:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 3b0:	00000ecb 	andeq	r0, r0, fp, asr #29
 3b4:	0000001c 	andeq	r0, r0, ip, lsl r0
 3b8:	000001c4 	andeq	r0, r0, r4, asr #3
 3bc:	00008770 	andeq	r8, r0, r0, ror r7
 3c0:	000000b0 	strheq	r0, [r0], -r0	; <UNPREDICTABLE>
 3c4:	8b080e42 	blhi	203cd4 <__bss_end+0x1faa28>
 3c8:	42018e02 	andmi	r8, r1, #2, 28
 3cc:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 3d0:	080d0c50 	stmdaeq	sp, {r4, r6, sl, fp}
 3d4:	0000000c 	andeq	r0, r0, ip
 3d8:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 3dc:	7c020001 	stcvc	0, cr0, [r2], {1}
 3e0:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 3e4:	0000001c 	andeq	r0, r0, ip, lsl r0
 3e8:	000003d4 	ldrdeq	r0, [r0], -r4
 3ec:	00008820 	andeq	r8, r0, r0, lsr #16
 3f0:	00000174 	andeq	r0, r0, r4, ror r1
 3f4:	8b080e42 	blhi	203d04 <__bss_end+0x1faa58>
 3f8:	42018e02 	andmi	r8, r1, #2, 28
 3fc:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 400:	080d0cb2 	stmdaeq	sp, {r1, r4, r5, r7, sl, fp}
 404:	0000001c 	andeq	r0, r0, ip, lsl r0
 408:	000003d4 	ldrdeq	r0, [r0], -r4
 40c:	00008994 	muleq	r0, r4, r9
 410:	0000009c 	muleq	r0, ip, r0
 414:	8b040e42 	blhi	103d24 <__bss_end+0xfaa78>
 418:	0b0d4201 	bleq	350c24 <__bss_end+0x347978>
 41c:	0d0d4602 	stceq	6, cr4, [sp, #-8]
 420:	000ecb42 	andeq	ip, lr, r2, asr #22
 424:	00000020 	andeq	r0, r0, r0, lsr #32
 428:	000003d4 	ldrdeq	r0, [r0], -r4
 42c:	00008a30 	andeq	r8, r0, r0, lsr sl
 430:	00000294 	muleq	r0, r4, r2
 434:	8b040e42 	blhi	103d44 <__bss_end+0xfaa98>
 438:	0b0d4201 	bleq	350c44 <__bss_end+0x347998>
 43c:	0d013e03 	stceq	14, cr3, [r1, #-12]
 440:	0ecb420d 	cdpeq	2, 12, cr4, cr11, cr13, {0}
 444:	00000000 	andeq	r0, r0, r0
 448:	0000001c 	andeq	r0, r0, ip, lsl r0
 44c:	000003d4 	ldrdeq	r0, [r0], -r4
 450:	00008cc4 	andeq	r8, r0, r4, asr #25
 454:	000000c0 	andeq	r0, r0, r0, asr #1
 458:	8b040e42 	blhi	103d68 <__bss_end+0xfaabc>
 45c:	0b0d4201 	bleq	350c68 <__bss_end+0x3479bc>
 460:	0d0d5802 	stceq	8, cr5, [sp, #-8]
 464:	000ecb42 	andeq	ip, lr, r2, asr #22
 468:	0000001c 	andeq	r0, r0, ip, lsl r0
 46c:	000003d4 	ldrdeq	r0, [r0], -r4
 470:	00008d84 	andeq	r8, r0, r4, lsl #27
 474:	000000ac 	andeq	r0, r0, ip, lsr #1
 478:	8b040e42 	blhi	103d88 <__bss_end+0xfaadc>
 47c:	0b0d4201 	bleq	350c88 <__bss_end+0x3479dc>
 480:	0d0d4e02 	stceq	14, cr4, [sp, #-8]
 484:	000ecb42 	andeq	ip, lr, r2, asr #22
 488:	0000001c 	andeq	r0, r0, ip, lsl r0
 48c:	000003d4 	ldrdeq	r0, [r0], -r4
 490:	00008e30 	andeq	r8, r0, r0, lsr lr
 494:	00000054 	andeq	r0, r0, r4, asr r0
 498:	8b040e42 	blhi	103da8 <__bss_end+0xfaafc>
 49c:	0b0d4201 	bleq	350ca8 <__bss_end+0x3479fc>
 4a0:	420d0d62 	andmi	r0, sp, #6272	; 0x1880
 4a4:	00000ecb 	andeq	r0, r0, fp, asr #29
 4a8:	0000001c 	andeq	r0, r0, ip, lsl r0
 4ac:	000003d4 	ldrdeq	r0, [r0], -r4
 4b0:	00008e84 	andeq	r8, r0, r4, lsl #29
 4b4:	00000068 	andeq	r0, r0, r8, rrx
 4b8:	8b040e42 	blhi	103dc8 <__bss_end+0xfab1c>
 4bc:	0b0d4201 	bleq	350cc8 <__bss_end+0x347a1c>
 4c0:	420d0d6c 	andmi	r0, sp, #108, 26	; 0x1b00
 4c4:	00000ecb 	andeq	r0, r0, fp, asr #29
 4c8:	0000001c 	andeq	r0, r0, ip, lsl r0
 4cc:	000003d4 	ldrdeq	r0, [r0], -r4
 4d0:	00008eec 	andeq	r8, r0, ip, ror #29
 4d4:	00000080 	andeq	r0, r0, r0, lsl #1
 4d8:	8b040e42 	blhi	103de8 <__bss_end+0xfab3c>
 4dc:	0b0d4201 	bleq	350ce8 <__bss_end+0x347a3c>
 4e0:	420d0d78 	andmi	r0, sp, #120, 26	; 0x1e00
 4e4:	00000ecb 	andeq	r0, r0, fp, asr #29
 4e8:	0000001c 	andeq	r0, r0, ip, lsl r0
 4ec:	000003d4 	ldrdeq	r0, [r0], -r4
 4f0:	00008f6c 	andeq	r8, r0, ip, ror #30
 4f4:	00000074 	andeq	r0, r0, r4, ror r0
 4f8:	8b080e42 	blhi	203e08 <__bss_end+0x1fab5c>
 4fc:	42018e02 	andmi	r8, r1, #2, 28
 500:	74040b0c 	strvc	r0, [r4], #-2828	; 0xfffff4f4
 504:	00080d0c 	andeq	r0, r8, ip, lsl #26
 508:	0000000c 	andeq	r0, r0, ip
 50c:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 510:	7c010001 	stcvc	0, cr0, [r1], {1}
 514:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 518:	0000000c 	andeq	r0, r0, ip
 51c:	00000508 	andeq	r0, r0, r8, lsl #10
 520:	00008fe0 	andeq	r8, r0, r0, ror #31
 524:	000001ec 	andeq	r0, r0, ip, ror #3
