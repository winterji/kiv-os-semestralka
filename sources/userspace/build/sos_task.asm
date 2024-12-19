
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
    805c:	00008fd4 	ldrdeq	r8, [r0], -r4
    8060:	00008fec 	andeq	r8, r0, ip, ror #31

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
    81cc:	00008fd1 	ldrdeq	r8, [r0], -r1
    81d0:	00008fd1 	ldrdeq	r8, [r0], -r1

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
    8224:	00008fd1 	ldrdeq	r8, [r0], -r1
    8228:	00008fd1 	ldrdeq	r8, [r0], -r1

0000822c <_Z5blinkb>:
_Z5blinkb():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:20
constexpr uint32_t char_tick_delay = 0x1000;

uint32_t sos_led, uart;

void blink(bool short_blink)
{
    822c:	e92d4800 	push	{fp, lr}
    8230:	e28db004 	add	fp, sp, #4
    8234:	e24dd008 	sub	sp, sp, #8
    8238:	e1a03000 	mov	r3, r0
    823c:	e54b3005 	strb	r3, [fp, #-5]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:21
	write(sos_led, "1", 1);
    8240:	e59f3058 	ldr	r3, [pc, #88]	; 82a0 <_Z5blinkb+0x74>
    8244:	e5933000 	ldr	r3, [r3]
    8248:	e3a02001 	mov	r2, #1
    824c:	e59f1050 	ldr	r1, [pc, #80]	; 82a4 <_Z5blinkb+0x78>
    8250:	e1a00003 	mov	r0, r3
    8254:	eb0000a0 	bl	84dc <_Z5writejPKcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:22
	sleep(short_blink ? 0x800 : 0x1000);
    8258:	e55b3005 	ldrb	r3, [fp, #-5]
    825c:	e3530000 	cmp	r3, #0
    8260:	0a000001 	beq	826c <_Z5blinkb+0x40>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:22 (discriminator 1)
    8264:	e3a03b02 	mov	r3, #2048	; 0x800
    8268:	ea000000 	b	8270 <_Z5blinkb+0x44>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:22 (discriminator 2)
    826c:	e3a03a01 	mov	r3, #4096	; 0x1000
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:22 (discriminator 4)
    8270:	e3e01001 	mvn	r1, #1
    8274:	e1a00003 	mov	r0, r3
    8278:	eb0000ef 	bl	863c <_Z5sleepjj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:23 (discriminator 4)
	write(sos_led, "0", 1);
    827c:	e59f301c 	ldr	r3, [pc, #28]	; 82a0 <_Z5blinkb+0x74>
    8280:	e5933000 	ldr	r3, [r3]
    8284:	e3a02001 	mov	r2, #1
    8288:	e59f1018 	ldr	r1, [pc, #24]	; 82a8 <_Z5blinkb+0x7c>
    828c:	e1a00003 	mov	r0, r3
    8290:	eb000091 	bl	84dc <_Z5writejPKcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:24 (discriminator 4)
}
    8294:	e320f000 	nop	{0}
    8298:	e24bd004 	sub	sp, fp, #4
    829c:	e8bd8800 	pop	{fp, pc}
    82a0:	00008fd4 	ldrdeq	r8, [r0], -r4
    82a4:	00008f60 	andeq	r8, r0, r0, ror #30
    82a8:	00008f64 	andeq	r8, r0, r4, ror #30

000082ac <main>:
main():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:27

int main(int argc, char** argv)
{
    82ac:	e92d4800 	push	{fp, lr}
    82b0:	e28db004 	add	fp, sp, #4
    82b4:	e24dd008 	sub	sp, sp, #8
    82b8:	e50b0008 	str	r0, [fp, #-8]
    82bc:	e50b100c 	str	r1, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:28
	sos_led = open("DEV:gpio/47", NFile_Open_Mode::Write_Only);
    82c0:	e3a01001 	mov	r1, #1
    82c4:	e59f00f4 	ldr	r0, [pc, #244]	; 83c0 <main+0x114>
    82c8:	eb00005e 	bl	8448 <_Z4openPKc15NFile_Open_Mode>
    82cc:	e1a03000 	mov	r3, r0
    82d0:	e59f20ec 	ldr	r2, [pc, #236]	; 83c4 <main+0x118>
    82d4:	e5823000 	str	r3, [r2]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:29
	uart = open("DEV:uart/0", NFile_Open_Mode::Read_Write);
    82d8:	e3a01002 	mov	r1, #2
    82dc:	e59f00e4 	ldr	r0, [pc, #228]	; 83c8 <main+0x11c>
    82e0:	eb000058 	bl	8448 <_Z4openPKc15NFile_Open_Mode>
    82e4:	e1a03000 	mov	r3, r0
    82e8:	e59f20dc 	ldr	r2, [pc, #220]	; 83cc <main+0x120>
    82ec:	e5823000 	str	r3, [r2]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:41 (discriminator 1)
		// 2) my mame deadline 0x300
		// 3) log task ma deadline 0x1000
		// 4) jiny task ma deadline 0x500
		// jiny task dostane prednost pred log taskem, a pokud nesplni v kratkem case svou ulohu, tento task prekroci deadline
		// TODO: inverzi priorit bychom docasne zvysili prioritu (zkratili deadline) log tasku, aby vyprazdnil pipe a my se mohli odblokovat co nejdrive
		write(uart, "SOS!", 5);
    82f0:	e59f30d4 	ldr	r3, [pc, #212]	; 83cc <main+0x120>
    82f4:	e5933000 	ldr	r3, [r3]
    82f8:	e3a02005 	mov	r2, #5
    82fc:	e59f10cc 	ldr	r1, [pc, #204]	; 83d0 <main+0x124>
    8300:	e1a00003 	mov	r0, r3
    8304:	eb000074 	bl	84dc <_Z5writejPKcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:43 (discriminator 1)

		blink(true);
    8308:	e3a00001 	mov	r0, #1
    830c:	ebffffc6 	bl	822c <_Z5blinkb>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:44 (discriminator 1)
		sleep(symbol_tick_delay);
    8310:	e3e01001 	mvn	r1, #1
    8314:	e3a00b01 	mov	r0, #1024	; 0x400
    8318:	eb0000c7 	bl	863c <_Z5sleepjj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:45 (discriminator 1)
		blink(true);
    831c:	e3a00001 	mov	r0, #1
    8320:	ebffffc1 	bl	822c <_Z5blinkb>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:46 (discriminator 1)
		sleep(symbol_tick_delay);
    8324:	e3e01001 	mvn	r1, #1
    8328:	e3a00b01 	mov	r0, #1024	; 0x400
    832c:	eb0000c2 	bl	863c <_Z5sleepjj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:47 (discriminator 1)
		blink(true);
    8330:	e3a00001 	mov	r0, #1
    8334:	ebffffbc 	bl	822c <_Z5blinkb>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:49 (discriminator 1)

		sleep(char_tick_delay);
    8338:	e3e01001 	mvn	r1, #1
    833c:	e3a00a01 	mov	r0, #4096	; 0x1000
    8340:	eb0000bd 	bl	863c <_Z5sleepjj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:51 (discriminator 1)

		blink(false);
    8344:	e3a00000 	mov	r0, #0
    8348:	ebffffb7 	bl	822c <_Z5blinkb>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:52 (discriminator 1)
		sleep(symbol_tick_delay);
    834c:	e3e01001 	mvn	r1, #1
    8350:	e3a00b01 	mov	r0, #1024	; 0x400
    8354:	eb0000b8 	bl	863c <_Z5sleepjj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:53 (discriminator 1)
		blink(false);
    8358:	e3a00000 	mov	r0, #0
    835c:	ebffffb2 	bl	822c <_Z5blinkb>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:54 (discriminator 1)
		sleep(symbol_tick_delay);
    8360:	e3e01001 	mvn	r1, #1
    8364:	e3a00b01 	mov	r0, #1024	; 0x400
    8368:	eb0000b3 	bl	863c <_Z5sleepjj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:55 (discriminator 1)
		blink(false);
    836c:	e3a00000 	mov	r0, #0
    8370:	ebffffad 	bl	822c <_Z5blinkb>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:56 (discriminator 1)
		sleep(symbol_tick_delay);
    8374:	e3e01001 	mvn	r1, #1
    8378:	e3a00b01 	mov	r0, #1024	; 0x400
    837c:	eb0000ae 	bl	863c <_Z5sleepjj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:58 (discriminator 1)

		sleep(char_tick_delay);
    8380:	e3e01001 	mvn	r1, #1
    8384:	e3a00a01 	mov	r0, #4096	; 0x1000
    8388:	eb0000ab 	bl	863c <_Z5sleepjj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:60 (discriminator 1)

		blink(true);
    838c:	e3a00001 	mov	r0, #1
    8390:	ebffffa5 	bl	822c <_Z5blinkb>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:61 (discriminator 1)
		sleep(symbol_tick_delay);
    8394:	e3e01001 	mvn	r1, #1
    8398:	e3a00b01 	mov	r0, #1024	; 0x400
    839c:	eb0000a6 	bl	863c <_Z5sleepjj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:62 (discriminator 1)
		blink(true);
    83a0:	e3a00001 	mov	r0, #1
    83a4:	ebffffa0 	bl	822c <_Z5blinkb>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:63 (discriminator 1)
		sleep(symbol_tick_delay);
    83a8:	e3e01001 	mvn	r1, #1
    83ac:	e3a00b01 	mov	r0, #1024	; 0x400
    83b0:	eb0000a1 	bl	863c <_Z5sleepjj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:64 (discriminator 1)
		blink(true);
    83b4:	e3a00001 	mov	r0, #1
    83b8:	ebffff9b 	bl	822c <_Z5blinkb>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/sos_task/main.cpp:41 (discriminator 1)
		write(uart, "SOS!", 5);
    83bc:	eaffffcb 	b	82f0 <main+0x44>
    83c0:	00008f68 	andeq	r8, r0, r8, ror #30
    83c4:	00008fd4 	ldrdeq	r8, [r0], -r4
    83c8:	00008f74 	andeq	r8, r0, r4, ror pc
    83cc:	00008fd8 	ldrdeq	r8, [r0], -r8	; <UNPREDICTABLE>
    83d0:	00008f80 	andeq	r8, r0, r0, lsl #31

000083d4 <_Z6getpidv>:
_Z6getpidv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:5
#include <stdfile.h>
#include <stdstring.h>

uint32_t getpid()
{
    83d4:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    83d8:	e28db000 	add	fp, sp, #0
    83dc:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:8
    uint32_t pid;

    asm volatile("swi 0");
    83e0:	ef000000 	svc	0x00000000
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:9
    asm volatile("mov %0, r0" : "=r" (pid));
    83e4:	e1a03000 	mov	r3, r0
    83e8:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:11

    return pid;
    83ec:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:12
}
    83f0:	e1a00003 	mov	r0, r3
    83f4:	e28bd000 	add	sp, fp, #0
    83f8:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    83fc:	e12fff1e 	bx	lr

00008400 <_Z9terminatei>:
_Z9terminatei():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:15

void terminate(int exitcode)
{
    8400:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8404:	e28db000 	add	fp, sp, #0
    8408:	e24dd00c 	sub	sp, sp, #12
    840c:	e50b0008 	str	r0, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:16
    asm volatile("mov r0, %0" : : "r" (exitcode));
    8410:	e51b3008 	ldr	r3, [fp, #-8]
    8414:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:17
    asm volatile("swi 1");
    8418:	ef000001 	svc	0x00000001
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:18
}
    841c:	e320f000 	nop	{0}
    8420:	e28bd000 	add	sp, fp, #0
    8424:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8428:	e12fff1e 	bx	lr

0000842c <_Z11sched_yieldv>:
_Z11sched_yieldv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:21

void sched_yield()
{
    842c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8430:	e28db000 	add	fp, sp, #0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:22
    asm volatile("swi 2");
    8434:	ef000002 	svc	0x00000002
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:23
}
    8438:	e320f000 	nop	{0}
    843c:	e28bd000 	add	sp, fp, #0
    8440:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8444:	e12fff1e 	bx	lr

00008448 <_Z4openPKc15NFile_Open_Mode>:
_Z4openPKc15NFile_Open_Mode():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:26

uint32_t open(const char* filename, NFile_Open_Mode mode)
{
    8448:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    844c:	e28db000 	add	fp, sp, #0
    8450:	e24dd014 	sub	sp, sp, #20
    8454:	e50b0010 	str	r0, [fp, #-16]
    8458:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:29
    uint32_t file;

    asm volatile("mov r0, %0" : : "r" (filename));
    845c:	e51b3010 	ldr	r3, [fp, #-16]
    8460:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:30
    asm volatile("mov r1, %0" : : "r" (mode));
    8464:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8468:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:31
    asm volatile("swi 64");
    846c:	ef000040 	svc	0x00000040
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:32
    asm volatile("mov %0, r0" : "=r" (file));
    8470:	e1a03000 	mov	r3, r0
    8474:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:33
    return file;
    8478:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:34
}
    847c:	e1a00003 	mov	r0, r3
    8480:	e28bd000 	add	sp, fp, #0
    8484:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8488:	e12fff1e 	bx	lr

0000848c <_Z4readjPcj>:
_Z4readjPcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:37

uint32_t read(uint32_t file, char* const buffer, uint32_t size)
{
    848c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8490:	e28db000 	add	fp, sp, #0
    8494:	e24dd01c 	sub	sp, sp, #28
    8498:	e50b0010 	str	r0, [fp, #-16]
    849c:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    84a0:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:40
    uint32_t rdnum;

    asm volatile("mov r0, %0" : : "r" (file));
    84a4:	e51b3010 	ldr	r3, [fp, #-16]
    84a8:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:41
    asm volatile("mov r1, %0" : : "r" (buffer));
    84ac:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    84b0:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:42
    asm volatile("mov r2, %0" : : "r" (size));
    84b4:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    84b8:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:43
    asm volatile("swi 65");
    84bc:	ef000041 	svc	0x00000041
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:44
    asm volatile("mov %0, r0" : "=r" (rdnum));
    84c0:	e1a03000 	mov	r3, r0
    84c4:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:46

    return rdnum;
    84c8:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:47
}
    84cc:	e1a00003 	mov	r0, r3
    84d0:	e28bd000 	add	sp, fp, #0
    84d4:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    84d8:	e12fff1e 	bx	lr

000084dc <_Z5writejPKcj>:
_Z5writejPKcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:50

uint32_t write(uint32_t file, const char* buffer, uint32_t size)
{
    84dc:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    84e0:	e28db000 	add	fp, sp, #0
    84e4:	e24dd01c 	sub	sp, sp, #28
    84e8:	e50b0010 	str	r0, [fp, #-16]
    84ec:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    84f0:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:53
    uint32_t wrnum;

    asm volatile("mov r0, %0" : : "r" (file));
    84f4:	e51b3010 	ldr	r3, [fp, #-16]
    84f8:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:54
    asm volatile("mov r1, %0" : : "r" (buffer));
    84fc:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8500:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:55
    asm volatile("mov r2, %0" : : "r" (size));
    8504:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8508:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:56
    asm volatile("swi 66");
    850c:	ef000042 	svc	0x00000042
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:57
    asm volatile("mov %0, r0" : "=r" (wrnum));
    8510:	e1a03000 	mov	r3, r0
    8514:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:59

    return wrnum;
    8518:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:60
}
    851c:	e1a00003 	mov	r0, r3
    8520:	e28bd000 	add	sp, fp, #0
    8524:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8528:	e12fff1e 	bx	lr

0000852c <_Z5closej>:
_Z5closej():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:63

void close(uint32_t file)
{
    852c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8530:	e28db000 	add	fp, sp, #0
    8534:	e24dd00c 	sub	sp, sp, #12
    8538:	e50b0008 	str	r0, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:64
    asm volatile("mov r0, %0" : : "r" (file));
    853c:	e51b3008 	ldr	r3, [fp, #-8]
    8540:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:65
    asm volatile("swi 67");
    8544:	ef000043 	svc	0x00000043
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:66
}
    8548:	e320f000 	nop	{0}
    854c:	e28bd000 	add	sp, fp, #0
    8550:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8554:	e12fff1e 	bx	lr

00008558 <_Z5ioctlj16NIOCtl_OperationPv>:
_Z5ioctlj16NIOCtl_OperationPv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:69

uint32_t ioctl(uint32_t file, NIOCtl_Operation operation, void* param)
{
    8558:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    855c:	e28db000 	add	fp, sp, #0
    8560:	e24dd01c 	sub	sp, sp, #28
    8564:	e50b0010 	str	r0, [fp, #-16]
    8568:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    856c:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:72
    uint32_t retcode;

    asm volatile("mov r0, %0" : : "r" (file));
    8570:	e51b3010 	ldr	r3, [fp, #-16]
    8574:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:73
    asm volatile("mov r1, %0" : : "r" (operation));
    8578:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    857c:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:74
    asm volatile("mov r2, %0" : : "r" (param));
    8580:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8584:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:75
    asm volatile("swi 68");
    8588:	ef000044 	svc	0x00000044
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:76
    asm volatile("mov %0, r0" : "=r" (retcode));
    858c:	e1a03000 	mov	r3, r0
    8590:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:78

    return retcode;
    8594:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:79
}
    8598:	e1a00003 	mov	r0, r3
    859c:	e28bd000 	add	sp, fp, #0
    85a0:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    85a4:	e12fff1e 	bx	lr

000085a8 <_Z6notifyjj>:
_Z6notifyjj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:82

uint32_t notify(uint32_t file, uint32_t count)
{
    85a8:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    85ac:	e28db000 	add	fp, sp, #0
    85b0:	e24dd014 	sub	sp, sp, #20
    85b4:	e50b0010 	str	r0, [fp, #-16]
    85b8:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:85
    uint32_t retcnt;

    asm volatile("mov r0, %0" : : "r" (file));
    85bc:	e51b3010 	ldr	r3, [fp, #-16]
    85c0:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:86
    asm volatile("mov r1, %0" : : "r" (count));
    85c4:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    85c8:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:87
    asm volatile("swi 69");
    85cc:	ef000045 	svc	0x00000045
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:88
    asm volatile("mov %0, r0" : "=r" (retcnt));
    85d0:	e1a03000 	mov	r3, r0
    85d4:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:90

    return retcnt;
    85d8:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:91
}
    85dc:	e1a00003 	mov	r0, r3
    85e0:	e28bd000 	add	sp, fp, #0
    85e4:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    85e8:	e12fff1e 	bx	lr

000085ec <_Z4waitjjj>:
_Z4waitjjj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:94

NSWI_Result_Code wait(uint32_t file, uint32_t count, uint32_t notified_deadline)
{
    85ec:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    85f0:	e28db000 	add	fp, sp, #0
    85f4:	e24dd01c 	sub	sp, sp, #28
    85f8:	e50b0010 	str	r0, [fp, #-16]
    85fc:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8600:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:97
    NSWI_Result_Code retcode;

    asm volatile("mov r0, %0" : : "r" (file));
    8604:	e51b3010 	ldr	r3, [fp, #-16]
    8608:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:98
    asm volatile("mov r1, %0" : : "r" (count));
    860c:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8610:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:99
    asm volatile("mov r2, %0" : : "r" (notified_deadline));
    8614:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8618:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:100
    asm volatile("swi 70");
    861c:	ef000046 	svc	0x00000046
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:101
    asm volatile("mov %0, r0" : "=r" (retcode));
    8620:	e1a03000 	mov	r3, r0
    8624:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:103

    return retcode;
    8628:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:104
}
    862c:	e1a00003 	mov	r0, r3
    8630:	e28bd000 	add	sp, fp, #0
    8634:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8638:	e12fff1e 	bx	lr

0000863c <_Z5sleepjj>:
_Z5sleepjj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:107

bool sleep(uint32_t ticks, uint32_t notified_deadline)
{
    863c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8640:	e28db000 	add	fp, sp, #0
    8644:	e24dd014 	sub	sp, sp, #20
    8648:	e50b0010 	str	r0, [fp, #-16]
    864c:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:110
    uint32_t retcode;

    asm volatile("mov r0, %0" : : "r" (ticks));
    8650:	e51b3010 	ldr	r3, [fp, #-16]
    8654:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:111
    asm volatile("mov r1, %0" : : "r" (notified_deadline));
    8658:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    865c:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:112
    asm volatile("swi 3");
    8660:	ef000003 	svc	0x00000003
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:113
    asm volatile("mov %0, r0" : "=r" (retcode));
    8664:	e1a03000 	mov	r3, r0
    8668:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:115

    return retcode;
    866c:	e51b3008 	ldr	r3, [fp, #-8]
    8670:	e3530000 	cmp	r3, #0
    8674:	13a03001 	movne	r3, #1
    8678:	03a03000 	moveq	r3, #0
    867c:	e6ef3073 	uxtb	r3, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:116
}
    8680:	e1a00003 	mov	r0, r3
    8684:	e28bd000 	add	sp, fp, #0
    8688:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    868c:	e12fff1e 	bx	lr

00008690 <_Z24get_active_process_countv>:
_Z24get_active_process_countv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:119

uint32_t get_active_process_count()
{
    8690:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8694:	e28db000 	add	fp, sp, #0
    8698:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:120
    const NGet_Sched_Info_Type req = NGet_Sched_Info_Type::Active_Process_Count;
    869c:	e3a03000 	mov	r3, #0
    86a0:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:123
    uint32_t retval;

    asm volatile("mov r0, %0" : : "r" (req));
    86a4:	e3a03000 	mov	r3, #0
    86a8:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:124
    asm volatile("mov r1, %0" : : "r" (&retval));
    86ac:	e24b300c 	sub	r3, fp, #12
    86b0:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:125
    asm volatile("swi 4");
    86b4:	ef000004 	svc	0x00000004
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:127

    return retval;
    86b8:	e51b300c 	ldr	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:128
}
    86bc:	e1a00003 	mov	r0, r3
    86c0:	e28bd000 	add	sp, fp, #0
    86c4:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    86c8:	e12fff1e 	bx	lr

000086cc <_Z14get_tick_countv>:
_Z14get_tick_countv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:131

uint32_t get_tick_count()
{
    86cc:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    86d0:	e28db000 	add	fp, sp, #0
    86d4:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:132
    const NGet_Sched_Info_Type req = NGet_Sched_Info_Type::Tick_Count;
    86d8:	e3a03001 	mov	r3, #1
    86dc:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:135
    uint32_t retval;

    asm volatile("mov r0, %0" : : "r" (req));
    86e0:	e3a03001 	mov	r3, #1
    86e4:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:136
    asm volatile("mov r1, %0" : : "r" (&retval));
    86e8:	e24b300c 	sub	r3, fp, #12
    86ec:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:137
    asm volatile("swi 4");
    86f0:	ef000004 	svc	0x00000004
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:139

    return retval;
    86f4:	e51b300c 	ldr	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:140
}
    86f8:	e1a00003 	mov	r0, r3
    86fc:	e28bd000 	add	sp, fp, #0
    8700:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8704:	e12fff1e 	bx	lr

00008708 <_Z17set_task_deadlinej>:
_Z17set_task_deadlinej():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:143

void set_task_deadline(uint32_t tick_count_required)
{
    8708:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    870c:	e28db000 	add	fp, sp, #0
    8710:	e24dd014 	sub	sp, sp, #20
    8714:	e50b0010 	str	r0, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:144
    const NDeadline_Subservice req = NDeadline_Subservice::Set_Relative;
    8718:	e3a03000 	mov	r3, #0
    871c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:146

    asm volatile("mov r0, %0" : : "r" (req));
    8720:	e3a03000 	mov	r3, #0
    8724:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:147
    asm volatile("mov r1, %0" : : "r" (&tick_count_required));
    8728:	e24b3010 	sub	r3, fp, #16
    872c:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:148
    asm volatile("swi 5");
    8730:	ef000005 	svc	0x00000005
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:149
}
    8734:	e320f000 	nop	{0}
    8738:	e28bd000 	add	sp, fp, #0
    873c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8740:	e12fff1e 	bx	lr

00008744 <_Z26get_task_ticks_to_deadlinev>:
_Z26get_task_ticks_to_deadlinev():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:152

uint32_t get_task_ticks_to_deadline()
{
    8744:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8748:	e28db000 	add	fp, sp, #0
    874c:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:153
    const NDeadline_Subservice req = NDeadline_Subservice::Get_Remaining;
    8750:	e3a03001 	mov	r3, #1
    8754:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:156
    uint32_t ticks;

    asm volatile("mov r0, %0" : : "r" (req));
    8758:	e3a03001 	mov	r3, #1
    875c:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:157
    asm volatile("mov r1, %0" : : "r" (&ticks));
    8760:	e24b300c 	sub	r3, fp, #12
    8764:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:158
    asm volatile("swi 5");
    8768:	ef000005 	svc	0x00000005
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:160

    return ticks;
    876c:	e51b300c 	ldr	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:161
}
    8770:	e1a00003 	mov	r0, r3
    8774:	e28bd000 	add	sp, fp, #0
    8778:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    877c:	e12fff1e 	bx	lr

00008780 <_Z4pipePKcj>:
_Z4pipePKcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:166

const char Pipe_File_Prefix[] = "SYS:pipe/";

uint32_t pipe(const char* name, uint32_t buf_size)
{
    8780:	e92d4800 	push	{fp, lr}
    8784:	e28db004 	add	fp, sp, #4
    8788:	e24dd050 	sub	sp, sp, #80	; 0x50
    878c:	e50b0050 	str	r0, [fp, #-80]	; 0xffffffb0
    8790:	e50b1054 	str	r1, [fp, #-84]	; 0xffffffac
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:168
    char fname[64];
    strncpy(fname, Pipe_File_Prefix, sizeof(Pipe_File_Prefix));
    8794:	e24b3048 	sub	r3, fp, #72	; 0x48
    8798:	e3a0200a 	mov	r2, #10
    879c:	e59f1088 	ldr	r1, [pc, #136]	; 882c <_Z4pipePKcj+0xac>
    87a0:	e1a00003 	mov	r0, r3
    87a4:	eb0000a5 	bl	8a40 <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:169
    strncpy(fname + sizeof(Pipe_File_Prefix), name, sizeof(fname) - sizeof(Pipe_File_Prefix) - 1);
    87a8:	e24b3048 	sub	r3, fp, #72	; 0x48
    87ac:	e283300a 	add	r3, r3, #10
    87b0:	e3a02035 	mov	r2, #53	; 0x35
    87b4:	e51b1050 	ldr	r1, [fp, #-80]	; 0xffffffb0
    87b8:	e1a00003 	mov	r0, r3
    87bc:	eb00009f 	bl	8a40 <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:171

    int ncur = sizeof(Pipe_File_Prefix) + strlen(name);
    87c0:	e51b0050 	ldr	r0, [fp, #-80]	; 0xffffffb0
    87c4:	eb0000f8 	bl	8bac <_Z6strlenPKc>
    87c8:	e1a03000 	mov	r3, r0
    87cc:	e283300a 	add	r3, r3, #10
    87d0:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:173

    fname[ncur++] = '#';
    87d4:	e51b3008 	ldr	r3, [fp, #-8]
    87d8:	e2832001 	add	r2, r3, #1
    87dc:	e50b2008 	str	r2, [fp, #-8]
    87e0:	e2433004 	sub	r3, r3, #4
    87e4:	e083300b 	add	r3, r3, fp
    87e8:	e3a02023 	mov	r2, #35	; 0x23
    87ec:	e5432044 	strb	r2, [r3, #-68]	; 0xffffffbc
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:175

    itoa(buf_size, &fname[ncur], 10);
    87f0:	e24b2048 	sub	r2, fp, #72	; 0x48
    87f4:	e51b3008 	ldr	r3, [fp, #-8]
    87f8:	e0823003 	add	r3, r2, r3
    87fc:	e3a0200a 	mov	r2, #10
    8800:	e1a01003 	mov	r1, r3
    8804:	e51b0054 	ldr	r0, [fp, #-84]	; 0xffffffac
    8808:	eb000008 	bl	8830 <_Z4itoajPcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:177

    return open(fname, NFile_Open_Mode::Read_Write);
    880c:	e24b3048 	sub	r3, fp, #72	; 0x48
    8810:	e3a01002 	mov	r1, #2
    8814:	e1a00003 	mov	r0, r3
    8818:	ebffff0a 	bl	8448 <_Z4openPKc15NFile_Open_Mode>
    881c:	e1a03000 	mov	r3, r0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:178
}
    8820:	e1a00003 	mov	r0, r3
    8824:	e24bd004 	sub	sp, fp, #4
    8828:	e8bd8800 	pop	{fp, pc}
    882c:	00008fb4 			; <UNDEFINED> instruction: 0x00008fb4

00008830 <_Z4itoajPcj>:
_Z4itoajPcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:9
{
    const char CharConvArr[] = "0123456789ABCDEF";
}

void itoa(unsigned int input, char* output, unsigned int base)
{
    8830:	e92d4800 	push	{fp, lr}
    8834:	e28db004 	add	fp, sp, #4
    8838:	e24dd020 	sub	sp, sp, #32
    883c:	e50b0018 	str	r0, [fp, #-24]	; 0xffffffe8
    8840:	e50b101c 	str	r1, [fp, #-28]	; 0xffffffe4
    8844:	e50b2020 	str	r2, [fp, #-32]	; 0xffffffe0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:10
	int i = 0;
    8848:	e3a03000 	mov	r3, #0
    884c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:12

	while (input > 0)
    8850:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8854:	e3530000 	cmp	r3, #0
    8858:	0a000014 	beq	88b0 <_Z4itoajPcj+0x80>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:14
	{
		output[i] = CharConvArr[input % base];
    885c:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8860:	e51b1020 	ldr	r1, [fp, #-32]	; 0xffffffe0
    8864:	e1a00003 	mov	r0, r3
    8868:	eb000199 	bl	8ed4 <__aeabi_uidivmod>
    886c:	e1a03001 	mov	r3, r1
    8870:	e1a01003 	mov	r1, r3
    8874:	e51b3008 	ldr	r3, [fp, #-8]
    8878:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    887c:	e0823003 	add	r3, r2, r3
    8880:	e59f2118 	ldr	r2, [pc, #280]	; 89a0 <_Z4itoajPcj+0x170>
    8884:	e7d22001 	ldrb	r2, [r2, r1]
    8888:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:15
		input /= base;
    888c:	e51b1020 	ldr	r1, [fp, #-32]	; 0xffffffe0
    8890:	e51b0018 	ldr	r0, [fp, #-24]	; 0xffffffe8
    8894:	eb000113 	bl	8ce8 <__udivsi3>
    8898:	e1a03000 	mov	r3, r0
    889c:	e50b3018 	str	r3, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:16
		i++;
    88a0:	e51b3008 	ldr	r3, [fp, #-8]
    88a4:	e2833001 	add	r3, r3, #1
    88a8:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:12
	while (input > 0)
    88ac:	eaffffe7 	b	8850 <_Z4itoajPcj+0x20>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:19
	}

    if (i == 0)
    88b0:	e51b3008 	ldr	r3, [fp, #-8]
    88b4:	e3530000 	cmp	r3, #0
    88b8:	1a000007 	bne	88dc <_Z4itoajPcj+0xac>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:21
    {
        output[i] = CharConvArr[0];
    88bc:	e51b3008 	ldr	r3, [fp, #-8]
    88c0:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    88c4:	e0823003 	add	r3, r2, r3
    88c8:	e3a02030 	mov	r2, #48	; 0x30
    88cc:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:22
        i++;
    88d0:	e51b3008 	ldr	r3, [fp, #-8]
    88d4:	e2833001 	add	r3, r3, #1
    88d8:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:25
    }

	output[i] = '\0';
    88dc:	e51b3008 	ldr	r3, [fp, #-8]
    88e0:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    88e4:	e0823003 	add	r3, r2, r3
    88e8:	e3a02000 	mov	r2, #0
    88ec:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:26
	i--;
    88f0:	e51b3008 	ldr	r3, [fp, #-8]
    88f4:	e2433001 	sub	r3, r3, #1
    88f8:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:28

	for (int j = 0; j <= i/2; j++)
    88fc:	e3a03000 	mov	r3, #0
    8900:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:28 (discriminator 3)
    8904:	e51b3008 	ldr	r3, [fp, #-8]
    8908:	e1a02fa3 	lsr	r2, r3, #31
    890c:	e0823003 	add	r3, r2, r3
    8910:	e1a030c3 	asr	r3, r3, #1
    8914:	e1a02003 	mov	r2, r3
    8918:	e51b300c 	ldr	r3, [fp, #-12]
    891c:	e1530002 	cmp	r3, r2
    8920:	ca00001b 	bgt	8994 <_Z4itoajPcj+0x164>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:30 (discriminator 2)
	{
		char c = output[i - j];
    8924:	e51b2008 	ldr	r2, [fp, #-8]
    8928:	e51b300c 	ldr	r3, [fp, #-12]
    892c:	e0423003 	sub	r3, r2, r3
    8930:	e1a02003 	mov	r2, r3
    8934:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    8938:	e0833002 	add	r3, r3, r2
    893c:	e5d33000 	ldrb	r3, [r3]
    8940:	e54b300d 	strb	r3, [fp, #-13]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:31 (discriminator 2)
		output[i - j] = output[j];
    8944:	e51b300c 	ldr	r3, [fp, #-12]
    8948:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    894c:	e0822003 	add	r2, r2, r3
    8950:	e51b1008 	ldr	r1, [fp, #-8]
    8954:	e51b300c 	ldr	r3, [fp, #-12]
    8958:	e0413003 	sub	r3, r1, r3
    895c:	e1a01003 	mov	r1, r3
    8960:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    8964:	e0833001 	add	r3, r3, r1
    8968:	e5d22000 	ldrb	r2, [r2]
    896c:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:32 (discriminator 2)
		output[j] = c;
    8970:	e51b300c 	ldr	r3, [fp, #-12]
    8974:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    8978:	e0823003 	add	r3, r2, r3
    897c:	e55b200d 	ldrb	r2, [fp, #-13]
    8980:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:28 (discriminator 2)
	for (int j = 0; j <= i/2; j++)
    8984:	e51b300c 	ldr	r3, [fp, #-12]
    8988:	e2833001 	add	r3, r3, #1
    898c:	e50b300c 	str	r3, [fp, #-12]
    8990:	eaffffdb 	b	8904 <_Z4itoajPcj+0xd4>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:34
	}
}
    8994:	e320f000 	nop	{0}
    8998:	e24bd004 	sub	sp, fp, #4
    899c:	e8bd8800 	pop	{fp, pc}
    89a0:	00008fc0 	andeq	r8, r0, r0, asr #31

000089a4 <_Z4atoiPKc>:
_Z4atoiPKc():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:37

int atoi(const char* input)
{
    89a4:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    89a8:	e28db000 	add	fp, sp, #0
    89ac:	e24dd014 	sub	sp, sp, #20
    89b0:	e50b0010 	str	r0, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:38
	int output = 0;
    89b4:	e3a03000 	mov	r3, #0
    89b8:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:40

	while (*input != '\0')
    89bc:	e51b3010 	ldr	r3, [fp, #-16]
    89c0:	e5d33000 	ldrb	r3, [r3]
    89c4:	e3530000 	cmp	r3, #0
    89c8:	0a000017 	beq	8a2c <_Z4atoiPKc+0x88>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:42
	{
		output *= 10;
    89cc:	e51b2008 	ldr	r2, [fp, #-8]
    89d0:	e1a03002 	mov	r3, r2
    89d4:	e1a03103 	lsl	r3, r3, #2
    89d8:	e0833002 	add	r3, r3, r2
    89dc:	e1a03083 	lsl	r3, r3, #1
    89e0:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:43
		if (*input > '9' || *input < '0')
    89e4:	e51b3010 	ldr	r3, [fp, #-16]
    89e8:	e5d33000 	ldrb	r3, [r3]
    89ec:	e3530039 	cmp	r3, #57	; 0x39
    89f0:	8a00000d 	bhi	8a2c <_Z4atoiPKc+0x88>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:43 (discriminator 1)
    89f4:	e51b3010 	ldr	r3, [fp, #-16]
    89f8:	e5d33000 	ldrb	r3, [r3]
    89fc:	e353002f 	cmp	r3, #47	; 0x2f
    8a00:	9a000009 	bls	8a2c <_Z4atoiPKc+0x88>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:46
			break;

		output += *input - '0';
    8a04:	e51b3010 	ldr	r3, [fp, #-16]
    8a08:	e5d33000 	ldrb	r3, [r3]
    8a0c:	e2433030 	sub	r3, r3, #48	; 0x30
    8a10:	e51b2008 	ldr	r2, [fp, #-8]
    8a14:	e0823003 	add	r3, r2, r3
    8a18:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:48

		input++;
    8a1c:	e51b3010 	ldr	r3, [fp, #-16]
    8a20:	e2833001 	add	r3, r3, #1
    8a24:	e50b3010 	str	r3, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:40
	while (*input != '\0')
    8a28:	eaffffe3 	b	89bc <_Z4atoiPKc+0x18>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:51
	}

	return output;
    8a2c:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:52
}
    8a30:	e1a00003 	mov	r0, r3
    8a34:	e28bd000 	add	sp, fp, #0
    8a38:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8a3c:	e12fff1e 	bx	lr

00008a40 <_Z7strncpyPcPKci>:
_Z7strncpyPcPKci():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:55

char* strncpy(char* dest, const char *src, int num)
{
    8a40:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8a44:	e28db000 	add	fp, sp, #0
    8a48:	e24dd01c 	sub	sp, sp, #28
    8a4c:	e50b0010 	str	r0, [fp, #-16]
    8a50:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8a54:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:58
	int i;

	for (i = 0; i < num && src[i] != '\0'; i++)
    8a58:	e3a03000 	mov	r3, #0
    8a5c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:58 (discriminator 4)
    8a60:	e51b2008 	ldr	r2, [fp, #-8]
    8a64:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8a68:	e1520003 	cmp	r2, r3
    8a6c:	aa000011 	bge	8ab8 <_Z7strncpyPcPKci+0x78>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:58 (discriminator 2)
    8a70:	e51b3008 	ldr	r3, [fp, #-8]
    8a74:	e51b2014 	ldr	r2, [fp, #-20]	; 0xffffffec
    8a78:	e0823003 	add	r3, r2, r3
    8a7c:	e5d33000 	ldrb	r3, [r3]
    8a80:	e3530000 	cmp	r3, #0
    8a84:	0a00000b 	beq	8ab8 <_Z7strncpyPcPKci+0x78>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:59 (discriminator 3)
		dest[i] = src[i];
    8a88:	e51b3008 	ldr	r3, [fp, #-8]
    8a8c:	e51b2014 	ldr	r2, [fp, #-20]	; 0xffffffec
    8a90:	e0822003 	add	r2, r2, r3
    8a94:	e51b3008 	ldr	r3, [fp, #-8]
    8a98:	e51b1010 	ldr	r1, [fp, #-16]
    8a9c:	e0813003 	add	r3, r1, r3
    8aa0:	e5d22000 	ldrb	r2, [r2]
    8aa4:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:58 (discriminator 3)
	for (i = 0; i < num && src[i] != '\0'; i++)
    8aa8:	e51b3008 	ldr	r3, [fp, #-8]
    8aac:	e2833001 	add	r3, r3, #1
    8ab0:	e50b3008 	str	r3, [fp, #-8]
    8ab4:	eaffffe9 	b	8a60 <_Z7strncpyPcPKci+0x20>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:60 (discriminator 2)
	for (; i < num; i++)
    8ab8:	e51b2008 	ldr	r2, [fp, #-8]
    8abc:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8ac0:	e1520003 	cmp	r2, r3
    8ac4:	aa000008 	bge	8aec <_Z7strncpyPcPKci+0xac>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:61 (discriminator 1)
		dest[i] = '\0';
    8ac8:	e51b3008 	ldr	r3, [fp, #-8]
    8acc:	e51b2010 	ldr	r2, [fp, #-16]
    8ad0:	e0823003 	add	r3, r2, r3
    8ad4:	e3a02000 	mov	r2, #0
    8ad8:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:60 (discriminator 1)
	for (; i < num; i++)
    8adc:	e51b3008 	ldr	r3, [fp, #-8]
    8ae0:	e2833001 	add	r3, r3, #1
    8ae4:	e50b3008 	str	r3, [fp, #-8]
    8ae8:	eafffff2 	b	8ab8 <_Z7strncpyPcPKci+0x78>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:63

   return dest;
    8aec:	e51b3010 	ldr	r3, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:64
}
    8af0:	e1a00003 	mov	r0, r3
    8af4:	e28bd000 	add	sp, fp, #0
    8af8:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8afc:	e12fff1e 	bx	lr

00008b00 <_Z7strncmpPKcS0_i>:
_Z7strncmpPKcS0_i():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:67

int strncmp(const char *s1, const char *s2, int num)
{
    8b00:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8b04:	e28db000 	add	fp, sp, #0
    8b08:	e24dd01c 	sub	sp, sp, #28
    8b0c:	e50b0010 	str	r0, [fp, #-16]
    8b10:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8b14:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:69
	unsigned char u1, u2;
  	while (num-- > 0)
    8b18:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8b1c:	e2432001 	sub	r2, r3, #1
    8b20:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
    8b24:	e3530000 	cmp	r3, #0
    8b28:	c3a03001 	movgt	r3, #1
    8b2c:	d3a03000 	movle	r3, #0
    8b30:	e6ef3073 	uxtb	r3, r3
    8b34:	e3530000 	cmp	r3, #0
    8b38:	0a000016 	beq	8b98 <_Z7strncmpPKcS0_i+0x98>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:71
    {
      	u1 = (unsigned char) *s1++;
    8b3c:	e51b3010 	ldr	r3, [fp, #-16]
    8b40:	e2832001 	add	r2, r3, #1
    8b44:	e50b2010 	str	r2, [fp, #-16]
    8b48:	e5d33000 	ldrb	r3, [r3]
    8b4c:	e54b3005 	strb	r3, [fp, #-5]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:72
     	u2 = (unsigned char) *s2++;
    8b50:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8b54:	e2832001 	add	r2, r3, #1
    8b58:	e50b2014 	str	r2, [fp, #-20]	; 0xffffffec
    8b5c:	e5d33000 	ldrb	r3, [r3]
    8b60:	e54b3006 	strb	r3, [fp, #-6]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:73
      	if (u1 != u2)
    8b64:	e55b2005 	ldrb	r2, [fp, #-5]
    8b68:	e55b3006 	ldrb	r3, [fp, #-6]
    8b6c:	e1520003 	cmp	r2, r3
    8b70:	0a000003 	beq	8b84 <_Z7strncmpPKcS0_i+0x84>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:74
        	return u1 - u2;
    8b74:	e55b2005 	ldrb	r2, [fp, #-5]
    8b78:	e55b3006 	ldrb	r3, [fp, #-6]
    8b7c:	e0423003 	sub	r3, r2, r3
    8b80:	ea000005 	b	8b9c <_Z7strncmpPKcS0_i+0x9c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:75
      	if (u1 == '\0')
    8b84:	e55b3005 	ldrb	r3, [fp, #-5]
    8b88:	e3530000 	cmp	r3, #0
    8b8c:	1affffe1 	bne	8b18 <_Z7strncmpPKcS0_i+0x18>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:76
        	return 0;
    8b90:	e3a03000 	mov	r3, #0
    8b94:	ea000000 	b	8b9c <_Z7strncmpPKcS0_i+0x9c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:79
    }

  	return 0;
    8b98:	e3a03000 	mov	r3, #0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:80
}
    8b9c:	e1a00003 	mov	r0, r3
    8ba0:	e28bd000 	add	sp, fp, #0
    8ba4:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8ba8:	e12fff1e 	bx	lr

00008bac <_Z6strlenPKc>:
_Z6strlenPKc():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:83

int strlen(const char* s)
{
    8bac:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8bb0:	e28db000 	add	fp, sp, #0
    8bb4:	e24dd014 	sub	sp, sp, #20
    8bb8:	e50b0010 	str	r0, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:84
	int i = 0;
    8bbc:	e3a03000 	mov	r3, #0
    8bc0:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:86

	while (s[i] != '\0')
    8bc4:	e51b3008 	ldr	r3, [fp, #-8]
    8bc8:	e51b2010 	ldr	r2, [fp, #-16]
    8bcc:	e0823003 	add	r3, r2, r3
    8bd0:	e5d33000 	ldrb	r3, [r3]
    8bd4:	e3530000 	cmp	r3, #0
    8bd8:	0a000003 	beq	8bec <_Z6strlenPKc+0x40>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:87
		i++;
    8bdc:	e51b3008 	ldr	r3, [fp, #-8]
    8be0:	e2833001 	add	r3, r3, #1
    8be4:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:86
	while (s[i] != '\0')
    8be8:	eafffff5 	b	8bc4 <_Z6strlenPKc+0x18>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:89

	return i;
    8bec:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:90
}
    8bf0:	e1a00003 	mov	r0, r3
    8bf4:	e28bd000 	add	sp, fp, #0
    8bf8:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8bfc:	e12fff1e 	bx	lr

00008c00 <_Z5bzeroPvi>:
_Z5bzeroPvi():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:93

void bzero(void* memory, int length)
{
    8c00:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8c04:	e28db000 	add	fp, sp, #0
    8c08:	e24dd014 	sub	sp, sp, #20
    8c0c:	e50b0010 	str	r0, [fp, #-16]
    8c10:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:94
	char* mem = reinterpret_cast<char*>(memory);
    8c14:	e51b3010 	ldr	r3, [fp, #-16]
    8c18:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:96

	for (int i = 0; i < length; i++)
    8c1c:	e3a03000 	mov	r3, #0
    8c20:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:96 (discriminator 3)
    8c24:	e51b2008 	ldr	r2, [fp, #-8]
    8c28:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8c2c:	e1520003 	cmp	r2, r3
    8c30:	aa000008 	bge	8c58 <_Z5bzeroPvi+0x58>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:97 (discriminator 2)
		mem[i] = 0;
    8c34:	e51b3008 	ldr	r3, [fp, #-8]
    8c38:	e51b200c 	ldr	r2, [fp, #-12]
    8c3c:	e0823003 	add	r3, r2, r3
    8c40:	e3a02000 	mov	r2, #0
    8c44:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:96 (discriminator 2)
	for (int i = 0; i < length; i++)
    8c48:	e51b3008 	ldr	r3, [fp, #-8]
    8c4c:	e2833001 	add	r3, r3, #1
    8c50:	e50b3008 	str	r3, [fp, #-8]
    8c54:	eafffff2 	b	8c24 <_Z5bzeroPvi+0x24>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:98
}
    8c58:	e320f000 	nop	{0}
    8c5c:	e28bd000 	add	sp, fp, #0
    8c60:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8c64:	e12fff1e 	bx	lr

00008c68 <_Z6memcpyPKvPvi>:
_Z6memcpyPKvPvi():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:101

void memcpy(const void* src, void* dst, int num)
{
    8c68:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8c6c:	e28db000 	add	fp, sp, #0
    8c70:	e24dd024 	sub	sp, sp, #36	; 0x24
    8c74:	e50b0018 	str	r0, [fp, #-24]	; 0xffffffe8
    8c78:	e50b101c 	str	r1, [fp, #-28]	; 0xffffffe4
    8c7c:	e50b2020 	str	r2, [fp, #-32]	; 0xffffffe0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:102
	const char* memsrc = reinterpret_cast<const char*>(src);
    8c80:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8c84:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:103
	char* memdst = reinterpret_cast<char*>(dst);
    8c88:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    8c8c:	e50b3010 	str	r3, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:105

	for (int i = 0; i < num; i++)
    8c90:	e3a03000 	mov	r3, #0
    8c94:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:105 (discriminator 3)
    8c98:	e51b2008 	ldr	r2, [fp, #-8]
    8c9c:	e51b3020 	ldr	r3, [fp, #-32]	; 0xffffffe0
    8ca0:	e1520003 	cmp	r2, r3
    8ca4:	aa00000b 	bge	8cd8 <_Z6memcpyPKvPvi+0x70>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:106 (discriminator 2)
		memdst[i] = memsrc[i];
    8ca8:	e51b3008 	ldr	r3, [fp, #-8]
    8cac:	e51b200c 	ldr	r2, [fp, #-12]
    8cb0:	e0822003 	add	r2, r2, r3
    8cb4:	e51b3008 	ldr	r3, [fp, #-8]
    8cb8:	e51b1010 	ldr	r1, [fp, #-16]
    8cbc:	e0813003 	add	r3, r1, r3
    8cc0:	e5d22000 	ldrb	r2, [r2]
    8cc4:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:105 (discriminator 2)
	for (int i = 0; i < num; i++)
    8cc8:	e51b3008 	ldr	r3, [fp, #-8]
    8ccc:	e2833001 	add	r3, r3, #1
    8cd0:	e50b3008 	str	r3, [fp, #-8]
    8cd4:	eaffffef 	b	8c98 <_Z6memcpyPKvPvi+0x30>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:107
}
    8cd8:	e320f000 	nop	{0}
    8cdc:	e28bd000 	add	sp, fp, #0
    8ce0:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8ce4:	e12fff1e 	bx	lr

00008ce8 <__udivsi3>:
__udivsi3():
    8ce8:	e2512001 	subs	r2, r1, #1
    8cec:	012fff1e 	bxeq	lr
    8cf0:	3a000074 	bcc	8ec8 <__udivsi3+0x1e0>
    8cf4:	e1500001 	cmp	r0, r1
    8cf8:	9a00006b 	bls	8eac <__udivsi3+0x1c4>
    8cfc:	e1110002 	tst	r1, r2
    8d00:	0a00006c 	beq	8eb8 <__udivsi3+0x1d0>
    8d04:	e16f3f10 	clz	r3, r0
    8d08:	e16f2f11 	clz	r2, r1
    8d0c:	e0423003 	sub	r3, r2, r3
    8d10:	e273301f 	rsbs	r3, r3, #31
    8d14:	10833083 	addne	r3, r3, r3, lsl #1
    8d18:	e3a02000 	mov	r2, #0
    8d1c:	108ff103 	addne	pc, pc, r3, lsl #2
    8d20:	e1a00000 	nop			; (mov r0, r0)
    8d24:	e1500f81 	cmp	r0, r1, lsl #31
    8d28:	e0a22002 	adc	r2, r2, r2
    8d2c:	20400f81 	subcs	r0, r0, r1, lsl #31
    8d30:	e1500f01 	cmp	r0, r1, lsl #30
    8d34:	e0a22002 	adc	r2, r2, r2
    8d38:	20400f01 	subcs	r0, r0, r1, lsl #30
    8d3c:	e1500e81 	cmp	r0, r1, lsl #29
    8d40:	e0a22002 	adc	r2, r2, r2
    8d44:	20400e81 	subcs	r0, r0, r1, lsl #29
    8d48:	e1500e01 	cmp	r0, r1, lsl #28
    8d4c:	e0a22002 	adc	r2, r2, r2
    8d50:	20400e01 	subcs	r0, r0, r1, lsl #28
    8d54:	e1500d81 	cmp	r0, r1, lsl #27
    8d58:	e0a22002 	adc	r2, r2, r2
    8d5c:	20400d81 	subcs	r0, r0, r1, lsl #27
    8d60:	e1500d01 	cmp	r0, r1, lsl #26
    8d64:	e0a22002 	adc	r2, r2, r2
    8d68:	20400d01 	subcs	r0, r0, r1, lsl #26
    8d6c:	e1500c81 	cmp	r0, r1, lsl #25
    8d70:	e0a22002 	adc	r2, r2, r2
    8d74:	20400c81 	subcs	r0, r0, r1, lsl #25
    8d78:	e1500c01 	cmp	r0, r1, lsl #24
    8d7c:	e0a22002 	adc	r2, r2, r2
    8d80:	20400c01 	subcs	r0, r0, r1, lsl #24
    8d84:	e1500b81 	cmp	r0, r1, lsl #23
    8d88:	e0a22002 	adc	r2, r2, r2
    8d8c:	20400b81 	subcs	r0, r0, r1, lsl #23
    8d90:	e1500b01 	cmp	r0, r1, lsl #22
    8d94:	e0a22002 	adc	r2, r2, r2
    8d98:	20400b01 	subcs	r0, r0, r1, lsl #22
    8d9c:	e1500a81 	cmp	r0, r1, lsl #21
    8da0:	e0a22002 	adc	r2, r2, r2
    8da4:	20400a81 	subcs	r0, r0, r1, lsl #21
    8da8:	e1500a01 	cmp	r0, r1, lsl #20
    8dac:	e0a22002 	adc	r2, r2, r2
    8db0:	20400a01 	subcs	r0, r0, r1, lsl #20
    8db4:	e1500981 	cmp	r0, r1, lsl #19
    8db8:	e0a22002 	adc	r2, r2, r2
    8dbc:	20400981 	subcs	r0, r0, r1, lsl #19
    8dc0:	e1500901 	cmp	r0, r1, lsl #18
    8dc4:	e0a22002 	adc	r2, r2, r2
    8dc8:	20400901 	subcs	r0, r0, r1, lsl #18
    8dcc:	e1500881 	cmp	r0, r1, lsl #17
    8dd0:	e0a22002 	adc	r2, r2, r2
    8dd4:	20400881 	subcs	r0, r0, r1, lsl #17
    8dd8:	e1500801 	cmp	r0, r1, lsl #16
    8ddc:	e0a22002 	adc	r2, r2, r2
    8de0:	20400801 	subcs	r0, r0, r1, lsl #16
    8de4:	e1500781 	cmp	r0, r1, lsl #15
    8de8:	e0a22002 	adc	r2, r2, r2
    8dec:	20400781 	subcs	r0, r0, r1, lsl #15
    8df0:	e1500701 	cmp	r0, r1, lsl #14
    8df4:	e0a22002 	adc	r2, r2, r2
    8df8:	20400701 	subcs	r0, r0, r1, lsl #14
    8dfc:	e1500681 	cmp	r0, r1, lsl #13
    8e00:	e0a22002 	adc	r2, r2, r2
    8e04:	20400681 	subcs	r0, r0, r1, lsl #13
    8e08:	e1500601 	cmp	r0, r1, lsl #12
    8e0c:	e0a22002 	adc	r2, r2, r2
    8e10:	20400601 	subcs	r0, r0, r1, lsl #12
    8e14:	e1500581 	cmp	r0, r1, lsl #11
    8e18:	e0a22002 	adc	r2, r2, r2
    8e1c:	20400581 	subcs	r0, r0, r1, lsl #11
    8e20:	e1500501 	cmp	r0, r1, lsl #10
    8e24:	e0a22002 	adc	r2, r2, r2
    8e28:	20400501 	subcs	r0, r0, r1, lsl #10
    8e2c:	e1500481 	cmp	r0, r1, lsl #9
    8e30:	e0a22002 	adc	r2, r2, r2
    8e34:	20400481 	subcs	r0, r0, r1, lsl #9
    8e38:	e1500401 	cmp	r0, r1, lsl #8
    8e3c:	e0a22002 	adc	r2, r2, r2
    8e40:	20400401 	subcs	r0, r0, r1, lsl #8
    8e44:	e1500381 	cmp	r0, r1, lsl #7
    8e48:	e0a22002 	adc	r2, r2, r2
    8e4c:	20400381 	subcs	r0, r0, r1, lsl #7
    8e50:	e1500301 	cmp	r0, r1, lsl #6
    8e54:	e0a22002 	adc	r2, r2, r2
    8e58:	20400301 	subcs	r0, r0, r1, lsl #6
    8e5c:	e1500281 	cmp	r0, r1, lsl #5
    8e60:	e0a22002 	adc	r2, r2, r2
    8e64:	20400281 	subcs	r0, r0, r1, lsl #5
    8e68:	e1500201 	cmp	r0, r1, lsl #4
    8e6c:	e0a22002 	adc	r2, r2, r2
    8e70:	20400201 	subcs	r0, r0, r1, lsl #4
    8e74:	e1500181 	cmp	r0, r1, lsl #3
    8e78:	e0a22002 	adc	r2, r2, r2
    8e7c:	20400181 	subcs	r0, r0, r1, lsl #3
    8e80:	e1500101 	cmp	r0, r1, lsl #2
    8e84:	e0a22002 	adc	r2, r2, r2
    8e88:	20400101 	subcs	r0, r0, r1, lsl #2
    8e8c:	e1500081 	cmp	r0, r1, lsl #1
    8e90:	e0a22002 	adc	r2, r2, r2
    8e94:	20400081 	subcs	r0, r0, r1, lsl #1
    8e98:	e1500001 	cmp	r0, r1
    8e9c:	e0a22002 	adc	r2, r2, r2
    8ea0:	20400001 	subcs	r0, r0, r1
    8ea4:	e1a00002 	mov	r0, r2
    8ea8:	e12fff1e 	bx	lr
    8eac:	03a00001 	moveq	r0, #1
    8eb0:	13a00000 	movne	r0, #0
    8eb4:	e12fff1e 	bx	lr
    8eb8:	e16f2f11 	clz	r2, r1
    8ebc:	e262201f 	rsb	r2, r2, #31
    8ec0:	e1a00230 	lsr	r0, r0, r2
    8ec4:	e12fff1e 	bx	lr
    8ec8:	e3500000 	cmp	r0, #0
    8ecc:	13e00000 	mvnne	r0, #0
    8ed0:	ea000007 	b	8ef4 <__aeabi_idiv0>

00008ed4 <__aeabi_uidivmod>:
__aeabi_uidivmod():
    8ed4:	e3510000 	cmp	r1, #0
    8ed8:	0afffffa 	beq	8ec8 <__udivsi3+0x1e0>
    8edc:	e92d4003 	push	{r0, r1, lr}
    8ee0:	ebffff80 	bl	8ce8 <__udivsi3>
    8ee4:	e8bd4006 	pop	{r1, r2, lr}
    8ee8:	e0030092 	mul	r3, r2, r0
    8eec:	e0411003 	sub	r1, r1, r3
    8ef0:	e12fff1e 	bx	lr

00008ef4 <__aeabi_idiv0>:
__aeabi_ldiv0():
    8ef4:	e12fff1e 	bx	lr

Disassembly of section .rodata:

00008ef8 <_ZL13Lock_Unlocked>:
    8ef8:	00000000 	andeq	r0, r0, r0

00008efc <_ZL11Lock_Locked>:
    8efc:	00000001 	andeq	r0, r0, r1

00008f00 <_ZL21MaxFSDriverNameLength>:
    8f00:	00000010 	andeq	r0, r0, r0, lsl r0

00008f04 <_ZL17MaxFilenameLength>:
    8f04:	00000010 	andeq	r0, r0, r0, lsl r0

00008f08 <_ZL13MaxPathLength>:
    8f08:	00000080 	andeq	r0, r0, r0, lsl #1

00008f0c <_ZL18NoFilesystemDriver>:
    8f0c:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008f10 <_ZL9NotifyAll>:
    8f10:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008f14 <_ZL24Max_Process_Opened_Files>:
    8f14:	00000010 	andeq	r0, r0, r0, lsl r0

00008f18 <_ZL10Indefinite>:
    8f18:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008f1c <_ZL18Deadline_Unchanged>:
    8f1c:	fffffffe 			; <UNDEFINED> instruction: 0xfffffffe

00008f20 <_ZL14Invalid_Handle>:
    8f20:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008f24 <_ZN3halL18Default_Clock_RateE>:
    8f24:	0ee6b280 	cdpeq	2, 14, cr11, cr6, cr0, {4}

00008f28 <_ZN3halL15Peripheral_BaseE>:
    8f28:	20000000 	andcs	r0, r0, r0

00008f2c <_ZN3halL9GPIO_BaseE>:
    8f2c:	20200000 	eorcs	r0, r0, r0

00008f30 <_ZN3halL14GPIO_Pin_CountE>:
    8f30:	00000036 	andeq	r0, r0, r6, lsr r0

00008f34 <_ZN3halL8AUX_BaseE>:
    8f34:	20215000 	eorcs	r5, r1, r0

00008f38 <_ZN3halL25Interrupt_Controller_BaseE>:
    8f38:	2000b200 	andcs	fp, r0, r0, lsl #4

00008f3c <_ZN3halL10Timer_BaseE>:
    8f3c:	2000b400 	andcs	fp, r0, r0, lsl #8

00008f40 <_ZN3halL9TRNG_BaseE>:
    8f40:	20104000 	andscs	r4, r0, r0

00008f44 <_ZN3halL9BSC0_BaseE>:
    8f44:	20205000 	eorcs	r5, r0, r0

00008f48 <_ZN3halL9BSC1_BaseE>:
    8f48:	20804000 	addcs	r4, r0, r0

00008f4c <_ZN3halL9BSC2_BaseE>:
    8f4c:	20805000 	addcs	r5, r0, r0

00008f50 <_ZN3halL14I2C_SLAVE_BaseE>:
    8f50:	20214000 	eorcs	r4, r1, r0

00008f54 <_ZL11Invalid_Pin>:
    8f54:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008f58 <_ZL17symbol_tick_delay>:
    8f58:	00000400 	andeq	r0, r0, r0, lsl #8

00008f5c <_ZL15char_tick_delay>:
    8f5c:	00001000 	andeq	r1, r0, r0
    8f60:	00000031 	andeq	r0, r0, r1, lsr r0
    8f64:	00000030 	andeq	r0, r0, r0, lsr r0
    8f68:	3a564544 	bcc	159a480 <__bss_end+0x1591494>
    8f6c:	6f697067 	svcvs	0x00697067
    8f70:	0037342f 	eorseq	r3, r7, pc, lsr #8
    8f74:	3a564544 	bcc	159a48c <__bss_end+0x15914a0>
    8f78:	74726175 	ldrbtvc	r6, [r2], #-373	; 0xfffffe8b
    8f7c:	0000302f 	andeq	r3, r0, pc, lsr #32
    8f80:	21534f53 	cmpcs	r3, r3, asr pc
    8f84:	00000000 	andeq	r0, r0, r0

00008f88 <_ZL13Lock_Unlocked>:
    8f88:	00000000 	andeq	r0, r0, r0

00008f8c <_ZL11Lock_Locked>:
    8f8c:	00000001 	andeq	r0, r0, r1

00008f90 <_ZL21MaxFSDriverNameLength>:
    8f90:	00000010 	andeq	r0, r0, r0, lsl r0

00008f94 <_ZL17MaxFilenameLength>:
    8f94:	00000010 	andeq	r0, r0, r0, lsl r0

00008f98 <_ZL13MaxPathLength>:
    8f98:	00000080 	andeq	r0, r0, r0, lsl #1

00008f9c <_ZL18NoFilesystemDriver>:
    8f9c:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008fa0 <_ZL9NotifyAll>:
    8fa0:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008fa4 <_ZL24Max_Process_Opened_Files>:
    8fa4:	00000010 	andeq	r0, r0, r0, lsl r0

00008fa8 <_ZL10Indefinite>:
    8fa8:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008fac <_ZL18Deadline_Unchanged>:
    8fac:	fffffffe 			; <UNDEFINED> instruction: 0xfffffffe

00008fb0 <_ZL14Invalid_Handle>:
    8fb0:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008fb4 <_ZL16Pipe_File_Prefix>:
    8fb4:	3a535953 	bcc	14df508 <__bss_end+0x14d651c>
    8fb8:	65706970 	ldrbvs	r6, [r0, #-2416]!	; 0xfffff690
    8fbc:	0000002f 	andeq	r0, r0, pc, lsr #32

00008fc0 <_ZN12_GLOBAL__N_1L11CharConvArrE>:
    8fc0:	33323130 	teqcc	r2, #48, 2
    8fc4:	37363534 			; <UNDEFINED> instruction: 0x37363534
    8fc8:	42413938 	submi	r3, r1, #56, 18	; 0xe0000
    8fcc:	46454443 	strbmi	r4, [r5], -r3, asr #8
	...

Disassembly of section .bss:

00008fd4 <sos_led>:
__bss_start():
    8fd4:	00000000 	andeq	r0, r0, r0

00008fd8 <uart>:
	...

Disassembly of section .ARM.attributes:

00000000 <.ARM.attributes>:
   0:	00002e41 	andeq	r2, r0, r1, asr #28
   4:	61656100 	cmnvs	r5, r0, lsl #2
   8:	01006962 	tsteq	r0, r2, ror #18
   c:	00000024 	andeq	r0, r0, r4, lsr #32
  10:	4b5a3605 	blmi	168d82c <__bss_end+0x1684840>
  14:	08070600 	stmdaeq	r7, {r9, sl}
  18:	0a010901 	beq	42424 <__bss_end+0x39438>
  1c:	14041202 	strne	r1, [r4], #-514	; 0xfffffdfe
  20:	17011501 	strne	r1, [r1, -r1, lsl #10]
  24:	1a011803 	bne	46038 <__bss_end+0x3d04c>
  28:	22011c01 	andcs	r1, r1, #256	; 0x100
  2c:	Address 0x000000000000002c is out of bounds.


Disassembly of section .comment:

00000000 <.comment>:
   0:	3a434347 	bcc	10d0d24 <__bss_end+0x10c7d38>
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
  38:	7a617661 	bvc	185d9c4 <__bss_end+0x18549d8>
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
  c0:	6a757a61 	bvs	1d5ea4c <__bss_end+0x1d55a60>
  c4:	2f696369 	svccs	0x00696369
  c8:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
  cc:	73656d65 	cmnvc	r5, #6464	; 0x1940
  d0:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
  d4:	6b2d616b 	blvs	b58688 <__bss_end+0xb4f69c>
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
 144:	fb010200 	blx	4094e <__bss_end+0x37962>
 148:	01000d0e 	tsteq	r0, lr, lsl #26
 14c:	00010101 	andeq	r0, r1, r1, lsl #2
 150:	00010000 	andeq	r0, r1, r0
 154:	552f0100 	strpl	r0, [pc, #-256]!	; 5c <shift+0x5c>
 158:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 15c:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 160:	6a726574 	bvs	1c99738 <__bss_end+0x1c9074c>
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
 198:	752f7365 	strvc	r7, [pc, #-869]!	; fffffe3b <__bss_end+0xffff6e4f>
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
 1d0:	0a05830b 	beq	160e04 <__bss_end+0x157e18>
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
 1fc:	4a030402 	bmi	c120c <__bss_end+0xb8220>
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
 230:	4a020402 	bmi	81240 <__bss_end+0x78254>
 234:	02000205 	andeq	r0, r0, #1342177280	; 0x50000000
 238:	052d0204 	streq	r0, [sp, #-516]!	; 0xfffffdfc
 23c:	01058509 	tsteq	r5, r9, lsl #10
 240:	000a022f 	andeq	r0, sl, pc, lsr #4
 244:	033c0101 	teqeq	ip, #1073741824	; 0x40000000
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
 280:	6a757a61 	bvs	1d5ec0c <__bss_end+0x1d55c20>
 284:	2f696369 	svccs	0x00696369
 288:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
 28c:	73656d65 	cmnvc	r5, #6464	; 0x1940
 290:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
 294:	6b2d616b 	blvs	b58848 <__bss_end+0xb4f85c>
 298:	6f2d7669 	svcvs	0x002d7669
 29c:	6f732f73 	svcvs	0x00732f73
 2a0:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
 2a4:	73752f73 	cmnvc	r5, #460	; 0x1cc
 2a8:	70737265 	rsbsvc	r7, r3, r5, ror #4
 2ac:	2f656361 	svccs	0x00656361
 2b0:	5f736f73 	svcpl	0x00736f73
 2b4:	6b736174 	blvs	1cd888c <__bss_end+0x1ccf8a0>
 2b8:	73552f00 	cmpvc	r5, #0, 30
 2bc:	2f737265 	svccs	0x00737265
 2c0:	746e6977 	strbtvc	r6, [lr], #-2423	; 0xfffff689
 2c4:	696a7265 	stmdbvs	sl!, {r0, r2, r5, r6, r9, ip, sp, lr}^
 2c8:	7365442f 	cmnvc	r5, #788529152	; 0x2f000000
 2cc:	706f746b 	rsbvc	r7, pc, fp, ror #8
 2d0:	5641462f 	strbpl	r4, [r1], -pc, lsr #12
 2d4:	76614e2f 	strbtvc	r4, [r1], -pc, lsr #28
 2d8:	6a757a61 	bvs	1d5ec64 <__bss_end+0x1d55c78>
 2dc:	2f696369 	svccs	0x00696369
 2e0:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
 2e4:	73656d65 	cmnvc	r5, #6464	; 0x1940
 2e8:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
 2ec:	6b2d616b 	blvs	b588a0 <__bss_end+0xb4f8b4>
 2f0:	6f2d7669 	svcvs	0x002d7669
 2f4:	6f732f73 	svcvs	0x00732f73
 2f8:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
 2fc:	73752f73 	cmnvc	r5, #460	; 0x1cc
 300:	70737265 	rsbsvc	r7, r3, r5, ror #4
 304:	2f656361 	svccs	0x00656361
 308:	6b2f2e2e 	blvs	bcbbc8 <__bss_end+0xbc2bdc>
 30c:	656e7265 	strbvs	r7, [lr, #-613]!	; 0xfffffd9b
 310:	6e692f6c 	cdpvs	15, 6, cr2, cr9, cr12, {3}
 314:	64756c63 	ldrbtvs	r6, [r5], #-3171	; 0xfffff39d
 318:	72702f65 	rsbsvc	r2, r0, #404	; 0x194
 31c:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
 320:	552f0073 	strpl	r0, [pc, #-115]!	; 2b5 <shift+0x2b5>
 324:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 328:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 32c:	6a726574 	bvs	1c99904 <__bss_end+0x1c90918>
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
 390:	6a726574 	bvs	1c99968 <__bss_end+0x1c9097c>
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
 400:	6a726574 	bvs	1c999d8 <__bss_end+0x1c909ec>
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
 4e4:	13030000 	movwne	r0, #12288	; 0x3000
 4e8:	9f070501 	svcls	0x00070501
 4ec:	040200bb 	streq	r0, [r2], #-187	; 0xffffff45
 4f0:	00660601 	rsbeq	r0, r6, r1, lsl #12
 4f4:	4a020402 	bmi	81504 <__bss_end+0x78518>
 4f8:	04040200 	streq	r0, [r4], #-512	; 0xfffffe00
 4fc:	0402002e 	streq	r0, [r2], #-46	; 0xffffffd2
 500:	05670604 	strbeq	r0, [r7, #-1540]!	; 0xfffff9fc
 504:	04020001 	streq	r0, [r2], #-1
 508:	05bdbb04 	ldreq	fp, [sp, #2820]!	; 0xb04
 50c:	0a059f10 	beq	168154 <__bss_end+0x15f168>
 510:	4b0d0582 	blmi	341b20 <__bss_end+0x338b34>
 514:	05820705 	streq	r0, [r2, #1797]	; 0x705
 518:	04020008 	streq	r0, [r2], #-8
 51c:	4a0c0301 	bmi	301128 <__bss_end+0x2f813c>
 520:	01040200 	mrseq	r0, R12_usr
 524:	040200bc 	streq	r0, [r2], #-188	; 0xffffff44
 528:	02004b01 	andeq	r4, r0, #1024	; 0x400
 52c:	00670104 	rsbeq	r0, r7, r4, lsl #2
 530:	4b010402 	blmi	41540 <__bss_end+0x38554>
 534:	01040200 	mrseq	r0, R12_usr
 538:	04020067 	streq	r0, [r2], #-103	; 0xffffff99
 53c:	02004c01 	andeq	r4, r0, #256	; 0x100
 540:	00680104 	rsbeq	r0, r8, r4, lsl #2
 544:	4b010402 	blmi	41554 <__bss_end+0x38568>
 548:	01040200 	mrseq	r0, R12_usr
 54c:	04020067 	streq	r0, [r2], #-103	; 0xffffff99
 550:	02004b01 	andeq	r4, r0, #1024	; 0x400
 554:	00670104 	rsbeq	r0, r7, r4, lsl #2
 558:	4b010402 	blmi	41568 <__bss_end+0x3857c>
 55c:	01040200 	mrseq	r0, R12_usr
 560:	04020068 	streq	r0, [r2], #-104	; 0xffffff98
 564:	02006801 	andeq	r6, r0, #65536	; 0x10000
 568:	004b0104 	subeq	r0, fp, r4, lsl #2
 56c:	67010402 	strvs	r0, [r1, -r2, lsl #8]
 570:	01040200 	mrseq	r0, R12_usr
 574:	0402004b 	streq	r0, [r2], #-75	; 0xffffffb5
 578:	02006701 	andeq	r6, r0, #262144	; 0x40000
 57c:	69030104 	stmdbvs	r3, {r2, r8}
 580:	000c024a 	andeq	r0, ip, sl, asr #4
 584:	02c80101 	sbceq	r0, r8, #1073741824	; 0x40000000
 588:	00030000 	andeq	r0, r3, r0
 58c:	000001dd 	ldrdeq	r0, [r0], -sp
 590:	0efb0102 	cdpeq	1, 15, cr0, cr11, cr2, {0}
 594:	0101000d 	tsteq	r1, sp
 598:	00000101 	andeq	r0, r0, r1, lsl #2
 59c:	00000100 	andeq	r0, r0, r0, lsl #2
 5a0:	73552f01 	cmpvc	r5, #1, 30
 5a4:	2f737265 	svccs	0x00737265
 5a8:	746e6977 	strbtvc	r6, [lr], #-2423	; 0xfffff689
 5ac:	696a7265 	stmdbvs	sl!, {r0, r2, r5, r6, r9, ip, sp, lr}^
 5b0:	7365442f 	cmnvc	r5, #788529152	; 0x2f000000
 5b4:	706f746b 	rsbvc	r7, pc, fp, ror #8
 5b8:	5641462f 	strbpl	r4, [r1], -pc, lsr #12
 5bc:	76614e2f 	strbtvc	r4, [r1], -pc, lsr #28
 5c0:	6a757a61 	bvs	1d5ef4c <__bss_end+0x1d55f60>
 5c4:	2f696369 	svccs	0x00696369
 5c8:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
 5cc:	73656d65 	cmnvc	r5, #6464	; 0x1940
 5d0:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
 5d4:	6b2d616b 	blvs	b58b88 <__bss_end+0xb4fb9c>
 5d8:	6f2d7669 	svcvs	0x002d7669
 5dc:	6f732f73 	svcvs	0x00732f73
 5e0:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
 5e4:	74732f73 	ldrbtvc	r2, [r3], #-3955	; 0xfffff08d
 5e8:	62696c64 	rsbvs	r6, r9, #100, 24	; 0x6400
 5ec:	6372732f 	cmnvs	r2, #-1140850688	; 0xbc000000
 5f0:	73552f00 	cmpvc	r5, #0, 30
 5f4:	2f737265 	svccs	0x00737265
 5f8:	746e6977 	strbtvc	r6, [lr], #-2423	; 0xfffff689
 5fc:	696a7265 	stmdbvs	sl!, {r0, r2, r5, r6, r9, ip, sp, lr}^
 600:	7365442f 	cmnvc	r5, #788529152	; 0x2f000000
 604:	706f746b 	rsbvc	r7, pc, fp, ror #8
 608:	5641462f 	strbpl	r4, [r1], -pc, lsr #12
 60c:	76614e2f 	strbtvc	r4, [r1], -pc, lsr #28
 610:	6a757a61 	bvs	1d5ef9c <__bss_end+0x1d55fb0>
 614:	2f696369 	svccs	0x00696369
 618:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
 61c:	73656d65 	cmnvc	r5, #6464	; 0x1940
 620:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
 624:	6b2d616b 	blvs	b58bd8 <__bss_end+0xb4fbec>
 628:	6f2d7669 	svcvs	0x002d7669
 62c:	6f732f73 	svcvs	0x00732f73
 630:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
 634:	656b2f73 	strbvs	r2, [fp, #-3955]!	; 0xfffff08d
 638:	6c656e72 	stclvs	14, cr6, [r5], #-456	; 0xfffffe38
 63c:	636e692f 	cmnvs	lr, #770048	; 0xbc000
 640:	6564756c 	strbvs	r7, [r4, #-1388]!	; 0xfffffa94
 644:	6f72702f 	svcvs	0x0072702f
 648:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
 64c:	73552f00 	cmpvc	r5, #0, 30
 650:	2f737265 	svccs	0x00737265
 654:	746e6977 	strbtvc	r6, [lr], #-2423	; 0xfffff689
 658:	696a7265 	stmdbvs	sl!, {r0, r2, r5, r6, r9, ip, sp, lr}^
 65c:	7365442f 	cmnvc	r5, #788529152	; 0x2f000000
 660:	706f746b 	rsbvc	r7, pc, fp, ror #8
 664:	5641462f 	strbpl	r4, [r1], -pc, lsr #12
 668:	76614e2f 	strbtvc	r4, [r1], -pc, lsr #28
 66c:	6a757a61 	bvs	1d5eff8 <__bss_end+0x1d5600c>
 670:	2f696369 	svccs	0x00696369
 674:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
 678:	73656d65 	cmnvc	r5, #6464	; 0x1940
 67c:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
 680:	6b2d616b 	blvs	b58c34 <__bss_end+0xb4fc48>
 684:	6f2d7669 	svcvs	0x002d7669
 688:	6f732f73 	svcvs	0x00732f73
 68c:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
 690:	656b2f73 	strbvs	r2, [fp, #-3955]!	; 0xfffff08d
 694:	6c656e72 	stclvs	14, cr6, [r5], #-456	; 0xfffffe38
 698:	636e692f 	cmnvs	lr, #770048	; 0xbc000
 69c:	6564756c 	strbvs	r7, [r4, #-1388]!	; 0xfffffa94
 6a0:	0073662f 	rsbseq	r6, r3, pc, lsr #12
 6a4:	6573552f 	ldrbvs	r5, [r3, #-1327]!	; 0xfffffad1
 6a8:	772f7372 			; <UNDEFINED> instruction: 0x772f7372
 6ac:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
 6b0:	2f696a72 	svccs	0x00696a72
 6b4:	6b736544 	blvs	1cd9bcc <__bss_end+0x1cd0be0>
 6b8:	2f706f74 	svccs	0x00706f74
 6bc:	2f564146 	svccs	0x00564146
 6c0:	6176614e 	cmnvs	r6, lr, asr #2
 6c4:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
 6c8:	4f2f6963 	svcmi	0x002f6963
 6cc:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
 6d0:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
 6d4:	6b6c6172 	blvs	1b18ca4 <__bss_end+0x1b0fcb8>
 6d8:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
 6dc:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
 6e0:	756f732f 	strbvc	r7, [pc, #-815]!	; 3b9 <shift+0x3b9>
 6e4:	73656372 	cmnvc	r5, #-939524095	; 0xc8000001
 6e8:	72656b2f 	rsbvc	r6, r5, #48128	; 0xbc00
 6ec:	2f6c656e 	svccs	0x006c656e
 6f0:	6c636e69 	stclvs	14, cr6, [r3], #-420	; 0xfffffe5c
 6f4:	2f656475 	svccs	0x00656475
 6f8:	72616f62 	rsbvc	r6, r1, #392	; 0x188
 6fc:	70722f64 	rsbsvc	r2, r2, r4, ror #30
 700:	682f3069 	stmdavs	pc!, {r0, r3, r5, r6, ip, sp}	; <UNPREDICTABLE>
 704:	00006c61 	andeq	r6, r0, r1, ror #24
 708:	66647473 			; <UNDEFINED> instruction: 0x66647473
 70c:	2e656c69 	cdpcs	12, 6, cr6, cr5, cr9, {3}
 710:	00707063 	rsbseq	r7, r0, r3, rrx
 714:	73000001 	movwvc	r0, #1
 718:	682e6977 	stmdavs	lr!, {r0, r1, r2, r4, r5, r6, r8, fp, sp, lr}
 71c:	00000200 	andeq	r0, r0, r0, lsl #4
 720:	6e697073 	mcrvs	0, 3, r7, cr9, cr3, {3}
 724:	6b636f6c 	blvs	18dc4dc <__bss_end+0x18d34f0>
 728:	0200682e 	andeq	r6, r0, #3014656	; 0x2e0000
 72c:	69660000 	stmdbvs	r6!, {}^	; <UNPREDICTABLE>
 730:	7973656c 	ldmdbvc	r3!, {r2, r3, r5, r6, r8, sl, sp, lr}^
 734:	6d657473 	cfstrdvs	mvd7, [r5, #-460]!	; 0xfffffe34
 738:	0300682e 	movweq	r6, #2094	; 0x82e
 73c:	72700000 	rsbsvc	r0, r0, #0
 740:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
 744:	00682e73 	rsbeq	r2, r8, r3, ror lr
 748:	70000002 	andvc	r0, r0, r2
 74c:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
 750:	6d5f7373 	ldclvs	3, cr7, [pc, #-460]	; 58c <shift+0x58c>
 754:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
 758:	682e7265 	stmdavs	lr!, {r0, r2, r5, r6, r9, ip, sp, lr}
 75c:	00000200 	andeq	r0, r0, r0, lsl #4
 760:	64746e69 	ldrbtvs	r6, [r4], #-3689	; 0xfffff197
 764:	682e6665 	stmdavs	lr!, {r0, r2, r5, r6, r9, sl, sp, lr}
 768:	00000400 	andeq	r0, r0, r0, lsl #8
 76c:	00010500 	andeq	r0, r1, r0, lsl #10
 770:	83d40205 	bicshi	r0, r4, #1342177280	; 0x50000000
 774:	05160000 	ldreq	r0, [r6, #-0]
 778:	052f6905 	streq	r6, [pc, #-2309]!	; fffffe7b <__bss_end+0xffff6e8f>
 77c:	01054c0c 	tsteq	r5, ip, lsl #24
 780:	0505852f 	streq	r8, [r5, #-1327]	; 0xfffffad1
 784:	01054b83 	smlabbeq	r5, r3, fp, r4
 788:	0505852f 	streq	r8, [r5, #-1327]	; 0xfffffad1
 78c:	2f01054b 	svccs	0x0001054b
 790:	a1050585 	smlabbge	r5, r5, r5, r0
 794:	052f4b4b 	streq	r4, [pc, #-2891]!	; fffffc51 <__bss_end+0xffff6c65>
 798:	01054b0c 	tsteq	r5, ip, lsl #22
 79c:	0505852f 	streq	r8, [r5, #-1327]	; 0xfffffad1
 7a0:	4b4b4bbd 	blmi	12d369c <__bss_end+0x12ca6b0>
 7a4:	4c0c052f 	cfstr32mi	mvfx0, [ip], {47}	; 0x2f
 7a8:	852f0105 	strhi	r0, [pc, #-261]!	; 6ab <shift+0x6ab>
 7ac:	4bbd0505 	blmi	fef41bc8 <__bss_end+0xfef38bdc>
 7b0:	052f4b4b 	streq	r4, [pc, #-2891]!	; fffffc6d <__bss_end+0xffff6c81>
 7b4:	01054c0c 	tsteq	r5, ip, lsl #24
 7b8:	0505852f 	streq	r8, [r5, #-1327]	; 0xfffffad1
 7bc:	01054b83 	smlabbeq	r5, r3, fp, r4
 7c0:	0505852f 	streq	r8, [r5, #-1327]	; 0xfffffad1
 7c4:	4b4b4bbd 	blmi	12d36c0 <__bss_end+0x12ca6d4>
 7c8:	4c0c052f 	cfstr32mi	mvfx0, [ip], {47}	; 0x2f
 7cc:	852f0105 	strhi	r0, [pc, #-261]!	; 6cf <shift+0x6cf>
 7d0:	4ba10505 	blmi	fe841bec <__bss_end+0xfe838c00>
 7d4:	0c052f4b 	stceq	15, cr2, [r5], {75}	; 0x4b
 7d8:	2f01054c 	svccs	0x0001054c
 7dc:	bd050585 	cfstr32lt	mvfx0, [r5, #-532]	; 0xfffffdec
 7e0:	2f4b4b4b 	svccs	0x004b4b4b
 7e4:	054c0c05 	strbeq	r0, [ip, #-3077]	; 0xfffff3fb
 7e8:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 7ec:	4b4ba105 	blmi	12e8c08 <__bss_end+0x12dfc1c>
 7f0:	4c0c052f 	cfstr32mi	mvfx0, [ip], {47}	; 0x2f
 7f4:	859f0105 	ldrhi	r0, [pc, #261]	; 901 <shift+0x901>
 7f8:	05672005 	strbeq	r2, [r7, #-5]!
 7fc:	4b4b4d05 	blmi	12d3c18 <__bss_end+0x12cac2c>
 800:	05300c05 	ldreq	r0, [r0, #-3077]!	; 0xfffff3fb
 804:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 808:	05056720 	streq	r6, [r5, #-1824]	; 0xfffff8e0
 80c:	054b4b4d 	strbeq	r4, [fp, #-2893]	; 0xfffff4b3
 810:	0105300c 	tsteq	r5, ip
 814:	2005852f 	andcs	r8, r5, pc, lsr #10
 818:	4c050583 	cfstr32mi	mvfx0, [r5], {131}	; 0x83
 81c:	01054b4b 	tsteq	r5, fp, asr #22
 820:	2005852f 	andcs	r8, r5, pc, lsr #10
 824:	4d050567 	cfstr32mi	mvfx0, [r5, #-412]	; 0xfffffe64
 828:	0c054b4b 			; <UNDEFINED> instruction: 0x0c054b4b
 82c:	2f010530 	svccs	0x00010530
 830:	a00c0587 	andge	r0, ip, r7, lsl #11
 834:	bc31059f 	cfldr32lt	mvfx0, [r1], #-636	; 0xfffffd84
 838:	05662905 	strbeq	r2, [r6, #-2309]!	; 0xfffff6fb
 83c:	0f052e36 	svceq	0x00052e36
 840:	66130530 			; <UNDEFINED> instruction: 0x66130530
 844:	05840905 	streq	r0, [r4, #2309]	; 0x905
 848:	0105d810 	tsteq	r5, r0, lsl r8
 84c:	0008029f 	muleq	r8, pc, r2	; <UNPREDICTABLE>
 850:	029b0101 	addseq	r0, fp, #1073741824	; 0x40000000
 854:	00030000 	andeq	r0, r3, r0
 858:	00000074 	andeq	r0, r0, r4, ror r0
 85c:	0efb0102 	cdpeq	1, 15, cr0, cr11, cr2, {0}
 860:	0101000d 	tsteq	r1, sp
 864:	00000101 	andeq	r0, r0, r1, lsl #2
 868:	00000100 	andeq	r0, r0, r0, lsl #2
 86c:	73552f01 	cmpvc	r5, #1, 30
 870:	2f737265 	svccs	0x00737265
 874:	746e6977 	strbtvc	r6, [lr], #-2423	; 0xfffff689
 878:	696a7265 	stmdbvs	sl!, {r0, r2, r5, r6, r9, ip, sp, lr}^
 87c:	7365442f 	cmnvc	r5, #788529152	; 0x2f000000
 880:	706f746b 	rsbvc	r7, pc, fp, ror #8
 884:	5641462f 	strbpl	r4, [r1], -pc, lsr #12
 888:	76614e2f 	strbtvc	r4, [r1], -pc, lsr #28
 88c:	6a757a61 	bvs	1d5f218 <__bss_end+0x1d5622c>
 890:	2f696369 	svccs	0x00696369
 894:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
 898:	73656d65 	cmnvc	r5, #6464	; 0x1940
 89c:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
 8a0:	6b2d616b 	blvs	b58e54 <__bss_end+0xb4fe68>
 8a4:	6f2d7669 	svcvs	0x002d7669
 8a8:	6f732f73 	svcvs	0x00732f73
 8ac:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
 8b0:	74732f73 	ldrbtvc	r2, [r3], #-3955	; 0xfffff08d
 8b4:	62696c64 	rsbvs	r6, r9, #100, 24	; 0x6400
 8b8:	6372732f 	cmnvs	r2, #-1140850688	; 0xbc000000
 8bc:	74730000 	ldrbtvc	r0, [r3], #-0
 8c0:	72747364 	rsbsvc	r7, r4, #100, 6	; 0x90000001
 8c4:	2e676e69 	cdpcs	14, 6, cr6, cr7, cr9, {3}
 8c8:	00707063 	rsbseq	r7, r0, r3, rrx
 8cc:	00000001 	andeq	r0, r0, r1
 8d0:	05000105 	streq	r0, [r0, #-261]	; 0xfffffefb
 8d4:	00883002 	addeq	r3, r8, r2
 8d8:	06051a00 	streq	r1, [r5], -r0, lsl #20
 8dc:	4c0f05bb 	cfstr32mi	mvfx0, [pc], {187}	; 0xbb
 8e0:	05682105 	strbeq	r2, [r8, #-261]!	; 0xfffffefb
 8e4:	0b05ba0a 	bleq	16f114 <__bss_end+0x166128>
 8e8:	4a27052e 	bmi	9c1da8 <__bss_end+0x9b8dbc>
 8ec:	054a0d05 	strbeq	r0, [sl, #-3333]	; 0xfffff2fb
 8f0:	04052f09 	streq	r2, [r5], #-3849	; 0xfffff0f7
 8f4:	6202059f 	andvs	r0, r2, #666894336	; 0x27c00000
 8f8:	05350505 	ldreq	r0, [r5, #-1285]!	; 0xfffffafb
 8fc:	11056810 	tstne	r5, r0, lsl r8
 900:	4a22052e 	bmi	881dc0 <__bss_end+0x878dd4>
 904:	052e1305 	streq	r1, [lr, #-773]!	; 0xfffffcfb
 908:	09052f0a 	stmdbeq	r5, {r1, r3, r8, r9, sl, fp, sp}
 90c:	2e0a0569 	cfsh32cs	mvfx0, mvfx10, #57
 910:	054a0c05 	strbeq	r0, [sl, #-3077]	; 0xfffff3fb
 914:	0b054b03 	bleq	153528 <__bss_end+0x14a53c>
 918:	00180568 	andseq	r0, r8, r8, ror #10
 91c:	4a030402 	bmi	c192c <__bss_end+0xb8940>
 920:	02001405 	andeq	r1, r0, #83886080	; 0x5000000
 924:	059e0304 	ldreq	r0, [lr, #772]	; 0x304
 928:	04020015 	streq	r0, [r2], #-21	; 0xffffffeb
 92c:	18056802 	stmdane	r5, {r1, fp, sp, lr}
 930:	02040200 	andeq	r0, r4, #0, 4
 934:	00080582 	andeq	r0, r8, r2, lsl #11
 938:	4a020402 	bmi	81948 <__bss_end+0x7895c>
 93c:	02001a05 	andeq	r1, r0, #20480	; 0x5000
 940:	054b0204 	strbeq	r0, [fp, #-516]	; 0xfffffdfc
 944:	0402001b 	streq	r0, [r2], #-27	; 0xffffffe5
 948:	0c052e02 	stceq	14, cr2, [r5], {2}
 94c:	02040200 	andeq	r0, r4, #0, 4
 950:	000f054a 	andeq	r0, pc, sl, asr #10
 954:	82020402 	andhi	r0, r2, #33554432	; 0x2000000
 958:	02001b05 	andeq	r1, r0, #5120	; 0x1400
 95c:	054a0204 	strbeq	r0, [sl, #-516]	; 0xfffffdfc
 960:	04020011 	streq	r0, [r2], #-17	; 0xffffffef
 964:	0a052e02 	beq	14c174 <__bss_end+0x143188>
 968:	02040200 	andeq	r0, r4, #0, 4
 96c:	000b052f 	andeq	r0, fp, pc, lsr #10
 970:	2e020402 	cdpcs	4, 0, cr0, cr2, cr2, {0}
 974:	02000d05 	andeq	r0, r0, #320	; 0x140
 978:	054a0204 	strbeq	r0, [sl, #-516]	; 0xfffffdfc
 97c:	04020002 	streq	r0, [r2], #-2
 980:	01054602 	tsteq	r5, r2, lsl #12
 984:	06058588 	streq	r8, [r5], -r8, lsl #11
 988:	4c090583 	cfstr32mi	mvfx0, [r9], {131}	; 0x83
 98c:	054a1005 	strbeq	r1, [sl, #-5]
 990:	07054c0a 	streq	r4, [r5, -sl, lsl #24]
 994:	4a0305bb 	bmi	c2088 <__bss_end+0xb909c>
 998:	02001705 	andeq	r1, r0, #1310720	; 0x140000
 99c:	054a0104 	strbeq	r0, [sl, #-260]	; 0xfffffefc
 9a0:	04020014 	streq	r0, [r2], #-20	; 0xffffffec
 9a4:	0d054a01 	vstreq	s8, [r5, #-4]
 9a8:	4a14054d 	bmi	501ee4 <__bss_end+0x4f8ef8>
 9ac:	052e0a05 	streq	r0, [lr, #-2565]!	; 0xfffff5fb
 9b0:	02056808 	andeq	r6, r5, #8, 16	; 0x80000
 9b4:	05667803 	strbeq	r7, [r6, #-2051]!	; 0xfffff7fd
 9b8:	2e0b0309 	cdpcs	3, 0, cr0, cr11, cr9, {0}
 9bc:	852f0105 	strhi	r0, [pc, #-261]!	; 8bf <shift+0x8bf>
 9c0:	05bd0905 	ldreq	r0, [sp, #2309]!	; 0x905
 9c4:	04020016 	streq	r0, [r2], #-22	; 0xffffffea
 9c8:	1d054a04 	vstrne	s8, [r5, #-16]
 9cc:	02040200 	andeq	r0, r4, #0, 4
 9d0:	001e0582 	andseq	r0, lr, r2, lsl #11
 9d4:	2e020402 	cdpcs	4, 0, cr0, cr2, cr2, {0}
 9d8:	02001605 	andeq	r1, r0, #5242880	; 0x500000
 9dc:	05660204 	strbeq	r0, [r6, #-516]!	; 0xfffffdfc
 9e0:	04020011 	streq	r0, [r2], #-17	; 0xffffffef
 9e4:	12054b03 	andne	r4, r5, #3072	; 0xc00
 9e8:	03040200 	movweq	r0, #16896	; 0x4200
 9ec:	0008052e 	andeq	r0, r8, lr, lsr #10
 9f0:	4a030402 	bmi	c1a00 <__bss_end+0xb8a14>
 9f4:	02000905 	andeq	r0, r0, #81920	; 0x14000
 9f8:	052e0304 	streq	r0, [lr, #-772]!	; 0xfffffcfc
 9fc:	04020012 	streq	r0, [r2], #-18	; 0xffffffee
 a00:	0b054a03 	bleq	153214 <__bss_end+0x14a228>
 a04:	03040200 	movweq	r0, #16896	; 0x4200
 a08:	0002052e 	andeq	r0, r2, lr, lsr #10
 a0c:	2d030402 	cfstrscs	mvf0, [r3, #-8]
 a10:	02000b05 	andeq	r0, r0, #5120	; 0x1400
 a14:	05840204 	streq	r0, [r4, #516]	; 0x204
 a18:	04020008 	streq	r0, [r2], #-8
 a1c:	09058301 	stmdbeq	r5, {r0, r8, r9, pc}
 a20:	01040200 	mrseq	r0, R12_usr
 a24:	000b052e 	andeq	r0, fp, lr, lsr #10
 a28:	4a010402 	bmi	41a38 <__bss_end+0x38a4c>
 a2c:	02000205 	andeq	r0, r0, #1342177280	; 0x50000000
 a30:	05490104 	strbeq	r0, [r9, #-260]	; 0xfffffefc
 a34:	0105850b 	tsteq	r5, fp, lsl #10
 a38:	0e05852f 	cfsh32eq	mvfx8, mvfx5, #31
 a3c:	661105bc 			; <UNDEFINED> instruction: 0x661105bc
 a40:	05bc2005 	ldreq	r2, [ip, #5]!
 a44:	1f05660b 	svcne	0x0005660b
 a48:	660a054b 	strvs	r0, [sl], -fp, asr #10
 a4c:	054b0805 	strbeq	r0, [fp, #-2053]	; 0xfffff7fb
 a50:	16058311 			; <UNDEFINED> instruction: 0x16058311
 a54:	6708052e 	strvs	r0, [r8, -lr, lsr #10]
 a58:	05671105 	strbeq	r1, [r7, #-261]!	; 0xfffffefb
 a5c:	01054d0b 	tsteq	r5, fp, lsl #26
 a60:	0605852f 	streq	r8, [r5], -pc, lsr #10
 a64:	4c0b0583 	cfstr32mi	mvfx0, [fp], {131}	; 0x83
 a68:	052e0c05 	streq	r0, [lr, #-3077]!	; 0xfffff3fb
 a6c:	0405660e 	streq	r6, [r5], #-1550	; 0xfffff9f2
 a70:	6502054b 	strvs	r0, [r2, #-1355]	; 0xfffffab5
 a74:	05310905 	ldreq	r0, [r1, #-2309]!	; 0xfffff6fb
 a78:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 a7c:	0b059f08 	bleq	1686a4 <__bss_end+0x15f6b8>
 a80:	0014054c 	andseq	r0, r4, ip, asr #10
 a84:	4a030402 	bmi	c1a94 <__bss_end+0xb8aa8>
 a88:	02000705 	andeq	r0, r0, #1310720	; 0x140000
 a8c:	05830204 	streq	r0, [r3, #516]	; 0x204
 a90:	04020008 	streq	r0, [r2], #-8
 a94:	0a052e02 	beq	14c2a4 <__bss_end+0x1432b8>
 a98:	02040200 	andeq	r0, r4, #0, 4
 a9c:	0002054a 	andeq	r0, r2, sl, asr #10
 aa0:	49020402 	stmdbmi	r2, {r1, sl}
 aa4:	85840105 	strhi	r0, [r4, #261]	; 0x105
 aa8:	05bb0e05 	ldreq	r0, [fp, #3589]!	; 0xe05
 aac:	0b054b08 	bleq	1536d4 <__bss_end+0x14a6e8>
 ab0:	0014054c 	andseq	r0, r4, ip, asr #10
 ab4:	4a030402 	bmi	c1ac4 <__bss_end+0xb8ad8>
 ab8:	02001605 	andeq	r1, r0, #5242880	; 0x500000
 abc:	05830204 	streq	r0, [r3, #516]	; 0x204
 ac0:	04020017 	streq	r0, [r2], #-23	; 0xffffffe9
 ac4:	0a052e02 	beq	14c2d4 <__bss_end+0x1432e8>
 ac8:	02040200 	andeq	r0, r4, #0, 4
 acc:	000b054a 	andeq	r0, fp, sl, asr #10
 ad0:	2e020402 	cdpcs	4, 0, cr0, cr2, cr2, {0}
 ad4:	02001705 	andeq	r1, r0, #1310720	; 0x140000
 ad8:	054a0204 	strbeq	r0, [sl, #-516]	; 0xfffffdfc
 adc:	0402000d 	streq	r0, [r2], #-13
 ae0:	02052e02 	andeq	r2, r5, #2, 28
 ae4:	02040200 	andeq	r0, r4, #0, 4
 ae8:	8401052d 	strhi	r0, [r1], #-1325	; 0xfffffad3
 aec:	01000802 	tsteq	r0, r2, lsl #16
 af0:	Address 0x0000000000000af0 is out of bounds.


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
      58:	07a80704 	streq	r0, [r8, r4, lsl #14]!
      5c:	5b020000 	blpl	80064 <__bss_end+0x77078>
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
     128:	000007a8 	andeq	r0, r0, r8, lsr #15
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
     174:	cb104801 	blgt	412180 <__bss_end+0x409194>
     178:	d4000000 	strle	r0, [r0], #-0
     17c:	58000081 	stmdapl	r0, {r0, r7}
     180:	01000000 	mrseq	r0, (UNDEF: 0)
     184:	0000cb9c 	muleq	r0, ip, fp
     188:	02b40a00 	adcseq	r0, r4, #0, 20
     18c:	4a010000 	bmi	40194 <__bss_end+0x371a8>
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
     21c:	ba0d9c01 	blt	367228 <__bss_end+0x35e23c>
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
     24c:	8b120f01 	blhi	483e58 <__bss_end+0x47ae6c>
     250:	0f000001 	svceq	0x00000001
     254:	0000019e 	muleq	r0, lr, r1
     258:	03d51000 	bicseq	r1, r5, #0
     25c:	0a010000 	beq	40264 <__bss_end+0x37278>
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
     2b4:	8b140074 	blhi	50048c <__bss_end+0x4f74a0>
     2b8:	a4000001 	strge	r0, [r0], #-1
     2bc:	38000080 	stmdacc	r0, {r7}
     2c0:	01000000 	mrseq	r0, (UNDEF: 0)
     2c4:	0067139c 	mlseq	r7, ip, r3, r1
     2c8:	9e2f0a01 	vmulls.f32	s0, s30, s2
     2cc:	02000001 	andeq	r0, r0, #1
     2d0:	00007491 	muleq	r0, r1, r4
     2d4:	00000803 	andeq	r0, r0, r3, lsl #16
     2d8:	01e00004 	mvneq	r0, r4
     2dc:	01040000 	mrseq	r0, (UNDEF: 4)
     2e0:	000001e1 	andeq	r0, r0, r1, ror #3
     2e4:	000a0704 	andeq	r0, sl, r4, lsl #14
     2e8:	00005600 	andeq	r5, r0, r0, lsl #12
     2ec:	00822c00 	addeq	r2, r2, r0, lsl #24
     2f0:	0001a800 	andeq	sl, r1, r0, lsl #16
     2f4:	00024600 	andeq	r4, r2, r0, lsl #12
     2f8:	08010200 	stmdaeq	r1, {r9}
     2fc:	0000098d 	andeq	r0, r0, sp, lsl #19
     300:	d9050202 	stmdble	r5, {r1, r9}
     304:	03000009 	movweq	r0, #9
     308:	6e690504 	cdpvs	5, 6, cr0, cr9, cr4, {0}
     30c:	01020074 	tsteq	r2, r4, ror r0
     310:	00098408 	andeq	r8, r9, r8, lsl #8
     314:	07020200 	streq	r0, [r2, -r0, lsl #4]
     318:	000007ef 	andeq	r0, r0, pc, ror #15
     31c:	000b6e04 	andeq	r6, fp, r4, lsl #28
     320:	07090900 	streq	r0, [r9, -r0, lsl #18]
     324:	00000059 	andeq	r0, r0, r9, asr r0
     328:	00004805 	andeq	r4, r0, r5, lsl #16
     32c:	07040200 	streq	r0, [r4, -r0, lsl #4]
     330:	000007a8 	andeq	r0, r0, r8, lsr #15
     334:	00005905 	andeq	r5, r0, r5, lsl #18
     338:	06850600 	streq	r0, [r5], r0, lsl #12
     33c:	02080000 	andeq	r0, r8, #0
     340:	008b0806 	addeq	r0, fp, r6, lsl #16
     344:	72070000 	andvc	r0, r7, #0
     348:	08020030 	stmdaeq	r2, {r4, r5}
     34c:	0000480e 	andeq	r4, r0, lr, lsl #16
     350:	72070000 	andvc	r0, r7, #0
     354:	09020031 	stmdbeq	r2, {r0, r4, r5}
     358:	0000480e 	andeq	r4, r0, lr, lsl #16
     35c:	08000400 	stmdaeq	r0, {sl}
     360:	00000541 	andeq	r0, r0, r1, asr #10
     364:	00330405 	eorseq	r0, r3, r5, lsl #8
     368:	1e020000 	cdpne	0, 0, cr0, cr2, cr0, {0}
     36c:	0000c20c 	andeq	ip, r0, ip, lsl #4
     370:	06f80900 	ldrbteq	r0, [r8], r0, lsl #18
     374:	09000000 	stmdbeq	r0, {}	; <UNPREDICTABLE>
     378:	00000c2e 	andeq	r0, r0, lr, lsr #24
     37c:	0c0e0901 			; <UNDEFINED> instruction: 0x0c0e0901
     380:	09020000 	stmdbeq	r2, {}	; <UNPREDICTABLE>
     384:	00000822 	andeq	r0, r0, r2, lsr #16
     388:	09130903 	ldmdbeq	r3, {r0, r1, r8, fp}
     38c:	09040000 	stmdbeq	r4, {}	; <UNPREDICTABLE>
     390:	000006c1 	andeq	r0, r0, r1, asr #13
     394:	b1080005 	tstlt	r8, r5
     398:	0500000b 	streq	r0, [r0, #-11]
     39c:	00003304 	andeq	r3, r0, r4, lsl #6
     3a0:	0c3f0200 	lfmeq	f0, 4, [pc], #-0	; 3a8 <shift+0x3a8>
     3a4:	000000ff 	strdeq	r0, [r0], -pc	; <UNPREDICTABLE>
     3a8:	0003ff09 	andeq	pc, r3, r9, lsl #30
     3ac:	56090000 	strpl	r0, [r9], -r0
     3b0:	01000005 	tsteq	r0, r5
     3b4:	00090609 	andeq	r0, r9, r9, lsl #12
     3b8:	ee090200 	cdp	2, 0, cr0, cr9, cr0, {0}
     3bc:	0300000b 	movweq	r0, #11
     3c0:	000c3809 	andeq	r3, ip, r9, lsl #16
     3c4:	cd090400 	cfstrsgt	mvf0, [r9, #-0]
     3c8:	05000008 	streq	r0, [r0, #-8]
     3cc:	00080f09 	andeq	r0, r8, r9, lsl #30
     3d0:	0a000600 	beq	1bd8 <shift+0x1bd8>
     3d4:	000008e7 	andeq	r0, r0, r7, ror #17
     3d8:	54140503 	ldrpl	r0, [r4], #-1283	; 0xfffffafd
     3dc:	05000000 	streq	r0, [r0, #-0]
     3e0:	008ef803 	addeq	pc, lr, r3, lsl #16
     3e4:	08f50a00 	ldmeq	r5!, {r9, fp}^
     3e8:	06030000 	streq	r0, [r3], -r0
     3ec:	00005414 	andeq	r5, r0, r4, lsl r4
     3f0:	fc030500 	stc2	5, cr0, [r3], {-0}
     3f4:	0a00008e 	beq	634 <shift+0x634>
     3f8:	000008b7 			; <UNDEFINED> instruction: 0x000008b7
     3fc:	541a0704 	ldrpl	r0, [sl], #-1796	; 0xfffff8fc
     400:	05000000 	streq	r0, [r0, #-0]
     404:	008f0003 	addeq	r0, pc, r3
     408:	05940a00 	ldreq	r0, [r4, #2560]	; 0xa00
     40c:	09040000 	stmdbeq	r4, {}	; <UNPREDICTABLE>
     410:	0000541a 	andeq	r5, r0, sl, lsl r4
     414:	04030500 	streq	r0, [r3], #-1280	; 0xfffffb00
     418:	0a00008f 	beq	65c <shift+0x65c>
     41c:	00000976 	andeq	r0, r0, r6, ror r9
     420:	541a0b04 	ldrpl	r0, [sl], #-2820	; 0xfffff4fc
     424:	05000000 	streq	r0, [r0, #-0]
     428:	008f0803 	addeq	r0, pc, r3, lsl #16
     42c:	07c90a00 	strbeq	r0, [r9, r0, lsl #20]
     430:	0d040000 	stceq	0, cr0, [r4, #-0]
     434:	0000541a 	andeq	r5, r0, sl, lsl r4
     438:	0c030500 	cfstr32eq	mvfx0, [r3], {-0}
     43c:	0a00008f 	beq	680 <shift+0x680>
     440:	0000069e 	muleq	r0, lr, r6
     444:	541a0f04 	ldrpl	r0, [sl], #-3844	; 0xfffff0fc
     448:	05000000 	streq	r0, [r0, #-0]
     44c:	008f1003 	addeq	r1, pc, r3
     450:	107a0800 	rsbsne	r0, sl, r0, lsl #16
     454:	04050000 	streq	r0, [r5], #-0
     458:	00000033 	andeq	r0, r0, r3, lsr r0
     45c:	a20c1b04 	andge	r1, ip, #4, 22	; 0x1000
     460:	09000001 	stmdbeq	r0, {r0}
     464:	00000a91 	muleq	r0, r1, sl
     468:	0bfe0900 	bleq	fff82870 <__bss_end+0xfff79884>
     46c:	09010000 	stmdbeq	r1, {}	; <UNPREDICTABLE>
     470:	00000901 	andeq	r0, r0, r1, lsl #18
     474:	700b0002 	andvc	r0, fp, r2
     478:	02000009 	andeq	r0, r0, #9
     47c:	08280201 	stmdaeq	r8!, {r0, r9}
     480:	040c0000 	streq	r0, [ip], #-0
     484:	000001a2 	andeq	r0, r0, r2, lsr #3
     488:	0007400a 	andeq	r4, r7, sl
     48c:	14040500 	strne	r0, [r4], #-1280	; 0xfffffb00
     490:	00000054 	andeq	r0, r0, r4, asr r0
     494:	8f140305 	svchi	0x00140305
     498:	f40a0000 	vst4.8	{d0-d3}, [sl], r0
     49c:	05000003 	streq	r0, [r0, #-3]
     4a0:	00541407 	subseq	r1, r4, r7, lsl #8
     4a4:	03050000 	movweq	r0, #20480	; 0x5000
     4a8:	00008f18 	andeq	r8, r0, r8, lsl pc
     4ac:	0005c20a 	andeq	ip, r5, sl, lsl #4
     4b0:	140a0500 	strne	r0, [sl], #-1280	; 0xfffffb00
     4b4:	00000054 	andeq	r0, r0, r4, asr r0
     4b8:	8f1c0305 	svchi	0x001c0305
     4bc:	5d080000 	stcpl	0, cr0, [r8, #-0]
     4c0:	05000008 	streq	r0, [r0, #-8]
     4c4:	00003304 	andeq	r3, r0, r4, lsl #6
     4c8:	0c0d0500 	cfstr32eq	mvfx0, [sp], {-0}
     4cc:	00000221 	andeq	r0, r0, r1, lsr #4
     4d0:	77654e0d 	strbvc	r4, [r5, -sp, lsl #28]!
     4d4:	54090000 	strpl	r0, [r9], #-0
     4d8:	01000008 	tsteq	r0, r8
     4dc:	0009ff09 	andeq	pc, r9, r9, lsl #30
     4e0:	37090200 	strcc	r0, [r9, -r0, lsl #4]
     4e4:	03000008 	movweq	r0, #8
     4e8:	00081409 	andeq	r1, r8, r9, lsl #8
     4ec:	0c090400 	cfstrseq	mvf0, [r9], {-0}
     4f0:	05000009 	streq	r0, [r0, #-9]
     4f4:	06b40600 	ldrteq	r0, [r4], r0, lsl #12
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
     524:	ca0e0800 	bgt	38252c <__bss_end+0x379540>
     528:	05000006 	streq	r0, [r0, #-6]
     52c:	02601320 	rsbeq	r1, r0, #32, 6	; 0x80000000
     530:	000c0000 	andeq	r0, ip, r0
     534:	a3070402 	movwge	r0, #29698	; 0x7402
     538:	05000007 	streq	r0, [r0, #-7]
     53c:	00000260 	andeq	r0, r0, r0, ror #4
     540:	00046106 	andeq	r6, r4, r6, lsl #2
     544:	28057000 	stmdacs	r5, {ip, sp, lr}
     548:	0002fc08 	andeq	pc, r2, r8, lsl #24
     54c:	0a850e00 	beq	fe143d54 <__bss_end+0xfe13ad68>
     550:	2a050000 	bcs	140558 <__bss_end+0x13756c>
     554:	00022112 	andeq	r2, r2, r2, lsl r1
     558:	70070000 	andvc	r0, r7, r0
     55c:	05006469 	streq	r6, [r0, #-1129]	; 0xfffffb97
     560:	0059122b 	subseq	r1, r9, fp, lsr #4
     564:	0e100000 	cdpeq	0, 1, cr0, cr0, cr0, {0}
     568:	0000057f 	andeq	r0, r0, pc, ror r5
     56c:	ea112c05 	b	44b588 <__bss_end+0x44259c>
     570:	14000001 	strne	r0, [r0], #-1
     574:	0008710e 	andeq	r7, r8, lr, lsl #2
     578:	122d0500 	eorne	r0, sp, #0, 10
     57c:	00000059 	andeq	r0, r0, r9, asr r0
     580:	087f0e18 	ldmdaeq	pc!, {r3, r4, r9, sl, fp}^	; <UNPREDICTABLE>
     584:	2e050000 	cdpcs	0, 0, cr0, cr5, cr0, {0}
     588:	00005912 	andeq	r5, r0, r2, lsl r9
     58c:	910e1c00 	tstls	lr, r0, lsl #24
     590:	05000006 	streq	r0, [r0, #-6]
     594:	02fc0c2f 	rscseq	r0, ip, #12032	; 0x2f00
     598:	0e200000 	cdpeq	0, 2, cr0, cr0, cr0, {0}
     59c:	00000895 	muleq	r0, r5, r8
     5a0:	33093005 	movwcc	r3, #36869	; 0x9005
     5a4:	60000000 	andvs	r0, r0, r0
     5a8:	000a9b0e 	andeq	r9, sl, lr, lsl #22
     5ac:	0e310500 	cfabs32eq	mvfx0, mvfx1
     5b0:	00000048 	andeq	r0, r0, r8, asr #32
     5b4:	07130e64 	ldreq	r0, [r3, -r4, ror #28]
     5b8:	33050000 	movwcc	r0, #20480	; 0x5000
     5bc:	0000480e 	andeq	r4, r0, lr, lsl #16
     5c0:	0a0e6800 	beq	39a5c8 <__bss_end+0x3915dc>
     5c4:	05000007 	streq	r0, [r0, #-7]
     5c8:	00480e34 	subeq	r0, r8, r4, lsr lr
     5cc:	006c0000 	rsbeq	r0, ip, r0
     5d0:	0001ae0f 	andeq	sl, r1, pc, lsl #28
     5d4:	00030c00 	andeq	r0, r3, r0, lsl #24
     5d8:	00591000 	subseq	r1, r9, r0
     5dc:	000f0000 	andeq	r0, pc, r0
     5e0:	000bc90a 	andeq	ip, fp, sl, lsl #18
     5e4:	140a0600 	strne	r0, [sl], #-1536	; 0xfffffa00
     5e8:	00000054 	andeq	r0, r0, r4, asr r0
     5ec:	8f200305 	svchi	0x00200305
     5f0:	3f080000 	svccc	0x00080000
     5f4:	05000008 	streq	r0, [r0, #-8]
     5f8:	00003304 	andeq	r3, r0, r4, lsl #6
     5fc:	0c0d0600 	stceq	6, cr0, [sp], {-0}
     600:	0000033d 	andeq	r0, r0, sp, lsr r3
     604:	00055b09 	andeq	r5, r5, r9, lsl #22
     608:	e9090000 	stmdb	r9, {}	; <UNPREDICTABLE>
     60c:	01000003 	tsteq	r0, r3
     610:	0b4f0600 	bleq	13c1e18 <__bss_end+0x13b8e2c>
     614:	060c0000 	streq	r0, [ip], -r0
     618:	0372081b 	cmneq	r2, #1769472	; 0x1b0000
     61c:	330e0000 	movwcc	r0, #57344	; 0xe000
     620:	06000004 	streq	r0, [r0], -r4
     624:	0372191d 	cmneq	r2, #475136	; 0x74000
     628:	0e000000 	cdpeq	0, 0, cr0, cr0, cr0, {0}
     62c:	0000051e 	andeq	r0, r0, lr, lsl r5
     630:	72191e06 	andsvc	r1, r9, #6, 28	; 0x60
     634:	04000003 	streq	r0, [r0], #-3
     638:	000b0f0e 	andeq	r0, fp, lr, lsl #30
     63c:	131f0600 	tstne	pc, #0, 12
     640:	00000378 	andeq	r0, r0, r8, ror r3
     644:	040c0008 	streq	r0, [ip], #-8
     648:	0000033d 	andeq	r0, r0, sp, lsr r3
     64c:	026c040c 	rsbeq	r0, ip, #12, 8	; 0xc000000
     650:	d5110000 	ldrle	r0, [r1, #-0]
     654:	14000005 	strne	r0, [r0], #-5
     658:	00072206 	andeq	r2, r7, r6, lsl #4
     65c:	0e000006 	cdpeq	0, 0, cr0, cr0, cr6, {0}
     660:	0000082d 	andeq	r0, r0, sp, lsr #16
     664:	48122606 	ldmdami	r2, {r1, r2, r9, sl, sp}
     668:	00000000 	andeq	r0, r0, r0
     66c:	0004dd0e 	andeq	sp, r4, lr, lsl #26
     670:	1d290600 	stcne	6, cr0, [r9, #-0]
     674:	00000372 	andeq	r0, r0, r2, ror r3
     678:	0a680e04 	beq	1a03e90 <__bss_end+0x19faea4>
     67c:	2c060000 	stccs	0, cr0, [r6], {-0}
     680:	0003721d 	andeq	r7, r3, sp, lsl r2
     684:	a7120800 	ldrge	r0, [r2, -r0, lsl #16]
     688:	0600000b 	streq	r0, [r0], -fp
     68c:	0b2c0e2f 	bleq	b03f50 <__bss_end+0xafaf64>
     690:	03c60000 	biceq	r0, r6, #0
     694:	03d10000 	bicseq	r0, r1, #0
     698:	05130000 	ldreq	r0, [r3, #-0]
     69c:	14000006 	strne	r0, [r0], #-6
     6a0:	00000372 	andeq	r0, r0, r2, ror r3
     6a4:	0b141500 	bleq	505aac <__bss_end+0x4fcac0>
     6a8:	31060000 	mrscc	r0, (UNDEF: 6)
     6ac:	0004380e 	andeq	r3, r4, lr, lsl #16
     6b0:	0001a700 	andeq	sl, r1, r0, lsl #14
     6b4:	0003e900 	andeq	lr, r3, r0, lsl #18
     6b8:	0003f400 	andeq	pc, r3, r0, lsl #8
     6bc:	06051300 	streq	r1, [r5], -r0, lsl #6
     6c0:	78140000 	ldmdavc	r4, {}	; <UNPREDICTABLE>
     6c4:	00000003 	andeq	r0, r0, r3
     6c8:	000b6216 	andeq	r6, fp, r6, lsl r2
     6cc:	1d350600 	ldcne	6, cr0, [r5, #-0]
     6d0:	00000aea 	andeq	r0, r0, sl, ror #21
     6d4:	00000372 	andeq	r0, r0, r2, ror r3
     6d8:	00040d02 	andeq	r0, r4, r2, lsl #26
     6dc:	00041300 	andeq	r1, r4, r0, lsl #6
     6e0:	06051300 	streq	r1, [r5], -r0, lsl #6
     6e4:	16000000 	strne	r0, [r0], -r0
     6e8:	00000802 	andeq	r0, r0, r2, lsl #16
     6ec:	a41d3706 	ldrge	r3, [sp], #-1798	; 0xfffff8fa
     6f0:	72000009 	andvc	r0, r0, #9
     6f4:	02000003 	andeq	r0, r0, #3
     6f8:	0000042c 	andeq	r0, r0, ip, lsr #8
     6fc:	00000432 	andeq	r0, r0, r2, lsr r4
     700:	00060513 	andeq	r0, r6, r3, lsl r5
     704:	9f170000 	svcls	0x00170000
     708:	06000008 	streq	r0, [r0], -r8
     70c:	061e3139 			; <UNDEFINED> instruction: 0x061e3139
     710:	020c0000 	andeq	r0, ip, #0
     714:	0005d516 	andeq	sp, r5, r6, lsl r5
     718:	093c0600 	ldmdbeq	ip!, {r9, sl}
     71c:	00000c14 	andeq	r0, r0, r4, lsl ip
     720:	00000605 	andeq	r0, r0, r5, lsl #12
     724:	00045901 	andeq	r5, r4, r1, lsl #18
     728:	00045f00 	andeq	r5, r4, r0, lsl #30
     72c:	06051300 	streq	r1, [r5], -r0, lsl #6
     730:	16000000 	strne	r0, [r0], -r0
     734:	00000570 	andeq	r0, r0, r0, ror r5
     738:	7c123f06 	ldcvc	15, cr3, [r2], {6}
     73c:	4800000b 	stmdami	r0, {r0, r1, r3}
     740:	01000000 	mrseq	r0, (UNDEF: 0)
     744:	00000478 	andeq	r0, r0, r8, ror r4
     748:	0000048d 	andeq	r0, r0, sp, lsl #9
     74c:	00060513 	andeq	r0, r6, r3, lsl r5
     750:	06271400 	strteq	r1, [r7], -r0, lsl #8
     754:	59140000 	ldmdbpl	r4, {}	; <UNPREDICTABLE>
     758:	14000000 	strne	r0, [r0], #-0
     75c:	000001a7 	andeq	r0, r0, r7, lsr #3
     760:	0b231800 	bleq	8c6768 <__bss_end+0x8bd77c>
     764:	42060000 	andmi	r0, r6, #0
     768:	0009220e 	andeq	r2, r9, lr, lsl #4
     76c:	04a20100 	strteq	r0, [r2], #256	; 0x100
     770:	04a80000 	strteq	r0, [r8], #0
     774:	05130000 	ldreq	r0, [r3, #-0]
     778:	00000006 	andeq	r0, r0, r6
     77c:	00078f16 	andeq	r8, r7, r6, lsl pc
     780:	17450600 	strbne	r0, [r5, -r0, lsl #12]
     784:	000004f0 	strdeq	r0, [r0], -r0	; <UNPREDICTABLE>
     788:	00000378 	andeq	r0, r0, r8, ror r3
     78c:	0004c101 	andeq	ip, r4, r1, lsl #2
     790:	0004c700 	andeq	ip, r4, r0, lsl #14
     794:	062d1300 	strteq	r1, [sp], -r0, lsl #6
     798:	16000000 	strne	r0, [r0], -r0
     79c:	00000523 	andeq	r0, r0, r3, lsr #10
     7a0:	a7174806 	ldrge	r4, [r7, -r6, lsl #16]
     7a4:	7800000a 	stmdavc	r0, {r1, r3}
     7a8:	01000003 	tsteq	r0, r3
     7ac:	000004e0 	andeq	r0, r0, r0, ror #9
     7b0:	000004eb 	andeq	r0, r0, fp, ror #9
     7b4:	00062d13 	andeq	r2, r6, r3, lsl sp
     7b8:	00481400 	subeq	r1, r8, r0, lsl #8
     7bc:	18000000 	stmdane	r0, {}	; <UNPREDICTABLE>
     7c0:	00000bd8 	ldrdeq	r0, [r0], -r8
     7c4:	040e4b06 	streq	r4, [lr], #-2822	; 0xfffff4fa
     7c8:	01000004 	tsteq	r0, r4
     7cc:	00000500 	andeq	r0, r0, r0, lsl #10
     7d0:	00000506 	andeq	r0, r0, r6, lsl #10
     7d4:	00060513 	andeq	r0, r6, r3, lsl r5
     7d8:	14160000 	ldrne	r0, [r6], #-0
     7dc:	0600000b 	streq	r0, [r0], -fp
     7e0:	06d00e4d 	ldrbeq	r0, [r0], sp, asr #28
     7e4:	01a70000 			; <UNDEFINED> instruction: 0x01a70000
     7e8:	1f010000 	svcne	0x00010000
     7ec:	2a000005 	bcs	808 <shift+0x808>
     7f0:	13000005 	movwne	r0, #5
     7f4:	00000605 	andeq	r0, r0, r5, lsl #12
     7f8:	00004814 	andeq	r4, r0, r4, lsl r8
     7fc:	b5160000 	ldrlt	r0, [r6, #-0]
     800:	06000007 	streq	r0, [r0], -r7
     804:	09431250 	stmdbeq	r3, {r4, r6, r9, ip}^
     808:	00480000 	subeq	r0, r8, r0
     80c:	43010000 	movwmi	r0, #4096	; 0x1000
     810:	4e000005 	cdpmi	0, 0, cr0, cr0, cr5, {0}
     814:	13000005 	movwne	r0, #5
     818:	00000605 	andeq	r0, r0, r5, lsl #12
     81c:	0001ae14 	andeq	sl, r1, r4, lsl lr
     820:	6e160000 	cdpvs	0, 1, cr0, cr6, cr0, {0}
     824:	06000004 	streq	r0, [r0], -r4
     828:	07590e53 			; <UNDEFINED> instruction: 0x07590e53
     82c:	01a70000 			; <UNDEFINED> instruction: 0x01a70000
     830:	67010000 	strvs	r0, [r1, -r0]
     834:	72000005 	andvc	r0, r0, #5
     838:	13000005 	movwne	r0, #5
     83c:	00000605 	andeq	r0, r0, r5, lsl #12
     840:	00004814 	andeq	r4, r0, r4, lsl r8
     844:	dc180000 	ldcle	0, cr0, [r8], {-0}
     848:	06000007 	streq	r0, [r0], -r7
     84c:	04810e56 	streq	r0, [r1], #3670	; 0xe56
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
     878:	d4180000 	ldrle	r0, [r8], #-0
     87c:	0600000a 	streq	r0, [r0], -sl
     880:	06390e58 			; <UNDEFINED> instruction: 0x06390e58
     884:	bb010000 	bllt	4088c <__bss_end+0x378a0>
     888:	da000005 	ble	8a4 <shift+0x8a4>
     88c:	13000005 	movwne	r0, #5
     890:	00000605 	andeq	r0, r0, r5, lsl #12
     894:	0000c214 	andeq	ip, r0, r4, lsl r2
     898:	00481400 	subeq	r1, r8, r0, lsl #8
     89c:	48140000 	ldmdami	r4, {}	; <UNPREDICTABLE>
     8a0:	14000000 	strne	r0, [r0], #-0
     8a4:	00000048 	andeq	r0, r0, r8, asr #32
     8a8:	00063314 	andeq	r3, r6, r4, lsl r3
     8ac:	af190000 	svcge	0x00190000
     8b0:	06000005 	streq	r0, [r0], -r5
     8b4:	05f60e5b 	ldrbeq	r0, [r6, #3675]!	; 0xe5b
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
     91c:	000008d4 	ldrdeq	r0, [r0], -r4
     920:	60190707 	andsvs	r0, r9, r7, lsl #14
     924:	80000000 	andhi	r0, r0, r0
     928:	1f0ee6b2 	svcne	0x000ee6b2
     92c:	000009ef 	andeq	r0, r0, pc, ror #19
     930:	671a0a07 	ldrvs	r0, [sl, -r7, lsl #20]
     934:	00000002 	andeq	r0, r0, r2
     938:	1f200000 	svcne	0x00200000
     93c:	000008ad 	andeq	r0, r0, sp, lsr #17
     940:	671a0d07 	ldrvs	r0, [sl, -r7, lsl #26]
     944:	00000002 	andeq	r0, r0, r2
     948:	20202000 	eorcs	r2, r0, r0
     94c:	000009ca 	andeq	r0, r0, sl, asr #19
     950:	54151007 	ldrpl	r1, [r5], #-7
     954:	36000000 	strcc	r0, [r0], -r0
     958:	0005a61f 	andeq	sl, r5, pc, lsl r6
     95c:	1a420700 	bne	1082564 <__bss_end+0x1079578>
     960:	00000267 	andeq	r0, r0, r7, ror #4
     964:	20215000 	eorcs	r5, r1, r0
     968:	00071c1f 	andeq	r1, r7, pc, lsl ip
     96c:	1a710700 	bne	1c42574 <__bss_end+0x1c39588>
     970:	00000267 	andeq	r0, r0, r7, ror #4
     974:	2000b200 	andcs	fp, r0, r0, lsl #4
     978:	0005361f 	andeq	r3, r5, pc, lsl r6
     97c:	1aa40700 	bne	fe902584 <__bss_end+0xfe8f9598>
     980:	00000267 	andeq	r0, r0, r7, ror #4
     984:	2000b400 	andcs	fp, r0, r0, lsl #8
     988:	0007851f 	andeq	r8, r7, pc, lsl r5
     98c:	1ab30700 	bne	fecc2594 <__bss_end+0xfecb95a8>
     990:	00000267 	andeq	r0, r0, r7, ror #4
     994:	20104000 	andscs	r4, r0, r0
     998:	0007001f 	andeq	r0, r7, pc, lsl r0
     99c:	1abe0700 	bne	fef825a4 <__bss_end+0xfef795b8>
     9a0:	00000267 	andeq	r0, r0, r7, ror #4
     9a4:	20205000 	eorcs	r5, r0, r0
     9a8:	0007361f 	andeq	r3, r7, pc, lsl r6
     9ac:	1abf0700 	bne	fefc25b4 <__bss_end+0xfefb95c8>
     9b0:	00000267 	andeq	r0, r0, r7, ror #4
     9b4:	20804000 	addcs	r4, r0, r0
     9b8:	0004d31f 	andeq	sp, r4, pc, lsl r3
     9bc:	1ac00700 	bne	ff0025c4 <__bss_end+0xfeff95d8>
     9c0:	00000267 	andeq	r0, r0, r7, ror #4
     9c4:	20805000 	addcs	r5, r0, r0
     9c8:	0005851f 	andeq	r8, r5, pc, lsl r5
     9cc:	1ace0700 	bne	ff3825d4 <__bss_end+0xff3795e8>
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
     a14:	09e30a00 	stmibeq	r3!, {r9, fp}^
     a18:	08080000 	stmdaeq	r8, {}	; <UNPREDICTABLE>
     a1c:	00005414 	andeq	r5, r0, r4, lsl r4
     a20:	54030500 	strpl	r0, [r3], #-1280	; 0xfffffb00
     a24:	0a00008f 	beq	c68 <shift+0xc68>
     a28:	00000992 	muleq	r0, r2, r9
     a2c:	54140e01 	ldrpl	r0, [r4], #-3585	; 0xfffff1ff
     a30:	05000000 	streq	r0, [r0, #-0]
     a34:	008f5803 	addeq	r5, pc, r3, lsl #16
     a38:	05e60a00 	strbeq	r0, [r6, #2560]!	; 0xa00
     a3c:	0f010000 	svceq	0x00010000
     a40:	00005414 	andeq	r5, r0, r4, lsl r4
     a44:	5c030500 	cfstr32pl	mvfx0, [r3], {-0}
     a48:	2200008f 	andcs	r0, r0, #143	; 0x8f
     a4c:	00000869 	andeq	r0, r0, r9, ror #16
     a50:	480a1101 	stmdami	sl, {r0, r8, ip}
     a54:	05000000 	streq	r0, [r0, #-0]
     a58:	008fd403 	addeq	sp, pc, r3, lsl #8
     a5c:	0bf92200 	bleq	ffe49264 <__bss_end+0xffe40278>
     a60:	11010000 	mrsne	r0, (UNDEF: 1)
     a64:	00004813 	andeq	r4, r0, r3, lsl r8
     a68:	d8030500 	stmdale	r3, {r8, sl}
     a6c:	2300008f 	movwcs	r0, #143	; 0x8f
     a70:	00000c09 	andeq	r0, r0, r9, lsl #24
     a74:	33051a01 	movwcc	r1, #23041	; 0x5a01
     a78:	ac000000 	stcge	0, cr0, [r0], {-0}
     a7c:	28000082 	stmdacs	r0, {r1, r7}
     a80:	01000001 	tsteq	r0, r1
     a84:	0007d49c 	muleq	r7, ip, r4
     a88:	0bf42400 	bleq	ffd09a90 <__bss_end+0xffd00aa4>
     a8c:	1a010000 	bne	40a94 <__bss_end+0x37aa8>
     a90:	0000330e 	andeq	r3, r0, lr, lsl #6
     a94:	74910200 	ldrvc	r0, [r1], #512	; 0x200
     a98:	000b7724 	andeq	r7, fp, r4, lsr #14
     a9c:	1b1a0100 	blne	680ea4 <__bss_end+0x677eb8>
     aa0:	000007d4 	ldrdeq	r0, [r0], -r4
     aa4:	00709102 	rsbseq	r9, r0, r2, lsl #2
     aa8:	07da040c 	ldrbeq	r0, [sl, ip, lsl #8]
     aac:	040c0000 	streq	r0, [ip], #-0
     ab0:	00000025 	andeq	r0, r0, r5, lsr #32
     ab4:	0006ae25 	andeq	sl, r6, r5, lsr #28
     ab8:	06130100 	ldreq	r0, [r3], -r0, lsl #2
     abc:	00000a7b 	andeq	r0, r0, fp, ror sl
     ac0:	0000822c 	andeq	r8, r0, ip, lsr #4
     ac4:	00000080 	andeq	r0, r0, r0, lsl #1
     ac8:	a8249c01 	stmdage	r4!, {r0, sl, fp, ip, pc}
     acc:	01000006 	tsteq	r0, r6
     ad0:	01a71113 			; <UNDEFINED> instruction: 0x01a71113
     ad4:	91020000 	mrsls	r0, (UNDEF: 2)
     ad8:	1f000077 	svcne	0x00000077
     adc:	0400000b 	streq	r0, [r0], #-11
     ae0:	00042200 	andeq	r2, r4, r0, lsl #4
     ae4:	76010400 	strvc	r0, [r1], -r0, lsl #8
     ae8:	0400000f 	streq	r0, [r0], #-15
     aec:	00000e4f 	andeq	r0, r0, pc, asr #28
     af0:	00000c3e 	andeq	r0, r0, lr, lsr ip
     af4:	000083d4 	ldrdeq	r8, [r0], -r4
     af8:	0000045c 	andeq	r0, r0, ip, asr r4
     afc:	00000586 	andeq	r0, r0, r6, lsl #11
     b00:	8d080102 	stfhis	f0, [r8, #-8]
     b04:	03000009 	movweq	r0, #9
     b08:	00000025 	andeq	r0, r0, r5, lsr #32
     b0c:	d9050202 	stmdble	r5, {r1, r9}
     b10:	04000009 	streq	r0, [r0], #-9
     b14:	6e690504 	cdpvs	5, 6, cr0, cr9, cr4, {0}
     b18:	01020074 	tsteq	r2, r4, ror r0
     b1c:	00098408 	andeq	r8, r9, r8, lsl #8
     b20:	07020200 	streq	r0, [r2, -r0, lsl #4]
     b24:	000007ef 	andeq	r0, r0, pc, ror #15
     b28:	000b6e05 	andeq	r6, fp, r5, lsl #28
     b2c:	07090700 	streq	r0, [r9, -r0, lsl #14]
     b30:	0000005e 	andeq	r0, r0, lr, asr r0
     b34:	00004d03 	andeq	r4, r0, r3, lsl #26
     b38:	07040200 	streq	r0, [r4, -r0, lsl #4]
     b3c:	000007a8 	andeq	r0, r0, r8, lsr #15
     b40:	00068506 	andeq	r8, r6, r6, lsl #10
     b44:	06020800 	streq	r0, [r2], -r0, lsl #16
     b48:	00008b08 	andeq	r8, r0, r8, lsl #22
     b4c:	30720700 	rsbscc	r0, r2, r0, lsl #14
     b50:	0e080200 	cdpeq	2, 0, cr0, cr8, cr0, {0}
     b54:	0000004d 	andeq	r0, r0, sp, asr #32
     b58:	31720700 	cmncc	r2, r0, lsl #14
     b5c:	0e090200 	cdpeq	2, 0, cr0, cr9, cr0, {0}
     b60:	0000004d 	andeq	r0, r0, sp, asr #32
     b64:	00080004 	andeq	r0, r8, r4
     b68:	0500000f 	streq	r0, [r0, #-15]
     b6c:	00003804 	andeq	r3, r0, r4, lsl #16
     b70:	0c0d0200 	sfmeq	f0, 4, [sp], {-0}
     b74:	000000a9 	andeq	r0, r0, r9, lsr #1
     b78:	004b4f09 	subeq	r4, fp, r9, lsl #30
     b7c:	0cec0a00 	vstmiaeq	ip!, {s1-s0}
     b80:	00010000 	andeq	r0, r1, r0
     b84:	00054108 	andeq	r4, r5, r8, lsl #2
     b88:	38040500 	stmdacc	r4, {r8, sl}
     b8c:	02000000 	andeq	r0, r0, #0
     b90:	00e00c1e 	rsceq	r0, r0, lr, lsl ip
     b94:	f80a0000 			; <UNDEFINED> instruction: 0xf80a0000
     b98:	00000006 	andeq	r0, r0, r6
     b9c:	000c2e0a 	andeq	r2, ip, sl, lsl #28
     ba0:	0e0a0100 	adfeqe	f0, f2, f0
     ba4:	0200000c 	andeq	r0, r0, #12
     ba8:	0008220a 	andeq	r2, r8, sl, lsl #4
     bac:	130a0300 	movwne	r0, #41728	; 0xa300
     bb0:	04000009 	streq	r0, [r0], #-9
     bb4:	0006c10a 	andeq	ip, r6, sl, lsl #2
     bb8:	08000500 	stmdaeq	r0, {r8, sl}
     bbc:	00000bb1 			; <UNDEFINED> instruction: 0x00000bb1
     bc0:	00380405 	eorseq	r0, r8, r5, lsl #8
     bc4:	3f020000 	svccc	0x00020000
     bc8:	00011d0c 	andeq	r1, r1, ip, lsl #26
     bcc:	03ff0a00 	mvnseq	r0, #0, 20
     bd0:	0a000000 	beq	bd8 <shift+0xbd8>
     bd4:	00000556 	andeq	r0, r0, r6, asr r5
     bd8:	09060a01 	stmdbeq	r6, {r0, r9, fp}
     bdc:	0a020000 	beq	80be4 <__bss_end+0x77bf8>
     be0:	00000bee 	andeq	r0, r0, lr, ror #23
     be4:	0c380a03 			; <UNDEFINED> instruction: 0x0c380a03
     be8:	0a040000 	beq	100bf0 <__bss_end+0xf7c04>
     bec:	000008cd 	andeq	r0, r0, sp, asr #17
     bf0:	080f0a05 	stmdaeq	pc, {r0, r2, r9, fp}	; <UNPREDICTABLE>
     bf4:	00060000 	andeq	r0, r6, r0
     bf8:	00102708 	andseq	r2, r0, r8, lsl #14
     bfc:	38040500 	stmdacc	r4, {r8, sl}
     c00:	02000000 	andeq	r0, r0, #0
     c04:	01480c66 	cmpeq	r8, r6, ror #24
     c08:	440a0000 	strmi	r0, [sl], #-0
     c0c:	0000000e 	andeq	r0, r0, lr
     c10:	000d490a 	andeq	r4, sp, sl, lsl #18
     c14:	c90a0100 	stmdbgt	sl, {r8}
     c18:	0200000e 	andeq	r0, r0, #14
     c1c:	000d6e0a 	andeq	r6, sp, sl, lsl #28
     c20:	0b000300 	bleq	1828 <shift+0x1828>
     c24:	000008e7 	andeq	r0, r0, r7, ror #17
     c28:	59140503 	ldmdbpl	r4, {r0, r1, r8, sl}
     c2c:	05000000 	streq	r0, [r0, #-0]
     c30:	008f8803 	addeq	r8, pc, r3, lsl #16
     c34:	08f50b00 	ldmeq	r5!, {r8, r9, fp}^
     c38:	06030000 	streq	r0, [r3], -r0
     c3c:	00005914 	andeq	r5, r0, r4, lsl r9
     c40:	8c030500 	cfstr32hi	mvfx0, [r3], {-0}
     c44:	0b00008f 	bleq	e88 <shift+0xe88>
     c48:	000008b7 			; <UNDEFINED> instruction: 0x000008b7
     c4c:	591a0704 	ldmdbpl	sl, {r2, r8, r9, sl}
     c50:	05000000 	streq	r0, [r0, #-0]
     c54:	008f9003 	addeq	r9, pc, r3
     c58:	05940b00 	ldreq	r0, [r4, #2816]	; 0xb00
     c5c:	09040000 	stmdbeq	r4, {}	; <UNPREDICTABLE>
     c60:	0000591a 	andeq	r5, r0, sl, lsl r9
     c64:	94030500 	strls	r0, [r3], #-1280	; 0xfffffb00
     c68:	0b00008f 	bleq	eac <shift+0xeac>
     c6c:	00000976 	andeq	r0, r0, r6, ror r9
     c70:	591a0b04 	ldmdbpl	sl, {r2, r8, r9, fp}
     c74:	05000000 	streq	r0, [r0, #-0]
     c78:	008f9803 	addeq	r9, pc, r3, lsl #16
     c7c:	07c90b00 	strbeq	r0, [r9, r0, lsl #22]
     c80:	0d040000 	stceq	0, cr0, [r4, #-0]
     c84:	0000591a 	andeq	r5, r0, sl, lsl r9
     c88:	9c030500 	cfstr32ls	mvfx0, [r3], {-0}
     c8c:	0b00008f 	bleq	ed0 <shift+0xed0>
     c90:	0000069e 	muleq	r0, lr, r6
     c94:	591a0f04 	ldmdbpl	sl, {r2, r8, r9, sl, fp}
     c98:	05000000 	streq	r0, [r0, #-0]
     c9c:	008fa003 	addeq	sl, pc, r3
     ca0:	107a0800 	rsbsne	r0, sl, r0, lsl #16
     ca4:	04050000 	streq	r0, [r5], #-0
     ca8:	00000038 	andeq	r0, r0, r8, lsr r0
     cac:	eb0c1b04 	bl	3078c4 <__bss_end+0x2fe8d8>
     cb0:	0a000001 	beq	cbc <shift+0xcbc>
     cb4:	00000a91 	muleq	r0, r1, sl
     cb8:	0bfe0a00 	bleq	fff834c0 <__bss_end+0xfff7a4d4>
     cbc:	0a010000 	beq	40cc4 <__bss_end+0x37cd8>
     cc0:	00000901 	andeq	r0, r0, r1, lsl #18
     cc4:	700c0002 	andvc	r0, ip, r2
     cc8:	02000009 	andeq	r0, r0, #9
     ccc:	08280201 	stmdaeq	r8!, {r0, r9}
     cd0:	040d0000 	streq	r0, [sp], #-0
     cd4:	0000002c 	andeq	r0, r0, ip, lsr #32
     cd8:	01eb040d 	mvneq	r0, sp, lsl #8
     cdc:	400b0000 	andmi	r0, fp, r0
     ce0:	05000007 	streq	r0, [r0, #-7]
     ce4:	00591404 	subseq	r1, r9, r4, lsl #8
     ce8:	03050000 	movweq	r0, #20480	; 0x5000
     cec:	00008fa4 	andeq	r8, r0, r4, lsr #31
     cf0:	0003f40b 	andeq	pc, r3, fp, lsl #8
     cf4:	14070500 	strne	r0, [r7], #-1280	; 0xfffffb00
     cf8:	00000059 	andeq	r0, r0, r9, asr r0
     cfc:	8fa80305 	svchi	0x00a80305
     d00:	c20b0000 	andgt	r0, fp, #0
     d04:	05000005 	streq	r0, [r0, #-5]
     d08:	0059140a 	subseq	r1, r9, sl, lsl #8
     d0c:	03050000 	movweq	r0, #20480	; 0x5000
     d10:	00008fac 	andeq	r8, r0, ip, lsr #31
     d14:	00085d08 	andeq	r5, r8, r8, lsl #26
     d18:	38040500 	stmdacc	r4, {r8, sl}
     d1c:	05000000 	streq	r0, [r0, #-0]
     d20:	02700c0d 	rsbseq	r0, r0, #3328	; 0xd00
     d24:	4e090000 	cdpmi	0, 0, cr0, cr9, cr0, {0}
     d28:	00007765 	andeq	r7, r0, r5, ror #14
     d2c:	0008540a 	andeq	r5, r8, sl, lsl #8
     d30:	ff0a0100 			; <UNDEFINED> instruction: 0xff0a0100
     d34:	02000009 	andeq	r0, r0, #9
     d38:	0008370a 	andeq	r3, r8, sl, lsl #14
     d3c:	140a0300 	strne	r0, [sl], #-768	; 0xfffffd00
     d40:	04000008 	streq	r0, [r0], #-8
     d44:	00090c0a 	andeq	r0, r9, sl, lsl #24
     d48:	06000500 	streq	r0, [r0], -r0, lsl #10
     d4c:	000006b4 			; <UNDEFINED> instruction: 0x000006b4
     d50:	081b0510 	ldmdaeq	fp, {r4, r8, sl}
     d54:	000002af 	andeq	r0, r0, pc, lsr #5
     d58:	00726c07 	rsbseq	r6, r2, r7, lsl #24
     d5c:	af131d05 	svcge	0x00131d05
     d60:	00000002 	andeq	r0, r0, r2
     d64:	00707307 	rsbseq	r7, r0, r7, lsl #6
     d68:	af131e05 	svcge	0x00131e05
     d6c:	04000002 	streq	r0, [r0], #-2
     d70:	00637007 	rsbeq	r7, r3, r7
     d74:	af131f05 	svcge	0x00131f05
     d78:	08000002 	stmdaeq	r0, {r1}
     d7c:	0006ca0e 	andeq	ip, r6, lr, lsl #20
     d80:	13200500 	nopne	{0}	; <UNPREDICTABLE>
     d84:	000002af 	andeq	r0, r0, pc, lsr #5
     d88:	0402000c 	streq	r0, [r2], #-12
     d8c:	0007a307 	andeq	sl, r7, r7, lsl #6
     d90:	04610600 	strbteq	r0, [r1], #-1536	; 0xfffffa00
     d94:	05700000 	ldrbeq	r0, [r0, #-0]!
     d98:	03460828 	movteq	r0, #26664	; 0x6828
     d9c:	850e0000 	strhi	r0, [lr, #-0]
     da0:	0500000a 	streq	r0, [r0, #-10]
     da4:	0270122a 	rsbseq	r1, r0, #-1610612734	; 0xa0000002
     da8:	07000000 	streq	r0, [r0, -r0]
     dac:	00646970 	rsbeq	r6, r4, r0, ror r9
     db0:	5e122b05 	vnmlspl.f64	d2, d2, d5
     db4:	10000000 	andne	r0, r0, r0
     db8:	00057f0e 	andeq	r7, r5, lr, lsl #30
     dbc:	112c0500 			; <UNDEFINED> instruction: 0x112c0500
     dc0:	00000239 	andeq	r0, r0, r9, lsr r2
     dc4:	08710e14 	ldmdaeq	r1!, {r2, r4, r9, sl, fp}^
     dc8:	2d050000 	stccs	0, cr0, [r5, #-0]
     dcc:	00005e12 	andeq	r5, r0, r2, lsl lr
     dd0:	7f0e1800 	svcvc	0x000e1800
     dd4:	05000008 	streq	r0, [r0, #-8]
     dd8:	005e122e 	subseq	r1, lr, lr, lsr #4
     ddc:	0e1c0000 	cdpeq	0, 1, cr0, cr12, cr0, {0}
     de0:	00000691 	muleq	r0, r1, r6
     de4:	460c2f05 	strmi	r2, [ip], -r5, lsl #30
     de8:	20000003 	andcs	r0, r0, r3
     dec:	0008950e 	andeq	r9, r8, lr, lsl #10
     df0:	09300500 	ldmdbeq	r0!, {r8, sl}
     df4:	00000038 	andeq	r0, r0, r8, lsr r0
     df8:	0a9b0e60 	beq	fe6c4780 <__bss_end+0xfe6bb794>
     dfc:	31050000 	mrscc	r0, (UNDEF: 5)
     e00:	00004d0e 	andeq	r4, r0, lr, lsl #26
     e04:	130e6400 	movwne	r6, #58368	; 0xe400
     e08:	05000007 	streq	r0, [r0, #-7]
     e0c:	004d0e33 	subeq	r0, sp, r3, lsr lr
     e10:	0e680000 	cdpeq	0, 6, cr0, cr8, cr0, {0}
     e14:	0000070a 	andeq	r0, r0, sl, lsl #14
     e18:	4d0e3405 	cfstrsmi	mvf3, [lr, #-20]	; 0xffffffec
     e1c:	6c000000 	stcvs	0, cr0, [r0], {-0}
     e20:	01fd0f00 	mvnseq	r0, r0, lsl #30
     e24:	03560000 	cmpeq	r6, #0
     e28:	5e100000 	cdppl	0, 1, cr0, cr0, cr0, {0}
     e2c:	0f000000 	svceq	0x00000000
     e30:	0bc90b00 	bleq	ff243a38 <__bss_end+0xff23aa4c>
     e34:	0a060000 	beq	180e3c <__bss_end+0x177e50>
     e38:	00005914 	andeq	r5, r0, r4, lsl r9
     e3c:	b0030500 	andlt	r0, r3, r0, lsl #10
     e40:	0800008f 	stmdaeq	r0, {r0, r1, r2, r3, r7}
     e44:	0000083f 	andeq	r0, r0, pc, lsr r8
     e48:	00380405 	eorseq	r0, r8, r5, lsl #8
     e4c:	0d060000 	stceq	0, cr0, [r6, #-0]
     e50:	0003870c 	andeq	r8, r3, ip, lsl #14
     e54:	055b0a00 	ldrbeq	r0, [fp, #-2560]	; 0xfffff600
     e58:	0a000000 	beq	e60 <shift+0xe60>
     e5c:	000003e9 	andeq	r0, r0, r9, ror #7
     e60:	68030001 	stmdavs	r3, {r0}
     e64:	08000003 	stmdaeq	r0, {r0, r1}
     e68:	00000dd6 	ldrdeq	r0, [r0], -r6
     e6c:	00380405 	eorseq	r0, r8, r5, lsl #8
     e70:	14060000 	strne	r0, [r6], #-0
     e74:	0003ab0c 	andeq	sl, r3, ip, lsl #22
     e78:	0c8f0a00 	vstmiaeq	pc, {s0-s-1}
     e7c:	0a000000 	beq	e84 <shift+0xe84>
     e80:	00000ebb 			; <UNDEFINED> instruction: 0x00000ebb
     e84:	8c030001 	stchi	0, cr0, [r3], {1}
     e88:	06000003 	streq	r0, [r0], -r3
     e8c:	00000b4f 	andeq	r0, r0, pc, asr #22
     e90:	081b060c 	ldmdaeq	fp, {r2, r3, r9, sl}
     e94:	000003e5 	andeq	r0, r0, r5, ror #7
     e98:	0004330e 	andeq	r3, r4, lr, lsl #6
     e9c:	191d0600 	ldmdbne	sp, {r9, sl}
     ea0:	000003e5 	andeq	r0, r0, r5, ror #7
     ea4:	051e0e00 	ldreq	r0, [lr, #-3584]	; 0xfffff200
     ea8:	1e060000 	cdpne	0, 0, cr0, cr6, cr0, {0}
     eac:	0003e519 	andeq	lr, r3, r9, lsl r5
     eb0:	0f0e0400 	svceq	0x000e0400
     eb4:	0600000b 	streq	r0, [r0], -fp
     eb8:	03eb131f 	mvneq	r1, #2080374784	; 0x7c000000
     ebc:	00080000 	andeq	r0, r8, r0
     ec0:	03b0040d 	movseq	r0, #218103808	; 0xd000000
     ec4:	040d0000 	streq	r0, [sp], #-0
     ec8:	000002b6 			; <UNDEFINED> instruction: 0x000002b6
     ecc:	0005d511 	andeq	sp, r5, r1, lsl r5
     ed0:	22061400 	andcs	r1, r6, #0, 8
     ed4:	00067307 	andeq	r7, r6, r7, lsl #6
     ed8:	082d0e00 	stmdaeq	sp!, {r9, sl, fp}
     edc:	26060000 	strcs	r0, [r6], -r0
     ee0:	00004d12 	andeq	r4, r0, r2, lsl sp
     ee4:	dd0e0000 	stcle	0, cr0, [lr, #-0]
     ee8:	06000004 	streq	r0, [r0], -r4
     eec:	03e51d29 	mvneq	r1, #2624	; 0xa40
     ef0:	0e040000 	cdpeq	0, 0, cr0, cr4, cr0, {0}
     ef4:	00000a68 	andeq	r0, r0, r8, ror #20
     ef8:	e51d2c06 	ldr	r2, [sp, #-3078]	; 0xfffff3fa
     efc:	08000003 	stmdaeq	r0, {r0, r1}
     f00:	000ba712 	andeq	sl, fp, r2, lsl r7
     f04:	0e2f0600 	cfmadda32eq	mvax0, mvax0, mvfx15, mvfx0
     f08:	00000b2c 	andeq	r0, r0, ip, lsr #22
     f0c:	00000439 	andeq	r0, r0, r9, lsr r4
     f10:	00000444 	andeq	r0, r0, r4, asr #8
     f14:	00067813 	andeq	r7, r6, r3, lsl r8
     f18:	03e51400 	mvneq	r1, #0, 8
     f1c:	15000000 	strne	r0, [r0, #-0]
     f20:	00000b14 	andeq	r0, r0, r4, lsl fp
     f24:	380e3106 	stmdacc	lr, {r1, r2, r8, ip, sp}
     f28:	f0000004 			; <UNDEFINED> instruction: 0xf0000004
     f2c:	5c000001 	stcpl	0, cr0, [r0], {1}
     f30:	67000004 	strvs	r0, [r0, -r4]
     f34:	13000004 	movwne	r0, #4
     f38:	00000678 	andeq	r0, r0, r8, ror r6
     f3c:	0003eb14 	andeq	lr, r3, r4, lsl fp
     f40:	62160000 	andsvs	r0, r6, #0
     f44:	0600000b 	streq	r0, [r0], -fp
     f48:	0aea1d35 	beq	ffa88424 <__bss_end+0xffa7f438>
     f4c:	03e50000 	mvneq	r0, #0
     f50:	80020000 	andhi	r0, r2, r0
     f54:	86000004 	strhi	r0, [r0], -r4
     f58:	13000004 	movwne	r0, #4
     f5c:	00000678 	andeq	r0, r0, r8, ror r6
     f60:	08021600 	stmdaeq	r2, {r9, sl, ip}
     f64:	37060000 	strcc	r0, [r6, -r0]
     f68:	0009a41d 	andeq	sl, r9, sp, lsl r4
     f6c:	0003e500 	andeq	lr, r3, r0, lsl #10
     f70:	049f0200 	ldreq	r0, [pc], #512	; f78 <shift+0xf78>
     f74:	04a50000 	strteq	r0, [r5], #0
     f78:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
     f7c:	00000006 	andeq	r0, r0, r6
     f80:	00089f17 	andeq	r9, r8, r7, lsl pc
     f84:	31390600 	teqcc	r9, r0, lsl #12
     f88:	00000691 	muleq	r0, r1, r6
     f8c:	d516020c 	ldrle	r0, [r6, #-524]	; 0xfffffdf4
     f90:	06000005 	streq	r0, [r0], -r5
     f94:	0c14093c 			; <UNDEFINED> instruction: 0x0c14093c
     f98:	06780000 	ldrbteq	r0, [r8], -r0
     f9c:	cc010000 	stcgt	0, cr0, [r1], {-0}
     fa0:	d2000004 	andle	r0, r0, #4
     fa4:	13000004 	movwne	r0, #4
     fa8:	00000678 	andeq	r0, r0, r8, ror r6
     fac:	05701600 	ldrbeq	r1, [r0, #-1536]!	; 0xfffffa00
     fb0:	3f060000 	svccc	0x00060000
     fb4:	000b7c12 	andeq	r7, fp, r2, lsl ip
     fb8:	00004d00 	andeq	r4, r0, r0, lsl #26
     fbc:	04eb0100 	strbteq	r0, [fp], #256	; 0x100
     fc0:	05000000 	streq	r0, [r0, #-0]
     fc4:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
     fc8:	14000006 	strne	r0, [r0], #-6
     fcc:	0000069a 	muleq	r0, sl, r6
     fd0:	00005e14 	andeq	r5, r0, r4, lsl lr
     fd4:	01f01400 	mvnseq	r1, r0, lsl #8
     fd8:	18000000 	stmdane	r0, {}	; <UNPREDICTABLE>
     fdc:	00000b23 	andeq	r0, r0, r3, lsr #22
     fe0:	220e4206 	andcs	r4, lr, #1610612736	; 0x60000000
     fe4:	01000009 	tsteq	r0, r9
     fe8:	00000515 	andeq	r0, r0, r5, lsl r5
     fec:	0000051b 	andeq	r0, r0, fp, lsl r5
     ff0:	00067813 	andeq	r7, r6, r3, lsl r8
     ff4:	8f160000 	svchi	0x00160000
     ff8:	06000007 	streq	r0, [r0], -r7
     ffc:	04f01745 	ldrbteq	r1, [r0], #1861	; 0x745
    1000:	03eb0000 	mvneq	r0, #0
    1004:	34010000 	strcc	r0, [r1], #-0
    1008:	3a000005 	bcc	1024 <shift+0x1024>
    100c:	13000005 	movwne	r0, #5
    1010:	000006a0 	andeq	r0, r0, r0, lsr #13
    1014:	05231600 	streq	r1, [r3, #-1536]!	; 0xfffffa00
    1018:	48060000 	stmdami	r6, {}	; <UNPREDICTABLE>
    101c:	000aa717 	andeq	sl, sl, r7, lsl r7
    1020:	0003eb00 	andeq	lr, r3, r0, lsl #22
    1024:	05530100 	ldrbeq	r0, [r3, #-256]	; 0xffffff00
    1028:	055e0000 	ldrbeq	r0, [lr, #-0]
    102c:	a0130000 	andsge	r0, r3, r0
    1030:	14000006 	strne	r0, [r0], #-6
    1034:	0000004d 	andeq	r0, r0, sp, asr #32
    1038:	0bd81800 	bleq	ff607040 <__bss_end+0xff5fe054>
    103c:	4b060000 	blmi	181044 <__bss_end+0x178058>
    1040:	0004040e 	andeq	r0, r4, lr, lsl #8
    1044:	05730100 	ldrbeq	r0, [r3, #-256]!	; 0xffffff00
    1048:	05790000 	ldrbeq	r0, [r9, #-0]!
    104c:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
    1050:	00000006 	andeq	r0, r0, r6
    1054:	000b1416 	andeq	r1, fp, r6, lsl r4
    1058:	0e4d0600 	cdpeq	6, 4, cr0, cr13, cr0, {0}
    105c:	000006d0 	ldrdeq	r0, [r0], -r0	; <UNPREDICTABLE>
    1060:	000001f0 	strdeq	r0, [r0], -r0	; <UNPREDICTABLE>
    1064:	00059201 	andeq	r9, r5, r1, lsl #4
    1068:	00059d00 	andeq	r9, r5, r0, lsl #26
    106c:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
    1070:	4d140000 	ldcmi	0, cr0, [r4, #-0]
    1074:	00000000 	andeq	r0, r0, r0
    1078:	0007b516 	andeq	fp, r7, r6, lsl r5
    107c:	12500600 	subsne	r0, r0, #0, 12
    1080:	00000943 	andeq	r0, r0, r3, asr #18
    1084:	0000004d 	andeq	r0, r0, sp, asr #32
    1088:	0005b601 	andeq	fp, r5, r1, lsl #12
    108c:	0005c100 	andeq	ip, r5, r0, lsl #2
    1090:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
    1094:	fd140000 	ldc2	0, cr0, [r4, #-0]
    1098:	00000001 	andeq	r0, r0, r1
    109c:	00046e16 	andeq	r6, r4, r6, lsl lr
    10a0:	0e530600 	cdpeq	6, 5, cr0, cr3, cr0, {0}
    10a4:	00000759 	andeq	r0, r0, r9, asr r7
    10a8:	000001f0 	strdeq	r0, [r0], -r0	; <UNPREDICTABLE>
    10ac:	0005da01 	andeq	sp, r5, r1, lsl #20
    10b0:	0005e500 	andeq	lr, r5, r0, lsl #10
    10b4:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
    10b8:	4d140000 	ldcmi	0, cr0, [r4, #-0]
    10bc:	00000000 	andeq	r0, r0, r0
    10c0:	0007dc18 	andeq	sp, r7, r8, lsl ip
    10c4:	0e560600 	cdpeq	6, 5, cr0, cr6, cr0, {0}
    10c8:	00000481 	andeq	r0, r0, r1, lsl #9
    10cc:	0005fa01 	andeq	pc, r5, r1, lsl #20
    10d0:	00061900 	andeq	r1, r6, r0, lsl #18
    10d4:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
    10d8:	a9140000 	ldmdbge	r4, {}	; <UNPREDICTABLE>
    10dc:	14000000 	strne	r0, [r0], #-0
    10e0:	0000004d 	andeq	r0, r0, sp, asr #32
    10e4:	00004d14 	andeq	r4, r0, r4, lsl sp
    10e8:	004d1400 	subeq	r1, sp, r0, lsl #8
    10ec:	a6140000 	ldrge	r0, [r4], -r0
    10f0:	00000006 	andeq	r0, r0, r6
    10f4:	000ad418 	andeq	sp, sl, r8, lsl r4
    10f8:	0e580600 	cdpeq	6, 5, cr0, cr8, cr0, {0}
    10fc:	00000639 	andeq	r0, r0, r9, lsr r6
    1100:	00062e01 	andeq	r2, r6, r1, lsl #28
    1104:	00064d00 	andeq	r4, r6, r0, lsl #26
    1108:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
    110c:	e0140000 	ands	r0, r4, r0
    1110:	14000000 	strne	r0, [r0], #-0
    1114:	0000004d 	andeq	r0, r0, sp, asr #32
    1118:	00004d14 	andeq	r4, r0, r4, lsl sp
    111c:	004d1400 	subeq	r1, sp, r0, lsl #8
    1120:	a6140000 	ldrge	r0, [r4], -r0
    1124:	00000006 	andeq	r0, r0, r6
    1128:	0005af19 	andeq	sl, r5, r9, lsl pc
    112c:	0e5b0600 	cdpeq	6, 5, cr0, cr11, cr0, {0}
    1130:	000005f6 	strdeq	r0, [r0], -r6
    1134:	000001f0 	strdeq	r0, [r0], -r0	; <UNPREDICTABLE>
    1138:	00066201 	andeq	r6, r6, r1, lsl #4
    113c:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
    1140:	68140000 	ldmdavs	r4, {}	; <UNPREDICTABLE>
    1144:	14000003 	strne	r0, [r0], #-3
    1148:	000006ac 	andeq	r0, r0, ip, lsr #13
    114c:	f1030000 			; <UNDEFINED> instruction: 0xf1030000
    1150:	0d000003 	stceq	0, cr0, [r0, #-12]
    1154:	0003f104 	andeq	pc, r3, r4, lsl #2
    1158:	03e51a00 	mvneq	r1, #0, 20
    115c:	068b0000 	streq	r0, [fp], r0
    1160:	06910000 	ldreq	r0, [r1], r0
    1164:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
    1168:	00000006 	andeq	r0, r0, r6
    116c:	0003f11b 	andeq	pc, r3, fp, lsl r1	; <UNPREDICTABLE>
    1170:	00067e00 	andeq	r7, r6, r0, lsl #28
    1174:	3f040d00 	svccc	0x00040d00
    1178:	0d000000 	stceq	0, cr0, [r0, #-0]
    117c:	00067304 	andeq	r7, r6, r4, lsl #6
    1180:	65041c00 	strvs	r1, [r4, #-3072]	; 0xfffff400
    1184:	1d000000 	stcne	0, cr0, [r0, #-0]
    1188:	002c0f04 	eoreq	r0, ip, r4, lsl #30
    118c:	06be0000 	ldrteq	r0, [lr], r0
    1190:	5e100000 	cdppl	0, 1, cr0, cr0, cr0, {0}
    1194:	09000000 	stmdbeq	r0, {}	; <UNPREDICTABLE>
    1198:	06ae0300 	strteq	r0, [lr], r0, lsl #6
    119c:	381e0000 	ldmdacc	lr, {}	; <UNPREDICTABLE>
    11a0:	0100000d 	tsteq	r0, sp
    11a4:	06be0ca3 	ldrteq	r0, [lr], r3, lsr #25
    11a8:	03050000 	movweq	r0, #20480	; 0x5000
    11ac:	00008fb4 			; <UNDEFINED> instruction: 0x00008fb4
    11b0:	000ca81f 	andeq	sl, ip, pc, lsl r8
    11b4:	0aa50100 	beq	fe9415bc <__bss_end+0xfe9385d0>
    11b8:	00000dca 	andeq	r0, r0, sl, asr #27
    11bc:	0000004d 	andeq	r0, r0, sp, asr #32
    11c0:	00008780 	andeq	r8, r0, r0, lsl #15
    11c4:	000000b0 	strheq	r0, [r0], -r0	; <UNPREDICTABLE>
    11c8:	07339c01 	ldreq	r9, [r3, -r1, lsl #24]!
    11cc:	5d200000 	stcpl	0, cr0, [r0, #-0]
    11d0:	01000010 	tsteq	r0, r0, lsl r0
    11d4:	01f71ba5 	mvnseq	r1, r5, lsr #23
    11d8:	91030000 	mrsls	r0, (UNDEF: 3)
    11dc:	29207fac 	stmdbcs	r0!, {r2, r3, r5, r7, r8, r9, sl, fp, ip, sp, lr}
    11e0:	0100000e 	tsteq	r0, lr
    11e4:	004d2aa5 	subeq	r2, sp, r5, lsr #21
    11e8:	91030000 	mrsls	r0, (UNDEF: 3)
    11ec:	b31e7fa8 	tstlt	lr, #168, 30	; 0x2a0
    11f0:	0100000d 	tsteq	r0, sp
    11f4:	07330aa7 	ldreq	r0, [r3, -r7, lsr #21]!
    11f8:	91030000 	mrsls	r0, (UNDEF: 3)
    11fc:	a31e7fb4 	tstge	lr, #180, 30	; 0x2d0
    1200:	0100000c 	tsteq	r0, ip
    1204:	003809ab 	eorseq	r0, r8, fp, lsr #19
    1208:	91020000 	mrsls	r0, (UNDEF: 2)
    120c:	250f0074 	strcs	r0, [pc, #-116]	; 11a0 <shift+0x11a0>
    1210:	43000000 	movwmi	r0, #0
    1214:	10000007 	andne	r0, r0, r7
    1218:	0000005e 	andeq	r0, r0, lr, asr r0
    121c:	0e21003f 	mcreq	0, 1, r0, cr1, cr15, {1}
    1220:	0100000e 	tsteq	r0, lr
    1224:	0ee00a97 			; <UNDEFINED> instruction: 0x0ee00a97
    1228:	004d0000 	subeq	r0, sp, r0
    122c:	87440000 	strbhi	r0, [r4, -r0]
    1230:	003c0000 	eorseq	r0, ip, r0
    1234:	9c010000 	stcls	0, cr0, [r1], {-0}
    1238:	00000780 	andeq	r0, r0, r0, lsl #15
    123c:	71657222 	cmnvc	r5, r2, lsr #4
    1240:	20990100 	addscs	r0, r9, r0, lsl #2
    1244:	000003ab 	andeq	r0, r0, fp, lsr #7
    1248:	1e749102 	expnes	f1, f2
    124c:	00000dbf 			; <UNDEFINED> instruction: 0x00000dbf
    1250:	4d0e9a01 	vstrmi	s18, [lr, #-4]
    1254:	02000000 	andeq	r0, r0, #0
    1258:	23007091 	movwcs	r7, #145	; 0x91
    125c:	00000e32 	andeq	r0, r0, r2, lsr lr
    1260:	c4068e01 	strgt	r8, [r6], #-3585	; 0xfffff1ff
    1264:	0800000c 	stmdaeq	r0, {r2, r3}
    1268:	3c000087 	stccc	0, cr0, [r0], {135}	; 0x87
    126c:	01000000 	mrseq	r0, (UNDEF: 0)
    1270:	0007b99c 	muleq	r7, ip, r9
    1274:	0d062000 	stceq	0, cr2, [r6, #-0]
    1278:	8e010000 	cdphi	0, 0, cr0, cr1, cr0, {0}
    127c:	00004d21 	andeq	r4, r0, r1, lsr #26
    1280:	6c910200 	lfmvs	f0, 4, [r1], {0}
    1284:	71657222 	cmnvc	r5, r2, lsr #4
    1288:	20900100 	addscs	r0, r0, r0, lsl #2
    128c:	000003ab 	andeq	r0, r0, fp, lsr #7
    1290:	00749102 	rsbseq	r9, r4, r2, lsl #2
    1294:	000deb21 	andeq	lr, sp, r1, lsr #22
    1298:	0a820100 	beq	fe0816a0 <__bss_end+0xfe0786b4>
    129c:	00000d54 	andeq	r0, r0, r4, asr sp
    12a0:	0000004d 	andeq	r0, r0, sp, asr #32
    12a4:	000086cc 	andeq	r8, r0, ip, asr #13
    12a8:	0000003c 	andeq	r0, r0, ip, lsr r0
    12ac:	07f69c01 	ldrbeq	r9, [r6, r1, lsl #24]!
    12b0:	72220000 	eorvc	r0, r2, #0
    12b4:	01007165 	tsteq	r0, r5, ror #2
    12b8:	03872084 	orreq	r2, r7, #132	; 0x84
    12bc:	91020000 	mrsls	r0, (UNDEF: 2)
    12c0:	0c9c1e74 	ldceq	14, cr1, [ip], {116}	; 0x74
    12c4:	85010000 	strhi	r0, [r1, #-0]
    12c8:	00004d0e 	andeq	r4, r0, lr, lsl #26
    12cc:	70910200 	addsvc	r0, r1, r0, lsl #4
    12d0:	10402100 	subne	r2, r0, r0, lsl #2
    12d4:	76010000 	strvc	r0, [r1], -r0
    12d8:	000d1a0a 	andeq	r1, sp, sl, lsl #20
    12dc:	00004d00 	andeq	r4, r0, r0, lsl #26
    12e0:	00869000 	addeq	r9, r6, r0
    12e4:	00003c00 	andeq	r3, r0, r0, lsl #24
    12e8:	339c0100 	orrscc	r0, ip, #0, 2
    12ec:	22000008 	andcs	r0, r0, #8
    12f0:	00716572 	rsbseq	r6, r1, r2, ror r5
    12f4:	87207801 	strhi	r7, [r0, -r1, lsl #16]!
    12f8:	02000003 	andeq	r0, r0, #3
    12fc:	9c1e7491 	cfldrsls	mvf7, [lr], {145}	; 0x91
    1300:	0100000c 	tsteq	r0, ip
    1304:	004d0e79 	subeq	r0, sp, r9, ror lr
    1308:	91020000 	mrsls	r0, (UNDEF: 2)
    130c:	68210070 	stmdavs	r1!, {r4, r5, r6}
    1310:	0100000d 	tsteq	r0, sp
    1314:	0eab066a 	cdpeq	6, 10, cr0, cr11, cr10, {3}
    1318:	01f00000 	mvnseq	r0, r0
    131c:	863c0000 	ldrthi	r0, [ip], -r0
    1320:	00540000 	subseq	r0, r4, r0
    1324:	9c010000 	stcls	0, cr0, [r1], {-0}
    1328:	0000087f 	andeq	r0, r0, pc, ror r8
    132c:	000dbf20 	andeq	fp, sp, r0, lsr #30
    1330:	156a0100 	strbne	r0, [sl, #-256]!	; 0xffffff00
    1334:	0000004d 	andeq	r0, r0, sp, asr #32
    1338:	206c9102 	rsbcs	r9, ip, r2, lsl #2
    133c:	0000070a 	andeq	r0, r0, sl, lsl #14
    1340:	4d256a01 	vstmdbmi	r5!, {s12}
    1344:	02000000 	andeq	r0, r0, #0
    1348:	381e6891 	ldmdacc	lr, {r0, r4, r7, fp, sp, lr}
    134c:	01000010 	tsteq	r0, r0, lsl r0
    1350:	004d0e6c 	subeq	r0, sp, ip, ror #28
    1354:	91020000 	mrsls	r0, (UNDEF: 2)
    1358:	db210074 	blle	841530 <__bss_end+0x838544>
    135c:	0100000c 	tsteq	r0, ip
    1360:	0f17125d 	svceq	0x0017125d
    1364:	008b0000 	addeq	r0, fp, r0
    1368:	85ec0000 	strbhi	r0, [ip, #0]!
    136c:	00500000 	subseq	r0, r0, r0
    1370:	9c010000 	stcls	0, cr0, [r1], {-0}
    1374:	000008da 	ldrdeq	r0, [r0], -sl
    1378:	000eb620 	andeq	fp, lr, r0, lsr #12
    137c:	205d0100 	subscs	r0, sp, r0, lsl #2
    1380:	0000004d 	andeq	r0, r0, sp, asr #32
    1384:	206c9102 	rsbcs	r9, ip, r2, lsl #2
    1388:	00000df4 	strdeq	r0, [r0], -r4
    138c:	4d2f5d01 	stcmi	13, cr5, [pc, #-4]!	; 1390 <shift+0x1390>
    1390:	02000000 	andeq	r0, r0, #0
    1394:	0a206891 	beq	81b5e0 <__bss_end+0x8125f4>
    1398:	01000007 	tsteq	r0, r7
    139c:	004d3f5d 	subeq	r3, sp, sp, asr pc
    13a0:	91020000 	mrsls	r0, (UNDEF: 2)
    13a4:	10381e64 	eorsne	r1, r8, r4, ror #28
    13a8:	5f010000 	svcpl	0x00010000
    13ac:	00008b16 	andeq	r8, r0, r6, lsl fp
    13b0:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    13b4:	0f4d2100 	svceq	0x004d2100
    13b8:	51010000 	mrspl	r0, (UNDEF: 1)
    13bc:	000ce00a 	andeq	lr, ip, sl
    13c0:	00004d00 	andeq	r4, r0, r0, lsl #26
    13c4:	0085a800 	addeq	sl, r5, r0, lsl #16
    13c8:	00004400 	andeq	r4, r0, r0, lsl #8
    13cc:	269c0100 	ldrcs	r0, [ip], r0, lsl #2
    13d0:	20000009 	andcs	r0, r0, r9
    13d4:	00000eb6 			; <UNDEFINED> instruction: 0x00000eb6
    13d8:	4d1a5101 	ldfmis	f5, [sl, #-4]
    13dc:	02000000 	andeq	r0, r0, #0
    13e0:	f4206c91 			; <UNDEFINED> instruction: 0xf4206c91
    13e4:	0100000d 	tsteq	r0, sp
    13e8:	004d2951 	subeq	r2, sp, r1, asr r9
    13ec:	91020000 	mrsls	r0, (UNDEF: 2)
    13f0:	0f461e68 	svceq	0x00461e68
    13f4:	53010000 	movwpl	r0, #4096	; 0x1000
    13f8:	00004d0e 	andeq	r4, r0, lr, lsl #26
    13fc:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    1400:	0f402100 	svceq	0x00402100
    1404:	44010000 	strmi	r0, [r1], #-0
    1408:	000f220a 	andeq	r2, pc, sl, lsl #4
    140c:	00004d00 	andeq	r4, r0, r0, lsl #26
    1410:	00855800 	addeq	r5, r5, r0, lsl #16
    1414:	00005000 	andeq	r5, r0, r0
    1418:	819c0100 	orrshi	r0, ip, r0, lsl #2
    141c:	20000009 	andcs	r0, r0, r9
    1420:	00000eb6 			; <UNDEFINED> instruction: 0x00000eb6
    1424:	4d194401 	cfldrsmi	mvf4, [r9, #-4]
    1428:	02000000 	andeq	r0, r0, #0
    142c:	94206c91 	strtls	r6, [r0], #-3217	; 0xfffff36f
    1430:	0100000d 	tsteq	r0, sp
    1434:	011d3044 	tsteq	sp, r4, asr #32
    1438:	91020000 	mrsls	r0, (UNDEF: 2)
    143c:	0dfa2068 	ldcleq	0, cr2, [sl, #416]!	; 0x1a0
    1440:	44010000 	strmi	r0, [r1], #-0
    1444:	0006ac41 	andeq	sl, r6, r1, asr #24
    1448:	64910200 	ldrvs	r0, [r1], #512	; 0x200
    144c:	0010381e 	andseq	r3, r0, lr, lsl r8
    1450:	0e460100 	dvfeqs	f0, f6, f0
    1454:	0000004d 	andeq	r0, r0, sp, asr #32
    1458:	00749102 	rsbseq	r9, r4, r2, lsl #2
    145c:	000c8923 	andeq	r8, ip, r3, lsr #18
    1460:	063e0100 	ldrteq	r0, [lr], -r0, lsl #2
    1464:	00000d9e 	muleq	r0, lr, sp
    1468:	0000852c 	andeq	r8, r0, ip, lsr #10
    146c:	0000002c 	andeq	r0, r0, ip, lsr #32
    1470:	09ab9c01 	stmibeq	fp!, {r0, sl, fp, ip, pc}
    1474:	b6200000 	strtlt	r0, [r0], -r0
    1478:	0100000e 	tsteq	r0, lr
    147c:	004d153e 	subeq	r1, sp, lr, lsr r5
    1480:	91020000 	mrsls	r0, (UNDEF: 2)
    1484:	b9210074 	stmdblt	r1!, {r2, r4, r5, r6}
    1488:	0100000d 	tsteq	r0, sp
    148c:	0e000a31 			; <UNDEFINED> instruction: 0x0e000a31
    1490:	004d0000 	subeq	r0, sp, r0
    1494:	84dc0000 	ldrbhi	r0, [ip], #0
    1498:	00500000 	subseq	r0, r0, r0
    149c:	9c010000 	stcls	0, cr0, [r1], {-0}
    14a0:	00000a06 	andeq	r0, r0, r6, lsl #20
    14a4:	000eb620 	andeq	fp, lr, r0, lsr #12
    14a8:	19310100 	ldmdbne	r1!, {r8}
    14ac:	0000004d 	andeq	r0, r0, sp, asr #32
    14b0:	206c9102 	rsbcs	r9, ip, r2, lsl #2
    14b4:	00000f63 	andeq	r0, r0, r3, ror #30
    14b8:	f72b3101 			; <UNDEFINED> instruction: 0xf72b3101
    14bc:	02000001 	andeq	r0, r0, #1
    14c0:	2d206891 	stccs	8, cr6, [r0, #-580]!	; 0xfffffdbc
    14c4:	0100000e 	tsteq	r0, lr
    14c8:	004d3c31 	subeq	r3, sp, r1, lsr ip
    14cc:	91020000 	mrsls	r0, (UNDEF: 2)
    14d0:	0f111e64 	svceq	0x00111e64
    14d4:	33010000 	movwcc	r0, #4096	; 0x1000
    14d8:	00004d0e 	andeq	r4, r0, lr, lsl #26
    14dc:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    14e0:	10622100 	rsbne	r2, r2, r0, lsl #2
    14e4:	24010000 	strcs	r0, [r1], #-0
    14e8:	000f6a0a 	andeq	r6, pc, sl, lsl #20
    14ec:	00004d00 	andeq	r4, r0, r0, lsl #26
    14f0:	00848c00 	addeq	r8, r4, r0, lsl #24
    14f4:	00005000 	andeq	r5, r0, r0
    14f8:	619c0100 	orrsvs	r0, ip, r0, lsl #2
    14fc:	2000000a 	andcs	r0, r0, sl
    1500:	00000eb6 			; <UNDEFINED> instruction: 0x00000eb6
    1504:	4d182401 	cfldrsmi	mvf2, [r8, #-4]
    1508:	02000000 	andeq	r0, r0, #0
    150c:	63206c91 			; <UNDEFINED> instruction: 0x63206c91
    1510:	0100000f 	tsteq	r0, pc
    1514:	0a672a24 	beq	19cbdac <__bss_end+0x19c2dc0>
    1518:	91020000 	mrsls	r0, (UNDEF: 2)
    151c:	0e2d2068 	cdpeq	0, 2, cr2, cr13, cr8, {3}
    1520:	24010000 	strcs	r0, [r1], #-0
    1524:	00004d3b 	andeq	r4, r0, fp, lsr sp
    1528:	64910200 	ldrvs	r0, [r1], #512	; 0x200
    152c:	000cad1e 	andeq	sl, ip, lr, lsl sp
    1530:	0e260100 	sufeqs	f0, f6, f0
    1534:	0000004d 	andeq	r0, r0, sp, asr #32
    1538:	00749102 	rsbseq	r9, r4, r2, lsl #2
    153c:	0025040d 	eoreq	r0, r5, sp, lsl #8
    1540:	61030000 	mrsvs	r0, (UNDEF: 3)
    1544:	2100000a 	tstcs	r0, sl
    1548:	00000dc5 	andeq	r0, r0, r5, asr #27
    154c:	6e0a1901 	vmlavs.f16	s2, s20, s2	; <UNPREDICTABLE>
    1550:	4d000010 	stcmi	0, cr0, [r0, #-64]	; 0xffffffc0
    1554:	48000000 	stmdami	r0, {}	; <UNPREDICTABLE>
    1558:	44000084 	strmi	r0, [r0], #-132	; 0xffffff7c
    155c:	01000000 	mrseq	r0, (UNDEF: 0)
    1560:	000ab89c 	muleq	sl, ip, r8
    1564:	10592000 	subsne	r2, r9, r0
    1568:	19010000 	stmdbne	r1, {}	; <UNPREDICTABLE>
    156c:	0001f71b 	andeq	pc, r1, fp, lsl r7	; <UNPREDICTABLE>
    1570:	6c910200 	lfmvs	f0, 4, [r1], {0}
    1574:	000f5e20 	andeq	r5, pc, r0, lsr #28
    1578:	35190100 	ldrcc	r0, [r9, #-256]	; 0xffffff00
    157c:	000001c6 	andeq	r0, r0, r6, asr #3
    1580:	1e689102 	lgnnee	f1, f2
    1584:	00000eb6 			; <UNDEFINED> instruction: 0x00000eb6
    1588:	4d0e1b01 	vstrmi	d1, [lr, #-4]
    158c:	02000000 	andeq	r0, r0, #0
    1590:	24007491 	strcs	r7, [r0], #-1169	; 0xfffffb6f
    1594:	00000cfa 	strdeq	r0, [r0], -sl
    1598:	b3061401 	movwlt	r1, #25601	; 0x6401
    159c:	2c00000c 	stccs	0, cr0, [r0], {12}
    15a0:	1c000084 	stcne	0, cr0, [r0], {132}	; 0x84
    15a4:	01000000 	mrseq	r0, (UNDEF: 0)
    15a8:	0f54239c 	svceq	0x0054239c
    15ac:	0e010000 	cdpeq	0, 0, cr0, cr1, cr0, {0}
    15b0:	000d8606 	andeq	r8, sp, r6, lsl #12
    15b4:	00840000 	addeq	r0, r4, r0
    15b8:	00002c00 	andeq	r2, r0, r0, lsl #24
    15bc:	f89c0100 			; <UNDEFINED> instruction: 0xf89c0100
    15c0:	2000000a 	andcs	r0, r0, sl
    15c4:	00000cf1 	strdeq	r0, [r0], -r1
    15c8:	38140e01 	ldmdacc	r4, {r0, r9, sl, fp}
    15cc:	02000000 	andeq	r0, r0, #0
    15d0:	25007491 	strcs	r7, [r0, #-1169]	; 0xfffffb6f
    15d4:	00001067 	andeq	r1, r0, r7, rrx
    15d8:	a80a0401 	stmdage	sl, {r0, sl}
    15dc:	4d00000d 	stcmi	0, cr0, [r0, #-52]	; 0xffffffcc
    15e0:	d4000000 	strle	r0, [r0], #-0
    15e4:	2c000083 	stccs	0, cr0, [r0], {131}	; 0x83
    15e8:	01000000 	mrseq	r0, (UNDEF: 0)
    15ec:	6970229c 	ldmdbvs	r0!, {r2, r3, r4, r7, r9, sp}^
    15f0:	06010064 	streq	r0, [r1], -r4, rrx
    15f4:	00004d0e 	andeq	r4, r0, lr, lsl #26
    15f8:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    15fc:	032e0000 			; <UNDEFINED> instruction: 0x032e0000
    1600:	00040000 	andeq	r0, r4, r0
    1604:	0000068b 	andeq	r0, r0, fp, lsl #13
    1608:	0f760104 	svceq	0x00760104
    160c:	ae040000 	cdpge	0, 0, cr0, cr4, cr0, {0}
    1610:	3e000010 	mcrcc	0, 0, r0, cr0, cr0, {0}
    1614:	3000000c 	andcc	r0, r0, ip
    1618:	b8000088 	stmdalt	r0, {r3, r7}
    161c:	52000004 	andpl	r0, r0, #4
    1620:	02000008 	andeq	r0, r0, #8
    1624:	00000049 	andeq	r0, r0, r9, asr #32
    1628:	00111703 	andseq	r1, r1, r3, lsl #14
    162c:	10050100 	andne	r0, r5, r0, lsl #2
    1630:	00000061 	andeq	r0, r0, r1, rrx
    1634:	32313011 	eorscc	r3, r1, #17
    1638:	36353433 			; <UNDEFINED> instruction: 0x36353433
    163c:	41393837 	teqmi	r9, r7, lsr r8
    1640:	45444342 	strbmi	r4, [r4, #-834]	; 0xfffffcbe
    1644:	04000046 	streq	r0, [r0], #-70	; 0xffffffba
    1648:	25010301 	strcs	r0, [r1, #-769]	; 0xfffffcff
    164c:	05000000 	streq	r0, [r0, #-0]
    1650:	00000074 	andeq	r0, r0, r4, ror r0
    1654:	00000061 	andeq	r0, r0, r1, rrx
    1658:	00006606 	andeq	r6, r0, r6, lsl #12
    165c:	07001000 	streq	r1, [r0, -r0]
    1660:	00000051 	andeq	r0, r0, r1, asr r0
    1664:	a8070408 	stmdage	r7, {r3, sl}
    1668:	08000007 	stmdaeq	r0, {r0, r1, r2}
    166c:	098d0801 	stmibeq	sp, {r0, fp}
    1670:	6d070000 	stcvs	0, cr0, [r7, #-0]
    1674:	09000000 	stmdbeq	r0, {}	; <UNPREDICTABLE>
    1678:	0000002a 	andeq	r0, r0, sl, lsr #32
    167c:	0011460a 	andseq	r4, r1, sl, lsl #12
    1680:	06640100 	strbteq	r0, [r4], -r0, lsl #2
    1684:	00001131 	andeq	r1, r0, r1, lsr r1
    1688:	00008c68 	andeq	r8, r0, r8, ror #24
    168c:	00000080 	andeq	r0, r0, r0, lsl #1
    1690:	00fb9c01 	rscseq	r9, fp, r1, lsl #24
    1694:	730b0000 	movwvc	r0, #45056	; 0xb000
    1698:	01006372 	tsteq	r0, r2, ror r3
    169c:	00fb1964 	rscseq	r1, fp, r4, ror #18
    16a0:	91020000 	mrsls	r0, (UNDEF: 2)
    16a4:	73640b64 	cmnvc	r4, #100, 22	; 0x19000
    16a8:	64010074 	strvs	r0, [r1], #-116	; 0xffffff8c
    16ac:	00010224 	andeq	r0, r1, r4, lsr #4
    16b0:	60910200 	addsvs	r0, r1, r0, lsl #4
    16b4:	6d756e0b 	ldclvs	14, cr6, [r5, #-44]!	; 0xffffffd4
    16b8:	2d640100 	stfcse	f0, [r4, #-0]
    16bc:	00000104 	andeq	r0, r0, r4, lsl #2
    16c0:	0c5c9102 	ldfeqp	f1, [ip], {2}
    16c4:	000011a0 	andeq	r1, r0, r0, lsr #3
    16c8:	0b0e6601 	bleq	39aed4 <__bss_end+0x391ee8>
    16cc:	02000001 	andeq	r0, r0, #1
    16d0:	230c7091 	movwcs	r7, #49297	; 0xc091
    16d4:	01000011 	tsteq	r0, r1, lsl r0
    16d8:	01110867 	tsteq	r1, r7, ror #16
    16dc:	91020000 	mrsls	r0, (UNDEF: 2)
    16e0:	8c900d6c 	ldchi	13, cr0, [r0], {108}	; 0x6c
    16e4:	00480000 	subeq	r0, r8, r0
    16e8:	690e0000 	stmdbvs	lr, {}	; <UNPREDICTABLE>
    16ec:	0b690100 	bleq	1a41af4 <__bss_end+0x1a38b08>
    16f0:	00000104 	andeq	r0, r0, r4, lsl #2
    16f4:	00749102 	rsbseq	r9, r4, r2, lsl #2
    16f8:	01040f00 	tsteq	r4, r0, lsl #30
    16fc:	10000001 	andne	r0, r0, r1
    1700:	04120411 	ldreq	r0, [r2], #-1041	; 0xfffffbef
    1704:	746e6905 	strbtvc	r6, [lr], #-2309	; 0xfffff6fb
    1708:	74040f00 	strvc	r0, [r4], #-3840	; 0xfffff100
    170c:	0f000000 	svceq	0x00000000
    1710:	00006d04 	andeq	r6, r0, r4, lsl #26
    1714:	10950a00 	addsne	r0, r5, r0, lsl #20
    1718:	5c010000 	stcpl	0, cr0, [r1], {-0}
    171c:	0010a206 	andseq	sl, r0, r6, lsl #4
    1720:	008c0000 	addeq	r0, ip, r0
    1724:	00006800 	andeq	r6, r0, r0, lsl #16
    1728:	769c0100 	ldrvc	r0, [ip], r0, lsl #2
    172c:	13000001 	movwne	r0, #1
    1730:	00001199 	muleq	r0, r9, r1
    1734:	02125c01 	andseq	r5, r2, #256	; 0x100
    1738:	02000001 	andeq	r0, r0, #1
    173c:	9b136c91 	blls	4dc988 <__bss_end+0x4d399c>
    1740:	01000010 	tsteq	r0, r0, lsl r0
    1744:	01041e5c 	tsteq	r4, ip, asr lr
    1748:	91020000 	mrsls	r0, (UNDEF: 2)
    174c:	656d0e68 	strbvs	r0, [sp, #-3688]!	; 0xfffff198
    1750:	5e01006d 	cdppl	0, 0, cr0, cr1, cr13, {3}
    1754:	00011108 	andeq	r1, r1, r8, lsl #2
    1758:	70910200 	addsvc	r0, r1, r0, lsl #4
    175c:	008c1c0d 	addeq	r1, ip, sp, lsl #24
    1760:	00003c00 	andeq	r3, r0, r0, lsl #24
    1764:	00690e00 	rsbeq	r0, r9, r0, lsl #28
    1768:	040b6001 	streq	r6, [fp], #-1
    176c:	02000001 	andeq	r0, r0, #1
    1770:	00007491 	muleq	r0, r1, r4
    1774:	00114d14 	andseq	r4, r1, r4, lsl sp
    1778:	05520100 	ldrbeq	r0, [r2, #-256]	; 0xffffff00
    177c:	00001166 	andeq	r1, r0, r6, ror #2
    1780:	00000104 	andeq	r0, r0, r4, lsl #2
    1784:	00008bac 	andeq	r8, r0, ip, lsr #23
    1788:	00000054 	andeq	r0, r0, r4, asr r0
    178c:	01af9c01 			; <UNDEFINED> instruction: 0x01af9c01
    1790:	730b0000 	movwvc	r0, #45056	; 0xb000
    1794:	18520100 	ldmdane	r2, {r8}^
    1798:	0000010b 	andeq	r0, r0, fp, lsl #2
    179c:	0e6c9102 	lgneqe	f1, f2
    17a0:	54010069 	strpl	r0, [r1], #-105	; 0xffffff97
    17a4:	00010406 	andeq	r0, r1, r6, lsl #8
    17a8:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    17ac:	11891400 	orrne	r1, r9, r0, lsl #8
    17b0:	42010000 	andmi	r0, r1, #0
    17b4:	00115405 	andseq	r5, r1, r5, lsl #8
    17b8:	00010400 	andeq	r0, r1, r0, lsl #8
    17bc:	008b0000 	addeq	r0, fp, r0
    17c0:	0000ac00 	andeq	sl, r0, r0, lsl #24
    17c4:	159c0100 	ldrne	r0, [ip, #256]	; 0x100
    17c8:	0b000002 	bleq	17d8 <shift+0x17d8>
    17cc:	01003173 	tsteq	r0, r3, ror r1
    17d0:	010b1942 	tsteq	fp, r2, asr #18
    17d4:	91020000 	mrsls	r0, (UNDEF: 2)
    17d8:	32730b6c 	rsbscc	r0, r3, #108, 22	; 0x1b000
    17dc:	29420100 	stmdbcs	r2, {r8}^
    17e0:	0000010b 	andeq	r0, r0, fp, lsl #2
    17e4:	0b689102 	bleq	1a25bf4 <__bss_end+0x1a1cc08>
    17e8:	006d756e 	rsbeq	r7, sp, lr, ror #10
    17ec:	04314201 	ldrteq	r4, [r1], #-513	; 0xfffffdff
    17f0:	02000001 	andeq	r0, r0, #1
    17f4:	750e6491 	strvc	r6, [lr, #-1169]	; 0xfffffb6f
    17f8:	44010031 	strmi	r0, [r1], #-49	; 0xffffffcf
    17fc:	00021510 	andeq	r1, r2, r0, lsl r5
    1800:	77910200 	ldrvc	r0, [r1, r0, lsl #4]
    1804:	0032750e 	eorseq	r7, r2, lr, lsl #10
    1808:	15144401 	ldrne	r4, [r4, #-1025]	; 0xfffffbff
    180c:	02000002 	andeq	r0, r0, #2
    1810:	08007691 	stmdaeq	r0, {r0, r4, r7, r9, sl, ip, sp, lr}
    1814:	09840801 	stmibeq	r4, {r0, fp}
    1818:	91140000 	tstls	r4, r0
    181c:	01000011 	tsteq	r0, r1, lsl r0
    1820:	11780736 	cmnne	r8, r6, lsr r7
    1824:	01110000 	tsteq	r1, r0
    1828:	8a400000 	bhi	1001830 <__bss_end+0xff8844>
    182c:	00c00000 	sbceq	r0, r0, r0
    1830:	9c010000 	stcls	0, cr0, [r1], {-0}
    1834:	00000275 	andeq	r0, r0, r5, ror r2
    1838:	00109013 	andseq	r9, r0, r3, lsl r0
    183c:	15360100 	ldrne	r0, [r6, #-256]!	; 0xffffff00
    1840:	00000111 	andeq	r0, r0, r1, lsl r1
    1844:	0b6c9102 	bleq	1b25c54 <__bss_end+0x1b1cc68>
    1848:	00637273 	rsbeq	r7, r3, r3, ror r2
    184c:	0b273601 	bleq	9cf058 <__bss_end+0x9c606c>
    1850:	02000001 	andeq	r0, r0, #1
    1854:	6e0b6891 	mcrvs	8, 0, r6, cr11, cr1, {4}
    1858:	01006d75 	tsteq	r0, r5, ror sp
    185c:	01043036 	tsteq	r4, r6, lsr r0
    1860:	91020000 	mrsls	r0, (UNDEF: 2)
    1864:	00690e64 	rsbeq	r0, r9, r4, ror #28
    1868:	04063801 	streq	r3, [r6], #-2049	; 0xfffff7ff
    186c:	02000001 	andeq	r0, r0, #1
    1870:	14007491 	strne	r7, [r0], #-1169	; 0xfffffb6f
    1874:	00001173 	andeq	r1, r0, r3, ror r1
    1878:	0c052401 	cfstrseq	mvf2, [r5], {1}
    187c:	04000011 	streq	r0, [r0], #-17	; 0xffffffef
    1880:	a4000001 	strge	r0, [r0], #-1
    1884:	9c000089 	stcls	0, cr0, [r0], {137}	; 0x89
    1888:	01000000 	mrseq	r0, (UNDEF: 0)
    188c:	0002b29c 	muleq	r2, ip, r2
    1890:	108a1300 	addne	r1, sl, r0, lsl #6
    1894:	24010000 	strcs	r0, [r1], #-0
    1898:	00010b16 	andeq	r0, r1, r6, lsl fp
    189c:	6c910200 	lfmvs	f0, 4, [r1], {0}
    18a0:	00112a0c 	andseq	r2, r1, ip, lsl #20
    18a4:	06260100 	strteq	r0, [r6], -r0, lsl #2
    18a8:	00000104 	andeq	r0, r0, r4, lsl #2
    18ac:	00749102 	rsbseq	r9, r4, r2, lsl #2
    18b0:	0011a715 	andseq	sl, r1, r5, lsl r7
    18b4:	06080100 	streq	r0, [r8], -r0, lsl #2
    18b8:	000011ac 	andeq	r1, r0, ip, lsr #3
    18bc:	00008830 	andeq	r8, r0, r0, lsr r8
    18c0:	00000174 	andeq	r0, r0, r4, ror r1
    18c4:	8a139c01 	bhi	4e88d0 <__bss_end+0x4df8e4>
    18c8:	01000010 	tsteq	r0, r0, lsl r0
    18cc:	00661808 	rsbeq	r1, r6, r8, lsl #16
    18d0:	91020000 	mrsls	r0, (UNDEF: 2)
    18d4:	112a1364 			; <UNDEFINED> instruction: 0x112a1364
    18d8:	08010000 	stmdaeq	r1, {}	; <UNPREDICTABLE>
    18dc:	00011125 	andeq	r1, r1, r5, lsr #2
    18e0:	60910200 	addsvs	r0, r1, r0, lsl #4
    18e4:	00114113 	andseq	r4, r1, r3, lsl r1
    18e8:	3a080100 	bcc	201cf0 <__bss_end+0x1f8d04>
    18ec:	00000066 	andeq	r0, r0, r6, rrx
    18f0:	0e5c9102 	logeqe	f1, f2
    18f4:	0a010069 	beq	41aa0 <__bss_end+0x38ab4>
    18f8:	00010406 	andeq	r0, r1, r6, lsl #8
    18fc:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    1900:	0088fc0d 	addeq	pc, r8, sp, lsl #24
    1904:	00009800 	andeq	r9, r0, r0, lsl #16
    1908:	006a0e00 	rsbeq	r0, sl, r0, lsl #28
    190c:	040b1c01 	streq	r1, [fp], #-3073	; 0xfffff3ff
    1910:	02000001 	andeq	r0, r0, #1
    1914:	240d7091 	strcs	r7, [sp], #-145	; 0xffffff6f
    1918:	60000089 	andvs	r0, r0, r9, lsl #1
    191c:	0e000000 	cdpeq	0, 0, cr0, cr0, cr0, {0}
    1920:	1e010063 	cdpne	0, 0, cr0, cr1, cr3, {3}
    1924:	00006d08 	andeq	r6, r0, r8, lsl #26
    1928:	6f910200 	svcvs	0x00910200
    192c:	00000000 	andeq	r0, r0, r0

Disassembly of section .debug_abbrev:

00000000 <.debug_abbrev>:
   0:	10001101 	andne	r1, r0, r1, lsl #2
   4:	12011106 	andne	r1, r1, #-2147483647	; 0x80000001
   8:	1b0e0301 	blne	380c14 <__bss_end+0x377c28>
   c:	130e250e 	movwne	r2, #58638	; 0xe50e
  10:	00000005 	andeq	r0, r0, r5
  14:	25011101 	strcs	r1, [r1, #-257]	; 0xfffffeff
  18:	030b130e 	movweq	r1, #45838	; 0xb30e
  1c:	110e1b0e 	tstne	lr, lr, lsl #22
  20:	10061201 	andne	r1, r6, r1, lsl #4
  24:	02000017 	andeq	r0, r0, #23
  28:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
  2c:	0b3b0b3a 	bleq	ec2d1c <__bss_end+0xeb9d30>
  30:	13490b39 	movtne	r0, #39737	; 0x9b39
  34:	193c193f 	ldmdbne	ip!, {r0, r1, r2, r3, r4, r5, r8, fp, ip}
  38:	24030000 	strcs	r0, [r3], #-0
  3c:	3e0b0b00 	vmlacc.f64	d0, d11, d0
  40:	000e030b 	andeq	r0, lr, fp, lsl #6
  44:	012e0400 			; <UNDEFINED> instruction: 0x012e0400
  48:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
  4c:	0b3b0b3a 	bleq	ec2d3c <__bss_end+0xeb9d50>
  50:	01110b39 	tsteq	r1, r9, lsr fp
  54:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
  58:	01194296 			; <UNDEFINED> instruction: 0x01194296
  5c:	05000013 	streq	r0, [r0, #-19]	; 0xffffffed
  60:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
  64:	0b3b0b3a 	bleq	ec2d54 <__bss_end+0xeb9d68>
  68:	13490b39 	movtne	r0, #39737	; 0x9b39
  6c:	00001802 	andeq	r1, r0, r2, lsl #16
  70:	0b002406 	bleq	9090 <__bss_end+0xa4>
  74:	030b3e0b 	movweq	r3, #48651	; 0xbe0b
  78:	07000008 	streq	r0, [r0, -r8]
  7c:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
  80:	0b3a0e03 	bleq	e83894 <__bss_end+0xe7a8a8>
  84:	0b390b3b 	bleq	e42d78 <__bss_end+0xe39d8c>
  88:	06120111 			; <UNDEFINED> instruction: 0x06120111
  8c:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
  90:	00130119 	andseq	r0, r3, r9, lsl r1
  94:	010b0800 	tsteq	fp, r0, lsl #16
  98:	06120111 			; <UNDEFINED> instruction: 0x06120111
  9c:	34090000 	strcc	r0, [r9], #-0
  a0:	3a080300 	bcc	200ca8 <__bss_end+0x1f7cbc>
  a4:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
  a8:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
  ac:	0a000018 	beq	114 <shift+0x114>
  b0:	0b0b000f 	bleq	2c00f4 <__bss_end+0x2b7108>
  b4:	00001349 	andeq	r1, r0, r9, asr #6
  b8:	01110100 	tsteq	r1, r0, lsl #2
  bc:	0b130e25 	bleq	4c3958 <__bss_end+0x4ba96c>
  c0:	0e1b0e03 	cdpeq	14, 1, cr0, cr11, cr3, {0}
  c4:	06120111 			; <UNDEFINED> instruction: 0x06120111
  c8:	00001710 	andeq	r1, r0, r0, lsl r7
  cc:	03001602 	movweq	r1, #1538	; 0x602
  d0:	3b0b3a0e 	blcc	2ce910 <__bss_end+0x2c5924>
  d4:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
  d8:	03000013 	movweq	r0, #19
  dc:	0b0b000f 	bleq	2c0120 <__bss_end+0x2b7134>
  e0:	00001349 	andeq	r1, r0, r9, asr #6
  e4:	00001504 	andeq	r1, r0, r4, lsl #10
  e8:	01010500 	tsteq	r1, r0, lsl #10
  ec:	13011349 	movwne	r1, #4937	; 0x1349
  f0:	21060000 	mrscs	r0, (UNDEF: 6)
  f4:	2f134900 	svccs	0x00134900
  f8:	07000006 	streq	r0, [r0, -r6]
  fc:	0b0b0024 	bleq	2c0194 <__bss_end+0x2b71a8>
 100:	0e030b3e 	vmoveq.16	d3[0], r0
 104:	34080000 	strcc	r0, [r8], #-0
 108:	3a0e0300 	bcc	380d10 <__bss_end+0x377d24>
 10c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 110:	3f13490b 	svccc	0x0013490b
 114:	00193c19 	andseq	r3, r9, r9, lsl ip
 118:	012e0900 			; <UNDEFINED> instruction: 0x012e0900
 11c:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 120:	0b3b0b3a 	bleq	ec2e10 <__bss_end+0xeb9e24>
 124:	13490b39 	movtne	r0, #39737	; 0x9b39
 128:	06120111 			; <UNDEFINED> instruction: 0x06120111
 12c:	42961840 	addsmi	r1, r6, #64, 16	; 0x400000
 130:	00130119 	andseq	r0, r3, r9, lsl r1
 134:	00340a00 	eorseq	r0, r4, r0, lsl #20
 138:	0b3a0e03 	bleq	e8394c <__bss_end+0xe7a960>
 13c:	0b390b3b 	bleq	e42e30 <__bss_end+0xe39e44>
 140:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 144:	240b0000 	strcs	r0, [fp], #-0
 148:	3e0b0b00 	vmlacc.f64	d0, d11, d0
 14c:	0008030b 	andeq	r0, r8, fp, lsl #6
 150:	002e0c00 	eoreq	r0, lr, r0, lsl #24
 154:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 158:	0b3b0b3a 	bleq	ec2e48 <__bss_end+0xeb9e5c>
 15c:	01110b39 	tsteq	r1, r9, lsr fp
 160:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 164:	00194297 	mulseq	r9, r7, r2
 168:	01390d00 	teqeq	r9, r0, lsl #26
 16c:	0b3a0e03 	bleq	e83980 <__bss_end+0xe7a994>
 170:	13010b3b 	movwne	r0, #6971	; 0x1b3b
 174:	2e0e0000 	cdpcs	0, 0, cr0, cr14, cr0, {0}
 178:	03193f01 	tsteq	r9, #1, 30
 17c:	3b0b3a0e 	blcc	2ce9bc <__bss_end+0x2c59d0>
 180:	3c0b390b 			; <UNDEFINED> instruction: 0x3c0b390b
 184:	00130119 	andseq	r0, r3, r9, lsl r1
 188:	00050f00 	andeq	r0, r5, r0, lsl #30
 18c:	00001349 	andeq	r1, r0, r9, asr #6
 190:	3f012e10 	svccc	0x00012e10
 194:	3a0e0319 	bcc	380e00 <__bss_end+0x377e14>
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
 1c0:	3a080300 	bcc	200dc8 <__bss_end+0x1f7ddc>
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
 1f4:	0b0b0024 	bleq	2c028c <__bss_end+0x2b72a0>
 1f8:	0e030b3e 	vmoveq.16	d3[0], r0
 1fc:	24030000 	strcs	r0, [r3], #-0
 200:	3e0b0b00 	vmlacc.f64	d0, d11, d0
 204:	0008030b 	andeq	r0, r8, fp, lsl #6
 208:	00160400 	andseq	r0, r6, r0, lsl #8
 20c:	0b3a0e03 	bleq	e83a20 <__bss_end+0xe7aa34>
 210:	0b390b3b 	bleq	e42f04 <__bss_end+0xe39f18>
 214:	00001349 	andeq	r1, r0, r9, asr #6
 218:	49002605 	stmdbmi	r0, {r0, r2, r9, sl, sp}
 21c:	06000013 			; <UNDEFINED> instruction: 0x06000013
 220:	0e030113 	mcreq	1, 0, r0, cr3, cr3, {0}
 224:	0b3a0b0b 	bleq	e82e58 <__bss_end+0xe79e6c>
 228:	0b390b3b 	bleq	e42f1c <__bss_end+0xe39f30>
 22c:	00001301 	andeq	r1, r0, r1, lsl #6
 230:	03000d07 	movweq	r0, #3335	; 0xd07
 234:	3b0b3a08 	blcc	2cea5c <__bss_end+0x2c5a70>
 238:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 23c:	000b3813 	andeq	r3, fp, r3, lsl r8
 240:	01040800 	tsteq	r4, r0, lsl #16
 244:	196d0e03 	stmdbne	sp!, {r0, r1, r9, sl, fp}^
 248:	0b0b0b3e 	bleq	2c2f48 <__bss_end+0x2b9f5c>
 24c:	0b3a1349 	bleq	e84f78 <__bss_end+0xe7bf8c>
 250:	0b390b3b 	bleq	e42f44 <__bss_end+0xe39f58>
 254:	00001301 	andeq	r1, r0, r1, lsl #6
 258:	03002809 	movweq	r2, #2057	; 0x809
 25c:	000b1c0e 	andeq	r1, fp, lr, lsl #24
 260:	00340a00 	eorseq	r0, r4, r0, lsl #20
 264:	0b3a0e03 	bleq	e83a78 <__bss_end+0xe7aa8c>
 268:	0b390b3b 	bleq	e42f5c <__bss_end+0xe39f70>
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
 294:	0b3b0b3a 	bleq	ec2f84 <__bss_end+0xeb9f98>
 298:	13490b39 	movtne	r0, #39737	; 0x9b39
 29c:	00000b38 	andeq	r0, r0, r8, lsr fp
 2a0:	4901010f 	stmdbmi	r1, {r0, r1, r2, r3, r8}
 2a4:	00130113 	andseq	r0, r3, r3, lsl r1
 2a8:	00211000 	eoreq	r1, r1, r0
 2ac:	0b2f1349 	bleq	bc4fd8 <__bss_end+0xbbbfec>
 2b0:	02110000 	andseq	r0, r1, #0
 2b4:	0b0e0301 	bleq	380ec0 <__bss_end+0x377ed4>
 2b8:	3b0b3a0b 	blcc	2ceaec <__bss_end+0x2c5b00>
 2bc:	010b390b 	tsteq	fp, fp, lsl #18
 2c0:	12000013 	andne	r0, r0, #19
 2c4:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 2c8:	0b3a0e03 	bleq	e83adc <__bss_end+0xe7aaf0>
 2cc:	0b390b3b 	bleq	e42fc0 <__bss_end+0xe39fd4>
 2d0:	193c0e6e 	ldmdbne	ip!, {r1, r2, r3, r5, r6, r9, sl, fp}
 2d4:	13011364 	movwne	r1, #4964	; 0x1364
 2d8:	05130000 	ldreq	r0, [r3, #-0]
 2dc:	34134900 	ldrcc	r4, [r3], #-2304	; 0xfffff700
 2e0:	14000019 	strne	r0, [r0], #-25	; 0xffffffe7
 2e4:	13490005 	movtne	r0, #36869	; 0x9005
 2e8:	2e150000 	cdpcs	0, 1, cr0, cr5, cr0, {0}
 2ec:	03193f01 	tsteq	r9, #1, 30
 2f0:	3b0b3a0e 	blcc	2ceb30 <__bss_end+0x2c5b44>
 2f4:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 2f8:	3c13490e 			; <UNDEFINED> instruction: 0x3c13490e
 2fc:	01136419 	tsteq	r3, r9, lsl r4
 300:	16000013 			; <UNDEFINED> instruction: 0x16000013
 304:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 308:	0b3a0e03 	bleq	e83b1c <__bss_end+0xe7ab30>
 30c:	0b390b3b 	bleq	e43000 <__bss_end+0xe3a014>
 310:	13490e6e 	movtne	r0, #40558	; 0x9e6e
 314:	193c0b32 	ldmdbne	ip!, {r1, r4, r5, r8, r9, fp}
 318:	13011364 	movwne	r1, #4964	; 0x1364
 31c:	0d170000 	ldceq	0, cr0, [r7, #-0]
 320:	3a0e0300 	bcc	380f28 <__bss_end+0x377f3c>
 324:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 328:	3813490b 	ldmdacc	r3, {r0, r1, r3, r8, fp, lr}
 32c:	000b320b 	andeq	r3, fp, fp, lsl #4
 330:	012e1800 			; <UNDEFINED> instruction: 0x012e1800
 334:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 338:	0b3b0b3a 	bleq	ec3028 <__bss_end+0xeba03c>
 33c:	0e6e0b39 	vmoveq.8	d14[5], r0
 340:	193c0b32 	ldmdbne	ip!, {r1, r4, r5, r8, r9, fp}
 344:	13011364 	movwne	r1, #4964	; 0x1364
 348:	2e190000 	cdpcs	0, 1, cr0, cr9, cr0, {0}
 34c:	03193f01 	tsteq	r9, #1, 30
 350:	3b0b3a0e 	blcc	2ceb90 <__bss_end+0x2c5ba4>
 354:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 358:	3213490e 	andscc	r4, r3, #229376	; 0x38000
 35c:	64193c0b 	ldrvs	r3, [r9], #-3083	; 0xfffff3f5
 360:	1a000013 	bne	3b4 <shift+0x3b4>
 364:	13490115 	movtne	r0, #37141	; 0x9115
 368:	13011364 	movwne	r1, #4964	; 0x1364
 36c:	1f1b0000 	svcne	0x001b0000
 370:	49131d00 	ldmdbmi	r3, {r8, sl, fp, ip}
 374:	1c000013 	stcne	0, cr0, [r0], {19}
 378:	0b0b0010 	bleq	2c03c0 <__bss_end+0x2b73d4>
 37c:	00001349 	andeq	r1, r0, r9, asr #6
 380:	0b000f1d 	bleq	3ffc <shift+0x3ffc>
 384:	1e00000b 	cdpne	0, 0, cr0, cr0, cr11, {0}
 388:	08030139 	stmdaeq	r3, {r0, r3, r4, r5, r8}
 38c:	0b3b0b3a 	bleq	ec307c <__bss_end+0xeba090>
 390:	13010b39 	movwne	r0, #6969	; 0x1b39
 394:	341f0000 	ldrcc	r0, [pc], #-0	; 39c <shift+0x39c>
 398:	3a0e0300 	bcc	380fa0 <__bss_end+0x377fb4>
 39c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 3a0:	3c13490b 			; <UNDEFINED> instruction: 0x3c13490b
 3a4:	6c061c19 	stcvs	12, cr1, [r6], {25}
 3a8:	20000019 	andcs	r0, r0, r9, lsl r0
 3ac:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 3b0:	0b3b0b3a 	bleq	ec30a0 <__bss_end+0xeba0b4>
 3b4:	13490b39 	movtne	r0, #39737	; 0x9b39
 3b8:	0b1c193c 	bleq	7068b0 <__bss_end+0x6fd8c4>
 3bc:	0000196c 	andeq	r1, r0, ip, ror #18
 3c0:	47003421 	strmi	r3, [r0, -r1, lsr #8]
 3c4:	22000013 	andcs	r0, r0, #19
 3c8:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 3cc:	0b3b0b3a 	bleq	ec30bc <__bss_end+0xeba0d0>
 3d0:	13490b39 	movtne	r0, #39737	; 0x9b39
 3d4:	1802193f 	stmdane	r2, {r0, r1, r2, r3, r4, r5, r8, fp, ip}
 3d8:	2e230000 	cdpcs	0, 2, cr0, cr3, cr0, {0}
 3dc:	03193f01 	tsteq	r9, #1, 30
 3e0:	3b0b3a0e 	blcc	2cec20 <__bss_end+0x2c5c34>
 3e4:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 3e8:	12011113 	andne	r1, r1, #-1073741820	; 0xc0000004
 3ec:	96184006 	ldrls	r4, [r8], -r6
 3f0:	13011942 	movwne	r1, #6466	; 0x1942
 3f4:	05240000 	streq	r0, [r4, #-0]!
 3f8:	3a0e0300 	bcc	381000 <__bss_end+0x378014>
 3fc:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 400:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 404:	25000018 	strcs	r0, [r0, #-24]	; 0xffffffe8
 408:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 40c:	0b3a0e03 	bleq	e83c20 <__bss_end+0xe7ac34>
 410:	0b390b3b 	bleq	e43104 <__bss_end+0xe3a118>
 414:	01110e6e 	tsteq	r1, lr, ror #28
 418:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 41c:	00194296 	mulseq	r9, r6, r2
 420:	11010000 	mrsne	r0, (UNDEF: 1)
 424:	130e2501 	movwne	r2, #58625	; 0xe501
 428:	1b0e030b 	blne	38105c <__bss_end+0x378070>
 42c:	1201110e 	andne	r1, r1, #-2147483645	; 0x80000003
 430:	00171006 	andseq	r1, r7, r6
 434:	00240200 	eoreq	r0, r4, r0, lsl #4
 438:	0b3e0b0b 	bleq	f8306c <__bss_end+0xf7a080>
 43c:	00000e03 	andeq	r0, r0, r3, lsl #28
 440:	49002603 	stmdbmi	r0, {r0, r1, r9, sl, sp}
 444:	04000013 	streq	r0, [r0], #-19	; 0xffffffed
 448:	0b0b0024 	bleq	2c04e0 <__bss_end+0x2b74f4>
 44c:	08030b3e 	stmdaeq	r3, {r1, r2, r3, r4, r5, r8, r9, fp}
 450:	16050000 	strne	r0, [r5], -r0
 454:	3a0e0300 	bcc	38105c <__bss_end+0x378070>
 458:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 45c:	0013490b 	andseq	r4, r3, fp, lsl #18
 460:	01130600 	tsteq	r3, r0, lsl #12
 464:	0b0b0e03 	bleq	2c3c78 <__bss_end+0x2bac8c>
 468:	0b3b0b3a 	bleq	ec3158 <__bss_end+0xeba16c>
 46c:	13010b39 	movwne	r0, #6969	; 0x1b39
 470:	0d070000 	stceq	0, cr0, [r7, #-0]
 474:	3a080300 	bcc	20107c <__bss_end+0x1f8090>
 478:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 47c:	3813490b 	ldmdacc	r3, {r0, r1, r3, r8, fp, lr}
 480:	0800000b 	stmdaeq	r0, {r0, r1, r3}
 484:	0e030104 	adfeqs	f0, f3, f4
 488:	0b3e196d 	bleq	f86a44 <__bss_end+0xf7da58>
 48c:	13490b0b 	movtne	r0, #39691	; 0x9b0b
 490:	0b3b0b3a 	bleq	ec3180 <__bss_end+0xeba194>
 494:	13010b39 	movwne	r0, #6969	; 0x1b39
 498:	28090000 	stmdacs	r9, {}	; <UNPREDICTABLE>
 49c:	1c080300 	stcne	3, cr0, [r8], {-0}
 4a0:	0a00000b 	beq	4d4 <shift+0x4d4>
 4a4:	0e030028 	cdpeq	0, 0, cr0, cr3, cr8, {1}
 4a8:	00000b1c 	andeq	r0, r0, ip, lsl fp
 4ac:	0300340b 	movweq	r3, #1035	; 0x40b
 4b0:	3b0b3a0e 	blcc	2cecf0 <__bss_end+0x2c5d04>
 4b4:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 4b8:	02196c13 	andseq	r6, r9, #4864	; 0x1300
 4bc:	0c000018 	stceq	0, cr0, [r0], {24}
 4c0:	0e030002 	cdpeq	0, 0, cr0, cr3, cr2, {0}
 4c4:	0000193c 	andeq	r1, r0, ip, lsr r9
 4c8:	0b000f0d 	bleq	4104 <shift+0x4104>
 4cc:	0013490b 	andseq	r4, r3, fp, lsl #18
 4d0:	000d0e00 	andeq	r0, sp, r0, lsl #28
 4d4:	0b3a0e03 	bleq	e83ce8 <__bss_end+0xe7acfc>
 4d8:	0b390b3b 	bleq	e431cc <__bss_end+0xe3a1e0>
 4dc:	0b381349 	bleq	e05208 <__bss_end+0xdfc21c>
 4e0:	010f0000 	mrseq	r0, CPSR
 4e4:	01134901 	tsteq	r3, r1, lsl #18
 4e8:	10000013 	andne	r0, r0, r3, lsl r0
 4ec:	13490021 	movtne	r0, #36897	; 0x9021
 4f0:	00000b2f 	andeq	r0, r0, pc, lsr #22
 4f4:	03010211 	movweq	r0, #4625	; 0x1211
 4f8:	3a0b0b0e 	bcc	2c3138 <__bss_end+0x2ba14c>
 4fc:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 500:	0013010b 	andseq	r0, r3, fp, lsl #2
 504:	012e1200 			; <UNDEFINED> instruction: 0x012e1200
 508:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 50c:	0b3b0b3a 	bleq	ec31fc <__bss_end+0xeba210>
 510:	0e6e0b39 	vmoveq.8	d14[5], r0
 514:	1364193c 	cmnne	r4, #60, 18	; 0xf0000
 518:	00001301 	andeq	r1, r0, r1, lsl #6
 51c:	49000513 	stmdbmi	r0, {r0, r1, r4, r8, sl}
 520:	00193413 	andseq	r3, r9, r3, lsl r4
 524:	00051400 	andeq	r1, r5, r0, lsl #8
 528:	00001349 	andeq	r1, r0, r9, asr #6
 52c:	3f012e15 	svccc	0x00012e15
 530:	3a0e0319 	bcc	38119c <__bss_end+0x3781b0>
 534:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 538:	490e6e0b 	stmdbmi	lr, {r0, r1, r3, r9, sl, fp, sp, lr}
 53c:	64193c13 	ldrvs	r3, [r9], #-3091	; 0xfffff3ed
 540:	00130113 	andseq	r0, r3, r3, lsl r1
 544:	012e1600 			; <UNDEFINED> instruction: 0x012e1600
 548:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 54c:	0b3b0b3a 	bleq	ec323c <__bss_end+0xeba250>
 550:	0e6e0b39 	vmoveq.8	d14[5], r0
 554:	0b321349 	bleq	c85280 <__bss_end+0xc7c294>
 558:	1364193c 	cmnne	r4, #60, 18	; 0xf0000
 55c:	00001301 	andeq	r1, r0, r1, lsl #6
 560:	03000d17 	movweq	r0, #3351	; 0xd17
 564:	3b0b3a0e 	blcc	2ceda4 <__bss_end+0x2c5db8>
 568:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 56c:	320b3813 	andcc	r3, fp, #1245184	; 0x130000
 570:	1800000b 	stmdane	r0, {r0, r1, r3}
 574:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 578:	0b3a0e03 	bleq	e83d8c <__bss_end+0xe7ada0>
 57c:	0b390b3b 	bleq	e43270 <__bss_end+0xe3a284>
 580:	0b320e6e 	bleq	c83f40 <__bss_end+0xc7af54>
 584:	1364193c 	cmnne	r4, #60, 18	; 0xf0000
 588:	00001301 	andeq	r1, r0, r1, lsl #6
 58c:	3f012e19 	svccc	0x00012e19
 590:	3a0e0319 	bcc	3811fc <__bss_end+0x378210>
 594:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 598:	490e6e0b 	stmdbmi	lr, {r0, r1, r3, r9, sl, fp, sp, lr}
 59c:	3c0b3213 	sfmcc	f3, 4, [fp], {19}
 5a0:	00136419 	andseq	r6, r3, r9, lsl r4
 5a4:	01151a00 	tsteq	r5, r0, lsl #20
 5a8:	13641349 	cmnne	r4, #603979777	; 0x24000001
 5ac:	00001301 	andeq	r1, r0, r1, lsl #6
 5b0:	1d001f1b 	stcne	15, cr1, [r0, #-108]	; 0xffffff94
 5b4:	00134913 	andseq	r4, r3, r3, lsl r9
 5b8:	00101c00 	andseq	r1, r0, r0, lsl #24
 5bc:	13490b0b 	movtne	r0, #39691	; 0x9b0b
 5c0:	0f1d0000 	svceq	0x001d0000
 5c4:	000b0b00 	andeq	r0, fp, r0, lsl #22
 5c8:	00341e00 	eorseq	r1, r4, r0, lsl #28
 5cc:	0b3a0e03 	bleq	e83de0 <__bss_end+0xe7adf4>
 5d0:	0b390b3b 	bleq	e432c4 <__bss_end+0xe3a2d8>
 5d4:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 5d8:	2e1f0000 	cdpcs	0, 1, cr0, cr15, cr0, {0}
 5dc:	03193f01 	tsteq	r9, #1, 30
 5e0:	3b0b3a0e 	blcc	2cee20 <__bss_end+0x2c5e34>
 5e4:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 5e8:	1113490e 	tstne	r3, lr, lsl #18
 5ec:	40061201 	andmi	r1, r6, r1, lsl #4
 5f0:	19429618 	stmdbne	r2, {r3, r4, r9, sl, ip, pc}^
 5f4:	00001301 	andeq	r1, r0, r1, lsl #6
 5f8:	03000520 	movweq	r0, #1312	; 0x520
 5fc:	3b0b3a0e 	blcc	2cee3c <__bss_end+0x2c5e50>
 600:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 604:	00180213 	andseq	r0, r8, r3, lsl r2
 608:	012e2100 			; <UNDEFINED> instruction: 0x012e2100
 60c:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 610:	0b3b0b3a 	bleq	ec3300 <__bss_end+0xeba314>
 614:	0e6e0b39 	vmoveq.8	d14[5], r0
 618:	01111349 	tsteq	r1, r9, asr #6
 61c:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 620:	01194297 			; <UNDEFINED> instruction: 0x01194297
 624:	22000013 	andcs	r0, r0, #19
 628:	08030034 	stmdaeq	r3, {r2, r4, r5}
 62c:	0b3b0b3a 	bleq	ec331c <__bss_end+0xeba330>
 630:	13490b39 	movtne	r0, #39737	; 0x9b39
 634:	00001802 	andeq	r1, r0, r2, lsl #16
 638:	3f012e23 	svccc	0x00012e23
 63c:	3a0e0319 	bcc	3812a8 <__bss_end+0x3782bc>
 640:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 644:	110e6e0b 	tstne	lr, fp, lsl #28
 648:	40061201 	andmi	r1, r6, r1, lsl #4
 64c:	19429718 	stmdbne	r2, {r3, r4, r8, r9, sl, ip, pc}^
 650:	00001301 	andeq	r1, r0, r1, lsl #6
 654:	3f002e24 	svccc	0x00002e24
 658:	3a0e0319 	bcc	3812c4 <__bss_end+0x3782d8>
 65c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 660:	110e6e0b 	tstne	lr, fp, lsl #28
 664:	40061201 	andmi	r1, r6, r1, lsl #4
 668:	19429718 	stmdbne	r2, {r3, r4, r8, r9, sl, ip, pc}^
 66c:	2e250000 	cdpcs	0, 2, cr0, cr5, cr0, {0}
 670:	03193f01 	tsteq	r9, #1, 30
 674:	3b0b3a0e 	blcc	2ceeb4 <__bss_end+0x2c5ec8>
 678:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 67c:	1113490e 	tstne	r3, lr, lsl #18
 680:	40061201 	andmi	r1, r6, r1, lsl #4
 684:	19429718 	stmdbne	r2, {r3, r4, r8, r9, sl, ip, pc}^
 688:	01000000 	mrseq	r0, (UNDEF: 0)
 68c:	0e250111 	mcreq	1, 1, r0, cr5, cr1, {0}
 690:	0e030b13 	vmoveq.32	d3[0], r0
 694:	01110e1b 	tsteq	r1, fp, lsl lr
 698:	17100612 			; <UNDEFINED> instruction: 0x17100612
 69c:	39020000 	stmdbcc	r2, {}	; <UNPREDICTABLE>
 6a0:	00130101 	andseq	r0, r3, r1, lsl #2
 6a4:	00340300 	eorseq	r0, r4, r0, lsl #6
 6a8:	0b3a0e03 	bleq	e83ebc <__bss_end+0xe7aed0>
 6ac:	0b390b3b 	bleq	e433a0 <__bss_end+0xe3a3b4>
 6b0:	193c1349 	ldmdbne	ip!, {r0, r3, r6, r8, r9, ip}
 6b4:	00000a1c 	andeq	r0, r0, ip, lsl sl
 6b8:	3a003a04 	bcc	eed0 <__bss_end+0x5ee4>
 6bc:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 6c0:	0013180b 	andseq	r1, r3, fp, lsl #16
 6c4:	01010500 	tsteq	r1, r0, lsl #10
 6c8:	13011349 	movwne	r1, #4937	; 0x1349
 6cc:	21060000 	mrscs	r0, (UNDEF: 6)
 6d0:	2f134900 	svccs	0x00134900
 6d4:	0700000b 	streq	r0, [r0, -fp]
 6d8:	13490026 	movtne	r0, #36902	; 0x9026
 6dc:	24080000 	strcs	r0, [r8], #-0
 6e0:	3e0b0b00 	vmlacc.f64	d0, d11, d0
 6e4:	000e030b 	andeq	r0, lr, fp, lsl #6
 6e8:	00340900 	eorseq	r0, r4, r0, lsl #18
 6ec:	00001347 	andeq	r1, r0, r7, asr #6
 6f0:	3f012e0a 	svccc	0x00012e0a
 6f4:	3a0e0319 	bcc	381360 <__bss_end+0x378374>
 6f8:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 6fc:	110e6e0b 	tstne	lr, fp, lsl #28
 700:	40061201 	andmi	r1, r6, r1, lsl #4
 704:	19429718 	stmdbne	r2, {r3, r4, r8, r9, sl, ip, pc}^
 708:	00001301 	andeq	r1, r0, r1, lsl #6
 70c:	0300050b 	movweq	r0, #1291	; 0x50b
 710:	3b0b3a08 	blcc	2cef38 <__bss_end+0x2c5f4c>
 714:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 718:	00180213 	andseq	r0, r8, r3, lsl r2
 71c:	00340c00 	eorseq	r0, r4, r0, lsl #24
 720:	0b3a0e03 	bleq	e83f34 <__bss_end+0xe7af48>
 724:	0b390b3b 	bleq	e43418 <__bss_end+0xe3a42c>
 728:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 72c:	0b0d0000 	bleq	340734 <__bss_end+0x337748>
 730:	12011101 	andne	r1, r1, #1073741824	; 0x40000000
 734:	0e000006 	cdpeq	0, 0, cr0, cr0, cr6, {0}
 738:	08030034 	stmdaeq	r3, {r2, r4, r5}
 73c:	0b3b0b3a 	bleq	ec342c <__bss_end+0xeba440>
 740:	13490b39 	movtne	r0, #39737	; 0x9b39
 744:	00001802 	andeq	r1, r0, r2, lsl #16
 748:	0b000f0f 	bleq	438c <shift+0x438c>
 74c:	0013490b 	andseq	r4, r3, fp, lsl #18
 750:	00261000 	eoreq	r1, r6, r0
 754:	0f110000 	svceq	0x00110000
 758:	000b0b00 	andeq	r0, fp, r0, lsl #22
 75c:	00241200 	eoreq	r1, r4, r0, lsl #4
 760:	0b3e0b0b 	bleq	f83394 <__bss_end+0xf7a3a8>
 764:	00000803 	andeq	r0, r0, r3, lsl #16
 768:	03000513 	movweq	r0, #1299	; 0x513
 76c:	3b0b3a0e 	blcc	2cefac <__bss_end+0x2c5fc0>
 770:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 774:	00180213 	andseq	r0, r8, r3, lsl r2
 778:	012e1400 			; <UNDEFINED> instruction: 0x012e1400
 77c:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 780:	0b3b0b3a 	bleq	ec3470 <__bss_end+0xeba484>
 784:	0e6e0b39 	vmoveq.8	d14[5], r0
 788:	01111349 	tsteq	r1, r9, asr #6
 78c:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 790:	01194297 			; <UNDEFINED> instruction: 0x01194297
 794:	15000013 	strne	r0, [r0, #-19]	; 0xffffffed
 798:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 79c:	0b3a0e03 	bleq	e83fb0 <__bss_end+0xe7afc4>
 7a0:	0b390b3b 	bleq	e43494 <__bss_end+0xe3a4a8>
 7a4:	01110e6e 	tsteq	r1, lr, ror #28
 7a8:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 7ac:	00194296 	mulseq	r9, r6, r2
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
  74:	000001a8 	andeq	r0, r0, r8, lsr #3
	...
  80:	0000001c 	andeq	r0, r0, ip, lsl r0
  84:	0adb0002 	beq	ff6c0094 <__bss_end+0xff6b70a8>
  88:	00040000 	andeq	r0, r4, r0
  8c:	00000000 	andeq	r0, r0, r0
  90:	000083d4 	ldrdeq	r8, [r0], -r4
  94:	0000045c 	andeq	r0, r0, ip, asr r4
	...
  a0:	0000001c 	andeq	r0, r0, ip, lsl r0
  a4:	15fe0002 	ldrbne	r0, [lr, #2]!
  a8:	00040000 	andeq	r0, r4, r0
  ac:	00000000 	andeq	r0, r0, r0
  b0:	00008830 	andeq	r8, r0, r0, lsr r8
  b4:	000004b8 			; <UNDEFINED> instruction: 0x000004b8
	...

Disassembly of section .debug_str:

00000000 <.debug_str>:
       0:	6573552f 	ldrbvs	r5, [r3, #-1327]!	; 0xfffffad1
       4:	772f7372 			; <UNDEFINED> instruction: 0x772f7372
       8:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
       c:	2f696a72 	svccs	0x00696a72
      10:	6b736544 	blvs	1cd9528 <__bss_end+0x1cd053c>
      14:	2f706f74 	svccs	0x00706f74
      18:	2f564146 	svccs	0x00564146
      1c:	6176614e 	cmnvs	r6, lr, asr #2
      20:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
      24:	4f2f6963 	svcmi	0x002f6963
      28:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
      2c:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
      30:	6b6c6172 	blvs	1b18600 <__bss_end+0x1b0f614>
      34:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
      38:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
      3c:	756f732f 	strbvc	r7, [pc, #-815]!	; fffffd15 <__bss_end+0xffff6d29>
      40:	73656372 	cmnvc	r5, #-939524095	; 0xc8000001
      44:	6573752f 	ldrbvs	r7, [r3, #-1327]!	; 0xfffffad1
      48:	61707372 	cmnvs	r0, r2, ror r3
      4c:	632f6563 			; <UNDEFINED> instruction: 0x632f6563
      50:	2e307472 	mrccs	4, 1, r7, cr0, cr2, {3}
      54:	552f0073 	strpl	r0, [pc, #-115]!	; ffffffe9 <__bss_end+0xffff6ffd>
      58:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
      5c:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
      60:	6a726574 	bvs	1c99638 <__bss_end+0x1c9064c>
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
      98:	752f7365 	strvc	r7, [pc, #-869]!	; fffffd3b <__bss_end+0xffff6d4f>
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
     12c:	6a363731 	bvs	d8ddf8 <__bss_end+0xd84e0c>
     130:	732d667a 			; <UNDEFINED> instruction: 0x732d667a
     134:	616d2d20 	cmnvs	sp, r0, lsr #26
     138:	2d206d72 	stccs	13, cr6, [r0, #-456]!	; 0xfffffe38
     13c:	6372616d 	cmnvs	r2, #1073741851	; 0x4000001b
     140:	72613d68 	rsbvc	r3, r1, #104, 26	; 0x1a00
     144:	7a36766d 	bvc	d9db00 <__bss_end+0xd94b14>
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
     184:	6a757a61 	bvs	1d5eb10 <__bss_end+0x1d55b24>
     188:	2f696369 	svccs	0x00696369
     18c:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
     190:	73656d65 	cmnvc	r5, #6464	; 0x1940
     194:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
     198:	6b2d616b 	blvs	b5874c <__bss_end+0xb4f760>
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
     1e4:	2b2b4320 	blcs	ad0e6c <__bss_end+0xac7e80>
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
     260:	2b6b7a36 	blcs	1adeb40 <__bss_end+0x1ad5b54>
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
     294:	755f6962 	ldrbvc	r6, [pc, #-2402]	; fffff93a <__bss_end+0xffff694e>
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
     324:	6b736544 	blvs	1cd983c <__bss_end+0x1cd0850>
     328:	2f706f74 	svccs	0x00706f74
     32c:	2f564146 	svccs	0x00564146
     330:	6176614e 	cmnvs	r6, lr, asr #2
     334:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
     338:	4f2f6963 	svcmi	0x002f6963
     33c:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
     340:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
     344:	6b6c6172 	blvs	1b18914 <__bss_end+0x1b0f928>
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
     41c:	6b636f6c 	blvs	18dc1d4 <__bss_end+0x18d31e8>
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
     480:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     484:	50433631 	subpl	r3, r3, r1, lsr r6
     488:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     48c:	4d5f7373 	ldclmi	3, cr7, [pc, #-460]	; 2c8 <shift+0x2c8>
     490:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
     494:	38317265 	ldmdacc	r1!, {r0, r2, r5, r6, r9, ip, sp, lr}
     498:	646e6148 	strbtvs	r6, [lr], #-328	; 0xfffffeb8
     49c:	505f656c 	subspl	r6, pc, ip, ror #10
     4a0:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     4a4:	535f7373 	cmppl	pc, #-872415231	; 0xcc000001
     4a8:	32454957 	subcc	r4, r5, #1425408	; 0x15c000
     4ac:	57534e30 	smmlarpl	r3, r0, lr, r4
     4b0:	72505f49 	subsvc	r5, r0, #292	; 0x124
     4b4:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     4b8:	65535f73 	ldrbvs	r5, [r3, #-3955]	; 0xfffff08d
     4bc:	63697672 	cmnvs	r9, #119537664	; 0x7200000
     4c0:	6a6a6a65 	bvs	1a9ae5c <__bss_end+0x1a91e70>
     4c4:	54313152 	ldrtpl	r3, [r1], #-338	; 0xfffffeae
     4c8:	5f495753 	svcpl	0x00495753
     4cc:	75736552 	ldrbvc	r6, [r3, #-1362]!	; 0xfffffaae
     4d0:	4200746c 	andmi	r7, r0, #108, 8	; 0x6c000000
     4d4:	5f324353 	svcpl	0x00324353
     4d8:	65736142 	ldrbvs	r6, [r3, #-322]!	; 0xfffffebe
     4dc:	72506d00 	subsvc	r6, r0, #0, 26
     4e0:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     4e4:	694c5f73 	stmdbvs	ip, {r0, r1, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     4e8:	485f7473 	ldmdami	pc, {r0, r1, r4, r5, r6, sl, ip, sp, lr}^	; <UNPREDICTABLE>
     4ec:	00646165 	rsbeq	r6, r4, r5, ror #2
     4f0:	4b4e5a5f 	blmi	1396e74 <__bss_end+0x138de88>
     4f4:	50433631 	subpl	r3, r3, r1, lsr r6
     4f8:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     4fc:	4d5f7373 	ldclmi	3, cr7, [pc, #-460]	; 338 <shift+0x338>
     500:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
     504:	39317265 	ldmdbcc	r1!, {r0, r2, r5, r6, r9, ip, sp, lr}
     508:	5f746547 	svcpl	0x00746547
     50c:	72727543 	rsbsvc	r7, r2, #281018368	; 0x10c00000
     510:	5f746e65 	svcpl	0x00746e65
     514:	636f7250 	cmnvs	pc, #80, 4
     518:	45737365 	ldrbmi	r7, [r3, #-869]!	; 0xfffffc9b
     51c:	656e0076 	strbvs	r0, [lr, #-118]!	; 0xffffff8a
     520:	47007478 	smlsdxmi	r0, r8, r4, r7
     524:	505f7465 	subspl	r7, pc, r5, ror #8
     528:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     52c:	425f7373 	subsmi	r7, pc, #-872415231	; 0xcc000001
     530:	49505f79 	ldmdbmi	r0, {r0, r3, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     534:	69540044 	ldmdbvs	r4, {r2, r6}^
     538:	5f72656d 	svcpl	0x0072656d
     53c:	65736142 	ldrbvs	r6, [r3, #-322]!	; 0xfffffebe
     540:	57534e00 	ldrbpl	r4, [r3, -r0, lsl #28]
     544:	72505f49 	subsvc	r5, r0, #292	; 0x124
     548:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     54c:	65535f73 	ldrbvs	r5, [r3, #-3955]	; 0xfffff08d
     550:	63697672 	cmnvs	r9, #119537664	; 0x7200000
     554:	65520065 	ldrbvs	r0, [r2, #-101]	; 0xffffff9b
     558:	41006461 	tstmi	r0, r1, ror #8
     55c:	76697463 	strbtvc	r7, [r9], -r3, ror #8
     560:	72505f65 	subsvc	r5, r0, #404	; 0x194
     564:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     568:	6f435f73 	svcvs	0x00435f73
     56c:	00746e75 	rsbseq	r6, r4, r5, ror lr
     570:	61657243 	cmnvs	r5, r3, asr #4
     574:	505f6574 	subspl	r6, pc, r4, ror r5	; <UNPREDICTABLE>
     578:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     57c:	73007373 	movwvc	r7, #883	; 0x373
     580:	65746174 	ldrbvs	r6, [r4, #-372]!	; 0xfffffe8c
     584:	43324900 	teqmi	r2, #0, 18
     588:	414c535f 	cmpmi	ip, pc, asr r3
     58c:	425f4556 	subsmi	r4, pc, #360710144	; 0x15800000
     590:	00657361 	rsbeq	r7, r5, r1, ror #6
     594:	4678614d 	ldrbtmi	r6, [r8], -sp, asr #2
     598:	6e656c69 	cdpvs	12, 6, cr6, cr5, cr9, {3}
     59c:	4c656d61 	stclmi	13, cr6, [r5], #-388	; 0xfffffe7c
     5a0:	74676e65 	strbtvc	r6, [r7], #-3685	; 0xfffff19b
     5a4:	55410068 	strbpl	r0, [r1, #-104]	; 0xffffff98
     5a8:	61425f58 	cmpvs	r2, r8, asr pc
     5ac:	47006573 	smlsdxmi	r0, r3, r5, r6
     5b0:	535f7465 	cmppl	pc, #1694498816	; 0x65000000
     5b4:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     5b8:	72656c75 	rsbvc	r6, r5, #29952	; 0x7500
     5bc:	666e495f 			; <UNDEFINED> instruction: 0x666e495f
     5c0:	6544006f 	strbvs	r0, [r4, #-111]	; 0xffffff91
     5c4:	696c6461 	stmdbvs	ip!, {r0, r5, r6, sl, sp, lr}^
     5c8:	555f656e 	ldrbpl	r6, [pc, #-1390]	; 62 <shift+0x62>
     5cc:	6168636e 	cmnvs	r8, lr, ror #6
     5d0:	6465676e 	strbtvs	r6, [r5], #-1902	; 0xfffff892
     5d4:	72504300 	subsvc	r4, r0, #0, 6
     5d8:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     5dc:	614d5f73 	hvcvs	54771	; 0xd5f3
     5e0:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     5e4:	68630072 	stmdavs	r3!, {r1, r4, r5, r6}^
     5e8:	745f7261 	ldrbvc	r7, [pc], #-609	; 5f0 <shift+0x5f0>
     5ec:	5f6b6369 	svcpl	0x006b6369
     5f0:	616c6564 	cmnvs	ip, r4, ror #10
     5f4:	5a5f0079 	bpl	17c07e0 <__bss_end+0x17b77f4>
     5f8:	4336314e 	teqmi	r6, #-2147483629	; 0x80000013
     5fc:	636f7250 	cmnvs	pc, #80, 4
     600:	5f737365 	svcpl	0x00737365
     604:	616e614d 	cmnvs	lr, sp, asr #2
     608:	31726567 	cmncc	r2, r7, ror #10
     60c:	74654738 	strbtvc	r4, [r5], #-1848	; 0xfffff8c8
     610:	6863535f 	stmdavs	r3!, {r0, r1, r2, r3, r4, r6, r8, r9, ip, lr}^
     614:	6c756465 	cfldrdvs	mvd6, [r5], #-404	; 0xfffffe6c
     618:	495f7265 	ldmdbmi	pc, {r0, r2, r5, r6, r9, ip, sp, lr}^	; <UNPREDICTABLE>
     61c:	456f666e 	strbmi	r6, [pc, #-1646]!	; ffffffb6 <__bss_end+0xffff6fca>
     620:	474e3032 	smlaldxmi	r3, lr, r2, r0
     624:	535f7465 	cmppl	pc, #1694498816	; 0x65000000
     628:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     62c:	666e495f 			; <UNDEFINED> instruction: 0x666e495f
     630:	79545f6f 	ldmdbvc	r4, {r0, r1, r2, r3, r5, r6, r8, r9, sl, fp, ip, lr}^
     634:	76506570 			; <UNDEFINED> instruction: 0x76506570
     638:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     63c:	50433631 	subpl	r3, r3, r1, lsr r6
     640:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     644:	4d5f7373 	ldclmi	3, cr7, [pc, #-460]	; 480 <shift+0x480>
     648:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
     64c:	31327265 	teqcc	r2, r5, ror #4
     650:	646e6148 	strbtvs	r6, [lr], #-328	; 0xfffffeb8
     654:	465f656c 	ldrbmi	r6, [pc], -ip, ror #10
     658:	73656c69 	cmnvc	r5, #26880	; 0x6900
     65c:	65747379 	ldrbvs	r7, [r4, #-889]!	; 0xfffffc87
     660:	57535f6d 	ldrbpl	r5, [r3, -sp, ror #30]
     664:	33324549 	teqcc	r2, #306184192	; 0x12400000
     668:	4957534e 	ldmdbmi	r7, {r1, r2, r3, r6, r8, r9, ip, lr}^
     66c:	6c69465f 	stclvs	6, cr4, [r9], #-380	; 0xfffffe84
     670:	73797365 	cmnvc	r9, #-1811939327	; 0x94000001
     674:	5f6d6574 	svcpl	0x006d6574
     678:	76726553 			; <UNDEFINED> instruction: 0x76726553
     67c:	6a656369 	bvs	1959428 <__bss_end+0x195043c>
     680:	31526a6a 	cmpcc	r2, sl, ror #20
     684:	57535431 	smmlarpl	r3, r1, r4, r5
     688:	65525f49 	ldrbvs	r5, [r2, #-3913]	; 0xfffff0b7
     68c:	746c7573 	strbtvc	r7, [ip], #-1395	; 0xfffffa8d
     690:	65706f00 	ldrbvs	r6, [r0, #-3840]!	; 0xfffff100
     694:	5f64656e 	svcpl	0x0064656e
     698:	656c6966 	strbvs	r6, [ip, #-2406]!	; 0xfffff69a
     69c:	6f4e0073 	svcvs	0x004e0073
     6a0:	79666974 	stmdbvc	r6!, {r2, r4, r5, r6, r8, fp, sp, lr}^
     6a4:	006c6c41 	rsbeq	r6, ip, r1, asr #24
     6a8:	726f6873 	rsbvc	r6, pc, #7536640	; 0x730000
     6ac:	6c625f74 	stclvs	15, cr5, [r2], #-464	; 0xfffffe30
     6b0:	006b6e69 	rsbeq	r6, fp, r9, ror #28
     6b4:	55504354 	ldrbpl	r4, [r0, #-852]	; 0xfffffcac
     6b8:	6e6f435f 	mcrvs	3, 3, r4, cr15, cr15, {2}
     6bc:	74786574 	ldrbtvc	r6, [r8], #-1396	; 0xfffffa8c
     6c0:	61654400 	cmnvs	r5, r0, lsl #8
     6c4:	6e696c64 	cdpvs	12, 6, cr6, cr9, cr4, {3}
     6c8:	74740065 	ldrbtvc	r0, [r4], #-101	; 0xffffff9b
     6cc:	00307262 	eorseq	r7, r0, r2, ror #4
     6d0:	314e5a5f 	cmpcc	lr, pc, asr sl
     6d4:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     6d8:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     6dc:	614d5f73 	hvcvs	54771	; 0xd5f3
     6e0:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     6e4:	4e343172 	mrcmi	1, 1, r3, cr4, cr2, {3}
     6e8:	6669746f 	strbtvs	r7, [r9], -pc, ror #8
     6ec:	72505f79 	subsvc	r5, r0, #484	; 0x1e4
     6f0:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     6f4:	006a4573 	rsbeq	r4, sl, r3, ror r5
     6f8:	5f746547 	svcpl	0x00746547
     6fc:	00444950 	subeq	r4, r4, r0, asr r9
     700:	30435342 	subcc	r5, r3, r2, asr #6
     704:	7361425f 	cmnvc	r1, #-268435451	; 0xf0000005
     708:	6f6e0065 	svcvs	0x006e0065
     70c:	69666974 	stmdbvs	r6!, {r2, r4, r5, r6, r8, fp, sp, lr}^
     710:	645f6465 	ldrbvs	r6, [pc], #-1125	; 718 <shift+0x718>
     714:	6c646165 	stfvse	f6, [r4], #-404	; 0xfffffe6c
     718:	00656e69 	rsbeq	r6, r5, r9, ror #28
     71c:	65746e49 	ldrbvs	r6, [r4, #-3657]!	; 0xfffff1b7
     720:	70757272 	rsbsvc	r7, r5, r2, ror r2
     724:	6f435f74 	svcvs	0x00435f74
     728:	6f72746e 	svcvs	0x0072746e
     72c:	72656c6c 	rsbvc	r6, r5, #108, 24	; 0x6c00
     730:	7361425f 	cmnvc	r1, #-268435451	; 0xf0000005
     734:	53420065 	movtpl	r0, #8293	; 0x2065
     738:	425f3143 	subsmi	r3, pc, #-1073741808	; 0xc0000010
     73c:	00657361 	rsbeq	r7, r5, r1, ror #6
     740:	5f78614d 	svcpl	0x0078614d
     744:	636f7250 	cmnvs	pc, #80, 4
     748:	5f737365 	svcpl	0x00737365
     74c:	6e65704f 	cdpvs	0, 6, cr7, cr5, cr15, {2}
     750:	465f6465 	ldrbmi	r6, [pc], -r5, ror #8
     754:	73656c69 	cmnvc	r5, #26880	; 0x6900
     758:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     75c:	50433631 	subpl	r3, r3, r1, lsr r6
     760:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     764:	4d5f7373 	ldclmi	3, cr7, [pc, #-460]	; 5a0 <shift+0x5a0>
     768:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
     76c:	38317265 	ldmdacc	r1!, {r0, r2, r5, r6, r9, ip, sp, lr}
     770:	616d6e55 	cmnvs	sp, r5, asr lr
     774:	69465f70 	stmdbvs	r6, {r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     778:	435f656c 	cmpmi	pc, #108, 10	; 0x1b000000
     77c:	65727275 	ldrbvs	r7, [r2, #-629]!	; 0xfffffd8b
     780:	6a45746e 	bvs	115d940 <__bss_end+0x1154954>
     784:	4e525400 	cdpmi	4, 5, cr5, cr2, cr0, {0}
     788:	61425f47 	cmpvs	r2, r7, asr #30
     78c:	47006573 	smlsdxmi	r0, r3, r5, r6
     790:	435f7465 	cmpmi	pc, #1694498816	; 0x65000000
     794:	65727275 	ldrbvs	r7, [r2, #-629]!	; 0xfffffd8b
     798:	505f746e 	subspl	r7, pc, lr, ror #8
     79c:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     7a0:	6c007373 	stcvs	3, cr7, [r0], {115}	; 0x73
     7a4:	20676e6f 	rsbcs	r6, r7, pc, ror #28
     7a8:	69736e75 	ldmdbvs	r3!, {r0, r2, r4, r5, r6, r9, sl, fp, sp, lr}^
     7ac:	64656e67 	strbtvs	r6, [r5], #-3687	; 0xfffff199
     7b0:	746e6920 	strbtvc	r6, [lr], #-2336	; 0xfffff6e0
     7b4:	70614d00 	rsbvc	r4, r1, r0, lsl #26
     7b8:	6c69465f 	stclvs	6, cr4, [r9], #-380	; 0xfffffe84
     7bc:	6f545f65 	svcvs	0x00545f65
     7c0:	7275435f 	rsbsvc	r4, r5, #2080374785	; 0x7c000001
     7c4:	746e6572 	strbtvc	r6, [lr], #-1394	; 0xfffffa8e
     7c8:	466f4e00 	strbtmi	r4, [pc], -r0, lsl #28
     7cc:	73656c69 	cmnvc	r5, #26880	; 0x6900
     7d0:	65747379 	ldrbvs	r7, [r4, #-889]!	; 0xfffffc87
     7d4:	6972446d 	ldmdbvs	r2!, {r0, r2, r3, r5, r6, sl, lr}^
     7d8:	00726576 	rsbseq	r6, r2, r6, ror r5
     7dc:	646e6148 	strbtvs	r6, [lr], #-328	; 0xfffffeb8
     7e0:	505f656c 	subspl	r6, pc, ip, ror #10
     7e4:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     7e8:	535f7373 	cmppl	pc, #-872415231	; 0xcc000001
     7ec:	73004957 	movwvc	r4, #2391	; 0x957
     7f0:	74726f68 	ldrbtvc	r6, [r2], #-3944	; 0xfffff098
     7f4:	736e7520 	cmnvc	lr, #32, 10	; 0x8000000
     7f8:	656e6769 	strbvs	r6, [lr, #-1897]!	; 0xfffff897
     7fc:	6e692064 	cdpvs	0, 6, cr2, cr9, cr4, {3}
     800:	63530074 	cmpvs	r3, #116	; 0x74
     804:	75646568 	strbvc	r6, [r4, #-1384]!	; 0xfffffa98
     808:	455f656c 	ldrbmi	r6, [pc, #-1388]	; 2a4 <shift+0x2a4>
     80c:	57004644 	strpl	r4, [r0, -r4, asr #12]
     810:	00746961 	rsbseq	r6, r4, r1, ror #18
     814:	65746e49 	ldrbvs	r6, [r4, #-3657]!	; 0xfffff1b7
     818:	70757272 	rsbsvc	r7, r5, r2, ror r2
     81c:	6c626174 	stfvse	f6, [r2], #-464	; 0xfffffe30
     820:	6c535f65 	mrrcvs	15, 6, r5, r3, cr5
     824:	00706565 	rsbseq	r6, r0, r5, ror #10
     828:	6c6f6f62 	stclvs	15, cr6, [pc], #-392	; 6a8 <shift+0x6a8>
     82c:	614c6d00 	cmpvs	ip, r0, lsl #26
     830:	505f7473 	subspl	r7, pc, r3, ror r4	; <UNPREDICTABLE>
     834:	42004449 	andmi	r4, r0, #1224736768	; 0x49000000
     838:	6b636f6c 	blvs	18dc5f0 <__bss_end+0x18d3604>
     83c:	4e006465 	cdpmi	4, 0, cr6, cr0, cr5, {3}
     840:	5f746547 	svcpl	0x00746547
     844:	65686353 	strbvs	r6, [r8, #-851]!	; 0xfffffcad
     848:	6e495f64 	cdpvs	15, 4, cr5, cr9, cr4, {3}
     84c:	545f6f66 	ldrbpl	r6, [pc], #-3942	; 854 <shift+0x854>
     850:	00657079 	rsbeq	r7, r5, r9, ror r0
     854:	6e6e7552 	mcrvs	5, 3, r7, cr14, cr2, {2}
     858:	656c6261 	strbvs	r6, [ip, #-609]!	; 0xfffffd9f
     85c:	61544e00 	cmpvs	r4, r0, lsl #28
     860:	535f6b73 	cmppl	pc, #117760	; 0x1cc00
     864:	65746174 	ldrbvs	r6, [r4, #-372]!	; 0xfffffe8c
     868:	736f7300 	cmnvc	pc, #0, 6
     86c:	64656c5f 	strbtvs	r6, [r5], #-3167	; 0xfffff3a1
     870:	68637300 	stmdavs	r3!, {r8, r9, ip, sp, lr}^
     874:	635f6465 	cmpvs	pc, #1694498816	; 0x65000000
     878:	746e756f 	strbtvc	r7, [lr], #-1391	; 0xfffffa91
     87c:	73007265 	movwvc	r7, #613	; 0x265
     880:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     884:	6174735f 	cmnvs	r4, pc, asr r3
     888:	5f636974 	svcpl	0x00636974
     88c:	6f697270 	svcvs	0x00697270
     890:	79746972 	ldmdbvc	r4!, {r1, r4, r5, r6, r8, fp, sp, lr}^
     894:	69786500 	ldmdbvs	r8!, {r8, sl, sp, lr}^
     898:	6f635f74 	svcvs	0x00635f74
     89c:	6d006564 	cfstr32vs	mvfx6, [r0, #-400]	; 0xfffffe70
     8a0:	65686353 	strbvs	r6, [r8, #-851]!	; 0xfffffcad
     8a4:	656c7564 	strbvs	r7, [ip, #-1380]!	; 0xfffffa9c
     8a8:	636e465f 	cmnvs	lr, #99614720	; 0x5f00000
     8ac:	49504700 	ldmdbmi	r0, {r8, r9, sl, lr}^
     8b0:	61425f4f 	cmpvs	r2, pc, asr #30
     8b4:	4d006573 	cfstr32mi	mvfx6, [r0, #-460]	; 0xfffffe34
     8b8:	53467861 	movtpl	r7, #26721	; 0x6861
     8bc:	76697244 	strbtvc	r7, [r9], -r4, asr #4
     8c0:	614e7265 	cmpvs	lr, r5, ror #4
     8c4:	654c656d 	strbvs	r6, [ip, #-1389]	; 0xfffffa93
     8c8:	6874676e 	ldmdavs	r4!, {r1, r2, r3, r5, r6, r8, r9, sl, sp, lr}^
     8cc:	746f4e00 	strbtvc	r4, [pc], #-3584	; 8d4 <shift+0x8d4>
     8d0:	00796669 	rsbseq	r6, r9, r9, ror #12
     8d4:	61666544 	cmnvs	r6, r4, asr #10
     8d8:	5f746c75 	svcpl	0x00746c75
     8dc:	636f6c43 	cmnvs	pc, #17152	; 0x4300
     8e0:	61525f6b 	cmpvs	r2, fp, ror #30
     8e4:	4c006574 	cfstr32mi	mvfx6, [r0], {116}	; 0x74
     8e8:	5f6b636f 	svcpl	0x006b636f
     8ec:	6f6c6e55 	svcvs	0x006c6e55
     8f0:	64656b63 	strbtvs	r6, [r5], #-2915	; 0xfffff49d
     8f4:	636f4c00 	cmnvs	pc, #0, 24
     8f8:	6f4c5f6b 	svcvs	0x004c5f6b
     8fc:	64656b63 	strbtvs	r6, [r5], #-2915	; 0xfffff49d
     900:	61655200 	cmnvs	r5, r0, lsl #4
     904:	72575f64 	subsvc	r5, r7, #100, 30	; 0x190
     908:	00657469 	rsbeq	r7, r5, r9, ror #8
     90c:	626d6f5a 	rsbvs	r6, sp, #360	; 0x168
     910:	47006569 	strmi	r6, [r0, -r9, ror #10]
     914:	535f7465 	cmppl	pc, #1694498816	; 0x65000000
     918:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     91c:	666e495f 			; <UNDEFINED> instruction: 0x666e495f
     920:	5a5f006f 	bpl	17c0ae4 <__bss_end+0x17b7af8>
     924:	4336314e 	teqmi	r6, #-2147483629	; 0x80000013
     928:	636f7250 	cmnvs	pc, #80, 4
     92c:	5f737365 	svcpl	0x00737365
     930:	616e614d 	cmnvs	lr, sp, asr #2
     934:	38726567 	ldmdacc	r2!, {r0, r1, r2, r5, r6, r8, sl, sp, lr}^
     938:	65686353 	strbvs	r6, [r8, #-851]!	; 0xfffffcad
     93c:	656c7564 	strbvs	r7, [ip, #-1380]!	; 0xfffffa9c
     940:	5f007645 	svcpl	0x00007645
     944:	36314e5a 			; <UNDEFINED> instruction: 0x36314e5a
     948:	6f725043 	svcvs	0x00725043
     94c:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     950:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     954:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     958:	614d3931 	cmpvs	sp, r1, lsr r9
     95c:	69465f70 	stmdbvs	r6, {r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     960:	545f656c 	ldrbpl	r6, [pc], #-1388	; 968 <shift+0x968>
     964:	75435f6f 	strbvc	r5, [r3, #-3951]	; 0xfffff091
     968:	6e657272 	mcrvs	2, 3, r7, cr5, cr2, {3}
     96c:	35504574 	ldrbcc	r4, [r0, #-1396]	; 0xfffffa8c
     970:	6c694649 	stclvs	6, cr4, [r9], #-292	; 0xfffffedc
     974:	614d0065 	cmpvs	sp, r5, rrx
     978:	74615078 	strbtvc	r5, [r1], #-120	; 0xffffff88
     97c:	6e654c68 	cdpvs	12, 6, cr4, cr5, cr8, {3}
     980:	00687467 	rsbeq	r7, r8, r7, ror #8
     984:	69736e75 	ldmdbvs	r3!, {r0, r2, r4, r5, r6, r9, sl, fp, sp, lr}^
     988:	64656e67 	strbtvs	r6, [r5], #-3687	; 0xfffff199
     98c:	61686320 	cmnvs	r8, r0, lsr #6
     990:	79730072 	ldmdbvc	r3!, {r1, r4, r5, r6}^
     994:	6c6f626d 	sfmvs	f6, 2, [pc], #-436	; 7e8 <shift+0x7e8>
     998:	6369745f 	cmnvs	r9, #1593835520	; 0x5f000000
     99c:	65645f6b 	strbvs	r5, [r4, #-3947]!	; 0xfffff095
     9a0:	0079616c 	rsbseq	r6, r9, ip, ror #2
     9a4:	314e5a5f 	cmpcc	lr, pc, asr sl
     9a8:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     9ac:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     9b0:	614d5f73 	hvcvs	54771	; 0xd5f3
     9b4:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     9b8:	53323172 	teqpl	r2, #-2147483620	; 0x8000001c
     9bc:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     9c0:	5f656c75 	svcpl	0x00656c75
     9c4:	45464445 	strbmi	r4, [r6, #-1093]	; 0xfffffbbb
     9c8:	50470076 	subpl	r0, r7, r6, ror r0
     9cc:	505f4f49 	subspl	r4, pc, r9, asr #30
     9d0:	435f6e69 	cmpmi	pc, #1680	; 0x690
     9d4:	746e756f 	strbtvc	r7, [lr], #-1391	; 0xfffffa91
     9d8:	6f687300 	svcvs	0x00687300
     9dc:	69207472 	stmdbvs	r0!, {r1, r4, r5, r6, sl, ip, sp, lr}
     9e0:	4900746e 	stmdbmi	r0, {r1, r2, r3, r5, r6, sl, ip, sp, lr}
     9e4:	6c61766e 	stclvs	6, cr7, [r1], #-440	; 0xfffffe48
     9e8:	505f6469 	subspl	r6, pc, r9, ror #8
     9ec:	50006e69 	andpl	r6, r0, r9, ror #28
     9f0:	70697265 	rsbvc	r7, r9, r5, ror #4
     9f4:	61726568 	cmnvs	r2, r8, ror #10
     9f8:	61425f6c 	cmpvs	r2, ip, ror #30
     9fc:	52006573 	andpl	r6, r0, #482344960	; 0x1cc00000
     a00:	696e6e75 	stmdbvs	lr!, {r0, r2, r4, r5, r6, r9, sl, fp, sp, lr}^
     a04:	2f00676e 	svccs	0x0000676e
     a08:	72657355 	rsbvc	r7, r5, #1409286145	; 0x54000001
     a0c:	69772f73 	ldmdbvs	r7!, {r0, r1, r4, r5, r6, r8, r9, sl, fp, sp}^
     a10:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
     a14:	442f696a 	strtmi	r6, [pc], #-2410	; a1c <shift+0xa1c>
     a18:	746b7365 	strbtvc	r7, [fp], #-869	; 0xfffffc9b
     a1c:	462f706f 	strtmi	r7, [pc], -pc, rrx
     a20:	4e2f5641 	cfmadda32mi	mvax2, mvax5, mvfx15, mvfx1
     a24:	7a617661 	bvc	185e3b0 <__bss_end+0x18553c4>
     a28:	63696a75 	cmnvs	r9, #479232	; 0x75000
     a2c:	534f2f69 	movtpl	r2, #65385	; 0xff69
     a30:	6d65732f 	stclvs	3, cr7, [r5, #-188]!	; 0xffffff44
     a34:	72747365 	rsbsvc	r7, r4, #-1811939327	; 0x94000001
     a38:	616b6c61 	cmnvs	fp, r1, ror #24
     a3c:	76696b2d 	strbtvc	r6, [r9], -sp, lsr #22
     a40:	2f736f2d 	svccs	0x00736f2d
     a44:	72756f73 	rsbsvc	r6, r5, #460	; 0x1cc
     a48:	2f736563 	svccs	0x00736563
     a4c:	72657375 	rsbvc	r7, r5, #-738197503	; 0xd4000001
     a50:	63617073 	cmnvs	r1, #115	; 0x73
     a54:	6f732f65 	svcvs	0x00732f65
     a58:	61745f73 	cmnvs	r4, r3, ror pc
     a5c:	6d2f6b73 	fstmdbxvs	pc!, {d6-d62}	;@ Deprecated
     a60:	2e6e6961 	vnmulcs.f16	s13, s28, s3	; <UNPREDICTABLE>
     a64:	00707063 	rsbseq	r7, r0, r3, rrx
     a68:	7275436d 	rsbsvc	r4, r5, #-1275068415	; 0xb4000001
     a6c:	746e6572 	strbtvc	r6, [lr], #-1394	; 0xfffffa8e
     a70:	7361545f 	cmnvc	r1, #1593835520	; 0x5f000000
     a74:	6f4e5f6b 	svcvs	0x004e5f6b
     a78:	5f006564 	svcpl	0x00006564
     a7c:	6c62355a 	cfstr64vs	mvdx3, [r2], #-360	; 0xfffffe98
     a80:	626b6e69 	rsbvs	r6, fp, #1680	; 0x690
     a84:	75706300 	ldrbvc	r6, [r0, #-768]!	; 0xfffffd00
     a88:	6e6f635f 	mcrvs	3, 3, r6, cr15, cr15, {2}
     a8c:	74786574 	ldrbtvc	r6, [r8], #-1396	; 0xfffffa8c
     a90:	61655200 	cmnvs	r5, r0, lsl #4
     a94:	6e4f5f64 	cdpvs	15, 4, cr5, cr15, cr4, {3}
     a98:	7300796c 	movwvc	r7, #2412	; 0x96c
     a9c:	7065656c 	rsbvc	r6, r5, ip, ror #10
     aa0:	6d69745f 	cfstrdvs	mvd7, [r9, #-380]!	; 0xfffffe84
     aa4:	5f007265 	svcpl	0x00007265
     aa8:	314b4e5a 	cmpcc	fp, sl, asr lr
     aac:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     ab0:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     ab4:	614d5f73 	hvcvs	54771	; 0xd5f3
     ab8:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     abc:	47383172 			; <UNDEFINED> instruction: 0x47383172
     ac0:	505f7465 	subspl	r7, pc, r5, ror #8
     ac4:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     ac8:	425f7373 	subsmi	r7, pc, #-872415231	; 0xcc000001
     acc:	49505f79 	ldmdbmi	r0, {r0, r3, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     ad0:	006a4544 	rsbeq	r4, sl, r4, asr #10
     ad4:	646e6148 	strbtvs	r6, [lr], #-328	; 0xfffffeb8
     ad8:	465f656c 	ldrbmi	r6, [pc], -ip, ror #10
     adc:	73656c69 	cmnvc	r5, #26880	; 0x6900
     ae0:	65747379 	ldrbvs	r7, [r4, #-889]!	; 0xfffffc87
     ae4:	57535f6d 	ldrbpl	r5, [r3, -sp, ror #30]
     ae8:	5a5f0049 	bpl	17c0c14 <__bss_end+0x17b7c28>
     aec:	4336314e 	teqmi	r6, #-2147483629	; 0x80000013
     af0:	636f7250 	cmnvs	pc, #80, 4
     af4:	5f737365 	svcpl	0x00737365
     af8:	616e614d 	cmnvs	lr, sp, asr #2
     afc:	31726567 	cmncc	r2, r7, ror #10
     b00:	68635331 	stmdavs	r3!, {r0, r4, r5, r8, r9, ip, lr}^
     b04:	6c756465 	cfldrdvs	mvd6, [r5], #-404	; 0xfffffe6c
     b08:	52525f65 	subspl	r5, r2, #404	; 0x194
     b0c:	74007645 	strvc	r7, [r0], #-1605	; 0xfffff9bb
     b10:	006b7361 	rsbeq	r7, fp, r1, ror #6
     b14:	69746f4e 	ldmdbvs	r4!, {r1, r2, r3, r6, r8, r9, sl, fp, sp, lr}^
     b18:	505f7966 	subspl	r7, pc, r6, ror #18
     b1c:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     b20:	53007373 	movwpl	r7, #883	; 0x373
     b24:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     b28:	00656c75 	rsbeq	r6, r5, r5, ror ip
     b2c:	314e5a5f 	cmpcc	lr, pc, asr sl
     b30:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     b34:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     b38:	614d5f73 	hvcvs	54771	; 0xd5f3
     b3c:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     b40:	77533972 			; <UNDEFINED> instruction: 0x77533972
     b44:	68637469 	stmdavs	r3!, {r0, r3, r5, r6, sl, ip, sp, lr}^
     b48:	456f545f 	strbmi	r5, [pc, #-1119]!	; 6f1 <shift+0x6f1>
     b4c:	43383150 	teqmi	r8, #80, 2
     b50:	636f7250 	cmnvs	pc, #80, 4
     b54:	5f737365 	svcpl	0x00737365
     b58:	7473694c 	ldrbtvc	r6, [r3], #-2380	; 0xfffff6b4
     b5c:	646f4e5f 	strbtvs	r4, [pc], #-3679	; b64 <shift+0xb64>
     b60:	63530065 	cmpvs	r3, #101	; 0x65
     b64:	75646568 	strbvc	r6, [r4, #-1384]!	; 0xfffffa98
     b68:	525f656c 	subspl	r6, pc, #108, 10	; 0x1b000000
     b6c:	69750052 	ldmdbvs	r5!, {r1, r4, r6}^
     b70:	3233746e 	eorscc	r7, r3, #1845493760	; 0x6e000000
     b74:	6100745f 	tstvs	r0, pc, asr r4
     b78:	00766772 	rsbseq	r6, r6, r2, ror r7
     b7c:	314e5a5f 	cmpcc	lr, pc, asr sl
     b80:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     b84:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     b88:	614d5f73 	hvcvs	54771	; 0xd5f3
     b8c:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     b90:	43343172 	teqmi	r4, #-2147483620	; 0x8000001c
     b94:	74616572 	strbtvc	r6, [r1], #-1394	; 0xfffffa8e
     b98:	72505f65 	subsvc	r5, r0, #404	; 0x194
     b9c:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     ba0:	68504573 	ldmdavs	r0, {r0, r1, r4, r5, r6, r8, sl, lr}^
     ba4:	5300626a 	movwpl	r6, #618	; 0x26a
     ba8:	63746977 	cmnvs	r4, #1949696	; 0x1dc000
     bac:	6f545f68 	svcvs	0x00545f68
     bb0:	57534e00 	ldrbpl	r4, [r3, -r0, lsl #28]
     bb4:	69465f49 	stmdbvs	r6, {r0, r3, r6, r8, r9, sl, fp, ip, lr}^
     bb8:	7973656c 	ldmdbvc	r3!, {r2, r3, r5, r6, r8, sl, sp, lr}^
     bbc:	6d657473 	cfstrdvs	mvd7, [r5, #-460]!	; 0xfffffe34
     bc0:	7265535f 	rsbvc	r5, r5, #2080374785	; 0x7c000001
     bc4:	65636976 	strbvs	r6, [r3, #-2422]!	; 0xfffff68a
     bc8:	766e4900 	strbtvc	r4, [lr], -r0, lsl #18
     bcc:	64696c61 	strbtvs	r6, [r9], #-3169	; 0xfffff39f
     bd0:	6e61485f 	mcrvs	8, 3, r4, cr1, cr15, {2}
     bd4:	00656c64 	rsbeq	r6, r5, r4, ror #24
     bd8:	636f6c42 	cmnvs	pc, #16896	; 0x4200
     bdc:	75435f6b 	strbvc	r5, [r3, #-3947]	; 0xfffff095
     be0:	6e657272 	mcrvs	2, 3, r7, cr5, cr2, {3}
     be4:	72505f74 	subsvc	r5, r0, #116, 30	; 0x1d0
     be8:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     bec:	6c430073 	mcrrvs	0, 7, r0, r3, cr3
     bf0:	0065736f 	rsbeq	r7, r5, pc, ror #6
     bf4:	63677261 	cmnvs	r7, #268435462	; 0x10000006
     bf8:	72617500 	rsbvc	r7, r1, #0, 10
     bfc:	72570074 	subsvc	r0, r7, #116	; 0x74
     c00:	5f657469 	svcpl	0x00657469
     c04:	796c6e4f 	stmdbvc	ip!, {r0, r1, r2, r3, r6, r9, sl, fp, sp, lr}^
     c08:	69616d00 	stmdbvs	r1!, {r8, sl, fp, sp, lr}^
     c0c:	6959006e 	ldmdbvs	r9, {r1, r2, r3, r5, r6}^
     c10:	00646c65 	rsbeq	r6, r4, r5, ror #24
     c14:	314e5a5f 	cmpcc	lr, pc, asr sl
     c18:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     c1c:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     c20:	614d5f73 	hvcvs	54771	; 0xd5f3
     c24:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     c28:	45344372 	ldrmi	r4, [r4, #-882]!	; 0xfffffc8e
     c2c:	65540076 	ldrbvs	r0, [r4, #-118]	; 0xffffff8a
     c30:	6e696d72 	mcrvs	13, 3, r6, cr9, cr2, {3}
     c34:	00657461 	rsbeq	r7, r5, r1, ror #8
     c38:	74434f49 	strbvc	r4, [r3], #-3913	; 0xfffff0b7
     c3c:	552f006c 	strpl	r0, [pc, #-108]!	; bd8 <shift+0xbd8>
     c40:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
     c44:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
     c48:	6a726574 	bvs	1c9a220 <__bss_end+0x1c91234>
     c4c:	65442f69 	strbvs	r2, [r4, #-3945]	; 0xfffff097
     c50:	6f746b73 	svcvs	0x00746b73
     c54:	41462f70 	hvcmi	25328	; 0x62f0
     c58:	614e2f56 	cmpvs	lr, r6, asr pc
     c5c:	757a6176 	ldrbvc	r6, [sl, #-374]!	; 0xfffffe8a
     c60:	6963696a 	stmdbvs	r3!, {r1, r3, r5, r6, r8, fp, sp, lr}^
     c64:	2f534f2f 	svccs	0x00534f2f
     c68:	656d6573 	strbvs	r6, [sp, #-1395]!	; 0xfffffa8d
     c6c:	61727473 	cmnvs	r2, r3, ror r4
     c70:	2d616b6c 	vstmdbcs	r1!, {d22-<overflow reg d75>}
     c74:	2d76696b 			; <UNDEFINED> instruction: 0x2d76696b
     c78:	732f736f 			; <UNDEFINED> instruction: 0x732f736f
     c7c:	6372756f 	cmnvs	r2, #465567744	; 0x1bc00000
     c80:	622f7365 	eorvs	r7, pc, #-1811939327	; 0x94000001
     c84:	646c6975 	strbtvs	r6, [ip], #-2421	; 0xfffff68b
     c88:	6f6c6300 	svcvs	0x006c6300
     c8c:	53006573 	movwpl	r6, #1395	; 0x573
     c90:	525f7465 	subspl	r7, pc, #1694498816	; 0x65000000
     c94:	74616c65 	strbtvc	r6, [r1], #-3173	; 0xfffff39b
     c98:	00657669 	rsbeq	r7, r5, r9, ror #12
     c9c:	76746572 			; <UNDEFINED> instruction: 0x76746572
     ca0:	6e006c61 	cdpvs	12, 0, cr6, cr0, cr1, {3}
     ca4:	00727563 	rsbseq	r7, r2, r3, ror #10
     ca8:	65706970 	ldrbvs	r6, [r0, #-2416]!	; 0xfffff690
     cac:	6e647200 	cdpvs	2, 6, cr7, cr4, cr0, {0}
     cb0:	5f006d75 	svcpl	0x00006d75
     cb4:	7331315a 	teqvc	r1, #-2147483626	; 0x80000016
     cb8:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     cbc:	6569795f 	strbvs	r7, [r9, #-2399]!	; 0xfffff6a1
     cc0:	0076646c 	rsbseq	r6, r6, ip, ror #8
     cc4:	37315a5f 			; <UNDEFINED> instruction: 0x37315a5f
     cc8:	5f746573 	svcpl	0x00746573
     ccc:	6b736174 	blvs	1cd92a4 <__bss_end+0x1cd02b8>
     cd0:	6165645f 	cmnvs	r5, pc, asr r4
     cd4:	6e696c64 	cdpvs	12, 6, cr6, cr9, cr4, {3}
     cd8:	77006a65 	strvc	r6, [r0, -r5, ror #20]
     cdc:	00746961 	rsbseq	r6, r4, r1, ror #18
     ce0:	6e365a5f 			; <UNDEFINED> instruction: 0x6e365a5f
     ce4:	6669746f 	strbtvs	r7, [r9], -pc, ror #8
     ce8:	006a6a79 	rsbeq	r6, sl, r9, ror sl
     cec:	6c696146 	stfvse	f6, [r9], #-280	; 0xfffffee8
     cf0:	69786500 	ldmdbvs	r8!, {r8, sl, sp, lr}^
     cf4:	646f6374 	strbtvs	r6, [pc], #-884	; cfc <shift+0xcfc>
     cf8:	63730065 	cmnvs	r3, #101	; 0x65
     cfc:	5f646568 	svcpl	0x00646568
     d00:	6c656979 			; <UNDEFINED> instruction: 0x6c656979
     d04:	69740064 	ldmdbvs	r4!, {r2, r5, r6}^
     d08:	635f6b63 	cmpvs	pc, #101376	; 0x18c00
     d0c:	746e756f 	strbtvc	r7, [lr], #-1391	; 0xfffffa91
     d10:	7165725f 	cmnvc	r5, pc, asr r2
     d14:	65726975 	ldrbvs	r6, [r2, #-2421]!	; 0xfffff68b
     d18:	5a5f0064 	bpl	17c0eb0 <__bss_end+0x17b7ec4>
     d1c:	65673432 	strbvs	r3, [r7, #-1074]!	; 0xfffffbce
     d20:	63615f74 	cmnvs	r1, #116, 30	; 0x1d0
     d24:	65766974 	ldrbvs	r6, [r6, #-2420]!	; 0xfffff68c
     d28:	6f72705f 	svcvs	0x0072705f
     d2c:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     d30:	756f635f 	strbvc	r6, [pc, #-863]!	; 9d9 <shift+0x9d9>
     d34:	0076746e 	rsbseq	r7, r6, lr, ror #8
     d38:	65706950 	ldrbvs	r6, [r0, #-2384]!	; 0xfffff6b0
     d3c:	6c69465f 	stclvs	6, cr4, [r9], #-380	; 0xfffffe84
     d40:	72505f65 	subsvc	r5, r0, #404	; 0x194
     d44:	78696665 	stmdavc	r9!, {r0, r2, r5, r6, r9, sl, sp, lr}^
     d48:	74655300 	strbtvc	r5, [r5], #-768	; 0xfffffd00
     d4c:	7261505f 	rsbvc	r5, r1, #95	; 0x5f
     d50:	00736d61 	rsbseq	r6, r3, r1, ror #26
     d54:	34315a5f 	ldrtcc	r5, [r1], #-2655	; 0xfffff5a1
     d58:	5f746567 	svcpl	0x00746567
     d5c:	6b636974 	blvs	18db334 <__bss_end+0x18d2348>
     d60:	756f635f 	strbvc	r6, [pc, #-863]!	; a09 <shift+0xa09>
     d64:	0076746e 	rsbseq	r7, r6, lr, ror #8
     d68:	65656c73 	strbvs	r6, [r5, #-3187]!	; 0xfffff38d
     d6c:	69440070 	stmdbvs	r4, {r4, r5, r6}^
     d70:	6c626173 	stfvse	f6, [r2], #-460	; 0xfffffe34
     d74:	76455f65 	strbvc	r5, [r5], -r5, ror #30
     d78:	5f746e65 	svcpl	0x00746e65
     d7c:	65746544 	ldrbvs	r6, [r4, #-1348]!	; 0xfffffabc
     d80:	6f697463 	svcvs	0x00697463
     d84:	5a5f006e 	bpl	17c0f44 <__bss_end+0x17b7f58>
     d88:	72657439 	rsbvc	r7, r5, #956301312	; 0x39000000
     d8c:	616e696d 	cmnvs	lr, sp, ror #18
     d90:	00696574 	rsbeq	r6, r9, r4, ror r5
     d94:	7265706f 	rsbvc	r7, r5, #111	; 0x6f
     d98:	6f697461 	svcvs	0x00697461
     d9c:	5a5f006e 	bpl	17c0f5c <__bss_end+0x17b7f70>
     da0:	6f6c6335 	svcvs	0x006c6335
     da4:	006a6573 	rsbeq	r6, sl, r3, ror r5
     da8:	67365a5f 			; <UNDEFINED> instruction: 0x67365a5f
     dac:	69707465 	ldmdbvs	r0!, {r0, r2, r5, r6, sl, ip, sp, lr}^
     db0:	66007664 	strvs	r7, [r0], -r4, ror #12
     db4:	656d616e 	strbvs	r6, [sp, #-366]!	; 0xfffffe92
     db8:	69727700 	ldmdbvs	r2!, {r8, r9, sl, ip, sp, lr}^
     dbc:	74006574 	strvc	r6, [r0], #-1396	; 0xfffffa8c
     dc0:	736b6369 	cmnvc	fp, #-1543503871	; 0xa4000001
     dc4:	65706f00 	ldrbvs	r6, [r0, #-3840]!	; 0xfffff100
     dc8:	5a5f006e 	bpl	17c0f88 <__bss_end+0x17b7f9c>
     dcc:	70697034 	rsbvc	r7, r9, r4, lsr r0
     dd0:	634b5065 	movtvs	r5, #45157	; 0xb065
     dd4:	444e006a 	strbmi	r0, [lr], #-106	; 0xffffff96
     dd8:	6c646165 	stfvse	f6, [r4], #-404	; 0xfffffe6c
     ddc:	5f656e69 	svcpl	0x00656e69
     de0:	73627553 	cmnvc	r2, #348127232	; 0x14c00000
     de4:	69767265 	ldmdbvs	r6!, {r0, r2, r5, r6, r9, ip, sp, lr}^
     de8:	67006563 	strvs	r6, [r0, -r3, ror #10]
     dec:	745f7465 	ldrbvc	r7, [pc], #-1125	; df4 <shift+0xdf4>
     df0:	5f6b6369 	svcpl	0x006b6369
     df4:	6e756f63 	cdpvs	15, 7, cr6, cr5, cr3, {3}
     df8:	61700074 	cmnvs	r0, r4, ror r0
     dfc:	006d6172 	rsbeq	r6, sp, r2, ror r1
     e00:	77355a5f 			; <UNDEFINED> instruction: 0x77355a5f
     e04:	65746972 	ldrbvs	r6, [r4, #-2418]!	; 0xfffff68e
     e08:	634b506a 	movtvs	r5, #45162	; 0xb06a
     e0c:	6567006a 	strbvs	r0, [r7, #-106]!	; 0xffffff96
     e10:	61745f74 	cmnvs	r4, r4, ror pc
     e14:	745f6b73 	ldrbvc	r6, [pc], #-2931	; e1c <shift+0xe1c>
     e18:	736b6369 	cmnvc	fp, #-1543503871	; 0xa4000001
     e1c:	5f6f745f 	svcpl	0x006f745f
     e20:	64616564 	strbtvs	r6, [r1], #-1380	; 0xfffffa9c
     e24:	656e696c 	strbvs	r6, [lr, #-2412]!	; 0xfffff694
     e28:	66756200 	ldrbtvs	r6, [r5], -r0, lsl #4
     e2c:	7a69735f 	bvc	1a5dbb0 <__bss_end+0x1a54bc4>
     e30:	65730065 	ldrbvs	r0, [r3, #-101]!	; 0xffffff9b
     e34:	61745f74 	cmnvs	r4, r4, ror pc
     e38:	645f6b73 	ldrbvs	r6, [pc], #-2931	; e40 <shift+0xe40>
     e3c:	6c646165 	stfvse	f6, [r4], #-404	; 0xfffffe6c
     e40:	00656e69 	rsbeq	r6, r5, r9, ror #28
     e44:	5f746547 	svcpl	0x00746547
     e48:	61726150 	cmnvs	r2, r0, asr r1
     e4c:	2f00736d 	svccs	0x0000736d
     e50:	72657355 	rsbvc	r7, r5, #1409286145	; 0x54000001
     e54:	69772f73 	ldmdbvs	r7!, {r0, r1, r4, r5, r6, r8, r9, sl, fp, sp}^
     e58:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
     e5c:	442f696a 	strtmi	r6, [pc], #-2410	; e64 <shift+0xe64>
     e60:	746b7365 	strbtvc	r7, [fp], #-869	; 0xfffffc9b
     e64:	462f706f 	strtmi	r7, [pc], -pc, rrx
     e68:	4e2f5641 	cfmadda32mi	mvax2, mvax5, mvfx15, mvfx1
     e6c:	7a617661 	bvc	185e7f8 <__bss_end+0x185580c>
     e70:	63696a75 	cmnvs	r9, #479232	; 0x75000
     e74:	534f2f69 	movtpl	r2, #65385	; 0xff69
     e78:	6d65732f 	stclvs	3, cr7, [r5, #-188]!	; 0xffffff44
     e7c:	72747365 	rsbsvc	r7, r4, #-1811939327	; 0x94000001
     e80:	616b6c61 	cmnvs	fp, r1, ror #24
     e84:	76696b2d 	strbtvc	r6, [r9], -sp, lsr #22
     e88:	2f736f2d 	svccs	0x00736f2d
     e8c:	72756f73 	rsbsvc	r6, r5, #460	; 0x1cc
     e90:	2f736563 	svccs	0x00736563
     e94:	6c647473 	cfstrdvs	mvd7, [r4], #-460	; 0xfffffe34
     e98:	732f6269 			; <UNDEFINED> instruction: 0x732f6269
     e9c:	732f6372 			; <UNDEFINED> instruction: 0x732f6372
     ea0:	69666474 	stmdbvs	r6!, {r2, r4, r5, r6, sl, sp, lr}^
     ea4:	632e656c 			; <UNDEFINED> instruction: 0x632e656c
     ea8:	5f007070 	svcpl	0x00007070
     eac:	6c73355a 	cfldr64vs	mvdx3, [r3], #-360	; 0xfffffe98
     eb0:	6a706565 	bvs	1c1a44c <__bss_end+0x1c11460>
     eb4:	6966006a 	stmdbvs	r6!, {r1, r3, r5, r6}^
     eb8:	4700656c 	strmi	r6, [r0, -ip, ror #10]
     ebc:	525f7465 	subspl	r7, pc, #1694498816	; 0x65000000
     ec0:	69616d65 	stmdbvs	r1!, {r0, r2, r5, r6, r8, sl, fp, sp, lr}^
     ec4:	676e696e 	strbvs	r6, [lr, -lr, ror #18]!
     ec8:	616e4500 	cmnvs	lr, r0, lsl #10
     ecc:	5f656c62 	svcpl	0x00656c62
     ed0:	6e657645 	cdpvs	6, 6, cr7, cr5, cr5, {2}
     ed4:	65445f74 	strbvs	r5, [r4, #-3956]	; 0xfffff08c
     ed8:	74636574 	strbtvc	r6, [r3], #-1396	; 0xfffffa8c
     edc:	006e6f69 	rsbeq	r6, lr, r9, ror #30
     ee0:	36325a5f 			; <UNDEFINED> instruction: 0x36325a5f
     ee4:	5f746567 	svcpl	0x00746567
     ee8:	6b736174 	blvs	1cd94c0 <__bss_end+0x1cd04d4>
     eec:	6369745f 	cmnvs	r9, #1593835520	; 0x5f000000
     ef0:	745f736b 	ldrbvc	r7, [pc], #-875	; ef8 <shift+0xef8>
     ef4:	65645f6f 	strbvs	r5, [r4, #-3951]!	; 0xfffff091
     ef8:	696c6461 	stmdbvs	ip!, {r0, r5, r6, sl, sp, lr}^
     efc:	0076656e 	rsbseq	r6, r6, lr, ror #10
     f00:	4957534e 	ldmdbmi	r7, {r1, r2, r3, r6, r8, r9, ip, lr}^
     f04:	7365525f 	cmnvc	r5, #-268435451	; 0xf0000005
     f08:	5f746c75 	svcpl	0x00746c75
     f0c:	65646f43 	strbvs	r6, [r4, #-3907]!	; 0xfffff0bd
     f10:	6e727700 	cdpvs	7, 7, cr7, cr2, cr0, {0}
     f14:	5f006d75 	svcpl	0x00006d75
     f18:	6177345a 	cmnvs	r7, sl, asr r4
     f1c:	6a6a7469 	bvs	1a9e0c8 <__bss_end+0x1a950dc>
     f20:	5a5f006a 	bpl	17c10d0 <__bss_end+0x17b80e4>
     f24:	636f6935 	cmnvs	pc, #868352	; 0xd4000
     f28:	316a6c74 	smccc	42692	; 0xa6c4
     f2c:	4f494e36 	svcmi	0x00494e36
     f30:	5f6c7443 	svcpl	0x006c7443
     f34:	7265704f 	rsbvc	r7, r5, #79	; 0x4f
     f38:	6f697461 	svcvs	0x00697461
     f3c:	0076506e 	rsbseq	r5, r6, lr, rrx
     f40:	74636f69 	strbtvc	r6, [r3], #-3945	; 0xfffff097
     f44:	6572006c 	ldrbvs	r0, [r2, #-108]!	; 0xffffff94
     f48:	746e6374 	strbtvc	r6, [lr], #-884	; 0xfffffc8c
     f4c:	746f6e00 	strbtvc	r6, [pc], #-3584	; f54 <shift+0xf54>
     f50:	00796669 	rsbseq	r6, r9, r9, ror #12
     f54:	6d726574 	cfldr64vs	mvdx6, [r2, #-464]!	; 0xfffffe30
     f58:	74616e69 	strbtvc	r6, [r1], #-3689	; 0xfffff197
     f5c:	6f6d0065 	svcvs	0x006d0065
     f60:	62006564 	andvs	r6, r0, #100, 10	; 0x19000000
     f64:	65666675 	strbvs	r6, [r6, #-1653]!	; 0xfffff98b
     f68:	5a5f0072 	bpl	17c1138 <__bss_end+0x17b814c>
     f6c:	61657234 	cmnvs	r5, r4, lsr r2
     f70:	63506a64 	cmpvs	r0, #100, 20	; 0x64000
     f74:	4e47006a 	cdpmi	0, 4, cr0, cr7, cr10, {3}
     f78:	2b432055 	blcs	10c90d4 <__bss_end+0x10c00e8>
     f7c:	2034312b 	eorscs	r3, r4, fp, lsr #2
     f80:	332e3031 			; <UNDEFINED> instruction: 0x332e3031
     f84:	3220312e 	eorcc	r3, r0, #-2147483637	; 0x8000000b
     f88:	30313230 	eorscc	r3, r1, r0, lsr r2
     f8c:	20343238 	eorscs	r3, r4, r8, lsr r2
     f90:	6c657228 	sfmvs	f7, 2, [r5], #-160	; 0xffffff60
     f94:	65736165 	ldrbvs	r6, [r3, #-357]!	; 0xfffffe9b
     f98:	6d2d2029 	stcvs	0, cr2, [sp, #-164]!	; 0xffffff5c
     f9c:	616f6c66 	cmnvs	pc, r6, ror #24
     fa0:	62612d74 	rsbvs	r2, r1, #116, 26	; 0x1d00
     fa4:	61683d69 	cmnvs	r8, r9, ror #26
     fa8:	2d206472 	cfstrscs	mvf6, [r0, #-456]!	; 0xfffffe38
     fac:	7570666d 	ldrbvc	r6, [r0, #-1645]!	; 0xfffff993
     fb0:	7066763d 	rsbvc	r7, r6, sp, lsr r6
     fb4:	666d2d20 	strbtvs	r2, [sp], -r0, lsr #26
     fb8:	74616f6c 	strbtvc	r6, [r1], #-3948	; 0xfffff094
     fbc:	6962612d 	stmdbvs	r2!, {r0, r2, r3, r5, r8, sp, lr}^
     fc0:	7261683d 	rsbvc	r6, r1, #3997696	; 0x3d0000
     fc4:	6d2d2064 	stcvs	0, cr2, [sp, #-400]!	; 0xfffffe70
     fc8:	3d757066 	ldclcc	0, cr7, [r5, #-408]!	; 0xfffffe68
     fcc:	20706676 	rsbscs	r6, r0, r6, ror r6
     fd0:	75746d2d 	ldrbvc	r6, [r4, #-3373]!	; 0xfffff2d3
     fd4:	613d656e 	teqvs	sp, lr, ror #10
     fd8:	31316d72 	teqcc	r1, r2, ror sp
     fdc:	7a6a3637 	bvc	1a8e8c0 <__bss_end+0x1a858d4>
     fe0:	20732d66 	rsbscs	r2, r3, r6, ror #26
     fe4:	72616d2d 	rsbvc	r6, r1, #2880	; 0xb40
     fe8:	6d2d206d 	stcvs	0, cr2, [sp, #-436]!	; 0xfffffe4c
     fec:	68637261 	stmdavs	r3!, {r0, r5, r6, r9, ip, sp, lr}^
     ff0:	6d72613d 	ldfvse	f6, [r2, #-244]!	; 0xffffff0c
     ff4:	6b7a3676 	blvs	1e8e9d4 <__bss_end+0x1e859e8>
     ff8:	2070662b 	rsbscs	r6, r0, fp, lsr #12
     ffc:	2d20672d 	stccs	7, cr6, [r0, #-180]!	; 0xffffff4c
    1000:	672d2067 	strvs	r2, [sp, -r7, rrx]!
    1004:	304f2d20 	subcc	r2, pc, r0, lsr #26
    1008:	304f2d20 	subcc	r2, pc, r0, lsr #26
    100c:	6e662d20 	cdpvs	13, 6, cr2, cr6, cr0, {1}
    1010:	78652d6f 	stmdavc	r5!, {r0, r1, r2, r3, r5, r6, r8, sl, fp, sp}^
    1014:	74706563 	ldrbtvc	r6, [r0], #-1379	; 0xfffffa9d
    1018:	736e6f69 	cmnvc	lr, #420	; 0x1a4
    101c:	6e662d20 	cdpvs	13, 6, cr2, cr6, cr0, {1}
    1020:	74722d6f 	ldrbtvc	r2, [r2], #-3439	; 0xfffff291
    1024:	4e006974 			; <UNDEFINED> instruction: 0x4e006974
    1028:	74434f49 	strbvc	r4, [r3], #-3913	; 0xfffff0b7
    102c:	704f5f6c 	subvc	r5, pc, ip, ror #30
    1030:	74617265 	strbtvc	r7, [r1], #-613	; 0xfffffd9b
    1034:	006e6f69 	rsbeq	r6, lr, r9, ror #30
    1038:	63746572 	cmnvs	r4, #478150656	; 0x1c800000
    103c:	0065646f 	rsbeq	r6, r5, pc, ror #8
    1040:	5f746567 	svcpl	0x00746567
    1044:	69746361 	ldmdbvs	r4!, {r0, r5, r6, r8, r9, sp, lr}^
    1048:	705f6576 	subsvc	r6, pc, r6, ror r5	; <UNPREDICTABLE>
    104c:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
    1050:	635f7373 	cmpvs	pc, #-872415231	; 0xcc000001
    1054:	746e756f 	strbtvc	r7, [lr], #-1391	; 0xfffffa91
    1058:	6c696600 	stclvs	6, cr6, [r9], #-0
    105c:	6d616e65 	stclvs	14, cr6, [r1, #-404]!	; 0xfffffe6c
    1060:	65720065 	ldrbvs	r0, [r2, #-101]!	; 0xffffff9b
    1064:	67006461 	strvs	r6, [r0, -r1, ror #8]
    1068:	69707465 	ldmdbvs	r0!, {r0, r2, r5, r6, sl, ip, sp, lr}^
    106c:	5a5f0064 	bpl	17c1204 <__bss_end+0x17b8218>
    1070:	65706f34 	ldrbvs	r6, [r0, #-3892]!	; 0xfffff0cc
    1074:	634b506e 	movtvs	r5, #45166	; 0xb06e
    1078:	464e3531 			; <UNDEFINED> instruction: 0x464e3531
    107c:	5f656c69 	svcpl	0x00656c69
    1080:	6e65704f 	cdpvs	0, 6, cr7, cr5, cr15, {2}
    1084:	646f4d5f 	strbtvs	r4, [pc], #-3423	; 108c <shift+0x108c>
    1088:	6e690065 	cdpvs	0, 6, cr0, cr9, cr5, {3}
    108c:	00747570 	rsbseq	r7, r4, r0, ror r5
    1090:	74736564 	ldrbtvc	r6, [r3], #-1380	; 0xfffffa9c
    1094:	657a6200 	ldrbvs	r6, [sl, #-512]!	; 0xfffffe00
    1098:	6c006f72 	stcvs	15, cr6, [r0], {114}	; 0x72
    109c:	74676e65 	strbtvc	r6, [r7], #-3685	; 0xfffff19b
    10a0:	5a5f0068 	bpl	17c1248 <__bss_end+0x17b825c>
    10a4:	657a6235 	ldrbvs	r6, [sl, #-565]!	; 0xfffffdcb
    10a8:	76506f72 	usub16vc	r6, r0, r2
    10ac:	552f0069 	strpl	r0, [pc, #-105]!	; 104b <shift+0x104b>
    10b0:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
    10b4:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
    10b8:	6a726574 	bvs	1c9a690 <__bss_end+0x1c916a4>
    10bc:	65442f69 	strbvs	r2, [r4, #-3945]	; 0xfffff097
    10c0:	6f746b73 	svcvs	0x00746b73
    10c4:	41462f70 	hvcmi	25328	; 0x62f0
    10c8:	614e2f56 	cmpvs	lr, r6, asr pc
    10cc:	757a6176 	ldrbvc	r6, [sl, #-374]!	; 0xfffffe8a
    10d0:	6963696a 	stmdbvs	r3!, {r1, r3, r5, r6, r8, fp, sp, lr}^
    10d4:	2f534f2f 	svccs	0x00534f2f
    10d8:	656d6573 	strbvs	r6, [sp, #-1395]!	; 0xfffffa8d
    10dc:	61727473 	cmnvs	r2, r3, ror r4
    10e0:	2d616b6c 	vstmdbcs	r1!, {d22-<overflow reg d75>}
    10e4:	2d76696b 			; <UNDEFINED> instruction: 0x2d76696b
    10e8:	732f736f 			; <UNDEFINED> instruction: 0x732f736f
    10ec:	6372756f 	cmnvs	r2, #465567744	; 0x1bc00000
    10f0:	732f7365 			; <UNDEFINED> instruction: 0x732f7365
    10f4:	696c6474 	stmdbvs	ip!, {r2, r4, r5, r6, sl, sp, lr}^
    10f8:	72732f62 	rsbsvc	r2, r3, #392	; 0x188
    10fc:	74732f63 	ldrbtvc	r2, [r3], #-3939	; 0xfffff09d
    1100:	72747364 	rsbsvc	r7, r4, #100, 6	; 0x90000001
    1104:	2e676e69 	cdpcs	14, 6, cr6, cr7, cr9, {3}
    1108:	00707063 	rsbseq	r7, r0, r3, rrx
    110c:	61345a5f 	teqvs	r4, pc, asr sl
    1110:	50696f74 	rsbpl	r6, r9, r4, ror pc
    1114:	4300634b 	movwmi	r6, #843	; 0x34b
    1118:	43726168 	cmnmi	r2, #104, 2
    111c:	41766e6f 	cmnmi	r6, pc, ror #28
    1120:	6d007272 	sfmvs	f7, 4, [r0, #-456]	; 0xfffffe38
    1124:	73646d65 	cmnvc	r4, #6464	; 0x1940
    1128:	756f0074 	strbvc	r0, [pc, #-116]!	; 10bc <shift+0x10bc>
    112c:	74757074 	ldrbtvc	r7, [r5], #-116	; 0xffffff8c
    1130:	365a5f00 	ldrbcc	r5, [sl], -r0, lsl #30
    1134:	636d656d 	cmnvs	sp, #457179136	; 0x1b400000
    1138:	4b507970 	blmi	141f700 <__bss_end+0x1416714>
    113c:	69765076 	ldmdbvs	r6!, {r1, r2, r4, r5, r6, ip, lr}^
    1140:	73616200 	cmnvc	r1, #0, 4
    1144:	656d0065 	strbvs	r0, [sp, #-101]!	; 0xffffff9b
    1148:	7970636d 	ldmdbvc	r0!, {r0, r2, r3, r5, r6, r8, r9, sp, lr}^
    114c:	72747300 	rsbsvc	r7, r4, #0, 6
    1150:	006e656c 	rsbeq	r6, lr, ip, ror #10
    1154:	73375a5f 	teqvc	r7, #389120	; 0x5f000
    1158:	636e7274 	cmnvs	lr, #116, 4	; 0x40000007
    115c:	4b50706d 	blmi	141d318 <__bss_end+0x141432c>
    1160:	5f305363 	svcpl	0x00305363
    1164:	5a5f0069 	bpl	17c1310 <__bss_end+0x17b8324>
    1168:	72747336 	rsbsvc	r7, r4, #-671088640	; 0xd8000000
    116c:	506e656c 	rsbpl	r6, lr, ip, ror #10
    1170:	6100634b 	tstvs	r0, fp, asr #6
    1174:	00696f74 	rsbeq	r6, r9, r4, ror pc
    1178:	73375a5f 	teqvc	r7, #389120	; 0x5f000
    117c:	636e7274 	cmnvs	lr, #116, 4	; 0x40000007
    1180:	63507970 	cmpvs	r0, #112, 18	; 0x1c0000
    1184:	69634b50 	stmdbvs	r3!, {r4, r6, r8, r9, fp, lr}^
    1188:	72747300 	rsbsvc	r7, r4, #0, 6
    118c:	706d636e 	rsbvc	r6, sp, lr, ror #6
    1190:	72747300 	rsbsvc	r7, r4, #0, 6
    1194:	7970636e 	ldmdbvc	r0!, {r1, r2, r3, r5, r6, r8, r9, sp, lr}^
    1198:	6d656d00 	stclvs	13, cr6, [r5, #-0]
    119c:	0079726f 	rsbseq	r7, r9, pc, ror #4
    11a0:	736d656d 	cmnvc	sp, #457179136	; 0x1b400000
    11a4:	69006372 	stmdbvs	r0, {r1, r4, r5, r6, r8, r9, sp, lr}
    11a8:	00616f74 	rsbeq	r6, r1, r4, ror pc
    11ac:	69345a5f 	ldmdbvs	r4!, {r0, r1, r2, r3, r4, r6, r9, fp, ip, lr}
    11b0:	6a616f74 	bvs	185cf88 <__bss_end+0x1853f9c>
    11b4:	006a6350 	rsbeq	r6, sl, r0, asr r3

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
  20:	8b040e42 	blhi	103930 <__bss_end+0xfa944>
  24:	0b0d4201 	bleq	350830 <__bss_end+0x347844>
  28:	420d0d62 	andmi	r0, sp, #6272	; 0x1880
  2c:	00000ecb 	andeq	r0, r0, fp, asr #29
  30:	0000001c 	andeq	r0, r0, ip, lsl r0
  34:	00000000 	andeq	r0, r0, r0
  38:	00008064 	andeq	r8, r0, r4, rrx
  3c:	00000040 	andeq	r0, r0, r0, asr #32
  40:	8b080e42 	blhi	203950 <__bss_end+0x1fa964>
  44:	42018e02 	andmi	r8, r1, #2, 28
  48:	5a040b0c 	bpl	102c80 <__bss_end+0xf9c94>
  4c:	00080d0c 	andeq	r0, r8, ip, lsl #26
  50:	0000000c 	andeq	r0, r0, ip
  54:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
  58:	7c020001 	stcvc	0, cr0, [r2], {1}
  5c:	000d0c0e 	andeq	r0, sp, lr, lsl #24
  60:	0000001c 	andeq	r0, r0, ip, lsl r0
  64:	00000050 	andeq	r0, r0, r0, asr r0
  68:	000080a4 	andeq	r8, r0, r4, lsr #1
  6c:	00000038 	andeq	r0, r0, r8, lsr r0
  70:	8b040e42 	blhi	103980 <__bss_end+0xfa994>
  74:	0b0d4201 	bleq	350880 <__bss_end+0x347894>
  78:	420d0d54 	andmi	r0, sp, #84, 26	; 0x1500
  7c:	00000ecb 	andeq	r0, r0, fp, asr #29
  80:	0000001c 	andeq	r0, r0, ip, lsl r0
  84:	00000050 	andeq	r0, r0, r0, asr r0
  88:	000080dc 	ldrdeq	r8, [r0], -ip
  8c:	0000002c 	andeq	r0, r0, ip, lsr #32
  90:	8b040e42 	blhi	1039a0 <__bss_end+0xfa9b4>
  94:	0b0d4201 	bleq	3508a0 <__bss_end+0x3478b4>
  98:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
  9c:	00000ecb 	andeq	r0, r0, fp, asr #29
  a0:	0000001c 	andeq	r0, r0, ip, lsl r0
  a4:	00000050 	andeq	r0, r0, r0, asr r0
  a8:	00008108 	andeq	r8, r0, r8, lsl #2
  ac:	00000020 	andeq	r0, r0, r0, lsr #32
  b0:	8b040e42 	blhi	1039c0 <__bss_end+0xfa9d4>
  b4:	0b0d4201 	bleq	3508c0 <__bss_end+0x3478d4>
  b8:	420d0d48 	andmi	r0, sp, #72, 26	; 0x1200
  bc:	00000ecb 	andeq	r0, r0, fp, asr #29
  c0:	0000001c 	andeq	r0, r0, ip, lsl r0
  c4:	00000050 	andeq	r0, r0, r0, asr r0
  c8:	00008128 	andeq	r8, r0, r8, lsr #2
  cc:	00000018 	andeq	r0, r0, r8, lsl r0
  d0:	8b040e42 	blhi	1039e0 <__bss_end+0xfa9f4>
  d4:	0b0d4201 	bleq	3508e0 <__bss_end+0x3478f4>
  d8:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
  dc:	00000ecb 	andeq	r0, r0, fp, asr #29
  e0:	0000001c 	andeq	r0, r0, ip, lsl r0
  e4:	00000050 	andeq	r0, r0, r0, asr r0
  e8:	00008140 	andeq	r8, r0, r0, asr #2
  ec:	00000018 	andeq	r0, r0, r8, lsl r0
  f0:	8b040e42 	blhi	103a00 <__bss_end+0xfaa14>
  f4:	0b0d4201 	bleq	350900 <__bss_end+0x347914>
  f8:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
  fc:	00000ecb 	andeq	r0, r0, fp, asr #29
 100:	0000001c 	andeq	r0, r0, ip, lsl r0
 104:	00000050 	andeq	r0, r0, r0, asr r0
 108:	00008158 	andeq	r8, r0, r8, asr r1
 10c:	00000018 	andeq	r0, r0, r8, lsl r0
 110:	8b040e42 	blhi	103a20 <__bss_end+0xfaa34>
 114:	0b0d4201 	bleq	350920 <__bss_end+0x347934>
 118:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
 11c:	00000ecb 	andeq	r0, r0, fp, asr #29
 120:	00000014 	andeq	r0, r0, r4, lsl r0
 124:	00000050 	andeq	r0, r0, r0, asr r0
 128:	00008170 	andeq	r8, r0, r0, ror r1
 12c:	0000000c 	andeq	r0, r0, ip
 130:	8b040e42 	blhi	103a40 <__bss_end+0xfaa54>
 134:	0b0d4201 	bleq	350940 <__bss_end+0x347954>
 138:	0000001c 	andeq	r0, r0, ip, lsl r0
 13c:	00000050 	andeq	r0, r0, r0, asr r0
 140:	0000817c 	andeq	r8, r0, ip, ror r1
 144:	00000058 	andeq	r0, r0, r8, asr r0
 148:	8b080e42 	blhi	203a58 <__bss_end+0x1faa6c>
 14c:	42018e02 	andmi	r8, r1, #2, 28
 150:	62040b0c 	andvs	r0, r4, #12, 22	; 0x3000
 154:	00080d0c 	andeq	r0, r8, ip, lsl #26
 158:	0000001c 	andeq	r0, r0, ip, lsl r0
 15c:	00000050 	andeq	r0, r0, r0, asr r0
 160:	000081d4 	ldrdeq	r8, [r0], -r4
 164:	00000058 	andeq	r0, r0, r8, asr r0
 168:	8b080e42 	blhi	203a78 <__bss_end+0x1faa8c>
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
 198:	8b080e42 	blhi	203aa8 <__bss_end+0x1faabc>
 19c:	42018e02 	andmi	r8, r1, #2, 28
 1a0:	74040b0c 	strvc	r0, [r4], #-2828	; 0xfffff4f4
 1a4:	00080d0c 	andeq	r0, r8, ip, lsl #26
 1a8:	00000018 	andeq	r0, r0, r8, lsl r0
 1ac:	00000178 	andeq	r0, r0, r8, ror r1
 1b0:	000082ac 	andeq	r8, r0, ip, lsr #5
 1b4:	00000128 	andeq	r0, r0, r8, lsr #2
 1b8:	8b080e42 	blhi	203ac8 <__bss_end+0x1faadc>
 1bc:	42018e02 	andmi	r8, r1, #2, 28
 1c0:	00040b0c 	andeq	r0, r4, ip, lsl #22
 1c4:	0000000c 	andeq	r0, r0, ip
 1c8:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 1cc:	7c020001 	stcvc	0, cr0, [r2], {1}
 1d0:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 1d4:	0000001c 	andeq	r0, r0, ip, lsl r0
 1d8:	000001c4 	andeq	r0, r0, r4, asr #3
 1dc:	000083d4 	ldrdeq	r8, [r0], -r4
 1e0:	0000002c 	andeq	r0, r0, ip, lsr #32
 1e4:	8b040e42 	blhi	103af4 <__bss_end+0xfab08>
 1e8:	0b0d4201 	bleq	3509f4 <__bss_end+0x347a08>
 1ec:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
 1f0:	00000ecb 	andeq	r0, r0, fp, asr #29
 1f4:	0000001c 	andeq	r0, r0, ip, lsl r0
 1f8:	000001c4 	andeq	r0, r0, r4, asr #3
 1fc:	00008400 	andeq	r8, r0, r0, lsl #8
 200:	0000002c 	andeq	r0, r0, ip, lsr #32
 204:	8b040e42 	blhi	103b14 <__bss_end+0xfab28>
 208:	0b0d4201 	bleq	350a14 <__bss_end+0x347a28>
 20c:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
 210:	00000ecb 	andeq	r0, r0, fp, asr #29
 214:	0000001c 	andeq	r0, r0, ip, lsl r0
 218:	000001c4 	andeq	r0, r0, r4, asr #3
 21c:	0000842c 	andeq	r8, r0, ip, lsr #8
 220:	0000001c 	andeq	r0, r0, ip, lsl r0
 224:	8b040e42 	blhi	103b34 <__bss_end+0xfab48>
 228:	0b0d4201 	bleq	350a34 <__bss_end+0x347a48>
 22c:	420d0d46 	andmi	r0, sp, #4480	; 0x1180
 230:	00000ecb 	andeq	r0, r0, fp, asr #29
 234:	0000001c 	andeq	r0, r0, ip, lsl r0
 238:	000001c4 	andeq	r0, r0, r4, asr #3
 23c:	00008448 	andeq	r8, r0, r8, asr #8
 240:	00000044 	andeq	r0, r0, r4, asr #32
 244:	8b040e42 	blhi	103b54 <__bss_end+0xfab68>
 248:	0b0d4201 	bleq	350a54 <__bss_end+0x347a68>
 24c:	420d0d5a 	andmi	r0, sp, #5760	; 0x1680
 250:	00000ecb 	andeq	r0, r0, fp, asr #29
 254:	0000001c 	andeq	r0, r0, ip, lsl r0
 258:	000001c4 	andeq	r0, r0, r4, asr #3
 25c:	0000848c 	andeq	r8, r0, ip, lsl #9
 260:	00000050 	andeq	r0, r0, r0, asr r0
 264:	8b040e42 	blhi	103b74 <__bss_end+0xfab88>
 268:	0b0d4201 	bleq	350a74 <__bss_end+0x347a88>
 26c:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 270:	00000ecb 	andeq	r0, r0, fp, asr #29
 274:	0000001c 	andeq	r0, r0, ip, lsl r0
 278:	000001c4 	andeq	r0, r0, r4, asr #3
 27c:	000084dc 	ldrdeq	r8, [r0], -ip
 280:	00000050 	andeq	r0, r0, r0, asr r0
 284:	8b040e42 	blhi	103b94 <__bss_end+0xfaba8>
 288:	0b0d4201 	bleq	350a94 <__bss_end+0x347aa8>
 28c:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 290:	00000ecb 	andeq	r0, r0, fp, asr #29
 294:	0000001c 	andeq	r0, r0, ip, lsl r0
 298:	000001c4 	andeq	r0, r0, r4, asr #3
 29c:	0000852c 	andeq	r8, r0, ip, lsr #10
 2a0:	0000002c 	andeq	r0, r0, ip, lsr #32
 2a4:	8b040e42 	blhi	103bb4 <__bss_end+0xfabc8>
 2a8:	0b0d4201 	bleq	350ab4 <__bss_end+0x347ac8>
 2ac:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
 2b0:	00000ecb 	andeq	r0, r0, fp, asr #29
 2b4:	0000001c 	andeq	r0, r0, ip, lsl r0
 2b8:	000001c4 	andeq	r0, r0, r4, asr #3
 2bc:	00008558 	andeq	r8, r0, r8, asr r5
 2c0:	00000050 	andeq	r0, r0, r0, asr r0
 2c4:	8b040e42 	blhi	103bd4 <__bss_end+0xfabe8>
 2c8:	0b0d4201 	bleq	350ad4 <__bss_end+0x347ae8>
 2cc:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 2d0:	00000ecb 	andeq	r0, r0, fp, asr #29
 2d4:	0000001c 	andeq	r0, r0, ip, lsl r0
 2d8:	000001c4 	andeq	r0, r0, r4, asr #3
 2dc:	000085a8 	andeq	r8, r0, r8, lsr #11
 2e0:	00000044 	andeq	r0, r0, r4, asr #32
 2e4:	8b040e42 	blhi	103bf4 <__bss_end+0xfac08>
 2e8:	0b0d4201 	bleq	350af4 <__bss_end+0x347b08>
 2ec:	420d0d5a 	andmi	r0, sp, #5760	; 0x1680
 2f0:	00000ecb 	andeq	r0, r0, fp, asr #29
 2f4:	0000001c 	andeq	r0, r0, ip, lsl r0
 2f8:	000001c4 	andeq	r0, r0, r4, asr #3
 2fc:	000085ec 	andeq	r8, r0, ip, ror #11
 300:	00000050 	andeq	r0, r0, r0, asr r0
 304:	8b040e42 	blhi	103c14 <__bss_end+0xfac28>
 308:	0b0d4201 	bleq	350b14 <__bss_end+0x347b28>
 30c:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 310:	00000ecb 	andeq	r0, r0, fp, asr #29
 314:	0000001c 	andeq	r0, r0, ip, lsl r0
 318:	000001c4 	andeq	r0, r0, r4, asr #3
 31c:	0000863c 	andeq	r8, r0, ip, lsr r6
 320:	00000054 	andeq	r0, r0, r4, asr r0
 324:	8b040e42 	blhi	103c34 <__bss_end+0xfac48>
 328:	0b0d4201 	bleq	350b34 <__bss_end+0x347b48>
 32c:	420d0d62 	andmi	r0, sp, #6272	; 0x1880
 330:	00000ecb 	andeq	r0, r0, fp, asr #29
 334:	0000001c 	andeq	r0, r0, ip, lsl r0
 338:	000001c4 	andeq	r0, r0, r4, asr #3
 33c:	00008690 	muleq	r0, r0, r6
 340:	0000003c 	andeq	r0, r0, ip, lsr r0
 344:	8b040e42 	blhi	103c54 <__bss_end+0xfac68>
 348:	0b0d4201 	bleq	350b54 <__bss_end+0x347b68>
 34c:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 350:	00000ecb 	andeq	r0, r0, fp, asr #29
 354:	0000001c 	andeq	r0, r0, ip, lsl r0
 358:	000001c4 	andeq	r0, r0, r4, asr #3
 35c:	000086cc 	andeq	r8, r0, ip, asr #13
 360:	0000003c 	andeq	r0, r0, ip, lsr r0
 364:	8b040e42 	blhi	103c74 <__bss_end+0xfac88>
 368:	0b0d4201 	bleq	350b74 <__bss_end+0x347b88>
 36c:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 370:	00000ecb 	andeq	r0, r0, fp, asr #29
 374:	0000001c 	andeq	r0, r0, ip, lsl r0
 378:	000001c4 	andeq	r0, r0, r4, asr #3
 37c:	00008708 	andeq	r8, r0, r8, lsl #14
 380:	0000003c 	andeq	r0, r0, ip, lsr r0
 384:	8b040e42 	blhi	103c94 <__bss_end+0xfaca8>
 388:	0b0d4201 	bleq	350b94 <__bss_end+0x347ba8>
 38c:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 390:	00000ecb 	andeq	r0, r0, fp, asr #29
 394:	0000001c 	andeq	r0, r0, ip, lsl r0
 398:	000001c4 	andeq	r0, r0, r4, asr #3
 39c:	00008744 	andeq	r8, r0, r4, asr #14
 3a0:	0000003c 	andeq	r0, r0, ip, lsr r0
 3a4:	8b040e42 	blhi	103cb4 <__bss_end+0xfacc8>
 3a8:	0b0d4201 	bleq	350bb4 <__bss_end+0x347bc8>
 3ac:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 3b0:	00000ecb 	andeq	r0, r0, fp, asr #29
 3b4:	0000001c 	andeq	r0, r0, ip, lsl r0
 3b8:	000001c4 	andeq	r0, r0, r4, asr #3
 3bc:	00008780 	andeq	r8, r0, r0, lsl #15
 3c0:	000000b0 	strheq	r0, [r0], -r0	; <UNPREDICTABLE>
 3c4:	8b080e42 	blhi	203cd4 <__bss_end+0x1face8>
 3c8:	42018e02 	andmi	r8, r1, #2, 28
 3cc:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 3d0:	080d0c50 	stmdaeq	sp, {r4, r6, sl, fp}
 3d4:	0000000c 	andeq	r0, r0, ip
 3d8:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 3dc:	7c020001 	stcvc	0, cr0, [r2], {1}
 3e0:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 3e4:	0000001c 	andeq	r0, r0, ip, lsl r0
 3e8:	000003d4 	ldrdeq	r0, [r0], -r4
 3ec:	00008830 	andeq	r8, r0, r0, lsr r8
 3f0:	00000174 	andeq	r0, r0, r4, ror r1
 3f4:	8b080e42 	blhi	203d04 <__bss_end+0x1fad18>
 3f8:	42018e02 	andmi	r8, r1, #2, 28
 3fc:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 400:	080d0cb2 	stmdaeq	sp, {r1, r4, r5, r7, sl, fp}
 404:	0000001c 	andeq	r0, r0, ip, lsl r0
 408:	000003d4 	ldrdeq	r0, [r0], -r4
 40c:	000089a4 	andeq	r8, r0, r4, lsr #19
 410:	0000009c 	muleq	r0, ip, r0
 414:	8b040e42 	blhi	103d24 <__bss_end+0xfad38>
 418:	0b0d4201 	bleq	350c24 <__bss_end+0x347c38>
 41c:	0d0d4602 	stceq	6, cr4, [sp, #-8]
 420:	000ecb42 	andeq	ip, lr, r2, asr #22
 424:	0000001c 	andeq	r0, r0, ip, lsl r0
 428:	000003d4 	ldrdeq	r0, [r0], -r4
 42c:	00008a40 	andeq	r8, r0, r0, asr #20
 430:	000000c0 	andeq	r0, r0, r0, asr #1
 434:	8b040e42 	blhi	103d44 <__bss_end+0xfad58>
 438:	0b0d4201 	bleq	350c44 <__bss_end+0x347c58>
 43c:	0d0d5802 	stceq	8, cr5, [sp, #-8]
 440:	000ecb42 	andeq	ip, lr, r2, asr #22
 444:	0000001c 	andeq	r0, r0, ip, lsl r0
 448:	000003d4 	ldrdeq	r0, [r0], -r4
 44c:	00008b00 	andeq	r8, r0, r0, lsl #22
 450:	000000ac 	andeq	r0, r0, ip, lsr #1
 454:	8b040e42 	blhi	103d64 <__bss_end+0xfad78>
 458:	0b0d4201 	bleq	350c64 <__bss_end+0x347c78>
 45c:	0d0d4e02 	stceq	14, cr4, [sp, #-8]
 460:	000ecb42 	andeq	ip, lr, r2, asr #22
 464:	0000001c 	andeq	r0, r0, ip, lsl r0
 468:	000003d4 	ldrdeq	r0, [r0], -r4
 46c:	00008bac 	andeq	r8, r0, ip, lsr #23
 470:	00000054 	andeq	r0, r0, r4, asr r0
 474:	8b040e42 	blhi	103d84 <__bss_end+0xfad98>
 478:	0b0d4201 	bleq	350c84 <__bss_end+0x347c98>
 47c:	420d0d62 	andmi	r0, sp, #6272	; 0x1880
 480:	00000ecb 	andeq	r0, r0, fp, asr #29
 484:	0000001c 	andeq	r0, r0, ip, lsl r0
 488:	000003d4 	ldrdeq	r0, [r0], -r4
 48c:	00008c00 	andeq	r8, r0, r0, lsl #24
 490:	00000068 	andeq	r0, r0, r8, rrx
 494:	8b040e42 	blhi	103da4 <__bss_end+0xfadb8>
 498:	0b0d4201 	bleq	350ca4 <__bss_end+0x347cb8>
 49c:	420d0d6c 	andmi	r0, sp, #108, 26	; 0x1b00
 4a0:	00000ecb 	andeq	r0, r0, fp, asr #29
 4a4:	0000001c 	andeq	r0, r0, ip, lsl r0
 4a8:	000003d4 	ldrdeq	r0, [r0], -r4
 4ac:	00008c68 	andeq	r8, r0, r8, ror #24
 4b0:	00000080 	andeq	r0, r0, r0, lsl #1
 4b4:	8b040e42 	blhi	103dc4 <__bss_end+0xfadd8>
 4b8:	0b0d4201 	bleq	350cc4 <__bss_end+0x347cd8>
 4bc:	420d0d78 	andmi	r0, sp, #120, 26	; 0x1e00
 4c0:	00000ecb 	andeq	r0, r0, fp, asr #29
 4c4:	0000000c 	andeq	r0, r0, ip
 4c8:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 4cc:	7c010001 	stcvc	0, cr0, [r1], {1}
 4d0:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 4d4:	0000000c 	andeq	r0, r0, ip
 4d8:	000004c4 	andeq	r0, r0, r4, asr #9
 4dc:	00008ce8 	andeq	r8, r0, r8, ror #25
 4e0:	000001ec 	andeq	r0, r0, ip, ror #3
