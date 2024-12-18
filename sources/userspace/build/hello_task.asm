
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
    805c:	00009118 	andeq	r9, r0, r8, lsl r1
    8060:	0000913c 	andeq	r9, r0, ip, lsr r1

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
    8080:	eb0000b4 	bl	8358 <main>
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
    81cc:	00009115 	andeq	r9, r0, r5, lsl r1
    81d0:	00009115 	andeq	r9, r0, r5, lsl r1

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
    8224:	00009115 	andeq	r9, r0, r5, lsl r1
    8228:	00009115 	andeq	r9, r0, r5, lsl r1

0000822c <_Z5blinkv>:
_Z5blinkv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:21
constexpr uint32_t char_tick_delay = 0x1000;

uint32_t led, uart, trng, master, slave;

void blink()
{
    822c:	e92d4800 	push	{fp, lr}
    8230:	e28db004 	add	fp, sp, #4
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:22
	write(led, "1", 1);
    8234:	e59f303c 	ldr	r3, [pc, #60]	; 8278 <_Z5blinkv+0x4c>
    8238:	e5933000 	ldr	r3, [r3]
    823c:	e3a02001 	mov	r2, #1
    8240:	e59f1034 	ldr	r1, [pc, #52]	; 827c <_Z5blinkv+0x50>
    8244:	e1a00003 	mov	r0, r3
    8248:	eb0000d9 	bl	85b4 <_Z5writejPKcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:23
	sleep(0x1000);
    824c:	e3e01001 	mvn	r1, #1
    8250:	e3a00a01 	mov	r0, #4096	; 0x1000
    8254:	eb00012e 	bl	8714 <_Z5sleepjj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:24
	write(led, "0", 1);
    8258:	e59f3018 	ldr	r3, [pc, #24]	; 8278 <_Z5blinkv+0x4c>
    825c:	e5933000 	ldr	r3, [r3]
    8260:	e3a02001 	mov	r2, #1
    8264:	e59f1014 	ldr	r1, [pc, #20]	; 8280 <_Z5blinkv+0x54>
    8268:	e1a00003 	mov	r0, r3
    826c:	eb0000d0 	bl	85b4 <_Z5writejPKcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:25
}
    8270:	e320f000 	nop	{0}
    8274:	e8bd8800 	pop	{fp, pc}
    8278:	00009118 	andeq	r9, r0, r8, lsl r1
    827c:	0000903c 	andeq	r9, r0, ip, lsr r0
    8280:	00009040 	andeq	r9, r0, r0, asr #32

00008284 <_Z10get_randomPc>:
_Z10get_randomPc():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:28

void get_random(char* buff)
{
    8284:	e92d4800 	push	{fp, lr}
    8288:	e28db004 	add	fp, sp, #4
    828c:	e24dd008 	sub	sp, sp, #8
    8290:	e50b0008 	str	r0, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:29
    read(trng, buff, 4);
    8294:	e59f301c 	ldr	r3, [pc, #28]	; 82b8 <_Z10get_randomPc+0x34>
    8298:	e5933000 	ldr	r3, [r3]
    829c:	e3a02004 	mov	r2, #4
    82a0:	e51b1008 	ldr	r1, [fp, #-8]
    82a4:	e1a00003 	mov	r0, r3
    82a8:	eb0000ad 	bl	8564 <_Z4readjPcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:30
}
    82ac:	e320f000 	nop	{0}
    82b0:	e24bd004 	sub	sp, fp, #4
    82b4:	e8bd8800 	pop	{fp, pc}
    82b8:	00009120 	andeq	r9, r0, r0, lsr #2

000082bc <_Z15do_cycle_randomv>:
_Z15do_cycle_randomv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:32

void do_cycle_random() {
    82bc:	e92d4810 	push	{r4, fp, lr}
    82c0:	e28db008 	add	fp, sp, #8
    82c4:	e24dd034 	sub	sp, sp, #52	; 0x34
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:37
    char buff[4], temp_buff[32]; // buffer nulled
    uint32_t* wbuf;
    int rndNum;

    write(uart, "Random number: ", 15);
    82c8:	e59f3080 	ldr	r3, [pc, #128]	; 8350 <_Z15do_cycle_randomv+0x94>
    82cc:	e5933000 	ldr	r3, [r3]
    82d0:	e3a0200f 	mov	r2, #15
    82d4:	e59f1078 	ldr	r1, [pc, #120]	; 8354 <_Z15do_cycle_randomv+0x98>
    82d8:	e1a00003 	mov	r0, r3
    82dc:	eb0000b4 	bl	85b4 <_Z5writejPKcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:38
    blink();
    82e0:	ebffffd1 	bl	822c <_Z5blinkv>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:39
    get_random(buff);
    82e4:	e24b3018 	sub	r3, fp, #24
    82e8:	e1a00003 	mov	r0, r3
    82ec:	ebffffe4 	bl	8284 <_Z10get_randomPc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:40
    wbuf = reinterpret_cast<uint32_t*>(buff);
    82f0:	e24b3018 	sub	r3, fp, #24
    82f4:	e50b3010 	str	r3, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:41
    rndNum = wbuf[0];
    82f8:	e51b3010 	ldr	r3, [fp, #-16]
    82fc:	e5933000 	ldr	r3, [r3]
    8300:	e50b3014 	str	r3, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:42
    itoa(rndNum, temp_buff, 10);
    8304:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8308:	e24b1038 	sub	r1, fp, #56	; 0x38
    830c:	e3a0200a 	mov	r2, #10
    8310:	e1a00003 	mov	r0, r3
    8314:	eb00017b 	bl	8908 <_Z4itoajPcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:43
    write(uart, temp_buff, strlen(temp_buff));
    8318:	e59f3030 	ldr	r3, [pc, #48]	; 8350 <_Z15do_cycle_randomv+0x94>
    831c:	e5934000 	ldr	r4, [r3]
    8320:	e24b3038 	sub	r3, fp, #56	; 0x38
    8324:	e1a00003 	mov	r0, r3
    8328:	eb000255 	bl	8c84 <_Z6strlenPKc>
    832c:	e1a03000 	mov	r3, r0
    8330:	e1a02003 	mov	r2, r3
    8334:	e24b3038 	sub	r3, fp, #56	; 0x38
    8338:	e1a01003 	mov	r1, r3
    833c:	e1a00004 	mov	r0, r4
    8340:	eb00009b 	bl	85b4 <_Z5writejPKcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:44
}
    8344:	e320f000 	nop	{0}
    8348:	e24bd008 	sub	sp, fp, #8
    834c:	e8bd8810 	pop	{r4, fp, pc}
    8350:	0000911c 	andeq	r9, r0, ip, lsl r1
    8354:	00009044 	andeq	r9, r0, r4, asr #32

00008358 <main>:
main():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:47

int main(int argc, char** argv)
{
    8358:	e92d4800 	push	{fp, lr}
    835c:	e28db004 	add	fp, sp, #4
    8360:	e24dd010 	sub	sp, sp, #16
    8364:	e50b0010 	str	r0, [fp, #-16]
    8368:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:50
    char buff[4];

	led = open("DEV:gpio/47", NFile_Open_Mode::Write_Only);
    836c:	e3a01001 	mov	r1, #1
    8370:	e59f0104 	ldr	r0, [pc, #260]	; 847c <main+0x124>
    8374:	eb000069 	bl	8520 <_Z4openPKc15NFile_Open_Mode>
    8378:	e1a03000 	mov	r3, r0
    837c:	e59f20fc 	ldr	r2, [pc, #252]	; 8480 <main+0x128>
    8380:	e5823000 	str	r3, [r2]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:51
	uart = open("DEV:uart/0", NFile_Open_Mode::Read_Write);
    8384:	e3a01002 	mov	r1, #2
    8388:	e59f00f4 	ldr	r0, [pc, #244]	; 8484 <main+0x12c>
    838c:	eb000063 	bl	8520 <_Z4openPKc15NFile_Open_Mode>
    8390:	e1a03000 	mov	r3, r0
    8394:	e59f20ec 	ldr	r2, [pc, #236]	; 8488 <main+0x130>
    8398:	e5823000 	str	r3, [r2]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:54
    // trng = open("DEV:trng/0", NFile_Open_Mode::Read_Write);

    write(uart, "Hello task started...\n", 13);
    839c:	e59f30e4 	ldr	r3, [pc, #228]	; 8488 <main+0x130>
    83a0:	e5933000 	ldr	r3, [r3]
    83a4:	e3a0200d 	mov	r2, #13
    83a8:	e59f10dc 	ldr	r1, [pc, #220]	; 848c <main+0x134>
    83ac:	e1a00003 	mov	r0, r3
    83b0:	eb00007f 	bl	85b4 <_Z5writejPKcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:57

    // start i2c connection
    master = open("DEV:i2c/1", NFile_Open_Mode::Read_Write);
    83b4:	e3a01002 	mov	r1, #2
    83b8:	e59f00d0 	ldr	r0, [pc, #208]	; 8490 <main+0x138>
    83bc:	eb000057 	bl	8520 <_Z4openPKc15NFile_Open_Mode>
    83c0:	e1a03000 	mov	r3, r0
    83c4:	e59f20c8 	ldr	r2, [pc, #200]	; 8494 <main+0x13c>
    83c8:	e5823000 	str	r3, [r2]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:58
    slave = open("DEV:i2c/2", NFile_Open_Mode::Read_Write);
    83cc:	e3a01002 	mov	r1, #2
    83d0:	e59f00c0 	ldr	r0, [pc, #192]	; 8498 <main+0x140>
    83d4:	eb000051 	bl	8520 <_Z4openPKc15NFile_Open_Mode>
    83d8:	e1a03000 	mov	r3, r0
    83dc:	e59f20b8 	ldr	r2, [pc, #184]	; 849c <main+0x144>
    83e0:	e5823000 	str	r3, [r2]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:59
    write(led, "0", 1);
    83e4:	e59f3094 	ldr	r3, [pc, #148]	; 8480 <main+0x128>
    83e8:	e5933000 	ldr	r3, [r3]
    83ec:	e3a02001 	mov	r2, #1
    83f0:	e59f10a8 	ldr	r1, [pc, #168]	; 84a0 <main+0x148>
    83f4:	e1a00003 	mov	r0, r3
    83f8:	eb00006d 	bl	85b4 <_Z5writejPKcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:60
    write(uart, "I2C connection started...\n", 13);
    83fc:	e59f3084 	ldr	r3, [pc, #132]	; 8488 <main+0x130>
    8400:	e5933000 	ldr	r3, [r3]
    8404:	e3a0200d 	mov	r2, #13
    8408:	e59f1094 	ldr	r1, [pc, #148]	; 84a4 <main+0x14c>
    840c:	e1a00003 	mov	r0, r3
    8410:	eb000067 	bl	85b4 <_Z5writejPKcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:76
    // write(uart, buff, 1);

    // sI2C1.Close();
    // sI2C1_Slave.Close();

    close(master);
    8414:	e59f3078 	ldr	r3, [pc, #120]	; 8494 <main+0x13c>
    8418:	e5933000 	ldr	r3, [r3]
    841c:	e1a00003 	mov	r0, r3
    8420:	eb000077 	bl	8604 <_Z5closej>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:77
    close(slave);
    8424:	e59f3070 	ldr	r3, [pc, #112]	; 849c <main+0x144>
    8428:	e5933000 	ldr	r3, [r3]
    842c:	e1a00003 	mov	r0, r3
    8430:	eb000073 	bl	8604 <_Z5closej>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:78
	close(led);
    8434:	e59f3044 	ldr	r3, [pc, #68]	; 8480 <main+0x128>
    8438:	e5933000 	ldr	r3, [r3]
    843c:	e1a00003 	mov	r0, r3
    8440:	eb00006f 	bl	8604 <_Z5closej>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:79
    write(uart, "Open files closed\n", 18);
    8444:	e59f303c 	ldr	r3, [pc, #60]	; 8488 <main+0x130>
    8448:	e5933000 	ldr	r3, [r3]
    844c:	e3a02012 	mov	r2, #18
    8450:	e59f1050 	ldr	r1, [pc, #80]	; 84a8 <main+0x150>
    8454:	e1a00003 	mov	r0, r3
    8458:	eb000055 	bl	85b4 <_Z5writejPKcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:80
    close(uart);
    845c:	e59f3024 	ldr	r3, [pc, #36]	; 8488 <main+0x130>
    8460:	e5933000 	ldr	r3, [r3]
    8464:	e1a00003 	mov	r0, r3
    8468:	eb000065 	bl	8604 <_Z5closej>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:82

    return 0;
    846c:	e3a03000 	mov	r3, #0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:83
}
    8470:	e1a00003 	mov	r0, r3
    8474:	e24bd004 	sub	sp, fp, #4
    8478:	e8bd8800 	pop	{fp, pc}
    847c:	00009054 	andeq	r9, r0, r4, asr r0
    8480:	00009118 	andeq	r9, r0, r8, lsl r1
    8484:	00009060 	andeq	r9, r0, r0, rrx
    8488:	0000911c 	andeq	r9, r0, ip, lsl r1
    848c:	0000906c 	andeq	r9, r0, ip, rrx
    8490:	00009084 	andeq	r9, r0, r4, lsl #1
    8494:	00009124 	andeq	r9, r0, r4, lsr #2
    8498:	00009090 	muleq	r0, r0, r0
    849c:	00009128 	andeq	r9, r0, r8, lsr #2
    84a0:	00009040 	andeq	r9, r0, r0, asr #32
    84a4:	0000909c 	muleq	r0, ip, r0
    84a8:	000090b8 	strheq	r9, [r0], -r8

000084ac <_Z6getpidv>:
_Z6getpidv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:5
#include <stdfile.h>
#include <stdstring.h>

uint32_t getpid()
{
    84ac:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    84b0:	e28db000 	add	fp, sp, #0
    84b4:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:8
    uint32_t pid;

    asm volatile("swi 0");
    84b8:	ef000000 	svc	0x00000000
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:9
    asm volatile("mov %0, r0" : "=r" (pid));
    84bc:	e1a03000 	mov	r3, r0
    84c0:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:11

    return pid;
    84c4:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:12
}
    84c8:	e1a00003 	mov	r0, r3
    84cc:	e28bd000 	add	sp, fp, #0
    84d0:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    84d4:	e12fff1e 	bx	lr

000084d8 <_Z9terminatei>:
_Z9terminatei():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:15

void terminate(int exitcode)
{
    84d8:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    84dc:	e28db000 	add	fp, sp, #0
    84e0:	e24dd00c 	sub	sp, sp, #12
    84e4:	e50b0008 	str	r0, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:16
    asm volatile("mov r0, %0" : : "r" (exitcode));
    84e8:	e51b3008 	ldr	r3, [fp, #-8]
    84ec:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:17
    asm volatile("swi 1");
    84f0:	ef000001 	svc	0x00000001
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:18
}
    84f4:	e320f000 	nop	{0}
    84f8:	e28bd000 	add	sp, fp, #0
    84fc:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8500:	e12fff1e 	bx	lr

00008504 <_Z11sched_yieldv>:
_Z11sched_yieldv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:21

void sched_yield()
{
    8504:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8508:	e28db000 	add	fp, sp, #0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:22
    asm volatile("swi 2");
    850c:	ef000002 	svc	0x00000002
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:23
}
    8510:	e320f000 	nop	{0}
    8514:	e28bd000 	add	sp, fp, #0
    8518:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    851c:	e12fff1e 	bx	lr

00008520 <_Z4openPKc15NFile_Open_Mode>:
_Z4openPKc15NFile_Open_Mode():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:26

uint32_t open(const char* filename, NFile_Open_Mode mode)
{
    8520:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8524:	e28db000 	add	fp, sp, #0
    8528:	e24dd014 	sub	sp, sp, #20
    852c:	e50b0010 	str	r0, [fp, #-16]
    8530:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:29
    uint32_t file;

    asm volatile("mov r0, %0" : : "r" (filename));
    8534:	e51b3010 	ldr	r3, [fp, #-16]
    8538:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:30
    asm volatile("mov r1, %0" : : "r" (mode));
    853c:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8540:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:31
    asm volatile("swi 64");
    8544:	ef000040 	svc	0x00000040
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:32
    asm volatile("mov %0, r0" : "=r" (file));
    8548:	e1a03000 	mov	r3, r0
    854c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:34

    return file;
    8550:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:35
}
    8554:	e1a00003 	mov	r0, r3
    8558:	e28bd000 	add	sp, fp, #0
    855c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8560:	e12fff1e 	bx	lr

00008564 <_Z4readjPcj>:
_Z4readjPcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:38

uint32_t read(uint32_t file, char* const buffer, uint32_t size)
{
    8564:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8568:	e28db000 	add	fp, sp, #0
    856c:	e24dd01c 	sub	sp, sp, #28
    8570:	e50b0010 	str	r0, [fp, #-16]
    8574:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8578:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:41
    uint32_t rdnum;

    asm volatile("mov r0, %0" : : "r" (file));
    857c:	e51b3010 	ldr	r3, [fp, #-16]
    8580:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:42
    asm volatile("mov r1, %0" : : "r" (buffer));
    8584:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8588:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:43
    asm volatile("mov r2, %0" : : "r" (size));
    858c:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8590:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:44
    asm volatile("swi 65");
    8594:	ef000041 	svc	0x00000041
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:45
    asm volatile("mov %0, r0" : "=r" (rdnum));
    8598:	e1a03000 	mov	r3, r0
    859c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:47

    return rdnum;
    85a0:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:48
}
    85a4:	e1a00003 	mov	r0, r3
    85a8:	e28bd000 	add	sp, fp, #0
    85ac:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    85b0:	e12fff1e 	bx	lr

000085b4 <_Z5writejPKcj>:
_Z5writejPKcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:51

uint32_t write(uint32_t file, const char* buffer, uint32_t size)
{
    85b4:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    85b8:	e28db000 	add	fp, sp, #0
    85bc:	e24dd01c 	sub	sp, sp, #28
    85c0:	e50b0010 	str	r0, [fp, #-16]
    85c4:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    85c8:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:54
    uint32_t wrnum;

    asm volatile("mov r0, %0" : : "r" (file));
    85cc:	e51b3010 	ldr	r3, [fp, #-16]
    85d0:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:55
    asm volatile("mov r1, %0" : : "r" (buffer));
    85d4:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    85d8:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:56
    asm volatile("mov r2, %0" : : "r" (size));
    85dc:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    85e0:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:57
    asm volatile("swi 66");
    85e4:	ef000042 	svc	0x00000042
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:58
    asm volatile("mov %0, r0" : "=r" (wrnum));
    85e8:	e1a03000 	mov	r3, r0
    85ec:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:60

    return wrnum;
    85f0:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:61
}
    85f4:	e1a00003 	mov	r0, r3
    85f8:	e28bd000 	add	sp, fp, #0
    85fc:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8600:	e12fff1e 	bx	lr

00008604 <_Z5closej>:
_Z5closej():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:64

void close(uint32_t file)
{
    8604:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8608:	e28db000 	add	fp, sp, #0
    860c:	e24dd00c 	sub	sp, sp, #12
    8610:	e50b0008 	str	r0, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:65
    asm volatile("mov r0, %0" : : "r" (file));
    8614:	e51b3008 	ldr	r3, [fp, #-8]
    8618:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:66
    asm volatile("swi 67");
    861c:	ef000043 	svc	0x00000043
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:67
}
    8620:	e320f000 	nop	{0}
    8624:	e28bd000 	add	sp, fp, #0
    8628:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    862c:	e12fff1e 	bx	lr

00008630 <_Z5ioctlj16NIOCtl_OperationPv>:
_Z5ioctlj16NIOCtl_OperationPv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:70

uint32_t ioctl(uint32_t file, NIOCtl_Operation operation, void* param)
{
    8630:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8634:	e28db000 	add	fp, sp, #0
    8638:	e24dd01c 	sub	sp, sp, #28
    863c:	e50b0010 	str	r0, [fp, #-16]
    8640:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8644:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:73
    uint32_t retcode;

    asm volatile("mov r0, %0" : : "r" (file));
    8648:	e51b3010 	ldr	r3, [fp, #-16]
    864c:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:74
    asm volatile("mov r1, %0" : : "r" (operation));
    8650:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8654:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:75
    asm volatile("mov r2, %0" : : "r" (param));
    8658:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    865c:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:76
    asm volatile("swi 68");
    8660:	ef000044 	svc	0x00000044
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:77
    asm volatile("mov %0, r0" : "=r" (retcode));
    8664:	e1a03000 	mov	r3, r0
    8668:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:79

    return retcode;
    866c:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:80
}
    8670:	e1a00003 	mov	r0, r3
    8674:	e28bd000 	add	sp, fp, #0
    8678:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    867c:	e12fff1e 	bx	lr

00008680 <_Z6notifyjj>:
_Z6notifyjj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:83

uint32_t notify(uint32_t file, uint32_t count)
{
    8680:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8684:	e28db000 	add	fp, sp, #0
    8688:	e24dd014 	sub	sp, sp, #20
    868c:	e50b0010 	str	r0, [fp, #-16]
    8690:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:86
    uint32_t retcnt;

    asm volatile("mov r0, %0" : : "r" (file));
    8694:	e51b3010 	ldr	r3, [fp, #-16]
    8698:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:87
    asm volatile("mov r1, %0" : : "r" (count));
    869c:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    86a0:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:88
    asm volatile("swi 69");
    86a4:	ef000045 	svc	0x00000045
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:89
    asm volatile("mov %0, r0" : "=r" (retcnt));
    86a8:	e1a03000 	mov	r3, r0
    86ac:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:91

    return retcnt;
    86b0:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:92
}
    86b4:	e1a00003 	mov	r0, r3
    86b8:	e28bd000 	add	sp, fp, #0
    86bc:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    86c0:	e12fff1e 	bx	lr

000086c4 <_Z4waitjjj>:
_Z4waitjjj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:95

NSWI_Result_Code wait(uint32_t file, uint32_t count, uint32_t notified_deadline)
{
    86c4:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    86c8:	e28db000 	add	fp, sp, #0
    86cc:	e24dd01c 	sub	sp, sp, #28
    86d0:	e50b0010 	str	r0, [fp, #-16]
    86d4:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    86d8:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:98
    NSWI_Result_Code retcode;

    asm volatile("mov r0, %0" : : "r" (file));
    86dc:	e51b3010 	ldr	r3, [fp, #-16]
    86e0:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:99
    asm volatile("mov r1, %0" : : "r" (count));
    86e4:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    86e8:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:100
    asm volatile("mov r2, %0" : : "r" (notified_deadline));
    86ec:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    86f0:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:101
    asm volatile("swi 70");
    86f4:	ef000046 	svc	0x00000046
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:102
    asm volatile("mov %0, r0" : "=r" (retcode));
    86f8:	e1a03000 	mov	r3, r0
    86fc:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:104

    return retcode;
    8700:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:105
}
    8704:	e1a00003 	mov	r0, r3
    8708:	e28bd000 	add	sp, fp, #0
    870c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8710:	e12fff1e 	bx	lr

00008714 <_Z5sleepjj>:
_Z5sleepjj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:108

bool sleep(uint32_t ticks, uint32_t notified_deadline)
{
    8714:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8718:	e28db000 	add	fp, sp, #0
    871c:	e24dd014 	sub	sp, sp, #20
    8720:	e50b0010 	str	r0, [fp, #-16]
    8724:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:111
    uint32_t retcode;

    asm volatile("mov r0, %0" : : "r" (ticks));
    8728:	e51b3010 	ldr	r3, [fp, #-16]
    872c:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:112
    asm volatile("mov r1, %0" : : "r" (notified_deadline));
    8730:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8734:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:113
    asm volatile("swi 3");
    8738:	ef000003 	svc	0x00000003
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:114
    asm volatile("mov %0, r0" : "=r" (retcode));
    873c:	e1a03000 	mov	r3, r0
    8740:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:116

    return retcode;
    8744:	e51b3008 	ldr	r3, [fp, #-8]
    8748:	e3530000 	cmp	r3, #0
    874c:	13a03001 	movne	r3, #1
    8750:	03a03000 	moveq	r3, #0
    8754:	e6ef3073 	uxtb	r3, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:117
}
    8758:	e1a00003 	mov	r0, r3
    875c:	e28bd000 	add	sp, fp, #0
    8760:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8764:	e12fff1e 	bx	lr

00008768 <_Z24get_active_process_countv>:
_Z24get_active_process_countv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:120

uint32_t get_active_process_count()
{
    8768:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    876c:	e28db000 	add	fp, sp, #0
    8770:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:121
    const NGet_Sched_Info_Type req = NGet_Sched_Info_Type::Active_Process_Count;
    8774:	e3a03000 	mov	r3, #0
    8778:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:124
    uint32_t retval;

    asm volatile("mov r0, %0" : : "r" (req));
    877c:	e3a03000 	mov	r3, #0
    8780:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:125
    asm volatile("mov r1, %0" : : "r" (&retval));
    8784:	e24b300c 	sub	r3, fp, #12
    8788:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:126
    asm volatile("swi 4");
    878c:	ef000004 	svc	0x00000004
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:128

    return retval;
    8790:	e51b300c 	ldr	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:129
}
    8794:	e1a00003 	mov	r0, r3
    8798:	e28bd000 	add	sp, fp, #0
    879c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    87a0:	e12fff1e 	bx	lr

000087a4 <_Z14get_tick_countv>:
_Z14get_tick_countv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:132

uint32_t get_tick_count()
{
    87a4:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    87a8:	e28db000 	add	fp, sp, #0
    87ac:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:133
    const NGet_Sched_Info_Type req = NGet_Sched_Info_Type::Tick_Count;
    87b0:	e3a03001 	mov	r3, #1
    87b4:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:136
    uint32_t retval;

    asm volatile("mov r0, %0" : : "r" (req));
    87b8:	e3a03001 	mov	r3, #1
    87bc:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:137
    asm volatile("mov r1, %0" : : "r" (&retval));
    87c0:	e24b300c 	sub	r3, fp, #12
    87c4:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:138
    asm volatile("swi 4");
    87c8:	ef000004 	svc	0x00000004
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:140

    return retval;
    87cc:	e51b300c 	ldr	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:141
}
    87d0:	e1a00003 	mov	r0, r3
    87d4:	e28bd000 	add	sp, fp, #0
    87d8:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    87dc:	e12fff1e 	bx	lr

000087e0 <_Z17set_task_deadlinej>:
_Z17set_task_deadlinej():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:144

void set_task_deadline(uint32_t tick_count_required)
{
    87e0:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    87e4:	e28db000 	add	fp, sp, #0
    87e8:	e24dd014 	sub	sp, sp, #20
    87ec:	e50b0010 	str	r0, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:145
    const NDeadline_Subservice req = NDeadline_Subservice::Set_Relative;
    87f0:	e3a03000 	mov	r3, #0
    87f4:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:147

    asm volatile("mov r0, %0" : : "r" (req));
    87f8:	e3a03000 	mov	r3, #0
    87fc:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:148
    asm volatile("mov r1, %0" : : "r" (&tick_count_required));
    8800:	e24b3010 	sub	r3, fp, #16
    8804:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:149
    asm volatile("swi 5");
    8808:	ef000005 	svc	0x00000005
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:150
}
    880c:	e320f000 	nop	{0}
    8810:	e28bd000 	add	sp, fp, #0
    8814:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8818:	e12fff1e 	bx	lr

0000881c <_Z26get_task_ticks_to_deadlinev>:
_Z26get_task_ticks_to_deadlinev():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:153

uint32_t get_task_ticks_to_deadline()
{
    881c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8820:	e28db000 	add	fp, sp, #0
    8824:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:154
    const NDeadline_Subservice req = NDeadline_Subservice::Get_Remaining;
    8828:	e3a03001 	mov	r3, #1
    882c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:157
    uint32_t ticks;

    asm volatile("mov r0, %0" : : "r" (req));
    8830:	e3a03001 	mov	r3, #1
    8834:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:158
    asm volatile("mov r1, %0" : : "r" (&ticks));
    8838:	e24b300c 	sub	r3, fp, #12
    883c:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:159
    asm volatile("swi 5");
    8840:	ef000005 	svc	0x00000005
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:161

    return ticks;
    8844:	e51b300c 	ldr	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:162
}
    8848:	e1a00003 	mov	r0, r3
    884c:	e28bd000 	add	sp, fp, #0
    8850:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8854:	e12fff1e 	bx	lr

00008858 <_Z4pipePKcj>:
_Z4pipePKcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:167

const char Pipe_File_Prefix[] = "SYS:pipe/";

uint32_t pipe(const char* name, uint32_t buf_size)
{
    8858:	e92d4800 	push	{fp, lr}
    885c:	e28db004 	add	fp, sp, #4
    8860:	e24dd050 	sub	sp, sp, #80	; 0x50
    8864:	e50b0050 	str	r0, [fp, #-80]	; 0xffffffb0
    8868:	e50b1054 	str	r1, [fp, #-84]	; 0xffffffac
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:169
    char fname[64];
    strncpy(fname, Pipe_File_Prefix, sizeof(Pipe_File_Prefix));
    886c:	e24b3048 	sub	r3, fp, #72	; 0x48
    8870:	e3a0200a 	mov	r2, #10
    8874:	e59f1088 	ldr	r1, [pc, #136]	; 8904 <_Z4pipePKcj+0xac>
    8878:	e1a00003 	mov	r0, r3
    887c:	eb0000a5 	bl	8b18 <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:170
    strncpy(fname + sizeof(Pipe_File_Prefix), name, sizeof(fname) - sizeof(Pipe_File_Prefix) - 1);
    8880:	e24b3048 	sub	r3, fp, #72	; 0x48
    8884:	e283300a 	add	r3, r3, #10
    8888:	e3a02035 	mov	r2, #53	; 0x35
    888c:	e51b1050 	ldr	r1, [fp, #-80]	; 0xffffffb0
    8890:	e1a00003 	mov	r0, r3
    8894:	eb00009f 	bl	8b18 <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:172

    int ncur = sizeof(Pipe_File_Prefix) + strlen(name);
    8898:	e51b0050 	ldr	r0, [fp, #-80]	; 0xffffffb0
    889c:	eb0000f8 	bl	8c84 <_Z6strlenPKc>
    88a0:	e1a03000 	mov	r3, r0
    88a4:	e283300a 	add	r3, r3, #10
    88a8:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:174

    fname[ncur++] = '#';
    88ac:	e51b3008 	ldr	r3, [fp, #-8]
    88b0:	e2832001 	add	r2, r3, #1
    88b4:	e50b2008 	str	r2, [fp, #-8]
    88b8:	e2433004 	sub	r3, r3, #4
    88bc:	e083300b 	add	r3, r3, fp
    88c0:	e3a02023 	mov	r2, #35	; 0x23
    88c4:	e5432044 	strb	r2, [r3, #-68]	; 0xffffffbc
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:176

    itoa(buf_size, &fname[ncur], 10);
    88c8:	e24b2048 	sub	r2, fp, #72	; 0x48
    88cc:	e51b3008 	ldr	r3, [fp, #-8]
    88d0:	e0823003 	add	r3, r2, r3
    88d4:	e3a0200a 	mov	r2, #10
    88d8:	e1a01003 	mov	r1, r3
    88dc:	e51b0054 	ldr	r0, [fp, #-84]	; 0xffffffac
    88e0:	eb000008 	bl	8908 <_Z4itoajPcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:178

    return open(fname, NFile_Open_Mode::Read_Write);
    88e4:	e24b3048 	sub	r3, fp, #72	; 0x48
    88e8:	e3a01002 	mov	r1, #2
    88ec:	e1a00003 	mov	r0, r3
    88f0:	ebffff0a 	bl	8520 <_Z4openPKc15NFile_Open_Mode>
    88f4:	e1a03000 	mov	r3, r0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:179
}
    88f8:	e1a00003 	mov	r0, r3
    88fc:	e24bd004 	sub	sp, fp, #4
    8900:	e8bd8800 	pop	{fp, pc}
    8904:	000090f8 	strdeq	r9, [r0], -r8

00008908 <_Z4itoajPcj>:
_Z4itoajPcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:9
{
    const char CharConvArr[] = "0123456789ABCDEF";
}

void itoa(unsigned int input, char* output, unsigned int base)
{
    8908:	e92d4800 	push	{fp, lr}
    890c:	e28db004 	add	fp, sp, #4
    8910:	e24dd020 	sub	sp, sp, #32
    8914:	e50b0018 	str	r0, [fp, #-24]	; 0xffffffe8
    8918:	e50b101c 	str	r1, [fp, #-28]	; 0xffffffe4
    891c:	e50b2020 	str	r2, [fp, #-32]	; 0xffffffe0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:10
	int i = 0;
    8920:	e3a03000 	mov	r3, #0
    8924:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:12

	while (input > 0)
    8928:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    892c:	e3530000 	cmp	r3, #0
    8930:	0a000014 	beq	8988 <_Z4itoajPcj+0x80>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:14
	{
		output[i] = CharConvArr[input % base];
    8934:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8938:	e51b1020 	ldr	r1, [fp, #-32]	; 0xffffffe0
    893c:	e1a00003 	mov	r0, r3
    8940:	eb000199 	bl	8fac <__aeabi_uidivmod>
    8944:	e1a03001 	mov	r3, r1
    8948:	e1a01003 	mov	r1, r3
    894c:	e51b3008 	ldr	r3, [fp, #-8]
    8950:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    8954:	e0823003 	add	r3, r2, r3
    8958:	e59f2118 	ldr	r2, [pc, #280]	; 8a78 <_Z4itoajPcj+0x170>
    895c:	e7d22001 	ldrb	r2, [r2, r1]
    8960:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:15
		input /= base;
    8964:	e51b1020 	ldr	r1, [fp, #-32]	; 0xffffffe0
    8968:	e51b0018 	ldr	r0, [fp, #-24]	; 0xffffffe8
    896c:	eb000113 	bl	8dc0 <__udivsi3>
    8970:	e1a03000 	mov	r3, r0
    8974:	e50b3018 	str	r3, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:16
		i++;
    8978:	e51b3008 	ldr	r3, [fp, #-8]
    897c:	e2833001 	add	r3, r3, #1
    8980:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:12
	while (input > 0)
    8984:	eaffffe7 	b	8928 <_Z4itoajPcj+0x20>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:19
	}

    if (i == 0)
    8988:	e51b3008 	ldr	r3, [fp, #-8]
    898c:	e3530000 	cmp	r3, #0
    8990:	1a000007 	bne	89b4 <_Z4itoajPcj+0xac>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:21
    {
        output[i] = CharConvArr[0];
    8994:	e51b3008 	ldr	r3, [fp, #-8]
    8998:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    899c:	e0823003 	add	r3, r2, r3
    89a0:	e3a02030 	mov	r2, #48	; 0x30
    89a4:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:22
        i++;
    89a8:	e51b3008 	ldr	r3, [fp, #-8]
    89ac:	e2833001 	add	r3, r3, #1
    89b0:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:25
    }

	output[i] = '\0';
    89b4:	e51b3008 	ldr	r3, [fp, #-8]
    89b8:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    89bc:	e0823003 	add	r3, r2, r3
    89c0:	e3a02000 	mov	r2, #0
    89c4:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:26
	i--;
    89c8:	e51b3008 	ldr	r3, [fp, #-8]
    89cc:	e2433001 	sub	r3, r3, #1
    89d0:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:28

	for (int j = 0; j <= i/2; j++)
    89d4:	e3a03000 	mov	r3, #0
    89d8:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:28 (discriminator 3)
    89dc:	e51b3008 	ldr	r3, [fp, #-8]
    89e0:	e1a02fa3 	lsr	r2, r3, #31
    89e4:	e0823003 	add	r3, r2, r3
    89e8:	e1a030c3 	asr	r3, r3, #1
    89ec:	e1a02003 	mov	r2, r3
    89f0:	e51b300c 	ldr	r3, [fp, #-12]
    89f4:	e1530002 	cmp	r3, r2
    89f8:	ca00001b 	bgt	8a6c <_Z4itoajPcj+0x164>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:30 (discriminator 2)
	{
		char c = output[i - j];
    89fc:	e51b2008 	ldr	r2, [fp, #-8]
    8a00:	e51b300c 	ldr	r3, [fp, #-12]
    8a04:	e0423003 	sub	r3, r2, r3
    8a08:	e1a02003 	mov	r2, r3
    8a0c:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    8a10:	e0833002 	add	r3, r3, r2
    8a14:	e5d33000 	ldrb	r3, [r3]
    8a18:	e54b300d 	strb	r3, [fp, #-13]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:31 (discriminator 2)
		output[i - j] = output[j];
    8a1c:	e51b300c 	ldr	r3, [fp, #-12]
    8a20:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    8a24:	e0822003 	add	r2, r2, r3
    8a28:	e51b1008 	ldr	r1, [fp, #-8]
    8a2c:	e51b300c 	ldr	r3, [fp, #-12]
    8a30:	e0413003 	sub	r3, r1, r3
    8a34:	e1a01003 	mov	r1, r3
    8a38:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    8a3c:	e0833001 	add	r3, r3, r1
    8a40:	e5d22000 	ldrb	r2, [r2]
    8a44:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:32 (discriminator 2)
		output[j] = c;
    8a48:	e51b300c 	ldr	r3, [fp, #-12]
    8a4c:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    8a50:	e0823003 	add	r3, r2, r3
    8a54:	e55b200d 	ldrb	r2, [fp, #-13]
    8a58:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:28 (discriminator 2)
	for (int j = 0; j <= i/2; j++)
    8a5c:	e51b300c 	ldr	r3, [fp, #-12]
    8a60:	e2833001 	add	r3, r3, #1
    8a64:	e50b300c 	str	r3, [fp, #-12]
    8a68:	eaffffdb 	b	89dc <_Z4itoajPcj+0xd4>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:34
	}
}
    8a6c:	e320f000 	nop	{0}
    8a70:	e24bd004 	sub	sp, fp, #4
    8a74:	e8bd8800 	pop	{fp, pc}
    8a78:	00009104 	andeq	r9, r0, r4, lsl #2

00008a7c <_Z4atoiPKc>:
_Z4atoiPKc():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:37

int atoi(const char* input)
{
    8a7c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8a80:	e28db000 	add	fp, sp, #0
    8a84:	e24dd014 	sub	sp, sp, #20
    8a88:	e50b0010 	str	r0, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:38
	int output = 0;
    8a8c:	e3a03000 	mov	r3, #0
    8a90:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:40

	while (*input != '\0')
    8a94:	e51b3010 	ldr	r3, [fp, #-16]
    8a98:	e5d33000 	ldrb	r3, [r3]
    8a9c:	e3530000 	cmp	r3, #0
    8aa0:	0a000017 	beq	8b04 <_Z4atoiPKc+0x88>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:42
	{
		output *= 10;
    8aa4:	e51b2008 	ldr	r2, [fp, #-8]
    8aa8:	e1a03002 	mov	r3, r2
    8aac:	e1a03103 	lsl	r3, r3, #2
    8ab0:	e0833002 	add	r3, r3, r2
    8ab4:	e1a03083 	lsl	r3, r3, #1
    8ab8:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:43
		if (*input > '9' || *input < '0')
    8abc:	e51b3010 	ldr	r3, [fp, #-16]
    8ac0:	e5d33000 	ldrb	r3, [r3]
    8ac4:	e3530039 	cmp	r3, #57	; 0x39
    8ac8:	8a00000d 	bhi	8b04 <_Z4atoiPKc+0x88>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:43 (discriminator 1)
    8acc:	e51b3010 	ldr	r3, [fp, #-16]
    8ad0:	e5d33000 	ldrb	r3, [r3]
    8ad4:	e353002f 	cmp	r3, #47	; 0x2f
    8ad8:	9a000009 	bls	8b04 <_Z4atoiPKc+0x88>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:46
			break;

		output += *input - '0';
    8adc:	e51b3010 	ldr	r3, [fp, #-16]
    8ae0:	e5d33000 	ldrb	r3, [r3]
    8ae4:	e2433030 	sub	r3, r3, #48	; 0x30
    8ae8:	e51b2008 	ldr	r2, [fp, #-8]
    8aec:	e0823003 	add	r3, r2, r3
    8af0:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:48

		input++;
    8af4:	e51b3010 	ldr	r3, [fp, #-16]
    8af8:	e2833001 	add	r3, r3, #1
    8afc:	e50b3010 	str	r3, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:40
	while (*input != '\0')
    8b00:	eaffffe3 	b	8a94 <_Z4atoiPKc+0x18>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:51
	}

	return output;
    8b04:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:52
}
    8b08:	e1a00003 	mov	r0, r3
    8b0c:	e28bd000 	add	sp, fp, #0
    8b10:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8b14:	e12fff1e 	bx	lr

00008b18 <_Z7strncpyPcPKci>:
_Z7strncpyPcPKci():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:55

char* strncpy(char* dest, const char *src, int num)
{
    8b18:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8b1c:	e28db000 	add	fp, sp, #0
    8b20:	e24dd01c 	sub	sp, sp, #28
    8b24:	e50b0010 	str	r0, [fp, #-16]
    8b28:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8b2c:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:58
	int i;

	for (i = 0; i < num && src[i] != '\0'; i++)
    8b30:	e3a03000 	mov	r3, #0
    8b34:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:58 (discriminator 4)
    8b38:	e51b2008 	ldr	r2, [fp, #-8]
    8b3c:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8b40:	e1520003 	cmp	r2, r3
    8b44:	aa000011 	bge	8b90 <_Z7strncpyPcPKci+0x78>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:58 (discriminator 2)
    8b48:	e51b3008 	ldr	r3, [fp, #-8]
    8b4c:	e51b2014 	ldr	r2, [fp, #-20]	; 0xffffffec
    8b50:	e0823003 	add	r3, r2, r3
    8b54:	e5d33000 	ldrb	r3, [r3]
    8b58:	e3530000 	cmp	r3, #0
    8b5c:	0a00000b 	beq	8b90 <_Z7strncpyPcPKci+0x78>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:59 (discriminator 3)
		dest[i] = src[i];
    8b60:	e51b3008 	ldr	r3, [fp, #-8]
    8b64:	e51b2014 	ldr	r2, [fp, #-20]	; 0xffffffec
    8b68:	e0822003 	add	r2, r2, r3
    8b6c:	e51b3008 	ldr	r3, [fp, #-8]
    8b70:	e51b1010 	ldr	r1, [fp, #-16]
    8b74:	e0813003 	add	r3, r1, r3
    8b78:	e5d22000 	ldrb	r2, [r2]
    8b7c:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:58 (discriminator 3)
	for (i = 0; i < num && src[i] != '\0'; i++)
    8b80:	e51b3008 	ldr	r3, [fp, #-8]
    8b84:	e2833001 	add	r3, r3, #1
    8b88:	e50b3008 	str	r3, [fp, #-8]
    8b8c:	eaffffe9 	b	8b38 <_Z7strncpyPcPKci+0x20>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:60 (discriminator 2)
	for (; i < num; i++)
    8b90:	e51b2008 	ldr	r2, [fp, #-8]
    8b94:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8b98:	e1520003 	cmp	r2, r3
    8b9c:	aa000008 	bge	8bc4 <_Z7strncpyPcPKci+0xac>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:61 (discriminator 1)
		dest[i] = '\0';
    8ba0:	e51b3008 	ldr	r3, [fp, #-8]
    8ba4:	e51b2010 	ldr	r2, [fp, #-16]
    8ba8:	e0823003 	add	r3, r2, r3
    8bac:	e3a02000 	mov	r2, #0
    8bb0:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:60 (discriminator 1)
	for (; i < num; i++)
    8bb4:	e51b3008 	ldr	r3, [fp, #-8]
    8bb8:	e2833001 	add	r3, r3, #1
    8bbc:	e50b3008 	str	r3, [fp, #-8]
    8bc0:	eafffff2 	b	8b90 <_Z7strncpyPcPKci+0x78>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:63

   return dest;
    8bc4:	e51b3010 	ldr	r3, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:64
}
    8bc8:	e1a00003 	mov	r0, r3
    8bcc:	e28bd000 	add	sp, fp, #0
    8bd0:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8bd4:	e12fff1e 	bx	lr

00008bd8 <_Z7strncmpPKcS0_i>:
_Z7strncmpPKcS0_i():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:67

int strncmp(const char *s1, const char *s2, int num)
{
    8bd8:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8bdc:	e28db000 	add	fp, sp, #0
    8be0:	e24dd01c 	sub	sp, sp, #28
    8be4:	e50b0010 	str	r0, [fp, #-16]
    8be8:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8bec:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:69
	unsigned char u1, u2;
  	while (num-- > 0)
    8bf0:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8bf4:	e2432001 	sub	r2, r3, #1
    8bf8:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
    8bfc:	e3530000 	cmp	r3, #0
    8c00:	c3a03001 	movgt	r3, #1
    8c04:	d3a03000 	movle	r3, #0
    8c08:	e6ef3073 	uxtb	r3, r3
    8c0c:	e3530000 	cmp	r3, #0
    8c10:	0a000016 	beq	8c70 <_Z7strncmpPKcS0_i+0x98>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:71
    {
      	u1 = (unsigned char) *s1++;
    8c14:	e51b3010 	ldr	r3, [fp, #-16]
    8c18:	e2832001 	add	r2, r3, #1
    8c1c:	e50b2010 	str	r2, [fp, #-16]
    8c20:	e5d33000 	ldrb	r3, [r3]
    8c24:	e54b3005 	strb	r3, [fp, #-5]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:72
     	u2 = (unsigned char) *s2++;
    8c28:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8c2c:	e2832001 	add	r2, r3, #1
    8c30:	e50b2014 	str	r2, [fp, #-20]	; 0xffffffec
    8c34:	e5d33000 	ldrb	r3, [r3]
    8c38:	e54b3006 	strb	r3, [fp, #-6]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:73
      	if (u1 != u2)
    8c3c:	e55b2005 	ldrb	r2, [fp, #-5]
    8c40:	e55b3006 	ldrb	r3, [fp, #-6]
    8c44:	e1520003 	cmp	r2, r3
    8c48:	0a000003 	beq	8c5c <_Z7strncmpPKcS0_i+0x84>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:74
        	return u1 - u2;
    8c4c:	e55b2005 	ldrb	r2, [fp, #-5]
    8c50:	e55b3006 	ldrb	r3, [fp, #-6]
    8c54:	e0423003 	sub	r3, r2, r3
    8c58:	ea000005 	b	8c74 <_Z7strncmpPKcS0_i+0x9c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:75
      	if (u1 == '\0')
    8c5c:	e55b3005 	ldrb	r3, [fp, #-5]
    8c60:	e3530000 	cmp	r3, #0
    8c64:	1affffe1 	bne	8bf0 <_Z7strncmpPKcS0_i+0x18>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:76
        	return 0;
    8c68:	e3a03000 	mov	r3, #0
    8c6c:	ea000000 	b	8c74 <_Z7strncmpPKcS0_i+0x9c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:79
    }

  	return 0;
    8c70:	e3a03000 	mov	r3, #0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:80
}
    8c74:	e1a00003 	mov	r0, r3
    8c78:	e28bd000 	add	sp, fp, #0
    8c7c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8c80:	e12fff1e 	bx	lr

00008c84 <_Z6strlenPKc>:
_Z6strlenPKc():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:83

int strlen(const char* s)
{
    8c84:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8c88:	e28db000 	add	fp, sp, #0
    8c8c:	e24dd014 	sub	sp, sp, #20
    8c90:	e50b0010 	str	r0, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:84
	int i = 0;
    8c94:	e3a03000 	mov	r3, #0
    8c98:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:86

	while (s[i] != '\0')
    8c9c:	e51b3008 	ldr	r3, [fp, #-8]
    8ca0:	e51b2010 	ldr	r2, [fp, #-16]
    8ca4:	e0823003 	add	r3, r2, r3
    8ca8:	e5d33000 	ldrb	r3, [r3]
    8cac:	e3530000 	cmp	r3, #0
    8cb0:	0a000003 	beq	8cc4 <_Z6strlenPKc+0x40>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:87
		i++;
    8cb4:	e51b3008 	ldr	r3, [fp, #-8]
    8cb8:	e2833001 	add	r3, r3, #1
    8cbc:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:86
	while (s[i] != '\0')
    8cc0:	eafffff5 	b	8c9c <_Z6strlenPKc+0x18>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:89

	return i;
    8cc4:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:90
}
    8cc8:	e1a00003 	mov	r0, r3
    8ccc:	e28bd000 	add	sp, fp, #0
    8cd0:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8cd4:	e12fff1e 	bx	lr

00008cd8 <_Z5bzeroPvi>:
_Z5bzeroPvi():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:93

void bzero(void* memory, int length)
{
    8cd8:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8cdc:	e28db000 	add	fp, sp, #0
    8ce0:	e24dd014 	sub	sp, sp, #20
    8ce4:	e50b0010 	str	r0, [fp, #-16]
    8ce8:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:94
	char* mem = reinterpret_cast<char*>(memory);
    8cec:	e51b3010 	ldr	r3, [fp, #-16]
    8cf0:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:96

	for (int i = 0; i < length; i++)
    8cf4:	e3a03000 	mov	r3, #0
    8cf8:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:96 (discriminator 3)
    8cfc:	e51b2008 	ldr	r2, [fp, #-8]
    8d00:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8d04:	e1520003 	cmp	r2, r3
    8d08:	aa000008 	bge	8d30 <_Z5bzeroPvi+0x58>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:97 (discriminator 2)
		mem[i] = 0;
    8d0c:	e51b3008 	ldr	r3, [fp, #-8]
    8d10:	e51b200c 	ldr	r2, [fp, #-12]
    8d14:	e0823003 	add	r3, r2, r3
    8d18:	e3a02000 	mov	r2, #0
    8d1c:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:96 (discriminator 2)
	for (int i = 0; i < length; i++)
    8d20:	e51b3008 	ldr	r3, [fp, #-8]
    8d24:	e2833001 	add	r3, r3, #1
    8d28:	e50b3008 	str	r3, [fp, #-8]
    8d2c:	eafffff2 	b	8cfc <_Z5bzeroPvi+0x24>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:98
}
    8d30:	e320f000 	nop	{0}
    8d34:	e28bd000 	add	sp, fp, #0
    8d38:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8d3c:	e12fff1e 	bx	lr

00008d40 <_Z6memcpyPKvPvi>:
_Z6memcpyPKvPvi():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:101

void memcpy(const void* src, void* dst, int num)
{
    8d40:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8d44:	e28db000 	add	fp, sp, #0
    8d48:	e24dd024 	sub	sp, sp, #36	; 0x24
    8d4c:	e50b0018 	str	r0, [fp, #-24]	; 0xffffffe8
    8d50:	e50b101c 	str	r1, [fp, #-28]	; 0xffffffe4
    8d54:	e50b2020 	str	r2, [fp, #-32]	; 0xffffffe0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:102
	const char* memsrc = reinterpret_cast<const char*>(src);
    8d58:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8d5c:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:103
	char* memdst = reinterpret_cast<char*>(dst);
    8d60:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    8d64:	e50b3010 	str	r3, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:105

	for (int i = 0; i < num; i++)
    8d68:	e3a03000 	mov	r3, #0
    8d6c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:105 (discriminator 3)
    8d70:	e51b2008 	ldr	r2, [fp, #-8]
    8d74:	e51b3020 	ldr	r3, [fp, #-32]	; 0xffffffe0
    8d78:	e1520003 	cmp	r2, r3
    8d7c:	aa00000b 	bge	8db0 <_Z6memcpyPKvPvi+0x70>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:106 (discriminator 2)
		memdst[i] = memsrc[i];
    8d80:	e51b3008 	ldr	r3, [fp, #-8]
    8d84:	e51b200c 	ldr	r2, [fp, #-12]
    8d88:	e0822003 	add	r2, r2, r3
    8d8c:	e51b3008 	ldr	r3, [fp, #-8]
    8d90:	e51b1010 	ldr	r1, [fp, #-16]
    8d94:	e0813003 	add	r3, r1, r3
    8d98:	e5d22000 	ldrb	r2, [r2]
    8d9c:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:105 (discriminator 2)
	for (int i = 0; i < num; i++)
    8da0:	e51b3008 	ldr	r3, [fp, #-8]
    8da4:	e2833001 	add	r3, r3, #1
    8da8:	e50b3008 	str	r3, [fp, #-8]
    8dac:	eaffffef 	b	8d70 <_Z6memcpyPKvPvi+0x30>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:107
}
    8db0:	e320f000 	nop	{0}
    8db4:	e28bd000 	add	sp, fp, #0
    8db8:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8dbc:	e12fff1e 	bx	lr

00008dc0 <__udivsi3>:
__udivsi3():
    8dc0:	e2512001 	subs	r2, r1, #1
    8dc4:	012fff1e 	bxeq	lr
    8dc8:	3a000074 	bcc	8fa0 <__udivsi3+0x1e0>
    8dcc:	e1500001 	cmp	r0, r1
    8dd0:	9a00006b 	bls	8f84 <__udivsi3+0x1c4>
    8dd4:	e1110002 	tst	r1, r2
    8dd8:	0a00006c 	beq	8f90 <__udivsi3+0x1d0>
    8ddc:	e16f3f10 	clz	r3, r0
    8de0:	e16f2f11 	clz	r2, r1
    8de4:	e0423003 	sub	r3, r2, r3
    8de8:	e273301f 	rsbs	r3, r3, #31
    8dec:	10833083 	addne	r3, r3, r3, lsl #1
    8df0:	e3a02000 	mov	r2, #0
    8df4:	108ff103 	addne	pc, pc, r3, lsl #2
    8df8:	e1a00000 	nop			; (mov r0, r0)
    8dfc:	e1500f81 	cmp	r0, r1, lsl #31
    8e00:	e0a22002 	adc	r2, r2, r2
    8e04:	20400f81 	subcs	r0, r0, r1, lsl #31
    8e08:	e1500f01 	cmp	r0, r1, lsl #30
    8e0c:	e0a22002 	adc	r2, r2, r2
    8e10:	20400f01 	subcs	r0, r0, r1, lsl #30
    8e14:	e1500e81 	cmp	r0, r1, lsl #29
    8e18:	e0a22002 	adc	r2, r2, r2
    8e1c:	20400e81 	subcs	r0, r0, r1, lsl #29
    8e20:	e1500e01 	cmp	r0, r1, lsl #28
    8e24:	e0a22002 	adc	r2, r2, r2
    8e28:	20400e01 	subcs	r0, r0, r1, lsl #28
    8e2c:	e1500d81 	cmp	r0, r1, lsl #27
    8e30:	e0a22002 	adc	r2, r2, r2
    8e34:	20400d81 	subcs	r0, r0, r1, lsl #27
    8e38:	e1500d01 	cmp	r0, r1, lsl #26
    8e3c:	e0a22002 	adc	r2, r2, r2
    8e40:	20400d01 	subcs	r0, r0, r1, lsl #26
    8e44:	e1500c81 	cmp	r0, r1, lsl #25
    8e48:	e0a22002 	adc	r2, r2, r2
    8e4c:	20400c81 	subcs	r0, r0, r1, lsl #25
    8e50:	e1500c01 	cmp	r0, r1, lsl #24
    8e54:	e0a22002 	adc	r2, r2, r2
    8e58:	20400c01 	subcs	r0, r0, r1, lsl #24
    8e5c:	e1500b81 	cmp	r0, r1, lsl #23
    8e60:	e0a22002 	adc	r2, r2, r2
    8e64:	20400b81 	subcs	r0, r0, r1, lsl #23
    8e68:	e1500b01 	cmp	r0, r1, lsl #22
    8e6c:	e0a22002 	adc	r2, r2, r2
    8e70:	20400b01 	subcs	r0, r0, r1, lsl #22
    8e74:	e1500a81 	cmp	r0, r1, lsl #21
    8e78:	e0a22002 	adc	r2, r2, r2
    8e7c:	20400a81 	subcs	r0, r0, r1, lsl #21
    8e80:	e1500a01 	cmp	r0, r1, lsl #20
    8e84:	e0a22002 	adc	r2, r2, r2
    8e88:	20400a01 	subcs	r0, r0, r1, lsl #20
    8e8c:	e1500981 	cmp	r0, r1, lsl #19
    8e90:	e0a22002 	adc	r2, r2, r2
    8e94:	20400981 	subcs	r0, r0, r1, lsl #19
    8e98:	e1500901 	cmp	r0, r1, lsl #18
    8e9c:	e0a22002 	adc	r2, r2, r2
    8ea0:	20400901 	subcs	r0, r0, r1, lsl #18
    8ea4:	e1500881 	cmp	r0, r1, lsl #17
    8ea8:	e0a22002 	adc	r2, r2, r2
    8eac:	20400881 	subcs	r0, r0, r1, lsl #17
    8eb0:	e1500801 	cmp	r0, r1, lsl #16
    8eb4:	e0a22002 	adc	r2, r2, r2
    8eb8:	20400801 	subcs	r0, r0, r1, lsl #16
    8ebc:	e1500781 	cmp	r0, r1, lsl #15
    8ec0:	e0a22002 	adc	r2, r2, r2
    8ec4:	20400781 	subcs	r0, r0, r1, lsl #15
    8ec8:	e1500701 	cmp	r0, r1, lsl #14
    8ecc:	e0a22002 	adc	r2, r2, r2
    8ed0:	20400701 	subcs	r0, r0, r1, lsl #14
    8ed4:	e1500681 	cmp	r0, r1, lsl #13
    8ed8:	e0a22002 	adc	r2, r2, r2
    8edc:	20400681 	subcs	r0, r0, r1, lsl #13
    8ee0:	e1500601 	cmp	r0, r1, lsl #12
    8ee4:	e0a22002 	adc	r2, r2, r2
    8ee8:	20400601 	subcs	r0, r0, r1, lsl #12
    8eec:	e1500581 	cmp	r0, r1, lsl #11
    8ef0:	e0a22002 	adc	r2, r2, r2
    8ef4:	20400581 	subcs	r0, r0, r1, lsl #11
    8ef8:	e1500501 	cmp	r0, r1, lsl #10
    8efc:	e0a22002 	adc	r2, r2, r2
    8f00:	20400501 	subcs	r0, r0, r1, lsl #10
    8f04:	e1500481 	cmp	r0, r1, lsl #9
    8f08:	e0a22002 	adc	r2, r2, r2
    8f0c:	20400481 	subcs	r0, r0, r1, lsl #9
    8f10:	e1500401 	cmp	r0, r1, lsl #8
    8f14:	e0a22002 	adc	r2, r2, r2
    8f18:	20400401 	subcs	r0, r0, r1, lsl #8
    8f1c:	e1500381 	cmp	r0, r1, lsl #7
    8f20:	e0a22002 	adc	r2, r2, r2
    8f24:	20400381 	subcs	r0, r0, r1, lsl #7
    8f28:	e1500301 	cmp	r0, r1, lsl #6
    8f2c:	e0a22002 	adc	r2, r2, r2
    8f30:	20400301 	subcs	r0, r0, r1, lsl #6
    8f34:	e1500281 	cmp	r0, r1, lsl #5
    8f38:	e0a22002 	adc	r2, r2, r2
    8f3c:	20400281 	subcs	r0, r0, r1, lsl #5
    8f40:	e1500201 	cmp	r0, r1, lsl #4
    8f44:	e0a22002 	adc	r2, r2, r2
    8f48:	20400201 	subcs	r0, r0, r1, lsl #4
    8f4c:	e1500181 	cmp	r0, r1, lsl #3
    8f50:	e0a22002 	adc	r2, r2, r2
    8f54:	20400181 	subcs	r0, r0, r1, lsl #3
    8f58:	e1500101 	cmp	r0, r1, lsl #2
    8f5c:	e0a22002 	adc	r2, r2, r2
    8f60:	20400101 	subcs	r0, r0, r1, lsl #2
    8f64:	e1500081 	cmp	r0, r1, lsl #1
    8f68:	e0a22002 	adc	r2, r2, r2
    8f6c:	20400081 	subcs	r0, r0, r1, lsl #1
    8f70:	e1500001 	cmp	r0, r1
    8f74:	e0a22002 	adc	r2, r2, r2
    8f78:	20400001 	subcs	r0, r0, r1
    8f7c:	e1a00002 	mov	r0, r2
    8f80:	e12fff1e 	bx	lr
    8f84:	03a00001 	moveq	r0, #1
    8f88:	13a00000 	movne	r0, #0
    8f8c:	e12fff1e 	bx	lr
    8f90:	e16f2f11 	clz	r2, r1
    8f94:	e262201f 	rsb	r2, r2, #31
    8f98:	e1a00230 	lsr	r0, r0, r2
    8f9c:	e12fff1e 	bx	lr
    8fa0:	e3500000 	cmp	r0, #0
    8fa4:	13e00000 	mvnne	r0, #0
    8fa8:	ea000007 	b	8fcc <__aeabi_idiv0>

00008fac <__aeabi_uidivmod>:
__aeabi_uidivmod():
    8fac:	e3510000 	cmp	r1, #0
    8fb0:	0afffffa 	beq	8fa0 <__udivsi3+0x1e0>
    8fb4:	e92d4003 	push	{r0, r1, lr}
    8fb8:	ebffff80 	bl	8dc0 <__udivsi3>
    8fbc:	e8bd4006 	pop	{r1, r2, lr}
    8fc0:	e0030092 	mul	r3, r2, r0
    8fc4:	e0411003 	sub	r1, r1, r3
    8fc8:	e12fff1e 	bx	lr

00008fcc <__aeabi_idiv0>:
__aeabi_ldiv0():
    8fcc:	e12fff1e 	bx	lr

Disassembly of section .rodata:

00008fd0 <_ZL13Lock_Unlocked>:
    8fd0:	00000000 	andeq	r0, r0, r0

00008fd4 <_ZL11Lock_Locked>:
    8fd4:	00000001 	andeq	r0, r0, r1

00008fd8 <_ZL21MaxFSDriverNameLength>:
    8fd8:	00000010 	andeq	r0, r0, r0, lsl r0

00008fdc <_ZL17MaxFilenameLength>:
    8fdc:	00000010 	andeq	r0, r0, r0, lsl r0

00008fe0 <_ZL13MaxPathLength>:
    8fe0:	00000080 	andeq	r0, r0, r0, lsl #1

00008fe4 <_ZL18NoFilesystemDriver>:
    8fe4:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008fe8 <_ZL9NotifyAll>:
    8fe8:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008fec <_ZL24Max_Process_Opened_Files>:
    8fec:	00000010 	andeq	r0, r0, r0, lsl r0

00008ff0 <_ZL10Indefinite>:
    8ff0:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008ff4 <_ZL18Deadline_Unchanged>:
    8ff4:	fffffffe 			; <UNDEFINED> instruction: 0xfffffffe

00008ff8 <_ZL14Invalid_Handle>:
    8ff8:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008ffc <_ZN3halL18Default_Clock_RateE>:
    8ffc:	0ee6b280 	cdpeq	2, 14, cr11, cr6, cr0, {4}

00009000 <_ZN3halL15Peripheral_BaseE>:
    9000:	20000000 	andcs	r0, r0, r0

00009004 <_ZN3halL9GPIO_BaseE>:
    9004:	20200000 	eorcs	r0, r0, r0

00009008 <_ZN3halL14GPIO_Pin_CountE>:
    9008:	00000036 	andeq	r0, r0, r6, lsr r0

0000900c <_ZN3halL8AUX_BaseE>:
    900c:	20215000 	eorcs	r5, r1, r0

00009010 <_ZN3halL25Interrupt_Controller_BaseE>:
    9010:	2000b200 	andcs	fp, r0, r0, lsl #4

00009014 <_ZN3halL10Timer_BaseE>:
    9014:	2000b400 	andcs	fp, r0, r0, lsl #8

00009018 <_ZN3halL9TRNG_BaseE>:
    9018:	20104000 	andscs	r4, r0, r0

0000901c <_ZN3halL9BSC0_BaseE>:
    901c:	20205000 	eorcs	r5, r0, r0

00009020 <_ZN3halL9BSC1_BaseE>:
    9020:	20804000 	addcs	r4, r0, r0

00009024 <_ZN3halL9BSC2_BaseE>:
    9024:	20805000 	addcs	r5, r0, r0

00009028 <_ZN3halL14I2C_SLAVE_BaseE>:
    9028:	20214000 	eorcs	r4, r1, r0

0000902c <_ZL11Invalid_Pin>:
    902c:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00009030 <_ZL24I2C_Transaction_Max_Size>:
    9030:	00000008 	andeq	r0, r0, r8

00009034 <_ZL17symbol_tick_delay>:
    9034:	00000400 	andeq	r0, r0, r0, lsl #8

00009038 <_ZL15char_tick_delay>:
    9038:	00001000 	andeq	r1, r0, r0
    903c:	00000031 	andeq	r0, r0, r1, lsr r0
    9040:	00000030 	andeq	r0, r0, r0, lsr r0
    9044:	646e6152 	strbtvs	r6, [lr], #-338	; 0xfffffeae
    9048:	6e206d6f 	cdpvs	13, 2, cr6, cr0, cr15, {3}
    904c:	65626d75 	strbvs	r6, [r2, #-3445]!	; 0xfffff28b
    9050:	00203a72 	eoreq	r3, r0, r2, ror sl
    9054:	3a564544 	bcc	159a56c <__bss_end+0x1591430>
    9058:	6f697067 	svcvs	0x00697067
    905c:	0037342f 	eorseq	r3, r7, pc, lsr #8
    9060:	3a564544 	bcc	159a578 <__bss_end+0x159143c>
    9064:	74726175 	ldrbtvc	r6, [r2], #-373	; 0xfffffe8b
    9068:	0000302f 	andeq	r3, r0, pc, lsr #32
    906c:	6c6c6548 	cfstr64vs	mvdx6, [ip], #-288	; 0xfffffee0
    9070:	6174206f 	cmnvs	r4, pc, rrx
    9074:	73206b73 			; <UNDEFINED> instruction: 0x73206b73
    9078:	74726174 	ldrbtvc	r6, [r2], #-372	; 0xfffffe8c
    907c:	2e2e6465 	cdpcs	4, 2, cr6, cr14, cr5, {3}
    9080:	00000a2e 	andeq	r0, r0, lr, lsr #20
    9084:	3a564544 	bcc	159a59c <__bss_end+0x1591460>
    9088:	2f633269 	svccs	0x00633269
    908c:	00000031 	andeq	r0, r0, r1, lsr r0
    9090:	3a564544 	bcc	159a5a8 <__bss_end+0x159146c>
    9094:	2f633269 	svccs	0x00633269
    9098:	00000032 	andeq	r0, r0, r2, lsr r0
    909c:	20433249 	subcs	r3, r3, r9, asr #4
    90a0:	6e6e6f63 	cdpvs	15, 6, cr6, cr14, cr3, {3}
    90a4:	69746365 	ldmdbvs	r4!, {r0, r2, r5, r6, r8, r9, sp, lr}^
    90a8:	73206e6f 			; <UNDEFINED> instruction: 0x73206e6f
    90ac:	74726174 	ldrbtvc	r6, [r2], #-372	; 0xfffffe8c
    90b0:	2e2e6465 	cdpcs	4, 2, cr6, cr14, cr5, {3}
    90b4:	00000a2e 	andeq	r0, r0, lr, lsr #20
    90b8:	6e65704f 	cdpvs	0, 6, cr7, cr5, cr15, {2}
    90bc:	6c696620 	stclvs	6, cr6, [r9], #-128	; 0xffffff80
    90c0:	63207365 			; <UNDEFINED> instruction: 0x63207365
    90c4:	65736f6c 	ldrbvs	r6, [r3, #-3948]!	; 0xfffff094
    90c8:	00000a64 	andeq	r0, r0, r4, ror #20

000090cc <_ZL13Lock_Unlocked>:
    90cc:	00000000 	andeq	r0, r0, r0

000090d0 <_ZL11Lock_Locked>:
    90d0:	00000001 	andeq	r0, r0, r1

000090d4 <_ZL21MaxFSDriverNameLength>:
    90d4:	00000010 	andeq	r0, r0, r0, lsl r0

000090d8 <_ZL17MaxFilenameLength>:
    90d8:	00000010 	andeq	r0, r0, r0, lsl r0

000090dc <_ZL13MaxPathLength>:
    90dc:	00000080 	andeq	r0, r0, r0, lsl #1

000090e0 <_ZL18NoFilesystemDriver>:
    90e0:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

000090e4 <_ZL9NotifyAll>:
    90e4:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

000090e8 <_ZL24Max_Process_Opened_Files>:
    90e8:	00000010 	andeq	r0, r0, r0, lsl r0

000090ec <_ZL10Indefinite>:
    90ec:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

000090f0 <_ZL18Deadline_Unchanged>:
    90f0:	fffffffe 			; <UNDEFINED> instruction: 0xfffffffe

000090f4 <_ZL14Invalid_Handle>:
    90f4:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

000090f8 <_ZL16Pipe_File_Prefix>:
    90f8:	3a535953 	bcc	14df64c <__bss_end+0x14d6510>
    90fc:	65706970 	ldrbvs	r6, [r0, #-2416]!	; 0xfffff690
    9100:	0000002f 	andeq	r0, r0, pc, lsr #32

00009104 <_ZN12_GLOBAL__N_1L11CharConvArrE>:
    9104:	33323130 	teqcc	r2, #48, 2
    9108:	37363534 			; <UNDEFINED> instruction: 0x37363534
    910c:	42413938 	submi	r3, r1, #56, 18	; 0xe0000
    9110:	46454443 	strbmi	r4, [r5], -r3, asr #8
	...

Disassembly of section .bss:

00009118 <led>:
__bss_start():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:18
uint32_t led, uart, trng, master, slave;
    9118:	00000000 	andeq	r0, r0, r0

0000911c <uart>:
    911c:	00000000 	andeq	r0, r0, r0

00009120 <trng>:
    9120:	00000000 	andeq	r0, r0, r0

00009124 <master>:
    9124:	00000000 	andeq	r0, r0, r0

00009128 <slave>:
	...

Disassembly of section .ARM.attributes:

00000000 <.ARM.attributes>:
   0:	00002e41 	andeq	r2, r0, r1, asr #28
   4:	61656100 	cmnvs	r5, r0, lsl #2
   8:	01006962 	tsteq	r0, r2, ror #18
   c:	00000024 	andeq	r0, r0, r4, lsr #32
  10:	4b5a3605 	blmi	168d82c <__bss_end+0x16846f0>
  14:	08070600 	stmdaeq	r7, {r9, sl}
  18:	0a010901 	beq	42424 <__bss_end+0x392e8>
  1c:	14041202 	strne	r1, [r4], #-514	; 0xfffffdfe
  20:	17011501 	strne	r1, [r1, -r1, lsl #10]
  24:	1a011803 	bne	46038 <__bss_end+0x3cefc>
  28:	22011c01 	andcs	r1, r1, #256	; 0x100
  2c:	Address 0x000000000000002c is out of bounds.


Disassembly of section .comment:

00000000 <.comment>:
   0:	3a434347 	bcc	10d0d24 <__bss_end+0x10c7be8>
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
  38:	7a617661 	bvc	185d9c4 <__bss_end+0x1854888>
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
  c0:	6a757a61 	bvs	1d5ea4c <__bss_end+0x1d55910>
  c4:	2f696369 	svccs	0x00696369
  c8:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
  cc:	73656d65 	cmnvc	r5, #6464	; 0x1940
  d0:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
  d4:	6b2d616b 	blvs	b58688 <__bss_end+0xb4f54c>
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
 144:	fb010200 	blx	4094e <__bss_end+0x37812>
 148:	01000d0e 	tsteq	r0, lr, lsl #26
 14c:	00010101 	andeq	r0, r1, r1, lsl #2
 150:	00010000 	andeq	r0, r1, r0
 154:	552f0100 	strpl	r0, [pc, #-256]!	; 5c <shift+0x5c>
 158:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 15c:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 160:	6a726574 	bvs	1c99738 <__bss_end+0x1c905fc>
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
 198:	752f7365 	strvc	r7, [pc, #-869]!	; fffffe3b <__bss_end+0xffff6cff>
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
 1d0:	0a05830b 	beq	160e04 <__bss_end+0x157cc8>
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
 1fc:	4a030402 	bmi	c120c <__bss_end+0xb80d0>
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
 230:	4a020402 	bmi	81240 <__bss_end+0x78104>
 234:	02000205 	andeq	r0, r0, #1342177280	; 0x50000000
 238:	052d0204 	streq	r0, [sp, #-516]!	; 0xfffffdfc
 23c:	01058509 	tsteq	r5, r9, lsl #10
 240:	000a022f 	andeq	r0, sl, pc, lsr #4
 244:	03110101 	tsteq	r1, #1073741824	; 0x40000000
 248:	00030000 	andeq	r0, r3, r0
 24c:	00000298 	muleq	r0, r8, r2
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
 280:	6a757a61 	bvs	1d5ec0c <__bss_end+0x1d55ad0>
 284:	2f696369 	svccs	0x00696369
 288:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
 28c:	73656d65 	cmnvc	r5, #6464	; 0x1940
 290:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
 294:	6b2d616b 	blvs	b58848 <__bss_end+0xb4f70c>
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
 2d8:	7a617661 	bvc	185dc64 <__bss_end+0x1854b28>
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
 334:	6b736544 	blvs	1cd984c <__bss_end+0x1cd0710>
 338:	2f706f74 	svccs	0x00706f74
 33c:	2f564146 	svccs	0x00564146
 340:	6176614e 	cmnvs	r6, lr, asr #2
 344:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
 348:	4f2f6963 	svcmi	0x002f6963
 34c:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
 350:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
 354:	6b6c6172 	blvs	1b18924 <__bss_end+0x1b0f7e8>
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
 398:	6b736544 	blvs	1cd98b0 <__bss_end+0x1cd0774>
 39c:	2f706f74 	svccs	0x00706f74
 3a0:	2f564146 	svccs	0x00564146
 3a4:	6176614e 	cmnvs	r6, lr, asr #2
 3a8:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
 3ac:	4f2f6963 	svcmi	0x002f6963
 3b0:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
 3b4:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
 3b8:	6b6c6172 	blvs	1b18988 <__bss_end+0x1b0f84c>
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
 408:	6b736544 	blvs	1cd9920 <__bss_end+0x1cd07e4>
 40c:	2f706f74 	svccs	0x00706f74
 410:	2f564146 	svccs	0x00564146
 414:	6176614e 	cmnvs	r6, lr, asr #2
 418:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
 41c:	4f2f6963 	svcmi	0x002f6963
 420:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
 424:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
 428:	6b6c6172 	blvs	1b189f8 <__bss_end+0x1b0f8bc>
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
 4d0:	32690000 	rsbcc	r0, r9, #0
 4d4:	00682e63 	rsbeq	r2, r8, r3, ror #28
 4d8:	69000005 	stmdbvs	r0, {r0, r2}
 4dc:	6564746e 	strbvs	r7, [r4, #-1134]!	; 0xfffffb92
 4e0:	00682e66 	rsbeq	r2, r8, r6, ror #28
 4e4:	00000004 	andeq	r0, r0, r4
 4e8:	05000105 	streq	r0, [r0, #-261]	; 0xfffffefb
 4ec:	00822c02 	addeq	r2, r2, r2, lsl #24
 4f0:	01140300 	tsteq	r4, r0, lsl #6
 4f4:	bb4b0705 	bllt	12c2110 <__bss_end+0x12b8fd4>
 4f8:	bb010567 	bllt	41a9c <__bss_end+0x38960>
 4fc:	830905a1 	movwhi	r0, #38305	; 0x95a1
 500:	05bb0105 	ldreq	r0, [fp, #261]!	; 0x105
 504:	0a058418 	beq	16156c <__bss_end+0x158430>
 508:	0f05bb6b 	svceq	0x0005bb6b
 50c:	670a052f 	strvs	r0, [sl, -pc, lsr #10]
 510:	054b1405 	strbeq	r1, [fp, #-1029]	; 0xfffffbfb
 514:	09054a0c 	stmdbeq	r5, {r2, r3, r9, fp, lr}
 518:	9f0a052f 	svcls	0x000a052f
 51c:	054a2205 	strbeq	r2, [sl, #-517]	; 0xfffffdfb
 520:	0105820a 	tsteq	r5, sl, lsl #4
 524:	0c05a19f 	stfeqd	f2, [r5], {159}	; 0x9f
 528:	820605a1 	andhi	r0, r6, #675282944	; 0x28400000
 52c:	054b0d05 	strbeq	r0, [fp, #-3333]	; 0xfffff2fb
 530:	0a058207 	beq	160d54 <__bss_end+0x157c18>
 534:	bd12054d 	cfldr32lt	mvfx0, [r2, #-308]	; 0xfffffecc
 538:	05820c05 	streq	r0, [r2, #3077]	; 0xc05
 53c:	0b054b11 	bleq	153188 <__bss_end+0x14a04c>
 540:	4b0a0582 	blmi	281b50 <__bss_end+0x278a14>
 544:	ba1003bb 	blt	401438 <__bss_end+0x3f82fc>
 548:	83070583 	movwhi	r0, #30083	; 0x7583
 54c:	bb830a05 	bllt	fe0c2d68 <__bss_end+0xfe0b9c2c>
 550:	05840c05 	streq	r0, [r4, #3077]	; 0xc05
 554:	1e022f01 	cdpne	15, 0, cr2, cr2, cr1, {0}
 558:	c8010100 	stmdagt	r1, {r8}
 55c:	03000002 	movweq	r0, #2
 560:	0001dd00 	andeq	sp, r1, r0, lsl #26
 564:	fb010200 	blx	40d6e <__bss_end+0x37c32>
 568:	01000d0e 	tsteq	r0, lr, lsl #26
 56c:	00010101 	andeq	r0, r1, r1, lsl #2
 570:	00010000 	andeq	r0, r1, r0
 574:	552f0100 	strpl	r0, [pc, #-256]!	; 47c <shift+0x47c>
 578:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 57c:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 580:	6a726574 	bvs	1c99b58 <__bss_end+0x1c90a1c>
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
 5d0:	6a726574 	bvs	1c99ba8 <__bss_end+0x1c90a6c>
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
 608:	6b2f7365 	blvs	bdd3a4 <__bss_end+0xbd4268>
 60c:	656e7265 	strbvs	r7, [lr, #-613]!	; 0xfffffd9b
 610:	6e692f6c 	cdpvs	15, 6, cr2, cr9, cr12, {3}
 614:	64756c63 	ldrbtvs	r6, [r5], #-3171	; 0xfffff39d
 618:	72702f65 	rsbsvc	r2, r0, #404	; 0x194
 61c:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
 620:	552f0073 	strpl	r0, [pc, #-115]!	; 5b5 <shift+0x5b5>
 624:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 628:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 62c:	6a726574 	bvs	1c99c04 <__bss_end+0x1c90ac8>
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
 664:	6b2f7365 	blvs	bdd400 <__bss_end+0xbd42c4>
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
 698:	6a757a61 	bvs	1d5f024 <__bss_end+0x1d55ee8>
 69c:	2f696369 	svccs	0x00696369
 6a0:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
 6a4:	73656d65 	cmnvc	r5, #6464	; 0x1940
 6a8:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
 6ac:	6b2d616b 	blvs	b58c60 <__bss_end+0xb4fb24>
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
 744:	ac020500 	cfstr32ge	mvfx0, [r2], {-0}
 748:	16000084 	strne	r0, [r0], -r4, lsl #1
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
 774:	4b4bbd05 	blmi	12efb90 <__bss_end+0x12e6a54>
 778:	0c052f4b 	stceq	15, cr2, [r5], {75}	; 0x4b
 77c:	2f01054c 	svccs	0x0001054c
 780:	bd050585 	cfstr32lt	mvfx0, [r5, #-532]	; 0xfffffdec
 784:	2f4b4b4b 	svccs	0x004b4b4b
 788:	054c0c05 	strbeq	r0, [ip, #-3077]	; 0xfffff3fb
 78c:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 790:	054b8305 	strbeq	r8, [fp, #-773]	; 0xfffffcfb
 794:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 798:	4b4bbd05 	blmi	12efbb4 <__bss_end+0x12e6a78>
 79c:	0c052f4b 	stceq	15, cr2, [r5], {75}	; 0x4b
 7a0:	2f01054c 	svccs	0x0001054c
 7a4:	a1050585 	smlabbge	r5, r5, r5, r0
 7a8:	052f4b4b 	streq	r4, [pc, #-2891]!	; fffffc65 <__bss_end+0xffff6b29>
 7ac:	01054c0c 	tsteq	r5, ip, lsl #24
 7b0:	0505852f 	streq	r8, [r5, #-1327]	; 0xfffffad1
 7b4:	4b4b4bbd 	blmi	12d36b0 <__bss_end+0x12ca574>
 7b8:	4c0c052f 	cfstr32mi	mvfx0, [ip], {47}	; 0x2f
 7bc:	852f0105 	strhi	r0, [pc, #-261]!	; 6bf <shift+0x6bf>
 7c0:	4ba10505 	blmi	fe841bdc <__bss_end+0xfe838aa0>
 7c4:	0c052f4b 	stceq	15, cr2, [r5], {75}	; 0x4b
 7c8:	9f01054c 	svcls	0x0001054c
 7cc:	67200585 	strvs	r0, [r0, -r5, lsl #11]!
 7d0:	4b4d0505 	blmi	1341bec <__bss_end+0x1338ab0>
 7d4:	300c054b 	andcc	r0, ip, fp, asr #10
 7d8:	852f0105 	strhi	r0, [pc, #-261]!	; 6db <shift+0x6db>
 7dc:	05672005 	strbeq	r2, [r7, #-5]!
 7e0:	4b4b4d05 	blmi	12d3bfc <__bss_end+0x12caac0>
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
 824:	9b010100 	blls	40c2c <__bss_end+0x37af0>
 828:	03000002 	movweq	r0, #2
 82c:	00007400 	andeq	r7, r0, r0, lsl #8
 830:	fb010200 	blx	4103a <__bss_end+0x37efe>
 834:	01000d0e 	tsteq	r0, lr, lsl #26
 838:	00010101 	andeq	r0, r1, r1, lsl #2
 83c:	00010000 	andeq	r0, r1, r0
 840:	552f0100 	strpl	r0, [pc, #-256]!	; 748 <shift+0x748>
 844:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 848:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 84c:	6a726574 	bvs	1c99e24 <__bss_end+0x1c90ce8>
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
 8a8:	89080205 	stmdbhi	r8, {r0, r2, r9}
 8ac:	051a0000 	ldreq	r0, [sl, #-0]
 8b0:	0f05bb06 	svceq	0x0005bb06
 8b4:	6821054c 	stmdavs	r1!, {r2, r3, r6, r8, sl}
 8b8:	05ba0a05 	ldreq	r0, [sl, #2565]!	; 0xa05
 8bc:	27052e0b 	strcs	r2, [r5, -fp, lsl #28]
 8c0:	4a0d054a 	bmi	341df0 <__bss_end+0x338cb4>
 8c4:	052f0905 	streq	r0, [pc, #-2309]!	; ffffffc7 <__bss_end+0xffff6e8b>
 8c8:	02059f04 	andeq	r9, r5, #4, 30
 8cc:	35050562 	strcc	r0, [r5, #-1378]	; 0xfffffa9e
 8d0:	05681005 	strbeq	r1, [r8, #-5]!
 8d4:	22052e11 	andcs	r2, r5, #272	; 0x110
 8d8:	2e13054a 	cfmac32cs	mvfx0, mvfx3, mvfx10
 8dc:	052f0a05 	streq	r0, [pc, #-2565]!	; fffffedf <__bss_end+0xffff6da3>
 8e0:	0a056909 	beq	15ad0c <__bss_end+0x151bd0>
 8e4:	4a0c052e 	bmi	301da4 <__bss_end+0x2f8c68>
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
 914:	4b020402 	blmi	81924 <__bss_end+0x787e8>
 918:	02001b05 	andeq	r1, r0, #5120	; 0x1400
 91c:	052e0204 	streq	r0, [lr, #-516]!	; 0xfffffdfc
 920:	0402000c 	streq	r0, [r2], #-12
 924:	0f054a02 	svceq	0x00054a02
 928:	02040200 	andeq	r0, r4, #0, 4
 92c:	001b0582 	andseq	r0, fp, r2, lsl #11
 930:	4a020402 	bmi	81940 <__bss_end+0x78804>
 934:	02001105 	andeq	r1, r0, #1073741825	; 0x40000001
 938:	052e0204 	streq	r0, [lr, #-516]!	; 0xfffffdfc
 93c:	0402000a 	streq	r0, [r2], #-10
 940:	0b052f02 	bleq	14c550 <__bss_end+0x143414>
 944:	02040200 	andeq	r0, r4, #0, 4
 948:	000d052e 	andeq	r0, sp, lr, lsr #10
 94c:	4a020402 	bmi	8195c <__bss_end+0x78820>
 950:	02000205 	andeq	r0, r0, #1342177280	; 0x50000000
 954:	05460204 	strbeq	r0, [r6, #-516]	; 0xfffffdfc
 958:	05858801 	streq	r8, [r5, #2049]	; 0x801
 95c:	09058306 	stmdbeq	r5, {r1, r2, r8, r9, pc}
 960:	4a10054c 	bmi	401e98 <__bss_end+0x3f8d5c>
 964:	054c0a05 	strbeq	r0, [ip, #-2565]	; 0xfffff5fb
 968:	0305bb07 	movweq	fp, #23303	; 0x5b07
 96c:	0017054a 	andseq	r0, r7, sl, asr #10
 970:	4a010402 	bmi	41980 <__bss_end+0x38844>
 974:	02001405 	andeq	r1, r0, #83886080	; 0x5000000
 978:	054a0104 	strbeq	r0, [sl, #-260]	; 0xfffffefc
 97c:	14054d0d 	strne	r4, [r5], #-3341	; 0xfffff2f3
 980:	2e0a054a 	cfsh32cs	mvfx0, mvfx10, #42
 984:	05680805 	strbeq	r0, [r8, #-2053]!	; 0xfffff7fb
 988:	66780302 	ldrbtvs	r0, [r8], -r2, lsl #6
 98c:	0b030905 	bleq	c2da8 <__bss_end+0xb9c6c>
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
 9f8:	0b052e01 	bleq	14c204 <__bss_end+0x1430c8>
 9fc:	01040200 	mrseq	r0, R12_usr
 a00:	0002054a 	andeq	r0, r2, sl, asr #10
 a04:	49010402 	stmdbmi	r1, {r1, sl}
 a08:	05850b05 	streq	r0, [r5, #2821]	; 0xb05
 a0c:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 a10:	1105bc0e 	tstne	r5, lr, lsl #24
 a14:	bc200566 	cfstr32lt	mvfx0, [r0], #-408	; 0xfffffe68
 a18:	05660b05 	strbeq	r0, [r6, #-2821]!	; 0xfffff4fb
 a1c:	0a054b1f 	beq	1536a0 <__bss_end+0x14a564>
 a20:	4b080566 	blmi	201fc0 <__bss_end+0x1f8e84>
 a24:	05831105 	streq	r1, [r3, #261]	; 0x105
 a28:	08052e16 	stmdaeq	r5, {r1, r2, r4, r9, sl, fp, sp}
 a2c:	67110567 	ldrvs	r0, [r1, -r7, ror #10]
 a30:	054d0b05 	strbeq	r0, [sp, #-2821]	; 0xfffff4fb
 a34:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 a38:	0b058306 	bleq	161658 <__bss_end+0x15851c>
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
 a7c:	bb0e0585 	bllt	382098 <__bss_end+0x378f5c>
 a80:	054b0805 	strbeq	r0, [fp, #-2053]	; 0xfffff7fb
 a84:	14054c0b 	strne	r4, [r5], #-3083	; 0xfffff3f5
 a88:	03040200 	movweq	r0, #16896	; 0x4200
 a8c:	0016054a 	andseq	r0, r6, sl, asr #10
 a90:	83020402 	movwhi	r0, #9218	; 0x2402
 a94:	02001705 	andeq	r1, r0, #1310720	; 0x140000
 a98:	052e0204 	streq	r0, [lr, #-516]!	; 0xfffffdfc
 a9c:	0402000a 	streq	r0, [r2], #-10
 aa0:	0b054a02 	bleq	1532b0 <__bss_end+0x14a174>
 aa4:	02040200 	andeq	r0, r4, #0, 4
 aa8:	0017052e 	andseq	r0, r7, lr, lsr #10
 aac:	4a020402 	bmi	81abc <__bss_end+0x78980>
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
      58:	0ab00704 	beq	fec01c70 <__bss_end+0xfebf8b34>
      5c:	5b020000 	blpl	80064 <__bss_end+0x76f28>
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
     128:	00000ab0 			; <UNDEFINED> instruction: 0x00000ab0
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
     174:	cb104801 	blgt	412180 <__bss_end+0x409044>
     178:	d4000000 	strle	r0, [r0], #-0
     17c:	58000081 	stmdapl	r0, {r0, r7}
     180:	01000000 	mrseq	r0, (UNDEF: 0)
     184:	0000cb9c 	muleq	r0, ip, fp
     188:	02b40a00 	adcseq	r0, r4, #0, 20
     18c:	4a010000 	bmi	40194 <__bss_end+0x37058>
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
     21c:	ba0d9c01 	blt	367228 <__bss_end+0x35e0ec>
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
     24c:	8b120f01 	blhi	483e58 <__bss_end+0x47ad1c>
     250:	0f000001 	svceq	0x00000001
     254:	0000019e 	muleq	r0, lr, r1
     258:	03d51000 	bicseq	r1, r5, #0
     25c:	0a010000 	beq	40264 <__bss_end+0x37128>
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
     2b4:	8b140074 	blhi	50048c <__bss_end+0x4f7350>
     2b8:	a4000001 	strge	r0, [r0], #-1
     2bc:	38000080 	stmdacc	r0, {r7}
     2c0:	01000000 	mrseq	r0, (UNDEF: 0)
     2c4:	0067139c 	mlseq	r7, ip, r3, r1
     2c8:	9e2f0a01 	vmulls.f32	s0, s30, s2
     2cc:	02000001 	andeq	r0, r0, #1
     2d0:	00007491 	muleq	r0, r1, r4
     2d4:	000008f1 	strdeq	r0, [r0], -r1
     2d8:	01e00004 	mvneq	r0, r4
     2dc:	01040000 	mrseq	r0, (UNDEF: 4)
     2e0:	000001e1 	andeq	r0, r0, r1, ror #3
     2e4:	00085c04 	andeq	r5, r8, r4, lsl #24
     2e8:	00005600 	andeq	r5, r0, r0, lsl #12
     2ec:	00822c00 	addeq	r2, r2, r0, lsl #24
     2f0:	00028000 	andeq	r8, r2, r0
     2f4:	00024600 	andeq	r4, r2, r0, lsl #12
     2f8:	08010200 	stmdaeq	r1, {r9}
     2fc:	00000b45 	andeq	r0, r0, r5, asr #22
     300:	f5050202 			; <UNDEFINED> instruction: 0xf5050202
     304:	03000009 	movweq	r0, #9
     308:	6e690504 	cdpvs	5, 6, cr0, cr9, cr4, {0}
     30c:	01020074 	tsteq	r2, r4, ror r0
     310:	000b3c08 	andeq	r3, fp, r8, lsl #24
     314:	07020200 	streq	r0, [r2, -r0, lsl #4]
     318:	00000bf3 	strdeq	r0, [r0], -r3
     31c:	00060804 	andeq	r0, r6, r4, lsl #16
     320:	07090a00 	streq	r0, [r9, -r0, lsl #20]
     324:	00000059 	andeq	r0, r0, r9, asr r0
     328:	00004805 	andeq	r4, r0, r5, lsl #16
     32c:	07040200 	streq	r0, [r4, -r0, lsl #4]
     330:	00000ab0 			; <UNDEFINED> instruction: 0x00000ab0
     334:	00005905 	andeq	r5, r0, r5, lsl #18
     338:	0ca80600 	stceq	6, cr0, [r8]
     33c:	02080000 	andeq	r0, r8, #0
     340:	008b0806 	addeq	r0, fp, r6, lsl #16
     344:	72070000 	andvc	r0, r7, #0
     348:	08020030 	stmdaeq	r2, {r4, r5}
     34c:	0000480e 	andeq	r4, r0, lr, lsl #16
     350:	72070000 	andvc	r0, r7, #0
     354:	09020031 	stmdbeq	r2, {r0, r4, r5}
     358:	0000480e 	andeq	r4, r0, lr, lsl #16
     35c:	08000400 	stmdaeq	r0, {sl}
     360:	00000a50 	andeq	r0, r0, r0, asr sl
     364:	00330405 	eorseq	r0, r3, r5, lsl #8
     368:	1e020000 	cdpne	0, 0, cr0, cr2, cr0, {0}
     36c:	0000c20c 	andeq	ip, r0, ip, lsl #4
     370:	06000900 	streq	r0, [r0], -r0, lsl #18
     374:	09000000 	stmdbeq	r0, {}	; <UNPREDICTABLE>
     378:	00000757 	andeq	r0, r0, r7, asr r7
     37c:	0a720901 	beq	1c82788 <__bss_end+0x1c7964c>
     380:	09020000 	stmdbeq	r2, {}	; <UNPREDICTABLE>
     384:	00000b67 	andeq	r0, r0, r7, ror #22
     388:	07370903 	ldreq	r0, [r7, -r3, lsl #18]!
     38c:	09040000 	stmdbeq	r4, {}	; <UNPREDICTABLE>
     390:	000009ec 	andeq	r0, r0, ip, ror #19
     394:	38080005 	stmdacc	r8, {r0, r2}
     398:	0500000a 	streq	r0, [r0, #-10]
     39c:	00003304 	andeq	r3, r0, r4, lsl #6
     3a0:	0c3f0200 	lfmeq	f0, 4, [pc], #-0	; 3a8 <shift+0x3a8>
     3a4:	000000ff 	strdeq	r0, [r0], -pc	; <UNPREDICTABLE>
     3a8:	0006cb09 	andeq	ip, r6, r9, lsl #22
     3ac:	52090000 	andpl	r0, r9, #0
     3b0:	01000007 	tsteq	r0, r7
     3b4:	000c2f09 	andeq	r2, ip, r9, lsl #30
     3b8:	55090200 	strpl	r0, [r9, #-512]	; 0xfffffe00
     3bc:	03000009 	movweq	r0, #9
     3c0:	00074609 	andeq	r4, r7, r9, lsl #12
     3c4:	95090400 	strls	r0, [r9, #-1024]	; 0xfffffc00
     3c8:	05000007 	streq	r0, [r0, #-7]
     3cc:	00061b09 	andeq	r1, r6, r9, lsl #22
     3d0:	0a000600 	beq	1bd8 <shift+0x1bd8>
     3d4:	00000933 	andeq	r0, r0, r3, lsr r9
     3d8:	54140503 	ldrpl	r0, [r4], #-1283	; 0xfffffafd
     3dc:	05000000 	streq	r0, [r0, #-0]
     3e0:	008fd003 	addeq	sp, pc, r3
     3e4:	0ad00a00 	beq	ff402bec <__bss_end+0xff3f9ab0>
     3e8:	06030000 	streq	r0, [r3], -r0
     3ec:	00005414 	andeq	r5, r0, r4, lsl r4
     3f0:	d4030500 	strle	r0, [r3], #-1280	; 0xfffffb00
     3f4:	0a00008f 	beq	638 <shift+0x638>
     3f8:	000007aa 	andeq	r0, r0, sl, lsr #15
     3fc:	541a0704 	ldrpl	r0, [sl], #-1796	; 0xfffff8fc
     400:	05000000 	streq	r0, [r0, #-0]
     404:	008fd803 	addeq	sp, pc, r3, lsl #16
     408:	09ff0a00 	ldmibeq	pc!, {r9, fp}^	; <UNPREDICTABLE>
     40c:	09040000 	stmdbeq	r4, {}	; <UNPREDICTABLE>
     410:	0000541a 	andeq	r5, r0, sl, lsl r4
     414:	dc030500 	cfstr32le	mvfx0, [r3], {-0}
     418:	0a00008f 	beq	65c <shift+0x65c>
     41c:	0000079c 	muleq	r0, ip, r7
     420:	541a0b04 	ldrpl	r0, [sl], #-2820	; 0xfffff4fc
     424:	05000000 	streq	r0, [r0, #-0]
     428:	008fe003 	addeq	lr, pc, r3
     42c:	09d90a00 	ldmibeq	r9, {r9, fp}^
     430:	0d040000 	stceq	0, cr0, [r4, #-0]
     434:	0000541a 	andeq	r5, r0, sl, lsl r4
     438:	e4030500 	str	r0, [r3], #-1280	; 0xfffffb00
     43c:	0a00008f 	beq	680 <shift+0x680>
     440:	000005e0 	andeq	r0, r0, r0, ror #11
     444:	541a0f04 	ldrpl	r0, [sl], #-3844	; 0xfffff0fc
     448:	05000000 	streq	r0, [r0, #-0]
     44c:	008fe803 	addeq	lr, pc, r3, lsl #16
     450:	10f00800 	rscsne	r0, r0, r0, lsl #16
     454:	04050000 	streq	r0, [r5], #-0
     458:	00000033 	andeq	r0, r0, r3, lsr r0
     45c:	a20c1b04 	andge	r1, ip, #4, 22	; 0x1000
     460:	09000001 	stmdbeq	r0, {r0}
     464:	0000058f 	andeq	r0, r0, pc, lsl #11
     468:	0b920900 	bleq	fe482870 <__bss_end+0xfe479734>
     46c:	09010000 	stmdbeq	r1, {}	; <UNPREDICTABLE>
     470:	00000c2a 	andeq	r0, r0, sl, lsr #24
     474:	590b0002 	stmdbpl	fp, {r1}
     478:	02000004 	andeq	r0, r0, #4
     47c:	08140201 	ldmdaeq	r4, {r0, r9}
     480:	040c0000 	streq	r0, [ip], #-0
     484:	000001a2 	andeq	r0, r0, r2, lsr #3
     488:	0005990a 	andeq	r9, r5, sl, lsl #18
     48c:	14040500 	strne	r0, [r4], #-1280	; 0xfffffb00
     490:	00000054 	andeq	r0, r0, r4, asr r0
     494:	8fec0305 	svchi	0x00ec0305
     498:	7d0a0000 	stcvc	0, cr0, [sl, #-0]
     49c:	0500000a 	streq	r0, [r0, #-10]
     4a0:	00541407 	subseq	r1, r4, r7, lsl #8
     4a4:	03050000 	movweq	r0, #20480	; 0x5000
     4a8:	00008ff0 	strdeq	r8, [r0], -r0
     4ac:	0004e70a 	andeq	lr, r4, sl, lsl #14
     4b0:	140a0500 	strne	r0, [sl], #-1280	; 0xfffffb00
     4b4:	00000054 	andeq	r0, r0, r4, asr r0
     4b8:	8ff40305 	svchi	0x00f40305
     4bc:	20080000 	andcs	r0, r8, r0
     4c0:	05000006 	streq	r0, [r0, #-6]
     4c4:	00003304 	andeq	r3, r0, r4, lsl #6
     4c8:	0c0d0500 	cfstr32eq	mvfx0, [sp], {-0}
     4cc:	00000221 	andeq	r0, r0, r1, lsr #4
     4d0:	77654e0d 	strbvc	r4, [r5, -sp, lsl #28]!
     4d4:	c7090000 	strgt	r0, [r9, -r0]
     4d8:	01000004 	tsteq	r0, r4
     4dc:	0004df09 	andeq	sp, r4, r9, lsl #30
     4e0:	43090200 	movwmi	r0, #37376	; 0x9200
     4e4:	03000006 	movweq	r0, #6
     4e8:	000b5909 	andeq	r5, fp, r9, lsl #18
     4ec:	bb090400 	bllt	2414f4 <__bss_end+0x2383b8>
     4f0:	05000004 	streq	r0, [r0, #-4]
     4f4:	05b20600 	ldreq	r0, [r2, #1536]!	; 0x600
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
     524:	320e0800 	andcc	r0, lr, #0, 16
     528:	0500000a 	streq	r0, [r0, #-10]
     52c:	02601320 	rsbeq	r1, r0, #32, 6	; 0x80000000
     530:	000c0000 	andeq	r0, ip, r0
     534:	ab070402 	blge	1c1544 <__bss_end+0x1b8408>
     538:	0500000a 	streq	r0, [r0, #-10]
     53c:	00000260 	andeq	r0, r0, r0, ror #4
     540:	00072a06 	andeq	r2, r7, r6, lsl #20
     544:	28057000 	stmdacs	r5, {ip, sp, lr}
     548:	0002fc08 	andeq	pc, r2, r8, lsl #24
     54c:	06b00e00 	ldrteq	r0, [r0], r0, lsl #28
     550:	2a050000 	bcs	140558 <__bss_end+0x13741c>
     554:	00022112 	andeq	r2, r2, r2, lsl r1
     558:	70070000 	andvc	r0, r7, r0
     55c:	05006469 	streq	r6, [r0, #-1129]	; 0xfffffb97
     560:	0059122b 	subseq	r1, r9, fp, lsr #4
     564:	0e100000 	cdpeq	0, 1, cr0, cr0, cr0, {0}
     568:	00000b8c 	andeq	r0, r0, ip, lsl #23
     56c:	ea112c05 	b	44b588 <__bss_end+0x44244c>
     570:	14000001 	strne	r0, [r0], #-1
     574:	000b2e0e 	andeq	r2, fp, lr, lsl #28
     578:	122d0500 	eorne	r0, sp, #0, 10
     57c:	00000059 	andeq	r0, r0, r9, asr r0
     580:	03e90e18 	mvneq	r0, #24, 28	; 0x180
     584:	2e050000 	cdpcs	0, 0, cr0, cr5, cr0, {0}
     588:	00005912 	andeq	r5, r0, r2, lsl r9
     58c:	650e1c00 	strvs	r1, [lr, #-3072]	; 0xfffff400
     590:	0500000a 	streq	r0, [r0, #-10]
     594:	02fc0c2f 	rscseq	r0, ip, #12032	; 0x2f00
     598:	0e200000 	cdpeq	0, 2, cr0, cr0, cr0, {0}
     59c:	00000472 	andeq	r0, r0, r2, ror r4
     5a0:	33093005 	movwcc	r3, #36869	; 0x9005
     5a4:	60000000 	andvs	r0, r0, r0
     5a8:	00066e0e 	andeq	r6, r6, lr, lsl #28
     5ac:	0e310500 	cfabs32eq	mvfx0, mvfx1
     5b0:	00000048 	andeq	r0, r0, r8, asr #32
     5b4:	09a30e64 	stmibeq	r3!, {r2, r5, r6, r9, sl, fp}
     5b8:	33050000 	movwcc	r0, #20480	; 0x5000
     5bc:	0000480e 	andeq	r4, r0, lr, lsl #16
     5c0:	9a0e6800 	bls	39a5c8 <__bss_end+0x39148c>
     5c4:	05000009 	streq	r0, [r0, #-9]
     5c8:	00480e34 	subeq	r0, r8, r4, lsr lr
     5cc:	006c0000 	rsbeq	r0, ip, r0
     5d0:	0001ae0f 	andeq	sl, r1, pc, lsl #28
     5d4:	00030c00 	andeq	r0, r3, r0, lsl #24
     5d8:	00591000 	subseq	r1, r9, r0
     5dc:	000f0000 	andeq	r0, pc, r0
     5e0:	0004d00a 	andeq	sp, r4, sl
     5e4:	140a0600 	strne	r0, [sl], #-1536	; 0xfffffa00
     5e8:	00000054 	andeq	r0, r0, r4, asr r0
     5ec:	8ff80305 	svchi	0x00f80305
     5f0:	e5080000 	str	r0, [r8, #-0]
     5f4:	05000007 	streq	r0, [r0, #-7]
     5f8:	00003304 	andeq	r3, r0, r4, lsl #6
     5fc:	0c0d0600 	stceq	6, cr0, [sp], {-0}
     600:	0000033d 	andeq	r0, r0, sp, lsr r3
     604:	000c3509 	andeq	r3, ip, r9, lsl #10
     608:	a6090000 	strge	r0, [r9], -r0
     60c:	0100000b 	tsteq	r0, fp
     610:	069d0600 	ldreq	r0, [sp], r0, lsl #12
     614:	060c0000 	streq	r0, [ip], -r0
     618:	0372081b 	cmneq	r2, #1769472	; 0x1b0000
     61c:	5c0e0000 	stcpl	0, cr0, [lr], {-0}
     620:	06000005 	streq	r0, [r0], -r5
     624:	0372191d 	cmneq	r2, #475136	; 0x74000
     628:	0e000000 	cdpeq	0, 0, cr0, cr0, cr0, {0}
     62c:	000004c2 	andeq	r0, r0, r2, asr #9
     630:	72191e06 	andsvc	r1, r9, #6, 28	; 0x60
     634:	04000003 	streq	r0, [r0], #-3
     638:	0008090e 	andeq	r0, r8, lr, lsl #18
     63c:	131f0600 	tstne	pc, #0, 12
     640:	00000378 	andeq	r0, r0, r8, ror r3
     644:	040c0008 	streq	r0, [ip], #-8
     648:	0000033d 	andeq	r0, r0, sp, lsr r3
     64c:	026c040c 	rsbeq	r0, ip, #12, 8	; 0xc000000
     650:	11110000 	tstne	r1, r0
     654:	1400000a 	strne	r0, [r0], #-10
     658:	00072206 	andeq	r2, r7, r6, lsl #4
     65c:	0e000006 	cdpeq	0, 0, cr0, cr0, cr6, {0}
     660:	00000941 	andeq	r0, r0, r1, asr #18
     664:	48122606 	ldmdami	r2, {r1, r2, r9, sl, sp}
     668:	00000000 	andeq	r0, r0, r0
     66c:	0008dc0e 	andeq	sp, r8, lr, lsl #24
     670:	1d290600 	stcne	6, cr0, [r9, #-0]
     674:	00000372 	andeq	r0, r0, r2, ror r3
     678:	064b0e04 	strbeq	r0, [fp], -r4, lsl #28
     67c:	2c060000 	stccs	0, cr0, [r6], {-0}
     680:	0003721d 	andeq	r7, r3, sp, lsl r2
     684:	4b120800 	blmi	48268c <__bss_end+0x479550>
     688:	06000009 	streq	r0, [r0], -r9
     68c:	067a0e2f 	ldrbteq	r0, [sl], -pc, lsr #28
     690:	03c60000 	biceq	r0, r6, #0
     694:	03d10000 	bicseq	r0, r1, #0
     698:	05130000 	ldreq	r0, [r3, #-0]
     69c:	14000006 	strne	r0, [r0], #-6
     6a0:	00000372 	andeq	r0, r0, r2, ror r3
     6a4:	07611500 	strbeq	r1, [r1, -r0, lsl #10]!
     6a8:	31060000 	mrscc	r0, (UNDEF: 6)
     6ac:	0007010e 	andeq	r0, r7, lr, lsl #2
     6b0:	0001a700 	andeq	sl, r1, r0, lsl #14
     6b4:	0003e900 	andeq	lr, r3, r0, lsl #18
     6b8:	0003f400 	andeq	pc, r3, r0, lsl #8
     6bc:	06051300 	streq	r1, [r5], -r0, lsl #6
     6c0:	78140000 	ldmdavc	r4, {}	; <UNPREDICTABLE>
     6c4:	00000003 	andeq	r0, r0, r3
     6c8:	000b6d16 	andeq	r6, fp, r6, lsl sp
     6cc:	1d350600 	ldcne	6, cr0, [r5, #-0]
     6d0:	000007c0 	andeq	r0, r0, r0, asr #15
     6d4:	00000372 	andeq	r0, r0, r2, ror r3
     6d8:	00040d02 	andeq	r0, r4, r2, lsl #26
     6dc:	00041300 	andeq	r1, r4, r0, lsl #6
     6e0:	06051300 	streq	r1, [r5], -r0, lsl #6
     6e4:	16000000 	strne	r0, [r0], -r0
     6e8:	0000062c 	andeq	r0, r0, ip, lsr #12
     6ec:	5b1d3706 	blpl	74e30c <__bss_end+0x7451d0>
     6f0:	72000009 	andvc	r0, r0, #9
     6f4:	02000003 	andeq	r0, r0, #3
     6f8:	0000042c 	andeq	r0, r0, ip, lsr #8
     6fc:	00000432 	andeq	r0, r0, r2, lsr r4
     700:	00060513 	andeq	r0, r6, r3, lsl r5
     704:	ef170000 	svc	0x00170000
     708:	06000008 	streq	r0, [r0], -r8
     70c:	061e3139 			; <UNDEFINED> instruction: 0x061e3139
     710:	020c0000 	andeq	r0, ip, #0
     714:	000a1116 	andeq	r1, sl, r6, lsl r1
     718:	093c0600 	ldmdbeq	ip!, {r9, sl}
     71c:	00000770 	andeq	r0, r0, r0, ror r7
     720:	00000605 	andeq	r0, r0, r5, lsl #12
     724:	00045901 	andeq	r5, r4, r1, lsl #18
     728:	00045f00 	andeq	r5, r4, r0, lsl #30
     72c:	06051300 	streq	r1, [r5], -r0, lsl #6
     730:	16000000 	strne	r0, [r0], -r0
     734:	000006bc 			; <UNDEFINED> instruction: 0x000006bc
     738:	18123f06 	ldmdane	r2, {r1, r2, r8, r9, sl, fp, ip, sp}
     73c:	48000005 	stmdami	r0, {r0, r2}
     740:	01000000 	mrseq	r0, (UNDEF: 0)
     744:	00000478 	andeq	r0, r0, r8, ror r4
     748:	0000048d 	andeq	r0, r0, sp, lsl #9
     74c:	00060513 	andeq	r0, r6, r3, lsl r5
     750:	06271400 	strteq	r1, [r7], -r0, lsl #8
     754:	59140000 	ldmdbpl	r4, {}	; <UNPREDICTABLE>
     758:	14000000 	strne	r0, [r0], #-0
     75c:	000001a7 	andeq	r0, r0, r7, lsr #3
     760:	0b9d1800 	bleq	fe746768 <__bss_end+0xfe73d62c>
     764:	42060000 	andmi	r0, r6, #0
     768:	0005bf0e 	andeq	fp, r5, lr, lsl #30
     76c:	04a20100 	strteq	r0, [r2], #256	; 0x100
     770:	04a80000 	strteq	r0, [r8], #0
     774:	05130000 	ldreq	r0, [r3, #-0]
     778:	00000006 	andeq	r0, r0, r6
     77c:	0004fa16 	andeq	pc, r4, r6, lsl sl	; <UNPREDICTABLE>
     780:	17450600 	strbne	r0, [r5, -r0, lsl #12]
     784:	00000561 	andeq	r0, r0, r1, ror #10
     788:	00000378 	andeq	r0, r0, r8, ror r3
     78c:	0004c101 	andeq	ip, r4, r1, lsl #2
     790:	0004c700 	andeq	ip, r4, r0, lsl #14
     794:	062d1300 	strteq	r1, [sp], -r0, lsl #6
     798:	16000000 	strne	r0, [r0], -r0
     79c:	00000a88 	andeq	r0, r0, r8, lsl #21
     7a0:	ff174806 			; <UNDEFINED> instruction: 0xff174806
     7a4:	78000003 	stmdavc	r0, {r0, r1}
     7a8:	01000003 	tsteq	r0, r3
     7ac:	000004e0 	andeq	r0, r0, r0, ror #9
     7b0:	000004eb 	andeq	r0, r0, fp, ror #9
     7b4:	00062d13 	andeq	r2, r6, r3, lsl sp
     7b8:	00481400 	subeq	r1, r8, r0, lsl #8
     7bc:	18000000 	stmdane	r0, {}	; <UNPREDICTABLE>
     7c0:	000005ea 	andeq	r0, r0, sl, ror #11
     7c4:	fd0e4b06 	stc2	11, cr4, [lr, #-24]	; 0xffffffe8	; <UNPREDICTABLE>
     7c8:	01000008 	tsteq	r0, r8
     7cc:	00000500 	andeq	r0, r0, r0, lsl #10
     7d0:	00000506 	andeq	r0, r0, r6, lsl #10
     7d4:	00060513 	andeq	r0, r6, r3, lsl r5
     7d8:	61160000 	tstvs	r6, r0
     7dc:	06000007 	streq	r0, [r0], -r7
     7e0:	09b10e4d 	ldmibeq	r1!, {r0, r2, r3, r6, r9, sl, fp}
     7e4:	01a70000 			; <UNDEFINED> instruction: 0x01a70000
     7e8:	1f010000 	svcne	0x00010000
     7ec:	2a000005 	bcs	808 <shift+0x808>
     7f0:	13000005 	movwne	r0, #5
     7f4:	00000605 	andeq	r0, r0, r5, lsl #12
     7f8:	00004814 	andeq	r4, r0, r4, lsl r8
     7fc:	a7160000 	ldrge	r0, [r6, -r0]
     800:	06000004 	streq	r0, [r0], -r4
     804:	042c1250 	strteq	r1, [ip], #-592	; 0xfffffdb0
     808:	00480000 	subeq	r0, r8, r0
     80c:	43010000 	movwmi	r0, #4096	; 0x1000
     810:	4e000005 	cdpmi	0, 0, cr0, cr0, cr5, {0}
     814:	13000005 	movwne	r0, #5
     818:	00000605 	andeq	r0, r0, r5, lsl #12
     81c:	0001ae14 	andeq	sl, r1, r4, lsl lr
     820:	5f160000 	svcpl	0x00160000
     824:	06000004 	streq	r0, [r0], -r4
     828:	0bb10e53 	bleq	fec4417c <__bss_end+0xfec3b040>
     82c:	01a70000 			; <UNDEFINED> instruction: 0x01a70000
     830:	67010000 	strvs	r0, [r1, -r0]
     834:	72000005 	andvc	r0, r0, #5
     838:	13000005 	movwne	r0, #5
     83c:	00000605 	andeq	r0, r0, r5, lsl #12
     840:	00004814 	andeq	r4, r0, r4, lsl r8
     844:	81180000 	tsthi	r8, r0
     848:	06000004 	streq	r0, [r0], -r4
     84c:	0adc0e56 	beq	ff7041ac <__bss_end+0xff6fb070>
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
     878:	dd180000 	ldcle	0, cr0, [r8, #-0]
     87c:	0600000b 	streq	r0, [r0], -fp
     880:	0c5c0e58 	mrrceq	14, 5, r0, ip, cr8
     884:	bb010000 	bllt	4088c <__bss_end+0x37750>
     888:	da000005 	ble	8a4 <shift+0x8a4>
     88c:	13000005 	movwne	r0, #5
     890:	00000605 	andeq	r0, r0, r5, lsl #12
     894:	0000c214 	andeq	ip, r0, r4, lsl r2
     898:	00481400 	subeq	r1, r8, r0, lsl #8
     89c:	48140000 	ldmdami	r4, {}	; <UNPREDICTABLE>
     8a0:	14000000 	strne	r0, [r0], #-0
     8a4:	00000048 	andeq	r0, r0, r8, asr #32
     8a8:	00063314 	andeq	r3, r6, r4, lsl r3
     8ac:	94190000 	ldrls	r0, [r9], #-0
     8b0:	06000004 	streq	r0, [r0], -r4
     8b4:	08190e5b 	ldmdaeq	r9, {r0, r1, r3, r4, r6, r9, sl, fp}
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
     914:	050b0507 	streq	r0, [fp, #-1287]	; 0xfffffaf9
     918:	1f000007 	svcne	0x00000007
     91c:	000008c9 	andeq	r0, r0, r9, asr #17
     920:	60190707 	andsvs	r0, r9, r7, lsl #14
     924:	80000000 	andhi	r0, r0, r0
     928:	1f0ee6b2 	svcne	0x000ee6b2
     92c:	00000a9b 	muleq	r0, fp, sl
     930:	671a0a07 	ldrvs	r0, [sl, -r7, lsl #20]
     934:	00000002 	andeq	r0, r0, r2
     938:	1f200000 	svcne	0x00200000
     93c:	0000050e 	andeq	r0, r0, lr, lsl #10
     940:	671a0d07 	ldrvs	r0, [sl, -r7, lsl #26]
     944:	00000002 	andeq	r0, r0, r2
     948:	20202000 	eorcs	r2, r0, r0
     94c:	000007fa 	strdeq	r0, [r0], -sl
     950:	54151007 	ldrpl	r1, [r5], #-7
     954:	36000000 	strcc	r0, [r0], -r0
     958:	000b791f 	andeq	r7, fp, pc, lsl r9
     95c:	1a420700 	bne	1082564 <__bss_end+0x1079428>
     960:	00000267 	andeq	r0, r0, r7, ror #4
     964:	20215000 	eorcs	r5, r1, r0
     968:	000c101f 	andeq	r1, ip, pc, lsl r0
     96c:	1a710700 	bne	1c42574 <__bss_end+0x1c39438>
     970:	00000267 	andeq	r0, r0, r7, ror #4
     974:	2000b200 	andcs	fp, r0, r0, lsl #4
     978:	0006d01f 	andeq	sp, r6, pc, lsl r0
     97c:	1aa40700 	bne	fe902584 <__bss_end+0xfe8f9448>
     980:	00000267 	andeq	r0, r0, r7, ror #4
     984:	2000b400 	andcs	fp, r0, r0, lsl #8
     988:	0008bf1f 	andeq	fp, r8, pc, lsl pc
     98c:	1ab30700 	bne	fecc2594 <__bss_end+0xfecb9458>
     990:	00000267 	andeq	r0, r0, r7, ror #4
     994:	20104000 	andscs	r4, r0, r0
     998:	0009811f 	andeq	r8, r9, pc, lsl r1
     99c:	1abe0700 	bne	fef825a4 <__bss_end+0xfef79468>
     9a0:	00000267 	andeq	r0, r0, r7, ror #4
     9a4:	20205000 	eorcs	r5, r0, r0
     9a8:	0006111f 	andeq	r1, r6, pc, lsl r1
     9ac:	1abf0700 	bne	fefc25b4 <__bss_end+0xfefb9478>
     9b0:	00000267 	andeq	r0, r0, r7, ror #4
     9b4:	20804000 	addcs	r4, r0, r0
     9b8:	000b821f 	andeq	r8, fp, pc, lsl r2
     9bc:	1ac00700 	bne	ff0025c4 <__bss_end+0xfeff9488>
     9c0:	00000267 	andeq	r0, r0, r7, ror #4
     9c4:	20805000 	addcs	r5, r0, r0
     9c8:	000b4a1f 	andeq	r4, fp, pc, lsl sl
     9cc:	1ace0700 	bne	ff3825d4 <__bss_end+0xff379498>
     9d0:	00000267 	andeq	r0, r0, r7, ror #4
     9d4:	20214000 	eorcs	r4, r1, r0
     9d8:	06472100 	strbeq	r2, [r7], -r0, lsl #2
     9dc:	57210000 	strpl	r0, [r1, -r0]!
     9e0:	21000006 	tstcs	r0, r6
     9e4:	00000667 	andeq	r0, r0, r7, ror #12
     9e8:	00067721 	andeq	r7, r6, r1, lsr #14
     9ec:	06842100 	streq	r2, [r4], r0, lsl #2
     9f0:	94210000 	strtls	r0, [r1], #-0
     9f4:	21000006 	tstcs	r0, r6
     9f8:	000006a4 	andeq	r0, r0, r4, lsr #13
     9fc:	0006b421 	andeq	fp, r6, r1, lsr #8
     a00:	06c42100 	strbeq	r2, [r4], r0, lsl #2
     a04:	d4210000 	strtle	r0, [r1], #-0
     a08:	21000006 	tstcs	r0, r6
     a0c:	000006e4 	andeq	r0, r0, r4, ror #13
     a10:	0006f421 	andeq	pc, r6, r1, lsr #8
     a14:	0abd0a00 	beq	fef4321c <__bss_end+0xfef3a0e0>
     a18:	08080000 	stmdaeq	r8, {}	; <UNPREDICTABLE>
     a1c:	00005414 	andeq	r5, r0, r4, lsl r4
     a20:	2c030500 	cfstr32cs	mvfx0, [r3], {-0}
     a24:	0a000090 	beq	c6c <shift+0xc6c>
     a28:	00000543 	andeq	r0, r0, r3, asr #10
     a2c:	54140809 	ldrpl	r0, [r4], #-2057	; 0xfffff7f7
     a30:	05000000 	streq	r0, [r0, #-0]
     a34:	00903003 	addseq	r3, r0, r3
     a38:	25040c00 	strcs	r0, [r4, #-3072]	; 0xfffff400
     a3c:	0a000000 	beq	a44 <shift+0xa44>
     a40:	00000c4a 	andeq	r0, r0, sl, asr #24
     a44:	54140f01 	ldrpl	r0, [r4], #-3841	; 0xfffff0ff
     a48:	05000000 	streq	r0, [r0, #-0]
     a4c:	00903403 	addseq	r3, r0, r3, lsl #8
     a50:	065e0a00 	ldrbeq	r0, [lr], -r0, lsl #20
     a54:	10010000 	andne	r0, r1, r0
     a58:	00005414 	andeq	r5, r0, r4, lsl r4
     a5c:	38030500 	stmdacc	r3, {r8, sl}
     a60:	22000090 	andcs	r0, r0, #144	; 0x90
     a64:	0064656c 	rsbeq	r6, r4, ip, ror #10
     a68:	480a1201 	stmdami	sl, {r0, r9, ip}
     a6c:	05000000 	streq	r0, [r0, #-0]
     a70:	00911803 	addseq	r1, r1, r3, lsl #16
     a74:	047c2300 	ldrbteq	r2, [ip], #-768	; 0xfffffd00
     a78:	12010000 	andne	r0, r1, #0
     a7c:	0000480f 	andeq	r4, r0, pc, lsl #16
     a80:	1c030500 	cfstr32ne	mvfx0, [r3], {-0}
     a84:	23000091 	movwcs	r0, #145	; 0x91
     a88:	00000c06 	andeq	r0, r0, r6, lsl #24
     a8c:	48151201 	ldmdami	r5, {r0, r9, ip}
     a90:	05000000 	streq	r0, [r0, #-0]
     a94:	00912003 	addseq	r2, r1, r3
     a98:	0ac92300 	beq	ff2496a0 <__bss_end+0xff240564>
     a9c:	12010000 	andne	r0, r1, #0
     aa0:	0000481b 	andeq	r4, r0, fp, lsl r8
     aa4:	24030500 	strcs	r0, [r3], #-1280	; 0xfffffb00
     aa8:	23000091 	movwcs	r0, #145	; 0x91
     aac:	0000074c 	andeq	r0, r0, ip, asr #14
     ab0:	48231201 	stmdami	r3!, {r0, r9, ip}
     ab4:	05000000 	streq	r0, [r0, #-0]
     ab8:	00912803 	addseq	r2, r1, r3, lsl #16
     abc:	0c0b2400 	cfstrseq	mvf2, [fp], {-0}
     ac0:	2e010000 	cdpcs	0, 0, cr0, cr1, cr0, {0}
     ac4:	00003305 	andeq	r3, r0, r5, lsl #6
     ac8:	00835800 	addeq	r5, r3, r0, lsl #16
     acc:	00015400 	andeq	r5, r1, r0, lsl #8
     ad0:	319c0100 	orrscc	r0, ip, r0, lsl #2
     ad4:	25000008 	strcs	r0, [r0, #-8]
     ad8:	00000995 	muleq	r0, r5, r9
     adc:	330e2e01 	movwcc	r2, #60929	; 0xee01
     ae0:	02000000 	andeq	r0, r0, #0
     ae4:	ac256c91 	stcge	12, cr6, [r5], #-580	; 0xfffffdbc
     ae8:	01000009 	tsteq	r0, r9
     aec:	08311b2e 	ldmdaeq	r1!, {r1, r2, r3, r5, r8, r9, fp, ip}
     af0:	91020000 	mrsls	r0, (UNDEF: 2)
     af4:	063e2668 	ldrteq	r2, [lr], -r8, ror #12
     af8:	30010000 	andcc	r0, r1, r0
     afc:	0008370a 	andeq	r3, r8, sl, lsl #14
     b00:	74910200 	ldrvc	r0, [r1], #512	; 0x200
     b04:	65040c00 	strvs	r0, [r4, #-3072]	; 0xfffff400
     b08:	0f000007 	svceq	0x00000007
     b0c:	00000025 	andeq	r0, r0, r5, lsr #32
     b10:	00000847 	andeq	r0, r0, r7, asr #16
     b14:	00005910 	andeq	r5, r0, r0, lsl r9
     b18:	27000300 	strcs	r0, [r0, -r0, lsl #6]
     b1c:	00000a22 	andeq	r0, r0, r2, lsr #20
     b20:	db062001 	blle	188b2c <__bss_end+0x17f9f0>
     b24:	bc000006 	stclt	0, cr0, [r0], {6}
     b28:	9c000082 	stcls	0, cr0, [r0], {130}	; 0x82
     b2c:	01000000 	mrseq	r0, (UNDEF: 0)
     b30:	00089e9c 	muleq	r8, ip, lr
     b34:	063e2600 	ldrteq	r2, [lr], -r0, lsl #12
     b38:	21010000 	mrscs	r0, (UNDEF: 1)
     b3c:	0008370a 	andeq	r3, r8, sl, lsl #14
     b40:	64910200 	ldrvs	r0, [r1], #512	; 0x200
     b44:	00063926 	andeq	r3, r6, r6, lsr #18
     b48:	13210100 			; <UNDEFINED> instruction: 0x13210100
     b4c:	0000089e 	muleq	r0, lr, r8
     b50:	26449102 	strbcs	r9, [r4], -r2, lsl #2
     b54:	00000a78 	andeq	r0, r0, r8, ror sl
     b58:	ae0f2201 	cdpge	2, 0, cr2, cr15, cr1, {0}
     b5c:	02000008 	andeq	r0, r0, #8
     b60:	2c266c91 	stccs	12, cr6, [r6], #-580	; 0xfffffdbc
     b64:	01000009 	tsteq	r0, r9
     b68:	00330923 	eorseq	r0, r3, r3, lsr #18
     b6c:	91020000 	mrsls	r0, (UNDEF: 2)
     b70:	250f0068 	strcs	r0, [pc, #-104]	; b10 <shift+0xb10>
     b74:	ae000000 	cdpge	0, 0, cr0, cr0, cr0, {0}
     b78:	10000008 	andne	r0, r0, r8
     b7c:	00000059 	andeq	r0, r0, r9, asr r0
     b80:	040c001f 	streq	r0, [ip], #-31	; 0xffffffe1
     b84:	00000048 	andeq	r0, r0, r8, asr #32
     b88:	00078a27 	andeq	r8, r7, r7, lsr #20
     b8c:	061b0100 	ldreq	r0, [fp], -r0, lsl #2
     b90:	000006f0 	strdeq	r0, [r0], -r0	; <UNPREDICTABLE>
     b94:	00008284 	andeq	r8, r0, r4, lsl #5
     b98:	00000038 	andeq	r0, r0, r8, lsr r0
     b9c:	08de9c01 	ldmeq	lr, {r0, sl, fp, ip, pc}^
     ba0:	3e250000 	cdpcc	0, 2, cr0, cr5, cr0, {0}
     ba4:	01000006 	tsteq	r0, r6
     ba8:	0765171b 			; <UNDEFINED> instruction: 0x0765171b
     bac:	91020000 	mrsls	r0, (UNDEF: 2)
     bb0:	0e280074 	mcreq	0, 1, r0, cr8, cr4, {3}
     bb4:	01000008 	tsteq	r0, r8
     bb8:	098b0614 	stmibeq	fp, {r2, r4, r9, sl}
     bbc:	822c0000 	eorhi	r0, ip, #0
     bc0:	00580000 	subseq	r0, r8, r0
     bc4:	9c010000 	stcls	0, cr0, [r1], {-0}
     bc8:	000b1f00 	andeq	r1, fp, r0, lsl #30
     bcc:	62000400 	andvs	r0, r0, #0, 8
     bd0:	04000004 	streq	r0, [r0], #-4
     bd4:	000fec01 	andeq	lr, pc, r1, lsl #24
     bd8:	0ec50400 	cdpeq	4, 12, cr0, cr5, cr0, {0}
     bdc:	0cb40000 	ldceq	0, cr0, [r4]
     be0:	84ac0000 	strthi	r0, [ip], #0
     be4:	045c0000 	ldrbeq	r0, [ip], #-0
     be8:	055b0000 	ldrbeq	r0, [fp, #-0]
     bec:	01020000 	mrseq	r0, (UNDEF: 2)
     bf0:	000b4508 	andeq	r4, fp, r8, lsl #10
     bf4:	00250300 	eoreq	r0, r5, r0, lsl #6
     bf8:	02020000 	andeq	r0, r2, #0
     bfc:	0009f505 	andeq	pc, r9, r5, lsl #10
     c00:	05040400 	streq	r0, [r4, #-1024]	; 0xfffffc00
     c04:	00746e69 	rsbseq	r6, r4, r9, ror #28
     c08:	3c080102 	stfccs	f0, [r8], {2}
     c0c:	0200000b 	andeq	r0, r0, #11
     c10:	0bf30702 	bleq	ffcc2820 <__bss_end+0xffcb96e4>
     c14:	08050000 	stmdaeq	r5, {}	; <UNPREDICTABLE>
     c18:	07000006 	streq	r0, [r0, -r6]
     c1c:	005e0709 	subseq	r0, lr, r9, lsl #14
     c20:	4d030000 	stcmi	0, cr0, [r3, #-0]
     c24:	02000000 	andeq	r0, r0, #0
     c28:	0ab00704 	beq	fec02840 <__bss_end+0xfebf9704>
     c2c:	a8060000 	stmdage	r6, {}	; <UNPREDICTABLE>
     c30:	0800000c 	stmdaeq	r0, {r2, r3}
     c34:	8b080602 	blhi	202444 <__bss_end+0x1f9308>
     c38:	07000000 	streq	r0, [r0, -r0]
     c3c:	02003072 	andeq	r3, r0, #114	; 0x72
     c40:	004d0e08 	subeq	r0, sp, r8, lsl #28
     c44:	07000000 	streq	r0, [r0, -r0]
     c48:	02003172 	andeq	r3, r0, #-2147483620	; 0x8000001c
     c4c:	004d0e09 	subeq	r0, sp, r9, lsl #28
     c50:	00040000 	andeq	r0, r4, r0
     c54:	000f7608 	andeq	r7, pc, r8, lsl #12
     c58:	38040500 	stmdacc	r4, {r8, sl}
     c5c:	02000000 	andeq	r0, r0, #0
     c60:	00a90c0d 	adceq	r0, r9, sp, lsl #24
     c64:	4f090000 	svcmi	0x00090000
     c68:	0a00004b 	beq	d9c <shift+0xd9c>
     c6c:	00000d62 	andeq	r0, r0, r2, ror #26
     c70:	50080001 	andpl	r0, r8, r1
     c74:	0500000a 	streq	r0, [r0, #-10]
     c78:	00003804 	andeq	r3, r0, r4, lsl #16
     c7c:	0c1e0200 	lfmeq	f0, 4, [lr], {-0}
     c80:	000000e0 	andeq	r0, r0, r0, ror #1
     c84:	0006000a 	andeq	r0, r6, sl
     c88:	570a0000 	strpl	r0, [sl, -r0]
     c8c:	01000007 	tsteq	r0, r7
     c90:	000a720a 	andeq	r7, sl, sl, lsl #4
     c94:	670a0200 	strvs	r0, [sl, -r0, lsl #4]
     c98:	0300000b 	movweq	r0, #11
     c9c:	0007370a 	andeq	r3, r7, sl, lsl #14
     ca0:	ec0a0400 	cfstrs	mvf0, [sl], {-0}
     ca4:	05000009 	streq	r0, [r0, #-9]
     ca8:	0a380800 	beq	e02cb0 <__bss_end+0xdf9b74>
     cac:	04050000 	streq	r0, [r5], #-0
     cb0:	00000038 	andeq	r0, r0, r8, lsr r0
     cb4:	1d0c3f02 	stcne	15, cr3, [ip, #-8]
     cb8:	0a000001 	beq	cc4 <shift+0xcc4>
     cbc:	000006cb 	andeq	r0, r0, fp, asr #13
     cc0:	07520a00 	ldrbeq	r0, [r2, -r0, lsl #20]
     cc4:	0a010000 	beq	40ccc <__bss_end+0x37b90>
     cc8:	00000c2f 	andeq	r0, r0, pc, lsr #24
     ccc:	09550a02 	ldmdbeq	r5, {r1, r9, fp}^
     cd0:	0a030000 	beq	c0cd8 <__bss_end+0xb7b9c>
     cd4:	00000746 	andeq	r0, r0, r6, asr #14
     cd8:	07950a04 	ldreq	r0, [r5, r4, lsl #20]
     cdc:	0a050000 	beq	140ce4 <__bss_end+0x137ba8>
     ce0:	0000061b 	andeq	r0, r0, fp, lsl r6
     ce4:	9d080006 	stcls	0, cr0, [r8, #-24]	; 0xffffffe8
     ce8:	05000010 	streq	r0, [r0, #-16]
     cec:	00003804 	andeq	r3, r0, r4, lsl #16
     cf0:	0c660200 	sfmeq	f0, 2, [r6], #-0
     cf4:	00000148 	andeq	r0, r0, r8, asr #2
     cf8:	000eba0a 	andeq	fp, lr, sl, lsl #20
     cfc:	bf0a0000 	svclt	0x000a0000
     d00:	0100000d 	tsteq	r0, sp
     d04:	000f3f0a 	andeq	r3, pc, sl, lsl #30
     d08:	e40a0200 	str	r0, [sl], #-512	; 0xfffffe00
     d0c:	0300000d 	movweq	r0, #13
     d10:	09330b00 	ldmdbeq	r3!, {r8, r9, fp}
     d14:	05030000 	streq	r0, [r3, #-0]
     d18:	00005914 	andeq	r5, r0, r4, lsl r9
     d1c:	cc030500 	cfstr32gt	mvfx0, [r3], {-0}
     d20:	0b000090 	bleq	f68 <shift+0xf68>
     d24:	00000ad0 	ldrdeq	r0, [r0], -r0	; <UNPREDICTABLE>
     d28:	59140603 	ldmdbpl	r4, {r0, r1, r9, sl}
     d2c:	05000000 	streq	r0, [r0, #-0]
     d30:	0090d003 	addseq	sp, r0, r3
     d34:	07aa0b00 	streq	r0, [sl, r0, lsl #22]!
     d38:	07040000 	streq	r0, [r4, -r0]
     d3c:	0000591a 	andeq	r5, r0, sl, lsl r9
     d40:	d4030500 	strle	r0, [r3], #-1280	; 0xfffffb00
     d44:	0b000090 	bleq	f8c <shift+0xf8c>
     d48:	000009ff 	strdeq	r0, [r0], -pc	; <UNPREDICTABLE>
     d4c:	591a0904 	ldmdbpl	sl, {r2, r8, fp}
     d50:	05000000 	streq	r0, [r0, #-0]
     d54:	0090d803 	addseq	sp, r0, r3, lsl #16
     d58:	079c0b00 	ldreq	r0, [ip, r0, lsl #22]
     d5c:	0b040000 	bleq	100d64 <__bss_end+0xf7c28>
     d60:	0000591a 	andeq	r5, r0, sl, lsl r9
     d64:	dc030500 	cfstr32le	mvfx0, [r3], {-0}
     d68:	0b000090 	bleq	fb0 <shift+0xfb0>
     d6c:	000009d9 	ldrdeq	r0, [r0], -r9
     d70:	591a0d04 	ldmdbpl	sl, {r2, r8, sl, fp}
     d74:	05000000 	streq	r0, [r0, #-0]
     d78:	0090e003 	addseq	lr, r0, r3
     d7c:	05e00b00 	strbeq	r0, [r0, #2816]!	; 0xb00
     d80:	0f040000 	svceq	0x00040000
     d84:	0000591a 	andeq	r5, r0, sl, lsl r9
     d88:	e4030500 	str	r0, [r3], #-1280	; 0xfffffb00
     d8c:	08000090 	stmdaeq	r0, {r4, r7}
     d90:	000010f0 	strdeq	r1, [r0], -r0
     d94:	00380405 	eorseq	r0, r8, r5, lsl #8
     d98:	1b040000 	blne	100da0 <__bss_end+0xf7c64>
     d9c:	0001eb0c 	andeq	lr, r1, ip, lsl #22
     da0:	058f0a00 	streq	r0, [pc, #2560]	; 17a8 <shift+0x17a8>
     da4:	0a000000 	beq	dac <shift+0xdac>
     da8:	00000b92 	muleq	r0, r2, fp
     dac:	0c2a0a01 			; <UNDEFINED> instruction: 0x0c2a0a01
     db0:	00020000 	andeq	r0, r2, r0
     db4:	0004590c 	andeq	r5, r4, ip, lsl #18
     db8:	02010200 	andeq	r0, r1, #0, 4
     dbc:	00000814 	andeq	r0, r0, r4, lsl r8
     dc0:	002c040d 	eoreq	r0, ip, sp, lsl #8
     dc4:	040d0000 	streq	r0, [sp], #-0
     dc8:	000001eb 	andeq	r0, r0, fp, ror #3
     dcc:	0005990b 	andeq	r9, r5, fp, lsl #18
     dd0:	14040500 	strne	r0, [r4], #-1280	; 0xfffffb00
     dd4:	00000059 	andeq	r0, r0, r9, asr r0
     dd8:	90e80305 	rscls	r0, r8, r5, lsl #6
     ddc:	7d0b0000 	stcvc	0, cr0, [fp, #-0]
     de0:	0500000a 	streq	r0, [r0, #-10]
     de4:	00591407 	subseq	r1, r9, r7, lsl #8
     de8:	03050000 	movweq	r0, #20480	; 0x5000
     dec:	000090ec 	andeq	r9, r0, ip, ror #1
     df0:	0004e70b 	andeq	lr, r4, fp, lsl #14
     df4:	140a0500 	strne	r0, [sl], #-1280	; 0xfffffb00
     df8:	00000059 	andeq	r0, r0, r9, asr r0
     dfc:	90f00305 	rscsls	r0, r0, r5, lsl #6
     e00:	20080000 	andcs	r0, r8, r0
     e04:	05000006 	streq	r0, [r0, #-6]
     e08:	00003804 	andeq	r3, r0, r4, lsl #16
     e0c:	0c0d0500 	cfstr32eq	mvfx0, [sp], {-0}
     e10:	00000270 	andeq	r0, r0, r0, ror r2
     e14:	77654e09 	strbvc	r4, [r5, -r9, lsl #28]!
     e18:	c70a0000 	strgt	r0, [sl, -r0]
     e1c:	01000004 	tsteq	r0, r4
     e20:	0004df0a 	andeq	sp, r4, sl, lsl #30
     e24:	430a0200 	movwmi	r0, #41472	; 0xa200
     e28:	03000006 	movweq	r0, #6
     e2c:	000b590a 	andeq	r5, fp, sl, lsl #18
     e30:	bb0a0400 	bllt	281e38 <__bss_end+0x278cfc>
     e34:	05000004 	streq	r0, [r0, #-4]
     e38:	05b20600 	ldreq	r0, [r2, #1536]!	; 0x600
     e3c:	05100000 	ldreq	r0, [r0, #-0]
     e40:	02af081b 	adceq	r0, pc, #1769472	; 0x1b0000
     e44:	6c070000 	stcvs	0, cr0, [r7], {-0}
     e48:	1d050072 	stcne	0, cr0, [r5, #-456]	; 0xfffffe38
     e4c:	0002af13 	andeq	sl, r2, r3, lsl pc
     e50:	73070000 	movwvc	r0, #28672	; 0x7000
     e54:	1e050070 	mcrne	0, 0, r0, cr5, cr0, {3}
     e58:	0002af13 	andeq	sl, r2, r3, lsl pc
     e5c:	70070400 	andvc	r0, r7, r0, lsl #8
     e60:	1f050063 	svcne	0x00050063
     e64:	0002af13 	andeq	sl, r2, r3, lsl pc
     e68:	320e0800 	andcc	r0, lr, #0, 16
     e6c:	0500000a 	streq	r0, [r0, #-10]
     e70:	02af1320 	adceq	r1, pc, #32, 6	; 0x80000000
     e74:	000c0000 	andeq	r0, ip, r0
     e78:	ab070402 	blge	1c1e88 <__bss_end+0x1b8d4c>
     e7c:	0600000a 	streq	r0, [r0], -sl
     e80:	0000072a 	andeq	r0, r0, sl, lsr #14
     e84:	08280570 	stmdaeq	r8!, {r4, r5, r6, r8, sl}
     e88:	00000346 	andeq	r0, r0, r6, asr #6
     e8c:	0006b00e 	andeq	fp, r6, lr
     e90:	122a0500 	eorne	r0, sl, #0, 10
     e94:	00000270 	andeq	r0, r0, r0, ror r2
     e98:	69700700 	ldmdbvs	r0!, {r8, r9, sl}^
     e9c:	2b050064 	blcs	141034 <__bss_end+0x137ef8>
     ea0:	00005e12 	andeq	r5, r0, r2, lsl lr
     ea4:	8c0e1000 	stchi	0, cr1, [lr], {-0}
     ea8:	0500000b 	streq	r0, [r0, #-11]
     eac:	0239112c 	eorseq	r1, r9, #44, 2
     eb0:	0e140000 	cdpeq	0, 1, cr0, cr4, cr0, {0}
     eb4:	00000b2e 	andeq	r0, r0, lr, lsr #22
     eb8:	5e122d05 	cdppl	13, 1, cr2, cr2, cr5, {0}
     ebc:	18000000 	stmdane	r0, {}	; <UNPREDICTABLE>
     ec0:	0003e90e 	andeq	lr, r3, lr, lsl #18
     ec4:	122e0500 	eorne	r0, lr, #0, 10
     ec8:	0000005e 	andeq	r0, r0, lr, asr r0
     ecc:	0a650e1c 	beq	1944744 <__bss_end+0x193b608>
     ed0:	2f050000 	svccs	0x00050000
     ed4:	0003460c 	andeq	r4, r3, ip, lsl #12
     ed8:	720e2000 	andvc	r2, lr, #0
     edc:	05000004 	streq	r0, [r0, #-4]
     ee0:	00380930 	eorseq	r0, r8, r0, lsr r9
     ee4:	0e600000 	cdpeq	0, 6, cr0, cr0, cr0, {0}
     ee8:	0000066e 	andeq	r0, r0, lr, ror #12
     eec:	4d0e3105 	stfmis	f3, [lr, #-20]	; 0xffffffec
     ef0:	64000000 	strvs	r0, [r0], #-0
     ef4:	0009a30e 	andeq	sl, r9, lr, lsl #6
     ef8:	0e330500 	cfabs32eq	mvfx0, mvfx3
     efc:	0000004d 	andeq	r0, r0, sp, asr #32
     f00:	099a0e68 	ldmibeq	sl, {r3, r5, r6, r9, sl, fp}
     f04:	34050000 	strcc	r0, [r5], #-0
     f08:	00004d0e 	andeq	r4, r0, lr, lsl #26
     f0c:	0f006c00 	svceq	0x00006c00
     f10:	000001fd 	strdeq	r0, [r0], -sp
     f14:	00000356 	andeq	r0, r0, r6, asr r3
     f18:	00005e10 	andeq	r5, r0, r0, lsl lr
     f1c:	0b000f00 	bleq	4b24 <shift+0x4b24>
     f20:	000004d0 	ldrdeq	r0, [r0], -r0	; <UNPREDICTABLE>
     f24:	59140a06 	ldmdbpl	r4, {r1, r2, r9, fp}
     f28:	05000000 	streq	r0, [r0, #-0]
     f2c:	0090f403 	addseq	pc, r0, r3, lsl #8
     f30:	07e50800 	strbeq	r0, [r5, r0, lsl #16]!
     f34:	04050000 	streq	r0, [r5], #-0
     f38:	00000038 	andeq	r0, r0, r8, lsr r0
     f3c:	870c0d06 	strhi	r0, [ip, -r6, lsl #26]
     f40:	0a000003 	beq	f54 <shift+0xf54>
     f44:	00000c35 	andeq	r0, r0, r5, lsr ip
     f48:	0ba60a00 	bleq	fe983750 <__bss_end+0xfe97a614>
     f4c:	00010000 	andeq	r0, r1, r0
     f50:	00036803 	andeq	r6, r3, r3, lsl #16
     f54:	0e4c0800 	cdpeq	8, 4, cr0, cr12, cr0, {0}
     f58:	04050000 	streq	r0, [r5], #-0
     f5c:	00000038 	andeq	r0, r0, r8, lsr r0
     f60:	ab0c1406 	blge	305f80 <__bss_end+0x2fce44>
     f64:	0a000003 	beq	f78 <shift+0xf78>
     f68:	00000d05 	andeq	r0, r0, r5, lsl #26
     f6c:	0f310a00 	svceq	0x00310a00
     f70:	00010000 	andeq	r0, r1, r0
     f74:	00038c03 	andeq	r8, r3, r3, lsl #24
     f78:	069d0600 	ldreq	r0, [sp], r0, lsl #12
     f7c:	060c0000 	streq	r0, [ip], -r0
     f80:	03e5081b 	mvneq	r0, #1769472	; 0x1b0000
     f84:	5c0e0000 	stcpl	0, cr0, [lr], {-0}
     f88:	06000005 	streq	r0, [r0], -r5
     f8c:	03e5191d 	mvneq	r1, #475136	; 0x74000
     f90:	0e000000 	cdpeq	0, 0, cr0, cr0, cr0, {0}
     f94:	000004c2 	andeq	r0, r0, r2, asr #9
     f98:	e5191e06 	ldr	r1, [r9, #-3590]	; 0xfffff1fa
     f9c:	04000003 	streq	r0, [r0], #-3
     fa0:	0008090e 	andeq	r0, r8, lr, lsl #18
     fa4:	131f0600 	tstne	pc, #0, 12
     fa8:	000003eb 	andeq	r0, r0, fp, ror #7
     fac:	040d0008 	streq	r0, [sp], #-8
     fb0:	000003b0 			; <UNDEFINED> instruction: 0x000003b0
     fb4:	02b6040d 	adcseq	r0, r6, #218103808	; 0xd000000
     fb8:	11110000 	tstne	r1, r0
     fbc:	1400000a 	strne	r0, [r0], #-10
     fc0:	73072206 	movwvc	r2, #29190	; 0x7206
     fc4:	0e000006 	cdpeq	0, 0, cr0, cr0, cr6, {0}
     fc8:	00000941 	andeq	r0, r0, r1, asr #18
     fcc:	4d122606 	ldcmi	6, cr2, [r2, #-24]	; 0xffffffe8
     fd0:	00000000 	andeq	r0, r0, r0
     fd4:	0008dc0e 	andeq	sp, r8, lr, lsl #24
     fd8:	1d290600 	stcne	6, cr0, [r9, #-0]
     fdc:	000003e5 	andeq	r0, r0, r5, ror #7
     fe0:	064b0e04 	strbeq	r0, [fp], -r4, lsl #28
     fe4:	2c060000 	stccs	0, cr0, [r6], {-0}
     fe8:	0003e51d 	andeq	lr, r3, sp, lsl r5
     fec:	4b120800 	blmi	482ff4 <__bss_end+0x479eb8>
     ff0:	06000009 	streq	r0, [r0], -r9
     ff4:	067a0e2f 	ldrbteq	r0, [sl], -pc, lsr #28
     ff8:	04390000 	ldrteq	r0, [r9], #-0
     ffc:	04440000 	strbeq	r0, [r4], #-0
    1000:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
    1004:	14000006 	strne	r0, [r0], #-6
    1008:	000003e5 	andeq	r0, r0, r5, ror #7
    100c:	07611500 	strbeq	r1, [r1, -r0, lsl #10]!
    1010:	31060000 	mrscc	r0, (UNDEF: 6)
    1014:	0007010e 	andeq	r0, r7, lr, lsl #2
    1018:	0001f000 	andeq	pc, r1, r0
    101c:	00045c00 	andeq	r5, r4, r0, lsl #24
    1020:	00046700 	andeq	r6, r4, r0, lsl #14
    1024:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
    1028:	eb140000 	bl	501030 <__bss_end+0x4f7ef4>
    102c:	00000003 	andeq	r0, r0, r3
    1030:	000b6d16 	andeq	r6, fp, r6, lsl sp
    1034:	1d350600 	ldcne	6, cr0, [r5, #-0]
    1038:	000007c0 	andeq	r0, r0, r0, asr #15
    103c:	000003e5 	andeq	r0, r0, r5, ror #7
    1040:	00048002 	andeq	r8, r4, r2
    1044:	00048600 	andeq	r8, r4, r0, lsl #12
    1048:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
    104c:	16000000 	strne	r0, [r0], -r0
    1050:	0000062c 	andeq	r0, r0, ip, lsr #12
    1054:	5b1d3706 	blpl	74ec74 <__bss_end+0x745b38>
    1058:	e5000009 	str	r0, [r0, #-9]
    105c:	02000003 	andeq	r0, r0, #3
    1060:	0000049f 	muleq	r0, pc, r4	; <UNPREDICTABLE>
    1064:	000004a5 	andeq	r0, r0, r5, lsr #9
    1068:	00067813 	andeq	r7, r6, r3, lsl r8
    106c:	ef170000 	svc	0x00170000
    1070:	06000008 	streq	r0, [r0], -r8
    1074:	06913139 			; <UNDEFINED> instruction: 0x06913139
    1078:	020c0000 	andeq	r0, ip, #0
    107c:	000a1116 	andeq	r1, sl, r6, lsl r1
    1080:	093c0600 	ldmdbeq	ip!, {r9, sl}
    1084:	00000770 	andeq	r0, r0, r0, ror r7
    1088:	00000678 	andeq	r0, r0, r8, ror r6
    108c:	0004cc01 	andeq	ip, r4, r1, lsl #24
    1090:	0004d200 	andeq	sp, r4, r0, lsl #4
    1094:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
    1098:	16000000 	strne	r0, [r0], -r0
    109c:	000006bc 			; <UNDEFINED> instruction: 0x000006bc
    10a0:	18123f06 	ldmdane	r2, {r1, r2, r8, r9, sl, fp, ip, sp}
    10a4:	4d000005 	stcmi	0, cr0, [r0, #-20]	; 0xffffffec
    10a8:	01000000 	mrseq	r0, (UNDEF: 0)
    10ac:	000004eb 	andeq	r0, r0, fp, ror #9
    10b0:	00000500 	andeq	r0, r0, r0, lsl #10
    10b4:	00067813 	andeq	r7, r6, r3, lsl r8
    10b8:	069a1400 	ldreq	r1, [sl], r0, lsl #8
    10bc:	5e140000 	cdppl	0, 1, cr0, cr4, cr0, {0}
    10c0:	14000000 	strne	r0, [r0], #-0
    10c4:	000001f0 	strdeq	r0, [r0], -r0	; <UNPREDICTABLE>
    10c8:	0b9d1800 	bleq	fe7470d0 <__bss_end+0xfe73df94>
    10cc:	42060000 	andmi	r0, r6, #0
    10d0:	0005bf0e 	andeq	fp, r5, lr, lsl #30
    10d4:	05150100 	ldreq	r0, [r5, #-256]	; 0xffffff00
    10d8:	051b0000 	ldreq	r0, [fp, #-0]
    10dc:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
    10e0:	00000006 	andeq	r0, r0, r6
    10e4:	0004fa16 	andeq	pc, r4, r6, lsl sl	; <UNPREDICTABLE>
    10e8:	17450600 	strbne	r0, [r5, -r0, lsl #12]
    10ec:	00000561 	andeq	r0, r0, r1, ror #10
    10f0:	000003eb 	andeq	r0, r0, fp, ror #7
    10f4:	00053401 	andeq	r3, r5, r1, lsl #8
    10f8:	00053a00 	andeq	r3, r5, r0, lsl #20
    10fc:	06a01300 	strteq	r1, [r0], r0, lsl #6
    1100:	16000000 	strne	r0, [r0], -r0
    1104:	00000a88 	andeq	r0, r0, r8, lsl #21
    1108:	ff174806 			; <UNDEFINED> instruction: 0xff174806
    110c:	eb000003 	bl	1120 <shift+0x1120>
    1110:	01000003 	tsteq	r0, r3
    1114:	00000553 	andeq	r0, r0, r3, asr r5
    1118:	0000055e 	andeq	r0, r0, lr, asr r5
    111c:	0006a013 	andeq	sl, r6, r3, lsl r0
    1120:	004d1400 	subeq	r1, sp, r0, lsl #8
    1124:	18000000 	stmdane	r0, {}	; <UNPREDICTABLE>
    1128:	000005ea 	andeq	r0, r0, sl, ror #11
    112c:	fd0e4b06 	stc2	11, cr4, [lr, #-24]	; 0xffffffe8	; <UNPREDICTABLE>
    1130:	01000008 	tsteq	r0, r8
    1134:	00000573 	andeq	r0, r0, r3, ror r5
    1138:	00000579 	andeq	r0, r0, r9, ror r5
    113c:	00067813 	andeq	r7, r6, r3, lsl r8
    1140:	61160000 	tstvs	r6, r0
    1144:	06000007 	streq	r0, [r0], -r7
    1148:	09b10e4d 	ldmibeq	r1!, {r0, r2, r3, r6, r9, sl, fp}
    114c:	01f00000 	mvnseq	r0, r0
    1150:	92010000 	andls	r0, r1, #0
    1154:	9d000005 	stcls	0, cr0, [r0, #-20]	; 0xffffffec
    1158:	13000005 	movwne	r0, #5
    115c:	00000678 	andeq	r0, r0, r8, ror r6
    1160:	00004d14 	andeq	r4, r0, r4, lsl sp
    1164:	a7160000 	ldrge	r0, [r6, -r0]
    1168:	06000004 	streq	r0, [r0], -r4
    116c:	042c1250 	strteq	r1, [ip], #-592	; 0xfffffdb0
    1170:	004d0000 	subeq	r0, sp, r0
    1174:	b6010000 	strlt	r0, [r1], -r0
    1178:	c1000005 	tstgt	r0, r5
    117c:	13000005 	movwne	r0, #5
    1180:	00000678 	andeq	r0, r0, r8, ror r6
    1184:	0001fd14 	andeq	pc, r1, r4, lsl sp	; <UNPREDICTABLE>
    1188:	5f160000 	svcpl	0x00160000
    118c:	06000004 	streq	r0, [r0], -r4
    1190:	0bb10e53 	bleq	fec44ae4 <__bss_end+0xfec3b9a8>
    1194:	01f00000 	mvnseq	r0, r0
    1198:	da010000 	ble	411a0 <__bss_end+0x38064>
    119c:	e5000005 	str	r0, [r0, #-5]
    11a0:	13000005 	movwne	r0, #5
    11a4:	00000678 	andeq	r0, r0, r8, ror r6
    11a8:	00004d14 	andeq	r4, r0, r4, lsl sp
    11ac:	81180000 	tsthi	r8, r0
    11b0:	06000004 	streq	r0, [r0], -r4
    11b4:	0adc0e56 	beq	ff704b14 <__bss_end+0xff6fb9d8>
    11b8:	fa010000 	blx	411c0 <__bss_end+0x38084>
    11bc:	19000005 	stmdbne	r0, {r0, r2}
    11c0:	13000006 	movwne	r0, #6
    11c4:	00000678 	andeq	r0, r0, r8, ror r6
    11c8:	0000a914 	andeq	sl, r0, r4, lsl r9
    11cc:	004d1400 	subeq	r1, sp, r0, lsl #8
    11d0:	4d140000 	ldcmi	0, cr0, [r4, #-0]
    11d4:	14000000 	strne	r0, [r0], #-0
    11d8:	0000004d 	andeq	r0, r0, sp, asr #32
    11dc:	0006a614 	andeq	sl, r6, r4, lsl r6
    11e0:	dd180000 	ldcle	0, cr0, [r8, #-0]
    11e4:	0600000b 	streq	r0, [r0], -fp
    11e8:	0c5c0e58 	mrrceq	14, 5, r0, ip, cr8
    11ec:	2e010000 	cdpcs	0, 0, cr0, cr1, cr0, {0}
    11f0:	4d000006 	stcmi	0, cr0, [r0, #-24]	; 0xffffffe8
    11f4:	13000006 	movwne	r0, #6
    11f8:	00000678 	andeq	r0, r0, r8, ror r6
    11fc:	0000e014 	andeq	lr, r0, r4, lsl r0
    1200:	004d1400 	subeq	r1, sp, r0, lsl #8
    1204:	4d140000 	ldcmi	0, cr0, [r4, #-0]
    1208:	14000000 	strne	r0, [r0], #-0
    120c:	0000004d 	andeq	r0, r0, sp, asr #32
    1210:	0006a614 	andeq	sl, r6, r4, lsl r6
    1214:	94190000 	ldrls	r0, [r9], #-0
    1218:	06000004 	streq	r0, [r0], -r4
    121c:	08190e5b 	ldmdaeq	r9, {r0, r1, r3, r4, r6, r9, sl, fp}
    1220:	01f00000 	mvnseq	r0, r0
    1224:	62010000 	andvs	r0, r1, #0
    1228:	13000006 	movwne	r0, #6
    122c:	00000678 	andeq	r0, r0, r8, ror r6
    1230:	00036814 	andeq	r6, r3, r4, lsl r8
    1234:	06ac1400 	strteq	r1, [ip], r0, lsl #8
    1238:	00000000 	andeq	r0, r0, r0
    123c:	0003f103 	andeq	pc, r3, r3, lsl #2
    1240:	f1040d00 			; <UNDEFINED> instruction: 0xf1040d00
    1244:	1a000003 	bne	1258 <shift+0x1258>
    1248:	000003e5 	andeq	r0, r0, r5, ror #7
    124c:	0000068b 	andeq	r0, r0, fp, lsl #13
    1250:	00000691 	muleq	r0, r1, r6
    1254:	00067813 	andeq	r7, r6, r3, lsl r8
    1258:	f11b0000 			; <UNDEFINED> instruction: 0xf11b0000
    125c:	7e000003 	cdpvc	0, 0, cr0, cr0, cr3, {0}
    1260:	0d000006 	stceq	0, cr0, [r0, #-24]	; 0xffffffe8
    1264:	00003f04 	andeq	r3, r0, r4, lsl #30
    1268:	73040d00 	movwvc	r0, #19712	; 0x4d00
    126c:	1c000006 	stcne	0, cr0, [r0], {6}
    1270:	00006504 	andeq	r6, r0, r4, lsl #10
    1274:	0f041d00 	svceq	0x00041d00
    1278:	0000002c 	andeq	r0, r0, ip, lsr #32
    127c:	000006be 			; <UNDEFINED> instruction: 0x000006be
    1280:	00005e10 	andeq	r5, r0, r0, lsl lr
    1284:	03000900 	movweq	r0, #2304	; 0x900
    1288:	000006ae 	andeq	r0, r0, lr, lsr #13
    128c:	000dae1e 	andeq	sl, sp, lr, lsl lr
    1290:	0ca40100 	stfeqs	f0, [r4]
    1294:	000006be 			; <UNDEFINED> instruction: 0x000006be
    1298:	90f80305 	rscsls	r0, r8, r5, lsl #6
    129c:	1e1f0000 	cdpne	0, 1, cr0, cr15, cr0, {0}
    12a0:	0100000d 	tsteq	r0, sp
    12a4:	0e400aa6 	vmlaeq.f32	s1, s1, s13
    12a8:	004d0000 	subeq	r0, sp, r0
    12ac:	88580000 	ldmdahi	r8, {}^	; <UNPREDICTABLE>
    12b0:	00b00000 	adcseq	r0, r0, r0
    12b4:	9c010000 	stcls	0, cr0, [r1], {-0}
    12b8:	00000733 	andeq	r0, r0, r3, lsr r7
    12bc:	0010d320 	andseq	sp, r0, r0, lsr #6
    12c0:	1ba60100 	blne	fe9816c8 <__bss_end+0xfe97858c>
    12c4:	000001f7 	strdeq	r0, [r0], -r7
    12c8:	7fac9103 	svcvc	0x00ac9103
    12cc:	000e9f20 	andeq	r9, lr, r0, lsr #30
    12d0:	2aa60100 	bcs	fe9816d8 <__bss_end+0xfe97859c>
    12d4:	0000004d 	andeq	r0, r0, sp, asr #32
    12d8:	7fa89103 	svcvc	0x00a89103
    12dc:	000e291e 	andeq	r2, lr, lr, lsl r9
    12e0:	0aa80100 	beq	fea016e8 <__bss_end+0xfe9f85ac>
    12e4:	00000733 	andeq	r0, r0, r3, lsr r7
    12e8:	7fb49103 	svcvc	0x00b49103
    12ec:	000d191e 	andeq	r1, sp, lr, lsl r9
    12f0:	09ac0100 	stmibeq	ip!, {r8}
    12f4:	00000038 	andeq	r0, r0, r8, lsr r0
    12f8:	00749102 	rsbseq	r9, r4, r2, lsl #2
    12fc:	0000250f 	andeq	r2, r0, pc, lsl #10
    1300:	00074300 	andeq	r4, r7, r0, lsl #6
    1304:	005e1000 	subseq	r1, lr, r0
    1308:	003f0000 	eorseq	r0, pc, r0
    130c:	000e8421 	andeq	r8, lr, r1, lsr #8
    1310:	0a980100 	beq	fe601718 <__bss_end+0xfe5f85dc>
    1314:	00000f56 	andeq	r0, r0, r6, asr pc
    1318:	0000004d 	andeq	r0, r0, sp, asr #32
    131c:	0000881c 	andeq	r8, r0, ip, lsl r8
    1320:	0000003c 	andeq	r0, r0, ip, lsr r0
    1324:	07809c01 	streq	r9, [r0, r1, lsl #24]
    1328:	72220000 	eorvc	r0, r2, #0
    132c:	01007165 	tsteq	r0, r5, ror #2
    1330:	03ab209a 			; <UNDEFINED> instruction: 0x03ab209a
    1334:	91020000 	mrsls	r0, (UNDEF: 2)
    1338:	0e351e74 	mrceq	14, 1, r1, cr5, cr4, {3}
    133c:	9b010000 	blls	41344 <__bss_end+0x38208>
    1340:	00004d0e 	andeq	r4, r0, lr, lsl #26
    1344:	70910200 	addsvc	r0, r1, r0, lsl #4
    1348:	0ea82300 	cdpeq	3, 10, cr2, cr8, cr0, {0}
    134c:	8f010000 	svchi	0x00010000
    1350:	000d3a06 	andeq	r3, sp, r6, lsl #20
    1354:	0087e000 	addeq	lr, r7, r0
    1358:	00003c00 	andeq	r3, r0, r0, lsl #24
    135c:	b99c0100 	ldmiblt	ip, {r8}
    1360:	20000007 	andcs	r0, r0, r7
    1364:	00000d7c 	andeq	r0, r0, ip, ror sp
    1368:	4d218f01 	stcmi	15, cr8, [r1, #-4]!
    136c:	02000000 	andeq	r0, r0, #0
    1370:	72226c91 	eorvc	r6, r2, #37120	; 0x9100
    1374:	01007165 	tsteq	r0, r5, ror #2
    1378:	03ab2091 			; <UNDEFINED> instruction: 0x03ab2091
    137c:	91020000 	mrsls	r0, (UNDEF: 2)
    1380:	61210074 			; <UNDEFINED> instruction: 0x61210074
    1384:	0100000e 	tsteq	r0, lr
    1388:	0dca0a83 	vstreq	s1, [sl, #524]	; 0x20c
    138c:	004d0000 	subeq	r0, sp, r0
    1390:	87a40000 	strhi	r0, [r4, r0]!
    1394:	003c0000 	eorseq	r0, ip, r0
    1398:	9c010000 	stcls	0, cr0, [r1], {-0}
    139c:	000007f6 	strdeq	r0, [r0], -r6
    13a0:	71657222 	cmnvc	r5, r2, lsr #4
    13a4:	20850100 	addcs	r0, r5, r0, lsl #2
    13a8:	00000387 	andeq	r0, r0, r7, lsl #7
    13ac:	1e749102 	expnes	f1, f2
    13b0:	00000d12 	andeq	r0, r0, r2, lsl sp
    13b4:	4d0e8601 	stcmi	6, cr8, [lr, #-4]
    13b8:	02000000 	andeq	r0, r0, #0
    13bc:	21007091 	swpcs	r7, r1, [r0]
    13c0:	000010b6 	strheq	r1, [r0], -r6
    13c4:	900a7701 	andls	r7, sl, r1, lsl #14
    13c8:	4d00000d 	stcmi	0, cr0, [r0, #-52]	; 0xffffffcc
    13cc:	68000000 	stmdavs	r0, {}	; <UNPREDICTABLE>
    13d0:	3c000087 	stccc	0, cr0, [r0], {135}	; 0x87
    13d4:	01000000 	mrseq	r0, (UNDEF: 0)
    13d8:	0008339c 	muleq	r8, ip, r3
    13dc:	65722200 	ldrbvs	r2, [r2, #-512]!	; 0xfffffe00
    13e0:	79010071 	stmdbvc	r1, {r0, r4, r5, r6}
    13e4:	00038720 	andeq	r8, r3, r0, lsr #14
    13e8:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    13ec:	000d121e 	andeq	r1, sp, lr, lsl r2
    13f0:	0e7a0100 	rpweqe	f0, f2, f0
    13f4:	0000004d 	andeq	r0, r0, sp, asr #32
    13f8:	00709102 	rsbseq	r9, r0, r2, lsl #2
    13fc:	000dde21 	andeq	sp, sp, r1, lsr #28
    1400:	066b0100 	strbteq	r0, [fp], -r0, lsl #2
    1404:	00000f21 	andeq	r0, r0, r1, lsr #30
    1408:	000001f0 	strdeq	r0, [r0], -r0	; <UNPREDICTABLE>
    140c:	00008714 	andeq	r8, r0, r4, lsl r7
    1410:	00000054 	andeq	r0, r0, r4, asr r0
    1414:	087f9c01 	ldmdaeq	pc!, {r0, sl, fp, ip, pc}^	; <UNPREDICTABLE>
    1418:	35200000 	strcc	r0, [r0, #-0]!
    141c:	0100000e 	tsteq	r0, lr
    1420:	004d156b 	subeq	r1, sp, fp, ror #10
    1424:	91020000 	mrsls	r0, (UNDEF: 2)
    1428:	099a206c 	ldmibeq	sl, {r2, r3, r5, r6, sp}
    142c:	6b010000 	blvs	41434 <__bss_end+0x382f8>
    1430:	00004d25 	andeq	r4, r0, r5, lsr #26
    1434:	68910200 	ldmvs	r1, {r9}
    1438:	0010ae1e 	andseq	sl, r0, lr, lsl lr
    143c:	0e6d0100 	poweqe	f0, f5, f0
    1440:	0000004d 	andeq	r0, r0, sp, asr #32
    1444:	00749102 	rsbseq	r9, r4, r2, lsl #2
    1448:	000d5121 	andeq	r5, sp, r1, lsr #2
    144c:	125e0100 	subsne	r0, lr, #0, 2
    1450:	00000f8d 	andeq	r0, r0, sp, lsl #31
    1454:	0000008b 	andeq	r0, r0, fp, lsl #1
    1458:	000086c4 	andeq	r8, r0, r4, asr #13
    145c:	00000050 	andeq	r0, r0, r0, asr r0
    1460:	08da9c01 	ldmeq	sl, {r0, sl, fp, ip, pc}^
    1464:	2c200000 	stccs	0, cr0, [r0], #-0
    1468:	0100000f 	tsteq	r0, pc
    146c:	004d205e 	subeq	r2, sp, lr, asr r0
    1470:	91020000 	mrsls	r0, (UNDEF: 2)
    1474:	0e6a206c 	cdpeq	0, 6, cr2, cr10, cr12, {3}
    1478:	5e010000 	cdppl	0, 0, cr0, cr1, cr0, {0}
    147c:	00004d2f 	andeq	r4, r0, pc, lsr #26
    1480:	68910200 	ldmvs	r1, {r9}
    1484:	00099a20 	andeq	r9, r9, r0, lsr #20
    1488:	3f5e0100 	svccc	0x005e0100
    148c:	0000004d 	andeq	r0, r0, sp, asr #32
    1490:	1e649102 	lgnnes	f1, f2
    1494:	000010ae 	andeq	r1, r0, lr, lsr #1
    1498:	8b166001 	blhi	5994a4 <__bss_end+0x590368>
    149c:	02000000 	andeq	r0, r0, #0
    14a0:	21007491 			; <UNDEFINED> instruction: 0x21007491
    14a4:	00000fc3 	andeq	r0, r0, r3, asr #31
    14a8:	560a5201 	strpl	r5, [sl], -r1, lsl #4
    14ac:	4d00000d 	stcmi	0, cr0, [r0, #-52]	; 0xffffffcc
    14b0:	80000000 	andhi	r0, r0, r0
    14b4:	44000086 	strmi	r0, [r0], #-134	; 0xffffff7a
    14b8:	01000000 	mrseq	r0, (UNDEF: 0)
    14bc:	0009269c 	muleq	r9, ip, r6
    14c0:	0f2c2000 	svceq	0x002c2000
    14c4:	52010000 	andpl	r0, r1, #0
    14c8:	00004d1a 	andeq	r4, r0, sl, lsl sp
    14cc:	6c910200 	lfmvs	f0, 4, [r1], {0}
    14d0:	000e6a20 	andeq	r6, lr, r0, lsr #20
    14d4:	29520100 	ldmdbcs	r2, {r8}^
    14d8:	0000004d 	andeq	r0, r0, sp, asr #32
    14dc:	1e689102 	lgnnee	f1, f2
    14e0:	00000fbc 			; <UNDEFINED> instruction: 0x00000fbc
    14e4:	4d0e5401 	cfstrsmi	mvf5, [lr, #-4]
    14e8:	02000000 	andeq	r0, r0, #0
    14ec:	21007491 			; <UNDEFINED> instruction: 0x21007491
    14f0:	00000fb6 			; <UNDEFINED> instruction: 0x00000fb6
    14f4:	980a4501 	stmdals	sl, {r0, r8, sl, lr}
    14f8:	4d00000f 	stcmi	0, cr0, [r0, #-60]	; 0xffffffc4
    14fc:	30000000 	andcc	r0, r0, r0
    1500:	50000086 	andpl	r0, r0, r6, lsl #1
    1504:	01000000 	mrseq	r0, (UNDEF: 0)
    1508:	0009819c 	muleq	r9, ip, r1
    150c:	0f2c2000 	svceq	0x002c2000
    1510:	45010000 	strmi	r0, [r1, #-0]
    1514:	00004d19 	andeq	r4, r0, r9, lsl sp
    1518:	6c910200 	lfmvs	f0, 4, [r1], {0}
    151c:	000e0a20 	andeq	r0, lr, r0, lsr #20
    1520:	30450100 	subcc	r0, r5, r0, lsl #2
    1524:	0000011d 	andeq	r0, r0, sp, lsl r1
    1528:	20689102 	rsbcs	r9, r8, r2, lsl #2
    152c:	00000e70 	andeq	r0, r0, r0, ror lr
    1530:	ac414501 	cfstr64ge	mvdx4, [r1], {1}
    1534:	02000006 	andeq	r0, r0, #6
    1538:	ae1e6491 	cfcmpsge	r6, mvf14, mvf1
    153c:	01000010 	tsteq	r0, r0, lsl r0
    1540:	004d0e47 	subeq	r0, sp, r7, asr #28
    1544:	91020000 	mrsls	r0, (UNDEF: 2)
    1548:	ff230074 			; <UNDEFINED> instruction: 0xff230074
    154c:	0100000c 	tsteq	r0, ip
    1550:	0e14063f 	mrceq	6, 0, r0, cr4, cr15, {1}
    1554:	86040000 	strhi	r0, [r4], -r0
    1558:	002c0000 	eoreq	r0, ip, r0
    155c:	9c010000 	stcls	0, cr0, [r1], {-0}
    1560:	000009ab 	andeq	r0, r0, fp, lsr #19
    1564:	000f2c20 	andeq	r2, pc, r0, lsr #24
    1568:	153f0100 	ldrne	r0, [pc, #-256]!	; 1470 <shift+0x1470>
    156c:	0000004d 	andeq	r0, r0, sp, asr #32
    1570:	00749102 	rsbseq	r9, r4, r2, lsl #2
    1574:	000e2f21 	andeq	r2, lr, r1, lsr #30
    1578:	0a320100 	beq	c81980 <__bss_end+0xc78844>
    157c:	00000e76 	andeq	r0, r0, r6, ror lr
    1580:	0000004d 	andeq	r0, r0, sp, asr #32
    1584:	000085b4 			; <UNDEFINED> instruction: 0x000085b4
    1588:	00000050 	andeq	r0, r0, r0, asr r0
    158c:	0a069c01 	beq	1a8598 <__bss_end+0x19f45c>
    1590:	2c200000 	stccs	0, cr0, [r0], #-0
    1594:	0100000f 	tsteq	r0, pc
    1598:	004d1932 	subeq	r1, sp, r2, lsr r9
    159c:	91020000 	mrsls	r0, (UNDEF: 2)
    15a0:	0fd9206c 	svceq	0x00d9206c
    15a4:	32010000 	andcc	r0, r1, #0
    15a8:	0001f72b 	andeq	pc, r1, fp, lsr #14
    15ac:	68910200 	ldmvs	r1, {r9}
    15b0:	000ea320 	andeq	sl, lr, r0, lsr #6
    15b4:	3c320100 	ldfccs	f0, [r2], #-0
    15b8:	0000004d 	andeq	r0, r0, sp, asr #32
    15bc:	1e649102 	lgnnes	f1, f2
    15c0:	00000f87 	andeq	r0, r0, r7, lsl #31
    15c4:	4d0e3401 	cfstrsmi	mvf3, [lr, #-4]
    15c8:	02000000 	andeq	r0, r0, #0
    15cc:	21007491 			; <UNDEFINED> instruction: 0x21007491
    15d0:	000010d8 	ldrdeq	r1, [r0], -r8
    15d4:	e00a2501 	and	r2, sl, r1, lsl #10
    15d8:	4d00000f 	stcmi	0, cr0, [r0, #-60]	; 0xffffffc4
    15dc:	64000000 	strvs	r0, [r0], #-0
    15e0:	50000085 	andpl	r0, r0, r5, lsl #1
    15e4:	01000000 	mrseq	r0, (UNDEF: 0)
    15e8:	000a619c 	muleq	sl, ip, r1
    15ec:	0f2c2000 	svceq	0x002c2000
    15f0:	25010000 	strcs	r0, [r1, #-0]
    15f4:	00004d18 	andeq	r4, r0, r8, lsl sp
    15f8:	6c910200 	lfmvs	f0, 4, [r1], {0}
    15fc:	000fd920 	andeq	sp, pc, r0, lsr #18
    1600:	2a250100 	bcs	941a08 <__bss_end+0x9388cc>
    1604:	00000a67 	andeq	r0, r0, r7, ror #20
    1608:	20689102 	rsbcs	r9, r8, r2, lsl #2
    160c:	00000ea3 	andeq	r0, r0, r3, lsr #29
    1610:	4d3b2501 	cfldr32mi	mvfx2, [fp, #-4]!
    1614:	02000000 	andeq	r0, r0, #0
    1618:	231e6491 	tstcs	lr, #-1862270976	; 0x91000000
    161c:	0100000d 	tsteq	r0, sp
    1620:	004d0e27 	subeq	r0, sp, r7, lsr #28
    1624:	91020000 	mrsls	r0, (UNDEF: 2)
    1628:	040d0074 	streq	r0, [sp], #-116	; 0xffffff8c
    162c:	00000025 	andeq	r0, r0, r5, lsr #32
    1630:	000a6103 	andeq	r6, sl, r3, lsl #2
    1634:	0e3b2100 	rsfeqe	f2, f3, f0
    1638:	19010000 	stmdbne	r1, {}	; <UNPREDICTABLE>
    163c:	0010e40a 	andseq	lr, r0, sl, lsl #8
    1640:	00004d00 	andeq	r4, r0, r0, lsl #26
    1644:	00852000 	addeq	r2, r5, r0
    1648:	00004400 	andeq	r4, r0, r0, lsl #8
    164c:	b89c0100 	ldmlt	ip, {r8}
    1650:	2000000a 	andcs	r0, r0, sl
    1654:	000010cf 	andeq	r1, r0, pc, asr #1
    1658:	f71b1901 			; <UNDEFINED> instruction: 0xf71b1901
    165c:	02000001 	andeq	r0, r0, #1
    1660:	d4206c91 	strtle	r6, [r0], #-3217	; 0xfffff36f
    1664:	0100000f 	tsteq	r0, pc
    1668:	01c63519 	biceq	r3, r6, r9, lsl r5
    166c:	91020000 	mrsls	r0, (UNDEF: 2)
    1670:	0f2c1e68 	svceq	0x002c1e68
    1674:	1b010000 	blne	4167c <__bss_end+0x38540>
    1678:	00004d0e 	andeq	r4, r0, lr, lsl #26
    167c:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    1680:	0d702400 	cfldrdeq	mvd2, [r0, #-0]
    1684:	14010000 	strne	r0, [r1], #-0
    1688:	000d2906 	andeq	r2, sp, r6, lsl #18
    168c:	00850400 	addeq	r0, r5, r0, lsl #8
    1690:	00001c00 	andeq	r1, r0, r0, lsl #24
    1694:	239c0100 	orrscs	r0, ip, #0, 2
    1698:	00000fca 	andeq	r0, r0, sl, asr #31
    169c:	fc060e01 	stc2	14, cr0, [r6], {1}
    16a0:	d800000d 	stmdale	r0, {r0, r2, r3}
    16a4:	2c000084 	stccs	0, cr0, [r0], {132}	; 0x84
    16a8:	01000000 	mrseq	r0, (UNDEF: 0)
    16ac:	000af89c 	muleq	sl, ip, r8
    16b0:	0d672000 	stcleq	0, cr2, [r7, #-0]
    16b4:	0e010000 	cdpeq	0, 0, cr0, cr1, cr0, {0}
    16b8:	00003814 	andeq	r3, r0, r4, lsl r8
    16bc:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    16c0:	10dd2500 	sbcsne	r2, sp, r0, lsl #10
    16c4:	04010000 	streq	r0, [r1], #-0
    16c8:	000e1e0a 	andeq	r1, lr, sl, lsl #28
    16cc:	00004d00 	andeq	r4, r0, r0, lsl #26
    16d0:	0084ac00 	addeq	sl, r4, r0, lsl #24
    16d4:	00002c00 	andeq	r2, r0, r0, lsl #24
    16d8:	229c0100 	addscs	r0, ip, #0, 2
    16dc:	00646970 	rsbeq	r6, r4, r0, ror r9
    16e0:	4d0e0601 	stcmi	6, cr0, [lr, #-4]
    16e4:	02000000 	andeq	r0, r0, #0
    16e8:	00007491 	muleq	r0, r1, r4
    16ec:	0000032e 	andeq	r0, r0, lr, lsr #6
    16f0:	06cb0004 	strbeq	r0, [fp], r4
    16f4:	01040000 	mrseq	r0, (UNDEF: 4)
    16f8:	00000fec 	andeq	r0, r0, ip, ror #31
    16fc:	00112404 	andseq	r2, r1, r4, lsl #8
    1700:	000cb400 	andeq	fp, ip, r0, lsl #8
    1704:	00890800 	addeq	r0, r9, r0, lsl #16
    1708:	0004b800 	andeq	fp, r4, r0, lsl #16
    170c:	00082700 	andeq	r2, r8, r0, lsl #14
    1710:	00490200 	subeq	r0, r9, r0, lsl #4
    1714:	8d030000 	stchi	0, cr0, [r3, #-0]
    1718:	01000011 	tsteq	r0, r1, lsl r0
    171c:	00611005 	rsbeq	r1, r1, r5
    1720:	30110000 	andscc	r0, r1, r0
    1724:	34333231 	ldrtcc	r3, [r3], #-561	; 0xfffffdcf
    1728:	38373635 	ldmdacc	r7!, {r0, r2, r4, r5, r9, sl, ip, sp}
    172c:	43424139 	movtmi	r4, #8505	; 0x2139
    1730:	00464544 	subeq	r4, r6, r4, asr #10
    1734:	03010400 	movweq	r0, #5120	; 0x1400
    1738:	00002501 	andeq	r2, r0, r1, lsl #10
    173c:	00740500 	rsbseq	r0, r4, r0, lsl #10
    1740:	00610000 	rsbeq	r0, r1, r0
    1744:	66060000 	strvs	r0, [r6], -r0
    1748:	10000000 	andne	r0, r0, r0
    174c:	00510700 	subseq	r0, r1, r0, lsl #14
    1750:	04080000 	streq	r0, [r8], #-0
    1754:	000ab007 	andeq	fp, sl, r7
    1758:	08010800 	stmdaeq	r1, {fp}
    175c:	00000b45 	andeq	r0, r0, r5, asr #22
    1760:	00006d07 	andeq	r6, r0, r7, lsl #26
    1764:	002a0900 	eoreq	r0, sl, r0, lsl #18
    1768:	bc0a0000 	stclt	0, cr0, [sl], {-0}
    176c:	01000011 	tsteq	r0, r1, lsl r0
    1770:	11a70664 			; <UNDEFINED> instruction: 0x11a70664
    1774:	8d400000 	stclhi	0, cr0, [r0, #-0]
    1778:	00800000 	addeq	r0, r0, r0
    177c:	9c010000 	stcls	0, cr0, [r1], {-0}
    1780:	000000fb 	strdeq	r0, [r0], -fp
    1784:	6372730b 	cmnvs	r2, #738197504	; 0x2c000000
    1788:	19640100 	stmdbne	r4!, {r8}^
    178c:	000000fb 	strdeq	r0, [r0], -fp
    1790:	0b649102 	bleq	1925ba0 <__bss_end+0x191ca64>
    1794:	00747364 	rsbseq	r7, r4, r4, ror #6
    1798:	02246401 	eoreq	r6, r4, #16777216	; 0x1000000
    179c:	02000001 	andeq	r0, r0, #1
    17a0:	6e0b6091 	mcrvs	0, 0, r6, cr11, cr1, {4}
    17a4:	01006d75 	tsteq	r0, r5, ror sp
    17a8:	01042d64 	tsteq	r4, r4, ror #26
    17ac:	91020000 	mrsls	r0, (UNDEF: 2)
    17b0:	12160c5c 	andsne	r0, r6, #92, 24	; 0x5c00
    17b4:	66010000 	strvs	r0, [r1], -r0
    17b8:	00010b0e 	andeq	r0, r1, lr, lsl #22
    17bc:	70910200 	addsvc	r0, r1, r0, lsl #4
    17c0:	0011990c 	andseq	r9, r1, ip, lsl #18
    17c4:	08670100 	stmdaeq	r7!, {r8}^
    17c8:	00000111 	andeq	r0, r0, r1, lsl r1
    17cc:	0d6c9102 	stfeqp	f1, [ip, #-8]!
    17d0:	00008d68 	andeq	r8, r0, r8, ror #26
    17d4:	00000048 	andeq	r0, r0, r8, asr #32
    17d8:	0100690e 	tsteq	r0, lr, lsl #18
    17dc:	01040b69 	tsteq	r4, r9, ror #22
    17e0:	91020000 	mrsls	r0, (UNDEF: 2)
    17e4:	0f000074 	svceq	0x00000074
    17e8:	00010104 	andeq	r0, r1, r4, lsl #2
    17ec:	04111000 	ldreq	r1, [r1], #-0
    17f0:	69050412 	stmdbvs	r5, {r1, r4, sl}
    17f4:	0f00746e 	svceq	0x0000746e
    17f8:	00007404 	andeq	r7, r0, r4, lsl #8
    17fc:	6d040f00 	stcvs	15, cr0, [r4, #-0]
    1800:	0a000000 	beq	1808 <shift+0x1808>
    1804:	0000110b 	andeq	r1, r0, fp, lsl #2
    1808:	18065c01 	stmdane	r6, {r0, sl, fp, ip, lr}
    180c:	d8000011 	stmdale	r0, {r0, r4}
    1810:	6800008c 	stmdavs	r0, {r2, r3, r7}
    1814:	01000000 	mrseq	r0, (UNDEF: 0)
    1818:	0001769c 	muleq	r1, ip, r6
    181c:	120f1300 	andne	r1, pc, #0, 6
    1820:	5c010000 	stcpl	0, cr0, [r1], {-0}
    1824:	00010212 	andeq	r0, r1, r2, lsl r2
    1828:	6c910200 	lfmvs	f0, 4, [r1], {0}
    182c:	00111113 	andseq	r1, r1, r3, lsl r1
    1830:	1e5c0100 	rdfnee	f0, f4, f0
    1834:	00000104 	andeq	r0, r0, r4, lsl #2
    1838:	0e689102 	lgneqe	f1, f2
    183c:	006d656d 	rsbeq	r6, sp, sp, ror #10
    1840:	11085e01 	tstne	r8, r1, lsl #28
    1844:	02000001 	andeq	r0, r0, #1
    1848:	f40d7091 	vst4.32	{d7-d10}, [sp :64], r1
    184c:	3c00008c 	stccc	0, cr0, [r0], {140}	; 0x8c
    1850:	0e000000 	cdpeq	0, 0, cr0, cr0, cr0, {0}
    1854:	60010069 	andvs	r0, r1, r9, rrx
    1858:	0001040b 	andeq	r0, r1, fp, lsl #8
    185c:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    1860:	c3140000 	tstgt	r4, #0
    1864:	01000011 	tsteq	r0, r1, lsl r0
    1868:	11dc0552 	bicsne	r0, ip, r2, asr r5
    186c:	01040000 	mrseq	r0, (UNDEF: 4)
    1870:	8c840000 	stchi	0, cr0, [r4], {0}
    1874:	00540000 	subseq	r0, r4, r0
    1878:	9c010000 	stcls	0, cr0, [r1], {-0}
    187c:	000001af 	andeq	r0, r0, pc, lsr #3
    1880:	0100730b 	tsteq	r0, fp, lsl #6
    1884:	010b1852 	tsteq	fp, r2, asr r8
    1888:	91020000 	mrsls	r0, (UNDEF: 2)
    188c:	00690e6c 	rsbeq	r0, r9, ip, ror #28
    1890:	04065401 	streq	r5, [r6], #-1025	; 0xfffffbff
    1894:	02000001 	andeq	r0, r0, #1
    1898:	14007491 	strne	r7, [r0], #-1169	; 0xfffffb6f
    189c:	000011ff 	strdeq	r1, [r0], -pc	; <UNPREDICTABLE>
    18a0:	ca054201 	bgt	1520ac <__bss_end+0x148f70>
    18a4:	04000011 	streq	r0, [r0], #-17	; 0xffffffef
    18a8:	d8000001 	stmdale	r0, {r0}
    18ac:	ac00008b 	stcge	0, cr0, [r0], {139}	; 0x8b
    18b0:	01000000 	mrseq	r0, (UNDEF: 0)
    18b4:	0002159c 	muleq	r2, ip, r5
    18b8:	31730b00 	cmncc	r3, r0, lsl #22
    18bc:	19420100 	stmdbne	r2, {r8}^
    18c0:	0000010b 	andeq	r0, r0, fp, lsl #2
    18c4:	0b6c9102 	bleq	1b25cd4 <__bss_end+0x1b1cb98>
    18c8:	01003273 	tsteq	r0, r3, ror r2
    18cc:	010b2942 	tsteq	fp, r2, asr #18
    18d0:	91020000 	mrsls	r0, (UNDEF: 2)
    18d4:	756e0b68 	strbvc	r0, [lr, #-2920]!	; 0xfffff498
    18d8:	4201006d 	andmi	r0, r1, #109	; 0x6d
    18dc:	00010431 	andeq	r0, r1, r1, lsr r4
    18e0:	64910200 	ldrvs	r0, [r1], #512	; 0x200
    18e4:	0031750e 	eorseq	r7, r1, lr, lsl #10
    18e8:	15104401 	ldrne	r4, [r0, #-1025]	; 0xfffffbff
    18ec:	02000002 	andeq	r0, r0, #2
    18f0:	750e7791 	strvc	r7, [lr, #-1937]	; 0xfffff86f
    18f4:	44010032 	strmi	r0, [r1], #-50	; 0xffffffce
    18f8:	00021514 	andeq	r1, r2, r4, lsl r5
    18fc:	76910200 	ldrvc	r0, [r1], r0, lsl #4
    1900:	08010800 	stmdaeq	r1, {fp}
    1904:	00000b3c 	andeq	r0, r0, ip, lsr fp
    1908:	00120714 	andseq	r0, r2, r4, lsl r7
    190c:	07360100 	ldreq	r0, [r6, -r0, lsl #2]!
    1910:	000011ee 	andeq	r1, r0, lr, ror #3
    1914:	00000111 	andeq	r0, r0, r1, lsl r1
    1918:	00008b18 	andeq	r8, r0, r8, lsl fp
    191c:	000000c0 	andeq	r0, r0, r0, asr #1
    1920:	02759c01 	rsbseq	r9, r5, #256	; 0x100
    1924:	06130000 	ldreq	r0, [r3], -r0
    1928:	01000011 	tsteq	r0, r1, lsl r0
    192c:	01111536 	tsteq	r1, r6, lsr r5
    1930:	91020000 	mrsls	r0, (UNDEF: 2)
    1934:	72730b6c 	rsbsvc	r0, r3, #108, 22	; 0x1b000
    1938:	36010063 	strcc	r0, [r1], -r3, rrx
    193c:	00010b27 	andeq	r0, r1, r7, lsr #22
    1940:	68910200 	ldmvs	r1, {r9}
    1944:	6d756e0b 	ldclvs	14, cr6, [r5, #-44]!	; 0xffffffd4
    1948:	30360100 	eorscc	r0, r6, r0, lsl #2
    194c:	00000104 	andeq	r0, r0, r4, lsl #2
    1950:	0e649102 	lgneqs	f1, f2
    1954:	38010069 	stmdacc	r1, {r0, r3, r5, r6}
    1958:	00010406 	andeq	r0, r1, r6, lsl #8
    195c:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    1960:	11e91400 	mvnne	r1, r0, lsl #8
    1964:	24010000 	strcs	r0, [r1], #-0
    1968:	00118205 	andseq	r8, r1, r5, lsl #4
    196c:	00010400 	andeq	r0, r1, r0, lsl #8
    1970:	008a7c00 	addeq	r7, sl, r0, lsl #24
    1974:	00009c00 	andeq	r9, r0, r0, lsl #24
    1978:	b29c0100 	addslt	r0, ip, #0, 2
    197c:	13000002 	movwne	r0, #2
    1980:	00001100 	andeq	r1, r0, r0, lsl #2
    1984:	0b162401 	bleq	58a990 <__bss_end+0x581854>
    1988:	02000001 	andeq	r0, r0, #1
    198c:	a00c6c91 	mulge	ip, r1, ip
    1990:	01000011 	tsteq	r0, r1, lsl r0
    1994:	01040626 	tsteq	r4, r6, lsr #12
    1998:	91020000 	mrsls	r0, (UNDEF: 2)
    199c:	1d150074 	ldcne	0, cr0, [r5, #-464]	; 0xfffffe30
    19a0:	01000012 	tsteq	r0, r2, lsl r0
    19a4:	12220608 	eorne	r0, r2, #8, 12	; 0x800000
    19a8:	89080000 	stmdbhi	r8, {}	; <UNPREDICTABLE>
    19ac:	01740000 	cmneq	r4, r0
    19b0:	9c010000 	stcls	0, cr0, [r1], {-0}
    19b4:	00110013 	andseq	r0, r1, r3, lsl r0
    19b8:	18080100 	stmdane	r8, {r8}
    19bc:	00000066 	andeq	r0, r0, r6, rrx
    19c0:	13649102 	cmnne	r4, #-2147483648	; 0x80000000
    19c4:	000011a0 	andeq	r1, r0, r0, lsr #3
    19c8:	11250801 			; <UNDEFINED> instruction: 0x11250801
    19cc:	02000001 	andeq	r0, r0, #1
    19d0:	b7136091 			; <UNDEFINED> instruction: 0xb7136091
    19d4:	01000011 	tsteq	r0, r1, lsl r0
    19d8:	00663a08 	rsbeq	r3, r6, r8, lsl #20
    19dc:	91020000 	mrsls	r0, (UNDEF: 2)
    19e0:	00690e5c 	rsbeq	r0, r9, ip, asr lr
    19e4:	04060a01 	streq	r0, [r6], #-2561	; 0xfffff5ff
    19e8:	02000001 	andeq	r0, r0, #1
    19ec:	d40d7491 	strle	r7, [sp], #-1169	; 0xfffffb6f
    19f0:	98000089 	stmdals	r0, {r0, r3, r7}
    19f4:	0e000000 	cdpeq	0, 0, cr0, cr0, cr0, {0}
    19f8:	1c01006a 	stcne	0, cr0, [r1], {106}	; 0x6a
    19fc:	0001040b 	andeq	r0, r1, fp, lsl #8
    1a00:	70910200 	addsvc	r0, r1, r0, lsl #4
    1a04:	0089fc0d 	addeq	pc, r9, sp, lsl #24
    1a08:	00006000 	andeq	r6, r0, r0
    1a0c:	00630e00 	rsbeq	r0, r3, r0, lsl #28
    1a10:	6d081e01 	stcvs	14, cr1, [r8, #-4]
    1a14:	02000000 	andeq	r0, r0, #0
    1a18:	00006f91 	muleq	r0, r1, pc	; <UNPREDICTABLE>
	...

Disassembly of section .debug_abbrev:

00000000 <.debug_abbrev>:
   0:	10001101 	andne	r1, r0, r1, lsl #2
   4:	12011106 	andne	r1, r1, #-2147483647	; 0x80000001
   8:	1b0e0301 	blne	380c14 <__bss_end+0x377ad8>
   c:	130e250e 	movwne	r2, #58638	; 0xe50e
  10:	00000005 	andeq	r0, r0, r5
  14:	25011101 	strcs	r1, [r1, #-257]	; 0xfffffeff
  18:	030b130e 	movweq	r1, #45838	; 0xb30e
  1c:	110e1b0e 	tstne	lr, lr, lsl #22
  20:	10061201 	andne	r1, r6, r1, lsl #4
  24:	02000017 	andeq	r0, r0, #23
  28:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
  2c:	0b3b0b3a 	bleq	ec2d1c <__bss_end+0xeb9be0>
  30:	13490b39 	movtne	r0, #39737	; 0x9b39
  34:	193c193f 	ldmdbne	ip!, {r0, r1, r2, r3, r4, r5, r8, fp, ip}
  38:	24030000 	strcs	r0, [r3], #-0
  3c:	3e0b0b00 	vmlacc.f64	d0, d11, d0
  40:	000e030b 	andeq	r0, lr, fp, lsl #6
  44:	012e0400 			; <UNDEFINED> instruction: 0x012e0400
  48:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
  4c:	0b3b0b3a 	bleq	ec2d3c <__bss_end+0xeb9c00>
  50:	01110b39 	tsteq	r1, r9, lsr fp
  54:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
  58:	01194296 			; <UNDEFINED> instruction: 0x01194296
  5c:	05000013 	streq	r0, [r0, #-19]	; 0xffffffed
  60:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
  64:	0b3b0b3a 	bleq	ec2d54 <__bss_end+0xeb9c18>
  68:	13490b39 	movtne	r0, #39737	; 0x9b39
  6c:	00001802 	andeq	r1, r0, r2, lsl #16
  70:	0b002406 	bleq	9090 <_ZL15char_tick_delay+0x58>
  74:	030b3e0b 	movweq	r3, #48651	; 0xbe0b
  78:	07000008 	streq	r0, [r0, -r8]
  7c:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
  80:	0b3a0e03 	bleq	e83894 <__bss_end+0xe7a758>
  84:	0b390b3b 	bleq	e42d78 <__bss_end+0xe39c3c>
  88:	06120111 			; <UNDEFINED> instruction: 0x06120111
  8c:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
  90:	00130119 	andseq	r0, r3, r9, lsl r1
  94:	010b0800 	tsteq	fp, r0, lsl #16
  98:	06120111 			; <UNDEFINED> instruction: 0x06120111
  9c:	34090000 	strcc	r0, [r9], #-0
  a0:	3a080300 	bcc	200ca8 <__bss_end+0x1f7b6c>
  a4:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
  a8:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
  ac:	0a000018 	beq	114 <shift+0x114>
  b0:	0b0b000f 	bleq	2c00f4 <__bss_end+0x2b6fb8>
  b4:	00001349 	andeq	r1, r0, r9, asr #6
  b8:	01110100 	tsteq	r1, r0, lsl #2
  bc:	0b130e25 	bleq	4c3958 <__bss_end+0x4ba81c>
  c0:	0e1b0e03 	cdpeq	14, 1, cr0, cr11, cr3, {0}
  c4:	06120111 			; <UNDEFINED> instruction: 0x06120111
  c8:	00001710 	andeq	r1, r0, r0, lsl r7
  cc:	03001602 	movweq	r1, #1538	; 0x602
  d0:	3b0b3a0e 	blcc	2ce910 <__bss_end+0x2c57d4>
  d4:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
  d8:	03000013 	movweq	r0, #19
  dc:	0b0b000f 	bleq	2c0120 <__bss_end+0x2b6fe4>
  e0:	00001349 	andeq	r1, r0, r9, asr #6
  e4:	00001504 	andeq	r1, r0, r4, lsl #10
  e8:	01010500 	tsteq	r1, r0, lsl #10
  ec:	13011349 	movwne	r1, #4937	; 0x1349
  f0:	21060000 	mrscs	r0, (UNDEF: 6)
  f4:	2f134900 	svccs	0x00134900
  f8:	07000006 	streq	r0, [r0, -r6]
  fc:	0b0b0024 	bleq	2c0194 <__bss_end+0x2b7058>
 100:	0e030b3e 	vmoveq.16	d3[0], r0
 104:	34080000 	strcc	r0, [r8], #-0
 108:	3a0e0300 	bcc	380d10 <__bss_end+0x377bd4>
 10c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 110:	3f13490b 	svccc	0x0013490b
 114:	00193c19 	andseq	r3, r9, r9, lsl ip
 118:	012e0900 			; <UNDEFINED> instruction: 0x012e0900
 11c:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 120:	0b3b0b3a 	bleq	ec2e10 <__bss_end+0xeb9cd4>
 124:	13490b39 	movtne	r0, #39737	; 0x9b39
 128:	06120111 			; <UNDEFINED> instruction: 0x06120111
 12c:	42961840 	addsmi	r1, r6, #64, 16	; 0x400000
 130:	00130119 	andseq	r0, r3, r9, lsl r1
 134:	00340a00 	eorseq	r0, r4, r0, lsl #20
 138:	0b3a0e03 	bleq	e8394c <__bss_end+0xe7a810>
 13c:	0b390b3b 	bleq	e42e30 <__bss_end+0xe39cf4>
 140:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 144:	240b0000 	strcs	r0, [fp], #-0
 148:	3e0b0b00 	vmlacc.f64	d0, d11, d0
 14c:	0008030b 	andeq	r0, r8, fp, lsl #6
 150:	002e0c00 	eoreq	r0, lr, r0, lsl #24
 154:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 158:	0b3b0b3a 	bleq	ec2e48 <__bss_end+0xeb9d0c>
 15c:	01110b39 	tsteq	r1, r9, lsr fp
 160:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 164:	00194297 	mulseq	r9, r7, r2
 168:	01390d00 	teqeq	r9, r0, lsl #26
 16c:	0b3a0e03 	bleq	e83980 <__bss_end+0xe7a844>
 170:	13010b3b 	movwne	r0, #6971	; 0x1b3b
 174:	2e0e0000 	cdpcs	0, 0, cr0, cr14, cr0, {0}
 178:	03193f01 	tsteq	r9, #1, 30
 17c:	3b0b3a0e 	blcc	2ce9bc <__bss_end+0x2c5880>
 180:	3c0b390b 			; <UNDEFINED> instruction: 0x3c0b390b
 184:	00130119 	andseq	r0, r3, r9, lsl r1
 188:	00050f00 	andeq	r0, r5, r0, lsl #30
 18c:	00001349 	andeq	r1, r0, r9, asr #6
 190:	3f012e10 	svccc	0x00012e10
 194:	3a0e0319 	bcc	380e00 <__bss_end+0x377cc4>
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
 1c0:	3a080300 	bcc	200dc8 <__bss_end+0x1f7c8c>
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
 1f4:	0b0b0024 	bleq	2c028c <__bss_end+0x2b7150>
 1f8:	0e030b3e 	vmoveq.16	d3[0], r0
 1fc:	24030000 	strcs	r0, [r3], #-0
 200:	3e0b0b00 	vmlacc.f64	d0, d11, d0
 204:	0008030b 	andeq	r0, r8, fp, lsl #6
 208:	00160400 	andseq	r0, r6, r0, lsl #8
 20c:	0b3a0e03 	bleq	e83a20 <__bss_end+0xe7a8e4>
 210:	0b390b3b 	bleq	e42f04 <__bss_end+0xe39dc8>
 214:	00001349 	andeq	r1, r0, r9, asr #6
 218:	49002605 	stmdbmi	r0, {r0, r2, r9, sl, sp}
 21c:	06000013 			; <UNDEFINED> instruction: 0x06000013
 220:	0e030113 	mcreq	1, 0, r0, cr3, cr3, {0}
 224:	0b3a0b0b 	bleq	e82e58 <__bss_end+0xe79d1c>
 228:	0b390b3b 	bleq	e42f1c <__bss_end+0xe39de0>
 22c:	00001301 	andeq	r1, r0, r1, lsl #6
 230:	03000d07 	movweq	r0, #3335	; 0xd07
 234:	3b0b3a08 	blcc	2cea5c <__bss_end+0x2c5920>
 238:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 23c:	000b3813 	andeq	r3, fp, r3, lsl r8
 240:	01040800 	tsteq	r4, r0, lsl #16
 244:	196d0e03 	stmdbne	sp!, {r0, r1, r9, sl, fp}^
 248:	0b0b0b3e 	bleq	2c2f48 <__bss_end+0x2b9e0c>
 24c:	0b3a1349 	bleq	e84f78 <__bss_end+0xe7be3c>
 250:	0b390b3b 	bleq	e42f44 <__bss_end+0xe39e08>
 254:	00001301 	andeq	r1, r0, r1, lsl #6
 258:	03002809 	movweq	r2, #2057	; 0x809
 25c:	000b1c0e 	andeq	r1, fp, lr, lsl #24
 260:	00340a00 	eorseq	r0, r4, r0, lsl #20
 264:	0b3a0e03 	bleq	e83a78 <__bss_end+0xe7a93c>
 268:	0b390b3b 	bleq	e42f5c <__bss_end+0xe39e20>
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
 294:	0b3b0b3a 	bleq	ec2f84 <__bss_end+0xeb9e48>
 298:	13490b39 	movtne	r0, #39737	; 0x9b39
 29c:	00000b38 	andeq	r0, r0, r8, lsr fp
 2a0:	4901010f 	stmdbmi	r1, {r0, r1, r2, r3, r8}
 2a4:	00130113 	andseq	r0, r3, r3, lsl r1
 2a8:	00211000 	eoreq	r1, r1, r0
 2ac:	0b2f1349 	bleq	bc4fd8 <__bss_end+0xbbbe9c>
 2b0:	02110000 	andseq	r0, r1, #0
 2b4:	0b0e0301 	bleq	380ec0 <__bss_end+0x377d84>
 2b8:	3b0b3a0b 	blcc	2ceaec <__bss_end+0x2c59b0>
 2bc:	010b390b 	tsteq	fp, fp, lsl #18
 2c0:	12000013 	andne	r0, r0, #19
 2c4:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 2c8:	0b3a0e03 	bleq	e83adc <__bss_end+0xe7a9a0>
 2cc:	0b390b3b 	bleq	e42fc0 <__bss_end+0xe39e84>
 2d0:	193c0e6e 	ldmdbne	ip!, {r1, r2, r3, r5, r6, r9, sl, fp}
 2d4:	13011364 	movwne	r1, #4964	; 0x1364
 2d8:	05130000 	ldreq	r0, [r3, #-0]
 2dc:	34134900 	ldrcc	r4, [r3], #-2304	; 0xfffff700
 2e0:	14000019 	strne	r0, [r0], #-25	; 0xffffffe7
 2e4:	13490005 	movtne	r0, #36869	; 0x9005
 2e8:	2e150000 	cdpcs	0, 1, cr0, cr5, cr0, {0}
 2ec:	03193f01 	tsteq	r9, #1, 30
 2f0:	3b0b3a0e 	blcc	2ceb30 <__bss_end+0x2c59f4>
 2f4:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 2f8:	3c13490e 			; <UNDEFINED> instruction: 0x3c13490e
 2fc:	01136419 	tsteq	r3, r9, lsl r4
 300:	16000013 			; <UNDEFINED> instruction: 0x16000013
 304:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 308:	0b3a0e03 	bleq	e83b1c <__bss_end+0xe7a9e0>
 30c:	0b390b3b 	bleq	e43000 <__bss_end+0xe39ec4>
 310:	13490e6e 	movtne	r0, #40558	; 0x9e6e
 314:	193c0b32 	ldmdbne	ip!, {r1, r4, r5, r8, r9, fp}
 318:	13011364 	movwne	r1, #4964	; 0x1364
 31c:	0d170000 	ldceq	0, cr0, [r7, #-0]
 320:	3a0e0300 	bcc	380f28 <__bss_end+0x377dec>
 324:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 328:	3813490b 	ldmdacc	r3, {r0, r1, r3, r8, fp, lr}
 32c:	000b320b 	andeq	r3, fp, fp, lsl #4
 330:	012e1800 			; <UNDEFINED> instruction: 0x012e1800
 334:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 338:	0b3b0b3a 	bleq	ec3028 <__bss_end+0xeb9eec>
 33c:	0e6e0b39 	vmoveq.8	d14[5], r0
 340:	193c0b32 	ldmdbne	ip!, {r1, r4, r5, r8, r9, fp}
 344:	13011364 	movwne	r1, #4964	; 0x1364
 348:	2e190000 	cdpcs	0, 1, cr0, cr9, cr0, {0}
 34c:	03193f01 	tsteq	r9, #1, 30
 350:	3b0b3a0e 	blcc	2ceb90 <__bss_end+0x2c5a54>
 354:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 358:	3213490e 	andscc	r4, r3, #229376	; 0x38000
 35c:	64193c0b 	ldrvs	r3, [r9], #-3083	; 0xfffff3f5
 360:	1a000013 	bne	3b4 <shift+0x3b4>
 364:	13490115 	movtne	r0, #37141	; 0x9115
 368:	13011364 	movwne	r1, #4964	; 0x1364
 36c:	1f1b0000 	svcne	0x001b0000
 370:	49131d00 	ldmdbmi	r3, {r8, sl, fp, ip}
 374:	1c000013 	stcne	0, cr0, [r0], {19}
 378:	0b0b0010 	bleq	2c03c0 <__bss_end+0x2b7284>
 37c:	00001349 	andeq	r1, r0, r9, asr #6
 380:	0b000f1d 	bleq	3ffc <shift+0x3ffc>
 384:	1e00000b 	cdpne	0, 0, cr0, cr0, cr11, {0}
 388:	08030139 	stmdaeq	r3, {r0, r3, r4, r5, r8}
 38c:	0b3b0b3a 	bleq	ec307c <__bss_end+0xeb9f40>
 390:	13010b39 	movwne	r0, #6969	; 0x1b39
 394:	341f0000 	ldrcc	r0, [pc], #-0	; 39c <shift+0x39c>
 398:	3a0e0300 	bcc	380fa0 <__bss_end+0x377e64>
 39c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 3a0:	3c13490b 			; <UNDEFINED> instruction: 0x3c13490b
 3a4:	6c061c19 	stcvs	12, cr1, [r6], {25}
 3a8:	20000019 	andcs	r0, r0, r9, lsl r0
 3ac:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 3b0:	0b3b0b3a 	bleq	ec30a0 <__bss_end+0xeb9f64>
 3b4:	13490b39 	movtne	r0, #39737	; 0x9b39
 3b8:	0b1c193c 	bleq	7068b0 <__bss_end+0x6fd774>
 3bc:	0000196c 	andeq	r1, r0, ip, ror #18
 3c0:	47003421 	strmi	r3, [r0, -r1, lsr #8]
 3c4:	22000013 	andcs	r0, r0, #19
 3c8:	08030034 	stmdaeq	r3, {r2, r4, r5}
 3cc:	0b3b0b3a 	bleq	ec30bc <__bss_end+0xeb9f80>
 3d0:	13490b39 	movtne	r0, #39737	; 0x9b39
 3d4:	1802193f 	stmdane	r2, {r0, r1, r2, r3, r4, r5, r8, fp, ip}
 3d8:	34230000 	strtcc	r0, [r3], #-0
 3dc:	3a0e0300 	bcc	380fe4 <__bss_end+0x377ea8>
 3e0:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 3e4:	3f13490b 	svccc	0x0013490b
 3e8:	00180219 	andseq	r0, r8, r9, lsl r2
 3ec:	012e2400 			; <UNDEFINED> instruction: 0x012e2400
 3f0:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 3f4:	0b3b0b3a 	bleq	ec30e4 <__bss_end+0xeb9fa8>
 3f8:	13490b39 	movtne	r0, #39737	; 0x9b39
 3fc:	06120111 			; <UNDEFINED> instruction: 0x06120111
 400:	42961840 	addsmi	r1, r6, #64, 16	; 0x400000
 404:	00130119 	andseq	r0, r3, r9, lsl r1
 408:	00052500 	andeq	r2, r5, r0, lsl #10
 40c:	0b3a0e03 	bleq	e83c20 <__bss_end+0xe7aae4>
 410:	0b390b3b 	bleq	e43104 <__bss_end+0xe39fc8>
 414:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 418:	34260000 	strtcc	r0, [r6], #-0
 41c:	3a0e0300 	bcc	381024 <__bss_end+0x377ee8>
 420:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 424:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 428:	27000018 	smladcs	r0, r8, r0, r0
 42c:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 430:	0b3a0e03 	bleq	e83c44 <__bss_end+0xe7ab08>
 434:	0b390b3b 	bleq	e43128 <__bss_end+0xe39fec>
 438:	01110e6e 	tsteq	r1, lr, ror #28
 43c:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 440:	01194296 			; <UNDEFINED> instruction: 0x01194296
 444:	28000013 	stmdacs	r0, {r0, r1, r4}
 448:	193f002e 	ldmdbne	pc!, {r1, r2, r3, r5}	; <UNPREDICTABLE>
 44c:	0b3a0e03 	bleq	e83c60 <__bss_end+0xe7ab24>
 450:	0b390b3b 	bleq	e43144 <__bss_end+0xe3a008>
 454:	01110e6e 	tsteq	r1, lr, ror #28
 458:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 45c:	00194296 	mulseq	r9, r6, r2
 460:	11010000 	mrsne	r0, (UNDEF: 1)
 464:	130e2501 	movwne	r2, #58625	; 0xe501
 468:	1b0e030b 	blne	38109c <__bss_end+0x377f60>
 46c:	1201110e 	andne	r1, r1, #-2147483645	; 0x80000003
 470:	00171006 	andseq	r1, r7, r6
 474:	00240200 	eoreq	r0, r4, r0, lsl #4
 478:	0b3e0b0b 	bleq	f830ac <__bss_end+0xf79f70>
 47c:	00000e03 	andeq	r0, r0, r3, lsl #28
 480:	49002603 	stmdbmi	r0, {r0, r1, r9, sl, sp}
 484:	04000013 	streq	r0, [r0], #-19	; 0xffffffed
 488:	0b0b0024 	bleq	2c0520 <__bss_end+0x2b73e4>
 48c:	08030b3e 	stmdaeq	r3, {r1, r2, r3, r4, r5, r8, r9, fp}
 490:	16050000 	strne	r0, [r5], -r0
 494:	3a0e0300 	bcc	38109c <__bss_end+0x377f60>
 498:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 49c:	0013490b 	andseq	r4, r3, fp, lsl #18
 4a0:	01130600 	tsteq	r3, r0, lsl #12
 4a4:	0b0b0e03 	bleq	2c3cb8 <__bss_end+0x2bab7c>
 4a8:	0b3b0b3a 	bleq	ec3198 <__bss_end+0xeba05c>
 4ac:	13010b39 	movwne	r0, #6969	; 0x1b39
 4b0:	0d070000 	stceq	0, cr0, [r7, #-0]
 4b4:	3a080300 	bcc	2010bc <__bss_end+0x1f7f80>
 4b8:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 4bc:	3813490b 	ldmdacc	r3, {r0, r1, r3, r8, fp, lr}
 4c0:	0800000b 	stmdaeq	r0, {r0, r1, r3}
 4c4:	0e030104 	adfeqs	f0, f3, f4
 4c8:	0b3e196d 	bleq	f86a84 <__bss_end+0xf7d948>
 4cc:	13490b0b 	movtne	r0, #39691	; 0x9b0b
 4d0:	0b3b0b3a 	bleq	ec31c0 <__bss_end+0xeba084>
 4d4:	13010b39 	movwne	r0, #6969	; 0x1b39
 4d8:	28090000 	stmdacs	r9, {}	; <UNPREDICTABLE>
 4dc:	1c080300 	stcne	3, cr0, [r8], {-0}
 4e0:	0a00000b 	beq	514 <shift+0x514>
 4e4:	0e030028 	cdpeq	0, 0, cr0, cr3, cr8, {1}
 4e8:	00000b1c 	andeq	r0, r0, ip, lsl fp
 4ec:	0300340b 	movweq	r3, #1035	; 0x40b
 4f0:	3b0b3a0e 	blcc	2ced30 <__bss_end+0x2c5bf4>
 4f4:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 4f8:	02196c13 	andseq	r6, r9, #4864	; 0x1300
 4fc:	0c000018 	stceq	0, cr0, [r0], {24}
 500:	0e030002 	cdpeq	0, 0, cr0, cr3, cr2, {0}
 504:	0000193c 	andeq	r1, r0, ip, lsr r9
 508:	0b000f0d 	bleq	4144 <shift+0x4144>
 50c:	0013490b 	andseq	r4, r3, fp, lsl #18
 510:	000d0e00 	andeq	r0, sp, r0, lsl #28
 514:	0b3a0e03 	bleq	e83d28 <__bss_end+0xe7abec>
 518:	0b390b3b 	bleq	e4320c <__bss_end+0xe3a0d0>
 51c:	0b381349 	bleq	e05248 <__bss_end+0xdfc10c>
 520:	010f0000 	mrseq	r0, CPSR
 524:	01134901 	tsteq	r3, r1, lsl #18
 528:	10000013 	andne	r0, r0, r3, lsl r0
 52c:	13490021 	movtne	r0, #36897	; 0x9021
 530:	00000b2f 	andeq	r0, r0, pc, lsr #22
 534:	03010211 	movweq	r0, #4625	; 0x1211
 538:	3a0b0b0e 	bcc	2c3178 <__bss_end+0x2ba03c>
 53c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 540:	0013010b 	andseq	r0, r3, fp, lsl #2
 544:	012e1200 			; <UNDEFINED> instruction: 0x012e1200
 548:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 54c:	0b3b0b3a 	bleq	ec323c <__bss_end+0xeba100>
 550:	0e6e0b39 	vmoveq.8	d14[5], r0
 554:	1364193c 	cmnne	r4, #60, 18	; 0xf0000
 558:	00001301 	andeq	r1, r0, r1, lsl #6
 55c:	49000513 	stmdbmi	r0, {r0, r1, r4, r8, sl}
 560:	00193413 	andseq	r3, r9, r3, lsl r4
 564:	00051400 	andeq	r1, r5, r0, lsl #8
 568:	00001349 	andeq	r1, r0, r9, asr #6
 56c:	3f012e15 	svccc	0x00012e15
 570:	3a0e0319 	bcc	3811dc <__bss_end+0x3780a0>
 574:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 578:	490e6e0b 	stmdbmi	lr, {r0, r1, r3, r9, sl, fp, sp, lr}
 57c:	64193c13 	ldrvs	r3, [r9], #-3091	; 0xfffff3ed
 580:	00130113 	andseq	r0, r3, r3, lsl r1
 584:	012e1600 			; <UNDEFINED> instruction: 0x012e1600
 588:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 58c:	0b3b0b3a 	bleq	ec327c <__bss_end+0xeba140>
 590:	0e6e0b39 	vmoveq.8	d14[5], r0
 594:	0b321349 	bleq	c852c0 <__bss_end+0xc7c184>
 598:	1364193c 	cmnne	r4, #60, 18	; 0xf0000
 59c:	00001301 	andeq	r1, r0, r1, lsl #6
 5a0:	03000d17 	movweq	r0, #3351	; 0xd17
 5a4:	3b0b3a0e 	blcc	2cede4 <__bss_end+0x2c5ca8>
 5a8:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 5ac:	320b3813 	andcc	r3, fp, #1245184	; 0x130000
 5b0:	1800000b 	stmdane	r0, {r0, r1, r3}
 5b4:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 5b8:	0b3a0e03 	bleq	e83dcc <__bss_end+0xe7ac90>
 5bc:	0b390b3b 	bleq	e432b0 <__bss_end+0xe3a174>
 5c0:	0b320e6e 	bleq	c83f80 <__bss_end+0xc7ae44>
 5c4:	1364193c 	cmnne	r4, #60, 18	; 0xf0000
 5c8:	00001301 	andeq	r1, r0, r1, lsl #6
 5cc:	3f012e19 	svccc	0x00012e19
 5d0:	3a0e0319 	bcc	38123c <__bss_end+0x378100>
 5d4:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 5d8:	490e6e0b 	stmdbmi	lr, {r0, r1, r3, r9, sl, fp, sp, lr}
 5dc:	3c0b3213 	sfmcc	f3, 4, [fp], {19}
 5e0:	00136419 	andseq	r6, r3, r9, lsl r4
 5e4:	01151a00 	tsteq	r5, r0, lsl #20
 5e8:	13641349 	cmnne	r4, #603979777	; 0x24000001
 5ec:	00001301 	andeq	r1, r0, r1, lsl #6
 5f0:	1d001f1b 	stcne	15, cr1, [r0, #-108]	; 0xffffff94
 5f4:	00134913 	andseq	r4, r3, r3, lsl r9
 5f8:	00101c00 	andseq	r1, r0, r0, lsl #24
 5fc:	13490b0b 	movtne	r0, #39691	; 0x9b0b
 600:	0f1d0000 	svceq	0x001d0000
 604:	000b0b00 	andeq	r0, fp, r0, lsl #22
 608:	00341e00 	eorseq	r1, r4, r0, lsl #28
 60c:	0b3a0e03 	bleq	e83e20 <__bss_end+0xe7ace4>
 610:	0b390b3b 	bleq	e43304 <__bss_end+0xe3a1c8>
 614:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 618:	2e1f0000 	cdpcs	0, 1, cr0, cr15, cr0, {0}
 61c:	03193f01 	tsteq	r9, #1, 30
 620:	3b0b3a0e 	blcc	2cee60 <__bss_end+0x2c5d24>
 624:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 628:	1113490e 	tstne	r3, lr, lsl #18
 62c:	40061201 	andmi	r1, r6, r1, lsl #4
 630:	19429618 	stmdbne	r2, {r3, r4, r9, sl, ip, pc}^
 634:	00001301 	andeq	r1, r0, r1, lsl #6
 638:	03000520 	movweq	r0, #1312	; 0x520
 63c:	3b0b3a0e 	blcc	2cee7c <__bss_end+0x2c5d40>
 640:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 644:	00180213 	andseq	r0, r8, r3, lsl r2
 648:	012e2100 			; <UNDEFINED> instruction: 0x012e2100
 64c:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 650:	0b3b0b3a 	bleq	ec3340 <__bss_end+0xeba204>
 654:	0e6e0b39 	vmoveq.8	d14[5], r0
 658:	01111349 	tsteq	r1, r9, asr #6
 65c:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 660:	01194297 			; <UNDEFINED> instruction: 0x01194297
 664:	22000013 	andcs	r0, r0, #19
 668:	08030034 	stmdaeq	r3, {r2, r4, r5}
 66c:	0b3b0b3a 	bleq	ec335c <__bss_end+0xeba220>
 670:	13490b39 	movtne	r0, #39737	; 0x9b39
 674:	00001802 	andeq	r1, r0, r2, lsl #16
 678:	3f012e23 	svccc	0x00012e23
 67c:	3a0e0319 	bcc	3812e8 <__bss_end+0x3781ac>
 680:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 684:	110e6e0b 	tstne	lr, fp, lsl #28
 688:	40061201 	andmi	r1, r6, r1, lsl #4
 68c:	19429718 	stmdbne	r2, {r3, r4, r8, r9, sl, ip, pc}^
 690:	00001301 	andeq	r1, r0, r1, lsl #6
 694:	3f002e24 	svccc	0x00002e24
 698:	3a0e0319 	bcc	381304 <__bss_end+0x3781c8>
 69c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 6a0:	110e6e0b 	tstne	lr, fp, lsl #28
 6a4:	40061201 	andmi	r1, r6, r1, lsl #4
 6a8:	19429718 	stmdbne	r2, {r3, r4, r8, r9, sl, ip, pc}^
 6ac:	2e250000 	cdpcs	0, 2, cr0, cr5, cr0, {0}
 6b0:	03193f01 	tsteq	r9, #1, 30
 6b4:	3b0b3a0e 	blcc	2ceef4 <__bss_end+0x2c5db8>
 6b8:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 6bc:	1113490e 	tstne	r3, lr, lsl #18
 6c0:	40061201 	andmi	r1, r6, r1, lsl #4
 6c4:	19429718 	stmdbne	r2, {r3, r4, r8, r9, sl, ip, pc}^
 6c8:	01000000 	mrseq	r0, (UNDEF: 0)
 6cc:	0e250111 	mcreq	1, 1, r0, cr5, cr1, {0}
 6d0:	0e030b13 	vmoveq.32	d3[0], r0
 6d4:	01110e1b 	tsteq	r1, fp, lsl lr
 6d8:	17100612 			; <UNDEFINED> instruction: 0x17100612
 6dc:	39020000 	stmdbcc	r2, {}	; <UNPREDICTABLE>
 6e0:	00130101 	andseq	r0, r3, r1, lsl #2
 6e4:	00340300 	eorseq	r0, r4, r0, lsl #6
 6e8:	0b3a0e03 	bleq	e83efc <__bss_end+0xe7adc0>
 6ec:	0b390b3b 	bleq	e433e0 <__bss_end+0xe3a2a4>
 6f0:	193c1349 	ldmdbne	ip!, {r0, r3, r6, r8, r9, ip}
 6f4:	00000a1c 	andeq	r0, r0, ip, lsl sl
 6f8:	3a003a04 	bcc	ef10 <__bss_end+0x5dd4>
 6fc:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 700:	0013180b 	andseq	r1, r3, fp, lsl #16
 704:	01010500 	tsteq	r1, r0, lsl #10
 708:	13011349 	movwne	r1, #4937	; 0x1349
 70c:	21060000 	mrscs	r0, (UNDEF: 6)
 710:	2f134900 	svccs	0x00134900
 714:	0700000b 	streq	r0, [r0, -fp]
 718:	13490026 	movtne	r0, #36902	; 0x9026
 71c:	24080000 	strcs	r0, [r8], #-0
 720:	3e0b0b00 	vmlacc.f64	d0, d11, d0
 724:	000e030b 	andeq	r0, lr, fp, lsl #6
 728:	00340900 	eorseq	r0, r4, r0, lsl #18
 72c:	00001347 	andeq	r1, r0, r7, asr #6
 730:	3f012e0a 	svccc	0x00012e0a
 734:	3a0e0319 	bcc	3813a0 <__bss_end+0x378264>
 738:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 73c:	110e6e0b 	tstne	lr, fp, lsl #28
 740:	40061201 	andmi	r1, r6, r1, lsl #4
 744:	19429718 	stmdbne	r2, {r3, r4, r8, r9, sl, ip, pc}^
 748:	00001301 	andeq	r1, r0, r1, lsl #6
 74c:	0300050b 	movweq	r0, #1291	; 0x50b
 750:	3b0b3a08 	blcc	2cef78 <__bss_end+0x2c5e3c>
 754:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 758:	00180213 	andseq	r0, r8, r3, lsl r2
 75c:	00340c00 	eorseq	r0, r4, r0, lsl #24
 760:	0b3a0e03 	bleq	e83f74 <__bss_end+0xe7ae38>
 764:	0b390b3b 	bleq	e43458 <__bss_end+0xe3a31c>
 768:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 76c:	0b0d0000 	bleq	340774 <__bss_end+0x337638>
 770:	12011101 	andne	r1, r1, #1073741824	; 0x40000000
 774:	0e000006 	cdpeq	0, 0, cr0, cr0, cr6, {0}
 778:	08030034 	stmdaeq	r3, {r2, r4, r5}
 77c:	0b3b0b3a 	bleq	ec346c <__bss_end+0xeba330>
 780:	13490b39 	movtne	r0, #39737	; 0x9b39
 784:	00001802 	andeq	r1, r0, r2, lsl #16
 788:	0b000f0f 	bleq	43cc <shift+0x43cc>
 78c:	0013490b 	andseq	r4, r3, fp, lsl #18
 790:	00261000 	eoreq	r1, r6, r0
 794:	0f110000 	svceq	0x00110000
 798:	000b0b00 	andeq	r0, fp, r0, lsl #22
 79c:	00241200 	eoreq	r1, r4, r0, lsl #4
 7a0:	0b3e0b0b 	bleq	f833d4 <__bss_end+0xf7a298>
 7a4:	00000803 	andeq	r0, r0, r3, lsl #16
 7a8:	03000513 	movweq	r0, #1299	; 0x513
 7ac:	3b0b3a0e 	blcc	2cefec <__bss_end+0x2c5eb0>
 7b0:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 7b4:	00180213 	andseq	r0, r8, r3, lsl r2
 7b8:	012e1400 			; <UNDEFINED> instruction: 0x012e1400
 7bc:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 7c0:	0b3b0b3a 	bleq	ec34b0 <__bss_end+0xeba374>
 7c4:	0e6e0b39 	vmoveq.8	d14[5], r0
 7c8:	01111349 	tsteq	r1, r9, asr #6
 7cc:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 7d0:	01194297 			; <UNDEFINED> instruction: 0x01194297
 7d4:	15000013 	strne	r0, [r0, #-19]	; 0xffffffed
 7d8:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 7dc:	0b3a0e03 	bleq	e83ff0 <__bss_end+0xe7aeb4>
 7e0:	0b390b3b 	bleq	e434d4 <__bss_end+0xe3a398>
 7e4:	01110e6e 	tsteq	r1, lr, ror #28
 7e8:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 7ec:	00194296 	mulseq	r9, r6, r2
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
  74:	00000280 	andeq	r0, r0, r0, lsl #5
	...
  80:	0000001c 	andeq	r0, r0, ip, lsl r0
  84:	0bc90002 	bleq	ff240094 <__bss_end+0xff236f58>
  88:	00040000 	andeq	r0, r4, r0
  8c:	00000000 	andeq	r0, r0, r0
  90:	000084ac 	andeq	r8, r0, ip, lsr #9
  94:	0000045c 	andeq	r0, r0, ip, asr r4
	...
  a0:	0000001c 	andeq	r0, r0, ip, lsl r0
  a4:	16ec0002 	strbtne	r0, [ip], r2
  a8:	00040000 	andeq	r0, r4, r0
  ac:	00000000 	andeq	r0, r0, r0
  b0:	00008908 	andeq	r8, r0, r8, lsl #18
  b4:	000004b8 			; <UNDEFINED> instruction: 0x000004b8
	...

Disassembly of section .debug_str:

00000000 <.debug_str>:
       0:	6573552f 	ldrbvs	r5, [r3, #-1327]!	; 0xfffffad1
       4:	772f7372 			; <UNDEFINED> instruction: 0x772f7372
       8:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
       c:	2f696a72 	svccs	0x00696a72
      10:	6b736544 	blvs	1cd9528 <__bss_end+0x1cd03ec>
      14:	2f706f74 	svccs	0x00706f74
      18:	2f564146 	svccs	0x00564146
      1c:	6176614e 	cmnvs	r6, lr, asr #2
      20:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
      24:	4f2f6963 	svcmi	0x002f6963
      28:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
      2c:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
      30:	6b6c6172 	blvs	1b18600 <__bss_end+0x1b0f4c4>
      34:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
      38:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
      3c:	756f732f 	strbvc	r7, [pc, #-815]!	; fffffd15 <__bss_end+0xffff6bd9>
      40:	73656372 	cmnvc	r5, #-939524095	; 0xc8000001
      44:	6573752f 	ldrbvs	r7, [r3, #-1327]!	; 0xfffffad1
      48:	61707372 	cmnvs	r0, r2, ror r3
      4c:	632f6563 			; <UNDEFINED> instruction: 0x632f6563
      50:	2e307472 	mrccs	4, 1, r7, cr0, cr2, {3}
      54:	552f0073 	strpl	r0, [pc, #-115]!	; ffffffe9 <__bss_end+0xffff6ead>
      58:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
      5c:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
      60:	6a726574 	bvs	1c99638 <__bss_end+0x1c904fc>
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
      98:	752f7365 	strvc	r7, [pc, #-869]!	; fffffd3b <__bss_end+0xffff6bff>
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
     12c:	6a363731 	bvs	d8ddf8 <__bss_end+0xd84cbc>
     130:	732d667a 			; <UNDEFINED> instruction: 0x732d667a
     134:	616d2d20 	cmnvs	sp, r0, lsr #26
     138:	2d206d72 	stccs	13, cr6, [r0, #-456]!	; 0xfffffe38
     13c:	6372616d 	cmnvs	r2, #1073741851	; 0x4000001b
     140:	72613d68 	rsbvc	r3, r1, #104, 26	; 0x1a00
     144:	7a36766d 	bvc	d9db00 <__bss_end+0xd949c4>
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
     184:	6a757a61 	bvs	1d5eb10 <__bss_end+0x1d559d4>
     188:	2f696369 	svccs	0x00696369
     18c:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
     190:	73656d65 	cmnvc	r5, #6464	; 0x1940
     194:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
     198:	6b2d616b 	blvs	b5874c <__bss_end+0xb4f610>
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
     1e4:	2b2b4320 	blcs	ad0e6c <__bss_end+0xac7d30>
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
     260:	2b6b7a36 	blcs	1adeb40 <__bss_end+0x1ad5a04>
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
     294:	755f6962 	ldrbvc	r6, [pc, #-2402]	; fffff93a <__bss_end+0xffff67fe>
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
     324:	6b736544 	blvs	1cd983c <__bss_end+0x1cd0700>
     328:	2f706f74 	svccs	0x00706f74
     32c:	2f564146 	svccs	0x00564146
     330:	6176614e 	cmnvs	r6, lr, asr #2
     334:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
     338:	4f2f6963 	svcmi	0x002f6963
     33c:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
     340:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
     344:	6b6c6172 	blvs	1b18914 <__bss_end+0x1b0f7d8>
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
     3e8:	68637300 	stmdavs	r3!, {r8, r9, ip, sp, lr}^
     3ec:	735f6465 	cmpvc	pc, #1694498816	; 0x65000000
     3f0:	69746174 	ldmdbvs	r4!, {r2, r4, r5, r6, r8, sp, lr}^
     3f4:	72705f63 	rsbsvc	r5, r0, #396	; 0x18c
     3f8:	69726f69 	ldmdbvs	r2!, {r0, r3, r5, r6, r8, r9, sl, fp, sp, lr}^
     3fc:	5f007974 	svcpl	0x00007974
     400:	314b4e5a 	cmpcc	fp, sl, asr lr
     404:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     408:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     40c:	614d5f73 	hvcvs	54771	; 0xd5f3
     410:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     414:	47383172 			; <UNDEFINED> instruction: 0x47383172
     418:	505f7465 	subspl	r7, pc, r5, ror #8
     41c:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     420:	425f7373 	subsmi	r7, pc, #-872415231	; 0xcc000001
     424:	49505f79 	ldmdbmi	r0, {r0, r3, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     428:	006a4544 	rsbeq	r4, sl, r4, asr #10
     42c:	314e5a5f 	cmpcc	lr, pc, asr sl
     430:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     434:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     438:	614d5f73 	hvcvs	54771	; 0xd5f3
     43c:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     440:	4d393172 	ldfmis	f3, [r9, #-456]!	; 0xfffffe38
     444:	465f7061 	ldrbmi	r7, [pc], -r1, rrx
     448:	5f656c69 	svcpl	0x00656c69
     44c:	435f6f54 	cmpmi	pc, #84, 30	; 0x150
     450:	65727275 	ldrbvs	r7, [r2, #-629]!	; 0xfffffd8b
     454:	5045746e 	subpl	r7, r5, lr, ror #8
     458:	69464935 	stmdbvs	r6, {r0, r2, r4, r5, r8, fp, lr}^
     45c:	5500656c 	strpl	r6, [r0, #-1388]	; 0xfffffa94
     460:	70616d6e 	rsbvc	r6, r1, lr, ror #26
     464:	6c69465f 	stclvs	6, cr4, [r9], #-380	; 0xfffffe84
     468:	75435f65 	strbvc	r5, [r3, #-3941]	; 0xfffff09b
     46c:	6e657272 	mcrvs	2, 3, r7, cr5, cr2, {3}
     470:	78650074 	stmdavc	r5!, {r2, r4, r5, r6}^
     474:	635f7469 	cmpvs	pc, #1761607680	; 0x69000000
     478:	0065646f 	rsbeq	r6, r5, pc, ror #8
     47c:	74726175 	ldrbtvc	r6, [r2], #-373	; 0xfffffe8b
     480:	6e614800 	cdpvs	8, 6, cr4, cr1, cr0, {0}
     484:	5f656c64 	svcpl	0x00656c64
     488:	636f7250 	cmnvs	pc, #80, 4
     48c:	5f737365 	svcpl	0x00737365
     490:	00495753 	subeq	r5, r9, r3, asr r7
     494:	5f746547 	svcpl	0x00746547
     498:	65686353 	strbvs	r6, [r8, #-851]!	; 0xfffffcad
     49c:	656c7564 	strbvs	r7, [ip, #-1380]!	; 0xfffffa9c
     4a0:	6e495f72 	mcrvs	15, 2, r5, cr9, cr2, {3}
     4a4:	4d006f66 	stcmi	15, cr6, [r0, #-408]	; 0xfffffe68
     4a8:	465f7061 	ldrbmi	r7, [pc], -r1, rrx
     4ac:	5f656c69 	svcpl	0x00656c69
     4b0:	435f6f54 	cmpmi	pc, #84, 30	; 0x150
     4b4:	65727275 	ldrbvs	r7, [r2, #-629]!	; 0xfffffd8b
     4b8:	5a00746e 	bpl	1d678 <__bss_end+0x1453c>
     4bc:	69626d6f 	stmdbvs	r2!, {r0, r1, r2, r3, r5, r6, r8, sl, fp, sp, lr}^
     4c0:	656e0065 	strbvs	r0, [lr, #-101]!	; 0xffffff9b
     4c4:	52007478 	andpl	r7, r0, #120, 8	; 0x78000000
     4c8:	616e6e75 	smcvs	59109	; 0xe6e5
     4cc:	00656c62 	rsbeq	r6, r5, r2, ror #24
     4d0:	61766e49 	cmnvs	r6, r9, asr #28
     4d4:	5f64696c 	svcpl	0x0064696c
     4d8:	646e6148 	strbtvs	r6, [lr], #-328	; 0xfffffeb8
     4dc:	5200656c 	andpl	r6, r0, #108, 10	; 0x1b000000
     4e0:	696e6e75 	stmdbvs	lr!, {r0, r2, r4, r5, r6, r9, sl, fp, sp, lr}^
     4e4:	4400676e 	strmi	r6, [r0], #-1902	; 0xfffff892
     4e8:	6c646165 	stfvse	f6, [r4], #-404	; 0xfffffe6c
     4ec:	5f656e69 	svcpl	0x00656e69
     4f0:	68636e55 	stmdavs	r3!, {r0, r2, r4, r6, r9, sl, fp, sp, lr}^
     4f4:	65676e61 	strbvs	r6, [r7, #-3681]!	; 0xfffff19f
     4f8:	65470064 	strbvs	r0, [r7, #-100]	; 0xffffff9c
     4fc:	75435f74 	strbvc	r5, [r3, #-3956]	; 0xfffff08c
     500:	6e657272 	mcrvs	2, 3, r7, cr5, cr2, {3}
     504:	72505f74 	subsvc	r5, r0, #116, 30	; 0x1d0
     508:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     50c:	50470073 	subpl	r0, r7, r3, ror r0
     510:	425f4f49 	subsmi	r4, pc, #292	; 0x124
     514:	00657361 	rsbeq	r7, r5, r1, ror #6
     518:	314e5a5f 	cmpcc	lr, pc, asr sl
     51c:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     520:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     524:	614d5f73 	hvcvs	54771	; 0xd5f3
     528:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     52c:	43343172 	teqmi	r4, #-2147483620	; 0x8000001c
     530:	74616572 	strbtvc	r6, [r1], #-1394	; 0xfffffa8e
     534:	72505f65 	subsvc	r5, r0, #404	; 0x194
     538:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     53c:	68504573 	ldmdavs	r0, {r0, r1, r4, r5, r6, r8, sl, lr}^
     540:	4900626a 	stmdbmi	r0, {r1, r3, r5, r6, r9, sp, lr}
     544:	545f4332 	ldrbpl	r4, [pc], #-818	; 54c <shift+0x54c>
     548:	736e6172 	cmnvc	lr, #-2147483620	; 0x8000001c
     54c:	69746361 	ldmdbvs	r4!, {r0, r5, r6, r8, r9, sp, lr}^
     550:	4d5f6e6f 	ldclmi	14, cr6, [pc, #-444]	; 39c <shift+0x39c>
     554:	535f7861 	cmppl	pc, #6356992	; 0x610000
     558:	00657a69 	rsbeq	r7, r5, r9, ror #20
     55c:	76657270 			; <UNDEFINED> instruction: 0x76657270
     560:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     564:	4336314b 	teqmi	r6, #-1073741806	; 0xc0000012
     568:	636f7250 	cmnvs	pc, #80, 4
     56c:	5f737365 	svcpl	0x00737365
     570:	616e614d 	cmnvs	lr, sp, asr #2
     574:	31726567 	cmncc	r2, r7, ror #10
     578:	74654739 	strbtvc	r4, [r5], #-1849	; 0xfffff8c7
     57c:	7275435f 	rsbsvc	r4, r5, #2080374785	; 0x7c000001
     580:	746e6572 	strbtvc	r6, [lr], #-1394	; 0xfffffa8e
     584:	6f72505f 	svcvs	0x0072505f
     588:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     58c:	52007645 	andpl	r7, r0, #72351744	; 0x4500000
     590:	5f646165 	svcpl	0x00646165
     594:	796c6e4f 	stmdbvc	ip!, {r0, r1, r2, r3, r6, r9, sl, fp, sp, lr}^
     598:	78614d00 	stmdavc	r1!, {r8, sl, fp, lr}^
     59c:	6f72505f 	svcvs	0x0072505f
     5a0:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     5a4:	65704f5f 	ldrbvs	r4, [r0, #-3935]!	; 0xfffff0a1
     5a8:	5f64656e 	svcpl	0x0064656e
     5ac:	656c6946 	strbvs	r6, [ip, #-2374]!	; 0xfffff6ba
     5b0:	43540073 	cmpmi	r4, #115	; 0x73
     5b4:	435f5550 	cmpmi	pc, #80, 10	; 0x14000000
     5b8:	65746e6f 	ldrbvs	r6, [r4, #-3695]!	; 0xfffff191
     5bc:	5f007478 	svcpl	0x00007478
     5c0:	36314e5a 			; <UNDEFINED> instruction: 0x36314e5a
     5c4:	6f725043 	svcvs	0x00725043
     5c8:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     5cc:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     5d0:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     5d4:	68635338 	stmdavs	r3!, {r3, r4, r5, r8, r9, ip, lr}^
     5d8:	6c756465 	cfldrdvs	mvd6, [r5], #-404	; 0xfffffe6c
     5dc:	00764565 	rsbseq	r4, r6, r5, ror #10
     5e0:	69746f4e 	ldmdbvs	r4!, {r1, r2, r3, r6, r8, r9, sl, fp, sp, lr}^
     5e4:	6c417966 	mcrrvs	9, 6, r7, r1, cr6	; <UNPREDICTABLE>
     5e8:	6c42006c 	mcrrvs	0, 6, r0, r2, cr12
     5ec:	5f6b636f 	svcpl	0x006b636f
     5f0:	72727543 	rsbsvc	r7, r2, #281018368	; 0x10c00000
     5f4:	5f746e65 	svcpl	0x00746e65
     5f8:	636f7250 	cmnvs	pc, #80, 4
     5fc:	00737365 	rsbseq	r7, r3, r5, ror #6
     600:	5f746547 	svcpl	0x00746547
     604:	00444950 	subeq	r4, r4, r0, asr r9
     608:	746e6975 	strbtvc	r6, [lr], #-2421	; 0xfffff68b
     60c:	745f3233 	ldrbvc	r3, [pc], #-563	; 614 <shift+0x614>
     610:	43534200 	cmpmi	r3, #0, 4
     614:	61425f31 	cmpvs	r2, r1, lsr pc
     618:	57006573 	smlsdxpl	r0, r3, r5, r6
     61c:	00746961 	rsbseq	r6, r4, r1, ror #18
     620:	7361544e 	cmnvc	r1, #1308622848	; 0x4e000000
     624:	74535f6b 	ldrbvc	r5, [r3], #-3947	; 0xfffff095
     628:	00657461 	rsbeq	r7, r5, r1, ror #8
     62c:	65686353 	strbvs	r6, [r8, #-851]!	; 0xfffffcad
     630:	656c7564 	strbvs	r7, [ip, #-1380]!	; 0xfffffa9c
     634:	4644455f 			; <UNDEFINED> instruction: 0x4644455f
     638:	6d657400 	cfstrdvs	mvd7, [r5, #-0]
     63c:	75625f70 	strbvc	r5, [r2, #-3952]!	; 0xfffff090
     640:	42006666 	andmi	r6, r0, #106954752	; 0x6600000
     644:	6b636f6c 	blvs	18dc3fc <__bss_end+0x18d32c0>
     648:	6d006465 	cfstrsvs	mvf6, [r0, #-404]	; 0xfffffe6c
     64c:	72727543 	rsbsvc	r7, r2, #281018368	; 0x10c00000
     650:	5f746e65 	svcpl	0x00746e65
     654:	6b736154 	blvs	1cd8bac <__bss_end+0x1ccfa70>
     658:	646f4e5f 	strbtvs	r4, [pc], #-3679	; 660 <shift+0x660>
     65c:	68630065 	stmdavs	r3!, {r0, r2, r5, r6}^
     660:	745f7261 	ldrbvc	r7, [pc], #-609	; 668 <shift+0x668>
     664:	5f6b6369 	svcpl	0x006b6369
     668:	616c6564 	cmnvs	ip, r4, ror #10
     66c:	6c730079 	ldclvs	0, cr0, [r3], #-484	; 0xfffffe1c
     670:	5f706565 	svcpl	0x00706565
     674:	656d6974 	strbvs	r6, [sp, #-2420]!	; 0xfffff68c
     678:	5a5f0072 	bpl	17c0848 <__bss_end+0x17b770c>
     67c:	4336314e 	teqmi	r6, #-2147483629	; 0x80000013
     680:	636f7250 	cmnvs	pc, #80, 4
     684:	5f737365 	svcpl	0x00737365
     688:	616e614d 	cmnvs	lr, sp, asr #2
     68c:	39726567 	ldmdbcc	r2!, {r0, r1, r2, r5, r6, r8, sl, sp, lr}^
     690:	74697753 	strbtvc	r7, [r9], #-1875	; 0xfffff8ad
     694:	545f6863 	ldrbpl	r6, [pc], #-2147	; 69c <shift+0x69c>
     698:	3150456f 	cmpcc	r0, pc, ror #10
     69c:	72504338 	subsvc	r4, r0, #56, 6	; 0xe0000000
     6a0:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     6a4:	694c5f73 	stmdbvs	ip, {r0, r1, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     6a8:	4e5f7473 	mrcmi	4, 2, r7, cr15, cr3, {3}
     6ac:	0065646f 	rsbeq	r6, r5, pc, ror #8
     6b0:	5f757063 	svcpl	0x00757063
     6b4:	746e6f63 	strbtvc	r6, [lr], #-3939	; 0xfffff09d
     6b8:	00747865 	rsbseq	r7, r4, r5, ror #16
     6bc:	61657243 	cmnvs	r5, r3, asr #4
     6c0:	505f6574 	subspl	r6, pc, r4, ror r5	; <UNPREDICTABLE>
     6c4:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     6c8:	4f007373 	svcmi	0x00007373
     6cc:	006e6570 	rsbeq	r6, lr, r0, ror r5
     6d0:	656d6954 	strbvs	r6, [sp, #-2388]!	; 0xfffff6ac
     6d4:	61425f72 	hvcvs	9714	; 0x25f2
     6d8:	5f006573 	svcpl	0x00006573
     6dc:	6435315a 	ldrtvs	r3, [r5], #-346	; 0xfffffea6
     6e0:	79635f6f 	stmdbvc	r3!, {r0, r1, r2, r3, r5, r6, r8, r9, sl, fp, ip, lr}^
     6e4:	5f656c63 	svcpl	0x00656c63
     6e8:	646e6172 	strbtvs	r6, [lr], #-370	; 0xfffffe8e
     6ec:	00766d6f 	rsbseq	r6, r6, pc, ror #26
     6f0:	30315a5f 	eorscc	r5, r1, pc, asr sl
     6f4:	5f746567 	svcpl	0x00746567
     6f8:	646e6172 	strbtvs	r6, [lr], #-370	; 0xfffffe8e
     6fc:	63506d6f 	cmpvs	r0, #7104	; 0x1bc0
     700:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     704:	50433631 	subpl	r3, r3, r1, lsr r6
     708:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     70c:	4d5f7373 	ldclmi	3, cr7, [pc, #-460]	; 548 <shift+0x548>
     710:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
     714:	34317265 	ldrtcc	r7, [r1], #-613	; 0xfffffd9b
     718:	69746f4e 	ldmdbvs	r4!, {r1, r2, r3, r6, r8, r9, sl, fp, sp, lr}^
     71c:	505f7966 	subspl	r7, pc, r6, ror #18
     720:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     724:	50457373 	subpl	r7, r5, r3, ror r3
     728:	54543231 	ldrbpl	r3, [r4], #-561	; 0xfffffdcf
     72c:	5f6b7361 	svcpl	0x006b7361
     730:	75727453 	ldrbvc	r7, [r2, #-1107]!	; 0xfffffbad
     734:	47007463 	strmi	r7, [r0, -r3, ror #8]
     738:	535f7465 	cmppl	pc, #1694498816	; 0x65000000
     73c:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     740:	666e495f 			; <UNDEFINED> instruction: 0x666e495f
     744:	4f49006f 	svcmi	0x0049006f
     748:	006c7443 	rsbeq	r7, ip, r3, asr #8
     74c:	76616c73 			; <UNDEFINED> instruction: 0x76616c73
     750:	65520065 	ldrbvs	r0, [r2, #-101]	; 0xffffff9b
     754:	54006461 	strpl	r6, [r0], #-1121	; 0xfffffb9f
     758:	696d7265 	stmdbvs	sp!, {r0, r2, r5, r6, r9, ip, sp, lr}^
     75c:	6574616e 	ldrbvs	r6, [r4, #-366]!	; 0xfffffe92
     760:	746f4e00 	strbtvc	r4, [pc], #-3584	; 768 <shift+0x768>
     764:	5f796669 	svcpl	0x00796669
     768:	636f7250 	cmnvs	pc, #80, 4
     76c:	00737365 	rsbseq	r7, r3, r5, ror #6
     770:	314e5a5f 	cmpcc	lr, pc, asr sl
     774:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     778:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     77c:	614d5f73 	hvcvs	54771	; 0xd5f3
     780:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     784:	45344372 	ldrmi	r4, [r4, #-882]!	; 0xfffffc8e
     788:	65670076 	strbvs	r0, [r7, #-118]!	; 0xffffff8a
     78c:	61725f74 	cmnvs	r2, r4, ror pc
     790:	6d6f646e 	cfstrdvs	mvd6, [pc, #-440]!	; 5e0 <shift+0x5e0>
     794:	746f4e00 	strbtvc	r4, [pc], #-3584	; 79c <shift+0x79c>
     798:	00796669 	rsbseq	r6, r9, r9, ror #12
     79c:	5078614d 	rsbspl	r6, r8, sp, asr #2
     7a0:	4c687461 	cfstrdmi	mvd7, [r8], #-388	; 0xfffffe7c
     7a4:	74676e65 	strbtvc	r6, [r7], #-3685	; 0xfffff19b
     7a8:	614d0068 	cmpvs	sp, r8, rrx
     7ac:	44534678 	ldrbmi	r4, [r3], #-1656	; 0xfffff988
     7b0:	65766972 	ldrbvs	r6, [r6, #-2418]!	; 0xfffff68e
     7b4:	6d614e72 	stclvs	14, cr4, [r1, #-456]!	; 0xfffffe38
     7b8:	6e654c65 	cdpvs	12, 6, cr4, cr5, cr5, {3}
     7bc:	00687467 	rsbeq	r7, r8, r7, ror #8
     7c0:	314e5a5f 	cmpcc	lr, pc, asr sl
     7c4:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     7c8:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     7cc:	614d5f73 	hvcvs	54771	; 0xd5f3
     7d0:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     7d4:	53313172 	teqpl	r1, #-2147483620	; 0x8000001c
     7d8:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     7dc:	5f656c75 	svcpl	0x00656c75
     7e0:	76455252 			; <UNDEFINED> instruction: 0x76455252
     7e4:	65474e00 	strbvs	r4, [r7, #-3584]	; 0xfffff200
     7e8:	63535f74 	cmpvs	r3, #116, 30	; 0x1d0
     7ec:	5f646568 	svcpl	0x00646568
     7f0:	6f666e49 	svcvs	0x00666e49
     7f4:	7079545f 	rsbsvc	r5, r9, pc, asr r4
     7f8:	50470065 	subpl	r0, r7, r5, rrx
     7fc:	505f4f49 	subspl	r4, pc, r9, asr #30
     800:	435f6e69 	cmpmi	pc, #1680	; 0x690
     804:	746e756f 	strbtvc	r7, [lr], #-1391	; 0xfffffa91
     808:	73617400 	cmnvc	r1, #0, 8
     80c:	6c62006b 	stclvs	0, cr0, [r2], #-428	; 0xfffffe54
     810:	006b6e69 	rsbeq	r6, fp, r9, ror #28
     814:	6c6f6f62 	stclvs	15, cr6, [pc], #-392	; 694 <shift+0x694>
     818:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     81c:	50433631 	subpl	r3, r3, r1, lsr r6
     820:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     824:	4d5f7373 	ldclmi	3, cr7, [pc, #-460]	; 660 <shift+0x660>
     828:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
     82c:	38317265 	ldmdacc	r1!, {r0, r2, r5, r6, r9, ip, sp, lr}
     830:	5f746547 	svcpl	0x00746547
     834:	65686353 	strbvs	r6, [r8, #-851]!	; 0xfffffcad
     838:	656c7564 	strbvs	r7, [ip, #-1380]!	; 0xfffffa9c
     83c:	6e495f72 	mcrvs	15, 2, r5, cr9, cr2, {3}
     840:	32456f66 	subcc	r6, r5, #408	; 0x198
     844:	65474e30 	strbvs	r4, [r7, #-3632]	; 0xfffff1d0
     848:	63535f74 	cmpvs	r3, #116, 30	; 0x1d0
     84c:	5f646568 	svcpl	0x00646568
     850:	6f666e49 	svcvs	0x00666e49
     854:	7079545f 	rsbsvc	r5, r9, pc, asr r4
     858:	00765065 	rsbseq	r5, r6, r5, rrx
     85c:	6573552f 	ldrbvs	r5, [r3, #-1327]!	; 0xfffffad1
     860:	772f7372 			; <UNDEFINED> instruction: 0x772f7372
     864:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
     868:	2f696a72 	svccs	0x00696a72
     86c:	6b736544 	blvs	1cd9d84 <__bss_end+0x1cd0c48>
     870:	2f706f74 	svccs	0x00706f74
     874:	2f564146 	svccs	0x00564146
     878:	6176614e 	cmnvs	r6, lr, asr #2
     87c:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
     880:	4f2f6963 	svcmi	0x002f6963
     884:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
     888:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
     88c:	6b6c6172 	blvs	1b18e5c <__bss_end+0x1b0fd20>
     890:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
     894:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
     898:	756f732f 	strbvc	r7, [pc, #-815]!	; 571 <shift+0x571>
     89c:	73656372 	cmnvc	r5, #-939524095	; 0xc8000001
     8a0:	6573752f 	ldrbvs	r7, [r3, #-1327]!	; 0xfffffad1
     8a4:	61707372 	cmnvs	r0, r2, ror r3
     8a8:	682f6563 	stmdavs	pc!, {r0, r1, r5, r6, r8, sl, sp, lr}	; <UNPREDICTABLE>
     8ac:	6f6c6c65 	svcvs	0x006c6c65
     8b0:	7361745f 	cmnvc	r1, #1593835520	; 0x5f000000
     8b4:	616d2f6b 	cmnvs	sp, fp, ror #30
     8b8:	632e6e69 			; <UNDEFINED> instruction: 0x632e6e69
     8bc:	54007070 	strpl	r7, [r0], #-112	; 0xffffff90
     8c0:	5f474e52 	svcpl	0x00474e52
     8c4:	65736142 	ldrbvs	r6, [r3, #-322]!	; 0xfffffebe
     8c8:	66654400 	strbtvs	r4, [r5], -r0, lsl #8
     8cc:	746c7561 	strbtvc	r7, [ip], #-1377	; 0xfffffa9f
     8d0:	6f6c435f 	svcvs	0x006c435f
     8d4:	525f6b63 	subspl	r6, pc, #101376	; 0x18c00
     8d8:	00657461 	rsbeq	r7, r5, r1, ror #8
     8dc:	6f72506d 	svcvs	0x0072506d
     8e0:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     8e4:	73694c5f 	cmnvc	r9, #24320	; 0x5f00
     8e8:	65485f74 	strbvs	r5, [r8, #-3956]	; 0xfffff08c
     8ec:	6d006461 	cfstrsvs	mvf6, [r0, #-388]	; 0xfffffe7c
     8f0:	65686353 	strbvs	r6, [r8, #-851]!	; 0xfffffcad
     8f4:	656c7564 	strbvs	r7, [ip, #-1380]!	; 0xfffffa9c
     8f8:	636e465f 	cmnvs	lr, #99614720	; 0x5f00000
     8fc:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     900:	50433631 	subpl	r3, r3, r1, lsr r6
     904:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     908:	4d5f7373 	ldclmi	3, cr7, [pc, #-460]	; 744 <shift+0x744>
     90c:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
     910:	31327265 	teqcc	r2, r5, ror #4
     914:	636f6c42 	cmnvs	pc, #16896	; 0x4200
     918:	75435f6b 	strbvc	r5, [r3, #-3947]	; 0xfffff095
     91c:	6e657272 	mcrvs	2, 3, r7, cr5, cr2, {3}
     920:	72505f74 	subsvc	r5, r0, #116, 30	; 0x1d0
     924:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     928:	00764573 	rsbseq	r4, r6, r3, ror r5
     92c:	4e646e72 	mcrmi	14, 3, r6, cr4, cr2, {3}
     930:	4c006d75 	stcmi	13, cr6, [r0], {117}	; 0x75
     934:	5f6b636f 	svcpl	0x006b636f
     938:	6f6c6e55 	svcvs	0x006c6e55
     93c:	64656b63 	strbtvs	r6, [r5], #-2915	; 0xfffff49d
     940:	614c6d00 	cmpvs	ip, r0, lsl #26
     944:	505f7473 	subspl	r7, pc, r3, ror r4	; <UNPREDICTABLE>
     948:	53004449 	movwpl	r4, #1097	; 0x449
     94c:	63746977 	cmnvs	r4, #1949696	; 0x1dc000
     950:	6f545f68 	svcvs	0x00545f68
     954:	6f6c4300 	svcvs	0x006c4300
     958:	5f006573 	svcpl	0x00006573
     95c:	36314e5a 			; <UNDEFINED> instruction: 0x36314e5a
     960:	6f725043 	svcvs	0x00725043
     964:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     968:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     96c:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     970:	63533231 	cmpvs	r3, #268435459	; 0x10000003
     974:	75646568 	strbvc	r6, [r4, #-1384]!	; 0xfffffa98
     978:	455f656c 	ldrbmi	r6, [pc, #-1388]	; 414 <shift+0x414>
     97c:	76454644 	strbvc	r4, [r5], -r4, asr #12
     980:	43534200 	cmpmi	r3, #0, 4
     984:	61425f30 	cmpvs	r2, r0, lsr pc
     988:	5f006573 	svcpl	0x00006573
     98c:	6c62355a 	cfstr64vs	mvdx3, [r2], #-360	; 0xfffffe98
     990:	766b6e69 	strbtvc	r6, [fp], -r9, ror #28
     994:	67726100 	ldrbvs	r6, [r2, -r0, lsl #2]!
     998:	6f6e0063 	svcvs	0x006e0063
     99c:	69666974 	stmdbvs	r6!, {r2, r4, r5, r6, r8, fp, sp, lr}^
     9a0:	645f6465 	ldrbvs	r6, [pc], #-1125	; 9a8 <shift+0x9a8>
     9a4:	6c646165 	stfvse	f6, [r4], #-404	; 0xfffffe6c
     9a8:	00656e69 	rsbeq	r6, r5, r9, ror #28
     9ac:	76677261 	strbtvc	r7, [r7], -r1, ror #4
     9b0:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     9b4:	50433631 	subpl	r3, r3, r1, lsr r6
     9b8:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     9bc:	4d5f7373 	ldclmi	3, cr7, [pc, #-460]	; 7f8 <shift+0x7f8>
     9c0:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
     9c4:	34317265 	ldrtcc	r7, [r1], #-613	; 0xfffffd9b
     9c8:	69746f4e 	ldmdbvs	r4!, {r1, r2, r3, r6, r8, r9, sl, fp, sp, lr}^
     9cc:	505f7966 	subspl	r7, pc, r6, ror #18
     9d0:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     9d4:	6a457373 	bvs	115d7a8 <__bss_end+0x115466c>
     9d8:	466f4e00 	strbtmi	r4, [pc], -r0, lsl #28
     9dc:	73656c69 	cmnvc	r5, #26880	; 0x6900
     9e0:	65747379 	ldrbvs	r7, [r4, #-889]!	; 0xfffffc87
     9e4:	6972446d 	ldmdbvs	r2!, {r0, r2, r3, r5, r6, sl, lr}^
     9e8:	00726576 	rsbseq	r6, r2, r6, ror r5
     9ec:	64616544 	strbtvs	r6, [r1], #-1348	; 0xfffffabc
     9f0:	656e696c 	strbvs	r6, [lr, #-2412]!	; 0xfffff694
     9f4:	6f687300 	svcvs	0x00687300
     9f8:	69207472 	stmdbvs	r0!, {r1, r4, r5, r6, sl, ip, sp, lr}
     9fc:	4d00746e 	cfstrsmi	mvf7, [r0, #-440]	; 0xfffffe48
     a00:	69467861 	stmdbvs	r6, {r0, r5, r6, fp, ip, sp, lr}^
     a04:	616e656c 	cmnvs	lr, ip, ror #10
     a08:	654c656d 	strbvs	r6, [ip, #-1389]	; 0xfffffa93
     a0c:	6874676e 	ldmdavs	r4!, {r1, r2, r3, r5, r6, r8, r9, sl, sp, lr}^
     a10:	72504300 	subsvc	r4, r0, #0, 6
     a14:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     a18:	614d5f73 	hvcvs	54771	; 0xd5f3
     a1c:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     a20:	6f640072 	svcvs	0x00640072
     a24:	6379635f 	cmnvs	r9, #2080374785	; 0x7c000001
     a28:	725f656c 	subsvc	r6, pc, #108, 10	; 0x1b000000
     a2c:	6f646e61 	svcvs	0x00646e61
     a30:	7474006d 	ldrbtvc	r0, [r4], #-109	; 0xffffff93
     a34:	00307262 	eorseq	r7, r0, r2, ror #4
     a38:	4957534e 	ldmdbmi	r7, {r1, r2, r3, r6, r8, r9, ip, lr}^
     a3c:	6c69465f 	stclvs	6, cr4, [r9], #-380	; 0xfffffe84
     a40:	73797365 	cmnvc	r9, #-1811939327	; 0x94000001
     a44:	5f6d6574 	svcpl	0x006d6574
     a48:	76726553 			; <UNDEFINED> instruction: 0x76726553
     a4c:	00656369 	rsbeq	r6, r5, r9, ror #6
     a50:	4957534e 	ldmdbmi	r7, {r1, r2, r3, r6, r8, r9, ip, lr}^
     a54:	6f72505f 	svcvs	0x0072505f
     a58:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     a5c:	7265535f 	rsbvc	r5, r5, #2080374785	; 0x7c000001
     a60:	65636976 	strbvs	r6, [r3, #-2422]!	; 0xfffff68a
     a64:	65706f00 	ldrbvs	r6, [r0, #-3840]!	; 0xfffff100
     a68:	5f64656e 	svcpl	0x0064656e
     a6c:	656c6966 	strbvs	r6, [ip, #-2406]!	; 0xfffff69a
     a70:	69590073 	ldmdbvs	r9, {r0, r1, r4, r5, r6}^
     a74:	00646c65 	rsbeq	r6, r4, r5, ror #24
     a78:	66756277 			; <UNDEFINED> instruction: 0x66756277
     a7c:	646e4900 	strbtvs	r4, [lr], #-2304	; 0xfffff700
     a80:	6e696665 	cdpvs	6, 6, cr6, cr9, cr5, {3}
     a84:	00657469 	rsbeq	r7, r5, r9, ror #8
     a88:	5f746547 	svcpl	0x00746547
     a8c:	636f7250 	cmnvs	pc, #80, 4
     a90:	5f737365 	svcpl	0x00737365
     a94:	505f7942 	subspl	r7, pc, r2, asr #18
     a98:	50004449 	andpl	r4, r0, r9, asr #8
     a9c:	70697265 	rsbvc	r7, r9, r5, ror #4
     aa0:	61726568 	cmnvs	r2, r8, ror #10
     aa4:	61425f6c 	cmpvs	r2, ip, ror #30
     aa8:	6c006573 	cfstr32vs	mvfx6, [r0], {115}	; 0x73
     aac:	20676e6f 	rsbcs	r6, r7, pc, ror #28
     ab0:	69736e75 	ldmdbvs	r3!, {r0, r2, r4, r5, r6, r9, sl, fp, sp, lr}^
     ab4:	64656e67 	strbtvs	r6, [r5], #-3687	; 0xfffff199
     ab8:	746e6920 	strbtvc	r6, [lr], #-2336	; 0xfffff6e0
     abc:	766e4900 	strbtvc	r4, [lr], -r0, lsl #18
     ac0:	64696c61 	strbtvs	r6, [r9], #-3169	; 0xfffff39f
     ac4:	6e69505f 	mcrvs	0, 3, r5, cr9, cr15, {2}
     ac8:	73616d00 	cmnvc	r1, #0, 26
     acc:	00726574 	rsbseq	r6, r2, r4, ror r5
     ad0:	6b636f4c 	blvs	18dc808 <__bss_end+0x18d36cc>
     ad4:	636f4c5f 	cmnvs	pc, #24320	; 0x5f00
     ad8:	0064656b 	rsbeq	r6, r4, fp, ror #10
     adc:	314e5a5f 	cmpcc	lr, pc, asr sl
     ae0:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     ae4:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     ae8:	614d5f73 	hvcvs	54771	; 0xd5f3
     aec:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     af0:	48383172 	ldmdami	r8!, {r1, r4, r5, r6, r8, ip, sp}
     af4:	6c646e61 	stclvs	14, cr6, [r4], #-388	; 0xfffffe7c
     af8:	72505f65 	subsvc	r5, r0, #404	; 0x194
     afc:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     b00:	57535f73 			; <UNDEFINED> instruction: 0x57535f73
     b04:	30324549 	eorscc	r4, r2, r9, asr #10
     b08:	4957534e 	ldmdbmi	r7, {r1, r2, r3, r6, r8, r9, ip, lr}^
     b0c:	6f72505f 	svcvs	0x0072505f
     b10:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     b14:	7265535f 	rsbvc	r5, r5, #2080374785	; 0x7c000001
     b18:	65636976 	strbvs	r6, [r3, #-2422]!	; 0xfffff68a
     b1c:	526a6a6a 	rsbpl	r6, sl, #434176	; 0x6a000
     b20:	53543131 	cmppl	r4, #1073741836	; 0x4000000c
     b24:	525f4957 	subspl	r4, pc, #1425408	; 0x15c000
     b28:	6c757365 	ldclvs	3, cr7, [r5], #-404	; 0xfffffe6c
     b2c:	63730074 	cmnvs	r3, #116	; 0x74
     b30:	5f646568 	svcpl	0x00646568
     b34:	6e756f63 	cdpvs	15, 7, cr6, cr5, cr3, {3}
     b38:	00726574 	rsbseq	r6, r2, r4, ror r5
     b3c:	69736e75 	ldmdbvs	r3!, {r0, r2, r4, r5, r6, r9, sl, fp, sp, lr}^
     b40:	64656e67 	strbtvs	r6, [r5], #-3687	; 0xfffff199
     b44:	61686320 	cmnvs	r8, r0, lsr #6
     b48:	32490072 	subcc	r0, r9, #114	; 0x72
     b4c:	4c535f43 	mrrcmi	15, 4, r5, r3, cr3
     b50:	5f455641 	svcpl	0x00455641
     b54:	65736142 	ldrbvs	r6, [r3, #-322]!	; 0xfffffebe
     b58:	746e4900 	strbtvc	r4, [lr], #-2304	; 0xfffff700
     b5c:	75727265 	ldrbvc	r7, [r2, #-613]!	; 0xfffffd9b
     b60:	62617470 	rsbvs	r7, r1, #112, 8	; 0x70000000
     b64:	535f656c 	cmppl	pc, #108, 10	; 0x1b000000
     b68:	7065656c 	rsbvc	r6, r5, ip, ror #10
     b6c:	68635300 	stmdavs	r3!, {r8, r9, ip, lr}^
     b70:	6c756465 	cfldrdvs	mvd6, [r5], #-404	; 0xfffffe6c
     b74:	52525f65 	subspl	r5, r2, #404	; 0x194
     b78:	58554100 	ldmdapl	r5, {r8, lr}^
     b7c:	7361425f 	cmnvc	r1, #-268435451	; 0xf0000005
     b80:	53420065 	movtpl	r0, #8293	; 0x2065
     b84:	425f3243 	subsmi	r3, pc, #805306372	; 0x30000004
     b88:	00657361 	rsbeq	r7, r5, r1, ror #6
     b8c:	74617473 	strbtvc	r7, [r1], #-1139	; 0xfffffb8d
     b90:	72570065 	subsvc	r0, r7, #101	; 0x65
     b94:	5f657469 	svcpl	0x00657469
     b98:	796c6e4f 	stmdbvc	ip!, {r0, r1, r2, r3, r6, r9, sl, fp, sp, lr}^
     b9c:	68635300 	stmdavs	r3!, {r8, r9, ip, lr}^
     ba0:	6c756465 	cfldrdvs	mvd6, [r5], #-404	; 0xfffffe6c
     ba4:	69540065 	ldmdbvs	r4, {r0, r2, r5, r6}^
     ba8:	435f6b63 	cmpmi	pc, #101376	; 0x18c00
     bac:	746e756f 	strbtvc	r7, [lr], #-1391	; 0xfffffa91
     bb0:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     bb4:	50433631 	subpl	r3, r3, r1, lsr r6
     bb8:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     bbc:	4d5f7373 	ldclmi	3, cr7, [pc, #-460]	; 9f8 <shift+0x9f8>
     bc0:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
     bc4:	38317265 	ldmdacc	r1!, {r0, r2, r5, r6, r9, ip, sp, lr}
     bc8:	616d6e55 	cmnvs	sp, r5, asr lr
     bcc:	69465f70 	stmdbvs	r6, {r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     bd0:	435f656c 	cmpmi	pc, #108, 10	; 0x1b000000
     bd4:	65727275 	ldrbvs	r7, [r2, #-629]!	; 0xfffffd8b
     bd8:	6a45746e 	bvs	115dd98 <__bss_end+0x1154c5c>
     bdc:	6e614800 	cdpvs	8, 6, cr4, cr1, cr0, {0}
     be0:	5f656c64 	svcpl	0x00656c64
     be4:	656c6946 	strbvs	r6, [ip, #-2374]!	; 0xfffff6ba
     be8:	74737973 	ldrbtvc	r7, [r3], #-2419	; 0xfffff68d
     bec:	535f6d65 	cmppl	pc, #6464	; 0x1940
     bf0:	73004957 	movwvc	r4, #2391	; 0x957
     bf4:	74726f68 	ldrbtvc	r6, [r2], #-3944	; 0xfffff098
     bf8:	736e7520 	cmnvc	lr, #32, 10	; 0x8000000
     bfc:	656e6769 	strbvs	r6, [lr, #-1897]!	; 0xfffff897
     c00:	6e692064 	cdpvs	0, 6, cr2, cr9, cr4, {3}
     c04:	72740074 	rsbsvc	r0, r4, #116	; 0x74
     c08:	6d00676e 	stcvs	7, cr6, [r0, #-440]	; 0xfffffe48
     c0c:	006e6961 	rsbeq	r6, lr, r1, ror #18
     c10:	65746e49 	ldrbvs	r6, [r4, #-3657]!	; 0xfffff1b7
     c14:	70757272 	rsbsvc	r7, r5, r2, ror r2
     c18:	6f435f74 	svcvs	0x00435f74
     c1c:	6f72746e 	svcvs	0x0072746e
     c20:	72656c6c 	rsbvc	r6, r5, #108, 24	; 0x6c00
     c24:	7361425f 	cmnvc	r1, #-268435451	; 0xf0000005
     c28:	65520065 	ldrbvs	r0, [r2, #-101]	; 0xffffff9b
     c2c:	575f6461 	ldrbpl	r6, [pc, -r1, ror #8]
     c30:	65746972 	ldrbvs	r6, [r4, #-2418]!	; 0xfffff68e
     c34:	74634100 	strbtvc	r4, [r3], #-256	; 0xffffff00
     c38:	5f657669 	svcpl	0x00657669
     c3c:	636f7250 	cmnvs	pc, #80, 4
     c40:	5f737365 	svcpl	0x00737365
     c44:	6e756f43 	cdpvs	15, 7, cr6, cr5, cr3, {2}
     c48:	79730074 	ldmdbvc	r3!, {r2, r4, r5, r6}^
     c4c:	6c6f626d 	sfmvs	f6, 2, [pc], #-436	; aa0 <shift+0xaa0>
     c50:	6369745f 	cmnvs	r9, #1593835520	; 0x5f000000
     c54:	65645f6b 	strbvs	r5, [r4, #-3947]!	; 0xfffff095
     c58:	0079616c 	rsbseq	r6, r9, ip, ror #2
     c5c:	314e5a5f 	cmpcc	lr, pc, asr sl
     c60:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     c64:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     c68:	614d5f73 	hvcvs	54771	; 0xd5f3
     c6c:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     c70:	48313272 	ldmdami	r1!, {r1, r4, r5, r6, r9, ip, sp}
     c74:	6c646e61 	stclvs	14, cr6, [r4], #-388	; 0xfffffe7c
     c78:	69465f65 	stmdbvs	r6, {r0, r2, r5, r6, r8, r9, sl, fp, ip, lr}^
     c7c:	7973656c 	ldmdbvc	r3!, {r2, r3, r5, r6, r8, sl, sp, lr}^
     c80:	6d657473 	cfstrdvs	mvd7, [r5, #-460]!	; 0xfffffe34
     c84:	4957535f 	ldmdbmi	r7, {r0, r1, r2, r3, r4, r6, r8, r9, ip, lr}^
     c88:	4e333245 	cdpmi	2, 3, cr3, cr3, cr5, {2}
     c8c:	5f495753 	svcpl	0x00495753
     c90:	656c6946 	strbvs	r6, [ip, #-2374]!	; 0xfffff6ba
     c94:	74737973 	ldrbtvc	r7, [r3], #-2419	; 0xfffff68d
     c98:	535f6d65 	cmppl	pc, #6464	; 0x1940
     c9c:	69767265 	ldmdbvs	r6!, {r0, r2, r5, r6, r9, ip, sp, lr}^
     ca0:	6a6a6563 	bvs	1a9a234 <__bss_end+0x1a910f8>
     ca4:	3131526a 	teqcc	r1, sl, ror #4
     ca8:	49575354 	ldmdbmi	r7, {r2, r4, r6, r8, r9, ip, lr}^
     cac:	7365525f 	cmnvc	r5, #-268435451	; 0xf0000005
     cb0:	00746c75 	rsbseq	r6, r4, r5, ror ip
     cb4:	6573552f 	ldrbvs	r5, [r3, #-1327]!	; 0xfffffad1
     cb8:	772f7372 			; <UNDEFINED> instruction: 0x772f7372
     cbc:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
     cc0:	2f696a72 	svccs	0x00696a72
     cc4:	6b736544 	blvs	1cda1dc <__bss_end+0x1cd10a0>
     cc8:	2f706f74 	svccs	0x00706f74
     ccc:	2f564146 	svccs	0x00564146
     cd0:	6176614e 	cmnvs	r6, lr, asr #2
     cd4:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
     cd8:	4f2f6963 	svcmi	0x002f6963
     cdc:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
     ce0:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
     ce4:	6b6c6172 	blvs	1b192b4 <__bss_end+0x1b10178>
     ce8:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
     cec:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
     cf0:	756f732f 	strbvc	r7, [pc, #-815]!	; 9c9 <shift+0x9c9>
     cf4:	73656372 	cmnvc	r5, #-939524095	; 0xc8000001
     cf8:	6975622f 	ldmdbvs	r5!, {r0, r1, r2, r3, r5, r9, sp, lr}^
     cfc:	6300646c 	movwvs	r6, #1132	; 0x46c
     d00:	65736f6c 	ldrbvs	r6, [r3, #-3948]!	; 0xfffff094
     d04:	74655300 	strbtvc	r5, [r5], #-768	; 0xfffffd00
     d08:	6c65525f 	sfmvs	f5, 2, [r5], #-380	; 0xfffffe84
     d0c:	76697461 	strbtvc	r7, [r9], -r1, ror #8
     d10:	65720065 	ldrbvs	r0, [r2, #-101]!	; 0xffffff9b
     d14:	6c617674 	stclvs	6, cr7, [r1], #-464	; 0xfffffe30
     d18:	75636e00 	strbvc	r6, [r3, #-3584]!	; 0xfffff200
     d1c:	69700072 	ldmdbvs	r0!, {r1, r4, r5, r6}^
     d20:	72006570 	andvc	r6, r0, #112, 10	; 0x1c000000
     d24:	6d756e64 	ldclvs	14, cr6, [r5, #-400]!	; 0xfffffe70
     d28:	315a5f00 	cmpcc	sl, r0, lsl #30
     d2c:	68637331 	stmdavs	r3!, {r0, r4, r5, r8, r9, ip, sp, lr}^
     d30:	795f6465 	ldmdbvc	pc, {r0, r2, r5, r6, sl, sp, lr}^	; <UNPREDICTABLE>
     d34:	646c6569 	strbtvs	r6, [ip], #-1385	; 0xfffffa97
     d38:	5a5f0076 	bpl	17c0f18 <__bss_end+0x17b7ddc>
     d3c:	65733731 	ldrbvs	r3, [r3, #-1841]!	; 0xfffff8cf
     d40:	61745f74 	cmnvs	r4, r4, ror pc
     d44:	645f6b73 	ldrbvs	r6, [pc], #-2931	; d4c <shift+0xd4c>
     d48:	6c646165 	stfvse	f6, [r4], #-404	; 0xfffffe6c
     d4c:	6a656e69 	bvs	195c6f8 <__bss_end+0x19535bc>
     d50:	69617700 	stmdbvs	r1!, {r8, r9, sl, ip, sp, lr}^
     d54:	5a5f0074 	bpl	17c0f2c <__bss_end+0x17b7df0>
     d58:	746f6e36 	strbtvc	r6, [pc], #-3638	; d60 <shift+0xd60>
     d5c:	6a796669 	bvs	1e5a708 <__bss_end+0x1e515cc>
     d60:	6146006a 	cmpvs	r6, sl, rrx
     d64:	65006c69 	strvs	r6, [r0, #-3177]	; 0xfffff397
     d68:	63746978 	cmnvs	r4, #120, 18	; 0x1e0000
     d6c:	0065646f 	rsbeq	r6, r5, pc, ror #8
     d70:	65686373 	strbvs	r6, [r8, #-883]!	; 0xfffffc8d
     d74:	69795f64 	ldmdbvs	r9!, {r2, r5, r6, r8, r9, sl, fp, ip, lr}^
     d78:	00646c65 	rsbeq	r6, r4, r5, ror #24
     d7c:	6b636974 	blvs	18db354 <__bss_end+0x18d2218>
     d80:	756f635f 	strbvc	r6, [pc, #-863]!	; a29 <shift+0xa29>
     d84:	725f746e 	subsvc	r7, pc, #1845493760	; 0x6e000000
     d88:	69757165 	ldmdbvs	r5!, {r0, r2, r5, r6, r8, ip, sp, lr}^
     d8c:	00646572 	rsbeq	r6, r4, r2, ror r5
     d90:	34325a5f 	ldrtcc	r5, [r2], #-2655	; 0xfffff5a1
     d94:	5f746567 	svcpl	0x00746567
     d98:	69746361 	ldmdbvs	r4!, {r0, r5, r6, r8, r9, sp, lr}^
     d9c:	705f6576 	subsvc	r6, pc, r6, ror r5	; <UNPREDICTABLE>
     da0:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     da4:	635f7373 	cmpvs	pc, #-872415231	; 0xcc000001
     da8:	746e756f 	strbtvc	r7, [lr], #-1391	; 0xfffffa91
     dac:	69500076 	ldmdbvs	r0, {r1, r2, r4, r5, r6}^
     db0:	465f6570 			; <UNDEFINED> instruction: 0x465f6570
     db4:	5f656c69 	svcpl	0x00656c69
     db8:	66657250 			; <UNDEFINED> instruction: 0x66657250
     dbc:	53007869 	movwpl	r7, #2153	; 0x869
     dc0:	505f7465 	subspl	r7, pc, r5, ror #8
     dc4:	6d617261 	sfmvs	f7, 2, [r1, #-388]!	; 0xfffffe7c
     dc8:	5a5f0073 	bpl	17c0f9c <__bss_end+0x17b7e60>
     dcc:	65673431 	strbvs	r3, [r7, #-1073]!	; 0xfffffbcf
     dd0:	69745f74 	ldmdbvs	r4!, {r2, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     dd4:	635f6b63 	cmpvs	pc, #101376	; 0x18c00
     dd8:	746e756f 	strbtvc	r7, [lr], #-1391	; 0xfffffa91
     ddc:	6c730076 	ldclvs	0, cr0, [r3], #-472	; 0xfffffe28
     de0:	00706565 	rsbseq	r6, r0, r5, ror #10
     de4:	61736944 	cmnvs	r3, r4, asr #18
     de8:	5f656c62 	svcpl	0x00656c62
     dec:	6e657645 	cdpvs	6, 6, cr7, cr5, cr5, {2}
     df0:	65445f74 	strbvs	r5, [r4, #-3956]	; 0xfffff08c
     df4:	74636574 	strbtvc	r6, [r3], #-1396	; 0xfffffa8c
     df8:	006e6f69 	rsbeq	r6, lr, r9, ror #30
     dfc:	74395a5f 	ldrtvc	r5, [r9], #-2655	; 0xfffff5a1
     e00:	696d7265 	stmdbvs	sp!, {r0, r2, r5, r6, r9, ip, sp, lr}^
     e04:	6574616e 	ldrbvs	r6, [r4, #-366]!	; 0xfffffe92
     e08:	706f0069 	rsbvc	r0, pc, r9, rrx
     e0c:	74617265 	strbtvc	r7, [r1], #-613	; 0xfffffd9b
     e10:	006e6f69 	rsbeq	r6, lr, r9, ror #30
     e14:	63355a5f 	teqvs	r5, #389120	; 0x5f000
     e18:	65736f6c 	ldrbvs	r6, [r3, #-3948]!	; 0xfffff094
     e1c:	5a5f006a 	bpl	17c0fcc <__bss_end+0x17b7e90>
     e20:	74656736 	strbtvc	r6, [r5], #-1846	; 0xfffff8ca
     e24:	76646970 			; <UNDEFINED> instruction: 0x76646970
     e28:	616e6600 	cmnvs	lr, r0, lsl #12
     e2c:	7700656d 	strvc	r6, [r0, -sp, ror #10]
     e30:	65746972 	ldrbvs	r6, [r4, #-2418]!	; 0xfffff68e
     e34:	63697400 	cmnvs	r9, #0, 8
     e38:	6f00736b 	svcvs	0x0000736b
     e3c:	006e6570 	rsbeq	r6, lr, r0, ror r5
     e40:	70345a5f 	eorsvc	r5, r4, pc, asr sl
     e44:	50657069 	rsbpl	r7, r5, r9, rrx
     e48:	006a634b 	rsbeq	r6, sl, fp, asr #6
     e4c:	6165444e 	cmnvs	r5, lr, asr #8
     e50:	6e696c64 	cdpvs	12, 6, cr6, cr9, cr4, {3}
     e54:	75535f65 	ldrbvc	r5, [r3, #-3941]	; 0xfffff09b
     e58:	72657362 	rsbvc	r7, r5, #-2013265919	; 0x88000001
     e5c:	65636976 	strbvs	r6, [r3, #-2422]!	; 0xfffff68a
     e60:	74656700 	strbtvc	r6, [r5], #-1792	; 0xfffff900
     e64:	6369745f 	cmnvs	r9, #1593835520	; 0x5f000000
     e68:	6f635f6b 	svcvs	0x00635f6b
     e6c:	00746e75 	rsbseq	r6, r4, r5, ror lr
     e70:	61726170 	cmnvs	r2, r0, ror r1
     e74:	5a5f006d 	bpl	17c1030 <__bss_end+0x17b7ef4>
     e78:	69727735 	ldmdbvs	r2!, {r0, r2, r4, r5, r8, r9, sl, ip, sp, lr}^
     e7c:	506a6574 	rsbpl	r6, sl, r4, ror r5
     e80:	006a634b 	rsbeq	r6, sl, fp, asr #6
     e84:	5f746567 	svcpl	0x00746567
     e88:	6b736174 	blvs	1cd9460 <__bss_end+0x1cd0324>
     e8c:	6369745f 	cmnvs	r9, #1593835520	; 0x5f000000
     e90:	745f736b 	ldrbvc	r7, [pc], #-875	; e98 <shift+0xe98>
     e94:	65645f6f 	strbvs	r5, [r4, #-3951]!	; 0xfffff091
     e98:	696c6461 	stmdbvs	ip!, {r0, r5, r6, sl, sp, lr}^
     e9c:	6200656e 	andvs	r6, r0, #461373440	; 0x1b800000
     ea0:	735f6675 	cmpvc	pc, #122683392	; 0x7500000
     ea4:	00657a69 	rsbeq	r7, r5, r9, ror #20
     ea8:	5f746573 	svcpl	0x00746573
     eac:	6b736174 	blvs	1cd9484 <__bss_end+0x1cd0348>
     eb0:	6165645f 	cmnvs	r5, pc, asr r4
     eb4:	6e696c64 	cdpvs	12, 6, cr6, cr9, cr4, {3}
     eb8:	65470065 	strbvs	r0, [r7, #-101]	; 0xffffff9b
     ebc:	61505f74 	cmpvs	r0, r4, ror pc
     ec0:	736d6172 	cmnvc	sp, #-2147483620	; 0x8000001c
     ec4:	73552f00 	cmpvc	r5, #0, 30
     ec8:	2f737265 	svccs	0x00737265
     ecc:	746e6977 	strbtvc	r6, [lr], #-2423	; 0xfffff689
     ed0:	696a7265 	stmdbvs	sl!, {r0, r2, r5, r6, r9, ip, sp, lr}^
     ed4:	7365442f 	cmnvc	r5, #788529152	; 0x2f000000
     ed8:	706f746b 	rsbvc	r7, pc, fp, ror #8
     edc:	5641462f 	strbpl	r4, [r1], -pc, lsr #12
     ee0:	76614e2f 	strbtvc	r4, [r1], -pc, lsr #28
     ee4:	6a757a61 	bvs	1d5f870 <__bss_end+0x1d56734>
     ee8:	2f696369 	svccs	0x00696369
     eec:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
     ef0:	73656d65 	cmnvc	r5, #6464	; 0x1940
     ef4:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
     ef8:	6b2d616b 	blvs	b594ac <__bss_end+0xb50370>
     efc:	6f2d7669 	svcvs	0x002d7669
     f00:	6f732f73 	svcvs	0x00732f73
     f04:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
     f08:	74732f73 	ldrbtvc	r2, [r3], #-3955	; 0xfffff08d
     f0c:	62696c64 	rsbvs	r6, r9, #100, 24	; 0x6400
     f10:	6372732f 	cmnvs	r2, #-1140850688	; 0xbc000000
     f14:	6474732f 	ldrbtvs	r7, [r4], #-815	; 0xfffffcd1
     f18:	656c6966 	strbvs	r6, [ip, #-2406]!	; 0xfffff69a
     f1c:	7070632e 	rsbsvc	r6, r0, lr, lsr #6
     f20:	355a5f00 	ldrbcc	r5, [sl, #-3840]	; 0xfffff100
     f24:	65656c73 	strbvs	r6, [r5, #-3187]!	; 0xfffff38d
     f28:	006a6a70 	rsbeq	r6, sl, r0, ror sl
     f2c:	656c6966 	strbvs	r6, [ip, #-2406]!	; 0xfffff69a
     f30:	74654700 	strbtvc	r4, [r5], #-1792	; 0xfffff900
     f34:	6d65525f 	sfmvs	f5, 2, [r5, #-380]!	; 0xfffffe84
     f38:	696e6961 	stmdbvs	lr!, {r0, r5, r6, r8, fp, sp, lr}^
     f3c:	4500676e 	strmi	r6, [r0, #-1902]	; 0xfffff892
     f40:	6c62616e 	stfvse	f6, [r2], #-440	; 0xfffffe48
     f44:	76455f65 	strbvc	r5, [r5], -r5, ror #30
     f48:	5f746e65 	svcpl	0x00746e65
     f4c:	65746544 	ldrbvs	r6, [r4, #-1348]!	; 0xfffffabc
     f50:	6f697463 	svcvs	0x00697463
     f54:	5a5f006e 	bpl	17c1114 <__bss_end+0x17b7fd8>
     f58:	65673632 	strbvs	r3, [r7, #-1586]!	; 0xfffff9ce
     f5c:	61745f74 	cmnvs	r4, r4, ror pc
     f60:	745f6b73 	ldrbvc	r6, [pc], #-2931	; f68 <shift+0xf68>
     f64:	736b6369 	cmnvc	fp, #-1543503871	; 0xa4000001
     f68:	5f6f745f 	svcpl	0x006f745f
     f6c:	64616564 	strbtvs	r6, [r1], #-1380	; 0xfffffa9c
     f70:	656e696c 	strbvs	r6, [lr, #-2412]!	; 0xfffff694
     f74:	534e0076 	movtpl	r0, #57462	; 0xe076
     f78:	525f4957 	subspl	r4, pc, #1425408	; 0x15c000
     f7c:	6c757365 	ldclvs	3, cr7, [r5], #-404	; 0xfffffe6c
     f80:	6f435f74 	svcvs	0x00435f74
     f84:	77006564 	strvc	r6, [r0, -r4, ror #10]
     f88:	6d756e72 	ldclvs	14, cr6, [r5, #-456]!	; 0xfffffe38
     f8c:	345a5f00 	ldrbcc	r5, [sl], #-3840	; 0xfffff100
     f90:	74696177 	strbtvc	r6, [r9], #-375	; 0xfffffe89
     f94:	006a6a6a 	rsbeq	r6, sl, sl, ror #20
     f98:	69355a5f 	ldmdbvs	r5!, {r0, r1, r2, r3, r4, r6, r9, fp, ip, lr}
     f9c:	6c74636f 	ldclvs	3, cr6, [r4], #-444	; 0xfffffe44
     fa0:	4e36316a 	rsfmisz	f3, f6, #2.0
     fa4:	74434f49 	strbvc	r4, [r3], #-3913	; 0xfffff0b7
     fa8:	704f5f6c 	subvc	r5, pc, ip, ror #30
     fac:	74617265 	strbtvc	r7, [r1], #-613	; 0xfffffd9b
     fb0:	506e6f69 	rsbpl	r6, lr, r9, ror #30
     fb4:	6f690076 	svcvs	0x00690076
     fb8:	006c7463 	rsbeq	r7, ip, r3, ror #8
     fbc:	63746572 	cmnvs	r4, #478150656	; 0x1c800000
     fc0:	6e00746e 	cdpvs	4, 0, cr7, cr0, cr14, {3}
     fc4:	6669746f 	strbtvs	r7, [r9], -pc, ror #8
     fc8:	65740079 	ldrbvs	r0, [r4, #-121]!	; 0xffffff87
     fcc:	6e696d72 	mcrvs	13, 3, r6, cr9, cr2, {3}
     fd0:	00657461 	rsbeq	r7, r5, r1, ror #8
     fd4:	65646f6d 	strbvs	r6, [r4, #-3949]!	; 0xfffff093
     fd8:	66756200 	ldrbtvs	r6, [r5], -r0, lsl #4
     fdc:	00726566 	rsbseq	r6, r2, r6, ror #10
     fe0:	72345a5f 	eorsvc	r5, r4, #389120	; 0x5f000
     fe4:	6a646165 	bvs	1919580 <__bss_end+0x1910444>
     fe8:	006a6350 	rsbeq	r6, sl, r0, asr r3
     fec:	20554e47 	subscs	r4, r5, r7, asr #28
     ff0:	312b2b43 			; <UNDEFINED> instruction: 0x312b2b43
     ff4:	30312034 	eorscc	r2, r1, r4, lsr r0
     ff8:	312e332e 			; <UNDEFINED> instruction: 0x312e332e
     ffc:	32303220 	eorscc	r3, r0, #32, 4
    1000:	32383031 	eorscc	r3, r8, #49	; 0x31
    1004:	72282034 	eorvc	r2, r8, #52	; 0x34
    1008:	61656c65 	cmnvs	r5, r5, ror #24
    100c:	20296573 	eorcs	r6, r9, r3, ror r5
    1010:	6c666d2d 	stclvs	13, cr6, [r6], #-180	; 0xffffff4c
    1014:	2d74616f 	ldfcse	f6, [r4, #-444]!	; 0xfffffe44
    1018:	3d696261 	sfmcc	f6, 2, [r9, #-388]!	; 0xfffffe7c
    101c:	64726168 	ldrbtvs	r6, [r2], #-360	; 0xfffffe98
    1020:	666d2d20 	strbtvs	r2, [sp], -r0, lsr #26
    1024:	763d7570 			; <UNDEFINED> instruction: 0x763d7570
    1028:	2d207066 	stccs	0, cr7, [r0, #-408]!	; 0xfffffe68
    102c:	6f6c666d 	svcvs	0x006c666d
    1030:	612d7461 			; <UNDEFINED> instruction: 0x612d7461
    1034:	683d6962 	ldmdavs	sp!, {r1, r5, r6, r8, fp, sp, lr}
    1038:	20647261 	rsbcs	r7, r4, r1, ror #4
    103c:	70666d2d 	rsbvc	r6, r6, sp, lsr #26
    1040:	66763d75 			; <UNDEFINED> instruction: 0x66763d75
    1044:	6d2d2070 	stcvs	0, cr2, [sp, #-448]!	; 0xfffffe40
    1048:	656e7574 	strbvs	r7, [lr, #-1396]!	; 0xfffffa8c
    104c:	6d72613d 	ldfvse	f6, [r2, #-244]!	; 0xffffff0c
    1050:	36373131 			; <UNDEFINED> instruction: 0x36373131
    1054:	2d667a6a 	vstmdbcs	r6!, {s15-s120}
    1058:	6d2d2073 	stcvs	0, cr2, [sp, #-460]!	; 0xfffffe34
    105c:	206d7261 	rsbcs	r7, sp, r1, ror #4
    1060:	72616d2d 	rsbvc	r6, r1, #2880	; 0xb40
    1064:	613d6863 	teqvs	sp, r3, ror #16
    1068:	36766d72 			; <UNDEFINED> instruction: 0x36766d72
    106c:	662b6b7a 			; <UNDEFINED> instruction: 0x662b6b7a
    1070:	672d2070 			; <UNDEFINED> instruction: 0x672d2070
    1074:	20672d20 	rsbcs	r2, r7, r0, lsr #26
    1078:	2d20672d 	stccs	7, cr6, [r0, #-180]!	; 0xffffff4c
    107c:	2d20304f 	stccs	0, cr3, [r0, #-316]!	; 0xfffffec4
    1080:	2d20304f 	stccs	0, cr3, [r0, #-316]!	; 0xfffffec4
    1084:	2d6f6e66 	stclcs	14, cr6, [pc, #-408]!	; ef4 <shift+0xef4>
    1088:	65637865 	strbvs	r7, [r3, #-2149]!	; 0xfffff79b
    108c:	6f697470 	svcvs	0x00697470
    1090:	2d20736e 	stccs	3, cr7, [r0, #-440]!	; 0xfffffe48
    1094:	2d6f6e66 	stclcs	14, cr6, [pc, #-408]!	; f04 <shift+0xf04>
    1098:	69747472 	ldmdbvs	r4!, {r1, r4, r5, r6, sl, ip, sp, lr}^
    109c:	4f494e00 	svcmi	0x00494e00
    10a0:	5f6c7443 	svcpl	0x006c7443
    10a4:	7265704f 	rsbvc	r7, r5, #79	; 0x4f
    10a8:	6f697461 	svcvs	0x00697461
    10ac:	6572006e 	ldrbvs	r0, [r2, #-110]!	; 0xffffff92
    10b0:	646f6374 	strbtvs	r6, [pc], #-884	; 10b8 <shift+0x10b8>
    10b4:	65670065 	strbvs	r0, [r7, #-101]!	; 0xffffff9b
    10b8:	63615f74 	cmnvs	r1, #116, 30	; 0x1d0
    10bc:	65766974 	ldrbvs	r6, [r6, #-2420]!	; 0xfffff68c
    10c0:	6f72705f 	svcvs	0x0072705f
    10c4:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
    10c8:	756f635f 	strbvc	r6, [pc, #-863]!	; d71 <shift+0xd71>
    10cc:	6600746e 	strvs	r7, [r0], -lr, ror #8
    10d0:	6e656c69 	cdpvs	12, 6, cr6, cr5, cr9, {3}
    10d4:	00656d61 	rsbeq	r6, r5, r1, ror #26
    10d8:	64616572 	strbtvs	r6, [r1], #-1394	; 0xfffffa8e
    10dc:	74656700 	strbtvc	r6, [r5], #-1792	; 0xfffff900
    10e0:	00646970 	rsbeq	r6, r4, r0, ror r9
    10e4:	6f345a5f 	svcvs	0x00345a5f
    10e8:	506e6570 	rsbpl	r6, lr, r0, ror r5
    10ec:	3531634b 	ldrcc	r6, [r1, #-843]!	; 0xfffffcb5
    10f0:	6c69464e 	stclvs	6, cr4, [r9], #-312	; 0xfffffec8
    10f4:	704f5f65 	subvc	r5, pc, r5, ror #30
    10f8:	4d5f6e65 	ldclmi	14, cr6, [pc, #-404]	; f6c <shift+0xf6c>
    10fc:	0065646f 	rsbeq	r6, r5, pc, ror #8
    1100:	75706e69 	ldrbvc	r6, [r0, #-3689]!	; 0xfffff197
    1104:	65640074 	strbvs	r0, [r4, #-116]!	; 0xffffff8c
    1108:	62007473 	andvs	r7, r0, #1929379840	; 0x73000000
    110c:	6f72657a 	svcvs	0x0072657a
    1110:	6e656c00 	cdpvs	12, 6, cr6, cr5, cr0, {0}
    1114:	00687467 	rsbeq	r7, r8, r7, ror #8
    1118:	62355a5f 	eorsvs	r5, r5, #389120	; 0x5f000
    111c:	6f72657a 	svcvs	0x0072657a
    1120:	00697650 	rsbeq	r7, r9, r0, asr r6
    1124:	6573552f 	ldrbvs	r5, [r3, #-1327]!	; 0xfffffad1
    1128:	772f7372 			; <UNDEFINED> instruction: 0x772f7372
    112c:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
    1130:	2f696a72 	svccs	0x00696a72
    1134:	6b736544 	blvs	1cda64c <__bss_end+0x1cd1510>
    1138:	2f706f74 	svccs	0x00706f74
    113c:	2f564146 	svccs	0x00564146
    1140:	6176614e 	cmnvs	r6, lr, asr #2
    1144:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
    1148:	4f2f6963 	svcmi	0x002f6963
    114c:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
    1150:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
    1154:	6b6c6172 	blvs	1b19724 <__bss_end+0x1b105e8>
    1158:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
    115c:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
    1160:	756f732f 	strbvc	r7, [pc, #-815]!	; e39 <shift+0xe39>
    1164:	73656372 	cmnvc	r5, #-939524095	; 0xc8000001
    1168:	6474732f 	ldrbtvs	r7, [r4], #-815	; 0xfffffcd1
    116c:	2f62696c 	svccs	0x0062696c
    1170:	2f637273 	svccs	0x00637273
    1174:	73647473 	cmnvc	r4, #1929379840	; 0x73000000
    1178:	6e697274 	mcrvs	2, 3, r7, cr9, cr4, {3}
    117c:	70632e67 	rsbvc	r2, r3, r7, ror #28
    1180:	5a5f0070 	bpl	17c1348 <__bss_end+0x17b820c>
    1184:	6f746134 	svcvs	0x00746134
    1188:	634b5069 	movtvs	r5, #45161	; 0xb069
    118c:	61684300 	cmnvs	r8, r0, lsl #6
    1190:	6e6f4372 	mcrvs	3, 3, r4, cr15, cr2, {3}
    1194:	72724176 	rsbsvc	r4, r2, #-2147483619	; 0x8000001d
    1198:	6d656d00 	stclvs	13, cr6, [r5, #-0]
    119c:	00747364 	rsbseq	r7, r4, r4, ror #6
    11a0:	7074756f 	rsbsvc	r7, r4, pc, ror #10
    11a4:	5f007475 	svcpl	0x00007475
    11a8:	656d365a 	strbvs	r3, [sp, #-1626]!	; 0xfffff9a6
    11ac:	7970636d 	ldmdbvc	r0!, {r0, r2, r3, r5, r6, r8, r9, sp, lr}^
    11b0:	50764b50 	rsbspl	r4, r6, r0, asr fp
    11b4:	62006976 	andvs	r6, r0, #1933312	; 0x1d8000
    11b8:	00657361 	rsbeq	r7, r5, r1, ror #6
    11bc:	636d656d 	cmnvs	sp, #457179136	; 0x1b400000
    11c0:	73007970 	movwvc	r7, #2416	; 0x970
    11c4:	656c7274 	strbvs	r7, [ip, #-628]!	; 0xfffffd8c
    11c8:	5a5f006e 	bpl	17c1388 <__bss_end+0x17b824c>
    11cc:	72747337 	rsbsvc	r7, r4, #-603979776	; 0xdc000000
    11d0:	706d636e 	rsbvc	r6, sp, lr, ror #6
    11d4:	53634b50 	cmnpl	r3, #80, 22	; 0x14000
    11d8:	00695f30 	rsbeq	r5, r9, r0, lsr pc
    11dc:	73365a5f 	teqvc	r6, #389120	; 0x5f000
    11e0:	656c7274 	strbvs	r7, [ip, #-628]!	; 0xfffffd8c
    11e4:	634b506e 	movtvs	r5, #45166	; 0xb06e
    11e8:	6f746100 	svcvs	0x00746100
    11ec:	5a5f0069 	bpl	17c1398 <__bss_end+0x17b825c>
    11f0:	72747337 	rsbsvc	r7, r4, #-603979776	; 0xdc000000
    11f4:	7970636e 	ldmdbvc	r0!, {r1, r2, r3, r5, r6, r8, r9, sp, lr}^
    11f8:	4b506350 	blmi	1419f40 <__bss_end+0x1410e04>
    11fc:	73006963 	movwvc	r6, #2403	; 0x963
    1200:	636e7274 	cmnvs	lr, #116, 4	; 0x40000007
    1204:	7300706d 	movwvc	r7, #109	; 0x6d
    1208:	636e7274 	cmnvs	lr, #116, 4	; 0x40000007
    120c:	6d007970 	vstrvs.16	s14, [r0, #-224]	; 0xffffff20	; <UNPREDICTABLE>
    1210:	726f6d65 	rsbvc	r6, pc, #6464	; 0x1940
    1214:	656d0079 	strbvs	r0, [sp, #-121]!	; 0xffffff87
    1218:	6372736d 	cmnvs	r2, #-1275068415	; 0xb4000001
    121c:	6f746900 	svcvs	0x00746900
    1220:	5a5f0061 	bpl	17c13ac <__bss_end+0x17b8270>
    1224:	6f746934 	svcvs	0x00746934
    1228:	63506a61 	cmpvs	r0, #397312	; 0x61000
    122c:	Address 0x000000000000122c is out of bounds.


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
  20:	8b040e42 	blhi	103930 <__bss_end+0xfa7f4>
  24:	0b0d4201 	bleq	350830 <__bss_end+0x3476f4>
  28:	420d0d62 	andmi	r0, sp, #6272	; 0x1880
  2c:	00000ecb 	andeq	r0, r0, fp, asr #29
  30:	0000001c 	andeq	r0, r0, ip, lsl r0
  34:	00000000 	andeq	r0, r0, r0
  38:	00008064 	andeq	r8, r0, r4, rrx
  3c:	00000040 	andeq	r0, r0, r0, asr #32
  40:	8b080e42 	blhi	203950 <__bss_end+0x1fa814>
  44:	42018e02 	andmi	r8, r1, #2, 28
  48:	5a040b0c 	bpl	102c80 <__bss_end+0xf9b44>
  4c:	00080d0c 	andeq	r0, r8, ip, lsl #26
  50:	0000000c 	andeq	r0, r0, ip
  54:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
  58:	7c020001 	stcvc	0, cr0, [r2], {1}
  5c:	000d0c0e 	andeq	r0, sp, lr, lsl #24
  60:	0000001c 	andeq	r0, r0, ip, lsl r0
  64:	00000050 	andeq	r0, r0, r0, asr r0
  68:	000080a4 	andeq	r8, r0, r4, lsr #1
  6c:	00000038 	andeq	r0, r0, r8, lsr r0
  70:	8b040e42 	blhi	103980 <__bss_end+0xfa844>
  74:	0b0d4201 	bleq	350880 <__bss_end+0x347744>
  78:	420d0d54 	andmi	r0, sp, #84, 26	; 0x1500
  7c:	00000ecb 	andeq	r0, r0, fp, asr #29
  80:	0000001c 	andeq	r0, r0, ip, lsl r0
  84:	00000050 	andeq	r0, r0, r0, asr r0
  88:	000080dc 	ldrdeq	r8, [r0], -ip
  8c:	0000002c 	andeq	r0, r0, ip, lsr #32
  90:	8b040e42 	blhi	1039a0 <__bss_end+0xfa864>
  94:	0b0d4201 	bleq	3508a0 <__bss_end+0x347764>
  98:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
  9c:	00000ecb 	andeq	r0, r0, fp, asr #29
  a0:	0000001c 	andeq	r0, r0, ip, lsl r0
  a4:	00000050 	andeq	r0, r0, r0, asr r0
  a8:	00008108 	andeq	r8, r0, r8, lsl #2
  ac:	00000020 	andeq	r0, r0, r0, lsr #32
  b0:	8b040e42 	blhi	1039c0 <__bss_end+0xfa884>
  b4:	0b0d4201 	bleq	3508c0 <__bss_end+0x347784>
  b8:	420d0d48 	andmi	r0, sp, #72, 26	; 0x1200
  bc:	00000ecb 	andeq	r0, r0, fp, asr #29
  c0:	0000001c 	andeq	r0, r0, ip, lsl r0
  c4:	00000050 	andeq	r0, r0, r0, asr r0
  c8:	00008128 	andeq	r8, r0, r8, lsr #2
  cc:	00000018 	andeq	r0, r0, r8, lsl r0
  d0:	8b040e42 	blhi	1039e0 <__bss_end+0xfa8a4>
  d4:	0b0d4201 	bleq	3508e0 <__bss_end+0x3477a4>
  d8:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
  dc:	00000ecb 	andeq	r0, r0, fp, asr #29
  e0:	0000001c 	andeq	r0, r0, ip, lsl r0
  e4:	00000050 	andeq	r0, r0, r0, asr r0
  e8:	00008140 	andeq	r8, r0, r0, asr #2
  ec:	00000018 	andeq	r0, r0, r8, lsl r0
  f0:	8b040e42 	blhi	103a00 <__bss_end+0xfa8c4>
  f4:	0b0d4201 	bleq	350900 <__bss_end+0x3477c4>
  f8:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
  fc:	00000ecb 	andeq	r0, r0, fp, asr #29
 100:	0000001c 	andeq	r0, r0, ip, lsl r0
 104:	00000050 	andeq	r0, r0, r0, asr r0
 108:	00008158 	andeq	r8, r0, r8, asr r1
 10c:	00000018 	andeq	r0, r0, r8, lsl r0
 110:	8b040e42 	blhi	103a20 <__bss_end+0xfa8e4>
 114:	0b0d4201 	bleq	350920 <__bss_end+0x3477e4>
 118:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
 11c:	00000ecb 	andeq	r0, r0, fp, asr #29
 120:	00000014 	andeq	r0, r0, r4, lsl r0
 124:	00000050 	andeq	r0, r0, r0, asr r0
 128:	00008170 	andeq	r8, r0, r0, ror r1
 12c:	0000000c 	andeq	r0, r0, ip
 130:	8b040e42 	blhi	103a40 <__bss_end+0xfa904>
 134:	0b0d4201 	bleq	350940 <__bss_end+0x347804>
 138:	0000001c 	andeq	r0, r0, ip, lsl r0
 13c:	00000050 	andeq	r0, r0, r0, asr r0
 140:	0000817c 	andeq	r8, r0, ip, ror r1
 144:	00000058 	andeq	r0, r0, r8, asr r0
 148:	8b080e42 	blhi	203a58 <__bss_end+0x1fa91c>
 14c:	42018e02 	andmi	r8, r1, #2, 28
 150:	62040b0c 	andvs	r0, r4, #12, 22	; 0x3000
 154:	00080d0c 	andeq	r0, r8, ip, lsl #26
 158:	0000001c 	andeq	r0, r0, ip, lsl r0
 15c:	00000050 	andeq	r0, r0, r0, asr r0
 160:	000081d4 	ldrdeq	r8, [r0], -r4
 164:	00000058 	andeq	r0, r0, r8, asr r0
 168:	8b080e42 	blhi	203a78 <__bss_end+0x1fa93c>
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
 198:	8b080e42 	blhi	203aa8 <__bss_end+0x1fa96c>
 19c:	42018e02 	andmi	r8, r1, #2, 28
 1a0:	00040b0c 	andeq	r0, r4, ip, lsl #22
 1a4:	0000001c 	andeq	r0, r0, ip, lsl r0
 1a8:	00000178 	andeq	r0, r0, r8, ror r1
 1ac:	00008284 	andeq	r8, r0, r4, lsl #5
 1b0:	00000038 	andeq	r0, r0, r8, lsr r0
 1b4:	8b080e42 	blhi	203ac4 <__bss_end+0x1fa988>
 1b8:	42018e02 	andmi	r8, r1, #2, 28
 1bc:	54040b0c 	strpl	r0, [r4], #-2828	; 0xfffff4f4
 1c0:	00080d0c 	andeq	r0, r8, ip, lsl #26
 1c4:	00000020 	andeq	r0, r0, r0, lsr #32
 1c8:	00000178 	andeq	r0, r0, r8, ror r1
 1cc:	000082bc 			; <UNDEFINED> instruction: 0x000082bc
 1d0:	0000009c 	muleq	r0, ip, r0
 1d4:	840c0e42 	strhi	r0, [ip], #-3650	; 0xfffff1be
 1d8:	8e028b03 	vmlahi.f64	d8, d2, d3
 1dc:	0b0c4201 	bleq	3109e8 <__bss_end+0x3078ac>
 1e0:	0c440204 	sfmeq	f0, 2, [r4], {4}
 1e4:	00000c0d 	andeq	r0, r0, sp, lsl #24
 1e8:	0000001c 	andeq	r0, r0, ip, lsl r0
 1ec:	00000178 	andeq	r0, r0, r8, ror r1
 1f0:	00008358 	andeq	r8, r0, r8, asr r3
 1f4:	00000154 	andeq	r0, r0, r4, asr r1
 1f8:	8b080e42 	blhi	203b08 <__bss_end+0x1fa9cc>
 1fc:	42018e02 	andmi	r8, r1, #2, 28
 200:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 204:	080d0c8c 	stmdaeq	sp, {r2, r3, r7, sl, fp}
 208:	0000000c 	andeq	r0, r0, ip
 20c:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 210:	7c020001 	stcvc	0, cr0, [r2], {1}
 214:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 218:	0000001c 	andeq	r0, r0, ip, lsl r0
 21c:	00000208 	andeq	r0, r0, r8, lsl #4
 220:	000084ac 	andeq	r8, r0, ip, lsr #9
 224:	0000002c 	andeq	r0, r0, ip, lsr #32
 228:	8b040e42 	blhi	103b38 <__bss_end+0xfa9fc>
 22c:	0b0d4201 	bleq	350a38 <__bss_end+0x3478fc>
 230:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
 234:	00000ecb 	andeq	r0, r0, fp, asr #29
 238:	0000001c 	andeq	r0, r0, ip, lsl r0
 23c:	00000208 	andeq	r0, r0, r8, lsl #4
 240:	000084d8 	ldrdeq	r8, [r0], -r8	; <UNPREDICTABLE>
 244:	0000002c 	andeq	r0, r0, ip, lsr #32
 248:	8b040e42 	blhi	103b58 <__bss_end+0xfaa1c>
 24c:	0b0d4201 	bleq	350a58 <__bss_end+0x34791c>
 250:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
 254:	00000ecb 	andeq	r0, r0, fp, asr #29
 258:	0000001c 	andeq	r0, r0, ip, lsl r0
 25c:	00000208 	andeq	r0, r0, r8, lsl #4
 260:	00008504 	andeq	r8, r0, r4, lsl #10
 264:	0000001c 	andeq	r0, r0, ip, lsl r0
 268:	8b040e42 	blhi	103b78 <__bss_end+0xfaa3c>
 26c:	0b0d4201 	bleq	350a78 <__bss_end+0x34793c>
 270:	420d0d46 	andmi	r0, sp, #4480	; 0x1180
 274:	00000ecb 	andeq	r0, r0, fp, asr #29
 278:	0000001c 	andeq	r0, r0, ip, lsl r0
 27c:	00000208 	andeq	r0, r0, r8, lsl #4
 280:	00008520 	andeq	r8, r0, r0, lsr #10
 284:	00000044 	andeq	r0, r0, r4, asr #32
 288:	8b040e42 	blhi	103b98 <__bss_end+0xfaa5c>
 28c:	0b0d4201 	bleq	350a98 <__bss_end+0x34795c>
 290:	420d0d5a 	andmi	r0, sp, #5760	; 0x1680
 294:	00000ecb 	andeq	r0, r0, fp, asr #29
 298:	0000001c 	andeq	r0, r0, ip, lsl r0
 29c:	00000208 	andeq	r0, r0, r8, lsl #4
 2a0:	00008564 	andeq	r8, r0, r4, ror #10
 2a4:	00000050 	andeq	r0, r0, r0, asr r0
 2a8:	8b040e42 	blhi	103bb8 <__bss_end+0xfaa7c>
 2ac:	0b0d4201 	bleq	350ab8 <__bss_end+0x34797c>
 2b0:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 2b4:	00000ecb 	andeq	r0, r0, fp, asr #29
 2b8:	0000001c 	andeq	r0, r0, ip, lsl r0
 2bc:	00000208 	andeq	r0, r0, r8, lsl #4
 2c0:	000085b4 			; <UNDEFINED> instruction: 0x000085b4
 2c4:	00000050 	andeq	r0, r0, r0, asr r0
 2c8:	8b040e42 	blhi	103bd8 <__bss_end+0xfaa9c>
 2cc:	0b0d4201 	bleq	350ad8 <__bss_end+0x34799c>
 2d0:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 2d4:	00000ecb 	andeq	r0, r0, fp, asr #29
 2d8:	0000001c 	andeq	r0, r0, ip, lsl r0
 2dc:	00000208 	andeq	r0, r0, r8, lsl #4
 2e0:	00008604 	andeq	r8, r0, r4, lsl #12
 2e4:	0000002c 	andeq	r0, r0, ip, lsr #32
 2e8:	8b040e42 	blhi	103bf8 <__bss_end+0xfaabc>
 2ec:	0b0d4201 	bleq	350af8 <__bss_end+0x3479bc>
 2f0:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
 2f4:	00000ecb 	andeq	r0, r0, fp, asr #29
 2f8:	0000001c 	andeq	r0, r0, ip, lsl r0
 2fc:	00000208 	andeq	r0, r0, r8, lsl #4
 300:	00008630 	andeq	r8, r0, r0, lsr r6
 304:	00000050 	andeq	r0, r0, r0, asr r0
 308:	8b040e42 	blhi	103c18 <__bss_end+0xfaadc>
 30c:	0b0d4201 	bleq	350b18 <__bss_end+0x3479dc>
 310:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 314:	00000ecb 	andeq	r0, r0, fp, asr #29
 318:	0000001c 	andeq	r0, r0, ip, lsl r0
 31c:	00000208 	andeq	r0, r0, r8, lsl #4
 320:	00008680 	andeq	r8, r0, r0, lsl #13
 324:	00000044 	andeq	r0, r0, r4, asr #32
 328:	8b040e42 	blhi	103c38 <__bss_end+0xfaafc>
 32c:	0b0d4201 	bleq	350b38 <__bss_end+0x3479fc>
 330:	420d0d5a 	andmi	r0, sp, #5760	; 0x1680
 334:	00000ecb 	andeq	r0, r0, fp, asr #29
 338:	0000001c 	andeq	r0, r0, ip, lsl r0
 33c:	00000208 	andeq	r0, r0, r8, lsl #4
 340:	000086c4 	andeq	r8, r0, r4, asr #13
 344:	00000050 	andeq	r0, r0, r0, asr r0
 348:	8b040e42 	blhi	103c58 <__bss_end+0xfab1c>
 34c:	0b0d4201 	bleq	350b58 <__bss_end+0x347a1c>
 350:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 354:	00000ecb 	andeq	r0, r0, fp, asr #29
 358:	0000001c 	andeq	r0, r0, ip, lsl r0
 35c:	00000208 	andeq	r0, r0, r8, lsl #4
 360:	00008714 	andeq	r8, r0, r4, lsl r7
 364:	00000054 	andeq	r0, r0, r4, asr r0
 368:	8b040e42 	blhi	103c78 <__bss_end+0xfab3c>
 36c:	0b0d4201 	bleq	350b78 <__bss_end+0x347a3c>
 370:	420d0d62 	andmi	r0, sp, #6272	; 0x1880
 374:	00000ecb 	andeq	r0, r0, fp, asr #29
 378:	0000001c 	andeq	r0, r0, ip, lsl r0
 37c:	00000208 	andeq	r0, r0, r8, lsl #4
 380:	00008768 	andeq	r8, r0, r8, ror #14
 384:	0000003c 	andeq	r0, r0, ip, lsr r0
 388:	8b040e42 	blhi	103c98 <__bss_end+0xfab5c>
 38c:	0b0d4201 	bleq	350b98 <__bss_end+0x347a5c>
 390:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 394:	00000ecb 	andeq	r0, r0, fp, asr #29
 398:	0000001c 	andeq	r0, r0, ip, lsl r0
 39c:	00000208 	andeq	r0, r0, r8, lsl #4
 3a0:	000087a4 	andeq	r8, r0, r4, lsr #15
 3a4:	0000003c 	andeq	r0, r0, ip, lsr r0
 3a8:	8b040e42 	blhi	103cb8 <__bss_end+0xfab7c>
 3ac:	0b0d4201 	bleq	350bb8 <__bss_end+0x347a7c>
 3b0:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 3b4:	00000ecb 	andeq	r0, r0, fp, asr #29
 3b8:	0000001c 	andeq	r0, r0, ip, lsl r0
 3bc:	00000208 	andeq	r0, r0, r8, lsl #4
 3c0:	000087e0 	andeq	r8, r0, r0, ror #15
 3c4:	0000003c 	andeq	r0, r0, ip, lsr r0
 3c8:	8b040e42 	blhi	103cd8 <__bss_end+0xfab9c>
 3cc:	0b0d4201 	bleq	350bd8 <__bss_end+0x347a9c>
 3d0:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 3d4:	00000ecb 	andeq	r0, r0, fp, asr #29
 3d8:	0000001c 	andeq	r0, r0, ip, lsl r0
 3dc:	00000208 	andeq	r0, r0, r8, lsl #4
 3e0:	0000881c 	andeq	r8, r0, ip, lsl r8
 3e4:	0000003c 	andeq	r0, r0, ip, lsr r0
 3e8:	8b040e42 	blhi	103cf8 <__bss_end+0xfabbc>
 3ec:	0b0d4201 	bleq	350bf8 <__bss_end+0x347abc>
 3f0:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 3f4:	00000ecb 	andeq	r0, r0, fp, asr #29
 3f8:	0000001c 	andeq	r0, r0, ip, lsl r0
 3fc:	00000208 	andeq	r0, r0, r8, lsl #4
 400:	00008858 	andeq	r8, r0, r8, asr r8
 404:	000000b0 	strheq	r0, [r0], -r0	; <UNPREDICTABLE>
 408:	8b080e42 	blhi	203d18 <__bss_end+0x1fabdc>
 40c:	42018e02 	andmi	r8, r1, #2, 28
 410:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 414:	080d0c50 	stmdaeq	sp, {r4, r6, sl, fp}
 418:	0000000c 	andeq	r0, r0, ip
 41c:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 420:	7c020001 	stcvc	0, cr0, [r2], {1}
 424:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 428:	0000001c 	andeq	r0, r0, ip, lsl r0
 42c:	00000418 	andeq	r0, r0, r8, lsl r4
 430:	00008908 	andeq	r8, r0, r8, lsl #18
 434:	00000174 	andeq	r0, r0, r4, ror r1
 438:	8b080e42 	blhi	203d48 <__bss_end+0x1fac0c>
 43c:	42018e02 	andmi	r8, r1, #2, 28
 440:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 444:	080d0cb2 	stmdaeq	sp, {r1, r4, r5, r7, sl, fp}
 448:	0000001c 	andeq	r0, r0, ip, lsl r0
 44c:	00000418 	andeq	r0, r0, r8, lsl r4
 450:	00008a7c 	andeq	r8, r0, ip, ror sl
 454:	0000009c 	muleq	r0, ip, r0
 458:	8b040e42 	blhi	103d68 <__bss_end+0xfac2c>
 45c:	0b0d4201 	bleq	350c68 <__bss_end+0x347b2c>
 460:	0d0d4602 	stceq	6, cr4, [sp, #-8]
 464:	000ecb42 	andeq	ip, lr, r2, asr #22
 468:	0000001c 	andeq	r0, r0, ip, lsl r0
 46c:	00000418 	andeq	r0, r0, r8, lsl r4
 470:	00008b18 	andeq	r8, r0, r8, lsl fp
 474:	000000c0 	andeq	r0, r0, r0, asr #1
 478:	8b040e42 	blhi	103d88 <__bss_end+0xfac4c>
 47c:	0b0d4201 	bleq	350c88 <__bss_end+0x347b4c>
 480:	0d0d5802 	stceq	8, cr5, [sp, #-8]
 484:	000ecb42 	andeq	ip, lr, r2, asr #22
 488:	0000001c 	andeq	r0, r0, ip, lsl r0
 48c:	00000418 	andeq	r0, r0, r8, lsl r4
 490:	00008bd8 	ldrdeq	r8, [r0], -r8	; <UNPREDICTABLE>
 494:	000000ac 	andeq	r0, r0, ip, lsr #1
 498:	8b040e42 	blhi	103da8 <__bss_end+0xfac6c>
 49c:	0b0d4201 	bleq	350ca8 <__bss_end+0x347b6c>
 4a0:	0d0d4e02 	stceq	14, cr4, [sp, #-8]
 4a4:	000ecb42 	andeq	ip, lr, r2, asr #22
 4a8:	0000001c 	andeq	r0, r0, ip, lsl r0
 4ac:	00000418 	andeq	r0, r0, r8, lsl r4
 4b0:	00008c84 	andeq	r8, r0, r4, lsl #25
 4b4:	00000054 	andeq	r0, r0, r4, asr r0
 4b8:	8b040e42 	blhi	103dc8 <__bss_end+0xfac8c>
 4bc:	0b0d4201 	bleq	350cc8 <__bss_end+0x347b8c>
 4c0:	420d0d62 	andmi	r0, sp, #6272	; 0x1880
 4c4:	00000ecb 	andeq	r0, r0, fp, asr #29
 4c8:	0000001c 	andeq	r0, r0, ip, lsl r0
 4cc:	00000418 	andeq	r0, r0, r8, lsl r4
 4d0:	00008cd8 	ldrdeq	r8, [r0], -r8	; <UNPREDICTABLE>
 4d4:	00000068 	andeq	r0, r0, r8, rrx
 4d8:	8b040e42 	blhi	103de8 <__bss_end+0xfacac>
 4dc:	0b0d4201 	bleq	350ce8 <__bss_end+0x347bac>
 4e0:	420d0d6c 	andmi	r0, sp, #108, 26	; 0x1b00
 4e4:	00000ecb 	andeq	r0, r0, fp, asr #29
 4e8:	0000001c 	andeq	r0, r0, ip, lsl r0
 4ec:	00000418 	andeq	r0, r0, r8, lsl r4
 4f0:	00008d40 	andeq	r8, r0, r0, asr #26
 4f4:	00000080 	andeq	r0, r0, r0, lsl #1
 4f8:	8b040e42 	blhi	103e08 <__bss_end+0xfaccc>
 4fc:	0b0d4201 	bleq	350d08 <__bss_end+0x347bcc>
 500:	420d0d78 	andmi	r0, sp, #120, 26	; 0x1e00
 504:	00000ecb 	andeq	r0, r0, fp, asr #29
 508:	0000000c 	andeq	r0, r0, ip
 50c:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 510:	7c010001 	stcvc	0, cr0, [r1], {1}
 514:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 518:	0000000c 	andeq	r0, r0, ip
 51c:	00000508 	andeq	r0, r0, r8, lsl #10
 520:	00008dc0 	andeq	r8, r0, r0, asr #27
 524:	000001ec 	andeq	r0, r0, ip, ror #3
