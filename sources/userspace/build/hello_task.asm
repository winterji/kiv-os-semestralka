
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
    805c:	00008f50 	andeq	r8, r0, r0, asr pc
    8060:	00008f64 	andeq	r8, r0, r4, ror #30

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
    81cc:	00008f4d 	andeq	r8, r0, sp, asr #30
    81d0:	00008f4d 	andeq	r8, r0, sp, asr #30

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
    8224:	00008f4d 	andeq	r8, r0, sp, asr #30
    8228:	00008f4d 	andeq	r8, r0, sp, asr #30

0000822c <_Z5blinkb>:
_Z5blinkb():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:19
constexpr uint32_t char_tick_delay = 0x1000;

uint32_t sos_led;

void blink(bool short_blink)
{
    822c:	e92d4800 	push	{fp, lr}
    8230:	e28db004 	add	fp, sp, #4
    8234:	e24dd008 	sub	sp, sp, #8
    8238:	e1a03000 	mov	r3, r0
    823c:	e54b3005 	strb	r3, [fp, #-5]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:20
	write(sos_led, "1", 1);
    8240:	e59f3058 	ldr	r3, [pc, #88]	; 82a0 <_Z5blinkb+0x74>
    8244:	e5933000 	ldr	r3, [r3]
    8248:	e3a02001 	mov	r2, #1
    824c:	e59f1050 	ldr	r1, [pc, #80]	; 82a4 <_Z5blinkb+0x78>
    8250:	e1a00003 	mov	r0, r3
    8254:	eb00007c 	bl	844c <_Z5writejPKcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:21
	sleep(short_blink ? 0x800 : 0x1000);
    8258:	e55b3005 	ldrb	r3, [fp, #-5]
    825c:	e3530000 	cmp	r3, #0
    8260:	0a000001 	beq	826c <_Z5blinkb+0x40>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:21 (discriminator 1)
    8264:	e3a03b02 	mov	r3, #2048	; 0x800
    8268:	ea000000 	b	8270 <_Z5blinkb+0x44>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:21 (discriminator 2)
    826c:	e3a03a01 	mov	r3, #4096	; 0x1000
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:21 (discriminator 4)
    8270:	e3e01001 	mvn	r1, #1
    8274:	e1a00003 	mov	r0, r3
    8278:	eb0000cb 	bl	85ac <_Z5sleepjj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:22 (discriminator 4)
	write(sos_led, "0", 1);
    827c:	e59f301c 	ldr	r3, [pc, #28]	; 82a0 <_Z5blinkb+0x74>
    8280:	e5933000 	ldr	r3, [r3]
    8284:	e3a02001 	mov	r2, #1
    8288:	e59f1018 	ldr	r1, [pc, #24]	; 82a8 <_Z5blinkb+0x7c>
    828c:	e1a00003 	mov	r0, r3
    8290:	eb00006d 	bl	844c <_Z5writejPKcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:23 (discriminator 4)
}
    8294:	e320f000 	nop	{0}
    8298:	e24bd004 	sub	sp, fp, #4
    829c:	e8bd8800 	pop	{fp, pc}
    82a0:	00008f50 	andeq	r8, r0, r0, asr pc
    82a4:	00008ecc 	andeq	r8, r0, ip, asr #29
    82a8:	00008ed0 	ldrdeq	r8, [r0], -r0

000082ac <main>:
main():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:26

int main(int argc, char** argv)
{
    82ac:	e92d4800 	push	{fp, lr}
    82b0:	e28db004 	add	fp, sp, #4
    82b4:	e24dd028 	sub	sp, sp, #40	; 0x28
    82b8:	e50b0028 	str	r0, [fp, #-40]	; 0xffffffd8
    82bc:	e50b102c 	str	r1, [fp, #-44]	; 0xffffffd4
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:27
    char hello[] = "Hello! I'm hello_task.\n";
    82c0:	e59f306c 	ldr	r3, [pc, #108]	; 8334 <main+0x88>
    82c4:	e24bc020 	sub	ip, fp, #32
    82c8:	e1a0e003 	mov	lr, r3
    82cc:	e8be000f 	ldm	lr!, {r0, r1, r2, r3}
    82d0:	e8ac000f 	stmia	ip!, {r0, r1, r2, r3}
    82d4:	e89e0003 	ldm	lr, {r0, r1}
    82d8:	e88c0003 	stm	ip, {r0, r1}
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:29

	sos_led = open("DEV:gpio/47", NFile_Open_Mode::Write_Only);
    82dc:	e3a01001 	mov	r1, #1
    82e0:	e59f0050 	ldr	r0, [pc, #80]	; 8338 <main+0x8c>
    82e4:	eb000033 	bl	83b8 <_Z4openPKc15NFile_Open_Mode>
    82e8:	e1a03000 	mov	r3, r0
    82ec:	e59f2048 	ldr	r2, [pc, #72]	; 833c <main+0x90>
    82f0:	e5823000 	str	r3, [r2]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:31

	uint32_t uart = open("DEV:uart/0", NFile_Open_Mode::Read_Write);
    82f4:	e3a01002 	mov	r1, #2
    82f8:	e59f0040 	ldr	r0, [pc, #64]	; 8340 <main+0x94>
    82fc:	eb00002d 	bl	83b8 <_Z4openPKc15NFile_Open_Mode>
    8300:	e50b0008 	str	r0, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:35 (discriminator 1)

	while (true)
	{
        blink(false);
    8304:	e3a00000 	mov	r0, #0
    8308:	ebffffc7 	bl	822c <_Z5blinkb>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:36 (discriminator 1)
		write(uart, hello, strlen(hello));
    830c:	e24b3020 	sub	r3, fp, #32
    8310:	e1a00003 	mov	r0, r3
    8314:	eb000200 	bl	8b1c <_Z6strlenPKc>
    8318:	e1a03000 	mov	r3, r0
    831c:	e1a02003 	mov	r2, r3
    8320:	e24b3020 	sub	r3, fp, #32
    8324:	e1a01003 	mov	r1, r3
    8328:	e51b0008 	ldr	r0, [fp, #-8]
    832c:	eb000046 	bl	844c <_Z5writejPKcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/hello_task/main.cpp:35 (discriminator 1)
        blink(false);
    8330:	eafffff3 	b	8304 <main+0x58>
    8334:	00008eec 	andeq	r8, r0, ip, ror #29
    8338:	00008ed4 	ldrdeq	r8, [r0], -r4
    833c:	00008f50 	andeq	r8, r0, r0, asr pc
    8340:	00008ee0 	andeq	r8, r0, r0, ror #29

00008344 <_Z6getpidv>:
_Z6getpidv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:5
#include <stdfile.h>
#include <stdstring.h>

uint32_t getpid()
{
    8344:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8348:	e28db000 	add	fp, sp, #0
    834c:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:8
    uint32_t pid;

    asm volatile("swi 0");
    8350:	ef000000 	svc	0x00000000
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:9
    asm volatile("mov %0, r0" : "=r" (pid));
    8354:	e1a03000 	mov	r3, r0
    8358:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:11

    return pid;
    835c:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:12
}
    8360:	e1a00003 	mov	r0, r3
    8364:	e28bd000 	add	sp, fp, #0
    8368:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    836c:	e12fff1e 	bx	lr

00008370 <_Z9terminatei>:
_Z9terminatei():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:15

void terminate(int exitcode)
{
    8370:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8374:	e28db000 	add	fp, sp, #0
    8378:	e24dd00c 	sub	sp, sp, #12
    837c:	e50b0008 	str	r0, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:16
    asm volatile("mov r0, %0" : : "r" (exitcode));
    8380:	e51b3008 	ldr	r3, [fp, #-8]
    8384:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:17
    asm volatile("swi 1");
    8388:	ef000001 	svc	0x00000001
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:18
}
    838c:	e320f000 	nop	{0}
    8390:	e28bd000 	add	sp, fp, #0
    8394:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8398:	e12fff1e 	bx	lr

0000839c <_Z11sched_yieldv>:
_Z11sched_yieldv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:21

void sched_yield()
{
    839c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    83a0:	e28db000 	add	fp, sp, #0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:22
    asm volatile("swi 2");
    83a4:	ef000002 	svc	0x00000002
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:23
}
    83a8:	e320f000 	nop	{0}
    83ac:	e28bd000 	add	sp, fp, #0
    83b0:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    83b4:	e12fff1e 	bx	lr

000083b8 <_Z4openPKc15NFile_Open_Mode>:
_Z4openPKc15NFile_Open_Mode():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:26

uint32_t open(const char* filename, NFile_Open_Mode mode)
{
    83b8:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    83bc:	e28db000 	add	fp, sp, #0
    83c0:	e24dd014 	sub	sp, sp, #20
    83c4:	e50b0010 	str	r0, [fp, #-16]
    83c8:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:29
    uint32_t file;

    asm volatile("mov r0, %0" : : "r" (filename));
    83cc:	e51b3010 	ldr	r3, [fp, #-16]
    83d0:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:30
    asm volatile("mov r1, %0" : : "r" (mode));
    83d4:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    83d8:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:31
    asm volatile("swi 64");
    83dc:	ef000040 	svc	0x00000040
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:32
    asm volatile("mov %0, r0" : "=r" (file));
    83e0:	e1a03000 	mov	r3, r0
    83e4:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:34

    return file;
    83e8:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:35
}
    83ec:	e1a00003 	mov	r0, r3
    83f0:	e28bd000 	add	sp, fp, #0
    83f4:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    83f8:	e12fff1e 	bx	lr

000083fc <_Z4readjPcj>:
_Z4readjPcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:38

uint32_t read(uint32_t file, char* const buffer, uint32_t size)
{
    83fc:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8400:	e28db000 	add	fp, sp, #0
    8404:	e24dd01c 	sub	sp, sp, #28
    8408:	e50b0010 	str	r0, [fp, #-16]
    840c:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8410:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:41
    uint32_t rdnum;

    asm volatile("mov r0, %0" : : "r" (file));
    8414:	e51b3010 	ldr	r3, [fp, #-16]
    8418:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:42
    asm volatile("mov r1, %0" : : "r" (buffer));
    841c:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8420:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:43
    asm volatile("mov r2, %0" : : "r" (size));
    8424:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8428:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:44
    asm volatile("swi 65");
    842c:	ef000041 	svc	0x00000041
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:45
    asm volatile("mov %0, r0" : "=r" (rdnum));
    8430:	e1a03000 	mov	r3, r0
    8434:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:47

    return rdnum;
    8438:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:48
}
    843c:	e1a00003 	mov	r0, r3
    8440:	e28bd000 	add	sp, fp, #0
    8444:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8448:	e12fff1e 	bx	lr

0000844c <_Z5writejPKcj>:
_Z5writejPKcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:51

uint32_t write(uint32_t file, const char* buffer, uint32_t size)
{
    844c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8450:	e28db000 	add	fp, sp, #0
    8454:	e24dd01c 	sub	sp, sp, #28
    8458:	e50b0010 	str	r0, [fp, #-16]
    845c:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8460:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:54
    uint32_t wrnum;

    asm volatile("mov r0, %0" : : "r" (file));
    8464:	e51b3010 	ldr	r3, [fp, #-16]
    8468:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:55
    asm volatile("mov r1, %0" : : "r" (buffer));
    846c:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8470:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:56
    asm volatile("mov r2, %0" : : "r" (size));
    8474:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8478:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:57
    asm volatile("swi 66");
    847c:	ef000042 	svc	0x00000042
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:58
    asm volatile("mov %0, r0" : "=r" (wrnum));
    8480:	e1a03000 	mov	r3, r0
    8484:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:60

    return wrnum;
    8488:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:61
}
    848c:	e1a00003 	mov	r0, r3
    8490:	e28bd000 	add	sp, fp, #0
    8494:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8498:	e12fff1e 	bx	lr

0000849c <_Z5closej>:
_Z5closej():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:64

void close(uint32_t file)
{
    849c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    84a0:	e28db000 	add	fp, sp, #0
    84a4:	e24dd00c 	sub	sp, sp, #12
    84a8:	e50b0008 	str	r0, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:65
    asm volatile("mov r0, %0" : : "r" (file));
    84ac:	e51b3008 	ldr	r3, [fp, #-8]
    84b0:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:66
    asm volatile("swi 67");
    84b4:	ef000043 	svc	0x00000043
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:67
}
    84b8:	e320f000 	nop	{0}
    84bc:	e28bd000 	add	sp, fp, #0
    84c0:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    84c4:	e12fff1e 	bx	lr

000084c8 <_Z5ioctlj16NIOCtl_OperationPv>:
_Z5ioctlj16NIOCtl_OperationPv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:70

uint32_t ioctl(uint32_t file, NIOCtl_Operation operation, void* param)
{
    84c8:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    84cc:	e28db000 	add	fp, sp, #0
    84d0:	e24dd01c 	sub	sp, sp, #28
    84d4:	e50b0010 	str	r0, [fp, #-16]
    84d8:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    84dc:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:73
    uint32_t retcode;

    asm volatile("mov r0, %0" : : "r" (file));
    84e0:	e51b3010 	ldr	r3, [fp, #-16]
    84e4:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:74
    asm volatile("mov r1, %0" : : "r" (operation));
    84e8:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    84ec:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:75
    asm volatile("mov r2, %0" : : "r" (param));
    84f0:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    84f4:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:76
    asm volatile("swi 68");
    84f8:	ef000044 	svc	0x00000044
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:77
    asm volatile("mov %0, r0" : "=r" (retcode));
    84fc:	e1a03000 	mov	r3, r0
    8500:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:79

    return retcode;
    8504:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:80
}
    8508:	e1a00003 	mov	r0, r3
    850c:	e28bd000 	add	sp, fp, #0
    8510:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8514:	e12fff1e 	bx	lr

00008518 <_Z6notifyjj>:
_Z6notifyjj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:83

uint32_t notify(uint32_t file, uint32_t count)
{
    8518:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    851c:	e28db000 	add	fp, sp, #0
    8520:	e24dd014 	sub	sp, sp, #20
    8524:	e50b0010 	str	r0, [fp, #-16]
    8528:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:86
    uint32_t retcnt;

    asm volatile("mov r0, %0" : : "r" (file));
    852c:	e51b3010 	ldr	r3, [fp, #-16]
    8530:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:87
    asm volatile("mov r1, %0" : : "r" (count));
    8534:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8538:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:88
    asm volatile("swi 69");
    853c:	ef000045 	svc	0x00000045
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:89
    asm volatile("mov %0, r0" : "=r" (retcnt));
    8540:	e1a03000 	mov	r3, r0
    8544:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:91

    return retcnt;
    8548:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:92
}
    854c:	e1a00003 	mov	r0, r3
    8550:	e28bd000 	add	sp, fp, #0
    8554:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8558:	e12fff1e 	bx	lr

0000855c <_Z4waitjjj>:
_Z4waitjjj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:95

NSWI_Result_Code wait(uint32_t file, uint32_t count, uint32_t notified_deadline)
{
    855c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8560:	e28db000 	add	fp, sp, #0
    8564:	e24dd01c 	sub	sp, sp, #28
    8568:	e50b0010 	str	r0, [fp, #-16]
    856c:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8570:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:98
    NSWI_Result_Code retcode;

    asm volatile("mov r0, %0" : : "r" (file));
    8574:	e51b3010 	ldr	r3, [fp, #-16]
    8578:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:99
    asm volatile("mov r1, %0" : : "r" (count));
    857c:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8580:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:100
    asm volatile("mov r2, %0" : : "r" (notified_deadline));
    8584:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8588:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:101
    asm volatile("swi 70");
    858c:	ef000046 	svc	0x00000046
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:102
    asm volatile("mov %0, r0" : "=r" (retcode));
    8590:	e1a03000 	mov	r3, r0
    8594:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:104

    return retcode;
    8598:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:105
}
    859c:	e1a00003 	mov	r0, r3
    85a0:	e28bd000 	add	sp, fp, #0
    85a4:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    85a8:	e12fff1e 	bx	lr

000085ac <_Z5sleepjj>:
_Z5sleepjj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:108

bool sleep(uint32_t ticks, uint32_t notified_deadline)
{
    85ac:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    85b0:	e28db000 	add	fp, sp, #0
    85b4:	e24dd014 	sub	sp, sp, #20
    85b8:	e50b0010 	str	r0, [fp, #-16]
    85bc:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:111
    uint32_t retcode;

    asm volatile("mov r0, %0" : : "r" (ticks));
    85c0:	e51b3010 	ldr	r3, [fp, #-16]
    85c4:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:112
    asm volatile("mov r1, %0" : : "r" (notified_deadline));
    85c8:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    85cc:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:113
    asm volatile("swi 3");
    85d0:	ef000003 	svc	0x00000003
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:114
    asm volatile("mov %0, r0" : "=r" (retcode));
    85d4:	e1a03000 	mov	r3, r0
    85d8:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:116

    return retcode;
    85dc:	e51b3008 	ldr	r3, [fp, #-8]
    85e0:	e3530000 	cmp	r3, #0
    85e4:	13a03001 	movne	r3, #1
    85e8:	03a03000 	moveq	r3, #0
    85ec:	e6ef3073 	uxtb	r3, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:117
}
    85f0:	e1a00003 	mov	r0, r3
    85f4:	e28bd000 	add	sp, fp, #0
    85f8:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    85fc:	e12fff1e 	bx	lr

00008600 <_Z24get_active_process_countv>:
_Z24get_active_process_countv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:120

uint32_t get_active_process_count()
{
    8600:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8604:	e28db000 	add	fp, sp, #0
    8608:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:121
    const NGet_Sched_Info_Type req = NGet_Sched_Info_Type::Active_Process_Count;
    860c:	e3a03000 	mov	r3, #0
    8610:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:124
    uint32_t retval;

    asm volatile("mov r0, %0" : : "r" (req));
    8614:	e3a03000 	mov	r3, #0
    8618:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:125
    asm volatile("mov r1, %0" : : "r" (&retval));
    861c:	e24b300c 	sub	r3, fp, #12
    8620:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:126
    asm volatile("swi 4");
    8624:	ef000004 	svc	0x00000004
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:128

    return retval;
    8628:	e51b300c 	ldr	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:129
}
    862c:	e1a00003 	mov	r0, r3
    8630:	e28bd000 	add	sp, fp, #0
    8634:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8638:	e12fff1e 	bx	lr

0000863c <_Z14get_tick_countv>:
_Z14get_tick_countv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:132

uint32_t get_tick_count()
{
    863c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8640:	e28db000 	add	fp, sp, #0
    8644:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:133
    const NGet_Sched_Info_Type req = NGet_Sched_Info_Type::Tick_Count;
    8648:	e3a03001 	mov	r3, #1
    864c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:136
    uint32_t retval;

    asm volatile("mov r0, %0" : : "r" (req));
    8650:	e3a03001 	mov	r3, #1
    8654:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:137
    asm volatile("mov r1, %0" : : "r" (&retval));
    8658:	e24b300c 	sub	r3, fp, #12
    865c:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:138
    asm volatile("swi 4");
    8660:	ef000004 	svc	0x00000004
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:140

    return retval;
    8664:	e51b300c 	ldr	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:141
}
    8668:	e1a00003 	mov	r0, r3
    866c:	e28bd000 	add	sp, fp, #0
    8670:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8674:	e12fff1e 	bx	lr

00008678 <_Z17set_task_deadlinej>:
_Z17set_task_deadlinej():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:144

void set_task_deadline(uint32_t tick_count_required)
{
    8678:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    867c:	e28db000 	add	fp, sp, #0
    8680:	e24dd014 	sub	sp, sp, #20
    8684:	e50b0010 	str	r0, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:145
    const NDeadline_Subservice req = NDeadline_Subservice::Set_Relative;
    8688:	e3a03000 	mov	r3, #0
    868c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:147

    asm volatile("mov r0, %0" : : "r" (req));
    8690:	e3a03000 	mov	r3, #0
    8694:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:148
    asm volatile("mov r1, %0" : : "r" (&tick_count_required));
    8698:	e24b3010 	sub	r3, fp, #16
    869c:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:149
    asm volatile("swi 5");
    86a0:	ef000005 	svc	0x00000005
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:150
}
    86a4:	e320f000 	nop	{0}
    86a8:	e28bd000 	add	sp, fp, #0
    86ac:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    86b0:	e12fff1e 	bx	lr

000086b4 <_Z26get_task_ticks_to_deadlinev>:
_Z26get_task_ticks_to_deadlinev():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:153

uint32_t get_task_ticks_to_deadline()
{
    86b4:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    86b8:	e28db000 	add	fp, sp, #0
    86bc:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:154
    const NDeadline_Subservice req = NDeadline_Subservice::Get_Remaining;
    86c0:	e3a03001 	mov	r3, #1
    86c4:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:157
    uint32_t ticks;

    asm volatile("mov r0, %0" : : "r" (req));
    86c8:	e3a03001 	mov	r3, #1
    86cc:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:158
    asm volatile("mov r1, %0" : : "r" (&ticks));
    86d0:	e24b300c 	sub	r3, fp, #12
    86d4:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:159
    asm volatile("swi 5");
    86d8:	ef000005 	svc	0x00000005
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:161

    return ticks;
    86dc:	e51b300c 	ldr	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:162
}
    86e0:	e1a00003 	mov	r0, r3
    86e4:	e28bd000 	add	sp, fp, #0
    86e8:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    86ec:	e12fff1e 	bx	lr

000086f0 <_Z4pipePKcj>:
_Z4pipePKcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:167

const char Pipe_File_Prefix[] = "SYS:pipe/";

uint32_t pipe(const char* name, uint32_t buf_size)
{
    86f0:	e92d4800 	push	{fp, lr}
    86f4:	e28db004 	add	fp, sp, #4
    86f8:	e24dd050 	sub	sp, sp, #80	; 0x50
    86fc:	e50b0050 	str	r0, [fp, #-80]	; 0xffffffb0
    8700:	e50b1054 	str	r1, [fp, #-84]	; 0xffffffac
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:169
    char fname[64];
    strncpy(fname, Pipe_File_Prefix, sizeof(Pipe_File_Prefix));
    8704:	e24b3048 	sub	r3, fp, #72	; 0x48
    8708:	e3a0200a 	mov	r2, #10
    870c:	e59f1088 	ldr	r1, [pc, #136]	; 879c <_Z4pipePKcj+0xac>
    8710:	e1a00003 	mov	r0, r3
    8714:	eb0000a5 	bl	89b0 <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:170
    strncpy(fname + sizeof(Pipe_File_Prefix), name, sizeof(fname) - sizeof(Pipe_File_Prefix) - 1);
    8718:	e24b3048 	sub	r3, fp, #72	; 0x48
    871c:	e283300a 	add	r3, r3, #10
    8720:	e3a02035 	mov	r2, #53	; 0x35
    8724:	e51b1050 	ldr	r1, [fp, #-80]	; 0xffffffb0
    8728:	e1a00003 	mov	r0, r3
    872c:	eb00009f 	bl	89b0 <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:172

    int ncur = sizeof(Pipe_File_Prefix) + strlen(name);
    8730:	e51b0050 	ldr	r0, [fp, #-80]	; 0xffffffb0
    8734:	eb0000f8 	bl	8b1c <_Z6strlenPKc>
    8738:	e1a03000 	mov	r3, r0
    873c:	e283300a 	add	r3, r3, #10
    8740:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:174

    fname[ncur++] = '#';
    8744:	e51b3008 	ldr	r3, [fp, #-8]
    8748:	e2832001 	add	r2, r3, #1
    874c:	e50b2008 	str	r2, [fp, #-8]
    8750:	e2433004 	sub	r3, r3, #4
    8754:	e083300b 	add	r3, r3, fp
    8758:	e3a02023 	mov	r2, #35	; 0x23
    875c:	e5432044 	strb	r2, [r3, #-68]	; 0xffffffbc
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:176

    itoa(buf_size, &fname[ncur], 10);
    8760:	e24b2048 	sub	r2, fp, #72	; 0x48
    8764:	e51b3008 	ldr	r3, [fp, #-8]
    8768:	e0823003 	add	r3, r2, r3
    876c:	e3a0200a 	mov	r2, #10
    8770:	e1a01003 	mov	r1, r3
    8774:	e51b0054 	ldr	r0, [fp, #-84]	; 0xffffffac
    8778:	eb000008 	bl	87a0 <_Z4itoajPcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:178

    return open(fname, NFile_Open_Mode::Read_Write);
    877c:	e24b3048 	sub	r3, fp, #72	; 0x48
    8780:	e3a01002 	mov	r1, #2
    8784:	e1a00003 	mov	r0, r3
    8788:	ebffff0a 	bl	83b8 <_Z4openPKc15NFile_Open_Mode>
    878c:	e1a03000 	mov	r3, r0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:179
}
    8790:	e1a00003 	mov	r0, r3
    8794:	e24bd004 	sub	sp, fp, #4
    8798:	e8bd8800 	pop	{fp, pc}
    879c:	00008f30 	andeq	r8, r0, r0, lsr pc

000087a0 <_Z4itoajPcj>:
_Z4itoajPcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:9
{
    const char CharConvArr[] = "0123456789ABCDEF";
}

void itoa(unsigned int input, char* output, unsigned int base)
{
    87a0:	e92d4800 	push	{fp, lr}
    87a4:	e28db004 	add	fp, sp, #4
    87a8:	e24dd020 	sub	sp, sp, #32
    87ac:	e50b0018 	str	r0, [fp, #-24]	; 0xffffffe8
    87b0:	e50b101c 	str	r1, [fp, #-28]	; 0xffffffe4
    87b4:	e50b2020 	str	r2, [fp, #-32]	; 0xffffffe0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:10
	int i = 0;
    87b8:	e3a03000 	mov	r3, #0
    87bc:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:12

	while (input > 0)
    87c0:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    87c4:	e3530000 	cmp	r3, #0
    87c8:	0a000014 	beq	8820 <_Z4itoajPcj+0x80>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:14
	{
		output[i] = CharConvArr[input % base];
    87cc:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    87d0:	e51b1020 	ldr	r1, [fp, #-32]	; 0xffffffe0
    87d4:	e1a00003 	mov	r0, r3
    87d8:	eb000199 	bl	8e44 <__aeabi_uidivmod>
    87dc:	e1a03001 	mov	r3, r1
    87e0:	e1a01003 	mov	r1, r3
    87e4:	e51b3008 	ldr	r3, [fp, #-8]
    87e8:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    87ec:	e0823003 	add	r3, r2, r3
    87f0:	e59f2118 	ldr	r2, [pc, #280]	; 8910 <_Z4itoajPcj+0x170>
    87f4:	e7d22001 	ldrb	r2, [r2, r1]
    87f8:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:15
		input /= base;
    87fc:	e51b1020 	ldr	r1, [fp, #-32]	; 0xffffffe0
    8800:	e51b0018 	ldr	r0, [fp, #-24]	; 0xffffffe8
    8804:	eb000113 	bl	8c58 <__udivsi3>
    8808:	e1a03000 	mov	r3, r0
    880c:	e50b3018 	str	r3, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:16
		i++;
    8810:	e51b3008 	ldr	r3, [fp, #-8]
    8814:	e2833001 	add	r3, r3, #1
    8818:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:12
	while (input > 0)
    881c:	eaffffe7 	b	87c0 <_Z4itoajPcj+0x20>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:19
	}

    if (i == 0)
    8820:	e51b3008 	ldr	r3, [fp, #-8]
    8824:	e3530000 	cmp	r3, #0
    8828:	1a000007 	bne	884c <_Z4itoajPcj+0xac>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:21
    {
        output[i] = CharConvArr[0];
    882c:	e51b3008 	ldr	r3, [fp, #-8]
    8830:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    8834:	e0823003 	add	r3, r2, r3
    8838:	e3a02030 	mov	r2, #48	; 0x30
    883c:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:22
        i++;
    8840:	e51b3008 	ldr	r3, [fp, #-8]
    8844:	e2833001 	add	r3, r3, #1
    8848:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:25
    }

	output[i] = '\0';
    884c:	e51b3008 	ldr	r3, [fp, #-8]
    8850:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    8854:	e0823003 	add	r3, r2, r3
    8858:	e3a02000 	mov	r2, #0
    885c:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:26
	i--;
    8860:	e51b3008 	ldr	r3, [fp, #-8]
    8864:	e2433001 	sub	r3, r3, #1
    8868:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:28

	for (int j = 0; j <= i/2; j++)
    886c:	e3a03000 	mov	r3, #0
    8870:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:28 (discriminator 3)
    8874:	e51b3008 	ldr	r3, [fp, #-8]
    8878:	e1a02fa3 	lsr	r2, r3, #31
    887c:	e0823003 	add	r3, r2, r3
    8880:	e1a030c3 	asr	r3, r3, #1
    8884:	e1a02003 	mov	r2, r3
    8888:	e51b300c 	ldr	r3, [fp, #-12]
    888c:	e1530002 	cmp	r3, r2
    8890:	ca00001b 	bgt	8904 <_Z4itoajPcj+0x164>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:30 (discriminator 2)
	{
		char c = output[i - j];
    8894:	e51b2008 	ldr	r2, [fp, #-8]
    8898:	e51b300c 	ldr	r3, [fp, #-12]
    889c:	e0423003 	sub	r3, r2, r3
    88a0:	e1a02003 	mov	r2, r3
    88a4:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    88a8:	e0833002 	add	r3, r3, r2
    88ac:	e5d33000 	ldrb	r3, [r3]
    88b0:	e54b300d 	strb	r3, [fp, #-13]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:31 (discriminator 2)
		output[i - j] = output[j];
    88b4:	e51b300c 	ldr	r3, [fp, #-12]
    88b8:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    88bc:	e0822003 	add	r2, r2, r3
    88c0:	e51b1008 	ldr	r1, [fp, #-8]
    88c4:	e51b300c 	ldr	r3, [fp, #-12]
    88c8:	e0413003 	sub	r3, r1, r3
    88cc:	e1a01003 	mov	r1, r3
    88d0:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    88d4:	e0833001 	add	r3, r3, r1
    88d8:	e5d22000 	ldrb	r2, [r2]
    88dc:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:32 (discriminator 2)
		output[j] = c;
    88e0:	e51b300c 	ldr	r3, [fp, #-12]
    88e4:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    88e8:	e0823003 	add	r3, r2, r3
    88ec:	e55b200d 	ldrb	r2, [fp, #-13]
    88f0:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:28 (discriminator 2)
	for (int j = 0; j <= i/2; j++)
    88f4:	e51b300c 	ldr	r3, [fp, #-12]
    88f8:	e2833001 	add	r3, r3, #1
    88fc:	e50b300c 	str	r3, [fp, #-12]
    8900:	eaffffdb 	b	8874 <_Z4itoajPcj+0xd4>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:34
	}
}
    8904:	e320f000 	nop	{0}
    8908:	e24bd004 	sub	sp, fp, #4
    890c:	e8bd8800 	pop	{fp, pc}
    8910:	00008f3c 	andeq	r8, r0, ip, lsr pc

00008914 <_Z4atoiPKc>:
_Z4atoiPKc():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:37

int atoi(const char* input)
{
    8914:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8918:	e28db000 	add	fp, sp, #0
    891c:	e24dd014 	sub	sp, sp, #20
    8920:	e50b0010 	str	r0, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:38
	int output = 0;
    8924:	e3a03000 	mov	r3, #0
    8928:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:40

	while (*input != '\0')
    892c:	e51b3010 	ldr	r3, [fp, #-16]
    8930:	e5d33000 	ldrb	r3, [r3]
    8934:	e3530000 	cmp	r3, #0
    8938:	0a000017 	beq	899c <_Z4atoiPKc+0x88>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:42
	{
		output *= 10;
    893c:	e51b2008 	ldr	r2, [fp, #-8]
    8940:	e1a03002 	mov	r3, r2
    8944:	e1a03103 	lsl	r3, r3, #2
    8948:	e0833002 	add	r3, r3, r2
    894c:	e1a03083 	lsl	r3, r3, #1
    8950:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:43
		if (*input > '9' || *input < '0')
    8954:	e51b3010 	ldr	r3, [fp, #-16]
    8958:	e5d33000 	ldrb	r3, [r3]
    895c:	e3530039 	cmp	r3, #57	; 0x39
    8960:	8a00000d 	bhi	899c <_Z4atoiPKc+0x88>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:43 (discriminator 1)
    8964:	e51b3010 	ldr	r3, [fp, #-16]
    8968:	e5d33000 	ldrb	r3, [r3]
    896c:	e353002f 	cmp	r3, #47	; 0x2f
    8970:	9a000009 	bls	899c <_Z4atoiPKc+0x88>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:46
			break;

		output += *input - '0';
    8974:	e51b3010 	ldr	r3, [fp, #-16]
    8978:	e5d33000 	ldrb	r3, [r3]
    897c:	e2433030 	sub	r3, r3, #48	; 0x30
    8980:	e51b2008 	ldr	r2, [fp, #-8]
    8984:	e0823003 	add	r3, r2, r3
    8988:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:48

		input++;
    898c:	e51b3010 	ldr	r3, [fp, #-16]
    8990:	e2833001 	add	r3, r3, #1
    8994:	e50b3010 	str	r3, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:40
	while (*input != '\0')
    8998:	eaffffe3 	b	892c <_Z4atoiPKc+0x18>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:51
	}

	return output;
    899c:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:52
}
    89a0:	e1a00003 	mov	r0, r3
    89a4:	e28bd000 	add	sp, fp, #0
    89a8:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    89ac:	e12fff1e 	bx	lr

000089b0 <_Z7strncpyPcPKci>:
_Z7strncpyPcPKci():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:55

char* strncpy(char* dest, const char *src, int num)
{
    89b0:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    89b4:	e28db000 	add	fp, sp, #0
    89b8:	e24dd01c 	sub	sp, sp, #28
    89bc:	e50b0010 	str	r0, [fp, #-16]
    89c0:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    89c4:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:58
	int i;

	for (i = 0; i < num && src[i] != '\0'; i++)
    89c8:	e3a03000 	mov	r3, #0
    89cc:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:58 (discriminator 4)
    89d0:	e51b2008 	ldr	r2, [fp, #-8]
    89d4:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    89d8:	e1520003 	cmp	r2, r3
    89dc:	aa000011 	bge	8a28 <_Z7strncpyPcPKci+0x78>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:58 (discriminator 2)
    89e0:	e51b3008 	ldr	r3, [fp, #-8]
    89e4:	e51b2014 	ldr	r2, [fp, #-20]	; 0xffffffec
    89e8:	e0823003 	add	r3, r2, r3
    89ec:	e5d33000 	ldrb	r3, [r3]
    89f0:	e3530000 	cmp	r3, #0
    89f4:	0a00000b 	beq	8a28 <_Z7strncpyPcPKci+0x78>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:59 (discriminator 3)
		dest[i] = src[i];
    89f8:	e51b3008 	ldr	r3, [fp, #-8]
    89fc:	e51b2014 	ldr	r2, [fp, #-20]	; 0xffffffec
    8a00:	e0822003 	add	r2, r2, r3
    8a04:	e51b3008 	ldr	r3, [fp, #-8]
    8a08:	e51b1010 	ldr	r1, [fp, #-16]
    8a0c:	e0813003 	add	r3, r1, r3
    8a10:	e5d22000 	ldrb	r2, [r2]
    8a14:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:58 (discriminator 3)
	for (i = 0; i < num && src[i] != '\0'; i++)
    8a18:	e51b3008 	ldr	r3, [fp, #-8]
    8a1c:	e2833001 	add	r3, r3, #1
    8a20:	e50b3008 	str	r3, [fp, #-8]
    8a24:	eaffffe9 	b	89d0 <_Z7strncpyPcPKci+0x20>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:60 (discriminator 2)
	for (; i < num; i++)
    8a28:	e51b2008 	ldr	r2, [fp, #-8]
    8a2c:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8a30:	e1520003 	cmp	r2, r3
    8a34:	aa000008 	bge	8a5c <_Z7strncpyPcPKci+0xac>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:61 (discriminator 1)
		dest[i] = '\0';
    8a38:	e51b3008 	ldr	r3, [fp, #-8]
    8a3c:	e51b2010 	ldr	r2, [fp, #-16]
    8a40:	e0823003 	add	r3, r2, r3
    8a44:	e3a02000 	mov	r2, #0
    8a48:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:60 (discriminator 1)
	for (; i < num; i++)
    8a4c:	e51b3008 	ldr	r3, [fp, #-8]
    8a50:	e2833001 	add	r3, r3, #1
    8a54:	e50b3008 	str	r3, [fp, #-8]
    8a58:	eafffff2 	b	8a28 <_Z7strncpyPcPKci+0x78>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:63

   return dest;
    8a5c:	e51b3010 	ldr	r3, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:64
}
    8a60:	e1a00003 	mov	r0, r3
    8a64:	e28bd000 	add	sp, fp, #0
    8a68:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8a6c:	e12fff1e 	bx	lr

00008a70 <_Z7strncmpPKcS0_i>:
_Z7strncmpPKcS0_i():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:67

int strncmp(const char *s1, const char *s2, int num)
{
    8a70:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8a74:	e28db000 	add	fp, sp, #0
    8a78:	e24dd01c 	sub	sp, sp, #28
    8a7c:	e50b0010 	str	r0, [fp, #-16]
    8a80:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8a84:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:69
	unsigned char u1, u2;
  	while (num-- > 0)
    8a88:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8a8c:	e2432001 	sub	r2, r3, #1
    8a90:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
    8a94:	e3530000 	cmp	r3, #0
    8a98:	c3a03001 	movgt	r3, #1
    8a9c:	d3a03000 	movle	r3, #0
    8aa0:	e6ef3073 	uxtb	r3, r3
    8aa4:	e3530000 	cmp	r3, #0
    8aa8:	0a000016 	beq	8b08 <_Z7strncmpPKcS0_i+0x98>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:71
    {
      	u1 = (unsigned char) *s1++;
    8aac:	e51b3010 	ldr	r3, [fp, #-16]
    8ab0:	e2832001 	add	r2, r3, #1
    8ab4:	e50b2010 	str	r2, [fp, #-16]
    8ab8:	e5d33000 	ldrb	r3, [r3]
    8abc:	e54b3005 	strb	r3, [fp, #-5]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:72
     	u2 = (unsigned char) *s2++;
    8ac0:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8ac4:	e2832001 	add	r2, r3, #1
    8ac8:	e50b2014 	str	r2, [fp, #-20]	; 0xffffffec
    8acc:	e5d33000 	ldrb	r3, [r3]
    8ad0:	e54b3006 	strb	r3, [fp, #-6]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:73
      	if (u1 != u2)
    8ad4:	e55b2005 	ldrb	r2, [fp, #-5]
    8ad8:	e55b3006 	ldrb	r3, [fp, #-6]
    8adc:	e1520003 	cmp	r2, r3
    8ae0:	0a000003 	beq	8af4 <_Z7strncmpPKcS0_i+0x84>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:74
        	return u1 - u2;
    8ae4:	e55b2005 	ldrb	r2, [fp, #-5]
    8ae8:	e55b3006 	ldrb	r3, [fp, #-6]
    8aec:	e0423003 	sub	r3, r2, r3
    8af0:	ea000005 	b	8b0c <_Z7strncmpPKcS0_i+0x9c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:75
      	if (u1 == '\0')
    8af4:	e55b3005 	ldrb	r3, [fp, #-5]
    8af8:	e3530000 	cmp	r3, #0
    8afc:	1affffe1 	bne	8a88 <_Z7strncmpPKcS0_i+0x18>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:76
        	return 0;
    8b00:	e3a03000 	mov	r3, #0
    8b04:	ea000000 	b	8b0c <_Z7strncmpPKcS0_i+0x9c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:79
    }

  	return 0;
    8b08:	e3a03000 	mov	r3, #0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:80
}
    8b0c:	e1a00003 	mov	r0, r3
    8b10:	e28bd000 	add	sp, fp, #0
    8b14:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8b18:	e12fff1e 	bx	lr

00008b1c <_Z6strlenPKc>:
_Z6strlenPKc():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:83

int strlen(const char* s)
{
    8b1c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8b20:	e28db000 	add	fp, sp, #0
    8b24:	e24dd014 	sub	sp, sp, #20
    8b28:	e50b0010 	str	r0, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:84
	int i = 0;
    8b2c:	e3a03000 	mov	r3, #0
    8b30:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:86

	while (s[i] != '\0')
    8b34:	e51b3008 	ldr	r3, [fp, #-8]
    8b38:	e51b2010 	ldr	r2, [fp, #-16]
    8b3c:	e0823003 	add	r3, r2, r3
    8b40:	e5d33000 	ldrb	r3, [r3]
    8b44:	e3530000 	cmp	r3, #0
    8b48:	0a000003 	beq	8b5c <_Z6strlenPKc+0x40>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:87
		i++;
    8b4c:	e51b3008 	ldr	r3, [fp, #-8]
    8b50:	e2833001 	add	r3, r3, #1
    8b54:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:86
	while (s[i] != '\0')
    8b58:	eafffff5 	b	8b34 <_Z6strlenPKc+0x18>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:89

	return i;
    8b5c:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:90
}
    8b60:	e1a00003 	mov	r0, r3
    8b64:	e28bd000 	add	sp, fp, #0
    8b68:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8b6c:	e12fff1e 	bx	lr

00008b70 <_Z5bzeroPvi>:
_Z5bzeroPvi():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:93

void bzero(void* memory, int length)
{
    8b70:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8b74:	e28db000 	add	fp, sp, #0
    8b78:	e24dd014 	sub	sp, sp, #20
    8b7c:	e50b0010 	str	r0, [fp, #-16]
    8b80:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:94
	char* mem = reinterpret_cast<char*>(memory);
    8b84:	e51b3010 	ldr	r3, [fp, #-16]
    8b88:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:96

	for (int i = 0; i < length; i++)
    8b8c:	e3a03000 	mov	r3, #0
    8b90:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:96 (discriminator 3)
    8b94:	e51b2008 	ldr	r2, [fp, #-8]
    8b98:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8b9c:	e1520003 	cmp	r2, r3
    8ba0:	aa000008 	bge	8bc8 <_Z5bzeroPvi+0x58>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:97 (discriminator 2)
		mem[i] = 0;
    8ba4:	e51b3008 	ldr	r3, [fp, #-8]
    8ba8:	e51b200c 	ldr	r2, [fp, #-12]
    8bac:	e0823003 	add	r3, r2, r3
    8bb0:	e3a02000 	mov	r2, #0
    8bb4:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:96 (discriminator 2)
	for (int i = 0; i < length; i++)
    8bb8:	e51b3008 	ldr	r3, [fp, #-8]
    8bbc:	e2833001 	add	r3, r3, #1
    8bc0:	e50b3008 	str	r3, [fp, #-8]
    8bc4:	eafffff2 	b	8b94 <_Z5bzeroPvi+0x24>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:98
}
    8bc8:	e320f000 	nop	{0}
    8bcc:	e28bd000 	add	sp, fp, #0
    8bd0:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8bd4:	e12fff1e 	bx	lr

00008bd8 <_Z6memcpyPKvPvi>:
_Z6memcpyPKvPvi():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:101

void memcpy(const void* src, void* dst, int num)
{
    8bd8:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8bdc:	e28db000 	add	fp, sp, #0
    8be0:	e24dd024 	sub	sp, sp, #36	; 0x24
    8be4:	e50b0018 	str	r0, [fp, #-24]	; 0xffffffe8
    8be8:	e50b101c 	str	r1, [fp, #-28]	; 0xffffffe4
    8bec:	e50b2020 	str	r2, [fp, #-32]	; 0xffffffe0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:102
	const char* memsrc = reinterpret_cast<const char*>(src);
    8bf0:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8bf4:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:103
	char* memdst = reinterpret_cast<char*>(dst);
    8bf8:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    8bfc:	e50b3010 	str	r3, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:105

	for (int i = 0; i < num; i++)
    8c00:	e3a03000 	mov	r3, #0
    8c04:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:105 (discriminator 3)
    8c08:	e51b2008 	ldr	r2, [fp, #-8]
    8c0c:	e51b3020 	ldr	r3, [fp, #-32]	; 0xffffffe0
    8c10:	e1520003 	cmp	r2, r3
    8c14:	aa00000b 	bge	8c48 <_Z6memcpyPKvPvi+0x70>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:106 (discriminator 2)
		memdst[i] = memsrc[i];
    8c18:	e51b3008 	ldr	r3, [fp, #-8]
    8c1c:	e51b200c 	ldr	r2, [fp, #-12]
    8c20:	e0822003 	add	r2, r2, r3
    8c24:	e51b3008 	ldr	r3, [fp, #-8]
    8c28:	e51b1010 	ldr	r1, [fp, #-16]
    8c2c:	e0813003 	add	r3, r1, r3
    8c30:	e5d22000 	ldrb	r2, [r2]
    8c34:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:105 (discriminator 2)
	for (int i = 0; i < num; i++)
    8c38:	e51b3008 	ldr	r3, [fp, #-8]
    8c3c:	e2833001 	add	r3, r3, #1
    8c40:	e50b3008 	str	r3, [fp, #-8]
    8c44:	eaffffef 	b	8c08 <_Z6memcpyPKvPvi+0x30>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:107
}
    8c48:	e320f000 	nop	{0}
    8c4c:	e28bd000 	add	sp, fp, #0
    8c50:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8c54:	e12fff1e 	bx	lr

00008c58 <__udivsi3>:
__udivsi3():
    8c58:	e2512001 	subs	r2, r1, #1
    8c5c:	012fff1e 	bxeq	lr
    8c60:	3a000074 	bcc	8e38 <__udivsi3+0x1e0>
    8c64:	e1500001 	cmp	r0, r1
    8c68:	9a00006b 	bls	8e1c <__udivsi3+0x1c4>
    8c6c:	e1110002 	tst	r1, r2
    8c70:	0a00006c 	beq	8e28 <__udivsi3+0x1d0>
    8c74:	e16f3f10 	clz	r3, r0
    8c78:	e16f2f11 	clz	r2, r1
    8c7c:	e0423003 	sub	r3, r2, r3
    8c80:	e273301f 	rsbs	r3, r3, #31
    8c84:	10833083 	addne	r3, r3, r3, lsl #1
    8c88:	e3a02000 	mov	r2, #0
    8c8c:	108ff103 	addne	pc, pc, r3, lsl #2
    8c90:	e1a00000 	nop			; (mov r0, r0)
    8c94:	e1500f81 	cmp	r0, r1, lsl #31
    8c98:	e0a22002 	adc	r2, r2, r2
    8c9c:	20400f81 	subcs	r0, r0, r1, lsl #31
    8ca0:	e1500f01 	cmp	r0, r1, lsl #30
    8ca4:	e0a22002 	adc	r2, r2, r2
    8ca8:	20400f01 	subcs	r0, r0, r1, lsl #30
    8cac:	e1500e81 	cmp	r0, r1, lsl #29
    8cb0:	e0a22002 	adc	r2, r2, r2
    8cb4:	20400e81 	subcs	r0, r0, r1, lsl #29
    8cb8:	e1500e01 	cmp	r0, r1, lsl #28
    8cbc:	e0a22002 	adc	r2, r2, r2
    8cc0:	20400e01 	subcs	r0, r0, r1, lsl #28
    8cc4:	e1500d81 	cmp	r0, r1, lsl #27
    8cc8:	e0a22002 	adc	r2, r2, r2
    8ccc:	20400d81 	subcs	r0, r0, r1, lsl #27
    8cd0:	e1500d01 	cmp	r0, r1, lsl #26
    8cd4:	e0a22002 	adc	r2, r2, r2
    8cd8:	20400d01 	subcs	r0, r0, r1, lsl #26
    8cdc:	e1500c81 	cmp	r0, r1, lsl #25
    8ce0:	e0a22002 	adc	r2, r2, r2
    8ce4:	20400c81 	subcs	r0, r0, r1, lsl #25
    8ce8:	e1500c01 	cmp	r0, r1, lsl #24
    8cec:	e0a22002 	adc	r2, r2, r2
    8cf0:	20400c01 	subcs	r0, r0, r1, lsl #24
    8cf4:	e1500b81 	cmp	r0, r1, lsl #23
    8cf8:	e0a22002 	adc	r2, r2, r2
    8cfc:	20400b81 	subcs	r0, r0, r1, lsl #23
    8d00:	e1500b01 	cmp	r0, r1, lsl #22
    8d04:	e0a22002 	adc	r2, r2, r2
    8d08:	20400b01 	subcs	r0, r0, r1, lsl #22
    8d0c:	e1500a81 	cmp	r0, r1, lsl #21
    8d10:	e0a22002 	adc	r2, r2, r2
    8d14:	20400a81 	subcs	r0, r0, r1, lsl #21
    8d18:	e1500a01 	cmp	r0, r1, lsl #20
    8d1c:	e0a22002 	adc	r2, r2, r2
    8d20:	20400a01 	subcs	r0, r0, r1, lsl #20
    8d24:	e1500981 	cmp	r0, r1, lsl #19
    8d28:	e0a22002 	adc	r2, r2, r2
    8d2c:	20400981 	subcs	r0, r0, r1, lsl #19
    8d30:	e1500901 	cmp	r0, r1, lsl #18
    8d34:	e0a22002 	adc	r2, r2, r2
    8d38:	20400901 	subcs	r0, r0, r1, lsl #18
    8d3c:	e1500881 	cmp	r0, r1, lsl #17
    8d40:	e0a22002 	adc	r2, r2, r2
    8d44:	20400881 	subcs	r0, r0, r1, lsl #17
    8d48:	e1500801 	cmp	r0, r1, lsl #16
    8d4c:	e0a22002 	adc	r2, r2, r2
    8d50:	20400801 	subcs	r0, r0, r1, lsl #16
    8d54:	e1500781 	cmp	r0, r1, lsl #15
    8d58:	e0a22002 	adc	r2, r2, r2
    8d5c:	20400781 	subcs	r0, r0, r1, lsl #15
    8d60:	e1500701 	cmp	r0, r1, lsl #14
    8d64:	e0a22002 	adc	r2, r2, r2
    8d68:	20400701 	subcs	r0, r0, r1, lsl #14
    8d6c:	e1500681 	cmp	r0, r1, lsl #13
    8d70:	e0a22002 	adc	r2, r2, r2
    8d74:	20400681 	subcs	r0, r0, r1, lsl #13
    8d78:	e1500601 	cmp	r0, r1, lsl #12
    8d7c:	e0a22002 	adc	r2, r2, r2
    8d80:	20400601 	subcs	r0, r0, r1, lsl #12
    8d84:	e1500581 	cmp	r0, r1, lsl #11
    8d88:	e0a22002 	adc	r2, r2, r2
    8d8c:	20400581 	subcs	r0, r0, r1, lsl #11
    8d90:	e1500501 	cmp	r0, r1, lsl #10
    8d94:	e0a22002 	adc	r2, r2, r2
    8d98:	20400501 	subcs	r0, r0, r1, lsl #10
    8d9c:	e1500481 	cmp	r0, r1, lsl #9
    8da0:	e0a22002 	adc	r2, r2, r2
    8da4:	20400481 	subcs	r0, r0, r1, lsl #9
    8da8:	e1500401 	cmp	r0, r1, lsl #8
    8dac:	e0a22002 	adc	r2, r2, r2
    8db0:	20400401 	subcs	r0, r0, r1, lsl #8
    8db4:	e1500381 	cmp	r0, r1, lsl #7
    8db8:	e0a22002 	adc	r2, r2, r2
    8dbc:	20400381 	subcs	r0, r0, r1, lsl #7
    8dc0:	e1500301 	cmp	r0, r1, lsl #6
    8dc4:	e0a22002 	adc	r2, r2, r2
    8dc8:	20400301 	subcs	r0, r0, r1, lsl #6
    8dcc:	e1500281 	cmp	r0, r1, lsl #5
    8dd0:	e0a22002 	adc	r2, r2, r2
    8dd4:	20400281 	subcs	r0, r0, r1, lsl #5
    8dd8:	e1500201 	cmp	r0, r1, lsl #4
    8ddc:	e0a22002 	adc	r2, r2, r2
    8de0:	20400201 	subcs	r0, r0, r1, lsl #4
    8de4:	e1500181 	cmp	r0, r1, lsl #3
    8de8:	e0a22002 	adc	r2, r2, r2
    8dec:	20400181 	subcs	r0, r0, r1, lsl #3
    8df0:	e1500101 	cmp	r0, r1, lsl #2
    8df4:	e0a22002 	adc	r2, r2, r2
    8df8:	20400101 	subcs	r0, r0, r1, lsl #2
    8dfc:	e1500081 	cmp	r0, r1, lsl #1
    8e00:	e0a22002 	adc	r2, r2, r2
    8e04:	20400081 	subcs	r0, r0, r1, lsl #1
    8e08:	e1500001 	cmp	r0, r1
    8e0c:	e0a22002 	adc	r2, r2, r2
    8e10:	20400001 	subcs	r0, r0, r1
    8e14:	e1a00002 	mov	r0, r2
    8e18:	e12fff1e 	bx	lr
    8e1c:	03a00001 	moveq	r0, #1
    8e20:	13a00000 	movne	r0, #0
    8e24:	e12fff1e 	bx	lr
    8e28:	e16f2f11 	clz	r2, r1
    8e2c:	e262201f 	rsb	r2, r2, #31
    8e30:	e1a00230 	lsr	r0, r0, r2
    8e34:	e12fff1e 	bx	lr
    8e38:	e3500000 	cmp	r0, #0
    8e3c:	13e00000 	mvnne	r0, #0
    8e40:	ea000007 	b	8e64 <__aeabi_idiv0>

00008e44 <__aeabi_uidivmod>:
__aeabi_uidivmod():
    8e44:	e3510000 	cmp	r1, #0
    8e48:	0afffffa 	beq	8e38 <__udivsi3+0x1e0>
    8e4c:	e92d4003 	push	{r0, r1, lr}
    8e50:	ebffff80 	bl	8c58 <__udivsi3>
    8e54:	e8bd4006 	pop	{r1, r2, lr}
    8e58:	e0030092 	mul	r3, r2, r0
    8e5c:	e0411003 	sub	r1, r1, r3
    8e60:	e12fff1e 	bx	lr

00008e64 <__aeabi_idiv0>:
__aeabi_ldiv0():
    8e64:	e12fff1e 	bx	lr

Disassembly of section .rodata:

00008e68 <_ZL13Lock_Unlocked>:
    8e68:	00000000 	andeq	r0, r0, r0

00008e6c <_ZL11Lock_Locked>:
    8e6c:	00000001 	andeq	r0, r0, r1

00008e70 <_ZL21MaxFSDriverNameLength>:
    8e70:	00000010 	andeq	r0, r0, r0, lsl r0

00008e74 <_ZL17MaxFilenameLength>:
    8e74:	00000010 	andeq	r0, r0, r0, lsl r0

00008e78 <_ZL13MaxPathLength>:
    8e78:	00000080 	andeq	r0, r0, r0, lsl #1

00008e7c <_ZL18NoFilesystemDriver>:
    8e7c:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008e80 <_ZL9NotifyAll>:
    8e80:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008e84 <_ZL24Max_Process_Opened_Files>:
    8e84:	00000010 	andeq	r0, r0, r0, lsl r0

00008e88 <_ZL10Indefinite>:
    8e88:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008e8c <_ZL18Deadline_Unchanged>:
    8e8c:	fffffffe 			; <UNDEFINED> instruction: 0xfffffffe

00008e90 <_ZL14Invalid_Handle>:
    8e90:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008e94 <_ZN3halL18Default_Clock_RateE>:
    8e94:	0ee6b280 	cdpeq	2, 14, cr11, cr6, cr0, {4}

00008e98 <_ZN3halL15Peripheral_BaseE>:
    8e98:	20000000 	andcs	r0, r0, r0

00008e9c <_ZN3halL9GPIO_BaseE>:
    8e9c:	20200000 	eorcs	r0, r0, r0

00008ea0 <_ZN3halL14GPIO_Pin_CountE>:
    8ea0:	00000036 	andeq	r0, r0, r6, lsr r0

00008ea4 <_ZN3halL8AUX_BaseE>:
    8ea4:	20215000 	eorcs	r5, r1, r0

00008ea8 <_ZN3halL25Interrupt_Controller_BaseE>:
    8ea8:	2000b200 	andcs	fp, r0, r0, lsl #4

00008eac <_ZN3halL10Timer_BaseE>:
    8eac:	2000b400 	andcs	fp, r0, r0, lsl #8

00008eb0 <_ZN3halL9TRNG_BaseE>:
    8eb0:	20104000 	andscs	r4, r0, r0

00008eb4 <_ZN3halL9BSC0_BaseE>:
    8eb4:	20205000 	eorcs	r5, r0, r0

00008eb8 <_ZN3halL9BSC1_BaseE>:
    8eb8:	20804000 	addcs	r4, r0, r0

00008ebc <_ZN3halL9BSC2_BaseE>:
    8ebc:	20805000 	addcs	r5, r0, r0

00008ec0 <_ZL11Invalid_Pin>:
    8ec0:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008ec4 <_ZL17symbol_tick_delay>:
    8ec4:	00000400 	andeq	r0, r0, r0, lsl #8

00008ec8 <_ZL15char_tick_delay>:
    8ec8:	00001000 	andeq	r1, r0, r0
    8ecc:	00000031 	andeq	r0, r0, r1, lsr r0
    8ed0:	00000030 	andeq	r0, r0, r0, lsr r0
    8ed4:	3a564544 	bcc	159a3ec <__bss_end+0x1591488>
    8ed8:	6f697067 	svcvs	0x00697067
    8edc:	0037342f 	eorseq	r3, r7, pc, lsr #8
    8ee0:	3a564544 	bcc	159a3f8 <__bss_end+0x1591494>
    8ee4:	74726175 	ldrbtvc	r6, [r2], #-373	; 0xfffffe8b
    8ee8:	0000302f 	andeq	r3, r0, pc, lsr #32
    8eec:	6c6c6548 	cfstr64vs	mvdx6, [ip], #-288	; 0xfffffee0
    8ef0:	4920216f 	stmdbmi	r0!, {r0, r1, r2, r3, r5, r6, r8, sp}
    8ef4:	68206d27 	stmdavs	r0!, {r0, r1, r2, r5, r8, sl, fp, sp, lr}
    8ef8:	6f6c6c65 	svcvs	0x006c6c65
    8efc:	7361745f 	cmnvc	r1, #1593835520	; 0x5f000000
    8f00:	000a2e6b 	andeq	r2, sl, fp, ror #28

00008f04 <_ZL13Lock_Unlocked>:
    8f04:	00000000 	andeq	r0, r0, r0

00008f08 <_ZL11Lock_Locked>:
    8f08:	00000001 	andeq	r0, r0, r1

00008f0c <_ZL21MaxFSDriverNameLength>:
    8f0c:	00000010 	andeq	r0, r0, r0, lsl r0

00008f10 <_ZL17MaxFilenameLength>:
    8f10:	00000010 	andeq	r0, r0, r0, lsl r0

00008f14 <_ZL13MaxPathLength>:
    8f14:	00000080 	andeq	r0, r0, r0, lsl #1

00008f18 <_ZL18NoFilesystemDriver>:
    8f18:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008f1c <_ZL9NotifyAll>:
    8f1c:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008f20 <_ZL24Max_Process_Opened_Files>:
    8f20:	00000010 	andeq	r0, r0, r0, lsl r0

00008f24 <_ZL10Indefinite>:
    8f24:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008f28 <_ZL18Deadline_Unchanged>:
    8f28:	fffffffe 			; <UNDEFINED> instruction: 0xfffffffe

00008f2c <_ZL14Invalid_Handle>:
    8f2c:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008f30 <_ZL16Pipe_File_Prefix>:
    8f30:	3a535953 	bcc	14df484 <__bss_end+0x14d6520>
    8f34:	65706970 	ldrbvs	r6, [r0, #-2416]!	; 0xfffff690
    8f38:	0000002f 	andeq	r0, r0, pc, lsr #32

00008f3c <_ZN12_GLOBAL__N_1L11CharConvArrE>:
    8f3c:	33323130 	teqcc	r2, #48, 2
    8f40:	37363534 			; <UNDEFINED> instruction: 0x37363534
    8f44:	42413938 	submi	r3, r1, #56, 18	; 0xe0000
    8f48:	46454443 	strbmi	r4, [r5], -r3, asr #8
	...

Disassembly of section .bss:

00008f50 <sos_led>:
	...

Disassembly of section .ARM.attributes:

00000000 <.ARM.attributes>:
   0:	00002e41 	andeq	r2, r0, r1, asr #28
   4:	61656100 	cmnvs	r5, r0, lsl #2
   8:	01006962 	tsteq	r0, r2, ror #18
   c:	00000024 	andeq	r0, r0, r4, lsr #32
  10:	4b5a3605 	blmi	168d82c <__bss_end+0x16848c8>
  14:	08070600 	stmdaeq	r7, {r9, sl}
  18:	0a010901 	beq	42424 <__bss_end+0x394c0>
  1c:	14041202 	strne	r1, [r4], #-514	; 0xfffffdfe
  20:	17011501 	strne	r1, [r1, -r1, lsl #10]
  24:	1a011803 	bne	46038 <__bss_end+0x3d0d4>
  28:	22011c01 	andcs	r1, r1, #256	; 0x100
  2c:	Address 0x000000000000002c is out of bounds.


Disassembly of section .comment:

00000000 <.comment>:
   0:	3a434347 	bcc	10d0d24 <__bss_end+0x10c7dc0>
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
  38:	7a617661 	bvc	185d9c4 <__bss_end+0x1854a60>
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
  c0:	6a757a61 	bvs	1d5ea4c <__bss_end+0x1d55ae8>
  c4:	2f696369 	svccs	0x00696369
  c8:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
  cc:	73656d65 	cmnvc	r5, #6464	; 0x1940
  d0:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
  d4:	6b2d616b 	blvs	b58688 <__bss_end+0xb4f724>
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
 144:	fb010200 	blx	4094e <__bss_end+0x379ea>
 148:	01000d0e 	tsteq	r0, lr, lsl #26
 14c:	00010101 	andeq	r0, r1, r1, lsl #2
 150:	00010000 	andeq	r0, r1, r0
 154:	552f0100 	strpl	r0, [pc, #-256]!	; 5c <shift+0x5c>
 158:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 15c:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 160:	6a726574 	bvs	1c99738 <__bss_end+0x1c907d4>
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
 198:	752f7365 	strvc	r7, [pc, #-869]!	; fffffe3b <__bss_end+0xffff6ed7>
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
 1d0:	0a05830b 	beq	160e04 <__bss_end+0x157ea0>
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
 1fc:	4a030402 	bmi	c120c <__bss_end+0xb82a8>
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
 230:	4a020402 	bmi	81240 <__bss_end+0x782dc>
 234:	02000205 	andeq	r0, r0, #1342177280	; 0x50000000
 238:	052d0204 	streq	r0, [sp, #-516]!	; 0xfffffdfc
 23c:	01058509 	tsteq	r5, r9, lsl #10
 240:	000a022f 	andeq	r0, sl, pc, lsr #4
 244:	02f00101 	rscseq	r0, r0, #1073741824	; 0x40000000
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
 280:	6a757a61 	bvs	1d5ec0c <__bss_end+0x1d55ca8>
 284:	2f696369 	svccs	0x00696369
 288:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
 28c:	73656d65 	cmnvc	r5, #6464	; 0x1940
 290:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
 294:	6b2d616b 	blvs	b58848 <__bss_end+0xb4f8e4>
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
 2d8:	7a617661 	bvc	185dc64 <__bss_end+0x1854d00>
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
 334:	6b736544 	blvs	1cd984c <__bss_end+0x1cd08e8>
 338:	2f706f74 	svccs	0x00706f74
 33c:	2f564146 	svccs	0x00564146
 340:	6176614e 	cmnvs	r6, lr, asr #2
 344:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
 348:	4f2f6963 	svcmi	0x002f6963
 34c:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
 350:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
 354:	6b6c6172 	blvs	1b18924 <__bss_end+0x1b0f9c0>
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
 398:	6b736544 	blvs	1cd98b0 <__bss_end+0x1cd094c>
 39c:	2f706f74 	svccs	0x00706f74
 3a0:	2f564146 	svccs	0x00564146
 3a4:	6176614e 	cmnvs	r6, lr, asr #2
 3a8:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
 3ac:	4f2f6963 	svcmi	0x002f6963
 3b0:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
 3b4:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
 3b8:	6b6c6172 	blvs	1b18988 <__bss_end+0x1b0fa24>
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
 408:	6b736544 	blvs	1cd9920 <__bss_end+0x1cd09bc>
 40c:	2f706f74 	svccs	0x00706f74
 410:	2f564146 	svccs	0x00564146
 414:	6176614e 	cmnvs	r6, lr, asr #2
 418:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
 41c:	4f2f6963 	svcmi	0x002f6963
 420:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
 424:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
 428:	6b6c6172 	blvs	1b189f8 <__bss_end+0x1b0fa94>
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
 4ec:	00bb9f07 	adcseq	r9, fp, r7, lsl #30
 4f0:	06010402 	streq	r0, [r1], -r2, lsl #8
 4f4:	04020066 	streq	r0, [r2], #-102	; 0xffffff9a
 4f8:	02004a02 	andeq	r4, r0, #8192	; 0x2000
 4fc:	002e0404 	eoreq	r0, lr, r4, lsl #8
 500:	06040402 	streq	r0, [r4], -r2, lsl #8
 504:	00010567 	andeq	r0, r1, r7, ror #10
 508:	bb040402 	bllt	101518 <__bss_end+0xf85b4>
 50c:	9f0a05bd 	svcls	0x000a05bd
 510:	05d81005 	ldrbeq	r1, [r8, #5]
 514:	1605820a 	strne	r8, [r5], -sl, lsl #4
 518:	000e054c 	andeq	r0, lr, ip, asr #10
 51c:	86010402 	strhi	r0, [r1], -r2, lsl #8
 520:	02001c05 	andeq	r1, r0, #1280	; 0x500
 524:	054b0104 	strbeq	r0, [fp, #-260]	; 0xfffffefc
 528:	04020008 	streq	r0, [r2], #-8
 52c:	0e058201 	cdpeq	2, 0, cr8, cr5, cr1, {0}
 530:	01040200 	mrseq	r0, R12_usr
 534:	000a029d 	muleq	sl, sp, r2
 538:	02c80101 	sbceq	r0, r8, #1073741824	; 0x40000000
 53c:	00030000 	andeq	r0, r3, r0
 540:	000001dd 	ldrdeq	r0, [r0], -sp
 544:	0efb0102 	cdpeq	1, 15, cr0, cr11, cr2, {0}
 548:	0101000d 	tsteq	r1, sp
 54c:	00000101 	andeq	r0, r0, r1, lsl #2
 550:	00000100 	andeq	r0, r0, r0, lsl #2
 554:	73552f01 	cmpvc	r5, #1, 30
 558:	2f737265 	svccs	0x00737265
 55c:	746e6977 	strbtvc	r6, [lr], #-2423	; 0xfffff689
 560:	696a7265 	stmdbvs	sl!, {r0, r2, r5, r6, r9, ip, sp, lr}^
 564:	7365442f 	cmnvc	r5, #788529152	; 0x2f000000
 568:	706f746b 	rsbvc	r7, pc, fp, ror #8
 56c:	5641462f 	strbpl	r4, [r1], -pc, lsr #12
 570:	76614e2f 	strbtvc	r4, [r1], -pc, lsr #28
 574:	6a757a61 	bvs	1d5ef00 <__bss_end+0x1d55f9c>
 578:	2f696369 	svccs	0x00696369
 57c:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
 580:	73656d65 	cmnvc	r5, #6464	; 0x1940
 584:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
 588:	6b2d616b 	blvs	b58b3c <__bss_end+0xb4fbd8>
 58c:	6f2d7669 	svcvs	0x002d7669
 590:	6f732f73 	svcvs	0x00732f73
 594:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
 598:	74732f73 	ldrbtvc	r2, [r3], #-3955	; 0xfffff08d
 59c:	62696c64 	rsbvs	r6, r9, #100, 24	; 0x6400
 5a0:	6372732f 	cmnvs	r2, #-1140850688	; 0xbc000000
 5a4:	73552f00 	cmpvc	r5, #0, 30
 5a8:	2f737265 	svccs	0x00737265
 5ac:	746e6977 	strbtvc	r6, [lr], #-2423	; 0xfffff689
 5b0:	696a7265 	stmdbvs	sl!, {r0, r2, r5, r6, r9, ip, sp, lr}^
 5b4:	7365442f 	cmnvc	r5, #788529152	; 0x2f000000
 5b8:	706f746b 	rsbvc	r7, pc, fp, ror #8
 5bc:	5641462f 	strbpl	r4, [r1], -pc, lsr #12
 5c0:	76614e2f 	strbtvc	r4, [r1], -pc, lsr #28
 5c4:	6a757a61 	bvs	1d5ef50 <__bss_end+0x1d55fec>
 5c8:	2f696369 	svccs	0x00696369
 5cc:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
 5d0:	73656d65 	cmnvc	r5, #6464	; 0x1940
 5d4:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
 5d8:	6b2d616b 	blvs	b58b8c <__bss_end+0xb4fc28>
 5dc:	6f2d7669 	svcvs	0x002d7669
 5e0:	6f732f73 	svcvs	0x00732f73
 5e4:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
 5e8:	656b2f73 	strbvs	r2, [fp, #-3955]!	; 0xfffff08d
 5ec:	6c656e72 	stclvs	14, cr6, [r5], #-456	; 0xfffffe38
 5f0:	636e692f 	cmnvs	lr, #770048	; 0xbc000
 5f4:	6564756c 	strbvs	r7, [r4, #-1388]!	; 0xfffffa94
 5f8:	6f72702f 	svcvs	0x0072702f
 5fc:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
 600:	73552f00 	cmpvc	r5, #0, 30
 604:	2f737265 	svccs	0x00737265
 608:	746e6977 	strbtvc	r6, [lr], #-2423	; 0xfffff689
 60c:	696a7265 	stmdbvs	sl!, {r0, r2, r5, r6, r9, ip, sp, lr}^
 610:	7365442f 	cmnvc	r5, #788529152	; 0x2f000000
 614:	706f746b 	rsbvc	r7, pc, fp, ror #8
 618:	5641462f 	strbpl	r4, [r1], -pc, lsr #12
 61c:	76614e2f 	strbtvc	r4, [r1], -pc, lsr #28
 620:	6a757a61 	bvs	1d5efac <__bss_end+0x1d56048>
 624:	2f696369 	svccs	0x00696369
 628:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
 62c:	73656d65 	cmnvc	r5, #6464	; 0x1940
 630:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
 634:	6b2d616b 	blvs	b58be8 <__bss_end+0xb4fc84>
 638:	6f2d7669 	svcvs	0x002d7669
 63c:	6f732f73 	svcvs	0x00732f73
 640:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
 644:	656b2f73 	strbvs	r2, [fp, #-3955]!	; 0xfffff08d
 648:	6c656e72 	stclvs	14, cr6, [r5], #-456	; 0xfffffe38
 64c:	636e692f 	cmnvs	lr, #770048	; 0xbc000
 650:	6564756c 	strbvs	r7, [r4, #-1388]!	; 0xfffffa94
 654:	0073662f 	rsbseq	r6, r3, pc, lsr #12
 658:	6573552f 	ldrbvs	r5, [r3, #-1327]!	; 0xfffffad1
 65c:	772f7372 			; <UNDEFINED> instruction: 0x772f7372
 660:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
 664:	2f696a72 	svccs	0x00696a72
 668:	6b736544 	blvs	1cd9b80 <__bss_end+0x1cd0c1c>
 66c:	2f706f74 	svccs	0x00706f74
 670:	2f564146 	svccs	0x00564146
 674:	6176614e 	cmnvs	r6, lr, asr #2
 678:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
 67c:	4f2f6963 	svcmi	0x002f6963
 680:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
 684:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
 688:	6b6c6172 	blvs	1b18c58 <__bss_end+0x1b0fcf4>
 68c:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
 690:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
 694:	756f732f 	strbvc	r7, [pc, #-815]!	; 36d <shift+0x36d>
 698:	73656372 	cmnvc	r5, #-939524095	; 0xc8000001
 69c:	72656b2f 	rsbvc	r6, r5, #48128	; 0xbc00
 6a0:	2f6c656e 	svccs	0x006c656e
 6a4:	6c636e69 	stclvs	14, cr6, [r3], #-420	; 0xfffffe5c
 6a8:	2f656475 	svccs	0x00656475
 6ac:	72616f62 	rsbvc	r6, r1, #392	; 0x188
 6b0:	70722f64 	rsbsvc	r2, r2, r4, ror #30
 6b4:	682f3069 	stmdavs	pc!, {r0, r3, r5, r6, ip, sp}	; <UNPREDICTABLE>
 6b8:	00006c61 	andeq	r6, r0, r1, ror #24
 6bc:	66647473 			; <UNDEFINED> instruction: 0x66647473
 6c0:	2e656c69 	cdpcs	12, 6, cr6, cr5, cr9, {3}
 6c4:	00707063 	rsbseq	r7, r0, r3, rrx
 6c8:	73000001 	movwvc	r0, #1
 6cc:	682e6977 	stmdavs	lr!, {r0, r1, r2, r4, r5, r6, r8, fp, sp, lr}
 6d0:	00000200 	andeq	r0, r0, r0, lsl #4
 6d4:	6e697073 	mcrvs	0, 3, r7, cr9, cr3, {3}
 6d8:	6b636f6c 	blvs	18dc490 <__bss_end+0x18d352c>
 6dc:	0200682e 	andeq	r6, r0, #3014656	; 0x2e0000
 6e0:	69660000 	stmdbvs	r6!, {}^	; <UNPREDICTABLE>
 6e4:	7973656c 	ldmdbvc	r3!, {r2, r3, r5, r6, r8, sl, sp, lr}^
 6e8:	6d657473 	cfstrdvs	mvd7, [r5, #-460]!	; 0xfffffe34
 6ec:	0300682e 	movweq	r6, #2094	; 0x82e
 6f0:	72700000 	rsbsvc	r0, r0, #0
 6f4:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
 6f8:	00682e73 	rsbeq	r2, r8, r3, ror lr
 6fc:	70000002 	andvc	r0, r0, r2
 700:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
 704:	6d5f7373 	ldclvs	3, cr7, [pc, #-460]	; 540 <shift+0x540>
 708:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
 70c:	682e7265 	stmdavs	lr!, {r0, r2, r5, r6, r9, ip, sp, lr}
 710:	00000200 	andeq	r0, r0, r0, lsl #4
 714:	64746e69 	ldrbtvs	r6, [r4], #-3689	; 0xfffff197
 718:	682e6665 	stmdavs	lr!, {r0, r2, r5, r6, r9, sl, sp, lr}
 71c:	00000400 	andeq	r0, r0, r0, lsl #8
 720:	00010500 	andeq	r0, r1, r0, lsl #10
 724:	83440205 	movthi	r0, #16901	; 0x4205
 728:	05160000 	ldreq	r0, [r6, #-0]
 72c:	052f6905 	streq	r6, [pc, #-2309]!	; fffffe2f <__bss_end+0xffff6ecb>
 730:	01054c0c 	tsteq	r5, ip, lsl #24
 734:	0505852f 	streq	r8, [r5, #-1327]	; 0xfffffad1
 738:	01054b83 	smlabbeq	r5, r3, fp, r4
 73c:	0505852f 	streq	r8, [r5, #-1327]	; 0xfffffad1
 740:	2f01054b 	svccs	0x0001054b
 744:	a1050585 	smlabbge	r5, r5, r5, r0
 748:	052f4b4b 	streq	r4, [pc, #-2891]!	; fffffc05 <__bss_end+0xffff6ca1>
 74c:	01054c0c 	tsteq	r5, ip, lsl #24
 750:	0505852f 	streq	r8, [r5, #-1327]	; 0xfffffad1
 754:	4b4b4bbd 	blmi	12d3650 <__bss_end+0x12ca6ec>
 758:	4c0c052f 	cfstr32mi	mvfx0, [ip], {47}	; 0x2f
 75c:	852f0105 	strhi	r0, [pc, #-261]!	; 65f <shift+0x65f>
 760:	4bbd0505 	blmi	fef41b7c <__bss_end+0xfef38c18>
 764:	052f4b4b 	streq	r4, [pc, #-2891]!	; fffffc21 <__bss_end+0xffff6cbd>
 768:	01054c0c 	tsteq	r5, ip, lsl #24
 76c:	0505852f 	streq	r8, [r5, #-1327]	; 0xfffffad1
 770:	01054b83 	smlabbeq	r5, r3, fp, r4
 774:	0505852f 	streq	r8, [r5, #-1327]	; 0xfffffad1
 778:	4b4b4bbd 	blmi	12d3674 <__bss_end+0x12ca710>
 77c:	4c0c052f 	cfstr32mi	mvfx0, [ip], {47}	; 0x2f
 780:	852f0105 	strhi	r0, [pc, #-261]!	; 683 <shift+0x683>
 784:	4ba10505 	blmi	fe841ba0 <__bss_end+0xfe838c3c>
 788:	0c052f4b 	stceq	15, cr2, [r5], {75}	; 0x4b
 78c:	2f01054c 	svccs	0x0001054c
 790:	bd050585 	cfstr32lt	mvfx0, [r5, #-532]	; 0xfffffdec
 794:	2f4b4b4b 	svccs	0x004b4b4b
 798:	054c0c05 	strbeq	r0, [ip, #-3077]	; 0xfffff3fb
 79c:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 7a0:	4b4ba105 	blmi	12e8bbc <__bss_end+0x12dfc58>
 7a4:	4c0c052f 	cfstr32mi	mvfx0, [ip], {47}	; 0x2f
 7a8:	859f0105 	ldrhi	r0, [pc, #261]	; 8b5 <shift+0x8b5>
 7ac:	05672005 	strbeq	r2, [r7, #-5]!
 7b0:	4b4b4d05 	blmi	12d3bcc <__bss_end+0x12cac68>
 7b4:	05300c05 	ldreq	r0, [r0, #-3077]!	; 0xfffff3fb
 7b8:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 7bc:	05056720 	streq	r6, [r5, #-1824]	; 0xfffff8e0
 7c0:	054b4b4d 	strbeq	r4, [fp, #-2893]	; 0xfffff4b3
 7c4:	0105300c 	tsteq	r5, ip
 7c8:	2005852f 	andcs	r8, r5, pc, lsr #10
 7cc:	4c050583 	cfstr32mi	mvfx0, [r5], {131}	; 0x83
 7d0:	01054b4b 	tsteq	r5, fp, asr #22
 7d4:	2005852f 	andcs	r8, r5, pc, lsr #10
 7d8:	4d050567 	cfstr32mi	mvfx0, [r5, #-412]	; 0xfffffe64
 7dc:	0c054b4b 			; <UNDEFINED> instruction: 0x0c054b4b
 7e0:	2f010530 	svccs	0x00010530
 7e4:	a00c0587 	andge	r0, ip, r7, lsl #11
 7e8:	bc31059f 	cfldr32lt	mvfx0, [r1], #-636	; 0xfffffd84
 7ec:	05662905 	strbeq	r2, [r6, #-2309]!	; 0xfffff6fb
 7f0:	0f052e36 	svceq	0x00052e36
 7f4:	66130530 			; <UNDEFINED> instruction: 0x66130530
 7f8:	05840905 	streq	r0, [r4, #2309]	; 0x905
 7fc:	0105d810 	tsteq	r5, r0, lsl r8
 800:	0008029f 	muleq	r8, pc, r2	; <UNPREDICTABLE>
 804:	029b0101 	addseq	r0, fp, #1073741824	; 0x40000000
 808:	00030000 	andeq	r0, r3, r0
 80c:	00000074 	andeq	r0, r0, r4, ror r0
 810:	0efb0102 	cdpeq	1, 15, cr0, cr11, cr2, {0}
 814:	0101000d 	tsteq	r1, sp
 818:	00000101 	andeq	r0, r0, r1, lsl #2
 81c:	00000100 	andeq	r0, r0, r0, lsl #2
 820:	73552f01 	cmpvc	r5, #1, 30
 824:	2f737265 	svccs	0x00737265
 828:	746e6977 	strbtvc	r6, [lr], #-2423	; 0xfffff689
 82c:	696a7265 	stmdbvs	sl!, {r0, r2, r5, r6, r9, ip, sp, lr}^
 830:	7365442f 	cmnvc	r5, #788529152	; 0x2f000000
 834:	706f746b 	rsbvc	r7, pc, fp, ror #8
 838:	5641462f 	strbpl	r4, [r1], -pc, lsr #12
 83c:	76614e2f 	strbtvc	r4, [r1], -pc, lsr #28
 840:	6a757a61 	bvs	1d5f1cc <__bss_end+0x1d56268>
 844:	2f696369 	svccs	0x00696369
 848:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
 84c:	73656d65 	cmnvc	r5, #6464	; 0x1940
 850:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
 854:	6b2d616b 	blvs	b58e08 <__bss_end+0xb4fea4>
 858:	6f2d7669 	svcvs	0x002d7669
 85c:	6f732f73 	svcvs	0x00732f73
 860:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
 864:	74732f73 	ldrbtvc	r2, [r3], #-3955	; 0xfffff08d
 868:	62696c64 	rsbvs	r6, r9, #100, 24	; 0x6400
 86c:	6372732f 	cmnvs	r2, #-1140850688	; 0xbc000000
 870:	74730000 	ldrbtvc	r0, [r3], #-0
 874:	72747364 	rsbsvc	r7, r4, #100, 6	; 0x90000001
 878:	2e676e69 	cdpcs	14, 6, cr6, cr7, cr9, {3}
 87c:	00707063 	rsbseq	r7, r0, r3, rrx
 880:	00000001 	andeq	r0, r0, r1
 884:	05000105 	streq	r0, [r0, #-261]	; 0xfffffefb
 888:	0087a002 	addeq	sl, r7, r2
 88c:	06051a00 	streq	r1, [r5], -r0, lsl #20
 890:	4c0f05bb 	cfstr32mi	mvfx0, [pc], {187}	; 0xbb
 894:	05682105 	strbeq	r2, [r8, #-261]!	; 0xfffffefb
 898:	0b05ba0a 	bleq	16f0c8 <__bss_end+0x166164>
 89c:	4a27052e 	bmi	9c1d5c <__bss_end+0x9b8df8>
 8a0:	054a0d05 	strbeq	r0, [sl, #-3333]	; 0xfffff2fb
 8a4:	04052f09 	streq	r2, [r5], #-3849	; 0xfffff0f7
 8a8:	6202059f 	andvs	r0, r2, #666894336	; 0x27c00000
 8ac:	05350505 	ldreq	r0, [r5, #-1285]!	; 0xfffffafb
 8b0:	11056810 	tstne	r5, r0, lsl r8
 8b4:	4a22052e 	bmi	881d74 <__bss_end+0x878e10>
 8b8:	052e1305 	streq	r1, [lr, #-773]!	; 0xfffffcfb
 8bc:	09052f0a 	stmdbeq	r5, {r1, r3, r8, r9, sl, fp, sp}
 8c0:	2e0a0569 	cfsh32cs	mvfx0, mvfx10, #57
 8c4:	054a0c05 	strbeq	r0, [sl, #-3077]	; 0xfffff3fb
 8c8:	0b054b03 	bleq	1534dc <__bss_end+0x14a578>
 8cc:	00180568 	andseq	r0, r8, r8, ror #10
 8d0:	4a030402 	bmi	c18e0 <__bss_end+0xb897c>
 8d4:	02001405 	andeq	r1, r0, #83886080	; 0x5000000
 8d8:	059e0304 	ldreq	r0, [lr, #772]	; 0x304
 8dc:	04020015 	streq	r0, [r2], #-21	; 0xffffffeb
 8e0:	18056802 	stmdane	r5, {r1, fp, sp, lr}
 8e4:	02040200 	andeq	r0, r4, #0, 4
 8e8:	00080582 	andeq	r0, r8, r2, lsl #11
 8ec:	4a020402 	bmi	818fc <__bss_end+0x78998>
 8f0:	02001a05 	andeq	r1, r0, #20480	; 0x5000
 8f4:	054b0204 	strbeq	r0, [fp, #-516]	; 0xfffffdfc
 8f8:	0402001b 	streq	r0, [r2], #-27	; 0xffffffe5
 8fc:	0c052e02 	stceq	14, cr2, [r5], {2}
 900:	02040200 	andeq	r0, r4, #0, 4
 904:	000f054a 	andeq	r0, pc, sl, asr #10
 908:	82020402 	andhi	r0, r2, #33554432	; 0x2000000
 90c:	02001b05 	andeq	r1, r0, #5120	; 0x1400
 910:	054a0204 	strbeq	r0, [sl, #-516]	; 0xfffffdfc
 914:	04020011 	streq	r0, [r2], #-17	; 0xffffffef
 918:	0a052e02 	beq	14c128 <__bss_end+0x1431c4>
 91c:	02040200 	andeq	r0, r4, #0, 4
 920:	000b052f 	andeq	r0, fp, pc, lsr #10
 924:	2e020402 	cdpcs	4, 0, cr0, cr2, cr2, {0}
 928:	02000d05 	andeq	r0, r0, #320	; 0x140
 92c:	054a0204 	strbeq	r0, [sl, #-516]	; 0xfffffdfc
 930:	04020002 	streq	r0, [r2], #-2
 934:	01054602 	tsteq	r5, r2, lsl #12
 938:	06058588 	streq	r8, [r5], -r8, lsl #11
 93c:	4c090583 	cfstr32mi	mvfx0, [r9], {131}	; 0x83
 940:	054a1005 	strbeq	r1, [sl, #-5]
 944:	07054c0a 	streq	r4, [r5, -sl, lsl #24]
 948:	4a0305bb 	bmi	c203c <__bss_end+0xb90d8>
 94c:	02001705 	andeq	r1, r0, #1310720	; 0x140000
 950:	054a0104 	strbeq	r0, [sl, #-260]	; 0xfffffefc
 954:	04020014 	streq	r0, [r2], #-20	; 0xffffffec
 958:	0d054a01 	vstreq	s8, [r5, #-4]
 95c:	4a14054d 	bmi	501e98 <__bss_end+0x4f8f34>
 960:	052e0a05 	streq	r0, [lr, #-2565]!	; 0xfffff5fb
 964:	02056808 	andeq	r6, r5, #8, 16	; 0x80000
 968:	05667803 	strbeq	r7, [r6, #-2051]!	; 0xfffff7fd
 96c:	2e0b0309 	cdpcs	3, 0, cr0, cr11, cr9, {0}
 970:	852f0105 	strhi	r0, [pc, #-261]!	; 873 <shift+0x873>
 974:	05bd0905 	ldreq	r0, [sp, #2309]!	; 0x905
 978:	04020016 	streq	r0, [r2], #-22	; 0xffffffea
 97c:	1d054a04 	vstrne	s8, [r5, #-16]
 980:	02040200 	andeq	r0, r4, #0, 4
 984:	001e0582 	andseq	r0, lr, r2, lsl #11
 988:	2e020402 	cdpcs	4, 0, cr0, cr2, cr2, {0}
 98c:	02001605 	andeq	r1, r0, #5242880	; 0x500000
 990:	05660204 	strbeq	r0, [r6, #-516]!	; 0xfffffdfc
 994:	04020011 	streq	r0, [r2], #-17	; 0xffffffef
 998:	12054b03 	andne	r4, r5, #3072	; 0xc00
 99c:	03040200 	movweq	r0, #16896	; 0x4200
 9a0:	0008052e 	andeq	r0, r8, lr, lsr #10
 9a4:	4a030402 	bmi	c19b4 <__bss_end+0xb8a50>
 9a8:	02000905 	andeq	r0, r0, #81920	; 0x14000
 9ac:	052e0304 	streq	r0, [lr, #-772]!	; 0xfffffcfc
 9b0:	04020012 	streq	r0, [r2], #-18	; 0xffffffee
 9b4:	0b054a03 	bleq	1531c8 <__bss_end+0x14a264>
 9b8:	03040200 	movweq	r0, #16896	; 0x4200
 9bc:	0002052e 	andeq	r0, r2, lr, lsr #10
 9c0:	2d030402 	cfstrscs	mvf0, [r3, #-8]
 9c4:	02000b05 	andeq	r0, r0, #5120	; 0x1400
 9c8:	05840204 	streq	r0, [r4, #516]	; 0x204
 9cc:	04020008 	streq	r0, [r2], #-8
 9d0:	09058301 	stmdbeq	r5, {r0, r8, r9, pc}
 9d4:	01040200 	mrseq	r0, R12_usr
 9d8:	000b052e 	andeq	r0, fp, lr, lsr #10
 9dc:	4a010402 	bmi	419ec <__bss_end+0x38a88>
 9e0:	02000205 	andeq	r0, r0, #1342177280	; 0x50000000
 9e4:	05490104 	strbeq	r0, [r9, #-260]	; 0xfffffefc
 9e8:	0105850b 	tsteq	r5, fp, lsl #10
 9ec:	0e05852f 	cfsh32eq	mvfx8, mvfx5, #31
 9f0:	661105bc 			; <UNDEFINED> instruction: 0x661105bc
 9f4:	05bc2005 	ldreq	r2, [ip, #5]!
 9f8:	1f05660b 	svcne	0x0005660b
 9fc:	660a054b 	strvs	r0, [sl], -fp, asr #10
 a00:	054b0805 	strbeq	r0, [fp, #-2053]	; 0xfffff7fb
 a04:	16058311 			; <UNDEFINED> instruction: 0x16058311
 a08:	6708052e 	strvs	r0, [r8, -lr, lsr #10]
 a0c:	05671105 	strbeq	r1, [r7, #-261]!	; 0xfffffefb
 a10:	01054d0b 	tsteq	r5, fp, lsl #26
 a14:	0605852f 	streq	r8, [r5], -pc, lsr #10
 a18:	4c0b0583 	cfstr32mi	mvfx0, [fp], {131}	; 0x83
 a1c:	052e0c05 	streq	r0, [lr, #-3077]!	; 0xfffff3fb
 a20:	0405660e 	streq	r6, [r5], #-1550	; 0xfffff9f2
 a24:	6502054b 	strvs	r0, [r2, #-1355]	; 0xfffffab5
 a28:	05310905 	ldreq	r0, [r1, #-2309]!	; 0xfffff6fb
 a2c:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 a30:	0b059f08 	bleq	168658 <__bss_end+0x15f6f4>
 a34:	0014054c 	andseq	r0, r4, ip, asr #10
 a38:	4a030402 	bmi	c1a48 <__bss_end+0xb8ae4>
 a3c:	02000705 	andeq	r0, r0, #1310720	; 0x140000
 a40:	05830204 	streq	r0, [r3, #516]	; 0x204
 a44:	04020008 	streq	r0, [r2], #-8
 a48:	0a052e02 	beq	14c258 <__bss_end+0x1432f4>
 a4c:	02040200 	andeq	r0, r4, #0, 4
 a50:	0002054a 	andeq	r0, r2, sl, asr #10
 a54:	49020402 	stmdbmi	r2, {r1, sl}
 a58:	85840105 	strhi	r0, [r4, #261]	; 0x105
 a5c:	05bb0e05 	ldreq	r0, [fp, #3589]!	; 0xe05
 a60:	0b054b08 	bleq	153688 <__bss_end+0x14a724>
 a64:	0014054c 	andseq	r0, r4, ip, asr #10
 a68:	4a030402 	bmi	c1a78 <__bss_end+0xb8b14>
 a6c:	02001605 	andeq	r1, r0, #5242880	; 0x500000
 a70:	05830204 	streq	r0, [r3, #516]	; 0x204
 a74:	04020017 	streq	r0, [r2], #-23	; 0xffffffe9
 a78:	0a052e02 	beq	14c288 <__bss_end+0x143324>
 a7c:	02040200 	andeq	r0, r4, #0, 4
 a80:	000b054a 	andeq	r0, fp, sl, asr #10
 a84:	2e020402 	cdpcs	4, 0, cr0, cr2, cr2, {0}
 a88:	02001705 	andeq	r1, r0, #1310720	; 0x140000
 a8c:	054a0204 	strbeq	r0, [sl, #-516]	; 0xfffffdfc
 a90:	0402000d 	streq	r0, [r2], #-13
 a94:	02052e02 	andeq	r2, r5, #2, 28
 a98:	02040200 	andeq	r0, r4, #0, 4
 a9c:	8401052d 	strhi	r0, [r1], #-1325	; 0xfffffad3
 aa0:	01000802 	tsteq	r0, r2, lsl #16
 aa4:	Address 0x0000000000000aa4 is out of bounds.


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
      58:	07470704 	strbeq	r0, [r7, -r4, lsl #14]
      5c:	5b020000 	blpl	80064 <__bss_end+0x77100>
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
     128:	00000747 	andeq	r0, r0, r7, asr #14
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
     174:	cb104801 	blgt	412180 <__bss_end+0x40921c>
     178:	d4000000 	strle	r0, [r0], #-0
     17c:	58000081 	stmdapl	r0, {r0, r7}
     180:	01000000 	mrseq	r0, (UNDEF: 0)
     184:	0000cb9c 	muleq	r0, ip, fp
     188:	02b40a00 	adcseq	r0, r4, #0, 20
     18c:	4a010000 	bmi	40194 <__bss_end+0x37230>
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
     21c:	ba0d9c01 	blt	367228 <__bss_end+0x35e2c4>
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
     24c:	8b120f01 	blhi	483e58 <__bss_end+0x47aef4>
     250:	0f000001 	svceq	0x00000001
     254:	0000019e 	muleq	r0, lr, r1
     258:	03d51000 	bicseq	r1, r5, #0
     25c:	0a010000 	beq	40264 <__bss_end+0x37300>
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
     2b4:	8b140074 	blhi	50048c <__bss_end+0x4f7528>
     2b8:	a4000001 	strge	r0, [r0], #-1
     2bc:	38000080 	stmdacc	r0, {r7}
     2c0:	01000000 	mrseq	r0, (UNDEF: 0)
     2c4:	0067139c 	mlseq	r7, ip, r3, r1
     2c8:	9e2f0a01 	vmulls.f32	s0, s30, s2
     2cc:	02000001 	andeq	r0, r0, #1
     2d0:	00007491 	muleq	r0, r1, r4
     2d4:	0000080a 	andeq	r0, r0, sl, lsl #16
     2d8:	01e00004 	mvneq	r0, r4
     2dc:	01040000 	mrseq	r0, (UNDEF: 4)
     2e0:	000001e1 	andeq	r0, r0, r1, ror #3
     2e4:	0007b304 	andeq	fp, r7, r4, lsl #6
     2e8:	00005600 	andeq	r5, r0, r0, lsl #12
     2ec:	00822c00 	addeq	r2, r2, r0, lsl #24
     2f0:	00011800 	andeq	r1, r1, r0, lsl #16
     2f4:	00024600 	andeq	r4, r2, r0, lsl #12
     2f8:	08010200 	stmdaeq	r1, {r9}
     2fc:	00000995 	muleq	r0, r5, r9
     300:	e1050202 	tst	r5, r2, lsl #4
     304:	03000009 	movweq	r0, #9
     308:	6e690504 	cdpvs	5, 6, cr0, cr9, cr4, {0}
     30c:	01020074 	tsteq	r2, r4, ror r0
     310:	00098c08 	andeq	r8, r9, r8, lsl #24
     314:	07020200 	streq	r0, [r2, -r0, lsl #4]
     318:	0000078e 	andeq	r0, r0, lr, lsl #15
     31c:	000a0f04 	andeq	r0, sl, r4, lsl #30
     320:	07090900 	streq	r0, [r9, -r0, lsl #18]
     324:	00000059 	andeq	r0, r0, r9, asr r0
     328:	00004805 	andeq	r4, r0, r5, lsl #16
     32c:	07040200 	streq	r0, [r4, -r0, lsl #4]
     330:	00000747 	andeq	r0, r0, r7, asr #14
     334:	00005905 	andeq	r5, r0, r5, lsl #18
     338:	06240600 	strteq	r0, [r4], -r0, lsl #12
     33c:	02080000 	andeq	r0, r8, #0
     340:	008b0806 	addeq	r0, fp, r6, lsl #16
     344:	72070000 	andvc	r0, r7, #0
     348:	08020030 	stmdaeq	r2, {r4, r5}
     34c:	0000480e 	andeq	r4, r0, lr, lsl #16
     350:	72070000 	andvc	r0, r7, #0
     354:	09020031 	stmdbeq	r2, {r0, r4, r5}
     358:	0000480e 	andeq	r4, r0, lr, lsl #16
     35c:	08000400 	stmdaeq	r0, {sl}
     360:	000004ef 	andeq	r0, r0, pc, ror #9
     364:	00330405 	eorseq	r0, r3, r5, lsl #8
     368:	1e020000 	cdpne	0, 0, cr0, cr2, cr0, {0}
     36c:	0000c20c 	andeq	ip, r0, ip, lsl #4
     370:	06970900 	ldreq	r0, [r7], r0, lsl #18
     374:	09000000 	stmdbeq	r0, {}	; <UNPREDICTABLE>
     378:	00000c27 	andeq	r0, r0, r7, lsr #24
     37c:	0c070901 			; <UNDEFINED> instruction: 0x0c070901
     380:	09020000 	stmdbeq	r2, {}	; <UNPREDICTABLE>
     384:	00000824 	andeq	r0, r0, r4, lsr #16
     388:	091b0903 	ldmdbeq	fp, {r0, r1, r8, fp}
     38c:	09040000 	stmdbeq	r4, {}	; <UNPREDICTABLE>
     390:	00000660 	andeq	r0, r0, r0, ror #12
     394:	aa080005 	bge	2003b0 <__bss_end+0x1f744c>
     398:	0500000b 	streq	r0, [r0, #-11]
     39c:	00003304 	andeq	r3, r0, r4, lsl #6
     3a0:	0c3f0200 	lfmeq	f0, 4, [pc], #-0	; 3a8 <shift+0x3a8>
     3a4:	000000ff 	strdeq	r0, [r0], -pc	; <UNPREDICTABLE>
     3a8:	0003ff09 	andeq	pc, r3, r9, lsl #30
     3ac:	04090000 	streq	r0, [r9], #-0
     3b0:	01000005 	tsteq	r0, r5
     3b4:	00090809 	andeq	r0, r9, r9, lsl #16
     3b8:	e7090200 	str	r0, [r9, -r0, lsl #4]
     3bc:	0300000b 	movweq	r0, #11
     3c0:	000c3109 	andeq	r3, ip, r9, lsl #2
     3c4:	cf090400 	svcgt	0x00090400
     3c8:	05000008 	streq	r0, [r0, #-8]
     3cc:	0007ae09 	andeq	sl, r7, r9, lsl #28
     3d0:	0a000600 	beq	1bd8 <shift+0x1bd8>
     3d4:	000008e9 	andeq	r0, r0, r9, ror #17
     3d8:	54140503 	ldrpl	r0, [r4], #-1283	; 0xfffffafd
     3dc:	05000000 	streq	r0, [r0, #-0]
     3e0:	008e6803 	addeq	r6, lr, r3, lsl #16
     3e4:	08f70a00 	ldmeq	r7!, {r9, fp}^
     3e8:	06030000 	streq	r0, [r3], -r0
     3ec:	00005414 	andeq	r5, r0, r4, lsl r4
     3f0:	6c030500 	cfstr32vs	mvfx0, [r3], {-0}
     3f4:	0a00008e 	beq	634 <shift+0x634>
     3f8:	000008b9 			; <UNDEFINED> instruction: 0x000008b9
     3fc:	541a0704 	ldrpl	r0, [sl], #-1796	; 0xfffff8fc
     400:	05000000 	streq	r0, [r0, #-0]
     404:	008e7003 	addeq	r7, lr, r3
     408:	05330a00 	ldreq	r0, [r3, #-2560]!	; 0xfffff600
     40c:	09040000 	stmdbeq	r4, {}	; <UNPREDICTABLE>
     410:	0000541a 	andeq	r5, r0, sl, lsl r4
     414:	74030500 	strvc	r0, [r3], #-1280	; 0xfffffb00
     418:	0a00008e 	beq	658 <shift+0x658>
     41c:	0000097e 	andeq	r0, r0, lr, ror r9
     420:	541a0b04 	ldrpl	r0, [sl], #-2820	; 0xfffff4fc
     424:	05000000 	streq	r0, [r0, #-0]
     428:	008e7803 	addeq	r7, lr, r3, lsl #16
     42c:	07680a00 	strbeq	r0, [r8, -r0, lsl #20]!
     430:	0d040000 	stceq	0, cr0, [r4, #-0]
     434:	0000541a 	andeq	r5, r0, sl, lsl r4
     438:	7c030500 	cfstr32vc	mvfx0, [r3], {-0}
     43c:	0a00008e 	beq	67c <shift+0x67c>
     440:	0000063d 	andeq	r0, r0, sp, lsr r6
     444:	541a0f04 	ldrpl	r0, [sl], #-3844	; 0xfffff0fc
     448:	05000000 	streq	r0, [r0, #-0]
     44c:	008e8003 	addeq	r8, lr, r3
     450:	10730800 	rsbsne	r0, r3, r0, lsl #16
     454:	04050000 	streq	r0, [r5], #-0
     458:	00000033 	andeq	r0, r0, r3, lsr r0
     45c:	a20c1b04 	andge	r1, ip, #4, 22	; 0x1000
     460:	09000001 	stmdbeq	r0, {r0}
     464:	00000a41 	andeq	r0, r0, r1, asr #20
     468:	0bf70900 	bleq	ffdc2870 <__bss_end+0xffdb990c>
     46c:	09010000 	stmdbeq	r1, {}	; <UNPREDICTABLE>
     470:	00000903 	andeq	r0, r0, r3, lsl #18
     474:	780b0002 	stmdavc	fp, {r1}
     478:	02000009 	andeq	r0, r0, #9
     47c:	082a0201 	stmdaeq	sl!, {r0, r9}
     480:	040c0000 	streq	r0, [ip], #-0
     484:	000001a2 	andeq	r0, r0, r2, lsr #3
     488:	0006df0a 	andeq	sp, r6, sl, lsl #30
     48c:	14040500 	strne	r0, [r4], #-1280	; 0xfffffb00
     490:	00000054 	andeq	r0, r0, r4, asr r0
     494:	8e840305 	cdphi	3, 8, cr0, cr4, cr5, {0}
     498:	f40a0000 	vst4.8	{d0-d3}, [sl], r0
     49c:	05000003 	streq	r0, [r0, #-3]
     4a0:	00541407 	subseq	r1, r4, r7, lsl #8
     4a4:	03050000 	movweq	r0, #20480	; 0x5000
     4a8:	00008e88 	andeq	r8, r0, r8, lsl #29
     4ac:	0005610a 	andeq	r6, r5, sl, lsl #2
     4b0:	140a0500 	strne	r0, [sl], #-1280	; 0xfffffb00
     4b4:	00000054 	andeq	r0, r0, r4, asr r0
     4b8:	8e8c0305 	cdphi	3, 8, cr0, cr12, cr5, {0}
     4bc:	5f080000 	svcpl	0x00080000
     4c0:	05000008 	streq	r0, [r0, #-8]
     4c4:	00003304 	andeq	r3, r0, r4, lsl #6
     4c8:	0c0d0500 	cfstr32eq	mvfx0, [sp], {-0}
     4cc:	00000221 	andeq	r0, r0, r1, lsr #4
     4d0:	77654e0d 	strbvc	r4, [r5, -sp, lsl #28]!
     4d4:	56090000 	strpl	r0, [r9], -r0
     4d8:	01000008 	tsteq	r0, r8
     4dc:	000a0709 	andeq	r0, sl, r9, lsl #14
     4e0:	39090200 	stmdbcc	r9, {r9}
     4e4:	03000008 	movweq	r0, #8
     4e8:	00081609 	andeq	r1, r8, r9, lsl #12
     4ec:	0e090400 	cfcpyseq	mvf0, mvf9
     4f0:	05000009 	streq	r0, [r0, #-9]
     4f4:	06530600 	ldrbeq	r0, [r3], -r0, lsl #12
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
     524:	690e0800 	stmdbvs	lr, {fp}
     528:	05000006 	streq	r0, [r0, #-6]
     52c:	02601320 	rsbeq	r1, r0, #32, 6	; 0x80000000
     530:	000c0000 	andeq	r0, ip, r0
     534:	42070402 	andmi	r0, r7, #33554432	; 0x2000000
     538:	05000007 	streq	r0, [r0, #-7]
     53c:	00000260 	andeq	r0, r0, r0, ror #4
     540:	00046106 	andeq	r6, r4, r6, lsl #2
     544:	28057000 	stmdacs	r5, {ip, sp, lr}
     548:	0002fc08 	andeq	pc, r2, r8, lsl #24
     54c:	0a350e00 	beq	d43d54 <__bss_end+0xd3adf0>
     550:	2a050000 	bcs	140558 <__bss_end+0x1375f4>
     554:	00022112 	andeq	r2, r2, r2, lsl r1
     558:	70070000 	andvc	r0, r7, r0
     55c:	05006469 	streq	r6, [r0, #-1129]	; 0xfffffb97
     560:	0059122b 	subseq	r1, r9, fp, lsr #4
     564:	0e100000 	cdpeq	0, 1, cr0, cr0, cr0, {0}
     568:	0000052d 	andeq	r0, r0, sp, lsr #10
     56c:	ea112c05 	b	44b588 <__bss_end+0x442624>
     570:	14000001 	strne	r0, [r0], #-1
     574:	0008730e 	andeq	r7, r8, lr, lsl #6
     578:	122d0500 	eorne	r0, sp, #0, 10
     57c:	00000059 	andeq	r0, r0, r9, asr r0
     580:	08810e18 	stmeq	r1, {r3, r4, r9, sl, fp}
     584:	2e050000 	cdpcs	0, 0, cr0, cr5, cr0, {0}
     588:	00005912 	andeq	r5, r0, r2, lsl r9
     58c:	300e1c00 	andcc	r1, lr, r0, lsl #24
     590:	05000006 	streq	r0, [r0, #-6]
     594:	02fc0c2f 	rscseq	r0, ip, #12032	; 0x2f00
     598:	0e200000 	cdpeq	0, 2, cr0, cr0, cr0, {0}
     59c:	00000897 	muleq	r0, r7, r8
     5a0:	33093005 	movwcc	r3, #36869	; 0x9005
     5a4:	60000000 	andvs	r0, r0, r0
     5a8:	000a4b0e 	andeq	r4, sl, lr, lsl #22
     5ac:	0e310500 	cfabs32eq	mvfx0, mvfx1
     5b0:	00000048 	andeq	r0, r0, r8, asr #32
     5b4:	06b20e64 	ldrteq	r0, [r2], r4, ror #28
     5b8:	33050000 	movwcc	r0, #20480	; 0x5000
     5bc:	0000480e 	andeq	r4, r0, lr, lsl #16
     5c0:	a90e6800 	stmdbge	lr, {fp, sp, lr}
     5c4:	05000006 	streq	r0, [r0, #-6]
     5c8:	00480e34 	subeq	r0, r8, r4, lsr lr
     5cc:	006c0000 	rsbeq	r0, ip, r0
     5d0:	0001ae0f 	andeq	sl, r1, pc, lsl #28
     5d4:	00030c00 	andeq	r0, r3, r0, lsl #24
     5d8:	00591000 	subseq	r1, r9, r0
     5dc:	000f0000 	andeq	r0, pc, r0
     5e0:	000bc20a 	andeq	ip, fp, sl, lsl #4
     5e4:	140a0600 	strne	r0, [sl], #-1536	; 0xfffffa00
     5e8:	00000054 	andeq	r0, r0, r4, asr r0
     5ec:	8e900305 	cdphi	3, 9, cr0, cr0, cr5, {0}
     5f0:	41080000 	mrsmi	r0, (UNDEF: 8)
     5f4:	05000008 	streq	r0, [r0, #-8]
     5f8:	00003304 	andeq	r3, r0, r4, lsl #6
     5fc:	0c0d0600 	stceq	6, cr0, [sp], {-0}
     600:	0000033d 	andeq	r0, r0, sp, lsr r3
     604:	00050909 	andeq	r0, r5, r9, lsl #18
     608:	e9090000 	stmdb	r9, {}	; <UNPREDICTABLE>
     60c:	01000003 	tsteq	r0, r3
     610:	0aff0600 	beq	fffc1e18 <__bss_end+0xfffb8eb4>
     614:	060c0000 	streq	r0, [ip], -r0
     618:	0372081b 	cmneq	r2, #1769472	; 0x1b0000
     61c:	330e0000 	movwcc	r0, #57344	; 0xe000
     620:	06000004 	streq	r0, [r0], -r4
     624:	0372191d 	cmneq	r2, #475136	; 0x74000
     628:	0e000000 	cdpeq	0, 0, cr0, cr0, cr0, {0}
     62c:	000004cc 	andeq	r0, r0, ip, asr #9
     630:	72191e06 	andsvc	r1, r9, #6, 28	; 0x60
     634:	04000003 	streq	r0, [r0], #-3
     638:	000abf0e 	andeq	fp, sl, lr, lsl #30
     63c:	131f0600 	tstne	pc, #0, 12
     640:	00000378 	andeq	r0, r0, r8, ror r3
     644:	040c0008 	streq	r0, [ip], #-8
     648:	0000033d 	andeq	r0, r0, sp, lsr r3
     64c:	026c040c 	rsbeq	r0, ip, #12, 8	; 0xc000000
     650:	74110000 	ldrvc	r0, [r1], #-0
     654:	14000005 	strne	r0, [r0], #-5
     658:	00072206 	andeq	r2, r7, r6, lsl #4
     65c:	0e000006 	cdpeq	0, 0, cr0, cr0, cr6, {0}
     660:	0000082f 	andeq	r0, r0, pc, lsr #16
     664:	48122606 	ldmdami	r2, {r1, r2, r9, sl, sp}
     668:	00000000 	andeq	r0, r0, r0
     66c:	00048b0e 	andeq	r8, r4, lr, lsl #22
     670:	1d290600 	stcne	6, cr0, [r9, #-0]
     674:	00000372 	andeq	r0, r0, r2, ror r3
     678:	0a180e04 	beq	603e90 <__bss_end+0x5faf2c>
     67c:	2c060000 	stccs	0, cr0, [r6], {-0}
     680:	0003721d 	andeq	r7, r3, sp, lsl r2
     684:	a0120800 	andsge	r0, r2, r0, lsl #16
     688:	0600000b 	streq	r0, [r0], -fp
     68c:	0adc0e2f 	beq	ff703f50 <__bss_end+0xff6fafec>
     690:	03c60000 	biceq	r0, r6, #0
     694:	03d10000 	bicseq	r0, r1, #0
     698:	05130000 	ldreq	r0, [r3, #-0]
     69c:	14000006 	strne	r0, [r0], #-6
     6a0:	00000372 	andeq	r0, r0, r2, ror r3
     6a4:	0ac41500 	beq	ff105aac <__bss_end+0xff0fcb48>
     6a8:	31060000 	mrscc	r0, (UNDEF: 6)
     6ac:	0004380e 	andeq	r3, r4, lr, lsl #16
     6b0:	0001a700 	andeq	sl, r1, r0, lsl #14
     6b4:	0003e900 	andeq	lr, r3, r0, lsl #18
     6b8:	0003f400 	andeq	pc, r3, r0, lsl #8
     6bc:	06051300 	streq	r1, [r5], -r0, lsl #6
     6c0:	78140000 	ldmdavc	r4, {}	; <UNPREDICTABLE>
     6c4:	00000003 	andeq	r0, r0, r3
     6c8:	000b1216 	andeq	r1, fp, r6, lsl r2
     6cc:	1d350600 	ldcne	6, cr0, [r5, #-0]
     6d0:	00000a9a 	muleq	r0, sl, sl
     6d4:	00000372 	andeq	r0, r0, r2, ror r3
     6d8:	00040d02 	andeq	r0, r4, r2, lsl #26
     6dc:	00041300 	andeq	r1, r4, r0, lsl #6
     6e0:	06051300 	streq	r1, [r5], -r0, lsl #6
     6e4:	16000000 	strne	r0, [r0], -r0
     6e8:	000007a1 	andeq	r0, r0, r1, lsr #15
     6ec:	ac1d3706 	ldcge	7, cr3, [sp], {6}
     6f0:	72000009 	andvc	r0, r0, #9
     6f4:	02000003 	andeq	r0, r0, #3
     6f8:	0000042c 	andeq	r0, r0, ip, lsr #8
     6fc:	00000432 	andeq	r0, r0, r2, lsr r4
     700:	00060513 	andeq	r0, r6, r3, lsl r5
     704:	a1170000 	tstge	r7, r0
     708:	06000008 	streq	r0, [r0], -r8
     70c:	061e3139 			; <UNDEFINED> instruction: 0x061e3139
     710:	020c0000 	andeq	r0, ip, #0
     714:	00057416 	andeq	r7, r5, r6, lsl r4
     718:	093c0600 	ldmdbeq	ip!, {r9, sl}
     71c:	00000c0d 	andeq	r0, r0, sp, lsl #24
     720:	00000605 	andeq	r0, r0, r5, lsl #12
     724:	00045901 	andeq	r5, r4, r1, lsl #18
     728:	00045f00 	andeq	r5, r4, r0, lsl #30
     72c:	06051300 	streq	r1, [r5], -r0, lsl #6
     730:	16000000 	strne	r0, [r0], -r0
     734:	0000051e 	andeq	r0, r0, lr, lsl r5
     738:	75123f06 	ldrvc	r3, [r2, #-3846]	; 0xfffff0fa
     73c:	4800000b 	stmdami	r0, {r0, r1, r3}
     740:	01000000 	mrseq	r0, (UNDEF: 0)
     744:	00000478 	andeq	r0, r0, r8, ror r4
     748:	0000048d 	andeq	r0, r0, sp, lsl #9
     74c:	00060513 	andeq	r0, r6, r3, lsl r5
     750:	06271400 	strteq	r1, [r7], -r0, lsl #8
     754:	59140000 	ldmdbpl	r4, {}	; <UNPREDICTABLE>
     758:	14000000 	strne	r0, [r0], #-0
     75c:	000001a7 	andeq	r0, r0, r7, lsr #3
     760:	0ad31800 	beq	ff4c6768 <__bss_end+0xff4bd804>
     764:	42060000 	andmi	r0, r6, #0
     768:	00092a0e 	andeq	r2, r9, lr, lsl #20
     76c:	04a20100 	strteq	r0, [r2], #256	; 0x100
     770:	04a80000 	strteq	r0, [r8], #0
     774:	05130000 	ldreq	r0, [r3, #-0]
     778:	00000006 	andeq	r0, r0, r6
     77c:	00072e16 	andeq	r2, r7, r6, lsl lr
     780:	17450600 	strbne	r0, [r5, -r0, lsl #12]
     784:	0000049e 	muleq	r0, lr, r4
     788:	00000378 	andeq	r0, r0, r8, ror r3
     78c:	0004c101 	andeq	ip, r4, r1, lsl #2
     790:	0004c700 	andeq	ip, r4, r0, lsl #14
     794:	062d1300 	strteq	r1, [sp], -r0, lsl #6
     798:	16000000 	strne	r0, [r0], -r0
     79c:	000004d1 	ldrdeq	r0, [r0], -r1
     7a0:	57174806 	ldrpl	r4, [r7, -r6, lsl #16]
     7a4:	7800000a 	stmdavc	r0, {r1, r3}
     7a8:	01000003 	tsteq	r0, r3
     7ac:	000004e0 	andeq	r0, r0, r0, ror #9
     7b0:	000004eb 	andeq	r0, r0, fp, ror #9
     7b4:	00062d13 	andeq	r2, r6, r3, lsl sp
     7b8:	00481400 	subeq	r1, r8, r0, lsl #8
     7bc:	18000000 	stmdane	r0, {}	; <UNPREDICTABLE>
     7c0:	00000bd1 	ldrdeq	r0, [r0], -r1
     7c4:	040e4b06 	streq	r4, [lr], #-2822	; 0xfffff4fa
     7c8:	01000004 	tsteq	r0, r4
     7cc:	00000500 	andeq	r0, r0, r0, lsl #10
     7d0:	00000506 	andeq	r0, r0, r6, lsl #10
     7d4:	00060513 	andeq	r0, r6, r3, lsl r5
     7d8:	c4160000 	ldrgt	r0, [r6], #-0
     7dc:	0600000a 	streq	r0, [r0], -sl
     7e0:	066f0e4d 	strbteq	r0, [pc], -sp, asr #28
     7e4:	01a70000 			; <UNDEFINED> instruction: 0x01a70000
     7e8:	1f010000 	svcne	0x00010000
     7ec:	2a000005 	bcs	808 <shift+0x808>
     7f0:	13000005 	movwne	r0, #5
     7f4:	00000605 	andeq	r0, r0, r5, lsl #12
     7f8:	00004814 	andeq	r4, r0, r4, lsl r8
     7fc:	54160000 	ldrpl	r0, [r6], #-0
     800:	06000007 	streq	r0, [r0], -r7
     804:	094b1250 	stmdbeq	fp, {r4, r6, r9, ip}^
     808:	00480000 	subeq	r0, r8, r0
     80c:	43010000 	movwmi	r0, #4096	; 0x1000
     810:	4e000005 	cdpmi	0, 0, cr0, cr0, cr5, {0}
     814:	13000005 	movwne	r0, #5
     818:	00000605 	andeq	r0, r0, r5, lsl #12
     81c:	0001ae14 	andeq	sl, r1, r4, lsl lr
     820:	6e160000 	cdpvs	0, 1, cr0, cr6, cr0, {0}
     824:	06000004 	streq	r0, [r0], -r4
     828:	06f80e53 	usateq	r0, #24, r3, asr #28
     82c:	01a70000 			; <UNDEFINED> instruction: 0x01a70000
     830:	67010000 	strvs	r0, [r1, -r0]
     834:	72000005 	andvc	r0, r0, #5
     838:	13000005 	movwne	r0, #5
     83c:	00000605 	andeq	r0, r0, r5, lsl #12
     840:	00004814 	andeq	r4, r0, r4, lsl r8
     844:	7b180000 	blvc	60084c <__bss_end+0x5f78e8>
     848:	06000007 	streq	r0, [r0], -r7
     84c:	0b1e0e56 	bleq	7841ac <__bss_end+0x77b248>
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
     878:	84180000 	ldrhi	r0, [r8], #-0
     87c:	0600000a 	streq	r0, [r0], -sl
     880:	05d80e58 	ldrbeq	r0, [r8, #3672]	; 0xe58
     884:	bb010000 	bllt	4088c <__bss_end+0x37928>
     888:	da000005 	ble	8a4 <shift+0x8a4>
     88c:	13000005 	movwne	r0, #5
     890:	00000605 	andeq	r0, r0, r5, lsl #12
     894:	0000c214 	andeq	ip, r0, r4, lsl r2
     898:	00481400 	subeq	r1, r8, r0, lsl #8
     89c:	48140000 	ldmdami	r4, {}	; <UNPREDICTABLE>
     8a0:	14000000 	strne	r0, [r0], #-0
     8a4:	00000048 	andeq	r0, r0, r8, asr #32
     8a8:	00063314 	andeq	r3, r6, r4, lsl r3
     8ac:	4e190000 	cdpmi	0, 1, cr0, cr9, cr0, {0}
     8b0:	06000005 	streq	r0, [r0], -r5
     8b4:	05950e5b 	ldreq	r0, [r5, #3675]	; 0xe5b
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
     91c:	000008d6 	ldrdeq	r0, [r0], -r6
     920:	60190707 	andsvs	r0, r9, r7, lsl #14
     924:	80000000 	andhi	r0, r0, r0
     928:	1f0ee6b2 	svcne	0x000ee6b2
     92c:	000009f7 	strdeq	r0, [r0], -r7
     930:	671a0a07 	ldrvs	r0, [sl, -r7, lsl #20]
     934:	00000002 	andeq	r0, r0, r2
     938:	1f200000 	svcne	0x00200000
     93c:	000008af 	andeq	r0, r0, pc, lsr #17
     940:	671a0d07 	ldrvs	r0, [sl, -r7, lsl #26]
     944:	00000002 	andeq	r0, r0, r2
     948:	20202000 	eorcs	r2, r0, r0
     94c:	000009d2 	ldrdeq	r0, [r0], -r2
     950:	54151007 	ldrpl	r1, [r5], #-7
     954:	36000000 	strcc	r0, [r0], -r0
     958:	0005451f 	andeq	r4, r5, pc, lsl r5
     95c:	1a420700 	bne	1082564 <__bss_end+0x1079600>
     960:	00000267 	andeq	r0, r0, r7, ror #4
     964:	20215000 	eorcs	r5, r1, r0
     968:	0006bb1f 	andeq	fp, r6, pc, lsl fp
     96c:	1a710700 	bne	1c42574 <__bss_end+0x1c39610>
     970:	00000267 	andeq	r0, r0, r7, ror #4
     974:	2000b200 	andcs	fp, r0, r0, lsl #4
     978:	0004e41f 	andeq	lr, r4, pc, lsl r4
     97c:	1aa40700 	bne	fe902584 <__bss_end+0xfe8f9620>
     980:	00000267 	andeq	r0, r0, r7, ror #4
     984:	2000b400 	andcs	fp, r0, r0, lsl #8
     988:	0007241f 	andeq	r2, r7, pc, lsl r4
     98c:	1ab30700 	bne	fecc2594 <__bss_end+0xfecb9630>
     990:	00000267 	andeq	r0, r0, r7, ror #4
     994:	20104000 	andscs	r4, r0, r0
     998:	00069f1f 	andeq	r9, r6, pc, lsl pc
     99c:	1abe0700 	bne	fef825a4 <__bss_end+0xfef79640>
     9a0:	00000267 	andeq	r0, r0, r7, ror #4
     9a4:	20205000 	eorcs	r5, r0, r0
     9a8:	0006d51f 	andeq	sp, r6, pc, lsl r5
     9ac:	1abf0700 	bne	fefc25b4 <__bss_end+0xfefb9650>
     9b0:	00000267 	andeq	r0, r0, r7, ror #4
     9b4:	20804000 	addcs	r4, r0, r0
     9b8:	0004811f 	andeq	r8, r4, pc, lsl r1
     9bc:	1ac00700 	bne	ff0025c4 <__bss_end+0xfeff9660>
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
     a00:	0009eb0a 	andeq	lr, r9, sl, lsl #22
     a04:	14080800 	strne	r0, [r8], #-2048	; 0xfffff800
     a08:	00000054 	andeq	r0, r0, r4, asr r0
     a0c:	8ec00305 	cdphi	3, 12, cr0, cr0, cr5, {0}
     a10:	9a0a0000 	bls	280a18 <__bss_end+0x277ab4>
     a14:	01000009 	tsteq	r0, r9
     a18:	0054140d 	subseq	r1, r4, sp, lsl #8
     a1c:	03050000 	movweq	r0, #20480	; 0x5000
     a20:	00008ec4 	andeq	r8, r0, r4, asr #29
     a24:	0005850a 	andeq	r8, r5, sl, lsl #10
     a28:	140e0100 	strne	r0, [lr], #-256	; 0xffffff00
     a2c:	00000054 	andeq	r0, r0, r4, asr r0
     a30:	8ec80305 	cdphi	3, 12, cr0, cr8, cr5, {0}
     a34:	6b220000 	blvs	880a3c <__bss_end+0x877ad8>
     a38:	01000008 	tsteq	r0, r8
     a3c:	00480a10 	subeq	r0, r8, r0, lsl sl
     a40:	03050000 	movweq	r0, #20480	; 0x5000
     a44:	00008f50 	andeq	r8, r0, r0, asr pc
     a48:	000c0223 	andeq	r0, ip, r3, lsr #4
     a4c:	05190100 	ldreq	r0, [r9, #-256]	; 0xffffff00
     a50:	00000033 	andeq	r0, r0, r3, lsr r0
     a54:	000082ac 	andeq	r8, r0, ip, lsr #5
     a58:	00000098 	muleq	r0, r8, r0
     a5c:	07cb9c01 	strbeq	r9, [fp, r1, lsl #24]
     a60:	ed240000 	stc	0, cr0, [r4, #-0]
     a64:	0100000b 	tsteq	r0, fp
     a68:	00330e19 	eorseq	r0, r3, r9, lsl lr
     a6c:	91020000 	mrsls	r0, (UNDEF: 2)
     a70:	0b702454 	bleq	1c09bc8 <__bss_end+0x1c00c64>
     a74:	19010000 	stmdbne	r1, {}	; <UNPREDICTABLE>
     a78:	0007cb1b 	andeq	ip, r7, fp, lsl fp
     a7c:	50910200 	addspl	r0, r1, r0, lsl #4
     a80:	00091525 	andeq	r1, r9, r5, lsr #10
     a84:	0a1b0100 	beq	6c0e8c <__bss_end+0x6b7f28>
     a88:	000007d7 	ldrdeq	r0, [r0], -r7
     a8c:	255c9102 	ldrbcs	r9, [ip, #-258]	; 0xfffffefe
     a90:	00000bf2 	strdeq	r0, [r0], -r2
     a94:	480b1f01 	stmdami	fp, {r0, r8, r9, sl, fp, ip}
     a98:	02000000 	andeq	r0, r0, #0
     a9c:	0c007491 	cfstrseq	mvf7, [r0], {145}	; 0x91
     aa0:	0007d104 	andeq	sp, r7, r4, lsl #2
     aa4:	25040c00 	strcs	r0, [r4, #-3072]	; 0xfffff400
     aa8:	0f000000 	svceq	0x00000000
     aac:	00000025 	andeq	r0, r0, r5, lsr #32
     ab0:	000007e7 	andeq	r0, r0, r7, ror #15
     ab4:	00005910 	andeq	r5, r0, r0, lsl r9
     ab8:	26001700 	strcs	r1, [r0], -r0, lsl #14
     abc:	0000064d 	andeq	r0, r0, sp, asr #12
     ac0:	2b061201 	blcs	1852cc <__bss_end+0x17c368>
     ac4:	2c00000a 	stccs	0, cr0, [r0], {10}
     ac8:	80000082 	andhi	r0, r0, r2, lsl #1
     acc:	01000000 	mrseq	r0, (UNDEF: 0)
     ad0:	0647249c 			; <UNDEFINED> instruction: 0x0647249c
     ad4:	12010000 	andne	r0, r1, #0
     ad8:	0001a711 	andeq	sl, r1, r1, lsl r7
     adc:	77910200 	ldrvc	r0, [r1, r0, lsl #4]
     ae0:	0b1f0000 	bleq	7c0ae8 <__bss_end+0x7b7b84>
     ae4:	00040000 	andeq	r0, r4, r0
     ae8:	00000433 	andeq	r0, r0, r3, lsr r4
     aec:	0f6f0104 	svceq	0x006f0104
     af0:	48040000 	stmdami	r4, {}	; <UNPREDICTABLE>
     af4:	3700000e 	strcc	r0, [r0, -lr]
     af8:	4400000c 	strmi	r0, [r0], #-12
     afc:	5c000083 	stcpl	0, cr0, [r0], {131}	; 0x83
     b00:	3a000004 	bcc	b18 <shift+0xb18>
     b04:	02000005 	andeq	r0, r0, #5
     b08:	09950801 	ldmibeq	r5, {r0, fp}
     b0c:	25030000 	strcs	r0, [r3, #-0]
     b10:	02000000 	andeq	r0, r0, #0
     b14:	09e10502 	stmibeq	r1!, {r1, r8, sl}^
     b18:	04040000 	streq	r0, [r4], #-0
     b1c:	746e6905 	strbtvc	r6, [lr], #-2309	; 0xfffff6fb
     b20:	08010200 	stmdaeq	r1, {r9}
     b24:	0000098c 	andeq	r0, r0, ip, lsl #19
     b28:	8e070202 	cdphi	2, 0, cr0, cr7, cr2, {0}
     b2c:	05000007 	streq	r0, [r0, #-7]
     b30:	00000a0f 	andeq	r0, r0, pc, lsl #20
     b34:	5e070907 	vmlapl.f16	s0, s14, s14	; <UNPREDICTABLE>
     b38:	03000000 	movweq	r0, #0
     b3c:	0000004d 	andeq	r0, r0, sp, asr #32
     b40:	47070402 	strmi	r0, [r7, -r2, lsl #8]
     b44:	06000007 	streq	r0, [r0], -r7
     b48:	00000624 	andeq	r0, r0, r4, lsr #12
     b4c:	08060208 	stmdaeq	r6, {r3, r9}
     b50:	0000008b 	andeq	r0, r0, fp, lsl #1
     b54:	00307207 	eorseq	r7, r0, r7, lsl #4
     b58:	4d0e0802 	stcmi	8, cr0, [lr, #-8]
     b5c:	00000000 	andeq	r0, r0, r0
     b60:	00317207 	eorseq	r7, r1, r7, lsl #4
     b64:	4d0e0902 	vstrmi.16	s0, [lr, #-4]	; <UNPREDICTABLE>
     b68:	04000000 	streq	r0, [r0], #-0
     b6c:	0ef90800 	cdpeq	8, 15, cr0, cr9, cr0, {0}
     b70:	04050000 	streq	r0, [r5], #-0
     b74:	00000038 	andeq	r0, r0, r8, lsr r0
     b78:	a90c0d02 	stmdbge	ip, {r1, r8, sl, fp}
     b7c:	09000000 	stmdbeq	r0, {}	; <UNPREDICTABLE>
     b80:	00004b4f 	andeq	r4, r0, pc, asr #22
     b84:	000ce50a 	andeq	lr, ip, sl, lsl #10
     b88:	08000100 	stmdaeq	r0, {r8}
     b8c:	000004ef 	andeq	r0, r0, pc, ror #9
     b90:	00380405 	eorseq	r0, r8, r5, lsl #8
     b94:	1e020000 	cdpne	0, 0, cr0, cr2, cr0, {0}
     b98:	0000e00c 	andeq	lr, r0, ip
     b9c:	06970a00 	ldreq	r0, [r7], r0, lsl #20
     ba0:	0a000000 	beq	ba8 <shift+0xba8>
     ba4:	00000c27 	andeq	r0, r0, r7, lsr #24
     ba8:	0c070a01 			; <UNDEFINED> instruction: 0x0c070a01
     bac:	0a020000 	beq	80bb4 <__bss_end+0x77c50>
     bb0:	00000824 	andeq	r0, r0, r4, lsr #16
     bb4:	091b0a03 	ldmdbeq	fp, {r0, r1, r9, fp}
     bb8:	0a040000 	beq	100bc0 <__bss_end+0xf7c5c>
     bbc:	00000660 	andeq	r0, r0, r0, ror #12
     bc0:	aa080005 	bge	200bdc <__bss_end+0x1f7c78>
     bc4:	0500000b 	streq	r0, [r0, #-11]
     bc8:	00003804 	andeq	r3, r0, r4, lsl #16
     bcc:	0c3f0200 	lfmeq	f0, 4, [pc], #-0	; bd4 <shift+0xbd4>
     bd0:	0000011d 	andeq	r0, r0, sp, lsl r1
     bd4:	0003ff0a 	andeq	pc, r3, sl, lsl #30
     bd8:	040a0000 	streq	r0, [sl], #-0
     bdc:	01000005 	tsteq	r0, r5
     be0:	0009080a 	andeq	r0, r9, sl, lsl #16
     be4:	e70a0200 	str	r0, [sl, -r0, lsl #4]
     be8:	0300000b 	movweq	r0, #11
     bec:	000c310a 	andeq	r3, ip, sl, lsl #2
     bf0:	cf0a0400 	svcgt	0x000a0400
     bf4:	05000008 	streq	r0, [r0, #-8]
     bf8:	0007ae0a 	andeq	sl, r7, sl, lsl #28
     bfc:	08000600 	stmdaeq	r0, {r9, sl}
     c00:	00001020 	andeq	r1, r0, r0, lsr #32
     c04:	00380405 	eorseq	r0, r8, r5, lsl #8
     c08:	66020000 	strvs	r0, [r2], -r0
     c0c:	0001480c 	andeq	r4, r1, ip, lsl #16
     c10:	0e3d0a00 	vaddeq.f32	s0, s26, s0
     c14:	0a000000 	beq	c1c <shift+0xc1c>
     c18:	00000d42 	andeq	r0, r0, r2, asr #26
     c1c:	0ec20a01 	vdiveq.f32	s1, s4, s2
     c20:	0a020000 	beq	80c28 <__bss_end+0x77cc4>
     c24:	00000d67 	andeq	r0, r0, r7, ror #26
     c28:	e90b0003 	stmdb	fp, {r0, r1}
     c2c:	03000008 	movweq	r0, #8
     c30:	00591405 	subseq	r1, r9, r5, lsl #8
     c34:	03050000 	movweq	r0, #20480	; 0x5000
     c38:	00008f04 	andeq	r8, r0, r4, lsl #30
     c3c:	0008f70b 	andeq	pc, r8, fp, lsl #14
     c40:	14060300 	strne	r0, [r6], #-768	; 0xfffffd00
     c44:	00000059 	andeq	r0, r0, r9, asr r0
     c48:	8f080305 	svchi	0x00080305
     c4c:	b90b0000 	stmdblt	fp, {}	; <UNPREDICTABLE>
     c50:	04000008 	streq	r0, [r0], #-8
     c54:	00591a07 	subseq	r1, r9, r7, lsl #20
     c58:	03050000 	movweq	r0, #20480	; 0x5000
     c5c:	00008f0c 	andeq	r8, r0, ip, lsl #30
     c60:	0005330b 	andeq	r3, r5, fp, lsl #6
     c64:	1a090400 	bne	241c6c <__bss_end+0x238d08>
     c68:	00000059 	andeq	r0, r0, r9, asr r0
     c6c:	8f100305 	svchi	0x00100305
     c70:	7e0b0000 	cdpvc	0, 0, cr0, cr11, cr0, {0}
     c74:	04000009 	streq	r0, [r0], #-9
     c78:	00591a0b 	subseq	r1, r9, fp, lsl #20
     c7c:	03050000 	movweq	r0, #20480	; 0x5000
     c80:	00008f14 	andeq	r8, r0, r4, lsl pc
     c84:	0007680b 	andeq	r6, r7, fp, lsl #16
     c88:	1a0d0400 	bne	341c90 <__bss_end+0x338d2c>
     c8c:	00000059 	andeq	r0, r0, r9, asr r0
     c90:	8f180305 	svchi	0x00180305
     c94:	3d0b0000 	stccc	0, cr0, [fp, #-0]
     c98:	04000006 	streq	r0, [r0], #-6
     c9c:	00591a0f 	subseq	r1, r9, pc, lsl #20
     ca0:	03050000 	movweq	r0, #20480	; 0x5000
     ca4:	00008f1c 	andeq	r8, r0, ip, lsl pc
     ca8:	00107308 	andseq	r7, r0, r8, lsl #6
     cac:	38040500 	stmdacc	r4, {r8, sl}
     cb0:	04000000 	streq	r0, [r0], #-0
     cb4:	01eb0c1b 	mvneq	r0, fp, lsl ip
     cb8:	410a0000 	mrsmi	r0, (UNDEF: 10)
     cbc:	0000000a 	andeq	r0, r0, sl
     cc0:	000bf70a 	andeq	pc, fp, sl, lsl #14
     cc4:	030a0100 	movweq	r0, #41216	; 0xa100
     cc8:	02000009 	andeq	r0, r0, #9
     ccc:	09780c00 	ldmdbeq	r8!, {sl, fp}^
     cd0:	01020000 	mrseq	r0, (UNDEF: 2)
     cd4:	00082a02 	andeq	r2, r8, r2, lsl #20
     cd8:	2c040d00 	stccs	13, cr0, [r4], {-0}
     cdc:	0d000000 	stceq	0, cr0, [r0, #-0]
     ce0:	0001eb04 	andeq	lr, r1, r4, lsl #22
     ce4:	06df0b00 	ldrbeq	r0, [pc], r0, lsl #22
     ce8:	04050000 	streq	r0, [r5], #-0
     cec:	00005914 	andeq	r5, r0, r4, lsl r9
     cf0:	20030500 	andcs	r0, r3, r0, lsl #10
     cf4:	0b00008f 	bleq	f38 <shift+0xf38>
     cf8:	000003f4 	strdeq	r0, [r0], -r4
     cfc:	59140705 	ldmdbpl	r4, {r0, r2, r8, r9, sl}
     d00:	05000000 	streq	r0, [r0, #-0]
     d04:	008f2403 	addeq	r2, pc, r3, lsl #8
     d08:	05610b00 	strbeq	r0, [r1, #-2816]!	; 0xfffff500
     d0c:	0a050000 	beq	140d14 <__bss_end+0x137db0>
     d10:	00005914 	andeq	r5, r0, r4, lsl r9
     d14:	28030500 	stmdacs	r3, {r8, sl}
     d18:	0800008f 	stmdaeq	r0, {r0, r1, r2, r3, r7}
     d1c:	0000085f 	andeq	r0, r0, pc, asr r8
     d20:	00380405 	eorseq	r0, r8, r5, lsl #8
     d24:	0d050000 	stceq	0, cr0, [r5, #-0]
     d28:	0002700c 	andeq	r7, r2, ip
     d2c:	654e0900 	strbvs	r0, [lr, #-2304]	; 0xfffff700
     d30:	0a000077 	beq	f14 <shift+0xf14>
     d34:	00000856 	andeq	r0, r0, r6, asr r8
     d38:	0a070a01 	beq	1c3544 <__bss_end+0x1ba5e0>
     d3c:	0a020000 	beq	80d44 <__bss_end+0x77de0>
     d40:	00000839 	andeq	r0, r0, r9, lsr r8
     d44:	08160a03 	ldmdaeq	r6, {r0, r1, r9, fp}
     d48:	0a040000 	beq	100d50 <__bss_end+0xf7dec>
     d4c:	0000090e 	andeq	r0, r0, lr, lsl #18
     d50:	53060005 	movwpl	r0, #24581	; 0x6005
     d54:	10000006 	andne	r0, r0, r6
     d58:	af081b05 	svcge	0x00081b05
     d5c:	07000002 	streq	r0, [r0, -r2]
     d60:	0500726c 	streq	r7, [r0, #-620]	; 0xfffffd94
     d64:	02af131d 	adceq	r1, pc, #1946157056	; 0x74000000
     d68:	07000000 	streq	r0, [r0, -r0]
     d6c:	05007073 	streq	r7, [r0, #-115]	; 0xffffff8d
     d70:	02af131e 	adceq	r1, pc, #2013265920	; 0x78000000
     d74:	07040000 	streq	r0, [r4, -r0]
     d78:	05006370 	streq	r6, [r0, #-880]	; 0xfffffc90
     d7c:	02af131f 	adceq	r1, pc, #2080374784	; 0x7c000000
     d80:	0e080000 	cdpeq	0, 0, cr0, cr8, cr0, {0}
     d84:	00000669 	andeq	r0, r0, r9, ror #12
     d88:	af132005 	svcge	0x00132005
     d8c:	0c000002 	stceq	0, cr0, [r0], {2}
     d90:	07040200 	streq	r0, [r4, -r0, lsl #4]
     d94:	00000742 	andeq	r0, r0, r2, asr #14
     d98:	00046106 	andeq	r6, r4, r6, lsl #2
     d9c:	28057000 	stmdacs	r5, {ip, sp, lr}
     da0:	00034608 	andeq	r4, r3, r8, lsl #12
     da4:	0a350e00 	beq	d445ac <__bss_end+0xd3b648>
     da8:	2a050000 	bcs	140db0 <__bss_end+0x137e4c>
     dac:	00027012 	andeq	r7, r2, r2, lsl r0
     db0:	70070000 	andvc	r0, r7, r0
     db4:	05006469 	streq	r6, [r0, #-1129]	; 0xfffffb97
     db8:	005e122b 	subseq	r1, lr, fp, lsr #4
     dbc:	0e100000 	cdpeq	0, 1, cr0, cr0, cr0, {0}
     dc0:	0000052d 	andeq	r0, r0, sp, lsr #10
     dc4:	39112c05 	ldmdbcc	r1, {r0, r2, sl, fp, sp}
     dc8:	14000002 	strne	r0, [r0], #-2
     dcc:	0008730e 	andeq	r7, r8, lr, lsl #6
     dd0:	122d0500 	eorne	r0, sp, #0, 10
     dd4:	0000005e 	andeq	r0, r0, lr, asr r0
     dd8:	08810e18 	stmeq	r1, {r3, r4, r9, sl, fp}
     ddc:	2e050000 	cdpcs	0, 0, cr0, cr5, cr0, {0}
     de0:	00005e12 	andeq	r5, r0, r2, lsl lr
     de4:	300e1c00 	andcc	r1, lr, r0, lsl #24
     de8:	05000006 	streq	r0, [r0, #-6]
     dec:	03460c2f 	movteq	r0, #27695	; 0x6c2f
     df0:	0e200000 	cdpeq	0, 2, cr0, cr0, cr0, {0}
     df4:	00000897 	muleq	r0, r7, r8
     df8:	38093005 	stmdacc	r9, {r0, r2, ip, sp}
     dfc:	60000000 	andvs	r0, r0, r0
     e00:	000a4b0e 	andeq	r4, sl, lr, lsl #22
     e04:	0e310500 	cfabs32eq	mvfx0, mvfx1
     e08:	0000004d 	andeq	r0, r0, sp, asr #32
     e0c:	06b20e64 	ldrteq	r0, [r2], r4, ror #28
     e10:	33050000 	movwcc	r0, #20480	; 0x5000
     e14:	00004d0e 	andeq	r4, r0, lr, lsl #26
     e18:	a90e6800 	stmdbge	lr, {fp, sp, lr}
     e1c:	05000006 	streq	r0, [r0, #-6]
     e20:	004d0e34 	subeq	r0, sp, r4, lsr lr
     e24:	006c0000 	rsbeq	r0, ip, r0
     e28:	0001fd0f 	andeq	pc, r1, pc, lsl #26
     e2c:	00035600 	andeq	r5, r3, r0, lsl #12
     e30:	005e1000 	subseq	r1, lr, r0
     e34:	000f0000 	andeq	r0, pc, r0
     e38:	000bc20b 	andeq	ip, fp, fp, lsl #4
     e3c:	140a0600 	strne	r0, [sl], #-1536	; 0xfffffa00
     e40:	00000059 	andeq	r0, r0, r9, asr r0
     e44:	8f2c0305 	svchi	0x002c0305
     e48:	41080000 	mrsmi	r0, (UNDEF: 8)
     e4c:	05000008 	streq	r0, [r0, #-8]
     e50:	00003804 	andeq	r3, r0, r4, lsl #16
     e54:	0c0d0600 	stceq	6, cr0, [sp], {-0}
     e58:	00000387 	andeq	r0, r0, r7, lsl #7
     e5c:	0005090a 	andeq	r0, r5, sl, lsl #18
     e60:	e90a0000 	stmdb	sl, {}	; <UNPREDICTABLE>
     e64:	01000003 	tsteq	r0, r3
     e68:	03680300 	cmneq	r8, #0, 6
     e6c:	cf080000 	svcgt	0x00080000
     e70:	0500000d 	streq	r0, [r0, #-13]
     e74:	00003804 	andeq	r3, r0, r4, lsl #16
     e78:	0c140600 	ldceq	6, cr0, [r4], {-0}
     e7c:	000003ab 	andeq	r0, r0, fp, lsr #7
     e80:	000c880a 	andeq	r8, ip, sl, lsl #16
     e84:	b40a0000 	strlt	r0, [sl], #-0
     e88:	0100000e 	tsteq	r0, lr
     e8c:	038c0300 	orreq	r0, ip, #0, 6
     e90:	ff060000 			; <UNDEFINED> instruction: 0xff060000
     e94:	0c00000a 	stceq	0, cr0, [r0], {10}
     e98:	e5081b06 	str	r1, [r8, #-2822]	; 0xfffff4fa
     e9c:	0e000003 	cdpeq	0, 0, cr0, cr0, cr3, {0}
     ea0:	00000433 	andeq	r0, r0, r3, lsr r4
     ea4:	e5191d06 	ldr	r1, [r9, #-3334]	; 0xfffff2fa
     ea8:	00000003 	andeq	r0, r0, r3
     eac:	0004cc0e 	andeq	ip, r4, lr, lsl #24
     eb0:	191e0600 	ldmdbne	lr, {r9, sl}
     eb4:	000003e5 	andeq	r0, r0, r5, ror #7
     eb8:	0abf0e04 	beq	fefc46d0 <__bss_end+0xfefbb76c>
     ebc:	1f060000 	svcne	0x00060000
     ec0:	0003eb13 	andeq	lr, r3, r3, lsl fp
     ec4:	0d000800 	stceq	8, cr0, [r0, #-0]
     ec8:	0003b004 	andeq	fp, r3, r4
     ecc:	b6040d00 	strlt	r0, [r4], -r0, lsl #26
     ed0:	11000002 	tstne	r0, r2
     ed4:	00000574 	andeq	r0, r0, r4, ror r5
     ed8:	07220614 			; <UNDEFINED> instruction: 0x07220614
     edc:	00000673 	andeq	r0, r0, r3, ror r6
     ee0:	00082f0e 	andeq	r2, r8, lr, lsl #30
     ee4:	12260600 	eorne	r0, r6, #0, 12
     ee8:	0000004d 	andeq	r0, r0, sp, asr #32
     eec:	048b0e00 	streq	r0, [fp], #3584	; 0xe00
     ef0:	29060000 	stmdbcs	r6, {}	; <UNPREDICTABLE>
     ef4:	0003e51d 	andeq	lr, r3, sp, lsl r5
     ef8:	180e0400 	stmdane	lr, {sl}
     efc:	0600000a 	streq	r0, [r0], -sl
     f00:	03e51d2c 	mvneq	r1, #44, 26	; 0xb00
     f04:	12080000 	andne	r0, r8, #0
     f08:	00000ba0 	andeq	r0, r0, r0, lsr #23
     f0c:	dc0e2f06 	stcle	15, cr2, [lr], {6}
     f10:	3900000a 	stmdbcc	r0, {r1, r3}
     f14:	44000004 	strmi	r0, [r0], #-4
     f18:	13000004 	movwne	r0, #4
     f1c:	00000678 	andeq	r0, r0, r8, ror r6
     f20:	0003e514 	andeq	lr, r3, r4, lsl r5
     f24:	c4150000 	ldrgt	r0, [r5], #-0
     f28:	0600000a 	streq	r0, [r0], -sl
     f2c:	04380e31 	ldrteq	r0, [r8], #-3633	; 0xfffff1cf
     f30:	01f00000 	mvnseq	r0, r0
     f34:	045c0000 	ldrbeq	r0, [ip], #-0
     f38:	04670000 	strbteq	r0, [r7], #-0
     f3c:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
     f40:	14000006 	strne	r0, [r0], #-6
     f44:	000003eb 	andeq	r0, r0, fp, ror #7
     f48:	0b121600 	bleq	486750 <__bss_end+0x47d7ec>
     f4c:	35060000 	strcc	r0, [r6, #-0]
     f50:	000a9a1d 	andeq	r9, sl, sp, lsl sl
     f54:	0003e500 	andeq	lr, r3, r0, lsl #10
     f58:	04800200 	streq	r0, [r0], #512	; 0x200
     f5c:	04860000 	streq	r0, [r6], #0
     f60:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
     f64:	00000006 	andeq	r0, r0, r6
     f68:	0007a116 	andeq	sl, r7, r6, lsl r1
     f6c:	1d370600 	ldcne	6, cr0, [r7, #-0]
     f70:	000009ac 	andeq	r0, r0, ip, lsr #19
     f74:	000003e5 	andeq	r0, r0, r5, ror #7
     f78:	00049f02 	andeq	r9, r4, r2, lsl #30
     f7c:	0004a500 	andeq	sl, r4, r0, lsl #10
     f80:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
     f84:	17000000 	strne	r0, [r0, -r0]
     f88:	000008a1 	andeq	r0, r0, r1, lsr #17
     f8c:	91313906 	teqls	r1, r6, lsl #18
     f90:	0c000006 	stceq	0, cr0, [r0], {6}
     f94:	05741602 	ldrbeq	r1, [r4, #-1538]!	; 0xfffff9fe
     f98:	3c060000 	stccc	0, cr0, [r6], {-0}
     f9c:	000c0d09 	andeq	r0, ip, r9, lsl #26
     fa0:	00067800 	andeq	r7, r6, r0, lsl #16
     fa4:	04cc0100 	strbeq	r0, [ip], #256	; 0x100
     fa8:	04d20000 	ldrbeq	r0, [r2], #0
     fac:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
     fb0:	00000006 	andeq	r0, r0, r6
     fb4:	00051e16 	andeq	r1, r5, r6, lsl lr
     fb8:	123f0600 	eorsne	r0, pc, #0, 12
     fbc:	00000b75 	andeq	r0, r0, r5, ror fp
     fc0:	0000004d 	andeq	r0, r0, sp, asr #32
     fc4:	0004eb01 	andeq	lr, r4, r1, lsl #22
     fc8:	00050000 	andeq	r0, r5, r0
     fcc:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
     fd0:	9a140000 	bls	500fd8 <__bss_end+0x4f8074>
     fd4:	14000006 	strne	r0, [r0], #-6
     fd8:	0000005e 	andeq	r0, r0, lr, asr r0
     fdc:	0001f014 	andeq	pc, r1, r4, lsl r0	; <UNPREDICTABLE>
     fe0:	d3180000 	tstle	r8, #0
     fe4:	0600000a 	streq	r0, [r0], -sl
     fe8:	092a0e42 	stmdbeq	sl!, {r1, r6, r9, sl, fp}
     fec:	15010000 	strne	r0, [r1, #-0]
     ff0:	1b000005 	blne	100c <shift+0x100c>
     ff4:	13000005 	movwne	r0, #5
     ff8:	00000678 	andeq	r0, r0, r8, ror r6
     ffc:	072e1600 	streq	r1, [lr, -r0, lsl #12]!
    1000:	45060000 	strmi	r0, [r6, #-0]
    1004:	00049e17 	andeq	r9, r4, r7, lsl lr
    1008:	0003eb00 	andeq	lr, r3, r0, lsl #22
    100c:	05340100 	ldreq	r0, [r4, #-256]!	; 0xffffff00
    1010:	053a0000 	ldreq	r0, [sl, #-0]!
    1014:	a0130000 	andsge	r0, r3, r0
    1018:	00000006 	andeq	r0, r0, r6
    101c:	0004d116 	andeq	sp, r4, r6, lsl r1
    1020:	17480600 	strbne	r0, [r8, -r0, lsl #12]
    1024:	00000a57 	andeq	r0, r0, r7, asr sl
    1028:	000003eb 	andeq	r0, r0, fp, ror #7
    102c:	00055301 	andeq	r5, r5, r1, lsl #6
    1030:	00055e00 	andeq	r5, r5, r0, lsl #28
    1034:	06a01300 	strteq	r1, [r0], r0, lsl #6
    1038:	4d140000 	ldcmi	0, cr0, [r4, #-0]
    103c:	00000000 	andeq	r0, r0, r0
    1040:	000bd118 	andeq	sp, fp, r8, lsl r1
    1044:	0e4b0600 	cdpeq	6, 4, cr0, cr11, cr0, {0}
    1048:	00000404 	andeq	r0, r0, r4, lsl #8
    104c:	00057301 	andeq	r7, r5, r1, lsl #6
    1050:	00057900 	andeq	r7, r5, r0, lsl #18
    1054:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
    1058:	16000000 	strne	r0, [r0], -r0
    105c:	00000ac4 	andeq	r0, r0, r4, asr #21
    1060:	6f0e4d06 	svcvs	0x000e4d06
    1064:	f0000006 			; <UNDEFINED> instruction: 0xf0000006
    1068:	01000001 	tsteq	r0, r1
    106c:	00000592 	muleq	r0, r2, r5
    1070:	0000059d 	muleq	r0, sp, r5
    1074:	00067813 	andeq	r7, r6, r3, lsl r8
    1078:	004d1400 	subeq	r1, sp, r0, lsl #8
    107c:	16000000 	strne	r0, [r0], -r0
    1080:	00000754 	andeq	r0, r0, r4, asr r7
    1084:	4b125006 	blmi	4950a4 <__bss_end+0x48c140>
    1088:	4d000009 	stcmi	0, cr0, [r0, #-36]	; 0xffffffdc
    108c:	01000000 	mrseq	r0, (UNDEF: 0)
    1090:	000005b6 			; <UNDEFINED> instruction: 0x000005b6
    1094:	000005c1 	andeq	r0, r0, r1, asr #11
    1098:	00067813 	andeq	r7, r6, r3, lsl r8
    109c:	01fd1400 	mvnseq	r1, r0, lsl #8
    10a0:	16000000 	strne	r0, [r0], -r0
    10a4:	0000046e 	andeq	r0, r0, lr, ror #8
    10a8:	f80e5306 			; <UNDEFINED> instruction: 0xf80e5306
    10ac:	f0000006 			; <UNDEFINED> instruction: 0xf0000006
    10b0:	01000001 	tsteq	r0, r1
    10b4:	000005da 	ldrdeq	r0, [r0], -sl
    10b8:	000005e5 	andeq	r0, r0, r5, ror #11
    10bc:	00067813 	andeq	r7, r6, r3, lsl r8
    10c0:	004d1400 	subeq	r1, sp, r0, lsl #8
    10c4:	18000000 	stmdane	r0, {}	; <UNPREDICTABLE>
    10c8:	0000077b 	andeq	r0, r0, fp, ror r7
    10cc:	1e0e5606 	cfmadd32ne	mvax0, mvfx5, mvfx14, mvfx6
    10d0:	0100000b 	tsteq	r0, fp
    10d4:	000005fa 	strdeq	r0, [r0], -sl
    10d8:	00000619 	andeq	r0, r0, r9, lsl r6
    10dc:	00067813 	andeq	r7, r6, r3, lsl r8
    10e0:	00a91400 	adceq	r1, r9, r0, lsl #8
    10e4:	4d140000 	ldcmi	0, cr0, [r4, #-0]
    10e8:	14000000 	strne	r0, [r0], #-0
    10ec:	0000004d 	andeq	r0, r0, sp, asr #32
    10f0:	00004d14 	andeq	r4, r0, r4, lsl sp
    10f4:	06a61400 	strteq	r1, [r6], r0, lsl #8
    10f8:	18000000 	stmdane	r0, {}	; <UNPREDICTABLE>
    10fc:	00000a84 	andeq	r0, r0, r4, lsl #21
    1100:	d80e5806 	stmdale	lr, {r1, r2, fp, ip, lr}
    1104:	01000005 	tsteq	r0, r5
    1108:	0000062e 	andeq	r0, r0, lr, lsr #12
    110c:	0000064d 	andeq	r0, r0, sp, asr #12
    1110:	00067813 	andeq	r7, r6, r3, lsl r8
    1114:	00e01400 	rsceq	r1, r0, r0, lsl #8
    1118:	4d140000 	ldcmi	0, cr0, [r4, #-0]
    111c:	14000000 	strne	r0, [r0], #-0
    1120:	0000004d 	andeq	r0, r0, sp, asr #32
    1124:	00004d14 	andeq	r4, r0, r4, lsl sp
    1128:	06a61400 	strteq	r1, [r6], r0, lsl #8
    112c:	19000000 	stmdbne	r0, {}	; <UNPREDICTABLE>
    1130:	0000054e 	andeq	r0, r0, lr, asr #10
    1134:	950e5b06 	strls	r5, [lr, #-2822]	; 0xfffff4fa
    1138:	f0000005 			; <UNDEFINED> instruction: 0xf0000005
    113c:	01000001 	tsteq	r0, r1
    1140:	00000662 	andeq	r0, r0, r2, ror #12
    1144:	00067813 	andeq	r7, r6, r3, lsl r8
    1148:	03681400 	cmneq	r8, #0, 8
    114c:	ac140000 	ldcge	0, cr0, [r4], {-0}
    1150:	00000006 	andeq	r0, r0, r6
    1154:	03f10300 	mvnseq	r0, #0, 6
    1158:	040d0000 	streq	r0, [sp], #-0
    115c:	000003f1 	strdeq	r0, [r0], -r1
    1160:	0003e51a 	andeq	lr, r3, sl, lsl r5
    1164:	00068b00 	andeq	r8, r6, r0, lsl #22
    1168:	00069100 	andeq	r9, r6, r0, lsl #2
    116c:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
    1170:	1b000000 	blne	1178 <shift+0x1178>
    1174:	000003f1 	strdeq	r0, [r0], -r1
    1178:	0000067e 	andeq	r0, r0, lr, ror r6
    117c:	003f040d 	eorseq	r0, pc, sp, lsl #8
    1180:	040d0000 	streq	r0, [sp], #-0
    1184:	00000673 	andeq	r0, r0, r3, ror r6
    1188:	0065041c 	rsbeq	r0, r5, ip, lsl r4
    118c:	041d0000 	ldreq	r0, [sp], #-0
    1190:	00002c0f 	andeq	r2, r0, pc, lsl #24
    1194:	0006be00 	andeq	fp, r6, r0, lsl #28
    1198:	005e1000 	subseq	r1, lr, r0
    119c:	00090000 	andeq	r0, r9, r0
    11a0:	0006ae03 	andeq	sl, r6, r3, lsl #28
    11a4:	0d311e00 	ldceq	14, cr1, [r1, #-0]
    11a8:	a4010000 	strge	r0, [r1], #-0
    11ac:	0006be0c 	andeq	fp, r6, ip, lsl #28
    11b0:	30030500 	andcc	r0, r3, r0, lsl #10
    11b4:	1f00008f 	svcne	0x0000008f
    11b8:	00000ca1 	andeq	r0, r0, r1, lsr #25
    11bc:	c30aa601 	movwgt	sl, #42497	; 0xa601
    11c0:	4d00000d 	stcmi	0, cr0, [r0, #-52]	; 0xffffffcc
    11c4:	f0000000 			; <UNDEFINED> instruction: 0xf0000000
    11c8:	b0000086 	andlt	r0, r0, r6, lsl #1
    11cc:	01000000 	mrseq	r0, (UNDEF: 0)
    11d0:	0007339c 	muleq	r7, ip, r3
    11d4:	10562000 	subsne	r2, r6, r0
    11d8:	a6010000 	strge	r0, [r1], -r0
    11dc:	0001f71b 	andeq	pc, r1, fp, lsl r7	; <UNPREDICTABLE>
    11e0:	ac910300 	ldcge	3, cr0, [r1], {0}
    11e4:	0e22207f 	mcreq	0, 1, r2, cr2, cr15, {3}
    11e8:	a6010000 	strge	r0, [r1], -r0
    11ec:	00004d2a 	andeq	r4, r0, sl, lsr #26
    11f0:	a8910300 	ldmge	r1, {r8, r9}
    11f4:	0dac1e7f 	stceq	14, cr1, [ip, #508]!	; 0x1fc
    11f8:	a8010000 	stmdage	r1, {}	; <UNPREDICTABLE>
    11fc:	0007330a 	andeq	r3, r7, sl, lsl #6
    1200:	b4910300 	ldrlt	r0, [r1], #768	; 0x300
    1204:	0c9c1e7f 	ldceq	14, cr1, [ip], {127}	; 0x7f
    1208:	ac010000 	stcge	0, cr0, [r1], {-0}
    120c:	00003809 	andeq	r3, r0, r9, lsl #16
    1210:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    1214:	00250f00 	eoreq	r0, r5, r0, lsl #30
    1218:	07430000 	strbeq	r0, [r3, -r0]
    121c:	5e100000 	cdppl	0, 1, cr0, cr0, cr0, {0}
    1220:	3f000000 	svccc	0x00000000
    1224:	0e072100 	adfeqs	f2, f7, f0
    1228:	98010000 	stmdals	r1, {}	; <UNPREDICTABLE>
    122c:	000ed90a 	andeq	sp, lr, sl, lsl #18
    1230:	00004d00 	andeq	r4, r0, r0, lsl #26
    1234:	0086b400 	addeq	fp, r6, r0, lsl #8
    1238:	00003c00 	andeq	r3, r0, r0, lsl #24
    123c:	809c0100 	addshi	r0, ip, r0, lsl #2
    1240:	22000007 	andcs	r0, r0, #7
    1244:	00716572 	rsbseq	r6, r1, r2, ror r5
    1248:	ab209a01 	blge	827a54 <__bss_end+0x81eaf0>
    124c:	02000003 	andeq	r0, r0, #3
    1250:	b81e7491 	ldmdalt	lr, {r0, r4, r7, sl, ip, sp, lr}
    1254:	0100000d 	tsteq	r0, sp
    1258:	004d0e9b 	umaaleq	r0, sp, fp, lr
    125c:	91020000 	mrsls	r0, (UNDEF: 2)
    1260:	2b230070 	blcs	8c1428 <__bss_end+0x8b84c4>
    1264:	0100000e 	tsteq	r0, lr
    1268:	0cbd068f 	ldceq	6, cr0, [sp], #572	; 0x23c
    126c:	86780000 	ldrbthi	r0, [r8], -r0
    1270:	003c0000 	eorseq	r0, ip, r0
    1274:	9c010000 	stcls	0, cr0, [r1], {-0}
    1278:	000007b9 			; <UNDEFINED> instruction: 0x000007b9
    127c:	000cff20 	andeq	pc, ip, r0, lsr #30
    1280:	218f0100 	orrcs	r0, pc, r0, lsl #2
    1284:	0000004d 	andeq	r0, r0, sp, asr #32
    1288:	226c9102 	rsbcs	r9, ip, #-2147483648	; 0x80000000
    128c:	00716572 	rsbseq	r6, r1, r2, ror r5
    1290:	ab209101 	blge	82569c <__bss_end+0x81c738>
    1294:	02000003 	andeq	r0, r0, #3
    1298:	21007491 			; <UNDEFINED> instruction: 0x21007491
    129c:	00000de4 	andeq	r0, r0, r4, ror #27
    12a0:	4d0a8301 	stcmi	3, cr8, [sl, #-4]
    12a4:	4d00000d 	stcmi	0, cr0, [r0, #-52]	; 0xffffffcc
    12a8:	3c000000 	stccc	0, cr0, [r0], {-0}
    12ac:	3c000086 	stccc	0, cr0, [r0], {134}	; 0x86
    12b0:	01000000 	mrseq	r0, (UNDEF: 0)
    12b4:	0007f69c 	muleq	r7, ip, r6
    12b8:	65722200 	ldrbvs	r2, [r2, #-512]!	; 0xfffffe00
    12bc:	85010071 	strhi	r0, [r1, #-113]	; 0xffffff8f
    12c0:	00038720 	andeq	r8, r3, r0, lsr #14
    12c4:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    12c8:	000c951e 	andeq	r9, ip, lr, lsl r5
    12cc:	0e860100 	rmfeqs	f0, f6, f0
    12d0:	0000004d 	andeq	r0, r0, sp, asr #32
    12d4:	00709102 	rsbseq	r9, r0, r2, lsl #2
    12d8:	00103921 	andseq	r3, r0, r1, lsr #18
    12dc:	0a770100 	beq	1dc16e4 <__bss_end+0x1db8780>
    12e0:	00000d13 	andeq	r0, r0, r3, lsl sp
    12e4:	0000004d 	andeq	r0, r0, sp, asr #32
    12e8:	00008600 	andeq	r8, r0, r0, lsl #12
    12ec:	0000003c 	andeq	r0, r0, ip, lsr r0
    12f0:	08339c01 	ldmdaeq	r3!, {r0, sl, fp, ip, pc}
    12f4:	72220000 	eorvc	r0, r2, #0
    12f8:	01007165 	tsteq	r0, r5, ror #2
    12fc:	03872079 	orreq	r2, r7, #121	; 0x79
    1300:	91020000 	mrsls	r0, (UNDEF: 2)
    1304:	0c951e74 	ldceq	14, cr1, [r5], {116}	; 0x74
    1308:	7a010000 	bvc	41310 <__bss_end+0x383ac>
    130c:	00004d0e 	andeq	r4, r0, lr, lsl #26
    1310:	70910200 	addsvc	r0, r1, r0, lsl #4
    1314:	0d612100 	stfeqe	f2, [r1, #-0]
    1318:	6b010000 	blvs	41320 <__bss_end+0x383bc>
    131c:	000ea406 	andeq	sl, lr, r6, lsl #8
    1320:	0001f000 	andeq	pc, r1, r0
    1324:	0085ac00 	addeq	sl, r5, r0, lsl #24
    1328:	00005400 	andeq	r5, r0, r0, lsl #8
    132c:	7f9c0100 	svcvc	0x009c0100
    1330:	20000008 	andcs	r0, r0, r8
    1334:	00000db8 			; <UNDEFINED> instruction: 0x00000db8
    1338:	4d156b01 	vldrmi	d6, [r5, #-4]
    133c:	02000000 	andeq	r0, r0, #0
    1340:	a9206c91 	stmdbge	r0!, {r0, r4, r7, sl, fp, sp, lr}
    1344:	01000006 	tsteq	r0, r6
    1348:	004d256b 	subeq	r2, sp, fp, ror #10
    134c:	91020000 	mrsls	r0, (UNDEF: 2)
    1350:	10311e68 	eorsne	r1, r1, r8, ror #28
    1354:	6d010000 	stcvs	0, cr0, [r1, #-0]
    1358:	00004d0e 	andeq	r4, r0, lr, lsl #26
    135c:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    1360:	0cd42100 	ldfeqe	f2, [r4], {0}
    1364:	5e010000 	cdppl	0, 0, cr0, cr1, cr0, {0}
    1368:	000f1012 	andeq	r1, pc, r2, lsl r0	; <UNPREDICTABLE>
    136c:	00008b00 	andeq	r8, r0, r0, lsl #22
    1370:	00855c00 	addeq	r5, r5, r0, lsl #24
    1374:	00005000 	andeq	r5, r0, r0
    1378:	da9c0100 	ble	fe701780 <__bss_end+0xfe6f881c>
    137c:	20000008 	andcs	r0, r0, r8
    1380:	00000eaf 	andeq	r0, r0, pc, lsr #29
    1384:	4d205e01 	stcmi	14, cr5, [r0, #-4]!
    1388:	02000000 	andeq	r0, r0, #0
    138c:	ed206c91 	stc	12, cr6, [r0, #-580]!	; 0xfffffdbc
    1390:	0100000d 	tsteq	r0, sp
    1394:	004d2f5e 	subeq	r2, sp, lr, asr pc
    1398:	91020000 	mrsls	r0, (UNDEF: 2)
    139c:	06a92068 	strteq	r2, [r9], r8, rrx
    13a0:	5e010000 	cdppl	0, 0, cr0, cr1, cr0, {0}
    13a4:	00004d3f 	andeq	r4, r0, pc, lsr sp
    13a8:	64910200 	ldrvs	r0, [r1], #512	; 0x200
    13ac:	0010311e 	andseq	r3, r0, lr, lsl r1
    13b0:	16600100 	strbtne	r0, [r0], -r0, lsl #2
    13b4:	0000008b 	andeq	r0, r0, fp, lsl #1
    13b8:	00749102 	rsbseq	r9, r4, r2, lsl #2
    13bc:	000f4621 	andeq	r4, pc, r1, lsr #12
    13c0:	0a520100 	beq	14817c8 <__bss_end+0x1478864>
    13c4:	00000cd9 	ldrdeq	r0, [r0], -r9
    13c8:	0000004d 	andeq	r0, r0, sp, asr #32
    13cc:	00008518 	andeq	r8, r0, r8, lsl r5
    13d0:	00000044 	andeq	r0, r0, r4, asr #32
    13d4:	09269c01 	stmdbeq	r6!, {r0, sl, fp, ip, pc}
    13d8:	af200000 	svcge	0x00200000
    13dc:	0100000e 	tsteq	r0, lr
    13e0:	004d1a52 	subeq	r1, sp, r2, asr sl
    13e4:	91020000 	mrsls	r0, (UNDEF: 2)
    13e8:	0ded206c 	stcleq	0, cr2, [sp, #432]!	; 0x1b0
    13ec:	52010000 	andpl	r0, r1, #0
    13f0:	00004d29 	andeq	r4, r0, r9, lsr #26
    13f4:	68910200 	ldmvs	r1, {r9}
    13f8:	000f3f1e 	andeq	r3, pc, lr, lsl pc	; <UNPREDICTABLE>
    13fc:	0e540100 	rdfeqs	f0, f4, f0
    1400:	0000004d 	andeq	r0, r0, sp, asr #32
    1404:	00749102 	rsbseq	r9, r4, r2, lsl #2
    1408:	000f3921 	andeq	r3, pc, r1, lsr #18
    140c:	0a450100 	beq	1141814 <__bss_end+0x11388b0>
    1410:	00000f1b 	andeq	r0, r0, fp, lsl pc
    1414:	0000004d 	andeq	r0, r0, sp, asr #32
    1418:	000084c8 	andeq	r8, r0, r8, asr #9
    141c:	00000050 	andeq	r0, r0, r0, asr r0
    1420:	09819c01 	stmibeq	r1, {r0, sl, fp, ip, pc}
    1424:	af200000 	svcge	0x00200000
    1428:	0100000e 	tsteq	r0, lr
    142c:	004d1945 	subeq	r1, sp, r5, asr #18
    1430:	91020000 	mrsls	r0, (UNDEF: 2)
    1434:	0d8d206c 	stceq	0, cr2, [sp, #432]	; 0x1b0
    1438:	45010000 	strmi	r0, [r1, #-0]
    143c:	00011d30 	andeq	r1, r1, r0, lsr sp
    1440:	68910200 	ldmvs	r1, {r9}
    1444:	000df320 	andeq	pc, sp, r0, lsr #6
    1448:	41450100 	mrsmi	r0, (UNDEF: 85)
    144c:	000006ac 	andeq	r0, r0, ip, lsr #13
    1450:	1e649102 	lgnnes	f1, f2
    1454:	00001031 	andeq	r1, r0, r1, lsr r0
    1458:	4d0e4701 	stcmi	7, cr4, [lr, #-4]
    145c:	02000000 	andeq	r0, r0, #0
    1460:	23007491 	movwcs	r7, #1169	; 0x491
    1464:	00000c82 	andeq	r0, r0, r2, lsl #25
    1468:	97063f01 	strls	r3, [r6, -r1, lsl #30]
    146c:	9c00000d 	stcls	0, cr0, [r0], {13}
    1470:	2c000084 	stccs	0, cr0, [r0], {132}	; 0x84
    1474:	01000000 	mrseq	r0, (UNDEF: 0)
    1478:	0009ab9c 	muleq	r9, ip, fp
    147c:	0eaf2000 	cdpeq	0, 10, cr2, cr15, cr0, {0}
    1480:	3f010000 	svccc	0x00010000
    1484:	00004d15 	andeq	r4, r0, r5, lsl sp
    1488:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    148c:	0db22100 	ldfeqs	f2, [r2]
    1490:	32010000 	andcc	r0, r1, #0
    1494:	000df90a 	andeq	pc, sp, sl, lsl #18
    1498:	00004d00 	andeq	r4, r0, r0, lsl #26
    149c:	00844c00 	addeq	r4, r4, r0, lsl #24
    14a0:	00005000 	andeq	r5, r0, r0
    14a4:	069c0100 	ldreq	r0, [ip], r0, lsl #2
    14a8:	2000000a 	andcs	r0, r0, sl
    14ac:	00000eaf 	andeq	r0, r0, pc, lsr #29
    14b0:	4d193201 	lfmmi	f3, 4, [r9, #-4]
    14b4:	02000000 	andeq	r0, r0, #0
    14b8:	5c206c91 	stcpl	12, cr6, [r0], #-580	; 0xfffffdbc
    14bc:	0100000f 	tsteq	r0, pc
    14c0:	01f72b32 	mvnseq	r2, r2, lsr fp
    14c4:	91020000 	mrsls	r0, (UNDEF: 2)
    14c8:	0e262068 	cdpeq	0, 2, cr2, cr6, cr8, {3}
    14cc:	32010000 	andcc	r0, r1, #0
    14d0:	00004d3c 	andeq	r4, r0, ip, lsr sp
    14d4:	64910200 	ldrvs	r0, [r1], #512	; 0x200
    14d8:	000f0a1e 	andeq	r0, pc, lr, lsl sl	; <UNPREDICTABLE>
    14dc:	0e340100 	rsfeqs	f0, f4, f0
    14e0:	0000004d 	andeq	r0, r0, sp, asr #32
    14e4:	00749102 	rsbseq	r9, r4, r2, lsl #2
    14e8:	00105b21 	andseq	r5, r0, r1, lsr #22
    14ec:	0a250100 	beq	9418f4 <__bss_end+0x938990>
    14f0:	00000f63 	andeq	r0, r0, r3, ror #30
    14f4:	0000004d 	andeq	r0, r0, sp, asr #32
    14f8:	000083fc 	strdeq	r8, [r0], -ip
    14fc:	00000050 	andeq	r0, r0, r0, asr r0
    1500:	0a619c01 	beq	186850c <__bss_end+0x185f5a8>
    1504:	af200000 	svcge	0x00200000
    1508:	0100000e 	tsteq	r0, lr
    150c:	004d1825 	subeq	r1, sp, r5, lsr #16
    1510:	91020000 	mrsls	r0, (UNDEF: 2)
    1514:	0f5c206c 	svceq	0x005c206c
    1518:	25010000 	strcs	r0, [r1, #-0]
    151c:	000a672a 	andeq	r6, sl, sl, lsr #14
    1520:	68910200 	ldmvs	r1, {r9}
    1524:	000e2620 	andeq	r2, lr, r0, lsr #12
    1528:	3b250100 	blcc	941930 <__bss_end+0x9389cc>
    152c:	0000004d 	andeq	r0, r0, sp, asr #32
    1530:	1e649102 	lgnnes	f1, f2
    1534:	00000ca6 	andeq	r0, r0, r6, lsr #25
    1538:	4d0e2701 	stcmi	7, cr2, [lr, #-4]
    153c:	02000000 	andeq	r0, r0, #0
    1540:	0d007491 	cfstrseq	mvf7, [r0, #-580]	; 0xfffffdbc
    1544:	00002504 	andeq	r2, r0, r4, lsl #10
    1548:	0a610300 	beq	1842150 <__bss_end+0x18391ec>
    154c:	be210000 	cdplt	0, 2, cr0, cr1, cr0, {0}
    1550:	0100000d 	tsteq	r0, sp
    1554:	10670a19 	rsbne	r0, r7, r9, lsl sl
    1558:	004d0000 	subeq	r0, sp, r0
    155c:	83b80000 			; <UNDEFINED> instruction: 0x83b80000
    1560:	00440000 	subeq	r0, r4, r0
    1564:	9c010000 	stcls	0, cr0, [r1], {-0}
    1568:	00000ab8 			; <UNDEFINED> instruction: 0x00000ab8
    156c:	00105220 	andseq	r5, r0, r0, lsr #4
    1570:	1b190100 	blne	641978 <__bss_end+0x638a14>
    1574:	000001f7 	strdeq	r0, [r0], -r7
    1578:	206c9102 	rsbcs	r9, ip, r2, lsl #2
    157c:	00000f57 	andeq	r0, r0, r7, asr pc
    1580:	c6351901 	ldrtgt	r1, [r5], -r1, lsl #18
    1584:	02000001 	andeq	r0, r0, #1
    1588:	af1e6891 	svcge	0x001e6891
    158c:	0100000e 	tsteq	r0, lr
    1590:	004d0e1b 	subeq	r0, sp, fp, lsl lr
    1594:	91020000 	mrsls	r0, (UNDEF: 2)
    1598:	f3240074 	vqadd.u32	q0, q2, q10
    159c:	0100000c 	tsteq	r0, ip
    15a0:	0cac0614 	stceq	6, cr0, [ip], #80	; 0x50
    15a4:	839c0000 	orrshi	r0, ip, #0
    15a8:	001c0000 	andseq	r0, ip, r0
    15ac:	9c010000 	stcls	0, cr0, [r1], {-0}
    15b0:	000f4d23 	andeq	r4, pc, r3, lsr #26
    15b4:	060e0100 	streq	r0, [lr], -r0, lsl #2
    15b8:	00000d7f 	andeq	r0, r0, pc, ror sp
    15bc:	00008370 	andeq	r8, r0, r0, ror r3
    15c0:	0000002c 	andeq	r0, r0, ip, lsr #32
    15c4:	0af89c01 	beq	ffe285d0 <__bss_end+0xffe1f66c>
    15c8:	ea200000 	b	8015d0 <__bss_end+0x7f866c>
    15cc:	0100000c 	tsteq	r0, ip
    15d0:	0038140e 	eorseq	r1, r8, lr, lsl #8
    15d4:	91020000 	mrsls	r0, (UNDEF: 2)
    15d8:	60250074 	eorvs	r0, r5, r4, ror r0
    15dc:	01000010 	tsteq	r0, r0, lsl r0
    15e0:	0da10a04 			; <UNDEFINED> instruction: 0x0da10a04
    15e4:	004d0000 	subeq	r0, sp, r0
    15e8:	83440000 	movthi	r0, #16384	; 0x4000
    15ec:	002c0000 	eoreq	r0, ip, r0
    15f0:	9c010000 	stcls	0, cr0, [r1], {-0}
    15f4:	64697022 	strbtvs	r7, [r9], #-34	; 0xffffffde
    15f8:	0e060100 	adfeqs	f0, f6, f0
    15fc:	0000004d 	andeq	r0, r0, sp, asr #32
    1600:	00749102 	rsbseq	r9, r4, r2, lsl #2
    1604:	00032e00 	andeq	r2, r3, r0, lsl #28
    1608:	9c000400 	cfstrsls	mvf0, [r0], {-0}
    160c:	04000006 	streq	r0, [r0], #-6
    1610:	000f6f01 	andeq	r6, pc, r1, lsl #30
    1614:	10a70400 	adcne	r0, r7, r0, lsl #8
    1618:	0c370000 	ldceq	0, cr0, [r7], #-0
    161c:	87a00000 	strhi	r0, [r0, r0]!
    1620:	04b80000 	ldrteq	r0, [r8], #0
    1624:	08060000 	stmdaeq	r6, {}	; <UNPREDICTABLE>
    1628:	49020000 	stmdbmi	r2, {}	; <UNPREDICTABLE>
    162c:	03000000 	movweq	r0, #0
    1630:	00001110 	andeq	r1, r0, r0, lsl r1
    1634:	61100501 	tstvs	r0, r1, lsl #10
    1638:	11000000 	mrsne	r0, (UNDEF: 0)
    163c:	33323130 	teqcc	r2, #48, 2
    1640:	37363534 			; <UNDEFINED> instruction: 0x37363534
    1644:	42413938 	submi	r3, r1, #56, 18	; 0xe0000
    1648:	46454443 	strbmi	r4, [r5], -r3, asr #8
    164c:	01040000 	mrseq	r0, (UNDEF: 4)
    1650:	00250103 	eoreq	r0, r5, r3, lsl #2
    1654:	74050000 	strvc	r0, [r5], #-0
    1658:	61000000 	mrsvs	r0, (UNDEF: 0)
    165c:	06000000 	streq	r0, [r0], -r0
    1660:	00000066 	andeq	r0, r0, r6, rrx
    1664:	51070010 	tstpl	r7, r0, lsl r0
    1668:	08000000 	stmdaeq	r0, {}	; <UNPREDICTABLE>
    166c:	07470704 	strbeq	r0, [r7, -r4, lsl #14]
    1670:	01080000 	mrseq	r0, (UNDEF: 8)
    1674:	00099508 	andeq	r9, r9, r8, lsl #10
    1678:	006d0700 	rsbeq	r0, sp, r0, lsl #14
    167c:	2a090000 	bcs	241684 <__bss_end+0x238720>
    1680:	0a000000 	beq	1688 <shift+0x1688>
    1684:	0000113f 	andeq	r1, r0, pc, lsr r1
    1688:	2a066401 	bcs	19a694 <__bss_end+0x191730>
    168c:	d8000011 	stmdale	r0, {r0, r4}
    1690:	8000008b 	andhi	r0, r0, fp, lsl #1
    1694:	01000000 	mrseq	r0, (UNDEF: 0)
    1698:	0000fb9c 	muleq	r0, ip, fp
    169c:	72730b00 	rsbsvc	r0, r3, #0, 22
    16a0:	64010063 	strvs	r0, [r1], #-99	; 0xffffff9d
    16a4:	0000fb19 	andeq	pc, r0, r9, lsl fp	; <UNPREDICTABLE>
    16a8:	64910200 	ldrvs	r0, [r1], #512	; 0x200
    16ac:	7473640b 	ldrbtvc	r6, [r3], #-1035	; 0xfffffbf5
    16b0:	24640100 	strbtcs	r0, [r4], #-256	; 0xffffff00
    16b4:	00000102 	andeq	r0, r0, r2, lsl #2
    16b8:	0b609102 	bleq	1825ac8 <__bss_end+0x181cb64>
    16bc:	006d756e 	rsbeq	r7, sp, lr, ror #10
    16c0:	042d6401 	strteq	r6, [sp], #-1025	; 0xfffffbff
    16c4:	02000001 	andeq	r0, r0, #1
    16c8:	990c5c91 	stmdbls	ip, {r0, r4, r7, sl, fp, ip, lr}
    16cc:	01000011 	tsteq	r0, r1, lsl r0
    16d0:	010b0e66 	tsteq	fp, r6, ror #28
    16d4:	91020000 	mrsls	r0, (UNDEF: 2)
    16d8:	111c0c70 	tstne	ip, r0, ror ip
    16dc:	67010000 	strvs	r0, [r1, -r0]
    16e0:	00011108 	andeq	r1, r1, r8, lsl #2
    16e4:	6c910200 	lfmvs	f0, 4, [r1], {0}
    16e8:	008c000d 	addeq	r0, ip, sp
    16ec:	00004800 	andeq	r4, r0, r0, lsl #16
    16f0:	00690e00 	rsbeq	r0, r9, r0, lsl #28
    16f4:	040b6901 	streq	r6, [fp], #-2305	; 0xfffff6ff
    16f8:	02000001 	andeq	r0, r0, #1
    16fc:	00007491 	muleq	r0, r1, r4
    1700:	0101040f 	tsteq	r1, pc, lsl #8
    1704:	11100000 	tstne	r0, r0
    1708:	05041204 	streq	r1, [r4, #-516]	; 0xfffffdfc
    170c:	00746e69 	rsbseq	r6, r4, r9, ror #28
    1710:	0074040f 	rsbseq	r0, r4, pc, lsl #8
    1714:	040f0000 	streq	r0, [pc], #-0	; 171c <shift+0x171c>
    1718:	0000006d 	andeq	r0, r0, sp, rrx
    171c:	00108e0a 	andseq	r8, r0, sl, lsl #28
    1720:	065c0100 	ldrbeq	r0, [ip], -r0, lsl #2
    1724:	0000109b 	muleq	r0, fp, r0
    1728:	00008b70 	andeq	r8, r0, r0, ror fp
    172c:	00000068 	andeq	r0, r0, r8, rrx
    1730:	01769c01 	cmneq	r6, r1, lsl #24
    1734:	92130000 	andsls	r0, r3, #0
    1738:	01000011 	tsteq	r0, r1, lsl r0
    173c:	0102125c 	tsteq	r2, ip, asr r2
    1740:	91020000 	mrsls	r0, (UNDEF: 2)
    1744:	1094136c 	addsne	r1, r4, ip, ror #6
    1748:	5c010000 	stcpl	0, cr0, [r1], {-0}
    174c:	0001041e 	andeq	r0, r1, lr, lsl r4
    1750:	68910200 	ldmvs	r1, {r9}
    1754:	6d656d0e 	stclvs	13, cr6, [r5, #-56]!	; 0xffffffc8
    1758:	085e0100 	ldmdaeq	lr, {r8}^
    175c:	00000111 	andeq	r0, r0, r1, lsl r1
    1760:	0d709102 	ldfeqp	f1, [r0, #-8]!
    1764:	00008b8c 	andeq	r8, r0, ip, lsl #23
    1768:	0000003c 	andeq	r0, r0, ip, lsr r0
    176c:	0100690e 	tsteq	r0, lr, lsl #18
    1770:	01040b60 	tsteq	r4, r0, ror #22
    1774:	91020000 	mrsls	r0, (UNDEF: 2)
    1778:	14000074 	strne	r0, [r0], #-116	; 0xffffff8c
    177c:	00001146 	andeq	r1, r0, r6, asr #2
    1780:	5f055201 	svcpl	0x00055201
    1784:	04000011 	streq	r0, [r0], #-17	; 0xffffffef
    1788:	1c000001 	stcne	0, cr0, [r0], {1}
    178c:	5400008b 	strpl	r0, [r0], #-139	; 0xffffff75
    1790:	01000000 	mrseq	r0, (UNDEF: 0)
    1794:	0001af9c 	muleq	r1, ip, pc	; <UNPREDICTABLE>
    1798:	00730b00 	rsbseq	r0, r3, r0, lsl #22
    179c:	0b185201 	bleq	615fa8 <__bss_end+0x60d044>
    17a0:	02000001 	andeq	r0, r0, #1
    17a4:	690e6c91 	stmdbvs	lr, {r0, r4, r7, sl, fp, sp, lr}
    17a8:	06540100 	ldrbeq	r0, [r4], -r0, lsl #2
    17ac:	00000104 	andeq	r0, r0, r4, lsl #2
    17b0:	00749102 	rsbseq	r9, r4, r2, lsl #2
    17b4:	00118214 	andseq	r8, r1, r4, lsl r2
    17b8:	05420100 	strbeq	r0, [r2, #-256]	; 0xffffff00
    17bc:	0000114d 	andeq	r1, r0, sp, asr #2
    17c0:	00000104 	andeq	r0, r0, r4, lsl #2
    17c4:	00008a70 	andeq	r8, r0, r0, ror sl
    17c8:	000000ac 	andeq	r0, r0, ip, lsr #1
    17cc:	02159c01 	andseq	r9, r5, #256	; 0x100
    17d0:	730b0000 	movwvc	r0, #45056	; 0xb000
    17d4:	42010031 	andmi	r0, r1, #49	; 0x31
    17d8:	00010b19 	andeq	r0, r1, r9, lsl fp
    17dc:	6c910200 	lfmvs	f0, 4, [r1], {0}
    17e0:	0032730b 	eorseq	r7, r2, fp, lsl #6
    17e4:	0b294201 	bleq	a51ff0 <__bss_end+0xa4908c>
    17e8:	02000001 	andeq	r0, r0, #1
    17ec:	6e0b6891 	mcrvs	8, 0, r6, cr11, cr1, {4}
    17f0:	01006d75 	tsteq	r0, r5, ror sp
    17f4:	01043142 	tsteq	r4, r2, asr #2
    17f8:	91020000 	mrsls	r0, (UNDEF: 2)
    17fc:	31750e64 	cmncc	r5, r4, ror #28
    1800:	10440100 	subne	r0, r4, r0, lsl #2
    1804:	00000215 	andeq	r0, r0, r5, lsl r2
    1808:	0e779102 	expeqs	f1, f2
    180c:	01003275 	tsteq	r0, r5, ror r2
    1810:	02151444 	andseq	r1, r5, #68, 8	; 0x44000000
    1814:	91020000 	mrsls	r0, (UNDEF: 2)
    1818:	01080076 	tsteq	r8, r6, ror r0
    181c:	00098c08 	andeq	r8, r9, r8, lsl #24
    1820:	118a1400 	orrne	r1, sl, r0, lsl #8
    1824:	36010000 	strcc	r0, [r1], -r0
    1828:	00117107 	andseq	r7, r1, r7, lsl #2
    182c:	00011100 	andeq	r1, r1, r0, lsl #2
    1830:	0089b000 	addeq	fp, r9, r0
    1834:	0000c000 	andeq	ip, r0, r0
    1838:	759c0100 	ldrvc	r0, [ip, #256]	; 0x100
    183c:	13000002 	movwne	r0, #2
    1840:	00001089 	andeq	r1, r0, r9, lsl #1
    1844:	11153601 	tstne	r5, r1, lsl #12
    1848:	02000001 	andeq	r0, r0, #1
    184c:	730b6c91 	movwvc	r6, #48273	; 0xbc91
    1850:	01006372 	tsteq	r0, r2, ror r3
    1854:	010b2736 	tsteq	fp, r6, lsr r7
    1858:	91020000 	mrsls	r0, (UNDEF: 2)
    185c:	756e0b68 	strbvc	r0, [lr, #-2920]!	; 0xfffff498
    1860:	3601006d 	strcc	r0, [r1], -sp, rrx
    1864:	00010430 	andeq	r0, r1, r0, lsr r4
    1868:	64910200 	ldrvs	r0, [r1], #512	; 0x200
    186c:	0100690e 	tsteq	r0, lr, lsl #18
    1870:	01040638 	tsteq	r4, r8, lsr r6
    1874:	91020000 	mrsls	r0, (UNDEF: 2)
    1878:	6c140074 	ldcvs	0, cr0, [r4], {116}	; 0x74
    187c:	01000011 	tsteq	r0, r1, lsl r0
    1880:	11050524 	tstne	r5, r4, lsr #10
    1884:	01040000 	mrseq	r0, (UNDEF: 4)
    1888:	89140000 	ldmdbhi	r4, {}	; <UNPREDICTABLE>
    188c:	009c0000 	addseq	r0, ip, r0
    1890:	9c010000 	stcls	0, cr0, [r1], {-0}
    1894:	000002b2 			; <UNDEFINED> instruction: 0x000002b2
    1898:	00108313 	andseq	r8, r0, r3, lsl r3
    189c:	16240100 	strtne	r0, [r4], -r0, lsl #2
    18a0:	0000010b 	andeq	r0, r0, fp, lsl #2
    18a4:	0c6c9102 	stfeqp	f1, [ip], #-8
    18a8:	00001123 	andeq	r1, r0, r3, lsr #2
    18ac:	04062601 	streq	r2, [r6], #-1537	; 0xfffff9ff
    18b0:	02000001 	andeq	r0, r0, #1
    18b4:	15007491 	strne	r7, [r0, #-1169]	; 0xfffffb6f
    18b8:	000011a0 	andeq	r1, r0, r0, lsr #3
    18bc:	a5060801 	strge	r0, [r6, #-2049]	; 0xfffff7ff
    18c0:	a0000011 	andge	r0, r0, r1, lsl r0
    18c4:	74000087 	strvc	r0, [r0], #-135	; 0xffffff79
    18c8:	01000001 	tsteq	r0, r1
    18cc:	1083139c 	umullne	r1, r3, ip, r3
    18d0:	08010000 	stmdaeq	r1, {}	; <UNPREDICTABLE>
    18d4:	00006618 	andeq	r6, r0, r8, lsl r6
    18d8:	64910200 	ldrvs	r0, [r1], #512	; 0x200
    18dc:	00112313 	andseq	r2, r1, r3, lsl r3
    18e0:	25080100 	strcs	r0, [r8, #-256]	; 0xffffff00
    18e4:	00000111 	andeq	r0, r0, r1, lsl r1
    18e8:	13609102 	cmnne	r0, #-2147483648	; 0x80000000
    18ec:	0000113a 	andeq	r1, r0, sl, lsr r1
    18f0:	663a0801 	ldrtvs	r0, [sl], -r1, lsl #16
    18f4:	02000000 	andeq	r0, r0, #0
    18f8:	690e5c91 	stmdbvs	lr, {r0, r4, r7, sl, fp, ip, lr}
    18fc:	060a0100 	streq	r0, [sl], -r0, lsl #2
    1900:	00000104 	andeq	r0, r0, r4, lsl #2
    1904:	0d749102 	ldfeqp	f1, [r4, #-8]!
    1908:	0000886c 	andeq	r8, r0, ip, ror #16
    190c:	00000098 	muleq	r0, r8, r0
    1910:	01006a0e 	tsteq	r0, lr, lsl #20
    1914:	01040b1c 	tsteq	r4, ip, lsl fp
    1918:	91020000 	mrsls	r0, (UNDEF: 2)
    191c:	88940d70 	ldmhi	r4, {r4, r5, r6, r8, sl, fp}
    1920:	00600000 	rsbeq	r0, r0, r0
    1924:	630e0000 	movwvs	r0, #57344	; 0xe000
    1928:	081e0100 	ldmdaeq	lr, {r8}
    192c:	0000006d 	andeq	r0, r0, sp, rrx
    1930:	006f9102 	rsbeq	r9, pc, r2, lsl #2
    1934:	Address 0x0000000000001934 is out of bounds.


Disassembly of section .debug_abbrev:

00000000 <.debug_abbrev>:
   0:	10001101 	andne	r1, r0, r1, lsl #2
   4:	12011106 	andne	r1, r1, #-2147483647	; 0x80000001
   8:	1b0e0301 	blne	380c14 <__bss_end+0x377cb0>
   c:	130e250e 	movwne	r2, #58638	; 0xe50e
  10:	00000005 	andeq	r0, r0, r5
  14:	25011101 	strcs	r1, [r1, #-257]	; 0xfffffeff
  18:	030b130e 	movweq	r1, #45838	; 0xb30e
  1c:	110e1b0e 	tstne	lr, lr, lsl #22
  20:	10061201 	andne	r1, r6, r1, lsl #4
  24:	02000017 	andeq	r0, r0, #23
  28:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
  2c:	0b3b0b3a 	bleq	ec2d1c <__bss_end+0xeb9db8>
  30:	13490b39 	movtne	r0, #39737	; 0x9b39
  34:	193c193f 	ldmdbne	ip!, {r0, r1, r2, r3, r4, r5, r8, fp, ip}
  38:	24030000 	strcs	r0, [r3], #-0
  3c:	3e0b0b00 	vmlacc.f64	d0, d11, d0
  40:	000e030b 	andeq	r0, lr, fp, lsl #6
  44:	012e0400 			; <UNDEFINED> instruction: 0x012e0400
  48:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
  4c:	0b3b0b3a 	bleq	ec2d3c <__bss_end+0xeb9dd8>
  50:	01110b39 	tsteq	r1, r9, lsr fp
  54:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
  58:	01194296 			; <UNDEFINED> instruction: 0x01194296
  5c:	05000013 	streq	r0, [r0, #-19]	; 0xffffffed
  60:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
  64:	0b3b0b3a 	bleq	ec2d54 <__bss_end+0xeb9df0>
  68:	13490b39 	movtne	r0, #39737	; 0x9b39
  6c:	00001802 	andeq	r1, r0, r2, lsl #16
  70:	0b002406 	bleq	9090 <__bss_end+0x12c>
  74:	030b3e0b 	movweq	r3, #48651	; 0xbe0b
  78:	07000008 	streq	r0, [r0, -r8]
  7c:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
  80:	0b3a0e03 	bleq	e83894 <__bss_end+0xe7a930>
  84:	0b390b3b 	bleq	e42d78 <__bss_end+0xe39e14>
  88:	06120111 			; <UNDEFINED> instruction: 0x06120111
  8c:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
  90:	00130119 	andseq	r0, r3, r9, lsl r1
  94:	010b0800 	tsteq	fp, r0, lsl #16
  98:	06120111 			; <UNDEFINED> instruction: 0x06120111
  9c:	34090000 	strcc	r0, [r9], #-0
  a0:	3a080300 	bcc	200ca8 <__bss_end+0x1f7d44>
  a4:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
  a8:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
  ac:	0a000018 	beq	114 <shift+0x114>
  b0:	0b0b000f 	bleq	2c00f4 <__bss_end+0x2b7190>
  b4:	00001349 	andeq	r1, r0, r9, asr #6
  b8:	01110100 	tsteq	r1, r0, lsl #2
  bc:	0b130e25 	bleq	4c3958 <__bss_end+0x4ba9f4>
  c0:	0e1b0e03 	cdpeq	14, 1, cr0, cr11, cr3, {0}
  c4:	06120111 			; <UNDEFINED> instruction: 0x06120111
  c8:	00001710 	andeq	r1, r0, r0, lsl r7
  cc:	03001602 	movweq	r1, #1538	; 0x602
  d0:	3b0b3a0e 	blcc	2ce910 <__bss_end+0x2c59ac>
  d4:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
  d8:	03000013 	movweq	r0, #19
  dc:	0b0b000f 	bleq	2c0120 <__bss_end+0x2b71bc>
  e0:	00001349 	andeq	r1, r0, r9, asr #6
  e4:	00001504 	andeq	r1, r0, r4, lsl #10
  e8:	01010500 	tsteq	r1, r0, lsl #10
  ec:	13011349 	movwne	r1, #4937	; 0x1349
  f0:	21060000 	mrscs	r0, (UNDEF: 6)
  f4:	2f134900 	svccs	0x00134900
  f8:	07000006 	streq	r0, [r0, -r6]
  fc:	0b0b0024 	bleq	2c0194 <__bss_end+0x2b7230>
 100:	0e030b3e 	vmoveq.16	d3[0], r0
 104:	34080000 	strcc	r0, [r8], #-0
 108:	3a0e0300 	bcc	380d10 <__bss_end+0x377dac>
 10c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 110:	3f13490b 	svccc	0x0013490b
 114:	00193c19 	andseq	r3, r9, r9, lsl ip
 118:	012e0900 			; <UNDEFINED> instruction: 0x012e0900
 11c:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 120:	0b3b0b3a 	bleq	ec2e10 <__bss_end+0xeb9eac>
 124:	13490b39 	movtne	r0, #39737	; 0x9b39
 128:	06120111 			; <UNDEFINED> instruction: 0x06120111
 12c:	42961840 	addsmi	r1, r6, #64, 16	; 0x400000
 130:	00130119 	andseq	r0, r3, r9, lsl r1
 134:	00340a00 	eorseq	r0, r4, r0, lsl #20
 138:	0b3a0e03 	bleq	e8394c <__bss_end+0xe7a9e8>
 13c:	0b390b3b 	bleq	e42e30 <__bss_end+0xe39ecc>
 140:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 144:	240b0000 	strcs	r0, [fp], #-0
 148:	3e0b0b00 	vmlacc.f64	d0, d11, d0
 14c:	0008030b 	andeq	r0, r8, fp, lsl #6
 150:	002e0c00 	eoreq	r0, lr, r0, lsl #24
 154:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 158:	0b3b0b3a 	bleq	ec2e48 <__bss_end+0xeb9ee4>
 15c:	01110b39 	tsteq	r1, r9, lsr fp
 160:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 164:	00194297 	mulseq	r9, r7, r2
 168:	01390d00 	teqeq	r9, r0, lsl #26
 16c:	0b3a0e03 	bleq	e83980 <__bss_end+0xe7aa1c>
 170:	13010b3b 	movwne	r0, #6971	; 0x1b3b
 174:	2e0e0000 	cdpcs	0, 0, cr0, cr14, cr0, {0}
 178:	03193f01 	tsteq	r9, #1, 30
 17c:	3b0b3a0e 	blcc	2ce9bc <__bss_end+0x2c5a58>
 180:	3c0b390b 			; <UNDEFINED> instruction: 0x3c0b390b
 184:	00130119 	andseq	r0, r3, r9, lsl r1
 188:	00050f00 	andeq	r0, r5, r0, lsl #30
 18c:	00001349 	andeq	r1, r0, r9, asr #6
 190:	3f012e10 	svccc	0x00012e10
 194:	3a0e0319 	bcc	380e00 <__bss_end+0x377e9c>
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
 1c0:	3a080300 	bcc	200dc8 <__bss_end+0x1f7e64>
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
 1f4:	0b0b0024 	bleq	2c028c <__bss_end+0x2b7328>
 1f8:	0e030b3e 	vmoveq.16	d3[0], r0
 1fc:	24030000 	strcs	r0, [r3], #-0
 200:	3e0b0b00 	vmlacc.f64	d0, d11, d0
 204:	0008030b 	andeq	r0, r8, fp, lsl #6
 208:	00160400 	andseq	r0, r6, r0, lsl #8
 20c:	0b3a0e03 	bleq	e83a20 <__bss_end+0xe7aabc>
 210:	0b390b3b 	bleq	e42f04 <__bss_end+0xe39fa0>
 214:	00001349 	andeq	r1, r0, r9, asr #6
 218:	49002605 	stmdbmi	r0, {r0, r2, r9, sl, sp}
 21c:	06000013 			; <UNDEFINED> instruction: 0x06000013
 220:	0e030113 	mcreq	1, 0, r0, cr3, cr3, {0}
 224:	0b3a0b0b 	bleq	e82e58 <__bss_end+0xe79ef4>
 228:	0b390b3b 	bleq	e42f1c <__bss_end+0xe39fb8>
 22c:	00001301 	andeq	r1, r0, r1, lsl #6
 230:	03000d07 	movweq	r0, #3335	; 0xd07
 234:	3b0b3a08 	blcc	2cea5c <__bss_end+0x2c5af8>
 238:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 23c:	000b3813 	andeq	r3, fp, r3, lsl r8
 240:	01040800 	tsteq	r4, r0, lsl #16
 244:	196d0e03 	stmdbne	sp!, {r0, r1, r9, sl, fp}^
 248:	0b0b0b3e 	bleq	2c2f48 <__bss_end+0x2b9fe4>
 24c:	0b3a1349 	bleq	e84f78 <__bss_end+0xe7c014>
 250:	0b390b3b 	bleq	e42f44 <__bss_end+0xe39fe0>
 254:	00001301 	andeq	r1, r0, r1, lsl #6
 258:	03002809 	movweq	r2, #2057	; 0x809
 25c:	000b1c0e 	andeq	r1, fp, lr, lsl #24
 260:	00340a00 	eorseq	r0, r4, r0, lsl #20
 264:	0b3a0e03 	bleq	e83a78 <__bss_end+0xe7ab14>
 268:	0b390b3b 	bleq	e42f5c <__bss_end+0xe39ff8>
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
 294:	0b3b0b3a 	bleq	ec2f84 <__bss_end+0xeba020>
 298:	13490b39 	movtne	r0, #39737	; 0x9b39
 29c:	00000b38 	andeq	r0, r0, r8, lsr fp
 2a0:	4901010f 	stmdbmi	r1, {r0, r1, r2, r3, r8}
 2a4:	00130113 	andseq	r0, r3, r3, lsl r1
 2a8:	00211000 	eoreq	r1, r1, r0
 2ac:	0b2f1349 	bleq	bc4fd8 <__bss_end+0xbbc074>
 2b0:	02110000 	andseq	r0, r1, #0
 2b4:	0b0e0301 	bleq	380ec0 <__bss_end+0x377f5c>
 2b8:	3b0b3a0b 	blcc	2ceaec <__bss_end+0x2c5b88>
 2bc:	010b390b 	tsteq	fp, fp, lsl #18
 2c0:	12000013 	andne	r0, r0, #19
 2c4:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 2c8:	0b3a0e03 	bleq	e83adc <__bss_end+0xe7ab78>
 2cc:	0b390b3b 	bleq	e42fc0 <__bss_end+0xe3a05c>
 2d0:	193c0e6e 	ldmdbne	ip!, {r1, r2, r3, r5, r6, r9, sl, fp}
 2d4:	13011364 	movwne	r1, #4964	; 0x1364
 2d8:	05130000 	ldreq	r0, [r3, #-0]
 2dc:	34134900 	ldrcc	r4, [r3], #-2304	; 0xfffff700
 2e0:	14000019 	strne	r0, [r0], #-25	; 0xffffffe7
 2e4:	13490005 	movtne	r0, #36869	; 0x9005
 2e8:	2e150000 	cdpcs	0, 1, cr0, cr5, cr0, {0}
 2ec:	03193f01 	tsteq	r9, #1, 30
 2f0:	3b0b3a0e 	blcc	2ceb30 <__bss_end+0x2c5bcc>
 2f4:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 2f8:	3c13490e 			; <UNDEFINED> instruction: 0x3c13490e
 2fc:	01136419 	tsteq	r3, r9, lsl r4
 300:	16000013 			; <UNDEFINED> instruction: 0x16000013
 304:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 308:	0b3a0e03 	bleq	e83b1c <__bss_end+0xe7abb8>
 30c:	0b390b3b 	bleq	e43000 <__bss_end+0xe3a09c>
 310:	13490e6e 	movtne	r0, #40558	; 0x9e6e
 314:	193c0b32 	ldmdbne	ip!, {r1, r4, r5, r8, r9, fp}
 318:	13011364 	movwne	r1, #4964	; 0x1364
 31c:	0d170000 	ldceq	0, cr0, [r7, #-0]
 320:	3a0e0300 	bcc	380f28 <__bss_end+0x377fc4>
 324:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 328:	3813490b 	ldmdacc	r3, {r0, r1, r3, r8, fp, lr}
 32c:	000b320b 	andeq	r3, fp, fp, lsl #4
 330:	012e1800 			; <UNDEFINED> instruction: 0x012e1800
 334:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 338:	0b3b0b3a 	bleq	ec3028 <__bss_end+0xeba0c4>
 33c:	0e6e0b39 	vmoveq.8	d14[5], r0
 340:	193c0b32 	ldmdbne	ip!, {r1, r4, r5, r8, r9, fp}
 344:	13011364 	movwne	r1, #4964	; 0x1364
 348:	2e190000 	cdpcs	0, 1, cr0, cr9, cr0, {0}
 34c:	03193f01 	tsteq	r9, #1, 30
 350:	3b0b3a0e 	blcc	2ceb90 <__bss_end+0x2c5c2c>
 354:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 358:	3213490e 	andscc	r4, r3, #229376	; 0x38000
 35c:	64193c0b 	ldrvs	r3, [r9], #-3083	; 0xfffff3f5
 360:	1a000013 	bne	3b4 <shift+0x3b4>
 364:	13490115 	movtne	r0, #37141	; 0x9115
 368:	13011364 	movwne	r1, #4964	; 0x1364
 36c:	1f1b0000 	svcne	0x001b0000
 370:	49131d00 	ldmdbmi	r3, {r8, sl, fp, ip}
 374:	1c000013 	stcne	0, cr0, [r0], {19}
 378:	0b0b0010 	bleq	2c03c0 <__bss_end+0x2b745c>
 37c:	00001349 	andeq	r1, r0, r9, asr #6
 380:	0b000f1d 	bleq	3ffc <shift+0x3ffc>
 384:	1e00000b 	cdpne	0, 0, cr0, cr0, cr11, {0}
 388:	08030139 	stmdaeq	r3, {r0, r3, r4, r5, r8}
 38c:	0b3b0b3a 	bleq	ec307c <__bss_end+0xeba118>
 390:	13010b39 	movwne	r0, #6969	; 0x1b39
 394:	341f0000 	ldrcc	r0, [pc], #-0	; 39c <shift+0x39c>
 398:	3a0e0300 	bcc	380fa0 <__bss_end+0x37803c>
 39c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 3a0:	3c13490b 			; <UNDEFINED> instruction: 0x3c13490b
 3a4:	6c061c19 	stcvs	12, cr1, [r6], {25}
 3a8:	20000019 	andcs	r0, r0, r9, lsl r0
 3ac:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 3b0:	0b3b0b3a 	bleq	ec30a0 <__bss_end+0xeba13c>
 3b4:	13490b39 	movtne	r0, #39737	; 0x9b39
 3b8:	0b1c193c 	bleq	7068b0 <__bss_end+0x6fd94c>
 3bc:	0000196c 	andeq	r1, r0, ip, ror #18
 3c0:	47003421 	strmi	r3, [r0, -r1, lsr #8]
 3c4:	22000013 	andcs	r0, r0, #19
 3c8:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 3cc:	0b3b0b3a 	bleq	ec30bc <__bss_end+0xeba158>
 3d0:	13490b39 	movtne	r0, #39737	; 0x9b39
 3d4:	1802193f 	stmdane	r2, {r0, r1, r2, r3, r4, r5, r8, fp, ip}
 3d8:	2e230000 	cdpcs	0, 2, cr0, cr3, cr0, {0}
 3dc:	03193f01 	tsteq	r9, #1, 30
 3e0:	3b0b3a0e 	blcc	2cec20 <__bss_end+0x2c5cbc>
 3e4:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 3e8:	12011113 	andne	r1, r1, #-1073741820	; 0xc0000004
 3ec:	96184006 	ldrls	r4, [r8], -r6
 3f0:	13011942 	movwne	r1, #6466	; 0x1942
 3f4:	05240000 	streq	r0, [r4, #-0]!
 3f8:	3a0e0300 	bcc	381000 <__bss_end+0x37809c>
 3fc:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 400:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 404:	25000018 	strcs	r0, [r0, #-24]	; 0xffffffe8
 408:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 40c:	0b3b0b3a 	bleq	ec30fc <__bss_end+0xeba198>
 410:	13490b39 	movtne	r0, #39737	; 0x9b39
 414:	00001802 	andeq	r1, r0, r2, lsl #16
 418:	3f012e26 	svccc	0x00012e26
 41c:	3a0e0319 	bcc	381088 <__bss_end+0x378124>
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
 458:	0b002404 	bleq	9470 <__bss_end+0x50c>
 45c:	030b3e0b 	movweq	r3, #48651	; 0xbe0b
 460:	05000008 	streq	r0, [r0, #-8]
 464:	0e030016 	mcreq	0, 0, r0, cr3, cr6, {0}
 468:	0b3b0b3a 	bleq	ec3158 <__bss_end+0xeba1f4>
 46c:	13490b39 	movtne	r0, #39737	; 0x9b39
 470:	13060000 	movwne	r0, #24576	; 0x6000
 474:	0b0e0301 	bleq	381080 <__bss_end+0x37811c>
 478:	3b0b3a0b 	blcc	2cecac <__bss_end+0x2c5d48>
 47c:	010b390b 	tsteq	fp, fp, lsl #18
 480:	07000013 	smladeq	r0, r3, r0, r0
 484:	0803000d 	stmdaeq	r3, {r0, r2, r3}
 488:	0b3b0b3a 	bleq	ec3178 <__bss_end+0xeba214>
 48c:	13490b39 	movtne	r0, #39737	; 0x9b39
 490:	00000b38 	andeq	r0, r0, r8, lsr fp
 494:	03010408 	movweq	r0, #5128	; 0x1408
 498:	3e196d0e 	cdpcc	13, 1, cr6, cr9, cr14, {0}
 49c:	490b0b0b 	stmdbmi	fp, {r0, r1, r3, r8, r9, fp}
 4a0:	3b0b3a13 	blcc	2cecf4 <__bss_end+0x2c5d90>
 4a4:	010b390b 	tsteq	fp, fp, lsl #18
 4a8:	09000013 	stmdbeq	r0, {r0, r1, r4}
 4ac:	08030028 	stmdaeq	r3, {r3, r5}
 4b0:	00000b1c 	andeq	r0, r0, ip, lsl fp
 4b4:	0300280a 	movweq	r2, #2058	; 0x80a
 4b8:	000b1c0e 	andeq	r1, fp, lr, lsl #24
 4bc:	00340b00 	eorseq	r0, r4, r0, lsl #22
 4c0:	0b3a0e03 	bleq	e83cd4 <__bss_end+0xe7ad70>
 4c4:	0b390b3b 	bleq	e431b8 <__bss_end+0xe3a254>
 4c8:	196c1349 	stmdbne	ip!, {r0, r3, r6, r8, r9, ip}^
 4cc:	00001802 	andeq	r1, r0, r2, lsl #16
 4d0:	0300020c 	movweq	r0, #524	; 0x20c
 4d4:	00193c0e 	andseq	r3, r9, lr, lsl #24
 4d8:	000f0d00 	andeq	r0, pc, r0, lsl #26
 4dc:	13490b0b 	movtne	r0, #39691	; 0x9b0b
 4e0:	0d0e0000 	stceq	0, cr0, [lr, #-0]
 4e4:	3a0e0300 	bcc	3810ec <__bss_end+0x378188>
 4e8:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 4ec:	3813490b 	ldmdacc	r3, {r0, r1, r3, r8, fp, lr}
 4f0:	0f00000b 	svceq	0x0000000b
 4f4:	13490101 	movtne	r0, #37121	; 0x9101
 4f8:	00001301 	andeq	r1, r0, r1, lsl #6
 4fc:	49002110 	stmdbmi	r0, {r4, r8, sp}
 500:	000b2f13 	andeq	r2, fp, r3, lsl pc
 504:	01021100 	mrseq	r1, (UNDEF: 18)
 508:	0b0b0e03 	bleq	2c3d1c <__bss_end+0x2badb8>
 50c:	0b3b0b3a 	bleq	ec31fc <__bss_end+0xeba298>
 510:	13010b39 	movwne	r0, #6969	; 0x1b39
 514:	2e120000 	cdpcs	0, 1, cr0, cr2, cr0, {0}
 518:	03193f01 	tsteq	r9, #1, 30
 51c:	3b0b3a0e 	blcc	2ced5c <__bss_end+0x2c5df8>
 520:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 524:	64193c0e 	ldrvs	r3, [r9], #-3086	; 0xfffff3f2
 528:	00130113 	andseq	r0, r3, r3, lsl r1
 52c:	00051300 	andeq	r1, r5, r0, lsl #6
 530:	19341349 	ldmdbne	r4!, {r0, r3, r6, r8, r9, ip}
 534:	05140000 	ldreq	r0, [r4, #-0]
 538:	00134900 	andseq	r4, r3, r0, lsl #18
 53c:	012e1500 			; <UNDEFINED> instruction: 0x012e1500
 540:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 544:	0b3b0b3a 	bleq	ec3234 <__bss_end+0xeba2d0>
 548:	0e6e0b39 	vmoveq.8	d14[5], r0
 54c:	193c1349 	ldmdbne	ip!, {r0, r3, r6, r8, r9, ip}
 550:	13011364 	movwne	r1, #4964	; 0x1364
 554:	2e160000 	cdpcs	0, 1, cr0, cr6, cr0, {0}
 558:	03193f01 	tsteq	r9, #1, 30
 55c:	3b0b3a0e 	blcc	2ced9c <__bss_end+0x2c5e38>
 560:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 564:	3213490e 	andscc	r4, r3, #229376	; 0x38000
 568:	64193c0b 	ldrvs	r3, [r9], #-3083	; 0xfffff3f5
 56c:	00130113 	andseq	r0, r3, r3, lsl r1
 570:	000d1700 	andeq	r1, sp, r0, lsl #14
 574:	0b3a0e03 	bleq	e83d88 <__bss_end+0xe7ae24>
 578:	0b390b3b 	bleq	e4326c <__bss_end+0xe3a308>
 57c:	0b381349 	bleq	e052a8 <__bss_end+0xdfc344>
 580:	00000b32 	andeq	r0, r0, r2, lsr fp
 584:	3f012e18 	svccc	0x00012e18
 588:	3a0e0319 	bcc	3811f4 <__bss_end+0x378290>
 58c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 590:	320e6e0b 	andcc	r6, lr, #11, 28	; 0xb0
 594:	64193c0b 	ldrvs	r3, [r9], #-3083	; 0xfffff3f5
 598:	00130113 	andseq	r0, r3, r3, lsl r1
 59c:	012e1900 			; <UNDEFINED> instruction: 0x012e1900
 5a0:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 5a4:	0b3b0b3a 	bleq	ec3294 <__bss_end+0xeba330>
 5a8:	0e6e0b39 	vmoveq.8	d14[5], r0
 5ac:	0b321349 	bleq	c852d8 <__bss_end+0xc7c374>
 5b0:	1364193c 	cmnne	r4, #60, 18	; 0xf0000
 5b4:	151a0000 	ldrne	r0, [sl, #-0]
 5b8:	64134901 	ldrvs	r4, [r3], #-2305	; 0xfffff6ff
 5bc:	00130113 	andseq	r0, r3, r3, lsl r1
 5c0:	001f1b00 	andseq	r1, pc, r0, lsl #22
 5c4:	1349131d 	movtne	r1, #37661	; 0x931d
 5c8:	101c0000 	andsne	r0, ip, r0
 5cc:	490b0b00 	stmdbmi	fp, {r8, r9, fp}
 5d0:	1d000013 	stcne	0, cr0, [r0, #-76]	; 0xffffffb4
 5d4:	0b0b000f 	bleq	2c0618 <__bss_end+0x2b76b4>
 5d8:	341e0000 	ldrcc	r0, [lr], #-0
 5dc:	3a0e0300 	bcc	3811e4 <__bss_end+0x378280>
 5e0:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 5e4:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 5e8:	1f000018 	svcne	0x00000018
 5ec:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 5f0:	0b3a0e03 	bleq	e83e04 <__bss_end+0xe7aea0>
 5f4:	0b390b3b 	bleq	e432e8 <__bss_end+0xe3a384>
 5f8:	13490e6e 	movtne	r0, #40558	; 0x9e6e
 5fc:	06120111 			; <UNDEFINED> instruction: 0x06120111
 600:	42961840 	addsmi	r1, r6, #64, 16	; 0x400000
 604:	00130119 	andseq	r0, r3, r9, lsl r1
 608:	00052000 	andeq	r2, r5, r0
 60c:	0b3a0e03 	bleq	e83e20 <__bss_end+0xe7aebc>
 610:	0b390b3b 	bleq	e43304 <__bss_end+0xe3a3a0>
 614:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 618:	2e210000 	cdpcs	0, 2, cr0, cr1, cr0, {0}
 61c:	03193f01 	tsteq	r9, #1, 30
 620:	3b0b3a0e 	blcc	2cee60 <__bss_end+0x2c5efc>
 624:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 628:	1113490e 	tstne	r3, lr, lsl #18
 62c:	40061201 	andmi	r1, r6, r1, lsl #4
 630:	19429718 	stmdbne	r2, {r3, r4, r8, r9, sl, ip, pc}^
 634:	00001301 	andeq	r1, r0, r1, lsl #6
 638:	03003422 	movweq	r3, #1058	; 0x422
 63c:	3b0b3a08 	blcc	2cee64 <__bss_end+0x2c5f00>
 640:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 644:	00180213 	andseq	r0, r8, r3, lsl r2
 648:	012e2300 			; <UNDEFINED> instruction: 0x012e2300
 64c:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 650:	0b3b0b3a 	bleq	ec3340 <__bss_end+0xeba3dc>
 654:	0e6e0b39 	vmoveq.8	d14[5], r0
 658:	06120111 			; <UNDEFINED> instruction: 0x06120111
 65c:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
 660:	00130119 	andseq	r0, r3, r9, lsl r1
 664:	002e2400 	eoreq	r2, lr, r0, lsl #8
 668:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 66c:	0b3b0b3a 	bleq	ec335c <__bss_end+0xeba3f8>
 670:	0e6e0b39 	vmoveq.8	d14[5], r0
 674:	06120111 			; <UNDEFINED> instruction: 0x06120111
 678:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
 67c:	25000019 	strcs	r0, [r0, #-25]	; 0xffffffe7
 680:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 684:	0b3a0e03 	bleq	e83e98 <__bss_end+0xe7af34>
 688:	0b390b3b 	bleq	e4337c <__bss_end+0xe3a418>
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
 6b8:	3a0e0300 	bcc	3812c0 <__bss_end+0x37835c>
 6bc:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 6c0:	3c13490b 			; <UNDEFINED> instruction: 0x3c13490b
 6c4:	000a1c19 	andeq	r1, sl, r9, lsl ip
 6c8:	003a0400 	eorseq	r0, sl, r0, lsl #8
 6cc:	0b3b0b3a 	bleq	ec33bc <__bss_end+0xeba458>
 6d0:	13180b39 	tstne	r8, #58368	; 0xe400
 6d4:	01050000 	mrseq	r0, (UNDEF: 5)
 6d8:	01134901 	tsteq	r3, r1, lsl #18
 6dc:	06000013 			; <UNDEFINED> instruction: 0x06000013
 6e0:	13490021 	movtne	r0, #36897	; 0x9021
 6e4:	00000b2f 	andeq	r0, r0, pc, lsr #22
 6e8:	49002607 	stmdbmi	r0, {r0, r1, r2, r9, sl, sp}
 6ec:	08000013 	stmdaeq	r0, {r0, r1, r4}
 6f0:	0b0b0024 	bleq	2c0788 <__bss_end+0x2b7824>
 6f4:	0e030b3e 	vmoveq.16	d3[0], r0
 6f8:	34090000 	strcc	r0, [r9], #-0
 6fc:	00134700 	andseq	r4, r3, r0, lsl #14
 700:	012e0a00 			; <UNDEFINED> instruction: 0x012e0a00
 704:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 708:	0b3b0b3a 	bleq	ec33f8 <__bss_end+0xeba494>
 70c:	0e6e0b39 	vmoveq.8	d14[5], r0
 710:	06120111 			; <UNDEFINED> instruction: 0x06120111
 714:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
 718:	00130119 	andseq	r0, r3, r9, lsl r1
 71c:	00050b00 	andeq	r0, r5, r0, lsl #22
 720:	0b3a0803 	bleq	e82734 <__bss_end+0xe797d0>
 724:	0b390b3b 	bleq	e43418 <__bss_end+0xe3a4b4>
 728:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 72c:	340c0000 	strcc	r0, [ip], #-0
 730:	3a0e0300 	bcc	381338 <__bss_end+0x3783d4>
 734:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 738:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 73c:	0d000018 	stceq	0, cr0, [r0, #-96]	; 0xffffffa0
 740:	0111010b 	tsteq	r1, fp, lsl #2
 744:	00000612 	andeq	r0, r0, r2, lsl r6
 748:	0300340e 	movweq	r3, #1038	; 0x40e
 74c:	3b0b3a08 	blcc	2cef74 <__bss_end+0x2c6010>
 750:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 754:	00180213 	andseq	r0, r8, r3, lsl r2
 758:	000f0f00 	andeq	r0, pc, r0, lsl #30
 75c:	13490b0b 	movtne	r0, #39691	; 0x9b0b
 760:	26100000 	ldrcs	r0, [r0], -r0
 764:	11000000 	mrsne	r0, (UNDEF: 0)
 768:	0b0b000f 	bleq	2c07ac <__bss_end+0x2b7848>
 76c:	24120000 	ldrcs	r0, [r2], #-0
 770:	3e0b0b00 	vmlacc.f64	d0, d11, d0
 774:	0008030b 	andeq	r0, r8, fp, lsl #6
 778:	00051300 	andeq	r1, r5, r0, lsl #6
 77c:	0b3a0e03 	bleq	e83f90 <__bss_end+0xe7b02c>
 780:	0b390b3b 	bleq	e43474 <__bss_end+0xe3a510>
 784:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 788:	2e140000 	cdpcs	0, 1, cr0, cr4, cr0, {0}
 78c:	03193f01 	tsteq	r9, #1, 30
 790:	3b0b3a0e 	blcc	2cefd0 <__bss_end+0x2c606c>
 794:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 798:	1113490e 	tstne	r3, lr, lsl #18
 79c:	40061201 	andmi	r1, r6, r1, lsl #4
 7a0:	19429718 	stmdbne	r2, {r3, r4, r8, r9, sl, ip, pc}^
 7a4:	00001301 	andeq	r1, r0, r1, lsl #6
 7a8:	3f012e15 	svccc	0x00012e15
 7ac:	3a0e0319 	bcc	381418 <__bss_end+0x3784b4>
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
  74:	00000118 	andeq	r0, r0, r8, lsl r1
	...
  80:	0000001c 	andeq	r0, r0, ip, lsl r0
  84:	0ae20002 	beq	ff880094 <__bss_end+0xff877130>
  88:	00040000 	andeq	r0, r4, r0
  8c:	00000000 	andeq	r0, r0, r0
  90:	00008344 	andeq	r8, r0, r4, asr #6
  94:	0000045c 	andeq	r0, r0, ip, asr r4
	...
  a0:	0000001c 	andeq	r0, r0, ip, lsl r0
  a4:	16050002 	strne	r0, [r5], -r2
  a8:	00040000 	andeq	r0, r4, r0
  ac:	00000000 	andeq	r0, r0, r0
  b0:	000087a0 	andeq	r8, r0, r0, lsr #15
  b4:	000004b8 			; <UNDEFINED> instruction: 0x000004b8
	...

Disassembly of section .debug_str:

00000000 <.debug_str>:
       0:	6573552f 	ldrbvs	r5, [r3, #-1327]!	; 0xfffffad1
       4:	772f7372 			; <UNDEFINED> instruction: 0x772f7372
       8:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
       c:	2f696a72 	svccs	0x00696a72
      10:	6b736544 	blvs	1cd9528 <__bss_end+0x1cd05c4>
      14:	2f706f74 	svccs	0x00706f74
      18:	2f564146 	svccs	0x00564146
      1c:	6176614e 	cmnvs	r6, lr, asr #2
      20:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
      24:	4f2f6963 	svcmi	0x002f6963
      28:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
      2c:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
      30:	6b6c6172 	blvs	1b18600 <__bss_end+0x1b0f69c>
      34:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
      38:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
      3c:	756f732f 	strbvc	r7, [pc, #-815]!	; fffffd15 <__bss_end+0xffff6db1>
      40:	73656372 	cmnvc	r5, #-939524095	; 0xc8000001
      44:	6573752f 	ldrbvs	r7, [r3, #-1327]!	; 0xfffffad1
      48:	61707372 	cmnvs	r0, r2, ror r3
      4c:	632f6563 			; <UNDEFINED> instruction: 0x632f6563
      50:	2e307472 	mrccs	4, 1, r7, cr0, cr2, {3}
      54:	552f0073 	strpl	r0, [pc, #-115]!	; ffffffe9 <__bss_end+0xffff7085>
      58:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
      5c:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
      60:	6a726574 	bvs	1c99638 <__bss_end+0x1c906d4>
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
      98:	752f7365 	strvc	r7, [pc, #-869]!	; fffffd3b <__bss_end+0xffff6dd7>
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
     12c:	6a363731 	bvs	d8ddf8 <__bss_end+0xd84e94>
     130:	732d667a 			; <UNDEFINED> instruction: 0x732d667a
     134:	616d2d20 	cmnvs	sp, r0, lsr #26
     138:	2d206d72 	stccs	13, cr6, [r0, #-456]!	; 0xfffffe38
     13c:	6372616d 	cmnvs	r2, #1073741851	; 0x4000001b
     140:	72613d68 	rsbvc	r3, r1, #104, 26	; 0x1a00
     144:	7a36766d 	bvc	d9db00 <__bss_end+0xd94b9c>
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
     184:	6a757a61 	bvs	1d5eb10 <__bss_end+0x1d55bac>
     188:	2f696369 	svccs	0x00696369
     18c:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
     190:	73656d65 	cmnvc	r5, #6464	; 0x1940
     194:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
     198:	6b2d616b 	blvs	b5874c <__bss_end+0xb4f7e8>
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
     1e4:	2b2b4320 	blcs	ad0e6c <__bss_end+0xac7f08>
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
     260:	2b6b7a36 	blcs	1adeb40 <__bss_end+0x1ad5bdc>
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
     294:	755f6962 	ldrbvc	r6, [pc, #-2402]	; fffff93a <__bss_end+0xffff69d6>
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
     324:	6b736544 	blvs	1cd983c <__bss_end+0x1cd08d8>
     328:	2f706f74 	svccs	0x00706f74
     32c:	2f564146 	svccs	0x00564146
     330:	6176614e 	cmnvs	r6, lr, asr #2
     334:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
     338:	4f2f6963 	svcmi	0x002f6963
     33c:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
     340:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
     344:	6b6c6172 	blvs	1b18914 <__bss_end+0x1b0f9b0>
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
     41c:	6b636f6c 	blvs	18dc1d4 <__bss_end+0x18d3270>
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
     49c:	5a5f0064 	bpl	17c0634 <__bss_end+0x17b76d0>
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
     4d0:	74654700 	strbtvc	r4, [r5], #-1792	; 0xfffff900
     4d4:	6f72505f 	svcvs	0x0072505f
     4d8:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     4dc:	5f79425f 	svcpl	0x0079425f
     4e0:	00444950 	subeq	r4, r4, r0, asr r9
     4e4:	656d6954 	strbvs	r6, [sp, #-2388]!	; 0xfffff6ac
     4e8:	61425f72 	hvcvs	9714	; 0x25f2
     4ec:	4e006573 	cfrshl64mi	mvdx0, mvdx3, r6
     4f0:	5f495753 	svcpl	0x00495753
     4f4:	636f7250 	cmnvs	pc, #80, 4
     4f8:	5f737365 	svcpl	0x00737365
     4fc:	76726553 			; <UNDEFINED> instruction: 0x76726553
     500:	00656369 	rsbeq	r6, r5, r9, ror #6
     504:	64616552 	strbtvs	r6, [r1], #-1362	; 0xfffffaae
     508:	74634100 	strbtvc	r4, [r3], #-256	; 0xffffff00
     50c:	5f657669 	svcpl	0x00657669
     510:	636f7250 	cmnvs	pc, #80, 4
     514:	5f737365 	svcpl	0x00737365
     518:	6e756f43 	cdpvs	15, 7, cr6, cr5, cr3, {2}
     51c:	72430074 	subvc	r0, r3, #116	; 0x74
     520:	65746165 	ldrbvs	r6, [r4, #-357]!	; 0xfffffe9b
     524:	6f72505f 	svcvs	0x0072505f
     528:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     52c:	61747300 	cmnvs	r4, r0, lsl #6
     530:	4d006574 	cfstr32mi	mvfx6, [r0, #-464]	; 0xfffffe30
     534:	69467861 	stmdbvs	r6, {r0, r5, r6, fp, ip, sp, lr}^
     538:	616e656c 	cmnvs	lr, ip, ror #10
     53c:	654c656d 	strbvs	r6, [ip, #-1389]	; 0xfffffa93
     540:	6874676e 	ldmdavs	r4!, {r1, r2, r3, r5, r6, r8, r9, sl, sp, lr}^
     544:	58554100 	ldmdapl	r5, {r8, lr}^
     548:	7361425f 	cmnvc	r1, #-268435451	; 0xf0000005
     54c:	65470065 	strbvs	r0, [r7, #-101]	; 0xffffff9b
     550:	63535f74 	cmpvs	r3, #116, 30	; 0x1d0
     554:	75646568 	strbvc	r6, [r4, #-1384]!	; 0xfffffa98
     558:	5f72656c 	svcpl	0x0072656c
     55c:	6f666e49 	svcvs	0x00666e49
     560:	61654400 	cmnvs	r5, r0, lsl #8
     564:	6e696c64 	cdpvs	12, 6, cr6, cr9, cr4, {3}
     568:	6e555f65 	cdpvs	15, 5, cr5, cr5, cr5, {3}
     56c:	6e616863 	cdpvs	8, 6, cr6, cr1, cr3, {3}
     570:	00646567 	rsbeq	r6, r4, r7, ror #10
     574:	6f725043 	svcvs	0x00725043
     578:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     57c:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     580:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     584:	61686300 	cmnvs	r8, r0, lsl #6
     588:	69745f72 	ldmdbvs	r4!, {r1, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     58c:	645f6b63 	ldrbvs	r6, [pc], #-2915	; 594 <shift+0x594>
     590:	79616c65 	stmdbvc	r1!, {r0, r2, r5, r6, sl, fp, sp, lr}^
     594:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     598:	50433631 	subpl	r3, r3, r1, lsr r6
     59c:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     5a0:	4d5f7373 	ldclmi	3, cr7, [pc, #-460]	; 3dc <shift+0x3dc>
     5a4:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
     5a8:	38317265 	ldmdacc	r1!, {r0, r2, r5, r6, r9, ip, sp, lr}
     5ac:	5f746547 	svcpl	0x00746547
     5b0:	65686353 	strbvs	r6, [r8, #-851]!	; 0xfffffcad
     5b4:	656c7564 	strbvs	r7, [ip, #-1380]!	; 0xfffffa9c
     5b8:	6e495f72 	mcrvs	15, 2, r5, cr9, cr2, {3}
     5bc:	32456f66 	subcc	r6, r5, #408	; 0x198
     5c0:	65474e30 	strbvs	r4, [r7, #-3632]	; 0xfffff1d0
     5c4:	63535f74 	cmpvs	r3, #116, 30	; 0x1d0
     5c8:	5f646568 	svcpl	0x00646568
     5cc:	6f666e49 	svcvs	0x00666e49
     5d0:	7079545f 	rsbsvc	r5, r9, pc, asr r4
     5d4:	00765065 	rsbseq	r5, r6, r5, rrx
     5d8:	314e5a5f 	cmpcc	lr, pc, asr sl
     5dc:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     5e0:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     5e4:	614d5f73 	hvcvs	54771	; 0xd5f3
     5e8:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     5ec:	48313272 	ldmdami	r1!, {r1, r4, r5, r6, r9, ip, sp}
     5f0:	6c646e61 	stclvs	14, cr6, [r4], #-388	; 0xfffffe7c
     5f4:	69465f65 	stmdbvs	r6, {r0, r2, r5, r6, r8, r9, sl, fp, ip, lr}^
     5f8:	7973656c 	ldmdbvc	r3!, {r2, r3, r5, r6, r8, sl, sp, lr}^
     5fc:	6d657473 	cfstrdvs	mvd7, [r5, #-460]!	; 0xfffffe34
     600:	4957535f 	ldmdbmi	r7, {r0, r1, r2, r3, r4, r6, r8, r9, ip, lr}^
     604:	4e333245 	cdpmi	2, 3, cr3, cr3, cr5, {2}
     608:	5f495753 	svcpl	0x00495753
     60c:	656c6946 	strbvs	r6, [ip, #-2374]!	; 0xfffff6ba
     610:	74737973 	ldrbtvc	r7, [r3], #-2419	; 0xfffff68d
     614:	535f6d65 	cmppl	pc, #6464	; 0x1940
     618:	69767265 	ldmdbvs	r6!, {r0, r2, r5, r6, r9, ip, sp, lr}^
     61c:	6a6a6563 	bvs	1a99bb0 <__bss_end+0x1a90c4c>
     620:	3131526a 	teqcc	r1, sl, ror #4
     624:	49575354 	ldmdbmi	r7, {r2, r4, r6, r8, r9, ip, lr}^
     628:	7365525f 	cmnvc	r5, #-268435451	; 0xf0000005
     62c:	00746c75 	rsbseq	r6, r4, r5, ror ip
     630:	6e65706f 	cdpvs	0, 6, cr7, cr5, cr15, {3}
     634:	665f6465 	ldrbvs	r6, [pc], -r5, ror #8
     638:	73656c69 	cmnvc	r5, #26880	; 0x6900
     63c:	746f4e00 	strbtvc	r4, [pc], #-3584	; 644 <shift+0x644>
     640:	41796669 	cmnmi	r9, r9, ror #12
     644:	73006c6c 	movwvc	r6, #3180	; 0xc6c
     648:	74726f68 	ldrbtvc	r6, [r2], #-3944	; 0xfffff098
     64c:	696c625f 	stmdbvs	ip!, {r0, r1, r2, r3, r4, r6, r9, sp, lr}^
     650:	54006b6e 	strpl	r6, [r0], #-2926	; 0xfffff492
     654:	5f555043 	svcpl	0x00555043
     658:	746e6f43 	strbtvc	r6, [lr], #-3907	; 0xfffff0bd
     65c:	00747865 	rsbseq	r7, r4, r5, ror #16
     660:	64616544 	strbtvs	r6, [r1], #-1348	; 0xfffffabc
     664:	656e696c 	strbvs	r6, [lr, #-2412]!	; 0xfffff694
     668:	62747400 	rsbsvs	r7, r4, #0, 8
     66c:	5f003072 	svcpl	0x00003072
     670:	36314e5a 			; <UNDEFINED> instruction: 0x36314e5a
     674:	6f725043 	svcvs	0x00725043
     678:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     67c:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     680:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     684:	6f4e3431 	svcvs	0x004e3431
     688:	79666974 	stmdbvc	r6!, {r2, r4, r5, r6, r8, fp, sp, lr}^
     68c:	6f72505f 	svcvs	0x0072505f
     690:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     694:	47006a45 	strmi	r6, [r0, -r5, asr #20]
     698:	505f7465 	subspl	r7, pc, r5, ror #8
     69c:	42004449 	andmi	r4, r0, #1224736768	; 0x49000000
     6a0:	5f304353 	svcpl	0x00304353
     6a4:	65736142 	ldrbvs	r6, [r3, #-322]!	; 0xfffffebe
     6a8:	746f6e00 	strbtvc	r6, [pc], #-3584	; 6b0 <shift+0x6b0>
     6ac:	65696669 	strbvs	r6, [r9, #-1641]!	; 0xfffff997
     6b0:	65645f64 	strbvs	r5, [r4, #-3940]!	; 0xfffff09c
     6b4:	696c6461 	stmdbvs	ip!, {r0, r5, r6, sl, sp, lr}^
     6b8:	4900656e 	stmdbmi	r0, {r1, r2, r3, r5, r6, r8, sl, sp, lr}
     6bc:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
     6c0:	74707572 	ldrbtvc	r7, [r0], #-1394	; 0xfffffa8e
     6c4:	6e6f435f 	mcrvs	3, 3, r4, cr15, cr15, {2}
     6c8:	6c6f7274 	sfmvs	f7, 2, [pc], #-464	; 500 <shift+0x500>
     6cc:	5f72656c 	svcpl	0x0072656c
     6d0:	65736142 	ldrbvs	r6, [r3, #-322]!	; 0xfffffebe
     6d4:	43534200 	cmpmi	r3, #0, 4
     6d8:	61425f31 	cmpvs	r2, r1, lsr pc
     6dc:	4d006573 	cfstr32mi	mvfx6, [r0, #-460]	; 0xfffffe34
     6e0:	505f7861 	subspl	r7, pc, r1, ror #16
     6e4:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     6e8:	4f5f7373 	svcmi	0x005f7373
     6ec:	656e6570 	strbvs	r6, [lr, #-1392]!	; 0xfffffa90
     6f0:	69465f64 	stmdbvs	r6, {r2, r5, r6, r8, r9, sl, fp, ip, lr}^
     6f4:	0073656c 	rsbseq	r6, r3, ip, ror #10
     6f8:	314e5a5f 	cmpcc	lr, pc, asr sl
     6fc:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     700:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     704:	614d5f73 	hvcvs	54771	; 0xd5f3
     708:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     70c:	55383172 	ldrpl	r3, [r8, #-370]!	; 0xfffffe8e
     710:	70616d6e 	rsbvc	r6, r1, lr, ror #26
     714:	6c69465f 	stclvs	6, cr4, [r9], #-380	; 0xfffffe84
     718:	75435f65 	strbvc	r5, [r3, #-3941]	; 0xfffff09b
     71c:	6e657272 	mcrvs	2, 3, r7, cr5, cr2, {3}
     720:	006a4574 	rsbeq	r4, sl, r4, ror r5
     724:	474e5254 	smlsldmi	r5, lr, r4, r2
     728:	7361425f 	cmnvc	r1, #-268435451	; 0xf0000005
     72c:	65470065 	strbvs	r0, [r7, #-101]	; 0xffffff9b
     730:	75435f74 	strbvc	r5, [r3, #-3956]	; 0xfffff08c
     734:	6e657272 	mcrvs	2, 3, r7, cr5, cr2, {3}
     738:	72505f74 	subsvc	r5, r0, #116, 30	; 0x1d0
     73c:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     740:	6f6c0073 	svcvs	0x006c0073
     744:	7520676e 	strvc	r6, [r0, #-1902]!	; 0xfffff892
     748:	6769736e 	strbvs	r7, [r9, -lr, ror #6]!
     74c:	2064656e 	rsbcs	r6, r4, lr, ror #10
     750:	00746e69 	rsbseq	r6, r4, r9, ror #28
     754:	5f70614d 	svcpl	0x0070614d
     758:	656c6946 	strbvs	r6, [ip, #-2374]!	; 0xfffff6ba
     75c:	5f6f545f 	svcpl	0x006f545f
     760:	72727543 	rsbsvc	r7, r2, #281018368	; 0x10c00000
     764:	00746e65 	rsbseq	r6, r4, r5, ror #28
     768:	69466f4e 	stmdbvs	r6, {r1, r2, r3, r6, r8, r9, sl, fp, sp, lr}^
     76c:	7973656c 	ldmdbvc	r3!, {r2, r3, r5, r6, r8, sl, sp, lr}^
     770:	6d657473 	cfstrdvs	mvd7, [r5, #-460]!	; 0xfffffe34
     774:	76697244 	strbtvc	r7, [r9], -r4, asr #4
     778:	48007265 	stmdami	r0, {r0, r2, r5, r6, r9, ip, sp, lr}
     77c:	6c646e61 	stclvs	14, cr6, [r4], #-388	; 0xfffffe7c
     780:	72505f65 	subsvc	r5, r0, #404	; 0x194
     784:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     788:	57535f73 			; <UNDEFINED> instruction: 0x57535f73
     78c:	68730049 	ldmdavs	r3!, {r0, r3, r6}^
     790:	2074726f 	rsbscs	r7, r4, pc, ror #4
     794:	69736e75 	ldmdbvs	r3!, {r0, r2, r4, r5, r6, r9, sl, fp, sp, lr}^
     798:	64656e67 	strbtvs	r6, [r5], #-3687	; 0xfffff199
     79c:	746e6920 	strbtvc	r6, [lr], #-2336	; 0xfffff6e0
     7a0:	68635300 	stmdavs	r3!, {r8, r9, ip, lr}^
     7a4:	6c756465 	cfldrdvs	mvd6, [r5], #-404	; 0xfffffe6c
     7a8:	44455f65 	strbmi	r5, [r5], #-3941	; 0xfffff09b
     7ac:	61570046 	cmpvs	r7, r6, asr #32
     7b0:	2f007469 	svccs	0x00007469
     7b4:	72657355 	rsbvc	r7, r5, #1409286145	; 0x54000001
     7b8:	69772f73 	ldmdbvs	r7!, {r0, r1, r4, r5, r6, r8, r9, sl, fp, sp}^
     7bc:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
     7c0:	442f696a 	strtmi	r6, [pc], #-2410	; 7c8 <shift+0x7c8>
     7c4:	746b7365 	strbtvc	r7, [fp], #-869	; 0xfffffc9b
     7c8:	462f706f 	strtmi	r7, [pc], -pc, rrx
     7cc:	4e2f5641 	cfmadda32mi	mvax2, mvax5, mvfx15, mvfx1
     7d0:	7a617661 	bvc	185e15c <__bss_end+0x18551f8>
     7d4:	63696a75 	cmnvs	r9, #479232	; 0x75000
     7d8:	534f2f69 	movtpl	r2, #65385	; 0xff69
     7dc:	6d65732f 	stclvs	3, cr7, [r5, #-188]!	; 0xffffff44
     7e0:	72747365 	rsbsvc	r7, r4, #-1811939327	; 0x94000001
     7e4:	616b6c61 	cmnvs	fp, r1, ror #24
     7e8:	76696b2d 	strbtvc	r6, [r9], -sp, lsr #22
     7ec:	2f736f2d 	svccs	0x00736f2d
     7f0:	72756f73 	rsbsvc	r6, r5, #460	; 0x1cc
     7f4:	2f736563 	svccs	0x00736563
     7f8:	72657375 	rsbvc	r7, r5, #-738197503	; 0xd4000001
     7fc:	63617073 	cmnvs	r1, #115	; 0x73
     800:	65682f65 	strbvs	r2, [r8, #-3941]!	; 0xfffff09b
     804:	5f6f6c6c 	svcpl	0x006f6c6c
     808:	6b736174 	blvs	1cd8de0 <__bss_end+0x1ccfe7c>
     80c:	69616d2f 	stmdbvs	r1!, {r0, r1, r2, r3, r5, r8, sl, fp, sp, lr}^
     810:	70632e6e 	rsbvc	r2, r3, lr, ror #28
     814:	6e490070 	mcrvs	0, 2, r0, cr9, cr0, {3}
     818:	72726574 	rsbsvc	r6, r2, #116, 10	; 0x1d000000
     81c:	61747075 	cmnvs	r4, r5, ror r0
     820:	5f656c62 	svcpl	0x00656c62
     824:	65656c53 	strbvs	r6, [r5, #-3155]!	; 0xfffff3ad
     828:	6f620070 	svcvs	0x00620070
     82c:	6d006c6f 	stcvs	12, cr6, [r0, #-444]	; 0xfffffe44
     830:	7473614c 	ldrbtvc	r6, [r3], #-332	; 0xfffffeb4
     834:	4449505f 	strbmi	r5, [r9], #-95	; 0xffffffa1
     838:	6f6c4200 	svcvs	0x006c4200
     83c:	64656b63 	strbtvs	r6, [r5], #-2915	; 0xfffff49d
     840:	65474e00 	strbvs	r4, [r7, #-3584]	; 0xfffff200
     844:	63535f74 	cmpvs	r3, #116, 30	; 0x1d0
     848:	5f646568 	svcpl	0x00646568
     84c:	6f666e49 	svcvs	0x00666e49
     850:	7079545f 	rsbsvc	r5, r9, pc, asr r4
     854:	75520065 	ldrbvc	r0, [r2, #-101]	; 0xffffff9b
     858:	62616e6e 	rsbvs	r6, r1, #1760	; 0x6e0
     85c:	4e00656c 	cfsh32mi	mvfx6, mvfx0, #60
     860:	6b736154 	blvs	1cd8db8 <__bss_end+0x1ccfe54>
     864:	6174535f 	cmnvs	r4, pc, asr r3
     868:	73006574 	movwvc	r6, #1396	; 0x574
     86c:	6c5f736f 	mrrcvs	3, 6, r7, pc, cr15	; <UNPREDICTABLE>
     870:	73006465 	movwvc	r6, #1125	; 0x465
     874:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     878:	756f635f 	strbvc	r6, [pc, #-863]!	; 521 <shift+0x521>
     87c:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
     880:	68637300 	stmdavs	r3!, {r8, r9, ip, sp, lr}^
     884:	735f6465 	cmpvc	pc, #1694498816	; 0x65000000
     888:	69746174 	ldmdbvs	r4!, {r2, r4, r5, r6, r8, sp, lr}^
     88c:	72705f63 	rsbsvc	r5, r0, #396	; 0x18c
     890:	69726f69 	ldmdbvs	r2!, {r0, r3, r5, r6, r8, r9, sl, fp, sp, lr}^
     894:	65007974 	strvs	r7, [r0, #-2420]	; 0xfffff68c
     898:	5f746978 	svcpl	0x00746978
     89c:	65646f63 	strbvs	r6, [r4, #-3939]!	; 0xfffff09d
     8a0:	63536d00 	cmpvs	r3, #0, 26
     8a4:	75646568 	strbvc	r6, [r4, #-1384]!	; 0xfffffa98
     8a8:	465f656c 	ldrbmi	r6, [pc], -ip, ror #10
     8ac:	4700636e 	strmi	r6, [r0, -lr, ror #6]
     8b0:	5f4f4950 	svcpl	0x004f4950
     8b4:	65736142 	ldrbvs	r6, [r3, #-322]!	; 0xfffffebe
     8b8:	78614d00 	stmdavc	r1!, {r8, sl, fp, lr}^
     8bc:	72445346 	subvc	r5, r4, #402653185	; 0x18000001
     8c0:	72657669 	rsbvc	r7, r5, #110100480	; 0x6900000
     8c4:	656d614e 	strbvs	r6, [sp, #-334]!	; 0xfffffeb2
     8c8:	676e654c 	strbvs	r6, [lr, -ip, asr #10]!
     8cc:	4e006874 	mcrmi	8, 0, r6, cr0, cr4, {3}
     8d0:	6669746f 	strbtvs	r7, [r9], -pc, ror #8
     8d4:	65440079 	strbvs	r0, [r4, #-121]	; 0xffffff87
     8d8:	6c756166 	ldfvse	f6, [r5], #-408	; 0xfffffe68
     8dc:	6c435f74 	mcrrvs	15, 7, r5, r3, cr4
     8e0:	5f6b636f 	svcpl	0x006b636f
     8e4:	65746152 	ldrbvs	r6, [r4, #-338]!	; 0xfffffeae
     8e8:	636f4c00 	cmnvs	pc, #0, 24
     8ec:	6e555f6b 	cdpvs	15, 5, cr5, cr5, cr11, {3}
     8f0:	6b636f6c 	blvs	18dc6a8 <__bss_end+0x18d3744>
     8f4:	4c006465 	cfstrsmi	mvf6, [r0], {101}	; 0x65
     8f8:	5f6b636f 	svcpl	0x006b636f
     8fc:	6b636f4c 	blvs	18dc634 <__bss_end+0x18d36d0>
     900:	52006465 	andpl	r6, r0, #1694498816	; 0x65000000
     904:	5f646165 	svcpl	0x00646165
     908:	74697257 	strbtvc	r7, [r9], #-599	; 0xfffffda9
     90c:	6f5a0065 	svcvs	0x005a0065
     910:	6569626d 	strbvs	r6, [r9, #-621]!	; 0xfffffd93
     914:	6c656800 	stclvs	8, cr6, [r5], #-0
     918:	47006f6c 	strmi	r6, [r0, -ip, ror #30]
     91c:	535f7465 	cmppl	pc, #1694498816	; 0x65000000
     920:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     924:	666e495f 			; <UNDEFINED> instruction: 0x666e495f
     928:	5a5f006f 	bpl	17c0aec <__bss_end+0x17b7b88>
     92c:	4336314e 	teqmi	r6, #-2147483629	; 0x80000013
     930:	636f7250 	cmnvs	pc, #80, 4
     934:	5f737365 	svcpl	0x00737365
     938:	616e614d 	cmnvs	lr, sp, asr #2
     93c:	38726567 	ldmdacc	r2!, {r0, r1, r2, r5, r6, r8, sl, sp, lr}^
     940:	65686353 	strbvs	r6, [r8, #-851]!	; 0xfffffcad
     944:	656c7564 	strbvs	r7, [ip, #-1380]!	; 0xfffffa9c
     948:	5f007645 	svcpl	0x00007645
     94c:	36314e5a 			; <UNDEFINED> instruction: 0x36314e5a
     950:	6f725043 	svcvs	0x00725043
     954:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     958:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     95c:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     960:	614d3931 	cmpvs	sp, r1, lsr r9
     964:	69465f70 	stmdbvs	r6, {r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     968:	545f656c 	ldrbpl	r6, [pc], #-1388	; 970 <shift+0x970>
     96c:	75435f6f 	strbvc	r5, [r3, #-3951]	; 0xfffff091
     970:	6e657272 	mcrvs	2, 3, r7, cr5, cr2, {3}
     974:	35504574 	ldrbcc	r4, [r0, #-1396]	; 0xfffffa8c
     978:	6c694649 	stclvs	6, cr4, [r9], #-292	; 0xfffffedc
     97c:	614d0065 	cmpvs	sp, r5, rrx
     980:	74615078 	strbtvc	r5, [r1], #-120	; 0xffffff88
     984:	6e654c68 	cdpvs	12, 6, cr4, cr5, cr8, {3}
     988:	00687467 	rsbeq	r7, r8, r7, ror #8
     98c:	69736e75 	ldmdbvs	r3!, {r0, r2, r4, r5, r6, r9, sl, fp, sp, lr}^
     990:	64656e67 	strbtvs	r6, [r5], #-3687	; 0xfffff199
     994:	61686320 	cmnvs	r8, r0, lsr #6
     998:	79730072 	ldmdbvc	r3!, {r1, r4, r5, r6}^
     99c:	6c6f626d 	sfmvs	f6, 2, [pc], #-436	; 7f0 <shift+0x7f0>
     9a0:	6369745f 	cmnvs	r9, #1593835520	; 0x5f000000
     9a4:	65645f6b 	strbvs	r5, [r4, #-3947]!	; 0xfffff095
     9a8:	0079616c 	rsbseq	r6, r9, ip, ror #2
     9ac:	314e5a5f 	cmpcc	lr, pc, asr sl
     9b0:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     9b4:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     9b8:	614d5f73 	hvcvs	54771	; 0xd5f3
     9bc:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     9c0:	53323172 	teqpl	r2, #-2147483620	; 0x8000001c
     9c4:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     9c8:	5f656c75 	svcpl	0x00656c75
     9cc:	45464445 	strbmi	r4, [r6, #-1093]	; 0xfffffbbb
     9d0:	50470076 	subpl	r0, r7, r6, ror r0
     9d4:	505f4f49 	subspl	r4, pc, r9, asr #30
     9d8:	435f6e69 	cmpmi	pc, #1680	; 0x690
     9dc:	746e756f 	strbtvc	r7, [lr], #-1391	; 0xfffffa91
     9e0:	6f687300 	svcvs	0x00687300
     9e4:	69207472 	stmdbvs	r0!, {r1, r4, r5, r6, sl, ip, sp, lr}
     9e8:	4900746e 	stmdbmi	r0, {r1, r2, r3, r5, r6, sl, ip, sp, lr}
     9ec:	6c61766e 	stclvs	6, cr7, [r1], #-440	; 0xfffffe48
     9f0:	505f6469 	subspl	r6, pc, r9, ror #8
     9f4:	50006e69 	andpl	r6, r0, r9, ror #28
     9f8:	70697265 	rsbvc	r7, r9, r5, ror #4
     9fc:	61726568 	cmnvs	r2, r8, ror #10
     a00:	61425f6c 	cmpvs	r2, ip, ror #30
     a04:	52006573 	andpl	r6, r0, #482344960	; 0x1cc00000
     a08:	696e6e75 	stmdbvs	lr!, {r0, r2, r4, r5, r6, r9, sl, fp, sp, lr}^
     a0c:	7500676e 	strvc	r6, [r0, #-1902]	; 0xfffff892
     a10:	33746e69 	cmncc	r4, #1680	; 0x690
     a14:	00745f32 	rsbseq	r5, r4, r2, lsr pc
     a18:	7275436d 	rsbsvc	r4, r5, #-1275068415	; 0xb4000001
     a1c:	746e6572 	strbtvc	r6, [lr], #-1394	; 0xfffffa8e
     a20:	7361545f 	cmnvc	r1, #1593835520	; 0x5f000000
     a24:	6f4e5f6b 	svcvs	0x004e5f6b
     a28:	5f006564 	svcpl	0x00006564
     a2c:	6c62355a 	cfstr64vs	mvdx3, [r2], #-360	; 0xfffffe98
     a30:	626b6e69 	rsbvs	r6, fp, #1680	; 0x690
     a34:	75706300 	ldrbvc	r6, [r0, #-768]!	; 0xfffffd00
     a38:	6e6f635f 	mcrvs	3, 3, r6, cr15, cr15, {2}
     a3c:	74786574 	ldrbtvc	r6, [r8], #-1396	; 0xfffffa8c
     a40:	61655200 	cmnvs	r5, r0, lsl #4
     a44:	6e4f5f64 	cdpvs	15, 4, cr5, cr15, cr4, {3}
     a48:	7300796c 	movwvc	r7, #2412	; 0x96c
     a4c:	7065656c 	rsbvc	r6, r5, ip, ror #10
     a50:	6d69745f 	cfstrdvs	mvd7, [r9, #-380]!	; 0xfffffe84
     a54:	5f007265 	svcpl	0x00007265
     a58:	314b4e5a 	cmpcc	fp, sl, asr lr
     a5c:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     a60:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     a64:	614d5f73 	hvcvs	54771	; 0xd5f3
     a68:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     a6c:	47383172 			; <UNDEFINED> instruction: 0x47383172
     a70:	505f7465 	subspl	r7, pc, r5, ror #8
     a74:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     a78:	425f7373 	subsmi	r7, pc, #-872415231	; 0xcc000001
     a7c:	49505f79 	ldmdbmi	r0, {r0, r3, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     a80:	006a4544 	rsbeq	r4, sl, r4, asr #10
     a84:	646e6148 	strbtvs	r6, [lr], #-328	; 0xfffffeb8
     a88:	465f656c 	ldrbmi	r6, [pc], -ip, ror #10
     a8c:	73656c69 	cmnvc	r5, #26880	; 0x6900
     a90:	65747379 	ldrbvs	r7, [r4, #-889]!	; 0xfffffc87
     a94:	57535f6d 	ldrbpl	r5, [r3, -sp, ror #30]
     a98:	5a5f0049 	bpl	17c0bc4 <__bss_end+0x17b7c60>
     a9c:	4336314e 	teqmi	r6, #-2147483629	; 0x80000013
     aa0:	636f7250 	cmnvs	pc, #80, 4
     aa4:	5f737365 	svcpl	0x00737365
     aa8:	616e614d 	cmnvs	lr, sp, asr #2
     aac:	31726567 	cmncc	r2, r7, ror #10
     ab0:	68635331 	stmdavs	r3!, {r0, r4, r5, r8, r9, ip, lr}^
     ab4:	6c756465 	cfldrdvs	mvd6, [r5], #-404	; 0xfffffe6c
     ab8:	52525f65 	subspl	r5, r2, #404	; 0x194
     abc:	74007645 	strvc	r7, [r0], #-1605	; 0xfffff9bb
     ac0:	006b7361 	rsbeq	r7, fp, r1, ror #6
     ac4:	69746f4e 	ldmdbvs	r4!, {r1, r2, r3, r6, r8, r9, sl, fp, sp, lr}^
     ac8:	505f7966 	subspl	r7, pc, r6, ror #18
     acc:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     ad0:	53007373 	movwpl	r7, #883	; 0x373
     ad4:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     ad8:	00656c75 	rsbeq	r6, r5, r5, ror ip
     adc:	314e5a5f 	cmpcc	lr, pc, asr sl
     ae0:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     ae4:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     ae8:	614d5f73 	hvcvs	54771	; 0xd5f3
     aec:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     af0:	77533972 			; <UNDEFINED> instruction: 0x77533972
     af4:	68637469 	stmdavs	r3!, {r0, r3, r5, r6, sl, ip, sp, lr}^
     af8:	456f545f 	strbmi	r5, [pc, #-1119]!	; 6a1 <shift+0x6a1>
     afc:	43383150 	teqmi	r8, #80, 2
     b00:	636f7250 	cmnvs	pc, #80, 4
     b04:	5f737365 	svcpl	0x00737365
     b08:	7473694c 	ldrbtvc	r6, [r3], #-2380	; 0xfffff6b4
     b0c:	646f4e5f 	strbtvs	r4, [pc], #-3679	; b14 <shift+0xb14>
     b10:	63530065 	cmpvs	r3, #101	; 0x65
     b14:	75646568 	strbvc	r6, [r4, #-1384]!	; 0xfffffa98
     b18:	525f656c 	subspl	r6, pc, #108, 10	; 0x1b000000
     b1c:	5a5f0052 	bpl	17c0c6c <__bss_end+0x17b7d08>
     b20:	4336314e 	teqmi	r6, #-2147483629	; 0x80000013
     b24:	636f7250 	cmnvs	pc, #80, 4
     b28:	5f737365 	svcpl	0x00737365
     b2c:	616e614d 	cmnvs	lr, sp, asr #2
     b30:	31726567 	cmncc	r2, r7, ror #10
     b34:	6e614838 	mcrvs	8, 3, r4, cr1, cr8, {1}
     b38:	5f656c64 	svcpl	0x00656c64
     b3c:	636f7250 	cmnvs	pc, #80, 4
     b40:	5f737365 	svcpl	0x00737365
     b44:	45495753 	strbmi	r5, [r9, #-1875]	; 0xfffff8ad
     b48:	534e3032 	movtpl	r3, #57394	; 0xe032
     b4c:	505f4957 	subspl	r4, pc, r7, asr r9	; <UNPREDICTABLE>
     b50:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     b54:	535f7373 	cmppl	pc, #-872415231	; 0xcc000001
     b58:	69767265 	ldmdbvs	r6!, {r0, r2, r5, r6, r9, ip, sp, lr}^
     b5c:	6a6a6563 	bvs	1a9a0f0 <__bss_end+0x1a9118c>
     b60:	3131526a 	teqcc	r1, sl, ror #4
     b64:	49575354 	ldmdbmi	r7, {r2, r4, r6, r8, r9, ip, lr}^
     b68:	7365525f 	cmnvc	r5, #-268435451	; 0xf0000005
     b6c:	00746c75 	rsbseq	r6, r4, r5, ror ip
     b70:	76677261 	strbtvc	r7, [r7], -r1, ror #4
     b74:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     b78:	50433631 	subpl	r3, r3, r1, lsr r6
     b7c:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     b80:	4d5f7373 	ldclmi	3, cr7, [pc, #-460]	; 9bc <shift+0x9bc>
     b84:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
     b88:	34317265 	ldrtcc	r7, [r1], #-613	; 0xfffffd9b
     b8c:	61657243 	cmnvs	r5, r3, asr #4
     b90:	505f6574 	subspl	r6, pc, r4, ror r5	; <UNPREDICTABLE>
     b94:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     b98:	50457373 	subpl	r7, r5, r3, ror r3
     b9c:	00626a68 	rsbeq	r6, r2, r8, ror #20
     ba0:	74697753 	strbtvc	r7, [r9], #-1875	; 0xfffff8ad
     ba4:	545f6863 	ldrbpl	r6, [pc], #-2147	; bac <shift+0xbac>
     ba8:	534e006f 	movtpl	r0, #57455	; 0xe06f
     bac:	465f4957 			; <UNDEFINED> instruction: 0x465f4957
     bb0:	73656c69 	cmnvc	r5, #26880	; 0x6900
     bb4:	65747379 	ldrbvs	r7, [r4, #-889]!	; 0xfffffc87
     bb8:	65535f6d 	ldrbvs	r5, [r3, #-3949]	; 0xfffff093
     bbc:	63697672 	cmnvs	r9, #119537664	; 0x7200000
     bc0:	6e490065 	cdpvs	0, 4, cr0, cr9, cr5, {3}
     bc4:	696c6176 	stmdbvs	ip!, {r1, r2, r4, r5, r6, r8, sp, lr}^
     bc8:	61485f64 	cmpvs	r8, r4, ror #30
     bcc:	656c646e 	strbvs	r6, [ip, #-1134]!	; 0xfffffb92
     bd0:	6f6c4200 	svcvs	0x006c4200
     bd4:	435f6b63 	cmpmi	pc, #101376	; 0x18c00
     bd8:	65727275 	ldrbvs	r7, [r2, #-629]!	; 0xfffffd8b
     bdc:	505f746e 	subspl	r7, pc, lr, ror #8
     be0:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     be4:	43007373 	movwmi	r7, #883	; 0x373
     be8:	65736f6c 	ldrbvs	r6, [r3, #-3948]!	; 0xfffff094
     bec:	67726100 	ldrbvs	r6, [r2, -r0, lsl #2]!
     bf0:	61750063 	cmnvs	r5, r3, rrx
     bf4:	57007472 	smlsdxpl	r0, r2, r4, r7
     bf8:	65746972 	ldrbvs	r6, [r4, #-2418]!	; 0xfffff68e
     bfc:	6c6e4f5f 	stclvs	15, cr4, [lr], #-380	; 0xfffffe84
     c00:	616d0079 	smcvs	53257	; 0xd009
     c04:	59006e69 	stmdbpl	r0, {r0, r3, r5, r6, r9, sl, fp, sp, lr}
     c08:	646c6569 	strbtvs	r6, [ip], #-1385	; 0xfffffa97
     c0c:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     c10:	50433631 	subpl	r3, r3, r1, lsr r6
     c14:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     c18:	4d5f7373 	ldclmi	3, cr7, [pc, #-460]	; a54 <shift+0xa54>
     c1c:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
     c20:	34437265 	strbcc	r7, [r3], #-613	; 0xfffffd9b
     c24:	54007645 	strpl	r7, [r0], #-1605	; 0xfffff9bb
     c28:	696d7265 	stmdbvs	sp!, {r0, r2, r5, r6, r9, ip, sp, lr}^
     c2c:	6574616e 	ldrbvs	r6, [r4, #-366]!	; 0xfffffe92
     c30:	434f4900 	movtmi	r4, #63744	; 0xf900
     c34:	2f006c74 	svccs	0x00006c74
     c38:	72657355 	rsbvc	r7, r5, #1409286145	; 0x54000001
     c3c:	69772f73 	ldmdbvs	r7!, {r0, r1, r4, r5, r6, r8, r9, sl, fp, sp}^
     c40:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
     c44:	442f696a 	strtmi	r6, [pc], #-2410	; c4c <shift+0xc4c>
     c48:	746b7365 	strbtvc	r7, [fp], #-869	; 0xfffffc9b
     c4c:	462f706f 	strtmi	r7, [pc], -pc, rrx
     c50:	4e2f5641 	cfmadda32mi	mvax2, mvax5, mvfx15, mvfx1
     c54:	7a617661 	bvc	185e5e0 <__bss_end+0x185567c>
     c58:	63696a75 	cmnvs	r9, #479232	; 0x75000
     c5c:	534f2f69 	movtpl	r2, #65385	; 0xff69
     c60:	6d65732f 	stclvs	3, cr7, [r5, #-188]!	; 0xffffff44
     c64:	72747365 	rsbsvc	r7, r4, #-1811939327	; 0x94000001
     c68:	616b6c61 	cmnvs	fp, r1, ror #24
     c6c:	76696b2d 	strbtvc	r6, [r9], -sp, lsr #22
     c70:	2f736f2d 	svccs	0x00736f2d
     c74:	72756f73 	rsbsvc	r6, r5, #460	; 0x1cc
     c78:	2f736563 	svccs	0x00736563
     c7c:	6c697562 	cfstr64vs	mvdx7, [r9], #-392	; 0xfffffe78
     c80:	6c630064 	stclvs	0, cr0, [r3], #-400	; 0xfffffe70
     c84:	0065736f 	rsbeq	r7, r5, pc, ror #6
     c88:	5f746553 	svcpl	0x00746553
     c8c:	616c6552 	cmnvs	ip, r2, asr r5
     c90:	65766974 	ldrbvs	r6, [r6, #-2420]!	; 0xfffff68c
     c94:	74657200 	strbtvc	r7, [r5], #-512	; 0xfffffe00
     c98:	006c6176 	rsbeq	r6, ip, r6, ror r1
     c9c:	7275636e 	rsbsvc	r6, r5, #-1207959551	; 0xb8000001
     ca0:	70697000 	rsbvc	r7, r9, r0
     ca4:	64720065 	ldrbtvs	r0, [r2], #-101	; 0xffffff9b
     ca8:	006d756e 	rsbeq	r7, sp, lr, ror #10
     cac:	31315a5f 	teqcc	r1, pc, asr sl
     cb0:	65686373 	strbvs	r6, [r8, #-883]!	; 0xfffffc8d
     cb4:	69795f64 	ldmdbvs	r9!, {r2, r5, r6, r8, r9, sl, fp, ip, lr}^
     cb8:	76646c65 	strbtvc	r6, [r4], -r5, ror #24
     cbc:	315a5f00 	cmpcc	sl, r0, lsl #30
     cc0:	74657337 	strbtvc	r7, [r5], #-823	; 0xfffffcc9
     cc4:	7361745f 	cmnvc	r1, #1593835520	; 0x5f000000
     cc8:	65645f6b 	strbvs	r5, [r4, #-3947]!	; 0xfffff095
     ccc:	696c6461 	stmdbvs	ip!, {r0, r5, r6, sl, sp, lr}^
     cd0:	006a656e 	rsbeq	r6, sl, lr, ror #10
     cd4:	74696177 	strbtvc	r6, [r9], #-375	; 0xfffffe89
     cd8:	365a5f00 	ldrbcc	r5, [sl], -r0, lsl #30
     cdc:	69746f6e 	ldmdbvs	r4!, {r1, r2, r3, r5, r6, r8, r9, sl, fp, sp, lr}^
     ce0:	6a6a7966 	bvs	1a9f280 <__bss_end+0x1a9631c>
     ce4:	69614600 	stmdbvs	r1!, {r9, sl, lr}^
     ce8:	7865006c 	stmdavc	r5!, {r2, r3, r5, r6}^
     cec:	6f637469 	svcvs	0x00637469
     cf0:	73006564 	movwvc	r6, #1380	; 0x564
     cf4:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     cf8:	6569795f 	strbvs	r7, [r9, #-2399]!	; 0xfffff6a1
     cfc:	7400646c 	strvc	r6, [r0], #-1132	; 0xfffffb94
     d00:	5f6b6369 	svcpl	0x006b6369
     d04:	6e756f63 	cdpvs	15, 7, cr6, cr5, cr3, {3}
     d08:	65725f74 	ldrbvs	r5, [r2, #-3956]!	; 0xfffff08c
     d0c:	72697571 	rsbvc	r7, r9, #473956352	; 0x1c400000
     d10:	5f006465 	svcpl	0x00006465
     d14:	6734325a 			; <UNDEFINED> instruction: 0x6734325a
     d18:	615f7465 	cmpvs	pc, r5, ror #8
     d1c:	76697463 	strbtvc	r7, [r9], -r3, ror #8
     d20:	72705f65 	rsbsvc	r5, r0, #404	; 0x194
     d24:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     d28:	6f635f73 	svcvs	0x00635f73
     d2c:	76746e75 			; <UNDEFINED> instruction: 0x76746e75
     d30:	70695000 	rsbvc	r5, r9, r0
     d34:	69465f65 	stmdbvs	r6, {r0, r2, r5, r6, r8, r9, sl, fp, ip, lr}^
     d38:	505f656c 	subspl	r6, pc, ip, ror #10
     d3c:	69666572 	stmdbvs	r6!, {r1, r4, r5, r6, r8, sl, sp, lr}^
     d40:	65530078 	ldrbvs	r0, [r3, #-120]	; 0xffffff88
     d44:	61505f74 	cmpvs	r0, r4, ror pc
     d48:	736d6172 	cmnvc	sp, #-2147483620	; 0x8000001c
     d4c:	315a5f00 	cmpcc	sl, r0, lsl #30
     d50:	74656734 	strbtvc	r6, [r5], #-1844	; 0xfffff8cc
     d54:	6369745f 	cmnvs	r9, #1593835520	; 0x5f000000
     d58:	6f635f6b 	svcvs	0x00635f6b
     d5c:	76746e75 			; <UNDEFINED> instruction: 0x76746e75
     d60:	656c7300 	strbvs	r7, [ip, #-768]!	; 0xfffffd00
     d64:	44007065 	strmi	r7, [r0], #-101	; 0xffffff9b
     d68:	62617369 	rsbvs	r7, r1, #-1543503871	; 0xa4000001
     d6c:	455f656c 	ldrbmi	r6, [pc, #-1388]	; 808 <shift+0x808>
     d70:	746e6576 	strbtvc	r6, [lr], #-1398	; 0xfffffa8a
     d74:	7465445f 	strbtvc	r4, [r5], #-1119	; 0xfffffba1
     d78:	69746365 	ldmdbvs	r4!, {r0, r2, r5, r6, r8, r9, sp, lr}^
     d7c:	5f006e6f 	svcpl	0x00006e6f
     d80:	6574395a 	ldrbvs	r3, [r4, #-2394]!	; 0xfffff6a6
     d84:	6e696d72 	mcrvs	13, 3, r6, cr9, cr2, {3}
     d88:	69657461 	stmdbvs	r5!, {r0, r5, r6, sl, ip, sp, lr}^
     d8c:	65706f00 	ldrbvs	r6, [r0, #-3840]!	; 0xfffff100
     d90:	69746172 	ldmdbvs	r4!, {r1, r4, r5, r6, r8, sp, lr}^
     d94:	5f006e6f 	svcpl	0x00006e6f
     d98:	6c63355a 	cfstr64vs	mvdx3, [r3], #-360	; 0xfffffe98
     d9c:	6a65736f 	bvs	195db60 <__bss_end+0x1954bfc>
     da0:	365a5f00 	ldrbcc	r5, [sl], -r0, lsl #30
     da4:	70746567 	rsbsvc	r6, r4, r7, ror #10
     da8:	00766469 	rsbseq	r6, r6, r9, ror #8
     dac:	6d616e66 	stclvs	14, cr6, [r1, #-408]!	; 0xfffffe68
     db0:	72770065 	rsbsvc	r0, r7, #101	; 0x65
     db4:	00657469 	rsbeq	r7, r5, r9, ror #8
     db8:	6b636974 	blvs	18db390 <__bss_end+0x18d242c>
     dbc:	706f0073 	rsbvc	r0, pc, r3, ror r0	; <UNPREDICTABLE>
     dc0:	5f006e65 	svcpl	0x00006e65
     dc4:	6970345a 	ldmdbvs	r0!, {r1, r3, r4, r6, sl, ip, sp}^
     dc8:	4b506570 	blmi	141a390 <__bss_end+0x141142c>
     dcc:	4e006a63 	vmlsmi.f32	s12, s0, s7
     dd0:	64616544 	strbtvs	r6, [r1], #-1348	; 0xfffffabc
     dd4:	656e696c 	strbvs	r6, [lr, #-2412]!	; 0xfffff694
     dd8:	6275535f 	rsbsvs	r5, r5, #2080374785	; 0x7c000001
     ddc:	76726573 			; <UNDEFINED> instruction: 0x76726573
     de0:	00656369 	rsbeq	r6, r5, r9, ror #6
     de4:	5f746567 	svcpl	0x00746567
     de8:	6b636974 	blvs	18db3c0 <__bss_end+0x18d245c>
     dec:	756f635f 	strbvc	r6, [pc, #-863]!	; a95 <shift+0xa95>
     df0:	7000746e 	andvc	r7, r0, lr, ror #8
     df4:	6d617261 	sfmvs	f7, 2, [r1, #-388]!	; 0xfffffe7c
     df8:	355a5f00 	ldrbcc	r5, [sl, #-3840]	; 0xfffff100
     dfc:	74697277 	strbtvc	r7, [r9], #-631	; 0xfffffd89
     e00:	4b506a65 	blmi	141b79c <__bss_end+0x1412838>
     e04:	67006a63 	strvs	r6, [r0, -r3, ror #20]
     e08:	745f7465 	ldrbvc	r7, [pc], #-1125	; e10 <shift+0xe10>
     e0c:	5f6b7361 	svcpl	0x006b7361
     e10:	6b636974 	blvs	18db3e8 <__bss_end+0x18d2484>
     e14:	6f745f73 	svcvs	0x00745f73
     e18:	6165645f 	cmnvs	r5, pc, asr r4
     e1c:	6e696c64 	cdpvs	12, 6, cr6, cr9, cr4, {3}
     e20:	75620065 	strbvc	r0, [r2, #-101]!	; 0xffffff9b
     e24:	69735f66 	ldmdbvs	r3!, {r1, r2, r5, r6, r8, r9, sl, fp, ip, lr}^
     e28:	7300657a 	movwvc	r6, #1402	; 0x57a
     e2c:	745f7465 	ldrbvc	r7, [pc], #-1125	; e34 <shift+0xe34>
     e30:	5f6b7361 	svcpl	0x006b7361
     e34:	64616564 	strbtvs	r6, [r1], #-1380	; 0xfffffa9c
     e38:	656e696c 	strbvs	r6, [lr, #-2412]!	; 0xfffff694
     e3c:	74654700 	strbtvc	r4, [r5], #-1792	; 0xfffff900
     e40:	7261505f 	rsbvc	r5, r1, #95	; 0x5f
     e44:	00736d61 	rsbseq	r6, r3, r1, ror #26
     e48:	6573552f 	ldrbvs	r5, [r3, #-1327]!	; 0xfffffad1
     e4c:	772f7372 			; <UNDEFINED> instruction: 0x772f7372
     e50:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
     e54:	2f696a72 	svccs	0x00696a72
     e58:	6b736544 	blvs	1cda370 <__bss_end+0x1cd140c>
     e5c:	2f706f74 	svccs	0x00706f74
     e60:	2f564146 	svccs	0x00564146
     e64:	6176614e 	cmnvs	r6, lr, asr #2
     e68:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
     e6c:	4f2f6963 	svcmi	0x002f6963
     e70:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
     e74:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
     e78:	6b6c6172 	blvs	1b19448 <__bss_end+0x1b104e4>
     e7c:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
     e80:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
     e84:	756f732f 	strbvc	r7, [pc, #-815]!	; b5d <shift+0xb5d>
     e88:	73656372 	cmnvc	r5, #-939524095	; 0xc8000001
     e8c:	6474732f 	ldrbtvs	r7, [r4], #-815	; 0xfffffcd1
     e90:	2f62696c 	svccs	0x0062696c
     e94:	2f637273 	svccs	0x00637273
     e98:	66647473 			; <UNDEFINED> instruction: 0x66647473
     e9c:	2e656c69 	cdpcs	12, 6, cr6, cr5, cr9, {3}
     ea0:	00707063 	rsbseq	r7, r0, r3, rrx
     ea4:	73355a5f 	teqvc	r5, #389120	; 0x5f000
     ea8:	7065656c 	rsbvc	r6, r5, ip, ror #10
     eac:	66006a6a 	strvs	r6, [r0], -sl, ror #20
     eb0:	00656c69 	rsbeq	r6, r5, r9, ror #24
     eb4:	5f746547 	svcpl	0x00746547
     eb8:	616d6552 	cmnvs	sp, r2, asr r5
     ebc:	6e696e69 	cdpvs	14, 6, cr6, cr9, cr9, {3}
     ec0:	6e450067 	cdpvs	0, 4, cr0, cr5, cr7, {3}
     ec4:	656c6261 	strbvs	r6, [ip, #-609]!	; 0xfffffd9f
     ec8:	6576455f 	ldrbvs	r4, [r6, #-1375]!	; 0xfffffaa1
     ecc:	445f746e 	ldrbmi	r7, [pc], #-1134	; ed4 <shift+0xed4>
     ed0:	63657465 	cmnvs	r5, #1694498816	; 0x65000000
     ed4:	6e6f6974 			; <UNDEFINED> instruction: 0x6e6f6974
     ed8:	325a5f00 	subscc	r5, sl, #0, 30
     edc:	74656736 	strbtvc	r6, [r5], #-1846	; 0xfffff8ca
     ee0:	7361745f 	cmnvc	r1, #1593835520	; 0x5f000000
     ee4:	69745f6b 	ldmdbvs	r4!, {r0, r1, r3, r5, r6, r8, r9, sl, fp, ip, lr}^
     ee8:	5f736b63 	svcpl	0x00736b63
     eec:	645f6f74 	ldrbvs	r6, [pc], #-3956	; ef4 <shift+0xef4>
     ef0:	6c646165 	stfvse	f6, [r4], #-404	; 0xfffffe6c
     ef4:	76656e69 	strbtvc	r6, [r5], -r9, ror #28
     ef8:	57534e00 	ldrbpl	r4, [r3, -r0, lsl #28]
     efc:	65525f49 	ldrbvs	r5, [r2, #-3913]	; 0xfffff0b7
     f00:	746c7573 	strbtvc	r7, [ip], #-1395	; 0xfffffa8d
     f04:	646f435f 	strbtvs	r4, [pc], #-863	; f0c <shift+0xf0c>
     f08:	72770065 	rsbsvc	r0, r7, #101	; 0x65
     f0c:	006d756e 	rsbeq	r7, sp, lr, ror #10
     f10:	77345a5f 			; <UNDEFINED> instruction: 0x77345a5f
     f14:	6a746961 	bvs	1d1b4a0 <__bss_end+0x1d1253c>
     f18:	5f006a6a 	svcpl	0x00006a6a
     f1c:	6f69355a 	svcvs	0x0069355a
     f20:	6a6c7463 	bvs	1b1e0b4 <__bss_end+0x1b15150>
     f24:	494e3631 	stmdbmi	lr, {r0, r4, r5, r9, sl, ip, sp}^
     f28:	6c74434f 	ldclvs	3, cr4, [r4], #-316	; 0xfffffec4
     f2c:	65704f5f 	ldrbvs	r4, [r0, #-3935]!	; 0xfffff0a1
     f30:	69746172 	ldmdbvs	r4!, {r1, r4, r5, r6, r8, sp, lr}^
     f34:	76506e6f 	ldrbvc	r6, [r0], -pc, ror #28
     f38:	636f6900 	cmnvs	pc, #0, 18
     f3c:	72006c74 	andvc	r6, r0, #116, 24	; 0x7400
     f40:	6e637465 	cdpvs	4, 6, cr7, cr3, cr5, {3}
     f44:	6f6e0074 	svcvs	0x006e0074
     f48:	79666974 	stmdbvc	r6!, {r2, r4, r5, r6, r8, fp, sp, lr}^
     f4c:	72657400 	rsbvc	r7, r5, #0, 8
     f50:	616e696d 	cmnvs	lr, sp, ror #18
     f54:	6d006574 	cfstr32vs	mvfx6, [r0, #-464]	; 0xfffffe30
     f58:	0065646f 	rsbeq	r6, r5, pc, ror #8
     f5c:	66667562 	strbtvs	r7, [r6], -r2, ror #10
     f60:	5f007265 	svcpl	0x00007265
     f64:	6572345a 	ldrbvs	r3, [r2, #-1114]!	; 0xfffffba6
     f68:	506a6461 	rsbpl	r6, sl, r1, ror #8
     f6c:	47006a63 	strmi	r6, [r0, -r3, ror #20]
     f70:	4320554e 			; <UNDEFINED> instruction: 0x4320554e
     f74:	34312b2b 	ldrtcc	r2, [r1], #-2859	; 0xfffff4d5
     f78:	2e303120 	rsfcssp	f3, f0, f0
     f7c:	20312e33 	eorscs	r2, r1, r3, lsr lr
     f80:	31323032 	teqcc	r2, r2, lsr r0
     f84:	34323830 	ldrtcc	r3, [r2], #-2096	; 0xfffff7d0
     f88:	65722820 	ldrbvs	r2, [r2, #-2080]!	; 0xfffff7e0
     f8c:	7361656c 	cmnvc	r1, #108, 10	; 0x1b000000
     f90:	2d202965 			; <UNDEFINED> instruction: 0x2d202965
     f94:	6f6c666d 	svcvs	0x006c666d
     f98:	612d7461 			; <UNDEFINED> instruction: 0x612d7461
     f9c:	683d6962 	ldmdavs	sp!, {r1, r5, r6, r8, fp, sp, lr}
     fa0:	20647261 	rsbcs	r7, r4, r1, ror #4
     fa4:	70666d2d 	rsbvc	r6, r6, sp, lsr #26
     fa8:	66763d75 			; <UNDEFINED> instruction: 0x66763d75
     fac:	6d2d2070 	stcvs	0, cr2, [sp, #-448]!	; 0xfffffe40
     fb0:	616f6c66 	cmnvs	pc, r6, ror #24
     fb4:	62612d74 	rsbvs	r2, r1, #116, 26	; 0x1d00
     fb8:	61683d69 	cmnvs	r8, r9, ror #26
     fbc:	2d206472 	cfstrscs	mvf6, [r0, #-456]!	; 0xfffffe38
     fc0:	7570666d 	ldrbvc	r6, [r0, #-1645]!	; 0xfffff993
     fc4:	7066763d 	rsbvc	r7, r6, sp, lsr r6
     fc8:	746d2d20 	strbtvc	r2, [sp], #-3360	; 0xfffff2e0
     fcc:	3d656e75 	stclcc	14, cr6, [r5, #-468]!	; 0xfffffe2c
     fd0:	316d7261 	cmncc	sp, r1, ror #4
     fd4:	6a363731 	bvs	d8eca0 <__bss_end+0xd85d3c>
     fd8:	732d667a 			; <UNDEFINED> instruction: 0x732d667a
     fdc:	616d2d20 	cmnvs	sp, r0, lsr #26
     fe0:	2d206d72 	stccs	13, cr6, [r0, #-456]!	; 0xfffffe38
     fe4:	6372616d 	cmnvs	r2, #1073741851	; 0x4000001b
     fe8:	72613d68 	rsbvc	r3, r1, #104, 26	; 0x1a00
     fec:	7a36766d 	bvc	d9e9a8 <__bss_end+0xd95a44>
     ff0:	70662b6b 	rsbvc	r2, r6, fp, ror #22
     ff4:	20672d20 	rsbcs	r2, r7, r0, lsr #26
     ff8:	2d20672d 	stccs	7, cr6, [r0, #-180]!	; 0xffffff4c
     ffc:	4f2d2067 	svcmi	0x002d2067
    1000:	4f2d2030 	svcmi	0x002d2030
    1004:	662d2030 			; <UNDEFINED> instruction: 0x662d2030
    1008:	652d6f6e 	strvs	r6, [sp, #-3950]!	; 0xfffff092
    100c:	70656378 	rsbvc	r6, r5, r8, ror r3
    1010:	6e6f6974 			; <UNDEFINED> instruction: 0x6e6f6974
    1014:	662d2073 			; <UNDEFINED> instruction: 0x662d2073
    1018:	722d6f6e 	eorvc	r6, sp, #440	; 0x1b8
    101c:	00697474 	rsbeq	r7, r9, r4, ror r4
    1020:	434f494e 	movtmi	r4, #63822	; 0xf94e
    1024:	4f5f6c74 	svcmi	0x005f6c74
    1028:	61726570 	cmnvs	r2, r0, ror r5
    102c:	6e6f6974 			; <UNDEFINED> instruction: 0x6e6f6974
    1030:	74657200 	strbtvc	r7, [r5], #-512	; 0xfffffe00
    1034:	65646f63 	strbvs	r6, [r4, #-3939]!	; 0xfffff09d
    1038:	74656700 	strbtvc	r6, [r5], #-1792	; 0xfffff900
    103c:	7463615f 	strbtvc	r6, [r3], #-351	; 0xfffffea1
    1040:	5f657669 	svcpl	0x00657669
    1044:	636f7270 	cmnvs	pc, #112, 4
    1048:	5f737365 	svcpl	0x00737365
    104c:	6e756f63 	cdpvs	15, 7, cr6, cr5, cr3, {3}
    1050:	69660074 	stmdbvs	r6!, {r2, r4, r5, r6}^
    1054:	616e656c 	cmnvs	lr, ip, ror #10
    1058:	7200656d 	andvc	r6, r0, #457179136	; 0x1b400000
    105c:	00646165 	rsbeq	r6, r4, r5, ror #2
    1060:	70746567 	rsbsvc	r6, r4, r7, ror #10
    1064:	5f006469 	svcpl	0x00006469
    1068:	706f345a 	rsbvc	r3, pc, sl, asr r4	; <UNPREDICTABLE>
    106c:	4b506e65 	blmi	141ca08 <__bss_end+0x1413aa4>
    1070:	4e353163 	rsfmisz	f3, f5, f3
    1074:	656c6946 	strbvs	r6, [ip, #-2374]!	; 0xfffff6ba
    1078:	65704f5f 	ldrbvs	r4, [r0, #-3935]!	; 0xfffff0a1
    107c:	6f4d5f6e 	svcvs	0x004d5f6e
    1080:	69006564 	stmdbvs	r0, {r2, r5, r6, r8, sl, sp, lr}
    1084:	7475706e 	ldrbtvc	r7, [r5], #-110	; 0xffffff92
    1088:	73656400 	cmnvc	r5, #0, 8
    108c:	7a620074 	bvc	1881264 <__bss_end+0x1878300>
    1090:	006f7265 	rsbeq	r7, pc, r5, ror #4
    1094:	676e656c 	strbvs	r6, [lr, -ip, ror #10]!
    1098:	5f006874 	svcpl	0x00006874
    109c:	7a62355a 	bvc	188e60c <__bss_end+0x18856a8>
    10a0:	506f7265 	rsbpl	r7, pc, r5, ror #4
    10a4:	2f006976 	svccs	0x00006976
    10a8:	72657355 	rsbvc	r7, r5, #1409286145	; 0x54000001
    10ac:	69772f73 	ldmdbvs	r7!, {r0, r1, r4, r5, r6, r8, r9, sl, fp, sp}^
    10b0:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
    10b4:	442f696a 	strtmi	r6, [pc], #-2410	; 10bc <shift+0x10bc>
    10b8:	746b7365 	strbtvc	r7, [fp], #-869	; 0xfffffc9b
    10bc:	462f706f 	strtmi	r7, [pc], -pc, rrx
    10c0:	4e2f5641 	cfmadda32mi	mvax2, mvax5, mvfx15, mvfx1
    10c4:	7a617661 	bvc	185ea50 <__bss_end+0x1855aec>
    10c8:	63696a75 	cmnvs	r9, #479232	; 0x75000
    10cc:	534f2f69 	movtpl	r2, #65385	; 0xff69
    10d0:	6d65732f 	stclvs	3, cr7, [r5, #-188]!	; 0xffffff44
    10d4:	72747365 	rsbsvc	r7, r4, #-1811939327	; 0x94000001
    10d8:	616b6c61 	cmnvs	fp, r1, ror #24
    10dc:	76696b2d 	strbtvc	r6, [r9], -sp, lsr #22
    10e0:	2f736f2d 	svccs	0x00736f2d
    10e4:	72756f73 	rsbsvc	r6, r5, #460	; 0x1cc
    10e8:	2f736563 	svccs	0x00736563
    10ec:	6c647473 	cfstrdvs	mvd7, [r4], #-460	; 0xfffffe34
    10f0:	732f6269 			; <UNDEFINED> instruction: 0x732f6269
    10f4:	732f6372 			; <UNDEFINED> instruction: 0x732f6372
    10f8:	74736474 	ldrbtvc	r6, [r3], #-1140	; 0xfffffb8c
    10fc:	676e6972 			; <UNDEFINED> instruction: 0x676e6972
    1100:	7070632e 	rsbsvc	r6, r0, lr, lsr #6
    1104:	345a5f00 	ldrbcc	r5, [sl], #-3840	; 0xfffff100
    1108:	696f7461 	stmdbvs	pc!, {r0, r5, r6, sl, ip, sp, lr}^	; <UNPREDICTABLE>
    110c:	00634b50 	rsbeq	r4, r3, r0, asr fp
    1110:	72616843 	rsbvc	r6, r1, #4390912	; 0x430000
    1114:	766e6f43 	strbtvc	r6, [lr], -r3, asr #30
    1118:	00727241 	rsbseq	r7, r2, r1, asr #4
    111c:	646d656d 	strbtvs	r6, [sp], #-1389	; 0xfffffa93
    1120:	6f007473 	svcvs	0x00007473
    1124:	75707475 	ldrbvc	r7, [r0, #-1141]!	; 0xfffffb8b
    1128:	5a5f0074 	bpl	17c1300 <__bss_end+0x17b839c>
    112c:	6d656d36 	stclvs	13, cr6, [r5, #-216]!	; 0xffffff28
    1130:	50797063 	rsbspl	r7, r9, r3, rrx
    1134:	7650764b 	ldrbvc	r7, [r0], -fp, asr #12
    1138:	61620069 	cmnvs	r2, r9, rrx
    113c:	6d006573 	cfstr32vs	mvfx6, [r0, #-460]	; 0xfffffe34
    1140:	70636d65 	rsbvc	r6, r3, r5, ror #26
    1144:	74730079 	ldrbtvc	r0, [r3], #-121	; 0xffffff87
    1148:	6e656c72 	mcrvs	12, 3, r6, cr5, cr2, {3}
    114c:	375a5f00 	ldrbcc	r5, [sl, -r0, lsl #30]
    1150:	6e727473 	mrcvs	4, 3, r7, cr2, cr3, {3}
    1154:	50706d63 	rsbspl	r6, r0, r3, ror #26
    1158:	3053634b 	subscc	r6, r3, fp, asr #6
    115c:	5f00695f 	svcpl	0x0000695f
    1160:	7473365a 	ldrbtvc	r3, [r3], #-1626	; 0xfffff9a6
    1164:	6e656c72 	mcrvs	12, 3, r6, cr5, cr2, {3}
    1168:	00634b50 	rsbeq	r4, r3, r0, asr fp
    116c:	696f7461 	stmdbvs	pc!, {r0, r5, r6, sl, ip, sp, lr}^	; <UNPREDICTABLE>
    1170:	375a5f00 	ldrbcc	r5, [sl, -r0, lsl #30]
    1174:	6e727473 	mrcvs	4, 3, r7, cr2, cr3, {3}
    1178:	50797063 	rsbspl	r7, r9, r3, rrx
    117c:	634b5063 	movtvs	r5, #45155	; 0xb063
    1180:	74730069 	ldrbtvc	r0, [r3], #-105	; 0xffffff97
    1184:	6d636e72 	stclvs	14, cr6, [r3, #-456]!	; 0xfffffe38
    1188:	74730070 	ldrbtvc	r0, [r3], #-112	; 0xffffff90
    118c:	70636e72 	rsbvc	r6, r3, r2, ror lr
    1190:	656d0079 	strbvs	r0, [sp, #-121]!	; 0xffffff87
    1194:	79726f6d 	ldmdbvc	r2!, {r0, r2, r3, r5, r6, r8, r9, sl, fp, sp, lr}^
    1198:	6d656d00 	stclvs	13, cr6, [r5, #-0]
    119c:	00637273 	rsbeq	r7, r3, r3, ror r2
    11a0:	616f7469 	cmnvs	pc, r9, ror #8
    11a4:	345a5f00 	ldrbcc	r5, [sl], #-3840	; 0xfffff100
    11a8:	616f7469 	cmnvs	pc, r9, ror #8
    11ac:	6a63506a 	bvs	18d535c <__bss_end+0x18cc3f8>
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
  20:	8b040e42 	blhi	103930 <__bss_end+0xfa9cc>
  24:	0b0d4201 	bleq	350830 <__bss_end+0x3478cc>
  28:	420d0d62 	andmi	r0, sp, #6272	; 0x1880
  2c:	00000ecb 	andeq	r0, r0, fp, asr #29
  30:	0000001c 	andeq	r0, r0, ip, lsl r0
  34:	00000000 	andeq	r0, r0, r0
  38:	00008064 	andeq	r8, r0, r4, rrx
  3c:	00000040 	andeq	r0, r0, r0, asr #32
  40:	8b080e42 	blhi	203950 <__bss_end+0x1fa9ec>
  44:	42018e02 	andmi	r8, r1, #2, 28
  48:	5a040b0c 	bpl	102c80 <__bss_end+0xf9d1c>
  4c:	00080d0c 	andeq	r0, r8, ip, lsl #26
  50:	0000000c 	andeq	r0, r0, ip
  54:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
  58:	7c020001 	stcvc	0, cr0, [r2], {1}
  5c:	000d0c0e 	andeq	r0, sp, lr, lsl #24
  60:	0000001c 	andeq	r0, r0, ip, lsl r0
  64:	00000050 	andeq	r0, r0, r0, asr r0
  68:	000080a4 	andeq	r8, r0, r4, lsr #1
  6c:	00000038 	andeq	r0, r0, r8, lsr r0
  70:	8b040e42 	blhi	103980 <__bss_end+0xfaa1c>
  74:	0b0d4201 	bleq	350880 <__bss_end+0x34791c>
  78:	420d0d54 	andmi	r0, sp, #84, 26	; 0x1500
  7c:	00000ecb 	andeq	r0, r0, fp, asr #29
  80:	0000001c 	andeq	r0, r0, ip, lsl r0
  84:	00000050 	andeq	r0, r0, r0, asr r0
  88:	000080dc 	ldrdeq	r8, [r0], -ip
  8c:	0000002c 	andeq	r0, r0, ip, lsr #32
  90:	8b040e42 	blhi	1039a0 <__bss_end+0xfaa3c>
  94:	0b0d4201 	bleq	3508a0 <__bss_end+0x34793c>
  98:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
  9c:	00000ecb 	andeq	r0, r0, fp, asr #29
  a0:	0000001c 	andeq	r0, r0, ip, lsl r0
  a4:	00000050 	andeq	r0, r0, r0, asr r0
  a8:	00008108 	andeq	r8, r0, r8, lsl #2
  ac:	00000020 	andeq	r0, r0, r0, lsr #32
  b0:	8b040e42 	blhi	1039c0 <__bss_end+0xfaa5c>
  b4:	0b0d4201 	bleq	3508c0 <__bss_end+0x34795c>
  b8:	420d0d48 	andmi	r0, sp, #72, 26	; 0x1200
  bc:	00000ecb 	andeq	r0, r0, fp, asr #29
  c0:	0000001c 	andeq	r0, r0, ip, lsl r0
  c4:	00000050 	andeq	r0, r0, r0, asr r0
  c8:	00008128 	andeq	r8, r0, r8, lsr #2
  cc:	00000018 	andeq	r0, r0, r8, lsl r0
  d0:	8b040e42 	blhi	1039e0 <__bss_end+0xfaa7c>
  d4:	0b0d4201 	bleq	3508e0 <__bss_end+0x34797c>
  d8:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
  dc:	00000ecb 	andeq	r0, r0, fp, asr #29
  e0:	0000001c 	andeq	r0, r0, ip, lsl r0
  e4:	00000050 	andeq	r0, r0, r0, asr r0
  e8:	00008140 	andeq	r8, r0, r0, asr #2
  ec:	00000018 	andeq	r0, r0, r8, lsl r0
  f0:	8b040e42 	blhi	103a00 <__bss_end+0xfaa9c>
  f4:	0b0d4201 	bleq	350900 <__bss_end+0x34799c>
  f8:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
  fc:	00000ecb 	andeq	r0, r0, fp, asr #29
 100:	0000001c 	andeq	r0, r0, ip, lsl r0
 104:	00000050 	andeq	r0, r0, r0, asr r0
 108:	00008158 	andeq	r8, r0, r8, asr r1
 10c:	00000018 	andeq	r0, r0, r8, lsl r0
 110:	8b040e42 	blhi	103a20 <__bss_end+0xfaabc>
 114:	0b0d4201 	bleq	350920 <__bss_end+0x3479bc>
 118:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
 11c:	00000ecb 	andeq	r0, r0, fp, asr #29
 120:	00000014 	andeq	r0, r0, r4, lsl r0
 124:	00000050 	andeq	r0, r0, r0, asr r0
 128:	00008170 	andeq	r8, r0, r0, ror r1
 12c:	0000000c 	andeq	r0, r0, ip
 130:	8b040e42 	blhi	103a40 <__bss_end+0xfaadc>
 134:	0b0d4201 	bleq	350940 <__bss_end+0x3479dc>
 138:	0000001c 	andeq	r0, r0, ip, lsl r0
 13c:	00000050 	andeq	r0, r0, r0, asr r0
 140:	0000817c 	andeq	r8, r0, ip, ror r1
 144:	00000058 	andeq	r0, r0, r8, asr r0
 148:	8b080e42 	blhi	203a58 <__bss_end+0x1faaf4>
 14c:	42018e02 	andmi	r8, r1, #2, 28
 150:	62040b0c 	andvs	r0, r4, #12, 22	; 0x3000
 154:	00080d0c 	andeq	r0, r8, ip, lsl #26
 158:	0000001c 	andeq	r0, r0, ip, lsl r0
 15c:	00000050 	andeq	r0, r0, r0, asr r0
 160:	000081d4 	ldrdeq	r8, [r0], -r4
 164:	00000058 	andeq	r0, r0, r8, asr r0
 168:	8b080e42 	blhi	203a78 <__bss_end+0x1fab14>
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
 198:	8b080e42 	blhi	203aa8 <__bss_end+0x1fab44>
 19c:	42018e02 	andmi	r8, r1, #2, 28
 1a0:	74040b0c 	strvc	r0, [r4], #-2828	; 0xfffff4f4
 1a4:	00080d0c 	andeq	r0, r8, ip, lsl #26
 1a8:	00000018 	andeq	r0, r0, r8, lsl r0
 1ac:	00000178 	andeq	r0, r0, r8, ror r1
 1b0:	000082ac 	andeq	r8, r0, ip, lsr #5
 1b4:	00000098 	muleq	r0, r8, r0
 1b8:	8b080e42 	blhi	203ac8 <__bss_end+0x1fab64>
 1bc:	42018e02 	andmi	r8, r1, #2, 28
 1c0:	00040b0c 	andeq	r0, r4, ip, lsl #22
 1c4:	0000000c 	andeq	r0, r0, ip
 1c8:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 1cc:	7c020001 	stcvc	0, cr0, [r2], {1}
 1d0:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 1d4:	0000001c 	andeq	r0, r0, ip, lsl r0
 1d8:	000001c4 	andeq	r0, r0, r4, asr #3
 1dc:	00008344 	andeq	r8, r0, r4, asr #6
 1e0:	0000002c 	andeq	r0, r0, ip, lsr #32
 1e4:	8b040e42 	blhi	103af4 <__bss_end+0xfab90>
 1e8:	0b0d4201 	bleq	3509f4 <__bss_end+0x347a90>
 1ec:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
 1f0:	00000ecb 	andeq	r0, r0, fp, asr #29
 1f4:	0000001c 	andeq	r0, r0, ip, lsl r0
 1f8:	000001c4 	andeq	r0, r0, r4, asr #3
 1fc:	00008370 	andeq	r8, r0, r0, ror r3
 200:	0000002c 	andeq	r0, r0, ip, lsr #32
 204:	8b040e42 	blhi	103b14 <__bss_end+0xfabb0>
 208:	0b0d4201 	bleq	350a14 <__bss_end+0x347ab0>
 20c:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
 210:	00000ecb 	andeq	r0, r0, fp, asr #29
 214:	0000001c 	andeq	r0, r0, ip, lsl r0
 218:	000001c4 	andeq	r0, r0, r4, asr #3
 21c:	0000839c 	muleq	r0, ip, r3
 220:	0000001c 	andeq	r0, r0, ip, lsl r0
 224:	8b040e42 	blhi	103b34 <__bss_end+0xfabd0>
 228:	0b0d4201 	bleq	350a34 <__bss_end+0x347ad0>
 22c:	420d0d46 	andmi	r0, sp, #4480	; 0x1180
 230:	00000ecb 	andeq	r0, r0, fp, asr #29
 234:	0000001c 	andeq	r0, r0, ip, lsl r0
 238:	000001c4 	andeq	r0, r0, r4, asr #3
 23c:	000083b8 			; <UNDEFINED> instruction: 0x000083b8
 240:	00000044 	andeq	r0, r0, r4, asr #32
 244:	8b040e42 	blhi	103b54 <__bss_end+0xfabf0>
 248:	0b0d4201 	bleq	350a54 <__bss_end+0x347af0>
 24c:	420d0d5a 	andmi	r0, sp, #5760	; 0x1680
 250:	00000ecb 	andeq	r0, r0, fp, asr #29
 254:	0000001c 	andeq	r0, r0, ip, lsl r0
 258:	000001c4 	andeq	r0, r0, r4, asr #3
 25c:	000083fc 	strdeq	r8, [r0], -ip
 260:	00000050 	andeq	r0, r0, r0, asr r0
 264:	8b040e42 	blhi	103b74 <__bss_end+0xfac10>
 268:	0b0d4201 	bleq	350a74 <__bss_end+0x347b10>
 26c:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 270:	00000ecb 	andeq	r0, r0, fp, asr #29
 274:	0000001c 	andeq	r0, r0, ip, lsl r0
 278:	000001c4 	andeq	r0, r0, r4, asr #3
 27c:	0000844c 	andeq	r8, r0, ip, asr #8
 280:	00000050 	andeq	r0, r0, r0, asr r0
 284:	8b040e42 	blhi	103b94 <__bss_end+0xfac30>
 288:	0b0d4201 	bleq	350a94 <__bss_end+0x347b30>
 28c:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 290:	00000ecb 	andeq	r0, r0, fp, asr #29
 294:	0000001c 	andeq	r0, r0, ip, lsl r0
 298:	000001c4 	andeq	r0, r0, r4, asr #3
 29c:	0000849c 	muleq	r0, ip, r4
 2a0:	0000002c 	andeq	r0, r0, ip, lsr #32
 2a4:	8b040e42 	blhi	103bb4 <__bss_end+0xfac50>
 2a8:	0b0d4201 	bleq	350ab4 <__bss_end+0x347b50>
 2ac:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
 2b0:	00000ecb 	andeq	r0, r0, fp, asr #29
 2b4:	0000001c 	andeq	r0, r0, ip, lsl r0
 2b8:	000001c4 	andeq	r0, r0, r4, asr #3
 2bc:	000084c8 	andeq	r8, r0, r8, asr #9
 2c0:	00000050 	andeq	r0, r0, r0, asr r0
 2c4:	8b040e42 	blhi	103bd4 <__bss_end+0xfac70>
 2c8:	0b0d4201 	bleq	350ad4 <__bss_end+0x347b70>
 2cc:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 2d0:	00000ecb 	andeq	r0, r0, fp, asr #29
 2d4:	0000001c 	andeq	r0, r0, ip, lsl r0
 2d8:	000001c4 	andeq	r0, r0, r4, asr #3
 2dc:	00008518 	andeq	r8, r0, r8, lsl r5
 2e0:	00000044 	andeq	r0, r0, r4, asr #32
 2e4:	8b040e42 	blhi	103bf4 <__bss_end+0xfac90>
 2e8:	0b0d4201 	bleq	350af4 <__bss_end+0x347b90>
 2ec:	420d0d5a 	andmi	r0, sp, #5760	; 0x1680
 2f0:	00000ecb 	andeq	r0, r0, fp, asr #29
 2f4:	0000001c 	andeq	r0, r0, ip, lsl r0
 2f8:	000001c4 	andeq	r0, r0, r4, asr #3
 2fc:	0000855c 	andeq	r8, r0, ip, asr r5
 300:	00000050 	andeq	r0, r0, r0, asr r0
 304:	8b040e42 	blhi	103c14 <__bss_end+0xfacb0>
 308:	0b0d4201 	bleq	350b14 <__bss_end+0x347bb0>
 30c:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 310:	00000ecb 	andeq	r0, r0, fp, asr #29
 314:	0000001c 	andeq	r0, r0, ip, lsl r0
 318:	000001c4 	andeq	r0, r0, r4, asr #3
 31c:	000085ac 	andeq	r8, r0, ip, lsr #11
 320:	00000054 	andeq	r0, r0, r4, asr r0
 324:	8b040e42 	blhi	103c34 <__bss_end+0xfacd0>
 328:	0b0d4201 	bleq	350b34 <__bss_end+0x347bd0>
 32c:	420d0d62 	andmi	r0, sp, #6272	; 0x1880
 330:	00000ecb 	andeq	r0, r0, fp, asr #29
 334:	0000001c 	andeq	r0, r0, ip, lsl r0
 338:	000001c4 	andeq	r0, r0, r4, asr #3
 33c:	00008600 	andeq	r8, r0, r0, lsl #12
 340:	0000003c 	andeq	r0, r0, ip, lsr r0
 344:	8b040e42 	blhi	103c54 <__bss_end+0xfacf0>
 348:	0b0d4201 	bleq	350b54 <__bss_end+0x347bf0>
 34c:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 350:	00000ecb 	andeq	r0, r0, fp, asr #29
 354:	0000001c 	andeq	r0, r0, ip, lsl r0
 358:	000001c4 	andeq	r0, r0, r4, asr #3
 35c:	0000863c 	andeq	r8, r0, ip, lsr r6
 360:	0000003c 	andeq	r0, r0, ip, lsr r0
 364:	8b040e42 	blhi	103c74 <__bss_end+0xfad10>
 368:	0b0d4201 	bleq	350b74 <__bss_end+0x347c10>
 36c:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 370:	00000ecb 	andeq	r0, r0, fp, asr #29
 374:	0000001c 	andeq	r0, r0, ip, lsl r0
 378:	000001c4 	andeq	r0, r0, r4, asr #3
 37c:	00008678 	andeq	r8, r0, r8, ror r6
 380:	0000003c 	andeq	r0, r0, ip, lsr r0
 384:	8b040e42 	blhi	103c94 <__bss_end+0xfad30>
 388:	0b0d4201 	bleq	350b94 <__bss_end+0x347c30>
 38c:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 390:	00000ecb 	andeq	r0, r0, fp, asr #29
 394:	0000001c 	andeq	r0, r0, ip, lsl r0
 398:	000001c4 	andeq	r0, r0, r4, asr #3
 39c:	000086b4 			; <UNDEFINED> instruction: 0x000086b4
 3a0:	0000003c 	andeq	r0, r0, ip, lsr r0
 3a4:	8b040e42 	blhi	103cb4 <__bss_end+0xfad50>
 3a8:	0b0d4201 	bleq	350bb4 <__bss_end+0x347c50>
 3ac:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 3b0:	00000ecb 	andeq	r0, r0, fp, asr #29
 3b4:	0000001c 	andeq	r0, r0, ip, lsl r0
 3b8:	000001c4 	andeq	r0, r0, r4, asr #3
 3bc:	000086f0 	strdeq	r8, [r0], -r0
 3c0:	000000b0 	strheq	r0, [r0], -r0	; <UNPREDICTABLE>
 3c4:	8b080e42 	blhi	203cd4 <__bss_end+0x1fad70>
 3c8:	42018e02 	andmi	r8, r1, #2, 28
 3cc:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 3d0:	080d0c50 	stmdaeq	sp, {r4, r6, sl, fp}
 3d4:	0000000c 	andeq	r0, r0, ip
 3d8:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 3dc:	7c020001 	stcvc	0, cr0, [r2], {1}
 3e0:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 3e4:	0000001c 	andeq	r0, r0, ip, lsl r0
 3e8:	000003d4 	ldrdeq	r0, [r0], -r4
 3ec:	000087a0 	andeq	r8, r0, r0, lsr #15
 3f0:	00000174 	andeq	r0, r0, r4, ror r1
 3f4:	8b080e42 	blhi	203d04 <__bss_end+0x1fada0>
 3f8:	42018e02 	andmi	r8, r1, #2, 28
 3fc:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 400:	080d0cb2 	stmdaeq	sp, {r1, r4, r5, r7, sl, fp}
 404:	0000001c 	andeq	r0, r0, ip, lsl r0
 408:	000003d4 	ldrdeq	r0, [r0], -r4
 40c:	00008914 	andeq	r8, r0, r4, lsl r9
 410:	0000009c 	muleq	r0, ip, r0
 414:	8b040e42 	blhi	103d24 <__bss_end+0xfadc0>
 418:	0b0d4201 	bleq	350c24 <__bss_end+0x347cc0>
 41c:	0d0d4602 	stceq	6, cr4, [sp, #-8]
 420:	000ecb42 	andeq	ip, lr, r2, asr #22
 424:	0000001c 	andeq	r0, r0, ip, lsl r0
 428:	000003d4 	ldrdeq	r0, [r0], -r4
 42c:	000089b0 			; <UNDEFINED> instruction: 0x000089b0
 430:	000000c0 	andeq	r0, r0, r0, asr #1
 434:	8b040e42 	blhi	103d44 <__bss_end+0xfade0>
 438:	0b0d4201 	bleq	350c44 <__bss_end+0x347ce0>
 43c:	0d0d5802 	stceq	8, cr5, [sp, #-8]
 440:	000ecb42 	andeq	ip, lr, r2, asr #22
 444:	0000001c 	andeq	r0, r0, ip, lsl r0
 448:	000003d4 	ldrdeq	r0, [r0], -r4
 44c:	00008a70 	andeq	r8, r0, r0, ror sl
 450:	000000ac 	andeq	r0, r0, ip, lsr #1
 454:	8b040e42 	blhi	103d64 <__bss_end+0xfae00>
 458:	0b0d4201 	bleq	350c64 <__bss_end+0x347d00>
 45c:	0d0d4e02 	stceq	14, cr4, [sp, #-8]
 460:	000ecb42 	andeq	ip, lr, r2, asr #22
 464:	0000001c 	andeq	r0, r0, ip, lsl r0
 468:	000003d4 	ldrdeq	r0, [r0], -r4
 46c:	00008b1c 	andeq	r8, r0, ip, lsl fp
 470:	00000054 	andeq	r0, r0, r4, asr r0
 474:	8b040e42 	blhi	103d84 <__bss_end+0xfae20>
 478:	0b0d4201 	bleq	350c84 <__bss_end+0x347d20>
 47c:	420d0d62 	andmi	r0, sp, #6272	; 0x1880
 480:	00000ecb 	andeq	r0, r0, fp, asr #29
 484:	0000001c 	andeq	r0, r0, ip, lsl r0
 488:	000003d4 	ldrdeq	r0, [r0], -r4
 48c:	00008b70 	andeq	r8, r0, r0, ror fp
 490:	00000068 	andeq	r0, r0, r8, rrx
 494:	8b040e42 	blhi	103da4 <__bss_end+0xfae40>
 498:	0b0d4201 	bleq	350ca4 <__bss_end+0x347d40>
 49c:	420d0d6c 	andmi	r0, sp, #108, 26	; 0x1b00
 4a0:	00000ecb 	andeq	r0, r0, fp, asr #29
 4a4:	0000001c 	andeq	r0, r0, ip, lsl r0
 4a8:	000003d4 	ldrdeq	r0, [r0], -r4
 4ac:	00008bd8 	ldrdeq	r8, [r0], -r8	; <UNPREDICTABLE>
 4b0:	00000080 	andeq	r0, r0, r0, lsl #1
 4b4:	8b040e42 	blhi	103dc4 <__bss_end+0xfae60>
 4b8:	0b0d4201 	bleq	350cc4 <__bss_end+0x347d60>
 4bc:	420d0d78 	andmi	r0, sp, #120, 26	; 0x1e00
 4c0:	00000ecb 	andeq	r0, r0, fp, asr #29
 4c4:	0000000c 	andeq	r0, r0, ip
 4c8:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 4cc:	7c010001 	stcvc	0, cr0, [r1], {1}
 4d0:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 4d4:	0000000c 	andeq	r0, r0, ip
 4d8:	000004c4 	andeq	r0, r0, r4, asr #9
 4dc:	00008c58 	andeq	r8, r0, r8, asr ip
 4e0:	000001ec 	andeq	r0, r0, ip, ror #3
