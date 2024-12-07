
./tilt_task:     file format elf32-littlearm


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
    805c:	00008ef8 	strdeq	r8, [r0], -r8	; <UNPREDICTABLE>
    8060:	00008f08 	andeq	r8, r0, r8, lsl #30

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
    8080:	eb000069 	bl	822c <main>
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
    81cc:	00008ef5 	strdeq	r8, [r0], -r5
    81d0:	00008ef5 	strdeq	r8, [r0], -r5

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
    8224:	00008ef5 	strdeq	r8, [r0], -r5
    8228:	00008ef5 	strdeq	r8, [r0], -r5

0000822c <main>:
main():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/tilt_task/main.cpp:15
 * 
 * Ceka na vstup ze senzoru naklonu, a prehraje neco na buzzeru (PWM) dle naklonu
 **/

int main(int argc, char** argv)
{
    822c:	e92d4800 	push	{fp, lr}
    8230:	e28db004 	add	fp, sp, #4
    8234:	e24dd020 	sub	sp, sp, #32
    8238:	e50b0020 	str	r0, [fp, #-32]	; 0xffffffe0
    823c:	e50b1024 	str	r1, [fp, #-36]	; 0xffffffdc
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/tilt_task/main.cpp:16
	char state = '0';
    8240:	e3a03030 	mov	r3, #48	; 0x30
    8244:	e54b3011 	strb	r3, [fp, #-17]	; 0xffffffef
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/tilt_task/main.cpp:17
	char oldstate = '0';
    8248:	e3a03030 	mov	r3, #48	; 0x30
    824c:	e54b3005 	strb	r3, [fp, #-5]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/tilt_task/main.cpp:19

	uint32_t tiltsensor_file = open("DEV:gpio/23", NFile_Open_Mode::Read_Only);
    8250:	e3a01000 	mov	r1, #0
    8254:	e59f009c 	ldr	r0, [pc, #156]	; 82f8 <main+0xcc>
    8258:	eb000047 	bl	837c <_Z4openPKc15NFile_Open_Mode>
    825c:	e50b000c 	str	r0, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/tilt_task/main.cpp:27
	NGPIO_Interrupt_Type irtype;
	
	//irtype = NGPIO_Interrupt_Type::Rising_Edge;
	//ioctl(tiltsensor_file, NIOCtl_Operation::Enable_Event_Detection, &irtype);

	irtype = NGPIO_Interrupt_Type::Falling_Edge;
    8260:	e3a03001 	mov	r3, #1
    8264:	e50b3018 	str	r3, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/tilt_task/main.cpp:28
	ioctl(tiltsensor_file, NIOCtl_Operation::Enable_Event_Detection, &irtype);
    8268:	e24b3018 	sub	r3, fp, #24
    826c:	e1a02003 	mov	r2, r3
    8270:	e3a01002 	mov	r1, #2
    8274:	e51b000c 	ldr	r0, [fp, #-12]
    8278:	eb000083 	bl	848c <_Z5ioctlj16NIOCtl_OperationPv>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/tilt_task/main.cpp:30

	uint32_t logpipe = pipe("log", 32);
    827c:	e3a01020 	mov	r1, #32
    8280:	e59f0074 	ldr	r0, [pc, #116]	; 82fc <main+0xd0>
    8284:	eb00010a 	bl	86b4 <_Z4pipePKcj>
    8288:	e50b0010 	str	r0, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/tilt_task/main.cpp:34

	while (true)
	{
		wait(tiltsensor_file, 0x800);
    828c:	e3e02001 	mvn	r2, #1
    8290:	e3a01b02 	mov	r1, #2048	; 0x800
    8294:	e51b000c 	ldr	r0, [fp, #-12]
    8298:	eb0000a0 	bl	8520 <_Z4waitjjj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/tilt_task/main.cpp:39

		// "debounce" - tilt senzor bude chvili flappovat mezi vysokou a nizkou urovni
		//sleep(0x100, Deadline_Unchanged);

		read(tiltsensor_file, &state, 1);
    829c:	e24b3011 	sub	r3, fp, #17
    82a0:	e3a02001 	mov	r2, #1
    82a4:	e1a01003 	mov	r1, r3
    82a8:	e51b000c 	ldr	r0, [fp, #-12]
    82ac:	eb000043 	bl	83c0 <_Z4readjPcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/tilt_task/main.cpp:43

		//if (state != oldstate)
		{
			if (state == '0')
    82b0:	e55b3011 	ldrb	r3, [fp, #-17]	; 0xffffffef
    82b4:	e3530030 	cmp	r3, #48	; 0x30
    82b8:	1a000004 	bne	82d0 <main+0xa4>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/tilt_task/main.cpp:45
			{
				write(logpipe, "Tilt UP", 7);
    82bc:	e3a02007 	mov	r2, #7
    82c0:	e59f1038 	ldr	r1, [pc, #56]	; 8300 <main+0xd4>
    82c4:	e51b0010 	ldr	r0, [fp, #-16]
    82c8:	eb000050 	bl	8410 <_Z5writejPKcj>
    82cc:	ea000003 	b	82e0 <main+0xb4>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/tilt_task/main.cpp:49
			}
			else
			{
				write(logpipe, "Tilt DOWN", 10);
    82d0:	e3a0200a 	mov	r2, #10
    82d4:	e59f1028 	ldr	r1, [pc, #40]	; 8304 <main+0xd8>
    82d8:	e51b0010 	ldr	r0, [fp, #-16]
    82dc:	eb00004b 	bl	8410 <_Z5writejPKcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/tilt_task/main.cpp:51
			}
			oldstate = state;
    82e0:	e55b3011 	ldrb	r3, [fp, #-17]	; 0xffffffef
    82e4:	e54b3005 	strb	r3, [fp, #-5]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/tilt_task/main.cpp:54
		}

		sleep(0x1000, Indefinite/*0x100*/);
    82e8:	e3e01000 	mvn	r1, #0
    82ec:	e3a00a01 	mov	r0, #4096	; 0x1000
    82f0:	eb00009e 	bl	8570 <_Z5sleepjj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/tilt_task/main.cpp:34
		wait(tiltsensor_file, 0x800);
    82f4:	eaffffe4 	b	828c <main+0x60>
    82f8:	00008e88 	andeq	r8, r0, r8, lsl #29
    82fc:	00008e94 	muleq	r0, r4, lr
    8300:	00008e98 	muleq	r0, r8, lr
    8304:	00008ea0 	andeq	r8, r0, r0, lsr #29

00008308 <_Z6getpidv>:
_Z6getpidv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:5
#include <stdfile.h>
#include <stdstring.h>

uint32_t getpid()
{
    8308:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    830c:	e28db000 	add	fp, sp, #0
    8310:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:8
    uint32_t pid;

    asm volatile("swi 0");
    8314:	ef000000 	svc	0x00000000
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:9
    asm volatile("mov %0, r0" : "=r" (pid));
    8318:	e1a03000 	mov	r3, r0
    831c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:11

    return pid;
    8320:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:12
}
    8324:	e1a00003 	mov	r0, r3
    8328:	e28bd000 	add	sp, fp, #0
    832c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8330:	e12fff1e 	bx	lr

00008334 <_Z9terminatei>:
_Z9terminatei():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:15

void terminate(int exitcode)
{
    8334:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8338:	e28db000 	add	fp, sp, #0
    833c:	e24dd00c 	sub	sp, sp, #12
    8340:	e50b0008 	str	r0, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:16
    asm volatile("mov r0, %0" : : "r" (exitcode));
    8344:	e51b3008 	ldr	r3, [fp, #-8]
    8348:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:17
    asm volatile("swi 1");
    834c:	ef000001 	svc	0x00000001
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:18
}
    8350:	e320f000 	nop	{0}
    8354:	e28bd000 	add	sp, fp, #0
    8358:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    835c:	e12fff1e 	bx	lr

00008360 <_Z11sched_yieldv>:
_Z11sched_yieldv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:21

void sched_yield()
{
    8360:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8364:	e28db000 	add	fp, sp, #0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:22
    asm volatile("swi 2");
    8368:	ef000002 	svc	0x00000002
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:23
}
    836c:	e320f000 	nop	{0}
    8370:	e28bd000 	add	sp, fp, #0
    8374:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8378:	e12fff1e 	bx	lr

0000837c <_Z4openPKc15NFile_Open_Mode>:
_Z4openPKc15NFile_Open_Mode():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:26

uint32_t open(const char* filename, NFile_Open_Mode mode)
{
    837c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8380:	e28db000 	add	fp, sp, #0
    8384:	e24dd014 	sub	sp, sp, #20
    8388:	e50b0010 	str	r0, [fp, #-16]
    838c:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:29
    uint32_t file;

    asm volatile("mov r0, %0" : : "r" (filename));
    8390:	e51b3010 	ldr	r3, [fp, #-16]
    8394:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:30
    asm volatile("mov r1, %0" : : "r" (mode));
    8398:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    839c:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:31
    asm volatile("swi 64");
    83a0:	ef000040 	svc	0x00000040
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:32
    asm volatile("mov %0, r0" : "=r" (file));
    83a4:	e1a03000 	mov	r3, r0
    83a8:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:34

    return file;
    83ac:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:35
}
    83b0:	e1a00003 	mov	r0, r3
    83b4:	e28bd000 	add	sp, fp, #0
    83b8:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    83bc:	e12fff1e 	bx	lr

000083c0 <_Z4readjPcj>:
_Z4readjPcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:38

uint32_t read(uint32_t file, char* const buffer, uint32_t size)
{
    83c0:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    83c4:	e28db000 	add	fp, sp, #0
    83c8:	e24dd01c 	sub	sp, sp, #28
    83cc:	e50b0010 	str	r0, [fp, #-16]
    83d0:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    83d4:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:41
    uint32_t rdnum;

    asm volatile("mov r0, %0" : : "r" (file));
    83d8:	e51b3010 	ldr	r3, [fp, #-16]
    83dc:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:42
    asm volatile("mov r1, %0" : : "r" (buffer));
    83e0:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    83e4:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:43
    asm volatile("mov r2, %0" : : "r" (size));
    83e8:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    83ec:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:44
    asm volatile("swi 65");
    83f0:	ef000041 	svc	0x00000041
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:45
    asm volatile("mov %0, r0" : "=r" (rdnum));
    83f4:	e1a03000 	mov	r3, r0
    83f8:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:47

    return rdnum;
    83fc:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:48
}
    8400:	e1a00003 	mov	r0, r3
    8404:	e28bd000 	add	sp, fp, #0
    8408:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    840c:	e12fff1e 	bx	lr

00008410 <_Z5writejPKcj>:
_Z5writejPKcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:51

uint32_t write(uint32_t file, const char* buffer, uint32_t size)
{
    8410:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8414:	e28db000 	add	fp, sp, #0
    8418:	e24dd01c 	sub	sp, sp, #28
    841c:	e50b0010 	str	r0, [fp, #-16]
    8420:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8424:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:54
    uint32_t wrnum;

    asm volatile("mov r0, %0" : : "r" (file));
    8428:	e51b3010 	ldr	r3, [fp, #-16]
    842c:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:55
    asm volatile("mov r1, %0" : : "r" (buffer));
    8430:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8434:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:56
    asm volatile("mov r2, %0" : : "r" (size));
    8438:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    843c:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:57
    asm volatile("swi 66");
    8440:	ef000042 	svc	0x00000042
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:58
    asm volatile("mov %0, r0" : "=r" (wrnum));
    8444:	e1a03000 	mov	r3, r0
    8448:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:60

    return wrnum;
    844c:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:61
}
    8450:	e1a00003 	mov	r0, r3
    8454:	e28bd000 	add	sp, fp, #0
    8458:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    845c:	e12fff1e 	bx	lr

00008460 <_Z5closej>:
_Z5closej():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:64

void close(uint32_t file)
{
    8460:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8464:	e28db000 	add	fp, sp, #0
    8468:	e24dd00c 	sub	sp, sp, #12
    846c:	e50b0008 	str	r0, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:65
    asm volatile("mov r0, %0" : : "r" (file));
    8470:	e51b3008 	ldr	r3, [fp, #-8]
    8474:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:66
    asm volatile("swi 67");
    8478:	ef000043 	svc	0x00000043
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:67
}
    847c:	e320f000 	nop	{0}
    8480:	e28bd000 	add	sp, fp, #0
    8484:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8488:	e12fff1e 	bx	lr

0000848c <_Z5ioctlj16NIOCtl_OperationPv>:
_Z5ioctlj16NIOCtl_OperationPv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:70

uint32_t ioctl(uint32_t file, NIOCtl_Operation operation, void* param)
{
    848c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8490:	e28db000 	add	fp, sp, #0
    8494:	e24dd01c 	sub	sp, sp, #28
    8498:	e50b0010 	str	r0, [fp, #-16]
    849c:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    84a0:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:73
    uint32_t retcode;

    asm volatile("mov r0, %0" : : "r" (file));
    84a4:	e51b3010 	ldr	r3, [fp, #-16]
    84a8:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:74
    asm volatile("mov r1, %0" : : "r" (operation));
    84ac:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    84b0:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:75
    asm volatile("mov r2, %0" : : "r" (param));
    84b4:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    84b8:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:76
    asm volatile("swi 68");
    84bc:	ef000044 	svc	0x00000044
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:77
    asm volatile("mov %0, r0" : "=r" (retcode));
    84c0:	e1a03000 	mov	r3, r0
    84c4:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:79

    return retcode;
    84c8:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:80
}
    84cc:	e1a00003 	mov	r0, r3
    84d0:	e28bd000 	add	sp, fp, #0
    84d4:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    84d8:	e12fff1e 	bx	lr

000084dc <_Z6notifyjj>:
_Z6notifyjj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:83

uint32_t notify(uint32_t file, uint32_t count)
{
    84dc:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    84e0:	e28db000 	add	fp, sp, #0
    84e4:	e24dd014 	sub	sp, sp, #20
    84e8:	e50b0010 	str	r0, [fp, #-16]
    84ec:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:86
    uint32_t retcnt;

    asm volatile("mov r0, %0" : : "r" (file));
    84f0:	e51b3010 	ldr	r3, [fp, #-16]
    84f4:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:87
    asm volatile("mov r1, %0" : : "r" (count));
    84f8:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    84fc:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:88
    asm volatile("swi 69");
    8500:	ef000045 	svc	0x00000045
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:89
    asm volatile("mov %0, r0" : "=r" (retcnt));
    8504:	e1a03000 	mov	r3, r0
    8508:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:91

    return retcnt;
    850c:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:92
}
    8510:	e1a00003 	mov	r0, r3
    8514:	e28bd000 	add	sp, fp, #0
    8518:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    851c:	e12fff1e 	bx	lr

00008520 <_Z4waitjjj>:
_Z4waitjjj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:95

NSWI_Result_Code wait(uint32_t file, uint32_t count, uint32_t notified_deadline)
{
    8520:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8524:	e28db000 	add	fp, sp, #0
    8528:	e24dd01c 	sub	sp, sp, #28
    852c:	e50b0010 	str	r0, [fp, #-16]
    8530:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8534:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:98
    NSWI_Result_Code retcode;

    asm volatile("mov r0, %0" : : "r" (file));
    8538:	e51b3010 	ldr	r3, [fp, #-16]
    853c:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:99
    asm volatile("mov r1, %0" : : "r" (count));
    8540:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8544:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:100
    asm volatile("mov r2, %0" : : "r" (notified_deadline));
    8548:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    854c:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:101
    asm volatile("swi 70");
    8550:	ef000046 	svc	0x00000046
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:102
    asm volatile("mov %0, r0" : "=r" (retcode));
    8554:	e1a03000 	mov	r3, r0
    8558:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:104

    return retcode;
    855c:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:105
}
    8560:	e1a00003 	mov	r0, r3
    8564:	e28bd000 	add	sp, fp, #0
    8568:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    856c:	e12fff1e 	bx	lr

00008570 <_Z5sleepjj>:
_Z5sleepjj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:108

bool sleep(uint32_t ticks, uint32_t notified_deadline)
{
    8570:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8574:	e28db000 	add	fp, sp, #0
    8578:	e24dd014 	sub	sp, sp, #20
    857c:	e50b0010 	str	r0, [fp, #-16]
    8580:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:111
    uint32_t retcode;

    asm volatile("mov r0, %0" : : "r" (ticks));
    8584:	e51b3010 	ldr	r3, [fp, #-16]
    8588:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:112
    asm volatile("mov r1, %0" : : "r" (notified_deadline));
    858c:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8590:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:113
    asm volatile("swi 3");
    8594:	ef000003 	svc	0x00000003
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:114
    asm volatile("mov %0, r0" : "=r" (retcode));
    8598:	e1a03000 	mov	r3, r0
    859c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:116

    return retcode;
    85a0:	e51b3008 	ldr	r3, [fp, #-8]
    85a4:	e3530000 	cmp	r3, #0
    85a8:	13a03001 	movne	r3, #1
    85ac:	03a03000 	moveq	r3, #0
    85b0:	e6ef3073 	uxtb	r3, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:117
}
    85b4:	e1a00003 	mov	r0, r3
    85b8:	e28bd000 	add	sp, fp, #0
    85bc:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    85c0:	e12fff1e 	bx	lr

000085c4 <_Z24get_active_process_countv>:
_Z24get_active_process_countv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:120

uint32_t get_active_process_count()
{
    85c4:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    85c8:	e28db000 	add	fp, sp, #0
    85cc:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:121
    const NGet_Sched_Info_Type req = NGet_Sched_Info_Type::Active_Process_Count;
    85d0:	e3a03000 	mov	r3, #0
    85d4:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:124
    uint32_t retval;

    asm volatile("mov r0, %0" : : "r" (req));
    85d8:	e3a03000 	mov	r3, #0
    85dc:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:125
    asm volatile("mov r1, %0" : : "r" (&retval));
    85e0:	e24b300c 	sub	r3, fp, #12
    85e4:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:126
    asm volatile("swi 4");
    85e8:	ef000004 	svc	0x00000004
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:128

    return retval;
    85ec:	e51b300c 	ldr	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:129
}
    85f0:	e1a00003 	mov	r0, r3
    85f4:	e28bd000 	add	sp, fp, #0
    85f8:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    85fc:	e12fff1e 	bx	lr

00008600 <_Z14get_tick_countv>:
_Z14get_tick_countv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:132

uint32_t get_tick_count()
{
    8600:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8604:	e28db000 	add	fp, sp, #0
    8608:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:133
    const NGet_Sched_Info_Type req = NGet_Sched_Info_Type::Tick_Count;
    860c:	e3a03001 	mov	r3, #1
    8610:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:136
    uint32_t retval;

    asm volatile("mov r0, %0" : : "r" (req));
    8614:	e3a03001 	mov	r3, #1
    8618:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:137
    asm volatile("mov r1, %0" : : "r" (&retval));
    861c:	e24b300c 	sub	r3, fp, #12
    8620:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:138
    asm volatile("swi 4");
    8624:	ef000004 	svc	0x00000004
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:140

    return retval;
    8628:	e51b300c 	ldr	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:141
}
    862c:	e1a00003 	mov	r0, r3
    8630:	e28bd000 	add	sp, fp, #0
    8634:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8638:	e12fff1e 	bx	lr

0000863c <_Z17set_task_deadlinej>:
_Z17set_task_deadlinej():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:144

void set_task_deadline(uint32_t tick_count_required)
{
    863c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8640:	e28db000 	add	fp, sp, #0
    8644:	e24dd014 	sub	sp, sp, #20
    8648:	e50b0010 	str	r0, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:145
    const NDeadline_Subservice req = NDeadline_Subservice::Set_Relative;
    864c:	e3a03000 	mov	r3, #0
    8650:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:147

    asm volatile("mov r0, %0" : : "r" (req));
    8654:	e3a03000 	mov	r3, #0
    8658:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:148
    asm volatile("mov r1, %0" : : "r" (&tick_count_required));
    865c:	e24b3010 	sub	r3, fp, #16
    8660:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:149
    asm volatile("swi 5");
    8664:	ef000005 	svc	0x00000005
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:150
}
    8668:	e320f000 	nop	{0}
    866c:	e28bd000 	add	sp, fp, #0
    8670:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8674:	e12fff1e 	bx	lr

00008678 <_Z26get_task_ticks_to_deadlinev>:
_Z26get_task_ticks_to_deadlinev():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:153

uint32_t get_task_ticks_to_deadline()
{
    8678:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    867c:	e28db000 	add	fp, sp, #0
    8680:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:154
    const NDeadline_Subservice req = NDeadline_Subservice::Get_Remaining;
    8684:	e3a03001 	mov	r3, #1
    8688:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:157
    uint32_t ticks;

    asm volatile("mov r0, %0" : : "r" (req));
    868c:	e3a03001 	mov	r3, #1
    8690:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:158
    asm volatile("mov r1, %0" : : "r" (&ticks));
    8694:	e24b300c 	sub	r3, fp, #12
    8698:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:159
    asm volatile("swi 5");
    869c:	ef000005 	svc	0x00000005
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:161

    return ticks;
    86a0:	e51b300c 	ldr	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:162
}
    86a4:	e1a00003 	mov	r0, r3
    86a8:	e28bd000 	add	sp, fp, #0
    86ac:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    86b0:	e12fff1e 	bx	lr

000086b4 <_Z4pipePKcj>:
_Z4pipePKcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:167

const char Pipe_File_Prefix[] = "SYS:pipe/";

uint32_t pipe(const char* name, uint32_t buf_size)
{
    86b4:	e92d4800 	push	{fp, lr}
    86b8:	e28db004 	add	fp, sp, #4
    86bc:	e24dd050 	sub	sp, sp, #80	; 0x50
    86c0:	e50b0050 	str	r0, [fp, #-80]	; 0xffffffb0
    86c4:	e50b1054 	str	r1, [fp, #-84]	; 0xffffffac
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:169
    char fname[64];
    strncpy(fname, Pipe_File_Prefix, sizeof(Pipe_File_Prefix));
    86c8:	e24b3048 	sub	r3, fp, #72	; 0x48
    86cc:	e3a0200a 	mov	r2, #10
    86d0:	e59f1088 	ldr	r1, [pc, #136]	; 8760 <_Z4pipePKcj+0xac>
    86d4:	e1a00003 	mov	r0, r3
    86d8:	eb0000a5 	bl	8974 <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:170
    strncpy(fname + sizeof(Pipe_File_Prefix), name, sizeof(fname) - sizeof(Pipe_File_Prefix) - 1);
    86dc:	e24b3048 	sub	r3, fp, #72	; 0x48
    86e0:	e283300a 	add	r3, r3, #10
    86e4:	e3a02035 	mov	r2, #53	; 0x35
    86e8:	e51b1050 	ldr	r1, [fp, #-80]	; 0xffffffb0
    86ec:	e1a00003 	mov	r0, r3
    86f0:	eb00009f 	bl	8974 <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:172

    int ncur = sizeof(Pipe_File_Prefix) + strlen(name);
    86f4:	e51b0050 	ldr	r0, [fp, #-80]	; 0xffffffb0
    86f8:	eb0000f8 	bl	8ae0 <_Z6strlenPKc>
    86fc:	e1a03000 	mov	r3, r0
    8700:	e283300a 	add	r3, r3, #10
    8704:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:174

    fname[ncur++] = '#';
    8708:	e51b3008 	ldr	r3, [fp, #-8]
    870c:	e2832001 	add	r2, r3, #1
    8710:	e50b2008 	str	r2, [fp, #-8]
    8714:	e2433004 	sub	r3, r3, #4
    8718:	e083300b 	add	r3, r3, fp
    871c:	e3a02023 	mov	r2, #35	; 0x23
    8720:	e5432044 	strb	r2, [r3, #-68]	; 0xffffffbc
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:176

    itoa(buf_size, &fname[ncur], 10);
    8724:	e24b2048 	sub	r2, fp, #72	; 0x48
    8728:	e51b3008 	ldr	r3, [fp, #-8]
    872c:	e0823003 	add	r3, r2, r3
    8730:	e3a0200a 	mov	r2, #10
    8734:	e1a01003 	mov	r1, r3
    8738:	e51b0054 	ldr	r0, [fp, #-84]	; 0xffffffac
    873c:	eb000008 	bl	8764 <_Z4itoajPcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:178

    return open(fname, NFile_Open_Mode::Read_Write);
    8740:	e24b3048 	sub	r3, fp, #72	; 0x48
    8744:	e3a01002 	mov	r1, #2
    8748:	e1a00003 	mov	r0, r3
    874c:	ebffff0a 	bl	837c <_Z4openPKc15NFile_Open_Mode>
    8750:	e1a03000 	mov	r3, r0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:179
}
    8754:	e1a00003 	mov	r0, r3
    8758:	e24bd004 	sub	sp, fp, #4
    875c:	e8bd8800 	pop	{fp, pc}
    8760:	00008ed8 	ldrdeq	r8, [r0], -r8	; <UNPREDICTABLE>

00008764 <_Z4itoajPcj>:
_Z4itoajPcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:9
{
    const char CharConvArr[] = "0123456789ABCDEF";
}

void itoa(unsigned int input, char* output, unsigned int base)
{
    8764:	e92d4800 	push	{fp, lr}
    8768:	e28db004 	add	fp, sp, #4
    876c:	e24dd020 	sub	sp, sp, #32
    8770:	e50b0018 	str	r0, [fp, #-24]	; 0xffffffe8
    8774:	e50b101c 	str	r1, [fp, #-28]	; 0xffffffe4
    8778:	e50b2020 	str	r2, [fp, #-32]	; 0xffffffe0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:10
	int i = 0;
    877c:	e3a03000 	mov	r3, #0
    8780:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:12

	while (input > 0)
    8784:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8788:	e3530000 	cmp	r3, #0
    878c:	0a000014 	beq	87e4 <_Z4itoajPcj+0x80>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:14
	{
		output[i] = CharConvArr[input % base];
    8790:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8794:	e51b1020 	ldr	r1, [fp, #-32]	; 0xffffffe0
    8798:	e1a00003 	mov	r0, r3
    879c:	eb000199 	bl	8e08 <__aeabi_uidivmod>
    87a0:	e1a03001 	mov	r3, r1
    87a4:	e1a01003 	mov	r1, r3
    87a8:	e51b3008 	ldr	r3, [fp, #-8]
    87ac:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    87b0:	e0823003 	add	r3, r2, r3
    87b4:	e59f2118 	ldr	r2, [pc, #280]	; 88d4 <_Z4itoajPcj+0x170>
    87b8:	e7d22001 	ldrb	r2, [r2, r1]
    87bc:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:15
		input /= base;
    87c0:	e51b1020 	ldr	r1, [fp, #-32]	; 0xffffffe0
    87c4:	e51b0018 	ldr	r0, [fp, #-24]	; 0xffffffe8
    87c8:	eb000113 	bl	8c1c <__udivsi3>
    87cc:	e1a03000 	mov	r3, r0
    87d0:	e50b3018 	str	r3, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:16
		i++;
    87d4:	e51b3008 	ldr	r3, [fp, #-8]
    87d8:	e2833001 	add	r3, r3, #1
    87dc:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:12
	while (input > 0)
    87e0:	eaffffe7 	b	8784 <_Z4itoajPcj+0x20>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:19
	}

    if (i == 0)
    87e4:	e51b3008 	ldr	r3, [fp, #-8]
    87e8:	e3530000 	cmp	r3, #0
    87ec:	1a000007 	bne	8810 <_Z4itoajPcj+0xac>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:21
    {
        output[i] = CharConvArr[0];
    87f0:	e51b3008 	ldr	r3, [fp, #-8]
    87f4:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    87f8:	e0823003 	add	r3, r2, r3
    87fc:	e3a02030 	mov	r2, #48	; 0x30
    8800:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:22
        i++;
    8804:	e51b3008 	ldr	r3, [fp, #-8]
    8808:	e2833001 	add	r3, r3, #1
    880c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:25
    }

	output[i] = '\0';
    8810:	e51b3008 	ldr	r3, [fp, #-8]
    8814:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    8818:	e0823003 	add	r3, r2, r3
    881c:	e3a02000 	mov	r2, #0
    8820:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:26
	i--;
    8824:	e51b3008 	ldr	r3, [fp, #-8]
    8828:	e2433001 	sub	r3, r3, #1
    882c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:28

	for (int j = 0; j <= i/2; j++)
    8830:	e3a03000 	mov	r3, #0
    8834:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:28 (discriminator 3)
    8838:	e51b3008 	ldr	r3, [fp, #-8]
    883c:	e1a02fa3 	lsr	r2, r3, #31
    8840:	e0823003 	add	r3, r2, r3
    8844:	e1a030c3 	asr	r3, r3, #1
    8848:	e1a02003 	mov	r2, r3
    884c:	e51b300c 	ldr	r3, [fp, #-12]
    8850:	e1530002 	cmp	r3, r2
    8854:	ca00001b 	bgt	88c8 <_Z4itoajPcj+0x164>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:30 (discriminator 2)
	{
		char c = output[i - j];
    8858:	e51b2008 	ldr	r2, [fp, #-8]
    885c:	e51b300c 	ldr	r3, [fp, #-12]
    8860:	e0423003 	sub	r3, r2, r3
    8864:	e1a02003 	mov	r2, r3
    8868:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    886c:	e0833002 	add	r3, r3, r2
    8870:	e5d33000 	ldrb	r3, [r3]
    8874:	e54b300d 	strb	r3, [fp, #-13]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:31 (discriminator 2)
		output[i - j] = output[j];
    8878:	e51b300c 	ldr	r3, [fp, #-12]
    887c:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    8880:	e0822003 	add	r2, r2, r3
    8884:	e51b1008 	ldr	r1, [fp, #-8]
    8888:	e51b300c 	ldr	r3, [fp, #-12]
    888c:	e0413003 	sub	r3, r1, r3
    8890:	e1a01003 	mov	r1, r3
    8894:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    8898:	e0833001 	add	r3, r3, r1
    889c:	e5d22000 	ldrb	r2, [r2]
    88a0:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:32 (discriminator 2)
		output[j] = c;
    88a4:	e51b300c 	ldr	r3, [fp, #-12]
    88a8:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    88ac:	e0823003 	add	r3, r2, r3
    88b0:	e55b200d 	ldrb	r2, [fp, #-13]
    88b4:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:28 (discriminator 2)
	for (int j = 0; j <= i/2; j++)
    88b8:	e51b300c 	ldr	r3, [fp, #-12]
    88bc:	e2833001 	add	r3, r3, #1
    88c0:	e50b300c 	str	r3, [fp, #-12]
    88c4:	eaffffdb 	b	8838 <_Z4itoajPcj+0xd4>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:34
	}
}
    88c8:	e320f000 	nop	{0}
    88cc:	e24bd004 	sub	sp, fp, #4
    88d0:	e8bd8800 	pop	{fp, pc}
    88d4:	00008ee4 	andeq	r8, r0, r4, ror #29

000088d8 <_Z4atoiPKc>:
_Z4atoiPKc():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:37

int atoi(const char* input)
{
    88d8:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    88dc:	e28db000 	add	fp, sp, #0
    88e0:	e24dd014 	sub	sp, sp, #20
    88e4:	e50b0010 	str	r0, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:38
	int output = 0;
    88e8:	e3a03000 	mov	r3, #0
    88ec:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:40

	while (*input != '\0')
    88f0:	e51b3010 	ldr	r3, [fp, #-16]
    88f4:	e5d33000 	ldrb	r3, [r3]
    88f8:	e3530000 	cmp	r3, #0
    88fc:	0a000017 	beq	8960 <_Z4atoiPKc+0x88>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:42
	{
		output *= 10;
    8900:	e51b2008 	ldr	r2, [fp, #-8]
    8904:	e1a03002 	mov	r3, r2
    8908:	e1a03103 	lsl	r3, r3, #2
    890c:	e0833002 	add	r3, r3, r2
    8910:	e1a03083 	lsl	r3, r3, #1
    8914:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:43
		if (*input > '9' || *input < '0')
    8918:	e51b3010 	ldr	r3, [fp, #-16]
    891c:	e5d33000 	ldrb	r3, [r3]
    8920:	e3530039 	cmp	r3, #57	; 0x39
    8924:	8a00000d 	bhi	8960 <_Z4atoiPKc+0x88>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:43 (discriminator 1)
    8928:	e51b3010 	ldr	r3, [fp, #-16]
    892c:	e5d33000 	ldrb	r3, [r3]
    8930:	e353002f 	cmp	r3, #47	; 0x2f
    8934:	9a000009 	bls	8960 <_Z4atoiPKc+0x88>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:46
			break;

		output += *input - '0';
    8938:	e51b3010 	ldr	r3, [fp, #-16]
    893c:	e5d33000 	ldrb	r3, [r3]
    8940:	e2433030 	sub	r3, r3, #48	; 0x30
    8944:	e51b2008 	ldr	r2, [fp, #-8]
    8948:	e0823003 	add	r3, r2, r3
    894c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:48

		input++;
    8950:	e51b3010 	ldr	r3, [fp, #-16]
    8954:	e2833001 	add	r3, r3, #1
    8958:	e50b3010 	str	r3, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:40
	while (*input != '\0')
    895c:	eaffffe3 	b	88f0 <_Z4atoiPKc+0x18>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:51
	}

	return output;
    8960:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:52
}
    8964:	e1a00003 	mov	r0, r3
    8968:	e28bd000 	add	sp, fp, #0
    896c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8970:	e12fff1e 	bx	lr

00008974 <_Z7strncpyPcPKci>:
_Z7strncpyPcPKci():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:55

char* strncpy(char* dest, const char *src, int num)
{
    8974:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8978:	e28db000 	add	fp, sp, #0
    897c:	e24dd01c 	sub	sp, sp, #28
    8980:	e50b0010 	str	r0, [fp, #-16]
    8984:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8988:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:58
	int i;

	for (i = 0; i < num && src[i] != '\0'; i++)
    898c:	e3a03000 	mov	r3, #0
    8990:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:58 (discriminator 4)
    8994:	e51b2008 	ldr	r2, [fp, #-8]
    8998:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    899c:	e1520003 	cmp	r2, r3
    89a0:	aa000011 	bge	89ec <_Z7strncpyPcPKci+0x78>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:58 (discriminator 2)
    89a4:	e51b3008 	ldr	r3, [fp, #-8]
    89a8:	e51b2014 	ldr	r2, [fp, #-20]	; 0xffffffec
    89ac:	e0823003 	add	r3, r2, r3
    89b0:	e5d33000 	ldrb	r3, [r3]
    89b4:	e3530000 	cmp	r3, #0
    89b8:	0a00000b 	beq	89ec <_Z7strncpyPcPKci+0x78>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:59 (discriminator 3)
		dest[i] = src[i];
    89bc:	e51b3008 	ldr	r3, [fp, #-8]
    89c0:	e51b2014 	ldr	r2, [fp, #-20]	; 0xffffffec
    89c4:	e0822003 	add	r2, r2, r3
    89c8:	e51b3008 	ldr	r3, [fp, #-8]
    89cc:	e51b1010 	ldr	r1, [fp, #-16]
    89d0:	e0813003 	add	r3, r1, r3
    89d4:	e5d22000 	ldrb	r2, [r2]
    89d8:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:58 (discriminator 3)
	for (i = 0; i < num && src[i] != '\0'; i++)
    89dc:	e51b3008 	ldr	r3, [fp, #-8]
    89e0:	e2833001 	add	r3, r3, #1
    89e4:	e50b3008 	str	r3, [fp, #-8]
    89e8:	eaffffe9 	b	8994 <_Z7strncpyPcPKci+0x20>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:60 (discriminator 2)
	for (; i < num; i++)
    89ec:	e51b2008 	ldr	r2, [fp, #-8]
    89f0:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    89f4:	e1520003 	cmp	r2, r3
    89f8:	aa000008 	bge	8a20 <_Z7strncpyPcPKci+0xac>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:61 (discriminator 1)
		dest[i] = '\0';
    89fc:	e51b3008 	ldr	r3, [fp, #-8]
    8a00:	e51b2010 	ldr	r2, [fp, #-16]
    8a04:	e0823003 	add	r3, r2, r3
    8a08:	e3a02000 	mov	r2, #0
    8a0c:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:60 (discriminator 1)
	for (; i < num; i++)
    8a10:	e51b3008 	ldr	r3, [fp, #-8]
    8a14:	e2833001 	add	r3, r3, #1
    8a18:	e50b3008 	str	r3, [fp, #-8]
    8a1c:	eafffff2 	b	89ec <_Z7strncpyPcPKci+0x78>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:63

   return dest;
    8a20:	e51b3010 	ldr	r3, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:64
}
    8a24:	e1a00003 	mov	r0, r3
    8a28:	e28bd000 	add	sp, fp, #0
    8a2c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8a30:	e12fff1e 	bx	lr

00008a34 <_Z7strncmpPKcS0_i>:
_Z7strncmpPKcS0_i():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:67

int strncmp(const char *s1, const char *s2, int num)
{
    8a34:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8a38:	e28db000 	add	fp, sp, #0
    8a3c:	e24dd01c 	sub	sp, sp, #28
    8a40:	e50b0010 	str	r0, [fp, #-16]
    8a44:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8a48:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:69
	unsigned char u1, u2;
  	while (num-- > 0)
    8a4c:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8a50:	e2432001 	sub	r2, r3, #1
    8a54:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
    8a58:	e3530000 	cmp	r3, #0
    8a5c:	c3a03001 	movgt	r3, #1
    8a60:	d3a03000 	movle	r3, #0
    8a64:	e6ef3073 	uxtb	r3, r3
    8a68:	e3530000 	cmp	r3, #0
    8a6c:	0a000016 	beq	8acc <_Z7strncmpPKcS0_i+0x98>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:71
    {
      	u1 = (unsigned char) *s1++;
    8a70:	e51b3010 	ldr	r3, [fp, #-16]
    8a74:	e2832001 	add	r2, r3, #1
    8a78:	e50b2010 	str	r2, [fp, #-16]
    8a7c:	e5d33000 	ldrb	r3, [r3]
    8a80:	e54b3005 	strb	r3, [fp, #-5]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:72
     	u2 = (unsigned char) *s2++;
    8a84:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8a88:	e2832001 	add	r2, r3, #1
    8a8c:	e50b2014 	str	r2, [fp, #-20]	; 0xffffffec
    8a90:	e5d33000 	ldrb	r3, [r3]
    8a94:	e54b3006 	strb	r3, [fp, #-6]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:73
      	if (u1 != u2)
    8a98:	e55b2005 	ldrb	r2, [fp, #-5]
    8a9c:	e55b3006 	ldrb	r3, [fp, #-6]
    8aa0:	e1520003 	cmp	r2, r3
    8aa4:	0a000003 	beq	8ab8 <_Z7strncmpPKcS0_i+0x84>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:74
        	return u1 - u2;
    8aa8:	e55b2005 	ldrb	r2, [fp, #-5]
    8aac:	e55b3006 	ldrb	r3, [fp, #-6]
    8ab0:	e0423003 	sub	r3, r2, r3
    8ab4:	ea000005 	b	8ad0 <_Z7strncmpPKcS0_i+0x9c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:75
      	if (u1 == '\0')
    8ab8:	e55b3005 	ldrb	r3, [fp, #-5]
    8abc:	e3530000 	cmp	r3, #0
    8ac0:	1affffe1 	bne	8a4c <_Z7strncmpPKcS0_i+0x18>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:76
        	return 0;
    8ac4:	e3a03000 	mov	r3, #0
    8ac8:	ea000000 	b	8ad0 <_Z7strncmpPKcS0_i+0x9c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:79
    }

  	return 0;
    8acc:	e3a03000 	mov	r3, #0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:80
}
    8ad0:	e1a00003 	mov	r0, r3
    8ad4:	e28bd000 	add	sp, fp, #0
    8ad8:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8adc:	e12fff1e 	bx	lr

00008ae0 <_Z6strlenPKc>:
_Z6strlenPKc():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:83

int strlen(const char* s)
{
    8ae0:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8ae4:	e28db000 	add	fp, sp, #0
    8ae8:	e24dd014 	sub	sp, sp, #20
    8aec:	e50b0010 	str	r0, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:84
	int i = 0;
    8af0:	e3a03000 	mov	r3, #0
    8af4:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:86

	while (s[i] != '\0')
    8af8:	e51b3008 	ldr	r3, [fp, #-8]
    8afc:	e51b2010 	ldr	r2, [fp, #-16]
    8b00:	e0823003 	add	r3, r2, r3
    8b04:	e5d33000 	ldrb	r3, [r3]
    8b08:	e3530000 	cmp	r3, #0
    8b0c:	0a000003 	beq	8b20 <_Z6strlenPKc+0x40>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:87
		i++;
    8b10:	e51b3008 	ldr	r3, [fp, #-8]
    8b14:	e2833001 	add	r3, r3, #1
    8b18:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:86
	while (s[i] != '\0')
    8b1c:	eafffff5 	b	8af8 <_Z6strlenPKc+0x18>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:89

	return i;
    8b20:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:90
}
    8b24:	e1a00003 	mov	r0, r3
    8b28:	e28bd000 	add	sp, fp, #0
    8b2c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8b30:	e12fff1e 	bx	lr

00008b34 <_Z5bzeroPvi>:
_Z5bzeroPvi():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:93

void bzero(void* memory, int length)
{
    8b34:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8b38:	e28db000 	add	fp, sp, #0
    8b3c:	e24dd014 	sub	sp, sp, #20
    8b40:	e50b0010 	str	r0, [fp, #-16]
    8b44:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:94
	char* mem = reinterpret_cast<char*>(memory);
    8b48:	e51b3010 	ldr	r3, [fp, #-16]
    8b4c:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:96

	for (int i = 0; i < length; i++)
    8b50:	e3a03000 	mov	r3, #0
    8b54:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:96 (discriminator 3)
    8b58:	e51b2008 	ldr	r2, [fp, #-8]
    8b5c:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8b60:	e1520003 	cmp	r2, r3
    8b64:	aa000008 	bge	8b8c <_Z5bzeroPvi+0x58>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:97 (discriminator 2)
		mem[i] = 0;
    8b68:	e51b3008 	ldr	r3, [fp, #-8]
    8b6c:	e51b200c 	ldr	r2, [fp, #-12]
    8b70:	e0823003 	add	r3, r2, r3
    8b74:	e3a02000 	mov	r2, #0
    8b78:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:96 (discriminator 2)
	for (int i = 0; i < length; i++)
    8b7c:	e51b3008 	ldr	r3, [fp, #-8]
    8b80:	e2833001 	add	r3, r3, #1
    8b84:	e50b3008 	str	r3, [fp, #-8]
    8b88:	eafffff2 	b	8b58 <_Z5bzeroPvi+0x24>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:98
}
    8b8c:	e320f000 	nop	{0}
    8b90:	e28bd000 	add	sp, fp, #0
    8b94:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8b98:	e12fff1e 	bx	lr

00008b9c <_Z6memcpyPKvPvi>:
_Z6memcpyPKvPvi():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:101

void memcpy(const void* src, void* dst, int num)
{
    8b9c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8ba0:	e28db000 	add	fp, sp, #0
    8ba4:	e24dd024 	sub	sp, sp, #36	; 0x24
    8ba8:	e50b0018 	str	r0, [fp, #-24]	; 0xffffffe8
    8bac:	e50b101c 	str	r1, [fp, #-28]	; 0xffffffe4
    8bb0:	e50b2020 	str	r2, [fp, #-32]	; 0xffffffe0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:102
	const char* memsrc = reinterpret_cast<const char*>(src);
    8bb4:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8bb8:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:103
	char* memdst = reinterpret_cast<char*>(dst);
    8bbc:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    8bc0:	e50b3010 	str	r3, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:105

	for (int i = 0; i < num; i++)
    8bc4:	e3a03000 	mov	r3, #0
    8bc8:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:105 (discriminator 3)
    8bcc:	e51b2008 	ldr	r2, [fp, #-8]
    8bd0:	e51b3020 	ldr	r3, [fp, #-32]	; 0xffffffe0
    8bd4:	e1520003 	cmp	r2, r3
    8bd8:	aa00000b 	bge	8c0c <_Z6memcpyPKvPvi+0x70>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:106 (discriminator 2)
		memdst[i] = memsrc[i];
    8bdc:	e51b3008 	ldr	r3, [fp, #-8]
    8be0:	e51b200c 	ldr	r2, [fp, #-12]
    8be4:	e0822003 	add	r2, r2, r3
    8be8:	e51b3008 	ldr	r3, [fp, #-8]
    8bec:	e51b1010 	ldr	r1, [fp, #-16]
    8bf0:	e0813003 	add	r3, r1, r3
    8bf4:	e5d22000 	ldrb	r2, [r2]
    8bf8:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:105 (discriminator 2)
	for (int i = 0; i < num; i++)
    8bfc:	e51b3008 	ldr	r3, [fp, #-8]
    8c00:	e2833001 	add	r3, r3, #1
    8c04:	e50b3008 	str	r3, [fp, #-8]
    8c08:	eaffffef 	b	8bcc <_Z6memcpyPKvPvi+0x30>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:107
}
    8c0c:	e320f000 	nop	{0}
    8c10:	e28bd000 	add	sp, fp, #0
    8c14:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8c18:	e12fff1e 	bx	lr

00008c1c <__udivsi3>:
__udivsi3():
    8c1c:	e2512001 	subs	r2, r1, #1
    8c20:	012fff1e 	bxeq	lr
    8c24:	3a000074 	bcc	8dfc <__udivsi3+0x1e0>
    8c28:	e1500001 	cmp	r0, r1
    8c2c:	9a00006b 	bls	8de0 <__udivsi3+0x1c4>
    8c30:	e1110002 	tst	r1, r2
    8c34:	0a00006c 	beq	8dec <__udivsi3+0x1d0>
    8c38:	e16f3f10 	clz	r3, r0
    8c3c:	e16f2f11 	clz	r2, r1
    8c40:	e0423003 	sub	r3, r2, r3
    8c44:	e273301f 	rsbs	r3, r3, #31
    8c48:	10833083 	addne	r3, r3, r3, lsl #1
    8c4c:	e3a02000 	mov	r2, #0
    8c50:	108ff103 	addne	pc, pc, r3, lsl #2
    8c54:	e1a00000 	nop			; (mov r0, r0)
    8c58:	e1500f81 	cmp	r0, r1, lsl #31
    8c5c:	e0a22002 	adc	r2, r2, r2
    8c60:	20400f81 	subcs	r0, r0, r1, lsl #31
    8c64:	e1500f01 	cmp	r0, r1, lsl #30
    8c68:	e0a22002 	adc	r2, r2, r2
    8c6c:	20400f01 	subcs	r0, r0, r1, lsl #30
    8c70:	e1500e81 	cmp	r0, r1, lsl #29
    8c74:	e0a22002 	adc	r2, r2, r2
    8c78:	20400e81 	subcs	r0, r0, r1, lsl #29
    8c7c:	e1500e01 	cmp	r0, r1, lsl #28
    8c80:	e0a22002 	adc	r2, r2, r2
    8c84:	20400e01 	subcs	r0, r0, r1, lsl #28
    8c88:	e1500d81 	cmp	r0, r1, lsl #27
    8c8c:	e0a22002 	adc	r2, r2, r2
    8c90:	20400d81 	subcs	r0, r0, r1, lsl #27
    8c94:	e1500d01 	cmp	r0, r1, lsl #26
    8c98:	e0a22002 	adc	r2, r2, r2
    8c9c:	20400d01 	subcs	r0, r0, r1, lsl #26
    8ca0:	e1500c81 	cmp	r0, r1, lsl #25
    8ca4:	e0a22002 	adc	r2, r2, r2
    8ca8:	20400c81 	subcs	r0, r0, r1, lsl #25
    8cac:	e1500c01 	cmp	r0, r1, lsl #24
    8cb0:	e0a22002 	adc	r2, r2, r2
    8cb4:	20400c01 	subcs	r0, r0, r1, lsl #24
    8cb8:	e1500b81 	cmp	r0, r1, lsl #23
    8cbc:	e0a22002 	adc	r2, r2, r2
    8cc0:	20400b81 	subcs	r0, r0, r1, lsl #23
    8cc4:	e1500b01 	cmp	r0, r1, lsl #22
    8cc8:	e0a22002 	adc	r2, r2, r2
    8ccc:	20400b01 	subcs	r0, r0, r1, lsl #22
    8cd0:	e1500a81 	cmp	r0, r1, lsl #21
    8cd4:	e0a22002 	adc	r2, r2, r2
    8cd8:	20400a81 	subcs	r0, r0, r1, lsl #21
    8cdc:	e1500a01 	cmp	r0, r1, lsl #20
    8ce0:	e0a22002 	adc	r2, r2, r2
    8ce4:	20400a01 	subcs	r0, r0, r1, lsl #20
    8ce8:	e1500981 	cmp	r0, r1, lsl #19
    8cec:	e0a22002 	adc	r2, r2, r2
    8cf0:	20400981 	subcs	r0, r0, r1, lsl #19
    8cf4:	e1500901 	cmp	r0, r1, lsl #18
    8cf8:	e0a22002 	adc	r2, r2, r2
    8cfc:	20400901 	subcs	r0, r0, r1, lsl #18
    8d00:	e1500881 	cmp	r0, r1, lsl #17
    8d04:	e0a22002 	adc	r2, r2, r2
    8d08:	20400881 	subcs	r0, r0, r1, lsl #17
    8d0c:	e1500801 	cmp	r0, r1, lsl #16
    8d10:	e0a22002 	adc	r2, r2, r2
    8d14:	20400801 	subcs	r0, r0, r1, lsl #16
    8d18:	e1500781 	cmp	r0, r1, lsl #15
    8d1c:	e0a22002 	adc	r2, r2, r2
    8d20:	20400781 	subcs	r0, r0, r1, lsl #15
    8d24:	e1500701 	cmp	r0, r1, lsl #14
    8d28:	e0a22002 	adc	r2, r2, r2
    8d2c:	20400701 	subcs	r0, r0, r1, lsl #14
    8d30:	e1500681 	cmp	r0, r1, lsl #13
    8d34:	e0a22002 	adc	r2, r2, r2
    8d38:	20400681 	subcs	r0, r0, r1, lsl #13
    8d3c:	e1500601 	cmp	r0, r1, lsl #12
    8d40:	e0a22002 	adc	r2, r2, r2
    8d44:	20400601 	subcs	r0, r0, r1, lsl #12
    8d48:	e1500581 	cmp	r0, r1, lsl #11
    8d4c:	e0a22002 	adc	r2, r2, r2
    8d50:	20400581 	subcs	r0, r0, r1, lsl #11
    8d54:	e1500501 	cmp	r0, r1, lsl #10
    8d58:	e0a22002 	adc	r2, r2, r2
    8d5c:	20400501 	subcs	r0, r0, r1, lsl #10
    8d60:	e1500481 	cmp	r0, r1, lsl #9
    8d64:	e0a22002 	adc	r2, r2, r2
    8d68:	20400481 	subcs	r0, r0, r1, lsl #9
    8d6c:	e1500401 	cmp	r0, r1, lsl #8
    8d70:	e0a22002 	adc	r2, r2, r2
    8d74:	20400401 	subcs	r0, r0, r1, lsl #8
    8d78:	e1500381 	cmp	r0, r1, lsl #7
    8d7c:	e0a22002 	adc	r2, r2, r2
    8d80:	20400381 	subcs	r0, r0, r1, lsl #7
    8d84:	e1500301 	cmp	r0, r1, lsl #6
    8d88:	e0a22002 	adc	r2, r2, r2
    8d8c:	20400301 	subcs	r0, r0, r1, lsl #6
    8d90:	e1500281 	cmp	r0, r1, lsl #5
    8d94:	e0a22002 	adc	r2, r2, r2
    8d98:	20400281 	subcs	r0, r0, r1, lsl #5
    8d9c:	e1500201 	cmp	r0, r1, lsl #4
    8da0:	e0a22002 	adc	r2, r2, r2
    8da4:	20400201 	subcs	r0, r0, r1, lsl #4
    8da8:	e1500181 	cmp	r0, r1, lsl #3
    8dac:	e0a22002 	adc	r2, r2, r2
    8db0:	20400181 	subcs	r0, r0, r1, lsl #3
    8db4:	e1500101 	cmp	r0, r1, lsl #2
    8db8:	e0a22002 	adc	r2, r2, r2
    8dbc:	20400101 	subcs	r0, r0, r1, lsl #2
    8dc0:	e1500081 	cmp	r0, r1, lsl #1
    8dc4:	e0a22002 	adc	r2, r2, r2
    8dc8:	20400081 	subcs	r0, r0, r1, lsl #1
    8dcc:	e1500001 	cmp	r0, r1
    8dd0:	e0a22002 	adc	r2, r2, r2
    8dd4:	20400001 	subcs	r0, r0, r1
    8dd8:	e1a00002 	mov	r0, r2
    8ddc:	e12fff1e 	bx	lr
    8de0:	03a00001 	moveq	r0, #1
    8de4:	13a00000 	movne	r0, #0
    8de8:	e12fff1e 	bx	lr
    8dec:	e16f2f11 	clz	r2, r1
    8df0:	e262201f 	rsb	r2, r2, #31
    8df4:	e1a00230 	lsr	r0, r0, r2
    8df8:	e12fff1e 	bx	lr
    8dfc:	e3500000 	cmp	r0, #0
    8e00:	13e00000 	mvnne	r0, #0
    8e04:	ea000007 	b	8e28 <__aeabi_idiv0>

00008e08 <__aeabi_uidivmod>:
__aeabi_uidivmod():
    8e08:	e3510000 	cmp	r1, #0
    8e0c:	0afffffa 	beq	8dfc <__udivsi3+0x1e0>
    8e10:	e92d4003 	push	{r0, r1, lr}
    8e14:	ebffff80 	bl	8c1c <__udivsi3>
    8e18:	e8bd4006 	pop	{r1, r2, lr}
    8e1c:	e0030092 	mul	r3, r2, r0
    8e20:	e0411003 	sub	r1, r1, r3
    8e24:	e12fff1e 	bx	lr

00008e28 <__aeabi_idiv0>:
__aeabi_ldiv0():
    8e28:	e12fff1e 	bx	lr

Disassembly of section .rodata:

00008e2c <_ZL13Lock_Unlocked>:
    8e2c:	00000000 	andeq	r0, r0, r0

00008e30 <_ZL11Lock_Locked>:
    8e30:	00000001 	andeq	r0, r0, r1

00008e34 <_ZL21MaxFSDriverNameLength>:
    8e34:	00000010 	andeq	r0, r0, r0, lsl r0

00008e38 <_ZL17MaxFilenameLength>:
    8e38:	00000010 	andeq	r0, r0, r0, lsl r0

00008e3c <_ZL13MaxPathLength>:
    8e3c:	00000080 	andeq	r0, r0, r0, lsl #1

00008e40 <_ZL18NoFilesystemDriver>:
    8e40:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008e44 <_ZL9NotifyAll>:
    8e44:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008e48 <_ZL24Max_Process_Opened_Files>:
    8e48:	00000010 	andeq	r0, r0, r0, lsl r0

00008e4c <_ZL10Indefinite>:
    8e4c:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008e50 <_ZL18Deadline_Unchanged>:
    8e50:	fffffffe 			; <UNDEFINED> instruction: 0xfffffffe

00008e54 <_ZL14Invalid_Handle>:
    8e54:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008e58 <_ZN3halL18Default_Clock_RateE>:
    8e58:	0ee6b280 	cdpeq	2, 14, cr11, cr6, cr0, {4}

00008e5c <_ZN3halL15Peripheral_BaseE>:
    8e5c:	20000000 	andcs	r0, r0, r0

00008e60 <_ZN3halL9GPIO_BaseE>:
    8e60:	20200000 	eorcs	r0, r0, r0

00008e64 <_ZN3halL14GPIO_Pin_CountE>:
    8e64:	00000036 	andeq	r0, r0, r6, lsr r0

00008e68 <_ZN3halL8AUX_BaseE>:
    8e68:	20215000 	eorcs	r5, r1, r0

00008e6c <_ZN3halL25Interrupt_Controller_BaseE>:
    8e6c:	2000b200 	andcs	fp, r0, r0, lsl #4

00008e70 <_ZN3halL10Timer_BaseE>:
    8e70:	2000b400 	andcs	fp, r0, r0, lsl #8

00008e74 <_ZN3halL9TRNG_BaseE>:
    8e74:	20104000 	andscs	r4, r0, r0

00008e78 <_ZN3halL9BSC0_BaseE>:
    8e78:	20205000 	eorcs	r5, r0, r0

00008e7c <_ZN3halL9BSC1_BaseE>:
    8e7c:	20804000 	addcs	r4, r0, r0

00008e80 <_ZN3halL9BSC2_BaseE>:
    8e80:	20805000 	addcs	r5, r0, r0

00008e84 <_ZL11Invalid_Pin>:
    8e84:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
    8e88:	3a564544 	bcc	159a3a0 <__bss_end+0x1591498>
    8e8c:	6f697067 	svcvs	0x00697067
    8e90:	0033322f 	eorseq	r3, r3, pc, lsr #4
    8e94:	00676f6c 	rsbeq	r6, r7, ip, ror #30
    8e98:	746c6954 	strbtvc	r6, [ip], #-2388	; 0xfffff6ac
    8e9c:	00505520 	subseq	r5, r0, r0, lsr #10
    8ea0:	746c6954 	strbtvc	r6, [ip], #-2388	; 0xfffff6ac
    8ea4:	574f4420 	strbpl	r4, [pc, -r0, lsr #8]
    8ea8:	0000004e 	andeq	r0, r0, lr, asr #32

00008eac <_ZL13Lock_Unlocked>:
    8eac:	00000000 	andeq	r0, r0, r0

00008eb0 <_ZL11Lock_Locked>:
    8eb0:	00000001 	andeq	r0, r0, r1

00008eb4 <_ZL21MaxFSDriverNameLength>:
    8eb4:	00000010 	andeq	r0, r0, r0, lsl r0

00008eb8 <_ZL17MaxFilenameLength>:
    8eb8:	00000010 	andeq	r0, r0, r0, lsl r0

00008ebc <_ZL13MaxPathLength>:
    8ebc:	00000080 	andeq	r0, r0, r0, lsl #1

00008ec0 <_ZL18NoFilesystemDriver>:
    8ec0:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008ec4 <_ZL9NotifyAll>:
    8ec4:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008ec8 <_ZL24Max_Process_Opened_Files>:
    8ec8:	00000010 	andeq	r0, r0, r0, lsl r0

00008ecc <_ZL10Indefinite>:
    8ecc:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008ed0 <_ZL18Deadline_Unchanged>:
    8ed0:	fffffffe 			; <UNDEFINED> instruction: 0xfffffffe

00008ed4 <_ZL14Invalid_Handle>:
    8ed4:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008ed8 <_ZL16Pipe_File_Prefix>:
    8ed8:	3a535953 	bcc	14df42c <__bss_end+0x14d6524>
    8edc:	65706970 	ldrbvs	r6, [r0, #-2416]!	; 0xfffff690
    8ee0:	0000002f 	andeq	r0, r0, pc, lsr #32

00008ee4 <_ZN12_GLOBAL__N_1L11CharConvArrE>:
    8ee4:	33323130 	teqcc	r2, #48, 2
    8ee8:	37363534 			; <UNDEFINED> instruction: 0x37363534
    8eec:	42413938 	submi	r3, r1, #56, 18	; 0xe0000
    8ef0:	46454443 	strbmi	r4, [r5], -r3, asr #8
	...

Disassembly of section .bss:

00008ef8 <__bss_start>:
	...

Disassembly of section .ARM.attributes:

00000000 <.ARM.attributes>:
   0:	00002e41 	andeq	r2, r0, r1, asr #28
   4:	61656100 	cmnvs	r5, r0, lsl #2
   8:	01006962 	tsteq	r0, r2, ror #18
   c:	00000024 	andeq	r0, r0, r4, lsr #32
  10:	4b5a3605 	blmi	168d82c <__bss_end+0x1684924>
  14:	08070600 	stmdaeq	r7, {r9, sl}
  18:	0a010901 	beq	42424 <__bss_end+0x3951c>
  1c:	14041202 	strne	r1, [r4], #-514	; 0xfffffdfe
  20:	17011501 	strne	r1, [r1, -r1, lsl #10]
  24:	1a011803 	bne	46038 <__bss_end+0x3d130>
  28:	22011c01 	andcs	r1, r1, #256	; 0x100
  2c:	Address 0x000000000000002c is out of bounds.


Disassembly of section .comment:

00000000 <.comment>:
   0:	3a434347 	bcc	10d0d24 <__bss_end+0x10c7e1c>
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
  38:	7a617661 	bvc	185d9c4 <__bss_end+0x1854abc>
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
  c0:	6a757a61 	bvs	1d5ea4c <__bss_end+0x1d55b44>
  c4:	2f696369 	svccs	0x00696369
  c8:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
  cc:	73656d65 	cmnvc	r5, #6464	; 0x1940
  d0:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
  d4:	6b2d616b 	blvs	b58688 <__bss_end+0xb4f780>
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
 144:	fb010200 	blx	4094e <__bss_end+0x37a46>
 148:	01000d0e 	tsteq	r0, lr, lsl #26
 14c:	00010101 	andeq	r0, r1, r1, lsl #2
 150:	00010000 	andeq	r0, r1, r0
 154:	552f0100 	strpl	r0, [pc, #-256]!	; 5c <shift+0x5c>
 158:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 15c:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 160:	6a726574 	bvs	1c99738 <__bss_end+0x1c90830>
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
 198:	752f7365 	strvc	r7, [pc, #-869]!	; fffffe3b <__bss_end+0xffff6f33>
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
 1d0:	0a05830b 	beq	160e04 <__bss_end+0x157efc>
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
 1fc:	4a030402 	bmi	c120c <__bss_end+0xb8304>
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
 230:	4a020402 	bmi	81240 <__bss_end+0x78338>
 234:	02000205 	andeq	r0, r0, #1342177280	; 0x50000000
 238:	052d0204 	streq	r0, [sp, #-516]!	; 0xfffffdfc
 23c:	01058509 	tsteq	r5, r9, lsl #10
 240:	000a022f 	andeq	r0, sl, pc, lsr #4
 244:	02ce0101 	sbceq	r0, lr, #1073741824	; 0x40000000
 248:	00030000 	andeq	r0, r3, r0
 24c:	0000028e 	andeq	r0, r0, lr, lsl #5
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
 280:	6a757a61 	bvs	1d5ec0c <__bss_end+0x1d55d04>
 284:	2f696369 	svccs	0x00696369
 288:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
 28c:	73656d65 	cmnvc	r5, #6464	; 0x1940
 290:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
 294:	6b2d616b 	blvs	b58848 <__bss_end+0xb4f940>
 298:	6f2d7669 	svcvs	0x002d7669
 29c:	6f732f73 	svcvs	0x00732f73
 2a0:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
 2a4:	73752f73 	cmnvc	r5, #460	; 0x1cc
 2a8:	70737265 	rsbsvc	r7, r3, r5, ror #4
 2ac:	2f656361 	svccs	0x00656361
 2b0:	746c6974 	strbtvc	r6, [ip], #-2420	; 0xfffff68c
 2b4:	7361745f 	cmnvc	r1, #1593835520	; 0x5f000000
 2b8:	552f006b 	strpl	r0, [pc, #-107]!	; 255 <shift+0x255>
 2bc:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 2c0:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 2c4:	6a726574 	bvs	1c9989c <__bss_end+0x1c90994>
 2c8:	65442f69 	strbvs	r2, [r4, #-3945]	; 0xfffff097
 2cc:	6f746b73 	svcvs	0x00746b73
 2d0:	41462f70 	hvcmi	25328	; 0x62f0
 2d4:	614e2f56 	cmpvs	lr, r6, asr pc
 2d8:	757a6176 	ldrbvc	r6, [sl, #-374]!	; 0xfffffe8a
 2dc:	6963696a 	stmdbvs	r3!, {r1, r3, r5, r6, r8, fp, sp, lr}^
 2e0:	2f534f2f 	svccs	0x00534f2f
 2e4:	656d6573 	strbvs	r6, [sp, #-1395]!	; 0xfffffa8d
 2e8:	61727473 	cmnvs	r2, r3, ror r4
 2ec:	2d616b6c 	vstmdbcs	r1!, {d22-<overflow reg d75>}
 2f0:	2d76696b 			; <UNDEFINED> instruction: 0x2d76696b
 2f4:	732f736f 			; <UNDEFINED> instruction: 0x732f736f
 2f8:	6372756f 	cmnvs	r2, #465567744	; 0x1bc00000
 2fc:	752f7365 	strvc	r7, [pc, #-869]!	; ffffff9f <__bss_end+0xffff7097>
 300:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 304:	65636170 	strbvs	r6, [r3, #-368]!	; 0xfffffe90
 308:	2f2e2e2f 	svccs	0x002e2e2f
 30c:	6e72656b 	cdpvs	5, 7, cr6, cr2, cr11, {3}
 310:	692f6c65 	stmdbvs	pc!, {r0, r2, r5, r6, sl, fp, sp, lr}	; <UNPREDICTABLE>
 314:	756c636e 	strbvc	r6, [ip, #-878]!	; 0xfffffc92
 318:	702f6564 	eorvc	r6, pc, r4, ror #10
 31c:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
 320:	2f007373 	svccs	0x00007373
 324:	72657355 	rsbvc	r7, r5, #1409286145	; 0x54000001
 328:	69772f73 	ldmdbvs	r7!, {r0, r1, r4, r5, r6, r8, r9, sl, fp, sp}^
 32c:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
 330:	442f696a 	strtmi	r6, [pc], #-2410	; 338 <shift+0x338>
 334:	746b7365 	strbtvc	r7, [fp], #-869	; 0xfffffc9b
 338:	462f706f 	strtmi	r7, [pc], -pc, rrx
 33c:	4e2f5641 	cfmadda32mi	mvax2, mvax5, mvfx15, mvfx1
 340:	7a617661 	bvc	185dccc <__bss_end+0x1854dc4>
 344:	63696a75 	cmnvs	r9, #479232	; 0x75000
 348:	534f2f69 	movtpl	r2, #65385	; 0xff69
 34c:	6d65732f 	stclvs	3, cr7, [r5, #-188]!	; 0xffffff44
 350:	72747365 	rsbsvc	r7, r4, #-1811939327	; 0x94000001
 354:	616b6c61 	cmnvs	fp, r1, ror #24
 358:	76696b2d 	strbtvc	r6, [r9], -sp, lsr #22
 35c:	2f736f2d 	svccs	0x00736f2d
 360:	72756f73 	rsbsvc	r6, r5, #460	; 0x1cc
 364:	2f736563 	svccs	0x00736563
 368:	72657375 	rsbvc	r7, r5, #-738197503	; 0xd4000001
 36c:	63617073 	cmnvs	r1, #115	; 0x73
 370:	2e2e2f65 	cdpcs	15, 2, cr2, cr14, cr5, {3}
 374:	72656b2f 	rsbvc	r6, r5, #48128	; 0xbc00
 378:	2f6c656e 	svccs	0x006c656e
 37c:	6c636e69 	stclvs	14, cr6, [r3], #-420	; 0xfffffe5c
 380:	2f656475 	svccs	0x00656475
 384:	2f007366 	svccs	0x00007366
 388:	72657355 	rsbvc	r7, r5, #1409286145	; 0x54000001
 38c:	69772f73 	ldmdbvs	r7!, {r0, r1, r4, r5, r6, r8, r9, sl, fp, sp}^
 390:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
 394:	442f696a 	strtmi	r6, [pc], #-2410	; 39c <shift+0x39c>
 398:	746b7365 	strbtvc	r7, [fp], #-869	; 0xfffffc9b
 39c:	462f706f 	strtmi	r7, [pc], -pc, rrx
 3a0:	4e2f5641 	cfmadda32mi	mvax2, mvax5, mvfx15, mvfx1
 3a4:	7a617661 	bvc	185dd30 <__bss_end+0x1854e28>
 3a8:	63696a75 	cmnvs	r9, #479232	; 0x75000
 3ac:	534f2f69 	movtpl	r2, #65385	; 0xff69
 3b0:	6d65732f 	stclvs	3, cr7, [r5, #-188]!	; 0xffffff44
 3b4:	72747365 	rsbsvc	r7, r4, #-1811939327	; 0x94000001
 3b8:	616b6c61 	cmnvs	fp, r1, ror #24
 3bc:	76696b2d 	strbtvc	r6, [r9], -sp, lsr #22
 3c0:	2f736f2d 	svccs	0x00736f2d
 3c4:	72756f73 	rsbsvc	r6, r5, #460	; 0x1cc
 3c8:	2f736563 	svccs	0x00736563
 3cc:	72657375 	rsbvc	r7, r5, #-738197503	; 0xd4000001
 3d0:	63617073 	cmnvs	r1, #115	; 0x73
 3d4:	2e2e2f65 	cdpcs	15, 2, cr2, cr14, cr5, {3}
 3d8:	72656b2f 	rsbvc	r6, r5, #48128	; 0xbc00
 3dc:	2f6c656e 	svccs	0x006c656e
 3e0:	6c636e69 	stclvs	14, cr6, [r3], #-420	; 0xfffffe5c
 3e4:	2f656475 	svccs	0x00656475
 3e8:	72616f62 	rsbvc	r6, r1, #392	; 0x188
 3ec:	70722f64 	rsbsvc	r2, r2, r4, ror #30
 3f0:	682f3069 	stmdavs	pc!, {r0, r3, r5, r6, ip, sp}	; <UNPREDICTABLE>
 3f4:	2f006c61 	svccs	0x00006c61
 3f8:	72657355 	rsbvc	r7, r5, #1409286145	; 0x54000001
 3fc:	69772f73 	ldmdbvs	r7!, {r0, r1, r4, r5, r6, r8, r9, sl, fp, sp}^
 400:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
 404:	442f696a 	strtmi	r6, [pc], #-2410	; 40c <shift+0x40c>
 408:	746b7365 	strbtvc	r7, [fp], #-869	; 0xfffffc9b
 40c:	462f706f 	strtmi	r7, [pc], -pc, rrx
 410:	4e2f5641 	cfmadda32mi	mvax2, mvax5, mvfx15, mvfx1
 414:	7a617661 	bvc	185dda0 <__bss_end+0x1854e98>
 418:	63696a75 	cmnvs	r9, #479232	; 0x75000
 41c:	534f2f69 	movtpl	r2, #65385	; 0xff69
 420:	6d65732f 	stclvs	3, cr7, [r5, #-188]!	; 0xffffff44
 424:	72747365 	rsbsvc	r7, r4, #-1811939327	; 0x94000001
 428:	616b6c61 	cmnvs	fp, r1, ror #24
 42c:	76696b2d 	strbtvc	r6, [r9], -sp, lsr #22
 430:	2f736f2d 	svccs	0x00736f2d
 434:	72756f73 	rsbsvc	r6, r5, #460	; 0x1cc
 438:	2f736563 	svccs	0x00736563
 43c:	72657375 	rsbvc	r7, r5, #-738197503	; 0xd4000001
 440:	63617073 	cmnvs	r1, #115	; 0x73
 444:	2e2e2f65 	cdpcs	15, 2, cr2, cr14, cr5, {3}
 448:	72656b2f 	rsbvc	r6, r5, #48128	; 0xbc00
 44c:	2f6c656e 	svccs	0x006c656e
 450:	6c636e69 	stclvs	14, cr6, [r3], #-420	; 0xfffffe5c
 454:	2f656475 	svccs	0x00656475
 458:	76697264 	strbtvc	r7, [r9], -r4, ror #4
 45c:	00737265 	rsbseq	r7, r3, r5, ror #4
 460:	69616d00 	stmdbvs	r1!, {r8, sl, fp, sp, lr}^
 464:	70632e6e 	rsbvc	r2, r3, lr, ror #28
 468:	00010070 	andeq	r0, r1, r0, ror r0
 46c:	69777300 	ldmdbvs	r7!, {r8, r9, ip, sp, lr}^
 470:	0200682e 	andeq	r6, r0, #3014656	; 0x2e0000
 474:	70730000 	rsbsvc	r0, r3, r0
 478:	6f6c6e69 	svcvs	0x006c6e69
 47c:	682e6b63 	stmdavs	lr!, {r0, r1, r5, r6, r8, r9, fp, sp, lr}
 480:	00000200 	andeq	r0, r0, r0, lsl #4
 484:	656c6966 	strbvs	r6, [ip, #-2406]!	; 0xfffff69a
 488:	74737973 	ldrbtvc	r7, [r3], #-2419	; 0xfffff68d
 48c:	682e6d65 	stmdavs	lr!, {r0, r2, r5, r6, r8, sl, fp, sp, lr}
 490:	00000300 	andeq	r0, r0, r0, lsl #6
 494:	636f7270 	cmnvs	pc, #112, 4
 498:	2e737365 	cdpcs	3, 7, cr7, cr3, cr5, {3}
 49c:	00020068 	andeq	r0, r2, r8, rrx
 4a0:	6f727000 	svcvs	0x00727000
 4a4:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
 4a8:	6e616d5f 	mcrvs	13, 3, r6, cr1, cr15, {2}
 4ac:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
 4b0:	0200682e 	andeq	r6, r0, #3014656	; 0x2e0000
 4b4:	65700000 	ldrbvs	r0, [r0, #-0]!
 4b8:	68706972 	ldmdavs	r0!, {r1, r4, r5, r6, r8, fp, sp, lr}^
 4bc:	6c617265 	sfmvs	f7, 2, [r1], #-404	; 0xfffffe6c
 4c0:	00682e73 	rsbeq	r2, r8, r3, ror lr
 4c4:	67000004 	strvs	r0, [r0, -r4]
 4c8:	2e6f6970 			; <UNDEFINED> instruction: 0x2e6f6970
 4cc:	00050068 	andeq	r0, r5, r8, rrx
 4d0:	746e6900 	strbtvc	r6, [lr], #-2304	; 0xfffff700
 4d4:	2e666564 	cdpcs	5, 6, cr6, cr6, cr4, {3}
 4d8:	00040068 	andeq	r0, r4, r8, rrx
 4dc:	01050000 	mrseq	r0, (UNDEF: 5)
 4e0:	2c020500 	cfstr32cs	mvfx0, [r2], {-0}
 4e4:	03000082 	movweq	r0, #130	; 0x82
 4e8:	0705010e 	streq	r0, [r5, -lr, lsl #2]
 4ec:	21054b9f 			; <UNDEFINED> instruction: 0x21054b9f
 4f0:	8a09054c 	bhi	241a28 <__bss_end+0x238b20>
 4f4:	054b0705 	strbeq	r0, [fp, #-1797]	; 0xfffff8fb
 4f8:	0705a019 	smladeq	r5, r9, r0, sl
 4fc:	0e058786 	cdpeq	7, 0, cr8, cr5, cr6, {4}
 500:	2e0405a2 	cfsh32cs	mvfx0, mvfx4, #-46
 504:	a24c0a05 	subge	r0, ip, #20480	; 0x5000
 508:	05840d05 	streq	r0, [r4, #3333]	; 0xd05
 50c:	07054d08 	streq	r4, [r5, -r8, lsl #26]
 510:	02666c03 	rsbeq	r6, r6, #768	; 0x300
 514:	0101000a 	tsteq	r1, sl
 518:	000002c8 	andeq	r0, r0, r8, asr #5
 51c:	01dd0003 	bicseq	r0, sp, r3
 520:	01020000 	mrseq	r0, (UNDEF: 2)
 524:	000d0efb 	strdeq	r0, [sp], -fp
 528:	01010101 	tsteq	r1, r1, lsl #2
 52c:	01000000 	mrseq	r0, (UNDEF: 0)
 530:	2f010000 	svccs	0x00010000
 534:	72657355 	rsbvc	r7, r5, #1409286145	; 0x54000001
 538:	69772f73 	ldmdbvs	r7!, {r0, r1, r4, r5, r6, r8, r9, sl, fp, sp}^
 53c:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
 540:	442f696a 	strtmi	r6, [pc], #-2410	; 548 <shift+0x548>
 544:	746b7365 	strbtvc	r7, [fp], #-869	; 0xfffffc9b
 548:	462f706f 	strtmi	r7, [pc], -pc, rrx
 54c:	4e2f5641 	cfmadda32mi	mvax2, mvax5, mvfx15, mvfx1
 550:	7a617661 	bvc	185dedc <__bss_end+0x1854fd4>
 554:	63696a75 	cmnvs	r9, #479232	; 0x75000
 558:	534f2f69 	movtpl	r2, #65385	; 0xff69
 55c:	6d65732f 	stclvs	3, cr7, [r5, #-188]!	; 0xffffff44
 560:	72747365 	rsbsvc	r7, r4, #-1811939327	; 0x94000001
 564:	616b6c61 	cmnvs	fp, r1, ror #24
 568:	76696b2d 	strbtvc	r6, [r9], -sp, lsr #22
 56c:	2f736f2d 	svccs	0x00736f2d
 570:	72756f73 	rsbsvc	r6, r5, #460	; 0x1cc
 574:	2f736563 	svccs	0x00736563
 578:	6c647473 	cfstrdvs	mvd7, [r4], #-460	; 0xfffffe34
 57c:	732f6269 			; <UNDEFINED> instruction: 0x732f6269
 580:	2f006372 	svccs	0x00006372
 584:	72657355 	rsbvc	r7, r5, #1409286145	; 0x54000001
 588:	69772f73 	ldmdbvs	r7!, {r0, r1, r4, r5, r6, r8, r9, sl, fp, sp}^
 58c:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
 590:	442f696a 	strtmi	r6, [pc], #-2410	; 598 <shift+0x598>
 594:	746b7365 	strbtvc	r7, [fp], #-869	; 0xfffffc9b
 598:	462f706f 	strtmi	r7, [pc], -pc, rrx
 59c:	4e2f5641 	cfmadda32mi	mvax2, mvax5, mvfx15, mvfx1
 5a0:	7a617661 	bvc	185df2c <__bss_end+0x1855024>
 5a4:	63696a75 	cmnvs	r9, #479232	; 0x75000
 5a8:	534f2f69 	movtpl	r2, #65385	; 0xff69
 5ac:	6d65732f 	stclvs	3, cr7, [r5, #-188]!	; 0xffffff44
 5b0:	72747365 	rsbsvc	r7, r4, #-1811939327	; 0x94000001
 5b4:	616b6c61 	cmnvs	fp, r1, ror #24
 5b8:	76696b2d 	strbtvc	r6, [r9], -sp, lsr #22
 5bc:	2f736f2d 	svccs	0x00736f2d
 5c0:	72756f73 	rsbsvc	r6, r5, #460	; 0x1cc
 5c4:	2f736563 	svccs	0x00736563
 5c8:	6e72656b 	cdpvs	5, 7, cr6, cr2, cr11, {3}
 5cc:	692f6c65 	stmdbvs	pc!, {r0, r2, r5, r6, sl, fp, sp, lr}	; <UNPREDICTABLE>
 5d0:	756c636e 	strbvc	r6, [ip, #-878]!	; 0xfffffc92
 5d4:	702f6564 	eorvc	r6, pc, r4, ror #10
 5d8:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
 5dc:	2f007373 	svccs	0x00007373
 5e0:	72657355 	rsbvc	r7, r5, #1409286145	; 0x54000001
 5e4:	69772f73 	ldmdbvs	r7!, {r0, r1, r4, r5, r6, r8, r9, sl, fp, sp}^
 5e8:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
 5ec:	442f696a 	strtmi	r6, [pc], #-2410	; 5f4 <shift+0x5f4>
 5f0:	746b7365 	strbtvc	r7, [fp], #-869	; 0xfffffc9b
 5f4:	462f706f 	strtmi	r7, [pc], -pc, rrx
 5f8:	4e2f5641 	cfmadda32mi	mvax2, mvax5, mvfx15, mvfx1
 5fc:	7a617661 	bvc	185df88 <__bss_end+0x1855080>
 600:	63696a75 	cmnvs	r9, #479232	; 0x75000
 604:	534f2f69 	movtpl	r2, #65385	; 0xff69
 608:	6d65732f 	stclvs	3, cr7, [r5, #-188]!	; 0xffffff44
 60c:	72747365 	rsbsvc	r7, r4, #-1811939327	; 0x94000001
 610:	616b6c61 	cmnvs	fp, r1, ror #24
 614:	76696b2d 	strbtvc	r6, [r9], -sp, lsr #22
 618:	2f736f2d 	svccs	0x00736f2d
 61c:	72756f73 	rsbsvc	r6, r5, #460	; 0x1cc
 620:	2f736563 	svccs	0x00736563
 624:	6e72656b 	cdpvs	5, 7, cr6, cr2, cr11, {3}
 628:	692f6c65 	stmdbvs	pc!, {r0, r2, r5, r6, sl, fp, sp, lr}	; <UNPREDICTABLE>
 62c:	756c636e 	strbvc	r6, [ip, #-878]!	; 0xfffffc92
 630:	662f6564 	strtvs	r6, [pc], -r4, ror #10
 634:	552f0073 	strpl	r0, [pc, #-115]!	; 5c9 <shift+0x5c9>
 638:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 63c:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 640:	6a726574 	bvs	1c99c18 <__bss_end+0x1c90d10>
 644:	65442f69 	strbvs	r2, [r4, #-3945]	; 0xfffff097
 648:	6f746b73 	svcvs	0x00746b73
 64c:	41462f70 	hvcmi	25328	; 0x62f0
 650:	614e2f56 	cmpvs	lr, r6, asr pc
 654:	757a6176 	ldrbvc	r6, [sl, #-374]!	; 0xfffffe8a
 658:	6963696a 	stmdbvs	r3!, {r1, r3, r5, r6, r8, fp, sp, lr}^
 65c:	2f534f2f 	svccs	0x00534f2f
 660:	656d6573 	strbvs	r6, [sp, #-1395]!	; 0xfffffa8d
 664:	61727473 	cmnvs	r2, r3, ror r4
 668:	2d616b6c 	vstmdbcs	r1!, {d22-<overflow reg d75>}
 66c:	2d76696b 			; <UNDEFINED> instruction: 0x2d76696b
 670:	732f736f 			; <UNDEFINED> instruction: 0x732f736f
 674:	6372756f 	cmnvs	r2, #465567744	; 0x1bc00000
 678:	6b2f7365 	blvs	bdd414 <__bss_end+0xbd450c>
 67c:	656e7265 	strbvs	r7, [lr, #-613]!	; 0xfffffd9b
 680:	6e692f6c 	cdpvs	15, 6, cr2, cr9, cr12, {3}
 684:	64756c63 	ldrbtvs	r6, [r5], #-3171	; 0xfffff39d
 688:	6f622f65 	svcvs	0x00622f65
 68c:	2f647261 	svccs	0x00647261
 690:	30697072 	rsbcc	r7, r9, r2, ror r0
 694:	6c61682f 	stclvs	8, cr6, [r1], #-188	; 0xffffff44
 698:	74730000 	ldrbtvc	r0, [r3], #-0
 69c:	6c696664 	stclvs	6, cr6, [r9], #-400	; 0xfffffe70
 6a0:	70632e65 	rsbvc	r2, r3, r5, ror #28
 6a4:	00010070 	andeq	r0, r1, r0, ror r0
 6a8:	69777300 	ldmdbvs	r7!, {r8, r9, ip, sp, lr}^
 6ac:	0200682e 	andeq	r6, r0, #3014656	; 0x2e0000
 6b0:	70730000 	rsbsvc	r0, r3, r0
 6b4:	6f6c6e69 	svcvs	0x006c6e69
 6b8:	682e6b63 	stmdavs	lr!, {r0, r1, r5, r6, r8, r9, fp, sp, lr}
 6bc:	00000200 	andeq	r0, r0, r0, lsl #4
 6c0:	656c6966 	strbvs	r6, [ip, #-2406]!	; 0xfffff69a
 6c4:	74737973 	ldrbtvc	r7, [r3], #-2419	; 0xfffff68d
 6c8:	682e6d65 	stmdavs	lr!, {r0, r2, r5, r6, r8, sl, fp, sp, lr}
 6cc:	00000300 	andeq	r0, r0, r0, lsl #6
 6d0:	636f7270 	cmnvs	pc, #112, 4
 6d4:	2e737365 	cdpcs	3, 7, cr7, cr3, cr5, {3}
 6d8:	00020068 	andeq	r0, r2, r8, rrx
 6dc:	6f727000 	svcvs	0x00727000
 6e0:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
 6e4:	6e616d5f 	mcrvs	13, 3, r6, cr1, cr15, {2}
 6e8:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
 6ec:	0200682e 	andeq	r6, r0, #3014656	; 0x2e0000
 6f0:	6e690000 	cdpvs	0, 6, cr0, cr9, cr0, {0}
 6f4:	66656474 			; <UNDEFINED> instruction: 0x66656474
 6f8:	0400682e 	streq	r6, [r0], #-2094	; 0xfffff7d2
 6fc:	05000000 	streq	r0, [r0, #-0]
 700:	02050001 	andeq	r0, r5, #1
 704:	00008308 	andeq	r8, r0, r8, lsl #6
 708:	69050516 	stmdbvs	r5, {r1, r2, r4, r8, sl}
 70c:	4c0c052f 	cfstr32mi	mvfx0, [ip], {47}	; 0x2f
 710:	852f0105 	strhi	r0, [pc, #-261]!	; 613 <shift+0x613>
 714:	4b830505 	blmi	fe0c1b30 <__bss_end+0xfe0b8c28>
 718:	852f0105 	strhi	r0, [pc, #-261]!	; 61b <shift+0x61b>
 71c:	054b0505 	strbeq	r0, [fp, #-1285]	; 0xfffffafb
 720:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 724:	4b4ba105 	blmi	12e8b40 <__bss_end+0x12dfc38>
 728:	4c0c052f 	cfstr32mi	mvfx0, [ip], {47}	; 0x2f
 72c:	852f0105 	strhi	r0, [pc, #-261]!	; 62f <shift+0x62f>
 730:	4bbd0505 	blmi	fef41b4c <__bss_end+0xfef38c44>
 734:	052f4b4b 	streq	r4, [pc, #-2891]!	; fffffbf1 <__bss_end+0xffff6ce9>
 738:	01054c0c 	tsteq	r5, ip, lsl #24
 73c:	0505852f 	streq	r8, [r5, #-1327]	; 0xfffffad1
 740:	4b4b4bbd 	blmi	12d363c <__bss_end+0x12ca734>
 744:	4c0c052f 	cfstr32mi	mvfx0, [ip], {47}	; 0x2f
 748:	852f0105 	strhi	r0, [pc, #-261]!	; 64b <shift+0x64b>
 74c:	4b830505 	blmi	fe0c1b68 <__bss_end+0xfe0b8c60>
 750:	852f0105 	strhi	r0, [pc, #-261]!	; 653 <shift+0x653>
 754:	4bbd0505 	blmi	fef41b70 <__bss_end+0xfef38c68>
 758:	052f4b4b 	streq	r4, [pc, #-2891]!	; fffffc15 <__bss_end+0xffff6d0d>
 75c:	01054c0c 	tsteq	r5, ip, lsl #24
 760:	0505852f 	streq	r8, [r5, #-1327]	; 0xfffffad1
 764:	2f4b4ba1 	svccs	0x004b4ba1
 768:	054c0c05 	strbeq	r0, [ip, #-3077]	; 0xfffff3fb
 76c:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 770:	4b4bbd05 	blmi	12efb8c <__bss_end+0x12e6c84>
 774:	0c052f4b 	stceq	15, cr2, [r5], {75}	; 0x4b
 778:	2f01054c 	svccs	0x0001054c
 77c:	a1050585 	smlabbge	r5, r5, r5, r0
 780:	052f4b4b 	streq	r4, [pc, #-2891]!	; fffffc3d <__bss_end+0xffff6d35>
 784:	01054c0c 	tsteq	r5, ip, lsl #24
 788:	2005859f 	mulcs	r5, pc, r5	; <UNPREDICTABLE>
 78c:	4d050567 	cfstr32mi	mvfx0, [r5, #-412]	; 0xfffffe64
 790:	0c054b4b 			; <UNDEFINED> instruction: 0x0c054b4b
 794:	2f010530 	svccs	0x00010530
 798:	67200585 	strvs	r0, [r0, -r5, lsl #11]!
 79c:	4b4d0505 	blmi	1341bb8 <__bss_end+0x1338cb0>
 7a0:	300c054b 	andcc	r0, ip, fp, asr #10
 7a4:	852f0105 	strhi	r0, [pc, #-261]!	; 6a7 <shift+0x6a7>
 7a8:	05832005 	streq	r2, [r3, #5]
 7ac:	4b4b4c05 	blmi	12d37c8 <__bss_end+0x12ca8c0>
 7b0:	852f0105 	strhi	r0, [pc, #-261]!	; 6b3 <shift+0x6b3>
 7b4:	05672005 	strbeq	r2, [r7, #-5]!
 7b8:	4b4b4d05 	blmi	12d3bd4 <__bss_end+0x12caccc>
 7bc:	05300c05 	ldreq	r0, [r0, #-3077]!	; 0xfffff3fb
 7c0:	05872f01 	streq	r2, [r7, #3841]	; 0xf01
 7c4:	059fa00c 	ldreq	sl, [pc, #12]	; 7d8 <shift+0x7d8>
 7c8:	2905bc31 	stmdbcs	r5, {r0, r4, r5, sl, fp, ip, sp, pc}
 7cc:	2e360566 	cdpcs	5, 3, cr0, cr6, cr6, {3}
 7d0:	05300f05 	ldreq	r0, [r0, #-3845]!	; 0xfffff0fb
 7d4:	09056613 	stmdbeq	r5, {r0, r1, r4, r9, sl, sp, lr}
 7d8:	d8100584 	ldmdale	r0, {r2, r7, r8, sl}
 7dc:	029f0105 	addseq	r0, pc, #1073741825	; 0x40000001
 7e0:	01010008 	tsteq	r1, r8
 7e4:	0000029b 	muleq	r0, fp, r2
 7e8:	00740003 	rsbseq	r0, r4, r3
 7ec:	01020000 	mrseq	r0, (UNDEF: 2)
 7f0:	000d0efb 	strdeq	r0, [sp], -fp
 7f4:	01010101 	tsteq	r1, r1, lsl #2
 7f8:	01000000 	mrseq	r0, (UNDEF: 0)
 7fc:	2f010000 	svccs	0x00010000
 800:	72657355 	rsbvc	r7, r5, #1409286145	; 0x54000001
 804:	69772f73 	ldmdbvs	r7!, {r0, r1, r4, r5, r6, r8, r9, sl, fp, sp}^
 808:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
 80c:	442f696a 	strtmi	r6, [pc], #-2410	; 814 <shift+0x814>
 810:	746b7365 	strbtvc	r7, [fp], #-869	; 0xfffffc9b
 814:	462f706f 	strtmi	r7, [pc], -pc, rrx
 818:	4e2f5641 	cfmadda32mi	mvax2, mvax5, mvfx15, mvfx1
 81c:	7a617661 	bvc	185e1a8 <__bss_end+0x18552a0>
 820:	63696a75 	cmnvs	r9, #479232	; 0x75000
 824:	534f2f69 	movtpl	r2, #65385	; 0xff69
 828:	6d65732f 	stclvs	3, cr7, [r5, #-188]!	; 0xffffff44
 82c:	72747365 	rsbsvc	r7, r4, #-1811939327	; 0x94000001
 830:	616b6c61 	cmnvs	fp, r1, ror #24
 834:	76696b2d 	strbtvc	r6, [r9], -sp, lsr #22
 838:	2f736f2d 	svccs	0x00736f2d
 83c:	72756f73 	rsbsvc	r6, r5, #460	; 0x1cc
 840:	2f736563 	svccs	0x00736563
 844:	6c647473 	cfstrdvs	mvd7, [r4], #-460	; 0xfffffe34
 848:	732f6269 			; <UNDEFINED> instruction: 0x732f6269
 84c:	00006372 	andeq	r6, r0, r2, ror r3
 850:	73647473 	cmnvc	r4, #1929379840	; 0x73000000
 854:	6e697274 	mcrvs	2, 3, r7, cr9, cr4, {3}
 858:	70632e67 	rsbvc	r2, r3, r7, ror #28
 85c:	00010070 	andeq	r0, r1, r0, ror r0
 860:	01050000 	mrseq	r0, (UNDEF: 5)
 864:	64020500 	strvs	r0, [r2], #-1280	; 0xfffffb00
 868:	1a000087 	bne	a8c <shift+0xa8c>
 86c:	05bb0605 	ldreq	r0, [fp, #1541]!	; 0x605
 870:	21054c0f 	tstcs	r5, pc, lsl #24
 874:	ba0a0568 	blt	281e1c <__bss_end+0x278f14>
 878:	052e0b05 	streq	r0, [lr, #-2821]!	; 0xfffff4fb
 87c:	0d054a27 	vstreq	s8, [r5, #-156]	; 0xffffff64
 880:	2f09054a 	svccs	0x0009054a
 884:	059f0405 	ldreq	r0, [pc, #1029]	; c91 <shift+0xc91>
 888:	05056202 	streq	r6, [r5, #-514]	; 0xfffffdfe
 88c:	68100535 	ldmdavs	r0, {r0, r2, r4, r5, r8, sl}
 890:	052e1105 	streq	r1, [lr, #-261]!	; 0xfffffefb
 894:	13054a22 	movwne	r4, #23074	; 0x5a22
 898:	2f0a052e 	svccs	0x000a052e
 89c:	05690905 	strbeq	r0, [r9, #-2309]!	; 0xfffff6fb
 8a0:	0c052e0a 	stceq	14, cr2, [r5], {10}
 8a4:	4b03054a 	blmi	c1dd4 <__bss_end+0xb8ecc>
 8a8:	05680b05 	strbeq	r0, [r8, #-2821]!	; 0xfffff4fb
 8ac:	04020018 	streq	r0, [r2], #-24	; 0xffffffe8
 8b0:	14054a03 	strne	r4, [r5], #-2563	; 0xfffff5fd
 8b4:	03040200 	movweq	r0, #16896	; 0x4200
 8b8:	0015059e 	mulseq	r5, lr, r5
 8bc:	68020402 	stmdavs	r2, {r1, sl}
 8c0:	02001805 	andeq	r1, r0, #327680	; 0x50000
 8c4:	05820204 	streq	r0, [r2, #516]	; 0x204
 8c8:	04020008 	streq	r0, [r2], #-8
 8cc:	1a054a02 	bne	1530dc <__bss_end+0x14a1d4>
 8d0:	02040200 	andeq	r0, r4, #0, 4
 8d4:	001b054b 	andseq	r0, fp, fp, asr #10
 8d8:	2e020402 	cdpcs	4, 0, cr0, cr2, cr2, {0}
 8dc:	02000c05 	andeq	r0, r0, #1280	; 0x500
 8e0:	054a0204 	strbeq	r0, [sl, #-516]	; 0xfffffdfc
 8e4:	0402000f 	streq	r0, [r2], #-15
 8e8:	1b058202 	blne	1610f8 <__bss_end+0x1581f0>
 8ec:	02040200 	andeq	r0, r4, #0, 4
 8f0:	0011054a 	andseq	r0, r1, sl, asr #10
 8f4:	2e020402 	cdpcs	4, 0, cr0, cr2, cr2, {0}
 8f8:	02000a05 	andeq	r0, r0, #20480	; 0x5000
 8fc:	052f0204 	streq	r0, [pc, #-516]!	; 700 <shift+0x700>
 900:	0402000b 	streq	r0, [r2], #-11
 904:	0d052e02 	stceq	14, cr2, [r5, #-8]
 908:	02040200 	andeq	r0, r4, #0, 4
 90c:	0002054a 	andeq	r0, r2, sl, asr #10
 910:	46020402 	strmi	r0, [r2], -r2, lsl #8
 914:	85880105 	strhi	r0, [r8, #261]	; 0x105
 918:	05830605 	streq	r0, [r3, #1541]	; 0x605
 91c:	10054c09 	andne	r4, r5, r9, lsl #24
 920:	4c0a054a 	cfstr32mi	mvfx0, [sl], {74}	; 0x4a
 924:	05bb0705 	ldreq	r0, [fp, #1797]!	; 0x705
 928:	17054a03 	strne	r4, [r5, -r3, lsl #20]
 92c:	01040200 	mrseq	r0, R12_usr
 930:	0014054a 	andseq	r0, r4, sl, asr #10
 934:	4a010402 	bmi	41944 <__bss_end+0x38a3c>
 938:	054d0d05 	strbeq	r0, [sp, #-3333]	; 0xfffff2fb
 93c:	0a054a14 	beq	153194 <__bss_end+0x14a28c>
 940:	6808052e 	stmdavs	r8, {r1, r2, r3, r5, r8, sl}
 944:	78030205 	stmdavc	r3, {r0, r2, r9}
 948:	03090566 	movweq	r0, #38246	; 0x9566
 94c:	01052e0b 	tsteq	r5, fp, lsl #28
 950:	0905852f 	stmdbeq	r5, {r0, r1, r2, r3, r5, r8, sl, pc}
 954:	001605bd 			; <UNDEFINED> instruction: 0x001605bd
 958:	4a040402 	bmi	101968 <__bss_end+0xf8a60>
 95c:	02001d05 	andeq	r1, r0, #320	; 0x140
 960:	05820204 	streq	r0, [r2, #516]	; 0x204
 964:	0402001e 	streq	r0, [r2], #-30	; 0xffffffe2
 968:	16052e02 	strne	r2, [r5], -r2, lsl #28
 96c:	02040200 	andeq	r0, r4, #0, 4
 970:	00110566 	andseq	r0, r1, r6, ror #10
 974:	4b030402 	blmi	c1984 <__bss_end+0xb8a7c>
 978:	02001205 	andeq	r1, r0, #1342177280	; 0x50000000
 97c:	052e0304 	streq	r0, [lr, #-772]!	; 0xfffffcfc
 980:	04020008 	streq	r0, [r2], #-8
 984:	09054a03 	stmdbeq	r5, {r0, r1, r9, fp, lr}
 988:	03040200 	movweq	r0, #16896	; 0x4200
 98c:	0012052e 	andseq	r0, r2, lr, lsr #10
 990:	4a030402 	bmi	c19a0 <__bss_end+0xb8a98>
 994:	02000b05 	andeq	r0, r0, #5120	; 0x1400
 998:	052e0304 	streq	r0, [lr, #-772]!	; 0xfffffcfc
 99c:	04020002 	streq	r0, [r2], #-2
 9a0:	0b052d03 	bleq	14bdb4 <__bss_end+0x142eac>
 9a4:	02040200 	andeq	r0, r4, #0, 4
 9a8:	00080584 	andeq	r0, r8, r4, lsl #11
 9ac:	83010402 	movwhi	r0, #5122	; 0x1402
 9b0:	02000905 	andeq	r0, r0, #81920	; 0x14000
 9b4:	052e0104 	streq	r0, [lr, #-260]!	; 0xfffffefc
 9b8:	0402000b 	streq	r0, [r2], #-11
 9bc:	02054a01 	andeq	r4, r5, #4096	; 0x1000
 9c0:	01040200 	mrseq	r0, R12_usr
 9c4:	850b0549 	strhi	r0, [fp, #-1353]	; 0xfffffab7
 9c8:	852f0105 	strhi	r0, [pc, #-261]!	; 8cb <shift+0x8cb>
 9cc:	05bc0e05 	ldreq	r0, [ip, #3589]!	; 0xe05
 9d0:	20056611 	andcs	r6, r5, r1, lsl r6
 9d4:	660b05bc 			; <UNDEFINED> instruction: 0x660b05bc
 9d8:	054b1f05 	strbeq	r1, [fp, #-3845]	; 0xfffff0fb
 9dc:	0805660a 	stmdaeq	r5, {r1, r3, r9, sl, sp, lr}
 9e0:	8311054b 	tsthi	r1, #314572800	; 0x12c00000
 9e4:	052e1605 	streq	r1, [lr, #-1541]!	; 0xfffff9fb
 9e8:	11056708 	tstne	r5, r8, lsl #14
 9ec:	4d0b0567 	cfstr32mi	mvfx0, [fp, #-412]	; 0xfffffe64
 9f0:	852f0105 	strhi	r0, [pc, #-261]!	; 8f3 <shift+0x8f3>
 9f4:	05830605 	streq	r0, [r3, #1541]	; 0x605
 9f8:	0c054c0b 	stceq	12, cr4, [r5], {11}
 9fc:	660e052e 	strvs	r0, [lr], -lr, lsr #10
 a00:	054b0405 	strbeq	r0, [fp, #-1029]	; 0xfffffbfb
 a04:	09056502 	stmdbeq	r5, {r1, r8, sl, sp, lr}
 a08:	2f010531 	svccs	0x00010531
 a0c:	9f080585 	svcls	0x00080585
 a10:	054c0b05 	strbeq	r0, [ip, #-2821]	; 0xfffff4fb
 a14:	04020014 	streq	r0, [r2], #-20	; 0xffffffec
 a18:	07054a03 	streq	r4, [r5, -r3, lsl #20]
 a1c:	02040200 	andeq	r0, r4, #0, 4
 a20:	00080583 	andeq	r0, r8, r3, lsl #11
 a24:	2e020402 	cdpcs	4, 0, cr0, cr2, cr2, {0}
 a28:	02000a05 	andeq	r0, r0, #20480	; 0x5000
 a2c:	054a0204 	strbeq	r0, [sl, #-516]	; 0xfffffdfc
 a30:	04020002 	streq	r0, [r2], #-2
 a34:	01054902 	tsteq	r5, r2, lsl #18
 a38:	0e058584 	cfsh32eq	mvfx8, mvfx5, #-60
 a3c:	4b0805bb 	blmi	202130 <__bss_end+0x1f9228>
 a40:	054c0b05 	strbeq	r0, [ip, #-2821]	; 0xfffff4fb
 a44:	04020014 	streq	r0, [r2], #-20	; 0xffffffec
 a48:	16054a03 	strne	r4, [r5], -r3, lsl #20
 a4c:	02040200 	andeq	r0, r4, #0, 4
 a50:	00170583 	andseq	r0, r7, r3, lsl #11
 a54:	2e020402 	cdpcs	4, 0, cr0, cr2, cr2, {0}
 a58:	02000a05 	andeq	r0, r0, #20480	; 0x5000
 a5c:	054a0204 	strbeq	r0, [sl, #-516]	; 0xfffffdfc
 a60:	0402000b 	streq	r0, [r2], #-11
 a64:	17052e02 	strne	r2, [r5, -r2, lsl #28]
 a68:	02040200 	andeq	r0, r4, #0, 4
 a6c:	000d054a 	andeq	r0, sp, sl, asr #10
 a70:	2e020402 	cdpcs	4, 0, cr0, cr2, cr2, {0}
 a74:	02000205 	andeq	r0, r0, #1342177280	; 0x50000000
 a78:	052d0204 	streq	r0, [sp, #-516]!	; 0xfffffdfc
 a7c:	08028401 	stmdaeq	r2, {r0, sl, pc}
 a80:	Address 0x0000000000000a80 is out of bounds.


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
      58:	074c0704 	strbeq	r0, [ip, -r4, lsl #14]
      5c:	5b020000 	blpl	80064 <__bss_end+0x7715c>
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
     128:	0000074c 	andeq	r0, r0, ip, asr #14
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
     174:	cb104801 	blgt	412180 <__bss_end+0x409278>
     178:	d4000000 	strle	r0, [r0], #-0
     17c:	58000081 	stmdapl	r0, {r0, r7}
     180:	01000000 	mrseq	r0, (UNDEF: 0)
     184:	0000cb9c 	muleq	r0, ip, fp
     188:	02b40a00 	adcseq	r0, r4, #0, 20
     18c:	4a010000 	bmi	40194 <__bss_end+0x3728c>
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
     21c:	ba0d9c01 	blt	367228 <__bss_end+0x35e320>
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
     24c:	8b120f01 	blhi	483e58 <__bss_end+0x47af50>
     250:	0f000001 	svceq	0x00000001
     254:	0000019e 	muleq	r0, lr, r1
     258:	03d51000 	bicseq	r1, r5, #0
     25c:	0a010000 	beq	40264 <__bss_end+0x3735c>
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
     2b4:	8b140074 	blhi	50048c <__bss_end+0x4f7584>
     2b8:	a4000001 	strge	r0, [r0], #-1
     2bc:	38000080 	stmdacc	r0, {r7}
     2c0:	01000000 	mrseq	r0, (UNDEF: 0)
     2c4:	0067139c 	mlseq	r7, ip, r3, r1
     2c8:	9e2f0a01 	vmulls.f32	s0, s30, s2
     2cc:	02000001 	andeq	r0, r0, #1
     2d0:	00007491 	muleq	r0, r1, r4
     2d4:	00000821 	andeq	r0, r0, r1, lsr #16
     2d8:	01e00004 	mvneq	r0, r4
     2dc:	01040000 	mrseq	r0, (UNDEF: 4)
     2e0:	000001e1 	andeq	r0, r0, r1, ror #3
     2e4:	00078b04 	andeq	r8, r7, r4, lsl #22
     2e8:	00005600 	andeq	r5, r0, r0, lsl #12
     2ec:	00822c00 	addeq	r2, r2, r0, lsl #24
     2f0:	0000dc00 	andeq	sp, r0, r0, lsl #24
     2f4:	00024600 	andeq	r4, r2, r0, lsl #12
     2f8:	08010200 	stmdaeq	r1, {r9}
     2fc:	000009c5 	andeq	r0, r0, r5, asr #19
     300:	ff050202 			; <UNDEFINED> instruction: 0xff050202
     304:	03000009 	movweq	r0, #9
     308:	6e690504 	cdpvs	5, 6, cr0, cr9, cr4, {0}
     30c:	01020074 	tsteq	r2, r4, ror r0
     310:	0009bc08 	andeq	fp, r9, r8, lsl #24
     314:	07020200 	streq	r0, [r2, -r0, lsl #4]
     318:	00000800 	andeq	r0, r0, r0, lsl #16
     31c:	000a4804 	andeq	r4, sl, r4, lsl #16
     320:	07090900 	streq	r0, [r9, -r0, lsl #18]
     324:	00000059 	andeq	r0, r0, r9, asr r0
     328:	00004805 	andeq	r4, r0, r5, lsl #16
     32c:	07040200 	streq	r0, [r4, -r0, lsl #4]
     330:	0000074c 	andeq	r0, r0, ip, asr #14
     334:	00005905 	andeq	r5, r0, r5, lsl #18
     338:	06170600 	ldreq	r0, [r7], -r0, lsl #12
     33c:	02080000 	andeq	r0, r8, #0
     340:	008b0806 	addeq	r0, fp, r6, lsl #16
     344:	72070000 	andvc	r0, r7, #0
     348:	08020030 	stmdaeq	r2, {r4, r5}
     34c:	0000480e 	andeq	r4, r0, lr, lsl #16
     350:	72070000 	andvc	r0, r7, #0
     354:	09020031 	stmdbeq	r2, {r0, r4, r5}
     358:	0000480e 	andeq	r4, r0, lr, lsl #16
     35c:	08000400 	stmdaeq	r0, {sl}
     360:	000004f8 	strdeq	r0, [r0], -r8
     364:	00330405 	eorseq	r0, r3, r5, lsl #8
     368:	1e020000 	cdpne	0, 0, cr0, cr2, cr0, {0}
     36c:	0000c20c 	andeq	ip, r0, ip, lsl #4
     370:	068b0900 	streq	r0, [fp], r0, lsl #18
     374:	09000000 	stmdbeq	r0, {}	; <UNPREDICTABLE>
     378:	00000c7e 	andeq	r0, r0, lr, ror ip
     37c:	0c5e0901 	mrrceq	9, 0, r0, lr, cr1	; <UNPREDICTABLE>
     380:	09020000 	stmdbeq	r2, {}	; <UNPREDICTABLE>
     384:	0000084b 	andeq	r0, r0, fp, asr #16
     388:	09400903 	stmdbeq	r0, {r0, r1, r8, fp}^
     38c:	09040000 	stmdbeq	r4, {}	; <UNPREDICTABLE>
     390:	00000654 	andeq	r0, r0, r4, asr r6
     394:	06080005 	streq	r0, [r8], -r5
     398:	0500000c 	streq	r0, [r0, #-12]
     39c:	00003304 	andeq	r3, r0, r4, lsl #6
     3a0:	0c3f0200 	lfmeq	f0, 4, [pc], #-0	; 3a8 <shift+0x3a8>
     3a4:	000000ff 	strdeq	r0, [r0], -pc	; <UNPREDICTABLE>
     3a8:	0003ff09 	andeq	pc, r3, r9, lsl #30
     3ac:	0d090000 	stceq	0, cr0, [r9, #-0]
     3b0:	01000005 	tsteq	r0, r5
     3b4:	00093309 	andeq	r3, r9, r9, lsl #6
     3b8:	43090200 	movwmi	r0, #37376	; 0x9200
     3bc:	0300000c 	movweq	r0, #12
     3c0:	000c8809 	andeq	r8, ip, r9, lsl #16
     3c4:	fa090400 	blx	2413cc <__bss_end+0x2384c4>
     3c8:	05000008 	streq	r0, [r0, #-8]
     3cc:	00082009 	andeq	r2, r8, r9
     3d0:	08000600 	stmdaeq	r0, {r9, sl}
     3d4:	00000bc0 	andeq	r0, r0, r0, asr #23
     3d8:	00330405 	eorseq	r0, r3, r5, lsl #8
     3dc:	66020000 	strvs	r0, [r2], -r0
     3e0:	00012a0c 	andeq	r2, r1, ip, lsl #20
     3e4:	09a30900 	stmibeq	r3!, {r8, fp}
     3e8:	09000000 	stmdbeq	r0, {}	; <UNPREDICTABLE>
     3ec:	00000780 	andeq	r0, r0, r0, lsl #15
     3f0:	0a090901 	beq	2427fc <__bss_end+0x2398f4>
     3f4:	09020000 	stmdbeq	r2, {}	; <UNPREDICTABLE>
     3f8:	00000825 	andeq	r0, r0, r5, lsr #16
     3fc:	140a0003 	strne	r0, [sl], #-3
     400:	03000009 	movweq	r0, #9
     404:	00541405 	subseq	r1, r4, r5, lsl #8
     408:	03050000 	movweq	r0, #20480	; 0x5000
     40c:	00008e2c 	andeq	r8, r0, ip, lsr #28
     410:	0009220a 	andeq	r2, r9, sl, lsl #4
     414:	14060300 	strne	r0, [r6], #-768	; 0xfffffd00
     418:	00000054 	andeq	r0, r0, r4, asr r0
     41c:	8e300305 	cdphi	3, 3, cr0, cr0, cr5, {0}
     420:	e40a0000 	str	r0, [sl], #-0
     424:	04000008 	streq	r0, [r0], #-8
     428:	00541a07 	subseq	r1, r4, r7, lsl #20
     42c:	03050000 	movweq	r0, #20480	; 0x5000
     430:	00008e34 	andeq	r8, r0, r4, lsr lr
     434:	0005360a 	andeq	r3, r5, sl, lsl #12
     438:	1a090400 	bne	241440 <__bss_end+0x238538>
     43c:	00000054 	andeq	r0, r0, r4, asr r0
     440:	8e380305 	cdphi	3, 3, cr0, cr8, cr5, {0}
     444:	ae0a0000 	cdpge	0, 0, cr0, cr10, cr0, {0}
     448:	04000009 	streq	r0, [r0], #-9
     44c:	00541a0b 	subseq	r1, r4, fp, lsl #20
     450:	03050000 	movweq	r0, #20480	; 0x5000
     454:	00008e3c 	andeq	r8, r0, ip, lsr lr
     458:	00076d0a 	andeq	r6, r7, sl, lsl #26
     45c:	1a0d0400 	bne	341464 <__bss_end+0x33855c>
     460:	00000054 	andeq	r0, r0, r4, asr r0
     464:	8e400305 	cdphi	3, 4, cr0, cr0, cr5, {0}
     468:	3d0a0000 	stccc	0, cr0, [sl, #-0]
     46c:	04000006 	streq	r0, [r0], #-6
     470:	00541a0f 	subseq	r1, r4, pc, lsl #20
     474:	03050000 	movweq	r0, #20480	; 0x5000
     478:	00008e44 	andeq	r8, r0, r4, asr #28
     47c:	00107208 	andseq	r7, r0, r8, lsl #4
     480:	33040500 	movwcc	r0, #17664	; 0x4500
     484:	04000000 	streq	r0, [r0], #-0
     488:	01cd0c1b 	biceq	r0, sp, fp, lsl ip
     48c:	85090000 	strhi	r0, [r9, #-0]
     490:	0000000a 	andeq	r0, r0, sl
     494:	000c4e09 	andeq	r4, ip, r9, lsl #28
     498:	2e090100 	adfcse	f0, f1, f0
     49c:	02000009 	andeq	r0, r0, #9
     4a0:	099d0b00 	ldmibeq	sp, {r8, r9, fp}
     4a4:	01020000 	mrseq	r0, (UNDEF: 2)
     4a8:	00085102 	andeq	r5, r8, r2, lsl #2
     4ac:	cd040c00 	stcgt	12, cr0, [r4, #-0]
     4b0:	0a000001 	beq	4bc <shift+0x4bc>
     4b4:	000006d3 	ldrdeq	r0, [r0], -r3
     4b8:	54140405 	ldrpl	r0, [r4], #-1029	; 0xfffffbfb
     4bc:	05000000 	streq	r0, [r0, #-0]
     4c0:	008e4803 	addeq	r4, lr, r3, lsl #16
     4c4:	03f40a00 	mvnseq	r0, #0, 20
     4c8:	07050000 	streq	r0, [r5, -r0]
     4cc:	00005414 	andeq	r5, r0, r4, lsl r4
     4d0:	4c030500 	cfstr32mi	mvfx0, [r3], {-0}
     4d4:	0a00008e 	beq	714 <shift+0x714>
     4d8:	00000564 	andeq	r0, r0, r4, ror #10
     4dc:	54140a05 	ldrpl	r0, [r4], #-2565	; 0xfffff5fb
     4e0:	05000000 	streq	r0, [r0, #-0]
     4e4:	008e5003 	addeq	r5, lr, r3
     4e8:	08860800 	stmeq	r6, {fp}
     4ec:	04050000 	streq	r0, [r5], #-0
     4f0:	00000033 	andeq	r0, r0, r3, lsr r0
     4f4:	4c0c0d05 	stcmi	13, cr0, [ip], {5}
     4f8:	0d000002 	stceq	0, cr0, [r0, #-8]
     4fc:	0077654e 	rsbseq	r6, r7, lr, asr #10
     500:	087d0900 	ldmdaeq	sp!, {r8, fp}^
     504:	09010000 	stmdbeq	r1, {}	; <UNPREDICTABLE>
     508:	00000a30 	andeq	r0, r0, r0, lsr sl
     50c:	08600902 	stmdaeq	r0!, {r1, r8, fp}^
     510:	09030000 	stmdbeq	r3, {}	; <UNPREDICTABLE>
     514:	0000083d 	andeq	r0, r0, sp, lsr r8
     518:	09390904 	ldmdbeq	r9!, {r2, r8, fp}
     51c:	00050000 	andeq	r0, r5, r0
     520:	00064706 	andeq	r4, r6, r6, lsl #14
     524:	1b051000 	blne	14452c <__bss_end+0x13b624>
     528:	00028b08 	andeq	r8, r2, r8, lsl #22
     52c:	726c0700 	rsbvc	r0, ip, #0, 14
     530:	131d0500 	tstne	sp, #0, 10
     534:	0000028b 	andeq	r0, r0, fp, lsl #5
     538:	70730700 	rsbsvc	r0, r3, r0, lsl #14
     53c:	131e0500 	tstne	lr, #0, 10
     540:	0000028b 	andeq	r0, r0, fp, lsl #5
     544:	63700704 	cmnvs	r0, #4, 14	; 0x100000
     548:	131f0500 	tstne	pc, #0, 10
     54c:	0000028b 	andeq	r0, r0, fp, lsl #5
     550:	065d0e08 	ldrbeq	r0, [sp], -r8, lsl #28
     554:	20050000 	andcs	r0, r5, r0
     558:	00028b13 	andeq	r8, r2, r3, lsl fp
     55c:	02000c00 	andeq	r0, r0, #0, 24
     560:	07470704 	strbeq	r0, [r7, -r4, lsl #14]
     564:	8b050000 	blhi	14056c <__bss_end+0x137664>
     568:	06000002 	streq	r0, [r0], -r2
     56c:	00000461 	andeq	r0, r0, r1, ror #8
     570:	08280570 	stmdaeq	r8!, {r4, r5, r6, r8, sl}
     574:	00000327 	andeq	r0, r0, r7, lsr #6
     578:	000a790e 	andeq	r7, sl, lr, lsl #18
     57c:	122a0500 	eorne	r0, sl, #0, 10
     580:	0000024c 	andeq	r0, r0, ip, asr #4
     584:	69700700 	ldmdbvs	r0!, {r8, r9, sl}^
     588:	2b050064 	blcs	140720 <__bss_end+0x137818>
     58c:	00005912 	andeq	r5, r0, r2, lsl r9
     590:	d40e1000 	strle	r1, [lr], #-0
     594:	05000004 	streq	r0, [r0, #-4]
     598:	0215112c 	andseq	r1, r5, #44, 2
     59c:	0e140000 	cdpeq	0, 1, cr0, cr4, cr0, {0}
     5a0:	00000892 	muleq	r0, r2, r8
     5a4:	59122d05 	ldmdbpl	r2, {r0, r2, r8, sl, fp, sp}
     5a8:	18000000 	stmdane	r0, {}	; <UNPREDICTABLE>
     5ac:	0008a00e 	andeq	sl, r8, lr
     5b0:	122e0500 	eorne	r0, lr, #0, 10
     5b4:	00000059 	andeq	r0, r0, r9, asr r0
     5b8:	06300e1c 			; <UNDEFINED> instruction: 0x06300e1c
     5bc:	2f050000 	svccs	0x00050000
     5c0:	0003270c 	andeq	r2, r3, ip, lsl #14
     5c4:	b60e2000 	strlt	r2, [lr], -r0
     5c8:	05000008 	streq	r0, [r0, #-8]
     5cc:	00330930 	eorseq	r0, r3, r0, lsr r9
     5d0:	0e600000 	cdpeq	0, 6, cr0, cr0, cr0, {0}
     5d4:	00000a8f 	andeq	r0, r0, pc, lsl #21
     5d8:	480e3105 	stmdami	lr, {r0, r2, r8, ip, sp}
     5dc:	64000000 	strvs	r0, [r0], #-0
     5e0:	0006a60e 	andeq	sl, r6, lr, lsl #12
     5e4:	0e330500 	cfabs32eq	mvfx0, mvfx3
     5e8:	00000048 	andeq	r0, r0, r8, asr #32
     5ec:	069d0e68 	ldreq	r0, [sp], r8, ror #28
     5f0:	34050000 	strcc	r0, [r5], #-0
     5f4:	0000480e 	andeq	r4, r0, lr, lsl #16
     5f8:	0f006c00 	svceq	0x00006c00
     5fc:	000001d9 	ldrdeq	r0, [r0], -r9
     600:	00000337 	andeq	r0, r0, r7, lsr r3
     604:	00005910 	andeq	r5, r0, r0, lsl r9
     608:	0a000f00 	beq	4210 <shift+0x4210>
     60c:	00000c1e 	andeq	r0, r0, lr, lsl ip
     610:	54140a06 	ldrpl	r0, [r4], #-2566	; 0xfffff5fa
     614:	05000000 	streq	r0, [r0, #-0]
     618:	008e5403 	addeq	r5, lr, r3, lsl #8
     61c:	08680800 	stmdaeq	r8!, {fp}^
     620:	04050000 	streq	r0, [r5], #-0
     624:	00000033 	andeq	r0, r0, r3, lsr r0
     628:	680c0d06 	stmdavs	ip, {r1, r2, r8, sl, fp}
     62c:	09000003 	stmdbeq	r0, {r0, r1}
     630:	00000512 	andeq	r0, r0, r2, lsl r5
     634:	03e90900 	mvneq	r0, #0, 18
     638:	00010000 	andeq	r0, r1, r0
     63c:	000b4a06 	andeq	r4, fp, r6, lsl #20
     640:	1b060c00 	blne	183648 <__bss_end+0x17a740>
     644:	00039d08 	andeq	r9, r3, r8, lsl #26
     648:	04330e00 	ldrteq	r0, [r3], #-3584	; 0xfffff200
     64c:	1d060000 	stcne	0, cr0, [r6, #-0]
     650:	00039d19 	andeq	r9, r3, r9, lsl sp
     654:	cc0e0000 	stcgt	0, cr0, [lr], {-0}
     658:	06000004 	streq	r0, [r0], -r4
     65c:	039d191e 	orrseq	r1, sp, #491520	; 0x78000
     660:	0e040000 	cdpeq	0, 0, cr0, cr4, cr0, {0}
     664:	00000b03 	andeq	r0, r0, r3, lsl #22
     668:	a3131f06 	tstge	r3, #6, 30
     66c:	08000003 	stmdaeq	r0, {r0, r1}
     670:	68040c00 	stmdavs	r4, {sl, fp}
     674:	0c000003 	stceq	0, cr0, [r0], {3}
     678:	00029704 	andeq	r9, r2, r4, lsl #14
     67c:	05771100 	ldrbeq	r1, [r7, #-256]!	; 0xffffff00
     680:	06140000 	ldreq	r0, [r4], -r0
     684:	062b0722 	strteq	r0, [fp], -r2, lsr #14
     688:	560e0000 	strpl	r0, [lr], -r0
     68c:	06000008 	streq	r0, [r0], -r8
     690:	00481226 	subeq	r1, r8, r6, lsr #4
     694:	0e000000 	cdpeq	0, 0, cr0, cr0, cr0, {0}
     698:	0000048b 	andeq	r0, r0, fp, lsl #9
     69c:	9d1d2906 	vldrls.16	s4, [sp, #-12]	; <UNPREDICTABLE>
     6a0:	04000003 	streq	r0, [r0], #-3
     6a4:	000a660e 	andeq	r6, sl, lr, lsl #12
     6a8:	1d2c0600 	stcne	6, cr0, [ip, #-0]
     6ac:	0000039d 	muleq	r0, sp, r3
     6b0:	0bfc1208 	bleq	fff04ed8 <__bss_end+0xffefbfd0>
     6b4:	2f060000 	svccs	0x00060000
     6b8:	000b270e 	andeq	r2, fp, lr, lsl #14
     6bc:	0003f100 	andeq	pc, r3, r0, lsl #2
     6c0:	0003fc00 	andeq	pc, r3, r0, lsl #24
     6c4:	06301300 	ldrteq	r1, [r0], -r0, lsl #6
     6c8:	9d140000 	ldcls	0, cr0, [r4, #-0]
     6cc:	00000003 	andeq	r0, r0, r3
     6d0:	000b0f15 	andeq	r0, fp, r5, lsl pc
     6d4:	0e310600 	cfmsuba32eq	mvax0, mvax0, mvfx1, mvfx0
     6d8:	00000438 	andeq	r0, r0, r8, lsr r4
     6dc:	000001d2 	ldrdeq	r0, [r0], -r2
     6e0:	00000414 	andeq	r0, r0, r4, lsl r4
     6e4:	0000041f 	andeq	r0, r0, pc, lsl r4
     6e8:	00063013 	andeq	r3, r6, r3, lsl r0
     6ec:	03a31400 			; <UNDEFINED> instruction: 0x03a31400
     6f0:	16000000 	strne	r0, [r0], -r0
     6f4:	00000b5d 	andeq	r0, r0, sp, asr fp
     6f8:	de1d3506 	cfmul32le	mvfx3, mvfx13, mvfx6
     6fc:	9d00000a 	stcls	0, cr0, [r0, #-40]	; 0xffffffd8
     700:	02000003 	andeq	r0, r0, #3
     704:	00000438 	andeq	r0, r0, r8, lsr r4
     708:	0000043e 	andeq	r0, r0, lr, lsr r4
     70c:	00063013 	andeq	r3, r6, r3, lsl r0
     710:	13160000 	tstne	r6, #0
     714:	06000008 	streq	r0, [r0], -r8
     718:	09ca1d37 	stmibeq	sl, {r0, r1, r2, r4, r5, r8, sl, fp, ip}^
     71c:	039d0000 	orrseq	r0, sp, #0
     720:	57020000 	strpl	r0, [r2, -r0]
     724:	5d000004 	stcpl	0, cr0, [r0, #-16]
     728:	13000004 	movwne	r0, #4
     72c:	00000630 	andeq	r0, r0, r0, lsr r6
     730:	08cc1700 	stmiaeq	ip, {r8, r9, sl, ip}^
     734:	39060000 	stmdbcc	r6, {}	; <UNPREDICTABLE>
     738:	00064931 	andeq	r4, r6, r1, lsr r9
     73c:	16020c00 	strne	r0, [r2], -r0, lsl #24
     740:	00000577 	andeq	r0, r0, r7, ror r5
     744:	64093c06 	strvs	r3, [r9], #-3078	; 0xfffff3fa
     748:	3000000c 	andcc	r0, r0, ip
     74c:	01000006 	tsteq	r0, r6
     750:	00000484 	andeq	r0, r0, r4, lsl #9
     754:	0000048a 	andeq	r0, r0, sl, lsl #9
     758:	00063013 	andeq	r3, r6, r3, lsl r0
     75c:	27160000 	ldrcs	r0, [r6, -r0]
     760:	06000005 	streq	r0, [r0], -r5
     764:	0bd1123f 	bleq	ff445068 <__bss_end+0xff43c160>
     768:	00480000 	subeq	r0, r8, r0
     76c:	a3010000 	movwge	r0, #4096	; 0x1000
     770:	b8000004 	stmdalt	r0, {r2}
     774:	13000004 	movwne	r0, #4
     778:	00000630 	andeq	r0, r0, r0, lsr r6
     77c:	00065214 	andeq	r5, r6, r4, lsl r2
     780:	00591400 	subseq	r1, r9, r0, lsl #8
     784:	d2140000 	andsle	r0, r4, #0
     788:	00000001 	andeq	r0, r0, r1
     78c:	000b1e18 	andeq	r1, fp, r8, lsl lr
     790:	0e420600 	cdpeq	6, 4, cr0, cr2, cr0, {0}
     794:	0000094f 	andeq	r0, r0, pc, asr #18
     798:	0004cd01 	andeq	ip, r4, r1, lsl #26
     79c:	0004d300 	andeq	sp, r4, r0, lsl #6
     7a0:	06301300 	ldrteq	r1, [r0], -r0, lsl #6
     7a4:	16000000 	strne	r0, [r0], -r0
     7a8:	00000733 	andeq	r0, r0, r3, lsr r7
     7ac:	9e174506 	cfmul32ls	mvfx4, mvfx7, mvfx6
     7b0:	a3000004 	movwge	r0, #4
     7b4:	01000003 	tsteq	r0, r3
     7b8:	000004ec 	andeq	r0, r0, ip, ror #9
     7bc:	000004f2 	strdeq	r0, [r0], -r2
     7c0:	00065813 	andeq	r5, r6, r3, lsl r8
     7c4:	da160000 	ble	5807cc <__bss_end+0x5778c4>
     7c8:	06000004 	streq	r0, [r0], -r4
     7cc:	0a9b1748 	beq	fe6c64f4 <__bss_end+0xfe6bd5ec>
     7d0:	03a30000 			; <UNDEFINED> instruction: 0x03a30000
     7d4:	0b010000 	bleq	407dc <__bss_end+0x378d4>
     7d8:	16000005 	strne	r0, [r0], -r5
     7dc:	13000005 	movwne	r0, #5
     7e0:	00000658 	andeq	r0, r0, r8, asr r6
     7e4:	00004814 	andeq	r4, r0, r4, lsl r8
     7e8:	2d180000 	ldccs	0, cr0, [r8, #-0]
     7ec:	0600000c 	streq	r0, [r0], -ip
     7f0:	04040e4b 	streq	r0, [r4], #-3659	; 0xfffff1b5
     7f4:	2b010000 	blcs	407fc <__bss_end+0x378f4>
     7f8:	31000005 	tstcc	r0, r5
     7fc:	13000005 	movwne	r0, #5
     800:	00000630 	andeq	r0, r0, r0, lsr r6
     804:	0b0f1600 	bleq	3c600c <__bss_end+0x3bd104>
     808:	4d060000 	stcmi	0, cr0, [r6, #-0]
     80c:	0006630e 	andeq	r6, r6, lr, lsl #6
     810:	0001d200 	andeq	sp, r1, r0, lsl #4
     814:	054a0100 	strbeq	r0, [sl, #-256]	; 0xffffff00
     818:	05550000 	ldrbeq	r0, [r5, #-0]
     81c:	30130000 	andscc	r0, r3, r0
     820:	14000006 	strne	r0, [r0], #-6
     824:	00000048 	andeq	r0, r0, r8, asr #32
     828:	07591600 	ldrbeq	r1, [r9, -r0, lsl #12]
     82c:	50060000 	andpl	r0, r6, r0
     830:	00097012 	andeq	r7, r9, r2, lsl r0
     834:	00004800 	andeq	r4, r0, r0, lsl #16
     838:	056e0100 	strbeq	r0, [lr, #-256]!	; 0xffffff00
     83c:	05790000 	ldrbeq	r0, [r9, #-0]!
     840:	30130000 	andscc	r0, r3, r0
     844:	14000006 	strne	r0, [r0], #-6
     848:	000001d9 	ldrdeq	r0, [r0], -r9
     84c:	046e1600 	strbteq	r1, [lr], #-1536	; 0xfffffa00
     850:	53060000 	movwpl	r0, #24576	; 0x6000
     854:	0006ec0e 	andeq	lr, r6, lr, lsl #24
     858:	0001d200 	andeq	sp, r1, r0, lsl #4
     85c:	05920100 	ldreq	r0, [r2, #256]	; 0x100
     860:	059d0000 	ldreq	r0, [sp]
     864:	30130000 	andscc	r0, r3, r0
     868:	14000006 	strne	r0, [r0], #-6
     86c:	00000048 	andeq	r0, r0, r8, asr #32
     870:	07ed1800 	strbeq	r1, [sp, r0, lsl #16]!
     874:	56060000 	strpl	r0, [r6], -r0
     878:	000b690e 	andeq	r6, fp, lr, lsl #18
     87c:	05b20100 	ldreq	r0, [r2, #256]!	; 0x100
     880:	05d10000 	ldrbeq	r0, [r1]
     884:	30130000 	andscc	r0, r3, r0
     888:	14000006 	strne	r0, [r0], #-6
     88c:	0000008b 	andeq	r0, r0, fp, lsl #1
     890:	00004814 	andeq	r4, r0, r4, lsl r8
     894:	00481400 	subeq	r1, r8, r0, lsl #8
     898:	48140000 	ldmdami	r4, {}	; <UNPREDICTABLE>
     89c:	14000000 	strne	r0, [r0], #-0
     8a0:	0000065e 	andeq	r0, r0, lr, asr r6
     8a4:	0ac81800 	beq	ff2068ac <__bss_end+0xff1fd9a4>
     8a8:	58060000 	stmdapl	r6, {}	; <UNPREDICTABLE>
     8ac:	0005cb0e 	andeq	ip, r5, lr, lsl #22
     8b0:	05e60100 	strbeq	r0, [r6, #256]!	; 0x100
     8b4:	06050000 	streq	r0, [r5], -r0
     8b8:	30130000 	andscc	r0, r3, r0
     8bc:	14000006 	strne	r0, [r0], #-6
     8c0:	000000c2 	andeq	r0, r0, r2, asr #1
     8c4:	00004814 	andeq	r4, r0, r4, lsl r8
     8c8:	00481400 	subeq	r1, r8, r0, lsl #8
     8cc:	48140000 	ldmdami	r4, {}	; <UNPREDICTABLE>
     8d0:	14000000 	strne	r0, [r0], #-0
     8d4:	0000065e 	andeq	r0, r0, lr, asr r6
     8d8:	05511900 	ldrbeq	r1, [r1, #-2304]	; 0xfffff700
     8dc:	5b060000 	blpl	1808e4 <__bss_end+0x1779dc>
     8e0:	0005880e 	andeq	r8, r5, lr, lsl #16
     8e4:	0001d200 	andeq	sp, r1, r0, lsl #4
     8e8:	061a0100 	ldreq	r0, [sl], -r0, lsl #2
     8ec:	30130000 	andscc	r0, r3, r0
     8f0:	14000006 	strne	r0, [r0], #-6
     8f4:	00000349 	andeq	r0, r0, r9, asr #6
     8f8:	00066414 	andeq	r6, r6, r4, lsl r4
     8fc:	05000000 	streq	r0, [r0, #-0]
     900:	000003a9 	andeq	r0, r0, r9, lsr #7
     904:	03a9040c 			; <UNDEFINED> instruction: 0x03a9040c
     908:	9d1a0000 	ldcls	0, cr0, [sl, #-0]
     90c:	43000003 	movwmi	r0, #3
     910:	49000006 	stmdbmi	r0, {r1, r2}
     914:	13000006 	movwne	r0, #6
     918:	00000630 	andeq	r0, r0, r0, lsr r6
     91c:	03a91b00 			; <UNDEFINED> instruction: 0x03a91b00
     920:	06360000 	ldrteq	r0, [r6], -r0
     924:	040c0000 	streq	r0, [ip], #-0
     928:	0000003a 	andeq	r0, r0, sl, lsr r0
     92c:	062b040c 	strteq	r0, [fp], -ip, lsl #8
     930:	041c0000 	ldreq	r0, [ip], #-0
     934:	00000065 	andeq	r0, r0, r5, rrx
     938:	681e041d 	ldmdavs	lr, {r0, r2, r3, r4, sl}
     93c:	07006c61 	streq	r6, [r0, -r1, ror #24]
     940:	07200b05 	streq	r0, [r0, -r5, lsl #22]!
     944:	011f0000 	tsteq	pc, r0
     948:	07000009 	streq	r0, [r0, -r9]
     94c:	00601907 	rsbeq	r1, r0, r7, lsl #18
     950:	b2800000 	addlt	r0, r0, #0
     954:	201f0ee6 	andscs	r0, pc, r6, ror #29
     958:	0700000a 	streq	r0, [r0, -sl]
     95c:	02921a0a 	addseq	r1, r2, #40960	; 0xa000
     960:	00000000 	andeq	r0, r0, r0
     964:	da1f2000 	ble	7c896c <__bss_end+0x7bfa64>
     968:	07000008 	streq	r0, [r0, -r8]
     96c:	02921a0d 	addseq	r1, r2, #53248	; 0xd000
     970:	00000000 	andeq	r0, r0, r0
     974:	f0202020 			; <UNDEFINED> instruction: 0xf0202020
     978:	07000009 	streq	r0, [r0, -r9]
     97c:	00541510 	subseq	r1, r4, r0, lsl r5
     980:	1f360000 	svcne	0x00360000
     984:	00000548 	andeq	r0, r0, r8, asr #10
     988:	921a4207 	andsls	r4, sl, #1879048192	; 0x70000000
     98c:	00000002 	andeq	r0, r0, r2
     990:	1f202150 	svcne	0x00202150
     994:	000006af 	andeq	r0, r0, pc, lsr #13
     998:	921a7107 	andsls	r7, sl, #-1073741823	; 0xc0000001
     99c:	00000002 	andeq	r0, r0, r2
     9a0:	1f2000b2 	svcne	0x002000b2
     9a4:	000004ed 	andeq	r0, r0, sp, ror #9
     9a8:	921aa407 	andsls	sl, sl, #117440512	; 0x7000000
     9ac:	00000002 	andeq	r0, r0, r2
     9b0:	1f2000b4 	svcne	0x002000b4
     9b4:	00000718 	andeq	r0, r0, r8, lsl r7
     9b8:	921ab307 	andsls	fp, sl, #469762048	; 0x1c000000
     9bc:	00000002 	andeq	r0, r0, r2
     9c0:	1f201040 	svcne	0x00201040
     9c4:	00000693 	muleq	r0, r3, r6
     9c8:	921abe07 	andsls	fp, sl, #7, 28	; 0x70
     9cc:	00000002 	andeq	r0, r0, r2
     9d0:	1f202050 	svcne	0x00202050
     9d4:	000006c9 	andeq	r0, r0, r9, asr #13
     9d8:	921abf07 	andsls	fp, sl, #7, 30
     9dc:	00000002 	andeq	r0, r0, r2
     9e0:	1f208040 	svcne	0x00208040
     9e4:	00000481 	andeq	r0, r0, r1, lsl #9
     9e8:	921ac007 	andsls	ip, sl, #7
     9ec:	00000002 	andeq	r0, r0, r2
     9f0:	00208050 	eoreq	r8, r0, r0, asr r0
     9f4:	00067221 	andeq	r7, r6, r1, lsr #4
     9f8:	06822100 	streq	r2, [r2], r0, lsl #2
     9fc:	92210000 	eorls	r0, r1, #0
     a00:	21000006 	tstcs	r0, r6
     a04:	000006a2 	andeq	r0, r0, r2, lsr #13
     a08:	0006af21 	andeq	sl, r6, r1, lsr #30
     a0c:	06bf2100 	ldrteq	r2, [pc], r0, lsl #2
     a10:	cf210000 	svcgt	0x00210000
     a14:	21000006 	tstcs	r0, r6
     a18:	000006df 	ldrdeq	r0, [r0], -pc	; <UNPREDICTABLE>
     a1c:	0006ef21 	andeq	lr, r6, r1, lsr #30
     a20:	06ff2100 	ldrbteq	r2, [pc], r0, lsl #2
     a24:	0f210000 	svceq	0x00210000
     a28:	0a000007 	beq	a4c <shift+0xa4c>
     a2c:	000008c0 	andeq	r0, r0, r0, asr #17
     a30:	54140808 	ldrpl	r0, [r4], #-2056	; 0xfffff7f8
     a34:	05000000 	streq	r0, [r0, #-0]
     a38:	008e8403 	addeq	r8, lr, r3, lsl #8
     a3c:	0a510800 	beq	1442a44 <__bss_end+0x1439b3c>
     a40:	04050000 	streq	r0, [r5], #-0
     a44:	00000033 	andeq	r0, r0, r3, lsr r0
     a48:	940c1d08 	strls	r1, [ip], #-3336	; 0xfffff2f8
     a4c:	09000007 	stmdbeq	r0, {r0, r1, r2}
     a50:	00000727 	andeq	r0, r0, r7, lsr #14
     a54:	06230900 	strteq	r0, [r3], -r0, lsl #18
     a58:	09010000 	stmdbeq	r1, {}	; <UNPREDICTABLE>
     a5c:	00000722 	andeq	r0, r0, r2, lsr #14
     a60:	6f4c0d02 	svcvs	0x004c0d02
     a64:	00030077 	andeq	r0, r3, r7, ror r0
     a68:	000c5922 	andeq	r5, ip, r2, lsr #18
     a6c:	050e0100 	streq	r0, [lr, #-256]	; 0xffffff00
     a70:	00000033 	andeq	r0, r0, r3, lsr r0
     a74:	0000822c 	andeq	r8, r0, ip, lsr #4
     a78:	000000dc 	ldrdeq	r0, [r0], -ip
     a7c:	08189c01 	ldmdaeq	r8, {r0, sl, fp, ip, pc}
     a80:	49230000 	stmdbmi	r3!, {}	; <UNPREDICTABLE>
     a84:	0100000c 	tsteq	r0, ip
     a88:	00330e0e 	eorseq	r0, r3, lr, lsl #28
     a8c:	91020000 	mrsls	r0, (UNDEF: 2)
     a90:	0bbb235c 	bleq	feec9808 <__bss_end+0xfeec0900>
     a94:	0e010000 	cdpeq	0, 0, cr0, cr1, cr0, {0}
     a98:	0008181b 	andeq	r1, r8, fp, lsl r8
     a9c:	58910200 	ldmpl	r1, {r9}
     aa0:	0004d424 	andeq	sp, r4, r4, lsr #8
     aa4:	07100100 	ldreq	r0, [r0, -r0, lsl #2]
     aa8:	00000025 	andeq	r0, r0, r5, lsr #32
     aac:	246b9102 	strbtcs	r9, [fp], #-258	; 0xfffffefe
     ab0:	000004d1 	ldrdeq	r0, [r0], -r1
     ab4:	25071101 	strcs	r1, [r7, #-257]	; 0xfffffeff
     ab8:	02000000 	andeq	r0, r0, #0
     abc:	38247791 	stmdacc	r4!, {r0, r4, r7, r8, r9, sl, ip, sp, lr}
     ac0:	0100000a 	tsteq	r0, sl
     ac4:	00480b13 	subeq	r0, r8, r3, lsl fp
     ac8:	91020000 	mrsls	r0, (UNDEF: 2)
     acc:	0b082470 	bleq	209c94 <__bss_end+0x200d8c>
     ad0:	16010000 	strne	r0, [r1], -r0
     ad4:	00076917 	andeq	r6, r7, r7, lsl r9
     ad8:	64910200 	ldrvs	r0, [r1], #512	; 0x200
     adc:	000c8e24 	andeq	r8, ip, r4, lsr #28
     ae0:	0b1e0100 	bleq	780ee8 <__bss_end+0x777fe0>
     ae4:	00000048 	andeq	r0, r0, r8, asr #32
     ae8:	006c9102 	rsbeq	r9, ip, r2, lsl #2
     aec:	081e040c 	ldmdaeq	lr, {r2, r3, sl}
     af0:	040c0000 	streq	r0, [ip], #-0
     af4:	00000025 	andeq	r0, r0, r5, lsr #32
     af8:	000b1f00 	andeq	r1, fp, r0, lsl #30
     afc:	06000400 	streq	r0, [r0], -r0, lsl #8
     b00:	04000004 	streq	r0, [r0], #-4
     b04:	000f7f01 	andeq	r7, pc, r1, lsl #30
     b08:	0e740400 	cdpeq	4, 7, cr0, cr4, cr0, {0}
     b0c:	0c960000 	ldceq	0, cr0, [r6], {0}
     b10:	83080000 	movwhi	r0, #32768	; 0x8000
     b14:	045c0000 	ldrbeq	r0, [ip], #-0
     b18:	05180000 	ldreq	r0, [r8, #-0]
     b1c:	01020000 	mrseq	r0, (UNDEF: 2)
     b20:	0009c508 	andeq	ip, r9, r8, lsl #10
     b24:	00250300 	eoreq	r0, r5, r0, lsl #6
     b28:	02020000 	andeq	r0, r2, #0
     b2c:	0009ff05 	andeq	pc, r9, r5, lsl #30
     b30:	05040400 	streq	r0, [r4, #-1024]	; 0xfffffc00
     b34:	00746e69 	rsbseq	r6, r4, r9, ror #28
     b38:	bc080102 	stflts	f0, [r8], {2}
     b3c:	02000009 	andeq	r0, r0, #9
     b40:	08000702 	stmdaeq	r0, {r1, r8, r9, sl}
     b44:	48050000 	stmdami	r5, {}	; <UNPREDICTABLE>
     b48:	0700000a 	streq	r0, [r0, -sl]
     b4c:	005e0709 	subseq	r0, lr, r9, lsl #14
     b50:	4d030000 	stcmi	0, cr0, [r3, #-0]
     b54:	02000000 	andeq	r0, r0, #0
     b58:	074c0704 	strbeq	r0, [ip, -r4, lsl #14]
     b5c:	17060000 	strne	r0, [r6, -r0]
     b60:	08000006 	stmdaeq	r0, {r1, r2}
     b64:	8b080602 	blhi	202374 <__bss_end+0x1f946c>
     b68:	07000000 	streq	r0, [r0, -r0]
     b6c:	02003072 	andeq	r3, r0, #114	; 0x72
     b70:	004d0e08 	subeq	r0, sp, r8, lsl #28
     b74:	07000000 	streq	r0, [r0, -r0]
     b78:	02003172 	andeq	r3, r0, #-2147483620	; 0x8000001c
     b7c:	004d0e09 	subeq	r0, sp, r9, lsl #28
     b80:	00040000 	andeq	r0, r4, r0
     b84:	000f0908 	andeq	r0, pc, r8, lsl #18
     b88:	38040500 	stmdacc	r4, {r8, sl}
     b8c:	02000000 	andeq	r0, r0, #0
     b90:	00a90c0d 	adceq	r0, r9, sp, lsl #24
     b94:	4f090000 	svcmi	0x00090000
     b98:	0a00004b 	beq	ccc <shift+0xccc>
     b9c:	00000d3f 	andeq	r0, r0, pc, lsr sp
     ba0:	f8080001 			; <UNDEFINED> instruction: 0xf8080001
     ba4:	05000004 	streq	r0, [r0, #-4]
     ba8:	00003804 	andeq	r3, r0, r4, lsl #16
     bac:	0c1e0200 	lfmeq	f0, 4, [lr], {-0}
     bb0:	000000e0 	andeq	r0, r0, r0, ror #1
     bb4:	00068b0a 	andeq	r8, r6, sl, lsl #22
     bb8:	7e0a0000 	cdpvc	0, 0, cr0, cr10, cr0, {0}
     bbc:	0100000c 	tsteq	r0, ip
     bc0:	000c5e0a 	andeq	r5, ip, sl, lsl #28
     bc4:	4b0a0200 	blmi	2813cc <__bss_end+0x2784c4>
     bc8:	03000008 	movweq	r0, #8
     bcc:	0009400a 	andeq	r4, r9, sl
     bd0:	540a0400 	strpl	r0, [sl], #-1024	; 0xfffffc00
     bd4:	05000006 	streq	r0, [r0, #-6]
     bd8:	0c060800 	stceq	8, cr0, [r6], {-0}
     bdc:	04050000 	streq	r0, [r5], #-0
     be0:	00000038 	andeq	r0, r0, r8, lsr r0
     be4:	1d0c3f02 	stcne	15, cr3, [ip, #-8]
     be8:	0a000001 	beq	bf4 <shift+0xbf4>
     bec:	000003ff 	strdeq	r0, [r0], -pc	; <UNPREDICTABLE>
     bf0:	050d0a00 	streq	r0, [sp, #-2560]	; 0xfffff600
     bf4:	0a010000 	beq	40bfc <__bss_end+0x37cf4>
     bf8:	00000933 	andeq	r0, r0, r3, lsr r9
     bfc:	0c430a02 	mcrreq	10, 0, r0, r3, cr2
     c00:	0a030000 	beq	c0c08 <__bss_end+0xb7d00>
     c04:	00000c88 	andeq	r0, r0, r8, lsl #25
     c08:	08fa0a04 	ldmeq	sl!, {r2, r9, fp}^
     c0c:	0a050000 	beq	140c14 <__bss_end+0x137d0c>
     c10:	00000820 	andeq	r0, r0, r0, lsr #16
     c14:	c0080006 	andgt	r0, r8, r6
     c18:	0500000b 	streq	r0, [r0, #-11]
     c1c:	00003804 	andeq	r3, r0, r4, lsl #16
     c20:	0c660200 	sfmeq	f0, 2, [r6], #-0
     c24:	00000148 	andeq	r0, r0, r8, asr #2
     c28:	0009a30a 	andeq	sl, r9, sl, lsl #6
     c2c:	800a0000 	andhi	r0, sl, r0
     c30:	01000007 	tsteq	r0, r7
     c34:	000a090a 	andeq	r0, sl, sl, lsl #18
     c38:	250a0200 	strcs	r0, [sl, #-512]	; 0xfffffe00
     c3c:	03000008 	movweq	r0, #8
     c40:	09140b00 	ldmdbeq	r4, {r8, r9, fp}
     c44:	05030000 	streq	r0, [r3, #-0]
     c48:	00005914 	andeq	r5, r0, r4, lsl r9
     c4c:	ac030500 	cfstr32ge	mvfx0, [r3], {-0}
     c50:	0b00008e 	bleq	e90 <shift+0xe90>
     c54:	00000922 	andeq	r0, r0, r2, lsr #18
     c58:	59140603 	ldmdbpl	r4, {r0, r1, r9, sl}
     c5c:	05000000 	streq	r0, [r0, #-0]
     c60:	008eb003 	addeq	fp, lr, r3
     c64:	08e40b00 	stmiaeq	r4!, {r8, r9, fp}^
     c68:	07040000 	streq	r0, [r4, -r0]
     c6c:	0000591a 	andeq	r5, r0, sl, lsl r9
     c70:	b4030500 	strlt	r0, [r3], #-1280	; 0xfffffb00
     c74:	0b00008e 	bleq	eb4 <shift+0xeb4>
     c78:	00000536 	andeq	r0, r0, r6, lsr r5
     c7c:	591a0904 	ldmdbpl	sl, {r2, r8, fp}
     c80:	05000000 	streq	r0, [r0, #-0]
     c84:	008eb803 	addeq	fp, lr, r3, lsl #16
     c88:	09ae0b00 	stmibeq	lr!, {r8, r9, fp}
     c8c:	0b040000 	bleq	100c94 <__bss_end+0xf7d8c>
     c90:	0000591a 	andeq	r5, r0, sl, lsl r9
     c94:	bc030500 	cfstr32lt	mvfx0, [r3], {-0}
     c98:	0b00008e 	bleq	ed8 <shift+0xed8>
     c9c:	0000076d 	andeq	r0, r0, sp, ror #14
     ca0:	591a0d04 	ldmdbpl	sl, {r2, r8, sl, fp}
     ca4:	05000000 	streq	r0, [r0, #-0]
     ca8:	008ec003 	addeq	ip, lr, r3
     cac:	063d0b00 	ldrteq	r0, [sp], -r0, lsl #22
     cb0:	0f040000 	svceq	0x00040000
     cb4:	0000591a 	andeq	r5, r0, sl, lsl r9
     cb8:	c4030500 	strgt	r0, [r3], #-1280	; 0xfffffb00
     cbc:	0800008e 	stmdaeq	r0, {r1, r2, r3, r7}
     cc0:	00001072 	andeq	r1, r0, r2, ror r0
     cc4:	00380405 	eorseq	r0, r8, r5, lsl #8
     cc8:	1b040000 	blne	100cd0 <__bss_end+0xf7dc8>
     ccc:	0001eb0c 	andeq	lr, r1, ip, lsl #22
     cd0:	0a850a00 	beq	fe1434d8 <__bss_end+0xfe13a5d0>
     cd4:	0a000000 	beq	cdc <shift+0xcdc>
     cd8:	00000c4e 	andeq	r0, r0, lr, asr #24
     cdc:	092e0a01 	stmdbeq	lr!, {r0, r9, fp}
     ce0:	00020000 	andeq	r0, r2, r0
     ce4:	00099d0c 	andeq	r9, r9, ip, lsl #26
     ce8:	02010200 	andeq	r0, r1, #0, 4
     cec:	00000851 	andeq	r0, r0, r1, asr r8
     cf0:	002c040d 	eoreq	r0, ip, sp, lsl #8
     cf4:	040d0000 	streq	r0, [sp], #-0
     cf8:	000001eb 	andeq	r0, r0, fp, ror #3
     cfc:	0006d30b 	andeq	sp, r6, fp, lsl #6
     d00:	14040500 	strne	r0, [r4], #-1280	; 0xfffffb00
     d04:	00000059 	andeq	r0, r0, r9, asr r0
     d08:	8ec80305 	cdphi	3, 12, cr0, cr8, cr5, {0}
     d0c:	f40b0000 	vst4.8	{d0-d3}, [fp], r0
     d10:	05000003 	streq	r0, [r0, #-3]
     d14:	00591407 	subseq	r1, r9, r7, lsl #8
     d18:	03050000 	movweq	r0, #20480	; 0x5000
     d1c:	00008ecc 	andeq	r8, r0, ip, asr #29
     d20:	0005640b 	andeq	r6, r5, fp, lsl #8
     d24:	140a0500 	strne	r0, [sl], #-1280	; 0xfffffb00
     d28:	00000059 	andeq	r0, r0, r9, asr r0
     d2c:	8ed00305 	cdphi	3, 13, cr0, cr0, cr5, {0}
     d30:	86080000 	strhi	r0, [r8], -r0
     d34:	05000008 	streq	r0, [r0, #-8]
     d38:	00003804 	andeq	r3, r0, r4, lsl #16
     d3c:	0c0d0500 	cfstr32eq	mvfx0, [sp], {-0}
     d40:	00000270 	andeq	r0, r0, r0, ror r2
     d44:	77654e09 	strbvc	r4, [r5, -r9, lsl #28]!
     d48:	7d0a0000 	stcvc	0, cr0, [sl, #-0]
     d4c:	01000008 	tsteq	r0, r8
     d50:	000a300a 	andeq	r3, sl, sl
     d54:	600a0200 	andvs	r0, sl, r0, lsl #4
     d58:	03000008 	movweq	r0, #8
     d5c:	00083d0a 	andeq	r3, r8, sl, lsl #26
     d60:	390a0400 	stmdbcc	sl, {sl}
     d64:	05000009 	streq	r0, [r0, #-9]
     d68:	06470600 	strbeq	r0, [r7], -r0, lsl #12
     d6c:	05100000 	ldreq	r0, [r0, #-0]
     d70:	02af081b 	adceq	r0, pc, #1769472	; 0x1b0000
     d74:	6c070000 	stcvs	0, cr0, [r7], {-0}
     d78:	1d050072 	stcne	0, cr0, [r5, #-456]	; 0xfffffe38
     d7c:	0002af13 	andeq	sl, r2, r3, lsl pc
     d80:	73070000 	movwvc	r0, #28672	; 0x7000
     d84:	1e050070 	mcrne	0, 0, r0, cr5, cr0, {3}
     d88:	0002af13 	andeq	sl, r2, r3, lsl pc
     d8c:	70070400 	andvc	r0, r7, r0, lsl #8
     d90:	1f050063 	svcne	0x00050063
     d94:	0002af13 	andeq	sl, r2, r3, lsl pc
     d98:	5d0e0800 	stcpl	8, cr0, [lr, #-0]
     d9c:	05000006 	streq	r0, [r0, #-6]
     da0:	02af1320 	adceq	r1, pc, #32, 6	; 0x80000000
     da4:	000c0000 	andeq	r0, ip, r0
     da8:	47070402 	strmi	r0, [r7, -r2, lsl #8]
     dac:	06000007 	streq	r0, [r0], -r7
     db0:	00000461 	andeq	r0, r0, r1, ror #8
     db4:	08280570 	stmdaeq	r8!, {r4, r5, r6, r8, sl}
     db8:	00000346 	andeq	r0, r0, r6, asr #6
     dbc:	000a790e 	andeq	r7, sl, lr, lsl #18
     dc0:	122a0500 	eorne	r0, sl, #0, 10
     dc4:	00000270 	andeq	r0, r0, r0, ror r2
     dc8:	69700700 	ldmdbvs	r0!, {r8, r9, sl}^
     dcc:	2b050064 	blcs	140f64 <__bss_end+0x13805c>
     dd0:	00005e12 	andeq	r5, r0, r2, lsl lr
     dd4:	d40e1000 	strle	r1, [lr], #-0
     dd8:	05000004 	streq	r0, [r0, #-4]
     ddc:	0239112c 	eorseq	r1, r9, #44, 2
     de0:	0e140000 	cdpeq	0, 1, cr0, cr4, cr0, {0}
     de4:	00000892 	muleq	r0, r2, r8
     de8:	5e122d05 	cdppl	13, 1, cr2, cr2, cr5, {0}
     dec:	18000000 	stmdane	r0, {}	; <UNPREDICTABLE>
     df0:	0008a00e 	andeq	sl, r8, lr
     df4:	122e0500 	eorne	r0, lr, #0, 10
     df8:	0000005e 	andeq	r0, r0, lr, asr r0
     dfc:	06300e1c 			; <UNDEFINED> instruction: 0x06300e1c
     e00:	2f050000 	svccs	0x00050000
     e04:	0003460c 	andeq	r4, r3, ip, lsl #12
     e08:	b60e2000 	strlt	r2, [lr], -r0
     e0c:	05000008 	streq	r0, [r0, #-8]
     e10:	00380930 	eorseq	r0, r8, r0, lsr r9
     e14:	0e600000 	cdpeq	0, 6, cr0, cr0, cr0, {0}
     e18:	00000a8f 	andeq	r0, r0, pc, lsl #21
     e1c:	4d0e3105 	stfmis	f3, [lr, #-20]	; 0xffffffec
     e20:	64000000 	strvs	r0, [r0], #-0
     e24:	0006a60e 	andeq	sl, r6, lr, lsl #12
     e28:	0e330500 	cfabs32eq	mvfx0, mvfx3
     e2c:	0000004d 	andeq	r0, r0, sp, asr #32
     e30:	069d0e68 	ldreq	r0, [sp], r8, ror #28
     e34:	34050000 	strcc	r0, [r5], #-0
     e38:	00004d0e 	andeq	r4, r0, lr, lsl #26
     e3c:	0f006c00 	svceq	0x00006c00
     e40:	000001fd 	strdeq	r0, [r0], -sp
     e44:	00000356 	andeq	r0, r0, r6, asr r3
     e48:	00005e10 	andeq	r5, r0, r0, lsl lr
     e4c:	0b000f00 	bleq	4a54 <shift+0x4a54>
     e50:	00000c1e 	andeq	r0, r0, lr, lsl ip
     e54:	59140a06 	ldmdbpl	r4, {r1, r2, r9, fp}
     e58:	05000000 	streq	r0, [r0, #-0]
     e5c:	008ed403 	addeq	sp, lr, r3, lsl #8
     e60:	08680800 	stmdaeq	r8!, {fp}^
     e64:	04050000 	streq	r0, [r5], #-0
     e68:	00000038 	andeq	r0, r0, r8, lsr r0
     e6c:	870c0d06 	strhi	r0, [ip, -r6, lsl #26]
     e70:	0a000003 	beq	e84 <shift+0xe84>
     e74:	00000512 	andeq	r0, r0, r2, lsl r5
     e78:	03e90a00 	mvneq	r0, #0, 20
     e7c:	00010000 	andeq	r0, r1, r0
     e80:	00036803 	andeq	r6, r3, r3, lsl #16
     e84:	0e060800 	cdpeq	8, 0, cr0, cr6, cr0, {0}
     e88:	04050000 	streq	r0, [r5], #-0
     e8c:	00000038 	andeq	r0, r0, r8, lsr r0
     e90:	ab0c1406 	blge	305eb0 <__bss_end+0x2fcfa8>
     e94:	0a000003 	beq	ea8 <shift+0xea8>
     e98:	00000ce7 	andeq	r0, r0, r7, ror #25
     e9c:	0edb0a00 	vfnmseq.f32	s1, s22, s0
     ea0:	00010000 	andeq	r0, r1, r0
     ea4:	00038c03 	andeq	r8, r3, r3, lsl #24
     ea8:	0b4a0600 	bleq	12826b0 <__bss_end+0x12797a8>
     eac:	060c0000 	streq	r0, [ip], -r0
     eb0:	03e5081b 	mvneq	r0, #1769472	; 0x1b0000
     eb4:	330e0000 	movwcc	r0, #57344	; 0xe000
     eb8:	06000004 	streq	r0, [r0], -r4
     ebc:	03e5191d 	mvneq	r1, #475136	; 0x74000
     ec0:	0e000000 	cdpeq	0, 0, cr0, cr0, cr0, {0}
     ec4:	000004cc 	andeq	r0, r0, ip, asr #9
     ec8:	e5191e06 	ldr	r1, [r9, #-3590]	; 0xfffff1fa
     ecc:	04000003 	streq	r0, [r0], #-3
     ed0:	000b030e 	andeq	r0, fp, lr, lsl #6
     ed4:	131f0600 	tstne	pc, #0, 12
     ed8:	000003eb 	andeq	r0, r0, fp, ror #7
     edc:	040d0008 	streq	r0, [sp], #-8
     ee0:	000003b0 			; <UNDEFINED> instruction: 0x000003b0
     ee4:	02b6040d 	adcseq	r0, r6, #218103808	; 0xd000000
     ee8:	77110000 	ldrvc	r0, [r1, -r0]
     eec:	14000005 	strne	r0, [r0], #-5
     ef0:	73072206 	movwvc	r2, #29190	; 0x7206
     ef4:	0e000006 	cdpeq	0, 0, cr0, cr0, cr6, {0}
     ef8:	00000856 	andeq	r0, r0, r6, asr r8
     efc:	4d122606 	ldcmi	6, cr2, [r2, #-24]	; 0xffffffe8
     f00:	00000000 	andeq	r0, r0, r0
     f04:	00048b0e 	andeq	r8, r4, lr, lsl #22
     f08:	1d290600 	stcne	6, cr0, [r9, #-0]
     f0c:	000003e5 	andeq	r0, r0, r5, ror #7
     f10:	0a660e04 	beq	1984728 <__bss_end+0x197b820>
     f14:	2c060000 	stccs	0, cr0, [r6], {-0}
     f18:	0003e51d 	andeq	lr, r3, sp, lsl r5
     f1c:	fc120800 	ldc2	8, cr0, [r2], {-0}
     f20:	0600000b 	streq	r0, [r0], -fp
     f24:	0b270e2f 	bleq	9c47e8 <__bss_end+0x9bb8e0>
     f28:	04390000 	ldrteq	r0, [r9], #-0
     f2c:	04440000 	strbeq	r0, [r4], #-0
     f30:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
     f34:	14000006 	strne	r0, [r0], #-6
     f38:	000003e5 	andeq	r0, r0, r5, ror #7
     f3c:	0b0f1500 	bleq	3c6344 <__bss_end+0x3bd43c>
     f40:	31060000 	mrscc	r0, (UNDEF: 6)
     f44:	0004380e 	andeq	r3, r4, lr, lsl #16
     f48:	0001f000 	andeq	pc, r1, r0
     f4c:	00045c00 	andeq	r5, r4, r0, lsl #24
     f50:	00046700 	andeq	r6, r4, r0, lsl #14
     f54:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
     f58:	eb140000 	bl	500f60 <__bss_end+0x4f8058>
     f5c:	00000003 	andeq	r0, r0, r3
     f60:	000b5d16 	andeq	r5, fp, r6, lsl sp
     f64:	1d350600 	ldcne	6, cr0, [r5, #-0]
     f68:	00000ade 	ldrdeq	r0, [r0], -lr
     f6c:	000003e5 	andeq	r0, r0, r5, ror #7
     f70:	00048002 	andeq	r8, r4, r2
     f74:	00048600 	andeq	r8, r4, r0, lsl #12
     f78:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
     f7c:	16000000 	strne	r0, [r0], -r0
     f80:	00000813 	andeq	r0, r0, r3, lsl r8
     f84:	ca1d3706 	bgt	74eba4 <__bss_end+0x745c9c>
     f88:	e5000009 	str	r0, [r0, #-9]
     f8c:	02000003 	andeq	r0, r0, #3
     f90:	0000049f 	muleq	r0, pc, r4	; <UNPREDICTABLE>
     f94:	000004a5 	andeq	r0, r0, r5, lsr #9
     f98:	00067813 	andeq	r7, r6, r3, lsl r8
     f9c:	cc170000 	ldcgt	0, cr0, [r7], {-0}
     fa0:	06000008 	streq	r0, [r0], -r8
     fa4:	06913139 			; <UNDEFINED> instruction: 0x06913139
     fa8:	020c0000 	andeq	r0, ip, #0
     fac:	00057716 	andeq	r7, r5, r6, lsl r7
     fb0:	093c0600 	ldmdbeq	ip!, {r9, sl}
     fb4:	00000c64 	andeq	r0, r0, r4, ror #24
     fb8:	00000678 	andeq	r0, r0, r8, ror r6
     fbc:	0004cc01 	andeq	ip, r4, r1, lsl #24
     fc0:	0004d200 	andeq	sp, r4, r0, lsl #4
     fc4:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
     fc8:	16000000 	strne	r0, [r0], -r0
     fcc:	00000527 	andeq	r0, r0, r7, lsr #10
     fd0:	d1123f06 	tstle	r2, r6, lsl #30
     fd4:	4d00000b 	stcmi	0, cr0, [r0, #-44]	; 0xffffffd4
     fd8:	01000000 	mrseq	r0, (UNDEF: 0)
     fdc:	000004eb 	andeq	r0, r0, fp, ror #9
     fe0:	00000500 	andeq	r0, r0, r0, lsl #10
     fe4:	00067813 	andeq	r7, r6, r3, lsl r8
     fe8:	069a1400 	ldreq	r1, [sl], r0, lsl #8
     fec:	5e140000 	cdppl	0, 1, cr0, cr4, cr0, {0}
     ff0:	14000000 	strne	r0, [r0], #-0
     ff4:	000001f0 	strdeq	r0, [r0], -r0	; <UNPREDICTABLE>
     ff8:	0b1e1800 	bleq	787000 <__bss_end+0x77e0f8>
     ffc:	42060000 	andmi	r0, r6, #0
    1000:	00094f0e 	andeq	r4, r9, lr, lsl #30
    1004:	05150100 	ldreq	r0, [r5, #-256]	; 0xffffff00
    1008:	051b0000 	ldreq	r0, [fp, #-0]
    100c:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
    1010:	00000006 	andeq	r0, r0, r6
    1014:	00073316 	andeq	r3, r7, r6, lsl r3
    1018:	17450600 	strbne	r0, [r5, -r0, lsl #12]
    101c:	0000049e 	muleq	r0, lr, r4
    1020:	000003eb 	andeq	r0, r0, fp, ror #7
    1024:	00053401 	andeq	r3, r5, r1, lsl #8
    1028:	00053a00 	andeq	r3, r5, r0, lsl #20
    102c:	06a01300 	strteq	r1, [r0], r0, lsl #6
    1030:	16000000 	strne	r0, [r0], -r0
    1034:	000004da 	ldrdeq	r0, [r0], -sl
    1038:	9b174806 	blls	5d3058 <__bss_end+0x5ca150>
    103c:	eb00000a 	bl	106c <shift+0x106c>
    1040:	01000003 	tsteq	r0, r3
    1044:	00000553 	andeq	r0, r0, r3, asr r5
    1048:	0000055e 	andeq	r0, r0, lr, asr r5
    104c:	0006a013 	andeq	sl, r6, r3, lsl r0
    1050:	004d1400 	subeq	r1, sp, r0, lsl #8
    1054:	18000000 	stmdane	r0, {}	; <UNPREDICTABLE>
    1058:	00000c2d 	andeq	r0, r0, sp, lsr #24
    105c:	040e4b06 	streq	r4, [lr], #-2822	; 0xfffff4fa
    1060:	01000004 	tsteq	r0, r4
    1064:	00000573 	andeq	r0, r0, r3, ror r5
    1068:	00000579 	andeq	r0, r0, r9, ror r5
    106c:	00067813 	andeq	r7, r6, r3, lsl r8
    1070:	0f160000 	svceq	0x00160000
    1074:	0600000b 	streq	r0, [r0], -fp
    1078:	06630e4d 	strbteq	r0, [r3], -sp, asr #28
    107c:	01f00000 	mvnseq	r0, r0
    1080:	92010000 	andls	r0, r1, #0
    1084:	9d000005 	stcls	0, cr0, [r0, #-20]	; 0xffffffec
    1088:	13000005 	movwne	r0, #5
    108c:	00000678 	andeq	r0, r0, r8, ror r6
    1090:	00004d14 	andeq	r4, r0, r4, lsl sp
    1094:	59160000 	ldmdbpl	r6, {}	; <UNPREDICTABLE>
    1098:	06000007 	streq	r0, [r0], -r7
    109c:	09701250 	ldmdbeq	r0!, {r4, r6, r9, ip}^
    10a0:	004d0000 	subeq	r0, sp, r0
    10a4:	b6010000 	strlt	r0, [r1], -r0
    10a8:	c1000005 	tstgt	r0, r5
    10ac:	13000005 	movwne	r0, #5
    10b0:	00000678 	andeq	r0, r0, r8, ror r6
    10b4:	0001fd14 	andeq	pc, r1, r4, lsl sp	; <UNPREDICTABLE>
    10b8:	6e160000 	cdpvs	0, 1, cr0, cr6, cr0, {0}
    10bc:	06000004 	streq	r0, [r0], -r4
    10c0:	06ec0e53 	usateq	r0, #12, r3, asr #28
    10c4:	01f00000 	mvnseq	r0, r0
    10c8:	da010000 	ble	410d0 <__bss_end+0x381c8>
    10cc:	e5000005 	str	r0, [r0, #-5]
    10d0:	13000005 	movwne	r0, #5
    10d4:	00000678 	andeq	r0, r0, r8, ror r6
    10d8:	00004d14 	andeq	r4, r0, r4, lsl sp
    10dc:	ed180000 	ldc	0, cr0, [r8, #-0]
    10e0:	06000007 	streq	r0, [r0], -r7
    10e4:	0b690e56 	bleq	1a44a44 <__bss_end+0x1a3bb3c>
    10e8:	fa010000 	blx	410f0 <__bss_end+0x381e8>
    10ec:	19000005 	stmdbne	r0, {r0, r2}
    10f0:	13000006 	movwne	r0, #6
    10f4:	00000678 	andeq	r0, r0, r8, ror r6
    10f8:	0000a914 	andeq	sl, r0, r4, lsl r9
    10fc:	004d1400 	subeq	r1, sp, r0, lsl #8
    1100:	4d140000 	ldcmi	0, cr0, [r4, #-0]
    1104:	14000000 	strne	r0, [r0], #-0
    1108:	0000004d 	andeq	r0, r0, sp, asr #32
    110c:	0006a614 	andeq	sl, r6, r4, lsl r6
    1110:	c8180000 	ldmdagt	r8, {}	; <UNPREDICTABLE>
    1114:	0600000a 	streq	r0, [r0], -sl
    1118:	05cb0e58 	strbeq	r0, [fp, #3672]	; 0xe58
    111c:	2e010000 	cdpcs	0, 0, cr0, cr1, cr0, {0}
    1120:	4d000006 	stcmi	0, cr0, [r0, #-24]	; 0xffffffe8
    1124:	13000006 	movwne	r0, #6
    1128:	00000678 	andeq	r0, r0, r8, ror r6
    112c:	0000e014 	andeq	lr, r0, r4, lsl r0
    1130:	004d1400 	subeq	r1, sp, r0, lsl #8
    1134:	4d140000 	ldcmi	0, cr0, [r4, #-0]
    1138:	14000000 	strne	r0, [r0], #-0
    113c:	0000004d 	andeq	r0, r0, sp, asr #32
    1140:	0006a614 	andeq	sl, r6, r4, lsl r6
    1144:	51190000 	tstpl	r9, r0
    1148:	06000005 	streq	r0, [r0], -r5
    114c:	05880e5b 	streq	r0, [r8, #3675]	; 0xe5b
    1150:	01f00000 	mvnseq	r0, r0
    1154:	62010000 	andvs	r0, r1, #0
    1158:	13000006 	movwne	r0, #6
    115c:	00000678 	andeq	r0, r0, r8, ror r6
    1160:	00036814 	andeq	r6, r3, r4, lsl r8
    1164:	06ac1400 	strteq	r1, [ip], r0, lsl #8
    1168:	00000000 	andeq	r0, r0, r0
    116c:	0003f103 	andeq	pc, r3, r3, lsl #2
    1170:	f1040d00 			; <UNDEFINED> instruction: 0xf1040d00
    1174:	1a000003 	bne	1188 <shift+0x1188>
    1178:	000003e5 	andeq	r0, r0, r5, ror #7
    117c:	0000068b 	andeq	r0, r0, fp, lsl #13
    1180:	00000691 	muleq	r0, r1, r6
    1184:	00067813 	andeq	r7, r6, r3, lsl r8
    1188:	f11b0000 			; <UNDEFINED> instruction: 0xf11b0000
    118c:	7e000003 	cdpvc	0, 0, cr0, cr0, cr3, {0}
    1190:	0d000006 	stceq	0, cr0, [r0, #-24]	; 0xffffffe8
    1194:	00003f04 	andeq	r3, r0, r4, lsl #30
    1198:	73040d00 	movwvc	r0, #19712	; 0x4d00
    119c:	1c000006 	stcne	0, cr0, [r0], {6}
    11a0:	00006504 	andeq	r6, r0, r4, lsl #10
    11a4:	0f041d00 	svceq	0x00041d00
    11a8:	0000002c 	andeq	r0, r0, ip, lsr #32
    11ac:	000006be 			; <UNDEFINED> instruction: 0x000006be
    11b0:	00005e10 	andeq	r5, r0, r0, lsl lr
    11b4:	03000900 	movweq	r0, #2304	; 0x900
    11b8:	000006ae 	andeq	r0, r0, lr, lsr #13
    11bc:	000d8b1e 	andeq	r8, sp, lr, lsl fp
    11c0:	0ca40100 	stfeqs	f0, [r4]
    11c4:	000006be 			; <UNDEFINED> instruction: 0x000006be
    11c8:	8ed80305 	cdphi	3, 13, cr0, cr8, cr5, {0}
    11cc:	911f0000 	tstls	pc, r0
    11d0:	0100000c 	tsteq	r0, ip
    11d4:	0dfa0aa6 			; <UNDEFINED> instruction: 0x0dfa0aa6
    11d8:	004d0000 	subeq	r0, sp, r0
    11dc:	86b40000 	ldrthi	r0, [r4], r0
    11e0:	00b00000 	adcseq	r0, r0, r0
    11e4:	9c010000 	stcls	0, cr0, [r1], {-0}
    11e8:	00000733 	andeq	r0, r0, r3, lsr r7
    11ec:	00105520 	andseq	r5, r0, r0, lsr #10
    11f0:	1ba60100 	blne	fe9815f8 <__bss_end+0xfe9786f0>
    11f4:	000001f7 	strdeq	r0, [r0], -r7
    11f8:	7fac9103 	svcvc	0x00ac9103
    11fc:	000e5920 	andeq	r5, lr, r0, lsr #18
    1200:	2aa60100 	bcs	fe981608 <__bss_end+0xfe978700>
    1204:	0000004d 	andeq	r0, r0, sp, asr #32
    1208:	7fa89103 	svcvc	0x00a89103
    120c:	000de31e 	andeq	lr, sp, lr, lsl r3
    1210:	0aa80100 	beq	fea01618 <__bss_end+0xfe9f8710>
    1214:	00000733 	andeq	r0, r0, r3, lsr r7
    1218:	7fb49103 	svcvc	0x00b49103
    121c:	000cfb1e 	andeq	pc, ip, lr, lsl fp	; <UNPREDICTABLE>
    1220:	09ac0100 	stmibeq	ip!, {r8}
    1224:	00000038 	andeq	r0, r0, r8, lsr r0
    1228:	00749102 	rsbseq	r9, r4, r2, lsl #2
    122c:	0000250f 	andeq	r2, r0, pc, lsl #10
    1230:	00074300 	andeq	r4, r7, r0, lsl #6
    1234:	005e1000 	subseq	r1, lr, r0
    1238:	003f0000 	eorseq	r0, pc, r0
    123c:	000e3e21 	andeq	r3, lr, r1, lsr #28
    1240:	0a980100 	beq	fe601648 <__bss_end+0xfe5f8740>
    1244:	00000ee9 	andeq	r0, r0, r9, ror #29
    1248:	0000004d 	andeq	r0, r0, sp, asr #32
    124c:	00008678 	andeq	r8, r0, r8, ror r6
    1250:	0000003c 	andeq	r0, r0, ip, lsr r0
    1254:	07809c01 	streq	r9, [r0, r1, lsl #24]
    1258:	72220000 	eorvc	r0, r2, #0
    125c:	01007165 	tsteq	r0, r5, ror #2
    1260:	03ab209a 			; <UNDEFINED> instruction: 0x03ab209a
    1264:	91020000 	mrsls	r0, (UNDEF: 2)
    1268:	0def1e74 	stcleq	14, cr1, [pc, #464]!	; 1440 <shift+0x1440>
    126c:	9b010000 	blls	41274 <__bss_end+0x3836c>
    1270:	00004d0e 	andeq	r4, r0, lr, lsl #26
    1274:	70910200 	addsvc	r0, r1, r0, lsl #4
    1278:	0e622300 	cdpeq	3, 6, cr2, cr2, cr0, {0}
    127c:	8f010000 	svchi	0x00010000
    1280:	000d1706 	andeq	r1, sp, r6, lsl #14
    1284:	00863c00 	addeq	r3, r6, r0, lsl #24
    1288:	00003c00 	andeq	r3, r0, r0, lsl #24
    128c:	b99c0100 	ldmiblt	ip, {r8}
    1290:	20000007 	andcs	r0, r0, r7
    1294:	00000d59 	andeq	r0, r0, r9, asr sp
    1298:	4d218f01 	stcmi	15, cr8, [r1, #-4]!
    129c:	02000000 	andeq	r0, r0, #0
    12a0:	72226c91 	eorvc	r6, r2, #37120	; 0x9100
    12a4:	01007165 	tsteq	r0, r5, ror #2
    12a8:	03ab2091 			; <UNDEFINED> instruction: 0x03ab2091
    12ac:	91020000 	mrsls	r0, (UNDEF: 2)
    12b0:	1b210074 	blne	841488 <__bss_end+0x838580>
    12b4:	0100000e 	tsteq	r0, lr
    12b8:	0d9c0a83 	vldreq	s0, [ip, #524]	; 0x20c
    12bc:	004d0000 	subeq	r0, sp, r0
    12c0:	86000000 	strhi	r0, [r0], -r0
    12c4:	003c0000 	eorseq	r0, ip, r0
    12c8:	9c010000 	stcls	0, cr0, [r1], {-0}
    12cc:	000007f6 	strdeq	r0, [r0], -r6
    12d0:	71657222 	cmnvc	r5, r2, lsr #4
    12d4:	20850100 	addcs	r0, r5, r0, lsl #2
    12d8:	00000387 	andeq	r0, r0, r7, lsl #7
    12dc:	1e749102 	expnes	f1, f2
    12e0:	00000cf4 	strdeq	r0, [r0], -r4
    12e4:	4d0e8601 	stcmi	6, cr8, [lr, #-4]
    12e8:	02000000 	andeq	r0, r0, #0
    12ec:	21007091 	swpcs	r7, r1, [r0]
    12f0:	00001038 	andeq	r1, r0, r8, lsr r0
    12f4:	6d0a7701 	stcvs	7, cr7, [sl, #-4]
    12f8:	4d00000d 	stcmi	0, cr0, [r0, #-52]	; 0xffffffcc
    12fc:	c4000000 	strgt	r0, [r0], #-0
    1300:	3c000085 	stccc	0, cr0, [r0], {133}	; 0x85
    1304:	01000000 	mrseq	r0, (UNDEF: 0)
    1308:	0008339c 	muleq	r8, ip, r3
    130c:	65722200 	ldrbvs	r2, [r2, #-512]!	; 0xfffffe00
    1310:	79010071 	stmdbvc	r1, {r0, r4, r5, r6}
    1314:	00038720 	andeq	r8, r3, r0, lsr #14
    1318:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    131c:	000cf41e 	andeq	pc, ip, lr, lsl r4	; <UNPREDICTABLE>
    1320:	0e7a0100 	rpweqe	f0, f2, f0
    1324:	0000004d 	andeq	r0, r0, sp, asr #32
    1328:	00709102 	rsbseq	r9, r0, r2, lsl #2
    132c:	000db021 	andeq	fp, sp, r1, lsr #32
    1330:	066b0100 	strbteq	r0, [fp], -r0, lsl #2
    1334:	00000ed0 	ldrdeq	r0, [r0], -r0	; <UNPREDICTABLE>
    1338:	000001f0 	strdeq	r0, [r0], -r0	; <UNPREDICTABLE>
    133c:	00008570 	andeq	r8, r0, r0, ror r5
    1340:	00000054 	andeq	r0, r0, r4, asr r0
    1344:	087f9c01 	ldmdaeq	pc!, {r0, sl, fp, ip, pc}^	; <UNPREDICTABLE>
    1348:	ef200000 	svc	0x00200000
    134c:	0100000d 	tsteq	r0, sp
    1350:	004d156b 	subeq	r1, sp, fp, ror #10
    1354:	91020000 	mrsls	r0, (UNDEF: 2)
    1358:	069d206c 	ldreq	r2, [sp], ip, rrx
    135c:	6b010000 	blvs	41364 <__bss_end+0x3845c>
    1360:	00004d25 	andeq	r4, r0, r5, lsr #26
    1364:	68910200 	ldmvs	r1, {r9}
    1368:	0010301e 	andseq	r3, r0, lr, lsl r0
    136c:	0e6d0100 	poweqe	f0, f5, f0
    1370:	0000004d 	andeq	r0, r0, sp, asr #32
    1374:	00749102 	rsbseq	r9, r4, r2, lsl #2
    1378:	000d2e21 	andeq	r2, sp, r1, lsr #28
    137c:	125e0100 	subsne	r0, lr, #0, 2
    1380:	00000f20 	andeq	r0, r0, r0, lsr #30
    1384:	0000008b 	andeq	r0, r0, fp, lsl #1
    1388:	00008520 	andeq	r8, r0, r0, lsr #10
    138c:	00000050 	andeq	r0, r0, r0, asr r0
    1390:	08da9c01 	ldmeq	sl, {r0, sl, fp, ip, pc}^
    1394:	43200000 	nopmi	{0}	; <UNPREDICTABLE>
    1398:	0100000a 	tsteq	r0, sl
    139c:	004d205e 	subeq	r2, sp, lr, asr r0
    13a0:	91020000 	mrsls	r0, (UNDEF: 2)
    13a4:	0e24206c 	cdpeq	0, 2, cr2, cr4, cr12, {3}
    13a8:	5e010000 	cdppl	0, 0, cr0, cr1, cr0, {0}
    13ac:	00004d2f 	andeq	r4, r0, pc, lsr #26
    13b0:	68910200 	ldmvs	r1, {r9}
    13b4:	00069d20 	andeq	r9, r6, r0, lsr #26
    13b8:	3f5e0100 	svccc	0x005e0100
    13bc:	0000004d 	andeq	r0, r0, sp, asr #32
    13c0:	1e649102 	lgnnes	f1, f2
    13c4:	00001030 	andeq	r1, r0, r0, lsr r0
    13c8:	8b166001 	blhi	5993d4 <__bss_end+0x5904cc>
    13cc:	02000000 	andeq	r0, r0, #0
    13d0:	21007491 			; <UNDEFINED> instruction: 0x21007491
    13d4:	00000f56 	andeq	r0, r0, r6, asr pc
    13d8:	330a5201 	movwcc	r5, #41473	; 0xa201
    13dc:	4d00000d 	stcmi	0, cr0, [r0, #-52]	; 0xffffffcc
    13e0:	dc000000 	stcle	0, cr0, [r0], {-0}
    13e4:	44000084 	strmi	r0, [r0], #-132	; 0xffffff7c
    13e8:	01000000 	mrseq	r0, (UNDEF: 0)
    13ec:	0009269c 	muleq	r9, ip, r6
    13f0:	0a432000 	beq	10c93f8 <__bss_end+0x10c04f0>
    13f4:	52010000 	andpl	r0, r1, #0
    13f8:	00004d1a 	andeq	r4, r0, sl, lsl sp
    13fc:	6c910200 	lfmvs	f0, 4, [r1], {0}
    1400:	000e2420 	andeq	r2, lr, r0, lsr #8
    1404:	29520100 	ldmdbcs	r2, {r8}^
    1408:	0000004d 	andeq	r0, r0, sp, asr #32
    140c:	1e689102 	lgnnee	f1, f2
    1410:	00000f4f 	andeq	r0, r0, pc, asr #30
    1414:	4d0e5401 	cfstrsmi	mvf5, [lr, #-4]
    1418:	02000000 	andeq	r0, r0, #0
    141c:	21007491 			; <UNDEFINED> instruction: 0x21007491
    1420:	00000f49 	andeq	r0, r0, r9, asr #30
    1424:	2b0a4501 	blcs	292830 <__bss_end+0x289928>
    1428:	4d00000f 	stcmi	0, cr0, [r0, #-60]	; 0xffffffc4
    142c:	8c000000 	stchi	0, cr0, [r0], {-0}
    1430:	50000084 	andpl	r0, r0, r4, lsl #1
    1434:	01000000 	mrseq	r0, (UNDEF: 0)
    1438:	0009819c 	muleq	r9, ip, r1
    143c:	0a432000 	beq	10c9444 <__bss_end+0x10c053c>
    1440:	45010000 	strmi	r0, [r1, #-0]
    1444:	00004d19 	andeq	r4, r0, r9, lsl sp
    1448:	6c910200 	lfmvs	f0, 4, [r1], {0}
    144c:	000dc420 	andeq	ip, sp, r0, lsr #8
    1450:	30450100 	subcc	r0, r5, r0, lsl #2
    1454:	0000011d 	andeq	r0, r0, sp, lsl r1
    1458:	20689102 	rsbcs	r9, r8, r2, lsl #2
    145c:	00000e2a 	andeq	r0, r0, sl, lsr #28
    1460:	ac414501 	cfstr64ge	mvdx4, [r1], {1}
    1464:	02000006 	andeq	r0, r0, #6
    1468:	301e6491 	mulscc	lr, r1, r4
    146c:	01000010 	tsteq	r0, r0, lsl r0
    1470:	004d0e47 	subeq	r0, sp, r7, asr #28
    1474:	91020000 	mrsls	r0, (UNDEF: 2)
    1478:	e1230074 	bkpt	0x3004
    147c:	0100000c 	tsteq	r0, ip
    1480:	0dce063f 	stcleq	6, cr0, [lr, #252]	; 0xfc
    1484:	84600000 	strbthi	r0, [r0], #-0
    1488:	002c0000 	eoreq	r0, ip, r0
    148c:	9c010000 	stcls	0, cr0, [r1], {-0}
    1490:	000009ab 	andeq	r0, r0, fp, lsr #19
    1494:	000a4320 	andeq	r4, sl, r0, lsr #6
    1498:	153f0100 	ldrne	r0, [pc, #-256]!	; 13a0 <shift+0x13a0>
    149c:	0000004d 	andeq	r0, r0, sp, asr #32
    14a0:	00749102 	rsbseq	r9, r4, r2, lsl #2
    14a4:	000de921 	andeq	lr, sp, r1, lsr #18
    14a8:	0a320100 	beq	c818b0 <__bss_end+0xc789a8>
    14ac:	00000e30 	andeq	r0, r0, r0, lsr lr
    14b0:	0000004d 	andeq	r0, r0, sp, asr #32
    14b4:	00008410 	andeq	r8, r0, r0, lsl r4
    14b8:	00000050 	andeq	r0, r0, r0, asr r0
    14bc:	0a069c01 	beq	1a84c8 <__bss_end+0x19f5c0>
    14c0:	43200000 	nopmi	{0}	; <UNPREDICTABLE>
    14c4:	0100000a 	tsteq	r0, sl
    14c8:	004d1932 	subeq	r1, sp, r2, lsr r9
    14cc:	91020000 	mrsls	r0, (UNDEF: 2)
    14d0:	0f6c206c 	svceq	0x006c206c
    14d4:	32010000 	andcc	r0, r1, #0
    14d8:	0001f72b 	andeq	pc, r1, fp, lsr #14
    14dc:	68910200 	ldmvs	r1, {r9}
    14e0:	000e5d20 	andeq	r5, lr, r0, lsr #26
    14e4:	3c320100 	ldfccs	f0, [r2], #-0
    14e8:	0000004d 	andeq	r0, r0, sp, asr #32
    14ec:	1e649102 	lgnnes	f1, f2
    14f0:	00000f1a 	andeq	r0, r0, sl, lsl pc
    14f4:	4d0e3401 	cfstrsmi	mvf3, [lr, #-4]
    14f8:	02000000 	andeq	r0, r0, #0
    14fc:	21007491 			; <UNDEFINED> instruction: 0x21007491
    1500:	0000105a 	andeq	r1, r0, sl, asr r0
    1504:	730a2501 	movwvc	r2, #42241	; 0xa501
    1508:	4d00000f 	stcmi	0, cr0, [r0, #-60]	; 0xffffffc4
    150c:	c0000000 	andgt	r0, r0, r0
    1510:	50000083 	andpl	r0, r0, r3, lsl #1
    1514:	01000000 	mrseq	r0, (UNDEF: 0)
    1518:	000a619c 	muleq	sl, ip, r1
    151c:	0a432000 	beq	10c9524 <__bss_end+0x10c061c>
    1520:	25010000 	strcs	r0, [r1, #-0]
    1524:	00004d18 	andeq	r4, r0, r8, lsl sp
    1528:	6c910200 	lfmvs	f0, 4, [r1], {0}
    152c:	000f6c20 	andeq	r6, pc, r0, lsr #24
    1530:	2a250100 	bcs	941938 <__bss_end+0x938a30>
    1534:	00000a67 	andeq	r0, r0, r7, ror #20
    1538:	20689102 	rsbcs	r9, r8, r2, lsl #2
    153c:	00000e5d 	andeq	r0, r0, sp, asr lr
    1540:	4d3b2501 	cfldr32mi	mvfx2, [fp, #-4]!
    1544:	02000000 	andeq	r0, r0, #0
    1548:	001e6491 	mulseq	lr, r1, r4
    154c:	0100000d 	tsteq	r0, sp
    1550:	004d0e27 	subeq	r0, sp, r7, lsr #28
    1554:	91020000 	mrsls	r0, (UNDEF: 2)
    1558:	040d0074 	streq	r0, [sp], #-116	; 0xffffff8c
    155c:	00000025 	andeq	r0, r0, r5, lsr #32
    1560:	000a6103 	andeq	r6, sl, r3, lsl #2
    1564:	0df52100 	ldfeqe	f2, [r5]
    1568:	19010000 	stmdbne	r1, {}	; <UNPREDICTABLE>
    156c:	0010660a 	andseq	r6, r0, sl, lsl #12
    1570:	00004d00 	andeq	r4, r0, r0, lsl #26
    1574:	00837c00 	addeq	r7, r3, r0, lsl #24
    1578:	00004400 	andeq	r4, r0, r0, lsl #8
    157c:	b89c0100 	ldmlt	ip, {r8}
    1580:	2000000a 	andcs	r0, r0, sl
    1584:	00001051 	andeq	r1, r0, r1, asr r0
    1588:	f71b1901 			; <UNDEFINED> instruction: 0xf71b1901
    158c:	02000001 	andeq	r0, r0, #1
    1590:	67206c91 			; <UNDEFINED> instruction: 0x67206c91
    1594:	0100000f 	tsteq	r0, pc
    1598:	01c63519 	biceq	r3, r6, r9, lsl r5
    159c:	91020000 	mrsls	r0, (UNDEF: 2)
    15a0:	0a431e68 	beq	10c8f48 <__bss_end+0x10c0040>
    15a4:	1b010000 	blne	415ac <__bss_end+0x386a4>
    15a8:	00004d0e 	andeq	r4, r0, lr, lsl #26
    15ac:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    15b0:	0d4d2400 	cfstrdeq	mvd2, [sp, #-0]
    15b4:	14010000 	strne	r0, [r1], #-0
    15b8:	000d0606 	andeq	r0, sp, r6, lsl #12
    15bc:	00836000 	addeq	r6, r3, r0
    15c0:	00001c00 	andeq	r1, r0, r0, lsl #24
    15c4:	239c0100 	orrscs	r0, ip, #0, 2
    15c8:	00000f5d 	andeq	r0, r0, sp, asr pc
    15cc:	b6060e01 	strlt	r0, [r6], -r1, lsl #28
    15d0:	3400000d 	strcc	r0, [r0], #-13
    15d4:	2c000083 	stccs	0, cr0, [r0], {131}	; 0x83
    15d8:	01000000 	mrseq	r0, (UNDEF: 0)
    15dc:	000af89c 	muleq	sl, ip, r8
    15e0:	0d442000 	stcleq	0, cr2, [r4, #-0]
    15e4:	0e010000 	cdpeq	0, 0, cr0, cr1, cr0, {0}
    15e8:	00003814 	andeq	r3, r0, r4, lsl r8
    15ec:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    15f0:	105f2500 	subsne	r2, pc, r0, lsl #10
    15f4:	04010000 	streq	r0, [r1], #-0
    15f8:	000dd80a 	andeq	sp, sp, sl, lsl #16
    15fc:	00004d00 	andeq	r4, r0, r0, lsl #26
    1600:	00830800 	addeq	r0, r3, r0, lsl #16
    1604:	00002c00 	andeq	r2, r0, r0, lsl #24
    1608:	229c0100 	addscs	r0, ip, #0, 2
    160c:	00646970 	rsbeq	r6, r4, r0, ror r9
    1610:	4d0e0601 	stcmi	6, cr0, [lr, #-4]
    1614:	02000000 	andeq	r0, r0, #0
    1618:	00007491 	muleq	r0, r1, r4
    161c:	0000032e 	andeq	r0, r0, lr, lsr #6
    1620:	066f0004 	strbteq	r0, [pc], -r4
    1624:	01040000 	mrseq	r0, (UNDEF: 4)
    1628:	00000f7f 	andeq	r0, r0, pc, ror pc
    162c:	0010a604 	andseq	sl, r0, r4, lsl #12
    1630:	000c9600 	andeq	r9, ip, r0, lsl #12
    1634:	00876400 	addeq	r6, r7, r0, lsl #8
    1638:	0004b800 	andeq	fp, r4, r0, lsl #16
    163c:	0007e400 	andeq	lr, r7, r0, lsl #8
    1640:	00490200 	subeq	r0, r9, r0, lsl #4
    1644:	0f030000 	svceq	0x00030000
    1648:	01000011 	tsteq	r0, r1, lsl r0
    164c:	00611005 	rsbeq	r1, r1, r5
    1650:	30110000 	andscc	r0, r1, r0
    1654:	34333231 	ldrtcc	r3, [r3], #-561	; 0xfffffdcf
    1658:	38373635 	ldmdacc	r7!, {r0, r2, r4, r5, r9, sl, ip, sp}
    165c:	43424139 	movtmi	r4, #8505	; 0x2139
    1660:	00464544 	subeq	r4, r6, r4, asr #10
    1664:	03010400 	movweq	r0, #5120	; 0x1400
    1668:	00002501 	andeq	r2, r0, r1, lsl #10
    166c:	00740500 	rsbseq	r0, r4, r0, lsl #10
    1670:	00610000 	rsbeq	r0, r1, r0
    1674:	66060000 	strvs	r0, [r6], -r0
    1678:	10000000 	andne	r0, r0, r0
    167c:	00510700 	subseq	r0, r1, r0, lsl #14
    1680:	04080000 	streq	r0, [r8], #-0
    1684:	00074c07 	andeq	r4, r7, r7, lsl #24
    1688:	08010800 	stmdaeq	r1, {fp}
    168c:	000009c5 	andeq	r0, r0, r5, asr #19
    1690:	00006d07 	andeq	r6, r0, r7, lsl #26
    1694:	002a0900 	eoreq	r0, sl, r0, lsl #18
    1698:	3e0a0000 	cdpcc	0, 0, cr0, cr10, cr0, {0}
    169c:	01000011 	tsteq	r0, r1, lsl r0
    16a0:	11290664 			; <UNDEFINED> instruction: 0x11290664
    16a4:	8b9c0000 	blhi	fe7016ac <__bss_end+0xfe6f87a4>
    16a8:	00800000 	addeq	r0, r0, r0
    16ac:	9c010000 	stcls	0, cr0, [r1], {-0}
    16b0:	000000fb 	strdeq	r0, [r0], -fp
    16b4:	6372730b 	cmnvs	r2, #738197504	; 0x2c000000
    16b8:	19640100 	stmdbne	r4!, {r8}^
    16bc:	000000fb 	strdeq	r0, [r0], -fp
    16c0:	0b649102 	bleq	1925ad0 <__bss_end+0x191cbc8>
    16c4:	00747364 	rsbseq	r7, r4, r4, ror #6
    16c8:	02246401 	eoreq	r6, r4, #16777216	; 0x1000000
    16cc:	02000001 	andeq	r0, r0, #1
    16d0:	6e0b6091 	mcrvs	0, 0, r6, cr11, cr1, {4}
    16d4:	01006d75 	tsteq	r0, r5, ror sp
    16d8:	01042d64 	tsteq	r4, r4, ror #26
    16dc:	91020000 	mrsls	r0, (UNDEF: 2)
    16e0:	11980c5c 	orrsne	r0, r8, ip, asr ip
    16e4:	66010000 	strvs	r0, [r1], -r0
    16e8:	00010b0e 	andeq	r0, r1, lr, lsl #22
    16ec:	70910200 	addsvc	r0, r1, r0, lsl #4
    16f0:	00111b0c 	andseq	r1, r1, ip, lsl #22
    16f4:	08670100 	stmdaeq	r7!, {r8}^
    16f8:	00000111 	andeq	r0, r0, r1, lsl r1
    16fc:	0d6c9102 	stfeqp	f1, [ip, #-8]!
    1700:	00008bc4 	andeq	r8, r0, r4, asr #23
    1704:	00000048 	andeq	r0, r0, r8, asr #32
    1708:	0100690e 	tsteq	r0, lr, lsl #18
    170c:	01040b69 	tsteq	r4, r9, ror #22
    1710:	91020000 	mrsls	r0, (UNDEF: 2)
    1714:	0f000074 	svceq	0x00000074
    1718:	00010104 	andeq	r0, r1, r4, lsl #2
    171c:	04111000 	ldreq	r1, [r1], #-0
    1720:	69050412 	stmdbvs	r5, {r1, r4, sl}
    1724:	0f00746e 	svceq	0x0000746e
    1728:	00007404 	andeq	r7, r0, r4, lsl #8
    172c:	6d040f00 	stcvs	15, cr0, [r4, #-0]
    1730:	0a000000 	beq	1738 <shift+0x1738>
    1734:	0000108d 	andeq	r1, r0, sp, lsl #1
    1738:	9a065c01 	bls	198744 <__bss_end+0x18f83c>
    173c:	34000010 	strcc	r0, [r0], #-16
    1740:	6800008b 	stmdavs	r0, {r0, r1, r3, r7}
    1744:	01000000 	mrseq	r0, (UNDEF: 0)
    1748:	0001769c 	muleq	r1, ip, r6
    174c:	11911300 	orrsne	r1, r1, r0, lsl #6
    1750:	5c010000 	stcpl	0, cr0, [r1], {-0}
    1754:	00010212 	andeq	r0, r1, r2, lsl r2
    1758:	6c910200 	lfmvs	f0, 4, [r1], {0}
    175c:	00109313 	andseq	r9, r0, r3, lsl r3
    1760:	1e5c0100 	rdfnee	f0, f4, f0
    1764:	00000104 	andeq	r0, r0, r4, lsl #2
    1768:	0e689102 	lgneqe	f1, f2
    176c:	006d656d 	rsbeq	r6, sp, sp, ror #10
    1770:	11085e01 	tstne	r8, r1, lsl #28
    1774:	02000001 	andeq	r0, r0, #1
    1778:	500d7091 	mulpl	sp, r1, r0
    177c:	3c00008b 	stccc	0, cr0, [r0], {139}	; 0x8b
    1780:	0e000000 	cdpeq	0, 0, cr0, cr0, cr0, {0}
    1784:	60010069 	andvs	r0, r1, r9, rrx
    1788:	0001040b 	andeq	r0, r1, fp, lsl #8
    178c:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    1790:	45140000 	ldrmi	r0, [r4, #-0]
    1794:	01000011 	tsteq	r0, r1, lsl r0
    1798:	115e0552 	cmpne	lr, r2, asr r5
    179c:	01040000 	mrseq	r0, (UNDEF: 4)
    17a0:	8ae00000 	bhi	ff8017a8 <__bss_end+0xff7f88a0>
    17a4:	00540000 	subseq	r0, r4, r0
    17a8:	9c010000 	stcls	0, cr0, [r1], {-0}
    17ac:	000001af 	andeq	r0, r0, pc, lsr #3
    17b0:	0100730b 	tsteq	r0, fp, lsl #6
    17b4:	010b1852 	tsteq	fp, r2, asr r8
    17b8:	91020000 	mrsls	r0, (UNDEF: 2)
    17bc:	00690e6c 	rsbeq	r0, r9, ip, ror #28
    17c0:	04065401 	streq	r5, [r6], #-1025	; 0xfffffbff
    17c4:	02000001 	andeq	r0, r0, #1
    17c8:	14007491 	strne	r7, [r0], #-1169	; 0xfffffb6f
    17cc:	00001181 	andeq	r1, r0, r1, lsl #3
    17d0:	4c054201 	sfmmi	f4, 4, [r5], {1}
    17d4:	04000011 	streq	r0, [r0], #-17	; 0xffffffef
    17d8:	34000001 	strcc	r0, [r0], #-1
    17dc:	ac00008a 	stcge	0, cr0, [r0], {138}	; 0x8a
    17e0:	01000000 	mrseq	r0, (UNDEF: 0)
    17e4:	0002159c 	muleq	r2, ip, r5
    17e8:	31730b00 	cmncc	r3, r0, lsl #22
    17ec:	19420100 	stmdbne	r2, {r8}^
    17f0:	0000010b 	andeq	r0, r0, fp, lsl #2
    17f4:	0b6c9102 	bleq	1b25c04 <__bss_end+0x1b1ccfc>
    17f8:	01003273 	tsteq	r0, r3, ror r2
    17fc:	010b2942 	tsteq	fp, r2, asr #18
    1800:	91020000 	mrsls	r0, (UNDEF: 2)
    1804:	756e0b68 	strbvc	r0, [lr, #-2920]!	; 0xfffff498
    1808:	4201006d 	andmi	r0, r1, #109	; 0x6d
    180c:	00010431 	andeq	r0, r1, r1, lsr r4
    1810:	64910200 	ldrvs	r0, [r1], #512	; 0x200
    1814:	0031750e 	eorseq	r7, r1, lr, lsl #10
    1818:	15104401 	ldrne	r4, [r0, #-1025]	; 0xfffffbff
    181c:	02000002 	andeq	r0, r0, #2
    1820:	750e7791 	strvc	r7, [lr, #-1937]	; 0xfffff86f
    1824:	44010032 	strmi	r0, [r1], #-50	; 0xffffffce
    1828:	00021514 	andeq	r1, r2, r4, lsl r5
    182c:	76910200 	ldrvc	r0, [r1], r0, lsl #4
    1830:	08010800 	stmdaeq	r1, {fp}
    1834:	000009bc 			; <UNDEFINED> instruction: 0x000009bc
    1838:	00118914 	andseq	r8, r1, r4, lsl r9
    183c:	07360100 	ldreq	r0, [r6, -r0, lsl #2]!
    1840:	00001170 	andeq	r1, r0, r0, ror r1
    1844:	00000111 	andeq	r0, r0, r1, lsl r1
    1848:	00008974 	andeq	r8, r0, r4, ror r9
    184c:	000000c0 	andeq	r0, r0, r0, asr #1
    1850:	02759c01 	rsbseq	r9, r5, #256	; 0x100
    1854:	88130000 	ldmdahi	r3, {}	; <UNPREDICTABLE>
    1858:	01000010 	tsteq	r0, r0, lsl r0
    185c:	01111536 	tsteq	r1, r6, lsr r5
    1860:	91020000 	mrsls	r0, (UNDEF: 2)
    1864:	72730b6c 	rsbsvc	r0, r3, #108, 22	; 0x1b000
    1868:	36010063 	strcc	r0, [r1], -r3, rrx
    186c:	00010b27 	andeq	r0, r1, r7, lsr #22
    1870:	68910200 	ldmvs	r1, {r9}
    1874:	6d756e0b 	ldclvs	14, cr6, [r5, #-44]!	; 0xffffffd4
    1878:	30360100 	eorscc	r0, r6, r0, lsl #2
    187c:	00000104 	andeq	r0, r0, r4, lsl #2
    1880:	0e649102 	lgneqs	f1, f2
    1884:	38010069 	stmdacc	r1, {r0, r3, r5, r6}
    1888:	00010406 	andeq	r0, r1, r6, lsl #8
    188c:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    1890:	116b1400 	cmnne	fp, r0, lsl #8
    1894:	24010000 	strcs	r0, [r1], #-0
    1898:	00110405 	andseq	r0, r1, r5, lsl #8
    189c:	00010400 	andeq	r0, r1, r0, lsl #8
    18a0:	0088d800 	addeq	sp, r8, r0, lsl #16
    18a4:	00009c00 	andeq	r9, r0, r0, lsl #24
    18a8:	b29c0100 	addslt	r0, ip, #0, 2
    18ac:	13000002 	movwne	r0, #2
    18b0:	00001082 	andeq	r1, r0, r2, lsl #1
    18b4:	0b162401 	bleq	58a8c0 <__bss_end+0x5819b8>
    18b8:	02000001 	andeq	r0, r0, #1
    18bc:	220c6c91 	andcs	r6, ip, #37120	; 0x9100
    18c0:	01000011 	tsteq	r0, r1, lsl r0
    18c4:	01040626 	tsteq	r4, r6, lsr #12
    18c8:	91020000 	mrsls	r0, (UNDEF: 2)
    18cc:	9f150074 	svcls	0x00150074
    18d0:	01000011 	tsteq	r0, r1, lsl r0
    18d4:	11a40608 			; <UNDEFINED> instruction: 0x11a40608
    18d8:	87640000 	strbhi	r0, [r4, -r0]!
    18dc:	01740000 	cmneq	r4, r0
    18e0:	9c010000 	stcls	0, cr0, [r1], {-0}
    18e4:	00108213 	andseq	r8, r0, r3, lsl r2
    18e8:	18080100 	stmdane	r8, {r8}
    18ec:	00000066 	andeq	r0, r0, r6, rrx
    18f0:	13649102 	cmnne	r4, #-2147483648	; 0x80000000
    18f4:	00001122 	andeq	r1, r0, r2, lsr #2
    18f8:	11250801 			; <UNDEFINED> instruction: 0x11250801
    18fc:	02000001 	andeq	r0, r0, #1
    1900:	39136091 	ldmdbcc	r3, {r0, r4, r7, sp, lr}
    1904:	01000011 	tsteq	r0, r1, lsl r0
    1908:	00663a08 	rsbeq	r3, r6, r8, lsl #20
    190c:	91020000 	mrsls	r0, (UNDEF: 2)
    1910:	00690e5c 	rsbeq	r0, r9, ip, asr lr
    1914:	04060a01 	streq	r0, [r6], #-2561	; 0xfffff5ff
    1918:	02000001 	andeq	r0, r0, #1
    191c:	300d7491 	mulcc	sp, r1, r4
    1920:	98000088 	stmdals	r0, {r3, r7}
    1924:	0e000000 	cdpeq	0, 0, cr0, cr0, cr0, {0}
    1928:	1c01006a 	stcne	0, cr0, [r1], {106}	; 0x6a
    192c:	0001040b 	andeq	r0, r1, fp, lsl #8
    1930:	70910200 	addsvc	r0, r1, r0, lsl #4
    1934:	0088580d 	addeq	r5, r8, sp, lsl #16
    1938:	00006000 	andeq	r6, r0, r0
    193c:	00630e00 	rsbeq	r0, r3, r0, lsl #28
    1940:	6d081e01 	stcvs	14, cr1, [r8, #-4]
    1944:	02000000 	andeq	r0, r0, #0
    1948:	00006f91 	muleq	r0, r1, pc	; <UNPREDICTABLE>
	...

Disassembly of section .debug_abbrev:

00000000 <.debug_abbrev>:
   0:	10001101 	andne	r1, r0, r1, lsl #2
   4:	12011106 	andne	r1, r1, #-2147483647	; 0x80000001
   8:	1b0e0301 	blne	380c14 <__bss_end+0x377d0c>
   c:	130e250e 	movwne	r2, #58638	; 0xe50e
  10:	00000005 	andeq	r0, r0, r5
  14:	25011101 	strcs	r1, [r1, #-257]	; 0xfffffeff
  18:	030b130e 	movweq	r1, #45838	; 0xb30e
  1c:	110e1b0e 	tstne	lr, lr, lsl #22
  20:	10061201 	andne	r1, r6, r1, lsl #4
  24:	02000017 	andeq	r0, r0, #23
  28:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
  2c:	0b3b0b3a 	bleq	ec2d1c <__bss_end+0xeb9e14>
  30:	13490b39 	movtne	r0, #39737	; 0x9b39
  34:	193c193f 	ldmdbne	ip!, {r0, r1, r2, r3, r4, r5, r8, fp, ip}
  38:	24030000 	strcs	r0, [r3], #-0
  3c:	3e0b0b00 	vmlacc.f64	d0, d11, d0
  40:	000e030b 	andeq	r0, lr, fp, lsl #6
  44:	012e0400 			; <UNDEFINED> instruction: 0x012e0400
  48:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
  4c:	0b3b0b3a 	bleq	ec2d3c <__bss_end+0xeb9e34>
  50:	01110b39 	tsteq	r1, r9, lsr fp
  54:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
  58:	01194296 			; <UNDEFINED> instruction: 0x01194296
  5c:	05000013 	streq	r0, [r0, #-19]	; 0xffffffed
  60:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
  64:	0b3b0b3a 	bleq	ec2d54 <__bss_end+0xeb9e4c>
  68:	13490b39 	movtne	r0, #39737	; 0x9b39
  6c:	00001802 	andeq	r1, r0, r2, lsl #16
  70:	0b002406 	bleq	9090 <__bss_end+0x188>
  74:	030b3e0b 	movweq	r3, #48651	; 0xbe0b
  78:	07000008 	streq	r0, [r0, -r8]
  7c:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
  80:	0b3a0e03 	bleq	e83894 <__bss_end+0xe7a98c>
  84:	0b390b3b 	bleq	e42d78 <__bss_end+0xe39e70>
  88:	06120111 			; <UNDEFINED> instruction: 0x06120111
  8c:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
  90:	00130119 	andseq	r0, r3, r9, lsl r1
  94:	010b0800 	tsteq	fp, r0, lsl #16
  98:	06120111 			; <UNDEFINED> instruction: 0x06120111
  9c:	34090000 	strcc	r0, [r9], #-0
  a0:	3a080300 	bcc	200ca8 <__bss_end+0x1f7da0>
  a4:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
  a8:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
  ac:	0a000018 	beq	114 <shift+0x114>
  b0:	0b0b000f 	bleq	2c00f4 <__bss_end+0x2b71ec>
  b4:	00001349 	andeq	r1, r0, r9, asr #6
  b8:	01110100 	tsteq	r1, r0, lsl #2
  bc:	0b130e25 	bleq	4c3958 <__bss_end+0x4baa50>
  c0:	0e1b0e03 	cdpeq	14, 1, cr0, cr11, cr3, {0}
  c4:	06120111 			; <UNDEFINED> instruction: 0x06120111
  c8:	00001710 	andeq	r1, r0, r0, lsl r7
  cc:	03001602 	movweq	r1, #1538	; 0x602
  d0:	3b0b3a0e 	blcc	2ce910 <__bss_end+0x2c5a08>
  d4:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
  d8:	03000013 	movweq	r0, #19
  dc:	0b0b000f 	bleq	2c0120 <__bss_end+0x2b7218>
  e0:	00001349 	andeq	r1, r0, r9, asr #6
  e4:	00001504 	andeq	r1, r0, r4, lsl #10
  e8:	01010500 	tsteq	r1, r0, lsl #10
  ec:	13011349 	movwne	r1, #4937	; 0x1349
  f0:	21060000 	mrscs	r0, (UNDEF: 6)
  f4:	2f134900 	svccs	0x00134900
  f8:	07000006 	streq	r0, [r0, -r6]
  fc:	0b0b0024 	bleq	2c0194 <__bss_end+0x2b728c>
 100:	0e030b3e 	vmoveq.16	d3[0], r0
 104:	34080000 	strcc	r0, [r8], #-0
 108:	3a0e0300 	bcc	380d10 <__bss_end+0x377e08>
 10c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 110:	3f13490b 	svccc	0x0013490b
 114:	00193c19 	andseq	r3, r9, r9, lsl ip
 118:	012e0900 			; <UNDEFINED> instruction: 0x012e0900
 11c:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 120:	0b3b0b3a 	bleq	ec2e10 <__bss_end+0xeb9f08>
 124:	13490b39 	movtne	r0, #39737	; 0x9b39
 128:	06120111 			; <UNDEFINED> instruction: 0x06120111
 12c:	42961840 	addsmi	r1, r6, #64, 16	; 0x400000
 130:	00130119 	andseq	r0, r3, r9, lsl r1
 134:	00340a00 	eorseq	r0, r4, r0, lsl #20
 138:	0b3a0e03 	bleq	e8394c <__bss_end+0xe7aa44>
 13c:	0b390b3b 	bleq	e42e30 <__bss_end+0xe39f28>
 140:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 144:	240b0000 	strcs	r0, [fp], #-0
 148:	3e0b0b00 	vmlacc.f64	d0, d11, d0
 14c:	0008030b 	andeq	r0, r8, fp, lsl #6
 150:	002e0c00 	eoreq	r0, lr, r0, lsl #24
 154:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 158:	0b3b0b3a 	bleq	ec2e48 <__bss_end+0xeb9f40>
 15c:	01110b39 	tsteq	r1, r9, lsr fp
 160:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 164:	00194297 	mulseq	r9, r7, r2
 168:	01390d00 	teqeq	r9, r0, lsl #26
 16c:	0b3a0e03 	bleq	e83980 <__bss_end+0xe7aa78>
 170:	13010b3b 	movwne	r0, #6971	; 0x1b3b
 174:	2e0e0000 	cdpcs	0, 0, cr0, cr14, cr0, {0}
 178:	03193f01 	tsteq	r9, #1, 30
 17c:	3b0b3a0e 	blcc	2ce9bc <__bss_end+0x2c5ab4>
 180:	3c0b390b 			; <UNDEFINED> instruction: 0x3c0b390b
 184:	00130119 	andseq	r0, r3, r9, lsl r1
 188:	00050f00 	andeq	r0, r5, r0, lsl #30
 18c:	00001349 	andeq	r1, r0, r9, asr #6
 190:	3f012e10 	svccc	0x00012e10
 194:	3a0e0319 	bcc	380e00 <__bss_end+0x377ef8>
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
 1c0:	3a080300 	bcc	200dc8 <__bss_end+0x1f7ec0>
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
 1f4:	0b0b0024 	bleq	2c028c <__bss_end+0x2b7384>
 1f8:	0e030b3e 	vmoveq.16	d3[0], r0
 1fc:	24030000 	strcs	r0, [r3], #-0
 200:	3e0b0b00 	vmlacc.f64	d0, d11, d0
 204:	0008030b 	andeq	r0, r8, fp, lsl #6
 208:	00160400 	andseq	r0, r6, r0, lsl #8
 20c:	0b3a0e03 	bleq	e83a20 <__bss_end+0xe7ab18>
 210:	0b390b3b 	bleq	e42f04 <__bss_end+0xe39ffc>
 214:	00001349 	andeq	r1, r0, r9, asr #6
 218:	49002605 	stmdbmi	r0, {r0, r2, r9, sl, sp}
 21c:	06000013 			; <UNDEFINED> instruction: 0x06000013
 220:	0e030113 	mcreq	1, 0, r0, cr3, cr3, {0}
 224:	0b3a0b0b 	bleq	e82e58 <__bss_end+0xe79f50>
 228:	0b390b3b 	bleq	e42f1c <__bss_end+0xe3a014>
 22c:	00001301 	andeq	r1, r0, r1, lsl #6
 230:	03000d07 	movweq	r0, #3335	; 0xd07
 234:	3b0b3a08 	blcc	2cea5c <__bss_end+0x2c5b54>
 238:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 23c:	000b3813 	andeq	r3, fp, r3, lsl r8
 240:	01040800 	tsteq	r4, r0, lsl #16
 244:	196d0e03 	stmdbne	sp!, {r0, r1, r9, sl, fp}^
 248:	0b0b0b3e 	bleq	2c2f48 <__bss_end+0x2ba040>
 24c:	0b3a1349 	bleq	e84f78 <__bss_end+0xe7c070>
 250:	0b390b3b 	bleq	e42f44 <__bss_end+0xe3a03c>
 254:	00001301 	andeq	r1, r0, r1, lsl #6
 258:	03002809 	movweq	r2, #2057	; 0x809
 25c:	000b1c0e 	andeq	r1, fp, lr, lsl #24
 260:	00340a00 	eorseq	r0, r4, r0, lsl #20
 264:	0b3a0e03 	bleq	e83a78 <__bss_end+0xe7ab70>
 268:	0b390b3b 	bleq	e42f5c <__bss_end+0xe3a054>
 26c:	196c1349 	stmdbne	ip!, {r0, r3, r6, r8, r9, ip}^
 270:	00001802 	andeq	r1, r0, r2, lsl #16
 274:	0300020b 	movweq	r0, #523	; 0x20b
 278:	00193c0e 	andseq	r3, r9, lr, lsl #24
 27c:	000f0c00 	andeq	r0, pc, r0, lsl #24
 280:	13490b0b 	movtne	r0, #39691	; 0x9b0b
 284:	280d0000 	stmdacs	sp, {}	; <UNPREDICTABLE>
 288:	1c080300 	stcne	3, cr0, [r8], {-0}
 28c:	0e00000b 	cdpeq	0, 0, cr0, cr0, cr11, {0}
 290:	0e03000d 	cdpeq	0, 0, cr0, cr3, cr13, {0}
 294:	0b3b0b3a 	bleq	ec2f84 <__bss_end+0xeba07c>
 298:	13490b39 	movtne	r0, #39737	; 0x9b39
 29c:	00000b38 	andeq	r0, r0, r8, lsr fp
 2a0:	4901010f 	stmdbmi	r1, {r0, r1, r2, r3, r8}
 2a4:	00130113 	andseq	r0, r3, r3, lsl r1
 2a8:	00211000 	eoreq	r1, r1, r0
 2ac:	0b2f1349 	bleq	bc4fd8 <__bss_end+0xbbc0d0>
 2b0:	02110000 	andseq	r0, r1, #0
 2b4:	0b0e0301 	bleq	380ec0 <__bss_end+0x377fb8>
 2b8:	3b0b3a0b 	blcc	2ceaec <__bss_end+0x2c5be4>
 2bc:	010b390b 	tsteq	fp, fp, lsl #18
 2c0:	12000013 	andne	r0, r0, #19
 2c4:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 2c8:	0b3a0e03 	bleq	e83adc <__bss_end+0xe7abd4>
 2cc:	0b390b3b 	bleq	e42fc0 <__bss_end+0xe3a0b8>
 2d0:	193c0e6e 	ldmdbne	ip!, {r1, r2, r3, r5, r6, r9, sl, fp}
 2d4:	13011364 	movwne	r1, #4964	; 0x1364
 2d8:	05130000 	ldreq	r0, [r3, #-0]
 2dc:	34134900 	ldrcc	r4, [r3], #-2304	; 0xfffff700
 2e0:	14000019 	strne	r0, [r0], #-25	; 0xffffffe7
 2e4:	13490005 	movtne	r0, #36869	; 0x9005
 2e8:	2e150000 	cdpcs	0, 1, cr0, cr5, cr0, {0}
 2ec:	03193f01 	tsteq	r9, #1, 30
 2f0:	3b0b3a0e 	blcc	2ceb30 <__bss_end+0x2c5c28>
 2f4:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 2f8:	3c13490e 			; <UNDEFINED> instruction: 0x3c13490e
 2fc:	01136419 	tsteq	r3, r9, lsl r4
 300:	16000013 			; <UNDEFINED> instruction: 0x16000013
 304:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 308:	0b3a0e03 	bleq	e83b1c <__bss_end+0xe7ac14>
 30c:	0b390b3b 	bleq	e43000 <__bss_end+0xe3a0f8>
 310:	13490e6e 	movtne	r0, #40558	; 0x9e6e
 314:	193c0b32 	ldmdbne	ip!, {r1, r4, r5, r8, r9, fp}
 318:	13011364 	movwne	r1, #4964	; 0x1364
 31c:	0d170000 	ldceq	0, cr0, [r7, #-0]
 320:	3a0e0300 	bcc	380f28 <__bss_end+0x378020>
 324:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 328:	3813490b 	ldmdacc	r3, {r0, r1, r3, r8, fp, lr}
 32c:	000b320b 	andeq	r3, fp, fp, lsl #4
 330:	012e1800 			; <UNDEFINED> instruction: 0x012e1800
 334:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 338:	0b3b0b3a 	bleq	ec3028 <__bss_end+0xeba120>
 33c:	0e6e0b39 	vmoveq.8	d14[5], r0
 340:	193c0b32 	ldmdbne	ip!, {r1, r4, r5, r8, r9, fp}
 344:	13011364 	movwne	r1, #4964	; 0x1364
 348:	2e190000 	cdpcs	0, 1, cr0, cr9, cr0, {0}
 34c:	03193f01 	tsteq	r9, #1, 30
 350:	3b0b3a0e 	blcc	2ceb90 <__bss_end+0x2c5c88>
 354:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 358:	3213490e 	andscc	r4, r3, #229376	; 0x38000
 35c:	64193c0b 	ldrvs	r3, [r9], #-3083	; 0xfffff3f5
 360:	1a000013 	bne	3b4 <shift+0x3b4>
 364:	13490115 	movtne	r0, #37141	; 0x9115
 368:	13011364 	movwne	r1, #4964	; 0x1364
 36c:	1f1b0000 	svcne	0x001b0000
 370:	49131d00 	ldmdbmi	r3, {r8, sl, fp, ip}
 374:	1c000013 	stcne	0, cr0, [r0], {19}
 378:	0b0b0010 	bleq	2c03c0 <__bss_end+0x2b74b8>
 37c:	00001349 	andeq	r1, r0, r9, asr #6
 380:	0b000f1d 	bleq	3ffc <shift+0x3ffc>
 384:	1e00000b 	cdpne	0, 0, cr0, cr0, cr11, {0}
 388:	08030139 	stmdaeq	r3, {r0, r3, r4, r5, r8}
 38c:	0b3b0b3a 	bleq	ec307c <__bss_end+0xeba174>
 390:	13010b39 	movwne	r0, #6969	; 0x1b39
 394:	341f0000 	ldrcc	r0, [pc], #-0	; 39c <shift+0x39c>
 398:	3a0e0300 	bcc	380fa0 <__bss_end+0x378098>
 39c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 3a0:	3c13490b 			; <UNDEFINED> instruction: 0x3c13490b
 3a4:	6c061c19 	stcvs	12, cr1, [r6], {25}
 3a8:	20000019 	andcs	r0, r0, r9, lsl r0
 3ac:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 3b0:	0b3b0b3a 	bleq	ec30a0 <__bss_end+0xeba198>
 3b4:	13490b39 	movtne	r0, #39737	; 0x9b39
 3b8:	0b1c193c 	bleq	7068b0 <__bss_end+0x6fd9a8>
 3bc:	0000196c 	andeq	r1, r0, ip, ror #18
 3c0:	47003421 	strmi	r3, [r0, -r1, lsr #8]
 3c4:	22000013 	andcs	r0, r0, #19
 3c8:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 3cc:	0b3a0e03 	bleq	e83be0 <__bss_end+0xe7acd8>
 3d0:	0b390b3b 	bleq	e430c4 <__bss_end+0xe3a1bc>
 3d4:	01111349 	tsteq	r1, r9, asr #6
 3d8:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 3dc:	01194296 			; <UNDEFINED> instruction: 0x01194296
 3e0:	23000013 	movwcs	r0, #19
 3e4:	0e030005 	cdpeq	0, 0, cr0, cr3, cr5, {0}
 3e8:	0b3b0b3a 	bleq	ec30d8 <__bss_end+0xeba1d0>
 3ec:	13490b39 	movtne	r0, #39737	; 0x9b39
 3f0:	00001802 	andeq	r1, r0, r2, lsl #16
 3f4:	03003424 	movweq	r3, #1060	; 0x424
 3f8:	3b0b3a0e 	blcc	2cec38 <__bss_end+0x2c5d30>
 3fc:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 400:	00180213 	andseq	r0, r8, r3, lsl r2
 404:	11010000 	mrsne	r0, (UNDEF: 1)
 408:	130e2501 	movwne	r2, #58625	; 0xe501
 40c:	1b0e030b 	blne	381040 <__bss_end+0x378138>
 410:	1201110e 	andne	r1, r1, #-2147483645	; 0x80000003
 414:	00171006 	andseq	r1, r7, r6
 418:	00240200 	eoreq	r0, r4, r0, lsl #4
 41c:	0b3e0b0b 	bleq	f83050 <__bss_end+0xf7a148>
 420:	00000e03 	andeq	r0, r0, r3, lsl #28
 424:	49002603 	stmdbmi	r0, {r0, r1, r9, sl, sp}
 428:	04000013 	streq	r0, [r0], #-19	; 0xffffffed
 42c:	0b0b0024 	bleq	2c04c4 <__bss_end+0x2b75bc>
 430:	08030b3e 	stmdaeq	r3, {r1, r2, r3, r4, r5, r8, r9, fp}
 434:	16050000 	strne	r0, [r5], -r0
 438:	3a0e0300 	bcc	381040 <__bss_end+0x378138>
 43c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 440:	0013490b 	andseq	r4, r3, fp, lsl #18
 444:	01130600 	tsteq	r3, r0, lsl #12
 448:	0b0b0e03 	bleq	2c3c5c <__bss_end+0x2bad54>
 44c:	0b3b0b3a 	bleq	ec313c <__bss_end+0xeba234>
 450:	13010b39 	movwne	r0, #6969	; 0x1b39
 454:	0d070000 	stceq	0, cr0, [r7, #-0]
 458:	3a080300 	bcc	201060 <__bss_end+0x1f8158>
 45c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 460:	3813490b 	ldmdacc	r3, {r0, r1, r3, r8, fp, lr}
 464:	0800000b 	stmdaeq	r0, {r0, r1, r3}
 468:	0e030104 	adfeqs	f0, f3, f4
 46c:	0b3e196d 	bleq	f86a28 <__bss_end+0xf7db20>
 470:	13490b0b 	movtne	r0, #39691	; 0x9b0b
 474:	0b3b0b3a 	bleq	ec3164 <__bss_end+0xeba25c>
 478:	13010b39 	movwne	r0, #6969	; 0x1b39
 47c:	28090000 	stmdacs	r9, {}	; <UNPREDICTABLE>
 480:	1c080300 	stcne	3, cr0, [r8], {-0}
 484:	0a00000b 	beq	4b8 <shift+0x4b8>
 488:	0e030028 	cdpeq	0, 0, cr0, cr3, cr8, {1}
 48c:	00000b1c 	andeq	r0, r0, ip, lsl fp
 490:	0300340b 	movweq	r3, #1035	; 0x40b
 494:	3b0b3a0e 	blcc	2cecd4 <__bss_end+0x2c5dcc>
 498:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 49c:	02196c13 	andseq	r6, r9, #4864	; 0x1300
 4a0:	0c000018 	stceq	0, cr0, [r0], {24}
 4a4:	0e030002 	cdpeq	0, 0, cr0, cr3, cr2, {0}
 4a8:	0000193c 	andeq	r1, r0, ip, lsr r9
 4ac:	0b000f0d 	bleq	40e8 <shift+0x40e8>
 4b0:	0013490b 	andseq	r4, r3, fp, lsl #18
 4b4:	000d0e00 	andeq	r0, sp, r0, lsl #28
 4b8:	0b3a0e03 	bleq	e83ccc <__bss_end+0xe7adc4>
 4bc:	0b390b3b 	bleq	e431b0 <__bss_end+0xe3a2a8>
 4c0:	0b381349 	bleq	e051ec <__bss_end+0xdfc2e4>
 4c4:	010f0000 	mrseq	r0, CPSR
 4c8:	01134901 	tsteq	r3, r1, lsl #18
 4cc:	10000013 	andne	r0, r0, r3, lsl r0
 4d0:	13490021 	movtne	r0, #36897	; 0x9021
 4d4:	00000b2f 	andeq	r0, r0, pc, lsr #22
 4d8:	03010211 	movweq	r0, #4625	; 0x1211
 4dc:	3a0b0b0e 	bcc	2c311c <__bss_end+0x2ba214>
 4e0:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 4e4:	0013010b 	andseq	r0, r3, fp, lsl #2
 4e8:	012e1200 			; <UNDEFINED> instruction: 0x012e1200
 4ec:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 4f0:	0b3b0b3a 	bleq	ec31e0 <__bss_end+0xeba2d8>
 4f4:	0e6e0b39 	vmoveq.8	d14[5], r0
 4f8:	1364193c 	cmnne	r4, #60, 18	; 0xf0000
 4fc:	00001301 	andeq	r1, r0, r1, lsl #6
 500:	49000513 	stmdbmi	r0, {r0, r1, r4, r8, sl}
 504:	00193413 	andseq	r3, r9, r3, lsl r4
 508:	00051400 	andeq	r1, r5, r0, lsl #8
 50c:	00001349 	andeq	r1, r0, r9, asr #6
 510:	3f012e15 	svccc	0x00012e15
 514:	3a0e0319 	bcc	381180 <__bss_end+0x378278>
 518:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 51c:	490e6e0b 	stmdbmi	lr, {r0, r1, r3, r9, sl, fp, sp, lr}
 520:	64193c13 	ldrvs	r3, [r9], #-3091	; 0xfffff3ed
 524:	00130113 	andseq	r0, r3, r3, lsl r1
 528:	012e1600 			; <UNDEFINED> instruction: 0x012e1600
 52c:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 530:	0b3b0b3a 	bleq	ec3220 <__bss_end+0xeba318>
 534:	0e6e0b39 	vmoveq.8	d14[5], r0
 538:	0b321349 	bleq	c85264 <__bss_end+0xc7c35c>
 53c:	1364193c 	cmnne	r4, #60, 18	; 0xf0000
 540:	00001301 	andeq	r1, r0, r1, lsl #6
 544:	03000d17 	movweq	r0, #3351	; 0xd17
 548:	3b0b3a0e 	blcc	2ced88 <__bss_end+0x2c5e80>
 54c:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 550:	320b3813 	andcc	r3, fp, #1245184	; 0x130000
 554:	1800000b 	stmdane	r0, {r0, r1, r3}
 558:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 55c:	0b3a0e03 	bleq	e83d70 <__bss_end+0xe7ae68>
 560:	0b390b3b 	bleq	e43254 <__bss_end+0xe3a34c>
 564:	0b320e6e 	bleq	c83f24 <__bss_end+0xc7b01c>
 568:	1364193c 	cmnne	r4, #60, 18	; 0xf0000
 56c:	00001301 	andeq	r1, r0, r1, lsl #6
 570:	3f012e19 	svccc	0x00012e19
 574:	3a0e0319 	bcc	3811e0 <__bss_end+0x3782d8>
 578:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 57c:	490e6e0b 	stmdbmi	lr, {r0, r1, r3, r9, sl, fp, sp, lr}
 580:	3c0b3213 	sfmcc	f3, 4, [fp], {19}
 584:	00136419 	andseq	r6, r3, r9, lsl r4
 588:	01151a00 	tsteq	r5, r0, lsl #20
 58c:	13641349 	cmnne	r4, #603979777	; 0x24000001
 590:	00001301 	andeq	r1, r0, r1, lsl #6
 594:	1d001f1b 	stcne	15, cr1, [r0, #-108]	; 0xffffff94
 598:	00134913 	andseq	r4, r3, r3, lsl r9
 59c:	00101c00 	andseq	r1, r0, r0, lsl #24
 5a0:	13490b0b 	movtne	r0, #39691	; 0x9b0b
 5a4:	0f1d0000 	svceq	0x001d0000
 5a8:	000b0b00 	andeq	r0, fp, r0, lsl #22
 5ac:	00341e00 	eorseq	r1, r4, r0, lsl #28
 5b0:	0b3a0e03 	bleq	e83dc4 <__bss_end+0xe7aebc>
 5b4:	0b390b3b 	bleq	e432a8 <__bss_end+0xe3a3a0>
 5b8:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 5bc:	2e1f0000 	cdpcs	0, 1, cr0, cr15, cr0, {0}
 5c0:	03193f01 	tsteq	r9, #1, 30
 5c4:	3b0b3a0e 	blcc	2cee04 <__bss_end+0x2c5efc>
 5c8:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 5cc:	1113490e 	tstne	r3, lr, lsl #18
 5d0:	40061201 	andmi	r1, r6, r1, lsl #4
 5d4:	19429618 	stmdbne	r2, {r3, r4, r9, sl, ip, pc}^
 5d8:	00001301 	andeq	r1, r0, r1, lsl #6
 5dc:	03000520 	movweq	r0, #1312	; 0x520
 5e0:	3b0b3a0e 	blcc	2cee20 <__bss_end+0x2c5f18>
 5e4:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 5e8:	00180213 	andseq	r0, r8, r3, lsl r2
 5ec:	012e2100 			; <UNDEFINED> instruction: 0x012e2100
 5f0:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 5f4:	0b3b0b3a 	bleq	ec32e4 <__bss_end+0xeba3dc>
 5f8:	0e6e0b39 	vmoveq.8	d14[5], r0
 5fc:	01111349 	tsteq	r1, r9, asr #6
 600:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 604:	01194297 			; <UNDEFINED> instruction: 0x01194297
 608:	22000013 	andcs	r0, r0, #19
 60c:	08030034 	stmdaeq	r3, {r2, r4, r5}
 610:	0b3b0b3a 	bleq	ec3300 <__bss_end+0xeba3f8>
 614:	13490b39 	movtne	r0, #39737	; 0x9b39
 618:	00001802 	andeq	r1, r0, r2, lsl #16
 61c:	3f012e23 	svccc	0x00012e23
 620:	3a0e0319 	bcc	38128c <__bss_end+0x378384>
 624:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 628:	110e6e0b 	tstne	lr, fp, lsl #28
 62c:	40061201 	andmi	r1, r6, r1, lsl #4
 630:	19429718 	stmdbne	r2, {r3, r4, r8, r9, sl, ip, pc}^
 634:	00001301 	andeq	r1, r0, r1, lsl #6
 638:	3f002e24 	svccc	0x00002e24
 63c:	3a0e0319 	bcc	3812a8 <__bss_end+0x3783a0>
 640:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 644:	110e6e0b 	tstne	lr, fp, lsl #28
 648:	40061201 	andmi	r1, r6, r1, lsl #4
 64c:	19429718 	stmdbne	r2, {r3, r4, r8, r9, sl, ip, pc}^
 650:	2e250000 	cdpcs	0, 2, cr0, cr5, cr0, {0}
 654:	03193f01 	tsteq	r9, #1, 30
 658:	3b0b3a0e 	blcc	2cee98 <__bss_end+0x2c5f90>
 65c:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 660:	1113490e 	tstne	r3, lr, lsl #18
 664:	40061201 	andmi	r1, r6, r1, lsl #4
 668:	19429718 	stmdbne	r2, {r3, r4, r8, r9, sl, ip, pc}^
 66c:	01000000 	mrseq	r0, (UNDEF: 0)
 670:	0e250111 	mcreq	1, 1, r0, cr5, cr1, {0}
 674:	0e030b13 	vmoveq.32	d3[0], r0
 678:	01110e1b 	tsteq	r1, fp, lsl lr
 67c:	17100612 			; <UNDEFINED> instruction: 0x17100612
 680:	39020000 	stmdbcc	r2, {}	; <UNPREDICTABLE>
 684:	00130101 	andseq	r0, r3, r1, lsl #2
 688:	00340300 	eorseq	r0, r4, r0, lsl #6
 68c:	0b3a0e03 	bleq	e83ea0 <__bss_end+0xe7af98>
 690:	0b390b3b 	bleq	e43384 <__bss_end+0xe3a47c>
 694:	193c1349 	ldmdbne	ip!, {r0, r3, r6, r8, r9, ip}
 698:	00000a1c 	andeq	r0, r0, ip, lsl sl
 69c:	3a003a04 	bcc	eeb4 <__bss_end+0x5fac>
 6a0:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 6a4:	0013180b 	andseq	r1, r3, fp, lsl #16
 6a8:	01010500 	tsteq	r1, r0, lsl #10
 6ac:	13011349 	movwne	r1, #4937	; 0x1349
 6b0:	21060000 	mrscs	r0, (UNDEF: 6)
 6b4:	2f134900 	svccs	0x00134900
 6b8:	0700000b 	streq	r0, [r0, -fp]
 6bc:	13490026 	movtne	r0, #36902	; 0x9026
 6c0:	24080000 	strcs	r0, [r8], #-0
 6c4:	3e0b0b00 	vmlacc.f64	d0, d11, d0
 6c8:	000e030b 	andeq	r0, lr, fp, lsl #6
 6cc:	00340900 	eorseq	r0, r4, r0, lsl #18
 6d0:	00001347 	andeq	r1, r0, r7, asr #6
 6d4:	3f012e0a 	svccc	0x00012e0a
 6d8:	3a0e0319 	bcc	381344 <__bss_end+0x37843c>
 6dc:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 6e0:	110e6e0b 	tstne	lr, fp, lsl #28
 6e4:	40061201 	andmi	r1, r6, r1, lsl #4
 6e8:	19429718 	stmdbne	r2, {r3, r4, r8, r9, sl, ip, pc}^
 6ec:	00001301 	andeq	r1, r0, r1, lsl #6
 6f0:	0300050b 	movweq	r0, #1291	; 0x50b
 6f4:	3b0b3a08 	blcc	2cef1c <__bss_end+0x2c6014>
 6f8:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 6fc:	00180213 	andseq	r0, r8, r3, lsl r2
 700:	00340c00 	eorseq	r0, r4, r0, lsl #24
 704:	0b3a0e03 	bleq	e83f18 <__bss_end+0xe7b010>
 708:	0b390b3b 	bleq	e433fc <__bss_end+0xe3a4f4>
 70c:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 710:	0b0d0000 	bleq	340718 <__bss_end+0x337810>
 714:	12011101 	andne	r1, r1, #1073741824	; 0x40000000
 718:	0e000006 	cdpeq	0, 0, cr0, cr0, cr6, {0}
 71c:	08030034 	stmdaeq	r3, {r2, r4, r5}
 720:	0b3b0b3a 	bleq	ec3410 <__bss_end+0xeba508>
 724:	13490b39 	movtne	r0, #39737	; 0x9b39
 728:	00001802 	andeq	r1, r0, r2, lsl #16
 72c:	0b000f0f 	bleq	4370 <shift+0x4370>
 730:	0013490b 	andseq	r4, r3, fp, lsl #18
 734:	00261000 	eoreq	r1, r6, r0
 738:	0f110000 	svceq	0x00110000
 73c:	000b0b00 	andeq	r0, fp, r0, lsl #22
 740:	00241200 	eoreq	r1, r4, r0, lsl #4
 744:	0b3e0b0b 	bleq	f83378 <__bss_end+0xf7a470>
 748:	00000803 	andeq	r0, r0, r3, lsl #16
 74c:	03000513 	movweq	r0, #1299	; 0x513
 750:	3b0b3a0e 	blcc	2cef90 <__bss_end+0x2c6088>
 754:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 758:	00180213 	andseq	r0, r8, r3, lsl r2
 75c:	012e1400 			; <UNDEFINED> instruction: 0x012e1400
 760:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 764:	0b3b0b3a 	bleq	ec3454 <__bss_end+0xeba54c>
 768:	0e6e0b39 	vmoveq.8	d14[5], r0
 76c:	01111349 	tsteq	r1, r9, asr #6
 770:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 774:	01194297 			; <UNDEFINED> instruction: 0x01194297
 778:	15000013 	strne	r0, [r0, #-19]	; 0xffffffed
 77c:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 780:	0b3a0e03 	bleq	e83f94 <__bss_end+0xe7b08c>
 784:	0b390b3b 	bleq	e43478 <__bss_end+0xe3a570>
 788:	01110e6e 	tsteq	r1, lr, ror #28
 78c:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 790:	00194296 	mulseq	r9, r6, r2
	...

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
  74:	000000dc 	ldrdeq	r0, [r0], -ip
	...
  80:	0000001c 	andeq	r0, r0, ip, lsl r0
  84:	0af90002 	beq	ffe40094 <__bss_end+0xffe3718c>
  88:	00040000 	andeq	r0, r4, r0
  8c:	00000000 	andeq	r0, r0, r0
  90:	00008308 	andeq	r8, r0, r8, lsl #6
  94:	0000045c 	andeq	r0, r0, ip, asr r4
	...
  a0:	0000001c 	andeq	r0, r0, ip, lsl r0
  a4:	161c0002 	ldrne	r0, [ip], -r2
  a8:	00040000 	andeq	r0, r4, r0
  ac:	00000000 	andeq	r0, r0, r0
  b0:	00008764 	andeq	r8, r0, r4, ror #14
  b4:	000004b8 			; <UNDEFINED> instruction: 0x000004b8
	...

Disassembly of section .debug_str:

00000000 <.debug_str>:
       0:	6573552f 	ldrbvs	r5, [r3, #-1327]!	; 0xfffffad1
       4:	772f7372 			; <UNDEFINED> instruction: 0x772f7372
       8:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
       c:	2f696a72 	svccs	0x00696a72
      10:	6b736544 	blvs	1cd9528 <__bss_end+0x1cd0620>
      14:	2f706f74 	svccs	0x00706f74
      18:	2f564146 	svccs	0x00564146
      1c:	6176614e 	cmnvs	r6, lr, asr #2
      20:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
      24:	4f2f6963 	svcmi	0x002f6963
      28:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
      2c:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
      30:	6b6c6172 	blvs	1b18600 <__bss_end+0x1b0f6f8>
      34:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
      38:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
      3c:	756f732f 	strbvc	r7, [pc, #-815]!	; fffffd15 <__bss_end+0xffff6e0d>
      40:	73656372 	cmnvc	r5, #-939524095	; 0xc8000001
      44:	6573752f 	ldrbvs	r7, [r3, #-1327]!	; 0xfffffad1
      48:	61707372 	cmnvs	r0, r2, ror r3
      4c:	632f6563 			; <UNDEFINED> instruction: 0x632f6563
      50:	2e307472 	mrccs	4, 1, r7, cr0, cr2, {3}
      54:	552f0073 	strpl	r0, [pc, #-115]!	; ffffffe9 <__bss_end+0xffff70e1>
      58:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
      5c:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
      60:	6a726574 	bvs	1c99638 <__bss_end+0x1c90730>
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
      98:	752f7365 	strvc	r7, [pc, #-869]!	; fffffd3b <__bss_end+0xffff6e33>
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
     12c:	6a363731 	bvs	d8ddf8 <__bss_end+0xd84ef0>
     130:	732d667a 			; <UNDEFINED> instruction: 0x732d667a
     134:	616d2d20 	cmnvs	sp, r0, lsr #26
     138:	2d206d72 	stccs	13, cr6, [r0, #-456]!	; 0xfffffe38
     13c:	6372616d 	cmnvs	r2, #1073741851	; 0x4000001b
     140:	72613d68 	rsbvc	r3, r1, #104, 26	; 0x1a00
     144:	7a36766d 	bvc	d9db00 <__bss_end+0xd94bf8>
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
     184:	6a757a61 	bvs	1d5eb10 <__bss_end+0x1d55c08>
     188:	2f696369 	svccs	0x00696369
     18c:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
     190:	73656d65 	cmnvc	r5, #6464	; 0x1940
     194:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
     198:	6b2d616b 	blvs	b5874c <__bss_end+0xb4f844>
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
     1e4:	2b2b4320 	blcs	ad0e6c <__bss_end+0xac7f64>
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
     260:	2b6b7a36 	blcs	1adeb40 <__bss_end+0x1ad5c38>
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
     294:	755f6962 	ldrbvc	r6, [pc, #-2402]	; fffff93a <__bss_end+0xffff6a32>
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
     324:	6b736544 	blvs	1cd983c <__bss_end+0x1cd0934>
     328:	2f706f74 	svccs	0x00706f74
     32c:	2f564146 	svccs	0x00564146
     330:	6176614e 	cmnvs	r6, lr, asr #2
     334:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
     338:	4f2f6963 	svcmi	0x002f6963
     33c:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
     340:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
     344:	6b6c6172 	blvs	1b18914 <__bss_end+0x1b0fa0c>
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
     3e8:	63695400 	cmnvs	r9, #0, 8
     3ec:	6f435f6b 	svcvs	0x00435f6b
     3f0:	00746e75 	rsbseq	r6, r4, r5, ror lr
     3f4:	65646e49 	strbvs	r6, [r4, #-3657]!	; 0xfffff1b7
     3f8:	696e6966 	stmdbvs	lr!, {r1, r2, r5, r6, r8, fp, sp, lr}^
     3fc:	4f006574 	svcmi	0x00006574
     400:	006e6570 	rsbeq	r6, lr, r0, ror r5
     404:	314e5a5f 	cmpcc	lr, pc, asr sl
     408:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     40c:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     410:	614d5f73 	hvcvs	54771	; 0xd5f3
     414:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     418:	42313272 	eorsmi	r3, r1, #536870919	; 0x20000007
     41c:	6b636f6c 	blvs	18dc1d4 <__bss_end+0x18d32cc>
     420:	7275435f 	rsbsvc	r4, r5, #2080374785	; 0x7c000001
     424:	746e6572 	strbtvc	r6, [lr], #-1394	; 0xfffffa8e
     428:	6f72505f 	svcvs	0x0072505f
     42c:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     430:	70007645 	andvc	r7, r0, r5, asr #12
     434:	00766572 	rsbseq	r6, r6, r2, ror r5
     438:	314e5a5f 	cmpcc	lr, pc, asr sl
     43c:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     440:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     444:	614d5f73 	hvcvs	54771	; 0xd5f3
     448:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     44c:	4e343172 	mrcmi	1, 1, r3, cr4, cr2, {3}
     450:	6669746f 	strbtvs	r7, [r9], -pc, ror #8
     454:	72505f79 	subsvc	r5, r0, #484	; 0x1e4
     458:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     45c:	31504573 	cmpcc	r0, r3, ror r5
     460:	61545432 	cmpvs	r4, r2, lsr r4
     464:	535f6b73 	cmppl	pc, #117760	; 0x1cc00
     468:	63757274 	cmnvs	r5, #116, 4	; 0x40000007
     46c:	6e550074 	mrcvs	0, 2, r0, cr5, cr4, {3}
     470:	5f70616d 	svcpl	0x0070616d
     474:	656c6946 	strbvs	r6, [ip, #-2374]!	; 0xfffff6ba
     478:	7275435f 	rsbsvc	r4, r5, #2080374785	; 0x7c000001
     47c:	746e6572 	strbtvc	r6, [lr], #-1394	; 0xfffffa8e
     480:	43534200 	cmpmi	r3, #0, 4
     484:	61425f32 	cmpvs	r2, r2, lsr pc
     488:	6d006573 	cfstr32vs	mvfx6, [r0, #-460]	; 0xfffffe34
     48c:	636f7250 	cmnvs	pc, #80, 4
     490:	5f737365 	svcpl	0x00737365
     494:	7473694c 	ldrbtvc	r6, [r3], #-2380	; 0xfffff6b4
     498:	6165485f 	cmnvs	r5, pc, asr r8
     49c:	5a5f0064 	bpl	17c0634 <__bss_end+0x17b772c>
     4a0:	36314b4e 	ldrtcc	r4, [r1], -lr, asr #22
     4a4:	6f725043 	svcvs	0x00725043
     4a8:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     4ac:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     4b0:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     4b4:	65473931 	strbvs	r3, [r7, #-2353]	; 0xfffff6cf
     4b8:	75435f74 	strbvc	r5, [r3, #-3956]	; 0xfffff08c
     4bc:	6e657272 	mcrvs	2, 3, r7, cr5, cr2, {3}
     4c0:	72505f74 	subsvc	r5, r0, #116, 30	; 0x1d0
     4c4:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     4c8:	00764573 	rsbseq	r4, r6, r3, ror r5
     4cc:	7478656e 	ldrbtvc	r6, [r8], #-1390	; 0xfffffa92
     4d0:	646c6f00 	strbtvs	r6, [ip], #-3840	; 0xfffff100
     4d4:	74617473 	strbtvc	r7, [r1], #-1139	; 0xfffffb8d
     4d8:	65470065 	strbvs	r0, [r7, #-101]	; 0xffffff9b
     4dc:	72505f74 	subsvc	r5, r0, #116, 30	; 0x1d0
     4e0:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     4e4:	79425f73 	stmdbvc	r2, {r0, r1, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     4e8:	4449505f 	strbmi	r5, [r9], #-95	; 0xffffffa1
     4ec:	6d695400 	cfstrdvs	mvd5, [r9, #-0]
     4f0:	425f7265 	subsmi	r7, pc, #1342177286	; 0x50000006
     4f4:	00657361 	rsbeq	r7, r5, r1, ror #6
     4f8:	4957534e 	ldmdbmi	r7, {r1, r2, r3, r6, r8, r9, ip, lr}^
     4fc:	6f72505f 	svcvs	0x0072505f
     500:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     504:	7265535f 	rsbvc	r5, r5, #2080374785	; 0x7c000001
     508:	65636976 	strbvs	r6, [r3, #-2422]!	; 0xfffff68a
     50c:	61655200 	cmnvs	r5, r0, lsl #4
     510:	63410064 	movtvs	r0, #4196	; 0x1064
     514:	65766974 	ldrbvs	r6, [r6, #-2420]!	; 0xfffff68c
     518:	6f72505f 	svcvs	0x0072505f
     51c:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     520:	756f435f 	strbvc	r4, [pc, #-863]!	; 1c9 <shift+0x1c9>
     524:	4300746e 	movwmi	r7, #1134	; 0x46e
     528:	74616572 	strbtvc	r6, [r1], #-1394	; 0xfffffa8e
     52c:	72505f65 	subsvc	r5, r0, #404	; 0x194
     530:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     534:	614d0073 	hvcvs	53251	; 0xd003
     538:	6c694678 	stclvs	6, cr4, [r9], #-480	; 0xfffffe20
     53c:	6d616e65 	stclvs	14, cr6, [r1, #-404]!	; 0xfffffe6c
     540:	6e654c65 	cdpvs	12, 6, cr4, cr5, cr5, {3}
     544:	00687467 	rsbeq	r7, r8, r7, ror #8
     548:	5f585541 	svcpl	0x00585541
     54c:	65736142 	ldrbvs	r6, [r3, #-322]!	; 0xfffffebe
     550:	74654700 	strbtvc	r4, [r5], #-1792	; 0xfffff900
     554:	6863535f 	stmdavs	r3!, {r0, r1, r2, r3, r4, r6, r8, r9, ip, lr}^
     558:	6c756465 	cfldrdvs	mvd6, [r5], #-404	; 0xfffffe6c
     55c:	495f7265 	ldmdbmi	pc, {r0, r2, r5, r6, r9, ip, sp, lr}^	; <UNPREDICTABLE>
     560:	006f666e 	rsbeq	r6, pc, lr, ror #12
     564:	64616544 	strbtvs	r6, [r1], #-1348	; 0xfffffabc
     568:	656e696c 	strbvs	r6, [lr, #-2412]!	; 0xfffff694
     56c:	636e555f 	cmnvs	lr, #398458880	; 0x17c00000
     570:	676e6168 	strbvs	r6, [lr, -r8, ror #2]!
     574:	43006465 	movwmi	r6, #1125	; 0x465
     578:	636f7250 	cmnvs	pc, #80, 4
     57c:	5f737365 	svcpl	0x00737365
     580:	616e614d 	cmnvs	lr, sp, asr #2
     584:	00726567 	rsbseq	r6, r2, r7, ror #10
     588:	314e5a5f 	cmpcc	lr, pc, asr sl
     58c:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     590:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     594:	614d5f73 	hvcvs	54771	; 0xd5f3
     598:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     59c:	47383172 			; <UNDEFINED> instruction: 0x47383172
     5a0:	535f7465 	cmppl	pc, #1694498816	; 0x65000000
     5a4:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     5a8:	72656c75 	rsbvc	r6, r5, #29952	; 0x7500
     5ac:	666e495f 			; <UNDEFINED> instruction: 0x666e495f
     5b0:	3032456f 	eorscc	r4, r2, pc, ror #10
     5b4:	7465474e 	strbtvc	r4, [r5], #-1870	; 0xfffff8b2
     5b8:	6863535f 	stmdavs	r3!, {r0, r1, r2, r3, r4, r6, r8, r9, ip, lr}^
     5bc:	495f6465 	ldmdbmi	pc, {r0, r2, r5, r6, sl, sp, lr}^	; <UNPREDICTABLE>
     5c0:	5f6f666e 	svcpl	0x006f666e
     5c4:	65707954 	ldrbvs	r7, [r0, #-2388]!	; 0xfffff6ac
     5c8:	5f007650 	svcpl	0x00007650
     5cc:	36314e5a 			; <UNDEFINED> instruction: 0x36314e5a
     5d0:	6f725043 	svcvs	0x00725043
     5d4:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     5d8:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     5dc:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     5e0:	61483132 	cmpvs	r8, r2, lsr r1
     5e4:	656c646e 	strbvs	r6, [ip, #-1134]!	; 0xfffffb92
     5e8:	6c69465f 	stclvs	6, cr4, [r9], #-380	; 0xfffffe84
     5ec:	73797365 	cmnvc	r9, #-1811939327	; 0x94000001
     5f0:	5f6d6574 	svcpl	0x006d6574
     5f4:	45495753 	strbmi	r5, [r9, #-1875]	; 0xfffff8ad
     5f8:	534e3332 	movtpl	r3, #58162	; 0xe332
     5fc:	465f4957 			; <UNDEFINED> instruction: 0x465f4957
     600:	73656c69 	cmnvc	r5, #26880	; 0x6900
     604:	65747379 	ldrbvs	r7, [r4, #-889]!	; 0xfffffc87
     608:	65535f6d 	ldrbvs	r5, [r3, #-3949]	; 0xfffff093
     60c:	63697672 	cmnvs	r9, #119537664	; 0x7200000
     610:	6a6a6a65 	bvs	1a9afac <__bss_end+0x1a920a4>
     614:	54313152 	ldrtpl	r3, [r1], #-338	; 0xfffffeae
     618:	5f495753 	svcpl	0x00495753
     61c:	75736552 	ldrbvc	r6, [r3, #-1362]!	; 0xfffffaae
     620:	4600746c 	strmi	r7, [r0], -ip, ror #8
     624:	696c6c61 	stmdbvs	ip!, {r0, r5, r6, sl, fp, sp, lr}^
     628:	455f676e 	ldrbmi	r6, [pc, #-1902]	; fffffec2 <__bss_end+0xffff6fba>
     62c:	00656764 	rsbeq	r6, r5, r4, ror #14
     630:	6e65706f 	cdpvs	0, 6, cr7, cr5, cr15, {3}
     634:	665f6465 	ldrbvs	r6, [pc], -r5, ror #8
     638:	73656c69 	cmnvc	r5, #26880	; 0x6900
     63c:	746f4e00 	strbtvc	r4, [pc], #-3584	; 644 <shift+0x644>
     640:	41796669 	cmnmi	r9, r9, ror #12
     644:	54006c6c 	strpl	r6, [r0], #-3180	; 0xfffff394
     648:	5f555043 	svcpl	0x00555043
     64c:	746e6f43 	strbtvc	r6, [lr], #-3907	; 0xfffff0bd
     650:	00747865 	rsbseq	r7, r4, r5, ror #16
     654:	64616544 	strbtvs	r6, [r1], #-1348	; 0xfffffabc
     658:	656e696c 	strbvs	r6, [lr, #-2412]!	; 0xfffff694
     65c:	62747400 	rsbsvs	r7, r4, #0, 8
     660:	5f003072 	svcpl	0x00003072
     664:	36314e5a 			; <UNDEFINED> instruction: 0x36314e5a
     668:	6f725043 	svcvs	0x00725043
     66c:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     670:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     674:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     678:	6f4e3431 	svcvs	0x004e3431
     67c:	79666974 	stmdbvc	r6!, {r2, r4, r5, r6, r8, fp, sp, lr}^
     680:	6f72505f 	svcvs	0x0072505f
     684:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     688:	47006a45 	strmi	r6, [r0, -r5, asr #20]
     68c:	505f7465 	subspl	r7, pc, r5, ror #8
     690:	42004449 	andmi	r4, r0, #1224736768	; 0x49000000
     694:	5f304353 	svcpl	0x00304353
     698:	65736142 	ldrbvs	r6, [r3, #-322]!	; 0xfffffebe
     69c:	746f6e00 	strbtvc	r6, [pc], #-3584	; 6a4 <shift+0x6a4>
     6a0:	65696669 	strbvs	r6, [r9, #-1641]!	; 0xfffff997
     6a4:	65645f64 	strbvs	r5, [r4, #-3940]!	; 0xfffff09c
     6a8:	696c6461 	stmdbvs	ip!, {r0, r5, r6, sl, sp, lr}^
     6ac:	4900656e 	stmdbmi	r0, {r1, r2, r3, r5, r6, r8, sl, sp, lr}
     6b0:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
     6b4:	74707572 	ldrbtvc	r7, [r0], #-1394	; 0xfffffa8e
     6b8:	6e6f435f 	mcrvs	3, 3, r4, cr15, cr15, {2}
     6bc:	6c6f7274 	sfmvs	f7, 2, [pc], #-464	; 4f4 <shift+0x4f4>
     6c0:	5f72656c 	svcpl	0x0072656c
     6c4:	65736142 	ldrbvs	r6, [r3, #-322]!	; 0xfffffebe
     6c8:	43534200 	cmpmi	r3, #0, 4
     6cc:	61425f31 	cmpvs	r2, r1, lsr pc
     6d0:	4d006573 	cfstr32mi	mvfx6, [r0, #-460]	; 0xfffffe34
     6d4:	505f7861 	subspl	r7, pc, r1, ror #16
     6d8:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     6dc:	4f5f7373 	svcmi	0x005f7373
     6e0:	656e6570 	strbvs	r6, [lr, #-1392]!	; 0xfffffa90
     6e4:	69465f64 	stmdbvs	r6, {r2, r5, r6, r8, r9, sl, fp, ip, lr}^
     6e8:	0073656c 	rsbseq	r6, r3, ip, ror #10
     6ec:	314e5a5f 	cmpcc	lr, pc, asr sl
     6f0:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     6f4:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     6f8:	614d5f73 	hvcvs	54771	; 0xd5f3
     6fc:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     700:	55383172 	ldrpl	r3, [r8, #-370]!	; 0xfffffe8e
     704:	70616d6e 	rsbvc	r6, r1, lr, ror #26
     708:	6c69465f 	stclvs	6, cr4, [r9], #-380	; 0xfffffe84
     70c:	75435f65 	strbvc	r5, [r3, #-3941]	; 0xfffff09b
     710:	6e657272 	mcrvs	2, 3, r7, cr5, cr2, {3}
     714:	006a4574 	rsbeq	r4, sl, r4, ror r5
     718:	474e5254 	smlsldmi	r5, lr, r4, r2
     71c:	7361425f 	cmnvc	r1, #-268435451	; 0xf0000005
     720:	69480065 	stmdbvs	r8, {r0, r2, r5, r6}^
     724:	52006867 	andpl	r6, r0, #6750208	; 0x670000
     728:	6e697369 	cdpvs	3, 6, cr7, cr9, cr9, {3}
     72c:	64455f67 	strbvs	r5, [r5], #-3943	; 0xfffff099
     730:	47006567 	strmi	r6, [r0, -r7, ror #10]
     734:	435f7465 	cmpmi	pc, #1694498816	; 0x65000000
     738:	65727275 	ldrbvs	r7, [r2, #-629]!	; 0xfffffd8b
     73c:	505f746e 	subspl	r7, pc, lr, ror #8
     740:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     744:	6c007373 	stcvs	3, cr7, [r0], {115}	; 0x73
     748:	20676e6f 	rsbcs	r6, r7, pc, ror #28
     74c:	69736e75 	ldmdbvs	r3!, {r0, r2, r4, r5, r6, r9, sl, fp, sp, lr}^
     750:	64656e67 	strbtvs	r6, [r5], #-3687	; 0xfffff199
     754:	746e6920 	strbtvc	r6, [lr], #-2336	; 0xfffff6e0
     758:	70614d00 	rsbvc	r4, r1, r0, lsl #26
     75c:	6c69465f 	stclvs	6, cr4, [r9], #-380	; 0xfffffe84
     760:	6f545f65 	svcvs	0x00545f65
     764:	7275435f 	rsbsvc	r4, r5, #2080374785	; 0x7c000001
     768:	746e6572 	strbtvc	r6, [lr], #-1394	; 0xfffffa8e
     76c:	466f4e00 	strbtmi	r4, [pc], -r0, lsl #28
     770:	73656c69 	cmnvc	r5, #26880	; 0x6900
     774:	65747379 	ldrbvs	r7, [r4, #-889]!	; 0xfffffc87
     778:	6972446d 	ldmdbvs	r2!, {r0, r2, r3, r5, r6, sl, lr}^
     77c:	00726576 	rsbseq	r6, r2, r6, ror r5
     780:	5f746553 	svcpl	0x00746553
     784:	61726150 	cmnvs	r2, r0, asr r1
     788:	2f00736d 	svccs	0x0000736d
     78c:	72657355 	rsbvc	r7, r5, #1409286145	; 0x54000001
     790:	69772f73 	ldmdbvs	r7!, {r0, r1, r4, r5, r6, r8, r9, sl, fp, sp}^
     794:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
     798:	442f696a 	strtmi	r6, [pc], #-2410	; 7a0 <shift+0x7a0>
     79c:	746b7365 	strbtvc	r7, [fp], #-869	; 0xfffffc9b
     7a0:	462f706f 	strtmi	r7, [pc], -pc, rrx
     7a4:	4e2f5641 	cfmadda32mi	mvax2, mvax5, mvfx15, mvfx1
     7a8:	7a617661 	bvc	185e134 <__bss_end+0x185522c>
     7ac:	63696a75 	cmnvs	r9, #479232	; 0x75000
     7b0:	534f2f69 	movtpl	r2, #65385	; 0xff69
     7b4:	6d65732f 	stclvs	3, cr7, [r5, #-188]!	; 0xffffff44
     7b8:	72747365 	rsbsvc	r7, r4, #-1811939327	; 0x94000001
     7bc:	616b6c61 	cmnvs	fp, r1, ror #24
     7c0:	76696b2d 	strbtvc	r6, [r9], -sp, lsr #22
     7c4:	2f736f2d 	svccs	0x00736f2d
     7c8:	72756f73 	rsbsvc	r6, r5, #460	; 0x1cc
     7cc:	2f736563 	svccs	0x00736563
     7d0:	72657375 	rsbvc	r7, r5, #-738197503	; 0xd4000001
     7d4:	63617073 	cmnvs	r1, #115	; 0x73
     7d8:	69742f65 	ldmdbvs	r4!, {r0, r2, r5, r6, r8, r9, sl, fp, sp}^
     7dc:	745f746c 	ldrbvc	r7, [pc], #-1132	; 7e4 <shift+0x7e4>
     7e0:	2f6b7361 	svccs	0x006b7361
     7e4:	6e69616d 	powvsez	f6, f1, #5.0
     7e8:	7070632e 	rsbsvc	r6, r0, lr, lsr #6
     7ec:	6e614800 	cdpvs	8, 6, cr4, cr1, cr0, {0}
     7f0:	5f656c64 	svcpl	0x00656c64
     7f4:	636f7250 	cmnvs	pc, #80, 4
     7f8:	5f737365 	svcpl	0x00737365
     7fc:	00495753 	subeq	r5, r9, r3, asr r7
     800:	726f6873 	rsbvc	r6, pc, #7536640	; 0x730000
     804:	6e752074 	mrcvs	0, 3, r2, cr5, cr4, {3}
     808:	6e676973 			; <UNDEFINED> instruction: 0x6e676973
     80c:	69206465 	stmdbvs	r0!, {r0, r2, r5, r6, sl, sp, lr}
     810:	5300746e 	movwpl	r7, #1134	; 0x46e
     814:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     818:	5f656c75 	svcpl	0x00656c75
     81c:	00464445 	subeq	r4, r6, r5, asr #8
     820:	74696157 	strbtvc	r6, [r9], #-343	; 0xfffffea9
     824:	73694400 	cmnvc	r9, #0, 8
     828:	656c6261 	strbvs	r6, [ip, #-609]!	; 0xfffffd9f
     82c:	6576455f 	ldrbvs	r4, [r6, #-1375]!	; 0xfffffaa1
     830:	445f746e 	ldrbmi	r7, [pc], #-1134	; 838 <shift+0x838>
     834:	63657465 	cmnvs	r5, #1694498816	; 0x65000000
     838:	6e6f6974 			; <UNDEFINED> instruction: 0x6e6f6974
     83c:	746e4900 	strbtvc	r4, [lr], #-2304	; 0xfffff700
     840:	75727265 	ldrbvc	r7, [r2, #-613]!	; 0xfffffd9b
     844:	62617470 	rsbvs	r7, r1, #112, 8	; 0x70000000
     848:	535f656c 	cmppl	pc, #108, 10	; 0x1b000000
     84c:	7065656c 	rsbvc	r6, r5, ip, ror #10
     850:	6f6f6200 	svcvs	0x006f6200
     854:	4c6d006c 	stclmi	0, cr0, [sp], #-432	; 0xfffffe50
     858:	5f747361 	svcpl	0x00747361
     85c:	00444950 	subeq	r4, r4, r0, asr r9
     860:	636f6c42 	cmnvs	pc, #16896	; 0x4200
     864:	0064656b 	rsbeq	r6, r4, fp, ror #10
     868:	7465474e 	strbtvc	r4, [r5], #-1870	; 0xfffff8b2
     86c:	6863535f 	stmdavs	r3!, {r0, r1, r2, r3, r4, r6, r8, r9, ip, lr}^
     870:	495f6465 	ldmdbmi	pc, {r0, r2, r5, r6, sl, sp, lr}^	; <UNPREDICTABLE>
     874:	5f6f666e 	svcpl	0x006f666e
     878:	65707954 	ldrbvs	r7, [r0, #-2388]!	; 0xfffff6ac
     87c:	6e755200 	cdpvs	2, 7, cr5, cr5, cr0, {0}
     880:	6c62616e 	stfvse	f6, [r2], #-440	; 0xfffffe48
     884:	544e0065 	strbpl	r0, [lr], #-101	; 0xffffff9b
     888:	5f6b7361 	svcpl	0x006b7361
     88c:	74617453 	strbtvc	r7, [r1], #-1107	; 0xfffffbad
     890:	63730065 	cmnvs	r3, #101	; 0x65
     894:	5f646568 	svcpl	0x00646568
     898:	6e756f63 	cdpvs	15, 7, cr6, cr5, cr3, {3}
     89c:	00726574 	rsbseq	r6, r2, r4, ror r5
     8a0:	65686373 	strbvs	r6, [r8, #-883]!	; 0xfffffc8d
     8a4:	74735f64 	ldrbtvc	r5, [r3], #-3940	; 0xfffff09c
     8a8:	63697461 	cmnvs	r9, #1627389952	; 0x61000000
     8ac:	6972705f 	ldmdbvs	r2!, {r0, r1, r2, r3, r4, r6, ip, sp, lr}^
     8b0:	7469726f 	strbtvc	r7, [r9], #-623	; 0xfffffd91
     8b4:	78650079 	stmdavc	r5!, {r0, r3, r4, r5, r6}^
     8b8:	635f7469 	cmpvs	pc, #1761607680	; 0x69000000
     8bc:	0065646f 	rsbeq	r6, r5, pc, ror #8
     8c0:	61766e49 	cmnvs	r6, r9, asr #28
     8c4:	5f64696c 	svcpl	0x0064696c
     8c8:	006e6950 	rsbeq	r6, lr, r0, asr r9
     8cc:	6863536d 	stmdavs	r3!, {r0, r2, r3, r5, r6, r8, r9, ip, lr}^
     8d0:	6c756465 	cfldrdvs	mvd6, [r5], #-404	; 0xfffffe6c
     8d4:	6e465f65 	cdpvs	15, 4, cr5, cr6, cr5, {3}
     8d8:	50470063 	subpl	r0, r7, r3, rrx
     8dc:	425f4f49 	subsmi	r4, pc, #292	; 0x124
     8e0:	00657361 	rsbeq	r7, r5, r1, ror #6
     8e4:	4678614d 	ldrbtmi	r6, [r8], -sp, asr #2
     8e8:	69724453 	ldmdbvs	r2!, {r0, r1, r4, r6, sl, lr}^
     8ec:	4e726576 	mrcmi	5, 3, r6, cr2, cr6, {3}
     8f0:	4c656d61 	stclmi	13, cr6, [r5], #-388	; 0xfffffe7c
     8f4:	74676e65 	strbtvc	r6, [r7], #-3685	; 0xfffff19b
     8f8:	6f4e0068 	svcvs	0x004e0068
     8fc:	79666974 	stmdbvc	r6!, {r2, r4, r5, r6, r8, fp, sp, lr}^
     900:	66654400 	strbtvs	r4, [r5], -r0, lsl #8
     904:	746c7561 	strbtvc	r7, [ip], #-1377	; 0xfffffa9f
     908:	6f6c435f 	svcvs	0x006c435f
     90c:	525f6b63 	subspl	r6, pc, #101376	; 0x18c00
     910:	00657461 	rsbeq	r7, r5, r1, ror #8
     914:	6b636f4c 	blvs	18dc64c <__bss_end+0x18d3744>
     918:	6c6e555f 	cfstr64vs	mvdx5, [lr], #-380	; 0xfffffe84
     91c:	656b636f 	strbvs	r6, [fp, #-879]!	; 0xfffffc91
     920:	6f4c0064 	svcvs	0x004c0064
     924:	4c5f6b63 	mrrcmi	11, 6, r6, pc, cr3	; <UNPREDICTABLE>
     928:	656b636f 	strbvs	r6, [fp, #-879]!	; 0xfffffc91
     92c:	65520064 	ldrbvs	r0, [r2, #-100]	; 0xffffff9c
     930:	575f6461 	ldrbpl	r6, [pc, -r1, ror #8]
     934:	65746972 	ldrbvs	r6, [r4, #-2418]!	; 0xfffff68e
     938:	6d6f5a00 	vstmdbvs	pc!, {s11-s10}
     93c:	00656962 	rsbeq	r6, r5, r2, ror #18
     940:	5f746547 	svcpl	0x00746547
     944:	65686353 	strbvs	r6, [r8, #-851]!	; 0xfffffcad
     948:	6e495f64 	cdpvs	15, 4, cr5, cr9, cr4, {3}
     94c:	5f006f66 	svcpl	0x00006f66
     950:	36314e5a 			; <UNDEFINED> instruction: 0x36314e5a
     954:	6f725043 	svcvs	0x00725043
     958:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     95c:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     960:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     964:	68635338 	stmdavs	r3!, {r3, r4, r5, r8, r9, ip, lr}^
     968:	6c756465 	cfldrdvs	mvd6, [r5], #-404	; 0xfffffe6c
     96c:	00764565 	rsbseq	r4, r6, r5, ror #10
     970:	314e5a5f 	cmpcc	lr, pc, asr sl
     974:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     978:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     97c:	614d5f73 	hvcvs	54771	; 0xd5f3
     980:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     984:	4d393172 	ldfmis	f3, [r9, #-456]!	; 0xfffffe38
     988:	465f7061 	ldrbmi	r7, [pc], -r1, rrx
     98c:	5f656c69 	svcpl	0x00656c69
     990:	435f6f54 	cmpmi	pc, #84, 30	; 0x150
     994:	65727275 	ldrbvs	r7, [r2, #-629]!	; 0xfffffd8b
     998:	5045746e 	subpl	r7, r5, lr, ror #8
     99c:	69464935 	stmdbvs	r6, {r0, r2, r4, r5, r8, fp, lr}^
     9a0:	4700656c 	strmi	r6, [r0, -ip, ror #10]
     9a4:	505f7465 	subspl	r7, pc, r5, ror #8
     9a8:	6d617261 	sfmvs	f7, 2, [r1, #-388]!	; 0xfffffe7c
     9ac:	614d0073 	hvcvs	53251	; 0xd003
     9b0:	74615078 	strbtvc	r5, [r1], #-120	; 0xffffff88
     9b4:	6e654c68 	cdpvs	12, 6, cr4, cr5, cr8, {3}
     9b8:	00687467 	rsbeq	r7, r8, r7, ror #8
     9bc:	69736e75 	ldmdbvs	r3!, {r0, r2, r4, r5, r6, r9, sl, fp, sp, lr}^
     9c0:	64656e67 	strbtvs	r6, [r5], #-3687	; 0xfffff199
     9c4:	61686320 	cmnvs	r8, r0, lsr #6
     9c8:	5a5f0072 	bpl	17c0b98 <__bss_end+0x17b7c90>
     9cc:	4336314e 	teqmi	r6, #-2147483629	; 0x80000013
     9d0:	636f7250 	cmnvs	pc, #80, 4
     9d4:	5f737365 	svcpl	0x00737365
     9d8:	616e614d 	cmnvs	lr, sp, asr #2
     9dc:	31726567 	cmncc	r2, r7, ror #10
     9e0:	68635332 	stmdavs	r3!, {r1, r4, r5, r8, r9, ip, lr}^
     9e4:	6c756465 	cfldrdvs	mvd6, [r5], #-404	; 0xfffffe6c
     9e8:	44455f65 	strbmi	r5, [r5], #-3941	; 0xfffff09b
     9ec:	00764546 	rsbseq	r4, r6, r6, asr #10
     9f0:	4f495047 	svcmi	0x00495047
     9f4:	6e69505f 	mcrvs	0, 3, r5, cr9, cr15, {2}
     9f8:	756f435f 	strbvc	r4, [pc, #-863]!	; 6a1 <shift+0x6a1>
     9fc:	7300746e 	movwvc	r7, #1134	; 0x46e
     a00:	74726f68 	ldrbtvc	r6, [r2], #-3944	; 0xfffff098
     a04:	746e6920 	strbtvc	r6, [lr], #-2336	; 0xfffff6e0
     a08:	616e4500 	cmnvs	lr, r0, lsl #10
     a0c:	5f656c62 	svcpl	0x00656c62
     a10:	6e657645 	cdpvs	6, 6, cr7, cr5, cr5, {2}
     a14:	65445f74 	strbvs	r5, [r4, #-3956]	; 0xfffff08c
     a18:	74636574 	strbtvc	r6, [r3], #-1396	; 0xfffffa8c
     a1c:	006e6f69 	rsbeq	r6, lr, r9, ror #30
     a20:	69726550 	ldmdbvs	r2!, {r4, r6, r8, sl, sp, lr}^
     a24:	72656870 	rsbvc	r6, r5, #112, 16	; 0x700000
     a28:	425f6c61 	subsmi	r6, pc, #24832	; 0x6100
     a2c:	00657361 	rsbeq	r7, r5, r1, ror #6
     a30:	6e6e7552 	mcrvs	5, 3, r7, cr14, cr2, {2}
     a34:	00676e69 	rsbeq	r6, r7, r9, ror #28
     a38:	746c6974 	strbtvc	r6, [ip], #-2420	; 0xfffff68c
     a3c:	736e6573 	cmnvc	lr, #482344960	; 0x1cc00000
     a40:	665f726f 	ldrbvs	r7, [pc], -pc, ror #4
     a44:	00656c69 	rsbeq	r6, r5, r9, ror #24
     a48:	746e6975 	strbtvc	r6, [lr], #-2421	; 0xfffff68b
     a4c:	745f3233 	ldrbvc	r3, [pc], #-563	; a54 <shift+0xa54>
     a50:	50474e00 	subpl	r4, r7, r0, lsl #28
     a54:	495f4f49 	ldmdbmi	pc, {r0, r3, r6, r8, r9, sl, fp, lr}^	; <UNPREDICTABLE>
     a58:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
     a5c:	74707572 	ldrbtvc	r7, [r0], #-1394	; 0xfffffa8e
     a60:	7079545f 	rsbsvc	r5, r9, pc, asr r4
     a64:	436d0065 	cmnmi	sp, #101	; 0x65
     a68:	65727275 	ldrbvs	r7, [r2, #-629]!	; 0xfffffd8b
     a6c:	545f746e 	ldrbpl	r7, [pc], #-1134	; a74 <shift+0xa74>
     a70:	5f6b7361 	svcpl	0x006b7361
     a74:	65646f4e 	strbvs	r6, [r4, #-3918]!	; 0xfffff0b2
     a78:	75706300 	ldrbvc	r6, [r0, #-768]!	; 0xfffffd00
     a7c:	6e6f635f 	mcrvs	3, 3, r6, cr15, cr15, {2}
     a80:	74786574 	ldrbtvc	r6, [r8], #-1396	; 0xfffffa8c
     a84:	61655200 	cmnvs	r5, r0, lsl #4
     a88:	6e4f5f64 	cdpvs	15, 4, cr5, cr15, cr4, {3}
     a8c:	7300796c 	movwvc	r7, #2412	; 0x96c
     a90:	7065656c 	rsbvc	r6, r5, ip, ror #10
     a94:	6d69745f 	cfstrdvs	mvd7, [r9, #-380]!	; 0xfffffe84
     a98:	5f007265 	svcpl	0x00007265
     a9c:	314b4e5a 	cmpcc	fp, sl, asr lr
     aa0:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     aa4:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     aa8:	614d5f73 	hvcvs	54771	; 0xd5f3
     aac:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     ab0:	47383172 			; <UNDEFINED> instruction: 0x47383172
     ab4:	505f7465 	subspl	r7, pc, r5, ror #8
     ab8:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     abc:	425f7373 	subsmi	r7, pc, #-872415231	; 0xcc000001
     ac0:	49505f79 	ldmdbmi	r0, {r0, r3, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     ac4:	006a4544 	rsbeq	r4, sl, r4, asr #10
     ac8:	646e6148 	strbtvs	r6, [lr], #-328	; 0xfffffeb8
     acc:	465f656c 	ldrbmi	r6, [pc], -ip, ror #10
     ad0:	73656c69 	cmnvc	r5, #26880	; 0x6900
     ad4:	65747379 	ldrbvs	r7, [r4, #-889]!	; 0xfffffc87
     ad8:	57535f6d 	ldrbpl	r5, [r3, -sp, ror #30]
     adc:	5a5f0049 	bpl	17c0c08 <__bss_end+0x17b7d00>
     ae0:	4336314e 	teqmi	r6, #-2147483629	; 0x80000013
     ae4:	636f7250 	cmnvs	pc, #80, 4
     ae8:	5f737365 	svcpl	0x00737365
     aec:	616e614d 	cmnvs	lr, sp, asr #2
     af0:	31726567 	cmncc	r2, r7, ror #10
     af4:	68635331 	stmdavs	r3!, {r0, r4, r5, r8, r9, ip, lr}^
     af8:	6c756465 	cfldrdvs	mvd6, [r5], #-404	; 0xfffffe6c
     afc:	52525f65 	subspl	r5, r2, #404	; 0x194
     b00:	74007645 	strvc	r7, [r0], #-1605	; 0xfffff9bb
     b04:	006b7361 	rsbeq	r7, fp, r1, ror #6
     b08:	79747269 	ldmdbvc	r4!, {r0, r3, r5, r6, r9, ip, sp, lr}^
     b0c:	4e006570 	cfrshl64mi	mvdx0, mvdx0, r6
     b10:	6669746f 	strbtvs	r7, [r9], -pc, ror #8
     b14:	72505f79 	subsvc	r5, r0, #484	; 0x1e4
     b18:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     b1c:	63530073 	cmpvs	r3, #115	; 0x73
     b20:	75646568 	strbvc	r6, [r4, #-1384]!	; 0xfffffa98
     b24:	5f00656c 	svcpl	0x0000656c
     b28:	36314e5a 			; <UNDEFINED> instruction: 0x36314e5a
     b2c:	6f725043 	svcvs	0x00725043
     b30:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     b34:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     b38:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     b3c:	69775339 	ldmdbvs	r7!, {r0, r3, r4, r5, r8, r9, ip, lr}^
     b40:	5f686374 	svcpl	0x00686374
     b44:	50456f54 	subpl	r6, r5, r4, asr pc
     b48:	50433831 	subpl	r3, r3, r1, lsr r8
     b4c:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     b50:	4c5f7373 	mrrcmi	3, 7, r7, pc, cr3	; <UNPREDICTABLE>
     b54:	5f747369 	svcpl	0x00747369
     b58:	65646f4e 	strbvs	r6, [r4, #-3918]!	; 0xfffff0b2
     b5c:	68635300 	stmdavs	r3!, {r8, r9, ip, lr}^
     b60:	6c756465 	cfldrdvs	mvd6, [r5], #-404	; 0xfffffe6c
     b64:	52525f65 	subspl	r5, r2, #404	; 0x194
     b68:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     b6c:	50433631 	subpl	r3, r3, r1, lsr r6
     b70:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     b74:	4d5f7373 	ldclmi	3, cr7, [pc, #-460]	; 9b0 <shift+0x9b0>
     b78:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
     b7c:	38317265 	ldmdacc	r1!, {r0, r2, r5, r6, r9, ip, sp, lr}
     b80:	646e6148 	strbtvs	r6, [lr], #-328	; 0xfffffeb8
     b84:	505f656c 	subspl	r6, pc, ip, ror #10
     b88:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     b8c:	535f7373 	cmppl	pc, #-872415231	; 0xcc000001
     b90:	32454957 	subcc	r4, r5, #1425408	; 0x15c000
     b94:	57534e30 	smmlarpl	r3, r0, lr, r4
     b98:	72505f49 	subsvc	r5, r0, #292	; 0x124
     b9c:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     ba0:	65535f73 	ldrbvs	r5, [r3, #-3955]	; 0xfffff08d
     ba4:	63697672 	cmnvs	r9, #119537664	; 0x7200000
     ba8:	6a6a6a65 	bvs	1a9b544 <__bss_end+0x1a9263c>
     bac:	54313152 	ldrtpl	r3, [r1], #-338	; 0xfffffeae
     bb0:	5f495753 	svcpl	0x00495753
     bb4:	75736552 	ldrbvc	r6, [r3, #-1362]!	; 0xfffffaae
     bb8:	6100746c 	tstvs	r0, ip, ror #8
     bbc:	00766772 	rsbseq	r6, r6, r2, ror r7
     bc0:	434f494e 	movtmi	r4, #63822	; 0xf94e
     bc4:	4f5f6c74 	svcmi	0x005f6c74
     bc8:	61726570 	cmnvs	r2, r0, ror r5
     bcc:	6e6f6974 			; <UNDEFINED> instruction: 0x6e6f6974
     bd0:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     bd4:	50433631 	subpl	r3, r3, r1, lsr r6
     bd8:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     bdc:	4d5f7373 	ldclmi	3, cr7, [pc, #-460]	; a18 <shift+0xa18>
     be0:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
     be4:	34317265 	ldrtcc	r7, [r1], #-613	; 0xfffffd9b
     be8:	61657243 	cmnvs	r5, r3, asr #4
     bec:	505f6574 	subspl	r6, pc, r4, ror r5	; <UNPREDICTABLE>
     bf0:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     bf4:	50457373 	subpl	r7, r5, r3, ror r3
     bf8:	00626a68 	rsbeq	r6, r2, r8, ror #20
     bfc:	74697753 	strbtvc	r7, [r9], #-1875	; 0xfffff8ad
     c00:	545f6863 	ldrbpl	r6, [pc], #-2147	; c08 <shift+0xc08>
     c04:	534e006f 	movtpl	r0, #57455	; 0xe06f
     c08:	465f4957 			; <UNDEFINED> instruction: 0x465f4957
     c0c:	73656c69 	cmnvc	r5, #26880	; 0x6900
     c10:	65747379 	ldrbvs	r7, [r4, #-889]!	; 0xfffffc87
     c14:	65535f6d 	ldrbvs	r5, [r3, #-3949]	; 0xfffff093
     c18:	63697672 	cmnvs	r9, #119537664	; 0x7200000
     c1c:	6e490065 	cdpvs	0, 4, cr0, cr9, cr5, {3}
     c20:	696c6176 	stmdbvs	ip!, {r1, r2, r4, r5, r6, r8, sp, lr}^
     c24:	61485f64 	cmpvs	r8, r4, ror #30
     c28:	656c646e 	strbvs	r6, [ip, #-1134]!	; 0xfffffb92
     c2c:	6f6c4200 	svcvs	0x006c4200
     c30:	435f6b63 	cmpmi	pc, #101376	; 0x18c00
     c34:	65727275 	ldrbvs	r7, [r2, #-629]!	; 0xfffffd8b
     c38:	505f746e 	subspl	r7, pc, lr, ror #8
     c3c:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     c40:	43007373 	movwmi	r7, #883	; 0x373
     c44:	65736f6c 	ldrbvs	r6, [r3, #-3948]!	; 0xfffff094
     c48:	67726100 	ldrbvs	r6, [r2, -r0, lsl #2]!
     c4c:	72570063 	subsvc	r0, r7, #99	; 0x63
     c50:	5f657469 	svcpl	0x00657469
     c54:	796c6e4f 	stmdbvc	ip!, {r0, r1, r2, r3, r6, r9, sl, fp, sp, lr}^
     c58:	69616d00 	stmdbvs	r1!, {r8, sl, fp, sp, lr}^
     c5c:	6959006e 	ldmdbvs	r9, {r1, r2, r3, r5, r6}^
     c60:	00646c65 	rsbeq	r6, r4, r5, ror #24
     c64:	314e5a5f 	cmpcc	lr, pc, asr sl
     c68:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     c6c:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     c70:	614d5f73 	hvcvs	54771	; 0xd5f3
     c74:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     c78:	45344372 	ldrmi	r4, [r4, #-882]!	; 0xfffffc8e
     c7c:	65540076 	ldrbvs	r0, [r4, #-118]	; 0xffffff8a
     c80:	6e696d72 	mcrvs	13, 3, r6, cr9, cr2, {3}
     c84:	00657461 	rsbeq	r7, r5, r1, ror #8
     c88:	74434f49 	strbvc	r4, [r3], #-3913	; 0xfffff0b7
     c8c:	6f6c006c 	svcvs	0x006c006c
     c90:	70697067 	rsbvc	r7, r9, r7, rrx
     c94:	552f0065 	strpl	r0, [pc, #-101]!	; c37 <shift+0xc37>
     c98:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
     c9c:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
     ca0:	6a726574 	bvs	1c9a278 <__bss_end+0x1c91370>
     ca4:	65442f69 	strbvs	r2, [r4, #-3945]	; 0xfffff097
     ca8:	6f746b73 	svcvs	0x00746b73
     cac:	41462f70 	hvcmi	25328	; 0x62f0
     cb0:	614e2f56 	cmpvs	lr, r6, asr pc
     cb4:	757a6176 	ldrbvc	r6, [sl, #-374]!	; 0xfffffe8a
     cb8:	6963696a 	stmdbvs	r3!, {r1, r3, r5, r6, r8, fp, sp, lr}^
     cbc:	2f534f2f 	svccs	0x00534f2f
     cc0:	656d6573 	strbvs	r6, [sp, #-1395]!	; 0xfffffa8d
     cc4:	61727473 	cmnvs	r2, r3, ror r4
     cc8:	2d616b6c 	vstmdbcs	r1!, {d22-<overflow reg d75>}
     ccc:	2d76696b 			; <UNDEFINED> instruction: 0x2d76696b
     cd0:	732f736f 			; <UNDEFINED> instruction: 0x732f736f
     cd4:	6372756f 	cmnvs	r2, #465567744	; 0x1bc00000
     cd8:	622f7365 	eorvs	r7, pc, #-1811939327	; 0x94000001
     cdc:	646c6975 	strbtvs	r6, [ip], #-2421	; 0xfffff68b
     ce0:	6f6c6300 	svcvs	0x006c6300
     ce4:	53006573 	movwpl	r6, #1395	; 0x573
     ce8:	525f7465 	subspl	r7, pc, #1694498816	; 0x65000000
     cec:	74616c65 	strbtvc	r6, [r1], #-3173	; 0xfffff39b
     cf0:	00657669 	rsbeq	r7, r5, r9, ror #12
     cf4:	76746572 			; <UNDEFINED> instruction: 0x76746572
     cf8:	6e006c61 	cdpvs	12, 0, cr6, cr0, cr1, {3}
     cfc:	00727563 	rsbseq	r7, r2, r3, ror #10
     d00:	756e6472 	strbvc	r6, [lr, #-1138]!	; 0xfffffb8e
     d04:	5a5f006d 	bpl	17c0ec0 <__bss_end+0x17b7fb8>
     d08:	63733131 	cmnvs	r3, #1073741836	; 0x4000000c
     d0c:	5f646568 	svcpl	0x00646568
     d10:	6c656979 			; <UNDEFINED> instruction: 0x6c656979
     d14:	5f007664 	svcpl	0x00007664
     d18:	7337315a 	teqvc	r7, #-2147483626	; 0x80000016
     d1c:	745f7465 	ldrbvc	r7, [pc], #-1125	; d24 <shift+0xd24>
     d20:	5f6b7361 	svcpl	0x006b7361
     d24:	64616564 	strbtvs	r6, [r1], #-1380	; 0xfffffa9c
     d28:	656e696c 	strbvs	r6, [lr, #-2412]!	; 0xfffff694
     d2c:	6177006a 	cmnvs	r7, sl, rrx
     d30:	5f007469 	svcpl	0x00007469
     d34:	6f6e365a 	svcvs	0x006e365a
     d38:	79666974 	stmdbvc	r6!, {r2, r4, r5, r6, r8, fp, sp, lr}^
     d3c:	46006a6a 	strmi	r6, [r0], -sl, ror #20
     d40:	006c6961 	rsbeq	r6, ip, r1, ror #18
     d44:	74697865 	strbtvc	r7, [r9], #-2149	; 0xfffff79b
     d48:	65646f63 	strbvs	r6, [r4, #-3939]!	; 0xfffff09d
     d4c:	68637300 	stmdavs	r3!, {r8, r9, ip, sp, lr}^
     d50:	795f6465 	ldmdbvc	pc, {r0, r2, r5, r6, sl, sp, lr}^	; <UNPREDICTABLE>
     d54:	646c6569 	strbtvs	r6, [ip], #-1385	; 0xfffffa97
     d58:	63697400 	cmnvs	r9, #0, 8
     d5c:	6f635f6b 	svcvs	0x00635f6b
     d60:	5f746e75 	svcpl	0x00746e75
     d64:	75716572 	ldrbvc	r6, [r1, #-1394]!	; 0xfffffa8e
     d68:	64657269 	strbtvs	r7, [r5], #-617	; 0xfffffd97
     d6c:	325a5f00 	subscc	r5, sl, #0, 30
     d70:	74656734 	strbtvc	r6, [r5], #-1844	; 0xfffff8cc
     d74:	7463615f 	strbtvc	r6, [r3], #-351	; 0xfffffea1
     d78:	5f657669 	svcpl	0x00657669
     d7c:	636f7270 	cmnvs	pc, #112, 4
     d80:	5f737365 	svcpl	0x00737365
     d84:	6e756f63 	cdpvs	15, 7, cr6, cr5, cr3, {3}
     d88:	50007674 	andpl	r7, r0, r4, ror r6
     d8c:	5f657069 	svcpl	0x00657069
     d90:	656c6946 	strbvs	r6, [ip, #-2374]!	; 0xfffff6ba
     d94:	6572505f 	ldrbvs	r5, [r2, #-95]!	; 0xffffffa1
     d98:	00786966 	rsbseq	r6, r8, r6, ror #18
     d9c:	34315a5f 	ldrtcc	r5, [r1], #-2655	; 0xfffff5a1
     da0:	5f746567 	svcpl	0x00746567
     da4:	6b636974 	blvs	18db37c <__bss_end+0x18d2474>
     da8:	756f635f 	strbvc	r6, [pc, #-863]!	; a51 <shift+0xa51>
     dac:	0076746e 	rsbseq	r7, r6, lr, ror #8
     db0:	65656c73 	strbvs	r6, [r5, #-3187]!	; 0xfffff38d
     db4:	5a5f0070 	bpl	17c0f7c <__bss_end+0x17b8074>
     db8:	72657439 	rsbvc	r7, r5, #956301312	; 0x39000000
     dbc:	616e696d 	cmnvs	lr, sp, ror #18
     dc0:	00696574 	rsbeq	r6, r9, r4, ror r5
     dc4:	7265706f 	rsbvc	r7, r5, #111	; 0x6f
     dc8:	6f697461 	svcvs	0x00697461
     dcc:	5a5f006e 	bpl	17c0f8c <__bss_end+0x17b8084>
     dd0:	6f6c6335 	svcvs	0x006c6335
     dd4:	006a6573 	rsbeq	r6, sl, r3, ror r5
     dd8:	67365a5f 			; <UNDEFINED> instruction: 0x67365a5f
     ddc:	69707465 	ldmdbvs	r0!, {r0, r2, r5, r6, sl, ip, sp, lr}^
     de0:	66007664 	strvs	r7, [r0], -r4, ror #12
     de4:	656d616e 	strbvs	r6, [sp, #-366]!	; 0xfffffe92
     de8:	69727700 	ldmdbvs	r2!, {r8, r9, sl, ip, sp, lr}^
     dec:	74006574 	strvc	r6, [r0], #-1396	; 0xfffffa8c
     df0:	736b6369 	cmnvc	fp, #-1543503871	; 0xa4000001
     df4:	65706f00 	ldrbvs	r6, [r0, #-3840]!	; 0xfffff100
     df8:	5a5f006e 	bpl	17c0fb8 <__bss_end+0x17b80b0>
     dfc:	70697034 	rsbvc	r7, r9, r4, lsr r0
     e00:	634b5065 	movtvs	r5, #45157	; 0xb065
     e04:	444e006a 	strbmi	r0, [lr], #-106	; 0xffffff96
     e08:	6c646165 	stfvse	f6, [r4], #-404	; 0xfffffe6c
     e0c:	5f656e69 	svcpl	0x00656e69
     e10:	73627553 	cmnvc	r2, #348127232	; 0x14c00000
     e14:	69767265 	ldmdbvs	r6!, {r0, r2, r5, r6, r9, ip, sp, lr}^
     e18:	67006563 	strvs	r6, [r0, -r3, ror #10]
     e1c:	745f7465 	ldrbvc	r7, [pc], #-1125	; e24 <shift+0xe24>
     e20:	5f6b6369 	svcpl	0x006b6369
     e24:	6e756f63 	cdpvs	15, 7, cr6, cr5, cr3, {3}
     e28:	61700074 	cmnvs	r0, r4, ror r0
     e2c:	006d6172 	rsbeq	r6, sp, r2, ror r1
     e30:	77355a5f 			; <UNDEFINED> instruction: 0x77355a5f
     e34:	65746972 	ldrbvs	r6, [r4, #-2418]!	; 0xfffff68e
     e38:	634b506a 	movtvs	r5, #45162	; 0xb06a
     e3c:	6567006a 	strbvs	r0, [r7, #-106]!	; 0xffffff96
     e40:	61745f74 	cmnvs	r4, r4, ror pc
     e44:	745f6b73 	ldrbvc	r6, [pc], #-2931	; e4c <shift+0xe4c>
     e48:	736b6369 	cmnvc	fp, #-1543503871	; 0xa4000001
     e4c:	5f6f745f 	svcpl	0x006f745f
     e50:	64616564 	strbtvs	r6, [r1], #-1380	; 0xfffffa9c
     e54:	656e696c 	strbvs	r6, [lr, #-2412]!	; 0xfffff694
     e58:	66756200 	ldrbtvs	r6, [r5], -r0, lsl #4
     e5c:	7a69735f 	bvc	1a5dbe0 <__bss_end+0x1a54cd8>
     e60:	65730065 	ldrbvs	r0, [r3, #-101]!	; 0xffffff9b
     e64:	61745f74 	cmnvs	r4, r4, ror pc
     e68:	645f6b73 	ldrbvs	r6, [pc], #-2931	; e70 <shift+0xe70>
     e6c:	6c646165 	stfvse	f6, [r4], #-404	; 0xfffffe6c
     e70:	00656e69 	rsbeq	r6, r5, r9, ror #28
     e74:	6573552f 	ldrbvs	r5, [r3, #-1327]!	; 0xfffffad1
     e78:	772f7372 			; <UNDEFINED> instruction: 0x772f7372
     e7c:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
     e80:	2f696a72 	svccs	0x00696a72
     e84:	6b736544 	blvs	1cda39c <__bss_end+0x1cd1494>
     e88:	2f706f74 	svccs	0x00706f74
     e8c:	2f564146 	svccs	0x00564146
     e90:	6176614e 	cmnvs	r6, lr, asr #2
     e94:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
     e98:	4f2f6963 	svcmi	0x002f6963
     e9c:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
     ea0:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
     ea4:	6b6c6172 	blvs	1b19474 <__bss_end+0x1b1056c>
     ea8:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
     eac:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
     eb0:	756f732f 	strbvc	r7, [pc, #-815]!	; b89 <shift+0xb89>
     eb4:	73656372 	cmnvc	r5, #-939524095	; 0xc8000001
     eb8:	6474732f 	ldrbtvs	r7, [r4], #-815	; 0xfffffcd1
     ebc:	2f62696c 	svccs	0x0062696c
     ec0:	2f637273 	svccs	0x00637273
     ec4:	66647473 			; <UNDEFINED> instruction: 0x66647473
     ec8:	2e656c69 	cdpcs	12, 6, cr6, cr5, cr9, {3}
     ecc:	00707063 	rsbseq	r7, r0, r3, rrx
     ed0:	73355a5f 	teqvc	r5, #389120	; 0x5f000
     ed4:	7065656c 	rsbvc	r6, r5, ip, ror #10
     ed8:	47006a6a 	strmi	r6, [r0, -sl, ror #20]
     edc:	525f7465 	subspl	r7, pc, #1694498816	; 0x65000000
     ee0:	69616d65 	stmdbvs	r1!, {r0, r2, r5, r6, r8, sl, fp, sp, lr}^
     ee4:	676e696e 	strbvs	r6, [lr, -lr, ror #18]!
     ee8:	325a5f00 	subscc	r5, sl, #0, 30
     eec:	74656736 	strbtvc	r6, [r5], #-1846	; 0xfffff8ca
     ef0:	7361745f 	cmnvc	r1, #1593835520	; 0x5f000000
     ef4:	69745f6b 	ldmdbvs	r4!, {r0, r1, r3, r5, r6, r8, r9, sl, fp, ip, lr}^
     ef8:	5f736b63 	svcpl	0x00736b63
     efc:	645f6f74 	ldrbvs	r6, [pc], #-3956	; f04 <shift+0xf04>
     f00:	6c646165 	stfvse	f6, [r4], #-404	; 0xfffffe6c
     f04:	76656e69 	strbtvc	r6, [r5], -r9, ror #28
     f08:	57534e00 	ldrbpl	r4, [r3, -r0, lsl #28]
     f0c:	65525f49 	ldrbvs	r5, [r2, #-3913]	; 0xfffff0b7
     f10:	746c7573 	strbtvc	r7, [ip], #-1395	; 0xfffffa8d
     f14:	646f435f 	strbtvs	r4, [pc], #-863	; f1c <shift+0xf1c>
     f18:	72770065 	rsbsvc	r0, r7, #101	; 0x65
     f1c:	006d756e 	rsbeq	r7, sp, lr, ror #10
     f20:	77345a5f 			; <UNDEFINED> instruction: 0x77345a5f
     f24:	6a746961 	bvs	1d1b4b0 <__bss_end+0x1d125a8>
     f28:	5f006a6a 	svcpl	0x00006a6a
     f2c:	6f69355a 	svcvs	0x0069355a
     f30:	6a6c7463 	bvs	1b1e0c4 <__bss_end+0x1b151bc>
     f34:	494e3631 	stmdbmi	lr, {r0, r4, r5, r9, sl, ip, sp}^
     f38:	6c74434f 	ldclvs	3, cr4, [r4], #-316	; 0xfffffec4
     f3c:	65704f5f 	ldrbvs	r4, [r0, #-3935]!	; 0xfffff0a1
     f40:	69746172 	ldmdbvs	r4!, {r1, r4, r5, r6, r8, sp, lr}^
     f44:	76506e6f 	ldrbvc	r6, [r0], -pc, ror #28
     f48:	636f6900 	cmnvs	pc, #0, 18
     f4c:	72006c74 	andvc	r6, r0, #116, 24	; 0x7400
     f50:	6e637465 	cdpvs	4, 6, cr7, cr3, cr5, {3}
     f54:	6f6e0074 	svcvs	0x006e0074
     f58:	79666974 	stmdbvc	r6!, {r2, r4, r5, r6, r8, fp, sp, lr}^
     f5c:	72657400 	rsbvc	r7, r5, #0, 8
     f60:	616e696d 	cmnvs	lr, sp, ror #18
     f64:	6d006574 	cfstr32vs	mvfx6, [r0, #-464]	; 0xfffffe30
     f68:	0065646f 	rsbeq	r6, r5, pc, ror #8
     f6c:	66667562 	strbtvs	r7, [r6], -r2, ror #10
     f70:	5f007265 	svcpl	0x00007265
     f74:	6572345a 	ldrbvs	r3, [r2, #-1114]!	; 0xfffffba6
     f78:	506a6461 	rsbpl	r6, sl, r1, ror #8
     f7c:	47006a63 	strmi	r6, [r0, -r3, ror #20]
     f80:	4320554e 			; <UNDEFINED> instruction: 0x4320554e
     f84:	34312b2b 	ldrtcc	r2, [r1], #-2859	; 0xfffff4d5
     f88:	2e303120 	rsfcssp	f3, f0, f0
     f8c:	20312e33 	eorscs	r2, r1, r3, lsr lr
     f90:	31323032 	teqcc	r2, r2, lsr r0
     f94:	34323830 	ldrtcc	r3, [r2], #-2096	; 0xfffff7d0
     f98:	65722820 	ldrbvs	r2, [r2, #-2080]!	; 0xfffff7e0
     f9c:	7361656c 	cmnvc	r1, #108, 10	; 0x1b000000
     fa0:	2d202965 			; <UNDEFINED> instruction: 0x2d202965
     fa4:	6f6c666d 	svcvs	0x006c666d
     fa8:	612d7461 			; <UNDEFINED> instruction: 0x612d7461
     fac:	683d6962 	ldmdavs	sp!, {r1, r5, r6, r8, fp, sp, lr}
     fb0:	20647261 	rsbcs	r7, r4, r1, ror #4
     fb4:	70666d2d 	rsbvc	r6, r6, sp, lsr #26
     fb8:	66763d75 			; <UNDEFINED> instruction: 0x66763d75
     fbc:	6d2d2070 	stcvs	0, cr2, [sp, #-448]!	; 0xfffffe40
     fc0:	616f6c66 	cmnvs	pc, r6, ror #24
     fc4:	62612d74 	rsbvs	r2, r1, #116, 26	; 0x1d00
     fc8:	61683d69 	cmnvs	r8, r9, ror #26
     fcc:	2d206472 	cfstrscs	mvf6, [r0, #-456]!	; 0xfffffe38
     fd0:	7570666d 	ldrbvc	r6, [r0, #-1645]!	; 0xfffff993
     fd4:	7066763d 	rsbvc	r7, r6, sp, lsr r6
     fd8:	746d2d20 	strbtvc	r2, [sp], #-3360	; 0xfffff2e0
     fdc:	3d656e75 	stclcc	14, cr6, [r5, #-468]!	; 0xfffffe2c
     fe0:	316d7261 	cmncc	sp, r1, ror #4
     fe4:	6a363731 	bvs	d8ecb0 <__bss_end+0xd85da8>
     fe8:	732d667a 			; <UNDEFINED> instruction: 0x732d667a
     fec:	616d2d20 	cmnvs	sp, r0, lsr #26
     ff0:	2d206d72 	stccs	13, cr6, [r0, #-456]!	; 0xfffffe38
     ff4:	6372616d 	cmnvs	r2, #1073741851	; 0x4000001b
     ff8:	72613d68 	rsbvc	r3, r1, #104, 26	; 0x1a00
     ffc:	7a36766d 	bvc	d9e9b8 <__bss_end+0xd95ab0>
    1000:	70662b6b 	rsbvc	r2, r6, fp, ror #22
    1004:	20672d20 	rsbcs	r2, r7, r0, lsr #26
    1008:	2d20672d 	stccs	7, cr6, [r0, #-180]!	; 0xffffff4c
    100c:	4f2d2067 	svcmi	0x002d2067
    1010:	4f2d2030 	svcmi	0x002d2030
    1014:	662d2030 			; <UNDEFINED> instruction: 0x662d2030
    1018:	652d6f6e 	strvs	r6, [sp, #-3950]!	; 0xfffff092
    101c:	70656378 	rsbvc	r6, r5, r8, ror r3
    1020:	6e6f6974 			; <UNDEFINED> instruction: 0x6e6f6974
    1024:	662d2073 			; <UNDEFINED> instruction: 0x662d2073
    1028:	722d6f6e 	eorvc	r6, sp, #440	; 0x1b8
    102c:	00697474 	rsbeq	r7, r9, r4, ror r4
    1030:	63746572 	cmnvs	r4, #478150656	; 0x1c800000
    1034:	0065646f 	rsbeq	r6, r5, pc, ror #8
    1038:	5f746567 	svcpl	0x00746567
    103c:	69746361 	ldmdbvs	r4!, {r0, r5, r6, r8, r9, sp, lr}^
    1040:	705f6576 	subsvc	r6, pc, r6, ror r5	; <UNPREDICTABLE>
    1044:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
    1048:	635f7373 	cmpvs	pc, #-872415231	; 0xcc000001
    104c:	746e756f 	strbtvc	r7, [lr], #-1391	; 0xfffffa91
    1050:	6c696600 	stclvs	6, cr6, [r9], #-0
    1054:	6d616e65 	stclvs	14, cr6, [r1, #-404]!	; 0xfffffe6c
    1058:	65720065 	ldrbvs	r0, [r2, #-101]!	; 0xffffff9b
    105c:	67006461 	strvs	r6, [r0, -r1, ror #8]
    1060:	69707465 	ldmdbvs	r0!, {r0, r2, r5, r6, sl, ip, sp, lr}^
    1064:	5a5f0064 	bpl	17c11fc <__bss_end+0x17b82f4>
    1068:	65706f34 	ldrbvs	r6, [r0, #-3892]!	; 0xfffff0cc
    106c:	634b506e 	movtvs	r5, #45166	; 0xb06e
    1070:	464e3531 			; <UNDEFINED> instruction: 0x464e3531
    1074:	5f656c69 	svcpl	0x00656c69
    1078:	6e65704f 	cdpvs	0, 6, cr7, cr5, cr15, {2}
    107c:	646f4d5f 	strbtvs	r4, [pc], #-3423	; 1084 <shift+0x1084>
    1080:	6e690065 	cdpvs	0, 6, cr0, cr9, cr5, {3}
    1084:	00747570 	rsbseq	r7, r4, r0, ror r5
    1088:	74736564 	ldrbtvc	r6, [r3], #-1380	; 0xfffffa9c
    108c:	657a6200 	ldrbvs	r6, [sl, #-512]!	; 0xfffffe00
    1090:	6c006f72 	stcvs	15, cr6, [r0], {114}	; 0x72
    1094:	74676e65 	strbtvc	r6, [r7], #-3685	; 0xfffff19b
    1098:	5a5f0068 	bpl	17c1240 <__bss_end+0x17b8338>
    109c:	657a6235 	ldrbvs	r6, [sl, #-565]!	; 0xfffffdcb
    10a0:	76506f72 	usub16vc	r6, r0, r2
    10a4:	552f0069 	strpl	r0, [pc, #-105]!	; 1043 <shift+0x1043>
    10a8:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
    10ac:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
    10b0:	6a726574 	bvs	1c9a688 <__bss_end+0x1c91780>
    10b4:	65442f69 	strbvs	r2, [r4, #-3945]	; 0xfffff097
    10b8:	6f746b73 	svcvs	0x00746b73
    10bc:	41462f70 	hvcmi	25328	; 0x62f0
    10c0:	614e2f56 	cmpvs	lr, r6, asr pc
    10c4:	757a6176 	ldrbvc	r6, [sl, #-374]!	; 0xfffffe8a
    10c8:	6963696a 	stmdbvs	r3!, {r1, r3, r5, r6, r8, fp, sp, lr}^
    10cc:	2f534f2f 	svccs	0x00534f2f
    10d0:	656d6573 	strbvs	r6, [sp, #-1395]!	; 0xfffffa8d
    10d4:	61727473 	cmnvs	r2, r3, ror r4
    10d8:	2d616b6c 	vstmdbcs	r1!, {d22-<overflow reg d75>}
    10dc:	2d76696b 			; <UNDEFINED> instruction: 0x2d76696b
    10e0:	732f736f 			; <UNDEFINED> instruction: 0x732f736f
    10e4:	6372756f 	cmnvs	r2, #465567744	; 0x1bc00000
    10e8:	732f7365 			; <UNDEFINED> instruction: 0x732f7365
    10ec:	696c6474 	stmdbvs	ip!, {r2, r4, r5, r6, sl, sp, lr}^
    10f0:	72732f62 	rsbsvc	r2, r3, #392	; 0x188
    10f4:	74732f63 	ldrbtvc	r2, [r3], #-3939	; 0xfffff09d
    10f8:	72747364 	rsbsvc	r7, r4, #100, 6	; 0x90000001
    10fc:	2e676e69 	cdpcs	14, 6, cr6, cr7, cr9, {3}
    1100:	00707063 	rsbseq	r7, r0, r3, rrx
    1104:	61345a5f 	teqvs	r4, pc, asr sl
    1108:	50696f74 	rsbpl	r6, r9, r4, ror pc
    110c:	4300634b 	movwmi	r6, #843	; 0x34b
    1110:	43726168 	cmnmi	r2, #104, 2
    1114:	41766e6f 	cmnmi	r6, pc, ror #28
    1118:	6d007272 	sfmvs	f7, 4, [r0, #-456]	; 0xfffffe38
    111c:	73646d65 	cmnvc	r4, #6464	; 0x1940
    1120:	756f0074 	strbvc	r0, [pc, #-116]!	; 10b4 <shift+0x10b4>
    1124:	74757074 	ldrbtvc	r7, [r5], #-116	; 0xffffff8c
    1128:	365a5f00 	ldrbcc	r5, [sl], -r0, lsl #30
    112c:	636d656d 	cmnvs	sp, #457179136	; 0x1b400000
    1130:	4b507970 	blmi	141f6f8 <__bss_end+0x14167f0>
    1134:	69765076 	ldmdbvs	r6!, {r1, r2, r4, r5, r6, ip, lr}^
    1138:	73616200 	cmnvc	r1, #0, 4
    113c:	656d0065 	strbvs	r0, [sp, #-101]!	; 0xffffff9b
    1140:	7970636d 	ldmdbvc	r0!, {r0, r2, r3, r5, r6, r8, r9, sp, lr}^
    1144:	72747300 	rsbsvc	r7, r4, #0, 6
    1148:	006e656c 	rsbeq	r6, lr, ip, ror #10
    114c:	73375a5f 	teqvc	r7, #389120	; 0x5f000
    1150:	636e7274 	cmnvs	lr, #116, 4	; 0x40000007
    1154:	4b50706d 	blmi	141d310 <__bss_end+0x1414408>
    1158:	5f305363 	svcpl	0x00305363
    115c:	5a5f0069 	bpl	17c1308 <__bss_end+0x17b8400>
    1160:	72747336 	rsbsvc	r7, r4, #-671088640	; 0xd8000000
    1164:	506e656c 	rsbpl	r6, lr, ip, ror #10
    1168:	6100634b 	tstvs	r0, fp, asr #6
    116c:	00696f74 	rsbeq	r6, r9, r4, ror pc
    1170:	73375a5f 	teqvc	r7, #389120	; 0x5f000
    1174:	636e7274 	cmnvs	lr, #116, 4	; 0x40000007
    1178:	63507970 	cmpvs	r0, #112, 18	; 0x1c0000
    117c:	69634b50 	stmdbvs	r3!, {r4, r6, r8, r9, fp, lr}^
    1180:	72747300 	rsbsvc	r7, r4, #0, 6
    1184:	706d636e 	rsbvc	r6, sp, lr, ror #6
    1188:	72747300 	rsbsvc	r7, r4, #0, 6
    118c:	7970636e 	ldmdbvc	r0!, {r1, r2, r3, r5, r6, r8, r9, sp, lr}^
    1190:	6d656d00 	stclvs	13, cr6, [r5, #-0]
    1194:	0079726f 	rsbseq	r7, r9, pc, ror #4
    1198:	736d656d 	cmnvc	sp, #457179136	; 0x1b400000
    119c:	69006372 	stmdbvs	r0, {r1, r4, r5, r6, r8, r9, sp, lr}
    11a0:	00616f74 	rsbeq	r6, r1, r4, ror pc
    11a4:	69345a5f 	ldmdbvs	r4!, {r0, r1, r2, r3, r4, r6, r9, fp, ip, lr}
    11a8:	6a616f74 	bvs	185cf80 <__bss_end+0x1854078>
    11ac:	006a6350 	rsbeq	r6, sl, r0, asr r3

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
  20:	8b040e42 	blhi	103930 <__bss_end+0xfaa28>
  24:	0b0d4201 	bleq	350830 <__bss_end+0x347928>
  28:	420d0d62 	andmi	r0, sp, #6272	; 0x1880
  2c:	00000ecb 	andeq	r0, r0, fp, asr #29
  30:	0000001c 	andeq	r0, r0, ip, lsl r0
  34:	00000000 	andeq	r0, r0, r0
  38:	00008064 	andeq	r8, r0, r4, rrx
  3c:	00000040 	andeq	r0, r0, r0, asr #32
  40:	8b080e42 	blhi	203950 <__bss_end+0x1faa48>
  44:	42018e02 	andmi	r8, r1, #2, 28
  48:	5a040b0c 	bpl	102c80 <__bss_end+0xf9d78>
  4c:	00080d0c 	andeq	r0, r8, ip, lsl #26
  50:	0000000c 	andeq	r0, r0, ip
  54:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
  58:	7c020001 	stcvc	0, cr0, [r2], {1}
  5c:	000d0c0e 	andeq	r0, sp, lr, lsl #24
  60:	0000001c 	andeq	r0, r0, ip, lsl r0
  64:	00000050 	andeq	r0, r0, r0, asr r0
  68:	000080a4 	andeq	r8, r0, r4, lsr #1
  6c:	00000038 	andeq	r0, r0, r8, lsr r0
  70:	8b040e42 	blhi	103980 <__bss_end+0xfaa78>
  74:	0b0d4201 	bleq	350880 <__bss_end+0x347978>
  78:	420d0d54 	andmi	r0, sp, #84, 26	; 0x1500
  7c:	00000ecb 	andeq	r0, r0, fp, asr #29
  80:	0000001c 	andeq	r0, r0, ip, lsl r0
  84:	00000050 	andeq	r0, r0, r0, asr r0
  88:	000080dc 	ldrdeq	r8, [r0], -ip
  8c:	0000002c 	andeq	r0, r0, ip, lsr #32
  90:	8b040e42 	blhi	1039a0 <__bss_end+0xfaa98>
  94:	0b0d4201 	bleq	3508a0 <__bss_end+0x347998>
  98:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
  9c:	00000ecb 	andeq	r0, r0, fp, asr #29
  a0:	0000001c 	andeq	r0, r0, ip, lsl r0
  a4:	00000050 	andeq	r0, r0, r0, asr r0
  a8:	00008108 	andeq	r8, r0, r8, lsl #2
  ac:	00000020 	andeq	r0, r0, r0, lsr #32
  b0:	8b040e42 	blhi	1039c0 <__bss_end+0xfaab8>
  b4:	0b0d4201 	bleq	3508c0 <__bss_end+0x3479b8>
  b8:	420d0d48 	andmi	r0, sp, #72, 26	; 0x1200
  bc:	00000ecb 	andeq	r0, r0, fp, asr #29
  c0:	0000001c 	andeq	r0, r0, ip, lsl r0
  c4:	00000050 	andeq	r0, r0, r0, asr r0
  c8:	00008128 	andeq	r8, r0, r8, lsr #2
  cc:	00000018 	andeq	r0, r0, r8, lsl r0
  d0:	8b040e42 	blhi	1039e0 <__bss_end+0xfaad8>
  d4:	0b0d4201 	bleq	3508e0 <__bss_end+0x3479d8>
  d8:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
  dc:	00000ecb 	andeq	r0, r0, fp, asr #29
  e0:	0000001c 	andeq	r0, r0, ip, lsl r0
  e4:	00000050 	andeq	r0, r0, r0, asr r0
  e8:	00008140 	andeq	r8, r0, r0, asr #2
  ec:	00000018 	andeq	r0, r0, r8, lsl r0
  f0:	8b040e42 	blhi	103a00 <__bss_end+0xfaaf8>
  f4:	0b0d4201 	bleq	350900 <__bss_end+0x3479f8>
  f8:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
  fc:	00000ecb 	andeq	r0, r0, fp, asr #29
 100:	0000001c 	andeq	r0, r0, ip, lsl r0
 104:	00000050 	andeq	r0, r0, r0, asr r0
 108:	00008158 	andeq	r8, r0, r8, asr r1
 10c:	00000018 	andeq	r0, r0, r8, lsl r0
 110:	8b040e42 	blhi	103a20 <__bss_end+0xfab18>
 114:	0b0d4201 	bleq	350920 <__bss_end+0x347a18>
 118:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
 11c:	00000ecb 	andeq	r0, r0, fp, asr #29
 120:	00000014 	andeq	r0, r0, r4, lsl r0
 124:	00000050 	andeq	r0, r0, r0, asr r0
 128:	00008170 	andeq	r8, r0, r0, ror r1
 12c:	0000000c 	andeq	r0, r0, ip
 130:	8b040e42 	blhi	103a40 <__bss_end+0xfab38>
 134:	0b0d4201 	bleq	350940 <__bss_end+0x347a38>
 138:	0000001c 	andeq	r0, r0, ip, lsl r0
 13c:	00000050 	andeq	r0, r0, r0, asr r0
 140:	0000817c 	andeq	r8, r0, ip, ror r1
 144:	00000058 	andeq	r0, r0, r8, asr r0
 148:	8b080e42 	blhi	203a58 <__bss_end+0x1fab50>
 14c:	42018e02 	andmi	r8, r1, #2, 28
 150:	62040b0c 	andvs	r0, r4, #12, 22	; 0x3000
 154:	00080d0c 	andeq	r0, r8, ip, lsl #26
 158:	0000001c 	andeq	r0, r0, ip, lsl r0
 15c:	00000050 	andeq	r0, r0, r0, asr r0
 160:	000081d4 	ldrdeq	r8, [r0], -r4
 164:	00000058 	andeq	r0, r0, r8, asr r0
 168:	8b080e42 	blhi	203a78 <__bss_end+0x1fab70>
 16c:	42018e02 	andmi	r8, r1, #2, 28
 170:	62040b0c 	andvs	r0, r4, #12, 22	; 0x3000
 174:	00080d0c 	andeq	r0, r8, ip, lsl #26
 178:	0000000c 	andeq	r0, r0, ip
 17c:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 180:	7c020001 	stcvc	0, cr0, [r2], {1}
 184:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 188:	00000018 	andeq	r0, r0, r8, lsl r0
 18c:	00000178 	andeq	r0, r0, r8, ror r1
 190:	0000822c 	andeq	r8, r0, ip, lsr #4
 194:	000000dc 	ldrdeq	r0, [r0], -ip
 198:	8b080e42 	blhi	203aa8 <__bss_end+0x1faba0>
 19c:	42018e02 	andmi	r8, r1, #2, 28
 1a0:	00040b0c 	andeq	r0, r4, ip, lsl #22
 1a4:	0000000c 	andeq	r0, r0, ip
 1a8:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 1ac:	7c020001 	stcvc	0, cr0, [r2], {1}
 1b0:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 1b4:	0000001c 	andeq	r0, r0, ip, lsl r0
 1b8:	000001a4 	andeq	r0, r0, r4, lsr #3
 1bc:	00008308 	andeq	r8, r0, r8, lsl #6
 1c0:	0000002c 	andeq	r0, r0, ip, lsr #32
 1c4:	8b040e42 	blhi	103ad4 <__bss_end+0xfabcc>
 1c8:	0b0d4201 	bleq	3509d4 <__bss_end+0x347acc>
 1cc:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
 1d0:	00000ecb 	andeq	r0, r0, fp, asr #29
 1d4:	0000001c 	andeq	r0, r0, ip, lsl r0
 1d8:	000001a4 	andeq	r0, r0, r4, lsr #3
 1dc:	00008334 	andeq	r8, r0, r4, lsr r3
 1e0:	0000002c 	andeq	r0, r0, ip, lsr #32
 1e4:	8b040e42 	blhi	103af4 <__bss_end+0xfabec>
 1e8:	0b0d4201 	bleq	3509f4 <__bss_end+0x347aec>
 1ec:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
 1f0:	00000ecb 	andeq	r0, r0, fp, asr #29
 1f4:	0000001c 	andeq	r0, r0, ip, lsl r0
 1f8:	000001a4 	andeq	r0, r0, r4, lsr #3
 1fc:	00008360 	andeq	r8, r0, r0, ror #6
 200:	0000001c 	andeq	r0, r0, ip, lsl r0
 204:	8b040e42 	blhi	103b14 <__bss_end+0xfac0c>
 208:	0b0d4201 	bleq	350a14 <__bss_end+0x347b0c>
 20c:	420d0d46 	andmi	r0, sp, #4480	; 0x1180
 210:	00000ecb 	andeq	r0, r0, fp, asr #29
 214:	0000001c 	andeq	r0, r0, ip, lsl r0
 218:	000001a4 	andeq	r0, r0, r4, lsr #3
 21c:	0000837c 	andeq	r8, r0, ip, ror r3
 220:	00000044 	andeq	r0, r0, r4, asr #32
 224:	8b040e42 	blhi	103b34 <__bss_end+0xfac2c>
 228:	0b0d4201 	bleq	350a34 <__bss_end+0x347b2c>
 22c:	420d0d5a 	andmi	r0, sp, #5760	; 0x1680
 230:	00000ecb 	andeq	r0, r0, fp, asr #29
 234:	0000001c 	andeq	r0, r0, ip, lsl r0
 238:	000001a4 	andeq	r0, r0, r4, lsr #3
 23c:	000083c0 	andeq	r8, r0, r0, asr #7
 240:	00000050 	andeq	r0, r0, r0, asr r0
 244:	8b040e42 	blhi	103b54 <__bss_end+0xfac4c>
 248:	0b0d4201 	bleq	350a54 <__bss_end+0x347b4c>
 24c:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 250:	00000ecb 	andeq	r0, r0, fp, asr #29
 254:	0000001c 	andeq	r0, r0, ip, lsl r0
 258:	000001a4 	andeq	r0, r0, r4, lsr #3
 25c:	00008410 	andeq	r8, r0, r0, lsl r4
 260:	00000050 	andeq	r0, r0, r0, asr r0
 264:	8b040e42 	blhi	103b74 <__bss_end+0xfac6c>
 268:	0b0d4201 	bleq	350a74 <__bss_end+0x347b6c>
 26c:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 270:	00000ecb 	andeq	r0, r0, fp, asr #29
 274:	0000001c 	andeq	r0, r0, ip, lsl r0
 278:	000001a4 	andeq	r0, r0, r4, lsr #3
 27c:	00008460 	andeq	r8, r0, r0, ror #8
 280:	0000002c 	andeq	r0, r0, ip, lsr #32
 284:	8b040e42 	blhi	103b94 <__bss_end+0xfac8c>
 288:	0b0d4201 	bleq	350a94 <__bss_end+0x347b8c>
 28c:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
 290:	00000ecb 	andeq	r0, r0, fp, asr #29
 294:	0000001c 	andeq	r0, r0, ip, lsl r0
 298:	000001a4 	andeq	r0, r0, r4, lsr #3
 29c:	0000848c 	andeq	r8, r0, ip, lsl #9
 2a0:	00000050 	andeq	r0, r0, r0, asr r0
 2a4:	8b040e42 	blhi	103bb4 <__bss_end+0xfacac>
 2a8:	0b0d4201 	bleq	350ab4 <__bss_end+0x347bac>
 2ac:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 2b0:	00000ecb 	andeq	r0, r0, fp, asr #29
 2b4:	0000001c 	andeq	r0, r0, ip, lsl r0
 2b8:	000001a4 	andeq	r0, r0, r4, lsr #3
 2bc:	000084dc 	ldrdeq	r8, [r0], -ip
 2c0:	00000044 	andeq	r0, r0, r4, asr #32
 2c4:	8b040e42 	blhi	103bd4 <__bss_end+0xfaccc>
 2c8:	0b0d4201 	bleq	350ad4 <__bss_end+0x347bcc>
 2cc:	420d0d5a 	andmi	r0, sp, #5760	; 0x1680
 2d0:	00000ecb 	andeq	r0, r0, fp, asr #29
 2d4:	0000001c 	andeq	r0, r0, ip, lsl r0
 2d8:	000001a4 	andeq	r0, r0, r4, lsr #3
 2dc:	00008520 	andeq	r8, r0, r0, lsr #10
 2e0:	00000050 	andeq	r0, r0, r0, asr r0
 2e4:	8b040e42 	blhi	103bf4 <__bss_end+0xfacec>
 2e8:	0b0d4201 	bleq	350af4 <__bss_end+0x347bec>
 2ec:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 2f0:	00000ecb 	andeq	r0, r0, fp, asr #29
 2f4:	0000001c 	andeq	r0, r0, ip, lsl r0
 2f8:	000001a4 	andeq	r0, r0, r4, lsr #3
 2fc:	00008570 	andeq	r8, r0, r0, ror r5
 300:	00000054 	andeq	r0, r0, r4, asr r0
 304:	8b040e42 	blhi	103c14 <__bss_end+0xfad0c>
 308:	0b0d4201 	bleq	350b14 <__bss_end+0x347c0c>
 30c:	420d0d62 	andmi	r0, sp, #6272	; 0x1880
 310:	00000ecb 	andeq	r0, r0, fp, asr #29
 314:	0000001c 	andeq	r0, r0, ip, lsl r0
 318:	000001a4 	andeq	r0, r0, r4, lsr #3
 31c:	000085c4 	andeq	r8, r0, r4, asr #11
 320:	0000003c 	andeq	r0, r0, ip, lsr r0
 324:	8b040e42 	blhi	103c34 <__bss_end+0xfad2c>
 328:	0b0d4201 	bleq	350b34 <__bss_end+0x347c2c>
 32c:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 330:	00000ecb 	andeq	r0, r0, fp, asr #29
 334:	0000001c 	andeq	r0, r0, ip, lsl r0
 338:	000001a4 	andeq	r0, r0, r4, lsr #3
 33c:	00008600 	andeq	r8, r0, r0, lsl #12
 340:	0000003c 	andeq	r0, r0, ip, lsr r0
 344:	8b040e42 	blhi	103c54 <__bss_end+0xfad4c>
 348:	0b0d4201 	bleq	350b54 <__bss_end+0x347c4c>
 34c:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 350:	00000ecb 	andeq	r0, r0, fp, asr #29
 354:	0000001c 	andeq	r0, r0, ip, lsl r0
 358:	000001a4 	andeq	r0, r0, r4, lsr #3
 35c:	0000863c 	andeq	r8, r0, ip, lsr r6
 360:	0000003c 	andeq	r0, r0, ip, lsr r0
 364:	8b040e42 	blhi	103c74 <__bss_end+0xfad6c>
 368:	0b0d4201 	bleq	350b74 <__bss_end+0x347c6c>
 36c:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 370:	00000ecb 	andeq	r0, r0, fp, asr #29
 374:	0000001c 	andeq	r0, r0, ip, lsl r0
 378:	000001a4 	andeq	r0, r0, r4, lsr #3
 37c:	00008678 	andeq	r8, r0, r8, ror r6
 380:	0000003c 	andeq	r0, r0, ip, lsr r0
 384:	8b040e42 	blhi	103c94 <__bss_end+0xfad8c>
 388:	0b0d4201 	bleq	350b94 <__bss_end+0x347c8c>
 38c:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 390:	00000ecb 	andeq	r0, r0, fp, asr #29
 394:	0000001c 	andeq	r0, r0, ip, lsl r0
 398:	000001a4 	andeq	r0, r0, r4, lsr #3
 39c:	000086b4 			; <UNDEFINED> instruction: 0x000086b4
 3a0:	000000b0 	strheq	r0, [r0], -r0	; <UNPREDICTABLE>
 3a4:	8b080e42 	blhi	203cb4 <__bss_end+0x1fadac>
 3a8:	42018e02 	andmi	r8, r1, #2, 28
 3ac:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 3b0:	080d0c50 	stmdaeq	sp, {r4, r6, sl, fp}
 3b4:	0000000c 	andeq	r0, r0, ip
 3b8:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 3bc:	7c020001 	stcvc	0, cr0, [r2], {1}
 3c0:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 3c4:	0000001c 	andeq	r0, r0, ip, lsl r0
 3c8:	000003b4 			; <UNDEFINED> instruction: 0x000003b4
 3cc:	00008764 	andeq	r8, r0, r4, ror #14
 3d0:	00000174 	andeq	r0, r0, r4, ror r1
 3d4:	8b080e42 	blhi	203ce4 <__bss_end+0x1faddc>
 3d8:	42018e02 	andmi	r8, r1, #2, 28
 3dc:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 3e0:	080d0cb2 	stmdaeq	sp, {r1, r4, r5, r7, sl, fp}
 3e4:	0000001c 	andeq	r0, r0, ip, lsl r0
 3e8:	000003b4 			; <UNDEFINED> instruction: 0x000003b4
 3ec:	000088d8 	ldrdeq	r8, [r0], -r8	; <UNPREDICTABLE>
 3f0:	0000009c 	muleq	r0, ip, r0
 3f4:	8b040e42 	blhi	103d04 <__bss_end+0xfadfc>
 3f8:	0b0d4201 	bleq	350c04 <__bss_end+0x347cfc>
 3fc:	0d0d4602 	stceq	6, cr4, [sp, #-8]
 400:	000ecb42 	andeq	ip, lr, r2, asr #22
 404:	0000001c 	andeq	r0, r0, ip, lsl r0
 408:	000003b4 			; <UNDEFINED> instruction: 0x000003b4
 40c:	00008974 	andeq	r8, r0, r4, ror r9
 410:	000000c0 	andeq	r0, r0, r0, asr #1
 414:	8b040e42 	blhi	103d24 <__bss_end+0xfae1c>
 418:	0b0d4201 	bleq	350c24 <__bss_end+0x347d1c>
 41c:	0d0d5802 	stceq	8, cr5, [sp, #-8]
 420:	000ecb42 	andeq	ip, lr, r2, asr #22
 424:	0000001c 	andeq	r0, r0, ip, lsl r0
 428:	000003b4 			; <UNDEFINED> instruction: 0x000003b4
 42c:	00008a34 	andeq	r8, r0, r4, lsr sl
 430:	000000ac 	andeq	r0, r0, ip, lsr #1
 434:	8b040e42 	blhi	103d44 <__bss_end+0xfae3c>
 438:	0b0d4201 	bleq	350c44 <__bss_end+0x347d3c>
 43c:	0d0d4e02 	stceq	14, cr4, [sp, #-8]
 440:	000ecb42 	andeq	ip, lr, r2, asr #22
 444:	0000001c 	andeq	r0, r0, ip, lsl r0
 448:	000003b4 			; <UNDEFINED> instruction: 0x000003b4
 44c:	00008ae0 	andeq	r8, r0, r0, ror #21
 450:	00000054 	andeq	r0, r0, r4, asr r0
 454:	8b040e42 	blhi	103d64 <__bss_end+0xfae5c>
 458:	0b0d4201 	bleq	350c64 <__bss_end+0x347d5c>
 45c:	420d0d62 	andmi	r0, sp, #6272	; 0x1880
 460:	00000ecb 	andeq	r0, r0, fp, asr #29
 464:	0000001c 	andeq	r0, r0, ip, lsl r0
 468:	000003b4 			; <UNDEFINED> instruction: 0x000003b4
 46c:	00008b34 	andeq	r8, r0, r4, lsr fp
 470:	00000068 	andeq	r0, r0, r8, rrx
 474:	8b040e42 	blhi	103d84 <__bss_end+0xfae7c>
 478:	0b0d4201 	bleq	350c84 <__bss_end+0x347d7c>
 47c:	420d0d6c 	andmi	r0, sp, #108, 26	; 0x1b00
 480:	00000ecb 	andeq	r0, r0, fp, asr #29
 484:	0000001c 	andeq	r0, r0, ip, lsl r0
 488:	000003b4 			; <UNDEFINED> instruction: 0x000003b4
 48c:	00008b9c 	muleq	r0, ip, fp
 490:	00000080 	andeq	r0, r0, r0, lsl #1
 494:	8b040e42 	blhi	103da4 <__bss_end+0xfae9c>
 498:	0b0d4201 	bleq	350ca4 <__bss_end+0x347d9c>
 49c:	420d0d78 	andmi	r0, sp, #120, 26	; 0x1e00
 4a0:	00000ecb 	andeq	r0, r0, fp, asr #29
 4a4:	0000000c 	andeq	r0, r0, ip
 4a8:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 4ac:	7c010001 	stcvc	0, cr0, [r1], {1}
 4b0:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 4b4:	0000000c 	andeq	r0, r0, ip
 4b8:	000004a4 	andeq	r0, r0, r4, lsr #9
 4bc:	00008c1c 	andeq	r8, r0, ip, lsl ip
 4c0:	000001ec 	andeq	r0, r0, ip, ror #3
