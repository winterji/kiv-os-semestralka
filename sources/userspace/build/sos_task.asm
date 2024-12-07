
./sos_task:     file format elf32-littlearm


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
    805c:	00009018 	andeq	r9, r0, r8, lsl r0
    8060:	00009030 	andeq	r9, r0, r0, lsr r0

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
    8080:	eb000089 	bl	82ac <main>
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
    81cc:	00009015 	andeq	r9, r0, r5, lsl r0
    81d0:	00009015 	andeq	r9, r0, r5, lsl r0

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
    8224:	00009015 	andeq	r9, r0, r5, lsl r0
    8228:	00009015 	andeq	r9, r0, r5, lsl r0

0000822c <_Z5blinkb>:
_Z5blinkb():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:23

uint32_t sos_led;
uint32_t button;

void blink(bool short_blink)
{
    822c:	e92d4800 	push	{fp, lr}
    8230:	e28db004 	add	fp, sp, #4
    8234:	e24dd008 	sub	sp, sp, #8
    8238:	e1a03000 	mov	r3, r0
    823c:	e54b3005 	strb	r3, [fp, #-5]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:24
	write(sos_led, "1", 1);
    8240:	e59f3058 	ldr	r3, [pc, #88]	; 82a0 <_Z5blinkb+0x74>
    8244:	e5933000 	ldr	r3, [r3]
    8248:	e3a02001 	mov	r2, #1
    824c:	e59f1050 	ldr	r1, [pc, #80]	; 82a4 <_Z5blinkb+0x78>
    8250:	e1a00003 	mov	r0, r3
    8254:	eb0000b1 	bl	8520 <_Z5writejPKcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:25
	sleep(short_blink ? 0x800 : 0x1000);
    8258:	e55b3005 	ldrb	r3, [fp, #-5]
    825c:	e3530000 	cmp	r3, #0
    8260:	0a000001 	beq	826c <_Z5blinkb+0x40>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:25 (discriminator 1)
    8264:	e3a03b02 	mov	r3, #2048	; 0x800
    8268:	ea000000 	b	8270 <_Z5blinkb+0x44>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:25 (discriminator 2)
    826c:	e3a03a01 	mov	r3, #4096	; 0x1000
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:25 (discriminator 4)
    8270:	e3e01001 	mvn	r1, #1
    8274:	e1a00003 	mov	r0, r3
    8278:	eb000100 	bl	8680 <_Z5sleepjj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:26 (discriminator 4)
	write(sos_led, "0", 1);
    827c:	e59f301c 	ldr	r3, [pc, #28]	; 82a0 <_Z5blinkb+0x74>
    8280:	e5933000 	ldr	r3, [r3]
    8284:	e3a02001 	mov	r2, #1
    8288:	e59f1018 	ldr	r1, [pc, #24]	; 82a8 <_Z5blinkb+0x7c>
    828c:	e1a00003 	mov	r0, r3
    8290:	eb0000a2 	bl	8520 <_Z5writejPKcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:27 (discriminator 4)
}
    8294:	e320f000 	nop	{0}
    8298:	e24bd004 	sub	sp, fp, #4
    829c:	e8bd8800 	pop	{fp, pc}
    82a0:	00009018 	andeq	r9, r0, r8, lsl r0
    82a4:	00008fa0 	andeq	r8, r0, r0, lsr #31
    82a8:	00008fa4 	andeq	r8, r0, r4, lsr #31

000082ac <main>:
main():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:30

int main(int argc, char** argv)
{
    82ac:	e92d4800 	push	{fp, lr}
    82b0:	e28db004 	add	fp, sp, #4
    82b4:	e24dd010 	sub	sp, sp, #16
    82b8:	e50b0010 	str	r0, [fp, #-16]
    82bc:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:31
	sos_led = open("DEV:gpio/18", NFile_Open_Mode::Write_Only);
    82c0:	e3a01001 	mov	r1, #1
    82c4:	e59f0134 	ldr	r0, [pc, #308]	; 8400 <main+0x154>
    82c8:	eb00006f 	bl	848c <_Z4openPKc15NFile_Open_Mode>
    82cc:	e1a03000 	mov	r3, r0
    82d0:	e59f212c 	ldr	r2, [pc, #300]	; 8404 <main+0x158>
    82d4:	e5823000 	str	r3, [r2]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:32
	button = open("DEV:gpio/16", NFile_Open_Mode::Read_Only);
    82d8:	e3a01000 	mov	r1, #0
    82dc:	e59f0124 	ldr	r0, [pc, #292]	; 8408 <main+0x15c>
    82e0:	eb000069 	bl	848c <_Z4openPKc15NFile_Open_Mode>
    82e4:	e1a03000 	mov	r3, r0
    82e8:	e59f211c 	ldr	r2, [pc, #284]	; 840c <main+0x160>
    82ec:	e5823000 	str	r3, [r2]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:34

	NGPIO_Interrupt_Type irtype = NGPIO_Interrupt_Type::Rising_Edge;
    82f0:	e3a03000 	mov	r3, #0
    82f4:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:35
	ioctl(button, NIOCtl_Operation::Enable_Event_Detection, &irtype);
    82f8:	e59f310c 	ldr	r3, [pc, #268]	; 840c <main+0x160>
    82fc:	e5933000 	ldr	r3, [r3]
    8300:	e24b200c 	sub	r2, fp, #12
    8304:	e3a01002 	mov	r1, #2
    8308:	e1a00003 	mov	r0, r3
    830c:	eb0000a2 	bl	859c <_Z5ioctlj16NIOCtl_OperationPv>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:37

	uint32_t logpipe = pipe("log", 32);
    8310:	e3a01020 	mov	r1, #32
    8314:	e59f00f4 	ldr	r0, [pc, #244]	; 8410 <main+0x164>
    8318:	eb000129 	bl	87c4 <_Z4pipePKcj>
    831c:	e50b0008 	str	r0, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:42 (discriminator 1)

	while (true)
	{
		// pockame na stisk klavesy
		wait(button, 1, 0x300);
    8320:	e59f30e4 	ldr	r3, [pc, #228]	; 840c <main+0x160>
    8324:	e5933000 	ldr	r3, [r3]
    8328:	e3a02c03 	mov	r2, #768	; 0x300
    832c:	e3a01001 	mov	r1, #1
    8330:	e1a00003 	mov	r0, r3
    8334:	eb0000bd 	bl	8630 <_Z4waitjjj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:51 (discriminator 1)
		// 2) my mame deadline 0x300
		// 3) log task ma deadline 0x1000
		// 4) jiny task ma deadline 0x500
		// jiny task dostane prednost pred log taskem, a pokud nesplni v kratkem case svou ulohu, tento task prekroci deadline
		// TODO: inverzi priorit bychom docasne zvysili prioritu (zkratili deadline) log tasku, aby vyprazdnil pipe a my se mohli odblokovat co nejdrive
		write(logpipe, "SOS!", 5);
    8338:	e3a02005 	mov	r2, #5
    833c:	e59f10d0 	ldr	r1, [pc, #208]	; 8414 <main+0x168>
    8340:	e51b0008 	ldr	r0, [fp, #-8]
    8344:	eb000075 	bl	8520 <_Z5writejPKcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:53 (discriminator 1)

		blink(true);
    8348:	e3a00001 	mov	r0, #1
    834c:	ebffffb6 	bl	822c <_Z5blinkb>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:54 (discriminator 1)
		sleep(symbol_tick_delay);
    8350:	e3e01001 	mvn	r1, #1
    8354:	e3a00b01 	mov	r0, #1024	; 0x400
    8358:	eb0000c8 	bl	8680 <_Z5sleepjj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:55 (discriminator 1)
		blink(true);
    835c:	e3a00001 	mov	r0, #1
    8360:	ebffffb1 	bl	822c <_Z5blinkb>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:56 (discriminator 1)
		sleep(symbol_tick_delay);
    8364:	e3e01001 	mvn	r1, #1
    8368:	e3a00b01 	mov	r0, #1024	; 0x400
    836c:	eb0000c3 	bl	8680 <_Z5sleepjj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:57 (discriminator 1)
		blink(true);
    8370:	e3a00001 	mov	r0, #1
    8374:	ebffffac 	bl	822c <_Z5blinkb>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:59 (discriminator 1)

		sleep(char_tick_delay);
    8378:	e3e01001 	mvn	r1, #1
    837c:	e3a00a01 	mov	r0, #4096	; 0x1000
    8380:	eb0000be 	bl	8680 <_Z5sleepjj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:61 (discriminator 1)

		blink(false);
    8384:	e3a00000 	mov	r0, #0
    8388:	ebffffa7 	bl	822c <_Z5blinkb>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:62 (discriminator 1)
		sleep(symbol_tick_delay);
    838c:	e3e01001 	mvn	r1, #1
    8390:	e3a00b01 	mov	r0, #1024	; 0x400
    8394:	eb0000b9 	bl	8680 <_Z5sleepjj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:63 (discriminator 1)
		blink(false);
    8398:	e3a00000 	mov	r0, #0
    839c:	ebffffa2 	bl	822c <_Z5blinkb>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:64 (discriminator 1)
		sleep(symbol_tick_delay);
    83a0:	e3e01001 	mvn	r1, #1
    83a4:	e3a00b01 	mov	r0, #1024	; 0x400
    83a8:	eb0000b4 	bl	8680 <_Z5sleepjj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:65 (discriminator 1)
		blink(false);
    83ac:	e3a00000 	mov	r0, #0
    83b0:	ebffff9d 	bl	822c <_Z5blinkb>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:66 (discriminator 1)
		sleep(symbol_tick_delay);
    83b4:	e3e01001 	mvn	r1, #1
    83b8:	e3a00b01 	mov	r0, #1024	; 0x400
    83bc:	eb0000af 	bl	8680 <_Z5sleepjj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:68 (discriminator 1)

		sleep(char_tick_delay);
    83c0:	e3e01001 	mvn	r1, #1
    83c4:	e3a00a01 	mov	r0, #4096	; 0x1000
    83c8:	eb0000ac 	bl	8680 <_Z5sleepjj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:70 (discriminator 1)

		blink(true);
    83cc:	e3a00001 	mov	r0, #1
    83d0:	ebffff95 	bl	822c <_Z5blinkb>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:71 (discriminator 1)
		sleep(symbol_tick_delay);
    83d4:	e3e01001 	mvn	r1, #1
    83d8:	e3a00b01 	mov	r0, #1024	; 0x400
    83dc:	eb0000a7 	bl	8680 <_Z5sleepjj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:72 (discriminator 1)
		blink(true);
    83e0:	e3a00001 	mov	r0, #1
    83e4:	ebffff90 	bl	822c <_Z5blinkb>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:73 (discriminator 1)
		sleep(symbol_tick_delay);
    83e8:	e3e01001 	mvn	r1, #1
    83ec:	e3a00b01 	mov	r0, #1024	; 0x400
    83f0:	eb0000a2 	bl	8680 <_Z5sleepjj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:74 (discriminator 1)
		blink(true);
    83f4:	e3a00001 	mov	r0, #1
    83f8:	ebffff8b 	bl	822c <_Z5blinkb>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:42 (discriminator 1)
		wait(button, 1, 0x300);
    83fc:	eaffffc7 	b	8320 <main+0x74>
    8400:	00008fa8 	andeq	r8, r0, r8, lsr #31
    8404:	00009018 	andeq	r9, r0, r8, lsl r0
    8408:	00008fb4 			; <UNDEFINED> instruction: 0x00008fb4
    840c:	0000901c 	andeq	r9, r0, ip, lsl r0
    8410:	00008fc0 	andeq	r8, r0, r0, asr #31
    8414:	00008fc4 	andeq	r8, r0, r4, asr #31

00008418 <_Z6getpidv>:
_Z6getpidv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:5
#include <stdfile.h>
#include <stdstring.h>

uint32_t getpid()
{
    8418:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    841c:	e28db000 	add	fp, sp, #0
    8420:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:8
    uint32_t pid;

    asm volatile("swi 0");
    8424:	ef000000 	svc	0x00000000
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:9
    asm volatile("mov %0, r0" : "=r" (pid));
    8428:	e1a03000 	mov	r3, r0
    842c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:11

    return pid;
    8430:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:12
}
    8434:	e1a00003 	mov	r0, r3
    8438:	e28bd000 	add	sp, fp, #0
    843c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8440:	e12fff1e 	bx	lr

00008444 <_Z9terminatei>:
_Z9terminatei():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:15

void terminate(int exitcode)
{
    8444:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8448:	e28db000 	add	fp, sp, #0
    844c:	e24dd00c 	sub	sp, sp, #12
    8450:	e50b0008 	str	r0, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:16
    asm volatile("mov r0, %0" : : "r" (exitcode));
    8454:	e51b3008 	ldr	r3, [fp, #-8]
    8458:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:17
    asm volatile("swi 1");
    845c:	ef000001 	svc	0x00000001
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:18
}
    8460:	e320f000 	nop	{0}
    8464:	e28bd000 	add	sp, fp, #0
    8468:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    846c:	e12fff1e 	bx	lr

00008470 <_Z11sched_yieldv>:
_Z11sched_yieldv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:21

void sched_yield()
{
    8470:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8474:	e28db000 	add	fp, sp, #0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:22
    asm volatile("swi 2");
    8478:	ef000002 	svc	0x00000002
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:23
}
    847c:	e320f000 	nop	{0}
    8480:	e28bd000 	add	sp, fp, #0
    8484:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8488:	e12fff1e 	bx	lr

0000848c <_Z4openPKc15NFile_Open_Mode>:
_Z4openPKc15NFile_Open_Mode():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:26

uint32_t open(const char* filename, NFile_Open_Mode mode)
{
    848c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8490:	e28db000 	add	fp, sp, #0
    8494:	e24dd014 	sub	sp, sp, #20
    8498:	e50b0010 	str	r0, [fp, #-16]
    849c:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:29
    uint32_t file;

    asm volatile("mov r0, %0" : : "r" (filename));
    84a0:	e51b3010 	ldr	r3, [fp, #-16]
    84a4:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:30
    asm volatile("mov r1, %0" : : "r" (mode));
    84a8:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    84ac:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:31
    asm volatile("swi 64");
    84b0:	ef000040 	svc	0x00000040
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:32
    asm volatile("mov %0, r0" : "=r" (file));
    84b4:	e1a03000 	mov	r3, r0
    84b8:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:34

    return file;
    84bc:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:35
}
    84c0:	e1a00003 	mov	r0, r3
    84c4:	e28bd000 	add	sp, fp, #0
    84c8:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    84cc:	e12fff1e 	bx	lr

000084d0 <_Z4readjPcj>:
_Z4readjPcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:38

uint32_t read(uint32_t file, char* const buffer, uint32_t size)
{
    84d0:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    84d4:	e28db000 	add	fp, sp, #0
    84d8:	e24dd01c 	sub	sp, sp, #28
    84dc:	e50b0010 	str	r0, [fp, #-16]
    84e0:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    84e4:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:41
    uint32_t rdnum;

    asm volatile("mov r0, %0" : : "r" (file));
    84e8:	e51b3010 	ldr	r3, [fp, #-16]
    84ec:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:42
    asm volatile("mov r1, %0" : : "r" (buffer));
    84f0:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    84f4:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:43
    asm volatile("mov r2, %0" : : "r" (size));
    84f8:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    84fc:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:44
    asm volatile("swi 65");
    8500:	ef000041 	svc	0x00000041
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:45
    asm volatile("mov %0, r0" : "=r" (rdnum));
    8504:	e1a03000 	mov	r3, r0
    8508:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:47

    return rdnum;
    850c:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:48
}
    8510:	e1a00003 	mov	r0, r3
    8514:	e28bd000 	add	sp, fp, #0
    8518:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    851c:	e12fff1e 	bx	lr

00008520 <_Z5writejPKcj>:
_Z5writejPKcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:51

uint32_t write(uint32_t file, const char* buffer, uint32_t size)
{
    8520:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8524:	e28db000 	add	fp, sp, #0
    8528:	e24dd01c 	sub	sp, sp, #28
    852c:	e50b0010 	str	r0, [fp, #-16]
    8530:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8534:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:54
    uint32_t wrnum;

    asm volatile("mov r0, %0" : : "r" (file));
    8538:	e51b3010 	ldr	r3, [fp, #-16]
    853c:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:55
    asm volatile("mov r1, %0" : : "r" (buffer));
    8540:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8544:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:56
    asm volatile("mov r2, %0" : : "r" (size));
    8548:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    854c:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:57
    asm volatile("swi 66");
    8550:	ef000042 	svc	0x00000042
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:58
    asm volatile("mov %0, r0" : "=r" (wrnum));
    8554:	e1a03000 	mov	r3, r0
    8558:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:60

    return wrnum;
    855c:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:61
}
    8560:	e1a00003 	mov	r0, r3
    8564:	e28bd000 	add	sp, fp, #0
    8568:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    856c:	e12fff1e 	bx	lr

00008570 <_Z5closej>:
_Z5closej():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:64

void close(uint32_t file)
{
    8570:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8574:	e28db000 	add	fp, sp, #0
    8578:	e24dd00c 	sub	sp, sp, #12
    857c:	e50b0008 	str	r0, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:65
    asm volatile("mov r0, %0" : : "r" (file));
    8580:	e51b3008 	ldr	r3, [fp, #-8]
    8584:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:66
    asm volatile("swi 67");
    8588:	ef000043 	svc	0x00000043
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:67
}
    858c:	e320f000 	nop	{0}
    8590:	e28bd000 	add	sp, fp, #0
    8594:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8598:	e12fff1e 	bx	lr

0000859c <_Z5ioctlj16NIOCtl_OperationPv>:
_Z5ioctlj16NIOCtl_OperationPv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:70

uint32_t ioctl(uint32_t file, NIOCtl_Operation operation, void* param)
{
    859c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    85a0:	e28db000 	add	fp, sp, #0
    85a4:	e24dd01c 	sub	sp, sp, #28
    85a8:	e50b0010 	str	r0, [fp, #-16]
    85ac:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    85b0:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:73
    uint32_t retcode;

    asm volatile("mov r0, %0" : : "r" (file));
    85b4:	e51b3010 	ldr	r3, [fp, #-16]
    85b8:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:74
    asm volatile("mov r1, %0" : : "r" (operation));
    85bc:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    85c0:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:75
    asm volatile("mov r2, %0" : : "r" (param));
    85c4:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    85c8:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:76
    asm volatile("swi 68");
    85cc:	ef000044 	svc	0x00000044
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:77
    asm volatile("mov %0, r0" : "=r" (retcode));
    85d0:	e1a03000 	mov	r3, r0
    85d4:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:79

    return retcode;
    85d8:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:80
}
    85dc:	e1a00003 	mov	r0, r3
    85e0:	e28bd000 	add	sp, fp, #0
    85e4:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    85e8:	e12fff1e 	bx	lr

000085ec <_Z6notifyjj>:
_Z6notifyjj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:83

uint32_t notify(uint32_t file, uint32_t count)
{
    85ec:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    85f0:	e28db000 	add	fp, sp, #0
    85f4:	e24dd014 	sub	sp, sp, #20
    85f8:	e50b0010 	str	r0, [fp, #-16]
    85fc:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:86
    uint32_t retcnt;

    asm volatile("mov r0, %0" : : "r" (file));
    8600:	e51b3010 	ldr	r3, [fp, #-16]
    8604:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:87
    asm volatile("mov r1, %0" : : "r" (count));
    8608:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    860c:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:88
    asm volatile("swi 69");
    8610:	ef000045 	svc	0x00000045
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:89
    asm volatile("mov %0, r0" : "=r" (retcnt));
    8614:	e1a03000 	mov	r3, r0
    8618:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:91

    return retcnt;
    861c:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:92
}
    8620:	e1a00003 	mov	r0, r3
    8624:	e28bd000 	add	sp, fp, #0
    8628:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    862c:	e12fff1e 	bx	lr

00008630 <_Z4waitjjj>:
_Z4waitjjj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:95

NSWI_Result_Code wait(uint32_t file, uint32_t count, uint32_t notified_deadline)
{
    8630:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8634:	e28db000 	add	fp, sp, #0
    8638:	e24dd01c 	sub	sp, sp, #28
    863c:	e50b0010 	str	r0, [fp, #-16]
    8640:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8644:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:98
    NSWI_Result_Code retcode;

    asm volatile("mov r0, %0" : : "r" (file));
    8648:	e51b3010 	ldr	r3, [fp, #-16]
    864c:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:99
    asm volatile("mov r1, %0" : : "r" (count));
    8650:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8654:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:100
    asm volatile("mov r2, %0" : : "r" (notified_deadline));
    8658:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    865c:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:101
    asm volatile("swi 70");
    8660:	ef000046 	svc	0x00000046
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:102
    asm volatile("mov %0, r0" : "=r" (retcode));
    8664:	e1a03000 	mov	r3, r0
    8668:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:104

    return retcode;
    866c:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:105
}
    8670:	e1a00003 	mov	r0, r3
    8674:	e28bd000 	add	sp, fp, #0
    8678:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    867c:	e12fff1e 	bx	lr

00008680 <_Z5sleepjj>:
_Z5sleepjj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:108

bool sleep(uint32_t ticks, uint32_t notified_deadline)
{
    8680:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8684:	e28db000 	add	fp, sp, #0
    8688:	e24dd014 	sub	sp, sp, #20
    868c:	e50b0010 	str	r0, [fp, #-16]
    8690:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:111
    uint32_t retcode;

    asm volatile("mov r0, %0" : : "r" (ticks));
    8694:	e51b3010 	ldr	r3, [fp, #-16]
    8698:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:112
    asm volatile("mov r1, %0" : : "r" (notified_deadline));
    869c:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    86a0:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:113
    asm volatile("swi 3");
    86a4:	ef000003 	svc	0x00000003
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:114
    asm volatile("mov %0, r0" : "=r" (retcode));
    86a8:	e1a03000 	mov	r3, r0
    86ac:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:116

    return retcode;
    86b0:	e51b3008 	ldr	r3, [fp, #-8]
    86b4:	e3530000 	cmp	r3, #0
    86b8:	13a03001 	movne	r3, #1
    86bc:	03a03000 	moveq	r3, #0
    86c0:	e6ef3073 	uxtb	r3, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:117
}
    86c4:	e1a00003 	mov	r0, r3
    86c8:	e28bd000 	add	sp, fp, #0
    86cc:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    86d0:	e12fff1e 	bx	lr

000086d4 <_Z24get_active_process_countv>:
_Z24get_active_process_countv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:120

uint32_t get_active_process_count()
{
    86d4:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    86d8:	e28db000 	add	fp, sp, #0
    86dc:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:121
    const NGet_Sched_Info_Type req = NGet_Sched_Info_Type::Active_Process_Count;
    86e0:	e3a03000 	mov	r3, #0
    86e4:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:124
    uint32_t retval;

    asm volatile("mov r0, %0" : : "r" (req));
    86e8:	e3a03000 	mov	r3, #0
    86ec:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:125
    asm volatile("mov r1, %0" : : "r" (&retval));
    86f0:	e24b300c 	sub	r3, fp, #12
    86f4:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:126
    asm volatile("swi 4");
    86f8:	ef000004 	svc	0x00000004
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:128

    return retval;
    86fc:	e51b300c 	ldr	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:129
}
    8700:	e1a00003 	mov	r0, r3
    8704:	e28bd000 	add	sp, fp, #0
    8708:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    870c:	e12fff1e 	bx	lr

00008710 <_Z14get_tick_countv>:
_Z14get_tick_countv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:132

uint32_t get_tick_count()
{
    8710:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8714:	e28db000 	add	fp, sp, #0
    8718:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:133
    const NGet_Sched_Info_Type req = NGet_Sched_Info_Type::Tick_Count;
    871c:	e3a03001 	mov	r3, #1
    8720:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:136
    uint32_t retval;

    asm volatile("mov r0, %0" : : "r" (req));
    8724:	e3a03001 	mov	r3, #1
    8728:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:137
    asm volatile("mov r1, %0" : : "r" (&retval));
    872c:	e24b300c 	sub	r3, fp, #12
    8730:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:138
    asm volatile("swi 4");
    8734:	ef000004 	svc	0x00000004
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:140

    return retval;
    8738:	e51b300c 	ldr	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:141
}
    873c:	e1a00003 	mov	r0, r3
    8740:	e28bd000 	add	sp, fp, #0
    8744:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8748:	e12fff1e 	bx	lr

0000874c <_Z17set_task_deadlinej>:
_Z17set_task_deadlinej():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:144

void set_task_deadline(uint32_t tick_count_required)
{
    874c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8750:	e28db000 	add	fp, sp, #0
    8754:	e24dd014 	sub	sp, sp, #20
    8758:	e50b0010 	str	r0, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:145
    const NDeadline_Subservice req = NDeadline_Subservice::Set_Relative;
    875c:	e3a03000 	mov	r3, #0
    8760:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:147

    asm volatile("mov r0, %0" : : "r" (req));
    8764:	e3a03000 	mov	r3, #0
    8768:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:148
    asm volatile("mov r1, %0" : : "r" (&tick_count_required));
    876c:	e24b3010 	sub	r3, fp, #16
    8770:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:149
    asm volatile("swi 5");
    8774:	ef000005 	svc	0x00000005
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:150
}
    8778:	e320f000 	nop	{0}
    877c:	e28bd000 	add	sp, fp, #0
    8780:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8784:	e12fff1e 	bx	lr

00008788 <_Z26get_task_ticks_to_deadlinev>:
_Z26get_task_ticks_to_deadlinev():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:153

uint32_t get_task_ticks_to_deadline()
{
    8788:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    878c:	e28db000 	add	fp, sp, #0
    8790:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:154
    const NDeadline_Subservice req = NDeadline_Subservice::Get_Remaining;
    8794:	e3a03001 	mov	r3, #1
    8798:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:157
    uint32_t ticks;

    asm volatile("mov r0, %0" : : "r" (req));
    879c:	e3a03001 	mov	r3, #1
    87a0:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:158
    asm volatile("mov r1, %0" : : "r" (&ticks));
    87a4:	e24b300c 	sub	r3, fp, #12
    87a8:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:159
    asm volatile("swi 5");
    87ac:	ef000005 	svc	0x00000005
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:161

    return ticks;
    87b0:	e51b300c 	ldr	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:162
}
    87b4:	e1a00003 	mov	r0, r3
    87b8:	e28bd000 	add	sp, fp, #0
    87bc:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    87c0:	e12fff1e 	bx	lr

000087c4 <_Z4pipePKcj>:
_Z4pipePKcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:167

const char Pipe_File_Prefix[] = "SYS:pipe/";

uint32_t pipe(const char* name, uint32_t buf_size)
{
    87c4:	e92d4800 	push	{fp, lr}
    87c8:	e28db004 	add	fp, sp, #4
    87cc:	e24dd050 	sub	sp, sp, #80	; 0x50
    87d0:	e50b0050 	str	r0, [fp, #-80]	; 0xffffffb0
    87d4:	e50b1054 	str	r1, [fp, #-84]	; 0xffffffac
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:169
    char fname[64];
    strncpy(fname, Pipe_File_Prefix, sizeof(Pipe_File_Prefix));
    87d8:	e24b3048 	sub	r3, fp, #72	; 0x48
    87dc:	e3a0200a 	mov	r2, #10
    87e0:	e59f1088 	ldr	r1, [pc, #136]	; 8870 <_Z4pipePKcj+0xac>
    87e4:	e1a00003 	mov	r0, r3
    87e8:	eb0000a5 	bl	8a84 <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:170
    strncpy(fname + sizeof(Pipe_File_Prefix), name, sizeof(fname) - sizeof(Pipe_File_Prefix) - 1);
    87ec:	e24b3048 	sub	r3, fp, #72	; 0x48
    87f0:	e283300a 	add	r3, r3, #10
    87f4:	e3a02035 	mov	r2, #53	; 0x35
    87f8:	e51b1050 	ldr	r1, [fp, #-80]	; 0xffffffb0
    87fc:	e1a00003 	mov	r0, r3
    8800:	eb00009f 	bl	8a84 <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:172

    int ncur = sizeof(Pipe_File_Prefix) + strlen(name);
    8804:	e51b0050 	ldr	r0, [fp, #-80]	; 0xffffffb0
    8808:	eb0000f8 	bl	8bf0 <_Z6strlenPKc>
    880c:	e1a03000 	mov	r3, r0
    8810:	e283300a 	add	r3, r3, #10
    8814:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:174

    fname[ncur++] = '#';
    8818:	e51b3008 	ldr	r3, [fp, #-8]
    881c:	e2832001 	add	r2, r3, #1
    8820:	e50b2008 	str	r2, [fp, #-8]
    8824:	e2433004 	sub	r3, r3, #4
    8828:	e083300b 	add	r3, r3, fp
    882c:	e3a02023 	mov	r2, #35	; 0x23
    8830:	e5432044 	strb	r2, [r3, #-68]	; 0xffffffbc
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:176

    itoa(buf_size, &fname[ncur], 10);
    8834:	e24b2048 	sub	r2, fp, #72	; 0x48
    8838:	e51b3008 	ldr	r3, [fp, #-8]
    883c:	e0823003 	add	r3, r2, r3
    8840:	e3a0200a 	mov	r2, #10
    8844:	e1a01003 	mov	r1, r3
    8848:	e51b0054 	ldr	r0, [fp, #-84]	; 0xffffffac
    884c:	eb000008 	bl	8874 <_Z4itoajPcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:178

    return open(fname, NFile_Open_Mode::Read_Write);
    8850:	e24b3048 	sub	r3, fp, #72	; 0x48
    8854:	e3a01002 	mov	r1, #2
    8858:	e1a00003 	mov	r0, r3
    885c:	ebffff0a 	bl	848c <_Z4openPKc15NFile_Open_Mode>
    8860:	e1a03000 	mov	r3, r0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:179
}
    8864:	e1a00003 	mov	r0, r3
    8868:	e24bd004 	sub	sp, fp, #4
    886c:	e8bd8800 	pop	{fp, pc}
    8870:	00008ff8 	strdeq	r8, [r0], -r8	; <UNPREDICTABLE>

00008874 <_Z4itoajPcj>:
_Z4itoajPcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:9
{
    const char CharConvArr[] = "0123456789ABCDEF";
}

void itoa(unsigned int input, char* output, unsigned int base)
{
    8874:	e92d4800 	push	{fp, lr}
    8878:	e28db004 	add	fp, sp, #4
    887c:	e24dd020 	sub	sp, sp, #32
    8880:	e50b0018 	str	r0, [fp, #-24]	; 0xffffffe8
    8884:	e50b101c 	str	r1, [fp, #-28]	; 0xffffffe4
    8888:	e50b2020 	str	r2, [fp, #-32]	; 0xffffffe0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:10
	int i = 0;
    888c:	e3a03000 	mov	r3, #0
    8890:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:12

	while (input > 0)
    8894:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8898:	e3530000 	cmp	r3, #0
    889c:	0a000014 	beq	88f4 <_Z4itoajPcj+0x80>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:14
	{
		output[i] = CharConvArr[input % base];
    88a0:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    88a4:	e51b1020 	ldr	r1, [fp, #-32]	; 0xffffffe0
    88a8:	e1a00003 	mov	r0, r3
    88ac:	eb000199 	bl	8f18 <__aeabi_uidivmod>
    88b0:	e1a03001 	mov	r3, r1
    88b4:	e1a01003 	mov	r1, r3
    88b8:	e51b3008 	ldr	r3, [fp, #-8]
    88bc:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    88c0:	e0823003 	add	r3, r2, r3
    88c4:	e59f2118 	ldr	r2, [pc, #280]	; 89e4 <_Z4itoajPcj+0x170>
    88c8:	e7d22001 	ldrb	r2, [r2, r1]
    88cc:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:15
		input /= base;
    88d0:	e51b1020 	ldr	r1, [fp, #-32]	; 0xffffffe0
    88d4:	e51b0018 	ldr	r0, [fp, #-24]	; 0xffffffe8
    88d8:	eb000113 	bl	8d2c <__udivsi3>
    88dc:	e1a03000 	mov	r3, r0
    88e0:	e50b3018 	str	r3, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:16
		i++;
    88e4:	e51b3008 	ldr	r3, [fp, #-8]
    88e8:	e2833001 	add	r3, r3, #1
    88ec:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:12
	while (input > 0)
    88f0:	eaffffe7 	b	8894 <_Z4itoajPcj+0x20>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:19
	}

    if (i == 0)
    88f4:	e51b3008 	ldr	r3, [fp, #-8]
    88f8:	e3530000 	cmp	r3, #0
    88fc:	1a000007 	bne	8920 <_Z4itoajPcj+0xac>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:21
    {
        output[i] = CharConvArr[0];
    8900:	e51b3008 	ldr	r3, [fp, #-8]
    8904:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    8908:	e0823003 	add	r3, r2, r3
    890c:	e3a02030 	mov	r2, #48	; 0x30
    8910:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:22
        i++;
    8914:	e51b3008 	ldr	r3, [fp, #-8]
    8918:	e2833001 	add	r3, r3, #1
    891c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:25
    }

	output[i] = '\0';
    8920:	e51b3008 	ldr	r3, [fp, #-8]
    8924:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    8928:	e0823003 	add	r3, r2, r3
    892c:	e3a02000 	mov	r2, #0
    8930:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:26
	i--;
    8934:	e51b3008 	ldr	r3, [fp, #-8]
    8938:	e2433001 	sub	r3, r3, #1
    893c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:28

	for (int j = 0; j <= i/2; j++)
    8940:	e3a03000 	mov	r3, #0
    8944:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:28 (discriminator 3)
    8948:	e51b3008 	ldr	r3, [fp, #-8]
    894c:	e1a02fa3 	lsr	r2, r3, #31
    8950:	e0823003 	add	r3, r2, r3
    8954:	e1a030c3 	asr	r3, r3, #1
    8958:	e1a02003 	mov	r2, r3
    895c:	e51b300c 	ldr	r3, [fp, #-12]
    8960:	e1530002 	cmp	r3, r2
    8964:	ca00001b 	bgt	89d8 <_Z4itoajPcj+0x164>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:30 (discriminator 2)
	{
		char c = output[i - j];
    8968:	e51b2008 	ldr	r2, [fp, #-8]
    896c:	e51b300c 	ldr	r3, [fp, #-12]
    8970:	e0423003 	sub	r3, r2, r3
    8974:	e1a02003 	mov	r2, r3
    8978:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    897c:	e0833002 	add	r3, r3, r2
    8980:	e5d33000 	ldrb	r3, [r3]
    8984:	e54b300d 	strb	r3, [fp, #-13]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:31 (discriminator 2)
		output[i - j] = output[j];
    8988:	e51b300c 	ldr	r3, [fp, #-12]
    898c:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    8990:	e0822003 	add	r2, r2, r3
    8994:	e51b1008 	ldr	r1, [fp, #-8]
    8998:	e51b300c 	ldr	r3, [fp, #-12]
    899c:	e0413003 	sub	r3, r1, r3
    89a0:	e1a01003 	mov	r1, r3
    89a4:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    89a8:	e0833001 	add	r3, r3, r1
    89ac:	e5d22000 	ldrb	r2, [r2]
    89b0:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:32 (discriminator 2)
		output[j] = c;
    89b4:	e51b300c 	ldr	r3, [fp, #-12]
    89b8:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    89bc:	e0823003 	add	r3, r2, r3
    89c0:	e55b200d 	ldrb	r2, [fp, #-13]
    89c4:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:28 (discriminator 2)
	for (int j = 0; j <= i/2; j++)
    89c8:	e51b300c 	ldr	r3, [fp, #-12]
    89cc:	e2833001 	add	r3, r3, #1
    89d0:	e50b300c 	str	r3, [fp, #-12]
    89d4:	eaffffdb 	b	8948 <_Z4itoajPcj+0xd4>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:34
	}
}
    89d8:	e320f000 	nop	{0}
    89dc:	e24bd004 	sub	sp, fp, #4
    89e0:	e8bd8800 	pop	{fp, pc}
    89e4:	00009004 	andeq	r9, r0, r4

000089e8 <_Z4atoiPKc>:
_Z4atoiPKc():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:37

int atoi(const char* input)
{
    89e8:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    89ec:	e28db000 	add	fp, sp, #0
    89f0:	e24dd014 	sub	sp, sp, #20
    89f4:	e50b0010 	str	r0, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:38
	int output = 0;
    89f8:	e3a03000 	mov	r3, #0
    89fc:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:40

	while (*input != '\0')
    8a00:	e51b3010 	ldr	r3, [fp, #-16]
    8a04:	e5d33000 	ldrb	r3, [r3]
    8a08:	e3530000 	cmp	r3, #0
    8a0c:	0a000017 	beq	8a70 <_Z4atoiPKc+0x88>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:42
	{
		output *= 10;
    8a10:	e51b2008 	ldr	r2, [fp, #-8]
    8a14:	e1a03002 	mov	r3, r2
    8a18:	e1a03103 	lsl	r3, r3, #2
    8a1c:	e0833002 	add	r3, r3, r2
    8a20:	e1a03083 	lsl	r3, r3, #1
    8a24:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:43
		if (*input > '9' || *input < '0')
    8a28:	e51b3010 	ldr	r3, [fp, #-16]
    8a2c:	e5d33000 	ldrb	r3, [r3]
    8a30:	e3530039 	cmp	r3, #57	; 0x39
    8a34:	8a00000d 	bhi	8a70 <_Z4atoiPKc+0x88>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:43 (discriminator 1)
    8a38:	e51b3010 	ldr	r3, [fp, #-16]
    8a3c:	e5d33000 	ldrb	r3, [r3]
    8a40:	e353002f 	cmp	r3, #47	; 0x2f
    8a44:	9a000009 	bls	8a70 <_Z4atoiPKc+0x88>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:46
			break;

		output += *input - '0';
    8a48:	e51b3010 	ldr	r3, [fp, #-16]
    8a4c:	e5d33000 	ldrb	r3, [r3]
    8a50:	e2433030 	sub	r3, r3, #48	; 0x30
    8a54:	e51b2008 	ldr	r2, [fp, #-8]
    8a58:	e0823003 	add	r3, r2, r3
    8a5c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:48

		input++;
    8a60:	e51b3010 	ldr	r3, [fp, #-16]
    8a64:	e2833001 	add	r3, r3, #1
    8a68:	e50b3010 	str	r3, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:40
	while (*input != '\0')
    8a6c:	eaffffe3 	b	8a00 <_Z4atoiPKc+0x18>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:51
	}

	return output;
    8a70:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:52
}
    8a74:	e1a00003 	mov	r0, r3
    8a78:	e28bd000 	add	sp, fp, #0
    8a7c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8a80:	e12fff1e 	bx	lr

00008a84 <_Z7strncpyPcPKci>:
_Z7strncpyPcPKci():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:55

char* strncpy(char* dest, const char *src, int num)
{
    8a84:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8a88:	e28db000 	add	fp, sp, #0
    8a8c:	e24dd01c 	sub	sp, sp, #28
    8a90:	e50b0010 	str	r0, [fp, #-16]
    8a94:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8a98:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:58
	int i;

	for (i = 0; i < num && src[i] != '\0'; i++)
    8a9c:	e3a03000 	mov	r3, #0
    8aa0:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:58 (discriminator 4)
    8aa4:	e51b2008 	ldr	r2, [fp, #-8]
    8aa8:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8aac:	e1520003 	cmp	r2, r3
    8ab0:	aa000011 	bge	8afc <_Z7strncpyPcPKci+0x78>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:58 (discriminator 2)
    8ab4:	e51b3008 	ldr	r3, [fp, #-8]
    8ab8:	e51b2014 	ldr	r2, [fp, #-20]	; 0xffffffec
    8abc:	e0823003 	add	r3, r2, r3
    8ac0:	e5d33000 	ldrb	r3, [r3]
    8ac4:	e3530000 	cmp	r3, #0
    8ac8:	0a00000b 	beq	8afc <_Z7strncpyPcPKci+0x78>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:59 (discriminator 3)
		dest[i] = src[i];
    8acc:	e51b3008 	ldr	r3, [fp, #-8]
    8ad0:	e51b2014 	ldr	r2, [fp, #-20]	; 0xffffffec
    8ad4:	e0822003 	add	r2, r2, r3
    8ad8:	e51b3008 	ldr	r3, [fp, #-8]
    8adc:	e51b1010 	ldr	r1, [fp, #-16]
    8ae0:	e0813003 	add	r3, r1, r3
    8ae4:	e5d22000 	ldrb	r2, [r2]
    8ae8:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:58 (discriminator 3)
	for (i = 0; i < num && src[i] != '\0'; i++)
    8aec:	e51b3008 	ldr	r3, [fp, #-8]
    8af0:	e2833001 	add	r3, r3, #1
    8af4:	e50b3008 	str	r3, [fp, #-8]
    8af8:	eaffffe9 	b	8aa4 <_Z7strncpyPcPKci+0x20>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:60 (discriminator 2)
	for (; i < num; i++)
    8afc:	e51b2008 	ldr	r2, [fp, #-8]
    8b00:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8b04:	e1520003 	cmp	r2, r3
    8b08:	aa000008 	bge	8b30 <_Z7strncpyPcPKci+0xac>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:61 (discriminator 1)
		dest[i] = '\0';
    8b0c:	e51b3008 	ldr	r3, [fp, #-8]
    8b10:	e51b2010 	ldr	r2, [fp, #-16]
    8b14:	e0823003 	add	r3, r2, r3
    8b18:	e3a02000 	mov	r2, #0
    8b1c:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:60 (discriminator 1)
	for (; i < num; i++)
    8b20:	e51b3008 	ldr	r3, [fp, #-8]
    8b24:	e2833001 	add	r3, r3, #1
    8b28:	e50b3008 	str	r3, [fp, #-8]
    8b2c:	eafffff2 	b	8afc <_Z7strncpyPcPKci+0x78>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:63

   return dest;
    8b30:	e51b3010 	ldr	r3, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:64
}
    8b34:	e1a00003 	mov	r0, r3
    8b38:	e28bd000 	add	sp, fp, #0
    8b3c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8b40:	e12fff1e 	bx	lr

00008b44 <_Z7strncmpPKcS0_i>:
_Z7strncmpPKcS0_i():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:67

int strncmp(const char *s1, const char *s2, int num)
{
    8b44:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8b48:	e28db000 	add	fp, sp, #0
    8b4c:	e24dd01c 	sub	sp, sp, #28
    8b50:	e50b0010 	str	r0, [fp, #-16]
    8b54:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8b58:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:69
	unsigned char u1, u2;
  	while (num-- > 0)
    8b5c:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8b60:	e2432001 	sub	r2, r3, #1
    8b64:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
    8b68:	e3530000 	cmp	r3, #0
    8b6c:	c3a03001 	movgt	r3, #1
    8b70:	d3a03000 	movle	r3, #0
    8b74:	e6ef3073 	uxtb	r3, r3
    8b78:	e3530000 	cmp	r3, #0
    8b7c:	0a000016 	beq	8bdc <_Z7strncmpPKcS0_i+0x98>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:71
    {
      	u1 = (unsigned char) *s1++;
    8b80:	e51b3010 	ldr	r3, [fp, #-16]
    8b84:	e2832001 	add	r2, r3, #1
    8b88:	e50b2010 	str	r2, [fp, #-16]
    8b8c:	e5d33000 	ldrb	r3, [r3]
    8b90:	e54b3005 	strb	r3, [fp, #-5]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:72
     	u2 = (unsigned char) *s2++;
    8b94:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8b98:	e2832001 	add	r2, r3, #1
    8b9c:	e50b2014 	str	r2, [fp, #-20]	; 0xffffffec
    8ba0:	e5d33000 	ldrb	r3, [r3]
    8ba4:	e54b3006 	strb	r3, [fp, #-6]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:73
      	if (u1 != u2)
    8ba8:	e55b2005 	ldrb	r2, [fp, #-5]
    8bac:	e55b3006 	ldrb	r3, [fp, #-6]
    8bb0:	e1520003 	cmp	r2, r3
    8bb4:	0a000003 	beq	8bc8 <_Z7strncmpPKcS0_i+0x84>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:74
        	return u1 - u2;
    8bb8:	e55b2005 	ldrb	r2, [fp, #-5]
    8bbc:	e55b3006 	ldrb	r3, [fp, #-6]
    8bc0:	e0423003 	sub	r3, r2, r3
    8bc4:	ea000005 	b	8be0 <_Z7strncmpPKcS0_i+0x9c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:75
      	if (u1 == '\0')
    8bc8:	e55b3005 	ldrb	r3, [fp, #-5]
    8bcc:	e3530000 	cmp	r3, #0
    8bd0:	1affffe1 	bne	8b5c <_Z7strncmpPKcS0_i+0x18>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:76
        	return 0;
    8bd4:	e3a03000 	mov	r3, #0
    8bd8:	ea000000 	b	8be0 <_Z7strncmpPKcS0_i+0x9c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:79
    }

  	return 0;
    8bdc:	e3a03000 	mov	r3, #0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:80
}
    8be0:	e1a00003 	mov	r0, r3
    8be4:	e28bd000 	add	sp, fp, #0
    8be8:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8bec:	e12fff1e 	bx	lr

00008bf0 <_Z6strlenPKc>:
_Z6strlenPKc():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:83

int strlen(const char* s)
{
    8bf0:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8bf4:	e28db000 	add	fp, sp, #0
    8bf8:	e24dd014 	sub	sp, sp, #20
    8bfc:	e50b0010 	str	r0, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:84
	int i = 0;
    8c00:	e3a03000 	mov	r3, #0
    8c04:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:86

	while (s[i] != '\0')
    8c08:	e51b3008 	ldr	r3, [fp, #-8]
    8c0c:	e51b2010 	ldr	r2, [fp, #-16]
    8c10:	e0823003 	add	r3, r2, r3
    8c14:	e5d33000 	ldrb	r3, [r3]
    8c18:	e3530000 	cmp	r3, #0
    8c1c:	0a000003 	beq	8c30 <_Z6strlenPKc+0x40>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:87
		i++;
    8c20:	e51b3008 	ldr	r3, [fp, #-8]
    8c24:	e2833001 	add	r3, r3, #1
    8c28:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:86
	while (s[i] != '\0')
    8c2c:	eafffff5 	b	8c08 <_Z6strlenPKc+0x18>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:89

	return i;
    8c30:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:90
}
    8c34:	e1a00003 	mov	r0, r3
    8c38:	e28bd000 	add	sp, fp, #0
    8c3c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8c40:	e12fff1e 	bx	lr

00008c44 <_Z5bzeroPvi>:
_Z5bzeroPvi():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:93

void bzero(void* memory, int length)
{
    8c44:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8c48:	e28db000 	add	fp, sp, #0
    8c4c:	e24dd014 	sub	sp, sp, #20
    8c50:	e50b0010 	str	r0, [fp, #-16]
    8c54:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:94
	char* mem = reinterpret_cast<char*>(memory);
    8c58:	e51b3010 	ldr	r3, [fp, #-16]
    8c5c:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:96

	for (int i = 0; i < length; i++)
    8c60:	e3a03000 	mov	r3, #0
    8c64:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:96 (discriminator 3)
    8c68:	e51b2008 	ldr	r2, [fp, #-8]
    8c6c:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8c70:	e1520003 	cmp	r2, r3
    8c74:	aa000008 	bge	8c9c <_Z5bzeroPvi+0x58>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:97 (discriminator 2)
		mem[i] = 0;
    8c78:	e51b3008 	ldr	r3, [fp, #-8]
    8c7c:	e51b200c 	ldr	r2, [fp, #-12]
    8c80:	e0823003 	add	r3, r2, r3
    8c84:	e3a02000 	mov	r2, #0
    8c88:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:96 (discriminator 2)
	for (int i = 0; i < length; i++)
    8c8c:	e51b3008 	ldr	r3, [fp, #-8]
    8c90:	e2833001 	add	r3, r3, #1
    8c94:	e50b3008 	str	r3, [fp, #-8]
    8c98:	eafffff2 	b	8c68 <_Z5bzeroPvi+0x24>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:98
}
    8c9c:	e320f000 	nop	{0}
    8ca0:	e28bd000 	add	sp, fp, #0
    8ca4:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8ca8:	e12fff1e 	bx	lr

00008cac <_Z6memcpyPKvPvi>:
_Z6memcpyPKvPvi():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:101

void memcpy(const void* src, void* dst, int num)
{
    8cac:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8cb0:	e28db000 	add	fp, sp, #0
    8cb4:	e24dd024 	sub	sp, sp, #36	; 0x24
    8cb8:	e50b0018 	str	r0, [fp, #-24]	; 0xffffffe8
    8cbc:	e50b101c 	str	r1, [fp, #-28]	; 0xffffffe4
    8cc0:	e50b2020 	str	r2, [fp, #-32]	; 0xffffffe0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:102
	const char* memsrc = reinterpret_cast<const char*>(src);
    8cc4:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8cc8:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:103
	char* memdst = reinterpret_cast<char*>(dst);
    8ccc:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    8cd0:	e50b3010 	str	r3, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:105

	for (int i = 0; i < num; i++)
    8cd4:	e3a03000 	mov	r3, #0
    8cd8:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:105 (discriminator 3)
    8cdc:	e51b2008 	ldr	r2, [fp, #-8]
    8ce0:	e51b3020 	ldr	r3, [fp, #-32]	; 0xffffffe0
    8ce4:	e1520003 	cmp	r2, r3
    8ce8:	aa00000b 	bge	8d1c <_Z6memcpyPKvPvi+0x70>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:106 (discriminator 2)
		memdst[i] = memsrc[i];
    8cec:	e51b3008 	ldr	r3, [fp, #-8]
    8cf0:	e51b200c 	ldr	r2, [fp, #-12]
    8cf4:	e0822003 	add	r2, r2, r3
    8cf8:	e51b3008 	ldr	r3, [fp, #-8]
    8cfc:	e51b1010 	ldr	r1, [fp, #-16]
    8d00:	e0813003 	add	r3, r1, r3
    8d04:	e5d22000 	ldrb	r2, [r2]
    8d08:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:105 (discriminator 2)
	for (int i = 0; i < num; i++)
    8d0c:	e51b3008 	ldr	r3, [fp, #-8]
    8d10:	e2833001 	add	r3, r3, #1
    8d14:	e50b3008 	str	r3, [fp, #-8]
    8d18:	eaffffef 	b	8cdc <_Z6memcpyPKvPvi+0x30>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:107
}
    8d1c:	e320f000 	nop	{0}
    8d20:	e28bd000 	add	sp, fp, #0
    8d24:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8d28:	e12fff1e 	bx	lr

00008d2c <__udivsi3>:
__udivsi3():
    8d2c:	e2512001 	subs	r2, r1, #1
    8d30:	012fff1e 	bxeq	lr
    8d34:	3a000074 	bcc	8f0c <__udivsi3+0x1e0>
    8d38:	e1500001 	cmp	r0, r1
    8d3c:	9a00006b 	bls	8ef0 <__udivsi3+0x1c4>
    8d40:	e1110002 	tst	r1, r2
    8d44:	0a00006c 	beq	8efc <__udivsi3+0x1d0>
    8d48:	e16f3f10 	clz	r3, r0
    8d4c:	e16f2f11 	clz	r2, r1
    8d50:	e0423003 	sub	r3, r2, r3
    8d54:	e273301f 	rsbs	r3, r3, #31
    8d58:	10833083 	addne	r3, r3, r3, lsl #1
    8d5c:	e3a02000 	mov	r2, #0
    8d60:	108ff103 	addne	pc, pc, r3, lsl #2
    8d64:	e1a00000 	nop			; (mov r0, r0)
    8d68:	e1500f81 	cmp	r0, r1, lsl #31
    8d6c:	e0a22002 	adc	r2, r2, r2
    8d70:	20400f81 	subcs	r0, r0, r1, lsl #31
    8d74:	e1500f01 	cmp	r0, r1, lsl #30
    8d78:	e0a22002 	adc	r2, r2, r2
    8d7c:	20400f01 	subcs	r0, r0, r1, lsl #30
    8d80:	e1500e81 	cmp	r0, r1, lsl #29
    8d84:	e0a22002 	adc	r2, r2, r2
    8d88:	20400e81 	subcs	r0, r0, r1, lsl #29
    8d8c:	e1500e01 	cmp	r0, r1, lsl #28
    8d90:	e0a22002 	adc	r2, r2, r2
    8d94:	20400e01 	subcs	r0, r0, r1, lsl #28
    8d98:	e1500d81 	cmp	r0, r1, lsl #27
    8d9c:	e0a22002 	adc	r2, r2, r2
    8da0:	20400d81 	subcs	r0, r0, r1, lsl #27
    8da4:	e1500d01 	cmp	r0, r1, lsl #26
    8da8:	e0a22002 	adc	r2, r2, r2
    8dac:	20400d01 	subcs	r0, r0, r1, lsl #26
    8db0:	e1500c81 	cmp	r0, r1, lsl #25
    8db4:	e0a22002 	adc	r2, r2, r2
    8db8:	20400c81 	subcs	r0, r0, r1, lsl #25
    8dbc:	e1500c01 	cmp	r0, r1, lsl #24
    8dc0:	e0a22002 	adc	r2, r2, r2
    8dc4:	20400c01 	subcs	r0, r0, r1, lsl #24
    8dc8:	e1500b81 	cmp	r0, r1, lsl #23
    8dcc:	e0a22002 	adc	r2, r2, r2
    8dd0:	20400b81 	subcs	r0, r0, r1, lsl #23
    8dd4:	e1500b01 	cmp	r0, r1, lsl #22
    8dd8:	e0a22002 	adc	r2, r2, r2
    8ddc:	20400b01 	subcs	r0, r0, r1, lsl #22
    8de0:	e1500a81 	cmp	r0, r1, lsl #21
    8de4:	e0a22002 	adc	r2, r2, r2
    8de8:	20400a81 	subcs	r0, r0, r1, lsl #21
    8dec:	e1500a01 	cmp	r0, r1, lsl #20
    8df0:	e0a22002 	adc	r2, r2, r2
    8df4:	20400a01 	subcs	r0, r0, r1, lsl #20
    8df8:	e1500981 	cmp	r0, r1, lsl #19
    8dfc:	e0a22002 	adc	r2, r2, r2
    8e00:	20400981 	subcs	r0, r0, r1, lsl #19
    8e04:	e1500901 	cmp	r0, r1, lsl #18
    8e08:	e0a22002 	adc	r2, r2, r2
    8e0c:	20400901 	subcs	r0, r0, r1, lsl #18
    8e10:	e1500881 	cmp	r0, r1, lsl #17
    8e14:	e0a22002 	adc	r2, r2, r2
    8e18:	20400881 	subcs	r0, r0, r1, lsl #17
    8e1c:	e1500801 	cmp	r0, r1, lsl #16
    8e20:	e0a22002 	adc	r2, r2, r2
    8e24:	20400801 	subcs	r0, r0, r1, lsl #16
    8e28:	e1500781 	cmp	r0, r1, lsl #15
    8e2c:	e0a22002 	adc	r2, r2, r2
    8e30:	20400781 	subcs	r0, r0, r1, lsl #15
    8e34:	e1500701 	cmp	r0, r1, lsl #14
    8e38:	e0a22002 	adc	r2, r2, r2
    8e3c:	20400701 	subcs	r0, r0, r1, lsl #14
    8e40:	e1500681 	cmp	r0, r1, lsl #13
    8e44:	e0a22002 	adc	r2, r2, r2
    8e48:	20400681 	subcs	r0, r0, r1, lsl #13
    8e4c:	e1500601 	cmp	r0, r1, lsl #12
    8e50:	e0a22002 	adc	r2, r2, r2
    8e54:	20400601 	subcs	r0, r0, r1, lsl #12
    8e58:	e1500581 	cmp	r0, r1, lsl #11
    8e5c:	e0a22002 	adc	r2, r2, r2
    8e60:	20400581 	subcs	r0, r0, r1, lsl #11
    8e64:	e1500501 	cmp	r0, r1, lsl #10
    8e68:	e0a22002 	adc	r2, r2, r2
    8e6c:	20400501 	subcs	r0, r0, r1, lsl #10
    8e70:	e1500481 	cmp	r0, r1, lsl #9
    8e74:	e0a22002 	adc	r2, r2, r2
    8e78:	20400481 	subcs	r0, r0, r1, lsl #9
    8e7c:	e1500401 	cmp	r0, r1, lsl #8
    8e80:	e0a22002 	adc	r2, r2, r2
    8e84:	20400401 	subcs	r0, r0, r1, lsl #8
    8e88:	e1500381 	cmp	r0, r1, lsl #7
    8e8c:	e0a22002 	adc	r2, r2, r2
    8e90:	20400381 	subcs	r0, r0, r1, lsl #7
    8e94:	e1500301 	cmp	r0, r1, lsl #6
    8e98:	e0a22002 	adc	r2, r2, r2
    8e9c:	20400301 	subcs	r0, r0, r1, lsl #6
    8ea0:	e1500281 	cmp	r0, r1, lsl #5
    8ea4:	e0a22002 	adc	r2, r2, r2
    8ea8:	20400281 	subcs	r0, r0, r1, lsl #5
    8eac:	e1500201 	cmp	r0, r1, lsl #4
    8eb0:	e0a22002 	adc	r2, r2, r2
    8eb4:	20400201 	subcs	r0, r0, r1, lsl #4
    8eb8:	e1500181 	cmp	r0, r1, lsl #3
    8ebc:	e0a22002 	adc	r2, r2, r2
    8ec0:	20400181 	subcs	r0, r0, r1, lsl #3
    8ec4:	e1500101 	cmp	r0, r1, lsl #2
    8ec8:	e0a22002 	adc	r2, r2, r2
    8ecc:	20400101 	subcs	r0, r0, r1, lsl #2
    8ed0:	e1500081 	cmp	r0, r1, lsl #1
    8ed4:	e0a22002 	adc	r2, r2, r2
    8ed8:	20400081 	subcs	r0, r0, r1, lsl #1
    8edc:	e1500001 	cmp	r0, r1
    8ee0:	e0a22002 	adc	r2, r2, r2
    8ee4:	20400001 	subcs	r0, r0, r1
    8ee8:	e1a00002 	mov	r0, r2
    8eec:	e12fff1e 	bx	lr
    8ef0:	03a00001 	moveq	r0, #1
    8ef4:	13a00000 	movne	r0, #0
    8ef8:	e12fff1e 	bx	lr
    8efc:	e16f2f11 	clz	r2, r1
    8f00:	e262201f 	rsb	r2, r2, #31
    8f04:	e1a00230 	lsr	r0, r0, r2
    8f08:	e12fff1e 	bx	lr
    8f0c:	e3500000 	cmp	r0, #0
    8f10:	13e00000 	mvnne	r0, #0
    8f14:	ea000007 	b	8f38 <__aeabi_idiv0>

00008f18 <__aeabi_uidivmod>:
__aeabi_uidivmod():
    8f18:	e3510000 	cmp	r1, #0
    8f1c:	0afffffa 	beq	8f0c <__udivsi3+0x1e0>
    8f20:	e92d4003 	push	{r0, r1, lr}
    8f24:	ebffff80 	bl	8d2c <__udivsi3>
    8f28:	e8bd4006 	pop	{r1, r2, lr}
    8f2c:	e0030092 	mul	r3, r2, r0
    8f30:	e0411003 	sub	r1, r1, r3
    8f34:	e12fff1e 	bx	lr

00008f38 <__aeabi_idiv0>:
__aeabi_ldiv0():
    8f38:	e12fff1e 	bx	lr

Disassembly of section .rodata:

00008f3c <_ZL13Lock_Unlocked>:
    8f3c:	00000000 	andeq	r0, r0, r0

00008f40 <_ZL11Lock_Locked>:
    8f40:	00000001 	andeq	r0, r0, r1

00008f44 <_ZL21MaxFSDriverNameLength>:
    8f44:	00000010 	andeq	r0, r0, r0, lsl r0

00008f48 <_ZL17MaxFilenameLength>:
    8f48:	00000010 	andeq	r0, r0, r0, lsl r0

00008f4c <_ZL13MaxPathLength>:
    8f4c:	00000080 	andeq	r0, r0, r0, lsl #1

00008f50 <_ZL18NoFilesystemDriver>:
    8f50:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008f54 <_ZL9NotifyAll>:
    8f54:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008f58 <_ZL24Max_Process_Opened_Files>:
    8f58:	00000010 	andeq	r0, r0, r0, lsl r0

00008f5c <_ZL10Indefinite>:
    8f5c:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008f60 <_ZL18Deadline_Unchanged>:
    8f60:	fffffffe 			; <UNDEFINED> instruction: 0xfffffffe

00008f64 <_ZL14Invalid_Handle>:
    8f64:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008f68 <_ZN3halL18Default_Clock_RateE>:
    8f68:	0ee6b280 	cdpeq	2, 14, cr11, cr6, cr0, {4}

00008f6c <_ZN3halL15Peripheral_BaseE>:
    8f6c:	20000000 	andcs	r0, r0, r0

00008f70 <_ZN3halL9GPIO_BaseE>:
    8f70:	20200000 	eorcs	r0, r0, r0

00008f74 <_ZN3halL14GPIO_Pin_CountE>:
    8f74:	00000036 	andeq	r0, r0, r6, lsr r0

00008f78 <_ZN3halL8AUX_BaseE>:
    8f78:	20215000 	eorcs	r5, r1, r0

00008f7c <_ZN3halL25Interrupt_Controller_BaseE>:
    8f7c:	2000b200 	andcs	fp, r0, r0, lsl #4

00008f80 <_ZN3halL10Timer_BaseE>:
    8f80:	2000b400 	andcs	fp, r0, r0, lsl #8

00008f84 <_ZN3halL9TRNG_BaseE>:
    8f84:	20104000 	andscs	r4, r0, r0

00008f88 <_ZN3halL9BSC0_BaseE>:
    8f88:	20205000 	eorcs	r5, r0, r0

00008f8c <_ZN3halL9BSC1_BaseE>:
    8f8c:	20804000 	addcs	r4, r0, r0

00008f90 <_ZN3halL9BSC2_BaseE>:
    8f90:	20805000 	addcs	r5, r0, r0

00008f94 <_ZL11Invalid_Pin>:
    8f94:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008f98 <_ZL17symbol_tick_delay>:
    8f98:	00000400 	andeq	r0, r0, r0, lsl #8

00008f9c <_ZL15char_tick_delay>:
    8f9c:	00001000 	andeq	r1, r0, r0
    8fa0:	00000031 	andeq	r0, r0, r1, lsr r0
    8fa4:	00000030 	andeq	r0, r0, r0, lsr r0
    8fa8:	3a564544 	bcc	159a4c0 <__bss_end+0x1591490>
    8fac:	6f697067 	svcvs	0x00697067
    8fb0:	0038312f 	eorseq	r3, r8, pc, lsr #2
    8fb4:	3a564544 	bcc	159a4cc <__bss_end+0x159149c>
    8fb8:	6f697067 	svcvs	0x00697067
    8fbc:	0036312f 	eorseq	r3, r6, pc, lsr #2
    8fc0:	00676f6c 	rsbeq	r6, r7, ip, ror #30
    8fc4:	21534f53 	cmpcs	r3, r3, asr pc
    8fc8:	00000000 	andeq	r0, r0, r0

00008fcc <_ZL13Lock_Unlocked>:
    8fcc:	00000000 	andeq	r0, r0, r0

00008fd0 <_ZL11Lock_Locked>:
    8fd0:	00000001 	andeq	r0, r0, r1

00008fd4 <_ZL21MaxFSDriverNameLength>:
    8fd4:	00000010 	andeq	r0, r0, r0, lsl r0

00008fd8 <_ZL17MaxFilenameLength>:
    8fd8:	00000010 	andeq	r0, r0, r0, lsl r0

00008fdc <_ZL13MaxPathLength>:
    8fdc:	00000080 	andeq	r0, r0, r0, lsl #1

00008fe0 <_ZL18NoFilesystemDriver>:
    8fe0:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008fe4 <_ZL9NotifyAll>:
    8fe4:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008fe8 <_ZL24Max_Process_Opened_Files>:
    8fe8:	00000010 	andeq	r0, r0, r0, lsl r0

00008fec <_ZL10Indefinite>:
    8fec:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008ff0 <_ZL18Deadline_Unchanged>:
    8ff0:	fffffffe 			; <UNDEFINED> instruction: 0xfffffffe

00008ff4 <_ZL14Invalid_Handle>:
    8ff4:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008ff8 <_ZL16Pipe_File_Prefix>:
    8ff8:	3a535953 	bcc	14df54c <__bss_end+0x14d651c>
    8ffc:	65706970 	ldrbvs	r6, [r0, #-2416]!	; 0xfffff690
    9000:	0000002f 	andeq	r0, r0, pc, lsr #32

00009004 <_ZN12_GLOBAL__N_1L11CharConvArrE>:
    9004:	33323130 	teqcc	r2, #48, 2
    9008:	37363534 			; <UNDEFINED> instruction: 0x37363534
    900c:	42413938 	submi	r3, r1, #56, 18	; 0xe0000
    9010:	46454443 	strbmi	r4, [r5], -r3, asr #8
	...

Disassembly of section .bss:

00009018 <sos_led>:
__bss_start():
    9018:	00000000 	andeq	r0, r0, r0

0000901c <button>:
	...

Disassembly of section .ARM.attributes:

00000000 <.ARM.attributes>:
   0:	00002e41 	andeq	r2, r0, r1, asr #28
   4:	61656100 	cmnvs	r5, r0, lsl #2
   8:	01006962 	tsteq	r0, r2, ror #18
   c:	00000024 	andeq	r0, r0, r4, lsr #32
  10:	4b5a3605 	blmi	168d82c <__bss_end+0x16847fc>
  14:	08070600 	stmdaeq	r7, {r9, sl}
  18:	0a010901 	beq	42424 <__bss_end+0x393f4>
  1c:	14041202 	strne	r1, [r4], #-514	; 0xfffffdfe
  20:	17011501 	strne	r1, [r1, -r1, lsl #10]
  24:	1a011803 	bne	46038 <__bss_end+0x3d008>
  28:	22011c01 	andcs	r1, r1, #256	; 0x100
  2c:	Address 0x000000000000002c is out of bounds.


Disassembly of section .comment:

00000000 <.comment>:
   0:	3a434347 	bcc	10d0d24 <__bss_end+0x10c7cf4>
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
  38:	7a617661 	bvc	185d9c4 <__bss_end+0x1854994>
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
  c0:	6a757a61 	bvs	1d5ea4c <__bss_end+0x1d55a1c>
  c4:	2f696369 	svccs	0x00696369
  c8:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
  cc:	73656d65 	cmnvc	r5, #6464	; 0x1940
  d0:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
  d4:	6b2d616b 	blvs	b58688 <__bss_end+0xb4f658>
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
 144:	fb010200 	blx	4094e <__bss_end+0x3791e>
 148:	01000d0e 	tsteq	r0, lr, lsl #26
 14c:	00010101 	andeq	r0, r1, r1, lsl #2
 150:	00010000 	andeq	r0, r1, r0
 154:	552f0100 	strpl	r0, [pc, #-256]!	; 5c <shift+0x5c>
 158:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 15c:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 160:	6a726574 	bvs	1c99738 <__bss_end+0x1c90708>
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
 198:	752f7365 	strvc	r7, [pc, #-869]!	; fffffe3b <__bss_end+0xffff6e0b>
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
 1d0:	0a05830b 	beq	160e04 <__bss_end+0x157dd4>
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
 1fc:	4a030402 	bmi	c120c <__bss_end+0xb81dc>
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
 230:	4a020402 	bmi	81240 <__bss_end+0x78210>
 234:	02000205 	andeq	r0, r0, #1342177280	; 0x50000000
 238:	052d0204 	streq	r0, [sp, #-516]!	; 0xfffffdfc
 23c:	01058509 	tsteq	r5, r9, lsl #10
 240:	000a022f 	andeq	r0, sl, pc, lsr #4
 244:	034e0101 	movteq	r0, #57601	; 0xe101
 248:	00030000 	andeq	r0, r3, r0
 24c:	0000028d 	andeq	r0, r0, sp, lsl #5
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
 280:	6a757a61 	bvs	1d5ec0c <__bss_end+0x1d55bdc>
 284:	2f696369 	svccs	0x00696369
 288:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
 28c:	73656d65 	cmnvc	r5, #6464	; 0x1940
 290:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
 294:	6b2d616b 	blvs	b58848 <__bss_end+0xb4f818>
 298:	6f2d7669 	svcvs	0x002d7669
 29c:	6f732f73 	svcvs	0x00732f73
 2a0:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
 2a4:	73752f73 	cmnvc	r5, #460	; 0x1cc
 2a8:	70737265 	rsbsvc	r7, r3, r5, ror #4
 2ac:	2f656361 	svccs	0x00656361
 2b0:	5f736f73 	svcpl	0x00736f73
 2b4:	6b736174 	blvs	1cd888c <__bss_end+0x1ccf85c>
 2b8:	73552f00 	cmpvc	r5, #0, 30
 2bc:	2f737265 	svccs	0x00737265
 2c0:	746e6977 	strbtvc	r6, [lr], #-2423	; 0xfffff689
 2c4:	696a7265 	stmdbvs	sl!, {r0, r2, r5, r6, r9, ip, sp, lr}^
 2c8:	7365442f 	cmnvc	r5, #788529152	; 0x2f000000
 2cc:	706f746b 	rsbvc	r7, pc, fp, ror #8
 2d0:	5641462f 	strbpl	r4, [r1], -pc, lsr #12
 2d4:	76614e2f 	strbtvc	r4, [r1], -pc, lsr #28
 2d8:	6a757a61 	bvs	1d5ec64 <__bss_end+0x1d55c34>
 2dc:	2f696369 	svccs	0x00696369
 2e0:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
 2e4:	73656d65 	cmnvc	r5, #6464	; 0x1940
 2e8:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
 2ec:	6b2d616b 	blvs	b588a0 <__bss_end+0xb4f870>
 2f0:	6f2d7669 	svcvs	0x002d7669
 2f4:	6f732f73 	svcvs	0x00732f73
 2f8:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
 2fc:	73752f73 	cmnvc	r5, #460	; 0x1cc
 300:	70737265 	rsbsvc	r7, r3, r5, ror #4
 304:	2f656361 	svccs	0x00656361
 308:	6b2f2e2e 	blvs	bcbbc8 <__bss_end+0xbc2b98>
 30c:	656e7265 	strbvs	r7, [lr, #-613]!	; 0xfffffd9b
 310:	6e692f6c 	cdpvs	15, 6, cr2, cr9, cr12, {3}
 314:	64756c63 	ldrbtvs	r6, [r5], #-3171	; 0xfffff39d
 318:	72702f65 	rsbsvc	r2, r0, #404	; 0x194
 31c:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
 320:	552f0073 	strpl	r0, [pc, #-115]!	; 2b5 <shift+0x2b5>
 324:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 328:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 32c:	6a726574 	bvs	1c99904 <__bss_end+0x1c908d4>
 330:	65442f69 	strbvs	r2, [r4, #-3945]	; 0xfffff097
 334:	6f746b73 	svcvs	0x00746b73
 338:	41462f70 	hvcmi	25328	; 0x62f0
 33c:	614e2f56 	cmpvs	lr, r6, asr pc
 340:	757a6176 	ldrbvc	r6, [sl, #-374]!	; 0xfffffe8a
 344:	6963696a 	stmdbvs	r3!, {r1, r3, r5, r6, r8, fp, sp, lr}^
 348:	2f534f2f 	svccs	0x00534f2f
 34c:	656d6573 	strbvs	r6, [sp, #-1395]!	; 0xfffffa8d
 350:	61727473 	cmnvs	r2, r3, ror r4
 354:	2d616b6c 	vstmdbcs	r1!, {d22-<overflow reg d75>}
 358:	2d76696b 			; <UNDEFINED> instruction: 0x2d76696b
 35c:	732f736f 			; <UNDEFINED> instruction: 0x732f736f
 360:	6372756f 	cmnvs	r2, #465567744	; 0x1bc00000
 364:	752f7365 	strvc	r7, [pc, #-869]!	; 7 <shift+0x7>
 368:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 36c:	65636170 	strbvs	r6, [r3, #-368]!	; 0xfffffe90
 370:	2f2e2e2f 	svccs	0x002e2e2f
 374:	6e72656b 	cdpvs	5, 7, cr6, cr2, cr11, {3}
 378:	692f6c65 	stmdbvs	pc!, {r0, r2, r5, r6, sl, fp, sp, lr}	; <UNPREDICTABLE>
 37c:	756c636e 	strbvc	r6, [ip, #-878]!	; 0xfffffc92
 380:	662f6564 	strtvs	r6, [pc], -r4, ror #10
 384:	552f0073 	strpl	r0, [pc, #-115]!	; 319 <shift+0x319>
 388:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 38c:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 390:	6a726574 	bvs	1c99968 <__bss_end+0x1c90938>
 394:	65442f69 	strbvs	r2, [r4, #-3945]	; 0xfffff097
 398:	6f746b73 	svcvs	0x00746b73
 39c:	41462f70 	hvcmi	25328	; 0x62f0
 3a0:	614e2f56 	cmpvs	lr, r6, asr pc
 3a4:	757a6176 	ldrbvc	r6, [sl, #-374]!	; 0xfffffe8a
 3a8:	6963696a 	stmdbvs	r3!, {r1, r3, r5, r6, r8, fp, sp, lr}^
 3ac:	2f534f2f 	svccs	0x00534f2f
 3b0:	656d6573 	strbvs	r6, [sp, #-1395]!	; 0xfffffa8d
 3b4:	61727473 	cmnvs	r2, r3, ror r4
 3b8:	2d616b6c 	vstmdbcs	r1!, {d22-<overflow reg d75>}
 3bc:	2d76696b 			; <UNDEFINED> instruction: 0x2d76696b
 3c0:	732f736f 			; <UNDEFINED> instruction: 0x732f736f
 3c4:	6372756f 	cmnvs	r2, #465567744	; 0x1bc00000
 3c8:	752f7365 	strvc	r7, [pc, #-869]!	; 6b <shift+0x6b>
 3cc:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 3d0:	65636170 	strbvs	r6, [r3, #-368]!	; 0xfffffe90
 3d4:	2f2e2e2f 	svccs	0x002e2e2f
 3d8:	6e72656b 	cdpvs	5, 7, cr6, cr2, cr11, {3}
 3dc:	692f6c65 	stmdbvs	pc!, {r0, r2, r5, r6, sl, fp, sp, lr}	; <UNPREDICTABLE>
 3e0:	756c636e 	strbvc	r6, [ip, #-878]!	; 0xfffffc92
 3e4:	622f6564 	eorvs	r6, pc, #100, 10	; 0x19000000
 3e8:	6472616f 	ldrbtvs	r6, [r2], #-367	; 0xfffffe91
 3ec:	6970722f 	ldmdbvs	r0!, {r0, r1, r2, r3, r5, r9, ip, sp, lr}^
 3f0:	61682f30 	cmnvs	r8, r0, lsr pc
 3f4:	552f006c 	strpl	r0, [pc, #-108]!	; 390 <shift+0x390>
 3f8:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 3fc:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 400:	6a726574 	bvs	1c999d8 <__bss_end+0x1c909a8>
 404:	65442f69 	strbvs	r2, [r4, #-3945]	; 0xfffff097
 408:	6f746b73 	svcvs	0x00746b73
 40c:	41462f70 	hvcmi	25328	; 0x62f0
 410:	614e2f56 	cmpvs	lr, r6, asr pc
 414:	757a6176 	ldrbvc	r6, [sl, #-374]!	; 0xfffffe8a
 418:	6963696a 	stmdbvs	r3!, {r1, r3, r5, r6, r8, fp, sp, lr}^
 41c:	2f534f2f 	svccs	0x00534f2f
 420:	656d6573 	strbvs	r6, [sp, #-1395]!	; 0xfffffa8d
 424:	61727473 	cmnvs	r2, r3, ror r4
 428:	2d616b6c 	vstmdbcs	r1!, {d22-<overflow reg d75>}
 42c:	2d76696b 			; <UNDEFINED> instruction: 0x2d76696b
 430:	732f736f 			; <UNDEFINED> instruction: 0x732f736f
 434:	6372756f 	cmnvs	r2, #465567744	; 0x1bc00000
 438:	752f7365 	strvc	r7, [pc, #-869]!	; db <shift+0xdb>
 43c:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 440:	65636170 	strbvs	r6, [r3, #-368]!	; 0xfffffe90
 444:	2f2e2e2f 	svccs	0x002e2e2f
 448:	6e72656b 	cdpvs	5, 7, cr6, cr2, cr11, {3}
 44c:	692f6c65 	stmdbvs	pc!, {r0, r2, r5, r6, sl, fp, sp, lr}	; <UNPREDICTABLE>
 450:	756c636e 	strbvc	r6, [ip, #-878]!	; 0xfffffc92
 454:	642f6564 	strtvs	r6, [pc], #-1380	; 45c <shift+0x45c>
 458:	65766972 	ldrbvs	r6, [r6, #-2418]!	; 0xfffff68e
 45c:	00007372 	andeq	r7, r0, r2, ror r3
 460:	6e69616d 	powvsez	f6, f1, #5.0
 464:	7070632e 	rsbsvc	r6, r0, lr, lsr #6
 468:	00000100 	andeq	r0, r0, r0, lsl #2
 46c:	2e697773 	mcrcs	7, 3, r7, cr9, cr3, {3}
 470:	00020068 	andeq	r0, r2, r8, rrx
 474:	69707300 	ldmdbvs	r0!, {r8, r9, ip, sp, lr}^
 478:	636f6c6e 	cmnvs	pc, #28160	; 0x6e00
 47c:	00682e6b 	rsbeq	r2, r8, fp, ror #28
 480:	66000002 	strvs	r0, [r0], -r2
 484:	73656c69 	cmnvc	r5, #26880	; 0x6900
 488:	65747379 	ldrbvs	r7, [r4, #-889]!	; 0xfffffc87
 48c:	00682e6d 	rsbeq	r2, r8, sp, ror #28
 490:	70000003 	andvc	r0, r0, r3
 494:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
 498:	682e7373 	stmdavs	lr!, {r0, r1, r4, r5, r6, r8, r9, ip, sp, lr}
 49c:	00000200 	andeq	r0, r0, r0, lsl #4
 4a0:	636f7270 	cmnvs	pc, #112, 4
 4a4:	5f737365 	svcpl	0x00737365
 4a8:	616e616d 	cmnvs	lr, sp, ror #2
 4ac:	2e726567 	cdpcs	5, 7, cr6, cr2, cr7, {3}
 4b0:	00020068 	andeq	r0, r2, r8, rrx
 4b4:	72657000 	rsbvc	r7, r5, #0
 4b8:	65687069 	strbvs	r7, [r8, #-105]!	; 0xffffff97
 4bc:	736c6172 	cmnvc	ip, #-2147483620	; 0x8000001c
 4c0:	0400682e 	streq	r6, [r0], #-2094	; 0xfffff7d2
 4c4:	70670000 	rsbvc	r0, r7, r0
 4c8:	682e6f69 	stmdavs	lr!, {r0, r3, r5, r6, r8, r9, sl, fp, sp, lr}
 4cc:	00000500 	andeq	r0, r0, r0, lsl #10
 4d0:	64746e69 	ldrbtvs	r6, [r4], #-3689	; 0xfffff197
 4d4:	682e6665 	stmdavs	lr!, {r0, r2, r5, r6, r9, sl, sp, lr}
 4d8:	00000400 	andeq	r0, r0, r0, lsl #8
 4dc:	00010500 	andeq	r0, r1, r0, lsl #10
 4e0:	822c0205 	eorhi	r0, ip, #1342177280	; 0x50000000
 4e4:	16030000 	strne	r0, [r3], -r0
 4e8:	9f070501 	svcls	0x00070501
 4ec:	040200bb 	streq	r0, [r2], #-187	; 0xffffff45
 4f0:	00660601 	rsbeq	r0, r6, r1, lsl #12
 4f4:	4a020402 	bmi	81504 <__bss_end+0x784d4>
 4f8:	04040200 	streq	r0, [r4], #-512	; 0xfffffe00
 4fc:	0402002e 	streq	r0, [r2], #-46	; 0xffffffd2
 500:	05670604 	strbeq	r0, [r7, #-1540]!	; 0xfffff9fc
 504:	04020001 	streq	r0, [r2], #-1
 508:	05bdbb04 	ldreq	fp, [sp, #2820]!	; 0xb04
 50c:	0a059f10 	beq	168154 <__bss_end+0x15f124>
 510:	4b0f0582 	blmi	3c1b20 <__bss_end+0x3b8af0>
 514:	05820905 	streq	r0, [r2, #2309]	; 0x905
 518:	07054c17 	smladeq	r5, r7, ip, r4
 51c:	bc19054b 	cfldr32lt	mvfx0, [r9], {75}	; 0x4b
 520:	02000705 	andeq	r0, r0, #1310720	; 0x140000
 524:	05870104 	streq	r0, [r7, #260]	; 0x104
 528:	04020008 	streq	r0, [r2], #-8
 52c:	ba090301 	blt	241138 <__bss_end+0x238108>
 530:	01040200 	mrseq	r0, R12_usr
 534:	04020084 	streq	r0, [r2], #-132	; 0xffffff7c
 538:	02004b01 	andeq	r4, r0, #1024	; 0x400
 53c:	00670104 	rsbeq	r0, r7, r4, lsl #2
 540:	4b010402 	blmi	41550 <__bss_end+0x38520>
 544:	01040200 	mrseq	r0, R12_usr
 548:	04020067 	streq	r0, [r2], #-103	; 0xffffff99
 54c:	02004c01 	andeq	r4, r0, #256	; 0x100
 550:	00680104 	rsbeq	r0, r8, r4, lsl #2
 554:	4b010402 	blmi	41564 <__bss_end+0x38534>
 558:	01040200 	mrseq	r0, R12_usr
 55c:	04020067 	streq	r0, [r2], #-103	; 0xffffff99
 560:	02004b01 	andeq	r4, r0, #1024	; 0x400
 564:	00670104 	rsbeq	r0, r7, r4, lsl #2
 568:	4b010402 	blmi	41578 <__bss_end+0x38548>
 56c:	01040200 	mrseq	r0, R12_usr
 570:	04020068 	streq	r0, [r2], #-104	; 0xffffff98
 574:	02006801 	andeq	r6, r0, #65536	; 0x10000
 578:	004b0104 	subeq	r0, fp, r4, lsl #2
 57c:	67010402 	strvs	r0, [r1, -r2, lsl #8]
 580:	01040200 	mrseq	r0, R12_usr
 584:	0402004b 	streq	r0, [r2], #-75	; 0xffffffb5
 588:	07056701 	streq	r6, [r5, -r1, lsl #14]
 58c:	01040200 	mrseq	r0, R12_usr
 590:	024a6003 	subeq	r6, sl, #3
 594:	0101000e 	tsteq	r1, lr
 598:	000002c8 	andeq	r0, r0, r8, asr #5
 59c:	01dd0003 	bicseq	r0, sp, r3
 5a0:	01020000 	mrseq	r0, (UNDEF: 2)
 5a4:	000d0efb 	strdeq	r0, [sp], -fp
 5a8:	01010101 	tsteq	r1, r1, lsl #2
 5ac:	01000000 	mrseq	r0, (UNDEF: 0)
 5b0:	2f010000 	svccs	0x00010000
 5b4:	72657355 	rsbvc	r7, r5, #1409286145	; 0x54000001
 5b8:	69772f73 	ldmdbvs	r7!, {r0, r1, r4, r5, r6, r8, r9, sl, fp, sp}^
 5bc:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
 5c0:	442f696a 	strtmi	r6, [pc], #-2410	; 5c8 <shift+0x5c8>
 5c4:	746b7365 	strbtvc	r7, [fp], #-869	; 0xfffffc9b
 5c8:	462f706f 	strtmi	r7, [pc], -pc, rrx
 5cc:	4e2f5641 	cfmadda32mi	mvax2, mvax5, mvfx15, mvfx1
 5d0:	7a617661 	bvc	185df5c <__bss_end+0x1854f2c>
 5d4:	63696a75 	cmnvs	r9, #479232	; 0x75000
 5d8:	534f2f69 	movtpl	r2, #65385	; 0xff69
 5dc:	6d65732f 	stclvs	3, cr7, [r5, #-188]!	; 0xffffff44
 5e0:	72747365 	rsbsvc	r7, r4, #-1811939327	; 0x94000001
 5e4:	616b6c61 	cmnvs	fp, r1, ror #24
 5e8:	76696b2d 	strbtvc	r6, [r9], -sp, lsr #22
 5ec:	2f736f2d 	svccs	0x00736f2d
 5f0:	72756f73 	rsbsvc	r6, r5, #460	; 0x1cc
 5f4:	2f736563 	svccs	0x00736563
 5f8:	6c647473 	cfstrdvs	mvd7, [r4], #-460	; 0xfffffe34
 5fc:	732f6269 			; <UNDEFINED> instruction: 0x732f6269
 600:	2f006372 	svccs	0x00006372
 604:	72657355 	rsbvc	r7, r5, #1409286145	; 0x54000001
 608:	69772f73 	ldmdbvs	r7!, {r0, r1, r4, r5, r6, r8, r9, sl, fp, sp}^
 60c:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
 610:	442f696a 	strtmi	r6, [pc], #-2410	; 618 <shift+0x618>
 614:	746b7365 	strbtvc	r7, [fp], #-869	; 0xfffffc9b
 618:	462f706f 	strtmi	r7, [pc], -pc, rrx
 61c:	4e2f5641 	cfmadda32mi	mvax2, mvax5, mvfx15, mvfx1
 620:	7a617661 	bvc	185dfac <__bss_end+0x1854f7c>
 624:	63696a75 	cmnvs	r9, #479232	; 0x75000
 628:	534f2f69 	movtpl	r2, #65385	; 0xff69
 62c:	6d65732f 	stclvs	3, cr7, [r5, #-188]!	; 0xffffff44
 630:	72747365 	rsbsvc	r7, r4, #-1811939327	; 0x94000001
 634:	616b6c61 	cmnvs	fp, r1, ror #24
 638:	76696b2d 	strbtvc	r6, [r9], -sp, lsr #22
 63c:	2f736f2d 	svccs	0x00736f2d
 640:	72756f73 	rsbsvc	r6, r5, #460	; 0x1cc
 644:	2f736563 	svccs	0x00736563
 648:	6e72656b 	cdpvs	5, 7, cr6, cr2, cr11, {3}
 64c:	692f6c65 	stmdbvs	pc!, {r0, r2, r5, r6, sl, fp, sp, lr}	; <UNPREDICTABLE>
 650:	756c636e 	strbvc	r6, [ip, #-878]!	; 0xfffffc92
 654:	702f6564 	eorvc	r6, pc, r4, ror #10
 658:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
 65c:	2f007373 	svccs	0x00007373
 660:	72657355 	rsbvc	r7, r5, #1409286145	; 0x54000001
 664:	69772f73 	ldmdbvs	r7!, {r0, r1, r4, r5, r6, r8, r9, sl, fp, sp}^
 668:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
 66c:	442f696a 	strtmi	r6, [pc], #-2410	; 674 <shift+0x674>
 670:	746b7365 	strbtvc	r7, [fp], #-869	; 0xfffffc9b
 674:	462f706f 	strtmi	r7, [pc], -pc, rrx
 678:	4e2f5641 	cfmadda32mi	mvax2, mvax5, mvfx15, mvfx1
 67c:	7a617661 	bvc	185e008 <__bss_end+0x1854fd8>
 680:	63696a75 	cmnvs	r9, #479232	; 0x75000
 684:	534f2f69 	movtpl	r2, #65385	; 0xff69
 688:	6d65732f 	stclvs	3, cr7, [r5, #-188]!	; 0xffffff44
 68c:	72747365 	rsbsvc	r7, r4, #-1811939327	; 0x94000001
 690:	616b6c61 	cmnvs	fp, r1, ror #24
 694:	76696b2d 	strbtvc	r6, [r9], -sp, lsr #22
 698:	2f736f2d 	svccs	0x00736f2d
 69c:	72756f73 	rsbsvc	r6, r5, #460	; 0x1cc
 6a0:	2f736563 	svccs	0x00736563
 6a4:	6e72656b 	cdpvs	5, 7, cr6, cr2, cr11, {3}
 6a8:	692f6c65 	stmdbvs	pc!, {r0, r2, r5, r6, sl, fp, sp, lr}	; <UNPREDICTABLE>
 6ac:	756c636e 	strbvc	r6, [ip, #-878]!	; 0xfffffc92
 6b0:	662f6564 	strtvs	r6, [pc], -r4, ror #10
 6b4:	552f0073 	strpl	r0, [pc, #-115]!	; 649 <shift+0x649>
 6b8:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 6bc:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 6c0:	6a726574 	bvs	1c99c98 <__bss_end+0x1c90c68>
 6c4:	65442f69 	strbvs	r2, [r4, #-3945]	; 0xfffff097
 6c8:	6f746b73 	svcvs	0x00746b73
 6cc:	41462f70 	hvcmi	25328	; 0x62f0
 6d0:	614e2f56 	cmpvs	lr, r6, asr pc
 6d4:	757a6176 	ldrbvc	r6, [sl, #-374]!	; 0xfffffe8a
 6d8:	6963696a 	stmdbvs	r3!, {r1, r3, r5, r6, r8, fp, sp, lr}^
 6dc:	2f534f2f 	svccs	0x00534f2f
 6e0:	656d6573 	strbvs	r6, [sp, #-1395]!	; 0xfffffa8d
 6e4:	61727473 	cmnvs	r2, r3, ror r4
 6e8:	2d616b6c 	vstmdbcs	r1!, {d22-<overflow reg d75>}
 6ec:	2d76696b 			; <UNDEFINED> instruction: 0x2d76696b
 6f0:	732f736f 			; <UNDEFINED> instruction: 0x732f736f
 6f4:	6372756f 	cmnvs	r2, #465567744	; 0x1bc00000
 6f8:	6b2f7365 	blvs	bdd494 <__bss_end+0xbd4464>
 6fc:	656e7265 	strbvs	r7, [lr, #-613]!	; 0xfffffd9b
 700:	6e692f6c 	cdpvs	15, 6, cr2, cr9, cr12, {3}
 704:	64756c63 	ldrbtvs	r6, [r5], #-3171	; 0xfffff39d
 708:	6f622f65 	svcvs	0x00622f65
 70c:	2f647261 	svccs	0x00647261
 710:	30697072 	rsbcc	r7, r9, r2, ror r0
 714:	6c61682f 	stclvs	8, cr6, [r1], #-188	; 0xffffff44
 718:	74730000 	ldrbtvc	r0, [r3], #-0
 71c:	6c696664 	stclvs	6, cr6, [r9], #-400	; 0xfffffe70
 720:	70632e65 	rsbvc	r2, r3, r5, ror #28
 724:	00010070 	andeq	r0, r1, r0, ror r0
 728:	69777300 	ldmdbvs	r7!, {r8, r9, ip, sp, lr}^
 72c:	0200682e 	andeq	r6, r0, #3014656	; 0x2e0000
 730:	70730000 	rsbsvc	r0, r3, r0
 734:	6f6c6e69 	svcvs	0x006c6e69
 738:	682e6b63 	stmdavs	lr!, {r0, r1, r5, r6, r8, r9, fp, sp, lr}
 73c:	00000200 	andeq	r0, r0, r0, lsl #4
 740:	656c6966 	strbvs	r6, [ip, #-2406]!	; 0xfffff69a
 744:	74737973 	ldrbtvc	r7, [r3], #-2419	; 0xfffff68d
 748:	682e6d65 	stmdavs	lr!, {r0, r2, r5, r6, r8, sl, fp, sp, lr}
 74c:	00000300 	andeq	r0, r0, r0, lsl #6
 750:	636f7270 	cmnvs	pc, #112, 4
 754:	2e737365 	cdpcs	3, 7, cr7, cr3, cr5, {3}
 758:	00020068 	andeq	r0, r2, r8, rrx
 75c:	6f727000 	svcvs	0x00727000
 760:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
 764:	6e616d5f 	mcrvs	13, 3, r6, cr1, cr15, {2}
 768:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
 76c:	0200682e 	andeq	r6, r0, #3014656	; 0x2e0000
 770:	6e690000 	cdpvs	0, 6, cr0, cr9, cr0, {0}
 774:	66656474 			; <UNDEFINED> instruction: 0x66656474
 778:	0400682e 	streq	r6, [r0], #-2094	; 0xfffff7d2
 77c:	05000000 	streq	r0, [r0, #-0]
 780:	02050001 	andeq	r0, r5, #1
 784:	00008418 	andeq	r8, r0, r8, lsl r4
 788:	69050516 	stmdbvs	r5, {r1, r2, r4, r8, sl}
 78c:	4c0c052f 	cfstr32mi	mvfx0, [ip], {47}	; 0x2f
 790:	852f0105 	strhi	r0, [pc, #-261]!	; 693 <shift+0x693>
 794:	4b830505 	blmi	fe0c1bb0 <__bss_end+0xfe0b8b80>
 798:	852f0105 	strhi	r0, [pc, #-261]!	; 69b <shift+0x69b>
 79c:	054b0505 	strbeq	r0, [fp, #-1285]	; 0xfffffafb
 7a0:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 7a4:	4b4ba105 	blmi	12e8bc0 <__bss_end+0x12dfb90>
 7a8:	4c0c052f 	cfstr32mi	mvfx0, [ip], {47}	; 0x2f
 7ac:	852f0105 	strhi	r0, [pc, #-261]!	; 6af <shift+0x6af>
 7b0:	4bbd0505 	blmi	fef41bcc <__bss_end+0xfef38b9c>
 7b4:	052f4b4b 	streq	r4, [pc, #-2891]!	; fffffc71 <__bss_end+0xffff6c41>
 7b8:	01054c0c 	tsteq	r5, ip, lsl #24
 7bc:	0505852f 	streq	r8, [r5, #-1327]	; 0xfffffad1
 7c0:	4b4b4bbd 	blmi	12d36bc <__bss_end+0x12ca68c>
 7c4:	4c0c052f 	cfstr32mi	mvfx0, [ip], {47}	; 0x2f
 7c8:	852f0105 	strhi	r0, [pc, #-261]!	; 6cb <shift+0x6cb>
 7cc:	4b830505 	blmi	fe0c1be8 <__bss_end+0xfe0b8bb8>
 7d0:	852f0105 	strhi	r0, [pc, #-261]!	; 6d3 <shift+0x6d3>
 7d4:	4bbd0505 	blmi	fef41bf0 <__bss_end+0xfef38bc0>
 7d8:	052f4b4b 	streq	r4, [pc, #-2891]!	; fffffc95 <__bss_end+0xffff6c65>
 7dc:	01054c0c 	tsteq	r5, ip, lsl #24
 7e0:	0505852f 	streq	r8, [r5, #-1327]	; 0xfffffad1
 7e4:	2f4b4ba1 	svccs	0x004b4ba1
 7e8:	054c0c05 	strbeq	r0, [ip, #-3077]	; 0xfffff3fb
 7ec:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 7f0:	4b4bbd05 	blmi	12efc0c <__bss_end+0x12e6bdc>
 7f4:	0c052f4b 	stceq	15, cr2, [r5], {75}	; 0x4b
 7f8:	2f01054c 	svccs	0x0001054c
 7fc:	a1050585 	smlabbge	r5, r5, r5, r0
 800:	052f4b4b 	streq	r4, [pc, #-2891]!	; fffffcbd <__bss_end+0xffff6c8d>
 804:	01054c0c 	tsteq	r5, ip, lsl #24
 808:	2005859f 	mulcs	r5, pc, r5	; <UNPREDICTABLE>
 80c:	4d050567 	cfstr32mi	mvfx0, [r5, #-412]	; 0xfffffe64
 810:	0c054b4b 			; <UNDEFINED> instruction: 0x0c054b4b
 814:	2f010530 	svccs	0x00010530
 818:	67200585 	strvs	r0, [r0, -r5, lsl #11]!
 81c:	4b4d0505 	blmi	1341c38 <__bss_end+0x1338c08>
 820:	300c054b 	andcc	r0, ip, fp, asr #10
 824:	852f0105 	strhi	r0, [pc, #-261]!	; 727 <shift+0x727>
 828:	05832005 	streq	r2, [r3, #5]
 82c:	4b4b4c05 	blmi	12d3848 <__bss_end+0x12ca818>
 830:	852f0105 	strhi	r0, [pc, #-261]!	; 733 <shift+0x733>
 834:	05672005 	strbeq	r2, [r7, #-5]!
 838:	4b4b4d05 	blmi	12d3c54 <__bss_end+0x12cac24>
 83c:	05300c05 	ldreq	r0, [r0, #-3077]!	; 0xfffff3fb
 840:	05872f01 	streq	r2, [r7, #3841]	; 0xf01
 844:	059fa00c 	ldreq	sl, [pc, #12]	; 858 <shift+0x858>
 848:	2905bc31 	stmdbcs	r5, {r0, r4, r5, sl, fp, ip, sp, pc}
 84c:	2e360566 	cdpcs	5, 3, cr0, cr6, cr6, {3}
 850:	05300f05 	ldreq	r0, [r0, #-3845]!	; 0xfffff0fb
 854:	09056613 	stmdbeq	r5, {r0, r1, r4, r9, sl, sp, lr}
 858:	d8100584 	ldmdale	r0, {r2, r7, r8, sl}
 85c:	029f0105 	addseq	r0, pc, #1073741825	; 0x40000001
 860:	01010008 	tsteq	r1, r8
 864:	0000029b 	muleq	r0, fp, r2
 868:	00740003 	rsbseq	r0, r4, r3
 86c:	01020000 	mrseq	r0, (UNDEF: 2)
 870:	000d0efb 	strdeq	r0, [sp], -fp
 874:	01010101 	tsteq	r1, r1, lsl #2
 878:	01000000 	mrseq	r0, (UNDEF: 0)
 87c:	2f010000 	svccs	0x00010000
 880:	72657355 	rsbvc	r7, r5, #1409286145	; 0x54000001
 884:	69772f73 	ldmdbvs	r7!, {r0, r1, r4, r5, r6, r8, r9, sl, fp, sp}^
 888:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
 88c:	442f696a 	strtmi	r6, [pc], #-2410	; 894 <shift+0x894>
 890:	746b7365 	strbtvc	r7, [fp], #-869	; 0xfffffc9b
 894:	462f706f 	strtmi	r7, [pc], -pc, rrx
 898:	4e2f5641 	cfmadda32mi	mvax2, mvax5, mvfx15, mvfx1
 89c:	7a617661 	bvc	185e228 <__bss_end+0x18551f8>
 8a0:	63696a75 	cmnvs	r9, #479232	; 0x75000
 8a4:	534f2f69 	movtpl	r2, #65385	; 0xff69
 8a8:	6d65732f 	stclvs	3, cr7, [r5, #-188]!	; 0xffffff44
 8ac:	72747365 	rsbsvc	r7, r4, #-1811939327	; 0x94000001
 8b0:	616b6c61 	cmnvs	fp, r1, ror #24
 8b4:	76696b2d 	strbtvc	r6, [r9], -sp, lsr #22
 8b8:	2f736f2d 	svccs	0x00736f2d
 8bc:	72756f73 	rsbsvc	r6, r5, #460	; 0x1cc
 8c0:	2f736563 	svccs	0x00736563
 8c4:	6c647473 	cfstrdvs	mvd7, [r4], #-460	; 0xfffffe34
 8c8:	732f6269 			; <UNDEFINED> instruction: 0x732f6269
 8cc:	00006372 	andeq	r6, r0, r2, ror r3
 8d0:	73647473 	cmnvc	r4, #1929379840	; 0x73000000
 8d4:	6e697274 	mcrvs	2, 3, r7, cr9, cr4, {3}
 8d8:	70632e67 	rsbvc	r2, r3, r7, ror #28
 8dc:	00010070 	andeq	r0, r1, r0, ror r0
 8e0:	01050000 	mrseq	r0, (UNDEF: 5)
 8e4:	74020500 	strvc	r0, [r2], #-1280	; 0xfffffb00
 8e8:	1a000088 	bne	b10 <shift+0xb10>
 8ec:	05bb0605 	ldreq	r0, [fp, #1541]!	; 0x605
 8f0:	21054c0f 	tstcs	r5, pc, lsl #24
 8f4:	ba0a0568 	blt	281e9c <__bss_end+0x278e6c>
 8f8:	052e0b05 	streq	r0, [lr, #-2821]!	; 0xfffff4fb
 8fc:	0d054a27 	vstreq	s8, [r5, #-156]	; 0xffffff64
 900:	2f09054a 	svccs	0x0009054a
 904:	059f0405 	ldreq	r0, [pc, #1029]	; d11 <shift+0xd11>
 908:	05056202 	streq	r6, [r5, #-514]	; 0xfffffdfe
 90c:	68100535 	ldmdavs	r0, {r0, r2, r4, r5, r8, sl}
 910:	052e1105 	streq	r1, [lr, #-261]!	; 0xfffffefb
 914:	13054a22 	movwne	r4, #23074	; 0x5a22
 918:	2f0a052e 	svccs	0x000a052e
 91c:	05690905 	strbeq	r0, [r9, #-2309]!	; 0xfffff6fb
 920:	0c052e0a 	stceq	14, cr2, [r5], {10}
 924:	4b03054a 	blmi	c1e54 <__bss_end+0xb8e24>
 928:	05680b05 	strbeq	r0, [r8, #-2821]!	; 0xfffff4fb
 92c:	04020018 	streq	r0, [r2], #-24	; 0xffffffe8
 930:	14054a03 	strne	r4, [r5], #-2563	; 0xfffff5fd
 934:	03040200 	movweq	r0, #16896	; 0x4200
 938:	0015059e 	mulseq	r5, lr, r5
 93c:	68020402 	stmdavs	r2, {r1, sl}
 940:	02001805 	andeq	r1, r0, #327680	; 0x50000
 944:	05820204 	streq	r0, [r2, #516]	; 0x204
 948:	04020008 	streq	r0, [r2], #-8
 94c:	1a054a02 	bne	15315c <__bss_end+0x14a12c>
 950:	02040200 	andeq	r0, r4, #0, 4
 954:	001b054b 	andseq	r0, fp, fp, asr #10
 958:	2e020402 	cdpcs	4, 0, cr0, cr2, cr2, {0}
 95c:	02000c05 	andeq	r0, r0, #1280	; 0x500
 960:	054a0204 	strbeq	r0, [sl, #-516]	; 0xfffffdfc
 964:	0402000f 	streq	r0, [r2], #-15
 968:	1b058202 	blne	161178 <__bss_end+0x158148>
 96c:	02040200 	andeq	r0, r4, #0, 4
 970:	0011054a 	andseq	r0, r1, sl, asr #10
 974:	2e020402 	cdpcs	4, 0, cr0, cr2, cr2, {0}
 978:	02000a05 	andeq	r0, r0, #20480	; 0x5000
 97c:	052f0204 	streq	r0, [pc, #-516]!	; 780 <shift+0x780>
 980:	0402000b 	streq	r0, [r2], #-11
 984:	0d052e02 	stceq	14, cr2, [r5, #-8]
 988:	02040200 	andeq	r0, r4, #0, 4
 98c:	0002054a 	andeq	r0, r2, sl, asr #10
 990:	46020402 	strmi	r0, [r2], -r2, lsl #8
 994:	85880105 	strhi	r0, [r8, #261]	; 0x105
 998:	05830605 	streq	r0, [r3, #1541]	; 0x605
 99c:	10054c09 	andne	r4, r5, r9, lsl #24
 9a0:	4c0a054a 	cfstr32mi	mvfx0, [sl], {74}	; 0x4a
 9a4:	05bb0705 	ldreq	r0, [fp, #1797]!	; 0x705
 9a8:	17054a03 	strne	r4, [r5, -r3, lsl #20]
 9ac:	01040200 	mrseq	r0, R12_usr
 9b0:	0014054a 	andseq	r0, r4, sl, asr #10
 9b4:	4a010402 	bmi	419c4 <__bss_end+0x38994>
 9b8:	054d0d05 	strbeq	r0, [sp, #-3333]	; 0xfffff2fb
 9bc:	0a054a14 	beq	153214 <__bss_end+0x14a1e4>
 9c0:	6808052e 	stmdavs	r8, {r1, r2, r3, r5, r8, sl}
 9c4:	78030205 	stmdavc	r3, {r0, r2, r9}
 9c8:	03090566 	movweq	r0, #38246	; 0x9566
 9cc:	01052e0b 	tsteq	r5, fp, lsl #28
 9d0:	0905852f 	stmdbeq	r5, {r0, r1, r2, r3, r5, r8, sl, pc}
 9d4:	001605bd 			; <UNDEFINED> instruction: 0x001605bd
 9d8:	4a040402 	bmi	1019e8 <__bss_end+0xf89b8>
 9dc:	02001d05 	andeq	r1, r0, #320	; 0x140
 9e0:	05820204 	streq	r0, [r2, #516]	; 0x204
 9e4:	0402001e 	streq	r0, [r2], #-30	; 0xffffffe2
 9e8:	16052e02 	strne	r2, [r5], -r2, lsl #28
 9ec:	02040200 	andeq	r0, r4, #0, 4
 9f0:	00110566 	andseq	r0, r1, r6, ror #10
 9f4:	4b030402 	blmi	c1a04 <__bss_end+0xb89d4>
 9f8:	02001205 	andeq	r1, r0, #1342177280	; 0x50000000
 9fc:	052e0304 	streq	r0, [lr, #-772]!	; 0xfffffcfc
 a00:	04020008 	streq	r0, [r2], #-8
 a04:	09054a03 	stmdbeq	r5, {r0, r1, r9, fp, lr}
 a08:	03040200 	movweq	r0, #16896	; 0x4200
 a0c:	0012052e 	andseq	r0, r2, lr, lsr #10
 a10:	4a030402 	bmi	c1a20 <__bss_end+0xb89f0>
 a14:	02000b05 	andeq	r0, r0, #5120	; 0x1400
 a18:	052e0304 	streq	r0, [lr, #-772]!	; 0xfffffcfc
 a1c:	04020002 	streq	r0, [r2], #-2
 a20:	0b052d03 	bleq	14be34 <__bss_end+0x142e04>
 a24:	02040200 	andeq	r0, r4, #0, 4
 a28:	00080584 	andeq	r0, r8, r4, lsl #11
 a2c:	83010402 	movwhi	r0, #5122	; 0x1402
 a30:	02000905 	andeq	r0, r0, #81920	; 0x14000
 a34:	052e0104 	streq	r0, [lr, #-260]!	; 0xfffffefc
 a38:	0402000b 	streq	r0, [r2], #-11
 a3c:	02054a01 	andeq	r4, r5, #4096	; 0x1000
 a40:	01040200 	mrseq	r0, R12_usr
 a44:	850b0549 	strhi	r0, [fp, #-1353]	; 0xfffffab7
 a48:	852f0105 	strhi	r0, [pc, #-261]!	; 94b <shift+0x94b>
 a4c:	05bc0e05 	ldreq	r0, [ip, #3589]!	; 0xe05
 a50:	20056611 	andcs	r6, r5, r1, lsl r6
 a54:	660b05bc 			; <UNDEFINED> instruction: 0x660b05bc
 a58:	054b1f05 	strbeq	r1, [fp, #-3845]	; 0xfffff0fb
 a5c:	0805660a 	stmdaeq	r5, {r1, r3, r9, sl, sp, lr}
 a60:	8311054b 	tsthi	r1, #314572800	; 0x12c00000
 a64:	052e1605 	streq	r1, [lr, #-1541]!	; 0xfffff9fb
 a68:	11056708 	tstne	r5, r8, lsl #14
 a6c:	4d0b0567 	cfstr32mi	mvfx0, [fp, #-412]	; 0xfffffe64
 a70:	852f0105 	strhi	r0, [pc, #-261]!	; 973 <shift+0x973>
 a74:	05830605 	streq	r0, [r3, #1541]	; 0x605
 a78:	0c054c0b 	stceq	12, cr4, [r5], {11}
 a7c:	660e052e 	strvs	r0, [lr], -lr, lsr #10
 a80:	054b0405 	strbeq	r0, [fp, #-1029]	; 0xfffffbfb
 a84:	09056502 	stmdbeq	r5, {r1, r8, sl, sp, lr}
 a88:	2f010531 	svccs	0x00010531
 a8c:	9f080585 	svcls	0x00080585
 a90:	054c0b05 	strbeq	r0, [ip, #-2821]	; 0xfffff4fb
 a94:	04020014 	streq	r0, [r2], #-20	; 0xffffffec
 a98:	07054a03 	streq	r4, [r5, -r3, lsl #20]
 a9c:	02040200 	andeq	r0, r4, #0, 4
 aa0:	00080583 	andeq	r0, r8, r3, lsl #11
 aa4:	2e020402 	cdpcs	4, 0, cr0, cr2, cr2, {0}
 aa8:	02000a05 	andeq	r0, r0, #20480	; 0x5000
 aac:	054a0204 	strbeq	r0, [sl, #-516]	; 0xfffffdfc
 ab0:	04020002 	streq	r0, [r2], #-2
 ab4:	01054902 	tsteq	r5, r2, lsl #18
 ab8:	0e058584 	cfsh32eq	mvfx8, mvfx5, #-60
 abc:	4b0805bb 	blmi	2021b0 <__bss_end+0x1f9180>
 ac0:	054c0b05 	strbeq	r0, [ip, #-2821]	; 0xfffff4fb
 ac4:	04020014 	streq	r0, [r2], #-20	; 0xffffffec
 ac8:	16054a03 	strne	r4, [r5], -r3, lsl #20
 acc:	02040200 	andeq	r0, r4, #0, 4
 ad0:	00170583 	andseq	r0, r7, r3, lsl #11
 ad4:	2e020402 	cdpcs	4, 0, cr0, cr2, cr2, {0}
 ad8:	02000a05 	andeq	r0, r0, #20480	; 0x5000
 adc:	054a0204 	strbeq	r0, [sl, #-516]	; 0xfffffdfc
 ae0:	0402000b 	streq	r0, [r2], #-11
 ae4:	17052e02 	strne	r2, [r5, -r2, lsl #28]
 ae8:	02040200 	andeq	r0, r4, #0, 4
 aec:	000d054a 	andeq	r0, sp, sl, asr #10
 af0:	2e020402 	cdpcs	4, 0, cr0, cr2, cr2, {0}
 af4:	02000205 	andeq	r0, r0, #1342177280	; 0x50000000
 af8:	052d0204 	streq	r0, [sp, #-516]!	; 0xfffffdfc
 afc:	08028401 	stmdaeq	r2, {r0, sl, pc}
 b00:	Address 0x0000000000000b00 is out of bounds.


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
      58:	0a740704 	beq	1d01c70 <__bss_end+0x1cf8c40>
      5c:	5b020000 	blpl	80064 <__bss_end+0x77034>
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
     128:	00000a74 	andeq	r0, r0, r4, ror sl
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
     174:	cb104801 	blgt	412180 <__bss_end+0x409150>
     178:	d4000000 	strle	r0, [r0], #-0
     17c:	58000081 	stmdapl	r0, {r0, r7}
     180:	01000000 	mrseq	r0, (UNDEF: 0)
     184:	0000cb9c 	muleq	r0, ip, fp
     188:	02b40a00 	adcseq	r0, r4, #0, 20
     18c:	4a010000 	bmi	40194 <__bss_end+0x37164>
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
     21c:	ba0d9c01 	blt	367228 <__bss_end+0x35e1f8>
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
     24c:	8b120f01 	blhi	483e58 <__bss_end+0x47ae28>
     250:	0f000001 	svceq	0x00000001
     254:	0000019e 	muleq	r0, lr, r1
     258:	03d51000 	bicseq	r1, r5, #0
     25c:	0a010000 	beq	40264 <__bss_end+0x37234>
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
     2b4:	8b140074 	blhi	50048c <__bss_end+0x4f745c>
     2b8:	a4000001 	strge	r0, [r0], #-1
     2bc:	38000080 	stmdacc	r0, {r7}
     2c0:	01000000 	mrseq	r0, (UNDEF: 0)
     2c4:	0067139c 	mlseq	r7, ip, r3, r1
     2c8:	9e2f0a01 	vmulls.f32	s0, s30, s2
     2cc:	02000001 	andeq	r0, r0, #1
     2d0:	00007491 	muleq	r0, r1, r4
     2d4:	00000862 	andeq	r0, r0, r2, ror #16
     2d8:	01e00004 	mvneq	r0, r4
     2dc:	01040000 	mrseq	r0, (UNDEF: 4)
     2e0:	000001e1 	andeq	r0, r0, r1, ror #3
     2e4:	000b4b04 	andeq	r4, fp, r4, lsl #22
     2e8:	00005600 	andeq	r5, r0, r0, lsl #12
     2ec:	00822c00 	addeq	r2, r2, r0, lsl #24
     2f0:	0001ec00 	andeq	lr, r1, r0, lsl #24
     2f4:	00024600 	andeq	r4, r2, r0, lsl #12
     2f8:	08010200 	stmdaeq	r1, {r9}
     2fc:	00000b0d 	andeq	r0, r0, sp, lsl #22
     300:	b0050202 	andlt	r0, r5, r2, lsl #4
     304:	03000009 	movweq	r0, #9
     308:	6e690504 	cdpvs	5, 6, cr0, cr9, cr4, {0}
     30c:	01020074 	tsteq	r2, r4, ror r0
     310:	000b0408 	andeq	r0, fp, r8, lsl #8
     314:	07020200 	streq	r0, [r2, -r0, lsl #4]
     318:	00000c0d 	andeq	r0, r0, sp, lsl #24
     31c:	00060904 	andeq	r0, r6, r4, lsl #18
     320:	07090900 	streq	r0, [r9, -r0, lsl #18]
     324:	00000059 	andeq	r0, r0, r9, asr r0
     328:	00004805 	andeq	r4, r0, r5, lsl #16
     32c:	07040200 	streq	r0, [r4, -r0, lsl #4]
     330:	00000a74 	andeq	r0, r0, r4, ror sl
     334:	00005905 	andeq	r5, r0, r5, lsl #18
     338:	0cbd0600 	ldceq	6, cr0, [sp]
     33c:	02080000 	andeq	r0, r8, #0
     340:	008b0806 	addeq	r0, fp, r6, lsl #16
     344:	72070000 	andvc	r0, r7, #0
     348:	08020030 	stmdaeq	r2, {r4, r5}
     34c:	0000480e 	andeq	r4, r0, lr, lsl #16
     350:	72070000 	andvc	r0, r7, #0
     354:	09020031 	stmdbeq	r2, {r0, r4, r5}
     358:	0000480e 	andeq	r4, r0, lr, lsl #16
     35c:	08000400 	stmdaeq	r0, {sl}
     360:	00000a02 	andeq	r0, r0, r2, lsl #20
     364:	00330405 	eorseq	r0, r3, r5, lsl #8
     368:	1e020000 	cdpne	0, 0, cr0, cr2, cr0, {0}
     36c:	0000c20c 	andeq	ip, r0, ip, lsl #4
     370:	06010900 	streq	r0, [r1], -r0, lsl #18
     374:	09000000 	stmdbeq	r0, {}	; <UNPREDICTABLE>
     378:	0000073a 	andeq	r0, r0, sl, lsr r7
     37c:	0a240901 	beq	902788 <__bss_end+0x8f9758>
     380:	09020000 	stmdbeq	r2, {}	; <UNPREDICTABLE>
     384:	00000b20 	andeq	r0, r0, r0, lsr #22
     388:	07200903 	streq	r0, [r0, -r3, lsl #18]!
     38c:	09040000 	stmdbeq	r4, {}	; <UNPREDICTABLE>
     390:	0000098f 	andeq	r0, r0, pc, lsl #19
     394:	ea080005 	b	2003b0 <__bss_end+0x1f7380>
     398:	05000009 	streq	r0, [r0, #-9]
     39c:	00003304 	andeq	r3, r0, r4, lsl #6
     3a0:	0c3f0200 	lfmeq	f0, 4, [pc], #-0	; 3a8 <shift+0x3a8>
     3a4:	000000ff 	strdeq	r0, [r0], -pc	; <UNPREDICTABLE>
     3a8:	0006d309 	andeq	sp, r6, r9, lsl #6
     3ac:	35090000 	strcc	r0, [r9, #-0]
     3b0:	01000007 	tsteq	r0, r7
     3b4:	000c4409 	andeq	r4, ip, r9, lsl #8
     3b8:	dc090200 	sfmle	f0, 4, [r9], {-0}
     3bc:	03000008 	movweq	r0, #8
     3c0:	00072f09 	andeq	r2, r7, r9, lsl #30
     3c4:	6d090400 	cfstrsvs	mvf0, [r9, #-0]
     3c8:	05000007 	streq	r0, [r0, #-7]
     3cc:	00062d09 	andeq	r2, r6, r9, lsl #26
     3d0:	08000600 	stmdaeq	r0, {r9, sl}
     3d4:	00000612 	andeq	r0, r0, r2, lsl r6
     3d8:	00330405 	eorseq	r0, r3, r5, lsl #8
     3dc:	66020000 	strvs	r0, [r2], -r0
     3e0:	00012a0c 	andeq	r2, r1, ip, lsl #20
     3e4:	0af90900 	beq	ffe427ec <__bss_end+0xffe397bc>
     3e8:	09000000 	stmdbeq	r0, {}	; <UNPREDICTABLE>
     3ec:	00000546 	andeq	r0, r0, r6, asr #10
     3f0:	0a480901 	beq	12027fc <__bss_end+0x11f97cc>
     3f4:	09020000 	stmdbeq	r2, {}	; <UNPREDICTABLE>
     3f8:	00000998 	muleq	r0, r8, r9
     3fc:	b00a0003 	andlt	r0, sl, r3
     400:	03000008 	movweq	r0, #8
     404:	00541405 	subseq	r1, r4, r5, lsl #8
     408:	03050000 	movweq	r0, #20480	; 0x5000
     40c:	00008f3c 	andeq	r8, r0, ip, lsr pc
     410:	000a8d0a 	andeq	r8, sl, sl, lsl #26
     414:	14060300 	strne	r0, [r6], #-768	; 0xfffffd00
     418:	00000054 	andeq	r0, r0, r4, asr r0
     41c:	8f400305 	svchi	0x00400305
     420:	820a0000 	andhi	r0, sl, #0
     424:	04000007 	streq	r0, [r0], #-7
     428:	00541a07 	subseq	r1, r4, r7, lsl #20
     42c:	03050000 	movweq	r0, #20480	; 0x5000
     430:	00008f44 	andeq	r8, r0, r4, asr #30
     434:	0009c10a 	andeq	ip, r9, sl, lsl #2
     438:	1a090400 	bne	241440 <__bss_end+0x238410>
     43c:	00000054 	andeq	r0, r0, r4, asr r0
     440:	8f480305 	svchi	0x00480305
     444:	740a0000 	strvc	r0, [sl], #-0
     448:	04000007 	streq	r0, [r0], #-7
     44c:	00541a0b 	subseq	r1, r4, fp, lsl #20
     450:	03050000 	movweq	r0, #20480	; 0x5000
     454:	00008f4c 	andeq	r8, r0, ip, asr #30
     458:	0009740a 	andeq	r7, r9, sl, lsl #8
     45c:	1a0d0400 	bne	341464 <__bss_end+0x338434>
     460:	00000054 	andeq	r0, r0, r4, asr r0
     464:	8f500305 	svchi	0x00500305
     468:	e10a0000 	mrs	r0, (UNDEF: 10)
     46c:	04000005 	streq	r0, [r0], #-5
     470:	00541a0f 	subseq	r1, r4, pc, lsl #20
     474:	03050000 	movweq	r0, #20480	; 0x5000
     478:	00008f54 	andeq	r8, r0, r4, asr pc
     47c:	0010aa08 	andseq	sl, r0, r8, lsl #20
     480:	33040500 	movwcc	r0, #17664	; 0x4500
     484:	04000000 	streq	r0, [r0], #-0
     488:	01cd0c1b 	biceq	r0, sp, fp, lsl ip
     48c:	84090000 	strhi	r0, [r9], #-0
     490:	00000005 	andeq	r0, r0, r5
     494:	000bac09 	andeq	sl, fp, r9, lsl #24
     498:	3f090100 	svccc	0x00090100
     49c:	0200000c 	andeq	r0, r0, #12
     4a0:	04590b00 	ldrbeq	r0, [r9], #-2816	; 0xfffff500
     4a4:	01020000 	mrseq	r0, (UNDEF: 2)
     4a8:	0007e602 	andeq	lr, r7, r2, lsl #12
     4ac:	cd040c00 	stcgt	12, cr0, [r4, #-0]
     4b0:	0a000001 	beq	4bc <shift+0x4bc>
     4b4:	0000059a 	muleq	r0, sl, r5
     4b8:	54140405 	ldrpl	r0, [r4], #-1029	; 0xfffffbfb
     4bc:	05000000 	streq	r0, [r0, #-0]
     4c0:	008f5803 	addeq	r5, pc, r3, lsl #16
     4c4:	0a2a0a00 	beq	a82ccc <__bss_end+0xa79c9c>
     4c8:	07050000 	streq	r0, [r5, -r0]
     4cc:	00005414 	andeq	r5, r0, r4, lsl r4
     4d0:	5c030500 	cfstr32pl	mvfx0, [r3], {-0}
     4d4:	0a00008f 	beq	718 <shift+0x718>
     4d8:	000004ea 	andeq	r0, r0, sl, ror #9
     4dc:	54140a05 	ldrpl	r0, [r4], #-2565	; 0xfffff5fb
     4e0:	05000000 	streq	r0, [r0, #-0]
     4e4:	008f6003 	addeq	r6, pc, r3
     4e8:	06320800 	ldrteq	r0, [r2], -r0, lsl #16
     4ec:	04050000 	streq	r0, [r5], #-0
     4f0:	00000033 	andeq	r0, r0, r3, lsr r0
     4f4:	4c0c0d05 	stcmi	13, cr0, [ip], {5}
     4f8:	0d000002 	stceq	0, cr0, [r0, #-8]
     4fc:	0077654e 	rsbseq	r6, r7, lr, asr #10
     500:	04c20900 	strbeq	r0, [r2], #2304	; 0x900
     504:	09010000 	stmdbeq	r1, {}	; <UNPREDICTABLE>
     508:	000004e2 	andeq	r0, r0, r2, ror #9
     50c:	064b0902 	strbeq	r0, [fp], -r2, lsl #18
     510:	09030000 	stmdbeq	r3, {}	; <UNPREDICTABLE>
     514:	00000b12 	andeq	r0, r0, r2, lsl fp
     518:	04b60904 	ldrteq	r0, [r6], #2308	; 0x904
     51c:	00050000 	andeq	r0, r5, r0
     520:	0005b306 	andeq	fp, r5, r6, lsl #6
     524:	1b051000 	blne	14452c <__bss_end+0x13b4fc>
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
     550:	09e40e08 	stmibeq	r4!, {r3, r9, sl, fp}^
     554:	20050000 	andcs	r0, r5, r0
     558:	00028b13 	andeq	r8, r2, r3, lsl fp
     55c:	02000c00 	andeq	r0, r0, #0, 24
     560:	0a6f0704 	beq	1bc2178 <__bss_end+0x1bb9148>
     564:	8b050000 	blhi	14056c <__bss_end+0x13753c>
     568:	06000002 	streq	r0, [r0], -r2
     56c:	00000713 	andeq	r0, r0, r3, lsl r7
     570:	08280570 	stmdaeq	r8!, {r4, r5, r6, r8, sl}
     574:	00000327 	andeq	r0, r0, r7, lsr #6
     578:	0006b80e 	andeq	fp, r6, lr, lsl #16
     57c:	122a0500 	eorne	r0, sl, #0, 10
     580:	0000024c 	andeq	r0, r0, ip, asr #4
     584:	69700700 	ldmdbvs	r0!, {r8, r9, sl}^
     588:	2b050064 	blcs	140720 <__bss_end+0x1376f0>
     58c:	00005912 	andeq	r5, r0, r2, lsl r9
     590:	450e1000 	strmi	r1, [lr, #-0]
     594:	0500000b 	streq	r0, [r0, #-11]
     598:	0215112c 	andseq	r1, r5, #44, 2
     59c:	0e140000 	cdpeq	0, 1, cr0, cr4, cr0, {0}
     5a0:	00000aeb 	andeq	r0, r0, fp, ror #21
     5a4:	59122d05 	ldmdbpl	r2, {r0, r2, r8, sl, fp, sp}
     5a8:	18000000 	stmdane	r0, {}	; <UNPREDICTABLE>
     5ac:	0003e90e 	andeq	lr, r3, lr, lsl #18
     5b0:	122e0500 	eorne	r0, lr, #0, 10
     5b4:	00000059 	andeq	r0, r0, r9, asr r0
     5b8:	0a170e1c 	beq	5c3e30 <__bss_end+0x5bae00>
     5bc:	2f050000 	svccs	0x00050000
     5c0:	0003270c 	andeq	r2, r3, ip, lsl #14
     5c4:	720e2000 	andvc	r2, lr, #0
     5c8:	05000004 	streq	r0, [r0, #-4]
     5cc:	00330930 	eorseq	r0, r3, r0, lsr r9
     5d0:	0e600000 	cdpeq	0, 6, cr0, cr0, cr0, {0}
     5d4:	00000676 	andeq	r0, r0, r6, ror r6
     5d8:	480e3105 	stmdami	lr, {r0, r2, r8, ip, sp}
     5dc:	64000000 	strvs	r0, [r0], #-0
     5e0:	0009310e 	andeq	r3, r9, lr, lsl #2
     5e4:	0e330500 	cfabs32eq	mvfx0, mvfx3
     5e8:	00000048 	andeq	r0, r0, r8, asr #32
     5ec:	09280e68 	stmdbeq	r8!, {r3, r5, r6, r9, sl, fp}
     5f0:	34050000 	strcc	r0, [r5], #-0
     5f4:	0000480e 	andeq	r4, r0, lr, lsl #16
     5f8:	0f006c00 	svceq	0x00006c00
     5fc:	000001d9 	ldrdeq	r0, [r0], -r9
     600:	00000337 	andeq	r0, r0, r7, lsr r3
     604:	00005910 	andeq	r5, r0, r0, lsl r9
     608:	0a000f00 	beq	4210 <shift+0x4210>
     60c:	000004d3 	ldrdeq	r0, [r0], -r3
     610:	54140a06 	ldrpl	r0, [r4], #-2566	; 0xfffff5fa
     614:	05000000 	streq	r0, [r0, #-0]
     618:	008f6403 	addeq	r6, pc, r3, lsl #8
     61c:	07bd0800 	ldreq	r0, [sp, r0, lsl #16]!
     620:	04050000 	streq	r0, [r5], #-0
     624:	00000033 	andeq	r0, r0, r3, lsr r0
     628:	680c0d06 	stmdavs	ip, {r1, r2, r8, sl, fp}
     62c:	09000003 	stmdbeq	r0, {r0, r1}
     630:	00000c4a 	andeq	r0, r0, sl, asr #24
     634:	0bc00900 	bleq	ff002a3c <__bss_end+0xfeff9a0c>
     638:	00010000 	andeq	r0, r1, r0
     63c:	0006a506 	andeq	sl, r6, r6, lsl #10
     640:	1b060c00 	blne	183648 <__bss_end+0x17a618>
     644:	00039d08 	andeq	r9, r3, r8, lsl #26
     648:	05510e00 	ldrbeq	r0, [r1, #-3584]	; 0xfffff200
     64c:	1d060000 	stcne	0, cr0, [r6, #-0]
     650:	00039d19 	andeq	r9, r3, r9, lsl sp
     654:	bd0e0000 	stclt	0, cr0, [lr, #-0]
     658:	06000004 	streq	r0, [r0], -r4
     65c:	039d191e 	orrseq	r1, sp, #491520	; 0x78000
     660:	0e040000 	cdpeq	0, 0, cr0, cr4, cr0, {0}
     664:	000007e1 	andeq	r0, r0, r1, ror #15
     668:	a3131f06 	tstge	r3, #6, 30
     66c:	08000003 	stmdaeq	r0, {r0, r1}
     670:	68040c00 	stmdavs	r4, {sl, fp}
     674:	0c000003 	stceq	0, cr0, [r0], {3}
     678:	00029704 	andeq	r9, r2, r4, lsl #14
     67c:	09d31100 	ldmibeq	r3, {r8, ip}^
     680:	06140000 	ldreq	r0, [r4], -r0
     684:	062b0722 	strteq	r0, [fp], -r2, lsr #14
     688:	be0e0000 	cdplt	0, 0, cr0, cr14, cr0, {0}
     68c:	06000008 	streq	r0, [r0], -r8
     690:	00481226 	subeq	r1, r8, r6, lsr #4
     694:	0e000000 	cdpeq	0, 0, cr0, cr0, cr0, {0}
     698:	00000860 	andeq	r0, r0, r0, ror #16
     69c:	9d1d2906 	vldrls.16	s4, [sp, #-12]	; <UNPREDICTABLE>
     6a0:	04000003 	streq	r0, [r0], #-3
     6a4:	0006530e 	andeq	r5, r6, lr, lsl #6
     6a8:	1d2c0600 	stcne	6, cr0, [ip, #-0]
     6ac:	0000039d 	muleq	r0, sp, r3
     6b0:	08d21208 	ldmeq	r2, {r3, r9, ip}^
     6b4:	2f060000 	svccs	0x00060000
     6b8:	0006820e 	andeq	r8, r6, lr, lsl #4
     6bc:	0003f100 	andeq	pc, r3, r0, lsl #2
     6c0:	0003fc00 	andeq	pc, r3, r0, lsl #24
     6c4:	06301300 	ldrteq	r1, [r0], -r0, lsl #6
     6c8:	9d140000 	ldcls	0, cr0, [r4, #-0]
     6cc:	00000003 	andeq	r0, r0, r3
     6d0:	00074415 	andeq	r4, r7, r5, lsl r4
     6d4:	0e310600 	cfmsuba32eq	mvax0, mvax0, mvfx1, mvfx0
     6d8:	000006ea 	andeq	r0, r0, sl, ror #13
     6dc:	000001d2 	ldrdeq	r0, [r0], -r2
     6e0:	00000414 	andeq	r0, r0, r4, lsl r4
     6e4:	0000041f 	andeq	r0, r0, pc, lsl r4
     6e8:	00063013 	andeq	r3, r6, r3, lsl r0
     6ec:	03a31400 			; <UNDEFINED> instruction: 0x03a31400
     6f0:	16000000 	strne	r0, [r0], -r0
     6f4:	00000b26 	andeq	r0, r0, r6, lsr #22
     6f8:	981d3506 	ldmdals	sp, {r1, r2, r8, sl, ip, sp}
     6fc:	9d000007 	stcls	0, cr0, [r0, #-28]	; 0xffffffe4
     700:	02000003 	andeq	r0, r0, #3
     704:	00000438 	andeq	r0, r0, r8, lsr r4
     708:	0000043e 	andeq	r0, r0, lr, lsr r4
     70c:	00063013 	andeq	r3, r6, r3, lsl r0
     710:	3e160000 	cdpcc	0, 1, cr0, cr6, cr0, {0}
     714:	06000006 	streq	r0, [r0], -r6
     718:	08e21d37 	stmiaeq	r2!, {r0, r1, r2, r4, r5, r8, sl, fp, ip}^
     71c:	039d0000 	orrseq	r0, sp, #0
     720:	57020000 	strpl	r0, [r2, -r0]
     724:	5d000004 	stcpl	0, cr0, [r0, #-16]
     728:	13000004 	movwne	r0, #4
     72c:	00000630 	andeq	r0, r0, r0, lsr r6
     730:	08731700 	ldmdaeq	r3!, {r8, r9, sl, ip}^
     734:	39060000 	stmdbcc	r6, {}	; <UNPREDICTABLE>
     738:	00064931 	andeq	r4, r6, r1, lsr r9
     73c:	16020c00 	strne	r0, [r2], -r0, lsl #24
     740:	000009d3 	ldrdeq	r0, [r0], -r3
     744:	53093c06 	movwpl	r3, #39942	; 0x9c06
     748:	30000007 	andcc	r0, r0, r7
     74c:	01000006 	tsteq	r0, r6
     750:	00000484 	andeq	r0, r0, r4, lsl #9
     754:	0000048a 	andeq	r0, r0, sl, lsl #9
     758:	00063013 	andeq	r3, r6, r3, lsl r0
     75c:	c4160000 	ldrgt	r0, [r6], #-0
     760:	06000006 	streq	r0, [r0], -r6
     764:	051b123f 	ldreq	r1, [fp, #-575]	; 0xfffffdc1
     768:	00480000 	subeq	r0, r8, r0
     76c:	a3010000 	movwge	r0, #4096	; 0x1000
     770:	b8000004 	stmdalt	r0, {r2}
     774:	13000004 	movwne	r0, #4
     778:	00000630 	andeq	r0, r0, r0, lsr r6
     77c:	00065214 	andeq	r5, r6, r4, lsl r2
     780:	00591400 	subseq	r1, r9, r0, lsl #8
     784:	d2140000 	andsle	r0, r4, #0
     788:	00000001 	andeq	r0, r0, r1
     78c:	000bb718 	andeq	fp, fp, r8, lsl r7
     790:	0e420600 	cdpeq	6, 4, cr0, cr2, cr0, {0}
     794:	000005c0 	andeq	r0, r0, r0, asr #11
     798:	0004cd01 	andeq	ip, r4, r1, lsl #26
     79c:	0004d300 	andeq	sp, r4, r0, lsl #6
     7a0:	06301300 	ldrteq	r1, [r0], -r0, lsl #6
     7a4:	16000000 	strne	r0, [r0], -r0
     7a8:	000004fd 	strdeq	r0, [r0], -sp
     7ac:	56174506 	ldrpl	r4, [r7], -r6, lsl #10
     7b0:	a3000005 	movwge	r0, #5
     7b4:	01000003 	tsteq	r0, r3
     7b8:	000004ec 	andeq	r0, r0, ip, ror #9
     7bc:	000004f2 	strdeq	r0, [r0], -r2
     7c0:	00065813 	andeq	r5, r6, r3, lsl r8
     7c4:	35160000 	ldrcc	r0, [r6, #-0]
     7c8:	0600000a 	streq	r0, [r0], -sl
     7cc:	03ff1748 	mvnseq	r1, #72, 14	; 0x1200000
     7d0:	03a30000 			; <UNDEFINED> instruction: 0x03a30000
     7d4:	0b010000 	bleq	407dc <__bss_end+0x377ac>
     7d8:	16000005 	strne	r0, [r0], -r5
     7dc:	13000005 	movwne	r0, #5
     7e0:	00000658 	andeq	r0, r0, r8, asr r6
     7e4:	00004814 	andeq	r4, r0, r4, lsl r8
     7e8:	eb180000 	bl	6007f0 <__bss_end+0x5f77c0>
     7ec:	06000005 	streq	r0, [r0], -r5
     7f0:	08810e4b 	stmeq	r1, {r0, r1, r3, r6, r9, sl, fp}
     7f4:	2b010000 	blcs	407fc <__bss_end+0x377cc>
     7f8:	31000005 	tstcc	r0, r5
     7fc:	13000005 	movwne	r0, #5
     800:	00000630 	andeq	r0, r0, r0, lsr r6
     804:	07441600 	strbeq	r1, [r4, -r0, lsl #12]
     808:	4d060000 	stcmi	0, cr0, [r6, #-0]
     80c:	00094c0e 	andeq	r4, r9, lr, lsl #24
     810:	0001d200 	andeq	sp, r1, r0, lsl #4
     814:	054a0100 	strbeq	r0, [sl, #-256]	; 0xffffff00
     818:	05550000 	ldrbeq	r0, [r5, #-0]
     81c:	30130000 	andscc	r0, r3, r0
     820:	14000006 	strne	r0, [r0], #-6
     824:	00000048 	andeq	r0, r0, r8, asr #32
     828:	04a21600 	strteq	r1, [r2], #1536	; 0x600
     82c:	50060000 	andpl	r0, r6, r0
     830:	00042c12 	andeq	r2, r4, r2, lsl ip
     834:	00004800 	andeq	r4, r0, r0, lsl #16
     838:	056e0100 	strbeq	r0, [lr, #-256]!	; 0xffffff00
     83c:	05790000 	ldrbeq	r0, [r9, #-0]!
     840:	30130000 	andscc	r0, r3, r0
     844:	14000006 	strne	r0, [r0], #-6
     848:	000001d9 	ldrdeq	r0, [r0], -r9
     84c:	045f1600 	ldrbeq	r1, [pc], #-1536	; 854 <shift+0x854>
     850:	53060000 	movwpl	r0, #24576	; 0x6000
     854:	000bcb0e 	andeq	ip, fp, lr, lsl #22
     858:	0001d200 	andeq	sp, r1, r0, lsl #4
     85c:	05920100 	ldreq	r0, [r2, #256]	; 0x100
     860:	059d0000 	ldreq	r0, [sp]
     864:	30130000 	andscc	r0, r3, r0
     868:	14000006 	strne	r0, [r0], #-6
     86c:	00000048 	andeq	r0, r0, r8, asr #32
     870:	047c1800 	ldrbteq	r1, [ip], #-2048	; 0xfffff800
     874:	56060000 	strpl	r0, [r6], -r0
     878:	000a990e 	andeq	r9, sl, lr, lsl #18
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
     8a4:	0bf71800 	bleq	ffdc68ac <__bss_end+0xffdbd87c>
     8a8:	58060000 	stmdapl	r6, {}	; <UNPREDICTABLE>
     8ac:	000c710e 	andeq	r7, ip, lr, lsl #2
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
     8d8:	048f1900 	streq	r1, [pc], #2304	; 8e0 <shift+0x8e0>
     8dc:	5b060000 	blpl	1808e4 <__bss_end+0x1778b4>
     8e0:	0007eb0e 	andeq	lr, r7, lr, lsl #22
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
     944:	4d1f0000 	ldcmi	0, cr0, [pc, #-0]	; 94c <shift+0x94c>
     948:	07000008 	streq	r0, [r0, -r8]
     94c:	00601907 	rsbeq	r1, r0, r7, lsl #18
     950:	b2800000 	addlt	r0, r0, #0
     954:	5f1f0ee6 	svcpl	0x001f0ee6
     958:	0700000a 	streq	r0, [r0, -sl]
     95c:	02921a0a 	addseq	r1, r2, #40960	; 0xa000
     960:	00000000 	andeq	r0, r0, r0
     964:	111f2000 	tstne	pc, r0
     968:	07000005 	streq	r0, [r0, -r5]
     96c:	02921a0d 	addseq	r1, r2, #53248	; 0xd000
     970:	00000000 	andeq	r0, r0, r0
     974:	d2202020 	eorle	r2, r0, #32
     978:	07000007 	streq	r0, [r0, -r7]
     97c:	00541510 	subseq	r1, r4, r0, lsl r5
     980:	1f360000 	svcne	0x00360000
     984:	00000b32 	andeq	r0, r0, r2, lsr fp
     988:	921a4207 	andsls	r4, sl, #1879048192	; 0x70000000
     98c:	00000002 	andeq	r0, r0, r2
     990:	1f202150 	svcne	0x00202150
     994:	00000c25 	andeq	r0, r0, r5, lsr #24
     998:	921a7107 	andsls	r7, sl, #-1073741823	; 0xc0000001
     99c:	00000002 	andeq	r0, r0, r2
     9a0:	1f2000b2 	svcne	0x002000b2
     9a4:	000006d8 	ldrdeq	r0, [r0], -r8
     9a8:	921aa407 	andsls	sl, sl, #117440512	; 0x7000000
     9ac:	00000002 	andeq	r0, r0, r2
     9b0:	1f2000b4 	svcne	0x002000b4
     9b4:	00000843 	andeq	r0, r0, r3, asr #16
     9b8:	921ab307 	andsls	fp, sl, #469762048	; 0x1c000000
     9bc:	00000002 	andeq	r0, r0, r2
     9c0:	1f201040 	svcne	0x00201040
     9c4:	00000908 	andeq	r0, r0, r8, lsl #18
     9c8:	921abe07 	andsls	fp, sl, #7, 28	; 0x70
     9cc:	00000002 	andeq	r0, r0, r2
     9d0:	1f202050 	svcne	0x00202050
     9d4:	00000623 	andeq	r0, r0, r3, lsr #12
     9d8:	921abf07 	andsls	fp, sl, #7, 30
     9dc:	00000002 	andeq	r0, r0, r2
     9e0:	1f208040 	svcne	0x00208040
     9e4:	00000b3b 	andeq	r0, r0, fp, lsr fp
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
     a2c:	00000a81 	andeq	r0, r0, r1, lsl #21
     a30:	54140808 	ldrpl	r0, [r4], #-2056	; 0xfffff7f8
     a34:	05000000 	streq	r0, [r0, #-0]
     a38:	008f9403 	addeq	r9, pc, r3, lsl #8
     a3c:	082e0800 	stmdaeq	lr!, {fp}
     a40:	04050000 	streq	r0, [r5], #-0
     a44:	00000033 	andeq	r0, r0, r3, lsr r0
     a48:	940c1d08 	strls	r1, [ip], #-3336	; 0xfffff2f8
     a4c:	09000007 	stmdbeq	r0, {r0, r1, r2}
     a50:	00000912 	andeq	r0, r0, r2, lsl r9
     a54:	093f0900 	ldmdbeq	pc!, {r8, fp}	; <UNPREDICTABLE>
     a58:	09010000 	stmdbeq	r1, {}	; <UNPREDICTABLE>
     a5c:	00000923 	andeq	r0, r0, r3, lsr #18
     a60:	6f4c0d02 	svcvs	0x004c0d02
     a64:	00030077 	andeq	r0, r3, r7, ror r0
     a68:	000c5f0a 	andeq	r5, ip, sl, lsl #30
     a6c:	14100100 	ldrne	r0, [r0], #-256	; 0xffffff00
     a70:	00000054 	andeq	r0, r0, r4, asr r0
     a74:	8f980305 	svchi	0x00980305
     a78:	660a0000 	strvs	r0, [sl], -r0
     a7c:	01000006 	tsteq	r0, r6
     a80:	00541411 	subseq	r1, r4, r1, lsl r4
     a84:	03050000 	movweq	r0, #20480	; 0x5000
     a88:	00008f9c 	muleq	r0, ip, pc	; <UNPREDICTABLE>
     a8c:	0004cb22 	andeq	ip, r4, r2, lsr #22
     a90:	0a130100 	beq	4c0e98 <__bss_end+0x4b7e68>
     a94:	00000048 	andeq	r0, r0, r8, asr #32
     a98:	90180305 	andsls	r0, r8, r5, lsl #6
     a9c:	e3220000 			; <UNDEFINED> instruction: 0xe3220000
     aa0:	01000006 	tsteq	r0, r6
     aa4:	00480a14 	subeq	r0, r8, r4, lsl sl
     aa8:	03050000 	movweq	r0, #20480	; 0x5000
     aac:	0000901c 	andeq	r9, r0, ip, lsl r0
     ab0:	000c2023 	andeq	r2, ip, r3, lsr #32
     ab4:	051d0100 	ldreq	r0, [sp, #-256]	; 0xffffff00
     ab8:	00000033 	andeq	r0, r0, r3, lsr r0
     abc:	000082ac 	andeq	r8, r0, ip, lsr #5
     ac0:	0000016c 	andeq	r0, r0, ip, ror #2
     ac4:	08339c01 	ldmdaeq	r3!, {r0, sl, fp, ip, pc}
     ac8:	1e240000 	cdpne	0, 2, cr0, cr4, cr0, {0}
     acc:	01000009 	tsteq	r0, r9
     ad0:	00330e1d 	eorseq	r0, r3, sp, lsl lr
     ad4:	91020000 	mrsls	r0, (UNDEF: 2)
     ad8:	093a246c 	ldmdbeq	sl!, {r2, r3, r5, r6, sl, sp}
     adc:	1d010000 	stcne	0, cr0, [r1, #-0]
     ae0:	0008331b 	andeq	r3, r8, fp, lsl r3
     ae4:	68910200 	ldmvs	r1, {r9}
     ae8:	0009ba25 	andeq	fp, r9, r5, lsr #20
     aec:	17220100 	strne	r0, [r2, -r0, lsl #2]!
     af0:	00000769 	andeq	r0, r0, r9, ror #14
     af4:	25709102 	ldrbcs	r9, [r0, #-258]!	; 0xfffffefe
     af8:	00000987 	andeq	r0, r0, r7, lsl #19
     afc:	480b2501 	stmdami	fp, {r0, r8, sl, sp}
     b00:	02000000 	andeq	r0, r0, #0
     b04:	0c007491 	cfstrseq	mvf7, [r0], {145}	; 0x91
     b08:	00083904 	andeq	r3, r8, r4, lsl #18
     b0c:	25040c00 	strcs	r0, [r4, #-3072]	; 0xfffff400
     b10:	26000000 	strcs	r0, [r0], -r0
     b14:	00000594 	muleq	r0, r4, r5
     b18:	c8061601 	stmdagt	r6, {r0, r9, sl, ip}
     b1c:	2c000008 	stccs	0, cr0, [r0], {8}
     b20:	80000082 	andhi	r0, r0, r2, lsl #1
     b24:	01000000 	mrseq	r0, (UNDEF: 0)
     b28:	058e249c 	streq	r2, [lr, #1180]	; 0x49c
     b2c:	16010000 	strne	r0, [r1], -r0
     b30:	0001d211 	andeq	sp, r1, r1, lsl r2
     b34:	77910200 	ldrvc	r0, [r1, r0, lsl #4]
     b38:	0b1f0000 	bleq	7c0b40 <__bss_end+0x7b7b10>
     b3c:	00040000 	andeq	r0, r4, r0
     b40:	00000433 	andeq	r0, r0, r3, lsr r4
     b44:	0fb70104 	svceq	0x00b70104
     b48:	a7040000 	strge	r0, [r4, -r0]
     b4c:	c900000e 	stmdbgt	r0, {r1, r2, r3}
     b50:	1800000c 	stmdane	r0, {r2, r3}
     b54:	5c000084 	stcpl	0, cr0, [r0], {132}	; 0x84
     b58:	98000004 	stmdals	r0, {r2}
     b5c:	02000005 	andeq	r0, r0, #5
     b60:	0b0d0801 	bleq	342b6c <__bss_end+0x339b3c>
     b64:	25030000 	strcs	r0, [r3, #-0]
     b68:	02000000 	andeq	r0, r0, #0
     b6c:	09b00502 	ldmibeq	r0!, {r1, r8, sl}
     b70:	04040000 	streq	r0, [r4], #-0
     b74:	746e6905 	strbtvc	r6, [lr], #-2309	; 0xfffff6fb
     b78:	08010200 	stmdaeq	r1, {r9}
     b7c:	00000b04 	andeq	r0, r0, r4, lsl #22
     b80:	0d070202 	sfmeq	f0, 4, [r7, #-8]
     b84:	0500000c 	streq	r0, [r0, #-12]
     b88:	00000609 	andeq	r0, r0, r9, lsl #12
     b8c:	5e070907 	vmlapl.f16	s0, s14, s14	; <UNPREDICTABLE>
     b90:	03000000 	movweq	r0, #0
     b94:	0000004d 	andeq	r0, r0, sp, asr #32
     b98:	74070402 	strvc	r0, [r7], #-1026	; 0xfffffbfe
     b9c:	0600000a 	streq	r0, [r0], -sl
     ba0:	00000cbd 			; <UNDEFINED> instruction: 0x00000cbd
     ba4:	08060208 	stmdaeq	r6, {r3, r9}
     ba8:	0000008b 	andeq	r0, r0, fp, lsl #1
     bac:	00307207 	eorseq	r7, r0, r7, lsl #4
     bb0:	4d0e0802 	stcmi	8, cr0, [lr, #-8]
     bb4:	00000000 	andeq	r0, r0, r0
     bb8:	00317207 	eorseq	r7, r1, r7, lsl #4
     bbc:	4d0e0902 	vstrmi.16	s0, [lr, #-4]	; <UNPREDICTABLE>
     bc0:	04000000 	streq	r0, [r0], #-0
     bc4:	0f410800 	svceq	0x00410800
     bc8:	04050000 	streq	r0, [r5], #-0
     bcc:	00000038 	andeq	r0, r0, r8, lsr r0
     bd0:	a90c0d02 	stmdbge	ip, {r1, r8, sl, fp}
     bd4:	09000000 	stmdbeq	r0, {}	; <UNPREDICTABLE>
     bd8:	00004b4f 	andeq	r4, r0, pc, asr #22
     bdc:	000d720a 	andeq	r7, sp, sl, lsl #4
     be0:	08000100 	stmdaeq	r0, {r8}
     be4:	00000a02 	andeq	r0, r0, r2, lsl #20
     be8:	00380405 	eorseq	r0, r8, r5, lsl #8
     bec:	1e020000 	cdpne	0, 0, cr0, cr2, cr0, {0}
     bf0:	0000e00c 	andeq	lr, r0, ip
     bf4:	06010a00 	streq	r0, [r1], -r0, lsl #20
     bf8:	0a000000 	beq	c00 <shift+0xc00>
     bfc:	0000073a 	andeq	r0, r0, sl, lsr r7
     c00:	0a240a01 	beq	90340c <__bss_end+0x8fa3dc>
     c04:	0a020000 	beq	80c0c <__bss_end+0x77bdc>
     c08:	00000b20 	andeq	r0, r0, r0, lsr #22
     c0c:	07200a03 	streq	r0, [r0, -r3, lsl #20]!
     c10:	0a040000 	beq	100c18 <__bss_end+0xf7be8>
     c14:	0000098f 	andeq	r0, r0, pc, lsl #19
     c18:	ea080005 	b	200c34 <__bss_end+0x1f7c04>
     c1c:	05000009 	streq	r0, [r0, #-9]
     c20:	00003804 	andeq	r3, r0, r4, lsl #16
     c24:	0c3f0200 	lfmeq	f0, 4, [pc], #-0	; c2c <shift+0xc2c>
     c28:	0000011d 	andeq	r0, r0, sp, lsl r1
     c2c:	0006d30a 	andeq	sp, r6, sl, lsl #6
     c30:	350a0000 	strcc	r0, [sl, #-0]
     c34:	01000007 	tsteq	r0, r7
     c38:	000c440a 	andeq	r4, ip, sl, lsl #8
     c3c:	dc0a0200 	sfmle	f0, 4, [sl], {-0}
     c40:	03000008 	movweq	r0, #8
     c44:	00072f0a 	andeq	r2, r7, sl, lsl #30
     c48:	6d0a0400 	cfstrsvs	mvf0, [sl, #-0]
     c4c:	05000007 	streq	r0, [r0, #-7]
     c50:	00062d0a 	andeq	r2, r6, sl, lsl #26
     c54:	08000600 	stmdaeq	r0, {r9, sl}
     c58:	00000612 	andeq	r0, r0, r2, lsl r6
     c5c:	00380405 	eorseq	r0, r8, r5, lsl #8
     c60:	66020000 	strvs	r0, [r2], -r0
     c64:	0001480c 	andeq	r4, r1, ip, lsl #16
     c68:	0af90a00 	beq	ffe43470 <__bss_end+0xffe3a440>
     c6c:	0a000000 	beq	c74 <shift+0xc74>
     c70:	00000546 	andeq	r0, r0, r6, asr #10
     c74:	0a480a01 	beq	1203480 <__bss_end+0x11fa450>
     c78:	0a020000 	beq	80c80 <__bss_end+0x77c50>
     c7c:	00000998 	muleq	r0, r8, r9
     c80:	b00b0003 	andlt	r0, fp, r3
     c84:	03000008 	movweq	r0, #8
     c88:	00591405 	subseq	r1, r9, r5, lsl #8
     c8c:	03050000 	movweq	r0, #20480	; 0x5000
     c90:	00008fcc 	andeq	r8, r0, ip, asr #31
     c94:	000a8d0b 	andeq	r8, sl, fp, lsl #26
     c98:	14060300 	strne	r0, [r6], #-768	; 0xfffffd00
     c9c:	00000059 	andeq	r0, r0, r9, asr r0
     ca0:	8fd00305 	svchi	0x00d00305
     ca4:	820b0000 	andhi	r0, fp, #0
     ca8:	04000007 	streq	r0, [r0], #-7
     cac:	00591a07 	subseq	r1, r9, r7, lsl #20
     cb0:	03050000 	movweq	r0, #20480	; 0x5000
     cb4:	00008fd4 	ldrdeq	r8, [r0], -r4
     cb8:	0009c10b 	andeq	ip, r9, fp, lsl #2
     cbc:	1a090400 	bne	241cc4 <__bss_end+0x238c94>
     cc0:	00000059 	andeq	r0, r0, r9, asr r0
     cc4:	8fd80305 	svchi	0x00d80305
     cc8:	740b0000 	strvc	r0, [fp], #-0
     ccc:	04000007 	streq	r0, [r0], #-7
     cd0:	00591a0b 	subseq	r1, r9, fp, lsl #20
     cd4:	03050000 	movweq	r0, #20480	; 0x5000
     cd8:	00008fdc 	ldrdeq	r8, [r0], -ip
     cdc:	0009740b 	andeq	r7, r9, fp, lsl #8
     ce0:	1a0d0400 	bne	341ce8 <__bss_end+0x338cb8>
     ce4:	00000059 	andeq	r0, r0, r9, asr r0
     ce8:	8fe00305 	svchi	0x00e00305
     cec:	e10b0000 	mrs	r0, (UNDEF: 11)
     cf0:	04000005 	streq	r0, [r0], #-5
     cf4:	00591a0f 	subseq	r1, r9, pc, lsl #20
     cf8:	03050000 	movweq	r0, #20480	; 0x5000
     cfc:	00008fe4 	andeq	r8, r0, r4, ror #31
     d00:	0010aa08 	andseq	sl, r0, r8, lsl #20
     d04:	38040500 	stmdacc	r4, {r8, sl}
     d08:	04000000 	streq	r0, [r0], #-0
     d0c:	01eb0c1b 	mvneq	r0, fp, lsl ip
     d10:	840a0000 	strhi	r0, [sl], #-0
     d14:	00000005 	andeq	r0, r0, r5
     d18:	000bac0a 	andeq	sl, fp, sl, lsl #24
     d1c:	3f0a0100 	svccc	0x000a0100
     d20:	0200000c 	andeq	r0, r0, #12
     d24:	04590c00 	ldrbeq	r0, [r9], #-3072	; 0xfffff400
     d28:	01020000 	mrseq	r0, (UNDEF: 2)
     d2c:	0007e602 	andeq	lr, r7, r2, lsl #12
     d30:	2c040d00 	stccs	13, cr0, [r4], {-0}
     d34:	0d000000 	stceq	0, cr0, [r0, #-0]
     d38:	0001eb04 	andeq	lr, r1, r4, lsl #22
     d3c:	059a0b00 	ldreq	r0, [sl, #2816]	; 0xb00
     d40:	04050000 	streq	r0, [r5], #-0
     d44:	00005914 	andeq	r5, r0, r4, lsl r9
     d48:	e8030500 	stmda	r3, {r8, sl}
     d4c:	0b00008f 	bleq	f90 <shift+0xf90>
     d50:	00000a2a 	andeq	r0, r0, sl, lsr #20
     d54:	59140705 	ldmdbpl	r4, {r0, r2, r8, r9, sl}
     d58:	05000000 	streq	r0, [r0, #-0]
     d5c:	008fec03 	addeq	lr, pc, r3, lsl #24
     d60:	04ea0b00 	strbteq	r0, [sl], #2816	; 0xb00
     d64:	0a050000 	beq	140d6c <__bss_end+0x137d3c>
     d68:	00005914 	andeq	r5, r0, r4, lsl r9
     d6c:	f0030500 			; <UNDEFINED> instruction: 0xf0030500
     d70:	0800008f 	stmdaeq	r0, {r0, r1, r2, r3, r7}
     d74:	00000632 	andeq	r0, r0, r2, lsr r6
     d78:	00380405 	eorseq	r0, r8, r5, lsl #8
     d7c:	0d050000 	stceq	0, cr0, [r5, #-0]
     d80:	0002700c 	andeq	r7, r2, ip
     d84:	654e0900 	strbvs	r0, [lr, #-2304]	; 0xfffff700
     d88:	0a000077 	beq	f6c <shift+0xf6c>
     d8c:	000004c2 	andeq	r0, r0, r2, asr #9
     d90:	04e20a01 	strbteq	r0, [r2], #2561	; 0xa01
     d94:	0a020000 	beq	80d9c <__bss_end+0x77d6c>
     d98:	0000064b 	andeq	r0, r0, fp, asr #12
     d9c:	0b120a03 	bleq	4835b0 <__bss_end+0x47a580>
     da0:	0a040000 	beq	100da8 <__bss_end+0xf7d78>
     da4:	000004b6 			; <UNDEFINED> instruction: 0x000004b6
     da8:	b3060005 	movwlt	r0, #24581	; 0x6005
     dac:	10000005 	andne	r0, r0, r5
     db0:	af081b05 	svcge	0x00081b05
     db4:	07000002 	streq	r0, [r0, -r2]
     db8:	0500726c 	streq	r7, [r0, #-620]	; 0xfffffd94
     dbc:	02af131d 	adceq	r1, pc, #1946157056	; 0x74000000
     dc0:	07000000 	streq	r0, [r0, -r0]
     dc4:	05007073 	streq	r7, [r0, #-115]	; 0xffffff8d
     dc8:	02af131e 	adceq	r1, pc, #2013265920	; 0x78000000
     dcc:	07040000 	streq	r0, [r4, -r0]
     dd0:	05006370 	streq	r6, [r0, #-880]	; 0xfffffc90
     dd4:	02af131f 	adceq	r1, pc, #2080374784	; 0x7c000000
     dd8:	0e080000 	cdpeq	0, 0, cr0, cr8, cr0, {0}
     ddc:	000009e4 	andeq	r0, r0, r4, ror #19
     de0:	af132005 	svcge	0x00132005
     de4:	0c000002 	stceq	0, cr0, [r0], {2}
     de8:	07040200 	streq	r0, [r4, -r0, lsl #4]
     dec:	00000a6f 	andeq	r0, r0, pc, ror #20
     df0:	00071306 	andeq	r1, r7, r6, lsl #6
     df4:	28057000 	stmdacs	r5, {ip, sp, lr}
     df8:	00034608 	andeq	r4, r3, r8, lsl #12
     dfc:	06b80e00 	ldrteq	r0, [r8], r0, lsl #28
     e00:	2a050000 	bcs	140e08 <__bss_end+0x137dd8>
     e04:	00027012 	andeq	r7, r2, r2, lsl r0
     e08:	70070000 	andvc	r0, r7, r0
     e0c:	05006469 	streq	r6, [r0, #-1129]	; 0xfffffb97
     e10:	005e122b 	subseq	r1, lr, fp, lsr #4
     e14:	0e100000 	cdpeq	0, 1, cr0, cr0, cr0, {0}
     e18:	00000b45 	andeq	r0, r0, r5, asr #22
     e1c:	39112c05 	ldmdbcc	r1, {r0, r2, sl, fp, sp}
     e20:	14000002 	strne	r0, [r0], #-2
     e24:	000aeb0e 	andeq	lr, sl, lr, lsl #22
     e28:	122d0500 	eorne	r0, sp, #0, 10
     e2c:	0000005e 	andeq	r0, r0, lr, asr r0
     e30:	03e90e18 	mvneq	r0, #24, 28	; 0x180
     e34:	2e050000 	cdpcs	0, 0, cr0, cr5, cr0, {0}
     e38:	00005e12 	andeq	r5, r0, r2, lsl lr
     e3c:	170e1c00 	strne	r1, [lr, -r0, lsl #24]
     e40:	0500000a 	streq	r0, [r0, #-10]
     e44:	03460c2f 	movteq	r0, #27695	; 0x6c2f
     e48:	0e200000 	cdpeq	0, 2, cr0, cr0, cr0, {0}
     e4c:	00000472 	andeq	r0, r0, r2, ror r4
     e50:	38093005 	stmdacc	r9, {r0, r2, ip, sp}
     e54:	60000000 	andvs	r0, r0, r0
     e58:	0006760e 	andeq	r7, r6, lr, lsl #12
     e5c:	0e310500 	cfabs32eq	mvfx0, mvfx1
     e60:	0000004d 	andeq	r0, r0, sp, asr #32
     e64:	09310e64 	ldmdbeq	r1!, {r2, r5, r6, r9, sl, fp}
     e68:	33050000 	movwcc	r0, #20480	; 0x5000
     e6c:	00004d0e 	andeq	r4, r0, lr, lsl #26
     e70:	280e6800 	stmdacs	lr, {fp, sp, lr}
     e74:	05000009 	streq	r0, [r0, #-9]
     e78:	004d0e34 	subeq	r0, sp, r4, lsr lr
     e7c:	006c0000 	rsbeq	r0, ip, r0
     e80:	0001fd0f 	andeq	pc, r1, pc, lsl #26
     e84:	00035600 	andeq	r5, r3, r0, lsl #12
     e88:	005e1000 	subseq	r1, lr, r0
     e8c:	000f0000 	andeq	r0, pc, r0
     e90:	0004d30b 	andeq	sp, r4, fp, lsl #6
     e94:	140a0600 	strne	r0, [sl], #-1536	; 0xfffffa00
     e98:	00000059 	andeq	r0, r0, r9, asr r0
     e9c:	8ff40305 	svchi	0x00f40305
     ea0:	bd080000 	stclt	0, cr0, [r8, #-0]
     ea4:	05000007 	streq	r0, [r0, #-7]
     ea8:	00003804 	andeq	r3, r0, r4, lsl #16
     eac:	0c0d0600 	stceq	6, cr0, [sp], {-0}
     eb0:	00000387 	andeq	r0, r0, r7, lsl #7
     eb4:	000c4a0a 	andeq	r4, ip, sl, lsl #20
     eb8:	c00a0000 	andgt	r0, sl, r0
     ebc:	0100000b 	tsteq	r0, fp
     ec0:	03680300 	cmneq	r8, #0, 6
     ec4:	39080000 	stmdbcc	r8, {}	; <UNPREDICTABLE>
     ec8:	0500000e 	streq	r0, [r0, #-14]
     ecc:	00003804 	andeq	r3, r0, r4, lsl #16
     ed0:	0c140600 	ldceq	6, cr0, [r4], {-0}
     ed4:	000003ab 	andeq	r0, r0, fp, lsr #7
     ed8:	000d1a0a 	andeq	r1, sp, sl, lsl #20
     edc:	130a0000 	movwne	r0, #40960	; 0xa000
     ee0:	0100000f 	tsteq	r0, pc
     ee4:	038c0300 	orreq	r0, ip, #0, 6
     ee8:	a5060000 	strge	r0, [r6, #-0]
     eec:	0c000006 	stceq	0, cr0, [r0], {6}
     ef0:	e5081b06 	str	r1, [r8, #-2822]	; 0xfffff4fa
     ef4:	0e000003 	cdpeq	0, 0, cr0, cr0, cr3, {0}
     ef8:	00000551 	andeq	r0, r0, r1, asr r5
     efc:	e5191d06 	ldr	r1, [r9, #-3334]	; 0xfffff2fa
     f00:	00000003 	andeq	r0, r0, r3
     f04:	0004bd0e 	andeq	fp, r4, lr, lsl #26
     f08:	191e0600 	ldmdbne	lr, {r9, sl}
     f0c:	000003e5 	andeq	r0, r0, r5, ror #7
     f10:	07e10e04 	strbeq	r0, [r1, r4, lsl #28]!
     f14:	1f060000 	svcne	0x00060000
     f18:	0003eb13 	andeq	lr, r3, r3, lsl fp
     f1c:	0d000800 	stceq	8, cr0, [r0, #-0]
     f20:	0003b004 	andeq	fp, r3, r4
     f24:	b6040d00 	strlt	r0, [r4], -r0, lsl #26
     f28:	11000002 	tstne	r0, r2
     f2c:	000009d3 	ldrdeq	r0, [r0], -r3
     f30:	07220614 			; <UNDEFINED> instruction: 0x07220614
     f34:	00000673 	andeq	r0, r0, r3, ror r6
     f38:	0008be0e 	andeq	fp, r8, lr, lsl #28
     f3c:	12260600 	eorne	r0, r6, #0, 12
     f40:	0000004d 	andeq	r0, r0, sp, asr #32
     f44:	08600e00 	stmdaeq	r0!, {r9, sl, fp}^
     f48:	29060000 	stmdbcs	r6, {}	; <UNPREDICTABLE>
     f4c:	0003e51d 	andeq	lr, r3, sp, lsl r5
     f50:	530e0400 	movwpl	r0, #58368	; 0xe400
     f54:	06000006 	streq	r0, [r0], -r6
     f58:	03e51d2c 	mvneq	r1, #44, 26	; 0xb00
     f5c:	12080000 	andne	r0, r8, #0
     f60:	000008d2 	ldrdeq	r0, [r0], -r2
     f64:	820e2f06 	andhi	r2, lr, #6, 30
     f68:	39000006 	stmdbcc	r0, {r1, r2}
     f6c:	44000004 	strmi	r0, [r0], #-4
     f70:	13000004 	movwne	r0, #4
     f74:	00000678 	andeq	r0, r0, r8, ror r6
     f78:	0003e514 	andeq	lr, r3, r4, lsl r5
     f7c:	44150000 	ldrmi	r0, [r5], #-0
     f80:	06000007 	streq	r0, [r0], -r7
     f84:	06ea0e31 			; <UNDEFINED> instruction: 0x06ea0e31
     f88:	01f00000 	mvnseq	r0, r0
     f8c:	045c0000 	ldrbeq	r0, [ip], #-0
     f90:	04670000 	strbteq	r0, [r7], #-0
     f94:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
     f98:	14000006 	strne	r0, [r0], #-6
     f9c:	000003eb 	andeq	r0, r0, fp, ror #7
     fa0:	0b261600 	bleq	9867a8 <__bss_end+0x97d778>
     fa4:	35060000 	strcc	r0, [r6, #-0]
     fa8:	0007981d 	andeq	r9, r7, sp, lsl r8
     fac:	0003e500 	andeq	lr, r3, r0, lsl #10
     fb0:	04800200 	streq	r0, [r0], #512	; 0x200
     fb4:	04860000 	streq	r0, [r6], #0
     fb8:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
     fbc:	00000006 	andeq	r0, r0, r6
     fc0:	00063e16 	andeq	r3, r6, r6, lsl lr
     fc4:	1d370600 	ldcne	6, cr0, [r7, #-0]
     fc8:	000008e2 	andeq	r0, r0, r2, ror #17
     fcc:	000003e5 	andeq	r0, r0, r5, ror #7
     fd0:	00049f02 	andeq	r9, r4, r2, lsl #30
     fd4:	0004a500 	andeq	sl, r4, r0, lsl #10
     fd8:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
     fdc:	17000000 	strne	r0, [r0, -r0]
     fe0:	00000873 	andeq	r0, r0, r3, ror r8
     fe4:	91313906 	teqls	r1, r6, lsl #18
     fe8:	0c000006 	stceq	0, cr0, [r0], {6}
     fec:	09d31602 	ldmibeq	r3, {r1, r9, sl, ip}^
     ff0:	3c060000 	stccc	0, cr0, [r6], {-0}
     ff4:	00075309 	andeq	r5, r7, r9, lsl #6
     ff8:	00067800 	andeq	r7, r6, r0, lsl #16
     ffc:	04cc0100 	strbeq	r0, [ip], #256	; 0x100
    1000:	04d20000 	ldrbeq	r0, [r2], #0
    1004:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
    1008:	00000006 	andeq	r0, r0, r6
    100c:	0006c416 	andeq	ip, r6, r6, lsl r4
    1010:	123f0600 	eorsne	r0, pc, #0, 12
    1014:	0000051b 	andeq	r0, r0, fp, lsl r5
    1018:	0000004d 	andeq	r0, r0, sp, asr #32
    101c:	0004eb01 	andeq	lr, r4, r1, lsl #22
    1020:	00050000 	andeq	r0, r5, r0
    1024:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
    1028:	9a140000 	bls	501030 <__bss_end+0x4f8000>
    102c:	14000006 	strne	r0, [r0], #-6
    1030:	0000005e 	andeq	r0, r0, lr, asr r0
    1034:	0001f014 	andeq	pc, r1, r4, lsl r0	; <UNPREDICTABLE>
    1038:	b7180000 	ldrlt	r0, [r8, -r0]
    103c:	0600000b 	streq	r0, [r0], -fp
    1040:	05c00e42 	strbeq	r0, [r0, #3650]	; 0xe42
    1044:	15010000 	strne	r0, [r1, #-0]
    1048:	1b000005 	blne	1064 <shift+0x1064>
    104c:	13000005 	movwne	r0, #5
    1050:	00000678 	andeq	r0, r0, r8, ror r6
    1054:	04fd1600 	ldrbteq	r1, [sp], #1536	; 0x600
    1058:	45060000 	strmi	r0, [r6, #-0]
    105c:	00055617 	andeq	r5, r5, r7, lsl r6
    1060:	0003eb00 	andeq	lr, r3, r0, lsl #22
    1064:	05340100 	ldreq	r0, [r4, #-256]!	; 0xffffff00
    1068:	053a0000 	ldreq	r0, [sl, #-0]!
    106c:	a0130000 	andsge	r0, r3, r0
    1070:	00000006 	andeq	r0, r0, r6
    1074:	000a3516 	andeq	r3, sl, r6, lsl r5
    1078:	17480600 	strbne	r0, [r8, -r0, lsl #12]
    107c:	000003ff 	strdeq	r0, [r0], -pc	; <UNPREDICTABLE>
    1080:	000003eb 	andeq	r0, r0, fp, ror #7
    1084:	00055301 	andeq	r5, r5, r1, lsl #6
    1088:	00055e00 	andeq	r5, r5, r0, lsl #28
    108c:	06a01300 	strteq	r1, [r0], r0, lsl #6
    1090:	4d140000 	ldcmi	0, cr0, [r4, #-0]
    1094:	00000000 	andeq	r0, r0, r0
    1098:	0005eb18 	andeq	lr, r5, r8, lsl fp
    109c:	0e4b0600 	cdpeq	6, 4, cr0, cr11, cr0, {0}
    10a0:	00000881 	andeq	r0, r0, r1, lsl #17
    10a4:	00057301 	andeq	r7, r5, r1, lsl #6
    10a8:	00057900 	andeq	r7, r5, r0, lsl #18
    10ac:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
    10b0:	16000000 	strne	r0, [r0], -r0
    10b4:	00000744 	andeq	r0, r0, r4, asr #14
    10b8:	4c0e4d06 	stcmi	13, cr4, [lr], {6}
    10bc:	f0000009 			; <UNDEFINED> instruction: 0xf0000009
    10c0:	01000001 	tsteq	r0, r1
    10c4:	00000592 	muleq	r0, r2, r5
    10c8:	0000059d 	muleq	r0, sp, r5
    10cc:	00067813 	andeq	r7, r6, r3, lsl r8
    10d0:	004d1400 	subeq	r1, sp, r0, lsl #8
    10d4:	16000000 	strne	r0, [r0], -r0
    10d8:	000004a2 	andeq	r0, r0, r2, lsr #9
    10dc:	2c125006 	ldccs	0, cr5, [r2], {6}
    10e0:	4d000004 	stcmi	0, cr0, [r0, #-16]
    10e4:	01000000 	mrseq	r0, (UNDEF: 0)
    10e8:	000005b6 			; <UNDEFINED> instruction: 0x000005b6
    10ec:	000005c1 	andeq	r0, r0, r1, asr #11
    10f0:	00067813 	andeq	r7, r6, r3, lsl r8
    10f4:	01fd1400 	mvnseq	r1, r0, lsl #8
    10f8:	16000000 	strne	r0, [r0], -r0
    10fc:	0000045f 	andeq	r0, r0, pc, asr r4
    1100:	cb0e5306 	blgt	395d20 <__bss_end+0x38ccf0>
    1104:	f000000b 			; <UNDEFINED> instruction: 0xf000000b
    1108:	01000001 	tsteq	r0, r1
    110c:	000005da 	ldrdeq	r0, [r0], -sl
    1110:	000005e5 	andeq	r0, r0, r5, ror #11
    1114:	00067813 	andeq	r7, r6, r3, lsl r8
    1118:	004d1400 	subeq	r1, sp, r0, lsl #8
    111c:	18000000 	stmdane	r0, {}	; <UNPREDICTABLE>
    1120:	0000047c 	andeq	r0, r0, ip, ror r4
    1124:	990e5606 	stmdbls	lr, {r1, r2, r9, sl, ip, lr}
    1128:	0100000a 	tsteq	r0, sl
    112c:	000005fa 	strdeq	r0, [r0], -sl
    1130:	00000619 	andeq	r0, r0, r9, lsl r6
    1134:	00067813 	andeq	r7, r6, r3, lsl r8
    1138:	00a91400 	adceq	r1, r9, r0, lsl #8
    113c:	4d140000 	ldcmi	0, cr0, [r4, #-0]
    1140:	14000000 	strne	r0, [r0], #-0
    1144:	0000004d 	andeq	r0, r0, sp, asr #32
    1148:	00004d14 	andeq	r4, r0, r4, lsl sp
    114c:	06a61400 	strteq	r1, [r6], r0, lsl #8
    1150:	18000000 	stmdane	r0, {}	; <UNPREDICTABLE>
    1154:	00000bf7 	strdeq	r0, [r0], -r7
    1158:	710e5806 	tstvc	lr, r6, lsl #16
    115c:	0100000c 	tsteq	r0, ip
    1160:	0000062e 	andeq	r0, r0, lr, lsr #12
    1164:	0000064d 	andeq	r0, r0, sp, asr #12
    1168:	00067813 	andeq	r7, r6, r3, lsl r8
    116c:	00e01400 	rsceq	r1, r0, r0, lsl #8
    1170:	4d140000 	ldcmi	0, cr0, [r4, #-0]
    1174:	14000000 	strne	r0, [r0], #-0
    1178:	0000004d 	andeq	r0, r0, sp, asr #32
    117c:	00004d14 	andeq	r4, r0, r4, lsl sp
    1180:	06a61400 	strteq	r1, [r6], r0, lsl #8
    1184:	19000000 	stmdbne	r0, {}	; <UNPREDICTABLE>
    1188:	0000048f 	andeq	r0, r0, pc, lsl #9
    118c:	eb0e5b06 	bl	397dac <__bss_end+0x38ed7c>
    1190:	f0000007 			; <UNDEFINED> instruction: 0xf0000007
    1194:	01000001 	tsteq	r0, r1
    1198:	00000662 	andeq	r0, r0, r2, ror #12
    119c:	00067813 	andeq	r7, r6, r3, lsl r8
    11a0:	03681400 	cmneq	r8, #0, 8
    11a4:	ac140000 	ldcge	0, cr0, [r4], {-0}
    11a8:	00000006 	andeq	r0, r0, r6
    11ac:	03f10300 	mvnseq	r0, #0, 6
    11b0:	040d0000 	streq	r0, [sp], #-0
    11b4:	000003f1 	strdeq	r0, [r0], -r1
    11b8:	0003e51a 	andeq	lr, r3, sl, lsl r5
    11bc:	00068b00 	andeq	r8, r6, r0, lsl #22
    11c0:	00069100 	andeq	r9, r6, r0, lsl #2
    11c4:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
    11c8:	1b000000 	blne	11d0 <shift+0x11d0>
    11cc:	000003f1 	strdeq	r0, [r0], -r1
    11d0:	0000067e 	andeq	r0, r0, lr, ror r6
    11d4:	003f040d 	eorseq	r0, pc, sp, lsl #8
    11d8:	040d0000 	streq	r0, [sp], #-0
    11dc:	00000673 	andeq	r0, r0, r3, ror r6
    11e0:	0065041c 	rsbeq	r0, r5, ip, lsl r4
    11e4:	041d0000 	ldreq	r0, [sp], #-0
    11e8:	00002c0f 	andeq	r2, r0, pc, lsl #24
    11ec:	0006be00 	andeq	fp, r6, r0, lsl #28
    11f0:	005e1000 	subseq	r1, lr, r0
    11f4:	00090000 	andeq	r0, r9, r0
    11f8:	0006ae03 	andeq	sl, r6, r3, lsl #28
    11fc:	0dbe1e00 	ldceq	14, cr1, [lr]
    1200:	a4010000 	strge	r0, [r1], #-0
    1204:	0006be0c 	andeq	fp, r6, ip, lsl #28
    1208:	f8030500 			; <UNDEFINED> instruction: 0xf8030500
    120c:	1f00008f 	svcne	0x0000008f
    1210:	0000098a 	andeq	r0, r0, sl, lsl #19
    1214:	2d0aa601 	stccs	6, cr10, [sl, #-4]
    1218:	4d00000e 	stcmi	0, cr0, [r0, #-56]	; 0xffffffc8
    121c:	c4000000 	strgt	r0, [r0], #-0
    1220:	b0000087 	andlt	r0, r0, r7, lsl #1
    1224:	01000000 	mrseq	r0, (UNDEF: 0)
    1228:	0007339c 	muleq	r7, ip, r3
    122c:	108d2000 	addne	r2, sp, r0
    1230:	a6010000 	strge	r0, [r1], -r0
    1234:	0001f71b 	andeq	pc, r1, fp, lsl r7	; <UNPREDICTABLE>
    1238:	ac910300 	ldcge	3, cr0, [r1], {0}
    123c:	0e8c207f 	mcreq	0, 4, r2, cr12, cr15, {3}
    1240:	a6010000 	strge	r0, [r1], -r0
    1244:	00004d2a 	andeq	r4, r0, sl, lsr #26
    1248:	a8910300 	ldmge	r1, {r8, r9}
    124c:	0e161e7f 	mrceq	14, 0, r1, cr6, cr15, {3}
    1250:	a8010000 	stmdage	r1, {}	; <UNPREDICTABLE>
    1254:	0007330a 	andeq	r3, r7, sl, lsl #6
    1258:	b4910300 	ldrlt	r0, [r1], #768	; 0x300
    125c:	0d2e1e7f 	stceq	14, cr1, [lr, #-508]!	; 0xfffffe04
    1260:	ac010000 	stcge	0, cr0, [r1], {-0}
    1264:	00003809 	andeq	r3, r0, r9, lsl #16
    1268:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    126c:	00250f00 	eoreq	r0, r5, r0, lsl #30
    1270:	07430000 	strbeq	r0, [r3, -r0]
    1274:	5e100000 	cdppl	0, 1, cr0, cr0, cr0, {0}
    1278:	3f000000 	svccc	0x00000000
    127c:	0e712100 	rpweqs	f2, f1, f0
    1280:	98010000 	stmdals	r1, {}	; <UNPREDICTABLE>
    1284:	000f210a 	andeq	r2, pc, sl, lsl #2
    1288:	00004d00 	andeq	r4, r0, r0, lsl #26
    128c:	00878800 	addeq	r8, r7, r0, lsl #16
    1290:	00003c00 	andeq	r3, r0, r0, lsl #24
    1294:	809c0100 	addshi	r0, ip, r0, lsl #2
    1298:	22000007 	andcs	r0, r0, #7
    129c:	00716572 	rsbseq	r6, r1, r2, ror r5
    12a0:	ab209a01 	blge	827aac <__bss_end+0x81ea7c>
    12a4:	02000003 	andeq	r0, r0, #3
    12a8:	221e7491 	andscs	r7, lr, #-1862270976	; 0x91000000
    12ac:	0100000e 	tsteq	r0, lr
    12b0:	004d0e9b 	umaaleq	r0, sp, fp, lr
    12b4:	91020000 	mrsls	r0, (UNDEF: 2)
    12b8:	95230070 	strls	r0, [r3, #-112]!	; 0xffffff90
    12bc:	0100000e 	tsteq	r0, lr
    12c0:	0d4a068f 	stcleq	6, cr0, [sl, #-572]	; 0xfffffdc4
    12c4:	874c0000 	strbhi	r0, [ip, -r0]
    12c8:	003c0000 	eorseq	r0, ip, r0
    12cc:	9c010000 	stcls	0, cr0, [r1], {-0}
    12d0:	000007b9 			; <UNDEFINED> instruction: 0x000007b9
    12d4:	000d8c20 	andeq	r8, sp, r0, lsr #24
    12d8:	218f0100 	orrcs	r0, pc, r0, lsl #2
    12dc:	0000004d 	andeq	r0, r0, sp, asr #32
    12e0:	226c9102 	rsbcs	r9, ip, #-2147483648	; 0x80000000
    12e4:	00716572 	rsbseq	r6, r1, r2, ror r5
    12e8:	ab209101 	blge	8256f4 <__bss_end+0x81c6c4>
    12ec:	02000003 	andeq	r0, r0, #3
    12f0:	21007491 			; <UNDEFINED> instruction: 0x21007491
    12f4:	00000e4e 	andeq	r0, r0, lr, asr #28
    12f8:	cf0a8301 	svcgt	0x000a8301
    12fc:	4d00000d 	stcmi	0, cr0, [r0, #-52]	; 0xffffffcc
    1300:	10000000 	andne	r0, r0, r0
    1304:	3c000087 	stccc	0, cr0, [r0], {135}	; 0x87
    1308:	01000000 	mrseq	r0, (UNDEF: 0)
    130c:	0007f69c 	muleq	r7, ip, r6
    1310:	65722200 	ldrbvs	r2, [r2, #-512]!	; 0xfffffe00
    1314:	85010071 	strhi	r0, [r1, #-113]	; 0xffffff8f
    1318:	00038720 	andeq	r8, r3, r0, lsr #14
    131c:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    1320:	000d271e 	andeq	r2, sp, lr, lsl r7
    1324:	0e860100 	rmfeqs	f0, f6, f0
    1328:	0000004d 	andeq	r0, r0, sp, asr #32
    132c:	00709102 	rsbseq	r9, r0, r2, lsl #2
    1330:	00107021 	andseq	r7, r0, r1, lsr #32
    1334:	0a770100 	beq	1dc173c <__bss_end+0x1db870c>
    1338:	00000da0 	andeq	r0, r0, r0, lsr #27
    133c:	0000004d 	andeq	r0, r0, sp, asr #32
    1340:	000086d4 	ldrdeq	r8, [r0], -r4
    1344:	0000003c 	andeq	r0, r0, ip, lsr r0
    1348:	08339c01 	ldmdaeq	r3!, {r0, sl, fp, ip, pc}
    134c:	72220000 	eorvc	r0, r2, #0
    1350:	01007165 	tsteq	r0, r5, ror #2
    1354:	03872079 	orreq	r2, r7, #121	; 0x79
    1358:	91020000 	mrsls	r0, (UNDEF: 2)
    135c:	0d271e74 	stceq	14, cr1, [r7, #-464]!	; 0xfffffe30
    1360:	7a010000 	bvc	41368 <__bss_end+0x38338>
    1364:	00004d0e 	andeq	r4, r0, lr, lsl #26
    1368:	70910200 	addsvc	r0, r1, r0, lsl #4
    136c:	0de32100 	stfeqe	f2, [r3]
    1370:	6b010000 	blvs	41378 <__bss_end+0x38348>
    1374:	000f0306 	andeq	r0, pc, r6, lsl #6
    1378:	0001f000 	andeq	pc, r1, r0
    137c:	00868000 	addeq	r8, r6, r0
    1380:	00005400 	andeq	r5, r0, r0, lsl #8
    1384:	7f9c0100 	svcvc	0x009c0100
    1388:	20000008 	andcs	r0, r0, r8
    138c:	00000e22 	andeq	r0, r0, r2, lsr #28
    1390:	4d156b01 	vldrmi	d6, [r5, #-4]
    1394:	02000000 	andeq	r0, r0, #0
    1398:	28206c91 	stmdacs	r0!, {r0, r4, r7, sl, fp, sp, lr}
    139c:	01000009 	tsteq	r0, r9
    13a0:	004d256b 	subeq	r2, sp, fp, ror #10
    13a4:	91020000 	mrsls	r0, (UNDEF: 2)
    13a8:	10681e68 	rsbne	r1, r8, r8, ror #28
    13ac:	6d010000 	stcvs	0, cr0, [r1, #-0]
    13b0:	00004d0e 	andeq	r4, r0, lr, lsl #26
    13b4:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    13b8:	0d612100 	stfeqe	f2, [r1, #-0]
    13bc:	5e010000 	cdppl	0, 0, cr0, cr1, cr0, {0}
    13c0:	000f5812 	andeq	r5, pc, r2, lsl r8	; <UNPREDICTABLE>
    13c4:	00008b00 	andeq	r8, r0, r0, lsl #22
    13c8:	00863000 	addeq	r3, r6, r0
    13cc:	00005000 	andeq	r5, r0, r0
    13d0:	da9c0100 	ble	fe7017d8 <__bss_end+0xfe6f87a8>
    13d4:	20000008 	andcs	r0, r0, r8
    13d8:	00000f0e 	andeq	r0, r0, lr, lsl #30
    13dc:	4d205e01 	stcmi	14, cr5, [r0, #-4]!
    13e0:	02000000 	andeq	r0, r0, #0
    13e4:	57206c91 			; <UNDEFINED> instruction: 0x57206c91
    13e8:	0100000e 	tsteq	r0, lr
    13ec:	004d2f5e 	subeq	r2, sp, lr, asr pc
    13f0:	91020000 	mrsls	r0, (UNDEF: 2)
    13f4:	09282068 	stmdbeq	r8!, {r3, r5, r6, sp}
    13f8:	5e010000 	cdppl	0, 0, cr0, cr1, cr0, {0}
    13fc:	00004d3f 	andeq	r4, r0, pc, lsr sp
    1400:	64910200 	ldrvs	r0, [r1], #512	; 0x200
    1404:	0010681e 	andseq	r6, r0, lr, lsl r8
    1408:	16600100 	strbtne	r0, [r0], -r0, lsl #2
    140c:	0000008b 	andeq	r0, r0, fp, lsl #1
    1410:	00749102 	rsbseq	r9, r4, r2, lsl #2
    1414:	000f8e21 	andeq	r8, pc, r1, lsr #28
    1418:	0a520100 	beq	1481820 <__bss_end+0x14787f0>
    141c:	00000d66 	andeq	r0, r0, r6, ror #26
    1420:	0000004d 	andeq	r0, r0, sp, asr #32
    1424:	000085ec 	andeq	r8, r0, ip, ror #11
    1428:	00000044 	andeq	r0, r0, r4, asr #32
    142c:	09269c01 	stmdbeq	r6!, {r0, sl, fp, ip, pc}
    1430:	0e200000 	cdpeq	0, 2, cr0, cr0, cr0, {0}
    1434:	0100000f 	tsteq	r0, pc
    1438:	004d1a52 	subeq	r1, sp, r2, asr sl
    143c:	91020000 	mrsls	r0, (UNDEF: 2)
    1440:	0e57206c 	cdpeq	0, 5, cr2, cr7, cr12, {3}
    1444:	52010000 	andpl	r0, r1, #0
    1448:	00004d29 	andeq	r4, r0, r9, lsr #26
    144c:	68910200 	ldmvs	r1, {r9}
    1450:	000f871e 	andeq	r8, pc, lr, lsl r7	; <UNPREDICTABLE>
    1454:	0e540100 	rdfeqs	f0, f4, f0
    1458:	0000004d 	andeq	r0, r0, sp, asr #32
    145c:	00749102 	rsbseq	r9, r4, r2, lsl #2
    1460:	000f8121 	andeq	r8, pc, r1, lsr #2
    1464:	0a450100 	beq	114186c <__bss_end+0x113883c>
    1468:	00000f63 	andeq	r0, r0, r3, ror #30
    146c:	0000004d 	andeq	r0, r0, sp, asr #32
    1470:	0000859c 	muleq	r0, ip, r5
    1474:	00000050 	andeq	r0, r0, r0, asr r0
    1478:	09819c01 	stmibeq	r1, {r0, sl, fp, ip, pc}
    147c:	0e200000 	cdpeq	0, 2, cr0, cr0, cr0, {0}
    1480:	0100000f 	tsteq	r0, pc
    1484:	004d1945 	subeq	r1, sp, r5, asr #18
    1488:	91020000 	mrsls	r0, (UNDEF: 2)
    148c:	0df7206c 	ldcleq	0, cr2, [r7, #432]!	; 0x1b0
    1490:	45010000 	strmi	r0, [r1, #-0]
    1494:	00011d30 	andeq	r1, r1, r0, lsr sp
    1498:	68910200 	ldmvs	r1, {r9}
    149c:	000e5d20 	andeq	r5, lr, r0, lsr #26
    14a0:	41450100 	mrsmi	r0, (UNDEF: 85)
    14a4:	000006ac 	andeq	r0, r0, ip, lsr #13
    14a8:	1e649102 	lgnnes	f1, f2
    14ac:	00001068 	andeq	r1, r0, r8, rrx
    14b0:	4d0e4701 	stcmi	7, cr4, [lr, #-4]
    14b4:	02000000 	andeq	r0, r0, #0
    14b8:	23007491 	movwcs	r7, #1169	; 0x491
    14bc:	00000d14 	andeq	r0, r0, r4, lsl sp
    14c0:	01063f01 	tsteq	r6, r1, lsl #30
    14c4:	7000000e 	andvc	r0, r0, lr
    14c8:	2c000085 	stccs	0, cr0, [r0], {133}	; 0x85
    14cc:	01000000 	mrseq	r0, (UNDEF: 0)
    14d0:	0009ab9c 	muleq	r9, ip, fp
    14d4:	0f0e2000 	svceq	0x000e2000
    14d8:	3f010000 	svccc	0x00010000
    14dc:	00004d15 	andeq	r4, r0, r5, lsl sp
    14e0:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    14e4:	0e1c2100 	mufeqe	f2, f4, f0
    14e8:	32010000 	andcc	r0, r1, #0
    14ec:	000e630a 	andeq	r6, lr, sl, lsl #6
    14f0:	00004d00 	andeq	r4, r0, r0, lsl #26
    14f4:	00852000 	addeq	r2, r5, r0
    14f8:	00005000 	andeq	r5, r0, r0
    14fc:	069c0100 	ldreq	r0, [ip], r0, lsl #2
    1500:	2000000a 	andcs	r0, r0, sl
    1504:	00000f0e 	andeq	r0, r0, lr, lsl #30
    1508:	4d193201 	lfmmi	f3, 4, [r9, #-4]
    150c:	02000000 	andeq	r0, r0, #0
    1510:	a4206c91 	strtge	r6, [r0], #-3217	; 0xfffff36f
    1514:	0100000f 	tsteq	r0, pc
    1518:	01f72b32 	mvnseq	r2, r2, lsr fp
    151c:	91020000 	mrsls	r0, (UNDEF: 2)
    1520:	0e902068 	cdpeq	0, 9, cr2, cr0, cr8, {3}
    1524:	32010000 	andcc	r0, r1, #0
    1528:	00004d3c 	andeq	r4, r0, ip, lsr sp
    152c:	64910200 	ldrvs	r0, [r1], #512	; 0x200
    1530:	000f521e 	andeq	r5, pc, lr, lsl r2	; <UNPREDICTABLE>
    1534:	0e340100 	rsfeqs	f0, f4, f0
    1538:	0000004d 	andeq	r0, r0, sp, asr #32
    153c:	00749102 	rsbseq	r9, r4, r2, lsl #2
    1540:	00109221 	andseq	r9, r0, r1, lsr #4
    1544:	0a250100 	beq	94194c <__bss_end+0x93891c>
    1548:	00000fab 	andeq	r0, r0, fp, lsr #31
    154c:	0000004d 	andeq	r0, r0, sp, asr #32
    1550:	000084d0 	ldrdeq	r8, [r0], -r0
    1554:	00000050 	andeq	r0, r0, r0, asr r0
    1558:	0a619c01 	beq	1868564 <__bss_end+0x185f534>
    155c:	0e200000 	cdpeq	0, 2, cr0, cr0, cr0, {0}
    1560:	0100000f 	tsteq	r0, pc
    1564:	004d1825 	subeq	r1, sp, r5, lsr #16
    1568:	91020000 	mrsls	r0, (UNDEF: 2)
    156c:	0fa4206c 	svceq	0x00a4206c
    1570:	25010000 	strcs	r0, [r1, #-0]
    1574:	000a672a 	andeq	r6, sl, sl, lsr #14
    1578:	68910200 	ldmvs	r1, {r9}
    157c:	000e9020 	andeq	r9, lr, r0, lsr #32
    1580:	3b250100 	blcc	941988 <__bss_end+0x938958>
    1584:	0000004d 	andeq	r0, r0, sp, asr #32
    1588:	1e649102 	lgnnes	f1, f2
    158c:	00000d33 	andeq	r0, r0, r3, lsr sp
    1590:	4d0e2701 	stcmi	7, cr2, [lr, #-4]
    1594:	02000000 	andeq	r0, r0, #0
    1598:	0d007491 	cfstrseq	mvf7, [r0, #-580]	; 0xfffffdbc
    159c:	00002504 	andeq	r2, r0, r4, lsl #10
    15a0:	0a610300 	beq	18421a8 <__bss_end+0x1839178>
    15a4:	28210000 	stmdacs	r1!, {}	; <UNPREDICTABLE>
    15a8:	0100000e 	tsteq	r0, lr
    15ac:	109e0a19 	addsne	r0, lr, r9, lsl sl
    15b0:	004d0000 	subeq	r0, sp, r0
    15b4:	848c0000 	strhi	r0, [ip], #0
    15b8:	00440000 	subeq	r0, r4, r0
    15bc:	9c010000 	stcls	0, cr0, [r1], {-0}
    15c0:	00000ab8 			; <UNDEFINED> instruction: 0x00000ab8
    15c4:	00108920 	andseq	r8, r0, r0, lsr #18
    15c8:	1b190100 	blne	6419d0 <__bss_end+0x6389a0>
    15cc:	000001f7 	strdeq	r0, [r0], -r7
    15d0:	206c9102 	rsbcs	r9, ip, r2, lsl #2
    15d4:	00000f9f 	muleq	r0, pc, pc	; <UNPREDICTABLE>
    15d8:	c6351901 	ldrtgt	r1, [r5], -r1, lsl #18
    15dc:	02000001 	andeq	r0, r0, #1
    15e0:	0e1e6891 	mrceq	8, 0, r6, cr14, cr1, {4}
    15e4:	0100000f 	tsteq	r0, pc
    15e8:	004d0e1b 	subeq	r0, sp, fp, lsl lr
    15ec:	91020000 	mrsls	r0, (UNDEF: 2)
    15f0:	80240074 	eorhi	r0, r4, r4, ror r0
    15f4:	0100000d 	tsteq	r0, sp
    15f8:	0d390614 	ldceq	6, cr0, [r9, #-80]!	; 0xffffffb0
    15fc:	84700000 	ldrbthi	r0, [r0], #-0
    1600:	001c0000 	andseq	r0, ip, r0
    1604:	9c010000 	stcls	0, cr0, [r1], {-0}
    1608:	000f9523 	andeq	r9, pc, r3, lsr #10
    160c:	060e0100 	streq	r0, [lr], -r0, lsl #2
    1610:	00000de9 	andeq	r0, r0, r9, ror #27
    1614:	00008444 	andeq	r8, r0, r4, asr #8
    1618:	0000002c 	andeq	r0, r0, ip, lsr #32
    161c:	0af89c01 	beq	ffe28628 <__bss_end+0xffe1f5f8>
    1620:	77200000 	strvc	r0, [r0, -r0]!
    1624:	0100000d 	tsteq	r0, sp
    1628:	0038140e 	eorseq	r1, r8, lr, lsl #8
    162c:	91020000 	mrsls	r0, (UNDEF: 2)
    1630:	97250074 			; <UNDEFINED> instruction: 0x97250074
    1634:	01000010 	tsteq	r0, r0, lsl r0
    1638:	0e0b0a04 	vmlaeq.f32	s0, s22, s8
    163c:	004d0000 	subeq	r0, sp, r0
    1640:	84180000 	ldrhi	r0, [r8], #-0
    1644:	002c0000 	eoreq	r0, ip, r0
    1648:	9c010000 	stcls	0, cr0, [r1], {-0}
    164c:	64697022 	strbtvs	r7, [r9], #-34	; 0xffffffde
    1650:	0e060100 	adfeqs	f0, f6, f0
    1654:	0000004d 	andeq	r0, r0, sp, asr #32
    1658:	00749102 	rsbseq	r9, r4, r2, lsl #2
    165c:	00032e00 	andeq	r2, r3, r0, lsl #28
    1660:	9c000400 	cfstrsls	mvf0, [r0], {-0}
    1664:	04000006 	streq	r0, [r0], #-6
    1668:	000fb701 	andeq	fp, pc, r1, lsl #14
    166c:	10de0400 	sbcsne	r0, lr, r0, lsl #8
    1670:	0cc90000 	stcleq	0, cr0, [r9], {0}
    1674:	88740000 	ldmdahi	r4!, {}^	; <UNPREDICTABLE>
    1678:	04b80000 	ldrteq	r0, [r8], #0
    167c:	08640000 	stmdaeq	r4!, {}^	; <UNPREDICTABLE>
    1680:	49020000 	stmdbmi	r2, {}	; <UNPREDICTABLE>
    1684:	03000000 	movweq	r0, #0
    1688:	00001147 	andeq	r1, r0, r7, asr #2
    168c:	61100501 	tstvs	r0, r1, lsl #10
    1690:	11000000 	mrsne	r0, (UNDEF: 0)
    1694:	33323130 	teqcc	r2, #48, 2
    1698:	37363534 			; <UNDEFINED> instruction: 0x37363534
    169c:	42413938 	submi	r3, r1, #56, 18	; 0xe0000
    16a0:	46454443 	strbmi	r4, [r5], -r3, asr #8
    16a4:	01040000 	mrseq	r0, (UNDEF: 4)
    16a8:	00250103 	eoreq	r0, r5, r3, lsl #2
    16ac:	74050000 	strvc	r0, [r5], #-0
    16b0:	61000000 	mrsvs	r0, (UNDEF: 0)
    16b4:	06000000 	streq	r0, [r0], -r0
    16b8:	00000066 	andeq	r0, r0, r6, rrx
    16bc:	51070010 	tstpl	r7, r0, lsl r0
    16c0:	08000000 	stmdaeq	r0, {}	; <UNPREDICTABLE>
    16c4:	0a740704 	beq	1d032dc <__bss_end+0x1cfa2ac>
    16c8:	01080000 	mrseq	r0, (UNDEF: 8)
    16cc:	000b0d08 	andeq	r0, fp, r8, lsl #26
    16d0:	006d0700 	rsbeq	r0, sp, r0, lsl #14
    16d4:	2a090000 	bcs	2416dc <__bss_end+0x2386ac>
    16d8:	0a000000 	beq	16e0 <shift+0x16e0>
    16dc:	00001176 	andeq	r1, r0, r6, ror r1
    16e0:	61066401 	tstvs	r6, r1, lsl #8
    16e4:	ac000011 	stcge	0, cr0, [r0], {17}
    16e8:	8000008c 	andhi	r0, r0, ip, lsl #1
    16ec:	01000000 	mrseq	r0, (UNDEF: 0)
    16f0:	0000fb9c 	muleq	r0, ip, fp
    16f4:	72730b00 	rsbsvc	r0, r3, #0, 22
    16f8:	64010063 	strvs	r0, [r1], #-99	; 0xffffff9d
    16fc:	0000fb19 	andeq	pc, r0, r9, lsl fp	; <UNPREDICTABLE>
    1700:	64910200 	ldrvs	r0, [r1], #512	; 0x200
    1704:	7473640b 	ldrbtvc	r6, [r3], #-1035	; 0xfffffbf5
    1708:	24640100 	strbtcs	r0, [r4], #-256	; 0xffffff00
    170c:	00000102 	andeq	r0, r0, r2, lsl #2
    1710:	0b609102 	bleq	1825b20 <__bss_end+0x181caf0>
    1714:	006d756e 	rsbeq	r7, sp, lr, ror #10
    1718:	042d6401 	strteq	r6, [sp], #-1025	; 0xfffffbff
    171c:	02000001 	andeq	r0, r0, #1
    1720:	d00c5c91 	mulle	ip, r1, ip
    1724:	01000011 	tsteq	r0, r1, lsl r0
    1728:	010b0e66 	tsteq	fp, r6, ror #28
    172c:	91020000 	mrsls	r0, (UNDEF: 2)
    1730:	11530c70 	cmpne	r3, r0, ror ip
    1734:	67010000 	strvs	r0, [r1, -r0]
    1738:	00011108 	andeq	r1, r1, r8, lsl #2
    173c:	6c910200 	lfmvs	f0, 4, [r1], {0}
    1740:	008cd40d 	addeq	sp, ip, sp, lsl #8
    1744:	00004800 	andeq	r4, r0, r0, lsl #16
    1748:	00690e00 	rsbeq	r0, r9, r0, lsl #28
    174c:	040b6901 	streq	r6, [fp], #-2305	; 0xfffff6ff
    1750:	02000001 	andeq	r0, r0, #1
    1754:	00007491 	muleq	r0, r1, r4
    1758:	0101040f 	tsteq	r1, pc, lsl #8
    175c:	11100000 	tstne	r0, r0
    1760:	05041204 	streq	r1, [r4, #-516]	; 0xfffffdfc
    1764:	00746e69 	rsbseq	r6, r4, r9, ror #28
    1768:	0074040f 	rsbseq	r0, r4, pc, lsl #8
    176c:	040f0000 	streq	r0, [pc], #-0	; 1774 <shift+0x1774>
    1770:	0000006d 	andeq	r0, r0, sp, rrx
    1774:	0010c50a 	andseq	ip, r0, sl, lsl #10
    1778:	065c0100 	ldrbeq	r0, [ip], -r0, lsl #2
    177c:	000010d2 	ldrdeq	r1, [r0], -r2
    1780:	00008c44 	andeq	r8, r0, r4, asr #24
    1784:	00000068 	andeq	r0, r0, r8, rrx
    1788:	01769c01 	cmneq	r6, r1, lsl #24
    178c:	c9130000 	ldmdbgt	r3, {}	; <UNPREDICTABLE>
    1790:	01000011 	tsteq	r0, r1, lsl r0
    1794:	0102125c 	tsteq	r2, ip, asr r2
    1798:	91020000 	mrsls	r0, (UNDEF: 2)
    179c:	10cb136c 	sbcne	r1, fp, ip, ror #6
    17a0:	5c010000 	stcpl	0, cr0, [r1], {-0}
    17a4:	0001041e 	andeq	r0, r1, lr, lsl r4
    17a8:	68910200 	ldmvs	r1, {r9}
    17ac:	6d656d0e 	stclvs	13, cr6, [r5, #-56]!	; 0xffffffc8
    17b0:	085e0100 	ldmdaeq	lr, {r8}^
    17b4:	00000111 	andeq	r0, r0, r1, lsl r1
    17b8:	0d709102 	ldfeqp	f1, [r0, #-8]!
    17bc:	00008c60 	andeq	r8, r0, r0, ror #24
    17c0:	0000003c 	andeq	r0, r0, ip, lsr r0
    17c4:	0100690e 	tsteq	r0, lr, lsl #18
    17c8:	01040b60 	tsteq	r4, r0, ror #22
    17cc:	91020000 	mrsls	r0, (UNDEF: 2)
    17d0:	14000074 	strne	r0, [r0], #-116	; 0xffffff8c
    17d4:	0000117d 	andeq	r1, r0, sp, ror r1
    17d8:	96055201 	strls	r5, [r5], -r1, lsl #4
    17dc:	04000011 	streq	r0, [r0], #-17	; 0xffffffef
    17e0:	f0000001 			; <UNDEFINED> instruction: 0xf0000001
    17e4:	5400008b 	strpl	r0, [r0], #-139	; 0xffffff75
    17e8:	01000000 	mrseq	r0, (UNDEF: 0)
    17ec:	0001af9c 	muleq	r1, ip, pc	; <UNPREDICTABLE>
    17f0:	00730b00 	rsbseq	r0, r3, r0, lsl #22
    17f4:	0b185201 	bleq	616000 <__bss_end+0x60cfd0>
    17f8:	02000001 	andeq	r0, r0, #1
    17fc:	690e6c91 	stmdbvs	lr, {r0, r4, r7, sl, fp, sp, lr}
    1800:	06540100 	ldrbeq	r0, [r4], -r0, lsl #2
    1804:	00000104 	andeq	r0, r0, r4, lsl #2
    1808:	00749102 	rsbseq	r9, r4, r2, lsl #2
    180c:	0011b914 	andseq	fp, r1, r4, lsl r9
    1810:	05420100 	strbeq	r0, [r2, #-256]	; 0xffffff00
    1814:	00001184 	andeq	r1, r0, r4, lsl #3
    1818:	00000104 	andeq	r0, r0, r4, lsl #2
    181c:	00008b44 	andeq	r8, r0, r4, asr #22
    1820:	000000ac 	andeq	r0, r0, ip, lsr #1
    1824:	02159c01 	andseq	r9, r5, #256	; 0x100
    1828:	730b0000 	movwvc	r0, #45056	; 0xb000
    182c:	42010031 	andmi	r0, r1, #49	; 0x31
    1830:	00010b19 	andeq	r0, r1, r9, lsl fp
    1834:	6c910200 	lfmvs	f0, 4, [r1], {0}
    1838:	0032730b 	eorseq	r7, r2, fp, lsl #6
    183c:	0b294201 	bleq	a52048 <__bss_end+0xa49018>
    1840:	02000001 	andeq	r0, r0, #1
    1844:	6e0b6891 	mcrvs	8, 0, r6, cr11, cr1, {4}
    1848:	01006d75 	tsteq	r0, r5, ror sp
    184c:	01043142 	tsteq	r4, r2, asr #2
    1850:	91020000 	mrsls	r0, (UNDEF: 2)
    1854:	31750e64 	cmncc	r5, r4, ror #28
    1858:	10440100 	subne	r0, r4, r0, lsl #2
    185c:	00000215 	andeq	r0, r0, r5, lsl r2
    1860:	0e779102 	expeqs	f1, f2
    1864:	01003275 	tsteq	r0, r5, ror r2
    1868:	02151444 	andseq	r1, r5, #68, 8	; 0x44000000
    186c:	91020000 	mrsls	r0, (UNDEF: 2)
    1870:	01080076 	tsteq	r8, r6, ror r0
    1874:	000b0408 	andeq	r0, fp, r8, lsl #8
    1878:	11c11400 	bicne	r1, r1, r0, lsl #8
    187c:	36010000 	strcc	r0, [r1], -r0
    1880:	0011a807 	andseq	sl, r1, r7, lsl #16
    1884:	00011100 	andeq	r1, r1, r0, lsl #2
    1888:	008a8400 	addeq	r8, sl, r0, lsl #8
    188c:	0000c000 	andeq	ip, r0, r0
    1890:	759c0100 	ldrvc	r0, [ip, #256]	; 0x100
    1894:	13000002 	movwne	r0, #2
    1898:	000010c0 	andeq	r1, r0, r0, asr #1
    189c:	11153601 	tstne	r5, r1, lsl #12
    18a0:	02000001 	andeq	r0, r0, #1
    18a4:	730b6c91 	movwvc	r6, #48273	; 0xbc91
    18a8:	01006372 	tsteq	r0, r2, ror r3
    18ac:	010b2736 	tsteq	fp, r6, lsr r7
    18b0:	91020000 	mrsls	r0, (UNDEF: 2)
    18b4:	756e0b68 	strbvc	r0, [lr, #-2920]!	; 0xfffff498
    18b8:	3601006d 	strcc	r0, [r1], -sp, rrx
    18bc:	00010430 	andeq	r0, r1, r0, lsr r4
    18c0:	64910200 	ldrvs	r0, [r1], #512	; 0x200
    18c4:	0100690e 	tsteq	r0, lr, lsl #18
    18c8:	01040638 	tsteq	r4, r8, lsr r6
    18cc:	91020000 	mrsls	r0, (UNDEF: 2)
    18d0:	a3140074 	tstge	r4, #116	; 0x74
    18d4:	01000011 	tsteq	r0, r1, lsl r0
    18d8:	113c0524 	teqne	ip, r4, lsr #10
    18dc:	01040000 	mrseq	r0, (UNDEF: 4)
    18e0:	89e80000 	stmibhi	r8!, {}^	; <UNPREDICTABLE>
    18e4:	009c0000 	addseq	r0, ip, r0
    18e8:	9c010000 	stcls	0, cr0, [r1], {-0}
    18ec:	000002b2 			; <UNDEFINED> instruction: 0x000002b2
    18f0:	0010ba13 	andseq	fp, r0, r3, lsl sl
    18f4:	16240100 	strtne	r0, [r4], -r0, lsl #2
    18f8:	0000010b 	andeq	r0, r0, fp, lsl #2
    18fc:	0c6c9102 	stfeqp	f1, [ip], #-8
    1900:	0000115a 	andeq	r1, r0, sl, asr r1
    1904:	04062601 	streq	r2, [r6], #-1537	; 0xfffff9ff
    1908:	02000001 	andeq	r0, r0, #1
    190c:	15007491 	strne	r7, [r0, #-1169]	; 0xfffffb6f
    1910:	000011d7 	ldrdeq	r1, [r0], -r7
    1914:	dc060801 	stcle	8, cr0, [r6], {1}
    1918:	74000011 	strvc	r0, [r0], #-17	; 0xffffffef
    191c:	74000088 	strvc	r0, [r0], #-136	; 0xffffff78
    1920:	01000001 	tsteq	r0, r1
    1924:	10ba139c 	umlalsne	r1, sl, ip, r3
    1928:	08010000 	stmdaeq	r1, {}	; <UNPREDICTABLE>
    192c:	00006618 	andeq	r6, r0, r8, lsl r6
    1930:	64910200 	ldrvs	r0, [r1], #512	; 0x200
    1934:	00115a13 	andseq	r5, r1, r3, lsl sl
    1938:	25080100 	strcs	r0, [r8, #-256]	; 0xffffff00
    193c:	00000111 	andeq	r0, r0, r1, lsl r1
    1940:	13609102 	cmnne	r0, #-2147483648	; 0x80000000
    1944:	00001171 	andeq	r1, r0, r1, ror r1
    1948:	663a0801 	ldrtvs	r0, [sl], -r1, lsl #16
    194c:	02000000 	andeq	r0, r0, #0
    1950:	690e5c91 	stmdbvs	lr, {r0, r4, r7, sl, fp, ip, lr}
    1954:	060a0100 	streq	r0, [sl], -r0, lsl #2
    1958:	00000104 	andeq	r0, r0, r4, lsl #2
    195c:	0d749102 	ldfeqp	f1, [r4, #-8]!
    1960:	00008940 	andeq	r8, r0, r0, asr #18
    1964:	00000098 	muleq	r0, r8, r0
    1968:	01006a0e 	tsteq	r0, lr, lsl #20
    196c:	01040b1c 	tsteq	r4, ip, lsl fp
    1970:	91020000 	mrsls	r0, (UNDEF: 2)
    1974:	89680d70 	stmdbhi	r8!, {r4, r5, r6, r8, sl, fp}^
    1978:	00600000 	rsbeq	r0, r0, r0
    197c:	630e0000 	movwvs	r0, #57344	; 0xe000
    1980:	081e0100 	ldmdaeq	lr, {r8}
    1984:	0000006d 	andeq	r0, r0, sp, rrx
    1988:	006f9102 	rsbeq	r9, pc, r2, lsl #2
    198c:	Address 0x000000000000198c is out of bounds.


Disassembly of section .debug_abbrev:

00000000 <.debug_abbrev>:
   0:	10001101 	andne	r1, r0, r1, lsl #2
   4:	12011106 	andne	r1, r1, #-2147483647	; 0x80000001
   8:	1b0e0301 	blne	380c14 <__bss_end+0x377be4>
   c:	130e250e 	movwne	r2, #58638	; 0xe50e
  10:	00000005 	andeq	r0, r0, r5
  14:	25011101 	strcs	r1, [r1, #-257]	; 0xfffffeff
  18:	030b130e 	movweq	r1, #45838	; 0xb30e
  1c:	110e1b0e 	tstne	lr, lr, lsl #22
  20:	10061201 	andne	r1, r6, r1, lsl #4
  24:	02000017 	andeq	r0, r0, #23
  28:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
  2c:	0b3b0b3a 	bleq	ec2d1c <__bss_end+0xeb9cec>
  30:	13490b39 	movtne	r0, #39737	; 0x9b39
  34:	193c193f 	ldmdbne	ip!, {r0, r1, r2, r3, r4, r5, r8, fp, ip}
  38:	24030000 	strcs	r0, [r3], #-0
  3c:	3e0b0b00 	vmlacc.f64	d0, d11, d0
  40:	000e030b 	andeq	r0, lr, fp, lsl #6
  44:	012e0400 			; <UNDEFINED> instruction: 0x012e0400
  48:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
  4c:	0b3b0b3a 	bleq	ec2d3c <__bss_end+0xeb9d0c>
  50:	01110b39 	tsteq	r1, r9, lsr fp
  54:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
  58:	01194296 			; <UNDEFINED> instruction: 0x01194296
  5c:	05000013 	streq	r0, [r0, #-19]	; 0xffffffed
  60:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
  64:	0b3b0b3a 	bleq	ec2d54 <__bss_end+0xeb9d24>
  68:	13490b39 	movtne	r0, #39737	; 0x9b39
  6c:	00001802 	andeq	r1, r0, r2, lsl #16
  70:	0b002406 	bleq	9090 <__bss_end+0x60>
  74:	030b3e0b 	movweq	r3, #48651	; 0xbe0b
  78:	07000008 	streq	r0, [r0, -r8]
  7c:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
  80:	0b3a0e03 	bleq	e83894 <__bss_end+0xe7a864>
  84:	0b390b3b 	bleq	e42d78 <__bss_end+0xe39d48>
  88:	06120111 			; <UNDEFINED> instruction: 0x06120111
  8c:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
  90:	00130119 	andseq	r0, r3, r9, lsl r1
  94:	010b0800 	tsteq	fp, r0, lsl #16
  98:	06120111 			; <UNDEFINED> instruction: 0x06120111
  9c:	34090000 	strcc	r0, [r9], #-0
  a0:	3a080300 	bcc	200ca8 <__bss_end+0x1f7c78>
  a4:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
  a8:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
  ac:	0a000018 	beq	114 <shift+0x114>
  b0:	0b0b000f 	bleq	2c00f4 <__bss_end+0x2b70c4>
  b4:	00001349 	andeq	r1, r0, r9, asr #6
  b8:	01110100 	tsteq	r1, r0, lsl #2
  bc:	0b130e25 	bleq	4c3958 <__bss_end+0x4ba928>
  c0:	0e1b0e03 	cdpeq	14, 1, cr0, cr11, cr3, {0}
  c4:	06120111 			; <UNDEFINED> instruction: 0x06120111
  c8:	00001710 	andeq	r1, r0, r0, lsl r7
  cc:	03001602 	movweq	r1, #1538	; 0x602
  d0:	3b0b3a0e 	blcc	2ce910 <__bss_end+0x2c58e0>
  d4:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
  d8:	03000013 	movweq	r0, #19
  dc:	0b0b000f 	bleq	2c0120 <__bss_end+0x2b70f0>
  e0:	00001349 	andeq	r1, r0, r9, asr #6
  e4:	00001504 	andeq	r1, r0, r4, lsl #10
  e8:	01010500 	tsteq	r1, r0, lsl #10
  ec:	13011349 	movwne	r1, #4937	; 0x1349
  f0:	21060000 	mrscs	r0, (UNDEF: 6)
  f4:	2f134900 	svccs	0x00134900
  f8:	07000006 	streq	r0, [r0, -r6]
  fc:	0b0b0024 	bleq	2c0194 <__bss_end+0x2b7164>
 100:	0e030b3e 	vmoveq.16	d3[0], r0
 104:	34080000 	strcc	r0, [r8], #-0
 108:	3a0e0300 	bcc	380d10 <__bss_end+0x377ce0>
 10c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 110:	3f13490b 	svccc	0x0013490b
 114:	00193c19 	andseq	r3, r9, r9, lsl ip
 118:	012e0900 			; <UNDEFINED> instruction: 0x012e0900
 11c:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 120:	0b3b0b3a 	bleq	ec2e10 <__bss_end+0xeb9de0>
 124:	13490b39 	movtne	r0, #39737	; 0x9b39
 128:	06120111 			; <UNDEFINED> instruction: 0x06120111
 12c:	42961840 	addsmi	r1, r6, #64, 16	; 0x400000
 130:	00130119 	andseq	r0, r3, r9, lsl r1
 134:	00340a00 	eorseq	r0, r4, r0, lsl #20
 138:	0b3a0e03 	bleq	e8394c <__bss_end+0xe7a91c>
 13c:	0b390b3b 	bleq	e42e30 <__bss_end+0xe39e00>
 140:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 144:	240b0000 	strcs	r0, [fp], #-0
 148:	3e0b0b00 	vmlacc.f64	d0, d11, d0
 14c:	0008030b 	andeq	r0, r8, fp, lsl #6
 150:	002e0c00 	eoreq	r0, lr, r0, lsl #24
 154:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 158:	0b3b0b3a 	bleq	ec2e48 <__bss_end+0xeb9e18>
 15c:	01110b39 	tsteq	r1, r9, lsr fp
 160:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 164:	00194297 	mulseq	r9, r7, r2
 168:	01390d00 	teqeq	r9, r0, lsl #26
 16c:	0b3a0e03 	bleq	e83980 <__bss_end+0xe7a950>
 170:	13010b3b 	movwne	r0, #6971	; 0x1b3b
 174:	2e0e0000 	cdpcs	0, 0, cr0, cr14, cr0, {0}
 178:	03193f01 	tsteq	r9, #1, 30
 17c:	3b0b3a0e 	blcc	2ce9bc <__bss_end+0x2c598c>
 180:	3c0b390b 			; <UNDEFINED> instruction: 0x3c0b390b
 184:	00130119 	andseq	r0, r3, r9, lsl r1
 188:	00050f00 	andeq	r0, r5, r0, lsl #30
 18c:	00001349 	andeq	r1, r0, r9, asr #6
 190:	3f012e10 	svccc	0x00012e10
 194:	3a0e0319 	bcc	380e00 <__bss_end+0x377dd0>
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
 1c0:	3a080300 	bcc	200dc8 <__bss_end+0x1f7d98>
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
 1f4:	0b0b0024 	bleq	2c028c <__bss_end+0x2b725c>
 1f8:	0e030b3e 	vmoveq.16	d3[0], r0
 1fc:	24030000 	strcs	r0, [r3], #-0
 200:	3e0b0b00 	vmlacc.f64	d0, d11, d0
 204:	0008030b 	andeq	r0, r8, fp, lsl #6
 208:	00160400 	andseq	r0, r6, r0, lsl #8
 20c:	0b3a0e03 	bleq	e83a20 <__bss_end+0xe7a9f0>
 210:	0b390b3b 	bleq	e42f04 <__bss_end+0xe39ed4>
 214:	00001349 	andeq	r1, r0, r9, asr #6
 218:	49002605 	stmdbmi	r0, {r0, r2, r9, sl, sp}
 21c:	06000013 			; <UNDEFINED> instruction: 0x06000013
 220:	0e030113 	mcreq	1, 0, r0, cr3, cr3, {0}
 224:	0b3a0b0b 	bleq	e82e58 <__bss_end+0xe79e28>
 228:	0b390b3b 	bleq	e42f1c <__bss_end+0xe39eec>
 22c:	00001301 	andeq	r1, r0, r1, lsl #6
 230:	03000d07 	movweq	r0, #3335	; 0xd07
 234:	3b0b3a08 	blcc	2cea5c <__bss_end+0x2c5a2c>
 238:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 23c:	000b3813 	andeq	r3, fp, r3, lsl r8
 240:	01040800 	tsteq	r4, r0, lsl #16
 244:	196d0e03 	stmdbne	sp!, {r0, r1, r9, sl, fp}^
 248:	0b0b0b3e 	bleq	2c2f48 <__bss_end+0x2b9f18>
 24c:	0b3a1349 	bleq	e84f78 <__bss_end+0xe7bf48>
 250:	0b390b3b 	bleq	e42f44 <__bss_end+0xe39f14>
 254:	00001301 	andeq	r1, r0, r1, lsl #6
 258:	03002809 	movweq	r2, #2057	; 0x809
 25c:	000b1c0e 	andeq	r1, fp, lr, lsl #24
 260:	00340a00 	eorseq	r0, r4, r0, lsl #20
 264:	0b3a0e03 	bleq	e83a78 <__bss_end+0xe7aa48>
 268:	0b390b3b 	bleq	e42f5c <__bss_end+0xe39f2c>
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
 294:	0b3b0b3a 	bleq	ec2f84 <__bss_end+0xeb9f54>
 298:	13490b39 	movtne	r0, #39737	; 0x9b39
 29c:	00000b38 	andeq	r0, r0, r8, lsr fp
 2a0:	4901010f 	stmdbmi	r1, {r0, r1, r2, r3, r8}
 2a4:	00130113 	andseq	r0, r3, r3, lsl r1
 2a8:	00211000 	eoreq	r1, r1, r0
 2ac:	0b2f1349 	bleq	bc4fd8 <__bss_end+0xbbbfa8>
 2b0:	02110000 	andseq	r0, r1, #0
 2b4:	0b0e0301 	bleq	380ec0 <__bss_end+0x377e90>
 2b8:	3b0b3a0b 	blcc	2ceaec <__bss_end+0x2c5abc>
 2bc:	010b390b 	tsteq	fp, fp, lsl #18
 2c0:	12000013 	andne	r0, r0, #19
 2c4:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 2c8:	0b3a0e03 	bleq	e83adc <__bss_end+0xe7aaac>
 2cc:	0b390b3b 	bleq	e42fc0 <__bss_end+0xe39f90>
 2d0:	193c0e6e 	ldmdbne	ip!, {r1, r2, r3, r5, r6, r9, sl, fp}
 2d4:	13011364 	movwne	r1, #4964	; 0x1364
 2d8:	05130000 	ldreq	r0, [r3, #-0]
 2dc:	34134900 	ldrcc	r4, [r3], #-2304	; 0xfffff700
 2e0:	14000019 	strne	r0, [r0], #-25	; 0xffffffe7
 2e4:	13490005 	movtne	r0, #36869	; 0x9005
 2e8:	2e150000 	cdpcs	0, 1, cr0, cr5, cr0, {0}
 2ec:	03193f01 	tsteq	r9, #1, 30
 2f0:	3b0b3a0e 	blcc	2ceb30 <__bss_end+0x2c5b00>
 2f4:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 2f8:	3c13490e 			; <UNDEFINED> instruction: 0x3c13490e
 2fc:	01136419 	tsteq	r3, r9, lsl r4
 300:	16000013 			; <UNDEFINED> instruction: 0x16000013
 304:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 308:	0b3a0e03 	bleq	e83b1c <__bss_end+0xe7aaec>
 30c:	0b390b3b 	bleq	e43000 <__bss_end+0xe39fd0>
 310:	13490e6e 	movtne	r0, #40558	; 0x9e6e
 314:	193c0b32 	ldmdbne	ip!, {r1, r4, r5, r8, r9, fp}
 318:	13011364 	movwne	r1, #4964	; 0x1364
 31c:	0d170000 	ldceq	0, cr0, [r7, #-0]
 320:	3a0e0300 	bcc	380f28 <__bss_end+0x377ef8>
 324:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 328:	3813490b 	ldmdacc	r3, {r0, r1, r3, r8, fp, lr}
 32c:	000b320b 	andeq	r3, fp, fp, lsl #4
 330:	012e1800 			; <UNDEFINED> instruction: 0x012e1800
 334:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 338:	0b3b0b3a 	bleq	ec3028 <__bss_end+0xeb9ff8>
 33c:	0e6e0b39 	vmoveq.8	d14[5], r0
 340:	193c0b32 	ldmdbne	ip!, {r1, r4, r5, r8, r9, fp}
 344:	13011364 	movwne	r1, #4964	; 0x1364
 348:	2e190000 	cdpcs	0, 1, cr0, cr9, cr0, {0}
 34c:	03193f01 	tsteq	r9, #1, 30
 350:	3b0b3a0e 	blcc	2ceb90 <__bss_end+0x2c5b60>
 354:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 358:	3213490e 	andscc	r4, r3, #229376	; 0x38000
 35c:	64193c0b 	ldrvs	r3, [r9], #-3083	; 0xfffff3f5
 360:	1a000013 	bne	3b4 <shift+0x3b4>
 364:	13490115 	movtne	r0, #37141	; 0x9115
 368:	13011364 	movwne	r1, #4964	; 0x1364
 36c:	1f1b0000 	svcne	0x001b0000
 370:	49131d00 	ldmdbmi	r3, {r8, sl, fp, ip}
 374:	1c000013 	stcne	0, cr0, [r0], {19}
 378:	0b0b0010 	bleq	2c03c0 <__bss_end+0x2b7390>
 37c:	00001349 	andeq	r1, r0, r9, asr #6
 380:	0b000f1d 	bleq	3ffc <shift+0x3ffc>
 384:	1e00000b 	cdpne	0, 0, cr0, cr0, cr11, {0}
 388:	08030139 	stmdaeq	r3, {r0, r3, r4, r5, r8}
 38c:	0b3b0b3a 	bleq	ec307c <__bss_end+0xeba04c>
 390:	13010b39 	movwne	r0, #6969	; 0x1b39
 394:	341f0000 	ldrcc	r0, [pc], #-0	; 39c <shift+0x39c>
 398:	3a0e0300 	bcc	380fa0 <__bss_end+0x377f70>
 39c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 3a0:	3c13490b 			; <UNDEFINED> instruction: 0x3c13490b
 3a4:	6c061c19 	stcvs	12, cr1, [r6], {25}
 3a8:	20000019 	andcs	r0, r0, r9, lsl r0
 3ac:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 3b0:	0b3b0b3a 	bleq	ec30a0 <__bss_end+0xeba070>
 3b4:	13490b39 	movtne	r0, #39737	; 0x9b39
 3b8:	0b1c193c 	bleq	7068b0 <__bss_end+0x6fd880>
 3bc:	0000196c 	andeq	r1, r0, ip, ror #18
 3c0:	47003421 	strmi	r3, [r0, -r1, lsr #8]
 3c4:	22000013 	andcs	r0, r0, #19
 3c8:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 3cc:	0b3b0b3a 	bleq	ec30bc <__bss_end+0xeba08c>
 3d0:	13490b39 	movtne	r0, #39737	; 0x9b39
 3d4:	1802193f 	stmdane	r2, {r0, r1, r2, r3, r4, r5, r8, fp, ip}
 3d8:	2e230000 	cdpcs	0, 2, cr0, cr3, cr0, {0}
 3dc:	03193f01 	tsteq	r9, #1, 30
 3e0:	3b0b3a0e 	blcc	2cec20 <__bss_end+0x2c5bf0>
 3e4:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 3e8:	12011113 	andne	r1, r1, #-1073741820	; 0xc0000004
 3ec:	96184006 	ldrls	r4, [r8], -r6
 3f0:	13011942 	movwne	r1, #6466	; 0x1942
 3f4:	05240000 	streq	r0, [r4, #-0]!
 3f8:	3a0e0300 	bcc	381000 <__bss_end+0x377fd0>
 3fc:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 400:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 404:	25000018 	strcs	r0, [r0, #-24]	; 0xffffffe8
 408:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 40c:	0b3b0b3a 	bleq	ec30fc <__bss_end+0xeba0cc>
 410:	13490b39 	movtne	r0, #39737	; 0x9b39
 414:	00001802 	andeq	r1, r0, r2, lsl #16
 418:	3f012e26 	svccc	0x00012e26
 41c:	3a0e0319 	bcc	381088 <__bss_end+0x378058>
 420:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 424:	110e6e0b 	tstne	lr, fp, lsl #28
 428:	40061201 	andmi	r1, r6, r1, lsl #4
 42c:	19429618 	stmdbne	r2, {r3, r4, r9, sl, ip, pc}^
 430:	01000000 	mrseq	r0, (UNDEF: 0)
 434:	0e250111 	mcreq	1, 1, r0, cr5, cr1, {0}
 438:	0e030b13 	vmoveq.32	d3[0], r0
 43c:	01110e1b 	tsteq	r1, fp, lsl lr
 440:	17100612 			; <UNDEFINED> instruction: 0x17100612
 444:	24020000 	strcs	r0, [r2], #-0
 448:	3e0b0b00 	vmlacc.f64	d0, d11, d0
 44c:	000e030b 	andeq	r0, lr, fp, lsl #6
 450:	00260300 	eoreq	r0, r6, r0, lsl #6
 454:	00001349 	andeq	r1, r0, r9, asr #6
 458:	0b002404 	bleq	9470 <__bss_end+0x440>
 45c:	030b3e0b 	movweq	r3, #48651	; 0xbe0b
 460:	05000008 	streq	r0, [r0, #-8]
 464:	0e030016 	mcreq	0, 0, r0, cr3, cr6, {0}
 468:	0b3b0b3a 	bleq	ec3158 <__bss_end+0xeba128>
 46c:	13490b39 	movtne	r0, #39737	; 0x9b39
 470:	13060000 	movwne	r0, #24576	; 0x6000
 474:	0b0e0301 	bleq	381080 <__bss_end+0x378050>
 478:	3b0b3a0b 	blcc	2cecac <__bss_end+0x2c5c7c>
 47c:	010b390b 	tsteq	fp, fp, lsl #18
 480:	07000013 	smladeq	r0, r3, r0, r0
 484:	0803000d 	stmdaeq	r3, {r0, r2, r3}
 488:	0b3b0b3a 	bleq	ec3178 <__bss_end+0xeba148>
 48c:	13490b39 	movtne	r0, #39737	; 0x9b39
 490:	00000b38 	andeq	r0, r0, r8, lsr fp
 494:	03010408 	movweq	r0, #5128	; 0x1408
 498:	3e196d0e 	cdpcc	13, 1, cr6, cr9, cr14, {0}
 49c:	490b0b0b 	stmdbmi	fp, {r0, r1, r3, r8, r9, fp}
 4a0:	3b0b3a13 	blcc	2cecf4 <__bss_end+0x2c5cc4>
 4a4:	010b390b 	tsteq	fp, fp, lsl #18
 4a8:	09000013 	stmdbeq	r0, {r0, r1, r4}
 4ac:	08030028 	stmdaeq	r3, {r3, r5}
 4b0:	00000b1c 	andeq	r0, r0, ip, lsl fp
 4b4:	0300280a 	movweq	r2, #2058	; 0x80a
 4b8:	000b1c0e 	andeq	r1, fp, lr, lsl #24
 4bc:	00340b00 	eorseq	r0, r4, r0, lsl #22
 4c0:	0b3a0e03 	bleq	e83cd4 <__bss_end+0xe7aca4>
 4c4:	0b390b3b 	bleq	e431b8 <__bss_end+0xe3a188>
 4c8:	196c1349 	stmdbne	ip!, {r0, r3, r6, r8, r9, ip}^
 4cc:	00001802 	andeq	r1, r0, r2, lsl #16
 4d0:	0300020c 	movweq	r0, #524	; 0x20c
 4d4:	00193c0e 	andseq	r3, r9, lr, lsl #24
 4d8:	000f0d00 	andeq	r0, pc, r0, lsl #26
 4dc:	13490b0b 	movtne	r0, #39691	; 0x9b0b
 4e0:	0d0e0000 	stceq	0, cr0, [lr, #-0]
 4e4:	3a0e0300 	bcc	3810ec <__bss_end+0x3780bc>
 4e8:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 4ec:	3813490b 	ldmdacc	r3, {r0, r1, r3, r8, fp, lr}
 4f0:	0f00000b 	svceq	0x0000000b
 4f4:	13490101 	movtne	r0, #37121	; 0x9101
 4f8:	00001301 	andeq	r1, r0, r1, lsl #6
 4fc:	49002110 	stmdbmi	r0, {r4, r8, sp}
 500:	000b2f13 	andeq	r2, fp, r3, lsl pc
 504:	01021100 	mrseq	r1, (UNDEF: 18)
 508:	0b0b0e03 	bleq	2c3d1c <__bss_end+0x2bacec>
 50c:	0b3b0b3a 	bleq	ec31fc <__bss_end+0xeba1cc>
 510:	13010b39 	movwne	r0, #6969	; 0x1b39
 514:	2e120000 	cdpcs	0, 1, cr0, cr2, cr0, {0}
 518:	03193f01 	tsteq	r9, #1, 30
 51c:	3b0b3a0e 	blcc	2ced5c <__bss_end+0x2c5d2c>
 520:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 524:	64193c0e 	ldrvs	r3, [r9], #-3086	; 0xfffff3f2
 528:	00130113 	andseq	r0, r3, r3, lsl r1
 52c:	00051300 	andeq	r1, r5, r0, lsl #6
 530:	19341349 	ldmdbne	r4!, {r0, r3, r6, r8, r9, ip}
 534:	05140000 	ldreq	r0, [r4, #-0]
 538:	00134900 	andseq	r4, r3, r0, lsl #18
 53c:	012e1500 			; <UNDEFINED> instruction: 0x012e1500
 540:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 544:	0b3b0b3a 	bleq	ec3234 <__bss_end+0xeba204>
 548:	0e6e0b39 	vmoveq.8	d14[5], r0
 54c:	193c1349 	ldmdbne	ip!, {r0, r3, r6, r8, r9, ip}
 550:	13011364 	movwne	r1, #4964	; 0x1364
 554:	2e160000 	cdpcs	0, 1, cr0, cr6, cr0, {0}
 558:	03193f01 	tsteq	r9, #1, 30
 55c:	3b0b3a0e 	blcc	2ced9c <__bss_end+0x2c5d6c>
 560:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 564:	3213490e 	andscc	r4, r3, #229376	; 0x38000
 568:	64193c0b 	ldrvs	r3, [r9], #-3083	; 0xfffff3f5
 56c:	00130113 	andseq	r0, r3, r3, lsl r1
 570:	000d1700 	andeq	r1, sp, r0, lsl #14
 574:	0b3a0e03 	bleq	e83d88 <__bss_end+0xe7ad58>
 578:	0b390b3b 	bleq	e4326c <__bss_end+0xe3a23c>
 57c:	0b381349 	bleq	e052a8 <__bss_end+0xdfc278>
 580:	00000b32 	andeq	r0, r0, r2, lsr fp
 584:	3f012e18 	svccc	0x00012e18
 588:	3a0e0319 	bcc	3811f4 <__bss_end+0x3781c4>
 58c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 590:	320e6e0b 	andcc	r6, lr, #11, 28	; 0xb0
 594:	64193c0b 	ldrvs	r3, [r9], #-3083	; 0xfffff3f5
 598:	00130113 	andseq	r0, r3, r3, lsl r1
 59c:	012e1900 			; <UNDEFINED> instruction: 0x012e1900
 5a0:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 5a4:	0b3b0b3a 	bleq	ec3294 <__bss_end+0xeba264>
 5a8:	0e6e0b39 	vmoveq.8	d14[5], r0
 5ac:	0b321349 	bleq	c852d8 <__bss_end+0xc7c2a8>
 5b0:	1364193c 	cmnne	r4, #60, 18	; 0xf0000
 5b4:	151a0000 	ldrne	r0, [sl, #-0]
 5b8:	64134901 	ldrvs	r4, [r3], #-2305	; 0xfffff6ff
 5bc:	00130113 	andseq	r0, r3, r3, lsl r1
 5c0:	001f1b00 	andseq	r1, pc, r0, lsl #22
 5c4:	1349131d 	movtne	r1, #37661	; 0x931d
 5c8:	101c0000 	andsne	r0, ip, r0
 5cc:	490b0b00 	stmdbmi	fp, {r8, r9, fp}
 5d0:	1d000013 	stcne	0, cr0, [r0, #-76]	; 0xffffffb4
 5d4:	0b0b000f 	bleq	2c0618 <__bss_end+0x2b75e8>
 5d8:	341e0000 	ldrcc	r0, [lr], #-0
 5dc:	3a0e0300 	bcc	3811e4 <__bss_end+0x3781b4>
 5e0:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 5e4:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 5e8:	1f000018 	svcne	0x00000018
 5ec:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 5f0:	0b3a0e03 	bleq	e83e04 <__bss_end+0xe7add4>
 5f4:	0b390b3b 	bleq	e432e8 <__bss_end+0xe3a2b8>
 5f8:	13490e6e 	movtne	r0, #40558	; 0x9e6e
 5fc:	06120111 			; <UNDEFINED> instruction: 0x06120111
 600:	42961840 	addsmi	r1, r6, #64, 16	; 0x400000
 604:	00130119 	andseq	r0, r3, r9, lsl r1
 608:	00052000 	andeq	r2, r5, r0
 60c:	0b3a0e03 	bleq	e83e20 <__bss_end+0xe7adf0>
 610:	0b390b3b 	bleq	e43304 <__bss_end+0xe3a2d4>
 614:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 618:	2e210000 	cdpcs	0, 2, cr0, cr1, cr0, {0}
 61c:	03193f01 	tsteq	r9, #1, 30
 620:	3b0b3a0e 	blcc	2cee60 <__bss_end+0x2c5e30>
 624:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 628:	1113490e 	tstne	r3, lr, lsl #18
 62c:	40061201 	andmi	r1, r6, r1, lsl #4
 630:	19429718 	stmdbne	r2, {r3, r4, r8, r9, sl, ip, pc}^
 634:	00001301 	andeq	r1, r0, r1, lsl #6
 638:	03003422 	movweq	r3, #1058	; 0x422
 63c:	3b0b3a08 	blcc	2cee64 <__bss_end+0x2c5e34>
 640:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 644:	00180213 	andseq	r0, r8, r3, lsl r2
 648:	012e2300 			; <UNDEFINED> instruction: 0x012e2300
 64c:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 650:	0b3b0b3a 	bleq	ec3340 <__bss_end+0xeba310>
 654:	0e6e0b39 	vmoveq.8	d14[5], r0
 658:	06120111 			; <UNDEFINED> instruction: 0x06120111
 65c:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
 660:	00130119 	andseq	r0, r3, r9, lsl r1
 664:	002e2400 	eoreq	r2, lr, r0, lsl #8
 668:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 66c:	0b3b0b3a 	bleq	ec335c <__bss_end+0xeba32c>
 670:	0e6e0b39 	vmoveq.8	d14[5], r0
 674:	06120111 			; <UNDEFINED> instruction: 0x06120111
 678:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
 67c:	25000019 	strcs	r0, [r0, #-25]	; 0xffffffe7
 680:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 684:	0b3a0e03 	bleq	e83e98 <__bss_end+0xe7ae68>
 688:	0b390b3b 	bleq	e4337c <__bss_end+0xe3a34c>
 68c:	13490e6e 	movtne	r0, #40558	; 0x9e6e
 690:	06120111 			; <UNDEFINED> instruction: 0x06120111
 694:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
 698:	00000019 	andeq	r0, r0, r9, lsl r0
 69c:	25011101 	strcs	r1, [r1, #-257]	; 0xfffffeff
 6a0:	030b130e 	movweq	r1, #45838	; 0xb30e
 6a4:	110e1b0e 	tstne	lr, lr, lsl #22
 6a8:	10061201 	andne	r1, r6, r1, lsl #4
 6ac:	02000017 	andeq	r0, r0, #23
 6b0:	13010139 	movwne	r0, #4409	; 0x1139
 6b4:	34030000 	strcc	r0, [r3], #-0
 6b8:	3a0e0300 	bcc	3812c0 <__bss_end+0x378290>
 6bc:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 6c0:	3c13490b 			; <UNDEFINED> instruction: 0x3c13490b
 6c4:	000a1c19 	andeq	r1, sl, r9, lsl ip
 6c8:	003a0400 	eorseq	r0, sl, r0, lsl #8
 6cc:	0b3b0b3a 	bleq	ec33bc <__bss_end+0xeba38c>
 6d0:	13180b39 	tstne	r8, #58368	; 0xe400
 6d4:	01050000 	mrseq	r0, (UNDEF: 5)
 6d8:	01134901 	tsteq	r3, r1, lsl #18
 6dc:	06000013 			; <UNDEFINED> instruction: 0x06000013
 6e0:	13490021 	movtne	r0, #36897	; 0x9021
 6e4:	00000b2f 	andeq	r0, r0, pc, lsr #22
 6e8:	49002607 	stmdbmi	r0, {r0, r1, r2, r9, sl, sp}
 6ec:	08000013 	stmdaeq	r0, {r0, r1, r4}
 6f0:	0b0b0024 	bleq	2c0788 <__bss_end+0x2b7758>
 6f4:	0e030b3e 	vmoveq.16	d3[0], r0
 6f8:	34090000 	strcc	r0, [r9], #-0
 6fc:	00134700 	andseq	r4, r3, r0, lsl #14
 700:	012e0a00 			; <UNDEFINED> instruction: 0x012e0a00
 704:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 708:	0b3b0b3a 	bleq	ec33f8 <__bss_end+0xeba3c8>
 70c:	0e6e0b39 	vmoveq.8	d14[5], r0
 710:	06120111 			; <UNDEFINED> instruction: 0x06120111
 714:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
 718:	00130119 	andseq	r0, r3, r9, lsl r1
 71c:	00050b00 	andeq	r0, r5, r0, lsl #22
 720:	0b3a0803 	bleq	e82734 <__bss_end+0xe79704>
 724:	0b390b3b 	bleq	e43418 <__bss_end+0xe3a3e8>
 728:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 72c:	340c0000 	strcc	r0, [ip], #-0
 730:	3a0e0300 	bcc	381338 <__bss_end+0x378308>
 734:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 738:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 73c:	0d000018 	stceq	0, cr0, [r0, #-96]	; 0xffffffa0
 740:	0111010b 	tsteq	r1, fp, lsl #2
 744:	00000612 	andeq	r0, r0, r2, lsl r6
 748:	0300340e 	movweq	r3, #1038	; 0x40e
 74c:	3b0b3a08 	blcc	2cef74 <__bss_end+0x2c5f44>
 750:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 754:	00180213 	andseq	r0, r8, r3, lsl r2
 758:	000f0f00 	andeq	r0, pc, r0, lsl #30
 75c:	13490b0b 	movtne	r0, #39691	; 0x9b0b
 760:	26100000 	ldrcs	r0, [r0], -r0
 764:	11000000 	mrsne	r0, (UNDEF: 0)
 768:	0b0b000f 	bleq	2c07ac <__bss_end+0x2b777c>
 76c:	24120000 	ldrcs	r0, [r2], #-0
 770:	3e0b0b00 	vmlacc.f64	d0, d11, d0
 774:	0008030b 	andeq	r0, r8, fp, lsl #6
 778:	00051300 	andeq	r1, r5, r0, lsl #6
 77c:	0b3a0e03 	bleq	e83f90 <__bss_end+0xe7af60>
 780:	0b390b3b 	bleq	e43474 <__bss_end+0xe3a444>
 784:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 788:	2e140000 	cdpcs	0, 1, cr0, cr4, cr0, {0}
 78c:	03193f01 	tsteq	r9, #1, 30
 790:	3b0b3a0e 	blcc	2cefd0 <__bss_end+0x2c5fa0>
 794:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 798:	1113490e 	tstne	r3, lr, lsl #18
 79c:	40061201 	andmi	r1, r6, r1, lsl #4
 7a0:	19429718 	stmdbne	r2, {r3, r4, r8, r9, sl, ip, pc}^
 7a4:	00001301 	andeq	r1, r0, r1, lsl #6
 7a8:	3f012e15 	svccc	0x00012e15
 7ac:	3a0e0319 	bcc	381418 <__bss_end+0x3783e8>
 7b0:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 7b4:	110e6e0b 	tstne	lr, fp, lsl #28
 7b8:	40061201 	andmi	r1, r6, r1, lsl #4
 7bc:	19429618 	stmdbne	r2, {r3, r4, r9, sl, ip, pc}^
 7c0:	Address 0x00000000000007c0 is out of bounds.


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
  74:	000001ec 	andeq	r0, r0, ip, ror #3
	...
  80:	0000001c 	andeq	r0, r0, ip, lsl r0
  84:	0b3a0002 	bleq	e80094 <__bss_end+0xe77064>
  88:	00040000 	andeq	r0, r4, r0
  8c:	00000000 	andeq	r0, r0, r0
  90:	00008418 	andeq	r8, r0, r8, lsl r4
  94:	0000045c 	andeq	r0, r0, ip, asr r4
	...
  a0:	0000001c 	andeq	r0, r0, ip, lsl r0
  a4:	165d0002 	ldrbne	r0, [sp], -r2
  a8:	00040000 	andeq	r0, r4, r0
  ac:	00000000 	andeq	r0, r0, r0
  b0:	00008874 	andeq	r8, r0, r4, ror r8
  b4:	000004b8 			; <UNDEFINED> instruction: 0x000004b8
	...

Disassembly of section .debug_str:

00000000 <.debug_str>:
       0:	6573552f 	ldrbvs	r5, [r3, #-1327]!	; 0xfffffad1
       4:	772f7372 			; <UNDEFINED> instruction: 0x772f7372
       8:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
       c:	2f696a72 	svccs	0x00696a72
      10:	6b736544 	blvs	1cd9528 <__bss_end+0x1cd04f8>
      14:	2f706f74 	svccs	0x00706f74
      18:	2f564146 	svccs	0x00564146
      1c:	6176614e 	cmnvs	r6, lr, asr #2
      20:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
      24:	4f2f6963 	svcmi	0x002f6963
      28:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
      2c:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
      30:	6b6c6172 	blvs	1b18600 <__bss_end+0x1b0f5d0>
      34:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
      38:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
      3c:	756f732f 	strbvc	r7, [pc, #-815]!	; fffffd15 <__bss_end+0xffff6ce5>
      40:	73656372 	cmnvc	r5, #-939524095	; 0xc8000001
      44:	6573752f 	ldrbvs	r7, [r3, #-1327]!	; 0xfffffad1
      48:	61707372 	cmnvs	r0, r2, ror r3
      4c:	632f6563 			; <UNDEFINED> instruction: 0x632f6563
      50:	2e307472 	mrccs	4, 1, r7, cr0, cr2, {3}
      54:	552f0073 	strpl	r0, [pc, #-115]!	; ffffffe9 <__bss_end+0xffff6fb9>
      58:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
      5c:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
      60:	6a726574 	bvs	1c99638 <__bss_end+0x1c90608>
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
      98:	752f7365 	strvc	r7, [pc, #-869]!	; fffffd3b <__bss_end+0xffff6d0b>
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
     12c:	6a363731 	bvs	d8ddf8 <__bss_end+0xd84dc8>
     130:	732d667a 			; <UNDEFINED> instruction: 0x732d667a
     134:	616d2d20 	cmnvs	sp, r0, lsr #26
     138:	2d206d72 	stccs	13, cr6, [r0, #-456]!	; 0xfffffe38
     13c:	6372616d 	cmnvs	r2, #1073741851	; 0x4000001b
     140:	72613d68 	rsbvc	r3, r1, #104, 26	; 0x1a00
     144:	7a36766d 	bvc	d9db00 <__bss_end+0xd94ad0>
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
     184:	6a757a61 	bvs	1d5eb10 <__bss_end+0x1d55ae0>
     188:	2f696369 	svccs	0x00696369
     18c:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
     190:	73656d65 	cmnvc	r5, #6464	; 0x1940
     194:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
     198:	6b2d616b 	blvs	b5874c <__bss_end+0xb4f71c>
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
     1e4:	2b2b4320 	blcs	ad0e6c <__bss_end+0xac7e3c>
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
     260:	2b6b7a36 	blcs	1adeb40 <__bss_end+0x1ad5b10>
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
     294:	755f6962 	ldrbvc	r6, [pc, #-2402]	; fffff93a <__bss_end+0xffff690a>
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
     324:	6b736544 	blvs	1cd983c <__bss_end+0x1cd080c>
     328:	2f706f74 	svccs	0x00706f74
     32c:	2f564146 	svccs	0x00564146
     330:	6176614e 	cmnvs	r6, lr, asr #2
     334:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
     338:	4f2f6963 	svcmi	0x002f6963
     33c:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
     340:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
     344:	6b6c6172 	blvs	1b18914 <__bss_end+0x1b0f8e4>
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
     47c:	646e6148 	strbtvs	r6, [lr], #-328	; 0xfffffeb8
     480:	505f656c 	subspl	r6, pc, ip, ror #10
     484:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     488:	535f7373 	cmppl	pc, #-872415231	; 0xcc000001
     48c:	47004957 	smlsdmi	r0, r7, r9, r4
     490:	535f7465 	cmppl	pc, #1694498816	; 0x65000000
     494:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     498:	72656c75 	rsbvc	r6, r5, #29952	; 0x7500
     49c:	666e495f 			; <UNDEFINED> instruction: 0x666e495f
     4a0:	614d006f 	cmpvs	sp, pc, rrx
     4a4:	69465f70 	stmdbvs	r6, {r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     4a8:	545f656c 	ldrbpl	r6, [pc], #-1388	; 4b0 <shift+0x4b0>
     4ac:	75435f6f 	strbvc	r5, [r3, #-3951]	; 0xfffff091
     4b0:	6e657272 	mcrvs	2, 3, r7, cr5, cr2, {3}
     4b4:	6f5a0074 	svcvs	0x005a0074
     4b8:	6569626d 	strbvs	r6, [r9, #-621]!	; 0xfffffd93
     4bc:	78656e00 	stmdavc	r5!, {r9, sl, fp, sp, lr}^
     4c0:	75520074 	ldrbvc	r0, [r2, #-116]	; 0xffffff8c
     4c4:	62616e6e 	rsbvs	r6, r1, #1760	; 0x6e0
     4c8:	7300656c 	movwvc	r6, #1388	; 0x56c
     4cc:	6c5f736f 	mrrcvs	3, 6, r7, pc, cr15	; <UNPREDICTABLE>
     4d0:	49006465 	stmdbmi	r0, {r0, r2, r5, r6, sl, sp, lr}
     4d4:	6c61766e 	stclvs	6, cr7, [r1], #-440	; 0xfffffe48
     4d8:	485f6469 	ldmdami	pc, {r0, r3, r5, r6, sl, sp, lr}^	; <UNPREDICTABLE>
     4dc:	6c646e61 	stclvs	14, cr6, [r4], #-388	; 0xfffffe7c
     4e0:	75520065 	ldrbvc	r0, [r2, #-101]	; 0xffffff9b
     4e4:	6e696e6e 	cdpvs	14, 6, cr6, cr9, cr14, {3}
     4e8:	65440067 	strbvs	r0, [r4, #-103]	; 0xffffff99
     4ec:	696c6461 	stmdbvs	ip!, {r0, r5, r6, sl, sp, lr}^
     4f0:	555f656e 	ldrbpl	r6, [pc, #-1390]	; ffffff8a <__bss_end+0xffff6f5a>
     4f4:	6168636e 	cmnvs	r8, lr, ror #6
     4f8:	6465676e 	strbtvs	r6, [r5], #-1902	; 0xfffff892
     4fc:	74654700 	strbtvc	r4, [r5], #-1792	; 0xfffff900
     500:	7275435f 	rsbsvc	r4, r5, #2080374785	; 0x7c000001
     504:	746e6572 	strbtvc	r6, [lr], #-1394	; 0xfffffa8e
     508:	6f72505f 	svcvs	0x0072505f
     50c:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     510:	49504700 	ldmdbmi	r0, {r8, r9, sl, lr}^
     514:	61425f4f 	cmpvs	r2, pc, asr #30
     518:	5f006573 	svcpl	0x00006573
     51c:	36314e5a 			; <UNDEFINED> instruction: 0x36314e5a
     520:	6f725043 	svcvs	0x00725043
     524:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     528:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     52c:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     530:	72433431 	subvc	r3, r3, #822083584	; 0x31000000
     534:	65746165 	ldrbvs	r6, [r4, #-357]!	; 0xfffffe9b
     538:	6f72505f 	svcvs	0x0072505f
     53c:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     540:	6a685045 	bvs	1a1465c <__bss_end+0x1a0b62c>
     544:	65530062 	ldrbvs	r0, [r3, #-98]	; 0xffffff9e
     548:	61505f74 	cmpvs	r0, r4, ror pc
     54c:	736d6172 	cmnvc	sp, #-2147483620	; 0x8000001c
     550:	65727000 	ldrbvs	r7, [r2, #-0]!
     554:	5a5f0076 	bpl	17c0734 <__bss_end+0x17b7704>
     558:	36314b4e 	ldrtcc	r4, [r1], -lr, asr #22
     55c:	6f725043 	svcvs	0x00725043
     560:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     564:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     568:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     56c:	65473931 	strbvs	r3, [r7, #-2353]	; 0xfffff6cf
     570:	75435f74 	strbvc	r5, [r3, #-3956]	; 0xfffff08c
     574:	6e657272 	mcrvs	2, 3, r7, cr5, cr2, {3}
     578:	72505f74 	subsvc	r5, r0, #116, 30	; 0x1d0
     57c:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     580:	00764573 	rsbseq	r4, r6, r3, ror r5
     584:	64616552 	strbtvs	r6, [r1], #-1362	; 0xfffffaae
     588:	6c6e4f5f 	stclvs	15, cr4, [lr], #-380	; 0xfffffe84
     58c:	68730079 	ldmdavs	r3!, {r0, r3, r4, r5, r6}^
     590:	5f74726f 	svcpl	0x0074726f
     594:	6e696c62 	cdpvs	12, 6, cr6, cr9, cr2, {3}
     598:	614d006b 	cmpvs	sp, fp, rrx
     59c:	72505f78 	subsvc	r5, r0, #120, 30	; 0x1e0
     5a0:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     5a4:	704f5f73 	subvc	r5, pc, r3, ror pc	; <UNPREDICTABLE>
     5a8:	64656e65 	strbtvs	r6, [r5], #-3685	; 0xfffff19b
     5ac:	6c69465f 	stclvs	6, cr4, [r9], #-380	; 0xfffffe84
     5b0:	54007365 	strpl	r7, [r0], #-869	; 0xfffffc9b
     5b4:	5f555043 	svcpl	0x00555043
     5b8:	746e6f43 	strbtvc	r6, [lr], #-3907	; 0xfffff0bd
     5bc:	00747865 	rsbseq	r7, r4, r5, ror #16
     5c0:	314e5a5f 	cmpcc	lr, pc, asr sl
     5c4:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     5c8:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     5cc:	614d5f73 	hvcvs	54771	; 0xd5f3
     5d0:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     5d4:	63533872 	cmpvs	r3, #7471104	; 0x720000
     5d8:	75646568 	strbvc	r6, [r4, #-1384]!	; 0xfffffa98
     5dc:	7645656c 	strbvc	r6, [r5], -ip, ror #10
     5e0:	746f4e00 	strbtvc	r4, [pc], #-3584	; 5e8 <shift+0x5e8>
     5e4:	41796669 	cmnmi	r9, r9, ror #12
     5e8:	42006c6c 	andmi	r6, r0, #108, 24	; 0x6c00
     5ec:	6b636f6c 	blvs	18dc3a4 <__bss_end+0x18d3374>
     5f0:	7275435f 	rsbsvc	r4, r5, #2080374785	; 0x7c000001
     5f4:	746e6572 	strbtvc	r6, [lr], #-1394	; 0xfffffa8e
     5f8:	6f72505f 	svcvs	0x0072505f
     5fc:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     600:	74654700 	strbtvc	r4, [r5], #-1792	; 0xfffff900
     604:	4449505f 	strbmi	r5, [r9], #-95	; 0xffffffa1
     608:	6e697500 	cdpvs	5, 6, cr7, cr9, cr0, {0}
     60c:	5f323374 	svcpl	0x00323374
     610:	494e0074 	stmdbmi	lr, {r2, r4, r5, r6}^
     614:	6c74434f 	ldclvs	3, cr4, [r4], #-316	; 0xfffffec4
     618:	65704f5f 	ldrbvs	r4, [r0, #-3935]!	; 0xfffff0a1
     61c:	69746172 	ldmdbvs	r4!, {r1, r4, r5, r6, r8, sp, lr}^
     620:	42006e6f 	andmi	r6, r0, #1776	; 0x6f0
     624:	5f314353 	svcpl	0x00314353
     628:	65736142 	ldrbvs	r6, [r3, #-322]!	; 0xfffffebe
     62c:	69615700 	stmdbvs	r1!, {r8, r9, sl, ip, lr}^
     630:	544e0074 	strbpl	r0, [lr], #-116	; 0xffffff8c
     634:	5f6b7361 	svcpl	0x006b7361
     638:	74617453 	strbtvc	r7, [r1], #-1107	; 0xfffffbad
     63c:	63530065 	cmpvs	r3, #101	; 0x65
     640:	75646568 	strbvc	r6, [r4, #-1384]!	; 0xfffffa98
     644:	455f656c 	ldrbmi	r6, [pc, #-1388]	; e0 <shift+0xe0>
     648:	42004644 	andmi	r4, r0, #68, 12	; 0x4400000
     64c:	6b636f6c 	blvs	18dc404 <__bss_end+0x18d33d4>
     650:	6d006465 	cfstrsvs	mvf6, [r0, #-404]	; 0xfffffe6c
     654:	72727543 	rsbsvc	r7, r2, #281018368	; 0x10c00000
     658:	5f746e65 	svcpl	0x00746e65
     65c:	6b736154 	blvs	1cd8bb4 <__bss_end+0x1ccfb84>
     660:	646f4e5f 	strbtvs	r4, [pc], #-3679	; 668 <shift+0x668>
     664:	68630065 	stmdavs	r3!, {r0, r2, r5, r6}^
     668:	745f7261 	ldrbvc	r7, [pc], #-609	; 670 <shift+0x670>
     66c:	5f6b6369 	svcpl	0x006b6369
     670:	616c6564 	cmnvs	ip, r4, ror #10
     674:	6c730079 	ldclvs	0, cr0, [r3], #-484	; 0xfffffe1c
     678:	5f706565 	svcpl	0x00706565
     67c:	656d6974 	strbvs	r6, [sp, #-2420]!	; 0xfffff68c
     680:	5a5f0072 	bpl	17c0850 <__bss_end+0x17b7820>
     684:	4336314e 	teqmi	r6, #-2147483629	; 0x80000013
     688:	636f7250 	cmnvs	pc, #80, 4
     68c:	5f737365 	svcpl	0x00737365
     690:	616e614d 	cmnvs	lr, sp, asr #2
     694:	39726567 	ldmdbcc	r2!, {r0, r1, r2, r5, r6, r8, sl, sp, lr}^
     698:	74697753 	strbtvc	r7, [r9], #-1875	; 0xfffff8ad
     69c:	545f6863 	ldrbpl	r6, [pc], #-2147	; 6a4 <shift+0x6a4>
     6a0:	3150456f 	cmpcc	r0, pc, ror #10
     6a4:	72504338 	subsvc	r4, r0, #56, 6	; 0xe0000000
     6a8:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     6ac:	694c5f73 	stmdbvs	ip, {r0, r1, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     6b0:	4e5f7473 	mrcmi	4, 2, r7, cr15, cr3, {3}
     6b4:	0065646f 	rsbeq	r6, r5, pc, ror #8
     6b8:	5f757063 	svcpl	0x00757063
     6bc:	746e6f63 	strbtvc	r6, [lr], #-3939	; 0xfffff09d
     6c0:	00747865 	rsbseq	r7, r4, r5, ror #16
     6c4:	61657243 	cmnvs	r5, r3, asr #4
     6c8:	505f6574 	subspl	r6, pc, r4, ror r5	; <UNPREDICTABLE>
     6cc:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     6d0:	4f007373 	svcmi	0x00007373
     6d4:	006e6570 	rsbeq	r6, lr, r0, ror r5
     6d8:	656d6954 	strbvs	r6, [sp, #-2388]!	; 0xfffff6ac
     6dc:	61425f72 	hvcvs	9714	; 0x25f2
     6e0:	62006573 	andvs	r6, r0, #482344960	; 0x1cc00000
     6e4:	6f747475 	svcvs	0x00747475
     6e8:	5a5f006e 	bpl	17c08a8 <__bss_end+0x17b7878>
     6ec:	4336314e 	teqmi	r6, #-2147483629	; 0x80000013
     6f0:	636f7250 	cmnvs	pc, #80, 4
     6f4:	5f737365 	svcpl	0x00737365
     6f8:	616e614d 	cmnvs	lr, sp, asr #2
     6fc:	31726567 	cmncc	r2, r7, ror #10
     700:	746f4e34 	strbtvc	r4, [pc], #-3636	; 708 <shift+0x708>
     704:	5f796669 	svcpl	0x00796669
     708:	636f7250 	cmnvs	pc, #80, 4
     70c:	45737365 	ldrbmi	r7, [r3, #-869]!	; 0xfffffc9b
     710:	54323150 	ldrtpl	r3, [r2], #-336	; 0xfffffeb0
     714:	6b736154 	blvs	1cd8c6c <__bss_end+0x1ccfc3c>
     718:	7274535f 	rsbsvc	r5, r4, #2080374785	; 0x7c000001
     71c:	00746375 	rsbseq	r6, r4, r5, ror r3
     720:	5f746547 	svcpl	0x00746547
     724:	65686353 	strbvs	r6, [r8, #-851]!	; 0xfffffcad
     728:	6e495f64 	cdpvs	15, 4, cr5, cr9, cr4, {3}
     72c:	49006f66 	stmdbmi	r0, {r1, r2, r5, r6, r8, r9, sl, fp, sp, lr}
     730:	6c74434f 	ldclvs	3, cr4, [r4], #-316	; 0xfffffec4
     734:	61655200 	cmnvs	r5, r0, lsl #4
     738:	65540064 	ldrbvs	r0, [r4, #-100]	; 0xffffff9c
     73c:	6e696d72 	mcrvs	13, 3, r6, cr9, cr2, {3}
     740:	00657461 	rsbeq	r7, r5, r1, ror #8
     744:	69746f4e 	ldmdbvs	r4!, {r1, r2, r3, r6, r8, r9, sl, fp, sp, lr}^
     748:	505f7966 	subspl	r7, pc, r6, ror #18
     74c:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     750:	5f007373 	svcpl	0x00007373
     754:	36314e5a 			; <UNDEFINED> instruction: 0x36314e5a
     758:	6f725043 	svcvs	0x00725043
     75c:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     760:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     764:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     768:	76453443 	strbvc	r3, [r5], -r3, asr #8
     76c:	746f4e00 	strbtvc	r4, [pc], #-3584	; 774 <shift+0x774>
     770:	00796669 	rsbseq	r6, r9, r9, ror #12
     774:	5078614d 	rsbspl	r6, r8, sp, asr #2
     778:	4c687461 	cfstrdmi	mvd7, [r8], #-388	; 0xfffffe7c
     77c:	74676e65 	strbtvc	r6, [r7], #-3685	; 0xfffff19b
     780:	614d0068 	cmpvs	sp, r8, rrx
     784:	44534678 	ldrbmi	r4, [r3], #-1656	; 0xfffff988
     788:	65766972 	ldrbvs	r6, [r6, #-2418]!	; 0xfffff68e
     78c:	6d614e72 	stclvs	14, cr4, [r1, #-456]!	; 0xfffffe38
     790:	6e654c65 	cdpvs	12, 6, cr4, cr5, cr5, {3}
     794:	00687467 	rsbeq	r7, r8, r7, ror #8
     798:	314e5a5f 	cmpcc	lr, pc, asr sl
     79c:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     7a0:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     7a4:	614d5f73 	hvcvs	54771	; 0xd5f3
     7a8:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     7ac:	53313172 	teqpl	r1, #-2147483620	; 0x8000001c
     7b0:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     7b4:	5f656c75 	svcpl	0x00656c75
     7b8:	76455252 			; <UNDEFINED> instruction: 0x76455252
     7bc:	65474e00 	strbvs	r4, [r7, #-3584]	; 0xfffff200
     7c0:	63535f74 	cmpvs	r3, #116, 30	; 0x1d0
     7c4:	5f646568 	svcpl	0x00646568
     7c8:	6f666e49 	svcvs	0x00666e49
     7cc:	7079545f 	rsbsvc	r5, r9, pc, asr r4
     7d0:	50470065 	subpl	r0, r7, r5, rrx
     7d4:	505f4f49 	subspl	r4, pc, r9, asr #30
     7d8:	435f6e69 	cmpmi	pc, #1680	; 0x690
     7dc:	746e756f 	strbtvc	r7, [lr], #-1391	; 0xfffffa91
     7e0:	73617400 	cmnvc	r1, #0, 8
     7e4:	6f62006b 	svcvs	0x0062006b
     7e8:	5f006c6f 	svcpl	0x00006c6f
     7ec:	36314e5a 			; <UNDEFINED> instruction: 0x36314e5a
     7f0:	6f725043 	svcvs	0x00725043
     7f4:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     7f8:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     7fc:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     800:	65473831 	strbvs	r3, [r7, #-2097]	; 0xfffff7cf
     804:	63535f74 	cmpvs	r3, #116, 30	; 0x1d0
     808:	75646568 	strbvc	r6, [r4, #-1384]!	; 0xfffffa98
     80c:	5f72656c 	svcpl	0x0072656c
     810:	6f666e49 	svcvs	0x00666e49
     814:	4e303245 	cdpmi	2, 3, cr3, cr0, cr5, {2}
     818:	5f746547 	svcpl	0x00746547
     81c:	65686353 	strbvs	r6, [r8, #-851]!	; 0xfffffcad
     820:	6e495f64 	cdpvs	15, 4, cr5, cr9, cr4, {3}
     824:	545f6f66 	ldrbpl	r6, [pc], #-3942	; 82c <shift+0x82c>
     828:	50657079 	rsbpl	r7, r5, r9, ror r0
     82c:	474e0076 	smlsldxmi	r0, lr, r6, r0
     830:	5f4f4950 	svcpl	0x004f4950
     834:	65746e49 	ldrbvs	r6, [r4, #-3657]!	; 0xfffff1b7
     838:	70757272 	rsbsvc	r7, r5, r2, ror r2
     83c:	79545f74 	ldmdbvc	r4, {r2, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     840:	54006570 	strpl	r6, [r0], #-1392	; 0xfffffa90
     844:	5f474e52 	svcpl	0x00474e52
     848:	65736142 	ldrbvs	r6, [r3, #-322]!	; 0xfffffebe
     84c:	66654400 	strbtvs	r4, [r5], -r0, lsl #8
     850:	746c7561 	strbtvc	r7, [ip], #-1377	; 0xfffffa9f
     854:	6f6c435f 	svcvs	0x006c435f
     858:	525f6b63 	subspl	r6, pc, #101376	; 0x18c00
     85c:	00657461 	rsbeq	r7, r5, r1, ror #8
     860:	6f72506d 	svcvs	0x0072506d
     864:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     868:	73694c5f 	cmnvc	r9, #24320	; 0x5f00
     86c:	65485f74 	strbvs	r5, [r8, #-3956]	; 0xfffff08c
     870:	6d006461 	cfstrsvs	mvf6, [r0, #-388]	; 0xfffffe7c
     874:	65686353 	strbvs	r6, [r8, #-851]!	; 0xfffffcad
     878:	656c7564 	strbvs	r7, [ip, #-1380]!	; 0xfffffa9c
     87c:	636e465f 	cmnvs	lr, #99614720	; 0x5f00000
     880:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     884:	50433631 	subpl	r3, r3, r1, lsr r6
     888:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     88c:	4d5f7373 	ldclmi	3, cr7, [pc, #-460]	; 6c8 <shift+0x6c8>
     890:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
     894:	31327265 	teqcc	r2, r5, ror #4
     898:	636f6c42 	cmnvs	pc, #16896	; 0x4200
     89c:	75435f6b 	strbvc	r5, [r3, #-3947]	; 0xfffff095
     8a0:	6e657272 	mcrvs	2, 3, r7, cr5, cr2, {3}
     8a4:	72505f74 	subsvc	r5, r0, #116, 30	; 0x1d0
     8a8:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     8ac:	00764573 	rsbseq	r4, r6, r3, ror r5
     8b0:	6b636f4c 	blvs	18dc5e8 <__bss_end+0x18d35b8>
     8b4:	6c6e555f 	cfstr64vs	mvdx5, [lr], #-380	; 0xfffffe84
     8b8:	656b636f 	strbvs	r6, [fp, #-879]!	; 0xfffffc91
     8bc:	4c6d0064 	stclmi	0, cr0, [sp], #-400	; 0xfffffe70
     8c0:	5f747361 	svcpl	0x00747361
     8c4:	00444950 	subeq	r4, r4, r0, asr r9
     8c8:	62355a5f 	eorsvs	r5, r5, #389120	; 0x5f000
     8cc:	6b6e696c 	blvs	1b9ae84 <__bss_end+0x1b91e54>
     8d0:	77530062 	ldrbvc	r0, [r3, -r2, rrx]
     8d4:	68637469 	stmdavs	r3!, {r0, r3, r5, r6, sl, ip, sp, lr}^
     8d8:	006f545f 	rsbeq	r5, pc, pc, asr r4	; <UNPREDICTABLE>
     8dc:	736f6c43 	cmnvc	pc, #17152	; 0x4300
     8e0:	5a5f0065 	bpl	17c0a7c <__bss_end+0x17b7a4c>
     8e4:	4336314e 	teqmi	r6, #-2147483629	; 0x80000013
     8e8:	636f7250 	cmnvs	pc, #80, 4
     8ec:	5f737365 	svcpl	0x00737365
     8f0:	616e614d 	cmnvs	lr, sp, asr #2
     8f4:	31726567 	cmncc	r2, r7, ror #10
     8f8:	68635332 	stmdavs	r3!, {r1, r4, r5, r8, r9, ip, lr}^
     8fc:	6c756465 	cfldrdvs	mvd6, [r5], #-404	; 0xfffffe6c
     900:	44455f65 	strbmi	r5, [r5], #-3941	; 0xfffff09b
     904:	00764546 	rsbseq	r4, r6, r6, asr #10
     908:	30435342 	subcc	r5, r3, r2, asr #6
     90c:	7361425f 	cmnvc	r1, #-268435451	; 0xf0000005
     910:	69520065 	ldmdbvs	r2, {r0, r2, r5, r6}^
     914:	676e6973 			; <UNDEFINED> instruction: 0x676e6973
     918:	6764455f 			; <UNDEFINED> instruction: 0x6764455f
     91c:	72610065 	rsbvc	r0, r1, #101	; 0x65
     920:	48006367 	stmdami	r0, {r0, r1, r2, r5, r6, r8, r9, sp, lr}
     924:	00686769 	rsbeq	r6, r8, r9, ror #14
     928:	69746f6e 	ldmdbvs	r4!, {r1, r2, r3, r5, r6, r8, r9, sl, fp, sp, lr}^
     92c:	64656966 	strbtvs	r6, [r5], #-2406	; 0xfffff69a
     930:	6165645f 	cmnvs	r5, pc, asr r4
     934:	6e696c64 	cdpvs	12, 6, cr6, cr9, cr4, {3}
     938:	72610065 	rsbvc	r0, r1, #101	; 0x65
     93c:	46007667 	strmi	r7, [r0], -r7, ror #12
     940:	696c6c61 	stmdbvs	ip!, {r0, r5, r6, sl, fp, sp, lr}^
     944:	455f676e 	ldrbmi	r6, [pc, #-1902]	; 1de <shift+0x1de>
     948:	00656764 	rsbeq	r6, r5, r4, ror #14
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
     974:	69466f4e 	stmdbvs	r6, {r1, r2, r3, r6, r8, r9, sl, fp, sp, lr}^
     978:	7973656c 	ldmdbvc	r3!, {r2, r3, r5, r6, r8, sl, sp, lr}^
     97c:	6d657473 	cfstrdvs	mvd7, [r5, #-460]!	; 0xfffffe34
     980:	76697244 	strbtvc	r7, [r9], -r4, asr #4
     984:	6c007265 	sfmvs	f7, 4, [r0], {101}	; 0x65
     988:	6970676f 	ldmdbvs	r0!, {r0, r1, r2, r3, r5, r6, r8, r9, sl, sp, lr}^
     98c:	44006570 	strmi	r6, [r0], #-1392	; 0xfffffa90
     990:	6c646165 	stfvse	f6, [r4], #-404	; 0xfffffe6c
     994:	00656e69 	rsbeq	r6, r5, r9, ror #28
     998:	61736944 	cmnvs	r3, r4, asr #18
     99c:	5f656c62 	svcpl	0x00656c62
     9a0:	6e657645 	cdpvs	6, 6, cr7, cr5, cr5, {2}
     9a4:	65445f74 	strbvs	r5, [r4, #-3956]	; 0xfffff08c
     9a8:	74636574 	strbtvc	r6, [r3], #-1396	; 0xfffffa8c
     9ac:	006e6f69 	rsbeq	r6, lr, r9, ror #30
     9b0:	726f6873 	rsbvc	r6, pc, #7536640	; 0x730000
     9b4:	6e692074 	mcrvs	0, 3, r2, cr9, cr4, {3}
     9b8:	72690074 	rsbvc	r0, r9, #116	; 0x74
     9bc:	65707974 	ldrbvs	r7, [r0, #-2420]!	; 0xfffff68c
     9c0:	78614d00 	stmdavc	r1!, {r8, sl, fp, lr}^
     9c4:	656c6946 	strbvs	r6, [ip, #-2374]!	; 0xfffff6ba
     9c8:	656d616e 	strbvs	r6, [sp, #-366]!	; 0xfffffe92
     9cc:	676e654c 	strbvs	r6, [lr, -ip, asr #10]!
     9d0:	43006874 	movwmi	r6, #2164	; 0x874
     9d4:	636f7250 	cmnvs	pc, #80, 4
     9d8:	5f737365 	svcpl	0x00737365
     9dc:	616e614d 	cmnvs	lr, sp, asr #2
     9e0:	00726567 	rsbseq	r6, r2, r7, ror #10
     9e4:	72627474 	rsbvc	r7, r2, #116, 8	; 0x74000000
     9e8:	534e0030 	movtpl	r0, #57392	; 0xe030
     9ec:	465f4957 			; <UNDEFINED> instruction: 0x465f4957
     9f0:	73656c69 	cmnvc	r5, #26880	; 0x6900
     9f4:	65747379 	ldrbvs	r7, [r4, #-889]!	; 0xfffffc87
     9f8:	65535f6d 	ldrbvs	r5, [r3, #-3949]	; 0xfffff093
     9fc:	63697672 	cmnvs	r9, #119537664	; 0x7200000
     a00:	534e0065 	movtpl	r0, #57445	; 0xe065
     a04:	505f4957 	subspl	r4, pc, r7, asr r9	; <UNPREDICTABLE>
     a08:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     a0c:	535f7373 	cmppl	pc, #-872415231	; 0xcc000001
     a10:	69767265 	ldmdbvs	r6!, {r0, r2, r5, r6, r9, ip, sp, lr}^
     a14:	6f006563 	svcvs	0x00006563
     a18:	656e6570 	strbvs	r6, [lr, #-1392]!	; 0xfffffa90
     a1c:	69665f64 	stmdbvs	r6!, {r2, r5, r6, r8, r9, sl, fp, ip, lr}^
     a20:	0073656c 	rsbseq	r6, r3, ip, ror #10
     a24:	6c656959 			; <UNDEFINED> instruction: 0x6c656959
     a28:	6e490064 	cdpvs	0, 4, cr0, cr9, cr4, {3}
     a2c:	69666564 	stmdbvs	r6!, {r2, r5, r6, r8, sl, sp, lr}^
     a30:	6574696e 	ldrbvs	r6, [r4, #-2414]!	; 0xfffff692
     a34:	74654700 	strbtvc	r4, [r5], #-1792	; 0xfffff900
     a38:	6f72505f 	svcvs	0x0072505f
     a3c:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     a40:	5f79425f 	svcpl	0x0079425f
     a44:	00444950 	subeq	r4, r4, r0, asr r9
     a48:	62616e45 	rsbvs	r6, r1, #1104	; 0x450
     a4c:	455f656c 	ldrbmi	r6, [pc, #-1388]	; 4e8 <shift+0x4e8>
     a50:	746e6576 	strbtvc	r6, [lr], #-1398	; 0xfffffa8a
     a54:	7465445f 	strbtvc	r4, [r5], #-1119	; 0xfffffba1
     a58:	69746365 	ldmdbvs	r4!, {r0, r2, r5, r6, r8, r9, sp, lr}^
     a5c:	50006e6f 	andpl	r6, r0, pc, ror #28
     a60:	70697265 	rsbvc	r7, r9, r5, ror #4
     a64:	61726568 	cmnvs	r2, r8, ror #10
     a68:	61425f6c 	cmpvs	r2, ip, ror #30
     a6c:	6c006573 	cfstr32vs	mvfx6, [r0], {115}	; 0x73
     a70:	20676e6f 	rsbcs	r6, r7, pc, ror #28
     a74:	69736e75 	ldmdbvs	r3!, {r0, r2, r4, r5, r6, r9, sl, fp, sp, lr}^
     a78:	64656e67 	strbtvs	r6, [r5], #-3687	; 0xfffff199
     a7c:	746e6920 	strbtvc	r6, [lr], #-2336	; 0xfffff6e0
     a80:	766e4900 	strbtvc	r4, [lr], -r0, lsl #18
     a84:	64696c61 	strbtvs	r6, [r9], #-3169	; 0xfffff39f
     a88:	6e69505f 	mcrvs	0, 3, r5, cr9, cr15, {2}
     a8c:	636f4c00 	cmnvs	pc, #0, 24
     a90:	6f4c5f6b 	svcvs	0x004c5f6b
     a94:	64656b63 	strbtvs	r6, [r5], #-2915	; 0xfffff49d
     a98:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     a9c:	50433631 	subpl	r3, r3, r1, lsr r6
     aa0:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     aa4:	4d5f7373 	ldclmi	3, cr7, [pc, #-460]	; 8e0 <shift+0x8e0>
     aa8:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
     aac:	38317265 	ldmdacc	r1!, {r0, r2, r5, r6, r9, ip, sp, lr}
     ab0:	646e6148 	strbtvs	r6, [lr], #-328	; 0xfffffeb8
     ab4:	505f656c 	subspl	r6, pc, ip, ror #10
     ab8:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     abc:	535f7373 	cmppl	pc, #-872415231	; 0xcc000001
     ac0:	32454957 	subcc	r4, r5, #1425408	; 0x15c000
     ac4:	57534e30 	smmlarpl	r3, r0, lr, r4
     ac8:	72505f49 	subsvc	r5, r0, #292	; 0x124
     acc:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     ad0:	65535f73 	ldrbvs	r5, [r3, #-3955]	; 0xfffff08d
     ad4:	63697672 	cmnvs	r9, #119537664	; 0x7200000
     ad8:	6a6a6a65 	bvs	1a9b474 <__bss_end+0x1a92444>
     adc:	54313152 	ldrtpl	r3, [r1], #-338	; 0xfffffeae
     ae0:	5f495753 	svcpl	0x00495753
     ae4:	75736552 	ldrbvc	r6, [r3, #-1362]!	; 0xfffffaae
     ae8:	7300746c 	movwvc	r7, #1132	; 0x46c
     aec:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     af0:	756f635f 	strbvc	r6, [pc, #-863]!	; 799 <shift+0x799>
     af4:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
     af8:	74654700 	strbtvc	r4, [r5], #-1792	; 0xfffff900
     afc:	7261505f 	rsbvc	r5, r1, #95	; 0x5f
     b00:	00736d61 	rsbseq	r6, r3, r1, ror #26
     b04:	69736e75 	ldmdbvs	r3!, {r0, r2, r4, r5, r6, r9, sl, fp, sp, lr}^
     b08:	64656e67 	strbtvs	r6, [r5], #-3687	; 0xfffff199
     b0c:	61686320 	cmnvs	r8, r0, lsr #6
     b10:	6e490072 	mcrvs	0, 2, r0, cr9, cr2, {3}
     b14:	72726574 	rsbsvc	r6, r2, #116, 10	; 0x1d000000
     b18:	61747075 	cmnvs	r4, r5, ror r0
     b1c:	5f656c62 	svcpl	0x00656c62
     b20:	65656c53 	strbvs	r6, [r5, #-3155]!	; 0xfffff3ad
     b24:	63530070 	cmpvs	r3, #112	; 0x70
     b28:	75646568 	strbvc	r6, [r4, #-1384]!	; 0xfffffa98
     b2c:	525f656c 	subspl	r6, pc, #108, 10	; 0x1b000000
     b30:	55410052 	strbpl	r0, [r1, #-82]	; 0xffffffae
     b34:	61425f58 	cmpvs	r2, r8, asr pc
     b38:	42006573 	andmi	r6, r0, #482344960	; 0x1cc00000
     b3c:	5f324353 	svcpl	0x00324353
     b40:	65736142 	ldrbvs	r6, [r3, #-322]!	; 0xfffffebe
     b44:	61747300 	cmnvs	r4, r0, lsl #6
     b48:	2f006574 	svccs	0x00006574
     b4c:	72657355 	rsbvc	r7, r5, #1409286145	; 0x54000001
     b50:	69772f73 	ldmdbvs	r7!, {r0, r1, r4, r5, r6, r8, r9, sl, fp, sp}^
     b54:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
     b58:	442f696a 	strtmi	r6, [pc], #-2410	; b60 <shift+0xb60>
     b5c:	746b7365 	strbtvc	r7, [fp], #-869	; 0xfffffc9b
     b60:	462f706f 	strtmi	r7, [pc], -pc, rrx
     b64:	4e2f5641 	cfmadda32mi	mvax2, mvax5, mvfx15, mvfx1
     b68:	7a617661 	bvc	185e4f4 <__bss_end+0x18554c4>
     b6c:	63696a75 	cmnvs	r9, #479232	; 0x75000
     b70:	534f2f69 	movtpl	r2, #65385	; 0xff69
     b74:	6d65732f 	stclvs	3, cr7, [r5, #-188]!	; 0xffffff44
     b78:	72747365 	rsbsvc	r7, r4, #-1811939327	; 0x94000001
     b7c:	616b6c61 	cmnvs	fp, r1, ror #24
     b80:	76696b2d 	strbtvc	r6, [r9], -sp, lsr #22
     b84:	2f736f2d 	svccs	0x00736f2d
     b88:	72756f73 	rsbsvc	r6, r5, #460	; 0x1cc
     b8c:	2f736563 	svccs	0x00736563
     b90:	72657375 	rsbvc	r7, r5, #-738197503	; 0xd4000001
     b94:	63617073 	cmnvs	r1, #115	; 0x73
     b98:	6f732f65 	svcvs	0x00732f65
     b9c:	61745f73 	cmnvs	r4, r3, ror pc
     ba0:	6d2f6b73 	fstmdbxvs	pc!, {d6-d62}	;@ Deprecated
     ba4:	2e6e6961 	vnmulcs.f16	s13, s28, s3	; <UNPREDICTABLE>
     ba8:	00707063 	rsbseq	r7, r0, r3, rrx
     bac:	74697257 	strbtvc	r7, [r9], #-599	; 0xfffffda9
     bb0:	6e4f5f65 	cdpvs	15, 4, cr5, cr15, cr5, {3}
     bb4:	5300796c 	movwpl	r7, #2412	; 0x96c
     bb8:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     bbc:	00656c75 	rsbeq	r6, r5, r5, ror ip
     bc0:	6b636954 	blvs	18db118 <__bss_end+0x18d20e8>
     bc4:	756f435f 	strbvc	r4, [pc, #-863]!	; 86d <shift+0x86d>
     bc8:	5f00746e 	svcpl	0x0000746e
     bcc:	36314e5a 			; <UNDEFINED> instruction: 0x36314e5a
     bd0:	6f725043 	svcvs	0x00725043
     bd4:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     bd8:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     bdc:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     be0:	6e553831 	mrcvs	8, 2, r3, cr5, cr1, {1}
     be4:	5f70616d 	svcpl	0x0070616d
     be8:	656c6946 	strbvs	r6, [ip, #-2374]!	; 0xfffff6ba
     bec:	7275435f 	rsbsvc	r4, r5, #2080374785	; 0x7c000001
     bf0:	746e6572 	strbtvc	r6, [lr], #-1394	; 0xfffffa8e
     bf4:	48006a45 	stmdami	r0, {r0, r2, r6, r9, fp, sp, lr}
     bf8:	6c646e61 	stclvs	14, cr6, [r4], #-388	; 0xfffffe7c
     bfc:	69465f65 	stmdbvs	r6, {r0, r2, r5, r6, r8, r9, sl, fp, ip, lr}^
     c00:	7973656c 	ldmdbvc	r3!, {r2, r3, r5, r6, r8, sl, sp, lr}^
     c04:	6d657473 	cfstrdvs	mvd7, [r5, #-460]!	; 0xfffffe34
     c08:	4957535f 	ldmdbmi	r7, {r0, r1, r2, r3, r4, r6, r8, r9, ip, lr}^
     c0c:	6f687300 	svcvs	0x00687300
     c10:	75207472 	strvc	r7, [r0, #-1138]!	; 0xfffffb8e
     c14:	6769736e 	strbvs	r7, [r9, -lr, ror #6]!
     c18:	2064656e 	rsbcs	r6, r4, lr, ror #10
     c1c:	00746e69 	rsbseq	r6, r4, r9, ror #28
     c20:	6e69616d 	powvsez	f6, f1, #5.0
     c24:	746e4900 	strbtvc	r4, [lr], #-2304	; 0xfffff700
     c28:	75727265 	ldrbvc	r7, [r2, #-613]!	; 0xfffffd9b
     c2c:	435f7470 	cmpmi	pc, #112, 8	; 0x70000000
     c30:	72746e6f 	rsbsvc	r6, r4, #1776	; 0x6f0
     c34:	656c6c6f 	strbvs	r6, [ip, #-3183]!	; 0xfffff391
     c38:	61425f72 	hvcvs	9714	; 0x25f2
     c3c:	52006573 	andpl	r6, r0, #482344960	; 0x1cc00000
     c40:	5f646165 	svcpl	0x00646165
     c44:	74697257 	strbtvc	r7, [r9], #-599	; 0xfffffda9
     c48:	63410065 	movtvs	r0, #4197	; 0x1065
     c4c:	65766974 	ldrbvs	r6, [r6, #-2420]!	; 0xfffff68c
     c50:	6f72505f 	svcvs	0x0072505f
     c54:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     c58:	756f435f 	strbvc	r4, [pc, #-863]!	; 901 <shift+0x901>
     c5c:	7300746e 	movwvc	r7, #1134	; 0x46e
     c60:	6f626d79 	svcvs	0x00626d79
     c64:	69745f6c 	ldmdbvs	r4!, {r2, r3, r5, r6, r8, r9, sl, fp, ip, lr}^
     c68:	645f6b63 	ldrbvs	r6, [pc], #-2915	; c70 <shift+0xc70>
     c6c:	79616c65 	stmdbvc	r1!, {r0, r2, r5, r6, sl, fp, sp, lr}^
     c70:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     c74:	50433631 	subpl	r3, r3, r1, lsr r6
     c78:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     c7c:	4d5f7373 	ldclmi	3, cr7, [pc, #-460]	; ab8 <shift+0xab8>
     c80:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
     c84:	31327265 	teqcc	r2, r5, ror #4
     c88:	646e6148 	strbtvs	r6, [lr], #-328	; 0xfffffeb8
     c8c:	465f656c 	ldrbmi	r6, [pc], -ip, ror #10
     c90:	73656c69 	cmnvc	r5, #26880	; 0x6900
     c94:	65747379 	ldrbvs	r7, [r4, #-889]!	; 0xfffffc87
     c98:	57535f6d 	ldrbpl	r5, [r3, -sp, ror #30]
     c9c:	33324549 	teqcc	r2, #306184192	; 0x12400000
     ca0:	4957534e 	ldmdbmi	r7, {r1, r2, r3, r6, r8, r9, ip, lr}^
     ca4:	6c69465f 	stclvs	6, cr4, [r9], #-380	; 0xfffffe84
     ca8:	73797365 	cmnvc	r9, #-1811939327	; 0x94000001
     cac:	5f6d6574 	svcpl	0x006d6574
     cb0:	76726553 			; <UNDEFINED> instruction: 0x76726553
     cb4:	6a656369 	bvs	1959a60 <__bss_end+0x1950a30>
     cb8:	31526a6a 	cmpcc	r2, sl, ror #20
     cbc:	57535431 	smmlarpl	r3, r1, r4, r5
     cc0:	65525f49 	ldrbvs	r5, [r2, #-3913]	; 0xfffff0b7
     cc4:	746c7573 	strbtvc	r7, [ip], #-1395	; 0xfffffa8d
     cc8:	73552f00 	cmpvc	r5, #0, 30
     ccc:	2f737265 	svccs	0x00737265
     cd0:	746e6977 	strbtvc	r6, [lr], #-2423	; 0xfffff689
     cd4:	696a7265 	stmdbvs	sl!, {r0, r2, r5, r6, r9, ip, sp, lr}^
     cd8:	7365442f 	cmnvc	r5, #788529152	; 0x2f000000
     cdc:	706f746b 	rsbvc	r7, pc, fp, ror #8
     ce0:	5641462f 	strbpl	r4, [r1], -pc, lsr #12
     ce4:	76614e2f 	strbtvc	r4, [r1], -pc, lsr #28
     ce8:	6a757a61 	bvs	1d5f674 <__bss_end+0x1d56644>
     cec:	2f696369 	svccs	0x00696369
     cf0:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
     cf4:	73656d65 	cmnvc	r5, #6464	; 0x1940
     cf8:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
     cfc:	6b2d616b 	blvs	b592b0 <__bss_end+0xb50280>
     d00:	6f2d7669 	svcvs	0x002d7669
     d04:	6f732f73 	svcvs	0x00732f73
     d08:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
     d0c:	75622f73 	strbvc	r2, [r2, #-3955]!	; 0xfffff08d
     d10:	00646c69 	rsbeq	r6, r4, r9, ror #24
     d14:	736f6c63 	cmnvc	pc, #25344	; 0x6300
     d18:	65530065 	ldrbvs	r0, [r3, #-101]	; 0xffffff9b
     d1c:	65525f74 	ldrbvs	r5, [r2, #-3956]	; 0xfffff08c
     d20:	6974616c 	ldmdbvs	r4!, {r2, r3, r5, r6, r8, sp, lr}^
     d24:	72006576 	andvc	r6, r0, #494927872	; 0x1d800000
     d28:	61767465 	cmnvs	r6, r5, ror #8
     d2c:	636e006c 	cmnvs	lr, #108	; 0x6c
     d30:	72007275 	andvc	r7, r0, #1342177287	; 0x50000007
     d34:	6d756e64 	ldclvs	14, cr6, [r5, #-400]!	; 0xfffffe70
     d38:	315a5f00 	cmpcc	sl, r0, lsl #30
     d3c:	68637331 	stmdavs	r3!, {r0, r4, r5, r8, r9, ip, sp, lr}^
     d40:	795f6465 	ldmdbvc	pc, {r0, r2, r5, r6, sl, sp, lr}^	; <UNPREDICTABLE>
     d44:	646c6569 	strbtvs	r6, [ip], #-1385	; 0xfffffa97
     d48:	5a5f0076 	bpl	17c0f28 <__bss_end+0x17b7ef8>
     d4c:	65733731 	ldrbvs	r3, [r3, #-1841]!	; 0xfffff8cf
     d50:	61745f74 	cmnvs	r4, r4, ror pc
     d54:	645f6b73 	ldrbvs	r6, [pc], #-2931	; d5c <shift+0xd5c>
     d58:	6c646165 	stfvse	f6, [r4], #-404	; 0xfffffe6c
     d5c:	6a656e69 	bvs	195c708 <__bss_end+0x19536d8>
     d60:	69617700 	stmdbvs	r1!, {r8, r9, sl, ip, sp, lr}^
     d64:	5a5f0074 	bpl	17c0f3c <__bss_end+0x17b7f0c>
     d68:	746f6e36 	strbtvc	r6, [pc], #-3638	; d70 <shift+0xd70>
     d6c:	6a796669 	bvs	1e5a718 <__bss_end+0x1e516e8>
     d70:	6146006a 	cmpvs	r6, sl, rrx
     d74:	65006c69 	strvs	r6, [r0, #-3177]	; 0xfffff397
     d78:	63746978 	cmnvs	r4, #120, 18	; 0x1e0000
     d7c:	0065646f 	rsbeq	r6, r5, pc, ror #8
     d80:	65686373 	strbvs	r6, [r8, #-883]!	; 0xfffffc8d
     d84:	69795f64 	ldmdbvs	r9!, {r2, r5, r6, r8, r9, sl, fp, ip, lr}^
     d88:	00646c65 	rsbeq	r6, r4, r5, ror #24
     d8c:	6b636974 	blvs	18db364 <__bss_end+0x18d2334>
     d90:	756f635f 	strbvc	r6, [pc, #-863]!	; a39 <shift+0xa39>
     d94:	725f746e 	subsvc	r7, pc, #1845493760	; 0x6e000000
     d98:	69757165 	ldmdbvs	r5!, {r0, r2, r5, r6, r8, ip, sp, lr}^
     d9c:	00646572 	rsbeq	r6, r4, r2, ror r5
     da0:	34325a5f 	ldrtcc	r5, [r2], #-2655	; 0xfffff5a1
     da4:	5f746567 	svcpl	0x00746567
     da8:	69746361 	ldmdbvs	r4!, {r0, r5, r6, r8, r9, sp, lr}^
     dac:	705f6576 	subsvc	r6, pc, r6, ror r5	; <UNPREDICTABLE>
     db0:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     db4:	635f7373 	cmpvs	pc, #-872415231	; 0xcc000001
     db8:	746e756f 	strbtvc	r7, [lr], #-1391	; 0xfffffa91
     dbc:	69500076 	ldmdbvs	r0, {r1, r2, r4, r5, r6}^
     dc0:	465f6570 			; <UNDEFINED> instruction: 0x465f6570
     dc4:	5f656c69 	svcpl	0x00656c69
     dc8:	66657250 			; <UNDEFINED> instruction: 0x66657250
     dcc:	5f007869 	svcpl	0x00007869
     dd0:	6734315a 			; <UNDEFINED> instruction: 0x6734315a
     dd4:	745f7465 	ldrbvc	r7, [pc], #-1125	; ddc <shift+0xddc>
     dd8:	5f6b6369 	svcpl	0x006b6369
     ddc:	6e756f63 	cdpvs	15, 7, cr6, cr5, cr3, {3}
     de0:	73007674 	movwvc	r7, #1652	; 0x674
     de4:	7065656c 	rsbvc	r6, r5, ip, ror #10
     de8:	395a5f00 	ldmdbcc	sl, {r8, r9, sl, fp, ip, lr}^
     dec:	6d726574 	cfldr64vs	mvdx6, [r2, #-464]!	; 0xfffffe30
     df0:	74616e69 	strbtvc	r6, [r1], #-3689	; 0xfffff197
     df4:	6f006965 	svcvs	0x00006965
     df8:	61726570 	cmnvs	r2, r0, ror r5
     dfc:	6e6f6974 			; <UNDEFINED> instruction: 0x6e6f6974
     e00:	355a5f00 	ldrbcc	r5, [sl, #-3840]	; 0xfffff100
     e04:	736f6c63 	cmnvc	pc, #25344	; 0x6300
     e08:	5f006a65 	svcpl	0x00006a65
     e0c:	6567365a 	strbvs	r3, [r7, #-1626]!	; 0xfffff9a6
     e10:	64697074 	strbtvs	r7, [r9], #-116	; 0xffffff8c
     e14:	6e660076 	mcrvs	0, 3, r0, cr6, cr6, {3}
     e18:	00656d61 	rsbeq	r6, r5, r1, ror #26
     e1c:	74697277 	strbtvc	r7, [r9], #-631	; 0xfffffd89
     e20:	69740065 	ldmdbvs	r4!, {r0, r2, r5, r6}^
     e24:	00736b63 	rsbseq	r6, r3, r3, ror #22
     e28:	6e65706f 	cdpvs	0, 6, cr7, cr5, cr15, {3}
     e2c:	345a5f00 	ldrbcc	r5, [sl], #-3840	; 0xfffff100
     e30:	65706970 	ldrbvs	r6, [r0, #-2416]!	; 0xfffff690
     e34:	6a634b50 	bvs	18d3b7c <__bss_end+0x18cab4c>
     e38:	65444e00 	strbvs	r4, [r4, #-3584]	; 0xfffff200
     e3c:	696c6461 	stmdbvs	ip!, {r0, r5, r6, sl, sp, lr}^
     e40:	535f656e 	cmppl	pc, #461373440	; 0x1b800000
     e44:	65736275 	ldrbvs	r6, [r3, #-629]!	; 0xfffffd8b
     e48:	63697672 	cmnvs	r9, #119537664	; 0x7200000
     e4c:	65670065 	strbvs	r0, [r7, #-101]!	; 0xffffff9b
     e50:	69745f74 	ldmdbvs	r4!, {r2, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     e54:	635f6b63 	cmpvs	pc, #101376	; 0x18c00
     e58:	746e756f 	strbtvc	r7, [lr], #-1391	; 0xfffffa91
     e5c:	72617000 	rsbvc	r7, r1, #0
     e60:	5f006d61 	svcpl	0x00006d61
     e64:	7277355a 	rsbsvc	r3, r7, #377487360	; 0x16800000
     e68:	6a657469 	bvs	195e014 <__bss_end+0x1954fe4>
     e6c:	6a634b50 	bvs	18d3bb4 <__bss_end+0x18cab84>
     e70:	74656700 	strbtvc	r6, [r5], #-1792	; 0xfffff900
     e74:	7361745f 	cmnvc	r1, #1593835520	; 0x5f000000
     e78:	69745f6b 	ldmdbvs	r4!, {r0, r1, r3, r5, r6, r8, r9, sl, fp, ip, lr}^
     e7c:	5f736b63 	svcpl	0x00736b63
     e80:	645f6f74 	ldrbvs	r6, [pc], #-3956	; e88 <shift+0xe88>
     e84:	6c646165 	stfvse	f6, [r4], #-404	; 0xfffffe6c
     e88:	00656e69 	rsbeq	r6, r5, r9, ror #28
     e8c:	5f667562 	svcpl	0x00667562
     e90:	657a6973 	ldrbvs	r6, [sl, #-2419]!	; 0xfffff68d
     e94:	74657300 	strbtvc	r7, [r5], #-768	; 0xfffffd00
     e98:	7361745f 	cmnvc	r1, #1593835520	; 0x5f000000
     e9c:	65645f6b 	strbvs	r5, [r4, #-3947]!	; 0xfffff095
     ea0:	696c6461 	stmdbvs	ip!, {r0, r5, r6, sl, sp, lr}^
     ea4:	2f00656e 	svccs	0x0000656e
     ea8:	72657355 	rsbvc	r7, r5, #1409286145	; 0x54000001
     eac:	69772f73 	ldmdbvs	r7!, {r0, r1, r4, r5, r6, r8, r9, sl, fp, sp}^
     eb0:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
     eb4:	442f696a 	strtmi	r6, [pc], #-2410	; ebc <shift+0xebc>
     eb8:	746b7365 	strbtvc	r7, [fp], #-869	; 0xfffffc9b
     ebc:	462f706f 	strtmi	r7, [pc], -pc, rrx
     ec0:	4e2f5641 	cfmadda32mi	mvax2, mvax5, mvfx15, mvfx1
     ec4:	7a617661 	bvc	185e850 <__bss_end+0x1855820>
     ec8:	63696a75 	cmnvs	r9, #479232	; 0x75000
     ecc:	534f2f69 	movtpl	r2, #65385	; 0xff69
     ed0:	6d65732f 	stclvs	3, cr7, [r5, #-188]!	; 0xffffff44
     ed4:	72747365 	rsbsvc	r7, r4, #-1811939327	; 0x94000001
     ed8:	616b6c61 	cmnvs	fp, r1, ror #24
     edc:	76696b2d 	strbtvc	r6, [r9], -sp, lsr #22
     ee0:	2f736f2d 	svccs	0x00736f2d
     ee4:	72756f73 	rsbsvc	r6, r5, #460	; 0x1cc
     ee8:	2f736563 	svccs	0x00736563
     eec:	6c647473 	cfstrdvs	mvd7, [r4], #-460	; 0xfffffe34
     ef0:	732f6269 			; <UNDEFINED> instruction: 0x732f6269
     ef4:	732f6372 			; <UNDEFINED> instruction: 0x732f6372
     ef8:	69666474 	stmdbvs	r6!, {r2, r4, r5, r6, sl, sp, lr}^
     efc:	632e656c 			; <UNDEFINED> instruction: 0x632e656c
     f00:	5f007070 	svcpl	0x00007070
     f04:	6c73355a 	cfldr64vs	mvdx3, [r3], #-360	; 0xfffffe98
     f08:	6a706565 	bvs	1c1a4a4 <__bss_end+0x1c11474>
     f0c:	6966006a 	stmdbvs	r6!, {r1, r3, r5, r6}^
     f10:	4700656c 	strmi	r6, [r0, -ip, ror #10]
     f14:	525f7465 	subspl	r7, pc, #1694498816	; 0x65000000
     f18:	69616d65 	stmdbvs	r1!, {r0, r2, r5, r6, r8, sl, fp, sp, lr}^
     f1c:	676e696e 	strbvs	r6, [lr, -lr, ror #18]!
     f20:	325a5f00 	subscc	r5, sl, #0, 30
     f24:	74656736 	strbtvc	r6, [r5], #-1846	; 0xfffff8ca
     f28:	7361745f 	cmnvc	r1, #1593835520	; 0x5f000000
     f2c:	69745f6b 	ldmdbvs	r4!, {r0, r1, r3, r5, r6, r8, r9, sl, fp, ip, lr}^
     f30:	5f736b63 	svcpl	0x00736b63
     f34:	645f6f74 	ldrbvs	r6, [pc], #-3956	; f3c <shift+0xf3c>
     f38:	6c646165 	stfvse	f6, [r4], #-404	; 0xfffffe6c
     f3c:	76656e69 	strbtvc	r6, [r5], -r9, ror #28
     f40:	57534e00 	ldrbpl	r4, [r3, -r0, lsl #28]
     f44:	65525f49 	ldrbvs	r5, [r2, #-3913]	; 0xfffff0b7
     f48:	746c7573 	strbtvc	r7, [ip], #-1395	; 0xfffffa8d
     f4c:	646f435f 	strbtvs	r4, [pc], #-863	; f54 <shift+0xf54>
     f50:	72770065 	rsbsvc	r0, r7, #101	; 0x65
     f54:	006d756e 	rsbeq	r7, sp, lr, ror #10
     f58:	77345a5f 			; <UNDEFINED> instruction: 0x77345a5f
     f5c:	6a746961 	bvs	1d1b4e8 <__bss_end+0x1d124b8>
     f60:	5f006a6a 	svcpl	0x00006a6a
     f64:	6f69355a 	svcvs	0x0069355a
     f68:	6a6c7463 	bvs	1b1e0fc <__bss_end+0x1b150cc>
     f6c:	494e3631 	stmdbmi	lr, {r0, r4, r5, r9, sl, ip, sp}^
     f70:	6c74434f 	ldclvs	3, cr4, [r4], #-316	; 0xfffffec4
     f74:	65704f5f 	ldrbvs	r4, [r0, #-3935]!	; 0xfffff0a1
     f78:	69746172 	ldmdbvs	r4!, {r1, r4, r5, r6, r8, sp, lr}^
     f7c:	76506e6f 	ldrbvc	r6, [r0], -pc, ror #28
     f80:	636f6900 	cmnvs	pc, #0, 18
     f84:	72006c74 	andvc	r6, r0, #116, 24	; 0x7400
     f88:	6e637465 	cdpvs	4, 6, cr7, cr3, cr5, {3}
     f8c:	6f6e0074 	svcvs	0x006e0074
     f90:	79666974 	stmdbvc	r6!, {r2, r4, r5, r6, r8, fp, sp, lr}^
     f94:	72657400 	rsbvc	r7, r5, #0, 8
     f98:	616e696d 	cmnvs	lr, sp, ror #18
     f9c:	6d006574 	cfstr32vs	mvfx6, [r0, #-464]	; 0xfffffe30
     fa0:	0065646f 	rsbeq	r6, r5, pc, ror #8
     fa4:	66667562 	strbtvs	r7, [r6], -r2, ror #10
     fa8:	5f007265 	svcpl	0x00007265
     fac:	6572345a 	ldrbvs	r3, [r2, #-1114]!	; 0xfffffba6
     fb0:	506a6461 	rsbpl	r6, sl, r1, ror #8
     fb4:	47006a63 	strmi	r6, [r0, -r3, ror #20]
     fb8:	4320554e 			; <UNDEFINED> instruction: 0x4320554e
     fbc:	34312b2b 	ldrtcc	r2, [r1], #-2859	; 0xfffff4d5
     fc0:	2e303120 	rsfcssp	f3, f0, f0
     fc4:	20312e33 	eorscs	r2, r1, r3, lsr lr
     fc8:	31323032 	teqcc	r2, r2, lsr r0
     fcc:	34323830 	ldrtcc	r3, [r2], #-2096	; 0xfffff7d0
     fd0:	65722820 	ldrbvs	r2, [r2, #-2080]!	; 0xfffff7e0
     fd4:	7361656c 	cmnvc	r1, #108, 10	; 0x1b000000
     fd8:	2d202965 			; <UNDEFINED> instruction: 0x2d202965
     fdc:	6f6c666d 	svcvs	0x006c666d
     fe0:	612d7461 			; <UNDEFINED> instruction: 0x612d7461
     fe4:	683d6962 	ldmdavs	sp!, {r1, r5, r6, r8, fp, sp, lr}
     fe8:	20647261 	rsbcs	r7, r4, r1, ror #4
     fec:	70666d2d 	rsbvc	r6, r6, sp, lsr #26
     ff0:	66763d75 			; <UNDEFINED> instruction: 0x66763d75
     ff4:	6d2d2070 	stcvs	0, cr2, [sp, #-448]!	; 0xfffffe40
     ff8:	616f6c66 	cmnvs	pc, r6, ror #24
     ffc:	62612d74 	rsbvs	r2, r1, #116, 26	; 0x1d00
    1000:	61683d69 	cmnvs	r8, r9, ror #26
    1004:	2d206472 	cfstrscs	mvf6, [r0, #-456]!	; 0xfffffe38
    1008:	7570666d 	ldrbvc	r6, [r0, #-1645]!	; 0xfffff993
    100c:	7066763d 	rsbvc	r7, r6, sp, lsr r6
    1010:	746d2d20 	strbtvc	r2, [sp], #-3360	; 0xfffff2e0
    1014:	3d656e75 	stclcc	14, cr6, [r5, #-468]!	; 0xfffffe2c
    1018:	316d7261 	cmncc	sp, r1, ror #4
    101c:	6a363731 	bvs	d8ece8 <__bss_end+0xd85cb8>
    1020:	732d667a 			; <UNDEFINED> instruction: 0x732d667a
    1024:	616d2d20 	cmnvs	sp, r0, lsr #26
    1028:	2d206d72 	stccs	13, cr6, [r0, #-456]!	; 0xfffffe38
    102c:	6372616d 	cmnvs	r2, #1073741851	; 0x4000001b
    1030:	72613d68 	rsbvc	r3, r1, #104, 26	; 0x1a00
    1034:	7a36766d 	bvc	d9e9f0 <__bss_end+0xd959c0>
    1038:	70662b6b 	rsbvc	r2, r6, fp, ror #22
    103c:	20672d20 	rsbcs	r2, r7, r0, lsr #26
    1040:	2d20672d 	stccs	7, cr6, [r0, #-180]!	; 0xffffff4c
    1044:	4f2d2067 	svcmi	0x002d2067
    1048:	4f2d2030 	svcmi	0x002d2030
    104c:	662d2030 			; <UNDEFINED> instruction: 0x662d2030
    1050:	652d6f6e 	strvs	r6, [sp, #-3950]!	; 0xfffff092
    1054:	70656378 	rsbvc	r6, r5, r8, ror r3
    1058:	6e6f6974 			; <UNDEFINED> instruction: 0x6e6f6974
    105c:	662d2073 			; <UNDEFINED> instruction: 0x662d2073
    1060:	722d6f6e 	eorvc	r6, sp, #440	; 0x1b8
    1064:	00697474 	rsbeq	r7, r9, r4, ror r4
    1068:	63746572 	cmnvs	r4, #478150656	; 0x1c800000
    106c:	0065646f 	rsbeq	r6, r5, pc, ror #8
    1070:	5f746567 	svcpl	0x00746567
    1074:	69746361 	ldmdbvs	r4!, {r0, r5, r6, r8, r9, sp, lr}^
    1078:	705f6576 	subsvc	r6, pc, r6, ror r5	; <UNPREDICTABLE>
    107c:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
    1080:	635f7373 	cmpvs	pc, #-872415231	; 0xcc000001
    1084:	746e756f 	strbtvc	r7, [lr], #-1391	; 0xfffffa91
    1088:	6c696600 	stclvs	6, cr6, [r9], #-0
    108c:	6d616e65 	stclvs	14, cr6, [r1, #-404]!	; 0xfffffe6c
    1090:	65720065 	ldrbvs	r0, [r2, #-101]!	; 0xffffff9b
    1094:	67006461 	strvs	r6, [r0, -r1, ror #8]
    1098:	69707465 	ldmdbvs	r0!, {r0, r2, r5, r6, sl, ip, sp, lr}^
    109c:	5a5f0064 	bpl	17c1234 <__bss_end+0x17b8204>
    10a0:	65706f34 	ldrbvs	r6, [r0, #-3892]!	; 0xfffff0cc
    10a4:	634b506e 	movtvs	r5, #45166	; 0xb06e
    10a8:	464e3531 			; <UNDEFINED> instruction: 0x464e3531
    10ac:	5f656c69 	svcpl	0x00656c69
    10b0:	6e65704f 	cdpvs	0, 6, cr7, cr5, cr15, {2}
    10b4:	646f4d5f 	strbtvs	r4, [pc], #-3423	; 10bc <shift+0x10bc>
    10b8:	6e690065 	cdpvs	0, 6, cr0, cr9, cr5, {3}
    10bc:	00747570 	rsbseq	r7, r4, r0, ror r5
    10c0:	74736564 	ldrbtvc	r6, [r3], #-1380	; 0xfffffa9c
    10c4:	657a6200 	ldrbvs	r6, [sl, #-512]!	; 0xfffffe00
    10c8:	6c006f72 	stcvs	15, cr6, [r0], {114}	; 0x72
    10cc:	74676e65 	strbtvc	r6, [r7], #-3685	; 0xfffff19b
    10d0:	5a5f0068 	bpl	17c1278 <__bss_end+0x17b8248>
    10d4:	657a6235 	ldrbvs	r6, [sl, #-565]!	; 0xfffffdcb
    10d8:	76506f72 	usub16vc	r6, r0, r2
    10dc:	552f0069 	strpl	r0, [pc, #-105]!	; 107b <shift+0x107b>
    10e0:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
    10e4:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
    10e8:	6a726574 	bvs	1c9a6c0 <__bss_end+0x1c91690>
    10ec:	65442f69 	strbvs	r2, [r4, #-3945]	; 0xfffff097
    10f0:	6f746b73 	svcvs	0x00746b73
    10f4:	41462f70 	hvcmi	25328	; 0x62f0
    10f8:	614e2f56 	cmpvs	lr, r6, asr pc
    10fc:	757a6176 	ldrbvc	r6, [sl, #-374]!	; 0xfffffe8a
    1100:	6963696a 	stmdbvs	r3!, {r1, r3, r5, r6, r8, fp, sp, lr}^
    1104:	2f534f2f 	svccs	0x00534f2f
    1108:	656d6573 	strbvs	r6, [sp, #-1395]!	; 0xfffffa8d
    110c:	61727473 	cmnvs	r2, r3, ror r4
    1110:	2d616b6c 	vstmdbcs	r1!, {d22-<overflow reg d75>}
    1114:	2d76696b 			; <UNDEFINED> instruction: 0x2d76696b
    1118:	732f736f 			; <UNDEFINED> instruction: 0x732f736f
    111c:	6372756f 	cmnvs	r2, #465567744	; 0x1bc00000
    1120:	732f7365 			; <UNDEFINED> instruction: 0x732f7365
    1124:	696c6474 	stmdbvs	ip!, {r2, r4, r5, r6, sl, sp, lr}^
    1128:	72732f62 	rsbsvc	r2, r3, #392	; 0x188
    112c:	74732f63 	ldrbtvc	r2, [r3], #-3939	; 0xfffff09d
    1130:	72747364 	rsbsvc	r7, r4, #100, 6	; 0x90000001
    1134:	2e676e69 	cdpcs	14, 6, cr6, cr7, cr9, {3}
    1138:	00707063 	rsbseq	r7, r0, r3, rrx
    113c:	61345a5f 	teqvs	r4, pc, asr sl
    1140:	50696f74 	rsbpl	r6, r9, r4, ror pc
    1144:	4300634b 	movwmi	r6, #843	; 0x34b
    1148:	43726168 	cmnmi	r2, #104, 2
    114c:	41766e6f 	cmnmi	r6, pc, ror #28
    1150:	6d007272 	sfmvs	f7, 4, [r0, #-456]	; 0xfffffe38
    1154:	73646d65 	cmnvc	r4, #6464	; 0x1940
    1158:	756f0074 	strbvc	r0, [pc, #-116]!	; 10ec <shift+0x10ec>
    115c:	74757074 	ldrbtvc	r7, [r5], #-116	; 0xffffff8c
    1160:	365a5f00 	ldrbcc	r5, [sl], -r0, lsl #30
    1164:	636d656d 	cmnvs	sp, #457179136	; 0x1b400000
    1168:	4b507970 	blmi	141f730 <__bss_end+0x1416700>
    116c:	69765076 	ldmdbvs	r6!, {r1, r2, r4, r5, r6, ip, lr}^
    1170:	73616200 	cmnvc	r1, #0, 4
    1174:	656d0065 	strbvs	r0, [sp, #-101]!	; 0xffffff9b
    1178:	7970636d 	ldmdbvc	r0!, {r0, r2, r3, r5, r6, r8, r9, sp, lr}^
    117c:	72747300 	rsbsvc	r7, r4, #0, 6
    1180:	006e656c 	rsbeq	r6, lr, ip, ror #10
    1184:	73375a5f 	teqvc	r7, #389120	; 0x5f000
    1188:	636e7274 	cmnvs	lr, #116, 4	; 0x40000007
    118c:	4b50706d 	blmi	141d348 <__bss_end+0x1414318>
    1190:	5f305363 	svcpl	0x00305363
    1194:	5a5f0069 	bpl	17c1340 <__bss_end+0x17b8310>
    1198:	72747336 	rsbsvc	r7, r4, #-671088640	; 0xd8000000
    119c:	506e656c 	rsbpl	r6, lr, ip, ror #10
    11a0:	6100634b 	tstvs	r0, fp, asr #6
    11a4:	00696f74 	rsbeq	r6, r9, r4, ror pc
    11a8:	73375a5f 	teqvc	r7, #389120	; 0x5f000
    11ac:	636e7274 	cmnvs	lr, #116, 4	; 0x40000007
    11b0:	63507970 	cmpvs	r0, #112, 18	; 0x1c0000
    11b4:	69634b50 	stmdbvs	r3!, {r4, r6, r8, r9, fp, lr}^
    11b8:	72747300 	rsbsvc	r7, r4, #0, 6
    11bc:	706d636e 	rsbvc	r6, sp, lr, ror #6
    11c0:	72747300 	rsbsvc	r7, r4, #0, 6
    11c4:	7970636e 	ldmdbvc	r0!, {r1, r2, r3, r5, r6, r8, r9, sp, lr}^
    11c8:	6d656d00 	stclvs	13, cr6, [r5, #-0]
    11cc:	0079726f 	rsbseq	r7, r9, pc, ror #4
    11d0:	736d656d 	cmnvc	sp, #457179136	; 0x1b400000
    11d4:	69006372 	stmdbvs	r0, {r1, r4, r5, r6, r8, r9, sp, lr}
    11d8:	00616f74 	rsbeq	r6, r1, r4, ror pc
    11dc:	69345a5f 	ldmdbvs	r4!, {r0, r1, r2, r3, r4, r6, r9, fp, ip, lr}
    11e0:	6a616f74 	bvs	185cfb8 <__bss_end+0x1853f88>
    11e4:	006a6350 	rsbeq	r6, sl, r0, asr r3

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
  20:	8b040e42 	blhi	103930 <__bss_end+0xfa900>
  24:	0b0d4201 	bleq	350830 <__bss_end+0x347800>
  28:	420d0d62 	andmi	r0, sp, #6272	; 0x1880
  2c:	00000ecb 	andeq	r0, r0, fp, asr #29
  30:	0000001c 	andeq	r0, r0, ip, lsl r0
  34:	00000000 	andeq	r0, r0, r0
  38:	00008064 	andeq	r8, r0, r4, rrx
  3c:	00000040 	andeq	r0, r0, r0, asr #32
  40:	8b080e42 	blhi	203950 <__bss_end+0x1fa920>
  44:	42018e02 	andmi	r8, r1, #2, 28
  48:	5a040b0c 	bpl	102c80 <__bss_end+0xf9c50>
  4c:	00080d0c 	andeq	r0, r8, ip, lsl #26
  50:	0000000c 	andeq	r0, r0, ip
  54:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
  58:	7c020001 	stcvc	0, cr0, [r2], {1}
  5c:	000d0c0e 	andeq	r0, sp, lr, lsl #24
  60:	0000001c 	andeq	r0, r0, ip, lsl r0
  64:	00000050 	andeq	r0, r0, r0, asr r0
  68:	000080a4 	andeq	r8, r0, r4, lsr #1
  6c:	00000038 	andeq	r0, r0, r8, lsr r0
  70:	8b040e42 	blhi	103980 <__bss_end+0xfa950>
  74:	0b0d4201 	bleq	350880 <__bss_end+0x347850>
  78:	420d0d54 	andmi	r0, sp, #84, 26	; 0x1500
  7c:	00000ecb 	andeq	r0, r0, fp, asr #29
  80:	0000001c 	andeq	r0, r0, ip, lsl r0
  84:	00000050 	andeq	r0, r0, r0, asr r0
  88:	000080dc 	ldrdeq	r8, [r0], -ip
  8c:	0000002c 	andeq	r0, r0, ip, lsr #32
  90:	8b040e42 	blhi	1039a0 <__bss_end+0xfa970>
  94:	0b0d4201 	bleq	3508a0 <__bss_end+0x347870>
  98:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
  9c:	00000ecb 	andeq	r0, r0, fp, asr #29
  a0:	0000001c 	andeq	r0, r0, ip, lsl r0
  a4:	00000050 	andeq	r0, r0, r0, asr r0
  a8:	00008108 	andeq	r8, r0, r8, lsl #2
  ac:	00000020 	andeq	r0, r0, r0, lsr #32
  b0:	8b040e42 	blhi	1039c0 <__bss_end+0xfa990>
  b4:	0b0d4201 	bleq	3508c0 <__bss_end+0x347890>
  b8:	420d0d48 	andmi	r0, sp, #72, 26	; 0x1200
  bc:	00000ecb 	andeq	r0, r0, fp, asr #29
  c0:	0000001c 	andeq	r0, r0, ip, lsl r0
  c4:	00000050 	andeq	r0, r0, r0, asr r0
  c8:	00008128 	andeq	r8, r0, r8, lsr #2
  cc:	00000018 	andeq	r0, r0, r8, lsl r0
  d0:	8b040e42 	blhi	1039e0 <__bss_end+0xfa9b0>
  d4:	0b0d4201 	bleq	3508e0 <__bss_end+0x3478b0>
  d8:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
  dc:	00000ecb 	andeq	r0, r0, fp, asr #29
  e0:	0000001c 	andeq	r0, r0, ip, lsl r0
  e4:	00000050 	andeq	r0, r0, r0, asr r0
  e8:	00008140 	andeq	r8, r0, r0, asr #2
  ec:	00000018 	andeq	r0, r0, r8, lsl r0
  f0:	8b040e42 	blhi	103a00 <__bss_end+0xfa9d0>
  f4:	0b0d4201 	bleq	350900 <__bss_end+0x3478d0>
  f8:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
  fc:	00000ecb 	andeq	r0, r0, fp, asr #29
 100:	0000001c 	andeq	r0, r0, ip, lsl r0
 104:	00000050 	andeq	r0, r0, r0, asr r0
 108:	00008158 	andeq	r8, r0, r8, asr r1
 10c:	00000018 	andeq	r0, r0, r8, lsl r0
 110:	8b040e42 	blhi	103a20 <__bss_end+0xfa9f0>
 114:	0b0d4201 	bleq	350920 <__bss_end+0x3478f0>
 118:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
 11c:	00000ecb 	andeq	r0, r0, fp, asr #29
 120:	00000014 	andeq	r0, r0, r4, lsl r0
 124:	00000050 	andeq	r0, r0, r0, asr r0
 128:	00008170 	andeq	r8, r0, r0, ror r1
 12c:	0000000c 	andeq	r0, r0, ip
 130:	8b040e42 	blhi	103a40 <__bss_end+0xfaa10>
 134:	0b0d4201 	bleq	350940 <__bss_end+0x347910>
 138:	0000001c 	andeq	r0, r0, ip, lsl r0
 13c:	00000050 	andeq	r0, r0, r0, asr r0
 140:	0000817c 	andeq	r8, r0, ip, ror r1
 144:	00000058 	andeq	r0, r0, r8, asr r0
 148:	8b080e42 	blhi	203a58 <__bss_end+0x1faa28>
 14c:	42018e02 	andmi	r8, r1, #2, 28
 150:	62040b0c 	andvs	r0, r4, #12, 22	; 0x3000
 154:	00080d0c 	andeq	r0, r8, ip, lsl #26
 158:	0000001c 	andeq	r0, r0, ip, lsl r0
 15c:	00000050 	andeq	r0, r0, r0, asr r0
 160:	000081d4 	ldrdeq	r8, [r0], -r4
 164:	00000058 	andeq	r0, r0, r8, asr r0
 168:	8b080e42 	blhi	203a78 <__bss_end+0x1faa48>
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
 194:	00000080 	andeq	r0, r0, r0, lsl #1
 198:	8b080e42 	blhi	203aa8 <__bss_end+0x1faa78>
 19c:	42018e02 	andmi	r8, r1, #2, 28
 1a0:	74040b0c 	strvc	r0, [r4], #-2828	; 0xfffff4f4
 1a4:	00080d0c 	andeq	r0, r8, ip, lsl #26
 1a8:	00000018 	andeq	r0, r0, r8, lsl r0
 1ac:	00000178 	andeq	r0, r0, r8, ror r1
 1b0:	000082ac 	andeq	r8, r0, ip, lsr #5
 1b4:	0000016c 	andeq	r0, r0, ip, ror #2
 1b8:	8b080e42 	blhi	203ac8 <__bss_end+0x1faa98>
 1bc:	42018e02 	andmi	r8, r1, #2, 28
 1c0:	00040b0c 	andeq	r0, r4, ip, lsl #22
 1c4:	0000000c 	andeq	r0, r0, ip
 1c8:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 1cc:	7c020001 	stcvc	0, cr0, [r2], {1}
 1d0:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 1d4:	0000001c 	andeq	r0, r0, ip, lsl r0
 1d8:	000001c4 	andeq	r0, r0, r4, asr #3
 1dc:	00008418 	andeq	r8, r0, r8, lsl r4
 1e0:	0000002c 	andeq	r0, r0, ip, lsr #32
 1e4:	8b040e42 	blhi	103af4 <__bss_end+0xfaac4>
 1e8:	0b0d4201 	bleq	3509f4 <__bss_end+0x3479c4>
 1ec:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
 1f0:	00000ecb 	andeq	r0, r0, fp, asr #29
 1f4:	0000001c 	andeq	r0, r0, ip, lsl r0
 1f8:	000001c4 	andeq	r0, r0, r4, asr #3
 1fc:	00008444 	andeq	r8, r0, r4, asr #8
 200:	0000002c 	andeq	r0, r0, ip, lsr #32
 204:	8b040e42 	blhi	103b14 <__bss_end+0xfaae4>
 208:	0b0d4201 	bleq	350a14 <__bss_end+0x3479e4>
 20c:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
 210:	00000ecb 	andeq	r0, r0, fp, asr #29
 214:	0000001c 	andeq	r0, r0, ip, lsl r0
 218:	000001c4 	andeq	r0, r0, r4, asr #3
 21c:	00008470 	andeq	r8, r0, r0, ror r4
 220:	0000001c 	andeq	r0, r0, ip, lsl r0
 224:	8b040e42 	blhi	103b34 <__bss_end+0xfab04>
 228:	0b0d4201 	bleq	350a34 <__bss_end+0x347a04>
 22c:	420d0d46 	andmi	r0, sp, #4480	; 0x1180
 230:	00000ecb 	andeq	r0, r0, fp, asr #29
 234:	0000001c 	andeq	r0, r0, ip, lsl r0
 238:	000001c4 	andeq	r0, r0, r4, asr #3
 23c:	0000848c 	andeq	r8, r0, ip, lsl #9
 240:	00000044 	andeq	r0, r0, r4, asr #32
 244:	8b040e42 	blhi	103b54 <__bss_end+0xfab24>
 248:	0b0d4201 	bleq	350a54 <__bss_end+0x347a24>
 24c:	420d0d5a 	andmi	r0, sp, #5760	; 0x1680
 250:	00000ecb 	andeq	r0, r0, fp, asr #29
 254:	0000001c 	andeq	r0, r0, ip, lsl r0
 258:	000001c4 	andeq	r0, r0, r4, asr #3
 25c:	000084d0 	ldrdeq	r8, [r0], -r0
 260:	00000050 	andeq	r0, r0, r0, asr r0
 264:	8b040e42 	blhi	103b74 <__bss_end+0xfab44>
 268:	0b0d4201 	bleq	350a74 <__bss_end+0x347a44>
 26c:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 270:	00000ecb 	andeq	r0, r0, fp, asr #29
 274:	0000001c 	andeq	r0, r0, ip, lsl r0
 278:	000001c4 	andeq	r0, r0, r4, asr #3
 27c:	00008520 	andeq	r8, r0, r0, lsr #10
 280:	00000050 	andeq	r0, r0, r0, asr r0
 284:	8b040e42 	blhi	103b94 <__bss_end+0xfab64>
 288:	0b0d4201 	bleq	350a94 <__bss_end+0x347a64>
 28c:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 290:	00000ecb 	andeq	r0, r0, fp, asr #29
 294:	0000001c 	andeq	r0, r0, ip, lsl r0
 298:	000001c4 	andeq	r0, r0, r4, asr #3
 29c:	00008570 	andeq	r8, r0, r0, ror r5
 2a0:	0000002c 	andeq	r0, r0, ip, lsr #32
 2a4:	8b040e42 	blhi	103bb4 <__bss_end+0xfab84>
 2a8:	0b0d4201 	bleq	350ab4 <__bss_end+0x347a84>
 2ac:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
 2b0:	00000ecb 	andeq	r0, r0, fp, asr #29
 2b4:	0000001c 	andeq	r0, r0, ip, lsl r0
 2b8:	000001c4 	andeq	r0, r0, r4, asr #3
 2bc:	0000859c 	muleq	r0, ip, r5
 2c0:	00000050 	andeq	r0, r0, r0, asr r0
 2c4:	8b040e42 	blhi	103bd4 <__bss_end+0xfaba4>
 2c8:	0b0d4201 	bleq	350ad4 <__bss_end+0x347aa4>
 2cc:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 2d0:	00000ecb 	andeq	r0, r0, fp, asr #29
 2d4:	0000001c 	andeq	r0, r0, ip, lsl r0
 2d8:	000001c4 	andeq	r0, r0, r4, asr #3
 2dc:	000085ec 	andeq	r8, r0, ip, ror #11
 2e0:	00000044 	andeq	r0, r0, r4, asr #32
 2e4:	8b040e42 	blhi	103bf4 <__bss_end+0xfabc4>
 2e8:	0b0d4201 	bleq	350af4 <__bss_end+0x347ac4>
 2ec:	420d0d5a 	andmi	r0, sp, #5760	; 0x1680
 2f0:	00000ecb 	andeq	r0, r0, fp, asr #29
 2f4:	0000001c 	andeq	r0, r0, ip, lsl r0
 2f8:	000001c4 	andeq	r0, r0, r4, asr #3
 2fc:	00008630 	andeq	r8, r0, r0, lsr r6
 300:	00000050 	andeq	r0, r0, r0, asr r0
 304:	8b040e42 	blhi	103c14 <__bss_end+0xfabe4>
 308:	0b0d4201 	bleq	350b14 <__bss_end+0x347ae4>
 30c:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 310:	00000ecb 	andeq	r0, r0, fp, asr #29
 314:	0000001c 	andeq	r0, r0, ip, lsl r0
 318:	000001c4 	andeq	r0, r0, r4, asr #3
 31c:	00008680 	andeq	r8, r0, r0, lsl #13
 320:	00000054 	andeq	r0, r0, r4, asr r0
 324:	8b040e42 	blhi	103c34 <__bss_end+0xfac04>
 328:	0b0d4201 	bleq	350b34 <__bss_end+0x347b04>
 32c:	420d0d62 	andmi	r0, sp, #6272	; 0x1880
 330:	00000ecb 	andeq	r0, r0, fp, asr #29
 334:	0000001c 	andeq	r0, r0, ip, lsl r0
 338:	000001c4 	andeq	r0, r0, r4, asr #3
 33c:	000086d4 	ldrdeq	r8, [r0], -r4
 340:	0000003c 	andeq	r0, r0, ip, lsr r0
 344:	8b040e42 	blhi	103c54 <__bss_end+0xfac24>
 348:	0b0d4201 	bleq	350b54 <__bss_end+0x347b24>
 34c:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 350:	00000ecb 	andeq	r0, r0, fp, asr #29
 354:	0000001c 	andeq	r0, r0, ip, lsl r0
 358:	000001c4 	andeq	r0, r0, r4, asr #3
 35c:	00008710 	andeq	r8, r0, r0, lsl r7
 360:	0000003c 	andeq	r0, r0, ip, lsr r0
 364:	8b040e42 	blhi	103c74 <__bss_end+0xfac44>
 368:	0b0d4201 	bleq	350b74 <__bss_end+0x347b44>
 36c:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 370:	00000ecb 	andeq	r0, r0, fp, asr #29
 374:	0000001c 	andeq	r0, r0, ip, lsl r0
 378:	000001c4 	andeq	r0, r0, r4, asr #3
 37c:	0000874c 	andeq	r8, r0, ip, asr #14
 380:	0000003c 	andeq	r0, r0, ip, lsr r0
 384:	8b040e42 	blhi	103c94 <__bss_end+0xfac64>
 388:	0b0d4201 	bleq	350b94 <__bss_end+0x347b64>
 38c:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 390:	00000ecb 	andeq	r0, r0, fp, asr #29
 394:	0000001c 	andeq	r0, r0, ip, lsl r0
 398:	000001c4 	andeq	r0, r0, r4, asr #3
 39c:	00008788 	andeq	r8, r0, r8, lsl #15
 3a0:	0000003c 	andeq	r0, r0, ip, lsr r0
 3a4:	8b040e42 	blhi	103cb4 <__bss_end+0xfac84>
 3a8:	0b0d4201 	bleq	350bb4 <__bss_end+0x347b84>
 3ac:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 3b0:	00000ecb 	andeq	r0, r0, fp, asr #29
 3b4:	0000001c 	andeq	r0, r0, ip, lsl r0
 3b8:	000001c4 	andeq	r0, r0, r4, asr #3
 3bc:	000087c4 	andeq	r8, r0, r4, asr #15
 3c0:	000000b0 	strheq	r0, [r0], -r0	; <UNPREDICTABLE>
 3c4:	8b080e42 	blhi	203cd4 <__bss_end+0x1faca4>
 3c8:	42018e02 	andmi	r8, r1, #2, 28
 3cc:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 3d0:	080d0c50 	stmdaeq	sp, {r4, r6, sl, fp}
 3d4:	0000000c 	andeq	r0, r0, ip
 3d8:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 3dc:	7c020001 	stcvc	0, cr0, [r2], {1}
 3e0:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 3e4:	0000001c 	andeq	r0, r0, ip, lsl r0
 3e8:	000003d4 	ldrdeq	r0, [r0], -r4
 3ec:	00008874 	andeq	r8, r0, r4, ror r8
 3f0:	00000174 	andeq	r0, r0, r4, ror r1
 3f4:	8b080e42 	blhi	203d04 <__bss_end+0x1facd4>
 3f8:	42018e02 	andmi	r8, r1, #2, 28
 3fc:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 400:	080d0cb2 	stmdaeq	sp, {r1, r4, r5, r7, sl, fp}
 404:	0000001c 	andeq	r0, r0, ip, lsl r0
 408:	000003d4 	ldrdeq	r0, [r0], -r4
 40c:	000089e8 	andeq	r8, r0, r8, ror #19
 410:	0000009c 	muleq	r0, ip, r0
 414:	8b040e42 	blhi	103d24 <__bss_end+0xfacf4>
 418:	0b0d4201 	bleq	350c24 <__bss_end+0x347bf4>
 41c:	0d0d4602 	stceq	6, cr4, [sp, #-8]
 420:	000ecb42 	andeq	ip, lr, r2, asr #22
 424:	0000001c 	andeq	r0, r0, ip, lsl r0
 428:	000003d4 	ldrdeq	r0, [r0], -r4
 42c:	00008a84 	andeq	r8, r0, r4, lsl #21
 430:	000000c0 	andeq	r0, r0, r0, asr #1
 434:	8b040e42 	blhi	103d44 <__bss_end+0xfad14>
 438:	0b0d4201 	bleq	350c44 <__bss_end+0x347c14>
 43c:	0d0d5802 	stceq	8, cr5, [sp, #-8]
 440:	000ecb42 	andeq	ip, lr, r2, asr #22
 444:	0000001c 	andeq	r0, r0, ip, lsl r0
 448:	000003d4 	ldrdeq	r0, [r0], -r4
 44c:	00008b44 	andeq	r8, r0, r4, asr #22
 450:	000000ac 	andeq	r0, r0, ip, lsr #1
 454:	8b040e42 	blhi	103d64 <__bss_end+0xfad34>
 458:	0b0d4201 	bleq	350c64 <__bss_end+0x347c34>
 45c:	0d0d4e02 	stceq	14, cr4, [sp, #-8]
 460:	000ecb42 	andeq	ip, lr, r2, asr #22
 464:	0000001c 	andeq	r0, r0, ip, lsl r0
 468:	000003d4 	ldrdeq	r0, [r0], -r4
 46c:	00008bf0 	strdeq	r8, [r0], -r0
 470:	00000054 	andeq	r0, r0, r4, asr r0
 474:	8b040e42 	blhi	103d84 <__bss_end+0xfad54>
 478:	0b0d4201 	bleq	350c84 <__bss_end+0x347c54>
 47c:	420d0d62 	andmi	r0, sp, #6272	; 0x1880
 480:	00000ecb 	andeq	r0, r0, fp, asr #29
 484:	0000001c 	andeq	r0, r0, ip, lsl r0
 488:	000003d4 	ldrdeq	r0, [r0], -r4
 48c:	00008c44 	andeq	r8, r0, r4, asr #24
 490:	00000068 	andeq	r0, r0, r8, rrx
 494:	8b040e42 	blhi	103da4 <__bss_end+0xfad74>
 498:	0b0d4201 	bleq	350ca4 <__bss_end+0x347c74>
 49c:	420d0d6c 	andmi	r0, sp, #108, 26	; 0x1b00
 4a0:	00000ecb 	andeq	r0, r0, fp, asr #29
 4a4:	0000001c 	andeq	r0, r0, ip, lsl r0
 4a8:	000003d4 	ldrdeq	r0, [r0], -r4
 4ac:	00008cac 	andeq	r8, r0, ip, lsr #25
 4b0:	00000080 	andeq	r0, r0, r0, lsl #1
 4b4:	8b040e42 	blhi	103dc4 <__bss_end+0xfad94>
 4b8:	0b0d4201 	bleq	350cc4 <__bss_end+0x347c94>
 4bc:	420d0d78 	andmi	r0, sp, #120, 26	; 0x1e00
 4c0:	00000ecb 	andeq	r0, r0, fp, asr #29
 4c4:	0000000c 	andeq	r0, r0, ip
 4c8:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 4cc:	7c010001 	stcvc	0, cr0, [r1], {1}
 4d0:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 4d4:	0000000c 	andeq	r0, r0, ip
 4d8:	000004c4 	andeq	r0, r0, r4, asr #9
 4dc:	00008d2c 	andeq	r8, r0, ip, lsr #26
 4e0:	000001ec 	andeq	r0, r0, ip, ror #3
