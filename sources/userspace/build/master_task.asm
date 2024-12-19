
./master_task:     file format elf32-littlearm


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
    805c:	00008fec 	andeq	r8, r0, ip, ror #31
    8060:	0000900c 	andeq	r9, r0, ip

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
    8080:	eb000090 	bl	82c8 <main>
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
    81cc:	00008fe9 	andeq	r8, r0, r9, ror #31
    81d0:	00008fe9 	andeq	r8, r0, r9, ror #31

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
    8224:	00008fe9 	andeq	r8, r0, r9, ror #31
    8228:	00008fe9 	andeq	r8, r0, r9, ror #31

0000822c <_Z3logPKc>:
_Z3logPKc():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:20
constexpr uint32_t char_tick_delay = 0x1000;

uint32_t led, uart, master, log_fd;

void log(const char* msg)
{
    822c:	e92d4810 	push	{r4, fp, lr}
    8230:	e28db008 	add	fp, sp, #8
    8234:	e24dd00c 	sub	sp, sp, #12
    8238:	e50b0010 	str	r0, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:21
    write(log_fd, msg, strlen(msg));
    823c:	e59f3028 	ldr	r3, [pc, #40]	; 826c <_Z3logPKc+0x40>
    8240:	e5934000 	ldr	r4, [r3]
    8244:	e51b0010 	ldr	r0, [fp, #-16]
    8248:	eb000242 	bl	8b58 <_Z6strlenPKc>
    824c:	e1a03000 	mov	r3, r0
    8250:	e1a02003 	mov	r2, r3
    8254:	e51b1010 	ldr	r1, [fp, #-16]
    8258:	e1a00004 	mov	r0, r4
    825c:	eb000089 	bl	8488 <_Z5writejPKcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:22
}
    8260:	e320f000 	nop	{0}
    8264:	e24bd008 	sub	sp, fp, #8
    8268:	e8bd8810 	pop	{r4, fp, pc}
    826c:	00008ff8 	strdeq	r8, [r0], -r8	; <UNPREDICTABLE>

00008270 <_Z5blinkv>:
_Z5blinkv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:25

void blink()
{
    8270:	e92d4800 	push	{fp, lr}
    8274:	e28db004 	add	fp, sp, #4
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:26
	write(led, "1", 1);
    8278:	e59f303c 	ldr	r3, [pc, #60]	; 82bc <_Z5blinkv+0x4c>
    827c:	e5933000 	ldr	r3, [r3]
    8280:	e3a02001 	mov	r2, #1
    8284:	e59f1034 	ldr	r1, [pc, #52]	; 82c0 <_Z5blinkv+0x50>
    8288:	e1a00003 	mov	r0, r3
    828c:	eb00007d 	bl	8488 <_Z5writejPKcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:27
	sleep(0x1000);
    8290:	e3e01001 	mvn	r1, #1
    8294:	e3a00a01 	mov	r0, #4096	; 0x1000
    8298:	eb0000d2 	bl	85e8 <_Z5sleepjj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:28
	write(led, "0", 1);
    829c:	e59f3018 	ldr	r3, [pc, #24]	; 82bc <_Z5blinkv+0x4c>
    82a0:	e5933000 	ldr	r3, [r3]
    82a4:	e3a02001 	mov	r2, #1
    82a8:	e59f1014 	ldr	r1, [pc, #20]	; 82c4 <_Z5blinkv+0x54>
    82ac:	e1a00003 	mov	r0, r3
    82b0:	eb000074 	bl	8488 <_Z5writejPKcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:29
}
    82b4:	e320f000 	nop	{0}
    82b8:	e8bd8800 	pop	{fp, pc}
    82bc:	00008fec 	andeq	r8, r0, ip, ror #31
    82c0:	00008f10 	andeq	r8, r0, r0, lsl pc
    82c4:	00008f14 	andeq	r8, r0, r4, lsl pc

000082c8 <main>:
main():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:32

int main(int argc, char** argv)
{
    82c8:	e92d4800 	push	{fp, lr}
    82cc:	e28db004 	add	fp, sp, #4
    82d0:	e24dd010 	sub	sp, sp, #16
    82d4:	e50b0010 	str	r0, [fp, #-16]
    82d8:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:35
    char buff[4];

    log_fd = pipe("log", 32);
    82dc:	e3a01020 	mov	r1, #32
    82e0:	e59f0078 	ldr	r0, [pc, #120]	; 8360 <main+0x98>
    82e4:	eb000110 	bl	872c <_Z4pipePKcj>
    82e8:	e1a03000 	mov	r3, r0
    82ec:	e59f2070 	ldr	r2, [pc, #112]	; 8364 <main+0x9c>
    82f0:	e5823000 	str	r3, [r2]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:38
    // trng = open("DEV:trng/0", NFile_Open_Mode::Read_Write);

    log("Master task started\n");
    82f4:	e59f006c 	ldr	r0, [pc, #108]	; 8368 <main+0xa0>
    82f8:	ebffffcb 	bl	822c <_Z3logPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:41

    // start i2c connection
    master = open("DEV:i2c/1", NFile_Open_Mode::Read_Write);
    82fc:	e3a01002 	mov	r1, #2
    8300:	e59f0064 	ldr	r0, [pc, #100]	; 836c <main+0xa4>
    8304:	eb00003a 	bl	83f4 <_Z4openPKc15NFile_Open_Mode>
    8308:	e1a03000 	mov	r3, r0
    830c:	e59f205c 	ldr	r2, [pc, #92]	; 8370 <main+0xa8>
    8310:	e5823000 	str	r3, [r2]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:42
    if (master == Invalid_Handle) {
    8314:	e59f3054 	ldr	r3, [pc, #84]	; 8370 <main+0xa8>
    8318:	e5933000 	ldr	r3, [r3]
    831c:	e3730001 	cmn	r3, #1
    8320:	1a000003 	bne	8334 <main+0x6c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:43
        log("Error opening I2C master connection\n");
    8324:	e59f0048 	ldr	r0, [pc, #72]	; 8374 <main+0xac>
    8328:	ebffffbf 	bl	822c <_Z3logPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:44
        return 1;
    832c:	e3a03001 	mov	r3, #1
    8330:	ea000007 	b	8354 <main+0x8c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:46
    }
    log("I2C connection master started...\n");
    8334:	e59f003c 	ldr	r0, [pc, #60]	; 8378 <main+0xb0>
    8338:	ebffffbb 	bl	822c <_Z3logPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:48 (discriminator 1)
    for (;;) {
        log("Hello from master\n");
    833c:	e59f0038 	ldr	r0, [pc, #56]	; 837c <main+0xb4>
    8340:	ebffffb9 	bl	822c <_Z3logPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:49 (discriminator 1)
        sleep(0x10000);
    8344:	e3e01001 	mvn	r1, #1
    8348:	e3a00801 	mov	r0, #65536	; 0x10000
    834c:	eb0000a5 	bl	85e8 <_Z5sleepjj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:48 (discriminator 1)
        log("Hello from master\n");
    8350:	eafffff9 	b	833c <main+0x74>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:57 (discriminator 1)
    close(master);
    log("Open files closed in master\n");
    close(log_fd);

    return 0;
}
    8354:	e1a00003 	mov	r0, r3
    8358:	e24bd004 	sub	sp, fp, #4
    835c:	e8bd8800 	pop	{fp, pc}
    8360:	00008f18 	andeq	r8, r0, r8, lsl pc
    8364:	00008ff8 	strdeq	r8, [r0], -r8	; <UNPREDICTABLE>
    8368:	00008f1c 	andeq	r8, r0, ip, lsl pc
    836c:	00008f34 	andeq	r8, r0, r4, lsr pc
    8370:	00008ff4 	strdeq	r8, [r0], -r4
    8374:	00008f40 	andeq	r8, r0, r0, asr #30
    8378:	00008f68 	andeq	r8, r0, r8, ror #30
    837c:	00008f8c 	andeq	r8, r0, ip, lsl #31

00008380 <_Z6getpidv>:
_Z6getpidv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:5
#include <stdfile.h>
#include <stdstring.h>

uint32_t getpid()
{
    8380:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8384:	e28db000 	add	fp, sp, #0
    8388:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:8
    uint32_t pid;

    asm volatile("swi 0");
    838c:	ef000000 	svc	0x00000000
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:9
    asm volatile("mov %0, r0" : "=r" (pid));
    8390:	e1a03000 	mov	r3, r0
    8394:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:11

    return pid;
    8398:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:12
}
    839c:	e1a00003 	mov	r0, r3
    83a0:	e28bd000 	add	sp, fp, #0
    83a4:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    83a8:	e12fff1e 	bx	lr

000083ac <_Z9terminatei>:
_Z9terminatei():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:15

void terminate(int exitcode)
{
    83ac:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    83b0:	e28db000 	add	fp, sp, #0
    83b4:	e24dd00c 	sub	sp, sp, #12
    83b8:	e50b0008 	str	r0, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:16
    asm volatile("mov r0, %0" : : "r" (exitcode));
    83bc:	e51b3008 	ldr	r3, [fp, #-8]
    83c0:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:17
    asm volatile("swi 1");
    83c4:	ef000001 	svc	0x00000001
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:18
}
    83c8:	e320f000 	nop	{0}
    83cc:	e28bd000 	add	sp, fp, #0
    83d0:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    83d4:	e12fff1e 	bx	lr

000083d8 <_Z11sched_yieldv>:
_Z11sched_yieldv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:21

void sched_yield()
{
    83d8:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    83dc:	e28db000 	add	fp, sp, #0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:22
    asm volatile("swi 2");
    83e0:	ef000002 	svc	0x00000002
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:23
}
    83e4:	e320f000 	nop	{0}
    83e8:	e28bd000 	add	sp, fp, #0
    83ec:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    83f0:	e12fff1e 	bx	lr

000083f4 <_Z4openPKc15NFile_Open_Mode>:
_Z4openPKc15NFile_Open_Mode():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:26

uint32_t open(const char* filename, NFile_Open_Mode mode)
{
    83f4:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    83f8:	e28db000 	add	fp, sp, #0
    83fc:	e24dd014 	sub	sp, sp, #20
    8400:	e50b0010 	str	r0, [fp, #-16]
    8404:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:29
    uint32_t file;

    asm volatile("mov r0, %0" : : "r" (filename));
    8408:	e51b3010 	ldr	r3, [fp, #-16]
    840c:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:30
    asm volatile("mov r1, %0" : : "r" (mode));
    8410:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8414:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:31
    asm volatile("swi 64");
    8418:	ef000040 	svc	0x00000040
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:32
    asm volatile("mov %0, r0" : "=r" (file));
    841c:	e1a03000 	mov	r3, r0
    8420:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:33
    return file;
    8424:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:34
}
    8428:	e1a00003 	mov	r0, r3
    842c:	e28bd000 	add	sp, fp, #0
    8430:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8434:	e12fff1e 	bx	lr

00008438 <_Z4readjPcj>:
_Z4readjPcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:37

uint32_t read(uint32_t file, char* const buffer, uint32_t size)
{
    8438:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    843c:	e28db000 	add	fp, sp, #0
    8440:	e24dd01c 	sub	sp, sp, #28
    8444:	e50b0010 	str	r0, [fp, #-16]
    8448:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    844c:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:40
    uint32_t rdnum;

    asm volatile("mov r0, %0" : : "r" (file));
    8450:	e51b3010 	ldr	r3, [fp, #-16]
    8454:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:41
    asm volatile("mov r1, %0" : : "r" (buffer));
    8458:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    845c:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:42
    asm volatile("mov r2, %0" : : "r" (size));
    8460:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8464:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:43
    asm volatile("swi 65");
    8468:	ef000041 	svc	0x00000041
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:44
    asm volatile("mov %0, r0" : "=r" (rdnum));
    846c:	e1a03000 	mov	r3, r0
    8470:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:46

    return rdnum;
    8474:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:47
}
    8478:	e1a00003 	mov	r0, r3
    847c:	e28bd000 	add	sp, fp, #0
    8480:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8484:	e12fff1e 	bx	lr

00008488 <_Z5writejPKcj>:
_Z5writejPKcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:50

uint32_t write(uint32_t file, const char* buffer, uint32_t size)
{
    8488:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    848c:	e28db000 	add	fp, sp, #0
    8490:	e24dd01c 	sub	sp, sp, #28
    8494:	e50b0010 	str	r0, [fp, #-16]
    8498:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    849c:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:53
    uint32_t wrnum;

    asm volatile("mov r0, %0" : : "r" (file));
    84a0:	e51b3010 	ldr	r3, [fp, #-16]
    84a4:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:54
    asm volatile("mov r1, %0" : : "r" (buffer));
    84a8:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    84ac:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:55
    asm volatile("mov r2, %0" : : "r" (size));
    84b0:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    84b4:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:56
    asm volatile("swi 66");
    84b8:	ef000042 	svc	0x00000042
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:57
    asm volatile("mov %0, r0" : "=r" (wrnum));
    84bc:	e1a03000 	mov	r3, r0
    84c0:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:59

    return wrnum;
    84c4:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:60
}
    84c8:	e1a00003 	mov	r0, r3
    84cc:	e28bd000 	add	sp, fp, #0
    84d0:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    84d4:	e12fff1e 	bx	lr

000084d8 <_Z5closej>:
_Z5closej():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:63

void close(uint32_t file)
{
    84d8:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    84dc:	e28db000 	add	fp, sp, #0
    84e0:	e24dd00c 	sub	sp, sp, #12
    84e4:	e50b0008 	str	r0, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:64
    asm volatile("mov r0, %0" : : "r" (file));
    84e8:	e51b3008 	ldr	r3, [fp, #-8]
    84ec:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:65
    asm volatile("swi 67");
    84f0:	ef000043 	svc	0x00000043
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:66
}
    84f4:	e320f000 	nop	{0}
    84f8:	e28bd000 	add	sp, fp, #0
    84fc:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8500:	e12fff1e 	bx	lr

00008504 <_Z5ioctlj16NIOCtl_OperationPv>:
_Z5ioctlj16NIOCtl_OperationPv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:69

uint32_t ioctl(uint32_t file, NIOCtl_Operation operation, void* param)
{
    8504:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8508:	e28db000 	add	fp, sp, #0
    850c:	e24dd01c 	sub	sp, sp, #28
    8510:	e50b0010 	str	r0, [fp, #-16]
    8514:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8518:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:72
    uint32_t retcode;

    asm volatile("mov r0, %0" : : "r" (file));
    851c:	e51b3010 	ldr	r3, [fp, #-16]
    8520:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:73
    asm volatile("mov r1, %0" : : "r" (operation));
    8524:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8528:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:74
    asm volatile("mov r2, %0" : : "r" (param));
    852c:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8530:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:75
    asm volatile("swi 68");
    8534:	ef000044 	svc	0x00000044
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:76
    asm volatile("mov %0, r0" : "=r" (retcode));
    8538:	e1a03000 	mov	r3, r0
    853c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:78

    return retcode;
    8540:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:79
}
    8544:	e1a00003 	mov	r0, r3
    8548:	e28bd000 	add	sp, fp, #0
    854c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8550:	e12fff1e 	bx	lr

00008554 <_Z6notifyjj>:
_Z6notifyjj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:82

uint32_t notify(uint32_t file, uint32_t count)
{
    8554:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8558:	e28db000 	add	fp, sp, #0
    855c:	e24dd014 	sub	sp, sp, #20
    8560:	e50b0010 	str	r0, [fp, #-16]
    8564:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:85
    uint32_t retcnt;

    asm volatile("mov r0, %0" : : "r" (file));
    8568:	e51b3010 	ldr	r3, [fp, #-16]
    856c:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:86
    asm volatile("mov r1, %0" : : "r" (count));
    8570:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8574:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:87
    asm volatile("swi 69");
    8578:	ef000045 	svc	0x00000045
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:88
    asm volatile("mov %0, r0" : "=r" (retcnt));
    857c:	e1a03000 	mov	r3, r0
    8580:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:90

    return retcnt;
    8584:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:91
}
    8588:	e1a00003 	mov	r0, r3
    858c:	e28bd000 	add	sp, fp, #0
    8590:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8594:	e12fff1e 	bx	lr

00008598 <_Z4waitjjj>:
_Z4waitjjj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:94

NSWI_Result_Code wait(uint32_t file, uint32_t count, uint32_t notified_deadline)
{
    8598:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    859c:	e28db000 	add	fp, sp, #0
    85a0:	e24dd01c 	sub	sp, sp, #28
    85a4:	e50b0010 	str	r0, [fp, #-16]
    85a8:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    85ac:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:97
    NSWI_Result_Code retcode;

    asm volatile("mov r0, %0" : : "r" (file));
    85b0:	e51b3010 	ldr	r3, [fp, #-16]
    85b4:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:98
    asm volatile("mov r1, %0" : : "r" (count));
    85b8:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    85bc:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:99
    asm volatile("mov r2, %0" : : "r" (notified_deadline));
    85c0:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    85c4:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:100
    asm volatile("swi 70");
    85c8:	ef000046 	svc	0x00000046
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:101
    asm volatile("mov %0, r0" : "=r" (retcode));
    85cc:	e1a03000 	mov	r3, r0
    85d0:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:103

    return retcode;
    85d4:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:104
}
    85d8:	e1a00003 	mov	r0, r3
    85dc:	e28bd000 	add	sp, fp, #0
    85e0:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    85e4:	e12fff1e 	bx	lr

000085e8 <_Z5sleepjj>:
_Z5sleepjj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:107

bool sleep(uint32_t ticks, uint32_t notified_deadline)
{
    85e8:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    85ec:	e28db000 	add	fp, sp, #0
    85f0:	e24dd014 	sub	sp, sp, #20
    85f4:	e50b0010 	str	r0, [fp, #-16]
    85f8:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:110
    uint32_t retcode;

    asm volatile("mov r0, %0" : : "r" (ticks));
    85fc:	e51b3010 	ldr	r3, [fp, #-16]
    8600:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:111
    asm volatile("mov r1, %0" : : "r" (notified_deadline));
    8604:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8608:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:112
    asm volatile("swi 3");
    860c:	ef000003 	svc	0x00000003
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:113
    asm volatile("mov %0, r0" : "=r" (retcode));
    8610:	e1a03000 	mov	r3, r0
    8614:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:115

    return retcode;
    8618:	e51b3008 	ldr	r3, [fp, #-8]
    861c:	e3530000 	cmp	r3, #0
    8620:	13a03001 	movne	r3, #1
    8624:	03a03000 	moveq	r3, #0
    8628:	e6ef3073 	uxtb	r3, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:116
}
    862c:	e1a00003 	mov	r0, r3
    8630:	e28bd000 	add	sp, fp, #0
    8634:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8638:	e12fff1e 	bx	lr

0000863c <_Z24get_active_process_countv>:
_Z24get_active_process_countv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:119

uint32_t get_active_process_count()
{
    863c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8640:	e28db000 	add	fp, sp, #0
    8644:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:120
    const NGet_Sched_Info_Type req = NGet_Sched_Info_Type::Active_Process_Count;
    8648:	e3a03000 	mov	r3, #0
    864c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:123
    uint32_t retval;

    asm volatile("mov r0, %0" : : "r" (req));
    8650:	e3a03000 	mov	r3, #0
    8654:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:124
    asm volatile("mov r1, %0" : : "r" (&retval));
    8658:	e24b300c 	sub	r3, fp, #12
    865c:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:125
    asm volatile("swi 4");
    8660:	ef000004 	svc	0x00000004
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:127

    return retval;
    8664:	e51b300c 	ldr	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:128
}
    8668:	e1a00003 	mov	r0, r3
    866c:	e28bd000 	add	sp, fp, #0
    8670:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8674:	e12fff1e 	bx	lr

00008678 <_Z14get_tick_countv>:
_Z14get_tick_countv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:131

uint32_t get_tick_count()
{
    8678:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    867c:	e28db000 	add	fp, sp, #0
    8680:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:132
    const NGet_Sched_Info_Type req = NGet_Sched_Info_Type::Tick_Count;
    8684:	e3a03001 	mov	r3, #1
    8688:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:135
    uint32_t retval;

    asm volatile("mov r0, %0" : : "r" (req));
    868c:	e3a03001 	mov	r3, #1
    8690:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:136
    asm volatile("mov r1, %0" : : "r" (&retval));
    8694:	e24b300c 	sub	r3, fp, #12
    8698:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:137
    asm volatile("swi 4");
    869c:	ef000004 	svc	0x00000004
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:139

    return retval;
    86a0:	e51b300c 	ldr	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:140
}
    86a4:	e1a00003 	mov	r0, r3
    86a8:	e28bd000 	add	sp, fp, #0
    86ac:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    86b0:	e12fff1e 	bx	lr

000086b4 <_Z17set_task_deadlinej>:
_Z17set_task_deadlinej():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:143

void set_task_deadline(uint32_t tick_count_required)
{
    86b4:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    86b8:	e28db000 	add	fp, sp, #0
    86bc:	e24dd014 	sub	sp, sp, #20
    86c0:	e50b0010 	str	r0, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:144
    const NDeadline_Subservice req = NDeadline_Subservice::Set_Relative;
    86c4:	e3a03000 	mov	r3, #0
    86c8:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:146

    asm volatile("mov r0, %0" : : "r" (req));
    86cc:	e3a03000 	mov	r3, #0
    86d0:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:147
    asm volatile("mov r1, %0" : : "r" (&tick_count_required));
    86d4:	e24b3010 	sub	r3, fp, #16
    86d8:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:148
    asm volatile("swi 5");
    86dc:	ef000005 	svc	0x00000005
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:149
}
    86e0:	e320f000 	nop	{0}
    86e4:	e28bd000 	add	sp, fp, #0
    86e8:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    86ec:	e12fff1e 	bx	lr

000086f0 <_Z26get_task_ticks_to_deadlinev>:
_Z26get_task_ticks_to_deadlinev():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:152

uint32_t get_task_ticks_to_deadline()
{
    86f0:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    86f4:	e28db000 	add	fp, sp, #0
    86f8:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:153
    const NDeadline_Subservice req = NDeadline_Subservice::Get_Remaining;
    86fc:	e3a03001 	mov	r3, #1
    8700:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:156
    uint32_t ticks;

    asm volatile("mov r0, %0" : : "r" (req));
    8704:	e3a03001 	mov	r3, #1
    8708:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:157
    asm volatile("mov r1, %0" : : "r" (&ticks));
    870c:	e24b300c 	sub	r3, fp, #12
    8710:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:158
    asm volatile("swi 5");
    8714:	ef000005 	svc	0x00000005
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:160

    return ticks;
    8718:	e51b300c 	ldr	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:161
}
    871c:	e1a00003 	mov	r0, r3
    8720:	e28bd000 	add	sp, fp, #0
    8724:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8728:	e12fff1e 	bx	lr

0000872c <_Z4pipePKcj>:
_Z4pipePKcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:166

const char Pipe_File_Prefix[] = "SYS:pipe/";

uint32_t pipe(const char* name, uint32_t buf_size)
{
    872c:	e92d4800 	push	{fp, lr}
    8730:	e28db004 	add	fp, sp, #4
    8734:	e24dd050 	sub	sp, sp, #80	; 0x50
    8738:	e50b0050 	str	r0, [fp, #-80]	; 0xffffffb0
    873c:	e50b1054 	str	r1, [fp, #-84]	; 0xffffffac
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:168
    char fname[64];
    strncpy(fname, Pipe_File_Prefix, sizeof(Pipe_File_Prefix));
    8740:	e24b3048 	sub	r3, fp, #72	; 0x48
    8744:	e3a0200a 	mov	r2, #10
    8748:	e59f1088 	ldr	r1, [pc, #136]	; 87d8 <_Z4pipePKcj+0xac>
    874c:	e1a00003 	mov	r0, r3
    8750:	eb0000a5 	bl	89ec <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:169
    strncpy(fname + sizeof(Pipe_File_Prefix), name, sizeof(fname) - sizeof(Pipe_File_Prefix) - 1);
    8754:	e24b3048 	sub	r3, fp, #72	; 0x48
    8758:	e283300a 	add	r3, r3, #10
    875c:	e3a02035 	mov	r2, #53	; 0x35
    8760:	e51b1050 	ldr	r1, [fp, #-80]	; 0xffffffb0
    8764:	e1a00003 	mov	r0, r3
    8768:	eb00009f 	bl	89ec <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:171

    int ncur = sizeof(Pipe_File_Prefix) + strlen(name);
    876c:	e51b0050 	ldr	r0, [fp, #-80]	; 0xffffffb0
    8770:	eb0000f8 	bl	8b58 <_Z6strlenPKc>
    8774:	e1a03000 	mov	r3, r0
    8778:	e283300a 	add	r3, r3, #10
    877c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:173

    fname[ncur++] = '#';
    8780:	e51b3008 	ldr	r3, [fp, #-8]
    8784:	e2832001 	add	r2, r3, #1
    8788:	e50b2008 	str	r2, [fp, #-8]
    878c:	e2433004 	sub	r3, r3, #4
    8790:	e083300b 	add	r3, r3, fp
    8794:	e3a02023 	mov	r2, #35	; 0x23
    8798:	e5432044 	strb	r2, [r3, #-68]	; 0xffffffbc
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:175

    itoa(buf_size, &fname[ncur], 10);
    879c:	e24b2048 	sub	r2, fp, #72	; 0x48
    87a0:	e51b3008 	ldr	r3, [fp, #-8]
    87a4:	e0823003 	add	r3, r2, r3
    87a8:	e3a0200a 	mov	r2, #10
    87ac:	e1a01003 	mov	r1, r3
    87b0:	e51b0054 	ldr	r0, [fp, #-84]	; 0xffffffac
    87b4:	eb000008 	bl	87dc <_Z4itoajPcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:177

    return open(fname, NFile_Open_Mode::Read_Write);
    87b8:	e24b3048 	sub	r3, fp, #72	; 0x48
    87bc:	e3a01002 	mov	r1, #2
    87c0:	e1a00003 	mov	r0, r3
    87c4:	ebffff0a 	bl	83f4 <_Z4openPKc15NFile_Open_Mode>
    87c8:	e1a03000 	mov	r3, r0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:178
}
    87cc:	e1a00003 	mov	r0, r3
    87d0:	e24bd004 	sub	sp, fp, #4
    87d4:	e8bd8800 	pop	{fp, pc}
    87d8:	00008fcc 	andeq	r8, r0, ip, asr #31

000087dc <_Z4itoajPcj>:
_Z4itoajPcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:9
{
    const char CharConvArr[] = "0123456789ABCDEF";
}

void itoa(unsigned int input, char* output, unsigned int base)
{
    87dc:	e92d4800 	push	{fp, lr}
    87e0:	e28db004 	add	fp, sp, #4
    87e4:	e24dd020 	sub	sp, sp, #32
    87e8:	e50b0018 	str	r0, [fp, #-24]	; 0xffffffe8
    87ec:	e50b101c 	str	r1, [fp, #-28]	; 0xffffffe4
    87f0:	e50b2020 	str	r2, [fp, #-32]	; 0xffffffe0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:10
	int i = 0;
    87f4:	e3a03000 	mov	r3, #0
    87f8:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:12

	while (input > 0)
    87fc:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8800:	e3530000 	cmp	r3, #0
    8804:	0a000014 	beq	885c <_Z4itoajPcj+0x80>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:14
	{
		output[i] = CharConvArr[input % base];
    8808:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    880c:	e51b1020 	ldr	r1, [fp, #-32]	; 0xffffffe0
    8810:	e1a00003 	mov	r0, r3
    8814:	eb000199 	bl	8e80 <__aeabi_uidivmod>
    8818:	e1a03001 	mov	r3, r1
    881c:	e1a01003 	mov	r1, r3
    8820:	e51b3008 	ldr	r3, [fp, #-8]
    8824:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    8828:	e0823003 	add	r3, r2, r3
    882c:	e59f2118 	ldr	r2, [pc, #280]	; 894c <_Z4itoajPcj+0x170>
    8830:	e7d22001 	ldrb	r2, [r2, r1]
    8834:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:15
		input /= base;
    8838:	e51b1020 	ldr	r1, [fp, #-32]	; 0xffffffe0
    883c:	e51b0018 	ldr	r0, [fp, #-24]	; 0xffffffe8
    8840:	eb000113 	bl	8c94 <__udivsi3>
    8844:	e1a03000 	mov	r3, r0
    8848:	e50b3018 	str	r3, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:16
		i++;
    884c:	e51b3008 	ldr	r3, [fp, #-8]
    8850:	e2833001 	add	r3, r3, #1
    8854:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:12
	while (input > 0)
    8858:	eaffffe7 	b	87fc <_Z4itoajPcj+0x20>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:19
	}

    if (i == 0)
    885c:	e51b3008 	ldr	r3, [fp, #-8]
    8860:	e3530000 	cmp	r3, #0
    8864:	1a000007 	bne	8888 <_Z4itoajPcj+0xac>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:21
    {
        output[i] = CharConvArr[0];
    8868:	e51b3008 	ldr	r3, [fp, #-8]
    886c:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    8870:	e0823003 	add	r3, r2, r3
    8874:	e3a02030 	mov	r2, #48	; 0x30
    8878:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:22
        i++;
    887c:	e51b3008 	ldr	r3, [fp, #-8]
    8880:	e2833001 	add	r3, r3, #1
    8884:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:25
    }

	output[i] = '\0';
    8888:	e51b3008 	ldr	r3, [fp, #-8]
    888c:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    8890:	e0823003 	add	r3, r2, r3
    8894:	e3a02000 	mov	r2, #0
    8898:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:26
	i--;
    889c:	e51b3008 	ldr	r3, [fp, #-8]
    88a0:	e2433001 	sub	r3, r3, #1
    88a4:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:28

	for (int j = 0; j <= i/2; j++)
    88a8:	e3a03000 	mov	r3, #0
    88ac:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:28 (discriminator 3)
    88b0:	e51b3008 	ldr	r3, [fp, #-8]
    88b4:	e1a02fa3 	lsr	r2, r3, #31
    88b8:	e0823003 	add	r3, r2, r3
    88bc:	e1a030c3 	asr	r3, r3, #1
    88c0:	e1a02003 	mov	r2, r3
    88c4:	e51b300c 	ldr	r3, [fp, #-12]
    88c8:	e1530002 	cmp	r3, r2
    88cc:	ca00001b 	bgt	8940 <_Z4itoajPcj+0x164>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:30 (discriminator 2)
	{
		char c = output[i - j];
    88d0:	e51b2008 	ldr	r2, [fp, #-8]
    88d4:	e51b300c 	ldr	r3, [fp, #-12]
    88d8:	e0423003 	sub	r3, r2, r3
    88dc:	e1a02003 	mov	r2, r3
    88e0:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    88e4:	e0833002 	add	r3, r3, r2
    88e8:	e5d33000 	ldrb	r3, [r3]
    88ec:	e54b300d 	strb	r3, [fp, #-13]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:31 (discriminator 2)
		output[i - j] = output[j];
    88f0:	e51b300c 	ldr	r3, [fp, #-12]
    88f4:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    88f8:	e0822003 	add	r2, r2, r3
    88fc:	e51b1008 	ldr	r1, [fp, #-8]
    8900:	e51b300c 	ldr	r3, [fp, #-12]
    8904:	e0413003 	sub	r3, r1, r3
    8908:	e1a01003 	mov	r1, r3
    890c:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    8910:	e0833001 	add	r3, r3, r1
    8914:	e5d22000 	ldrb	r2, [r2]
    8918:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:32 (discriminator 2)
		output[j] = c;
    891c:	e51b300c 	ldr	r3, [fp, #-12]
    8920:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    8924:	e0823003 	add	r3, r2, r3
    8928:	e55b200d 	ldrb	r2, [fp, #-13]
    892c:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:28 (discriminator 2)
	for (int j = 0; j <= i/2; j++)
    8930:	e51b300c 	ldr	r3, [fp, #-12]
    8934:	e2833001 	add	r3, r3, #1
    8938:	e50b300c 	str	r3, [fp, #-12]
    893c:	eaffffdb 	b	88b0 <_Z4itoajPcj+0xd4>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:34
	}
}
    8940:	e320f000 	nop	{0}
    8944:	e24bd004 	sub	sp, fp, #4
    8948:	e8bd8800 	pop	{fp, pc}
    894c:	00008fd8 	ldrdeq	r8, [r0], -r8	; <UNPREDICTABLE>

00008950 <_Z4atoiPKc>:
_Z4atoiPKc():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:37

int atoi(const char* input)
{
    8950:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8954:	e28db000 	add	fp, sp, #0
    8958:	e24dd014 	sub	sp, sp, #20
    895c:	e50b0010 	str	r0, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:38
	int output = 0;
    8960:	e3a03000 	mov	r3, #0
    8964:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:40

	while (*input != '\0')
    8968:	e51b3010 	ldr	r3, [fp, #-16]
    896c:	e5d33000 	ldrb	r3, [r3]
    8970:	e3530000 	cmp	r3, #0
    8974:	0a000017 	beq	89d8 <_Z4atoiPKc+0x88>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:42
	{
		output *= 10;
    8978:	e51b2008 	ldr	r2, [fp, #-8]
    897c:	e1a03002 	mov	r3, r2
    8980:	e1a03103 	lsl	r3, r3, #2
    8984:	e0833002 	add	r3, r3, r2
    8988:	e1a03083 	lsl	r3, r3, #1
    898c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:43
		if (*input > '9' || *input < '0')
    8990:	e51b3010 	ldr	r3, [fp, #-16]
    8994:	e5d33000 	ldrb	r3, [r3]
    8998:	e3530039 	cmp	r3, #57	; 0x39
    899c:	8a00000d 	bhi	89d8 <_Z4atoiPKc+0x88>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:43 (discriminator 1)
    89a0:	e51b3010 	ldr	r3, [fp, #-16]
    89a4:	e5d33000 	ldrb	r3, [r3]
    89a8:	e353002f 	cmp	r3, #47	; 0x2f
    89ac:	9a000009 	bls	89d8 <_Z4atoiPKc+0x88>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:46
			break;

		output += *input - '0';
    89b0:	e51b3010 	ldr	r3, [fp, #-16]
    89b4:	e5d33000 	ldrb	r3, [r3]
    89b8:	e2433030 	sub	r3, r3, #48	; 0x30
    89bc:	e51b2008 	ldr	r2, [fp, #-8]
    89c0:	e0823003 	add	r3, r2, r3
    89c4:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:48

		input++;
    89c8:	e51b3010 	ldr	r3, [fp, #-16]
    89cc:	e2833001 	add	r3, r3, #1
    89d0:	e50b3010 	str	r3, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:40
	while (*input != '\0')
    89d4:	eaffffe3 	b	8968 <_Z4atoiPKc+0x18>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:51
	}

	return output;
    89d8:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:52
}
    89dc:	e1a00003 	mov	r0, r3
    89e0:	e28bd000 	add	sp, fp, #0
    89e4:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    89e8:	e12fff1e 	bx	lr

000089ec <_Z7strncpyPcPKci>:
_Z7strncpyPcPKci():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:55

char* strncpy(char* dest, const char *src, int num)
{
    89ec:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    89f0:	e28db000 	add	fp, sp, #0
    89f4:	e24dd01c 	sub	sp, sp, #28
    89f8:	e50b0010 	str	r0, [fp, #-16]
    89fc:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8a00:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:58
	int i;

	for (i = 0; i < num && src[i] != '\0'; i++)
    8a04:	e3a03000 	mov	r3, #0
    8a08:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:58 (discriminator 4)
    8a0c:	e51b2008 	ldr	r2, [fp, #-8]
    8a10:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8a14:	e1520003 	cmp	r2, r3
    8a18:	aa000011 	bge	8a64 <_Z7strncpyPcPKci+0x78>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:58 (discriminator 2)
    8a1c:	e51b3008 	ldr	r3, [fp, #-8]
    8a20:	e51b2014 	ldr	r2, [fp, #-20]	; 0xffffffec
    8a24:	e0823003 	add	r3, r2, r3
    8a28:	e5d33000 	ldrb	r3, [r3]
    8a2c:	e3530000 	cmp	r3, #0
    8a30:	0a00000b 	beq	8a64 <_Z7strncpyPcPKci+0x78>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:59 (discriminator 3)
		dest[i] = src[i];
    8a34:	e51b3008 	ldr	r3, [fp, #-8]
    8a38:	e51b2014 	ldr	r2, [fp, #-20]	; 0xffffffec
    8a3c:	e0822003 	add	r2, r2, r3
    8a40:	e51b3008 	ldr	r3, [fp, #-8]
    8a44:	e51b1010 	ldr	r1, [fp, #-16]
    8a48:	e0813003 	add	r3, r1, r3
    8a4c:	e5d22000 	ldrb	r2, [r2]
    8a50:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:58 (discriminator 3)
	for (i = 0; i < num && src[i] != '\0'; i++)
    8a54:	e51b3008 	ldr	r3, [fp, #-8]
    8a58:	e2833001 	add	r3, r3, #1
    8a5c:	e50b3008 	str	r3, [fp, #-8]
    8a60:	eaffffe9 	b	8a0c <_Z7strncpyPcPKci+0x20>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:60 (discriminator 2)
	for (; i < num; i++)
    8a64:	e51b2008 	ldr	r2, [fp, #-8]
    8a68:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8a6c:	e1520003 	cmp	r2, r3
    8a70:	aa000008 	bge	8a98 <_Z7strncpyPcPKci+0xac>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:61 (discriminator 1)
		dest[i] = '\0';
    8a74:	e51b3008 	ldr	r3, [fp, #-8]
    8a78:	e51b2010 	ldr	r2, [fp, #-16]
    8a7c:	e0823003 	add	r3, r2, r3
    8a80:	e3a02000 	mov	r2, #0
    8a84:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:60 (discriminator 1)
	for (; i < num; i++)
    8a88:	e51b3008 	ldr	r3, [fp, #-8]
    8a8c:	e2833001 	add	r3, r3, #1
    8a90:	e50b3008 	str	r3, [fp, #-8]
    8a94:	eafffff2 	b	8a64 <_Z7strncpyPcPKci+0x78>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:63

   return dest;
    8a98:	e51b3010 	ldr	r3, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:64
}
    8a9c:	e1a00003 	mov	r0, r3
    8aa0:	e28bd000 	add	sp, fp, #0
    8aa4:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8aa8:	e12fff1e 	bx	lr

00008aac <_Z7strncmpPKcS0_i>:
_Z7strncmpPKcS0_i():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:67

int strncmp(const char *s1, const char *s2, int num)
{
    8aac:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8ab0:	e28db000 	add	fp, sp, #0
    8ab4:	e24dd01c 	sub	sp, sp, #28
    8ab8:	e50b0010 	str	r0, [fp, #-16]
    8abc:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8ac0:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:69
	unsigned char u1, u2;
  	while (num-- > 0)
    8ac4:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8ac8:	e2432001 	sub	r2, r3, #1
    8acc:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
    8ad0:	e3530000 	cmp	r3, #0
    8ad4:	c3a03001 	movgt	r3, #1
    8ad8:	d3a03000 	movle	r3, #0
    8adc:	e6ef3073 	uxtb	r3, r3
    8ae0:	e3530000 	cmp	r3, #0
    8ae4:	0a000016 	beq	8b44 <_Z7strncmpPKcS0_i+0x98>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:71
    {
      	u1 = (unsigned char) *s1++;
    8ae8:	e51b3010 	ldr	r3, [fp, #-16]
    8aec:	e2832001 	add	r2, r3, #1
    8af0:	e50b2010 	str	r2, [fp, #-16]
    8af4:	e5d33000 	ldrb	r3, [r3]
    8af8:	e54b3005 	strb	r3, [fp, #-5]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:72
     	u2 = (unsigned char) *s2++;
    8afc:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8b00:	e2832001 	add	r2, r3, #1
    8b04:	e50b2014 	str	r2, [fp, #-20]	; 0xffffffec
    8b08:	e5d33000 	ldrb	r3, [r3]
    8b0c:	e54b3006 	strb	r3, [fp, #-6]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:73
      	if (u1 != u2)
    8b10:	e55b2005 	ldrb	r2, [fp, #-5]
    8b14:	e55b3006 	ldrb	r3, [fp, #-6]
    8b18:	e1520003 	cmp	r2, r3
    8b1c:	0a000003 	beq	8b30 <_Z7strncmpPKcS0_i+0x84>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:74
        	return u1 - u2;
    8b20:	e55b2005 	ldrb	r2, [fp, #-5]
    8b24:	e55b3006 	ldrb	r3, [fp, #-6]
    8b28:	e0423003 	sub	r3, r2, r3
    8b2c:	ea000005 	b	8b48 <_Z7strncmpPKcS0_i+0x9c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:75
      	if (u1 == '\0')
    8b30:	e55b3005 	ldrb	r3, [fp, #-5]
    8b34:	e3530000 	cmp	r3, #0
    8b38:	1affffe1 	bne	8ac4 <_Z7strncmpPKcS0_i+0x18>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:76
        	return 0;
    8b3c:	e3a03000 	mov	r3, #0
    8b40:	ea000000 	b	8b48 <_Z7strncmpPKcS0_i+0x9c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:79
    }

  	return 0;
    8b44:	e3a03000 	mov	r3, #0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:80
}
    8b48:	e1a00003 	mov	r0, r3
    8b4c:	e28bd000 	add	sp, fp, #0
    8b50:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8b54:	e12fff1e 	bx	lr

00008b58 <_Z6strlenPKc>:
_Z6strlenPKc():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:83

int strlen(const char* s)
{
    8b58:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8b5c:	e28db000 	add	fp, sp, #0
    8b60:	e24dd014 	sub	sp, sp, #20
    8b64:	e50b0010 	str	r0, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:84
	int i = 0;
    8b68:	e3a03000 	mov	r3, #0
    8b6c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:86

	while (s[i] != '\0')
    8b70:	e51b3008 	ldr	r3, [fp, #-8]
    8b74:	e51b2010 	ldr	r2, [fp, #-16]
    8b78:	e0823003 	add	r3, r2, r3
    8b7c:	e5d33000 	ldrb	r3, [r3]
    8b80:	e3530000 	cmp	r3, #0
    8b84:	0a000003 	beq	8b98 <_Z6strlenPKc+0x40>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:87
		i++;
    8b88:	e51b3008 	ldr	r3, [fp, #-8]
    8b8c:	e2833001 	add	r3, r3, #1
    8b90:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:86
	while (s[i] != '\0')
    8b94:	eafffff5 	b	8b70 <_Z6strlenPKc+0x18>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:89

	return i;
    8b98:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:90
}
    8b9c:	e1a00003 	mov	r0, r3
    8ba0:	e28bd000 	add	sp, fp, #0
    8ba4:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8ba8:	e12fff1e 	bx	lr

00008bac <_Z5bzeroPvi>:
_Z5bzeroPvi():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:93

void bzero(void* memory, int length)
{
    8bac:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8bb0:	e28db000 	add	fp, sp, #0
    8bb4:	e24dd014 	sub	sp, sp, #20
    8bb8:	e50b0010 	str	r0, [fp, #-16]
    8bbc:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:94
	char* mem = reinterpret_cast<char*>(memory);
    8bc0:	e51b3010 	ldr	r3, [fp, #-16]
    8bc4:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:96

	for (int i = 0; i < length; i++)
    8bc8:	e3a03000 	mov	r3, #0
    8bcc:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:96 (discriminator 3)
    8bd0:	e51b2008 	ldr	r2, [fp, #-8]
    8bd4:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8bd8:	e1520003 	cmp	r2, r3
    8bdc:	aa000008 	bge	8c04 <_Z5bzeroPvi+0x58>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:97 (discriminator 2)
		mem[i] = 0;
    8be0:	e51b3008 	ldr	r3, [fp, #-8]
    8be4:	e51b200c 	ldr	r2, [fp, #-12]
    8be8:	e0823003 	add	r3, r2, r3
    8bec:	e3a02000 	mov	r2, #0
    8bf0:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:96 (discriminator 2)
	for (int i = 0; i < length; i++)
    8bf4:	e51b3008 	ldr	r3, [fp, #-8]
    8bf8:	e2833001 	add	r3, r3, #1
    8bfc:	e50b3008 	str	r3, [fp, #-8]
    8c00:	eafffff2 	b	8bd0 <_Z5bzeroPvi+0x24>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:98
}
    8c04:	e320f000 	nop	{0}
    8c08:	e28bd000 	add	sp, fp, #0
    8c0c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8c10:	e12fff1e 	bx	lr

00008c14 <_Z6memcpyPKvPvi>:
_Z6memcpyPKvPvi():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:101

void memcpy(const void* src, void* dst, int num)
{
    8c14:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8c18:	e28db000 	add	fp, sp, #0
    8c1c:	e24dd024 	sub	sp, sp, #36	; 0x24
    8c20:	e50b0018 	str	r0, [fp, #-24]	; 0xffffffe8
    8c24:	e50b101c 	str	r1, [fp, #-28]	; 0xffffffe4
    8c28:	e50b2020 	str	r2, [fp, #-32]	; 0xffffffe0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:102
	const char* memsrc = reinterpret_cast<const char*>(src);
    8c2c:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8c30:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:103
	char* memdst = reinterpret_cast<char*>(dst);
    8c34:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    8c38:	e50b3010 	str	r3, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:105

	for (int i = 0; i < num; i++)
    8c3c:	e3a03000 	mov	r3, #0
    8c40:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:105 (discriminator 3)
    8c44:	e51b2008 	ldr	r2, [fp, #-8]
    8c48:	e51b3020 	ldr	r3, [fp, #-32]	; 0xffffffe0
    8c4c:	e1520003 	cmp	r2, r3
    8c50:	aa00000b 	bge	8c84 <_Z6memcpyPKvPvi+0x70>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:106 (discriminator 2)
		memdst[i] = memsrc[i];
    8c54:	e51b3008 	ldr	r3, [fp, #-8]
    8c58:	e51b200c 	ldr	r2, [fp, #-12]
    8c5c:	e0822003 	add	r2, r2, r3
    8c60:	e51b3008 	ldr	r3, [fp, #-8]
    8c64:	e51b1010 	ldr	r1, [fp, #-16]
    8c68:	e0813003 	add	r3, r1, r3
    8c6c:	e5d22000 	ldrb	r2, [r2]
    8c70:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:105 (discriminator 2)
	for (int i = 0; i < num; i++)
    8c74:	e51b3008 	ldr	r3, [fp, #-8]
    8c78:	e2833001 	add	r3, r3, #1
    8c7c:	e50b3008 	str	r3, [fp, #-8]
    8c80:	eaffffef 	b	8c44 <_Z6memcpyPKvPvi+0x30>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:107
}
    8c84:	e320f000 	nop	{0}
    8c88:	e28bd000 	add	sp, fp, #0
    8c8c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8c90:	e12fff1e 	bx	lr

00008c94 <__udivsi3>:
__udivsi3():
    8c94:	e2512001 	subs	r2, r1, #1
    8c98:	012fff1e 	bxeq	lr
    8c9c:	3a000074 	bcc	8e74 <__udivsi3+0x1e0>
    8ca0:	e1500001 	cmp	r0, r1
    8ca4:	9a00006b 	bls	8e58 <__udivsi3+0x1c4>
    8ca8:	e1110002 	tst	r1, r2
    8cac:	0a00006c 	beq	8e64 <__udivsi3+0x1d0>
    8cb0:	e16f3f10 	clz	r3, r0
    8cb4:	e16f2f11 	clz	r2, r1
    8cb8:	e0423003 	sub	r3, r2, r3
    8cbc:	e273301f 	rsbs	r3, r3, #31
    8cc0:	10833083 	addne	r3, r3, r3, lsl #1
    8cc4:	e3a02000 	mov	r2, #0
    8cc8:	108ff103 	addne	pc, pc, r3, lsl #2
    8ccc:	e1a00000 	nop			; (mov r0, r0)
    8cd0:	e1500f81 	cmp	r0, r1, lsl #31
    8cd4:	e0a22002 	adc	r2, r2, r2
    8cd8:	20400f81 	subcs	r0, r0, r1, lsl #31
    8cdc:	e1500f01 	cmp	r0, r1, lsl #30
    8ce0:	e0a22002 	adc	r2, r2, r2
    8ce4:	20400f01 	subcs	r0, r0, r1, lsl #30
    8ce8:	e1500e81 	cmp	r0, r1, lsl #29
    8cec:	e0a22002 	adc	r2, r2, r2
    8cf0:	20400e81 	subcs	r0, r0, r1, lsl #29
    8cf4:	e1500e01 	cmp	r0, r1, lsl #28
    8cf8:	e0a22002 	adc	r2, r2, r2
    8cfc:	20400e01 	subcs	r0, r0, r1, lsl #28
    8d00:	e1500d81 	cmp	r0, r1, lsl #27
    8d04:	e0a22002 	adc	r2, r2, r2
    8d08:	20400d81 	subcs	r0, r0, r1, lsl #27
    8d0c:	e1500d01 	cmp	r0, r1, lsl #26
    8d10:	e0a22002 	adc	r2, r2, r2
    8d14:	20400d01 	subcs	r0, r0, r1, lsl #26
    8d18:	e1500c81 	cmp	r0, r1, lsl #25
    8d1c:	e0a22002 	adc	r2, r2, r2
    8d20:	20400c81 	subcs	r0, r0, r1, lsl #25
    8d24:	e1500c01 	cmp	r0, r1, lsl #24
    8d28:	e0a22002 	adc	r2, r2, r2
    8d2c:	20400c01 	subcs	r0, r0, r1, lsl #24
    8d30:	e1500b81 	cmp	r0, r1, lsl #23
    8d34:	e0a22002 	adc	r2, r2, r2
    8d38:	20400b81 	subcs	r0, r0, r1, lsl #23
    8d3c:	e1500b01 	cmp	r0, r1, lsl #22
    8d40:	e0a22002 	adc	r2, r2, r2
    8d44:	20400b01 	subcs	r0, r0, r1, lsl #22
    8d48:	e1500a81 	cmp	r0, r1, lsl #21
    8d4c:	e0a22002 	adc	r2, r2, r2
    8d50:	20400a81 	subcs	r0, r0, r1, lsl #21
    8d54:	e1500a01 	cmp	r0, r1, lsl #20
    8d58:	e0a22002 	adc	r2, r2, r2
    8d5c:	20400a01 	subcs	r0, r0, r1, lsl #20
    8d60:	e1500981 	cmp	r0, r1, lsl #19
    8d64:	e0a22002 	adc	r2, r2, r2
    8d68:	20400981 	subcs	r0, r0, r1, lsl #19
    8d6c:	e1500901 	cmp	r0, r1, lsl #18
    8d70:	e0a22002 	adc	r2, r2, r2
    8d74:	20400901 	subcs	r0, r0, r1, lsl #18
    8d78:	e1500881 	cmp	r0, r1, lsl #17
    8d7c:	e0a22002 	adc	r2, r2, r2
    8d80:	20400881 	subcs	r0, r0, r1, lsl #17
    8d84:	e1500801 	cmp	r0, r1, lsl #16
    8d88:	e0a22002 	adc	r2, r2, r2
    8d8c:	20400801 	subcs	r0, r0, r1, lsl #16
    8d90:	e1500781 	cmp	r0, r1, lsl #15
    8d94:	e0a22002 	adc	r2, r2, r2
    8d98:	20400781 	subcs	r0, r0, r1, lsl #15
    8d9c:	e1500701 	cmp	r0, r1, lsl #14
    8da0:	e0a22002 	adc	r2, r2, r2
    8da4:	20400701 	subcs	r0, r0, r1, lsl #14
    8da8:	e1500681 	cmp	r0, r1, lsl #13
    8dac:	e0a22002 	adc	r2, r2, r2
    8db0:	20400681 	subcs	r0, r0, r1, lsl #13
    8db4:	e1500601 	cmp	r0, r1, lsl #12
    8db8:	e0a22002 	adc	r2, r2, r2
    8dbc:	20400601 	subcs	r0, r0, r1, lsl #12
    8dc0:	e1500581 	cmp	r0, r1, lsl #11
    8dc4:	e0a22002 	adc	r2, r2, r2
    8dc8:	20400581 	subcs	r0, r0, r1, lsl #11
    8dcc:	e1500501 	cmp	r0, r1, lsl #10
    8dd0:	e0a22002 	adc	r2, r2, r2
    8dd4:	20400501 	subcs	r0, r0, r1, lsl #10
    8dd8:	e1500481 	cmp	r0, r1, lsl #9
    8ddc:	e0a22002 	adc	r2, r2, r2
    8de0:	20400481 	subcs	r0, r0, r1, lsl #9
    8de4:	e1500401 	cmp	r0, r1, lsl #8
    8de8:	e0a22002 	adc	r2, r2, r2
    8dec:	20400401 	subcs	r0, r0, r1, lsl #8
    8df0:	e1500381 	cmp	r0, r1, lsl #7
    8df4:	e0a22002 	adc	r2, r2, r2
    8df8:	20400381 	subcs	r0, r0, r1, lsl #7
    8dfc:	e1500301 	cmp	r0, r1, lsl #6
    8e00:	e0a22002 	adc	r2, r2, r2
    8e04:	20400301 	subcs	r0, r0, r1, lsl #6
    8e08:	e1500281 	cmp	r0, r1, lsl #5
    8e0c:	e0a22002 	adc	r2, r2, r2
    8e10:	20400281 	subcs	r0, r0, r1, lsl #5
    8e14:	e1500201 	cmp	r0, r1, lsl #4
    8e18:	e0a22002 	adc	r2, r2, r2
    8e1c:	20400201 	subcs	r0, r0, r1, lsl #4
    8e20:	e1500181 	cmp	r0, r1, lsl #3
    8e24:	e0a22002 	adc	r2, r2, r2
    8e28:	20400181 	subcs	r0, r0, r1, lsl #3
    8e2c:	e1500101 	cmp	r0, r1, lsl #2
    8e30:	e0a22002 	adc	r2, r2, r2
    8e34:	20400101 	subcs	r0, r0, r1, lsl #2
    8e38:	e1500081 	cmp	r0, r1, lsl #1
    8e3c:	e0a22002 	adc	r2, r2, r2
    8e40:	20400081 	subcs	r0, r0, r1, lsl #1
    8e44:	e1500001 	cmp	r0, r1
    8e48:	e0a22002 	adc	r2, r2, r2
    8e4c:	20400001 	subcs	r0, r0, r1
    8e50:	e1a00002 	mov	r0, r2
    8e54:	e12fff1e 	bx	lr
    8e58:	03a00001 	moveq	r0, #1
    8e5c:	13a00000 	movne	r0, #0
    8e60:	e12fff1e 	bx	lr
    8e64:	e16f2f11 	clz	r2, r1
    8e68:	e262201f 	rsb	r2, r2, #31
    8e6c:	e1a00230 	lsr	r0, r0, r2
    8e70:	e12fff1e 	bx	lr
    8e74:	e3500000 	cmp	r0, #0
    8e78:	13e00000 	mvnne	r0, #0
    8e7c:	ea000007 	b	8ea0 <__aeabi_idiv0>

00008e80 <__aeabi_uidivmod>:
__aeabi_uidivmod():
    8e80:	e3510000 	cmp	r1, #0
    8e84:	0afffffa 	beq	8e74 <__udivsi3+0x1e0>
    8e88:	e92d4003 	push	{r0, r1, lr}
    8e8c:	ebffff80 	bl	8c94 <__udivsi3>
    8e90:	e8bd4006 	pop	{r1, r2, lr}
    8e94:	e0030092 	mul	r3, r2, r0
    8e98:	e0411003 	sub	r1, r1, r3
    8e9c:	e12fff1e 	bx	lr

00008ea0 <__aeabi_idiv0>:
__aeabi_ldiv0():
    8ea0:	e12fff1e 	bx	lr

Disassembly of section .rodata:

00008ea4 <_ZL13Lock_Unlocked>:
    8ea4:	00000000 	andeq	r0, r0, r0

00008ea8 <_ZL11Lock_Locked>:
    8ea8:	00000001 	andeq	r0, r0, r1

00008eac <_ZL21MaxFSDriverNameLength>:
    8eac:	00000010 	andeq	r0, r0, r0, lsl r0

00008eb0 <_ZL17MaxFilenameLength>:
    8eb0:	00000010 	andeq	r0, r0, r0, lsl r0

00008eb4 <_ZL13MaxPathLength>:
    8eb4:	00000080 	andeq	r0, r0, r0, lsl #1

00008eb8 <_ZL18NoFilesystemDriver>:
    8eb8:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008ebc <_ZL9NotifyAll>:
    8ebc:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008ec0 <_ZL24Max_Process_Opened_Files>:
    8ec0:	00000010 	andeq	r0, r0, r0, lsl r0

00008ec4 <_ZL10Indefinite>:
    8ec4:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008ec8 <_ZL18Deadline_Unchanged>:
    8ec8:	fffffffe 			; <UNDEFINED> instruction: 0xfffffffe

00008ecc <_ZL14Invalid_Handle>:
    8ecc:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008ed0 <_ZN3halL18Default_Clock_RateE>:
    8ed0:	0ee6b280 	cdpeq	2, 14, cr11, cr6, cr0, {4}

00008ed4 <_ZN3halL15Peripheral_BaseE>:
    8ed4:	20000000 	andcs	r0, r0, r0

00008ed8 <_ZN3halL9GPIO_BaseE>:
    8ed8:	20200000 	eorcs	r0, r0, r0

00008edc <_ZN3halL14GPIO_Pin_CountE>:
    8edc:	00000036 	andeq	r0, r0, r6, lsr r0

00008ee0 <_ZN3halL8AUX_BaseE>:
    8ee0:	20215000 	eorcs	r5, r1, r0

00008ee4 <_ZN3halL25Interrupt_Controller_BaseE>:
    8ee4:	2000b200 	andcs	fp, r0, r0, lsl #4

00008ee8 <_ZN3halL10Timer_BaseE>:
    8ee8:	2000b400 	andcs	fp, r0, r0, lsl #8

00008eec <_ZN3halL9TRNG_BaseE>:
    8eec:	20104000 	andscs	r4, r0, r0

00008ef0 <_ZN3halL9BSC0_BaseE>:
    8ef0:	20205000 	eorcs	r5, r0, r0

00008ef4 <_ZN3halL9BSC1_BaseE>:
    8ef4:	20804000 	addcs	r4, r0, r0

00008ef8 <_ZN3halL9BSC2_BaseE>:
    8ef8:	20805000 	addcs	r5, r0, r0

00008efc <_ZN3halL14I2C_SLAVE_BaseE>:
    8efc:	20214000 	eorcs	r4, r1, r0

00008f00 <_ZL11Invalid_Pin>:
    8f00:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008f04 <_ZL24I2C_Transaction_Max_Size>:
    8f04:	00000008 	andeq	r0, r0, r8

00008f08 <_ZL17symbol_tick_delay>:
    8f08:	00000400 	andeq	r0, r0, r0, lsl #8

00008f0c <_ZL15char_tick_delay>:
    8f0c:	00001000 	andeq	r1, r0, r0
    8f10:	00000031 	andeq	r0, r0, r1, lsr r0
    8f14:	00000030 	andeq	r0, r0, r0, lsr r0
    8f18:	00676f6c 	rsbeq	r6, r7, ip, ror #30
    8f1c:	7473614d 	ldrbtvc	r6, [r3], #-333	; 0xfffffeb3
    8f20:	74207265 	strtvc	r7, [r0], #-613	; 0xfffffd9b
    8f24:	206b7361 	rsbcs	r7, fp, r1, ror #6
    8f28:	72617473 	rsbvc	r7, r1, #1929379840	; 0x73000000
    8f2c:	0a646574 	beq	1922504 <__bss_end+0x19194f8>
    8f30:	00000000 	andeq	r0, r0, r0
    8f34:	3a564544 	bcc	159a44c <__bss_end+0x1591440>
    8f38:	2f633269 	svccs	0x00633269
    8f3c:	00000031 	andeq	r0, r0, r1, lsr r0
    8f40:	6f727245 	svcvs	0x00727245
    8f44:	706f2072 	rsbvc	r2, pc, r2, ror r0	; <UNPREDICTABLE>
    8f48:	6e696e65 	cdpvs	14, 6, cr6, cr9, cr5, {3}
    8f4c:	32492067 	subcc	r2, r9, #103	; 0x67
    8f50:	616d2043 	cmnvs	sp, r3, asr #32
    8f54:	72657473 	rsbvc	r7, r5, #1929379840	; 0x73000000
    8f58:	6e6f6320 	cdpvs	3, 6, cr6, cr15, cr0, {1}
    8f5c:	7463656e 	strbtvc	r6, [r3], #-1390	; 0xfffffa92
    8f60:	0a6e6f69 	beq	1ba4d0c <__bss_end+0x1b9bd00>
    8f64:	00000000 	andeq	r0, r0, r0
    8f68:	20433249 	subcs	r3, r3, r9, asr #4
    8f6c:	6e6e6f63 	cdpvs	15, 6, cr6, cr14, cr3, {3}
    8f70:	69746365 	ldmdbvs	r4!, {r0, r2, r5, r6, r8, r9, sp, lr}^
    8f74:	6d206e6f 	stcvs	14, cr6, [r0, #-444]!	; 0xfffffe44
    8f78:	65747361 	ldrbvs	r7, [r4, #-865]!	; 0xfffffc9f
    8f7c:	74732072 	ldrbtvc	r2, [r3], #-114	; 0xffffff8e
    8f80:	65747261 	ldrbvs	r7, [r4, #-609]!	; 0xfffffd9f
    8f84:	2e2e2e64 	cdpcs	14, 2, cr2, cr14, cr4, {3}
    8f88:	0000000a 	andeq	r0, r0, sl
    8f8c:	6c6c6548 	cfstr64vs	mvdx6, [ip], #-288	; 0xfffffee0
    8f90:	7266206f 	rsbvc	r2, r6, #111	; 0x6f
    8f94:	6d206d6f 	stcvs	13, cr6, [r0, #-444]!	; 0xfffffe44
    8f98:	65747361 	ldrbvs	r7, [r4, #-865]!	; 0xfffffc9f
    8f9c:	00000a72 	andeq	r0, r0, r2, ror sl

00008fa0 <_ZL13Lock_Unlocked>:
    8fa0:	00000000 	andeq	r0, r0, r0

00008fa4 <_ZL11Lock_Locked>:
    8fa4:	00000001 	andeq	r0, r0, r1

00008fa8 <_ZL21MaxFSDriverNameLength>:
    8fa8:	00000010 	andeq	r0, r0, r0, lsl r0

00008fac <_ZL17MaxFilenameLength>:
    8fac:	00000010 	andeq	r0, r0, r0, lsl r0

00008fb0 <_ZL13MaxPathLength>:
    8fb0:	00000080 	andeq	r0, r0, r0, lsl #1

00008fb4 <_ZL18NoFilesystemDriver>:
    8fb4:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008fb8 <_ZL9NotifyAll>:
    8fb8:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008fbc <_ZL24Max_Process_Opened_Files>:
    8fbc:	00000010 	andeq	r0, r0, r0, lsl r0

00008fc0 <_ZL10Indefinite>:
    8fc0:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008fc4 <_ZL18Deadline_Unchanged>:
    8fc4:	fffffffe 			; <UNDEFINED> instruction: 0xfffffffe

00008fc8 <_ZL14Invalid_Handle>:
    8fc8:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008fcc <_ZL16Pipe_File_Prefix>:
    8fcc:	3a535953 	bcc	14df520 <__bss_end+0x14d6514>
    8fd0:	65706970 	ldrbvs	r6, [r0, #-2416]!	; 0xfffff690
    8fd4:	0000002f 	andeq	r0, r0, pc, lsr #32

00008fd8 <_ZN12_GLOBAL__N_1L11CharConvArrE>:
    8fd8:	33323130 	teqcc	r2, #48, 2
    8fdc:	37363534 			; <UNDEFINED> instruction: 0x37363534
    8fe0:	42413938 	submi	r3, r1, #56, 18	; 0xe0000
    8fe4:	46454443 	strbmi	r4, [r5], -r3, asr #8
	...

Disassembly of section .bss:

00008fec <led>:
__bss_start():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:17
uint32_t led, uart, master, log_fd;
    8fec:	00000000 	andeq	r0, r0, r0

00008ff0 <uart>:
    8ff0:	00000000 	andeq	r0, r0, r0

00008ff4 <master>:
    8ff4:	00000000 	andeq	r0, r0, r0

00008ff8 <log_fd>:
	...

Disassembly of section .ARM.attributes:

00000000 <.ARM.attributes>:
   0:	00002e41 	andeq	r2, r0, r1, asr #28
   4:	61656100 	cmnvs	r5, r0, lsl #2
   8:	01006962 	tsteq	r0, r2, ror #18
   c:	00000024 	andeq	r0, r0, r4, lsr #32
  10:	4b5a3605 	blmi	168d82c <__bss_end+0x1684820>
  14:	08070600 	stmdaeq	r7, {r9, sl}
  18:	0a010901 	beq	42424 <__bss_end+0x39418>
  1c:	14041202 	strne	r1, [r4], #-514	; 0xfffffdfe
  20:	17011501 	strne	r1, [r1, -r1, lsl #10]
  24:	1a011803 	bne	46038 <__bss_end+0x3d02c>
  28:	22011c01 	andcs	r1, r1, #256	; 0x100
  2c:	Address 0x000000000000002c is out of bounds.


Disassembly of section .comment:

00000000 <.comment>:
   0:	3a434347 	bcc	10d0d24 <__bss_end+0x10c7d18>
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
  38:	7a617661 	bvc	185d9c4 <__bss_end+0x18549b8>
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
  c0:	6a757a61 	bvs	1d5ea4c <__bss_end+0x1d55a40>
  c4:	2f696369 	svccs	0x00696369
  c8:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
  cc:	73656d65 	cmnvc	r5, #6464	; 0x1940
  d0:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
  d4:	6b2d616b 	blvs	b58688 <__bss_end+0xb4f67c>
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
 144:	fb010200 	blx	4094e <__bss_end+0x37942>
 148:	01000d0e 	tsteq	r0, lr, lsl #26
 14c:	00010101 	andeq	r0, r1, r1, lsl #2
 150:	00010000 	andeq	r0, r1, r0
 154:	552f0100 	strpl	r0, [pc, #-256]!	; 5c <shift+0x5c>
 158:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 15c:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 160:	6a726574 	bvs	1c99738 <__bss_end+0x1c9072c>
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
 198:	752f7365 	strvc	r7, [pc, #-869]!	; fffffe3b <__bss_end+0xffff6e2f>
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
 1d0:	0a05830b 	beq	160e04 <__bss_end+0x157df8>
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
 1fc:	4a030402 	bmi	c120c <__bss_end+0xb8200>
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
 230:	4a020402 	bmi	81240 <__bss_end+0x78234>
 234:	02000205 	andeq	r0, r0, #1342177280	; 0x50000000
 238:	052d0204 	streq	r0, [sp, #-516]!	; 0xfffffdfc
 23c:	01058509 	tsteq	r5, r9, lsl #10
 240:	000a022f 	andeq	r0, sl, pc, lsr #4
 244:	03020101 	movweq	r0, #8449	; 0x2101
 248:	00030000 	andeq	r0, r3, r0
 24c:	00000299 	muleq	r0, r9, r2
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
 280:	6a757a61 	bvs	1d5ec0c <__bss_end+0x1d55c00>
 284:	2f696369 	svccs	0x00696369
 288:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
 28c:	73656d65 	cmnvc	r5, #6464	; 0x1940
 290:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
 294:	6b2d616b 	blvs	b58848 <__bss_end+0xb4f83c>
 298:	6f2d7669 	svcvs	0x002d7669
 29c:	6f732f73 	svcvs	0x00732f73
 2a0:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
 2a4:	73752f73 	cmnvc	r5, #460	; 0x1cc
 2a8:	70737265 	rsbsvc	r7, r3, r5, ror #4
 2ac:	2f656361 	svccs	0x00656361
 2b0:	7473616d 	ldrbtvc	r6, [r3], #-365	; 0xfffffe93
 2b4:	745f7265 	ldrbvc	r7, [pc], #-613	; 2bc <shift+0x2bc>
 2b8:	006b7361 	rsbeq	r7, fp, r1, ror #6
 2bc:	6573552f 	ldrbvs	r5, [r3, #-1327]!	; 0xfffffad1
 2c0:	772f7372 			; <UNDEFINED> instruction: 0x772f7372
 2c4:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
 2c8:	2f696a72 	svccs	0x00696a72
 2cc:	6b736544 	blvs	1cd97e4 <__bss_end+0x1cd07d8>
 2d0:	2f706f74 	svccs	0x00706f74
 2d4:	2f564146 	svccs	0x00564146
 2d8:	6176614e 	cmnvs	r6, lr, asr #2
 2dc:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
 2e0:	4f2f6963 	svcmi	0x002f6963
 2e4:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
 2e8:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
 2ec:	6b6c6172 	blvs	1b188bc <__bss_end+0x1b0f8b0>
 2f0:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
 2f4:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
 2f8:	756f732f 	strbvc	r7, [pc, #-815]!	; ffffffd1 <__bss_end+0xffff6fc5>
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
 344:	6a757a61 	bvs	1d5ecd0 <__bss_end+0x1d55cc4>
 348:	2f696369 	svccs	0x00696369
 34c:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
 350:	73656d65 	cmnvc	r5, #6464	; 0x1940
 354:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
 358:	6b2d616b 	blvs	b5890c <__bss_end+0xb4f900>
 35c:	6f2d7669 	svcvs	0x002d7669
 360:	6f732f73 	svcvs	0x00732f73
 364:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
 368:	73752f73 	cmnvc	r5, #460	; 0x1cc
 36c:	70737265 	rsbsvc	r7, r3, r5, ror #4
 370:	2f656361 	svccs	0x00656361
 374:	6b2f2e2e 	blvs	bcbc34 <__bss_end+0xbc2c28>
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
 3a8:	6a757a61 	bvs	1d5ed34 <__bss_end+0x1d55d28>
 3ac:	2f696369 	svccs	0x00696369
 3b0:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
 3b4:	73656d65 	cmnvc	r5, #6464	; 0x1940
 3b8:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
 3bc:	6b2d616b 	blvs	b58970 <__bss_end+0xb4f964>
 3c0:	6f2d7669 	svcvs	0x002d7669
 3c4:	6f732f73 	svcvs	0x00732f73
 3c8:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
 3cc:	73752f73 	cmnvc	r5, #460	; 0x1cc
 3d0:	70737265 	rsbsvc	r7, r3, r5, ror #4
 3d4:	2f656361 	svccs	0x00656361
 3d8:	6b2f2e2e 	blvs	bcbc98 <__bss_end+0xbc2c8c>
 3dc:	656e7265 	strbvs	r7, [lr, #-613]!	; 0xfffffd9b
 3e0:	6e692f6c 	cdpvs	15, 6, cr2, cr9, cr12, {3}
 3e4:	64756c63 	ldrbtvs	r6, [r5], #-3171	; 0xfffff39d
 3e8:	6f622f65 	svcvs	0x00622f65
 3ec:	2f647261 	svccs	0x00647261
 3f0:	30697072 	rsbcc	r7, r9, r2, ror r0
 3f4:	6c61682f 	stclvs	8, cr6, [r1], #-188	; 0xffffff44
 3f8:	73552f00 	cmpvc	r5, #0, 30
 3fc:	2f737265 	svccs	0x00737265
 400:	746e6977 	strbtvc	r6, [lr], #-2423	; 0xfffff689
 404:	696a7265 	stmdbvs	sl!, {r0, r2, r5, r6, r9, ip, sp, lr}^
 408:	7365442f 	cmnvc	r5, #788529152	; 0x2f000000
 40c:	706f746b 	rsbvc	r7, pc, fp, ror #8
 410:	5641462f 	strbpl	r4, [r1], -pc, lsr #12
 414:	76614e2f 	strbtvc	r4, [r1], -pc, lsr #28
 418:	6a757a61 	bvs	1d5eda4 <__bss_end+0x1d55d98>
 41c:	2f696369 	svccs	0x00696369
 420:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
 424:	73656d65 	cmnvc	r5, #6464	; 0x1940
 428:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
 42c:	6b2d616b 	blvs	b589e0 <__bss_end+0xb4f9d4>
 430:	6f2d7669 	svcvs	0x002d7669
 434:	6f732f73 	svcvs	0x00732f73
 438:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
 43c:	73752f73 	cmnvc	r5, #460	; 0x1cc
 440:	70737265 	rsbsvc	r7, r3, r5, ror #4
 444:	2f656361 	svccs	0x00656361
 448:	6b2f2e2e 	blvs	bcbd08 <__bss_end+0xbc2cfc>
 44c:	656e7265 	strbvs	r7, [lr, #-613]!	; 0xfffffd9b
 450:	6e692f6c 	cdpvs	15, 6, cr2, cr9, cr12, {3}
 454:	64756c63 	ldrbtvs	r6, [r5], #-3171	; 0xfffff39d
 458:	72642f65 	rsbvc	r2, r4, #404	; 0x194
 45c:	72657669 	rsbvc	r7, r5, #110100480	; 0x6900000
 460:	6d000073 	stcvs	0, cr0, [r0, #-460]	; 0xfffffe34
 464:	2e6e6961 	vnmulcs.f16	s13, s28, s3	; <UNPREDICTABLE>
 468:	00707063 	rsbseq	r7, r0, r3, rrx
 46c:	73000001 	movwvc	r0, #1
 470:	682e6977 	stmdavs	lr!, {r0, r1, r2, r4, r5, r6, r8, fp, sp, lr}
 474:	00000200 	andeq	r0, r0, r0, lsl #4
 478:	6e697073 	mcrvs	0, 3, r7, cr9, cr3, {3}
 47c:	6b636f6c 	blvs	18dc234 <__bss_end+0x18d3228>
 480:	0200682e 	andeq	r6, r0, #3014656	; 0x2e0000
 484:	69660000 	stmdbvs	r6!, {}^	; <UNPREDICTABLE>
 488:	7973656c 	ldmdbvc	r3!, {r2, r3, r5, r6, r8, sl, sp, lr}^
 48c:	6d657473 	cfstrdvs	mvd7, [r5, #-460]!	; 0xfffffe34
 490:	0300682e 	movweq	r6, #2094	; 0x82e
 494:	72700000 	rsbsvc	r0, r0, #0
 498:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
 49c:	00682e73 	rsbeq	r2, r8, r3, ror lr
 4a0:	70000002 	andvc	r0, r0, r2
 4a4:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
 4a8:	6d5f7373 	ldclvs	3, cr7, [pc, #-460]	; 2e4 <shift+0x2e4>
 4ac:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
 4b0:	682e7265 	stmdavs	lr!, {r0, r2, r5, r6, r9, ip, sp, lr}
 4b4:	00000200 	andeq	r0, r0, r0, lsl #4
 4b8:	69726570 	ldmdbvs	r2!, {r4, r5, r6, r8, sl, sp, lr}^
 4bc:	72656870 	rsbvc	r6, r5, #112, 16	; 0x700000
 4c0:	2e736c61 	cdpcs	12, 7, cr6, cr3, cr1, {3}
 4c4:	00040068 	andeq	r0, r4, r8, rrx
 4c8:	69706700 	ldmdbvs	r0!, {r8, r9, sl, sp, lr}^
 4cc:	00682e6f 	rsbeq	r2, r8, pc, ror #28
 4d0:	69000005 	stmdbvs	r0, {r0, r2}
 4d4:	682e6332 	stmdavs	lr!, {r1, r4, r5, r8, r9, sp, lr}
 4d8:	00000500 	andeq	r0, r0, r0, lsl #10
 4dc:	64746e69 	ldrbtvs	r6, [r4], #-3689	; 0xfffff197
 4e0:	682e6665 	stmdavs	lr!, {r0, r2, r5, r6, r9, sl, sp, lr}
 4e4:	00000400 	andeq	r0, r0, r0, lsl #8
 4e8:	00010500 	andeq	r0, r1, r0, lsl #10
 4ec:	822c0205 	eorhi	r0, ip, #1342177280	; 0x50000000
 4f0:	13030000 	movwne	r0, #12288	; 0x3000
 4f4:	830a0501 	movwhi	r0, #42241	; 0xa501
 4f8:	054a1e05 	strbeq	r1, [sl, #-3589]	; 0xfffff1fb
 4fc:	0105660a 	tsteq	r5, sl, lsl #12
 500:	07058583 	streq	r8, [r5, -r3, lsl #11]
 504:	0567bb4b 	strbeq	fp, [r7, #-2891]!	; 0xfffff4b5
 508:	05a1bb01 	streq	fp, [r1, #2817]!	; 0xb01
 50c:	0c05a112 	stfeqd	f2, [r5], {18}
 510:	4d080582 	cfstr32mi	mvfx0, [r8, #-520]	; 0xfffffdf8
 514:	054d1205 	strbeq	r1, [sp, #-517]	; 0xfffffdfb
 518:	1005820c 	andne	r8, r5, ip, lsl #4
 51c:	4a05054b 	bmi	141a50 <__bss_end+0x138a44>
 520:	054b0c05 	strbeq	r0, [fp, #-3077]	; 0xfffff3fb
 524:	08054b10 	stmdaeq	r5, {r4, r8, r9, fp, lr}
 528:	000c054c 	andeq	r0, ip, ip, asr #10
 52c:	4c010402 	cfstrsmi	mvf0, [r1], {2}
 530:	02000e05 	andeq	r0, r0, #5, 28	; 0x50
 534:	054b0104 	strbeq	r0, [fp, #-260]	; 0xfffffefc
 538:	0402000c 	streq	r0, [r2], #-12
 53c:	01056501 	tsteq	r5, r1, lsl #10
 540:	01040200 	mrseq	r0, R12_usr
 544:	022e0903 	eoreq	r0, lr, #49152	; 0xc000
 548:	01010016 	tsteq	r1, r6, lsl r0
 54c:	000002c8 	andeq	r0, r0, r8, asr #5
 550:	01dd0003 	bicseq	r0, sp, r3
 554:	01020000 	mrseq	r0, (UNDEF: 2)
 558:	000d0efb 	strdeq	r0, [sp], -fp
 55c:	01010101 	tsteq	r1, r1, lsl #2
 560:	01000000 	mrseq	r0, (UNDEF: 0)
 564:	2f010000 	svccs	0x00010000
 568:	72657355 	rsbvc	r7, r5, #1409286145	; 0x54000001
 56c:	69772f73 	ldmdbvs	r7!, {r0, r1, r4, r5, r6, r8, r9, sl, fp, sp}^
 570:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
 574:	442f696a 	strtmi	r6, [pc], #-2410	; 57c <shift+0x57c>
 578:	746b7365 	strbtvc	r7, [fp], #-869	; 0xfffffc9b
 57c:	462f706f 	strtmi	r7, [pc], -pc, rrx
 580:	4e2f5641 	cfmadda32mi	mvax2, mvax5, mvfx15, mvfx1
 584:	7a617661 	bvc	185df10 <__bss_end+0x1854f04>
 588:	63696a75 	cmnvs	r9, #479232	; 0x75000
 58c:	534f2f69 	movtpl	r2, #65385	; 0xff69
 590:	6d65732f 	stclvs	3, cr7, [r5, #-188]!	; 0xffffff44
 594:	72747365 	rsbsvc	r7, r4, #-1811939327	; 0x94000001
 598:	616b6c61 	cmnvs	fp, r1, ror #24
 59c:	76696b2d 	strbtvc	r6, [r9], -sp, lsr #22
 5a0:	2f736f2d 	svccs	0x00736f2d
 5a4:	72756f73 	rsbsvc	r6, r5, #460	; 0x1cc
 5a8:	2f736563 	svccs	0x00736563
 5ac:	6c647473 	cfstrdvs	mvd7, [r4], #-460	; 0xfffffe34
 5b0:	732f6269 			; <UNDEFINED> instruction: 0x732f6269
 5b4:	2f006372 	svccs	0x00006372
 5b8:	72657355 	rsbvc	r7, r5, #1409286145	; 0x54000001
 5bc:	69772f73 	ldmdbvs	r7!, {r0, r1, r4, r5, r6, r8, r9, sl, fp, sp}^
 5c0:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
 5c4:	442f696a 	strtmi	r6, [pc], #-2410	; 5cc <shift+0x5cc>
 5c8:	746b7365 	strbtvc	r7, [fp], #-869	; 0xfffffc9b
 5cc:	462f706f 	strtmi	r7, [pc], -pc, rrx
 5d0:	4e2f5641 	cfmadda32mi	mvax2, mvax5, mvfx15, mvfx1
 5d4:	7a617661 	bvc	185df60 <__bss_end+0x1854f54>
 5d8:	63696a75 	cmnvs	r9, #479232	; 0x75000
 5dc:	534f2f69 	movtpl	r2, #65385	; 0xff69
 5e0:	6d65732f 	stclvs	3, cr7, [r5, #-188]!	; 0xffffff44
 5e4:	72747365 	rsbsvc	r7, r4, #-1811939327	; 0x94000001
 5e8:	616b6c61 	cmnvs	fp, r1, ror #24
 5ec:	76696b2d 	strbtvc	r6, [r9], -sp, lsr #22
 5f0:	2f736f2d 	svccs	0x00736f2d
 5f4:	72756f73 	rsbsvc	r6, r5, #460	; 0x1cc
 5f8:	2f736563 	svccs	0x00736563
 5fc:	6e72656b 	cdpvs	5, 7, cr6, cr2, cr11, {3}
 600:	692f6c65 	stmdbvs	pc!, {r0, r2, r5, r6, sl, fp, sp, lr}	; <UNPREDICTABLE>
 604:	756c636e 	strbvc	r6, [ip, #-878]!	; 0xfffffc92
 608:	702f6564 	eorvc	r6, pc, r4, ror #10
 60c:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
 610:	2f007373 	svccs	0x00007373
 614:	72657355 	rsbvc	r7, r5, #1409286145	; 0x54000001
 618:	69772f73 	ldmdbvs	r7!, {r0, r1, r4, r5, r6, r8, r9, sl, fp, sp}^
 61c:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
 620:	442f696a 	strtmi	r6, [pc], #-2410	; 628 <shift+0x628>
 624:	746b7365 	strbtvc	r7, [fp], #-869	; 0xfffffc9b
 628:	462f706f 	strtmi	r7, [pc], -pc, rrx
 62c:	4e2f5641 	cfmadda32mi	mvax2, mvax5, mvfx15, mvfx1
 630:	7a617661 	bvc	185dfbc <__bss_end+0x1854fb0>
 634:	63696a75 	cmnvs	r9, #479232	; 0x75000
 638:	534f2f69 	movtpl	r2, #65385	; 0xff69
 63c:	6d65732f 	stclvs	3, cr7, [r5, #-188]!	; 0xffffff44
 640:	72747365 	rsbsvc	r7, r4, #-1811939327	; 0x94000001
 644:	616b6c61 	cmnvs	fp, r1, ror #24
 648:	76696b2d 	strbtvc	r6, [r9], -sp, lsr #22
 64c:	2f736f2d 	svccs	0x00736f2d
 650:	72756f73 	rsbsvc	r6, r5, #460	; 0x1cc
 654:	2f736563 	svccs	0x00736563
 658:	6e72656b 	cdpvs	5, 7, cr6, cr2, cr11, {3}
 65c:	692f6c65 	stmdbvs	pc!, {r0, r2, r5, r6, sl, fp, sp, lr}	; <UNPREDICTABLE>
 660:	756c636e 	strbvc	r6, [ip, #-878]!	; 0xfffffc92
 664:	662f6564 	strtvs	r6, [pc], -r4, ror #10
 668:	552f0073 	strpl	r0, [pc, #-115]!	; 5fd <shift+0x5fd>
 66c:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 670:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 674:	6a726574 	bvs	1c99c4c <__bss_end+0x1c90c40>
 678:	65442f69 	strbvs	r2, [r4, #-3945]	; 0xfffff097
 67c:	6f746b73 	svcvs	0x00746b73
 680:	41462f70 	hvcmi	25328	; 0x62f0
 684:	614e2f56 	cmpvs	lr, r6, asr pc
 688:	757a6176 	ldrbvc	r6, [sl, #-374]!	; 0xfffffe8a
 68c:	6963696a 	stmdbvs	r3!, {r1, r3, r5, r6, r8, fp, sp, lr}^
 690:	2f534f2f 	svccs	0x00534f2f
 694:	656d6573 	strbvs	r6, [sp, #-1395]!	; 0xfffffa8d
 698:	61727473 	cmnvs	r2, r3, ror r4
 69c:	2d616b6c 	vstmdbcs	r1!, {d22-<overflow reg d75>}
 6a0:	2d76696b 			; <UNDEFINED> instruction: 0x2d76696b
 6a4:	732f736f 			; <UNDEFINED> instruction: 0x732f736f
 6a8:	6372756f 	cmnvs	r2, #465567744	; 0x1bc00000
 6ac:	6b2f7365 	blvs	bdd448 <__bss_end+0xbd443c>
 6b0:	656e7265 	strbvs	r7, [lr, #-613]!	; 0xfffffd9b
 6b4:	6e692f6c 	cdpvs	15, 6, cr2, cr9, cr12, {3}
 6b8:	64756c63 	ldrbtvs	r6, [r5], #-3171	; 0xfffff39d
 6bc:	6f622f65 	svcvs	0x00622f65
 6c0:	2f647261 	svccs	0x00647261
 6c4:	30697072 	rsbcc	r7, r9, r2, ror r0
 6c8:	6c61682f 	stclvs	8, cr6, [r1], #-188	; 0xffffff44
 6cc:	74730000 	ldrbtvc	r0, [r3], #-0
 6d0:	6c696664 	stclvs	6, cr6, [r9], #-400	; 0xfffffe70
 6d4:	70632e65 	rsbvc	r2, r3, r5, ror #28
 6d8:	00010070 	andeq	r0, r1, r0, ror r0
 6dc:	69777300 	ldmdbvs	r7!, {r8, r9, ip, sp, lr}^
 6e0:	0200682e 	andeq	r6, r0, #3014656	; 0x2e0000
 6e4:	70730000 	rsbsvc	r0, r3, r0
 6e8:	6f6c6e69 	svcvs	0x006c6e69
 6ec:	682e6b63 	stmdavs	lr!, {r0, r1, r5, r6, r8, r9, fp, sp, lr}
 6f0:	00000200 	andeq	r0, r0, r0, lsl #4
 6f4:	656c6966 	strbvs	r6, [ip, #-2406]!	; 0xfffff69a
 6f8:	74737973 	ldrbtvc	r7, [r3], #-2419	; 0xfffff68d
 6fc:	682e6d65 	stmdavs	lr!, {r0, r2, r5, r6, r8, sl, fp, sp, lr}
 700:	00000300 	andeq	r0, r0, r0, lsl #6
 704:	636f7270 	cmnvs	pc, #112, 4
 708:	2e737365 	cdpcs	3, 7, cr7, cr3, cr5, {3}
 70c:	00020068 	andeq	r0, r2, r8, rrx
 710:	6f727000 	svcvs	0x00727000
 714:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
 718:	6e616d5f 	mcrvs	13, 3, r6, cr1, cr15, {2}
 71c:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
 720:	0200682e 	andeq	r6, r0, #3014656	; 0x2e0000
 724:	6e690000 	cdpvs	0, 6, cr0, cr9, cr0, {0}
 728:	66656474 			; <UNDEFINED> instruction: 0x66656474
 72c:	0400682e 	streq	r6, [r0], #-2094	; 0xfffff7d2
 730:	05000000 	streq	r0, [r0, #-0]
 734:	02050001 	andeq	r0, r5, #1
 738:	00008380 	andeq	r8, r0, r0, lsl #7
 73c:	69050516 	stmdbvs	r5, {r1, r2, r4, r8, sl}
 740:	4c0c052f 	cfstr32mi	mvfx0, [ip], {47}	; 0x2f
 744:	852f0105 	strhi	r0, [pc, #-261]!	; 647 <shift+0x647>
 748:	4b830505 	blmi	fe0c1b64 <__bss_end+0xfe0b8b58>
 74c:	852f0105 	strhi	r0, [pc, #-261]!	; 64f <shift+0x64f>
 750:	054b0505 	strbeq	r0, [fp, #-1285]	; 0xfffffafb
 754:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 758:	4b4ba105 	blmi	12e8b74 <__bss_end+0x12dfb68>
 75c:	4b0c052f 	blmi	301c20 <__bss_end+0x2f8c14>
 760:	852f0105 	strhi	r0, [pc, #-261]!	; 663 <shift+0x663>
 764:	4bbd0505 	blmi	fef41b80 <__bss_end+0xfef38b74>
 768:	052f4b4b 	streq	r4, [pc, #-2891]!	; fffffc25 <__bss_end+0xffff6c19>
 76c:	01054c0c 	tsteq	r5, ip, lsl #24
 770:	0505852f 	streq	r8, [r5, #-1327]	; 0xfffffad1
 774:	4b4b4bbd 	blmi	12d3670 <__bss_end+0x12ca664>
 778:	4c0c052f 	cfstr32mi	mvfx0, [ip], {47}	; 0x2f
 77c:	852f0105 	strhi	r0, [pc, #-261]!	; 67f <shift+0x67f>
 780:	4b830505 	blmi	fe0c1b9c <__bss_end+0xfe0b8b90>
 784:	852f0105 	strhi	r0, [pc, #-261]!	; 687 <shift+0x687>
 788:	4bbd0505 	blmi	fef41ba4 <__bss_end+0xfef38b98>
 78c:	052f4b4b 	streq	r4, [pc, #-2891]!	; fffffc49 <__bss_end+0xffff6c3d>
 790:	01054c0c 	tsteq	r5, ip, lsl #24
 794:	0505852f 	streq	r8, [r5, #-1327]	; 0xfffffad1
 798:	2f4b4ba1 	svccs	0x004b4ba1
 79c:	054c0c05 	strbeq	r0, [ip, #-3077]	; 0xfffff3fb
 7a0:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 7a4:	4b4bbd05 	blmi	12efbc0 <__bss_end+0x12e6bb4>
 7a8:	0c052f4b 	stceq	15, cr2, [r5], {75}	; 0x4b
 7ac:	2f01054c 	svccs	0x0001054c
 7b0:	a1050585 	smlabbge	r5, r5, r5, r0
 7b4:	052f4b4b 	streq	r4, [pc, #-2891]!	; fffffc71 <__bss_end+0xffff6c65>
 7b8:	01054c0c 	tsteq	r5, ip, lsl #24
 7bc:	2005859f 	mulcs	r5, pc, r5	; <UNPREDICTABLE>
 7c0:	4d050567 	cfstr32mi	mvfx0, [r5, #-412]	; 0xfffffe64
 7c4:	0c054b4b 			; <UNDEFINED> instruction: 0x0c054b4b
 7c8:	2f010530 	svccs	0x00010530
 7cc:	67200585 	strvs	r0, [r0, -r5, lsl #11]!
 7d0:	4b4d0505 	blmi	1341bec <__bss_end+0x1338be0>
 7d4:	300c054b 	andcc	r0, ip, fp, asr #10
 7d8:	852f0105 	strhi	r0, [pc, #-261]!	; 6db <shift+0x6db>
 7dc:	05832005 	streq	r2, [r3, #5]
 7e0:	4b4b4c05 	blmi	12d37fc <__bss_end+0x12ca7f0>
 7e4:	852f0105 	strhi	r0, [pc, #-261]!	; 6e7 <shift+0x6e7>
 7e8:	05672005 	strbeq	r2, [r7, #-5]!
 7ec:	4b4b4d05 	blmi	12d3c08 <__bss_end+0x12cabfc>
 7f0:	05300c05 	ldreq	r0, [r0, #-3077]!	; 0xfffff3fb
 7f4:	05872f01 	streq	r2, [r7, #3841]	; 0xf01
 7f8:	059fa00c 	ldreq	sl, [pc, #12]	; 80c <shift+0x80c>
 7fc:	2905bc31 	stmdbcs	r5, {r0, r4, r5, sl, fp, ip, sp, pc}
 800:	2e360566 	cdpcs	5, 3, cr0, cr6, cr6, {3}
 804:	05300f05 	ldreq	r0, [r0, #-3845]!	; 0xfffff0fb
 808:	09056613 	stmdbeq	r5, {r0, r1, r4, r9, sl, sp, lr}
 80c:	d8100584 	ldmdale	r0, {r2, r7, r8, sl}
 810:	029f0105 	addseq	r0, pc, #1073741825	; 0x40000001
 814:	01010008 	tsteq	r1, r8
 818:	0000029b 	muleq	r0, fp, r2
 81c:	00740003 	rsbseq	r0, r4, r3
 820:	01020000 	mrseq	r0, (UNDEF: 2)
 824:	000d0efb 	strdeq	r0, [sp], -fp
 828:	01010101 	tsteq	r1, r1, lsl #2
 82c:	01000000 	mrseq	r0, (UNDEF: 0)
 830:	2f010000 	svccs	0x00010000
 834:	72657355 	rsbvc	r7, r5, #1409286145	; 0x54000001
 838:	69772f73 	ldmdbvs	r7!, {r0, r1, r4, r5, r6, r8, r9, sl, fp, sp}^
 83c:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
 840:	442f696a 	strtmi	r6, [pc], #-2410	; 848 <shift+0x848>
 844:	746b7365 	strbtvc	r7, [fp], #-869	; 0xfffffc9b
 848:	462f706f 	strtmi	r7, [pc], -pc, rrx
 84c:	4e2f5641 	cfmadda32mi	mvax2, mvax5, mvfx15, mvfx1
 850:	7a617661 	bvc	185e1dc <__bss_end+0x18551d0>
 854:	63696a75 	cmnvs	r9, #479232	; 0x75000
 858:	534f2f69 	movtpl	r2, #65385	; 0xff69
 85c:	6d65732f 	stclvs	3, cr7, [r5, #-188]!	; 0xffffff44
 860:	72747365 	rsbsvc	r7, r4, #-1811939327	; 0x94000001
 864:	616b6c61 	cmnvs	fp, r1, ror #24
 868:	76696b2d 	strbtvc	r6, [r9], -sp, lsr #22
 86c:	2f736f2d 	svccs	0x00736f2d
 870:	72756f73 	rsbsvc	r6, r5, #460	; 0x1cc
 874:	2f736563 	svccs	0x00736563
 878:	6c647473 	cfstrdvs	mvd7, [r4], #-460	; 0xfffffe34
 87c:	732f6269 			; <UNDEFINED> instruction: 0x732f6269
 880:	00006372 	andeq	r6, r0, r2, ror r3
 884:	73647473 	cmnvc	r4, #1929379840	; 0x73000000
 888:	6e697274 	mcrvs	2, 3, r7, cr9, cr4, {3}
 88c:	70632e67 	rsbvc	r2, r3, r7, ror #28
 890:	00010070 	andeq	r0, r1, r0, ror r0
 894:	01050000 	mrseq	r0, (UNDEF: 5)
 898:	dc020500 	cfstr32le	mvfx0, [r2], {-0}
 89c:	1a000087 	bne	ac0 <shift+0xac0>
 8a0:	05bb0605 	ldreq	r0, [fp, #1541]!	; 0x605
 8a4:	21054c0f 	tstcs	r5, pc, lsl #24
 8a8:	ba0a0568 	blt	281e50 <__bss_end+0x278e44>
 8ac:	052e0b05 	streq	r0, [lr, #-2821]!	; 0xfffff4fb
 8b0:	0d054a27 	vstreq	s8, [r5, #-156]	; 0xffffff64
 8b4:	2f09054a 	svccs	0x0009054a
 8b8:	059f0405 	ldreq	r0, [pc, #1029]	; cc5 <shift+0xcc5>
 8bc:	05056202 	streq	r6, [r5, #-514]	; 0xfffffdfe
 8c0:	68100535 	ldmdavs	r0, {r0, r2, r4, r5, r8, sl}
 8c4:	052e1105 	streq	r1, [lr, #-261]!	; 0xfffffefb
 8c8:	13054a22 	movwne	r4, #23074	; 0x5a22
 8cc:	2f0a052e 	svccs	0x000a052e
 8d0:	05690905 	strbeq	r0, [r9, #-2309]!	; 0xfffff6fb
 8d4:	0c052e0a 	stceq	14, cr2, [r5], {10}
 8d8:	4b03054a 	blmi	c1e08 <__bss_end+0xb8dfc>
 8dc:	05680b05 	strbeq	r0, [r8, #-2821]!	; 0xfffff4fb
 8e0:	04020018 	streq	r0, [r2], #-24	; 0xffffffe8
 8e4:	14054a03 	strne	r4, [r5], #-2563	; 0xfffff5fd
 8e8:	03040200 	movweq	r0, #16896	; 0x4200
 8ec:	0015059e 	mulseq	r5, lr, r5
 8f0:	68020402 	stmdavs	r2, {r1, sl}
 8f4:	02001805 	andeq	r1, r0, #327680	; 0x50000
 8f8:	05820204 	streq	r0, [r2, #516]	; 0x204
 8fc:	04020008 	streq	r0, [r2], #-8
 900:	1a054a02 	bne	153110 <__bss_end+0x14a104>
 904:	02040200 	andeq	r0, r4, #0, 4
 908:	001b054b 	andseq	r0, fp, fp, asr #10
 90c:	2e020402 	cdpcs	4, 0, cr0, cr2, cr2, {0}
 910:	02000c05 	andeq	r0, r0, #1280	; 0x500
 914:	054a0204 	strbeq	r0, [sl, #-516]	; 0xfffffdfc
 918:	0402000f 	streq	r0, [r2], #-15
 91c:	1b058202 	blne	16112c <__bss_end+0x158120>
 920:	02040200 	andeq	r0, r4, #0, 4
 924:	0011054a 	andseq	r0, r1, sl, asr #10
 928:	2e020402 	cdpcs	4, 0, cr0, cr2, cr2, {0}
 92c:	02000a05 	andeq	r0, r0, #20480	; 0x5000
 930:	052f0204 	streq	r0, [pc, #-516]!	; 734 <shift+0x734>
 934:	0402000b 	streq	r0, [r2], #-11
 938:	0d052e02 	stceq	14, cr2, [r5, #-8]
 93c:	02040200 	andeq	r0, r4, #0, 4
 940:	0002054a 	andeq	r0, r2, sl, asr #10
 944:	46020402 	strmi	r0, [r2], -r2, lsl #8
 948:	85880105 	strhi	r0, [r8, #261]	; 0x105
 94c:	05830605 	streq	r0, [r3, #1541]	; 0x605
 950:	10054c09 	andne	r4, r5, r9, lsl #24
 954:	4c0a054a 	cfstr32mi	mvfx0, [sl], {74}	; 0x4a
 958:	05bb0705 	ldreq	r0, [fp, #1797]!	; 0x705
 95c:	17054a03 	strne	r4, [r5, -r3, lsl #20]
 960:	01040200 	mrseq	r0, R12_usr
 964:	0014054a 	andseq	r0, r4, sl, asr #10
 968:	4a010402 	bmi	41978 <__bss_end+0x3896c>
 96c:	054d0d05 	strbeq	r0, [sp, #-3333]	; 0xfffff2fb
 970:	0a054a14 	beq	1531c8 <__bss_end+0x14a1bc>
 974:	6808052e 	stmdavs	r8, {r1, r2, r3, r5, r8, sl}
 978:	78030205 	stmdavc	r3, {r0, r2, r9}
 97c:	03090566 	movweq	r0, #38246	; 0x9566
 980:	01052e0b 	tsteq	r5, fp, lsl #28
 984:	0905852f 	stmdbeq	r5, {r0, r1, r2, r3, r5, r8, sl, pc}
 988:	001605bd 			; <UNDEFINED> instruction: 0x001605bd
 98c:	4a040402 	bmi	10199c <__bss_end+0xf8990>
 990:	02001d05 	andeq	r1, r0, #320	; 0x140
 994:	05820204 	streq	r0, [r2, #516]	; 0x204
 998:	0402001e 	streq	r0, [r2], #-30	; 0xffffffe2
 99c:	16052e02 	strne	r2, [r5], -r2, lsl #28
 9a0:	02040200 	andeq	r0, r4, #0, 4
 9a4:	00110566 	andseq	r0, r1, r6, ror #10
 9a8:	4b030402 	blmi	c19b8 <__bss_end+0xb89ac>
 9ac:	02001205 	andeq	r1, r0, #1342177280	; 0x50000000
 9b0:	052e0304 	streq	r0, [lr, #-772]!	; 0xfffffcfc
 9b4:	04020008 	streq	r0, [r2], #-8
 9b8:	09054a03 	stmdbeq	r5, {r0, r1, r9, fp, lr}
 9bc:	03040200 	movweq	r0, #16896	; 0x4200
 9c0:	0012052e 	andseq	r0, r2, lr, lsr #10
 9c4:	4a030402 	bmi	c19d4 <__bss_end+0xb89c8>
 9c8:	02000b05 	andeq	r0, r0, #5120	; 0x1400
 9cc:	052e0304 	streq	r0, [lr, #-772]!	; 0xfffffcfc
 9d0:	04020002 	streq	r0, [r2], #-2
 9d4:	0b052d03 	bleq	14bde8 <__bss_end+0x142ddc>
 9d8:	02040200 	andeq	r0, r4, #0, 4
 9dc:	00080584 	andeq	r0, r8, r4, lsl #11
 9e0:	83010402 	movwhi	r0, #5122	; 0x1402
 9e4:	02000905 	andeq	r0, r0, #81920	; 0x14000
 9e8:	052e0104 	streq	r0, [lr, #-260]!	; 0xfffffefc
 9ec:	0402000b 	streq	r0, [r2], #-11
 9f0:	02054a01 	andeq	r4, r5, #4096	; 0x1000
 9f4:	01040200 	mrseq	r0, R12_usr
 9f8:	850b0549 	strhi	r0, [fp, #-1353]	; 0xfffffab7
 9fc:	852f0105 	strhi	r0, [pc, #-261]!	; 8ff <shift+0x8ff>
 a00:	05bc0e05 	ldreq	r0, [ip, #3589]!	; 0xe05
 a04:	20056611 	andcs	r6, r5, r1, lsl r6
 a08:	660b05bc 			; <UNDEFINED> instruction: 0x660b05bc
 a0c:	054b1f05 	strbeq	r1, [fp, #-3845]	; 0xfffff0fb
 a10:	0805660a 	stmdaeq	r5, {r1, r3, r9, sl, sp, lr}
 a14:	8311054b 	tsthi	r1, #314572800	; 0x12c00000
 a18:	052e1605 	streq	r1, [lr, #-1541]!	; 0xfffff9fb
 a1c:	11056708 	tstne	r5, r8, lsl #14
 a20:	4d0b0567 	cfstr32mi	mvfx0, [fp, #-412]	; 0xfffffe64
 a24:	852f0105 	strhi	r0, [pc, #-261]!	; 927 <shift+0x927>
 a28:	05830605 	streq	r0, [r3, #1541]	; 0x605
 a2c:	0c054c0b 	stceq	12, cr4, [r5], {11}
 a30:	660e052e 	strvs	r0, [lr], -lr, lsr #10
 a34:	054b0405 	strbeq	r0, [fp, #-1029]	; 0xfffffbfb
 a38:	09056502 	stmdbeq	r5, {r1, r8, sl, sp, lr}
 a3c:	2f010531 	svccs	0x00010531
 a40:	9f080585 	svcls	0x00080585
 a44:	054c0b05 	strbeq	r0, [ip, #-2821]	; 0xfffff4fb
 a48:	04020014 	streq	r0, [r2], #-20	; 0xffffffec
 a4c:	07054a03 	streq	r4, [r5, -r3, lsl #20]
 a50:	02040200 	andeq	r0, r4, #0, 4
 a54:	00080583 	andeq	r0, r8, r3, lsl #11
 a58:	2e020402 	cdpcs	4, 0, cr0, cr2, cr2, {0}
 a5c:	02000a05 	andeq	r0, r0, #20480	; 0x5000
 a60:	054a0204 	strbeq	r0, [sl, #-516]	; 0xfffffdfc
 a64:	04020002 	streq	r0, [r2], #-2
 a68:	01054902 	tsteq	r5, r2, lsl #18
 a6c:	0e058584 	cfsh32eq	mvfx8, mvfx5, #-60
 a70:	4b0805bb 	blmi	202164 <__bss_end+0x1f9158>
 a74:	054c0b05 	strbeq	r0, [ip, #-2821]	; 0xfffff4fb
 a78:	04020014 	streq	r0, [r2], #-20	; 0xffffffec
 a7c:	16054a03 	strne	r4, [r5], -r3, lsl #20
 a80:	02040200 	andeq	r0, r4, #0, 4
 a84:	00170583 	andseq	r0, r7, r3, lsl #11
 a88:	2e020402 	cdpcs	4, 0, cr0, cr2, cr2, {0}
 a8c:	02000a05 	andeq	r0, r0, #20480	; 0x5000
 a90:	054a0204 	strbeq	r0, [sl, #-516]	; 0xfffffdfc
 a94:	0402000b 	streq	r0, [r2], #-11
 a98:	17052e02 	strne	r2, [r5, -r2, lsl #28]
 a9c:	02040200 	andeq	r0, r4, #0, 4
 aa0:	000d054a 	andeq	r0, sp, sl, asr #10
 aa4:	2e020402 	cdpcs	4, 0, cr0, cr2, cr2, {0}
 aa8:	02000205 	andeq	r0, r0, #1342177280	; 0x50000000
 aac:	052d0204 	streq	r0, [sp, #-516]!	; 0xfffffdfc
 ab0:	08028401 	stmdaeq	r2, {r0, sl, pc}
 ab4:	Address 0x0000000000000ab4 is out of bounds.


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
      58:	0a6a0704 	beq	1a81c70 <__bss_end+0x1a78c64>
      5c:	5b020000 	blpl	80064 <__bss_end+0x77058>
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
     128:	00000a6a 	andeq	r0, r0, sl, ror #20
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
     174:	cb104801 	blgt	412180 <__bss_end+0x409174>
     178:	d4000000 	strle	r0, [r0], #-0
     17c:	58000081 	stmdapl	r0, {r0, r7}
     180:	01000000 	mrseq	r0, (UNDEF: 0)
     184:	0000cb9c 	muleq	r0, ip, fp
     188:	02b40a00 	adcseq	r0, r4, #0, 20
     18c:	4a010000 	bmi	40194 <__bss_end+0x37188>
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
     21c:	ba0d9c01 	blt	367228 <__bss_end+0x35e21c>
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
     24c:	8b120f01 	blhi	483e58 <__bss_end+0x47ae4c>
     250:	0f000001 	svceq	0x00000001
     254:	0000019e 	muleq	r0, lr, r1
     258:	03d51000 	bicseq	r1, r5, #0
     25c:	0a010000 	beq	40264 <__bss_end+0x37258>
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
     2b4:	8b140074 	blhi	50048c <__bss_end+0x4f7480>
     2b8:	a4000001 	strge	r0, [r0], #-1
     2bc:	38000080 	stmdacc	r0, {r7}
     2c0:	01000000 	mrseq	r0, (UNDEF: 0)
     2c4:	0067139c 	mlseq	r7, ip, r3, r1
     2c8:	9e2f0a01 	vmulls.f32	s0, s30, s2
     2cc:	02000001 	andeq	r0, r0, #1
     2d0:	00007491 	muleq	r0, r1, r4
     2d4:	00000879 	andeq	r0, r0, r9, ror r8
     2d8:	01e00004 	mvneq	r0, r4
     2dc:	01040000 	mrseq	r0, (UNDEF: 4)
     2e0:	000001e1 	andeq	r0, r0, r1, ror #3
     2e4:	0006e704 	andeq	lr, r6, r4, lsl #14
     2e8:	00005600 	andeq	r5, r0, r0, lsl #12
     2ec:	00822c00 	addeq	r2, r2, r0, lsl #24
     2f0:	00015400 	andeq	r5, r1, r0, lsl #8
     2f4:	00024600 	andeq	r4, r2, r0, lsl #12
     2f8:	08010200 	stmdaeq	r1, {r9}
     2fc:	00000aff 	strdeq	r0, [r0], -pc	; <UNPREDICTABLE>
     300:	00002503 	andeq	r2, r0, r3, lsl #10
     304:	05020200 	streq	r0, [r2, #-512]	; 0xfffffe00
     308:	000009c4 	andeq	r0, r0, r4, asr #19
     30c:	69050404 	stmdbvs	r5, {r2, sl}
     310:	0200746e 	andeq	r7, r0, #1845493760	; 0x6e000000
     314:	0af60801 	beq	ffd82320 <__bss_end+0xffd79314>
     318:	02020000 	andeq	r0, r2, #0
     31c:	000bad07 	andeq	sl, fp, r7, lsl #26
     320:	060f0500 	streq	r0, [pc], -r0, lsl #10
     324:	090a0000 	stmdbeq	sl, {}	; <UNPREDICTABLE>
     328:	00005e07 	andeq	r5, r0, r7, lsl #28
     32c:	004d0300 	subeq	r0, sp, r0, lsl #6
     330:	04020000 	streq	r0, [r2], #-0
     334:	000a6a07 	andeq	r6, sl, r7, lsl #20
     338:	005e0300 	subseq	r0, lr, r0, lsl #6
     33c:	5d060000 	stcpl	0, cr0, [r6, #-0]
     340:	0800000c 	stmdaeq	r0, {r2, r3}
     344:	90080602 	andls	r0, r8, r2, lsl #12
     348:	07000000 	streq	r0, [r0, -r0]
     34c:	02003072 	andeq	r3, r0, #114	; 0x72
     350:	004d0e08 	subeq	r0, sp, r8, lsl #28
     354:	07000000 	streq	r0, [r0, -r0]
     358:	02003172 	andeq	r3, r0, #-2147483620	; 0x8000001c
     35c:	004d0e09 	subeq	r0, sp, r9, lsl #28
     360:	00040000 	andeq	r0, r4, r0
     364:	000a0f08 	andeq	r0, sl, r8, lsl #30
     368:	38040500 	stmdacc	r4, {r8, sl}
     36c:	02000000 	andeq	r0, r0, #0
     370:	00c70c1e 	sbceq	r0, r7, lr, lsl ip
     374:	07090000 	streq	r0, [r9, -r0]
     378:	00000006 	andeq	r0, r0, r6
     37c:	00079b09 	andeq	r9, r7, r9, lsl #22
     380:	31090100 	mrscc	r0, (UNDEF: 25)
     384:	0200000a 	andeq	r0, r0, #10
     388:	000b2109 	andeq	r2, fp, r9, lsl #2
     38c:	81090300 	mrshi	r0, (UNDEF: 57)
     390:	04000007 	streq	r0, [r0], #-7
     394:	0009bb09 	andeq	fp, r9, r9, lsl #22
     398:	08000500 	stmdaeq	r0, {r8, sl}
     39c:	000009f7 	strdeq	r0, [r0], -r7
     3a0:	00380405 	eorseq	r0, r8, r5, lsl #8
     3a4:	3f020000 	svccc	0x00020000
     3a8:	0001040c 	andeq	r0, r1, ip, lsl #8
     3ac:	06c80900 	strbeq	r0, [r8], r0, lsl #18
     3b0:	09000000 	stmdbeq	r0, {}	; <UNPREDICTABLE>
     3b4:	00000796 	muleq	r0, r6, r7
     3b8:	0be40901 	bleq	ff9027c4 <__bss_end+0xff8f97b8>
     3bc:	09020000 	stmdbeq	r2, {}	; <UNPREDICTABLE>
     3c0:	00000924 	andeq	r0, r0, r4, lsr #18
     3c4:	07900903 	ldreq	r0, [r0, r3, lsl #18]
     3c8:	09040000 	stmdbeq	r4, {}	; <UNPREDICTABLE>
     3cc:	000007ce 	andeq	r0, r0, lr, asr #15
     3d0:	06220905 	strteq	r0, [r2], -r5, lsl #18
     3d4:	00060000 	andeq	r0, r6, r0
     3d8:	0009020a 	andeq	r0, r9, sl, lsl #4
     3dc:	14050300 	strne	r0, [r5], #-768	; 0xfffffd00
     3e0:	00000059 	andeq	r0, r0, r9, asr r0
     3e4:	8ea40305 	cdphi	3, 10, cr0, cr4, cr5, {0}
     3e8:	8a0a0000 	bhi	2803f0 <__bss_end+0x2773e4>
     3ec:	0300000a 	movweq	r0, #10
     3f0:	00591406 	subseq	r1, r9, r6, lsl #8
     3f4:	03050000 	movweq	r0, #20480	; 0x5000
     3f8:	00008ea8 	andeq	r8, r0, r8, lsr #29
     3fc:	0007e30a 	andeq	lr, r7, sl, lsl #6
     400:	1a070400 	bne	1c1408 <__bss_end+0x1b83fc>
     404:	00000059 	andeq	r0, r0, r9, asr r0
     408:	8eac0305 	cdphi	3, 10, cr0, cr12, cr5, {0}
     40c:	ce0a0000 	cdpgt	0, 0, cr0, cr10, cr0, {0}
     410:	04000009 	streq	r0, [r0], #-9
     414:	00591a09 	subseq	r1, r9, r9, lsl #20
     418:	03050000 	movweq	r0, #20480	; 0x5000
     41c:	00008eb0 			; <UNDEFINED> instruction: 0x00008eb0
     420:	0007d50a 	andeq	sp, r7, sl, lsl #10
     424:	1a0b0400 	bne	2c142c <__bss_end+0x2b8420>
     428:	00000059 	andeq	r0, r0, r9, asr r0
     42c:	8eb40305 	cdphi	3, 11, cr0, cr4, cr5, {0}
     430:	a80a0000 	stmdage	sl, {}	; <UNPREDICTABLE>
     434:	04000009 	streq	r0, [r0], #-9
     438:	00591a0d 	subseq	r1, r9, sp, lsl #20
     43c:	03050000 	movweq	r0, #20480	; 0x5000
     440:	00008eb8 			; <UNDEFINED> instruction: 0x00008eb8
     444:	0005e70a 	andeq	lr, r5, sl, lsl #14
     448:	1a0f0400 	bne	3c1450 <__bss_end+0x3b8444>
     44c:	00000059 	andeq	r0, r0, r9, asr r0
     450:	8ebc0305 	cdphi	3, 11, cr0, cr12, cr5, {0}
     454:	a5080000 	strge	r0, [r8, #-0]
     458:	05000010 	streq	r0, [r0, #-16]
     45c:	00003804 	andeq	r3, r0, r4, lsl #16
     460:	0c1b0400 	cfldrseq	mvf0, [fp], {-0}
     464:	000001a7 	andeq	r0, r0, r7, lsr #3
     468:	00059609 	andeq	r9, r5, r9, lsl #12
     46c:	4c090000 	stcmi	0, cr0, [r9], {-0}
     470:	0100000b 	tsteq	r0, fp
     474:	000bdf09 	andeq	sp, fp, r9, lsl #30
     478:	0b000200 	bleq	c80 <shift+0xc80>
     47c:	00000459 	andeq	r0, r0, r9, asr r4
     480:	4d020102 	stfmis	f0, [r2, #-8]
     484:	0c000008 	stceq	0, cr0, [r0], {8}
     488:	00002c04 	andeq	r2, r0, r4, lsl #24
     48c:	a7040c00 	strge	r0, [r4, -r0, lsl #24]
     490:	0a000001 	beq	49c <shift+0x49c>
     494:	000005a0 	andeq	r0, r0, r0, lsr #11
     498:	59140405 	ldmdbpl	r4, {r0, r2, sl}
     49c:	05000000 	streq	r0, [r0, #-0]
     4a0:	008ec003 	addeq	ip, lr, r3
     4a4:	0a370a00 	beq	dc2cac <__bss_end+0xdb9ca0>
     4a8:	07050000 	streq	r0, [r5, -r0]
     4ac:	00005914 	andeq	r5, r0, r4, lsl r9
     4b0:	c4030500 	strgt	r0, [r3], #-1280	; 0xfffffb00
     4b4:	0a00008e 	beq	6f4 <shift+0x6f4>
     4b8:	000004ee 	andeq	r0, r0, lr, ror #9
     4bc:	59140a05 	ldmdbpl	r4, {r0, r2, r9, fp}
     4c0:	05000000 	streq	r0, [r0, #-0]
     4c4:	008ec803 	addeq	ip, lr, r3, lsl #16
     4c8:	06270800 	strteq	r0, [r7], -r0, lsl #16
     4cc:	04050000 	streq	r0, [r5], #-0
     4d0:	00000038 	andeq	r0, r0, r8, lsr r0
     4d4:	2c0c0d05 	stccs	13, cr0, [ip], {5}
     4d8:	0d000002 	stceq	0, cr0, [r0, #-8]
     4dc:	0077654e 	rsbseq	r6, r7, lr, asr #10
     4e0:	04ce0900 	strbeq	r0, [lr], #2304	; 0x900
     4e4:	09010000 	stmdbeq	r1, {}	; <UNPREDICTABLE>
     4e8:	000004e6 	andeq	r0, r0, r6, ror #9
     4ec:	06400902 	strbeq	r0, [r0], -r2, lsl #18
     4f0:	09030000 	stmdbeq	r3, {}	; <UNPREDICTABLE>
     4f4:	00000b13 	andeq	r0, r0, r3, lsl fp
     4f8:	04bb0904 	ldrteq	r0, [fp], #2308	; 0x904
     4fc:	00050000 	andeq	r0, r5, r0
     500:	0005b906 	andeq	fp, r5, r6, lsl #18
     504:	1b051000 	blne	14450c <__bss_end+0x13b500>
     508:	00026b08 	andeq	r6, r2, r8, lsl #22
     50c:	726c0700 	rsbvc	r0, ip, #0, 14
     510:	131d0500 	tstne	sp, #0, 10
     514:	0000026b 	andeq	r0, r0, fp, ror #4
     518:	70730700 	rsbsvc	r0, r3, r0, lsl #14
     51c:	131e0500 	tstne	lr, #0, 10
     520:	0000026b 	andeq	r0, r0, fp, ror #4
     524:	63700704 	cmnvs	r0, #4, 14	; 0x100000
     528:	131f0500 	tstne	pc, #0, 10
     52c:	0000026b 	andeq	r0, r0, fp, ror #4
     530:	09f10e08 	ldmibeq	r1!, {r3, r9, sl, fp}^
     534:	20050000 	andcs	r0, r5, r0
     538:	00026b13 	andeq	r6, r2, r3, lsl fp
     53c:	02000c00 	andeq	r0, r0, #0, 24
     540:	0a650704 	beq	1942158 <__bss_end+0x193914c>
     544:	6b030000 	blvs	c054c <__bss_end+0xb7540>
     548:	06000002 	streq	r0, [r0], -r2
     54c:	00000774 	andeq	r0, r0, r4, ror r7
     550:	08280570 	stmdaeq	r8!, {r4, r5, r6, r8, sl}
     554:	00000307 	andeq	r0, r0, r7, lsl #6
     558:	0006ad0e 	andeq	sl, r6, lr, lsl #26
     55c:	122a0500 	eorne	r0, sl, #0, 10
     560:	0000022c 	andeq	r0, r0, ip, lsr #4
     564:	69700700 	ldmdbvs	r0!, {r8, r9, sl}^
     568:	2b050064 	blcs	140700 <__bss_end+0x1376f4>
     56c:	00005e12 	andeq	r5, r0, r2, lsl lr
     570:	460e1000 	strmi	r1, [lr], -r0
     574:	0500000b 	streq	r0, [r0, #-11]
     578:	01f5112c 	mvnseq	r1, ip, lsr #2
     57c:	0e140000 	cdpeq	0, 1, cr0, cr4, cr0, {0}
     580:	00000ae8 	andeq	r0, r0, r8, ror #21
     584:	5e122d05 	cdppl	13, 1, cr2, cr2, cr5, {0}
     588:	18000000 	stmdane	r0, {}	; <UNPREDICTABLE>
     58c:	0003e90e 	andeq	lr, r3, lr, lsl #18
     590:	122e0500 	eorne	r0, lr, #0, 10
     594:	0000005e 	andeq	r0, r0, lr, asr r0
     598:	0a240e1c 	beq	903e10 <__bss_end+0x8fae04>
     59c:	2f050000 	svccs	0x00050000
     5a0:	0003070c 	andeq	r0, r3, ip, lsl #14
     5a4:	720e2000 	andvc	r2, lr, #0
     5a8:	05000004 	streq	r0, [r0, #-4]
     5ac:	00380930 	eorseq	r0, r8, r0, lsr r9
     5b0:	0e600000 	cdpeq	0, 6, cr0, cr0, cr0, {0}
     5b4:	0000066b 	andeq	r0, r0, fp, ror #12
     5b8:	4d0e3105 	stfmis	f3, [lr, #-20]	; 0xffffffec
     5bc:	64000000 	strvs	r0, [r0], #-0
     5c0:	0009720e 	andeq	r7, r9, lr, lsl #4
     5c4:	0e330500 	cfabs32eq	mvfx0, mvfx3
     5c8:	0000004d 	andeq	r0, r0, sp, asr #32
     5cc:	09690e68 	stmdbeq	r9!, {r3, r5, r6, r9, sl, fp}^
     5d0:	34050000 	strcc	r0, [r5], #-0
     5d4:	00004d0e 	andeq	r4, r0, lr, lsl #26
     5d8:	0f006c00 	svceq	0x00006c00
     5dc:	000001b9 			; <UNDEFINED> instruction: 0x000001b9
     5e0:	00000317 	andeq	r0, r0, r7, lsl r3
     5e4:	00005e10 	andeq	r5, r0, r0, lsl lr
     5e8:	0a000f00 	beq	41f0 <shift+0x41f0>
     5ec:	000004d7 	ldrdeq	r0, [r0], -r7
     5f0:	59140a06 	ldmdbpl	r4, {r1, r2, r9, fp}
     5f4:	05000000 	streq	r0, [r0, #-0]
     5f8:	008ecc03 	addeq	ip, lr, r3, lsl #24
     5fc:	081e0800 	ldmdaeq	lr, {fp}
     600:	04050000 	streq	r0, [r5], #-0
     604:	00000038 	andeq	r0, r0, r8, lsr r0
     608:	480c0d06 	stmdami	ip, {r1, r2, r8, sl, fp}
     60c:	09000003 	stmdbeq	r0, {r0, r1}
     610:	00000bea 	andeq	r0, r0, sl, ror #23
     614:	0b600900 	bleq	1802a1c <__bss_end+0x17f9a10>
     618:	00010000 	andeq	r0, r1, r0
     61c:	00069a06 	andeq	r9, r6, r6, lsl #20
     620:	1b060c00 	blne	183628 <__bss_end+0x17a61c>
     624:	00037d08 	andeq	r7, r3, r8, lsl #26
     628:	05630e00 	strbeq	r0, [r3, #-3584]!	; 0xfffff200
     62c:	1d060000 	stcne	0, cr0, [r6, #-0]
     630:	00037d19 	andeq	r7, r3, r9, lsl sp
     634:	c90e0000 	stmdbgt	lr, {}	; <UNPREDICTABLE>
     638:	06000004 	streq	r0, [r0], -r4
     63c:	037d191e 	cmneq	sp, #491520	; 0x78000
     640:	0e040000 	cdpeq	0, 0, cr0, cr4, cr0, {0}
     644:	00000842 	andeq	r0, r0, r2, asr #16
     648:	83131f06 	tsthi	r3, #6, 30
     64c:	08000003 	stmdaeq	r0, {r0, r1}
     650:	48040c00 	stmdami	r4, {sl, fp}
     654:	0c000003 	stceq	0, cr0, [r0], {3}
     658:	00027704 	andeq	r7, r2, r4, lsl #14
     65c:	09e01100 	stmibeq	r0!, {r8, ip}^
     660:	06140000 	ldreq	r0, [r4], -r0
     664:	060b0722 	streq	r0, [fp], -r2, lsr #14
     668:	100e0000 	andne	r0, lr, r0
     66c:	06000009 	streq	r0, [r0], -r9
     670:	004d1226 	subeq	r1, sp, r6, lsr #4
     674:	0e000000 	cdpeq	0, 0, cr0, cr0, cr0, {0}
     678:	000008b2 			; <UNDEFINED> instruction: 0x000008b2
     67c:	7d1d2906 	vldrvc.16	s4, [sp, #-12]	; <UNPREDICTABLE>
     680:	04000003 	streq	r0, [r0], #-3
     684:	0006480e 	andeq	r4, r6, lr, lsl #16
     688:	1d2c0600 	stcne	6, cr0, [ip, #-0]
     68c:	0000037d 	andeq	r0, r0, sp, ror r3
     690:	091a1208 	ldmdbeq	sl, {r3, r9, ip}
     694:	2f060000 	svccs	0x00060000
     698:	0006770e 	andeq	r7, r6, lr, lsl #14
     69c:	0003d100 	andeq	sp, r3, r0, lsl #2
     6a0:	0003dc00 	andeq	sp, r3, r0, lsl #24
     6a4:	06101300 	ldreq	r1, [r0], -r0, lsl #6
     6a8:	7d140000 	ldcvc	0, cr0, [r4, #-0]
     6ac:	00000003 	andeq	r0, r0, r3
     6b0:	0007a515 	andeq	sl, r7, r5, lsl r5
     6b4:	0e310600 	cfmsuba32eq	mvax0, mvax0, mvfx1, mvfx0
     6b8:	0000074b 	andeq	r0, r0, fp, asr #14
     6bc:	000001ac 	andeq	r0, r0, ip, lsr #3
     6c0:	000003f4 	strdeq	r0, [r0], -r4
     6c4:	000003ff 	strdeq	r0, [r0], -pc	; <UNPREDICTABLE>
     6c8:	00061013 	andeq	r1, r6, r3, lsl r0
     6cc:	03831400 	orreq	r1, r3, #0, 8
     6d0:	16000000 	strne	r0, [r0], -r0
     6d4:	00000b27 	andeq	r0, r0, r7, lsr #22
     6d8:	f91d3506 			; <UNDEFINED> instruction: 0xf91d3506
     6dc:	7d000007 	stcvc	0, cr0, [r0, #-28]	; 0xffffffe4
     6e0:	02000003 	andeq	r0, r0, #3
     6e4:	00000418 	andeq	r0, r0, r8, lsl r4
     6e8:	0000041e 	andeq	r0, r0, lr, lsl r4
     6ec:	00061013 	andeq	r1, r6, r3, lsl r0
     6f0:	33160000 	tstcc	r6, #0
     6f4:	06000006 	streq	r0, [r0], -r6
     6f8:	092a1d37 	stmdbeq	sl!, {r0, r1, r2, r4, r5, r8, sl, fp, ip}
     6fc:	037d0000 	cmneq	sp, #0
     700:	37020000 	strcc	r0, [r2, -r0]
     704:	3d000004 	stccc	0, cr0, [r0, #-16]
     708:	13000004 	movwne	r0, #4
     70c:	00000610 	andeq	r0, r0, r0, lsl r6
     710:	08c51700 	stmiaeq	r5, {r8, r9, sl, ip}^
     714:	39060000 	stmdbcc	r6, {}	; <UNPREDICTABLE>
     718:	00062931 	andeq	r2, r6, r1, lsr r9
     71c:	16020c00 	strne	r0, [r2], -r0, lsl #24
     720:	000009e0 	andeq	r0, r0, r0, ror #19
     724:	b4093c06 	strlt	r3, [r9], #-3078	; 0xfffff3fa
     728:	10000007 	andne	r0, r0, r7
     72c:	01000006 	tsteq	r0, r6
     730:	00000464 	andeq	r0, r0, r4, ror #8
     734:	0000046a 	andeq	r0, r0, sl, ror #8
     738:	00061013 	andeq	r1, r6, r3, lsl r0
     73c:	b9160000 	ldmdblt	r6, {}	; <UNPREDICTABLE>
     740:	06000006 	streq	r0, [r0], -r6
     744:	051f123f 	ldreq	r1, [pc, #-575]	; 50d <shift+0x50d>
     748:	004d0000 	subeq	r0, sp, r0
     74c:	83010000 	movwhi	r0, #4096	; 0x1000
     750:	98000004 	stmdals	r0, {r2}
     754:	13000004 	movwne	r0, #4
     758:	00000610 	andeq	r0, r0, r0, lsl r6
     75c:	00063214 	andeq	r3, r6, r4, lsl r2
     760:	005e1400 	subseq	r1, lr, r0, lsl #8
     764:	ac140000 	ldcge	0, cr0, [r4], {-0}
     768:	00000001 	andeq	r0, r0, r1
     76c:	000b5718 	andeq	r5, fp, r8, lsl r7
     770:	0e420600 	cdpeq	6, 4, cr0, cr2, cr0, {0}
     774:	000005c6 	andeq	r0, r0, r6, asr #11
     778:	0004ad01 	andeq	sl, r4, r1, lsl #26
     77c:	0004b300 	andeq	fp, r4, r0, lsl #6
     780:	06101300 	ldreq	r1, [r0], -r0, lsl #6
     784:	16000000 	strne	r0, [r0], -r0
     788:	00000501 	andeq	r0, r0, r1, lsl #10
     78c:	68174506 	ldmdavs	r7, {r1, r2, r8, sl, lr}
     790:	83000005 	movwhi	r0, #5
     794:	01000003 	tsteq	r0, r3
     798:	000004cc 	andeq	r0, r0, ip, asr #9
     79c:	000004d2 	ldrdeq	r0, [r0], -r2
     7a0:	00063813 	andeq	r3, r6, r3, lsl r8
     7a4:	42160000 	andsmi	r0, r6, #0
     7a8:	0600000a 	streq	r0, [r0], -sl
     7ac:	03ff1748 	mvnseq	r1, #72, 14	; 0x1200000
     7b0:	03830000 	orreq	r0, r3, #0
     7b4:	eb010000 	bl	407bc <__bss_end+0x377b0>
     7b8:	f6000004 			; <UNDEFINED> instruction: 0xf6000004
     7bc:	13000004 	movwne	r0, #4
     7c0:	00000638 	andeq	r0, r0, r8, lsr r6
     7c4:	00004d14 	andeq	r4, r0, r4, lsl sp
     7c8:	f1180000 			; <UNDEFINED> instruction: 0xf1180000
     7cc:	06000005 	streq	r0, [r0], -r5
     7d0:	08d30e4b 	ldmeq	r3, {r0, r1, r3, r6, r9, sl, fp}^
     7d4:	0b010000 	bleq	407dc <__bss_end+0x377d0>
     7d8:	11000005 	tstne	r0, r5
     7dc:	13000005 	movwne	r0, #5
     7e0:	00000610 	andeq	r0, r0, r0, lsl r6
     7e4:	07a51600 	streq	r1, [r5, r0, lsl #12]!
     7e8:	4d060000 	stcmi	0, cr0, [r6, #-0]
     7ec:	0009800e 	andeq	r8, r9, lr
     7f0:	0001ac00 	andeq	sl, r1, r0, lsl #24
     7f4:	052a0100 	streq	r0, [sl, #-256]!	; 0xffffff00
     7f8:	05350000 	ldreq	r0, [r5, #-0]!
     7fc:	10130000 	andsne	r0, r3, r0
     800:	14000006 	strne	r0, [r0], #-6
     804:	0000004d 	andeq	r0, r0, sp, asr #32
     808:	04a71600 	strteq	r1, [r7], #1536	; 0x600
     80c:	50060000 	andpl	r0, r6, r0
     810:	00042c12 	andeq	r2, r4, r2, lsl ip
     814:	00004d00 	andeq	r4, r0, r0, lsl #26
     818:	054e0100 	strbeq	r0, [lr, #-256]	; 0xffffff00
     81c:	05590000 	ldrbeq	r0, [r9, #-0]
     820:	10130000 	andsne	r0, r3, r0
     824:	14000006 	strne	r0, [r0], #-6
     828:	000001b9 			; <UNDEFINED> instruction: 0x000001b9
     82c:	045f1600 	ldrbeq	r1, [pc], #-1536	; 834 <shift+0x834>
     830:	53060000 	movwpl	r0, #24576	; 0x6000
     834:	000b6b0e 	andeq	r6, fp, lr, lsl #22
     838:	0001ac00 	andeq	sl, r1, r0, lsl #24
     83c:	05720100 	ldrbeq	r0, [r2, #-256]!	; 0xffffff00
     840:	057d0000 	ldrbeq	r0, [sp, #-0]!
     844:	10130000 	andsne	r0, r3, r0
     848:	14000006 	strne	r0, [r0], #-6
     84c:	0000004d 	andeq	r0, r0, sp, asr #32
     850:	04811800 	streq	r1, [r1], #2048	; 0x800
     854:	56060000 	strpl	r0, [r6], -r0
     858:	000a960e 	andeq	r9, sl, lr, lsl #12
     85c:	05920100 	ldreq	r0, [r2, #256]	; 0x100
     860:	05b10000 	ldreq	r0, [r1, #0]!
     864:	10130000 	andsne	r0, r3, r0
     868:	14000006 	strne	r0, [r0], #-6
     86c:	00000090 	muleq	r0, r0, r0
     870:	00004d14 	andeq	r4, r0, r4, lsl sp
     874:	004d1400 	subeq	r1, sp, r0, lsl #8
     878:	4d140000 	ldcmi	0, cr0, [r4, #-0]
     87c:	14000000 	strne	r0, [r0], #-0
     880:	0000063e 	andeq	r0, r0, lr, lsr r6
     884:	0b971800 	bleq	fe5c688c <__bss_end+0xfe5bd880>
     888:	58060000 	stmdapl	r6, {}	; <UNPREDICTABLE>
     88c:	000c110e 	andeq	r1, ip, lr, lsl #2
     890:	05c60100 	strbeq	r0, [r6, #256]	; 0x100
     894:	05e50000 	strbeq	r0, [r5, #0]!
     898:	10130000 	andsne	r0, r3, r0
     89c:	14000006 	strne	r0, [r0], #-6
     8a0:	000000c7 	andeq	r0, r0, r7, asr #1
     8a4:	00004d14 	andeq	r4, r0, r4, lsl sp
     8a8:	004d1400 	subeq	r1, sp, r0, lsl #8
     8ac:	4d140000 	ldcmi	0, cr0, [r4, #-0]
     8b0:	14000000 	strne	r0, [r0], #-0
     8b4:	0000063e 	andeq	r0, r0, lr, lsr r6
     8b8:	04941900 	ldreq	r1, [r4], #2304	; 0x900
     8bc:	5b060000 	blpl	1808c4 <__bss_end+0x1778b8>
     8c0:	0008520e 	andeq	r5, r8, lr, lsl #4
     8c4:	0001ac00 	andeq	sl, r1, r0, lsl #24
     8c8:	05fa0100 	ldrbeq	r0, [sl, #256]!	; 0x100
     8cc:	10130000 	andsne	r0, r3, r0
     8d0:	14000006 	strne	r0, [r0], #-6
     8d4:	00000329 	andeq	r0, r0, r9, lsr #6
     8d8:	00064414 	andeq	r4, r6, r4, lsl r4
     8dc:	03000000 	movweq	r0, #0
     8e0:	00000389 	andeq	r0, r0, r9, lsl #7
     8e4:	0389040c 	orreq	r0, r9, #12, 8	; 0xc000000
     8e8:	7d1a0000 	ldcvc	0, cr0, [sl, #-0]
     8ec:	23000003 	movwcs	r0, #3
     8f0:	29000006 	stmdbcs	r0, {r1, r2}
     8f4:	13000006 	movwne	r0, #6
     8f8:	00000610 	andeq	r0, r0, r0, lsl r6
     8fc:	03891b00 	orreq	r1, r9, #0, 22
     900:	06160000 	ldreq	r0, [r6], -r0
     904:	040c0000 	streq	r0, [ip], #-0
     908:	0000003f 	andeq	r0, r0, pc, lsr r0
     90c:	060b040c 	streq	r0, [fp], -ip, lsl #8
     910:	041c0000 	ldreq	r0, [ip], #-0
     914:	0000006a 	andeq	r0, r0, sl, rrx
     918:	681e041d 	ldmdavs	lr, {r0, r2, r3, r4, sl}
     91c:	07006c61 	streq	r6, [r0, -r1, ror #24]
     920:	07100b05 	ldreq	r0, [r0, -r5, lsl #22]
     924:	9f1f0000 	svcls	0x001f0000
     928:	07000008 	streq	r0, [r0, -r8]
     92c:	00651907 	rsbeq	r1, r5, r7, lsl #18
     930:	b2800000 	addlt	r0, r0, #0
     934:	551f0ee6 	ldrpl	r0, [pc, #-3814]	; fffffa56 <__bss_end+0xffff6a4a>
     938:	0700000a 	streq	r0, [r0, -sl]
     93c:	02721a0a 	rsbseq	r1, r2, #40960	; 0xa000
     940:	00000000 	andeq	r0, r0, r0
     944:	151f2000 	ldrne	r2, [pc, #-0]	; 94c <shift+0x94c>
     948:	07000005 	streq	r0, [r0, -r5]
     94c:	02721a0d 	rsbseq	r1, r2, #53248	; 0xd000
     950:	00000000 	andeq	r0, r0, r0
     954:	33202020 			; <UNDEFINED> instruction: 0x33202020
     958:	07000008 	streq	r0, [r0, -r8]
     95c:	00591510 	subseq	r1, r9, r0, lsl r5
     960:	1f360000 	svcne	0x00360000
     964:	00000b33 	andeq	r0, r0, r3, lsr fp
     968:	721a4207 	andsvc	r4, sl, #1879048192	; 0x70000000
     96c:	00000002 	andeq	r0, r0, r2
     970:	1f202150 	svcne	0x00202150
     974:	00000bc5 	andeq	r0, r0, r5, asr #23
     978:	721a7107 	andsvc	r7, sl, #-1073741823	; 0xc0000001
     97c:	00000002 	andeq	r0, r0, r2
     980:	1f2000b2 	svcne	0x002000b2
     984:	000006d2 	ldrdeq	r0, [r0], -r2
     988:	721aa407 	andsvc	sl, sl, #117440512	; 0x7000000
     98c:	00000002 	andeq	r0, r0, r2
     990:	1f2000b4 	svcne	0x002000b4
     994:	00000895 	muleq	r0, r5, r8
     998:	721ab307 	andsvc	fp, sl, #469762048	; 0x1c000000
     99c:	00000002 	andeq	r0, r0, r2
     9a0:	1f201040 	svcne	0x00201040
     9a4:	00000950 	andeq	r0, r0, r0, asr r9
     9a8:	721abe07 	andsvc	fp, sl, #7, 28	; 0x70
     9ac:	00000002 	andeq	r0, r0, r2
     9b0:	1f202050 	svcne	0x00202050
     9b4:	00000618 	andeq	r0, r0, r8, lsl r6
     9b8:	721abf07 	andsvc	fp, sl, #7, 30
     9bc:	00000002 	andeq	r0, r0, r2
     9c0:	1f208040 	svcne	0x00208040
     9c4:	00000b3c 	andeq	r0, r0, ip, lsr fp
     9c8:	721ac007 	andsvc	ip, sl, #7
     9cc:	00000002 	andeq	r0, r0, r2
     9d0:	1f208050 	svcne	0x00208050
     9d4:	00000b04 	andeq	r0, r0, r4, lsl #22
     9d8:	721ace07 	andsvc	ip, sl, #7, 28	; 0x70
     9dc:	00000002 	andeq	r0, r0, r2
     9e0:	00202140 	eoreq	r2, r0, r0, asr #2
     9e4:	00065221 	andeq	r5, r6, r1, lsr #4
     9e8:	06622100 	strbteq	r2, [r2], -r0, lsl #2
     9ec:	72210000 	eorvc	r0, r1, #0
     9f0:	21000006 	tstcs	r0, r6
     9f4:	00000682 	andeq	r0, r0, r2, lsl #13
     9f8:	00068f21 	andeq	r8, r6, r1, lsr #30
     9fc:	069f2100 	ldreq	r2, [pc], r0, lsl #2
     a00:	af210000 	svcge	0x00210000
     a04:	21000006 	tstcs	r0, r6
     a08:	000006bf 			; <UNDEFINED> instruction: 0x000006bf
     a0c:	0006cf21 	andeq	ip, r6, r1, lsr #30
     a10:	06df2100 	ldrbeq	r2, [pc], r0, lsl #2
     a14:	ef210000 	svc	0x00210000
     a18:	21000006 	tstcs	r0, r6
     a1c:	000006ff 	strdeq	r0, [r0], -pc	; <UNPREDICTABLE>
     a20:	000a770a 	andeq	r7, sl, sl, lsl #14
     a24:	14080800 	strne	r0, [r8], #-2048	; 0xfffff800
     a28:	00000059 	andeq	r0, r0, r9, asr r0
     a2c:	8f000305 	svchi	0x00000305
     a30:	4a0a0000 	bmi	280a38 <__bss_end+0x277a2c>
     a34:	09000005 	stmdbeq	r0, {r0, r2}
     a38:	00591408 	subseq	r1, r9, r8, lsl #8
     a3c:	03050000 	movweq	r0, #20480	; 0x5000
     a40:	00008f04 	andeq	r8, r0, r4, lsl #30
     a44:	0025040c 	eoreq	r0, r5, ip, lsl #8
     a48:	ff0a0000 			; <UNDEFINED> instruction: 0xff0a0000
     a4c:	0100000b 	tsteq	r0, fp
     a50:	0059140e 	subseq	r1, r9, lr, lsl #8
     a54:	03050000 	movweq	r0, #20480	; 0x5000
     a58:	00008f08 	andeq	r8, r0, r8, lsl #30
     a5c:	00065b0a 	andeq	r5, r6, sl, lsl #22
     a60:	140f0100 	strne	r0, [pc], #-256	; a68 <shift+0xa68>
     a64:	00000059 	andeq	r0, r0, r9, asr r0
     a68:	8f0c0305 	svchi	0x000c0305
     a6c:	6c220000 	stcvs	0, cr0, [r2], #-0
     a70:	01006465 	tsteq	r0, r5, ror #8
     a74:	004d0a11 	subeq	r0, sp, r1, lsl sl
     a78:	03050000 	movweq	r0, #20480	; 0x5000
     a7c:	00008fec 	andeq	r8, r0, ip, ror #31
     a80:	00047c23 	andeq	r7, r4, r3, lsr #24
     a84:	0f110100 	svceq	0x00110100
     a88:	0000004d 	andeq	r0, r0, sp, asr #32
     a8c:	8ff00305 	svchi	0x00f00305
     a90:	83230000 			; <UNDEFINED> instruction: 0x83230000
     a94:	0100000a 	tsteq	r0, sl
     a98:	004d1511 	subeq	r1, sp, r1, lsl r5
     a9c:	03050000 	movweq	r0, #20480	; 0x5000
     aa0:	00008ff4 	strdeq	r8, [r0], -r4
     aa4:	0004c223 	andeq	ip, r4, r3, lsr #4
     aa8:	1d110100 	ldfnes	f0, [r1, #-0]
     aac:	0000004d 	andeq	r0, r0, sp, asr #32
     ab0:	8ff80305 	svchi	0x00f80305
     ab4:	c0240000 	eorgt	r0, r4, r0
     ab8:	0100000b 	tsteq	r0, fp
     abc:	0038051f 	eorseq	r0, r8, pc, lsl r5
     ac0:	82c80000 	sbchi	r0, r8, #0
     ac4:	00b80000 	adcseq	r0, r8, r0
     ac8:	9c010000 	stcls	0, cr0, [r1], {-0}
     acc:	0000082a 	andeq	r0, r0, sl, lsr #16
     ad0:	00096425 	andeq	r6, r9, r5, lsr #8
     ad4:	0e1f0100 	mufeqe	f0, f7, f0
     ad8:	00000038 	andeq	r0, r0, r8, lsr r0
     adc:	256c9102 	strbcs	r9, [ip, #-258]!	; 0xfffffefe
     ae0:	0000097b 	andeq	r0, r0, fp, ror r9
     ae4:	2a1b1f01 	bcs	6c86f0 <__bss_end+0x6bf6e4>
     ae8:	02000008 	andeq	r0, r0, #8
     aec:	cd266891 	stcgt	8, cr6, [r6, #-580]!	; 0xfffffdbc
     af0:	01000006 	tsteq	r0, r6
     af4:	08300a21 	ldmdaeq	r0!, {r0, r5, r9, fp}
     af8:	91020000 	mrsls	r0, (UNDEF: 2)
     afc:	040c0074 	streq	r0, [ip], #-116	; 0xffffff8c
     b00:	00000770 	andeq	r0, r0, r0, ror r7
     b04:	0000250f 	andeq	r2, r0, pc, lsl #10
     b08:	00084000 	andeq	r4, r8, r0
     b0c:	005e1000 	subseq	r1, lr, r0
     b10:	00030000 	andeq	r0, r3, r0
     b14:	00084727 	andeq	r4, r8, r7, lsr #14
     b18:	06180100 	ldreq	r0, [r8], -r0, lsl #2
     b1c:	0000095a 	andeq	r0, r0, sl, asr r9
     b20:	00008270 	andeq	r8, r0, r0, ror r2
     b24:	00000058 	andeq	r0, r0, r8, asr r0
     b28:	6c289c01 	stcvs	12, cr9, [r8], #-4
     b2c:	0100676f 	tsteq	r0, pc, ror #14
     b30:	06dd0613 			; <UNDEFINED> instruction: 0x06dd0613
     b34:	822c0000 	eorhi	r0, ip, #0
     b38:	00440000 	subeq	r0, r4, r0
     b3c:	9c010000 	stcls	0, cr0, [r1], {-0}
     b40:	67736d29 	ldrbvs	r6, [r3, -r9, lsr #26]!
     b44:	16130100 	ldrne	r0, [r3], -r0, lsl #2
     b48:	000001b3 			; <UNDEFINED> instruction: 0x000001b3
     b4c:	006c9102 	rsbeq	r9, ip, r2, lsl #2
     b50:	000b1f00 	andeq	r1, fp, r0, lsl #30
     b54:	71000400 	tstvc	r0, r0, lsl #8
     b58:	04000004 	streq	r0, [r0], #-4
     b5c:	000fa101 	andeq	sl, pc, r1, lsl #2
     b60:	0e7a0400 	cdpeq	4, 7, cr0, cr10, cr0, {0}
     b64:	0c690000 	stcleq	0, cr0, [r9], #-0
     b68:	83800000 	orrhi	r0, r0, #0
     b6c:	045c0000 	ldrbeq	r0, [ip], #-0
     b70:	054c0000 	strbeq	r0, [ip, #-0]
     b74:	01020000 	mrseq	r0, (UNDEF: 2)
     b78:	000aff08 	andeq	pc, sl, r8, lsl #30
     b7c:	00250300 	eoreq	r0, r5, r0, lsl #6
     b80:	02020000 	andeq	r0, r2, #0
     b84:	0009c405 	andeq	ip, r9, r5, lsl #8
     b88:	05040400 	streq	r0, [r4, #-1024]	; 0xfffffc00
     b8c:	00746e69 	rsbseq	r6, r4, r9, ror #28
     b90:	f6080102 			; <UNDEFINED> instruction: 0xf6080102
     b94:	0200000a 	andeq	r0, r0, #10
     b98:	0bad0702 	bleq	feb427a8 <__bss_end+0xfeb3979c>
     b9c:	0f050000 	svceq	0x00050000
     ba0:	07000006 	streq	r0, [r0, -r6]
     ba4:	005e0709 	subseq	r0, lr, r9, lsl #14
     ba8:	4d030000 	stcmi	0, cr0, [r3, #-0]
     bac:	02000000 	andeq	r0, r0, #0
     bb0:	0a6a0704 	beq	1a827c8 <__bss_end+0x1a797bc>
     bb4:	5d060000 	stcpl	0, cr0, [r6, #-0]
     bb8:	0800000c 	stmdaeq	r0, {r2, r3}
     bbc:	8b080602 	blhi	2023cc <__bss_end+0x1f93c0>
     bc0:	07000000 	streq	r0, [r0, -r0]
     bc4:	02003072 	andeq	r3, r0, #114	; 0x72
     bc8:	004d0e08 	subeq	r0, sp, r8, lsl #28
     bcc:	07000000 	streq	r0, [r0, -r0]
     bd0:	02003172 	andeq	r3, r0, #-2147483620	; 0x8000001c
     bd4:	004d0e09 	subeq	r0, sp, r9, lsl #28
     bd8:	00040000 	andeq	r0, r4, r0
     bdc:	000f2b08 	andeq	r2, pc, r8, lsl #22
     be0:	38040500 	stmdacc	r4, {r8, sl}
     be4:	02000000 	andeq	r0, r0, #0
     be8:	00a90c0d 	adceq	r0, r9, sp, lsl #24
     bec:	4f090000 	svcmi	0x00090000
     bf0:	0a00004b 	beq	d24 <shift+0xd24>
     bf4:	00000d17 	andeq	r0, r0, r7, lsl sp
     bf8:	0f080001 	svceq	0x00080001
     bfc:	0500000a 	streq	r0, [r0, #-10]
     c00:	00003804 	andeq	r3, r0, r4, lsl #16
     c04:	0c1e0200 	lfmeq	f0, 4, [lr], {-0}
     c08:	000000e0 	andeq	r0, r0, r0, ror #1
     c0c:	0006070a 	andeq	r0, r6, sl, lsl #14
     c10:	9b0a0000 	blls	280c18 <__bss_end+0x277c0c>
     c14:	01000007 	tsteq	r0, r7
     c18:	000a310a 	andeq	r3, sl, sl, lsl #2
     c1c:	210a0200 	mrscs	r0, R10_fiq
     c20:	0300000b 	movweq	r0, #11
     c24:	0007810a 	andeq	r8, r7, sl, lsl #2
     c28:	bb0a0400 	bllt	281c30 <__bss_end+0x278c24>
     c2c:	05000009 	streq	r0, [r0, #-9]
     c30:	09f70800 	ldmibeq	r7!, {fp}^
     c34:	04050000 	streq	r0, [r5], #-0
     c38:	00000038 	andeq	r0, r0, r8, lsr r0
     c3c:	1d0c3f02 	stcne	15, cr3, [ip, #-8]
     c40:	0a000001 	beq	c4c <shift+0xc4c>
     c44:	000006c8 	andeq	r0, r0, r8, asr #13
     c48:	07960a00 	ldreq	r0, [r6, r0, lsl #20]
     c4c:	0a010000 	beq	40c54 <__bss_end+0x37c48>
     c50:	00000be4 	andeq	r0, r0, r4, ror #23
     c54:	09240a02 	stmdbeq	r4!, {r1, r9, fp}
     c58:	0a030000 	beq	c0c60 <__bss_end+0xb7c54>
     c5c:	00000790 	muleq	r0, r0, r7
     c60:	07ce0a04 	strbeq	r0, [lr, r4, lsl #20]
     c64:	0a050000 	beq	140c6c <__bss_end+0x137c60>
     c68:	00000622 	andeq	r0, r0, r2, lsr #12
     c6c:	52080006 	andpl	r0, r8, #6
     c70:	05000010 	streq	r0, [r0, #-16]
     c74:	00003804 	andeq	r3, r0, r4, lsl #16
     c78:	0c660200 	sfmeq	f0, 2, [r6], #-0
     c7c:	00000148 	andeq	r0, r0, r8, asr #2
     c80:	000e6f0a 	andeq	r6, lr, sl, lsl #30
     c84:	740a0000 	strvc	r0, [sl], #-0
     c88:	0100000d 	tsteq	r0, sp
     c8c:	000ef40a 	andeq	pc, lr, sl, lsl #8
     c90:	990a0200 	stmdbls	sl, {r9}
     c94:	0300000d 	movweq	r0, #13
     c98:	09020b00 	stmdbeq	r2, {r8, r9, fp}
     c9c:	05030000 	streq	r0, [r3, #-0]
     ca0:	00005914 	andeq	r5, r0, r4, lsl r9
     ca4:	a0030500 	andge	r0, r3, r0, lsl #10
     ca8:	0b00008f 	bleq	eec <shift+0xeec>
     cac:	00000a8a 	andeq	r0, r0, sl, lsl #21
     cb0:	59140603 	ldmdbpl	r4, {r0, r1, r9, sl}
     cb4:	05000000 	streq	r0, [r0, #-0]
     cb8:	008fa403 	addeq	sl, pc, r3, lsl #8
     cbc:	07e30b00 	strbeq	r0, [r3, r0, lsl #22]!
     cc0:	07040000 	streq	r0, [r4, -r0]
     cc4:	0000591a 	andeq	r5, r0, sl, lsl r9
     cc8:	a8030500 	stmdage	r3, {r8, sl}
     ccc:	0b00008f 	bleq	f10 <shift+0xf10>
     cd0:	000009ce 	andeq	r0, r0, lr, asr #19
     cd4:	591a0904 	ldmdbpl	sl, {r2, r8, fp}
     cd8:	05000000 	streq	r0, [r0, #-0]
     cdc:	008fac03 	addeq	sl, pc, r3, lsl #24
     ce0:	07d50b00 	ldrbeq	r0, [r5, r0, lsl #22]
     ce4:	0b040000 	bleq	100cec <__bss_end+0xf7ce0>
     ce8:	0000591a 	andeq	r5, r0, sl, lsl r9
     cec:	b0030500 	andlt	r0, r3, r0, lsl #10
     cf0:	0b00008f 	bleq	f34 <shift+0xf34>
     cf4:	000009a8 	andeq	r0, r0, r8, lsr #19
     cf8:	591a0d04 	ldmdbpl	sl, {r2, r8, sl, fp}
     cfc:	05000000 	streq	r0, [r0, #-0]
     d00:	008fb403 	addeq	fp, pc, r3, lsl #8
     d04:	05e70b00 	strbeq	r0, [r7, #2816]!	; 0xb00
     d08:	0f040000 	svceq	0x00040000
     d0c:	0000591a 	andeq	r5, r0, sl, lsl r9
     d10:	b8030500 	stmdalt	r3, {r8, sl}
     d14:	0800008f 	stmdaeq	r0, {r0, r1, r2, r3, r7}
     d18:	000010a5 	andeq	r1, r0, r5, lsr #1
     d1c:	00380405 	eorseq	r0, r8, r5, lsl #8
     d20:	1b040000 	blne	100d28 <__bss_end+0xf7d1c>
     d24:	0001eb0c 	andeq	lr, r1, ip, lsl #22
     d28:	05960a00 	ldreq	r0, [r6, #2560]	; 0xa00
     d2c:	0a000000 	beq	d34 <shift+0xd34>
     d30:	00000b4c 	andeq	r0, r0, ip, asr #22
     d34:	0bdf0a01 	bleq	ff7c3540 <__bss_end+0xff7ba534>
     d38:	00020000 	andeq	r0, r2, r0
     d3c:	0004590c 	andeq	r5, r4, ip, lsl #18
     d40:	02010200 	andeq	r0, r1, #0, 4
     d44:	0000084d 	andeq	r0, r0, sp, asr #16
     d48:	002c040d 	eoreq	r0, ip, sp, lsl #8
     d4c:	040d0000 	streq	r0, [sp], #-0
     d50:	000001eb 	andeq	r0, r0, fp, ror #3
     d54:	0005a00b 	andeq	sl, r5, fp
     d58:	14040500 	strne	r0, [r4], #-1280	; 0xfffffb00
     d5c:	00000059 	andeq	r0, r0, r9, asr r0
     d60:	8fbc0305 	svchi	0x00bc0305
     d64:	370b0000 	strcc	r0, [fp, -r0]
     d68:	0500000a 	streq	r0, [r0, #-10]
     d6c:	00591407 	subseq	r1, r9, r7, lsl #8
     d70:	03050000 	movweq	r0, #20480	; 0x5000
     d74:	00008fc0 	andeq	r8, r0, r0, asr #31
     d78:	0004ee0b 	andeq	lr, r4, fp, lsl #28
     d7c:	140a0500 	strne	r0, [sl], #-1280	; 0xfffffb00
     d80:	00000059 	andeq	r0, r0, r9, asr r0
     d84:	8fc40305 	svchi	0x00c40305
     d88:	27080000 	strcs	r0, [r8, -r0]
     d8c:	05000006 	streq	r0, [r0, #-6]
     d90:	00003804 	andeq	r3, r0, r4, lsl #16
     d94:	0c0d0500 	cfstr32eq	mvfx0, [sp], {-0}
     d98:	00000270 	andeq	r0, r0, r0, ror r2
     d9c:	77654e09 	strbvc	r4, [r5, -r9, lsl #28]!
     da0:	ce0a0000 	cdpgt	0, 0, cr0, cr10, cr0, {0}
     da4:	01000004 	tsteq	r0, r4
     da8:	0004e60a 	andeq	lr, r4, sl, lsl #12
     dac:	400a0200 	andmi	r0, sl, r0, lsl #4
     db0:	03000006 	movweq	r0, #6
     db4:	000b130a 	andeq	r1, fp, sl, lsl #6
     db8:	bb0a0400 	bllt	281dc0 <__bss_end+0x278db4>
     dbc:	05000004 	streq	r0, [r0, #-4]
     dc0:	05b90600 	ldreq	r0, [r9, #1536]!	; 0x600
     dc4:	05100000 	ldreq	r0, [r0, #-0]
     dc8:	02af081b 	adceq	r0, pc, #1769472	; 0x1b0000
     dcc:	6c070000 	stcvs	0, cr0, [r7], {-0}
     dd0:	1d050072 	stcne	0, cr0, [r5, #-456]	; 0xfffffe38
     dd4:	0002af13 	andeq	sl, r2, r3, lsl pc
     dd8:	73070000 	movwvc	r0, #28672	; 0x7000
     ddc:	1e050070 	mcrne	0, 0, r0, cr5, cr0, {3}
     de0:	0002af13 	andeq	sl, r2, r3, lsl pc
     de4:	70070400 	andvc	r0, r7, r0, lsl #8
     de8:	1f050063 	svcne	0x00050063
     dec:	0002af13 	andeq	sl, r2, r3, lsl pc
     df0:	f10e0800 			; <UNDEFINED> instruction: 0xf10e0800
     df4:	05000009 	streq	r0, [r0, #-9]
     df8:	02af1320 	adceq	r1, pc, #32, 6	; 0x80000000
     dfc:	000c0000 	andeq	r0, ip, r0
     e00:	65070402 	strvs	r0, [r7, #-1026]	; 0xfffffbfe
     e04:	0600000a 	streq	r0, [r0], -sl
     e08:	00000774 	andeq	r0, r0, r4, ror r7
     e0c:	08280570 	stmdaeq	r8!, {r4, r5, r6, r8, sl}
     e10:	00000346 	andeq	r0, r0, r6, asr #6
     e14:	0006ad0e 	andeq	sl, r6, lr, lsl #26
     e18:	122a0500 	eorne	r0, sl, #0, 10
     e1c:	00000270 	andeq	r0, r0, r0, ror r2
     e20:	69700700 	ldmdbvs	r0!, {r8, r9, sl}^
     e24:	2b050064 	blcs	140fbc <__bss_end+0x137fb0>
     e28:	00005e12 	andeq	r5, r0, r2, lsl lr
     e2c:	460e1000 	strmi	r1, [lr], -r0
     e30:	0500000b 	streq	r0, [r0, #-11]
     e34:	0239112c 	eorseq	r1, r9, #44, 2
     e38:	0e140000 	cdpeq	0, 1, cr0, cr4, cr0, {0}
     e3c:	00000ae8 	andeq	r0, r0, r8, ror #21
     e40:	5e122d05 	cdppl	13, 1, cr2, cr2, cr5, {0}
     e44:	18000000 	stmdane	r0, {}	; <UNPREDICTABLE>
     e48:	0003e90e 	andeq	lr, r3, lr, lsl #18
     e4c:	122e0500 	eorne	r0, lr, #0, 10
     e50:	0000005e 	andeq	r0, r0, lr, asr r0
     e54:	0a240e1c 	beq	9046cc <__bss_end+0x8fb6c0>
     e58:	2f050000 	svccs	0x00050000
     e5c:	0003460c 	andeq	r4, r3, ip, lsl #12
     e60:	720e2000 	andvc	r2, lr, #0
     e64:	05000004 	streq	r0, [r0, #-4]
     e68:	00380930 	eorseq	r0, r8, r0, lsr r9
     e6c:	0e600000 	cdpeq	0, 6, cr0, cr0, cr0, {0}
     e70:	0000066b 	andeq	r0, r0, fp, ror #12
     e74:	4d0e3105 	stfmis	f3, [lr, #-20]	; 0xffffffec
     e78:	64000000 	strvs	r0, [r0], #-0
     e7c:	0009720e 	andeq	r7, r9, lr, lsl #4
     e80:	0e330500 	cfabs32eq	mvfx0, mvfx3
     e84:	0000004d 	andeq	r0, r0, sp, asr #32
     e88:	09690e68 	stmdbeq	r9!, {r3, r5, r6, r9, sl, fp}^
     e8c:	34050000 	strcc	r0, [r5], #-0
     e90:	00004d0e 	andeq	r4, r0, lr, lsl #26
     e94:	0f006c00 	svceq	0x00006c00
     e98:	000001fd 	strdeq	r0, [r0], -sp
     e9c:	00000356 	andeq	r0, r0, r6, asr r3
     ea0:	00005e10 	andeq	r5, r0, r0, lsl lr
     ea4:	0b000f00 	bleq	4aac <shift+0x4aac>
     ea8:	000004d7 	ldrdeq	r0, [r0], -r7
     eac:	59140a06 	ldmdbpl	r4, {r1, r2, r9, fp}
     eb0:	05000000 	streq	r0, [r0, #-0]
     eb4:	008fc803 	addeq	ip, pc, r3, lsl #16
     eb8:	081e0800 	ldmdaeq	lr, {fp}
     ebc:	04050000 	streq	r0, [r5], #-0
     ec0:	00000038 	andeq	r0, r0, r8, lsr r0
     ec4:	870c0d06 	strhi	r0, [ip, -r6, lsl #26]
     ec8:	0a000003 	beq	edc <shift+0xedc>
     ecc:	00000bea 	andeq	r0, r0, sl, ror #23
     ed0:	0b600a00 	bleq	18036d8 <__bss_end+0x17fa6cc>
     ed4:	00010000 	andeq	r0, r1, r0
     ed8:	00036803 	andeq	r6, r3, r3, lsl #16
     edc:	0e010800 	cdpeq	8, 0, cr0, cr1, cr0, {0}
     ee0:	04050000 	streq	r0, [r5], #-0
     ee4:	00000038 	andeq	r0, r0, r8, lsr r0
     ee8:	ab0c1406 	blge	305f08 <__bss_end+0x2fcefc>
     eec:	0a000003 	beq	f00 <shift+0xf00>
     ef0:	00000cba 			; <UNDEFINED> instruction: 0x00000cba
     ef4:	0ee60a00 	vfmaeq.f32	s1, s12, s0
     ef8:	00010000 	andeq	r0, r1, r0
     efc:	00038c03 	andeq	r8, r3, r3, lsl #24
     f00:	069a0600 	ldreq	r0, [sl], r0, lsl #12
     f04:	060c0000 	streq	r0, [ip], -r0
     f08:	03e5081b 	mvneq	r0, #1769472	; 0x1b0000
     f0c:	630e0000 	movwvs	r0, #57344	; 0xe000
     f10:	06000005 	streq	r0, [r0], -r5
     f14:	03e5191d 	mvneq	r1, #475136	; 0x74000
     f18:	0e000000 	cdpeq	0, 0, cr0, cr0, cr0, {0}
     f1c:	000004c9 	andeq	r0, r0, r9, asr #9
     f20:	e5191e06 	ldr	r1, [r9, #-3590]	; 0xfffff1fa
     f24:	04000003 	streq	r0, [r0], #-3
     f28:	0008420e 	andeq	r4, r8, lr, lsl #4
     f2c:	131f0600 	tstne	pc, #0, 12
     f30:	000003eb 	andeq	r0, r0, fp, ror #7
     f34:	040d0008 	streq	r0, [sp], #-8
     f38:	000003b0 			; <UNDEFINED> instruction: 0x000003b0
     f3c:	02b6040d 	adcseq	r0, r6, #218103808	; 0xd000000
     f40:	e0110000 	ands	r0, r1, r0
     f44:	14000009 	strne	r0, [r0], #-9
     f48:	73072206 	movwvc	r2, #29190	; 0x7206
     f4c:	0e000006 	cdpeq	0, 0, cr0, cr0, cr6, {0}
     f50:	00000910 	andeq	r0, r0, r0, lsl r9
     f54:	4d122606 	ldcmi	6, cr2, [r2, #-24]	; 0xffffffe8
     f58:	00000000 	andeq	r0, r0, r0
     f5c:	0008b20e 	andeq	fp, r8, lr, lsl #4
     f60:	1d290600 	stcne	6, cr0, [r9, #-0]
     f64:	000003e5 	andeq	r0, r0, r5, ror #7
     f68:	06480e04 	strbeq	r0, [r8], -r4, lsl #28
     f6c:	2c060000 	stccs	0, cr0, [r6], {-0}
     f70:	0003e51d 	andeq	lr, r3, sp, lsl r5
     f74:	1a120800 	bne	482f7c <__bss_end+0x479f70>
     f78:	06000009 	streq	r0, [r0], -r9
     f7c:	06770e2f 	ldrbteq	r0, [r7], -pc, lsr #28
     f80:	04390000 	ldrteq	r0, [r9], #-0
     f84:	04440000 	strbeq	r0, [r4], #-0
     f88:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
     f8c:	14000006 	strne	r0, [r0], #-6
     f90:	000003e5 	andeq	r0, r0, r5, ror #7
     f94:	07a51500 	streq	r1, [r5, r0, lsl #10]!
     f98:	31060000 	mrscc	r0, (UNDEF: 6)
     f9c:	00074b0e 	andeq	r4, r7, lr, lsl #22
     fa0:	0001f000 	andeq	pc, r1, r0
     fa4:	00045c00 	andeq	r5, r4, r0, lsl #24
     fa8:	00046700 	andeq	r6, r4, r0, lsl #14
     fac:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
     fb0:	eb140000 	bl	500fb8 <__bss_end+0x4f7fac>
     fb4:	00000003 	andeq	r0, r0, r3
     fb8:	000b2716 	andeq	r2, fp, r6, lsl r7
     fbc:	1d350600 	ldcne	6, cr0, [r5, #-0]
     fc0:	000007f9 	strdeq	r0, [r0], -r9
     fc4:	000003e5 	andeq	r0, r0, r5, ror #7
     fc8:	00048002 	andeq	r8, r4, r2
     fcc:	00048600 	andeq	r8, r4, r0, lsl #12
     fd0:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
     fd4:	16000000 	strne	r0, [r0], -r0
     fd8:	00000633 	andeq	r0, r0, r3, lsr r6
     fdc:	2a1d3706 	bcs	74ebfc <__bss_end+0x745bf0>
     fe0:	e5000009 	str	r0, [r0, #-9]
     fe4:	02000003 	andeq	r0, r0, #3
     fe8:	0000049f 	muleq	r0, pc, r4	; <UNPREDICTABLE>
     fec:	000004a5 	andeq	r0, r0, r5, lsr #9
     ff0:	00067813 	andeq	r7, r6, r3, lsl r8
     ff4:	c5170000 	ldrgt	r0, [r7, #-0]
     ff8:	06000008 	streq	r0, [r0], -r8
     ffc:	06913139 			; <UNDEFINED> instruction: 0x06913139
    1000:	020c0000 	andeq	r0, ip, #0
    1004:	0009e016 	andeq	lr, r9, r6, lsl r0
    1008:	093c0600 	ldmdbeq	ip!, {r9, sl}
    100c:	000007b4 			; <UNDEFINED> instruction: 0x000007b4
    1010:	00000678 	andeq	r0, r0, r8, ror r6
    1014:	0004cc01 	andeq	ip, r4, r1, lsl #24
    1018:	0004d200 	andeq	sp, r4, r0, lsl #4
    101c:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
    1020:	16000000 	strne	r0, [r0], -r0
    1024:	000006b9 			; <UNDEFINED> instruction: 0x000006b9
    1028:	1f123f06 	svcne	0x00123f06
    102c:	4d000005 	stcmi	0, cr0, [r0, #-20]	; 0xffffffec
    1030:	01000000 	mrseq	r0, (UNDEF: 0)
    1034:	000004eb 	andeq	r0, r0, fp, ror #9
    1038:	00000500 	andeq	r0, r0, r0, lsl #10
    103c:	00067813 	andeq	r7, r6, r3, lsl r8
    1040:	069a1400 	ldreq	r1, [sl], r0, lsl #8
    1044:	5e140000 	cdppl	0, 1, cr0, cr4, cr0, {0}
    1048:	14000000 	strne	r0, [r0], #-0
    104c:	000001f0 	strdeq	r0, [r0], -r0	; <UNPREDICTABLE>
    1050:	0b571800 	bleq	15c7058 <__bss_end+0x15be04c>
    1054:	42060000 	andmi	r0, r6, #0
    1058:	0005c60e 	andeq	ip, r5, lr, lsl #12
    105c:	05150100 	ldreq	r0, [r5, #-256]	; 0xffffff00
    1060:	051b0000 	ldreq	r0, [fp, #-0]
    1064:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
    1068:	00000006 	andeq	r0, r0, r6
    106c:	00050116 	andeq	r0, r5, r6, lsl r1
    1070:	17450600 	strbne	r0, [r5, -r0, lsl #12]
    1074:	00000568 	andeq	r0, r0, r8, ror #10
    1078:	000003eb 	andeq	r0, r0, fp, ror #7
    107c:	00053401 	andeq	r3, r5, r1, lsl #8
    1080:	00053a00 	andeq	r3, r5, r0, lsl #20
    1084:	06a01300 	strteq	r1, [r0], r0, lsl #6
    1088:	16000000 	strne	r0, [r0], -r0
    108c:	00000a42 	andeq	r0, r0, r2, asr #20
    1090:	ff174806 			; <UNDEFINED> instruction: 0xff174806
    1094:	eb000003 	bl	10a8 <shift+0x10a8>
    1098:	01000003 	tsteq	r0, r3
    109c:	00000553 	andeq	r0, r0, r3, asr r5
    10a0:	0000055e 	andeq	r0, r0, lr, asr r5
    10a4:	0006a013 	andeq	sl, r6, r3, lsl r0
    10a8:	004d1400 	subeq	r1, sp, r0, lsl #8
    10ac:	18000000 	stmdane	r0, {}	; <UNPREDICTABLE>
    10b0:	000005f1 	strdeq	r0, [r0], -r1
    10b4:	d30e4b06 	movwle	r4, #60166	; 0xeb06
    10b8:	01000008 	tsteq	r0, r8
    10bc:	00000573 	andeq	r0, r0, r3, ror r5
    10c0:	00000579 	andeq	r0, r0, r9, ror r5
    10c4:	00067813 	andeq	r7, r6, r3, lsl r8
    10c8:	a5160000 	ldrge	r0, [r6, #-0]
    10cc:	06000007 	streq	r0, [r0], -r7
    10d0:	09800e4d 	stmibeq	r0, {r0, r2, r3, r6, r9, sl, fp}
    10d4:	01f00000 	mvnseq	r0, r0
    10d8:	92010000 	andls	r0, r1, #0
    10dc:	9d000005 	stcls	0, cr0, [r0, #-20]	; 0xffffffec
    10e0:	13000005 	movwne	r0, #5
    10e4:	00000678 	andeq	r0, r0, r8, ror r6
    10e8:	00004d14 	andeq	r4, r0, r4, lsl sp
    10ec:	a7160000 	ldrge	r0, [r6, -r0]
    10f0:	06000004 	streq	r0, [r0], -r4
    10f4:	042c1250 	strteq	r1, [ip], #-592	; 0xfffffdb0
    10f8:	004d0000 	subeq	r0, sp, r0
    10fc:	b6010000 	strlt	r0, [r1], -r0
    1100:	c1000005 	tstgt	r0, r5
    1104:	13000005 	movwne	r0, #5
    1108:	00000678 	andeq	r0, r0, r8, ror r6
    110c:	0001fd14 	andeq	pc, r1, r4, lsl sp	; <UNPREDICTABLE>
    1110:	5f160000 	svcpl	0x00160000
    1114:	06000004 	streq	r0, [r0], -r4
    1118:	0b6b0e53 	bleq	1ac4a6c <__bss_end+0x1abba60>
    111c:	01f00000 	mvnseq	r0, r0
    1120:	da010000 	ble	41128 <__bss_end+0x3811c>
    1124:	e5000005 	str	r0, [r0, #-5]
    1128:	13000005 	movwne	r0, #5
    112c:	00000678 	andeq	r0, r0, r8, ror r6
    1130:	00004d14 	andeq	r4, r0, r4, lsl sp
    1134:	81180000 	tsthi	r8, r0
    1138:	06000004 	streq	r0, [r0], -r4
    113c:	0a960e56 	beq	fe584a9c <__bss_end+0xfe57ba90>
    1140:	fa010000 	blx	41148 <__bss_end+0x3813c>
    1144:	19000005 	stmdbne	r0, {r0, r2}
    1148:	13000006 	movwne	r0, #6
    114c:	00000678 	andeq	r0, r0, r8, ror r6
    1150:	0000a914 	andeq	sl, r0, r4, lsl r9
    1154:	004d1400 	subeq	r1, sp, r0, lsl #8
    1158:	4d140000 	ldcmi	0, cr0, [r4, #-0]
    115c:	14000000 	strne	r0, [r0], #-0
    1160:	0000004d 	andeq	r0, r0, sp, asr #32
    1164:	0006a614 	andeq	sl, r6, r4, lsl r6
    1168:	97180000 	ldrls	r0, [r8, -r0]
    116c:	0600000b 	streq	r0, [r0], -fp
    1170:	0c110e58 	ldceq	14, cr0, [r1], {88}	; 0x58
    1174:	2e010000 	cdpcs	0, 0, cr0, cr1, cr0, {0}
    1178:	4d000006 	stcmi	0, cr0, [r0, #-24]	; 0xffffffe8
    117c:	13000006 	movwne	r0, #6
    1180:	00000678 	andeq	r0, r0, r8, ror r6
    1184:	0000e014 	andeq	lr, r0, r4, lsl r0
    1188:	004d1400 	subeq	r1, sp, r0, lsl #8
    118c:	4d140000 	ldcmi	0, cr0, [r4, #-0]
    1190:	14000000 	strne	r0, [r0], #-0
    1194:	0000004d 	andeq	r0, r0, sp, asr #32
    1198:	0006a614 	andeq	sl, r6, r4, lsl r6
    119c:	94190000 	ldrls	r0, [r9], #-0
    11a0:	06000004 	streq	r0, [r0], -r4
    11a4:	08520e5b 	ldmdaeq	r2, {r0, r1, r3, r4, r6, r9, sl, fp}^
    11a8:	01f00000 	mvnseq	r0, r0
    11ac:	62010000 	andvs	r0, r1, #0
    11b0:	13000006 	movwne	r0, #6
    11b4:	00000678 	andeq	r0, r0, r8, ror r6
    11b8:	00036814 	andeq	r6, r3, r4, lsl r8
    11bc:	06ac1400 	strteq	r1, [ip], r0, lsl #8
    11c0:	00000000 	andeq	r0, r0, r0
    11c4:	0003f103 	andeq	pc, r3, r3, lsl #2
    11c8:	f1040d00 			; <UNDEFINED> instruction: 0xf1040d00
    11cc:	1a000003 	bne	11e0 <shift+0x11e0>
    11d0:	000003e5 	andeq	r0, r0, r5, ror #7
    11d4:	0000068b 	andeq	r0, r0, fp, lsl #13
    11d8:	00000691 	muleq	r0, r1, r6
    11dc:	00067813 	andeq	r7, r6, r3, lsl r8
    11e0:	f11b0000 			; <UNDEFINED> instruction: 0xf11b0000
    11e4:	7e000003 	cdpvc	0, 0, cr0, cr0, cr3, {0}
    11e8:	0d000006 	stceq	0, cr0, [r0, #-24]	; 0xffffffe8
    11ec:	00003f04 	andeq	r3, r0, r4, lsl #30
    11f0:	73040d00 	movwvc	r0, #19712	; 0x4d00
    11f4:	1c000006 	stcne	0, cr0, [r0], {6}
    11f8:	00006504 	andeq	r6, r0, r4, lsl #10
    11fc:	0f041d00 	svceq	0x00041d00
    1200:	0000002c 	andeq	r0, r0, ip, lsr #32
    1204:	000006be 			; <UNDEFINED> instruction: 0x000006be
    1208:	00005e10 	andeq	r5, r0, r0, lsl lr
    120c:	03000900 	movweq	r0, #2304	; 0x900
    1210:	000006ae 	andeq	r0, r0, lr, lsr #13
    1214:	000d631e 	andeq	r6, sp, lr, lsl r3
    1218:	0ca30100 	stfeqs	f0, [r3]
    121c:	000006be 			; <UNDEFINED> instruction: 0x000006be
    1220:	8fcc0305 	svchi	0x00cc0305
    1224:	d31f0000 	tstle	pc, #0
    1228:	0100000c 	tsteq	r0, ip
    122c:	0df50aa5 			; <UNDEFINED> instruction: 0x0df50aa5
    1230:	004d0000 	subeq	r0, sp, r0
    1234:	872c0000 	strhi	r0, [ip, -r0]!
    1238:	00b00000 	adcseq	r0, r0, r0
    123c:	9c010000 	stcls	0, cr0, [r1], {-0}
    1240:	00000733 	andeq	r0, r0, r3, lsr r7
    1244:	00108820 	andseq	r8, r0, r0, lsr #16
    1248:	1ba50100 	blne	fe941650 <__bss_end+0xfe938644>
    124c:	000001f7 	strdeq	r0, [r0], -r7
    1250:	7fac9103 	svcvc	0x00ac9103
    1254:	000e5420 	andeq	r5, lr, r0, lsr #8
    1258:	2aa50100 	bcs	fe941660 <__bss_end+0xfe938654>
    125c:	0000004d 	andeq	r0, r0, sp, asr #32
    1260:	7fa89103 	svcvc	0x00a89103
    1264:	000dde1e 	andeq	sp, sp, lr, lsl lr
    1268:	0aa70100 	beq	fe9c1670 <__bss_end+0xfe9b8664>
    126c:	00000733 	andeq	r0, r0, r3, lsr r7
    1270:	7fb49103 	svcvc	0x00b49103
    1274:	000cce1e 	andeq	ip, ip, lr, lsl lr
    1278:	09ab0100 	stmibeq	fp!, {r8}
    127c:	00000038 	andeq	r0, r0, r8, lsr r0
    1280:	00749102 	rsbseq	r9, r4, r2, lsl #2
    1284:	0000250f 	andeq	r2, r0, pc, lsl #10
    1288:	00074300 	andeq	r4, r7, r0, lsl #6
    128c:	005e1000 	subseq	r1, lr, r0
    1290:	003f0000 	eorseq	r0, pc, r0
    1294:	000e3921 	andeq	r3, lr, r1, lsr #18
    1298:	0a970100 	beq	fe5c16a0 <__bss_end+0xfe5b8694>
    129c:	00000f0b 	andeq	r0, r0, fp, lsl #30
    12a0:	0000004d 	andeq	r0, r0, sp, asr #32
    12a4:	000086f0 	strdeq	r8, [r0], -r0
    12a8:	0000003c 	andeq	r0, r0, ip, lsr r0
    12ac:	07809c01 	streq	r9, [r0, r1, lsl #24]
    12b0:	72220000 	eorvc	r0, r2, #0
    12b4:	01007165 	tsteq	r0, r5, ror #2
    12b8:	03ab2099 			; <UNDEFINED> instruction: 0x03ab2099
    12bc:	91020000 	mrsls	r0, (UNDEF: 2)
    12c0:	0dea1e74 	stcleq	14, cr1, [sl, #464]!	; 0x1d0
    12c4:	9a010000 	bls	412cc <__bss_end+0x382c0>
    12c8:	00004d0e 	andeq	r4, r0, lr, lsl #26
    12cc:	70910200 	addsvc	r0, r1, r0, lsl #4
    12d0:	0e5d2300 	cdpeq	3, 5, cr2, cr13, cr0, {0}
    12d4:	8e010000 	cdphi	0, 0, cr0, cr1, cr0, {0}
    12d8:	000cef06 	andeq	lr, ip, r6, lsl #30
    12dc:	0086b400 	addeq	fp, r6, r0, lsl #8
    12e0:	00003c00 	andeq	r3, r0, r0, lsl #24
    12e4:	b99c0100 	ldmiblt	ip, {r8}
    12e8:	20000007 	andcs	r0, r0, r7
    12ec:	00000d31 	andeq	r0, r0, r1, lsr sp
    12f0:	4d218e01 	stcmi	14, cr8, [r1, #-4]!
    12f4:	02000000 	andeq	r0, r0, #0
    12f8:	72226c91 	eorvc	r6, r2, #37120	; 0x9100
    12fc:	01007165 	tsteq	r0, r5, ror #2
    1300:	03ab2090 			; <UNDEFINED> instruction: 0x03ab2090
    1304:	91020000 	mrsls	r0, (UNDEF: 2)
    1308:	16210074 			; <UNDEFINED> instruction: 0x16210074
    130c:	0100000e 	tsteq	r0, lr
    1310:	0d7f0a82 	vldmdbeq	pc!, {s1-s130}
    1314:	004d0000 	subeq	r0, sp, r0
    1318:	86780000 	ldrbthi	r0, [r8], -r0
    131c:	003c0000 	eorseq	r0, ip, r0
    1320:	9c010000 	stcls	0, cr0, [r1], {-0}
    1324:	000007f6 	strdeq	r0, [r0], -r6
    1328:	71657222 	cmnvc	r5, r2, lsr #4
    132c:	20840100 	addcs	r0, r4, r0, lsl #2
    1330:	00000387 	andeq	r0, r0, r7, lsl #7
    1334:	1e749102 	expnes	f1, f2
    1338:	00000cc7 	andeq	r0, r0, r7, asr #25
    133c:	4d0e8501 	cfstr32mi	mvfx8, [lr, #-4]
    1340:	02000000 	andeq	r0, r0, #0
    1344:	21007091 	swpcs	r7, r1, [r0]
    1348:	0000106b 	andeq	r1, r0, fp, rrx
    134c:	450a7601 	strmi	r7, [sl, #-1537]	; 0xfffff9ff
    1350:	4d00000d 	stcmi	0, cr0, [r0, #-52]	; 0xffffffcc
    1354:	3c000000 	stccc	0, cr0, [r0], {-0}
    1358:	3c000086 	stccc	0, cr0, [r0], {134}	; 0x86
    135c:	01000000 	mrseq	r0, (UNDEF: 0)
    1360:	0008339c 	muleq	r8, ip, r3
    1364:	65722200 	ldrbvs	r2, [r2, #-512]!	; 0xfffffe00
    1368:	78010071 	stmdavc	r1, {r0, r4, r5, r6}
    136c:	00038720 	andeq	r8, r3, r0, lsr #14
    1370:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    1374:	000cc71e 	andeq	ip, ip, lr, lsl r7
    1378:	0e790100 	rpweqe	f0, f1, f0
    137c:	0000004d 	andeq	r0, r0, sp, asr #32
    1380:	00709102 	rsbseq	r9, r0, r2, lsl #2
    1384:	000d9321 	andeq	r9, sp, r1, lsr #6
    1388:	066a0100 	strbteq	r0, [sl], -r0, lsl #2
    138c:	00000ed6 	ldrdeq	r0, [r0], -r6
    1390:	000001f0 	strdeq	r0, [r0], -r0	; <UNPREDICTABLE>
    1394:	000085e8 	andeq	r8, r0, r8, ror #11
    1398:	00000054 	andeq	r0, r0, r4, asr r0
    139c:	087f9c01 	ldmdaeq	pc!, {r0, sl, fp, ip, pc}^	; <UNPREDICTABLE>
    13a0:	ea200000 	b	8013a8 <__bss_end+0x7f839c>
    13a4:	0100000d 	tsteq	r0, sp
    13a8:	004d156a 	subeq	r1, sp, sl, ror #10
    13ac:	91020000 	mrsls	r0, (UNDEF: 2)
    13b0:	0969206c 	stmdbeq	r9!, {r2, r3, r5, r6, sp}^
    13b4:	6a010000 	bvs	413bc <__bss_end+0x383b0>
    13b8:	00004d25 	andeq	r4, r0, r5, lsr #26
    13bc:	68910200 	ldmvs	r1, {r9}
    13c0:	0010631e 	andseq	r6, r0, lr, lsl r3
    13c4:	0e6c0100 	poweqe	f0, f4, f0
    13c8:	0000004d 	andeq	r0, r0, sp, asr #32
    13cc:	00749102 	rsbseq	r9, r4, r2, lsl #2
    13d0:	000d0621 	andeq	r0, sp, r1, lsr #12
    13d4:	125d0100 	subsne	r0, sp, #0, 2
    13d8:	00000f42 	andeq	r0, r0, r2, asr #30
    13dc:	0000008b 	andeq	r0, r0, fp, lsl #1
    13e0:	00008598 	muleq	r0, r8, r5
    13e4:	00000050 	andeq	r0, r0, r0, asr r0
    13e8:	08da9c01 	ldmeq	sl, {r0, sl, fp, ip, pc}^
    13ec:	e1200000 			; <UNDEFINED> instruction: 0xe1200000
    13f0:	0100000e 	tsteq	r0, lr
    13f4:	004d205d 	subeq	r2, sp, sp, asr r0
    13f8:	91020000 	mrsls	r0, (UNDEF: 2)
    13fc:	0e1f206c 	cdpeq	0, 1, cr2, cr15, cr12, {3}
    1400:	5d010000 	stcpl	0, cr0, [r1, #-0]
    1404:	00004d2f 	andeq	r4, r0, pc, lsr #26
    1408:	68910200 	ldmvs	r1, {r9}
    140c:	00096920 	andeq	r6, r9, r0, lsr #18
    1410:	3f5d0100 	svccc	0x005d0100
    1414:	0000004d 	andeq	r0, r0, sp, asr #32
    1418:	1e649102 	lgnnes	f1, f2
    141c:	00001063 	andeq	r1, r0, r3, rrx
    1420:	8b165f01 	blhi	59902c <__bss_end+0x590020>
    1424:	02000000 	andeq	r0, r0, #0
    1428:	21007491 			; <UNDEFINED> instruction: 0x21007491
    142c:	00000f78 	andeq	r0, r0, r8, ror pc
    1430:	0b0a5101 	bleq	29583c <__bss_end+0x28c830>
    1434:	4d00000d 	stcmi	0, cr0, [r0, #-52]	; 0xffffffcc
    1438:	54000000 	strpl	r0, [r0], #-0
    143c:	44000085 	strmi	r0, [r0], #-133	; 0xffffff7b
    1440:	01000000 	mrseq	r0, (UNDEF: 0)
    1444:	0009269c 	muleq	r9, ip, r6
    1448:	0ee12000 	cdpeq	0, 14, cr2, cr1, cr0, {0}
    144c:	51010000 	mrspl	r0, (UNDEF: 1)
    1450:	00004d1a 	andeq	r4, r0, sl, lsl sp
    1454:	6c910200 	lfmvs	f0, 4, [r1], {0}
    1458:	000e1f20 	andeq	r1, lr, r0, lsr #30
    145c:	29510100 	ldmdbcs	r1, {r8}^
    1460:	0000004d 	andeq	r0, r0, sp, asr #32
    1464:	1e689102 	lgnnee	f1, f2
    1468:	00000f71 	andeq	r0, r0, r1, ror pc
    146c:	4d0e5301 	stcmi	3, cr5, [lr, #-4]
    1470:	02000000 	andeq	r0, r0, #0
    1474:	21007491 			; <UNDEFINED> instruction: 0x21007491
    1478:	00000f6b 	andeq	r0, r0, fp, ror #30
    147c:	4d0a4401 	cfstrsmi	mvf4, [sl, #-4]
    1480:	4d00000f 	stcmi	0, cr0, [r0, #-60]	; 0xffffffc4
    1484:	04000000 	streq	r0, [r0], #-0
    1488:	50000085 	andpl	r0, r0, r5, lsl #1
    148c:	01000000 	mrseq	r0, (UNDEF: 0)
    1490:	0009819c 	muleq	r9, ip, r1
    1494:	0ee12000 	cdpeq	0, 14, cr2, cr1, cr0, {0}
    1498:	44010000 	strmi	r0, [r1], #-0
    149c:	00004d19 	andeq	r4, r0, r9, lsl sp
    14a0:	6c910200 	lfmvs	f0, 4, [r1], {0}
    14a4:	000dbf20 	andeq	fp, sp, r0, lsr #30
    14a8:	30440100 	subcc	r0, r4, r0, lsl #2
    14ac:	0000011d 	andeq	r0, r0, sp, lsl r1
    14b0:	20689102 	rsbcs	r9, r8, r2, lsl #2
    14b4:	00000e25 	andeq	r0, r0, r5, lsr #28
    14b8:	ac414401 	cfstrdge	mvd4, [r1], {1}
    14bc:	02000006 	andeq	r0, r0, #6
    14c0:	631e6491 	tstvs	lr, #-1862270976	; 0x91000000
    14c4:	01000010 	tsteq	r0, r0, lsl r0
    14c8:	004d0e46 	subeq	r0, sp, r6, asr #28
    14cc:	91020000 	mrsls	r0, (UNDEF: 2)
    14d0:	b4230074 	strtlt	r0, [r3], #-116	; 0xffffff8c
    14d4:	0100000c 	tsteq	r0, ip
    14d8:	0dc9063e 	stcleq	6, cr0, [r9, #248]	; 0xf8
    14dc:	84d80000 	ldrbhi	r0, [r8], #0
    14e0:	002c0000 	eoreq	r0, ip, r0
    14e4:	9c010000 	stcls	0, cr0, [r1], {-0}
    14e8:	000009ab 	andeq	r0, r0, fp, lsr #19
    14ec:	000ee120 	andeq	lr, lr, r0, lsr #2
    14f0:	153e0100 	ldrne	r0, [lr, #-256]!	; 0xffffff00
    14f4:	0000004d 	andeq	r0, r0, sp, asr #32
    14f8:	00749102 	rsbseq	r9, r4, r2, lsl #2
    14fc:	000de421 	andeq	lr, sp, r1, lsr #8
    1500:	0a310100 	beq	c41908 <__bss_end+0xc388fc>
    1504:	00000e2b 	andeq	r0, r0, fp, lsr #28
    1508:	0000004d 	andeq	r0, r0, sp, asr #32
    150c:	00008488 	andeq	r8, r0, r8, lsl #9
    1510:	00000050 	andeq	r0, r0, r0, asr r0
    1514:	0a069c01 	beq	1a8520 <__bss_end+0x19f514>
    1518:	e1200000 			; <UNDEFINED> instruction: 0xe1200000
    151c:	0100000e 	tsteq	r0, lr
    1520:	004d1931 	subeq	r1, sp, r1, lsr r9
    1524:	91020000 	mrsls	r0, (UNDEF: 2)
    1528:	0f8e206c 	svceq	0x008e206c
    152c:	31010000 	mrscc	r0, (UNDEF: 1)
    1530:	0001f72b 	andeq	pc, r1, fp, lsr #14
    1534:	68910200 	ldmvs	r1, {r9}
    1538:	000e5820 	andeq	r5, lr, r0, lsr #16
    153c:	3c310100 	ldfccs	f0, [r1], #-0
    1540:	0000004d 	andeq	r0, r0, sp, asr #32
    1544:	1e649102 	lgnnes	f1, f2
    1548:	00000f3c 	andeq	r0, r0, ip, lsr pc
    154c:	4d0e3301 	stcmi	3, cr3, [lr, #-4]
    1550:	02000000 	andeq	r0, r0, #0
    1554:	21007491 			; <UNDEFINED> instruction: 0x21007491
    1558:	0000108d 	andeq	r1, r0, sp, lsl #1
    155c:	950a2401 	strls	r2, [sl, #-1025]	; 0xfffffbff
    1560:	4d00000f 	stcmi	0, cr0, [r0, #-60]	; 0xffffffc4
    1564:	38000000 	stmdacc	r0, {}	; <UNPREDICTABLE>
    1568:	50000084 	andpl	r0, r0, r4, lsl #1
    156c:	01000000 	mrseq	r0, (UNDEF: 0)
    1570:	000a619c 	muleq	sl, ip, r1
    1574:	0ee12000 	cdpeq	0, 14, cr2, cr1, cr0, {0}
    1578:	24010000 	strcs	r0, [r1], #-0
    157c:	00004d18 	andeq	r4, r0, r8, lsl sp
    1580:	6c910200 	lfmvs	f0, 4, [r1], {0}
    1584:	000f8e20 	andeq	r8, pc, r0, lsr #28
    1588:	2a240100 	bcs	901990 <__bss_end+0x8f8984>
    158c:	00000a67 	andeq	r0, r0, r7, ror #20
    1590:	20689102 	rsbcs	r9, r8, r2, lsl #2
    1594:	00000e58 	andeq	r0, r0, r8, asr lr
    1598:	4d3b2401 	cfldrsmi	mvf2, [fp, #-4]!
    159c:	02000000 	andeq	r0, r0, #0
    15a0:	d81e6491 	ldmdale	lr, {r0, r4, r7, sl, sp, lr}
    15a4:	0100000c 	tsteq	r0, ip
    15a8:	004d0e26 	subeq	r0, sp, r6, lsr #28
    15ac:	91020000 	mrsls	r0, (UNDEF: 2)
    15b0:	040d0074 	streq	r0, [sp], #-116	; 0xffffff8c
    15b4:	00000025 	andeq	r0, r0, r5, lsr #32
    15b8:	000a6103 	andeq	r6, sl, r3, lsl #2
    15bc:	0df02100 	ldfeqe	f2, [r0]
    15c0:	19010000 	stmdbne	r1, {}	; <UNPREDICTABLE>
    15c4:	0010990a 	andseq	r9, r0, sl, lsl #18
    15c8:	00004d00 	andeq	r4, r0, r0, lsl #26
    15cc:	0083f400 	addeq	pc, r3, r0, lsl #8
    15d0:	00004400 	andeq	r4, r0, r0, lsl #8
    15d4:	b89c0100 	ldmlt	ip, {r8}
    15d8:	2000000a 	andcs	r0, r0, sl
    15dc:	00001084 	andeq	r1, r0, r4, lsl #1
    15e0:	f71b1901 			; <UNDEFINED> instruction: 0xf71b1901
    15e4:	02000001 	andeq	r0, r0, #1
    15e8:	89206c91 	stmdbhi	r0!, {r0, r4, r7, sl, fp, sp, lr}
    15ec:	0100000f 	tsteq	r0, pc
    15f0:	01c63519 	biceq	r3, r6, r9, lsl r5
    15f4:	91020000 	mrsls	r0, (UNDEF: 2)
    15f8:	0ee11e68 	cdpeq	14, 14, cr1, cr1, cr8, {3}
    15fc:	1b010000 	blne	41604 <__bss_end+0x385f8>
    1600:	00004d0e 	andeq	r4, r0, lr, lsl #26
    1604:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    1608:	0d252400 	cfstrseq	mvf2, [r5, #-0]
    160c:	14010000 	strne	r0, [r1], #-0
    1610:	000cde06 	andeq	sp, ip, r6, lsl #28
    1614:	0083d800 	addeq	sp, r3, r0, lsl #16
    1618:	00001c00 	andeq	r1, r0, r0, lsl #24
    161c:	239c0100 	orrscs	r0, ip, #0, 2
    1620:	00000f7f 	andeq	r0, r0, pc, ror pc
    1624:	b1060e01 	tstlt	r6, r1, lsl #28
    1628:	ac00000d 	stcge	0, cr0, [r0], {13}
    162c:	2c000083 	stccs	0, cr0, [r0], {131}	; 0x83
    1630:	01000000 	mrseq	r0, (UNDEF: 0)
    1634:	000af89c 	muleq	sl, ip, r8
    1638:	0d1c2000 	ldceq	0, cr2, [ip, #-0]
    163c:	0e010000 	cdpeq	0, 0, cr0, cr1, cr0, {0}
    1640:	00003814 	andeq	r3, r0, r4, lsl r8
    1644:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    1648:	10922500 	addsne	r2, r2, r0, lsl #10
    164c:	04010000 	streq	r0, [r1], #-0
    1650:	000dd30a 	andeq	sp, sp, sl, lsl #6
    1654:	00004d00 	andeq	r4, r0, r0, lsl #26
    1658:	00838000 	addeq	r8, r3, r0
    165c:	00002c00 	andeq	r2, r0, r0, lsl #24
    1660:	229c0100 	addscs	r0, ip, #0, 2
    1664:	00646970 	rsbeq	r6, r4, r0, ror r9
    1668:	4d0e0601 	stcmi	6, cr0, [lr, #-4]
    166c:	02000000 	andeq	r0, r0, #0
    1670:	00007491 	muleq	r0, r1, r4
    1674:	0000032e 	andeq	r0, r0, lr, lsr #6
    1678:	06da0004 	ldrbeq	r0, [sl], r4
    167c:	01040000 	mrseq	r0, (UNDEF: 4)
    1680:	00000fa1 	andeq	r0, r0, r1, lsr #31
    1684:	0010d904 	andseq	sp, r0, r4, lsl #18
    1688:	000c6900 	andeq	r6, ip, r0, lsl #18
    168c:	0087dc00 	addeq	sp, r7, r0, lsl #24
    1690:	0004b800 	andeq	fp, r4, r0, lsl #16
    1694:	00081800 	andeq	r1, r8, r0, lsl #16
    1698:	00490200 	subeq	r0, r9, r0, lsl #4
    169c:	42030000 	andmi	r0, r3, #0
    16a0:	01000011 	tsteq	r0, r1, lsl r0
    16a4:	00611005 	rsbeq	r1, r1, r5
    16a8:	30110000 	andscc	r0, r1, r0
    16ac:	34333231 	ldrtcc	r3, [r3], #-561	; 0xfffffdcf
    16b0:	38373635 	ldmdacc	r7!, {r0, r2, r4, r5, r9, sl, ip, sp}
    16b4:	43424139 	movtmi	r4, #8505	; 0x2139
    16b8:	00464544 	subeq	r4, r6, r4, asr #10
    16bc:	03010400 	movweq	r0, #5120	; 0x1400
    16c0:	00002501 	andeq	r2, r0, r1, lsl #10
    16c4:	00740500 	rsbseq	r0, r4, r0, lsl #10
    16c8:	00610000 	rsbeq	r0, r1, r0
    16cc:	66060000 	strvs	r0, [r6], -r0
    16d0:	10000000 	andne	r0, r0, r0
    16d4:	00510700 	subseq	r0, r1, r0, lsl #14
    16d8:	04080000 	streq	r0, [r8], #-0
    16dc:	000a6a07 	andeq	r6, sl, r7, lsl #20
    16e0:	08010800 	stmdaeq	r1, {fp}
    16e4:	00000aff 	strdeq	r0, [r0], -pc	; <UNPREDICTABLE>
    16e8:	00006d07 	andeq	r6, r0, r7, lsl #26
    16ec:	002a0900 	eoreq	r0, sl, r0, lsl #18
    16f0:	710a0000 	mrsvc	r0, (UNDEF: 10)
    16f4:	01000011 	tsteq	r0, r1, lsl r0
    16f8:	115c0664 	cmpne	ip, r4, ror #12
    16fc:	8c140000 	ldchi	0, cr0, [r4], {-0}
    1700:	00800000 	addeq	r0, r0, r0
    1704:	9c010000 	stcls	0, cr0, [r1], {-0}
    1708:	000000fb 	strdeq	r0, [r0], -fp
    170c:	6372730b 	cmnvs	r2, #738197504	; 0x2c000000
    1710:	19640100 	stmdbne	r4!, {r8}^
    1714:	000000fb 	strdeq	r0, [r0], -fp
    1718:	0b649102 	bleq	1925b28 <__bss_end+0x191cb1c>
    171c:	00747364 	rsbseq	r7, r4, r4, ror #6
    1720:	02246401 	eoreq	r6, r4, #16777216	; 0x1000000
    1724:	02000001 	andeq	r0, r0, #1
    1728:	6e0b6091 	mcrvs	0, 0, r6, cr11, cr1, {4}
    172c:	01006d75 	tsteq	r0, r5, ror sp
    1730:	01042d64 	tsteq	r4, r4, ror #26
    1734:	91020000 	mrsls	r0, (UNDEF: 2)
    1738:	11cb0c5c 	bicne	r0, fp, ip, asr ip
    173c:	66010000 	strvs	r0, [r1], -r0
    1740:	00010b0e 	andeq	r0, r1, lr, lsl #22
    1744:	70910200 	addsvc	r0, r1, r0, lsl #4
    1748:	00114e0c 	andseq	r4, r1, ip, lsl #28
    174c:	08670100 	stmdaeq	r7!, {r8}^
    1750:	00000111 	andeq	r0, r0, r1, lsl r1
    1754:	0d6c9102 	stfeqp	f1, [ip, #-8]!
    1758:	00008c3c 	andeq	r8, r0, ip, lsr ip
    175c:	00000048 	andeq	r0, r0, r8, asr #32
    1760:	0100690e 	tsteq	r0, lr, lsl #18
    1764:	01040b69 	tsteq	r4, r9, ror #22
    1768:	91020000 	mrsls	r0, (UNDEF: 2)
    176c:	0f000074 	svceq	0x00000074
    1770:	00010104 	andeq	r0, r1, r4, lsl #2
    1774:	04111000 	ldreq	r1, [r1], #-0
    1778:	69050412 	stmdbvs	r5, {r1, r4, sl}
    177c:	0f00746e 	svceq	0x0000746e
    1780:	00007404 	andeq	r7, r0, r4, lsl #8
    1784:	6d040f00 	stcvs	15, cr0, [r4, #-0]
    1788:	0a000000 	beq	1790 <shift+0x1790>
    178c:	000010c0 	andeq	r1, r0, r0, asr #1
    1790:	cd065c01 	stcgt	12, cr5, [r6, #-4]
    1794:	ac000010 	stcge	0, cr0, [r0], {16}
    1798:	6800008b 	stmdavs	r0, {r0, r1, r3, r7}
    179c:	01000000 	mrseq	r0, (UNDEF: 0)
    17a0:	0001769c 	muleq	r1, ip, r6
    17a4:	11c41300 	bicne	r1, r4, r0, lsl #6
    17a8:	5c010000 	stcpl	0, cr0, [r1], {-0}
    17ac:	00010212 	andeq	r0, r1, r2, lsl r2
    17b0:	6c910200 	lfmvs	f0, 4, [r1], {0}
    17b4:	0010c613 	andseq	ip, r0, r3, lsl r6
    17b8:	1e5c0100 	rdfnee	f0, f4, f0
    17bc:	00000104 	andeq	r0, r0, r4, lsl #2
    17c0:	0e689102 	lgneqe	f1, f2
    17c4:	006d656d 	rsbeq	r6, sp, sp, ror #10
    17c8:	11085e01 	tstne	r8, r1, lsl #28
    17cc:	02000001 	andeq	r0, r0, #1
    17d0:	c80d7091 	stmdagt	sp, {r0, r4, r7, ip, sp, lr}
    17d4:	3c00008b 	stccc	0, cr0, [r0], {139}	; 0x8b
    17d8:	0e000000 	cdpeq	0, 0, cr0, cr0, cr0, {0}
    17dc:	60010069 	andvs	r0, r1, r9, rrx
    17e0:	0001040b 	andeq	r0, r1, fp, lsl #8
    17e4:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    17e8:	78140000 	ldmdavc	r4, {}	; <UNPREDICTABLE>
    17ec:	01000011 	tsteq	r0, r1, lsl r0
    17f0:	11910552 	orrsne	r0, r1, r2, asr r5
    17f4:	01040000 	mrseq	r0, (UNDEF: 4)
    17f8:	8b580000 	blhi	1601800 <__bss_end+0x15f87f4>
    17fc:	00540000 	subseq	r0, r4, r0
    1800:	9c010000 	stcls	0, cr0, [r1], {-0}
    1804:	000001af 	andeq	r0, r0, pc, lsr #3
    1808:	0100730b 	tsteq	r0, fp, lsl #6
    180c:	010b1852 	tsteq	fp, r2, asr r8
    1810:	91020000 	mrsls	r0, (UNDEF: 2)
    1814:	00690e6c 	rsbeq	r0, r9, ip, ror #28
    1818:	04065401 	streq	r5, [r6], #-1025	; 0xfffffbff
    181c:	02000001 	andeq	r0, r0, #1
    1820:	14007491 	strne	r7, [r0], #-1169	; 0xfffffb6f
    1824:	000011b4 			; <UNDEFINED> instruction: 0x000011b4
    1828:	7f054201 	svcvc	0x00054201
    182c:	04000011 	streq	r0, [r0], #-17	; 0xffffffef
    1830:	ac000001 	stcge	0, cr0, [r0], {1}
    1834:	ac00008a 	stcge	0, cr0, [r0], {138}	; 0x8a
    1838:	01000000 	mrseq	r0, (UNDEF: 0)
    183c:	0002159c 	muleq	r2, ip, r5
    1840:	31730b00 	cmncc	r3, r0, lsl #22
    1844:	19420100 	stmdbne	r2, {r8}^
    1848:	0000010b 	andeq	r0, r0, fp, lsl #2
    184c:	0b6c9102 	bleq	1b25c5c <__bss_end+0x1b1cc50>
    1850:	01003273 	tsteq	r0, r3, ror r2
    1854:	010b2942 	tsteq	fp, r2, asr #18
    1858:	91020000 	mrsls	r0, (UNDEF: 2)
    185c:	756e0b68 	strbvc	r0, [lr, #-2920]!	; 0xfffff498
    1860:	4201006d 	andmi	r0, r1, #109	; 0x6d
    1864:	00010431 	andeq	r0, r1, r1, lsr r4
    1868:	64910200 	ldrvs	r0, [r1], #512	; 0x200
    186c:	0031750e 	eorseq	r7, r1, lr, lsl #10
    1870:	15104401 	ldrne	r4, [r0, #-1025]	; 0xfffffbff
    1874:	02000002 	andeq	r0, r0, #2
    1878:	750e7791 	strvc	r7, [lr, #-1937]	; 0xfffff86f
    187c:	44010032 	strmi	r0, [r1], #-50	; 0xffffffce
    1880:	00021514 	andeq	r1, r2, r4, lsl r5
    1884:	76910200 	ldrvc	r0, [r1], r0, lsl #4
    1888:	08010800 	stmdaeq	r1, {fp}
    188c:	00000af6 	strdeq	r0, [r0], -r6
    1890:	0011bc14 	andseq	fp, r1, r4, lsl ip
    1894:	07360100 	ldreq	r0, [r6, -r0, lsl #2]!
    1898:	000011a3 	andeq	r1, r0, r3, lsr #3
    189c:	00000111 	andeq	r0, r0, r1, lsl r1
    18a0:	000089ec 	andeq	r8, r0, ip, ror #19
    18a4:	000000c0 	andeq	r0, r0, r0, asr #1
    18a8:	02759c01 	rsbseq	r9, r5, #256	; 0x100
    18ac:	bb130000 	bllt	4c18b4 <__bss_end+0x4b88a8>
    18b0:	01000010 	tsteq	r0, r0, lsl r0
    18b4:	01111536 	tsteq	r1, r6, lsr r5
    18b8:	91020000 	mrsls	r0, (UNDEF: 2)
    18bc:	72730b6c 	rsbsvc	r0, r3, #108, 22	; 0x1b000
    18c0:	36010063 	strcc	r0, [r1], -r3, rrx
    18c4:	00010b27 	andeq	r0, r1, r7, lsr #22
    18c8:	68910200 	ldmvs	r1, {r9}
    18cc:	6d756e0b 	ldclvs	14, cr6, [r5, #-44]!	; 0xffffffd4
    18d0:	30360100 	eorscc	r0, r6, r0, lsl #2
    18d4:	00000104 	andeq	r0, r0, r4, lsl #2
    18d8:	0e649102 	lgneqs	f1, f2
    18dc:	38010069 	stmdacc	r1, {r0, r3, r5, r6}
    18e0:	00010406 	andeq	r0, r1, r6, lsl #8
    18e4:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    18e8:	119e1400 	orrsne	r1, lr, r0, lsl #8
    18ec:	24010000 	strcs	r0, [r1], #-0
    18f0:	00113705 	andseq	r3, r1, r5, lsl #14
    18f4:	00010400 	andeq	r0, r1, r0, lsl #8
    18f8:	00895000 	addeq	r5, r9, r0
    18fc:	00009c00 	andeq	r9, r0, r0, lsl #24
    1900:	b29c0100 	addslt	r0, ip, #0, 2
    1904:	13000002 	movwne	r0, #2
    1908:	000010b5 	strheq	r1, [r0], -r5
    190c:	0b162401 	bleq	58a918 <__bss_end+0x58190c>
    1910:	02000001 	andeq	r0, r0, #1
    1914:	550c6c91 	strpl	r6, [ip, #-3217]	; 0xfffff36f
    1918:	01000011 	tsteq	r0, r1, lsl r0
    191c:	01040626 	tsteq	r4, r6, lsr #12
    1920:	91020000 	mrsls	r0, (UNDEF: 2)
    1924:	d2150074 	andsle	r0, r5, #116	; 0x74
    1928:	01000011 	tsteq	r0, r1, lsl r0
    192c:	11d70608 	bicsne	r0, r7, r8, lsl #12
    1930:	87dc0000 	ldrbhi	r0, [ip, r0]
    1934:	01740000 	cmneq	r4, r0
    1938:	9c010000 	stcls	0, cr0, [r1], {-0}
    193c:	0010b513 	andseq	fp, r0, r3, lsl r5
    1940:	18080100 	stmdane	r8, {r8}
    1944:	00000066 	andeq	r0, r0, r6, rrx
    1948:	13649102 	cmnne	r4, #-2147483648	; 0x80000000
    194c:	00001155 	andeq	r1, r0, r5, asr r1
    1950:	11250801 			; <UNDEFINED> instruction: 0x11250801
    1954:	02000001 	andeq	r0, r0, #1
    1958:	6c136091 	ldcvs	0, cr6, [r3], {145}	; 0x91
    195c:	01000011 	tsteq	r0, r1, lsl r0
    1960:	00663a08 	rsbeq	r3, r6, r8, lsl #20
    1964:	91020000 	mrsls	r0, (UNDEF: 2)
    1968:	00690e5c 	rsbeq	r0, r9, ip, asr lr
    196c:	04060a01 	streq	r0, [r6], #-2561	; 0xfffff5ff
    1970:	02000001 	andeq	r0, r0, #1
    1974:	a80d7491 	stmdage	sp, {r0, r4, r7, sl, ip, sp, lr}
    1978:	98000088 	stmdals	r0, {r3, r7}
    197c:	0e000000 	cdpeq	0, 0, cr0, cr0, cr0, {0}
    1980:	1c01006a 	stcne	0, cr0, [r1], {106}	; 0x6a
    1984:	0001040b 	andeq	r0, r1, fp, lsl #8
    1988:	70910200 	addsvc	r0, r1, r0, lsl #4
    198c:	0088d00d 	addeq	sp, r8, sp
    1990:	00006000 	andeq	r6, r0, r0
    1994:	00630e00 	rsbeq	r0, r3, r0, lsl #28
    1998:	6d081e01 	stcvs	14, cr1, [r8, #-4]
    199c:	02000000 	andeq	r0, r0, #0
    19a0:	00006f91 	muleq	r0, r1, pc	; <UNPREDICTABLE>
	...

Disassembly of section .debug_abbrev:

00000000 <.debug_abbrev>:
   0:	10001101 	andne	r1, r0, r1, lsl #2
   4:	12011106 	andne	r1, r1, #-2147483647	; 0x80000001
   8:	1b0e0301 	blne	380c14 <__bss_end+0x377c08>
   c:	130e250e 	movwne	r2, #58638	; 0xe50e
  10:	00000005 	andeq	r0, r0, r5
  14:	25011101 	strcs	r1, [r1, #-257]	; 0xfffffeff
  18:	030b130e 	movweq	r1, #45838	; 0xb30e
  1c:	110e1b0e 	tstne	lr, lr, lsl #22
  20:	10061201 	andne	r1, r6, r1, lsl #4
  24:	02000017 	andeq	r0, r0, #23
  28:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
  2c:	0b3b0b3a 	bleq	ec2d1c <__bss_end+0xeb9d10>
  30:	13490b39 	movtne	r0, #39737	; 0x9b39
  34:	193c193f 	ldmdbne	ip!, {r0, r1, r2, r3, r4, r5, r8, fp, ip}
  38:	24030000 	strcs	r0, [r3], #-0
  3c:	3e0b0b00 	vmlacc.f64	d0, d11, d0
  40:	000e030b 	andeq	r0, lr, fp, lsl #6
  44:	012e0400 			; <UNDEFINED> instruction: 0x012e0400
  48:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
  4c:	0b3b0b3a 	bleq	ec2d3c <__bss_end+0xeb9d30>
  50:	01110b39 	tsteq	r1, r9, lsr fp
  54:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
  58:	01194296 			; <UNDEFINED> instruction: 0x01194296
  5c:	05000013 	streq	r0, [r0, #-19]	; 0xffffffed
  60:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
  64:	0b3b0b3a 	bleq	ec2d54 <__bss_end+0xeb9d48>
  68:	13490b39 	movtne	r0, #39737	; 0x9b39
  6c:	00001802 	andeq	r1, r0, r2, lsl #16
  70:	0b002406 	bleq	9090 <__bss_end+0x84>
  74:	030b3e0b 	movweq	r3, #48651	; 0xbe0b
  78:	07000008 	streq	r0, [r0, -r8]
  7c:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
  80:	0b3a0e03 	bleq	e83894 <__bss_end+0xe7a888>
  84:	0b390b3b 	bleq	e42d78 <__bss_end+0xe39d6c>
  88:	06120111 			; <UNDEFINED> instruction: 0x06120111
  8c:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
  90:	00130119 	andseq	r0, r3, r9, lsl r1
  94:	010b0800 	tsteq	fp, r0, lsl #16
  98:	06120111 			; <UNDEFINED> instruction: 0x06120111
  9c:	34090000 	strcc	r0, [r9], #-0
  a0:	3a080300 	bcc	200ca8 <__bss_end+0x1f7c9c>
  a4:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
  a8:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
  ac:	0a000018 	beq	114 <shift+0x114>
  b0:	0b0b000f 	bleq	2c00f4 <__bss_end+0x2b70e8>
  b4:	00001349 	andeq	r1, r0, r9, asr #6
  b8:	01110100 	tsteq	r1, r0, lsl #2
  bc:	0b130e25 	bleq	4c3958 <__bss_end+0x4ba94c>
  c0:	0e1b0e03 	cdpeq	14, 1, cr0, cr11, cr3, {0}
  c4:	06120111 			; <UNDEFINED> instruction: 0x06120111
  c8:	00001710 	andeq	r1, r0, r0, lsl r7
  cc:	03001602 	movweq	r1, #1538	; 0x602
  d0:	3b0b3a0e 	blcc	2ce910 <__bss_end+0x2c5904>
  d4:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
  d8:	03000013 	movweq	r0, #19
  dc:	0b0b000f 	bleq	2c0120 <__bss_end+0x2b7114>
  e0:	00001349 	andeq	r1, r0, r9, asr #6
  e4:	00001504 	andeq	r1, r0, r4, lsl #10
  e8:	01010500 	tsteq	r1, r0, lsl #10
  ec:	13011349 	movwne	r1, #4937	; 0x1349
  f0:	21060000 	mrscs	r0, (UNDEF: 6)
  f4:	2f134900 	svccs	0x00134900
  f8:	07000006 	streq	r0, [r0, -r6]
  fc:	0b0b0024 	bleq	2c0194 <__bss_end+0x2b7188>
 100:	0e030b3e 	vmoveq.16	d3[0], r0
 104:	34080000 	strcc	r0, [r8], #-0
 108:	3a0e0300 	bcc	380d10 <__bss_end+0x377d04>
 10c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 110:	3f13490b 	svccc	0x0013490b
 114:	00193c19 	andseq	r3, r9, r9, lsl ip
 118:	012e0900 			; <UNDEFINED> instruction: 0x012e0900
 11c:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 120:	0b3b0b3a 	bleq	ec2e10 <__bss_end+0xeb9e04>
 124:	13490b39 	movtne	r0, #39737	; 0x9b39
 128:	06120111 			; <UNDEFINED> instruction: 0x06120111
 12c:	42961840 	addsmi	r1, r6, #64, 16	; 0x400000
 130:	00130119 	andseq	r0, r3, r9, lsl r1
 134:	00340a00 	eorseq	r0, r4, r0, lsl #20
 138:	0b3a0e03 	bleq	e8394c <__bss_end+0xe7a940>
 13c:	0b390b3b 	bleq	e42e30 <__bss_end+0xe39e24>
 140:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 144:	240b0000 	strcs	r0, [fp], #-0
 148:	3e0b0b00 	vmlacc.f64	d0, d11, d0
 14c:	0008030b 	andeq	r0, r8, fp, lsl #6
 150:	002e0c00 	eoreq	r0, lr, r0, lsl #24
 154:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 158:	0b3b0b3a 	bleq	ec2e48 <__bss_end+0xeb9e3c>
 15c:	01110b39 	tsteq	r1, r9, lsr fp
 160:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 164:	00194297 	mulseq	r9, r7, r2
 168:	01390d00 	teqeq	r9, r0, lsl #26
 16c:	0b3a0e03 	bleq	e83980 <__bss_end+0xe7a974>
 170:	13010b3b 	movwne	r0, #6971	; 0x1b3b
 174:	2e0e0000 	cdpcs	0, 0, cr0, cr14, cr0, {0}
 178:	03193f01 	tsteq	r9, #1, 30
 17c:	3b0b3a0e 	blcc	2ce9bc <__bss_end+0x2c59b0>
 180:	3c0b390b 			; <UNDEFINED> instruction: 0x3c0b390b
 184:	00130119 	andseq	r0, r3, r9, lsl r1
 188:	00050f00 	andeq	r0, r5, r0, lsl #30
 18c:	00001349 	andeq	r1, r0, r9, asr #6
 190:	3f012e10 	svccc	0x00012e10
 194:	3a0e0319 	bcc	380e00 <__bss_end+0x377df4>
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
 1c0:	3a080300 	bcc	200dc8 <__bss_end+0x1f7dbc>
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
 1f4:	0b0b0024 	bleq	2c028c <__bss_end+0x2b7280>
 1f8:	0e030b3e 	vmoveq.16	d3[0], r0
 1fc:	26030000 	strcs	r0, [r3], -r0
 200:	00134900 	andseq	r4, r3, r0, lsl #18
 204:	00240400 	eoreq	r0, r4, r0, lsl #8
 208:	0b3e0b0b 	bleq	f82e3c <__bss_end+0xf79e30>
 20c:	00000803 	andeq	r0, r0, r3, lsl #16
 210:	03001605 	movweq	r1, #1541	; 0x605
 214:	3b0b3a0e 	blcc	2cea54 <__bss_end+0x2c5a48>
 218:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 21c:	06000013 			; <UNDEFINED> instruction: 0x06000013
 220:	0e030113 	mcreq	1, 0, r0, cr3, cr3, {0}
 224:	0b3a0b0b 	bleq	e82e58 <__bss_end+0xe79e4c>
 228:	0b390b3b 	bleq	e42f1c <__bss_end+0xe39f10>
 22c:	00001301 	andeq	r1, r0, r1, lsl #6
 230:	03000d07 	movweq	r0, #3335	; 0xd07
 234:	3b0b3a08 	blcc	2cea5c <__bss_end+0x2c5a50>
 238:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 23c:	000b3813 	andeq	r3, fp, r3, lsl r8
 240:	01040800 	tsteq	r4, r0, lsl #16
 244:	196d0e03 	stmdbne	sp!, {r0, r1, r9, sl, fp}^
 248:	0b0b0b3e 	bleq	2c2f48 <__bss_end+0x2b9f3c>
 24c:	0b3a1349 	bleq	e84f78 <__bss_end+0xe7bf6c>
 250:	0b390b3b 	bleq	e42f44 <__bss_end+0xe39f38>
 254:	00001301 	andeq	r1, r0, r1, lsl #6
 258:	03002809 	movweq	r2, #2057	; 0x809
 25c:	000b1c0e 	andeq	r1, fp, lr, lsl #24
 260:	00340a00 	eorseq	r0, r4, r0, lsl #20
 264:	0b3a0e03 	bleq	e83a78 <__bss_end+0xe7aa6c>
 268:	0b390b3b 	bleq	e42f5c <__bss_end+0xe39f50>
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
 294:	0b3b0b3a 	bleq	ec2f84 <__bss_end+0xeb9f78>
 298:	13490b39 	movtne	r0, #39737	; 0x9b39
 29c:	00000b38 	andeq	r0, r0, r8, lsr fp
 2a0:	4901010f 	stmdbmi	r1, {r0, r1, r2, r3, r8}
 2a4:	00130113 	andseq	r0, r3, r3, lsl r1
 2a8:	00211000 	eoreq	r1, r1, r0
 2ac:	0b2f1349 	bleq	bc4fd8 <__bss_end+0xbbbfcc>
 2b0:	02110000 	andseq	r0, r1, #0
 2b4:	0b0e0301 	bleq	380ec0 <__bss_end+0x377eb4>
 2b8:	3b0b3a0b 	blcc	2ceaec <__bss_end+0x2c5ae0>
 2bc:	010b390b 	tsteq	fp, fp, lsl #18
 2c0:	12000013 	andne	r0, r0, #19
 2c4:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 2c8:	0b3a0e03 	bleq	e83adc <__bss_end+0xe7aad0>
 2cc:	0b390b3b 	bleq	e42fc0 <__bss_end+0xe39fb4>
 2d0:	193c0e6e 	ldmdbne	ip!, {r1, r2, r3, r5, r6, r9, sl, fp}
 2d4:	13011364 	movwne	r1, #4964	; 0x1364
 2d8:	05130000 	ldreq	r0, [r3, #-0]
 2dc:	34134900 	ldrcc	r4, [r3], #-2304	; 0xfffff700
 2e0:	14000019 	strne	r0, [r0], #-25	; 0xffffffe7
 2e4:	13490005 	movtne	r0, #36869	; 0x9005
 2e8:	2e150000 	cdpcs	0, 1, cr0, cr5, cr0, {0}
 2ec:	03193f01 	tsteq	r9, #1, 30
 2f0:	3b0b3a0e 	blcc	2ceb30 <__bss_end+0x2c5b24>
 2f4:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 2f8:	3c13490e 			; <UNDEFINED> instruction: 0x3c13490e
 2fc:	01136419 	tsteq	r3, r9, lsl r4
 300:	16000013 			; <UNDEFINED> instruction: 0x16000013
 304:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 308:	0b3a0e03 	bleq	e83b1c <__bss_end+0xe7ab10>
 30c:	0b390b3b 	bleq	e43000 <__bss_end+0xe39ff4>
 310:	13490e6e 	movtne	r0, #40558	; 0x9e6e
 314:	193c0b32 	ldmdbne	ip!, {r1, r4, r5, r8, r9, fp}
 318:	13011364 	movwne	r1, #4964	; 0x1364
 31c:	0d170000 	ldceq	0, cr0, [r7, #-0]
 320:	3a0e0300 	bcc	380f28 <__bss_end+0x377f1c>
 324:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 328:	3813490b 	ldmdacc	r3, {r0, r1, r3, r8, fp, lr}
 32c:	000b320b 	andeq	r3, fp, fp, lsl #4
 330:	012e1800 			; <UNDEFINED> instruction: 0x012e1800
 334:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 338:	0b3b0b3a 	bleq	ec3028 <__bss_end+0xeba01c>
 33c:	0e6e0b39 	vmoveq.8	d14[5], r0
 340:	193c0b32 	ldmdbne	ip!, {r1, r4, r5, r8, r9, fp}
 344:	13011364 	movwne	r1, #4964	; 0x1364
 348:	2e190000 	cdpcs	0, 1, cr0, cr9, cr0, {0}
 34c:	03193f01 	tsteq	r9, #1, 30
 350:	3b0b3a0e 	blcc	2ceb90 <__bss_end+0x2c5b84>
 354:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 358:	3213490e 	andscc	r4, r3, #229376	; 0x38000
 35c:	64193c0b 	ldrvs	r3, [r9], #-3083	; 0xfffff3f5
 360:	1a000013 	bne	3b4 <shift+0x3b4>
 364:	13490115 	movtne	r0, #37141	; 0x9115
 368:	13011364 	movwne	r1, #4964	; 0x1364
 36c:	1f1b0000 	svcne	0x001b0000
 370:	49131d00 	ldmdbmi	r3, {r8, sl, fp, ip}
 374:	1c000013 	stcne	0, cr0, [r0], {19}
 378:	0b0b0010 	bleq	2c03c0 <__bss_end+0x2b73b4>
 37c:	00001349 	andeq	r1, r0, r9, asr #6
 380:	0b000f1d 	bleq	3ffc <shift+0x3ffc>
 384:	1e00000b 	cdpne	0, 0, cr0, cr0, cr11, {0}
 388:	08030139 	stmdaeq	r3, {r0, r3, r4, r5, r8}
 38c:	0b3b0b3a 	bleq	ec307c <__bss_end+0xeba070>
 390:	13010b39 	movwne	r0, #6969	; 0x1b39
 394:	341f0000 	ldrcc	r0, [pc], #-0	; 39c <shift+0x39c>
 398:	3a0e0300 	bcc	380fa0 <__bss_end+0x377f94>
 39c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 3a0:	3c13490b 			; <UNDEFINED> instruction: 0x3c13490b
 3a4:	6c061c19 	stcvs	12, cr1, [r6], {25}
 3a8:	20000019 	andcs	r0, r0, r9, lsl r0
 3ac:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 3b0:	0b3b0b3a 	bleq	ec30a0 <__bss_end+0xeba094>
 3b4:	13490b39 	movtne	r0, #39737	; 0x9b39
 3b8:	0b1c193c 	bleq	7068b0 <__bss_end+0x6fd8a4>
 3bc:	0000196c 	andeq	r1, r0, ip, ror #18
 3c0:	47003421 	strmi	r3, [r0, -r1, lsr #8]
 3c4:	22000013 	andcs	r0, r0, #19
 3c8:	08030034 	stmdaeq	r3, {r2, r4, r5}
 3cc:	0b3b0b3a 	bleq	ec30bc <__bss_end+0xeba0b0>
 3d0:	13490b39 	movtne	r0, #39737	; 0x9b39
 3d4:	1802193f 	stmdane	r2, {r0, r1, r2, r3, r4, r5, r8, fp, ip}
 3d8:	34230000 	strtcc	r0, [r3], #-0
 3dc:	3a0e0300 	bcc	380fe4 <__bss_end+0x377fd8>
 3e0:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 3e4:	3f13490b 	svccc	0x0013490b
 3e8:	00180219 	andseq	r0, r8, r9, lsl r2
 3ec:	012e2400 			; <UNDEFINED> instruction: 0x012e2400
 3f0:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 3f4:	0b3b0b3a 	bleq	ec30e4 <__bss_end+0xeba0d8>
 3f8:	13490b39 	movtne	r0, #39737	; 0x9b39
 3fc:	06120111 			; <UNDEFINED> instruction: 0x06120111
 400:	42961840 	addsmi	r1, r6, #64, 16	; 0x400000
 404:	00130119 	andseq	r0, r3, r9, lsl r1
 408:	00052500 	andeq	r2, r5, r0, lsl #10
 40c:	0b3a0e03 	bleq	e83c20 <__bss_end+0xe7ac14>
 410:	0b390b3b 	bleq	e43104 <__bss_end+0xe3a0f8>
 414:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 418:	34260000 	strtcc	r0, [r6], #-0
 41c:	3a0e0300 	bcc	381024 <__bss_end+0x378018>
 420:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 424:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 428:	27000018 	smladcs	r0, r8, r0, r0
 42c:	193f002e 	ldmdbne	pc!, {r1, r2, r3, r5}	; <UNPREDICTABLE>
 430:	0b3a0e03 	bleq	e83c44 <__bss_end+0xe7ac38>
 434:	0b390b3b 	bleq	e43128 <__bss_end+0xe3a11c>
 438:	01110e6e 	tsteq	r1, lr, ror #28
 43c:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 440:	00194296 	mulseq	r9, r6, r2
 444:	012e2800 			; <UNDEFINED> instruction: 0x012e2800
 448:	0803193f 	stmdaeq	r3, {r0, r1, r2, r3, r4, r5, r8, fp, ip}
 44c:	0b3b0b3a 	bleq	ec313c <__bss_end+0xeba130>
 450:	0e6e0b39 	vmoveq.8	d14[5], r0
 454:	06120111 			; <UNDEFINED> instruction: 0x06120111
 458:	42961840 	addsmi	r1, r6, #64, 16	; 0x400000
 45c:	29000019 	stmdbcs	r0, {r0, r3, r4}
 460:	08030005 	stmdaeq	r3, {r0, r2}
 464:	0b3b0b3a 	bleq	ec3154 <__bss_end+0xeba148>
 468:	13490b39 	movtne	r0, #39737	; 0x9b39
 46c:	00001802 	andeq	r1, r0, r2, lsl #16
 470:	01110100 	tsteq	r1, r0, lsl #2
 474:	0b130e25 	bleq	4c3d10 <__bss_end+0x4bad04>
 478:	0e1b0e03 	cdpeq	14, 1, cr0, cr11, cr3, {0}
 47c:	06120111 			; <UNDEFINED> instruction: 0x06120111
 480:	00001710 	andeq	r1, r0, r0, lsl r7
 484:	0b002402 	bleq	9494 <__bss_end+0x488>
 488:	030b3e0b 	movweq	r3, #48651	; 0xbe0b
 48c:	0300000e 	movweq	r0, #14
 490:	13490026 	movtne	r0, #36902	; 0x9026
 494:	24040000 	strcs	r0, [r4], #-0
 498:	3e0b0b00 	vmlacc.f64	d0, d11, d0
 49c:	0008030b 	andeq	r0, r8, fp, lsl #6
 4a0:	00160500 	andseq	r0, r6, r0, lsl #10
 4a4:	0b3a0e03 	bleq	e83cb8 <__bss_end+0xe7acac>
 4a8:	0b390b3b 	bleq	e4319c <__bss_end+0xe3a190>
 4ac:	00001349 	andeq	r1, r0, r9, asr #6
 4b0:	03011306 	movweq	r1, #4870	; 0x1306
 4b4:	3a0b0b0e 	bcc	2c30f4 <__bss_end+0x2ba0e8>
 4b8:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 4bc:	0013010b 	andseq	r0, r3, fp, lsl #2
 4c0:	000d0700 	andeq	r0, sp, r0, lsl #14
 4c4:	0b3a0803 	bleq	e824d8 <__bss_end+0xe794cc>
 4c8:	0b390b3b 	bleq	e431bc <__bss_end+0xe3a1b0>
 4cc:	0b381349 	bleq	e051f8 <__bss_end+0xdfc1ec>
 4d0:	04080000 	streq	r0, [r8], #-0
 4d4:	6d0e0301 	stcvs	3, cr0, [lr, #-4]
 4d8:	0b0b3e19 	bleq	2cfd44 <__bss_end+0x2c6d38>
 4dc:	3a13490b 	bcc	4d2910 <__bss_end+0x4c9904>
 4e0:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 4e4:	0013010b 	andseq	r0, r3, fp, lsl #2
 4e8:	00280900 	eoreq	r0, r8, r0, lsl #18
 4ec:	0b1c0803 	bleq	702500 <__bss_end+0x6f94f4>
 4f0:	280a0000 	stmdacs	sl, {}	; <UNPREDICTABLE>
 4f4:	1c0e0300 	stcne	3, cr0, [lr], {-0}
 4f8:	0b00000b 	bleq	52c <shift+0x52c>
 4fc:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 500:	0b3b0b3a 	bleq	ec31f0 <__bss_end+0xeba1e4>
 504:	13490b39 	movtne	r0, #39737	; 0x9b39
 508:	1802196c 	stmdane	r2, {r2, r3, r5, r6, r8, fp, ip}
 50c:	020c0000 	andeq	r0, ip, #0
 510:	3c0e0300 	stccc	3, cr0, [lr], {-0}
 514:	0d000019 	stceq	0, cr0, [r0, #-100]	; 0xffffff9c
 518:	0b0b000f 	bleq	2c055c <__bss_end+0x2b7550>
 51c:	00001349 	andeq	r1, r0, r9, asr #6
 520:	03000d0e 	movweq	r0, #3342	; 0xd0e
 524:	3b0b3a0e 	blcc	2ced64 <__bss_end+0x2c5d58>
 528:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 52c:	000b3813 	andeq	r3, fp, r3, lsl r8
 530:	01010f00 	tsteq	r1, r0, lsl #30
 534:	13011349 	movwne	r1, #4937	; 0x1349
 538:	21100000 	tstcs	r0, r0
 53c:	2f134900 	svccs	0x00134900
 540:	1100000b 	tstne	r0, fp
 544:	0e030102 	adfeqs	f0, f3, f2
 548:	0b3a0b0b 	bleq	e8317c <__bss_end+0xe7a170>
 54c:	0b390b3b 	bleq	e43240 <__bss_end+0xe3a234>
 550:	00001301 	andeq	r1, r0, r1, lsl #6
 554:	3f012e12 	svccc	0x00012e12
 558:	3a0e0319 	bcc	3811c4 <__bss_end+0x3781b8>
 55c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 560:	3c0e6e0b 	stccc	14, cr6, [lr], {11}
 564:	01136419 	tsteq	r3, r9, lsl r4
 568:	13000013 	movwne	r0, #19
 56c:	13490005 	movtne	r0, #36869	; 0x9005
 570:	00001934 	andeq	r1, r0, r4, lsr r9
 574:	49000514 	stmdbmi	r0, {r2, r4, r8, sl}
 578:	15000013 	strne	r0, [r0, #-19]	; 0xffffffed
 57c:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 580:	0b3a0e03 	bleq	e83d94 <__bss_end+0xe7ad88>
 584:	0b390b3b 	bleq	e43278 <__bss_end+0xe3a26c>
 588:	13490e6e 	movtne	r0, #40558	; 0x9e6e
 58c:	1364193c 	cmnne	r4, #60, 18	; 0xf0000
 590:	00001301 	andeq	r1, r0, r1, lsl #6
 594:	3f012e16 	svccc	0x00012e16
 598:	3a0e0319 	bcc	381204 <__bss_end+0x3781f8>
 59c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 5a0:	490e6e0b 	stmdbmi	lr, {r0, r1, r3, r9, sl, fp, sp, lr}
 5a4:	3c0b3213 	sfmcc	f3, 4, [fp], {19}
 5a8:	01136419 	tsteq	r3, r9, lsl r4
 5ac:	17000013 	smladne	r0, r3, r0, r0
 5b0:	0e03000d 	cdpeq	0, 0, cr0, cr3, cr13, {0}
 5b4:	0b3b0b3a 	bleq	ec32a4 <__bss_end+0xeba298>
 5b8:	13490b39 	movtne	r0, #39737	; 0x9b39
 5bc:	0b320b38 	bleq	c832a4 <__bss_end+0xc7a298>
 5c0:	2e180000 	cdpcs	0, 1, cr0, cr8, cr0, {0}
 5c4:	03193f01 	tsteq	r9, #1, 30
 5c8:	3b0b3a0e 	blcc	2cee08 <__bss_end+0x2c5dfc>
 5cc:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 5d0:	3c0b320e 	sfmcc	f3, 4, [fp], {14}
 5d4:	01136419 	tsteq	r3, r9, lsl r4
 5d8:	19000013 	stmdbne	r0, {r0, r1, r4}
 5dc:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 5e0:	0b3a0e03 	bleq	e83df4 <__bss_end+0xe7ade8>
 5e4:	0b390b3b 	bleq	e432d8 <__bss_end+0xe3a2cc>
 5e8:	13490e6e 	movtne	r0, #40558	; 0x9e6e
 5ec:	193c0b32 	ldmdbne	ip!, {r1, r4, r5, r8, r9, fp}
 5f0:	00001364 	andeq	r1, r0, r4, ror #6
 5f4:	4901151a 	stmdbmi	r1, {r1, r3, r4, r8, sl, ip}
 5f8:	01136413 	tsteq	r3, r3, lsl r4
 5fc:	1b000013 	blne	650 <shift+0x650>
 600:	131d001f 	tstne	sp, #31
 604:	00001349 	andeq	r1, r0, r9, asr #6
 608:	0b00101c 	bleq	4680 <shift+0x4680>
 60c:	0013490b 	andseq	r4, r3, fp, lsl #18
 610:	000f1d00 	andeq	r1, pc, r0, lsl #26
 614:	00000b0b 	andeq	r0, r0, fp, lsl #22
 618:	0300341e 	movweq	r3, #1054	; 0x41e
 61c:	3b0b3a0e 	blcc	2cee5c <__bss_end+0x2c5e50>
 620:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 624:	00180213 	andseq	r0, r8, r3, lsl r2
 628:	012e1f00 			; <UNDEFINED> instruction: 0x012e1f00
 62c:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 630:	0b3b0b3a 	bleq	ec3320 <__bss_end+0xeba314>
 634:	0e6e0b39 	vmoveq.8	d14[5], r0
 638:	01111349 	tsteq	r1, r9, asr #6
 63c:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 640:	01194296 			; <UNDEFINED> instruction: 0x01194296
 644:	20000013 	andcs	r0, r0, r3, lsl r0
 648:	0e030005 	cdpeq	0, 0, cr0, cr3, cr5, {0}
 64c:	0b3b0b3a 	bleq	ec333c <__bss_end+0xeba330>
 650:	13490b39 	movtne	r0, #39737	; 0x9b39
 654:	00001802 	andeq	r1, r0, r2, lsl #16
 658:	3f012e21 	svccc	0x00012e21
 65c:	3a0e0319 	bcc	3812c8 <__bss_end+0x3782bc>
 660:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 664:	490e6e0b 	stmdbmi	lr, {r0, r1, r3, r9, sl, fp, sp, lr}
 668:	12011113 	andne	r1, r1, #-1073741820	; 0xc0000004
 66c:	97184006 	ldrls	r4, [r8, -r6]
 670:	13011942 	movwne	r1, #6466	; 0x1942
 674:	34220000 	strtcc	r0, [r2], #-0
 678:	3a080300 	bcc	201280 <__bss_end+0x1f8274>
 67c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 680:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 684:	23000018 	movwcs	r0, #24
 688:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 68c:	0b3a0e03 	bleq	e83ea0 <__bss_end+0xe7ae94>
 690:	0b390b3b 	bleq	e43384 <__bss_end+0xe3a378>
 694:	01110e6e 	tsteq	r1, lr, ror #28
 698:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 69c:	01194297 			; <UNDEFINED> instruction: 0x01194297
 6a0:	24000013 	strcs	r0, [r0], #-19	; 0xffffffed
 6a4:	193f002e 	ldmdbne	pc!, {r1, r2, r3, r5}	; <UNPREDICTABLE>
 6a8:	0b3a0e03 	bleq	e83ebc <__bss_end+0xe7aeb0>
 6ac:	0b390b3b 	bleq	e433a0 <__bss_end+0xe3a394>
 6b0:	01110e6e 	tsteq	r1, lr, ror #28
 6b4:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 6b8:	00194297 	mulseq	r9, r7, r2
 6bc:	012e2500 			; <UNDEFINED> instruction: 0x012e2500
 6c0:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 6c4:	0b3b0b3a 	bleq	ec33b4 <__bss_end+0xeba3a8>
 6c8:	0e6e0b39 	vmoveq.8	d14[5], r0
 6cc:	01111349 	tsteq	r1, r9, asr #6
 6d0:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 6d4:	00194297 	mulseq	r9, r7, r2
 6d8:	11010000 	mrsne	r0, (UNDEF: 1)
 6dc:	130e2501 	movwne	r2, #58625	; 0xe501
 6e0:	1b0e030b 	blne	381314 <__bss_end+0x378308>
 6e4:	1201110e 	andne	r1, r1, #-2147483645	; 0x80000003
 6e8:	00171006 	andseq	r1, r7, r6
 6ec:	01390200 	teqeq	r9, r0, lsl #4
 6f0:	00001301 	andeq	r1, r0, r1, lsl #6
 6f4:	03003403 	movweq	r3, #1027	; 0x403
 6f8:	3b0b3a0e 	blcc	2cef38 <__bss_end+0x2c5f2c>
 6fc:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 700:	1c193c13 	ldcne	12, cr3, [r9], {19}
 704:	0400000a 	streq	r0, [r0], #-10
 708:	0b3a003a 	bleq	e807f8 <__bss_end+0xe777ec>
 70c:	0b390b3b 	bleq	e43400 <__bss_end+0xe3a3f4>
 710:	00001318 	andeq	r1, r0, r8, lsl r3
 714:	49010105 	stmdbmi	r1, {r0, r2, r8}
 718:	00130113 	andseq	r0, r3, r3, lsl r1
 71c:	00210600 	eoreq	r0, r1, r0, lsl #12
 720:	0b2f1349 	bleq	bc544c <__bss_end+0xbbc440>
 724:	26070000 	strcs	r0, [r7], -r0
 728:	00134900 	andseq	r4, r3, r0, lsl #18
 72c:	00240800 	eoreq	r0, r4, r0, lsl #16
 730:	0b3e0b0b 	bleq	f83364 <__bss_end+0xf7a358>
 734:	00000e03 	andeq	r0, r0, r3, lsl #28
 738:	47003409 	strmi	r3, [r0, -r9, lsl #8]
 73c:	0a000013 	beq	790 <shift+0x790>
 740:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 744:	0b3a0e03 	bleq	e83f58 <__bss_end+0xe7af4c>
 748:	0b390b3b 	bleq	e4343c <__bss_end+0xe3a430>
 74c:	01110e6e 	tsteq	r1, lr, ror #28
 750:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 754:	01194297 			; <UNDEFINED> instruction: 0x01194297
 758:	0b000013 	bleq	7ac <shift+0x7ac>
 75c:	08030005 	stmdaeq	r3, {r0, r2}
 760:	0b3b0b3a 	bleq	ec3450 <__bss_end+0xeba444>
 764:	13490b39 	movtne	r0, #39737	; 0x9b39
 768:	00001802 	andeq	r1, r0, r2, lsl #16
 76c:	0300340c 	movweq	r3, #1036	; 0x40c
 770:	3b0b3a0e 	blcc	2cefb0 <__bss_end+0x2c5fa4>
 774:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 778:	00180213 	andseq	r0, r8, r3, lsl r2
 77c:	010b0d00 	tsteq	fp, r0, lsl #26
 780:	06120111 			; <UNDEFINED> instruction: 0x06120111
 784:	340e0000 	strcc	r0, [lr], #-0
 788:	3a080300 	bcc	201390 <__bss_end+0x1f8384>
 78c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 790:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 794:	0f000018 	svceq	0x00000018
 798:	0b0b000f 	bleq	2c07dc <__bss_end+0x2b77d0>
 79c:	00001349 	andeq	r1, r0, r9, asr #6
 7a0:	00002610 	andeq	r2, r0, r0, lsl r6
 7a4:	000f1100 	andeq	r1, pc, r0, lsl #2
 7a8:	00000b0b 	andeq	r0, r0, fp, lsl #22
 7ac:	0b002412 	bleq	97fc <__bss_end+0x7f0>
 7b0:	030b3e0b 	movweq	r3, #48651	; 0xbe0b
 7b4:	13000008 	movwne	r0, #8
 7b8:	0e030005 	cdpeq	0, 0, cr0, cr3, cr5, {0}
 7bc:	0b3b0b3a 	bleq	ec34ac <__bss_end+0xeba4a0>
 7c0:	13490b39 	movtne	r0, #39737	; 0x9b39
 7c4:	00001802 	andeq	r1, r0, r2, lsl #16
 7c8:	3f012e14 	svccc	0x00012e14
 7cc:	3a0e0319 	bcc	381438 <__bss_end+0x37842c>
 7d0:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 7d4:	490e6e0b 	stmdbmi	lr, {r0, r1, r3, r9, sl, fp, sp, lr}
 7d8:	12011113 	andne	r1, r1, #-1073741820	; 0xc0000004
 7dc:	97184006 	ldrls	r4, [r8, -r6]
 7e0:	13011942 	movwne	r1, #6466	; 0x1942
 7e4:	2e150000 	cdpcs	0, 1, cr0, cr5, cr0, {0}
 7e8:	03193f01 	tsteq	r9, #1, 30
 7ec:	3b0b3a0e 	blcc	2cf02c <__bss_end+0x2c6020>
 7f0:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 7f4:	1201110e 	andne	r1, r1, #-2147483645	; 0x80000003
 7f8:	96184006 	ldrls	r4, [r8], -r6
 7fc:	00001942 	andeq	r1, r0, r2, asr #18
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
  74:	00000154 	andeq	r0, r0, r4, asr r1
	...
  80:	0000001c 	andeq	r0, r0, ip, lsl r0
  84:	0b510002 	bleq	1440094 <__bss_end+0x1437088>
  88:	00040000 	andeq	r0, r4, r0
  8c:	00000000 	andeq	r0, r0, r0
  90:	00008380 	andeq	r8, r0, r0, lsl #7
  94:	0000045c 	andeq	r0, r0, ip, asr r4
	...
  a0:	0000001c 	andeq	r0, r0, ip, lsl r0
  a4:	16740002 	ldrbtne	r0, [r4], -r2
  a8:	00040000 	andeq	r0, r4, r0
  ac:	00000000 	andeq	r0, r0, r0
  b0:	000087dc 	ldrdeq	r8, [r0], -ip
  b4:	000004b8 			; <UNDEFINED> instruction: 0x000004b8
	...

Disassembly of section .debug_str:

00000000 <.debug_str>:
       0:	6573552f 	ldrbvs	r5, [r3, #-1327]!	; 0xfffffad1
       4:	772f7372 			; <UNDEFINED> instruction: 0x772f7372
       8:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
       c:	2f696a72 	svccs	0x00696a72
      10:	6b736544 	blvs	1cd9528 <__bss_end+0x1cd051c>
      14:	2f706f74 	svccs	0x00706f74
      18:	2f564146 	svccs	0x00564146
      1c:	6176614e 	cmnvs	r6, lr, asr #2
      20:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
      24:	4f2f6963 	svcmi	0x002f6963
      28:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
      2c:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
      30:	6b6c6172 	blvs	1b18600 <__bss_end+0x1b0f5f4>
      34:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
      38:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
      3c:	756f732f 	strbvc	r7, [pc, #-815]!	; fffffd15 <__bss_end+0xffff6d09>
      40:	73656372 	cmnvc	r5, #-939524095	; 0xc8000001
      44:	6573752f 	ldrbvs	r7, [r3, #-1327]!	; 0xfffffad1
      48:	61707372 	cmnvs	r0, r2, ror r3
      4c:	632f6563 			; <UNDEFINED> instruction: 0x632f6563
      50:	2e307472 	mrccs	4, 1, r7, cr0, cr2, {3}
      54:	552f0073 	strpl	r0, [pc, #-115]!	; ffffffe9 <__bss_end+0xffff6fdd>
      58:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
      5c:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
      60:	6a726574 	bvs	1c99638 <__bss_end+0x1c9062c>
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
      98:	752f7365 	strvc	r7, [pc, #-869]!	; fffffd3b <__bss_end+0xffff6d2f>
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
     12c:	6a363731 	bvs	d8ddf8 <__bss_end+0xd84dec>
     130:	732d667a 			; <UNDEFINED> instruction: 0x732d667a
     134:	616d2d20 	cmnvs	sp, r0, lsr #26
     138:	2d206d72 	stccs	13, cr6, [r0, #-456]!	; 0xfffffe38
     13c:	6372616d 	cmnvs	r2, #1073741851	; 0x4000001b
     140:	72613d68 	rsbvc	r3, r1, #104, 26	; 0x1a00
     144:	7a36766d 	bvc	d9db00 <__bss_end+0xd94af4>
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
     184:	6a757a61 	bvs	1d5eb10 <__bss_end+0x1d55b04>
     188:	2f696369 	svccs	0x00696369
     18c:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
     190:	73656d65 	cmnvc	r5, #6464	; 0x1940
     194:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
     198:	6b2d616b 	blvs	b5874c <__bss_end+0xb4f740>
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
     1e4:	2b2b4320 	blcs	ad0e6c <__bss_end+0xac7e60>
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
     260:	2b6b7a36 	blcs	1adeb40 <__bss_end+0x1ad5b34>
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
     294:	755f6962 	ldrbvc	r6, [pc, #-2402]	; fffff93a <__bss_end+0xffff692e>
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
     324:	6b736544 	blvs	1cd983c <__bss_end+0x1cd0830>
     328:	2f706f74 	svccs	0x00706f74
     32c:	2f564146 	svccs	0x00564146
     330:	6176614e 	cmnvs	r6, lr, asr #2
     334:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
     338:	4f2f6963 	svcmi	0x002f6963
     33c:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
     340:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
     344:	6b6c6172 	blvs	1b18914 <__bss_end+0x1b0f908>
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
     4b8:	5a00746e 	bpl	1d678 <__bss_end+0x1466c>
     4bc:	69626d6f 	stmdbvs	r2!, {r0, r1, r2, r3, r5, r6, r8, sl, fp, sp, lr}^
     4c0:	6f6c0065 	svcvs	0x006c0065
     4c4:	64665f67 	strbtvs	r5, [r6], #-3943	; 0xfffff099
     4c8:	78656e00 	stmdavc	r5!, {r9, sl, fp, sp, lr}^
     4cc:	75520074 	ldrbvc	r0, [r2, #-116]	; 0xffffff8c
     4d0:	62616e6e 	rsbvs	r6, r1, #1760	; 0x6e0
     4d4:	4900656c 	stmdbmi	r0, {r2, r3, r5, r6, r8, sl, sp, lr}
     4d8:	6c61766e 	stclvs	6, cr7, [r1], #-440	; 0xfffffe48
     4dc:	485f6469 	ldmdami	pc, {r0, r3, r5, r6, sl, sp, lr}^	; <UNPREDICTABLE>
     4e0:	6c646e61 	stclvs	14, cr6, [r4], #-388	; 0xfffffe7c
     4e4:	75520065 	ldrbvc	r0, [r2, #-101]	; 0xffffff9b
     4e8:	6e696e6e 	cdpvs	14, 6, cr6, cr9, cr14, {3}
     4ec:	65440067 	strbvs	r0, [r4, #-103]	; 0xffffff99
     4f0:	696c6461 	stmdbvs	ip!, {r0, r5, r6, sl, sp, lr}^
     4f4:	555f656e 	ldrbpl	r6, [pc, #-1390]	; ffffff8e <__bss_end+0xffff6f82>
     4f8:	6168636e 	cmnvs	r8, lr, ror #6
     4fc:	6465676e 	strbtvs	r6, [r5], #-1902	; 0xfffff892
     500:	74654700 	strbtvc	r4, [r5], #-1792	; 0xfffff900
     504:	7275435f 	rsbsvc	r4, r5, #2080374785	; 0x7c000001
     508:	746e6572 	strbtvc	r6, [lr], #-1394	; 0xfffffa8e
     50c:	6f72505f 	svcvs	0x0072505f
     510:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     514:	49504700 	ldmdbmi	r0, {r8, r9, sl, lr}^
     518:	61425f4f 	cmpvs	r2, pc, asr #30
     51c:	5f006573 	svcpl	0x00006573
     520:	36314e5a 			; <UNDEFINED> instruction: 0x36314e5a
     524:	6f725043 	svcvs	0x00725043
     528:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     52c:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     530:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     534:	72433431 	subvc	r3, r3, #822083584	; 0x31000000
     538:	65746165 	ldrbvs	r6, [r4, #-357]!	; 0xfffffe9b
     53c:	6f72505f 	svcvs	0x0072505f
     540:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     544:	6a685045 	bvs	1a14660 <__bss_end+0x1a0b654>
     548:	32490062 	subcc	r0, r9, #98	; 0x62
     54c:	72545f43 	subsvc	r5, r4, #268	; 0x10c
     550:	61736e61 	cmnvs	r3, r1, ror #28
     554:	6f697463 	svcvs	0x00697463
     558:	614d5f6e 	cmpvs	sp, lr, ror #30
     55c:	69535f78 	ldmdbvs	r3, {r3, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     560:	7000657a 	andvc	r6, r0, sl, ror r5
     564:	00766572 	rsbseq	r6, r6, r2, ror r5
     568:	4b4e5a5f 	blmi	1396eec <__bss_end+0x138dee0>
     56c:	50433631 	subpl	r3, r3, r1, lsr r6
     570:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     574:	4d5f7373 	ldclmi	3, cr7, [pc, #-460]	; 3b0 <shift+0x3b0>
     578:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
     57c:	39317265 	ldmdbcc	r1!, {r0, r2, r5, r6, r9, ip, sp, lr}
     580:	5f746547 	svcpl	0x00746547
     584:	72727543 	rsbsvc	r7, r2, #281018368	; 0x10c00000
     588:	5f746e65 	svcpl	0x00746e65
     58c:	636f7250 	cmnvs	pc, #80, 4
     590:	45737365 	ldrbmi	r7, [r3, #-869]!	; 0xfffffc9b
     594:	65520076 	ldrbvs	r0, [r2, #-118]	; 0xffffff8a
     598:	4f5f6461 	svcmi	0x005f6461
     59c:	00796c6e 	rsbseq	r6, r9, lr, ror #24
     5a0:	5f78614d 	svcpl	0x0078614d
     5a4:	636f7250 	cmnvs	pc, #80, 4
     5a8:	5f737365 	svcpl	0x00737365
     5ac:	6e65704f 	cdpvs	0, 6, cr7, cr5, cr15, {2}
     5b0:	465f6465 	ldrbmi	r6, [pc], -r5, ror #8
     5b4:	73656c69 	cmnvc	r5, #26880	; 0x6900
     5b8:	50435400 	subpl	r5, r3, r0, lsl #8
     5bc:	6f435f55 	svcvs	0x00435f55
     5c0:	7865746e 	stmdavc	r5!, {r1, r2, r3, r5, r6, sl, ip, sp, lr}^
     5c4:	5a5f0074 	bpl	17c079c <__bss_end+0x17b7790>
     5c8:	4336314e 	teqmi	r6, #-2147483629	; 0x80000013
     5cc:	636f7250 	cmnvs	pc, #80, 4
     5d0:	5f737365 	svcpl	0x00737365
     5d4:	616e614d 	cmnvs	lr, sp, asr #2
     5d8:	38726567 	ldmdacc	r2!, {r0, r1, r2, r5, r6, r8, sl, sp, lr}^
     5dc:	65686353 	strbvs	r6, [r8, #-851]!	; 0xfffffcad
     5e0:	656c7564 	strbvs	r7, [ip, #-1380]!	; 0xfffffa9c
     5e4:	4e007645 	cfmadd32mi	mvax2, mvfx7, mvfx0, mvfx5
     5e8:	6669746f 	strbtvs	r7, [r9], -pc, ror #8
     5ec:	6c6c4179 	stfvse	f4, [ip], #-484	; 0xfffffe1c
     5f0:	6f6c4200 	svcvs	0x006c4200
     5f4:	435f6b63 	cmpmi	pc, #101376	; 0x18c00
     5f8:	65727275 	ldrbvs	r7, [r2, #-629]!	; 0xfffffd8b
     5fc:	505f746e 	subspl	r7, pc, lr, ror #8
     600:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     604:	47007373 	smlsdxmi	r0, r3, r3, r7
     608:	505f7465 	subspl	r7, pc, r5, ror #8
     60c:	75004449 	strvc	r4, [r0, #-1097]	; 0xfffffbb7
     610:	33746e69 	cmncc	r4, #1680	; 0x690
     614:	00745f32 	rsbseq	r5, r4, r2, lsr pc
     618:	31435342 	cmpcc	r3, r2, asr #6
     61c:	7361425f 	cmnvc	r1, #-268435451	; 0xf0000005
     620:	61570065 	cmpvs	r7, r5, rrx
     624:	4e007469 	cdpmi	4, 0, cr7, cr0, cr9, {3}
     628:	6b736154 	blvs	1cd8b80 <__bss_end+0x1ccfb74>
     62c:	6174535f 	cmnvs	r4, pc, asr r3
     630:	53006574 	movwpl	r6, #1396	; 0x574
     634:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     638:	5f656c75 	svcpl	0x00656c75
     63c:	00464445 	subeq	r4, r6, r5, asr #8
     640:	636f6c42 	cmnvs	pc, #16896	; 0x4200
     644:	0064656b 	rsbeq	r6, r4, fp, ror #10
     648:	7275436d 	rsbsvc	r4, r5, #-1275068415	; 0xb4000001
     64c:	746e6572 	strbtvc	r6, [lr], #-1394	; 0xfffffa8e
     650:	7361545f 	cmnvc	r1, #1593835520	; 0x5f000000
     654:	6f4e5f6b 	svcvs	0x004e5f6b
     658:	63006564 	movwvs	r6, #1380	; 0x564
     65c:	5f726168 	svcpl	0x00726168
     660:	6b636974 	blvs	18dac38 <__bss_end+0x18d1c2c>
     664:	6c65645f 	cfstrdvs	mvd6, [r5], #-380	; 0xfffffe84
     668:	73007961 	movwvc	r7, #2401	; 0x961
     66c:	7065656c 	rsbvc	r6, r5, ip, ror #10
     670:	6d69745f 	cfstrdvs	mvd7, [r9, #-380]!	; 0xfffffe84
     674:	5f007265 	svcpl	0x00007265
     678:	36314e5a 			; <UNDEFINED> instruction: 0x36314e5a
     67c:	6f725043 	svcvs	0x00725043
     680:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     684:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     688:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     68c:	69775339 	ldmdbvs	r7!, {r0, r3, r4, r5, r8, r9, ip, lr}^
     690:	5f686374 	svcpl	0x00686374
     694:	50456f54 	subpl	r6, r5, r4, asr pc
     698:	50433831 	subpl	r3, r3, r1, lsr r8
     69c:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     6a0:	4c5f7373 	mrrcmi	3, 7, r7, pc, cr3	; <UNPREDICTABLE>
     6a4:	5f747369 	svcpl	0x00747369
     6a8:	65646f4e 	strbvs	r6, [r4, #-3918]!	; 0xfffff0b2
     6ac:	75706300 	ldrbvc	r6, [r0, #-768]!	; 0xfffffd00
     6b0:	6e6f635f 	mcrvs	3, 3, r6, cr15, cr15, {2}
     6b4:	74786574 	ldrbtvc	r6, [r8], #-1396	; 0xfffffa8c
     6b8:	65724300 	ldrbvs	r4, [r2, #-768]!	; 0xfffffd00
     6bc:	5f657461 	svcpl	0x00657461
     6c0:	636f7250 	cmnvs	pc, #80, 4
     6c4:	00737365 	rsbseq	r7, r3, r5, ror #6
     6c8:	6e65704f 	cdpvs	0, 6, cr7, cr5, cr15, {2}
     6cc:	66756200 	ldrbtvs	r6, [r5], -r0, lsl #4
     6d0:	69540066 	ldmdbvs	r4, {r1, r2, r5, r6}^
     6d4:	5f72656d 	svcpl	0x0072656d
     6d8:	65736142 	ldrbvs	r6, [r3, #-322]!	; 0xfffffebe
     6dc:	335a5f00 	cmpcc	sl, #0, 30
     6e0:	50676f6c 	rsbpl	r6, r7, ip, ror #30
     6e4:	2f00634b 	svccs	0x0000634b
     6e8:	72657355 	rsbvc	r7, r5, #1409286145	; 0x54000001
     6ec:	69772f73 	ldmdbvs	r7!, {r0, r1, r4, r5, r6, r8, r9, sl, fp, sp}^
     6f0:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
     6f4:	442f696a 	strtmi	r6, [pc], #-2410	; 6fc <shift+0x6fc>
     6f8:	746b7365 	strbtvc	r7, [fp], #-869	; 0xfffffc9b
     6fc:	462f706f 	strtmi	r7, [pc], -pc, rrx
     700:	4e2f5641 	cfmadda32mi	mvax2, mvax5, mvfx15, mvfx1
     704:	7a617661 	bvc	185e090 <__bss_end+0x1855084>
     708:	63696a75 	cmnvs	r9, #479232	; 0x75000
     70c:	534f2f69 	movtpl	r2, #65385	; 0xff69
     710:	6d65732f 	stclvs	3, cr7, [r5, #-188]!	; 0xffffff44
     714:	72747365 	rsbsvc	r7, r4, #-1811939327	; 0x94000001
     718:	616b6c61 	cmnvs	fp, r1, ror #24
     71c:	76696b2d 	strbtvc	r6, [r9], -sp, lsr #22
     720:	2f736f2d 	svccs	0x00736f2d
     724:	72756f73 	rsbsvc	r6, r5, #460	; 0x1cc
     728:	2f736563 	svccs	0x00736563
     72c:	72657375 	rsbvc	r7, r5, #-738197503	; 0xd4000001
     730:	63617073 	cmnvs	r1, #115	; 0x73
     734:	616d2f65 	cmnvs	sp, r5, ror #30
     738:	72657473 	rsbvc	r7, r5, #1929379840	; 0x73000000
     73c:	7361745f 	cmnvc	r1, #1593835520	; 0x5f000000
     740:	616d2f6b 	cmnvs	sp, fp, ror #30
     744:	632e6e69 			; <UNDEFINED> instruction: 0x632e6e69
     748:	5f007070 	svcpl	0x00007070
     74c:	36314e5a 			; <UNDEFINED> instruction: 0x36314e5a
     750:	6f725043 	svcvs	0x00725043
     754:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     758:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     75c:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     760:	6f4e3431 	svcvs	0x004e3431
     764:	79666974 	stmdbvc	r6!, {r2, r4, r5, r6, r8, fp, sp, lr}^
     768:	6f72505f 	svcvs	0x0072505f
     76c:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     770:	32315045 	eorscc	r5, r1, #69	; 0x45
     774:	73615454 	cmnvc	r1, #84, 8	; 0x54000000
     778:	74535f6b 	ldrbvc	r5, [r3], #-3947	; 0xfffff095
     77c:	74637572 	strbtvc	r7, [r3], #-1394	; 0xfffffa8e
     780:	74654700 	strbtvc	r4, [r5], #-1792	; 0xfffff900
     784:	6863535f 	stmdavs	r3!, {r0, r1, r2, r3, r4, r6, r8, r9, ip, lr}^
     788:	495f6465 	ldmdbmi	pc, {r0, r2, r5, r6, sl, sp, lr}^	; <UNPREDICTABLE>
     78c:	006f666e 	rsbeq	r6, pc, lr, ror #12
     790:	74434f49 	strbvc	r4, [r3], #-3913	; 0xfffff0b7
     794:	6552006c 	ldrbvs	r0, [r2, #-108]	; 0xffffff94
     798:	54006461 	strpl	r6, [r0], #-1121	; 0xfffffb9f
     79c:	696d7265 	stmdbvs	sp!, {r0, r2, r5, r6, r9, ip, sp, lr}^
     7a0:	6574616e 	ldrbvs	r6, [r4, #-366]!	; 0xfffffe92
     7a4:	746f4e00 	strbtvc	r4, [pc], #-3584	; 7ac <shift+0x7ac>
     7a8:	5f796669 	svcpl	0x00796669
     7ac:	636f7250 	cmnvs	pc, #80, 4
     7b0:	00737365 	rsbseq	r7, r3, r5, ror #6
     7b4:	314e5a5f 	cmpcc	lr, pc, asr sl
     7b8:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     7bc:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     7c0:	614d5f73 	hvcvs	54771	; 0xd5f3
     7c4:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     7c8:	45344372 	ldrmi	r4, [r4, #-882]!	; 0xfffffc8e
     7cc:	6f4e0076 	svcvs	0x004e0076
     7d0:	79666974 	stmdbvc	r6!, {r2, r4, r5, r6, r8, fp, sp, lr}^
     7d4:	78614d00 	stmdavc	r1!, {r8, sl, fp, lr}^
     7d8:	68746150 	ldmdavs	r4!, {r4, r6, r8, sp, lr}^
     7dc:	676e654c 	strbvs	r6, [lr, -ip, asr #10]!
     7e0:	4d006874 	stcmi	8, cr6, [r0, #-464]	; 0xfffffe30
     7e4:	53467861 	movtpl	r7, #26721	; 0x6861
     7e8:	76697244 	strbtvc	r7, [r9], -r4, asr #4
     7ec:	614e7265 	cmpvs	lr, r5, ror #4
     7f0:	654c656d 	strbvs	r6, [ip, #-1389]	; 0xfffffa93
     7f4:	6874676e 	ldmdavs	r4!, {r1, r2, r3, r5, r6, r8, r9, sl, sp, lr}^
     7f8:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     7fc:	50433631 	subpl	r3, r3, r1, lsr r6
     800:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     804:	4d5f7373 	ldclmi	3, cr7, [pc, #-460]	; 640 <shift+0x640>
     808:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
     80c:	31317265 	teqcc	r1, r5, ror #4
     810:	65686353 	strbvs	r6, [r8, #-851]!	; 0xfffffcad
     814:	656c7564 	strbvs	r7, [ip, #-1380]!	; 0xfffffa9c
     818:	4552525f 	ldrbmi	r5, [r2, #-607]	; 0xfffffda1
     81c:	474e0076 	smlsldxmi	r0, lr, r6, r0
     820:	535f7465 	cmppl	pc, #1694498816	; 0x65000000
     824:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     828:	666e495f 			; <UNDEFINED> instruction: 0x666e495f
     82c:	79545f6f 	ldmdbvc	r4, {r0, r1, r2, r3, r5, r6, r8, r9, sl, fp, ip, lr}^
     830:	47006570 	smlsdxmi	r0, r0, r5, r6
     834:	5f4f4950 	svcpl	0x004f4950
     838:	5f6e6950 	svcpl	0x006e6950
     83c:	6e756f43 	cdpvs	15, 7, cr6, cr5, cr3, {2}
     840:	61740074 	cmnvs	r4, r4, ror r0
     844:	62006b73 	andvs	r6, r0, #117760	; 0x1cc00
     848:	6b6e696c 	blvs	1b9ae00 <__bss_end+0x1b91df4>
     84c:	6f6f6200 	svcvs	0x006f6200
     850:	5a5f006c 	bpl	17c0a08 <__bss_end+0x17b79fc>
     854:	4336314e 	teqmi	r6, #-2147483629	; 0x80000013
     858:	636f7250 	cmnvs	pc, #80, 4
     85c:	5f737365 	svcpl	0x00737365
     860:	616e614d 	cmnvs	lr, sp, asr #2
     864:	31726567 	cmncc	r2, r7, ror #10
     868:	74654738 	strbtvc	r4, [r5], #-1848	; 0xfffff8c8
     86c:	6863535f 	stmdavs	r3!, {r0, r1, r2, r3, r4, r6, r8, r9, ip, lr}^
     870:	6c756465 	cfldrdvs	mvd6, [r5], #-404	; 0xfffffe6c
     874:	495f7265 	ldmdbmi	pc, {r0, r2, r5, r6, r9, ip, sp, lr}^	; <UNPREDICTABLE>
     878:	456f666e 	strbmi	r6, [pc, #-1646]!	; 212 <shift+0x212>
     87c:	474e3032 	smlaldxmi	r3, lr, r2, r0
     880:	535f7465 	cmppl	pc, #1694498816	; 0x65000000
     884:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     888:	666e495f 			; <UNDEFINED> instruction: 0x666e495f
     88c:	79545f6f 	ldmdbvc	r4, {r0, r1, r2, r3, r5, r6, r8, r9, sl, fp, ip, lr}^
     890:	76506570 			; <UNDEFINED> instruction: 0x76506570
     894:	4e525400 	cdpmi	4, 5, cr5, cr2, cr0, {0}
     898:	61425f47 	cmpvs	r2, r7, asr #30
     89c:	44006573 	strmi	r6, [r0], #-1395	; 0xfffffa8d
     8a0:	75616665 	strbvc	r6, [r1, #-1637]!	; 0xfffff99b
     8a4:	435f746c 	cmpmi	pc, #108, 8	; 0x6c000000
     8a8:	6b636f6c 	blvs	18dc660 <__bss_end+0x18d3654>
     8ac:	7461525f 	strbtvc	r5, [r1], #-607	; 0xfffffda1
     8b0:	506d0065 	rsbpl	r0, sp, r5, rrx
     8b4:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     8b8:	4c5f7373 	mrrcmi	3, 7, r7, pc, cr3	; <UNPREDICTABLE>
     8bc:	5f747369 	svcpl	0x00747369
     8c0:	64616548 	strbtvs	r6, [r1], #-1352	; 0xfffffab8
     8c4:	63536d00 	cmpvs	r3, #0, 26
     8c8:	75646568 	strbvc	r6, [r4, #-1384]!	; 0xfffffa98
     8cc:	465f656c 	ldrbmi	r6, [pc], -ip, ror #10
     8d0:	5f00636e 	svcpl	0x0000636e
     8d4:	36314e5a 			; <UNDEFINED> instruction: 0x36314e5a
     8d8:	6f725043 	svcvs	0x00725043
     8dc:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     8e0:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     8e4:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     8e8:	6c423132 	stfvse	f3, [r2], {50}	; 0x32
     8ec:	5f6b636f 	svcpl	0x006b636f
     8f0:	72727543 	rsbsvc	r7, r2, #281018368	; 0x10c00000
     8f4:	5f746e65 	svcpl	0x00746e65
     8f8:	636f7250 	cmnvs	pc, #80, 4
     8fc:	45737365 	ldrbmi	r7, [r3, #-869]!	; 0xfffffc9b
     900:	6f4c0076 	svcvs	0x004c0076
     904:	555f6b63 	ldrbpl	r6, [pc, #-2915]	; fffffda9 <__bss_end+0xffff6d9d>
     908:	636f6c6e 	cmnvs	pc, #28160	; 0x6e00
     90c:	0064656b 	rsbeq	r6, r4, fp, ror #10
     910:	73614c6d 	cmnvc	r1, #27904	; 0x6d00
     914:	49505f74 	ldmdbmi	r0, {r2, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     918:	77530044 	ldrbvc	r0, [r3, -r4, asr #32]
     91c:	68637469 	stmdavs	r3!, {r0, r3, r5, r6, sl, ip, sp, lr}^
     920:	006f545f 	rsbeq	r5, pc, pc, asr r4	; <UNPREDICTABLE>
     924:	736f6c43 	cmnvc	pc, #17152	; 0x4300
     928:	5a5f0065 	bpl	17c0ac4 <__bss_end+0x17b7ab8>
     92c:	4336314e 	teqmi	r6, #-2147483629	; 0x80000013
     930:	636f7250 	cmnvs	pc, #80, 4
     934:	5f737365 	svcpl	0x00737365
     938:	616e614d 	cmnvs	lr, sp, asr #2
     93c:	31726567 	cmncc	r2, r7, ror #10
     940:	68635332 	stmdavs	r3!, {r1, r4, r5, r8, r9, ip, lr}^
     944:	6c756465 	cfldrdvs	mvd6, [r5], #-404	; 0xfffffe6c
     948:	44455f65 	strbmi	r5, [r5], #-3941	; 0xfffff09b
     94c:	00764546 	rsbseq	r4, r6, r6, asr #10
     950:	30435342 	subcc	r5, r3, r2, asr #6
     954:	7361425f 	cmnvc	r1, #-268435451	; 0xf0000005
     958:	5a5f0065 	bpl	17c0af4 <__bss_end+0x17b7ae8>
     95c:	696c6235 	stmdbvs	ip!, {r0, r2, r4, r5, r9, sp, lr}^
     960:	00766b6e 	rsbseq	r6, r6, lr, ror #22
     964:	63677261 	cmnvs	r7, #268435462	; 0x10000006
     968:	746f6e00 	strbtvc	r6, [pc], #-3584	; 970 <shift+0x970>
     96c:	65696669 	strbvs	r6, [r9, #-1641]!	; 0xfffff997
     970:	65645f64 	strbvs	r5, [r4, #-3940]!	; 0xfffff09c
     974:	696c6461 	stmdbvs	ip!, {r0, r5, r6, sl, sp, lr}^
     978:	6100656e 	tstvs	r0, lr, ror #10
     97c:	00766772 	rsbseq	r6, r6, r2, ror r7
     980:	314e5a5f 	cmpcc	lr, pc, asr sl
     984:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     988:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     98c:	614d5f73 	hvcvs	54771	; 0xd5f3
     990:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     994:	4e343172 	mrcmi	1, 1, r3, cr4, cr2, {3}
     998:	6669746f 	strbtvs	r7, [r9], -pc, ror #8
     99c:	72505f79 	subsvc	r5, r0, #484	; 0x1e4
     9a0:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     9a4:	006a4573 	rsbeq	r4, sl, r3, ror r5
     9a8:	69466f4e 	stmdbvs	r6, {r1, r2, r3, r6, r8, r9, sl, fp, sp, lr}^
     9ac:	7973656c 	ldmdbvc	r3!, {r2, r3, r5, r6, r8, sl, sp, lr}^
     9b0:	6d657473 	cfstrdvs	mvd7, [r5, #-460]!	; 0xfffffe34
     9b4:	76697244 	strbtvc	r7, [r9], -r4, asr #4
     9b8:	44007265 	strmi	r7, [r0], #-613	; 0xfffffd9b
     9bc:	6c646165 	stfvse	f6, [r4], #-404	; 0xfffffe6c
     9c0:	00656e69 	rsbeq	r6, r5, r9, ror #28
     9c4:	726f6873 	rsbvc	r6, pc, #7536640	; 0x730000
     9c8:	6e692074 	mcrvs	0, 3, r2, cr9, cr4, {3}
     9cc:	614d0074 	hvcvs	53252	; 0xd004
     9d0:	6c694678 	stclvs	6, cr4, [r9], #-480	; 0xfffffe20
     9d4:	6d616e65 	stclvs	14, cr6, [r1, #-404]!	; 0xfffffe6c
     9d8:	6e654c65 	cdpvs	12, 6, cr4, cr5, cr5, {3}
     9dc:	00687467 	rsbeq	r7, r8, r7, ror #8
     9e0:	6f725043 	svcvs	0x00725043
     9e4:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     9e8:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     9ec:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     9f0:	62747400 	rsbsvs	r7, r4, #0, 8
     9f4:	4e003072 	mcrmi	0, 0, r3, cr0, cr2, {3}
     9f8:	5f495753 	svcpl	0x00495753
     9fc:	656c6946 	strbvs	r6, [ip, #-2374]!	; 0xfffff6ba
     a00:	74737973 	ldrbtvc	r7, [r3], #-2419	; 0xfffff68d
     a04:	535f6d65 	cmppl	pc, #6464	; 0x1940
     a08:	69767265 	ldmdbvs	r6!, {r0, r2, r5, r6, r9, ip, sp, lr}^
     a0c:	4e006563 	cfsh32mi	mvfx6, mvfx0, #51
     a10:	5f495753 	svcpl	0x00495753
     a14:	636f7250 	cmnvs	pc, #80, 4
     a18:	5f737365 	svcpl	0x00737365
     a1c:	76726553 			; <UNDEFINED> instruction: 0x76726553
     a20:	00656369 	rsbeq	r6, r5, r9, ror #6
     a24:	6e65706f 	cdpvs	0, 6, cr7, cr5, cr15, {3}
     a28:	665f6465 	ldrbvs	r6, [pc], -r5, ror #8
     a2c:	73656c69 	cmnvc	r5, #26880	; 0x6900
     a30:	65695900 	strbvs	r5, [r9, #-2304]!	; 0xfffff700
     a34:	4900646c 	stmdbmi	r0, {r2, r3, r5, r6, sl, sp, lr}
     a38:	6665646e 	strbtvs	r6, [r5], -lr, ror #8
     a3c:	74696e69 	strbtvc	r6, [r9], #-3689	; 0xfffff197
     a40:	65470065 	strbvs	r0, [r7, #-101]	; 0xffffff9b
     a44:	72505f74 	subsvc	r5, r0, #116, 30	; 0x1d0
     a48:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     a4c:	79425f73 	stmdbvc	r2, {r0, r1, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     a50:	4449505f 	strbmi	r5, [r9], #-95	; 0xffffffa1
     a54:	72655000 	rsbvc	r5, r5, #0
     a58:	65687069 	strbvs	r7, [r8, #-105]!	; 0xffffff97
     a5c:	5f6c6172 	svcpl	0x006c6172
     a60:	65736142 	ldrbvs	r6, [r3, #-322]!	; 0xfffffebe
     a64:	6e6f6c00 	cdpvs	12, 6, cr6, cr15, cr0, {0}
     a68:	6e752067 	cdpvs	0, 7, cr2, cr5, cr7, {3}
     a6c:	6e676973 			; <UNDEFINED> instruction: 0x6e676973
     a70:	69206465 	stmdbvs	r0!, {r0, r2, r5, r6, sl, sp, lr}
     a74:	4900746e 	stmdbmi	r0, {r1, r2, r3, r5, r6, sl, ip, sp, lr}
     a78:	6c61766e 	stclvs	6, cr7, [r1], #-440	; 0xfffffe48
     a7c:	505f6469 	subspl	r6, pc, r9, ror #8
     a80:	6d006e69 	stcvs	14, cr6, [r0, #-420]	; 0xfffffe5c
     a84:	65747361 	ldrbvs	r7, [r4, #-865]!	; 0xfffffc9f
     a88:	6f4c0072 	svcvs	0x004c0072
     a8c:	4c5f6b63 	mrrcmi	11, 6, r6, pc, cr3	; <UNPREDICTABLE>
     a90:	656b636f 	strbvs	r6, [fp, #-879]!	; 0xfffffc91
     a94:	5a5f0064 	bpl	17c0c2c <__bss_end+0x17b7c20>
     a98:	4336314e 	teqmi	r6, #-2147483629	; 0x80000013
     a9c:	636f7250 	cmnvs	pc, #80, 4
     aa0:	5f737365 	svcpl	0x00737365
     aa4:	616e614d 	cmnvs	lr, sp, asr #2
     aa8:	31726567 	cmncc	r2, r7, ror #10
     aac:	6e614838 	mcrvs	8, 3, r4, cr1, cr8, {1}
     ab0:	5f656c64 	svcpl	0x00656c64
     ab4:	636f7250 	cmnvs	pc, #80, 4
     ab8:	5f737365 	svcpl	0x00737365
     abc:	45495753 	strbmi	r5, [r9, #-1875]	; 0xfffff8ad
     ac0:	534e3032 	movtpl	r3, #57394	; 0xe032
     ac4:	505f4957 	subspl	r4, pc, r7, asr r9	; <UNPREDICTABLE>
     ac8:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     acc:	535f7373 	cmppl	pc, #-872415231	; 0xcc000001
     ad0:	69767265 	ldmdbvs	r6!, {r0, r2, r5, r6, r9, ip, sp, lr}^
     ad4:	6a6a6563 	bvs	1a9a068 <__bss_end+0x1a9105c>
     ad8:	3131526a 	teqcc	r1, sl, ror #4
     adc:	49575354 	ldmdbmi	r7, {r2, r4, r6, r8, r9, ip, lr}^
     ae0:	7365525f 	cmnvc	r5, #-268435451	; 0xf0000005
     ae4:	00746c75 	rsbseq	r6, r4, r5, ror ip
     ae8:	65686373 	strbvs	r6, [r8, #-883]!	; 0xfffffc8d
     aec:	6f635f64 	svcvs	0x00635f64
     af0:	65746e75 	ldrbvs	r6, [r4, #-3701]!	; 0xfffff18b
     af4:	6e750072 	mrcvs	0, 3, r0, cr5, cr2, {3}
     af8:	6e676973 			; <UNDEFINED> instruction: 0x6e676973
     afc:	63206465 			; <UNDEFINED> instruction: 0x63206465
     b00:	00726168 	rsbseq	r6, r2, r8, ror #2
     b04:	5f433249 	svcpl	0x00433249
     b08:	56414c53 			; <UNDEFINED> instruction: 0x56414c53
     b0c:	61425f45 	cmpvs	r2, r5, asr #30
     b10:	49006573 	stmdbmi	r0, {r0, r1, r4, r5, r6, r8, sl, sp, lr}
     b14:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
     b18:	74707572 	ldrbtvc	r7, [r0], #-1394	; 0xfffffa8e
     b1c:	656c6261 	strbvs	r6, [ip, #-609]!	; 0xfffffd9f
     b20:	656c535f 	strbvs	r5, [ip, #-863]!	; 0xfffffca1
     b24:	53007065 	movwpl	r7, #101	; 0x65
     b28:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     b2c:	5f656c75 	svcpl	0x00656c75
     b30:	41005252 	tstmi	r0, r2, asr r2
     b34:	425f5855 	subsmi	r5, pc, #5570560	; 0x550000
     b38:	00657361 	rsbeq	r7, r5, r1, ror #6
     b3c:	32435342 	subcc	r5, r3, #134217729	; 0x8000001
     b40:	7361425f 	cmnvc	r1, #-268435451	; 0xf0000005
     b44:	74730065 	ldrbtvc	r0, [r3], #-101	; 0xffffff9b
     b48:	00657461 	rsbeq	r7, r5, r1, ror #8
     b4c:	74697257 	strbtvc	r7, [r9], #-599	; 0xfffffda9
     b50:	6e4f5f65 	cdpvs	15, 4, cr5, cr15, cr5, {3}
     b54:	5300796c 	movwpl	r7, #2412	; 0x96c
     b58:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     b5c:	00656c75 	rsbeq	r6, r5, r5, ror ip
     b60:	6b636954 	blvs	18db0b8 <__bss_end+0x18d20ac>
     b64:	756f435f 	strbvc	r4, [pc, #-863]!	; 80d <shift+0x80d>
     b68:	5f00746e 	svcpl	0x0000746e
     b6c:	36314e5a 			; <UNDEFINED> instruction: 0x36314e5a
     b70:	6f725043 	svcvs	0x00725043
     b74:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     b78:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     b7c:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     b80:	6e553831 	mrcvs	8, 2, r3, cr5, cr1, {1}
     b84:	5f70616d 	svcpl	0x0070616d
     b88:	656c6946 	strbvs	r6, [ip, #-2374]!	; 0xfffff6ba
     b8c:	7275435f 	rsbsvc	r4, r5, #2080374785	; 0x7c000001
     b90:	746e6572 	strbtvc	r6, [lr], #-1394	; 0xfffffa8e
     b94:	48006a45 	stmdami	r0, {r0, r2, r6, r9, fp, sp, lr}
     b98:	6c646e61 	stclvs	14, cr6, [r4], #-388	; 0xfffffe7c
     b9c:	69465f65 	stmdbvs	r6, {r0, r2, r5, r6, r8, r9, sl, fp, ip, lr}^
     ba0:	7973656c 	ldmdbvc	r3!, {r2, r3, r5, r6, r8, sl, sp, lr}^
     ba4:	6d657473 	cfstrdvs	mvd7, [r5, #-460]!	; 0xfffffe34
     ba8:	4957535f 	ldmdbmi	r7, {r0, r1, r2, r3, r4, r6, r8, r9, ip, lr}^
     bac:	6f687300 	svcvs	0x00687300
     bb0:	75207472 	strvc	r7, [r0, #-1138]!	; 0xfffffb8e
     bb4:	6769736e 	strbvs	r7, [r9, -lr, ror #6]!
     bb8:	2064656e 	rsbcs	r6, r4, lr, ror #10
     bbc:	00746e69 	rsbseq	r6, r4, r9, ror #28
     bc0:	6e69616d 	powvsez	f6, f1, #5.0
     bc4:	746e4900 	strbtvc	r4, [lr], #-2304	; 0xfffff700
     bc8:	75727265 	ldrbvc	r7, [r2, #-613]!	; 0xfffffd9b
     bcc:	435f7470 	cmpmi	pc, #112, 8	; 0x70000000
     bd0:	72746e6f 	rsbsvc	r6, r4, #1776	; 0x6f0
     bd4:	656c6c6f 	strbvs	r6, [ip, #-3183]!	; 0xfffff391
     bd8:	61425f72 	hvcvs	9714	; 0x25f2
     bdc:	52006573 	andpl	r6, r0, #482344960	; 0x1cc00000
     be0:	5f646165 	svcpl	0x00646165
     be4:	74697257 	strbtvc	r7, [r9], #-599	; 0xfffffda9
     be8:	63410065 	movtvs	r0, #4197	; 0x1065
     bec:	65766974 	ldrbvs	r6, [r6, #-2420]!	; 0xfffff68c
     bf0:	6f72505f 	svcvs	0x0072505f
     bf4:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     bf8:	756f435f 	strbvc	r4, [pc, #-863]!	; 8a1 <shift+0x8a1>
     bfc:	7300746e 	movwvc	r7, #1134	; 0x46e
     c00:	6f626d79 	svcvs	0x00626d79
     c04:	69745f6c 	ldmdbvs	r4!, {r2, r3, r5, r6, r8, r9, sl, fp, ip, lr}^
     c08:	645f6b63 	ldrbvs	r6, [pc], #-2915	; c10 <shift+0xc10>
     c0c:	79616c65 	stmdbvc	r1!, {r0, r2, r5, r6, sl, fp, sp, lr}^
     c10:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     c14:	50433631 	subpl	r3, r3, r1, lsr r6
     c18:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     c1c:	4d5f7373 	ldclmi	3, cr7, [pc, #-460]	; a58 <shift+0xa58>
     c20:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
     c24:	31327265 	teqcc	r2, r5, ror #4
     c28:	646e6148 	strbtvs	r6, [lr], #-328	; 0xfffffeb8
     c2c:	465f656c 	ldrbmi	r6, [pc], -ip, ror #10
     c30:	73656c69 	cmnvc	r5, #26880	; 0x6900
     c34:	65747379 	ldrbvs	r7, [r4, #-889]!	; 0xfffffc87
     c38:	57535f6d 	ldrbpl	r5, [r3, -sp, ror #30]
     c3c:	33324549 	teqcc	r2, #306184192	; 0x12400000
     c40:	4957534e 	ldmdbmi	r7, {r1, r2, r3, r6, r8, r9, ip, lr}^
     c44:	6c69465f 	stclvs	6, cr4, [r9], #-380	; 0xfffffe84
     c48:	73797365 	cmnvc	r9, #-1811939327	; 0x94000001
     c4c:	5f6d6574 	svcpl	0x006d6574
     c50:	76726553 			; <UNDEFINED> instruction: 0x76726553
     c54:	6a656369 	bvs	1959a00 <__bss_end+0x19509f4>
     c58:	31526a6a 	cmpcc	r2, sl, ror #20
     c5c:	57535431 	smmlarpl	r3, r1, r4, r5
     c60:	65525f49 	ldrbvs	r5, [r2, #-3913]	; 0xfffff0b7
     c64:	746c7573 	strbtvc	r7, [ip], #-1395	; 0xfffffa8d
     c68:	73552f00 	cmpvc	r5, #0, 30
     c6c:	2f737265 	svccs	0x00737265
     c70:	746e6977 	strbtvc	r6, [lr], #-2423	; 0xfffff689
     c74:	696a7265 	stmdbvs	sl!, {r0, r2, r5, r6, r9, ip, sp, lr}^
     c78:	7365442f 	cmnvc	r5, #788529152	; 0x2f000000
     c7c:	706f746b 	rsbvc	r7, pc, fp, ror #8
     c80:	5641462f 	strbpl	r4, [r1], -pc, lsr #12
     c84:	76614e2f 	strbtvc	r4, [r1], -pc, lsr #28
     c88:	6a757a61 	bvs	1d5f614 <__bss_end+0x1d56608>
     c8c:	2f696369 	svccs	0x00696369
     c90:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
     c94:	73656d65 	cmnvc	r5, #6464	; 0x1940
     c98:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
     c9c:	6b2d616b 	blvs	b59250 <__bss_end+0xb50244>
     ca0:	6f2d7669 	svcvs	0x002d7669
     ca4:	6f732f73 	svcvs	0x00732f73
     ca8:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
     cac:	75622f73 	strbvc	r2, [r2, #-3955]!	; 0xfffff08d
     cb0:	00646c69 	rsbeq	r6, r4, r9, ror #24
     cb4:	736f6c63 	cmnvc	pc, #25344	; 0x6300
     cb8:	65530065 	ldrbvs	r0, [r3, #-101]	; 0xffffff9b
     cbc:	65525f74 	ldrbvs	r5, [r2, #-3956]	; 0xfffff08c
     cc0:	6974616c 	ldmdbvs	r4!, {r2, r3, r5, r6, r8, sp, lr}^
     cc4:	72006576 	andvc	r6, r0, #494927872	; 0x1d800000
     cc8:	61767465 	cmnvs	r6, r5, ror #8
     ccc:	636e006c 	cmnvs	lr, #108	; 0x6c
     cd0:	70007275 	andvc	r7, r0, r5, ror r2
     cd4:	00657069 	rsbeq	r7, r5, r9, rrx
     cd8:	756e6472 	strbvc	r6, [lr, #-1138]!	; 0xfffffb8e
     cdc:	5a5f006d 	bpl	17c0e98 <__bss_end+0x17b7e8c>
     ce0:	63733131 	cmnvs	r3, #1073741836	; 0x4000000c
     ce4:	5f646568 	svcpl	0x00646568
     ce8:	6c656979 			; <UNDEFINED> instruction: 0x6c656979
     cec:	5f007664 	svcpl	0x00007664
     cf0:	7337315a 	teqvc	r7, #-2147483626	; 0x80000016
     cf4:	745f7465 	ldrbvc	r7, [pc], #-1125	; cfc <shift+0xcfc>
     cf8:	5f6b7361 	svcpl	0x006b7361
     cfc:	64616564 	strbtvs	r6, [r1], #-1380	; 0xfffffa9c
     d00:	656e696c 	strbvs	r6, [lr, #-2412]!	; 0xfffff694
     d04:	6177006a 	cmnvs	r7, sl, rrx
     d08:	5f007469 	svcpl	0x00007469
     d0c:	6f6e365a 	svcvs	0x006e365a
     d10:	79666974 	stmdbvc	r6!, {r2, r4, r5, r6, r8, fp, sp, lr}^
     d14:	46006a6a 	strmi	r6, [r0], -sl, ror #20
     d18:	006c6961 	rsbeq	r6, ip, r1, ror #18
     d1c:	74697865 	strbtvc	r7, [r9], #-2149	; 0xfffff79b
     d20:	65646f63 	strbvs	r6, [r4, #-3939]!	; 0xfffff09d
     d24:	68637300 	stmdavs	r3!, {r8, r9, ip, sp, lr}^
     d28:	795f6465 	ldmdbvc	pc, {r0, r2, r5, r6, sl, sp, lr}^	; <UNPREDICTABLE>
     d2c:	646c6569 	strbtvs	r6, [ip], #-1385	; 0xfffffa97
     d30:	63697400 	cmnvs	r9, #0, 8
     d34:	6f635f6b 	svcvs	0x00635f6b
     d38:	5f746e75 	svcpl	0x00746e75
     d3c:	75716572 	ldrbvc	r6, [r1, #-1394]!	; 0xfffffa8e
     d40:	64657269 	strbtvs	r7, [r5], #-617	; 0xfffffd97
     d44:	325a5f00 	subscc	r5, sl, #0, 30
     d48:	74656734 	strbtvc	r6, [r5], #-1844	; 0xfffff8cc
     d4c:	7463615f 	strbtvc	r6, [r3], #-351	; 0xfffffea1
     d50:	5f657669 	svcpl	0x00657669
     d54:	636f7270 	cmnvs	pc, #112, 4
     d58:	5f737365 	svcpl	0x00737365
     d5c:	6e756f63 	cdpvs	15, 7, cr6, cr5, cr3, {3}
     d60:	50007674 	andpl	r7, r0, r4, ror r6
     d64:	5f657069 	svcpl	0x00657069
     d68:	656c6946 	strbvs	r6, [ip, #-2374]!	; 0xfffff6ba
     d6c:	6572505f 	ldrbvs	r5, [r2, #-95]!	; 0xffffffa1
     d70:	00786966 	rsbseq	r6, r8, r6, ror #18
     d74:	5f746553 	svcpl	0x00746553
     d78:	61726150 	cmnvs	r2, r0, asr r1
     d7c:	5f00736d 	svcpl	0x0000736d
     d80:	6734315a 			; <UNDEFINED> instruction: 0x6734315a
     d84:	745f7465 	ldrbvc	r7, [pc], #-1125	; d8c <shift+0xd8c>
     d88:	5f6b6369 	svcpl	0x006b6369
     d8c:	6e756f63 	cdpvs	15, 7, cr6, cr5, cr3, {3}
     d90:	73007674 	movwvc	r7, #1652	; 0x674
     d94:	7065656c 	rsbvc	r6, r5, ip, ror #10
     d98:	73694400 	cmnvc	r9, #0, 8
     d9c:	656c6261 	strbvs	r6, [ip, #-609]!	; 0xfffffd9f
     da0:	6576455f 	ldrbvs	r4, [r6, #-1375]!	; 0xfffffaa1
     da4:	445f746e 	ldrbmi	r7, [pc], #-1134	; dac <shift+0xdac>
     da8:	63657465 	cmnvs	r5, #1694498816	; 0x65000000
     dac:	6e6f6974 			; <UNDEFINED> instruction: 0x6e6f6974
     db0:	395a5f00 	ldmdbcc	sl, {r8, r9, sl, fp, ip, lr}^
     db4:	6d726574 	cfldr64vs	mvdx6, [r2, #-464]!	; 0xfffffe30
     db8:	74616e69 	strbtvc	r6, [r1], #-3689	; 0xfffff197
     dbc:	6f006965 	svcvs	0x00006965
     dc0:	61726570 	cmnvs	r2, r0, ror r5
     dc4:	6e6f6974 			; <UNDEFINED> instruction: 0x6e6f6974
     dc8:	355a5f00 	ldrbcc	r5, [sl, #-3840]	; 0xfffff100
     dcc:	736f6c63 	cmnvc	pc, #25344	; 0x6300
     dd0:	5f006a65 	svcpl	0x00006a65
     dd4:	6567365a 	strbvs	r3, [r7, #-1626]!	; 0xfffff9a6
     dd8:	64697074 	strbtvs	r7, [r9], #-116	; 0xffffff8c
     ddc:	6e660076 	mcrvs	0, 3, r0, cr6, cr6, {3}
     de0:	00656d61 	rsbeq	r6, r5, r1, ror #26
     de4:	74697277 	strbtvc	r7, [r9], #-631	; 0xfffffd89
     de8:	69740065 	ldmdbvs	r4!, {r0, r2, r5, r6}^
     dec:	00736b63 	rsbseq	r6, r3, r3, ror #22
     df0:	6e65706f 	cdpvs	0, 6, cr7, cr5, cr15, {3}
     df4:	345a5f00 	ldrbcc	r5, [sl], #-3840	; 0xfffff100
     df8:	65706970 	ldrbvs	r6, [r0, #-2416]!	; 0xfffff690
     dfc:	6a634b50 	bvs	18d3b44 <__bss_end+0x18cab38>
     e00:	65444e00 	strbvs	r4, [r4, #-3584]	; 0xfffff200
     e04:	696c6461 	stmdbvs	ip!, {r0, r5, r6, sl, sp, lr}^
     e08:	535f656e 	cmppl	pc, #461373440	; 0x1b800000
     e0c:	65736275 	ldrbvs	r6, [r3, #-629]!	; 0xfffffd8b
     e10:	63697672 	cmnvs	r9, #119537664	; 0x7200000
     e14:	65670065 	strbvs	r0, [r7, #-101]!	; 0xffffff9b
     e18:	69745f74 	ldmdbvs	r4!, {r2, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     e1c:	635f6b63 	cmpvs	pc, #101376	; 0x18c00
     e20:	746e756f 	strbtvc	r7, [lr], #-1391	; 0xfffffa91
     e24:	72617000 	rsbvc	r7, r1, #0
     e28:	5f006d61 	svcpl	0x00006d61
     e2c:	7277355a 	rsbsvc	r3, r7, #377487360	; 0x16800000
     e30:	6a657469 	bvs	195dfdc <__bss_end+0x1954fd0>
     e34:	6a634b50 	bvs	18d3b7c <__bss_end+0x18cab70>
     e38:	74656700 	strbtvc	r6, [r5], #-1792	; 0xfffff900
     e3c:	7361745f 	cmnvc	r1, #1593835520	; 0x5f000000
     e40:	69745f6b 	ldmdbvs	r4!, {r0, r1, r3, r5, r6, r8, r9, sl, fp, ip, lr}^
     e44:	5f736b63 	svcpl	0x00736b63
     e48:	645f6f74 	ldrbvs	r6, [pc], #-3956	; e50 <shift+0xe50>
     e4c:	6c646165 	stfvse	f6, [r4], #-404	; 0xfffffe6c
     e50:	00656e69 	rsbeq	r6, r5, r9, ror #28
     e54:	5f667562 	svcpl	0x00667562
     e58:	657a6973 	ldrbvs	r6, [sl, #-2419]!	; 0xfffff68d
     e5c:	74657300 	strbtvc	r7, [r5], #-768	; 0xfffffd00
     e60:	7361745f 	cmnvc	r1, #1593835520	; 0x5f000000
     e64:	65645f6b 	strbvs	r5, [r4, #-3947]!	; 0xfffff095
     e68:	696c6461 	stmdbvs	ip!, {r0, r5, r6, sl, sp, lr}^
     e6c:	4700656e 	strmi	r6, [r0, -lr, ror #10]
     e70:	505f7465 	subspl	r7, pc, r5, ror #8
     e74:	6d617261 	sfmvs	f7, 2, [r1, #-388]!	; 0xfffffe7c
     e78:	552f0073 	strpl	r0, [pc, #-115]!	; e0d <shift+0xe0d>
     e7c:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
     e80:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
     e84:	6a726574 	bvs	1c9a45c <__bss_end+0x1c91450>
     e88:	65442f69 	strbvs	r2, [r4, #-3945]	; 0xfffff097
     e8c:	6f746b73 	svcvs	0x00746b73
     e90:	41462f70 	hvcmi	25328	; 0x62f0
     e94:	614e2f56 	cmpvs	lr, r6, asr pc
     e98:	757a6176 	ldrbvc	r6, [sl, #-374]!	; 0xfffffe8a
     e9c:	6963696a 	stmdbvs	r3!, {r1, r3, r5, r6, r8, fp, sp, lr}^
     ea0:	2f534f2f 	svccs	0x00534f2f
     ea4:	656d6573 	strbvs	r6, [sp, #-1395]!	; 0xfffffa8d
     ea8:	61727473 	cmnvs	r2, r3, ror r4
     eac:	2d616b6c 	vstmdbcs	r1!, {d22-<overflow reg d75>}
     eb0:	2d76696b 			; <UNDEFINED> instruction: 0x2d76696b
     eb4:	732f736f 			; <UNDEFINED> instruction: 0x732f736f
     eb8:	6372756f 	cmnvs	r2, #465567744	; 0x1bc00000
     ebc:	732f7365 			; <UNDEFINED> instruction: 0x732f7365
     ec0:	696c6474 	stmdbvs	ip!, {r2, r4, r5, r6, sl, sp, lr}^
     ec4:	72732f62 	rsbsvc	r2, r3, #392	; 0x188
     ec8:	74732f63 	ldrbtvc	r2, [r3], #-3939	; 0xfffff09d
     ecc:	6c696664 	stclvs	6, cr6, [r9], #-400	; 0xfffffe70
     ed0:	70632e65 	rsbvc	r2, r3, r5, ror #28
     ed4:	5a5f0070 	bpl	17c109c <__bss_end+0x17b8090>
     ed8:	656c7335 	strbvs	r7, [ip, #-821]!	; 0xfffffccb
     edc:	6a6a7065 	bvs	1a9d078 <__bss_end+0x1a9406c>
     ee0:	6c696600 	stclvs	6, cr6, [r9], #-0
     ee4:	65470065 	strbvs	r0, [r7, #-101]	; 0xffffff9b
     ee8:	65525f74 	ldrbvs	r5, [r2, #-3956]	; 0xfffff08c
     eec:	6e69616d 	powvsez	f6, f1, #5.0
     ef0:	00676e69 	rsbeq	r6, r7, r9, ror #28
     ef4:	62616e45 	rsbvs	r6, r1, #1104	; 0x450
     ef8:	455f656c 	ldrbmi	r6, [pc, #-1388]	; 994 <shift+0x994>
     efc:	746e6576 	strbtvc	r6, [lr], #-1398	; 0xfffffa8a
     f00:	7465445f 	strbtvc	r4, [r5], #-1119	; 0xfffffba1
     f04:	69746365 	ldmdbvs	r4!, {r0, r2, r5, r6, r8, r9, sp, lr}^
     f08:	5f006e6f 	svcpl	0x00006e6f
     f0c:	6736325a 			; <UNDEFINED> instruction: 0x6736325a
     f10:	745f7465 	ldrbvc	r7, [pc], #-1125	; f18 <shift+0xf18>
     f14:	5f6b7361 	svcpl	0x006b7361
     f18:	6b636974 	blvs	18db4f0 <__bss_end+0x18d24e4>
     f1c:	6f745f73 	svcvs	0x00745f73
     f20:	6165645f 	cmnvs	r5, pc, asr r4
     f24:	6e696c64 	cdpvs	12, 6, cr6, cr9, cr4, {3}
     f28:	4e007665 	cfmadd32mi	mvax3, mvfx7, mvfx0, mvfx5
     f2c:	5f495753 	svcpl	0x00495753
     f30:	75736552 	ldrbvc	r6, [r3, #-1362]!	; 0xfffffaae
     f34:	435f746c 	cmpmi	pc, #108, 8	; 0x6c000000
     f38:	0065646f 	rsbeq	r6, r5, pc, ror #8
     f3c:	756e7277 	strbvc	r7, [lr, #-631]!	; 0xfffffd89
     f40:	5a5f006d 	bpl	17c10fc <__bss_end+0x17b80f0>
     f44:	69617734 	stmdbvs	r1!, {r2, r4, r5, r8, r9, sl, ip, sp, lr}^
     f48:	6a6a6a74 	bvs	1a9b920 <__bss_end+0x1a92914>
     f4c:	355a5f00 	ldrbcc	r5, [sl, #-3840]	; 0xfffff100
     f50:	74636f69 	strbtvc	r6, [r3], #-3945	; 0xfffff097
     f54:	36316a6c 	ldrtcc	r6, [r1], -ip, ror #20
     f58:	434f494e 	movtmi	r4, #63822	; 0xf94e
     f5c:	4f5f6c74 	svcmi	0x005f6c74
     f60:	61726570 	cmnvs	r2, r0, ror r5
     f64:	6e6f6974 			; <UNDEFINED> instruction: 0x6e6f6974
     f68:	69007650 	stmdbvs	r0, {r4, r6, r9, sl, ip, sp, lr}
     f6c:	6c74636f 	ldclvs	3, cr6, [r4], #-444	; 0xfffffe44
     f70:	74657200 	strbtvc	r7, [r5], #-512	; 0xfffffe00
     f74:	00746e63 	rsbseq	r6, r4, r3, ror #28
     f78:	69746f6e 	ldmdbvs	r4!, {r1, r2, r3, r5, r6, r8, r9, sl, fp, sp, lr}^
     f7c:	74007966 	strvc	r7, [r0], #-2406	; 0xfffff69a
     f80:	696d7265 	stmdbvs	sp!, {r0, r2, r5, r6, r9, ip, sp, lr}^
     f84:	6574616e 	ldrbvs	r6, [r4, #-366]!	; 0xfffffe92
     f88:	646f6d00 	strbtvs	r6, [pc], #-3328	; f90 <shift+0xf90>
     f8c:	75620065 	strbvc	r0, [r2, #-101]!	; 0xffffff9b
     f90:	72656666 	rsbvc	r6, r5, #106954752	; 0x6600000
     f94:	345a5f00 	ldrbcc	r5, [sl], #-3840	; 0xfffff100
     f98:	64616572 	strbtvs	r6, [r1], #-1394	; 0xfffffa8e
     f9c:	6a63506a 	bvs	18d514c <__bss_end+0x18cc140>
     fa0:	554e4700 	strbpl	r4, [lr, #-1792]	; 0xfffff900
     fa4:	2b2b4320 	blcs	ad1c2c <__bss_end+0xac8c20>
     fa8:	31203431 			; <UNDEFINED> instruction: 0x31203431
     fac:	2e332e30 	mrccs	14, 1, r2, cr3, cr0, {1}
     fb0:	30322031 	eorscc	r2, r2, r1, lsr r0
     fb4:	38303132 	ldmdacc	r0!, {r1, r4, r5, r8, ip, sp}
     fb8:	28203432 	stmdacs	r0!, {r1, r4, r5, sl, ip, sp}
     fbc:	656c6572 	strbvs	r6, [ip, #-1394]!	; 0xfffffa8e
     fc0:	29657361 	stmdbcs	r5!, {r0, r5, r6, r8, r9, ip, sp, lr}^
     fc4:	666d2d20 	strbtvs	r2, [sp], -r0, lsr #26
     fc8:	74616f6c 	strbtvc	r6, [r1], #-3948	; 0xfffff094
     fcc:	6962612d 	stmdbvs	r2!, {r0, r2, r3, r5, r8, sp, lr}^
     fd0:	7261683d 	rsbvc	r6, r1, #3997696	; 0x3d0000
     fd4:	6d2d2064 	stcvs	0, cr2, [sp, #-400]!	; 0xfffffe70
     fd8:	3d757066 	ldclcc	0, cr7, [r5, #-408]!	; 0xfffffe68
     fdc:	20706676 	rsbscs	r6, r0, r6, ror r6
     fe0:	6c666d2d 	stclvs	13, cr6, [r6], #-180	; 0xffffff4c
     fe4:	2d74616f 	ldfcse	f6, [r4, #-444]!	; 0xfffffe44
     fe8:	3d696261 	sfmcc	f6, 2, [r9, #-388]!	; 0xfffffe7c
     fec:	64726168 	ldrbtvs	r6, [r2], #-360	; 0xfffffe98
     ff0:	666d2d20 	strbtvs	r2, [sp], -r0, lsr #26
     ff4:	763d7570 			; <UNDEFINED> instruction: 0x763d7570
     ff8:	2d207066 	stccs	0, cr7, [r0, #-408]!	; 0xfffffe68
     ffc:	6e75746d 	cdpvs	4, 7, cr7, cr5, cr13, {3}
    1000:	72613d65 	rsbvc	r3, r1, #6464	; 0x1940
    1004:	3731316d 	ldrcc	r3, [r1, -sp, ror #2]!
    1008:	667a6a36 			; <UNDEFINED> instruction: 0x667a6a36
    100c:	2d20732d 	stccs	3, cr7, [r0, #-180]!	; 0xffffff4c
    1010:	6d72616d 	ldfvse	f6, [r2, #-436]!	; 0xfffffe4c
    1014:	616d2d20 	cmnvs	sp, r0, lsr #26
    1018:	3d686372 	stclcc	3, cr6, [r8, #-456]!	; 0xfffffe38
    101c:	766d7261 	strbtvc	r7, [sp], -r1, ror #4
    1020:	2b6b7a36 	blcs	1adf900 <__bss_end+0x1ad68f4>
    1024:	2d207066 	stccs	0, cr7, [r0, #-408]!	; 0xfffffe68
    1028:	672d2067 	strvs	r2, [sp, -r7, rrx]!
    102c:	20672d20 	rsbcs	r2, r7, r0, lsr #26
    1030:	20304f2d 	eorscs	r4, r0, sp, lsr #30
    1034:	20304f2d 	eorscs	r4, r0, sp, lsr #30
    1038:	6f6e662d 	svcvs	0x006e662d
    103c:	6378652d 	cmnvs	r8, #188743680	; 0xb400000
    1040:	69747065 	ldmdbvs	r4!, {r0, r2, r5, r6, ip, sp, lr}^
    1044:	20736e6f 	rsbscs	r6, r3, pc, ror #28
    1048:	6f6e662d 	svcvs	0x006e662d
    104c:	7474722d 	ldrbtvc	r7, [r4], #-557	; 0xfffffdd3
    1050:	494e0069 	stmdbmi	lr, {r0, r3, r5, r6}^
    1054:	6c74434f 	ldclvs	3, cr4, [r4], #-316	; 0xfffffec4
    1058:	65704f5f 	ldrbvs	r4, [r0, #-3935]!	; 0xfffff0a1
    105c:	69746172 	ldmdbvs	r4!, {r1, r4, r5, r6, r8, sp, lr}^
    1060:	72006e6f 	andvc	r6, r0, #1776	; 0x6f0
    1064:	6f637465 	svcvs	0x00637465
    1068:	67006564 	strvs	r6, [r0, -r4, ror #10]
    106c:	615f7465 	cmpvs	pc, r5, ror #8
    1070:	76697463 	strbtvc	r7, [r9], -r3, ror #8
    1074:	72705f65 	rsbsvc	r5, r0, #404	; 0x194
    1078:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
    107c:	6f635f73 	svcvs	0x00635f73
    1080:	00746e75 	rsbseq	r6, r4, r5, ror lr
    1084:	656c6966 	strbvs	r6, [ip, #-2406]!	; 0xfffff69a
    1088:	656d616e 	strbvs	r6, [sp, #-366]!	; 0xfffffe92
    108c:	61657200 	cmnvs	r5, r0, lsl #4
    1090:	65670064 	strbvs	r0, [r7, #-100]!	; 0xffffff9c
    1094:	64697074 	strbtvs	r7, [r9], #-116	; 0xffffff8c
    1098:	345a5f00 	ldrbcc	r5, [sl], #-3840	; 0xfffff100
    109c:	6e65706f 	cdpvs	0, 6, cr7, cr5, cr15, {3}
    10a0:	31634b50 	cmncc	r3, r0, asr fp
    10a4:	69464e35 	stmdbvs	r6, {r0, r2, r4, r5, r9, sl, fp, lr}^
    10a8:	4f5f656c 	svcmi	0x005f656c
    10ac:	5f6e6570 	svcpl	0x006e6570
    10b0:	65646f4d 	strbvs	r6, [r4, #-3917]!	; 0xfffff0b3
    10b4:	706e6900 	rsbvc	r6, lr, r0, lsl #18
    10b8:	64007475 	strvs	r7, [r0], #-1141	; 0xfffffb8b
    10bc:	00747365 	rsbseq	r7, r4, r5, ror #6
    10c0:	72657a62 	rsbvc	r7, r5, #401408	; 0x62000
    10c4:	656c006f 	strbvs	r0, [ip, #-111]!	; 0xffffff91
    10c8:	6874676e 	ldmdavs	r4!, {r1, r2, r3, r5, r6, r8, r9, sl, sp, lr}^
    10cc:	355a5f00 	ldrbcc	r5, [sl, #-3840]	; 0xfffff100
    10d0:	72657a62 	rsbvc	r7, r5, #401408	; 0x62000
    10d4:	6976506f 	ldmdbvs	r6!, {r0, r1, r2, r3, r5, r6, ip, lr}^
    10d8:	73552f00 	cmpvc	r5, #0, 30
    10dc:	2f737265 	svccs	0x00737265
    10e0:	746e6977 	strbtvc	r6, [lr], #-2423	; 0xfffff689
    10e4:	696a7265 	stmdbvs	sl!, {r0, r2, r5, r6, r9, ip, sp, lr}^
    10e8:	7365442f 	cmnvc	r5, #788529152	; 0x2f000000
    10ec:	706f746b 	rsbvc	r7, pc, fp, ror #8
    10f0:	5641462f 	strbpl	r4, [r1], -pc, lsr #12
    10f4:	76614e2f 	strbtvc	r4, [r1], -pc, lsr #28
    10f8:	6a757a61 	bvs	1d5fa84 <__bss_end+0x1d56a78>
    10fc:	2f696369 	svccs	0x00696369
    1100:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
    1104:	73656d65 	cmnvc	r5, #6464	; 0x1940
    1108:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
    110c:	6b2d616b 	blvs	b596c0 <__bss_end+0xb506b4>
    1110:	6f2d7669 	svcvs	0x002d7669
    1114:	6f732f73 	svcvs	0x00732f73
    1118:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
    111c:	74732f73 	ldrbtvc	r2, [r3], #-3955	; 0xfffff08d
    1120:	62696c64 	rsbvs	r6, r9, #100, 24	; 0x6400
    1124:	6372732f 	cmnvs	r2, #-1140850688	; 0xbc000000
    1128:	6474732f 	ldrbtvs	r7, [r4], #-815	; 0xfffffcd1
    112c:	69727473 	ldmdbvs	r2!, {r0, r1, r4, r5, r6, sl, ip, sp, lr}^
    1130:	632e676e 			; <UNDEFINED> instruction: 0x632e676e
    1134:	5f007070 	svcpl	0x00007070
    1138:	7461345a 	strbtvc	r3, [r1], #-1114	; 0xfffffba6
    113c:	4b50696f 	blmi	141b700 <__bss_end+0x14126f4>
    1140:	68430063 	stmdavs	r3, {r0, r1, r5, r6}^
    1144:	6f437261 	svcvs	0x00437261
    1148:	7241766e 	subvc	r7, r1, #115343360	; 0x6e00000
    114c:	656d0072 	strbvs	r0, [sp, #-114]!	; 0xffffff8e
    1150:	7473646d 	ldrbtvc	r6, [r3], #-1133	; 0xfffffb93
    1154:	74756f00 	ldrbtvc	r6, [r5], #-3840	; 0xfffff100
    1158:	00747570 	rsbseq	r7, r4, r0, ror r5
    115c:	6d365a5f 	vldmdbvs	r6!, {s10-s104}
    1160:	70636d65 	rsbvc	r6, r3, r5, ror #26
    1164:	764b5079 			; <UNDEFINED> instruction: 0x764b5079
    1168:	00697650 	rsbeq	r7, r9, r0, asr r6
    116c:	65736162 	ldrbvs	r6, [r3, #-354]!	; 0xfffffe9e
    1170:	6d656d00 	stclvs	13, cr6, [r5, #-0]
    1174:	00797063 	rsbseq	r7, r9, r3, rrx
    1178:	6c727473 	cfldrdvs	mvd7, [r2], #-460	; 0xfffffe34
    117c:	5f006e65 	svcpl	0x00006e65
    1180:	7473375a 	ldrbtvc	r3, [r3], #-1882	; 0xfffff8a6
    1184:	6d636e72 	stclvs	14, cr6, [r3, #-456]!	; 0xfffffe38
    1188:	634b5070 	movtvs	r5, #45168	; 0xb070
    118c:	695f3053 	ldmdbvs	pc, {r0, r1, r4, r6, ip, sp}^	; <UNPREDICTABLE>
    1190:	365a5f00 	ldrbcc	r5, [sl], -r0, lsl #30
    1194:	6c727473 	cfldrdvs	mvd7, [r2], #-460	; 0xfffffe34
    1198:	4b506e65 	blmi	141cb34 <__bss_end+0x1413b28>
    119c:	74610063 	strbtvc	r0, [r1], #-99	; 0xffffff9d
    11a0:	5f00696f 	svcpl	0x0000696f
    11a4:	7473375a 	ldrbtvc	r3, [r3], #-1882	; 0xfffff8a6
    11a8:	70636e72 	rsbvc	r6, r3, r2, ror lr
    11ac:	50635079 	rsbpl	r5, r3, r9, ror r0
    11b0:	0069634b 	rsbeq	r6, r9, fp, asr #6
    11b4:	6e727473 	mrcvs	4, 3, r7, cr2, cr3, {3}
    11b8:	00706d63 	rsbseq	r6, r0, r3, ror #26
    11bc:	6e727473 	mrcvs	4, 3, r7, cr2, cr3, {3}
    11c0:	00797063 	rsbseq	r7, r9, r3, rrx
    11c4:	6f6d656d 	svcvs	0x006d656d
    11c8:	6d007972 	vstrvs.16	s14, [r0, #-228]	; 0xffffff1c	; <UNPREDICTABLE>
    11cc:	72736d65 	rsbsvc	r6, r3, #6464	; 0x1940
    11d0:	74690063 	strbtvc	r0, [r9], #-99	; 0xffffff9d
    11d4:	5f00616f 	svcpl	0x0000616f
    11d8:	7469345a 	strbtvc	r3, [r9], #-1114	; 0xfffffba6
    11dc:	506a616f 	rsbpl	r6, sl, pc, ror #2
    11e0:	Address 0x00000000000011e0 is out of bounds.


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
  20:	8b040e42 	blhi	103930 <__bss_end+0xfa924>
  24:	0b0d4201 	bleq	350830 <__bss_end+0x347824>
  28:	420d0d62 	andmi	r0, sp, #6272	; 0x1880
  2c:	00000ecb 	andeq	r0, r0, fp, asr #29
  30:	0000001c 	andeq	r0, r0, ip, lsl r0
  34:	00000000 	andeq	r0, r0, r0
  38:	00008064 	andeq	r8, r0, r4, rrx
  3c:	00000040 	andeq	r0, r0, r0, asr #32
  40:	8b080e42 	blhi	203950 <__bss_end+0x1fa944>
  44:	42018e02 	andmi	r8, r1, #2, 28
  48:	5a040b0c 	bpl	102c80 <__bss_end+0xf9c74>
  4c:	00080d0c 	andeq	r0, r8, ip, lsl #26
  50:	0000000c 	andeq	r0, r0, ip
  54:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
  58:	7c020001 	stcvc	0, cr0, [r2], {1}
  5c:	000d0c0e 	andeq	r0, sp, lr, lsl #24
  60:	0000001c 	andeq	r0, r0, ip, lsl r0
  64:	00000050 	andeq	r0, r0, r0, asr r0
  68:	000080a4 	andeq	r8, r0, r4, lsr #1
  6c:	00000038 	andeq	r0, r0, r8, lsr r0
  70:	8b040e42 	blhi	103980 <__bss_end+0xfa974>
  74:	0b0d4201 	bleq	350880 <__bss_end+0x347874>
  78:	420d0d54 	andmi	r0, sp, #84, 26	; 0x1500
  7c:	00000ecb 	andeq	r0, r0, fp, asr #29
  80:	0000001c 	andeq	r0, r0, ip, lsl r0
  84:	00000050 	andeq	r0, r0, r0, asr r0
  88:	000080dc 	ldrdeq	r8, [r0], -ip
  8c:	0000002c 	andeq	r0, r0, ip, lsr #32
  90:	8b040e42 	blhi	1039a0 <__bss_end+0xfa994>
  94:	0b0d4201 	bleq	3508a0 <__bss_end+0x347894>
  98:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
  9c:	00000ecb 	andeq	r0, r0, fp, asr #29
  a0:	0000001c 	andeq	r0, r0, ip, lsl r0
  a4:	00000050 	andeq	r0, r0, r0, asr r0
  a8:	00008108 	andeq	r8, r0, r8, lsl #2
  ac:	00000020 	andeq	r0, r0, r0, lsr #32
  b0:	8b040e42 	blhi	1039c0 <__bss_end+0xfa9b4>
  b4:	0b0d4201 	bleq	3508c0 <__bss_end+0x3478b4>
  b8:	420d0d48 	andmi	r0, sp, #72, 26	; 0x1200
  bc:	00000ecb 	andeq	r0, r0, fp, asr #29
  c0:	0000001c 	andeq	r0, r0, ip, lsl r0
  c4:	00000050 	andeq	r0, r0, r0, asr r0
  c8:	00008128 	andeq	r8, r0, r8, lsr #2
  cc:	00000018 	andeq	r0, r0, r8, lsl r0
  d0:	8b040e42 	blhi	1039e0 <__bss_end+0xfa9d4>
  d4:	0b0d4201 	bleq	3508e0 <__bss_end+0x3478d4>
  d8:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
  dc:	00000ecb 	andeq	r0, r0, fp, asr #29
  e0:	0000001c 	andeq	r0, r0, ip, lsl r0
  e4:	00000050 	andeq	r0, r0, r0, asr r0
  e8:	00008140 	andeq	r8, r0, r0, asr #2
  ec:	00000018 	andeq	r0, r0, r8, lsl r0
  f0:	8b040e42 	blhi	103a00 <__bss_end+0xfa9f4>
  f4:	0b0d4201 	bleq	350900 <__bss_end+0x3478f4>
  f8:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
  fc:	00000ecb 	andeq	r0, r0, fp, asr #29
 100:	0000001c 	andeq	r0, r0, ip, lsl r0
 104:	00000050 	andeq	r0, r0, r0, asr r0
 108:	00008158 	andeq	r8, r0, r8, asr r1
 10c:	00000018 	andeq	r0, r0, r8, lsl r0
 110:	8b040e42 	blhi	103a20 <__bss_end+0xfaa14>
 114:	0b0d4201 	bleq	350920 <__bss_end+0x347914>
 118:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
 11c:	00000ecb 	andeq	r0, r0, fp, asr #29
 120:	00000014 	andeq	r0, r0, r4, lsl r0
 124:	00000050 	andeq	r0, r0, r0, asr r0
 128:	00008170 	andeq	r8, r0, r0, ror r1
 12c:	0000000c 	andeq	r0, r0, ip
 130:	8b040e42 	blhi	103a40 <__bss_end+0xfaa34>
 134:	0b0d4201 	bleq	350940 <__bss_end+0x347934>
 138:	0000001c 	andeq	r0, r0, ip, lsl r0
 13c:	00000050 	andeq	r0, r0, r0, asr r0
 140:	0000817c 	andeq	r8, r0, ip, ror r1
 144:	00000058 	andeq	r0, r0, r8, asr r0
 148:	8b080e42 	blhi	203a58 <__bss_end+0x1faa4c>
 14c:	42018e02 	andmi	r8, r1, #2, 28
 150:	62040b0c 	andvs	r0, r4, #12, 22	; 0x3000
 154:	00080d0c 	andeq	r0, r8, ip, lsl #26
 158:	0000001c 	andeq	r0, r0, ip, lsl r0
 15c:	00000050 	andeq	r0, r0, r0, asr r0
 160:	000081d4 	ldrdeq	r8, [r0], -r4
 164:	00000058 	andeq	r0, r0, r8, asr r0
 168:	8b080e42 	blhi	203a78 <__bss_end+0x1faa6c>
 16c:	42018e02 	andmi	r8, r1, #2, 28
 170:	62040b0c 	andvs	r0, r4, #12, 22	; 0x3000
 174:	00080d0c 	andeq	r0, r8, ip, lsl #26
 178:	0000000c 	andeq	r0, r0, ip
 17c:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 180:	7c020001 	stcvc	0, cr0, [r2], {1}
 184:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 188:	00000020 	andeq	r0, r0, r0, lsr #32
 18c:	00000178 	andeq	r0, r0, r8, ror r1
 190:	0000822c 	andeq	r8, r0, ip, lsr #4
 194:	00000044 	andeq	r0, r0, r4, asr #32
 198:	840c0e42 	strhi	r0, [ip], #-3650	; 0xfffff1be
 19c:	8e028b03 	vmlahi.f64	d8, d2, d3
 1a0:	0b0c4201 	bleq	3109ac <__bss_end+0x3079a0>
 1a4:	0d0c5a04 	vstreq	s10, [ip, #-16]
 1a8:	0000000c 	andeq	r0, r0, ip
 1ac:	00000018 	andeq	r0, r0, r8, lsl r0
 1b0:	00000178 	andeq	r0, r0, r8, ror r1
 1b4:	00008270 	andeq	r8, r0, r0, ror r2
 1b8:	00000058 	andeq	r0, r0, r8, asr r0
 1bc:	8b080e42 	blhi	203acc <__bss_end+0x1faac0>
 1c0:	42018e02 	andmi	r8, r1, #2, 28
 1c4:	00040b0c 	andeq	r0, r4, ip, lsl #22
 1c8:	0000001c 	andeq	r0, r0, ip, lsl r0
 1cc:	00000178 	andeq	r0, r0, r8, ror r1
 1d0:	000082c8 	andeq	r8, r0, r8, asr #5
 1d4:	000000b8 	strheq	r0, [r0], -r8
 1d8:	8b080e42 	blhi	203ae8 <__bss_end+0x1faadc>
 1dc:	42018e02 	andmi	r8, r1, #2, 28
 1e0:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 1e4:	080d0c46 	stmdaeq	sp, {r1, r2, r6, sl, fp}
 1e8:	0000000c 	andeq	r0, r0, ip
 1ec:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 1f0:	7c020001 	stcvc	0, cr0, [r2], {1}
 1f4:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 1f8:	0000001c 	andeq	r0, r0, ip, lsl r0
 1fc:	000001e8 	andeq	r0, r0, r8, ror #3
 200:	00008380 	andeq	r8, r0, r0, lsl #7
 204:	0000002c 	andeq	r0, r0, ip, lsr #32
 208:	8b040e42 	blhi	103b18 <__bss_end+0xfab0c>
 20c:	0b0d4201 	bleq	350a18 <__bss_end+0x347a0c>
 210:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
 214:	00000ecb 	andeq	r0, r0, fp, asr #29
 218:	0000001c 	andeq	r0, r0, ip, lsl r0
 21c:	000001e8 	andeq	r0, r0, r8, ror #3
 220:	000083ac 	andeq	r8, r0, ip, lsr #7
 224:	0000002c 	andeq	r0, r0, ip, lsr #32
 228:	8b040e42 	blhi	103b38 <__bss_end+0xfab2c>
 22c:	0b0d4201 	bleq	350a38 <__bss_end+0x347a2c>
 230:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
 234:	00000ecb 	andeq	r0, r0, fp, asr #29
 238:	0000001c 	andeq	r0, r0, ip, lsl r0
 23c:	000001e8 	andeq	r0, r0, r8, ror #3
 240:	000083d8 	ldrdeq	r8, [r0], -r8	; <UNPREDICTABLE>
 244:	0000001c 	andeq	r0, r0, ip, lsl r0
 248:	8b040e42 	blhi	103b58 <__bss_end+0xfab4c>
 24c:	0b0d4201 	bleq	350a58 <__bss_end+0x347a4c>
 250:	420d0d46 	andmi	r0, sp, #4480	; 0x1180
 254:	00000ecb 	andeq	r0, r0, fp, asr #29
 258:	0000001c 	andeq	r0, r0, ip, lsl r0
 25c:	000001e8 	andeq	r0, r0, r8, ror #3
 260:	000083f4 	strdeq	r8, [r0], -r4
 264:	00000044 	andeq	r0, r0, r4, asr #32
 268:	8b040e42 	blhi	103b78 <__bss_end+0xfab6c>
 26c:	0b0d4201 	bleq	350a78 <__bss_end+0x347a6c>
 270:	420d0d5a 	andmi	r0, sp, #5760	; 0x1680
 274:	00000ecb 	andeq	r0, r0, fp, asr #29
 278:	0000001c 	andeq	r0, r0, ip, lsl r0
 27c:	000001e8 	andeq	r0, r0, r8, ror #3
 280:	00008438 	andeq	r8, r0, r8, lsr r4
 284:	00000050 	andeq	r0, r0, r0, asr r0
 288:	8b040e42 	blhi	103b98 <__bss_end+0xfab8c>
 28c:	0b0d4201 	bleq	350a98 <__bss_end+0x347a8c>
 290:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 294:	00000ecb 	andeq	r0, r0, fp, asr #29
 298:	0000001c 	andeq	r0, r0, ip, lsl r0
 29c:	000001e8 	andeq	r0, r0, r8, ror #3
 2a0:	00008488 	andeq	r8, r0, r8, lsl #9
 2a4:	00000050 	andeq	r0, r0, r0, asr r0
 2a8:	8b040e42 	blhi	103bb8 <__bss_end+0xfabac>
 2ac:	0b0d4201 	bleq	350ab8 <__bss_end+0x347aac>
 2b0:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 2b4:	00000ecb 	andeq	r0, r0, fp, asr #29
 2b8:	0000001c 	andeq	r0, r0, ip, lsl r0
 2bc:	000001e8 	andeq	r0, r0, r8, ror #3
 2c0:	000084d8 	ldrdeq	r8, [r0], -r8	; <UNPREDICTABLE>
 2c4:	0000002c 	andeq	r0, r0, ip, lsr #32
 2c8:	8b040e42 	blhi	103bd8 <__bss_end+0xfabcc>
 2cc:	0b0d4201 	bleq	350ad8 <__bss_end+0x347acc>
 2d0:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
 2d4:	00000ecb 	andeq	r0, r0, fp, asr #29
 2d8:	0000001c 	andeq	r0, r0, ip, lsl r0
 2dc:	000001e8 	andeq	r0, r0, r8, ror #3
 2e0:	00008504 	andeq	r8, r0, r4, lsl #10
 2e4:	00000050 	andeq	r0, r0, r0, asr r0
 2e8:	8b040e42 	blhi	103bf8 <__bss_end+0xfabec>
 2ec:	0b0d4201 	bleq	350af8 <__bss_end+0x347aec>
 2f0:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 2f4:	00000ecb 	andeq	r0, r0, fp, asr #29
 2f8:	0000001c 	andeq	r0, r0, ip, lsl r0
 2fc:	000001e8 	andeq	r0, r0, r8, ror #3
 300:	00008554 	andeq	r8, r0, r4, asr r5
 304:	00000044 	andeq	r0, r0, r4, asr #32
 308:	8b040e42 	blhi	103c18 <__bss_end+0xfac0c>
 30c:	0b0d4201 	bleq	350b18 <__bss_end+0x347b0c>
 310:	420d0d5a 	andmi	r0, sp, #5760	; 0x1680
 314:	00000ecb 	andeq	r0, r0, fp, asr #29
 318:	0000001c 	andeq	r0, r0, ip, lsl r0
 31c:	000001e8 	andeq	r0, r0, r8, ror #3
 320:	00008598 	muleq	r0, r8, r5
 324:	00000050 	andeq	r0, r0, r0, asr r0
 328:	8b040e42 	blhi	103c38 <__bss_end+0xfac2c>
 32c:	0b0d4201 	bleq	350b38 <__bss_end+0x347b2c>
 330:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 334:	00000ecb 	andeq	r0, r0, fp, asr #29
 338:	0000001c 	andeq	r0, r0, ip, lsl r0
 33c:	000001e8 	andeq	r0, r0, r8, ror #3
 340:	000085e8 	andeq	r8, r0, r8, ror #11
 344:	00000054 	andeq	r0, r0, r4, asr r0
 348:	8b040e42 	blhi	103c58 <__bss_end+0xfac4c>
 34c:	0b0d4201 	bleq	350b58 <__bss_end+0x347b4c>
 350:	420d0d62 	andmi	r0, sp, #6272	; 0x1880
 354:	00000ecb 	andeq	r0, r0, fp, asr #29
 358:	0000001c 	andeq	r0, r0, ip, lsl r0
 35c:	000001e8 	andeq	r0, r0, r8, ror #3
 360:	0000863c 	andeq	r8, r0, ip, lsr r6
 364:	0000003c 	andeq	r0, r0, ip, lsr r0
 368:	8b040e42 	blhi	103c78 <__bss_end+0xfac6c>
 36c:	0b0d4201 	bleq	350b78 <__bss_end+0x347b6c>
 370:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 374:	00000ecb 	andeq	r0, r0, fp, asr #29
 378:	0000001c 	andeq	r0, r0, ip, lsl r0
 37c:	000001e8 	andeq	r0, r0, r8, ror #3
 380:	00008678 	andeq	r8, r0, r8, ror r6
 384:	0000003c 	andeq	r0, r0, ip, lsr r0
 388:	8b040e42 	blhi	103c98 <__bss_end+0xfac8c>
 38c:	0b0d4201 	bleq	350b98 <__bss_end+0x347b8c>
 390:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 394:	00000ecb 	andeq	r0, r0, fp, asr #29
 398:	0000001c 	andeq	r0, r0, ip, lsl r0
 39c:	000001e8 	andeq	r0, r0, r8, ror #3
 3a0:	000086b4 			; <UNDEFINED> instruction: 0x000086b4
 3a4:	0000003c 	andeq	r0, r0, ip, lsr r0
 3a8:	8b040e42 	blhi	103cb8 <__bss_end+0xfacac>
 3ac:	0b0d4201 	bleq	350bb8 <__bss_end+0x347bac>
 3b0:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 3b4:	00000ecb 	andeq	r0, r0, fp, asr #29
 3b8:	0000001c 	andeq	r0, r0, ip, lsl r0
 3bc:	000001e8 	andeq	r0, r0, r8, ror #3
 3c0:	000086f0 	strdeq	r8, [r0], -r0
 3c4:	0000003c 	andeq	r0, r0, ip, lsr r0
 3c8:	8b040e42 	blhi	103cd8 <__bss_end+0xfaccc>
 3cc:	0b0d4201 	bleq	350bd8 <__bss_end+0x347bcc>
 3d0:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 3d4:	00000ecb 	andeq	r0, r0, fp, asr #29
 3d8:	0000001c 	andeq	r0, r0, ip, lsl r0
 3dc:	000001e8 	andeq	r0, r0, r8, ror #3
 3e0:	0000872c 	andeq	r8, r0, ip, lsr #14
 3e4:	000000b0 	strheq	r0, [r0], -r0	; <UNPREDICTABLE>
 3e8:	8b080e42 	blhi	203cf8 <__bss_end+0x1facec>
 3ec:	42018e02 	andmi	r8, r1, #2, 28
 3f0:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 3f4:	080d0c50 	stmdaeq	sp, {r4, r6, sl, fp}
 3f8:	0000000c 	andeq	r0, r0, ip
 3fc:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 400:	7c020001 	stcvc	0, cr0, [r2], {1}
 404:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 408:	0000001c 	andeq	r0, r0, ip, lsl r0
 40c:	000003f8 	strdeq	r0, [r0], -r8
 410:	000087dc 	ldrdeq	r8, [r0], -ip
 414:	00000174 	andeq	r0, r0, r4, ror r1
 418:	8b080e42 	blhi	203d28 <__bss_end+0x1fad1c>
 41c:	42018e02 	andmi	r8, r1, #2, 28
 420:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 424:	080d0cb2 	stmdaeq	sp, {r1, r4, r5, r7, sl, fp}
 428:	0000001c 	andeq	r0, r0, ip, lsl r0
 42c:	000003f8 	strdeq	r0, [r0], -r8
 430:	00008950 	andeq	r8, r0, r0, asr r9
 434:	0000009c 	muleq	r0, ip, r0
 438:	8b040e42 	blhi	103d48 <__bss_end+0xfad3c>
 43c:	0b0d4201 	bleq	350c48 <__bss_end+0x347c3c>
 440:	0d0d4602 	stceq	6, cr4, [sp, #-8]
 444:	000ecb42 	andeq	ip, lr, r2, asr #22
 448:	0000001c 	andeq	r0, r0, ip, lsl r0
 44c:	000003f8 	strdeq	r0, [r0], -r8
 450:	000089ec 	andeq	r8, r0, ip, ror #19
 454:	000000c0 	andeq	r0, r0, r0, asr #1
 458:	8b040e42 	blhi	103d68 <__bss_end+0xfad5c>
 45c:	0b0d4201 	bleq	350c68 <__bss_end+0x347c5c>
 460:	0d0d5802 	stceq	8, cr5, [sp, #-8]
 464:	000ecb42 	andeq	ip, lr, r2, asr #22
 468:	0000001c 	andeq	r0, r0, ip, lsl r0
 46c:	000003f8 	strdeq	r0, [r0], -r8
 470:	00008aac 	andeq	r8, r0, ip, lsr #21
 474:	000000ac 	andeq	r0, r0, ip, lsr #1
 478:	8b040e42 	blhi	103d88 <__bss_end+0xfad7c>
 47c:	0b0d4201 	bleq	350c88 <__bss_end+0x347c7c>
 480:	0d0d4e02 	stceq	14, cr4, [sp, #-8]
 484:	000ecb42 	andeq	ip, lr, r2, asr #22
 488:	0000001c 	andeq	r0, r0, ip, lsl r0
 48c:	000003f8 	strdeq	r0, [r0], -r8
 490:	00008b58 	andeq	r8, r0, r8, asr fp
 494:	00000054 	andeq	r0, r0, r4, asr r0
 498:	8b040e42 	blhi	103da8 <__bss_end+0xfad9c>
 49c:	0b0d4201 	bleq	350ca8 <__bss_end+0x347c9c>
 4a0:	420d0d62 	andmi	r0, sp, #6272	; 0x1880
 4a4:	00000ecb 	andeq	r0, r0, fp, asr #29
 4a8:	0000001c 	andeq	r0, r0, ip, lsl r0
 4ac:	000003f8 	strdeq	r0, [r0], -r8
 4b0:	00008bac 	andeq	r8, r0, ip, lsr #23
 4b4:	00000068 	andeq	r0, r0, r8, rrx
 4b8:	8b040e42 	blhi	103dc8 <__bss_end+0xfadbc>
 4bc:	0b0d4201 	bleq	350cc8 <__bss_end+0x347cbc>
 4c0:	420d0d6c 	andmi	r0, sp, #108, 26	; 0x1b00
 4c4:	00000ecb 	andeq	r0, r0, fp, asr #29
 4c8:	0000001c 	andeq	r0, r0, ip, lsl r0
 4cc:	000003f8 	strdeq	r0, [r0], -r8
 4d0:	00008c14 	andeq	r8, r0, r4, lsl ip
 4d4:	00000080 	andeq	r0, r0, r0, lsl #1
 4d8:	8b040e42 	blhi	103de8 <__bss_end+0xfaddc>
 4dc:	0b0d4201 	bleq	350ce8 <__bss_end+0x347cdc>
 4e0:	420d0d78 	andmi	r0, sp, #120, 26	; 0x1e00
 4e4:	00000ecb 	andeq	r0, r0, fp, asr #29
 4e8:	0000000c 	andeq	r0, r0, ip
 4ec:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 4f0:	7c010001 	stcvc	0, cr0, [r1], {1}
 4f4:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 4f8:	0000000c 	andeq	r0, r0, ip
 4fc:	000004e8 	andeq	r0, r0, r8, ror #9
 500:	00008c94 	muleq	r0, r4, ip
 504:	000001ec 	andeq	r0, r0, ip, ror #3
