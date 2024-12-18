
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
    805c:	00008f80 	andeq	r8, r0, r0, lsl #31
    8060:	00008fa0 	andeq	r8, r0, r0, lsr #31

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
    8080:	eb00007f 	bl	8284 <main>
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
    81cc:	00008f7d 	andeq	r8, r0, sp, ror pc
    81d0:	00008f7d 	andeq	r8, r0, sp, ror pc

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
    8224:	00008f7d 	andeq	r8, r0, sp, ror pc
    8228:	00008f7d 	andeq	r8, r0, sp, ror pc

0000822c <_Z5blinkv>:
_Z5blinkv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:20
constexpr uint32_t char_tick_delay = 0x1000;

uint32_t led, uart, master, log;

void blink()
{
    822c:	e92d4800 	push	{fp, lr}
    8230:	e28db004 	add	fp, sp, #4
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:21
	write(led, "1", 1);
    8234:	e59f303c 	ldr	r3, [pc, #60]	; 8278 <_Z5blinkv+0x4c>
    8238:	e5933000 	ldr	r3, [r3]
    823c:	e3a02001 	mov	r2, #1
    8240:	e59f1034 	ldr	r1, [pc, #52]	; 827c <_Z5blinkv+0x50>
    8244:	e1a00003 	mov	r0, r3
    8248:	eb00007d 	bl	8444 <_Z5writejPKcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:22
	sleep(0x1000);
    824c:	e3e01001 	mvn	r1, #1
    8250:	e3a00a01 	mov	r0, #4096	; 0x1000
    8254:	eb0000d2 	bl	85a4 <_Z5sleepjj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:23
	write(led, "0", 1);
    8258:	e59f3018 	ldr	r3, [pc, #24]	; 8278 <_Z5blinkv+0x4c>
    825c:	e5933000 	ldr	r3, [r3]
    8260:	e3a02001 	mov	r2, #1
    8264:	e59f1014 	ldr	r1, [pc, #20]	; 8280 <_Z5blinkv+0x54>
    8268:	e1a00003 	mov	r0, r3
    826c:	eb000074 	bl	8444 <_Z5writejPKcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:24
}
    8270:	e320f000 	nop	{0}
    8274:	e8bd8800 	pop	{fp, pc}
    8278:	00008f80 	andeq	r8, r0, r0, lsl #31
    827c:	00008ecc 	andeq	r8, r0, ip, asr #29
    8280:	00008ed0 	ldrdeq	r8, [r0], -r0

00008284 <main>:
main():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:27

int main(int argc, char** argv)
{
    8284:	e92d4800 	push	{fp, lr}
    8288:	e28db004 	add	fp, sp, #4
    828c:	e24dd010 	sub	sp, sp, #16
    8290:	e50b0010 	str	r0, [fp, #-16]
    8294:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:30
    char buff[4];

    log = pipe("log", 32);
    8298:	e3a01020 	mov	r1, #32
    829c:	e59f007c 	ldr	r0, [pc, #124]	; 8320 <main+0x9c>
    82a0:	eb000110 	bl	86e8 <_Z4pipePKcj>
    82a4:	e1a03000 	mov	r3, r0
    82a8:	e59f2074 	ldr	r2, [pc, #116]	; 8324 <main+0xa0>
    82ac:	e5823000 	str	r3, [r2]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:33
    // trng = open("DEV:trng/0", NFile_Open_Mode::Read_Write);

    write(log, "Master task started\n", 21);
    82b0:	e59f306c 	ldr	r3, [pc, #108]	; 8324 <main+0xa0>
    82b4:	e5933000 	ldr	r3, [r3]
    82b8:	e3a02015 	mov	r2, #21
    82bc:	e59f1064 	ldr	r1, [pc, #100]	; 8328 <main+0xa4>
    82c0:	e1a00003 	mov	r0, r3
    82c4:	eb00005e 	bl	8444 <_Z5writejPKcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:36

    // start i2c connection
    master = open("DEV:i2c/1", NFile_Open_Mode::Read_Write);
    82c8:	e3a01002 	mov	r1, #2
    82cc:	e59f0058 	ldr	r0, [pc, #88]	; 832c <main+0xa8>
    82d0:	eb000036 	bl	83b0 <_Z4openPKc15NFile_Open_Mode>
    82d4:	e1a03000 	mov	r3, r0
    82d8:	e59f2050 	ldr	r2, [pc, #80]	; 8330 <main+0xac>
    82dc:	e5823000 	str	r3, [r2]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:37
    write(log, "I2C connection master started...\n", 33);
    82e0:	e59f303c 	ldr	r3, [pc, #60]	; 8324 <main+0xa0>
    82e4:	e5933000 	ldr	r3, [r3]
    82e8:	e3a02021 	mov	r2, #33	; 0x21
    82ec:	e59f1040 	ldr	r1, [pc, #64]	; 8334 <main+0xb0>
    82f0:	e1a00003 	mov	r0, r3
    82f4:	eb000052 	bl	8444 <_Z5writejPKcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:39 (discriminator 1)
    for (;;) {
        write(log, "Hello from master\n", 18);
    82f8:	e59f3024 	ldr	r3, [pc, #36]	; 8324 <main+0xa0>
    82fc:	e5933000 	ldr	r3, [r3]
    8300:	e3a02012 	mov	r2, #18
    8304:	e59f102c 	ldr	r1, [pc, #44]	; 8338 <main+0xb4>
    8308:	e1a00003 	mov	r0, r3
    830c:	eb00004c 	bl	8444 <_Z5writejPKcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:40 (discriminator 1)
        sleep(0x10000);
    8310:	e3e01001 	mvn	r1, #1
    8314:	e3a00801 	mov	r0, #65536	; 0x10000
    8318:	eb0000a1 	bl	85a4 <_Z5sleepjj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:39 (discriminator 1)
        write(log, "Hello from master\n", 18);
    831c:	eafffff5 	b	82f8 <main+0x74>
    8320:	00008ed4 	ldrdeq	r8, [r0], -r4
    8324:	00008f8c 	andeq	r8, r0, ip, lsl #31
    8328:	00008ed8 	ldrdeq	r8, [r0], -r8	; <UNPREDICTABLE>
    832c:	00008ef0 	strdeq	r8, [r0], -r0
    8330:	00008f88 	andeq	r8, r0, r8, lsl #31
    8334:	00008efc 	strdeq	r8, [r0], -ip
    8338:	00008f20 	andeq	r8, r0, r0, lsr #30

0000833c <_Z6getpidv>:
_Z6getpidv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:5
#include <stdfile.h>
#include <stdstring.h>

uint32_t getpid()
{
    833c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8340:	e28db000 	add	fp, sp, #0
    8344:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:8
    uint32_t pid;

    asm volatile("swi 0");
    8348:	ef000000 	svc	0x00000000
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:9
    asm volatile("mov %0, r0" : "=r" (pid));
    834c:	e1a03000 	mov	r3, r0
    8350:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:11

    return pid;
    8354:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:12
}
    8358:	e1a00003 	mov	r0, r3
    835c:	e28bd000 	add	sp, fp, #0
    8360:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8364:	e12fff1e 	bx	lr

00008368 <_Z9terminatei>:
_Z9terminatei():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:15

void terminate(int exitcode)
{
    8368:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    836c:	e28db000 	add	fp, sp, #0
    8370:	e24dd00c 	sub	sp, sp, #12
    8374:	e50b0008 	str	r0, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:16
    asm volatile("mov r0, %0" : : "r" (exitcode));
    8378:	e51b3008 	ldr	r3, [fp, #-8]
    837c:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:17
    asm volatile("swi 1");
    8380:	ef000001 	svc	0x00000001
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:18
}
    8384:	e320f000 	nop	{0}
    8388:	e28bd000 	add	sp, fp, #0
    838c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8390:	e12fff1e 	bx	lr

00008394 <_Z11sched_yieldv>:
_Z11sched_yieldv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:21

void sched_yield()
{
    8394:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8398:	e28db000 	add	fp, sp, #0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:22
    asm volatile("swi 2");
    839c:	ef000002 	svc	0x00000002
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:23
}
    83a0:	e320f000 	nop	{0}
    83a4:	e28bd000 	add	sp, fp, #0
    83a8:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    83ac:	e12fff1e 	bx	lr

000083b0 <_Z4openPKc15NFile_Open_Mode>:
_Z4openPKc15NFile_Open_Mode():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:26

uint32_t open(const char* filename, NFile_Open_Mode mode)
{
    83b0:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    83b4:	e28db000 	add	fp, sp, #0
    83b8:	e24dd014 	sub	sp, sp, #20
    83bc:	e50b0010 	str	r0, [fp, #-16]
    83c0:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:29
    uint32_t file;

    asm volatile("mov r0, %0" : : "r" (filename));
    83c4:	e51b3010 	ldr	r3, [fp, #-16]
    83c8:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:30
    asm volatile("mov r1, %0" : : "r" (mode));
    83cc:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    83d0:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:31
    asm volatile("swi 64");
    83d4:	ef000040 	svc	0x00000040
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:32
    asm volatile("mov %0, r0" : "=r" (file));
    83d8:	e1a03000 	mov	r3, r0
    83dc:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:34

    return file;
    83e0:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:35
}
    83e4:	e1a00003 	mov	r0, r3
    83e8:	e28bd000 	add	sp, fp, #0
    83ec:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    83f0:	e12fff1e 	bx	lr

000083f4 <_Z4readjPcj>:
_Z4readjPcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:38

uint32_t read(uint32_t file, char* const buffer, uint32_t size)
{
    83f4:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    83f8:	e28db000 	add	fp, sp, #0
    83fc:	e24dd01c 	sub	sp, sp, #28
    8400:	e50b0010 	str	r0, [fp, #-16]
    8404:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8408:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:41
    uint32_t rdnum;

    asm volatile("mov r0, %0" : : "r" (file));
    840c:	e51b3010 	ldr	r3, [fp, #-16]
    8410:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:42
    asm volatile("mov r1, %0" : : "r" (buffer));
    8414:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8418:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:43
    asm volatile("mov r2, %0" : : "r" (size));
    841c:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8420:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:44
    asm volatile("swi 65");
    8424:	ef000041 	svc	0x00000041
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:45
    asm volatile("mov %0, r0" : "=r" (rdnum));
    8428:	e1a03000 	mov	r3, r0
    842c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:47

    return rdnum;
    8430:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:48
}
    8434:	e1a00003 	mov	r0, r3
    8438:	e28bd000 	add	sp, fp, #0
    843c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8440:	e12fff1e 	bx	lr

00008444 <_Z5writejPKcj>:
_Z5writejPKcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:51

uint32_t write(uint32_t file, const char* buffer, uint32_t size)
{
    8444:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8448:	e28db000 	add	fp, sp, #0
    844c:	e24dd01c 	sub	sp, sp, #28
    8450:	e50b0010 	str	r0, [fp, #-16]
    8454:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8458:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:54
    uint32_t wrnum;

    asm volatile("mov r0, %0" : : "r" (file));
    845c:	e51b3010 	ldr	r3, [fp, #-16]
    8460:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:55
    asm volatile("mov r1, %0" : : "r" (buffer));
    8464:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8468:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:56
    asm volatile("mov r2, %0" : : "r" (size));
    846c:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8470:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:57
    asm volatile("swi 66");
    8474:	ef000042 	svc	0x00000042
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:58
    asm volatile("mov %0, r0" : "=r" (wrnum));
    8478:	e1a03000 	mov	r3, r0
    847c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:60

    return wrnum;
    8480:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:61
}
    8484:	e1a00003 	mov	r0, r3
    8488:	e28bd000 	add	sp, fp, #0
    848c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8490:	e12fff1e 	bx	lr

00008494 <_Z5closej>:
_Z5closej():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:64

void close(uint32_t file)
{
    8494:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8498:	e28db000 	add	fp, sp, #0
    849c:	e24dd00c 	sub	sp, sp, #12
    84a0:	e50b0008 	str	r0, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:65
    asm volatile("mov r0, %0" : : "r" (file));
    84a4:	e51b3008 	ldr	r3, [fp, #-8]
    84a8:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:66
    asm volatile("swi 67");
    84ac:	ef000043 	svc	0x00000043
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:67
}
    84b0:	e320f000 	nop	{0}
    84b4:	e28bd000 	add	sp, fp, #0
    84b8:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    84bc:	e12fff1e 	bx	lr

000084c0 <_Z5ioctlj16NIOCtl_OperationPv>:
_Z5ioctlj16NIOCtl_OperationPv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:70

uint32_t ioctl(uint32_t file, NIOCtl_Operation operation, void* param)
{
    84c0:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    84c4:	e28db000 	add	fp, sp, #0
    84c8:	e24dd01c 	sub	sp, sp, #28
    84cc:	e50b0010 	str	r0, [fp, #-16]
    84d0:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    84d4:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:73
    uint32_t retcode;

    asm volatile("mov r0, %0" : : "r" (file));
    84d8:	e51b3010 	ldr	r3, [fp, #-16]
    84dc:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:74
    asm volatile("mov r1, %0" : : "r" (operation));
    84e0:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    84e4:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:75
    asm volatile("mov r2, %0" : : "r" (param));
    84e8:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    84ec:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:76
    asm volatile("swi 68");
    84f0:	ef000044 	svc	0x00000044
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:77
    asm volatile("mov %0, r0" : "=r" (retcode));
    84f4:	e1a03000 	mov	r3, r0
    84f8:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:79

    return retcode;
    84fc:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:80
}
    8500:	e1a00003 	mov	r0, r3
    8504:	e28bd000 	add	sp, fp, #0
    8508:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    850c:	e12fff1e 	bx	lr

00008510 <_Z6notifyjj>:
_Z6notifyjj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:83

uint32_t notify(uint32_t file, uint32_t count)
{
    8510:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8514:	e28db000 	add	fp, sp, #0
    8518:	e24dd014 	sub	sp, sp, #20
    851c:	e50b0010 	str	r0, [fp, #-16]
    8520:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:86
    uint32_t retcnt;

    asm volatile("mov r0, %0" : : "r" (file));
    8524:	e51b3010 	ldr	r3, [fp, #-16]
    8528:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:87
    asm volatile("mov r1, %0" : : "r" (count));
    852c:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8530:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:88
    asm volatile("swi 69");
    8534:	ef000045 	svc	0x00000045
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:89
    asm volatile("mov %0, r0" : "=r" (retcnt));
    8538:	e1a03000 	mov	r3, r0
    853c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:91

    return retcnt;
    8540:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:92
}
    8544:	e1a00003 	mov	r0, r3
    8548:	e28bd000 	add	sp, fp, #0
    854c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8550:	e12fff1e 	bx	lr

00008554 <_Z4waitjjj>:
_Z4waitjjj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:95

NSWI_Result_Code wait(uint32_t file, uint32_t count, uint32_t notified_deadline)
{
    8554:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8558:	e28db000 	add	fp, sp, #0
    855c:	e24dd01c 	sub	sp, sp, #28
    8560:	e50b0010 	str	r0, [fp, #-16]
    8564:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8568:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:98
    NSWI_Result_Code retcode;

    asm volatile("mov r0, %0" : : "r" (file));
    856c:	e51b3010 	ldr	r3, [fp, #-16]
    8570:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:99
    asm volatile("mov r1, %0" : : "r" (count));
    8574:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8578:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:100
    asm volatile("mov r2, %0" : : "r" (notified_deadline));
    857c:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8580:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:101
    asm volatile("swi 70");
    8584:	ef000046 	svc	0x00000046
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:102
    asm volatile("mov %0, r0" : "=r" (retcode));
    8588:	e1a03000 	mov	r3, r0
    858c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:104

    return retcode;
    8590:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:105
}
    8594:	e1a00003 	mov	r0, r3
    8598:	e28bd000 	add	sp, fp, #0
    859c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    85a0:	e12fff1e 	bx	lr

000085a4 <_Z5sleepjj>:
_Z5sleepjj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:108

bool sleep(uint32_t ticks, uint32_t notified_deadline)
{
    85a4:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    85a8:	e28db000 	add	fp, sp, #0
    85ac:	e24dd014 	sub	sp, sp, #20
    85b0:	e50b0010 	str	r0, [fp, #-16]
    85b4:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:111
    uint32_t retcode;

    asm volatile("mov r0, %0" : : "r" (ticks));
    85b8:	e51b3010 	ldr	r3, [fp, #-16]
    85bc:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:112
    asm volatile("mov r1, %0" : : "r" (notified_deadline));
    85c0:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    85c4:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:113
    asm volatile("swi 3");
    85c8:	ef000003 	svc	0x00000003
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:114
    asm volatile("mov %0, r0" : "=r" (retcode));
    85cc:	e1a03000 	mov	r3, r0
    85d0:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:116

    return retcode;
    85d4:	e51b3008 	ldr	r3, [fp, #-8]
    85d8:	e3530000 	cmp	r3, #0
    85dc:	13a03001 	movne	r3, #1
    85e0:	03a03000 	moveq	r3, #0
    85e4:	e6ef3073 	uxtb	r3, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:117
}
    85e8:	e1a00003 	mov	r0, r3
    85ec:	e28bd000 	add	sp, fp, #0
    85f0:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    85f4:	e12fff1e 	bx	lr

000085f8 <_Z24get_active_process_countv>:
_Z24get_active_process_countv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:120

uint32_t get_active_process_count()
{
    85f8:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    85fc:	e28db000 	add	fp, sp, #0
    8600:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:121
    const NGet_Sched_Info_Type req = NGet_Sched_Info_Type::Active_Process_Count;
    8604:	e3a03000 	mov	r3, #0
    8608:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:124
    uint32_t retval;

    asm volatile("mov r0, %0" : : "r" (req));
    860c:	e3a03000 	mov	r3, #0
    8610:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:125
    asm volatile("mov r1, %0" : : "r" (&retval));
    8614:	e24b300c 	sub	r3, fp, #12
    8618:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:126
    asm volatile("swi 4");
    861c:	ef000004 	svc	0x00000004
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:128

    return retval;
    8620:	e51b300c 	ldr	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:129
}
    8624:	e1a00003 	mov	r0, r3
    8628:	e28bd000 	add	sp, fp, #0
    862c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8630:	e12fff1e 	bx	lr

00008634 <_Z14get_tick_countv>:
_Z14get_tick_countv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:132

uint32_t get_tick_count()
{
    8634:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8638:	e28db000 	add	fp, sp, #0
    863c:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:133
    const NGet_Sched_Info_Type req = NGet_Sched_Info_Type::Tick_Count;
    8640:	e3a03001 	mov	r3, #1
    8644:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:136
    uint32_t retval;

    asm volatile("mov r0, %0" : : "r" (req));
    8648:	e3a03001 	mov	r3, #1
    864c:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:137
    asm volatile("mov r1, %0" : : "r" (&retval));
    8650:	e24b300c 	sub	r3, fp, #12
    8654:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:138
    asm volatile("swi 4");
    8658:	ef000004 	svc	0x00000004
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:140

    return retval;
    865c:	e51b300c 	ldr	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:141
}
    8660:	e1a00003 	mov	r0, r3
    8664:	e28bd000 	add	sp, fp, #0
    8668:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    866c:	e12fff1e 	bx	lr

00008670 <_Z17set_task_deadlinej>:
_Z17set_task_deadlinej():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:144

void set_task_deadline(uint32_t tick_count_required)
{
    8670:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8674:	e28db000 	add	fp, sp, #0
    8678:	e24dd014 	sub	sp, sp, #20
    867c:	e50b0010 	str	r0, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:145
    const NDeadline_Subservice req = NDeadline_Subservice::Set_Relative;
    8680:	e3a03000 	mov	r3, #0
    8684:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:147

    asm volatile("mov r0, %0" : : "r" (req));
    8688:	e3a03000 	mov	r3, #0
    868c:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:148
    asm volatile("mov r1, %0" : : "r" (&tick_count_required));
    8690:	e24b3010 	sub	r3, fp, #16
    8694:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:149
    asm volatile("swi 5");
    8698:	ef000005 	svc	0x00000005
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:150
}
    869c:	e320f000 	nop	{0}
    86a0:	e28bd000 	add	sp, fp, #0
    86a4:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    86a8:	e12fff1e 	bx	lr

000086ac <_Z26get_task_ticks_to_deadlinev>:
_Z26get_task_ticks_to_deadlinev():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:153

uint32_t get_task_ticks_to_deadline()
{
    86ac:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    86b0:	e28db000 	add	fp, sp, #0
    86b4:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:154
    const NDeadline_Subservice req = NDeadline_Subservice::Get_Remaining;
    86b8:	e3a03001 	mov	r3, #1
    86bc:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:157
    uint32_t ticks;

    asm volatile("mov r0, %0" : : "r" (req));
    86c0:	e3a03001 	mov	r3, #1
    86c4:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:158
    asm volatile("mov r1, %0" : : "r" (&ticks));
    86c8:	e24b300c 	sub	r3, fp, #12
    86cc:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:159
    asm volatile("swi 5");
    86d0:	ef000005 	svc	0x00000005
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:161

    return ticks;
    86d4:	e51b300c 	ldr	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:162
}
    86d8:	e1a00003 	mov	r0, r3
    86dc:	e28bd000 	add	sp, fp, #0
    86e0:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    86e4:	e12fff1e 	bx	lr

000086e8 <_Z4pipePKcj>:
_Z4pipePKcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:167

const char Pipe_File_Prefix[] = "SYS:pipe/";

uint32_t pipe(const char* name, uint32_t buf_size)
{
    86e8:	e92d4800 	push	{fp, lr}
    86ec:	e28db004 	add	fp, sp, #4
    86f0:	e24dd050 	sub	sp, sp, #80	; 0x50
    86f4:	e50b0050 	str	r0, [fp, #-80]	; 0xffffffb0
    86f8:	e50b1054 	str	r1, [fp, #-84]	; 0xffffffac
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:169
    char fname[64];
    strncpy(fname, Pipe_File_Prefix, sizeof(Pipe_File_Prefix));
    86fc:	e24b3048 	sub	r3, fp, #72	; 0x48
    8700:	e3a0200a 	mov	r2, #10
    8704:	e59f1088 	ldr	r1, [pc, #136]	; 8794 <_Z4pipePKcj+0xac>
    8708:	e1a00003 	mov	r0, r3
    870c:	eb0000a5 	bl	89a8 <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:170
    strncpy(fname + sizeof(Pipe_File_Prefix), name, sizeof(fname) - sizeof(Pipe_File_Prefix) - 1);
    8710:	e24b3048 	sub	r3, fp, #72	; 0x48
    8714:	e283300a 	add	r3, r3, #10
    8718:	e3a02035 	mov	r2, #53	; 0x35
    871c:	e51b1050 	ldr	r1, [fp, #-80]	; 0xffffffb0
    8720:	e1a00003 	mov	r0, r3
    8724:	eb00009f 	bl	89a8 <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:172

    int ncur = sizeof(Pipe_File_Prefix) + strlen(name);
    8728:	e51b0050 	ldr	r0, [fp, #-80]	; 0xffffffb0
    872c:	eb0000f8 	bl	8b14 <_Z6strlenPKc>
    8730:	e1a03000 	mov	r3, r0
    8734:	e283300a 	add	r3, r3, #10
    8738:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:174

    fname[ncur++] = '#';
    873c:	e51b3008 	ldr	r3, [fp, #-8]
    8740:	e2832001 	add	r2, r3, #1
    8744:	e50b2008 	str	r2, [fp, #-8]
    8748:	e2433004 	sub	r3, r3, #4
    874c:	e083300b 	add	r3, r3, fp
    8750:	e3a02023 	mov	r2, #35	; 0x23
    8754:	e5432044 	strb	r2, [r3, #-68]	; 0xffffffbc
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:176

    itoa(buf_size, &fname[ncur], 10);
    8758:	e24b2048 	sub	r2, fp, #72	; 0x48
    875c:	e51b3008 	ldr	r3, [fp, #-8]
    8760:	e0823003 	add	r3, r2, r3
    8764:	e3a0200a 	mov	r2, #10
    8768:	e1a01003 	mov	r1, r3
    876c:	e51b0054 	ldr	r0, [fp, #-84]	; 0xffffffac
    8770:	eb000008 	bl	8798 <_Z4itoajPcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:178

    return open(fname, NFile_Open_Mode::Read_Write);
    8774:	e24b3048 	sub	r3, fp, #72	; 0x48
    8778:	e3a01002 	mov	r1, #2
    877c:	e1a00003 	mov	r0, r3
    8780:	ebffff0a 	bl	83b0 <_Z4openPKc15NFile_Open_Mode>
    8784:	e1a03000 	mov	r3, r0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:179
}
    8788:	e1a00003 	mov	r0, r3
    878c:	e24bd004 	sub	sp, fp, #4
    8790:	e8bd8800 	pop	{fp, pc}
    8794:	00008f60 	andeq	r8, r0, r0, ror #30

00008798 <_Z4itoajPcj>:
_Z4itoajPcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:9
{
    const char CharConvArr[] = "0123456789ABCDEF";
}

void itoa(unsigned int input, char* output, unsigned int base)
{
    8798:	e92d4800 	push	{fp, lr}
    879c:	e28db004 	add	fp, sp, #4
    87a0:	e24dd020 	sub	sp, sp, #32
    87a4:	e50b0018 	str	r0, [fp, #-24]	; 0xffffffe8
    87a8:	e50b101c 	str	r1, [fp, #-28]	; 0xffffffe4
    87ac:	e50b2020 	str	r2, [fp, #-32]	; 0xffffffe0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:10
	int i = 0;
    87b0:	e3a03000 	mov	r3, #0
    87b4:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:12

	while (input > 0)
    87b8:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    87bc:	e3530000 	cmp	r3, #0
    87c0:	0a000014 	beq	8818 <_Z4itoajPcj+0x80>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:14
	{
		output[i] = CharConvArr[input % base];
    87c4:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    87c8:	e51b1020 	ldr	r1, [fp, #-32]	; 0xffffffe0
    87cc:	e1a00003 	mov	r0, r3
    87d0:	eb000199 	bl	8e3c <__aeabi_uidivmod>
    87d4:	e1a03001 	mov	r3, r1
    87d8:	e1a01003 	mov	r1, r3
    87dc:	e51b3008 	ldr	r3, [fp, #-8]
    87e0:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    87e4:	e0823003 	add	r3, r2, r3
    87e8:	e59f2118 	ldr	r2, [pc, #280]	; 8908 <_Z4itoajPcj+0x170>
    87ec:	e7d22001 	ldrb	r2, [r2, r1]
    87f0:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:15
		input /= base;
    87f4:	e51b1020 	ldr	r1, [fp, #-32]	; 0xffffffe0
    87f8:	e51b0018 	ldr	r0, [fp, #-24]	; 0xffffffe8
    87fc:	eb000113 	bl	8c50 <__udivsi3>
    8800:	e1a03000 	mov	r3, r0
    8804:	e50b3018 	str	r3, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:16
		i++;
    8808:	e51b3008 	ldr	r3, [fp, #-8]
    880c:	e2833001 	add	r3, r3, #1
    8810:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:12
	while (input > 0)
    8814:	eaffffe7 	b	87b8 <_Z4itoajPcj+0x20>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:19
	}

    if (i == 0)
    8818:	e51b3008 	ldr	r3, [fp, #-8]
    881c:	e3530000 	cmp	r3, #0
    8820:	1a000007 	bne	8844 <_Z4itoajPcj+0xac>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:21
    {
        output[i] = CharConvArr[0];
    8824:	e51b3008 	ldr	r3, [fp, #-8]
    8828:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    882c:	e0823003 	add	r3, r2, r3
    8830:	e3a02030 	mov	r2, #48	; 0x30
    8834:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:22
        i++;
    8838:	e51b3008 	ldr	r3, [fp, #-8]
    883c:	e2833001 	add	r3, r3, #1
    8840:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:25
    }

	output[i] = '\0';
    8844:	e51b3008 	ldr	r3, [fp, #-8]
    8848:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    884c:	e0823003 	add	r3, r2, r3
    8850:	e3a02000 	mov	r2, #0
    8854:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:26
	i--;
    8858:	e51b3008 	ldr	r3, [fp, #-8]
    885c:	e2433001 	sub	r3, r3, #1
    8860:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:28

	for (int j = 0; j <= i/2; j++)
    8864:	e3a03000 	mov	r3, #0
    8868:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:28 (discriminator 3)
    886c:	e51b3008 	ldr	r3, [fp, #-8]
    8870:	e1a02fa3 	lsr	r2, r3, #31
    8874:	e0823003 	add	r3, r2, r3
    8878:	e1a030c3 	asr	r3, r3, #1
    887c:	e1a02003 	mov	r2, r3
    8880:	e51b300c 	ldr	r3, [fp, #-12]
    8884:	e1530002 	cmp	r3, r2
    8888:	ca00001b 	bgt	88fc <_Z4itoajPcj+0x164>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:30 (discriminator 2)
	{
		char c = output[i - j];
    888c:	e51b2008 	ldr	r2, [fp, #-8]
    8890:	e51b300c 	ldr	r3, [fp, #-12]
    8894:	e0423003 	sub	r3, r2, r3
    8898:	e1a02003 	mov	r2, r3
    889c:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    88a0:	e0833002 	add	r3, r3, r2
    88a4:	e5d33000 	ldrb	r3, [r3]
    88a8:	e54b300d 	strb	r3, [fp, #-13]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:31 (discriminator 2)
		output[i - j] = output[j];
    88ac:	e51b300c 	ldr	r3, [fp, #-12]
    88b0:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    88b4:	e0822003 	add	r2, r2, r3
    88b8:	e51b1008 	ldr	r1, [fp, #-8]
    88bc:	e51b300c 	ldr	r3, [fp, #-12]
    88c0:	e0413003 	sub	r3, r1, r3
    88c4:	e1a01003 	mov	r1, r3
    88c8:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    88cc:	e0833001 	add	r3, r3, r1
    88d0:	e5d22000 	ldrb	r2, [r2]
    88d4:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:32 (discriminator 2)
		output[j] = c;
    88d8:	e51b300c 	ldr	r3, [fp, #-12]
    88dc:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    88e0:	e0823003 	add	r3, r2, r3
    88e4:	e55b200d 	ldrb	r2, [fp, #-13]
    88e8:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:28 (discriminator 2)
	for (int j = 0; j <= i/2; j++)
    88ec:	e51b300c 	ldr	r3, [fp, #-12]
    88f0:	e2833001 	add	r3, r3, #1
    88f4:	e50b300c 	str	r3, [fp, #-12]
    88f8:	eaffffdb 	b	886c <_Z4itoajPcj+0xd4>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:34
	}
}
    88fc:	e320f000 	nop	{0}
    8900:	e24bd004 	sub	sp, fp, #4
    8904:	e8bd8800 	pop	{fp, pc}
    8908:	00008f6c 	andeq	r8, r0, ip, ror #30

0000890c <_Z4atoiPKc>:
_Z4atoiPKc():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:37

int atoi(const char* input)
{
    890c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8910:	e28db000 	add	fp, sp, #0
    8914:	e24dd014 	sub	sp, sp, #20
    8918:	e50b0010 	str	r0, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:38
	int output = 0;
    891c:	e3a03000 	mov	r3, #0
    8920:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:40

	while (*input != '\0')
    8924:	e51b3010 	ldr	r3, [fp, #-16]
    8928:	e5d33000 	ldrb	r3, [r3]
    892c:	e3530000 	cmp	r3, #0
    8930:	0a000017 	beq	8994 <_Z4atoiPKc+0x88>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:42
	{
		output *= 10;
    8934:	e51b2008 	ldr	r2, [fp, #-8]
    8938:	e1a03002 	mov	r3, r2
    893c:	e1a03103 	lsl	r3, r3, #2
    8940:	e0833002 	add	r3, r3, r2
    8944:	e1a03083 	lsl	r3, r3, #1
    8948:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:43
		if (*input > '9' || *input < '0')
    894c:	e51b3010 	ldr	r3, [fp, #-16]
    8950:	e5d33000 	ldrb	r3, [r3]
    8954:	e3530039 	cmp	r3, #57	; 0x39
    8958:	8a00000d 	bhi	8994 <_Z4atoiPKc+0x88>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:43 (discriminator 1)
    895c:	e51b3010 	ldr	r3, [fp, #-16]
    8960:	e5d33000 	ldrb	r3, [r3]
    8964:	e353002f 	cmp	r3, #47	; 0x2f
    8968:	9a000009 	bls	8994 <_Z4atoiPKc+0x88>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:46
			break;

		output += *input - '0';
    896c:	e51b3010 	ldr	r3, [fp, #-16]
    8970:	e5d33000 	ldrb	r3, [r3]
    8974:	e2433030 	sub	r3, r3, #48	; 0x30
    8978:	e51b2008 	ldr	r2, [fp, #-8]
    897c:	e0823003 	add	r3, r2, r3
    8980:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:48

		input++;
    8984:	e51b3010 	ldr	r3, [fp, #-16]
    8988:	e2833001 	add	r3, r3, #1
    898c:	e50b3010 	str	r3, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:40
	while (*input != '\0')
    8990:	eaffffe3 	b	8924 <_Z4atoiPKc+0x18>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:51
	}

	return output;
    8994:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:52
}
    8998:	e1a00003 	mov	r0, r3
    899c:	e28bd000 	add	sp, fp, #0
    89a0:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    89a4:	e12fff1e 	bx	lr

000089a8 <_Z7strncpyPcPKci>:
_Z7strncpyPcPKci():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:55

char* strncpy(char* dest, const char *src, int num)
{
    89a8:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    89ac:	e28db000 	add	fp, sp, #0
    89b0:	e24dd01c 	sub	sp, sp, #28
    89b4:	e50b0010 	str	r0, [fp, #-16]
    89b8:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    89bc:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:58
	int i;

	for (i = 0; i < num && src[i] != '\0'; i++)
    89c0:	e3a03000 	mov	r3, #0
    89c4:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:58 (discriminator 4)
    89c8:	e51b2008 	ldr	r2, [fp, #-8]
    89cc:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    89d0:	e1520003 	cmp	r2, r3
    89d4:	aa000011 	bge	8a20 <_Z7strncpyPcPKci+0x78>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:58 (discriminator 2)
    89d8:	e51b3008 	ldr	r3, [fp, #-8]
    89dc:	e51b2014 	ldr	r2, [fp, #-20]	; 0xffffffec
    89e0:	e0823003 	add	r3, r2, r3
    89e4:	e5d33000 	ldrb	r3, [r3]
    89e8:	e3530000 	cmp	r3, #0
    89ec:	0a00000b 	beq	8a20 <_Z7strncpyPcPKci+0x78>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:59 (discriminator 3)
		dest[i] = src[i];
    89f0:	e51b3008 	ldr	r3, [fp, #-8]
    89f4:	e51b2014 	ldr	r2, [fp, #-20]	; 0xffffffec
    89f8:	e0822003 	add	r2, r2, r3
    89fc:	e51b3008 	ldr	r3, [fp, #-8]
    8a00:	e51b1010 	ldr	r1, [fp, #-16]
    8a04:	e0813003 	add	r3, r1, r3
    8a08:	e5d22000 	ldrb	r2, [r2]
    8a0c:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:58 (discriminator 3)
	for (i = 0; i < num && src[i] != '\0'; i++)
    8a10:	e51b3008 	ldr	r3, [fp, #-8]
    8a14:	e2833001 	add	r3, r3, #1
    8a18:	e50b3008 	str	r3, [fp, #-8]
    8a1c:	eaffffe9 	b	89c8 <_Z7strncpyPcPKci+0x20>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:60 (discriminator 2)
	for (; i < num; i++)
    8a20:	e51b2008 	ldr	r2, [fp, #-8]
    8a24:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8a28:	e1520003 	cmp	r2, r3
    8a2c:	aa000008 	bge	8a54 <_Z7strncpyPcPKci+0xac>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:61 (discriminator 1)
		dest[i] = '\0';
    8a30:	e51b3008 	ldr	r3, [fp, #-8]
    8a34:	e51b2010 	ldr	r2, [fp, #-16]
    8a38:	e0823003 	add	r3, r2, r3
    8a3c:	e3a02000 	mov	r2, #0
    8a40:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:60 (discriminator 1)
	for (; i < num; i++)
    8a44:	e51b3008 	ldr	r3, [fp, #-8]
    8a48:	e2833001 	add	r3, r3, #1
    8a4c:	e50b3008 	str	r3, [fp, #-8]
    8a50:	eafffff2 	b	8a20 <_Z7strncpyPcPKci+0x78>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:63

   return dest;
    8a54:	e51b3010 	ldr	r3, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:64
}
    8a58:	e1a00003 	mov	r0, r3
    8a5c:	e28bd000 	add	sp, fp, #0
    8a60:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8a64:	e12fff1e 	bx	lr

00008a68 <_Z7strncmpPKcS0_i>:
_Z7strncmpPKcS0_i():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:67

int strncmp(const char *s1, const char *s2, int num)
{
    8a68:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8a6c:	e28db000 	add	fp, sp, #0
    8a70:	e24dd01c 	sub	sp, sp, #28
    8a74:	e50b0010 	str	r0, [fp, #-16]
    8a78:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8a7c:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:69
	unsigned char u1, u2;
  	while (num-- > 0)
    8a80:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8a84:	e2432001 	sub	r2, r3, #1
    8a88:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
    8a8c:	e3530000 	cmp	r3, #0
    8a90:	c3a03001 	movgt	r3, #1
    8a94:	d3a03000 	movle	r3, #0
    8a98:	e6ef3073 	uxtb	r3, r3
    8a9c:	e3530000 	cmp	r3, #0
    8aa0:	0a000016 	beq	8b00 <_Z7strncmpPKcS0_i+0x98>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:71
    {
      	u1 = (unsigned char) *s1++;
    8aa4:	e51b3010 	ldr	r3, [fp, #-16]
    8aa8:	e2832001 	add	r2, r3, #1
    8aac:	e50b2010 	str	r2, [fp, #-16]
    8ab0:	e5d33000 	ldrb	r3, [r3]
    8ab4:	e54b3005 	strb	r3, [fp, #-5]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:72
     	u2 = (unsigned char) *s2++;
    8ab8:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8abc:	e2832001 	add	r2, r3, #1
    8ac0:	e50b2014 	str	r2, [fp, #-20]	; 0xffffffec
    8ac4:	e5d33000 	ldrb	r3, [r3]
    8ac8:	e54b3006 	strb	r3, [fp, #-6]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:73
      	if (u1 != u2)
    8acc:	e55b2005 	ldrb	r2, [fp, #-5]
    8ad0:	e55b3006 	ldrb	r3, [fp, #-6]
    8ad4:	e1520003 	cmp	r2, r3
    8ad8:	0a000003 	beq	8aec <_Z7strncmpPKcS0_i+0x84>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:74
        	return u1 - u2;
    8adc:	e55b2005 	ldrb	r2, [fp, #-5]
    8ae0:	e55b3006 	ldrb	r3, [fp, #-6]
    8ae4:	e0423003 	sub	r3, r2, r3
    8ae8:	ea000005 	b	8b04 <_Z7strncmpPKcS0_i+0x9c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:75
      	if (u1 == '\0')
    8aec:	e55b3005 	ldrb	r3, [fp, #-5]
    8af0:	e3530000 	cmp	r3, #0
    8af4:	1affffe1 	bne	8a80 <_Z7strncmpPKcS0_i+0x18>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:76
        	return 0;
    8af8:	e3a03000 	mov	r3, #0
    8afc:	ea000000 	b	8b04 <_Z7strncmpPKcS0_i+0x9c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:79
    }

  	return 0;
    8b00:	e3a03000 	mov	r3, #0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:80
}
    8b04:	e1a00003 	mov	r0, r3
    8b08:	e28bd000 	add	sp, fp, #0
    8b0c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8b10:	e12fff1e 	bx	lr

00008b14 <_Z6strlenPKc>:
_Z6strlenPKc():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:83

int strlen(const char* s)
{
    8b14:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8b18:	e28db000 	add	fp, sp, #0
    8b1c:	e24dd014 	sub	sp, sp, #20
    8b20:	e50b0010 	str	r0, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:84
	int i = 0;
    8b24:	e3a03000 	mov	r3, #0
    8b28:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:86

	while (s[i] != '\0')
    8b2c:	e51b3008 	ldr	r3, [fp, #-8]
    8b30:	e51b2010 	ldr	r2, [fp, #-16]
    8b34:	e0823003 	add	r3, r2, r3
    8b38:	e5d33000 	ldrb	r3, [r3]
    8b3c:	e3530000 	cmp	r3, #0
    8b40:	0a000003 	beq	8b54 <_Z6strlenPKc+0x40>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:87
		i++;
    8b44:	e51b3008 	ldr	r3, [fp, #-8]
    8b48:	e2833001 	add	r3, r3, #1
    8b4c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:86
	while (s[i] != '\0')
    8b50:	eafffff5 	b	8b2c <_Z6strlenPKc+0x18>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:89

	return i;
    8b54:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:90
}
    8b58:	e1a00003 	mov	r0, r3
    8b5c:	e28bd000 	add	sp, fp, #0
    8b60:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8b64:	e12fff1e 	bx	lr

00008b68 <_Z5bzeroPvi>:
_Z5bzeroPvi():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:93

void bzero(void* memory, int length)
{
    8b68:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8b6c:	e28db000 	add	fp, sp, #0
    8b70:	e24dd014 	sub	sp, sp, #20
    8b74:	e50b0010 	str	r0, [fp, #-16]
    8b78:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:94
	char* mem = reinterpret_cast<char*>(memory);
    8b7c:	e51b3010 	ldr	r3, [fp, #-16]
    8b80:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:96

	for (int i = 0; i < length; i++)
    8b84:	e3a03000 	mov	r3, #0
    8b88:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:96 (discriminator 3)
    8b8c:	e51b2008 	ldr	r2, [fp, #-8]
    8b90:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8b94:	e1520003 	cmp	r2, r3
    8b98:	aa000008 	bge	8bc0 <_Z5bzeroPvi+0x58>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:97 (discriminator 2)
		mem[i] = 0;
    8b9c:	e51b3008 	ldr	r3, [fp, #-8]
    8ba0:	e51b200c 	ldr	r2, [fp, #-12]
    8ba4:	e0823003 	add	r3, r2, r3
    8ba8:	e3a02000 	mov	r2, #0
    8bac:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:96 (discriminator 2)
	for (int i = 0; i < length; i++)
    8bb0:	e51b3008 	ldr	r3, [fp, #-8]
    8bb4:	e2833001 	add	r3, r3, #1
    8bb8:	e50b3008 	str	r3, [fp, #-8]
    8bbc:	eafffff2 	b	8b8c <_Z5bzeroPvi+0x24>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:98
}
    8bc0:	e320f000 	nop	{0}
    8bc4:	e28bd000 	add	sp, fp, #0
    8bc8:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8bcc:	e12fff1e 	bx	lr

00008bd0 <_Z6memcpyPKvPvi>:
_Z6memcpyPKvPvi():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:101

void memcpy(const void* src, void* dst, int num)
{
    8bd0:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8bd4:	e28db000 	add	fp, sp, #0
    8bd8:	e24dd024 	sub	sp, sp, #36	; 0x24
    8bdc:	e50b0018 	str	r0, [fp, #-24]	; 0xffffffe8
    8be0:	e50b101c 	str	r1, [fp, #-28]	; 0xffffffe4
    8be4:	e50b2020 	str	r2, [fp, #-32]	; 0xffffffe0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:102
	const char* memsrc = reinterpret_cast<const char*>(src);
    8be8:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8bec:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:103
	char* memdst = reinterpret_cast<char*>(dst);
    8bf0:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    8bf4:	e50b3010 	str	r3, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:105

	for (int i = 0; i < num; i++)
    8bf8:	e3a03000 	mov	r3, #0
    8bfc:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:105 (discriminator 3)
    8c00:	e51b2008 	ldr	r2, [fp, #-8]
    8c04:	e51b3020 	ldr	r3, [fp, #-32]	; 0xffffffe0
    8c08:	e1520003 	cmp	r2, r3
    8c0c:	aa00000b 	bge	8c40 <_Z6memcpyPKvPvi+0x70>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:106 (discriminator 2)
		memdst[i] = memsrc[i];
    8c10:	e51b3008 	ldr	r3, [fp, #-8]
    8c14:	e51b200c 	ldr	r2, [fp, #-12]
    8c18:	e0822003 	add	r2, r2, r3
    8c1c:	e51b3008 	ldr	r3, [fp, #-8]
    8c20:	e51b1010 	ldr	r1, [fp, #-16]
    8c24:	e0813003 	add	r3, r1, r3
    8c28:	e5d22000 	ldrb	r2, [r2]
    8c2c:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:105 (discriminator 2)
	for (int i = 0; i < num; i++)
    8c30:	e51b3008 	ldr	r3, [fp, #-8]
    8c34:	e2833001 	add	r3, r3, #1
    8c38:	e50b3008 	str	r3, [fp, #-8]
    8c3c:	eaffffef 	b	8c00 <_Z6memcpyPKvPvi+0x30>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:107
}
    8c40:	e320f000 	nop	{0}
    8c44:	e28bd000 	add	sp, fp, #0
    8c48:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8c4c:	e12fff1e 	bx	lr

00008c50 <__udivsi3>:
__udivsi3():
    8c50:	e2512001 	subs	r2, r1, #1
    8c54:	012fff1e 	bxeq	lr
    8c58:	3a000074 	bcc	8e30 <__udivsi3+0x1e0>
    8c5c:	e1500001 	cmp	r0, r1
    8c60:	9a00006b 	bls	8e14 <__udivsi3+0x1c4>
    8c64:	e1110002 	tst	r1, r2
    8c68:	0a00006c 	beq	8e20 <__udivsi3+0x1d0>
    8c6c:	e16f3f10 	clz	r3, r0
    8c70:	e16f2f11 	clz	r2, r1
    8c74:	e0423003 	sub	r3, r2, r3
    8c78:	e273301f 	rsbs	r3, r3, #31
    8c7c:	10833083 	addne	r3, r3, r3, lsl #1
    8c80:	e3a02000 	mov	r2, #0
    8c84:	108ff103 	addne	pc, pc, r3, lsl #2
    8c88:	e1a00000 	nop			; (mov r0, r0)
    8c8c:	e1500f81 	cmp	r0, r1, lsl #31
    8c90:	e0a22002 	adc	r2, r2, r2
    8c94:	20400f81 	subcs	r0, r0, r1, lsl #31
    8c98:	e1500f01 	cmp	r0, r1, lsl #30
    8c9c:	e0a22002 	adc	r2, r2, r2
    8ca0:	20400f01 	subcs	r0, r0, r1, lsl #30
    8ca4:	e1500e81 	cmp	r0, r1, lsl #29
    8ca8:	e0a22002 	adc	r2, r2, r2
    8cac:	20400e81 	subcs	r0, r0, r1, lsl #29
    8cb0:	e1500e01 	cmp	r0, r1, lsl #28
    8cb4:	e0a22002 	adc	r2, r2, r2
    8cb8:	20400e01 	subcs	r0, r0, r1, lsl #28
    8cbc:	e1500d81 	cmp	r0, r1, lsl #27
    8cc0:	e0a22002 	adc	r2, r2, r2
    8cc4:	20400d81 	subcs	r0, r0, r1, lsl #27
    8cc8:	e1500d01 	cmp	r0, r1, lsl #26
    8ccc:	e0a22002 	adc	r2, r2, r2
    8cd0:	20400d01 	subcs	r0, r0, r1, lsl #26
    8cd4:	e1500c81 	cmp	r0, r1, lsl #25
    8cd8:	e0a22002 	adc	r2, r2, r2
    8cdc:	20400c81 	subcs	r0, r0, r1, lsl #25
    8ce0:	e1500c01 	cmp	r0, r1, lsl #24
    8ce4:	e0a22002 	adc	r2, r2, r2
    8ce8:	20400c01 	subcs	r0, r0, r1, lsl #24
    8cec:	e1500b81 	cmp	r0, r1, lsl #23
    8cf0:	e0a22002 	adc	r2, r2, r2
    8cf4:	20400b81 	subcs	r0, r0, r1, lsl #23
    8cf8:	e1500b01 	cmp	r0, r1, lsl #22
    8cfc:	e0a22002 	adc	r2, r2, r2
    8d00:	20400b01 	subcs	r0, r0, r1, lsl #22
    8d04:	e1500a81 	cmp	r0, r1, lsl #21
    8d08:	e0a22002 	adc	r2, r2, r2
    8d0c:	20400a81 	subcs	r0, r0, r1, lsl #21
    8d10:	e1500a01 	cmp	r0, r1, lsl #20
    8d14:	e0a22002 	adc	r2, r2, r2
    8d18:	20400a01 	subcs	r0, r0, r1, lsl #20
    8d1c:	e1500981 	cmp	r0, r1, lsl #19
    8d20:	e0a22002 	adc	r2, r2, r2
    8d24:	20400981 	subcs	r0, r0, r1, lsl #19
    8d28:	e1500901 	cmp	r0, r1, lsl #18
    8d2c:	e0a22002 	adc	r2, r2, r2
    8d30:	20400901 	subcs	r0, r0, r1, lsl #18
    8d34:	e1500881 	cmp	r0, r1, lsl #17
    8d38:	e0a22002 	adc	r2, r2, r2
    8d3c:	20400881 	subcs	r0, r0, r1, lsl #17
    8d40:	e1500801 	cmp	r0, r1, lsl #16
    8d44:	e0a22002 	adc	r2, r2, r2
    8d48:	20400801 	subcs	r0, r0, r1, lsl #16
    8d4c:	e1500781 	cmp	r0, r1, lsl #15
    8d50:	e0a22002 	adc	r2, r2, r2
    8d54:	20400781 	subcs	r0, r0, r1, lsl #15
    8d58:	e1500701 	cmp	r0, r1, lsl #14
    8d5c:	e0a22002 	adc	r2, r2, r2
    8d60:	20400701 	subcs	r0, r0, r1, lsl #14
    8d64:	e1500681 	cmp	r0, r1, lsl #13
    8d68:	e0a22002 	adc	r2, r2, r2
    8d6c:	20400681 	subcs	r0, r0, r1, lsl #13
    8d70:	e1500601 	cmp	r0, r1, lsl #12
    8d74:	e0a22002 	adc	r2, r2, r2
    8d78:	20400601 	subcs	r0, r0, r1, lsl #12
    8d7c:	e1500581 	cmp	r0, r1, lsl #11
    8d80:	e0a22002 	adc	r2, r2, r2
    8d84:	20400581 	subcs	r0, r0, r1, lsl #11
    8d88:	e1500501 	cmp	r0, r1, lsl #10
    8d8c:	e0a22002 	adc	r2, r2, r2
    8d90:	20400501 	subcs	r0, r0, r1, lsl #10
    8d94:	e1500481 	cmp	r0, r1, lsl #9
    8d98:	e0a22002 	adc	r2, r2, r2
    8d9c:	20400481 	subcs	r0, r0, r1, lsl #9
    8da0:	e1500401 	cmp	r0, r1, lsl #8
    8da4:	e0a22002 	adc	r2, r2, r2
    8da8:	20400401 	subcs	r0, r0, r1, lsl #8
    8dac:	e1500381 	cmp	r0, r1, lsl #7
    8db0:	e0a22002 	adc	r2, r2, r2
    8db4:	20400381 	subcs	r0, r0, r1, lsl #7
    8db8:	e1500301 	cmp	r0, r1, lsl #6
    8dbc:	e0a22002 	adc	r2, r2, r2
    8dc0:	20400301 	subcs	r0, r0, r1, lsl #6
    8dc4:	e1500281 	cmp	r0, r1, lsl #5
    8dc8:	e0a22002 	adc	r2, r2, r2
    8dcc:	20400281 	subcs	r0, r0, r1, lsl #5
    8dd0:	e1500201 	cmp	r0, r1, lsl #4
    8dd4:	e0a22002 	adc	r2, r2, r2
    8dd8:	20400201 	subcs	r0, r0, r1, lsl #4
    8ddc:	e1500181 	cmp	r0, r1, lsl #3
    8de0:	e0a22002 	adc	r2, r2, r2
    8de4:	20400181 	subcs	r0, r0, r1, lsl #3
    8de8:	e1500101 	cmp	r0, r1, lsl #2
    8dec:	e0a22002 	adc	r2, r2, r2
    8df0:	20400101 	subcs	r0, r0, r1, lsl #2
    8df4:	e1500081 	cmp	r0, r1, lsl #1
    8df8:	e0a22002 	adc	r2, r2, r2
    8dfc:	20400081 	subcs	r0, r0, r1, lsl #1
    8e00:	e1500001 	cmp	r0, r1
    8e04:	e0a22002 	adc	r2, r2, r2
    8e08:	20400001 	subcs	r0, r0, r1
    8e0c:	e1a00002 	mov	r0, r2
    8e10:	e12fff1e 	bx	lr
    8e14:	03a00001 	moveq	r0, #1
    8e18:	13a00000 	movne	r0, #0
    8e1c:	e12fff1e 	bx	lr
    8e20:	e16f2f11 	clz	r2, r1
    8e24:	e262201f 	rsb	r2, r2, #31
    8e28:	e1a00230 	lsr	r0, r0, r2
    8e2c:	e12fff1e 	bx	lr
    8e30:	e3500000 	cmp	r0, #0
    8e34:	13e00000 	mvnne	r0, #0
    8e38:	ea000007 	b	8e5c <__aeabi_idiv0>

00008e3c <__aeabi_uidivmod>:
__aeabi_uidivmod():
    8e3c:	e3510000 	cmp	r1, #0
    8e40:	0afffffa 	beq	8e30 <__udivsi3+0x1e0>
    8e44:	e92d4003 	push	{r0, r1, lr}
    8e48:	ebffff80 	bl	8c50 <__udivsi3>
    8e4c:	e8bd4006 	pop	{r1, r2, lr}
    8e50:	e0030092 	mul	r3, r2, r0
    8e54:	e0411003 	sub	r1, r1, r3
    8e58:	e12fff1e 	bx	lr

00008e5c <__aeabi_idiv0>:
__aeabi_ldiv0():
    8e5c:	e12fff1e 	bx	lr

Disassembly of section .rodata:

00008e60 <_ZL13Lock_Unlocked>:
    8e60:	00000000 	andeq	r0, r0, r0

00008e64 <_ZL11Lock_Locked>:
    8e64:	00000001 	andeq	r0, r0, r1

00008e68 <_ZL21MaxFSDriverNameLength>:
    8e68:	00000010 	andeq	r0, r0, r0, lsl r0

00008e6c <_ZL17MaxFilenameLength>:
    8e6c:	00000010 	andeq	r0, r0, r0, lsl r0

00008e70 <_ZL13MaxPathLength>:
    8e70:	00000080 	andeq	r0, r0, r0, lsl #1

00008e74 <_ZL18NoFilesystemDriver>:
    8e74:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008e78 <_ZL9NotifyAll>:
    8e78:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008e7c <_ZL24Max_Process_Opened_Files>:
    8e7c:	00000010 	andeq	r0, r0, r0, lsl r0

00008e80 <_ZL10Indefinite>:
    8e80:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008e84 <_ZL18Deadline_Unchanged>:
    8e84:	fffffffe 			; <UNDEFINED> instruction: 0xfffffffe

00008e88 <_ZL14Invalid_Handle>:
    8e88:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008e8c <_ZN3halL18Default_Clock_RateE>:
    8e8c:	0ee6b280 	cdpeq	2, 14, cr11, cr6, cr0, {4}

00008e90 <_ZN3halL15Peripheral_BaseE>:
    8e90:	20000000 	andcs	r0, r0, r0

00008e94 <_ZN3halL9GPIO_BaseE>:
    8e94:	20200000 	eorcs	r0, r0, r0

00008e98 <_ZN3halL14GPIO_Pin_CountE>:
    8e98:	00000036 	andeq	r0, r0, r6, lsr r0

00008e9c <_ZN3halL8AUX_BaseE>:
    8e9c:	20215000 	eorcs	r5, r1, r0

00008ea0 <_ZN3halL25Interrupt_Controller_BaseE>:
    8ea0:	2000b200 	andcs	fp, r0, r0, lsl #4

00008ea4 <_ZN3halL10Timer_BaseE>:
    8ea4:	2000b400 	andcs	fp, r0, r0, lsl #8

00008ea8 <_ZN3halL9TRNG_BaseE>:
    8ea8:	20104000 	andscs	r4, r0, r0

00008eac <_ZN3halL9BSC0_BaseE>:
    8eac:	20205000 	eorcs	r5, r0, r0

00008eb0 <_ZN3halL9BSC1_BaseE>:
    8eb0:	20804000 	addcs	r4, r0, r0

00008eb4 <_ZN3halL9BSC2_BaseE>:
    8eb4:	20805000 	addcs	r5, r0, r0

00008eb8 <_ZN3halL14I2C_SLAVE_BaseE>:
    8eb8:	20214000 	eorcs	r4, r1, r0

00008ebc <_ZL11Invalid_Pin>:
    8ebc:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008ec0 <_ZL24I2C_Transaction_Max_Size>:
    8ec0:	00000008 	andeq	r0, r0, r8

00008ec4 <_ZL17symbol_tick_delay>:
    8ec4:	00000400 	andeq	r0, r0, r0, lsl #8

00008ec8 <_ZL15char_tick_delay>:
    8ec8:	00001000 	andeq	r1, r0, r0
    8ecc:	00000031 	andeq	r0, r0, r1, lsr r0
    8ed0:	00000030 	andeq	r0, r0, r0, lsr r0
    8ed4:	00676f6c 	rsbeq	r6, r7, ip, ror #30
    8ed8:	7473614d 	ldrbtvc	r6, [r3], #-333	; 0xfffffeb3
    8edc:	74207265 	strtvc	r7, [r0], #-613	; 0xfffffd9b
    8ee0:	206b7361 	rsbcs	r7, fp, r1, ror #6
    8ee4:	72617473 	rsbvc	r7, r1, #1929379840	; 0x73000000
    8ee8:	0a646574 	beq	19224c0 <__bss_end+0x1919520>
    8eec:	00000000 	andeq	r0, r0, r0
    8ef0:	3a564544 	bcc	159a408 <__bss_end+0x1591468>
    8ef4:	2f633269 	svccs	0x00633269
    8ef8:	00000031 	andeq	r0, r0, r1, lsr r0
    8efc:	20433249 	subcs	r3, r3, r9, asr #4
    8f00:	6e6e6f63 	cdpvs	15, 6, cr6, cr14, cr3, {3}
    8f04:	69746365 	ldmdbvs	r4!, {r0, r2, r5, r6, r8, r9, sp, lr}^
    8f08:	6d206e6f 	stcvs	14, cr6, [r0, #-444]!	; 0xfffffe44
    8f0c:	65747361 	ldrbvs	r7, [r4, #-865]!	; 0xfffffc9f
    8f10:	74732072 	ldrbtvc	r2, [r3], #-114	; 0xffffff8e
    8f14:	65747261 	ldrbvs	r7, [r4, #-609]!	; 0xfffffd9f
    8f18:	2e2e2e64 	cdpcs	14, 2, cr2, cr14, cr4, {3}
    8f1c:	0000000a 	andeq	r0, r0, sl
    8f20:	6c6c6548 	cfstr64vs	mvdx6, [ip], #-288	; 0xfffffee0
    8f24:	7266206f 	rsbvc	r2, r6, #111	; 0x6f
    8f28:	6d206d6f 	stcvs	13, cr6, [r0, #-444]!	; 0xfffffe44
    8f2c:	65747361 	ldrbvs	r7, [r4, #-865]!	; 0xfffffc9f
    8f30:	00000a72 	andeq	r0, r0, r2, ror sl

00008f34 <_ZL13Lock_Unlocked>:
    8f34:	00000000 	andeq	r0, r0, r0

00008f38 <_ZL11Lock_Locked>:
    8f38:	00000001 	andeq	r0, r0, r1

00008f3c <_ZL21MaxFSDriverNameLength>:
    8f3c:	00000010 	andeq	r0, r0, r0, lsl r0

00008f40 <_ZL17MaxFilenameLength>:
    8f40:	00000010 	andeq	r0, r0, r0, lsl r0

00008f44 <_ZL13MaxPathLength>:
    8f44:	00000080 	andeq	r0, r0, r0, lsl #1

00008f48 <_ZL18NoFilesystemDriver>:
    8f48:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008f4c <_ZL9NotifyAll>:
    8f4c:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008f50 <_ZL24Max_Process_Opened_Files>:
    8f50:	00000010 	andeq	r0, r0, r0, lsl r0

00008f54 <_ZL10Indefinite>:
    8f54:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008f58 <_ZL18Deadline_Unchanged>:
    8f58:	fffffffe 			; <UNDEFINED> instruction: 0xfffffffe

00008f5c <_ZL14Invalid_Handle>:
    8f5c:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008f60 <_ZL16Pipe_File_Prefix>:
    8f60:	3a535953 	bcc	14df4b4 <__bss_end+0x14d6514>
    8f64:	65706970 	ldrbvs	r6, [r0, #-2416]!	; 0xfffff690
    8f68:	0000002f 	andeq	r0, r0, pc, lsr #32

00008f6c <_ZN12_GLOBAL__N_1L11CharConvArrE>:
    8f6c:	33323130 	teqcc	r2, #48, 2
    8f70:	37363534 			; <UNDEFINED> instruction: 0x37363534
    8f74:	42413938 	submi	r3, r1, #56, 18	; 0xe0000
    8f78:	46454443 	strbmi	r4, [r5], -r3, asr #8
	...

Disassembly of section .bss:

00008f80 <led>:
__bss_start():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:17
uint32_t led, uart, master, log;
    8f80:	00000000 	andeq	r0, r0, r0

00008f84 <uart>:
    8f84:	00000000 	andeq	r0, r0, r0

00008f88 <master>:
    8f88:	00000000 	andeq	r0, r0, r0

00008f8c <log>:
	...

Disassembly of section .ARM.attributes:

00000000 <.ARM.attributes>:
   0:	00002e41 	andeq	r2, r0, r1, asr #28
   4:	61656100 	cmnvs	r5, r0, lsl #2
   8:	01006962 	tsteq	r0, r2, ror #18
   c:	00000024 	andeq	r0, r0, r4, lsr #32
  10:	4b5a3605 	blmi	168d82c <__bss_end+0x168488c>
  14:	08070600 	stmdaeq	r7, {r9, sl}
  18:	0a010901 	beq	42424 <__bss_end+0x39484>
  1c:	14041202 	strne	r1, [r4], #-514	; 0xfffffdfe
  20:	17011501 	strne	r1, [r1, -r1, lsl #10]
  24:	1a011803 	bne	46038 <__bss_end+0x3d098>
  28:	22011c01 	andcs	r1, r1, #256	; 0x100
  2c:	Address 0x000000000000002c is out of bounds.


Disassembly of section .comment:

00000000 <.comment>:
   0:	3a434347 	bcc	10d0d24 <__bss_end+0x10c7d84>
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
  38:	7a617661 	bvc	185d9c4 <__bss_end+0x1854a24>
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
  c0:	6a757a61 	bvs	1d5ea4c <__bss_end+0x1d55aac>
  c4:	2f696369 	svccs	0x00696369
  c8:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
  cc:	73656d65 	cmnvc	r5, #6464	; 0x1940
  d0:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
  d4:	6b2d616b 	blvs	b58688 <__bss_end+0xb4f6e8>
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
 144:	fb010200 	blx	4094e <__bss_end+0x379ae>
 148:	01000d0e 	tsteq	r0, lr, lsl #26
 14c:	00010101 	andeq	r0, r1, r1, lsl #2
 150:	00010000 	andeq	r0, r1, r0
 154:	552f0100 	strpl	r0, [pc, #-256]!	; 5c <shift+0x5c>
 158:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 15c:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 160:	6a726574 	bvs	1c99738 <__bss_end+0x1c90798>
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
 198:	752f7365 	strvc	r7, [pc, #-869]!	; fffffe3b <__bss_end+0xffff6e9b>
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
 1d0:	0a05830b 	beq	160e04 <__bss_end+0x157e64>
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
 1fc:	4a030402 	bmi	c120c <__bss_end+0xb826c>
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
 230:	4a020402 	bmi	81240 <__bss_end+0x782a0>
 234:	02000205 	andeq	r0, r0, #1342177280	; 0x50000000
 238:	052d0204 	streq	r0, [sp, #-516]!	; 0xfffffdfc
 23c:	01058509 	tsteq	r5, r9, lsl #10
 240:	000a022f 	andeq	r0, sl, pc, lsr #4
 244:	02dc0101 	sbcseq	r0, ip, #1073741824	; 0x40000000
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
 280:	6a757a61 	bvs	1d5ec0c <__bss_end+0x1d55c6c>
 284:	2f696369 	svccs	0x00696369
 288:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
 28c:	73656d65 	cmnvc	r5, #6464	; 0x1940
 290:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
 294:	6b2d616b 	blvs	b58848 <__bss_end+0xb4f8a8>
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
 2cc:	6b736544 	blvs	1cd97e4 <__bss_end+0x1cd0844>
 2d0:	2f706f74 	svccs	0x00706f74
 2d4:	2f564146 	svccs	0x00564146
 2d8:	6176614e 	cmnvs	r6, lr, asr #2
 2dc:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
 2e0:	4f2f6963 	svcmi	0x002f6963
 2e4:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
 2e8:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
 2ec:	6b6c6172 	blvs	1b188bc <__bss_end+0x1b0f91c>
 2f0:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
 2f4:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
 2f8:	756f732f 	strbvc	r7, [pc, #-815]!	; ffffffd1 <__bss_end+0xffff7031>
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
 344:	6a757a61 	bvs	1d5ecd0 <__bss_end+0x1d55d30>
 348:	2f696369 	svccs	0x00696369
 34c:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
 350:	73656d65 	cmnvc	r5, #6464	; 0x1940
 354:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
 358:	6b2d616b 	blvs	b5890c <__bss_end+0xb4f96c>
 35c:	6f2d7669 	svcvs	0x002d7669
 360:	6f732f73 	svcvs	0x00732f73
 364:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
 368:	73752f73 	cmnvc	r5, #460	; 0x1cc
 36c:	70737265 	rsbsvc	r7, r3, r5, ror #4
 370:	2f656361 	svccs	0x00656361
 374:	6b2f2e2e 	blvs	bcbc34 <__bss_end+0xbc2c94>
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
 3a8:	6a757a61 	bvs	1d5ed34 <__bss_end+0x1d55d94>
 3ac:	2f696369 	svccs	0x00696369
 3b0:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
 3b4:	73656d65 	cmnvc	r5, #6464	; 0x1940
 3b8:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
 3bc:	6b2d616b 	blvs	b58970 <__bss_end+0xb4f9d0>
 3c0:	6f2d7669 	svcvs	0x002d7669
 3c4:	6f732f73 	svcvs	0x00732f73
 3c8:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
 3cc:	73752f73 	cmnvc	r5, #460	; 0x1cc
 3d0:	70737265 	rsbsvc	r7, r3, r5, ror #4
 3d4:	2f656361 	svccs	0x00656361
 3d8:	6b2f2e2e 	blvs	bcbc98 <__bss_end+0xbc2cf8>
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
 418:	6a757a61 	bvs	1d5eda4 <__bss_end+0x1d55e04>
 41c:	2f696369 	svccs	0x00696369
 420:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
 424:	73656d65 	cmnvc	r5, #6464	; 0x1940
 428:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
 42c:	6b2d616b 	blvs	b589e0 <__bss_end+0xb4fa40>
 430:	6f2d7669 	svcvs	0x002d7669
 434:	6f732f73 	svcvs	0x00732f73
 438:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
 43c:	73752f73 	cmnvc	r5, #460	; 0x1cc
 440:	70737265 	rsbsvc	r7, r3, r5, ror #4
 444:	2f656361 	svccs	0x00656361
 448:	6b2f2e2e 	blvs	bcbd08 <__bss_end+0xbc2d68>
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
 47c:	6b636f6c 	blvs	18dc234 <__bss_end+0x18d3294>
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
 4f4:	4b070501 	blmi	1c1900 <__bss_end+0x1b8960>
 4f8:	010567bb 			; <UNDEFINED> instruction: 0x010567bb
 4fc:	0f05a1bb 	svceq	0x0005a1bb
 500:	820905a1 	andhi	r0, r9, #675282944	; 0x28400000
 504:	054d0a05 	strbeq	r0, [sp, #-2565]	; 0xfffff5fb
 508:	0c05bd12 	stceq	13, cr11, [r5], {18}
 50c:	4b0a0582 	blmi	281b1c <__bss_end+0x278b7c>
 510:	02000e05 	andeq	r0, r0, #5, 28	; 0x50
 514:	00bc0104 	adcseq	r0, ip, r4, lsl #2
 518:	bb010402 	bllt	41528 <__bss_end+0x38588>
 51c:	01040200 	mrseq	r0, R12_usr
 520:	00100265 	andseq	r0, r0, r5, ror #4
 524:	02c80101 	sbceq	r0, r8, #1073741824	; 0x40000000
 528:	00030000 	andeq	r0, r3, r0
 52c:	000001dd 	ldrdeq	r0, [r0], -sp
 530:	0efb0102 	cdpeq	1, 15, cr0, cr11, cr2, {0}
 534:	0101000d 	tsteq	r1, sp
 538:	00000101 	andeq	r0, r0, r1, lsl #2
 53c:	00000100 	andeq	r0, r0, r0, lsl #2
 540:	73552f01 	cmpvc	r5, #1, 30
 544:	2f737265 	svccs	0x00737265
 548:	746e6977 	strbtvc	r6, [lr], #-2423	; 0xfffff689
 54c:	696a7265 	stmdbvs	sl!, {r0, r2, r5, r6, r9, ip, sp, lr}^
 550:	7365442f 	cmnvc	r5, #788529152	; 0x2f000000
 554:	706f746b 	rsbvc	r7, pc, fp, ror #8
 558:	5641462f 	strbpl	r4, [r1], -pc, lsr #12
 55c:	76614e2f 	strbtvc	r4, [r1], -pc, lsr #28
 560:	6a757a61 	bvs	1d5eeec <__bss_end+0x1d55f4c>
 564:	2f696369 	svccs	0x00696369
 568:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
 56c:	73656d65 	cmnvc	r5, #6464	; 0x1940
 570:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
 574:	6b2d616b 	blvs	b58b28 <__bss_end+0xb4fb88>
 578:	6f2d7669 	svcvs	0x002d7669
 57c:	6f732f73 	svcvs	0x00732f73
 580:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
 584:	74732f73 	ldrbtvc	r2, [r3], #-3955	; 0xfffff08d
 588:	62696c64 	rsbvs	r6, r9, #100, 24	; 0x6400
 58c:	6372732f 	cmnvs	r2, #-1140850688	; 0xbc000000
 590:	73552f00 	cmpvc	r5, #0, 30
 594:	2f737265 	svccs	0x00737265
 598:	746e6977 	strbtvc	r6, [lr], #-2423	; 0xfffff689
 59c:	696a7265 	stmdbvs	sl!, {r0, r2, r5, r6, r9, ip, sp, lr}^
 5a0:	7365442f 	cmnvc	r5, #788529152	; 0x2f000000
 5a4:	706f746b 	rsbvc	r7, pc, fp, ror #8
 5a8:	5641462f 	strbpl	r4, [r1], -pc, lsr #12
 5ac:	76614e2f 	strbtvc	r4, [r1], -pc, lsr #28
 5b0:	6a757a61 	bvs	1d5ef3c <__bss_end+0x1d55f9c>
 5b4:	2f696369 	svccs	0x00696369
 5b8:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
 5bc:	73656d65 	cmnvc	r5, #6464	; 0x1940
 5c0:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
 5c4:	6b2d616b 	blvs	b58b78 <__bss_end+0xb4fbd8>
 5c8:	6f2d7669 	svcvs	0x002d7669
 5cc:	6f732f73 	svcvs	0x00732f73
 5d0:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
 5d4:	656b2f73 	strbvs	r2, [fp, #-3955]!	; 0xfffff08d
 5d8:	6c656e72 	stclvs	14, cr6, [r5], #-456	; 0xfffffe38
 5dc:	636e692f 	cmnvs	lr, #770048	; 0xbc000
 5e0:	6564756c 	strbvs	r7, [r4, #-1388]!	; 0xfffffa94
 5e4:	6f72702f 	svcvs	0x0072702f
 5e8:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
 5ec:	73552f00 	cmpvc	r5, #0, 30
 5f0:	2f737265 	svccs	0x00737265
 5f4:	746e6977 	strbtvc	r6, [lr], #-2423	; 0xfffff689
 5f8:	696a7265 	stmdbvs	sl!, {r0, r2, r5, r6, r9, ip, sp, lr}^
 5fc:	7365442f 	cmnvc	r5, #788529152	; 0x2f000000
 600:	706f746b 	rsbvc	r7, pc, fp, ror #8
 604:	5641462f 	strbpl	r4, [r1], -pc, lsr #12
 608:	76614e2f 	strbtvc	r4, [r1], -pc, lsr #28
 60c:	6a757a61 	bvs	1d5ef98 <__bss_end+0x1d55ff8>
 610:	2f696369 	svccs	0x00696369
 614:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
 618:	73656d65 	cmnvc	r5, #6464	; 0x1940
 61c:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
 620:	6b2d616b 	blvs	b58bd4 <__bss_end+0xb4fc34>
 624:	6f2d7669 	svcvs	0x002d7669
 628:	6f732f73 	svcvs	0x00732f73
 62c:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
 630:	656b2f73 	strbvs	r2, [fp, #-3955]!	; 0xfffff08d
 634:	6c656e72 	stclvs	14, cr6, [r5], #-456	; 0xfffffe38
 638:	636e692f 	cmnvs	lr, #770048	; 0xbc000
 63c:	6564756c 	strbvs	r7, [r4, #-1388]!	; 0xfffffa94
 640:	0073662f 	rsbseq	r6, r3, pc, lsr #12
 644:	6573552f 	ldrbvs	r5, [r3, #-1327]!	; 0xfffffad1
 648:	772f7372 			; <UNDEFINED> instruction: 0x772f7372
 64c:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
 650:	2f696a72 	svccs	0x00696a72
 654:	6b736544 	blvs	1cd9b6c <__bss_end+0x1cd0bcc>
 658:	2f706f74 	svccs	0x00706f74
 65c:	2f564146 	svccs	0x00564146
 660:	6176614e 	cmnvs	r6, lr, asr #2
 664:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
 668:	4f2f6963 	svcmi	0x002f6963
 66c:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
 670:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
 674:	6b6c6172 	blvs	1b18c44 <__bss_end+0x1b0fca4>
 678:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
 67c:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
 680:	756f732f 	strbvc	r7, [pc, #-815]!	; 359 <shift+0x359>
 684:	73656372 	cmnvc	r5, #-939524095	; 0xc8000001
 688:	72656b2f 	rsbvc	r6, r5, #48128	; 0xbc00
 68c:	2f6c656e 	svccs	0x006c656e
 690:	6c636e69 	stclvs	14, cr6, [r3], #-420	; 0xfffffe5c
 694:	2f656475 	svccs	0x00656475
 698:	72616f62 	rsbvc	r6, r1, #392	; 0x188
 69c:	70722f64 	rsbsvc	r2, r2, r4, ror #30
 6a0:	682f3069 	stmdavs	pc!, {r0, r3, r5, r6, ip, sp}	; <UNPREDICTABLE>
 6a4:	00006c61 	andeq	r6, r0, r1, ror #24
 6a8:	66647473 			; <UNDEFINED> instruction: 0x66647473
 6ac:	2e656c69 	cdpcs	12, 6, cr6, cr5, cr9, {3}
 6b0:	00707063 	rsbseq	r7, r0, r3, rrx
 6b4:	73000001 	movwvc	r0, #1
 6b8:	682e6977 	stmdavs	lr!, {r0, r1, r2, r4, r5, r6, r8, fp, sp, lr}
 6bc:	00000200 	andeq	r0, r0, r0, lsl #4
 6c0:	6e697073 	mcrvs	0, 3, r7, cr9, cr3, {3}
 6c4:	6b636f6c 	blvs	18dc47c <__bss_end+0x18d34dc>
 6c8:	0200682e 	andeq	r6, r0, #3014656	; 0x2e0000
 6cc:	69660000 	stmdbvs	r6!, {}^	; <UNPREDICTABLE>
 6d0:	7973656c 	ldmdbvc	r3!, {r2, r3, r5, r6, r8, sl, sp, lr}^
 6d4:	6d657473 	cfstrdvs	mvd7, [r5, #-460]!	; 0xfffffe34
 6d8:	0300682e 	movweq	r6, #2094	; 0x82e
 6dc:	72700000 	rsbsvc	r0, r0, #0
 6e0:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
 6e4:	00682e73 	rsbeq	r2, r8, r3, ror lr
 6e8:	70000002 	andvc	r0, r0, r2
 6ec:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
 6f0:	6d5f7373 	ldclvs	3, cr7, [pc, #-460]	; 52c <shift+0x52c>
 6f4:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
 6f8:	682e7265 	stmdavs	lr!, {r0, r2, r5, r6, r9, ip, sp, lr}
 6fc:	00000200 	andeq	r0, r0, r0, lsl #4
 700:	64746e69 	ldrbtvs	r6, [r4], #-3689	; 0xfffff197
 704:	682e6665 	stmdavs	lr!, {r0, r2, r5, r6, r9, sl, sp, lr}
 708:	00000400 	andeq	r0, r0, r0, lsl #8
 70c:	00010500 	andeq	r0, r1, r0, lsl #10
 710:	833c0205 	teqhi	ip, #1342177280	; 0x50000000
 714:	05160000 	ldreq	r0, [r6, #-0]
 718:	052f6905 	streq	r6, [pc, #-2309]!	; fffffe1b <__bss_end+0xffff6e7b>
 71c:	01054c0c 	tsteq	r5, ip, lsl #24
 720:	0505852f 	streq	r8, [r5, #-1327]	; 0xfffffad1
 724:	01054b83 	smlabbeq	r5, r3, fp, r4
 728:	0505852f 	streq	r8, [r5, #-1327]	; 0xfffffad1
 72c:	2f01054b 	svccs	0x0001054b
 730:	a1050585 	smlabbge	r5, r5, r5, r0
 734:	052f4b4b 	streq	r4, [pc, #-2891]!	; fffffbf1 <__bss_end+0xffff6c51>
 738:	01054c0c 	tsteq	r5, ip, lsl #24
 73c:	0505852f 	streq	r8, [r5, #-1327]	; 0xfffffad1
 740:	4b4b4bbd 	blmi	12d363c <__bss_end+0x12ca69c>
 744:	4c0c052f 	cfstr32mi	mvfx0, [ip], {47}	; 0x2f
 748:	852f0105 	strhi	r0, [pc, #-261]!	; 64b <shift+0x64b>
 74c:	4bbd0505 	blmi	fef41b68 <__bss_end+0xfef38bc8>
 750:	052f4b4b 	streq	r4, [pc, #-2891]!	; fffffc0d <__bss_end+0xffff6c6d>
 754:	01054c0c 	tsteq	r5, ip, lsl #24
 758:	0505852f 	streq	r8, [r5, #-1327]	; 0xfffffad1
 75c:	01054b83 	smlabbeq	r5, r3, fp, r4
 760:	0505852f 	streq	r8, [r5, #-1327]	; 0xfffffad1
 764:	4b4b4bbd 	blmi	12d3660 <__bss_end+0x12ca6c0>
 768:	4c0c052f 	cfstr32mi	mvfx0, [ip], {47}	; 0x2f
 76c:	852f0105 	strhi	r0, [pc, #-261]!	; 66f <shift+0x66f>
 770:	4ba10505 	blmi	fe841b8c <__bss_end+0xfe838bec>
 774:	0c052f4b 	stceq	15, cr2, [r5], {75}	; 0x4b
 778:	2f01054c 	svccs	0x0001054c
 77c:	bd050585 	cfstr32lt	mvfx0, [r5, #-532]	; 0xfffffdec
 780:	2f4b4b4b 	svccs	0x004b4b4b
 784:	054c0c05 	strbeq	r0, [ip, #-3077]	; 0xfffff3fb
 788:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 78c:	4b4ba105 	blmi	12e8ba8 <__bss_end+0x12dfc08>
 790:	4c0c052f 	cfstr32mi	mvfx0, [ip], {47}	; 0x2f
 794:	859f0105 	ldrhi	r0, [pc, #261]	; 8a1 <shift+0x8a1>
 798:	05672005 	strbeq	r2, [r7, #-5]!
 79c:	4b4b4d05 	blmi	12d3bb8 <__bss_end+0x12cac18>
 7a0:	05300c05 	ldreq	r0, [r0, #-3077]!	; 0xfffff3fb
 7a4:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 7a8:	05056720 	streq	r6, [r5, #-1824]	; 0xfffff8e0
 7ac:	054b4b4d 	strbeq	r4, [fp, #-2893]	; 0xfffff4b3
 7b0:	0105300c 	tsteq	r5, ip
 7b4:	2005852f 	andcs	r8, r5, pc, lsr #10
 7b8:	4c050583 	cfstr32mi	mvfx0, [r5], {131}	; 0x83
 7bc:	01054b4b 	tsteq	r5, fp, asr #22
 7c0:	2005852f 	andcs	r8, r5, pc, lsr #10
 7c4:	4d050567 	cfstr32mi	mvfx0, [r5, #-412]	; 0xfffffe64
 7c8:	0c054b4b 			; <UNDEFINED> instruction: 0x0c054b4b
 7cc:	2f010530 	svccs	0x00010530
 7d0:	a00c0587 	andge	r0, ip, r7, lsl #11
 7d4:	bc31059f 	cfldr32lt	mvfx0, [r1], #-636	; 0xfffffd84
 7d8:	05662905 	strbeq	r2, [r6, #-2309]!	; 0xfffff6fb
 7dc:	0f052e36 	svceq	0x00052e36
 7e0:	66130530 			; <UNDEFINED> instruction: 0x66130530
 7e4:	05840905 	streq	r0, [r4, #2309]	; 0x905
 7e8:	0105d810 	tsteq	r5, r0, lsl r8
 7ec:	0008029f 	muleq	r8, pc, r2	; <UNPREDICTABLE>
 7f0:	029b0101 	addseq	r0, fp, #1073741824	; 0x40000000
 7f4:	00030000 	andeq	r0, r3, r0
 7f8:	00000074 	andeq	r0, r0, r4, ror r0
 7fc:	0efb0102 	cdpeq	1, 15, cr0, cr11, cr2, {0}
 800:	0101000d 	tsteq	r1, sp
 804:	00000101 	andeq	r0, r0, r1, lsl #2
 808:	00000100 	andeq	r0, r0, r0, lsl #2
 80c:	73552f01 	cmpvc	r5, #1, 30
 810:	2f737265 	svccs	0x00737265
 814:	746e6977 	strbtvc	r6, [lr], #-2423	; 0xfffff689
 818:	696a7265 	stmdbvs	sl!, {r0, r2, r5, r6, r9, ip, sp, lr}^
 81c:	7365442f 	cmnvc	r5, #788529152	; 0x2f000000
 820:	706f746b 	rsbvc	r7, pc, fp, ror #8
 824:	5641462f 	strbpl	r4, [r1], -pc, lsr #12
 828:	76614e2f 	strbtvc	r4, [r1], -pc, lsr #28
 82c:	6a757a61 	bvs	1d5f1b8 <__bss_end+0x1d56218>
 830:	2f696369 	svccs	0x00696369
 834:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
 838:	73656d65 	cmnvc	r5, #6464	; 0x1940
 83c:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
 840:	6b2d616b 	blvs	b58df4 <__bss_end+0xb4fe54>
 844:	6f2d7669 	svcvs	0x002d7669
 848:	6f732f73 	svcvs	0x00732f73
 84c:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
 850:	74732f73 	ldrbtvc	r2, [r3], #-3955	; 0xfffff08d
 854:	62696c64 	rsbvs	r6, r9, #100, 24	; 0x6400
 858:	6372732f 	cmnvs	r2, #-1140850688	; 0xbc000000
 85c:	74730000 	ldrbtvc	r0, [r3], #-0
 860:	72747364 	rsbsvc	r7, r4, #100, 6	; 0x90000001
 864:	2e676e69 	cdpcs	14, 6, cr6, cr7, cr9, {3}
 868:	00707063 	rsbseq	r7, r0, r3, rrx
 86c:	00000001 	andeq	r0, r0, r1
 870:	05000105 	streq	r0, [r0, #-261]	; 0xfffffefb
 874:	00879802 	addeq	r9, r7, r2, lsl #16
 878:	06051a00 	streq	r1, [r5], -r0, lsl #20
 87c:	4c0f05bb 	cfstr32mi	mvfx0, [pc], {187}	; 0xbb
 880:	05682105 	strbeq	r2, [r8, #-261]!	; 0xfffffefb
 884:	0b05ba0a 	bleq	16f0b4 <__bss_end+0x166114>
 888:	4a27052e 	bmi	9c1d48 <__bss_end+0x9b8da8>
 88c:	054a0d05 	strbeq	r0, [sl, #-3333]	; 0xfffff2fb
 890:	04052f09 	streq	r2, [r5], #-3849	; 0xfffff0f7
 894:	6202059f 	andvs	r0, r2, #666894336	; 0x27c00000
 898:	05350505 	ldreq	r0, [r5, #-1285]!	; 0xfffffafb
 89c:	11056810 	tstne	r5, r0, lsl r8
 8a0:	4a22052e 	bmi	881d60 <__bss_end+0x878dc0>
 8a4:	052e1305 	streq	r1, [lr, #-773]!	; 0xfffffcfb
 8a8:	09052f0a 	stmdbeq	r5, {r1, r3, r8, r9, sl, fp, sp}
 8ac:	2e0a0569 	cfsh32cs	mvfx0, mvfx10, #57
 8b0:	054a0c05 	strbeq	r0, [sl, #-3077]	; 0xfffff3fb
 8b4:	0b054b03 	bleq	1534c8 <__bss_end+0x14a528>
 8b8:	00180568 	andseq	r0, r8, r8, ror #10
 8bc:	4a030402 	bmi	c18cc <__bss_end+0xb892c>
 8c0:	02001405 	andeq	r1, r0, #83886080	; 0x5000000
 8c4:	059e0304 	ldreq	r0, [lr, #772]	; 0x304
 8c8:	04020015 	streq	r0, [r2], #-21	; 0xffffffeb
 8cc:	18056802 	stmdane	r5, {r1, fp, sp, lr}
 8d0:	02040200 	andeq	r0, r4, #0, 4
 8d4:	00080582 	andeq	r0, r8, r2, lsl #11
 8d8:	4a020402 	bmi	818e8 <__bss_end+0x78948>
 8dc:	02001a05 	andeq	r1, r0, #20480	; 0x5000
 8e0:	054b0204 	strbeq	r0, [fp, #-516]	; 0xfffffdfc
 8e4:	0402001b 	streq	r0, [r2], #-27	; 0xffffffe5
 8e8:	0c052e02 	stceq	14, cr2, [r5], {2}
 8ec:	02040200 	andeq	r0, r4, #0, 4
 8f0:	000f054a 	andeq	r0, pc, sl, asr #10
 8f4:	82020402 	andhi	r0, r2, #33554432	; 0x2000000
 8f8:	02001b05 	andeq	r1, r0, #5120	; 0x1400
 8fc:	054a0204 	strbeq	r0, [sl, #-516]	; 0xfffffdfc
 900:	04020011 	streq	r0, [r2], #-17	; 0xffffffef
 904:	0a052e02 	beq	14c114 <__bss_end+0x143174>
 908:	02040200 	andeq	r0, r4, #0, 4
 90c:	000b052f 	andeq	r0, fp, pc, lsr #10
 910:	2e020402 	cdpcs	4, 0, cr0, cr2, cr2, {0}
 914:	02000d05 	andeq	r0, r0, #320	; 0x140
 918:	054a0204 	strbeq	r0, [sl, #-516]	; 0xfffffdfc
 91c:	04020002 	streq	r0, [r2], #-2
 920:	01054602 	tsteq	r5, r2, lsl #12
 924:	06058588 	streq	r8, [r5], -r8, lsl #11
 928:	4c090583 	cfstr32mi	mvfx0, [r9], {131}	; 0x83
 92c:	054a1005 	strbeq	r1, [sl, #-5]
 930:	07054c0a 	streq	r4, [r5, -sl, lsl #24]
 934:	4a0305bb 	bmi	c2028 <__bss_end+0xb9088>
 938:	02001705 	andeq	r1, r0, #1310720	; 0x140000
 93c:	054a0104 	strbeq	r0, [sl, #-260]	; 0xfffffefc
 940:	04020014 	streq	r0, [r2], #-20	; 0xffffffec
 944:	0d054a01 	vstreq	s8, [r5, #-4]
 948:	4a14054d 	bmi	501e84 <__bss_end+0x4f8ee4>
 94c:	052e0a05 	streq	r0, [lr, #-2565]!	; 0xfffff5fb
 950:	02056808 	andeq	r6, r5, #8, 16	; 0x80000
 954:	05667803 	strbeq	r7, [r6, #-2051]!	; 0xfffff7fd
 958:	2e0b0309 	cdpcs	3, 0, cr0, cr11, cr9, {0}
 95c:	852f0105 	strhi	r0, [pc, #-261]!	; 85f <shift+0x85f>
 960:	05bd0905 	ldreq	r0, [sp, #2309]!	; 0x905
 964:	04020016 	streq	r0, [r2], #-22	; 0xffffffea
 968:	1d054a04 	vstrne	s8, [r5, #-16]
 96c:	02040200 	andeq	r0, r4, #0, 4
 970:	001e0582 	andseq	r0, lr, r2, lsl #11
 974:	2e020402 	cdpcs	4, 0, cr0, cr2, cr2, {0}
 978:	02001605 	andeq	r1, r0, #5242880	; 0x500000
 97c:	05660204 	strbeq	r0, [r6, #-516]!	; 0xfffffdfc
 980:	04020011 	streq	r0, [r2], #-17	; 0xffffffef
 984:	12054b03 	andne	r4, r5, #3072	; 0xc00
 988:	03040200 	movweq	r0, #16896	; 0x4200
 98c:	0008052e 	andeq	r0, r8, lr, lsr #10
 990:	4a030402 	bmi	c19a0 <__bss_end+0xb8a00>
 994:	02000905 	andeq	r0, r0, #81920	; 0x14000
 998:	052e0304 	streq	r0, [lr, #-772]!	; 0xfffffcfc
 99c:	04020012 	streq	r0, [r2], #-18	; 0xffffffee
 9a0:	0b054a03 	bleq	1531b4 <__bss_end+0x14a214>
 9a4:	03040200 	movweq	r0, #16896	; 0x4200
 9a8:	0002052e 	andeq	r0, r2, lr, lsr #10
 9ac:	2d030402 	cfstrscs	mvf0, [r3, #-8]
 9b0:	02000b05 	andeq	r0, r0, #5120	; 0x1400
 9b4:	05840204 	streq	r0, [r4, #516]	; 0x204
 9b8:	04020008 	streq	r0, [r2], #-8
 9bc:	09058301 	stmdbeq	r5, {r0, r8, r9, pc}
 9c0:	01040200 	mrseq	r0, R12_usr
 9c4:	000b052e 	andeq	r0, fp, lr, lsr #10
 9c8:	4a010402 	bmi	419d8 <__bss_end+0x38a38>
 9cc:	02000205 	andeq	r0, r0, #1342177280	; 0x50000000
 9d0:	05490104 	strbeq	r0, [r9, #-260]	; 0xfffffefc
 9d4:	0105850b 	tsteq	r5, fp, lsl #10
 9d8:	0e05852f 	cfsh32eq	mvfx8, mvfx5, #31
 9dc:	661105bc 			; <UNDEFINED> instruction: 0x661105bc
 9e0:	05bc2005 	ldreq	r2, [ip, #5]!
 9e4:	1f05660b 	svcne	0x0005660b
 9e8:	660a054b 	strvs	r0, [sl], -fp, asr #10
 9ec:	054b0805 	strbeq	r0, [fp, #-2053]	; 0xfffff7fb
 9f0:	16058311 			; <UNDEFINED> instruction: 0x16058311
 9f4:	6708052e 	strvs	r0, [r8, -lr, lsr #10]
 9f8:	05671105 	strbeq	r1, [r7, #-261]!	; 0xfffffefb
 9fc:	01054d0b 	tsteq	r5, fp, lsl #26
 a00:	0605852f 	streq	r8, [r5], -pc, lsr #10
 a04:	4c0b0583 	cfstr32mi	mvfx0, [fp], {131}	; 0x83
 a08:	052e0c05 	streq	r0, [lr, #-3077]!	; 0xfffff3fb
 a0c:	0405660e 	streq	r6, [r5], #-1550	; 0xfffff9f2
 a10:	6502054b 	strvs	r0, [r2, #-1355]	; 0xfffffab5
 a14:	05310905 	ldreq	r0, [r1, #-2309]!	; 0xfffff6fb
 a18:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 a1c:	0b059f08 	bleq	168644 <__bss_end+0x15f6a4>
 a20:	0014054c 	andseq	r0, r4, ip, asr #10
 a24:	4a030402 	bmi	c1a34 <__bss_end+0xb8a94>
 a28:	02000705 	andeq	r0, r0, #1310720	; 0x140000
 a2c:	05830204 	streq	r0, [r3, #516]	; 0x204
 a30:	04020008 	streq	r0, [r2], #-8
 a34:	0a052e02 	beq	14c244 <__bss_end+0x1432a4>
 a38:	02040200 	andeq	r0, r4, #0, 4
 a3c:	0002054a 	andeq	r0, r2, sl, asr #10
 a40:	49020402 	stmdbmi	r2, {r1, sl}
 a44:	85840105 	strhi	r0, [r4, #261]	; 0x105
 a48:	05bb0e05 	ldreq	r0, [fp, #3589]!	; 0xe05
 a4c:	0b054b08 	bleq	153674 <__bss_end+0x14a6d4>
 a50:	0014054c 	andseq	r0, r4, ip, asr #10
 a54:	4a030402 	bmi	c1a64 <__bss_end+0xb8ac4>
 a58:	02001605 	andeq	r1, r0, #5242880	; 0x500000
 a5c:	05830204 	streq	r0, [r3, #516]	; 0x204
 a60:	04020017 	streq	r0, [r2], #-23	; 0xffffffe9
 a64:	0a052e02 	beq	14c274 <__bss_end+0x1432d4>
 a68:	02040200 	andeq	r0, r4, #0, 4
 a6c:	000b054a 	andeq	r0, fp, sl, asr #10
 a70:	2e020402 	cdpcs	4, 0, cr0, cr2, cr2, {0}
 a74:	02001705 	andeq	r1, r0, #1310720	; 0x140000
 a78:	054a0204 	strbeq	r0, [sl, #-516]	; 0xfffffdfc
 a7c:	0402000d 	streq	r0, [r2], #-13
 a80:	02052e02 	andeq	r2, r5, #2, 28
 a84:	02040200 	andeq	r0, r4, #0, 4
 a88:	8401052d 	strhi	r0, [r1], #-1325	; 0xfffffad3
 a8c:	01000802 	tsteq	r0, r2, lsl #16
 a90:	Address 0x0000000000000a90 is out of bounds.


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
      58:	0a590704 	beq	1641c70 <__bss_end+0x1638cd0>
      5c:	5b020000 	blpl	80064 <__bss_end+0x770c4>
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
     128:	00000a59 	andeq	r0, r0, r9, asr sl
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
     174:	cb104801 	blgt	412180 <__bss_end+0x4091e0>
     178:	d4000000 	strle	r0, [r0], #-0
     17c:	58000081 	stmdapl	r0, {r0, r7}
     180:	01000000 	mrseq	r0, (UNDEF: 0)
     184:	0000cb9c 	muleq	r0, ip, fp
     188:	02b40a00 	adcseq	r0, r4, #0, 20
     18c:	4a010000 	bmi	40194 <__bss_end+0x371f4>
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
     21c:	ba0d9c01 	blt	367228 <__bss_end+0x35e288>
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
     24c:	8b120f01 	blhi	483e58 <__bss_end+0x47aeb8>
     250:	0f000001 	svceq	0x00000001
     254:	0000019e 	muleq	r0, lr, r1
     258:	03d51000 	bicseq	r1, r5, #0
     25c:	0a010000 	beq	40264 <__bss_end+0x372c4>
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
     2b4:	8b140074 	blhi	50048c <__bss_end+0x4f74ec>
     2b8:	a4000001 	strge	r0, [r0], #-1
     2bc:	38000080 	stmdacc	r0, {r7}
     2c0:	01000000 	mrseq	r0, (UNDEF: 0)
     2c4:	0067139c 	mlseq	r7, ip, r3, r1
     2c8:	9e2f0a01 	vmulls.f32	s0, s30, s2
     2cc:	02000001 	andeq	r0, r0, #1
     2d0:	00007491 	muleq	r0, r1, r4
     2d4:	00000848 	andeq	r0, r0, r8, asr #16
     2d8:	01e00004 	mvneq	r0, r4
     2dc:	01040000 	mrseq	r0, (UNDEF: 4)
     2e0:	000001e1 	andeq	r0, r0, r1, ror #3
     2e4:	0006d604 	andeq	sp, r6, r4, lsl #12
     2e8:	00005600 	andeq	r5, r0, r0, lsl #12
     2ec:	00822c00 	addeq	r2, r2, r0, lsl #24
     2f0:	00011000 	andeq	r1, r1, r0
     2f4:	00024600 	andeq	r4, r2, r0, lsl #12
     2f8:	08010200 	stmdaeq	r1, {r9}
     2fc:	00000aee 	andeq	r0, r0, lr, ror #21
     300:	b3050202 	movwlt	r0, #20994	; 0x5202
     304:	03000009 	movweq	r0, #9
     308:	6e690504 	cdpvs	5, 6, cr0, cr9, cr4, {0}
     30c:	01020074 	tsteq	r2, r4, ror r0
     310:	000ae508 	andeq	lr, sl, r8, lsl #10
     314:	07020200 	streq	r0, [r2, -r0, lsl #4]
     318:	00000b9c 	muleq	r0, ip, fp
     31c:	00060804 	andeq	r0, r6, r4, lsl #16
     320:	07090a00 	streq	r0, [r9, -r0, lsl #20]
     324:	00000059 	andeq	r0, r0, r9, asr r0
     328:	00004805 	andeq	r4, r0, r5, lsl #16
     32c:	07040200 	streq	r0, [r4, -r0, lsl #4]
     330:	00000a59 	andeq	r0, r0, r9, asr sl
     334:	00005905 	andeq	r5, r0, r5, lsl #18
     338:	0c4c0600 	mcrreq	6, 0, r0, ip, cr0
     33c:	02080000 	andeq	r0, r8, #0
     340:	008b0806 	addeq	r0, fp, r6, lsl #16
     344:	72070000 	andvc	r0, r7, #0
     348:	08020030 	stmdaeq	r2, {r4, r5}
     34c:	0000480e 	andeq	r4, r0, lr, lsl #16
     350:	72070000 	andvc	r0, r7, #0
     354:	09020031 	stmdbeq	r2, {r0, r4, r5}
     358:	0000480e 	andeq	r4, r0, lr, lsl #16
     35c:	08000400 	stmdaeq	r0, {sl}
     360:	000009fe 	strdeq	r0, [r0], -lr
     364:	00330405 	eorseq	r0, r3, r5, lsl #8
     368:	1e020000 	cdpne	0, 0, cr0, cr2, cr0, {0}
     36c:	0000c20c 	andeq	ip, r0, ip, lsl #4
     370:	06000900 	streq	r0, [r0], -r0, lsl #18
     374:	09000000 	stmdbeq	r0, {}	; <UNPREDICTABLE>
     378:	0000078a 	andeq	r0, r0, sl, lsl #15
     37c:	0a200901 	beq	802788 <__bss_end+0x7f97e8>
     380:	09020000 	stmdbeq	r2, {}	; <UNPREDICTABLE>
     384:	00000b10 	andeq	r0, r0, r0, lsl fp
     388:	07700903 	ldrbeq	r0, [r0, -r3, lsl #18]!
     38c:	09040000 	stmdbeq	r4, {}	; <UNPREDICTABLE>
     390:	000009aa 	andeq	r0, r0, sl, lsr #19
     394:	e6080005 	str	r0, [r8], -r5
     398:	05000009 	streq	r0, [r0, #-9]
     39c:	00003304 	andeq	r3, r0, r4, lsl #6
     3a0:	0c3f0200 	lfmeq	f0, 4, [pc], #-0	; 3a8 <shift+0x3a8>
     3a4:	000000ff 	strdeq	r0, [r0], -pc	; <UNPREDICTABLE>
     3a8:	0006c109 	andeq	ip, r6, r9, lsl #2
     3ac:	85090000 	strhi	r0, [r9, #-0]
     3b0:	01000007 	tsteq	r0, r7
     3b4:	000bd309 	andeq	sp, fp, r9, lsl #6
     3b8:	13090200 	movwne	r0, #37376	; 0x9200
     3bc:	03000009 	movweq	r0, #9
     3c0:	00077f09 	andeq	r7, r7, r9, lsl #30
     3c4:	bd090400 	cfstrslt	mvf0, [r9, #-0]
     3c8:	05000007 	streq	r0, [r0, #-7]
     3cc:	00061b09 	andeq	r1, r6, r9, lsl #22
     3d0:	0a000600 	beq	1bd8 <shift+0x1bd8>
     3d4:	000008f1 	strdeq	r0, [r0], -r1
     3d8:	54140503 	ldrpl	r0, [r4], #-1283	; 0xfffffafd
     3dc:	05000000 	streq	r0, [r0, #-0]
     3e0:	008e6003 	addeq	r6, lr, r3
     3e4:	0a790a00 	beq	1e42bec <__bss_end+0x1e39c4c>
     3e8:	06030000 	streq	r0, [r3], -r0
     3ec:	00005414 	andeq	r5, r0, r4, lsl r4
     3f0:	64030500 	strvs	r0, [r3], #-1280	; 0xfffffb00
     3f4:	0a00008e 	beq	634 <shift+0x634>
     3f8:	000007d2 	ldrdeq	r0, [r0], -r2
     3fc:	541a0704 	ldrpl	r0, [sl], #-1796	; 0xfffff8fc
     400:	05000000 	streq	r0, [r0, #-0]
     404:	008e6803 	addeq	r6, lr, r3, lsl #16
     408:	09bd0a00 	ldmibeq	sp!, {r9, fp}
     40c:	09040000 	stmdbeq	r4, {}	; <UNPREDICTABLE>
     410:	0000541a 	andeq	r5, r0, sl, lsl r4
     414:	6c030500 	cfstr32vs	mvfx0, [r3], {-0}
     418:	0a00008e 	beq	658 <shift+0x658>
     41c:	000007c4 	andeq	r0, r0, r4, asr #15
     420:	541a0b04 	ldrpl	r0, [sl], #-2820	; 0xfffff4fc
     424:	05000000 	streq	r0, [r0, #-0]
     428:	008e7003 	addeq	r7, lr, r3
     42c:	09970a00 	ldmibeq	r7, {r9, fp}
     430:	0d040000 	stceq	0, cr0, [r4, #-0]
     434:	0000541a 	andeq	r5, r0, sl, lsl r4
     438:	74030500 	strvc	r0, [r3], #-1280	; 0xfffffb00
     43c:	0a00008e 	beq	67c <shift+0x67c>
     440:	000005e0 	andeq	r0, r0, r0, ror #11
     444:	541a0f04 	ldrpl	r0, [sl], #-3844	; 0xfffff0fc
     448:	05000000 	streq	r0, [r0, #-0]
     44c:	008e7803 	addeq	r7, lr, r3, lsl #16
     450:	10940800 	addsne	r0, r4, r0, lsl #16
     454:	04050000 	streq	r0, [r5], #-0
     458:	00000033 	andeq	r0, r0, r3, lsr r0
     45c:	a20c1b04 	andge	r1, ip, #4, 22	; 0x1000
     460:	09000001 	stmdbeq	r0, {r0}
     464:	0000058f 	andeq	r0, r0, pc, lsl #11
     468:	0b3b0900 	bleq	ec2870 <__bss_end+0xeb98d0>
     46c:	09010000 	stmdbeq	r1, {}	; <UNPREDICTABLE>
     470:	00000bce 	andeq	r0, r0, lr, asr #23
     474:	590b0002 	stmdbpl	fp, {r1}
     478:	02000004 	andeq	r0, r0, #4
     47c:	083c0201 	ldmdaeq	ip!, {r0, r9}
     480:	040c0000 	streq	r0, [ip], #-0
     484:	000001a2 	andeq	r0, r0, r2, lsr #3
     488:	0005990a 	andeq	r9, r5, sl, lsl #18
     48c:	14040500 	strne	r0, [r4], #-1280	; 0xfffffb00
     490:	00000054 	andeq	r0, r0, r4, asr r0
     494:	8e7c0305 	cdphi	3, 7, cr0, cr12, cr5, {0}
     498:	260a0000 	strcs	r0, [sl], -r0
     49c:	0500000a 	streq	r0, [r0, #-10]
     4a0:	00541407 	subseq	r1, r4, r7, lsl #8
     4a4:	03050000 	movweq	r0, #20480	; 0x5000
     4a8:	00008e80 	andeq	r8, r0, r0, lsl #29
     4ac:	0004e70a 	andeq	lr, r4, sl, lsl #14
     4b0:	140a0500 	strne	r0, [sl], #-1280	; 0xfffffb00
     4b4:	00000054 	andeq	r0, r0, r4, asr r0
     4b8:	8e840305 	cdphi	3, 8, cr0, cr4, cr5, {0}
     4bc:	20080000 	andcs	r0, r8, r0
     4c0:	05000006 	streq	r0, [r0, #-6]
     4c4:	00003304 	andeq	r3, r0, r4, lsl #6
     4c8:	0c0d0500 	cfstr32eq	mvfx0, [sp], {-0}
     4cc:	00000221 	andeq	r0, r0, r1, lsr #4
     4d0:	77654e0d 	strbvc	r4, [r5, -sp, lsl #28]!
     4d4:	c7090000 	strgt	r0, [r9, -r0]
     4d8:	01000004 	tsteq	r0, r4
     4dc:	0004df09 	andeq	sp, r4, r9, lsl #30
     4e0:	39090200 	stmdbcc	r9, {r9}
     4e4:	03000006 	movweq	r0, #6
     4e8:	000b0209 	andeq	r0, fp, r9, lsl #4
     4ec:	bb090400 	bllt	2414f4 <__bss_end+0x238554>
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
     524:	e00e0800 	and	r0, lr, r0, lsl #16
     528:	05000009 	streq	r0, [r0, #-9]
     52c:	02601320 	rsbeq	r1, r0, #32, 6	; 0x80000000
     530:	000c0000 	andeq	r0, ip, r0
     534:	54070402 	strpl	r0, [r7], #-1026	; 0xfffffbfe
     538:	0500000a 	streq	r0, [r0, #-10]
     53c:	00000260 	andeq	r0, r0, r0, ror #4
     540:	00076306 	andeq	r6, r7, r6, lsl #6
     544:	28057000 	stmdacs	r5, {ip, sp, lr}
     548:	0002fc08 	andeq	pc, r2, r8, lsl #24
     54c:	06a60e00 	strteq	r0, [r6], r0, lsl #28
     550:	2a050000 	bcs	140558 <__bss_end+0x1375b8>
     554:	00022112 	andeq	r2, r2, r2, lsl r1
     558:	70070000 	andvc	r0, r7, r0
     55c:	05006469 	streq	r6, [r0, #-1129]	; 0xfffffb97
     560:	0059122b 	subseq	r1, r9, fp, lsr #4
     564:	0e100000 	cdpeq	0, 1, cr0, cr0, cr0, {0}
     568:	00000b35 	andeq	r0, r0, r5, lsr fp
     56c:	ea112c05 	b	44b588 <__bss_end+0x4425e8>
     570:	14000001 	strne	r0, [r0], #-1
     574:	000ad70e 	andeq	sp, sl, lr, lsl #14
     578:	122d0500 	eorne	r0, sp, #0, 10
     57c:	00000059 	andeq	r0, r0, r9, asr r0
     580:	03e90e18 	mvneq	r0, #24, 28	; 0x180
     584:	2e050000 	cdpcs	0, 0, cr0, cr5, cr0, {0}
     588:	00005912 	andeq	r5, r0, r2, lsl r9
     58c:	130e1c00 	movwne	r1, #60416	; 0xec00
     590:	0500000a 	streq	r0, [r0, #-10]
     594:	02fc0c2f 	rscseq	r0, ip, #12032	; 0x2f00
     598:	0e200000 	cdpeq	0, 2, cr0, cr0, cr0, {0}
     59c:	00000472 	andeq	r0, r0, r2, ror r4
     5a0:	33093005 	movwcc	r3, #36869	; 0x9005
     5a4:	60000000 	andvs	r0, r0, r0
     5a8:	0006640e 	andeq	r6, r6, lr, lsl #8
     5ac:	0e310500 	cfabs32eq	mvfx0, mvfx1
     5b0:	00000048 	andeq	r0, r0, r8, asr #32
     5b4:	09610e64 	stmdbeq	r1!, {r2, r5, r6, r9, sl, fp}^
     5b8:	33050000 	movwcc	r0, #20480	; 0x5000
     5bc:	0000480e 	andeq	r4, r0, lr, lsl #16
     5c0:	580e6800 	stmdapl	lr, {fp, sp, lr}
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
     5ec:	8e880305 	cdphi	3, 8, cr0, cr8, cr5, {0}
     5f0:	0d080000 	stceq	0, cr0, [r8, #-0]
     5f4:	05000008 	streq	r0, [r0, #-8]
     5f8:	00003304 	andeq	r3, r0, r4, lsl #6
     5fc:	0c0d0600 	stceq	6, cr0, [sp], {-0}
     600:	0000033d 	andeq	r0, r0, sp, lsr r3
     604:	000bd909 	andeq	sp, fp, r9, lsl #18
     608:	4f090000 	svcmi	0x00090000
     60c:	0100000b 	tsteq	r0, fp
     610:	06930600 	ldreq	r0, [r3], r0, lsl #12
     614:	060c0000 	streq	r0, [ip], -r0
     618:	0372081b 	cmneq	r2, #1769472	; 0x1b0000
     61c:	5c0e0000 	stcpl	0, cr0, [lr], {-0}
     620:	06000005 	streq	r0, [r0], -r5
     624:	0372191d 	cmneq	r2, #475136	; 0x74000
     628:	0e000000 	cdpeq	0, 0, cr0, cr0, cr0, {0}
     62c:	000004c2 	andeq	r0, r0, r2, asr #9
     630:	72191e06 	andsvc	r1, r9, #6, 28	; 0x60
     634:	04000003 	streq	r0, [r0], #-3
     638:	0008310e 	andeq	r3, r8, lr, lsl #2
     63c:	131f0600 	tstne	pc, #0, 12
     640:	00000378 	andeq	r0, r0, r8, ror r3
     644:	040c0008 	streq	r0, [ip], #-8
     648:	0000033d 	andeq	r0, r0, sp, lsr r3
     64c:	026c040c 	rsbeq	r0, ip, #12, 8	; 0xc000000
     650:	cf110000 	svcgt	0x00110000
     654:	14000009 	strne	r0, [r0], #-9
     658:	00072206 	andeq	r2, r7, r6, lsl #4
     65c:	0e000006 	cdpeq	0, 0, cr0, cr0, cr6, {0}
     660:	000008ff 	strdeq	r0, [r0], -pc	; <UNPREDICTABLE>
     664:	48122606 	ldmdami	r2, {r1, r2, r9, sl, sp}
     668:	00000000 	andeq	r0, r0, r0
     66c:	0008a10e 	andeq	sl, r8, lr, lsl #2
     670:	1d290600 	stcne	6, cr0, [r9, #-0]
     674:	00000372 	andeq	r0, r0, r2, ror r3
     678:	06410e04 	strbeq	r0, [r1], -r4, lsl #28
     67c:	2c060000 	stccs	0, cr0, [r6], {-0}
     680:	0003721d 	andeq	r7, r3, sp, lsl r2
     684:	09120800 	ldmdbeq	r2, {fp}
     688:	06000009 	streq	r0, [r0], -r9
     68c:	06700e2f 	ldrbteq	r0, [r0], -pc, lsr #28
     690:	03c60000 	biceq	r0, r6, #0
     694:	03d10000 	bicseq	r0, r1, #0
     698:	05130000 	ldreq	r0, [r3, #-0]
     69c:	14000006 	strne	r0, [r0], #-6
     6a0:	00000372 	andeq	r0, r0, r2, ror r3
     6a4:	07941500 	ldreq	r1, [r4, r0, lsl #10]
     6a8:	31060000 	mrscc	r0, (UNDEF: 6)
     6ac:	00073a0e 	andeq	r3, r7, lr, lsl #20
     6b0:	0001a700 	andeq	sl, r1, r0, lsl #14
     6b4:	0003e900 	andeq	lr, r3, r0, lsl #18
     6b8:	0003f400 	andeq	pc, r3, r0, lsl #8
     6bc:	06051300 	streq	r1, [r5], -r0, lsl #6
     6c0:	78140000 	ldmdavc	r4, {}	; <UNPREDICTABLE>
     6c4:	00000003 	andeq	r0, r0, r3
     6c8:	000b1616 	andeq	r1, fp, r6, lsl r6
     6cc:	1d350600 	ldcne	6, cr0, [r5, #-0]
     6d0:	000007e8 	andeq	r0, r0, r8, ror #15
     6d4:	00000372 	andeq	r0, r0, r2, ror r3
     6d8:	00040d02 	andeq	r0, r4, r2, lsl #26
     6dc:	00041300 	andeq	r1, r4, r0, lsl #6
     6e0:	06051300 	streq	r1, [r5], -r0, lsl #6
     6e4:	16000000 	strne	r0, [r0], -r0
     6e8:	0000062c 	andeq	r0, r0, ip, lsr #12
     6ec:	191d3706 	ldmdbne	sp, {r1, r2, r8, r9, sl, ip, sp}
     6f0:	72000009 	andvc	r0, r0, #9
     6f4:	02000003 	andeq	r0, r0, #3
     6f8:	0000042c 	andeq	r0, r0, ip, lsr #8
     6fc:	00000432 	andeq	r0, r0, r2, lsr r4
     700:	00060513 	andeq	r0, r6, r3, lsl r5
     704:	b4170000 	ldrlt	r0, [r7], #-0
     708:	06000008 	streq	r0, [r0], -r8
     70c:	061e3139 			; <UNDEFINED> instruction: 0x061e3139
     710:	020c0000 	andeq	r0, ip, #0
     714:	0009cf16 	andeq	ip, r9, r6, lsl pc
     718:	093c0600 	ldmdbeq	ip!, {r9, sl}
     71c:	000007a3 	andeq	r0, r0, r3, lsr #15
     720:	00000605 	andeq	r0, r0, r5, lsl #12
     724:	00045901 	andeq	r5, r4, r1, lsl #18
     728:	00045f00 	andeq	r5, r4, r0, lsl #30
     72c:	06051300 	streq	r1, [r5], -r0, lsl #6
     730:	16000000 	strne	r0, [r0], -r0
     734:	000006b2 			; <UNDEFINED> instruction: 0x000006b2
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
     760:	0b461800 	bleq	1186768 <__bss_end+0x117d7c8>
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
     79c:	00000a31 	andeq	r0, r0, r1, lsr sl
     7a0:	ff174806 			; <UNDEFINED> instruction: 0xff174806
     7a4:	78000003 	stmdavc	r0, {r0, r1}
     7a8:	01000003 	tsteq	r0, r3
     7ac:	000004e0 	andeq	r0, r0, r0, ror #9
     7b0:	000004eb 	andeq	r0, r0, fp, ror #9
     7b4:	00062d13 	andeq	r2, r6, r3, lsl sp
     7b8:	00481400 	subeq	r1, r8, r0, lsl #8
     7bc:	18000000 	stmdane	r0, {}	; <UNPREDICTABLE>
     7c0:	000005ea 	andeq	r0, r0, sl, ror #11
     7c4:	c20e4b06 	andgt	r4, lr, #6144	; 0x1800
     7c8:	01000008 	tsteq	r0, r8
     7cc:	00000500 	andeq	r0, r0, r0, lsl #10
     7d0:	00000506 	andeq	r0, r0, r6, lsl #10
     7d4:	00060513 	andeq	r0, r6, r3, lsl r5
     7d8:	94160000 	ldrls	r0, [r6], #-0
     7dc:	06000007 	streq	r0, [r0], -r7
     7e0:	096f0e4d 	stmdbeq	pc!, {r0, r2, r3, r6, r9, sl, fp}^	; <UNPREDICTABLE>
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
     828:	0b5a0e53 	bleq	168417c <__bss_end+0x167b1dc>
     82c:	01a70000 			; <UNDEFINED> instruction: 0x01a70000
     830:	67010000 	strvs	r0, [r1, -r0]
     834:	72000005 	andvc	r0, r0, #5
     838:	13000005 	movwne	r0, #5
     83c:	00000605 	andeq	r0, r0, r5, lsl #12
     840:	00004814 	andeq	r4, r0, r4, lsl r8
     844:	81180000 	tsthi	r8, r0
     848:	06000004 	streq	r0, [r0], -r4
     84c:	0a850e56 	beq	fe1441ac <__bss_end+0xfe13b20c>
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
     878:	86180000 	ldrhi	r0, [r8], -r0
     87c:	0600000b 	streq	r0, [r0], -fp
     880:	0c000e58 	stceq	14, cr0, [r0], {88}	; 0x58
     884:	bb010000 	bllt	4088c <__bss_end+0x378ec>
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
     8b4:	08410e5b 	stmdaeq	r1, {r0, r1, r3, r4, r6, r9, sl, fp}^
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
     91c:	0000088e 	andeq	r0, r0, lr, lsl #17
     920:	60190707 	andsvs	r0, r9, r7, lsl #14
     924:	80000000 	andhi	r0, r0, r0
     928:	1f0ee6b2 	svcne	0x000ee6b2
     92c:	00000a44 	andeq	r0, r0, r4, asr #20
     930:	671a0a07 	ldrvs	r0, [sl, -r7, lsl #20]
     934:	00000002 	andeq	r0, r0, r2
     938:	1f200000 	svcne	0x00200000
     93c:	0000050e 	andeq	r0, r0, lr, lsl #10
     940:	671a0d07 	ldrvs	r0, [sl, -r7, lsl #26]
     944:	00000002 	andeq	r0, r0, r2
     948:	20202000 	eorcs	r2, r0, r0
     94c:	00000822 	andeq	r0, r0, r2, lsr #16
     950:	54151007 	ldrpl	r1, [r5], #-7
     954:	36000000 	strcc	r0, [r0], -r0
     958:	000b221f 	andeq	r2, fp, pc, lsl r2
     95c:	1a420700 	bne	1082564 <__bss_end+0x10795c4>
     960:	00000267 	andeq	r0, r0, r7, ror #4
     964:	20215000 	eorcs	r5, r1, r0
     968:	000bb41f 	andeq	fp, fp, pc, lsl r4
     96c:	1a710700 	bne	1c42574 <__bss_end+0x1c395d4>
     970:	00000267 	andeq	r0, r0, r7, ror #4
     974:	2000b200 	andcs	fp, r0, r0, lsl #4
     978:	0006cb1f 	andeq	ip, r6, pc, lsl fp
     97c:	1aa40700 	bne	fe902584 <__bss_end+0xfe8f95e4>
     980:	00000267 	andeq	r0, r0, r7, ror #4
     984:	2000b400 	andcs	fp, r0, r0, lsl #8
     988:	0008841f 	andeq	r8, r8, pc, lsl r4
     98c:	1ab30700 	bne	fecc2594 <__bss_end+0xfecb95f4>
     990:	00000267 	andeq	r0, r0, r7, ror #4
     994:	20104000 	andscs	r4, r0, r0
     998:	00093f1f 	andeq	r3, r9, pc, lsl pc
     99c:	1abe0700 	bne	fef825a4 <__bss_end+0xfef79604>
     9a0:	00000267 	andeq	r0, r0, r7, ror #4
     9a4:	20205000 	eorcs	r5, r0, r0
     9a8:	0006111f 	andeq	r1, r6, pc, lsl r1
     9ac:	1abf0700 	bne	fefc25b4 <__bss_end+0xfefb9614>
     9b0:	00000267 	andeq	r0, r0, r7, ror #4
     9b4:	20804000 	addcs	r4, r0, r0
     9b8:	000b2b1f 	andeq	r2, fp, pc, lsl fp
     9bc:	1ac00700 	bne	ff0025c4 <__bss_end+0xfeff9624>
     9c0:	00000267 	andeq	r0, r0, r7, ror #4
     9c4:	20805000 	addcs	r5, r0, r0
     9c8:	000af31f 	andeq	pc, sl, pc, lsl r3	; <UNPREDICTABLE>
     9cc:	1ace0700 	bne	ff3825d4 <__bss_end+0xff379634>
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
     a14:	0a660a00 	beq	198321c <__bss_end+0x197a27c>
     a18:	08080000 	stmdaeq	r8, {}	; <UNPREDICTABLE>
     a1c:	00005414 	andeq	r5, r0, r4, lsl r4
     a20:	bc030500 	cfstr32lt	mvfx0, [r3], {-0}
     a24:	0a00008e 	beq	c64 <shift+0xc64>
     a28:	00000543 	andeq	r0, r0, r3, asr #10
     a2c:	54140809 	ldrpl	r0, [r4], #-2057	; 0xfffff7f7
     a30:	05000000 	streq	r0, [r0, #-0]
     a34:	008ec003 	addeq	ip, lr, r3
     a38:	25040c00 	strcs	r0, [r4, #-3072]	; 0xfffff400
     a3c:	0a000000 	beq	a44 <shift+0xa44>
     a40:	00000bee 	andeq	r0, r0, lr, ror #23
     a44:	54140e01 	ldrpl	r0, [r4], #-3585	; 0xfffff1ff
     a48:	05000000 	streq	r0, [r0, #-0]
     a4c:	008ec403 	addeq	ip, lr, r3, lsl #8
     a50:	06540a00 	ldrbeq	r0, [r4], -r0, lsl #20
     a54:	0f010000 	svceq	0x00010000
     a58:	00005414 	andeq	r5, r0, r4, lsl r4
     a5c:	c8030500 	stmdagt	r3, {r8, sl}
     a60:	2200008e 	andcs	r0, r0, #142	; 0x8e
     a64:	0064656c 	rsbeq	r6, r4, ip, ror #10
     a68:	480a1101 	stmdami	sl, {r0, r8, ip}
     a6c:	05000000 	streq	r0, [r0, #-0]
     a70:	008f8003 	addeq	r8, pc, r3
     a74:	047c2300 	ldrbteq	r2, [ip], #-768	; 0xfffffd00
     a78:	11010000 	mrsne	r0, (UNDEF: 1)
     a7c:	0000480f 	andeq	r4, r0, pc, lsl #16
     a80:	84030500 	strhi	r0, [r3], #-1280	; 0xfffffb00
     a84:	2300008f 	movwcs	r0, #143	; 0x8f
     a88:	00000a72 	andeq	r0, r0, r2, ror sl
     a8c:	48151101 	ldmdami	r5, {r0, r8, ip}
     a90:	05000000 	streq	r0, [r0, #-0]
     a94:	008f8803 	addeq	r8, pc, r3, lsl #16
     a98:	6f6c2200 	svcvs	0x006c2200
     a9c:	11010067 	tstne	r1, r7, rrx
     aa0:	0000481d 	andeq	r4, r0, sp, lsl r8
     aa4:	8c030500 	cfstr32hi	mvfx0, [r3], {-0}
     aa8:	2400008f 	strcs	r0, [r0], #-143	; 0xffffff71
     aac:	00000baf 	andeq	r0, r0, pc, lsr #23
     ab0:	33051a01 	movwcc	r1, #23041	; 0x5a01
     ab4:	84000000 	strhi	r0, [r0], #-0
     ab8:	b8000082 	stmdalt	r0, {r1, r7}
     abc:	01000000 	mrseq	r0, (UNDEF: 0)
     ac0:	00081f9c 	muleq	r8, ip, pc	; <UNPREDICTABLE>
     ac4:	09532500 	ldmdbeq	r3, {r8, sl, sp}^
     ac8:	1a010000 	bne	40ad0 <__bss_end+0x37b30>
     acc:	0000330e 	andeq	r3, r0, lr, lsl #6
     ad0:	6c910200 	lfmvs	f0, 4, [r1], {0}
     ad4:	00096a25 	andeq	r6, r9, r5, lsr #20
     ad8:	1b1a0100 	blne	680ee0 <__bss_end+0x677f40>
     adc:	0000081f 	andeq	r0, r0, pc, lsl r8
     ae0:	26689102 	strbtcs	r9, [r8], -r2, lsl #2
     ae4:	000006c6 	andeq	r0, r0, r6, asr #13
     ae8:	250a1c01 	strcs	r1, [sl, #-3073]	; 0xfffff3ff
     aec:	02000008 	andeq	r0, r0, #8
     af0:	0c007491 	cfstrseq	mvf7, [r0], {145}	; 0x91
     af4:	00076504 	andeq	r6, r7, r4, lsl #10
     af8:	00250f00 	eoreq	r0, r5, r0, lsl #30
     afc:	08350000 	ldmdaeq	r5!, {}	; <UNPREDICTABLE>
     b00:	59100000 	ldmdbpl	r0, {}	; <UNPREDICTABLE>
     b04:	03000000 	movweq	r0, #0
     b08:	08362700 	ldmdaeq	r6!, {r8, r9, sl, sp}
     b0c:	13010000 	movwne	r0, #4096	; 0x1000
     b10:	00094906 	andeq	r4, r9, r6, lsl #18
     b14:	00822c00 	addeq	r2, r2, r0, lsl #24
     b18:	00005800 	andeq	r5, r0, r0, lsl #16
     b1c:	009c0100 	addseq	r0, ip, r0, lsl #2
     b20:	00000b1f 	andeq	r0, r0, pc, lsl fp
     b24:	04460004 	strbeq	r0, [r6], #-4
     b28:	01040000 	mrseq	r0, (UNDEF: 4)
     b2c:	00000f90 	muleq	r0, r0, pc	; <UNPREDICTABLE>
     b30:	000e6904 	andeq	r6, lr, r4, lsl #18
     b34:	000c5800 	andeq	r5, ip, r0, lsl #16
     b38:	00833c00 	addeq	r3, r3, r0, lsl #24
     b3c:	00045c00 	andeq	r5, r4, r0, lsl #24
     b40:	00052600 	andeq	r2, r5, r0, lsl #12
     b44:	08010200 	stmdaeq	r1, {r9}
     b48:	00000aee 	andeq	r0, r0, lr, ror #21
     b4c:	00002503 	andeq	r2, r0, r3, lsl #10
     b50:	05020200 	streq	r0, [r2, #-512]	; 0xfffffe00
     b54:	000009b3 			; <UNDEFINED> instruction: 0x000009b3
     b58:	69050404 	stmdbvs	r5, {r2, sl}
     b5c:	0200746e 	andeq	r7, r0, #1845493760	; 0x6e000000
     b60:	0ae50801 	beq	ff942b6c <__bss_end+0xff939bcc>
     b64:	02020000 	andeq	r0, r2, #0
     b68:	000b9c07 	andeq	r9, fp, r7, lsl #24
     b6c:	06080500 	streq	r0, [r8], -r0, lsl #10
     b70:	09070000 	stmdbeq	r7, {}	; <UNPREDICTABLE>
     b74:	00005e07 	andeq	r5, r0, r7, lsl #28
     b78:	004d0300 	subeq	r0, sp, r0, lsl #6
     b7c:	04020000 	streq	r0, [r2], #-0
     b80:	000a5907 	andeq	r5, sl, r7, lsl #18
     b84:	0c4c0600 	mcrreq	6, 0, r0, ip, cr0
     b88:	02080000 	andeq	r0, r8, #0
     b8c:	008b0806 	addeq	r0, fp, r6, lsl #16
     b90:	72070000 	andvc	r0, r7, #0
     b94:	08020030 	stmdaeq	r2, {r4, r5}
     b98:	00004d0e 	andeq	r4, r0, lr, lsl #26
     b9c:	72070000 	andvc	r0, r7, #0
     ba0:	09020031 	stmdbeq	r2, {r0, r4, r5}
     ba4:	00004d0e 	andeq	r4, r0, lr, lsl #26
     ba8:	08000400 	stmdaeq	r0, {sl}
     bac:	00000f1a 	andeq	r0, r0, sl, lsl pc
     bb0:	00380405 	eorseq	r0, r8, r5, lsl #8
     bb4:	0d020000 	stceq	0, cr0, [r2, #-0]
     bb8:	0000a90c 	andeq	sl, r0, ip, lsl #18
     bbc:	4b4f0900 	blmi	13c2fc4 <__bss_end+0x13ba024>
     bc0:	060a0000 	streq	r0, [sl], -r0
     bc4:	0100000d 	tsteq	r0, sp
     bc8:	09fe0800 	ldmibeq	lr!, {fp}^
     bcc:	04050000 	streq	r0, [r5], #-0
     bd0:	00000038 	andeq	r0, r0, r8, lsr r0
     bd4:	e00c1e02 	and	r1, ip, r2, lsl #28
     bd8:	0a000000 	beq	be0 <shift+0xbe0>
     bdc:	00000600 	andeq	r0, r0, r0, lsl #12
     be0:	078a0a00 	streq	r0, [sl, r0, lsl #20]
     be4:	0a010000 	beq	40bec <__bss_end+0x37c4c>
     be8:	00000a20 	andeq	r0, r0, r0, lsr #20
     bec:	0b100a02 	bleq	4033fc <__bss_end+0x3fa45c>
     bf0:	0a030000 	beq	c0bf8 <__bss_end+0xb7c58>
     bf4:	00000770 	andeq	r0, r0, r0, ror r7
     bf8:	09aa0a04 	stmibeq	sl!, {r2, r9, fp}
     bfc:	00050000 	andeq	r0, r5, r0
     c00:	0009e608 	andeq	lr, r9, r8, lsl #12
     c04:	38040500 	stmdacc	r4, {r8, sl}
     c08:	02000000 	andeq	r0, r0, #0
     c0c:	011d0c3f 	tsteq	sp, pc, lsr ip
     c10:	c10a0000 	mrsgt	r0, (UNDEF: 10)
     c14:	00000006 	andeq	r0, r0, r6
     c18:	0007850a 	andeq	r8, r7, sl, lsl #10
     c1c:	d30a0100 	movwle	r0, #41216	; 0xa100
     c20:	0200000b 	andeq	r0, r0, #11
     c24:	0009130a 	andeq	r1, r9, sl, lsl #6
     c28:	7f0a0300 	svcvc	0x000a0300
     c2c:	04000007 	streq	r0, [r0], #-7
     c30:	0007bd0a 	andeq	fp, r7, sl, lsl #26
     c34:	1b0a0500 	blne	28203c <__bss_end+0x27909c>
     c38:	06000006 	streq	r0, [r0], -r6
     c3c:	10410800 	subne	r0, r1, r0, lsl #16
     c40:	04050000 	streq	r0, [r5], #-0
     c44:	00000038 	andeq	r0, r0, r8, lsr r0
     c48:	480c6602 	stmdami	ip, {r1, r9, sl, sp, lr}
     c4c:	0a000001 	beq	c58 <shift+0xc58>
     c50:	00000e5e 	andeq	r0, r0, lr, asr lr
     c54:	0d630a00 	vstmdbeq	r3!, {s1-s0}
     c58:	0a010000 	beq	40c60 <__bss_end+0x37cc0>
     c5c:	00000ee3 	andeq	r0, r0, r3, ror #29
     c60:	0d880a02 	vstreq	s0, [r8, #8]
     c64:	00030000 	andeq	r0, r3, r0
     c68:	0008f10b 	andeq	pc, r8, fp, lsl #2
     c6c:	14050300 	strne	r0, [r5], #-768	; 0xfffffd00
     c70:	00000059 	andeq	r0, r0, r9, asr r0
     c74:	8f340305 	svchi	0x00340305
     c78:	790b0000 	stmdbvc	fp, {}	; <UNPREDICTABLE>
     c7c:	0300000a 	movweq	r0, #10
     c80:	00591406 	subseq	r1, r9, r6, lsl #8
     c84:	03050000 	movweq	r0, #20480	; 0x5000
     c88:	00008f38 	andeq	r8, r0, r8, lsr pc
     c8c:	0007d20b 	andeq	sp, r7, fp, lsl #4
     c90:	1a070400 	bne	1c1c98 <__bss_end+0x1b8cf8>
     c94:	00000059 	andeq	r0, r0, r9, asr r0
     c98:	8f3c0305 	svchi	0x003c0305
     c9c:	bd0b0000 	stclt	0, cr0, [fp, #-0]
     ca0:	04000009 	streq	r0, [r0], #-9
     ca4:	00591a09 	subseq	r1, r9, r9, lsl #20
     ca8:	03050000 	movweq	r0, #20480	; 0x5000
     cac:	00008f40 	andeq	r8, r0, r0, asr #30
     cb0:	0007c40b 	andeq	ip, r7, fp, lsl #8
     cb4:	1a0b0400 	bne	2c1cbc <__bss_end+0x2b8d1c>
     cb8:	00000059 	andeq	r0, r0, r9, asr r0
     cbc:	8f440305 	svchi	0x00440305
     cc0:	970b0000 	strls	r0, [fp, -r0]
     cc4:	04000009 	streq	r0, [r0], #-9
     cc8:	00591a0d 	subseq	r1, r9, sp, lsl #20
     ccc:	03050000 	movweq	r0, #20480	; 0x5000
     cd0:	00008f48 	andeq	r8, r0, r8, asr #30
     cd4:	0005e00b 	andeq	lr, r5, fp
     cd8:	1a0f0400 	bne	3c1ce0 <__bss_end+0x3b8d40>
     cdc:	00000059 	andeq	r0, r0, r9, asr r0
     ce0:	8f4c0305 	svchi	0x004c0305
     ce4:	94080000 	strls	r0, [r8], #-0
     ce8:	05000010 	streq	r0, [r0, #-16]
     cec:	00003804 	andeq	r3, r0, r4, lsl #16
     cf0:	0c1b0400 	cfldrseq	mvf0, [fp], {-0}
     cf4:	000001eb 	andeq	r0, r0, fp, ror #3
     cf8:	00058f0a 	andeq	r8, r5, sl, lsl #30
     cfc:	3b0a0000 	blcc	280d04 <__bss_end+0x277d64>
     d00:	0100000b 	tsteq	r0, fp
     d04:	000bce0a 	andeq	ip, fp, sl, lsl #28
     d08:	0c000200 	sfmeq	f0, 4, [r0], {-0}
     d0c:	00000459 	andeq	r0, r0, r9, asr r4
     d10:	3c020102 	stfccs	f0, [r2], {2}
     d14:	0d000008 	stceq	0, cr0, [r0, #-32]	; 0xffffffe0
     d18:	00002c04 	andeq	r2, r0, r4, lsl #24
     d1c:	eb040d00 	bl	104124 <__bss_end+0xfb184>
     d20:	0b000001 	bleq	d2c <shift+0xd2c>
     d24:	00000599 	muleq	r0, r9, r5
     d28:	59140405 	ldmdbpl	r4, {r0, r2, sl}
     d2c:	05000000 	streq	r0, [r0, #-0]
     d30:	008f5003 	addeq	r5, pc, r3
     d34:	0a260b00 	beq	98393c <__bss_end+0x97a99c>
     d38:	07050000 	streq	r0, [r5, -r0]
     d3c:	00005914 	andeq	r5, r0, r4, lsl r9
     d40:	54030500 	strpl	r0, [r3], #-1280	; 0xfffffb00
     d44:	0b00008f 	bleq	f88 <shift+0xf88>
     d48:	000004e7 	andeq	r0, r0, r7, ror #9
     d4c:	59140a05 	ldmdbpl	r4, {r0, r2, r9, fp}
     d50:	05000000 	streq	r0, [r0, #-0]
     d54:	008f5803 	addeq	r5, pc, r3, lsl #16
     d58:	06200800 	strteq	r0, [r0], -r0, lsl #16
     d5c:	04050000 	streq	r0, [r5], #-0
     d60:	00000038 	andeq	r0, r0, r8, lsr r0
     d64:	700c0d05 	andvc	r0, ip, r5, lsl #26
     d68:	09000002 	stmdbeq	r0, {r1}
     d6c:	0077654e 	rsbseq	r6, r7, lr, asr #10
     d70:	04c70a00 	strbeq	r0, [r7], #2560	; 0xa00
     d74:	0a010000 	beq	40d7c <__bss_end+0x37ddc>
     d78:	000004df 	ldrdeq	r0, [r0], -pc	; <UNPREDICTABLE>
     d7c:	06390a02 	ldrteq	r0, [r9], -r2, lsl #20
     d80:	0a030000 	beq	c0d88 <__bss_end+0xb7de8>
     d84:	00000b02 	andeq	r0, r0, r2, lsl #22
     d88:	04bb0a04 	ldrteq	r0, [fp], #2564	; 0xa04
     d8c:	00050000 	andeq	r0, r5, r0
     d90:	0005b206 	andeq	fp, r5, r6, lsl #4
     d94:	1b051000 	blne	144d9c <__bss_end+0x13bdfc>
     d98:	0002af08 	andeq	sl, r2, r8, lsl #30
     d9c:	726c0700 	rsbvc	r0, ip, #0, 14
     da0:	131d0500 	tstne	sp, #0, 10
     da4:	000002af 	andeq	r0, r0, pc, lsr #5
     da8:	70730700 	rsbsvc	r0, r3, r0, lsl #14
     dac:	131e0500 	tstne	lr, #0, 10
     db0:	000002af 	andeq	r0, r0, pc, lsr #5
     db4:	63700704 	cmnvs	r0, #4, 14	; 0x100000
     db8:	131f0500 	tstne	pc, #0, 10
     dbc:	000002af 	andeq	r0, r0, pc, lsr #5
     dc0:	09e00e08 	stmibeq	r0!, {r3, r9, sl, fp}^
     dc4:	20050000 	andcs	r0, r5, r0
     dc8:	0002af13 	andeq	sl, r2, r3, lsl pc
     dcc:	02000c00 	andeq	r0, r0, #0, 24
     dd0:	0a540704 	beq	15029e8 <__bss_end+0x14f9a48>
     dd4:	63060000 	movwvs	r0, #24576	; 0x6000
     dd8:	70000007 	andvc	r0, r0, r7
     ddc:	46082805 	strmi	r2, [r8], -r5, lsl #16
     de0:	0e000003 	cdpeq	0, 0, cr0, cr0, cr3, {0}
     de4:	000006a6 	andeq	r0, r0, r6, lsr #13
     de8:	70122a05 	andsvc	r2, r2, r5, lsl #20
     dec:	00000002 	andeq	r0, r0, r2
     df0:	64697007 	strbtvs	r7, [r9], #-7
     df4:	122b0500 	eorne	r0, fp, #0, 10
     df8:	0000005e 	andeq	r0, r0, lr, asr r0
     dfc:	0b350e10 	bleq	d44644 <__bss_end+0xd3b6a4>
     e00:	2c050000 	stccs	0, cr0, [r5], {-0}
     e04:	00023911 	andeq	r3, r2, r1, lsl r9
     e08:	d70e1400 	strle	r1, [lr, -r0, lsl #8]
     e0c:	0500000a 	streq	r0, [r0, #-10]
     e10:	005e122d 	subseq	r1, lr, sp, lsr #4
     e14:	0e180000 	cdpeq	0, 1, cr0, cr8, cr0, {0}
     e18:	000003e9 	andeq	r0, r0, r9, ror #7
     e1c:	5e122e05 	cdppl	14, 1, cr2, cr2, cr5, {0}
     e20:	1c000000 	stcne	0, cr0, [r0], {-0}
     e24:	000a130e 	andeq	r1, sl, lr, lsl #6
     e28:	0c2f0500 	cfstr32eq	mvfx0, [pc], #-0	; e30 <shift+0xe30>
     e2c:	00000346 	andeq	r0, r0, r6, asr #6
     e30:	04720e20 	ldrbteq	r0, [r2], #-3616	; 0xfffff1e0
     e34:	30050000 	andcc	r0, r5, r0
     e38:	00003809 	andeq	r3, r0, r9, lsl #16
     e3c:	640e6000 	strvs	r6, [lr], #-0
     e40:	05000006 	streq	r0, [r0, #-6]
     e44:	004d0e31 	subeq	r0, sp, r1, lsr lr
     e48:	0e640000 	cdpeq	0, 6, cr0, cr4, cr0, {0}
     e4c:	00000961 	andeq	r0, r0, r1, ror #18
     e50:	4d0e3305 	stcmi	3, cr3, [lr, #-20]	; 0xffffffec
     e54:	68000000 	stmdavs	r0, {}	; <UNPREDICTABLE>
     e58:	0009580e 	andeq	r5, r9, lr, lsl #16
     e5c:	0e340500 	cfabs32eq	mvfx0, mvfx4
     e60:	0000004d 	andeq	r0, r0, sp, asr #32
     e64:	fd0f006c 	stc2	0, cr0, [pc, #-432]	; cbc <shift+0xcbc>
     e68:	56000001 	strpl	r0, [r0], -r1
     e6c:	10000003 	andne	r0, r0, r3
     e70:	0000005e 	andeq	r0, r0, lr, asr r0
     e74:	d00b000f 	andle	r0, fp, pc
     e78:	06000004 	streq	r0, [r0], -r4
     e7c:	0059140a 	subseq	r1, r9, sl, lsl #8
     e80:	03050000 	movweq	r0, #20480	; 0x5000
     e84:	00008f5c 	andeq	r8, r0, ip, asr pc
     e88:	00080d08 	andeq	r0, r8, r8, lsl #26
     e8c:	38040500 	stmdacc	r4, {r8, sl}
     e90:	06000000 	streq	r0, [r0], -r0
     e94:	03870c0d 	orreq	r0, r7, #3328	; 0xd00
     e98:	d90a0000 	stmdble	sl, {}	; <UNPREDICTABLE>
     e9c:	0000000b 	andeq	r0, r0, fp
     ea0:	000b4f0a 	andeq	r4, fp, sl, lsl #30
     ea4:	03000100 	movweq	r0, #256	; 0x100
     ea8:	00000368 	andeq	r0, r0, r8, ror #6
     eac:	000df008 	andeq	pc, sp, r8
     eb0:	38040500 	stmdacc	r4, {r8, sl}
     eb4:	06000000 	streq	r0, [r0], -r0
     eb8:	03ab0c14 			; <UNDEFINED> instruction: 0x03ab0c14
     ebc:	a90a0000 	stmdbge	sl, {}	; <UNPREDICTABLE>
     ec0:	0000000c 	andeq	r0, r0, ip
     ec4:	000ed50a 	andeq	sp, lr, sl, lsl #10
     ec8:	03000100 	movweq	r0, #256	; 0x100
     ecc:	0000038c 	andeq	r0, r0, ip, lsl #7
     ed0:	00069306 	andeq	r9, r6, r6, lsl #6
     ed4:	1b060c00 	blne	183edc <__bss_end+0x17af3c>
     ed8:	0003e508 	andeq	lr, r3, r8, lsl #10
     edc:	055c0e00 	ldrbeq	r0, [ip, #-3584]	; 0xfffff200
     ee0:	1d060000 	stcne	0, cr0, [r6, #-0]
     ee4:	0003e519 	andeq	lr, r3, r9, lsl r5
     ee8:	c20e0000 	andgt	r0, lr, #0
     eec:	06000004 	streq	r0, [r0], -r4
     ef0:	03e5191e 	mvneq	r1, #491520	; 0x78000
     ef4:	0e040000 	cdpeq	0, 0, cr0, cr4, cr0, {0}
     ef8:	00000831 	andeq	r0, r0, r1, lsr r8
     efc:	eb131f06 	bl	4c8b1c <__bss_end+0x4bfb7c>
     f00:	08000003 	stmdaeq	r0, {r0, r1}
     f04:	b0040d00 	andlt	r0, r4, r0, lsl #26
     f08:	0d000003 	stceq	0, cr0, [r0, #-12]
     f0c:	0002b604 	andeq	fp, r2, r4, lsl #12
     f10:	09cf1100 	stmibeq	pc, {r8, ip}^	; <UNPREDICTABLE>
     f14:	06140000 	ldreq	r0, [r4], -r0
     f18:	06730722 	ldrbteq	r0, [r3], -r2, lsr #14
     f1c:	ff0e0000 			; <UNDEFINED> instruction: 0xff0e0000
     f20:	06000008 	streq	r0, [r0], -r8
     f24:	004d1226 	subeq	r1, sp, r6, lsr #4
     f28:	0e000000 	cdpeq	0, 0, cr0, cr0, cr0, {0}
     f2c:	000008a1 	andeq	r0, r0, r1, lsr #17
     f30:	e51d2906 	ldr	r2, [sp, #-2310]	; 0xfffff6fa
     f34:	04000003 	streq	r0, [r0], #-3
     f38:	0006410e 	andeq	r4, r6, lr, lsl #2
     f3c:	1d2c0600 	stcne	6, cr0, [ip, #-0]
     f40:	000003e5 	andeq	r0, r0, r5, ror #7
     f44:	09091208 	stmdbeq	r9, {r3, r9, ip}
     f48:	2f060000 	svccs	0x00060000
     f4c:	0006700e 	andeq	r7, r6, lr
     f50:	00043900 	andeq	r3, r4, r0, lsl #18
     f54:	00044400 	andeq	r4, r4, r0, lsl #8
     f58:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
     f5c:	e5140000 	ldr	r0, [r4, #-0]
     f60:	00000003 	andeq	r0, r0, r3
     f64:	00079415 	andeq	r9, r7, r5, lsl r4
     f68:	0e310600 	cfmsuba32eq	mvax0, mvax0, mvfx1, mvfx0
     f6c:	0000073a 	andeq	r0, r0, sl, lsr r7
     f70:	000001f0 	strdeq	r0, [r0], -r0	; <UNPREDICTABLE>
     f74:	0000045c 	andeq	r0, r0, ip, asr r4
     f78:	00000467 	andeq	r0, r0, r7, ror #8
     f7c:	00067813 	andeq	r7, r6, r3, lsl r8
     f80:	03eb1400 	mvneq	r1, #0, 8
     f84:	16000000 	strne	r0, [r0], -r0
     f88:	00000b16 	andeq	r0, r0, r6, lsl fp
     f8c:	e81d3506 	ldmda	sp, {r1, r2, r8, sl, ip, sp}
     f90:	e5000007 	str	r0, [r0, #-7]
     f94:	02000003 	andeq	r0, r0, #3
     f98:	00000480 	andeq	r0, r0, r0, lsl #9
     f9c:	00000486 	andeq	r0, r0, r6, lsl #9
     fa0:	00067813 	andeq	r7, r6, r3, lsl r8
     fa4:	2c160000 	ldccs	0, cr0, [r6], {-0}
     fa8:	06000006 	streq	r0, [r0], -r6
     fac:	09191d37 	ldmdbeq	r9, {r0, r1, r2, r4, r5, r8, sl, fp, ip}
     fb0:	03e50000 	mvneq	r0, #0
     fb4:	9f020000 	svcls	0x00020000
     fb8:	a5000004 	strge	r0, [r0, #-4]
     fbc:	13000004 	movwne	r0, #4
     fc0:	00000678 	andeq	r0, r0, r8, ror r6
     fc4:	08b41700 	ldmeq	r4!, {r8, r9, sl, ip}
     fc8:	39060000 	stmdbcc	r6, {}	; <UNPREDICTABLE>
     fcc:	00069131 	andeq	r9, r6, r1, lsr r1
     fd0:	16020c00 	strne	r0, [r2], -r0, lsl #24
     fd4:	000009cf 	andeq	r0, r0, pc, asr #19
     fd8:	a3093c06 	movwge	r3, #39942	; 0x9c06
     fdc:	78000007 	stmdavc	r0, {r0, r1, r2}
     fe0:	01000006 	tsteq	r0, r6
     fe4:	000004cc 	andeq	r0, r0, ip, asr #9
     fe8:	000004d2 	ldrdeq	r0, [r0], -r2
     fec:	00067813 	andeq	r7, r6, r3, lsl r8
     ff0:	b2160000 	andslt	r0, r6, #0
     ff4:	06000006 	streq	r0, [r0], -r6
     ff8:	0518123f 	ldreq	r1, [r8, #-575]	; 0xfffffdc1
     ffc:	004d0000 	subeq	r0, sp, r0
    1000:	eb010000 	bl	41008 <__bss_end+0x38068>
    1004:	00000004 	andeq	r0, r0, r4
    1008:	13000005 	movwne	r0, #5
    100c:	00000678 	andeq	r0, r0, r8, ror r6
    1010:	00069a14 	andeq	r9, r6, r4, lsl sl
    1014:	005e1400 	subseq	r1, lr, r0, lsl #8
    1018:	f0140000 			; <UNDEFINED> instruction: 0xf0140000
    101c:	00000001 	andeq	r0, r0, r1
    1020:	000b4618 	andeq	r4, fp, r8, lsl r6
    1024:	0e420600 	cdpeq	6, 4, cr0, cr2, cr0, {0}
    1028:	000005bf 			; <UNDEFINED> instruction: 0x000005bf
    102c:	00051501 	andeq	r1, r5, r1, lsl #10
    1030:	00051b00 	andeq	r1, r5, r0, lsl #22
    1034:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
    1038:	16000000 	strne	r0, [r0], -r0
    103c:	000004fa 	strdeq	r0, [r0], -sl
    1040:	61174506 	tstvs	r7, r6, lsl #10
    1044:	eb000005 	bl	1060 <shift+0x1060>
    1048:	01000003 	tsteq	r0, r3
    104c:	00000534 	andeq	r0, r0, r4, lsr r5
    1050:	0000053a 	andeq	r0, r0, sl, lsr r5
    1054:	0006a013 	andeq	sl, r6, r3, lsl r0
    1058:	31160000 	tstcc	r6, r0
    105c:	0600000a 	streq	r0, [r0], -sl
    1060:	03ff1748 	mvnseq	r1, #72, 14	; 0x1200000
    1064:	03eb0000 	mvneq	r0, #0
    1068:	53010000 	movwpl	r0, #4096	; 0x1000
    106c:	5e000005 	cdppl	0, 0, cr0, cr0, cr5, {0}
    1070:	13000005 	movwne	r0, #5
    1074:	000006a0 	andeq	r0, r0, r0, lsr #13
    1078:	00004d14 	andeq	r4, r0, r4, lsl sp
    107c:	ea180000 	b	601084 <__bss_end+0x5f80e4>
    1080:	06000005 	streq	r0, [r0], -r5
    1084:	08c20e4b 	stmiaeq	r2, {r0, r1, r3, r6, r9, sl, fp}^
    1088:	73010000 	movwvc	r0, #4096	; 0x1000
    108c:	79000005 	stmdbvc	r0, {r0, r2}
    1090:	13000005 	movwne	r0, #5
    1094:	00000678 	andeq	r0, r0, r8, ror r6
    1098:	07941600 	ldreq	r1, [r4, r0, lsl #12]
    109c:	4d060000 	stcmi	0, cr0, [r6, #-0]
    10a0:	00096f0e 	andeq	r6, r9, lr, lsl #30
    10a4:	0001f000 	andeq	pc, r1, r0
    10a8:	05920100 	ldreq	r0, [r2, #256]	; 0x100
    10ac:	059d0000 	ldreq	r0, [sp]
    10b0:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
    10b4:	14000006 	strne	r0, [r0], #-6
    10b8:	0000004d 	andeq	r0, r0, sp, asr #32
    10bc:	04a71600 	strteq	r1, [r7], #1536	; 0x600
    10c0:	50060000 	andpl	r0, r6, r0
    10c4:	00042c12 	andeq	r2, r4, r2, lsl ip
    10c8:	00004d00 	andeq	r4, r0, r0, lsl #26
    10cc:	05b60100 	ldreq	r0, [r6, #256]!	; 0x100
    10d0:	05c10000 	strbeq	r0, [r1]
    10d4:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
    10d8:	14000006 	strne	r0, [r0], #-6
    10dc:	000001fd 	strdeq	r0, [r0], -sp
    10e0:	045f1600 	ldrbeq	r1, [pc], #-1536	; 10e8 <shift+0x10e8>
    10e4:	53060000 	movwpl	r0, #24576	; 0x6000
    10e8:	000b5a0e 	andeq	r5, fp, lr, lsl #20
    10ec:	0001f000 	andeq	pc, r1, r0
    10f0:	05da0100 	ldrbeq	r0, [sl, #256]	; 0x100
    10f4:	05e50000 	strbeq	r0, [r5, #0]!
    10f8:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
    10fc:	14000006 	strne	r0, [r0], #-6
    1100:	0000004d 	andeq	r0, r0, sp, asr #32
    1104:	04811800 	streq	r1, [r1], #2048	; 0x800
    1108:	56060000 	strpl	r0, [r6], -r0
    110c:	000a850e 	andeq	r8, sl, lr, lsl #10
    1110:	05fa0100 	ldrbeq	r0, [sl, #256]!	; 0x100
    1114:	06190000 	ldreq	r0, [r9], -r0
    1118:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
    111c:	14000006 	strne	r0, [r0], #-6
    1120:	000000a9 	andeq	r0, r0, r9, lsr #1
    1124:	00004d14 	andeq	r4, r0, r4, lsl sp
    1128:	004d1400 	subeq	r1, sp, r0, lsl #8
    112c:	4d140000 	ldcmi	0, cr0, [r4, #-0]
    1130:	14000000 	strne	r0, [r0], #-0
    1134:	000006a6 	andeq	r0, r0, r6, lsr #13
    1138:	0b861800 	bleq	fe187140 <__bss_end+0xfe17e1a0>
    113c:	58060000 	stmdapl	r6, {}	; <UNPREDICTABLE>
    1140:	000c000e 	andeq	r0, ip, lr
    1144:	062e0100 	strteq	r0, [lr], -r0, lsl #2
    1148:	064d0000 	strbeq	r0, [sp], -r0
    114c:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
    1150:	14000006 	strne	r0, [r0], #-6
    1154:	000000e0 	andeq	r0, r0, r0, ror #1
    1158:	00004d14 	andeq	r4, r0, r4, lsl sp
    115c:	004d1400 	subeq	r1, sp, r0, lsl #8
    1160:	4d140000 	ldcmi	0, cr0, [r4, #-0]
    1164:	14000000 	strne	r0, [r0], #-0
    1168:	000006a6 	andeq	r0, r0, r6, lsr #13
    116c:	04941900 	ldreq	r1, [r4], #2304	; 0x900
    1170:	5b060000 	blpl	181178 <__bss_end+0x1781d8>
    1174:	0008410e 	andeq	r4, r8, lr, lsl #2
    1178:	0001f000 	andeq	pc, r1, r0
    117c:	06620100 	strbteq	r0, [r2], -r0, lsl #2
    1180:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
    1184:	14000006 	strne	r0, [r0], #-6
    1188:	00000368 	andeq	r0, r0, r8, ror #6
    118c:	0006ac14 	andeq	sl, r6, r4, lsl ip
    1190:	03000000 	movweq	r0, #0
    1194:	000003f1 	strdeq	r0, [r0], -r1
    1198:	03f1040d 	mvnseq	r0, #218103808	; 0xd000000
    119c:	e51a0000 	ldr	r0, [sl, #-0]
    11a0:	8b000003 	blhi	11b4 <shift+0x11b4>
    11a4:	91000006 	tstls	r0, r6
    11a8:	13000006 	movwne	r0, #6
    11ac:	00000678 	andeq	r0, r0, r8, ror r6
    11b0:	03f11b00 	mvnseq	r1, #0, 22
    11b4:	067e0000 	ldrbteq	r0, [lr], -r0
    11b8:	040d0000 	streq	r0, [sp], #-0
    11bc:	0000003f 	andeq	r0, r0, pc, lsr r0
    11c0:	0673040d 	ldrbteq	r0, [r3], -sp, lsl #8
    11c4:	041c0000 	ldreq	r0, [ip], #-0
    11c8:	00000065 	andeq	r0, r0, r5, rrx
    11cc:	2c0f041d 	cfstrscs	mvf0, [pc], {29}
    11d0:	be000000 	cdplt	0, 0, cr0, cr0, cr0, {0}
    11d4:	10000006 	andne	r0, r0, r6
    11d8:	0000005e 	andeq	r0, r0, lr, asr r0
    11dc:	ae030009 	cdpge	0, 0, cr0, cr3, cr9, {0}
    11e0:	1e000006 	cdpne	0, 0, cr0, cr0, cr6, {0}
    11e4:	00000d52 	andeq	r0, r0, r2, asr sp
    11e8:	be0ca401 	cdplt	4, 0, cr10, cr12, cr1, {0}
    11ec:	05000006 	streq	r0, [r0, #-6]
    11f0:	008f6003 	addeq	r6, pc, r3
    11f4:	0cc21f00 	stcleq	15, cr1, [r2], {0}
    11f8:	a6010000 	strge	r0, [r1], -r0
    11fc:	000de40a 	andeq	lr, sp, sl, lsl #8
    1200:	00004d00 	andeq	r4, r0, r0, lsl #26
    1204:	0086e800 	addeq	lr, r6, r0, lsl #16
    1208:	0000b000 	andeq	fp, r0, r0
    120c:	339c0100 	orrscc	r0, ip, #0, 2
    1210:	20000007 	andcs	r0, r0, r7
    1214:	00001077 	andeq	r1, r0, r7, ror r0
    1218:	f71ba601 			; <UNDEFINED> instruction: 0xf71ba601
    121c:	03000001 	movweq	r0, #1
    1220:	207fac91 			; <UNDEFINED> instruction: 0x207fac91
    1224:	00000e43 	andeq	r0, r0, r3, asr #28
    1228:	4d2aa601 	stcmi	6, cr10, [sl, #-4]!
    122c:	03000000 	movweq	r0, #0
    1230:	1e7fa891 	mrcne	8, 3, sl, cr15, cr1, {4}
    1234:	00000dcd 	andeq	r0, r0, sp, asr #27
    1238:	330aa801 	movwcc	sl, #43009	; 0xa801
    123c:	03000007 	movweq	r0, #7
    1240:	1e7fb491 	mrcne	4, 3, fp, cr15, cr1, {4}
    1244:	00000cbd 			; <UNDEFINED> instruction: 0x00000cbd
    1248:	3809ac01 	stmdacc	r9, {r0, sl, fp, sp, pc}
    124c:	02000000 	andeq	r0, r0, #0
    1250:	0f007491 	svceq	0x00007491
    1254:	00000025 	andeq	r0, r0, r5, lsr #32
    1258:	00000743 	andeq	r0, r0, r3, asr #14
    125c:	00005e10 	andeq	r5, r0, r0, lsl lr
    1260:	21003f00 	tstcs	r0, r0, lsl #30
    1264:	00000e28 	andeq	r0, r0, r8, lsr #28
    1268:	fa0a9801 	blx	2a7274 <__bss_end+0x29e2d4>
    126c:	4d00000e 	stcmi	0, cr0, [r0, #-56]	; 0xffffffc8
    1270:	ac000000 	stcge	0, cr0, [r0], {-0}
    1274:	3c000086 	stccc	0, cr0, [r0], {134}	; 0x86
    1278:	01000000 	mrseq	r0, (UNDEF: 0)
    127c:	0007809c 	muleq	r7, ip, r0
    1280:	65722200 	ldrbvs	r2, [r2, #-512]!	; 0xfffffe00
    1284:	9a010071 	bls	41450 <__bss_end+0x384b0>
    1288:	0003ab20 	andeq	sl, r3, r0, lsr #22
    128c:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    1290:	000dd91e 	andeq	sp, sp, lr, lsl r9
    1294:	0e9b0100 	fmleqe	f0, f3, f0
    1298:	0000004d 	andeq	r0, r0, sp, asr #32
    129c:	00709102 	rsbseq	r9, r0, r2, lsl #2
    12a0:	000e4c23 	andeq	r4, lr, r3, lsr #24
    12a4:	068f0100 	streq	r0, [pc], r0, lsl #2
    12a8:	00000cde 	ldrdeq	r0, [r0], -lr
    12ac:	00008670 	andeq	r8, r0, r0, ror r6
    12b0:	0000003c 	andeq	r0, r0, ip, lsr r0
    12b4:	07b99c01 	ldreq	r9, [r9, r1, lsl #24]!
    12b8:	20200000 	eorcs	r0, r0, r0
    12bc:	0100000d 	tsteq	r0, sp
    12c0:	004d218f 	subeq	r2, sp, pc, lsl #3
    12c4:	91020000 	mrsls	r0, (UNDEF: 2)
    12c8:	6572226c 	ldrbvs	r2, [r2, #-620]!	; 0xfffffd94
    12cc:	91010071 	tstls	r1, r1, ror r0
    12d0:	0003ab20 	andeq	sl, r3, r0, lsr #22
    12d4:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    12d8:	0e052100 	adfeqs	f2, f5, f0
    12dc:	83010000 	movwhi	r0, #4096	; 0x1000
    12e0:	000d6e0a 	andeq	r6, sp, sl, lsl #28
    12e4:	00004d00 	andeq	r4, r0, r0, lsl #26
    12e8:	00863400 	addeq	r3, r6, r0, lsl #8
    12ec:	00003c00 	andeq	r3, r0, r0, lsl #24
    12f0:	f69c0100 			; <UNDEFINED> instruction: 0xf69c0100
    12f4:	22000007 	andcs	r0, r0, #7
    12f8:	00716572 	rsbseq	r6, r1, r2, ror r5
    12fc:	87208501 	strhi	r8, [r0, -r1, lsl #10]!
    1300:	02000003 	andeq	r0, r0, #3
    1304:	b61e7491 			; <UNDEFINED> instruction: 0xb61e7491
    1308:	0100000c 	tsteq	r0, ip
    130c:	004d0e86 	subeq	r0, sp, r6, lsl #29
    1310:	91020000 	mrsls	r0, (UNDEF: 2)
    1314:	5a210070 	bpl	8414dc <__bss_end+0x83853c>
    1318:	01000010 	tsteq	r0, r0, lsl r0
    131c:	0d340a77 	vldmdbeq	r4!, {s0-s118}
    1320:	004d0000 	subeq	r0, sp, r0
    1324:	85f80000 	ldrbhi	r0, [r8, #0]!
    1328:	003c0000 	eorseq	r0, ip, r0
    132c:	9c010000 	stcls	0, cr0, [r1], {-0}
    1330:	00000833 	andeq	r0, r0, r3, lsr r8
    1334:	71657222 	cmnvc	r5, r2, lsr #4
    1338:	20790100 	rsbscs	r0, r9, r0, lsl #2
    133c:	00000387 	andeq	r0, r0, r7, lsl #7
    1340:	1e749102 	expnes	f1, f2
    1344:	00000cb6 			; <UNDEFINED> instruction: 0x00000cb6
    1348:	4d0e7a01 	vstrmi	s14, [lr, #-4]
    134c:	02000000 	andeq	r0, r0, #0
    1350:	21007091 	swpcs	r7, r1, [r0]
    1354:	00000d82 	andeq	r0, r0, r2, lsl #27
    1358:	c5066b01 	strgt	r6, [r6, #-2817]	; 0xfffff4ff
    135c:	f000000e 			; <UNDEFINED> instruction: 0xf000000e
    1360:	a4000001 	strge	r0, [r0], #-1
    1364:	54000085 	strpl	r0, [r0], #-133	; 0xffffff7b
    1368:	01000000 	mrseq	r0, (UNDEF: 0)
    136c:	00087f9c 	muleq	r8, ip, pc	; <UNPREDICTABLE>
    1370:	0dd92000 	ldcleq	0, cr2, [r9]
    1374:	6b010000 	blvs	4137c <__bss_end+0x383dc>
    1378:	00004d15 	andeq	r4, r0, r5, lsl sp
    137c:	6c910200 	lfmvs	f0, 4, [r1], {0}
    1380:	00095820 	andeq	r5, r9, r0, lsr #16
    1384:	256b0100 	strbcs	r0, [fp, #-256]!	; 0xffffff00
    1388:	0000004d 	andeq	r0, r0, sp, asr #32
    138c:	1e689102 	lgnnee	f1, f2
    1390:	00001052 	andeq	r1, r0, r2, asr r0
    1394:	4d0e6d01 	stcmi	13, cr6, [lr, #-4]
    1398:	02000000 	andeq	r0, r0, #0
    139c:	21007491 			; <UNDEFINED> instruction: 0x21007491
    13a0:	00000cf5 	strdeq	r0, [r0], -r5
    13a4:	31125e01 	tstcc	r2, r1, lsl #28
    13a8:	8b00000f 	blhi	13ec <shift+0x13ec>
    13ac:	54000000 	strpl	r0, [r0], #-0
    13b0:	50000085 	andpl	r0, r0, r5, lsl #1
    13b4:	01000000 	mrseq	r0, (UNDEF: 0)
    13b8:	0008da9c 	muleq	r8, ip, sl
    13bc:	0ed02000 	cdpeq	0, 13, cr2, cr0, cr0, {0}
    13c0:	5e010000 	cdppl	0, 0, cr0, cr1, cr0, {0}
    13c4:	00004d20 	andeq	r4, r0, r0, lsr #26
    13c8:	6c910200 	lfmvs	f0, 4, [r1], {0}
    13cc:	000e0e20 	andeq	r0, lr, r0, lsr #28
    13d0:	2f5e0100 	svccs	0x005e0100
    13d4:	0000004d 	andeq	r0, r0, sp, asr #32
    13d8:	20689102 	rsbcs	r9, r8, r2, lsl #2
    13dc:	00000958 	andeq	r0, r0, r8, asr r9
    13e0:	4d3f5e01 	ldcmi	14, cr5, [pc, #-4]!	; 13e4 <shift+0x13e4>
    13e4:	02000000 	andeq	r0, r0, #0
    13e8:	521e6491 	andspl	r6, lr, #-1862270976	; 0x91000000
    13ec:	01000010 	tsteq	r0, r0, lsl r0
    13f0:	008b1660 	addeq	r1, fp, r0, ror #12
    13f4:	91020000 	mrsls	r0, (UNDEF: 2)
    13f8:	67210074 			; <UNDEFINED> instruction: 0x67210074
    13fc:	0100000f 	tsteq	r0, pc
    1400:	0cfa0a52 	vldmiaeq	sl!, {s1-s82}
    1404:	004d0000 	subeq	r0, sp, r0
    1408:	85100000 	ldrhi	r0, [r0, #-0]
    140c:	00440000 	subeq	r0, r4, r0
    1410:	9c010000 	stcls	0, cr0, [r1], {-0}
    1414:	00000926 	andeq	r0, r0, r6, lsr #18
    1418:	000ed020 	andeq	sp, lr, r0, lsr #32
    141c:	1a520100 	bne	1481824 <__bss_end+0x1478884>
    1420:	0000004d 	andeq	r0, r0, sp, asr #32
    1424:	206c9102 	rsbcs	r9, ip, r2, lsl #2
    1428:	00000e0e 	andeq	r0, r0, lr, lsl #28
    142c:	4d295201 	sfmmi	f5, 4, [r9, #-4]!
    1430:	02000000 	andeq	r0, r0, #0
    1434:	601e6891 	mulsvs	lr, r1, r8
    1438:	0100000f 	tsteq	r0, pc
    143c:	004d0e54 	subeq	r0, sp, r4, asr lr
    1440:	91020000 	mrsls	r0, (UNDEF: 2)
    1444:	5a210074 	bpl	84161c <__bss_end+0x83867c>
    1448:	0100000f 	tsteq	r0, pc
    144c:	0f3c0a45 	svceq	0x003c0a45
    1450:	004d0000 	subeq	r0, sp, r0
    1454:	84c00000 	strbhi	r0, [r0], #0
    1458:	00500000 	subseq	r0, r0, r0
    145c:	9c010000 	stcls	0, cr0, [r1], {-0}
    1460:	00000981 	andeq	r0, r0, r1, lsl #19
    1464:	000ed020 	andeq	sp, lr, r0, lsr #32
    1468:	19450100 	stmdbne	r5, {r8}^
    146c:	0000004d 	andeq	r0, r0, sp, asr #32
    1470:	206c9102 	rsbcs	r9, ip, r2, lsl #2
    1474:	00000dae 	andeq	r0, r0, lr, lsr #27
    1478:	1d304501 	cfldr32ne	mvfx4, [r0, #-4]!
    147c:	02000001 	andeq	r0, r0, #1
    1480:	14206891 	strtne	r6, [r0], #-2193	; 0xfffff76f
    1484:	0100000e 	tsteq	r0, lr
    1488:	06ac4145 	strteq	r4, [ip], r5, asr #2
    148c:	91020000 	mrsls	r0, (UNDEF: 2)
    1490:	10521e64 	subsne	r1, r2, r4, ror #28
    1494:	47010000 	strmi	r0, [r1, -r0]
    1498:	00004d0e 	andeq	r4, r0, lr, lsl #26
    149c:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    14a0:	0ca32300 	stceq	3, cr2, [r3]
    14a4:	3f010000 	svccc	0x00010000
    14a8:	000db806 	andeq	fp, sp, r6, lsl #16
    14ac:	00849400 	addeq	r9, r4, r0, lsl #8
    14b0:	00002c00 	andeq	r2, r0, r0, lsl #24
    14b4:	ab9c0100 	blge	fe7018bc <__bss_end+0xfe6f891c>
    14b8:	20000009 	andcs	r0, r0, r9
    14bc:	00000ed0 	ldrdeq	r0, [r0], -r0	; <UNPREDICTABLE>
    14c0:	4d153f01 	ldcmi	15, cr3, [r5, #-4]
    14c4:	02000000 	andeq	r0, r0, #0
    14c8:	21007491 			; <UNDEFINED> instruction: 0x21007491
    14cc:	00000dd3 	ldrdeq	r0, [r0], -r3
    14d0:	1a0a3201 	bne	28dcdc <__bss_end+0x284d3c>
    14d4:	4d00000e 	stcmi	0, cr0, [r0, #-56]	; 0xffffffc8
    14d8:	44000000 	strmi	r0, [r0], #-0
    14dc:	50000084 	andpl	r0, r0, r4, lsl #1
    14e0:	01000000 	mrseq	r0, (UNDEF: 0)
    14e4:	000a069c 	muleq	sl, ip, r6
    14e8:	0ed02000 	cdpeq	0, 13, cr2, cr0, cr0, {0}
    14ec:	32010000 	andcc	r0, r1, #0
    14f0:	00004d19 	andeq	r4, r0, r9, lsl sp
    14f4:	6c910200 	lfmvs	f0, 4, [r1], {0}
    14f8:	000f7d20 	andeq	r7, pc, r0, lsr #26
    14fc:	2b320100 	blcs	c81904 <__bss_end+0xc78964>
    1500:	000001f7 	strdeq	r0, [r0], -r7
    1504:	20689102 	rsbcs	r9, r8, r2, lsl #2
    1508:	00000e47 	andeq	r0, r0, r7, asr #28
    150c:	4d3c3201 	lfmmi	f3, 4, [ip, #-4]!
    1510:	02000000 	andeq	r0, r0, #0
    1514:	2b1e6491 	blcs	79a760 <__bss_end+0x7917c0>
    1518:	0100000f 	tsteq	r0, pc
    151c:	004d0e34 	subeq	r0, sp, r4, lsr lr
    1520:	91020000 	mrsls	r0, (UNDEF: 2)
    1524:	7c210074 	stcvc	0, cr0, [r1], #-464	; 0xfffffe30
    1528:	01000010 	tsteq	r0, r0, lsl r0
    152c:	0f840a25 	svceq	0x00840a25
    1530:	004d0000 	subeq	r0, sp, r0
    1534:	83f40000 	mvnshi	r0, #0
    1538:	00500000 	subseq	r0, r0, r0
    153c:	9c010000 	stcls	0, cr0, [r1], {-0}
    1540:	00000a61 	andeq	r0, r0, r1, ror #20
    1544:	000ed020 	andeq	sp, lr, r0, lsr #32
    1548:	18250100 	stmdane	r5!, {r8}
    154c:	0000004d 	andeq	r0, r0, sp, asr #32
    1550:	206c9102 	rsbcs	r9, ip, r2, lsl #2
    1554:	00000f7d 	andeq	r0, r0, sp, ror pc
    1558:	672a2501 	strvs	r2, [sl, -r1, lsl #10]!
    155c:	0200000a 	andeq	r0, r0, #10
    1560:	47206891 			; <UNDEFINED> instruction: 0x47206891
    1564:	0100000e 	tsteq	r0, lr
    1568:	004d3b25 	subeq	r3, sp, r5, lsr #22
    156c:	91020000 	mrsls	r0, (UNDEF: 2)
    1570:	0cc71e64 	stcleq	14, cr1, [r7], {100}	; 0x64
    1574:	27010000 	strcs	r0, [r1, -r0]
    1578:	00004d0e 	andeq	r4, r0, lr, lsl #26
    157c:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    1580:	25040d00 	strcs	r0, [r4, #-3328]	; 0xfffff300
    1584:	03000000 	movweq	r0, #0
    1588:	00000a61 	andeq	r0, r0, r1, ror #20
    158c:	000ddf21 	andeq	sp, sp, r1, lsr #30
    1590:	0a190100 	beq	641998 <__bss_end+0x6389f8>
    1594:	00001088 	andeq	r1, r0, r8, lsl #1
    1598:	0000004d 	andeq	r0, r0, sp, asr #32
    159c:	000083b0 			; <UNDEFINED> instruction: 0x000083b0
    15a0:	00000044 	andeq	r0, r0, r4, asr #32
    15a4:	0ab89c01 	beq	fee285b0 <__bss_end+0xfee1f610>
    15a8:	73200000 	nopvc	{0}	; <UNPREDICTABLE>
    15ac:	01000010 	tsteq	r0, r0, lsl r0
    15b0:	01f71b19 	mvnseq	r1, r9, lsl fp
    15b4:	91020000 	mrsls	r0, (UNDEF: 2)
    15b8:	0f78206c 	svceq	0x0078206c
    15bc:	19010000 	stmdbne	r1, {}	; <UNPREDICTABLE>
    15c0:	0001c635 	andeq	ip, r1, r5, lsr r6
    15c4:	68910200 	ldmvs	r1, {r9}
    15c8:	000ed01e 	andeq	sp, lr, lr, lsl r0
    15cc:	0e1b0100 	mufeqe	f0, f3, f0
    15d0:	0000004d 	andeq	r0, r0, sp, asr #32
    15d4:	00749102 	rsbseq	r9, r4, r2, lsl #2
    15d8:	000d1424 	andeq	r1, sp, r4, lsr #8
    15dc:	06140100 	ldreq	r0, [r4], -r0, lsl #2
    15e0:	00000ccd 	andeq	r0, r0, sp, asr #25
    15e4:	00008394 	muleq	r0, r4, r3
    15e8:	0000001c 	andeq	r0, r0, ip, lsl r0
    15ec:	6e239c01 	cdpvs	12, 2, cr9, cr3, cr1, {0}
    15f0:	0100000f 	tsteq	r0, pc
    15f4:	0da0060e 	stceq	6, cr0, [r0, #56]!	; 0x38
    15f8:	83680000 	cmnhi	r8, #0
    15fc:	002c0000 	eoreq	r0, ip, r0
    1600:	9c010000 	stcls	0, cr0, [r1], {-0}
    1604:	00000af8 	strdeq	r0, [r0], -r8
    1608:	000d0b20 	andeq	r0, sp, r0, lsr #22
    160c:	140e0100 	strne	r0, [lr], #-256	; 0xffffff00
    1610:	00000038 	andeq	r0, r0, r8, lsr r0
    1614:	00749102 	rsbseq	r9, r4, r2, lsl #2
    1618:	00108125 	andseq	r8, r0, r5, lsr #2
    161c:	0a040100 	beq	101a24 <__bss_end+0xf8a84>
    1620:	00000dc2 	andeq	r0, r0, r2, asr #27
    1624:	0000004d 	andeq	r0, r0, sp, asr #32
    1628:	0000833c 	andeq	r8, r0, ip, lsr r3
    162c:	0000002c 	andeq	r0, r0, ip, lsr #32
    1630:	70229c01 	eorvc	r9, r2, r1, lsl #24
    1634:	01006469 	tsteq	r0, r9, ror #8
    1638:	004d0e06 	subeq	r0, sp, r6, lsl #28
    163c:	91020000 	mrsls	r0, (UNDEF: 2)
    1640:	2e000074 	mcrcs	0, 0, r0, cr0, cr4, {3}
    1644:	04000003 	streq	r0, [r0], #-3
    1648:	0006af00 	andeq	sl, r6, r0, lsl #30
    164c:	90010400 	andls	r0, r1, r0, lsl #8
    1650:	0400000f 	streq	r0, [r0], #-15
    1654:	000010c8 	andeq	r1, r0, r8, asr #1
    1658:	00000c58 	andeq	r0, r0, r8, asr ip
    165c:	00008798 	muleq	r0, r8, r7
    1660:	000004b8 			; <UNDEFINED> instruction: 0x000004b8
    1664:	000007f2 	strdeq	r0, [r0], -r2
    1668:	00004902 	andeq	r4, r0, r2, lsl #18
    166c:	11310300 	teqne	r1, r0, lsl #6
    1670:	05010000 	streq	r0, [r1, #-0]
    1674:	00006110 	andeq	r6, r0, r0, lsl r1
    1678:	31301100 	teqcc	r0, r0, lsl #2
    167c:	35343332 	ldrcc	r3, [r4, #-818]!	; 0xfffffcce
    1680:	39383736 	ldmdbcc	r8!, {r1, r2, r4, r5, r8, r9, sl, ip, sp}
    1684:	44434241 	strbmi	r4, [r3], #-577	; 0xfffffdbf
    1688:	00004645 	andeq	r4, r0, r5, asr #12
    168c:	01030104 	tsteq	r3, r4, lsl #2
    1690:	00000025 	andeq	r0, r0, r5, lsr #32
    1694:	00007405 	andeq	r7, r0, r5, lsl #8
    1698:	00006100 	andeq	r6, r0, r0, lsl #2
    169c:	00660600 	rsbeq	r0, r6, r0, lsl #12
    16a0:	00100000 	andseq	r0, r0, r0
    16a4:	00005107 	andeq	r5, r0, r7, lsl #2
    16a8:	07040800 	streq	r0, [r4, -r0, lsl #16]
    16ac:	00000a59 	andeq	r0, r0, r9, asr sl
    16b0:	ee080108 	adfe	f0, f0, #0.0
    16b4:	0700000a 	streq	r0, [r0, -sl]
    16b8:	0000006d 	andeq	r0, r0, sp, rrx
    16bc:	00002a09 	andeq	r2, r0, r9, lsl #20
    16c0:	11600a00 	cmnne	r0, r0, lsl #20
    16c4:	64010000 	strvs	r0, [r1], #-0
    16c8:	00114b06 	andseq	r4, r1, r6, lsl #22
    16cc:	008bd000 	addeq	sp, fp, r0
    16d0:	00008000 	andeq	r8, r0, r0
    16d4:	fb9c0100 	blx	fe701ade <__bss_end+0xfe6f8b3e>
    16d8:	0b000000 	bleq	16e0 <shift+0x16e0>
    16dc:	00637273 	rsbeq	r7, r3, r3, ror r2
    16e0:	fb196401 	blx	65a6ee <__bss_end+0x65174e>
    16e4:	02000000 	andeq	r0, r0, #0
    16e8:	640b6491 	strvs	r6, [fp], #-1169	; 0xfffffb6f
    16ec:	01007473 	tsteq	r0, r3, ror r4
    16f0:	01022464 	tsteq	r2, r4, ror #8
    16f4:	91020000 	mrsls	r0, (UNDEF: 2)
    16f8:	756e0b60 	strbvc	r0, [lr, #-2912]!	; 0xfffff4a0
    16fc:	6401006d 	strvs	r0, [r1], #-109	; 0xffffff93
    1700:	0001042d 	andeq	r0, r1, sp, lsr #8
    1704:	5c910200 	lfmpl	f0, 4, [r1], {0}
    1708:	0011ba0c 	andseq	fp, r1, ip, lsl #20
    170c:	0e660100 	poweqs	f0, f6, f0
    1710:	0000010b 	andeq	r0, r0, fp, lsl #2
    1714:	0c709102 	ldfeqp	f1, [r0], #-8
    1718:	0000113d 	andeq	r1, r0, sp, lsr r1
    171c:	11086701 	tstne	r8, r1, lsl #14
    1720:	02000001 	andeq	r0, r0, #1
    1724:	f80d6c91 			; <UNDEFINED> instruction: 0xf80d6c91
    1728:	4800008b 	stmdami	r0, {r0, r1, r3, r7}
    172c:	0e000000 	cdpeq	0, 0, cr0, cr0, cr0, {0}
    1730:	69010069 	stmdbvs	r1, {r0, r3, r5, r6}
    1734:	0001040b 	andeq	r0, r1, fp, lsl #8
    1738:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    173c:	040f0000 	streq	r0, [pc], #-0	; 1744 <shift+0x1744>
    1740:	00000101 	andeq	r0, r0, r1, lsl #2
    1744:	12041110 	andne	r1, r4, #16, 2
    1748:	6e690504 	cdpvs	5, 6, cr0, cr9, cr4, {0}
    174c:	040f0074 	streq	r0, [pc], #-116	; 1754 <shift+0x1754>
    1750:	00000074 	andeq	r0, r0, r4, ror r0
    1754:	006d040f 	rsbeq	r0, sp, pc, lsl #8
    1758:	af0a0000 	svcge	0x000a0000
    175c:	01000010 	tsteq	r0, r0, lsl r0
    1760:	10bc065c 	adcsne	r0, ip, ip, asr r6
    1764:	8b680000 	blhi	1a0176c <__bss_end+0x19f87cc>
    1768:	00680000 	rsbeq	r0, r8, r0
    176c:	9c010000 	stcls	0, cr0, [r1], {-0}
    1770:	00000176 	andeq	r0, r0, r6, ror r1
    1774:	0011b313 	andseq	fp, r1, r3, lsl r3
    1778:	125c0100 	subsne	r0, ip, #0, 2
    177c:	00000102 	andeq	r0, r0, r2, lsl #2
    1780:	136c9102 	cmnne	ip, #-2147483648	; 0x80000000
    1784:	000010b5 	strheq	r1, [r0], -r5
    1788:	041e5c01 	ldreq	r5, [lr], #-3073	; 0xfffff3ff
    178c:	02000001 	andeq	r0, r0, #1
    1790:	6d0e6891 	stcvs	8, cr6, [lr, #-580]	; 0xfffffdbc
    1794:	01006d65 	tsteq	r0, r5, ror #26
    1798:	0111085e 	tsteq	r1, lr, asr r8
    179c:	91020000 	mrsls	r0, (UNDEF: 2)
    17a0:	8b840d70 	blhi	fe104d68 <__bss_end+0xfe0fbdc8>
    17a4:	003c0000 	eorseq	r0, ip, r0
    17a8:	690e0000 	stmdbvs	lr, {}	; <UNPREDICTABLE>
    17ac:	0b600100 	bleq	1801bb4 <__bss_end+0x17f8c14>
    17b0:	00000104 	andeq	r0, r0, r4, lsl #2
    17b4:	00749102 	rsbseq	r9, r4, r2, lsl #2
    17b8:	11671400 	cmnne	r7, r0, lsl #8
    17bc:	52010000 	andpl	r0, r1, #0
    17c0:	00118005 	andseq	r8, r1, r5
    17c4:	00010400 	andeq	r0, r1, r0, lsl #8
    17c8:	008b1400 	addeq	r1, fp, r0, lsl #8
    17cc:	00005400 	andeq	r5, r0, r0, lsl #8
    17d0:	af9c0100 	svcge	0x009c0100
    17d4:	0b000001 	bleq	17e0 <shift+0x17e0>
    17d8:	52010073 	andpl	r0, r1, #115	; 0x73
    17dc:	00010b18 	andeq	r0, r1, r8, lsl fp
    17e0:	6c910200 	lfmvs	f0, 4, [r1], {0}
    17e4:	0100690e 	tsteq	r0, lr, lsl #18
    17e8:	01040654 	tsteq	r4, r4, asr r6
    17ec:	91020000 	mrsls	r0, (UNDEF: 2)
    17f0:	a3140074 	tstge	r4, #116	; 0x74
    17f4:	01000011 	tsteq	r0, r1, lsl r0
    17f8:	116e0542 	cmnne	lr, r2, asr #10
    17fc:	01040000 	mrseq	r0, (UNDEF: 4)
    1800:	8a680000 	bhi	1a01808 <__bss_end+0x19f8868>
    1804:	00ac0000 	adceq	r0, ip, r0
    1808:	9c010000 	stcls	0, cr0, [r1], {-0}
    180c:	00000215 	andeq	r0, r0, r5, lsl r2
    1810:	0031730b 	eorseq	r7, r1, fp, lsl #6
    1814:	0b194201 	bleq	652020 <__bss_end+0x649080>
    1818:	02000001 	andeq	r0, r0, #1
    181c:	730b6c91 	movwvc	r6, #48273	; 0xbc91
    1820:	42010032 	andmi	r0, r1, #50	; 0x32
    1824:	00010b29 	andeq	r0, r1, r9, lsr #22
    1828:	68910200 	ldmvs	r1, {r9}
    182c:	6d756e0b 	ldclvs	14, cr6, [r5, #-44]!	; 0xffffffd4
    1830:	31420100 	mrscc	r0, (UNDEF: 82)
    1834:	00000104 	andeq	r0, r0, r4, lsl #2
    1838:	0e649102 	lgneqs	f1, f2
    183c:	01003175 	tsteq	r0, r5, ror r1
    1840:	02151044 	andseq	r1, r5, #68	; 0x44
    1844:	91020000 	mrsls	r0, (UNDEF: 2)
    1848:	32750e77 	rsbscc	r0, r5, #1904	; 0x770
    184c:	14440100 	strbne	r0, [r4], #-256	; 0xffffff00
    1850:	00000215 	andeq	r0, r0, r5, lsl r2
    1854:	00769102 	rsbseq	r9, r6, r2, lsl #2
    1858:	e5080108 	str	r0, [r8, #-264]	; 0xfffffef8
    185c:	1400000a 	strne	r0, [r0], #-10
    1860:	000011ab 	andeq	r1, r0, fp, lsr #3
    1864:	92073601 	andls	r3, r7, #1048576	; 0x100000
    1868:	11000011 	tstne	r0, r1, lsl r0
    186c:	a8000001 	stmdage	r0, {r0}
    1870:	c0000089 	andgt	r0, r0, r9, lsl #1
    1874:	01000000 	mrseq	r0, (UNDEF: 0)
    1878:	0002759c 	muleq	r2, ip, r5
    187c:	10aa1300 	adcne	r1, sl, r0, lsl #6
    1880:	36010000 	strcc	r0, [r1], -r0
    1884:	00011115 	andeq	r1, r1, r5, lsl r1
    1888:	6c910200 	lfmvs	f0, 4, [r1], {0}
    188c:	6372730b 	cmnvs	r2, #738197504	; 0x2c000000
    1890:	27360100 	ldrcs	r0, [r6, -r0, lsl #2]!
    1894:	0000010b 	andeq	r0, r0, fp, lsl #2
    1898:	0b689102 	bleq	1a25ca8 <__bss_end+0x1a1cd08>
    189c:	006d756e 	rsbeq	r7, sp, lr, ror #10
    18a0:	04303601 	ldrteq	r3, [r0], #-1537	; 0xfffff9ff
    18a4:	02000001 	andeq	r0, r0, #1
    18a8:	690e6491 	stmdbvs	lr, {r0, r4, r7, sl, sp, lr}
    18ac:	06380100 	ldrteq	r0, [r8], -r0, lsl #2
    18b0:	00000104 	andeq	r0, r0, r4, lsl #2
    18b4:	00749102 	rsbseq	r9, r4, r2, lsl #2
    18b8:	00118d14 	andseq	r8, r1, r4, lsl sp
    18bc:	05240100 	streq	r0, [r4, #-256]!	; 0xffffff00
    18c0:	00001126 	andeq	r1, r0, r6, lsr #2
    18c4:	00000104 	andeq	r0, r0, r4, lsl #2
    18c8:	0000890c 	andeq	r8, r0, ip, lsl #18
    18cc:	0000009c 	muleq	r0, ip, r0
    18d0:	02b29c01 	adcseq	r9, r2, #256	; 0x100
    18d4:	a4130000 	ldrge	r0, [r3], #-0
    18d8:	01000010 	tsteq	r0, r0, lsl r0
    18dc:	010b1624 	tsteq	fp, r4, lsr #12
    18e0:	91020000 	mrsls	r0, (UNDEF: 2)
    18e4:	11440c6c 	cmpne	r4, ip, ror #24
    18e8:	26010000 	strcs	r0, [r1], -r0
    18ec:	00010406 	andeq	r0, r1, r6, lsl #8
    18f0:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    18f4:	11c11500 	bicne	r1, r1, r0, lsl #10
    18f8:	08010000 	stmdaeq	r1, {}	; <UNPREDICTABLE>
    18fc:	0011c606 	andseq	ip, r1, r6, lsl #12
    1900:	00879800 	addeq	r9, r7, r0, lsl #16
    1904:	00017400 	andeq	r7, r1, r0, lsl #8
    1908:	139c0100 	orrsne	r0, ip, #0, 2
    190c:	000010a4 	andeq	r1, r0, r4, lsr #1
    1910:	66180801 	ldrvs	r0, [r8], -r1, lsl #16
    1914:	02000000 	andeq	r0, r0, #0
    1918:	44136491 	ldrmi	r6, [r3], #-1169	; 0xfffffb6f
    191c:	01000011 	tsteq	r0, r1, lsl r0
    1920:	01112508 	tsteq	r1, r8, lsl #10
    1924:	91020000 	mrsls	r0, (UNDEF: 2)
    1928:	115b1360 	cmpne	fp, r0, ror #6
    192c:	08010000 	stmdaeq	r1, {}	; <UNPREDICTABLE>
    1930:	0000663a 	andeq	r6, r0, sl, lsr r6
    1934:	5c910200 	lfmpl	f0, 4, [r1], {0}
    1938:	0100690e 	tsteq	r0, lr, lsl #18
    193c:	0104060a 	tsteq	r4, sl, lsl #12
    1940:	91020000 	mrsls	r0, (UNDEF: 2)
    1944:	88640d74 	stmdahi	r4!, {r2, r4, r5, r6, r8, sl, fp}^
    1948:	00980000 	addseq	r0, r8, r0
    194c:	6a0e0000 	bvs	381954 <__bss_end+0x3789b4>
    1950:	0b1c0100 	bleq	701d58 <__bss_end+0x6f8db8>
    1954:	00000104 	andeq	r0, r0, r4, lsl #2
    1958:	0d709102 	ldfeqp	f1, [r0, #-8]!
    195c:	0000888c 	andeq	r8, r0, ip, lsl #17
    1960:	00000060 	andeq	r0, r0, r0, rrx
    1964:	0100630e 	tsteq	r0, lr, lsl #6
    1968:	006d081e 	rsbeq	r0, sp, lr, lsl r8
    196c:	91020000 	mrsls	r0, (UNDEF: 2)
    1970:	0000006f 	andeq	r0, r0, pc, rrx
	...

Disassembly of section .debug_abbrev:

00000000 <.debug_abbrev>:
   0:	10001101 	andne	r1, r0, r1, lsl #2
   4:	12011106 	andne	r1, r1, #-2147483647	; 0x80000001
   8:	1b0e0301 	blne	380c14 <__bss_end+0x377c74>
   c:	130e250e 	movwne	r2, #58638	; 0xe50e
  10:	00000005 	andeq	r0, r0, r5
  14:	25011101 	strcs	r1, [r1, #-257]	; 0xfffffeff
  18:	030b130e 	movweq	r1, #45838	; 0xb30e
  1c:	110e1b0e 	tstne	lr, lr, lsl #22
  20:	10061201 	andne	r1, r6, r1, lsl #4
  24:	02000017 	andeq	r0, r0, #23
  28:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
  2c:	0b3b0b3a 	bleq	ec2d1c <__bss_end+0xeb9d7c>
  30:	13490b39 	movtne	r0, #39737	; 0x9b39
  34:	193c193f 	ldmdbne	ip!, {r0, r1, r2, r3, r4, r5, r8, fp, ip}
  38:	24030000 	strcs	r0, [r3], #-0
  3c:	3e0b0b00 	vmlacc.f64	d0, d11, d0
  40:	000e030b 	andeq	r0, lr, fp, lsl #6
  44:	012e0400 			; <UNDEFINED> instruction: 0x012e0400
  48:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
  4c:	0b3b0b3a 	bleq	ec2d3c <__bss_end+0xeb9d9c>
  50:	01110b39 	tsteq	r1, r9, lsr fp
  54:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
  58:	01194296 			; <UNDEFINED> instruction: 0x01194296
  5c:	05000013 	streq	r0, [r0, #-19]	; 0xffffffed
  60:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
  64:	0b3b0b3a 	bleq	ec2d54 <__bss_end+0xeb9db4>
  68:	13490b39 	movtne	r0, #39737	; 0x9b39
  6c:	00001802 	andeq	r1, r0, r2, lsl #16
  70:	0b002406 	bleq	9090 <__bss_end+0xf0>
  74:	030b3e0b 	movweq	r3, #48651	; 0xbe0b
  78:	07000008 	streq	r0, [r0, -r8]
  7c:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
  80:	0b3a0e03 	bleq	e83894 <__bss_end+0xe7a8f4>
  84:	0b390b3b 	bleq	e42d78 <__bss_end+0xe39dd8>
  88:	06120111 			; <UNDEFINED> instruction: 0x06120111
  8c:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
  90:	00130119 	andseq	r0, r3, r9, lsl r1
  94:	010b0800 	tsteq	fp, r0, lsl #16
  98:	06120111 			; <UNDEFINED> instruction: 0x06120111
  9c:	34090000 	strcc	r0, [r9], #-0
  a0:	3a080300 	bcc	200ca8 <__bss_end+0x1f7d08>
  a4:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
  a8:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
  ac:	0a000018 	beq	114 <shift+0x114>
  b0:	0b0b000f 	bleq	2c00f4 <__bss_end+0x2b7154>
  b4:	00001349 	andeq	r1, r0, r9, asr #6
  b8:	01110100 	tsteq	r1, r0, lsl #2
  bc:	0b130e25 	bleq	4c3958 <__bss_end+0x4ba9b8>
  c0:	0e1b0e03 	cdpeq	14, 1, cr0, cr11, cr3, {0}
  c4:	06120111 			; <UNDEFINED> instruction: 0x06120111
  c8:	00001710 	andeq	r1, r0, r0, lsl r7
  cc:	03001602 	movweq	r1, #1538	; 0x602
  d0:	3b0b3a0e 	blcc	2ce910 <__bss_end+0x2c5970>
  d4:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
  d8:	03000013 	movweq	r0, #19
  dc:	0b0b000f 	bleq	2c0120 <__bss_end+0x2b7180>
  e0:	00001349 	andeq	r1, r0, r9, asr #6
  e4:	00001504 	andeq	r1, r0, r4, lsl #10
  e8:	01010500 	tsteq	r1, r0, lsl #10
  ec:	13011349 	movwne	r1, #4937	; 0x1349
  f0:	21060000 	mrscs	r0, (UNDEF: 6)
  f4:	2f134900 	svccs	0x00134900
  f8:	07000006 	streq	r0, [r0, -r6]
  fc:	0b0b0024 	bleq	2c0194 <__bss_end+0x2b71f4>
 100:	0e030b3e 	vmoveq.16	d3[0], r0
 104:	34080000 	strcc	r0, [r8], #-0
 108:	3a0e0300 	bcc	380d10 <__bss_end+0x377d70>
 10c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 110:	3f13490b 	svccc	0x0013490b
 114:	00193c19 	andseq	r3, r9, r9, lsl ip
 118:	012e0900 			; <UNDEFINED> instruction: 0x012e0900
 11c:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 120:	0b3b0b3a 	bleq	ec2e10 <__bss_end+0xeb9e70>
 124:	13490b39 	movtne	r0, #39737	; 0x9b39
 128:	06120111 			; <UNDEFINED> instruction: 0x06120111
 12c:	42961840 	addsmi	r1, r6, #64, 16	; 0x400000
 130:	00130119 	andseq	r0, r3, r9, lsl r1
 134:	00340a00 	eorseq	r0, r4, r0, lsl #20
 138:	0b3a0e03 	bleq	e8394c <__bss_end+0xe7a9ac>
 13c:	0b390b3b 	bleq	e42e30 <__bss_end+0xe39e90>
 140:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 144:	240b0000 	strcs	r0, [fp], #-0
 148:	3e0b0b00 	vmlacc.f64	d0, d11, d0
 14c:	0008030b 	andeq	r0, r8, fp, lsl #6
 150:	002e0c00 	eoreq	r0, lr, r0, lsl #24
 154:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 158:	0b3b0b3a 	bleq	ec2e48 <__bss_end+0xeb9ea8>
 15c:	01110b39 	tsteq	r1, r9, lsr fp
 160:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 164:	00194297 	mulseq	r9, r7, r2
 168:	01390d00 	teqeq	r9, r0, lsl #26
 16c:	0b3a0e03 	bleq	e83980 <__bss_end+0xe7a9e0>
 170:	13010b3b 	movwne	r0, #6971	; 0x1b3b
 174:	2e0e0000 	cdpcs	0, 0, cr0, cr14, cr0, {0}
 178:	03193f01 	tsteq	r9, #1, 30
 17c:	3b0b3a0e 	blcc	2ce9bc <__bss_end+0x2c5a1c>
 180:	3c0b390b 			; <UNDEFINED> instruction: 0x3c0b390b
 184:	00130119 	andseq	r0, r3, r9, lsl r1
 188:	00050f00 	andeq	r0, r5, r0, lsl #30
 18c:	00001349 	andeq	r1, r0, r9, asr #6
 190:	3f012e10 	svccc	0x00012e10
 194:	3a0e0319 	bcc	380e00 <__bss_end+0x377e60>
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
 1c0:	3a080300 	bcc	200dc8 <__bss_end+0x1f7e28>
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
 1f4:	0b0b0024 	bleq	2c028c <__bss_end+0x2b72ec>
 1f8:	0e030b3e 	vmoveq.16	d3[0], r0
 1fc:	24030000 	strcs	r0, [r3], #-0
 200:	3e0b0b00 	vmlacc.f64	d0, d11, d0
 204:	0008030b 	andeq	r0, r8, fp, lsl #6
 208:	00160400 	andseq	r0, r6, r0, lsl #8
 20c:	0b3a0e03 	bleq	e83a20 <__bss_end+0xe7aa80>
 210:	0b390b3b 	bleq	e42f04 <__bss_end+0xe39f64>
 214:	00001349 	andeq	r1, r0, r9, asr #6
 218:	49002605 	stmdbmi	r0, {r0, r2, r9, sl, sp}
 21c:	06000013 			; <UNDEFINED> instruction: 0x06000013
 220:	0e030113 	mcreq	1, 0, r0, cr3, cr3, {0}
 224:	0b3a0b0b 	bleq	e82e58 <__bss_end+0xe79eb8>
 228:	0b390b3b 	bleq	e42f1c <__bss_end+0xe39f7c>
 22c:	00001301 	andeq	r1, r0, r1, lsl #6
 230:	03000d07 	movweq	r0, #3335	; 0xd07
 234:	3b0b3a08 	blcc	2cea5c <__bss_end+0x2c5abc>
 238:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 23c:	000b3813 	andeq	r3, fp, r3, lsl r8
 240:	01040800 	tsteq	r4, r0, lsl #16
 244:	196d0e03 	stmdbne	sp!, {r0, r1, r9, sl, fp}^
 248:	0b0b0b3e 	bleq	2c2f48 <__bss_end+0x2b9fa8>
 24c:	0b3a1349 	bleq	e84f78 <__bss_end+0xe7bfd8>
 250:	0b390b3b 	bleq	e42f44 <__bss_end+0xe39fa4>
 254:	00001301 	andeq	r1, r0, r1, lsl #6
 258:	03002809 	movweq	r2, #2057	; 0x809
 25c:	000b1c0e 	andeq	r1, fp, lr, lsl #24
 260:	00340a00 	eorseq	r0, r4, r0, lsl #20
 264:	0b3a0e03 	bleq	e83a78 <__bss_end+0xe7aad8>
 268:	0b390b3b 	bleq	e42f5c <__bss_end+0xe39fbc>
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
 294:	0b3b0b3a 	bleq	ec2f84 <__bss_end+0xeb9fe4>
 298:	13490b39 	movtne	r0, #39737	; 0x9b39
 29c:	00000b38 	andeq	r0, r0, r8, lsr fp
 2a0:	4901010f 	stmdbmi	r1, {r0, r1, r2, r3, r8}
 2a4:	00130113 	andseq	r0, r3, r3, lsl r1
 2a8:	00211000 	eoreq	r1, r1, r0
 2ac:	0b2f1349 	bleq	bc4fd8 <__bss_end+0xbbc038>
 2b0:	02110000 	andseq	r0, r1, #0
 2b4:	0b0e0301 	bleq	380ec0 <__bss_end+0x377f20>
 2b8:	3b0b3a0b 	blcc	2ceaec <__bss_end+0x2c5b4c>
 2bc:	010b390b 	tsteq	fp, fp, lsl #18
 2c0:	12000013 	andne	r0, r0, #19
 2c4:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 2c8:	0b3a0e03 	bleq	e83adc <__bss_end+0xe7ab3c>
 2cc:	0b390b3b 	bleq	e42fc0 <__bss_end+0xe3a020>
 2d0:	193c0e6e 	ldmdbne	ip!, {r1, r2, r3, r5, r6, r9, sl, fp}
 2d4:	13011364 	movwne	r1, #4964	; 0x1364
 2d8:	05130000 	ldreq	r0, [r3, #-0]
 2dc:	34134900 	ldrcc	r4, [r3], #-2304	; 0xfffff700
 2e0:	14000019 	strne	r0, [r0], #-25	; 0xffffffe7
 2e4:	13490005 	movtne	r0, #36869	; 0x9005
 2e8:	2e150000 	cdpcs	0, 1, cr0, cr5, cr0, {0}
 2ec:	03193f01 	tsteq	r9, #1, 30
 2f0:	3b0b3a0e 	blcc	2ceb30 <__bss_end+0x2c5b90>
 2f4:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 2f8:	3c13490e 			; <UNDEFINED> instruction: 0x3c13490e
 2fc:	01136419 	tsteq	r3, r9, lsl r4
 300:	16000013 			; <UNDEFINED> instruction: 0x16000013
 304:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 308:	0b3a0e03 	bleq	e83b1c <__bss_end+0xe7ab7c>
 30c:	0b390b3b 	bleq	e43000 <__bss_end+0xe3a060>
 310:	13490e6e 	movtne	r0, #40558	; 0x9e6e
 314:	193c0b32 	ldmdbne	ip!, {r1, r4, r5, r8, r9, fp}
 318:	13011364 	movwne	r1, #4964	; 0x1364
 31c:	0d170000 	ldceq	0, cr0, [r7, #-0]
 320:	3a0e0300 	bcc	380f28 <__bss_end+0x377f88>
 324:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 328:	3813490b 	ldmdacc	r3, {r0, r1, r3, r8, fp, lr}
 32c:	000b320b 	andeq	r3, fp, fp, lsl #4
 330:	012e1800 			; <UNDEFINED> instruction: 0x012e1800
 334:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 338:	0b3b0b3a 	bleq	ec3028 <__bss_end+0xeba088>
 33c:	0e6e0b39 	vmoveq.8	d14[5], r0
 340:	193c0b32 	ldmdbne	ip!, {r1, r4, r5, r8, r9, fp}
 344:	13011364 	movwne	r1, #4964	; 0x1364
 348:	2e190000 	cdpcs	0, 1, cr0, cr9, cr0, {0}
 34c:	03193f01 	tsteq	r9, #1, 30
 350:	3b0b3a0e 	blcc	2ceb90 <__bss_end+0x2c5bf0>
 354:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 358:	3213490e 	andscc	r4, r3, #229376	; 0x38000
 35c:	64193c0b 	ldrvs	r3, [r9], #-3083	; 0xfffff3f5
 360:	1a000013 	bne	3b4 <shift+0x3b4>
 364:	13490115 	movtne	r0, #37141	; 0x9115
 368:	13011364 	movwne	r1, #4964	; 0x1364
 36c:	1f1b0000 	svcne	0x001b0000
 370:	49131d00 	ldmdbmi	r3, {r8, sl, fp, ip}
 374:	1c000013 	stcne	0, cr0, [r0], {19}
 378:	0b0b0010 	bleq	2c03c0 <__bss_end+0x2b7420>
 37c:	00001349 	andeq	r1, r0, r9, asr #6
 380:	0b000f1d 	bleq	3ffc <shift+0x3ffc>
 384:	1e00000b 	cdpne	0, 0, cr0, cr0, cr11, {0}
 388:	08030139 	stmdaeq	r3, {r0, r3, r4, r5, r8}
 38c:	0b3b0b3a 	bleq	ec307c <__bss_end+0xeba0dc>
 390:	13010b39 	movwne	r0, #6969	; 0x1b39
 394:	341f0000 	ldrcc	r0, [pc], #-0	; 39c <shift+0x39c>
 398:	3a0e0300 	bcc	380fa0 <__bss_end+0x378000>
 39c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 3a0:	3c13490b 			; <UNDEFINED> instruction: 0x3c13490b
 3a4:	6c061c19 	stcvs	12, cr1, [r6], {25}
 3a8:	20000019 	andcs	r0, r0, r9, lsl r0
 3ac:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 3b0:	0b3b0b3a 	bleq	ec30a0 <__bss_end+0xeba100>
 3b4:	13490b39 	movtne	r0, #39737	; 0x9b39
 3b8:	0b1c193c 	bleq	7068b0 <__bss_end+0x6fd910>
 3bc:	0000196c 	andeq	r1, r0, ip, ror #18
 3c0:	47003421 	strmi	r3, [r0, -r1, lsr #8]
 3c4:	22000013 	andcs	r0, r0, #19
 3c8:	08030034 	stmdaeq	r3, {r2, r4, r5}
 3cc:	0b3b0b3a 	bleq	ec30bc <__bss_end+0xeba11c>
 3d0:	13490b39 	movtne	r0, #39737	; 0x9b39
 3d4:	1802193f 	stmdane	r2, {r0, r1, r2, r3, r4, r5, r8, fp, ip}
 3d8:	34230000 	strtcc	r0, [r3], #-0
 3dc:	3a0e0300 	bcc	380fe4 <__bss_end+0x378044>
 3e0:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 3e4:	3f13490b 	svccc	0x0013490b
 3e8:	00180219 	andseq	r0, r8, r9, lsl r2
 3ec:	012e2400 			; <UNDEFINED> instruction: 0x012e2400
 3f0:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 3f4:	0b3b0b3a 	bleq	ec30e4 <__bss_end+0xeba144>
 3f8:	13490b39 	movtne	r0, #39737	; 0x9b39
 3fc:	06120111 			; <UNDEFINED> instruction: 0x06120111
 400:	42961840 	addsmi	r1, r6, #64, 16	; 0x400000
 404:	00130119 	andseq	r0, r3, r9, lsl r1
 408:	00052500 	andeq	r2, r5, r0, lsl #10
 40c:	0b3a0e03 	bleq	e83c20 <__bss_end+0xe7ac80>
 410:	0b390b3b 	bleq	e43104 <__bss_end+0xe3a164>
 414:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 418:	34260000 	strtcc	r0, [r6], #-0
 41c:	3a0e0300 	bcc	381024 <__bss_end+0x378084>
 420:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 424:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 428:	27000018 	smladcs	r0, r8, r0, r0
 42c:	193f002e 	ldmdbne	pc!, {r1, r2, r3, r5}	; <UNPREDICTABLE>
 430:	0b3a0e03 	bleq	e83c44 <__bss_end+0xe7aca4>
 434:	0b390b3b 	bleq	e43128 <__bss_end+0xe3a188>
 438:	01110e6e 	tsteq	r1, lr, ror #28
 43c:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 440:	00194296 	mulseq	r9, r6, r2
 444:	11010000 	mrsne	r0, (UNDEF: 1)
 448:	130e2501 	movwne	r2, #58625	; 0xe501
 44c:	1b0e030b 	blne	381080 <__bss_end+0x3780e0>
 450:	1201110e 	andne	r1, r1, #-2147483645	; 0x80000003
 454:	00171006 	andseq	r1, r7, r6
 458:	00240200 	eoreq	r0, r4, r0, lsl #4
 45c:	0b3e0b0b 	bleq	f83090 <__bss_end+0xf7a0f0>
 460:	00000e03 	andeq	r0, r0, r3, lsl #28
 464:	49002603 	stmdbmi	r0, {r0, r1, r9, sl, sp}
 468:	04000013 	streq	r0, [r0], #-19	; 0xffffffed
 46c:	0b0b0024 	bleq	2c0504 <__bss_end+0x2b7564>
 470:	08030b3e 	stmdaeq	r3, {r1, r2, r3, r4, r5, r8, r9, fp}
 474:	16050000 	strne	r0, [r5], -r0
 478:	3a0e0300 	bcc	381080 <__bss_end+0x3780e0>
 47c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 480:	0013490b 	andseq	r4, r3, fp, lsl #18
 484:	01130600 	tsteq	r3, r0, lsl #12
 488:	0b0b0e03 	bleq	2c3c9c <__bss_end+0x2bacfc>
 48c:	0b3b0b3a 	bleq	ec317c <__bss_end+0xeba1dc>
 490:	13010b39 	movwne	r0, #6969	; 0x1b39
 494:	0d070000 	stceq	0, cr0, [r7, #-0]
 498:	3a080300 	bcc	2010a0 <__bss_end+0x1f8100>
 49c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 4a0:	3813490b 	ldmdacc	r3, {r0, r1, r3, r8, fp, lr}
 4a4:	0800000b 	stmdaeq	r0, {r0, r1, r3}
 4a8:	0e030104 	adfeqs	f0, f3, f4
 4ac:	0b3e196d 	bleq	f86a68 <__bss_end+0xf7dac8>
 4b0:	13490b0b 	movtne	r0, #39691	; 0x9b0b
 4b4:	0b3b0b3a 	bleq	ec31a4 <__bss_end+0xeba204>
 4b8:	13010b39 	movwne	r0, #6969	; 0x1b39
 4bc:	28090000 	stmdacs	r9, {}	; <UNPREDICTABLE>
 4c0:	1c080300 	stcne	3, cr0, [r8], {-0}
 4c4:	0a00000b 	beq	4f8 <shift+0x4f8>
 4c8:	0e030028 	cdpeq	0, 0, cr0, cr3, cr8, {1}
 4cc:	00000b1c 	andeq	r0, r0, ip, lsl fp
 4d0:	0300340b 	movweq	r3, #1035	; 0x40b
 4d4:	3b0b3a0e 	blcc	2ced14 <__bss_end+0x2c5d74>
 4d8:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 4dc:	02196c13 	andseq	r6, r9, #4864	; 0x1300
 4e0:	0c000018 	stceq	0, cr0, [r0], {24}
 4e4:	0e030002 	cdpeq	0, 0, cr0, cr3, cr2, {0}
 4e8:	0000193c 	andeq	r1, r0, ip, lsr r9
 4ec:	0b000f0d 	bleq	4128 <shift+0x4128>
 4f0:	0013490b 	andseq	r4, r3, fp, lsl #18
 4f4:	000d0e00 	andeq	r0, sp, r0, lsl #28
 4f8:	0b3a0e03 	bleq	e83d0c <__bss_end+0xe7ad6c>
 4fc:	0b390b3b 	bleq	e431f0 <__bss_end+0xe3a250>
 500:	0b381349 	bleq	e0522c <__bss_end+0xdfc28c>
 504:	010f0000 	mrseq	r0, CPSR
 508:	01134901 	tsteq	r3, r1, lsl #18
 50c:	10000013 	andne	r0, r0, r3, lsl r0
 510:	13490021 	movtne	r0, #36897	; 0x9021
 514:	00000b2f 	andeq	r0, r0, pc, lsr #22
 518:	03010211 	movweq	r0, #4625	; 0x1211
 51c:	3a0b0b0e 	bcc	2c315c <__bss_end+0x2ba1bc>
 520:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 524:	0013010b 	andseq	r0, r3, fp, lsl #2
 528:	012e1200 			; <UNDEFINED> instruction: 0x012e1200
 52c:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 530:	0b3b0b3a 	bleq	ec3220 <__bss_end+0xeba280>
 534:	0e6e0b39 	vmoveq.8	d14[5], r0
 538:	1364193c 	cmnne	r4, #60, 18	; 0xf0000
 53c:	00001301 	andeq	r1, r0, r1, lsl #6
 540:	49000513 	stmdbmi	r0, {r0, r1, r4, r8, sl}
 544:	00193413 	andseq	r3, r9, r3, lsl r4
 548:	00051400 	andeq	r1, r5, r0, lsl #8
 54c:	00001349 	andeq	r1, r0, r9, asr #6
 550:	3f012e15 	svccc	0x00012e15
 554:	3a0e0319 	bcc	3811c0 <__bss_end+0x378220>
 558:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 55c:	490e6e0b 	stmdbmi	lr, {r0, r1, r3, r9, sl, fp, sp, lr}
 560:	64193c13 	ldrvs	r3, [r9], #-3091	; 0xfffff3ed
 564:	00130113 	andseq	r0, r3, r3, lsl r1
 568:	012e1600 			; <UNDEFINED> instruction: 0x012e1600
 56c:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 570:	0b3b0b3a 	bleq	ec3260 <__bss_end+0xeba2c0>
 574:	0e6e0b39 	vmoveq.8	d14[5], r0
 578:	0b321349 	bleq	c852a4 <__bss_end+0xc7c304>
 57c:	1364193c 	cmnne	r4, #60, 18	; 0xf0000
 580:	00001301 	andeq	r1, r0, r1, lsl #6
 584:	03000d17 	movweq	r0, #3351	; 0xd17
 588:	3b0b3a0e 	blcc	2cedc8 <__bss_end+0x2c5e28>
 58c:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 590:	320b3813 	andcc	r3, fp, #1245184	; 0x130000
 594:	1800000b 	stmdane	r0, {r0, r1, r3}
 598:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 59c:	0b3a0e03 	bleq	e83db0 <__bss_end+0xe7ae10>
 5a0:	0b390b3b 	bleq	e43294 <__bss_end+0xe3a2f4>
 5a4:	0b320e6e 	bleq	c83f64 <__bss_end+0xc7afc4>
 5a8:	1364193c 	cmnne	r4, #60, 18	; 0xf0000
 5ac:	00001301 	andeq	r1, r0, r1, lsl #6
 5b0:	3f012e19 	svccc	0x00012e19
 5b4:	3a0e0319 	bcc	381220 <__bss_end+0x378280>
 5b8:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 5bc:	490e6e0b 	stmdbmi	lr, {r0, r1, r3, r9, sl, fp, sp, lr}
 5c0:	3c0b3213 	sfmcc	f3, 4, [fp], {19}
 5c4:	00136419 	andseq	r6, r3, r9, lsl r4
 5c8:	01151a00 	tsteq	r5, r0, lsl #20
 5cc:	13641349 	cmnne	r4, #603979777	; 0x24000001
 5d0:	00001301 	andeq	r1, r0, r1, lsl #6
 5d4:	1d001f1b 	stcne	15, cr1, [r0, #-108]	; 0xffffff94
 5d8:	00134913 	andseq	r4, r3, r3, lsl r9
 5dc:	00101c00 	andseq	r1, r0, r0, lsl #24
 5e0:	13490b0b 	movtne	r0, #39691	; 0x9b0b
 5e4:	0f1d0000 	svceq	0x001d0000
 5e8:	000b0b00 	andeq	r0, fp, r0, lsl #22
 5ec:	00341e00 	eorseq	r1, r4, r0, lsl #28
 5f0:	0b3a0e03 	bleq	e83e04 <__bss_end+0xe7ae64>
 5f4:	0b390b3b 	bleq	e432e8 <__bss_end+0xe3a348>
 5f8:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 5fc:	2e1f0000 	cdpcs	0, 1, cr0, cr15, cr0, {0}
 600:	03193f01 	tsteq	r9, #1, 30
 604:	3b0b3a0e 	blcc	2cee44 <__bss_end+0x2c5ea4>
 608:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 60c:	1113490e 	tstne	r3, lr, lsl #18
 610:	40061201 	andmi	r1, r6, r1, lsl #4
 614:	19429618 	stmdbne	r2, {r3, r4, r9, sl, ip, pc}^
 618:	00001301 	andeq	r1, r0, r1, lsl #6
 61c:	03000520 	movweq	r0, #1312	; 0x520
 620:	3b0b3a0e 	blcc	2cee60 <__bss_end+0x2c5ec0>
 624:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 628:	00180213 	andseq	r0, r8, r3, lsl r2
 62c:	012e2100 			; <UNDEFINED> instruction: 0x012e2100
 630:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 634:	0b3b0b3a 	bleq	ec3324 <__bss_end+0xeba384>
 638:	0e6e0b39 	vmoveq.8	d14[5], r0
 63c:	01111349 	tsteq	r1, r9, asr #6
 640:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 644:	01194297 			; <UNDEFINED> instruction: 0x01194297
 648:	22000013 	andcs	r0, r0, #19
 64c:	08030034 	stmdaeq	r3, {r2, r4, r5}
 650:	0b3b0b3a 	bleq	ec3340 <__bss_end+0xeba3a0>
 654:	13490b39 	movtne	r0, #39737	; 0x9b39
 658:	00001802 	andeq	r1, r0, r2, lsl #16
 65c:	3f012e23 	svccc	0x00012e23
 660:	3a0e0319 	bcc	3812cc <__bss_end+0x37832c>
 664:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 668:	110e6e0b 	tstne	lr, fp, lsl #28
 66c:	40061201 	andmi	r1, r6, r1, lsl #4
 670:	19429718 	stmdbne	r2, {r3, r4, r8, r9, sl, ip, pc}^
 674:	00001301 	andeq	r1, r0, r1, lsl #6
 678:	3f002e24 	svccc	0x00002e24
 67c:	3a0e0319 	bcc	3812e8 <__bss_end+0x378348>
 680:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 684:	110e6e0b 	tstne	lr, fp, lsl #28
 688:	40061201 	andmi	r1, r6, r1, lsl #4
 68c:	19429718 	stmdbne	r2, {r3, r4, r8, r9, sl, ip, pc}^
 690:	2e250000 	cdpcs	0, 2, cr0, cr5, cr0, {0}
 694:	03193f01 	tsteq	r9, #1, 30
 698:	3b0b3a0e 	blcc	2ceed8 <__bss_end+0x2c5f38>
 69c:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 6a0:	1113490e 	tstne	r3, lr, lsl #18
 6a4:	40061201 	andmi	r1, r6, r1, lsl #4
 6a8:	19429718 	stmdbne	r2, {r3, r4, r8, r9, sl, ip, pc}^
 6ac:	01000000 	mrseq	r0, (UNDEF: 0)
 6b0:	0e250111 	mcreq	1, 1, r0, cr5, cr1, {0}
 6b4:	0e030b13 	vmoveq.32	d3[0], r0
 6b8:	01110e1b 	tsteq	r1, fp, lsl lr
 6bc:	17100612 			; <UNDEFINED> instruction: 0x17100612
 6c0:	39020000 	stmdbcc	r2, {}	; <UNPREDICTABLE>
 6c4:	00130101 	andseq	r0, r3, r1, lsl #2
 6c8:	00340300 	eorseq	r0, r4, r0, lsl #6
 6cc:	0b3a0e03 	bleq	e83ee0 <__bss_end+0xe7af40>
 6d0:	0b390b3b 	bleq	e433c4 <__bss_end+0xe3a424>
 6d4:	193c1349 	ldmdbne	ip!, {r0, r3, r6, r8, r9, ip}
 6d8:	00000a1c 	andeq	r0, r0, ip, lsl sl
 6dc:	3a003a04 	bcc	eef4 <__bss_end+0x5f54>
 6e0:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 6e4:	0013180b 	andseq	r1, r3, fp, lsl #16
 6e8:	01010500 	tsteq	r1, r0, lsl #10
 6ec:	13011349 	movwne	r1, #4937	; 0x1349
 6f0:	21060000 	mrscs	r0, (UNDEF: 6)
 6f4:	2f134900 	svccs	0x00134900
 6f8:	0700000b 	streq	r0, [r0, -fp]
 6fc:	13490026 	movtne	r0, #36902	; 0x9026
 700:	24080000 	strcs	r0, [r8], #-0
 704:	3e0b0b00 	vmlacc.f64	d0, d11, d0
 708:	000e030b 	andeq	r0, lr, fp, lsl #6
 70c:	00340900 	eorseq	r0, r4, r0, lsl #18
 710:	00001347 	andeq	r1, r0, r7, asr #6
 714:	3f012e0a 	svccc	0x00012e0a
 718:	3a0e0319 	bcc	381384 <__bss_end+0x3783e4>
 71c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 720:	110e6e0b 	tstne	lr, fp, lsl #28
 724:	40061201 	andmi	r1, r6, r1, lsl #4
 728:	19429718 	stmdbne	r2, {r3, r4, r8, r9, sl, ip, pc}^
 72c:	00001301 	andeq	r1, r0, r1, lsl #6
 730:	0300050b 	movweq	r0, #1291	; 0x50b
 734:	3b0b3a08 	blcc	2cef5c <__bss_end+0x2c5fbc>
 738:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 73c:	00180213 	andseq	r0, r8, r3, lsl r2
 740:	00340c00 	eorseq	r0, r4, r0, lsl #24
 744:	0b3a0e03 	bleq	e83f58 <__bss_end+0xe7afb8>
 748:	0b390b3b 	bleq	e4343c <__bss_end+0xe3a49c>
 74c:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 750:	0b0d0000 	bleq	340758 <__bss_end+0x3377b8>
 754:	12011101 	andne	r1, r1, #1073741824	; 0x40000000
 758:	0e000006 	cdpeq	0, 0, cr0, cr0, cr6, {0}
 75c:	08030034 	stmdaeq	r3, {r2, r4, r5}
 760:	0b3b0b3a 	bleq	ec3450 <__bss_end+0xeba4b0>
 764:	13490b39 	movtne	r0, #39737	; 0x9b39
 768:	00001802 	andeq	r1, r0, r2, lsl #16
 76c:	0b000f0f 	bleq	43b0 <shift+0x43b0>
 770:	0013490b 	andseq	r4, r3, fp, lsl #18
 774:	00261000 	eoreq	r1, r6, r0
 778:	0f110000 	svceq	0x00110000
 77c:	000b0b00 	andeq	r0, fp, r0, lsl #22
 780:	00241200 	eoreq	r1, r4, r0, lsl #4
 784:	0b3e0b0b 	bleq	f833b8 <__bss_end+0xf7a418>
 788:	00000803 	andeq	r0, r0, r3, lsl #16
 78c:	03000513 	movweq	r0, #1299	; 0x513
 790:	3b0b3a0e 	blcc	2cefd0 <__bss_end+0x2c6030>
 794:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 798:	00180213 	andseq	r0, r8, r3, lsl r2
 79c:	012e1400 			; <UNDEFINED> instruction: 0x012e1400
 7a0:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 7a4:	0b3b0b3a 	bleq	ec3494 <__bss_end+0xeba4f4>
 7a8:	0e6e0b39 	vmoveq.8	d14[5], r0
 7ac:	01111349 	tsteq	r1, r9, asr #6
 7b0:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 7b4:	01194297 			; <UNDEFINED> instruction: 0x01194297
 7b8:	15000013 	strne	r0, [r0, #-19]	; 0xffffffed
 7bc:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 7c0:	0b3a0e03 	bleq	e83fd4 <__bss_end+0xe7b034>
 7c4:	0b390b3b 	bleq	e434b8 <__bss_end+0xe3a518>
 7c8:	01110e6e 	tsteq	r1, lr, ror #28
 7cc:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 7d0:	00194296 	mulseq	r9, r6, r2
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
  74:	00000110 	andeq	r0, r0, r0, lsl r1
	...
  80:	0000001c 	andeq	r0, r0, ip, lsl r0
  84:	0b200002 	bleq	800094 <__bss_end+0x7f70f4>
  88:	00040000 	andeq	r0, r4, r0
  8c:	00000000 	andeq	r0, r0, r0
  90:	0000833c 	andeq	r8, r0, ip, lsr r3
  94:	0000045c 	andeq	r0, r0, ip, asr r4
	...
  a0:	0000001c 	andeq	r0, r0, ip, lsl r0
  a4:	16430002 	strbne	r0, [r3], -r2
  a8:	00040000 	andeq	r0, r4, r0
  ac:	00000000 	andeq	r0, r0, r0
  b0:	00008798 	muleq	r0, r8, r7
  b4:	000004b8 			; <UNDEFINED> instruction: 0x000004b8
	...

Disassembly of section .debug_str:

00000000 <.debug_str>:
       0:	6573552f 	ldrbvs	r5, [r3, #-1327]!	; 0xfffffad1
       4:	772f7372 			; <UNDEFINED> instruction: 0x772f7372
       8:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
       c:	2f696a72 	svccs	0x00696a72
      10:	6b736544 	blvs	1cd9528 <__bss_end+0x1cd0588>
      14:	2f706f74 	svccs	0x00706f74
      18:	2f564146 	svccs	0x00564146
      1c:	6176614e 	cmnvs	r6, lr, asr #2
      20:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
      24:	4f2f6963 	svcmi	0x002f6963
      28:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
      2c:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
      30:	6b6c6172 	blvs	1b18600 <__bss_end+0x1b0f660>
      34:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
      38:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
      3c:	756f732f 	strbvc	r7, [pc, #-815]!	; fffffd15 <__bss_end+0xffff6d75>
      40:	73656372 	cmnvc	r5, #-939524095	; 0xc8000001
      44:	6573752f 	ldrbvs	r7, [r3, #-1327]!	; 0xfffffad1
      48:	61707372 	cmnvs	r0, r2, ror r3
      4c:	632f6563 			; <UNDEFINED> instruction: 0x632f6563
      50:	2e307472 	mrccs	4, 1, r7, cr0, cr2, {3}
      54:	552f0073 	strpl	r0, [pc, #-115]!	; ffffffe9 <__bss_end+0xffff7049>
      58:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
      5c:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
      60:	6a726574 	bvs	1c99638 <__bss_end+0x1c90698>
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
      98:	752f7365 	strvc	r7, [pc, #-869]!	; fffffd3b <__bss_end+0xffff6d9b>
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
     12c:	6a363731 	bvs	d8ddf8 <__bss_end+0xd84e58>
     130:	732d667a 			; <UNDEFINED> instruction: 0x732d667a
     134:	616d2d20 	cmnvs	sp, r0, lsr #26
     138:	2d206d72 	stccs	13, cr6, [r0, #-456]!	; 0xfffffe38
     13c:	6372616d 	cmnvs	r2, #1073741851	; 0x4000001b
     140:	72613d68 	rsbvc	r3, r1, #104, 26	; 0x1a00
     144:	7a36766d 	bvc	d9db00 <__bss_end+0xd94b60>
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
     184:	6a757a61 	bvs	1d5eb10 <__bss_end+0x1d55b70>
     188:	2f696369 	svccs	0x00696369
     18c:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
     190:	73656d65 	cmnvc	r5, #6464	; 0x1940
     194:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
     198:	6b2d616b 	blvs	b5874c <__bss_end+0xb4f7ac>
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
     1e4:	2b2b4320 	blcs	ad0e6c <__bss_end+0xac7ecc>
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
     260:	2b6b7a36 	blcs	1adeb40 <__bss_end+0x1ad5ba0>
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
     294:	755f6962 	ldrbvc	r6, [pc, #-2402]	; fffff93a <__bss_end+0xffff699a>
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
     324:	6b736544 	blvs	1cd983c <__bss_end+0x1cd089c>
     328:	2f706f74 	svccs	0x00706f74
     32c:	2f564146 	svccs	0x00564146
     330:	6176614e 	cmnvs	r6, lr, asr #2
     334:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
     338:	4f2f6963 	svcmi	0x002f6963
     33c:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
     340:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
     344:	6b6c6172 	blvs	1b18914 <__bss_end+0x1b0f974>
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
     4b8:	5a00746e 	bpl	1d678 <__bss_end+0x146d8>
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
     638:	6f6c4200 	svcvs	0x006c4200
     63c:	64656b63 	strbtvs	r6, [r5], #-2915	; 0xfffff49d
     640:	75436d00 	strbvc	r6, [r3, #-3328]	; 0xfffff300
     644:	6e657272 	mcrvs	2, 3, r7, cr5, cr2, {3}
     648:	61545f74 	cmpvs	r4, r4, ror pc
     64c:	4e5f6b73 	vmovmi.s8	r6, d15[3]
     650:	0065646f 	rsbeq	r6, r5, pc, ror #8
     654:	72616863 	rsbvc	r6, r1, #6488064	; 0x630000
     658:	6369745f 	cmnvs	r9, #1593835520	; 0x5f000000
     65c:	65645f6b 	strbvs	r5, [r4, #-3947]!	; 0xfffff095
     660:	0079616c 	rsbseq	r6, r9, ip, ror #2
     664:	65656c73 	strbvs	r6, [r5, #-3187]!	; 0xfffff38d
     668:	69745f70 	ldmdbvs	r4!, {r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     66c:	0072656d 	rsbseq	r6, r2, sp, ror #10
     670:	314e5a5f 	cmpcc	lr, pc, asr sl
     674:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     678:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     67c:	614d5f73 	hvcvs	54771	; 0xd5f3
     680:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     684:	77533972 			; <UNDEFINED> instruction: 0x77533972
     688:	68637469 	stmdavs	r3!, {r0, r3, r5, r6, sl, ip, sp, lr}^
     68c:	456f545f 	strbmi	r5, [pc, #-1119]!	; 235 <shift+0x235>
     690:	43383150 	teqmi	r8, #80, 2
     694:	636f7250 	cmnvs	pc, #80, 4
     698:	5f737365 	svcpl	0x00737365
     69c:	7473694c 	ldrbtvc	r6, [r3], #-2380	; 0xfffff6b4
     6a0:	646f4e5f 	strbtvs	r4, [pc], #-3679	; 6a8 <shift+0x6a8>
     6a4:	70630065 	rsbvc	r0, r3, r5, rrx
     6a8:	6f635f75 	svcvs	0x00635f75
     6ac:	7865746e 	stmdavc	r5!, {r1, r2, r3, r5, r6, sl, ip, sp, lr}^
     6b0:	72430074 	subvc	r0, r3, #116	; 0x74
     6b4:	65746165 	ldrbvs	r6, [r4, #-357]!	; 0xfffffe9b
     6b8:	6f72505f 	svcvs	0x0072505f
     6bc:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     6c0:	65704f00 	ldrbvs	r4, [r0, #-3840]!	; 0xfffff100
     6c4:	7562006e 	strbvc	r0, [r2, #-110]!	; 0xffffff92
     6c8:	54006666 	strpl	r6, [r0], #-1638	; 0xfffff99a
     6cc:	72656d69 	rsbvc	r6, r5, #6720	; 0x1a40
     6d0:	7361425f 	cmnvc	r1, #-268435451	; 0xf0000005
     6d4:	552f0065 	strpl	r0, [pc, #-101]!	; 677 <shift+0x677>
     6d8:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
     6dc:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
     6e0:	6a726574 	bvs	1c99cb8 <__bss_end+0x1c90d18>
     6e4:	65442f69 	strbvs	r2, [r4, #-3945]	; 0xfffff097
     6e8:	6f746b73 	svcvs	0x00746b73
     6ec:	41462f70 	hvcmi	25328	; 0x62f0
     6f0:	614e2f56 	cmpvs	lr, r6, asr pc
     6f4:	757a6176 	ldrbvc	r6, [sl, #-374]!	; 0xfffffe8a
     6f8:	6963696a 	stmdbvs	r3!, {r1, r3, r5, r6, r8, fp, sp, lr}^
     6fc:	2f534f2f 	svccs	0x00534f2f
     700:	656d6573 	strbvs	r6, [sp, #-1395]!	; 0xfffffa8d
     704:	61727473 	cmnvs	r2, r3, ror r4
     708:	2d616b6c 	vstmdbcs	r1!, {d22-<overflow reg d75>}
     70c:	2d76696b 			; <UNDEFINED> instruction: 0x2d76696b
     710:	732f736f 			; <UNDEFINED> instruction: 0x732f736f
     714:	6372756f 	cmnvs	r2, #465567744	; 0x1bc00000
     718:	752f7365 	strvc	r7, [pc, #-869]!	; 3bb <shift+0x3bb>
     71c:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
     720:	65636170 	strbvs	r6, [r3, #-368]!	; 0xfffffe90
     724:	73616d2f 	cmnvc	r1, #3008	; 0xbc0
     728:	5f726574 	svcpl	0x00726574
     72c:	6b736174 	blvs	1cd8d04 <__bss_end+0x1ccfd64>
     730:	69616d2f 	stmdbvs	r1!, {r0, r1, r2, r3, r5, r8, sl, fp, sp, lr}^
     734:	70632e6e 	rsbvc	r2, r3, lr, ror #28
     738:	5a5f0070 	bpl	17c0900 <__bss_end+0x17b7960>
     73c:	4336314e 	teqmi	r6, #-2147483629	; 0x80000013
     740:	636f7250 	cmnvs	pc, #80, 4
     744:	5f737365 	svcpl	0x00737365
     748:	616e614d 	cmnvs	lr, sp, asr #2
     74c:	31726567 	cmncc	r2, r7, ror #10
     750:	746f4e34 	strbtvc	r4, [pc], #-3636	; 758 <shift+0x758>
     754:	5f796669 	svcpl	0x00796669
     758:	636f7250 	cmnvs	pc, #80, 4
     75c:	45737365 	ldrbmi	r7, [r3, #-869]!	; 0xfffffc9b
     760:	54323150 	ldrtpl	r3, [r2], #-336	; 0xfffffeb0
     764:	6b736154 	blvs	1cd8cbc <__bss_end+0x1ccfd1c>
     768:	7274535f 	rsbsvc	r5, r4, #2080374785	; 0x7c000001
     76c:	00746375 	rsbseq	r6, r4, r5, ror r3
     770:	5f746547 	svcpl	0x00746547
     774:	65686353 	strbvs	r6, [r8, #-851]!	; 0xfffffcad
     778:	6e495f64 	cdpvs	15, 4, cr5, cr9, cr4, {3}
     77c:	49006f66 	stmdbmi	r0, {r1, r2, r5, r6, r8, r9, sl, fp, sp, lr}
     780:	6c74434f 	ldclvs	3, cr4, [r4], #-316	; 0xfffffec4
     784:	61655200 	cmnvs	r5, r0, lsl #4
     788:	65540064 	ldrbvs	r0, [r4, #-100]	; 0xffffff9c
     78c:	6e696d72 	mcrvs	13, 3, r6, cr9, cr2, {3}
     790:	00657461 	rsbeq	r7, r5, r1, ror #8
     794:	69746f4e 	ldmdbvs	r4!, {r1, r2, r3, r6, r8, r9, sl, fp, sp, lr}^
     798:	505f7966 	subspl	r7, pc, r6, ror #18
     79c:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     7a0:	5f007373 	svcpl	0x00007373
     7a4:	36314e5a 			; <UNDEFINED> instruction: 0x36314e5a
     7a8:	6f725043 	svcvs	0x00725043
     7ac:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     7b0:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     7b4:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     7b8:	76453443 	strbvc	r3, [r5], -r3, asr #8
     7bc:	746f4e00 	strbtvc	r4, [pc], #-3584	; 7c4 <shift+0x7c4>
     7c0:	00796669 	rsbseq	r6, r9, r9, ror #12
     7c4:	5078614d 	rsbspl	r6, r8, sp, asr #2
     7c8:	4c687461 	cfstrdmi	mvd7, [r8], #-388	; 0xfffffe7c
     7cc:	74676e65 	strbtvc	r6, [r7], #-3685	; 0xfffff19b
     7d0:	614d0068 	cmpvs	sp, r8, rrx
     7d4:	44534678 	ldrbmi	r4, [r3], #-1656	; 0xfffff988
     7d8:	65766972 	ldrbvs	r6, [r6, #-2418]!	; 0xfffff68e
     7dc:	6d614e72 	stclvs	14, cr4, [r1, #-456]!	; 0xfffffe38
     7e0:	6e654c65 	cdpvs	12, 6, cr4, cr5, cr5, {3}
     7e4:	00687467 	rsbeq	r7, r8, r7, ror #8
     7e8:	314e5a5f 	cmpcc	lr, pc, asr sl
     7ec:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     7f0:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     7f4:	614d5f73 	hvcvs	54771	; 0xd5f3
     7f8:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     7fc:	53313172 	teqpl	r1, #-2147483620	; 0x8000001c
     800:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     804:	5f656c75 	svcpl	0x00656c75
     808:	76455252 			; <UNDEFINED> instruction: 0x76455252
     80c:	65474e00 	strbvs	r4, [r7, #-3584]	; 0xfffff200
     810:	63535f74 	cmpvs	r3, #116, 30	; 0x1d0
     814:	5f646568 	svcpl	0x00646568
     818:	6f666e49 	svcvs	0x00666e49
     81c:	7079545f 	rsbsvc	r5, r9, pc, asr r4
     820:	50470065 	subpl	r0, r7, r5, rrx
     824:	505f4f49 	subspl	r4, pc, r9, asr #30
     828:	435f6e69 	cmpmi	pc, #1680	; 0x690
     82c:	746e756f 	strbtvc	r7, [lr], #-1391	; 0xfffffa91
     830:	73617400 	cmnvc	r1, #0, 8
     834:	6c62006b 	stclvs	0, cr0, [r2], #-428	; 0xfffffe54
     838:	006b6e69 	rsbeq	r6, fp, r9, ror #28
     83c:	6c6f6f62 	stclvs	15, cr6, [pc], #-392	; 6bc <shift+0x6bc>
     840:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     844:	50433631 	subpl	r3, r3, r1, lsr r6
     848:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     84c:	4d5f7373 	ldclmi	3, cr7, [pc, #-460]	; 688 <shift+0x688>
     850:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
     854:	38317265 	ldmdacc	r1!, {r0, r2, r5, r6, r9, ip, sp, lr}
     858:	5f746547 	svcpl	0x00746547
     85c:	65686353 	strbvs	r6, [r8, #-851]!	; 0xfffffcad
     860:	656c7564 	strbvs	r7, [ip, #-1380]!	; 0xfffffa9c
     864:	6e495f72 	mcrvs	15, 2, r5, cr9, cr2, {3}
     868:	32456f66 	subcc	r6, r5, #408	; 0x198
     86c:	65474e30 	strbvs	r4, [r7, #-3632]	; 0xfffff1d0
     870:	63535f74 	cmpvs	r3, #116, 30	; 0x1d0
     874:	5f646568 	svcpl	0x00646568
     878:	6f666e49 	svcvs	0x00666e49
     87c:	7079545f 	rsbsvc	r5, r9, pc, asr r4
     880:	00765065 	rsbseq	r5, r6, r5, rrx
     884:	474e5254 	smlsldmi	r5, lr, r4, r2
     888:	7361425f 	cmnvc	r1, #-268435451	; 0xf0000005
     88c:	65440065 	strbvs	r0, [r4, #-101]	; 0xffffff9b
     890:	6c756166 	ldfvse	f6, [r5], #-408	; 0xfffffe68
     894:	6c435f74 	mcrrvs	15, 7, r5, r3, cr4
     898:	5f6b636f 	svcpl	0x006b636f
     89c:	65746152 	ldrbvs	r6, [r4, #-338]!	; 0xfffffeae
     8a0:	72506d00 	subsvc	r6, r0, #0, 26
     8a4:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     8a8:	694c5f73 	stmdbvs	ip, {r0, r1, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     8ac:	485f7473 	ldmdami	pc, {r0, r1, r4, r5, r6, sl, ip, sp, lr}^	; <UNPREDICTABLE>
     8b0:	00646165 	rsbeq	r6, r4, r5, ror #2
     8b4:	6863536d 	stmdavs	r3!, {r0, r2, r3, r5, r6, r8, r9, ip, lr}^
     8b8:	6c756465 	cfldrdvs	mvd6, [r5], #-404	; 0xfffffe6c
     8bc:	6e465f65 	cdpvs	15, 4, cr5, cr6, cr5, {3}
     8c0:	5a5f0063 	bpl	17c0a54 <__bss_end+0x17b7ab4>
     8c4:	4336314e 	teqmi	r6, #-2147483629	; 0x80000013
     8c8:	636f7250 	cmnvs	pc, #80, 4
     8cc:	5f737365 	svcpl	0x00737365
     8d0:	616e614d 	cmnvs	lr, sp, asr #2
     8d4:	32726567 	rsbscc	r6, r2, #432013312	; 0x19c00000
     8d8:	6f6c4231 	svcvs	0x006c4231
     8dc:	435f6b63 	cmpmi	pc, #101376	; 0x18c00
     8e0:	65727275 	ldrbvs	r7, [r2, #-629]!	; 0xfffffd8b
     8e4:	505f746e 	subspl	r7, pc, lr, ror #8
     8e8:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     8ec:	76457373 			; <UNDEFINED> instruction: 0x76457373
     8f0:	636f4c00 	cmnvs	pc, #0, 24
     8f4:	6e555f6b 	cdpvs	15, 5, cr5, cr5, cr11, {3}
     8f8:	6b636f6c 	blvs	18dc6b0 <__bss_end+0x18d3710>
     8fc:	6d006465 	cfstrsvs	mvf6, [r0, #-404]	; 0xfffffe6c
     900:	7473614c 	ldrbtvc	r6, [r3], #-332	; 0xfffffeb4
     904:	4449505f 	strbmi	r5, [r9], #-95	; 0xffffffa1
     908:	69775300 	ldmdbvs	r7!, {r8, r9, ip, lr}^
     90c:	5f686374 	svcpl	0x00686374
     910:	43006f54 	movwmi	r6, #3924	; 0xf54
     914:	65736f6c 	ldrbvs	r6, [r3, #-3948]!	; 0xfffff094
     918:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     91c:	50433631 	subpl	r3, r3, r1, lsr r6
     920:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     924:	4d5f7373 	ldclmi	3, cr7, [pc, #-460]	; 760 <shift+0x760>
     928:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
     92c:	32317265 	eorscc	r7, r1, #1342177286	; 0x50000006
     930:	65686353 	strbvs	r6, [r8, #-851]!	; 0xfffffcad
     934:	656c7564 	strbvs	r7, [ip, #-1380]!	; 0xfffffa9c
     938:	4644455f 			; <UNDEFINED> instruction: 0x4644455f
     93c:	42007645 	andmi	r7, r0, #72351744	; 0x4500000
     940:	5f304353 	svcpl	0x00304353
     944:	65736142 	ldrbvs	r6, [r3, #-322]!	; 0xfffffebe
     948:	355a5f00 	ldrbcc	r5, [sl, #-3840]	; 0xfffff100
     94c:	6e696c62 	cdpvs	12, 6, cr6, cr9, cr2, {3}
     950:	6100766b 	tstvs	r0, fp, ror #12
     954:	00636772 	rsbeq	r6, r3, r2, ror r7
     958:	69746f6e 	ldmdbvs	r4!, {r1, r2, r3, r5, r6, r8, r9, sl, fp, sp, lr}^
     95c:	64656966 	strbtvs	r6, [r5], #-2406	; 0xfffff69a
     960:	6165645f 	cmnvs	r5, pc, asr r4
     964:	6e696c64 	cdpvs	12, 6, cr6, cr9, cr4, {3}
     968:	72610065 	rsbvc	r0, r1, #101	; 0x65
     96c:	5f007667 	svcpl	0x00007667
     970:	36314e5a 			; <UNDEFINED> instruction: 0x36314e5a
     974:	6f725043 	svcvs	0x00725043
     978:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     97c:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     980:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     984:	6f4e3431 	svcvs	0x004e3431
     988:	79666974 	stmdbvc	r6!, {r2, r4, r5, r6, r8, fp, sp, lr}^
     98c:	6f72505f 	svcvs	0x0072505f
     990:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     994:	4e006a45 	vmlsmi.f32	s12, s0, s10
     998:	6c69466f 	stclvs	6, cr4, [r9], #-444	; 0xfffffe44
     99c:	73797365 	cmnvc	r9, #-1811939327	; 0x94000001
     9a0:	446d6574 	strbtmi	r6, [sp], #-1396	; 0xfffffa8c
     9a4:	65766972 	ldrbvs	r6, [r6, #-2418]!	; 0xfffff68e
     9a8:	65440072 	strbvs	r0, [r4, #-114]	; 0xffffff8e
     9ac:	696c6461 	stmdbvs	ip!, {r0, r5, r6, sl, sp, lr}^
     9b0:	7300656e 	movwvc	r6, #1390	; 0x56e
     9b4:	74726f68 	ldrbtvc	r6, [r2], #-3944	; 0xfffff098
     9b8:	746e6920 	strbtvc	r6, [lr], #-2336	; 0xfffff6e0
     9bc:	78614d00 	stmdavc	r1!, {r8, sl, fp, lr}^
     9c0:	656c6946 	strbvs	r6, [ip, #-2374]!	; 0xfffff6ba
     9c4:	656d616e 	strbvs	r6, [sp, #-366]!	; 0xfffffe92
     9c8:	676e654c 	strbvs	r6, [lr, -ip, asr #10]!
     9cc:	43006874 	movwmi	r6, #2164	; 0x874
     9d0:	636f7250 	cmnvs	pc, #80, 4
     9d4:	5f737365 	svcpl	0x00737365
     9d8:	616e614d 	cmnvs	lr, sp, asr #2
     9dc:	00726567 	rsbseq	r6, r2, r7, ror #10
     9e0:	72627474 	rsbvc	r7, r2, #116, 8	; 0x74000000
     9e4:	534e0030 	movtpl	r0, #57392	; 0xe030
     9e8:	465f4957 			; <UNDEFINED> instruction: 0x465f4957
     9ec:	73656c69 	cmnvc	r5, #26880	; 0x6900
     9f0:	65747379 	ldrbvs	r7, [r4, #-889]!	; 0xfffffc87
     9f4:	65535f6d 	ldrbvs	r5, [r3, #-3949]	; 0xfffff093
     9f8:	63697672 	cmnvs	r9, #119537664	; 0x7200000
     9fc:	534e0065 	movtpl	r0, #57445	; 0xe065
     a00:	505f4957 	subspl	r4, pc, r7, asr r9	; <UNPREDICTABLE>
     a04:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     a08:	535f7373 	cmppl	pc, #-872415231	; 0xcc000001
     a0c:	69767265 	ldmdbvs	r6!, {r0, r2, r5, r6, r9, ip, sp, lr}^
     a10:	6f006563 	svcvs	0x00006563
     a14:	656e6570 	strbvs	r6, [lr, #-1392]!	; 0xfffffa90
     a18:	69665f64 	stmdbvs	r6!, {r2, r5, r6, r8, r9, sl, fp, ip, lr}^
     a1c:	0073656c 	rsbseq	r6, r3, ip, ror #10
     a20:	6c656959 			; <UNDEFINED> instruction: 0x6c656959
     a24:	6e490064 	cdpvs	0, 4, cr0, cr9, cr4, {3}
     a28:	69666564 	stmdbvs	r6!, {r2, r5, r6, r8, sl, sp, lr}^
     a2c:	6574696e 	ldrbvs	r6, [r4, #-2414]!	; 0xfffff692
     a30:	74654700 	strbtvc	r4, [r5], #-1792	; 0xfffff900
     a34:	6f72505f 	svcvs	0x0072505f
     a38:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     a3c:	5f79425f 	svcpl	0x0079425f
     a40:	00444950 	subeq	r4, r4, r0, asr r9
     a44:	69726550 	ldmdbvs	r2!, {r4, r6, r8, sl, sp, lr}^
     a48:	72656870 	rsbvc	r6, r5, #112, 16	; 0x700000
     a4c:	425f6c61 	subsmi	r6, pc, #24832	; 0x6100
     a50:	00657361 	rsbeq	r7, r5, r1, ror #6
     a54:	676e6f6c 	strbvs	r6, [lr, -ip, ror #30]!
     a58:	736e7520 	cmnvc	lr, #32, 10	; 0x8000000
     a5c:	656e6769 	strbvs	r6, [lr, #-1897]!	; 0xfffff897
     a60:	6e692064 	cdpvs	0, 6, cr2, cr9, cr4, {3}
     a64:	6e490074 	mcrvs	0, 2, r0, cr9, cr4, {3}
     a68:	696c6176 	stmdbvs	ip!, {r1, r2, r4, r5, r6, r8, sp, lr}^
     a6c:	69505f64 	ldmdbvs	r0, {r2, r5, r6, r8, r9, sl, fp, ip, lr}^
     a70:	616d006e 	cmnvs	sp, lr, rrx
     a74:	72657473 	rsbvc	r7, r5, #1929379840	; 0x73000000
     a78:	636f4c00 	cmnvs	pc, #0, 24
     a7c:	6f4c5f6b 	svcvs	0x004c5f6b
     a80:	64656b63 	strbtvs	r6, [r5], #-2915	; 0xfffff49d
     a84:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     a88:	50433631 	subpl	r3, r3, r1, lsr r6
     a8c:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     a90:	4d5f7373 	ldclmi	3, cr7, [pc, #-460]	; 8cc <shift+0x8cc>
     a94:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
     a98:	38317265 	ldmdacc	r1!, {r0, r2, r5, r6, r9, ip, sp, lr}
     a9c:	646e6148 	strbtvs	r6, [lr], #-328	; 0xfffffeb8
     aa0:	505f656c 	subspl	r6, pc, ip, ror #10
     aa4:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     aa8:	535f7373 	cmppl	pc, #-872415231	; 0xcc000001
     aac:	32454957 	subcc	r4, r5, #1425408	; 0x15c000
     ab0:	57534e30 	smmlarpl	r3, r0, lr, r4
     ab4:	72505f49 	subsvc	r5, r0, #292	; 0x124
     ab8:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     abc:	65535f73 	ldrbvs	r5, [r3, #-3955]	; 0xfffff08d
     ac0:	63697672 	cmnvs	r9, #119537664	; 0x7200000
     ac4:	6a6a6a65 	bvs	1a9b460 <__bss_end+0x1a924c0>
     ac8:	54313152 	ldrtpl	r3, [r1], #-338	; 0xfffffeae
     acc:	5f495753 	svcpl	0x00495753
     ad0:	75736552 	ldrbvc	r6, [r3, #-1362]!	; 0xfffffaae
     ad4:	7300746c 	movwvc	r7, #1132	; 0x46c
     ad8:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     adc:	756f635f 	strbvc	r6, [pc, #-863]!	; 785 <shift+0x785>
     ae0:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
     ae4:	736e7500 	cmnvc	lr, #0, 10
     ae8:	656e6769 	strbvs	r6, [lr, #-1897]!	; 0xfffff897
     aec:	68632064 	stmdavs	r3!, {r2, r5, r6, sp}^
     af0:	49007261 	stmdbmi	r0, {r0, r5, r6, r9, ip, sp, lr}
     af4:	535f4332 	cmppl	pc, #-939524096	; 0xc8000000
     af8:	4556414c 	ldrbmi	r4, [r6, #-332]	; 0xfffffeb4
     afc:	7361425f 	cmnvc	r1, #-268435451	; 0xf0000005
     b00:	6e490065 	cdpvs	0, 4, cr0, cr9, cr5, {3}
     b04:	72726574 	rsbsvc	r6, r2, #116, 10	; 0x1d000000
     b08:	61747075 	cmnvs	r4, r5, ror r0
     b0c:	5f656c62 	svcpl	0x00656c62
     b10:	65656c53 	strbvs	r6, [r5, #-3155]!	; 0xfffff3ad
     b14:	63530070 	cmpvs	r3, #112	; 0x70
     b18:	75646568 	strbvc	r6, [r4, #-1384]!	; 0xfffffa98
     b1c:	525f656c 	subspl	r6, pc, #108, 10	; 0x1b000000
     b20:	55410052 	strbpl	r0, [r1, #-82]	; 0xffffffae
     b24:	61425f58 	cmpvs	r2, r8, asr pc
     b28:	42006573 	andmi	r6, r0, #482344960	; 0x1cc00000
     b2c:	5f324353 	svcpl	0x00324353
     b30:	65736142 	ldrbvs	r6, [r3, #-322]!	; 0xfffffebe
     b34:	61747300 	cmnvs	r4, r0, lsl #6
     b38:	57006574 	smlsdxpl	r0, r4, r5, r6
     b3c:	65746972 	ldrbvs	r6, [r4, #-2418]!	; 0xfffff68e
     b40:	6c6e4f5f 	stclvs	15, cr4, [lr], #-380	; 0xfffffe84
     b44:	63530079 	cmpvs	r3, #121	; 0x79
     b48:	75646568 	strbvc	r6, [r4, #-1384]!	; 0xfffffa98
     b4c:	5400656c 	strpl	r6, [r0], #-1388	; 0xfffffa94
     b50:	5f6b6369 	svcpl	0x006b6369
     b54:	6e756f43 	cdpvs	15, 7, cr6, cr5, cr3, {2}
     b58:	5a5f0074 	bpl	17c0d30 <__bss_end+0x17b7d90>
     b5c:	4336314e 	teqmi	r6, #-2147483629	; 0x80000013
     b60:	636f7250 	cmnvs	pc, #80, 4
     b64:	5f737365 	svcpl	0x00737365
     b68:	616e614d 	cmnvs	lr, sp, asr #2
     b6c:	31726567 	cmncc	r2, r7, ror #10
     b70:	6d6e5538 	cfstr64vs	mvdx5, [lr, #-224]!	; 0xffffff20
     b74:	465f7061 	ldrbmi	r7, [pc], -r1, rrx
     b78:	5f656c69 	svcpl	0x00656c69
     b7c:	72727543 	rsbsvc	r7, r2, #281018368	; 0x10c00000
     b80:	45746e65 	ldrbmi	r6, [r4, #-3685]!	; 0xfffff19b
     b84:	6148006a 	cmpvs	r8, sl, rrx
     b88:	656c646e 	strbvs	r6, [ip, #-1134]!	; 0xfffffb92
     b8c:	6c69465f 	stclvs	6, cr4, [r9], #-380	; 0xfffffe84
     b90:	73797365 	cmnvc	r9, #-1811939327	; 0x94000001
     b94:	5f6d6574 	svcpl	0x006d6574
     b98:	00495753 	subeq	r5, r9, r3, asr r7
     b9c:	726f6873 	rsbvc	r6, pc, #7536640	; 0x730000
     ba0:	6e752074 	mrcvs	0, 3, r2, cr5, cr4, {3}
     ba4:	6e676973 			; <UNDEFINED> instruction: 0x6e676973
     ba8:	69206465 	stmdbvs	r0!, {r0, r2, r5, r6, sl, sp, lr}
     bac:	6d00746e 	cfstrsvs	mvf7, [r0, #-440]	; 0xfffffe48
     bb0:	006e6961 	rsbeq	r6, lr, r1, ror #18
     bb4:	65746e49 	ldrbvs	r6, [r4, #-3657]!	; 0xfffff1b7
     bb8:	70757272 	rsbsvc	r7, r5, r2, ror r2
     bbc:	6f435f74 	svcvs	0x00435f74
     bc0:	6f72746e 	svcvs	0x0072746e
     bc4:	72656c6c 	rsbvc	r6, r5, #108, 24	; 0x6c00
     bc8:	7361425f 	cmnvc	r1, #-268435451	; 0xf0000005
     bcc:	65520065 	ldrbvs	r0, [r2, #-101]	; 0xffffff9b
     bd0:	575f6461 	ldrbpl	r6, [pc, -r1, ror #8]
     bd4:	65746972 	ldrbvs	r6, [r4, #-2418]!	; 0xfffff68e
     bd8:	74634100 	strbtvc	r4, [r3], #-256	; 0xffffff00
     bdc:	5f657669 	svcpl	0x00657669
     be0:	636f7250 	cmnvs	pc, #80, 4
     be4:	5f737365 	svcpl	0x00737365
     be8:	6e756f43 	cdpvs	15, 7, cr6, cr5, cr3, {2}
     bec:	79730074 	ldmdbvc	r3!, {r2, r4, r5, r6}^
     bf0:	6c6f626d 	sfmvs	f6, 2, [pc], #-436	; a44 <shift+0xa44>
     bf4:	6369745f 	cmnvs	r9, #1593835520	; 0x5f000000
     bf8:	65645f6b 	strbvs	r5, [r4, #-3947]!	; 0xfffff095
     bfc:	0079616c 	rsbseq	r6, r9, ip, ror #2
     c00:	314e5a5f 	cmpcc	lr, pc, asr sl
     c04:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     c08:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     c0c:	614d5f73 	hvcvs	54771	; 0xd5f3
     c10:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     c14:	48313272 	ldmdami	r1!, {r1, r4, r5, r6, r9, ip, sp}
     c18:	6c646e61 	stclvs	14, cr6, [r4], #-388	; 0xfffffe7c
     c1c:	69465f65 	stmdbvs	r6, {r0, r2, r5, r6, r8, r9, sl, fp, ip, lr}^
     c20:	7973656c 	ldmdbvc	r3!, {r2, r3, r5, r6, r8, sl, sp, lr}^
     c24:	6d657473 	cfstrdvs	mvd7, [r5, #-460]!	; 0xfffffe34
     c28:	4957535f 	ldmdbmi	r7, {r0, r1, r2, r3, r4, r6, r8, r9, ip, lr}^
     c2c:	4e333245 	cdpmi	2, 3, cr3, cr3, cr5, {2}
     c30:	5f495753 	svcpl	0x00495753
     c34:	656c6946 	strbvs	r6, [ip, #-2374]!	; 0xfffff6ba
     c38:	74737973 	ldrbtvc	r7, [r3], #-2419	; 0xfffff68d
     c3c:	535f6d65 	cmppl	pc, #6464	; 0x1940
     c40:	69767265 	ldmdbvs	r6!, {r0, r2, r5, r6, r9, ip, sp, lr}^
     c44:	6a6a6563 	bvs	1a9a1d8 <__bss_end+0x1a91238>
     c48:	3131526a 	teqcc	r1, sl, ror #4
     c4c:	49575354 	ldmdbmi	r7, {r2, r4, r6, r8, r9, ip, lr}^
     c50:	7365525f 	cmnvc	r5, #-268435451	; 0xf0000005
     c54:	00746c75 	rsbseq	r6, r4, r5, ror ip
     c58:	6573552f 	ldrbvs	r5, [r3, #-1327]!	; 0xfffffad1
     c5c:	772f7372 			; <UNDEFINED> instruction: 0x772f7372
     c60:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
     c64:	2f696a72 	svccs	0x00696a72
     c68:	6b736544 	blvs	1cda180 <__bss_end+0x1cd11e0>
     c6c:	2f706f74 	svccs	0x00706f74
     c70:	2f564146 	svccs	0x00564146
     c74:	6176614e 	cmnvs	r6, lr, asr #2
     c78:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
     c7c:	4f2f6963 	svcmi	0x002f6963
     c80:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
     c84:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
     c88:	6b6c6172 	blvs	1b19258 <__bss_end+0x1b102b8>
     c8c:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
     c90:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
     c94:	756f732f 	strbvc	r7, [pc, #-815]!	; 96d <shift+0x96d>
     c98:	73656372 	cmnvc	r5, #-939524095	; 0xc8000001
     c9c:	6975622f 	ldmdbvs	r5!, {r0, r1, r2, r3, r5, r9, sp, lr}^
     ca0:	6300646c 	movwvs	r6, #1132	; 0x46c
     ca4:	65736f6c 	ldrbvs	r6, [r3, #-3948]!	; 0xfffff094
     ca8:	74655300 	strbtvc	r5, [r5], #-768	; 0xfffffd00
     cac:	6c65525f 	sfmvs	f5, 2, [r5], #-380	; 0xfffffe84
     cb0:	76697461 	strbtvc	r7, [r9], -r1, ror #8
     cb4:	65720065 	ldrbvs	r0, [r2, #-101]!	; 0xffffff9b
     cb8:	6c617674 	stclvs	6, cr7, [r1], #-464	; 0xfffffe30
     cbc:	75636e00 	strbvc	r6, [r3, #-3584]!	; 0xfffff200
     cc0:	69700072 	ldmdbvs	r0!, {r1, r4, r5, r6}^
     cc4:	72006570 	andvc	r6, r0, #112, 10	; 0x1c000000
     cc8:	6d756e64 	ldclvs	14, cr6, [r5, #-400]!	; 0xfffffe70
     ccc:	315a5f00 	cmpcc	sl, r0, lsl #30
     cd0:	68637331 	stmdavs	r3!, {r0, r4, r5, r8, r9, ip, sp, lr}^
     cd4:	795f6465 	ldmdbvc	pc, {r0, r2, r5, r6, sl, sp, lr}^	; <UNPREDICTABLE>
     cd8:	646c6569 	strbtvs	r6, [ip], #-1385	; 0xfffffa97
     cdc:	5a5f0076 	bpl	17c0ebc <__bss_end+0x17b7f1c>
     ce0:	65733731 	ldrbvs	r3, [r3, #-1841]!	; 0xfffff8cf
     ce4:	61745f74 	cmnvs	r4, r4, ror pc
     ce8:	645f6b73 	ldrbvs	r6, [pc], #-2931	; cf0 <shift+0xcf0>
     cec:	6c646165 	stfvse	f6, [r4], #-404	; 0xfffffe6c
     cf0:	6a656e69 	bvs	195c69c <__bss_end+0x19536fc>
     cf4:	69617700 	stmdbvs	r1!, {r8, r9, sl, ip, sp, lr}^
     cf8:	5a5f0074 	bpl	17c0ed0 <__bss_end+0x17b7f30>
     cfc:	746f6e36 	strbtvc	r6, [pc], #-3638	; d04 <shift+0xd04>
     d00:	6a796669 	bvs	1e5a6ac <__bss_end+0x1e5170c>
     d04:	6146006a 	cmpvs	r6, sl, rrx
     d08:	65006c69 	strvs	r6, [r0, #-3177]	; 0xfffff397
     d0c:	63746978 	cmnvs	r4, #120, 18	; 0x1e0000
     d10:	0065646f 	rsbeq	r6, r5, pc, ror #8
     d14:	65686373 	strbvs	r6, [r8, #-883]!	; 0xfffffc8d
     d18:	69795f64 	ldmdbvs	r9!, {r2, r5, r6, r8, r9, sl, fp, ip, lr}^
     d1c:	00646c65 	rsbeq	r6, r4, r5, ror #24
     d20:	6b636974 	blvs	18db2f8 <__bss_end+0x18d2358>
     d24:	756f635f 	strbvc	r6, [pc, #-863]!	; 9cd <shift+0x9cd>
     d28:	725f746e 	subsvc	r7, pc, #1845493760	; 0x6e000000
     d2c:	69757165 	ldmdbvs	r5!, {r0, r2, r5, r6, r8, ip, sp, lr}^
     d30:	00646572 	rsbeq	r6, r4, r2, ror r5
     d34:	34325a5f 	ldrtcc	r5, [r2], #-2655	; 0xfffff5a1
     d38:	5f746567 	svcpl	0x00746567
     d3c:	69746361 	ldmdbvs	r4!, {r0, r5, r6, r8, r9, sp, lr}^
     d40:	705f6576 	subsvc	r6, pc, r6, ror r5	; <UNPREDICTABLE>
     d44:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     d48:	635f7373 	cmpvs	pc, #-872415231	; 0xcc000001
     d4c:	746e756f 	strbtvc	r7, [lr], #-1391	; 0xfffffa91
     d50:	69500076 	ldmdbvs	r0, {r1, r2, r4, r5, r6}^
     d54:	465f6570 			; <UNDEFINED> instruction: 0x465f6570
     d58:	5f656c69 	svcpl	0x00656c69
     d5c:	66657250 			; <UNDEFINED> instruction: 0x66657250
     d60:	53007869 	movwpl	r7, #2153	; 0x869
     d64:	505f7465 	subspl	r7, pc, r5, ror #8
     d68:	6d617261 	sfmvs	f7, 2, [r1, #-388]!	; 0xfffffe7c
     d6c:	5a5f0073 	bpl	17c0f40 <__bss_end+0x17b7fa0>
     d70:	65673431 	strbvs	r3, [r7, #-1073]!	; 0xfffffbcf
     d74:	69745f74 	ldmdbvs	r4!, {r2, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     d78:	635f6b63 	cmpvs	pc, #101376	; 0x18c00
     d7c:	746e756f 	strbtvc	r7, [lr], #-1391	; 0xfffffa91
     d80:	6c730076 	ldclvs	0, cr0, [r3], #-472	; 0xfffffe28
     d84:	00706565 	rsbseq	r6, r0, r5, ror #10
     d88:	61736944 	cmnvs	r3, r4, asr #18
     d8c:	5f656c62 	svcpl	0x00656c62
     d90:	6e657645 	cdpvs	6, 6, cr7, cr5, cr5, {2}
     d94:	65445f74 	strbvs	r5, [r4, #-3956]	; 0xfffff08c
     d98:	74636574 	strbtvc	r6, [r3], #-1396	; 0xfffffa8c
     d9c:	006e6f69 	rsbeq	r6, lr, r9, ror #30
     da0:	74395a5f 	ldrtvc	r5, [r9], #-2655	; 0xfffff5a1
     da4:	696d7265 	stmdbvs	sp!, {r0, r2, r5, r6, r9, ip, sp, lr}^
     da8:	6574616e 	ldrbvs	r6, [r4, #-366]!	; 0xfffffe92
     dac:	706f0069 	rsbvc	r0, pc, r9, rrx
     db0:	74617265 	strbtvc	r7, [r1], #-613	; 0xfffffd9b
     db4:	006e6f69 	rsbeq	r6, lr, r9, ror #30
     db8:	63355a5f 	teqvs	r5, #389120	; 0x5f000
     dbc:	65736f6c 	ldrbvs	r6, [r3, #-3948]!	; 0xfffff094
     dc0:	5a5f006a 	bpl	17c0f70 <__bss_end+0x17b7fd0>
     dc4:	74656736 	strbtvc	r6, [r5], #-1846	; 0xfffff8ca
     dc8:	76646970 			; <UNDEFINED> instruction: 0x76646970
     dcc:	616e6600 	cmnvs	lr, r0, lsl #12
     dd0:	7700656d 	strvc	r6, [r0, -sp, ror #10]
     dd4:	65746972 	ldrbvs	r6, [r4, #-2418]!	; 0xfffff68e
     dd8:	63697400 	cmnvs	r9, #0, 8
     ddc:	6f00736b 	svcvs	0x0000736b
     de0:	006e6570 	rsbeq	r6, lr, r0, ror r5
     de4:	70345a5f 	eorsvc	r5, r4, pc, asr sl
     de8:	50657069 	rsbpl	r7, r5, r9, rrx
     dec:	006a634b 	rsbeq	r6, sl, fp, asr #6
     df0:	6165444e 	cmnvs	r5, lr, asr #8
     df4:	6e696c64 	cdpvs	12, 6, cr6, cr9, cr4, {3}
     df8:	75535f65 	ldrbvc	r5, [r3, #-3941]	; 0xfffff09b
     dfc:	72657362 	rsbvc	r7, r5, #-2013265919	; 0x88000001
     e00:	65636976 	strbvs	r6, [r3, #-2422]!	; 0xfffff68a
     e04:	74656700 	strbtvc	r6, [r5], #-1792	; 0xfffff900
     e08:	6369745f 	cmnvs	r9, #1593835520	; 0x5f000000
     e0c:	6f635f6b 	svcvs	0x00635f6b
     e10:	00746e75 	rsbseq	r6, r4, r5, ror lr
     e14:	61726170 	cmnvs	r2, r0, ror r1
     e18:	5a5f006d 	bpl	17c0fd4 <__bss_end+0x17b8034>
     e1c:	69727735 	ldmdbvs	r2!, {r0, r2, r4, r5, r8, r9, sl, ip, sp, lr}^
     e20:	506a6574 	rsbpl	r6, sl, r4, ror r5
     e24:	006a634b 	rsbeq	r6, sl, fp, asr #6
     e28:	5f746567 	svcpl	0x00746567
     e2c:	6b736174 	blvs	1cd9404 <__bss_end+0x1cd0464>
     e30:	6369745f 	cmnvs	r9, #1593835520	; 0x5f000000
     e34:	745f736b 	ldrbvc	r7, [pc], #-875	; e3c <shift+0xe3c>
     e38:	65645f6f 	strbvs	r5, [r4, #-3951]!	; 0xfffff091
     e3c:	696c6461 	stmdbvs	ip!, {r0, r5, r6, sl, sp, lr}^
     e40:	6200656e 	andvs	r6, r0, #461373440	; 0x1b800000
     e44:	735f6675 	cmpvc	pc, #122683392	; 0x7500000
     e48:	00657a69 	rsbeq	r7, r5, r9, ror #20
     e4c:	5f746573 	svcpl	0x00746573
     e50:	6b736174 	blvs	1cd9428 <__bss_end+0x1cd0488>
     e54:	6165645f 	cmnvs	r5, pc, asr r4
     e58:	6e696c64 	cdpvs	12, 6, cr6, cr9, cr4, {3}
     e5c:	65470065 	strbvs	r0, [r7, #-101]	; 0xffffff9b
     e60:	61505f74 	cmpvs	r0, r4, ror pc
     e64:	736d6172 	cmnvc	sp, #-2147483620	; 0x8000001c
     e68:	73552f00 	cmpvc	r5, #0, 30
     e6c:	2f737265 	svccs	0x00737265
     e70:	746e6977 	strbtvc	r6, [lr], #-2423	; 0xfffff689
     e74:	696a7265 	stmdbvs	sl!, {r0, r2, r5, r6, r9, ip, sp, lr}^
     e78:	7365442f 	cmnvc	r5, #788529152	; 0x2f000000
     e7c:	706f746b 	rsbvc	r7, pc, fp, ror #8
     e80:	5641462f 	strbpl	r4, [r1], -pc, lsr #12
     e84:	76614e2f 	strbtvc	r4, [r1], -pc, lsr #28
     e88:	6a757a61 	bvs	1d5f814 <__bss_end+0x1d56874>
     e8c:	2f696369 	svccs	0x00696369
     e90:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
     e94:	73656d65 	cmnvc	r5, #6464	; 0x1940
     e98:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
     e9c:	6b2d616b 	blvs	b59450 <__bss_end+0xb504b0>
     ea0:	6f2d7669 	svcvs	0x002d7669
     ea4:	6f732f73 	svcvs	0x00732f73
     ea8:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
     eac:	74732f73 	ldrbtvc	r2, [r3], #-3955	; 0xfffff08d
     eb0:	62696c64 	rsbvs	r6, r9, #100, 24	; 0x6400
     eb4:	6372732f 	cmnvs	r2, #-1140850688	; 0xbc000000
     eb8:	6474732f 	ldrbtvs	r7, [r4], #-815	; 0xfffffcd1
     ebc:	656c6966 	strbvs	r6, [ip, #-2406]!	; 0xfffff69a
     ec0:	7070632e 	rsbsvc	r6, r0, lr, lsr #6
     ec4:	355a5f00 	ldrbcc	r5, [sl, #-3840]	; 0xfffff100
     ec8:	65656c73 	strbvs	r6, [r5, #-3187]!	; 0xfffff38d
     ecc:	006a6a70 	rsbeq	r6, sl, r0, ror sl
     ed0:	656c6966 	strbvs	r6, [ip, #-2406]!	; 0xfffff69a
     ed4:	74654700 	strbtvc	r4, [r5], #-1792	; 0xfffff900
     ed8:	6d65525f 	sfmvs	f5, 2, [r5, #-380]!	; 0xfffffe84
     edc:	696e6961 	stmdbvs	lr!, {r0, r5, r6, r8, fp, sp, lr}^
     ee0:	4500676e 	strmi	r6, [r0, #-1902]	; 0xfffff892
     ee4:	6c62616e 	stfvse	f6, [r2], #-440	; 0xfffffe48
     ee8:	76455f65 	strbvc	r5, [r5], -r5, ror #30
     eec:	5f746e65 	svcpl	0x00746e65
     ef0:	65746544 	ldrbvs	r6, [r4, #-1348]!	; 0xfffffabc
     ef4:	6f697463 	svcvs	0x00697463
     ef8:	5a5f006e 	bpl	17c10b8 <__bss_end+0x17b8118>
     efc:	65673632 	strbvs	r3, [r7, #-1586]!	; 0xfffff9ce
     f00:	61745f74 	cmnvs	r4, r4, ror pc
     f04:	745f6b73 	ldrbvc	r6, [pc], #-2931	; f0c <shift+0xf0c>
     f08:	736b6369 	cmnvc	fp, #-1543503871	; 0xa4000001
     f0c:	5f6f745f 	svcpl	0x006f745f
     f10:	64616564 	strbtvs	r6, [r1], #-1380	; 0xfffffa9c
     f14:	656e696c 	strbvs	r6, [lr, #-2412]!	; 0xfffff694
     f18:	534e0076 	movtpl	r0, #57462	; 0xe076
     f1c:	525f4957 	subspl	r4, pc, #1425408	; 0x15c000
     f20:	6c757365 	ldclvs	3, cr7, [r5], #-404	; 0xfffffe6c
     f24:	6f435f74 	svcvs	0x00435f74
     f28:	77006564 	strvc	r6, [r0, -r4, ror #10]
     f2c:	6d756e72 	ldclvs	14, cr6, [r5, #-456]!	; 0xfffffe38
     f30:	345a5f00 	ldrbcc	r5, [sl], #-3840	; 0xfffff100
     f34:	74696177 	strbtvc	r6, [r9], #-375	; 0xfffffe89
     f38:	006a6a6a 	rsbeq	r6, sl, sl, ror #20
     f3c:	69355a5f 	ldmdbvs	r5!, {r0, r1, r2, r3, r4, r6, r9, fp, ip, lr}
     f40:	6c74636f 	ldclvs	3, cr6, [r4], #-444	; 0xfffffe44
     f44:	4e36316a 	rsfmisz	f3, f6, #2.0
     f48:	74434f49 	strbvc	r4, [r3], #-3913	; 0xfffff0b7
     f4c:	704f5f6c 	subvc	r5, pc, ip, ror #30
     f50:	74617265 	strbtvc	r7, [r1], #-613	; 0xfffffd9b
     f54:	506e6f69 	rsbpl	r6, lr, r9, ror #30
     f58:	6f690076 	svcvs	0x00690076
     f5c:	006c7463 	rsbeq	r7, ip, r3, ror #8
     f60:	63746572 	cmnvs	r4, #478150656	; 0x1c800000
     f64:	6e00746e 	cdpvs	4, 0, cr7, cr0, cr14, {3}
     f68:	6669746f 	strbtvs	r7, [r9], -pc, ror #8
     f6c:	65740079 	ldrbvs	r0, [r4, #-121]!	; 0xffffff87
     f70:	6e696d72 	mcrvs	13, 3, r6, cr9, cr2, {3}
     f74:	00657461 	rsbeq	r7, r5, r1, ror #8
     f78:	65646f6d 	strbvs	r6, [r4, #-3949]!	; 0xfffff093
     f7c:	66756200 	ldrbtvs	r6, [r5], -r0, lsl #4
     f80:	00726566 	rsbseq	r6, r2, r6, ror #10
     f84:	72345a5f 	eorsvc	r5, r4, #389120	; 0x5f000
     f88:	6a646165 	bvs	1919524 <__bss_end+0x1910584>
     f8c:	006a6350 	rsbeq	r6, sl, r0, asr r3
     f90:	20554e47 	subscs	r4, r5, r7, asr #28
     f94:	312b2b43 			; <UNDEFINED> instruction: 0x312b2b43
     f98:	30312034 	eorscc	r2, r1, r4, lsr r0
     f9c:	312e332e 			; <UNDEFINED> instruction: 0x312e332e
     fa0:	32303220 	eorscc	r3, r0, #32, 4
     fa4:	32383031 	eorscc	r3, r8, #49	; 0x31
     fa8:	72282034 	eorvc	r2, r8, #52	; 0x34
     fac:	61656c65 	cmnvs	r5, r5, ror #24
     fb0:	20296573 	eorcs	r6, r9, r3, ror r5
     fb4:	6c666d2d 	stclvs	13, cr6, [r6], #-180	; 0xffffff4c
     fb8:	2d74616f 	ldfcse	f6, [r4, #-444]!	; 0xfffffe44
     fbc:	3d696261 	sfmcc	f6, 2, [r9, #-388]!	; 0xfffffe7c
     fc0:	64726168 	ldrbtvs	r6, [r2], #-360	; 0xfffffe98
     fc4:	666d2d20 	strbtvs	r2, [sp], -r0, lsr #26
     fc8:	763d7570 			; <UNDEFINED> instruction: 0x763d7570
     fcc:	2d207066 	stccs	0, cr7, [r0, #-408]!	; 0xfffffe68
     fd0:	6f6c666d 	svcvs	0x006c666d
     fd4:	612d7461 			; <UNDEFINED> instruction: 0x612d7461
     fd8:	683d6962 	ldmdavs	sp!, {r1, r5, r6, r8, fp, sp, lr}
     fdc:	20647261 	rsbcs	r7, r4, r1, ror #4
     fe0:	70666d2d 	rsbvc	r6, r6, sp, lsr #26
     fe4:	66763d75 			; <UNDEFINED> instruction: 0x66763d75
     fe8:	6d2d2070 	stcvs	0, cr2, [sp, #-448]!	; 0xfffffe40
     fec:	656e7574 	strbvs	r7, [lr, #-1396]!	; 0xfffffa8c
     ff0:	6d72613d 	ldfvse	f6, [r2, #-244]!	; 0xffffff0c
     ff4:	36373131 			; <UNDEFINED> instruction: 0x36373131
     ff8:	2d667a6a 	vstmdbcs	r6!, {s15-s120}
     ffc:	6d2d2073 	stcvs	0, cr2, [sp, #-460]!	; 0xfffffe34
    1000:	206d7261 	rsbcs	r7, sp, r1, ror #4
    1004:	72616d2d 	rsbvc	r6, r1, #2880	; 0xb40
    1008:	613d6863 	teqvs	sp, r3, ror #16
    100c:	36766d72 			; <UNDEFINED> instruction: 0x36766d72
    1010:	662b6b7a 			; <UNDEFINED> instruction: 0x662b6b7a
    1014:	672d2070 			; <UNDEFINED> instruction: 0x672d2070
    1018:	20672d20 	rsbcs	r2, r7, r0, lsr #26
    101c:	2d20672d 	stccs	7, cr6, [r0, #-180]!	; 0xffffff4c
    1020:	2d20304f 	stccs	0, cr3, [r0, #-316]!	; 0xfffffec4
    1024:	2d20304f 	stccs	0, cr3, [r0, #-316]!	; 0xfffffec4
    1028:	2d6f6e66 	stclcs	14, cr6, [pc, #-408]!	; e98 <shift+0xe98>
    102c:	65637865 	strbvs	r7, [r3, #-2149]!	; 0xfffff79b
    1030:	6f697470 	svcvs	0x00697470
    1034:	2d20736e 	stccs	3, cr7, [r0, #-440]!	; 0xfffffe48
    1038:	2d6f6e66 	stclcs	14, cr6, [pc, #-408]!	; ea8 <shift+0xea8>
    103c:	69747472 	ldmdbvs	r4!, {r1, r4, r5, r6, sl, ip, sp, lr}^
    1040:	4f494e00 	svcmi	0x00494e00
    1044:	5f6c7443 	svcpl	0x006c7443
    1048:	7265704f 	rsbvc	r7, r5, #79	; 0x4f
    104c:	6f697461 	svcvs	0x00697461
    1050:	6572006e 	ldrbvs	r0, [r2, #-110]!	; 0xffffff92
    1054:	646f6374 	strbtvs	r6, [pc], #-884	; 105c <shift+0x105c>
    1058:	65670065 	strbvs	r0, [r7, #-101]!	; 0xffffff9b
    105c:	63615f74 	cmnvs	r1, #116, 30	; 0x1d0
    1060:	65766974 	ldrbvs	r6, [r6, #-2420]!	; 0xfffff68c
    1064:	6f72705f 	svcvs	0x0072705f
    1068:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
    106c:	756f635f 	strbvc	r6, [pc, #-863]!	; d15 <shift+0xd15>
    1070:	6600746e 	strvs	r7, [r0], -lr, ror #8
    1074:	6e656c69 	cdpvs	12, 6, cr6, cr5, cr9, {3}
    1078:	00656d61 	rsbeq	r6, r5, r1, ror #26
    107c:	64616572 	strbtvs	r6, [r1], #-1394	; 0xfffffa8e
    1080:	74656700 	strbtvc	r6, [r5], #-1792	; 0xfffff900
    1084:	00646970 	rsbeq	r6, r4, r0, ror r9
    1088:	6f345a5f 	svcvs	0x00345a5f
    108c:	506e6570 	rsbpl	r6, lr, r0, ror r5
    1090:	3531634b 	ldrcc	r6, [r1, #-843]!	; 0xfffffcb5
    1094:	6c69464e 	stclvs	6, cr4, [r9], #-312	; 0xfffffec8
    1098:	704f5f65 	subvc	r5, pc, r5, ror #30
    109c:	4d5f6e65 	ldclmi	14, cr6, [pc, #-404]	; f10 <shift+0xf10>
    10a0:	0065646f 	rsbeq	r6, r5, pc, ror #8
    10a4:	75706e69 	ldrbvc	r6, [r0, #-3689]!	; 0xfffff197
    10a8:	65640074 	strbvs	r0, [r4, #-116]!	; 0xffffff8c
    10ac:	62007473 	andvs	r7, r0, #1929379840	; 0x73000000
    10b0:	6f72657a 	svcvs	0x0072657a
    10b4:	6e656c00 	cdpvs	12, 6, cr6, cr5, cr0, {0}
    10b8:	00687467 	rsbeq	r7, r8, r7, ror #8
    10bc:	62355a5f 	eorsvs	r5, r5, #389120	; 0x5f000
    10c0:	6f72657a 	svcvs	0x0072657a
    10c4:	00697650 	rsbeq	r7, r9, r0, asr r6
    10c8:	6573552f 	ldrbvs	r5, [r3, #-1327]!	; 0xfffffad1
    10cc:	772f7372 			; <UNDEFINED> instruction: 0x772f7372
    10d0:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
    10d4:	2f696a72 	svccs	0x00696a72
    10d8:	6b736544 	blvs	1cda5f0 <__bss_end+0x1cd1650>
    10dc:	2f706f74 	svccs	0x00706f74
    10e0:	2f564146 	svccs	0x00564146
    10e4:	6176614e 	cmnvs	r6, lr, asr #2
    10e8:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
    10ec:	4f2f6963 	svcmi	0x002f6963
    10f0:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
    10f4:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
    10f8:	6b6c6172 	blvs	1b196c8 <__bss_end+0x1b10728>
    10fc:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
    1100:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
    1104:	756f732f 	strbvc	r7, [pc, #-815]!	; ddd <shift+0xddd>
    1108:	73656372 	cmnvc	r5, #-939524095	; 0xc8000001
    110c:	6474732f 	ldrbtvs	r7, [r4], #-815	; 0xfffffcd1
    1110:	2f62696c 	svccs	0x0062696c
    1114:	2f637273 	svccs	0x00637273
    1118:	73647473 	cmnvc	r4, #1929379840	; 0x73000000
    111c:	6e697274 	mcrvs	2, 3, r7, cr9, cr4, {3}
    1120:	70632e67 	rsbvc	r2, r3, r7, ror #28
    1124:	5a5f0070 	bpl	17c12ec <__bss_end+0x17b834c>
    1128:	6f746134 	svcvs	0x00746134
    112c:	634b5069 	movtvs	r5, #45161	; 0xb069
    1130:	61684300 	cmnvs	r8, r0, lsl #6
    1134:	6e6f4372 	mcrvs	3, 3, r4, cr15, cr2, {3}
    1138:	72724176 	rsbsvc	r4, r2, #-2147483619	; 0x8000001d
    113c:	6d656d00 	stclvs	13, cr6, [r5, #-0]
    1140:	00747364 	rsbseq	r7, r4, r4, ror #6
    1144:	7074756f 	rsbsvc	r7, r4, pc, ror #10
    1148:	5f007475 	svcpl	0x00007475
    114c:	656d365a 	strbvs	r3, [sp, #-1626]!	; 0xfffff9a6
    1150:	7970636d 	ldmdbvc	r0!, {r0, r2, r3, r5, r6, r8, r9, sp, lr}^
    1154:	50764b50 	rsbspl	r4, r6, r0, asr fp
    1158:	62006976 	andvs	r6, r0, #1933312	; 0x1d8000
    115c:	00657361 	rsbeq	r7, r5, r1, ror #6
    1160:	636d656d 	cmnvs	sp, #457179136	; 0x1b400000
    1164:	73007970 	movwvc	r7, #2416	; 0x970
    1168:	656c7274 	strbvs	r7, [ip, #-628]!	; 0xfffffd8c
    116c:	5a5f006e 	bpl	17c132c <__bss_end+0x17b838c>
    1170:	72747337 	rsbsvc	r7, r4, #-603979776	; 0xdc000000
    1174:	706d636e 	rsbvc	r6, sp, lr, ror #6
    1178:	53634b50 	cmnpl	r3, #80, 22	; 0x14000
    117c:	00695f30 	rsbeq	r5, r9, r0, lsr pc
    1180:	73365a5f 	teqvc	r6, #389120	; 0x5f000
    1184:	656c7274 	strbvs	r7, [ip, #-628]!	; 0xfffffd8c
    1188:	634b506e 	movtvs	r5, #45166	; 0xb06e
    118c:	6f746100 	svcvs	0x00746100
    1190:	5a5f0069 	bpl	17c133c <__bss_end+0x17b839c>
    1194:	72747337 	rsbsvc	r7, r4, #-603979776	; 0xdc000000
    1198:	7970636e 	ldmdbvc	r0!, {r1, r2, r3, r5, r6, r8, r9, sp, lr}^
    119c:	4b506350 	blmi	1419ee4 <__bss_end+0x1410f44>
    11a0:	73006963 	movwvc	r6, #2403	; 0x963
    11a4:	636e7274 	cmnvs	lr, #116, 4	; 0x40000007
    11a8:	7300706d 	movwvc	r7, #109	; 0x6d
    11ac:	636e7274 	cmnvs	lr, #116, 4	; 0x40000007
    11b0:	6d007970 	vstrvs.16	s14, [r0, #-224]	; 0xffffff20	; <UNPREDICTABLE>
    11b4:	726f6d65 	rsbvc	r6, pc, #6464	; 0x1940
    11b8:	656d0079 	strbvs	r0, [sp, #-121]!	; 0xffffff87
    11bc:	6372736d 	cmnvs	r2, #-1275068415	; 0xb4000001
    11c0:	6f746900 	svcvs	0x00746900
    11c4:	5a5f0061 	bpl	17c1350 <__bss_end+0x17b83b0>
    11c8:	6f746934 	svcvs	0x00746934
    11cc:	63506a61 	cmpvs	r0, #397312	; 0x61000
    11d0:	Address 0x00000000000011d0 is out of bounds.


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
  20:	8b040e42 	blhi	103930 <__bss_end+0xfa990>
  24:	0b0d4201 	bleq	350830 <__bss_end+0x347890>
  28:	420d0d62 	andmi	r0, sp, #6272	; 0x1880
  2c:	00000ecb 	andeq	r0, r0, fp, asr #29
  30:	0000001c 	andeq	r0, r0, ip, lsl r0
  34:	00000000 	andeq	r0, r0, r0
  38:	00008064 	andeq	r8, r0, r4, rrx
  3c:	00000040 	andeq	r0, r0, r0, asr #32
  40:	8b080e42 	blhi	203950 <__bss_end+0x1fa9b0>
  44:	42018e02 	andmi	r8, r1, #2, 28
  48:	5a040b0c 	bpl	102c80 <__bss_end+0xf9ce0>
  4c:	00080d0c 	andeq	r0, r8, ip, lsl #26
  50:	0000000c 	andeq	r0, r0, ip
  54:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
  58:	7c020001 	stcvc	0, cr0, [r2], {1}
  5c:	000d0c0e 	andeq	r0, sp, lr, lsl #24
  60:	0000001c 	andeq	r0, r0, ip, lsl r0
  64:	00000050 	andeq	r0, r0, r0, asr r0
  68:	000080a4 	andeq	r8, r0, r4, lsr #1
  6c:	00000038 	andeq	r0, r0, r8, lsr r0
  70:	8b040e42 	blhi	103980 <__bss_end+0xfa9e0>
  74:	0b0d4201 	bleq	350880 <__bss_end+0x3478e0>
  78:	420d0d54 	andmi	r0, sp, #84, 26	; 0x1500
  7c:	00000ecb 	andeq	r0, r0, fp, asr #29
  80:	0000001c 	andeq	r0, r0, ip, lsl r0
  84:	00000050 	andeq	r0, r0, r0, asr r0
  88:	000080dc 	ldrdeq	r8, [r0], -ip
  8c:	0000002c 	andeq	r0, r0, ip, lsr #32
  90:	8b040e42 	blhi	1039a0 <__bss_end+0xfaa00>
  94:	0b0d4201 	bleq	3508a0 <__bss_end+0x347900>
  98:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
  9c:	00000ecb 	andeq	r0, r0, fp, asr #29
  a0:	0000001c 	andeq	r0, r0, ip, lsl r0
  a4:	00000050 	andeq	r0, r0, r0, asr r0
  a8:	00008108 	andeq	r8, r0, r8, lsl #2
  ac:	00000020 	andeq	r0, r0, r0, lsr #32
  b0:	8b040e42 	blhi	1039c0 <__bss_end+0xfaa20>
  b4:	0b0d4201 	bleq	3508c0 <__bss_end+0x347920>
  b8:	420d0d48 	andmi	r0, sp, #72, 26	; 0x1200
  bc:	00000ecb 	andeq	r0, r0, fp, asr #29
  c0:	0000001c 	andeq	r0, r0, ip, lsl r0
  c4:	00000050 	andeq	r0, r0, r0, asr r0
  c8:	00008128 	andeq	r8, r0, r8, lsr #2
  cc:	00000018 	andeq	r0, r0, r8, lsl r0
  d0:	8b040e42 	blhi	1039e0 <__bss_end+0xfaa40>
  d4:	0b0d4201 	bleq	3508e0 <__bss_end+0x347940>
  d8:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
  dc:	00000ecb 	andeq	r0, r0, fp, asr #29
  e0:	0000001c 	andeq	r0, r0, ip, lsl r0
  e4:	00000050 	andeq	r0, r0, r0, asr r0
  e8:	00008140 	andeq	r8, r0, r0, asr #2
  ec:	00000018 	andeq	r0, r0, r8, lsl r0
  f0:	8b040e42 	blhi	103a00 <__bss_end+0xfaa60>
  f4:	0b0d4201 	bleq	350900 <__bss_end+0x347960>
  f8:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
  fc:	00000ecb 	andeq	r0, r0, fp, asr #29
 100:	0000001c 	andeq	r0, r0, ip, lsl r0
 104:	00000050 	andeq	r0, r0, r0, asr r0
 108:	00008158 	andeq	r8, r0, r8, asr r1
 10c:	00000018 	andeq	r0, r0, r8, lsl r0
 110:	8b040e42 	blhi	103a20 <__bss_end+0xfaa80>
 114:	0b0d4201 	bleq	350920 <__bss_end+0x347980>
 118:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
 11c:	00000ecb 	andeq	r0, r0, fp, asr #29
 120:	00000014 	andeq	r0, r0, r4, lsl r0
 124:	00000050 	andeq	r0, r0, r0, asr r0
 128:	00008170 	andeq	r8, r0, r0, ror r1
 12c:	0000000c 	andeq	r0, r0, ip
 130:	8b040e42 	blhi	103a40 <__bss_end+0xfaaa0>
 134:	0b0d4201 	bleq	350940 <__bss_end+0x3479a0>
 138:	0000001c 	andeq	r0, r0, ip, lsl r0
 13c:	00000050 	andeq	r0, r0, r0, asr r0
 140:	0000817c 	andeq	r8, r0, ip, ror r1
 144:	00000058 	andeq	r0, r0, r8, asr r0
 148:	8b080e42 	blhi	203a58 <__bss_end+0x1faab8>
 14c:	42018e02 	andmi	r8, r1, #2, 28
 150:	62040b0c 	andvs	r0, r4, #12, 22	; 0x3000
 154:	00080d0c 	andeq	r0, r8, ip, lsl #26
 158:	0000001c 	andeq	r0, r0, ip, lsl r0
 15c:	00000050 	andeq	r0, r0, r0, asr r0
 160:	000081d4 	ldrdeq	r8, [r0], -r4
 164:	00000058 	andeq	r0, r0, r8, asr r0
 168:	8b080e42 	blhi	203a78 <__bss_end+0x1faad8>
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
 198:	8b080e42 	blhi	203aa8 <__bss_end+0x1fab08>
 19c:	42018e02 	andmi	r8, r1, #2, 28
 1a0:	00040b0c 	andeq	r0, r4, ip, lsl #22
 1a4:	00000018 	andeq	r0, r0, r8, lsl r0
 1a8:	00000178 	andeq	r0, r0, r8, ror r1
 1ac:	00008284 	andeq	r8, r0, r4, lsl #5
 1b0:	000000b8 	strheq	r0, [r0], -r8
 1b4:	8b080e42 	blhi	203ac4 <__bss_end+0x1fab24>
 1b8:	42018e02 	andmi	r8, r1, #2, 28
 1bc:	00040b0c 	andeq	r0, r4, ip, lsl #22
 1c0:	0000000c 	andeq	r0, r0, ip
 1c4:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 1c8:	7c020001 	stcvc	0, cr0, [r2], {1}
 1cc:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 1d0:	0000001c 	andeq	r0, r0, ip, lsl r0
 1d4:	000001c0 	andeq	r0, r0, r0, asr #3
 1d8:	0000833c 	andeq	r8, r0, ip, lsr r3
 1dc:	0000002c 	andeq	r0, r0, ip, lsr #32
 1e0:	8b040e42 	blhi	103af0 <__bss_end+0xfab50>
 1e4:	0b0d4201 	bleq	3509f0 <__bss_end+0x347a50>
 1e8:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
 1ec:	00000ecb 	andeq	r0, r0, fp, asr #29
 1f0:	0000001c 	andeq	r0, r0, ip, lsl r0
 1f4:	000001c0 	andeq	r0, r0, r0, asr #3
 1f8:	00008368 	andeq	r8, r0, r8, ror #6
 1fc:	0000002c 	andeq	r0, r0, ip, lsr #32
 200:	8b040e42 	blhi	103b10 <__bss_end+0xfab70>
 204:	0b0d4201 	bleq	350a10 <__bss_end+0x347a70>
 208:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
 20c:	00000ecb 	andeq	r0, r0, fp, asr #29
 210:	0000001c 	andeq	r0, r0, ip, lsl r0
 214:	000001c0 	andeq	r0, r0, r0, asr #3
 218:	00008394 	muleq	r0, r4, r3
 21c:	0000001c 	andeq	r0, r0, ip, lsl r0
 220:	8b040e42 	blhi	103b30 <__bss_end+0xfab90>
 224:	0b0d4201 	bleq	350a30 <__bss_end+0x347a90>
 228:	420d0d46 	andmi	r0, sp, #4480	; 0x1180
 22c:	00000ecb 	andeq	r0, r0, fp, asr #29
 230:	0000001c 	andeq	r0, r0, ip, lsl r0
 234:	000001c0 	andeq	r0, r0, r0, asr #3
 238:	000083b0 			; <UNDEFINED> instruction: 0x000083b0
 23c:	00000044 	andeq	r0, r0, r4, asr #32
 240:	8b040e42 	blhi	103b50 <__bss_end+0xfabb0>
 244:	0b0d4201 	bleq	350a50 <__bss_end+0x347ab0>
 248:	420d0d5a 	andmi	r0, sp, #5760	; 0x1680
 24c:	00000ecb 	andeq	r0, r0, fp, asr #29
 250:	0000001c 	andeq	r0, r0, ip, lsl r0
 254:	000001c0 	andeq	r0, r0, r0, asr #3
 258:	000083f4 	strdeq	r8, [r0], -r4
 25c:	00000050 	andeq	r0, r0, r0, asr r0
 260:	8b040e42 	blhi	103b70 <__bss_end+0xfabd0>
 264:	0b0d4201 	bleq	350a70 <__bss_end+0x347ad0>
 268:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 26c:	00000ecb 	andeq	r0, r0, fp, asr #29
 270:	0000001c 	andeq	r0, r0, ip, lsl r0
 274:	000001c0 	andeq	r0, r0, r0, asr #3
 278:	00008444 	andeq	r8, r0, r4, asr #8
 27c:	00000050 	andeq	r0, r0, r0, asr r0
 280:	8b040e42 	blhi	103b90 <__bss_end+0xfabf0>
 284:	0b0d4201 	bleq	350a90 <__bss_end+0x347af0>
 288:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 28c:	00000ecb 	andeq	r0, r0, fp, asr #29
 290:	0000001c 	andeq	r0, r0, ip, lsl r0
 294:	000001c0 	andeq	r0, r0, r0, asr #3
 298:	00008494 	muleq	r0, r4, r4
 29c:	0000002c 	andeq	r0, r0, ip, lsr #32
 2a0:	8b040e42 	blhi	103bb0 <__bss_end+0xfac10>
 2a4:	0b0d4201 	bleq	350ab0 <__bss_end+0x347b10>
 2a8:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
 2ac:	00000ecb 	andeq	r0, r0, fp, asr #29
 2b0:	0000001c 	andeq	r0, r0, ip, lsl r0
 2b4:	000001c0 	andeq	r0, r0, r0, asr #3
 2b8:	000084c0 	andeq	r8, r0, r0, asr #9
 2bc:	00000050 	andeq	r0, r0, r0, asr r0
 2c0:	8b040e42 	blhi	103bd0 <__bss_end+0xfac30>
 2c4:	0b0d4201 	bleq	350ad0 <__bss_end+0x347b30>
 2c8:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 2cc:	00000ecb 	andeq	r0, r0, fp, asr #29
 2d0:	0000001c 	andeq	r0, r0, ip, lsl r0
 2d4:	000001c0 	andeq	r0, r0, r0, asr #3
 2d8:	00008510 	andeq	r8, r0, r0, lsl r5
 2dc:	00000044 	andeq	r0, r0, r4, asr #32
 2e0:	8b040e42 	blhi	103bf0 <__bss_end+0xfac50>
 2e4:	0b0d4201 	bleq	350af0 <__bss_end+0x347b50>
 2e8:	420d0d5a 	andmi	r0, sp, #5760	; 0x1680
 2ec:	00000ecb 	andeq	r0, r0, fp, asr #29
 2f0:	0000001c 	andeq	r0, r0, ip, lsl r0
 2f4:	000001c0 	andeq	r0, r0, r0, asr #3
 2f8:	00008554 	andeq	r8, r0, r4, asr r5
 2fc:	00000050 	andeq	r0, r0, r0, asr r0
 300:	8b040e42 	blhi	103c10 <__bss_end+0xfac70>
 304:	0b0d4201 	bleq	350b10 <__bss_end+0x347b70>
 308:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 30c:	00000ecb 	andeq	r0, r0, fp, asr #29
 310:	0000001c 	andeq	r0, r0, ip, lsl r0
 314:	000001c0 	andeq	r0, r0, r0, asr #3
 318:	000085a4 	andeq	r8, r0, r4, lsr #11
 31c:	00000054 	andeq	r0, r0, r4, asr r0
 320:	8b040e42 	blhi	103c30 <__bss_end+0xfac90>
 324:	0b0d4201 	bleq	350b30 <__bss_end+0x347b90>
 328:	420d0d62 	andmi	r0, sp, #6272	; 0x1880
 32c:	00000ecb 	andeq	r0, r0, fp, asr #29
 330:	0000001c 	andeq	r0, r0, ip, lsl r0
 334:	000001c0 	andeq	r0, r0, r0, asr #3
 338:	000085f8 	strdeq	r8, [r0], -r8	; <UNPREDICTABLE>
 33c:	0000003c 	andeq	r0, r0, ip, lsr r0
 340:	8b040e42 	blhi	103c50 <__bss_end+0xfacb0>
 344:	0b0d4201 	bleq	350b50 <__bss_end+0x347bb0>
 348:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 34c:	00000ecb 	andeq	r0, r0, fp, asr #29
 350:	0000001c 	andeq	r0, r0, ip, lsl r0
 354:	000001c0 	andeq	r0, r0, r0, asr #3
 358:	00008634 	andeq	r8, r0, r4, lsr r6
 35c:	0000003c 	andeq	r0, r0, ip, lsr r0
 360:	8b040e42 	blhi	103c70 <__bss_end+0xfacd0>
 364:	0b0d4201 	bleq	350b70 <__bss_end+0x347bd0>
 368:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 36c:	00000ecb 	andeq	r0, r0, fp, asr #29
 370:	0000001c 	andeq	r0, r0, ip, lsl r0
 374:	000001c0 	andeq	r0, r0, r0, asr #3
 378:	00008670 	andeq	r8, r0, r0, ror r6
 37c:	0000003c 	andeq	r0, r0, ip, lsr r0
 380:	8b040e42 	blhi	103c90 <__bss_end+0xfacf0>
 384:	0b0d4201 	bleq	350b90 <__bss_end+0x347bf0>
 388:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 38c:	00000ecb 	andeq	r0, r0, fp, asr #29
 390:	0000001c 	andeq	r0, r0, ip, lsl r0
 394:	000001c0 	andeq	r0, r0, r0, asr #3
 398:	000086ac 	andeq	r8, r0, ip, lsr #13
 39c:	0000003c 	andeq	r0, r0, ip, lsr r0
 3a0:	8b040e42 	blhi	103cb0 <__bss_end+0xfad10>
 3a4:	0b0d4201 	bleq	350bb0 <__bss_end+0x347c10>
 3a8:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 3ac:	00000ecb 	andeq	r0, r0, fp, asr #29
 3b0:	0000001c 	andeq	r0, r0, ip, lsl r0
 3b4:	000001c0 	andeq	r0, r0, r0, asr #3
 3b8:	000086e8 	andeq	r8, r0, r8, ror #13
 3bc:	000000b0 	strheq	r0, [r0], -r0	; <UNPREDICTABLE>
 3c0:	8b080e42 	blhi	203cd0 <__bss_end+0x1fad30>
 3c4:	42018e02 	andmi	r8, r1, #2, 28
 3c8:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 3cc:	080d0c50 	stmdaeq	sp, {r4, r6, sl, fp}
 3d0:	0000000c 	andeq	r0, r0, ip
 3d4:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 3d8:	7c020001 	stcvc	0, cr0, [r2], {1}
 3dc:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 3e0:	0000001c 	andeq	r0, r0, ip, lsl r0
 3e4:	000003d0 	ldrdeq	r0, [r0], -r0	; <UNPREDICTABLE>
 3e8:	00008798 	muleq	r0, r8, r7
 3ec:	00000174 	andeq	r0, r0, r4, ror r1
 3f0:	8b080e42 	blhi	203d00 <__bss_end+0x1fad60>
 3f4:	42018e02 	andmi	r8, r1, #2, 28
 3f8:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 3fc:	080d0cb2 	stmdaeq	sp, {r1, r4, r5, r7, sl, fp}
 400:	0000001c 	andeq	r0, r0, ip, lsl r0
 404:	000003d0 	ldrdeq	r0, [r0], -r0	; <UNPREDICTABLE>
 408:	0000890c 	andeq	r8, r0, ip, lsl #18
 40c:	0000009c 	muleq	r0, ip, r0
 410:	8b040e42 	blhi	103d20 <__bss_end+0xfad80>
 414:	0b0d4201 	bleq	350c20 <__bss_end+0x347c80>
 418:	0d0d4602 	stceq	6, cr4, [sp, #-8]
 41c:	000ecb42 	andeq	ip, lr, r2, asr #22
 420:	0000001c 	andeq	r0, r0, ip, lsl r0
 424:	000003d0 	ldrdeq	r0, [r0], -r0	; <UNPREDICTABLE>
 428:	000089a8 	andeq	r8, r0, r8, lsr #19
 42c:	000000c0 	andeq	r0, r0, r0, asr #1
 430:	8b040e42 	blhi	103d40 <__bss_end+0xfada0>
 434:	0b0d4201 	bleq	350c40 <__bss_end+0x347ca0>
 438:	0d0d5802 	stceq	8, cr5, [sp, #-8]
 43c:	000ecb42 	andeq	ip, lr, r2, asr #22
 440:	0000001c 	andeq	r0, r0, ip, lsl r0
 444:	000003d0 	ldrdeq	r0, [r0], -r0	; <UNPREDICTABLE>
 448:	00008a68 	andeq	r8, r0, r8, ror #20
 44c:	000000ac 	andeq	r0, r0, ip, lsr #1
 450:	8b040e42 	blhi	103d60 <__bss_end+0xfadc0>
 454:	0b0d4201 	bleq	350c60 <__bss_end+0x347cc0>
 458:	0d0d4e02 	stceq	14, cr4, [sp, #-8]
 45c:	000ecb42 	andeq	ip, lr, r2, asr #22
 460:	0000001c 	andeq	r0, r0, ip, lsl r0
 464:	000003d0 	ldrdeq	r0, [r0], -r0	; <UNPREDICTABLE>
 468:	00008b14 	andeq	r8, r0, r4, lsl fp
 46c:	00000054 	andeq	r0, r0, r4, asr r0
 470:	8b040e42 	blhi	103d80 <__bss_end+0xfade0>
 474:	0b0d4201 	bleq	350c80 <__bss_end+0x347ce0>
 478:	420d0d62 	andmi	r0, sp, #6272	; 0x1880
 47c:	00000ecb 	andeq	r0, r0, fp, asr #29
 480:	0000001c 	andeq	r0, r0, ip, lsl r0
 484:	000003d0 	ldrdeq	r0, [r0], -r0	; <UNPREDICTABLE>
 488:	00008b68 	andeq	r8, r0, r8, ror #22
 48c:	00000068 	andeq	r0, r0, r8, rrx
 490:	8b040e42 	blhi	103da0 <__bss_end+0xfae00>
 494:	0b0d4201 	bleq	350ca0 <__bss_end+0x347d00>
 498:	420d0d6c 	andmi	r0, sp, #108, 26	; 0x1b00
 49c:	00000ecb 	andeq	r0, r0, fp, asr #29
 4a0:	0000001c 	andeq	r0, r0, ip, lsl r0
 4a4:	000003d0 	ldrdeq	r0, [r0], -r0	; <UNPREDICTABLE>
 4a8:	00008bd0 	ldrdeq	r8, [r0], -r0
 4ac:	00000080 	andeq	r0, r0, r0, lsl #1
 4b0:	8b040e42 	blhi	103dc0 <__bss_end+0xfae20>
 4b4:	0b0d4201 	bleq	350cc0 <__bss_end+0x347d20>
 4b8:	420d0d78 	andmi	r0, sp, #120, 26	; 0x1e00
 4bc:	00000ecb 	andeq	r0, r0, fp, asr #29
 4c0:	0000000c 	andeq	r0, r0, ip
 4c4:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 4c8:	7c010001 	stcvc	0, cr0, [r1], {1}
 4cc:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 4d0:	0000000c 	andeq	r0, r0, ip
 4d4:	000004c0 	andeq	r0, r0, r0, asr #9
 4d8:	00008c50 	andeq	r8, r0, r0, asr ip
 4dc:	000001ec 	andeq	r0, r0, ip, ror #3
