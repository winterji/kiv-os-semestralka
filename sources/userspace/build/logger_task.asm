
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
    805c:	00008f7c 	andeq	r8, r0, ip, ror pc
    8060:	00008f8c 	andeq	r8, r0, ip, lsl #31

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
    81cc:	00008f79 	andeq	r8, r0, r9, ror pc
    81d0:	00008f79 	andeq	r8, r0, r9, ror pc

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
    8224:	00008f79 	andeq	r8, r0, r9, ror pc
    8228:	00008f79 	andeq	r8, r0, r9, ror pc

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
    8244:	eb00024e 	bl	8b84 <_Z6strlenPKc>
    8248:	e1a03000 	mov	r3, r0
    824c:	e1a02003 	mov	r2, r3
    8250:	e51b100c 	ldr	r1, [fp, #-12]
    8254:	e51b0008 	ldr	r0, [fp, #-8]
    8258:	eb000095 	bl	84b4 <_Z5writejPKcj>
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
    8270:	e24dd058 	sub	sp, sp, #88	; 0x58
    8274:	e50b0058 	str	r0, [fp, #-88]	; 0xffffffa8
    8278:	e50b105c 	str	r1, [fp, #-92]	; 0xffffffa4
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/logger_task/main.cpp:20
	uint32_t uart_file = open("DEV:uart/0", NFile_Open_Mode::Write_Only);
    827c:	e3a01001 	mov	r1, #1
    8280:	e59f010c 	ldr	r0, [pc, #268]	; 8394 <main+0x12c>
    8284:	eb000065 	bl	8420 <_Z4openPKc15NFile_Open_Mode>
    8288:	e50b0008 	str	r0, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/logger_task/main.cpp:23

	TUART_IOCtl_Params params;
	params.baud_rate = NUART_Baud_Rate::BR_115200;
    828c:	e59f3104 	ldr	r3, [pc, #260]	; 8398 <main+0x130>
    8290:	e50b301c 	str	r3, [fp, #-28]	; 0xffffffe4
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/logger_task/main.cpp:24
	params.char_length = NUART_Char_Length::Char_8;
    8294:	e3a03001 	mov	r3, #1
    8298:	e50b3020 	str	r3, [fp, #-32]	; 0xffffffe0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/logger_task/main.cpp:25
	ioctl(uart_file, NIOCtl_Operation::Set_Params, &params);
    829c:	e24b3020 	sub	r3, fp, #32
    82a0:	e1a02003 	mov	r2, r3
    82a4:	e3a01001 	mov	r1, #1
    82a8:	e51b0008 	ldr	r0, [fp, #-8]
    82ac:	eb00009f 	bl	8530 <_Z5ioctlj16NIOCtl_OperationPv>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/logger_task/main.cpp:27

	fputs(uart_file, "Logger task starting!");
    82b0:	e59f10e4 	ldr	r1, [pc, #228]	; 839c <main+0x134>
    82b4:	e51b0008 	ldr	r0, [fp, #-8]
    82b8:	ebffffdb 	bl	822c <_ZL5fputsjPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/logger_task/main.cpp:31

	char buf[33];
	char tickbuf[16];
	bzero(buf, 33);
    82bc:	e24b3044 	sub	r3, fp, #68	; 0x44
    82c0:	e3a01021 	mov	r1, #33	; 0x21
    82c4:	e1a00003 	mov	r0, r3
    82c8:	eb000242 	bl	8bd8 <_Z5bzeroPvi>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/logger_task/main.cpp:32
	bzero(tickbuf, 16);
    82cc:	e24b3054 	sub	r3, fp, #84	; 0x54
    82d0:	e3a01010 	mov	r1, #16
    82d4:	e1a00003 	mov	r0, r3
    82d8:	eb00023e 	bl	8bd8 <_Z5bzeroPvi>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/logger_task/main.cpp:34

	uint32_t last_tick = 0;
    82dc:	e3a03000 	mov	r3, #0
    82e0:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/logger_task/main.cpp:36

	uint32_t logpipe = pipe("log", 128);
    82e4:	e3a01080 	mov	r1, #128	; 0x80
    82e8:	e59f00b0 	ldr	r0, [pc, #176]	; 83a0 <main+0x138>
    82ec:	eb000119 	bl	8758 <_Z4pipePKcj>
    82f0:	e50b0010 	str	r0, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/logger_task/main.cpp:40

	while (true)
	{
		wait(logpipe, 1, 0x1000);
    82f4:	e3a02a01 	mov	r2, #4096	; 0x1000
    82f8:	e3a01001 	mov	r1, #1
    82fc:	e51b0010 	ldr	r0, [fp, #-16]
    8300:	eb0000af 	bl	85c4 <_Z4waitjjj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/logger_task/main.cpp:42

		uint32_t v = read(logpipe, buf, 32);
    8304:	e24b3044 	sub	r3, fp, #68	; 0x44
    8308:	e3a02020 	mov	r2, #32
    830c:	e1a01003 	mov	r1, r3
    8310:	e51b0010 	ldr	r0, [fp, #-16]
    8314:	eb000052 	bl	8464 <_Z4readjPcj>
    8318:	e50b0014 	str	r0, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/logger_task/main.cpp:43
		if (v > 0)
    831c:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8320:	e3530000 	cmp	r3, #0
    8324:	0afffff2 	beq	82f4 <main+0x8c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/logger_task/main.cpp:45
		{
			buf[v] = '\0';
    8328:	e24b2044 	sub	r2, fp, #68	; 0x44
    832c:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8330:	e0823003 	add	r3, r2, r3
    8334:	e3a02000 	mov	r2, #0
    8338:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/logger_task/main.cpp:46
			fputs(uart_file, "\r\n[ ");
    833c:	e59f1060 	ldr	r1, [pc, #96]	; 83a4 <main+0x13c>
    8340:	e51b0008 	ldr	r0, [fp, #-8]
    8344:	ebffffb8 	bl	822c <_ZL5fputsjPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/logger_task/main.cpp:47
			uint32_t tick = get_tick_count();
    8348:	eb0000d5 	bl	86a4 <_Z14get_tick_countv>
    834c:	e50b0018 	str	r0, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/logger_task/main.cpp:48
			itoa(tick, tickbuf, 16);
    8350:	e24b3054 	sub	r3, fp, #84	; 0x54
    8354:	e3a02010 	mov	r2, #16
    8358:	e1a01003 	mov	r1, r3
    835c:	e51b0018 	ldr	r0, [fp, #-24]	; 0xffffffe8
    8360:	eb000128 	bl	8808 <_Z4itoajPcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/logger_task/main.cpp:49
			fputs(uart_file, tickbuf);
    8364:	e24b3054 	sub	r3, fp, #84	; 0x54
    8368:	e1a01003 	mov	r1, r3
    836c:	e51b0008 	ldr	r0, [fp, #-8]
    8370:	ebffffad 	bl	822c <_ZL5fputsjPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/logger_task/main.cpp:50
			fputs(uart_file, "]: ");
    8374:	e59f102c 	ldr	r1, [pc, #44]	; 83a8 <main+0x140>
    8378:	e51b0008 	ldr	r0, [fp, #-8]
    837c:	ebffffaa 	bl	822c <_ZL5fputsjPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/logger_task/main.cpp:51
			fputs(uart_file, buf);
    8380:	e24b3044 	sub	r3, fp, #68	; 0x44
    8384:	e1a01003 	mov	r1, r3
    8388:	e51b0008 	ldr	r0, [fp, #-8]
    838c:	ebffffa6 	bl	822c <_ZL5fputsjPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/logger_task/main.cpp:53
		}
	}
    8390:	eaffffd7 	b	82f4 <main+0x8c>
    8394:	00008efc 	strdeq	r8, [r0], -ip
    8398:	0001c200 	andeq	ip, r1, r0, lsl #4
    839c:	00008f08 	andeq	r8, r0, r8, lsl #30
    83a0:	00008f20 	andeq	r8, r0, r0, lsr #30
    83a4:	00008f24 	andeq	r8, r0, r4, lsr #30
    83a8:	00008f2c 	andeq	r8, r0, ip, lsr #30

000083ac <_Z6getpidv>:
_Z6getpidv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:5
#include <stdfile.h>
#include <stdstring.h>

uint32_t getpid()
{
    83ac:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    83b0:	e28db000 	add	fp, sp, #0
    83b4:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:8
    uint32_t pid;

    asm volatile("swi 0");
    83b8:	ef000000 	svc	0x00000000
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:9
    asm volatile("mov %0, r0" : "=r" (pid));
    83bc:	e1a03000 	mov	r3, r0
    83c0:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:11

    return pid;
    83c4:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:12
}
    83c8:	e1a00003 	mov	r0, r3
    83cc:	e28bd000 	add	sp, fp, #0
    83d0:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    83d4:	e12fff1e 	bx	lr

000083d8 <_Z9terminatei>:
_Z9terminatei():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:15

void terminate(int exitcode)
{
    83d8:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    83dc:	e28db000 	add	fp, sp, #0
    83e0:	e24dd00c 	sub	sp, sp, #12
    83e4:	e50b0008 	str	r0, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:16
    asm volatile("mov r0, %0" : : "r" (exitcode));
    83e8:	e51b3008 	ldr	r3, [fp, #-8]
    83ec:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:17
    asm volatile("swi 1");
    83f0:	ef000001 	svc	0x00000001
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:18
}
    83f4:	e320f000 	nop	{0}
    83f8:	e28bd000 	add	sp, fp, #0
    83fc:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8400:	e12fff1e 	bx	lr

00008404 <_Z11sched_yieldv>:
_Z11sched_yieldv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:21

void sched_yield()
{
    8404:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8408:	e28db000 	add	fp, sp, #0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:22
    asm volatile("swi 2");
    840c:	ef000002 	svc	0x00000002
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:23
}
    8410:	e320f000 	nop	{0}
    8414:	e28bd000 	add	sp, fp, #0
    8418:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    841c:	e12fff1e 	bx	lr

00008420 <_Z4openPKc15NFile_Open_Mode>:
_Z4openPKc15NFile_Open_Mode():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:26

uint32_t open(const char* filename, NFile_Open_Mode mode)
{
    8420:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8424:	e28db000 	add	fp, sp, #0
    8428:	e24dd014 	sub	sp, sp, #20
    842c:	e50b0010 	str	r0, [fp, #-16]
    8430:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:29
    uint32_t file;

    asm volatile("mov r0, %0" : : "r" (filename));
    8434:	e51b3010 	ldr	r3, [fp, #-16]
    8438:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:30
    asm volatile("mov r1, %0" : : "r" (mode));
    843c:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8440:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:31
    asm volatile("swi 64");
    8444:	ef000040 	svc	0x00000040
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:32
    asm volatile("mov %0, r0" : "=r" (file));
    8448:	e1a03000 	mov	r3, r0
    844c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:33
    return file;
    8450:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:34
}
    8454:	e1a00003 	mov	r0, r3
    8458:	e28bd000 	add	sp, fp, #0
    845c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8460:	e12fff1e 	bx	lr

00008464 <_Z4readjPcj>:
_Z4readjPcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:37

uint32_t read(uint32_t file, char* const buffer, uint32_t size)
{
    8464:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8468:	e28db000 	add	fp, sp, #0
    846c:	e24dd01c 	sub	sp, sp, #28
    8470:	e50b0010 	str	r0, [fp, #-16]
    8474:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8478:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:40
    uint32_t rdnum;

    asm volatile("mov r0, %0" : : "r" (file));
    847c:	e51b3010 	ldr	r3, [fp, #-16]
    8480:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:41
    asm volatile("mov r1, %0" : : "r" (buffer));
    8484:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8488:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:42
    asm volatile("mov r2, %0" : : "r" (size));
    848c:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8490:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:43
    asm volatile("swi 65");
    8494:	ef000041 	svc	0x00000041
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:44
    asm volatile("mov %0, r0" : "=r" (rdnum));
    8498:	e1a03000 	mov	r3, r0
    849c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:46

    return rdnum;
    84a0:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:47
}
    84a4:	e1a00003 	mov	r0, r3
    84a8:	e28bd000 	add	sp, fp, #0
    84ac:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    84b0:	e12fff1e 	bx	lr

000084b4 <_Z5writejPKcj>:
_Z5writejPKcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:50

uint32_t write(uint32_t file, const char* buffer, uint32_t size)
{
    84b4:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    84b8:	e28db000 	add	fp, sp, #0
    84bc:	e24dd01c 	sub	sp, sp, #28
    84c0:	e50b0010 	str	r0, [fp, #-16]
    84c4:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    84c8:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:53
    uint32_t wrnum;

    asm volatile("mov r0, %0" : : "r" (file));
    84cc:	e51b3010 	ldr	r3, [fp, #-16]
    84d0:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:54
    asm volatile("mov r1, %0" : : "r" (buffer));
    84d4:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    84d8:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:55
    asm volatile("mov r2, %0" : : "r" (size));
    84dc:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    84e0:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:56
    asm volatile("swi 66");
    84e4:	ef000042 	svc	0x00000042
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:57
    asm volatile("mov %0, r0" : "=r" (wrnum));
    84e8:	e1a03000 	mov	r3, r0
    84ec:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:59

    return wrnum;
    84f0:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:60
}
    84f4:	e1a00003 	mov	r0, r3
    84f8:	e28bd000 	add	sp, fp, #0
    84fc:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8500:	e12fff1e 	bx	lr

00008504 <_Z5closej>:
_Z5closej():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:63

void close(uint32_t file)
{
    8504:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8508:	e28db000 	add	fp, sp, #0
    850c:	e24dd00c 	sub	sp, sp, #12
    8510:	e50b0008 	str	r0, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:64
    asm volatile("mov r0, %0" : : "r" (file));
    8514:	e51b3008 	ldr	r3, [fp, #-8]
    8518:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:65
    asm volatile("swi 67");
    851c:	ef000043 	svc	0x00000043
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:66
}
    8520:	e320f000 	nop	{0}
    8524:	e28bd000 	add	sp, fp, #0
    8528:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    852c:	e12fff1e 	bx	lr

00008530 <_Z5ioctlj16NIOCtl_OperationPv>:
_Z5ioctlj16NIOCtl_OperationPv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:69

uint32_t ioctl(uint32_t file, NIOCtl_Operation operation, void* param)
{
    8530:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8534:	e28db000 	add	fp, sp, #0
    8538:	e24dd01c 	sub	sp, sp, #28
    853c:	e50b0010 	str	r0, [fp, #-16]
    8540:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8544:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:72
    uint32_t retcode;

    asm volatile("mov r0, %0" : : "r" (file));
    8548:	e51b3010 	ldr	r3, [fp, #-16]
    854c:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:73
    asm volatile("mov r1, %0" : : "r" (operation));
    8550:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8554:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:74
    asm volatile("mov r2, %0" : : "r" (param));
    8558:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    855c:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:75
    asm volatile("swi 68");
    8560:	ef000044 	svc	0x00000044
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:76
    asm volatile("mov %0, r0" : "=r" (retcode));
    8564:	e1a03000 	mov	r3, r0
    8568:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:78

    return retcode;
    856c:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:79
}
    8570:	e1a00003 	mov	r0, r3
    8574:	e28bd000 	add	sp, fp, #0
    8578:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    857c:	e12fff1e 	bx	lr

00008580 <_Z6notifyjj>:
_Z6notifyjj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:82

uint32_t notify(uint32_t file, uint32_t count)
{
    8580:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8584:	e28db000 	add	fp, sp, #0
    8588:	e24dd014 	sub	sp, sp, #20
    858c:	e50b0010 	str	r0, [fp, #-16]
    8590:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:85
    uint32_t retcnt;

    asm volatile("mov r0, %0" : : "r" (file));
    8594:	e51b3010 	ldr	r3, [fp, #-16]
    8598:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:86
    asm volatile("mov r1, %0" : : "r" (count));
    859c:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    85a0:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:87
    asm volatile("swi 69");
    85a4:	ef000045 	svc	0x00000045
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:88
    asm volatile("mov %0, r0" : "=r" (retcnt));
    85a8:	e1a03000 	mov	r3, r0
    85ac:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:90

    return retcnt;
    85b0:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:91
}
    85b4:	e1a00003 	mov	r0, r3
    85b8:	e28bd000 	add	sp, fp, #0
    85bc:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    85c0:	e12fff1e 	bx	lr

000085c4 <_Z4waitjjj>:
_Z4waitjjj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:94

NSWI_Result_Code wait(uint32_t file, uint32_t count, uint32_t notified_deadline)
{
    85c4:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    85c8:	e28db000 	add	fp, sp, #0
    85cc:	e24dd01c 	sub	sp, sp, #28
    85d0:	e50b0010 	str	r0, [fp, #-16]
    85d4:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    85d8:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:97
    NSWI_Result_Code retcode;

    asm volatile("mov r0, %0" : : "r" (file));
    85dc:	e51b3010 	ldr	r3, [fp, #-16]
    85e0:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:98
    asm volatile("mov r1, %0" : : "r" (count));
    85e4:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    85e8:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:99
    asm volatile("mov r2, %0" : : "r" (notified_deadline));
    85ec:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    85f0:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:100
    asm volatile("swi 70");
    85f4:	ef000046 	svc	0x00000046
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:101
    asm volatile("mov %0, r0" : "=r" (retcode));
    85f8:	e1a03000 	mov	r3, r0
    85fc:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:103

    return retcode;
    8600:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:104
}
    8604:	e1a00003 	mov	r0, r3
    8608:	e28bd000 	add	sp, fp, #0
    860c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8610:	e12fff1e 	bx	lr

00008614 <_Z5sleepjj>:
_Z5sleepjj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:107

bool sleep(uint32_t ticks, uint32_t notified_deadline)
{
    8614:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8618:	e28db000 	add	fp, sp, #0
    861c:	e24dd014 	sub	sp, sp, #20
    8620:	e50b0010 	str	r0, [fp, #-16]
    8624:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:110
    uint32_t retcode;

    asm volatile("mov r0, %0" : : "r" (ticks));
    8628:	e51b3010 	ldr	r3, [fp, #-16]
    862c:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:111
    asm volatile("mov r1, %0" : : "r" (notified_deadline));
    8630:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8634:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:112
    asm volatile("swi 3");
    8638:	ef000003 	svc	0x00000003
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:113
    asm volatile("mov %0, r0" : "=r" (retcode));
    863c:	e1a03000 	mov	r3, r0
    8640:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:115

    return retcode;
    8644:	e51b3008 	ldr	r3, [fp, #-8]
    8648:	e3530000 	cmp	r3, #0
    864c:	13a03001 	movne	r3, #1
    8650:	03a03000 	moveq	r3, #0
    8654:	e6ef3073 	uxtb	r3, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:116
}
    8658:	e1a00003 	mov	r0, r3
    865c:	e28bd000 	add	sp, fp, #0
    8660:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8664:	e12fff1e 	bx	lr

00008668 <_Z24get_active_process_countv>:
_Z24get_active_process_countv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:119

uint32_t get_active_process_count()
{
    8668:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    866c:	e28db000 	add	fp, sp, #0
    8670:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:120
    const NGet_Sched_Info_Type req = NGet_Sched_Info_Type::Active_Process_Count;
    8674:	e3a03000 	mov	r3, #0
    8678:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:123
    uint32_t retval;

    asm volatile("mov r0, %0" : : "r" (req));
    867c:	e3a03000 	mov	r3, #0
    8680:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:124
    asm volatile("mov r1, %0" : : "r" (&retval));
    8684:	e24b300c 	sub	r3, fp, #12
    8688:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:125
    asm volatile("swi 4");
    868c:	ef000004 	svc	0x00000004
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:127

    return retval;
    8690:	e51b300c 	ldr	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:128
}
    8694:	e1a00003 	mov	r0, r3
    8698:	e28bd000 	add	sp, fp, #0
    869c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    86a0:	e12fff1e 	bx	lr

000086a4 <_Z14get_tick_countv>:
_Z14get_tick_countv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:131

uint32_t get_tick_count()
{
    86a4:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    86a8:	e28db000 	add	fp, sp, #0
    86ac:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:132
    const NGet_Sched_Info_Type req = NGet_Sched_Info_Type::Tick_Count;
    86b0:	e3a03001 	mov	r3, #1
    86b4:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:135
    uint32_t retval;

    asm volatile("mov r0, %0" : : "r" (req));
    86b8:	e3a03001 	mov	r3, #1
    86bc:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:136
    asm volatile("mov r1, %0" : : "r" (&retval));
    86c0:	e24b300c 	sub	r3, fp, #12
    86c4:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:137
    asm volatile("swi 4");
    86c8:	ef000004 	svc	0x00000004
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:139

    return retval;
    86cc:	e51b300c 	ldr	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:140
}
    86d0:	e1a00003 	mov	r0, r3
    86d4:	e28bd000 	add	sp, fp, #0
    86d8:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    86dc:	e12fff1e 	bx	lr

000086e0 <_Z17set_task_deadlinej>:
_Z17set_task_deadlinej():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:143

void set_task_deadline(uint32_t tick_count_required)
{
    86e0:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    86e4:	e28db000 	add	fp, sp, #0
    86e8:	e24dd014 	sub	sp, sp, #20
    86ec:	e50b0010 	str	r0, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:144
    const NDeadline_Subservice req = NDeadline_Subservice::Set_Relative;
    86f0:	e3a03000 	mov	r3, #0
    86f4:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:146

    asm volatile("mov r0, %0" : : "r" (req));
    86f8:	e3a03000 	mov	r3, #0
    86fc:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:147
    asm volatile("mov r1, %0" : : "r" (&tick_count_required));
    8700:	e24b3010 	sub	r3, fp, #16
    8704:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:148
    asm volatile("swi 5");
    8708:	ef000005 	svc	0x00000005
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:149
}
    870c:	e320f000 	nop	{0}
    8710:	e28bd000 	add	sp, fp, #0
    8714:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8718:	e12fff1e 	bx	lr

0000871c <_Z26get_task_ticks_to_deadlinev>:
_Z26get_task_ticks_to_deadlinev():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:152

uint32_t get_task_ticks_to_deadline()
{
    871c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8720:	e28db000 	add	fp, sp, #0
    8724:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:153
    const NDeadline_Subservice req = NDeadline_Subservice::Get_Remaining;
    8728:	e3a03001 	mov	r3, #1
    872c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:156
    uint32_t ticks;

    asm volatile("mov r0, %0" : : "r" (req));
    8730:	e3a03001 	mov	r3, #1
    8734:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:157
    asm volatile("mov r1, %0" : : "r" (&ticks));
    8738:	e24b300c 	sub	r3, fp, #12
    873c:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:158
    asm volatile("swi 5");
    8740:	ef000005 	svc	0x00000005
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:160

    return ticks;
    8744:	e51b300c 	ldr	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:161
}
    8748:	e1a00003 	mov	r0, r3
    874c:	e28bd000 	add	sp, fp, #0
    8750:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8754:	e12fff1e 	bx	lr

00008758 <_Z4pipePKcj>:
_Z4pipePKcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:166

const char Pipe_File_Prefix[] = "SYS:pipe/";

uint32_t pipe(const char* name, uint32_t buf_size)
{
    8758:	e92d4800 	push	{fp, lr}
    875c:	e28db004 	add	fp, sp, #4
    8760:	e24dd050 	sub	sp, sp, #80	; 0x50
    8764:	e50b0050 	str	r0, [fp, #-80]	; 0xffffffb0
    8768:	e50b1054 	str	r1, [fp, #-84]	; 0xffffffac
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:168
    char fname[64];
    strncpy(fname, Pipe_File_Prefix, sizeof(Pipe_File_Prefix));
    876c:	e24b3048 	sub	r3, fp, #72	; 0x48
    8770:	e3a0200a 	mov	r2, #10
    8774:	e59f1088 	ldr	r1, [pc, #136]	; 8804 <_Z4pipePKcj+0xac>
    8778:	e1a00003 	mov	r0, r3
    877c:	eb0000a5 	bl	8a18 <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:169
    strncpy(fname + sizeof(Pipe_File_Prefix), name, sizeof(fname) - sizeof(Pipe_File_Prefix) - 1);
    8780:	e24b3048 	sub	r3, fp, #72	; 0x48
    8784:	e283300a 	add	r3, r3, #10
    8788:	e3a02035 	mov	r2, #53	; 0x35
    878c:	e51b1050 	ldr	r1, [fp, #-80]	; 0xffffffb0
    8790:	e1a00003 	mov	r0, r3
    8794:	eb00009f 	bl	8a18 <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:171

    int ncur = sizeof(Pipe_File_Prefix) + strlen(name);
    8798:	e51b0050 	ldr	r0, [fp, #-80]	; 0xffffffb0
    879c:	eb0000f8 	bl	8b84 <_Z6strlenPKc>
    87a0:	e1a03000 	mov	r3, r0
    87a4:	e283300a 	add	r3, r3, #10
    87a8:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:173

    fname[ncur++] = '#';
    87ac:	e51b3008 	ldr	r3, [fp, #-8]
    87b0:	e2832001 	add	r2, r3, #1
    87b4:	e50b2008 	str	r2, [fp, #-8]
    87b8:	e2433004 	sub	r3, r3, #4
    87bc:	e083300b 	add	r3, r3, fp
    87c0:	e3a02023 	mov	r2, #35	; 0x23
    87c4:	e5432044 	strb	r2, [r3, #-68]	; 0xffffffbc
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:175

    itoa(buf_size, &fname[ncur], 10);
    87c8:	e24b2048 	sub	r2, fp, #72	; 0x48
    87cc:	e51b3008 	ldr	r3, [fp, #-8]
    87d0:	e0823003 	add	r3, r2, r3
    87d4:	e3a0200a 	mov	r2, #10
    87d8:	e1a01003 	mov	r1, r3
    87dc:	e51b0054 	ldr	r0, [fp, #-84]	; 0xffffffac
    87e0:	eb000008 	bl	8808 <_Z4itoajPcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:177

    return open(fname, NFile_Open_Mode::Read_Write);
    87e4:	e24b3048 	sub	r3, fp, #72	; 0x48
    87e8:	e3a01002 	mov	r1, #2
    87ec:	e1a00003 	mov	r0, r3
    87f0:	ebffff0a 	bl	8420 <_Z4openPKc15NFile_Open_Mode>
    87f4:	e1a03000 	mov	r3, r0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:178
}
    87f8:	e1a00003 	mov	r0, r3
    87fc:	e24bd004 	sub	sp, fp, #4
    8800:	e8bd8800 	pop	{fp, pc}
    8804:	00008f5c 	andeq	r8, r0, ip, asr pc

00008808 <_Z4itoajPcj>:
_Z4itoajPcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:9
{
    const char CharConvArr[] = "0123456789ABCDEF";
}

void itoa(unsigned int input, char* output, unsigned int base)
{
    8808:	e92d4800 	push	{fp, lr}
    880c:	e28db004 	add	fp, sp, #4
    8810:	e24dd020 	sub	sp, sp, #32
    8814:	e50b0018 	str	r0, [fp, #-24]	; 0xffffffe8
    8818:	e50b101c 	str	r1, [fp, #-28]	; 0xffffffe4
    881c:	e50b2020 	str	r2, [fp, #-32]	; 0xffffffe0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:10
	int i = 0;
    8820:	e3a03000 	mov	r3, #0
    8824:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:12

	while (input > 0)
    8828:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    882c:	e3530000 	cmp	r3, #0
    8830:	0a000014 	beq	8888 <_Z4itoajPcj+0x80>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:14
	{
		output[i] = CharConvArr[input % base];
    8834:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8838:	e51b1020 	ldr	r1, [fp, #-32]	; 0xffffffe0
    883c:	e1a00003 	mov	r0, r3
    8840:	eb000199 	bl	8eac <__aeabi_uidivmod>
    8844:	e1a03001 	mov	r3, r1
    8848:	e1a01003 	mov	r1, r3
    884c:	e51b3008 	ldr	r3, [fp, #-8]
    8850:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    8854:	e0823003 	add	r3, r2, r3
    8858:	e59f2118 	ldr	r2, [pc, #280]	; 8978 <_Z4itoajPcj+0x170>
    885c:	e7d22001 	ldrb	r2, [r2, r1]
    8860:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:15
		input /= base;
    8864:	e51b1020 	ldr	r1, [fp, #-32]	; 0xffffffe0
    8868:	e51b0018 	ldr	r0, [fp, #-24]	; 0xffffffe8
    886c:	eb000113 	bl	8cc0 <__udivsi3>
    8870:	e1a03000 	mov	r3, r0
    8874:	e50b3018 	str	r3, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:16
		i++;
    8878:	e51b3008 	ldr	r3, [fp, #-8]
    887c:	e2833001 	add	r3, r3, #1
    8880:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:12
	while (input > 0)
    8884:	eaffffe7 	b	8828 <_Z4itoajPcj+0x20>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:19
	}

    if (i == 0)
    8888:	e51b3008 	ldr	r3, [fp, #-8]
    888c:	e3530000 	cmp	r3, #0
    8890:	1a000007 	bne	88b4 <_Z4itoajPcj+0xac>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:21
    {
        output[i] = CharConvArr[0];
    8894:	e51b3008 	ldr	r3, [fp, #-8]
    8898:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    889c:	e0823003 	add	r3, r2, r3
    88a0:	e3a02030 	mov	r2, #48	; 0x30
    88a4:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:22
        i++;
    88a8:	e51b3008 	ldr	r3, [fp, #-8]
    88ac:	e2833001 	add	r3, r3, #1
    88b0:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:25
    }

	output[i] = '\0';
    88b4:	e51b3008 	ldr	r3, [fp, #-8]
    88b8:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    88bc:	e0823003 	add	r3, r2, r3
    88c0:	e3a02000 	mov	r2, #0
    88c4:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:26
	i--;
    88c8:	e51b3008 	ldr	r3, [fp, #-8]
    88cc:	e2433001 	sub	r3, r3, #1
    88d0:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:28

	for (int j = 0; j <= i/2; j++)
    88d4:	e3a03000 	mov	r3, #0
    88d8:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:28 (discriminator 3)
    88dc:	e51b3008 	ldr	r3, [fp, #-8]
    88e0:	e1a02fa3 	lsr	r2, r3, #31
    88e4:	e0823003 	add	r3, r2, r3
    88e8:	e1a030c3 	asr	r3, r3, #1
    88ec:	e1a02003 	mov	r2, r3
    88f0:	e51b300c 	ldr	r3, [fp, #-12]
    88f4:	e1530002 	cmp	r3, r2
    88f8:	ca00001b 	bgt	896c <_Z4itoajPcj+0x164>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:30 (discriminator 2)
	{
		char c = output[i - j];
    88fc:	e51b2008 	ldr	r2, [fp, #-8]
    8900:	e51b300c 	ldr	r3, [fp, #-12]
    8904:	e0423003 	sub	r3, r2, r3
    8908:	e1a02003 	mov	r2, r3
    890c:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    8910:	e0833002 	add	r3, r3, r2
    8914:	e5d33000 	ldrb	r3, [r3]
    8918:	e54b300d 	strb	r3, [fp, #-13]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:31 (discriminator 2)
		output[i - j] = output[j];
    891c:	e51b300c 	ldr	r3, [fp, #-12]
    8920:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    8924:	e0822003 	add	r2, r2, r3
    8928:	e51b1008 	ldr	r1, [fp, #-8]
    892c:	e51b300c 	ldr	r3, [fp, #-12]
    8930:	e0413003 	sub	r3, r1, r3
    8934:	e1a01003 	mov	r1, r3
    8938:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    893c:	e0833001 	add	r3, r3, r1
    8940:	e5d22000 	ldrb	r2, [r2]
    8944:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:32 (discriminator 2)
		output[j] = c;
    8948:	e51b300c 	ldr	r3, [fp, #-12]
    894c:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    8950:	e0823003 	add	r3, r2, r3
    8954:	e55b200d 	ldrb	r2, [fp, #-13]
    8958:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:28 (discriminator 2)
	for (int j = 0; j <= i/2; j++)
    895c:	e51b300c 	ldr	r3, [fp, #-12]
    8960:	e2833001 	add	r3, r3, #1
    8964:	e50b300c 	str	r3, [fp, #-12]
    8968:	eaffffdb 	b	88dc <_Z4itoajPcj+0xd4>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:34
	}
}
    896c:	e320f000 	nop	{0}
    8970:	e24bd004 	sub	sp, fp, #4
    8974:	e8bd8800 	pop	{fp, pc}
    8978:	00008f68 	andeq	r8, r0, r8, ror #30

0000897c <_Z4atoiPKc>:
_Z4atoiPKc():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:37

int atoi(const char* input)
{
    897c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8980:	e28db000 	add	fp, sp, #0
    8984:	e24dd014 	sub	sp, sp, #20
    8988:	e50b0010 	str	r0, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:38
	int output = 0;
    898c:	e3a03000 	mov	r3, #0
    8990:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:40

	while (*input != '\0')
    8994:	e51b3010 	ldr	r3, [fp, #-16]
    8998:	e5d33000 	ldrb	r3, [r3]
    899c:	e3530000 	cmp	r3, #0
    89a0:	0a000017 	beq	8a04 <_Z4atoiPKc+0x88>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:42
	{
		output *= 10;
    89a4:	e51b2008 	ldr	r2, [fp, #-8]
    89a8:	e1a03002 	mov	r3, r2
    89ac:	e1a03103 	lsl	r3, r3, #2
    89b0:	e0833002 	add	r3, r3, r2
    89b4:	e1a03083 	lsl	r3, r3, #1
    89b8:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:43
		if (*input > '9' || *input < '0')
    89bc:	e51b3010 	ldr	r3, [fp, #-16]
    89c0:	e5d33000 	ldrb	r3, [r3]
    89c4:	e3530039 	cmp	r3, #57	; 0x39
    89c8:	8a00000d 	bhi	8a04 <_Z4atoiPKc+0x88>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:43 (discriminator 1)
    89cc:	e51b3010 	ldr	r3, [fp, #-16]
    89d0:	e5d33000 	ldrb	r3, [r3]
    89d4:	e353002f 	cmp	r3, #47	; 0x2f
    89d8:	9a000009 	bls	8a04 <_Z4atoiPKc+0x88>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:46
			break;

		output += *input - '0';
    89dc:	e51b3010 	ldr	r3, [fp, #-16]
    89e0:	e5d33000 	ldrb	r3, [r3]
    89e4:	e2433030 	sub	r3, r3, #48	; 0x30
    89e8:	e51b2008 	ldr	r2, [fp, #-8]
    89ec:	e0823003 	add	r3, r2, r3
    89f0:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:48

		input++;
    89f4:	e51b3010 	ldr	r3, [fp, #-16]
    89f8:	e2833001 	add	r3, r3, #1
    89fc:	e50b3010 	str	r3, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:40
	while (*input != '\0')
    8a00:	eaffffe3 	b	8994 <_Z4atoiPKc+0x18>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:51
	}

	return output;
    8a04:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:52
}
    8a08:	e1a00003 	mov	r0, r3
    8a0c:	e28bd000 	add	sp, fp, #0
    8a10:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8a14:	e12fff1e 	bx	lr

00008a18 <_Z7strncpyPcPKci>:
_Z7strncpyPcPKci():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:55

char* strncpy(char* dest, const char *src, int num)
{
    8a18:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8a1c:	e28db000 	add	fp, sp, #0
    8a20:	e24dd01c 	sub	sp, sp, #28
    8a24:	e50b0010 	str	r0, [fp, #-16]
    8a28:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8a2c:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:58
	int i;

	for (i = 0; i < num && src[i] != '\0'; i++)
    8a30:	e3a03000 	mov	r3, #0
    8a34:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:58 (discriminator 4)
    8a38:	e51b2008 	ldr	r2, [fp, #-8]
    8a3c:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8a40:	e1520003 	cmp	r2, r3
    8a44:	aa000011 	bge	8a90 <_Z7strncpyPcPKci+0x78>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:58 (discriminator 2)
    8a48:	e51b3008 	ldr	r3, [fp, #-8]
    8a4c:	e51b2014 	ldr	r2, [fp, #-20]	; 0xffffffec
    8a50:	e0823003 	add	r3, r2, r3
    8a54:	e5d33000 	ldrb	r3, [r3]
    8a58:	e3530000 	cmp	r3, #0
    8a5c:	0a00000b 	beq	8a90 <_Z7strncpyPcPKci+0x78>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:59 (discriminator 3)
		dest[i] = src[i];
    8a60:	e51b3008 	ldr	r3, [fp, #-8]
    8a64:	e51b2014 	ldr	r2, [fp, #-20]	; 0xffffffec
    8a68:	e0822003 	add	r2, r2, r3
    8a6c:	e51b3008 	ldr	r3, [fp, #-8]
    8a70:	e51b1010 	ldr	r1, [fp, #-16]
    8a74:	e0813003 	add	r3, r1, r3
    8a78:	e5d22000 	ldrb	r2, [r2]
    8a7c:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:58 (discriminator 3)
	for (i = 0; i < num && src[i] != '\0'; i++)
    8a80:	e51b3008 	ldr	r3, [fp, #-8]
    8a84:	e2833001 	add	r3, r3, #1
    8a88:	e50b3008 	str	r3, [fp, #-8]
    8a8c:	eaffffe9 	b	8a38 <_Z7strncpyPcPKci+0x20>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:60 (discriminator 2)
	for (; i < num; i++)
    8a90:	e51b2008 	ldr	r2, [fp, #-8]
    8a94:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8a98:	e1520003 	cmp	r2, r3
    8a9c:	aa000008 	bge	8ac4 <_Z7strncpyPcPKci+0xac>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:61 (discriminator 1)
		dest[i] = '\0';
    8aa0:	e51b3008 	ldr	r3, [fp, #-8]
    8aa4:	e51b2010 	ldr	r2, [fp, #-16]
    8aa8:	e0823003 	add	r3, r2, r3
    8aac:	e3a02000 	mov	r2, #0
    8ab0:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:60 (discriminator 1)
	for (; i < num; i++)
    8ab4:	e51b3008 	ldr	r3, [fp, #-8]
    8ab8:	e2833001 	add	r3, r3, #1
    8abc:	e50b3008 	str	r3, [fp, #-8]
    8ac0:	eafffff2 	b	8a90 <_Z7strncpyPcPKci+0x78>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:63

   return dest;
    8ac4:	e51b3010 	ldr	r3, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:64
}
    8ac8:	e1a00003 	mov	r0, r3
    8acc:	e28bd000 	add	sp, fp, #0
    8ad0:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8ad4:	e12fff1e 	bx	lr

00008ad8 <_Z7strncmpPKcS0_i>:
_Z7strncmpPKcS0_i():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:67

int strncmp(const char *s1, const char *s2, int num)
{
    8ad8:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8adc:	e28db000 	add	fp, sp, #0
    8ae0:	e24dd01c 	sub	sp, sp, #28
    8ae4:	e50b0010 	str	r0, [fp, #-16]
    8ae8:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8aec:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:69
	unsigned char u1, u2;
  	while (num-- > 0)
    8af0:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8af4:	e2432001 	sub	r2, r3, #1
    8af8:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
    8afc:	e3530000 	cmp	r3, #0
    8b00:	c3a03001 	movgt	r3, #1
    8b04:	d3a03000 	movle	r3, #0
    8b08:	e6ef3073 	uxtb	r3, r3
    8b0c:	e3530000 	cmp	r3, #0
    8b10:	0a000016 	beq	8b70 <_Z7strncmpPKcS0_i+0x98>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:71
    {
      	u1 = (unsigned char) *s1++;
    8b14:	e51b3010 	ldr	r3, [fp, #-16]
    8b18:	e2832001 	add	r2, r3, #1
    8b1c:	e50b2010 	str	r2, [fp, #-16]
    8b20:	e5d33000 	ldrb	r3, [r3]
    8b24:	e54b3005 	strb	r3, [fp, #-5]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:72
     	u2 = (unsigned char) *s2++;
    8b28:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8b2c:	e2832001 	add	r2, r3, #1
    8b30:	e50b2014 	str	r2, [fp, #-20]	; 0xffffffec
    8b34:	e5d33000 	ldrb	r3, [r3]
    8b38:	e54b3006 	strb	r3, [fp, #-6]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:73
      	if (u1 != u2)
    8b3c:	e55b2005 	ldrb	r2, [fp, #-5]
    8b40:	e55b3006 	ldrb	r3, [fp, #-6]
    8b44:	e1520003 	cmp	r2, r3
    8b48:	0a000003 	beq	8b5c <_Z7strncmpPKcS0_i+0x84>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:74
        	return u1 - u2;
    8b4c:	e55b2005 	ldrb	r2, [fp, #-5]
    8b50:	e55b3006 	ldrb	r3, [fp, #-6]
    8b54:	e0423003 	sub	r3, r2, r3
    8b58:	ea000005 	b	8b74 <_Z7strncmpPKcS0_i+0x9c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:75
      	if (u1 == '\0')
    8b5c:	e55b3005 	ldrb	r3, [fp, #-5]
    8b60:	e3530000 	cmp	r3, #0
    8b64:	1affffe1 	bne	8af0 <_Z7strncmpPKcS0_i+0x18>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:76
        	return 0;
    8b68:	e3a03000 	mov	r3, #0
    8b6c:	ea000000 	b	8b74 <_Z7strncmpPKcS0_i+0x9c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:79
    }

  	return 0;
    8b70:	e3a03000 	mov	r3, #0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:80
}
    8b74:	e1a00003 	mov	r0, r3
    8b78:	e28bd000 	add	sp, fp, #0
    8b7c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8b80:	e12fff1e 	bx	lr

00008b84 <_Z6strlenPKc>:
_Z6strlenPKc():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:83

int strlen(const char* s)
{
    8b84:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8b88:	e28db000 	add	fp, sp, #0
    8b8c:	e24dd014 	sub	sp, sp, #20
    8b90:	e50b0010 	str	r0, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:84
	int i = 0;
    8b94:	e3a03000 	mov	r3, #0
    8b98:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:86

	while (s[i] != '\0')
    8b9c:	e51b3008 	ldr	r3, [fp, #-8]
    8ba0:	e51b2010 	ldr	r2, [fp, #-16]
    8ba4:	e0823003 	add	r3, r2, r3
    8ba8:	e5d33000 	ldrb	r3, [r3]
    8bac:	e3530000 	cmp	r3, #0
    8bb0:	0a000003 	beq	8bc4 <_Z6strlenPKc+0x40>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:87
		i++;
    8bb4:	e51b3008 	ldr	r3, [fp, #-8]
    8bb8:	e2833001 	add	r3, r3, #1
    8bbc:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:86
	while (s[i] != '\0')
    8bc0:	eafffff5 	b	8b9c <_Z6strlenPKc+0x18>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:89

	return i;
    8bc4:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:90
}
    8bc8:	e1a00003 	mov	r0, r3
    8bcc:	e28bd000 	add	sp, fp, #0
    8bd0:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8bd4:	e12fff1e 	bx	lr

00008bd8 <_Z5bzeroPvi>:
_Z5bzeroPvi():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:93

void bzero(void* memory, int length)
{
    8bd8:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8bdc:	e28db000 	add	fp, sp, #0
    8be0:	e24dd014 	sub	sp, sp, #20
    8be4:	e50b0010 	str	r0, [fp, #-16]
    8be8:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:94
	char* mem = reinterpret_cast<char*>(memory);
    8bec:	e51b3010 	ldr	r3, [fp, #-16]
    8bf0:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:96

	for (int i = 0; i < length; i++)
    8bf4:	e3a03000 	mov	r3, #0
    8bf8:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:96 (discriminator 3)
    8bfc:	e51b2008 	ldr	r2, [fp, #-8]
    8c00:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8c04:	e1520003 	cmp	r2, r3
    8c08:	aa000008 	bge	8c30 <_Z5bzeroPvi+0x58>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:97 (discriminator 2)
		mem[i] = 0;
    8c0c:	e51b3008 	ldr	r3, [fp, #-8]
    8c10:	e51b200c 	ldr	r2, [fp, #-12]
    8c14:	e0823003 	add	r3, r2, r3
    8c18:	e3a02000 	mov	r2, #0
    8c1c:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:96 (discriminator 2)
	for (int i = 0; i < length; i++)
    8c20:	e51b3008 	ldr	r3, [fp, #-8]
    8c24:	e2833001 	add	r3, r3, #1
    8c28:	e50b3008 	str	r3, [fp, #-8]
    8c2c:	eafffff2 	b	8bfc <_Z5bzeroPvi+0x24>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:98
}
    8c30:	e320f000 	nop	{0}
    8c34:	e28bd000 	add	sp, fp, #0
    8c38:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8c3c:	e12fff1e 	bx	lr

00008c40 <_Z6memcpyPKvPvi>:
_Z6memcpyPKvPvi():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:101

void memcpy(const void* src, void* dst, int num)
{
    8c40:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8c44:	e28db000 	add	fp, sp, #0
    8c48:	e24dd024 	sub	sp, sp, #36	; 0x24
    8c4c:	e50b0018 	str	r0, [fp, #-24]	; 0xffffffe8
    8c50:	e50b101c 	str	r1, [fp, #-28]	; 0xffffffe4
    8c54:	e50b2020 	str	r2, [fp, #-32]	; 0xffffffe0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:102
	const char* memsrc = reinterpret_cast<const char*>(src);
    8c58:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8c5c:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:103
	char* memdst = reinterpret_cast<char*>(dst);
    8c60:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    8c64:	e50b3010 	str	r3, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:105

	for (int i = 0; i < num; i++)
    8c68:	e3a03000 	mov	r3, #0
    8c6c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:105 (discriminator 3)
    8c70:	e51b2008 	ldr	r2, [fp, #-8]
    8c74:	e51b3020 	ldr	r3, [fp, #-32]	; 0xffffffe0
    8c78:	e1520003 	cmp	r2, r3
    8c7c:	aa00000b 	bge	8cb0 <_Z6memcpyPKvPvi+0x70>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:106 (discriminator 2)
		memdst[i] = memsrc[i];
    8c80:	e51b3008 	ldr	r3, [fp, #-8]
    8c84:	e51b200c 	ldr	r2, [fp, #-12]
    8c88:	e0822003 	add	r2, r2, r3
    8c8c:	e51b3008 	ldr	r3, [fp, #-8]
    8c90:	e51b1010 	ldr	r1, [fp, #-16]
    8c94:	e0813003 	add	r3, r1, r3
    8c98:	e5d22000 	ldrb	r2, [r2]
    8c9c:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:105 (discriminator 2)
	for (int i = 0; i < num; i++)
    8ca0:	e51b3008 	ldr	r3, [fp, #-8]
    8ca4:	e2833001 	add	r3, r3, #1
    8ca8:	e50b3008 	str	r3, [fp, #-8]
    8cac:	eaffffef 	b	8c70 <_Z6memcpyPKvPvi+0x30>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:107
}
    8cb0:	e320f000 	nop	{0}
    8cb4:	e28bd000 	add	sp, fp, #0
    8cb8:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8cbc:	e12fff1e 	bx	lr

00008cc0 <__udivsi3>:
__udivsi3():
    8cc0:	e2512001 	subs	r2, r1, #1
    8cc4:	012fff1e 	bxeq	lr
    8cc8:	3a000074 	bcc	8ea0 <__udivsi3+0x1e0>
    8ccc:	e1500001 	cmp	r0, r1
    8cd0:	9a00006b 	bls	8e84 <__udivsi3+0x1c4>
    8cd4:	e1110002 	tst	r1, r2
    8cd8:	0a00006c 	beq	8e90 <__udivsi3+0x1d0>
    8cdc:	e16f3f10 	clz	r3, r0
    8ce0:	e16f2f11 	clz	r2, r1
    8ce4:	e0423003 	sub	r3, r2, r3
    8ce8:	e273301f 	rsbs	r3, r3, #31
    8cec:	10833083 	addne	r3, r3, r3, lsl #1
    8cf0:	e3a02000 	mov	r2, #0
    8cf4:	108ff103 	addne	pc, pc, r3, lsl #2
    8cf8:	e1a00000 	nop			; (mov r0, r0)
    8cfc:	e1500f81 	cmp	r0, r1, lsl #31
    8d00:	e0a22002 	adc	r2, r2, r2
    8d04:	20400f81 	subcs	r0, r0, r1, lsl #31
    8d08:	e1500f01 	cmp	r0, r1, lsl #30
    8d0c:	e0a22002 	adc	r2, r2, r2
    8d10:	20400f01 	subcs	r0, r0, r1, lsl #30
    8d14:	e1500e81 	cmp	r0, r1, lsl #29
    8d18:	e0a22002 	adc	r2, r2, r2
    8d1c:	20400e81 	subcs	r0, r0, r1, lsl #29
    8d20:	e1500e01 	cmp	r0, r1, lsl #28
    8d24:	e0a22002 	adc	r2, r2, r2
    8d28:	20400e01 	subcs	r0, r0, r1, lsl #28
    8d2c:	e1500d81 	cmp	r0, r1, lsl #27
    8d30:	e0a22002 	adc	r2, r2, r2
    8d34:	20400d81 	subcs	r0, r0, r1, lsl #27
    8d38:	e1500d01 	cmp	r0, r1, lsl #26
    8d3c:	e0a22002 	adc	r2, r2, r2
    8d40:	20400d01 	subcs	r0, r0, r1, lsl #26
    8d44:	e1500c81 	cmp	r0, r1, lsl #25
    8d48:	e0a22002 	adc	r2, r2, r2
    8d4c:	20400c81 	subcs	r0, r0, r1, lsl #25
    8d50:	e1500c01 	cmp	r0, r1, lsl #24
    8d54:	e0a22002 	adc	r2, r2, r2
    8d58:	20400c01 	subcs	r0, r0, r1, lsl #24
    8d5c:	e1500b81 	cmp	r0, r1, lsl #23
    8d60:	e0a22002 	adc	r2, r2, r2
    8d64:	20400b81 	subcs	r0, r0, r1, lsl #23
    8d68:	e1500b01 	cmp	r0, r1, lsl #22
    8d6c:	e0a22002 	adc	r2, r2, r2
    8d70:	20400b01 	subcs	r0, r0, r1, lsl #22
    8d74:	e1500a81 	cmp	r0, r1, lsl #21
    8d78:	e0a22002 	adc	r2, r2, r2
    8d7c:	20400a81 	subcs	r0, r0, r1, lsl #21
    8d80:	e1500a01 	cmp	r0, r1, lsl #20
    8d84:	e0a22002 	adc	r2, r2, r2
    8d88:	20400a01 	subcs	r0, r0, r1, lsl #20
    8d8c:	e1500981 	cmp	r0, r1, lsl #19
    8d90:	e0a22002 	adc	r2, r2, r2
    8d94:	20400981 	subcs	r0, r0, r1, lsl #19
    8d98:	e1500901 	cmp	r0, r1, lsl #18
    8d9c:	e0a22002 	adc	r2, r2, r2
    8da0:	20400901 	subcs	r0, r0, r1, lsl #18
    8da4:	e1500881 	cmp	r0, r1, lsl #17
    8da8:	e0a22002 	adc	r2, r2, r2
    8dac:	20400881 	subcs	r0, r0, r1, lsl #17
    8db0:	e1500801 	cmp	r0, r1, lsl #16
    8db4:	e0a22002 	adc	r2, r2, r2
    8db8:	20400801 	subcs	r0, r0, r1, lsl #16
    8dbc:	e1500781 	cmp	r0, r1, lsl #15
    8dc0:	e0a22002 	adc	r2, r2, r2
    8dc4:	20400781 	subcs	r0, r0, r1, lsl #15
    8dc8:	e1500701 	cmp	r0, r1, lsl #14
    8dcc:	e0a22002 	adc	r2, r2, r2
    8dd0:	20400701 	subcs	r0, r0, r1, lsl #14
    8dd4:	e1500681 	cmp	r0, r1, lsl #13
    8dd8:	e0a22002 	adc	r2, r2, r2
    8ddc:	20400681 	subcs	r0, r0, r1, lsl #13
    8de0:	e1500601 	cmp	r0, r1, lsl #12
    8de4:	e0a22002 	adc	r2, r2, r2
    8de8:	20400601 	subcs	r0, r0, r1, lsl #12
    8dec:	e1500581 	cmp	r0, r1, lsl #11
    8df0:	e0a22002 	adc	r2, r2, r2
    8df4:	20400581 	subcs	r0, r0, r1, lsl #11
    8df8:	e1500501 	cmp	r0, r1, lsl #10
    8dfc:	e0a22002 	adc	r2, r2, r2
    8e00:	20400501 	subcs	r0, r0, r1, lsl #10
    8e04:	e1500481 	cmp	r0, r1, lsl #9
    8e08:	e0a22002 	adc	r2, r2, r2
    8e0c:	20400481 	subcs	r0, r0, r1, lsl #9
    8e10:	e1500401 	cmp	r0, r1, lsl #8
    8e14:	e0a22002 	adc	r2, r2, r2
    8e18:	20400401 	subcs	r0, r0, r1, lsl #8
    8e1c:	e1500381 	cmp	r0, r1, lsl #7
    8e20:	e0a22002 	adc	r2, r2, r2
    8e24:	20400381 	subcs	r0, r0, r1, lsl #7
    8e28:	e1500301 	cmp	r0, r1, lsl #6
    8e2c:	e0a22002 	adc	r2, r2, r2
    8e30:	20400301 	subcs	r0, r0, r1, lsl #6
    8e34:	e1500281 	cmp	r0, r1, lsl #5
    8e38:	e0a22002 	adc	r2, r2, r2
    8e3c:	20400281 	subcs	r0, r0, r1, lsl #5
    8e40:	e1500201 	cmp	r0, r1, lsl #4
    8e44:	e0a22002 	adc	r2, r2, r2
    8e48:	20400201 	subcs	r0, r0, r1, lsl #4
    8e4c:	e1500181 	cmp	r0, r1, lsl #3
    8e50:	e0a22002 	adc	r2, r2, r2
    8e54:	20400181 	subcs	r0, r0, r1, lsl #3
    8e58:	e1500101 	cmp	r0, r1, lsl #2
    8e5c:	e0a22002 	adc	r2, r2, r2
    8e60:	20400101 	subcs	r0, r0, r1, lsl #2
    8e64:	e1500081 	cmp	r0, r1, lsl #1
    8e68:	e0a22002 	adc	r2, r2, r2
    8e6c:	20400081 	subcs	r0, r0, r1, lsl #1
    8e70:	e1500001 	cmp	r0, r1
    8e74:	e0a22002 	adc	r2, r2, r2
    8e78:	20400001 	subcs	r0, r0, r1
    8e7c:	e1a00002 	mov	r0, r2
    8e80:	e12fff1e 	bx	lr
    8e84:	03a00001 	moveq	r0, #1
    8e88:	13a00000 	movne	r0, #0
    8e8c:	e12fff1e 	bx	lr
    8e90:	e16f2f11 	clz	r2, r1
    8e94:	e262201f 	rsb	r2, r2, #31
    8e98:	e1a00230 	lsr	r0, r0, r2
    8e9c:	e12fff1e 	bx	lr
    8ea0:	e3500000 	cmp	r0, #0
    8ea4:	13e00000 	mvnne	r0, #0
    8ea8:	ea000007 	b	8ecc <__aeabi_idiv0>

00008eac <__aeabi_uidivmod>:
__aeabi_uidivmod():
    8eac:	e3510000 	cmp	r1, #0
    8eb0:	0afffffa 	beq	8ea0 <__udivsi3+0x1e0>
    8eb4:	e92d4003 	push	{r0, r1, lr}
    8eb8:	ebffff80 	bl	8cc0 <__udivsi3>
    8ebc:	e8bd4006 	pop	{r1, r2, lr}
    8ec0:	e0030092 	mul	r3, r2, r0
    8ec4:	e0411003 	sub	r1, r1, r3
    8ec8:	e12fff1e 	bx	lr

00008ecc <__aeabi_idiv0>:
__aeabi_ldiv0():
    8ecc:	e12fff1e 	bx	lr

Disassembly of section .rodata:

00008ed0 <_ZL13Lock_Unlocked>:
    8ed0:	00000000 	andeq	r0, r0, r0

00008ed4 <_ZL11Lock_Locked>:
    8ed4:	00000001 	andeq	r0, r0, r1

00008ed8 <_ZL21MaxFSDriverNameLength>:
    8ed8:	00000010 	andeq	r0, r0, r0, lsl r0

00008edc <_ZL17MaxFilenameLength>:
    8edc:	00000010 	andeq	r0, r0, r0, lsl r0

00008ee0 <_ZL13MaxPathLength>:
    8ee0:	00000080 	andeq	r0, r0, r0, lsl #1

00008ee4 <_ZL18NoFilesystemDriver>:
    8ee4:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008ee8 <_ZL9NotifyAll>:
    8ee8:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008eec <_ZL24Max_Process_Opened_Files>:
    8eec:	00000010 	andeq	r0, r0, r0, lsl r0

00008ef0 <_ZL10Indefinite>:
    8ef0:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008ef4 <_ZL18Deadline_Unchanged>:
    8ef4:	fffffffe 			; <UNDEFINED> instruction: 0xfffffffe

00008ef8 <_ZL14Invalid_Handle>:
    8ef8:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
    8efc:	3a564544 	bcc	159a414 <__bss_end+0x1591488>
    8f00:	74726175 	ldrbtvc	r6, [r2], #-373	; 0xfffffe8b
    8f04:	0000302f 	andeq	r3, r0, pc, lsr #32
    8f08:	67676f4c 	strbvs	r6, [r7, -ip, asr #30]!
    8f0c:	74207265 	strtvc	r7, [r0], #-613	; 0xfffffd9b
    8f10:	206b7361 	rsbcs	r7, fp, r1, ror #6
    8f14:	72617473 	rsbvc	r7, r1, #1929379840	; 0x73000000
    8f18:	676e6974 			; <UNDEFINED> instruction: 0x676e6974
    8f1c:	00000021 	andeq	r0, r0, r1, lsr #32
    8f20:	00676f6c 	rsbeq	r6, r7, ip, ror #30
    8f24:	205b0a0d 	subscs	r0, fp, sp, lsl #20
    8f28:	00000000 	andeq	r0, r0, r0
    8f2c:	00203a5d 	eoreq	r3, r0, sp, asr sl

00008f30 <_ZL13Lock_Unlocked>:
    8f30:	00000000 	andeq	r0, r0, r0

00008f34 <_ZL11Lock_Locked>:
    8f34:	00000001 	andeq	r0, r0, r1

00008f38 <_ZL21MaxFSDriverNameLength>:
    8f38:	00000010 	andeq	r0, r0, r0, lsl r0

00008f3c <_ZL17MaxFilenameLength>:
    8f3c:	00000010 	andeq	r0, r0, r0, lsl r0

00008f40 <_ZL13MaxPathLength>:
    8f40:	00000080 	andeq	r0, r0, r0, lsl #1

00008f44 <_ZL18NoFilesystemDriver>:
    8f44:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008f48 <_ZL9NotifyAll>:
    8f48:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008f4c <_ZL24Max_Process_Opened_Files>:
    8f4c:	00000010 	andeq	r0, r0, r0, lsl r0

00008f50 <_ZL10Indefinite>:
    8f50:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008f54 <_ZL18Deadline_Unchanged>:
    8f54:	fffffffe 			; <UNDEFINED> instruction: 0xfffffffe

00008f58 <_ZL14Invalid_Handle>:
    8f58:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008f5c <_ZL16Pipe_File_Prefix>:
    8f5c:	3a535953 	bcc	14df4b0 <__bss_end+0x14d6524>
    8f60:	65706970 	ldrbvs	r6, [r0, #-2416]!	; 0xfffff690
    8f64:	0000002f 	andeq	r0, r0, pc, lsr #32

00008f68 <_ZN12_GLOBAL__N_1L11CharConvArrE>:
    8f68:	33323130 	teqcc	r2, #48, 2
    8f6c:	37363534 			; <UNDEFINED> instruction: 0x37363534
    8f70:	42413938 	submi	r3, r1, #56, 18	; 0xe0000
    8f74:	46454443 	strbmi	r4, [r5], -r3, asr #8
	...

Disassembly of section .bss:

00008f7c <__bss_start>:
	...

Disassembly of section .ARM.attributes:

00000000 <.ARM.attributes>:
   0:	00002e41 	andeq	r2, r0, r1, asr #28
   4:	61656100 	cmnvs	r5, r0, lsl #2
   8:	01006962 	tsteq	r0, r2, ror #18
   c:	00000024 	andeq	r0, r0, r4, lsr #32
  10:	4b5a3605 	blmi	168d82c <__bss_end+0x16848a0>
  14:	08070600 	stmdaeq	r7, {r9, sl}
  18:	0a010901 	beq	42424 <__bss_end+0x39498>
  1c:	14041202 	strne	r1, [r4], #-514	; 0xfffffdfe
  20:	17011501 	strne	r1, [r1, -r1, lsl #10]
  24:	1a011803 	bne	46038 <__bss_end+0x3d0ac>
  28:	22011c01 	andcs	r1, r1, #256	; 0x100
  2c:	Address 0x000000000000002c is out of bounds.


Disassembly of section .comment:

00000000 <.comment>:
   0:	3a434347 	bcc	10d0d24 <__bss_end+0x10c7d98>
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
  38:	7a617661 	bvc	185d9c4 <__bss_end+0x1854a38>
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
  c0:	6a757a61 	bvs	1d5ea4c <__bss_end+0x1d55ac0>
  c4:	2f696369 	svccs	0x00696369
  c8:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
  cc:	73656d65 	cmnvc	r5, #6464	; 0x1940
  d0:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
  d4:	6b2d616b 	blvs	b58688 <__bss_end+0xb4f6fc>
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
 144:	fb010200 	blx	4094e <__bss_end+0x379c2>
 148:	01000d0e 	tsteq	r0, lr, lsl #26
 14c:	00010101 	andeq	r0, r1, r1, lsl #2
 150:	00010000 	andeq	r0, r1, r0
 154:	552f0100 	strpl	r0, [pc, #-256]!	; 5c <shift+0x5c>
 158:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 15c:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 160:	6a726574 	bvs	1c99738 <__bss_end+0x1c907ac>
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
 198:	752f7365 	strvc	r7, [pc, #-869]!	; fffffe3b <__bss_end+0xffff6eaf>
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
 1d0:	0a05830b 	beq	160e04 <__bss_end+0x157e78>
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
 1fc:	4a030402 	bmi	c120c <__bss_end+0xb8280>
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
 230:	4a020402 	bmi	81240 <__bss_end+0x782b4>
 234:	02000205 	andeq	r0, r0, #1342177280	; 0x50000000
 238:	052d0204 	streq	r0, [sp, #-516]!	; 0xfffffdfc
 23c:	01058509 	tsteq	r5, r9, lsl #10
 240:	000a022f 	andeq	r0, sl, pc, lsr #4
 244:	02df0101 	sbcseq	r0, pc, #1073741824	; 0x40000000
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
 280:	6a757a61 	bvs	1d5ec0c <__bss_end+0x1d55c80>
 284:	2f696369 	svccs	0x00696369
 288:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
 28c:	73656d65 	cmnvc	r5, #6464	; 0x1940
 290:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
 294:	6b2d616b 	blvs	b58848 <__bss_end+0xb4f8bc>
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
 2cc:	6b736544 	blvs	1cd97e4 <__bss_end+0x1cd0858>
 2d0:	2f706f74 	svccs	0x00706f74
 2d4:	2f564146 	svccs	0x00564146
 2d8:	6176614e 	cmnvs	r6, lr, asr #2
 2dc:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
 2e0:	4f2f6963 	svcmi	0x002f6963
 2e4:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
 2e8:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
 2ec:	6b6c6172 	blvs	1b188bc <__bss_end+0x1b0f930>
 2f0:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
 2f4:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
 2f8:	756f732f 	strbvc	r7, [pc, #-815]!	; ffffffd1 <__bss_end+0xffff7045>
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
 344:	6a757a61 	bvs	1d5ecd0 <__bss_end+0x1d55d44>
 348:	2f696369 	svccs	0x00696369
 34c:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
 350:	73656d65 	cmnvc	r5, #6464	; 0x1940
 354:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
 358:	6b2d616b 	blvs	b5890c <__bss_end+0xb4f980>
 35c:	6f2d7669 	svcvs	0x002d7669
 360:	6f732f73 	svcvs	0x00732f73
 364:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
 368:	73752f73 	cmnvc	r5, #460	; 0x1cc
 36c:	70737265 	rsbsvc	r7, r3, r5, ror #4
 370:	2f656361 	svccs	0x00656361
 374:	6b2f2e2e 	blvs	bcbc34 <__bss_end+0xbc2ca8>
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
 3a8:	6a757a61 	bvs	1d5ed34 <__bss_end+0x1d55da8>
 3ac:	2f696369 	svccs	0x00696369
 3b0:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
 3b4:	73656d65 	cmnvc	r5, #6464	; 0x1940
 3b8:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
 3bc:	6b2d616b 	blvs	b58970 <__bss_end+0xb4f9e4>
 3c0:	6f2d7669 	svcvs	0x002d7669
 3c4:	6f732f73 	svcvs	0x00732f73
 3c8:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
 3cc:	73752f73 	cmnvc	r5, #460	; 0x1cc
 3d0:	70737265 	rsbsvc	r7, r3, r5, ror #4
 3d4:	2f656361 	svccs	0x00656361
 3d8:	6b2f2e2e 	blvs	bcbc98 <__bss_end+0xbc2d0c>
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
 404:	6a726574 	bvs	1c999dc <__bss_end+0x1c90a50>
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
 4f0:	1b056983 	blne	15ab04 <__bss_end+0x151b78>
 4f4:	8513059f 	ldrhi	r0, [r3, #-1439]	; 0xfffffa61
 4f8:	054b1505 	strbeq	r1, [fp, #-1285]	; 0xfffffafb
 4fc:	6aa04b07 	bvs	fe813120 <__bss_end+0xfe80a194>
 500:	840b0583 	strhi	r0, [fp], #-1411	; 0xfffffa7d
 504:	054c1905 	strbeq	r1, [ip, #-2309]	; 0xfffff6fb
 508:	14058607 	strne	r8, [r5], #-1543	; 0xfffff9f9
 50c:	bb030584 	bllt	c1b24 <__bss_end+0xb8b98>
 510:	05680b05 	strbeq	r0, [r8, #-2821]!	; 0xfffff4fb
 514:	22059f09 	andcs	r9, r5, #9, 30	; 0x24
 518:	4b080567 	blmi	201abc <__bss_end+0x1f8b30>
 51c:	839f0905 	orrshi	r0, pc, #81920	; 0x14000
 520:	84020567 	strhi	r0, [r2], #-1383	; 0xfffffa99
 524:	01000e02 	tsteq	r0, r2, lsl #28
 528:	0002c801 	andeq	ip, r2, r1, lsl #16
 52c:	dd000300 	stcle	3, cr0, [r0, #-0]
 530:	02000001 	andeq	r0, r0, #1
 534:	0d0efb01 	vstreq	d15, [lr, #-4]
 538:	01010100 	mrseq	r0, (UNDEF: 17)
 53c:	00000001 	andeq	r0, r0, r1
 540:	01000001 	tsteq	r0, r1
 544:	6573552f 	ldrbvs	r5, [r3, #-1327]!	; 0xfffffad1
 548:	772f7372 			; <UNDEFINED> instruction: 0x772f7372
 54c:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
 550:	2f696a72 	svccs	0x00696a72
 554:	6b736544 	blvs	1cd9a6c <__bss_end+0x1cd0ae0>
 558:	2f706f74 	svccs	0x00706f74
 55c:	2f564146 	svccs	0x00564146
 560:	6176614e 	cmnvs	r6, lr, asr #2
 564:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
 568:	4f2f6963 	svcmi	0x002f6963
 56c:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
 570:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
 574:	6b6c6172 	blvs	1b18b44 <__bss_end+0x1b0fbb8>
 578:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
 57c:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
 580:	756f732f 	strbvc	r7, [pc, #-815]!	; 259 <shift+0x259>
 584:	73656372 	cmnvc	r5, #-939524095	; 0xc8000001
 588:	6474732f 	ldrbtvs	r7, [r4], #-815	; 0xfffffcd1
 58c:	2f62696c 	svccs	0x0062696c
 590:	00637273 	rsbeq	r7, r3, r3, ror r2
 594:	6573552f 	ldrbvs	r5, [r3, #-1327]!	; 0xfffffad1
 598:	772f7372 			; <UNDEFINED> instruction: 0x772f7372
 59c:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
 5a0:	2f696a72 	svccs	0x00696a72
 5a4:	6b736544 	blvs	1cd9abc <__bss_end+0x1cd0b30>
 5a8:	2f706f74 	svccs	0x00706f74
 5ac:	2f564146 	svccs	0x00564146
 5b0:	6176614e 	cmnvs	r6, lr, asr #2
 5b4:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
 5b8:	4f2f6963 	svcmi	0x002f6963
 5bc:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
 5c0:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
 5c4:	6b6c6172 	blvs	1b18b94 <__bss_end+0x1b0fc08>
 5c8:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
 5cc:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
 5d0:	756f732f 	strbvc	r7, [pc, #-815]!	; 2a9 <shift+0x2a9>
 5d4:	73656372 	cmnvc	r5, #-939524095	; 0xc8000001
 5d8:	72656b2f 	rsbvc	r6, r5, #48128	; 0xbc00
 5dc:	2f6c656e 	svccs	0x006c656e
 5e0:	6c636e69 	stclvs	14, cr6, [r3], #-420	; 0xfffffe5c
 5e4:	2f656475 	svccs	0x00656475
 5e8:	636f7270 	cmnvs	pc, #112, 4
 5ec:	00737365 	rsbseq	r7, r3, r5, ror #6
 5f0:	6573552f 	ldrbvs	r5, [r3, #-1327]!	; 0xfffffad1
 5f4:	772f7372 			; <UNDEFINED> instruction: 0x772f7372
 5f8:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
 5fc:	2f696a72 	svccs	0x00696a72
 600:	6b736544 	blvs	1cd9b18 <__bss_end+0x1cd0b8c>
 604:	2f706f74 	svccs	0x00706f74
 608:	2f564146 	svccs	0x00564146
 60c:	6176614e 	cmnvs	r6, lr, asr #2
 610:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
 614:	4f2f6963 	svcmi	0x002f6963
 618:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
 61c:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
 620:	6b6c6172 	blvs	1b18bf0 <__bss_end+0x1b0fc64>
 624:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
 628:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
 62c:	756f732f 	strbvc	r7, [pc, #-815]!	; 305 <shift+0x305>
 630:	73656372 	cmnvc	r5, #-939524095	; 0xc8000001
 634:	72656b2f 	rsbvc	r6, r5, #48128	; 0xbc00
 638:	2f6c656e 	svccs	0x006c656e
 63c:	6c636e69 	stclvs	14, cr6, [r3], #-420	; 0xfffffe5c
 640:	2f656475 	svccs	0x00656475
 644:	2f007366 	svccs	0x00007366
 648:	72657355 	rsbvc	r7, r5, #1409286145	; 0x54000001
 64c:	69772f73 	ldmdbvs	r7!, {r0, r1, r4, r5, r6, r8, r9, sl, fp, sp}^
 650:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
 654:	442f696a 	strtmi	r6, [pc], #-2410	; 65c <shift+0x65c>
 658:	746b7365 	strbtvc	r7, [fp], #-869	; 0xfffffc9b
 65c:	462f706f 	strtmi	r7, [pc], -pc, rrx
 660:	4e2f5641 	cfmadda32mi	mvax2, mvax5, mvfx15, mvfx1
 664:	7a617661 	bvc	185dff0 <__bss_end+0x1855064>
 668:	63696a75 	cmnvs	r9, #479232	; 0x75000
 66c:	534f2f69 	movtpl	r2, #65385	; 0xff69
 670:	6d65732f 	stclvs	3, cr7, [r5, #-188]!	; 0xffffff44
 674:	72747365 	rsbsvc	r7, r4, #-1811939327	; 0x94000001
 678:	616b6c61 	cmnvs	fp, r1, ror #24
 67c:	76696b2d 	strbtvc	r6, [r9], -sp, lsr #22
 680:	2f736f2d 	svccs	0x00736f2d
 684:	72756f73 	rsbsvc	r6, r5, #460	; 0x1cc
 688:	2f736563 	svccs	0x00736563
 68c:	6e72656b 	cdpvs	5, 7, cr6, cr2, cr11, {3}
 690:	692f6c65 	stmdbvs	pc!, {r0, r2, r5, r6, sl, fp, sp, lr}	; <UNPREDICTABLE>
 694:	756c636e 	strbvc	r6, [ip, #-878]!	; 0xfffffc92
 698:	622f6564 	eorvs	r6, pc, #100, 10	; 0x19000000
 69c:	6472616f 	ldrbtvs	r6, [r2], #-367	; 0xfffffe91
 6a0:	6970722f 	ldmdbvs	r0!, {r0, r1, r2, r3, r5, r9, ip, sp, lr}^
 6a4:	61682f30 	cmnvs	r8, r0, lsr pc
 6a8:	7300006c 	movwvc	r0, #108	; 0x6c
 6ac:	69666474 	stmdbvs	r6!, {r2, r4, r5, r6, sl, sp, lr}^
 6b0:	632e656c 			; <UNDEFINED> instruction: 0x632e656c
 6b4:	01007070 	tsteq	r0, r0, ror r0
 6b8:	77730000 	ldrbvc	r0, [r3, -r0]!
 6bc:	00682e69 	rsbeq	r2, r8, r9, ror #28
 6c0:	73000002 	movwvc	r0, #2
 6c4:	6c6e6970 			; <UNDEFINED> instruction: 0x6c6e6970
 6c8:	2e6b636f 	cdpcs	3, 6, cr6, cr11, cr15, {3}
 6cc:	00020068 	andeq	r0, r2, r8, rrx
 6d0:	6c696600 	stclvs	6, cr6, [r9], #-0
 6d4:	73797365 	cmnvc	r9, #-1811939327	; 0x94000001
 6d8:	2e6d6574 	mcrcs	5, 3, r6, cr13, cr4, {3}
 6dc:	00030068 	andeq	r0, r3, r8, rrx
 6e0:	6f727000 	svcvs	0x00727000
 6e4:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
 6e8:	0200682e 	andeq	r6, r0, #3014656	; 0x2e0000
 6ec:	72700000 	rsbsvc	r0, r0, #0
 6f0:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
 6f4:	616d5f73 	smcvs	54771	; 0xd5f3
 6f8:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
 6fc:	00682e72 	rsbeq	r2, r8, r2, ror lr
 700:	69000002 	stmdbvs	r0, {r1}
 704:	6564746e 	strbvs	r7, [r4, #-1134]!	; 0xfffffb92
 708:	00682e66 	rsbeq	r2, r8, r6, ror #28
 70c:	00000004 	andeq	r0, r0, r4
 710:	05000105 	streq	r0, [r0, #-261]	; 0xfffffefb
 714:	0083ac02 	addeq	sl, r3, r2, lsl #24
 718:	05051600 	streq	r1, [r5, #-1536]	; 0xfffffa00
 71c:	0c052f69 	stceq	15, cr2, [r5], {105}	; 0x69
 720:	2f01054c 	svccs	0x0001054c
 724:	83050585 	movwhi	r0, #21893	; 0x5585
 728:	2f01054b 	svccs	0x0001054b
 72c:	4b050585 	blmi	141d48 <__bss_end+0x138dbc>
 730:	852f0105 	strhi	r0, [pc, #-261]!	; 633 <shift+0x633>
 734:	4ba10505 	blmi	fe841b50 <__bss_end+0xfe838bc4>
 738:	0c052f4b 	stceq	15, cr2, [r5], {75}	; 0x4b
 73c:	2f01054b 	svccs	0x0001054b
 740:	bd050585 	cfstr32lt	mvfx0, [r5, #-532]	; 0xfffffdec
 744:	2f4b4b4b 	svccs	0x004b4b4b
 748:	054c0c05 	strbeq	r0, [ip, #-3077]	; 0xfffff3fb
 74c:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 750:	4b4bbd05 	blmi	12efb6c <__bss_end+0x12e6be0>
 754:	0c052f4b 	stceq	15, cr2, [r5], {75}	; 0x4b
 758:	2f01054c 	svccs	0x0001054c
 75c:	83050585 	movwhi	r0, #21893	; 0x5585
 760:	2f01054b 	svccs	0x0001054b
 764:	bd050585 	cfstr32lt	mvfx0, [r5, #-532]	; 0xfffffdec
 768:	2f4b4b4b 	svccs	0x004b4b4b
 76c:	054c0c05 	strbeq	r0, [ip, #-3077]	; 0xfffff3fb
 770:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 774:	4b4ba105 	blmi	12e8b90 <__bss_end+0x12dfc04>
 778:	4c0c052f 	cfstr32mi	mvfx0, [ip], {47}	; 0x2f
 77c:	852f0105 	strhi	r0, [pc, #-261]!	; 67f <shift+0x67f>
 780:	4bbd0505 	blmi	fef41b9c <__bss_end+0xfef38c10>
 784:	052f4b4b 	streq	r4, [pc, #-2891]!	; fffffc41 <__bss_end+0xffff6cb5>
 788:	01054c0c 	tsteq	r5, ip, lsl #24
 78c:	0505852f 	streq	r8, [r5, #-1327]	; 0xfffffad1
 790:	2f4b4ba1 	svccs	0x004b4ba1
 794:	054c0c05 	strbeq	r0, [ip, #-3077]	; 0xfffff3fb
 798:	05859f01 	streq	r9, [r5, #3841]	; 0xf01
 79c:	05056720 	streq	r6, [r5, #-1824]	; 0xfffff8e0
 7a0:	054b4b4d 	strbeq	r4, [fp, #-2893]	; 0xfffff4b3
 7a4:	0105300c 	tsteq	r5, ip
 7a8:	2005852f 	andcs	r8, r5, pc, lsr #10
 7ac:	4d050567 	cfstr32mi	mvfx0, [r5, #-412]	; 0xfffffe64
 7b0:	0c054b4b 			; <UNDEFINED> instruction: 0x0c054b4b
 7b4:	2f010530 	svccs	0x00010530
 7b8:	83200585 			; <UNDEFINED> instruction: 0x83200585
 7bc:	4b4c0505 	blmi	1301bd8 <__bss_end+0x12f8c4c>
 7c0:	2f01054b 	svccs	0x0001054b
 7c4:	67200585 	strvs	r0, [r0, -r5, lsl #11]!
 7c8:	4b4d0505 	blmi	1341be4 <__bss_end+0x1338c58>
 7cc:	300c054b 	andcc	r0, ip, fp, asr #10
 7d0:	872f0105 	strhi	r0, [pc, -r5, lsl #2]!
 7d4:	9fa00c05 	svcls	0x00a00c05
 7d8:	05bc3105 	ldreq	r3, [ip, #261]!	; 0x105
 7dc:	36056629 	strcc	r6, [r5], -r9, lsr #12
 7e0:	300f052e 	andcc	r0, pc, lr, lsr #10
 7e4:	05661305 	strbeq	r1, [r6, #-773]!	; 0xfffffcfb
 7e8:	10058409 	andne	r8, r5, r9, lsl #8
 7ec:	9f0105d8 	svcls	0x000105d8
 7f0:	01000802 	tsteq	r0, r2, lsl #16
 7f4:	00029b01 	andeq	r9, r2, r1, lsl #22
 7f8:	74000300 	strvc	r0, [r0], #-768	; 0xfffffd00
 7fc:	02000000 	andeq	r0, r0, #0
 800:	0d0efb01 	vstreq	d15, [lr, #-4]
 804:	01010100 	mrseq	r0, (UNDEF: 17)
 808:	00000001 	andeq	r0, r0, r1
 80c:	01000001 	tsteq	r0, r1
 810:	6573552f 	ldrbvs	r5, [r3, #-1327]!	; 0xfffffad1
 814:	772f7372 			; <UNDEFINED> instruction: 0x772f7372
 818:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
 81c:	2f696a72 	svccs	0x00696a72
 820:	6b736544 	blvs	1cd9d38 <__bss_end+0x1cd0dac>
 824:	2f706f74 	svccs	0x00706f74
 828:	2f564146 	svccs	0x00564146
 82c:	6176614e 	cmnvs	r6, lr, asr #2
 830:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
 834:	4f2f6963 	svcmi	0x002f6963
 838:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
 83c:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
 840:	6b6c6172 	blvs	1b18e10 <__bss_end+0x1b0fe84>
 844:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
 848:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
 84c:	756f732f 	strbvc	r7, [pc, #-815]!	; 525 <shift+0x525>
 850:	73656372 	cmnvc	r5, #-939524095	; 0xc8000001
 854:	6474732f 	ldrbtvs	r7, [r4], #-815	; 0xfffffcd1
 858:	2f62696c 	svccs	0x0062696c
 85c:	00637273 	rsbeq	r7, r3, r3, ror r2
 860:	64747300 	ldrbtvs	r7, [r4], #-768	; 0xfffffd00
 864:	69727473 	ldmdbvs	r2!, {r0, r1, r4, r5, r6, sl, ip, sp, lr}^
 868:	632e676e 			; <UNDEFINED> instruction: 0x632e676e
 86c:	01007070 	tsteq	r0, r0, ror r0
 870:	05000000 	streq	r0, [r0, #-0]
 874:	02050001 	andeq	r0, r5, #1
 878:	00008808 	andeq	r8, r0, r8, lsl #16
 87c:	bb06051a 	bllt	181cec <__bss_end+0x178d60>
 880:	054c0f05 	strbeq	r0, [ip, #-3845]	; 0xfffff0fb
 884:	0a056821 	beq	15a910 <__bss_end+0x151984>
 888:	2e0b05ba 	mcrcs	5, 0, r0, cr11, cr10, {5}
 88c:	054a2705 	strbeq	r2, [sl, #-1797]	; 0xfffff8fb
 890:	09054a0d 	stmdbeq	r5, {r0, r2, r3, r9, fp, lr}
 894:	9f04052f 	svcls	0x0004052f
 898:	05620205 	strbeq	r0, [r2, #-517]!	; 0xfffffdfb
 89c:	10053505 	andne	r3, r5, r5, lsl #10
 8a0:	2e110568 	cfmsc32cs	mvfx0, mvfx1, mvfx8
 8a4:	054a2205 	strbeq	r2, [sl, #-517]	; 0xfffffdfb
 8a8:	0a052e13 	beq	14c0fc <__bss_end+0x143170>
 8ac:	6909052f 	stmdbvs	r9, {r0, r1, r2, r3, r5, r8, sl}
 8b0:	052e0a05 	streq	r0, [lr, #-2565]!	; 0xfffff5fb
 8b4:	03054a0c 	movweq	r4, #23052	; 0x5a0c
 8b8:	680b054b 	stmdavs	fp, {r0, r1, r3, r6, r8, sl}
 8bc:	02001805 	andeq	r1, r0, #327680	; 0x50000
 8c0:	054a0304 	strbeq	r0, [sl, #-772]	; 0xfffffcfc
 8c4:	04020014 	streq	r0, [r2], #-20	; 0xffffffec
 8c8:	15059e03 	strne	r9, [r5, #-3587]	; 0xfffff1fd
 8cc:	02040200 	andeq	r0, r4, #0, 4
 8d0:	00180568 	andseq	r0, r8, r8, ror #10
 8d4:	82020402 	andhi	r0, r2, #33554432	; 0x2000000
 8d8:	02000805 	andeq	r0, r0, #327680	; 0x50000
 8dc:	054a0204 	strbeq	r0, [sl, #-516]	; 0xfffffdfc
 8e0:	0402001a 	streq	r0, [r2], #-26	; 0xffffffe6
 8e4:	1b054b02 	blne	1534f4 <__bss_end+0x14a568>
 8e8:	02040200 	andeq	r0, r4, #0, 4
 8ec:	000c052e 	andeq	r0, ip, lr, lsr #10
 8f0:	4a020402 	bmi	81900 <__bss_end+0x78974>
 8f4:	02000f05 	andeq	r0, r0, #5, 30
 8f8:	05820204 	streq	r0, [r2, #516]	; 0x204
 8fc:	0402001b 	streq	r0, [r2], #-27	; 0xffffffe5
 900:	11054a02 	tstne	r5, r2, lsl #20
 904:	02040200 	andeq	r0, r4, #0, 4
 908:	000a052e 	andeq	r0, sl, lr, lsr #10
 90c:	2f020402 	svccs	0x00020402
 910:	02000b05 	andeq	r0, r0, #5120	; 0x1400
 914:	052e0204 	streq	r0, [lr, #-516]!	; 0xfffffdfc
 918:	0402000d 	streq	r0, [r2], #-13
 91c:	02054a02 	andeq	r4, r5, #8192	; 0x2000
 920:	02040200 	andeq	r0, r4, #0, 4
 924:	88010546 	stmdahi	r1, {r1, r2, r6, r8, sl}
 928:	83060585 	movwhi	r0, #25989	; 0x6585
 92c:	054c0905 	strbeq	r0, [ip, #-2309]	; 0xfffff6fb
 930:	0a054a10 	beq	153178 <__bss_end+0x14a1ec>
 934:	bb07054c 	bllt	1c1e6c <__bss_end+0x1b8ee0>
 938:	054a0305 	strbeq	r0, [sl, #-773]	; 0xfffffcfb
 93c:	04020017 	streq	r0, [r2], #-23	; 0xffffffe9
 940:	14054a01 	strne	r4, [r5], #-2561	; 0xfffff5ff
 944:	01040200 	mrseq	r0, R12_usr
 948:	4d0d054a 	cfstr32mi	mvfx0, [sp, #-296]	; 0xfffffed8
 94c:	054a1405 	strbeq	r1, [sl, #-1029]	; 0xfffffbfb
 950:	08052e0a 	stmdaeq	r5, {r1, r3, r9, sl, fp, sp}
 954:	03020568 	movweq	r0, #9576	; 0x2568
 958:	09056678 	stmdbeq	r5, {r3, r4, r5, r6, r9, sl, sp, lr}
 95c:	052e0b03 	streq	r0, [lr, #-2819]!	; 0xfffff4fd
 960:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 964:	1605bd09 	strne	fp, [r5], -r9, lsl #26
 968:	04040200 	streq	r0, [r4], #-512	; 0xfffffe00
 96c:	001d054a 	andseq	r0, sp, sl, asr #10
 970:	82020402 	andhi	r0, r2, #33554432	; 0x2000000
 974:	02001e05 	andeq	r1, r0, #5, 28	; 0x50
 978:	052e0204 	streq	r0, [lr, #-516]!	; 0xfffffdfc
 97c:	04020016 	streq	r0, [r2], #-22	; 0xffffffea
 980:	11056602 	tstne	r5, r2, lsl #12
 984:	03040200 	movweq	r0, #16896	; 0x4200
 988:	0012054b 	andseq	r0, r2, fp, asr #10
 98c:	2e030402 	cdpcs	4, 0, cr0, cr3, cr2, {0}
 990:	02000805 	andeq	r0, r0, #327680	; 0x50000
 994:	054a0304 	strbeq	r0, [sl, #-772]	; 0xfffffcfc
 998:	04020009 	streq	r0, [r2], #-9
 99c:	12052e03 	andne	r2, r5, #3, 28	; 0x30
 9a0:	03040200 	movweq	r0, #16896	; 0x4200
 9a4:	000b054a 	andeq	r0, fp, sl, asr #10
 9a8:	2e030402 	cdpcs	4, 0, cr0, cr3, cr2, {0}
 9ac:	02000205 	andeq	r0, r0, #1342177280	; 0x50000000
 9b0:	052d0304 	streq	r0, [sp, #-772]!	; 0xfffffcfc
 9b4:	0402000b 	streq	r0, [r2], #-11
 9b8:	08058402 	stmdaeq	r5, {r1, sl, pc}
 9bc:	01040200 	mrseq	r0, R12_usr
 9c0:	00090583 	andeq	r0, r9, r3, lsl #11
 9c4:	2e010402 	cdpcs	4, 0, cr0, cr1, cr2, {0}
 9c8:	02000b05 	andeq	r0, r0, #5120	; 0x1400
 9cc:	054a0104 	strbeq	r0, [sl, #-260]	; 0xfffffefc
 9d0:	04020002 	streq	r0, [r2], #-2
 9d4:	0b054901 	bleq	152de0 <__bss_end+0x149e54>
 9d8:	2f010585 	svccs	0x00010585
 9dc:	bc0e0585 	cfstr32lt	mvfx0, [lr], {133}	; 0x85
 9e0:	05661105 	strbeq	r1, [r6, #-261]!	; 0xfffffefb
 9e4:	0b05bc20 	bleq	16fa6c <__bss_end+0x166ae0>
 9e8:	4b1f0566 	blmi	7c1f88 <__bss_end+0x7b8ffc>
 9ec:	05660a05 	strbeq	r0, [r6, #-2565]!	; 0xfffff5fb
 9f0:	11054b08 	tstne	r5, r8, lsl #22
 9f4:	2e160583 	cdpcs	5, 1, cr0, cr6, cr3, {4}
 9f8:	05670805 	strbeq	r0, [r7, #-2053]!	; 0xfffff7fb
 9fc:	0b056711 	bleq	15a648 <__bss_end+0x1516bc>
 a00:	2f01054d 	svccs	0x0001054d
 a04:	83060585 	movwhi	r0, #25989	; 0x6585
 a08:	054c0b05 	strbeq	r0, [ip, #-2821]	; 0xfffff4fb
 a0c:	0e052e0c 	cdpeq	14, 0, cr2, cr5, cr12, {0}
 a10:	4b040566 	blmi	101fb0 <__bss_end+0xf9024>
 a14:	05650205 	strbeq	r0, [r5, #-517]!	; 0xfffffdfb
 a18:	01053109 	tsteq	r5, r9, lsl #2
 a1c:	0805852f 	stmdaeq	r5, {r0, r1, r2, r3, r5, r8, sl, pc}
 a20:	4c0b059f 	cfstr32mi	mvfx0, [fp], {159}	; 0x9f
 a24:	02001405 	andeq	r1, r0, #83886080	; 0x5000000
 a28:	054a0304 	strbeq	r0, [sl, #-772]	; 0xfffffcfc
 a2c:	04020007 	streq	r0, [r2], #-7
 a30:	08058302 	stmdaeq	r5, {r1, r8, r9, pc}
 a34:	02040200 	andeq	r0, r4, #0, 4
 a38:	000a052e 	andeq	r0, sl, lr, lsr #10
 a3c:	4a020402 	bmi	81a4c <__bss_end+0x78ac0>
 a40:	02000205 	andeq	r0, r0, #1342177280	; 0x50000000
 a44:	05490204 	strbeq	r0, [r9, #-516]	; 0xfffffdfc
 a48:	05858401 	streq	r8, [r5, #1025]	; 0x401
 a4c:	0805bb0e 	stmdaeq	r5, {r1, r2, r3, r8, r9, fp, ip, sp, pc}
 a50:	4c0b054b 	cfstr32mi	mvfx0, [fp], {75}	; 0x4b
 a54:	02001405 	andeq	r1, r0, #83886080	; 0x5000000
 a58:	054a0304 	strbeq	r0, [sl, #-772]	; 0xfffffcfc
 a5c:	04020016 	streq	r0, [r2], #-22	; 0xffffffea
 a60:	17058302 	strne	r8, [r5, -r2, lsl #6]
 a64:	02040200 	andeq	r0, r4, #0, 4
 a68:	000a052e 	andeq	r0, sl, lr, lsr #10
 a6c:	4a020402 	bmi	81a7c <__bss_end+0x78af0>
 a70:	02000b05 	andeq	r0, r0, #5120	; 0x1400
 a74:	052e0204 	streq	r0, [lr, #-516]!	; 0xfffffdfc
 a78:	04020017 	streq	r0, [r2], #-23	; 0xffffffe9
 a7c:	0d054a02 	vstreq	s8, [r5, #-8]
 a80:	02040200 	andeq	r0, r4, #0, 4
 a84:	0002052e 	andeq	r0, r2, lr, lsr #10
 a88:	2d020402 	cfstrscs	mvf0, [r2, #-8]
 a8c:	02840105 	addeq	r0, r4, #1073741825	; 0x40000001
 a90:	01010008 	tsteq	r1, r8

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
      58:	05330704 	ldreq	r0, [r3, #-1796]!	; 0xfffff8fc
      5c:	5b020000 	blpl	80064 <__bss_end+0x770d8>
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
     128:	00000533 	andeq	r0, r0, r3, lsr r5
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
     174:	cb104801 	blgt	412180 <__bss_end+0x4091f4>
     178:	d4000000 	strle	r0, [r0], #-0
     17c:	58000081 	stmdapl	r0, {r0, r7}
     180:	01000000 	mrseq	r0, (UNDEF: 0)
     184:	0000cb9c 	muleq	r0, ip, fp
     188:	02b40a00 	adcseq	r0, r4, #0, 20
     18c:	4a010000 	bmi	40194 <__bss_end+0x37208>
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
     21c:	ba0d9c01 	blt	367228 <__bss_end+0x35e29c>
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
     24c:	8b120f01 	blhi	483e58 <__bss_end+0x47aecc>
     250:	0f000001 	svceq	0x00000001
     254:	0000019e 	muleq	r0, lr, r1
     258:	03d51000 	bicseq	r1, r5, #0
     25c:	0a010000 	beq	40264 <__bss_end+0x372d8>
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
     2b4:	8b140074 	blhi	50048c <__bss_end+0x4f7500>
     2b8:	a4000001 	strge	r0, [r0], #-1
     2bc:	38000080 	stmdacc	r0, {r7}
     2c0:	01000000 	mrseq	r0, (UNDEF: 0)
     2c4:	0067139c 	mlseq	r7, ip, r3, r1
     2c8:	9e2f0a01 	vmulls.f32	s0, s30, s2
     2cc:	02000001 	andeq	r0, r0, #1
     2d0:	00007491 	muleq	r0, r1, r4
     2d4:	00000344 	andeq	r0, r0, r4, asr #6
     2d8:	01e00004 	mvneq	r0, r4
     2dc:	01040000 	mrseq	r0, (UNDEF: 4)
     2e0:	000001e1 	andeq	r0, r0, r1, ror #3
     2e4:	00044204 	andeq	r4, r4, r4, lsl #4
     2e8:	00005600 	andeq	r5, r0, r0, lsl #12
     2ec:	00822c00 	addeq	r2, r2, r0, lsl #24
     2f0:	00018000 	andeq	r8, r1, r0
     2f4:	00024600 	andeq	r4, r2, r0, lsl #12
     2f8:	08010200 	stmdaeq	r1, {r9}
     2fc:	00000516 	andeq	r0, r0, r6, lsl r5
     300:	00002503 	andeq	r2, r0, r3, lsl #10
     304:	05020200 	streq	r0, [r2, #-512]	; 0xfffffe00
     308:	00000653 	andeq	r0, r0, r3, asr r6
     30c:	69050404 	stmdbvs	r5, {r2, sl}
     310:	0200746e 	andeq	r7, r0, #1845493760	; 0x6e000000
     314:	050d0801 	streq	r0, [sp, #-2049]	; 0xfffff7ff
     318:	02020000 	andeq	r0, r2, #0
     31c:	00054a07 	andeq	r4, r5, r7, lsl #20
     320:	067a0500 	ldrbteq	r0, [sl], -r0, lsl #10
     324:	09080000 	stmdbeq	r8, {}	; <UNPREDICTABLE>
     328:	00005e07 	andeq	r5, r0, r7, lsl #28
     32c:	004d0300 	subeq	r0, sp, r0, lsl #6
     330:	04020000 	streq	r0, [r2], #-0
     334:	00053307 	andeq	r3, r5, r7, lsl #6
     338:	06690600 	strbteq	r0, [r9], -r0, lsl #12
     33c:	04050000 	streq	r0, [r5], #-0
     340:	00000038 	andeq	r0, r0, r8, lsr r0
     344:	900c6604 	andls	r6, ip, r4, lsl #12
     348:	07000000 	streq	r0, [r0, -r0]
     34c:	0000057e 	andeq	r0, r0, lr, ror r5
     350:	06480700 	strbeq	r0, [r8], -r0, lsl #14
     354:	07010000 	streq	r0, [r1, -r0]
     358:	000003f9 	strdeq	r0, [r0], -r9
     35c:	06140702 	ldreq	r0, [r4], -r2, lsl #14
     360:	00030000 	andeq	r0, r3, r0
     364:	00060608 	andeq	r0, r6, r8, lsl #12
     368:	14050200 	strne	r0, [r5], #-512	; 0xfffffe00
     36c:	00000059 	andeq	r0, r0, r9, asr r0
     370:	8ed00305 	cdphi	3, 13, cr0, cr0, cr5, {0}
     374:	b3080000 	movwlt	r0, #32768	; 0x8000
     378:	02000004 	andeq	r0, r0, #4
     37c:	00591406 	subseq	r1, r9, r6, lsl #8
     380:	03050000 	movweq	r0, #20480	; 0x5000
     384:	00008ed4 	ldrdeq	r8, [r0], -r4
     388:	00041008 	andeq	r1, r4, r8
     38c:	1a070300 	bne	1c0f94 <__bss_end+0x1b8008>
     390:	00000059 	andeq	r0, r0, r9, asr r0
     394:	8ed80305 	cdphi	3, 13, cr0, cr8, cr5, {0}
     398:	e9080000 	stmdb	r8, {}	; <UNPREDICTABLE>
     39c:	03000004 	movweq	r0, #4
     3a0:	00591a09 	subseq	r1, r9, r9, lsl #20
     3a4:	03050000 	movweq	r0, #20480	; 0x5000
     3a8:	00008edc 	ldrdeq	r8, [r0], -ip
     3ac:	00062c08 	andeq	r2, r6, r8, lsl #24
     3b0:	1a0b0300 	bne	2c0fb8 <__bss_end+0x2b802c>
     3b4:	00000059 	andeq	r0, r0, r9, asr r0
     3b8:	8ee00305 	cdphi	3, 14, cr0, cr0, cr5, {0}
     3bc:	cc080000 	stcgt	0, cr0, [r8], {-0}
     3c0:	03000004 	movweq	r0, #4
     3c4:	00591a0d 	subseq	r1, r9, sp, lsl #20
     3c8:	03050000 	movweq	r0, #20480	; 0x5000
     3cc:	00008ee4 	andeq	r8, r0, r4, ror #29
     3d0:	00055d08 	andeq	r5, r5, r8, lsl #26
     3d4:	1a0f0300 	bne	3c0fdc <__bss_end+0x3b8050>
     3d8:	00000059 	andeq	r0, r0, r9, asr r0
     3dc:	8ee80305 	cdphi	3, 14, cr0, cr8, cr5, {0}
     3e0:	27060000 	strcs	r0, [r6, -r0]
     3e4:	05000010 	streq	r0, [r0, #-16]
     3e8:	00003804 	andeq	r3, r0, r4, lsl #16
     3ec:	0c1b0300 	ldceq	3, cr0, [fp], {-0}
     3f0:	00000133 	andeq	r0, r0, r3, lsr r1
     3f4:	0005fc07 	andeq	pc, r5, r7, lsl #24
     3f8:	89070000 	stmdbhi	r7, {}	; <UNPREDICTABLE>
     3fc:	01000005 	tsteq	r0, r5
     400:	0005be07 	andeq	fp, r5, r7, lsl #28
     404:	09000200 	stmdbeq	r0, {r9}
     408:	00000025 	andeq	r0, r0, r5, lsr #32
     40c:	00000143 	andeq	r0, r0, r3, asr #2
     410:	00005e0a 	andeq	r5, r0, sl, lsl #28
     414:	02000f00 	andeq	r0, r0, #0, 30
     418:	04a60201 	strteq	r0, [r6], #513	; 0x201
     41c:	040b0000 	streq	r0, [fp], #-0
     420:	0000002c 	andeq	r0, r0, ip, lsr #32
     424:	00059d08 	andeq	r9, r5, r8, lsl #26
     428:	14040500 	strne	r0, [r4], #-1280	; 0xfffffb00
     42c:	00000059 	andeq	r0, r0, r9, asr r0
     430:	8eec0305 	cdphi	3, 14, cr0, cr12, cr5, {0}
     434:	dd080000 	stcle	0, cr0, [r8, #-0]
     438:	05000005 	streq	r0, [r0, #-5]
     43c:	00591407 	subseq	r1, r9, r7, lsl #8
     440:	03050000 	movweq	r0, #20480	; 0x5000
     444:	00008ef0 	strdeq	r8, [r0], -r0
     448:	00051b08 	andeq	r1, r5, r8, lsl #22
     44c:	140a0500 	strne	r0, [sl], #-1280	; 0xfffffb00
     450:	00000059 	andeq	r0, r0, r9, asr r0
     454:	8ef40305 	cdphi	3, 15, cr0, cr4, cr5, {0}
     458:	04020000 	streq	r0, [r2], #-0
     45c:	00052e07 	andeq	r2, r5, r7, lsl #28
     460:	05c90800 	strbeq	r0, [r9, #2048]	; 0x800
     464:	0a060000 	beq	18046c <__bss_end+0x1774e0>
     468:	00005914 	andeq	r5, r0, r4, lsl r9
     46c:	f8030500 			; <UNDEFINED> instruction: 0xf8030500
     470:	0600008e 	streq	r0, [r0], -lr, lsl #1
     474:	00000426 	andeq	r0, r0, r6, lsr #8
     478:	00380405 	eorseq	r0, r8, r5, lsl #8
     47c:	03070000 	movweq	r0, #28672	; 0x7000
     480:	0001be0c 	andeq	fp, r1, ip, lsl #28
     484:	05670700 	strbeq	r0, [r7, #-1792]!	; 0xfffff900
     488:	07000000 	streq	r0, [r0, -r0]
     48c:	0000056e 	andeq	r0, r0, lr, ror #10
     490:	e9060001 	stmdb	r6, {r0}
     494:	05000003 	streq	r0, [r0, #-3]
     498:	00003804 	andeq	r3, r0, r4, lsl #16
     49c:	0c090700 	stceq	7, cr0, [r9], {-0}
     4a0:	0000020b 	andeq	r0, r0, fp, lsl #4
     4a4:	0005e80c 	andeq	lr, r5, ip, lsl #16
     4a8:	0c04b000 	stceq	0, cr11, [r4], {-0}
     4ac:	000005b6 			; <UNDEFINED> instruction: 0x000005b6
     4b0:	050c0960 	streq	r0, [ip, #-2400]	; 0xfffff6a0
     4b4:	c0000005 	andgt	r0, r0, r5
     4b8:	04ab0c12 	strteq	r0, [fp], #3090	; 0xc12
     4bc:	25800000 	strcs	r0, [r0]
     4c0:	0005940c 	andeq	r9, r5, ip, lsl #8
     4c4:	0c4b0000 	mareq	acc0, r0, fp
     4c8:	00000575 	andeq	r0, r0, r5, ror r5
     4cc:	3f0c9600 	svccc	0x000c9600
     4d0:	00000006 	andeq	r0, r0, r6
     4d4:	04380de1 	ldrteq	r0, [r8], #-3553	; 0xfffff21f
     4d8:	c2000000 	andgt	r0, r0, #0
     4dc:	0e000001 	cdpeq	0, 0, cr0, cr0, cr1, {0}
     4e0:	0000068b 	andeq	r0, r0, fp, lsl #13
     4e4:	08160708 	ldmdaeq	r6, {r3, r8, r9, sl}
     4e8:	00000233 	andeq	r0, r0, r3, lsr r2
     4ec:	0005f00f 	andeq	pc, r5, pc
     4f0:	17180700 	ldrne	r0, [r8, -r0, lsl #14]
     4f4:	0000019f 	muleq	r0, pc, r1	; <UNPREDICTABLE>
     4f8:	04fb0f00 	ldrbteq	r0, [fp], #3840	; 0xf00
     4fc:	19070000 	stmdbne	r7, {}	; <UNPREDICTABLE>
     500:	0001be15 	andeq	fp, r1, r5, lsl lr
     504:	10000400 	andne	r0, r0, r0, lsl #8
     508:	000005d8 	ldrdeq	r0, [r0], -r8
     50c:	38051201 	stmdacc	r5, {r0, r9, ip}
     510:	68000000 	stmdavs	r0, {}	; <UNPREDICTABLE>
     514:	44000082 	strmi	r0, [r0], #-130	; 0xffffff7e
     518:	01000001 	tsteq	r0, r1
     51c:	0002fa9c 	muleq	r2, ip, sl
     520:	063a1100 	ldrteq	r1, [sl], -r0, lsl #2
     524:	12010000 	andne	r0, r1, #0
     528:	0000380e 	andeq	r3, r0, lr, lsl #16
     52c:	a4910300 	ldrge	r0, [r1], #768	; 0x300
     530:	065d117f 			; <UNDEFINED> instruction: 0x065d117f
     534:	12010000 	andne	r0, r1, #0
     538:	0002fa1b 	andeq	pc, r2, fp, lsl sl	; <UNPREDICTABLE>
     53c:	a0910300 	addsge	r0, r1, r0, lsl #6
     540:	0540127f 	strbeq	r1, [r0, #-639]	; 0xfffffd81
     544:	14010000 	strne	r0, [r1], #-0
     548:	00004d0b 	andeq	r4, r0, fp, lsl #26
     54c:	74910200 	ldrvc	r0, [r1], #512	; 0x200
     550:	00066212 	andeq	r6, r6, r2, lsl r2
     554:	15160100 	ldrne	r0, [r6, #-256]	; 0xffffff00
     558:	0000020b 	andeq	r0, r0, fp, lsl #4
     55c:	135c9102 	cmpne	ip, #-2147483648	; 0x80000000
     560:	00667562 	rsbeq	r7, r6, r2, ror #10
     564:	06071d01 	streq	r1, [r7], -r1, lsl #26
     568:	03000003 	movweq	r0, #3
     56c:	127fb891 	rsbsne	fp, pc, #9502720	; 0x910000
     570:	0000069e 	muleq	r0, lr, r6
     574:	33071e01 	movwcc	r1, #32257	; 0x7e01
     578:	03000001 	movweq	r0, #1
     57c:	127fa891 	rsbsne	sl, pc, #9502720	; 0x910000
     580:	000004df 	ldrdeq	r0, [r0], -pc	; <UNPREDICTABLE>
     584:	4d0b2201 	sfmmi	f2, 4, [fp, #-4]
     588:	02000000 	andeq	r0, r0, #0
     58c:	83127091 	tsthi	r2, #145	; 0x91
     590:	01000006 	tsteq	r0, r6
     594:	004d0b24 	subeq	r0, sp, r4, lsr #22
     598:	91020000 	mrsls	r0, (UNDEF: 2)
     59c:	82f4146c 	rscshi	r1, r4, #108, 8	; 0x6c000000
     5a0:	009c0000 	addseq	r0, ip, r0
     5a4:	76130000 	ldrvc	r0, [r3], -r0
     5a8:	0c2a0100 	stfeqs	f0, [sl], #-0
     5ac:	0000004d 	andeq	r0, r0, sp, asr #32
     5b0:	14689102 	strbtne	r9, [r8], #-258	; 0xfffffefe
     5b4:	00008328 	andeq	r8, r0, r8, lsr #6
     5b8:	00000068 	andeq	r0, r0, r8, rrx
     5bc:	0004e412 	andeq	lr, r4, r2, lsl r4
     5c0:	0d2f0100 	stfeqs	f0, [pc, #-0]	; 5c8 <shift+0x5c8>
     5c4:	0000004d 	andeq	r0, r0, sp, asr #32
     5c8:	00649102 	rsbeq	r9, r4, r2, lsl #2
     5cc:	040b0000 	streq	r0, [fp], #-0
     5d0:	00000300 	andeq	r0, r0, r0, lsl #6
     5d4:	0025040b 	eoreq	r0, r5, fp, lsl #8
     5d8:	25090000 	strcs	r0, [r9, #-0]
     5dc:	16000000 	strne	r0, [r0], -r0
     5e0:	0a000003 	beq	5f4 <shift+0x5f4>
     5e4:	0000005e 	andeq	r0, r0, lr, asr r0
     5e8:	bf150020 	svclt	0x00150020
     5ec:	01000004 	tsteq	r0, r4
     5f0:	822c0d0d 	eorhi	r0, ip, #832	; 0x340
     5f4:	003c0000 	eorseq	r0, ip, r0
     5f8:	9c010000 	stcls	0, cr0, [r1], {-0}
     5fc:	00054511 	andeq	r4, r5, r1, lsl r5
     600:	1c0d0100 	stfnes	f0, [sp], {-0}
     604:	0000004d 	andeq	r0, r0, sp, asr #32
     608:	11749102 	cmnne	r4, r2, lsl #2
     60c:	000004c5 	andeq	r0, r0, r5, asr #9
     610:	4a2e0d01 	bmi	b83a1c <__bss_end+0xb7aa90>
     614:	02000001 	andeq	r0, r0, #1
     618:	00007091 	muleq	r0, r1, r0
     61c:	00000b1f 	andeq	r0, r0, pc, lsl fp
     620:	03100004 	tsteq	r0, #4
     624:	01040000 	mrseq	r0, (UNDEF: 4)
     628:	00000e37 	andeq	r0, r0, r7, lsr lr
     62c:	000c4e04 	andeq	r4, ip, r4, lsl #28
     630:	0006b100 	andeq	fp, r6, r0, lsl #2
     634:	0083ac00 	addeq	sl, r3, r0, lsl #24
     638:	00045c00 	andeq	r5, r4, r0, lsl #24
     63c:	00052900 	andeq	r2, r5, r0, lsl #18
     640:	08010200 	stmdaeq	r1, {r9}
     644:	00000516 	andeq	r0, r0, r6, lsl r5
     648:	00002503 	andeq	r2, r0, r3, lsl #10
     64c:	05020200 	streq	r0, [r2, #-512]	; 0xfffffe00
     650:	00000653 	andeq	r0, r0, r3, asr r6
     654:	69050404 	stmdbvs	r5, {r2, sl}
     658:	0200746e 	andeq	r7, r0, #1845493760	; 0x6e000000
     65c:	050d0801 	streq	r0, [sp, #-2049]	; 0xfffff7ff
     660:	02020000 	andeq	r0, r2, #0
     664:	00054a07 	andeq	r4, r5, r7, lsl #20
     668:	067a0500 	ldrbteq	r0, [sl], -r0, lsl #10
     66c:	09070000 	stmdbeq	r7, {}	; <UNPREDICTABLE>
     670:	00005e07 	andeq	r5, r0, r7, lsl #28
     674:	004d0300 	subeq	r0, sp, r0, lsl #6
     678:	04020000 	streq	r0, [r2], #-0
     67c:	00053307 	andeq	r3, r5, r7, lsl #6
     680:	08f60600 	ldmeq	r6!, {r9, sl}^
     684:	02080000 	andeq	r0, r8, #0
     688:	008b0806 	addeq	r0, fp, r6, lsl #16
     68c:	72070000 	andvc	r0, r7, #0
     690:	08020030 	stmdaeq	r2, {r4, r5}
     694:	00004d0e 	andeq	r4, r0, lr, lsl #26
     698:	72070000 	andvc	r0, r7, #0
     69c:	09020031 	stmdbeq	r2, {r0, r4, r5}
     6a0:	00004d0e 	andeq	r4, r0, lr, lsl #26
     6a4:	08000400 	stmdaeq	r0, {sl}
     6a8:	00000d09 	andeq	r0, r0, r9, lsl #26
     6ac:	00380405 	eorseq	r0, r8, r5, lsl #8
     6b0:	0d020000 	stceq	0, cr0, [r2, #-0]
     6b4:	0000a90c 	andeq	sl, r0, ip, lsl #18
     6b8:	4b4f0900 	blmi	13c2ac0 <__bss_end+0x13b9b34>
     6bc:	0f0a0000 	svceq	0x000a0000
     6c0:	01000009 	tsteq	r0, r9
     6c4:	07d70800 	ldrbeq	r0, [r7, r0, lsl #16]
     6c8:	04050000 	streq	r0, [r5], #-0
     6cc:	00000038 	andeq	r0, r0, r8, lsr r0
     6d0:	e00c1e02 	and	r1, ip, r2, lsl #28
     6d4:	0a000000 	beq	6dc <shift+0x6dc>
     6d8:	00000961 	andeq	r0, r0, r1, ror #18
     6dc:	10570a00 	subsne	r0, r7, r0, lsl #20
     6e0:	0a010000 	beq	406e8 <__bss_end+0x3775c>
     6e4:	00001037 	andeq	r1, r0, r7, lsr r0
     6e8:	0aaf0a02 	beq	febc2ef8 <__bss_end+0xfebb9f6c>
     6ec:	0a030000 	beq	c06f4 <__bss_end+0xb7768>
     6f0:	00000bd9 	ldrdeq	r0, [r0], -r9
     6f4:	09210a04 	stmdbeq	r1!, {r2, r9, fp}
     6f8:	00050000 	andeq	r0, r5, r0
     6fc:	000fb108 	andeq	fp, pc, r8, lsl #2
     700:	38040500 	stmdacc	r4, {r8, sl}
     704:	02000000 	andeq	r0, r0, #0
     708:	011d0c3f 	tsteq	sp, pc, lsr ip
     70c:	fc0a0000 	stc2	0, cr0, [sl], {-0}
     710:	00000006 	andeq	r0, r0, r6
     714:	0007ec0a 	andeq	lr, r7, sl, lsl #24
     718:	c30a0100 	movwgt	r0, #41216	; 0xa100
     71c:	02000005 	andeq	r0, r0, #5
     720:	00100e0a 	andseq	r0, r0, sl, lsl #28
     724:	610a0300 	mrsvs	r0, (UNDEF: 58)
     728:	04000010 	streq	r0, [r0], #-16
     72c:	000b930a 	andeq	r9, fp, sl, lsl #6
     730:	8e0a0500 	cfsh32hi	mvfx0, mvfx10, #0
     734:	0600000a 	streq	r0, [r0], -sl
     738:	06690800 	strbteq	r0, [r9], -r0, lsl #16
     73c:	04050000 	streq	r0, [r5], #-0
     740:	00000038 	andeq	r0, r0, r8, lsr r0
     744:	480c6602 	stmdami	ip, {r1, r9, sl, sp, lr}
     748:	0a000001 	beq	754 <shift+0x754>
     74c:	0000057e 	andeq	r0, r0, lr, ror r5
     750:	06480a00 	strbeq	r0, [r8], -r0, lsl #20
     754:	0a010000 	beq	4075c <__bss_end+0x377d0>
     758:	000003f9 	strdeq	r0, [r0], -r9
     75c:	06140a02 	ldreq	r0, [r4], -r2, lsl #20
     760:	00030000 	andeq	r0, r3, r0
     764:	0006060b 	andeq	r0, r6, fp, lsl #12
     768:	14050300 	strne	r0, [r5], #-768	; 0xfffffd00
     76c:	00000059 	andeq	r0, r0, r9, asr r0
     770:	8f300305 	svchi	0x00300305
     774:	b30b0000 	movwlt	r0, #45056	; 0xb000
     778:	03000004 	movweq	r0, #4
     77c:	00591406 	subseq	r1, r9, r6, lsl #8
     780:	03050000 	movweq	r0, #20480	; 0x5000
     784:	00008f34 	andeq	r8, r0, r4, lsr pc
     788:	0004100b 	andeq	r1, r4, fp
     78c:	1a070400 	bne	1c1794 <__bss_end+0x1b8808>
     790:	00000059 	andeq	r0, r0, r9, asr r0
     794:	8f380305 	svchi	0x00380305
     798:	e90b0000 	stmdb	fp, {}	; <UNPREDICTABLE>
     79c:	04000004 	streq	r0, [r0], #-4
     7a0:	00591a09 	subseq	r1, r9, r9, lsl #20
     7a4:	03050000 	movweq	r0, #20480	; 0x5000
     7a8:	00008f3c 	andeq	r8, r0, ip, lsr pc
     7ac:	00062c0b 	andeq	r2, r6, fp, lsl #24
     7b0:	1a0b0400 	bne	2c17b8 <__bss_end+0x2b882c>
     7b4:	00000059 	andeq	r0, r0, r9, asr r0
     7b8:	8f400305 	svchi	0x00400305
     7bc:	cc0b0000 	stcgt	0, cr0, [fp], {-0}
     7c0:	04000004 	streq	r0, [r0], #-4
     7c4:	00591a0d 	subseq	r1, r9, sp, lsl #20
     7c8:	03050000 	movweq	r0, #20480	; 0x5000
     7cc:	00008f44 	andeq	r8, r0, r4, asr #30
     7d0:	00055d0b 	andeq	r5, r5, fp, lsl #26
     7d4:	1a0f0400 	bne	3c17dc <__bss_end+0x3b8850>
     7d8:	00000059 	andeq	r0, r0, r9, asr r0
     7dc:	8f480305 	svchi	0x00480305
     7e0:	27080000 	strcs	r0, [r8, -r0]
     7e4:	05000010 	streq	r0, [r0, #-16]
     7e8:	00003804 	andeq	r3, r0, r4, lsl #16
     7ec:	0c1b0400 	cfldrseq	mvf0, [fp], {-0}
     7f0:	000001eb 	andeq	r0, r0, fp, ror #3
     7f4:	0005fc0a 	andeq	pc, r5, sl, lsl #24
     7f8:	890a0000 	stmdbhi	sl, {}	; <UNPREDICTABLE>
     7fc:	01000005 	tsteq	r0, r5
     800:	0005be0a 	andeq	fp, r5, sl, lsl #28
     804:	0c000200 	sfmeq	f0, 4, [r0], {-0}
     808:	00000c48 	andeq	r0, r0, r8, asr #24
     80c:	a6020102 	strge	r0, [r2], -r2, lsl #2
     810:	0d000004 	stceq	0, cr0, [r0, #-16]
     814:	00002c04 	andeq	r2, r0, r4, lsl #24
     818:	eb040d00 	bl	103c20 <__bss_end+0xfac94>
     81c:	0b000001 	bleq	828 <shift+0x828>
     820:	0000059d 	muleq	r0, sp, r5
     824:	59140405 	ldmdbpl	r4, {r0, r2, sl}
     828:	05000000 	streq	r0, [r0, #-0]
     82c:	008f4c03 	addeq	r4, pc, r3, lsl #24
     830:	05dd0b00 	ldrbeq	r0, [sp, #2816]	; 0xb00
     834:	07050000 	streq	r0, [r5, -r0]
     838:	00005914 	andeq	r5, r0, r4, lsl r9
     83c:	50030500 	andpl	r0, r3, r0, lsl #10
     840:	0b00008f 	bleq	a84 <shift+0xa84>
     844:	0000051b 	andeq	r0, r0, fp, lsl r5
     848:	59140a05 	ldmdbpl	r4, {r0, r2, r9, fp}
     84c:	05000000 	streq	r0, [r0, #-0]
     850:	008f5403 	addeq	r5, pc, r3, lsl #8
     854:	0b0a0800 	bleq	28285c <__bss_end+0x2798d0>
     858:	04050000 	streq	r0, [r5], #-0
     85c:	00000038 	andeq	r0, r0, r8, lsr r0
     860:	700c0d05 	andvc	r0, ip, r5, lsl #26
     864:	09000002 	stmdbeq	r0, {r1}
     868:	0077654e 	rsbseq	r6, r7, lr, asr #10
     86c:	0b010a00 	bleq	43074 <__bss_end+0x3a0e8>
     870:	0a010000 	beq	40878 <__bss_end+0x378ec>
     874:	00000d1a 	andeq	r0, r0, sl, lsl sp
     878:	0ad30a02 	beq	ff4c3088 <__bss_end+0xff4ba0fc>
     87c:	0a030000 	beq	c0884 <__bss_end+0xb78f8>
     880:	00000aa1 	andeq	r0, r0, r1, lsr #21
     884:	0bd20a04 	bleq	ff48309c <__bss_end+0xff47a110>
     888:	00050000 	andeq	r0, r5, r0
     88c:	00091406 	andeq	r1, r9, r6, lsl #8
     890:	1b051000 	blne	144898 <__bss_end+0x13b90c>
     894:	0002af08 	andeq	sl, r2, r8, lsl #30
     898:	726c0700 	rsbvc	r0, ip, #0, 14
     89c:	131d0500 	tstne	sp, #0, 10
     8a0:	000002af 	andeq	r0, r0, pc, lsr #5
     8a4:	70730700 	rsbsvc	r0, r3, r0, lsl #14
     8a8:	131e0500 	tstne	lr, #0, 10
     8ac:	000002af 	andeq	r0, r0, pc, lsr #5
     8b0:	63700704 	cmnvs	r0, #4, 14	; 0x100000
     8b4:	131f0500 	tstne	pc, #0, 10
     8b8:	000002af 	andeq	r0, r0, pc, lsr #5
     8bc:	09330e08 	ldmdbeq	r3!, {r3, r9, sl, fp}
     8c0:	20050000 	andcs	r0, r5, r0
     8c4:	0002af13 	andeq	sl, r2, r3, lsl pc
     8c8:	02000c00 	andeq	r0, r0, #0, 24
     8cc:	052e0704 	streq	r0, [lr, #-1796]!	; 0xfffff8fc
     8d0:	d0060000 	andle	r0, r6, r0
     8d4:	70000009 	andvc	r0, r0, r9
     8d8:	46082805 	strmi	r2, [r8], -r5, lsl #16
     8dc:	0e000003 	cdpeq	0, 0, cr0, cr0, cr3, {0}
     8e0:	00000d87 	andeq	r0, r0, r7, lsl #27
     8e4:	70122a05 	andsvc	r2, r2, r5, lsl #20
     8e8:	00000002 	andeq	r0, r0, r2
     8ec:	64697007 	strbtvs	r7, [r9], #-7
     8f0:	122b0500 	eorne	r0, fp, #0, 10
     8f4:	0000005e 	andeq	r0, r0, lr, asr r0
     8f8:	08310e10 	ldmdaeq	r1!, {r4, r9, sl, fp}
     8fc:	2c050000 	stccs	0, cr0, [r5], {-0}
     900:	00023911 	andeq	r3, r2, r1, lsl r9
     904:	160e1400 	strne	r1, [lr], -r0, lsl #8
     908:	0500000b 	streq	r0, [r0, #-11]
     90c:	005e122d 	subseq	r1, lr, sp, lsr #4
     910:	0e180000 	cdpeq	0, 1, cr0, cr8, cr0, {0}
     914:	00000b24 	andeq	r0, r0, r4, lsr #22
     918:	5e122e05 	cdppl	14, 1, cr2, cr2, cr5, {0}
     91c:	1c000000 	stcne	0, cr0, [r0], {-0}
     920:	0009020e 	andeq	r0, r9, lr, lsl #4
     924:	0c2f0500 	cfstr32eq	mvfx0, [pc], #-0	; 92c <shift+0x92c>
     928:	00000346 	andeq	r0, r0, r6, asr #6
     92c:	0b400e20 	bleq	10041b4 <__bss_end+0xffb228>
     930:	30050000 	andcc	r0, r5, r0
     934:	00003809 	andeq	r3, r0, r9, lsl #16
     938:	9a0e6000 	bls	398940 <__bss_end+0x38f9b4>
     93c:	0500000d 	streq	r0, [r0, #-13]
     940:	004d0e31 	subeq	r0, sp, r1, lsr lr
     944:	0e640000 	cdpeq	0, 6, cr0, cr4, cr0, {0}
     948:	00000972 	andeq	r0, r0, r2, ror r9
     94c:	4d0e3305 	stcmi	3, cr3, [lr, #-20]	; 0xffffffec
     950:	68000000 	stmdavs	r0, {}	; <UNPREDICTABLE>
     954:	0009690e 	andeq	r6, r9, lr, lsl #18
     958:	0e340500 	cfabs32eq	mvfx0, mvfx4
     95c:	0000004d 	andeq	r0, r0, sp, asr #32
     960:	fd0f006c 	stc2	0, cr0, [pc, #-432]	; 7b8 <shift+0x7b8>
     964:	56000001 	strpl	r0, [r0], -r1
     968:	10000003 	andne	r0, r0, r3
     96c:	0000005e 	andeq	r0, r0, lr, asr r0
     970:	c90b000f 	stmdbgt	fp, {r0, r1, r2, r3}
     974:	06000005 	streq	r0, [r0], -r5
     978:	0059140a 	subseq	r1, r9, sl, lsl #8
     97c:	03050000 	movweq	r0, #20480	; 0x5000
     980:	00008f58 	andeq	r8, r0, r8, asr pc
     984:	000adb08 	andeq	sp, sl, r8, lsl #22
     988:	38040500 	stmdacc	r4, {r8, sl}
     98c:	06000000 	streq	r0, [r0], -r0
     990:	03870c0d 	orreq	r0, r7, #3328	; 0xd00
     994:	f10a0000 	cpsie	,#0
     998:	00000007 	andeq	r0, r0, r7
     99c:	0006a60a 	andeq	sl, r6, sl, lsl #12
     9a0:	03000100 	movweq	r0, #256	; 0x100
     9a4:	00000368 	andeq	r0, r0, r8, ror #6
     9a8:	000b6f08 	andeq	r6, fp, r8, lsl #30
     9ac:	38040500 	stmdacc	r4, {r8, sl}
     9b0:	06000000 	streq	r0, [r0], -r0
     9b4:	03ab0c14 			; <UNDEFINED> instruction: 0x03ab0c14
     9b8:	3b0a0000 	blcc	2809c0 <__bss_end+0x277a34>
     9bc:	00000007 	andeq	r0, r0, r7
     9c0:	000cdb0a 	andeq	sp, ip, sl, lsl #22
     9c4:	03000100 	movweq	r0, #256	; 0x100
     9c8:	0000038c 	andeq	r0, r0, ip, lsl #7
     9cc:	000f0b06 	andeq	r0, pc, r6, lsl #22
     9d0:	1b060c00 	blne	1839d8 <__bss_end+0x17aa4c>
     9d4:	0003e508 	andeq	lr, r3, r8, lsl #10
     9d8:	07360e00 	ldreq	r0, [r6, -r0, lsl #28]!
     9dc:	1d060000 	stcne	0, cr0, [r6, #-0]
     9e0:	0003e519 	andeq	lr, r3, r9, lsl r5
     9e4:	ae0e0000 	cdpge	0, 0, cr0, cr14, cr0, {0}
     9e8:	06000007 	streq	r0, [r0], -r7
     9ec:	03e5191e 	mvneq	r1, #491520	; 0x78000
     9f0:	0e040000 	cdpeq	0, 0, cr0, cr4, cr0, {0}
     9f4:	00000e0e 	andeq	r0, r0, lr, lsl #28
     9f8:	eb131f06 	bl	4c8618 <__bss_end+0x4bf68c>
     9fc:	08000003 	stmdaeq	r0, {r0, r1}
     a00:	b0040d00 	andlt	r0, r4, r0, lsl #26
     a04:	0d000003 	stceq	0, cr0, [r0, #-12]
     a08:	0002b604 	andeq	fp, r2, r4, lsl #12
     a0c:	08561100 	ldmdaeq	r6, {r8, ip}^
     a10:	06140000 	ldreq	r0, [r4], -r0
     a14:	06730722 	ldrbteq	r0, [r3], -r2, lsr #14
     a18:	c90e0000 	stmdbgt	lr, {}	; <UNPREDICTABLE>
     a1c:	0600000a 	streq	r0, [r0], -sl
     a20:	004d1226 	subeq	r1, sp, r6, lsr #4
     a24:	0e000000 	cdpeq	0, 0, cr0, cr0, cr0, {0}
     a28:	00000767 	andeq	r0, r0, r7, ror #14
     a2c:	e51d2906 	ldr	r2, [sp, #-2310]	; 0xfffff6fa
     a30:	04000003 	streq	r0, [r0], #-3
     a34:	000d5e0e 	andeq	r5, sp, lr, lsl #28
     a38:	1d2c0600 	stcne	6, cr0, [ip, #-0]
     a3c:	000003e5 	andeq	r0, r0, r5, ror #7
     a40:	0fa71208 	svceq	0x00a71208
     a44:	2f060000 	svccs	0x00060000
     a48:	000ee80e 	andeq	lr, lr, lr, lsl #16
     a4c:	00043900 	andeq	r3, r4, r0, lsl #18
     a50:	00044400 	andeq	r4, r4, r0, lsl #8
     a54:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
     a58:	e5140000 	ldr	r0, [r4, #-0]
     a5c:	00000003 	andeq	r0, r0, r3
     a60:	000e1f15 	andeq	r1, lr, r5, lsl pc
     a64:	0e310600 	cfmsuba32eq	mvax0, mvax0, mvfx1, mvfx0
     a68:	000009a7 	andeq	r0, r0, r7, lsr #19
     a6c:	000001f0 	strdeq	r0, [r0], -r0	; <UNPREDICTABLE>
     a70:	0000045c 	andeq	r0, r0, ip, asr r4
     a74:	00000467 	andeq	r0, r0, r7, ror #8
     a78:	00067813 	andeq	r7, r6, r3, lsl r8
     a7c:	03eb1400 	mvneq	r1, #0, 8
     a80:	16000000 	strne	r0, [r0], -r0
     a84:	00000f1e 	andeq	r0, r0, lr, lsl pc
     a88:	e91d3506 	ldmdb	sp, {r1, r2, r8, sl, ip, sp}
     a8c:	e500000d 	str	r0, [r0, #-13]
     a90:	02000003 	andeq	r0, r0, #3
     a94:	00000480 	andeq	r0, r0, r0, lsl #9
     a98:	00000486 	andeq	r0, r0, r6, lsl #9
     a9c:	00067813 	andeq	r7, r6, r3, lsl r8
     aa0:	81160000 	tsthi	r6, r0
     aa4:	0600000a 	streq	r0, [r0], -sl
     aa8:	0caa1d37 	stceq	13, cr1, [sl], #220	; 0xdc
     aac:	03e50000 	mvneq	r0, #0
     ab0:	9f020000 	svcls	0x00020000
     ab4:	a5000004 	strge	r0, [r0, #-4]
     ab8:	13000004 	movwne	r0, #4
     abc:	00000678 	andeq	r0, r0, r8, ror r6
     ac0:	0b501700 	bleq	14066c8 <__bss_end+0x13fd73c>
     ac4:	39060000 	stmdbcc	r6, {}	; <UNPREDICTABLE>
     ac8:	00069131 	andeq	r9, r6, r1, lsr r1
     acc:	16020c00 	strne	r0, [r2], -r0, lsl #24
     ad0:	00000856 	andeq	r0, r0, r6, asr r8
     ad4:	3d093c06 	stccc	12, cr3, [r9, #-24]	; 0xffffffe8
     ad8:	78000010 	stmdavc	r0, {r4}
     adc:	01000006 	tsteq	r0, r6
     ae0:	000004cc 	andeq	r0, r0, ip, asr #9
     ae4:	000004d2 	ldrdeq	r0, [r0], -r2
     ae8:	00067813 	andeq	r7, r6, r3, lsl r8
     aec:	06160000 	ldreq	r0, [r6], -r0
     af0:	06000008 	streq	r0, [r0], -r8
     af4:	0f7c123f 	svceq	0x007c123f
     af8:	004d0000 	subeq	r0, sp, r0
     afc:	eb010000 	bl	40b04 <__bss_end+0x37b78>
     b00:	00000004 	andeq	r0, r0, r4
     b04:	13000005 	movwne	r0, #5
     b08:	00000678 	andeq	r0, r0, r8, ror r6
     b0c:	00069a14 	andeq	r9, r6, r4, lsl sl
     b10:	005e1400 	subseq	r1, lr, r0, lsl #8
     b14:	f0140000 			; <UNDEFINED> instruction: 0xf0140000
     b18:	00000001 	andeq	r0, r0, r1
     b1c:	000e2e18 	andeq	r2, lr, r8, lsl lr
     b20:	0e420600 	cdpeq	6, 4, cr0, cr2, cr0, {0}
     b24:	00000bfa 	strdeq	r0, [r0], -sl
     b28:	00051501 	andeq	r1, r5, r1, lsl #10
     b2c:	00051b00 	andeq	r1, r5, r0, lsl #22
     b30:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
     b34:	16000000 	strne	r0, [r0], -r0
     b38:	00000a1b 	andeq	r0, r0, fp, lsl sl
     b3c:	7a174506 	bvc	5d1f5c <__bss_end+0x5c8fd0>
     b40:	eb000007 	bl	b64 <shift+0xb64>
     b44:	01000003 	tsteq	r0, r3
     b48:	00000534 	andeq	r0, r0, r4, lsr r5
     b4c:	0000053a 	andeq	r0, r0, sl, lsr r5
     b50:	0006a013 	andeq	sl, r6, r3, lsl r0
     b54:	b3160000 	tstlt	r6, #0
     b58:	06000007 	streq	r0, [r0], -r7
     b5c:	0da61748 	stceq	7, cr1, [r6, #288]!	; 0x120
     b60:	03eb0000 	mvneq	r0, #0
     b64:	53010000 	movwpl	r0, #4096	; 0x1000
     b68:	5e000005 	cdppl	0, 0, cr0, cr0, cr5, {0}
     b6c:	13000005 	movwne	r0, #5
     b70:	000006a0 	andeq	r0, r0, r0, lsr #13
     b74:	00004d14 	andeq	r4, r0, r4, lsl sp
     b78:	f3180000 	vhadd.u16	d0, d8, d0
     b7c:	0600000f 	streq	r0, [r0], -pc
     b80:	07010e4b 	streq	r0, [r1, -fp, asr #28]
     b84:	73010000 	movwvc	r0, #4096	; 0x1000
     b88:	79000005 	stmdbvc	r0, {r0, r2}
     b8c:	13000005 	movwne	r0, #5
     b90:	00000678 	andeq	r0, r0, r8, ror r6
     b94:	0e1f1600 	cfmsub32eq	mvax0, mvfx1, mvfx15, mvfx0
     b98:	4d060000 	stcmi	0, cr0, [r6, #-0]
     b9c:	0009390e 	andeq	r3, r9, lr, lsl #18
     ba0:	0001f000 	andeq	pc, r1, r0
     ba4:	05920100 	ldreq	r0, [r2, #256]	; 0x100
     ba8:	059d0000 	ldreq	r0, [sp]
     bac:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
     bb0:	14000006 	strne	r0, [r0], #-6
     bb4:	0000004d 	andeq	r0, r0, sp, asr #32
     bb8:	0a401600 	beq	10063c0 <__bss_end+0xffd434>
     bbc:	50060000 	andpl	r0, r6, r0
     bc0:	000c1b12 	andeq	r1, ip, r2, lsl fp
     bc4:	00004d00 	andeq	r4, r0, r0, lsl #26
     bc8:	05b60100 	ldreq	r0, [r6, #256]!	; 0x100
     bcc:	05c10000 	strbeq	r0, [r1]
     bd0:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
     bd4:	14000006 	strne	r0, [r0], #-6
     bd8:	000001fd 	strdeq	r0, [r0], -sp
     bdc:	07481600 	strbeq	r1, [r8, -r0, lsl #12]
     be0:	53060000 	movwpl	r0, #24576	; 0x6000
     be4:	00097b0e 	andeq	r7, r9, lr, lsl #22
     be8:	0001f000 	andeq	pc, r1, r0
     bec:	05da0100 	ldrbeq	r0, [sl, #256]	; 0x100
     bf0:	05e50000 	strbeq	r0, [r5, #0]!
     bf4:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
     bf8:	14000006 	strne	r0, [r0], #-6
     bfc:	0000004d 	andeq	r0, r0, sp, asr #32
     c00:	0a681800 	beq	1a06c08 <__bss_end+0x19fdc7c>
     c04:	56060000 	strpl	r0, [r6], -r0
     c08:	000f2a0e 	andeq	r2, pc, lr, lsl #20
     c0c:	05fa0100 	ldrbeq	r0, [sl, #256]!	; 0x100
     c10:	06190000 	ldreq	r0, [r9], -r0
     c14:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
     c18:	14000006 	strne	r0, [r0], #-6
     c1c:	000000a9 	andeq	r0, r0, r9, lsr #1
     c20:	00004d14 	andeq	r4, r0, r4, lsl sp
     c24:	004d1400 	subeq	r1, sp, r0, lsl #8
     c28:	4d140000 	ldcmi	0, cr0, [r4, #-0]
     c2c:	14000000 	strne	r0, [r0], #-0
     c30:	000006a6 	andeq	r0, r0, r6, lsr #13
     c34:	0dd31800 	ldcleq	8, cr1, [r3]
     c38:	58060000 	stmdapl	r6, {}	; <UNPREDICTABLE>
     c3c:	0008aa0e 	andeq	sl, r8, lr, lsl #20
     c40:	062e0100 	strteq	r0, [lr], -r0, lsl #2
     c44:	064d0000 	strbeq	r0, [sp], -r0
     c48:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
     c4c:	14000006 	strne	r0, [r0], #-6
     c50:	000000e0 	andeq	r0, r0, r0, ror #1
     c54:	00004d14 	andeq	r4, r0, r4, lsl sp
     c58:	004d1400 	subeq	r1, sp, r0, lsl #8
     c5c:	4d140000 	ldcmi	0, cr0, [r4, #-0]
     c60:	14000000 	strne	r0, [r0], #-0
     c64:	000006a6 	andeq	r0, r0, r6, lsr #13
     c68:	08431900 	stmdaeq	r3, {r8, fp, ip}^
     c6c:	5b060000 	blpl	180c74 <__bss_end+0x177ce8>
     c70:	0008670e 	andeq	r6, r8, lr, lsl #14
     c74:	0001f000 	andeq	pc, r1, r0
     c78:	06620100 	strbteq	r0, [r2], -r0, lsl #2
     c7c:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
     c80:	14000006 	strne	r0, [r0], #-6
     c84:	00000368 	andeq	r0, r0, r8, ror #6
     c88:	0006ac14 	andeq	sl, r6, r4, lsl ip
     c8c:	03000000 	movweq	r0, #0
     c90:	000003f1 	strdeq	r0, [r0], -r1
     c94:	03f1040d 	mvnseq	r0, #218103808	; 0xd000000
     c98:	e51a0000 	ldr	r0, [sl, #-0]
     c9c:	8b000003 	blhi	cb0 <shift+0xcb0>
     ca0:	91000006 	tstls	r0, r6
     ca4:	13000006 	movwne	r0, #6
     ca8:	00000678 	andeq	r0, r0, r8, ror r6
     cac:	03f11b00 	mvnseq	r1, #0, 22
     cb0:	067e0000 	ldrbteq	r0, [lr], -r0
     cb4:	040d0000 	streq	r0, [sp], #-0
     cb8:	0000003f 	andeq	r0, r0, pc, lsr r0
     cbc:	0673040d 	ldrbteq	r0, [r3], -sp, lsl #8
     cc0:	041c0000 	ldreq	r0, [ip], #-0
     cc4:	00000065 	andeq	r0, r0, r5, rrx
     cc8:	2c0f041d 	cfstrscs	mvf0, [pc], {29}
     ccc:	be000000 	cdplt	0, 0, cr0, cr0, cr0, {0}
     cd0:	10000006 	andne	r0, r0, r6
     cd4:	0000005e 	andeq	r0, r0, lr, asr r0
     cd8:	ae030009 	cdpge	0, 0, cr0, cr3, cr9, {0}
     cdc:	1e000006 	cdpne	0, 0, cr0, cr0, cr6, {0}
     ce0:	00000a2f 	andeq	r0, r0, pc, lsr #20
     ce4:	be0ca301 	cdplt	3, 0, cr10, cr12, cr1, {0}
     ce8:	05000006 	streq	r0, [r0, #-6]
     cec:	008f5c03 	addeq	r5, pc, r3, lsl #24
     cf0:	06861f00 	streq	r1, [r6], r0, lsl #30
     cf4:	a5010000 	strge	r0, [r1, #-0]
     cf8:	000b630a 	andeq	r6, fp, sl, lsl #6
     cfc:	00004d00 	andeq	r4, r0, r0, lsl #26
     d00:	00875800 	addeq	r5, r7, r0, lsl #16
     d04:	0000b000 	andeq	fp, r0, r0
     d08:	339c0100 	orrscc	r0, ip, #0, 2
     d0c:	20000007 	andcs	r0, r0, r7
     d10:	00000fee 	andeq	r0, r0, lr, ror #31
     d14:	f71ba501 			; <UNDEFINED> instruction: 0xf71ba501
     d18:	03000001 	movweq	r0, #1
     d1c:	207fac91 			; <UNDEFINED> instruction: 0x207fac91
     d20:	00000bc9 	andeq	r0, r0, r9, asr #23
     d24:	4d2aa501 	cfstr32mi	mvfx10, [sl, #-4]!
     d28:	03000000 	movweq	r0, #0
     d2c:	1e7fa891 	mrcne	8, 3, sl, cr15, cr1, {4}
     d30:	00000afb 	strdeq	r0, [r0], -fp
     d34:	330aa701 	movwcc	sl, #42753	; 0xa701
     d38:	03000007 	movweq	r0, #7
     d3c:	1e7fb491 	mrcne	4, 3, fp, cr15, cr1, {4}
     d40:	00000762 	andeq	r0, r0, r2, ror #14
     d44:	3809ab01 	stmdacc	r9, {r0, r8, r9, fp, sp, pc}
     d48:	02000000 	andeq	r0, r0, #0
     d4c:	0f007491 	svceq	0x00007491
     d50:	00000025 	andeq	r0, r0, r5, lsr #32
     d54:	00000743 	andeq	r0, r0, r3, asr #14
     d58:	00005e10 	andeq	r5, r0, r0, lsl lr
     d5c:	21003f00 	tstcs	r0, r0, lsl #30
     d60:	00000bae 	andeq	r0, r0, lr, lsr #23
     d64:	e90a9701 	stmdb	sl, {r0, r8, r9, sl, ip, pc}
     d68:	4d00000c 	stcmi	0, cr0, [r0, #-48]	; 0xffffffd0
     d6c:	1c000000 	stcne	0, cr0, [r0], {-0}
     d70:	3c000087 	stccc	0, cr0, [r0], {135}	; 0x87
     d74:	01000000 	mrseq	r0, (UNDEF: 0)
     d78:	0007809c 	muleq	r7, ip, r0
     d7c:	65722200 	ldrbvs	r2, [r2, #-512]!	; 0xfffffe00
     d80:	99010071 	stmdbls	r1, {r0, r4, r5, r6}
     d84:	0003ab20 	andeq	sl, r3, r0, lsr #22
     d88:	74910200 	ldrvc	r0, [r1], #512	; 0x200
     d8c:	000b4a1e 	andeq	r4, fp, lr, lsl sl
     d90:	0e9a0100 	fmleqe	f0, f2, f0
     d94:	0000004d 	andeq	r0, r0, sp, asr #32
     d98:	00709102 	rsbseq	r9, r0, r2, lsl #2
     d9c:	000be823 	andeq	lr, fp, r3, lsr #16
     da0:	068e0100 	streq	r0, [lr], r0, lsl #2
     da4:	00000815 	andeq	r0, r0, r5, lsl r8
     da8:	000086e0 	andeq	r8, r0, r0, ror #13
     dac:	0000003c 	andeq	r0, r0, ip, lsr r0
     db0:	07b99c01 	ldreq	r9, [r9, r1, lsl #24]!
     db4:	e9200000 	stmdb	r0!, {}	; <UNPREDICTABLE>
     db8:	01000009 	tsteq	r0, r9
     dbc:	004d218e 	subeq	r2, sp, lr, lsl #3
     dc0:	91020000 	mrsls	r0, (UNDEF: 2)
     dc4:	6572226c 	ldrbvs	r2, [r2, #-620]!	; 0xfffffd94
     dc8:	90010071 	andls	r0, r1, r1, ror r0
     dcc:	0003ab20 	andeq	sl, r3, r0, lsr #22
     dd0:	74910200 	ldrvc	r0, [r1], #512	; 0x200
     dd4:	0b842100 	bleq	fe1091dc <__bss_end+0xfe100250>
     dd8:	82010000 	andhi	r0, r1, #0
     ddc:	000a540a 	andeq	r5, sl, sl, lsl #8
     de0:	00004d00 	andeq	r4, r0, r0, lsl #26
     de4:	0086a400 	addeq	sl, r6, r0, lsl #8
     de8:	00003c00 	andeq	r3, r0, r0, lsl #24
     dec:	f69c0100 			; <UNDEFINED> instruction: 0xf69c0100
     df0:	22000007 	andcs	r0, r0, #7
     df4:	00716572 	rsbseq	r6, r1, r2, ror r5
     df8:	87208401 	strhi	r8, [r0, -r1, lsl #8]!
     dfc:	02000003 	andeq	r0, r0, #3
     e00:	5b1e7491 	blpl	79e04c <__bss_end+0x7950c0>
     e04:	01000007 	tsteq	r0, r7
     e08:	004d0e85 	subeq	r0, sp, r5, lsl #29
     e0c:	91020000 	mrsls	r0, (UNDEF: 2)
     e10:	d1210070 			; <UNDEFINED> instruction: 0xd1210070
     e14:	0100000f 	tsteq	r0, pc
     e18:	09fd0a76 	ldmibeq	sp!, {r1, r2, r4, r5, r6, r9, fp}^
     e1c:	004d0000 	subeq	r0, sp, r0
     e20:	86680000 	strbthi	r0, [r8], -r0
     e24:	003c0000 	eorseq	r0, ip, r0
     e28:	9c010000 	stcls	0, cr0, [r1], {-0}
     e2c:	00000833 	andeq	r0, r0, r3, lsr r8
     e30:	71657222 	cmnvc	r5, r2, lsr #4
     e34:	20780100 	rsbscs	r0, r8, r0, lsl #2
     e38:	00000387 	andeq	r0, r0, r7, lsl #7
     e3c:	1e749102 	expnes	f1, f2
     e40:	0000075b 	andeq	r0, r0, fp, asr r7
     e44:	4d0e7901 	vstrmi.16	s14, [lr, #-2]	; <UNPREDICTABLE>
     e48:	02000000 	andeq	r0, r0, #0
     e4c:	21007091 	swpcs	r7, r1, [r0]
     e50:	00000a7b 	andeq	r0, r0, fp, ror sl
     e54:	d0066a01 	andle	r6, r6, r1, lsl #20
     e58:	f000000c 			; <UNDEFINED> instruction: 0xf000000c
     e5c:	14000001 	strne	r0, [r0], #-1
     e60:	54000086 	strpl	r0, [r0], #-134	; 0xffffff7a
     e64:	01000000 	mrseq	r0, (UNDEF: 0)
     e68:	00087f9c 	muleq	r8, ip, pc	; <UNPREDICTABLE>
     e6c:	0b4a2000 	bleq	1288e74 <__bss_end+0x127fee8>
     e70:	6a010000 	bvs	40e78 <__bss_end+0x37eec>
     e74:	00004d15 	andeq	r4, r0, r5, lsl sp
     e78:	6c910200 	lfmvs	f0, 4, [r1], {0}
     e7c:	00096920 	andeq	r6, r9, r0, lsr #18
     e80:	256a0100 	strbcs	r0, [sl, #-256]!	; 0xffffff00
     e84:	0000004d 	andeq	r0, r0, sp, asr #32
     e88:	1e689102 	lgnnee	f1, f2
     e8c:	00000fc9 	andeq	r0, r0, r9, asr #31
     e90:	4d0e6c01 	stcmi	12, cr6, [lr, #-4]
     e94:	02000000 	andeq	r0, r0, #0
     e98:	21007491 			; <UNDEFINED> instruction: 0x21007491
     e9c:	0000082c 	andeq	r0, r0, ip, lsr #16
     ea0:	28125d01 	ldmdacs	r2, {r0, r8, sl, fp, ip, lr}
     ea4:	8b00000d 	blhi	ee0 <shift+0xee0>
     ea8:	c4000000 	strgt	r0, [r0], #-0
     eac:	50000085 	andpl	r0, r0, r5, lsl #1
     eb0:	01000000 	mrseq	r0, (UNDEF: 0)
     eb4:	0008da9c 	muleq	r8, ip, sl
     eb8:	05452000 	strbeq	r2, [r5, #-0]
     ebc:	5d010000 	stcpl	0, cr0, [r1, #-0]
     ec0:	00004d20 	andeq	r4, r0, r0, lsr #26
     ec4:	6c910200 	lfmvs	f0, 4, [r1], {0}
     ec8:	000b8d20 	andeq	r8, fp, r0, lsr #26
     ecc:	2f5d0100 	svccs	0x005d0100
     ed0:	0000004d 	andeq	r0, r0, sp, asr #32
     ed4:	20689102 	rsbcs	r9, r8, r2, lsl #2
     ed8:	00000969 	andeq	r0, r0, r9, ror #18
     edc:	4d3f5d01 	ldcmi	13, cr5, [pc, #-4]!	; ee0 <shift+0xee0>
     ee0:	02000000 	andeq	r0, r0, #0
     ee4:	c91e6491 	ldmdbgt	lr, {r0, r4, r7, sl, sp, lr}
     ee8:	0100000f 	tsteq	r0, pc
     eec:	008b165f 	addeq	r1, fp, pc, asr r6
     ef0:	91020000 	mrsls	r0, (UNDEF: 2)
     ef4:	71210074 			; <UNDEFINED> instruction: 0x71210074
     ef8:	0100000d 	tsteq	r0, sp
     efc:	08370a51 	ldmdaeq	r7!, {r0, r4, r6, r9, fp}
     f00:	004d0000 	subeq	r0, sp, r0
     f04:	85800000 	strhi	r0, [r0]
     f08:	00440000 	subeq	r0, r4, r0
     f0c:	9c010000 	stcls	0, cr0, [r1], {-0}
     f10:	00000926 	andeq	r0, r0, r6, lsr #18
     f14:	00054520 	andeq	r4, r5, r0, lsr #10
     f18:	1a510100 	bne	1441320 <__bss_end+0x1438394>
     f1c:	0000004d 	andeq	r0, r0, sp, asr #32
     f20:	206c9102 	rsbcs	r9, ip, r2, lsl #2
     f24:	00000b8d 	andeq	r0, r0, sp, lsl #23
     f28:	4d295101 	stfmis	f5, [r9, #-4]!
     f2c:	02000000 	andeq	r0, r0, #0
     f30:	571e6891 			; <UNDEFINED> instruction: 0x571e6891
     f34:	0100000d 	tsteq	r0, sp
     f38:	004d0e53 	subeq	r0, sp, r3, asr lr
     f3c:	91020000 	mrsls	r0, (UNDEF: 2)
     f40:	51210074 			; <UNDEFINED> instruction: 0x51210074
     f44:	0100000d 	tsteq	r0, sp
     f48:	0d330a44 	vldmdbeq	r3!, {s0-s67}
     f4c:	004d0000 	subeq	r0, sp, r0
     f50:	85300000 	ldrhi	r0, [r0, #-0]!
     f54:	00500000 	subseq	r0, r0, r0
     f58:	9c010000 	stcls	0, cr0, [r1], {-0}
     f5c:	00000981 	andeq	r0, r0, r1, lsl #19
     f60:	00054520 	andeq	r4, r5, r0, lsr #10
     f64:	19440100 	stmdbne	r4, {r8}^
     f68:	0000004d 	andeq	r0, r0, sp, asr #32
     f6c:	206c9102 	rsbcs	r9, ip, r2, lsl #2
     f70:	00000ab5 			; <UNDEFINED> instruction: 0x00000ab5
     f74:	1d304401 	cfldrsne	mvf4, [r0, #-4]!
     f78:	02000001 	andeq	r0, r0, #1
     f7c:	9a206891 	bls	81b1c8 <__bss_end+0x81223c>
     f80:	0100000b 	tsteq	r0, fp
     f84:	06ac4144 	strteq	r4, [ip], r4, asr #2
     f88:	91020000 	mrsls	r0, (UNDEF: 2)
     f8c:	0fc91e64 	svceq	0x00c91e64
     f90:	46010000 	strmi	r0, [r1], -r0
     f94:	00004d0e 	andeq	r4, r0, lr, lsl #26
     f98:	74910200 	ldrvc	r0, [r1], #512	; 0x200
     f9c:	07302300 	ldreq	r2, [r0, -r0, lsl #6]!
     fa0:	3e010000 	cdpcc	0, 0, cr0, cr1, cr0, {0}
     fa4:	000abf06 	andeq	fp, sl, r6, lsl #30
     fa8:	00850400 	addeq	r0, r5, r0, lsl #8
     fac:	00002c00 	andeq	r2, r0, r0, lsl #24
     fb0:	ab9c0100 	blge	fe7013b8 <__bss_end+0xfe6f842c>
     fb4:	20000009 	andcs	r0, r0, r9
     fb8:	00000545 	andeq	r0, r0, r5, asr #10
     fbc:	4d153e01 	ldcmi	14, cr3, [r5, #-4]
     fc0:	02000000 	andeq	r0, r0, #0
     fc4:	21007491 			; <UNDEFINED> instruction: 0x21007491
     fc8:	00000b3a 	andeq	r0, r0, sl, lsr fp
     fcc:	a00a3101 	andge	r3, sl, r1, lsl #2
     fd0:	4d00000b 	stcmi	0, cr0, [r0, #-44]	; 0xffffffd4
     fd4:	b4000000 	strlt	r0, [r0], #-0
     fd8:	50000084 	andpl	r0, r0, r4, lsl #1
     fdc:	01000000 	mrseq	r0, (UNDEF: 0)
     fe0:	000a069c 	muleq	sl, ip, r6
     fe4:	05452000 	strbeq	r2, [r5, #-0]
     fe8:	31010000 	mrscc	r0, (UNDEF: 1)
     fec:	00004d19 	andeq	r4, r0, r9, lsl sp
     ff0:	6c910200 	lfmvs	f0, 4, [r1], {0}
     ff4:	000d9320 	andeq	r9, sp, r0, lsr #6
     ff8:	2b310100 	blcs	c41400 <__bss_end+0xc38474>
     ffc:	000001f7 	strdeq	r0, [r0], -r7
    1000:	20689102 	rsbcs	r9, r8, r2, lsl #2
    1004:	00000bcd 	andeq	r0, r0, sp, asr #23
    1008:	4d3c3101 	ldfmis	f3, [ip, #-4]!
    100c:	02000000 	andeq	r0, r0, #0
    1010:	221e6491 	andscs	r6, lr, #-1862270976	; 0x91000000
    1014:	0100000d 	tsteq	r0, sp
    1018:	004d0e33 	subeq	r0, sp, r3, lsr lr
    101c:	91020000 	mrsls	r0, (UNDEF: 2)
    1020:	09210074 	stmdbeq	r1!, {r2, r4, r5, r6}
    1024:	01000010 	tsteq	r0, r0, lsl r0
    1028:	0e130a24 	vnmlseq.f32	s0, s6, s9
    102c:	004d0000 	subeq	r0, sp, r0
    1030:	84640000 	strbthi	r0, [r4], #-0
    1034:	00500000 	subseq	r0, r0, r0
    1038:	9c010000 	stcls	0, cr0, [r1], {-0}
    103c:	00000a61 	andeq	r0, r0, r1, ror #20
    1040:	00054520 	andeq	r4, r5, r0, lsr #10
    1044:	18240100 	stmdane	r4!, {r8}
    1048:	0000004d 	andeq	r0, r0, sp, asr #32
    104c:	206c9102 	rsbcs	r9, ip, r2, lsl #2
    1050:	00000d93 	muleq	r0, r3, sp
    1054:	672a2401 	strvs	r2, [sl, -r1, lsl #8]!
    1058:	0200000a 	andeq	r0, r0, #10
    105c:	cd206891 	stcgt	8, cr6, [r0, #-580]!	; 0xfffffdbc
    1060:	0100000b 	tsteq	r0, fp
    1064:	004d3b24 	subeq	r3, sp, r4, lsr #22
    1068:	91020000 	mrsls	r0, (UNDEF: 2)
    106c:	07a81e64 	streq	r1, [r8, r4, ror #28]!
    1070:	26010000 	strcs	r0, [r1], -r0
    1074:	00004d0e 	andeq	r4, r0, lr, lsl #26
    1078:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    107c:	25040d00 	strcs	r0, [r4, #-3328]	; 0xfffff300
    1080:	03000000 	movweq	r0, #0
    1084:	00000a61 	andeq	r0, r0, r1, ror #20
    1088:	000b5e21 	andeq	r5, fp, r1, lsr #28
    108c:	0a190100 	beq	641494 <__bss_end+0x638508>
    1090:	0000101b 	andeq	r1, r0, fp, lsl r0
    1094:	0000004d 	andeq	r0, r0, sp, asr #32
    1098:	00008420 	andeq	r8, r0, r0, lsr #8
    109c:	00000044 	andeq	r0, r0, r4, asr #32
    10a0:	0ab89c01 	beq	fee280ac <__bss_end+0xfee1f120>
    10a4:	ea200000 	b	8010ac <__bss_end+0x7f8120>
    10a8:	0100000f 	tsteq	r0, pc
    10ac:	01f71b19 	mvnseq	r1, r9, lsl fp
    10b0:	91020000 	mrsls	r0, (UNDEF: 2)
    10b4:	0d82206c 	stceq	0, cr2, [r2, #432]	; 0x1b0
    10b8:	19010000 	stmdbne	r1, {}	; <UNPREDICTABLE>
    10bc:	0001c635 	andeq	ip, r1, r5, lsr r6
    10c0:	68910200 	ldmvs	r1, {r9}
    10c4:	0005451e 	andeq	r4, r5, lr, lsl r5
    10c8:	0e1b0100 	mufeqe	f0, f3, f0
    10cc:	0000004d 	andeq	r0, r0, sp, asr #32
    10d0:	00749102 	rsbseq	r9, r4, r2, lsl #2
    10d4:	0009dd24 	andeq	sp, r9, r4, lsr #26
    10d8:	06140100 	ldreq	r0, [r4], -r0, lsl #2
    10dc:	000007c6 	andeq	r0, r0, r6, asr #15
    10e0:	00008404 	andeq	r8, r0, r4, lsl #8
    10e4:	0000001c 	andeq	r0, r0, ip, lsl r0
    10e8:	78239c01 	stmdavc	r3!, {r0, sl, fp, ip, pc}
    10ec:	0100000d 	tsteq	r0, sp
    10f0:	0a93060e 	beq	fe4c2930 <__bss_end+0xfe4b99a4>
    10f4:	83d80000 	bicshi	r0, r8, #0
    10f8:	002c0000 	eoreq	r0, ip, r0
    10fc:	9c010000 	stcls	0, cr0, [r1], {-0}
    1100:	00000af8 	strdeq	r0, [r0], -r8
    1104:	00092a20 	andeq	r2, r9, r0, lsr #20
    1108:	140e0100 	strne	r0, [lr], #-256	; 0xffffff00
    110c:	00000038 	andeq	r0, r0, r8, lsr r0
    1110:	00749102 	rsbseq	r9, r4, r2, lsl #2
    1114:	00101425 	andseq	r1, r0, r5, lsr #8
    1118:	0a040100 	beq	101520 <__bss_end+0xf8594>
    111c:	00000af0 	strdeq	r0, [r0], -r0	; <UNPREDICTABLE>
    1120:	0000004d 	andeq	r0, r0, sp, asr #32
    1124:	000083ac 	andeq	r8, r0, ip, lsr #7
    1128:	0000002c 	andeq	r0, r0, ip, lsr #32
    112c:	70229c01 	eorvc	r9, r2, r1, lsl #24
    1130:	01006469 	tsteq	r0, r9, ror #8
    1134:	004d0e06 	subeq	r0, sp, r6, lsl #28
    1138:	91020000 	mrsls	r0, (UNDEF: 2)
    113c:	2e000074 	mcrcs	0, 0, r0, cr0, cr4, {3}
    1140:	04000003 	streq	r0, [r0], #-3
    1144:	00057900 	andeq	r7, r5, r0, lsl #18
    1148:	37010400 	strcc	r0, [r1, -r0, lsl #8]
    114c:	0400000e 	streq	r0, [r0], #-14
    1150:	00001084 	andeq	r1, r0, r4, lsl #1
    1154:	000006b1 			; <UNDEFINED> instruction: 0x000006b1
    1158:	00008808 	andeq	r8, r0, r8, lsl #16
    115c:	000004b8 			; <UNDEFINED> instruction: 0x000004b8
    1160:	000007f5 	strdeq	r0, [r0], -r5
    1164:	00004902 	andeq	r4, r0, r2, lsl #18
    1168:	10ed0300 	rscne	r0, sp, r0, lsl #6
    116c:	05010000 	streq	r0, [r1, #-0]
    1170:	00006110 	andeq	r6, r0, r0, lsl r1
    1174:	31301100 	teqcc	r0, r0, lsl #2
    1178:	35343332 	ldrcc	r3, [r4, #-818]!	; 0xfffffcce
    117c:	39383736 	ldmdbcc	r8!, {r1, r2, r4, r5, r8, r9, sl, ip, sp}
    1180:	44434241 	strbmi	r4, [r3], #-577	; 0xfffffdbf
    1184:	00004645 	andeq	r4, r0, r5, asr #12
    1188:	01030104 	tsteq	r3, r4, lsl #2
    118c:	00000025 	andeq	r0, r0, r5, lsr #32
    1190:	00007405 	andeq	r7, r0, r5, lsl #8
    1194:	00006100 	andeq	r6, r0, r0, lsl #2
    1198:	00660600 	rsbeq	r0, r6, r0, lsl #12
    119c:	00100000 	andseq	r0, r0, r0
    11a0:	00005107 	andeq	r5, r0, r7, lsl #2
    11a4:	07040800 	streq	r0, [r4, -r0, lsl #16]
    11a8:	00000533 	andeq	r0, r0, r3, lsr r5
    11ac:	16080108 	strne	r0, [r8], -r8, lsl #2
    11b0:	07000005 	streq	r0, [r0, -r5]
    11b4:	0000006d 	andeq	r0, r0, sp, rrx
    11b8:	00002a09 	andeq	r2, r0, r9, lsl #20
    11bc:	111c0a00 	tstne	ip, r0, lsl #20
    11c0:	64010000 	strvs	r0, [r1], #-0
    11c4:	00110706 	andseq	r0, r1, r6, lsl #14
    11c8:	008c4000 	addeq	r4, ip, r0
    11cc:	00008000 	andeq	r8, r0, r0
    11d0:	fb9c0100 	blx	fe7015da <__bss_end+0xfe6f864e>
    11d4:	0b000000 	bleq	11dc <shift+0x11dc>
    11d8:	00637273 	rsbeq	r7, r3, r3, ror r2
    11dc:	fb196401 	blx	65a1ea <__bss_end+0x65125e>
    11e0:	02000000 	andeq	r0, r0, #0
    11e4:	640b6491 	strvs	r6, [fp], #-1169	; 0xfffffb6f
    11e8:	01007473 	tsteq	r0, r3, ror r4
    11ec:	01022464 	tsteq	r2, r4, ror #8
    11f0:	91020000 	mrsls	r0, (UNDEF: 2)
    11f4:	756e0b60 	strbvc	r0, [lr, #-2912]!	; 0xfffff4a0
    11f8:	6401006d 	strvs	r0, [r1], #-109	; 0xffffff93
    11fc:	0001042d 	andeq	r0, r1, sp, lsr #8
    1200:	5c910200 	lfmpl	f0, 4, [r1], {0}
    1204:	0011760c 	andseq	r7, r1, ip, lsl #12
    1208:	0e660100 	poweqs	f0, f6, f0
    120c:	0000010b 	andeq	r0, r0, fp, lsl #2
    1210:	0c709102 	ldfeqp	f1, [r0], #-8
    1214:	000010f9 	strdeq	r1, [r0], -r9
    1218:	11086701 	tstne	r8, r1, lsl #14
    121c:	02000001 	andeq	r0, r0, #1
    1220:	680d6c91 	stmdavs	sp, {r0, r4, r7, sl, fp, sp, lr}
    1224:	4800008c 	stmdami	r0, {r2, r3, r7}
    1228:	0e000000 	cdpeq	0, 0, cr0, cr0, cr0, {0}
    122c:	69010069 	stmdbvs	r1, {r0, r3, r5, r6}
    1230:	0001040b 	andeq	r0, r1, fp, lsl #8
    1234:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    1238:	040f0000 	streq	r0, [pc], #-0	; 1240 <shift+0x1240>
    123c:	00000101 	andeq	r0, r0, r1, lsl #2
    1240:	12041110 	andne	r1, r4, #16, 2
    1244:	6e690504 	cdpvs	5, 6, cr0, cr9, cr4, {0}
    1248:	040f0074 	streq	r0, [pc], #-116	; 1250 <shift+0x1250>
    124c:	00000074 	andeq	r0, r0, r4, ror r0
    1250:	006d040f 	rsbeq	r0, sp, pc, lsl #8
    1254:	720a0000 	andvc	r0, sl, #0
    1258:	01000010 	tsteq	r0, r0, lsl r0
    125c:	1078065c 	rsbsne	r0, r8, ip, asr r6
    1260:	8bd80000 	blhi	ff601268 <__bss_end+0xff5f82dc>
    1264:	00680000 	rsbeq	r0, r8, r0
    1268:	9c010000 	stcls	0, cr0, [r1], {-0}
    126c:	00000176 	andeq	r0, r0, r6, ror r1
    1270:	00116f13 	andseq	r6, r1, r3, lsl pc
    1274:	125c0100 	subsne	r0, ip, #0, 2
    1278:	00000102 	andeq	r0, r0, r2, lsl #2
    127c:	136c9102 	cmnne	ip, #-2147483648	; 0x80000000
    1280:	000005f5 	strdeq	r0, [r0], -r5
    1284:	041e5c01 	ldreq	r5, [lr], #-3073	; 0xfffff3ff
    1288:	02000001 	andeq	r0, r0, #1
    128c:	6d0e6891 	stcvs	8, cr6, [lr, #-580]	; 0xfffffdbc
    1290:	01006d65 	tsteq	r0, r5, ror #26
    1294:	0111085e 	tsteq	r1, lr, asr r8
    1298:	91020000 	mrsls	r0, (UNDEF: 2)
    129c:	8bf40d70 	blhi	ffd04864 <__bss_end+0xffcfb8d8>
    12a0:	003c0000 	eorseq	r0, ip, r0
    12a4:	690e0000 	stmdbvs	lr, {}	; <UNPREDICTABLE>
    12a8:	0b600100 	bleq	18016b0 <__bss_end+0x17f8724>
    12ac:	00000104 	andeq	r0, r0, r4, lsl #2
    12b0:	00749102 	rsbseq	r9, r4, r2, lsl #2
    12b4:	11231400 			; <UNDEFINED> instruction: 0x11231400
    12b8:	52010000 	andpl	r0, r1, #0
    12bc:	00113c05 	andseq	r3, r1, r5, lsl #24
    12c0:	00010400 	andeq	r0, r1, r0, lsl #8
    12c4:	008b8400 	addeq	r8, fp, r0, lsl #8
    12c8:	00005400 	andeq	r5, r0, r0, lsl #8
    12cc:	af9c0100 	svcge	0x009c0100
    12d0:	0b000001 	bleq	12dc <shift+0x12dc>
    12d4:	52010073 	andpl	r0, r1, #115	; 0x73
    12d8:	00010b18 	andeq	r0, r1, r8, lsl fp
    12dc:	6c910200 	lfmvs	f0, 4, [r1], {0}
    12e0:	0100690e 	tsteq	r0, lr, lsl #18
    12e4:	01040654 	tsteq	r4, r4, asr r6
    12e8:	91020000 	mrsls	r0, (UNDEF: 2)
    12ec:	5f140074 	svcpl	0x00140074
    12f0:	01000011 	tsteq	r0, r1, lsl r0
    12f4:	112a0542 			; <UNDEFINED> instruction: 0x112a0542
    12f8:	01040000 	mrseq	r0, (UNDEF: 4)
    12fc:	8ad80000 	bhi	ff601304 <__bss_end+0xff5f8378>
    1300:	00ac0000 	adceq	r0, ip, r0
    1304:	9c010000 	stcls	0, cr0, [r1], {-0}
    1308:	00000215 	andeq	r0, r0, r5, lsl r2
    130c:	0031730b 	eorseq	r7, r1, fp, lsl #6
    1310:	0b194201 	bleq	651b1c <__bss_end+0x648b90>
    1314:	02000001 	andeq	r0, r0, #1
    1318:	730b6c91 	movwvc	r6, #48273	; 0xbc91
    131c:	42010032 	andmi	r0, r1, #50	; 0x32
    1320:	00010b29 	andeq	r0, r1, r9, lsr #22
    1324:	68910200 	ldmvs	r1, {r9}
    1328:	6d756e0b 	ldclvs	14, cr6, [r5, #-44]!	; 0xffffffd4
    132c:	31420100 	mrscc	r0, (UNDEF: 82)
    1330:	00000104 	andeq	r0, r0, r4, lsl #2
    1334:	0e649102 	lgneqs	f1, f2
    1338:	01003175 	tsteq	r0, r5, ror r1
    133c:	02151044 	andseq	r1, r5, #68	; 0x44
    1340:	91020000 	mrsls	r0, (UNDEF: 2)
    1344:	32750e77 	rsbscc	r0, r5, #1904	; 0x770
    1348:	14440100 	strbne	r0, [r4], #-256	; 0xffffff00
    134c:	00000215 	andeq	r0, r0, r5, lsl r2
    1350:	00769102 	rsbseq	r9, r6, r2, lsl #2
    1354:	0d080108 	stfeqs	f0, [r8, #-32]	; 0xffffffe0
    1358:	14000005 	strne	r0, [r0], #-5
    135c:	00001167 	andeq	r1, r0, r7, ror #2
    1360:	4e073601 	cfmadd32mi	mvax0, mvfx3, mvfx7, mvfx1
    1364:	11000011 	tstne	r0, r1, lsl r0
    1368:	18000001 	stmdane	r0, {r0}
    136c:	c000008a 	andgt	r0, r0, sl, lsl #1
    1370:	01000000 	mrseq	r0, (UNDEF: 0)
    1374:	0002759c 	muleq	r2, ip, r5
    1378:	106d1300 	rsbne	r1, sp, r0, lsl #6
    137c:	36010000 	strcc	r0, [r1], -r0
    1380:	00011115 	andeq	r1, r1, r5, lsl r1
    1384:	6c910200 	lfmvs	f0, 4, [r1], {0}
    1388:	6372730b 	cmnvs	r2, #738197504	; 0x2c000000
    138c:	27360100 	ldrcs	r0, [r6, -r0, lsl #2]!
    1390:	0000010b 	andeq	r0, r0, fp, lsl #2
    1394:	0b689102 	bleq	1a257a4 <__bss_end+0x1a1c818>
    1398:	006d756e 	rsbeq	r7, sp, lr, ror #10
    139c:	04303601 	ldrteq	r3, [r0], #-1537	; 0xfffff9ff
    13a0:	02000001 	andeq	r0, r0, #1
    13a4:	690e6491 	stmdbvs	lr, {r0, r4, r7, sl, sp, lr}
    13a8:	06380100 	ldrteq	r0, [r8], -r0, lsl #2
    13ac:	00000104 	andeq	r0, r0, r4, lsl #2
    13b0:	00749102 	rsbseq	r9, r4, r2, lsl #2
    13b4:	00114914 	andseq	r4, r1, r4, lsl r9
    13b8:	05240100 	streq	r0, [r4, #-256]!	; 0xffffff00
    13bc:	000010e2 	andeq	r1, r0, r2, ror #1
    13c0:	00000104 	andeq	r0, r0, r4, lsl #2
    13c4:	0000897c 	andeq	r8, r0, ip, ror r9
    13c8:	0000009c 	muleq	r0, ip, r0
    13cc:	02b29c01 	adcseq	r9, r2, #256	; 0x100
    13d0:	67130000 	ldrvs	r0, [r3, -r0]
    13d4:	01000010 	tsteq	r0, r0, lsl r0
    13d8:	010b1624 	tsteq	fp, r4, lsr #12
    13dc:	91020000 	mrsls	r0, (UNDEF: 2)
    13e0:	11000c6c 	tstne	r0, ip, ror #24
    13e4:	26010000 	strcs	r0, [r1], -r0
    13e8:	00010406 	andeq	r0, r1, r6, lsl #8
    13ec:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    13f0:	117d1500 	cmnne	sp, r0, lsl #10
    13f4:	08010000 	stmdaeq	r1, {}	; <UNPREDICTABLE>
    13f8:	00118206 	andseq	r8, r1, r6, lsl #4
    13fc:	00880800 	addeq	r0, r8, r0, lsl #16
    1400:	00017400 	andeq	r7, r1, r0, lsl #8
    1404:	139c0100 	orrsne	r0, ip, #0, 2
    1408:	00001067 	andeq	r1, r0, r7, rrx
    140c:	66180801 	ldrvs	r0, [r8], -r1, lsl #16
    1410:	02000000 	andeq	r0, r0, #0
    1414:	00136491 	mulseq	r3, r1, r4
    1418:	01000011 	tsteq	r0, r1, lsl r0
    141c:	01112508 	tsteq	r1, r8, lsl #10
    1420:	91020000 	mrsls	r0, (UNDEF: 2)
    1424:	11171360 	tstne	r7, r0, ror #6
    1428:	08010000 	stmdaeq	r1, {}	; <UNPREDICTABLE>
    142c:	0000663a 	andeq	r6, r0, sl, lsr r6
    1430:	5c910200 	lfmpl	f0, 4, [r1], {0}
    1434:	0100690e 	tsteq	r0, lr, lsl #18
    1438:	0104060a 	tsteq	r4, sl, lsl #12
    143c:	91020000 	mrsls	r0, (UNDEF: 2)
    1440:	88d40d74 	ldmhi	r4, {r2, r4, r5, r6, r8, sl, fp}^
    1444:	00980000 	addseq	r0, r8, r0
    1448:	6a0e0000 	bvs	381450 <__bss_end+0x3784c4>
    144c:	0b1c0100 	bleq	701854 <__bss_end+0x6f88c8>
    1450:	00000104 	andeq	r0, r0, r4, lsl #2
    1454:	0d709102 	ldfeqp	f1, [r0, #-8]!
    1458:	000088fc 	strdeq	r8, [r0], -ip
    145c:	00000060 	andeq	r0, r0, r0, rrx
    1460:	0100630e 	tsteq	r0, lr, lsl #6
    1464:	006d081e 	rsbeq	r0, sp, lr, lsl r8
    1468:	91020000 	mrsls	r0, (UNDEF: 2)
    146c:	0000006f 	andeq	r0, r0, pc, rrx
	...

Disassembly of section .debug_abbrev:

00000000 <.debug_abbrev>:
   0:	10001101 	andne	r1, r0, r1, lsl #2
   4:	12011106 	andne	r1, r1, #-2147483647	; 0x80000001
   8:	1b0e0301 	blne	380c14 <__bss_end+0x377c88>
   c:	130e250e 	movwne	r2, #58638	; 0xe50e
  10:	00000005 	andeq	r0, r0, r5
  14:	25011101 	strcs	r1, [r1, #-257]	; 0xfffffeff
  18:	030b130e 	movweq	r1, #45838	; 0xb30e
  1c:	110e1b0e 	tstne	lr, lr, lsl #22
  20:	10061201 	andne	r1, r6, r1, lsl #4
  24:	02000017 	andeq	r0, r0, #23
  28:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
  2c:	0b3b0b3a 	bleq	ec2d1c <__bss_end+0xeb9d90>
  30:	13490b39 	movtne	r0, #39737	; 0x9b39
  34:	193c193f 	ldmdbne	ip!, {r0, r1, r2, r3, r4, r5, r8, fp, ip}
  38:	24030000 	strcs	r0, [r3], #-0
  3c:	3e0b0b00 	vmlacc.f64	d0, d11, d0
  40:	000e030b 	andeq	r0, lr, fp, lsl #6
  44:	012e0400 			; <UNDEFINED> instruction: 0x012e0400
  48:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
  4c:	0b3b0b3a 	bleq	ec2d3c <__bss_end+0xeb9db0>
  50:	01110b39 	tsteq	r1, r9, lsr fp
  54:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
  58:	01194296 			; <UNDEFINED> instruction: 0x01194296
  5c:	05000013 	streq	r0, [r0, #-19]	; 0xffffffed
  60:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
  64:	0b3b0b3a 	bleq	ec2d54 <__bss_end+0xeb9dc8>
  68:	13490b39 	movtne	r0, #39737	; 0x9b39
  6c:	00001802 	andeq	r1, r0, r2, lsl #16
  70:	0b002406 	bleq	9090 <__bss_end+0x104>
  74:	030b3e0b 	movweq	r3, #48651	; 0xbe0b
  78:	07000008 	streq	r0, [r0, -r8]
  7c:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
  80:	0b3a0e03 	bleq	e83894 <__bss_end+0xe7a908>
  84:	0b390b3b 	bleq	e42d78 <__bss_end+0xe39dec>
  88:	06120111 			; <UNDEFINED> instruction: 0x06120111
  8c:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
  90:	00130119 	andseq	r0, r3, r9, lsl r1
  94:	010b0800 	tsteq	fp, r0, lsl #16
  98:	06120111 			; <UNDEFINED> instruction: 0x06120111
  9c:	34090000 	strcc	r0, [r9], #-0
  a0:	3a080300 	bcc	200ca8 <__bss_end+0x1f7d1c>
  a4:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
  a8:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
  ac:	0a000018 	beq	114 <shift+0x114>
  b0:	0b0b000f 	bleq	2c00f4 <__bss_end+0x2b7168>
  b4:	00001349 	andeq	r1, r0, r9, asr #6
  b8:	01110100 	tsteq	r1, r0, lsl #2
  bc:	0b130e25 	bleq	4c3958 <__bss_end+0x4ba9cc>
  c0:	0e1b0e03 	cdpeq	14, 1, cr0, cr11, cr3, {0}
  c4:	06120111 			; <UNDEFINED> instruction: 0x06120111
  c8:	00001710 	andeq	r1, r0, r0, lsl r7
  cc:	03001602 	movweq	r1, #1538	; 0x602
  d0:	3b0b3a0e 	blcc	2ce910 <__bss_end+0x2c5984>
  d4:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
  d8:	03000013 	movweq	r0, #19
  dc:	0b0b000f 	bleq	2c0120 <__bss_end+0x2b7194>
  e0:	00001349 	andeq	r1, r0, r9, asr #6
  e4:	00001504 	andeq	r1, r0, r4, lsl #10
  e8:	01010500 	tsteq	r1, r0, lsl #10
  ec:	13011349 	movwne	r1, #4937	; 0x1349
  f0:	21060000 	mrscs	r0, (UNDEF: 6)
  f4:	2f134900 	svccs	0x00134900
  f8:	07000006 	streq	r0, [r0, -r6]
  fc:	0b0b0024 	bleq	2c0194 <__bss_end+0x2b7208>
 100:	0e030b3e 	vmoveq.16	d3[0], r0
 104:	34080000 	strcc	r0, [r8], #-0
 108:	3a0e0300 	bcc	380d10 <__bss_end+0x377d84>
 10c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 110:	3f13490b 	svccc	0x0013490b
 114:	00193c19 	andseq	r3, r9, r9, lsl ip
 118:	012e0900 			; <UNDEFINED> instruction: 0x012e0900
 11c:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 120:	0b3b0b3a 	bleq	ec2e10 <__bss_end+0xeb9e84>
 124:	13490b39 	movtne	r0, #39737	; 0x9b39
 128:	06120111 			; <UNDEFINED> instruction: 0x06120111
 12c:	42961840 	addsmi	r1, r6, #64, 16	; 0x400000
 130:	00130119 	andseq	r0, r3, r9, lsl r1
 134:	00340a00 	eorseq	r0, r4, r0, lsl #20
 138:	0b3a0e03 	bleq	e8394c <__bss_end+0xe7a9c0>
 13c:	0b390b3b 	bleq	e42e30 <__bss_end+0xe39ea4>
 140:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 144:	240b0000 	strcs	r0, [fp], #-0
 148:	3e0b0b00 	vmlacc.f64	d0, d11, d0
 14c:	0008030b 	andeq	r0, r8, fp, lsl #6
 150:	002e0c00 	eoreq	r0, lr, r0, lsl #24
 154:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 158:	0b3b0b3a 	bleq	ec2e48 <__bss_end+0xeb9ebc>
 15c:	01110b39 	tsteq	r1, r9, lsr fp
 160:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 164:	00194297 	mulseq	r9, r7, r2
 168:	01390d00 	teqeq	r9, r0, lsl #26
 16c:	0b3a0e03 	bleq	e83980 <__bss_end+0xe7a9f4>
 170:	13010b3b 	movwne	r0, #6971	; 0x1b3b
 174:	2e0e0000 	cdpcs	0, 0, cr0, cr14, cr0, {0}
 178:	03193f01 	tsteq	r9, #1, 30
 17c:	3b0b3a0e 	blcc	2ce9bc <__bss_end+0x2c5a30>
 180:	3c0b390b 			; <UNDEFINED> instruction: 0x3c0b390b
 184:	00130119 	andseq	r0, r3, r9, lsl r1
 188:	00050f00 	andeq	r0, r5, r0, lsl #30
 18c:	00001349 	andeq	r1, r0, r9, asr #6
 190:	3f012e10 	svccc	0x00012e10
 194:	3a0e0319 	bcc	380e00 <__bss_end+0x377e74>
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
 1c0:	3a080300 	bcc	200dc8 <__bss_end+0x1f7e3c>
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
 1f4:	0b0b0024 	bleq	2c028c <__bss_end+0x2b7300>
 1f8:	0e030b3e 	vmoveq.16	d3[0], r0
 1fc:	26030000 	strcs	r0, [r3], -r0
 200:	00134900 	andseq	r4, r3, r0, lsl #18
 204:	00240400 	eoreq	r0, r4, r0, lsl #8
 208:	0b3e0b0b 	bleq	f82e3c <__bss_end+0xf79eb0>
 20c:	00000803 	andeq	r0, r0, r3, lsl #16
 210:	03001605 	movweq	r1, #1541	; 0x605
 214:	3b0b3a0e 	blcc	2cea54 <__bss_end+0x2c5ac8>
 218:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 21c:	06000013 			; <UNDEFINED> instruction: 0x06000013
 220:	0e030104 	adfeqs	f0, f3, f4
 224:	0b3e196d 	bleq	f867e0 <__bss_end+0xf7d854>
 228:	13490b0b 	movtne	r0, #39691	; 0x9b0b
 22c:	0b3b0b3a 	bleq	ec2f1c <__bss_end+0xeb9f90>
 230:	13010b39 	movwne	r0, #6969	; 0x1b39
 234:	28070000 	stmdacs	r7, {}	; <UNPREDICTABLE>
 238:	1c0e0300 	stcne	3, cr0, [lr], {-0}
 23c:	0800000b 	stmdaeq	r0, {r0, r1, r3}
 240:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 244:	0b3b0b3a 	bleq	ec2f34 <__bss_end+0xeb9fa8>
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
 284:	0b3a0b0b 	bleq	e82eb8 <__bss_end+0xe79f2c>
 288:	0b390b3b 	bleq	e42f7c <__bss_end+0xe39ff0>
 28c:	00001301 	andeq	r1, r0, r1, lsl #6
 290:	03000d0f 	movweq	r0, #3343	; 0xd0f
 294:	3b0b3a0e 	blcc	2cead4 <__bss_end+0x2c5b48>
 298:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 29c:	000b3813 	andeq	r3, fp, r3, lsl r8
 2a0:	012e1000 			; <UNDEFINED> instruction: 0x012e1000
 2a4:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 2a8:	0b3b0b3a 	bleq	ec2f98 <__bss_end+0xeba00c>
 2ac:	13490b39 	movtne	r0, #39737	; 0x9b39
 2b0:	06120111 			; <UNDEFINED> instruction: 0x06120111
 2b4:	42961840 	addsmi	r1, r6, #64, 16	; 0x400000
 2b8:	00130119 	andseq	r0, r3, r9, lsl r1
 2bc:	00051100 	andeq	r1, r5, r0, lsl #2
 2c0:	0b3a0e03 	bleq	e83ad4 <__bss_end+0xe7ab48>
 2c4:	0b390b3b 	bleq	e42fb8 <__bss_end+0xe3a02c>
 2c8:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 2cc:	34120000 	ldrcc	r0, [r2], #-0
 2d0:	3a0e0300 	bcc	380ed8 <__bss_end+0x377f4c>
 2d4:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 2d8:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 2dc:	13000018 	movwne	r0, #24
 2e0:	08030034 	stmdaeq	r3, {r2, r4, r5}
 2e4:	0b3b0b3a 	bleq	ec2fd4 <__bss_end+0xeba048>
 2e8:	13490b39 	movtne	r0, #39737	; 0x9b39
 2ec:	00001802 	andeq	r1, r0, r2, lsl #16
 2f0:	11010b14 	tstne	r1, r4, lsl fp
 2f4:	00061201 	andeq	r1, r6, r1, lsl #4
 2f8:	012e1500 			; <UNDEFINED> instruction: 0x012e1500
 2fc:	0b3a0e03 	bleq	e83b10 <__bss_end+0xe7ab84>
 300:	0b390b3b 	bleq	e42ff4 <__bss_end+0xe3a068>
 304:	06120111 			; <UNDEFINED> instruction: 0x06120111
 308:	42961840 	addsmi	r1, r6, #64, 16	; 0x400000
 30c:	00000019 	andeq	r0, r0, r9, lsl r0
 310:	25011101 	strcs	r1, [r1, #-257]	; 0xfffffeff
 314:	030b130e 	movweq	r1, #45838	; 0xb30e
 318:	110e1b0e 	tstne	lr, lr, lsl #22
 31c:	10061201 	andne	r1, r6, r1, lsl #4
 320:	02000017 	andeq	r0, r0, #23
 324:	0b0b0024 	bleq	2c03bc <__bss_end+0x2b7430>
 328:	0e030b3e 	vmoveq.16	d3[0], r0
 32c:	26030000 	strcs	r0, [r3], -r0
 330:	00134900 	andseq	r4, r3, r0, lsl #18
 334:	00240400 	eoreq	r0, r4, r0, lsl #8
 338:	0b3e0b0b 	bleq	f82f6c <__bss_end+0xf79fe0>
 33c:	00000803 	andeq	r0, r0, r3, lsl #16
 340:	03001605 	movweq	r1, #1541	; 0x605
 344:	3b0b3a0e 	blcc	2ceb84 <__bss_end+0x2c5bf8>
 348:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 34c:	06000013 			; <UNDEFINED> instruction: 0x06000013
 350:	0e030113 	mcreq	1, 0, r0, cr3, cr3, {0}
 354:	0b3a0b0b 	bleq	e82f88 <__bss_end+0xe79ffc>
 358:	0b390b3b 	bleq	e4304c <__bss_end+0xe3a0c0>
 35c:	00001301 	andeq	r1, r0, r1, lsl #6
 360:	03000d07 	movweq	r0, #3335	; 0xd07
 364:	3b0b3a08 	blcc	2ceb8c <__bss_end+0x2c5c00>
 368:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 36c:	000b3813 	andeq	r3, fp, r3, lsl r8
 370:	01040800 	tsteq	r4, r0, lsl #16
 374:	196d0e03 	stmdbne	sp!, {r0, r1, r9, sl, fp}^
 378:	0b0b0b3e 	bleq	2c3078 <__bss_end+0x2ba0ec>
 37c:	0b3a1349 	bleq	e850a8 <__bss_end+0xe7c11c>
 380:	0b390b3b 	bleq	e43074 <__bss_end+0xe3a0e8>
 384:	00001301 	andeq	r1, r0, r1, lsl #6
 388:	03002809 	movweq	r2, #2057	; 0x809
 38c:	000b1c08 	andeq	r1, fp, r8, lsl #24
 390:	00280a00 	eoreq	r0, r8, r0, lsl #20
 394:	0b1c0e03 	bleq	703ba8 <__bss_end+0x6fac1c>
 398:	340b0000 	strcc	r0, [fp], #-0
 39c:	3a0e0300 	bcc	380fa4 <__bss_end+0x378018>
 3a0:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 3a4:	6c13490b 			; <UNDEFINED> instruction: 0x6c13490b
 3a8:	00180219 	andseq	r0, r8, r9, lsl r2
 3ac:	00020c00 	andeq	r0, r2, r0, lsl #24
 3b0:	193c0e03 	ldmdbne	ip!, {r0, r1, r9, sl, fp}
 3b4:	0f0d0000 	svceq	0x000d0000
 3b8:	490b0b00 	stmdbmi	fp, {r8, r9, fp}
 3bc:	0e000013 	mcreq	0, 0, r0, cr0, cr3, {0}
 3c0:	0e03000d 	cdpeq	0, 0, cr0, cr3, cr13, {0}
 3c4:	0b3b0b3a 	bleq	ec30b4 <__bss_end+0xeba128>
 3c8:	13490b39 	movtne	r0, #39737	; 0x9b39
 3cc:	00000b38 	andeq	r0, r0, r8, lsr fp
 3d0:	4901010f 	stmdbmi	r1, {r0, r1, r2, r3, r8}
 3d4:	00130113 	andseq	r0, r3, r3, lsl r1
 3d8:	00211000 	eoreq	r1, r1, r0
 3dc:	0b2f1349 	bleq	bc5108 <__bss_end+0xbbc17c>
 3e0:	02110000 	andseq	r0, r1, #0
 3e4:	0b0e0301 	bleq	380ff0 <__bss_end+0x378064>
 3e8:	3b0b3a0b 	blcc	2cec1c <__bss_end+0x2c5c90>
 3ec:	010b390b 	tsteq	fp, fp, lsl #18
 3f0:	12000013 	andne	r0, r0, #19
 3f4:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 3f8:	0b3a0e03 	bleq	e83c0c <__bss_end+0xe7ac80>
 3fc:	0b390b3b 	bleq	e430f0 <__bss_end+0xe3a164>
 400:	193c0e6e 	ldmdbne	ip!, {r1, r2, r3, r5, r6, r9, sl, fp}
 404:	13011364 	movwne	r1, #4964	; 0x1364
 408:	05130000 	ldreq	r0, [r3, #-0]
 40c:	34134900 	ldrcc	r4, [r3], #-2304	; 0xfffff700
 410:	14000019 	strne	r0, [r0], #-25	; 0xffffffe7
 414:	13490005 	movtne	r0, #36869	; 0x9005
 418:	2e150000 	cdpcs	0, 1, cr0, cr5, cr0, {0}
 41c:	03193f01 	tsteq	r9, #1, 30
 420:	3b0b3a0e 	blcc	2cec60 <__bss_end+0x2c5cd4>
 424:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 428:	3c13490e 			; <UNDEFINED> instruction: 0x3c13490e
 42c:	01136419 	tsteq	r3, r9, lsl r4
 430:	16000013 			; <UNDEFINED> instruction: 0x16000013
 434:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 438:	0b3a0e03 	bleq	e83c4c <__bss_end+0xe7acc0>
 43c:	0b390b3b 	bleq	e43130 <__bss_end+0xe3a1a4>
 440:	13490e6e 	movtne	r0, #40558	; 0x9e6e
 444:	193c0b32 	ldmdbne	ip!, {r1, r4, r5, r8, r9, fp}
 448:	13011364 	movwne	r1, #4964	; 0x1364
 44c:	0d170000 	ldceq	0, cr0, [r7, #-0]
 450:	3a0e0300 	bcc	381058 <__bss_end+0x3780cc>
 454:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 458:	3813490b 	ldmdacc	r3, {r0, r1, r3, r8, fp, lr}
 45c:	000b320b 	andeq	r3, fp, fp, lsl #4
 460:	012e1800 			; <UNDEFINED> instruction: 0x012e1800
 464:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 468:	0b3b0b3a 	bleq	ec3158 <__bss_end+0xeba1cc>
 46c:	0e6e0b39 	vmoveq.8	d14[5], r0
 470:	193c0b32 	ldmdbne	ip!, {r1, r4, r5, r8, r9, fp}
 474:	13011364 	movwne	r1, #4964	; 0x1364
 478:	2e190000 	cdpcs	0, 1, cr0, cr9, cr0, {0}
 47c:	03193f01 	tsteq	r9, #1, 30
 480:	3b0b3a0e 	blcc	2cecc0 <__bss_end+0x2c5d34>
 484:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 488:	3213490e 	andscc	r4, r3, #229376	; 0x38000
 48c:	64193c0b 	ldrvs	r3, [r9], #-3083	; 0xfffff3f5
 490:	1a000013 	bne	4e4 <shift+0x4e4>
 494:	13490115 	movtne	r0, #37141	; 0x9115
 498:	13011364 	movwne	r1, #4964	; 0x1364
 49c:	1f1b0000 	svcne	0x001b0000
 4a0:	49131d00 	ldmdbmi	r3, {r8, sl, fp, ip}
 4a4:	1c000013 	stcne	0, cr0, [r0], {19}
 4a8:	0b0b0010 	bleq	2c04f0 <__bss_end+0x2b7564>
 4ac:	00001349 	andeq	r1, r0, r9, asr #6
 4b0:	0b000f1d 	bleq	412c <shift+0x412c>
 4b4:	1e00000b 	cdpne	0, 0, cr0, cr0, cr11, {0}
 4b8:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 4bc:	0b3b0b3a 	bleq	ec31ac <__bss_end+0xeba220>
 4c0:	13490b39 	movtne	r0, #39737	; 0x9b39
 4c4:	00001802 	andeq	r1, r0, r2, lsl #16
 4c8:	3f012e1f 	svccc	0x00012e1f
 4cc:	3a0e0319 	bcc	381138 <__bss_end+0x3781ac>
 4d0:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 4d4:	490e6e0b 	stmdbmi	lr, {r0, r1, r3, r9, sl, fp, sp, lr}
 4d8:	12011113 	andne	r1, r1, #-1073741820	; 0xc0000004
 4dc:	96184006 	ldrls	r4, [r8], -r6
 4e0:	13011942 	movwne	r1, #6466	; 0x1942
 4e4:	05200000 	streq	r0, [r0, #-0]!
 4e8:	3a0e0300 	bcc	3810f0 <__bss_end+0x378164>
 4ec:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 4f0:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 4f4:	21000018 	tstcs	r0, r8, lsl r0
 4f8:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 4fc:	0b3a0e03 	bleq	e83d10 <__bss_end+0xe7ad84>
 500:	0b390b3b 	bleq	e431f4 <__bss_end+0xe3a268>
 504:	13490e6e 	movtne	r0, #40558	; 0x9e6e
 508:	06120111 			; <UNDEFINED> instruction: 0x06120111
 50c:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
 510:	00130119 	andseq	r0, r3, r9, lsl r1
 514:	00342200 	eorseq	r2, r4, r0, lsl #4
 518:	0b3a0803 	bleq	e8252c <__bss_end+0xe795a0>
 51c:	0b390b3b 	bleq	e43210 <__bss_end+0xe3a284>
 520:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 524:	2e230000 	cdpcs	0, 2, cr0, cr3, cr0, {0}
 528:	03193f01 	tsteq	r9, #1, 30
 52c:	3b0b3a0e 	blcc	2ced6c <__bss_end+0x2c5de0>
 530:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 534:	1201110e 	andne	r1, r1, #-2147483645	; 0x80000003
 538:	97184006 	ldrls	r4, [r8, -r6]
 53c:	13011942 	movwne	r1, #6466	; 0x1942
 540:	2e240000 	cdpcs	0, 2, cr0, cr4, cr0, {0}
 544:	03193f00 	tsteq	r9, #0, 30
 548:	3b0b3a0e 	blcc	2ced88 <__bss_end+0x2c5dfc>
 54c:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 550:	1201110e 	andne	r1, r1, #-2147483645	; 0x80000003
 554:	97184006 	ldrls	r4, [r8, -r6]
 558:	00001942 	andeq	r1, r0, r2, asr #18
 55c:	3f012e25 	svccc	0x00012e25
 560:	3a0e0319 	bcc	3811cc <__bss_end+0x378240>
 564:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 568:	490e6e0b 	stmdbmi	lr, {r0, r1, r3, r9, sl, fp, sp, lr}
 56c:	12011113 	andne	r1, r1, #-1073741820	; 0xc0000004
 570:	97184006 	ldrls	r4, [r8, -r6]
 574:	00001942 	andeq	r1, r0, r2, asr #18
 578:	01110100 	tsteq	r1, r0, lsl #2
 57c:	0b130e25 	bleq	4c3e18 <__bss_end+0x4bae8c>
 580:	0e1b0e03 	cdpeq	14, 1, cr0, cr11, cr3, {0}
 584:	06120111 			; <UNDEFINED> instruction: 0x06120111
 588:	00001710 	andeq	r1, r0, r0, lsl r7
 58c:	01013902 	tsteq	r1, r2, lsl #18
 590:	03000013 	movweq	r0, #19
 594:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 598:	0b3b0b3a 	bleq	ec3288 <__bss_end+0xeba2fc>
 59c:	13490b39 	movtne	r0, #39737	; 0x9b39
 5a0:	0a1c193c 	beq	706a98 <__bss_end+0x6fdb0c>
 5a4:	3a040000 	bcc	1005ac <__bss_end+0xf7620>
 5a8:	3b0b3a00 	blcc	2cedb0 <__bss_end+0x2c5e24>
 5ac:	180b390b 	stmdane	fp, {r0, r1, r3, r8, fp, ip, sp}
 5b0:	05000013 	streq	r0, [r0, #-19]	; 0xffffffed
 5b4:	13490101 	movtne	r0, #37121	; 0x9101
 5b8:	00001301 	andeq	r1, r0, r1, lsl #6
 5bc:	49002106 	stmdbmi	r0, {r1, r2, r8, sp}
 5c0:	000b2f13 	andeq	r2, fp, r3, lsl pc
 5c4:	00260700 	eoreq	r0, r6, r0, lsl #14
 5c8:	00001349 	andeq	r1, r0, r9, asr #6
 5cc:	0b002408 	bleq	95f4 <__bss_end+0x668>
 5d0:	030b3e0b 	movweq	r3, #48651	; 0xbe0b
 5d4:	0900000e 	stmdbeq	r0, {r1, r2, r3}
 5d8:	13470034 	movtne	r0, #28724	; 0x7034
 5dc:	2e0a0000 	cdpcs	0, 0, cr0, cr10, cr0, {0}
 5e0:	03193f01 	tsteq	r9, #1, 30
 5e4:	3b0b3a0e 	blcc	2cee24 <__bss_end+0x2c5e98>
 5e8:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 5ec:	1201110e 	andne	r1, r1, #-2147483645	; 0x80000003
 5f0:	97184006 	ldrls	r4, [r8, -r6]
 5f4:	13011942 	movwne	r1, #6466	; 0x1942
 5f8:	050b0000 	streq	r0, [fp, #-0]
 5fc:	3a080300 	bcc	201204 <__bss_end+0x1f8278>
 600:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 604:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 608:	0c000018 	stceq	0, cr0, [r0], {24}
 60c:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 610:	0b3b0b3a 	bleq	ec3300 <__bss_end+0xeba374>
 614:	13490b39 	movtne	r0, #39737	; 0x9b39
 618:	00001802 	andeq	r1, r0, r2, lsl #16
 61c:	11010b0d 	tstne	r1, sp, lsl #22
 620:	00061201 	andeq	r1, r6, r1, lsl #4
 624:	00340e00 	eorseq	r0, r4, r0, lsl #28
 628:	0b3a0803 	bleq	e8263c <__bss_end+0xe796b0>
 62c:	0b390b3b 	bleq	e43320 <__bss_end+0xe3a394>
 630:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 634:	0f0f0000 	svceq	0x000f0000
 638:	490b0b00 	stmdbmi	fp, {r8, r9, fp}
 63c:	10000013 	andne	r0, r0, r3, lsl r0
 640:	00000026 	andeq	r0, r0, r6, lsr #32
 644:	0b000f11 	bleq	4290 <shift+0x4290>
 648:	1200000b 	andne	r0, r0, #11
 64c:	0b0b0024 	bleq	2c06e4 <__bss_end+0x2b7758>
 650:	08030b3e 	stmdaeq	r3, {r1, r2, r3, r4, r5, r8, r9, fp}
 654:	05130000 	ldreq	r0, [r3, #-0]
 658:	3a0e0300 	bcc	381260 <__bss_end+0x3782d4>
 65c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 660:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 664:	14000018 	strne	r0, [r0], #-24	; 0xffffffe8
 668:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 66c:	0b3a0e03 	bleq	e83e80 <__bss_end+0xe7aef4>
 670:	0b390b3b 	bleq	e43364 <__bss_end+0xe3a3d8>
 674:	13490e6e 	movtne	r0, #40558	; 0x9e6e
 678:	06120111 			; <UNDEFINED> instruction: 0x06120111
 67c:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
 680:	00130119 	andseq	r0, r3, r9, lsl r1
 684:	012e1500 			; <UNDEFINED> instruction: 0x012e1500
 688:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 68c:	0b3b0b3a 	bleq	ec337c <__bss_end+0xeba3f0>
 690:	0e6e0b39 	vmoveq.8	d14[5], r0
 694:	06120111 			; <UNDEFINED> instruction: 0x06120111
 698:	42961840 	addsmi	r1, r6, #64, 16	; 0x400000
 69c:	00000019 	andeq	r0, r0, r9, lsl r0

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
  74:	00000180 	andeq	r0, r0, r0, lsl #3
	...
  80:	0000001c 	andeq	r0, r0, ip, lsl r0
  84:	061c0002 	ldreq	r0, [ip], -r2
  88:	00040000 	andeq	r0, r4, r0
  8c:	00000000 	andeq	r0, r0, r0
  90:	000083ac 	andeq	r8, r0, ip, lsr #7
  94:	0000045c 	andeq	r0, r0, ip, asr r4
	...
  a0:	0000001c 	andeq	r0, r0, ip, lsl r0
  a4:	113f0002 	teqne	pc, r2
  a8:	00040000 	andeq	r0, r4, r0
  ac:	00000000 	andeq	r0, r0, r0
  b0:	00008808 	andeq	r8, r0, r8, lsl #16
  b4:	000004b8 			; <UNDEFINED> instruction: 0x000004b8
	...

Disassembly of section .debug_str:

00000000 <.debug_str>:
       0:	6573552f 	ldrbvs	r5, [r3, #-1327]!	; 0xfffffad1
       4:	772f7372 			; <UNDEFINED> instruction: 0x772f7372
       8:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
       c:	2f696a72 	svccs	0x00696a72
      10:	6b736544 	blvs	1cd9528 <__bss_end+0x1cd059c>
      14:	2f706f74 	svccs	0x00706f74
      18:	2f564146 	svccs	0x00564146
      1c:	6176614e 	cmnvs	r6, lr, asr #2
      20:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
      24:	4f2f6963 	svcmi	0x002f6963
      28:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
      2c:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
      30:	6b6c6172 	blvs	1b18600 <__bss_end+0x1b0f674>
      34:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
      38:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
      3c:	756f732f 	strbvc	r7, [pc, #-815]!	; fffffd15 <__bss_end+0xffff6d89>
      40:	73656372 	cmnvc	r5, #-939524095	; 0xc8000001
      44:	6573752f 	ldrbvs	r7, [r3, #-1327]!	; 0xfffffad1
      48:	61707372 	cmnvs	r0, r2, ror r3
      4c:	632f6563 			; <UNDEFINED> instruction: 0x632f6563
      50:	2e307472 	mrccs	4, 1, r7, cr0, cr2, {3}
      54:	552f0073 	strpl	r0, [pc, #-115]!	; ffffffe9 <__bss_end+0xffff705d>
      58:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
      5c:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
      60:	6a726574 	bvs	1c99638 <__bss_end+0x1c906ac>
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
      98:	752f7365 	strvc	r7, [pc, #-869]!	; fffffd3b <__bss_end+0xffff6daf>
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
     12c:	6a363731 	bvs	d8ddf8 <__bss_end+0xd84e6c>
     130:	732d667a 			; <UNDEFINED> instruction: 0x732d667a
     134:	616d2d20 	cmnvs	sp, r0, lsr #26
     138:	2d206d72 	stccs	13, cr6, [r0, #-456]!	; 0xfffffe38
     13c:	6372616d 	cmnvs	r2, #1073741851	; 0x4000001b
     140:	72613d68 	rsbvc	r3, r1, #104, 26	; 0x1a00
     144:	7a36766d 	bvc	d9db00 <__bss_end+0xd94b74>
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
     184:	6a757a61 	bvs	1d5eb10 <__bss_end+0x1d55b84>
     188:	2f696369 	svccs	0x00696369
     18c:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
     190:	73656d65 	cmnvc	r5, #6464	; 0x1940
     194:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
     198:	6b2d616b 	blvs	b5874c <__bss_end+0xb4f7c0>
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
     1e4:	2b2b4320 	blcs	ad0e6c <__bss_end+0xac7ee0>
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
     260:	2b6b7a36 	blcs	1adeb40 <__bss_end+0x1ad5bb4>
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
     294:	755f6962 	ldrbvc	r6, [pc, #-2402]	; fffff93a <__bss_end+0xffff69ae>
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
     324:	6b736544 	blvs	1cd983c <__bss_end+0x1cd08b0>
     328:	2f706f74 	svccs	0x00706f74
     32c:	2f564146 	svccs	0x00564146
     330:	6176614e 	cmnvs	r6, lr, asr #2
     334:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
     338:	4f2f6963 	svcmi	0x002f6963
     33c:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
     340:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
     344:	6b6c6172 	blvs	1b18914 <__bss_end+0x1b0f988>
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
     438:	315f5242 	cmpcc	pc, r2, asr #4
     43c:	30323531 	eorscc	r3, r2, r1, lsr r5
     440:	552f0030 	strpl	r0, [pc, #-48]!	; 418 <shift+0x418>
     444:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
     448:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
     44c:	6a726574 	bvs	1c99a24 <__bss_end+0x1c90a98>
     450:	65442f69 	strbvs	r2, [r4, #-3945]	; 0xfffff097
     454:	6f746b73 	svcvs	0x00746b73
     458:	41462f70 	hvcmi	25328	; 0x62f0
     45c:	614e2f56 	cmpvs	lr, r6, asr pc
     460:	757a6176 	ldrbvc	r6, [sl, #-374]!	; 0xfffffe8a
     464:	6963696a 	stmdbvs	r3!, {r1, r3, r5, r6, r8, fp, sp, lr}^
     468:	2f534f2f 	svccs	0x00534f2f
     46c:	656d6573 	strbvs	r6, [sp, #-1395]!	; 0xfffffa8d
     470:	61727473 	cmnvs	r2, r3, ror r4
     474:	2d616b6c 	vstmdbcs	r1!, {d22-<overflow reg d75>}
     478:	2d76696b 			; <UNDEFINED> instruction: 0x2d76696b
     47c:	732f736f 			; <UNDEFINED> instruction: 0x732f736f
     480:	6372756f 	cmnvs	r2, #465567744	; 0x1bc00000
     484:	752f7365 	strvc	r7, [pc, #-869]!	; 127 <shift+0x127>
     488:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
     48c:	65636170 	strbvs	r6, [r3, #-368]!	; 0xfffffe90
     490:	676f6c2f 	strbvs	r6, [pc, -pc, lsr #24]!
     494:	5f726567 	svcpl	0x00726567
     498:	6b736174 	blvs	1cd8a70 <__bss_end+0x1ccfae4>
     49c:	69616d2f 	stmdbvs	r1!, {r0, r1, r2, r3, r5, r8, sl, fp, sp, lr}^
     4a0:	70632e6e 	rsbvc	r2, r3, lr, ror #28
     4a4:	6f620070 	svcvs	0x00620070
     4a8:	42006c6f 	andmi	r6, r0, #28416	; 0x6f00
     4ac:	36395f52 	shsaxcc	r5, r9, r2
     4b0:	4c003030 	stcmi	0, cr3, [r0], {48}	; 0x30
     4b4:	5f6b636f 	svcpl	0x006b636f
     4b8:	6b636f4c 	blvs	18dc1f0 <__bss_end+0x18d3264>
     4bc:	66006465 	strvs	r6, [r0], -r5, ror #8
     4c0:	73747570 	cmnvc	r4, #112, 10	; 0x1c000000
     4c4:	72747300 	rsbsvc	r7, r4, #0, 6
     4c8:	00676e69 	rsbeq	r6, r7, r9, ror #28
     4cc:	69466f4e 	stmdbvs	r6, {r1, r2, r3, r6, r8, r9, sl, fp, sp, lr}^
     4d0:	7973656c 	ldmdbvc	r3!, {r2, r3, r5, r6, r8, sl, sp, lr}^
     4d4:	6d657473 	cfstrdvs	mvd7, [r5, #-460]!	; 0xfffffe34
     4d8:	76697244 	strbtvc	r7, [r9], -r4, asr #4
     4dc:	6c007265 	sfmvs	f7, 4, [r0], {101}	; 0x65
     4e0:	5f747361 	svcpl	0x00747361
     4e4:	6b636974 	blvs	18daabc <__bss_end+0x18d1b30>
     4e8:	78614d00 	stmdavc	r1!, {r8, sl, fp, lr}^
     4ec:	656c6946 	strbvs	r6, [ip, #-2374]!	; 0xfffff6ba
     4f0:	656d616e 	strbvs	r6, [sp, #-366]!	; 0xfffffe92
     4f4:	676e654c 	strbvs	r6, [lr, -ip, asr #10]!
     4f8:	62006874 	andvs	r6, r0, #116, 16	; 0x740000
     4fc:	5f647561 	svcpl	0x00647561
     500:	65746172 	ldrbvs	r6, [r4, #-370]!	; 0xfffffe8e
     504:	5f524200 	svcpl	0x00524200
     508:	30303834 	eorscc	r3, r0, r4, lsr r8
     50c:	736e7500 	cmnvc	lr, #0, 10
     510:	656e6769 	strbvs	r6, [lr, #-1897]!	; 0xfffff897
     514:	68632064 	stmdavs	r3!, {r2, r5, r6, sp}^
     518:	44007261 	strmi	r7, [r0], #-609	; 0xfffffd9f
     51c:	6c646165 	stfvse	f6, [r4], #-404	; 0xfffffe6c
     520:	5f656e69 	svcpl	0x00656e69
     524:	68636e55 	stmdavs	r3!, {r0, r2, r4, r6, r9, sl, fp, sp, lr}^
     528:	65676e61 	strbvs	r6, [r7, #-3681]!	; 0xfffff19f
     52c:	6f6c0064 	svcvs	0x006c0064
     530:	7520676e 	strvc	r6, [r0, #-1902]!	; 0xfffff892
     534:	6769736e 	strbvs	r7, [r9, -lr, ror #6]!
     538:	2064656e 	rsbcs	r6, r4, lr, ror #10
     53c:	00746e69 	rsbseq	r6, r4, r9, ror #28
     540:	74726175 	ldrbtvc	r6, [r2], #-373	; 0xfffffe8b
     544:	6c69665f 	stclvs	6, cr6, [r9], #-380	; 0xfffffe84
     548:	68730065 	ldmdavs	r3!, {r0, r2, r5, r6}^
     54c:	2074726f 	rsbscs	r7, r4, pc, ror #4
     550:	69736e75 	ldmdbvs	r3!, {r0, r2, r4, r5, r6, r9, sl, fp, sp, lr}^
     554:	64656e67 	strbtvs	r6, [r5], #-3687	; 0xfffff199
     558:	746e6920 	strbtvc	r6, [lr], #-2336	; 0xfffff6e0
     55c:	746f4e00 	strbtvc	r4, [pc], #-3584	; 564 <shift+0x564>
     560:	41796669 	cmnmi	r9, r9, ror #12
     564:	43006c6c 	movwmi	r6, #3180	; 0xc6c
     568:	5f726168 	svcpl	0x00726168
     56c:	68430037 	stmdavs	r3, {r0, r1, r2, r4, r5}^
     570:	385f7261 	ldmdacc	pc, {r0, r5, r6, r9, ip, sp, lr}^	; <UNPREDICTABLE>
     574:	5f524200 	svcpl	0x00524200
     578:	30343833 	eorscc	r3, r4, r3, lsr r8
     57c:	65470030 	strbvs	r0, [r7, #-48]	; 0xffffffd0
     580:	61505f74 	cmpvs	r0, r4, ror pc
     584:	736d6172 	cmnvc	sp, #-2147483620	; 0x8000001c
     588:	69725700 	ldmdbvs	r2!, {r8, r9, sl, ip, lr}^
     58c:	4f5f6574 	svcmi	0x005f6574
     590:	00796c6e 	rsbseq	r6, r9, lr, ror #24
     594:	315f5242 	cmpcc	pc, r2, asr #4
     598:	30303239 	eorscc	r3, r0, r9, lsr r2
     59c:	78614d00 	stmdavc	r1!, {r8, sl, fp, lr}^
     5a0:	6f72505f 	svcvs	0x0072505f
     5a4:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     5a8:	65704f5f 	ldrbvs	r4, [r0, #-3935]!	; 0xfffff0a1
     5ac:	5f64656e 	svcpl	0x0064656e
     5b0:	656c6946 	strbvs	r6, [ip, #-2374]!	; 0xfffff6ba
     5b4:	52420073 	subpl	r0, r2, #115	; 0x73
     5b8:	3034325f 	eorscc	r3, r4, pc, asr r2
     5bc:	65520030 	ldrbvs	r0, [r2, #-48]	; 0xffffffd0
     5c0:	575f6461 	ldrbpl	r6, [pc, -r1, ror #8]
     5c4:	65746972 	ldrbvs	r6, [r4, #-2418]!	; 0xfffff68e
     5c8:	766e4900 	strbtvc	r4, [lr], -r0, lsl #18
     5cc:	64696c61 	strbtvs	r6, [r9], #-3169	; 0xfffff39f
     5d0:	6e61485f 	mcrvs	8, 3, r4, cr1, cr15, {2}
     5d4:	00656c64 	rsbeq	r6, r5, r4, ror #24
     5d8:	6e69616d 	powvsez	f6, f1, #5.0
     5dc:	646e4900 	strbtvs	r4, [lr], #-2304	; 0xfffff700
     5e0:	6e696665 	cdpvs	6, 6, cr6, cr9, cr5, {3}
     5e4:	00657469 	rsbeq	r7, r5, r9, ror #8
     5e8:	315f5242 	cmpcc	pc, r2, asr #4
     5ec:	00303032 	eorseq	r3, r0, r2, lsr r0
     5f0:	72616863 	rsbvc	r6, r1, #6488064	; 0x630000
     5f4:	6e656c5f 	mcrvs	12, 3, r6, cr5, cr15, {2}
     5f8:	00687467 	rsbeq	r7, r8, r7, ror #8
     5fc:	64616552 	strbtvs	r6, [r1], #-1362	; 0xfffffaae
     600:	6c6e4f5f 	stclvs	15, cr4, [lr], #-380	; 0xfffffe84
     604:	6f4c0079 	svcvs	0x004c0079
     608:	555f6b63 	ldrbpl	r6, [pc, #-2915]	; fffffaad <__bss_end+0xffff6b21>
     60c:	636f6c6e 	cmnvs	pc, #28160	; 0x6e00
     610:	0064656b 	rsbeq	r6, r4, fp, ror #10
     614:	61736944 	cmnvs	r3, r4, asr #18
     618:	5f656c62 	svcpl	0x00656c62
     61c:	6e657645 	cdpvs	6, 6, cr7, cr5, cr5, {2}
     620:	65445f74 	strbvs	r5, [r4, #-3956]	; 0xfffff08c
     624:	74636574 	strbtvc	r6, [r3], #-1396	; 0xfffffa8c
     628:	006e6f69 	rsbeq	r6, lr, r9, ror #30
     62c:	5078614d 	rsbspl	r6, r8, sp, asr #2
     630:	4c687461 	cfstrdmi	mvd7, [r8], #-388	; 0xfffffe7c
     634:	74676e65 	strbtvc	r6, [r7], #-3685	; 0xfffff19b
     638:	72610068 	rsbvc	r0, r1, #104	; 0x68
     63c:	42006367 	andmi	r6, r0, #-1677721599	; 0x9c000001
     640:	37355f52 			; <UNDEFINED> instruction: 0x37355f52
     644:	00303036 	eorseq	r3, r0, r6, lsr r0
     648:	5f746553 	svcpl	0x00746553
     64c:	61726150 	cmnvs	r2, r0, asr r1
     650:	7300736d 	movwvc	r7, #877	; 0x36d
     654:	74726f68 	ldrbtvc	r6, [r2], #-3944	; 0xfffff098
     658:	746e6920 	strbtvc	r6, [lr], #-2336	; 0xfffff6e0
     65c:	67726100 	ldrbvs	r6, [r2, -r0, lsl #2]!
     660:	61700076 	cmnvs	r0, r6, ror r0
     664:	736d6172 	cmnvc	sp, #-2147483620	; 0x8000001c
     668:	4f494e00 	svcmi	0x00494e00
     66c:	5f6c7443 	svcpl	0x006c7443
     670:	7265704f 	rsbvc	r7, r5, #79	; 0x4f
     674:	6f697461 	svcvs	0x00697461
     678:	6975006e 	ldmdbvs	r5!, {r1, r2, r3, r5, r6}^
     67c:	3233746e 	eorscc	r7, r3, #1845493760	; 0x6e000000
     680:	6c00745f 	cfstrsvs	mvf7, [r0], {95}	; 0x5f
     684:	6970676f 	ldmdbvs	r0!, {r0, r1, r2, r3, r5, r6, r8, r9, sl, sp, lr}^
     688:	54006570 	strpl	r6, [r0], #-1392	; 0xfffffa90
     68c:	54524155 	ldrbpl	r4, [r2], #-341	; 0xfffffeab
     690:	434f495f 	movtmi	r4, #63839	; 0xf95f
     694:	505f6c74 	subspl	r6, pc, r4, ror ip	; <UNPREDICTABLE>
     698:	6d617261 	sfmvs	f7, 2, [r1, #-388]!	; 0xfffffe7c
     69c:	69740073 	ldmdbvs	r4!, {r0, r1, r4, r5, r6}^
     6a0:	75626b63 	strbvc	r6, [r2, #-2915]!	; 0xfffff49d
     6a4:	69540066 	ldmdbvs	r4, {r1, r2, r5, r6}^
     6a8:	435f6b63 	cmpmi	pc, #101376	; 0x18c00
     6ac:	746e756f 	strbtvc	r7, [lr], #-1391	; 0xfffffa91
     6b0:	73552f00 	cmpvc	r5, #0, 30
     6b4:	2f737265 	svccs	0x00737265
     6b8:	746e6977 	strbtvc	r6, [lr], #-2423	; 0xfffff689
     6bc:	696a7265 	stmdbvs	sl!, {r0, r2, r5, r6, r9, ip, sp, lr}^
     6c0:	7365442f 	cmnvc	r5, #788529152	; 0x2f000000
     6c4:	706f746b 	rsbvc	r7, pc, fp, ror #8
     6c8:	5641462f 	strbpl	r4, [r1], -pc, lsr #12
     6cc:	76614e2f 	strbtvc	r4, [r1], -pc, lsr #28
     6d0:	6a757a61 	bvs	1d5f05c <__bss_end+0x1d560d0>
     6d4:	2f696369 	svccs	0x00696369
     6d8:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
     6dc:	73656d65 	cmnvc	r5, #6464	; 0x1940
     6e0:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
     6e4:	6b2d616b 	blvs	b58c98 <__bss_end+0xb4fd0c>
     6e8:	6f2d7669 	svcvs	0x002d7669
     6ec:	6f732f73 	svcvs	0x00732f73
     6f0:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
     6f4:	75622f73 	strbvc	r2, [r2, #-3955]!	; 0xfffff08d
     6f8:	00646c69 	rsbeq	r6, r4, r9, ror #24
     6fc:	6e65704f 	cdpvs	0, 6, cr7, cr5, cr15, {2}
     700:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     704:	50433631 	subpl	r3, r3, r1, lsr r6
     708:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     70c:	4d5f7373 	ldclmi	3, cr7, [pc, #-460]	; 548 <shift+0x548>
     710:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
     714:	31327265 	teqcc	r2, r5, ror #4
     718:	636f6c42 	cmnvs	pc, #16896	; 0x4200
     71c:	75435f6b 	strbvc	r5, [r3, #-3947]	; 0xfffff095
     720:	6e657272 	mcrvs	2, 3, r7, cr5, cr2, {3}
     724:	72505f74 	subsvc	r5, r0, #116, 30	; 0x1d0
     728:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     72c:	00764573 	rsbseq	r4, r6, r3, ror r5
     730:	736f6c63 	cmnvc	pc, #25344	; 0x6300
     734:	72700065 	rsbsvc	r0, r0, #101	; 0x65
     738:	53007665 	movwpl	r7, #1637	; 0x665
     73c:	525f7465 	subspl	r7, pc, #1694498816	; 0x65000000
     740:	74616c65 	strbtvc	r6, [r1], #-3173	; 0xfffff39b
     744:	00657669 	rsbeq	r7, r5, r9, ror #12
     748:	616d6e55 	cmnvs	sp, r5, asr lr
     74c:	69465f70 	stmdbvs	r6, {r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     750:	435f656c 	cmpmi	pc, #108, 10	; 0x1b000000
     754:	65727275 	ldrbvs	r7, [r2, #-629]!	; 0xfffffd8b
     758:	7200746e 	andvc	r7, r0, #1845493760	; 0x6e000000
     75c:	61767465 	cmnvs	r6, r5, ror #8
     760:	636e006c 	cmnvs	lr, #108	; 0x6c
     764:	6d007275 	sfmvs	f7, 4, [r0, #-468]	; 0xfffffe2c
     768:	636f7250 	cmnvs	pc, #80, 4
     76c:	5f737365 	svcpl	0x00737365
     770:	7473694c 	ldrbtvc	r6, [r3], #-2380	; 0xfffff6b4
     774:	6165485f 	cmnvs	r5, pc, asr r8
     778:	5a5f0064 	bpl	17c0910 <__bss_end+0x17b7984>
     77c:	36314b4e 	ldrtcc	r4, [r1], -lr, asr #22
     780:	6f725043 	svcvs	0x00725043
     784:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     788:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     78c:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     790:	65473931 	strbvs	r3, [r7, #-2353]	; 0xfffff6cf
     794:	75435f74 	strbvc	r5, [r3, #-3956]	; 0xfffff08c
     798:	6e657272 	mcrvs	2, 3, r7, cr5, cr2, {3}
     79c:	72505f74 	subsvc	r5, r0, #116, 30	; 0x1d0
     7a0:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     7a4:	00764573 	rsbseq	r4, r6, r3, ror r5
     7a8:	756e6472 	strbvc	r6, [lr, #-1138]!	; 0xfffffb8e
     7ac:	656e006d 	strbvs	r0, [lr, #-109]!	; 0xffffff93
     7b0:	47007478 	smlsdxmi	r0, r8, r4, r7
     7b4:	505f7465 	subspl	r7, pc, r5, ror #8
     7b8:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     7bc:	425f7373 	subsmi	r7, pc, #-872415231	; 0xcc000001
     7c0:	49505f79 	ldmdbmi	r0, {r0, r3, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     7c4:	5a5f0044 	bpl	17c08dc <__bss_end+0x17b7950>
     7c8:	63733131 	cmnvs	r3, #1073741836	; 0x4000000c
     7cc:	5f646568 	svcpl	0x00646568
     7d0:	6c656979 			; <UNDEFINED> instruction: 0x6c656979
     7d4:	4e007664 	cfmadd32mi	mvax3, mvfx7, mvfx0, mvfx4
     7d8:	5f495753 	svcpl	0x00495753
     7dc:	636f7250 	cmnvs	pc, #80, 4
     7e0:	5f737365 	svcpl	0x00737365
     7e4:	76726553 			; <UNDEFINED> instruction: 0x76726553
     7e8:	00656369 	rsbeq	r6, r5, r9, ror #6
     7ec:	64616552 	strbtvs	r6, [r1], #-1362	; 0xfffffaae
     7f0:	74634100 	strbtvc	r4, [r3], #-256	; 0xffffff00
     7f4:	5f657669 	svcpl	0x00657669
     7f8:	636f7250 	cmnvs	pc, #80, 4
     7fc:	5f737365 	svcpl	0x00737365
     800:	6e756f43 	cdpvs	15, 7, cr6, cr5, cr3, {2}
     804:	72430074 	subvc	r0, r3, #116	; 0x74
     808:	65746165 	ldrbvs	r6, [r4, #-357]!	; 0xfffffe9b
     80c:	6f72505f 	svcvs	0x0072505f
     810:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     814:	315a5f00 	cmpcc	sl, r0, lsl #30
     818:	74657337 	strbtvc	r7, [r5], #-823	; 0xfffffcc9
     81c:	7361745f 	cmnvc	r1, #1593835520	; 0x5f000000
     820:	65645f6b 	strbvs	r5, [r4, #-3947]!	; 0xfffff095
     824:	696c6461 	stmdbvs	ip!, {r0, r5, r6, sl, sp, lr}^
     828:	006a656e 	rsbeq	r6, sl, lr, ror #10
     82c:	74696177 	strbtvc	r6, [r9], #-375	; 0xfffffe89
     830:	61747300 	cmnvs	r4, r0, lsl #6
     834:	5f006574 	svcpl	0x00006574
     838:	6f6e365a 	svcvs	0x006e365a
     83c:	79666974 	stmdbvc	r6!, {r2, r4, r5, r6, r8, fp, sp, lr}^
     840:	47006a6a 	strmi	r6, [r0, -sl, ror #20]
     844:	535f7465 	cmppl	pc, #1694498816	; 0x65000000
     848:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     84c:	72656c75 	rsbvc	r6, r5, #29952	; 0x7500
     850:	666e495f 			; <UNDEFINED> instruction: 0x666e495f
     854:	5043006f 	subpl	r0, r3, pc, rrx
     858:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     85c:	4d5f7373 	ldclmi	3, cr7, [pc, #-460]	; 698 <shift+0x698>
     860:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
     864:	5f007265 	svcpl	0x00007265
     868:	36314e5a 			; <UNDEFINED> instruction: 0x36314e5a
     86c:	6f725043 	svcvs	0x00725043
     870:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     874:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     878:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     87c:	65473831 	strbvs	r3, [r7, #-2097]	; 0xfffff7cf
     880:	63535f74 	cmpvs	r3, #116, 30	; 0x1d0
     884:	75646568 	strbvc	r6, [r4, #-1384]!	; 0xfffffa98
     888:	5f72656c 	svcpl	0x0072656c
     88c:	6f666e49 	svcvs	0x00666e49
     890:	4e303245 	cdpmi	2, 3, cr3, cr0, cr5, {2}
     894:	5f746547 	svcpl	0x00746547
     898:	65686353 	strbvs	r6, [r8, #-851]!	; 0xfffffcad
     89c:	6e495f64 	cdpvs	15, 4, cr5, cr9, cr4, {3}
     8a0:	545f6f66 	ldrbpl	r6, [pc], #-3942	; 8a8 <shift+0x8a8>
     8a4:	50657079 	rsbpl	r7, r5, r9, ror r0
     8a8:	5a5f0076 	bpl	17c0a88 <__bss_end+0x17b7afc>
     8ac:	4336314e 	teqmi	r6, #-2147483629	; 0x80000013
     8b0:	636f7250 	cmnvs	pc, #80, 4
     8b4:	5f737365 	svcpl	0x00737365
     8b8:	616e614d 	cmnvs	lr, sp, asr #2
     8bc:	32726567 	rsbscc	r6, r2, #432013312	; 0x19c00000
     8c0:	6e614831 	mcrvs	8, 3, r4, cr1, cr1, {1}
     8c4:	5f656c64 	svcpl	0x00656c64
     8c8:	656c6946 	strbvs	r6, [ip, #-2374]!	; 0xfffff6ba
     8cc:	74737973 	ldrbtvc	r7, [r3], #-2419	; 0xfffff68d
     8d0:	535f6d65 	cmppl	pc, #6464	; 0x1940
     8d4:	32454957 	subcc	r4, r5, #1425408	; 0x15c000
     8d8:	57534e33 	smmlarpl	r3, r3, lr, r4
     8dc:	69465f49 	stmdbvs	r6, {r0, r3, r6, r8, r9, sl, fp, ip, lr}^
     8e0:	7973656c 	ldmdbvc	r3!, {r2, r3, r5, r6, r8, sl, sp, lr}^
     8e4:	6d657473 	cfstrdvs	mvd7, [r5, #-460]!	; 0xfffffe34
     8e8:	7265535f 	rsbvc	r5, r5, #2080374785	; 0x7c000001
     8ec:	65636976 	strbvs	r6, [r3, #-2422]!	; 0xfffff68a
     8f0:	526a6a6a 	rsbpl	r6, sl, #434176	; 0x6a000
     8f4:	53543131 	cmppl	r4, #1073741836	; 0x4000000c
     8f8:	525f4957 	subspl	r4, pc, #1425408	; 0x15c000
     8fc:	6c757365 	ldclvs	3, cr7, [r5], #-404	; 0xfffffe6c
     900:	706f0074 	rsbvc	r0, pc, r4, ror r0	; <UNPREDICTABLE>
     904:	64656e65 	strbtvs	r6, [r5], #-3685	; 0xfffff19b
     908:	6c69665f 	stclvs	6, cr6, [r9], #-380	; 0xfffffe84
     90c:	46007365 	strmi	r7, [r0], -r5, ror #6
     910:	006c6961 	rsbeq	r6, ip, r1, ror #18
     914:	55504354 	ldrbpl	r4, [r0, #-852]	; 0xfffffcac
     918:	6e6f435f 	mcrvs	3, 3, r4, cr15, cr15, {2}
     91c:	74786574 	ldrbtvc	r6, [r8], #-1396	; 0xfffffa8c
     920:	61654400 	cmnvs	r5, r0, lsl #8
     924:	6e696c64 	cdpvs	12, 6, cr6, cr9, cr4, {3}
     928:	78650065 	stmdavc	r5!, {r0, r2, r5, r6}^
     92c:	6f637469 	svcvs	0x00637469
     930:	74006564 	strvc	r6, [r0], #-1380	; 0xfffffa9c
     934:	30726274 	rsbscc	r6, r2, r4, ror r2
     938:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     93c:	50433631 	subpl	r3, r3, r1, lsr r6
     940:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     944:	4d5f7373 	ldclmi	3, cr7, [pc, #-460]	; 780 <shift+0x780>
     948:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
     94c:	34317265 	ldrtcc	r7, [r1], #-613	; 0xfffffd9b
     950:	69746f4e 	ldmdbvs	r4!, {r1, r2, r3, r6, r8, r9, sl, fp, sp, lr}^
     954:	505f7966 	subspl	r7, pc, r6, ror #18
     958:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     95c:	6a457373 	bvs	115d730 <__bss_end+0x11547a4>
     960:	74654700 	strbtvc	r4, [r5], #-1792	; 0xfffff900
     964:	4449505f 	strbmi	r5, [r9], #-95	; 0xffffffa1
     968:	746f6e00 	strbtvc	r6, [pc], #-3584	; 970 <shift+0x970>
     96c:	65696669 	strbvs	r6, [r9, #-1641]!	; 0xfffff997
     970:	65645f64 	strbvs	r5, [r4, #-3940]!	; 0xfffff09c
     974:	696c6461 	stmdbvs	ip!, {r0, r5, r6, sl, sp, lr}^
     978:	5f00656e 	svcpl	0x0000656e
     97c:	36314e5a 			; <UNDEFINED> instruction: 0x36314e5a
     980:	6f725043 	svcvs	0x00725043
     984:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     988:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     98c:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     990:	6e553831 	mrcvs	8, 2, r3, cr5, cr1, {1}
     994:	5f70616d 	svcpl	0x0070616d
     998:	656c6946 	strbvs	r6, [ip, #-2374]!	; 0xfffff6ba
     99c:	7275435f 	rsbsvc	r4, r5, #2080374785	; 0x7c000001
     9a0:	746e6572 	strbtvc	r6, [lr], #-1394	; 0xfffffa8e
     9a4:	5f006a45 	svcpl	0x00006a45
     9a8:	36314e5a 			; <UNDEFINED> instruction: 0x36314e5a
     9ac:	6f725043 	svcvs	0x00725043
     9b0:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     9b4:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     9b8:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     9bc:	6f4e3431 	svcvs	0x004e3431
     9c0:	79666974 	stmdbvc	r6!, {r2, r4, r5, r6, r8, fp, sp, lr}^
     9c4:	6f72505f 	svcvs	0x0072505f
     9c8:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     9cc:	32315045 	eorscc	r5, r1, #69	; 0x45
     9d0:	73615454 	cmnvc	r1, #84, 8	; 0x54000000
     9d4:	74535f6b 	ldrbvc	r5, [r3], #-3947	; 0xfffff095
     9d8:	74637572 	strbtvc	r7, [r3], #-1394	; 0xfffffa8e
     9dc:	68637300 	stmdavs	r3!, {r8, r9, ip, sp, lr}^
     9e0:	795f6465 	ldmdbvc	pc, {r0, r2, r5, r6, sl, sp, lr}^	; <UNPREDICTABLE>
     9e4:	646c6569 	strbtvs	r6, [ip], #-1385	; 0xfffffa97
     9e8:	63697400 	cmnvs	r9, #0, 8
     9ec:	6f635f6b 	svcvs	0x00635f6b
     9f0:	5f746e75 	svcpl	0x00746e75
     9f4:	75716572 	ldrbvc	r6, [r1, #-1394]!	; 0xfffffa8e
     9f8:	64657269 	strbtvs	r7, [r5], #-617	; 0xfffffd97
     9fc:	325a5f00 	subscc	r5, sl, #0, 30
     a00:	74656734 	strbtvc	r6, [r5], #-1844	; 0xfffff8cc
     a04:	7463615f 	strbtvc	r6, [r3], #-351	; 0xfffffea1
     a08:	5f657669 	svcpl	0x00657669
     a0c:	636f7270 	cmnvs	pc, #112, 4
     a10:	5f737365 	svcpl	0x00737365
     a14:	6e756f63 	cdpvs	15, 7, cr6, cr5, cr3, {3}
     a18:	47007674 	smlsdxmi	r0, r4, r6, r7
     a1c:	435f7465 	cmpmi	pc, #1694498816	; 0x65000000
     a20:	65727275 	ldrbvs	r7, [r2, #-629]!	; 0xfffffd8b
     a24:	505f746e 	subspl	r7, pc, lr, ror #8
     a28:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     a2c:	50007373 	andpl	r7, r0, r3, ror r3
     a30:	5f657069 	svcpl	0x00657069
     a34:	656c6946 	strbvs	r6, [ip, #-2374]!	; 0xfffff6ba
     a38:	6572505f 	ldrbvs	r5, [r2, #-95]!	; 0xffffffa1
     a3c:	00786966 	rsbseq	r6, r8, r6, ror #18
     a40:	5f70614d 	svcpl	0x0070614d
     a44:	656c6946 	strbvs	r6, [ip, #-2374]!	; 0xfffff6ba
     a48:	5f6f545f 	svcpl	0x006f545f
     a4c:	72727543 	rsbsvc	r7, r2, #281018368	; 0x10c00000
     a50:	00746e65 	rsbseq	r6, r4, r5, ror #28
     a54:	34315a5f 	ldrtcc	r5, [r1], #-2655	; 0xfffff5a1
     a58:	5f746567 	svcpl	0x00746567
     a5c:	6b636974 	blvs	18db034 <__bss_end+0x18d20a8>
     a60:	756f635f 	strbvc	r6, [pc, #-863]!	; 709 <shift+0x709>
     a64:	0076746e 	rsbseq	r7, r6, lr, ror #8
     a68:	646e6148 	strbtvs	r6, [lr], #-328	; 0xfffffeb8
     a6c:	505f656c 	subspl	r6, pc, ip, ror #10
     a70:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     a74:	535f7373 	cmppl	pc, #-872415231	; 0xcc000001
     a78:	73004957 	movwvc	r4, #2391	; 0x957
     a7c:	7065656c 	rsbvc	r6, r5, ip, ror #10
     a80:	68635300 	stmdavs	r3!, {r8, r9, ip, lr}^
     a84:	6c756465 	cfldrdvs	mvd6, [r5], #-404	; 0xfffffe6c
     a88:	44455f65 	strbmi	r5, [r5], #-3941	; 0xfffff09b
     a8c:	61570046 	cmpvs	r7, r6, asr #32
     a90:	5f007469 	svcpl	0x00007469
     a94:	6574395a 	ldrbvs	r3, [r4, #-2394]!	; 0xfffff6a6
     a98:	6e696d72 	mcrvs	13, 3, r6, cr9, cr2, {3}
     a9c:	69657461 	stmdbvs	r5!, {r0, r5, r6, sl, ip, sp, lr}^
     aa0:	746e4900 	strbtvc	r4, [lr], #-2304	; 0xfffff700
     aa4:	75727265 	ldrbvc	r7, [r2, #-613]!	; 0xfffffd9b
     aa8:	62617470 	rsbvs	r7, r1, #112, 8	; 0x70000000
     aac:	535f656c 	cmppl	pc, #108, 10	; 0x1b000000
     ab0:	7065656c 	rsbvc	r6, r5, ip, ror #10
     ab4:	65706f00 	ldrbvs	r6, [r0, #-3840]!	; 0xfffff100
     ab8:	69746172 	ldmdbvs	r4!, {r1, r4, r5, r6, r8, sp, lr}^
     abc:	5f006e6f 	svcpl	0x00006e6f
     ac0:	6c63355a 	cfstr64vs	mvdx3, [r3], #-360	; 0xfffffe98
     ac4:	6a65736f 	bvs	195d888 <__bss_end+0x19548fc>
     ac8:	614c6d00 	cmpvs	ip, r0, lsl #26
     acc:	505f7473 	subspl	r7, pc, r3, ror r4	; <UNPREDICTABLE>
     ad0:	42004449 	andmi	r4, r0, #1224736768	; 0x49000000
     ad4:	6b636f6c 	blvs	18dc88c <__bss_end+0x18d3900>
     ad8:	4e006465 	cdpmi	4, 0, cr6, cr0, cr5, {3}
     adc:	5f746547 	svcpl	0x00746547
     ae0:	65686353 	strbvs	r6, [r8, #-851]!	; 0xfffffcad
     ae4:	6e495f64 	cdpvs	15, 4, cr5, cr9, cr4, {3}
     ae8:	545f6f66 	ldrbpl	r6, [pc], #-3942	; af0 <shift+0xaf0>
     aec:	00657079 	rsbeq	r7, r5, r9, ror r0
     af0:	67365a5f 			; <UNDEFINED> instruction: 0x67365a5f
     af4:	69707465 	ldmdbvs	r0!, {r0, r2, r5, r6, sl, ip, sp, lr}^
     af8:	66007664 	strvs	r7, [r0], -r4, ror #12
     afc:	656d616e 	strbvs	r6, [sp, #-366]!	; 0xfffffe92
     b00:	6e755200 	cdpvs	2, 7, cr5, cr5, cr0, {0}
     b04:	6c62616e 	stfvse	f6, [r2], #-440	; 0xfffffe48
     b08:	544e0065 	strbpl	r0, [lr], #-101	; 0xffffff9b
     b0c:	5f6b7361 	svcpl	0x006b7361
     b10:	74617453 	strbtvc	r7, [r1], #-1107	; 0xfffffbad
     b14:	63730065 	cmnvs	r3, #101	; 0x65
     b18:	5f646568 	svcpl	0x00646568
     b1c:	6e756f63 	cdpvs	15, 7, cr6, cr5, cr3, {3}
     b20:	00726574 	rsbseq	r6, r2, r4, ror r5
     b24:	65686373 	strbvs	r6, [r8, #-883]!	; 0xfffffc8d
     b28:	74735f64 	ldrbtvc	r5, [r3], #-3940	; 0xfffff09c
     b2c:	63697461 	cmnvs	r9, #1627389952	; 0x61000000
     b30:	6972705f 	ldmdbvs	r2!, {r0, r1, r2, r3, r4, r6, ip, sp, lr}^
     b34:	7469726f 	strbtvc	r7, [r9], #-623	; 0xfffffd91
     b38:	72770079 	rsbsvc	r0, r7, #121	; 0x79
     b3c:	00657469 	rsbeq	r7, r5, r9, ror #8
     b40:	74697865 	strbtvc	r7, [r9], #-2149	; 0xfffff79b
     b44:	646f635f 	strbtvs	r6, [pc], #-863	; b4c <shift+0xb4c>
     b48:	69740065 	ldmdbvs	r4!, {r0, r2, r5, r6}^
     b4c:	00736b63 	rsbseq	r6, r3, r3, ror #22
     b50:	6863536d 	stmdavs	r3!, {r0, r2, r3, r5, r6, r8, r9, ip, lr}^
     b54:	6c756465 	cfldrdvs	mvd6, [r5], #-404	; 0xfffffe6c
     b58:	6e465f65 	cdpvs	15, 4, cr5, cr6, cr5, {3}
     b5c:	706f0063 	rsbvc	r0, pc, r3, rrx
     b60:	5f006e65 	svcpl	0x00006e65
     b64:	6970345a 	ldmdbvs	r0!, {r1, r3, r4, r6, sl, ip, sp}^
     b68:	4b506570 	blmi	141a130 <__bss_end+0x14111a4>
     b6c:	4e006a63 	vmlsmi.f32	s12, s0, s7
     b70:	64616544 	strbtvs	r6, [r1], #-1348	; 0xfffffabc
     b74:	656e696c 	strbvs	r6, [lr, #-2412]!	; 0xfffff694
     b78:	6275535f 	rsbsvs	r5, r5, #2080374785	; 0x7c000001
     b7c:	76726573 			; <UNDEFINED> instruction: 0x76726573
     b80:	00656369 	rsbeq	r6, r5, r9, ror #6
     b84:	5f746567 	svcpl	0x00746567
     b88:	6b636974 	blvs	18db160 <__bss_end+0x18d21d4>
     b8c:	756f635f 	strbvc	r6, [pc, #-863]!	; 835 <shift+0x835>
     b90:	4e00746e 	cdpmi	4, 0, cr7, cr0, cr14, {3}
     b94:	6669746f 	strbtvs	r7, [r9], -pc, ror #8
     b98:	61700079 	cmnvs	r0, r9, ror r0
     b9c:	006d6172 	rsbeq	r6, sp, r2, ror r1
     ba0:	77355a5f 			; <UNDEFINED> instruction: 0x77355a5f
     ba4:	65746972 	ldrbvs	r6, [r4, #-2418]!	; 0xfffff68e
     ba8:	634b506a 	movtvs	r5, #45162	; 0xb06a
     bac:	6567006a 	strbvs	r0, [r7, #-106]!	; 0xffffff96
     bb0:	61745f74 	cmnvs	r4, r4, ror pc
     bb4:	745f6b73 	ldrbvc	r6, [pc], #-2931	; bbc <shift+0xbbc>
     bb8:	736b6369 	cmnvc	fp, #-1543503871	; 0xa4000001
     bbc:	5f6f745f 	svcpl	0x006f745f
     bc0:	64616564 	strbtvs	r6, [r1], #-1380	; 0xfffffa9c
     bc4:	656e696c 	strbvs	r6, [lr, #-2412]!	; 0xfffff694
     bc8:	66756200 	ldrbtvs	r6, [r5], -r0, lsl #4
     bcc:	7a69735f 	bvc	1a5d950 <__bss_end+0x1a549c4>
     bd0:	6f5a0065 	svcvs	0x005a0065
     bd4:	6569626d 	strbvs	r6, [r9, #-621]!	; 0xfffffd93
     bd8:	74654700 	strbtvc	r4, [r5], #-1792	; 0xfffff900
     bdc:	6863535f 	stmdavs	r3!, {r0, r1, r2, r3, r4, r6, r8, r9, ip, lr}^
     be0:	495f6465 	ldmdbmi	pc, {r0, r2, r5, r6, sl, sp, lr}^	; <UNPREDICTABLE>
     be4:	006f666e 	rsbeq	r6, pc, lr, ror #12
     be8:	5f746573 	svcpl	0x00746573
     bec:	6b736174 	blvs	1cd91c4 <__bss_end+0x1cd0238>
     bf0:	6165645f 	cmnvs	r5, pc, asr r4
     bf4:	6e696c64 	cdpvs	12, 6, cr6, cr9, cr4, {3}
     bf8:	5a5f0065 	bpl	17c0d94 <__bss_end+0x17b7e08>
     bfc:	4336314e 	teqmi	r6, #-2147483629	; 0x80000013
     c00:	636f7250 	cmnvs	pc, #80, 4
     c04:	5f737365 	svcpl	0x00737365
     c08:	616e614d 	cmnvs	lr, sp, asr #2
     c0c:	38726567 	ldmdacc	r2!, {r0, r1, r2, r5, r6, r8, sl, sp, lr}^
     c10:	65686353 	strbvs	r6, [r8, #-851]!	; 0xfffffcad
     c14:	656c7564 	strbvs	r7, [ip, #-1380]!	; 0xfffffa9c
     c18:	5f007645 	svcpl	0x00007645
     c1c:	36314e5a 			; <UNDEFINED> instruction: 0x36314e5a
     c20:	6f725043 	svcvs	0x00725043
     c24:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     c28:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     c2c:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     c30:	614d3931 	cmpvs	sp, r1, lsr r9
     c34:	69465f70 	stmdbvs	r6, {r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     c38:	545f656c 	ldrbpl	r6, [pc], #-1388	; c40 <shift+0xc40>
     c3c:	75435f6f 	strbvc	r5, [r3, #-3951]	; 0xfffff091
     c40:	6e657272 	mcrvs	2, 3, r7, cr5, cr2, {3}
     c44:	35504574 	ldrbcc	r4, [r0, #-1396]	; 0xfffffa8c
     c48:	6c694649 	stclvs	6, cr4, [r9], #-292	; 0xfffffedc
     c4c:	552f0065 	strpl	r0, [pc, #-101]!	; bef <shift+0xbef>
     c50:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
     c54:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
     c58:	6a726574 	bvs	1c9a230 <__bss_end+0x1c912a4>
     c5c:	65442f69 	strbvs	r2, [r4, #-3945]	; 0xfffff097
     c60:	6f746b73 	svcvs	0x00746b73
     c64:	41462f70 	hvcmi	25328	; 0x62f0
     c68:	614e2f56 	cmpvs	lr, r6, asr pc
     c6c:	757a6176 	ldrbvc	r6, [sl, #-374]!	; 0xfffffe8a
     c70:	6963696a 	stmdbvs	r3!, {r1, r3, r5, r6, r8, fp, sp, lr}^
     c74:	2f534f2f 	svccs	0x00534f2f
     c78:	656d6573 	strbvs	r6, [sp, #-1395]!	; 0xfffffa8d
     c7c:	61727473 	cmnvs	r2, r3, ror r4
     c80:	2d616b6c 	vstmdbcs	r1!, {d22-<overflow reg d75>}
     c84:	2d76696b 			; <UNDEFINED> instruction: 0x2d76696b
     c88:	732f736f 			; <UNDEFINED> instruction: 0x732f736f
     c8c:	6372756f 	cmnvs	r2, #465567744	; 0x1bc00000
     c90:	732f7365 			; <UNDEFINED> instruction: 0x732f7365
     c94:	696c6474 	stmdbvs	ip!, {r2, r4, r5, r6, sl, sp, lr}^
     c98:	72732f62 	rsbsvc	r2, r3, #392	; 0x188
     c9c:	74732f63 	ldrbtvc	r2, [r3], #-3939	; 0xfffff09d
     ca0:	6c696664 	stclvs	6, cr6, [r9], #-400	; 0xfffffe70
     ca4:	70632e65 	rsbvc	r2, r3, r5, ror #28
     ca8:	5a5f0070 	bpl	17c0e70 <__bss_end+0x17b7ee4>
     cac:	4336314e 	teqmi	r6, #-2147483629	; 0x80000013
     cb0:	636f7250 	cmnvs	pc, #80, 4
     cb4:	5f737365 	svcpl	0x00737365
     cb8:	616e614d 	cmnvs	lr, sp, asr #2
     cbc:	31726567 	cmncc	r2, r7, ror #10
     cc0:	68635332 	stmdavs	r3!, {r1, r4, r5, r8, r9, ip, lr}^
     cc4:	6c756465 	cfldrdvs	mvd6, [r5], #-404	; 0xfffffe6c
     cc8:	44455f65 	strbmi	r5, [r5], #-3941	; 0xfffff09b
     ccc:	00764546 	rsbseq	r4, r6, r6, asr #10
     cd0:	73355a5f 	teqvc	r5, #389120	; 0x5f000
     cd4:	7065656c 	rsbvc	r6, r5, ip, ror #10
     cd8:	47006a6a 	strmi	r6, [r0, -sl, ror #20]
     cdc:	525f7465 	subspl	r7, pc, #1694498816	; 0x65000000
     ce0:	69616d65 	stmdbvs	r1!, {r0, r2, r5, r6, r8, sl, fp, sp, lr}^
     ce4:	676e696e 	strbvs	r6, [lr, -lr, ror #18]!
     ce8:	325a5f00 	subscc	r5, sl, #0, 30
     cec:	74656736 	strbtvc	r6, [r5], #-1846	; 0xfffff8ca
     cf0:	7361745f 	cmnvc	r1, #1593835520	; 0x5f000000
     cf4:	69745f6b 	ldmdbvs	r4!, {r0, r1, r3, r5, r6, r8, r9, sl, fp, ip, lr}^
     cf8:	5f736b63 	svcpl	0x00736b63
     cfc:	645f6f74 	ldrbvs	r6, [pc], #-3956	; d04 <shift+0xd04>
     d00:	6c646165 	stfvse	f6, [r4], #-404	; 0xfffffe6c
     d04:	76656e69 	strbtvc	r6, [r5], -r9, ror #28
     d08:	57534e00 	ldrbpl	r4, [r3, -r0, lsl #28]
     d0c:	65525f49 	ldrbvs	r5, [r2, #-3913]	; 0xfffff0b7
     d10:	746c7573 	strbtvc	r7, [ip], #-1395	; 0xfffffa8d
     d14:	646f435f 	strbtvs	r4, [pc], #-863	; d1c <shift+0xd1c>
     d18:	75520065 	ldrbvc	r0, [r2, #-101]	; 0xffffff9b
     d1c:	6e696e6e 	cdpvs	14, 6, cr6, cr9, cr14, {3}
     d20:	72770067 	rsbsvc	r0, r7, #103	; 0x67
     d24:	006d756e 	rsbeq	r7, sp, lr, ror #10
     d28:	77345a5f 			; <UNDEFINED> instruction: 0x77345a5f
     d2c:	6a746961 	bvs	1d1b2b8 <__bss_end+0x1d1232c>
     d30:	5f006a6a 	svcpl	0x00006a6a
     d34:	6f69355a 	svcvs	0x0069355a
     d38:	6a6c7463 	bvs	1b1decc <__bss_end+0x1b14f40>
     d3c:	494e3631 	stmdbmi	lr, {r0, r4, r5, r9, sl, ip, sp}^
     d40:	6c74434f 	ldclvs	3, cr4, [r4], #-316	; 0xfffffec4
     d44:	65704f5f 	ldrbvs	r4, [r0, #-3935]!	; 0xfffff0a1
     d48:	69746172 	ldmdbvs	r4!, {r1, r4, r5, r6, r8, sp, lr}^
     d4c:	76506e6f 	ldrbvc	r6, [r0], -pc, ror #28
     d50:	636f6900 	cmnvs	pc, #0, 18
     d54:	72006c74 	andvc	r6, r0, #116, 24	; 0x7400
     d58:	6e637465 	cdpvs	4, 6, cr7, cr3, cr5, {3}
     d5c:	436d0074 	cmnmi	sp, #116	; 0x74
     d60:	65727275 	ldrbvs	r7, [r2, #-629]!	; 0xfffffd8b
     d64:	545f746e 	ldrbpl	r7, [pc], #-1134	; d6c <shift+0xd6c>
     d68:	5f6b7361 	svcpl	0x006b7361
     d6c:	65646f4e 	strbvs	r6, [r4, #-3918]!	; 0xfffff0b2
     d70:	746f6e00 	strbtvc	r6, [pc], #-3584	; d78 <shift+0xd78>
     d74:	00796669 	rsbseq	r6, r9, r9, ror #12
     d78:	6d726574 	cfldr64vs	mvdx6, [r2, #-464]!	; 0xfffffe30
     d7c:	74616e69 	strbtvc	r6, [r1], #-3689	; 0xfffff197
     d80:	6f6d0065 	svcvs	0x006d0065
     d84:	63006564 	movwvs	r6, #1380	; 0x564
     d88:	635f7570 	cmpvs	pc, #112, 10	; 0x1c000000
     d8c:	65746e6f 	ldrbvs	r6, [r4, #-3695]!	; 0xfffff191
     d90:	62007478 	andvs	r7, r0, #120, 8	; 0x78000000
     d94:	65666675 	strbvs	r6, [r6, #-1653]!	; 0xfffff98b
     d98:	6c730072 	ldclvs	0, cr0, [r3], #-456	; 0xfffffe38
     d9c:	5f706565 	svcpl	0x00706565
     da0:	656d6974 	strbvs	r6, [sp, #-2420]!	; 0xfffff68c
     da4:	5a5f0072 	bpl	17c0f74 <__bss_end+0x17b7fe8>
     da8:	36314b4e 	ldrtcc	r4, [r1], -lr, asr #22
     dac:	6f725043 	svcvs	0x00725043
     db0:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     db4:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     db8:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     dbc:	65473831 	strbvs	r3, [r7, #-2097]	; 0xfffff7cf
     dc0:	72505f74 	subsvc	r5, r0, #116, 30	; 0x1d0
     dc4:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     dc8:	79425f73 	stmdbvc	r2, {r0, r1, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     dcc:	4449505f 	strbmi	r5, [r9], #-95	; 0xffffffa1
     dd0:	48006a45 	stmdami	r0, {r0, r2, r6, r9, fp, sp, lr}
     dd4:	6c646e61 	stclvs	14, cr6, [r4], #-388	; 0xfffffe7c
     dd8:	69465f65 	stmdbvs	r6, {r0, r2, r5, r6, r8, r9, sl, fp, ip, lr}^
     ddc:	7973656c 	ldmdbvc	r3!, {r2, r3, r5, r6, r8, sl, sp, lr}^
     de0:	6d657473 	cfstrdvs	mvd7, [r5, #-460]!	; 0xfffffe34
     de4:	4957535f 	ldmdbmi	r7, {r0, r1, r2, r3, r4, r6, r8, r9, ip, lr}^
     de8:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     dec:	50433631 	subpl	r3, r3, r1, lsr r6
     df0:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     df4:	4d5f7373 	ldclmi	3, cr7, [pc, #-460]	; c30 <shift+0xc30>
     df8:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
     dfc:	31317265 	teqcc	r1, r5, ror #4
     e00:	65686353 	strbvs	r6, [r8, #-851]!	; 0xfffffcad
     e04:	656c7564 	strbvs	r7, [ip, #-1380]!	; 0xfffffa9c
     e08:	4552525f 	ldrbmi	r5, [r2, #-607]	; 0xfffffda1
     e0c:	61740076 	cmnvs	r4, r6, ror r0
     e10:	5f006b73 	svcpl	0x00006b73
     e14:	6572345a 	ldrbvs	r3, [r2, #-1114]!	; 0xfffffba6
     e18:	506a6461 	rsbpl	r6, sl, r1, ror #8
     e1c:	4e006a63 	vmlsmi.f32	s12, s0, s7
     e20:	6669746f 	strbtvs	r7, [r9], -pc, ror #8
     e24:	72505f79 	subsvc	r5, r0, #484	; 0x1e4
     e28:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     e2c:	63530073 	cmpvs	r3, #115	; 0x73
     e30:	75646568 	strbvc	r6, [r4, #-1384]!	; 0xfffffa98
     e34:	4700656c 	strmi	r6, [r0, -ip, ror #10]
     e38:	4320554e 			; <UNDEFINED> instruction: 0x4320554e
     e3c:	34312b2b 	ldrtcc	r2, [r1], #-2859	; 0xfffff4d5
     e40:	2e303120 	rsfcssp	f3, f0, f0
     e44:	20312e33 	eorscs	r2, r1, r3, lsr lr
     e48:	31323032 	teqcc	r2, r2, lsr r0
     e4c:	34323830 	ldrtcc	r3, [r2], #-2096	; 0xfffff7d0
     e50:	65722820 	ldrbvs	r2, [r2, #-2080]!	; 0xfffff7e0
     e54:	7361656c 	cmnvc	r1, #108, 10	; 0x1b000000
     e58:	2d202965 			; <UNDEFINED> instruction: 0x2d202965
     e5c:	6f6c666d 	svcvs	0x006c666d
     e60:	612d7461 			; <UNDEFINED> instruction: 0x612d7461
     e64:	683d6962 	ldmdavs	sp!, {r1, r5, r6, r8, fp, sp, lr}
     e68:	20647261 	rsbcs	r7, r4, r1, ror #4
     e6c:	70666d2d 	rsbvc	r6, r6, sp, lsr #26
     e70:	66763d75 			; <UNDEFINED> instruction: 0x66763d75
     e74:	6d2d2070 	stcvs	0, cr2, [sp, #-448]!	; 0xfffffe40
     e78:	616f6c66 	cmnvs	pc, r6, ror #24
     e7c:	62612d74 	rsbvs	r2, r1, #116, 26	; 0x1d00
     e80:	61683d69 	cmnvs	r8, r9, ror #26
     e84:	2d206472 	cfstrscs	mvf6, [r0, #-456]!	; 0xfffffe38
     e88:	7570666d 	ldrbvc	r6, [r0, #-1645]!	; 0xfffff993
     e8c:	7066763d 	rsbvc	r7, r6, sp, lsr r6
     e90:	746d2d20 	strbtvc	r2, [sp], #-3360	; 0xfffff2e0
     e94:	3d656e75 	stclcc	14, cr6, [r5, #-468]!	; 0xfffffe2c
     e98:	316d7261 	cmncc	sp, r1, ror #4
     e9c:	6a363731 	bvs	d8eb68 <__bss_end+0xd85bdc>
     ea0:	732d667a 			; <UNDEFINED> instruction: 0x732d667a
     ea4:	616d2d20 	cmnvs	sp, r0, lsr #26
     ea8:	2d206d72 	stccs	13, cr6, [r0, #-456]!	; 0xfffffe38
     eac:	6372616d 	cmnvs	r2, #1073741851	; 0x4000001b
     eb0:	72613d68 	rsbvc	r3, r1, #104, 26	; 0x1a00
     eb4:	7a36766d 	bvc	d9e870 <__bss_end+0xd958e4>
     eb8:	70662b6b 	rsbvc	r2, r6, fp, ror #22
     ebc:	20672d20 	rsbcs	r2, r7, r0, lsr #26
     ec0:	2d20672d 	stccs	7, cr6, [r0, #-180]!	; 0xffffff4c
     ec4:	4f2d2067 	svcmi	0x002d2067
     ec8:	4f2d2030 	svcmi	0x002d2030
     ecc:	662d2030 			; <UNDEFINED> instruction: 0x662d2030
     ed0:	652d6f6e 	strvs	r6, [sp, #-3950]!	; 0xfffff092
     ed4:	70656378 	rsbvc	r6, r5, r8, ror r3
     ed8:	6e6f6974 			; <UNDEFINED> instruction: 0x6e6f6974
     edc:	662d2073 			; <UNDEFINED> instruction: 0x662d2073
     ee0:	722d6f6e 	eorvc	r6, sp, #440	; 0x1b8
     ee4:	00697474 	rsbeq	r7, r9, r4, ror r4
     ee8:	314e5a5f 	cmpcc	lr, pc, asr sl
     eec:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     ef0:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     ef4:	614d5f73 	hvcvs	54771	; 0xd5f3
     ef8:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     efc:	77533972 			; <UNDEFINED> instruction: 0x77533972
     f00:	68637469 	stmdavs	r3!, {r0, r3, r5, r6, sl, ip, sp, lr}^
     f04:	456f545f 	strbmi	r5, [pc, #-1119]!	; aad <shift+0xaad>
     f08:	43383150 	teqmi	r8, #80, 2
     f0c:	636f7250 	cmnvs	pc, #80, 4
     f10:	5f737365 	svcpl	0x00737365
     f14:	7473694c 	ldrbtvc	r6, [r3], #-2380	; 0xfffff6b4
     f18:	646f4e5f 	strbtvs	r4, [pc], #-3679	; f20 <shift+0xf20>
     f1c:	63530065 	cmpvs	r3, #101	; 0x65
     f20:	75646568 	strbvc	r6, [r4, #-1384]!	; 0xfffffa98
     f24:	525f656c 	subspl	r6, pc, #108, 10	; 0x1b000000
     f28:	5a5f0052 	bpl	17c1078 <__bss_end+0x17b80ec>
     f2c:	4336314e 	teqmi	r6, #-2147483629	; 0x80000013
     f30:	636f7250 	cmnvs	pc, #80, 4
     f34:	5f737365 	svcpl	0x00737365
     f38:	616e614d 	cmnvs	lr, sp, asr #2
     f3c:	31726567 	cmncc	r2, r7, ror #10
     f40:	6e614838 	mcrvs	8, 3, r4, cr1, cr8, {1}
     f44:	5f656c64 	svcpl	0x00656c64
     f48:	636f7250 	cmnvs	pc, #80, 4
     f4c:	5f737365 	svcpl	0x00737365
     f50:	45495753 	strbmi	r5, [r9, #-1875]	; 0xfffff8ad
     f54:	534e3032 	movtpl	r3, #57394	; 0xe032
     f58:	505f4957 	subspl	r4, pc, r7, asr r9	; <UNPREDICTABLE>
     f5c:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     f60:	535f7373 	cmppl	pc, #-872415231	; 0xcc000001
     f64:	69767265 	ldmdbvs	r6!, {r0, r2, r5, r6, r9, ip, sp, lr}^
     f68:	6a6a6563 	bvs	1a9a4fc <__bss_end+0x1a91570>
     f6c:	3131526a 	teqcc	r1, sl, ror #4
     f70:	49575354 	ldmdbmi	r7, {r2, r4, r6, r8, r9, ip, lr}^
     f74:	7365525f 	cmnvc	r5, #-268435451	; 0xf0000005
     f78:	00746c75 	rsbseq	r6, r4, r5, ror ip
     f7c:	314e5a5f 	cmpcc	lr, pc, asr sl
     f80:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     f84:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     f88:	614d5f73 	hvcvs	54771	; 0xd5f3
     f8c:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     f90:	43343172 	teqmi	r4, #-2147483620	; 0x8000001c
     f94:	74616572 	strbtvc	r6, [r1], #-1394	; 0xfffffa8e
     f98:	72505f65 	subsvc	r5, r0, #404	; 0x194
     f9c:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     fa0:	68504573 	ldmdavs	r0, {r0, r1, r4, r5, r6, r8, sl, lr}^
     fa4:	5300626a 	movwpl	r6, #618	; 0x26a
     fa8:	63746977 	cmnvs	r4, #1949696	; 0x1dc000
     fac:	6f545f68 	svcvs	0x00545f68
     fb0:	57534e00 	ldrbpl	r4, [r3, -r0, lsl #28]
     fb4:	69465f49 	stmdbvs	r6, {r0, r3, r6, r8, r9, sl, fp, ip, lr}^
     fb8:	7973656c 	ldmdbvc	r3!, {r2, r3, r5, r6, r8, sl, sp, lr}^
     fbc:	6d657473 	cfstrdvs	mvd7, [r5, #-460]!	; 0xfffffe34
     fc0:	7265535f 	rsbvc	r5, r5, #2080374785	; 0x7c000001
     fc4:	65636976 	strbvs	r6, [r3, #-2422]!	; 0xfffff68a
     fc8:	74657200 	strbtvc	r7, [r5], #-512	; 0xfffffe00
     fcc:	65646f63 	strbvs	r6, [r4, #-3939]!	; 0xfffff09d
     fd0:	74656700 	strbtvc	r6, [r5], #-1792	; 0xfffff900
     fd4:	7463615f 	strbtvc	r6, [r3], #-351	; 0xfffffea1
     fd8:	5f657669 	svcpl	0x00657669
     fdc:	636f7270 	cmnvs	pc, #112, 4
     fe0:	5f737365 	svcpl	0x00737365
     fe4:	6e756f63 	cdpvs	15, 7, cr6, cr5, cr3, {3}
     fe8:	69660074 	stmdbvs	r6!, {r2, r4, r5, r6}^
     fec:	616e656c 	cmnvs	lr, ip, ror #10
     ff0:	4200656d 	andmi	r6, r0, #457179136	; 0x1b400000
     ff4:	6b636f6c 	blvs	18dcdac <__bss_end+0x18d3e20>
     ff8:	7275435f 	rsbsvc	r4, r5, #2080374785	; 0x7c000001
     ffc:	746e6572 	strbtvc	r6, [lr], #-1394	; 0xfffffa8e
    1000:	6f72505f 	svcvs	0x0072505f
    1004:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
    1008:	61657200 	cmnvs	r5, r0, lsl #4
    100c:	6c430064 	mcrrvs	0, 6, r0, r3, cr4
    1010:	0065736f 	rsbeq	r7, r5, pc, ror #6
    1014:	70746567 	rsbsvc	r6, r4, r7, ror #10
    1018:	5f006469 	svcpl	0x00006469
    101c:	706f345a 	rsbvc	r3, pc, sl, asr r4	; <UNPREDICTABLE>
    1020:	4b506e65 	blmi	141c9bc <__bss_end+0x1413a30>
    1024:	4e353163 	rsfmisz	f3, f5, f3
    1028:	656c6946 	strbvs	r6, [ip, #-2374]!	; 0xfffff6ba
    102c:	65704f5f 	ldrbvs	r4, [r0, #-3935]!	; 0xfffff0a1
    1030:	6f4d5f6e 	svcvs	0x004d5f6e
    1034:	59006564 	stmdbpl	r0, {r2, r5, r6, r8, sl, sp, lr}
    1038:	646c6569 	strbtvs	r6, [ip], #-1385	; 0xfffffa97
    103c:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
    1040:	50433631 	subpl	r3, r3, r1, lsr r6
    1044:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
    1048:	4d5f7373 	ldclmi	3, cr7, [pc, #-460]	; e84 <shift+0xe84>
    104c:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
    1050:	34437265 	strbcc	r7, [r3], #-613	; 0xfffffd9b
    1054:	54007645 	strpl	r7, [r0], #-1605	; 0xfffff9bb
    1058:	696d7265 	stmdbvs	sp!, {r0, r2, r5, r6, r9, ip, sp, lr}^
    105c:	6574616e 	ldrbvs	r6, [r4, #-366]!	; 0xfffffe92
    1060:	434f4900 	movtmi	r4, #63744	; 0xf900
    1064:	69006c74 	stmdbvs	r0, {r2, r4, r5, r6, sl, fp, sp, lr}
    1068:	7475706e 	ldrbtvc	r7, [r5], #-110	; 0xffffff92
    106c:	73656400 	cmnvc	r5, #0, 8
    1070:	7a620074 	bvc	1881248 <__bss_end+0x18782bc>
    1074:	006f7265 	rsbeq	r7, pc, r5, ror #4
    1078:	62355a5f 	eorsvs	r5, r5, #389120	; 0x5f000
    107c:	6f72657a 	svcvs	0x0072657a
    1080:	00697650 	rsbeq	r7, r9, r0, asr r6
    1084:	6573552f 	ldrbvs	r5, [r3, #-1327]!	; 0xfffffad1
    1088:	772f7372 			; <UNDEFINED> instruction: 0x772f7372
    108c:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
    1090:	2f696a72 	svccs	0x00696a72
    1094:	6b736544 	blvs	1cda5ac <__bss_end+0x1cd1620>
    1098:	2f706f74 	svccs	0x00706f74
    109c:	2f564146 	svccs	0x00564146
    10a0:	6176614e 	cmnvs	r6, lr, asr #2
    10a4:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
    10a8:	4f2f6963 	svcmi	0x002f6963
    10ac:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
    10b0:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
    10b4:	6b6c6172 	blvs	1b19684 <__bss_end+0x1b106f8>
    10b8:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
    10bc:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
    10c0:	756f732f 	strbvc	r7, [pc, #-815]!	; d99 <shift+0xd99>
    10c4:	73656372 	cmnvc	r5, #-939524095	; 0xc8000001
    10c8:	6474732f 	ldrbtvs	r7, [r4], #-815	; 0xfffffcd1
    10cc:	2f62696c 	svccs	0x0062696c
    10d0:	2f637273 	svccs	0x00637273
    10d4:	73647473 	cmnvc	r4, #1929379840	; 0x73000000
    10d8:	6e697274 	mcrvs	2, 3, r7, cr9, cr4, {3}
    10dc:	70632e67 	rsbvc	r2, r3, r7, ror #28
    10e0:	5a5f0070 	bpl	17c12a8 <__bss_end+0x17b831c>
    10e4:	6f746134 	svcvs	0x00746134
    10e8:	634b5069 	movtvs	r5, #45161	; 0xb069
    10ec:	61684300 	cmnvs	r8, r0, lsl #6
    10f0:	6e6f4372 	mcrvs	3, 3, r4, cr15, cr2, {3}
    10f4:	72724176 	rsbsvc	r4, r2, #-2147483619	; 0x8000001d
    10f8:	6d656d00 	stclvs	13, cr6, [r5, #-0]
    10fc:	00747364 	rsbseq	r7, r4, r4, ror #6
    1100:	7074756f 	rsbsvc	r7, r4, pc, ror #10
    1104:	5f007475 	svcpl	0x00007475
    1108:	656d365a 	strbvs	r3, [sp, #-1626]!	; 0xfffff9a6
    110c:	7970636d 	ldmdbvc	r0!, {r0, r2, r3, r5, r6, r8, r9, sp, lr}^
    1110:	50764b50 	rsbspl	r4, r6, r0, asr fp
    1114:	62006976 	andvs	r6, r0, #1933312	; 0x1d8000
    1118:	00657361 	rsbeq	r7, r5, r1, ror #6
    111c:	636d656d 	cmnvs	sp, #457179136	; 0x1b400000
    1120:	73007970 	movwvc	r7, #2416	; 0x970
    1124:	656c7274 	strbvs	r7, [ip, #-628]!	; 0xfffffd8c
    1128:	5a5f006e 	bpl	17c12e8 <__bss_end+0x17b835c>
    112c:	72747337 	rsbsvc	r7, r4, #-603979776	; 0xdc000000
    1130:	706d636e 	rsbvc	r6, sp, lr, ror #6
    1134:	53634b50 	cmnpl	r3, #80, 22	; 0x14000
    1138:	00695f30 	rsbeq	r5, r9, r0, lsr pc
    113c:	73365a5f 	teqvc	r6, #389120	; 0x5f000
    1140:	656c7274 	strbvs	r7, [ip, #-628]!	; 0xfffffd8c
    1144:	634b506e 	movtvs	r5, #45166	; 0xb06e
    1148:	6f746100 	svcvs	0x00746100
    114c:	5a5f0069 	bpl	17c12f8 <__bss_end+0x17b836c>
    1150:	72747337 	rsbsvc	r7, r4, #-603979776	; 0xdc000000
    1154:	7970636e 	ldmdbvc	r0!, {r1, r2, r3, r5, r6, r8, r9, sp, lr}^
    1158:	4b506350 	blmi	1419ea0 <__bss_end+0x1410f14>
    115c:	73006963 	movwvc	r6, #2403	; 0x963
    1160:	636e7274 	cmnvs	lr, #116, 4	; 0x40000007
    1164:	7300706d 	movwvc	r7, #109	; 0x6d
    1168:	636e7274 	cmnvs	lr, #116, 4	; 0x40000007
    116c:	6d007970 	vstrvs.16	s14, [r0, #-224]	; 0xffffff20	; <UNPREDICTABLE>
    1170:	726f6d65 	rsbvc	r6, pc, #6464	; 0x1940
    1174:	656d0079 	strbvs	r0, [sp, #-121]!	; 0xffffff87
    1178:	6372736d 	cmnvs	r2, #-1275068415	; 0xb4000001
    117c:	6f746900 	svcvs	0x00746900
    1180:	5a5f0061 	bpl	17c130c <__bss_end+0x17b8380>
    1184:	6f746934 	svcvs	0x00746934
    1188:	63506a61 	cmpvs	r0, #397312	; 0x61000
    118c:	Address 0x000000000000118c is out of bounds.


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
  20:	8b040e42 	blhi	103930 <__bss_end+0xfa9a4>
  24:	0b0d4201 	bleq	350830 <__bss_end+0x3478a4>
  28:	420d0d62 	andmi	r0, sp, #6272	; 0x1880
  2c:	00000ecb 	andeq	r0, r0, fp, asr #29
  30:	0000001c 	andeq	r0, r0, ip, lsl r0
  34:	00000000 	andeq	r0, r0, r0
  38:	00008064 	andeq	r8, r0, r4, rrx
  3c:	00000040 	andeq	r0, r0, r0, asr #32
  40:	8b080e42 	blhi	203950 <__bss_end+0x1fa9c4>
  44:	42018e02 	andmi	r8, r1, #2, 28
  48:	5a040b0c 	bpl	102c80 <__bss_end+0xf9cf4>
  4c:	00080d0c 	andeq	r0, r8, ip, lsl #26
  50:	0000000c 	andeq	r0, r0, ip
  54:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
  58:	7c020001 	stcvc	0, cr0, [r2], {1}
  5c:	000d0c0e 	andeq	r0, sp, lr, lsl #24
  60:	0000001c 	andeq	r0, r0, ip, lsl r0
  64:	00000050 	andeq	r0, r0, r0, asr r0
  68:	000080a4 	andeq	r8, r0, r4, lsr #1
  6c:	00000038 	andeq	r0, r0, r8, lsr r0
  70:	8b040e42 	blhi	103980 <__bss_end+0xfa9f4>
  74:	0b0d4201 	bleq	350880 <__bss_end+0x3478f4>
  78:	420d0d54 	andmi	r0, sp, #84, 26	; 0x1500
  7c:	00000ecb 	andeq	r0, r0, fp, asr #29
  80:	0000001c 	andeq	r0, r0, ip, lsl r0
  84:	00000050 	andeq	r0, r0, r0, asr r0
  88:	000080dc 	ldrdeq	r8, [r0], -ip
  8c:	0000002c 	andeq	r0, r0, ip, lsr #32
  90:	8b040e42 	blhi	1039a0 <__bss_end+0xfaa14>
  94:	0b0d4201 	bleq	3508a0 <__bss_end+0x347914>
  98:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
  9c:	00000ecb 	andeq	r0, r0, fp, asr #29
  a0:	0000001c 	andeq	r0, r0, ip, lsl r0
  a4:	00000050 	andeq	r0, r0, r0, asr r0
  a8:	00008108 	andeq	r8, r0, r8, lsl #2
  ac:	00000020 	andeq	r0, r0, r0, lsr #32
  b0:	8b040e42 	blhi	1039c0 <__bss_end+0xfaa34>
  b4:	0b0d4201 	bleq	3508c0 <__bss_end+0x347934>
  b8:	420d0d48 	andmi	r0, sp, #72, 26	; 0x1200
  bc:	00000ecb 	andeq	r0, r0, fp, asr #29
  c0:	0000001c 	andeq	r0, r0, ip, lsl r0
  c4:	00000050 	andeq	r0, r0, r0, asr r0
  c8:	00008128 	andeq	r8, r0, r8, lsr #2
  cc:	00000018 	andeq	r0, r0, r8, lsl r0
  d0:	8b040e42 	blhi	1039e0 <__bss_end+0xfaa54>
  d4:	0b0d4201 	bleq	3508e0 <__bss_end+0x347954>
  d8:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
  dc:	00000ecb 	andeq	r0, r0, fp, asr #29
  e0:	0000001c 	andeq	r0, r0, ip, lsl r0
  e4:	00000050 	andeq	r0, r0, r0, asr r0
  e8:	00008140 	andeq	r8, r0, r0, asr #2
  ec:	00000018 	andeq	r0, r0, r8, lsl r0
  f0:	8b040e42 	blhi	103a00 <__bss_end+0xfaa74>
  f4:	0b0d4201 	bleq	350900 <__bss_end+0x347974>
  f8:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
  fc:	00000ecb 	andeq	r0, r0, fp, asr #29
 100:	0000001c 	andeq	r0, r0, ip, lsl r0
 104:	00000050 	andeq	r0, r0, r0, asr r0
 108:	00008158 	andeq	r8, r0, r8, asr r1
 10c:	00000018 	andeq	r0, r0, r8, lsl r0
 110:	8b040e42 	blhi	103a20 <__bss_end+0xfaa94>
 114:	0b0d4201 	bleq	350920 <__bss_end+0x347994>
 118:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
 11c:	00000ecb 	andeq	r0, r0, fp, asr #29
 120:	00000014 	andeq	r0, r0, r4, lsl r0
 124:	00000050 	andeq	r0, r0, r0, asr r0
 128:	00008170 	andeq	r8, r0, r0, ror r1
 12c:	0000000c 	andeq	r0, r0, ip
 130:	8b040e42 	blhi	103a40 <__bss_end+0xfaab4>
 134:	0b0d4201 	bleq	350940 <__bss_end+0x3479b4>
 138:	0000001c 	andeq	r0, r0, ip, lsl r0
 13c:	00000050 	andeq	r0, r0, r0, asr r0
 140:	0000817c 	andeq	r8, r0, ip, ror r1
 144:	00000058 	andeq	r0, r0, r8, asr r0
 148:	8b080e42 	blhi	203a58 <__bss_end+0x1faacc>
 14c:	42018e02 	andmi	r8, r1, #2, 28
 150:	62040b0c 	andvs	r0, r4, #12, 22	; 0x3000
 154:	00080d0c 	andeq	r0, r8, ip, lsl #26
 158:	0000001c 	andeq	r0, r0, ip, lsl r0
 15c:	00000050 	andeq	r0, r0, r0, asr r0
 160:	000081d4 	ldrdeq	r8, [r0], -r4
 164:	00000058 	andeq	r0, r0, r8, asr r0
 168:	8b080e42 	blhi	203a78 <__bss_end+0x1faaec>
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
 198:	8b080e42 	blhi	203aa8 <__bss_end+0x1fab1c>
 19c:	42018e02 	andmi	r8, r1, #2, 28
 1a0:	58040b0c 	stmdapl	r4, {r2, r3, r8, r9, fp}
 1a4:	00080d0c 	andeq	r0, r8, ip, lsl #26
 1a8:	00000018 	andeq	r0, r0, r8, lsl r0
 1ac:	00000178 	andeq	r0, r0, r8, ror r1
 1b0:	00008268 	andeq	r8, r0, r8, ror #4
 1b4:	00000144 	andeq	r0, r0, r4, asr #2
 1b8:	8b080e42 	blhi	203ac8 <__bss_end+0x1fab3c>
 1bc:	42018e02 	andmi	r8, r1, #2, 28
 1c0:	00040b0c 	andeq	r0, r4, ip, lsl #22
 1c4:	0000000c 	andeq	r0, r0, ip
 1c8:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 1cc:	7c020001 	stcvc	0, cr0, [r2], {1}
 1d0:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 1d4:	0000001c 	andeq	r0, r0, ip, lsl r0
 1d8:	000001c4 	andeq	r0, r0, r4, asr #3
 1dc:	000083ac 	andeq	r8, r0, ip, lsr #7
 1e0:	0000002c 	andeq	r0, r0, ip, lsr #32
 1e4:	8b040e42 	blhi	103af4 <__bss_end+0xfab68>
 1e8:	0b0d4201 	bleq	3509f4 <__bss_end+0x347a68>
 1ec:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
 1f0:	00000ecb 	andeq	r0, r0, fp, asr #29
 1f4:	0000001c 	andeq	r0, r0, ip, lsl r0
 1f8:	000001c4 	andeq	r0, r0, r4, asr #3
 1fc:	000083d8 	ldrdeq	r8, [r0], -r8	; <UNPREDICTABLE>
 200:	0000002c 	andeq	r0, r0, ip, lsr #32
 204:	8b040e42 	blhi	103b14 <__bss_end+0xfab88>
 208:	0b0d4201 	bleq	350a14 <__bss_end+0x347a88>
 20c:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
 210:	00000ecb 	andeq	r0, r0, fp, asr #29
 214:	0000001c 	andeq	r0, r0, ip, lsl r0
 218:	000001c4 	andeq	r0, r0, r4, asr #3
 21c:	00008404 	andeq	r8, r0, r4, lsl #8
 220:	0000001c 	andeq	r0, r0, ip, lsl r0
 224:	8b040e42 	blhi	103b34 <__bss_end+0xfaba8>
 228:	0b0d4201 	bleq	350a34 <__bss_end+0x347aa8>
 22c:	420d0d46 	andmi	r0, sp, #4480	; 0x1180
 230:	00000ecb 	andeq	r0, r0, fp, asr #29
 234:	0000001c 	andeq	r0, r0, ip, lsl r0
 238:	000001c4 	andeq	r0, r0, r4, asr #3
 23c:	00008420 	andeq	r8, r0, r0, lsr #8
 240:	00000044 	andeq	r0, r0, r4, asr #32
 244:	8b040e42 	blhi	103b54 <__bss_end+0xfabc8>
 248:	0b0d4201 	bleq	350a54 <__bss_end+0x347ac8>
 24c:	420d0d5a 	andmi	r0, sp, #5760	; 0x1680
 250:	00000ecb 	andeq	r0, r0, fp, asr #29
 254:	0000001c 	andeq	r0, r0, ip, lsl r0
 258:	000001c4 	andeq	r0, r0, r4, asr #3
 25c:	00008464 	andeq	r8, r0, r4, ror #8
 260:	00000050 	andeq	r0, r0, r0, asr r0
 264:	8b040e42 	blhi	103b74 <__bss_end+0xfabe8>
 268:	0b0d4201 	bleq	350a74 <__bss_end+0x347ae8>
 26c:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 270:	00000ecb 	andeq	r0, r0, fp, asr #29
 274:	0000001c 	andeq	r0, r0, ip, lsl r0
 278:	000001c4 	andeq	r0, r0, r4, asr #3
 27c:	000084b4 			; <UNDEFINED> instruction: 0x000084b4
 280:	00000050 	andeq	r0, r0, r0, asr r0
 284:	8b040e42 	blhi	103b94 <__bss_end+0xfac08>
 288:	0b0d4201 	bleq	350a94 <__bss_end+0x347b08>
 28c:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 290:	00000ecb 	andeq	r0, r0, fp, asr #29
 294:	0000001c 	andeq	r0, r0, ip, lsl r0
 298:	000001c4 	andeq	r0, r0, r4, asr #3
 29c:	00008504 	andeq	r8, r0, r4, lsl #10
 2a0:	0000002c 	andeq	r0, r0, ip, lsr #32
 2a4:	8b040e42 	blhi	103bb4 <__bss_end+0xfac28>
 2a8:	0b0d4201 	bleq	350ab4 <__bss_end+0x347b28>
 2ac:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
 2b0:	00000ecb 	andeq	r0, r0, fp, asr #29
 2b4:	0000001c 	andeq	r0, r0, ip, lsl r0
 2b8:	000001c4 	andeq	r0, r0, r4, asr #3
 2bc:	00008530 	andeq	r8, r0, r0, lsr r5
 2c0:	00000050 	andeq	r0, r0, r0, asr r0
 2c4:	8b040e42 	blhi	103bd4 <__bss_end+0xfac48>
 2c8:	0b0d4201 	bleq	350ad4 <__bss_end+0x347b48>
 2cc:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 2d0:	00000ecb 	andeq	r0, r0, fp, asr #29
 2d4:	0000001c 	andeq	r0, r0, ip, lsl r0
 2d8:	000001c4 	andeq	r0, r0, r4, asr #3
 2dc:	00008580 	andeq	r8, r0, r0, lsl #11
 2e0:	00000044 	andeq	r0, r0, r4, asr #32
 2e4:	8b040e42 	blhi	103bf4 <__bss_end+0xfac68>
 2e8:	0b0d4201 	bleq	350af4 <__bss_end+0x347b68>
 2ec:	420d0d5a 	andmi	r0, sp, #5760	; 0x1680
 2f0:	00000ecb 	andeq	r0, r0, fp, asr #29
 2f4:	0000001c 	andeq	r0, r0, ip, lsl r0
 2f8:	000001c4 	andeq	r0, r0, r4, asr #3
 2fc:	000085c4 	andeq	r8, r0, r4, asr #11
 300:	00000050 	andeq	r0, r0, r0, asr r0
 304:	8b040e42 	blhi	103c14 <__bss_end+0xfac88>
 308:	0b0d4201 	bleq	350b14 <__bss_end+0x347b88>
 30c:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 310:	00000ecb 	andeq	r0, r0, fp, asr #29
 314:	0000001c 	andeq	r0, r0, ip, lsl r0
 318:	000001c4 	andeq	r0, r0, r4, asr #3
 31c:	00008614 	andeq	r8, r0, r4, lsl r6
 320:	00000054 	andeq	r0, r0, r4, asr r0
 324:	8b040e42 	blhi	103c34 <__bss_end+0xfaca8>
 328:	0b0d4201 	bleq	350b34 <__bss_end+0x347ba8>
 32c:	420d0d62 	andmi	r0, sp, #6272	; 0x1880
 330:	00000ecb 	andeq	r0, r0, fp, asr #29
 334:	0000001c 	andeq	r0, r0, ip, lsl r0
 338:	000001c4 	andeq	r0, r0, r4, asr #3
 33c:	00008668 	andeq	r8, r0, r8, ror #12
 340:	0000003c 	andeq	r0, r0, ip, lsr r0
 344:	8b040e42 	blhi	103c54 <__bss_end+0xfacc8>
 348:	0b0d4201 	bleq	350b54 <__bss_end+0x347bc8>
 34c:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 350:	00000ecb 	andeq	r0, r0, fp, asr #29
 354:	0000001c 	andeq	r0, r0, ip, lsl r0
 358:	000001c4 	andeq	r0, r0, r4, asr #3
 35c:	000086a4 	andeq	r8, r0, r4, lsr #13
 360:	0000003c 	andeq	r0, r0, ip, lsr r0
 364:	8b040e42 	blhi	103c74 <__bss_end+0xface8>
 368:	0b0d4201 	bleq	350b74 <__bss_end+0x347be8>
 36c:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 370:	00000ecb 	andeq	r0, r0, fp, asr #29
 374:	0000001c 	andeq	r0, r0, ip, lsl r0
 378:	000001c4 	andeq	r0, r0, r4, asr #3
 37c:	000086e0 	andeq	r8, r0, r0, ror #13
 380:	0000003c 	andeq	r0, r0, ip, lsr r0
 384:	8b040e42 	blhi	103c94 <__bss_end+0xfad08>
 388:	0b0d4201 	bleq	350b94 <__bss_end+0x347c08>
 38c:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 390:	00000ecb 	andeq	r0, r0, fp, asr #29
 394:	0000001c 	andeq	r0, r0, ip, lsl r0
 398:	000001c4 	andeq	r0, r0, r4, asr #3
 39c:	0000871c 	andeq	r8, r0, ip, lsl r7
 3a0:	0000003c 	andeq	r0, r0, ip, lsr r0
 3a4:	8b040e42 	blhi	103cb4 <__bss_end+0xfad28>
 3a8:	0b0d4201 	bleq	350bb4 <__bss_end+0x347c28>
 3ac:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 3b0:	00000ecb 	andeq	r0, r0, fp, asr #29
 3b4:	0000001c 	andeq	r0, r0, ip, lsl r0
 3b8:	000001c4 	andeq	r0, r0, r4, asr #3
 3bc:	00008758 	andeq	r8, r0, r8, asr r7
 3c0:	000000b0 	strheq	r0, [r0], -r0	; <UNPREDICTABLE>
 3c4:	8b080e42 	blhi	203cd4 <__bss_end+0x1fad48>
 3c8:	42018e02 	andmi	r8, r1, #2, 28
 3cc:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 3d0:	080d0c50 	stmdaeq	sp, {r4, r6, sl, fp}
 3d4:	0000000c 	andeq	r0, r0, ip
 3d8:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 3dc:	7c020001 	stcvc	0, cr0, [r2], {1}
 3e0:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 3e4:	0000001c 	andeq	r0, r0, ip, lsl r0
 3e8:	000003d4 	ldrdeq	r0, [r0], -r4
 3ec:	00008808 	andeq	r8, r0, r8, lsl #16
 3f0:	00000174 	andeq	r0, r0, r4, ror r1
 3f4:	8b080e42 	blhi	203d04 <__bss_end+0x1fad78>
 3f8:	42018e02 	andmi	r8, r1, #2, 28
 3fc:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 400:	080d0cb2 	stmdaeq	sp, {r1, r4, r5, r7, sl, fp}
 404:	0000001c 	andeq	r0, r0, ip, lsl r0
 408:	000003d4 	ldrdeq	r0, [r0], -r4
 40c:	0000897c 	andeq	r8, r0, ip, ror r9
 410:	0000009c 	muleq	r0, ip, r0
 414:	8b040e42 	blhi	103d24 <__bss_end+0xfad98>
 418:	0b0d4201 	bleq	350c24 <__bss_end+0x347c98>
 41c:	0d0d4602 	stceq	6, cr4, [sp, #-8]
 420:	000ecb42 	andeq	ip, lr, r2, asr #22
 424:	0000001c 	andeq	r0, r0, ip, lsl r0
 428:	000003d4 	ldrdeq	r0, [r0], -r4
 42c:	00008a18 	andeq	r8, r0, r8, lsl sl
 430:	000000c0 	andeq	r0, r0, r0, asr #1
 434:	8b040e42 	blhi	103d44 <__bss_end+0xfadb8>
 438:	0b0d4201 	bleq	350c44 <__bss_end+0x347cb8>
 43c:	0d0d5802 	stceq	8, cr5, [sp, #-8]
 440:	000ecb42 	andeq	ip, lr, r2, asr #22
 444:	0000001c 	andeq	r0, r0, ip, lsl r0
 448:	000003d4 	ldrdeq	r0, [r0], -r4
 44c:	00008ad8 	ldrdeq	r8, [r0], -r8	; <UNPREDICTABLE>
 450:	000000ac 	andeq	r0, r0, ip, lsr #1
 454:	8b040e42 	blhi	103d64 <__bss_end+0xfadd8>
 458:	0b0d4201 	bleq	350c64 <__bss_end+0x347cd8>
 45c:	0d0d4e02 	stceq	14, cr4, [sp, #-8]
 460:	000ecb42 	andeq	ip, lr, r2, asr #22
 464:	0000001c 	andeq	r0, r0, ip, lsl r0
 468:	000003d4 	ldrdeq	r0, [r0], -r4
 46c:	00008b84 	andeq	r8, r0, r4, lsl #23
 470:	00000054 	andeq	r0, r0, r4, asr r0
 474:	8b040e42 	blhi	103d84 <__bss_end+0xfadf8>
 478:	0b0d4201 	bleq	350c84 <__bss_end+0x347cf8>
 47c:	420d0d62 	andmi	r0, sp, #6272	; 0x1880
 480:	00000ecb 	andeq	r0, r0, fp, asr #29
 484:	0000001c 	andeq	r0, r0, ip, lsl r0
 488:	000003d4 	ldrdeq	r0, [r0], -r4
 48c:	00008bd8 	ldrdeq	r8, [r0], -r8	; <UNPREDICTABLE>
 490:	00000068 	andeq	r0, r0, r8, rrx
 494:	8b040e42 	blhi	103da4 <__bss_end+0xfae18>
 498:	0b0d4201 	bleq	350ca4 <__bss_end+0x347d18>
 49c:	420d0d6c 	andmi	r0, sp, #108, 26	; 0x1b00
 4a0:	00000ecb 	andeq	r0, r0, fp, asr #29
 4a4:	0000001c 	andeq	r0, r0, ip, lsl r0
 4a8:	000003d4 	ldrdeq	r0, [r0], -r4
 4ac:	00008c40 	andeq	r8, r0, r0, asr #24
 4b0:	00000080 	andeq	r0, r0, r0, lsl #1
 4b4:	8b040e42 	blhi	103dc4 <__bss_end+0xfae38>
 4b8:	0b0d4201 	bleq	350cc4 <__bss_end+0x347d38>
 4bc:	420d0d78 	andmi	r0, sp, #120, 26	; 0x1e00
 4c0:	00000ecb 	andeq	r0, r0, fp, asr #29
 4c4:	0000000c 	andeq	r0, r0, ip
 4c8:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 4cc:	7c010001 	stcvc	0, cr0, [r1], {1}
 4d0:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 4d4:	0000000c 	andeq	r0, r0, ip
 4d8:	000004c4 	andeq	r0, r0, r4, asr #9
 4dc:	00008cc0 	andeq	r8, r0, r0, asr #25
 4e0:	000001ec 	andeq	r0, r0, ip, ror #3
