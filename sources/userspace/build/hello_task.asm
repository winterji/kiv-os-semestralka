
./hello_task:     file format elf32-littlearm


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
    805c:	00008fc4 	andeq	r8, r0, r4, asr #31
    8060:	00008fe0 	andeq	r8, r0, r0, ror #31

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
    8080:	eb00008d 	bl	82bc <main>
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
    81cc:	00008fc1 	andeq	r8, r0, r1, asr #31
    81d0:	00008fc1 	andeq	r8, r0, r1, asr #31

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
    8224:	00008fc1 	andeq	r8, r0, r1, asr #31
    8228:	00008fc1 	andeq	r8, r0, r1, asr #31

0000822c <_Z5blinkv>:
_Z5blinkv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:19
constexpr uint32_t char_tick_delay = 0x1000;

uint32_t sos_led, uart, trng;

void blink()
{
    822c:	e92d4800 	push	{fp, lr}
    8230:	e28db004 	add	fp, sp, #4
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:20
	write(sos_led, "1", 1);
    8234:	e59f303c 	ldr	r3, [pc, #60]	; 8278 <_Z5blinkv+0x4c>
    8238:	e5933000 	ldr	r3, [r3]
    823c:	e3a02001 	mov	r2, #1
    8240:	e59f1034 	ldr	r1, [pc, #52]	; 827c <_Z5blinkv+0x50>
    8244:	e1a00003 	mov	r0, r3
    8248:	eb00009b 	bl	84bc <_Z5writejPKcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:21
	sleep(0x1000);
    824c:	e3e01001 	mvn	r1, #1
    8250:	e3a00a01 	mov	r0, #4096	; 0x1000
    8254:	eb0000f0 	bl	861c <_Z5sleepjj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:22
	write(sos_led, "0", 1);
    8258:	e59f3018 	ldr	r3, [pc, #24]	; 8278 <_Z5blinkv+0x4c>
    825c:	e5933000 	ldr	r3, [r3]
    8260:	e3a02001 	mov	r2, #1
    8264:	e59f1014 	ldr	r1, [pc, #20]	; 8280 <_Z5blinkv+0x54>
    8268:	e1a00003 	mov	r0, r3
    826c:	eb000092 	bl	84bc <_Z5writejPKcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:23
}
    8270:	e320f000 	nop	{0}
    8274:	e8bd8800 	pop	{fp, pc}
    8278:	00008fc4 	andeq	r8, r0, r4, asr #31
    827c:	00008f3c 	andeq	r8, r0, ip, lsr pc
    8280:	00008f40 	andeq	r8, r0, r0, asr #30

00008284 <_Z10get_randomPc>:
_Z10get_randomPc():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:26

void get_random(char* buff)
{
    8284:	e92d4800 	push	{fp, lr}
    8288:	e28db004 	add	fp, sp, #4
    828c:	e24dd008 	sub	sp, sp, #8
    8290:	e50b0008 	str	r0, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:27
    read(trng, buff, 4);
    8294:	e59f301c 	ldr	r3, [pc, #28]	; 82b8 <_Z10get_randomPc+0x34>
    8298:	e5933000 	ldr	r3, [r3]
    829c:	e3a02004 	mov	r2, #4
    82a0:	e51b1008 	ldr	r1, [fp, #-8]
    82a4:	e1a00003 	mov	r0, r3
    82a8:	eb00006f 	bl	846c <_Z4readjPcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:28
}
    82ac:	e320f000 	nop	{0}
    82b0:	e24bd004 	sub	sp, fp, #4
    82b4:	e8bd8800 	pop	{fp, pc}
    82b8:	00008fcc 	andeq	r8, r0, ip, asr #31

000082bc <main>:
main():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:31

int main(int argc, char** argv)
{
    82bc:	e92d4810 	push	{r4, fp, lr}
    82c0:	e28db008 	add	fp, sp, #8
    82c4:	e24dd03c 	sub	sp, sp, #60	; 0x3c
    82c8:	e50b0040 	str	r0, [fp, #-64]	; 0xffffffc0
    82cc:	e50b1044 	str	r1, [fp, #-68]	; 0xffffffbc
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:36
    char buff[4], temp_buff[32]; // buffer nulled
    uint32_t* wbuf;
    int rndNum;

	sos_led = open("DEV:gpio/47", NFile_Open_Mode::Write_Only);
    82d0:	e3a01001 	mov	r1, #1
    82d4:	e59f00bc 	ldr	r0, [pc, #188]	; 8398 <main+0xdc>
    82d8:	eb000052 	bl	8428 <_Z4openPKc15NFile_Open_Mode>
    82dc:	e1a03000 	mov	r3, r0
    82e0:	e59f20b4 	ldr	r2, [pc, #180]	; 839c <main+0xe0>
    82e4:	e5823000 	str	r3, [r2]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:37
	uart = open("DEV:uart/0", NFile_Open_Mode::Read_Write);
    82e8:	e3a01002 	mov	r1, #2
    82ec:	e59f00ac 	ldr	r0, [pc, #172]	; 83a0 <main+0xe4>
    82f0:	eb00004c 	bl	8428 <_Z4openPKc15NFile_Open_Mode>
    82f4:	e1a03000 	mov	r3, r0
    82f8:	e59f20a4 	ldr	r2, [pc, #164]	; 83a4 <main+0xe8>
    82fc:	e5823000 	str	r3, [r2]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:38
    trng = open("DEV:trng/0", NFile_Open_Mode::Read_Write);
    8300:	e3a01002 	mov	r1, #2
    8304:	e59f009c 	ldr	r0, [pc, #156]	; 83a8 <main+0xec>
    8308:	eb000046 	bl	8428 <_Z4openPKc15NFile_Open_Mode>
    830c:	e1a03000 	mov	r3, r0
    8310:	e59f2094 	ldr	r2, [pc, #148]	; 83ac <main+0xf0>
    8314:	e5823000 	str	r3, [r2]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:42 (discriminator 1)

	while (true)
	{
        write(uart, "Random number: ", 15);
    8318:	e59f3084 	ldr	r3, [pc, #132]	; 83a4 <main+0xe8>
    831c:	e5933000 	ldr	r3, [r3]
    8320:	e3a0200f 	mov	r2, #15
    8324:	e59f1084 	ldr	r1, [pc, #132]	; 83b0 <main+0xf4>
    8328:	e1a00003 	mov	r0, r3
    832c:	eb000062 	bl	84bc <_Z5writejPKcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:43 (discriminator 1)
        blink();
    8330:	ebffffbd 	bl	822c <_Z5blinkv>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:44 (discriminator 1)
        get_random(buff);
    8334:	e24b3018 	sub	r3, fp, #24
    8338:	e1a00003 	mov	r0, r3
    833c:	ebffffd0 	bl	8284 <_Z10get_randomPc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:45 (discriminator 1)
        uint32_t* wbuf = reinterpret_cast<uint32_t*>(buff);
    8340:	e24b3018 	sub	r3, fp, #24
    8344:	e50b3010 	str	r3, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:46 (discriminator 1)
        rndNum = wbuf[0];
    8348:	e51b3010 	ldr	r3, [fp, #-16]
    834c:	e5933000 	ldr	r3, [r3]
    8350:	e50b3014 	str	r3, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:47 (discriminator 1)
        itoa(rndNum, temp_buff, 10);
    8354:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8358:	e24b1038 	sub	r1, fp, #56	; 0x38
    835c:	e3a0200a 	mov	r2, #10
    8360:	e1a00003 	mov	r0, r3
    8364:	eb000129 	bl	8810 <_Z4itoajPcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:48 (discriminator 1)
        write(uart, temp_buff, strlen(temp_buff));
    8368:	e59f3034 	ldr	r3, [pc, #52]	; 83a4 <main+0xe8>
    836c:	e5934000 	ldr	r4, [r3]
    8370:	e24b3038 	sub	r3, fp, #56	; 0x38
    8374:	e1a00003 	mov	r0, r3
    8378:	eb000203 	bl	8b8c <_Z6strlenPKc>
    837c:	e1a03000 	mov	r3, r0
    8380:	e1a02003 	mov	r2, r3
    8384:	e24b3038 	sub	r3, fp, #56	; 0x38
    8388:	e1a01003 	mov	r1, r3
    838c:	e1a00004 	mov	r0, r4
    8390:	eb000049 	bl	84bc <_Z5writejPKcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:50 (discriminator 1)
        
	}
    8394:	eaffffdf 	b	8318 <main+0x5c>
    8398:	00008f44 	andeq	r8, r0, r4, asr #30
    839c:	00008fc4 	andeq	r8, r0, r4, asr #31
    83a0:	00008f50 	andeq	r8, r0, r0, asr pc
    83a4:	00008fc8 	andeq	r8, r0, r8, asr #31
    83a8:	00008f5c 	andeq	r8, r0, ip, asr pc
    83ac:	00008fcc 	andeq	r8, r0, ip, asr #31
    83b0:	00008f68 	andeq	r8, r0, r8, ror #30

000083b4 <_Z6getpidv>:
_Z6getpidv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:5
#include <stdfile.h>
#include <stdstring.h>

uint32_t getpid()
{
    83b4:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    83b8:	e28db000 	add	fp, sp, #0
    83bc:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:8
    uint32_t pid;

    asm volatile("swi 0");
    83c0:	ef000000 	svc	0x00000000
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:9
    asm volatile("mov %0, r0" : "=r" (pid));
    83c4:	e1a03000 	mov	r3, r0
    83c8:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:11

    return pid;
    83cc:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:12
}
    83d0:	e1a00003 	mov	r0, r3
    83d4:	e28bd000 	add	sp, fp, #0
    83d8:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    83dc:	e12fff1e 	bx	lr

000083e0 <_Z9terminatei>:
_Z9terminatei():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:15

void terminate(int exitcode)
{
    83e0:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    83e4:	e28db000 	add	fp, sp, #0
    83e8:	e24dd00c 	sub	sp, sp, #12
    83ec:	e50b0008 	str	r0, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:16
    asm volatile("mov r0, %0" : : "r" (exitcode));
    83f0:	e51b3008 	ldr	r3, [fp, #-8]
    83f4:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:17
    asm volatile("swi 1");
    83f8:	ef000001 	svc	0x00000001
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:18
}
    83fc:	e320f000 	nop	{0}
    8400:	e28bd000 	add	sp, fp, #0
    8404:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8408:	e12fff1e 	bx	lr

0000840c <_Z11sched_yieldv>:
_Z11sched_yieldv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:21

void sched_yield()
{
    840c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8410:	e28db000 	add	fp, sp, #0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:22
    asm volatile("swi 2");
    8414:	ef000002 	svc	0x00000002
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:23
}
    8418:	e320f000 	nop	{0}
    841c:	e28bd000 	add	sp, fp, #0
    8420:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8424:	e12fff1e 	bx	lr

00008428 <_Z4openPKc15NFile_Open_Mode>:
_Z4openPKc15NFile_Open_Mode():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:26

uint32_t open(const char* filename, NFile_Open_Mode mode)
{
    8428:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    842c:	e28db000 	add	fp, sp, #0
    8430:	e24dd014 	sub	sp, sp, #20
    8434:	e50b0010 	str	r0, [fp, #-16]
    8438:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:29
    uint32_t file;

    asm volatile("mov r0, %0" : : "r" (filename));
    843c:	e51b3010 	ldr	r3, [fp, #-16]
    8440:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:30
    asm volatile("mov r1, %0" : : "r" (mode));
    8444:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8448:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:31
    asm volatile("swi 64");
    844c:	ef000040 	svc	0x00000040
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:32
    asm volatile("mov %0, r0" : "=r" (file));
    8450:	e1a03000 	mov	r3, r0
    8454:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:34

    return file;
    8458:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:35
}
    845c:	e1a00003 	mov	r0, r3
    8460:	e28bd000 	add	sp, fp, #0
    8464:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8468:	e12fff1e 	bx	lr

0000846c <_Z4readjPcj>:
_Z4readjPcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:38

uint32_t read(uint32_t file, char* const buffer, uint32_t size)
{
    846c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8470:	e28db000 	add	fp, sp, #0
    8474:	e24dd01c 	sub	sp, sp, #28
    8478:	e50b0010 	str	r0, [fp, #-16]
    847c:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8480:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:41
    uint32_t rdnum;

    asm volatile("mov r0, %0" : : "r" (file));
    8484:	e51b3010 	ldr	r3, [fp, #-16]
    8488:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:42
    asm volatile("mov r1, %0" : : "r" (buffer));
    848c:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8490:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:43
    asm volatile("mov r2, %0" : : "r" (size));
    8494:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8498:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:44
    asm volatile("swi 65");
    849c:	ef000041 	svc	0x00000041
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:45
    asm volatile("mov %0, r0" : "=r" (rdnum));
    84a0:	e1a03000 	mov	r3, r0
    84a4:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:47

    return rdnum;
    84a8:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:48
}
    84ac:	e1a00003 	mov	r0, r3
    84b0:	e28bd000 	add	sp, fp, #0
    84b4:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    84b8:	e12fff1e 	bx	lr

000084bc <_Z5writejPKcj>:
_Z5writejPKcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:51

uint32_t write(uint32_t file, const char* buffer, uint32_t size)
{
    84bc:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    84c0:	e28db000 	add	fp, sp, #0
    84c4:	e24dd01c 	sub	sp, sp, #28
    84c8:	e50b0010 	str	r0, [fp, #-16]
    84cc:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    84d0:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:54
    uint32_t wrnum;

    asm volatile("mov r0, %0" : : "r" (file));
    84d4:	e51b3010 	ldr	r3, [fp, #-16]
    84d8:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:55
    asm volatile("mov r1, %0" : : "r" (buffer));
    84dc:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    84e0:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:56
    asm volatile("mov r2, %0" : : "r" (size));
    84e4:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    84e8:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:57
    asm volatile("swi 66");
    84ec:	ef000042 	svc	0x00000042
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:58
    asm volatile("mov %0, r0" : "=r" (wrnum));
    84f0:	e1a03000 	mov	r3, r0
    84f4:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:60

    return wrnum;
    84f8:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:61
}
    84fc:	e1a00003 	mov	r0, r3
    8500:	e28bd000 	add	sp, fp, #0
    8504:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8508:	e12fff1e 	bx	lr

0000850c <_Z5closej>:
_Z5closej():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:64

void close(uint32_t file)
{
    850c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8510:	e28db000 	add	fp, sp, #0
    8514:	e24dd00c 	sub	sp, sp, #12
    8518:	e50b0008 	str	r0, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:65
    asm volatile("mov r0, %0" : : "r" (file));
    851c:	e51b3008 	ldr	r3, [fp, #-8]
    8520:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:66
    asm volatile("swi 67");
    8524:	ef000043 	svc	0x00000043
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:67
}
    8528:	e320f000 	nop	{0}
    852c:	e28bd000 	add	sp, fp, #0
    8530:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8534:	e12fff1e 	bx	lr

00008538 <_Z5ioctlj16NIOCtl_OperationPv>:
_Z5ioctlj16NIOCtl_OperationPv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:70

uint32_t ioctl(uint32_t file, NIOCtl_Operation operation, void* param)
{
    8538:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    853c:	e28db000 	add	fp, sp, #0
    8540:	e24dd01c 	sub	sp, sp, #28
    8544:	e50b0010 	str	r0, [fp, #-16]
    8548:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    854c:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:73
    uint32_t retcode;

    asm volatile("mov r0, %0" : : "r" (file));
    8550:	e51b3010 	ldr	r3, [fp, #-16]
    8554:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:74
    asm volatile("mov r1, %0" : : "r" (operation));
    8558:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    855c:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:75
    asm volatile("mov r2, %0" : : "r" (param));
    8560:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8564:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:76
    asm volatile("swi 68");
    8568:	ef000044 	svc	0x00000044
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:77
    asm volatile("mov %0, r0" : "=r" (retcode));
    856c:	e1a03000 	mov	r3, r0
    8570:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:79

    return retcode;
    8574:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:80
}
    8578:	e1a00003 	mov	r0, r3
    857c:	e28bd000 	add	sp, fp, #0
    8580:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8584:	e12fff1e 	bx	lr

00008588 <_Z6notifyjj>:
_Z6notifyjj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:83

uint32_t notify(uint32_t file, uint32_t count)
{
    8588:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    858c:	e28db000 	add	fp, sp, #0
    8590:	e24dd014 	sub	sp, sp, #20
    8594:	e50b0010 	str	r0, [fp, #-16]
    8598:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:86
    uint32_t retcnt;

    asm volatile("mov r0, %0" : : "r" (file));
    859c:	e51b3010 	ldr	r3, [fp, #-16]
    85a0:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:87
    asm volatile("mov r1, %0" : : "r" (count));
    85a4:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    85a8:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:88
    asm volatile("swi 69");
    85ac:	ef000045 	svc	0x00000045
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:89
    asm volatile("mov %0, r0" : "=r" (retcnt));
    85b0:	e1a03000 	mov	r3, r0
    85b4:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:91

    return retcnt;
    85b8:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:92
}
    85bc:	e1a00003 	mov	r0, r3
    85c0:	e28bd000 	add	sp, fp, #0
    85c4:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    85c8:	e12fff1e 	bx	lr

000085cc <_Z4waitjjj>:
_Z4waitjjj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:95

NSWI_Result_Code wait(uint32_t file, uint32_t count, uint32_t notified_deadline)
{
    85cc:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    85d0:	e28db000 	add	fp, sp, #0
    85d4:	e24dd01c 	sub	sp, sp, #28
    85d8:	e50b0010 	str	r0, [fp, #-16]
    85dc:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    85e0:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:98
    NSWI_Result_Code retcode;

    asm volatile("mov r0, %0" : : "r" (file));
    85e4:	e51b3010 	ldr	r3, [fp, #-16]
    85e8:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:99
    asm volatile("mov r1, %0" : : "r" (count));
    85ec:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    85f0:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:100
    asm volatile("mov r2, %0" : : "r" (notified_deadline));
    85f4:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    85f8:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:101
    asm volatile("swi 70");
    85fc:	ef000046 	svc	0x00000046
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:102
    asm volatile("mov %0, r0" : "=r" (retcode));
    8600:	e1a03000 	mov	r3, r0
    8604:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:104

    return retcode;
    8608:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:105
}
    860c:	e1a00003 	mov	r0, r3
    8610:	e28bd000 	add	sp, fp, #0
    8614:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8618:	e12fff1e 	bx	lr

0000861c <_Z5sleepjj>:
_Z5sleepjj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:108

bool sleep(uint32_t ticks, uint32_t notified_deadline)
{
    861c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8620:	e28db000 	add	fp, sp, #0
    8624:	e24dd014 	sub	sp, sp, #20
    8628:	e50b0010 	str	r0, [fp, #-16]
    862c:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:111
    uint32_t retcode;

    asm volatile("mov r0, %0" : : "r" (ticks));
    8630:	e51b3010 	ldr	r3, [fp, #-16]
    8634:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:112
    asm volatile("mov r1, %0" : : "r" (notified_deadline));
    8638:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    863c:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:113
    asm volatile("swi 3");
    8640:	ef000003 	svc	0x00000003
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:114
    asm volatile("mov %0, r0" : "=r" (retcode));
    8644:	e1a03000 	mov	r3, r0
    8648:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:116

    return retcode;
    864c:	e51b3008 	ldr	r3, [fp, #-8]
    8650:	e3530000 	cmp	r3, #0
    8654:	13a03001 	movne	r3, #1
    8658:	03a03000 	moveq	r3, #0
    865c:	e6ef3073 	uxtb	r3, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:117
}
    8660:	e1a00003 	mov	r0, r3
    8664:	e28bd000 	add	sp, fp, #0
    8668:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    866c:	e12fff1e 	bx	lr

00008670 <_Z24get_active_process_countv>:
_Z24get_active_process_countv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:120

uint32_t get_active_process_count()
{
    8670:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8674:	e28db000 	add	fp, sp, #0
    8678:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:121
    const NGet_Sched_Info_Type req = NGet_Sched_Info_Type::Active_Process_Count;
    867c:	e3a03000 	mov	r3, #0
    8680:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:124
    uint32_t retval;

    asm volatile("mov r0, %0" : : "r" (req));
    8684:	e3a03000 	mov	r3, #0
    8688:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:125
    asm volatile("mov r1, %0" : : "r" (&retval));
    868c:	e24b300c 	sub	r3, fp, #12
    8690:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:126
    asm volatile("swi 4");
    8694:	ef000004 	svc	0x00000004
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:128

    return retval;
    8698:	e51b300c 	ldr	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:129
}
    869c:	e1a00003 	mov	r0, r3
    86a0:	e28bd000 	add	sp, fp, #0
    86a4:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    86a8:	e12fff1e 	bx	lr

000086ac <_Z14get_tick_countv>:
_Z14get_tick_countv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:132

uint32_t get_tick_count()
{
    86ac:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    86b0:	e28db000 	add	fp, sp, #0
    86b4:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:133
    const NGet_Sched_Info_Type req = NGet_Sched_Info_Type::Tick_Count;
    86b8:	e3a03001 	mov	r3, #1
    86bc:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:136
    uint32_t retval;

    asm volatile("mov r0, %0" : : "r" (req));
    86c0:	e3a03001 	mov	r3, #1
    86c4:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:137
    asm volatile("mov r1, %0" : : "r" (&retval));
    86c8:	e24b300c 	sub	r3, fp, #12
    86cc:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:138
    asm volatile("swi 4");
    86d0:	ef000004 	svc	0x00000004
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:140

    return retval;
    86d4:	e51b300c 	ldr	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:141
}
    86d8:	e1a00003 	mov	r0, r3
    86dc:	e28bd000 	add	sp, fp, #0
    86e0:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    86e4:	e12fff1e 	bx	lr

000086e8 <_Z17set_task_deadlinej>:
_Z17set_task_deadlinej():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:144

void set_task_deadline(uint32_t tick_count_required)
{
    86e8:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    86ec:	e28db000 	add	fp, sp, #0
    86f0:	e24dd014 	sub	sp, sp, #20
    86f4:	e50b0010 	str	r0, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:145
    const NDeadline_Subservice req = NDeadline_Subservice::Set_Relative;
    86f8:	e3a03000 	mov	r3, #0
    86fc:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:147

    asm volatile("mov r0, %0" : : "r" (req));
    8700:	e3a03000 	mov	r3, #0
    8704:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:148
    asm volatile("mov r1, %0" : : "r" (&tick_count_required));
    8708:	e24b3010 	sub	r3, fp, #16
    870c:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:149
    asm volatile("swi 5");
    8710:	ef000005 	svc	0x00000005
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:150
}
    8714:	e320f000 	nop	{0}
    8718:	e28bd000 	add	sp, fp, #0
    871c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8720:	e12fff1e 	bx	lr

00008724 <_Z26get_task_ticks_to_deadlinev>:
_Z26get_task_ticks_to_deadlinev():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:153

uint32_t get_task_ticks_to_deadline()
{
    8724:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8728:	e28db000 	add	fp, sp, #0
    872c:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:154
    const NDeadline_Subservice req = NDeadline_Subservice::Get_Remaining;
    8730:	e3a03001 	mov	r3, #1
    8734:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:157
    uint32_t ticks;

    asm volatile("mov r0, %0" : : "r" (req));
    8738:	e3a03001 	mov	r3, #1
    873c:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:158
    asm volatile("mov r1, %0" : : "r" (&ticks));
    8740:	e24b300c 	sub	r3, fp, #12
    8744:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:159
    asm volatile("swi 5");
    8748:	ef000005 	svc	0x00000005
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:161

    return ticks;
    874c:	e51b300c 	ldr	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:162
}
    8750:	e1a00003 	mov	r0, r3
    8754:	e28bd000 	add	sp, fp, #0
    8758:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    875c:	e12fff1e 	bx	lr

00008760 <_Z4pipePKcj>:
_Z4pipePKcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:167

const char Pipe_File_Prefix[] = "SYS:pipe/";

uint32_t pipe(const char* name, uint32_t buf_size)
{
    8760:	e92d4800 	push	{fp, lr}
    8764:	e28db004 	add	fp, sp, #4
    8768:	e24dd050 	sub	sp, sp, #80	; 0x50
    876c:	e50b0050 	str	r0, [fp, #-80]	; 0xffffffb0
    8770:	e50b1054 	str	r1, [fp, #-84]	; 0xffffffac
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:169
    char fname[64];
    strncpy(fname, Pipe_File_Prefix, sizeof(Pipe_File_Prefix));
    8774:	e24b3048 	sub	r3, fp, #72	; 0x48
    8778:	e3a0200a 	mov	r2, #10
    877c:	e59f1088 	ldr	r1, [pc, #136]	; 880c <_Z4pipePKcj+0xac>
    8780:	e1a00003 	mov	r0, r3
    8784:	eb0000a5 	bl	8a20 <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:170
    strncpy(fname + sizeof(Pipe_File_Prefix), name, sizeof(fname) - sizeof(Pipe_File_Prefix) - 1);
    8788:	e24b3048 	sub	r3, fp, #72	; 0x48
    878c:	e283300a 	add	r3, r3, #10
    8790:	e3a02035 	mov	r2, #53	; 0x35
    8794:	e51b1050 	ldr	r1, [fp, #-80]	; 0xffffffb0
    8798:	e1a00003 	mov	r0, r3
    879c:	eb00009f 	bl	8a20 <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:172

    int ncur = sizeof(Pipe_File_Prefix) + strlen(name);
    87a0:	e51b0050 	ldr	r0, [fp, #-80]	; 0xffffffb0
    87a4:	eb0000f8 	bl	8b8c <_Z6strlenPKc>
    87a8:	e1a03000 	mov	r3, r0
    87ac:	e283300a 	add	r3, r3, #10
    87b0:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:174

    fname[ncur++] = '#';
    87b4:	e51b3008 	ldr	r3, [fp, #-8]
    87b8:	e2832001 	add	r2, r3, #1
    87bc:	e50b2008 	str	r2, [fp, #-8]
    87c0:	e2433004 	sub	r3, r3, #4
    87c4:	e083300b 	add	r3, r3, fp
    87c8:	e3a02023 	mov	r2, #35	; 0x23
    87cc:	e5432044 	strb	r2, [r3, #-68]	; 0xffffffbc
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:176

    itoa(buf_size, &fname[ncur], 10);
    87d0:	e24b2048 	sub	r2, fp, #72	; 0x48
    87d4:	e51b3008 	ldr	r3, [fp, #-8]
    87d8:	e0823003 	add	r3, r2, r3
    87dc:	e3a0200a 	mov	r2, #10
    87e0:	e1a01003 	mov	r1, r3
    87e4:	e51b0054 	ldr	r0, [fp, #-84]	; 0xffffffac
    87e8:	eb000008 	bl	8810 <_Z4itoajPcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:178

    return open(fname, NFile_Open_Mode::Read_Write);
    87ec:	e24b3048 	sub	r3, fp, #72	; 0x48
    87f0:	e3a01002 	mov	r1, #2
    87f4:	e1a00003 	mov	r0, r3
    87f8:	ebffff0a 	bl	8428 <_Z4openPKc15NFile_Open_Mode>
    87fc:	e1a03000 	mov	r3, r0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:179
}
    8800:	e1a00003 	mov	r0, r3
    8804:	e24bd004 	sub	sp, fp, #4
    8808:	e8bd8800 	pop	{fp, pc}
    880c:	00008fa4 	andeq	r8, r0, r4, lsr #31

00008810 <_Z4itoajPcj>:
_Z4itoajPcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:9
{
    const char CharConvArr[] = "0123456789ABCDEF";
}

void itoa(unsigned int input, char* output, unsigned int base)
{
    8810:	e92d4800 	push	{fp, lr}
    8814:	e28db004 	add	fp, sp, #4
    8818:	e24dd020 	sub	sp, sp, #32
    881c:	e50b0018 	str	r0, [fp, #-24]	; 0xffffffe8
    8820:	e50b101c 	str	r1, [fp, #-28]	; 0xffffffe4
    8824:	e50b2020 	str	r2, [fp, #-32]	; 0xffffffe0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:10
	int i = 0;
    8828:	e3a03000 	mov	r3, #0
    882c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:12

	while (input > 0)
    8830:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8834:	e3530000 	cmp	r3, #0
    8838:	0a000014 	beq	8890 <_Z4itoajPcj+0x80>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:14
	{
		output[i] = CharConvArr[input % base];
    883c:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8840:	e51b1020 	ldr	r1, [fp, #-32]	; 0xffffffe0
    8844:	e1a00003 	mov	r0, r3
    8848:	eb000199 	bl	8eb4 <__aeabi_uidivmod>
    884c:	e1a03001 	mov	r3, r1
    8850:	e1a01003 	mov	r1, r3
    8854:	e51b3008 	ldr	r3, [fp, #-8]
    8858:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    885c:	e0823003 	add	r3, r2, r3
    8860:	e59f2118 	ldr	r2, [pc, #280]	; 8980 <_Z4itoajPcj+0x170>
    8864:	e7d22001 	ldrb	r2, [r2, r1]
    8868:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:15
		input /= base;
    886c:	e51b1020 	ldr	r1, [fp, #-32]	; 0xffffffe0
    8870:	e51b0018 	ldr	r0, [fp, #-24]	; 0xffffffe8
    8874:	eb000113 	bl	8cc8 <__udivsi3>
    8878:	e1a03000 	mov	r3, r0
    887c:	e50b3018 	str	r3, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:16
		i++;
    8880:	e51b3008 	ldr	r3, [fp, #-8]
    8884:	e2833001 	add	r3, r3, #1
    8888:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:12
	while (input > 0)
    888c:	eaffffe7 	b	8830 <_Z4itoajPcj+0x20>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:19
	}

    if (i == 0)
    8890:	e51b3008 	ldr	r3, [fp, #-8]
    8894:	e3530000 	cmp	r3, #0
    8898:	1a000007 	bne	88bc <_Z4itoajPcj+0xac>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:21
    {
        output[i] = CharConvArr[0];
    889c:	e51b3008 	ldr	r3, [fp, #-8]
    88a0:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    88a4:	e0823003 	add	r3, r2, r3
    88a8:	e3a02030 	mov	r2, #48	; 0x30
    88ac:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:22
        i++;
    88b0:	e51b3008 	ldr	r3, [fp, #-8]
    88b4:	e2833001 	add	r3, r3, #1
    88b8:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:25
    }

	output[i] = '\0';
    88bc:	e51b3008 	ldr	r3, [fp, #-8]
    88c0:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    88c4:	e0823003 	add	r3, r2, r3
    88c8:	e3a02000 	mov	r2, #0
    88cc:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:26
	i--;
    88d0:	e51b3008 	ldr	r3, [fp, #-8]
    88d4:	e2433001 	sub	r3, r3, #1
    88d8:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:28

	for (int j = 0; j <= i/2; j++)
    88dc:	e3a03000 	mov	r3, #0
    88e0:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:28 (discriminator 3)
    88e4:	e51b3008 	ldr	r3, [fp, #-8]
    88e8:	e1a02fa3 	lsr	r2, r3, #31
    88ec:	e0823003 	add	r3, r2, r3
    88f0:	e1a030c3 	asr	r3, r3, #1
    88f4:	e1a02003 	mov	r2, r3
    88f8:	e51b300c 	ldr	r3, [fp, #-12]
    88fc:	e1530002 	cmp	r3, r2
    8900:	ca00001b 	bgt	8974 <_Z4itoajPcj+0x164>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:30 (discriminator 2)
	{
		char c = output[i - j];
    8904:	e51b2008 	ldr	r2, [fp, #-8]
    8908:	e51b300c 	ldr	r3, [fp, #-12]
    890c:	e0423003 	sub	r3, r2, r3
    8910:	e1a02003 	mov	r2, r3
    8914:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    8918:	e0833002 	add	r3, r3, r2
    891c:	e5d33000 	ldrb	r3, [r3]
    8920:	e54b300d 	strb	r3, [fp, #-13]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:31 (discriminator 2)
		output[i - j] = output[j];
    8924:	e51b300c 	ldr	r3, [fp, #-12]
    8928:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    892c:	e0822003 	add	r2, r2, r3
    8930:	e51b1008 	ldr	r1, [fp, #-8]
    8934:	e51b300c 	ldr	r3, [fp, #-12]
    8938:	e0413003 	sub	r3, r1, r3
    893c:	e1a01003 	mov	r1, r3
    8940:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    8944:	e0833001 	add	r3, r3, r1
    8948:	e5d22000 	ldrb	r2, [r2]
    894c:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:32 (discriminator 2)
		output[j] = c;
    8950:	e51b300c 	ldr	r3, [fp, #-12]
    8954:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    8958:	e0823003 	add	r3, r2, r3
    895c:	e55b200d 	ldrb	r2, [fp, #-13]
    8960:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:28 (discriminator 2)
	for (int j = 0; j <= i/2; j++)
    8964:	e51b300c 	ldr	r3, [fp, #-12]
    8968:	e2833001 	add	r3, r3, #1
    896c:	e50b300c 	str	r3, [fp, #-12]
    8970:	eaffffdb 	b	88e4 <_Z4itoajPcj+0xd4>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:34
	}
}
    8974:	e320f000 	nop	{0}
    8978:	e24bd004 	sub	sp, fp, #4
    897c:	e8bd8800 	pop	{fp, pc}
    8980:	00008fb0 			; <UNDEFINED> instruction: 0x00008fb0

00008984 <_Z4atoiPKc>:
_Z4atoiPKc():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:37

int atoi(const char* input)
{
    8984:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8988:	e28db000 	add	fp, sp, #0
    898c:	e24dd014 	sub	sp, sp, #20
    8990:	e50b0010 	str	r0, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:38
	int output = 0;
    8994:	e3a03000 	mov	r3, #0
    8998:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:40

	while (*input != '\0')
    899c:	e51b3010 	ldr	r3, [fp, #-16]
    89a0:	e5d33000 	ldrb	r3, [r3]
    89a4:	e3530000 	cmp	r3, #0
    89a8:	0a000017 	beq	8a0c <_Z4atoiPKc+0x88>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:42
	{
		output *= 10;
    89ac:	e51b2008 	ldr	r2, [fp, #-8]
    89b0:	e1a03002 	mov	r3, r2
    89b4:	e1a03103 	lsl	r3, r3, #2
    89b8:	e0833002 	add	r3, r3, r2
    89bc:	e1a03083 	lsl	r3, r3, #1
    89c0:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:43
		if (*input > '9' || *input < '0')
    89c4:	e51b3010 	ldr	r3, [fp, #-16]
    89c8:	e5d33000 	ldrb	r3, [r3]
    89cc:	e3530039 	cmp	r3, #57	; 0x39
    89d0:	8a00000d 	bhi	8a0c <_Z4atoiPKc+0x88>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:43 (discriminator 1)
    89d4:	e51b3010 	ldr	r3, [fp, #-16]
    89d8:	e5d33000 	ldrb	r3, [r3]
    89dc:	e353002f 	cmp	r3, #47	; 0x2f
    89e0:	9a000009 	bls	8a0c <_Z4atoiPKc+0x88>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:46
			break;

		output += *input - '0';
    89e4:	e51b3010 	ldr	r3, [fp, #-16]
    89e8:	e5d33000 	ldrb	r3, [r3]
    89ec:	e2433030 	sub	r3, r3, #48	; 0x30
    89f0:	e51b2008 	ldr	r2, [fp, #-8]
    89f4:	e0823003 	add	r3, r2, r3
    89f8:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:48

		input++;
    89fc:	e51b3010 	ldr	r3, [fp, #-16]
    8a00:	e2833001 	add	r3, r3, #1
    8a04:	e50b3010 	str	r3, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:40
	while (*input != '\0')
    8a08:	eaffffe3 	b	899c <_Z4atoiPKc+0x18>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:51
	}

	return output;
    8a0c:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:52
}
    8a10:	e1a00003 	mov	r0, r3
    8a14:	e28bd000 	add	sp, fp, #0
    8a18:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8a1c:	e12fff1e 	bx	lr

00008a20 <_Z7strncpyPcPKci>:
_Z7strncpyPcPKci():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:55

char* strncpy(char* dest, const char *src, int num)
{
    8a20:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8a24:	e28db000 	add	fp, sp, #0
    8a28:	e24dd01c 	sub	sp, sp, #28
    8a2c:	e50b0010 	str	r0, [fp, #-16]
    8a30:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8a34:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:58
	int i;

	for (i = 0; i < num && src[i] != '\0'; i++)
    8a38:	e3a03000 	mov	r3, #0
    8a3c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:58 (discriminator 4)
    8a40:	e51b2008 	ldr	r2, [fp, #-8]
    8a44:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8a48:	e1520003 	cmp	r2, r3
    8a4c:	aa000011 	bge	8a98 <_Z7strncpyPcPKci+0x78>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:58 (discriminator 2)
    8a50:	e51b3008 	ldr	r3, [fp, #-8]
    8a54:	e51b2014 	ldr	r2, [fp, #-20]	; 0xffffffec
    8a58:	e0823003 	add	r3, r2, r3
    8a5c:	e5d33000 	ldrb	r3, [r3]
    8a60:	e3530000 	cmp	r3, #0
    8a64:	0a00000b 	beq	8a98 <_Z7strncpyPcPKci+0x78>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:59 (discriminator 3)
		dest[i] = src[i];
    8a68:	e51b3008 	ldr	r3, [fp, #-8]
    8a6c:	e51b2014 	ldr	r2, [fp, #-20]	; 0xffffffec
    8a70:	e0822003 	add	r2, r2, r3
    8a74:	e51b3008 	ldr	r3, [fp, #-8]
    8a78:	e51b1010 	ldr	r1, [fp, #-16]
    8a7c:	e0813003 	add	r3, r1, r3
    8a80:	e5d22000 	ldrb	r2, [r2]
    8a84:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:58 (discriminator 3)
	for (i = 0; i < num && src[i] != '\0'; i++)
    8a88:	e51b3008 	ldr	r3, [fp, #-8]
    8a8c:	e2833001 	add	r3, r3, #1
    8a90:	e50b3008 	str	r3, [fp, #-8]
    8a94:	eaffffe9 	b	8a40 <_Z7strncpyPcPKci+0x20>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:60 (discriminator 2)
	for (; i < num; i++)
    8a98:	e51b2008 	ldr	r2, [fp, #-8]
    8a9c:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8aa0:	e1520003 	cmp	r2, r3
    8aa4:	aa000008 	bge	8acc <_Z7strncpyPcPKci+0xac>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:61 (discriminator 1)
		dest[i] = '\0';
    8aa8:	e51b3008 	ldr	r3, [fp, #-8]
    8aac:	e51b2010 	ldr	r2, [fp, #-16]
    8ab0:	e0823003 	add	r3, r2, r3
    8ab4:	e3a02000 	mov	r2, #0
    8ab8:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:60 (discriminator 1)
	for (; i < num; i++)
    8abc:	e51b3008 	ldr	r3, [fp, #-8]
    8ac0:	e2833001 	add	r3, r3, #1
    8ac4:	e50b3008 	str	r3, [fp, #-8]
    8ac8:	eafffff2 	b	8a98 <_Z7strncpyPcPKci+0x78>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:63

   return dest;
    8acc:	e51b3010 	ldr	r3, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:64
}
    8ad0:	e1a00003 	mov	r0, r3
    8ad4:	e28bd000 	add	sp, fp, #0
    8ad8:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8adc:	e12fff1e 	bx	lr

00008ae0 <_Z7strncmpPKcS0_i>:
_Z7strncmpPKcS0_i():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:67

int strncmp(const char *s1, const char *s2, int num)
{
    8ae0:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8ae4:	e28db000 	add	fp, sp, #0
    8ae8:	e24dd01c 	sub	sp, sp, #28
    8aec:	e50b0010 	str	r0, [fp, #-16]
    8af0:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8af4:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:69
	unsigned char u1, u2;
  	while (num-- > 0)
    8af8:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8afc:	e2432001 	sub	r2, r3, #1
    8b00:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
    8b04:	e3530000 	cmp	r3, #0
    8b08:	c3a03001 	movgt	r3, #1
    8b0c:	d3a03000 	movle	r3, #0
    8b10:	e6ef3073 	uxtb	r3, r3
    8b14:	e3530000 	cmp	r3, #0
    8b18:	0a000016 	beq	8b78 <_Z7strncmpPKcS0_i+0x98>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:71
    {
      	u1 = (unsigned char) *s1++;
    8b1c:	e51b3010 	ldr	r3, [fp, #-16]
    8b20:	e2832001 	add	r2, r3, #1
    8b24:	e50b2010 	str	r2, [fp, #-16]
    8b28:	e5d33000 	ldrb	r3, [r3]
    8b2c:	e54b3005 	strb	r3, [fp, #-5]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:72
     	u2 = (unsigned char) *s2++;
    8b30:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8b34:	e2832001 	add	r2, r3, #1
    8b38:	e50b2014 	str	r2, [fp, #-20]	; 0xffffffec
    8b3c:	e5d33000 	ldrb	r3, [r3]
    8b40:	e54b3006 	strb	r3, [fp, #-6]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:73
      	if (u1 != u2)
    8b44:	e55b2005 	ldrb	r2, [fp, #-5]
    8b48:	e55b3006 	ldrb	r3, [fp, #-6]
    8b4c:	e1520003 	cmp	r2, r3
    8b50:	0a000003 	beq	8b64 <_Z7strncmpPKcS0_i+0x84>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:74
        	return u1 - u2;
    8b54:	e55b2005 	ldrb	r2, [fp, #-5]
    8b58:	e55b3006 	ldrb	r3, [fp, #-6]
    8b5c:	e0423003 	sub	r3, r2, r3
    8b60:	ea000005 	b	8b7c <_Z7strncmpPKcS0_i+0x9c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:75
      	if (u1 == '\0')
    8b64:	e55b3005 	ldrb	r3, [fp, #-5]
    8b68:	e3530000 	cmp	r3, #0
    8b6c:	1affffe1 	bne	8af8 <_Z7strncmpPKcS0_i+0x18>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:76
        	return 0;
    8b70:	e3a03000 	mov	r3, #0
    8b74:	ea000000 	b	8b7c <_Z7strncmpPKcS0_i+0x9c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:79
    }

  	return 0;
    8b78:	e3a03000 	mov	r3, #0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:80
}
    8b7c:	e1a00003 	mov	r0, r3
    8b80:	e28bd000 	add	sp, fp, #0
    8b84:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8b88:	e12fff1e 	bx	lr

00008b8c <_Z6strlenPKc>:
_Z6strlenPKc():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:83

int strlen(const char* s)
{
    8b8c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8b90:	e28db000 	add	fp, sp, #0
    8b94:	e24dd014 	sub	sp, sp, #20
    8b98:	e50b0010 	str	r0, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:84
	int i = 0;
    8b9c:	e3a03000 	mov	r3, #0
    8ba0:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:86

	while (s[i] != '\0')
    8ba4:	e51b3008 	ldr	r3, [fp, #-8]
    8ba8:	e51b2010 	ldr	r2, [fp, #-16]
    8bac:	e0823003 	add	r3, r2, r3
    8bb0:	e5d33000 	ldrb	r3, [r3]
    8bb4:	e3530000 	cmp	r3, #0
    8bb8:	0a000003 	beq	8bcc <_Z6strlenPKc+0x40>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:87
		i++;
    8bbc:	e51b3008 	ldr	r3, [fp, #-8]
    8bc0:	e2833001 	add	r3, r3, #1
    8bc4:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:86
	while (s[i] != '\0')
    8bc8:	eafffff5 	b	8ba4 <_Z6strlenPKc+0x18>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:89

	return i;
    8bcc:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:90
}
    8bd0:	e1a00003 	mov	r0, r3
    8bd4:	e28bd000 	add	sp, fp, #0
    8bd8:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8bdc:	e12fff1e 	bx	lr

00008be0 <_Z5bzeroPvi>:
_Z5bzeroPvi():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:93

void bzero(void* memory, int length)
{
    8be0:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8be4:	e28db000 	add	fp, sp, #0
    8be8:	e24dd014 	sub	sp, sp, #20
    8bec:	e50b0010 	str	r0, [fp, #-16]
    8bf0:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:94
	char* mem = reinterpret_cast<char*>(memory);
    8bf4:	e51b3010 	ldr	r3, [fp, #-16]
    8bf8:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:96

	for (int i = 0; i < length; i++)
    8bfc:	e3a03000 	mov	r3, #0
    8c00:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:96 (discriminator 3)
    8c04:	e51b2008 	ldr	r2, [fp, #-8]
    8c08:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8c0c:	e1520003 	cmp	r2, r3
    8c10:	aa000008 	bge	8c38 <_Z5bzeroPvi+0x58>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:97 (discriminator 2)
		mem[i] = 0;
    8c14:	e51b3008 	ldr	r3, [fp, #-8]
    8c18:	e51b200c 	ldr	r2, [fp, #-12]
    8c1c:	e0823003 	add	r3, r2, r3
    8c20:	e3a02000 	mov	r2, #0
    8c24:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:96 (discriminator 2)
	for (int i = 0; i < length; i++)
    8c28:	e51b3008 	ldr	r3, [fp, #-8]
    8c2c:	e2833001 	add	r3, r3, #1
    8c30:	e50b3008 	str	r3, [fp, #-8]
    8c34:	eafffff2 	b	8c04 <_Z5bzeroPvi+0x24>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:98
}
    8c38:	e320f000 	nop	{0}
    8c3c:	e28bd000 	add	sp, fp, #0
    8c40:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8c44:	e12fff1e 	bx	lr

00008c48 <_Z6memcpyPKvPvi>:
_Z6memcpyPKvPvi():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:101

void memcpy(const void* src, void* dst, int num)
{
    8c48:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8c4c:	e28db000 	add	fp, sp, #0
    8c50:	e24dd024 	sub	sp, sp, #36	; 0x24
    8c54:	e50b0018 	str	r0, [fp, #-24]	; 0xffffffe8
    8c58:	e50b101c 	str	r1, [fp, #-28]	; 0xffffffe4
    8c5c:	e50b2020 	str	r2, [fp, #-32]	; 0xffffffe0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:102
	const char* memsrc = reinterpret_cast<const char*>(src);
    8c60:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8c64:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:103
	char* memdst = reinterpret_cast<char*>(dst);
    8c68:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    8c6c:	e50b3010 	str	r3, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:105

	for (int i = 0; i < num; i++)
    8c70:	e3a03000 	mov	r3, #0
    8c74:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:105 (discriminator 3)
    8c78:	e51b2008 	ldr	r2, [fp, #-8]
    8c7c:	e51b3020 	ldr	r3, [fp, #-32]	; 0xffffffe0
    8c80:	e1520003 	cmp	r2, r3
    8c84:	aa00000b 	bge	8cb8 <_Z6memcpyPKvPvi+0x70>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:106 (discriminator 2)
		memdst[i] = memsrc[i];
    8c88:	e51b3008 	ldr	r3, [fp, #-8]
    8c8c:	e51b200c 	ldr	r2, [fp, #-12]
    8c90:	e0822003 	add	r2, r2, r3
    8c94:	e51b3008 	ldr	r3, [fp, #-8]
    8c98:	e51b1010 	ldr	r1, [fp, #-16]
    8c9c:	e0813003 	add	r3, r1, r3
    8ca0:	e5d22000 	ldrb	r2, [r2]
    8ca4:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:105 (discriminator 2)
	for (int i = 0; i < num; i++)
    8ca8:	e51b3008 	ldr	r3, [fp, #-8]
    8cac:	e2833001 	add	r3, r3, #1
    8cb0:	e50b3008 	str	r3, [fp, #-8]
    8cb4:	eaffffef 	b	8c78 <_Z6memcpyPKvPvi+0x30>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:107
}
    8cb8:	e320f000 	nop	{0}
    8cbc:	e28bd000 	add	sp, fp, #0
    8cc0:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8cc4:	e12fff1e 	bx	lr

00008cc8 <__udivsi3>:
__udivsi3():
    8cc8:	e2512001 	subs	r2, r1, #1
    8ccc:	012fff1e 	bxeq	lr
    8cd0:	3a000074 	bcc	8ea8 <__udivsi3+0x1e0>
    8cd4:	e1500001 	cmp	r0, r1
    8cd8:	9a00006b 	bls	8e8c <__udivsi3+0x1c4>
    8cdc:	e1110002 	tst	r1, r2
    8ce0:	0a00006c 	beq	8e98 <__udivsi3+0x1d0>
    8ce4:	e16f3f10 	clz	r3, r0
    8ce8:	e16f2f11 	clz	r2, r1
    8cec:	e0423003 	sub	r3, r2, r3
    8cf0:	e273301f 	rsbs	r3, r3, #31
    8cf4:	10833083 	addne	r3, r3, r3, lsl #1
    8cf8:	e3a02000 	mov	r2, #0
    8cfc:	108ff103 	addne	pc, pc, r3, lsl #2
    8d00:	e1a00000 	nop			; (mov r0, r0)
    8d04:	e1500f81 	cmp	r0, r1, lsl #31
    8d08:	e0a22002 	adc	r2, r2, r2
    8d0c:	20400f81 	subcs	r0, r0, r1, lsl #31
    8d10:	e1500f01 	cmp	r0, r1, lsl #30
    8d14:	e0a22002 	adc	r2, r2, r2
    8d18:	20400f01 	subcs	r0, r0, r1, lsl #30
    8d1c:	e1500e81 	cmp	r0, r1, lsl #29
    8d20:	e0a22002 	adc	r2, r2, r2
    8d24:	20400e81 	subcs	r0, r0, r1, lsl #29
    8d28:	e1500e01 	cmp	r0, r1, lsl #28
    8d2c:	e0a22002 	adc	r2, r2, r2
    8d30:	20400e01 	subcs	r0, r0, r1, lsl #28
    8d34:	e1500d81 	cmp	r0, r1, lsl #27
    8d38:	e0a22002 	adc	r2, r2, r2
    8d3c:	20400d81 	subcs	r0, r0, r1, lsl #27
    8d40:	e1500d01 	cmp	r0, r1, lsl #26
    8d44:	e0a22002 	adc	r2, r2, r2
    8d48:	20400d01 	subcs	r0, r0, r1, lsl #26
    8d4c:	e1500c81 	cmp	r0, r1, lsl #25
    8d50:	e0a22002 	adc	r2, r2, r2
    8d54:	20400c81 	subcs	r0, r0, r1, lsl #25
    8d58:	e1500c01 	cmp	r0, r1, lsl #24
    8d5c:	e0a22002 	adc	r2, r2, r2
    8d60:	20400c01 	subcs	r0, r0, r1, lsl #24
    8d64:	e1500b81 	cmp	r0, r1, lsl #23
    8d68:	e0a22002 	adc	r2, r2, r2
    8d6c:	20400b81 	subcs	r0, r0, r1, lsl #23
    8d70:	e1500b01 	cmp	r0, r1, lsl #22
    8d74:	e0a22002 	adc	r2, r2, r2
    8d78:	20400b01 	subcs	r0, r0, r1, lsl #22
    8d7c:	e1500a81 	cmp	r0, r1, lsl #21
    8d80:	e0a22002 	adc	r2, r2, r2
    8d84:	20400a81 	subcs	r0, r0, r1, lsl #21
    8d88:	e1500a01 	cmp	r0, r1, lsl #20
    8d8c:	e0a22002 	adc	r2, r2, r2
    8d90:	20400a01 	subcs	r0, r0, r1, lsl #20
    8d94:	e1500981 	cmp	r0, r1, lsl #19
    8d98:	e0a22002 	adc	r2, r2, r2
    8d9c:	20400981 	subcs	r0, r0, r1, lsl #19
    8da0:	e1500901 	cmp	r0, r1, lsl #18
    8da4:	e0a22002 	adc	r2, r2, r2
    8da8:	20400901 	subcs	r0, r0, r1, lsl #18
    8dac:	e1500881 	cmp	r0, r1, lsl #17
    8db0:	e0a22002 	adc	r2, r2, r2
    8db4:	20400881 	subcs	r0, r0, r1, lsl #17
    8db8:	e1500801 	cmp	r0, r1, lsl #16
    8dbc:	e0a22002 	adc	r2, r2, r2
    8dc0:	20400801 	subcs	r0, r0, r1, lsl #16
    8dc4:	e1500781 	cmp	r0, r1, lsl #15
    8dc8:	e0a22002 	adc	r2, r2, r2
    8dcc:	20400781 	subcs	r0, r0, r1, lsl #15
    8dd0:	e1500701 	cmp	r0, r1, lsl #14
    8dd4:	e0a22002 	adc	r2, r2, r2
    8dd8:	20400701 	subcs	r0, r0, r1, lsl #14
    8ddc:	e1500681 	cmp	r0, r1, lsl #13
    8de0:	e0a22002 	adc	r2, r2, r2
    8de4:	20400681 	subcs	r0, r0, r1, lsl #13
    8de8:	e1500601 	cmp	r0, r1, lsl #12
    8dec:	e0a22002 	adc	r2, r2, r2
    8df0:	20400601 	subcs	r0, r0, r1, lsl #12
    8df4:	e1500581 	cmp	r0, r1, lsl #11
    8df8:	e0a22002 	adc	r2, r2, r2
    8dfc:	20400581 	subcs	r0, r0, r1, lsl #11
    8e00:	e1500501 	cmp	r0, r1, lsl #10
    8e04:	e0a22002 	adc	r2, r2, r2
    8e08:	20400501 	subcs	r0, r0, r1, lsl #10
    8e0c:	e1500481 	cmp	r0, r1, lsl #9
    8e10:	e0a22002 	adc	r2, r2, r2
    8e14:	20400481 	subcs	r0, r0, r1, lsl #9
    8e18:	e1500401 	cmp	r0, r1, lsl #8
    8e1c:	e0a22002 	adc	r2, r2, r2
    8e20:	20400401 	subcs	r0, r0, r1, lsl #8
    8e24:	e1500381 	cmp	r0, r1, lsl #7
    8e28:	e0a22002 	adc	r2, r2, r2
    8e2c:	20400381 	subcs	r0, r0, r1, lsl #7
    8e30:	e1500301 	cmp	r0, r1, lsl #6
    8e34:	e0a22002 	adc	r2, r2, r2
    8e38:	20400301 	subcs	r0, r0, r1, lsl #6
    8e3c:	e1500281 	cmp	r0, r1, lsl #5
    8e40:	e0a22002 	adc	r2, r2, r2
    8e44:	20400281 	subcs	r0, r0, r1, lsl #5
    8e48:	e1500201 	cmp	r0, r1, lsl #4
    8e4c:	e0a22002 	adc	r2, r2, r2
    8e50:	20400201 	subcs	r0, r0, r1, lsl #4
    8e54:	e1500181 	cmp	r0, r1, lsl #3
    8e58:	e0a22002 	adc	r2, r2, r2
    8e5c:	20400181 	subcs	r0, r0, r1, lsl #3
    8e60:	e1500101 	cmp	r0, r1, lsl #2
    8e64:	e0a22002 	adc	r2, r2, r2
    8e68:	20400101 	subcs	r0, r0, r1, lsl #2
    8e6c:	e1500081 	cmp	r0, r1, lsl #1
    8e70:	e0a22002 	adc	r2, r2, r2
    8e74:	20400081 	subcs	r0, r0, r1, lsl #1
    8e78:	e1500001 	cmp	r0, r1
    8e7c:	e0a22002 	adc	r2, r2, r2
    8e80:	20400001 	subcs	r0, r0, r1
    8e84:	e1a00002 	mov	r0, r2
    8e88:	e12fff1e 	bx	lr
    8e8c:	03a00001 	moveq	r0, #1
    8e90:	13a00000 	movne	r0, #0
    8e94:	e12fff1e 	bx	lr
    8e98:	e16f2f11 	clz	r2, r1
    8e9c:	e262201f 	rsb	r2, r2, #31
    8ea0:	e1a00230 	lsr	r0, r0, r2
    8ea4:	e12fff1e 	bx	lr
    8ea8:	e3500000 	cmp	r0, #0
    8eac:	13e00000 	mvnne	r0, #0
    8eb0:	ea000007 	b	8ed4 <__aeabi_idiv0>

00008eb4 <__aeabi_uidivmod>:
__aeabi_uidivmod():
    8eb4:	e3510000 	cmp	r1, #0
    8eb8:	0afffffa 	beq	8ea8 <__udivsi3+0x1e0>
    8ebc:	e92d4003 	push	{r0, r1, lr}
    8ec0:	ebffff80 	bl	8cc8 <__udivsi3>
    8ec4:	e8bd4006 	pop	{r1, r2, lr}
    8ec8:	e0030092 	mul	r3, r2, r0
    8ecc:	e0411003 	sub	r1, r1, r3
    8ed0:	e12fff1e 	bx	lr

00008ed4 <__aeabi_idiv0>:
__aeabi_ldiv0():
    8ed4:	e12fff1e 	bx	lr

Disassembly of section .rodata:

00008ed8 <_ZL13Lock_Unlocked>:
    8ed8:	00000000 	andeq	r0, r0, r0

00008edc <_ZL11Lock_Locked>:
    8edc:	00000001 	andeq	r0, r0, r1

00008ee0 <_ZL21MaxFSDriverNameLength>:
    8ee0:	00000010 	andeq	r0, r0, r0, lsl r0

00008ee4 <_ZL17MaxFilenameLength>:
    8ee4:	00000010 	andeq	r0, r0, r0, lsl r0

00008ee8 <_ZL13MaxPathLength>:
    8ee8:	00000080 	andeq	r0, r0, r0, lsl #1

00008eec <_ZL18NoFilesystemDriver>:
    8eec:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008ef0 <_ZL9NotifyAll>:
    8ef0:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008ef4 <_ZL24Max_Process_Opened_Files>:
    8ef4:	00000010 	andeq	r0, r0, r0, lsl r0

00008ef8 <_ZL10Indefinite>:
    8ef8:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008efc <_ZL18Deadline_Unchanged>:
    8efc:	fffffffe 			; <UNDEFINED> instruction: 0xfffffffe

00008f00 <_ZL14Invalid_Handle>:
    8f00:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008f04 <_ZN3halL18Default_Clock_RateE>:
    8f04:	0ee6b280 	cdpeq	2, 14, cr11, cr6, cr0, {4}

00008f08 <_ZN3halL15Peripheral_BaseE>:
    8f08:	20000000 	andcs	r0, r0, r0

00008f0c <_ZN3halL9GPIO_BaseE>:
    8f0c:	20200000 	eorcs	r0, r0, r0

00008f10 <_ZN3halL14GPIO_Pin_CountE>:
    8f10:	00000036 	andeq	r0, r0, r6, lsr r0

00008f14 <_ZN3halL8AUX_BaseE>:
    8f14:	20215000 	eorcs	r5, r1, r0

00008f18 <_ZN3halL25Interrupt_Controller_BaseE>:
    8f18:	2000b200 	andcs	fp, r0, r0, lsl #4

00008f1c <_ZN3halL10Timer_BaseE>:
    8f1c:	2000b400 	andcs	fp, r0, r0, lsl #8

00008f20 <_ZN3halL9TRNG_BaseE>:
    8f20:	20104000 	andscs	r4, r0, r0

00008f24 <_ZN3halL9BSC0_BaseE>:
    8f24:	20205000 	eorcs	r5, r0, r0

00008f28 <_ZN3halL9BSC1_BaseE>:
    8f28:	20804000 	addcs	r4, r0, r0

00008f2c <_ZN3halL9BSC2_BaseE>:
    8f2c:	20805000 	addcs	r5, r0, r0

00008f30 <_ZL11Invalid_Pin>:
    8f30:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008f34 <_ZL17symbol_tick_delay>:
    8f34:	00000400 	andeq	r0, r0, r0, lsl #8

00008f38 <_ZL15char_tick_delay>:
    8f38:	00001000 	andeq	r1, r0, r0
    8f3c:	00000031 	andeq	r0, r0, r1, lsr r0
    8f40:	00000030 	andeq	r0, r0, r0, lsr r0
    8f44:	3a564544 	bcc	159a45c <__bss_end+0x159147c>
    8f48:	6f697067 	svcvs	0x00697067
    8f4c:	0037342f 	eorseq	r3, r7, pc, lsr #8
    8f50:	3a564544 	bcc	159a468 <__bss_end+0x1591488>
    8f54:	74726175 	ldrbtvc	r6, [r2], #-373	; 0xfffffe8b
    8f58:	0000302f 	andeq	r3, r0, pc, lsr #32
    8f5c:	3a564544 	bcc	159a474 <__bss_end+0x1591494>
    8f60:	676e7274 			; <UNDEFINED> instruction: 0x676e7274
    8f64:	0000302f 	andeq	r3, r0, pc, lsr #32
    8f68:	646e6152 	strbtvs	r6, [lr], #-338	; 0xfffffeae
    8f6c:	6e206d6f 	cdpvs	13, 2, cr6, cr0, cr15, {3}
    8f70:	65626d75 	strbvs	r6, [r2, #-3445]!	; 0xfffff28b
    8f74:	00203a72 	eoreq	r3, r0, r2, ror sl

00008f78 <_ZL13Lock_Unlocked>:
    8f78:	00000000 	andeq	r0, r0, r0

00008f7c <_ZL11Lock_Locked>:
    8f7c:	00000001 	andeq	r0, r0, r1

00008f80 <_ZL21MaxFSDriverNameLength>:
    8f80:	00000010 	andeq	r0, r0, r0, lsl r0

00008f84 <_ZL17MaxFilenameLength>:
    8f84:	00000010 	andeq	r0, r0, r0, lsl r0

00008f88 <_ZL13MaxPathLength>:
    8f88:	00000080 	andeq	r0, r0, r0, lsl #1

00008f8c <_ZL18NoFilesystemDriver>:
    8f8c:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008f90 <_ZL9NotifyAll>:
    8f90:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008f94 <_ZL24Max_Process_Opened_Files>:
    8f94:	00000010 	andeq	r0, r0, r0, lsl r0

00008f98 <_ZL10Indefinite>:
    8f98:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008f9c <_ZL18Deadline_Unchanged>:
    8f9c:	fffffffe 			; <UNDEFINED> instruction: 0xfffffffe

00008fa0 <_ZL14Invalid_Handle>:
    8fa0:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008fa4 <_ZL16Pipe_File_Prefix>:
    8fa4:	3a535953 	bcc	14df4f8 <__bss_end+0x14d6518>
    8fa8:	65706970 	ldrbvs	r6, [r0, #-2416]!	; 0xfffff690
    8fac:	0000002f 	andeq	r0, r0, pc, lsr #32

00008fb0 <_ZN12_GLOBAL__N_1L11CharConvArrE>:
    8fb0:	33323130 	teqcc	r2, #48, 2
    8fb4:	37363534 			; <UNDEFINED> instruction: 0x37363534
    8fb8:	42413938 	submi	r3, r1, #56, 18	; 0xe0000
    8fbc:	46454443 	strbmi	r4, [r5], -r3, asr #8
	...

Disassembly of section .bss:

00008fc4 <sos_led>:
__bss_start():
    8fc4:	00000000 	andeq	r0, r0, r0

00008fc8 <uart>:
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:16
uint32_t sos_led, uart, trng;
    8fc8:	00000000 	andeq	r0, r0, r0

00008fcc <trng>:
	...

Disassembly of section .ARM.attributes:

00000000 <.ARM.attributes>:
   0:	00002e41 	andeq	r2, r0, r1, asr #28
   4:	61656100 	cmnvs	r5, r0, lsl #2
   8:	01006962 	tsteq	r0, r2, ror #18
   c:	00000024 	andeq	r0, r0, r4, lsr #32
  10:	4b5a3605 	blmi	168d82c <__bss_end+0x168484c>
  14:	08070600 	stmdaeq	r7, {r9, sl}
  18:	0a010901 	beq	42424 <__bss_end+0x39444>
  1c:	14041202 	strne	r1, [r4], #-514	; 0xfffffdfe
  20:	17011501 	strne	r1, [r1, -r1, lsl #10]
  24:	1a011803 	bne	46038 <__bss_end+0x3d058>
  28:	22011c01 	andcs	r1, r1, #256	; 0x100
  2c:	Address 0x000000000000002c is out of bounds.


Disassembly of section .comment:

00000000 <.comment>:
   0:	3a434347 	bcc	10d0d24 <__bss_end+0x10c7d44>
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
  38:	7a617661 	bvc	185d9c4 <__bss_end+0x18549e4>
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
  c0:	6a757a61 	bvs	1d5ea4c <__bss_end+0x1d55a6c>
  c4:	2f696369 	svccs	0x00696369
  c8:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
  cc:	73656d65 	cmnvc	r5, #6464	; 0x1940
  d0:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
  d4:	6b2d616b 	blvs	b58688 <__bss_end+0xb4f6a8>
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
 144:	fb010200 	blx	4094e <__bss_end+0x3796e>
 148:	01000d0e 	tsteq	r0, lr, lsl #26
 14c:	00010101 	andeq	r0, r1, r1, lsl #2
 150:	00010000 	andeq	r0, r1, r0
 154:	552f0100 	strpl	r0, [pc, #-256]!	; 5c <shift+0x5c>
 158:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 15c:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 160:	6a726574 	bvs	1c99738 <__bss_end+0x1c90758>
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
 198:	752f7365 	strvc	r7, [pc, #-869]!	; fffffe3b <__bss_end+0xffff6e5b>
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
 1d0:	0a05830b 	beq	160e04 <__bss_end+0x157e24>
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
 1fc:	4a030402 	bmi	c120c <__bss_end+0xb822c>
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
 230:	4a020402 	bmi	81240 <__bss_end+0x78260>
 234:	02000205 	andeq	r0, r0, #1342177280	; 0x50000000
 238:	052d0204 	streq	r0, [sp, #-516]!	; 0xfffffdfc
 23c:	01058509 	tsteq	r5, r9, lsl #10
 240:	000a022f 	andeq	r0, sl, pc, lsr #4
 244:	03110101 	tsteq	r1, #1073741824	; 0x40000000
 248:	00030000 	andeq	r0, r3, r0
 24c:	0000028f 	andeq	r0, r0, pc, lsl #5
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
 280:	6a757a61 	bvs	1d5ec0c <__bss_end+0x1d55c2c>
 284:	2f696369 	svccs	0x00696369
 288:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
 28c:	73656d65 	cmnvc	r5, #6464	; 0x1940
 290:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
 294:	6b2d616b 	blvs	b58848 <__bss_end+0xb4f868>
 298:	6f2d7669 	svcvs	0x002d7669
 29c:	6f732f73 	svcvs	0x00732f73
 2a0:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
 2a4:	73752f73 	cmnvc	r5, #460	; 0x1cc
 2a8:	70737265 	rsbsvc	r7, r3, r5, ror #4
 2ac:	2f656361 	svccs	0x00656361
 2b0:	6c6c6568 	cfstr64vs	mvdx6, [ip], #-416	; 0xfffffe60
 2b4:	61745f6f 	cmnvs	r4, pc, ror #30
 2b8:	2f006b73 	svccs	0x00006b73
 2bc:	72657355 	rsbvc	r7, r5, #1409286145	; 0x54000001
 2c0:	69772f73 	ldmdbvs	r7!, {r0, r1, r4, r5, r6, r8, r9, sl, fp, sp}^
 2c4:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
 2c8:	442f696a 	strtmi	r6, [pc], #-2410	; 2d0 <shift+0x2d0>
 2cc:	746b7365 	strbtvc	r7, [fp], #-869	; 0xfffffc9b
 2d0:	462f706f 	strtmi	r7, [pc], -pc, rrx
 2d4:	4e2f5641 	cfmadda32mi	mvax2, mvax5, mvfx15, mvfx1
 2d8:	7a617661 	bvc	185dc64 <__bss_end+0x1854c84>
 2dc:	63696a75 	cmnvs	r9, #479232	; 0x75000
 2e0:	534f2f69 	movtpl	r2, #65385	; 0xff69
 2e4:	6d65732f 	stclvs	3, cr7, [r5, #-188]!	; 0xffffff44
 2e8:	72747365 	rsbsvc	r7, r4, #-1811939327	; 0x94000001
 2ec:	616b6c61 	cmnvs	fp, r1, ror #24
 2f0:	76696b2d 	strbtvc	r6, [r9], -sp, lsr #22
 2f4:	2f736f2d 	svccs	0x00736f2d
 2f8:	72756f73 	rsbsvc	r6, r5, #460	; 0x1cc
 2fc:	2f736563 	svccs	0x00736563
 300:	72657375 	rsbvc	r7, r5, #-738197503	; 0xd4000001
 304:	63617073 	cmnvs	r1, #115	; 0x73
 308:	2e2e2f65 	cdpcs	15, 2, cr2, cr14, cr5, {3}
 30c:	72656b2f 	rsbvc	r6, r5, #48128	; 0xbc00
 310:	2f6c656e 	svccs	0x006c656e
 314:	6c636e69 	stclvs	14, cr6, [r3], #-420	; 0xfffffe5c
 318:	2f656475 	svccs	0x00656475
 31c:	636f7270 	cmnvs	pc, #112, 4
 320:	00737365 	rsbseq	r7, r3, r5, ror #6
 324:	6573552f 	ldrbvs	r5, [r3, #-1327]!	; 0xfffffad1
 328:	772f7372 			; <UNDEFINED> instruction: 0x772f7372
 32c:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
 330:	2f696a72 	svccs	0x00696a72
 334:	6b736544 	blvs	1cd984c <__bss_end+0x1cd086c>
 338:	2f706f74 	svccs	0x00706f74
 33c:	2f564146 	svccs	0x00564146
 340:	6176614e 	cmnvs	r6, lr, asr #2
 344:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
 348:	4f2f6963 	svcmi	0x002f6963
 34c:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
 350:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
 354:	6b6c6172 	blvs	1b18924 <__bss_end+0x1b0f944>
 358:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
 35c:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
 360:	756f732f 	strbvc	r7, [pc, #-815]!	; 39 <shift+0x39>
 364:	73656372 	cmnvc	r5, #-939524095	; 0xc8000001
 368:	6573752f 	ldrbvs	r7, [r3, #-1327]!	; 0xfffffad1
 36c:	61707372 	cmnvs	r0, r2, ror r3
 370:	2e2f6563 	cfsh64cs	mvdx6, mvdx15, #51
 374:	656b2f2e 	strbvs	r2, [fp, #-3886]!	; 0xfffff0d2
 378:	6c656e72 	stclvs	14, cr6, [r5], #-456	; 0xfffffe38
 37c:	636e692f 	cmnvs	lr, #770048	; 0xbc000
 380:	6564756c 	strbvs	r7, [r4, #-1388]!	; 0xfffffa94
 384:	0073662f 	rsbseq	r6, r3, pc, lsr #12
 388:	6573552f 	ldrbvs	r5, [r3, #-1327]!	; 0xfffffad1
 38c:	772f7372 			; <UNDEFINED> instruction: 0x772f7372
 390:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
 394:	2f696a72 	svccs	0x00696a72
 398:	6b736544 	blvs	1cd98b0 <__bss_end+0x1cd08d0>
 39c:	2f706f74 	svccs	0x00706f74
 3a0:	2f564146 	svccs	0x00564146
 3a4:	6176614e 	cmnvs	r6, lr, asr #2
 3a8:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
 3ac:	4f2f6963 	svcmi	0x002f6963
 3b0:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
 3b4:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
 3b8:	6b6c6172 	blvs	1b18988 <__bss_end+0x1b0f9a8>
 3bc:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
 3c0:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
 3c4:	756f732f 	strbvc	r7, [pc, #-815]!	; 9d <shift+0x9d>
 3c8:	73656372 	cmnvc	r5, #-939524095	; 0xc8000001
 3cc:	6573752f 	ldrbvs	r7, [r3, #-1327]!	; 0xfffffad1
 3d0:	61707372 	cmnvs	r0, r2, ror r3
 3d4:	2e2f6563 	cfsh64cs	mvdx6, mvdx15, #51
 3d8:	656b2f2e 	strbvs	r2, [fp, #-3886]!	; 0xfffff0d2
 3dc:	6c656e72 	stclvs	14, cr6, [r5], #-456	; 0xfffffe38
 3e0:	636e692f 	cmnvs	lr, #770048	; 0xbc000
 3e4:	6564756c 	strbvs	r7, [r4, #-1388]!	; 0xfffffa94
 3e8:	616f622f 	cmnvs	pc, pc, lsr #4
 3ec:	722f6472 	eorvc	r6, pc, #1912602624	; 0x72000000
 3f0:	2f306970 	svccs	0x00306970
 3f4:	006c6168 	rsbeq	r6, ip, r8, ror #2
 3f8:	6573552f 	ldrbvs	r5, [r3, #-1327]!	; 0xfffffad1
 3fc:	772f7372 			; <UNDEFINED> instruction: 0x772f7372
 400:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
 404:	2f696a72 	svccs	0x00696a72
 408:	6b736544 	blvs	1cd9920 <__bss_end+0x1cd0940>
 40c:	2f706f74 	svccs	0x00706f74
 410:	2f564146 	svccs	0x00564146
 414:	6176614e 	cmnvs	r6, lr, asr #2
 418:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
 41c:	4f2f6963 	svcmi	0x002f6963
 420:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
 424:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
 428:	6b6c6172 	blvs	1b189f8 <__bss_end+0x1b0fa18>
 42c:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
 430:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
 434:	756f732f 	strbvc	r7, [pc, #-815]!	; 10d <shift+0x10d>
 438:	73656372 	cmnvc	r5, #-939524095	; 0xc8000001
 43c:	6573752f 	ldrbvs	r7, [r3, #-1327]!	; 0xfffffad1
 440:	61707372 	cmnvs	r0, r2, ror r3
 444:	2e2f6563 	cfsh64cs	mvdx6, mvdx15, #51
 448:	656b2f2e 	strbvs	r2, [fp, #-3886]!	; 0xfffff0d2
 44c:	6c656e72 	stclvs	14, cr6, [r5], #-456	; 0xfffffe38
 450:	636e692f 	cmnvs	lr, #770048	; 0xbc000
 454:	6564756c 	strbvs	r7, [r4, #-1388]!	; 0xfffffa94
 458:	6972642f 	ldmdbvs	r2!, {r0, r1, r2, r3, r5, sl, sp, lr}^
 45c:	73726576 	cmnvc	r2, #494927872	; 0x1d800000
 460:	616d0000 	cmnvs	sp, r0
 464:	632e6e69 			; <UNDEFINED> instruction: 0x632e6e69
 468:	01007070 	tsteq	r0, r0, ror r0
 46c:	77730000 	ldrbvc	r0, [r3, -r0]!
 470:	00682e69 	rsbeq	r2, r8, r9, ror #28
 474:	73000002 	movwvc	r0, #2
 478:	6c6e6970 			; <UNDEFINED> instruction: 0x6c6e6970
 47c:	2e6b636f 	cdpcs	3, 6, cr6, cr11, cr15, {3}
 480:	00020068 	andeq	r0, r2, r8, rrx
 484:	6c696600 	stclvs	6, cr6, [r9], #-0
 488:	73797365 	cmnvc	r9, #-1811939327	; 0x94000001
 48c:	2e6d6574 	mcrcs	5, 3, r6, cr13, cr4, {3}
 490:	00030068 	andeq	r0, r3, r8, rrx
 494:	6f727000 	svcvs	0x00727000
 498:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
 49c:	0200682e 	andeq	r6, r0, #3014656	; 0x2e0000
 4a0:	72700000 	rsbsvc	r0, r0, #0
 4a4:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
 4a8:	616d5f73 	smcvs	54771	; 0xd5f3
 4ac:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
 4b0:	00682e72 	rsbeq	r2, r8, r2, ror lr
 4b4:	70000002 	andvc	r0, r0, r2
 4b8:	70697265 	rsbvc	r7, r9, r5, ror #4
 4bc:	61726568 	cmnvs	r2, r8, ror #10
 4c0:	682e736c 	stmdavs	lr!, {r2, r3, r5, r6, r8, r9, ip, sp, lr}
 4c4:	00000400 	andeq	r0, r0, r0, lsl #8
 4c8:	6f697067 	svcvs	0x00697067
 4cc:	0500682e 	streq	r6, [r0, #-2094]	; 0xfffff7d2
 4d0:	6e690000 	cdpvs	0, 6, cr0, cr9, cr0, {0}
 4d4:	66656474 			; <UNDEFINED> instruction: 0x66656474
 4d8:	0400682e 	streq	r6, [r0], #-2094	; 0xfffff7d2
 4dc:	05000000 	streq	r0, [r0, #-0]
 4e0:	02050001 	andeq	r0, r5, #1
 4e4:	0000822c 	andeq	r8, r0, ip, lsr #4
 4e8:	05011203 	streq	r1, [r1, #-515]	; 0xfffffdfd
 4ec:	67bb4b07 	ldrvs	r4, [fp, r7, lsl #22]!
 4f0:	a1bb0105 			; <UNDEFINED> instruction: 0xa1bb0105
 4f4:	05830905 	streq	r0, [r3, #2309]	; 0x905
 4f8:	0585bb01 	streq	fp, [r5, #2817]	; 0xb01
 4fc:	0a05a310 	beq	169144 <__bss_end+0x160164>
 500:	4b0d0582 	blmi	341b10 <__bss_end+0x338b30>
 504:	05820705 	streq	r0, [r2, #1797]	; 0x705
 508:	0a054b10 	beq	153150 <__bss_end+0x14a170>
 50c:	000e0582 	andeq	r0, lr, r2, lsl #11
 510:	4e010402 	cdpmi	4, 0, cr0, cr1, cr2, {0}
 514:	01040200 	mrseq	r0, R12_usr
 518:	001305bb 			; <UNDEFINED> instruction: 0x001305bb
 51c:	2f010402 	svccs	0x00010402
 520:	01040200 	mrseq	r0, R12_usr
 524:	00180567 	andseq	r0, r8, r7, ror #10
 528:	4b010402 	blmi	41538 <__bss_end+0x38558>
 52c:	02001005 	andeq	r1, r0, #5
 530:	054a0104 	strbeq	r0, [sl, #-260]	; 0xfffffefc
 534:	0402000d 	streq	r0, [r2], #-13
 538:	0e052f01 	cdpeq	15, 0, cr2, cr5, cr1, {0}
 53c:	01040200 	mrseq	r0, R12_usr
 540:	0026059f 	mlaeq	r6, pc, r5, r0	; <UNPREDICTABLE>
 544:	4a010402 	bmi	41554 <__bss_end+0x38574>
 548:	02000e05 	andeq	r0, r0, #5, 28	; 0x50
 54c:	05820104 	streq	r0, [r2, #260]	; 0x104
 550:	04020002 	streq	r0, [r2], #-2
 554:	1002a001 	andne	sl, r2, r1
 558:	c8010100 	stmdagt	r1, {r8}
 55c:	03000002 	movweq	r0, #2
 560:	0001dd00 	andeq	sp, r1, r0, lsl #26
 564:	fb010200 	blx	40d6e <__bss_end+0x37d8e>
 568:	01000d0e 	tsteq	r0, lr, lsl #26
 56c:	00010101 	andeq	r0, r1, r1, lsl #2
 570:	00010000 	andeq	r0, r1, r0
 574:	552f0100 	strpl	r0, [pc, #-256]!	; 47c <shift+0x47c>
 578:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 57c:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 580:	6a726574 	bvs	1c99b58 <__bss_end+0x1c90b78>
 584:	65442f69 	strbvs	r2, [r4, #-3945]	; 0xfffff097
 588:	6f746b73 	svcvs	0x00746b73
 58c:	41462f70 	hvcmi	25328	; 0x62f0
 590:	614e2f56 	cmpvs	lr, r6, asr pc
 594:	757a6176 	ldrbvc	r6, [sl, #-374]!	; 0xfffffe8a
 598:	6963696a 	stmdbvs	r3!, {r1, r3, r5, r6, r8, fp, sp, lr}^
 59c:	2f534f2f 	svccs	0x00534f2f
 5a0:	656d6573 	strbvs	r6, [sp, #-1395]!	; 0xfffffa8d
 5a4:	61727473 	cmnvs	r2, r3, ror r4
 5a8:	2d616b6c 	vstmdbcs	r1!, {d22-<overflow reg d75>}
 5ac:	2d76696b 			; <UNDEFINED> instruction: 0x2d76696b
 5b0:	732f736f 			; <UNDEFINED> instruction: 0x732f736f
 5b4:	6372756f 	cmnvs	r2, #465567744	; 0x1bc00000
 5b8:	732f7365 			; <UNDEFINED> instruction: 0x732f7365
 5bc:	696c6474 	stmdbvs	ip!, {r2, r4, r5, r6, sl, sp, lr}^
 5c0:	72732f62 	rsbsvc	r2, r3, #392	; 0x188
 5c4:	552f0063 	strpl	r0, [pc, #-99]!	; 569 <shift+0x569>
 5c8:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 5cc:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 5d0:	6a726574 	bvs	1c99ba8 <__bss_end+0x1c90bc8>
 5d4:	65442f69 	strbvs	r2, [r4, #-3945]	; 0xfffff097
 5d8:	6f746b73 	svcvs	0x00746b73
 5dc:	41462f70 	hvcmi	25328	; 0x62f0
 5e0:	614e2f56 	cmpvs	lr, r6, asr pc
 5e4:	757a6176 	ldrbvc	r6, [sl, #-374]!	; 0xfffffe8a
 5e8:	6963696a 	stmdbvs	r3!, {r1, r3, r5, r6, r8, fp, sp, lr}^
 5ec:	2f534f2f 	svccs	0x00534f2f
 5f0:	656d6573 	strbvs	r6, [sp, #-1395]!	; 0xfffffa8d
 5f4:	61727473 	cmnvs	r2, r3, ror r4
 5f8:	2d616b6c 	vstmdbcs	r1!, {d22-<overflow reg d75>}
 5fc:	2d76696b 			; <UNDEFINED> instruction: 0x2d76696b
 600:	732f736f 			; <UNDEFINED> instruction: 0x732f736f
 604:	6372756f 	cmnvs	r2, #465567744	; 0x1bc00000
 608:	6b2f7365 	blvs	bdd3a4 <__bss_end+0xbd43c4>
 60c:	656e7265 	strbvs	r7, [lr, #-613]!	; 0xfffffd9b
 610:	6e692f6c 	cdpvs	15, 6, cr2, cr9, cr12, {3}
 614:	64756c63 	ldrbtvs	r6, [r5], #-3171	; 0xfffff39d
 618:	72702f65 	rsbsvc	r2, r0, #404	; 0x194
 61c:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
 620:	552f0073 	strpl	r0, [pc, #-115]!	; 5b5 <shift+0x5b5>
 624:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 628:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 62c:	6a726574 	bvs	1c99c04 <__bss_end+0x1c90c24>
 630:	65442f69 	strbvs	r2, [r4, #-3945]	; 0xfffff097
 634:	6f746b73 	svcvs	0x00746b73
 638:	41462f70 	hvcmi	25328	; 0x62f0
 63c:	614e2f56 	cmpvs	lr, r6, asr pc
 640:	757a6176 	ldrbvc	r6, [sl, #-374]!	; 0xfffffe8a
 644:	6963696a 	stmdbvs	r3!, {r1, r3, r5, r6, r8, fp, sp, lr}^
 648:	2f534f2f 	svccs	0x00534f2f
 64c:	656d6573 	strbvs	r6, [sp, #-1395]!	; 0xfffffa8d
 650:	61727473 	cmnvs	r2, r3, ror r4
 654:	2d616b6c 	vstmdbcs	r1!, {d22-<overflow reg d75>}
 658:	2d76696b 			; <UNDEFINED> instruction: 0x2d76696b
 65c:	732f736f 			; <UNDEFINED> instruction: 0x732f736f
 660:	6372756f 	cmnvs	r2, #465567744	; 0x1bc00000
 664:	6b2f7365 	blvs	bdd400 <__bss_end+0xbd4420>
 668:	656e7265 	strbvs	r7, [lr, #-613]!	; 0xfffffd9b
 66c:	6e692f6c 	cdpvs	15, 6, cr2, cr9, cr12, {3}
 670:	64756c63 	ldrbtvs	r6, [r5], #-3171	; 0xfffff39d
 674:	73662f65 	cmnvc	r6, #404	; 0x194
 678:	73552f00 	cmpvc	r5, #0, 30
 67c:	2f737265 	svccs	0x00737265
 680:	746e6977 	strbtvc	r6, [lr], #-2423	; 0xfffff689
 684:	696a7265 	stmdbvs	sl!, {r0, r2, r5, r6, r9, ip, sp, lr}^
 688:	7365442f 	cmnvc	r5, #788529152	; 0x2f000000
 68c:	706f746b 	rsbvc	r7, pc, fp, ror #8
 690:	5641462f 	strbpl	r4, [r1], -pc, lsr #12
 694:	76614e2f 	strbtvc	r4, [r1], -pc, lsr #28
 698:	6a757a61 	bvs	1d5f024 <__bss_end+0x1d56044>
 69c:	2f696369 	svccs	0x00696369
 6a0:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
 6a4:	73656d65 	cmnvc	r5, #6464	; 0x1940
 6a8:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
 6ac:	6b2d616b 	blvs	b58c60 <__bss_end+0xb4fc80>
 6b0:	6f2d7669 	svcvs	0x002d7669
 6b4:	6f732f73 	svcvs	0x00732f73
 6b8:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
 6bc:	656b2f73 	strbvs	r2, [fp, #-3955]!	; 0xfffff08d
 6c0:	6c656e72 	stclvs	14, cr6, [r5], #-456	; 0xfffffe38
 6c4:	636e692f 	cmnvs	lr, #770048	; 0xbc000
 6c8:	6564756c 	strbvs	r7, [r4, #-1388]!	; 0xfffffa94
 6cc:	616f622f 	cmnvs	pc, pc, lsr #4
 6d0:	722f6472 	eorvc	r6, pc, #1912602624	; 0x72000000
 6d4:	2f306970 	svccs	0x00306970
 6d8:	006c6168 	rsbeq	r6, ip, r8, ror #2
 6dc:	64747300 	ldrbtvs	r7, [r4], #-768	; 0xfffffd00
 6e0:	656c6966 	strbvs	r6, [ip, #-2406]!	; 0xfffff69a
 6e4:	7070632e 	rsbsvc	r6, r0, lr, lsr #6
 6e8:	00000100 	andeq	r0, r0, r0, lsl #2
 6ec:	2e697773 	mcrcs	7, 3, r7, cr9, cr3, {3}
 6f0:	00020068 	andeq	r0, r2, r8, rrx
 6f4:	69707300 	ldmdbvs	r0!, {r8, r9, ip, sp, lr}^
 6f8:	636f6c6e 	cmnvs	pc, #28160	; 0x6e00
 6fc:	00682e6b 	rsbeq	r2, r8, fp, ror #28
 700:	66000002 	strvs	r0, [r0], -r2
 704:	73656c69 	cmnvc	r5, #26880	; 0x6900
 708:	65747379 	ldrbvs	r7, [r4, #-889]!	; 0xfffffc87
 70c:	00682e6d 	rsbeq	r2, r8, sp, ror #28
 710:	70000003 	andvc	r0, r0, r3
 714:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
 718:	682e7373 	stmdavs	lr!, {r0, r1, r4, r5, r6, r8, r9, ip, sp, lr}
 71c:	00000200 	andeq	r0, r0, r0, lsl #4
 720:	636f7270 	cmnvs	pc, #112, 4
 724:	5f737365 	svcpl	0x00737365
 728:	616e616d 	cmnvs	lr, sp, ror #2
 72c:	2e726567 	cdpcs	5, 7, cr6, cr2, cr7, {3}
 730:	00020068 	andeq	r0, r2, r8, rrx
 734:	746e6900 	strbtvc	r6, [lr], #-2304	; 0xfffff700
 738:	2e666564 	cdpcs	5, 6, cr6, cr6, cr4, {3}
 73c:	00040068 	andeq	r0, r4, r8, rrx
 740:	01050000 	mrseq	r0, (UNDEF: 5)
 744:	b4020500 	strlt	r0, [r2], #-1280	; 0xfffffb00
 748:	16000083 	strne	r0, [r0], -r3, lsl #1
 74c:	2f690505 	svccs	0x00690505
 750:	054c0c05 	strbeq	r0, [ip, #-3077]	; 0xfffff3fb
 754:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 758:	054b8305 	strbeq	r8, [fp, #-773]	; 0xfffffcfb
 75c:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 760:	01054b05 	tsteq	r5, r5, lsl #22
 764:	0505852f 	streq	r8, [r5, #-1327]	; 0xfffffad1
 768:	2f4b4ba1 	svccs	0x004b4ba1
 76c:	054c0c05 	strbeq	r0, [ip, #-3077]	; 0xfffff3fb
 770:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 774:	4b4bbd05 	blmi	12efb90 <__bss_end+0x12e6bb0>
 778:	0c052f4b 	stceq	15, cr2, [r5], {75}	; 0x4b
 77c:	2f01054c 	svccs	0x0001054c
 780:	bd050585 	cfstr32lt	mvfx0, [r5, #-532]	; 0xfffffdec
 784:	2f4b4b4b 	svccs	0x004b4b4b
 788:	054c0c05 	strbeq	r0, [ip, #-3077]	; 0xfffff3fb
 78c:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 790:	054b8305 	strbeq	r8, [fp, #-773]	; 0xfffffcfb
 794:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 798:	4b4bbd05 	blmi	12efbb4 <__bss_end+0x12e6bd4>
 79c:	0c052f4b 	stceq	15, cr2, [r5], {75}	; 0x4b
 7a0:	2f01054c 	svccs	0x0001054c
 7a4:	a1050585 	smlabbge	r5, r5, r5, r0
 7a8:	052f4b4b 	streq	r4, [pc, #-2891]!	; fffffc65 <__bss_end+0xffff6c85>
 7ac:	01054c0c 	tsteq	r5, ip, lsl #24
 7b0:	0505852f 	streq	r8, [r5, #-1327]	; 0xfffffad1
 7b4:	4b4b4bbd 	blmi	12d36b0 <__bss_end+0x12ca6d0>
 7b8:	4c0c052f 	cfstr32mi	mvfx0, [ip], {47}	; 0x2f
 7bc:	852f0105 	strhi	r0, [pc, #-261]!	; 6bf <shift+0x6bf>
 7c0:	4ba10505 	blmi	fe841bdc <__bss_end+0xfe838bfc>
 7c4:	0c052f4b 	stceq	15, cr2, [r5], {75}	; 0x4b
 7c8:	9f01054c 	svcls	0x0001054c
 7cc:	67200585 	strvs	r0, [r0, -r5, lsl #11]!
 7d0:	4b4d0505 	blmi	1341bec <__bss_end+0x1338c0c>
 7d4:	300c054b 	andcc	r0, ip, fp, asr #10
 7d8:	852f0105 	strhi	r0, [pc, #-261]!	; 6db <shift+0x6db>
 7dc:	05672005 	strbeq	r2, [r7, #-5]!
 7e0:	4b4b4d05 	blmi	12d3bfc <__bss_end+0x12cac1c>
 7e4:	05300c05 	ldreq	r0, [r0, #-3077]!	; 0xfffff3fb
 7e8:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 7ec:	05058320 	streq	r8, [r5, #-800]	; 0xfffffce0
 7f0:	054b4b4c 	strbeq	r4, [fp, #-2892]	; 0xfffff4b4
 7f4:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 7f8:	05056720 	streq	r6, [r5, #-1824]	; 0xfffff8e0
 7fc:	054b4b4d 	strbeq	r4, [fp, #-2893]	; 0xfffff4b3
 800:	0105300c 	tsteq	r5, ip
 804:	0c05872f 	stceq	7, cr8, [r5], {47}	; 0x2f
 808:	31059fa0 	smlatbcc	r5, r0, pc, r9	; <UNPREDICTABLE>
 80c:	662905bc 			; <UNDEFINED> instruction: 0x662905bc
 810:	052e3605 	streq	r3, [lr, #-1541]!	; 0xfffff9fb
 814:	1305300f 	movwne	r3, #20495	; 0x500f
 818:	84090566 	strhi	r0, [r9], #-1382	; 0xfffffa9a
 81c:	05d81005 	ldrbeq	r1, [r8, #5]
 820:	08029f01 	stmdaeq	r2, {r0, r8, r9, sl, fp, ip, pc}
 824:	9b010100 	blls	40c2c <__bss_end+0x37c4c>
 828:	03000002 	movweq	r0, #2
 82c:	00007400 	andeq	r7, r0, r0, lsl #8
 830:	fb010200 	blx	4103a <__bss_end+0x3805a>
 834:	01000d0e 	tsteq	r0, lr, lsl #26
 838:	00010101 	andeq	r0, r1, r1, lsl #2
 83c:	00010000 	andeq	r0, r1, r0
 840:	552f0100 	strpl	r0, [pc, #-256]!	; 748 <shift+0x748>
 844:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 848:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 84c:	6a726574 	bvs	1c99e24 <__bss_end+0x1c90e44>
 850:	65442f69 	strbvs	r2, [r4, #-3945]	; 0xfffff097
 854:	6f746b73 	svcvs	0x00746b73
 858:	41462f70 	hvcmi	25328	; 0x62f0
 85c:	614e2f56 	cmpvs	lr, r6, asr pc
 860:	757a6176 	ldrbvc	r6, [sl, #-374]!	; 0xfffffe8a
 864:	6963696a 	stmdbvs	r3!, {r1, r3, r5, r6, r8, fp, sp, lr}^
 868:	2f534f2f 	svccs	0x00534f2f
 86c:	656d6573 	strbvs	r6, [sp, #-1395]!	; 0xfffffa8d
 870:	61727473 	cmnvs	r2, r3, ror r4
 874:	2d616b6c 	vstmdbcs	r1!, {d22-<overflow reg d75>}
 878:	2d76696b 			; <UNDEFINED> instruction: 0x2d76696b
 87c:	732f736f 			; <UNDEFINED> instruction: 0x732f736f
 880:	6372756f 	cmnvs	r2, #465567744	; 0x1bc00000
 884:	732f7365 			; <UNDEFINED> instruction: 0x732f7365
 888:	696c6474 	stmdbvs	ip!, {r2, r4, r5, r6, sl, sp, lr}^
 88c:	72732f62 	rsbsvc	r2, r3, #392	; 0x188
 890:	73000063 	movwvc	r0, #99	; 0x63
 894:	74736474 	ldrbtvc	r6, [r3], #-1140	; 0xfffffb8c
 898:	676e6972 			; <UNDEFINED> instruction: 0x676e6972
 89c:	7070632e 	rsbsvc	r6, r0, lr, lsr #6
 8a0:	00000100 	andeq	r0, r0, r0, lsl #2
 8a4:	00010500 	andeq	r0, r1, r0, lsl #10
 8a8:	88100205 	ldmdahi	r0, {r0, r2, r9}
 8ac:	051a0000 	ldreq	r0, [sl, #-0]
 8b0:	0f05bb06 	svceq	0x0005bb06
 8b4:	6821054c 	stmdavs	r1!, {r2, r3, r6, r8, sl}
 8b8:	05ba0a05 	ldreq	r0, [sl, #2565]!	; 0xa05
 8bc:	27052e0b 	strcs	r2, [r5, -fp, lsl #28]
 8c0:	4a0d054a 	bmi	341df0 <__bss_end+0x338e10>
 8c4:	052f0905 	streq	r0, [pc, #-2309]!	; ffffffc7 <__bss_end+0xffff6fe7>
 8c8:	02059f04 	andeq	r9, r5, #4, 30
 8cc:	35050562 	strcc	r0, [r5, #-1378]	; 0xfffffa9e
 8d0:	05681005 	strbeq	r1, [r8, #-5]!
 8d4:	22052e11 	andcs	r2, r5, #272	; 0x110
 8d8:	2e13054a 	cfmac32cs	mvfx0, mvfx3, mvfx10
 8dc:	052f0a05 	streq	r0, [pc, #-2565]!	; fffffedf <__bss_end+0xffff6eff>
 8e0:	0a056909 	beq	15ad0c <__bss_end+0x151d2c>
 8e4:	4a0c052e 	bmi	301da4 <__bss_end+0x2f8dc4>
 8e8:	054b0305 	strbeq	r0, [fp, #-773]	; 0xfffffcfb
 8ec:	1805680b 	stmdane	r5, {r0, r1, r3, fp, sp, lr}
 8f0:	03040200 	movweq	r0, #16896	; 0x4200
 8f4:	0014054a 	andseq	r0, r4, sl, asr #10
 8f8:	9e030402 	cdpls	4, 0, cr0, cr3, cr2, {0}
 8fc:	02001505 	andeq	r1, r0, #20971520	; 0x1400000
 900:	05680204 	strbeq	r0, [r8, #-516]!	; 0xfffffdfc
 904:	04020018 	streq	r0, [r2], #-24	; 0xffffffe8
 908:	08058202 	stmdaeq	r5, {r1, r9, pc}
 90c:	02040200 	andeq	r0, r4, #0, 4
 910:	001a054a 	andseq	r0, sl, sl, asr #10
 914:	4b020402 	blmi	81924 <__bss_end+0x78944>
 918:	02001b05 	andeq	r1, r0, #5120	; 0x1400
 91c:	052e0204 	streq	r0, [lr, #-516]!	; 0xfffffdfc
 920:	0402000c 	streq	r0, [r2], #-12
 924:	0f054a02 	svceq	0x00054a02
 928:	02040200 	andeq	r0, r4, #0, 4
 92c:	001b0582 	andseq	r0, fp, r2, lsl #11
 930:	4a020402 	bmi	81940 <__bss_end+0x78960>
 934:	02001105 	andeq	r1, r0, #1073741825	; 0x40000001
 938:	052e0204 	streq	r0, [lr, #-516]!	; 0xfffffdfc
 93c:	0402000a 	streq	r0, [r2], #-10
 940:	0b052f02 	bleq	14c550 <__bss_end+0x143570>
 944:	02040200 	andeq	r0, r4, #0, 4
 948:	000d052e 	andeq	r0, sp, lr, lsr #10
 94c:	4a020402 	bmi	8195c <__bss_end+0x7897c>
 950:	02000205 	andeq	r0, r0, #1342177280	; 0x50000000
 954:	05460204 	strbeq	r0, [r6, #-516]	; 0xfffffdfc
 958:	05858801 	streq	r8, [r5, #2049]	; 0x801
 95c:	09058306 	stmdbeq	r5, {r1, r2, r8, r9, pc}
 960:	4a10054c 	bmi	401e98 <__bss_end+0x3f8eb8>
 964:	054c0a05 	strbeq	r0, [ip, #-2565]	; 0xfffff5fb
 968:	0305bb07 	movweq	fp, #23303	; 0x5b07
 96c:	0017054a 	andseq	r0, r7, sl, asr #10
 970:	4a010402 	bmi	41980 <__bss_end+0x389a0>
 974:	02001405 	andeq	r1, r0, #83886080	; 0x5000000
 978:	054a0104 	strbeq	r0, [sl, #-260]	; 0xfffffefc
 97c:	14054d0d 	strne	r4, [r5], #-3341	; 0xfffff2f3
 980:	2e0a054a 	cfsh32cs	mvfx0, mvfx10, #42
 984:	05680805 	strbeq	r0, [r8, #-2053]!	; 0xfffff7fb
 988:	66780302 	ldrbtvs	r0, [r8], -r2, lsl #6
 98c:	0b030905 	bleq	c2da8 <__bss_end+0xb9dc8>
 990:	2f01052e 	svccs	0x0001052e
 994:	bd090585 	cfstr32lt	mvfx0, [r9, #-532]	; 0xfffffdec
 998:	02001605 	andeq	r1, r0, #5242880	; 0x500000
 99c:	054a0404 	strbeq	r0, [sl, #-1028]	; 0xfffffbfc
 9a0:	0402001d 	streq	r0, [r2], #-29	; 0xffffffe3
 9a4:	1e058202 	cdpne	2, 0, cr8, cr5, cr2, {0}
 9a8:	02040200 	andeq	r0, r4, #0, 4
 9ac:	0016052e 	andseq	r0, r6, lr, lsr #10
 9b0:	66020402 	strvs	r0, [r2], -r2, lsl #8
 9b4:	02001105 	andeq	r1, r0, #1073741825	; 0x40000001
 9b8:	054b0304 	strbeq	r0, [fp, #-772]	; 0xfffffcfc
 9bc:	04020012 	streq	r0, [r2], #-18	; 0xffffffee
 9c0:	08052e03 	stmdaeq	r5, {r0, r1, r9, sl, fp, sp}
 9c4:	03040200 	movweq	r0, #16896	; 0x4200
 9c8:	0009054a 	andeq	r0, r9, sl, asr #10
 9cc:	2e030402 	cdpcs	4, 0, cr0, cr3, cr2, {0}
 9d0:	02001205 	andeq	r1, r0, #1342177280	; 0x50000000
 9d4:	054a0304 	strbeq	r0, [sl, #-772]	; 0xfffffcfc
 9d8:	0402000b 	streq	r0, [r2], #-11
 9dc:	02052e03 	andeq	r2, r5, #3, 28	; 0x30
 9e0:	03040200 	movweq	r0, #16896	; 0x4200
 9e4:	000b052d 	andeq	r0, fp, sp, lsr #10
 9e8:	84020402 	strhi	r0, [r2], #-1026	; 0xfffffbfe
 9ec:	02000805 	andeq	r0, r0, #327680	; 0x50000
 9f0:	05830104 	streq	r0, [r3, #260]	; 0x104
 9f4:	04020009 	streq	r0, [r2], #-9
 9f8:	0b052e01 	bleq	14c204 <__bss_end+0x143224>
 9fc:	01040200 	mrseq	r0, R12_usr
 a00:	0002054a 	andeq	r0, r2, sl, asr #10
 a04:	49010402 	stmdbmi	r1, {r1, sl}
 a08:	05850b05 	streq	r0, [r5, #2821]	; 0xb05
 a0c:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 a10:	1105bc0e 	tstne	r5, lr, lsl #24
 a14:	bc200566 	cfstr32lt	mvfx0, [r0], #-408	; 0xfffffe68
 a18:	05660b05 	strbeq	r0, [r6, #-2821]!	; 0xfffff4fb
 a1c:	0a054b1f 	beq	1536a0 <__bss_end+0x14a6c0>
 a20:	4b080566 	blmi	201fc0 <__bss_end+0x1f8fe0>
 a24:	05831105 	streq	r1, [r3, #261]	; 0x105
 a28:	08052e16 	stmdaeq	r5, {r1, r2, r4, r9, sl, fp, sp}
 a2c:	67110567 	ldrvs	r0, [r1, -r7, ror #10]
 a30:	054d0b05 	strbeq	r0, [sp, #-2821]	; 0xfffff4fb
 a34:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 a38:	0b058306 	bleq	161658 <__bss_end+0x158678>
 a3c:	2e0c054c 	cfsh32cs	mvfx0, mvfx12, #44
 a40:	05660e05 	strbeq	r0, [r6, #-3589]!	; 0xfffff1fb
 a44:	02054b04 	andeq	r4, r5, #4, 22	; 0x1000
 a48:	31090565 	tstcc	r9, r5, ror #10
 a4c:	852f0105 	strhi	r0, [pc, #-261]!	; 94f <shift+0x94f>
 a50:	059f0805 	ldreq	r0, [pc, #2053]	; 125d <shift+0x125d>
 a54:	14054c0b 	strne	r4, [r5], #-3083	; 0xfffff3f5
 a58:	03040200 	movweq	r0, #16896	; 0x4200
 a5c:	0007054a 	andeq	r0, r7, sl, asr #10
 a60:	83020402 	movwhi	r0, #9218	; 0x2402
 a64:	02000805 	andeq	r0, r0, #327680	; 0x50000
 a68:	052e0204 	streq	r0, [lr, #-516]!	; 0xfffffdfc
 a6c:	0402000a 	streq	r0, [r2], #-10
 a70:	02054a02 	andeq	r4, r5, #8192	; 0x2000
 a74:	02040200 	andeq	r0, r4, #0, 4
 a78:	84010549 	strhi	r0, [r1], #-1353	; 0xfffffab7
 a7c:	bb0e0585 	bllt	382098 <__bss_end+0x3790b8>
 a80:	054b0805 	strbeq	r0, [fp, #-2053]	; 0xfffff7fb
 a84:	14054c0b 	strne	r4, [r5], #-3083	; 0xfffff3f5
 a88:	03040200 	movweq	r0, #16896	; 0x4200
 a8c:	0016054a 	andseq	r0, r6, sl, asr #10
 a90:	83020402 	movwhi	r0, #9218	; 0x2402
 a94:	02001705 	andeq	r1, r0, #1310720	; 0x140000
 a98:	052e0204 	streq	r0, [lr, #-516]!	; 0xfffffdfc
 a9c:	0402000a 	streq	r0, [r2], #-10
 aa0:	0b054a02 	bleq	1532b0 <__bss_end+0x14a2d0>
 aa4:	02040200 	andeq	r0, r4, #0, 4
 aa8:	0017052e 	andseq	r0, r7, lr, lsr #10
 aac:	4a020402 	bmi	81abc <__bss_end+0x78adc>
 ab0:	02000d05 	andeq	r0, r0, #320	; 0x140
 ab4:	052e0204 	streq	r0, [lr, #-516]!	; 0xfffffdfc
 ab8:	04020002 	streq	r0, [r2], #-2
 abc:	01052d02 	tsteq	r5, r2, lsl #26
 ac0:	00080284 	andeq	r0, r8, r4, lsl #5
 ac4:	Address 0x0000000000000ac4 is out of bounds.


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
      58:	074a0704 	strbeq	r0, [sl, -r4, lsl #14]
      5c:	5b020000 	blpl	80064 <__bss_end+0x77084>
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
     128:	0000074a 	andeq	r0, r0, sl, asr #14
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
     174:	cb104801 	blgt	412180 <__bss_end+0x4091a0>
     178:	d4000000 	strle	r0, [r0], #-0
     17c:	58000081 	stmdapl	r0, {r0, r7}
     180:	01000000 	mrseq	r0, (UNDEF: 0)
     184:	0000cb9c 	muleq	r0, ip, fp
     188:	02b40a00 	adcseq	r0, r4, #0, 20
     18c:	4a010000 	bmi	40194 <__bss_end+0x371b4>
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
     21c:	ba0d9c01 	blt	367228 <__bss_end+0x35e248>
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
     24c:	8b120f01 	blhi	483e58 <__bss_end+0x47ae78>
     250:	0f000001 	svceq	0x00000001
     254:	0000019e 	muleq	r0, lr, r1
     258:	03d51000 	bicseq	r1, r5, #0
     25c:	0a010000 	beq	40264 <__bss_end+0x37284>
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
     2b4:	8b140074 	blhi	50048c <__bss_end+0x4f74ac>
     2b8:	a4000001 	strge	r0, [r0], #-1
     2bc:	38000080 	stmdacc	r0, {r7}
     2c0:	01000000 	mrseq	r0, (UNDEF: 0)
     2c4:	0067139c 	mlseq	r7, ip, r3, r1
     2c8:	9e2f0a01 	vmulls.f32	s0, s30, s2
     2cc:	02000001 	andeq	r0, r0, #1
     2d0:	00007491 	muleq	r0, r1, r4
     2d4:	00000894 	muleq	r0, r4, r8
     2d8:	01e00004 	mvneq	r0, r4
     2dc:	01040000 	mrseq	r0, (UNDEF: 4)
     2e0:	000001e1 	andeq	r0, r0, r1, ror #3
     2e4:	0007b604 	andeq	fp, r7, r4, lsl #12
     2e8:	00005600 	andeq	r5, r0, r0, lsl #12
     2ec:	00822c00 	addeq	r2, r2, r0, lsl #24
     2f0:	00018800 	andeq	r8, r1, r0, lsl #16
     2f4:	00024600 	andeq	r4, r2, r0, lsl #12
     2f8:	08010200 	stmdaeq	r1, {r9}
     2fc:	000009a8 	andeq	r0, r0, r8, lsr #19
     300:	f4050202 	vst1.8	{d0-d3}, [r5], r2
     304:	03000009 	movweq	r0, #9
     308:	6e690504 	cdpvs	5, 6, cr0, cr9, cr4, {0}
     30c:	01020074 	tsteq	r2, r4, ror r0
     310:	00099f08 	andeq	r9, r9, r8, lsl #30
     314:	07020200 	streq	r0, [r2, -r0, lsl #4]
     318:	00000791 	muleq	r0, r1, r7
     31c:	000a2d04 	andeq	r2, sl, r4, lsl #26
     320:	07090900 	streq	r0, [r9, -r0, lsl #18]
     324:	00000059 	andeq	r0, r0, r9, asr r0
     328:	00004805 	andeq	r4, r0, r5, lsl #16
     32c:	07040200 	streq	r0, [r4, -r0, lsl #4]
     330:	0000074a 	andeq	r0, r0, sl, asr #14
     334:	00005905 	andeq	r5, r0, r5, lsl #18
     338:	06330600 	ldrteq	r0, [r3], -r0, lsl #12
     33c:	02080000 	andeq	r0, r8, #0
     340:	008b0806 	addeq	r0, fp, r6, lsl #16
     344:	72070000 	andvc	r0, r7, #0
     348:	08020030 	stmdaeq	r2, {r4, r5}
     34c:	0000480e 	andeq	r4, r0, lr, lsl #16
     350:	72070000 	andvc	r0, r7, #0
     354:	09020031 	stmdbeq	r2, {r0, r4, r5}
     358:	0000480e 	andeq	r4, r0, lr, lsl #16
     35c:	08000400 	stmdaeq	r0, {sl}
     360:	000004fe 	strdeq	r0, [r0], -lr
     364:	00330405 	eorseq	r0, r3, r5, lsl #8
     368:	1e020000 	cdpne	0, 0, cr0, cr2, cr0, {0}
     36c:	0000c20c 	andeq	ip, r0, ip, lsl #4
     370:	069a0900 	ldreq	r0, [sl], r0, lsl #18
     374:	09000000 	stmdbeq	r0, {}	; <UNPREDICTABLE>
     378:	00000c52 	andeq	r0, r0, r2, asr ip
     37c:	0c320901 			; <UNDEFINED> instruction: 0x0c320901
     380:	09020000 	stmdbeq	r2, {}	; <UNPREDICTABLE>
     384:	00000827 	andeq	r0, r0, r7, lsr #16
     388:	092e0903 	stmdbeq	lr!, {r0, r1, r8, fp}
     38c:	09040000 	stmdbeq	r4, {}	; <UNPREDICTABLE>
     390:	00000663 	andeq	r0, r0, r3, ror #12
     394:	c4080005 	strgt	r0, [r8], #-5
     398:	0500000b 	streq	r0, [r0, #-11]
     39c:	00003304 	andeq	r3, r0, r4, lsl #6
     3a0:	0c3f0200 	lfmeq	f0, 4, [pc], #-0	; 3a8 <shift+0x3a8>
     3a4:	000000ff 	strdeq	r0, [r0], -pc	; <UNPREDICTABLE>
     3a8:	0003ff09 	andeq	pc, r3, r9, lsl #30
     3ac:	13090000 	movwne	r0, #36864	; 0x9000
     3b0:	01000005 	tsteq	r0, r5
     3b4:	00092109 	andeq	r2, r9, r9, lsl #2
     3b8:	12090200 	andne	r0, r9, #0, 4
     3bc:	0300000c 	movweq	r0, #12
     3c0:	000c5c09 	andeq	r5, ip, r9, lsl #24
     3c4:	e3090400 	movw	r0, #37888	; 0x9400
     3c8:	05000008 	streq	r0, [r0, #-8]
     3cc:	0007b109 	andeq	fp, r7, r9, lsl #2
     3d0:	0a000600 	beq	1bd8 <shift+0x1bd8>
     3d4:	000008fd 	strdeq	r0, [r0], -sp
     3d8:	54140503 	ldrpl	r0, [r4], #-1283	; 0xfffffafd
     3dc:	05000000 	streq	r0, [r0, #-0]
     3e0:	008ed803 	addeq	sp, lr, r3, lsl #16
     3e4:	09100a00 	ldmdbeq	r0, {r9, fp}
     3e8:	06030000 	streq	r0, [r3], -r0
     3ec:	00005414 	andeq	r5, r0, r4, lsl r4
     3f0:	dc030500 	cfstr32le	mvfx0, [r3], {-0}
     3f4:	0a00008e 	beq	634 <shift+0x634>
     3f8:	000008cd 	andeq	r0, r0, sp, asr #17
     3fc:	541a0704 	ldrpl	r0, [sl], #-1796	; 0xfffff8fc
     400:	05000000 	streq	r0, [r0, #-0]
     404:	008ee003 	addeq	lr, lr, r3
     408:	05420a00 	strbeq	r0, [r2, #-2560]	; 0xfffff600
     40c:	09040000 	stmdbeq	r4, {}	; <UNPREDICTABLE>
     410:	0000541a 	andeq	r5, r0, sl, lsl r4
     414:	e4030500 	str	r0, [r3], #-1280	; 0xfffffb00
     418:	0a00008e 	beq	658 <shift+0x658>
     41c:	00000991 	muleq	r0, r1, r9
     420:	541a0b04 	ldrpl	r0, [sl], #-2820	; 0xfffff4fc
     424:	05000000 	streq	r0, [r0, #-0]
     428:	008ee803 	addeq	lr, lr, r3, lsl #16
     42c:	076b0a00 	strbeq	r0, [fp, -r0, lsl #20]!
     430:	0d040000 	stceq	0, cr0, [r4, #-0]
     434:	0000541a 	andeq	r5, r0, sl, lsl r4
     438:	ec030500 	cfstr32	mvfx0, [r3], {-0}
     43c:	0a00008e 	beq	67c <shift+0x67c>
     440:	0000064c 	andeq	r0, r0, ip, asr #12
     444:	541a0f04 	ldrpl	r0, [sl], #-3844	; 0xfffff0fc
     448:	05000000 	streq	r0, [r0, #-0]
     44c:	008ef003 	addeq	pc, lr, r3
     450:	109e0800 	addsne	r0, lr, r0, lsl #16
     454:	04050000 	streq	r0, [r5], #-0
     458:	00000033 	andeq	r0, r0, r3, lsr r0
     45c:	a20c1b04 	andge	r1, ip, #4, 22	; 0x1000
     460:	09000001 	stmdbeq	r0, {r0}
     464:	00000a55 	andeq	r0, r0, r5, asr sl
     468:	0c220900 			; <UNDEFINED> instruction: 0x0c220900
     46c:	09010000 	stmdbeq	r1, {}	; <UNPREDICTABLE>
     470:	0000091c 	andeq	r0, r0, ip, lsl r9
     474:	8b0b0002 	blhi	2c0484 <__bss_end+0x2b74a4>
     478:	02000009 	andeq	r0, r0, #9
     47c:	08370201 	ldmdaeq	r7!, {r0, r9}
     480:	040c0000 	streq	r0, [ip], #-0
     484:	000001a2 	andeq	r0, r0, r2, lsr #3
     488:	0006e20a 	andeq	lr, r6, sl, lsl #4
     48c:	14040500 	strne	r0, [r4], #-1280	; 0xfffffb00
     490:	00000054 	andeq	r0, r0, r4, asr r0
     494:	8ef40305 	cdphi	3, 15, cr0, cr4, cr5, {0}
     498:	f40a0000 	vst4.8	{d0-d3}, [sl], r0
     49c:	05000003 	streq	r0, [r0, #-3]
     4a0:	00541407 	subseq	r1, r4, r7, lsl #8
     4a4:	03050000 	movweq	r0, #20480	; 0x5000
     4a8:	00008ef8 	strdeq	r8, [r0], -r8	; <UNPREDICTABLE>
     4ac:	0005700a 	andeq	r7, r5, sl
     4b0:	140a0500 	strne	r0, [sl], #-1280	; 0xfffffb00
     4b4:	00000054 	andeq	r0, r0, r4, asr r0
     4b8:	8efc0305 	cdphi	3, 15, cr0, cr12, cr5, {0}
     4bc:	6c080000 	stcvs	0, cr0, [r8], {-0}
     4c0:	05000008 	streq	r0, [r0, #-8]
     4c4:	00003304 	andeq	r3, r0, r4, lsl #6
     4c8:	0c0d0500 	cfstr32eq	mvfx0, [sp], {-0}
     4cc:	00000221 	andeq	r0, r0, r1, lsr #4
     4d0:	77654e0d 	strbvc	r4, [r5, -sp, lsl #28]!
     4d4:	63090000 	movwvs	r0, #36864	; 0x9000
     4d8:	01000008 	tsteq	r0, r8
     4dc:	000a2509 	andeq	r2, sl, r9, lsl #10
     4e0:	46090200 	strmi	r0, [r9], -r0, lsl #4
     4e4:	03000008 	movweq	r0, #8
     4e8:	00081909 	andeq	r1, r8, r9, lsl #18
     4ec:	27090400 	strcs	r0, [r9, -r0, lsl #8]
     4f0:	05000009 	streq	r0, [r0, #-9]
     4f4:	06560600 	ldrbeq	r0, [r6], -r0, lsl #12
     4f8:	05100000 	ldreq	r0, [r0, #-0]
     4fc:	0260081b 	rsbeq	r0, r0, #1769472	; 0x1b0000
     500:	6c070000 	stcvs	0, cr0, [r7], {-0}
     504:	1d050072 	stcne	0, cr0, [r5, #-456]	; 0xfffffe38
     508:	00026013 	andeq	r6, r2, r3, lsl r0
     50c:	73070000 	movwvc	r0, #28672	; 0x7000
     510:	1e050070 	mcrne	0, 0, r0, cr5, cr0, {3}
     514:	00026013 	andeq	r6, r2, r3, lsl r0
     518:	70070400 	andvc	r0, r7, r0, lsl #8
     51c:	1f050063 	svcne	0x00050063
     520:	00026013 	andeq	r6, r2, r3, lsl r0
     524:	6c0e0800 	stcvs	8, cr0, [lr], {-0}
     528:	05000006 	streq	r0, [r0, #-6]
     52c:	02601320 	rsbeq	r1, r0, #32, 6	; 0x80000000
     530:	000c0000 	andeq	r0, ip, r0
     534:	45070402 	strmi	r0, [r7, #-1026]	; 0xfffffbfe
     538:	05000007 	streq	r0, [r0, #-7]
     53c:	00000260 	andeq	r0, r0, r0, ror #4
     540:	00046106 	andeq	r6, r4, r6, lsl #2
     544:	28057000 	stmdacs	r5, {ip, sp, lr}
     548:	0002fc08 	andeq	pc, r2, r8, lsl #24
     54c:	0a490e00 	beq	1243d54 <__bss_end+0x123ad74>
     550:	2a050000 	bcs	140558 <__bss_end+0x137578>
     554:	00022112 	andeq	r2, r2, r2, lsl r1
     558:	70070000 	andvc	r0, r7, r0
     55c:	05006469 	streq	r6, [r0, #-1129]	; 0xfffffb97
     560:	0059122b 	subseq	r1, r9, fp, lsr #4
     564:	0e100000 	cdpeq	0, 1, cr0, cr0, cr0, {0}
     568:	0000053c 	andeq	r0, r0, ip, lsr r5
     56c:	ea112c05 	b	44b588 <__bss_end+0x4425a8>
     570:	14000001 	strne	r0, [r0], #-1
     574:	0008800e 	andeq	r8, r8, lr
     578:	122d0500 	eorne	r0, sp, #0, 10
     57c:	00000059 	andeq	r0, r0, r9, asr r0
     580:	088e0e18 	stmeq	lr, {r3, r4, r9, sl, fp}
     584:	2e050000 	cdpcs	0, 0, cr0, cr5, cr0, {0}
     588:	00005912 	andeq	r5, r0, r2, lsl r9
     58c:	3f0e1c00 	svccc	0x000e1c00
     590:	05000006 	streq	r0, [r0, #-6]
     594:	02fc0c2f 	rscseq	r0, ip, #12032	; 0x2f00
     598:	0e200000 	cdpeq	0, 2, cr0, cr0, cr0, {0}
     59c:	000008a4 	andeq	r0, r0, r4, lsr #17
     5a0:	33093005 	movwcc	r3, #36869	; 0x9005
     5a4:	60000000 	andvs	r0, r0, r0
     5a8:	000a5f0e 	andeq	r5, sl, lr, lsl #30
     5ac:	0e310500 	cfabs32eq	mvfx0, mvfx1
     5b0:	00000048 	andeq	r0, r0, r8, asr #32
     5b4:	06b50e64 	ldrteq	r0, [r5], r4, ror #28
     5b8:	33050000 	movwcc	r0, #20480	; 0x5000
     5bc:	0000480e 	andeq	r4, r0, lr, lsl #16
     5c0:	ac0e6800 	stcge	8, cr6, [lr], {-0}
     5c4:	05000006 	streq	r0, [r0, #-6]
     5c8:	00480e34 	subeq	r0, r8, r4, lsr lr
     5cc:	006c0000 	rsbeq	r0, ip, r0
     5d0:	0001ae0f 	andeq	sl, r1, pc, lsl #28
     5d4:	00030c00 	andeq	r0, r3, r0, lsl #24
     5d8:	00591000 	subseq	r1, r9, r0
     5dc:	000f0000 	andeq	r0, pc, r0
     5e0:	000bed0a 	andeq	lr, fp, sl, lsl #26
     5e4:	140a0600 	strne	r0, [sl], #-1536	; 0xfffffa00
     5e8:	00000054 	andeq	r0, r0, r4, asr r0
     5ec:	8f000305 	svchi	0x00000305
     5f0:	4e080000 	cdpmi	0, 0, cr0, cr8, cr0, {0}
     5f4:	05000008 	streq	r0, [r0, #-8]
     5f8:	00003304 	andeq	r3, r0, r4, lsl #6
     5fc:	0c0d0600 	stceq	6, cr0, [sp], {-0}
     600:	0000033d 	andeq	r0, r0, sp, lsr r3
     604:	00051809 	andeq	r1, r5, r9, lsl #16
     608:	e9090000 	stmdb	r9, {}	; <UNPREDICTABLE>
     60c:	01000003 	tsteq	r0, r3
     610:	0b130600 	bleq	4c1e18 <__bss_end+0x4b8e38>
     614:	060c0000 	streq	r0, [ip], -r0
     618:	0372081b 	cmneq	r2, #1769472	; 0x1b0000
     61c:	330e0000 	movwcc	r0, #57344	; 0xe000
     620:	06000004 	streq	r0, [r0], -r4
     624:	0372191d 	cmneq	r2, #475136	; 0x74000
     628:	0e000000 	cdpeq	0, 0, cr0, cr0, cr0, {0}
     62c:	000004d1 	ldrdeq	r0, [r0], -r1
     630:	72191e06 	andsvc	r1, r9, #6, 28	; 0x60
     634:	04000003 	streq	r0, [r0], #-3
     638:	000ad30e 	andeq	sp, sl, lr, lsl #6
     63c:	131f0600 	tstne	pc, #0, 12
     640:	00000378 	andeq	r0, r0, r8, ror r3
     644:	040c0008 	streq	r0, [ip], #-8
     648:	0000033d 	andeq	r0, r0, sp, lsr r3
     64c:	026c040c 	rsbeq	r0, ip, #12, 8	; 0xc000000
     650:	83110000 	tsthi	r1, #0
     654:	14000005 	strne	r0, [r0], #-5
     658:	00072206 	andeq	r2, r7, r6, lsl #4
     65c:	0e000006 	cdpeq	0, 0, cr0, cr0, cr6, {0}
     660:	0000083c 	andeq	r0, r0, ip, lsr r8
     664:	48122606 	ldmdami	r2, {r1, r2, r9, sl, sp}
     668:	00000000 	andeq	r0, r0, r0
     66c:	0004900e 	andeq	r9, r4, lr
     670:	1d290600 	stcne	6, cr0, [r9, #-0]
     674:	00000372 	andeq	r0, r0, r2, ror r3
     678:	0a360e04 	beq	d83e90 <__bss_end+0xd7aeb0>
     67c:	2c060000 	stccs	0, cr0, [r6], {-0}
     680:	0003721d 	andeq	r7, r3, sp, lsl r2
     684:	ba120800 	blt	48268c <__bss_end+0x4796ac>
     688:	0600000b 	streq	r0, [r0], -fp
     68c:	0af00e2f 	beq	ffc03f50 <__bss_end+0xffbfaf70>
     690:	03c60000 	biceq	r0, r6, #0
     694:	03d10000 	bicseq	r0, r1, #0
     698:	05130000 	ldreq	r0, [r3, #-0]
     69c:	14000006 	strne	r0, [r0], #-6
     6a0:	00000372 	andeq	r0, r0, r2, ror r3
     6a4:	0ad81500 	beq	ff605aac <__bss_end+0xff5fcacc>
     6a8:	31060000 	mrscc	r0, (UNDEF: 6)
     6ac:	0004380e 	andeq	r3, r4, lr, lsl #16
     6b0:	0001a700 	andeq	sl, r1, r0, lsl #14
     6b4:	0003e900 	andeq	lr, r3, r0, lsl #18
     6b8:	0003f400 	andeq	pc, r3, r0, lsl #8
     6bc:	06051300 	streq	r1, [r5], -r0, lsl #6
     6c0:	78140000 	ldmdavc	r4, {}	; <UNPREDICTABLE>
     6c4:	00000003 	andeq	r0, r0, r3
     6c8:	000b2616 	andeq	r2, fp, r6, lsl r6
     6cc:	1d350600 	ldcne	6, cr0, [r5, #-0]
     6d0:	00000aae 	andeq	r0, r0, lr, lsr #21
     6d4:	00000372 	andeq	r0, r0, r2, ror r3
     6d8:	00040d02 	andeq	r0, r4, r2, lsl #26
     6dc:	00041300 	andeq	r1, r4, r0, lsl #6
     6e0:	06051300 	streq	r1, [r5], -r0, lsl #6
     6e4:	16000000 	strne	r0, [r0], -r0
     6e8:	000007a4 	andeq	r0, r0, r4, lsr #15
     6ec:	bf1d3706 	svclt	0x001d3706
     6f0:	72000009 	andvc	r0, r0, #9
     6f4:	02000003 	andeq	r0, r0, #3
     6f8:	0000042c 	andeq	r0, r0, ip, lsr #8
     6fc:	00000432 	andeq	r0, r0, r2, lsr r4
     700:	00060513 	andeq	r0, r6, r3, lsl r5
     704:	b5170000 	ldrlt	r0, [r7, #-0]
     708:	06000008 	streq	r0, [r0], -r8
     70c:	061e3139 			; <UNDEFINED> instruction: 0x061e3139
     710:	020c0000 	andeq	r0, ip, #0
     714:	00058316 	andeq	r8, r5, r6, lsl r3
     718:	093c0600 	ldmdbeq	ip!, {r9, sl}
     71c:	00000c38 	andeq	r0, r0, r8, lsr ip
     720:	00000605 	andeq	r0, r0, r5, lsl #12
     724:	00045901 	andeq	r5, r4, r1, lsl #18
     728:	00045f00 	andeq	r5, r4, r0, lsl #30
     72c:	06051300 	streq	r1, [r5], -r0, lsl #6
     730:	16000000 	strne	r0, [r0], -r0
     734:	0000052d 	andeq	r0, r0, sp, lsr #10
     738:	8f123f06 	svchi	0x00123f06
     73c:	4800000b 	stmdami	r0, {r0, r1, r3}
     740:	01000000 	mrseq	r0, (UNDEF: 0)
     744:	00000478 	andeq	r0, r0, r8, ror r4
     748:	0000048d 	andeq	r0, r0, sp, lsl #9
     74c:	00060513 	andeq	r0, r6, r3, lsl r5
     750:	06271400 	strteq	r1, [r7], -r0, lsl #8
     754:	59140000 	ldmdbpl	r4, {}	; <UNPREDICTABLE>
     758:	14000000 	strne	r0, [r0], #-0
     75c:	000001a7 	andeq	r0, r0, r7, lsr #3
     760:	0ae71800 	beq	ff9c6768 <__bss_end+0xff9bd788>
     764:	42060000 	andmi	r0, r6, #0
     768:	00093d0e 	andeq	r3, r9, lr, lsl #26
     76c:	04a20100 	strteq	r0, [r2], #256	; 0x100
     770:	04a80000 	strteq	r0, [r8], #0
     774:	05130000 	ldreq	r0, [r3, #-0]
     778:	00000006 	andeq	r0, r0, r6
     77c:	00073116 	andeq	r3, r7, r6, lsl r1
     780:	17450600 	strbne	r0, [r5, -r0, lsl #12]
     784:	000004a3 	andeq	r0, r0, r3, lsr #9
     788:	00000378 	andeq	r0, r0, r8, ror r3
     78c:	0004c101 	andeq	ip, r4, r1, lsl #2
     790:	0004c700 	andeq	ip, r4, r0, lsl #14
     794:	062d1300 	strteq	r1, [sp], -r0, lsl #6
     798:	16000000 	strne	r0, [r0], -r0
     79c:	000004d6 	ldrdeq	r0, [r0], -r6
     7a0:	6b174806 	blvs	5d27c0 <__bss_end+0x5c97e0>
     7a4:	7800000a 	stmdavc	r0, {r1, r3}
     7a8:	01000003 	tsteq	r0, r3
     7ac:	000004e0 	andeq	r0, r0, r0, ror #9
     7b0:	000004eb 	andeq	r0, r0, fp, ror #9
     7b4:	00062d13 	andeq	r2, r6, r3, lsl sp
     7b8:	00481400 	subeq	r1, r8, r0, lsl #8
     7bc:	18000000 	stmdane	r0, {}	; <UNPREDICTABLE>
     7c0:	00000bfc 	strdeq	r0, [r0], -ip
     7c4:	040e4b06 	streq	r4, [lr], #-2822	; 0xfffff4fa
     7c8:	01000004 	tsteq	r0, r4
     7cc:	00000500 	andeq	r0, r0, r0, lsl #10
     7d0:	00000506 	andeq	r0, r0, r6, lsl #10
     7d4:	00060513 	andeq	r0, r6, r3, lsl r5
     7d8:	d8160000 	ldmdale	r6, {}	; <UNPREDICTABLE>
     7dc:	0600000a 	streq	r0, [r0], -sl
     7e0:	06720e4d 	ldrbteq	r0, [r2], -sp, asr #28
     7e4:	01a70000 			; <UNDEFINED> instruction: 0x01a70000
     7e8:	1f010000 	svcne	0x00010000
     7ec:	2a000005 	bcs	808 <shift+0x808>
     7f0:	13000005 	movwne	r0, #5
     7f4:	00000605 	andeq	r0, r0, r5, lsl #12
     7f8:	00004814 	andeq	r4, r0, r4, lsl r8
     7fc:	57160000 	ldrpl	r0, [r6, -r0]
     800:	06000007 	streq	r0, [r0], -r7
     804:	095e1250 	ldmdbeq	lr, {r4, r6, r9, ip}^
     808:	00480000 	subeq	r0, r8, r0
     80c:	43010000 	movwmi	r0, #4096	; 0x1000
     810:	4e000005 	cdpmi	0, 0, cr0, cr0, cr5, {0}
     814:	13000005 	movwne	r0, #5
     818:	00000605 	andeq	r0, r0, r5, lsl #12
     81c:	0001ae14 	andeq	sl, r1, r4, lsl lr
     820:	6e160000 	cdpvs	0, 1, cr0, cr6, cr0, {0}
     824:	06000004 	streq	r0, [r0], -r4
     828:	06fb0e53 	usateq	r0, #27, r3, asr #28
     82c:	01a70000 			; <UNDEFINED> instruction: 0x01a70000
     830:	67010000 	strvs	r0, [r1, -r0]
     834:	72000005 	andvc	r0, r0, #5
     838:	13000005 	movwne	r0, #5
     83c:	00000605 	andeq	r0, r0, r5, lsl #12
     840:	00004814 	andeq	r4, r0, r4, lsl r8
     844:	7e180000 	cdpvc	0, 1, cr0, cr8, cr0, {0}
     848:	06000007 	streq	r0, [r0], -r7
     84c:	0b380e56 	bleq	e041ac <__bss_end+0xdfb1cc>
     850:	87010000 	strhi	r0, [r1, -r0]
     854:	a6000005 	strge	r0, [r0], -r5
     858:	13000005 	movwne	r0, #5
     85c:	00000605 	andeq	r0, r0, r5, lsl #12
     860:	00008b14 	andeq	r8, r0, r4, lsl fp
     864:	00481400 	subeq	r1, r8, r0, lsl #8
     868:	48140000 	ldmdami	r4, {}	; <UNPREDICTABLE>
     86c:	14000000 	strne	r0, [r0], #-0
     870:	00000048 	andeq	r0, r0, r8, asr #32
     874:	00063314 	andeq	r3, r6, r4, lsl r3
     878:	98180000 	ldmdals	r8, {}	; <UNPREDICTABLE>
     87c:	0600000a 	streq	r0, [r0], -sl
     880:	05e70e58 	strbeq	r0, [r7, #3672]!	; 0xe58
     884:	bb010000 	bllt	4088c <__bss_end+0x378ac>
     888:	da000005 	ble	8a4 <shift+0x8a4>
     88c:	13000005 	movwne	r0, #5
     890:	00000605 	andeq	r0, r0, r5, lsl #12
     894:	0000c214 	andeq	ip, r0, r4, lsl r2
     898:	00481400 	subeq	r1, r8, r0, lsl #8
     89c:	48140000 	ldmdami	r4, {}	; <UNPREDICTABLE>
     8a0:	14000000 	strne	r0, [r0], #-0
     8a4:	00000048 	andeq	r0, r0, r8, asr #32
     8a8:	00063314 	andeq	r3, r6, r4, lsl r3
     8ac:	5d190000 	ldcpl	0, cr0, [r9, #-0]
     8b0:	06000005 	streq	r0, [r0], -r5
     8b4:	05a40e5b 	streq	r0, [r4, #3675]!	; 0xe5b
     8b8:	01a70000 			; <UNDEFINED> instruction: 0x01a70000
     8bc:	ef010000 	svc	0x00010000
     8c0:	13000005 	movwne	r0, #5
     8c4:	00000605 	andeq	r0, r0, r5, lsl #12
     8c8:	00031e14 	andeq	r1, r3, r4, lsl lr
     8cc:	06391400 	ldrteq	r1, [r9], -r0, lsl #8
     8d0:	00000000 	andeq	r0, r0, r0
     8d4:	00037e05 	andeq	r7, r3, r5, lsl #28
     8d8:	7e040c00 	cdpvc	12, 0, cr0, cr4, cr0, {0}
     8dc:	1a000003 	bne	8f0 <shift+0x8f0>
     8e0:	00000372 	andeq	r0, r0, r2, ror r3
     8e4:	00000618 	andeq	r0, r0, r8, lsl r6
     8e8:	0000061e 	andeq	r0, r0, lr, lsl r6
     8ec:	00060513 	andeq	r0, r6, r3, lsl r5
     8f0:	7e1b0000 	cdpvc	0, 1, cr0, cr11, cr0, {0}
     8f4:	0b000003 	bleq	908 <shift+0x908>
     8f8:	0c000006 	stceq	0, cr0, [r0], {6}
     8fc:	00003a04 	andeq	r3, r0, r4, lsl #20
     900:	00040c00 	andeq	r0, r4, r0, lsl #24
     904:	1c000006 	stcne	0, cr0, [r0], {6}
     908:	00006504 	andeq	r6, r0, r4, lsl #10
     90c:	1e041d00 	cdpne	13, 0, cr1, cr4, cr0, {0}
     910:	006c6168 	rsbeq	r6, ip, r8, ror #2
     914:	f50b0507 			; <UNDEFINED> instruction: 0xf50b0507
     918:	1f000006 	svcne	0x00000006
     91c:	000008ea 	andeq	r0, r0, sl, ror #17
     920:	60190707 	andsvs	r0, r9, r7, lsl #14
     924:	80000000 	andhi	r0, r0, r0
     928:	1f0ee6b2 	svcne	0x000ee6b2
     92c:	00000a15 	andeq	r0, r0, r5, lsl sl
     930:	671a0a07 	ldrvs	r0, [sl, -r7, lsl #20]
     934:	00000002 	andeq	r0, r0, r2
     938:	1f200000 	svcne	0x00200000
     93c:	000008c3 	andeq	r0, r0, r3, asr #17
     940:	671a0d07 	ldrvs	r0, [sl, -r7, lsl #26]
     944:	00000002 	andeq	r0, r0, r2
     948:	20202000 	eorcs	r2, r0, r0
     94c:	000009e5 	andeq	r0, r0, r5, ror #19
     950:	54151007 	ldrpl	r1, [r5], #-7
     954:	36000000 	strcc	r0, [r0], -r0
     958:	0005541f 	andeq	r5, r5, pc, lsl r4
     95c:	1a420700 	bne	1082564 <__bss_end+0x1079584>
     960:	00000267 	andeq	r0, r0, r7, ror #4
     964:	20215000 	eorcs	r5, r1, r0
     968:	0006be1f 	andeq	fp, r6, pc, lsl lr
     96c:	1a710700 	bne	1c42574 <__bss_end+0x1c39594>
     970:	00000267 	andeq	r0, r0, r7, ror #4
     974:	2000b200 	andcs	fp, r0, r0, lsl #4
     978:	0004f31f 	andeq	pc, r4, pc, lsl r3	; <UNPREDICTABLE>
     97c:	1aa40700 	bne	fe902584 <__bss_end+0xfe8f95a4>
     980:	00000267 	andeq	r0, r0, r7, ror #4
     984:	2000b400 	andcs	fp, r0, r0, lsl #8
     988:	0007271f 	andeq	r2, r7, pc, lsl r7
     98c:	1ab30700 	bne	fecc2594 <__bss_end+0xfecb95b4>
     990:	00000267 	andeq	r0, r0, r7, ror #4
     994:	20104000 	andscs	r4, r0, r0
     998:	0006a21f 	andeq	sl, r6, pc, lsl r2
     99c:	1abe0700 	bne	fef825a4 <__bss_end+0xfef795c4>
     9a0:	00000267 	andeq	r0, r0, r7, ror #4
     9a4:	20205000 	eorcs	r5, r0, r0
     9a8:	0006d81f 	andeq	sp, r6, pc, lsl r8
     9ac:	1abf0700 	bne	fefc25b4 <__bss_end+0xfefb95d4>
     9b0:	00000267 	andeq	r0, r0, r7, ror #4
     9b4:	20804000 	addcs	r4, r0, r0
     9b8:	0004861f 	andeq	r8, r4, pc, lsl r6
     9bc:	1ac00700 	bne	ff0025c4 <__bss_end+0xfeff95e4>
     9c0:	00000267 	andeq	r0, r0, r7, ror #4
     9c4:	20805000 	addcs	r5, r0, r0
     9c8:	06472100 	strbeq	r2, [r7], -r0, lsl #2
     9cc:	57210000 	strpl	r0, [r1, -r0]!
     9d0:	21000006 	tstcs	r0, r6
     9d4:	00000667 	andeq	r0, r0, r7, ror #12
     9d8:	00067721 	andeq	r7, r6, r1, lsr #14
     9dc:	06842100 	streq	r2, [r4], r0, lsl #2
     9e0:	94210000 	strtls	r0, [r1], #-0
     9e4:	21000006 	tstcs	r0, r6
     9e8:	000006a4 	andeq	r0, r0, r4, lsr #13
     9ec:	0006b421 	andeq	fp, r6, r1, lsr #8
     9f0:	06c42100 	strbeq	r2, [r4], r0, lsl #2
     9f4:	d4210000 	strtle	r0, [r1], #-0
     9f8:	21000006 	tstcs	r0, r6
     9fc:	000006e4 	andeq	r0, r0, r4, ror #13
     a00:	0009fe0a 	andeq	pc, r9, sl, lsl #28
     a04:	14080800 	strne	r0, [r8], #-2048	; 0xfffff800
     a08:	00000054 	andeq	r0, r0, r4, asr r0
     a0c:	8f300305 	svchi	0x00300305
     a10:	ad0a0000 	stcge	0, cr0, [sl, #-0]
     a14:	01000009 	tsteq	r0, r9
     a18:	0054140d 	subseq	r1, r4, sp, lsl #8
     a1c:	03050000 	movweq	r0, #20480	; 0x5000
     a20:	00008f34 	andeq	r8, r0, r4, lsr pc
     a24:	0005940a 	andeq	r9, r5, sl, lsl #8
     a28:	140e0100 	strne	r0, [lr], #-256	; 0xffffff00
     a2c:	00000054 	andeq	r0, r0, r4, asr r0
     a30:	8f380305 	svchi	0x00380305
     a34:	78220000 	stmdavc	r2!, {}	; <UNPREDICTABLE>
     a38:	01000008 	tsteq	r0, r8
     a3c:	00480a10 	subeq	r0, r8, r0, lsl sl
     a40:	03050000 	movweq	r0, #20480	; 0x5000
     a44:	00008fc4 	andeq	r8, r0, r4, asr #31
     a48:	000c1d22 	andeq	r1, ip, r2, lsr #26
     a4c:	13100100 	tstne	r0, #0, 2
     a50:	00000048 	andeq	r0, r0, r8, asr #32
     a54:	8fc80305 	svchi	0x00c80305
     a58:	81220000 			; <UNDEFINED> instruction: 0x81220000
     a5c:	01000004 	tsteq	r0, r4
     a60:	00481910 	subeq	r1, r8, r0, lsl r9
     a64:	03050000 	movweq	r0, #20480	; 0x5000
     a68:	00008fcc 	andeq	r8, r0, ip, asr #31
     a6c:	000c2d23 	andeq	r2, ip, r3, lsr #26
     a70:	051e0100 	ldreq	r0, [lr, #-256]	; 0xffffff00
     a74:	00000033 	andeq	r0, r0, r3, lsr r0
     a78:	000082bc 			; <UNDEFINED> instruction: 0x000082bc
     a7c:	000000f8 	strdeq	r0, [r0], -r8
     a80:	08259c01 	stmdaeq	r5!, {r0, sl, fp, ip, pc}
     a84:	18240000 	stmdane	r4!, {}	; <UNPREDICTABLE>
     a88:	0100000c 	tsteq	r0, ip
     a8c:	00330e1e 	eorseq	r0, r3, lr, lsl lr
     a90:	91030000 	mrsls	r0, (UNDEF: 3)
     a94:	8a247fbc 	bhi	92098c <__bss_end+0x9179ac>
     a98:	0100000b 	tsteq	r0, fp
     a9c:	08251b1e 	stmdaeq	r5!, {r1, r2, r3, r4, r8, r9, fp, ip}
     aa0:	91030000 	mrsls	r0, (UNDEF: 3)
     aa4:	ee257fb8 	mcr	15, 1, r7, cr5, cr8, {5}
     aa8:	01000004 	tsteq	r0, r4
     aac:	08310a20 	ldmdaeq	r1!, {r5, r9, fp}
     ab0:	91020000 	mrsls	r0, (UNDEF: 2)
     ab4:	04e92564 	strbteq	r2, [r9], #1380	; 0x564
     ab8:	20010000 	andcs	r0, r1, r0
     abc:	00084113 	andeq	r4, r8, r3, lsl r1
     ac0:	44910200 	ldrmi	r0, [r1], #512	; 0x200
     ac4:	00090b26 	andeq	r0, r9, r6, lsr #22
     ac8:	0f210100 	svceq	0x00210100
     acc:	00000851 	andeq	r0, r0, r1, asr r8
     ad0:	0008ae25 	andeq	sl, r8, r5, lsr #28
     ad4:	09220100 	stmdbeq	r2!, {r8}
     ad8:	00000033 	andeq	r0, r0, r3, lsr r0
     adc:	27689102 	strbcs	r9, [r8, -r2, lsl #2]!
     ae0:	00008318 	andeq	r8, r0, r8, lsl r3
     ae4:	0000007c 	andeq	r0, r0, ip, ror r0
     ae8:	00090b25 	andeq	r0, r9, r5, lsr #22
     aec:	132d0100 			; <UNDEFINED> instruction: 0x132d0100
     af0:	00000851 	andeq	r0, r0, r1, asr r8
     af4:	006c9102 	rsbeq	r9, ip, r2, lsl #2
     af8:	2b040c00 	blcs	103b00 <__bss_end+0xfab20>
     afc:	0c000008 	stceq	0, cr0, [r0], {8}
     b00:	00002504 	andeq	r2, r0, r4, lsl #10
     b04:	00250f00 	eoreq	r0, r5, r0, lsl #30
     b08:	08410000 	stmdaeq	r1, {}^	; <UNPREDICTABLE>
     b0c:	59100000 	ldmdbpl	r0, {}	; <UNPREDICTABLE>
     b10:	03000000 	movweq	r0, #0
     b14:	00250f00 	eoreq	r0, r5, r0, lsl #30
     b18:	08510000 	ldmdaeq	r1, {}^	; <UNPREDICTABLE>
     b1c:	59100000 	ldmdbpl	r0, {}	; <UNPREDICTABLE>
     b20:	1f000000 	svcne	0x00000000
     b24:	48040c00 	stmdami	r4, {sl, fp}
     b28:	28000000 	stmdacs	r0, {}	; <UNPREDICTABLE>
     b2c:	00000a0a 	andeq	r0, r0, sl, lsl #20
     b30:	dc061901 			; <UNDEFINED> instruction: 0xdc061901
     b34:	8400000b 	strhi	r0, [r0], #-11
     b38:	38000082 	stmdacc	r0, {r1, r7}
     b3c:	01000000 	mrseq	r0, (UNDEF: 0)
     b40:	0008819c 	muleq	r8, ip, r1
     b44:	04ee2400 	strbteq	r2, [lr], #1024	; 0x400
     b48:	19010000 	stmdbne	r1, {}	; <UNPREDICTABLE>
     b4c:	00082b17 	andeq	r2, r8, r7, lsl fp
     b50:	74910200 	ldrvc	r0, [r1], #512	; 0x200
     b54:	0b322900 	bleq	c8af5c <__bss_end+0xc81f7c>
     b58:	12010000 	andne	r0, r1, #0
     b5c:	00082d06 	andeq	r2, r8, r6, lsl #26
     b60:	00822c00 	addeq	r2, r2, r0, lsl #24
     b64:	00005800 	andeq	r5, r0, r0, lsl #16
     b68:	009c0100 	addseq	r0, ip, r0, lsl #2
     b6c:	00000b1f 	andeq	r0, r0, pc, lsl fp
     b70:	04670004 	strbteq	r0, [r7], #-4
     b74:	01040000 	mrseq	r0, (UNDEF: 4)
     b78:	00000f9a 	muleq	r0, sl, pc	; <UNPREDICTABLE>
     b7c:	000e7304 	andeq	r7, lr, r4, lsl #6
     b80:	000c6200 	andeq	r6, ip, r0, lsl #4
     b84:	0083b400 	addeq	fp, r3, r0, lsl #8
     b88:	00045c00 	andeq	r5, r4, r0, lsl #24
     b8c:	00055b00 	andeq	r5, r5, r0, lsl #22
     b90:	08010200 	stmdaeq	r1, {r9}
     b94:	000009a8 	andeq	r0, r0, r8, lsr #19
     b98:	00002503 	andeq	r2, r0, r3, lsl #10
     b9c:	05020200 	streq	r0, [r2, #-512]	; 0xfffffe00
     ba0:	000009f4 	strdeq	r0, [r0], -r4
     ba4:	69050404 	stmdbvs	r5, {r2, sl}
     ba8:	0200746e 	andeq	r7, r0, #1845493760	; 0x6e000000
     bac:	099f0801 	ldmibeq	pc, {r0, fp}	; <UNPREDICTABLE>
     bb0:	02020000 	andeq	r0, r2, #0
     bb4:	00079107 	andeq	r9, r7, r7, lsl #2
     bb8:	0a2d0500 	beq	b41fc0 <__bss_end+0xb38fe0>
     bbc:	09070000 	stmdbeq	r7, {}	; <UNPREDICTABLE>
     bc0:	00005e07 	andeq	r5, r0, r7, lsl #28
     bc4:	004d0300 	subeq	r0, sp, r0, lsl #6
     bc8:	04020000 	streq	r0, [r2], #-0
     bcc:	00074a07 	andeq	r4, r7, r7, lsl #20
     bd0:	06330600 	ldrteq	r0, [r3], -r0, lsl #12
     bd4:	02080000 	andeq	r0, r8, #0
     bd8:	008b0806 	addeq	r0, fp, r6, lsl #16
     bdc:	72070000 	andvc	r0, r7, #0
     be0:	08020030 	stmdaeq	r2, {r4, r5}
     be4:	00004d0e 	andeq	r4, r0, lr, lsl #26
     be8:	72070000 	andvc	r0, r7, #0
     bec:	09020031 	stmdbeq	r2, {r0, r4, r5}
     bf0:	00004d0e 	andeq	r4, r0, lr, lsl #26
     bf4:	08000400 	stmdaeq	r0, {sl}
     bf8:	00000f24 	andeq	r0, r0, r4, lsr #30
     bfc:	00380405 	eorseq	r0, r8, r5, lsl #8
     c00:	0d020000 	stceq	0, cr0, [r2, #-0]
     c04:	0000a90c 	andeq	sl, r0, ip, lsl #18
     c08:	4b4f0900 	blmi	13c3010 <__bss_end+0x13ba030>
     c0c:	100a0000 	andne	r0, sl, r0
     c10:	0100000d 	tsteq	r0, sp
     c14:	04fe0800 	ldrbteq	r0, [lr], #2048	; 0x800
     c18:	04050000 	streq	r0, [r5], #-0
     c1c:	00000038 	andeq	r0, r0, r8, lsr r0
     c20:	e00c1e02 	and	r1, ip, r2, lsl #28
     c24:	0a000000 	beq	c2c <shift+0xc2c>
     c28:	0000069a 	muleq	r0, sl, r6
     c2c:	0c520a00 	mrrceq	10, 0, r0, r2, cr0
     c30:	0a010000 	beq	40c38 <__bss_end+0x37c58>
     c34:	00000c32 	andeq	r0, r0, r2, lsr ip
     c38:	08270a02 	stmdaeq	r7!, {r1, r9, fp}
     c3c:	0a030000 	beq	c0c44 <__bss_end+0xb7c64>
     c40:	0000092e 	andeq	r0, r0, lr, lsr #18
     c44:	06630a04 	strbteq	r0, [r3], -r4, lsl #20
     c48:	00050000 	andeq	r0, r5, r0
     c4c:	000bc408 	andeq	ip, fp, r8, lsl #8
     c50:	38040500 	stmdacc	r4, {r8, sl}
     c54:	02000000 	andeq	r0, r0, #0
     c58:	011d0c3f 	tsteq	sp, pc, lsr ip
     c5c:	ff0a0000 			; <UNDEFINED> instruction: 0xff0a0000
     c60:	00000003 	andeq	r0, r0, r3
     c64:	0005130a 	andeq	r1, r5, sl, lsl #6
     c68:	210a0100 	mrscs	r0, (UNDEF: 26)
     c6c:	02000009 	andeq	r0, r0, #9
     c70:	000c120a 	andeq	r1, ip, sl, lsl #4
     c74:	5c0a0300 	stcpl	3, cr0, [sl], {-0}
     c78:	0400000c 	streq	r0, [r0], #-12
     c7c:	0008e30a 	andeq	lr, r8, sl, lsl #6
     c80:	b10a0500 	tstlt	sl, r0, lsl #10
     c84:	06000007 	streq	r0, [r0], -r7
     c88:	104b0800 	subne	r0, fp, r0, lsl #16
     c8c:	04050000 	streq	r0, [r5], #-0
     c90:	00000038 	andeq	r0, r0, r8, lsr r0
     c94:	480c6602 	stmdami	ip, {r1, r9, sl, sp, lr}
     c98:	0a000001 	beq	ca4 <shift+0xca4>
     c9c:	00000e68 	andeq	r0, r0, r8, ror #28
     ca0:	0d6d0a00 	vpusheq	{s1-s0}
     ca4:	0a010000 	beq	40cac <__bss_end+0x37ccc>
     ca8:	00000eed 	andeq	r0, r0, sp, ror #29
     cac:	0d920a02 	vldreq	s0, [r2, #8]
     cb0:	00030000 	andeq	r0, r3, r0
     cb4:	0008fd0b 	andeq	pc, r8, fp, lsl #26
     cb8:	14050300 	strne	r0, [r5], #-768	; 0xfffffd00
     cbc:	00000059 	andeq	r0, r0, r9, asr r0
     cc0:	8f780305 	svchi	0x00780305
     cc4:	100b0000 	andne	r0, fp, r0
     cc8:	03000009 	movweq	r0, #9
     ccc:	00591406 	subseq	r1, r9, r6, lsl #8
     cd0:	03050000 	movweq	r0, #20480	; 0x5000
     cd4:	00008f7c 	andeq	r8, r0, ip, ror pc
     cd8:	0008cd0b 	andeq	ip, r8, fp, lsl #26
     cdc:	1a070400 	bne	1c1ce4 <__bss_end+0x1b8d04>
     ce0:	00000059 	andeq	r0, r0, r9, asr r0
     ce4:	8f800305 	svchi	0x00800305
     ce8:	420b0000 	andmi	r0, fp, #0
     cec:	04000005 	streq	r0, [r0], #-5
     cf0:	00591a09 	subseq	r1, r9, r9, lsl #20
     cf4:	03050000 	movweq	r0, #20480	; 0x5000
     cf8:	00008f84 	andeq	r8, r0, r4, lsl #31
     cfc:	0009910b 	andeq	r9, r9, fp, lsl #2
     d00:	1a0b0400 	bne	2c1d08 <__bss_end+0x2b8d28>
     d04:	00000059 	andeq	r0, r0, r9, asr r0
     d08:	8f880305 	svchi	0x00880305
     d0c:	6b0b0000 	blvs	2c0d14 <__bss_end+0x2b7d34>
     d10:	04000007 	streq	r0, [r0], #-7
     d14:	00591a0d 	subseq	r1, r9, sp, lsl #20
     d18:	03050000 	movweq	r0, #20480	; 0x5000
     d1c:	00008f8c 	andeq	r8, r0, ip, lsl #31
     d20:	00064c0b 	andeq	r4, r6, fp, lsl #24
     d24:	1a0f0400 	bne	3c1d2c <__bss_end+0x3b8d4c>
     d28:	00000059 	andeq	r0, r0, r9, asr r0
     d2c:	8f900305 	svchi	0x00900305
     d30:	9e080000 	cdpls	0, 0, cr0, cr8, cr0, {0}
     d34:	05000010 	streq	r0, [r0, #-16]
     d38:	00003804 	andeq	r3, r0, r4, lsl #16
     d3c:	0c1b0400 	cfldrseq	mvf0, [fp], {-0}
     d40:	000001eb 	andeq	r0, r0, fp, ror #3
     d44:	000a550a 	andeq	r5, sl, sl, lsl #10
     d48:	220a0000 	andcs	r0, sl, #0
     d4c:	0100000c 	tsteq	r0, ip
     d50:	00091c0a 	andeq	r1, r9, sl, lsl #24
     d54:	0c000200 	sfmeq	f0, 4, [r0], {-0}
     d58:	0000098b 	andeq	r0, r0, fp, lsl #19
     d5c:	37020102 	strcc	r0, [r2, -r2, lsl #2]
     d60:	0d000008 	stceq	0, cr0, [r0, #-32]	; 0xffffffe0
     d64:	00002c04 	andeq	r2, r0, r4, lsl #24
     d68:	eb040d00 	bl	104170 <__bss_end+0xfb190>
     d6c:	0b000001 	bleq	d78 <shift+0xd78>
     d70:	000006e2 	andeq	r0, r0, r2, ror #13
     d74:	59140405 	ldmdbpl	r4, {r0, r2, sl}
     d78:	05000000 	streq	r0, [r0, #-0]
     d7c:	008f9403 	addeq	r9, pc, r3, lsl #8
     d80:	03f40b00 	mvnseq	r0, #0, 22
     d84:	07050000 	streq	r0, [r5, -r0]
     d88:	00005914 	andeq	r5, r0, r4, lsl r9
     d8c:	98030500 	stmdals	r3, {r8, sl}
     d90:	0b00008f 	bleq	fd4 <shift+0xfd4>
     d94:	00000570 	andeq	r0, r0, r0, ror r5
     d98:	59140a05 	ldmdbpl	r4, {r0, r2, r9, fp}
     d9c:	05000000 	streq	r0, [r0, #-0]
     da0:	008f9c03 	addeq	r9, pc, r3, lsl #24
     da4:	086c0800 	stmdaeq	ip!, {fp}^
     da8:	04050000 	streq	r0, [r5], #-0
     dac:	00000038 	andeq	r0, r0, r8, lsr r0
     db0:	700c0d05 	andvc	r0, ip, r5, lsl #26
     db4:	09000002 	stmdbeq	r0, {r1}
     db8:	0077654e 	rsbseq	r6, r7, lr, asr #10
     dbc:	08630a00 	stmdaeq	r3!, {r9, fp}^
     dc0:	0a010000 	beq	40dc8 <__bss_end+0x37de8>
     dc4:	00000a25 	andeq	r0, r0, r5, lsr #20
     dc8:	08460a02 	stmdaeq	r6, {r1, r9, fp}^
     dcc:	0a030000 	beq	c0dd4 <__bss_end+0xb7df4>
     dd0:	00000819 	andeq	r0, r0, r9, lsl r8
     dd4:	09270a04 	stmdbeq	r7!, {r2, r9, fp}
     dd8:	00050000 	andeq	r0, r5, r0
     ddc:	00065606 	andeq	r5, r6, r6, lsl #12
     de0:	1b051000 	blne	144de8 <__bss_end+0x13be08>
     de4:	0002af08 	andeq	sl, r2, r8, lsl #30
     de8:	726c0700 	rsbvc	r0, ip, #0, 14
     dec:	131d0500 	tstne	sp, #0, 10
     df0:	000002af 	andeq	r0, r0, pc, lsr #5
     df4:	70730700 	rsbsvc	r0, r3, r0, lsl #14
     df8:	131e0500 	tstne	lr, #0, 10
     dfc:	000002af 	andeq	r0, r0, pc, lsr #5
     e00:	63700704 	cmnvs	r0, #4, 14	; 0x100000
     e04:	131f0500 	tstne	pc, #0, 10
     e08:	000002af 	andeq	r0, r0, pc, lsr #5
     e0c:	066c0e08 	strbteq	r0, [ip], -r8, lsl #28
     e10:	20050000 	andcs	r0, r5, r0
     e14:	0002af13 	andeq	sl, r2, r3, lsl pc
     e18:	02000c00 	andeq	r0, r0, #0, 24
     e1c:	07450704 	strbeq	r0, [r5, -r4, lsl #14]
     e20:	61060000 	mrsvs	r0, (UNDEF: 6)
     e24:	70000004 	andvc	r0, r0, r4
     e28:	46082805 	strmi	r2, [r8], -r5, lsl #16
     e2c:	0e000003 	cdpeq	0, 0, cr0, cr0, cr3, {0}
     e30:	00000a49 	andeq	r0, r0, r9, asr #20
     e34:	70122a05 	andsvc	r2, r2, r5, lsl #20
     e38:	00000002 	andeq	r0, r0, r2
     e3c:	64697007 	strbtvs	r7, [r9], #-7
     e40:	122b0500 	eorne	r0, fp, #0, 10
     e44:	0000005e 	andeq	r0, r0, lr, asr r0
     e48:	053c0e10 	ldreq	r0, [ip, #-3600]!	; 0xfffff1f0
     e4c:	2c050000 	stccs	0, cr0, [r5], {-0}
     e50:	00023911 	andeq	r3, r2, r1, lsl r9
     e54:	800e1400 	andhi	r1, lr, r0, lsl #8
     e58:	05000008 	streq	r0, [r0, #-8]
     e5c:	005e122d 	subseq	r1, lr, sp, lsr #4
     e60:	0e180000 	cdpeq	0, 1, cr0, cr8, cr0, {0}
     e64:	0000088e 	andeq	r0, r0, lr, lsl #17
     e68:	5e122e05 	cdppl	14, 1, cr2, cr2, cr5, {0}
     e6c:	1c000000 	stcne	0, cr0, [r0], {-0}
     e70:	00063f0e 	andeq	r3, r6, lr, lsl #30
     e74:	0c2f0500 	cfstr32eq	mvfx0, [pc], #-0	; e7c <shift+0xe7c>
     e78:	00000346 	andeq	r0, r0, r6, asr #6
     e7c:	08a40e20 	stmiaeq	r4!, {r5, r9, sl, fp}
     e80:	30050000 	andcc	r0, r5, r0
     e84:	00003809 	andeq	r3, r0, r9, lsl #16
     e88:	5f0e6000 	svcpl	0x000e6000
     e8c:	0500000a 	streq	r0, [r0, #-10]
     e90:	004d0e31 	subeq	r0, sp, r1, lsr lr
     e94:	0e640000 	cdpeq	0, 6, cr0, cr4, cr0, {0}
     e98:	000006b5 			; <UNDEFINED> instruction: 0x000006b5
     e9c:	4d0e3305 	stcmi	3, cr3, [lr, #-20]	; 0xffffffec
     ea0:	68000000 	stmdavs	r0, {}	; <UNPREDICTABLE>
     ea4:	0006ac0e 	andeq	sl, r6, lr, lsl #24
     ea8:	0e340500 	cfabs32eq	mvfx0, mvfx4
     eac:	0000004d 	andeq	r0, r0, sp, asr #32
     eb0:	fd0f006c 	stc2	0, cr0, [pc, #-432]	; d08 <shift+0xd08>
     eb4:	56000001 	strpl	r0, [r0], -r1
     eb8:	10000003 	andne	r0, r0, r3
     ebc:	0000005e 	andeq	r0, r0, lr, asr r0
     ec0:	ed0b000f 	stc	0, cr0, [fp, #-60]	; 0xffffffc4
     ec4:	0600000b 	streq	r0, [r0], -fp
     ec8:	0059140a 	subseq	r1, r9, sl, lsl #8
     ecc:	03050000 	movweq	r0, #20480	; 0x5000
     ed0:	00008fa0 	andeq	r8, r0, r0, lsr #31
     ed4:	00084e08 	andeq	r4, r8, r8, lsl #28
     ed8:	38040500 	stmdacc	r4, {r8, sl}
     edc:	06000000 	streq	r0, [r0], -r0
     ee0:	03870c0d 	orreq	r0, r7, #3328	; 0xd00
     ee4:	180a0000 	stmdane	sl, {}	; <UNPREDICTABLE>
     ee8:	00000005 	andeq	r0, r0, r5
     eec:	0003e90a 	andeq	lr, r3, sl, lsl #18
     ef0:	03000100 	movweq	r0, #256	; 0x100
     ef4:	00000368 	andeq	r0, r0, r8, ror #6
     ef8:	000dfa08 	andeq	pc, sp, r8, lsl #20
     efc:	38040500 	stmdacc	r4, {r8, sl}
     f00:	06000000 	streq	r0, [r0], -r0
     f04:	03ab0c14 			; <UNDEFINED> instruction: 0x03ab0c14
     f08:	b30a0000 	movwlt	r0, #40960	; 0xa000
     f0c:	0000000c 	andeq	r0, r0, ip
     f10:	000edf0a 	andeq	sp, lr, sl, lsl #30
     f14:	03000100 	movweq	r0, #256	; 0x100
     f18:	0000038c 	andeq	r0, r0, ip, lsl #7
     f1c:	000b1306 	andeq	r1, fp, r6, lsl #6
     f20:	1b060c00 	blne	183f28 <__bss_end+0x17af48>
     f24:	0003e508 	andeq	lr, r3, r8, lsl #10
     f28:	04330e00 	ldrteq	r0, [r3], #-3584	; 0xfffff200
     f2c:	1d060000 	stcne	0, cr0, [r6, #-0]
     f30:	0003e519 	andeq	lr, r3, r9, lsl r5
     f34:	d10e0000 	mrsle	r0, (UNDEF: 14)
     f38:	06000004 	streq	r0, [r0], -r4
     f3c:	03e5191e 	mvneq	r1, #491520	; 0x78000
     f40:	0e040000 	cdpeq	0, 0, cr0, cr4, cr0, {0}
     f44:	00000ad3 	ldrdeq	r0, [r0], -r3
     f48:	eb131f06 	bl	4c8b68 <__bss_end+0x4bfb88>
     f4c:	08000003 	stmdaeq	r0, {r0, r1}
     f50:	b0040d00 	andlt	r0, r4, r0, lsl #26
     f54:	0d000003 	stceq	0, cr0, [r0, #-12]
     f58:	0002b604 	andeq	fp, r2, r4, lsl #12
     f5c:	05831100 	streq	r1, [r3, #256]	; 0x100
     f60:	06140000 	ldreq	r0, [r4], -r0
     f64:	06730722 	ldrbteq	r0, [r3], -r2, lsr #14
     f68:	3c0e0000 	stccc	0, cr0, [lr], {-0}
     f6c:	06000008 	streq	r0, [r0], -r8
     f70:	004d1226 	subeq	r1, sp, r6, lsr #4
     f74:	0e000000 	cdpeq	0, 0, cr0, cr0, cr0, {0}
     f78:	00000490 	muleq	r0, r0, r4
     f7c:	e51d2906 	ldr	r2, [sp, #-2310]	; 0xfffff6fa
     f80:	04000003 	streq	r0, [r0], #-3
     f84:	000a360e 	andeq	r3, sl, lr, lsl #12
     f88:	1d2c0600 	stcne	6, cr0, [ip, #-0]
     f8c:	000003e5 	andeq	r0, r0, r5, ror #7
     f90:	0bba1208 	bleq	fee857b8 <__bss_end+0xfee7c7d8>
     f94:	2f060000 	svccs	0x00060000
     f98:	000af00e 	andeq	pc, sl, lr
     f9c:	00043900 	andeq	r3, r4, r0, lsl #18
     fa0:	00044400 	andeq	r4, r4, r0, lsl #8
     fa4:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
     fa8:	e5140000 	ldr	r0, [r4, #-0]
     fac:	00000003 	andeq	r0, r0, r3
     fb0:	000ad815 	andeq	sp, sl, r5, lsl r8
     fb4:	0e310600 	cfmsuba32eq	mvax0, mvax0, mvfx1, mvfx0
     fb8:	00000438 	andeq	r0, r0, r8, lsr r4
     fbc:	000001f0 	strdeq	r0, [r0], -r0	; <UNPREDICTABLE>
     fc0:	0000045c 	andeq	r0, r0, ip, asr r4
     fc4:	00000467 	andeq	r0, r0, r7, ror #8
     fc8:	00067813 	andeq	r7, r6, r3, lsl r8
     fcc:	03eb1400 	mvneq	r1, #0, 8
     fd0:	16000000 	strne	r0, [r0], -r0
     fd4:	00000b26 	andeq	r0, r0, r6, lsr #22
     fd8:	ae1d3506 	cfmul32ge	mvfx3, mvfx13, mvfx6
     fdc:	e500000a 	str	r0, [r0, #-10]
     fe0:	02000003 	andeq	r0, r0, #3
     fe4:	00000480 	andeq	r0, r0, r0, lsl #9
     fe8:	00000486 	andeq	r0, r0, r6, lsl #9
     fec:	00067813 	andeq	r7, r6, r3, lsl r8
     ff0:	a4160000 	ldrge	r0, [r6], #-0
     ff4:	06000007 	streq	r0, [r0], -r7
     ff8:	09bf1d37 	ldmibeq	pc!, {r0, r1, r2, r4, r5, r8, sl, fp, ip}	; <UNPREDICTABLE>
     ffc:	03e50000 	mvneq	r0, #0
    1000:	9f020000 	svcls	0x00020000
    1004:	a5000004 	strge	r0, [r0, #-4]
    1008:	13000004 	movwne	r0, #4
    100c:	00000678 	andeq	r0, r0, r8, ror r6
    1010:	08b51700 	ldmeq	r5!, {r8, r9, sl, ip}
    1014:	39060000 	stmdbcc	r6, {}	; <UNPREDICTABLE>
    1018:	00069131 	andeq	r9, r6, r1, lsr r1
    101c:	16020c00 	strne	r0, [r2], -r0, lsl #24
    1020:	00000583 	andeq	r0, r0, r3, lsl #11
    1024:	38093c06 	stmdacc	r9, {r1, r2, sl, fp, ip, sp}
    1028:	7800000c 	stmdavc	r0, {r2, r3}
    102c:	01000006 	tsteq	r0, r6
    1030:	000004cc 	andeq	r0, r0, ip, asr #9
    1034:	000004d2 	ldrdeq	r0, [r0], -r2
    1038:	00067813 	andeq	r7, r6, r3, lsl r8
    103c:	2d160000 	ldccs	0, cr0, [r6, #-0]
    1040:	06000005 	streq	r0, [r0], -r5
    1044:	0b8f123f 	bleq	fe3c5948 <__bss_end+0xfe3bc968>
    1048:	004d0000 	subeq	r0, sp, r0
    104c:	eb010000 	bl	41054 <__bss_end+0x38074>
    1050:	00000004 	andeq	r0, r0, r4
    1054:	13000005 	movwne	r0, #5
    1058:	00000678 	andeq	r0, r0, r8, ror r6
    105c:	00069a14 	andeq	r9, r6, r4, lsl sl
    1060:	005e1400 	subseq	r1, lr, r0, lsl #8
    1064:	f0140000 			; <UNDEFINED> instruction: 0xf0140000
    1068:	00000001 	andeq	r0, r0, r1
    106c:	000ae718 	andeq	lr, sl, r8, lsl r7
    1070:	0e420600 	cdpeq	6, 4, cr0, cr2, cr0, {0}
    1074:	0000093d 	andeq	r0, r0, sp, lsr r9
    1078:	00051501 	andeq	r1, r5, r1, lsl #10
    107c:	00051b00 	andeq	r1, r5, r0, lsl #22
    1080:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
    1084:	16000000 	strne	r0, [r0], -r0
    1088:	00000731 	andeq	r0, r0, r1, lsr r7
    108c:	a3174506 	tstge	r7, #25165824	; 0x1800000
    1090:	eb000004 	bl	10a8 <shift+0x10a8>
    1094:	01000003 	tsteq	r0, r3
    1098:	00000534 	andeq	r0, r0, r4, lsr r5
    109c:	0000053a 	andeq	r0, r0, sl, lsr r5
    10a0:	0006a013 	andeq	sl, r6, r3, lsl r0
    10a4:	d6160000 	ldrle	r0, [r6], -r0
    10a8:	06000004 	streq	r0, [r0], -r4
    10ac:	0a6b1748 	beq	1ac6dd4 <__bss_end+0x1abddf4>
    10b0:	03eb0000 	mvneq	r0, #0
    10b4:	53010000 	movwpl	r0, #4096	; 0x1000
    10b8:	5e000005 	cdppl	0, 0, cr0, cr0, cr5, {0}
    10bc:	13000005 	movwne	r0, #5
    10c0:	000006a0 	andeq	r0, r0, r0, lsr #13
    10c4:	00004d14 	andeq	r4, r0, r4, lsl sp
    10c8:	fc180000 	ldc2	0, cr0, [r8], {-0}
    10cc:	0600000b 	streq	r0, [r0], -fp
    10d0:	04040e4b 	streq	r0, [r4], #-3659	; 0xfffff1b5
    10d4:	73010000 	movwvc	r0, #4096	; 0x1000
    10d8:	79000005 	stmdbvc	r0, {r0, r2}
    10dc:	13000005 	movwne	r0, #5
    10e0:	00000678 	andeq	r0, r0, r8, ror r6
    10e4:	0ad81600 	beq	ff6068ec <__bss_end+0xff5fd90c>
    10e8:	4d060000 	stcmi	0, cr0, [r6, #-0]
    10ec:	0006720e 	andeq	r7, r6, lr, lsl #4
    10f0:	0001f000 	andeq	pc, r1, r0
    10f4:	05920100 	ldreq	r0, [r2, #256]	; 0x100
    10f8:	059d0000 	ldreq	r0, [sp]
    10fc:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
    1100:	14000006 	strne	r0, [r0], #-6
    1104:	0000004d 	andeq	r0, r0, sp, asr #32
    1108:	07571600 	ldrbeq	r1, [r7, -r0, lsl #12]
    110c:	50060000 	andpl	r0, r6, r0
    1110:	00095e12 	andeq	r5, r9, r2, lsl lr
    1114:	00004d00 	andeq	r4, r0, r0, lsl #26
    1118:	05b60100 	ldreq	r0, [r6, #256]!	; 0x100
    111c:	05c10000 	strbeq	r0, [r1]
    1120:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
    1124:	14000006 	strne	r0, [r0], #-6
    1128:	000001fd 	strdeq	r0, [r0], -sp
    112c:	046e1600 	strbteq	r1, [lr], #-1536	; 0xfffffa00
    1130:	53060000 	movwpl	r0, #24576	; 0x6000
    1134:	0006fb0e 	andeq	pc, r6, lr, lsl #22
    1138:	0001f000 	andeq	pc, r1, r0
    113c:	05da0100 	ldrbeq	r0, [sl, #256]	; 0x100
    1140:	05e50000 	strbeq	r0, [r5, #0]!
    1144:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
    1148:	14000006 	strne	r0, [r0], #-6
    114c:	0000004d 	andeq	r0, r0, sp, asr #32
    1150:	077e1800 	ldrbeq	r1, [lr, -r0, lsl #16]!
    1154:	56060000 	strpl	r0, [r6], -r0
    1158:	000b380e 	andeq	r3, fp, lr, lsl #16
    115c:	05fa0100 	ldrbeq	r0, [sl, #256]!	; 0x100
    1160:	06190000 	ldreq	r0, [r9], -r0
    1164:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
    1168:	14000006 	strne	r0, [r0], #-6
    116c:	000000a9 	andeq	r0, r0, r9, lsr #1
    1170:	00004d14 	andeq	r4, r0, r4, lsl sp
    1174:	004d1400 	subeq	r1, sp, r0, lsl #8
    1178:	4d140000 	ldcmi	0, cr0, [r4, #-0]
    117c:	14000000 	strne	r0, [r0], #-0
    1180:	000006a6 	andeq	r0, r0, r6, lsr #13
    1184:	0a981800 	beq	fe60718c <__bss_end+0xfe5fe1ac>
    1188:	58060000 	stmdapl	r6, {}	; <UNPREDICTABLE>
    118c:	0005e70e 	andeq	lr, r5, lr, lsl #14
    1190:	062e0100 	strteq	r0, [lr], -r0, lsl #2
    1194:	064d0000 	strbeq	r0, [sp], -r0
    1198:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
    119c:	14000006 	strne	r0, [r0], #-6
    11a0:	000000e0 	andeq	r0, r0, r0, ror #1
    11a4:	00004d14 	andeq	r4, r0, r4, lsl sp
    11a8:	004d1400 	subeq	r1, sp, r0, lsl #8
    11ac:	4d140000 	ldcmi	0, cr0, [r4, #-0]
    11b0:	14000000 	strne	r0, [r0], #-0
    11b4:	000006a6 	andeq	r0, r0, r6, lsr #13
    11b8:	055d1900 	ldrbeq	r1, [sp, #-2304]	; 0xfffff700
    11bc:	5b060000 	blpl	1811c4 <__bss_end+0x1781e4>
    11c0:	0005a40e 	andeq	sl, r5, lr, lsl #8
    11c4:	0001f000 	andeq	pc, r1, r0
    11c8:	06620100 	strbteq	r0, [r2], -r0, lsl #2
    11cc:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
    11d0:	14000006 	strne	r0, [r0], #-6
    11d4:	00000368 	andeq	r0, r0, r8, ror #6
    11d8:	0006ac14 	andeq	sl, r6, r4, lsl ip
    11dc:	03000000 	movweq	r0, #0
    11e0:	000003f1 	strdeq	r0, [r0], -r1
    11e4:	03f1040d 	mvnseq	r0, #218103808	; 0xd000000
    11e8:	e51a0000 	ldr	r0, [sl, #-0]
    11ec:	8b000003 	blhi	1200 <shift+0x1200>
    11f0:	91000006 	tstls	r0, r6
    11f4:	13000006 	movwne	r0, #6
    11f8:	00000678 	andeq	r0, r0, r8, ror r6
    11fc:	03f11b00 	mvnseq	r1, #0, 22
    1200:	067e0000 	ldrbteq	r0, [lr], -r0
    1204:	040d0000 	streq	r0, [sp], #-0
    1208:	0000003f 	andeq	r0, r0, pc, lsr r0
    120c:	0673040d 	ldrbteq	r0, [r3], -sp, lsl #8
    1210:	041c0000 	ldreq	r0, [ip], #-0
    1214:	00000065 	andeq	r0, r0, r5, rrx
    1218:	2c0f041d 	cfstrscs	mvf0, [pc], {29}
    121c:	be000000 	cdplt	0, 0, cr0, cr0, cr0, {0}
    1220:	10000006 	andne	r0, r0, r6
    1224:	0000005e 	andeq	r0, r0, lr, asr r0
    1228:	ae030009 	cdpge	0, 0, cr0, cr3, cr9, {0}
    122c:	1e000006 	cdpne	0, 0, cr0, cr0, cr6, {0}
    1230:	00000d5c 	andeq	r0, r0, ip, asr sp
    1234:	be0ca401 	cdplt	4, 0, cr10, cr12, cr1, {0}
    1238:	05000006 	streq	r0, [r0, #-6]
    123c:	008fa403 	addeq	sl, pc, r3, lsl #8
    1240:	0ccc1f00 	stcleq	15, cr1, [ip], {0}
    1244:	a6010000 	strge	r0, [r1], -r0
    1248:	000dee0a 	andeq	lr, sp, sl, lsl #28
    124c:	00004d00 	andeq	r4, r0, r0, lsl #26
    1250:	00876000 	addeq	r6, r7, r0
    1254:	0000b000 	andeq	fp, r0, r0
    1258:	339c0100 	orrscc	r0, ip, #0, 2
    125c:	20000007 	andcs	r0, r0, r7
    1260:	00001081 	andeq	r1, r0, r1, lsl #1
    1264:	f71ba601 			; <UNDEFINED> instruction: 0xf71ba601
    1268:	03000001 	movweq	r0, #1
    126c:	207fac91 			; <UNDEFINED> instruction: 0x207fac91
    1270:	00000e4d 	andeq	r0, r0, sp, asr #28
    1274:	4d2aa601 	stcmi	6, cr10, [sl, #-4]!
    1278:	03000000 	movweq	r0, #0
    127c:	1e7fa891 	mrcne	8, 3, sl, cr15, cr1, {4}
    1280:	00000dd7 	ldrdeq	r0, [r0], -r7
    1284:	330aa801 	movwcc	sl, #43009	; 0xa801
    1288:	03000007 	movweq	r0, #7
    128c:	1e7fb491 	mrcne	4, 3, fp, cr15, cr1, {4}
    1290:	00000cc7 	andeq	r0, r0, r7, asr #25
    1294:	3809ac01 	stmdacc	r9, {r0, sl, fp, sp, pc}
    1298:	02000000 	andeq	r0, r0, #0
    129c:	0f007491 	svceq	0x00007491
    12a0:	00000025 	andeq	r0, r0, r5, lsr #32
    12a4:	00000743 	andeq	r0, r0, r3, asr #14
    12a8:	00005e10 	andeq	r5, r0, r0, lsl lr
    12ac:	21003f00 	tstcs	r0, r0, lsl #30
    12b0:	00000e32 	andeq	r0, r0, r2, lsr lr
    12b4:	040a9801 	streq	r9, [sl], #-2049	; 0xfffff7ff
    12b8:	4d00000f 	stcmi	0, cr0, [r0, #-60]	; 0xffffffc4
    12bc:	24000000 	strcs	r0, [r0], #-0
    12c0:	3c000087 	stccc	0, cr0, [r0], {135}	; 0x87
    12c4:	01000000 	mrseq	r0, (UNDEF: 0)
    12c8:	0007809c 	muleq	r7, ip, r0
    12cc:	65722200 	ldrbvs	r2, [r2, #-512]!	; 0xfffffe00
    12d0:	9a010071 	bls	4149c <__bss_end+0x384bc>
    12d4:	0003ab20 	andeq	sl, r3, r0, lsr #22
    12d8:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    12dc:	000de31e 	andeq	lr, sp, lr, lsl r3
    12e0:	0e9b0100 	fmleqe	f0, f3, f0
    12e4:	0000004d 	andeq	r0, r0, sp, asr #32
    12e8:	00709102 	rsbseq	r9, r0, r2, lsl #2
    12ec:	000e5623 	andeq	r5, lr, r3, lsr #12
    12f0:	068f0100 	streq	r0, [pc], r0, lsl #2
    12f4:	00000ce8 	andeq	r0, r0, r8, ror #25
    12f8:	000086e8 	andeq	r8, r0, r8, ror #13
    12fc:	0000003c 	andeq	r0, r0, ip, lsr r0
    1300:	07b99c01 	ldreq	r9, [r9, r1, lsl #24]!
    1304:	2a200000 	bcs	80130c <__bss_end+0x7f832c>
    1308:	0100000d 	tsteq	r0, sp
    130c:	004d218f 	subeq	r2, sp, pc, lsl #3
    1310:	91020000 	mrsls	r0, (UNDEF: 2)
    1314:	6572226c 	ldrbvs	r2, [r2, #-620]!	; 0xfffffd94
    1318:	91010071 	tstls	r1, r1, ror r0
    131c:	0003ab20 	andeq	sl, r3, r0, lsr #22
    1320:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    1324:	0e0f2100 	adfeqe	f2, f7, f0
    1328:	83010000 	movwhi	r0, #4096	; 0x1000
    132c:	000d780a 	andeq	r7, sp, sl, lsl #16
    1330:	00004d00 	andeq	r4, r0, r0, lsl #26
    1334:	0086ac00 	addeq	sl, r6, r0, lsl #24
    1338:	00003c00 	andeq	r3, r0, r0, lsl #24
    133c:	f69c0100 			; <UNDEFINED> instruction: 0xf69c0100
    1340:	22000007 	andcs	r0, r0, #7
    1344:	00716572 	rsbseq	r6, r1, r2, ror r5
    1348:	87208501 	strhi	r8, [r0, -r1, lsl #10]!
    134c:	02000003 	andeq	r0, r0, #3
    1350:	c01e7491 	mulsgt	lr, r1, r4
    1354:	0100000c 	tsteq	r0, ip
    1358:	004d0e86 	subeq	r0, sp, r6, lsl #29
    135c:	91020000 	mrsls	r0, (UNDEF: 2)
    1360:	64210070 	strtvs	r0, [r1], #-112	; 0xffffff90
    1364:	01000010 	tsteq	r0, r0, lsl r0
    1368:	0d3e0a77 	vldmdbeq	lr!, {s0-s118}
    136c:	004d0000 	subeq	r0, sp, r0
    1370:	86700000 	ldrbthi	r0, [r0], -r0
    1374:	003c0000 	eorseq	r0, ip, r0
    1378:	9c010000 	stcls	0, cr0, [r1], {-0}
    137c:	00000833 	andeq	r0, r0, r3, lsr r8
    1380:	71657222 	cmnvc	r5, r2, lsr #4
    1384:	20790100 	rsbscs	r0, r9, r0, lsl #2
    1388:	00000387 	andeq	r0, r0, r7, lsl #7
    138c:	1e749102 	expnes	f1, f2
    1390:	00000cc0 	andeq	r0, r0, r0, asr #25
    1394:	4d0e7a01 	vstrmi	s14, [lr, #-4]
    1398:	02000000 	andeq	r0, r0, #0
    139c:	21007091 	swpcs	r7, r1, [r0]
    13a0:	00000d8c 	andeq	r0, r0, ip, lsl #27
    13a4:	cf066b01 	svcgt	0x00066b01
    13a8:	f000000e 			; <UNDEFINED> instruction: 0xf000000e
    13ac:	1c000001 	stcne	0, cr0, [r0], {1}
    13b0:	54000086 	strpl	r0, [r0], #-134	; 0xffffff7a
    13b4:	01000000 	mrseq	r0, (UNDEF: 0)
    13b8:	00087f9c 	muleq	r8, ip, pc	; <UNPREDICTABLE>
    13bc:	0de32000 	stcleq	0, cr2, [r3]
    13c0:	6b010000 	blvs	413c8 <__bss_end+0x383e8>
    13c4:	00004d15 	andeq	r4, r0, r5, lsl sp
    13c8:	6c910200 	lfmvs	f0, 4, [r1], {0}
    13cc:	0006ac20 	andeq	sl, r6, r0, lsr #24
    13d0:	256b0100 	strbcs	r0, [fp, #-256]!	; 0xffffff00
    13d4:	0000004d 	andeq	r0, r0, sp, asr #32
    13d8:	1e689102 	lgnnee	f1, f2
    13dc:	0000105c 	andeq	r1, r0, ip, asr r0
    13e0:	4d0e6d01 	stcmi	13, cr6, [lr, #-4]
    13e4:	02000000 	andeq	r0, r0, #0
    13e8:	21007491 			; <UNDEFINED> instruction: 0x21007491
    13ec:	00000cff 	strdeq	r0, [r0], -pc	; <UNPREDICTABLE>
    13f0:	3b125e01 	blcc	498bfc <__bss_end+0x48fc1c>
    13f4:	8b00000f 	blhi	1438 <shift+0x1438>
    13f8:	cc000000 	stcgt	0, cr0, [r0], {-0}
    13fc:	50000085 	andpl	r0, r0, r5, lsl #1
    1400:	01000000 	mrseq	r0, (UNDEF: 0)
    1404:	0008da9c 	muleq	r8, ip, sl
    1408:	0eda2000 	cdpeq	0, 13, cr2, cr10, cr0, {0}
    140c:	5e010000 	cdppl	0, 0, cr0, cr1, cr0, {0}
    1410:	00004d20 	andeq	r4, r0, r0, lsr #26
    1414:	6c910200 	lfmvs	f0, 4, [r1], {0}
    1418:	000e1820 	andeq	r1, lr, r0, lsr #16
    141c:	2f5e0100 	svccs	0x005e0100
    1420:	0000004d 	andeq	r0, r0, sp, asr #32
    1424:	20689102 	rsbcs	r9, r8, r2, lsl #2
    1428:	000006ac 	andeq	r0, r0, ip, lsr #13
    142c:	4d3f5e01 	ldcmi	14, cr5, [pc, #-4]!	; 1430 <shift+0x1430>
    1430:	02000000 	andeq	r0, r0, #0
    1434:	5c1e6491 	cfldrspl	mvf6, [lr], {145}	; 0x91
    1438:	01000010 	tsteq	r0, r0, lsl r0
    143c:	008b1660 	addeq	r1, fp, r0, ror #12
    1440:	91020000 	mrsls	r0, (UNDEF: 2)
    1444:	71210074 			; <UNDEFINED> instruction: 0x71210074
    1448:	0100000f 	tsteq	r0, pc
    144c:	0d040a52 	vstreq	s0, [r4, #-328]	; 0xfffffeb8
    1450:	004d0000 	subeq	r0, sp, r0
    1454:	85880000 	strhi	r0, [r8]
    1458:	00440000 	subeq	r0, r4, r0
    145c:	9c010000 	stcls	0, cr0, [r1], {-0}
    1460:	00000926 	andeq	r0, r0, r6, lsr #18
    1464:	000eda20 	andeq	sp, lr, r0, lsr #20
    1468:	1a520100 	bne	1481870 <__bss_end+0x1478890>
    146c:	0000004d 	andeq	r0, r0, sp, asr #32
    1470:	206c9102 	rsbcs	r9, ip, r2, lsl #2
    1474:	00000e18 	andeq	r0, r0, r8, lsl lr
    1478:	4d295201 	sfmmi	f5, 4, [r9, #-4]!
    147c:	02000000 	andeq	r0, r0, #0
    1480:	6a1e6891 	bvs	79b6cc <__bss_end+0x7926ec>
    1484:	0100000f 	tsteq	r0, pc
    1488:	004d0e54 	subeq	r0, sp, r4, asr lr
    148c:	91020000 	mrsls	r0, (UNDEF: 2)
    1490:	64210074 	strtvs	r0, [r1], #-116	; 0xffffff8c
    1494:	0100000f 	tsteq	r0, pc
    1498:	0f460a45 	svceq	0x00460a45
    149c:	004d0000 	subeq	r0, sp, r0
    14a0:	85380000 	ldrhi	r0, [r8, #-0]!
    14a4:	00500000 	subseq	r0, r0, r0
    14a8:	9c010000 	stcls	0, cr0, [r1], {-0}
    14ac:	00000981 	andeq	r0, r0, r1, lsl #19
    14b0:	000eda20 	andeq	sp, lr, r0, lsr #20
    14b4:	19450100 	stmdbne	r5, {r8}^
    14b8:	0000004d 	andeq	r0, r0, sp, asr #32
    14bc:	206c9102 	rsbcs	r9, ip, r2, lsl #2
    14c0:	00000db8 			; <UNDEFINED> instruction: 0x00000db8
    14c4:	1d304501 	cfldr32ne	mvfx4, [r0, #-4]!
    14c8:	02000001 	andeq	r0, r0, #1
    14cc:	1e206891 	mcrne	8, 1, r6, cr0, cr1, {4}
    14d0:	0100000e 	tsteq	r0, lr
    14d4:	06ac4145 	strteq	r4, [ip], r5, asr #2
    14d8:	91020000 	mrsls	r0, (UNDEF: 2)
    14dc:	105c1e64 	subsne	r1, ip, r4, ror #28
    14e0:	47010000 	strmi	r0, [r1, -r0]
    14e4:	00004d0e 	andeq	r4, r0, lr, lsl #26
    14e8:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    14ec:	0cad2300 	stceq	3, cr2, [sp]
    14f0:	3f010000 	svccc	0x00010000
    14f4:	000dc206 	andeq	ip, sp, r6, lsl #4
    14f8:	00850c00 	addeq	r0, r5, r0, lsl #24
    14fc:	00002c00 	andeq	r2, r0, r0, lsl #24
    1500:	ab9c0100 	blge	fe701908 <__bss_end+0xfe6f8928>
    1504:	20000009 	andcs	r0, r0, r9
    1508:	00000eda 	ldrdeq	r0, [r0], -sl
    150c:	4d153f01 	ldcmi	15, cr3, [r5, #-4]
    1510:	02000000 	andeq	r0, r0, #0
    1514:	21007491 			; <UNDEFINED> instruction: 0x21007491
    1518:	00000ddd 	ldrdeq	r0, [r0], -sp
    151c:	240a3201 	strcs	r3, [sl], #-513	; 0xfffffdff
    1520:	4d00000e 	stcmi	0, cr0, [r0, #-56]	; 0xffffffc8
    1524:	bc000000 	stclt	0, cr0, [r0], {-0}
    1528:	50000084 	andpl	r0, r0, r4, lsl #1
    152c:	01000000 	mrseq	r0, (UNDEF: 0)
    1530:	000a069c 	muleq	sl, ip, r6
    1534:	0eda2000 	cdpeq	0, 13, cr2, cr10, cr0, {0}
    1538:	32010000 	andcc	r0, r1, #0
    153c:	00004d19 	andeq	r4, r0, r9, lsl sp
    1540:	6c910200 	lfmvs	f0, 4, [r1], {0}
    1544:	000f8720 	andeq	r8, pc, r0, lsr #14
    1548:	2b320100 	blcs	c81950 <__bss_end+0xc78970>
    154c:	000001f7 	strdeq	r0, [r0], -r7
    1550:	20689102 	rsbcs	r9, r8, r2, lsl #2
    1554:	00000e51 	andeq	r0, r0, r1, asr lr
    1558:	4d3c3201 	lfmmi	f3, 4, [ip, #-4]!
    155c:	02000000 	andeq	r0, r0, #0
    1560:	351e6491 	ldrcc	r6, [lr, #-1169]	; 0xfffffb6f
    1564:	0100000f 	tsteq	r0, pc
    1568:	004d0e34 	subeq	r0, sp, r4, lsr lr
    156c:	91020000 	mrsls	r0, (UNDEF: 2)
    1570:	86210074 			; <UNDEFINED> instruction: 0x86210074
    1574:	01000010 	tsteq	r0, r0, lsl r0
    1578:	0f8e0a25 	svceq	0x008e0a25
    157c:	004d0000 	subeq	r0, sp, r0
    1580:	846c0000 	strbthi	r0, [ip], #-0
    1584:	00500000 	subseq	r0, r0, r0
    1588:	9c010000 	stcls	0, cr0, [r1], {-0}
    158c:	00000a61 	andeq	r0, r0, r1, ror #20
    1590:	000eda20 	andeq	sp, lr, r0, lsr #20
    1594:	18250100 	stmdane	r5!, {r8}
    1598:	0000004d 	andeq	r0, r0, sp, asr #32
    159c:	206c9102 	rsbcs	r9, ip, r2, lsl #2
    15a0:	00000f87 	andeq	r0, r0, r7, lsl #31
    15a4:	672a2501 	strvs	r2, [sl, -r1, lsl #10]!
    15a8:	0200000a 	andeq	r0, r0, #10
    15ac:	51206891 			; <UNDEFINED> instruction: 0x51206891
    15b0:	0100000e 	tsteq	r0, lr
    15b4:	004d3b25 	subeq	r3, sp, r5, lsr #22
    15b8:	91020000 	mrsls	r0, (UNDEF: 2)
    15bc:	0cd11e64 	ldcleq	14, cr1, [r1], {100}	; 0x64
    15c0:	27010000 	strcs	r0, [r1, -r0]
    15c4:	00004d0e 	andeq	r4, r0, lr, lsl #26
    15c8:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    15cc:	25040d00 	strcs	r0, [r4, #-3328]	; 0xfffff300
    15d0:	03000000 	movweq	r0, #0
    15d4:	00000a61 	andeq	r0, r0, r1, ror #20
    15d8:	000de921 	andeq	lr, sp, r1, lsr #18
    15dc:	0a190100 	beq	6419e4 <__bss_end+0x638a04>
    15e0:	00001092 	muleq	r0, r2, r0
    15e4:	0000004d 	andeq	r0, r0, sp, asr #32
    15e8:	00008428 	andeq	r8, r0, r8, lsr #8
    15ec:	00000044 	andeq	r0, r0, r4, asr #32
    15f0:	0ab89c01 	beq	fee285fc <__bss_end+0xfee1f61c>
    15f4:	7d200000 	stcvc	0, cr0, [r0, #-0]
    15f8:	01000010 	tsteq	r0, r0, lsl r0
    15fc:	01f71b19 	mvnseq	r1, r9, lsl fp
    1600:	91020000 	mrsls	r0, (UNDEF: 2)
    1604:	0f82206c 	svceq	0x0082206c
    1608:	19010000 	stmdbne	r1, {}	; <UNPREDICTABLE>
    160c:	0001c635 	andeq	ip, r1, r5, lsr r6
    1610:	68910200 	ldmvs	r1, {r9}
    1614:	000eda1e 	andeq	sp, lr, lr, lsl sl
    1618:	0e1b0100 	mufeqe	f0, f3, f0
    161c:	0000004d 	andeq	r0, r0, sp, asr #32
    1620:	00749102 	rsbseq	r9, r4, r2, lsl #2
    1624:	000d1e24 	andeq	r1, sp, r4, lsr #28
    1628:	06140100 	ldreq	r0, [r4], -r0, lsl #2
    162c:	00000cd7 	ldrdeq	r0, [r0], -r7
    1630:	0000840c 	andeq	r8, r0, ip, lsl #8
    1634:	0000001c 	andeq	r0, r0, ip, lsl r0
    1638:	78239c01 	stmdavc	r3!, {r0, sl, fp, ip, pc}
    163c:	0100000f 	tsteq	r0, pc
    1640:	0daa060e 	stceq	6, cr0, [sl, #56]!	; 0x38
    1644:	83e00000 	mvnhi	r0, #0
    1648:	002c0000 	eoreq	r0, ip, r0
    164c:	9c010000 	stcls	0, cr0, [r1], {-0}
    1650:	00000af8 	strdeq	r0, [r0], -r8
    1654:	000d1520 	andeq	r1, sp, r0, lsr #10
    1658:	140e0100 	strne	r0, [lr], #-256	; 0xffffff00
    165c:	00000038 	andeq	r0, r0, r8, lsr r0
    1660:	00749102 	rsbseq	r9, r4, r2, lsl #2
    1664:	00108b25 	andseq	r8, r0, r5, lsr #22
    1668:	0a040100 	beq	101a70 <__bss_end+0xf8a90>
    166c:	00000dcc 	andeq	r0, r0, ip, asr #27
    1670:	0000004d 	andeq	r0, r0, sp, asr #32
    1674:	000083b4 			; <UNDEFINED> instruction: 0x000083b4
    1678:	0000002c 	andeq	r0, r0, ip, lsr #32
    167c:	70229c01 	eorvc	r9, r2, r1, lsl #24
    1680:	01006469 	tsteq	r0, r9, ror #8
    1684:	004d0e06 	subeq	r0, sp, r6, lsl #28
    1688:	91020000 	mrsls	r0, (UNDEF: 2)
    168c:	2e000074 	mcrcs	0, 0, r0, cr0, cr4, {3}
    1690:	04000003 	streq	r0, [r0], #-3
    1694:	0006d000 	andeq	sp, r6, r0
    1698:	9a010400 	bls	426a0 <__bss_end+0x396c0>
    169c:	0400000f 	streq	r0, [r0], #-15
    16a0:	000010d2 	ldrdeq	r1, [r0], -r2
    16a4:	00000c62 	andeq	r0, r0, r2, ror #24
    16a8:	00008810 	andeq	r8, r0, r0, lsl r8
    16ac:	000004b8 			; <UNDEFINED> instruction: 0x000004b8
    16b0:	00000827 	andeq	r0, r0, r7, lsr #16
    16b4:	00004902 	andeq	r4, r0, r2, lsl #18
    16b8:	113b0300 	teqne	fp, r0, lsl #6
    16bc:	05010000 	streq	r0, [r1, #-0]
    16c0:	00006110 	andeq	r6, r0, r0, lsl r1
    16c4:	31301100 	teqcc	r0, r0, lsl #2
    16c8:	35343332 	ldrcc	r3, [r4, #-818]!	; 0xfffffcce
    16cc:	39383736 	ldmdbcc	r8!, {r1, r2, r4, r5, r8, r9, sl, ip, sp}
    16d0:	44434241 	strbmi	r4, [r3], #-577	; 0xfffffdbf
    16d4:	00004645 	andeq	r4, r0, r5, asr #12
    16d8:	01030104 	tsteq	r3, r4, lsl #2
    16dc:	00000025 	andeq	r0, r0, r5, lsr #32
    16e0:	00007405 	andeq	r7, r0, r5, lsl #8
    16e4:	00006100 	andeq	r6, r0, r0, lsl #2
    16e8:	00660600 	rsbeq	r0, r6, r0, lsl #12
    16ec:	00100000 	andseq	r0, r0, r0
    16f0:	00005107 	andeq	r5, r0, r7, lsl #2
    16f4:	07040800 	streq	r0, [r4, -r0, lsl #16]
    16f8:	0000074a 	andeq	r0, r0, sl, asr #14
    16fc:	a8080108 	stmdage	r8, {r3, r8}
    1700:	07000009 	streq	r0, [r0, -r9]
    1704:	0000006d 	andeq	r0, r0, sp, rrx
    1708:	00002a09 	andeq	r2, r0, r9, lsl #20
    170c:	116a0a00 	cmnne	sl, r0, lsl #20
    1710:	64010000 	strvs	r0, [r1], #-0
    1714:	00115506 	andseq	r5, r1, r6, lsl #10
    1718:	008c4800 	addeq	r4, ip, r0, lsl #16
    171c:	00008000 	andeq	r8, r0, r0
    1720:	fb9c0100 	blx	fe701b2a <__bss_end+0xfe6f8b4a>
    1724:	0b000000 	bleq	172c <shift+0x172c>
    1728:	00637273 	rsbeq	r7, r3, r3, ror r2
    172c:	fb196401 	blx	65a73a <__bss_end+0x65175a>
    1730:	02000000 	andeq	r0, r0, #0
    1734:	640b6491 	strvs	r6, [fp], #-1169	; 0xfffffb6f
    1738:	01007473 	tsteq	r0, r3, ror r4
    173c:	01022464 	tsteq	r2, r4, ror #8
    1740:	91020000 	mrsls	r0, (UNDEF: 2)
    1744:	756e0b60 	strbvc	r0, [lr, #-2912]!	; 0xfffff4a0
    1748:	6401006d 	strvs	r0, [r1], #-109	; 0xffffff93
    174c:	0001042d 	andeq	r0, r1, sp, lsr #8
    1750:	5c910200 	lfmpl	f0, 4, [r1], {0}
    1754:	0011c40c 	andseq	ip, r1, ip, lsl #8
    1758:	0e660100 	poweqs	f0, f6, f0
    175c:	0000010b 	andeq	r0, r0, fp, lsl #2
    1760:	0c709102 	ldfeqp	f1, [r0], #-8
    1764:	00001147 	andeq	r1, r0, r7, asr #2
    1768:	11086701 	tstne	r8, r1, lsl #14
    176c:	02000001 	andeq	r0, r0, #1
    1770:	700d6c91 	mulvc	sp, r1, ip
    1774:	4800008c 	stmdami	r0, {r2, r3, r7}
    1778:	0e000000 	cdpeq	0, 0, cr0, cr0, cr0, {0}
    177c:	69010069 	stmdbvs	r1, {r0, r3, r5, r6}
    1780:	0001040b 	andeq	r0, r1, fp, lsl #8
    1784:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    1788:	040f0000 	streq	r0, [pc], #-0	; 1790 <shift+0x1790>
    178c:	00000101 	andeq	r0, r0, r1, lsl #2
    1790:	12041110 	andne	r1, r4, #16, 2
    1794:	6e690504 	cdpvs	5, 6, cr0, cr9, cr4, {0}
    1798:	040f0074 	streq	r0, [pc], #-116	; 17a0 <shift+0x17a0>
    179c:	00000074 	andeq	r0, r0, r4, ror r0
    17a0:	006d040f 	rsbeq	r0, sp, pc, lsl #8
    17a4:	b90a0000 	stmdblt	sl, {}	; <UNPREDICTABLE>
    17a8:	01000010 	tsteq	r0, r0, lsl r0
    17ac:	10c6065c 	sbcne	r0, r6, ip, asr r6
    17b0:	8be00000 	blhi	ff8017b8 <__bss_end+0xff7f87d8>
    17b4:	00680000 	rsbeq	r0, r8, r0
    17b8:	9c010000 	stcls	0, cr0, [r1], {-0}
    17bc:	00000176 	andeq	r0, r0, r6, ror r1
    17c0:	0011bd13 	andseq	fp, r1, r3, lsl sp
    17c4:	125c0100 	subsne	r0, ip, #0, 2
    17c8:	00000102 	andeq	r0, r0, r2, lsl #2
    17cc:	136c9102 	cmnne	ip, #-2147483648	; 0x80000000
    17d0:	000010bf 	strheq	r1, [r0], -pc	; <UNPREDICTABLE>
    17d4:	041e5c01 	ldreq	r5, [lr], #-3073	; 0xfffff3ff
    17d8:	02000001 	andeq	r0, r0, #1
    17dc:	6d0e6891 	stcvs	8, cr6, [lr, #-580]	; 0xfffffdbc
    17e0:	01006d65 	tsteq	r0, r5, ror #26
    17e4:	0111085e 	tsteq	r1, lr, asr r8
    17e8:	91020000 	mrsls	r0, (UNDEF: 2)
    17ec:	8bfc0d70 	blhi	fff04db4 <__bss_end+0xffefbdd4>
    17f0:	003c0000 	eorseq	r0, ip, r0
    17f4:	690e0000 	stmdbvs	lr, {}	; <UNPREDICTABLE>
    17f8:	0b600100 	bleq	1801c00 <__bss_end+0x17f8c20>
    17fc:	00000104 	andeq	r0, r0, r4, lsl #2
    1800:	00749102 	rsbseq	r9, r4, r2, lsl #2
    1804:	11711400 	cmnne	r1, r0, lsl #8
    1808:	52010000 	andpl	r0, r1, #0
    180c:	00118a05 	andseq	r8, r1, r5, lsl #20
    1810:	00010400 	andeq	r0, r1, r0, lsl #8
    1814:	008b8c00 	addeq	r8, fp, r0, lsl #24
    1818:	00005400 	andeq	r5, r0, r0, lsl #8
    181c:	af9c0100 	svcge	0x009c0100
    1820:	0b000001 	bleq	182c <shift+0x182c>
    1824:	52010073 	andpl	r0, r1, #115	; 0x73
    1828:	00010b18 	andeq	r0, r1, r8, lsl fp
    182c:	6c910200 	lfmvs	f0, 4, [r1], {0}
    1830:	0100690e 	tsteq	r0, lr, lsl #18
    1834:	01040654 	tsteq	r4, r4, asr r6
    1838:	91020000 	mrsls	r0, (UNDEF: 2)
    183c:	ad140074 	ldcge	0, cr0, [r4, #-464]	; 0xfffffe30
    1840:	01000011 	tsteq	r0, r1, lsl r0
    1844:	11780542 	cmnne	r8, r2, asr #10
    1848:	01040000 	mrseq	r0, (UNDEF: 4)
    184c:	8ae00000 	bhi	ff801854 <__bss_end+0xff7f8874>
    1850:	00ac0000 	adceq	r0, ip, r0
    1854:	9c010000 	stcls	0, cr0, [r1], {-0}
    1858:	00000215 	andeq	r0, r0, r5, lsl r2
    185c:	0031730b 	eorseq	r7, r1, fp, lsl #6
    1860:	0b194201 	bleq	65206c <__bss_end+0x64908c>
    1864:	02000001 	andeq	r0, r0, #1
    1868:	730b6c91 	movwvc	r6, #48273	; 0xbc91
    186c:	42010032 	andmi	r0, r1, #50	; 0x32
    1870:	00010b29 	andeq	r0, r1, r9, lsr #22
    1874:	68910200 	ldmvs	r1, {r9}
    1878:	6d756e0b 	ldclvs	14, cr6, [r5, #-44]!	; 0xffffffd4
    187c:	31420100 	mrscc	r0, (UNDEF: 82)
    1880:	00000104 	andeq	r0, r0, r4, lsl #2
    1884:	0e649102 	lgneqs	f1, f2
    1888:	01003175 	tsteq	r0, r5, ror r1
    188c:	02151044 	andseq	r1, r5, #68	; 0x44
    1890:	91020000 	mrsls	r0, (UNDEF: 2)
    1894:	32750e77 	rsbscc	r0, r5, #1904	; 0x770
    1898:	14440100 	strbne	r0, [r4], #-256	; 0xffffff00
    189c:	00000215 	andeq	r0, r0, r5, lsl r2
    18a0:	00769102 	rsbseq	r9, r6, r2, lsl #2
    18a4:	9f080108 	svcls	0x00080108
    18a8:	14000009 	strne	r0, [r0], #-9
    18ac:	000011b5 			; <UNDEFINED> instruction: 0x000011b5
    18b0:	9c073601 	stcls	6, cr3, [r7], {1}
    18b4:	11000011 	tstne	r0, r1, lsl r0
    18b8:	20000001 	andcs	r0, r0, r1
    18bc:	c000008a 	andgt	r0, r0, sl, lsl #1
    18c0:	01000000 	mrseq	r0, (UNDEF: 0)
    18c4:	0002759c 	muleq	r2, ip, r5
    18c8:	10b41300 	adcsne	r1, r4, r0, lsl #6
    18cc:	36010000 	strcc	r0, [r1], -r0
    18d0:	00011115 	andeq	r1, r1, r5, lsl r1
    18d4:	6c910200 	lfmvs	f0, 4, [r1], {0}
    18d8:	6372730b 	cmnvs	r2, #738197504	; 0x2c000000
    18dc:	27360100 	ldrcs	r0, [r6, -r0, lsl #2]!
    18e0:	0000010b 	andeq	r0, r0, fp, lsl #2
    18e4:	0b689102 	bleq	1a25cf4 <__bss_end+0x1a1cd14>
    18e8:	006d756e 	rsbeq	r7, sp, lr, ror #10
    18ec:	04303601 	ldrteq	r3, [r0], #-1537	; 0xfffff9ff
    18f0:	02000001 	andeq	r0, r0, #1
    18f4:	690e6491 	stmdbvs	lr, {r0, r4, r7, sl, sp, lr}
    18f8:	06380100 	ldrteq	r0, [r8], -r0, lsl #2
    18fc:	00000104 	andeq	r0, r0, r4, lsl #2
    1900:	00749102 	rsbseq	r9, r4, r2, lsl #2
    1904:	00119714 	andseq	r9, r1, r4, lsl r7
    1908:	05240100 	streq	r0, [r4, #-256]!	; 0xffffff00
    190c:	00001130 	andeq	r1, r0, r0, lsr r1
    1910:	00000104 	andeq	r0, r0, r4, lsl #2
    1914:	00008984 	andeq	r8, r0, r4, lsl #19
    1918:	0000009c 	muleq	r0, ip, r0
    191c:	02b29c01 	adcseq	r9, r2, #256	; 0x100
    1920:	ae130000 	cdpge	0, 1, cr0, cr3, cr0, {0}
    1924:	01000010 	tsteq	r0, r0, lsl r0
    1928:	010b1624 	tsteq	fp, r4, lsr #12
    192c:	91020000 	mrsls	r0, (UNDEF: 2)
    1930:	114e0c6c 	cmpne	lr, ip, ror #24
    1934:	26010000 	strcs	r0, [r1], -r0
    1938:	00010406 	andeq	r0, r1, r6, lsl #8
    193c:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    1940:	11cb1500 	bicne	r1, fp, r0, lsl #10
    1944:	08010000 	stmdaeq	r1, {}	; <UNPREDICTABLE>
    1948:	0011d006 	andseq	sp, r1, r6
    194c:	00881000 	addeq	r1, r8, r0
    1950:	00017400 	andeq	r7, r1, r0, lsl #8
    1954:	139c0100 	orrsne	r0, ip, #0, 2
    1958:	000010ae 	andeq	r1, r0, lr, lsr #1
    195c:	66180801 	ldrvs	r0, [r8], -r1, lsl #16
    1960:	02000000 	andeq	r0, r0, #0
    1964:	4e136491 	cfcmpsmi	r6, mvf3, mvf1
    1968:	01000011 	tsteq	r0, r1, lsl r0
    196c:	01112508 	tsteq	r1, r8, lsl #10
    1970:	91020000 	mrsls	r0, (UNDEF: 2)
    1974:	11651360 	cmnne	r5, r0, ror #6
    1978:	08010000 	stmdaeq	r1, {}	; <UNPREDICTABLE>
    197c:	0000663a 	andeq	r6, r0, sl, lsr r6
    1980:	5c910200 	lfmpl	f0, 4, [r1], {0}
    1984:	0100690e 	tsteq	r0, lr, lsl #18
    1988:	0104060a 	tsteq	r4, sl, lsl #12
    198c:	91020000 	mrsls	r0, (UNDEF: 2)
    1990:	88dc0d74 	ldmhi	ip, {r2, r4, r5, r6, r8, sl, fp}^
    1994:	00980000 	addseq	r0, r8, r0
    1998:	6a0e0000 	bvs	3819a0 <__bss_end+0x3789c0>
    199c:	0b1c0100 	bleq	701da4 <__bss_end+0x6f8dc4>
    19a0:	00000104 	andeq	r0, r0, r4, lsl #2
    19a4:	0d709102 	ldfeqp	f1, [r0, #-8]!
    19a8:	00008904 	andeq	r8, r0, r4, lsl #18
    19ac:	00000060 	andeq	r0, r0, r0, rrx
    19b0:	0100630e 	tsteq	r0, lr, lsl #6
    19b4:	006d081e 	rsbeq	r0, sp, lr, lsl r8
    19b8:	91020000 	mrsls	r0, (UNDEF: 2)
    19bc:	0000006f 	andeq	r0, r0, pc, rrx
	...

Disassembly of section .debug_abbrev:

00000000 <.debug_abbrev>:
   0:	10001101 	andne	r1, r0, r1, lsl #2
   4:	12011106 	andne	r1, r1, #-2147483647	; 0x80000001
   8:	1b0e0301 	blne	380c14 <__bss_end+0x377c34>
   c:	130e250e 	movwne	r2, #58638	; 0xe50e
  10:	00000005 	andeq	r0, r0, r5
  14:	25011101 	strcs	r1, [r1, #-257]	; 0xfffffeff
  18:	030b130e 	movweq	r1, #45838	; 0xb30e
  1c:	110e1b0e 	tstne	lr, lr, lsl #22
  20:	10061201 	andne	r1, r6, r1, lsl #4
  24:	02000017 	andeq	r0, r0, #23
  28:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
  2c:	0b3b0b3a 	bleq	ec2d1c <__bss_end+0xeb9d3c>
  30:	13490b39 	movtne	r0, #39737	; 0x9b39
  34:	193c193f 	ldmdbne	ip!, {r0, r1, r2, r3, r4, r5, r8, fp, ip}
  38:	24030000 	strcs	r0, [r3], #-0
  3c:	3e0b0b00 	vmlacc.f64	d0, d11, d0
  40:	000e030b 	andeq	r0, lr, fp, lsl #6
  44:	012e0400 			; <UNDEFINED> instruction: 0x012e0400
  48:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
  4c:	0b3b0b3a 	bleq	ec2d3c <__bss_end+0xeb9d5c>
  50:	01110b39 	tsteq	r1, r9, lsr fp
  54:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
  58:	01194296 			; <UNDEFINED> instruction: 0x01194296
  5c:	05000013 	streq	r0, [r0, #-19]	; 0xffffffed
  60:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
  64:	0b3b0b3a 	bleq	ec2d54 <__bss_end+0xeb9d74>
  68:	13490b39 	movtne	r0, #39737	; 0x9b39
  6c:	00001802 	andeq	r1, r0, r2, lsl #16
  70:	0b002406 	bleq	9090 <__bss_end+0xb0>
  74:	030b3e0b 	movweq	r3, #48651	; 0xbe0b
  78:	07000008 	streq	r0, [r0, -r8]
  7c:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
  80:	0b3a0e03 	bleq	e83894 <__bss_end+0xe7a8b4>
  84:	0b390b3b 	bleq	e42d78 <__bss_end+0xe39d98>
  88:	06120111 			; <UNDEFINED> instruction: 0x06120111
  8c:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
  90:	00130119 	andseq	r0, r3, r9, lsl r1
  94:	010b0800 	tsteq	fp, r0, lsl #16
  98:	06120111 			; <UNDEFINED> instruction: 0x06120111
  9c:	34090000 	strcc	r0, [r9], #-0
  a0:	3a080300 	bcc	200ca8 <__bss_end+0x1f7cc8>
  a4:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
  a8:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
  ac:	0a000018 	beq	114 <shift+0x114>
  b0:	0b0b000f 	bleq	2c00f4 <__bss_end+0x2b7114>
  b4:	00001349 	andeq	r1, r0, r9, asr #6
  b8:	01110100 	tsteq	r1, r0, lsl #2
  bc:	0b130e25 	bleq	4c3958 <__bss_end+0x4ba978>
  c0:	0e1b0e03 	cdpeq	14, 1, cr0, cr11, cr3, {0}
  c4:	06120111 			; <UNDEFINED> instruction: 0x06120111
  c8:	00001710 	andeq	r1, r0, r0, lsl r7
  cc:	03001602 	movweq	r1, #1538	; 0x602
  d0:	3b0b3a0e 	blcc	2ce910 <__bss_end+0x2c5930>
  d4:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
  d8:	03000013 	movweq	r0, #19
  dc:	0b0b000f 	bleq	2c0120 <__bss_end+0x2b7140>
  e0:	00001349 	andeq	r1, r0, r9, asr #6
  e4:	00001504 	andeq	r1, r0, r4, lsl #10
  e8:	01010500 	tsteq	r1, r0, lsl #10
  ec:	13011349 	movwne	r1, #4937	; 0x1349
  f0:	21060000 	mrscs	r0, (UNDEF: 6)
  f4:	2f134900 	svccs	0x00134900
  f8:	07000006 	streq	r0, [r0, -r6]
  fc:	0b0b0024 	bleq	2c0194 <__bss_end+0x2b71b4>
 100:	0e030b3e 	vmoveq.16	d3[0], r0
 104:	34080000 	strcc	r0, [r8], #-0
 108:	3a0e0300 	bcc	380d10 <__bss_end+0x377d30>
 10c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 110:	3f13490b 	svccc	0x0013490b
 114:	00193c19 	andseq	r3, r9, r9, lsl ip
 118:	012e0900 			; <UNDEFINED> instruction: 0x012e0900
 11c:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 120:	0b3b0b3a 	bleq	ec2e10 <__bss_end+0xeb9e30>
 124:	13490b39 	movtne	r0, #39737	; 0x9b39
 128:	06120111 			; <UNDEFINED> instruction: 0x06120111
 12c:	42961840 	addsmi	r1, r6, #64, 16	; 0x400000
 130:	00130119 	andseq	r0, r3, r9, lsl r1
 134:	00340a00 	eorseq	r0, r4, r0, lsl #20
 138:	0b3a0e03 	bleq	e8394c <__bss_end+0xe7a96c>
 13c:	0b390b3b 	bleq	e42e30 <__bss_end+0xe39e50>
 140:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 144:	240b0000 	strcs	r0, [fp], #-0
 148:	3e0b0b00 	vmlacc.f64	d0, d11, d0
 14c:	0008030b 	andeq	r0, r8, fp, lsl #6
 150:	002e0c00 	eoreq	r0, lr, r0, lsl #24
 154:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 158:	0b3b0b3a 	bleq	ec2e48 <__bss_end+0xeb9e68>
 15c:	01110b39 	tsteq	r1, r9, lsr fp
 160:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 164:	00194297 	mulseq	r9, r7, r2
 168:	01390d00 	teqeq	r9, r0, lsl #26
 16c:	0b3a0e03 	bleq	e83980 <__bss_end+0xe7a9a0>
 170:	13010b3b 	movwne	r0, #6971	; 0x1b3b
 174:	2e0e0000 	cdpcs	0, 0, cr0, cr14, cr0, {0}
 178:	03193f01 	tsteq	r9, #1, 30
 17c:	3b0b3a0e 	blcc	2ce9bc <__bss_end+0x2c59dc>
 180:	3c0b390b 			; <UNDEFINED> instruction: 0x3c0b390b
 184:	00130119 	andseq	r0, r3, r9, lsl r1
 188:	00050f00 	andeq	r0, r5, r0, lsl #30
 18c:	00001349 	andeq	r1, r0, r9, asr #6
 190:	3f012e10 	svccc	0x00012e10
 194:	3a0e0319 	bcc	380e00 <__bss_end+0x377e20>
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
 1c0:	3a080300 	bcc	200dc8 <__bss_end+0x1f7de8>
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
 1f4:	0b0b0024 	bleq	2c028c <__bss_end+0x2b72ac>
 1f8:	0e030b3e 	vmoveq.16	d3[0], r0
 1fc:	24030000 	strcs	r0, [r3], #-0
 200:	3e0b0b00 	vmlacc.f64	d0, d11, d0
 204:	0008030b 	andeq	r0, r8, fp, lsl #6
 208:	00160400 	andseq	r0, r6, r0, lsl #8
 20c:	0b3a0e03 	bleq	e83a20 <__bss_end+0xe7aa40>
 210:	0b390b3b 	bleq	e42f04 <__bss_end+0xe39f24>
 214:	00001349 	andeq	r1, r0, r9, asr #6
 218:	49002605 	stmdbmi	r0, {r0, r2, r9, sl, sp}
 21c:	06000013 			; <UNDEFINED> instruction: 0x06000013
 220:	0e030113 	mcreq	1, 0, r0, cr3, cr3, {0}
 224:	0b3a0b0b 	bleq	e82e58 <__bss_end+0xe79e78>
 228:	0b390b3b 	bleq	e42f1c <__bss_end+0xe39f3c>
 22c:	00001301 	andeq	r1, r0, r1, lsl #6
 230:	03000d07 	movweq	r0, #3335	; 0xd07
 234:	3b0b3a08 	blcc	2cea5c <__bss_end+0x2c5a7c>
 238:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 23c:	000b3813 	andeq	r3, fp, r3, lsl r8
 240:	01040800 	tsteq	r4, r0, lsl #16
 244:	196d0e03 	stmdbne	sp!, {r0, r1, r9, sl, fp}^
 248:	0b0b0b3e 	bleq	2c2f48 <__bss_end+0x2b9f68>
 24c:	0b3a1349 	bleq	e84f78 <__bss_end+0xe7bf98>
 250:	0b390b3b 	bleq	e42f44 <__bss_end+0xe39f64>
 254:	00001301 	andeq	r1, r0, r1, lsl #6
 258:	03002809 	movweq	r2, #2057	; 0x809
 25c:	000b1c0e 	andeq	r1, fp, lr, lsl #24
 260:	00340a00 	eorseq	r0, r4, r0, lsl #20
 264:	0b3a0e03 	bleq	e83a78 <__bss_end+0xe7aa98>
 268:	0b390b3b 	bleq	e42f5c <__bss_end+0xe39f7c>
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
 294:	0b3b0b3a 	bleq	ec2f84 <__bss_end+0xeb9fa4>
 298:	13490b39 	movtne	r0, #39737	; 0x9b39
 29c:	00000b38 	andeq	r0, r0, r8, lsr fp
 2a0:	4901010f 	stmdbmi	r1, {r0, r1, r2, r3, r8}
 2a4:	00130113 	andseq	r0, r3, r3, lsl r1
 2a8:	00211000 	eoreq	r1, r1, r0
 2ac:	0b2f1349 	bleq	bc4fd8 <__bss_end+0xbbbff8>
 2b0:	02110000 	andseq	r0, r1, #0
 2b4:	0b0e0301 	bleq	380ec0 <__bss_end+0x377ee0>
 2b8:	3b0b3a0b 	blcc	2ceaec <__bss_end+0x2c5b0c>
 2bc:	010b390b 	tsteq	fp, fp, lsl #18
 2c0:	12000013 	andne	r0, r0, #19
 2c4:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 2c8:	0b3a0e03 	bleq	e83adc <__bss_end+0xe7aafc>
 2cc:	0b390b3b 	bleq	e42fc0 <__bss_end+0xe39fe0>
 2d0:	193c0e6e 	ldmdbne	ip!, {r1, r2, r3, r5, r6, r9, sl, fp}
 2d4:	13011364 	movwne	r1, #4964	; 0x1364
 2d8:	05130000 	ldreq	r0, [r3, #-0]
 2dc:	34134900 	ldrcc	r4, [r3], #-2304	; 0xfffff700
 2e0:	14000019 	strne	r0, [r0], #-25	; 0xffffffe7
 2e4:	13490005 	movtne	r0, #36869	; 0x9005
 2e8:	2e150000 	cdpcs	0, 1, cr0, cr5, cr0, {0}
 2ec:	03193f01 	tsteq	r9, #1, 30
 2f0:	3b0b3a0e 	blcc	2ceb30 <__bss_end+0x2c5b50>
 2f4:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 2f8:	3c13490e 			; <UNDEFINED> instruction: 0x3c13490e
 2fc:	01136419 	tsteq	r3, r9, lsl r4
 300:	16000013 			; <UNDEFINED> instruction: 0x16000013
 304:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 308:	0b3a0e03 	bleq	e83b1c <__bss_end+0xe7ab3c>
 30c:	0b390b3b 	bleq	e43000 <__bss_end+0xe3a020>
 310:	13490e6e 	movtne	r0, #40558	; 0x9e6e
 314:	193c0b32 	ldmdbne	ip!, {r1, r4, r5, r8, r9, fp}
 318:	13011364 	movwne	r1, #4964	; 0x1364
 31c:	0d170000 	ldceq	0, cr0, [r7, #-0]
 320:	3a0e0300 	bcc	380f28 <__bss_end+0x377f48>
 324:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 328:	3813490b 	ldmdacc	r3, {r0, r1, r3, r8, fp, lr}
 32c:	000b320b 	andeq	r3, fp, fp, lsl #4
 330:	012e1800 			; <UNDEFINED> instruction: 0x012e1800
 334:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 338:	0b3b0b3a 	bleq	ec3028 <__bss_end+0xeba048>
 33c:	0e6e0b39 	vmoveq.8	d14[5], r0
 340:	193c0b32 	ldmdbne	ip!, {r1, r4, r5, r8, r9, fp}
 344:	13011364 	movwne	r1, #4964	; 0x1364
 348:	2e190000 	cdpcs	0, 1, cr0, cr9, cr0, {0}
 34c:	03193f01 	tsteq	r9, #1, 30
 350:	3b0b3a0e 	blcc	2ceb90 <__bss_end+0x2c5bb0>
 354:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 358:	3213490e 	andscc	r4, r3, #229376	; 0x38000
 35c:	64193c0b 	ldrvs	r3, [r9], #-3083	; 0xfffff3f5
 360:	1a000013 	bne	3b4 <shift+0x3b4>
 364:	13490115 	movtne	r0, #37141	; 0x9115
 368:	13011364 	movwne	r1, #4964	; 0x1364
 36c:	1f1b0000 	svcne	0x001b0000
 370:	49131d00 	ldmdbmi	r3, {r8, sl, fp, ip}
 374:	1c000013 	stcne	0, cr0, [r0], {19}
 378:	0b0b0010 	bleq	2c03c0 <__bss_end+0x2b73e0>
 37c:	00001349 	andeq	r1, r0, r9, asr #6
 380:	0b000f1d 	bleq	3ffc <shift+0x3ffc>
 384:	1e00000b 	cdpne	0, 0, cr0, cr0, cr11, {0}
 388:	08030139 	stmdaeq	r3, {r0, r3, r4, r5, r8}
 38c:	0b3b0b3a 	bleq	ec307c <__bss_end+0xeba09c>
 390:	13010b39 	movwne	r0, #6969	; 0x1b39
 394:	341f0000 	ldrcc	r0, [pc], #-0	; 39c <shift+0x39c>
 398:	3a0e0300 	bcc	380fa0 <__bss_end+0x377fc0>
 39c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 3a0:	3c13490b 			; <UNDEFINED> instruction: 0x3c13490b
 3a4:	6c061c19 	stcvs	12, cr1, [r6], {25}
 3a8:	20000019 	andcs	r0, r0, r9, lsl r0
 3ac:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 3b0:	0b3b0b3a 	bleq	ec30a0 <__bss_end+0xeba0c0>
 3b4:	13490b39 	movtne	r0, #39737	; 0x9b39
 3b8:	0b1c193c 	bleq	7068b0 <__bss_end+0x6fd8d0>
 3bc:	0000196c 	andeq	r1, r0, ip, ror #18
 3c0:	47003421 	strmi	r3, [r0, -r1, lsr #8]
 3c4:	22000013 	andcs	r0, r0, #19
 3c8:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 3cc:	0b3b0b3a 	bleq	ec30bc <__bss_end+0xeba0dc>
 3d0:	13490b39 	movtne	r0, #39737	; 0x9b39
 3d4:	1802193f 	stmdane	r2, {r0, r1, r2, r3, r4, r5, r8, fp, ip}
 3d8:	2e230000 	cdpcs	0, 2, cr0, cr3, cr0, {0}
 3dc:	03193f01 	tsteq	r9, #1, 30
 3e0:	3b0b3a0e 	blcc	2cec20 <__bss_end+0x2c5c40>
 3e4:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 3e8:	12011113 	andne	r1, r1, #-1073741820	; 0xc0000004
 3ec:	96184006 	ldrls	r4, [r8], -r6
 3f0:	13011942 	movwne	r1, #6466	; 0x1942
 3f4:	05240000 	streq	r0, [r4, #-0]!
 3f8:	3a0e0300 	bcc	381000 <__bss_end+0x378020>
 3fc:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 400:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 404:	25000018 	strcs	r0, [r0, #-24]	; 0xffffffe8
 408:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 40c:	0b3b0b3a 	bleq	ec30fc <__bss_end+0xeba11c>
 410:	13490b39 	movtne	r0, #39737	; 0x9b39
 414:	00001802 	andeq	r1, r0, r2, lsl #16
 418:	03003426 	movweq	r3, #1062	; 0x426
 41c:	3b0b3a0e 	blcc	2cec5c <__bss_end+0x2c5c7c>
 420:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 424:	27000013 	smladcs	r0, r3, r0, r0
 428:	0111010b 	tsteq	r1, fp, lsl #2
 42c:	00000612 	andeq	r0, r0, r2, lsl r6
 430:	3f012e28 	svccc	0x00012e28
 434:	3a0e0319 	bcc	3810a0 <__bss_end+0x3780c0>
 438:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 43c:	110e6e0b 	tstne	lr, fp, lsl #28
 440:	40061201 	andmi	r1, r6, r1, lsl #4
 444:	19429618 	stmdbne	r2, {r3, r4, r9, sl, ip, pc}^
 448:	00001301 	andeq	r1, r0, r1, lsl #6
 44c:	3f002e29 	svccc	0x00002e29
 450:	3a0e0319 	bcc	3810bc <__bss_end+0x3780dc>
 454:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 458:	110e6e0b 	tstne	lr, fp, lsl #28
 45c:	40061201 	andmi	r1, r6, r1, lsl #4
 460:	19429618 	stmdbne	r2, {r3, r4, r9, sl, ip, pc}^
 464:	01000000 	mrseq	r0, (UNDEF: 0)
 468:	0e250111 	mcreq	1, 1, r0, cr5, cr1, {0}
 46c:	0e030b13 	vmoveq.32	d3[0], r0
 470:	01110e1b 	tsteq	r1, fp, lsl lr
 474:	17100612 			; <UNDEFINED> instruction: 0x17100612
 478:	24020000 	strcs	r0, [r2], #-0
 47c:	3e0b0b00 	vmlacc.f64	d0, d11, d0
 480:	000e030b 	andeq	r0, lr, fp, lsl #6
 484:	00260300 	eoreq	r0, r6, r0, lsl #6
 488:	00001349 	andeq	r1, r0, r9, asr #6
 48c:	0b002404 	bleq	94a4 <__bss_end+0x4c4>
 490:	030b3e0b 	movweq	r3, #48651	; 0xbe0b
 494:	05000008 	streq	r0, [r0, #-8]
 498:	0e030016 	mcreq	0, 0, r0, cr3, cr6, {0}
 49c:	0b3b0b3a 	bleq	ec318c <__bss_end+0xeba1ac>
 4a0:	13490b39 	movtne	r0, #39737	; 0x9b39
 4a4:	13060000 	movwne	r0, #24576	; 0x6000
 4a8:	0b0e0301 	bleq	3810b4 <__bss_end+0x3780d4>
 4ac:	3b0b3a0b 	blcc	2cece0 <__bss_end+0x2c5d00>
 4b0:	010b390b 	tsteq	fp, fp, lsl #18
 4b4:	07000013 	smladeq	r0, r3, r0, r0
 4b8:	0803000d 	stmdaeq	r3, {r0, r2, r3}
 4bc:	0b3b0b3a 	bleq	ec31ac <__bss_end+0xeba1cc>
 4c0:	13490b39 	movtne	r0, #39737	; 0x9b39
 4c4:	00000b38 	andeq	r0, r0, r8, lsr fp
 4c8:	03010408 	movweq	r0, #5128	; 0x1408
 4cc:	3e196d0e 	cdpcc	13, 1, cr6, cr9, cr14, {0}
 4d0:	490b0b0b 	stmdbmi	fp, {r0, r1, r3, r8, r9, fp}
 4d4:	3b0b3a13 	blcc	2ced28 <__bss_end+0x2c5d48>
 4d8:	010b390b 	tsteq	fp, fp, lsl #18
 4dc:	09000013 	stmdbeq	r0, {r0, r1, r4}
 4e0:	08030028 	stmdaeq	r3, {r3, r5}
 4e4:	00000b1c 	andeq	r0, r0, ip, lsl fp
 4e8:	0300280a 	movweq	r2, #2058	; 0x80a
 4ec:	000b1c0e 	andeq	r1, fp, lr, lsl #24
 4f0:	00340b00 	eorseq	r0, r4, r0, lsl #22
 4f4:	0b3a0e03 	bleq	e83d08 <__bss_end+0xe7ad28>
 4f8:	0b390b3b 	bleq	e431ec <__bss_end+0xe3a20c>
 4fc:	196c1349 	stmdbne	ip!, {r0, r3, r6, r8, r9, ip}^
 500:	00001802 	andeq	r1, r0, r2, lsl #16
 504:	0300020c 	movweq	r0, #524	; 0x20c
 508:	00193c0e 	andseq	r3, r9, lr, lsl #24
 50c:	000f0d00 	andeq	r0, pc, r0, lsl #26
 510:	13490b0b 	movtne	r0, #39691	; 0x9b0b
 514:	0d0e0000 	stceq	0, cr0, [lr, #-0]
 518:	3a0e0300 	bcc	381120 <__bss_end+0x378140>
 51c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 520:	3813490b 	ldmdacc	r3, {r0, r1, r3, r8, fp, lr}
 524:	0f00000b 	svceq	0x0000000b
 528:	13490101 	movtne	r0, #37121	; 0x9101
 52c:	00001301 	andeq	r1, r0, r1, lsl #6
 530:	49002110 	stmdbmi	r0, {r4, r8, sp}
 534:	000b2f13 	andeq	r2, fp, r3, lsl pc
 538:	01021100 	mrseq	r1, (UNDEF: 18)
 53c:	0b0b0e03 	bleq	2c3d50 <__bss_end+0x2bad70>
 540:	0b3b0b3a 	bleq	ec3230 <__bss_end+0xeba250>
 544:	13010b39 	movwne	r0, #6969	; 0x1b39
 548:	2e120000 	cdpcs	0, 1, cr0, cr2, cr0, {0}
 54c:	03193f01 	tsteq	r9, #1, 30
 550:	3b0b3a0e 	blcc	2ced90 <__bss_end+0x2c5db0>
 554:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 558:	64193c0e 	ldrvs	r3, [r9], #-3086	; 0xfffff3f2
 55c:	00130113 	andseq	r0, r3, r3, lsl r1
 560:	00051300 	andeq	r1, r5, r0, lsl #6
 564:	19341349 	ldmdbne	r4!, {r0, r3, r6, r8, r9, ip}
 568:	05140000 	ldreq	r0, [r4, #-0]
 56c:	00134900 	andseq	r4, r3, r0, lsl #18
 570:	012e1500 			; <UNDEFINED> instruction: 0x012e1500
 574:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 578:	0b3b0b3a 	bleq	ec3268 <__bss_end+0xeba288>
 57c:	0e6e0b39 	vmoveq.8	d14[5], r0
 580:	193c1349 	ldmdbne	ip!, {r0, r3, r6, r8, r9, ip}
 584:	13011364 	movwne	r1, #4964	; 0x1364
 588:	2e160000 	cdpcs	0, 1, cr0, cr6, cr0, {0}
 58c:	03193f01 	tsteq	r9, #1, 30
 590:	3b0b3a0e 	blcc	2cedd0 <__bss_end+0x2c5df0>
 594:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 598:	3213490e 	andscc	r4, r3, #229376	; 0x38000
 59c:	64193c0b 	ldrvs	r3, [r9], #-3083	; 0xfffff3f5
 5a0:	00130113 	andseq	r0, r3, r3, lsl r1
 5a4:	000d1700 	andeq	r1, sp, r0, lsl #14
 5a8:	0b3a0e03 	bleq	e83dbc <__bss_end+0xe7addc>
 5ac:	0b390b3b 	bleq	e432a0 <__bss_end+0xe3a2c0>
 5b0:	0b381349 	bleq	e052dc <__bss_end+0xdfc2fc>
 5b4:	00000b32 	andeq	r0, r0, r2, lsr fp
 5b8:	3f012e18 	svccc	0x00012e18
 5bc:	3a0e0319 	bcc	381228 <__bss_end+0x378248>
 5c0:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 5c4:	320e6e0b 	andcc	r6, lr, #11, 28	; 0xb0
 5c8:	64193c0b 	ldrvs	r3, [r9], #-3083	; 0xfffff3f5
 5cc:	00130113 	andseq	r0, r3, r3, lsl r1
 5d0:	012e1900 			; <UNDEFINED> instruction: 0x012e1900
 5d4:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 5d8:	0b3b0b3a 	bleq	ec32c8 <__bss_end+0xeba2e8>
 5dc:	0e6e0b39 	vmoveq.8	d14[5], r0
 5e0:	0b321349 	bleq	c8530c <__bss_end+0xc7c32c>
 5e4:	1364193c 	cmnne	r4, #60, 18	; 0xf0000
 5e8:	151a0000 	ldrne	r0, [sl, #-0]
 5ec:	64134901 	ldrvs	r4, [r3], #-2305	; 0xfffff6ff
 5f0:	00130113 	andseq	r0, r3, r3, lsl r1
 5f4:	001f1b00 	andseq	r1, pc, r0, lsl #22
 5f8:	1349131d 	movtne	r1, #37661	; 0x931d
 5fc:	101c0000 	andsne	r0, ip, r0
 600:	490b0b00 	stmdbmi	fp, {r8, r9, fp}
 604:	1d000013 	stcne	0, cr0, [r0, #-76]	; 0xffffffb4
 608:	0b0b000f 	bleq	2c064c <__bss_end+0x2b766c>
 60c:	341e0000 	ldrcc	r0, [lr], #-0
 610:	3a0e0300 	bcc	381218 <__bss_end+0x378238>
 614:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 618:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 61c:	1f000018 	svcne	0x00000018
 620:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 624:	0b3a0e03 	bleq	e83e38 <__bss_end+0xe7ae58>
 628:	0b390b3b 	bleq	e4331c <__bss_end+0xe3a33c>
 62c:	13490e6e 	movtne	r0, #40558	; 0x9e6e
 630:	06120111 			; <UNDEFINED> instruction: 0x06120111
 634:	42961840 	addsmi	r1, r6, #64, 16	; 0x400000
 638:	00130119 	andseq	r0, r3, r9, lsl r1
 63c:	00052000 	andeq	r2, r5, r0
 640:	0b3a0e03 	bleq	e83e54 <__bss_end+0xe7ae74>
 644:	0b390b3b 	bleq	e43338 <__bss_end+0xe3a358>
 648:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 64c:	2e210000 	cdpcs	0, 2, cr0, cr1, cr0, {0}
 650:	03193f01 	tsteq	r9, #1, 30
 654:	3b0b3a0e 	blcc	2cee94 <__bss_end+0x2c5eb4>
 658:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 65c:	1113490e 	tstne	r3, lr, lsl #18
 660:	40061201 	andmi	r1, r6, r1, lsl #4
 664:	19429718 	stmdbne	r2, {r3, r4, r8, r9, sl, ip, pc}^
 668:	00001301 	andeq	r1, r0, r1, lsl #6
 66c:	03003422 	movweq	r3, #1058	; 0x422
 670:	3b0b3a08 	blcc	2cee98 <__bss_end+0x2c5eb8>
 674:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 678:	00180213 	andseq	r0, r8, r3, lsl r2
 67c:	012e2300 			; <UNDEFINED> instruction: 0x012e2300
 680:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 684:	0b3b0b3a 	bleq	ec3374 <__bss_end+0xeba394>
 688:	0e6e0b39 	vmoveq.8	d14[5], r0
 68c:	06120111 			; <UNDEFINED> instruction: 0x06120111
 690:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
 694:	00130119 	andseq	r0, r3, r9, lsl r1
 698:	002e2400 	eoreq	r2, lr, r0, lsl #8
 69c:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 6a0:	0b3b0b3a 	bleq	ec3390 <__bss_end+0xeba3b0>
 6a4:	0e6e0b39 	vmoveq.8	d14[5], r0
 6a8:	06120111 			; <UNDEFINED> instruction: 0x06120111
 6ac:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
 6b0:	25000019 	strcs	r0, [r0, #-25]	; 0xffffffe7
 6b4:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 6b8:	0b3a0e03 	bleq	e83ecc <__bss_end+0xe7aeec>
 6bc:	0b390b3b 	bleq	e433b0 <__bss_end+0xe3a3d0>
 6c0:	13490e6e 	movtne	r0, #40558	; 0x9e6e
 6c4:	06120111 			; <UNDEFINED> instruction: 0x06120111
 6c8:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
 6cc:	00000019 	andeq	r0, r0, r9, lsl r0
 6d0:	25011101 	strcs	r1, [r1, #-257]	; 0xfffffeff
 6d4:	030b130e 	movweq	r1, #45838	; 0xb30e
 6d8:	110e1b0e 	tstne	lr, lr, lsl #22
 6dc:	10061201 	andne	r1, r6, r1, lsl #4
 6e0:	02000017 	andeq	r0, r0, #23
 6e4:	13010139 	movwne	r0, #4409	; 0x1139
 6e8:	34030000 	strcc	r0, [r3], #-0
 6ec:	3a0e0300 	bcc	3812f4 <__bss_end+0x378314>
 6f0:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 6f4:	3c13490b 			; <UNDEFINED> instruction: 0x3c13490b
 6f8:	000a1c19 	andeq	r1, sl, r9, lsl ip
 6fc:	003a0400 	eorseq	r0, sl, r0, lsl #8
 700:	0b3b0b3a 	bleq	ec33f0 <__bss_end+0xeba410>
 704:	13180b39 	tstne	r8, #58368	; 0xe400
 708:	01050000 	mrseq	r0, (UNDEF: 5)
 70c:	01134901 	tsteq	r3, r1, lsl #18
 710:	06000013 			; <UNDEFINED> instruction: 0x06000013
 714:	13490021 	movtne	r0, #36897	; 0x9021
 718:	00000b2f 	andeq	r0, r0, pc, lsr #22
 71c:	49002607 	stmdbmi	r0, {r0, r1, r2, r9, sl, sp}
 720:	08000013 	stmdaeq	r0, {r0, r1, r4}
 724:	0b0b0024 	bleq	2c07bc <__bss_end+0x2b77dc>
 728:	0e030b3e 	vmoveq.16	d3[0], r0
 72c:	34090000 	strcc	r0, [r9], #-0
 730:	00134700 	andseq	r4, r3, r0, lsl #14
 734:	012e0a00 			; <UNDEFINED> instruction: 0x012e0a00
 738:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 73c:	0b3b0b3a 	bleq	ec342c <__bss_end+0xeba44c>
 740:	0e6e0b39 	vmoveq.8	d14[5], r0
 744:	06120111 			; <UNDEFINED> instruction: 0x06120111
 748:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
 74c:	00130119 	andseq	r0, r3, r9, lsl r1
 750:	00050b00 	andeq	r0, r5, r0, lsl #22
 754:	0b3a0803 	bleq	e82768 <__bss_end+0xe79788>
 758:	0b390b3b 	bleq	e4344c <__bss_end+0xe3a46c>
 75c:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 760:	340c0000 	strcc	r0, [ip], #-0
 764:	3a0e0300 	bcc	38136c <__bss_end+0x37838c>
 768:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 76c:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 770:	0d000018 	stceq	0, cr0, [r0, #-96]	; 0xffffffa0
 774:	0111010b 	tsteq	r1, fp, lsl #2
 778:	00000612 	andeq	r0, r0, r2, lsl r6
 77c:	0300340e 	movweq	r3, #1038	; 0x40e
 780:	3b0b3a08 	blcc	2cefa8 <__bss_end+0x2c5fc8>
 784:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 788:	00180213 	andseq	r0, r8, r3, lsl r2
 78c:	000f0f00 	andeq	r0, pc, r0, lsl #30
 790:	13490b0b 	movtne	r0, #39691	; 0x9b0b
 794:	26100000 	ldrcs	r0, [r0], -r0
 798:	11000000 	mrsne	r0, (UNDEF: 0)
 79c:	0b0b000f 	bleq	2c07e0 <__bss_end+0x2b7800>
 7a0:	24120000 	ldrcs	r0, [r2], #-0
 7a4:	3e0b0b00 	vmlacc.f64	d0, d11, d0
 7a8:	0008030b 	andeq	r0, r8, fp, lsl #6
 7ac:	00051300 	andeq	r1, r5, r0, lsl #6
 7b0:	0b3a0e03 	bleq	e83fc4 <__bss_end+0xe7afe4>
 7b4:	0b390b3b 	bleq	e434a8 <__bss_end+0xe3a4c8>
 7b8:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 7bc:	2e140000 	cdpcs	0, 1, cr0, cr4, cr0, {0}
 7c0:	03193f01 	tsteq	r9, #1, 30
 7c4:	3b0b3a0e 	blcc	2cf004 <__bss_end+0x2c6024>
 7c8:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 7cc:	1113490e 	tstne	r3, lr, lsl #18
 7d0:	40061201 	andmi	r1, r6, r1, lsl #4
 7d4:	19429718 	stmdbne	r2, {r3, r4, r8, r9, sl, ip, pc}^
 7d8:	00001301 	andeq	r1, r0, r1, lsl #6
 7dc:	3f012e15 	svccc	0x00012e15
 7e0:	3a0e0319 	bcc	38144c <__bss_end+0x37846c>
 7e4:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 7e8:	110e6e0b 	tstne	lr, fp, lsl #28
 7ec:	40061201 	andmi	r1, r6, r1, lsl #4
 7f0:	19429618 	stmdbne	r2, {r3, r4, r9, sl, ip, pc}^
 7f4:	Address 0x00000000000007f4 is out of bounds.


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
  74:	00000188 	andeq	r0, r0, r8, lsl #3
	...
  80:	0000001c 	andeq	r0, r0, ip, lsl r0
  84:	0b6c0002 	bleq	1b00094 <__bss_end+0x1af70b4>
  88:	00040000 	andeq	r0, r4, r0
  8c:	00000000 	andeq	r0, r0, r0
  90:	000083b4 			; <UNDEFINED> instruction: 0x000083b4
  94:	0000045c 	andeq	r0, r0, ip, asr r4
	...
  a0:	0000001c 	andeq	r0, r0, ip, lsl r0
  a4:	168f0002 	strne	r0, [pc], r2
  a8:	00040000 	andeq	r0, r4, r0
  ac:	00000000 	andeq	r0, r0, r0
  b0:	00008810 	andeq	r8, r0, r0, lsl r8
  b4:	000004b8 			; <UNDEFINED> instruction: 0x000004b8
	...

Disassembly of section .debug_str:

00000000 <.debug_str>:
       0:	6573552f 	ldrbvs	r5, [r3, #-1327]!	; 0xfffffad1
       4:	772f7372 			; <UNDEFINED> instruction: 0x772f7372
       8:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
       c:	2f696a72 	svccs	0x00696a72
      10:	6b736544 	blvs	1cd9528 <__bss_end+0x1cd0548>
      14:	2f706f74 	svccs	0x00706f74
      18:	2f564146 	svccs	0x00564146
      1c:	6176614e 	cmnvs	r6, lr, asr #2
      20:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
      24:	4f2f6963 	svcmi	0x002f6963
      28:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
      2c:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
      30:	6b6c6172 	blvs	1b18600 <__bss_end+0x1b0f620>
      34:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
      38:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
      3c:	756f732f 	strbvc	r7, [pc, #-815]!	; fffffd15 <__bss_end+0xffff6d35>
      40:	73656372 	cmnvc	r5, #-939524095	; 0xc8000001
      44:	6573752f 	ldrbvs	r7, [r3, #-1327]!	; 0xfffffad1
      48:	61707372 	cmnvs	r0, r2, ror r3
      4c:	632f6563 			; <UNDEFINED> instruction: 0x632f6563
      50:	2e307472 	mrccs	4, 1, r7, cr0, cr2, {3}
      54:	552f0073 	strpl	r0, [pc, #-115]!	; ffffffe9 <__bss_end+0xffff7009>
      58:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
      5c:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
      60:	6a726574 	bvs	1c99638 <__bss_end+0x1c90658>
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
      98:	752f7365 	strvc	r7, [pc, #-869]!	; fffffd3b <__bss_end+0xffff6d5b>
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
     12c:	6a363731 	bvs	d8ddf8 <__bss_end+0xd84e18>
     130:	732d667a 			; <UNDEFINED> instruction: 0x732d667a
     134:	616d2d20 	cmnvs	sp, r0, lsr #26
     138:	2d206d72 	stccs	13, cr6, [r0, #-456]!	; 0xfffffe38
     13c:	6372616d 	cmnvs	r2, #1073741851	; 0x4000001b
     140:	72613d68 	rsbvc	r3, r1, #104, 26	; 0x1a00
     144:	7a36766d 	bvc	d9db00 <__bss_end+0xd94b20>
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
     184:	6a757a61 	bvs	1d5eb10 <__bss_end+0x1d55b30>
     188:	2f696369 	svccs	0x00696369
     18c:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
     190:	73656d65 	cmnvc	r5, #6464	; 0x1940
     194:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
     198:	6b2d616b 	blvs	b5874c <__bss_end+0xb4f76c>
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
     1e4:	2b2b4320 	blcs	ad0e6c <__bss_end+0xac7e8c>
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
     260:	2b6b7a36 	blcs	1adeb40 <__bss_end+0x1ad5b60>
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
     294:	755f6962 	ldrbvc	r6, [pc, #-2402]	; fffff93a <__bss_end+0xffff695a>
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
     324:	6b736544 	blvs	1cd983c <__bss_end+0x1cd085c>
     328:	2f706f74 	svccs	0x00706f74
     32c:	2f564146 	svccs	0x00564146
     330:	6176614e 	cmnvs	r6, lr, asr #2
     334:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
     338:	4f2f6963 	svcmi	0x002f6963
     33c:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
     340:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
     344:	6b6c6172 	blvs	1b18914 <__bss_end+0x1b0f934>
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
     41c:	6b636f6c 	blvs	18dc1d4 <__bss_end+0x18d31f4>
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
     480:	6e727400 	cdpvs	4, 7, cr7, cr2, cr0, {0}
     484:	53420067 	movtpl	r0, #8295	; 0x2067
     488:	425f3243 	subsmi	r3, pc, #805306372	; 0x30000004
     48c:	00657361 	rsbeq	r7, r5, r1, ror #6
     490:	6f72506d 	svcvs	0x0072506d
     494:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     498:	73694c5f 	cmnvc	r9, #24320	; 0x5f00
     49c:	65485f74 	strbvs	r5, [r8, #-3956]	; 0xfffff08c
     4a0:	5f006461 	svcpl	0x00006461
     4a4:	314b4e5a 	cmpcc	fp, sl, asr lr
     4a8:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     4ac:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     4b0:	614d5f73 	hvcvs	54771	; 0xd5f3
     4b4:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     4b8:	47393172 			; <UNDEFINED> instruction: 0x47393172
     4bc:	435f7465 	cmpmi	pc, #1694498816	; 0x65000000
     4c0:	65727275 	ldrbvs	r7, [r2, #-629]!	; 0xfffffd8b
     4c4:	505f746e 	subspl	r7, pc, lr, ror #8
     4c8:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     4cc:	76457373 			; <UNDEFINED> instruction: 0x76457373
     4d0:	78656e00 	stmdavc	r5!, {r9, sl, fp, sp, lr}^
     4d4:	65470074 	strbvs	r0, [r7, #-116]	; 0xffffff8c
     4d8:	72505f74 	subsvc	r5, r0, #116, 30	; 0x1d0
     4dc:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     4e0:	79425f73 	stmdbvc	r2, {r0, r1, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     4e4:	4449505f 	strbmi	r5, [r9], #-95	; 0xffffffa1
     4e8:	6d657400 	cfstrdvs	mvd7, [r5, #-0]
     4ec:	75625f70 	strbvc	r5, [r2, #-3952]!	; 0xfffff090
     4f0:	54006666 	strpl	r6, [r0], #-1638	; 0xfffff99a
     4f4:	72656d69 	rsbvc	r6, r5, #6720	; 0x1a40
     4f8:	7361425f 	cmnvc	r1, #-268435451	; 0xf0000005
     4fc:	534e0065 	movtpl	r0, #57445	; 0xe065
     500:	505f4957 	subspl	r4, pc, r7, asr r9	; <UNPREDICTABLE>
     504:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     508:	535f7373 	cmppl	pc, #-872415231	; 0xcc000001
     50c:	69767265 	ldmdbvs	r6!, {r0, r2, r5, r6, r9, ip, sp, lr}^
     510:	52006563 	andpl	r6, r0, #415236096	; 0x18c00000
     514:	00646165 	rsbeq	r6, r4, r5, ror #2
     518:	69746341 	ldmdbvs	r4!, {r0, r6, r8, r9, sp, lr}^
     51c:	505f6576 	subspl	r6, pc, r6, ror r5	; <UNPREDICTABLE>
     520:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     524:	435f7373 	cmpmi	pc, #-872415231	; 0xcc000001
     528:	746e756f 	strbtvc	r7, [lr], #-1391	; 0xfffffa91
     52c:	65724300 	ldrbvs	r4, [r2, #-768]!	; 0xfffffd00
     530:	5f657461 	svcpl	0x00657461
     534:	636f7250 	cmnvs	pc, #80, 4
     538:	00737365 	rsbseq	r7, r3, r5, ror #6
     53c:	74617473 	strbtvc	r7, [r1], #-1139	; 0xfffffb8d
     540:	614d0065 	cmpvs	sp, r5, rrx
     544:	6c694678 	stclvs	6, cr4, [r9], #-480	; 0xfffffe20
     548:	6d616e65 	stclvs	14, cr6, [r1, #-404]!	; 0xfffffe6c
     54c:	6e654c65 	cdpvs	12, 6, cr4, cr5, cr5, {3}
     550:	00687467 	rsbeq	r7, r8, r7, ror #8
     554:	5f585541 	svcpl	0x00585541
     558:	65736142 	ldrbvs	r6, [r3, #-322]!	; 0xfffffebe
     55c:	74654700 	strbtvc	r4, [r5], #-1792	; 0xfffff900
     560:	6863535f 	stmdavs	r3!, {r0, r1, r2, r3, r4, r6, r8, r9, ip, lr}^
     564:	6c756465 	cfldrdvs	mvd6, [r5], #-404	; 0xfffffe6c
     568:	495f7265 	ldmdbmi	pc, {r0, r2, r5, r6, r9, ip, sp, lr}^	; <UNPREDICTABLE>
     56c:	006f666e 	rsbeq	r6, pc, lr, ror #12
     570:	64616544 	strbtvs	r6, [r1], #-1348	; 0xfffffabc
     574:	656e696c 	strbvs	r6, [lr, #-2412]!	; 0xfffff694
     578:	636e555f 	cmnvs	lr, #398458880	; 0x17c00000
     57c:	676e6168 	strbvs	r6, [lr, -r8, ror #2]!
     580:	43006465 	movwmi	r6, #1125	; 0x465
     584:	636f7250 	cmnvs	pc, #80, 4
     588:	5f737365 	svcpl	0x00737365
     58c:	616e614d 	cmnvs	lr, sp, asr #2
     590:	00726567 	rsbseq	r6, r2, r7, ror #10
     594:	72616863 	rsbvc	r6, r1, #6488064	; 0x630000
     598:	6369745f 	cmnvs	r9, #1593835520	; 0x5f000000
     59c:	65645f6b 	strbvs	r5, [r4, #-3947]!	; 0xfffff095
     5a0:	0079616c 	rsbseq	r6, r9, ip, ror #2
     5a4:	314e5a5f 	cmpcc	lr, pc, asr sl
     5a8:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     5ac:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     5b0:	614d5f73 	hvcvs	54771	; 0xd5f3
     5b4:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     5b8:	47383172 			; <UNDEFINED> instruction: 0x47383172
     5bc:	535f7465 	cmppl	pc, #1694498816	; 0x65000000
     5c0:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     5c4:	72656c75 	rsbvc	r6, r5, #29952	; 0x7500
     5c8:	666e495f 			; <UNDEFINED> instruction: 0x666e495f
     5cc:	3032456f 	eorscc	r4, r2, pc, ror #10
     5d0:	7465474e 	strbtvc	r4, [r5], #-1870	; 0xfffff8b2
     5d4:	6863535f 	stmdavs	r3!, {r0, r1, r2, r3, r4, r6, r8, r9, ip, lr}^
     5d8:	495f6465 	ldmdbmi	pc, {r0, r2, r5, r6, sl, sp, lr}^	; <UNPREDICTABLE>
     5dc:	5f6f666e 	svcpl	0x006f666e
     5e0:	65707954 	ldrbvs	r7, [r0, #-2388]!	; 0xfffff6ac
     5e4:	5f007650 	svcpl	0x00007650
     5e8:	36314e5a 			; <UNDEFINED> instruction: 0x36314e5a
     5ec:	6f725043 	svcvs	0x00725043
     5f0:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     5f4:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     5f8:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     5fc:	61483132 	cmpvs	r8, r2, lsr r1
     600:	656c646e 	strbvs	r6, [ip, #-1134]!	; 0xfffffb92
     604:	6c69465f 	stclvs	6, cr4, [r9], #-380	; 0xfffffe84
     608:	73797365 	cmnvc	r9, #-1811939327	; 0x94000001
     60c:	5f6d6574 	svcpl	0x006d6574
     610:	45495753 	strbmi	r5, [r9, #-1875]	; 0xfffff8ad
     614:	534e3332 	movtpl	r3, #58162	; 0xe332
     618:	465f4957 			; <UNDEFINED> instruction: 0x465f4957
     61c:	73656c69 	cmnvc	r5, #26880	; 0x6900
     620:	65747379 	ldrbvs	r7, [r4, #-889]!	; 0xfffffc87
     624:	65535f6d 	ldrbvs	r5, [r3, #-3949]	; 0xfffff093
     628:	63697672 	cmnvs	r9, #119537664	; 0x7200000
     62c:	6a6a6a65 	bvs	1a9afc8 <__bss_end+0x1a91fe8>
     630:	54313152 	ldrtpl	r3, [r1], #-338	; 0xfffffeae
     634:	5f495753 	svcpl	0x00495753
     638:	75736552 	ldrbvc	r6, [r3, #-1362]!	; 0xfffffaae
     63c:	6f00746c 	svcvs	0x0000746c
     640:	656e6570 	strbvs	r6, [lr, #-1392]!	; 0xfffffa90
     644:	69665f64 	stmdbvs	r6!, {r2, r5, r6, r8, r9, sl, fp, ip, lr}^
     648:	0073656c 	rsbseq	r6, r3, ip, ror #10
     64c:	69746f4e 	ldmdbvs	r4!, {r1, r2, r3, r6, r8, r9, sl, fp, sp, lr}^
     650:	6c417966 	mcrrvs	9, 6, r7, r1, cr6	; <UNPREDICTABLE>
     654:	4354006c 	cmpmi	r4, #108	; 0x6c
     658:	435f5550 	cmpmi	pc, #80, 10	; 0x14000000
     65c:	65746e6f 	ldrbvs	r6, [r4, #-3695]!	; 0xfffff191
     660:	44007478 	strmi	r7, [r0], #-1144	; 0xfffffb88
     664:	6c646165 	stfvse	f6, [r4], #-404	; 0xfffffe6c
     668:	00656e69 	rsbeq	r6, r5, r9, ror #28
     66c:	72627474 	rsbvc	r7, r2, #116, 8	; 0x74000000
     670:	5a5f0030 	bpl	17c0738 <__bss_end+0x17b7758>
     674:	4336314e 	teqmi	r6, #-2147483629	; 0x80000013
     678:	636f7250 	cmnvs	pc, #80, 4
     67c:	5f737365 	svcpl	0x00737365
     680:	616e614d 	cmnvs	lr, sp, asr #2
     684:	31726567 	cmncc	r2, r7, ror #10
     688:	746f4e34 	strbtvc	r4, [pc], #-3636	; 690 <shift+0x690>
     68c:	5f796669 	svcpl	0x00796669
     690:	636f7250 	cmnvs	pc, #80, 4
     694:	45737365 	ldrbmi	r7, [r3, #-869]!	; 0xfffffc9b
     698:	6547006a 	strbvs	r0, [r7, #-106]	; 0xffffff96
     69c:	49505f74 	ldmdbmi	r0, {r2, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     6a0:	53420044 	movtpl	r0, #8260	; 0x2044
     6a4:	425f3043 	subsmi	r3, pc, #67	; 0x43
     6a8:	00657361 	rsbeq	r7, r5, r1, ror #6
     6ac:	69746f6e 	ldmdbvs	r4!, {r1, r2, r3, r5, r6, r8, r9, sl, fp, sp, lr}^
     6b0:	64656966 	strbtvs	r6, [r5], #-2406	; 0xfffff69a
     6b4:	6165645f 	cmnvs	r5, pc, asr r4
     6b8:	6e696c64 	cdpvs	12, 6, cr6, cr9, cr4, {3}
     6bc:	6e490065 	cdpvs	0, 4, cr0, cr9, cr5, {3}
     6c0:	72726574 	rsbsvc	r6, r2, #116, 10	; 0x1d000000
     6c4:	5f747075 	svcpl	0x00747075
     6c8:	746e6f43 	strbtvc	r6, [lr], #-3907	; 0xfffff0bd
     6cc:	6c6c6f72 	stclvs	15, cr6, [ip], #-456	; 0xfffffe38
     6d0:	425f7265 	subsmi	r7, pc, #1342177286	; 0x50000006
     6d4:	00657361 	rsbeq	r7, r5, r1, ror #6
     6d8:	31435342 	cmpcc	r3, r2, asr #6
     6dc:	7361425f 	cmnvc	r1, #-268435451	; 0xf0000005
     6e0:	614d0065 	cmpvs	sp, r5, rrx
     6e4:	72505f78 	subsvc	r5, r0, #120, 30	; 0x1e0
     6e8:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     6ec:	704f5f73 	subvc	r5, pc, r3, ror pc	; <UNPREDICTABLE>
     6f0:	64656e65 	strbtvs	r6, [r5], #-3685	; 0xfffff19b
     6f4:	6c69465f 	stclvs	6, cr4, [r9], #-380	; 0xfffffe84
     6f8:	5f007365 	svcpl	0x00007365
     6fc:	36314e5a 			; <UNDEFINED> instruction: 0x36314e5a
     700:	6f725043 	svcvs	0x00725043
     704:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     708:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     70c:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     710:	6e553831 	mrcvs	8, 2, r3, cr5, cr1, {1}
     714:	5f70616d 	svcpl	0x0070616d
     718:	656c6946 	strbvs	r6, [ip, #-2374]!	; 0xfffff6ba
     71c:	7275435f 	rsbsvc	r4, r5, #2080374785	; 0x7c000001
     720:	746e6572 	strbtvc	r6, [lr], #-1394	; 0xfffffa8e
     724:	54006a45 	strpl	r6, [r0], #-2629	; 0xfffff5bb
     728:	5f474e52 	svcpl	0x00474e52
     72c:	65736142 	ldrbvs	r6, [r3, #-322]!	; 0xfffffebe
     730:	74654700 	strbtvc	r4, [r5], #-1792	; 0xfffff900
     734:	7275435f 	rsbsvc	r4, r5, #2080374785	; 0x7c000001
     738:	746e6572 	strbtvc	r6, [lr], #-1394	; 0xfffffa8e
     73c:	6f72505f 	svcvs	0x0072505f
     740:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     744:	6e6f6c00 	cdpvs	12, 6, cr6, cr15, cr0, {0}
     748:	6e752067 	cdpvs	0, 7, cr2, cr5, cr7, {3}
     74c:	6e676973 			; <UNDEFINED> instruction: 0x6e676973
     750:	69206465 	stmdbvs	r0!, {r0, r2, r5, r6, sl, sp, lr}
     754:	4d00746e 	cfstrsmi	mvf7, [r0, #-440]	; 0xfffffe48
     758:	465f7061 	ldrbmi	r7, [pc], -r1, rrx
     75c:	5f656c69 	svcpl	0x00656c69
     760:	435f6f54 	cmpmi	pc, #84, 30	; 0x150
     764:	65727275 	ldrbvs	r7, [r2, #-629]!	; 0xfffffd8b
     768:	4e00746e 	cdpmi	4, 0, cr7, cr0, cr14, {3}
     76c:	6c69466f 	stclvs	6, cr4, [r9], #-444	; 0xfffffe44
     770:	73797365 	cmnvc	r9, #-1811939327	; 0x94000001
     774:	446d6574 	strbtmi	r6, [sp], #-1396	; 0xfffffa8c
     778:	65766972 	ldrbvs	r6, [r6, #-2418]!	; 0xfffff68e
     77c:	61480072 	hvcvs	32770	; 0x8002
     780:	656c646e 	strbvs	r6, [ip, #-1134]!	; 0xfffffb92
     784:	6f72505f 	svcvs	0x0072505f
     788:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     78c:	4957535f 	ldmdbmi	r7, {r0, r1, r2, r3, r4, r6, r8, r9, ip, lr}^
     790:	6f687300 	svcvs	0x00687300
     794:	75207472 	strvc	r7, [r0, #-1138]!	; 0xfffffb8e
     798:	6769736e 	strbvs	r7, [r9, -lr, ror #6]!
     79c:	2064656e 	rsbcs	r6, r4, lr, ror #10
     7a0:	00746e69 	rsbseq	r6, r4, r9, ror #28
     7a4:	65686353 	strbvs	r6, [r8, #-851]!	; 0xfffffcad
     7a8:	656c7564 	strbvs	r7, [ip, #-1380]!	; 0xfffffa9c
     7ac:	4644455f 			; <UNDEFINED> instruction: 0x4644455f
     7b0:	69615700 	stmdbvs	r1!, {r8, r9, sl, ip, lr}^
     7b4:	552f0074 	strpl	r0, [pc, #-116]!	; 748 <shift+0x748>
     7b8:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
     7bc:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
     7c0:	6a726574 	bvs	1c99d98 <__bss_end+0x1c90db8>
     7c4:	65442f69 	strbvs	r2, [r4, #-3945]	; 0xfffff097
     7c8:	6f746b73 	svcvs	0x00746b73
     7cc:	41462f70 	hvcmi	25328	; 0x62f0
     7d0:	614e2f56 	cmpvs	lr, r6, asr pc
     7d4:	757a6176 	ldrbvc	r6, [sl, #-374]!	; 0xfffffe8a
     7d8:	6963696a 	stmdbvs	r3!, {r1, r3, r5, r6, r8, fp, sp, lr}^
     7dc:	2f534f2f 	svccs	0x00534f2f
     7e0:	656d6573 	strbvs	r6, [sp, #-1395]!	; 0xfffffa8d
     7e4:	61727473 	cmnvs	r2, r3, ror r4
     7e8:	2d616b6c 	vstmdbcs	r1!, {d22-<overflow reg d75>}
     7ec:	2d76696b 			; <UNDEFINED> instruction: 0x2d76696b
     7f0:	732f736f 			; <UNDEFINED> instruction: 0x732f736f
     7f4:	6372756f 	cmnvs	r2, #465567744	; 0x1bc00000
     7f8:	752f7365 	strvc	r7, [pc, #-869]!	; 49b <shift+0x49b>
     7fc:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
     800:	65636170 	strbvs	r6, [r3, #-368]!	; 0xfffffe90
     804:	6c65682f 	stclvs	8, cr6, [r5], #-188	; 0xffffff44
     808:	745f6f6c 	ldrbvc	r6, [pc], #-3948	; 810 <shift+0x810>
     80c:	2f6b7361 	svccs	0x006b7361
     810:	6e69616d 	powvsez	f6, f1, #5.0
     814:	7070632e 	rsbsvc	r6, r0, lr, lsr #6
     818:	746e4900 	strbtvc	r4, [lr], #-2304	; 0xfffff700
     81c:	75727265 	ldrbvc	r7, [r2, #-613]!	; 0xfffffd9b
     820:	62617470 	rsbvs	r7, r1, #112, 8	; 0x70000000
     824:	535f656c 	cmppl	pc, #108, 10	; 0x1b000000
     828:	7065656c 	rsbvc	r6, r5, ip, ror #10
     82c:	355a5f00 	ldrbcc	r5, [sl, #-3840]	; 0xfffff100
     830:	6e696c62 	cdpvs	12, 6, cr6, cr9, cr2, {3}
     834:	6200766b 	andvs	r7, r0, #112197632	; 0x6b00000
     838:	006c6f6f 	rsbeq	r6, ip, pc, ror #30
     83c:	73614c6d 	cmnvc	r1, #27904	; 0x6d00
     840:	49505f74 	ldmdbmi	r0, {r2, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     844:	6c420044 	mcrrvs	0, 4, r0, r2, cr4
     848:	656b636f 	strbvs	r6, [fp, #-879]!	; 0xfffffc91
     84c:	474e0064 	strbmi	r0, [lr, -r4, rrx]
     850:	535f7465 	cmppl	pc, #1694498816	; 0x65000000
     854:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     858:	666e495f 			; <UNDEFINED> instruction: 0x666e495f
     85c:	79545f6f 	ldmdbvc	r4, {r0, r1, r2, r3, r5, r6, r8, r9, sl, fp, ip, lr}^
     860:	52006570 	andpl	r6, r0, #112, 10	; 0x1c000000
     864:	616e6e75 	smcvs	59109	; 0xe6e5
     868:	00656c62 	rsbeq	r6, r5, r2, ror #24
     86c:	7361544e 	cmnvc	r1, #1308622848	; 0x4e000000
     870:	74535f6b 	ldrbvc	r5, [r3], #-3947	; 0xfffff095
     874:	00657461 	rsbeq	r7, r5, r1, ror #8
     878:	5f736f73 	svcpl	0x00736f73
     87c:	0064656c 	rsbeq	r6, r4, ip, ror #10
     880:	65686373 	strbvs	r6, [r8, #-883]!	; 0xfffffc8d
     884:	6f635f64 	svcvs	0x00635f64
     888:	65746e75 	ldrbvs	r6, [r4, #-3701]!	; 0xfffff18b
     88c:	63730072 	cmnvs	r3, #114	; 0x72
     890:	5f646568 	svcpl	0x00646568
     894:	74617473 	strbtvc	r7, [r1], #-1139	; 0xfffffb8d
     898:	705f6369 	subsvc	r6, pc, r9, ror #6
     89c:	726f6972 	rsbvc	r6, pc, #1867776	; 0x1c8000
     8a0:	00797469 	rsbseq	r7, r9, r9, ror #8
     8a4:	74697865 	strbtvc	r7, [r9], #-2149	; 0xfffff79b
     8a8:	646f635f 	strbtvs	r6, [pc], #-863	; 8b0 <shift+0x8b0>
     8ac:	6e720065 	cdpvs	0, 7, cr0, cr2, cr5, {3}
     8b0:	6d754e64 	ldclvs	14, cr4, [r5, #-400]!	; 0xfffffe70
     8b4:	63536d00 	cmpvs	r3, #0, 26
     8b8:	75646568 	strbvc	r6, [r4, #-1384]!	; 0xfffffa98
     8bc:	465f656c 	ldrbmi	r6, [pc], -ip, ror #10
     8c0:	4700636e 	strmi	r6, [r0, -lr, ror #6]
     8c4:	5f4f4950 	svcpl	0x004f4950
     8c8:	65736142 	ldrbvs	r6, [r3, #-322]!	; 0xfffffebe
     8cc:	78614d00 	stmdavc	r1!, {r8, sl, fp, lr}^
     8d0:	72445346 	subvc	r5, r4, #402653185	; 0x18000001
     8d4:	72657669 	rsbvc	r7, r5, #110100480	; 0x6900000
     8d8:	656d614e 	strbvs	r6, [sp, #-334]!	; 0xfffffeb2
     8dc:	676e654c 	strbvs	r6, [lr, -ip, asr #10]!
     8e0:	4e006874 	mcrmi	8, 0, r6, cr0, cr4, {3}
     8e4:	6669746f 	strbtvs	r7, [r9], -pc, ror #8
     8e8:	65440079 	strbvs	r0, [r4, #-121]	; 0xffffff87
     8ec:	6c756166 	ldfvse	f6, [r5], #-408	; 0xfffffe68
     8f0:	6c435f74 	mcrrvs	15, 7, r5, r3, cr4
     8f4:	5f6b636f 	svcpl	0x006b636f
     8f8:	65746152 	ldrbvs	r6, [r4, #-338]!	; 0xfffffeae
     8fc:	636f4c00 	cmnvs	pc, #0, 24
     900:	6e555f6b 	cdpvs	15, 5, cr5, cr5, cr11, {3}
     904:	6b636f6c 	blvs	18dc6bc <__bss_end+0x18d36dc>
     908:	77006465 	strvc	r6, [r0, -r5, ror #8]
     90c:	00667562 	rsbeq	r7, r6, r2, ror #10
     910:	6b636f4c 	blvs	18dc648 <__bss_end+0x18d3668>
     914:	636f4c5f 	cmnvs	pc, #24320	; 0x5f00
     918:	0064656b 	rsbeq	r6, r4, fp, ror #10
     91c:	64616552 	strbtvs	r6, [r1], #-1362	; 0xfffffaae
     920:	6972575f 	ldmdbvs	r2!, {r0, r1, r2, r3, r4, r6, r8, r9, sl, ip, lr}^
     924:	5a006574 	bpl	19efc <__bss_end+0x10f1c>
     928:	69626d6f 	stmdbvs	r2!, {r0, r1, r2, r3, r5, r6, r8, sl, fp, sp, lr}^
     92c:	65470065 	strbvs	r0, [r7, #-101]	; 0xffffff9b
     930:	63535f74 	cmpvs	r3, #116, 30	; 0x1d0
     934:	5f646568 	svcpl	0x00646568
     938:	6f666e49 	svcvs	0x00666e49
     93c:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     940:	50433631 	subpl	r3, r3, r1, lsr r6
     944:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     948:	4d5f7373 	ldclmi	3, cr7, [pc, #-460]	; 784 <shift+0x784>
     94c:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
     950:	53387265 	teqpl	r8, #1342177286	; 0x50000006
     954:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     958:	45656c75 	strbmi	r6, [r5, #-3189]!	; 0xfffff38b
     95c:	5a5f0076 	bpl	17c0b3c <__bss_end+0x17b7b5c>
     960:	4336314e 	teqmi	r6, #-2147483629	; 0x80000013
     964:	636f7250 	cmnvs	pc, #80, 4
     968:	5f737365 	svcpl	0x00737365
     96c:	616e614d 	cmnvs	lr, sp, asr #2
     970:	31726567 	cmncc	r2, r7, ror #10
     974:	70614d39 	rsbvc	r4, r1, r9, lsr sp
     978:	6c69465f 	stclvs	6, cr4, [r9], #-380	; 0xfffffe84
     97c:	6f545f65 	svcvs	0x00545f65
     980:	7275435f 	rsbsvc	r4, r5, #2080374785	; 0x7c000001
     984:	746e6572 	strbtvc	r6, [lr], #-1394	; 0xfffffa8e
     988:	49355045 	ldmdbmi	r5!, {r0, r2, r6, ip, lr}
     98c:	656c6946 	strbvs	r6, [ip, #-2374]!	; 0xfffff6ba
     990:	78614d00 	stmdavc	r1!, {r8, sl, fp, lr}^
     994:	68746150 	ldmdavs	r4!, {r4, r6, r8, sp, lr}^
     998:	676e654c 	strbvs	r6, [lr, -ip, asr #10]!
     99c:	75006874 	strvc	r6, [r0, #-2164]	; 0xfffff78c
     9a0:	6769736e 	strbvs	r7, [r9, -lr, ror #6]!
     9a4:	2064656e 	rsbcs	r6, r4, lr, ror #10
     9a8:	72616863 	rsbvc	r6, r1, #6488064	; 0x630000
     9ac:	6d797300 	ldclvs	3, cr7, [r9, #-0]
     9b0:	5f6c6f62 	svcpl	0x006c6f62
     9b4:	6b636974 	blvs	18daf8c <__bss_end+0x18d1fac>
     9b8:	6c65645f 	cfstrdvs	mvd6, [r5], #-380	; 0xfffffe84
     9bc:	5f007961 	svcpl	0x00007961
     9c0:	36314e5a 			; <UNDEFINED> instruction: 0x36314e5a
     9c4:	6f725043 	svcvs	0x00725043
     9c8:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     9cc:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     9d0:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     9d4:	63533231 	cmpvs	r3, #268435459	; 0x10000003
     9d8:	75646568 	strbvc	r6, [r4, #-1384]!	; 0xfffffa98
     9dc:	455f656c 	ldrbmi	r6, [pc, #-1388]	; 478 <shift+0x478>
     9e0:	76454644 	strbvc	r4, [r5], -r4, asr #12
     9e4:	49504700 	ldmdbmi	r0, {r8, r9, sl, lr}^
     9e8:	69505f4f 	ldmdbvs	r0, {r0, r1, r2, r3, r6, r8, r9, sl, fp, ip, lr}^
     9ec:	6f435f6e 	svcvs	0x00435f6e
     9f0:	00746e75 	rsbseq	r6, r4, r5, ror lr
     9f4:	726f6873 	rsbvc	r6, pc, #7536640	; 0x730000
     9f8:	6e692074 	mcrvs	0, 3, r2, cr9, cr4, {3}
     9fc:	6e490074 	mcrvs	0, 2, r0, cr9, cr4, {3}
     a00:	696c6176 	stmdbvs	ip!, {r1, r2, r4, r5, r6, r8, sp, lr}^
     a04:	69505f64 	ldmdbvs	r0, {r2, r5, r6, r8, r9, sl, fp, ip, lr}^
     a08:	6567006e 	strbvs	r0, [r7, #-110]!	; 0xffffff92
     a0c:	61725f74 	cmnvs	r2, r4, ror pc
     a10:	6d6f646e 	cfstrdvs	mvd6, [pc, #-440]!	; 860 <shift+0x860>
     a14:	72655000 	rsbvc	r5, r5, #0
     a18:	65687069 	strbvs	r7, [r8, #-105]!	; 0xffffff97
     a1c:	5f6c6172 	svcpl	0x006c6172
     a20:	65736142 	ldrbvs	r6, [r3, #-322]!	; 0xfffffebe
     a24:	6e755200 	cdpvs	2, 7, cr5, cr5, cr0, {0}
     a28:	676e696e 	strbvs	r6, [lr, -lr, ror #18]!
     a2c:	6e697500 	cdpvs	5, 6, cr7, cr9, cr0, {0}
     a30:	5f323374 	svcpl	0x00323374
     a34:	436d0074 	cmnmi	sp, #116	; 0x74
     a38:	65727275 	ldrbvs	r7, [r2, #-629]!	; 0xfffffd8b
     a3c:	545f746e 	ldrbpl	r7, [pc], #-1134	; a44 <shift+0xa44>
     a40:	5f6b7361 	svcpl	0x006b7361
     a44:	65646f4e 	strbvs	r6, [r4, #-3918]!	; 0xfffff0b2
     a48:	75706300 	ldrbvc	r6, [r0, #-768]!	; 0xfffffd00
     a4c:	6e6f635f 	mcrvs	3, 3, r6, cr15, cr15, {2}
     a50:	74786574 	ldrbtvc	r6, [r8], #-1396	; 0xfffffa8c
     a54:	61655200 	cmnvs	r5, r0, lsl #4
     a58:	6e4f5f64 	cdpvs	15, 4, cr5, cr15, cr4, {3}
     a5c:	7300796c 	movwvc	r7, #2412	; 0x96c
     a60:	7065656c 	rsbvc	r6, r5, ip, ror #10
     a64:	6d69745f 	cfstrdvs	mvd7, [r9, #-380]!	; 0xfffffe84
     a68:	5f007265 	svcpl	0x00007265
     a6c:	314b4e5a 	cmpcc	fp, sl, asr lr
     a70:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     a74:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     a78:	614d5f73 	hvcvs	54771	; 0xd5f3
     a7c:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     a80:	47383172 			; <UNDEFINED> instruction: 0x47383172
     a84:	505f7465 	subspl	r7, pc, r5, ror #8
     a88:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     a8c:	425f7373 	subsmi	r7, pc, #-872415231	; 0xcc000001
     a90:	49505f79 	ldmdbmi	r0, {r0, r3, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     a94:	006a4544 	rsbeq	r4, sl, r4, asr #10
     a98:	646e6148 	strbtvs	r6, [lr], #-328	; 0xfffffeb8
     a9c:	465f656c 	ldrbmi	r6, [pc], -ip, ror #10
     aa0:	73656c69 	cmnvc	r5, #26880	; 0x6900
     aa4:	65747379 	ldrbvs	r7, [r4, #-889]!	; 0xfffffc87
     aa8:	57535f6d 	ldrbpl	r5, [r3, -sp, ror #30]
     aac:	5a5f0049 	bpl	17c0bd8 <__bss_end+0x17b7bf8>
     ab0:	4336314e 	teqmi	r6, #-2147483629	; 0x80000013
     ab4:	636f7250 	cmnvs	pc, #80, 4
     ab8:	5f737365 	svcpl	0x00737365
     abc:	616e614d 	cmnvs	lr, sp, asr #2
     ac0:	31726567 	cmncc	r2, r7, ror #10
     ac4:	68635331 	stmdavs	r3!, {r0, r4, r5, r8, r9, ip, lr}^
     ac8:	6c756465 	cfldrdvs	mvd6, [r5], #-404	; 0xfffffe6c
     acc:	52525f65 	subspl	r5, r2, #404	; 0x194
     ad0:	74007645 	strvc	r7, [r0], #-1605	; 0xfffff9bb
     ad4:	006b7361 	rsbeq	r7, fp, r1, ror #6
     ad8:	69746f4e 	ldmdbvs	r4!, {r1, r2, r3, r6, r8, r9, sl, fp, sp, lr}^
     adc:	505f7966 	subspl	r7, pc, r6, ror #18
     ae0:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     ae4:	53007373 	movwpl	r7, #883	; 0x373
     ae8:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     aec:	00656c75 	rsbeq	r6, r5, r5, ror ip
     af0:	314e5a5f 	cmpcc	lr, pc, asr sl
     af4:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     af8:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     afc:	614d5f73 	hvcvs	54771	; 0xd5f3
     b00:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     b04:	77533972 			; <UNDEFINED> instruction: 0x77533972
     b08:	68637469 	stmdavs	r3!, {r0, r3, r5, r6, sl, ip, sp, lr}^
     b0c:	456f545f 	strbmi	r5, [pc, #-1119]!	; 6b5 <shift+0x6b5>
     b10:	43383150 	teqmi	r8, #80, 2
     b14:	636f7250 	cmnvs	pc, #80, 4
     b18:	5f737365 	svcpl	0x00737365
     b1c:	7473694c 	ldrbtvc	r6, [r3], #-2380	; 0xfffff6b4
     b20:	646f4e5f 	strbtvs	r4, [pc], #-3679	; b28 <shift+0xb28>
     b24:	63530065 	cmpvs	r3, #101	; 0x65
     b28:	75646568 	strbvc	r6, [r4, #-1384]!	; 0xfffffa98
     b2c:	525f656c 	subspl	r6, pc, #108, 10	; 0x1b000000
     b30:	6c620052 	stclvs	0, cr0, [r2], #-328	; 0xfffffeb8
     b34:	006b6e69 	rsbeq	r6, fp, r9, ror #28
     b38:	314e5a5f 	cmpcc	lr, pc, asr sl
     b3c:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     b40:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     b44:	614d5f73 	hvcvs	54771	; 0xd5f3
     b48:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     b4c:	48383172 	ldmdami	r8!, {r1, r4, r5, r6, r8, ip, sp}
     b50:	6c646e61 	stclvs	14, cr6, [r4], #-388	; 0xfffffe7c
     b54:	72505f65 	subsvc	r5, r0, #404	; 0x194
     b58:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     b5c:	57535f73 			; <UNDEFINED> instruction: 0x57535f73
     b60:	30324549 	eorscc	r4, r2, r9, asr #10
     b64:	4957534e 	ldmdbmi	r7, {r1, r2, r3, r6, r8, r9, ip, lr}^
     b68:	6f72505f 	svcvs	0x0072505f
     b6c:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     b70:	7265535f 	rsbvc	r5, r5, #2080374785	; 0x7c000001
     b74:	65636976 	strbvs	r6, [r3, #-2422]!	; 0xfffff68a
     b78:	526a6a6a 	rsbpl	r6, sl, #434176	; 0x6a000
     b7c:	53543131 	cmppl	r4, #1073741836	; 0x4000000c
     b80:	525f4957 	subspl	r4, pc, #1425408	; 0x15c000
     b84:	6c757365 	ldclvs	3, cr7, [r5], #-404	; 0xfffffe6c
     b88:	72610074 	rsbvc	r0, r1, #116	; 0x74
     b8c:	5f007667 	svcpl	0x00007667
     b90:	36314e5a 			; <UNDEFINED> instruction: 0x36314e5a
     b94:	6f725043 	svcvs	0x00725043
     b98:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     b9c:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     ba0:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     ba4:	72433431 	subvc	r3, r3, #822083584	; 0x31000000
     ba8:	65746165 	ldrbvs	r6, [r4, #-357]!	; 0xfffffe9b
     bac:	6f72505f 	svcvs	0x0072505f
     bb0:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     bb4:	6a685045 	bvs	1a14cd0 <__bss_end+0x1a0bcf0>
     bb8:	77530062 	ldrbvc	r0, [r3, -r2, rrx]
     bbc:	68637469 	stmdavs	r3!, {r0, r3, r5, r6, sl, ip, sp, lr}^
     bc0:	006f545f 	rsbeq	r5, pc, pc, asr r4	; <UNPREDICTABLE>
     bc4:	4957534e 	ldmdbmi	r7, {r1, r2, r3, r6, r8, r9, ip, lr}^
     bc8:	6c69465f 	stclvs	6, cr4, [r9], #-380	; 0xfffffe84
     bcc:	73797365 	cmnvc	r9, #-1811939327	; 0x94000001
     bd0:	5f6d6574 	svcpl	0x006d6574
     bd4:	76726553 			; <UNDEFINED> instruction: 0x76726553
     bd8:	00656369 	rsbeq	r6, r5, r9, ror #6
     bdc:	30315a5f 	eorscc	r5, r1, pc, asr sl
     be0:	5f746567 	svcpl	0x00746567
     be4:	646e6172 	strbtvs	r6, [lr], #-370	; 0xfffffe8e
     be8:	63506d6f 	cmpvs	r0, #7104	; 0x1bc0
     bec:	766e4900 	strbtvc	r4, [lr], -r0, lsl #18
     bf0:	64696c61 	strbtvs	r6, [r9], #-3169	; 0xfffff39f
     bf4:	6e61485f 	mcrvs	8, 3, r4, cr1, cr15, {2}
     bf8:	00656c64 	rsbeq	r6, r5, r4, ror #24
     bfc:	636f6c42 	cmnvs	pc, #16896	; 0x4200
     c00:	75435f6b 	strbvc	r5, [r3, #-3947]	; 0xfffff095
     c04:	6e657272 	mcrvs	2, 3, r7, cr5, cr2, {3}
     c08:	72505f74 	subsvc	r5, r0, #116, 30	; 0x1d0
     c0c:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     c10:	6c430073 	mcrrvs	0, 7, r0, r3, cr3
     c14:	0065736f 	rsbeq	r7, r5, pc, ror #6
     c18:	63677261 	cmnvs	r7, #268435462	; 0x10000006
     c1c:	72617500 	rsbvc	r7, r1, #0, 10
     c20:	72570074 	subsvc	r0, r7, #116	; 0x74
     c24:	5f657469 	svcpl	0x00657469
     c28:	796c6e4f 	stmdbvc	ip!, {r0, r1, r2, r3, r6, r9, sl, fp, sp, lr}^
     c2c:	69616d00 	stmdbvs	r1!, {r8, sl, fp, sp, lr}^
     c30:	6959006e 	ldmdbvs	r9, {r1, r2, r3, r5, r6}^
     c34:	00646c65 	rsbeq	r6, r4, r5, ror #24
     c38:	314e5a5f 	cmpcc	lr, pc, asr sl
     c3c:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     c40:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     c44:	614d5f73 	hvcvs	54771	; 0xd5f3
     c48:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     c4c:	45344372 	ldrmi	r4, [r4, #-882]!	; 0xfffffc8e
     c50:	65540076 	ldrbvs	r0, [r4, #-118]	; 0xffffff8a
     c54:	6e696d72 	mcrvs	13, 3, r6, cr9, cr2, {3}
     c58:	00657461 	rsbeq	r7, r5, r1, ror #8
     c5c:	74434f49 	strbvc	r4, [r3], #-3913	; 0xfffff0b7
     c60:	552f006c 	strpl	r0, [pc, #-108]!	; bfc <shift+0xbfc>
     c64:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
     c68:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
     c6c:	6a726574 	bvs	1c9a244 <__bss_end+0x1c91264>
     c70:	65442f69 	strbvs	r2, [r4, #-3945]	; 0xfffff097
     c74:	6f746b73 	svcvs	0x00746b73
     c78:	41462f70 	hvcmi	25328	; 0x62f0
     c7c:	614e2f56 	cmpvs	lr, r6, asr pc
     c80:	757a6176 	ldrbvc	r6, [sl, #-374]!	; 0xfffffe8a
     c84:	6963696a 	stmdbvs	r3!, {r1, r3, r5, r6, r8, fp, sp, lr}^
     c88:	2f534f2f 	svccs	0x00534f2f
     c8c:	656d6573 	strbvs	r6, [sp, #-1395]!	; 0xfffffa8d
     c90:	61727473 	cmnvs	r2, r3, ror r4
     c94:	2d616b6c 	vstmdbcs	r1!, {d22-<overflow reg d75>}
     c98:	2d76696b 			; <UNDEFINED> instruction: 0x2d76696b
     c9c:	732f736f 			; <UNDEFINED> instruction: 0x732f736f
     ca0:	6372756f 	cmnvs	r2, #465567744	; 0x1bc00000
     ca4:	622f7365 	eorvs	r7, pc, #-1811939327	; 0x94000001
     ca8:	646c6975 	strbtvs	r6, [ip], #-2421	; 0xfffff68b
     cac:	6f6c6300 	svcvs	0x006c6300
     cb0:	53006573 	movwpl	r6, #1395	; 0x573
     cb4:	525f7465 	subspl	r7, pc, #1694498816	; 0x65000000
     cb8:	74616c65 	strbtvc	r6, [r1], #-3173	; 0xfffff39b
     cbc:	00657669 	rsbeq	r7, r5, r9, ror #12
     cc0:	76746572 			; <UNDEFINED> instruction: 0x76746572
     cc4:	6e006c61 	cdpvs	12, 0, cr6, cr0, cr1, {3}
     cc8:	00727563 	rsbseq	r7, r2, r3, ror #10
     ccc:	65706970 	ldrbvs	r6, [r0, #-2416]!	; 0xfffff690
     cd0:	6e647200 	cdpvs	2, 6, cr7, cr4, cr0, {0}
     cd4:	5f006d75 	svcpl	0x00006d75
     cd8:	7331315a 	teqvc	r1, #-2147483626	; 0x80000016
     cdc:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     ce0:	6569795f 	strbvs	r7, [r9, #-2399]!	; 0xfffff6a1
     ce4:	0076646c 	rsbseq	r6, r6, ip, ror #8
     ce8:	37315a5f 			; <UNDEFINED> instruction: 0x37315a5f
     cec:	5f746573 	svcpl	0x00746573
     cf0:	6b736174 	blvs	1cd92c8 <__bss_end+0x1cd02e8>
     cf4:	6165645f 	cmnvs	r5, pc, asr r4
     cf8:	6e696c64 	cdpvs	12, 6, cr6, cr9, cr4, {3}
     cfc:	77006a65 	strvc	r6, [r0, -r5, ror #20]
     d00:	00746961 	rsbseq	r6, r4, r1, ror #18
     d04:	6e365a5f 			; <UNDEFINED> instruction: 0x6e365a5f
     d08:	6669746f 	strbtvs	r7, [r9], -pc, ror #8
     d0c:	006a6a79 	rsbeq	r6, sl, r9, ror sl
     d10:	6c696146 	stfvse	f6, [r9], #-280	; 0xfffffee8
     d14:	69786500 	ldmdbvs	r8!, {r8, sl, sp, lr}^
     d18:	646f6374 	strbtvs	r6, [pc], #-884	; d20 <shift+0xd20>
     d1c:	63730065 	cmnvs	r3, #101	; 0x65
     d20:	5f646568 	svcpl	0x00646568
     d24:	6c656979 			; <UNDEFINED> instruction: 0x6c656979
     d28:	69740064 	ldmdbvs	r4!, {r2, r5, r6}^
     d2c:	635f6b63 	cmpvs	pc, #101376	; 0x18c00
     d30:	746e756f 	strbtvc	r7, [lr], #-1391	; 0xfffffa91
     d34:	7165725f 	cmnvc	r5, pc, asr r2
     d38:	65726975 	ldrbvs	r6, [r2, #-2421]!	; 0xfffff68b
     d3c:	5a5f0064 	bpl	17c0ed4 <__bss_end+0x17b7ef4>
     d40:	65673432 	strbvs	r3, [r7, #-1074]!	; 0xfffffbce
     d44:	63615f74 	cmnvs	r1, #116, 30	; 0x1d0
     d48:	65766974 	ldrbvs	r6, [r6, #-2420]!	; 0xfffff68c
     d4c:	6f72705f 	svcvs	0x0072705f
     d50:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     d54:	756f635f 	strbvc	r6, [pc, #-863]!	; 9fd <shift+0x9fd>
     d58:	0076746e 	rsbseq	r7, r6, lr, ror #8
     d5c:	65706950 	ldrbvs	r6, [r0, #-2384]!	; 0xfffff6b0
     d60:	6c69465f 	stclvs	6, cr4, [r9], #-380	; 0xfffffe84
     d64:	72505f65 	subsvc	r5, r0, #404	; 0x194
     d68:	78696665 	stmdavc	r9!, {r0, r2, r5, r6, r9, sl, sp, lr}^
     d6c:	74655300 	strbtvc	r5, [r5], #-768	; 0xfffffd00
     d70:	7261505f 	rsbvc	r5, r1, #95	; 0x5f
     d74:	00736d61 	rsbseq	r6, r3, r1, ror #26
     d78:	34315a5f 	ldrtcc	r5, [r1], #-2655	; 0xfffff5a1
     d7c:	5f746567 	svcpl	0x00746567
     d80:	6b636974 	blvs	18db358 <__bss_end+0x18d2378>
     d84:	756f635f 	strbvc	r6, [pc, #-863]!	; a2d <shift+0xa2d>
     d88:	0076746e 	rsbseq	r7, r6, lr, ror #8
     d8c:	65656c73 	strbvs	r6, [r5, #-3187]!	; 0xfffff38d
     d90:	69440070 	stmdbvs	r4, {r4, r5, r6}^
     d94:	6c626173 	stfvse	f6, [r2], #-460	; 0xfffffe34
     d98:	76455f65 	strbvc	r5, [r5], -r5, ror #30
     d9c:	5f746e65 	svcpl	0x00746e65
     da0:	65746544 	ldrbvs	r6, [r4, #-1348]!	; 0xfffffabc
     da4:	6f697463 	svcvs	0x00697463
     da8:	5a5f006e 	bpl	17c0f68 <__bss_end+0x17b7f88>
     dac:	72657439 	rsbvc	r7, r5, #956301312	; 0x39000000
     db0:	616e696d 	cmnvs	lr, sp, ror #18
     db4:	00696574 	rsbeq	r6, r9, r4, ror r5
     db8:	7265706f 	rsbvc	r7, r5, #111	; 0x6f
     dbc:	6f697461 	svcvs	0x00697461
     dc0:	5a5f006e 	bpl	17c0f80 <__bss_end+0x17b7fa0>
     dc4:	6f6c6335 	svcvs	0x006c6335
     dc8:	006a6573 	rsbeq	r6, sl, r3, ror r5
     dcc:	67365a5f 			; <UNDEFINED> instruction: 0x67365a5f
     dd0:	69707465 	ldmdbvs	r0!, {r0, r2, r5, r6, sl, ip, sp, lr}^
     dd4:	66007664 	strvs	r7, [r0], -r4, ror #12
     dd8:	656d616e 	strbvs	r6, [sp, #-366]!	; 0xfffffe92
     ddc:	69727700 	ldmdbvs	r2!, {r8, r9, sl, ip, sp, lr}^
     de0:	74006574 	strvc	r6, [r0], #-1396	; 0xfffffa8c
     de4:	736b6369 	cmnvc	fp, #-1543503871	; 0xa4000001
     de8:	65706f00 	ldrbvs	r6, [r0, #-3840]!	; 0xfffff100
     dec:	5a5f006e 	bpl	17c0fac <__bss_end+0x17b7fcc>
     df0:	70697034 	rsbvc	r7, r9, r4, lsr r0
     df4:	634b5065 	movtvs	r5, #45157	; 0xb065
     df8:	444e006a 	strbmi	r0, [lr], #-106	; 0xffffff96
     dfc:	6c646165 	stfvse	f6, [r4], #-404	; 0xfffffe6c
     e00:	5f656e69 	svcpl	0x00656e69
     e04:	73627553 	cmnvc	r2, #348127232	; 0x14c00000
     e08:	69767265 	ldmdbvs	r6!, {r0, r2, r5, r6, r9, ip, sp, lr}^
     e0c:	67006563 	strvs	r6, [r0, -r3, ror #10]
     e10:	745f7465 	ldrbvc	r7, [pc], #-1125	; e18 <shift+0xe18>
     e14:	5f6b6369 	svcpl	0x006b6369
     e18:	6e756f63 	cdpvs	15, 7, cr6, cr5, cr3, {3}
     e1c:	61700074 	cmnvs	r0, r4, ror r0
     e20:	006d6172 	rsbeq	r6, sp, r2, ror r1
     e24:	77355a5f 			; <UNDEFINED> instruction: 0x77355a5f
     e28:	65746972 	ldrbvs	r6, [r4, #-2418]!	; 0xfffff68e
     e2c:	634b506a 	movtvs	r5, #45162	; 0xb06a
     e30:	6567006a 	strbvs	r0, [r7, #-106]!	; 0xffffff96
     e34:	61745f74 	cmnvs	r4, r4, ror pc
     e38:	745f6b73 	ldrbvc	r6, [pc], #-2931	; e40 <shift+0xe40>
     e3c:	736b6369 	cmnvc	fp, #-1543503871	; 0xa4000001
     e40:	5f6f745f 	svcpl	0x006f745f
     e44:	64616564 	strbtvs	r6, [r1], #-1380	; 0xfffffa9c
     e48:	656e696c 	strbvs	r6, [lr, #-2412]!	; 0xfffff694
     e4c:	66756200 	ldrbtvs	r6, [r5], -r0, lsl #4
     e50:	7a69735f 	bvc	1a5dbd4 <__bss_end+0x1a54bf4>
     e54:	65730065 	ldrbvs	r0, [r3, #-101]!	; 0xffffff9b
     e58:	61745f74 	cmnvs	r4, r4, ror pc
     e5c:	645f6b73 	ldrbvs	r6, [pc], #-2931	; e64 <shift+0xe64>
     e60:	6c646165 	stfvse	f6, [r4], #-404	; 0xfffffe6c
     e64:	00656e69 	rsbeq	r6, r5, r9, ror #28
     e68:	5f746547 	svcpl	0x00746547
     e6c:	61726150 	cmnvs	r2, r0, asr r1
     e70:	2f00736d 	svccs	0x0000736d
     e74:	72657355 	rsbvc	r7, r5, #1409286145	; 0x54000001
     e78:	69772f73 	ldmdbvs	r7!, {r0, r1, r4, r5, r6, r8, r9, sl, fp, sp}^
     e7c:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
     e80:	442f696a 	strtmi	r6, [pc], #-2410	; e88 <shift+0xe88>
     e84:	746b7365 	strbtvc	r7, [fp], #-869	; 0xfffffc9b
     e88:	462f706f 	strtmi	r7, [pc], -pc, rrx
     e8c:	4e2f5641 	cfmadda32mi	mvax2, mvax5, mvfx15, mvfx1
     e90:	7a617661 	bvc	185e81c <__bss_end+0x185583c>
     e94:	63696a75 	cmnvs	r9, #479232	; 0x75000
     e98:	534f2f69 	movtpl	r2, #65385	; 0xff69
     e9c:	6d65732f 	stclvs	3, cr7, [r5, #-188]!	; 0xffffff44
     ea0:	72747365 	rsbsvc	r7, r4, #-1811939327	; 0x94000001
     ea4:	616b6c61 	cmnvs	fp, r1, ror #24
     ea8:	76696b2d 	strbtvc	r6, [r9], -sp, lsr #22
     eac:	2f736f2d 	svccs	0x00736f2d
     eb0:	72756f73 	rsbsvc	r6, r5, #460	; 0x1cc
     eb4:	2f736563 	svccs	0x00736563
     eb8:	6c647473 	cfstrdvs	mvd7, [r4], #-460	; 0xfffffe34
     ebc:	732f6269 			; <UNDEFINED> instruction: 0x732f6269
     ec0:	732f6372 			; <UNDEFINED> instruction: 0x732f6372
     ec4:	69666474 	stmdbvs	r6!, {r2, r4, r5, r6, sl, sp, lr}^
     ec8:	632e656c 			; <UNDEFINED> instruction: 0x632e656c
     ecc:	5f007070 	svcpl	0x00007070
     ed0:	6c73355a 	cfldr64vs	mvdx3, [r3], #-360	; 0xfffffe98
     ed4:	6a706565 	bvs	1c1a470 <__bss_end+0x1c11490>
     ed8:	6966006a 	stmdbvs	r6!, {r1, r3, r5, r6}^
     edc:	4700656c 	strmi	r6, [r0, -ip, ror #10]
     ee0:	525f7465 	subspl	r7, pc, #1694498816	; 0x65000000
     ee4:	69616d65 	stmdbvs	r1!, {r0, r2, r5, r6, r8, sl, fp, sp, lr}^
     ee8:	676e696e 	strbvs	r6, [lr, -lr, ror #18]!
     eec:	616e4500 	cmnvs	lr, r0, lsl #10
     ef0:	5f656c62 	svcpl	0x00656c62
     ef4:	6e657645 	cdpvs	6, 6, cr7, cr5, cr5, {2}
     ef8:	65445f74 	strbvs	r5, [r4, #-3956]	; 0xfffff08c
     efc:	74636574 	strbtvc	r6, [r3], #-1396	; 0xfffffa8c
     f00:	006e6f69 	rsbeq	r6, lr, r9, ror #30
     f04:	36325a5f 			; <UNDEFINED> instruction: 0x36325a5f
     f08:	5f746567 	svcpl	0x00746567
     f0c:	6b736174 	blvs	1cd94e4 <__bss_end+0x1cd0504>
     f10:	6369745f 	cmnvs	r9, #1593835520	; 0x5f000000
     f14:	745f736b 	ldrbvc	r7, [pc], #-875	; f1c <shift+0xf1c>
     f18:	65645f6f 	strbvs	r5, [r4, #-3951]!	; 0xfffff091
     f1c:	696c6461 	stmdbvs	ip!, {r0, r5, r6, sl, sp, lr}^
     f20:	0076656e 	rsbseq	r6, r6, lr, ror #10
     f24:	4957534e 	ldmdbmi	r7, {r1, r2, r3, r6, r8, r9, ip, lr}^
     f28:	7365525f 	cmnvc	r5, #-268435451	; 0xf0000005
     f2c:	5f746c75 	svcpl	0x00746c75
     f30:	65646f43 	strbvs	r6, [r4, #-3907]!	; 0xfffff0bd
     f34:	6e727700 	cdpvs	7, 7, cr7, cr2, cr0, {0}
     f38:	5f006d75 	svcpl	0x00006d75
     f3c:	6177345a 	cmnvs	r7, sl, asr r4
     f40:	6a6a7469 	bvs	1a9e0ec <__bss_end+0x1a9510c>
     f44:	5a5f006a 	bpl	17c10f4 <__bss_end+0x17b8114>
     f48:	636f6935 	cmnvs	pc, #868352	; 0xd4000
     f4c:	316a6c74 	smccc	42692	; 0xa6c4
     f50:	4f494e36 	svcmi	0x00494e36
     f54:	5f6c7443 	svcpl	0x006c7443
     f58:	7265704f 	rsbvc	r7, r5, #79	; 0x4f
     f5c:	6f697461 	svcvs	0x00697461
     f60:	0076506e 	rsbseq	r5, r6, lr, rrx
     f64:	74636f69 	strbtvc	r6, [r3], #-3945	; 0xfffff097
     f68:	6572006c 	ldrbvs	r0, [r2, #-108]!	; 0xffffff94
     f6c:	746e6374 	strbtvc	r6, [lr], #-884	; 0xfffffc8c
     f70:	746f6e00 	strbtvc	r6, [pc], #-3584	; f78 <shift+0xf78>
     f74:	00796669 	rsbseq	r6, r9, r9, ror #12
     f78:	6d726574 	cfldr64vs	mvdx6, [r2, #-464]!	; 0xfffffe30
     f7c:	74616e69 	strbtvc	r6, [r1], #-3689	; 0xfffff197
     f80:	6f6d0065 	svcvs	0x006d0065
     f84:	62006564 	andvs	r6, r0, #100, 10	; 0x19000000
     f88:	65666675 	strbvs	r6, [r6, #-1653]!	; 0xfffff98b
     f8c:	5a5f0072 	bpl	17c115c <__bss_end+0x17b817c>
     f90:	61657234 	cmnvs	r5, r4, lsr r2
     f94:	63506a64 	cmpvs	r0, #100, 20	; 0x64000
     f98:	4e47006a 	cdpmi	0, 4, cr0, cr7, cr10, {3}
     f9c:	2b432055 	blcs	10c90f8 <__bss_end+0x10c0118>
     fa0:	2034312b 	eorscs	r3, r4, fp, lsr #2
     fa4:	332e3031 			; <UNDEFINED> instruction: 0x332e3031
     fa8:	3220312e 	eorcc	r3, r0, #-2147483637	; 0x8000000b
     fac:	30313230 	eorscc	r3, r1, r0, lsr r2
     fb0:	20343238 	eorscs	r3, r4, r8, lsr r2
     fb4:	6c657228 	sfmvs	f7, 2, [r5], #-160	; 0xffffff60
     fb8:	65736165 	ldrbvs	r6, [r3, #-357]!	; 0xfffffe9b
     fbc:	6d2d2029 	stcvs	0, cr2, [sp, #-164]!	; 0xffffff5c
     fc0:	616f6c66 	cmnvs	pc, r6, ror #24
     fc4:	62612d74 	rsbvs	r2, r1, #116, 26	; 0x1d00
     fc8:	61683d69 	cmnvs	r8, r9, ror #26
     fcc:	2d206472 	cfstrscs	mvf6, [r0, #-456]!	; 0xfffffe38
     fd0:	7570666d 	ldrbvc	r6, [r0, #-1645]!	; 0xfffff993
     fd4:	7066763d 	rsbvc	r7, r6, sp, lsr r6
     fd8:	666d2d20 	strbtvs	r2, [sp], -r0, lsr #26
     fdc:	74616f6c 	strbtvc	r6, [r1], #-3948	; 0xfffff094
     fe0:	6962612d 	stmdbvs	r2!, {r0, r2, r3, r5, r8, sp, lr}^
     fe4:	7261683d 	rsbvc	r6, r1, #3997696	; 0x3d0000
     fe8:	6d2d2064 	stcvs	0, cr2, [sp, #-400]!	; 0xfffffe70
     fec:	3d757066 	ldclcc	0, cr7, [r5, #-408]!	; 0xfffffe68
     ff0:	20706676 	rsbscs	r6, r0, r6, ror r6
     ff4:	75746d2d 	ldrbvc	r6, [r4, #-3373]!	; 0xfffff2d3
     ff8:	613d656e 	teqvs	sp, lr, ror #10
     ffc:	31316d72 	teqcc	r1, r2, ror sp
    1000:	7a6a3637 	bvc	1a8e8e4 <__bss_end+0x1a85904>
    1004:	20732d66 	rsbscs	r2, r3, r6, ror #26
    1008:	72616d2d 	rsbvc	r6, r1, #2880	; 0xb40
    100c:	6d2d206d 	stcvs	0, cr2, [sp, #-436]!	; 0xfffffe4c
    1010:	68637261 	stmdavs	r3!, {r0, r5, r6, r9, ip, sp, lr}^
    1014:	6d72613d 	ldfvse	f6, [r2, #-244]!	; 0xffffff0c
    1018:	6b7a3676 	blvs	1e8e9f8 <__bss_end+0x1e85a18>
    101c:	2070662b 	rsbscs	r6, r0, fp, lsr #12
    1020:	2d20672d 	stccs	7, cr6, [r0, #-180]!	; 0xffffff4c
    1024:	672d2067 	strvs	r2, [sp, -r7, rrx]!
    1028:	304f2d20 	subcc	r2, pc, r0, lsr #26
    102c:	304f2d20 	subcc	r2, pc, r0, lsr #26
    1030:	6e662d20 	cdpvs	13, 6, cr2, cr6, cr0, {1}
    1034:	78652d6f 	stmdavc	r5!, {r0, r1, r2, r3, r5, r6, r8, sl, fp, sp}^
    1038:	74706563 	ldrbtvc	r6, [r0], #-1379	; 0xfffffa9d
    103c:	736e6f69 	cmnvc	lr, #420	; 0x1a4
    1040:	6e662d20 	cdpvs	13, 6, cr2, cr6, cr0, {1}
    1044:	74722d6f 	ldrbtvc	r2, [r2], #-3439	; 0xfffff291
    1048:	4e006974 			; <UNDEFINED> instruction: 0x4e006974
    104c:	74434f49 	strbvc	r4, [r3], #-3913	; 0xfffff0b7
    1050:	704f5f6c 	subvc	r5, pc, ip, ror #30
    1054:	74617265 	strbtvc	r7, [r1], #-613	; 0xfffffd9b
    1058:	006e6f69 	rsbeq	r6, lr, r9, ror #30
    105c:	63746572 	cmnvs	r4, #478150656	; 0x1c800000
    1060:	0065646f 	rsbeq	r6, r5, pc, ror #8
    1064:	5f746567 	svcpl	0x00746567
    1068:	69746361 	ldmdbvs	r4!, {r0, r5, r6, r8, r9, sp, lr}^
    106c:	705f6576 	subsvc	r6, pc, r6, ror r5	; <UNPREDICTABLE>
    1070:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
    1074:	635f7373 	cmpvs	pc, #-872415231	; 0xcc000001
    1078:	746e756f 	strbtvc	r7, [lr], #-1391	; 0xfffffa91
    107c:	6c696600 	stclvs	6, cr6, [r9], #-0
    1080:	6d616e65 	stclvs	14, cr6, [r1, #-404]!	; 0xfffffe6c
    1084:	65720065 	ldrbvs	r0, [r2, #-101]!	; 0xffffff9b
    1088:	67006461 	strvs	r6, [r0, -r1, ror #8]
    108c:	69707465 	ldmdbvs	r0!, {r0, r2, r5, r6, sl, ip, sp, lr}^
    1090:	5a5f0064 	bpl	17c1228 <__bss_end+0x17b8248>
    1094:	65706f34 	ldrbvs	r6, [r0, #-3892]!	; 0xfffff0cc
    1098:	634b506e 	movtvs	r5, #45166	; 0xb06e
    109c:	464e3531 			; <UNDEFINED> instruction: 0x464e3531
    10a0:	5f656c69 	svcpl	0x00656c69
    10a4:	6e65704f 	cdpvs	0, 6, cr7, cr5, cr15, {2}
    10a8:	646f4d5f 	strbtvs	r4, [pc], #-3423	; 10b0 <shift+0x10b0>
    10ac:	6e690065 	cdpvs	0, 6, cr0, cr9, cr5, {3}
    10b0:	00747570 	rsbseq	r7, r4, r0, ror r5
    10b4:	74736564 	ldrbtvc	r6, [r3], #-1380	; 0xfffffa9c
    10b8:	657a6200 	ldrbvs	r6, [sl, #-512]!	; 0xfffffe00
    10bc:	6c006f72 	stcvs	15, cr6, [r0], {114}	; 0x72
    10c0:	74676e65 	strbtvc	r6, [r7], #-3685	; 0xfffff19b
    10c4:	5a5f0068 	bpl	17c126c <__bss_end+0x17b828c>
    10c8:	657a6235 	ldrbvs	r6, [sl, #-565]!	; 0xfffffdcb
    10cc:	76506f72 	usub16vc	r6, r0, r2
    10d0:	552f0069 	strpl	r0, [pc, #-105]!	; 106f <shift+0x106f>
    10d4:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
    10d8:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
    10dc:	6a726574 	bvs	1c9a6b4 <__bss_end+0x1c916d4>
    10e0:	65442f69 	strbvs	r2, [r4, #-3945]	; 0xfffff097
    10e4:	6f746b73 	svcvs	0x00746b73
    10e8:	41462f70 	hvcmi	25328	; 0x62f0
    10ec:	614e2f56 	cmpvs	lr, r6, asr pc
    10f0:	757a6176 	ldrbvc	r6, [sl, #-374]!	; 0xfffffe8a
    10f4:	6963696a 	stmdbvs	r3!, {r1, r3, r5, r6, r8, fp, sp, lr}^
    10f8:	2f534f2f 	svccs	0x00534f2f
    10fc:	656d6573 	strbvs	r6, [sp, #-1395]!	; 0xfffffa8d
    1100:	61727473 	cmnvs	r2, r3, ror r4
    1104:	2d616b6c 	vstmdbcs	r1!, {d22-<overflow reg d75>}
    1108:	2d76696b 			; <UNDEFINED> instruction: 0x2d76696b
    110c:	732f736f 			; <UNDEFINED> instruction: 0x732f736f
    1110:	6372756f 	cmnvs	r2, #465567744	; 0x1bc00000
    1114:	732f7365 			; <UNDEFINED> instruction: 0x732f7365
    1118:	696c6474 	stmdbvs	ip!, {r2, r4, r5, r6, sl, sp, lr}^
    111c:	72732f62 	rsbsvc	r2, r3, #392	; 0x188
    1120:	74732f63 	ldrbtvc	r2, [r3], #-3939	; 0xfffff09d
    1124:	72747364 	rsbsvc	r7, r4, #100, 6	; 0x90000001
    1128:	2e676e69 	cdpcs	14, 6, cr6, cr7, cr9, {3}
    112c:	00707063 	rsbseq	r7, r0, r3, rrx
    1130:	61345a5f 	teqvs	r4, pc, asr sl
    1134:	50696f74 	rsbpl	r6, r9, r4, ror pc
    1138:	4300634b 	movwmi	r6, #843	; 0x34b
    113c:	43726168 	cmnmi	r2, #104, 2
    1140:	41766e6f 	cmnmi	r6, pc, ror #28
    1144:	6d007272 	sfmvs	f7, 4, [r0, #-456]	; 0xfffffe38
    1148:	73646d65 	cmnvc	r4, #6464	; 0x1940
    114c:	756f0074 	strbvc	r0, [pc, #-116]!	; 10e0 <shift+0x10e0>
    1150:	74757074 	ldrbtvc	r7, [r5], #-116	; 0xffffff8c
    1154:	365a5f00 	ldrbcc	r5, [sl], -r0, lsl #30
    1158:	636d656d 	cmnvs	sp, #457179136	; 0x1b400000
    115c:	4b507970 	blmi	141f724 <__bss_end+0x1416744>
    1160:	69765076 	ldmdbvs	r6!, {r1, r2, r4, r5, r6, ip, lr}^
    1164:	73616200 	cmnvc	r1, #0, 4
    1168:	656d0065 	strbvs	r0, [sp, #-101]!	; 0xffffff9b
    116c:	7970636d 	ldmdbvc	r0!, {r0, r2, r3, r5, r6, r8, r9, sp, lr}^
    1170:	72747300 	rsbsvc	r7, r4, #0, 6
    1174:	006e656c 	rsbeq	r6, lr, ip, ror #10
    1178:	73375a5f 	teqvc	r7, #389120	; 0x5f000
    117c:	636e7274 	cmnvs	lr, #116, 4	; 0x40000007
    1180:	4b50706d 	blmi	141d33c <__bss_end+0x141435c>
    1184:	5f305363 	svcpl	0x00305363
    1188:	5a5f0069 	bpl	17c1334 <__bss_end+0x17b8354>
    118c:	72747336 	rsbsvc	r7, r4, #-671088640	; 0xd8000000
    1190:	506e656c 	rsbpl	r6, lr, ip, ror #10
    1194:	6100634b 	tstvs	r0, fp, asr #6
    1198:	00696f74 	rsbeq	r6, r9, r4, ror pc
    119c:	73375a5f 	teqvc	r7, #389120	; 0x5f000
    11a0:	636e7274 	cmnvs	lr, #116, 4	; 0x40000007
    11a4:	63507970 	cmpvs	r0, #112, 18	; 0x1c0000
    11a8:	69634b50 	stmdbvs	r3!, {r4, r6, r8, r9, fp, lr}^
    11ac:	72747300 	rsbsvc	r7, r4, #0, 6
    11b0:	706d636e 	rsbvc	r6, sp, lr, ror #6
    11b4:	72747300 	rsbsvc	r7, r4, #0, 6
    11b8:	7970636e 	ldmdbvc	r0!, {r1, r2, r3, r5, r6, r8, r9, sp, lr}^
    11bc:	6d656d00 	stclvs	13, cr6, [r5, #-0]
    11c0:	0079726f 	rsbseq	r7, r9, pc, ror #4
    11c4:	736d656d 	cmnvc	sp, #457179136	; 0x1b400000
    11c8:	69006372 	stmdbvs	r0, {r1, r4, r5, r6, r8, r9, sp, lr}
    11cc:	00616f74 	rsbeq	r6, r1, r4, ror pc
    11d0:	69345a5f 	ldmdbvs	r4!, {r0, r1, r2, r3, r4, r6, r9, fp, ip, lr}
    11d4:	6a616f74 	bvs	185cfac <__bss_end+0x1853fcc>
    11d8:	006a6350 	rsbeq	r6, sl, r0, asr r3

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
  20:	8b040e42 	blhi	103930 <__bss_end+0xfa950>
  24:	0b0d4201 	bleq	350830 <__bss_end+0x347850>
  28:	420d0d62 	andmi	r0, sp, #6272	; 0x1880
  2c:	00000ecb 	andeq	r0, r0, fp, asr #29
  30:	0000001c 	andeq	r0, r0, ip, lsl r0
  34:	00000000 	andeq	r0, r0, r0
  38:	00008064 	andeq	r8, r0, r4, rrx
  3c:	00000040 	andeq	r0, r0, r0, asr #32
  40:	8b080e42 	blhi	203950 <__bss_end+0x1fa970>
  44:	42018e02 	andmi	r8, r1, #2, 28
  48:	5a040b0c 	bpl	102c80 <__bss_end+0xf9ca0>
  4c:	00080d0c 	andeq	r0, r8, ip, lsl #26
  50:	0000000c 	andeq	r0, r0, ip
  54:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
  58:	7c020001 	stcvc	0, cr0, [r2], {1}
  5c:	000d0c0e 	andeq	r0, sp, lr, lsl #24
  60:	0000001c 	andeq	r0, r0, ip, lsl r0
  64:	00000050 	andeq	r0, r0, r0, asr r0
  68:	000080a4 	andeq	r8, r0, r4, lsr #1
  6c:	00000038 	andeq	r0, r0, r8, lsr r0
  70:	8b040e42 	blhi	103980 <__bss_end+0xfa9a0>
  74:	0b0d4201 	bleq	350880 <__bss_end+0x3478a0>
  78:	420d0d54 	andmi	r0, sp, #84, 26	; 0x1500
  7c:	00000ecb 	andeq	r0, r0, fp, asr #29
  80:	0000001c 	andeq	r0, r0, ip, lsl r0
  84:	00000050 	andeq	r0, r0, r0, asr r0
  88:	000080dc 	ldrdeq	r8, [r0], -ip
  8c:	0000002c 	andeq	r0, r0, ip, lsr #32
  90:	8b040e42 	blhi	1039a0 <__bss_end+0xfa9c0>
  94:	0b0d4201 	bleq	3508a0 <__bss_end+0x3478c0>
  98:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
  9c:	00000ecb 	andeq	r0, r0, fp, asr #29
  a0:	0000001c 	andeq	r0, r0, ip, lsl r0
  a4:	00000050 	andeq	r0, r0, r0, asr r0
  a8:	00008108 	andeq	r8, r0, r8, lsl #2
  ac:	00000020 	andeq	r0, r0, r0, lsr #32
  b0:	8b040e42 	blhi	1039c0 <__bss_end+0xfa9e0>
  b4:	0b0d4201 	bleq	3508c0 <__bss_end+0x3478e0>
  b8:	420d0d48 	andmi	r0, sp, #72, 26	; 0x1200
  bc:	00000ecb 	andeq	r0, r0, fp, asr #29
  c0:	0000001c 	andeq	r0, r0, ip, lsl r0
  c4:	00000050 	andeq	r0, r0, r0, asr r0
  c8:	00008128 	andeq	r8, r0, r8, lsr #2
  cc:	00000018 	andeq	r0, r0, r8, lsl r0
  d0:	8b040e42 	blhi	1039e0 <__bss_end+0xfaa00>
  d4:	0b0d4201 	bleq	3508e0 <__bss_end+0x347900>
  d8:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
  dc:	00000ecb 	andeq	r0, r0, fp, asr #29
  e0:	0000001c 	andeq	r0, r0, ip, lsl r0
  e4:	00000050 	andeq	r0, r0, r0, asr r0
  e8:	00008140 	andeq	r8, r0, r0, asr #2
  ec:	00000018 	andeq	r0, r0, r8, lsl r0
  f0:	8b040e42 	blhi	103a00 <__bss_end+0xfaa20>
  f4:	0b0d4201 	bleq	350900 <__bss_end+0x347920>
  f8:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
  fc:	00000ecb 	andeq	r0, r0, fp, asr #29
 100:	0000001c 	andeq	r0, r0, ip, lsl r0
 104:	00000050 	andeq	r0, r0, r0, asr r0
 108:	00008158 	andeq	r8, r0, r8, asr r1
 10c:	00000018 	andeq	r0, r0, r8, lsl r0
 110:	8b040e42 	blhi	103a20 <__bss_end+0xfaa40>
 114:	0b0d4201 	bleq	350920 <__bss_end+0x347940>
 118:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
 11c:	00000ecb 	andeq	r0, r0, fp, asr #29
 120:	00000014 	andeq	r0, r0, r4, lsl r0
 124:	00000050 	andeq	r0, r0, r0, asr r0
 128:	00008170 	andeq	r8, r0, r0, ror r1
 12c:	0000000c 	andeq	r0, r0, ip
 130:	8b040e42 	blhi	103a40 <__bss_end+0xfaa60>
 134:	0b0d4201 	bleq	350940 <__bss_end+0x347960>
 138:	0000001c 	andeq	r0, r0, ip, lsl r0
 13c:	00000050 	andeq	r0, r0, r0, asr r0
 140:	0000817c 	andeq	r8, r0, ip, ror r1
 144:	00000058 	andeq	r0, r0, r8, asr r0
 148:	8b080e42 	blhi	203a58 <__bss_end+0x1faa78>
 14c:	42018e02 	andmi	r8, r1, #2, 28
 150:	62040b0c 	andvs	r0, r4, #12, 22	; 0x3000
 154:	00080d0c 	andeq	r0, r8, ip, lsl #26
 158:	0000001c 	andeq	r0, r0, ip, lsl r0
 15c:	00000050 	andeq	r0, r0, r0, asr r0
 160:	000081d4 	ldrdeq	r8, [r0], -r4
 164:	00000058 	andeq	r0, r0, r8, asr r0
 168:	8b080e42 	blhi	203a78 <__bss_end+0x1faa98>
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
 194:	00000058 	andeq	r0, r0, r8, asr r0
 198:	8b080e42 	blhi	203aa8 <__bss_end+0x1faac8>
 19c:	42018e02 	andmi	r8, r1, #2, 28
 1a0:	00040b0c 	andeq	r0, r4, ip, lsl #22
 1a4:	0000001c 	andeq	r0, r0, ip, lsl r0
 1a8:	00000178 	andeq	r0, r0, r8, ror r1
 1ac:	00008284 	andeq	r8, r0, r4, lsl #5
 1b0:	00000038 	andeq	r0, r0, r8, lsr r0
 1b4:	8b080e42 	blhi	203ac4 <__bss_end+0x1faae4>
 1b8:	42018e02 	andmi	r8, r1, #2, 28
 1bc:	54040b0c 	strpl	r0, [r4], #-2828	; 0xfffff4f4
 1c0:	00080d0c 	andeq	r0, r8, ip, lsl #26
 1c4:	0000001c 	andeq	r0, r0, ip, lsl r0
 1c8:	00000178 	andeq	r0, r0, r8, ror r1
 1cc:	000082bc 			; <UNDEFINED> instruction: 0x000082bc
 1d0:	000000f8 	strdeq	r0, [r0], -r8
 1d4:	840c0e42 	strhi	r0, [ip], #-3650	; 0xfffff1be
 1d8:	8e028b03 	vmlahi.f64	d8, d2, d3
 1dc:	0b0c4201 	bleq	3109e8 <__bss_end+0x307a08>
 1e0:	00000004 	andeq	r0, r0, r4
 1e4:	0000000c 	andeq	r0, r0, ip
 1e8:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 1ec:	7c020001 	stcvc	0, cr0, [r2], {1}
 1f0:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 1f4:	0000001c 	andeq	r0, r0, ip, lsl r0
 1f8:	000001e4 	andeq	r0, r0, r4, ror #3
 1fc:	000083b4 			; <UNDEFINED> instruction: 0x000083b4
 200:	0000002c 	andeq	r0, r0, ip, lsr #32
 204:	8b040e42 	blhi	103b14 <__bss_end+0xfab34>
 208:	0b0d4201 	bleq	350a14 <__bss_end+0x347a34>
 20c:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
 210:	00000ecb 	andeq	r0, r0, fp, asr #29
 214:	0000001c 	andeq	r0, r0, ip, lsl r0
 218:	000001e4 	andeq	r0, r0, r4, ror #3
 21c:	000083e0 	andeq	r8, r0, r0, ror #7
 220:	0000002c 	andeq	r0, r0, ip, lsr #32
 224:	8b040e42 	blhi	103b34 <__bss_end+0xfab54>
 228:	0b0d4201 	bleq	350a34 <__bss_end+0x347a54>
 22c:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
 230:	00000ecb 	andeq	r0, r0, fp, asr #29
 234:	0000001c 	andeq	r0, r0, ip, lsl r0
 238:	000001e4 	andeq	r0, r0, r4, ror #3
 23c:	0000840c 	andeq	r8, r0, ip, lsl #8
 240:	0000001c 	andeq	r0, r0, ip, lsl r0
 244:	8b040e42 	blhi	103b54 <__bss_end+0xfab74>
 248:	0b0d4201 	bleq	350a54 <__bss_end+0x347a74>
 24c:	420d0d46 	andmi	r0, sp, #4480	; 0x1180
 250:	00000ecb 	andeq	r0, r0, fp, asr #29
 254:	0000001c 	andeq	r0, r0, ip, lsl r0
 258:	000001e4 	andeq	r0, r0, r4, ror #3
 25c:	00008428 	andeq	r8, r0, r8, lsr #8
 260:	00000044 	andeq	r0, r0, r4, asr #32
 264:	8b040e42 	blhi	103b74 <__bss_end+0xfab94>
 268:	0b0d4201 	bleq	350a74 <__bss_end+0x347a94>
 26c:	420d0d5a 	andmi	r0, sp, #5760	; 0x1680
 270:	00000ecb 	andeq	r0, r0, fp, asr #29
 274:	0000001c 	andeq	r0, r0, ip, lsl r0
 278:	000001e4 	andeq	r0, r0, r4, ror #3
 27c:	0000846c 	andeq	r8, r0, ip, ror #8
 280:	00000050 	andeq	r0, r0, r0, asr r0
 284:	8b040e42 	blhi	103b94 <__bss_end+0xfabb4>
 288:	0b0d4201 	bleq	350a94 <__bss_end+0x347ab4>
 28c:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 290:	00000ecb 	andeq	r0, r0, fp, asr #29
 294:	0000001c 	andeq	r0, r0, ip, lsl r0
 298:	000001e4 	andeq	r0, r0, r4, ror #3
 29c:	000084bc 			; <UNDEFINED> instruction: 0x000084bc
 2a0:	00000050 	andeq	r0, r0, r0, asr r0
 2a4:	8b040e42 	blhi	103bb4 <__bss_end+0xfabd4>
 2a8:	0b0d4201 	bleq	350ab4 <__bss_end+0x347ad4>
 2ac:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 2b0:	00000ecb 	andeq	r0, r0, fp, asr #29
 2b4:	0000001c 	andeq	r0, r0, ip, lsl r0
 2b8:	000001e4 	andeq	r0, r0, r4, ror #3
 2bc:	0000850c 	andeq	r8, r0, ip, lsl #10
 2c0:	0000002c 	andeq	r0, r0, ip, lsr #32
 2c4:	8b040e42 	blhi	103bd4 <__bss_end+0xfabf4>
 2c8:	0b0d4201 	bleq	350ad4 <__bss_end+0x347af4>
 2cc:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
 2d0:	00000ecb 	andeq	r0, r0, fp, asr #29
 2d4:	0000001c 	andeq	r0, r0, ip, lsl r0
 2d8:	000001e4 	andeq	r0, r0, r4, ror #3
 2dc:	00008538 	andeq	r8, r0, r8, lsr r5
 2e0:	00000050 	andeq	r0, r0, r0, asr r0
 2e4:	8b040e42 	blhi	103bf4 <__bss_end+0xfac14>
 2e8:	0b0d4201 	bleq	350af4 <__bss_end+0x347b14>
 2ec:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 2f0:	00000ecb 	andeq	r0, r0, fp, asr #29
 2f4:	0000001c 	andeq	r0, r0, ip, lsl r0
 2f8:	000001e4 	andeq	r0, r0, r4, ror #3
 2fc:	00008588 	andeq	r8, r0, r8, lsl #11
 300:	00000044 	andeq	r0, r0, r4, asr #32
 304:	8b040e42 	blhi	103c14 <__bss_end+0xfac34>
 308:	0b0d4201 	bleq	350b14 <__bss_end+0x347b34>
 30c:	420d0d5a 	andmi	r0, sp, #5760	; 0x1680
 310:	00000ecb 	andeq	r0, r0, fp, asr #29
 314:	0000001c 	andeq	r0, r0, ip, lsl r0
 318:	000001e4 	andeq	r0, r0, r4, ror #3
 31c:	000085cc 	andeq	r8, r0, ip, asr #11
 320:	00000050 	andeq	r0, r0, r0, asr r0
 324:	8b040e42 	blhi	103c34 <__bss_end+0xfac54>
 328:	0b0d4201 	bleq	350b34 <__bss_end+0x347b54>
 32c:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 330:	00000ecb 	andeq	r0, r0, fp, asr #29
 334:	0000001c 	andeq	r0, r0, ip, lsl r0
 338:	000001e4 	andeq	r0, r0, r4, ror #3
 33c:	0000861c 	andeq	r8, r0, ip, lsl r6
 340:	00000054 	andeq	r0, r0, r4, asr r0
 344:	8b040e42 	blhi	103c54 <__bss_end+0xfac74>
 348:	0b0d4201 	bleq	350b54 <__bss_end+0x347b74>
 34c:	420d0d62 	andmi	r0, sp, #6272	; 0x1880
 350:	00000ecb 	andeq	r0, r0, fp, asr #29
 354:	0000001c 	andeq	r0, r0, ip, lsl r0
 358:	000001e4 	andeq	r0, r0, r4, ror #3
 35c:	00008670 	andeq	r8, r0, r0, ror r6
 360:	0000003c 	andeq	r0, r0, ip, lsr r0
 364:	8b040e42 	blhi	103c74 <__bss_end+0xfac94>
 368:	0b0d4201 	bleq	350b74 <__bss_end+0x347b94>
 36c:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 370:	00000ecb 	andeq	r0, r0, fp, asr #29
 374:	0000001c 	andeq	r0, r0, ip, lsl r0
 378:	000001e4 	andeq	r0, r0, r4, ror #3
 37c:	000086ac 	andeq	r8, r0, ip, lsr #13
 380:	0000003c 	andeq	r0, r0, ip, lsr r0
 384:	8b040e42 	blhi	103c94 <__bss_end+0xfacb4>
 388:	0b0d4201 	bleq	350b94 <__bss_end+0x347bb4>
 38c:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 390:	00000ecb 	andeq	r0, r0, fp, asr #29
 394:	0000001c 	andeq	r0, r0, ip, lsl r0
 398:	000001e4 	andeq	r0, r0, r4, ror #3
 39c:	000086e8 	andeq	r8, r0, r8, ror #13
 3a0:	0000003c 	andeq	r0, r0, ip, lsr r0
 3a4:	8b040e42 	blhi	103cb4 <__bss_end+0xfacd4>
 3a8:	0b0d4201 	bleq	350bb4 <__bss_end+0x347bd4>
 3ac:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 3b0:	00000ecb 	andeq	r0, r0, fp, asr #29
 3b4:	0000001c 	andeq	r0, r0, ip, lsl r0
 3b8:	000001e4 	andeq	r0, r0, r4, ror #3
 3bc:	00008724 	andeq	r8, r0, r4, lsr #14
 3c0:	0000003c 	andeq	r0, r0, ip, lsr r0
 3c4:	8b040e42 	blhi	103cd4 <__bss_end+0xfacf4>
 3c8:	0b0d4201 	bleq	350bd4 <__bss_end+0x347bf4>
 3cc:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 3d0:	00000ecb 	andeq	r0, r0, fp, asr #29
 3d4:	0000001c 	andeq	r0, r0, ip, lsl r0
 3d8:	000001e4 	andeq	r0, r0, r4, ror #3
 3dc:	00008760 	andeq	r8, r0, r0, ror #14
 3e0:	000000b0 	strheq	r0, [r0], -r0	; <UNPREDICTABLE>
 3e4:	8b080e42 	blhi	203cf4 <__bss_end+0x1fad14>
 3e8:	42018e02 	andmi	r8, r1, #2, 28
 3ec:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 3f0:	080d0c50 	stmdaeq	sp, {r4, r6, sl, fp}
 3f4:	0000000c 	andeq	r0, r0, ip
 3f8:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 3fc:	7c020001 	stcvc	0, cr0, [r2], {1}
 400:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 404:	0000001c 	andeq	r0, r0, ip, lsl r0
 408:	000003f4 	strdeq	r0, [r0], -r4
 40c:	00008810 	andeq	r8, r0, r0, lsl r8
 410:	00000174 	andeq	r0, r0, r4, ror r1
 414:	8b080e42 	blhi	203d24 <__bss_end+0x1fad44>
 418:	42018e02 	andmi	r8, r1, #2, 28
 41c:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 420:	080d0cb2 	stmdaeq	sp, {r1, r4, r5, r7, sl, fp}
 424:	0000001c 	andeq	r0, r0, ip, lsl r0
 428:	000003f4 	strdeq	r0, [r0], -r4
 42c:	00008984 	andeq	r8, r0, r4, lsl #19
 430:	0000009c 	muleq	r0, ip, r0
 434:	8b040e42 	blhi	103d44 <__bss_end+0xfad64>
 438:	0b0d4201 	bleq	350c44 <__bss_end+0x347c64>
 43c:	0d0d4602 	stceq	6, cr4, [sp, #-8]
 440:	000ecb42 	andeq	ip, lr, r2, asr #22
 444:	0000001c 	andeq	r0, r0, ip, lsl r0
 448:	000003f4 	strdeq	r0, [r0], -r4
 44c:	00008a20 	andeq	r8, r0, r0, lsr #20
 450:	000000c0 	andeq	r0, r0, r0, asr #1
 454:	8b040e42 	blhi	103d64 <__bss_end+0xfad84>
 458:	0b0d4201 	bleq	350c64 <__bss_end+0x347c84>
 45c:	0d0d5802 	stceq	8, cr5, [sp, #-8]
 460:	000ecb42 	andeq	ip, lr, r2, asr #22
 464:	0000001c 	andeq	r0, r0, ip, lsl r0
 468:	000003f4 	strdeq	r0, [r0], -r4
 46c:	00008ae0 	andeq	r8, r0, r0, ror #21
 470:	000000ac 	andeq	r0, r0, ip, lsr #1
 474:	8b040e42 	blhi	103d84 <__bss_end+0xfada4>
 478:	0b0d4201 	bleq	350c84 <__bss_end+0x347ca4>
 47c:	0d0d4e02 	stceq	14, cr4, [sp, #-8]
 480:	000ecb42 	andeq	ip, lr, r2, asr #22
 484:	0000001c 	andeq	r0, r0, ip, lsl r0
 488:	000003f4 	strdeq	r0, [r0], -r4
 48c:	00008b8c 	andeq	r8, r0, ip, lsl #23
 490:	00000054 	andeq	r0, r0, r4, asr r0
 494:	8b040e42 	blhi	103da4 <__bss_end+0xfadc4>
 498:	0b0d4201 	bleq	350ca4 <__bss_end+0x347cc4>
 49c:	420d0d62 	andmi	r0, sp, #6272	; 0x1880
 4a0:	00000ecb 	andeq	r0, r0, fp, asr #29
 4a4:	0000001c 	andeq	r0, r0, ip, lsl r0
 4a8:	000003f4 	strdeq	r0, [r0], -r4
 4ac:	00008be0 	andeq	r8, r0, r0, ror #23
 4b0:	00000068 	andeq	r0, r0, r8, rrx
 4b4:	8b040e42 	blhi	103dc4 <__bss_end+0xfade4>
 4b8:	0b0d4201 	bleq	350cc4 <__bss_end+0x347ce4>
 4bc:	420d0d6c 	andmi	r0, sp, #108, 26	; 0x1b00
 4c0:	00000ecb 	andeq	r0, r0, fp, asr #29
 4c4:	0000001c 	andeq	r0, r0, ip, lsl r0
 4c8:	000003f4 	strdeq	r0, [r0], -r4
 4cc:	00008c48 	andeq	r8, r0, r8, asr #24
 4d0:	00000080 	andeq	r0, r0, r0, lsl #1
 4d4:	8b040e42 	blhi	103de4 <__bss_end+0xfae04>
 4d8:	0b0d4201 	bleq	350ce4 <__bss_end+0x347d04>
 4dc:	420d0d78 	andmi	r0, sp, #120, 26	; 0x1e00
 4e0:	00000ecb 	andeq	r0, r0, fp, asr #29
 4e4:	0000000c 	andeq	r0, r0, ip
 4e8:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 4ec:	7c010001 	stcvc	0, cr0, [r1], {1}
 4f0:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 4f4:	0000000c 	andeq	r0, r0, ip
 4f8:	000004e4 	andeq	r0, r0, r4, ror #9
 4fc:	00008cc8 	andeq	r8, r0, r8, asr #25
 500:	000001ec 	andeq	r0, r0, ip, ror #3
