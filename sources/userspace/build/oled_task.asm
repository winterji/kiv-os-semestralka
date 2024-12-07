
./oled_task:     file format elf32-littlearm


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
    805c:	00009728 	andeq	r9, r0, r8, lsr #14
    8060:	00009738 	andeq	r9, r0, r8, lsr r7

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
    81cc:	00009714 	andeq	r9, r0, r4, lsl r7
    81d0:	00009714 	andeq	r9, r0, r4, lsl r7

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
    8224:	00009714 	andeq	r9, r0, r4, lsl r7
    8228:	00009714 	andeq	r9, r0, r4, lsl r7

0000822c <main>:
main():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/oled_task/main.cpp:27
	"My favourite sport is ARM wrestling",
	"Old MacDonald had a farm, EIGRP",
};

int main(int argc, char** argv)
{
    822c:	e92d4800 	push	{fp, lr}
    8230:	e28db004 	add	fp, sp, #4
    8234:	e24dd020 	sub	sp, sp, #32
    8238:	e50b0020 	str	r0, [fp, #-32]	; 0xffffffe0
    823c:	e50b1024 	str	r1, [fp, #-36]	; 0xffffffdc
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/oled_task/main.cpp:28
	COLED_Display disp("DEV:oled");
    8240:	e24b3014 	sub	r3, fp, #20
    8244:	e59f10d8 	ldr	r1, [pc, #216]	; 8324 <main+0xf8>
    8248:	e1a00003 	mov	r0, r3
    824c:	eb00027e 	bl	8c4c <_ZN13COLED_DisplayC1EPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/oled_task/main.cpp:29
	disp.Clear(false);
    8250:	e24b3014 	sub	r3, fp, #20
    8254:	e3a01000 	mov	r1, #0
    8258:	e1a00003 	mov	r0, r3
    825c:	eb0002b1 	bl	8d28 <_ZN13COLED_Display5ClearEb>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/oled_task/main.cpp:30
	disp.Put_String(10, 10, "KIV-RTOS init...");
    8260:	e24b0014 	sub	r0, fp, #20
    8264:	e59f30bc 	ldr	r3, [pc, #188]	; 8328 <main+0xfc>
    8268:	e3a0200a 	mov	r2, #10
    826c:	e3a0100a 	mov	r1, #10
    8270:	eb000376 	bl	9050 <_ZN13COLED_Display10Put_StringEttPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/oled_task/main.cpp:31
	disp.Flip();
    8274:	e24b3014 	sub	r3, fp, #20
    8278:	e1a00003 	mov	r0, r3
    827c:	eb00035d 	bl	8ff8 <_ZN13COLED_Display4FlipEv>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/oled_task/main.cpp:33

	uint32_t trng_file = open("DEV:trng", NFile_Open_Mode::Read_Only);
    8280:	e3a01000 	mov	r1, #0
    8284:	e59f00a0 	ldr	r0, [pc, #160]	; 832c <main+0x100>
    8288:	eb000047 	bl	83ac <_Z4openPKc15NFile_Open_Mode>
    828c:	e50b0008 	str	r0, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/oled_task/main.cpp:34
	uint32_t num = 0;
    8290:	e3a03000 	mov	r3, #0
    8294:	e50b3018 	str	r3, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/oled_task/main.cpp:36

	sleep(0x800, 0x800);
    8298:	e3a01b02 	mov	r1, #2048	; 0x800
    829c:	e3a00b02 	mov	r0, #2048	; 0x800
    82a0:	eb0000be 	bl	85a0 <_Z5sleepjj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/oled_task/main.cpp:41 (discriminator 1)

	while (true)
	{
		// ziskame si nahodne cislo a vybereme podle toho zpravu
		read(trng_file, reinterpret_cast<char*>(&num), sizeof(num));
    82a4:	e24b3018 	sub	r3, fp, #24
    82a8:	e3a02004 	mov	r2, #4
    82ac:	e1a01003 	mov	r1, r3
    82b0:	e51b0008 	ldr	r0, [fp, #-8]
    82b4:	eb00004d 	bl	83f0 <_Z4readjPcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/oled_task/main.cpp:42 (discriminator 1)
		const char* msg = messages[num % (sizeof(messages) / sizeof(const char*))];
    82b8:	e51b1018 	ldr	r1, [fp, #-24]	; 0xffffffe8
    82bc:	e59f306c 	ldr	r3, [pc, #108]	; 8330 <main+0x104>
    82c0:	e0832193 	umull	r2, r3, r3, r1
    82c4:	e1a02123 	lsr	r2, r3, #2
    82c8:	e1a03002 	mov	r3, r2
    82cc:	e1a03103 	lsl	r3, r3, #2
    82d0:	e0833002 	add	r3, r3, r2
    82d4:	e0412003 	sub	r2, r1, r3
    82d8:	e59f3054 	ldr	r3, [pc, #84]	; 8334 <main+0x108>
    82dc:	e7933102 	ldr	r3, [r3, r2, lsl #2]
    82e0:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/oled_task/main.cpp:44 (discriminator 1)

		disp.Clear(false);
    82e4:	e24b3014 	sub	r3, fp, #20
    82e8:	e3a01000 	mov	r1, #0
    82ec:	e1a00003 	mov	r0, r3
    82f0:	eb00028c 	bl	8d28 <_ZN13COLED_Display5ClearEb>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/oled_task/main.cpp:45 (discriminator 1)
		disp.Put_String(0, 0, msg);
    82f4:	e24b0014 	sub	r0, fp, #20
    82f8:	e51b300c 	ldr	r3, [fp, #-12]
    82fc:	e3a02000 	mov	r2, #0
    8300:	e3a01000 	mov	r1, #0
    8304:	eb000351 	bl	9050 <_ZN13COLED_Display10Put_StringEttPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/oled_task/main.cpp:46 (discriminator 1)
		disp.Flip();
    8308:	e24b3014 	sub	r3, fp, #20
    830c:	e1a00003 	mov	r0, r3
    8310:	eb000338 	bl	8ff8 <_ZN13COLED_Display4FlipEv>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/oled_task/main.cpp:48 (discriminator 1)

		sleep(0x4000, 0x800); // TODO: z tohohle bude casem cekani na podminkove promenne (na eventu) s timeoutem
    8314:	e3a01b02 	mov	r1, #2048	; 0x800
    8318:	e3a00901 	mov	r0, #16384	; 0x4000
    831c:	eb00009f 	bl	85a0 <_Z5sleepjj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/oled_task/main.cpp:49 (discriminator 1)
	}
    8320:	eaffffdf 	b	82a4 <main+0x78>
    8324:	000093f8 	strdeq	r9, [r0], -r8
    8328:	00009404 	andeq	r9, r0, r4, lsl #8
    832c:	00009418 	andeq	r9, r0, r8, lsl r4
    8330:	cccccccd 	stclgt	12, cr12, [ip], {205}	; 0xcd
    8334:	00009714 	andeq	r9, r0, r4, lsl r7

00008338 <_Z6getpidv>:
_Z6getpidv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:5
#include <stdfile.h>
#include <stdstring.h>

uint32_t getpid()
{
    8338:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    833c:	e28db000 	add	fp, sp, #0
    8340:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:8
    uint32_t pid;

    asm volatile("swi 0");
    8344:	ef000000 	svc	0x00000000
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:9
    asm volatile("mov %0, r0" : "=r" (pid));
    8348:	e1a03000 	mov	r3, r0
    834c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:11

    return pid;
    8350:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:12
}
    8354:	e1a00003 	mov	r0, r3
    8358:	e28bd000 	add	sp, fp, #0
    835c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8360:	e12fff1e 	bx	lr

00008364 <_Z9terminatei>:
_Z9terminatei():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:15

void terminate(int exitcode)
{
    8364:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8368:	e28db000 	add	fp, sp, #0
    836c:	e24dd00c 	sub	sp, sp, #12
    8370:	e50b0008 	str	r0, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:16
    asm volatile("mov r0, %0" : : "r" (exitcode));
    8374:	e51b3008 	ldr	r3, [fp, #-8]
    8378:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:17
    asm volatile("swi 1");
    837c:	ef000001 	svc	0x00000001
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:18
}
    8380:	e320f000 	nop	{0}
    8384:	e28bd000 	add	sp, fp, #0
    8388:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    838c:	e12fff1e 	bx	lr

00008390 <_Z11sched_yieldv>:
_Z11sched_yieldv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:21

void sched_yield()
{
    8390:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8394:	e28db000 	add	fp, sp, #0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:22
    asm volatile("swi 2");
    8398:	ef000002 	svc	0x00000002
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:23
}
    839c:	e320f000 	nop	{0}
    83a0:	e28bd000 	add	sp, fp, #0
    83a4:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    83a8:	e12fff1e 	bx	lr

000083ac <_Z4openPKc15NFile_Open_Mode>:
_Z4openPKc15NFile_Open_Mode():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:26

uint32_t open(const char* filename, NFile_Open_Mode mode)
{
    83ac:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    83b0:	e28db000 	add	fp, sp, #0
    83b4:	e24dd014 	sub	sp, sp, #20
    83b8:	e50b0010 	str	r0, [fp, #-16]
    83bc:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:29
    uint32_t file;

    asm volatile("mov r0, %0" : : "r" (filename));
    83c0:	e51b3010 	ldr	r3, [fp, #-16]
    83c4:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:30
    asm volatile("mov r1, %0" : : "r" (mode));
    83c8:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    83cc:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:31
    asm volatile("swi 64");
    83d0:	ef000040 	svc	0x00000040
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:32
    asm volatile("mov %0, r0" : "=r" (file));
    83d4:	e1a03000 	mov	r3, r0
    83d8:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:34

    return file;
    83dc:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:35
}
    83e0:	e1a00003 	mov	r0, r3
    83e4:	e28bd000 	add	sp, fp, #0
    83e8:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    83ec:	e12fff1e 	bx	lr

000083f0 <_Z4readjPcj>:
_Z4readjPcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:38

uint32_t read(uint32_t file, char* const buffer, uint32_t size)
{
    83f0:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    83f4:	e28db000 	add	fp, sp, #0
    83f8:	e24dd01c 	sub	sp, sp, #28
    83fc:	e50b0010 	str	r0, [fp, #-16]
    8400:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8404:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:41
    uint32_t rdnum;

    asm volatile("mov r0, %0" : : "r" (file));
    8408:	e51b3010 	ldr	r3, [fp, #-16]
    840c:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:42
    asm volatile("mov r1, %0" : : "r" (buffer));
    8410:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8414:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:43
    asm volatile("mov r2, %0" : : "r" (size));
    8418:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    841c:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:44
    asm volatile("swi 65");
    8420:	ef000041 	svc	0x00000041
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:45
    asm volatile("mov %0, r0" : "=r" (rdnum));
    8424:	e1a03000 	mov	r3, r0
    8428:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:47

    return rdnum;
    842c:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:48
}
    8430:	e1a00003 	mov	r0, r3
    8434:	e28bd000 	add	sp, fp, #0
    8438:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    843c:	e12fff1e 	bx	lr

00008440 <_Z5writejPKcj>:
_Z5writejPKcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:51

uint32_t write(uint32_t file, const char* buffer, uint32_t size)
{
    8440:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8444:	e28db000 	add	fp, sp, #0
    8448:	e24dd01c 	sub	sp, sp, #28
    844c:	e50b0010 	str	r0, [fp, #-16]
    8450:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8454:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:54
    uint32_t wrnum;

    asm volatile("mov r0, %0" : : "r" (file));
    8458:	e51b3010 	ldr	r3, [fp, #-16]
    845c:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:55
    asm volatile("mov r1, %0" : : "r" (buffer));
    8460:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8464:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:56
    asm volatile("mov r2, %0" : : "r" (size));
    8468:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    846c:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:57
    asm volatile("swi 66");
    8470:	ef000042 	svc	0x00000042
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:58
    asm volatile("mov %0, r0" : "=r" (wrnum));
    8474:	e1a03000 	mov	r3, r0
    8478:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:60

    return wrnum;
    847c:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:61
}
    8480:	e1a00003 	mov	r0, r3
    8484:	e28bd000 	add	sp, fp, #0
    8488:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    848c:	e12fff1e 	bx	lr

00008490 <_Z5closej>:
_Z5closej():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:64

void close(uint32_t file)
{
    8490:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8494:	e28db000 	add	fp, sp, #0
    8498:	e24dd00c 	sub	sp, sp, #12
    849c:	e50b0008 	str	r0, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:65
    asm volatile("mov r0, %0" : : "r" (file));
    84a0:	e51b3008 	ldr	r3, [fp, #-8]
    84a4:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:66
    asm volatile("swi 67");
    84a8:	ef000043 	svc	0x00000043
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:67
}
    84ac:	e320f000 	nop	{0}
    84b0:	e28bd000 	add	sp, fp, #0
    84b4:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    84b8:	e12fff1e 	bx	lr

000084bc <_Z5ioctlj16NIOCtl_OperationPv>:
_Z5ioctlj16NIOCtl_OperationPv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:70

uint32_t ioctl(uint32_t file, NIOCtl_Operation operation, void* param)
{
    84bc:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    84c0:	e28db000 	add	fp, sp, #0
    84c4:	e24dd01c 	sub	sp, sp, #28
    84c8:	e50b0010 	str	r0, [fp, #-16]
    84cc:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    84d0:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:73
    uint32_t retcode;

    asm volatile("mov r0, %0" : : "r" (file));
    84d4:	e51b3010 	ldr	r3, [fp, #-16]
    84d8:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:74
    asm volatile("mov r1, %0" : : "r" (operation));
    84dc:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    84e0:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:75
    asm volatile("mov r2, %0" : : "r" (param));
    84e4:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    84e8:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:76
    asm volatile("swi 68");
    84ec:	ef000044 	svc	0x00000044
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:77
    asm volatile("mov %0, r0" : "=r" (retcode));
    84f0:	e1a03000 	mov	r3, r0
    84f4:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:79

    return retcode;
    84f8:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:80
}
    84fc:	e1a00003 	mov	r0, r3
    8500:	e28bd000 	add	sp, fp, #0
    8504:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8508:	e12fff1e 	bx	lr

0000850c <_Z6notifyjj>:
_Z6notifyjj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:83

uint32_t notify(uint32_t file, uint32_t count)
{
    850c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8510:	e28db000 	add	fp, sp, #0
    8514:	e24dd014 	sub	sp, sp, #20
    8518:	e50b0010 	str	r0, [fp, #-16]
    851c:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:86
    uint32_t retcnt;

    asm volatile("mov r0, %0" : : "r" (file));
    8520:	e51b3010 	ldr	r3, [fp, #-16]
    8524:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:87
    asm volatile("mov r1, %0" : : "r" (count));
    8528:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    852c:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:88
    asm volatile("swi 69");
    8530:	ef000045 	svc	0x00000045
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:89
    asm volatile("mov %0, r0" : "=r" (retcnt));
    8534:	e1a03000 	mov	r3, r0
    8538:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:91

    return retcnt;
    853c:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:92
}
    8540:	e1a00003 	mov	r0, r3
    8544:	e28bd000 	add	sp, fp, #0
    8548:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    854c:	e12fff1e 	bx	lr

00008550 <_Z4waitjjj>:
_Z4waitjjj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:95

NSWI_Result_Code wait(uint32_t file, uint32_t count, uint32_t notified_deadline)
{
    8550:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8554:	e28db000 	add	fp, sp, #0
    8558:	e24dd01c 	sub	sp, sp, #28
    855c:	e50b0010 	str	r0, [fp, #-16]
    8560:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8564:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:98
    NSWI_Result_Code retcode;

    asm volatile("mov r0, %0" : : "r" (file));
    8568:	e51b3010 	ldr	r3, [fp, #-16]
    856c:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:99
    asm volatile("mov r1, %0" : : "r" (count));
    8570:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8574:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:100
    asm volatile("mov r2, %0" : : "r" (notified_deadline));
    8578:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    857c:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:101
    asm volatile("swi 70");
    8580:	ef000046 	svc	0x00000046
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:102
    asm volatile("mov %0, r0" : "=r" (retcode));
    8584:	e1a03000 	mov	r3, r0
    8588:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:104

    return retcode;
    858c:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:105
}
    8590:	e1a00003 	mov	r0, r3
    8594:	e28bd000 	add	sp, fp, #0
    8598:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    859c:	e12fff1e 	bx	lr

000085a0 <_Z5sleepjj>:
_Z5sleepjj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:108

bool sleep(uint32_t ticks, uint32_t notified_deadline)
{
    85a0:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    85a4:	e28db000 	add	fp, sp, #0
    85a8:	e24dd014 	sub	sp, sp, #20
    85ac:	e50b0010 	str	r0, [fp, #-16]
    85b0:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:111
    uint32_t retcode;

    asm volatile("mov r0, %0" : : "r" (ticks));
    85b4:	e51b3010 	ldr	r3, [fp, #-16]
    85b8:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:112
    asm volatile("mov r1, %0" : : "r" (notified_deadline));
    85bc:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    85c0:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:113
    asm volatile("swi 3");
    85c4:	ef000003 	svc	0x00000003
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:114
    asm volatile("mov %0, r0" : "=r" (retcode));
    85c8:	e1a03000 	mov	r3, r0
    85cc:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:116

    return retcode;
    85d0:	e51b3008 	ldr	r3, [fp, #-8]
    85d4:	e3530000 	cmp	r3, #0
    85d8:	13a03001 	movne	r3, #1
    85dc:	03a03000 	moveq	r3, #0
    85e0:	e6ef3073 	uxtb	r3, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:117
}
    85e4:	e1a00003 	mov	r0, r3
    85e8:	e28bd000 	add	sp, fp, #0
    85ec:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    85f0:	e12fff1e 	bx	lr

000085f4 <_Z24get_active_process_countv>:
_Z24get_active_process_countv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:120

uint32_t get_active_process_count()
{
    85f4:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    85f8:	e28db000 	add	fp, sp, #0
    85fc:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:121
    const NGet_Sched_Info_Type req = NGet_Sched_Info_Type::Active_Process_Count;
    8600:	e3a03000 	mov	r3, #0
    8604:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:124
    uint32_t retval;

    asm volatile("mov r0, %0" : : "r" (req));
    8608:	e3a03000 	mov	r3, #0
    860c:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:125
    asm volatile("mov r1, %0" : : "r" (&retval));
    8610:	e24b300c 	sub	r3, fp, #12
    8614:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:126
    asm volatile("swi 4");
    8618:	ef000004 	svc	0x00000004
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:128

    return retval;
    861c:	e51b300c 	ldr	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:129
}
    8620:	e1a00003 	mov	r0, r3
    8624:	e28bd000 	add	sp, fp, #0
    8628:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    862c:	e12fff1e 	bx	lr

00008630 <_Z14get_tick_countv>:
_Z14get_tick_countv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:132

uint32_t get_tick_count()
{
    8630:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8634:	e28db000 	add	fp, sp, #0
    8638:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:133
    const NGet_Sched_Info_Type req = NGet_Sched_Info_Type::Tick_Count;
    863c:	e3a03001 	mov	r3, #1
    8640:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:136
    uint32_t retval;

    asm volatile("mov r0, %0" : : "r" (req));
    8644:	e3a03001 	mov	r3, #1
    8648:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:137
    asm volatile("mov r1, %0" : : "r" (&retval));
    864c:	e24b300c 	sub	r3, fp, #12
    8650:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:138
    asm volatile("swi 4");
    8654:	ef000004 	svc	0x00000004
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:140

    return retval;
    8658:	e51b300c 	ldr	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:141
}
    865c:	e1a00003 	mov	r0, r3
    8660:	e28bd000 	add	sp, fp, #0
    8664:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8668:	e12fff1e 	bx	lr

0000866c <_Z17set_task_deadlinej>:
_Z17set_task_deadlinej():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:144

void set_task_deadline(uint32_t tick_count_required)
{
    866c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8670:	e28db000 	add	fp, sp, #0
    8674:	e24dd014 	sub	sp, sp, #20
    8678:	e50b0010 	str	r0, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:145
    const NDeadline_Subservice req = NDeadline_Subservice::Set_Relative;
    867c:	e3a03000 	mov	r3, #0
    8680:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:147

    asm volatile("mov r0, %0" : : "r" (req));
    8684:	e3a03000 	mov	r3, #0
    8688:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:148
    asm volatile("mov r1, %0" : : "r" (&tick_count_required));
    868c:	e24b3010 	sub	r3, fp, #16
    8690:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:149
    asm volatile("swi 5");
    8694:	ef000005 	svc	0x00000005
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:150
}
    8698:	e320f000 	nop	{0}
    869c:	e28bd000 	add	sp, fp, #0
    86a0:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    86a4:	e12fff1e 	bx	lr

000086a8 <_Z26get_task_ticks_to_deadlinev>:
_Z26get_task_ticks_to_deadlinev():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:153

uint32_t get_task_ticks_to_deadline()
{
    86a8:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    86ac:	e28db000 	add	fp, sp, #0
    86b0:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:154
    const NDeadline_Subservice req = NDeadline_Subservice::Get_Remaining;
    86b4:	e3a03001 	mov	r3, #1
    86b8:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:157
    uint32_t ticks;

    asm volatile("mov r0, %0" : : "r" (req));
    86bc:	e3a03001 	mov	r3, #1
    86c0:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:158
    asm volatile("mov r1, %0" : : "r" (&ticks));
    86c4:	e24b300c 	sub	r3, fp, #12
    86c8:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:159
    asm volatile("swi 5");
    86cc:	ef000005 	svc	0x00000005
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:161

    return ticks;
    86d0:	e51b300c 	ldr	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:162
}
    86d4:	e1a00003 	mov	r0, r3
    86d8:	e28bd000 	add	sp, fp, #0
    86dc:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    86e0:	e12fff1e 	bx	lr

000086e4 <_Z4pipePKcj>:
_Z4pipePKcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:167

const char Pipe_File_Prefix[] = "SYS:pipe/";

uint32_t pipe(const char* name, uint32_t buf_size)
{
    86e4:	e92d4800 	push	{fp, lr}
    86e8:	e28db004 	add	fp, sp, #4
    86ec:	e24dd050 	sub	sp, sp, #80	; 0x50
    86f0:	e50b0050 	str	r0, [fp, #-80]	; 0xffffffb0
    86f4:	e50b1054 	str	r1, [fp, #-84]	; 0xffffffac
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:169
    char fname[64];
    strncpy(fname, Pipe_File_Prefix, sizeof(Pipe_File_Prefix));
    86f8:	e24b3048 	sub	r3, fp, #72	; 0x48
    86fc:	e3a0200a 	mov	r2, #10
    8700:	e59f1088 	ldr	r1, [pc, #136]	; 8790 <_Z4pipePKcj+0xac>
    8704:	e1a00003 	mov	r0, r3
    8708:	eb0000a5 	bl	89a4 <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:170
    strncpy(fname + sizeof(Pipe_File_Prefix), name, sizeof(fname) - sizeof(Pipe_File_Prefix) - 1);
    870c:	e24b3048 	sub	r3, fp, #72	; 0x48
    8710:	e283300a 	add	r3, r3, #10
    8714:	e3a02035 	mov	r2, #53	; 0x35
    8718:	e51b1050 	ldr	r1, [fp, #-80]	; 0xffffffb0
    871c:	e1a00003 	mov	r0, r3
    8720:	eb00009f 	bl	89a4 <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:172

    int ncur = sizeof(Pipe_File_Prefix) + strlen(name);
    8724:	e51b0050 	ldr	r0, [fp, #-80]	; 0xffffffb0
    8728:	eb0000f8 	bl	8b10 <_Z6strlenPKc>
    872c:	e1a03000 	mov	r3, r0
    8730:	e283300a 	add	r3, r3, #10
    8734:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:174

    fname[ncur++] = '#';
    8738:	e51b3008 	ldr	r3, [fp, #-8]
    873c:	e2832001 	add	r2, r3, #1
    8740:	e50b2008 	str	r2, [fp, #-8]
    8744:	e2433004 	sub	r3, r3, #4
    8748:	e083300b 	add	r3, r3, fp
    874c:	e3a02023 	mov	r2, #35	; 0x23
    8750:	e5432044 	strb	r2, [r3, #-68]	; 0xffffffbc
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:176

    itoa(buf_size, &fname[ncur], 10);
    8754:	e24b2048 	sub	r2, fp, #72	; 0x48
    8758:	e51b3008 	ldr	r3, [fp, #-8]
    875c:	e0823003 	add	r3, r2, r3
    8760:	e3a0200a 	mov	r2, #10
    8764:	e1a01003 	mov	r1, r3
    8768:	e51b0054 	ldr	r0, [fp, #-84]	; 0xffffffac
    876c:	eb000008 	bl	8794 <_Z4itoajPcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:178

    return open(fname, NFile_Open_Mode::Read_Write);
    8770:	e24b3048 	sub	r3, fp, #72	; 0x48
    8774:	e3a01002 	mov	r1, #2
    8778:	e1a00003 	mov	r0, r3
    877c:	ebffff0a 	bl	83ac <_Z4openPKc15NFile_Open_Mode>
    8780:	e1a03000 	mov	r3, r0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:179
}
    8784:	e1a00003 	mov	r0, r3
    8788:	e24bd004 	sub	sp, fp, #4
    878c:	e8bd8800 	pop	{fp, pc}
    8790:	00009450 	andeq	r9, r0, r0, asr r4

00008794 <_Z4itoajPcj>:
_Z4itoajPcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:9
{
    const char CharConvArr[] = "0123456789ABCDEF";
}

void itoa(unsigned int input, char* output, unsigned int base)
{
    8794:	e92d4800 	push	{fp, lr}
    8798:	e28db004 	add	fp, sp, #4
    879c:	e24dd020 	sub	sp, sp, #32
    87a0:	e50b0018 	str	r0, [fp, #-24]	; 0xffffffe8
    87a4:	e50b101c 	str	r1, [fp, #-28]	; 0xffffffe4
    87a8:	e50b2020 	str	r2, [fp, #-32]	; 0xffffffe0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:10
	int i = 0;
    87ac:	e3a03000 	mov	r3, #0
    87b0:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:12

	while (input > 0)
    87b4:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    87b8:	e3530000 	cmp	r3, #0
    87bc:	0a000014 	beq	8814 <_Z4itoajPcj+0x80>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:14
	{
		output[i] = CharConvArr[input % base];
    87c0:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    87c4:	e51b1020 	ldr	r1, [fp, #-32]	; 0xffffffe0
    87c8:	e1a00003 	mov	r0, r3
    87cc:	eb0002c6 	bl	92ec <__aeabi_uidivmod>
    87d0:	e1a03001 	mov	r3, r1
    87d4:	e1a01003 	mov	r1, r3
    87d8:	e51b3008 	ldr	r3, [fp, #-8]
    87dc:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    87e0:	e0823003 	add	r3, r2, r3
    87e4:	e59f2118 	ldr	r2, [pc, #280]	; 8904 <_Z4itoajPcj+0x170>
    87e8:	e7d22001 	ldrb	r2, [r2, r1]
    87ec:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:15
		input /= base;
    87f0:	e51b1020 	ldr	r1, [fp, #-32]	; 0xffffffe0
    87f4:	e51b0018 	ldr	r0, [fp, #-24]	; 0xffffffe8
    87f8:	eb000240 	bl	9100 <__udivsi3>
    87fc:	e1a03000 	mov	r3, r0
    8800:	e50b3018 	str	r3, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:16
		i++;
    8804:	e51b3008 	ldr	r3, [fp, #-8]
    8808:	e2833001 	add	r3, r3, #1
    880c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:12
	while (input > 0)
    8810:	eaffffe7 	b	87b4 <_Z4itoajPcj+0x20>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:19
	}

    if (i == 0)
    8814:	e51b3008 	ldr	r3, [fp, #-8]
    8818:	e3530000 	cmp	r3, #0
    881c:	1a000007 	bne	8840 <_Z4itoajPcj+0xac>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:21
    {
        output[i] = CharConvArr[0];
    8820:	e51b3008 	ldr	r3, [fp, #-8]
    8824:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    8828:	e0823003 	add	r3, r2, r3
    882c:	e3a02030 	mov	r2, #48	; 0x30
    8830:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:22
        i++;
    8834:	e51b3008 	ldr	r3, [fp, #-8]
    8838:	e2833001 	add	r3, r3, #1
    883c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:25
    }

	output[i] = '\0';
    8840:	e51b3008 	ldr	r3, [fp, #-8]
    8844:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    8848:	e0823003 	add	r3, r2, r3
    884c:	e3a02000 	mov	r2, #0
    8850:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:26
	i--;
    8854:	e51b3008 	ldr	r3, [fp, #-8]
    8858:	e2433001 	sub	r3, r3, #1
    885c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:28

	for (int j = 0; j <= i/2; j++)
    8860:	e3a03000 	mov	r3, #0
    8864:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:28 (discriminator 3)
    8868:	e51b3008 	ldr	r3, [fp, #-8]
    886c:	e1a02fa3 	lsr	r2, r3, #31
    8870:	e0823003 	add	r3, r2, r3
    8874:	e1a030c3 	asr	r3, r3, #1
    8878:	e1a02003 	mov	r2, r3
    887c:	e51b300c 	ldr	r3, [fp, #-12]
    8880:	e1530002 	cmp	r3, r2
    8884:	ca00001b 	bgt	88f8 <_Z4itoajPcj+0x164>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:30 (discriminator 2)
	{
		char c = output[i - j];
    8888:	e51b2008 	ldr	r2, [fp, #-8]
    888c:	e51b300c 	ldr	r3, [fp, #-12]
    8890:	e0423003 	sub	r3, r2, r3
    8894:	e1a02003 	mov	r2, r3
    8898:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    889c:	e0833002 	add	r3, r3, r2
    88a0:	e5d33000 	ldrb	r3, [r3]
    88a4:	e54b300d 	strb	r3, [fp, #-13]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:31 (discriminator 2)
		output[i - j] = output[j];
    88a8:	e51b300c 	ldr	r3, [fp, #-12]
    88ac:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    88b0:	e0822003 	add	r2, r2, r3
    88b4:	e51b1008 	ldr	r1, [fp, #-8]
    88b8:	e51b300c 	ldr	r3, [fp, #-12]
    88bc:	e0413003 	sub	r3, r1, r3
    88c0:	e1a01003 	mov	r1, r3
    88c4:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    88c8:	e0833001 	add	r3, r3, r1
    88cc:	e5d22000 	ldrb	r2, [r2]
    88d0:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:32 (discriminator 2)
		output[j] = c;
    88d4:	e51b300c 	ldr	r3, [fp, #-12]
    88d8:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    88dc:	e0823003 	add	r3, r2, r3
    88e0:	e55b200d 	ldrb	r2, [fp, #-13]
    88e4:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:28 (discriminator 2)
	for (int j = 0; j <= i/2; j++)
    88e8:	e51b300c 	ldr	r3, [fp, #-12]
    88ec:	e2833001 	add	r3, r3, #1
    88f0:	e50b300c 	str	r3, [fp, #-12]
    88f4:	eaffffdb 	b	8868 <_Z4itoajPcj+0xd4>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:34
	}
}
    88f8:	e320f000 	nop	{0}
    88fc:	e24bd004 	sub	sp, fp, #4
    8900:	e8bd8800 	pop	{fp, pc}
    8904:	0000945c 	andeq	r9, r0, ip, asr r4

00008908 <_Z4atoiPKc>:
_Z4atoiPKc():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:37

int atoi(const char* input)
{
    8908:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    890c:	e28db000 	add	fp, sp, #0
    8910:	e24dd014 	sub	sp, sp, #20
    8914:	e50b0010 	str	r0, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:38
	int output = 0;
    8918:	e3a03000 	mov	r3, #0
    891c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:40

	while (*input != '\0')
    8920:	e51b3010 	ldr	r3, [fp, #-16]
    8924:	e5d33000 	ldrb	r3, [r3]
    8928:	e3530000 	cmp	r3, #0
    892c:	0a000017 	beq	8990 <_Z4atoiPKc+0x88>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:42
	{
		output *= 10;
    8930:	e51b2008 	ldr	r2, [fp, #-8]
    8934:	e1a03002 	mov	r3, r2
    8938:	e1a03103 	lsl	r3, r3, #2
    893c:	e0833002 	add	r3, r3, r2
    8940:	e1a03083 	lsl	r3, r3, #1
    8944:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:43
		if (*input > '9' || *input < '0')
    8948:	e51b3010 	ldr	r3, [fp, #-16]
    894c:	e5d33000 	ldrb	r3, [r3]
    8950:	e3530039 	cmp	r3, #57	; 0x39
    8954:	8a00000d 	bhi	8990 <_Z4atoiPKc+0x88>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:43 (discriminator 1)
    8958:	e51b3010 	ldr	r3, [fp, #-16]
    895c:	e5d33000 	ldrb	r3, [r3]
    8960:	e353002f 	cmp	r3, #47	; 0x2f
    8964:	9a000009 	bls	8990 <_Z4atoiPKc+0x88>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:46
			break;

		output += *input - '0';
    8968:	e51b3010 	ldr	r3, [fp, #-16]
    896c:	e5d33000 	ldrb	r3, [r3]
    8970:	e2433030 	sub	r3, r3, #48	; 0x30
    8974:	e51b2008 	ldr	r2, [fp, #-8]
    8978:	e0823003 	add	r3, r2, r3
    897c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:48

		input++;
    8980:	e51b3010 	ldr	r3, [fp, #-16]
    8984:	e2833001 	add	r3, r3, #1
    8988:	e50b3010 	str	r3, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:40
	while (*input != '\0')
    898c:	eaffffe3 	b	8920 <_Z4atoiPKc+0x18>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:51
	}

	return output;
    8990:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:52
}
    8994:	e1a00003 	mov	r0, r3
    8998:	e28bd000 	add	sp, fp, #0
    899c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    89a0:	e12fff1e 	bx	lr

000089a4 <_Z7strncpyPcPKci>:
_Z7strncpyPcPKci():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:55

char* strncpy(char* dest, const char *src, int num)
{
    89a4:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    89a8:	e28db000 	add	fp, sp, #0
    89ac:	e24dd01c 	sub	sp, sp, #28
    89b0:	e50b0010 	str	r0, [fp, #-16]
    89b4:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    89b8:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:58
	int i;

	for (i = 0; i < num && src[i] != '\0'; i++)
    89bc:	e3a03000 	mov	r3, #0
    89c0:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:58 (discriminator 4)
    89c4:	e51b2008 	ldr	r2, [fp, #-8]
    89c8:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    89cc:	e1520003 	cmp	r2, r3
    89d0:	aa000011 	bge	8a1c <_Z7strncpyPcPKci+0x78>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:58 (discriminator 2)
    89d4:	e51b3008 	ldr	r3, [fp, #-8]
    89d8:	e51b2014 	ldr	r2, [fp, #-20]	; 0xffffffec
    89dc:	e0823003 	add	r3, r2, r3
    89e0:	e5d33000 	ldrb	r3, [r3]
    89e4:	e3530000 	cmp	r3, #0
    89e8:	0a00000b 	beq	8a1c <_Z7strncpyPcPKci+0x78>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:59 (discriminator 3)
		dest[i] = src[i];
    89ec:	e51b3008 	ldr	r3, [fp, #-8]
    89f0:	e51b2014 	ldr	r2, [fp, #-20]	; 0xffffffec
    89f4:	e0822003 	add	r2, r2, r3
    89f8:	e51b3008 	ldr	r3, [fp, #-8]
    89fc:	e51b1010 	ldr	r1, [fp, #-16]
    8a00:	e0813003 	add	r3, r1, r3
    8a04:	e5d22000 	ldrb	r2, [r2]
    8a08:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:58 (discriminator 3)
	for (i = 0; i < num && src[i] != '\0'; i++)
    8a0c:	e51b3008 	ldr	r3, [fp, #-8]
    8a10:	e2833001 	add	r3, r3, #1
    8a14:	e50b3008 	str	r3, [fp, #-8]
    8a18:	eaffffe9 	b	89c4 <_Z7strncpyPcPKci+0x20>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:60 (discriminator 2)
	for (; i < num; i++)
    8a1c:	e51b2008 	ldr	r2, [fp, #-8]
    8a20:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8a24:	e1520003 	cmp	r2, r3
    8a28:	aa000008 	bge	8a50 <_Z7strncpyPcPKci+0xac>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:61 (discriminator 1)
		dest[i] = '\0';
    8a2c:	e51b3008 	ldr	r3, [fp, #-8]
    8a30:	e51b2010 	ldr	r2, [fp, #-16]
    8a34:	e0823003 	add	r3, r2, r3
    8a38:	e3a02000 	mov	r2, #0
    8a3c:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:60 (discriminator 1)
	for (; i < num; i++)
    8a40:	e51b3008 	ldr	r3, [fp, #-8]
    8a44:	e2833001 	add	r3, r3, #1
    8a48:	e50b3008 	str	r3, [fp, #-8]
    8a4c:	eafffff2 	b	8a1c <_Z7strncpyPcPKci+0x78>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:63

   return dest;
    8a50:	e51b3010 	ldr	r3, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:64
}
    8a54:	e1a00003 	mov	r0, r3
    8a58:	e28bd000 	add	sp, fp, #0
    8a5c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8a60:	e12fff1e 	bx	lr

00008a64 <_Z7strncmpPKcS0_i>:
_Z7strncmpPKcS0_i():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:67

int strncmp(const char *s1, const char *s2, int num)
{
    8a64:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8a68:	e28db000 	add	fp, sp, #0
    8a6c:	e24dd01c 	sub	sp, sp, #28
    8a70:	e50b0010 	str	r0, [fp, #-16]
    8a74:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8a78:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:69
	unsigned char u1, u2;
  	while (num-- > 0)
    8a7c:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8a80:	e2432001 	sub	r2, r3, #1
    8a84:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
    8a88:	e3530000 	cmp	r3, #0
    8a8c:	c3a03001 	movgt	r3, #1
    8a90:	d3a03000 	movle	r3, #0
    8a94:	e6ef3073 	uxtb	r3, r3
    8a98:	e3530000 	cmp	r3, #0
    8a9c:	0a000016 	beq	8afc <_Z7strncmpPKcS0_i+0x98>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:71
    {
      	u1 = (unsigned char) *s1++;
    8aa0:	e51b3010 	ldr	r3, [fp, #-16]
    8aa4:	e2832001 	add	r2, r3, #1
    8aa8:	e50b2010 	str	r2, [fp, #-16]
    8aac:	e5d33000 	ldrb	r3, [r3]
    8ab0:	e54b3005 	strb	r3, [fp, #-5]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:72
     	u2 = (unsigned char) *s2++;
    8ab4:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8ab8:	e2832001 	add	r2, r3, #1
    8abc:	e50b2014 	str	r2, [fp, #-20]	; 0xffffffec
    8ac0:	e5d33000 	ldrb	r3, [r3]
    8ac4:	e54b3006 	strb	r3, [fp, #-6]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:73
      	if (u1 != u2)
    8ac8:	e55b2005 	ldrb	r2, [fp, #-5]
    8acc:	e55b3006 	ldrb	r3, [fp, #-6]
    8ad0:	e1520003 	cmp	r2, r3
    8ad4:	0a000003 	beq	8ae8 <_Z7strncmpPKcS0_i+0x84>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:74
        	return u1 - u2;
    8ad8:	e55b2005 	ldrb	r2, [fp, #-5]
    8adc:	e55b3006 	ldrb	r3, [fp, #-6]
    8ae0:	e0423003 	sub	r3, r2, r3
    8ae4:	ea000005 	b	8b00 <_Z7strncmpPKcS0_i+0x9c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:75
      	if (u1 == '\0')
    8ae8:	e55b3005 	ldrb	r3, [fp, #-5]
    8aec:	e3530000 	cmp	r3, #0
    8af0:	1affffe1 	bne	8a7c <_Z7strncmpPKcS0_i+0x18>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:76
        	return 0;
    8af4:	e3a03000 	mov	r3, #0
    8af8:	ea000000 	b	8b00 <_Z7strncmpPKcS0_i+0x9c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:79
    }

  	return 0;
    8afc:	e3a03000 	mov	r3, #0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:80
}
    8b00:	e1a00003 	mov	r0, r3
    8b04:	e28bd000 	add	sp, fp, #0
    8b08:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8b0c:	e12fff1e 	bx	lr

00008b10 <_Z6strlenPKc>:
_Z6strlenPKc():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:83

int strlen(const char* s)
{
    8b10:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8b14:	e28db000 	add	fp, sp, #0
    8b18:	e24dd014 	sub	sp, sp, #20
    8b1c:	e50b0010 	str	r0, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:84
	int i = 0;
    8b20:	e3a03000 	mov	r3, #0
    8b24:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:86

	while (s[i] != '\0')
    8b28:	e51b3008 	ldr	r3, [fp, #-8]
    8b2c:	e51b2010 	ldr	r2, [fp, #-16]
    8b30:	e0823003 	add	r3, r2, r3
    8b34:	e5d33000 	ldrb	r3, [r3]
    8b38:	e3530000 	cmp	r3, #0
    8b3c:	0a000003 	beq	8b50 <_Z6strlenPKc+0x40>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:87
		i++;
    8b40:	e51b3008 	ldr	r3, [fp, #-8]
    8b44:	e2833001 	add	r3, r3, #1
    8b48:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:86
	while (s[i] != '\0')
    8b4c:	eafffff5 	b	8b28 <_Z6strlenPKc+0x18>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:89

	return i;
    8b50:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:90
}
    8b54:	e1a00003 	mov	r0, r3
    8b58:	e28bd000 	add	sp, fp, #0
    8b5c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8b60:	e12fff1e 	bx	lr

00008b64 <_Z5bzeroPvi>:
_Z5bzeroPvi():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:93

void bzero(void* memory, int length)
{
    8b64:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8b68:	e28db000 	add	fp, sp, #0
    8b6c:	e24dd014 	sub	sp, sp, #20
    8b70:	e50b0010 	str	r0, [fp, #-16]
    8b74:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:94
	char* mem = reinterpret_cast<char*>(memory);
    8b78:	e51b3010 	ldr	r3, [fp, #-16]
    8b7c:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:96

	for (int i = 0; i < length; i++)
    8b80:	e3a03000 	mov	r3, #0
    8b84:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:96 (discriminator 3)
    8b88:	e51b2008 	ldr	r2, [fp, #-8]
    8b8c:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8b90:	e1520003 	cmp	r2, r3
    8b94:	aa000008 	bge	8bbc <_Z5bzeroPvi+0x58>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:97 (discriminator 2)
		mem[i] = 0;
    8b98:	e51b3008 	ldr	r3, [fp, #-8]
    8b9c:	e51b200c 	ldr	r2, [fp, #-12]
    8ba0:	e0823003 	add	r3, r2, r3
    8ba4:	e3a02000 	mov	r2, #0
    8ba8:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:96 (discriminator 2)
	for (int i = 0; i < length; i++)
    8bac:	e51b3008 	ldr	r3, [fp, #-8]
    8bb0:	e2833001 	add	r3, r3, #1
    8bb4:	e50b3008 	str	r3, [fp, #-8]
    8bb8:	eafffff2 	b	8b88 <_Z5bzeroPvi+0x24>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:98
}
    8bbc:	e320f000 	nop	{0}
    8bc0:	e28bd000 	add	sp, fp, #0
    8bc4:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8bc8:	e12fff1e 	bx	lr

00008bcc <_Z6memcpyPKvPvi>:
_Z6memcpyPKvPvi():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:101

void memcpy(const void* src, void* dst, int num)
{
    8bcc:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8bd0:	e28db000 	add	fp, sp, #0
    8bd4:	e24dd024 	sub	sp, sp, #36	; 0x24
    8bd8:	e50b0018 	str	r0, [fp, #-24]	; 0xffffffe8
    8bdc:	e50b101c 	str	r1, [fp, #-28]	; 0xffffffe4
    8be0:	e50b2020 	str	r2, [fp, #-32]	; 0xffffffe0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:102
	const char* memsrc = reinterpret_cast<const char*>(src);
    8be4:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8be8:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:103
	char* memdst = reinterpret_cast<char*>(dst);
    8bec:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    8bf0:	e50b3010 	str	r3, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:105

	for (int i = 0; i < num; i++)
    8bf4:	e3a03000 	mov	r3, #0
    8bf8:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:105 (discriminator 3)
    8bfc:	e51b2008 	ldr	r2, [fp, #-8]
    8c00:	e51b3020 	ldr	r3, [fp, #-32]	; 0xffffffe0
    8c04:	e1520003 	cmp	r2, r3
    8c08:	aa00000b 	bge	8c3c <_Z6memcpyPKvPvi+0x70>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:106 (discriminator 2)
		memdst[i] = memsrc[i];
    8c0c:	e51b3008 	ldr	r3, [fp, #-8]
    8c10:	e51b200c 	ldr	r2, [fp, #-12]
    8c14:	e0822003 	add	r2, r2, r3
    8c18:	e51b3008 	ldr	r3, [fp, #-8]
    8c1c:	e51b1010 	ldr	r1, [fp, #-16]
    8c20:	e0813003 	add	r3, r1, r3
    8c24:	e5d22000 	ldrb	r2, [r2]
    8c28:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:105 (discriminator 2)
	for (int i = 0; i < num; i++)
    8c2c:	e51b3008 	ldr	r3, [fp, #-8]
    8c30:	e2833001 	add	r3, r3, #1
    8c34:	e50b3008 	str	r3, [fp, #-8]
    8c38:	eaffffef 	b	8bfc <_Z6memcpyPKvPvi+0x30>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:107
}
    8c3c:	e320f000 	nop	{0}
    8c40:	e28bd000 	add	sp, fp, #0
    8c44:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8c48:	e12fff1e 	bx	lr

00008c4c <_ZN13COLED_DisplayC1EPKc>:
_ZN13COLED_DisplayC2EPKc():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:10
#include <drivers/bridges/display_protocol.h>

// tento soubor includujeme jen odtud
#include "oled_font.h"

COLED_Display::COLED_Display(const char* path)
    8c4c:	e92d4800 	push	{fp, lr}
    8c50:	e28db004 	add	fp, sp, #4
    8c54:	e24dd008 	sub	sp, sp, #8
    8c58:	e50b0008 	str	r0, [fp, #-8]
    8c5c:	e50b100c 	str	r1, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:11
    : mHandle{ open(path, NFile_Open_Mode::Write_Only) }, mOpened(false)
    8c60:	e3a01001 	mov	r1, #1
    8c64:	e51b000c 	ldr	r0, [fp, #-12]
    8c68:	ebfffdcf 	bl	83ac <_Z4openPKc15NFile_Open_Mode>
    8c6c:	e1a02000 	mov	r2, r0
    8c70:	e51b3008 	ldr	r3, [fp, #-8]
    8c74:	e5832000 	str	r2, [r3]
    8c78:	e51b3008 	ldr	r3, [fp, #-8]
    8c7c:	e3a02000 	mov	r2, #0
    8c80:	e5c32004 	strb	r2, [r3, #4]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:14
{
    // nastavime priznak dle toho, co vrati open
    mOpened = (mHandle != static_cast<uint32_t>(-1));
    8c84:	e51b3008 	ldr	r3, [fp, #-8]
    8c88:	e5933000 	ldr	r3, [r3]
    8c8c:	e3730001 	cmn	r3, #1
    8c90:	13a03001 	movne	r3, #1
    8c94:	03a03000 	moveq	r3, #0
    8c98:	e6ef2073 	uxtb	r2, r3
    8c9c:	e51b3008 	ldr	r3, [fp, #-8]
    8ca0:	e5c32004 	strb	r2, [r3, #4]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:15
}
    8ca4:	e51b3008 	ldr	r3, [fp, #-8]
    8ca8:	e1a00003 	mov	r0, r3
    8cac:	e24bd004 	sub	sp, fp, #4
    8cb0:	e8bd8800 	pop	{fp, pc}

00008cb4 <_ZN13COLED_DisplayD1Ev>:
_ZN13COLED_DisplayD2Ev():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:17

COLED_Display::~COLED_Display()
    8cb4:	e92d4800 	push	{fp, lr}
    8cb8:	e28db004 	add	fp, sp, #4
    8cbc:	e24dd008 	sub	sp, sp, #8
    8cc0:	e50b0008 	str	r0, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:20
{
    // pokud byl displej otevreny, zavreme
    if (mOpened)
    8cc4:	e51b3008 	ldr	r3, [fp, #-8]
    8cc8:	e5d33004 	ldrb	r3, [r3, #4]
    8ccc:	e3530000 	cmp	r3, #0
    8cd0:	0a000006 	beq	8cf0 <_ZN13COLED_DisplayD1Ev+0x3c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:22
    {
        mOpened = false;
    8cd4:	e51b3008 	ldr	r3, [fp, #-8]
    8cd8:	e3a02000 	mov	r2, #0
    8cdc:	e5c32004 	strb	r2, [r3, #4]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:23
        close(mHandle);
    8ce0:	e51b3008 	ldr	r3, [fp, #-8]
    8ce4:	e5933000 	ldr	r3, [r3]
    8ce8:	e1a00003 	mov	r0, r3
    8cec:	ebfffde7 	bl	8490 <_Z5closej>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:25
    }
}
    8cf0:	e51b3008 	ldr	r3, [fp, #-8]
    8cf4:	e1a00003 	mov	r0, r3
    8cf8:	e24bd004 	sub	sp, fp, #4
    8cfc:	e8bd8800 	pop	{fp, pc}

00008d00 <_ZNK13COLED_Display9Is_OpenedEv>:
_ZNK13COLED_Display9Is_OpenedEv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:28

bool COLED_Display::Is_Opened() const
{
    8d00:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8d04:	e28db000 	add	fp, sp, #0
    8d08:	e24dd00c 	sub	sp, sp, #12
    8d0c:	e50b0008 	str	r0, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:29
    return mOpened;
    8d10:	e51b3008 	ldr	r3, [fp, #-8]
    8d14:	e5d33004 	ldrb	r3, [r3, #4]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:30
}
    8d18:	e1a00003 	mov	r0, r3
    8d1c:	e28bd000 	add	sp, fp, #0
    8d20:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8d24:	e12fff1e 	bx	lr

00008d28 <_ZN13COLED_Display5ClearEb>:
_ZN13COLED_Display5ClearEb():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:33

void COLED_Display::Clear(bool clearSet)
{
    8d28:	e92d4800 	push	{fp, lr}
    8d2c:	e28db004 	add	fp, sp, #4
    8d30:	e24dd010 	sub	sp, sp, #16
    8d34:	e50b0010 	str	r0, [fp, #-16]
    8d38:	e1a03001 	mov	r3, r1
    8d3c:	e54b3011 	strb	r3, [fp, #-17]	; 0xffffffef
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:34
    if (!mOpened)
    8d40:	e51b3010 	ldr	r3, [fp, #-16]
    8d44:	e5d33004 	ldrb	r3, [r3, #4]
    8d48:	e2233001 	eor	r3, r3, #1
    8d4c:	e6ef3073 	uxtb	r3, r3
    8d50:	e3530000 	cmp	r3, #0
    8d54:	1a00000f 	bne	8d98 <_ZN13COLED_Display5ClearEb+0x70>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:38
        return;

    TDisplay_Clear_Packet pkt;
	pkt.header.cmd = NDisplay_Command::Clear;
    8d58:	e3a03002 	mov	r3, #2
    8d5c:	e54b3008 	strb	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:39
	pkt.clearSet = clearSet ? 1 : 0;
    8d60:	e55b3011 	ldrb	r3, [fp, #-17]	; 0xffffffef
    8d64:	e3530000 	cmp	r3, #0
    8d68:	0a000001 	beq	8d74 <_ZN13COLED_Display5ClearEb+0x4c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:39 (discriminator 1)
    8d6c:	e3a03001 	mov	r3, #1
    8d70:	ea000000 	b	8d78 <_ZN13COLED_Display5ClearEb+0x50>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:39 (discriminator 2)
    8d74:	e3a03000 	mov	r3, #0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:39 (discriminator 4)
    8d78:	e54b3007 	strb	r3, [fp, #-7]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:40 (discriminator 4)
	write(mHandle, reinterpret_cast<char*>(&pkt), sizeof(pkt));
    8d7c:	e51b3010 	ldr	r3, [fp, #-16]
    8d80:	e5933000 	ldr	r3, [r3]
    8d84:	e24b1008 	sub	r1, fp, #8
    8d88:	e3a02002 	mov	r2, #2
    8d8c:	e1a00003 	mov	r0, r3
    8d90:	ebfffdaa 	bl	8440 <_Z5writejPKcj>
    8d94:	ea000000 	b	8d9c <_ZN13COLED_Display5ClearEb+0x74>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:35
        return;
    8d98:	e320f000 	nop	{0}
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:41
}
    8d9c:	e24bd004 	sub	sp, fp, #4
    8da0:	e8bd8800 	pop	{fp, pc}

00008da4 <_ZN13COLED_Display9Set_PixelEttb>:
_ZN13COLED_Display9Set_PixelEttb():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:44

void COLED_Display::Set_Pixel(uint16_t x, uint16_t y, bool set)
{
    8da4:	e92d4800 	push	{fp, lr}
    8da8:	e28db004 	add	fp, sp, #4
    8dac:	e24dd018 	sub	sp, sp, #24
    8db0:	e50b0010 	str	r0, [fp, #-16]
    8db4:	e1a00001 	mov	r0, r1
    8db8:	e1a01002 	mov	r1, r2
    8dbc:	e1a02003 	mov	r2, r3
    8dc0:	e1a03000 	mov	r3, r0
    8dc4:	e14b31b2 	strh	r3, [fp, #-18]	; 0xffffffee
    8dc8:	e1a03001 	mov	r3, r1
    8dcc:	e14b31b4 	strh	r3, [fp, #-20]	; 0xffffffec
    8dd0:	e1a03002 	mov	r3, r2
    8dd4:	e54b3015 	strb	r3, [fp, #-21]	; 0xffffffeb
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:45
    if (!mOpened)
    8dd8:	e51b3010 	ldr	r3, [fp, #-16]
    8ddc:	e5d33004 	ldrb	r3, [r3, #4]
    8de0:	e2233001 	eor	r3, r3, #1
    8de4:	e6ef3073 	uxtb	r3, r3
    8de8:	e3530000 	cmp	r3, #0
    8dec:	1a000024 	bne	8e84 <_ZN13COLED_Display9Set_PixelEttb+0xe0>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:50
        return;

    // nehospodarny zpusob, jak nastavit pixely, ale pro ted staci
    TDisplay_Draw_Pixel_Array_Packet pkt;
    pkt.header.cmd = NDisplay_Command::Draw_Pixel_Array;
    8df0:	e3a03003 	mov	r3, #3
    8df4:	e54b300c 	strb	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:51
    pkt.count = 1;
    8df8:	e3a03000 	mov	r3, #0
    8dfc:	e3833001 	orr	r3, r3, #1
    8e00:	e54b300b 	strb	r3, [fp, #-11]
    8e04:	e3a03000 	mov	r3, #0
    8e08:	e54b300a 	strb	r3, [fp, #-10]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:52
    pkt.first.x = x;
    8e0c:	e55b3012 	ldrb	r3, [fp, #-18]	; 0xffffffee
    8e10:	e3a02000 	mov	r2, #0
    8e14:	e1823003 	orr	r3, r2, r3
    8e18:	e54b3009 	strb	r3, [fp, #-9]
    8e1c:	e55b3011 	ldrb	r3, [fp, #-17]	; 0xffffffef
    8e20:	e3a02000 	mov	r2, #0
    8e24:	e1823003 	orr	r3, r2, r3
    8e28:	e54b3008 	strb	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:53
    pkt.first.y = y;
    8e2c:	e55b3014 	ldrb	r3, [fp, #-20]	; 0xffffffec
    8e30:	e3a02000 	mov	r2, #0
    8e34:	e1823003 	orr	r3, r2, r3
    8e38:	e54b3007 	strb	r3, [fp, #-7]
    8e3c:	e55b3013 	ldrb	r3, [fp, #-19]	; 0xffffffed
    8e40:	e3a02000 	mov	r2, #0
    8e44:	e1823003 	orr	r3, r2, r3
    8e48:	e54b3006 	strb	r3, [fp, #-6]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:54
    pkt.first.set = set ? 1 : 0;
    8e4c:	e55b3015 	ldrb	r3, [fp, #-21]	; 0xffffffeb
    8e50:	e3530000 	cmp	r3, #0
    8e54:	0a000001 	beq	8e60 <_ZN13COLED_Display9Set_PixelEttb+0xbc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:54 (discriminator 1)
    8e58:	e3a03001 	mov	r3, #1
    8e5c:	ea000000 	b	8e64 <_ZN13COLED_Display9Set_PixelEttb+0xc0>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:54 (discriminator 2)
    8e60:	e3a03000 	mov	r3, #0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:54 (discriminator 4)
    8e64:	e54b3005 	strb	r3, [fp, #-5]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:55 (discriminator 4)
    write(mHandle, reinterpret_cast<char*>(&pkt), sizeof(pkt));
    8e68:	e51b3010 	ldr	r3, [fp, #-16]
    8e6c:	e5933000 	ldr	r3, [r3]
    8e70:	e24b100c 	sub	r1, fp, #12
    8e74:	e3a02008 	mov	r2, #8
    8e78:	e1a00003 	mov	r0, r3
    8e7c:	ebfffd6f 	bl	8440 <_Z5writejPKcj>
    8e80:	ea000000 	b	8e88 <_ZN13COLED_Display9Set_PixelEttb+0xe4>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:46
        return;
    8e84:	e320f000 	nop	{0}
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:56
}
    8e88:	e24bd004 	sub	sp, fp, #4
    8e8c:	e8bd8800 	pop	{fp, pc}

00008e90 <_ZN13COLED_Display8Put_CharEttc>:
_ZN13COLED_Display8Put_CharEttc():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:59

void COLED_Display::Put_Char(uint16_t x, uint16_t y, char c)
{
    8e90:	e92d4800 	push	{fp, lr}
    8e94:	e28db004 	add	fp, sp, #4
    8e98:	e24dd028 	sub	sp, sp, #40	; 0x28
    8e9c:	e50b0020 	str	r0, [fp, #-32]	; 0xffffffe0
    8ea0:	e1a00001 	mov	r0, r1
    8ea4:	e1a01002 	mov	r1, r2
    8ea8:	e1a02003 	mov	r2, r3
    8eac:	e1a03000 	mov	r3, r0
    8eb0:	e14b32b2 	strh	r3, [fp, #-34]	; 0xffffffde
    8eb4:	e1a03001 	mov	r3, r1
    8eb8:	e14b32b4 	strh	r3, [fp, #-36]	; 0xffffffdc
    8ebc:	e1a03002 	mov	r3, r2
    8ec0:	e54b3025 	strb	r3, [fp, #-37]	; 0xffffffdb
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:60
    if (!mOpened)
    8ec4:	e51b3020 	ldr	r3, [fp, #-32]	; 0xffffffe0
    8ec8:	e5d33004 	ldrb	r3, [r3, #4]
    8ecc:	e2233001 	eor	r3, r3, #1
    8ed0:	e6ef3073 	uxtb	r3, r3
    8ed4:	e3530000 	cmp	r3, #0
    8ed8:	1a000040 	bne	8fe0 <_ZN13COLED_Display8Put_CharEttc+0x150>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:64
        return;

    // umime jen nektere znaky
    if (c < OLED_Font::Char_Begin || c >= OLED_Font::Char_End)
    8edc:	e55b3025 	ldrb	r3, [fp, #-37]	; 0xffffffdb
    8ee0:	e353001f 	cmp	r3, #31
    8ee4:	9a00003f 	bls	8fe8 <_ZN13COLED_Display8Put_CharEttc+0x158>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:64 (discriminator 1)
    8ee8:	e15b32d5 	ldrsb	r3, [fp, #-37]	; 0xffffffdb
    8eec:	e3530000 	cmp	r3, #0
    8ef0:	ba00003c 	blt	8fe8 <_ZN13COLED_Display8Put_CharEttc+0x158>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:69
        return;

    char buf[sizeof(TDisplay_Pixels_To_Rect) + OLED_Font::Char_Width];

    TDisplay_Pixels_To_Rect* ptr = reinterpret_cast<TDisplay_Pixels_To_Rect*>(buf);
    8ef4:	e24b301c 	sub	r3, fp, #28
    8ef8:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:70
    ptr->header.cmd = NDisplay_Command::Draw_Pixel_Array_To_Rect;
    8efc:	e51b3008 	ldr	r3, [fp, #-8]
    8f00:	e3a02004 	mov	r2, #4
    8f04:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:71
    ptr->w = OLED_Font::Char_Width;
    8f08:	e51b3008 	ldr	r3, [fp, #-8]
    8f0c:	e3a02000 	mov	r2, #0
    8f10:	e3822006 	orr	r2, r2, #6
    8f14:	e5c32005 	strb	r2, [r3, #5]
    8f18:	e3a02000 	mov	r2, #0
    8f1c:	e5c32006 	strb	r2, [r3, #6]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:72
    ptr->h = OLED_Font::Char_Height;
    8f20:	e51b3008 	ldr	r3, [fp, #-8]
    8f24:	e3a02000 	mov	r2, #0
    8f28:	e3822008 	orr	r2, r2, #8
    8f2c:	e5c32007 	strb	r2, [r3, #7]
    8f30:	e3a02000 	mov	r2, #0
    8f34:	e5c32008 	strb	r2, [r3, #8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:73
    ptr->x1 = x;
    8f38:	e51b3008 	ldr	r3, [fp, #-8]
    8f3c:	e55b2022 	ldrb	r2, [fp, #-34]	; 0xffffffde
    8f40:	e3a01000 	mov	r1, #0
    8f44:	e1812002 	orr	r2, r1, r2
    8f48:	e5c32001 	strb	r2, [r3, #1]
    8f4c:	e55b2021 	ldrb	r2, [fp, #-33]	; 0xffffffdf
    8f50:	e3a01000 	mov	r1, #0
    8f54:	e1812002 	orr	r2, r1, r2
    8f58:	e5c32002 	strb	r2, [r3, #2]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:74
    ptr->y1 = y;
    8f5c:	e51b3008 	ldr	r3, [fp, #-8]
    8f60:	e55b2024 	ldrb	r2, [fp, #-36]	; 0xffffffdc
    8f64:	e3a01000 	mov	r1, #0
    8f68:	e1812002 	orr	r2, r1, r2
    8f6c:	e5c32003 	strb	r2, [r3, #3]
    8f70:	e55b2023 	ldrb	r2, [fp, #-35]	; 0xffffffdd
    8f74:	e3a01000 	mov	r1, #0
    8f78:	e1812002 	orr	r2, r1, r2
    8f7c:	e5c32004 	strb	r2, [r3, #4]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:75
    ptr->vflip = OLED_Font::Flip_Chars ? 1 : 0;
    8f80:	e51b3008 	ldr	r3, [fp, #-8]
    8f84:	e3a02001 	mov	r2, #1
    8f88:	e5c32009 	strb	r2, [r3, #9]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:77
    
    memcpy(&OLED_Font::OLED_Font_Default[OLED_Font::Char_Width * (((uint16_t)c) - OLED_Font::Char_Begin)], &ptr->first, OLED_Font::Char_Width);
    8f8c:	e55b3025 	ldrb	r3, [fp, #-37]	; 0xffffffdb
    8f90:	e2432020 	sub	r2, r3, #32
    8f94:	e1a03002 	mov	r3, r2
    8f98:	e1a03083 	lsl	r3, r3, #1
    8f9c:	e0833002 	add	r3, r3, r2
    8fa0:	e1a03083 	lsl	r3, r3, #1
    8fa4:	e1a02003 	mov	r2, r3
    8fa8:	e59f3044 	ldr	r3, [pc, #68]	; 8ff4 <_ZN13COLED_Display8Put_CharEttc+0x164>
    8fac:	e0820003 	add	r0, r2, r3
    8fb0:	e51b3008 	ldr	r3, [fp, #-8]
    8fb4:	e283300a 	add	r3, r3, #10
    8fb8:	e3a02006 	mov	r2, #6
    8fbc:	e1a01003 	mov	r1, r3
    8fc0:	ebffff01 	bl	8bcc <_Z6memcpyPKvPvi>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:79

    write(mHandle, buf, sizeof(buf));
    8fc4:	e51b3020 	ldr	r3, [fp, #-32]	; 0xffffffe0
    8fc8:	e5933000 	ldr	r3, [r3]
    8fcc:	e24b101c 	sub	r1, fp, #28
    8fd0:	e3a02011 	mov	r2, #17
    8fd4:	e1a00003 	mov	r0, r3
    8fd8:	ebfffd18 	bl	8440 <_Z5writejPKcj>
    8fdc:	ea000002 	b	8fec <_ZN13COLED_Display8Put_CharEttc+0x15c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:61
        return;
    8fe0:	e320f000 	nop	{0}
    8fe4:	ea000000 	b	8fec <_ZN13COLED_Display8Put_CharEttc+0x15c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:65
        return;
    8fe8:	e320f000 	nop	{0}
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:80
}
    8fec:	e24bd004 	sub	sp, fp, #4
    8ff0:	e8bd8800 	pop	{fp, pc}
    8ff4:	000094d4 	ldrdeq	r9, [r0], -r4

00008ff8 <_ZN13COLED_Display4FlipEv>:
_ZN13COLED_Display4FlipEv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:83

void COLED_Display::Flip()
{
    8ff8:	e92d4800 	push	{fp, lr}
    8ffc:	e28db004 	add	fp, sp, #4
    9000:	e24dd010 	sub	sp, sp, #16
    9004:	e50b0010 	str	r0, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:84
    if (!mOpened)
    9008:	e51b3010 	ldr	r3, [fp, #-16]
    900c:	e5d33004 	ldrb	r3, [r3, #4]
    9010:	e2233001 	eor	r3, r3, #1
    9014:	e6ef3073 	uxtb	r3, r3
    9018:	e3530000 	cmp	r3, #0
    901c:	1a000008 	bne	9044 <_ZN13COLED_Display4FlipEv+0x4c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:88
        return;

    TDisplay_NonParametric_Packet pkt;
    pkt.header.cmd = NDisplay_Command::Flip;
    9020:	e3a03001 	mov	r3, #1
    9024:	e54b3008 	strb	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:90

    write(mHandle, reinterpret_cast<char*>(&pkt), sizeof(pkt));
    9028:	e51b3010 	ldr	r3, [fp, #-16]
    902c:	e5933000 	ldr	r3, [r3]
    9030:	e24b1008 	sub	r1, fp, #8
    9034:	e3a02001 	mov	r2, #1
    9038:	e1a00003 	mov	r0, r3
    903c:	ebfffcff 	bl	8440 <_Z5writejPKcj>
    9040:	ea000000 	b	9048 <_ZN13COLED_Display4FlipEv+0x50>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:85
        return;
    9044:	e320f000 	nop	{0}
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:91
}
    9048:	e24bd004 	sub	sp, fp, #4
    904c:	e8bd8800 	pop	{fp, pc}

00009050 <_ZN13COLED_Display10Put_StringEttPKc>:
_ZN13COLED_Display10Put_StringEttPKc():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:94

void COLED_Display::Put_String(uint16_t x, uint16_t y, const char* str)
{
    9050:	e92d4800 	push	{fp, lr}
    9054:	e28db004 	add	fp, sp, #4
    9058:	e24dd018 	sub	sp, sp, #24
    905c:	e50b0010 	str	r0, [fp, #-16]
    9060:	e50b3018 	str	r3, [fp, #-24]	; 0xffffffe8
    9064:	e1a03001 	mov	r3, r1
    9068:	e14b31b2 	strh	r3, [fp, #-18]	; 0xffffffee
    906c:	e1a03002 	mov	r3, r2
    9070:	e14b31b4 	strh	r3, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:95
    if (!mOpened)
    9074:	e51b3010 	ldr	r3, [fp, #-16]
    9078:	e5d33004 	ldrb	r3, [r3, #4]
    907c:	e2233001 	eor	r3, r3, #1
    9080:	e6ef3073 	uxtb	r3, r3
    9084:	e3530000 	cmp	r3, #0
    9088:	1a000019 	bne	90f4 <_ZN13COLED_Display10Put_StringEttPKc+0xa4>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:98
        return;

    uint16_t xi = x;
    908c:	e15b31b2 	ldrh	r3, [fp, #-18]	; 0xffffffee
    9090:	e14b30b6 	strh	r3, [fp, #-6]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:99
    const char* ptr = str;
    9094:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    9098:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:101
    // dokud nedojdeme na konec retezce nebo dokud nejsme 64 znaku daleko (limit, kdyby nahodou se neco pokazilo)
    while (*ptr != '\0' && ptr - str < 64)
    909c:	e51b300c 	ldr	r3, [fp, #-12]
    90a0:	e5d33000 	ldrb	r3, [r3]
    90a4:	e3530000 	cmp	r3, #0
    90a8:	0a000012 	beq	90f8 <_ZN13COLED_Display10Put_StringEttPKc+0xa8>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:101 (discriminator 1)
    90ac:	e51b200c 	ldr	r2, [fp, #-12]
    90b0:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    90b4:	e0423003 	sub	r3, r2, r3
    90b8:	e353003f 	cmp	r3, #63	; 0x3f
    90bc:	ca00000d 	bgt	90f8 <_ZN13COLED_Display10Put_StringEttPKc+0xa8>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:103
    {
        Put_Char(xi, y, *ptr);
    90c0:	e51b300c 	ldr	r3, [fp, #-12]
    90c4:	e5d33000 	ldrb	r3, [r3]
    90c8:	e15b21b4 	ldrh	r2, [fp, #-20]	; 0xffffffec
    90cc:	e15b10b6 	ldrh	r1, [fp, #-6]
    90d0:	e51b0010 	ldr	r0, [fp, #-16]
    90d4:	ebffff6d 	bl	8e90 <_ZN13COLED_Display8Put_CharEttc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:104
        xi += OLED_Font::Char_Width;
    90d8:	e15b30b6 	ldrh	r3, [fp, #-6]
    90dc:	e2833006 	add	r3, r3, #6
    90e0:	e14b30b6 	strh	r3, [fp, #-6]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:105
        ptr++;
    90e4:	e51b300c 	ldr	r3, [fp, #-12]
    90e8:	e2833001 	add	r3, r3, #1
    90ec:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:101
    while (*ptr != '\0' && ptr - str < 64)
    90f0:	eaffffe9 	b	909c <_ZN13COLED_Display10Put_StringEttPKc+0x4c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:96
        return;
    90f4:	e320f000 	nop	{0}
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdutils/src/oled.cpp:107
    }
}
    90f8:	e24bd004 	sub	sp, fp, #4
    90fc:	e8bd8800 	pop	{fp, pc}

00009100 <__udivsi3>:
__udivsi3():
    9100:	e2512001 	subs	r2, r1, #1
    9104:	012fff1e 	bxeq	lr
    9108:	3a000074 	bcc	92e0 <__udivsi3+0x1e0>
    910c:	e1500001 	cmp	r0, r1
    9110:	9a00006b 	bls	92c4 <__udivsi3+0x1c4>
    9114:	e1110002 	tst	r1, r2
    9118:	0a00006c 	beq	92d0 <__udivsi3+0x1d0>
    911c:	e16f3f10 	clz	r3, r0
    9120:	e16f2f11 	clz	r2, r1
    9124:	e0423003 	sub	r3, r2, r3
    9128:	e273301f 	rsbs	r3, r3, #31
    912c:	10833083 	addne	r3, r3, r3, lsl #1
    9130:	e3a02000 	mov	r2, #0
    9134:	108ff103 	addne	pc, pc, r3, lsl #2
    9138:	e1a00000 	nop			; (mov r0, r0)
    913c:	e1500f81 	cmp	r0, r1, lsl #31
    9140:	e0a22002 	adc	r2, r2, r2
    9144:	20400f81 	subcs	r0, r0, r1, lsl #31
    9148:	e1500f01 	cmp	r0, r1, lsl #30
    914c:	e0a22002 	adc	r2, r2, r2
    9150:	20400f01 	subcs	r0, r0, r1, lsl #30
    9154:	e1500e81 	cmp	r0, r1, lsl #29
    9158:	e0a22002 	adc	r2, r2, r2
    915c:	20400e81 	subcs	r0, r0, r1, lsl #29
    9160:	e1500e01 	cmp	r0, r1, lsl #28
    9164:	e0a22002 	adc	r2, r2, r2
    9168:	20400e01 	subcs	r0, r0, r1, lsl #28
    916c:	e1500d81 	cmp	r0, r1, lsl #27
    9170:	e0a22002 	adc	r2, r2, r2
    9174:	20400d81 	subcs	r0, r0, r1, lsl #27
    9178:	e1500d01 	cmp	r0, r1, lsl #26
    917c:	e0a22002 	adc	r2, r2, r2
    9180:	20400d01 	subcs	r0, r0, r1, lsl #26
    9184:	e1500c81 	cmp	r0, r1, lsl #25
    9188:	e0a22002 	adc	r2, r2, r2
    918c:	20400c81 	subcs	r0, r0, r1, lsl #25
    9190:	e1500c01 	cmp	r0, r1, lsl #24
    9194:	e0a22002 	adc	r2, r2, r2
    9198:	20400c01 	subcs	r0, r0, r1, lsl #24
    919c:	e1500b81 	cmp	r0, r1, lsl #23
    91a0:	e0a22002 	adc	r2, r2, r2
    91a4:	20400b81 	subcs	r0, r0, r1, lsl #23
    91a8:	e1500b01 	cmp	r0, r1, lsl #22
    91ac:	e0a22002 	adc	r2, r2, r2
    91b0:	20400b01 	subcs	r0, r0, r1, lsl #22
    91b4:	e1500a81 	cmp	r0, r1, lsl #21
    91b8:	e0a22002 	adc	r2, r2, r2
    91bc:	20400a81 	subcs	r0, r0, r1, lsl #21
    91c0:	e1500a01 	cmp	r0, r1, lsl #20
    91c4:	e0a22002 	adc	r2, r2, r2
    91c8:	20400a01 	subcs	r0, r0, r1, lsl #20
    91cc:	e1500981 	cmp	r0, r1, lsl #19
    91d0:	e0a22002 	adc	r2, r2, r2
    91d4:	20400981 	subcs	r0, r0, r1, lsl #19
    91d8:	e1500901 	cmp	r0, r1, lsl #18
    91dc:	e0a22002 	adc	r2, r2, r2
    91e0:	20400901 	subcs	r0, r0, r1, lsl #18
    91e4:	e1500881 	cmp	r0, r1, lsl #17
    91e8:	e0a22002 	adc	r2, r2, r2
    91ec:	20400881 	subcs	r0, r0, r1, lsl #17
    91f0:	e1500801 	cmp	r0, r1, lsl #16
    91f4:	e0a22002 	adc	r2, r2, r2
    91f8:	20400801 	subcs	r0, r0, r1, lsl #16
    91fc:	e1500781 	cmp	r0, r1, lsl #15
    9200:	e0a22002 	adc	r2, r2, r2
    9204:	20400781 	subcs	r0, r0, r1, lsl #15
    9208:	e1500701 	cmp	r0, r1, lsl #14
    920c:	e0a22002 	adc	r2, r2, r2
    9210:	20400701 	subcs	r0, r0, r1, lsl #14
    9214:	e1500681 	cmp	r0, r1, lsl #13
    9218:	e0a22002 	adc	r2, r2, r2
    921c:	20400681 	subcs	r0, r0, r1, lsl #13
    9220:	e1500601 	cmp	r0, r1, lsl #12
    9224:	e0a22002 	adc	r2, r2, r2
    9228:	20400601 	subcs	r0, r0, r1, lsl #12
    922c:	e1500581 	cmp	r0, r1, lsl #11
    9230:	e0a22002 	adc	r2, r2, r2
    9234:	20400581 	subcs	r0, r0, r1, lsl #11
    9238:	e1500501 	cmp	r0, r1, lsl #10
    923c:	e0a22002 	adc	r2, r2, r2
    9240:	20400501 	subcs	r0, r0, r1, lsl #10
    9244:	e1500481 	cmp	r0, r1, lsl #9
    9248:	e0a22002 	adc	r2, r2, r2
    924c:	20400481 	subcs	r0, r0, r1, lsl #9
    9250:	e1500401 	cmp	r0, r1, lsl #8
    9254:	e0a22002 	adc	r2, r2, r2
    9258:	20400401 	subcs	r0, r0, r1, lsl #8
    925c:	e1500381 	cmp	r0, r1, lsl #7
    9260:	e0a22002 	adc	r2, r2, r2
    9264:	20400381 	subcs	r0, r0, r1, lsl #7
    9268:	e1500301 	cmp	r0, r1, lsl #6
    926c:	e0a22002 	adc	r2, r2, r2
    9270:	20400301 	subcs	r0, r0, r1, lsl #6
    9274:	e1500281 	cmp	r0, r1, lsl #5
    9278:	e0a22002 	adc	r2, r2, r2
    927c:	20400281 	subcs	r0, r0, r1, lsl #5
    9280:	e1500201 	cmp	r0, r1, lsl #4
    9284:	e0a22002 	adc	r2, r2, r2
    9288:	20400201 	subcs	r0, r0, r1, lsl #4
    928c:	e1500181 	cmp	r0, r1, lsl #3
    9290:	e0a22002 	adc	r2, r2, r2
    9294:	20400181 	subcs	r0, r0, r1, lsl #3
    9298:	e1500101 	cmp	r0, r1, lsl #2
    929c:	e0a22002 	adc	r2, r2, r2
    92a0:	20400101 	subcs	r0, r0, r1, lsl #2
    92a4:	e1500081 	cmp	r0, r1, lsl #1
    92a8:	e0a22002 	adc	r2, r2, r2
    92ac:	20400081 	subcs	r0, r0, r1, lsl #1
    92b0:	e1500001 	cmp	r0, r1
    92b4:	e0a22002 	adc	r2, r2, r2
    92b8:	20400001 	subcs	r0, r0, r1
    92bc:	e1a00002 	mov	r0, r2
    92c0:	e12fff1e 	bx	lr
    92c4:	03a00001 	moveq	r0, #1
    92c8:	13a00000 	movne	r0, #0
    92cc:	e12fff1e 	bx	lr
    92d0:	e16f2f11 	clz	r2, r1
    92d4:	e262201f 	rsb	r2, r2, #31
    92d8:	e1a00230 	lsr	r0, r0, r2
    92dc:	e12fff1e 	bx	lr
    92e0:	e3500000 	cmp	r0, #0
    92e4:	13e00000 	mvnne	r0, #0
    92e8:	ea000007 	b	930c <__aeabi_idiv0>

000092ec <__aeabi_uidivmod>:
__aeabi_uidivmod():
    92ec:	e3510000 	cmp	r1, #0
    92f0:	0afffffa 	beq	92e0 <__udivsi3+0x1e0>
    92f4:	e92d4003 	push	{r0, r1, lr}
    92f8:	ebffff80 	bl	9100 <__udivsi3>
    92fc:	e8bd4006 	pop	{r1, r2, lr}
    9300:	e0030092 	mul	r3, r2, r0
    9304:	e0411003 	sub	r1, r1, r3
    9308:	e12fff1e 	bx	lr

0000930c <__aeabi_idiv0>:
__aeabi_ldiv0():
    930c:	e12fff1e 	bx	lr

Disassembly of section .rodata:

00009310 <_ZL13Lock_Unlocked>:
    9310:	00000000 	andeq	r0, r0, r0

00009314 <_ZL11Lock_Locked>:
    9314:	00000001 	andeq	r0, r0, r1

00009318 <_ZL21MaxFSDriverNameLength>:
    9318:	00000010 	andeq	r0, r0, r0, lsl r0

0000931c <_ZL17MaxFilenameLength>:
    931c:	00000010 	andeq	r0, r0, r0, lsl r0

00009320 <_ZL13MaxPathLength>:
    9320:	00000080 	andeq	r0, r0, r0, lsl #1

00009324 <_ZL18NoFilesystemDriver>:
    9324:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00009328 <_ZL9NotifyAll>:
    9328:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

0000932c <_ZL24Max_Process_Opened_Files>:
    932c:	00000010 	andeq	r0, r0, r0, lsl r0

00009330 <_ZL10Indefinite>:
    9330:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00009334 <_ZL18Deadline_Unchanged>:
    9334:	fffffffe 			; <UNDEFINED> instruction: 0xfffffffe

00009338 <_ZL14Invalid_Handle>:
    9338:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

0000933c <_ZN3halL18Default_Clock_RateE>:
    933c:	0ee6b280 	cdpeq	2, 14, cr11, cr6, cr0, {4}

00009340 <_ZN3halL15Peripheral_BaseE>:
    9340:	20000000 	andcs	r0, r0, r0

00009344 <_ZN3halL9GPIO_BaseE>:
    9344:	20200000 	eorcs	r0, r0, r0

00009348 <_ZN3halL14GPIO_Pin_CountE>:
    9348:	00000036 	andeq	r0, r0, r6, lsr r0

0000934c <_ZN3halL8AUX_BaseE>:
    934c:	20215000 	eorcs	r5, r1, r0

00009350 <_ZN3halL25Interrupt_Controller_BaseE>:
    9350:	2000b200 	andcs	fp, r0, r0, lsl #4

00009354 <_ZN3halL10Timer_BaseE>:
    9354:	2000b400 	andcs	fp, r0, r0, lsl #8

00009358 <_ZN3halL9TRNG_BaseE>:
    9358:	20104000 	andscs	r4, r0, r0

0000935c <_ZN3halL9BSC0_BaseE>:
    935c:	20205000 	eorcs	r5, r0, r0

00009360 <_ZN3halL9BSC1_BaseE>:
    9360:	20804000 	addcs	r4, r0, r0

00009364 <_ZN3halL9BSC2_BaseE>:
    9364:	20805000 	addcs	r5, r0, r0

00009368 <_ZL11Invalid_Pin>:
    9368:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
    936c:	6c622049 	stclvs	0, cr2, [r2], #-292	; 0xfffffedc
    9370:	2c6b6e69 	stclcs	14, cr6, [fp], #-420	; 0xfffffe5c
    9374:	65687420 	strbvs	r7, [r8, #-1056]!	; 0xfffffbe0
    9378:	6f666572 	svcvs	0x00666572
    937c:	49206572 	stmdbmi	r0!, {r1, r4, r5, r6, r8, sl, sp, lr}
    9380:	2e6d6120 	powcsep	f6, f5, f0
    9384:	00000000 	andeq	r0, r0, r0
    9388:	65732049 	ldrbvs	r2, [r3, #-73]!	; 0xffffffb7
    938c:	65642065 	strbvs	r2, [r4, #-101]!	; 0xffffff9b
    9390:	70206461 	eorvc	r6, r0, r1, ror #8
    9394:	6c657869 	stclvs	8, cr7, [r5], #-420	; 0xfffffe5c
    9398:	00002e73 	andeq	r2, r0, r3, ror lr
    939c:	20656e4f 	rsbcs	r6, r5, pc, asr #28
    93a0:	20555043 	subscs	r5, r5, r3, asr #32
    93a4:	656c7572 	strbvs	r7, [ip, #-1394]!	; 0xfffffa8e
    93a8:	68742073 	ldmdavs	r4!, {r0, r1, r4, r5, r6, sp}^
    93ac:	61206d65 			; <UNDEFINED> instruction: 0x61206d65
    93b0:	002e6c6c 	eoreq	r6, lr, ip, ror #24
    93b4:	6620794d 	strtvs	r7, [r0], -sp, asr #18
    93b8:	756f7661 	strbvc	r7, [pc, #-1633]!	; 8d5f <_ZN13COLED_Display5ClearEb+0x37>
    93bc:	65746972 	ldrbvs	r6, [r4, #-2418]!	; 0xfffff68e
    93c0:	6f707320 	svcvs	0x00707320
    93c4:	69207472 	stmdbvs	r0!, {r1, r4, r5, r6, sl, ip, sp, lr}
    93c8:	52412073 	subpl	r2, r1, #115	; 0x73
    93cc:	7277204d 	rsbsvc	r2, r7, #77	; 0x4d
    93d0:	6c747365 	ldclvs	3, cr7, [r4], #-404	; 0xfffffe6c
    93d4:	00676e69 	rsbeq	r6, r7, r9, ror #28
    93d8:	20646c4f 	rsbcs	r6, r4, pc, asr #24
    93dc:	4463614d 	strbtmi	r6, [r3], #-333	; 0xfffffeb3
    93e0:	6c616e6f 	stclvs	14, cr6, [r1], #-444	; 0xfffffe44
    93e4:	61682064 	cmnvs	r8, r4, rrx
    93e8:	20612064 	rsbcs	r2, r1, r4, rrx
    93ec:	6d726166 	ldfvse	f6, [r2, #-408]!	; 0xfffffe68
    93f0:	4945202c 	stmdbmi	r5, {r2, r3, r5, sp}^
    93f4:	00505247 	subseq	r5, r0, r7, asr #4
    93f8:	3a564544 	bcc	159a910 <__bss_end+0x15911d8>
    93fc:	64656c6f 	strbtvs	r6, [r5], #-3183	; 0xfffff391
    9400:	00000000 	andeq	r0, r0, r0
    9404:	2d56494b 	vldrcs.16	s9, [r6, #-150]	; 0xffffff6a	; <UNPREDICTABLE>
    9408:	534f5452 	movtpl	r5, #62546	; 0xf452
    940c:	696e6920 	stmdbvs	lr!, {r5, r8, fp, sp, lr}^
    9410:	2e2e2e74 	mcrcs	14, 1, r2, cr14, cr4, {3}
    9414:	00000000 	andeq	r0, r0, r0
    9418:	3a564544 	bcc	159a930 <__bss_end+0x15911f8>
    941c:	676e7274 			; <UNDEFINED> instruction: 0x676e7274
    9420:	00000000 	andeq	r0, r0, r0

00009424 <_ZL13Lock_Unlocked>:
    9424:	00000000 	andeq	r0, r0, r0

00009428 <_ZL11Lock_Locked>:
    9428:	00000001 	andeq	r0, r0, r1

0000942c <_ZL21MaxFSDriverNameLength>:
    942c:	00000010 	andeq	r0, r0, r0, lsl r0

00009430 <_ZL17MaxFilenameLength>:
    9430:	00000010 	andeq	r0, r0, r0, lsl r0

00009434 <_ZL13MaxPathLength>:
    9434:	00000080 	andeq	r0, r0, r0, lsl #1

00009438 <_ZL18NoFilesystemDriver>:
    9438:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

0000943c <_ZL9NotifyAll>:
    943c:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00009440 <_ZL24Max_Process_Opened_Files>:
    9440:	00000010 	andeq	r0, r0, r0, lsl r0

00009444 <_ZL10Indefinite>:
    9444:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00009448 <_ZL18Deadline_Unchanged>:
    9448:	fffffffe 			; <UNDEFINED> instruction: 0xfffffffe

0000944c <_ZL14Invalid_Handle>:
    944c:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00009450 <_ZL16Pipe_File_Prefix>:
    9450:	3a535953 	bcc	14df9a4 <__bss_end+0x14d626c>
    9454:	65706970 	ldrbvs	r6, [r0, #-2416]!	; 0xfffff690
    9458:	0000002f 	andeq	r0, r0, pc, lsr #32

0000945c <_ZN12_GLOBAL__N_1L11CharConvArrE>:
    945c:	33323130 	teqcc	r2, #48, 2
    9460:	37363534 			; <UNDEFINED> instruction: 0x37363534
    9464:	42413938 	submi	r3, r1, #56, 18	; 0xe0000
    9468:	46454443 	strbmi	r4, [r5], -r3, asr #8
    946c:	00000000 	andeq	r0, r0, r0

00009470 <_ZL13Lock_Unlocked>:
    9470:	00000000 	andeq	r0, r0, r0

00009474 <_ZL11Lock_Locked>:
    9474:	00000001 	andeq	r0, r0, r1

00009478 <_ZL21MaxFSDriverNameLength>:
    9478:	00000010 	andeq	r0, r0, r0, lsl r0

0000947c <_ZL17MaxFilenameLength>:
    947c:	00000010 	andeq	r0, r0, r0, lsl r0

00009480 <_ZL13MaxPathLength>:
    9480:	00000080 	andeq	r0, r0, r0, lsl #1

00009484 <_ZL18NoFilesystemDriver>:
    9484:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00009488 <_ZL9NotifyAll>:
    9488:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

0000948c <_ZL24Max_Process_Opened_Files>:
    948c:	00000010 	andeq	r0, r0, r0, lsl r0

00009490 <_ZL10Indefinite>:
    9490:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00009494 <_ZL18Deadline_Unchanged>:
    9494:	fffffffe 			; <UNDEFINED> instruction: 0xfffffffe

00009498 <_ZL14Invalid_Handle>:
    9498:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

0000949c <_ZN3halL18Default_Clock_RateE>:
    949c:	0ee6b280 	cdpeq	2, 14, cr11, cr6, cr0, {4}

000094a0 <_ZN3halL15Peripheral_BaseE>:
    94a0:	20000000 	andcs	r0, r0, r0

000094a4 <_ZN3halL9GPIO_BaseE>:
    94a4:	20200000 	eorcs	r0, r0, r0

000094a8 <_ZN3halL14GPIO_Pin_CountE>:
    94a8:	00000036 	andeq	r0, r0, r6, lsr r0

000094ac <_ZN3halL8AUX_BaseE>:
    94ac:	20215000 	eorcs	r5, r1, r0

000094b0 <_ZN3halL25Interrupt_Controller_BaseE>:
    94b0:	2000b200 	andcs	fp, r0, r0, lsl #4

000094b4 <_ZN3halL10Timer_BaseE>:
    94b4:	2000b400 	andcs	fp, r0, r0, lsl #8

000094b8 <_ZN3halL9TRNG_BaseE>:
    94b8:	20104000 	andscs	r4, r0, r0

000094bc <_ZN3halL9BSC0_BaseE>:
    94bc:	20205000 	eorcs	r5, r0, r0

000094c0 <_ZN3halL9BSC1_BaseE>:
    94c0:	20804000 	addcs	r4, r0, r0

000094c4 <_ZN3halL9BSC2_BaseE>:
    94c4:	20805000 	addcs	r5, r0, r0

000094c8 <_ZN9OLED_FontL10Char_WidthE>:
    94c8:	 	andeq	r0, r8, r6

000094ca <_ZN9OLED_FontL11Char_HeightE>:
    94ca:	 	eoreq	r0, r0, r8

000094cc <_ZN9OLED_FontL10Char_BeginE>:
    94cc:	 	addeq	r0, r0, r0, lsr #32

000094ce <_ZN9OLED_FontL8Char_EndE>:
    94ce:	 	andeq	r0, r1, r0, lsl #1

000094d0 <_ZN9OLED_FontL10Flip_CharsE>:
    94d0:	00000001 	andeq	r0, r0, r1

000094d4 <_ZN9OLED_FontL17OLED_Font_DefaultE>:
	...
    94dc:	00002f00 	andeq	r2, r0, r0, lsl #30
    94e0:	00070000 	andeq	r0, r7, r0
    94e4:	14000007 	strne	r0, [r0], #-7
    94e8:	147f147f 	ldrbtne	r1, [pc], #-1151	; 94f0 <_ZN9OLED_FontL17OLED_Font_DefaultE+0x1c>
    94ec:	7f2a2400 	svcvc	0x002a2400
    94f0:	2300122a 	movwcs	r1, #554	; 0x22a
    94f4:	62640813 	rsbvs	r0, r4, #1245184	; 0x130000
    94f8:	55493600 	strbpl	r3, [r9, #-1536]	; 0xfffffa00
    94fc:	00005022 	andeq	r5, r0, r2, lsr #32
    9500:	00000305 	andeq	r0, r0, r5, lsl #6
    9504:	221c0000 	andscs	r0, ip, #0
    9508:	00000041 	andeq	r0, r0, r1, asr #32
    950c:	001c2241 	andseq	r2, ip, r1, asr #4
    9510:	3e081400 	cfcpyscc	mvf1, mvf8
    9514:	08001408 	stmdaeq	r0, {r3, sl, ip}
    9518:	08083e08 	stmdaeq	r8, {r3, r9, sl, fp, ip, sp}
    951c:	a0000000 	andge	r0, r0, r0
    9520:	08000060 	stmdaeq	r0, {r5, r6}
    9524:	08080808 	stmdaeq	r8, {r3, fp}
    9528:	60600000 	rsbvs	r0, r0, r0
    952c:	20000000 	andcs	r0, r0, r0
    9530:	02040810 	andeq	r0, r4, #16, 16	; 0x100000
    9534:	49513e00 	ldmdbmi	r1, {r9, sl, fp, ip, sp}^
    9538:	00003e45 	andeq	r3, r0, r5, asr #28
    953c:	00407f42 	subeq	r7, r0, r2, asr #30
    9540:	51614200 	cmnpl	r1, r0, lsl #4
    9544:	21004649 	tstcs	r0, r9, asr #12
    9548:	314b4541 	cmpcc	fp, r1, asr #10
    954c:	12141800 	andsne	r1, r4, #0, 16
    9550:	2700107f 	smlsdxcs	r0, pc, r0, r1	; <UNPREDICTABLE>
    9554:	39454545 	stmdbcc	r5, {r0, r2, r6, r8, sl, lr}^
    9558:	494a3c00 	stmdbmi	sl, {sl, fp, ip, sp}^
    955c:	01003049 	tsteq	r0, r9, asr #32
    9560:	03050971 	movweq	r0, #22897	; 0x5971
    9564:	49493600 	stmdbmi	r9, {r9, sl, ip, sp}^
    9568:	06003649 	streq	r3, [r0], -r9, asr #12
    956c:	1e294949 	vnmulne.f16	s8, s18, s18	; <UNPREDICTABLE>
    9570:	36360000 	ldrtcc	r0, [r6], -r0
    9574:	00000000 	andeq	r0, r0, r0
    9578:	00003656 	andeq	r3, r0, r6, asr r6
    957c:	22140800 	andscs	r0, r4, #0, 16
    9580:	14000041 	strne	r0, [r0], #-65	; 0xffffffbf
    9584:	14141414 	ldrne	r1, [r4], #-1044	; 0xfffffbec
    9588:	22410000 	subcs	r0, r1, #0
    958c:	02000814 	andeq	r0, r0, #20, 16	; 0x140000
    9590:	06095101 	streq	r5, [r9], -r1, lsl #2
    9594:	59493200 	stmdbpl	r9, {r9, ip, sp}^
    9598:	7c003e51 	stcvc	14, cr3, [r0], {81}	; 0x51
    959c:	7c121112 	ldfvcs	f1, [r2], {18}
    95a0:	49497f00 	stmdbmi	r9, {r8, r9, sl, fp, ip, sp, lr}^
    95a4:	3e003649 	cfmadd32cc	mvax2, mvfx3, mvfx0, mvfx9
    95a8:	22414141 	subcs	r4, r1, #1073741840	; 0x40000010
    95ac:	41417f00 	cmpmi	r1, r0, lsl #30
    95b0:	7f001c22 	svcvc	0x00001c22
    95b4:	41494949 	cmpmi	r9, r9, asr #18
    95b8:	09097f00 	stmdbeq	r9, {r8, r9, sl, fp, ip, sp, lr}
    95bc:	3e000109 	adfccs	f0, f0, #1.0
    95c0:	7a494941 	bvc	125bacc <__bss_end+0x1252394>
    95c4:	08087f00 	stmdaeq	r8, {r8, r9, sl, fp, ip, sp, lr}
    95c8:	00007f08 	andeq	r7, r0, r8, lsl #30
    95cc:	00417f41 	subeq	r7, r1, r1, asr #30
    95d0:	41402000 	mrsmi	r2, (UNDEF: 64)
    95d4:	7f00013f 	svcvc	0x0000013f
    95d8:	41221408 			; <UNDEFINED> instruction: 0x41221408
    95dc:	40407f00 	submi	r7, r0, r0, lsl #30
    95e0:	7f004040 	svcvc	0x00004040
    95e4:	7f020c02 	svcvc	0x00020c02
    95e8:	08047f00 	stmdaeq	r4, {r8, r9, sl, fp, ip, sp, lr}
    95ec:	3e007f10 	mcrcc	15, 0, r7, cr0, cr0, {0}
    95f0:	3e414141 	dvfccsm	f4, f1, f1
    95f4:	09097f00 	stmdbeq	r9, {r8, r9, sl, fp, ip, sp, lr}
    95f8:	3e000609 	cfmadd32cc	mvax0, mvfx0, mvfx0, mvfx9
    95fc:	5e215141 	sufplsm	f5, f1, f1
    9600:	19097f00 	stmdbne	r9, {r8, r9, sl, fp, ip, sp, lr}
    9604:	46004629 	strmi	r4, [r0], -r9, lsr #12
    9608:	31494949 	cmpcc	r9, r9, asr #18
    960c:	7f010100 	svcvc	0x00010100
    9610:	3f000101 	svccc	0x00000101
    9614:	3f404040 	svccc	0x00404040
    9618:	40201f00 	eormi	r1, r0, r0, lsl #30
    961c:	3f001f20 	svccc	0x00001f20
    9620:	3f403840 	svccc	0x00403840
    9624:	08146300 	ldmdaeq	r4, {r8, r9, sp, lr}
    9628:	07006314 	smladeq	r0, r4, r3, r6
    962c:	07087008 	streq	r7, [r8, -r8]
    9630:	49516100 	ldmdbmi	r1, {r8, sp, lr}^
    9634:	00004345 	andeq	r4, r0, r5, asr #6
    9638:	0041417f 	subeq	r4, r1, pc, ror r1
    963c:	552a5500 	strpl	r5, [sl, #-1280]!	; 0xfffffb00
    9640:	0000552a 	andeq	r5, r0, sl, lsr #10
    9644:	007f4141 	rsbseq	r4, pc, r1, asr #2
    9648:	01020400 	tsteq	r2, r0, lsl #8
    964c:	40000402 	andmi	r0, r0, r2, lsl #8
    9650:	40404040 	submi	r4, r0, r0, asr #32
    9654:	02010000 	andeq	r0, r1, #0
    9658:	20000004 	andcs	r0, r0, r4
    965c:	78545454 	ldmdavc	r4, {r2, r4, r6, sl, ip, lr}^
    9660:	44487f00 	strbmi	r7, [r8], #-3840	; 0xfffff100
    9664:	38003844 	stmdacc	r0, {r2, r6, fp, ip, sp}
    9668:	20444444 	subcs	r4, r4, r4, asr #8
    966c:	44443800 	strbmi	r3, [r4], #-2048	; 0xfffff800
    9670:	38007f48 	stmdacc	r0, {r3, r6, r8, r9, sl, fp, ip, sp, lr}
    9674:	18545454 	ldmdane	r4, {r2, r4, r6, sl, ip, lr}^
    9678:	097e0800 	ldmdbeq	lr!, {fp}^
    967c:	18000201 	stmdane	r0, {r0, r9}
    9680:	7ca4a4a4 	cfstrsvc	mvf10, [r4], #656	; 0x290
    9684:	04087f00 	streq	r7, [r8], #-3840	; 0xfffff100
    9688:	00007804 	andeq	r7, r0, r4, lsl #16
    968c:	00407d44 	subeq	r7, r0, r4, asr #26
    9690:	84804000 	strhi	r4, [r0], #0
    9694:	7f00007d 	svcvc	0x0000007d
    9698:	00442810 	subeq	r2, r4, r0, lsl r8
    969c:	7f410000 	svcvc	0x00410000
    96a0:	7c000040 	stcvc	0, cr0, [r0], {64}	; 0x40
    96a4:	78041804 	stmdavc	r4, {r2, fp, ip}
    96a8:	04087c00 	streq	r7, [r8], #-3072	; 0xfffff400
    96ac:	38007804 	stmdacc	r0, {r2, fp, ip, sp, lr}
    96b0:	38444444 	stmdacc	r4, {r2, r6, sl, lr}^
    96b4:	2424fc00 	strtcs	pc, [r4], #-3072	; 0xfffff400
    96b8:	18001824 	stmdane	r0, {r2, r5, fp, ip}
    96bc:	fc182424 	ldc2	4, cr2, [r8], {36}	; 0x24
    96c0:	04087c00 	streq	r7, [r8], #-3072	; 0xfffff400
    96c4:	48000804 	stmdami	r0, {r2, fp}
    96c8:	20545454 	subscs	r5, r4, r4, asr r4
    96cc:	443f0400 	ldrtmi	r0, [pc], #-1024	; 96d4 <_ZN9OLED_FontL17OLED_Font_DefaultE+0x200>
    96d0:	3c002040 	stccc	0, cr2, [r0], {64}	; 0x40
    96d4:	7c204040 	stcvc	0, cr4, [r0], #-256	; 0xffffff00
    96d8:	40201c00 	eormi	r1, r0, r0, lsl #24
    96dc:	3c001c20 	stccc	12, cr1, [r0], {32}
    96e0:	3c403040 	mcrrcc	0, 4, r3, r0, cr0
    96e4:	10284400 	eorne	r4, r8, r0, lsl #8
    96e8:	1c004428 	cfstrsne	mvf4, [r0], {40}	; 0x28
    96ec:	7ca0a0a0 	stcvc	0, cr10, [r0], #640	; 0x280
    96f0:	54644400 	strbtpl	r4, [r4], #-1024	; 0xfffffc00
    96f4:	0000444c 	andeq	r4, r0, ip, asr #8
    96f8:	00007708 	andeq	r7, r0, r8, lsl #14
    96fc:	7f000000 	svcvc	0x00000000
    9700:	00000000 	andeq	r0, r0, r0
    9704:	00000877 	andeq	r0, r0, r7, ror r8
    9708:	10081000 	andne	r1, r8, r0
    970c:	00000008 	andeq	r0, r0, r8
    9710:	00000000 	andeq	r0, r0, r0

Disassembly of section .data:

00009714 <messages>:
__DTOR_END__():
    9714:	0000936c 	andeq	r9, r0, ip, ror #6
    9718:	00009388 	andeq	r9, r0, r8, lsl #7
    971c:	0000939c 	muleq	r0, ip, r3
    9720:	000093b4 			; <UNDEFINED> instruction: 0x000093b4
    9724:	000093d8 	ldrdeq	r9, [r0], -r8

Disassembly of section .bss:

00009728 <__bss_start>:
	...

Disassembly of section .ARM.attributes:

00000000 <.ARM.attributes>:
   0:	00002e41 	andeq	r2, r0, r1, asr #28
   4:	61656100 	cmnvs	r5, r0, lsl #2
   8:	01006962 	tsteq	r0, r2, ror #18
   c:	00000024 	andeq	r0, r0, r4, lsr #32
  10:	4b5a3605 	blmi	168d82c <__bss_end+0x16840f4>
  14:	08070600 	stmdaeq	r7, {r9, sl}
  18:	0a010901 	beq	42424 <__bss_end+0x38cec>
  1c:	14041202 	strne	r1, [r4], #-514	; 0xfffffdfe
  20:	17011501 	strne	r1, [r1, -r1, lsl #10]
  24:	1a011803 	bne	46038 <__bss_end+0x3c900>
  28:	22011c01 	andcs	r1, r1, #256	; 0x100
  2c:	Address 0x000000000000002c is out of bounds.


Disassembly of section .comment:

00000000 <.comment>:
   0:	3a434347 	bcc	10d0d24 <__bss_end+0x10c75ec>
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
  38:	7a617661 	bvc	185d9c4 <__bss_end+0x185428c>
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
  c0:	6a757a61 	bvs	1d5ea4c <__bss_end+0x1d55314>
  c4:	2f696369 	svccs	0x00696369
  c8:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
  cc:	73656d65 	cmnvc	r5, #6464	; 0x1940
  d0:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
  d4:	6b2d616b 	blvs	b58688 <__bss_end+0xb4ef50>
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
 144:	fb010200 	blx	4094e <__bss_end+0x37216>
 148:	01000d0e 	tsteq	r0, lr, lsl #26
 14c:	00010101 	andeq	r0, r1, r1, lsl #2
 150:	00010000 	andeq	r0, r1, r0
 154:	552f0100 	strpl	r0, [pc, #-256]!	; 5c <shift+0x5c>
 158:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 15c:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 160:	6a726574 	bvs	1c99738 <__bss_end+0x1c90000>
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
 198:	752f7365 	strvc	r7, [pc, #-869]!	; fffffe3b <__bss_end+0xffff6703>
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
 1d0:	0a05830b 	beq	160e04 <__bss_end+0x1576cc>
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
 1fc:	4a030402 	bmi	c120c <__bss_end+0xb7ad4>
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
 230:	4a020402 	bmi	81240 <__bss_end+0x77b08>
 234:	02000205 	andeq	r0, r0, #1342177280	; 0x50000000
 238:	052d0204 	streq	r0, [sp, #-516]!	; 0xfffffdfc
 23c:	01058509 	tsteq	r5, r9, lsl #10
 240:	000a022f 	andeq	r0, sl, pc, lsr #4
 244:	035d0101 	cmpeq	sp, #1073741824	; 0x40000000
 248:	00030000 	andeq	r0, r3, r0
 24c:	000002fb 	strdeq	r0, [r0], -fp
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
 280:	6a757a61 	bvs	1d5ec0c <__bss_end+0x1d554d4>
 284:	2f696369 	svccs	0x00696369
 288:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
 28c:	73656d65 	cmnvc	r5, #6464	; 0x1940
 290:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
 294:	6b2d616b 	blvs	b58848 <__bss_end+0xb4f110>
 298:	6f2d7669 	svcvs	0x002d7669
 29c:	6f732f73 	svcvs	0x00732f73
 2a0:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
 2a4:	73752f73 	cmnvc	r5, #460	; 0x1cc
 2a8:	70737265 	rsbsvc	r7, r3, r5, ror #4
 2ac:	2f656361 	svccs	0x00656361
 2b0:	64656c6f 	strbtvs	r6, [r5], #-3183	; 0xfffff391
 2b4:	7361745f 	cmnvc	r1, #1593835520	; 0x5f000000
 2b8:	552f006b 	strpl	r0, [pc, #-107]!	; 255 <shift+0x255>
 2bc:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 2c0:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 2c4:	6a726574 	bvs	1c9989c <__bss_end+0x1c90164>
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
 2fc:	752f7365 	strvc	r7, [pc, #-869]!	; ffffff9f <__bss_end+0xffff6867>
 300:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 304:	65636170 	strbvs	r6, [r3, #-368]!	; 0xfffffe90
 308:	2f2e2e2f 	svccs	0x002e2e2f
 30c:	6e72656b 	cdpvs	5, 7, cr6, cr2, cr11, {3}
 310:	692f6c65 	stmdbvs	pc!, {r0, r2, r5, r6, sl, fp, sp, lr}	; <UNPREDICTABLE>
 314:	756c636e 	strbvc	r6, [ip, #-878]!	; 0xfffffc92
 318:	622f6564 	eorvs	r6, pc, #100, 10	; 0x19000000
 31c:	6472616f 	ldrbtvs	r6, [r2], #-367	; 0xfffffe91
 320:	6970722f 	ldmdbvs	r0!, {r0, r1, r2, r3, r5, r9, ip, sp, lr}^
 324:	61682f30 	cmnvs	r8, r0, lsr pc
 328:	552f006c 	strpl	r0, [pc, #-108]!	; 2c4 <shift+0x2c4>
 32c:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 330:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 334:	6a726574 	bvs	1c9990c <__bss_end+0x1c901d4>
 338:	65442f69 	strbvs	r2, [r4, #-3945]	; 0xfffff097
 33c:	6f746b73 	svcvs	0x00746b73
 340:	41462f70 	hvcmi	25328	; 0x62f0
 344:	614e2f56 	cmpvs	lr, r6, asr pc
 348:	757a6176 	ldrbvc	r6, [sl, #-374]!	; 0xfffffe8a
 34c:	6963696a 	stmdbvs	r3!, {r1, r3, r5, r6, r8, fp, sp, lr}^
 350:	2f534f2f 	svccs	0x00534f2f
 354:	656d6573 	strbvs	r6, [sp, #-1395]!	; 0xfffffa8d
 358:	61727473 	cmnvs	r2, r3, ror r4
 35c:	2d616b6c 	vstmdbcs	r1!, {d22-<overflow reg d75>}
 360:	2d76696b 			; <UNDEFINED> instruction: 0x2d76696b
 364:	732f736f 			; <UNDEFINED> instruction: 0x732f736f
 368:	6372756f 	cmnvs	r2, #465567744	; 0x1bc00000
 36c:	752f7365 	strvc	r7, [pc, #-869]!	; f <shift+0xf>
 370:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 374:	65636170 	strbvs	r6, [r3, #-368]!	; 0xfffffe90
 378:	2f2e2e2f 	svccs	0x002e2e2f
 37c:	6e72656b 	cdpvs	5, 7, cr6, cr2, cr11, {3}
 380:	692f6c65 	stmdbvs	pc!, {r0, r2, r5, r6, sl, fp, sp, lr}	; <UNPREDICTABLE>
 384:	756c636e 	strbvc	r6, [ip, #-878]!	; 0xfffffc92
 388:	702f6564 	eorvc	r6, pc, r4, ror #10
 38c:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
 390:	2f007373 	svccs	0x00007373
 394:	72657355 	rsbvc	r7, r5, #1409286145	; 0x54000001
 398:	69772f73 	ldmdbvs	r7!, {r0, r1, r4, r5, r6, r8, r9, sl, fp, sp}^
 39c:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
 3a0:	442f696a 	strtmi	r6, [pc], #-2410	; 3a8 <shift+0x3a8>
 3a4:	746b7365 	strbtvc	r7, [fp], #-869	; 0xfffffc9b
 3a8:	462f706f 	strtmi	r7, [pc], -pc, rrx
 3ac:	4e2f5641 	cfmadda32mi	mvax2, mvax5, mvfx15, mvfx1
 3b0:	7a617661 	bvc	185dd3c <__bss_end+0x1854604>
 3b4:	63696a75 	cmnvs	r9, #479232	; 0x75000
 3b8:	534f2f69 	movtpl	r2, #65385	; 0xff69
 3bc:	6d65732f 	stclvs	3, cr7, [r5, #-188]!	; 0xffffff44
 3c0:	72747365 	rsbsvc	r7, r4, #-1811939327	; 0x94000001
 3c4:	616b6c61 	cmnvs	fp, r1, ror #24
 3c8:	76696b2d 	strbtvc	r6, [r9], -sp, lsr #22
 3cc:	2f736f2d 	svccs	0x00736f2d
 3d0:	72756f73 	rsbsvc	r6, r5, #460	; 0x1cc
 3d4:	2f736563 	svccs	0x00736563
 3d8:	72657375 	rsbvc	r7, r5, #-738197503	; 0xd4000001
 3dc:	63617073 	cmnvs	r1, #115	; 0x73
 3e0:	2e2e2f65 	cdpcs	15, 2, cr2, cr14, cr5, {3}
 3e4:	72656b2f 	rsbvc	r6, r5, #48128	; 0xbc00
 3e8:	2f6c656e 	svccs	0x006c656e
 3ec:	6c636e69 	stclvs	14, cr6, [r3], #-420	; 0xfffffe5c
 3f0:	2f656475 	svccs	0x00656475
 3f4:	2f007366 	svccs	0x00007366
 3f8:	72657355 	rsbvc	r7, r5, #1409286145	; 0x54000001
 3fc:	69772f73 	ldmdbvs	r7!, {r0, r1, r4, r5, r6, r8, r9, sl, fp, sp}^
 400:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
 404:	442f696a 	strtmi	r6, [pc], #-2410	; 40c <shift+0x40c>
 408:	746b7365 	strbtvc	r7, [fp], #-869	; 0xfffffc9b
 40c:	462f706f 	strtmi	r7, [pc], -pc, rrx
 410:	4e2f5641 	cfmadda32mi	mvax2, mvax5, mvfx15, mvfx1
 414:	7a617661 	bvc	185dda0 <__bss_end+0x1854668>
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
 448:	6474732f 	ldrbtvs	r7, [r4], #-815	; 0xfffffcd1
 44c:	6c697475 	cfstrdvs	mvd7, [r9], #-468	; 0xfffffe2c
 450:	6e692f73 	mcrvs	15, 3, r2, cr9, cr3, {3}
 454:	64756c63 	ldrbtvs	r6, [r5], #-3171	; 0xfffff39d
 458:	552f0065 	strpl	r0, [pc, #-101]!	; 3fb <shift+0x3fb>
 45c:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 460:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 464:	6a726574 	bvs	1c99a3c <__bss_end+0x1c90304>
 468:	65442f69 	strbvs	r2, [r4, #-3945]	; 0xfffff097
 46c:	6f746b73 	svcvs	0x00746b73
 470:	41462f70 	hvcmi	25328	; 0x62f0
 474:	614e2f56 	cmpvs	lr, r6, asr pc
 478:	757a6176 	ldrbvc	r6, [sl, #-374]!	; 0xfffffe8a
 47c:	6963696a 	stmdbvs	r3!, {r1, r3, r5, r6, r8, fp, sp, lr}^
 480:	2f534f2f 	svccs	0x00534f2f
 484:	656d6573 	strbvs	r6, [sp, #-1395]!	; 0xfffffa8d
 488:	61727473 	cmnvs	r2, r3, ror r4
 48c:	2d616b6c 	vstmdbcs	r1!, {d22-<overflow reg d75>}
 490:	2d76696b 			; <UNDEFINED> instruction: 0x2d76696b
 494:	732f736f 			; <UNDEFINED> instruction: 0x732f736f
 498:	6372756f 	cmnvs	r2, #465567744	; 0x1bc00000
 49c:	752f7365 	strvc	r7, [pc, #-869]!	; 13f <shift+0x13f>
 4a0:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 4a4:	65636170 	strbvs	r6, [r3, #-368]!	; 0xfffffe90
 4a8:	2f2e2e2f 	svccs	0x002e2e2f
 4ac:	6e72656b 	cdpvs	5, 7, cr6, cr2, cr11, {3}
 4b0:	692f6c65 	stmdbvs	pc!, {r0, r2, r5, r6, sl, fp, sp, lr}	; <UNPREDICTABLE>
 4b4:	756c636e 	strbvc	r6, [ip, #-878]!	; 0xfffffc92
 4b8:	642f6564 	strtvs	r6, [pc], #-1380	; 4c0 <shift+0x4c0>
 4bc:	65766972 	ldrbvs	r6, [r6, #-2418]!	; 0xfffff68e
 4c0:	00007372 	andeq	r7, r0, r2, ror r3
 4c4:	6e69616d 	powvsez	f6, f1, #5.0
 4c8:	7070632e 	rsbsvc	r6, r0, lr, lsr #6
 4cc:	00000100 	andeq	r0, r0, r0, lsl #2
 4d0:	64746e69 	ldrbtvs	r6, [r4], #-3689	; 0xfffff197
 4d4:	682e6665 	stmdavs	lr!, {r0, r2, r5, r6, r9, sl, sp, lr}
 4d8:	00000200 	andeq	r0, r0, r0, lsl #4
 4dc:	2e697773 	mcrcs	7, 3, r7, cr9, cr3, {3}
 4e0:	00030068 	andeq	r0, r3, r8, rrx
 4e4:	69707300 	ldmdbvs	r0!, {r8, r9, ip, sp, lr}^
 4e8:	636f6c6e 	cmnvs	pc, #28160	; 0x6e00
 4ec:	00682e6b 	rsbeq	r2, r8, fp, ror #28
 4f0:	66000003 	strvs	r0, [r0], -r3
 4f4:	73656c69 	cmnvc	r5, #26880	; 0x6900
 4f8:	65747379 	ldrbvs	r7, [r4, #-889]!	; 0xfffffc87
 4fc:	00682e6d 	rsbeq	r2, r8, sp, ror #28
 500:	70000004 	andvc	r0, r0, r4
 504:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
 508:	682e7373 	stmdavs	lr!, {r0, r1, r4, r5, r6, r8, r9, ip, sp, lr}
 50c:	00000300 	andeq	r0, r0, r0, lsl #6
 510:	636f7270 	cmnvs	pc, #112, 4
 514:	5f737365 	svcpl	0x00737365
 518:	616e616d 	cmnvs	lr, sp, ror #2
 51c:	2e726567 	cdpcs	5, 7, cr6, cr2, cr7, {3}
 520:	00030068 	andeq	r0, r3, r8, rrx
 524:	656c6f00 	strbvs	r6, [ip, #-3840]!	; 0xfffff100
 528:	00682e64 	rsbeq	r2, r8, r4, ror #28
 52c:	70000005 	andvc	r0, r0, r5
 530:	70697265 	rsbvc	r7, r9, r5, ror #4
 534:	61726568 	cmnvs	r2, r8, ror #10
 538:	682e736c 	stmdavs	lr!, {r2, r3, r5, r6, r8, r9, ip, sp, lr}
 53c:	00000200 	andeq	r0, r0, r0, lsl #4
 540:	6f697067 	svcvs	0x00697067
 544:	0600682e 	streq	r6, [r0], -lr, lsr #16
 548:	05000000 	streq	r0, [r0, #-0]
 54c:	02050001 	andeq	r0, r5, #1
 550:	0000822c 	andeq	r8, r0, ip, lsr #4
 554:	05011a03 	streq	r1, [r1, #-2563]	; 0xfffff5fd
 558:	0c059f1f 	stceq	15, cr9, [r5], {31}
 55c:	83110583 	tsthi	r1, #549453824	; 0x20c00000
 560:	059f0b05 	ldreq	r0, [pc, #2821]	; 106d <shift+0x106d>
 564:	0b05681b 	bleq	15a5d8 <__bss_end+0x150ea0>
 568:	4c070583 	cfstr32mi	mvfx0, [r7], {131}	; 0x83
 56c:	01040200 	mrseq	r0, R12_usr
 570:	0022056b 	eoreq	r0, r2, fp, ror #10
 574:	9f010402 	svcls	0x00010402
 578:	02000f05 	andeq	r0, r0, #5, 30
 57c:	05f20104 	ldrbeq	r0, [r2, #260]!	; 0x104
 580:	0402000d 	streq	r0, [r2], #-13
 584:	12056801 	andne	r6, r5, #65536	; 0x10000
 588:	01040200 	mrseq	r0, R12_usr
 58c:	000c0583 	andeq	r0, ip, r3, lsl #11
 590:	9f010402 	svcls	0x00010402
 594:	02000805 	andeq	r0, r0, #327680	; 0x50000
 598:	05680104 	strbeq	r0, [r8, #-260]!	; 0xfffffefc
 59c:	04020002 	streq	r0, [r2], #-2
 5a0:	0c026701 	stceq	7, cr6, [r2], {1}
 5a4:	c8010100 	stmdagt	r1, {r8}
 5a8:	03000002 	movweq	r0, #2
 5ac:	0001dd00 	andeq	sp, r1, r0, lsl #26
 5b0:	fb010200 	blx	40dba <__bss_end+0x37682>
 5b4:	01000d0e 	tsteq	r0, lr, lsl #26
 5b8:	00010101 	andeq	r0, r1, r1, lsl #2
 5bc:	00010000 	andeq	r0, r1, r0
 5c0:	552f0100 	strpl	r0, [pc, #-256]!	; 4c8 <shift+0x4c8>
 5c4:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 5c8:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 5cc:	6a726574 	bvs	1c99ba4 <__bss_end+0x1c9046c>
 5d0:	65442f69 	strbvs	r2, [r4, #-3945]	; 0xfffff097
 5d4:	6f746b73 	svcvs	0x00746b73
 5d8:	41462f70 	hvcmi	25328	; 0x62f0
 5dc:	614e2f56 	cmpvs	lr, r6, asr pc
 5e0:	757a6176 	ldrbvc	r6, [sl, #-374]!	; 0xfffffe8a
 5e4:	6963696a 	stmdbvs	r3!, {r1, r3, r5, r6, r8, fp, sp, lr}^
 5e8:	2f534f2f 	svccs	0x00534f2f
 5ec:	656d6573 	strbvs	r6, [sp, #-1395]!	; 0xfffffa8d
 5f0:	61727473 	cmnvs	r2, r3, ror r4
 5f4:	2d616b6c 	vstmdbcs	r1!, {d22-<overflow reg d75>}
 5f8:	2d76696b 			; <UNDEFINED> instruction: 0x2d76696b
 5fc:	732f736f 			; <UNDEFINED> instruction: 0x732f736f
 600:	6372756f 	cmnvs	r2, #465567744	; 0x1bc00000
 604:	732f7365 			; <UNDEFINED> instruction: 0x732f7365
 608:	696c6474 	stmdbvs	ip!, {r2, r4, r5, r6, sl, sp, lr}^
 60c:	72732f62 	rsbsvc	r2, r3, #392	; 0x188
 610:	552f0063 	strpl	r0, [pc, #-99]!	; 5b5 <shift+0x5b5>
 614:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 618:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 61c:	6a726574 	bvs	1c99bf4 <__bss_end+0x1c904bc>
 620:	65442f69 	strbvs	r2, [r4, #-3945]	; 0xfffff097
 624:	6f746b73 	svcvs	0x00746b73
 628:	41462f70 	hvcmi	25328	; 0x62f0
 62c:	614e2f56 	cmpvs	lr, r6, asr pc
 630:	757a6176 	ldrbvc	r6, [sl, #-374]!	; 0xfffffe8a
 634:	6963696a 	stmdbvs	r3!, {r1, r3, r5, r6, r8, fp, sp, lr}^
 638:	2f534f2f 	svccs	0x00534f2f
 63c:	656d6573 	strbvs	r6, [sp, #-1395]!	; 0xfffffa8d
 640:	61727473 	cmnvs	r2, r3, ror r4
 644:	2d616b6c 	vstmdbcs	r1!, {d22-<overflow reg d75>}
 648:	2d76696b 			; <UNDEFINED> instruction: 0x2d76696b
 64c:	732f736f 			; <UNDEFINED> instruction: 0x732f736f
 650:	6372756f 	cmnvs	r2, #465567744	; 0x1bc00000
 654:	6b2f7365 	blvs	bdd3f0 <__bss_end+0xbd3cb8>
 658:	656e7265 	strbvs	r7, [lr, #-613]!	; 0xfffffd9b
 65c:	6e692f6c 	cdpvs	15, 6, cr2, cr9, cr12, {3}
 660:	64756c63 	ldrbtvs	r6, [r5], #-3171	; 0xfffff39d
 664:	72702f65 	rsbsvc	r2, r0, #404	; 0x194
 668:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
 66c:	552f0073 	strpl	r0, [pc, #-115]!	; 601 <shift+0x601>
 670:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 674:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 678:	6a726574 	bvs	1c99c50 <__bss_end+0x1c90518>
 67c:	65442f69 	strbvs	r2, [r4, #-3945]	; 0xfffff097
 680:	6f746b73 	svcvs	0x00746b73
 684:	41462f70 	hvcmi	25328	; 0x62f0
 688:	614e2f56 	cmpvs	lr, r6, asr pc
 68c:	757a6176 	ldrbvc	r6, [sl, #-374]!	; 0xfffffe8a
 690:	6963696a 	stmdbvs	r3!, {r1, r3, r5, r6, r8, fp, sp, lr}^
 694:	2f534f2f 	svccs	0x00534f2f
 698:	656d6573 	strbvs	r6, [sp, #-1395]!	; 0xfffffa8d
 69c:	61727473 	cmnvs	r2, r3, ror r4
 6a0:	2d616b6c 	vstmdbcs	r1!, {d22-<overflow reg d75>}
 6a4:	2d76696b 			; <UNDEFINED> instruction: 0x2d76696b
 6a8:	732f736f 			; <UNDEFINED> instruction: 0x732f736f
 6ac:	6372756f 	cmnvs	r2, #465567744	; 0x1bc00000
 6b0:	6b2f7365 	blvs	bdd44c <__bss_end+0xbd3d14>
 6b4:	656e7265 	strbvs	r7, [lr, #-613]!	; 0xfffffd9b
 6b8:	6e692f6c 	cdpvs	15, 6, cr2, cr9, cr12, {3}
 6bc:	64756c63 	ldrbtvs	r6, [r5], #-3171	; 0xfffff39d
 6c0:	73662f65 	cmnvc	r6, #404	; 0x194
 6c4:	73552f00 	cmpvc	r5, #0, 30
 6c8:	2f737265 	svccs	0x00737265
 6cc:	746e6977 	strbtvc	r6, [lr], #-2423	; 0xfffff689
 6d0:	696a7265 	stmdbvs	sl!, {r0, r2, r5, r6, r9, ip, sp, lr}^
 6d4:	7365442f 	cmnvc	r5, #788529152	; 0x2f000000
 6d8:	706f746b 	rsbvc	r7, pc, fp, ror #8
 6dc:	5641462f 	strbpl	r4, [r1], -pc, lsr #12
 6e0:	76614e2f 	strbtvc	r4, [r1], -pc, lsr #28
 6e4:	6a757a61 	bvs	1d5f070 <__bss_end+0x1d55938>
 6e8:	2f696369 	svccs	0x00696369
 6ec:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
 6f0:	73656d65 	cmnvc	r5, #6464	; 0x1940
 6f4:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
 6f8:	6b2d616b 	blvs	b58cac <__bss_end+0xb4f574>
 6fc:	6f2d7669 	svcvs	0x002d7669
 700:	6f732f73 	svcvs	0x00732f73
 704:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
 708:	656b2f73 	strbvs	r2, [fp, #-3955]!	; 0xfffff08d
 70c:	6c656e72 	stclvs	14, cr6, [r5], #-456	; 0xfffffe38
 710:	636e692f 	cmnvs	lr, #770048	; 0xbc000
 714:	6564756c 	strbvs	r7, [r4, #-1388]!	; 0xfffffa94
 718:	616f622f 	cmnvs	pc, pc, lsr #4
 71c:	722f6472 	eorvc	r6, pc, #1912602624	; 0x72000000
 720:	2f306970 	svccs	0x00306970
 724:	006c6168 	rsbeq	r6, ip, r8, ror #2
 728:	64747300 	ldrbtvs	r7, [r4], #-768	; 0xfffffd00
 72c:	656c6966 	strbvs	r6, [ip, #-2406]!	; 0xfffff69a
 730:	7070632e 	rsbsvc	r6, r0, lr, lsr #6
 734:	00000100 	andeq	r0, r0, r0, lsl #2
 738:	2e697773 	mcrcs	7, 3, r7, cr9, cr3, {3}
 73c:	00020068 	andeq	r0, r2, r8, rrx
 740:	69707300 	ldmdbvs	r0!, {r8, r9, ip, sp, lr}^
 744:	636f6c6e 	cmnvs	pc, #28160	; 0x6e00
 748:	00682e6b 	rsbeq	r2, r8, fp, ror #28
 74c:	66000002 	strvs	r0, [r0], -r2
 750:	73656c69 	cmnvc	r5, #26880	; 0x6900
 754:	65747379 	ldrbvs	r7, [r4, #-889]!	; 0xfffffc87
 758:	00682e6d 	rsbeq	r2, r8, sp, ror #28
 75c:	70000003 	andvc	r0, r0, r3
 760:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
 764:	682e7373 	stmdavs	lr!, {r0, r1, r4, r5, r6, r8, r9, ip, sp, lr}
 768:	00000200 	andeq	r0, r0, r0, lsl #4
 76c:	636f7270 	cmnvs	pc, #112, 4
 770:	5f737365 	svcpl	0x00737365
 774:	616e616d 	cmnvs	lr, sp, ror #2
 778:	2e726567 	cdpcs	5, 7, cr6, cr2, cr7, {3}
 77c:	00020068 	andeq	r0, r2, r8, rrx
 780:	746e6900 	strbtvc	r6, [lr], #-2304	; 0xfffff700
 784:	2e666564 	cdpcs	5, 6, cr6, cr6, cr4, {3}
 788:	00040068 	andeq	r0, r4, r8, rrx
 78c:	01050000 	mrseq	r0, (UNDEF: 5)
 790:	38020500 	stmdacc	r2, {r8, sl}
 794:	16000083 	strne	r0, [r0], -r3, lsl #1
 798:	2f690505 	svccs	0x00690505
 79c:	054c0c05 	strbeq	r0, [ip, #-3077]	; 0xfffff3fb
 7a0:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 7a4:	054b8305 	strbeq	r8, [fp, #-773]	; 0xfffffcfb
 7a8:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 7ac:	01054b05 	tsteq	r5, r5, lsl #22
 7b0:	0505852f 	streq	r8, [r5, #-1327]	; 0xfffffad1
 7b4:	2f4b4ba1 	svccs	0x004b4ba1
 7b8:	054c0c05 	strbeq	r0, [ip, #-3077]	; 0xfffff3fb
 7bc:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 7c0:	4b4bbd05 	blmi	12efbdc <__bss_end+0x12e64a4>
 7c4:	0c052f4b 	stceq	15, cr2, [r5], {75}	; 0x4b
 7c8:	2f01054c 	svccs	0x0001054c
 7cc:	bd050585 	cfstr32lt	mvfx0, [r5, #-532]	; 0xfffffdec
 7d0:	2f4b4b4b 	svccs	0x004b4b4b
 7d4:	054c0c05 	strbeq	r0, [ip, #-3077]	; 0xfffff3fb
 7d8:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 7dc:	054b8305 	strbeq	r8, [fp, #-773]	; 0xfffffcfb
 7e0:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 7e4:	4b4bbd05 	blmi	12efc00 <__bss_end+0x12e64c8>
 7e8:	0c052f4b 	stceq	15, cr2, [r5], {75}	; 0x4b
 7ec:	2f01054c 	svccs	0x0001054c
 7f0:	a1050585 	smlabbge	r5, r5, r5, r0
 7f4:	052f4b4b 	streq	r4, [pc, #-2891]!	; fffffcb1 <__bss_end+0xffff6579>
 7f8:	01054c0c 	tsteq	r5, ip, lsl #24
 7fc:	0505852f 	streq	r8, [r5, #-1327]	; 0xfffffad1
 800:	4b4b4bbd 	blmi	12d36fc <__bss_end+0x12c9fc4>
 804:	4c0c052f 	cfstr32mi	mvfx0, [ip], {47}	; 0x2f
 808:	852f0105 	strhi	r0, [pc, #-261]!	; 70b <shift+0x70b>
 80c:	4ba10505 	blmi	fe841c28 <__bss_end+0xfe8384f0>
 810:	0c052f4b 	stceq	15, cr2, [r5], {75}	; 0x4b
 814:	9f01054c 	svcls	0x0001054c
 818:	67200585 	strvs	r0, [r0, -r5, lsl #11]!
 81c:	4b4d0505 	blmi	1341c38 <__bss_end+0x1338500>
 820:	300c054b 	andcc	r0, ip, fp, asr #10
 824:	852f0105 	strhi	r0, [pc, #-261]!	; 727 <shift+0x727>
 828:	05672005 	strbeq	r2, [r7, #-5]!
 82c:	4b4b4d05 	blmi	12d3c48 <__bss_end+0x12ca510>
 830:	05300c05 	ldreq	r0, [r0, #-3077]!	; 0xfffff3fb
 834:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 838:	05058320 	streq	r8, [r5, #-800]	; 0xfffffce0
 83c:	054b4b4c 	strbeq	r4, [fp, #-2892]	; 0xfffff4b4
 840:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 844:	05056720 	streq	r6, [r5, #-1824]	; 0xfffff8e0
 848:	054b4b4d 	strbeq	r4, [fp, #-2893]	; 0xfffff4b3
 84c:	0105300c 	tsteq	r5, ip
 850:	0c05872f 	stceq	7, cr8, [r5], {47}	; 0x2f
 854:	31059fa0 	smlatbcc	r5, r0, pc, r9	; <UNPREDICTABLE>
 858:	662905bc 			; <UNDEFINED> instruction: 0x662905bc
 85c:	052e3605 	streq	r3, [lr, #-1541]!	; 0xfffff9fb
 860:	1305300f 	movwne	r3, #20495	; 0x500f
 864:	84090566 	strhi	r0, [r9], #-1382	; 0xfffffa9a
 868:	05d81005 	ldrbeq	r1, [r8, #5]
 86c:	08029f01 	stmdaeq	r2, {r0, r8, r9, sl, fp, ip, pc}
 870:	9b010100 	blls	40c78 <__bss_end+0x37540>
 874:	03000002 	movweq	r0, #2
 878:	00007400 	andeq	r7, r0, r0, lsl #8
 87c:	fb010200 	blx	41086 <__bss_end+0x3794e>
 880:	01000d0e 	tsteq	r0, lr, lsl #26
 884:	00010101 	andeq	r0, r1, r1, lsl #2
 888:	00010000 	andeq	r0, r1, r0
 88c:	552f0100 	strpl	r0, [pc, #-256]!	; 794 <shift+0x794>
 890:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 894:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 898:	6a726574 	bvs	1c99e70 <__bss_end+0x1c90738>
 89c:	65442f69 	strbvs	r2, [r4, #-3945]	; 0xfffff097
 8a0:	6f746b73 	svcvs	0x00746b73
 8a4:	41462f70 	hvcmi	25328	; 0x62f0
 8a8:	614e2f56 	cmpvs	lr, r6, asr pc
 8ac:	757a6176 	ldrbvc	r6, [sl, #-374]!	; 0xfffffe8a
 8b0:	6963696a 	stmdbvs	r3!, {r1, r3, r5, r6, r8, fp, sp, lr}^
 8b4:	2f534f2f 	svccs	0x00534f2f
 8b8:	656d6573 	strbvs	r6, [sp, #-1395]!	; 0xfffffa8d
 8bc:	61727473 	cmnvs	r2, r3, ror r4
 8c0:	2d616b6c 	vstmdbcs	r1!, {d22-<overflow reg d75>}
 8c4:	2d76696b 			; <UNDEFINED> instruction: 0x2d76696b
 8c8:	732f736f 			; <UNDEFINED> instruction: 0x732f736f
 8cc:	6372756f 	cmnvs	r2, #465567744	; 0x1bc00000
 8d0:	732f7365 			; <UNDEFINED> instruction: 0x732f7365
 8d4:	696c6474 	stmdbvs	ip!, {r2, r4, r5, r6, sl, sp, lr}^
 8d8:	72732f62 	rsbsvc	r2, r3, #392	; 0x188
 8dc:	73000063 	movwvc	r0, #99	; 0x63
 8e0:	74736474 	ldrbtvc	r6, [r3], #-1140	; 0xfffffb8c
 8e4:	676e6972 			; <UNDEFINED> instruction: 0x676e6972
 8e8:	7070632e 	rsbsvc	r6, r0, lr, lsr #6
 8ec:	00000100 	andeq	r0, r0, r0, lsl #2
 8f0:	00010500 	andeq	r0, r1, r0, lsl #10
 8f4:	87940205 	ldrhi	r0, [r4, r5, lsl #4]
 8f8:	051a0000 	ldreq	r0, [sl, #-0]
 8fc:	0f05bb06 	svceq	0x0005bb06
 900:	6821054c 	stmdavs	r1!, {r2, r3, r6, r8, sl}
 904:	05ba0a05 	ldreq	r0, [sl, #2565]!	; 0xa05
 908:	27052e0b 	strcs	r2, [r5, -fp, lsl #28]
 90c:	4a0d054a 	bmi	341e3c <__bss_end+0x338704>
 910:	052f0905 	streq	r0, [pc, #-2309]!	; 13 <shift+0x13>
 914:	02059f04 	andeq	r9, r5, #4, 30
 918:	35050562 	strcc	r0, [r5, #-1378]	; 0xfffffa9e
 91c:	05681005 	strbeq	r1, [r8, #-5]!
 920:	22052e11 	andcs	r2, r5, #272	; 0x110
 924:	2e13054a 	cfmac32cs	mvfx0, mvfx3, mvfx10
 928:	052f0a05 	streq	r0, [pc, #-2565]!	; ffffff2b <__bss_end+0xffff67f3>
 92c:	0a056909 	beq	15ad58 <__bss_end+0x151620>
 930:	4a0c052e 	bmi	301df0 <__bss_end+0x2f86b8>
 934:	054b0305 	strbeq	r0, [fp, #-773]	; 0xfffffcfb
 938:	1805680b 	stmdane	r5, {r0, r1, r3, fp, sp, lr}
 93c:	03040200 	movweq	r0, #16896	; 0x4200
 940:	0014054a 	andseq	r0, r4, sl, asr #10
 944:	9e030402 	cdpls	4, 0, cr0, cr3, cr2, {0}
 948:	02001505 	andeq	r1, r0, #20971520	; 0x1400000
 94c:	05680204 	strbeq	r0, [r8, #-516]!	; 0xfffffdfc
 950:	04020018 	streq	r0, [r2], #-24	; 0xffffffe8
 954:	08058202 	stmdaeq	r5, {r1, r9, pc}
 958:	02040200 	andeq	r0, r4, #0, 4
 95c:	001a054a 	andseq	r0, sl, sl, asr #10
 960:	4b020402 	blmi	81970 <__bss_end+0x78238>
 964:	02001b05 	andeq	r1, r0, #5120	; 0x1400
 968:	052e0204 	streq	r0, [lr, #-516]!	; 0xfffffdfc
 96c:	0402000c 	streq	r0, [r2], #-12
 970:	0f054a02 	svceq	0x00054a02
 974:	02040200 	andeq	r0, r4, #0, 4
 978:	001b0582 	andseq	r0, fp, r2, lsl #11
 97c:	4a020402 	bmi	8198c <__bss_end+0x78254>
 980:	02001105 	andeq	r1, r0, #1073741825	; 0x40000001
 984:	052e0204 	streq	r0, [lr, #-516]!	; 0xfffffdfc
 988:	0402000a 	streq	r0, [r2], #-10
 98c:	0b052f02 	bleq	14c59c <__bss_end+0x142e64>
 990:	02040200 	andeq	r0, r4, #0, 4
 994:	000d052e 	andeq	r0, sp, lr, lsr #10
 998:	4a020402 	bmi	819a8 <__bss_end+0x78270>
 99c:	02000205 	andeq	r0, r0, #1342177280	; 0x50000000
 9a0:	05460204 	strbeq	r0, [r6, #-516]	; 0xfffffdfc
 9a4:	05858801 	streq	r8, [r5, #2049]	; 0x801
 9a8:	09058306 	stmdbeq	r5, {r1, r2, r8, r9, pc}
 9ac:	4a10054c 	bmi	401ee4 <__bss_end+0x3f87ac>
 9b0:	054c0a05 	strbeq	r0, [ip, #-2565]	; 0xfffff5fb
 9b4:	0305bb07 	movweq	fp, #23303	; 0x5b07
 9b8:	0017054a 	andseq	r0, r7, sl, asr #10
 9bc:	4a010402 	bmi	419cc <__bss_end+0x38294>
 9c0:	02001405 	andeq	r1, r0, #83886080	; 0x5000000
 9c4:	054a0104 	strbeq	r0, [sl, #-260]	; 0xfffffefc
 9c8:	14054d0d 	strne	r4, [r5], #-3341	; 0xfffff2f3
 9cc:	2e0a054a 	cfsh32cs	mvfx0, mvfx10, #42
 9d0:	05680805 	strbeq	r0, [r8, #-2053]!	; 0xfffff7fb
 9d4:	66780302 	ldrbtvs	r0, [r8], -r2, lsl #6
 9d8:	0b030905 	bleq	c2df4 <__bss_end+0xb96bc>
 9dc:	2f01052e 	svccs	0x0001052e
 9e0:	bd090585 	cfstr32lt	mvfx0, [r9, #-532]	; 0xfffffdec
 9e4:	02001605 	andeq	r1, r0, #5242880	; 0x500000
 9e8:	054a0404 	strbeq	r0, [sl, #-1028]	; 0xfffffbfc
 9ec:	0402001d 	streq	r0, [r2], #-29	; 0xffffffe3
 9f0:	1e058202 	cdpne	2, 0, cr8, cr5, cr2, {0}
 9f4:	02040200 	andeq	r0, r4, #0, 4
 9f8:	0016052e 	andseq	r0, r6, lr, lsr #10
 9fc:	66020402 	strvs	r0, [r2], -r2, lsl #8
 a00:	02001105 	andeq	r1, r0, #1073741825	; 0x40000001
 a04:	054b0304 	strbeq	r0, [fp, #-772]	; 0xfffffcfc
 a08:	04020012 	streq	r0, [r2], #-18	; 0xffffffee
 a0c:	08052e03 	stmdaeq	r5, {r0, r1, r9, sl, fp, sp}
 a10:	03040200 	movweq	r0, #16896	; 0x4200
 a14:	0009054a 	andeq	r0, r9, sl, asr #10
 a18:	2e030402 	cdpcs	4, 0, cr0, cr3, cr2, {0}
 a1c:	02001205 	andeq	r1, r0, #1342177280	; 0x50000000
 a20:	054a0304 	strbeq	r0, [sl, #-772]	; 0xfffffcfc
 a24:	0402000b 	streq	r0, [r2], #-11
 a28:	02052e03 	andeq	r2, r5, #3, 28	; 0x30
 a2c:	03040200 	movweq	r0, #16896	; 0x4200
 a30:	000b052d 	andeq	r0, fp, sp, lsr #10
 a34:	84020402 	strhi	r0, [r2], #-1026	; 0xfffffbfe
 a38:	02000805 	andeq	r0, r0, #327680	; 0x50000
 a3c:	05830104 	streq	r0, [r3, #260]	; 0x104
 a40:	04020009 	streq	r0, [r2], #-9
 a44:	0b052e01 	bleq	14c250 <__bss_end+0x142b18>
 a48:	01040200 	mrseq	r0, R12_usr
 a4c:	0002054a 	andeq	r0, r2, sl, asr #10
 a50:	49010402 	stmdbmi	r1, {r1, sl}
 a54:	05850b05 	streq	r0, [r5, #2821]	; 0xb05
 a58:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 a5c:	1105bc0e 	tstne	r5, lr, lsl #24
 a60:	bc200566 	cfstr32lt	mvfx0, [r0], #-408	; 0xfffffe68
 a64:	05660b05 	strbeq	r0, [r6, #-2821]!	; 0xfffff4fb
 a68:	0a054b1f 	beq	1536ec <__bss_end+0x149fb4>
 a6c:	4b080566 	blmi	20200c <__bss_end+0x1f88d4>
 a70:	05831105 	streq	r1, [r3, #261]	; 0x105
 a74:	08052e16 	stmdaeq	r5, {r1, r2, r4, r9, sl, fp, sp}
 a78:	67110567 	ldrvs	r0, [r1, -r7, ror #10]
 a7c:	054d0b05 	strbeq	r0, [sp, #-2821]	; 0xfffff4fb
 a80:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 a84:	0b058306 	bleq	1616a4 <__bss_end+0x157f6c>
 a88:	2e0c054c 	cfsh32cs	mvfx0, mvfx12, #44
 a8c:	05660e05 	strbeq	r0, [r6, #-3589]!	; 0xfffff1fb
 a90:	02054b04 	andeq	r4, r5, #4, 22	; 0x1000
 a94:	31090565 	tstcc	r9, r5, ror #10
 a98:	852f0105 	strhi	r0, [pc, #-261]!	; 99b <shift+0x99b>
 a9c:	059f0805 	ldreq	r0, [pc, #2053]	; 12a9 <shift+0x12a9>
 aa0:	14054c0b 	strne	r4, [r5], #-3083	; 0xfffff3f5
 aa4:	03040200 	movweq	r0, #16896	; 0x4200
 aa8:	0007054a 	andeq	r0, r7, sl, asr #10
 aac:	83020402 	movwhi	r0, #9218	; 0x2402
 ab0:	02000805 	andeq	r0, r0, #327680	; 0x50000
 ab4:	052e0204 	streq	r0, [lr, #-516]!	; 0xfffffdfc
 ab8:	0402000a 	streq	r0, [r2], #-10
 abc:	02054a02 	andeq	r4, r5, #8192	; 0x2000
 ac0:	02040200 	andeq	r0, r4, #0, 4
 ac4:	84010549 	strhi	r0, [r1], #-1353	; 0xfffffab7
 ac8:	bb0e0585 	bllt	3820e4 <__bss_end+0x3789ac>
 acc:	054b0805 	strbeq	r0, [fp, #-2053]	; 0xfffff7fb
 ad0:	14054c0b 	strne	r4, [r5], #-3083	; 0xfffff3f5
 ad4:	03040200 	movweq	r0, #16896	; 0x4200
 ad8:	0016054a 	andseq	r0, r6, sl, asr #10
 adc:	83020402 	movwhi	r0, #9218	; 0x2402
 ae0:	02001705 	andeq	r1, r0, #1310720	; 0x140000
 ae4:	052e0204 	streq	r0, [lr, #-516]!	; 0xfffffdfc
 ae8:	0402000a 	streq	r0, [r2], #-10
 aec:	0b054a02 	bleq	1532fc <__bss_end+0x149bc4>
 af0:	02040200 	andeq	r0, r4, #0, 4
 af4:	0017052e 	andseq	r0, r7, lr, lsr #10
 af8:	4a020402 	bmi	81b08 <__bss_end+0x783d0>
 afc:	02000d05 	andeq	r0, r0, #320	; 0x140
 b00:	052e0204 	streq	r0, [lr, #-516]!	; 0xfffffdfc
 b04:	04020002 	streq	r0, [r2], #-2
 b08:	01052d02 	tsteq	r5, r2, lsl #26
 b0c:	00080284 	andeq	r0, r8, r4, lsl #5
 b10:	04180101 	ldreq	r0, [r8], #-257	; 0xfffffeff
 b14:	00030000 	andeq	r0, r3, r0
 b18:	000002d6 	ldrdeq	r0, [r0], -r6
 b1c:	0efb0102 	cdpeq	1, 15, cr0, cr11, cr2, {0}
 b20:	0101000d 	tsteq	r1, sp
 b24:	00000101 	andeq	r0, r0, r1, lsl #2
 b28:	00000100 	andeq	r0, r0, r0, lsl #2
 b2c:	73552f01 	cmpvc	r5, #1, 30
 b30:	2f737265 	svccs	0x00737265
 b34:	746e6977 	strbtvc	r6, [lr], #-2423	; 0xfffff689
 b38:	696a7265 	stmdbvs	sl!, {r0, r2, r5, r6, r9, ip, sp, lr}^
 b3c:	7365442f 	cmnvc	r5, #788529152	; 0x2f000000
 b40:	706f746b 	rsbvc	r7, pc, fp, ror #8
 b44:	5641462f 	strbpl	r4, [r1], -pc, lsr #12
 b48:	76614e2f 	strbtvc	r4, [r1], -pc, lsr #28
 b4c:	6a757a61 	bvs	1d5f4d8 <__bss_end+0x1d55da0>
 b50:	2f696369 	svccs	0x00696369
 b54:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
 b58:	73656d65 	cmnvc	r5, #6464	; 0x1940
 b5c:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
 b60:	6b2d616b 	blvs	b59114 <__bss_end+0xb4f9dc>
 b64:	6f2d7669 	svcvs	0x002d7669
 b68:	6f732f73 	svcvs	0x00732f73
 b6c:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
 b70:	74732f73 	ldrbtvc	r2, [r3], #-3955	; 0xfffff08d
 b74:	69747564 	ldmdbvs	r4!, {r2, r5, r6, r8, sl, ip, sp, lr}^
 b78:	732f736c 			; <UNDEFINED> instruction: 0x732f736c
 b7c:	2f006372 	svccs	0x00006372
 b80:	72657355 	rsbvc	r7, r5, #1409286145	; 0x54000001
 b84:	69772f73 	ldmdbvs	r7!, {r0, r1, r4, r5, r6, r8, r9, sl, fp, sp}^
 b88:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
 b8c:	442f696a 	strtmi	r6, [pc], #-2410	; b94 <shift+0xb94>
 b90:	746b7365 	strbtvc	r7, [fp], #-869	; 0xfffffc9b
 b94:	462f706f 	strtmi	r7, [pc], -pc, rrx
 b98:	4e2f5641 	cfmadda32mi	mvax2, mvax5, mvfx15, mvfx1
 b9c:	7a617661 	bvc	185e528 <__bss_end+0x1854df0>
 ba0:	63696a75 	cmnvs	r9, #479232	; 0x75000
 ba4:	534f2f69 	movtpl	r2, #65385	; 0xff69
 ba8:	6d65732f 	stclvs	3, cr7, [r5, #-188]!	; 0xffffff44
 bac:	72747365 	rsbsvc	r7, r4, #-1811939327	; 0x94000001
 bb0:	616b6c61 	cmnvs	fp, r1, ror #24
 bb4:	76696b2d 	strbtvc	r6, [r9], -sp, lsr #22
 bb8:	2f736f2d 	svccs	0x00736f2d
 bbc:	72756f73 	rsbsvc	r6, r5, #460	; 0x1cc
 bc0:	2f736563 	svccs	0x00736563
 bc4:	6e72656b 	cdpvs	5, 7, cr6, cr2, cr11, {3}
 bc8:	692f6c65 	stmdbvs	pc!, {r0, r2, r5, r6, sl, fp, sp, lr}	; <UNPREDICTABLE>
 bcc:	756c636e 	strbvc	r6, [ip, #-878]!	; 0xfffffc92
 bd0:	622f6564 	eorvs	r6, pc, #100, 10	; 0x19000000
 bd4:	6472616f 	ldrbtvs	r6, [r2], #-367	; 0xfffffe91
 bd8:	6970722f 	ldmdbvs	r0!, {r0, r1, r2, r3, r5, r9, ip, sp, lr}^
 bdc:	61682f30 	cmnvs	r8, r0, lsr pc
 be0:	552f006c 	strpl	r0, [pc, #-108]!	; b7c <shift+0xb7c>
 be4:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 be8:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 bec:	6a726574 	bvs	1c9a1c4 <__bss_end+0x1c90a8c>
 bf0:	65442f69 	strbvs	r2, [r4, #-3945]	; 0xfffff097
 bf4:	6f746b73 	svcvs	0x00746b73
 bf8:	41462f70 	hvcmi	25328	; 0x62f0
 bfc:	614e2f56 	cmpvs	lr, r6, asr pc
 c00:	757a6176 	ldrbvc	r6, [sl, #-374]!	; 0xfffffe8a
 c04:	6963696a 	stmdbvs	r3!, {r1, r3, r5, r6, r8, fp, sp, lr}^
 c08:	2f534f2f 	svccs	0x00534f2f
 c0c:	656d6573 	strbvs	r6, [sp, #-1395]!	; 0xfffffa8d
 c10:	61727473 	cmnvs	r2, r3, ror r4
 c14:	2d616b6c 	vstmdbcs	r1!, {d22-<overflow reg d75>}
 c18:	2d76696b 			; <UNDEFINED> instruction: 0x2d76696b
 c1c:	732f736f 			; <UNDEFINED> instruction: 0x732f736f
 c20:	6372756f 	cmnvs	r2, #465567744	; 0x1bc00000
 c24:	732f7365 			; <UNDEFINED> instruction: 0x732f7365
 c28:	74756474 	ldrbtvc	r6, [r5], #-1140	; 0xfffffb8c
 c2c:	2f736c69 	svccs	0x00736c69
 c30:	6c636e69 	stclvs	14, cr6, [r3], #-420	; 0xfffffe5c
 c34:	00656475 	rsbeq	r6, r5, r5, ror r4
 c38:	6573552f 	ldrbvs	r5, [r3, #-1327]!	; 0xfffffad1
 c3c:	772f7372 			; <UNDEFINED> instruction: 0x772f7372
 c40:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
 c44:	2f696a72 	svccs	0x00696a72
 c48:	6b736544 	blvs	1cda160 <__bss_end+0x1cd0a28>
 c4c:	2f706f74 	svccs	0x00706f74
 c50:	2f564146 	svccs	0x00564146
 c54:	6176614e 	cmnvs	r6, lr, asr #2
 c58:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
 c5c:	4f2f6963 	svcmi	0x002f6963
 c60:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
 c64:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
 c68:	6b6c6172 	blvs	1b19238 <__bss_end+0x1b0fb00>
 c6c:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
 c70:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
 c74:	756f732f 	strbvc	r7, [pc, #-815]!	; 94d <shift+0x94d>
 c78:	73656372 	cmnvc	r5, #-939524095	; 0xc8000001
 c7c:	72656b2f 	rsbvc	r6, r5, #48128	; 0xbc00
 c80:	2f6c656e 	svccs	0x006c656e
 c84:	6c636e69 	stclvs	14, cr6, [r3], #-420	; 0xfffffe5c
 c88:	2f656475 	svccs	0x00656475
 c8c:	636f7270 	cmnvs	pc, #112, 4
 c90:	00737365 	rsbseq	r7, r3, r5, ror #6
 c94:	6573552f 	ldrbvs	r5, [r3, #-1327]!	; 0xfffffad1
 c98:	772f7372 			; <UNDEFINED> instruction: 0x772f7372
 c9c:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
 ca0:	2f696a72 	svccs	0x00696a72
 ca4:	6b736544 	blvs	1cda1bc <__bss_end+0x1cd0a84>
 ca8:	2f706f74 	svccs	0x00706f74
 cac:	2f564146 	svccs	0x00564146
 cb0:	6176614e 	cmnvs	r6, lr, asr #2
 cb4:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
 cb8:	4f2f6963 	svcmi	0x002f6963
 cbc:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
 cc0:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
 cc4:	6b6c6172 	blvs	1b19294 <__bss_end+0x1b0fb5c>
 cc8:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
 ccc:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
 cd0:	756f732f 	strbvc	r7, [pc, #-815]!	; 9a9 <shift+0x9a9>
 cd4:	73656372 	cmnvc	r5, #-939524095	; 0xc8000001
 cd8:	72656b2f 	rsbvc	r6, r5, #48128	; 0xbc00
 cdc:	2f6c656e 	svccs	0x006c656e
 ce0:	6c636e69 	stclvs	14, cr6, [r3], #-420	; 0xfffffe5c
 ce4:	2f656475 	svccs	0x00656475
 ce8:	2f007366 	svccs	0x00007366
 cec:	72657355 	rsbvc	r7, r5, #1409286145	; 0x54000001
 cf0:	69772f73 	ldmdbvs	r7!, {r0, r1, r4, r5, r6, r8, r9, sl, fp, sp}^
 cf4:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
 cf8:	442f696a 	strtmi	r6, [pc], #-2410	; d00 <shift+0xd00>
 cfc:	746b7365 	strbtvc	r7, [fp], #-869	; 0xfffffc9b
 d00:	462f706f 	strtmi	r7, [pc], -pc, rrx
 d04:	4e2f5641 	cfmadda32mi	mvax2, mvax5, mvfx15, mvfx1
 d08:	7a617661 	bvc	185e694 <__bss_end+0x1854f5c>
 d0c:	63696a75 	cmnvs	r9, #479232	; 0x75000
 d10:	534f2f69 	movtpl	r2, #65385	; 0xff69
 d14:	6d65732f 	stclvs	3, cr7, [r5, #-188]!	; 0xffffff44
 d18:	72747365 	rsbsvc	r7, r4, #-1811939327	; 0x94000001
 d1c:	616b6c61 	cmnvs	fp, r1, ror #24
 d20:	76696b2d 	strbtvc	r6, [r9], -sp, lsr #22
 d24:	2f736f2d 	svccs	0x00736f2d
 d28:	72756f73 	rsbsvc	r6, r5, #460	; 0x1cc
 d2c:	2f736563 	svccs	0x00736563
 d30:	6e72656b 	cdpvs	5, 7, cr6, cr2, cr11, {3}
 d34:	692f6c65 	stmdbvs	pc!, {r0, r2, r5, r6, sl, fp, sp, lr}	; <UNPREDICTABLE>
 d38:	756c636e 	strbvc	r6, [ip, #-878]!	; 0xfffffc92
 d3c:	642f6564 	strtvs	r6, [pc], #-1380	; d44 <shift+0xd44>
 d40:	65766972 	ldrbvs	r6, [r6, #-2418]!	; 0xfffff68e
 d44:	622f7372 	eorvs	r7, pc, #-939524095	; 0xc8000001
 d48:	67646972 			; <UNDEFINED> instruction: 0x67646972
 d4c:	00007365 	andeq	r7, r0, r5, ror #6
 d50:	64656c6f 	strbtvs	r6, [r5], #-3183	; 0xfffff391
 d54:	7070632e 	rsbsvc	r6, r0, lr, lsr #6
 d58:	00000100 	andeq	r0, r0, r0, lsl #2
 d5c:	64746e69 	ldrbtvs	r6, [r4], #-3689	; 0xfffff197
 d60:	682e6665 	stmdavs	lr!, {r0, r2, r5, r6, r9, sl, sp, lr}
 d64:	00000200 	andeq	r0, r0, r0, lsl #4
 d68:	64656c6f 	strbtvs	r6, [r5], #-3183	; 0xfffff391
 d6c:	0300682e 	movweq	r6, #2094	; 0x82e
 d70:	77730000 	ldrbvc	r0, [r3, -r0]!
 d74:	00682e69 	rsbeq	r2, r8, r9, ror #28
 d78:	73000004 	movwvc	r0, #4
 d7c:	6c6e6970 			; <UNDEFINED> instruction: 0x6c6e6970
 d80:	2e6b636f 	cdpcs	3, 6, cr6, cr11, cr15, {3}
 d84:	00040068 	andeq	r0, r4, r8, rrx
 d88:	6c696600 	stclvs	6, cr6, [r9], #-0
 d8c:	73797365 	cmnvc	r9, #-1811939327	; 0x94000001
 d90:	2e6d6574 	mcrcs	5, 3, r6, cr13, cr4, {3}
 d94:	00050068 	andeq	r0, r5, r8, rrx
 d98:	6f727000 	svcvs	0x00727000
 d9c:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
 da0:	0400682e 	streq	r6, [r0], #-2094	; 0xfffff7d2
 da4:	72700000 	rsbsvc	r0, r0, #0
 da8:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
 dac:	616d5f73 	smcvs	54771	; 0xd5f3
 db0:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
 db4:	00682e72 	rsbeq	r2, r8, r2, ror lr
 db8:	64000004 	strvs	r0, [r0], #-4
 dbc:	6c707369 	ldclvs	3, cr7, [r0], #-420	; 0xfffffe5c
 dc0:	705f7961 	subsvc	r7, pc, r1, ror #18
 dc4:	6f746f72 	svcvs	0x00746f72
 dc8:	2e6c6f63 	cdpcs	15, 6, cr6, cr12, cr3, {3}
 dcc:	00060068 	andeq	r0, r6, r8, rrx
 dd0:	72657000 	rsbvc	r7, r5, #0
 dd4:	65687069 	strbvs	r7, [r8, #-105]!	; 0xffffff97
 dd8:	736c6172 	cmnvc	ip, #-2147483620	; 0x8000001c
 ddc:	0200682e 	andeq	r6, r0, #3014656	; 0x2e0000
 de0:	6c6f0000 	stclvs	0, cr0, [pc], #-0	; de8 <shift+0xde8>
 de4:	665f6465 	ldrbvs	r6, [pc], -r5, ror #8
 de8:	2e746e6f 	cdpcs	14, 7, cr6, cr4, cr15, {3}
 dec:	00010068 	andeq	r0, r1, r8, rrx
 df0:	01050000 	mrseq	r0, (UNDEF: 5)
 df4:	4c020500 	cfstr32mi	mvfx0, [r2], {-0}
 df8:	0300008c 	movweq	r0, #140	; 0x8c
 dfc:	14050109 	strne	r0, [r5], #-265	; 0xfffffef7
 e00:	8248059f 	subhi	r0, r8, #666894336	; 0x27c00000
 e04:	05a11005 	streq	r1, [r1, #5]!
 e08:	0d054a18 	vstreq	s8, [r5, #-96]	; 0xffffffa0
 e0c:	4b010582 	blmi	4241c <__bss_end+0x38ce4>
 e10:	85090584 	strhi	r0, [r9, #-1412]	; 0xfffffa7c
 e14:	054a0505 	strbeq	r0, [sl, #-1285]	; 0xfffffafb
 e18:	0e054c11 	mcreq	12, 0, r4, cr5, cr1, {0}
 e1c:	84010567 	strhi	r0, [r1], #-1383	; 0xfffffa99
 e20:	830c0585 	movwhi	r0, #50565	; 0xc585
 e24:	854b0105 	strbhi	r0, [fp, #-261]	; 0xfffffefb
 e28:	05bb0a05 	ldreq	r0, [fp, #2565]!	; 0xa05
 e2c:	05054a09 	streq	r4, [r5, #-2569]	; 0xfffff5f7
 e30:	4e11054a 	cfmac32mi	mvfx0, mvfx1, mvfx10
 e34:	004b0f05 	subeq	r0, fp, r5, lsl #30
 e38:	06010402 	streq	r0, [r1], -r2, lsl #8
 e3c:	04020066 	streq	r0, [r2], #-102	; 0xffffff9a
 e40:	02004a02 	andeq	r4, r0, #8192	; 0x2000
 e44:	052e0404 	streq	r0, [lr, #-1028]!	; 0xfffffbfc
 e48:	04020007 	streq	r0, [r2], #-7
 e4c:	052f0604 	streq	r0, [pc, #-1540]!	; 850 <shift+0x850>
 e50:	0105d109 	tsteq	r5, r9, lsl #2
 e54:	0a054d34 	beq	15432c <__bss_end+0x14abf4>
 e58:	09059108 	stmdbeq	r5, {r3, r8, ip, pc}
 e5c:	4a05054a 	bmi	14238c <__bss_end+0x138c54>
 e60:	054f1405 	strbeq	r1, [pc, #-1029]	; a63 <shift+0xa63>
 e64:	11054b0f 	tstne	r5, pc, lsl #22
 e68:	1305f39f 	movwne	pc, #21407	; 0x539f	; <UNPREDICTABLE>
 e6c:	040200f3 	streq	r0, [r2], #-243	; 0xffffff0d
 e70:	00660601 	rsbeq	r0, r6, r1, lsl #12
 e74:	4a020402 	bmi	81e84 <__bss_end+0x7874c>
 e78:	04040200 	streq	r0, [r4], #-512	; 0xfffffe00
 e7c:	000a052e 	andeq	r0, sl, lr, lsr #10
 e80:	06040402 	streq	r0, [r4], -r2, lsl #8
 e84:	0309052f 	movweq	r0, #38191	; 0x952f
 e88:	0105d677 	tsteq	r5, r7, ror r6
 e8c:	4d2e0a03 	vstmdbmi	lr!, {s0-s2}
 e90:	91080a05 	tstls	r8, r5, lsl #20
 e94:	054a0905 	strbeq	r0, [sl, #-2309]	; 0xfffff6fb
 e98:	054e4a05 	strbeq	r4, [lr, #-2565]	; 0xfffff5fb
 e9c:	04020028 	streq	r0, [r2], #-40	; 0xffffffd8
 ea0:	23056601 	movwcs	r6, #22017	; 0x5601
 ea4:	01040200 	mrseq	r0, R12_usr
 ea8:	4f1e052e 	svcmi	0x001e052e
 eac:	054b1505 	strbeq	r1, [fp, #-1285]	; 0xfffffafb
 eb0:	05bb670c 	ldreq	r6, [fp, #1804]!	; 0x70c
 eb4:	2108bb0d 	tstcs	r8, sp, lsl #22
 eb8:	21081005 	tstcs	r8, r5
 ebc:	05684405 	strbeq	r4, [r8, #-1029]!	; 0xfffffbfb
 ec0:	40052e51 	andmi	r2, r5, r1, asr lr
 ec4:	9e0c052e 	cfsh32ls	mvfx0, mvfx12, #30
 ec8:	054a6c05 	strbeq	r6, [sl, #-3077]	; 0xfffff3fb
 ecc:	0a054a0b 	beq	153700 <__bss_end+0x149fc8>
 ed0:	03090568 	movweq	r0, #38248	; 0x9568
 ed4:	054ed66e 	strbeq	sp, [lr, #-1646]	; 0xfffff992
 ed8:	2e0f0301 	cdpcs	3, 0, cr0, cr15, cr1, {0}
 edc:	830a0569 	movwhi	r0, #42345	; 0xa569
 ee0:	054a0905 	strbeq	r0, [sl, #-2309]	; 0xfffff6fb
 ee4:	14054a05 	strne	r4, [r5], #-2565	; 0xfffff5fb
 ee8:	4c0a054e 	cfstr32mi	mvfx0, [sl], {78}	; 0x4e
 eec:	05d10905 	ldrbeq	r0, [r1, #2309]	; 0x905
 ef0:	054d3401 	strbeq	r3, [sp, #-1025]	; 0xfffffbff
 ef4:	0521080a 	streq	r0, [r1, #-2058]!	; 0xfffff7f6
 ef8:	05054a09 	streq	r4, [r5, #-2569]	; 0xfffff5f7
 efc:	4d0e054a 	cfstr32mi	mvfx0, [lr, #-296]	; 0xfffffed8
 f00:	054b1105 	strbeq	r1, [fp, #-261]	; 0xfffffefb
 f04:	19054c0c 	stmdbne	r5, {r2, r3, sl, fp, lr}
 f08:	0020054a 	eoreq	r0, r0, sl, asr #10
 f0c:	4a010402 	bmi	41f1c <__bss_end+0x387e4>
 f10:	02001905 	andeq	r1, r0, #81920	; 0x14000
 f14:	05660104 	strbeq	r0, [r6, #-260]!	; 0xfffffefc
 f18:	0c054c11 	stceq	12, cr4, [r5], {17}
 f1c:	050567bb 	streq	r6, [r5, #-1979]	; 0xfffff845
 f20:	29090562 	stmdbcs	r9, {r1, r5, r6, r8, sl}
 f24:	0b030105 	bleq	c1340 <__bss_end+0xb7c08>
 f28:	0004022e 	andeq	r0, r4, lr, lsr #4
 f2c:	Address 0x0000000000000f2c is out of bounds.


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
      58:	0b280704 	bleq	a01c70 <__bss_end+0x9f8538>
      5c:	5b020000 	blpl	80064 <__bss_end+0x7692c>
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
     128:	00000b28 	andeq	r0, r0, r8, lsr #22
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
     174:	cb104801 	blgt	412180 <__bss_end+0x408a48>
     178:	d4000000 	strle	r0, [r0], #-0
     17c:	58000081 	stmdapl	r0, {r0, r7}
     180:	01000000 	mrseq	r0, (UNDEF: 0)
     184:	0000cb9c 	muleq	r0, ip, fp
     188:	02b40a00 	adcseq	r0, r4, #0, 20
     18c:	4a010000 	bmi	40194 <__bss_end+0x36a5c>
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
     21c:	ba0d9c01 	blt	367228 <__bss_end+0x35daf0>
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
     24c:	8b120f01 	blhi	483e58 <__bss_end+0x47a720>
     250:	0f000001 	svceq	0x00000001
     254:	0000019e 	muleq	r0, lr, r1
     258:	03d51000 	bicseq	r1, r5, #0
     25c:	0a010000 	beq	40264 <__bss_end+0x36b2c>
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
     2b4:	8b140074 	blhi	50048c <__bss_end+0x4f6d54>
     2b8:	a4000001 	strge	r0, [r0], #-1
     2bc:	38000080 	stmdacc	r0, {r7}
     2c0:	01000000 	mrseq	r0, (UNDEF: 0)
     2c4:	0067139c 	mlseq	r7, ip, r3, r1
     2c8:	9e2f0a01 	vmulls.f32	s0, s30, s2
     2cc:	02000001 	andeq	r0, r0, #1
     2d0:	00007491 	muleq	r0, r1, r4
     2d4:	00000954 	andeq	r0, r0, r4, asr r9
     2d8:	01e00004 	mvneq	r0, r4
     2dc:	01040000 	mrseq	r0, (UNDEF: 4)
     2e0:	000001e1 	andeq	r0, r0, r1, ror #3
     2e4:	00063604 	andeq	r3, r6, r4, lsl #12
     2e8:	00005600 	andeq	r5, r0, r0, lsl #12
     2ec:	00822c00 	addeq	r2, r2, r0, lsl #24
     2f0:	00010c00 	andeq	r0, r1, r0, lsl #24
     2f4:	00024600 	andeq	r4, r2, r0, lsl #12
     2f8:	08010200 	stmdaeq	r1, {r9}
     2fc:	00000bc5 	andeq	r0, r0, r5, asr #23
     300:	00002503 	andeq	r2, r0, r3, lsl #10
     304:	05020200 	streq	r0, [r2, #-512]	; 0xfffffe00
     308:	00000a4e 	andeq	r0, r0, lr, asr #20
     30c:	69050404 	stmdbvs	r5, {r2, sl}
     310:	0200746e 	andeq	r7, r0, #1845493760	; 0x6e000000
     314:	0bbc0801 	bleq	fef02320 <__bss_end+0xfeef8be8>
     318:	e2050000 	and	r0, r5, #0
     31c:	02000009 	andeq	r0, r0, #9
     320:	00520708 	subseq	r0, r2, r8, lsl #14
     324:	02020000 	andeq	r0, r2, #0
     328:	000c8507 	andeq	r8, ip, r7, lsl #10
     32c:	062d0500 	strteq	r0, [sp], -r0, lsl #10
     330:	09020000 	stmdbeq	r2, {}	; <UNPREDICTABLE>
     334:	00006a07 	andeq	r6, r0, r7, lsl #20
     338:	00590300 	subseq	r0, r9, r0, lsl #6
     33c:	04020000 	streq	r0, [r2], #-0
     340:	000b2807 	andeq	r2, fp, r7, lsl #16
     344:	006a0300 	rsbeq	r0, sl, r0, lsl #6
     348:	33060000 	movwcc	r0, #24576	; 0x6000
     34c:	0800000d 	stmdaeq	r0, {r0, r2, r3}
     350:	9c080603 	stcls	6, cr0, [r8], {3}
     354:	07000000 	streq	r0, [r0, -r0]
     358:	03003072 	movweq	r3, #114	; 0x72
     35c:	00590e08 	subseq	r0, r9, r8, lsl #28
     360:	07000000 	streq	r0, [r0, -r0]
     364:	03003172 	movweq	r3, #370	; 0x172
     368:	00590e09 	subseq	r0, r9, r9, lsl #28
     36c:	00040000 	andeq	r0, r4, r0
     370:	000aa808 	andeq	sl, sl, r8, lsl #16
     374:	38040500 	stmdacc	r4, {r8, sl}
     378:	03000000 	movweq	r0, #0
     37c:	00d30c1e 	sbcseq	r0, r3, lr, lsl ip
     380:	25090000 	strcs	r0, [r9, #-0]
     384:	00000006 	andeq	r0, r0, r6
     388:	0007de09 	andeq	sp, r7, r9, lsl #28
     38c:	ca090100 	bgt	240794 <__bss_end+0x23705c>
     390:	0200000a 	andeq	r0, r0, #10
     394:	000bd809 	andeq	sp, fp, r9, lsl #16
     398:	bc090300 	stclt	3, cr0, [r9], {-0}
     39c:	04000007 	streq	r0, [r0], #-7
     3a0:	000a4509 	andeq	r4, sl, r9, lsl #10
     3a4:	08000500 	stmdaeq	r0, {r8, sl}
     3a8:	00000a90 	muleq	r0, r0, sl
     3ac:	00380405 	eorseq	r0, r8, r5, lsl #8
     3b0:	3f030000 	svccc	0x00030000
     3b4:	0001100c 	andeq	r1, r1, ip
     3b8:	075c0900 	ldrbeq	r0, [ip, -r0, lsl #18]
     3bc:	09000000 	stmdbeq	r0, {}	; <UNPREDICTABLE>
     3c0:	000007d9 	ldrdeq	r0, [r0], -r9
     3c4:	0ccc0901 			; <UNDEFINED> instruction: 0x0ccc0901
     3c8:	09020000 	stmdbeq	r2, {}	; <UNPREDICTABLE>
     3cc:	00000990 	muleq	r0, r0, r9
     3d0:	07cb0903 	strbeq	r0, [fp, r3, lsl #18]
     3d4:	09040000 	stmdbeq	r4, {}	; <UNPREDICTABLE>
     3d8:	00000840 	andeq	r0, r0, r0, asr #16
     3dc:	06c60905 	strbeq	r0, [r6], r5, lsl #18
     3e0:	00060000 	andeq	r0, r6, r0
     3e4:	00096e0a 	andeq	r6, r9, sl, lsl #28
     3e8:	14050400 	strne	r0, [r5], #-1024	; 0xfffffc00
     3ec:	00000065 	andeq	r0, r0, r5, rrx
     3f0:	93100305 	tstls	r0, #335544320	; 0x14000000
     3f4:	460a0000 	strmi	r0, [sl], -r0
     3f8:	0400000b 	streq	r0, [r0], #-11
     3fc:	00651406 	rsbeq	r1, r5, r6, lsl #8
     400:	03050000 	movweq	r0, #20480	; 0x5000
     404:	00009314 	andeq	r9, r0, r4, lsl r3
     408:	0008550a 	andeq	r5, r8, sl, lsl #10
     40c:	1a070500 	bne	1c1814 <__bss_end+0x1b80dc>
     410:	00000065 	andeq	r0, r0, r5, rrx
     414:	93180305 	tstls	r8, #335544320	; 0x14000000
     418:	670a0000 	strvs	r0, [sl, -r0]
     41c:	0500000a 	streq	r0, [r0, #-10]
     420:	00651a09 	rsbeq	r1, r5, r9, lsl #20
     424:	03050000 	movweq	r0, #20480	; 0x5000
     428:	0000931c 	andeq	r9, r0, ip, lsl r3
     42c:	0008470a 	andeq	r4, r8, sl, lsl #14
     430:	1a0b0500 	bne	2c1838 <__bss_end+0x2b8100>
     434:	00000065 	andeq	r0, r0, r5, rrx
     438:	93200305 			; <UNDEFINED> instruction: 0x93200305
     43c:	1b0a0000 	blne	280444 <__bss_end+0x276d0c>
     440:	0500000a 	streq	r0, [r0, #-10]
     444:	00651a0d 	rsbeq	r1, r5, sp, lsl #20
     448:	03050000 	movweq	r0, #20480	; 0x5000
     44c:	00009324 	andeq	r9, r0, r4, lsr #6
     450:	0006050a 	andeq	r0, r6, sl, lsl #10
     454:	1a0f0500 	bne	3c185c <__bss_end+0x3b8124>
     458:	00000065 	andeq	r0, r0, r5, rrx
     45c:	93280305 			; <UNDEFINED> instruction: 0x93280305
     460:	80080000 	andhi	r0, r8, r0
     464:	05000011 	streq	r0, [r0, #-17]	; 0xffffffef
     468:	00003804 	andeq	r3, r0, r4, lsl #16
     46c:	0c1b0500 	cfldr32eq	mvfx0, [fp], {-0}
     470:	000001b3 			; <UNDEFINED> instruction: 0x000001b3
     474:	00059109 	andeq	r9, r5, r9, lsl #2
     478:	03090000 	movweq	r0, #36864	; 0x9000
     47c:	0100000c 	tsteq	r0, ip
     480:	000cc709 	andeq	ip, ip, r9, lsl #14
     484:	0b000200 	bleq	c8c <shift+0xc8c>
     488:	00000459 	andeq	r0, r0, r9, asr r4
     48c:	b9020102 	stmdblt	r2, {r1, r8}
     490:	0c000008 	stceq	0, cr0, [r0], {8}
     494:	00002c04 	andeq	r2, r0, r4, lsl #24
     498:	b3040c00 	movwlt	r0, #19456	; 0x4c00
     49c:	0a000001 	beq	4a8 <shift+0x4a8>
     4a0:	0000059b 	muleq	r0, fp, r5
     4a4:	65140406 	ldrvs	r0, [r4, #-1030]	; 0xfffffbfa
     4a8:	05000000 	streq	r0, [r0, #-0]
     4ac:	00932c03 	addseq	r2, r3, r3, lsl #24
     4b0:	0ad00a00 	beq	ff402cb8 <__bss_end+0xff3f9580>
     4b4:	07060000 	streq	r0, [r6, -r0]
     4b8:	00006514 	andeq	r6, r0, r4, lsl r5
     4bc:	30030500 	andcc	r0, r3, r0, lsl #10
     4c0:	0a000093 	beq	714 <shift+0x714>
     4c4:	000004e2 	andeq	r0, r0, r2, ror #9
     4c8:	65140a06 	ldrvs	r0, [r4, #-2566]	; 0xfffff5fa
     4cc:	05000000 	streq	r0, [r0, #-0]
     4d0:	00933403 	addseq	r3, r3, r3, lsl #8
     4d4:	06cb0800 	strbeq	r0, [fp], r0, lsl #16
     4d8:	04050000 	streq	r0, [r5], #-0
     4dc:	00000038 	andeq	r0, r0, r8, lsr r0
     4e0:	380c0d06 	stmdacc	ip, {r1, r2, r8, sl, fp}
     4e4:	0d000002 	stceq	0, cr0, [r0, #-8]
     4e8:	0077654e 	rsbseq	r6, r7, lr, asr #10
     4ec:	04c20900 	strbeq	r0, [r2], #2304	; 0x900
     4f0:	09010000 	stmdbeq	r1, {}	; <UNPREDICTABLE>
     4f4:	000004da 	ldrdeq	r0, [r0], -sl
     4f8:	06e40902 	strbteq	r0, [r4], r2, lsl #18
     4fc:	09030000 	stmdbeq	r3, {}	; <UNPREDICTABLE>
     500:	00000bca 	andeq	r0, r0, sl, asr #23
     504:	04b60904 	ldrteq	r0, [r6], #2308	; 0x904
     508:	00050000 	andeq	r0, r5, r0
     50c:	0005b406 	andeq	fp, r5, r6, lsl #8
     510:	1b061000 	blne	184518 <__bss_end+0x17ade0>
     514:	00027708 	andeq	r7, r2, r8, lsl #14
     518:	726c0700 	rsbvc	r0, ip, #0, 14
     51c:	131d0600 	tstne	sp, #0, 12
     520:	00000277 	andeq	r0, r0, r7, ror r2
     524:	70730700 	rsbsvc	r0, r3, r0, lsl #14
     528:	131e0600 	tstne	lr, #0, 12
     52c:	00000277 	andeq	r0, r0, r7, ror r2
     530:	63700704 	cmnvs	r0, #4, 14	; 0x100000
     534:	131f0600 	tstne	pc, #0, 12
     538:	00000277 	andeq	r0, r0, r7, ror r2
     53c:	0a8a0e08 	beq	fe283d64 <__bss_end+0xfe27a62c>
     540:	20060000 	andcs	r0, r6, r0
     544:	00027713 	andeq	r7, r2, r3, lsl r7
     548:	02000c00 	andeq	r0, r0, #0, 24
     54c:	0b230704 	bleq	8c2164 <__bss_end+0x8b8a2c>
     550:	77030000 	strvc	r0, [r3, -r0]
     554:	06000002 	streq	r0, [r0], -r2
     558:	000007af 	andeq	r0, r0, pc, lsr #15
     55c:	08280670 	stmdaeq	r8!, {r4, r5, r6, r9, sl}
     560:	00000313 	andeq	r0, r0, r3, lsl r3
     564:	0007410e 	andeq	r4, r7, lr, lsl #2
     568:	122a0600 	eorne	r0, sl, #0, 12
     56c:	00000238 	andeq	r0, r0, r8, lsr r2
     570:	69700700 	ldmdbvs	r0!, {r8, r9, sl}^
     574:	2b060064 	blcs	18070c <__bss_end+0x176fd4>
     578:	00006a12 	andeq	r6, r0, r2, lsl sl
     57c:	fd0e1000 	stc2	0, cr1, [lr, #-0]
     580:	0600000b 	streq	r0, [r0], -fp
     584:	0201112c 	andeq	r1, r1, #44, 2
     588:	0e140000 	cdpeq	0, 1, cr0, cr4, cr0, {0}
     58c:	00000bae 	andeq	r0, r0, lr, lsr #23
     590:	6a122d06 	bvs	48b9b0 <__bss_end+0x482278>
     594:	18000000 	stmdane	r0, {}	; <UNPREDICTABLE>
     598:	0003e90e 	andeq	lr, r3, lr, lsl #18
     59c:	122e0600 	eorne	r0, lr, #0, 12
     5a0:	0000006a 	andeq	r0, r0, sl, rrx
     5a4:	0abd0e1c 	beq	fef43e1c <__bss_end+0xfef3a6e4>
     5a8:	2f060000 	svccs	0x00060000
     5ac:	0003130c 	andeq	r1, r3, ip, lsl #6
     5b0:	720e2000 	andvc	r2, lr, #0
     5b4:	06000004 	streq	r0, [r0], -r4
     5b8:	00380930 	eorseq	r0, r8, r0, lsr r9
     5bc:	0e600000 	cdpeq	0, 6, cr0, cr0, cr0, {0}
     5c0:	000006ff 	strdeq	r0, [r0], -pc	; <UNPREDICTABLE>
     5c4:	590e3106 	stmdbpl	lr, {r1, r2, r8, ip, sp}
     5c8:	64000000 	strvs	r0, [r0], #-0
     5cc:	0009d40e 	andeq	sp, r9, lr, lsl #8
     5d0:	0e330600 	cfmsuba32eq	mvax0, mvax0, mvfx3, mvfx0
     5d4:	00000059 	andeq	r0, r0, r9, asr r0
     5d8:	09cb0e68 	stmibeq	fp, {r3, r5, r6, r9, sl, fp}^
     5dc:	34060000 	strcc	r0, [r6], #-0
     5e0:	0000590e 	andeq	r5, r0, lr, lsl #18
     5e4:	0f006c00 	svceq	0x00006c00
     5e8:	000001c5 	andeq	r0, r0, r5, asr #3
     5ec:	00000323 	andeq	r0, r0, r3, lsr #6
     5f0:	00006a10 	andeq	r6, r0, r0, lsl sl
     5f4:	0a000f00 	beq	41fc <shift+0x41fc>
     5f8:	000004cb 	andeq	r0, r0, fp, asr #9
     5fc:	65140a07 	ldrvs	r0, [r4, #-2567]	; 0xfffff5f9
     600:	05000000 	streq	r0, [r0, #-0]
     604:	00933803 	addseq	r3, r3, r3, lsl #16
     608:	08900800 	ldmeq	r0, {fp}
     60c:	04050000 	streq	r0, [r5], #-0
     610:	00000038 	andeq	r0, r0, r8, lsr r0
     614:	540c0d07 	strpl	r0, [ip], #-3335	; 0xfffff2f9
     618:	09000003 	stmdbeq	r0, {r0, r1}
     61c:	00000cd2 	ldrdeq	r0, [r0], -r2
     620:	0c170900 			; <UNDEFINED> instruction: 0x0c170900
     624:	00010000 	andeq	r0, r1, r0
     628:	00072e06 	andeq	r2, r7, r6, lsl #28
     62c:	1b070c00 	blne	1c3634 <__bss_end+0x1b9efc>
     630:	00038908 	andeq	r8, r3, r8, lsl #18
     634:	053e0e00 	ldreq	r0, [lr, #-3584]!	; 0xfffff200
     638:	1d070000 	stcne	0, cr0, [r7, #-0]
     63c:	00038919 	andeq	r8, r3, r9, lsl r9
     640:	bd0e0000 	stclt	0, cr0, [lr, #-0]
     644:	07000004 	streq	r0, [r0, -r4]
     648:	0389191e 	orreq	r1, r9, #491520	; 0x78000
     64c:	0e040000 	cdpeq	0, 0, cr0, cr4, cr0, {0}
     650:	000008b4 			; <UNDEFINED> instruction: 0x000008b4
     654:	8f131f07 	svchi	0x00131f07
     658:	08000003 	stmdaeq	r0, {r0, r1}
     65c:	54040c00 	strpl	r0, [r4], #-3072	; 0xfffff400
     660:	0c000003 	stceq	0, cr0, [r0], {3}
     664:	00028304 	andeq	r8, r2, r4, lsl #6
     668:	0a791100 	beq	1e44a70 <__bss_end+0x1e3b338>
     66c:	07140000 	ldreq	r0, [r4, -r0]
     670:	06170722 	ldreq	r0, [r7], -r2, lsr #14
     674:	7c0e0000 	stcvc	0, cr0, [lr], {-0}
     678:	07000009 	streq	r0, [r0, -r9]
     67c:	00591226 	subseq	r1, r9, r6, lsr #4
     680:	0e000000 	cdpeq	0, 0, cr0, cr0, cr0, {0}
     684:	0000091e 	andeq	r0, r0, lr, lsl r9
     688:	891d2907 	ldmdbhi	sp, {r0, r1, r2, r8, fp, sp}
     68c:	04000003 	streq	r0, [r0], #-3
     690:	0006ec0e 	andeq	lr, r6, lr, lsl #24
     694:	1d2c0700 	stcne	7, cr0, [ip, #-0]
     698:	00000389 	andeq	r0, r0, r9, lsl #7
     69c:	09861208 	stmibeq	r6, {r3, r9, ip}
     6a0:	2f070000 	svccs	0x00070000
     6a4:	00070b0e 	andeq	r0, r7, lr, lsl #22
     6a8:	0003dd00 	andeq	sp, r3, r0, lsl #26
     6ac:	0003e800 	andeq	lr, r3, r0, lsl #16
     6b0:	061c1300 	ldreq	r1, [ip], -r0, lsl #6
     6b4:	89140000 	ldmdbhi	r4, {}	; <UNPREDICTABLE>
     6b8:	00000003 	andeq	r0, r0, r3
     6bc:	0007e815 	andeq	lr, r7, r5, lsl r8
     6c0:	0e310700 	cdpeq	7, 3, cr0, cr1, cr0, {0}
     6c4:	00000786 	andeq	r0, r0, r6, lsl #15
     6c8:	000001b8 			; <UNDEFINED> instruction: 0x000001b8
     6cc:	00000400 	andeq	r0, r0, r0, lsl #8
     6d0:	0000040b 	andeq	r0, r0, fp, lsl #8
     6d4:	00061c13 	andeq	r1, r6, r3, lsl ip
     6d8:	038f1400 	orreq	r1, pc, #0, 8
     6dc:	16000000 	strne	r0, [r0], -r0
     6e0:	00000bde 	ldrdeq	r0, [r0], -lr
     6e4:	6b1d3507 	blvs	74db08 <__bss_end+0x7443d0>
     6e8:	89000008 	stmdbhi	r0, {r3}
     6ec:	02000003 	andeq	r0, r0, #3
     6f0:	00000424 	andeq	r0, r0, r4, lsr #8
     6f4:	0000042a 	andeq	r0, r0, sl, lsr #8
     6f8:	00061c13 	andeq	r1, r6, r3, lsl ip
     6fc:	d7160000 	ldrle	r0, [r6, -r0]
     700:	07000006 	streq	r0, [r0, -r6]
     704:	09961d37 	ldmibeq	r6, {r0, r1, r2, r4, r5, r8, sl, fp, ip}
     708:	03890000 	orreq	r0, r9, #0
     70c:	43020000 	movwmi	r0, #8192	; 0x2000
     710:	49000004 	stmdbmi	r0, {r2}
     714:	13000004 	movwne	r0, #4
     718:	0000061c 	andeq	r0, r0, ip, lsl r6
     71c:	09311700 	ldmdbeq	r1!, {r8, r9, sl, ip}
     720:	39070000 	stmdbcc	r7, {}	; <UNPREDICTABLE>
     724:	00063531 	andeq	r3, r6, r1, lsr r5
     728:	16020c00 	strne	r0, [r2], -r0, lsl #24
     72c:	00000a79 	andeq	r0, r0, r9, ror sl
     730:	f7093c07 			; <UNDEFINED> instruction: 0xf7093c07
     734:	1c000007 	stcne	0, cr0, [r0], {7}
     738:	01000006 	tsteq	r0, r6
     73c:	00000470 	andeq	r0, r0, r0, ror r4
     740:	00000476 	andeq	r0, r0, r6, ror r4
     744:	00061c13 	andeq	r1, r6, r3, lsl ip
     748:	4d160000 	ldcmi	0, cr0, [r6, #-0]
     74c:	07000007 	streq	r0, [r0, -r7]
     750:	0513123f 	ldreq	r1, [r3, #-575]	; 0xfffffdc1
     754:	00590000 	subseq	r0, r9, r0
     758:	8f010000 	svchi	0x00010000
     75c:	a4000004 	strge	r0, [r0], #-4
     760:	13000004 	movwne	r0, #4
     764:	0000061c 	andeq	r0, r0, ip, lsl r6
     768:	00063e14 	andeq	r3, r6, r4, lsl lr
     76c:	006a1400 	rsbeq	r1, sl, r0, lsl #8
     770:	b8140000 	ldmdalt	r4, {}	; <UNPREDICTABLE>
     774:	00000001 	andeq	r0, r0, r1
     778:	000c0e18 	andeq	r0, ip, r8, lsl lr
     77c:	0e420700 	cdpeq	7, 4, cr0, cr2, cr0, {0}
     780:	000005c1 	andeq	r0, r0, r1, asr #11
     784:	0004b901 	andeq	fp, r4, r1, lsl #18
     788:	0004bf00 	andeq	fp, r4, r0, lsl #30
     78c:	061c1300 	ldreq	r1, [ip], -r0, lsl #6
     790:	16000000 	strne	r0, [r0], -r0
     794:	000004f5 	strdeq	r0, [r0], -r5
     798:	63174507 	tstvs	r7, #29360128	; 0x1c00000
     79c:	8f000005 	svchi	0x00000005
     7a0:	01000003 	tsteq	r0, r3
     7a4:	000004d8 	ldrdeq	r0, [r0], -r8
     7a8:	000004de 	ldrdeq	r0, [r0], -lr
     7ac:	00064413 	andeq	r4, r6, r3, lsl r4
     7b0:	db160000 	blle	5807b8 <__bss_end+0x577080>
     7b4:	0700000a 	streq	r0, [r0, -sl]
     7b8:	03ff1748 	mvnseq	r1, #72, 14	; 0x1200000
     7bc:	038f0000 	orreq	r0, pc, #0
     7c0:	f7010000 			; <UNDEFINED> instruction: 0xf7010000
     7c4:	02000004 	andeq	r0, r0, #4
     7c8:	13000005 	movwne	r0, #5
     7cc:	00000644 	andeq	r0, r0, r4, asr #12
     7d0:	00005914 	andeq	r5, r0, r4, lsl r9
     7d4:	0f180000 	svceq	0x00180000
     7d8:	07000006 	streq	r0, [r0, -r6]
     7dc:	093f0e4b 	ldmdbeq	pc!, {r0, r1, r3, r6, r9, sl, fp}	; <UNPREDICTABLE>
     7e0:	17010000 	strne	r0, [r1, -r0]
     7e4:	1d000005 	stcne	0, cr0, [r0, #-20]	; 0xffffffec
     7e8:	13000005 	movwne	r0, #5
     7ec:	0000061c 	andeq	r0, r0, ip, lsl r6
     7f0:	07e81600 	strbeq	r1, [r8, r0, lsl #12]!
     7f4:	4d070000 	stcmi	0, cr0, [r7, #-0]
     7f8:	0009f30e 	andeq	pc, r9, lr, lsl #6
     7fc:	0001b800 	andeq	fp, r1, r0, lsl #16
     800:	05360100 	ldreq	r0, [r6, #-256]!	; 0xffffff00
     804:	05410000 	strbeq	r0, [r1, #-0]
     808:	1c130000 	ldcne	0, cr0, [r3], {-0}
     80c:	14000006 	strne	r0, [r0], #-6
     810:	00000059 	andeq	r0, r0, r9, asr r0
     814:	04a21600 	strteq	r1, [r2], #1536	; 0x600
     818:	50070000 	andpl	r0, r7, r0
     81c:	00042c12 	andeq	r2, r4, r2, lsl ip
     820:	00005900 	andeq	r5, r0, r0, lsl #18
     824:	055a0100 	ldrbeq	r0, [sl, #-256]	; 0xffffff00
     828:	05650000 	strbeq	r0, [r5, #-0]!
     82c:	1c130000 	ldcne	0, cr0, [r3], {-0}
     830:	14000006 	strne	r0, [r0], #-6
     834:	000001c5 	andeq	r0, r0, r5, asr #3
     838:	045f1600 	ldrbeq	r1, [pc], #-1536	; 840 <shift+0x840>
     83c:	53070000 	movwpl	r0, #28672	; 0x7000
     840:	000c430e 	andeq	r4, ip, lr, lsl #6
     844:	0001b800 	andeq	fp, r1, r0, lsl #16
     848:	057e0100 	ldrbeq	r0, [lr, #-256]!	; 0xffffff00
     84c:	05890000 	streq	r0, [r9]
     850:	1c130000 	ldcne	0, cr0, [r3], {-0}
     854:	14000006 	strne	r0, [r0], #-6
     858:	00000059 	andeq	r0, r0, r9, asr r0
     85c:	047c1800 	ldrbteq	r1, [ip], #-2048	; 0xfffff800
     860:	56070000 	strpl	r0, [r7], -r0
     864:	000b520e 	andeq	r5, fp, lr, lsl #4
     868:	059e0100 	ldreq	r0, [lr, #256]	; 0x100
     86c:	05bd0000 	ldreq	r0, [sp, #0]!
     870:	1c130000 	ldcne	0, cr0, [r3], {-0}
     874:	14000006 	strne	r0, [r0], #-6
     878:	0000009c 	muleq	r0, ip, r0
     87c:	00005914 	andeq	r5, r0, r4, lsl r9
     880:	00591400 	subseq	r1, r9, r0, lsl #8
     884:	59140000 	ldmdbpl	r4, {}	; <UNPREDICTABLE>
     888:	14000000 	strne	r0, [r0], #-0
     88c:	0000064a 	andeq	r0, r0, sl, asr #12
     890:	0c6f1800 	stcleq	8, cr1, [pc], #-0	; 898 <shift+0x898>
     894:	58070000 	stmdapl	r7, {}	; <UNPREDICTABLE>
     898:	000ce70e 	andeq	lr, ip, lr, lsl #14
     89c:	05d20100 	ldrbeq	r0, [r2, #256]	; 0x100
     8a0:	05f10000 	ldrbeq	r0, [r1, #0]!
     8a4:	1c130000 	ldcne	0, cr0, [r3], {-0}
     8a8:	14000006 	strne	r0, [r0], #-6
     8ac:	000000d3 	ldrdeq	r0, [r0], -r3
     8b0:	00005914 	andeq	r5, r0, r4, lsl r9
     8b4:	00591400 	subseq	r1, r9, r0, lsl #8
     8b8:	59140000 	ldmdbpl	r4, {}	; <UNPREDICTABLE>
     8bc:	14000000 	strne	r0, [r0], #-0
     8c0:	0000064a 	andeq	r0, r0, sl, asr #12
     8c4:	048f1900 	streq	r1, [pc], #2304	; 8cc <shift+0x8cc>
     8c8:	5b070000 	blpl	1c08d0 <__bss_end+0x1b7198>
     8cc:	0008be0e 	andeq	fp, r8, lr, lsl #28
     8d0:	0001b800 	andeq	fp, r1, r0, lsl #16
     8d4:	06060100 	streq	r0, [r6], -r0, lsl #2
     8d8:	1c130000 	ldcne	0, cr0, [r3], {-0}
     8dc:	14000006 	strne	r0, [r0], #-6
     8e0:	00000335 	andeq	r0, r0, r5, lsr r3
     8e4:	00065014 	andeq	r5, r6, r4, lsl r0
     8e8:	03000000 	movweq	r0, #0
     8ec:	00000395 	muleq	r0, r5, r3
     8f0:	0395040c 	orrseq	r0, r5, #12, 8	; 0xc000000
     8f4:	891a0000 	ldmdbhi	sl, {}	; <UNPREDICTABLE>
     8f8:	2f000003 	svccs	0x00000003
     8fc:	35000006 	strcc	r0, [r0, #-6]
     900:	13000006 	movwne	r0, #6
     904:	0000061c 	andeq	r0, r0, ip, lsl r6
     908:	03951b00 	orrseq	r1, r5, #0, 22
     90c:	06220000 	strteq	r0, [r2], -r0
     910:	040c0000 	streq	r0, [ip], #-0
     914:	0000003f 	andeq	r0, r0, pc, lsr r0
     918:	0617040c 	ldreq	r0, [r7], -ip, lsl #8
     91c:	041c0000 	ldreq	r0, [ip], #-0
     920:	00000076 	andeq	r0, r0, r6, ror r0
     924:	5911041d 	ldmdbpl	r1, {r0, r2, r3, r4, sl}
     928:	0800000a 	stmdaeq	r0, {r1, r3}
     92c:	96070608 	strls	r0, [r7], -r8, lsl #12
     930:	0e000007 	cdpeq	0, 0, cr0, cr0, cr7, {0}
     934:	000007d1 	ldrdeq	r0, [r0], -r1
     938:	59120a08 	ldmdbpl	r2, {r3, r9, fp}
     93c:	00000000 	andeq	r0, r0, r0
     940:	0009eb0e 	andeq	lr, r9, lr, lsl #22
     944:	0e0c0800 	cdpeq	8, 0, cr0, cr12, cr0, {0}
     948:	000001b8 			; <UNDEFINED> instruction: 0x000001b8
     94c:	0a591604 	beq	1646164 <__bss_end+0x163ca2c>
     950:	10080000 	andne	r0, r8, r0
     954:	0005e209 	andeq	lr, r5, r9, lsl #4
     958:	00079b00 	andeq	r9, r7, r0, lsl #22
     95c:	06920100 	ldreq	r0, [r2], r0, lsl #2
     960:	069d0000 	ldreq	r0, [sp], r0
     964:	9b130000 	blls	4c096c <__bss_end+0x4b7234>
     968:	14000007 	strne	r0, [r0], #-7
     96c:	000001bf 			; <UNDEFINED> instruction: 0x000001bf
     970:	0a581600 	beq	1606178 <__bss_end+0x15fca40>
     974:	12080000 	andne	r0, r8, #0
     978:	000a2e15 	andeq	r2, sl, r5, lsl lr
     97c:	00065000 	andeq	r5, r6, r0
     980:	06b60100 	ldrteq	r0, [r6], r0, lsl #2
     984:	06c10000 	strbeq	r0, [r1], r0
     988:	9b130000 	blls	4c0990 <__bss_end+0x4b7258>
     98c:	13000007 	movwne	r0, #7
     990:	00000038 	andeq	r0, r0, r8, lsr r0
     994:	05fb1600 	ldrbeq	r1, [fp, #1536]!	; 0x600
     998:	15080000 	strne	r0, [r8, #-0]
     99c:	0008200e 	andeq	r2, r8, lr
     9a0:	0001b800 	andeq	fp, r1, r0, lsl #16
     9a4:	06da0100 	ldrbeq	r0, [sl], r0, lsl #2
     9a8:	06e00000 	strbteq	r0, [r0], r0
     9ac:	a1130000 	tstge	r3, r0
     9b0:	00000007 	andeq	r0, r0, r7
     9b4:	000b3518 	andeq	r3, fp, r8, lsl r5
     9b8:	0e180800 	cdpeq	8, 1, cr0, cr8, cr0, {0}
     9bc:	0000076c 	andeq	r0, r0, ip, ror #14
     9c0:	0006f501 	andeq	pc, r6, r1, lsl #10
     9c4:	0006fb00 	andeq	pc, r6, r0, lsl #22
     9c8:	079b1300 	ldreq	r1, [fp, r0, lsl #6]
     9cc:	18000000 	stmdane	r0, {}	; <UNPREDICTABLE>
     9d0:	0000081a 	andeq	r0, r0, sl, lsl r8
     9d4:	980e1b08 	stmdals	lr, {r3, r8, r9, fp, ip}
     9d8:	01000006 	tsteq	r0, r6
     9dc:	00000710 	andeq	r0, r0, r0, lsl r7
     9e0:	0000071b 	andeq	r0, r0, fp, lsl r7
     9e4:	00079b13 	andeq	r9, r7, r3, lsl fp
     9e8:	01b81400 			; <UNDEFINED> instruction: 0x01b81400
     9ec:	18000000 	stmdane	r0, {}	; <UNPREDICTABLE>
     9f0:	00000ba4 	andeq	r0, r0, r4, lsr #23
     9f4:	220e1d08 	andcs	r1, lr, #8, 26	; 0x200
     9f8:	0100000c 	tsteq	r0, ip
     9fc:	00000730 	andeq	r0, r0, r0, lsr r7
     a00:	00000745 	andeq	r0, r0, r5, asr #14
     a04:	00079b13 	andeq	r9, r7, r3, lsl fp
     a08:	00461400 	subeq	r1, r6, r0, lsl #8
     a0c:	46140000 	ldrmi	r0, [r4], -r0
     a10:	14000000 	strne	r0, [r0], #-0
     a14:	000001b8 			; <UNDEFINED> instruction: 0x000001b8
     a18:	06bd1800 	ldrteq	r1, [sp], r0, lsl #16
     a1c:	1f080000 	svcne	0x00080000
     a20:	0005430e 	andeq	r4, r5, lr, lsl #6
     a24:	075a0100 	ldrbeq	r0, [sl, -r0, lsl #2]
     a28:	076f0000 	strbeq	r0, [pc, -r0]!
     a2c:	9b130000 	blls	4c0a34 <__bss_end+0x4b72fc>
     a30:	14000007 	strne	r0, [r0], #-7
     a34:	00000046 	andeq	r0, r0, r6, asr #32
     a38:	00004614 	andeq	r4, r0, r4, lsl r6
     a3c:	00251400 	eoreq	r1, r5, r0, lsl #8
     a40:	1e000000 	cdpne	0, 0, cr0, cr0, cr0, {0}
     a44:	00000ca2 	andeq	r0, r0, r2, lsr #25
     a48:	fe0e2108 	cdp2	1, 0, cr2, cr14, cr8, {0}
     a4c:	0100000a 	tsteq	r0, sl
     a50:	00000780 	andeq	r0, r0, r0, lsl #15
     a54:	00079b13 	andeq	r9, r7, r3, lsl fp
     a58:	00461400 	subeq	r1, r6, r0, lsl #8
     a5c:	46140000 	ldrmi	r0, [r4], -r0
     a60:	14000000 	strne	r0, [r0], #-0
     a64:	000001bf 			; <UNDEFINED> instruction: 0x000001bf
     a68:	52030000 	andpl	r0, r3, #0
     a6c:	0c000006 	stceq	0, cr0, [r0], {6}
     a70:	00065204 	andeq	r5, r6, r4, lsl #4
     a74:	96040c00 	strls	r0, [r4], -r0, lsl #24
     a78:	1f000007 	svcne	0x00000007
     a7c:	006c6168 	rsbeq	r6, ip, r8, ror #2
     a80:	610b0509 	tstvs	fp, r9, lsl #10
     a84:	20000008 	andcs	r0, r0, r8
     a88:	0000090b 	andeq	r0, r0, fp, lsl #18
     a8c:	71190709 	tstvc	r9, r9, lsl #14
     a90:	80000000 	andhi	r0, r0, r0
     a94:	200ee6b2 			; <UNDEFINED> instruction: 0x200ee6b2
     a98:	00000aee 	andeq	r0, r0, lr, ror #21
     a9c:	7e1a0a09 	vnmlsvc.f32	s0, s20, s18
     aa0:	00000002 	andeq	r0, r0, r2
     aa4:	20200000 	eorcs	r0, r0, r0
     aa8:	00000509 	andeq	r0, r0, r9, lsl #10
     aac:	7e1a0d09 	cdpvc	13, 1, cr0, cr10, cr9, {0}
     ab0:	00000002 	andeq	r0, r0, r2
     ab4:	21202000 			; <UNDEFINED> instruction: 0x21202000
     ab8:	000008a5 	andeq	r0, r0, r5, lsr #17
     abc:	65151009 	ldrvs	r1, [r5, #-9]
     ac0:	36000000 	strcc	r0, [r0], -r0
     ac4:	000bea20 	andeq	lr, fp, r0, lsr #20
     ac8:	1a420900 	bne	1082ed0 <__bss_end+0x1079798>
     acc:	0000027e 	andeq	r0, r0, lr, ror r2
     ad0:	20215000 	eorcs	r5, r1, r0
     ad4:	000cad20 	andeq	sl, ip, r0, lsr #26
     ad8:	1a710900 	bne	1c42ee0 <__bss_end+0x1c397a8>
     adc:	0000027e 	andeq	r0, r0, lr, ror r2
     ae0:	2000b200 	andcs	fp, r0, r0, lsl #4
     ae4:	00076120 	andeq	r6, r7, r0, lsr #2
     ae8:	1aa40900 	bne	fe902ef0 <__bss_end+0xfe8f97b8>
     aec:	0000027e 	andeq	r0, r0, lr, ror r2
     af0:	2000b400 	andcs	fp, r0, r0, lsl #8
     af4:	00090120 	andeq	r0, r9, r0, lsr #2
     af8:	1ab30900 	bne	fecc2f00 <__bss_end+0xfecb97c8>
     afc:	0000027e 	andeq	r0, r0, lr, ror r2
     b00:	20104000 	andscs	r4, r0, r0
     b04:	0009bc20 	andeq	fp, r9, r0, lsr #24
     b08:	1abe0900 	bne	fef82f10 <__bss_end+0xfef797d8>
     b0c:	0000027e 	andeq	r0, r0, lr, ror r2
     b10:	20205000 	eorcs	r5, r0, r0
     b14:	0006b320 	andeq	fp, r6, r0, lsr #6
     b18:	1abf0900 	bne	fefc2f20 <__bss_end+0xfefb97e8>
     b1c:	0000027e 	andeq	r0, r0, lr, ror r2
     b20:	20804000 	addcs	r4, r0, r0
     b24:	000bf320 	andeq	pc, fp, r0, lsr #6
     b28:	1ac00900 	bne	ff002f30 <__bss_end+0xfeff97f8>
     b2c:	0000027e 	andeq	r0, r0, lr, ror r2
     b30:	20805000 	addcs	r5, r0, r0
     b34:	07b32200 	ldreq	r2, [r3, r0, lsl #4]!
     b38:	c3220000 			; <UNDEFINED> instruction: 0xc3220000
     b3c:	22000007 	andcs	r0, r0, #7
     b40:	000007d3 	ldrdeq	r0, [r0], -r3
     b44:	0007e322 	andeq	lr, r7, r2, lsr #6
     b48:	07f02200 	ldrbeq	r2, [r0, r0, lsl #4]!
     b4c:	00220000 	eoreq	r0, r2, r0
     b50:	22000008 	andcs	r0, r0, #8
     b54:	00000810 	andeq	r0, r0, r0, lsl r8
     b58:	00082022 	andeq	r2, r8, r2, lsr #32
     b5c:	08302200 	ldmdaeq	r0!, {r9, sp}
     b60:	40220000 	eormi	r0, r2, r0
     b64:	22000008 	andcs	r0, r0, #8
     b68:	00000850 	andeq	r0, r0, r0, asr r8
     b6c:	000b3a0a 	andeq	r3, fp, sl, lsl #20
     b70:	14080a00 	strne	r0, [r8], #-2560	; 0xfffff600
     b74:	00000065 	andeq	r0, r0, r5, rrx
     b78:	93680305 	cmnls	r8, #335544320	; 0x14000000
     b7c:	bf0f0000 	svclt	0x000f0000
     b80:	ba000001 	blt	b8c <shift+0xb8c>
     b84:	10000008 	andne	r0, r0, r8
     b88:	0000006a 	andeq	r0, r0, sl, rrx
     b8c:	11230004 			; <UNDEFINED> instruction: 0x11230004
     b90:	01000008 	tsteq	r0, r8
     b94:	08aa0d12 	stmiaeq	sl!, {r1, r4, r8, sl, fp}
     b98:	03050000 	movweq	r0, #20480	; 0x5000
     b9c:	00009714 	andeq	r9, r0, r4, lsl r7
     ba0:	000c9824 	andeq	r9, ip, r4, lsr #16
     ba4:	051a0100 	ldreq	r0, [sl, #-256]	; 0xffffff00
     ba8:	00000038 	andeq	r0, r0, r8, lsr r0
     bac:	0000822c 	andeq	r8, r0, ip, lsr #4
     bb0:	0000010c 	andeq	r0, r0, ip, lsl #2
     bb4:	094b9c01 	stmdbeq	fp, {r0, sl, fp, ip, pc}^
     bb8:	c6250000 	strtgt	r0, [r5], -r0
     bbc:	01000009 	tsteq	r0, r9
     bc0:	00380e1a 	eorseq	r0, r8, sl, lsl lr
     bc4:	91020000 	mrsls	r0, (UNDEF: 2)
     bc8:	09dd255c 	ldmibeq	sp, {r2, r3, r4, r6, r8, sl, sp}^
     bcc:	1a010000 	bne	40bd4 <__bss_end+0x3749c>
     bd0:	00094b1b 	andeq	r4, r9, fp, lsl fp
     bd4:	58910200 	ldmpl	r1, {r9}
     bd8:	000c9d26 	andeq	r9, ip, r6, lsr #26
     bdc:	101c0100 	andsne	r0, ip, r0, lsl #2
     be0:	00000652 	andeq	r0, r0, r2, asr r6
     be4:	26689102 	strbtcs	r9, [r8], -r2, lsl #2
     be8:	00000d3f 	andeq	r0, r0, pc, lsr sp
     bec:	590b2101 	stmdbpl	fp, {r0, r8, sp}
     bf0:	02000000 	andeq	r0, r0, #0
     bf4:	6e277491 	mcrvs	4, 1, r7, cr7, cr1, {4}
     bf8:	01006d75 	tsteq	r0, r5, ror sp
     bfc:	00590b22 	subseq	r0, r9, r2, lsr #22
     c00:	91020000 	mrsls	r0, (UNDEF: 2)
     c04:	82a42864 	adchi	r2, r4, #100, 16	; 0x640000
     c08:	007c0000 	rsbseq	r0, ip, r0
     c0c:	6d270000 	stcvs	0, cr0, [r7, #-0]
     c10:	01006773 	tsteq	r0, r3, ror r7
     c14:	01bf0f2a 			; <UNDEFINED> instruction: 0x01bf0f2a
     c18:	91020000 	mrsls	r0, (UNDEF: 2)
     c1c:	0c000070 	stceq	0, cr0, [r0], {112}	; 0x70
     c20:	00095104 	andeq	r5, r9, r4, lsl #2
     c24:	25040c00 	strcs	r0, [r4, #-3072]	; 0xfffff400
     c28:	00000000 	andeq	r0, r0, r0
     c2c:	00000b1f 	andeq	r0, r0, pc, lsl fp
     c30:	044a0004 	strbeq	r0, [sl], #-4
     c34:	01040000 	mrseq	r0, (UNDEF: 4)
     c38:	0000107c 	andeq	r1, r0, ip, ror r0
     c3c:	000f5a04 	andeq	r5, pc, r4, lsl #20
     c40:	000d4900 	andeq	r4, sp, r0, lsl #18
     c44:	00833800 	addeq	r3, r3, r0, lsl #16
     c48:	00045c00 	andeq	r5, r4, r0, lsl #24
     c4c:	0005a700 	andeq	sl, r5, r0, lsl #14
     c50:	08010200 	stmdaeq	r1, {r9}
     c54:	00000bc5 	andeq	r0, r0, r5, asr #23
     c58:	00002503 	andeq	r2, r0, r3, lsl #10
     c5c:	05020200 	streq	r0, [r2, #-512]	; 0xfffffe00
     c60:	00000a4e 	andeq	r0, r0, lr, asr #20
     c64:	69050404 	stmdbvs	r5, {r2, sl}
     c68:	0200746e 	andeq	r7, r0, #1845493760	; 0x6e000000
     c6c:	0bbc0801 	bleq	fef02c78 <__bss_end+0xfeef9540>
     c70:	02020000 	andeq	r0, r2, #0
     c74:	000c8507 	andeq	r8, ip, r7, lsl #10
     c78:	062d0500 	strteq	r0, [sp], -r0, lsl #10
     c7c:	09070000 	stmdbeq	r7, {}	; <UNPREDICTABLE>
     c80:	00005e07 	andeq	r5, r0, r7, lsl #28
     c84:	004d0300 	subeq	r0, sp, r0, lsl #6
     c88:	04020000 	streq	r0, [r2], #-0
     c8c:	000b2807 	andeq	r2, fp, r7, lsl #16
     c90:	0d330600 	ldceq	6, cr0, [r3, #-0]
     c94:	02080000 	andeq	r0, r8, #0
     c98:	008b0806 	addeq	r0, fp, r6, lsl #16
     c9c:	72070000 	andvc	r0, r7, #0
     ca0:	08020030 	stmdaeq	r2, {r4, r5}
     ca4:	00004d0e 	andeq	r4, r0, lr, lsl #26
     ca8:	72070000 	andvc	r0, r7, #0
     cac:	09020031 	stmdbeq	r2, {r0, r4, r5}
     cb0:	00004d0e 	andeq	r4, r0, lr, lsl #26
     cb4:	08000400 	stmdaeq	r0, {sl}
     cb8:	00001006 	andeq	r1, r0, r6
     cbc:	00380405 	eorseq	r0, r8, r5, lsl #8
     cc0:	0d020000 	stceq	0, cr0, [r2, #-0]
     cc4:	0000a90c 	andeq	sl, r0, ip, lsl #18
     cc8:	4b4f0900 	blmi	13c30d0 <__bss_end+0x13b9998>
     ccc:	f70a0000 			; <UNDEFINED> instruction: 0xf70a0000
     cd0:	0100000d 	tsteq	r0, sp
     cd4:	0aa80800 	beq	fea02cdc <__bss_end+0xfe9f95a4>
     cd8:	04050000 	streq	r0, [r5], #-0
     cdc:	00000038 	andeq	r0, r0, r8, lsr r0
     ce0:	e00c1e02 	and	r1, ip, r2, lsl #28
     ce4:	0a000000 	beq	cec <shift+0xcec>
     ce8:	00000625 	andeq	r0, r0, r5, lsr #12
     cec:	07de0a00 	ldrbeq	r0, [lr, r0, lsl #20]
     cf0:	0a010000 	beq	40cf8 <__bss_end+0x375c0>
     cf4:	00000aca 	andeq	r0, r0, sl, asr #21
     cf8:	0bd80a02 	bleq	ff603508 <__bss_end+0xff5f9dd0>
     cfc:	0a030000 	beq	c0d04 <__bss_end+0xb75cc>
     d00:	000007bc 			; <UNDEFINED> instruction: 0x000007bc
     d04:	0a450a04 	beq	114351c <__bss_end+0x1139de4>
     d08:	00050000 	andeq	r0, r5, r0
     d0c:	000a9008 	andeq	r9, sl, r8
     d10:	38040500 	stmdacc	r4, {r8, sl}
     d14:	02000000 	andeq	r0, r0, #0
     d18:	011d0c3f 	tsteq	sp, pc, lsr ip
     d1c:	5c0a0000 	stcpl	0, cr0, [sl], {-0}
     d20:	00000007 	andeq	r0, r0, r7
     d24:	0007d90a 	andeq	sp, r7, sl, lsl #18
     d28:	cc0a0100 	stfgts	f0, [sl], {-0}
     d2c:	0200000c 	andeq	r0, r0, #12
     d30:	0009900a 	andeq	r9, r9, sl
     d34:	cb0a0300 	blgt	28193c <__bss_end+0x278204>
     d38:	04000007 	streq	r0, [r0], #-7
     d3c:	0008400a 	andeq	r4, r8, sl
     d40:	c60a0500 	strgt	r0, [sl], -r0, lsl #10
     d44:	06000006 	streq	r0, [r0], -r6
     d48:	112d0800 			; <UNDEFINED> instruction: 0x112d0800
     d4c:	04050000 	streq	r0, [r5], #-0
     d50:	00000038 	andeq	r0, r0, r8, lsr r0
     d54:	480c6602 	stmdami	ip, {r1, r9, sl, sp, lr}
     d58:	0a000001 	beq	d64 <shift+0xd64>
     d5c:	00000f4f 	andeq	r0, r0, pc, asr #30
     d60:	0e540a00 	vnmlseq.f32	s1, s8, s0
     d64:	0a010000 	beq	40d6c <__bss_end+0x37634>
     d68:	00000fcf 	andeq	r0, r0, pc, asr #31
     d6c:	0e790a02 	vaddeq.f32	s1, s18, s4
     d70:	00030000 	andeq	r0, r3, r0
     d74:	00096e0b 	andeq	r6, r9, fp, lsl #28
     d78:	14050300 	strne	r0, [r5], #-768	; 0xfffffd00
     d7c:	00000059 	andeq	r0, r0, r9, asr r0
     d80:	94240305 	strtls	r0, [r4], #-773	; 0xfffffcfb
     d84:	460b0000 	strmi	r0, [fp], -r0
     d88:	0300000b 	movweq	r0, #11
     d8c:	00591406 	subseq	r1, r9, r6, lsl #8
     d90:	03050000 	movweq	r0, #20480	; 0x5000
     d94:	00009428 	andeq	r9, r0, r8, lsr #8
     d98:	0008550b 	andeq	r5, r8, fp, lsl #10
     d9c:	1a070400 	bne	1c1da4 <__bss_end+0x1b866c>
     da0:	00000059 	andeq	r0, r0, r9, asr r0
     da4:	942c0305 	strtls	r0, [ip], #-773	; 0xfffffcfb
     da8:	670b0000 	strvs	r0, [fp, -r0]
     dac:	0400000a 	streq	r0, [r0], #-10
     db0:	00591a09 	subseq	r1, r9, r9, lsl #20
     db4:	03050000 	movweq	r0, #20480	; 0x5000
     db8:	00009430 	andeq	r9, r0, r0, lsr r4
     dbc:	0008470b 	andeq	r4, r8, fp, lsl #14
     dc0:	1a0b0400 	bne	2c1dc8 <__bss_end+0x2b8690>
     dc4:	00000059 	andeq	r0, r0, r9, asr r0
     dc8:	94340305 	ldrtls	r0, [r4], #-773	; 0xfffffcfb
     dcc:	1b0b0000 	blne	2c0dd4 <__bss_end+0x2b769c>
     dd0:	0400000a 	streq	r0, [r0], #-10
     dd4:	00591a0d 	subseq	r1, r9, sp, lsl #20
     dd8:	03050000 	movweq	r0, #20480	; 0x5000
     ddc:	00009438 	andeq	r9, r0, r8, lsr r4
     de0:	0006050b 	andeq	r0, r6, fp, lsl #10
     de4:	1a0f0400 	bne	3c1dec <__bss_end+0x3b86b4>
     de8:	00000059 	andeq	r0, r0, r9, asr r0
     dec:	943c0305 	ldrtls	r0, [ip], #-773	; 0xfffffcfb
     df0:	80080000 	andhi	r0, r8, r0
     df4:	05000011 	streq	r0, [r0, #-17]	; 0xffffffef
     df8:	00003804 	andeq	r3, r0, r4, lsl #16
     dfc:	0c1b0400 	cfldrseq	mvf0, [fp], {-0}
     e00:	000001eb 	andeq	r0, r0, fp, ror #3
     e04:	0005910a 	andeq	r9, r5, sl, lsl #2
     e08:	030a0000 	movweq	r0, #40960	; 0xa000
     e0c:	0100000c 	tsteq	r0, ip
     e10:	000cc70a 	andeq	ip, ip, sl, lsl #14
     e14:	0c000200 	sfmeq	f0, 4, [r0], {-0}
     e18:	00000459 	andeq	r0, r0, r9, asr r4
     e1c:	b9020102 	stmdblt	r2, {r1, r8}
     e20:	0d000008 	stceq	0, cr0, [r0, #-32]	; 0xffffffe0
     e24:	00002c04 	andeq	r2, r0, r4, lsl #24
     e28:	eb040d00 	bl	104230 <__bss_end+0xfaaf8>
     e2c:	0b000001 	bleq	e38 <shift+0xe38>
     e30:	0000059b 	muleq	r0, fp, r5
     e34:	59140405 	ldmdbpl	r4, {r0, r2, sl}
     e38:	05000000 	streq	r0, [r0, #-0]
     e3c:	00944003 	addseq	r4, r4, r3
     e40:	0ad00b00 	beq	ff403a48 <__bss_end+0xff3fa310>
     e44:	07050000 	streq	r0, [r5, -r0]
     e48:	00005914 	andeq	r5, r0, r4, lsl r9
     e4c:	44030500 	strmi	r0, [r3], #-1280	; 0xfffffb00
     e50:	0b000094 	bleq	10a8 <shift+0x10a8>
     e54:	000004e2 	andeq	r0, r0, r2, ror #9
     e58:	59140a05 	ldmdbpl	r4, {r0, r2, r9, fp}
     e5c:	05000000 	streq	r0, [r0, #-0]
     e60:	00944803 	addseq	r4, r4, r3, lsl #16
     e64:	06cb0800 	strbeq	r0, [fp], r0, lsl #16
     e68:	04050000 	streq	r0, [r5], #-0
     e6c:	00000038 	andeq	r0, r0, r8, lsr r0
     e70:	700c0d05 	andvc	r0, ip, r5, lsl #26
     e74:	09000002 	stmdbeq	r0, {r1}
     e78:	0077654e 	rsbseq	r6, r7, lr, asr #10
     e7c:	04c20a00 	strbeq	r0, [r2], #2560	; 0xa00
     e80:	0a010000 	beq	40e88 <__bss_end+0x37750>
     e84:	000004da 	ldrdeq	r0, [r0], -sl
     e88:	06e40a02 	strbteq	r0, [r4], r2, lsl #20
     e8c:	0a030000 	beq	c0e94 <__bss_end+0xb775c>
     e90:	00000bca 	andeq	r0, r0, sl, asr #23
     e94:	04b60a04 	ldrteq	r0, [r6], #2564	; 0xa04
     e98:	00050000 	andeq	r0, r5, r0
     e9c:	0005b406 	andeq	fp, r5, r6, lsl #8
     ea0:	1b051000 	blne	144ea8 <__bss_end+0x13b770>
     ea4:	0002af08 	andeq	sl, r2, r8, lsl #30
     ea8:	726c0700 	rsbvc	r0, ip, #0, 14
     eac:	131d0500 	tstne	sp, #0, 10
     eb0:	000002af 	andeq	r0, r0, pc, lsr #5
     eb4:	70730700 	rsbsvc	r0, r3, r0, lsl #14
     eb8:	131e0500 	tstne	lr, #0, 10
     ebc:	000002af 	andeq	r0, r0, pc, lsr #5
     ec0:	63700704 	cmnvs	r0, #4, 14	; 0x100000
     ec4:	131f0500 	tstne	pc, #0, 10
     ec8:	000002af 	andeq	r0, r0, pc, lsr #5
     ecc:	0a8a0e08 	beq	fe2846f4 <__bss_end+0xfe27afbc>
     ed0:	20050000 	andcs	r0, r5, r0
     ed4:	0002af13 	andeq	sl, r2, r3, lsl pc
     ed8:	02000c00 	andeq	r0, r0, #0, 24
     edc:	0b230704 	bleq	8c2af4 <__bss_end+0x8b93bc>
     ee0:	af060000 	svcge	0x00060000
     ee4:	70000007 	andvc	r0, r0, r7
     ee8:	46082805 	strmi	r2, [r8], -r5, lsl #16
     eec:	0e000003 	cdpeq	0, 0, cr0, cr0, cr3, {0}
     ef0:	00000741 	andeq	r0, r0, r1, asr #14
     ef4:	70122a05 	andsvc	r2, r2, r5, lsl #20
     ef8:	00000002 	andeq	r0, r0, r2
     efc:	64697007 	strbtvs	r7, [r9], #-7
     f00:	122b0500 	eorne	r0, fp, #0, 10
     f04:	0000005e 	andeq	r0, r0, lr, asr r0
     f08:	0bfd0e10 	bleq	fff44750 <__bss_end+0xfff3b018>
     f0c:	2c050000 	stccs	0, cr0, [r5], {-0}
     f10:	00023911 	andeq	r3, r2, r1, lsl r9
     f14:	ae0e1400 	cfcpysge	mvf1, mvf14
     f18:	0500000b 	streq	r0, [r0, #-11]
     f1c:	005e122d 	subseq	r1, lr, sp, lsr #4
     f20:	0e180000 	cdpeq	0, 1, cr0, cr8, cr0, {0}
     f24:	000003e9 	andeq	r0, r0, r9, ror #7
     f28:	5e122e05 	cdppl	14, 1, cr2, cr2, cr5, {0}
     f2c:	1c000000 	stcne	0, cr0, [r0], {-0}
     f30:	000abd0e 	andeq	fp, sl, lr, lsl #26
     f34:	0c2f0500 	cfstr32eq	mvfx0, [pc], #-0	; f3c <shift+0xf3c>
     f38:	00000346 	andeq	r0, r0, r6, asr #6
     f3c:	04720e20 	ldrbteq	r0, [r2], #-3616	; 0xfffff1e0
     f40:	30050000 	andcc	r0, r5, r0
     f44:	00003809 	andeq	r3, r0, r9, lsl #16
     f48:	ff0e6000 			; <UNDEFINED> instruction: 0xff0e6000
     f4c:	05000006 	streq	r0, [r0, #-6]
     f50:	004d0e31 	subeq	r0, sp, r1, lsr lr
     f54:	0e640000 	cdpeq	0, 6, cr0, cr4, cr0, {0}
     f58:	000009d4 	ldrdeq	r0, [r0], -r4
     f5c:	4d0e3305 	stcmi	3, cr3, [lr, #-20]	; 0xffffffec
     f60:	68000000 	stmdavs	r0, {}	; <UNPREDICTABLE>
     f64:	0009cb0e 	andeq	ip, r9, lr, lsl #22
     f68:	0e340500 	cfabs32eq	mvfx0, mvfx4
     f6c:	0000004d 	andeq	r0, r0, sp, asr #32
     f70:	fd0f006c 	stc2	0, cr0, [pc, #-432]	; dc8 <shift+0xdc8>
     f74:	56000001 	strpl	r0, [r0], -r1
     f78:	10000003 	andne	r0, r0, r3
     f7c:	0000005e 	andeq	r0, r0, lr, asr r0
     f80:	cb0b000f 	blgt	2c0fc4 <__bss_end+0x2b788c>
     f84:	06000004 	streq	r0, [r0], -r4
     f88:	0059140a 	subseq	r1, r9, sl, lsl #8
     f8c:	03050000 	movweq	r0, #20480	; 0x5000
     f90:	0000944c 	andeq	r9, r0, ip, asr #8
     f94:	00089008 	andeq	r9, r8, r8
     f98:	38040500 	stmdacc	r4, {r8, sl}
     f9c:	06000000 	streq	r0, [r0], -r0
     fa0:	03870c0d 	orreq	r0, r7, #3328	; 0xd00
     fa4:	d20a0000 	andle	r0, sl, #0
     fa8:	0000000c 	andeq	r0, r0, ip
     fac:	000c170a 	andeq	r1, ip, sl, lsl #14
     fb0:	03000100 	movweq	r0, #256	; 0x100
     fb4:	00000368 	andeq	r0, r0, r8, ror #6
     fb8:	000ee108 	andeq	lr, lr, r8, lsl #2
     fbc:	38040500 	stmdacc	r4, {r8, sl}
     fc0:	06000000 	streq	r0, [r0], -r0
     fc4:	03ab0c14 			; <UNDEFINED> instruction: 0x03ab0c14
     fc8:	9a0a0000 	bls	280fd0 <__bss_end+0x277898>
     fcc:	0000000d 	andeq	r0, r0, sp
     fd0:	000fc10a 	andeq	ip, pc, sl, lsl #2
     fd4:	03000100 	movweq	r0, #256	; 0x100
     fd8:	0000038c 	andeq	r0, r0, ip, lsl #7
     fdc:	00072e06 	andeq	r2, r7, r6, lsl #28
     fe0:	1b060c00 	blne	183fe8 <__bss_end+0x17a8b0>
     fe4:	0003e508 	andeq	lr, r3, r8, lsl #10
     fe8:	053e0e00 	ldreq	r0, [lr, #-3584]!	; 0xfffff200
     fec:	1d060000 	stcne	0, cr0, [r6, #-0]
     ff0:	0003e519 	andeq	lr, r3, r9, lsl r5
     ff4:	bd0e0000 	stclt	0, cr0, [lr, #-0]
     ff8:	06000004 	streq	r0, [r0], -r4
     ffc:	03e5191e 	mvneq	r1, #491520	; 0x78000
    1000:	0e040000 	cdpeq	0, 0, cr0, cr4, cr0, {0}
    1004:	000008b4 			; <UNDEFINED> instruction: 0x000008b4
    1008:	eb131f06 	bl	4c8c28 <__bss_end+0x4bf4f0>
    100c:	08000003 	stmdaeq	r0, {r0, r1}
    1010:	b0040d00 	andlt	r0, r4, r0, lsl #26
    1014:	0d000003 	stceq	0, cr0, [r0, #-12]
    1018:	0002b604 	andeq	fp, r2, r4, lsl #12
    101c:	0a791100 	beq	1e45424 <__bss_end+0x1e3bcec>
    1020:	06140000 	ldreq	r0, [r4], -r0
    1024:	06730722 	ldrbteq	r0, [r3], -r2, lsr #14
    1028:	7c0e0000 	stcvc	0, cr0, [lr], {-0}
    102c:	06000009 	streq	r0, [r0], -r9
    1030:	004d1226 	subeq	r1, sp, r6, lsr #4
    1034:	0e000000 	cdpeq	0, 0, cr0, cr0, cr0, {0}
    1038:	0000091e 	andeq	r0, r0, lr, lsl r9
    103c:	e51d2906 	ldr	r2, [sp, #-2310]	; 0xfffff6fa
    1040:	04000003 	streq	r0, [r0], #-3
    1044:	0006ec0e 	andeq	lr, r6, lr, lsl #24
    1048:	1d2c0600 	stcne	6, cr0, [ip, #-0]
    104c:	000003e5 	andeq	r0, r0, r5, ror #7
    1050:	09861208 	stmibeq	r6, {r3, r9, ip}
    1054:	2f060000 	svccs	0x00060000
    1058:	00070b0e 	andeq	r0, r7, lr, lsl #22
    105c:	00043900 	andeq	r3, r4, r0, lsl #18
    1060:	00044400 	andeq	r4, r4, r0, lsl #8
    1064:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
    1068:	e5140000 	ldr	r0, [r4, #-0]
    106c:	00000003 	andeq	r0, r0, r3
    1070:	0007e815 	andeq	lr, r7, r5, lsl r8
    1074:	0e310600 	cfmsuba32eq	mvax0, mvax0, mvfx1, mvfx0
    1078:	00000786 	andeq	r0, r0, r6, lsl #15
    107c:	000001f0 	strdeq	r0, [r0], -r0	; <UNPREDICTABLE>
    1080:	0000045c 	andeq	r0, r0, ip, asr r4
    1084:	00000467 	andeq	r0, r0, r7, ror #8
    1088:	00067813 	andeq	r7, r6, r3, lsl r8
    108c:	03eb1400 	mvneq	r1, #0, 8
    1090:	16000000 	strne	r0, [r0], -r0
    1094:	00000bde 	ldrdeq	r0, [r0], -lr
    1098:	6b1d3506 	blvs	74e4b8 <__bss_end+0x744d80>
    109c:	e5000008 	str	r0, [r0, #-8]
    10a0:	02000003 	andeq	r0, r0, #3
    10a4:	00000480 	andeq	r0, r0, r0, lsl #9
    10a8:	00000486 	andeq	r0, r0, r6, lsl #9
    10ac:	00067813 	andeq	r7, r6, r3, lsl r8
    10b0:	d7160000 	ldrle	r0, [r6, -r0]
    10b4:	06000006 	streq	r0, [r0], -r6
    10b8:	09961d37 	ldmibeq	r6, {r0, r1, r2, r4, r5, r8, sl, fp, ip}
    10bc:	03e50000 	mvneq	r0, #0
    10c0:	9f020000 	svcls	0x00020000
    10c4:	a5000004 	strge	r0, [r0, #-4]
    10c8:	13000004 	movwne	r0, #4
    10cc:	00000678 	andeq	r0, r0, r8, ror r6
    10d0:	09311700 	ldmdbeq	r1!, {r8, r9, sl, ip}
    10d4:	39060000 	stmdbcc	r6, {}	; <UNPREDICTABLE>
    10d8:	00069131 	andeq	r9, r6, r1, lsr r1
    10dc:	16020c00 	strne	r0, [r2], -r0, lsl #24
    10e0:	00000a79 	andeq	r0, r0, r9, ror sl
    10e4:	f7093c06 			; <UNDEFINED> instruction: 0xf7093c06
    10e8:	78000007 	stmdavc	r0, {r0, r1, r2}
    10ec:	01000006 	tsteq	r0, r6
    10f0:	000004cc 	andeq	r0, r0, ip, asr #9
    10f4:	000004d2 	ldrdeq	r0, [r0], -r2
    10f8:	00067813 	andeq	r7, r6, r3, lsl r8
    10fc:	4d160000 	ldcmi	0, cr0, [r6, #-0]
    1100:	06000007 	streq	r0, [r0], -r7
    1104:	0513123f 	ldreq	r1, [r3, #-575]	; 0xfffffdc1
    1108:	004d0000 	subeq	r0, sp, r0
    110c:	eb010000 	bl	41114 <__bss_end+0x379dc>
    1110:	00000004 	andeq	r0, r0, r4
    1114:	13000005 	movwne	r0, #5
    1118:	00000678 	andeq	r0, r0, r8, ror r6
    111c:	00069a14 	andeq	r9, r6, r4, lsl sl
    1120:	005e1400 	subseq	r1, lr, r0, lsl #8
    1124:	f0140000 			; <UNDEFINED> instruction: 0xf0140000
    1128:	00000001 	andeq	r0, r0, r1
    112c:	000c0e18 	andeq	r0, ip, r8, lsl lr
    1130:	0e420600 	cdpeq	6, 4, cr0, cr2, cr0, {0}
    1134:	000005c1 	andeq	r0, r0, r1, asr #11
    1138:	00051501 	andeq	r1, r5, r1, lsl #10
    113c:	00051b00 	andeq	r1, r5, r0, lsl #22
    1140:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
    1144:	16000000 	strne	r0, [r0], -r0
    1148:	000004f5 	strdeq	r0, [r0], -r5
    114c:	63174506 	tstvs	r7, #25165824	; 0x1800000
    1150:	eb000005 	bl	116c <shift+0x116c>
    1154:	01000003 	tsteq	r0, r3
    1158:	00000534 	andeq	r0, r0, r4, lsr r5
    115c:	0000053a 	andeq	r0, r0, sl, lsr r5
    1160:	0006a013 	andeq	sl, r6, r3, lsl r0
    1164:	db160000 	blle	58116c <__bss_end+0x577a34>
    1168:	0600000a 	streq	r0, [r0], -sl
    116c:	03ff1748 	mvnseq	r1, #72, 14	; 0x1200000
    1170:	03eb0000 	mvneq	r0, #0
    1174:	53010000 	movwpl	r0, #4096	; 0x1000
    1178:	5e000005 	cdppl	0, 0, cr0, cr0, cr5, {0}
    117c:	13000005 	movwne	r0, #5
    1180:	000006a0 	andeq	r0, r0, r0, lsr #13
    1184:	00004d14 	andeq	r4, r0, r4, lsl sp
    1188:	0f180000 	svceq	0x00180000
    118c:	06000006 	streq	r0, [r0], -r6
    1190:	093f0e4b 	ldmdbeq	pc!, {r0, r1, r3, r6, r9, sl, fp}	; <UNPREDICTABLE>
    1194:	73010000 	movwvc	r0, #4096	; 0x1000
    1198:	79000005 	stmdbvc	r0, {r0, r2}
    119c:	13000005 	movwne	r0, #5
    11a0:	00000678 	andeq	r0, r0, r8, ror r6
    11a4:	07e81600 	strbeq	r1, [r8, r0, lsl #12]!
    11a8:	4d060000 	stcmi	0, cr0, [r6, #-0]
    11ac:	0009f30e 	andeq	pc, r9, lr, lsl #6
    11b0:	0001f000 	andeq	pc, r1, r0
    11b4:	05920100 	ldreq	r0, [r2, #256]	; 0x100
    11b8:	059d0000 	ldreq	r0, [sp]
    11bc:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
    11c0:	14000006 	strne	r0, [r0], #-6
    11c4:	0000004d 	andeq	r0, r0, sp, asr #32
    11c8:	04a21600 	strteq	r1, [r2], #1536	; 0x600
    11cc:	50060000 	andpl	r0, r6, r0
    11d0:	00042c12 	andeq	r2, r4, r2, lsl ip
    11d4:	00004d00 	andeq	r4, r0, r0, lsl #26
    11d8:	05b60100 	ldreq	r0, [r6, #256]!	; 0x100
    11dc:	05c10000 	strbeq	r0, [r1]
    11e0:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
    11e4:	14000006 	strne	r0, [r0], #-6
    11e8:	000001fd 	strdeq	r0, [r0], -sp
    11ec:	045f1600 	ldrbeq	r1, [pc], #-1536	; 11f4 <shift+0x11f4>
    11f0:	53060000 	movwpl	r0, #24576	; 0x6000
    11f4:	000c430e 	andeq	r4, ip, lr, lsl #6
    11f8:	0001f000 	andeq	pc, r1, r0
    11fc:	05da0100 	ldrbeq	r0, [sl, #256]	; 0x100
    1200:	05e50000 	strbeq	r0, [r5, #0]!
    1204:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
    1208:	14000006 	strne	r0, [r0], #-6
    120c:	0000004d 	andeq	r0, r0, sp, asr #32
    1210:	047c1800 	ldrbteq	r1, [ip], #-2048	; 0xfffff800
    1214:	56060000 	strpl	r0, [r6], -r0
    1218:	000b520e 	andeq	r5, fp, lr, lsl #4
    121c:	05fa0100 	ldrbeq	r0, [sl, #256]!	; 0x100
    1220:	06190000 	ldreq	r0, [r9], -r0
    1224:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
    1228:	14000006 	strne	r0, [r0], #-6
    122c:	000000a9 	andeq	r0, r0, r9, lsr #1
    1230:	00004d14 	andeq	r4, r0, r4, lsl sp
    1234:	004d1400 	subeq	r1, sp, r0, lsl #8
    1238:	4d140000 	ldcmi	0, cr0, [r4, #-0]
    123c:	14000000 	strne	r0, [r0], #-0
    1240:	000006a6 	andeq	r0, r0, r6, lsr #13
    1244:	0c6f1800 	stcleq	8, cr1, [pc], #-0	; 124c <shift+0x124c>
    1248:	58060000 	stmdapl	r6, {}	; <UNPREDICTABLE>
    124c:	000ce70e 	andeq	lr, ip, lr, lsl #14
    1250:	062e0100 	strteq	r0, [lr], -r0, lsl #2
    1254:	064d0000 	strbeq	r0, [sp], -r0
    1258:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
    125c:	14000006 	strne	r0, [r0], #-6
    1260:	000000e0 	andeq	r0, r0, r0, ror #1
    1264:	00004d14 	andeq	r4, r0, r4, lsl sp
    1268:	004d1400 	subeq	r1, sp, r0, lsl #8
    126c:	4d140000 	ldcmi	0, cr0, [r4, #-0]
    1270:	14000000 	strne	r0, [r0], #-0
    1274:	000006a6 	andeq	r0, r0, r6, lsr #13
    1278:	048f1900 	streq	r1, [pc], #2304	; 1280 <shift+0x1280>
    127c:	5b060000 	blpl	181284 <__bss_end+0x177b4c>
    1280:	0008be0e 	andeq	fp, r8, lr, lsl #28
    1284:	0001f000 	andeq	pc, r1, r0
    1288:	06620100 	strbteq	r0, [r2], -r0, lsl #2
    128c:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
    1290:	14000006 	strne	r0, [r0], #-6
    1294:	00000368 	andeq	r0, r0, r8, ror #6
    1298:	0006ac14 	andeq	sl, r6, r4, lsl ip
    129c:	03000000 	movweq	r0, #0
    12a0:	000003f1 	strdeq	r0, [r0], -r1
    12a4:	03f1040d 	mvnseq	r0, #218103808	; 0xd000000
    12a8:	e51a0000 	ldr	r0, [sl, #-0]
    12ac:	8b000003 	blhi	12c0 <shift+0x12c0>
    12b0:	91000006 	tstls	r0, r6
    12b4:	13000006 	movwne	r0, #6
    12b8:	00000678 	andeq	r0, r0, r8, ror r6
    12bc:	03f11b00 	mvnseq	r1, #0, 22
    12c0:	067e0000 	ldrbteq	r0, [lr], -r0
    12c4:	040d0000 	streq	r0, [sp], #-0
    12c8:	0000003f 	andeq	r0, r0, pc, lsr r0
    12cc:	0673040d 	ldrbteq	r0, [r3], -sp, lsl #8
    12d0:	041c0000 	ldreq	r0, [ip], #-0
    12d4:	00000065 	andeq	r0, r0, r5, rrx
    12d8:	2c0f041d 	cfstrscs	mvf0, [pc], {29}
    12dc:	be000000 	cdplt	0, 0, cr0, cr0, cr0, {0}
    12e0:	10000006 	andne	r0, r0, r6
    12e4:	0000005e 	andeq	r0, r0, lr, asr r0
    12e8:	ae030009 	cdpge	0, 0, cr0, cr3, cr9, {0}
    12ec:	1e000006 	cdpne	0, 0, cr0, cr0, cr6, {0}
    12f0:	00000e43 	andeq	r0, r0, r3, asr #28
    12f4:	be0ca401 	cdplt	4, 0, cr10, cr12, cr1, {0}
    12f8:	05000006 	streq	r0, [r0, #-6]
    12fc:	00945003 	addseq	r5, r4, r3
    1300:	0db31f00 	ldceq	15, cr1, [r3]
    1304:	a6010000 	strge	r0, [r1], -r0
    1308:	000ed50a 	andeq	sp, lr, sl, lsl #10
    130c:	00004d00 	andeq	r4, r0, r0, lsl #26
    1310:	0086e400 	addeq	lr, r6, r0, lsl #8
    1314:	0000b000 	andeq	fp, r0, r0
    1318:	339c0100 	orrscc	r0, ip, #0, 2
    131c:	20000007 	andcs	r0, r0, r7
    1320:	00001163 	andeq	r1, r0, r3, ror #2
    1324:	f71ba601 			; <UNDEFINED> instruction: 0xf71ba601
    1328:	03000001 	movweq	r0, #1
    132c:	207fac91 			; <UNDEFINED> instruction: 0x207fac91
    1330:	00000f34 	andeq	r0, r0, r4, lsr pc
    1334:	4d2aa601 	stcmi	6, cr10, [sl, #-4]!
    1338:	03000000 	movweq	r0, #0
    133c:	1e7fa891 	mrcne	8, 3, sl, cr15, cr1, {4}
    1340:	00000ebe 			; <UNDEFINED> instruction: 0x00000ebe
    1344:	330aa801 	movwcc	sl, #43009	; 0xa801
    1348:	03000007 	movweq	r0, #7
    134c:	1e7fb491 	mrcne	4, 3, fp, cr15, cr1, {4}
    1350:	00000dae 	andeq	r0, r0, lr, lsr #27
    1354:	3809ac01 	stmdacc	r9, {r0, sl, fp, sp, pc}
    1358:	02000000 	andeq	r0, r0, #0
    135c:	0f007491 	svceq	0x00007491
    1360:	00000025 	andeq	r0, r0, r5, lsr #32
    1364:	00000743 	andeq	r0, r0, r3, asr #14
    1368:	00005e10 	andeq	r5, r0, r0, lsl lr
    136c:	21003f00 	tstcs	r0, r0, lsl #30
    1370:	00000f19 	andeq	r0, r0, r9, lsl pc
    1374:	e60a9801 	str	r9, [sl], -r1, lsl #16
    1378:	4d00000f 	stcmi	0, cr0, [r0, #-60]	; 0xffffffc4
    137c:	a8000000 	stmdage	r0, {}	; <UNPREDICTABLE>
    1380:	3c000086 	stccc	0, cr0, [r0], {134}	; 0x86
    1384:	01000000 	mrseq	r0, (UNDEF: 0)
    1388:	0007809c 	muleq	r7, ip, r0
    138c:	65722200 	ldrbvs	r2, [r2, #-512]!	; 0xfffffe00
    1390:	9a010071 	bls	4155c <__bss_end+0x37e24>
    1394:	0003ab20 	andeq	sl, r3, r0, lsr #22
    1398:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    139c:	000eca1e 	andeq	ip, lr, lr, lsl sl
    13a0:	0e9b0100 	fmleqe	f0, f3, f0
    13a4:	0000004d 	andeq	r0, r0, sp, asr #32
    13a8:	00709102 	rsbseq	r9, r0, r2, lsl #2
    13ac:	000f3d23 	andeq	r3, pc, r3, lsr #26
    13b0:	068f0100 	streq	r0, [pc], r0, lsl #2
    13b4:	00000dcf 	andeq	r0, r0, pc, asr #27
    13b8:	0000866c 	andeq	r8, r0, ip, ror #12
    13bc:	0000003c 	andeq	r0, r0, ip, lsr r0
    13c0:	07b99c01 	ldreq	r9, [r9, r1, lsl #24]!
    13c4:	11200000 			; <UNDEFINED> instruction: 0x11200000
    13c8:	0100000e 	tsteq	r0, lr
    13cc:	004d218f 	subeq	r2, sp, pc, lsl #3
    13d0:	91020000 	mrsls	r0, (UNDEF: 2)
    13d4:	6572226c 	ldrbvs	r2, [r2, #-620]!	; 0xfffffd94
    13d8:	91010071 	tstls	r1, r1, ror r0
    13dc:	0003ab20 	andeq	sl, r3, r0, lsr #22
    13e0:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    13e4:	0ef62100 	cdpeq	1, 15, cr2, cr6, cr0, {0}
    13e8:	83010000 	movwhi	r0, #4096	; 0x1000
    13ec:	000e5f0a 	andeq	r5, lr, sl, lsl #30
    13f0:	00004d00 	andeq	r4, r0, r0, lsl #26
    13f4:	00863000 	addeq	r3, r6, r0
    13f8:	00003c00 	andeq	r3, r0, r0, lsl #24
    13fc:	f69c0100 			; <UNDEFINED> instruction: 0xf69c0100
    1400:	22000007 	andcs	r0, r0, #7
    1404:	00716572 	rsbseq	r6, r1, r2, ror r5
    1408:	87208501 	strhi	r8, [r0, -r1, lsl #10]!
    140c:	02000003 	andeq	r0, r0, #3
    1410:	a71e7491 			; <UNDEFINED> instruction: 0xa71e7491
    1414:	0100000d 	tsteq	r0, sp
    1418:	004d0e86 	subeq	r0, sp, r6, lsl #29
    141c:	91020000 	mrsls	r0, (UNDEF: 2)
    1420:	46210070 			; <UNDEFINED> instruction: 0x46210070
    1424:	01000011 	tsteq	r0, r1, lsl r0
    1428:	0e250a77 			; <UNDEFINED> instruction: 0x0e250a77
    142c:	004d0000 	subeq	r0, sp, r0
    1430:	85f40000 	ldrbhi	r0, [r4, #0]!
    1434:	003c0000 	eorseq	r0, ip, r0
    1438:	9c010000 	stcls	0, cr0, [r1], {-0}
    143c:	00000833 	andeq	r0, r0, r3, lsr r8
    1440:	71657222 	cmnvc	r5, r2, lsr #4
    1444:	20790100 	rsbscs	r0, r9, r0, lsl #2
    1448:	00000387 	andeq	r0, r0, r7, lsl #7
    144c:	1e749102 	expnes	f1, f2
    1450:	00000da7 	andeq	r0, r0, r7, lsr #27
    1454:	4d0e7a01 	vstrmi	s14, [lr, #-4]
    1458:	02000000 	andeq	r0, r0, #0
    145c:	21007091 	swpcs	r7, r1, [r0]
    1460:	00000e73 	andeq	r0, r0, r3, ror lr
    1464:	b6066b01 	strlt	r6, [r6], -r1, lsl #22
    1468:	f000000f 			; <UNDEFINED> instruction: 0xf000000f
    146c:	a0000001 	andge	r0, r0, r1
    1470:	54000085 	strpl	r0, [r0], #-133	; 0xffffff7b
    1474:	01000000 	mrseq	r0, (UNDEF: 0)
    1478:	00087f9c 	muleq	r8, ip, pc	; <UNPREDICTABLE>
    147c:	0eca2000 	cdpeq	0, 12, cr2, cr10, cr0, {0}
    1480:	6b010000 	blvs	41488 <__bss_end+0x37d50>
    1484:	00004d15 	andeq	r4, r0, r5, lsl sp
    1488:	6c910200 	lfmvs	f0, 4, [r1], {0}
    148c:	0009cb20 	andeq	ip, r9, r0, lsr #22
    1490:	256b0100 	strbcs	r0, [fp, #-256]!	; 0xffffff00
    1494:	0000004d 	andeq	r0, r0, sp, asr #32
    1498:	1e689102 	lgnnee	f1, f2
    149c:	0000113e 	andeq	r1, r0, lr, lsr r1
    14a0:	4d0e6d01 	stcmi	13, cr6, [lr, #-4]
    14a4:	02000000 	andeq	r0, r0, #0
    14a8:	21007491 			; <UNDEFINED> instruction: 0x21007491
    14ac:	00000de6 	andeq	r0, r0, r6, ror #27
    14b0:	1d125e01 	ldcne	14, cr5, [r2, #-4]
    14b4:	8b000010 	blhi	14fc <shift+0x14fc>
    14b8:	50000000 	andpl	r0, r0, r0
    14bc:	50000085 	andpl	r0, r0, r5, lsl #1
    14c0:	01000000 	mrseq	r0, (UNDEF: 0)
    14c4:	0008da9c 	muleq	r8, ip, sl
    14c8:	0d442000 	stcleq	0, cr2, [r4, #-0]
    14cc:	5e010000 	cdppl	0, 0, cr0, cr1, cr0, {0}
    14d0:	00004d20 	andeq	r4, r0, r0, lsr #26
    14d4:	6c910200 	lfmvs	f0, 4, [r1], {0}
    14d8:	000eff20 	andeq	pc, lr, r0, lsr #30
    14dc:	2f5e0100 	svccs	0x005e0100
    14e0:	0000004d 	andeq	r0, r0, sp, asr #32
    14e4:	20689102 	rsbcs	r9, r8, r2, lsl #2
    14e8:	000009cb 	andeq	r0, r0, fp, asr #19
    14ec:	4d3f5e01 	ldcmi	14, cr5, [pc, #-4]!	; 14f0 <shift+0x14f0>
    14f0:	02000000 	andeq	r0, r0, #0
    14f4:	3e1e6491 	cfcmpscc	r6, mvf14, mvf1
    14f8:	01000011 	tsteq	r0, r1, lsl r0
    14fc:	008b1660 	addeq	r1, fp, r0, ror #12
    1500:	91020000 	mrsls	r0, (UNDEF: 2)
    1504:	53210074 			; <UNDEFINED> instruction: 0x53210074
    1508:	01000010 	tsteq	r0, r0, lsl r0
    150c:	0deb0a52 			; <UNDEFINED> instruction: 0x0deb0a52
    1510:	004d0000 	subeq	r0, sp, r0
    1514:	850c0000 	strhi	r0, [ip, #-0]
    1518:	00440000 	subeq	r0, r4, r0
    151c:	9c010000 	stcls	0, cr0, [r1], {-0}
    1520:	00000926 	andeq	r0, r0, r6, lsr #18
    1524:	000d4420 	andeq	r4, sp, r0, lsr #8
    1528:	1a520100 	bne	1481930 <__bss_end+0x14781f8>
    152c:	0000004d 	andeq	r0, r0, sp, asr #32
    1530:	206c9102 	rsbcs	r9, ip, r2, lsl #2
    1534:	00000eff 	strdeq	r0, [r0], -pc	; <UNPREDICTABLE>
    1538:	4d295201 	sfmmi	f5, 4, [r9, #-4]!
    153c:	02000000 	andeq	r0, r0, #0
    1540:	4c1e6891 	ldcmi	8, cr6, [lr], {145}	; 0x91
    1544:	01000010 	tsteq	r0, r0, lsl r0
    1548:	004d0e54 	subeq	r0, sp, r4, asr lr
    154c:	91020000 	mrsls	r0, (UNDEF: 2)
    1550:	46210074 			; <UNDEFINED> instruction: 0x46210074
    1554:	01000010 	tsteq	r0, r0, lsl r0
    1558:	10280a45 	eorne	r0, r8, r5, asr #20
    155c:	004d0000 	subeq	r0, sp, r0
    1560:	84bc0000 	ldrthi	r0, [ip], #0
    1564:	00500000 	subseq	r0, r0, r0
    1568:	9c010000 	stcls	0, cr0, [r1], {-0}
    156c:	00000981 	andeq	r0, r0, r1, lsl #19
    1570:	000d4420 	andeq	r4, sp, r0, lsr #8
    1574:	19450100 	stmdbne	r5, {r8}^
    1578:	0000004d 	andeq	r0, r0, sp, asr #32
    157c:	206c9102 	rsbcs	r9, ip, r2, lsl #2
    1580:	00000e9f 	muleq	r0, pc, lr	; <UNPREDICTABLE>
    1584:	1d304501 	cfldr32ne	mvfx4, [r0, #-4]!
    1588:	02000001 	andeq	r0, r0, #1
    158c:	05206891 	streq	r6, [r0, #-2193]!	; 0xfffff76f
    1590:	0100000f 	tsteq	r0, pc
    1594:	06ac4145 	strteq	r4, [ip], r5, asr #2
    1598:	91020000 	mrsls	r0, (UNDEF: 2)
    159c:	113e1e64 	teqne	lr, r4, ror #28
    15a0:	47010000 	strmi	r0, [r1, -r0]
    15a4:	00004d0e 	andeq	r4, r0, lr, lsl #26
    15a8:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    15ac:	0d942300 	ldceq	3, cr2, [r4]
    15b0:	3f010000 	svccc	0x00010000
    15b4:	000ea906 	andeq	sl, lr, r6, lsl #18
    15b8:	00849000 	addeq	r9, r4, r0
    15bc:	00002c00 	andeq	r2, r0, r0, lsl #24
    15c0:	ab9c0100 	blge	fe7019c8 <__bss_end+0xfe6f8290>
    15c4:	20000009 	andcs	r0, r0, r9
    15c8:	00000d44 	andeq	r0, r0, r4, asr #26
    15cc:	4d153f01 	ldcmi	15, cr3, [r5, #-4]
    15d0:	02000000 	andeq	r0, r0, #0
    15d4:	21007491 			; <UNDEFINED> instruction: 0x21007491
    15d8:	00000ec4 	andeq	r0, r0, r4, asr #29
    15dc:	0b0a3201 	bleq	28dde8 <__bss_end+0x2846b0>
    15e0:	4d00000f 	stcmi	0, cr0, [r0, #-60]	; 0xffffffc4
    15e4:	40000000 	andmi	r0, r0, r0
    15e8:	50000084 	andpl	r0, r0, r4, lsl #1
    15ec:	01000000 	mrseq	r0, (UNDEF: 0)
    15f0:	000a069c 	muleq	sl, ip, r6
    15f4:	0d442000 	stcleq	0, cr2, [r4, #-0]
    15f8:	32010000 	andcc	r0, r1, #0
    15fc:	00004d19 	andeq	r4, r0, r9, lsl sp
    1600:	6c910200 	lfmvs	f0, 4, [r1], {0}
    1604:	00106920 	andseq	r6, r0, r0, lsr #18
    1608:	2b320100 	blcs	c81a10 <__bss_end+0xc782d8>
    160c:	000001f7 	strdeq	r0, [r0], -r7
    1610:	20689102 	rsbcs	r9, r8, r2, lsl #2
    1614:	00000f38 	andeq	r0, r0, r8, lsr pc
    1618:	4d3c3201 	lfmmi	f3, 4, [ip, #-4]!
    161c:	02000000 	andeq	r0, r0, #0
    1620:	171e6491 			; <UNDEFINED> instruction: 0x171e6491
    1624:	01000010 	tsteq	r0, r0, lsl r0
    1628:	004d0e34 	subeq	r0, sp, r4, lsr lr
    162c:	91020000 	mrsls	r0, (UNDEF: 2)
    1630:	68210074 	stmdavs	r1!, {r2, r4, r5, r6}
    1634:	01000011 	tsteq	r0, r1, lsl r0
    1638:	10700a25 	rsbsne	r0, r0, r5, lsr #20
    163c:	004d0000 	subeq	r0, sp, r0
    1640:	83f00000 	mvnshi	r0, #0
    1644:	00500000 	subseq	r0, r0, r0
    1648:	9c010000 	stcls	0, cr0, [r1], {-0}
    164c:	00000a61 	andeq	r0, r0, r1, ror #20
    1650:	000d4420 	andeq	r4, sp, r0, lsr #8
    1654:	18250100 	stmdane	r5!, {r8}
    1658:	0000004d 	andeq	r0, r0, sp, asr #32
    165c:	206c9102 	rsbcs	r9, ip, r2, lsl #2
    1660:	00001069 	andeq	r1, r0, r9, rrx
    1664:	672a2501 	strvs	r2, [sl, -r1, lsl #10]!
    1668:	0200000a 	andeq	r0, r0, #10
    166c:	38206891 	stmdacc	r0!, {r0, r4, r7, fp, sp, lr}
    1670:	0100000f 	tsteq	r0, pc
    1674:	004d3b25 	subeq	r3, sp, r5, lsr #22
    1678:	91020000 	mrsls	r0, (UNDEF: 2)
    167c:	0db81e64 	ldceq	14, cr1, [r8, #400]!	; 0x190
    1680:	27010000 	strcs	r0, [r1, -r0]
    1684:	00004d0e 	andeq	r4, r0, lr, lsl #26
    1688:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    168c:	25040d00 	strcs	r0, [r4, #-3328]	; 0xfffff300
    1690:	03000000 	movweq	r0, #0
    1694:	00000a61 	andeq	r0, r0, r1, ror #20
    1698:	000ed021 	andeq	sp, lr, r1, lsr #32
    169c:	0a190100 	beq	641aa4 <__bss_end+0x63836c>
    16a0:	00001174 	andeq	r1, r0, r4, ror r1
    16a4:	0000004d 	andeq	r0, r0, sp, asr #32
    16a8:	000083ac 	andeq	r8, r0, ip, lsr #7
    16ac:	00000044 	andeq	r0, r0, r4, asr #32
    16b0:	0ab89c01 	beq	fee286bc <__bss_end+0xfee1ef84>
    16b4:	5f200000 	svcpl	0x00200000
    16b8:	01000011 	tsteq	r0, r1, lsl r0
    16bc:	01f71b19 	mvnseq	r1, r9, lsl fp
    16c0:	91020000 	mrsls	r0, (UNDEF: 2)
    16c4:	1064206c 	rsbne	r2, r4, ip, rrx
    16c8:	19010000 	stmdbne	r1, {}	; <UNPREDICTABLE>
    16cc:	0001c635 	andeq	ip, r1, r5, lsr r6
    16d0:	68910200 	ldmvs	r1, {r9}
    16d4:	000d441e 	andeq	r4, sp, lr, lsl r4
    16d8:	0e1b0100 	mufeqe	f0, f3, f0
    16dc:	0000004d 	andeq	r0, r0, sp, asr #32
    16e0:	00749102 	rsbseq	r9, r4, r2, lsl #2
    16e4:	000e0524 	andeq	r0, lr, r4, lsr #10
    16e8:	06140100 	ldreq	r0, [r4], -r0, lsl #2
    16ec:	00000dbe 			; <UNDEFINED> instruction: 0x00000dbe
    16f0:	00008390 	muleq	r0, r0, r3
    16f4:	0000001c 	andeq	r0, r0, ip, lsl r0
    16f8:	5a239c01 	bpl	8e8704 <__bss_end+0x8defcc>
    16fc:	01000010 	tsteq	r0, r0, lsl r0
    1700:	0e91060e 	cdpeq	6, 9, cr0, cr1, cr14, {0}
    1704:	83640000 	cmnhi	r4, #0
    1708:	002c0000 	eoreq	r0, ip, r0
    170c:	9c010000 	stcls	0, cr0, [r1], {-0}
    1710:	00000af8 	strdeq	r0, [r0], -r8
    1714:	000dfc20 	andeq	pc, sp, r0, lsr #24
    1718:	140e0100 	strne	r0, [lr], #-256	; 0xffffff00
    171c:	00000038 	andeq	r0, r0, r8, lsr r0
    1720:	00749102 	rsbseq	r9, r4, r2, lsl #2
    1724:	00116d25 	andseq	r6, r1, r5, lsr #26
    1728:	0a040100 	beq	101b30 <__bss_end+0xf83f8>
    172c:	00000eb3 			; <UNDEFINED> instruction: 0x00000eb3
    1730:	0000004d 	andeq	r0, r0, sp, asr #32
    1734:	00008338 	andeq	r8, r0, r8, lsr r3
    1738:	0000002c 	andeq	r0, r0, ip, lsr #32
    173c:	70229c01 	eorvc	r9, r2, r1, lsl #24
    1740:	01006469 	tsteq	r0, r9, ror #8
    1744:	004d0e06 	subeq	r0, sp, r6, lsl #28
    1748:	91020000 	mrsls	r0, (UNDEF: 2)
    174c:	2e000074 	mcrcs	0, 0, r0, cr0, cr4, {3}
    1750:	04000003 	streq	r0, [r0], #-3
    1754:	0006b300 	andeq	fp, r6, r0, lsl #6
    1758:	7c010400 	cfstrsvc	mvf0, [r1], {-0}
    175c:	04000010 	streq	r0, [r0], #-16
    1760:	000011b4 			; <UNDEFINED> instruction: 0x000011b4
    1764:	00000d49 	andeq	r0, r0, r9, asr #26
    1768:	00008794 	muleq	r0, r4, r7
    176c:	000004b8 			; <UNDEFINED> instruction: 0x000004b8
    1770:	00000873 	andeq	r0, r0, r3, ror r8
    1774:	00004902 	andeq	r4, r0, r2, lsl #18
    1778:	121d0300 	andsne	r0, sp, #0, 6
    177c:	05010000 	streq	r0, [r1, #-0]
    1780:	00006110 	andeq	r6, r0, r0, lsl r1
    1784:	31301100 	teqcc	r0, r0, lsl #2
    1788:	35343332 	ldrcc	r3, [r4, #-818]!	; 0xfffffcce
    178c:	39383736 	ldmdbcc	r8!, {r1, r2, r4, r5, r8, r9, sl, ip, sp}
    1790:	44434241 	strbmi	r4, [r3], #-577	; 0xfffffdbf
    1794:	00004645 	andeq	r4, r0, r5, asr #12
    1798:	01030104 	tsteq	r3, r4, lsl #2
    179c:	00000025 	andeq	r0, r0, r5, lsr #32
    17a0:	00007405 	andeq	r7, r0, r5, lsl #8
    17a4:	00006100 	andeq	r6, r0, r0, lsl #2
    17a8:	00660600 	rsbeq	r0, r6, r0, lsl #12
    17ac:	00100000 	andseq	r0, r0, r0
    17b0:	00005107 	andeq	r5, r0, r7, lsl #2
    17b4:	07040800 	streq	r0, [r4, -r0, lsl #16]
    17b8:	00000b28 	andeq	r0, r0, r8, lsr #22
    17bc:	c5080108 	strgt	r0, [r8, #-264]	; 0xfffffef8
    17c0:	0700000b 	streq	r0, [r0, -fp]
    17c4:	0000006d 	andeq	r0, r0, sp, rrx
    17c8:	00002a09 	andeq	r2, r0, r9, lsl #20
    17cc:	124c0a00 	subne	r0, ip, #0, 20
    17d0:	64010000 	strvs	r0, [r1], #-0
    17d4:	00123706 	andseq	r3, r2, r6, lsl #14
    17d8:	008bcc00 	addeq	ip, fp, r0, lsl #24
    17dc:	00008000 	andeq	r8, r0, r0
    17e0:	fb9c0100 	blx	fe701bea <__bss_end+0xfe6f84b2>
    17e4:	0b000000 	bleq	17ec <shift+0x17ec>
    17e8:	00637273 	rsbeq	r7, r3, r3, ror r2
    17ec:	fb196401 	blx	65a7fa <__bss_end+0x6510c2>
    17f0:	02000000 	andeq	r0, r0, #0
    17f4:	640b6491 	strvs	r6, [fp], #-1169	; 0xfffffb6f
    17f8:	01007473 	tsteq	r0, r3, ror r4
    17fc:	01022464 	tsteq	r2, r4, ror #8
    1800:	91020000 	mrsls	r0, (UNDEF: 2)
    1804:	756e0b60 	strbvc	r0, [lr, #-2912]!	; 0xfffff4a0
    1808:	6401006d 	strvs	r0, [r1], #-109	; 0xffffff93
    180c:	0001042d 	andeq	r0, r1, sp, lsr #8
    1810:	5c910200 	lfmpl	f0, 4, [r1], {0}
    1814:	0012a60c 	andseq	sl, r2, ip, lsl #12
    1818:	0e660100 	poweqs	f0, f6, f0
    181c:	0000010b 	andeq	r0, r0, fp, lsl #2
    1820:	0c709102 	ldfeqp	f1, [r0], #-8
    1824:	00001229 	andeq	r1, r0, r9, lsr #4
    1828:	11086701 	tstne	r8, r1, lsl #14
    182c:	02000001 	andeq	r0, r0, #1
    1830:	f40d6c91 			; <UNDEFINED> instruction: 0xf40d6c91
    1834:	4800008b 	stmdami	r0, {r0, r1, r3, r7}
    1838:	0e000000 	cdpeq	0, 0, cr0, cr0, cr0, {0}
    183c:	69010069 	stmdbvs	r1, {r0, r3, r5, r6}
    1840:	0001040b 	andeq	r0, r1, fp, lsl #8
    1844:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    1848:	040f0000 	streq	r0, [pc], #-0	; 1850 <shift+0x1850>
    184c:	00000101 	andeq	r0, r0, r1, lsl #2
    1850:	12041110 	andne	r1, r4, #16, 2
    1854:	6e690504 	cdpvs	5, 6, cr0, cr9, cr4, {0}
    1858:	040f0074 	streq	r0, [pc], #-116	; 1860 <shift+0x1860>
    185c:	00000074 	andeq	r0, r0, r4, ror r0
    1860:	006d040f 	rsbeq	r0, sp, pc, lsl #8
    1864:	9b0a0000 	blls	28186c <__bss_end+0x278134>
    1868:	01000011 	tsteq	r0, r1, lsl r0
    186c:	11a8065c 			; <UNDEFINED> instruction: 0x11a8065c
    1870:	8b640000 	blhi	1901878 <__bss_end+0x18f8140>
    1874:	00680000 	rsbeq	r0, r8, r0
    1878:	9c010000 	stcls	0, cr0, [r1], {-0}
    187c:	00000176 	andeq	r0, r0, r6, ror r1
    1880:	00129f13 	andseq	r9, r2, r3, lsl pc
    1884:	125c0100 	subsne	r0, ip, #0, 2
    1888:	00000102 	andeq	r0, r0, r2, lsl #2
    188c:	136c9102 	cmnne	ip, #-2147483648	; 0x80000000
    1890:	000011a1 	andeq	r1, r0, r1, lsr #3
    1894:	041e5c01 	ldreq	r5, [lr], #-3073	; 0xfffff3ff
    1898:	02000001 	andeq	r0, r0, #1
    189c:	6d0e6891 	stcvs	8, cr6, [lr, #-580]	; 0xfffffdbc
    18a0:	01006d65 	tsteq	r0, r5, ror #26
    18a4:	0111085e 	tsteq	r1, lr, asr r8
    18a8:	91020000 	mrsls	r0, (UNDEF: 2)
    18ac:	8b800d70 	blhi	fe004e74 <__bss_end+0xfdffb73c>
    18b0:	003c0000 	eorseq	r0, ip, r0
    18b4:	690e0000 	stmdbvs	lr, {}	; <UNPREDICTABLE>
    18b8:	0b600100 	bleq	1801cc0 <__bss_end+0x17f8588>
    18bc:	00000104 	andeq	r0, r0, r4, lsl #2
    18c0:	00749102 	rsbseq	r9, r4, r2, lsl #2
    18c4:	12531400 	subsne	r1, r3, #0, 8
    18c8:	52010000 	andpl	r0, r1, #0
    18cc:	00126c05 	andseq	r6, r2, r5, lsl #24
    18d0:	00010400 	andeq	r0, r1, r0, lsl #8
    18d4:	008b1000 	addeq	r1, fp, r0
    18d8:	00005400 	andeq	r5, r0, r0, lsl #8
    18dc:	af9c0100 	svcge	0x009c0100
    18e0:	0b000001 	bleq	18ec <shift+0x18ec>
    18e4:	52010073 	andpl	r0, r1, #115	; 0x73
    18e8:	00010b18 	andeq	r0, r1, r8, lsl fp
    18ec:	6c910200 	lfmvs	f0, 4, [r1], {0}
    18f0:	0100690e 	tsteq	r0, lr, lsl #18
    18f4:	01040654 	tsteq	r4, r4, asr r6
    18f8:	91020000 	mrsls	r0, (UNDEF: 2)
    18fc:	8f140074 	svchi	0x00140074
    1900:	01000012 	tsteq	r0, r2, lsl r0
    1904:	125a0542 	subsne	r0, sl, #276824064	; 0x10800000
    1908:	01040000 	mrseq	r0, (UNDEF: 4)
    190c:	8a640000 	bhi	1901914 <__bss_end+0x18f81dc>
    1910:	00ac0000 	adceq	r0, ip, r0
    1914:	9c010000 	stcls	0, cr0, [r1], {-0}
    1918:	00000215 	andeq	r0, r0, r5, lsl r2
    191c:	0031730b 	eorseq	r7, r1, fp, lsl #6
    1920:	0b194201 	bleq	65212c <__bss_end+0x6489f4>
    1924:	02000001 	andeq	r0, r0, #1
    1928:	730b6c91 	movwvc	r6, #48273	; 0xbc91
    192c:	42010032 	andmi	r0, r1, #50	; 0x32
    1930:	00010b29 	andeq	r0, r1, r9, lsr #22
    1934:	68910200 	ldmvs	r1, {r9}
    1938:	6d756e0b 	ldclvs	14, cr6, [r5, #-44]!	; 0xffffffd4
    193c:	31420100 	mrscc	r0, (UNDEF: 82)
    1940:	00000104 	andeq	r0, r0, r4, lsl #2
    1944:	0e649102 	lgneqs	f1, f2
    1948:	01003175 	tsteq	r0, r5, ror r1
    194c:	02151044 	andseq	r1, r5, #68	; 0x44
    1950:	91020000 	mrsls	r0, (UNDEF: 2)
    1954:	32750e77 	rsbscc	r0, r5, #1904	; 0x770
    1958:	14440100 	strbne	r0, [r4], #-256	; 0xffffff00
    195c:	00000215 	andeq	r0, r0, r5, lsl r2
    1960:	00769102 	rsbseq	r9, r6, r2, lsl #2
    1964:	bc080108 	stflts	f0, [r8], {8}
    1968:	1400000b 	strne	r0, [r0], #-11
    196c:	00001297 	muleq	r0, r7, r2
    1970:	7e073601 	cfmadd32vc	mvax0, mvfx3, mvfx7, mvfx1
    1974:	11000012 	tstne	r0, r2, lsl r0
    1978:	a4000001 	strge	r0, [r0], #-1
    197c:	c0000089 	andgt	r0, r0, r9, lsl #1
    1980:	01000000 	mrseq	r0, (UNDEF: 0)
    1984:	0002759c 	muleq	r2, ip, r5
    1988:	11961300 	orrsne	r1, r6, r0, lsl #6
    198c:	36010000 	strcc	r0, [r1], -r0
    1990:	00011115 	andeq	r1, r1, r5, lsl r1
    1994:	6c910200 	lfmvs	f0, 4, [r1], {0}
    1998:	6372730b 	cmnvs	r2, #738197504	; 0x2c000000
    199c:	27360100 	ldrcs	r0, [r6, -r0, lsl #2]!
    19a0:	0000010b 	andeq	r0, r0, fp, lsl #2
    19a4:	0b689102 	bleq	1a25db4 <__bss_end+0x1a1c67c>
    19a8:	006d756e 	rsbeq	r7, sp, lr, ror #10
    19ac:	04303601 	ldrteq	r3, [r0], #-1537	; 0xfffff9ff
    19b0:	02000001 	andeq	r0, r0, #1
    19b4:	690e6491 	stmdbvs	lr, {r0, r4, r7, sl, sp, lr}
    19b8:	06380100 	ldrteq	r0, [r8], -r0, lsl #2
    19bc:	00000104 	andeq	r0, r0, r4, lsl #2
    19c0:	00749102 	rsbseq	r9, r4, r2, lsl #2
    19c4:	00127914 	andseq	r7, r2, r4, lsl r9
    19c8:	05240100 	streq	r0, [r4, #-256]!	; 0xffffff00
    19cc:	00001212 	andeq	r1, r0, r2, lsl r2
    19d0:	00000104 	andeq	r0, r0, r4, lsl #2
    19d4:	00008908 	andeq	r8, r0, r8, lsl #18
    19d8:	0000009c 	muleq	r0, ip, r0
    19dc:	02b29c01 	adcseq	r9, r2, #256	; 0x100
    19e0:	90130000 	andsls	r0, r3, r0
    19e4:	01000011 	tsteq	r0, r1, lsl r0
    19e8:	010b1624 	tsteq	fp, r4, lsr #12
    19ec:	91020000 	mrsls	r0, (UNDEF: 2)
    19f0:	12300c6c 	eorsne	r0, r0, #108, 24	; 0x6c00
    19f4:	26010000 	strcs	r0, [r1], -r0
    19f8:	00010406 	andeq	r0, r1, r6, lsl #8
    19fc:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    1a00:	12ad1500 	adcne	r1, sp, #0, 10
    1a04:	08010000 	stmdaeq	r1, {}	; <UNPREDICTABLE>
    1a08:	0012b206 	andseq	fp, r2, r6, lsl #4
    1a0c:	00879400 	addeq	r9, r7, r0, lsl #8
    1a10:	00017400 	andeq	r7, r1, r0, lsl #8
    1a14:	139c0100 	orrsne	r0, ip, #0, 2
    1a18:	00001190 	muleq	r0, r0, r1
    1a1c:	66180801 	ldrvs	r0, [r8], -r1, lsl #16
    1a20:	02000000 	andeq	r0, r0, #0
    1a24:	30136491 	mulscc	r3, r1, r4
    1a28:	01000012 	tsteq	r0, r2, lsl r0
    1a2c:	01112508 	tsteq	r1, r8, lsl #10
    1a30:	91020000 	mrsls	r0, (UNDEF: 2)
    1a34:	12471360 	subne	r1, r7, #96, 6	; 0x80000001
    1a38:	08010000 	stmdaeq	r1, {}	; <UNPREDICTABLE>
    1a3c:	0000663a 	andeq	r6, r0, sl, lsr r6
    1a40:	5c910200 	lfmpl	f0, 4, [r1], {0}
    1a44:	0100690e 	tsteq	r0, lr, lsl #18
    1a48:	0104060a 	tsteq	r4, sl, lsl #12
    1a4c:	91020000 	mrsls	r0, (UNDEF: 2)
    1a50:	88600d74 	stmdahi	r0!, {r2, r4, r5, r6, r8, sl, fp}^
    1a54:	00980000 	addseq	r0, r8, r0
    1a58:	6a0e0000 	bvs	381a60 <__bss_end+0x378328>
    1a5c:	0b1c0100 	bleq	701e64 <__bss_end+0x6f872c>
    1a60:	00000104 	andeq	r0, r0, r4, lsl #2
    1a64:	0d709102 	ldfeqp	f1, [r0, #-8]!
    1a68:	00008888 	andeq	r8, r0, r8, lsl #17
    1a6c:	00000060 	andeq	r0, r0, r0, rrx
    1a70:	0100630e 	tsteq	r0, lr, lsl #6
    1a74:	006d081e 	rsbeq	r0, sp, lr, lsl r8
    1a78:	91020000 	mrsls	r0, (UNDEF: 2)
    1a7c:	0000006f 	andeq	r0, r0, pc, rrx
    1a80:	000f4d00 	andeq	r4, pc, r0, lsl #26
    1a84:	da000400 	ble	2a8c <shift+0x2a8c>
    1a88:	04000007 	streq	r0, [r0], #-7
    1a8c:	00107c01 	andseq	r7, r0, r1, lsl #24
    1a90:	13020400 	movwne	r0, #9216	; 0x2400
    1a94:	0d490000 	stcleq	0, cr0, [r9, #-0]
    1a98:	8c4c0000 	marhi	acc0, r0, ip
    1a9c:	04b40000 	ldrteq	r0, [r4], #0
    1aa0:	0b120000 	bleq	481aa8 <__bss_end+0x478370>
    1aa4:	01020000 	mrseq	r0, (UNDEF: 2)
    1aa8:	000bc508 	andeq	ip, fp, r8, lsl #10
    1aac:	00250300 	eoreq	r0, r5, r0, lsl #6
    1ab0:	02020000 	andeq	r0, r2, #0
    1ab4:	000a4e05 	andeq	r4, sl, r5, lsl #28
    1ab8:	05040400 	streq	r0, [r4, #-1024]	; 0xfffffc00
    1abc:	00746e69 	rsbseq	r6, r4, r9, ror #28
    1ac0:	00003803 	andeq	r3, r0, r3, lsl #16
    1ac4:	14690500 	strbtne	r0, [r9], #-1280	; 0xfffffb00
    1ac8:	07020000 	streq	r0, [r2, -r0]
    1acc:	00005507 	andeq	r5, r0, r7, lsl #10
    1ad0:	00440300 	subeq	r0, r4, r0, lsl #6
    1ad4:	01020000 	mrseq	r0, (UNDEF: 2)
    1ad8:	000bbc08 	andeq	fp, fp, r8, lsl #24
    1adc:	09e20500 	stmibeq	r2!, {r8, sl}^
    1ae0:	08020000 	stmdaeq	r2, {}	; <UNPREDICTABLE>
    1ae4:	00006d07 	andeq	r6, r0, r7, lsl #26
    1ae8:	005c0300 	subseq	r0, ip, r0, lsl #6
    1aec:	02020000 	andeq	r0, r2, #0
    1af0:	000c8507 	andeq	r8, ip, r7, lsl #10
    1af4:	062d0500 	strteq	r0, [sp], -r0, lsl #10
    1af8:	09020000 	stmdbeq	r2, {}	; <UNPREDICTABLE>
    1afc:	00008507 	andeq	r8, r0, r7, lsl #10
    1b00:	00740300 	rsbseq	r0, r4, r0, lsl #6
    1b04:	04020000 	streq	r0, [r2], #-0
    1b08:	000b2807 	andeq	r2, fp, r7, lsl #16
    1b0c:	00850300 	addeq	r0, r5, r0, lsl #6
    1b10:	59060000 	stmdbpl	r6, {}	; <UNPREDICTABLE>
    1b14:	0800000a 	stmdaeq	r0, {r1, r3}
    1b18:	d5070603 	strle	r0, [r7, #-1539]	; 0xfffff9fd
    1b1c:	07000001 	streq	r0, [r0, -r1]
    1b20:	000007d1 	ldrdeq	r0, [r0], -r1
    1b24:	74120a03 	ldrvc	r0, [r2], #-2563	; 0xfffff5fd
    1b28:	00000000 	andeq	r0, r0, r0
    1b2c:	0009eb07 	andeq	lr, r9, r7, lsl #22
    1b30:	0e0c0300 	cdpeq	3, 0, cr0, cr12, cr0, {0}
    1b34:	000001da 	ldrdeq	r0, [r0], -sl
    1b38:	0a590804 	beq	1643b50 <__bss_end+0x163a418>
    1b3c:	10030000 	andne	r0, r3, r0
    1b40:	0005e209 	andeq	lr, r5, r9, lsl #4
    1b44:	0001e600 	andeq	lr, r1, r0, lsl #12
    1b48:	00d10100 	sbcseq	r0, r1, r0, lsl #2
    1b4c:	00dc0000 	sbcseq	r0, ip, r0
    1b50:	e6090000 	str	r0, [r9], -r0
    1b54:	0a000001 	beq	1b60 <shift+0x1b60>
    1b58:	000001f1 	strdeq	r0, [r0], -r1
    1b5c:	0a580800 	beq	1603b64 <__bss_end+0x15fa42c>
    1b60:	12030000 	andne	r0, r3, #0
    1b64:	000a2e15 	andeq	r2, sl, r5, lsl lr
    1b68:	0001f700 	andeq	pc, r1, r0, lsl #14
    1b6c:	00f50100 	rscseq	r0, r5, r0, lsl #2
    1b70:	01000000 	mrseq	r0, (UNDEF: 0)
    1b74:	e6090000 	str	r0, [r9], -r0
    1b78:	09000001 	stmdbeq	r0, {r0}
    1b7c:	00000038 	andeq	r0, r0, r8, lsr r0
    1b80:	05fb0800 	ldrbeq	r0, [fp, #2048]!	; 0x800
    1b84:	15030000 	strne	r0, [r3, #-0]
    1b88:	0008200e 	andeq	r2, r8, lr
    1b8c:	0001da00 	andeq	sp, r1, r0, lsl #20
    1b90:	01190100 	tsteq	r9, r0, lsl #2
    1b94:	011f0000 	tsteq	pc, r0
    1b98:	f9090000 			; <UNDEFINED> instruction: 0xf9090000
    1b9c:	00000001 	andeq	r0, r0, r1
    1ba0:	000b350b 	andeq	r3, fp, fp, lsl #10
    1ba4:	0e180300 	cdpeq	3, 1, cr0, cr8, cr0, {0}
    1ba8:	0000076c 	andeq	r0, r0, ip, ror #14
    1bac:	00013401 	andeq	r3, r1, r1, lsl #8
    1bb0:	00013a00 	andeq	r3, r1, r0, lsl #20
    1bb4:	01e60900 	mvneq	r0, r0, lsl #18
    1bb8:	0b000000 	bleq	1bc0 <shift+0x1bc0>
    1bbc:	0000081a 	andeq	r0, r0, sl, lsl r8
    1bc0:	980e1b03 	stmdals	lr, {r0, r1, r8, r9, fp, ip}
    1bc4:	01000006 	tsteq	r0, r6
    1bc8:	0000014f 	andeq	r0, r0, pc, asr #2
    1bcc:	0000015a 	andeq	r0, r0, sl, asr r1
    1bd0:	0001e609 	andeq	lr, r1, r9, lsl #12
    1bd4:	01da0a00 	bicseq	r0, sl, r0, lsl #20
    1bd8:	0b000000 	bleq	1be0 <shift+0x1be0>
    1bdc:	00000ba4 	andeq	r0, r0, r4, lsr #23
    1be0:	220e1d03 	andcs	r1, lr, #3, 26	; 0xc0
    1be4:	0100000c 	tsteq	r0, ip
    1be8:	0000016f 	andeq	r0, r0, pc, ror #2
    1bec:	00000184 	andeq	r0, r0, r4, lsl #3
    1bf0:	0001e609 	andeq	lr, r1, r9, lsl #12
    1bf4:	005c0a00 	subseq	r0, ip, r0, lsl #20
    1bf8:	5c0a0000 	stcpl	0, cr0, [sl], {-0}
    1bfc:	0a000000 	beq	1c04 <shift+0x1c04>
    1c00:	000001da 	ldrdeq	r0, [r0], -sl
    1c04:	06bd0b00 	ldrteq	r0, [sp], r0, lsl #22
    1c08:	1f030000 	svcne	0x00030000
    1c0c:	0005430e 	andeq	r4, r5, lr, lsl #6
    1c10:	01990100 	orrseq	r0, r9, r0, lsl #2
    1c14:	01ae0000 			; <UNDEFINED> instruction: 0x01ae0000
    1c18:	e6090000 	str	r0, [r9], -r0
    1c1c:	0a000001 	beq	1c28 <shift+0x1c28>
    1c20:	0000005c 	andeq	r0, r0, ip, asr r0
    1c24:	00005c0a 	andeq	r5, r0, sl, lsl #24
    1c28:	00250a00 	eoreq	r0, r5, r0, lsl #20
    1c2c:	0c000000 	stceq	0, cr0, [r0], {-0}
    1c30:	00000ca2 	andeq	r0, r0, r2, lsr #25
    1c34:	fe0e2103 	cdp2	1, 0, cr2, cr14, cr3, {0}
    1c38:	0100000a 	tsteq	r0, sl
    1c3c:	000001bf 			; <UNDEFINED> instruction: 0x000001bf
    1c40:	0001e609 	andeq	lr, r1, r9, lsl #12
    1c44:	005c0a00 	subseq	r0, ip, r0, lsl #20
    1c48:	5c0a0000 	stcpl	0, cr0, [sl], {-0}
    1c4c:	0a000000 	beq	1c54 <shift+0x1c54>
    1c50:	000001f1 	strdeq	r0, [r0], -r1
    1c54:	91030000 	mrsls	r0, (UNDEF: 3)
    1c58:	02000000 	andeq	r0, r0, #0
    1c5c:	08b90201 	ldmeq	r9!, {r0, r9}
    1c60:	da030000 	ble	c1c68 <__bss_end+0xb8530>
    1c64:	0d000001 	stceq	0, cr0, [r0, #-4]
    1c68:	00009104 	andeq	r9, r0, r4, lsl #2
    1c6c:	01e60300 	mvneq	r0, r0, lsl #6
    1c70:	040d0000 	streq	r0, [sp], #-0
    1c74:	0000002c 	andeq	r0, r0, ip, lsr #32
    1c78:	040d040e 	streq	r0, [sp], #-1038	; 0xfffffbf2
    1c7c:	000001d5 	ldrdeq	r0, [r0], -r5
    1c80:	0001f903 	andeq	pc, r1, r3, lsl #18
    1c84:	0d330f00 	ldceq	15, cr0, [r3, #-0]
    1c88:	04080000 	streq	r0, [r8], #-0
    1c8c:	022a0806 	eoreq	r0, sl, #393216	; 0x60000
    1c90:	72100000 	andsvc	r0, r0, #0
    1c94:	08040030 	stmdaeq	r4, {r4, r5}
    1c98:	0000740e 	andeq	r7, r0, lr, lsl #8
    1c9c:	72100000 	andsvc	r0, r0, #0
    1ca0:	09040031 	stmdbeq	r4, {r0, r4, r5}
    1ca4:	0000740e 	andeq	r7, r0, lr, lsl #8
    1ca8:	11000400 	tstne	r0, r0, lsl #8
    1cac:	00000aa8 	andeq	r0, r0, r8, lsr #21
    1cb0:	00380405 	eorseq	r0, r8, r5, lsl #8
    1cb4:	1e040000 	cdpne	0, 0, cr0, cr4, cr0, {0}
    1cb8:	0002610c 	andeq	r6, r2, ip, lsl #2
    1cbc:	06251200 	strteq	r1, [r5], -r0, lsl #4
    1cc0:	12000000 	andne	r0, r0, #0
    1cc4:	000007de 	ldrdeq	r0, [r0], -lr
    1cc8:	0aca1201 	beq	ff2864d4 <__bss_end+0xff27cd9c>
    1ccc:	12020000 	andne	r0, r2, #0
    1cd0:	00000bd8 	ldrdeq	r0, [r0], -r8
    1cd4:	07bc1203 	ldreq	r1, [ip, r3, lsl #4]!
    1cd8:	12040000 	andne	r0, r4, #0
    1cdc:	00000a45 	andeq	r0, r0, r5, asr #20
    1ce0:	90110005 	andsls	r0, r1, r5
    1ce4:	0500000a 	streq	r0, [r0, #-10]
    1ce8:	00003804 	andeq	r3, r0, r4, lsl #16
    1cec:	0c3f0400 	cfldrseq	mvf0, [pc], #-0	; 1cf4 <shift+0x1cf4>
    1cf0:	0000029e 	muleq	r0, lr, r2
    1cf4:	00075c12 	andeq	r5, r7, r2, lsl ip
    1cf8:	d9120000 	ldmdble	r2, {}	; <UNPREDICTABLE>
    1cfc:	01000007 	tsteq	r0, r7
    1d00:	000ccc12 	andeq	ip, ip, r2, lsl ip
    1d04:	90120200 	andsls	r0, r2, r0, lsl #4
    1d08:	03000009 	movweq	r0, #9
    1d0c:	0007cb12 	andeq	ip, r7, r2, lsl fp
    1d10:	40120400 	andsmi	r0, r2, r0, lsl #8
    1d14:	05000008 	streq	r0, [r0, #-8]
    1d18:	0006c612 	andeq	ip, r6, r2, lsl r6
    1d1c:	13000600 	movwne	r0, #1536	; 0x600
    1d20:	0000096e 	andeq	r0, r0, lr, ror #18
    1d24:	80140505 	andshi	r0, r4, r5, lsl #10
    1d28:	05000000 	streq	r0, [r0, #-0]
    1d2c:	00947003 	addseq	r7, r4, r3
    1d30:	0b461300 	bleq	1186938 <__bss_end+0x117d200>
    1d34:	06050000 	streq	r0, [r5], -r0
    1d38:	00008014 	andeq	r8, r0, r4, lsl r0
    1d3c:	74030500 	strvc	r0, [r3], #-1280	; 0xfffffb00
    1d40:	13000094 	movwne	r0, #148	; 0x94
    1d44:	00000855 	andeq	r0, r0, r5, asr r8
    1d48:	801a0706 	andshi	r0, sl, r6, lsl #14
    1d4c:	05000000 	streq	r0, [r0, #-0]
    1d50:	00947803 	addseq	r7, r4, r3, lsl #16
    1d54:	0a671300 	beq	19c695c <__bss_end+0x19bd224>
    1d58:	09060000 	stmdbeq	r6, {}	; <UNPREDICTABLE>
    1d5c:	0000801a 	andeq	r8, r0, sl, lsl r0
    1d60:	7c030500 	cfstr32vc	mvfx0, [r3], {-0}
    1d64:	13000094 	movwne	r0, #148	; 0x94
    1d68:	00000847 	andeq	r0, r0, r7, asr #16
    1d6c:	801a0b06 	andshi	r0, sl, r6, lsl #22
    1d70:	05000000 	streq	r0, [r0, #-0]
    1d74:	00948003 	addseq	r8, r4, r3
    1d78:	0a1b1300 	beq	6c6980 <__bss_end+0x6bd248>
    1d7c:	0d060000 	stceq	0, cr0, [r6, #-0]
    1d80:	0000801a 	andeq	r8, r0, sl, lsl r0
    1d84:	84030500 	strhi	r0, [r3], #-1280	; 0xfffffb00
    1d88:	13000094 	movwne	r0, #148	; 0x94
    1d8c:	00000605 	andeq	r0, r0, r5, lsl #12
    1d90:	801a0f06 	andshi	r0, sl, r6, lsl #30
    1d94:	05000000 	streq	r0, [r0, #-0]
    1d98:	00948803 	addseq	r8, r4, r3, lsl #16
    1d9c:	04591400 	ldrbeq	r1, [r9], #-1024	; 0xfffffc00
    1da0:	040d0000 	streq	r0, [sp], #-0
    1da4:	0000031c 	andeq	r0, r0, ip, lsl r3
    1da8:	00059b13 	andeq	r9, r5, r3, lsl fp
    1dac:	14040700 	strne	r0, [r4], #-1792	; 0xfffff900
    1db0:	00000080 	andeq	r0, r0, r0, lsl #1
    1db4:	948c0305 	strls	r0, [ip], #773	; 0x305
    1db8:	d0130000 	andsle	r0, r3, r0
    1dbc:	0700000a 	streq	r0, [r0, -sl]
    1dc0:	00801407 	addeq	r1, r0, r7, lsl #8
    1dc4:	03050000 	movweq	r0, #20480	; 0x5000
    1dc8:	00009490 	muleq	r0, r0, r4
    1dcc:	0004e213 	andeq	lr, r4, r3, lsl r2
    1dd0:	140a0700 	strne	r0, [sl], #-1792	; 0xfffff900
    1dd4:	00000080 	andeq	r0, r0, r0, lsl #1
    1dd8:	94940305 	ldrls	r0, [r4], #773	; 0x305
    1ddc:	cb110000 	blgt	441de4 <__bss_end+0x4386ac>
    1de0:	05000006 	streq	r0, [r0, #-6]
    1de4:	00003804 	andeq	r3, r0, r4, lsl #16
    1de8:	0c0d0700 	stceq	7, cr0, [sp], {-0}
    1dec:	00000394 	muleq	r0, r4, r3
    1df0:	77654e15 			; <UNDEFINED> instruction: 0x77654e15
    1df4:	c2120000 	andsgt	r0, r2, #0
    1df8:	01000004 	tsteq	r0, r4
    1dfc:	0004da12 	andeq	sp, r4, r2, lsl sl
    1e00:	e4120200 	ldr	r0, [r2], #-512	; 0xfffffe00
    1e04:	03000006 	movweq	r0, #6
    1e08:	000bca12 	andeq	ip, fp, r2, lsl sl
    1e0c:	b6120400 	ldrlt	r0, [r2], -r0, lsl #8
    1e10:	05000004 	streq	r0, [r0, #-4]
    1e14:	05b40f00 	ldreq	r0, [r4, #3840]!	; 0xf00
    1e18:	07100000 	ldreq	r0, [r0, -r0]
    1e1c:	03d3081b 	bicseq	r0, r3, #1769472	; 0x1b0000
    1e20:	6c100000 	ldcvs	0, cr0, [r0], {-0}
    1e24:	1d070072 	stcne	0, cr0, [r7, #-456]	; 0xfffffe38
    1e28:	0003d313 	andeq	sp, r3, r3, lsl r3
    1e2c:	73100000 	tstvc	r0, #0
    1e30:	1e070070 	mcrne	0, 0, r0, cr7, cr0, {3}
    1e34:	0003d313 	andeq	sp, r3, r3, lsl r3
    1e38:	70100400 	andsvc	r0, r0, r0, lsl #8
    1e3c:	1f070063 	svcne	0x00070063
    1e40:	0003d313 	andeq	sp, r3, r3, lsl r3
    1e44:	8a070800 	bhi	1c3e4c <__bss_end+0x1ba714>
    1e48:	0700000a 	streq	r0, [r0, -sl]
    1e4c:	03d31320 	bicseq	r1, r3, #32, 6	; 0x80000000
    1e50:	000c0000 	andeq	r0, ip, r0
    1e54:	23070402 	movwcs	r0, #29698	; 0x7402
    1e58:	0300000b 	movweq	r0, #11
    1e5c:	000003d3 	ldrdeq	r0, [r0], -r3
    1e60:	0007af0f 	andeq	sl, r7, pc, lsl #30
    1e64:	28077000 	stmdacs	r7, {ip, sp, lr}
    1e68:	00046f08 	andeq	r6, r4, r8, lsl #30
    1e6c:	07410700 	strbeq	r0, [r1, -r0, lsl #14]
    1e70:	2a070000 	bcs	1c1e78 <__bss_end+0x1b8740>
    1e74:	00039412 	andeq	r9, r3, r2, lsl r4
    1e78:	70100000 	andsvc	r0, r0, r0
    1e7c:	07006469 	streq	r6, [r0, -r9, ror #8]
    1e80:	0085122b 	addeq	r1, r5, fp, lsr #4
    1e84:	07100000 	ldreq	r0, [r0, -r0]
    1e88:	00000bfd 	strdeq	r0, [r0], -sp
    1e8c:	5d112c07 	ldcpl	12, cr2, [r1, #-28]	; 0xffffffe4
    1e90:	14000003 	strne	r0, [r0], #-3
    1e94:	000bae07 	andeq	sl, fp, r7, lsl #28
    1e98:	122d0700 	eorne	r0, sp, #0, 14
    1e9c:	00000085 	andeq	r0, r0, r5, lsl #1
    1ea0:	03e90718 	mvneq	r0, #24, 14	; 0x600000
    1ea4:	2e070000 	cdpcs	0, 0, cr0, cr7, cr0, {0}
    1ea8:	00008512 	andeq	r8, r0, r2, lsl r5
    1eac:	bd071c00 	stclt	12, cr1, [r7, #-0]
    1eb0:	0700000a 	streq	r0, [r0, -sl]
    1eb4:	046f0c2f 	strbteq	r0, [pc], #-3119	; 1ebc <shift+0x1ebc>
    1eb8:	07200000 	streq	r0, [r0, -r0]!
    1ebc:	00000472 	andeq	r0, r0, r2, ror r4
    1ec0:	38093007 	stmdacc	r9, {r0, r1, r2, ip, sp}
    1ec4:	60000000 	andvs	r0, r0, r0
    1ec8:	0006ff07 	andeq	pc, r6, r7, lsl #30
    1ecc:	0e310700 	cdpeq	7, 3, cr0, cr1, cr0, {0}
    1ed0:	00000074 	andeq	r0, r0, r4, ror r0
    1ed4:	09d40764 	ldmibeq	r4, {r2, r5, r6, r8, r9, sl}^
    1ed8:	33070000 	movwcc	r0, #28672	; 0x7000
    1edc:	0000740e 	andeq	r7, r0, lr, lsl #8
    1ee0:	cb076800 	blgt	1dbee8 <__bss_end+0x1d27b0>
    1ee4:	07000009 	streq	r0, [r0, -r9]
    1ee8:	00740e34 	rsbseq	r0, r4, r4, lsr lr
    1eec:	006c0000 	rsbeq	r0, ip, r0
    1ef0:	00032116 	andeq	r2, r3, r6, lsl r1
    1ef4:	00047f00 	andeq	r7, r4, r0, lsl #30
    1ef8:	00851700 	addeq	r1, r5, r0, lsl #14
    1efc:	000f0000 	andeq	r0, pc, r0
    1f00:	0004cb13 	andeq	ip, r4, r3, lsl fp
    1f04:	140a0800 	strne	r0, [sl], #-2048	; 0xfffff800
    1f08:	00000080 	andeq	r0, r0, r0, lsl #1
    1f0c:	94980305 	ldrls	r0, [r8], #773	; 0x305
    1f10:	90110000 	andsls	r0, r1, r0
    1f14:	05000008 	streq	r0, [r0, #-8]
    1f18:	00003804 	andeq	r3, r0, r4, lsl #16
    1f1c:	0c0d0800 	stceq	8, cr0, [sp], {-0}
    1f20:	000004b0 			; <UNDEFINED> instruction: 0x000004b0
    1f24:	000cd212 	andeq	sp, ip, r2, lsl r2
    1f28:	17120000 	ldrne	r0, [r2, -r0]
    1f2c:	0100000c 	tsteq	r0, ip
    1f30:	072e0f00 	streq	r0, [lr, -r0, lsl #30]!
    1f34:	080c0000 	stmdaeq	ip, {}	; <UNPREDICTABLE>
    1f38:	04e5081b 	strbteq	r0, [r5], #2075	; 0x81b
    1f3c:	3e070000 	cdpcc	0, 0, cr0, cr7, cr0, {0}
    1f40:	08000005 	stmdaeq	r0, {r0, r2}
    1f44:	04e5191d 	strbteq	r1, [r5], #2333	; 0x91d
    1f48:	07000000 	streq	r0, [r0, -r0]
    1f4c:	000004bd 			; <UNDEFINED> instruction: 0x000004bd
    1f50:	e5191e08 	ldr	r1, [r9, #-3592]	; 0xfffff1f8
    1f54:	04000004 	streq	r0, [r0], #-4
    1f58:	0008b407 	andeq	fp, r8, r7, lsl #8
    1f5c:	131f0800 	tstne	pc, #0, 16
    1f60:	000004eb 	andeq	r0, r0, fp, ror #9
    1f64:	040d0008 	streq	r0, [sp], #-8
    1f68:	000004b0 			; <UNDEFINED> instruction: 0x000004b0
    1f6c:	03df040d 	bicseq	r0, pc, #218103808	; 0xd000000
    1f70:	79060000 	stmdbvc	r6, {}	; <UNPREDICTABLE>
    1f74:	1400000a 	strne	r0, [r0], #-10
    1f78:	73072208 	movwvc	r2, #29192	; 0x7208
    1f7c:	07000007 	streq	r0, [r0, -r7]
    1f80:	0000097c 	andeq	r0, r0, ip, ror r9
    1f84:	74122608 	ldrvc	r2, [r2], #-1544	; 0xfffff9f8
    1f88:	00000000 	andeq	r0, r0, r0
    1f8c:	00091e07 	andeq	r1, r9, r7, lsl #28
    1f90:	1d290800 	stcne	8, cr0, [r9, #-0]
    1f94:	000004e5 	andeq	r0, r0, r5, ror #9
    1f98:	06ec0704 	strbteq	r0, [ip], r4, lsl #14
    1f9c:	2c080000 	stccs	0, cr0, [r8], {-0}
    1fa0:	0004e51d 	andeq	lr, r4, sp, lsl r5
    1fa4:	86180800 	ldrhi	r0, [r8], -r0, lsl #16
    1fa8:	08000009 	stmdaeq	r0, {r0, r3}
    1fac:	070b0e2f 	streq	r0, [fp, -pc, lsr #28]
    1fb0:	05390000 	ldreq	r0, [r9, #-0]!
    1fb4:	05440000 	strbeq	r0, [r4, #-0]
    1fb8:	78090000 	stmdavc	r9, {}	; <UNPREDICTABLE>
    1fbc:	0a000007 	beq	1fe0 <shift+0x1fe0>
    1fc0:	000004e5 	andeq	r0, r0, r5, ror #9
    1fc4:	07e81900 	strbeq	r1, [r8, r0, lsl #18]!
    1fc8:	31080000 	mrscc	r0, (UNDEF: 8)
    1fcc:	0007860e 	andeq	r8, r7, lr, lsl #12
    1fd0:	0001da00 	andeq	sp, r1, r0, lsl #20
    1fd4:	00055c00 	andeq	r5, r5, r0, lsl #24
    1fd8:	00056700 	andeq	r6, r5, r0, lsl #14
    1fdc:	07780900 	ldrbeq	r0, [r8, -r0, lsl #18]!
    1fe0:	eb0a0000 	bl	281fe8 <__bss_end+0x2788b0>
    1fe4:	00000004 	andeq	r0, r0, r4
    1fe8:	000bde08 	andeq	sp, fp, r8, lsl #28
    1fec:	1d350800 	ldcne	8, cr0, [r5, #-0]
    1ff0:	0000086b 	andeq	r0, r0, fp, ror #16
    1ff4:	000004e5 	andeq	r0, r0, r5, ror #9
    1ff8:	00058002 	andeq	r8, r5, r2
    1ffc:	00058600 	andeq	r8, r5, r0, lsl #12
    2000:	07780900 	ldrbeq	r0, [r8, -r0, lsl #18]!
    2004:	08000000 	stmdaeq	r0, {}	; <UNPREDICTABLE>
    2008:	000006d7 	ldrdeq	r0, [r0], -r7
    200c:	961d3708 	ldrls	r3, [sp], -r8, lsl #14
    2010:	e5000009 	str	r0, [r0, #-9]
    2014:	02000004 	andeq	r0, r0, #4
    2018:	0000059f 	muleq	r0, pc, r5	; <UNPREDICTABLE>
    201c:	000005a5 	andeq	r0, r0, r5, lsr #11
    2020:	00077809 	andeq	r7, r7, r9, lsl #16
    2024:	311a0000 	tstcc	sl, r0
    2028:	08000009 	stmdaeq	r0, {r0, r3}
    202c:	07913139 			; <UNDEFINED> instruction: 0x07913139
    2030:	020c0000 	andeq	r0, ip, #0
    2034:	000a7908 	andeq	r7, sl, r8, lsl #18
    2038:	093c0800 	ldmdbeq	ip!, {fp}
    203c:	000007f7 	strdeq	r0, [r0], -r7
    2040:	00000778 	andeq	r0, r0, r8, ror r7
    2044:	0005cc01 	andeq	ip, r5, r1, lsl #24
    2048:	0005d200 	andeq	sp, r5, r0, lsl #4
    204c:	07780900 	ldrbeq	r0, [r8, -r0, lsl #18]!
    2050:	08000000 	stmdaeq	r0, {}	; <UNPREDICTABLE>
    2054:	0000074d 	andeq	r0, r0, sp, asr #14
    2058:	13123f08 	tstne	r2, #8, 30
    205c:	74000005 	strvc	r0, [r0], #-5
    2060:	01000000 	mrseq	r0, (UNDEF: 0)
    2064:	000005eb 	andeq	r0, r0, fp, ror #11
    2068:	00000600 	andeq	r0, r0, r0, lsl #12
    206c:	00077809 	andeq	r7, r7, r9, lsl #16
    2070:	079a0a00 	ldreq	r0, [sl, r0, lsl #20]
    2074:	850a0000 	strhi	r0, [sl, #-0]
    2078:	0a000000 	beq	2080 <shift+0x2080>
    207c:	000001da 	ldrdeq	r0, [r0], -sl
    2080:	0c0e0b00 			; <UNDEFINED> instruction: 0x0c0e0b00
    2084:	42080000 	andmi	r0, r8, #0
    2088:	0005c10e 	andeq	ip, r5, lr, lsl #2
    208c:	06150100 	ldreq	r0, [r5], -r0, lsl #2
    2090:	061b0000 	ldreq	r0, [fp], -r0
    2094:	78090000 	stmdavc	r9, {}	; <UNPREDICTABLE>
    2098:	00000007 	andeq	r0, r0, r7
    209c:	0004f508 	andeq	pc, r4, r8, lsl #10
    20a0:	17450800 	strbne	r0, [r5, -r0, lsl #16]
    20a4:	00000563 	andeq	r0, r0, r3, ror #10
    20a8:	000004eb 	andeq	r0, r0, fp, ror #9
    20ac:	00063401 	andeq	r3, r6, r1, lsl #8
    20b0:	00063a00 	andeq	r3, r6, r0, lsl #20
    20b4:	07a00900 	streq	r0, [r0, r0, lsl #18]!
    20b8:	08000000 	stmdaeq	r0, {}	; <UNPREDICTABLE>
    20bc:	00000adb 	ldrdeq	r0, [r0], -fp
    20c0:	ff174808 			; <UNDEFINED> instruction: 0xff174808
    20c4:	eb000003 	bl	20d8 <shift+0x20d8>
    20c8:	01000004 	tsteq	r0, r4
    20cc:	00000653 	andeq	r0, r0, r3, asr r6
    20d0:	0000065e 	andeq	r0, r0, lr, asr r6
    20d4:	0007a009 	andeq	sl, r7, r9
    20d8:	00740a00 	rsbseq	r0, r4, r0, lsl #20
    20dc:	0b000000 	bleq	20e4 <shift+0x20e4>
    20e0:	0000060f 	andeq	r0, r0, pc, lsl #12
    20e4:	3f0e4b08 	svccc	0x000e4b08
    20e8:	01000009 	tsteq	r0, r9
    20ec:	00000673 	andeq	r0, r0, r3, ror r6
    20f0:	00000679 	andeq	r0, r0, r9, ror r6
    20f4:	00077809 	andeq	r7, r7, r9, lsl #16
    20f8:	e8080000 	stmda	r8, {}	; <UNPREDICTABLE>
    20fc:	08000007 	stmdaeq	r0, {r0, r1, r2}
    2100:	09f30e4d 	ldmibeq	r3!, {r0, r2, r3, r6, r9, sl, fp}^
    2104:	01da0000 	bicseq	r0, sl, r0
    2108:	92010000 	andls	r0, r1, #0
    210c:	9d000006 	stcls	0, cr0, [r0, #-24]	; 0xffffffe8
    2110:	09000006 	stmdbeq	r0, {r1, r2}
    2114:	00000778 	andeq	r0, r0, r8, ror r7
    2118:	0000740a 	andeq	r7, r0, sl, lsl #8
    211c:	a2080000 	andge	r0, r8, #0
    2120:	08000004 	stmdaeq	r0, {r2}
    2124:	042c1250 	strteq	r1, [ip], #-592	; 0xfffffdb0
    2128:	00740000 	rsbseq	r0, r4, r0
    212c:	b6010000 	strlt	r0, [r1], -r0
    2130:	c1000006 	tstgt	r0, r6
    2134:	09000006 	stmdbeq	r0, {r1, r2}
    2138:	00000778 	andeq	r0, r0, r8, ror r7
    213c:	0003210a 	andeq	r2, r3, sl, lsl #2
    2140:	5f080000 	svcpl	0x00080000
    2144:	08000004 	stmdaeq	r0, {r2}
    2148:	0c430e53 	mcrreq	14, 5, r0, r3, cr3
    214c:	01da0000 	bicseq	r0, sl, r0
    2150:	da010000 	ble	42158 <__bss_end+0x38a20>
    2154:	e5000006 	str	r0, [r0, #-6]
    2158:	09000006 	stmdbeq	r0, {r1, r2}
    215c:	00000778 	andeq	r0, r0, r8, ror r7
    2160:	0000740a 	andeq	r7, r0, sl, lsl #8
    2164:	7c0b0000 	stcvc	0, cr0, [fp], {-0}
    2168:	08000004 	stmdaeq	r0, {r2}
    216c:	0b520e56 	bleq	1485acc <__bss_end+0x147c394>
    2170:	fa010000 	blx	42178 <__bss_end+0x38a40>
    2174:	19000006 	stmdbne	r0, {r1, r2}
    2178:	09000007 	stmdbeq	r0, {r0, r1, r2}
    217c:	00000778 	andeq	r0, r0, r8, ror r7
    2180:	00022a0a 	andeq	r2, r2, sl, lsl #20
    2184:	00740a00 	rsbseq	r0, r4, r0, lsl #20
    2188:	740a0000 	strvc	r0, [sl], #-0
    218c:	0a000000 	beq	2194 <shift+0x2194>
    2190:	00000074 	andeq	r0, r0, r4, ror r0
    2194:	0007a60a 	andeq	sl, r7, sl, lsl #12
    2198:	6f0b0000 	svcvs	0x000b0000
    219c:	0800000c 	stmdaeq	r0, {r2, r3}
    21a0:	0ce70e58 	stcleq	14, cr0, [r7], #352	; 0x160
    21a4:	2e010000 	cdpcs	0, 0, cr0, cr1, cr0, {0}
    21a8:	4d000007 	stcmi	0, cr0, [r0, #-28]	; 0xffffffe4
    21ac:	09000007 	stmdbeq	r0, {r0, r1, r2}
    21b0:	00000778 	andeq	r0, r0, r8, ror r7
    21b4:	0002610a 	andeq	r6, r2, sl, lsl #2
    21b8:	00740a00 	rsbseq	r0, r4, r0, lsl #20
    21bc:	740a0000 	strvc	r0, [sl], #-0
    21c0:	0a000000 	beq	21c8 <shift+0x21c8>
    21c4:	00000074 	andeq	r0, r0, r4, ror r0
    21c8:	0007a60a 	andeq	sl, r7, sl, lsl #12
    21cc:	8f1b0000 	svchi	0x001b0000
    21d0:	08000004 	stmdaeq	r0, {r2}
    21d4:	08be0e5b 	ldmeq	lr!, {r0, r1, r3, r4, r6, r9, sl, fp}
    21d8:	01da0000 	bicseq	r0, sl, r0
    21dc:	62010000 	andvs	r0, r1, #0
    21e0:	09000007 	stmdbeq	r0, {r0, r1, r2}
    21e4:	00000778 	andeq	r0, r0, r8, ror r7
    21e8:	0004910a 	andeq	r9, r4, sl, lsl #2
    21ec:	01f70a00 	mvnseq	r0, r0, lsl #20
    21f0:	00000000 	andeq	r0, r0, r0
    21f4:	0004f103 	andeq	pc, r4, r3, lsl #2
    21f8:	f1040d00 			; <UNDEFINED> instruction: 0xf1040d00
    21fc:	1c000004 	stcne	0, cr0, [r0], {4}
    2200:	000004e5 	andeq	r0, r0, r5, ror #9
    2204:	0000078b 	andeq	r0, r0, fp, lsl #15
    2208:	00000791 	muleq	r0, r1, r7
    220c:	00077809 	andeq	r7, r7, r9, lsl #16
    2210:	f11d0000 			; <UNDEFINED> instruction: 0xf11d0000
    2214:	7e000004 	cdpvc	0, 0, cr0, cr0, cr4, {0}
    2218:	0d000007 	stceq	0, cr0, [r0, #-28]	; 0xffffffe4
    221c:	00005504 	andeq	r5, r0, r4, lsl #10
    2220:	73040d00 	movwvc	r0, #19712	; 0x4d00
    2224:	1e000007 	cdpne	0, 0, cr0, cr0, cr7, {0}
    2228:	00020404 	andeq	r0, r2, r4, lsl #8
    222c:	14301100 	ldrtne	r1, [r0], #-256	; 0xffffff00
    2230:	01070000 	mrseq	r0, (UNDEF: 7)
    2234:	00000044 	andeq	r0, r0, r4, asr #32
    2238:	dd0c0609 	stcle	6, cr0, [ip, #-36]	; 0xffffffdc
    223c:	15000007 	strne	r0, [r0, #-7]
    2240:	00706f4e 	rsbseq	r6, r0, lr, asr #30
    2244:	0b351200 	bleq	d46a4c <__bss_end+0xd3d314>
    2248:	12010000 	andne	r0, r1, #0
    224c:	0000081a 	andeq	r0, r0, sl, lsl r8
    2250:	13e91202 	mvnne	r1, #536870912	; 0x20000000
    2254:	12030000 	andne	r0, r3, #0
    2258:	00001396 	muleq	r0, r6, r3
    225c:	af0f0004 	svcge	0x000f0004
    2260:	05000013 	streq	r0, [r0, #-19]	; 0xffffffed
    2264:	0e082209 	cdpeq	2, 0, cr2, cr8, cr9, {0}
    2268:	10000008 	andne	r0, r0, r8
    226c:	24090078 	strcs	r0, [r9], #-120	; 0xffffff88
    2270:	00005c0e 	andeq	r5, r0, lr, lsl #24
    2274:	79100000 	ldmdbvc	r0, {}	; <UNPREDICTABLE>
    2278:	0e250900 	vmuleq.f16	s0, s10, s0	; <UNPREDICTABLE>
    227c:	0000005c 	andeq	r0, r0, ip, asr r0
    2280:	65731002 	ldrbvs	r1, [r3, #-2]!
    2284:	26090074 			; <UNDEFINED> instruction: 0x26090074
    2288:	0000440d 	andeq	r4, r0, sp, lsl #8
    228c:	0f000400 	svceq	0x00000400
    2290:	000012c8 	andeq	r1, r0, r8, asr #5
    2294:	082a0901 	stmdaeq	sl!, {r0, r8, fp}
    2298:	00000829 	andeq	r0, r0, r9, lsr #16
    229c:	646d6310 	strbtvs	r6, [sp], #-784	; 0xfffffcf0
    22a0:	162c0900 	strtne	r0, [ip], -r0, lsl #18
    22a4:	000007ac 	andeq	r0, r0, ip, lsr #15
    22a8:	df0f0000 	svcle	0x000f0000
    22ac:	01000012 	tsteq	r0, r2, lsl r0
    22b0:	44083009 	strmi	r3, [r8], #-9
    22b4:	07000008 	streq	r0, [r0, -r8]
    22b8:	0000147d 	andeq	r1, r0, sp, ror r4
    22bc:	0e1c3209 	cdpeq	2, 1, cr3, cr12, cr9, {0}
    22c0:	00000008 	andeq	r0, r0, r8
    22c4:	14050f00 	strne	r0, [r5], #-3840	; 0xfffff100
    22c8:	09020000 	stmdbeq	r2, {}	; <UNPREDICTABLE>
    22cc:	086c0836 	stmdaeq	ip!, {r1, r2, r4, r5, fp}^
    22d0:	7d070000 	stcvc	0, cr0, [r7, #-0]
    22d4:	09000014 	stmdbeq	r0, {r2, r4}
    22d8:	080e1c38 	stmdaeq	lr, {r3, r4, r5, sl, fp, ip}
    22dc:	07000000 	streq	r0, [r0, -r0]
    22e0:	00001447 	andeq	r1, r0, r7, asr #8
    22e4:	440d3909 	strmi	r3, [sp], #-2313	; 0xfffff6f7
    22e8:	01000000 	mrseq	r0, (UNDEF: 0)
    22ec:	13750f00 	cmnne	r5, #0, 30
    22f0:	09080000 	stmdbeq	r8, {}	; <UNPREDICTABLE>
    22f4:	08a1083d 	stmiaeq	r1!, {r0, r2, r3, r4, r5, fp}
    22f8:	7d070000 	stcvc	0, cr0, [r7, #-0]
    22fc:	09000014 	stmdbeq	r0, {r2, r4}
    2300:	080e1c3f 	stmdaeq	lr, {r0, r1, r2, r3, r4, r5, sl, fp, ip}
    2304:	07000000 	streq	r0, [r0, -r0]
    2308:	00000eff 	strdeq	r0, [r0], -pc	; <UNPREDICTABLE>
    230c:	5c0e4009 	stcpl	0, cr4, [lr], {9}
    2310:	01000000 	mrseq	r0, (UNDEF: 0)
    2314:	00144107 	andseq	r4, r4, r7, lsl #2
    2318:	19420900 	stmdbne	r2, {r8, fp}^
    231c:	000007dd 	ldrdeq	r0, [r0], -sp
    2320:	c80f0003 	stmdagt	pc, {r0, r1}	; <UNPREDICTABLE>
    2324:	0b000013 	bleq	2378 <shift+0x2378>
    2328:	04084609 	streq	r4, [r8], #-1545	; 0xfffff9f7
    232c:	07000009 	streq	r0, [r0, -r9]
    2330:	0000147d 	andeq	r1, r0, sp, ror r4
    2334:	0e1c4809 	cdpeq	8, 1, cr4, cr12, cr9, {0}
    2338:	00000008 	andeq	r0, r0, r8
    233c:	00317810 	eorseq	r7, r1, r0, lsl r8
    2340:	5c0e4909 			; <UNDEFINED> instruction: 0x5c0e4909
    2344:	01000000 	mrseq	r0, (UNDEF: 0)
    2348:	00317910 	eorseq	r7, r1, r0, lsl r9
    234c:	5c124909 			; <UNDEFINED> instruction: 0x5c124909
    2350:	03000000 	movweq	r0, #0
    2354:	09007710 	stmdbeq	r0, {r4, r8, r9, sl, ip, sp, lr}
    2358:	005c0e4a 	subseq	r0, ip, sl, asr #28
    235c:	10050000 	andne	r0, r5, r0
    2360:	4a090068 	bmi	242508 <__bss_end+0x238dd0>
    2364:	00005c11 	andeq	r5, r0, r1, lsl ip
    2368:	6f070700 	svcvs	0x00070700
    236c:	09000013 	stmdbeq	r0, {r0, r1, r4}
    2370:	00440d4b 	subeq	r0, r4, fp, asr #26
    2374:	07090000 	streq	r0, [r9, -r0]
    2378:	00001441 	andeq	r1, r0, r1, asr #8
    237c:	440d4d09 	strmi	r4, [sp], #-3337	; 0xfffff2f7
    2380:	0a000000 	beq	2388 <shift+0x2388>
    2384:	61681f00 	cmnvs	r8, r0, lsl #30
    2388:	050a006c 	streq	r0, [sl, #-108]	; 0xffffff94
    238c:	0009be0b 	andeq	fp, r9, fp, lsl #28
    2390:	090b2000 	stmdbeq	fp, {sp}
    2394:	070a0000 	streq	r0, [sl, -r0]
    2398:	00008c19 	andeq	r8, r0, r9, lsl ip
    239c:	e6b28000 	ldrt	r8, [r2], r0
    23a0:	0aee200e 	beq	ffb8a3e0 <__bss_end+0xffb80ca8>
    23a4:	0a0a0000 	beq	2823ac <__bss_end+0x278c74>
    23a8:	0003da1a 	andeq	sp, r3, sl, lsl sl
    23ac:	00000000 	andeq	r0, r0, r0
    23b0:	05092020 	streq	r2, [r9, #-32]	; 0xffffffe0
    23b4:	0d0a0000 	stceq	0, cr0, [sl, #-0]
    23b8:	0003da1a 	andeq	sp, r3, sl, lsl sl
    23bc:	20000000 	andcs	r0, r0, r0
    23c0:	08a52120 	stmiaeq	r5!, {r5, r8, sp}
    23c4:	100a0000 	andne	r0, sl, r0
    23c8:	00008015 	andeq	r8, r0, r5, lsl r0
    23cc:	ea203600 	b	80fbd4 <__bss_end+0x80649c>
    23d0:	0a00000b 	beq	2404 <shift+0x2404>
    23d4:	03da1a42 	bicseq	r1, sl, #270336	; 0x42000
    23d8:	50000000 	andpl	r0, r0, r0
    23dc:	ad202021 	stcge	0, cr2, [r0, #-132]!	; 0xffffff7c
    23e0:	0a00000c 	beq	2418 <shift+0x2418>
    23e4:	03da1a71 	bicseq	r1, sl, #462848	; 0x71000
    23e8:	b2000000 	andlt	r0, r0, #0
    23ec:	61202000 			; <UNDEFINED> instruction: 0x61202000
    23f0:	0a000007 	beq	2414 <shift+0x2414>
    23f4:	03da1aa4 	bicseq	r1, sl, #164, 20	; 0xa4000
    23f8:	b4000000 	strlt	r0, [r0], #-0
    23fc:	01202000 			; <UNDEFINED> instruction: 0x01202000
    2400:	0a000009 	beq	242c <shift+0x242c>
    2404:	03da1ab3 	bicseq	r1, sl, #733184	; 0xb3000
    2408:	40000000 	andmi	r0, r0, r0
    240c:	bc202010 	stclt	0, cr2, [r0], #-64	; 0xffffffc0
    2410:	0a000009 	beq	243c <shift+0x243c>
    2414:	03da1abe 	bicseq	r1, sl, #778240	; 0xbe000
    2418:	50000000 	andpl	r0, r0, r0
    241c:	b3202020 			; <UNDEFINED> instruction: 0xb3202020
    2420:	0a000006 	beq	2440 <shift+0x2440>
    2424:	03da1abf 	bicseq	r1, sl, #782336	; 0xbf000
    2428:	40000000 	andmi	r0, r0, r0
    242c:	f3202080 	vhadd.u32	d2, d16, d0
    2430:	0a00000b 	beq	2464 <shift+0x2464>
    2434:	03da1ac0 	bicseq	r1, sl, #192, 20	; 0xc0000
    2438:	50000000 	andpl	r0, r0, r0
    243c:	22002080 	andcs	r2, r0, #128	; 0x80
    2440:	00000910 	andeq	r0, r0, r0, lsl r9
    2444:	00092022 	andeq	r2, r9, r2, lsr #32
    2448:	09302200 	ldmdbeq	r0!, {r9, sp}
    244c:	40220000 	eormi	r0, r2, r0
    2450:	22000009 	andcs	r0, r0, #9
    2454:	0000094d 	andeq	r0, r0, sp, asr #18
    2458:	00095d22 	andeq	r5, r9, r2, lsr #26
    245c:	096d2200 	stmdbeq	sp!, {r9, sp}^
    2460:	7d220000 	stcvc	0, cr0, [r2, #-0]
    2464:	22000009 	andcs	r0, r0, #9
    2468:	0000098d 	andeq	r0, r0, sp, lsl #19
    246c:	00099d22 	andeq	r9, r9, r2, lsr #26
    2470:	09ad2200 	stmibeq	sp!, {r9, sp}
    2474:	26230000 	strtcs	r0, [r3], -r0
    2478:	0b000014 	bleq	24d0 <shift+0x24d0>
    247c:	0c910b04 	vldmiaeq	r1, {d0-d1}
    2480:	1b210000 	blne	842488 <__bss_end+0x838d50>
    2484:	0b000014 	bleq	24dc <shift+0x24dc>
    2488:	00681807 	rsbeq	r1, r8, r7, lsl #16
    248c:	21060000 	mrscs	r0, (UNDEF: 6)
    2490:	00001471 	andeq	r1, r0, r1, ror r4
    2494:	6818090b 	ldmdavs	r8, {r0, r1, r3, r8, fp}
    2498:	08000000 	stmdaeq	r0, {}	; <UNPREDICTABLE>
    249c:	00148421 	andseq	r8, r4, r1, lsr #8
    24a0:	180c0b00 	stmdane	ip, {r8, r9, fp}
    24a4:	00000068 	andeq	r0, r0, r8, rrx
    24a8:	13e02120 	mvnne	r2, #32, 2
    24ac:	0e0b0000 	cdpeq	0, 0, cr0, cr11, cr0, {0}
    24b0:	00006818 	andeq	r6, r0, r8, lsl r8
    24b4:	fa218000 	blx	8624bc <__bss_end+0x858d84>
    24b8:	0b000013 	bleq	250c <shift+0x250c>
    24bc:	01e11411 	mvneq	r1, r1, lsl r4
    24c0:	24010000 	strcs	r0, [r1], #-0
    24c4:	0000135d 	andeq	r1, r0, sp, asr r3
    24c8:	bb13140b 	bllt	4c74fc <__bss_end+0x4bddc4>
    24cc:	4000000c 	andmi	r0, r0, ip
    24d0:	00000002 	andeq	r0, r0, r2
    24d4:	00000000 	andeq	r0, r0, r0
    24d8:	002f0000 	eoreq	r0, pc, r0
    24dc:	07000000 	streq	r0, [r0, -r0]
    24e0:	00000700 	andeq	r0, r0, r0, lsl #14
    24e4:	7f147f14 	svcvc	0x00147f14
    24e8:	2a240014 	bcs	902540 <__bss_end+0x8f8e08>
    24ec:	00122a7f 	andseq	r2, r2, pc, ror sl
    24f0:	64081323 	strvs	r1, [r8], #-803	; 0xfffffcdd
    24f4:	49360062 	ldmdbmi	r6!, {r1, r5, r6}
    24f8:	00502255 	subseq	r2, r0, r5, asr r2
    24fc:	00030500 	andeq	r0, r3, r0, lsl #10
    2500:	1c000000 	stcne	0, cr0, [r0], {-0}
    2504:	00004122 	andeq	r4, r0, r2, lsr #2
    2508:	1c224100 	stfnes	f4, [r2], #-0
    250c:	08140000 	ldmdaeq	r4, {}	; <UNPREDICTABLE>
    2510:	0014083e 	andseq	r0, r4, lr, lsr r8
    2514:	083e0808 	ldmdaeq	lr!, {r3, fp}
    2518:	00000008 	andeq	r0, r0, r8
    251c:	000060a0 	andeq	r6, r0, r0, lsr #1
    2520:	08080808 	stmdaeq	r8, {r3, fp}
    2524:	60000008 	andvs	r0, r0, r8
    2528:	00000060 	andeq	r0, r0, r0, rrx
    252c:	04081020 	streq	r1, [r8], #-32	; 0xffffffe0
    2530:	513e0002 	teqpl	lr, r2
    2534:	003e4549 	eorseq	r4, lr, r9, asr #10
    2538:	407f4200 	rsbsmi	r4, pc, r0, lsl #4
    253c:	61420000 	mrsvs	r0, (UNDEF: 66)
    2540:	00464951 	subeq	r4, r6, r1, asr r9
    2544:	4b454121 	blmi	11529d0 <__bss_end+0x1149298>
    2548:	14180031 	ldrne	r0, [r8], #-49	; 0xffffffcf
    254c:	00107f12 	andseq	r7, r0, r2, lsl pc
    2550:	45454527 	strbmi	r4, [r5, #-1319]	; 0xfffffad9
    2554:	4a3c0039 	bmi	f02640 <__bss_end+0xef8f08>
    2558:	00304949 	eorseq	r4, r0, r9, asr #18
    255c:	05097101 	streq	r7, [r9, #-257]	; 0xfffffeff
    2560:	49360003 	ldmdbmi	r6!, {r0, r1}
    2564:	00364949 	eorseq	r4, r6, r9, asr #18
    2568:	29494906 	stmdbcs	r9, {r1, r2, r8, fp, lr}^
    256c:	3600001e 			; <UNDEFINED> instruction: 0x3600001e
    2570:	00000036 	andeq	r0, r0, r6, lsr r0
    2574:	00365600 	eorseq	r5, r6, r0, lsl #12
    2578:	14080000 	strne	r0, [r8], #-0
    257c:	00004122 	andeq	r4, r0, r2, lsr #2
    2580:	14141414 	ldrne	r1, [r4], #-1044	; 0xfffffbec
    2584:	41000014 	tstmi	r0, r4, lsl r0
    2588:	00081422 	andeq	r1, r8, r2, lsr #8
    258c:	09510102 	ldmdbeq	r1, {r1, r8}^
    2590:	49320006 	ldmdbmi	r2!, {r1, r2}
    2594:	003e5159 	eorseq	r5, lr, r9, asr r1
    2598:	1211127c 	andsne	r1, r1, #124, 4	; 0xc0000007
    259c:	497f007c 	ldmdbmi	pc!, {r2, r3, r4, r5, r6}^	; <UNPREDICTABLE>
    25a0:	00364949 	eorseq	r4, r6, r9, asr #18
    25a4:	4141413e 	cmpmi	r1, lr, lsr r1
    25a8:	417f0022 	cmnmi	pc, r2, lsr #32
    25ac:	001c2241 	andseq	r2, ip, r1, asr #4
    25b0:	4949497f 	stmdbmi	r9, {r0, r1, r2, r3, r4, r5, r6, r8, fp, lr}^
    25b4:	097f0041 	ldmdbeq	pc!, {r0, r6}^	; <UNPREDICTABLE>
    25b8:	00010909 	andeq	r0, r1, r9, lsl #18
    25bc:	4949413e 	stmdbmi	r9, {r1, r2, r3, r4, r5, r8, lr}^
    25c0:	087f007a 	ldmdaeq	pc!, {r1, r3, r4, r5, r6}^	; <UNPREDICTABLE>
    25c4:	007f0808 	rsbseq	r0, pc, r8, lsl #16
    25c8:	417f4100 	cmnmi	pc, r0, lsl #2
    25cc:	40200000 	eormi	r0, r0, r0
    25d0:	00013f41 	andeq	r3, r1, r1, asr #30
    25d4:	2214087f 	andscs	r0, r4, #8323072	; 0x7f0000
    25d8:	407f0041 	rsbsmi	r0, pc, r1, asr #32
    25dc:	00404040 	subeq	r4, r0, r0, asr #32
    25e0:	020c027f 	andeq	r0, ip, #-268435449	; 0xf0000007
    25e4:	047f007f 	ldrbteq	r0, [pc], #-127	; 25ec <shift+0x25ec>
    25e8:	007f1008 	rsbseq	r1, pc, r8
    25ec:	4141413e 	cmpmi	r1, lr, lsr r1
    25f0:	097f003e 	ldmdbeq	pc!, {r1, r2, r3, r4, r5}^	; <UNPREDICTABLE>
    25f4:	00060909 	andeq	r0, r6, r9, lsl #18
    25f8:	2151413e 	cmpcs	r1, lr, lsr r1
    25fc:	097f005e 	ldmdbeq	pc!, {r1, r2, r3, r4, r6}^	; <UNPREDICTABLE>
    2600:	00462919 	subeq	r2, r6, r9, lsl r9
    2604:	49494946 	stmdbmi	r9, {r1, r2, r6, r8, fp, lr}^
    2608:	01010031 	tsteq	r1, r1, lsr r0
    260c:	0001017f 	andeq	r0, r1, pc, ror r1
    2610:	4040403f 	submi	r4, r0, pc, lsr r0
    2614:	201f003f 	andscs	r0, pc, pc, lsr r0	; <UNPREDICTABLE>
    2618:	001f2040 	andseq	r2, pc, r0, asr #32
    261c:	4038403f 	eorsmi	r4, r8, pc, lsr r0
    2620:	1463003f 	strbtne	r0, [r3], #-63	; 0xffffffc1
    2624:	00631408 	rsbeq	r1, r3, r8, lsl #8
    2628:	08700807 	ldmdaeq	r0!, {r0, r1, r2, fp}^
    262c:	51610007 	cmnpl	r1, r7
    2630:	00434549 	subeq	r4, r3, r9, asr #10
    2634:	41417f00 	cmpmi	r1, r0, lsl #30
    2638:	2a550000 	bcs	1542640 <__bss_end+0x1538f08>
    263c:	00552a55 	subseq	r2, r5, r5, asr sl
    2640:	7f414100 	svcvc	0x00414100
    2644:	02040000 	andeq	r0, r4, #0
    2648:	00040201 	andeq	r0, r4, r1, lsl #4
    264c:	40404040 	submi	r4, r0, r0, asr #32
    2650:	01000040 	tsteq	r0, r0, asr #32
    2654:	00000402 	andeq	r0, r0, r2, lsl #8
    2658:	54545420 	ldrbpl	r5, [r4], #-1056	; 0xfffffbe0
    265c:	487f0078 	ldmdami	pc!, {r3, r4, r5, r6}^	; <UNPREDICTABLE>
    2660:	00384444 	eorseq	r4, r8, r4, asr #8
    2664:	44444438 	strbmi	r4, [r4], #-1080	; 0xfffffbc8
    2668:	44380020 	ldrtmi	r0, [r8], #-32	; 0xffffffe0
    266c:	007f4844 	rsbseq	r4, pc, r4, asr #16
    2670:	54545438 	ldrbpl	r5, [r4], #-1080	; 0xfffffbc8
    2674:	7e080018 	mcrvc	0, 0, r0, cr8, cr8, {0}
    2678:	00020109 	andeq	r0, r2, r9, lsl #2
    267c:	a4a4a418 	strtge	sl, [r4], #1048	; 0x418
    2680:	087f007c 	ldmdaeq	pc!, {r2, r3, r4, r5, r6}^	; <UNPREDICTABLE>
    2684:	00780404 	rsbseq	r0, r8, r4, lsl #8
    2688:	407d4400 	rsbsmi	r4, sp, r0, lsl #8
    268c:	80400000 	subhi	r0, r0, r0
    2690:	00007d84 	andeq	r7, r0, r4, lsl #27
    2694:	4428107f 	strtmi	r1, [r8], #-127	; 0xffffff81
    2698:	41000000 	mrsmi	r0, (UNDEF: 0)
    269c:	0000407f 	andeq	r4, r0, pc, ror r0
    26a0:	0418047c 	ldreq	r0, [r8], #-1148	; 0xfffffb84
    26a4:	087c0078 	ldmdaeq	ip!, {r3, r4, r5, r6}^
    26a8:	00780404 	rsbseq	r0, r8, r4, lsl #8
    26ac:	44444438 	strbmi	r4, [r4], #-1080	; 0xfffffbc8
    26b0:	24fc0038 	ldrbtcs	r0, [ip], #56	; 0x38
    26b4:	00182424 	andseq	r2, r8, r4, lsr #8
    26b8:	18242418 	stmdane	r4!, {r3, r4, sl, sp}
    26bc:	087c00fc 	ldmdaeq	ip!, {r2, r3, r4, r5, r6, r7}^
    26c0:	00080404 	andeq	r0, r8, r4, lsl #8
    26c4:	54545448 	ldrbpl	r5, [r4], #-1096	; 0xfffffbb8
    26c8:	3f040020 	svccc	0x00040020
    26cc:	00204044 	eoreq	r4, r0, r4, asr #32
    26d0:	2040403c 	subcs	r4, r0, ip, lsr r0
    26d4:	201c007c 	andscs	r0, ip, ip, ror r0
    26d8:	001c2040 	andseq	r2, ip, r0, asr #32
    26dc:	4030403c 	eorsmi	r4, r0, ip, lsr r0
    26e0:	2844003c 	stmdacs	r4, {r2, r3, r4, r5}^
    26e4:	00442810 	subeq	r2, r4, r0, lsl r8
    26e8:	a0a0a01c 	adcge	sl, r0, ip, lsl r0
    26ec:	6444007c 	strbvs	r0, [r4], #-124	; 0xffffff84
    26f0:	00444c54 	subeq	r4, r4, r4, asr ip
    26f4:	00770800 	rsbseq	r0, r7, r0, lsl #16
    26f8:	00000000 	andeq	r0, r0, r0
    26fc:	0000007f 	andeq	r0, r0, pc, ror r0
    2700:	00087700 	andeq	r7, r8, r0, lsl #14
    2704:	08100000 	ldmdaeq	r0, {}	; <UNPREDICTABLE>
    2708:	00000810 	andeq	r0, r0, r0, lsl r8
    270c:	00000000 	andeq	r0, r0, r0
    2710:	01220000 			; <UNDEFINED> instruction: 0x01220000
    2714:	2200000a 	andcs	r0, r0, #10
    2718:	00000a0e 	andeq	r0, r0, lr, lsl #20
    271c:	000a1b22 	andeq	r1, sl, r2, lsr #22
    2720:	0a282200 	beq	a0af28 <__bss_end+0xa017f0>
    2724:	35220000 	strcc	r0, [r2, #-0]!
    2728:	1600000a 	strne	r0, [r0], -sl
    272c:	00000050 	andeq	r0, r0, r0, asr r0
    2730:	00000cbb 			; <UNDEFINED> instruction: 0x00000cbb
    2734:	00008525 	andeq	r8, r0, r5, lsr #10
    2738:	00023f00 	andeq	r3, r2, r0, lsl #30
    273c:	000caa03 	andeq	sl, ip, r3, lsl #20
    2740:	0a422200 	beq	108af48 <__bss_end+0x1081810>
    2744:	ae260000 	cdpge	0, 2, cr0, cr6, cr0, {0}
    2748:	01000001 	tsteq	r0, r1
    274c:	0cdf065d 	ldcleq	6, cr0, [pc], {93}	; 0x5d
    2750:	90500000 	subsls	r0, r0, r0
    2754:	00b00000 	adcseq	r0, r0, r0
    2758:	9c010000 	stcls	0, cr0, [r1], {-0}
    275c:	00000d32 	andeq	r0, r0, r2, lsr sp
    2760:	0012fd27 	andseq	pc, r2, r7, lsr #26
    2764:	0001ec00 	andeq	lr, r1, r0, lsl #24
    2768:	6c910200 	lfmvs	f0, 4, [r1], {0}
    276c:	01007828 	tsteq	r0, r8, lsr #16
    2770:	005c295d 	subseq	r2, ip, sp, asr r9
    2774:	91020000 	mrsls	r0, (UNDEF: 2)
    2778:	0079286a 	rsbseq	r2, r9, sl, ror #16
    277c:	5c355d01 	ldcpl	13, cr5, [r5], #-4
    2780:	02000000 	andeq	r0, r0, #0
    2784:	73286891 			; <UNDEFINED> instruction: 0x73286891
    2788:	01007274 	tsteq	r0, r4, ror r2
    278c:	01f1445d 	mvnseq	r4, sp, asr r4
    2790:	91020000 	mrsls	r0, (UNDEF: 2)
    2794:	69782964 	ldmdbvs	r8!, {r2, r5, r6, r8, fp, sp}^
    2798:	0e620100 	poweqs	f0, f2, f0
    279c:	0000005c 	andeq	r0, r0, ip, asr r0
    27a0:	29769102 	ldmdbcs	r6!, {r1, r8, ip, pc}^
    27a4:	00727470 	rsbseq	r7, r2, r0, ror r4
    27a8:	f1116301 			; <UNDEFINED> instruction: 0xf1116301
    27ac:	02000001 	andeq	r0, r0, #1
    27b0:	26007091 			; <UNDEFINED> instruction: 0x26007091
    27b4:	0000011f 	andeq	r0, r0, pc, lsl r1
    27b8:	4c065201 	sfmmi	f5, 4, [r6], {1}
    27bc:	f800000d 			; <UNDEFINED> instruction: 0xf800000d
    27c0:	5800008f 	stmdapl	r0, {r0, r1, r2, r3, r7}
    27c4:	01000000 	mrseq	r0, (UNDEF: 0)
    27c8:	000d689c 	muleq	sp, ip, r8
    27cc:	12fd2700 	rscsne	r2, sp, #0, 14
    27d0:	01ec0000 	mvneq	r0, r0
    27d4:	91020000 	mrsls	r0, (UNDEF: 2)
    27d8:	6b70296c 	blvs	1c0cd90 <__bss_end+0x1c03658>
    27dc:	57010074 	smlsdxpl	r1, r4, r0, r0
    27e0:	00082923 	andeq	r2, r8, r3, lsr #18
    27e4:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    27e8:	01842600 	orreq	r2, r4, r0, lsl #12
    27ec:	3a010000 	bcc	427f4 <__bss_end+0x390bc>
    27f0:	000d8206 	andeq	r8, sp, r6, lsl #4
    27f4:	008e9000 	addeq	r9, lr, r0
    27f8:	00016800 	andeq	r6, r1, r0, lsl #16
    27fc:	d49c0100 	ldrle	r0, [ip], #256	; 0x100
    2800:	2700000d 	strcs	r0, [r0, -sp]
    2804:	000012fd 	strdeq	r1, [r0], -sp
    2808:	000001ec 	andeq	r0, r0, ip, ror #3
    280c:	285c9102 	ldmdacs	ip, {r1, r8, ip, pc}^
    2810:	3a010078 	bcc	429f8 <__bss_end+0x392c0>
    2814:	00005c27 	andeq	r5, r0, r7, lsr #24
    2818:	5a910200 	bpl	fe443020 <__bss_end+0xfe4398e8>
    281c:	01007928 	tsteq	r0, r8, lsr #18
    2820:	005c333a 	subseq	r3, ip, sl, lsr r3
    2824:	91020000 	mrsls	r0, (UNDEF: 2)
    2828:	00632858 	rsbeq	r2, r3, r8, asr r8
    282c:	253b3a01 	ldrcs	r3, [fp, #-2561]!	; 0xfffff5ff
    2830:	02000000 	andeq	r0, r0, #0
    2834:	62295791 	eorvs	r5, r9, #38010880	; 0x2440000
    2838:	01006675 	tsteq	r0, r5, ror r6
    283c:	0dd40a43 	vldreq	s1, [r4, #268]	; 0x10c
    2840:	91020000 	mrsls	r0, (UNDEF: 2)
    2844:	74702960 	ldrbtvc	r2, [r0], #-2400	; 0xfffff6a0
    2848:	45010072 	strmi	r0, [r1, #-114]	; 0xffffff8e
    284c:	000de41e 	andeq	lr, sp, lr, lsl r4
    2850:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    2854:	00251600 	eoreq	r1, r5, r0, lsl #12
    2858:	0de40000 	stcleq	0, cr0, [r4]
    285c:	85170000 	ldrhi	r0, [r7, #-0]
    2860:	10000000 	andne	r0, r0, r0
    2864:	a1040d00 	tstge	r4, r0, lsl #26
    2868:	26000008 	strcs	r0, [r0], -r8
    286c:	0000015a 	andeq	r0, r0, sl, asr r1
    2870:	04062b01 	streq	r2, [r6], #-2817	; 0xfffff4ff
    2874:	a400000e 	strge	r0, [r0], #-14
    2878:	ec00008d 	stc	0, cr0, [r0], {141}	; 0x8d
    287c:	01000000 	mrseq	r0, (UNDEF: 0)
    2880:	000e499c 	muleq	lr, ip, r9
    2884:	12fd2700 	rscsne	r2, sp, #0, 14
    2888:	01ec0000 	mvneq	r0, r0
    288c:	91020000 	mrsls	r0, (UNDEF: 2)
    2890:	0078286c 	rsbseq	r2, r8, ip, ror #16
    2894:	5c282b01 			; <UNDEFINED> instruction: 0x5c282b01
    2898:	02000000 	andeq	r0, r0, #0
    289c:	79286a91 	stmdbvc	r8!, {r0, r4, r7, r9, fp, sp, lr}
    28a0:	342b0100 	strtcc	r0, [fp], #-256	; 0xffffff00
    28a4:	0000005c 	andeq	r0, r0, ip, asr r0
    28a8:	28689102 	stmdacs	r8!, {r1, r8, ip, pc}^
    28ac:	00746573 	rsbseq	r6, r4, r3, ror r5
    28b0:	da3c2b01 	ble	f0d4bc <__bss_end+0xf03d84>
    28b4:	02000001 	andeq	r0, r0, #1
    28b8:	70296791 	mlavc	r9, r1, r7, r6
    28bc:	0100746b 	tsteq	r0, fp, ror #8
    28c0:	086c2631 	stmdaeq	ip!, {r0, r4, r5, r9, sl, sp}^
    28c4:	91020000 	mrsls	r0, (UNDEF: 2)
    28c8:	3a260070 	bcc	982a90 <__bss_end+0x979358>
    28cc:	01000001 	tsteq	r0, r1
    28d0:	0e630620 	cdpeq	6, 6, cr0, cr3, cr0, {1}
    28d4:	8d280000 	stchi	0, cr0, [r8, #-0]
    28d8:	007c0000 	rsbseq	r0, ip, r0
    28dc:	9c010000 	stcls	0, cr0, [r1], {-0}
    28e0:	00000e8e 	andeq	r0, r0, lr, lsl #29
    28e4:	0012fd27 	andseq	pc, r2, r7, lsr #26
    28e8:	0001ec00 	andeq	lr, r1, r0, lsl #24
    28ec:	6c910200 	lfmvs	f0, 4, [r1], {0}
    28f0:	0014472a 	andseq	r4, r4, sl, lsr #14
    28f4:	20200100 	eorcs	r0, r0, r0, lsl #2
    28f8:	000001da 	ldrdeq	r0, [r0], -sl
    28fc:	296b9102 	stmdbcs	fp!, {r1, r8, ip, pc}^
    2900:	00746b70 	rsbseq	r6, r4, r0, ror fp
    2904:	441b2501 	ldrmi	r2, [fp], #-1281	; 0xfffffaff
    2908:	02000008 	andeq	r0, r0, #8
    290c:	2b007491 	blcs	1fb58 <__bss_end+0x16420>
    2910:	00000100 	andeq	r0, r0, r0, lsl #2
    2914:	a8061b01 	stmdage	r6, {r0, r8, r9, fp, ip}
    2918:	0000000e 	andeq	r0, r0, lr
    291c:	2800008d 	stmdacs	r0, {r0, r2, r3, r7}
    2920:	01000000 	mrseq	r0, (UNDEF: 0)
    2924:	000eb59c 	muleq	lr, ip, r5
    2928:	12fd2700 	rscsne	r2, sp, #0, 14
    292c:	01ff0000 	mvnseq	r0, r0
    2930:	91020000 	mrsls	r0, (UNDEF: 2)
    2934:	dc2c0074 	stcle	0, cr0, [ip], #-464	; 0xfffffe30
    2938:	01000000 	mrseq	r0, (UNDEF: 0)
    293c:	01f70111 	mvnseq	r0, r1, lsl r1
    2940:	0eca0000 	cdpeq	0, 12, cr0, cr10, cr0, {0}
    2944:	dd000000 	stcle	0, cr0, [r0, #-0]
    2948:	2d00000e 	stccs	0, cr0, [r0, #-56]	; 0xffffffc8
    294c:	000012fd 	strdeq	r1, [r0], -sp
    2950:	000001ec 	andeq	r0, r0, ip, ror #3
    2954:	0012be2d 	andseq	fp, r2, sp, lsr #28
    2958:	00003f00 	andeq	r3, r0, r0, lsl #30
    295c:	b52e0000 	strlt	r0, [lr, #-0]!
    2960:	8f00000e 	svchi	0x0000000e
    2964:	f8000014 			; <UNDEFINED> instruction: 0xf8000014
    2968:	b400000e 	strlt	r0, [r0], #-14
    296c:	4c00008c 	stcmi	0, cr0, [r0], {140}	; 0x8c
    2970:	01000000 	mrseq	r0, (UNDEF: 0)
    2974:	000f019c 	muleq	pc, ip, r1	; <UNPREDICTABLE>
    2978:	0eca2f00 	cdpeq	15, 12, cr2, cr10, cr0, {0}
    297c:	91020000 	mrsls	r0, (UNDEF: 2)
    2980:	b8300074 	ldmdalt	r0!, {r2, r4, r5, r6}
    2984:	01000000 	mrseq	r0, (UNDEF: 0)
    2988:	0f12010a 	svceq	0x0012010a
    298c:	28000000 	stmdacs	r0, {}	; <UNPREDICTABLE>
    2990:	2d00000f 	stccs	0, cr0, [r0, #-60]	; 0xffffffc4
    2994:	000012fd 	strdeq	r1, [r0], -sp
    2998:	000001ec 	andeq	r0, r0, ip, ror #3
    299c:	0013c331 	andseq	ip, r3, r1, lsr r3
    29a0:	2a0a0100 	bcs	282da8 <__bss_end+0x279670>
    29a4:	000001f1 	strdeq	r0, [r0], -r1
    29a8:	0f013200 	svceq	0x00013200
    29ac:	14500000 	ldrbne	r0, [r0], #-0
    29b0:	0f3f0000 	svceq	0x003f0000
    29b4:	8c4c0000 	marhi	acc0, r0, ip
    29b8:	00680000 	rsbeq	r0, r8, r0
    29bc:	9c010000 	stcls	0, cr0, [r1], {-0}
    29c0:	000f122f 	andeq	r1, pc, pc, lsr #4
    29c4:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    29c8:	000f1b2f 	andeq	r1, pc, pc, lsr #22
    29cc:	70910200 	addsvc	r0, r1, r0, lsl #4
	...

Disassembly of section .debug_abbrev:

00000000 <.debug_abbrev>:
   0:	10001101 	andne	r1, r0, r1, lsl #2
   4:	12011106 	andne	r1, r1, #-2147483647	; 0x80000001
   8:	1b0e0301 	blne	380c14 <__bss_end+0x3774dc>
   c:	130e250e 	movwne	r2, #58638	; 0xe50e
  10:	00000005 	andeq	r0, r0, r5
  14:	25011101 	strcs	r1, [r1, #-257]	; 0xfffffeff
  18:	030b130e 	movweq	r1, #45838	; 0xb30e
  1c:	110e1b0e 	tstne	lr, lr, lsl #22
  20:	10061201 	andne	r1, r6, r1, lsl #4
  24:	02000017 	andeq	r0, r0, #23
  28:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
  2c:	0b3b0b3a 	bleq	ec2d1c <__bss_end+0xeb95e4>
  30:	13490b39 	movtne	r0, #39737	; 0x9b39
  34:	193c193f 	ldmdbne	ip!, {r0, r1, r2, r3, r4, r5, r8, fp, ip}
  38:	24030000 	strcs	r0, [r3], #-0
  3c:	3e0b0b00 	vmlacc.f64	d0, d11, d0
  40:	000e030b 	andeq	r0, lr, fp, lsl #6
  44:	012e0400 			; <UNDEFINED> instruction: 0x012e0400
  48:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
  4c:	0b3b0b3a 	bleq	ec2d3c <__bss_end+0xeb9604>
  50:	01110b39 	tsteq	r1, r9, lsr fp
  54:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
  58:	01194296 			; <UNDEFINED> instruction: 0x01194296
  5c:	05000013 	streq	r0, [r0, #-19]	; 0xffffffed
  60:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
  64:	0b3b0b3a 	bleq	ec2d54 <__bss_end+0xeb961c>
  68:	13490b39 	movtne	r0, #39737	; 0x9b39
  6c:	00001802 	andeq	r1, r0, r2, lsl #16
  70:	0b002406 	bleq	9090 <_ZN13COLED_Display10Put_StringEttPKc+0x40>
  74:	030b3e0b 	movweq	r3, #48651	; 0xbe0b
  78:	07000008 	streq	r0, [r0, -r8]
  7c:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
  80:	0b3a0e03 	bleq	e83894 <__bss_end+0xe7a15c>
  84:	0b390b3b 	bleq	e42d78 <__bss_end+0xe39640>
  88:	06120111 			; <UNDEFINED> instruction: 0x06120111
  8c:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
  90:	00130119 	andseq	r0, r3, r9, lsl r1
  94:	010b0800 	tsteq	fp, r0, lsl #16
  98:	06120111 			; <UNDEFINED> instruction: 0x06120111
  9c:	34090000 	strcc	r0, [r9], #-0
  a0:	3a080300 	bcc	200ca8 <__bss_end+0x1f7570>
  a4:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
  a8:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
  ac:	0a000018 	beq	114 <shift+0x114>
  b0:	0b0b000f 	bleq	2c00f4 <__bss_end+0x2b69bc>
  b4:	00001349 	andeq	r1, r0, r9, asr #6
  b8:	01110100 	tsteq	r1, r0, lsl #2
  bc:	0b130e25 	bleq	4c3958 <__bss_end+0x4ba220>
  c0:	0e1b0e03 	cdpeq	14, 1, cr0, cr11, cr3, {0}
  c4:	06120111 			; <UNDEFINED> instruction: 0x06120111
  c8:	00001710 	andeq	r1, r0, r0, lsl r7
  cc:	03001602 	movweq	r1, #1538	; 0x602
  d0:	3b0b3a0e 	blcc	2ce910 <__bss_end+0x2c51d8>
  d4:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
  d8:	03000013 	movweq	r0, #19
  dc:	0b0b000f 	bleq	2c0120 <__bss_end+0x2b69e8>
  e0:	00001349 	andeq	r1, r0, r9, asr #6
  e4:	00001504 	andeq	r1, r0, r4, lsl #10
  e8:	01010500 	tsteq	r1, r0, lsl #10
  ec:	13011349 	movwne	r1, #4937	; 0x1349
  f0:	21060000 	mrscs	r0, (UNDEF: 6)
  f4:	2f134900 	svccs	0x00134900
  f8:	07000006 	streq	r0, [r0, -r6]
  fc:	0b0b0024 	bleq	2c0194 <__bss_end+0x2b6a5c>
 100:	0e030b3e 	vmoveq.16	d3[0], r0
 104:	34080000 	strcc	r0, [r8], #-0
 108:	3a0e0300 	bcc	380d10 <__bss_end+0x3775d8>
 10c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 110:	3f13490b 	svccc	0x0013490b
 114:	00193c19 	andseq	r3, r9, r9, lsl ip
 118:	012e0900 			; <UNDEFINED> instruction: 0x012e0900
 11c:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 120:	0b3b0b3a 	bleq	ec2e10 <__bss_end+0xeb96d8>
 124:	13490b39 	movtne	r0, #39737	; 0x9b39
 128:	06120111 			; <UNDEFINED> instruction: 0x06120111
 12c:	42961840 	addsmi	r1, r6, #64, 16	; 0x400000
 130:	00130119 	andseq	r0, r3, r9, lsl r1
 134:	00340a00 	eorseq	r0, r4, r0, lsl #20
 138:	0b3a0e03 	bleq	e8394c <__bss_end+0xe7a214>
 13c:	0b390b3b 	bleq	e42e30 <__bss_end+0xe396f8>
 140:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 144:	240b0000 	strcs	r0, [fp], #-0
 148:	3e0b0b00 	vmlacc.f64	d0, d11, d0
 14c:	0008030b 	andeq	r0, r8, fp, lsl #6
 150:	002e0c00 	eoreq	r0, lr, r0, lsl #24
 154:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 158:	0b3b0b3a 	bleq	ec2e48 <__bss_end+0xeb9710>
 15c:	01110b39 	tsteq	r1, r9, lsr fp
 160:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 164:	00194297 	mulseq	r9, r7, r2
 168:	01390d00 	teqeq	r9, r0, lsl #26
 16c:	0b3a0e03 	bleq	e83980 <__bss_end+0xe7a248>
 170:	13010b3b 	movwne	r0, #6971	; 0x1b3b
 174:	2e0e0000 	cdpcs	0, 0, cr0, cr14, cr0, {0}
 178:	03193f01 	tsteq	r9, #1, 30
 17c:	3b0b3a0e 	blcc	2ce9bc <__bss_end+0x2c5284>
 180:	3c0b390b 			; <UNDEFINED> instruction: 0x3c0b390b
 184:	00130119 	andseq	r0, r3, r9, lsl r1
 188:	00050f00 	andeq	r0, r5, r0, lsl #30
 18c:	00001349 	andeq	r1, r0, r9, asr #6
 190:	3f012e10 	svccc	0x00012e10
 194:	3a0e0319 	bcc	380e00 <__bss_end+0x3776c8>
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
 1c0:	3a080300 	bcc	200dc8 <__bss_end+0x1f7690>
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
 1f4:	0b0b0024 	bleq	2c028c <__bss_end+0x2b6b54>
 1f8:	0e030b3e 	vmoveq.16	d3[0], r0
 1fc:	26030000 	strcs	r0, [r3], -r0
 200:	00134900 	andseq	r4, r3, r0, lsl #18
 204:	00240400 	eoreq	r0, r4, r0, lsl #8
 208:	0b3e0b0b 	bleq	f82e3c <__bss_end+0xf79704>
 20c:	00000803 	andeq	r0, r0, r3, lsl #16
 210:	03001605 	movweq	r1, #1541	; 0x605
 214:	3b0b3a0e 	blcc	2cea54 <__bss_end+0x2c531c>
 218:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 21c:	06000013 			; <UNDEFINED> instruction: 0x06000013
 220:	0e030113 	mcreq	1, 0, r0, cr3, cr3, {0}
 224:	0b3a0b0b 	bleq	e82e58 <__bss_end+0xe79720>
 228:	0b390b3b 	bleq	e42f1c <__bss_end+0xe397e4>
 22c:	00001301 	andeq	r1, r0, r1, lsl #6
 230:	03000d07 	movweq	r0, #3335	; 0xd07
 234:	3b0b3a08 	blcc	2cea5c <__bss_end+0x2c5324>
 238:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 23c:	000b3813 	andeq	r3, fp, r3, lsl r8
 240:	01040800 	tsteq	r4, r0, lsl #16
 244:	196d0e03 	stmdbne	sp!, {r0, r1, r9, sl, fp}^
 248:	0b0b0b3e 	bleq	2c2f48 <__bss_end+0x2b9810>
 24c:	0b3a1349 	bleq	e84f78 <__bss_end+0xe7b840>
 250:	0b390b3b 	bleq	e42f44 <__bss_end+0xe3980c>
 254:	00001301 	andeq	r1, r0, r1, lsl #6
 258:	03002809 	movweq	r2, #2057	; 0x809
 25c:	000b1c0e 	andeq	r1, fp, lr, lsl #24
 260:	00340a00 	eorseq	r0, r4, r0, lsl #20
 264:	0b3a0e03 	bleq	e83a78 <__bss_end+0xe7a340>
 268:	0b390b3b 	bleq	e42f5c <__bss_end+0xe39824>
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
 294:	0b3b0b3a 	bleq	ec2f84 <__bss_end+0xeb984c>
 298:	13490b39 	movtne	r0, #39737	; 0x9b39
 29c:	00000b38 	andeq	r0, r0, r8, lsr fp
 2a0:	4901010f 	stmdbmi	r1, {r0, r1, r2, r3, r8}
 2a4:	00130113 	andseq	r0, r3, r3, lsl r1
 2a8:	00211000 	eoreq	r1, r1, r0
 2ac:	0b2f1349 	bleq	bc4fd8 <__bss_end+0xbbb8a0>
 2b0:	02110000 	andseq	r0, r1, #0
 2b4:	0b0e0301 	bleq	380ec0 <__bss_end+0x377788>
 2b8:	3b0b3a0b 	blcc	2ceaec <__bss_end+0x2c53b4>
 2bc:	010b390b 	tsteq	fp, fp, lsl #18
 2c0:	12000013 	andne	r0, r0, #19
 2c4:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 2c8:	0b3a0e03 	bleq	e83adc <__bss_end+0xe7a3a4>
 2cc:	0b390b3b 	bleq	e42fc0 <__bss_end+0xe39888>
 2d0:	193c0e6e 	ldmdbne	ip!, {r1, r2, r3, r5, r6, r9, sl, fp}
 2d4:	13011364 	movwne	r1, #4964	; 0x1364
 2d8:	05130000 	ldreq	r0, [r3, #-0]
 2dc:	34134900 	ldrcc	r4, [r3], #-2304	; 0xfffff700
 2e0:	14000019 	strne	r0, [r0], #-25	; 0xffffffe7
 2e4:	13490005 	movtne	r0, #36869	; 0x9005
 2e8:	2e150000 	cdpcs	0, 1, cr0, cr5, cr0, {0}
 2ec:	03193f01 	tsteq	r9, #1, 30
 2f0:	3b0b3a0e 	blcc	2ceb30 <__bss_end+0x2c53f8>
 2f4:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 2f8:	3c13490e 			; <UNDEFINED> instruction: 0x3c13490e
 2fc:	01136419 	tsteq	r3, r9, lsl r4
 300:	16000013 			; <UNDEFINED> instruction: 0x16000013
 304:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 308:	0b3a0e03 	bleq	e83b1c <__bss_end+0xe7a3e4>
 30c:	0b390b3b 	bleq	e43000 <__bss_end+0xe398c8>
 310:	13490e6e 	movtne	r0, #40558	; 0x9e6e
 314:	193c0b32 	ldmdbne	ip!, {r1, r4, r5, r8, r9, fp}
 318:	13011364 	movwne	r1, #4964	; 0x1364
 31c:	0d170000 	ldceq	0, cr0, [r7, #-0]
 320:	3a0e0300 	bcc	380f28 <__bss_end+0x3777f0>
 324:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 328:	3813490b 	ldmdacc	r3, {r0, r1, r3, r8, fp, lr}
 32c:	000b320b 	andeq	r3, fp, fp, lsl #4
 330:	012e1800 			; <UNDEFINED> instruction: 0x012e1800
 334:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 338:	0b3b0b3a 	bleq	ec3028 <__bss_end+0xeb98f0>
 33c:	0e6e0b39 	vmoveq.8	d14[5], r0
 340:	193c0b32 	ldmdbne	ip!, {r1, r4, r5, r8, r9, fp}
 344:	13011364 	movwne	r1, #4964	; 0x1364
 348:	2e190000 	cdpcs	0, 1, cr0, cr9, cr0, {0}
 34c:	03193f01 	tsteq	r9, #1, 30
 350:	3b0b3a0e 	blcc	2ceb90 <__bss_end+0x2c5458>
 354:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 358:	3213490e 	andscc	r4, r3, #229376	; 0x38000
 35c:	64193c0b 	ldrvs	r3, [r9], #-3083	; 0xfffff3f5
 360:	1a000013 	bne	3b4 <shift+0x3b4>
 364:	13490115 	movtne	r0, #37141	; 0x9115
 368:	13011364 	movwne	r1, #4964	; 0x1364
 36c:	1f1b0000 	svcne	0x001b0000
 370:	49131d00 	ldmdbmi	r3, {r8, sl, fp, ip}
 374:	1c000013 	stcne	0, cr0, [r0], {19}
 378:	0b0b0010 	bleq	2c03c0 <__bss_end+0x2b6c88>
 37c:	00001349 	andeq	r1, r0, r9, asr #6
 380:	0b000f1d 	bleq	3ffc <shift+0x3ffc>
 384:	1e00000b 	cdpne	0, 0, cr0, cr0, cr11, {0}
 388:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 38c:	0b3a0e03 	bleq	e83ba0 <__bss_end+0xe7a468>
 390:	0b390b3b 	bleq	e43084 <__bss_end+0xe3994c>
 394:	0b320e6e 	bleq	c83d54 <__bss_end+0xc7a61c>
 398:	1364193c 	cmnne	r4, #60, 18	; 0xf0000
 39c:	391f0000 	ldmdbcc	pc, {}	; <UNPREDICTABLE>
 3a0:	3a080301 	bcc	200fac <__bss_end+0x1f7874>
 3a4:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 3a8:	0013010b 	andseq	r0, r3, fp, lsl #2
 3ac:	00342000 	eorseq	r2, r4, r0
 3b0:	0b3a0e03 	bleq	e83bc4 <__bss_end+0xe7a48c>
 3b4:	0b390b3b 	bleq	e430a8 <__bss_end+0xe39970>
 3b8:	193c1349 	ldmdbne	ip!, {r0, r3, r6, r8, r9, ip}
 3bc:	196c061c 	stmdbne	ip!, {r2, r3, r4, r9, sl}^
 3c0:	34210000 	strtcc	r0, [r1], #-0
 3c4:	3a0e0300 	bcc	380fcc <__bss_end+0x377894>
 3c8:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 3cc:	3c13490b 			; <UNDEFINED> instruction: 0x3c13490b
 3d0:	6c0b1c19 	stcvs	12, cr1, [fp], {25}
 3d4:	22000019 	andcs	r0, r0, #25
 3d8:	13470034 	movtne	r0, #28724	; 0x7034
 3dc:	34230000 	strtcc	r0, [r3], #-0
 3e0:	3a0e0300 	bcc	380fe8 <__bss_end+0x3778b0>
 3e4:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 3e8:	3f13490b 	svccc	0x0013490b
 3ec:	00180219 	andseq	r0, r8, r9, lsl r2
 3f0:	012e2400 			; <UNDEFINED> instruction: 0x012e2400
 3f4:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 3f8:	0b3b0b3a 	bleq	ec30e8 <__bss_end+0xeb99b0>
 3fc:	13490b39 	movtne	r0, #39737	; 0x9b39
 400:	06120111 			; <UNDEFINED> instruction: 0x06120111
 404:	42961840 	addsmi	r1, r6, #64, 16	; 0x400000
 408:	00130119 	andseq	r0, r3, r9, lsl r1
 40c:	00052500 	andeq	r2, r5, r0, lsl #10
 410:	0b3a0e03 	bleq	e83c24 <__bss_end+0xe7a4ec>
 414:	0b390b3b 	bleq	e43108 <__bss_end+0xe399d0>
 418:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 41c:	34260000 	strtcc	r0, [r6], #-0
 420:	3a0e0300 	bcc	381028 <__bss_end+0x3778f0>
 424:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 428:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 42c:	27000018 	smladcs	r0, r8, r0, r0
 430:	08030034 	stmdaeq	r3, {r2, r4, r5}
 434:	0b3b0b3a 	bleq	ec3124 <__bss_end+0xeb99ec>
 438:	13490b39 	movtne	r0, #39737	; 0x9b39
 43c:	00001802 	andeq	r1, r0, r2, lsl #16
 440:	11010b28 	tstne	r1, r8, lsr #22
 444:	00061201 	andeq	r1, r6, r1, lsl #4
 448:	11010000 	mrsne	r0, (UNDEF: 1)
 44c:	130e2501 	movwne	r2, #58625	; 0xe501
 450:	1b0e030b 	blne	381084 <__bss_end+0x37794c>
 454:	1201110e 	andne	r1, r1, #-2147483645	; 0x80000003
 458:	00171006 	andseq	r1, r7, r6
 45c:	00240200 	eoreq	r0, r4, r0, lsl #4
 460:	0b3e0b0b 	bleq	f83094 <__bss_end+0xf7995c>
 464:	00000e03 	andeq	r0, r0, r3, lsl #28
 468:	49002603 	stmdbmi	r0, {r0, r1, r9, sl, sp}
 46c:	04000013 	streq	r0, [r0], #-19	; 0xffffffed
 470:	0b0b0024 	bleq	2c0508 <__bss_end+0x2b6dd0>
 474:	08030b3e 	stmdaeq	r3, {r1, r2, r3, r4, r5, r8, r9, fp}
 478:	16050000 	strne	r0, [r5], -r0
 47c:	3a0e0300 	bcc	381084 <__bss_end+0x37794c>
 480:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 484:	0013490b 	andseq	r4, r3, fp, lsl #18
 488:	01130600 	tsteq	r3, r0, lsl #12
 48c:	0b0b0e03 	bleq	2c3ca0 <__bss_end+0x2ba568>
 490:	0b3b0b3a 	bleq	ec3180 <__bss_end+0xeb9a48>
 494:	13010b39 	movwne	r0, #6969	; 0x1b39
 498:	0d070000 	stceq	0, cr0, [r7, #-0]
 49c:	3a080300 	bcc	2010a4 <__bss_end+0x1f796c>
 4a0:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 4a4:	3813490b 	ldmdacc	r3, {r0, r1, r3, r8, fp, lr}
 4a8:	0800000b 	stmdaeq	r0, {r0, r1, r3}
 4ac:	0e030104 	adfeqs	f0, f3, f4
 4b0:	0b3e196d 	bleq	f86a6c <__bss_end+0xf7d334>
 4b4:	13490b0b 	movtne	r0, #39691	; 0x9b0b
 4b8:	0b3b0b3a 	bleq	ec31a8 <__bss_end+0xeb9a70>
 4bc:	13010b39 	movwne	r0, #6969	; 0x1b39
 4c0:	28090000 	stmdacs	r9, {}	; <UNPREDICTABLE>
 4c4:	1c080300 	stcne	3, cr0, [r8], {-0}
 4c8:	0a00000b 	beq	4fc <shift+0x4fc>
 4cc:	0e030028 	cdpeq	0, 0, cr0, cr3, cr8, {1}
 4d0:	00000b1c 	andeq	r0, r0, ip, lsl fp
 4d4:	0300340b 	movweq	r3, #1035	; 0x40b
 4d8:	3b0b3a0e 	blcc	2ced18 <__bss_end+0x2c55e0>
 4dc:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 4e0:	02196c13 	andseq	r6, r9, #4864	; 0x1300
 4e4:	0c000018 	stceq	0, cr0, [r0], {24}
 4e8:	0e030002 	cdpeq	0, 0, cr0, cr3, cr2, {0}
 4ec:	0000193c 	andeq	r1, r0, ip, lsr r9
 4f0:	0b000f0d 	bleq	412c <shift+0x412c>
 4f4:	0013490b 	andseq	r4, r3, fp, lsl #18
 4f8:	000d0e00 	andeq	r0, sp, r0, lsl #28
 4fc:	0b3a0e03 	bleq	e83d10 <__bss_end+0xe7a5d8>
 500:	0b390b3b 	bleq	e431f4 <__bss_end+0xe39abc>
 504:	0b381349 	bleq	e05230 <__bss_end+0xdfbaf8>
 508:	010f0000 	mrseq	r0, CPSR
 50c:	01134901 	tsteq	r3, r1, lsl #18
 510:	10000013 	andne	r0, r0, r3, lsl r0
 514:	13490021 	movtne	r0, #36897	; 0x9021
 518:	00000b2f 	andeq	r0, r0, pc, lsr #22
 51c:	03010211 	movweq	r0, #4625	; 0x1211
 520:	3a0b0b0e 	bcc	2c3160 <__bss_end+0x2b9a28>
 524:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 528:	0013010b 	andseq	r0, r3, fp, lsl #2
 52c:	012e1200 			; <UNDEFINED> instruction: 0x012e1200
 530:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 534:	0b3b0b3a 	bleq	ec3224 <__bss_end+0xeb9aec>
 538:	0e6e0b39 	vmoveq.8	d14[5], r0
 53c:	1364193c 	cmnne	r4, #60, 18	; 0xf0000
 540:	00001301 	andeq	r1, r0, r1, lsl #6
 544:	49000513 	stmdbmi	r0, {r0, r1, r4, r8, sl}
 548:	00193413 	andseq	r3, r9, r3, lsl r4
 54c:	00051400 	andeq	r1, r5, r0, lsl #8
 550:	00001349 	andeq	r1, r0, r9, asr #6
 554:	3f012e15 	svccc	0x00012e15
 558:	3a0e0319 	bcc	3811c4 <__bss_end+0x377a8c>
 55c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 560:	490e6e0b 	stmdbmi	lr, {r0, r1, r3, r9, sl, fp, sp, lr}
 564:	64193c13 	ldrvs	r3, [r9], #-3091	; 0xfffff3ed
 568:	00130113 	andseq	r0, r3, r3, lsl r1
 56c:	012e1600 			; <UNDEFINED> instruction: 0x012e1600
 570:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 574:	0b3b0b3a 	bleq	ec3264 <__bss_end+0xeb9b2c>
 578:	0e6e0b39 	vmoveq.8	d14[5], r0
 57c:	0b321349 	bleq	c852a8 <__bss_end+0xc7bb70>
 580:	1364193c 	cmnne	r4, #60, 18	; 0xf0000
 584:	00001301 	andeq	r1, r0, r1, lsl #6
 588:	03000d17 	movweq	r0, #3351	; 0xd17
 58c:	3b0b3a0e 	blcc	2cedcc <__bss_end+0x2c5694>
 590:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 594:	320b3813 	andcc	r3, fp, #1245184	; 0x130000
 598:	1800000b 	stmdane	r0, {r0, r1, r3}
 59c:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 5a0:	0b3a0e03 	bleq	e83db4 <__bss_end+0xe7a67c>
 5a4:	0b390b3b 	bleq	e43298 <__bss_end+0xe39b60>
 5a8:	0b320e6e 	bleq	c83f68 <__bss_end+0xc7a830>
 5ac:	1364193c 	cmnne	r4, #60, 18	; 0xf0000
 5b0:	00001301 	andeq	r1, r0, r1, lsl #6
 5b4:	3f012e19 	svccc	0x00012e19
 5b8:	3a0e0319 	bcc	381224 <__bss_end+0x377aec>
 5bc:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 5c0:	490e6e0b 	stmdbmi	lr, {r0, r1, r3, r9, sl, fp, sp, lr}
 5c4:	3c0b3213 	sfmcc	f3, 4, [fp], {19}
 5c8:	00136419 	andseq	r6, r3, r9, lsl r4
 5cc:	01151a00 	tsteq	r5, r0, lsl #20
 5d0:	13641349 	cmnne	r4, #603979777	; 0x24000001
 5d4:	00001301 	andeq	r1, r0, r1, lsl #6
 5d8:	1d001f1b 	stcne	15, cr1, [r0, #-108]	; 0xffffff94
 5dc:	00134913 	andseq	r4, r3, r3, lsl r9
 5e0:	00101c00 	andseq	r1, r0, r0, lsl #24
 5e4:	13490b0b 	movtne	r0, #39691	; 0x9b0b
 5e8:	0f1d0000 	svceq	0x001d0000
 5ec:	000b0b00 	andeq	r0, fp, r0, lsl #22
 5f0:	00341e00 	eorseq	r1, r4, r0, lsl #28
 5f4:	0b3a0e03 	bleq	e83e08 <__bss_end+0xe7a6d0>
 5f8:	0b390b3b 	bleq	e432ec <__bss_end+0xe39bb4>
 5fc:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 600:	2e1f0000 	cdpcs	0, 1, cr0, cr15, cr0, {0}
 604:	03193f01 	tsteq	r9, #1, 30
 608:	3b0b3a0e 	blcc	2cee48 <__bss_end+0x2c5710>
 60c:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 610:	1113490e 	tstne	r3, lr, lsl #18
 614:	40061201 	andmi	r1, r6, r1, lsl #4
 618:	19429618 	stmdbne	r2, {r3, r4, r9, sl, ip, pc}^
 61c:	00001301 	andeq	r1, r0, r1, lsl #6
 620:	03000520 	movweq	r0, #1312	; 0x520
 624:	3b0b3a0e 	blcc	2cee64 <__bss_end+0x2c572c>
 628:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 62c:	00180213 	andseq	r0, r8, r3, lsl r2
 630:	012e2100 			; <UNDEFINED> instruction: 0x012e2100
 634:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 638:	0b3b0b3a 	bleq	ec3328 <__bss_end+0xeb9bf0>
 63c:	0e6e0b39 	vmoveq.8	d14[5], r0
 640:	01111349 	tsteq	r1, r9, asr #6
 644:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 648:	01194297 			; <UNDEFINED> instruction: 0x01194297
 64c:	22000013 	andcs	r0, r0, #19
 650:	08030034 	stmdaeq	r3, {r2, r4, r5}
 654:	0b3b0b3a 	bleq	ec3344 <__bss_end+0xeb9c0c>
 658:	13490b39 	movtne	r0, #39737	; 0x9b39
 65c:	00001802 	andeq	r1, r0, r2, lsl #16
 660:	3f012e23 	svccc	0x00012e23
 664:	3a0e0319 	bcc	3812d0 <__bss_end+0x377b98>
 668:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 66c:	110e6e0b 	tstne	lr, fp, lsl #28
 670:	40061201 	andmi	r1, r6, r1, lsl #4
 674:	19429718 	stmdbne	r2, {r3, r4, r8, r9, sl, ip, pc}^
 678:	00001301 	andeq	r1, r0, r1, lsl #6
 67c:	3f002e24 	svccc	0x00002e24
 680:	3a0e0319 	bcc	3812ec <__bss_end+0x377bb4>
 684:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 688:	110e6e0b 	tstne	lr, fp, lsl #28
 68c:	40061201 	andmi	r1, r6, r1, lsl #4
 690:	19429718 	stmdbne	r2, {r3, r4, r8, r9, sl, ip, pc}^
 694:	2e250000 	cdpcs	0, 2, cr0, cr5, cr0, {0}
 698:	03193f01 	tsteq	r9, #1, 30
 69c:	3b0b3a0e 	blcc	2ceedc <__bss_end+0x2c57a4>
 6a0:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 6a4:	1113490e 	tstne	r3, lr, lsl #18
 6a8:	40061201 	andmi	r1, r6, r1, lsl #4
 6ac:	19429718 	stmdbne	r2, {r3, r4, r8, r9, sl, ip, pc}^
 6b0:	01000000 	mrseq	r0, (UNDEF: 0)
 6b4:	0e250111 	mcreq	1, 1, r0, cr5, cr1, {0}
 6b8:	0e030b13 	vmoveq.32	d3[0], r0
 6bc:	01110e1b 	tsteq	r1, fp, lsl lr
 6c0:	17100612 			; <UNDEFINED> instruction: 0x17100612
 6c4:	39020000 	stmdbcc	r2, {}	; <UNPREDICTABLE>
 6c8:	00130101 	andseq	r0, r3, r1, lsl #2
 6cc:	00340300 	eorseq	r0, r4, r0, lsl #6
 6d0:	0b3a0e03 	bleq	e83ee4 <__bss_end+0xe7a7ac>
 6d4:	0b390b3b 	bleq	e433c8 <__bss_end+0xe39c90>
 6d8:	193c1349 	ldmdbne	ip!, {r0, r3, r6, r8, r9, ip}
 6dc:	00000a1c 	andeq	r0, r0, ip, lsl sl
 6e0:	3a003a04 	bcc	eef8 <__bss_end+0x57c0>
 6e4:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 6e8:	0013180b 	andseq	r1, r3, fp, lsl #16
 6ec:	01010500 	tsteq	r1, r0, lsl #10
 6f0:	13011349 	movwne	r1, #4937	; 0x1349
 6f4:	21060000 	mrscs	r0, (UNDEF: 6)
 6f8:	2f134900 	svccs	0x00134900
 6fc:	0700000b 	streq	r0, [r0, -fp]
 700:	13490026 	movtne	r0, #36902	; 0x9026
 704:	24080000 	strcs	r0, [r8], #-0
 708:	3e0b0b00 	vmlacc.f64	d0, d11, d0
 70c:	000e030b 	andeq	r0, lr, fp, lsl #6
 710:	00340900 	eorseq	r0, r4, r0, lsl #18
 714:	00001347 	andeq	r1, r0, r7, asr #6
 718:	3f012e0a 	svccc	0x00012e0a
 71c:	3a0e0319 	bcc	381388 <__bss_end+0x377c50>
 720:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 724:	110e6e0b 	tstne	lr, fp, lsl #28
 728:	40061201 	andmi	r1, r6, r1, lsl #4
 72c:	19429718 	stmdbne	r2, {r3, r4, r8, r9, sl, ip, pc}^
 730:	00001301 	andeq	r1, r0, r1, lsl #6
 734:	0300050b 	movweq	r0, #1291	; 0x50b
 738:	3b0b3a08 	blcc	2cef60 <__bss_end+0x2c5828>
 73c:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 740:	00180213 	andseq	r0, r8, r3, lsl r2
 744:	00340c00 	eorseq	r0, r4, r0, lsl #24
 748:	0b3a0e03 	bleq	e83f5c <__bss_end+0xe7a824>
 74c:	0b390b3b 	bleq	e43440 <__bss_end+0xe39d08>
 750:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 754:	0b0d0000 	bleq	34075c <__bss_end+0x337024>
 758:	12011101 	andne	r1, r1, #1073741824	; 0x40000000
 75c:	0e000006 	cdpeq	0, 0, cr0, cr0, cr6, {0}
 760:	08030034 	stmdaeq	r3, {r2, r4, r5}
 764:	0b3b0b3a 	bleq	ec3454 <__bss_end+0xeb9d1c>
 768:	13490b39 	movtne	r0, #39737	; 0x9b39
 76c:	00001802 	andeq	r1, r0, r2, lsl #16
 770:	0b000f0f 	bleq	43b4 <shift+0x43b4>
 774:	0013490b 	andseq	r4, r3, fp, lsl #18
 778:	00261000 	eoreq	r1, r6, r0
 77c:	0f110000 	svceq	0x00110000
 780:	000b0b00 	andeq	r0, fp, r0, lsl #22
 784:	00241200 	eoreq	r1, r4, r0, lsl #4
 788:	0b3e0b0b 	bleq	f833bc <__bss_end+0xf79c84>
 78c:	00000803 	andeq	r0, r0, r3, lsl #16
 790:	03000513 	movweq	r0, #1299	; 0x513
 794:	3b0b3a0e 	blcc	2cefd4 <__bss_end+0x2c589c>
 798:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 79c:	00180213 	andseq	r0, r8, r3, lsl r2
 7a0:	012e1400 			; <UNDEFINED> instruction: 0x012e1400
 7a4:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 7a8:	0b3b0b3a 	bleq	ec3498 <__bss_end+0xeb9d60>
 7ac:	0e6e0b39 	vmoveq.8	d14[5], r0
 7b0:	01111349 	tsteq	r1, r9, asr #6
 7b4:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 7b8:	01194297 			; <UNDEFINED> instruction: 0x01194297
 7bc:	15000013 	strne	r0, [r0, #-19]	; 0xffffffed
 7c0:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 7c4:	0b3a0e03 	bleq	e83fd8 <__bss_end+0xe7a8a0>
 7c8:	0b390b3b 	bleq	e434bc <__bss_end+0xe39d84>
 7cc:	01110e6e 	tsteq	r1, lr, ror #28
 7d0:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 7d4:	00194296 	mulseq	r9, r6, r2
 7d8:	11010000 	mrsne	r0, (UNDEF: 1)
 7dc:	130e2501 	movwne	r2, #58625	; 0xe501
 7e0:	1b0e030b 	blne	381414 <__bss_end+0x377cdc>
 7e4:	1201110e 	andne	r1, r1, #-2147483645	; 0x80000003
 7e8:	00171006 	andseq	r1, r7, r6
 7ec:	00240200 	eoreq	r0, r4, r0, lsl #4
 7f0:	0b3e0b0b 	bleq	f83424 <__bss_end+0xf79cec>
 7f4:	00000e03 	andeq	r0, r0, r3, lsl #28
 7f8:	49002603 	stmdbmi	r0, {r0, r1, r9, sl, sp}
 7fc:	04000013 	streq	r0, [r0], #-19	; 0xffffffed
 800:	0b0b0024 	bleq	2c0898 <__bss_end+0x2b7160>
 804:	08030b3e 	stmdaeq	r3, {r1, r2, r3, r4, r5, r8, r9, fp}
 808:	16050000 	strne	r0, [r5], -r0
 80c:	3a0e0300 	bcc	381414 <__bss_end+0x377cdc>
 810:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 814:	0013490b 	andseq	r4, r3, fp, lsl #18
 818:	01020600 	tsteq	r2, r0, lsl #12
 81c:	0b0b0e03 	bleq	2c4030 <__bss_end+0x2ba8f8>
 820:	0b3b0b3a 	bleq	ec3510 <__bss_end+0xeb9dd8>
 824:	13010b39 	movwne	r0, #6969	; 0x1b39
 828:	0d070000 	stceq	0, cr0, [r7, #-0]
 82c:	3a0e0300 	bcc	381434 <__bss_end+0x377cfc>
 830:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 834:	3813490b 	ldmdacc	r3, {r0, r1, r3, r8, fp, lr}
 838:	0800000b 	stmdaeq	r0, {r0, r1, r3}
 83c:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 840:	0b3a0e03 	bleq	e84054 <__bss_end+0xe7a91c>
 844:	0b390b3b 	bleq	e43538 <__bss_end+0xe39e00>
 848:	13490e6e 	movtne	r0, #40558	; 0x9e6e
 84c:	193c0b32 	ldmdbne	ip!, {r1, r4, r5, r8, r9, fp}
 850:	13011364 	movwne	r1, #4964	; 0x1364
 854:	05090000 	streq	r0, [r9, #-0]
 858:	34134900 	ldrcc	r4, [r3], #-2304	; 0xfffff700
 85c:	0a000019 	beq	8c8 <shift+0x8c8>
 860:	13490005 	movtne	r0, #36869	; 0x9005
 864:	2e0b0000 	cdpcs	0, 0, cr0, cr11, cr0, {0}
 868:	03193f01 	tsteq	r9, #1, 30
 86c:	3b0b3a0e 	blcc	2cf0ac <__bss_end+0x2c5974>
 870:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 874:	3c0b320e 	sfmcc	f3, 4, [fp], {14}
 878:	01136419 	tsteq	r3, r9, lsl r4
 87c:	0c000013 	stceq	0, cr0, [r0], {19}
 880:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 884:	0b3a0e03 	bleq	e84098 <__bss_end+0xe7a960>
 888:	0b390b3b 	bleq	e4357c <__bss_end+0xe39e44>
 88c:	0b320e6e 	bleq	c8424c <__bss_end+0xc7ab14>
 890:	1364193c 	cmnne	r4, #60, 18	; 0xf0000
 894:	0f0d0000 	svceq	0x000d0000
 898:	490b0b00 	stmdbmi	fp, {r8, r9, fp}
 89c:	0e000013 	mcreq	0, 0, r0, cr0, cr3, {0}
 8a0:	0b0b000f 	bleq	2c08e4 <__bss_end+0x2b71ac>
 8a4:	130f0000 	movwne	r0, #61440	; 0xf000
 8a8:	0b0e0301 	bleq	3814b4 <__bss_end+0x377d7c>
 8ac:	3b0b3a0b 	blcc	2cf0e0 <__bss_end+0x2c59a8>
 8b0:	010b390b 	tsteq	fp, fp, lsl #18
 8b4:	10000013 	andne	r0, r0, r3, lsl r0
 8b8:	0803000d 	stmdaeq	r3, {r0, r2, r3}
 8bc:	0b3b0b3a 	bleq	ec35ac <__bss_end+0xeb9e74>
 8c0:	13490b39 	movtne	r0, #39737	; 0x9b39
 8c4:	00000b38 	andeq	r0, r0, r8, lsr fp
 8c8:	03010411 	movweq	r0, #5137	; 0x1411
 8cc:	3e196d0e 	cdpcc	13, 1, cr6, cr9, cr14, {0}
 8d0:	490b0b0b 	stmdbmi	fp, {r0, r1, r3, r8, r9, fp}
 8d4:	3b0b3a13 	blcc	2cf128 <__bss_end+0x2c59f0>
 8d8:	010b390b 	tsteq	fp, fp, lsl #18
 8dc:	12000013 	andne	r0, r0, #19
 8e0:	0e030028 	cdpeq	0, 0, cr0, cr3, cr8, {1}
 8e4:	00000b1c 	andeq	r0, r0, ip, lsl fp
 8e8:	03003413 	movweq	r3, #1043	; 0x413
 8ec:	3b0b3a0e 	blcc	2cf12c <__bss_end+0x2c59f4>
 8f0:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 8f4:	02196c13 	andseq	r6, r9, #4864	; 0x1300
 8f8:	14000018 	strne	r0, [r0], #-24	; 0xffffffe8
 8fc:	0e030002 	cdpeq	0, 0, cr0, cr3, cr2, {0}
 900:	0000193c 	andeq	r1, r0, ip, lsr r9
 904:	03002815 	movweq	r2, #2069	; 0x815
 908:	000b1c08 	andeq	r1, fp, r8, lsl #24
 90c:	01011600 	tsteq	r1, r0, lsl #12
 910:	13011349 	movwne	r1, #4937	; 0x1349
 914:	21170000 	tstcs	r7, r0
 918:	2f134900 	svccs	0x00134900
 91c:	1800000b 	stmdane	r0, {r0, r1, r3}
 920:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 924:	0b3a0e03 	bleq	e84138 <__bss_end+0xe7aa00>
 928:	0b390b3b 	bleq	e4361c <__bss_end+0xe39ee4>
 92c:	193c0e6e 	ldmdbne	ip!, {r1, r2, r3, r5, r6, r9, sl, fp}
 930:	13011364 	movwne	r1, #4964	; 0x1364
 934:	2e190000 	cdpcs	0, 1, cr0, cr9, cr0, {0}
 938:	03193f01 	tsteq	r9, #1, 30
 93c:	3b0b3a0e 	blcc	2cf17c <__bss_end+0x2c5a44>
 940:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 944:	3c13490e 			; <UNDEFINED> instruction: 0x3c13490e
 948:	01136419 	tsteq	r3, r9, lsl r4
 94c:	1a000013 	bne	9a0 <shift+0x9a0>
 950:	0e03000d 	cdpeq	0, 0, cr0, cr3, cr13, {0}
 954:	0b3b0b3a 	bleq	ec3644 <__bss_end+0xeb9f0c>
 958:	13490b39 	movtne	r0, #39737	; 0x9b39
 95c:	0b320b38 	bleq	c83644 <__bss_end+0xc79f0c>
 960:	2e1b0000 	cdpcs	0, 1, cr0, cr11, cr0, {0}
 964:	03193f01 	tsteq	r9, #1, 30
 968:	3b0b3a0e 	blcc	2cf1a8 <__bss_end+0x2c5a70>
 96c:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 970:	3213490e 	andscc	r4, r3, #229376	; 0x38000
 974:	64193c0b 	ldrvs	r3, [r9], #-3083	; 0xfffff3f5
 978:	1c000013 	stcne	0, cr0, [r0], {19}
 97c:	13490115 	movtne	r0, #37141	; 0x9115
 980:	13011364 	movwne	r1, #4964	; 0x1364
 984:	1f1d0000 	svcne	0x001d0000
 988:	49131d00 	ldmdbmi	r3, {r8, sl, fp, ip}
 98c:	1e000013 	mcrne	0, 0, r0, cr0, cr3, {0}
 990:	0b0b0010 	bleq	2c09d8 <__bss_end+0x2b72a0>
 994:	00001349 	andeq	r1, r0, r9, asr #6
 998:	0301391f 	movweq	r3, #6431	; 0x191f
 99c:	3b0b3a08 	blcc	2cf1c4 <__bss_end+0x2c5a8c>
 9a0:	010b390b 	tsteq	fp, fp, lsl #18
 9a4:	20000013 	andcs	r0, r0, r3, lsl r0
 9a8:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 9ac:	0b3b0b3a 	bleq	ec369c <__bss_end+0xeb9f64>
 9b0:	13490b39 	movtne	r0, #39737	; 0x9b39
 9b4:	061c193c 			; <UNDEFINED> instruction: 0x061c193c
 9b8:	0000196c 	andeq	r1, r0, ip, ror #18
 9bc:	03003421 	movweq	r3, #1057	; 0x421
 9c0:	3b0b3a0e 	blcc	2cf200 <__bss_end+0x2c5ac8>
 9c4:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 9c8:	1c193c13 	ldcne	12, cr3, [r9], {19}
 9cc:	00196c0b 	andseq	r6, r9, fp, lsl #24
 9d0:	00342200 	eorseq	r2, r4, r0, lsl #4
 9d4:	00001347 	andeq	r1, r0, r7, asr #6
 9d8:	03013923 	movweq	r3, #6435	; 0x1923
 9dc:	3b0b3a0e 	blcc	2cf21c <__bss_end+0x2c5ae4>
 9e0:	010b390b 	tsteq	fp, fp, lsl #18
 9e4:	24000013 	strcs	r0, [r0], #-19	; 0xffffffed
 9e8:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 9ec:	0b3b0b3a 	bleq	ec36dc <__bss_end+0xeb9fa4>
 9f0:	13490b39 	movtne	r0, #39737	; 0x9b39
 9f4:	031c193c 	tsteq	ip, #60, 18	; 0xf0000
 9f8:	21250000 			; <UNDEFINED> instruction: 0x21250000
 9fc:	2f134900 	svccs	0x00134900
 a00:	26000005 	strcs	r0, [r0], -r5
 a04:	1347012e 	movtne	r0, #28974	; 0x712e
 a08:	0b3b0b3a 	bleq	ec36f8 <__bss_end+0xeb9fc0>
 a0c:	13640b39 	cmnne	r4, #58368	; 0xe400
 a10:	06120111 			; <UNDEFINED> instruction: 0x06120111
 a14:	42961840 	addsmi	r1, r6, #64, 16	; 0x400000
 a18:	00130119 	andseq	r0, r3, r9, lsl r1
 a1c:	00052700 	andeq	r2, r5, r0, lsl #14
 a20:	13490e03 	movtne	r0, #40451	; 0x9e03
 a24:	18021934 	stmdane	r2, {r2, r4, r5, r8, fp, ip}
 a28:	05280000 	streq	r0, [r8, #-0]!
 a2c:	3a080300 	bcc	201634 <__bss_end+0x1f7efc>
 a30:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 a34:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 a38:	29000018 	stmdbcs	r0, {r3, r4}
 a3c:	08030034 	stmdaeq	r3, {r2, r4, r5}
 a40:	0b3b0b3a 	bleq	ec3730 <__bss_end+0xeb9ff8>
 a44:	13490b39 	movtne	r0, #39737	; 0x9b39
 a48:	00001802 	andeq	r1, r0, r2, lsl #16
 a4c:	0300052a 	movweq	r0, #1322	; 0x52a
 a50:	3b0b3a0e 	blcc	2cf290 <__bss_end+0x2c5b58>
 a54:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 a58:	00180213 	andseq	r0, r8, r3, lsl r2
 a5c:	012e2b00 			; <UNDEFINED> instruction: 0x012e2b00
 a60:	0b3a1347 	bleq	e85784 <__bss_end+0xe7c04c>
 a64:	0b390b3b 	bleq	e43758 <__bss_end+0xe3a020>
 a68:	01111364 	tsteq	r1, r4, ror #6
 a6c:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 a70:	01194297 			; <UNDEFINED> instruction: 0x01194297
 a74:	2c000013 	stccs	0, cr0, [r0], {19}
 a78:	1347012e 	movtne	r0, #28974	; 0x712e
 a7c:	0b3b0b3a 	bleq	ec376c <__bss_end+0xeba034>
 a80:	13490b39 	movtne	r0, #39737	; 0x9b39
 a84:	0b201364 	bleq	80581c <__bss_end+0x7fc0e4>
 a88:	00001301 	andeq	r1, r0, r1, lsl #6
 a8c:	0300052d 	movweq	r0, #1325	; 0x52d
 a90:	3413490e 	ldrcc	r4, [r3], #-2318	; 0xfffff6f2
 a94:	2e000019 	mcrcs	0, 0, r0, cr0, cr9, {0}
 a98:	1331012e 	teqne	r1, #-2147483637	; 0x8000000b
 a9c:	13640e6e 	cmnne	r4, #1760	; 0x6e0
 aa0:	06120111 			; <UNDEFINED> instruction: 0x06120111
 aa4:	42961840 	addsmi	r1, r6, #64, 16	; 0x400000
 aa8:	00130119 	andseq	r0, r3, r9, lsl r1
 aac:	00052f00 	andeq	r2, r5, r0, lsl #30
 ab0:	18021331 	stmdane	r2, {r0, r4, r5, r8, r9, ip}
 ab4:	2e300000 	cdpcs	0, 3, cr0, cr0, cr0, {0}
 ab8:	3a134701 	bcc	4d26c4 <__bss_end+0x4c8f8c>
 abc:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 ac0:	2013640b 	andscs	r6, r3, fp, lsl #8
 ac4:	0013010b 	andseq	r0, r3, fp, lsl #2
 ac8:	00053100 	andeq	r3, r5, r0, lsl #2
 acc:	0b3a0e03 	bleq	e842e0 <__bss_end+0xe7aba8>
 ad0:	0b390b3b 	bleq	e437c4 <__bss_end+0xe3a08c>
 ad4:	00001349 	andeq	r1, r0, r9, asr #6
 ad8:	31012e32 	tstcc	r1, r2, lsr lr
 adc:	640e6e13 	strvs	r6, [lr], #-3603	; 0xfffff1ed
 ae0:	12011113 	andne	r1, r1, #-1073741820	; 0xc0000004
 ae4:	96184006 	ldrls	r4, [r8], -r6
 ae8:	00001942 	andeq	r1, r0, r2, asr #18
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
  74:	0000010c 	andeq	r0, r0, ip, lsl #2
	...
  80:	0000001c 	andeq	r0, r0, ip, lsl r0
  84:	0c2c0002 	stceq	0, cr0, [ip], #-8
  88:	00040000 	andeq	r0, r4, r0
  8c:	00000000 	andeq	r0, r0, r0
  90:	00008338 	andeq	r8, r0, r8, lsr r3
  94:	0000045c 	andeq	r0, r0, ip, asr r4
	...
  a0:	0000001c 	andeq	r0, r0, ip, lsl r0
  a4:	174f0002 	strbne	r0, [pc, -r2]
  a8:	00040000 	andeq	r0, r4, r0
  ac:	00000000 	andeq	r0, r0, r0
  b0:	00008794 	muleq	r0, r4, r7
  b4:	000004b8 			; <UNDEFINED> instruction: 0x000004b8
	...
  c0:	0000001c 	andeq	r0, r0, ip, lsl r0
  c4:	1a810002 	bne	fe0400d4 <__bss_end+0xfe03699c>
  c8:	00040000 	andeq	r0, r4, r0
  cc:	00000000 	andeq	r0, r0, r0
  d0:	00008c4c 	andeq	r8, r0, ip, asr #24
  d4:	000004b4 			; <UNDEFINED> instruction: 0x000004b4
	...

Disassembly of section .debug_str:

00000000 <.debug_str>:
       0:	6573552f 	ldrbvs	r5, [r3, #-1327]!	; 0xfffffad1
       4:	772f7372 			; <UNDEFINED> instruction: 0x772f7372
       8:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
       c:	2f696a72 	svccs	0x00696a72
      10:	6b736544 	blvs	1cd9528 <__bss_end+0x1ccfdf0>
      14:	2f706f74 	svccs	0x00706f74
      18:	2f564146 	svccs	0x00564146
      1c:	6176614e 	cmnvs	r6, lr, asr #2
      20:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
      24:	4f2f6963 	svcmi	0x002f6963
      28:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
      2c:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
      30:	6b6c6172 	blvs	1b18600 <__bss_end+0x1b0eec8>
      34:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
      38:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
      3c:	756f732f 	strbvc	r7, [pc, #-815]!	; fffffd15 <__bss_end+0xffff65dd>
      40:	73656372 	cmnvc	r5, #-939524095	; 0xc8000001
      44:	6573752f 	ldrbvs	r7, [r3, #-1327]!	; 0xfffffad1
      48:	61707372 	cmnvs	r0, r2, ror r3
      4c:	632f6563 			; <UNDEFINED> instruction: 0x632f6563
      50:	2e307472 	mrccs	4, 1, r7, cr0, cr2, {3}
      54:	552f0073 	strpl	r0, [pc, #-115]!	; ffffffe9 <__bss_end+0xffff68b1>
      58:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
      5c:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
      60:	6a726574 	bvs	1c99638 <__bss_end+0x1c8ff00>
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
      98:	752f7365 	strvc	r7, [pc, #-869]!	; fffffd3b <__bss_end+0xffff6603>
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
     12c:	6a363731 	bvs	d8ddf8 <__bss_end+0xd846c0>
     130:	732d667a 			; <UNDEFINED> instruction: 0x732d667a
     134:	616d2d20 	cmnvs	sp, r0, lsr #26
     138:	2d206d72 	stccs	13, cr6, [r0, #-456]!	; 0xfffffe38
     13c:	6372616d 	cmnvs	r2, #1073741851	; 0x4000001b
     140:	72613d68 	rsbvc	r3, r1, #104, 26	; 0x1a00
     144:	7a36766d 	bvc	d9db00 <__bss_end+0xd943c8>
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
     184:	6a757a61 	bvs	1d5eb10 <__bss_end+0x1d553d8>
     188:	2f696369 	svccs	0x00696369
     18c:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
     190:	73656d65 	cmnvc	r5, #6464	; 0x1940
     194:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
     198:	6b2d616b 	blvs	b5874c <__bss_end+0xb4f014>
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
     1e4:	2b2b4320 	blcs	ad0e6c <__bss_end+0xac7734>
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
     260:	2b6b7a36 	blcs	1adeb40 <__bss_end+0x1ad5408>
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
     294:	755f6962 	ldrbvc	r6, [pc, #-2402]	; fffff93a <__bss_end+0xffff6202>
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
     324:	6b736544 	blvs	1cd983c <__bss_end+0x1cd0104>
     328:	2f706f74 	svccs	0x00706f74
     32c:	2f564146 	svccs	0x00564146
     330:	6176614e 	cmnvs	r6, lr, asr #2
     334:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
     338:	4f2f6963 	svcmi	0x002f6963
     33c:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
     340:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
     344:	6b6c6172 	blvs	1b18914 <__bss_end+0x1b0f1dc>
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
     4c8:	4900656c 	stmdbmi	r0, {r2, r3, r5, r6, r8, sl, sp, lr}
     4cc:	6c61766e 	stclvs	6, cr7, [r1], #-440	; 0xfffffe48
     4d0:	485f6469 	ldmdami	pc, {r0, r3, r5, r6, sl, sp, lr}^	; <UNPREDICTABLE>
     4d4:	6c646e61 	stclvs	14, cr6, [r4], #-388	; 0xfffffe7c
     4d8:	75520065 	ldrbvc	r0, [r2, #-101]	; 0xffffff9b
     4dc:	6e696e6e 	cdpvs	14, 6, cr6, cr9, cr14, {3}
     4e0:	65440067 	strbvs	r0, [r4, #-103]	; 0xffffff99
     4e4:	696c6461 	stmdbvs	ip!, {r0, r5, r6, sl, sp, lr}^
     4e8:	555f656e 	ldrbpl	r6, [pc, #-1390]	; ffffff82 <__bss_end+0xffff684a>
     4ec:	6168636e 	cmnvs	r8, lr, ror #6
     4f0:	6465676e 	strbtvs	r6, [r5], #-1902	; 0xfffff892
     4f4:	74654700 	strbtvc	r4, [r5], #-1792	; 0xfffff900
     4f8:	7275435f 	rsbsvc	r4, r5, #2080374785	; 0x7c000001
     4fc:	746e6572 	strbtvc	r6, [lr], #-1394	; 0xfffffa8e
     500:	6f72505f 	svcvs	0x0072505f
     504:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     508:	49504700 	ldmdbmi	r0, {r8, r9, sl, lr}^
     50c:	61425f4f 	cmpvs	r2, pc, asr #30
     510:	5f006573 	svcpl	0x00006573
     514:	36314e5a 			; <UNDEFINED> instruction: 0x36314e5a
     518:	6f725043 	svcvs	0x00725043
     51c:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     520:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     524:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     528:	72433431 	subvc	r3, r3, #822083584	; 0x31000000
     52c:	65746165 	ldrbvs	r6, [r4, #-357]!	; 0xfffffe9b
     530:	6f72505f 	svcvs	0x0072505f
     534:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     538:	6a685045 	bvs	1a14654 <__bss_end+0x1a0af1c>
     53c:	72700062 	rsbsvc	r0, r0, #98	; 0x62
     540:	5f007665 	svcpl	0x00007665
     544:	33314e5a 	teqcc	r1, #1440	; 0x5a0
     548:	454c4f43 	strbmi	r4, [ip, #-3907]	; 0xfffff0bd
     54c:	69445f44 	stmdbvs	r4, {r2, r6, r8, r9, sl, fp, ip, lr}^
     550:	616c7073 	smcvs	50947	; 0xc703
     554:	75503879 	ldrbvc	r3, [r0, #-2169]	; 0xfffff787
     558:	68435f74 	stmdavs	r3, {r2, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     55c:	74457261 	strbvc	r7, [r5], #-609	; 0xfffffd9f
     560:	5f006374 	svcpl	0x00006374
     564:	314b4e5a 	cmpcc	fp, sl, asr lr
     568:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     56c:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     570:	614d5f73 	hvcvs	54771	; 0xd5f3
     574:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     578:	47393172 			; <UNDEFINED> instruction: 0x47393172
     57c:	435f7465 	cmpmi	pc, #1694498816	; 0x65000000
     580:	65727275 	ldrbvs	r7, [r2, #-629]!	; 0xfffffd8b
     584:	505f746e 	subspl	r7, pc, lr, ror #8
     588:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     58c:	76457373 			; <UNDEFINED> instruction: 0x76457373
     590:	61655200 	cmnvs	r5, r0, lsl #4
     594:	6e4f5f64 	cdpvs	15, 4, cr5, cr15, cr4, {3}
     598:	4d00796c 	vstrmi.16	s14, [r0, #-216]	; 0xffffff28	; <UNPREDICTABLE>
     59c:	505f7861 	subspl	r7, pc, r1, ror #16
     5a0:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     5a4:	4f5f7373 	svcmi	0x005f7373
     5a8:	656e6570 	strbvs	r6, [lr, #-1392]!	; 0xfffffa90
     5ac:	69465f64 	stmdbvs	r6, {r2, r5, r6, r8, r9, sl, fp, ip, lr}^
     5b0:	0073656c 	rsbseq	r6, r3, ip, ror #10
     5b4:	55504354 	ldrbpl	r4, [r0, #-852]	; 0xfffffcac
     5b8:	6e6f435f 	mcrvs	3, 3, r4, cr15, cr15, {2}
     5bc:	74786574 	ldrbtvc	r6, [r8], #-1396	; 0xfffffa8c
     5c0:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     5c4:	50433631 	subpl	r3, r3, r1, lsr r6
     5c8:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     5cc:	4d5f7373 	ldclmi	3, cr7, [pc, #-460]	; 408 <shift+0x408>
     5d0:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
     5d4:	53387265 	teqpl	r8, #1342177286	; 0x50000006
     5d8:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     5dc:	45656c75 	strbmi	r6, [r5, #-3189]!	; 0xfffff38b
     5e0:	5a5f0076 	bpl	17c07c0 <__bss_end+0x17b7088>
     5e4:	4333314e 	teqmi	r3, #-2147483629	; 0x80000013
     5e8:	44454c4f 	strbmi	r4, [r5], #-3151	; 0xfffff3b1
     5ec:	7369445f 	cmnvc	r9, #1593835520	; 0x5f000000
     5f0:	79616c70 	stmdbvc	r1!, {r4, r5, r6, sl, fp, sp, lr}^
     5f4:	50453443 	subpl	r3, r5, r3, asr #8
     5f8:	4900634b 	stmdbmi	r0, {r0, r1, r3, r6, r8, r9, sp, lr}
     5fc:	704f5f73 	subvc	r5, pc, r3, ror pc	; <UNPREDICTABLE>
     600:	64656e65 	strbtvs	r6, [r5], #-3685	; 0xfffff19b
     604:	746f4e00 	strbtvc	r4, [pc], #-3584	; 60c <shift+0x60c>
     608:	41796669 	cmnmi	r9, r9, ror #12
     60c:	42006c6c 	andmi	r6, r0, #108, 24	; 0x6c00
     610:	6b636f6c 	blvs	18dc3c8 <__bss_end+0x18d2c90>
     614:	7275435f 	rsbsvc	r4, r5, #2080374785	; 0x7c000001
     618:	746e6572 	strbtvc	r6, [lr], #-1394	; 0xfffffa8e
     61c:	6f72505f 	svcvs	0x0072505f
     620:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     624:	74654700 	strbtvc	r4, [r5], #-1792	; 0xfffff900
     628:	4449505f 	strbmi	r5, [r9], #-95	; 0xffffffa1
     62c:	6e697500 	cdpvs	5, 6, cr7, cr9, cr0, {0}
     630:	5f323374 	svcpl	0x00323374
     634:	552f0074 	strpl	r0, [pc, #-116]!	; 5c8 <shift+0x5c8>
     638:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
     63c:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
     640:	6a726574 	bvs	1c99c18 <__bss_end+0x1c904e0>
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
     678:	752f7365 	strvc	r7, [pc, #-869]!	; 31b <shift+0x31b>
     67c:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
     680:	65636170 	strbvs	r6, [r3, #-368]!	; 0xfffffe90
     684:	656c6f2f 	strbvs	r6, [ip, #-3887]!	; 0xfffff0d1
     688:	61745f64 	cmnvs	r4, r4, ror #30
     68c:	6d2f6b73 	fstmdbxvs	pc!, {d6-d62}	;@ Deprecated
     690:	2e6e6961 	vnmulcs.f16	s13, s28, s3	; <UNPREDICTABLE>
     694:	00707063 	rsbseq	r7, r0, r3, rrx
     698:	314e5a5f 	cmpcc	lr, pc, asr sl
     69c:	4c4f4333 	mcrrmi	3, 3, r4, pc, cr3
     6a0:	445f4445 	ldrbmi	r4, [pc], #-1093	; 6a8 <shift+0x6a8>
     6a4:	6c707369 	ldclvs	3, cr7, [r0], #-420	; 0xfffffe5c
     6a8:	43357961 	teqmi	r5, #1589248	; 0x184000
     6ac:	7261656c 	rsbvc	r6, r1, #108, 10	; 0x1b000000
     6b0:	42006245 	andmi	r6, r0, #1342177284	; 0x50000004
     6b4:	5f314353 	svcpl	0x00314353
     6b8:	65736142 	ldrbvs	r6, [r3, #-322]!	; 0xfffffebe
     6bc:	74755000 	ldrbtvc	r5, [r5], #-0
     6c0:	6168435f 	cmnvs	r8, pc, asr r3
     6c4:	61570072 	cmpvs	r7, r2, ror r0
     6c8:	4e007469 	cdpmi	4, 0, cr7, cr0, cr9, {3}
     6cc:	6b736154 	blvs	1cd8c24 <__bss_end+0x1ccf4ec>
     6d0:	6174535f 	cmnvs	r4, pc, asr r3
     6d4:	53006574 	movwpl	r6, #1396	; 0x574
     6d8:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     6dc:	5f656c75 	svcpl	0x00656c75
     6e0:	00464445 	subeq	r4, r6, r5, asr #8
     6e4:	636f6c42 	cmnvs	pc, #16896	; 0x4200
     6e8:	0064656b 	rsbeq	r6, r4, fp, ror #10
     6ec:	7275436d 	rsbsvc	r4, r5, #-1275068415	; 0xb4000001
     6f0:	746e6572 	strbtvc	r6, [lr], #-1394	; 0xfffffa8e
     6f4:	7361545f 	cmnvc	r1, #1593835520	; 0x5f000000
     6f8:	6f4e5f6b 	svcvs	0x004e5f6b
     6fc:	73006564 	movwvc	r6, #1380	; 0x564
     700:	7065656c 	rsbvc	r6, r5, ip, ror #10
     704:	6d69745f 	cfstrdvs	mvd7, [r9, #-380]!	; 0xfffffe84
     708:	5f007265 	svcpl	0x00007265
     70c:	36314e5a 			; <UNDEFINED> instruction: 0x36314e5a
     710:	6f725043 	svcvs	0x00725043
     714:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     718:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     71c:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     720:	69775339 	ldmdbvs	r7!, {r0, r3, r4, r5, r8, r9, ip, lr}^
     724:	5f686374 	svcpl	0x00686374
     728:	50456f54 	subpl	r6, r5, r4, asr pc
     72c:	50433831 	subpl	r3, r3, r1, lsr r8
     730:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     734:	4c5f7373 	mrrcmi	3, 7, r7, pc, cr3	; <UNPREDICTABLE>
     738:	5f747369 	svcpl	0x00747369
     73c:	65646f4e 	strbvs	r6, [r4, #-3918]!	; 0xfffff0b2
     740:	75706300 	ldrbvc	r6, [r0, #-768]!	; 0xfffffd00
     744:	6e6f635f 	mcrvs	3, 3, r6, cr15, cr15, {2}
     748:	74786574 	ldrbtvc	r6, [r8], #-1396	; 0xfffffa8c
     74c:	65724300 	ldrbvs	r4, [r2, #-768]!	; 0xfffffd00
     750:	5f657461 	svcpl	0x00657461
     754:	636f7250 	cmnvs	pc, #80, 4
     758:	00737365 	rsbseq	r7, r3, r5, ror #6
     75c:	6e65704f 	cdpvs	0, 6, cr7, cr5, cr15, {2}
     760:	6d695400 	cfstrdvs	mvd5, [r9, #-0]
     764:	425f7265 	subsmi	r7, pc, #1342177286	; 0x50000006
     768:	00657361 	rsbeq	r7, r5, r1, ror #6
     76c:	314e5a5f 	cmpcc	lr, pc, asr sl
     770:	4c4f4333 	mcrrmi	3, 3, r4, pc, cr3
     774:	445f4445 	ldrbmi	r4, [pc], #-1093	; 77c <shift+0x77c>
     778:	6c707369 	ldclvs	3, cr7, [r0], #-420	; 0xfffffe5c
     77c:	46347961 	ldrtmi	r7, [r4], -r1, ror #18
     780:	4570696c 	ldrbmi	r6, [r0, #-2412]!	; 0xfffff694
     784:	5a5f0076 	bpl	17c0964 <__bss_end+0x17b722c>
     788:	4336314e 	teqmi	r6, #-2147483629	; 0x80000013
     78c:	636f7250 	cmnvs	pc, #80, 4
     790:	5f737365 	svcpl	0x00737365
     794:	616e614d 	cmnvs	lr, sp, asr #2
     798:	31726567 	cmncc	r2, r7, ror #10
     79c:	746f4e34 	strbtvc	r4, [pc], #-3636	; 7a4 <shift+0x7a4>
     7a0:	5f796669 	svcpl	0x00796669
     7a4:	636f7250 	cmnvs	pc, #80, 4
     7a8:	45737365 	ldrbmi	r7, [r3, #-869]!	; 0xfffffc9b
     7ac:	54323150 	ldrtpl	r3, [r2], #-336	; 0xfffffeb0
     7b0:	6b736154 	blvs	1cd8d08 <__bss_end+0x1ccf5d0>
     7b4:	7274535f 	rsbsvc	r5, r4, #2080374785	; 0x7c000001
     7b8:	00746375 	rsbseq	r6, r4, r5, ror r3
     7bc:	5f746547 	svcpl	0x00746547
     7c0:	65686353 	strbvs	r6, [r8, #-851]!	; 0xfffffcad
     7c4:	6e495f64 	cdpvs	15, 4, cr5, cr9, cr4, {3}
     7c8:	49006f66 	stmdbmi	r0, {r1, r2, r5, r6, r8, r9, sl, fp, sp, lr}
     7cc:	6c74434f 	ldclvs	3, cr4, [r4], #-316	; 0xfffffec4
     7d0:	61486d00 	cmpvs	r8, r0, lsl #26
     7d4:	656c646e 	strbvs	r6, [ip, #-1134]!	; 0xfffffb92
     7d8:	61655200 	cmnvs	r5, r0, lsl #4
     7dc:	65540064 	ldrbvs	r0, [r4, #-100]	; 0xffffff9c
     7e0:	6e696d72 	mcrvs	13, 3, r6, cr9, cr2, {3}
     7e4:	00657461 	rsbeq	r7, r5, r1, ror #8
     7e8:	69746f4e 	ldmdbvs	r4!, {r1, r2, r3, r6, r8, r9, sl, fp, sp, lr}^
     7ec:	505f7966 	subspl	r7, pc, r6, ror #18
     7f0:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     7f4:	5f007373 	svcpl	0x00007373
     7f8:	36314e5a 			; <UNDEFINED> instruction: 0x36314e5a
     7fc:	6f725043 	svcvs	0x00725043
     800:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     804:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     808:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     80c:	76453443 	strbvc	r3, [r5], -r3, asr #8
     810:	73656d00 	cmnvc	r5, #0, 26
     814:	65676173 	strbvs	r6, [r7, #-371]!	; 0xfffffe8d
     818:	6c430073 	mcrrvs	0, 7, r0, r3, cr3
     81c:	00726165 	rsbseq	r6, r2, r5, ror #2
     820:	4b4e5a5f 	blmi	13971a4 <__bss_end+0x138da6c>
     824:	4f433331 	svcmi	0x00433331
     828:	5f44454c 	svcpl	0x0044454c
     82c:	70736944 	rsbsvc	r6, r3, r4, asr #18
     830:	3979616c 	ldmdbcc	r9!, {r2, r3, r5, r6, r8, sp, lr}^
     834:	4f5f7349 	svcmi	0x005f7349
     838:	656e6570 	strbvs	r6, [lr, #-1392]!	; 0xfffffa90
     83c:	00764564 	rsbseq	r4, r6, r4, ror #10
     840:	69746f4e 	ldmdbvs	r4!, {r1, r2, r3, r6, r8, r9, sl, fp, sp, lr}^
     844:	4d007966 	vstrmi.16	s14, [r0, #-204]	; 0xffffff34	; <UNPREDICTABLE>
     848:	61507861 	cmpvs	r0, r1, ror #16
     84c:	654c6874 	strbvs	r6, [ip, #-2164]	; 0xfffff78c
     850:	6874676e 	ldmdavs	r4!, {r1, r2, r3, r5, r6, r8, r9, sl, sp, lr}^
     854:	78614d00 	stmdavc	r1!, {r8, sl, fp, lr}^
     858:	72445346 	subvc	r5, r4, #402653185	; 0x18000001
     85c:	72657669 	rsbvc	r7, r5, #110100480	; 0x6900000
     860:	656d614e 	strbvs	r6, [sp, #-334]!	; 0xfffffeb2
     864:	676e654c 	strbvs	r6, [lr, -ip, asr #10]!
     868:	5f006874 	svcpl	0x00006874
     86c:	36314e5a 			; <UNDEFINED> instruction: 0x36314e5a
     870:	6f725043 	svcvs	0x00725043
     874:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     878:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     87c:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     880:	63533131 	cmpvs	r3, #1073741836	; 0x4000000c
     884:	75646568 	strbvc	r6, [r4, #-1384]!	; 0xfffffa98
     888:	525f656c 	subspl	r6, pc, #108, 10	; 0x1b000000
     88c:	00764552 	rsbseq	r4, r6, r2, asr r5
     890:	7465474e 	strbtvc	r4, [r5], #-1870	; 0xfffff8b2
     894:	6863535f 	stmdavs	r3!, {r0, r1, r2, r3, r4, r6, r8, r9, ip, lr}^
     898:	495f6465 	ldmdbmi	pc, {r0, r2, r5, r6, sl, sp, lr}^	; <UNPREDICTABLE>
     89c:	5f6f666e 	svcpl	0x006f666e
     8a0:	65707954 	ldrbvs	r7, [r0, #-2388]!	; 0xfffff6ac
     8a4:	49504700 	ldmdbmi	r0, {r8, r9, sl, lr}^
     8a8:	69505f4f 	ldmdbvs	r0, {r0, r1, r2, r3, r6, r8, r9, sl, fp, ip, lr}^
     8ac:	6f435f6e 	svcvs	0x00435f6e
     8b0:	00746e75 	rsbseq	r6, r4, r5, ror lr
     8b4:	6b736174 	blvs	1cd8e8c <__bss_end+0x1ccf754>
     8b8:	6f6f6200 	svcvs	0x006f6200
     8bc:	5a5f006c 	bpl	17c0a74 <__bss_end+0x17b733c>
     8c0:	4336314e 	teqmi	r6, #-2147483629	; 0x80000013
     8c4:	636f7250 	cmnvs	pc, #80, 4
     8c8:	5f737365 	svcpl	0x00737365
     8cc:	616e614d 	cmnvs	lr, sp, asr #2
     8d0:	31726567 	cmncc	r2, r7, ror #10
     8d4:	74654738 	strbtvc	r4, [r5], #-1848	; 0xfffff8c8
     8d8:	6863535f 	stmdavs	r3!, {r0, r1, r2, r3, r4, r6, r8, r9, ip, lr}^
     8dc:	6c756465 	cfldrdvs	mvd6, [r5], #-404	; 0xfffffe6c
     8e0:	495f7265 	ldmdbmi	pc, {r0, r2, r5, r6, r9, ip, sp, lr}^	; <UNPREDICTABLE>
     8e4:	456f666e 	strbmi	r6, [pc, #-1646]!	; 27e <shift+0x27e>
     8e8:	474e3032 	smlaldxmi	r3, lr, r2, r0
     8ec:	535f7465 	cmppl	pc, #1694498816	; 0x65000000
     8f0:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     8f4:	666e495f 			; <UNDEFINED> instruction: 0x666e495f
     8f8:	79545f6f 	ldmdbvc	r4, {r0, r1, r2, r3, r5, r6, r8, r9, sl, fp, ip, lr}^
     8fc:	76506570 			; <UNDEFINED> instruction: 0x76506570
     900:	4e525400 	cdpmi	4, 5, cr5, cr2, cr0, {0}
     904:	61425f47 	cmpvs	r2, r7, asr #30
     908:	44006573 	strmi	r6, [r0], #-1395	; 0xfffffa8d
     90c:	75616665 	strbvc	r6, [r1, #-1637]!	; 0xfffff99b
     910:	435f746c 	cmpmi	pc, #108, 8	; 0x6c000000
     914:	6b636f6c 	blvs	18dc6cc <__bss_end+0x18d2f94>
     918:	7461525f 	strbtvc	r5, [r1], #-607	; 0xfffffda1
     91c:	506d0065 	rsbpl	r0, sp, r5, rrx
     920:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     924:	4c5f7373 	mrrcmi	3, 7, r7, pc, cr3	; <UNPREDICTABLE>
     928:	5f747369 	svcpl	0x00747369
     92c:	64616548 	strbtvs	r6, [r1], #-1352	; 0xfffffab8
     930:	63536d00 	cmpvs	r3, #0, 26
     934:	75646568 	strbvc	r6, [r4, #-1384]!	; 0xfffffa98
     938:	465f656c 	ldrbmi	r6, [pc], -ip, ror #10
     93c:	5f00636e 	svcpl	0x0000636e
     940:	36314e5a 			; <UNDEFINED> instruction: 0x36314e5a
     944:	6f725043 	svcvs	0x00725043
     948:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     94c:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     950:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     954:	6c423132 	stfvse	f3, [r2], {50}	; 0x32
     958:	5f6b636f 	svcpl	0x006b636f
     95c:	72727543 	rsbsvc	r7, r2, #281018368	; 0x10c00000
     960:	5f746e65 	svcpl	0x00746e65
     964:	636f7250 	cmnvs	pc, #80, 4
     968:	45737365 	ldrbmi	r7, [r3, #-869]!	; 0xfffffc9b
     96c:	6f4c0076 	svcvs	0x004c0076
     970:	555f6b63 	ldrbpl	r6, [pc, #-2915]	; fffffe15 <__bss_end+0xffff66dd>
     974:	636f6c6e 	cmnvs	pc, #28160	; 0x6e00
     978:	0064656b 	rsbeq	r6, r4, fp, ror #10
     97c:	73614c6d 	cmnvc	r1, #27904	; 0x6d00
     980:	49505f74 	ldmdbmi	r0, {r2, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     984:	77530044 	ldrbvc	r0, [r3, -r4, asr #32]
     988:	68637469 	stmdavs	r3!, {r0, r3, r5, r6, sl, ip, sp, lr}^
     98c:	006f545f 	rsbeq	r5, pc, pc, asr r4	; <UNPREDICTABLE>
     990:	736f6c43 	cmnvc	pc, #17152	; 0x4300
     994:	5a5f0065 	bpl	17c0b30 <__bss_end+0x17b73f8>
     998:	4336314e 	teqmi	r6, #-2147483629	; 0x80000013
     99c:	636f7250 	cmnvs	pc, #80, 4
     9a0:	5f737365 	svcpl	0x00737365
     9a4:	616e614d 	cmnvs	lr, sp, asr #2
     9a8:	31726567 	cmncc	r2, r7, ror #10
     9ac:	68635332 	stmdavs	r3!, {r1, r4, r5, r8, r9, ip, lr}^
     9b0:	6c756465 	cfldrdvs	mvd6, [r5], #-404	; 0xfffffe6c
     9b4:	44455f65 	strbmi	r5, [r5], #-3941	; 0xfffff09b
     9b8:	00764546 	rsbseq	r4, r6, r6, asr #10
     9bc:	30435342 	subcc	r5, r3, r2, asr #6
     9c0:	7361425f 	cmnvc	r1, #-268435451	; 0xf0000005
     9c4:	72610065 	rsbvc	r0, r1, #101	; 0x65
     9c8:	6e006367 	cdpvs	3, 0, cr6, cr0, cr7, {3}
     9cc:	6669746f 	strbtvs	r7, [r9], -pc, ror #8
     9d0:	5f646569 	svcpl	0x00646569
     9d4:	64616564 	strbtvs	r6, [r1], #-1380	; 0xfffffa9c
     9d8:	656e696c 	strbvs	r6, [lr, #-2412]!	; 0xfffff694
     9dc:	67726100 	ldrbvs	r6, [r2, -r0, lsl #2]!
     9e0:	69750076 	ldmdbvs	r5!, {r1, r2, r4, r5, r6}^
     9e4:	3631746e 	ldrtcc	r7, [r1], -lr, ror #8
     9e8:	6d00745f 	cfstrsvs	mvf7, [r0, #-380]	; 0xfffffe84
     9ec:	6e65704f 	cdpvs	0, 6, cr7, cr5, cr15, {2}
     9f0:	5f006465 	svcpl	0x00006465
     9f4:	36314e5a 			; <UNDEFINED> instruction: 0x36314e5a
     9f8:	6f725043 	svcvs	0x00725043
     9fc:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     a00:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     a04:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     a08:	6f4e3431 	svcvs	0x004e3431
     a0c:	79666974 	stmdbvc	r6!, {r2, r4, r5, r6, r8, fp, sp, lr}^
     a10:	6f72505f 	svcvs	0x0072505f
     a14:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     a18:	4e006a45 	vmlsmi.f32	s12, s0, s10
     a1c:	6c69466f 	stclvs	6, cr4, [r9], #-444	; 0xfffffe44
     a20:	73797365 	cmnvc	r9, #-1811939327	; 0x94000001
     a24:	446d6574 	strbtmi	r6, [sp], #-1396	; 0xfffffa8c
     a28:	65766972 	ldrbvs	r6, [r6, #-2418]!	; 0xfffff68e
     a2c:	5a5f0072 	bpl	17c0bfc <__bss_end+0x17b74c4>
     a30:	4333314e 	teqmi	r3, #-2147483629	; 0x80000013
     a34:	44454c4f 	strbmi	r4, [r5], #-3151	; 0xfffff3b1
     a38:	7369445f 	cmnvc	r9, #1593835520	; 0x5f000000
     a3c:	79616c70 	stmdbvc	r1!, {r4, r5, r6, sl, fp, sp, lr}^
     a40:	76453444 	strbvc	r3, [r5], -r4, asr #8
     a44:	61654400 	cmnvs	r5, r0, lsl #8
     a48:	6e696c64 	cdpvs	12, 6, cr6, cr9, cr4, {3}
     a4c:	68730065 	ldmdavs	r3!, {r0, r2, r5, r6}^
     a50:	2074726f 	rsbscs	r7, r4, pc, ror #4
     a54:	00746e69 	rsbseq	r6, r4, r9, ror #28
     a58:	4c4f437e 	mcrrmi	3, 7, r4, pc, cr14
     a5c:	445f4445 	ldrbmi	r4, [pc], #-1093	; a64 <shift+0xa64>
     a60:	6c707369 	ldclvs	3, cr7, [r0], #-420	; 0xfffffe5c
     a64:	4d007961 	vstrmi.16	s14, [r0, #-194]	; 0xffffff3e	; <UNPREDICTABLE>
     a68:	69467861 	stmdbvs	r6, {r0, r5, r6, fp, ip, sp, lr}^
     a6c:	616e656c 	cmnvs	lr, ip, ror #10
     a70:	654c656d 	strbvs	r6, [ip, #-1389]	; 0xfffffa93
     a74:	6874676e 	ldmdavs	r4!, {r1, r2, r3, r5, r6, r8, r9, sl, sp, lr}^
     a78:	72504300 	subsvc	r4, r0, #0, 6
     a7c:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     a80:	614d5f73 	hvcvs	54771	; 0xd5f3
     a84:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     a88:	74740072 	ldrbtvc	r0, [r4], #-114	; 0xffffff8e
     a8c:	00307262 	eorseq	r7, r0, r2, ror #4
     a90:	4957534e 	ldmdbmi	r7, {r1, r2, r3, r6, r8, r9, ip, lr}^
     a94:	6c69465f 	stclvs	6, cr4, [r9], #-380	; 0xfffffe84
     a98:	73797365 	cmnvc	r9, #-1811939327	; 0x94000001
     a9c:	5f6d6574 	svcpl	0x006d6574
     aa0:	76726553 			; <UNDEFINED> instruction: 0x76726553
     aa4:	00656369 	rsbeq	r6, r5, r9, ror #6
     aa8:	4957534e 	ldmdbmi	r7, {r1, r2, r3, r6, r8, r9, ip, lr}^
     aac:	6f72505f 	svcvs	0x0072505f
     ab0:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     ab4:	7265535f 	rsbvc	r5, r5, #2080374785	; 0x7c000001
     ab8:	65636976 	strbvs	r6, [r3, #-2422]!	; 0xfffff68a
     abc:	65706f00 	ldrbvs	r6, [r0, #-3840]!	; 0xfffff100
     ac0:	5f64656e 	svcpl	0x0064656e
     ac4:	656c6966 	strbvs	r6, [ip, #-2406]!	; 0xfffff69a
     ac8:	69590073 	ldmdbvs	r9, {r0, r1, r4, r5, r6}^
     acc:	00646c65 	rsbeq	r6, r4, r5, ror #24
     ad0:	65646e49 	strbvs	r6, [r4, #-3657]!	; 0xfffff1b7
     ad4:	696e6966 	stmdbvs	lr!, {r1, r2, r5, r6, r8, fp, sp, lr}^
     ad8:	47006574 	smlsdxmi	r0, r4, r5, r6
     adc:	505f7465 	subspl	r7, pc, r5, ror #8
     ae0:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     ae4:	425f7373 	subsmi	r7, pc, #-872415231	; 0xcc000001
     ae8:	49505f79 	ldmdbmi	r0, {r0, r3, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     aec:	65500044 	ldrbvs	r0, [r0, #-68]	; 0xffffffbc
     af0:	68706972 	ldmdavs	r0!, {r1, r4, r5, r6, r8, fp, sp, lr}^
     af4:	6c617265 	sfmvs	f7, 2, [r1], #-404	; 0xfffffe6c
     af8:	7361425f 	cmnvc	r1, #-268435451	; 0xf0000005
     afc:	5a5f0065 	bpl	17c0c98 <__bss_end+0x17b7560>
     b00:	4333314e 	teqmi	r3, #-2147483629	; 0x80000013
     b04:	44454c4f 	strbmi	r4, [r5], #-3151	; 0xfffff3b1
     b08:	7369445f 	cmnvc	r9, #1593835520	; 0x5f000000
     b0c:	79616c70 	stmdbvc	r1!, {r4, r5, r6, sl, fp, sp, lr}^
     b10:	75503031 	ldrbvc	r3, [r0, #-49]	; 0xffffffcf
     b14:	74535f74 	ldrbvc	r5, [r3], #-3956	; 0xfffff08c
     b18:	676e6972 			; <UNDEFINED> instruction: 0x676e6972
     b1c:	50747445 	rsbspl	r7, r4, r5, asr #8
     b20:	6c00634b 	stcvs	3, cr6, [r0], {75}	; 0x4b
     b24:	20676e6f 	rsbcs	r6, r7, pc, ror #28
     b28:	69736e75 	ldmdbvs	r3!, {r0, r2, r4, r5, r6, r9, sl, fp, sp, lr}^
     b2c:	64656e67 	strbtvs	r6, [r5], #-3687	; 0xfffff199
     b30:	746e6920 	strbtvc	r6, [lr], #-2336	; 0xfffff6e0
     b34:	696c4600 	stmdbvs	ip!, {r9, sl, lr}^
     b38:	6e490070 	mcrvs	0, 2, r0, cr9, cr0, {3}
     b3c:	696c6176 	stmdbvs	ip!, {r1, r2, r4, r5, r6, r8, sp, lr}^
     b40:	69505f64 	ldmdbvs	r0, {r2, r5, r6, r8, r9, sl, fp, ip, lr}^
     b44:	6f4c006e 	svcvs	0x004c006e
     b48:	4c5f6b63 	mrrcmi	11, 6, r6, pc, cr3	; <UNPREDICTABLE>
     b4c:	656b636f 	strbvs	r6, [fp, #-879]!	; 0xfffffc91
     b50:	5a5f0064 	bpl	17c0ce8 <__bss_end+0x17b75b0>
     b54:	4336314e 	teqmi	r6, #-2147483629	; 0x80000013
     b58:	636f7250 	cmnvs	pc, #80, 4
     b5c:	5f737365 	svcpl	0x00737365
     b60:	616e614d 	cmnvs	lr, sp, asr #2
     b64:	31726567 	cmncc	r2, r7, ror #10
     b68:	6e614838 	mcrvs	8, 3, r4, cr1, cr8, {1}
     b6c:	5f656c64 	svcpl	0x00656c64
     b70:	636f7250 	cmnvs	pc, #80, 4
     b74:	5f737365 	svcpl	0x00737365
     b78:	45495753 	strbmi	r5, [r9, #-1875]	; 0xfffff8ad
     b7c:	534e3032 	movtpl	r3, #57394	; 0xe032
     b80:	505f4957 	subspl	r4, pc, r7, asr r9	; <UNPREDICTABLE>
     b84:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     b88:	535f7373 	cmppl	pc, #-872415231	; 0xcc000001
     b8c:	69767265 	ldmdbvs	r6!, {r0, r2, r5, r6, r9, ip, sp, lr}^
     b90:	6a6a6563 	bvs	1a9a124 <__bss_end+0x1a909ec>
     b94:	3131526a 	teqcc	r1, sl, ror #4
     b98:	49575354 	ldmdbmi	r7, {r2, r4, r6, r8, r9, ip, lr}^
     b9c:	7365525f 	cmnvc	r5, #-268435451	; 0xf0000005
     ba0:	00746c75 	rsbseq	r6, r4, r5, ror ip
     ba4:	5f746553 	svcpl	0x00746553
     ba8:	65786950 	ldrbvs	r6, [r8, #-2384]!	; 0xfffff6b0
     bac:	6373006c 	cmnvs	r3, #108	; 0x6c
     bb0:	5f646568 	svcpl	0x00646568
     bb4:	6e756f63 	cdpvs	15, 7, cr6, cr5, cr3, {3}
     bb8:	00726574 	rsbseq	r6, r2, r4, ror r5
     bbc:	69736e75 	ldmdbvs	r3!, {r0, r2, r4, r5, r6, r9, sl, fp, sp, lr}^
     bc0:	64656e67 	strbtvs	r6, [r5], #-3687	; 0xfffff199
     bc4:	61686320 	cmnvs	r8, r0, lsr #6
     bc8:	6e490072 	mcrvs	0, 2, r0, cr9, cr2, {3}
     bcc:	72726574 	rsbsvc	r6, r2, #116, 10	; 0x1d000000
     bd0:	61747075 	cmnvs	r4, r5, ror r0
     bd4:	5f656c62 	svcpl	0x00656c62
     bd8:	65656c53 	strbvs	r6, [r5, #-3155]!	; 0xfffff3ad
     bdc:	63530070 	cmpvs	r3, #112	; 0x70
     be0:	75646568 	strbvc	r6, [r4, #-1384]!	; 0xfffffa98
     be4:	525f656c 	subspl	r6, pc, #108, 10	; 0x1b000000
     be8:	55410052 	strbpl	r0, [r1, #-82]	; 0xffffffae
     bec:	61425f58 	cmpvs	r2, r8, asr pc
     bf0:	42006573 	andmi	r6, r0, #482344960	; 0x1cc00000
     bf4:	5f324353 	svcpl	0x00324353
     bf8:	65736142 	ldrbvs	r6, [r3, #-322]!	; 0xfffffebe
     bfc:	61747300 	cmnvs	r4, r0, lsl #6
     c00:	57006574 	smlsdxpl	r0, r4, r5, r6
     c04:	65746972 	ldrbvs	r6, [r4, #-2418]!	; 0xfffff68e
     c08:	6c6e4f5f 	stclvs	15, cr4, [lr], #-380	; 0xfffffe84
     c0c:	63530079 	cmpvs	r3, #121	; 0x79
     c10:	75646568 	strbvc	r6, [r4, #-1384]!	; 0xfffffa98
     c14:	5400656c 	strpl	r6, [r0], #-1388	; 0xfffffa94
     c18:	5f6b6369 	svcpl	0x006b6369
     c1c:	6e756f43 	cdpvs	15, 7, cr6, cr5, cr3, {2}
     c20:	5a5f0074 	bpl	17c0df8 <__bss_end+0x17b76c0>
     c24:	4333314e 	teqmi	r3, #-2147483629	; 0x80000013
     c28:	44454c4f 	strbmi	r4, [r5], #-3151	; 0xfffff3b1
     c2c:	7369445f 	cmnvc	r9, #1593835520	; 0x5f000000
     c30:	79616c70 	stmdbvc	r1!, {r4, r5, r6, sl, fp, sp, lr}^
     c34:	74655339 	strbtvc	r5, [r5], #-825	; 0xfffffcc7
     c38:	7869505f 	stmdavc	r9!, {r0, r1, r2, r3, r4, r6, ip, lr}^
     c3c:	74456c65 	strbvc	r6, [r5], #-3173	; 0xfffff39b
     c40:	5f006274 	svcpl	0x00006274
     c44:	36314e5a 			; <UNDEFINED> instruction: 0x36314e5a
     c48:	6f725043 	svcvs	0x00725043
     c4c:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     c50:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     c54:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     c58:	6e553831 	mrcvs	8, 2, r3, cr5, cr1, {1}
     c5c:	5f70616d 	svcpl	0x0070616d
     c60:	656c6946 	strbvs	r6, [ip, #-2374]!	; 0xfffff6ba
     c64:	7275435f 	rsbsvc	r4, r5, #2080374785	; 0x7c000001
     c68:	746e6572 	strbtvc	r6, [lr], #-1394	; 0xfffffa8e
     c6c:	48006a45 	stmdami	r0, {r0, r2, r6, r9, fp, sp, lr}
     c70:	6c646e61 	stclvs	14, cr6, [r4], #-388	; 0xfffffe7c
     c74:	69465f65 	stmdbvs	r6, {r0, r2, r5, r6, r8, r9, sl, fp, ip, lr}^
     c78:	7973656c 	ldmdbvc	r3!, {r2, r3, r5, r6, r8, sl, sp, lr}^
     c7c:	6d657473 	cfstrdvs	mvd7, [r5, #-460]!	; 0xfffffe34
     c80:	4957535f 	ldmdbmi	r7, {r0, r1, r2, r3, r4, r6, r8, r9, ip, lr}^
     c84:	6f687300 	svcvs	0x00687300
     c88:	75207472 	strvc	r7, [r0, #-1138]!	; 0xfffffb8e
     c8c:	6769736e 	strbvs	r7, [r9, -lr, ror #6]!
     c90:	2064656e 	rsbcs	r6, r4, lr, ror #10
     c94:	00746e69 	rsbseq	r6, r4, r9, ror #28
     c98:	6e69616d 	powvsez	f6, f1, #5.0
     c9c:	73696400 	cmnvc	r9, #0, 8
     ca0:	75500070 	ldrbvc	r0, [r0, #-112]	; 0xffffff90
     ca4:	74535f74 	ldrbvc	r5, [r3], #-3956	; 0xfffff08c
     ca8:	676e6972 			; <UNDEFINED> instruction: 0x676e6972
     cac:	746e4900 	strbtvc	r4, [lr], #-2304	; 0xfffff700
     cb0:	75727265 	ldrbvc	r7, [r2, #-613]!	; 0xfffffd9b
     cb4:	435f7470 	cmpmi	pc, #112, 8	; 0x70000000
     cb8:	72746e6f 	rsbsvc	r6, r4, #1776	; 0x6f0
     cbc:	656c6c6f 	strbvs	r6, [ip, #-3183]!	; 0xfffff391
     cc0:	61425f72 	hvcvs	9714	; 0x25f2
     cc4:	52006573 	andpl	r6, r0, #482344960	; 0x1cc00000
     cc8:	5f646165 	svcpl	0x00646165
     ccc:	74697257 	strbtvc	r7, [r9], #-599	; 0xfffffda9
     cd0:	63410065 	movtvs	r0, #4197	; 0x1065
     cd4:	65766974 	ldrbvs	r6, [r6, #-2420]!	; 0xfffff68c
     cd8:	6f72505f 	svcvs	0x0072505f
     cdc:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     ce0:	756f435f 	strbvc	r4, [pc, #-863]!	; 989 <shift+0x989>
     ce4:	5f00746e 	svcpl	0x0000746e
     ce8:	36314e5a 			; <UNDEFINED> instruction: 0x36314e5a
     cec:	6f725043 	svcvs	0x00725043
     cf0:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     cf4:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     cf8:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     cfc:	61483132 	cmpvs	r8, r2, lsr r1
     d00:	656c646e 	strbvs	r6, [ip, #-1134]!	; 0xfffffb92
     d04:	6c69465f 	stclvs	6, cr4, [r9], #-380	; 0xfffffe84
     d08:	73797365 	cmnvc	r9, #-1811939327	; 0x94000001
     d0c:	5f6d6574 	svcpl	0x006d6574
     d10:	45495753 	strbmi	r5, [r9, #-1875]	; 0xfffff8ad
     d14:	534e3332 	movtpl	r3, #58162	; 0xe332
     d18:	465f4957 			; <UNDEFINED> instruction: 0x465f4957
     d1c:	73656c69 	cmnvc	r5, #26880	; 0x6900
     d20:	65747379 	ldrbvs	r7, [r4, #-889]!	; 0xfffffc87
     d24:	65535f6d 	ldrbvs	r5, [r3, #-3949]	; 0xfffff093
     d28:	63697672 	cmnvs	r9, #119537664	; 0x7200000
     d2c:	6a6a6a65 	bvs	1a9b6c8 <__bss_end+0x1a91f90>
     d30:	54313152 	ldrtpl	r3, [r1], #-338	; 0xfffffeae
     d34:	5f495753 	svcpl	0x00495753
     d38:	75736552 	ldrbvc	r6, [r3, #-1362]!	; 0xfffffaae
     d3c:	7400746c 	strvc	r7, [r0], #-1132	; 0xfffffb94
     d40:	5f676e72 	svcpl	0x00676e72
     d44:	656c6966 	strbvs	r6, [ip, #-2406]!	; 0xfffff69a
     d48:	73552f00 	cmpvc	r5, #0, 30
     d4c:	2f737265 	svccs	0x00737265
     d50:	746e6977 	strbtvc	r6, [lr], #-2423	; 0xfffff689
     d54:	696a7265 	stmdbvs	sl!, {r0, r2, r5, r6, r9, ip, sp, lr}^
     d58:	7365442f 	cmnvc	r5, #788529152	; 0x2f000000
     d5c:	706f746b 	rsbvc	r7, pc, fp, ror #8
     d60:	5641462f 	strbpl	r4, [r1], -pc, lsr #12
     d64:	76614e2f 	strbtvc	r4, [r1], -pc, lsr #28
     d68:	6a757a61 	bvs	1d5f6f4 <__bss_end+0x1d55fbc>
     d6c:	2f696369 	svccs	0x00696369
     d70:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
     d74:	73656d65 	cmnvc	r5, #6464	; 0x1940
     d78:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
     d7c:	6b2d616b 	blvs	b59330 <__bss_end+0xb4fbf8>
     d80:	6f2d7669 	svcvs	0x002d7669
     d84:	6f732f73 	svcvs	0x00732f73
     d88:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
     d8c:	75622f73 	strbvc	r2, [r2, #-3955]!	; 0xfffff08d
     d90:	00646c69 	rsbeq	r6, r4, r9, ror #24
     d94:	736f6c63 	cmnvc	pc, #25344	; 0x6300
     d98:	65530065 	ldrbvs	r0, [r3, #-101]	; 0xffffff9b
     d9c:	65525f74 	ldrbvs	r5, [r2, #-3956]	; 0xfffff08c
     da0:	6974616c 	ldmdbvs	r4!, {r2, r3, r5, r6, r8, sp, lr}^
     da4:	72006576 	andvc	r6, r0, #494927872	; 0x1d800000
     da8:	61767465 	cmnvs	r6, r5, ror #8
     dac:	636e006c 	cmnvs	lr, #108	; 0x6c
     db0:	70007275 	andvc	r7, r0, r5, ror r2
     db4:	00657069 	rsbeq	r7, r5, r9, rrx
     db8:	756e6472 	strbvc	r6, [lr, #-1138]!	; 0xfffffb8e
     dbc:	5a5f006d 	bpl	17c0f78 <__bss_end+0x17b7840>
     dc0:	63733131 	cmnvs	r3, #1073741836	; 0x4000000c
     dc4:	5f646568 	svcpl	0x00646568
     dc8:	6c656979 			; <UNDEFINED> instruction: 0x6c656979
     dcc:	5f007664 	svcpl	0x00007664
     dd0:	7337315a 	teqvc	r7, #-2147483626	; 0x80000016
     dd4:	745f7465 	ldrbvc	r7, [pc], #-1125	; ddc <shift+0xddc>
     dd8:	5f6b7361 	svcpl	0x006b7361
     ddc:	64616564 	strbtvs	r6, [r1], #-1380	; 0xfffffa9c
     de0:	656e696c 	strbvs	r6, [lr, #-2412]!	; 0xfffff694
     de4:	6177006a 	cmnvs	r7, sl, rrx
     de8:	5f007469 	svcpl	0x00007469
     dec:	6f6e365a 	svcvs	0x006e365a
     df0:	79666974 	stmdbvc	r6!, {r2, r4, r5, r6, r8, fp, sp, lr}^
     df4:	46006a6a 	strmi	r6, [r0], -sl, ror #20
     df8:	006c6961 	rsbeq	r6, ip, r1, ror #18
     dfc:	74697865 	strbtvc	r7, [r9], #-2149	; 0xfffff79b
     e00:	65646f63 	strbvs	r6, [r4, #-3939]!	; 0xfffff09d
     e04:	68637300 	stmdavs	r3!, {r8, r9, ip, sp, lr}^
     e08:	795f6465 	ldmdbvc	pc, {r0, r2, r5, r6, sl, sp, lr}^	; <UNPREDICTABLE>
     e0c:	646c6569 	strbtvs	r6, [ip], #-1385	; 0xfffffa97
     e10:	63697400 	cmnvs	r9, #0, 8
     e14:	6f635f6b 	svcvs	0x00635f6b
     e18:	5f746e75 	svcpl	0x00746e75
     e1c:	75716572 	ldrbvc	r6, [r1, #-1394]!	; 0xfffffa8e
     e20:	64657269 	strbtvs	r7, [r5], #-617	; 0xfffffd97
     e24:	325a5f00 	subscc	r5, sl, #0, 30
     e28:	74656734 	strbtvc	r6, [r5], #-1844	; 0xfffff8cc
     e2c:	7463615f 	strbtvc	r6, [r3], #-351	; 0xfffffea1
     e30:	5f657669 	svcpl	0x00657669
     e34:	636f7270 	cmnvs	pc, #112, 4
     e38:	5f737365 	svcpl	0x00737365
     e3c:	6e756f63 	cdpvs	15, 7, cr6, cr5, cr3, {3}
     e40:	50007674 	andpl	r7, r0, r4, ror r6
     e44:	5f657069 	svcpl	0x00657069
     e48:	656c6946 	strbvs	r6, [ip, #-2374]!	; 0xfffff6ba
     e4c:	6572505f 	ldrbvs	r5, [r2, #-95]!	; 0xffffffa1
     e50:	00786966 	rsbseq	r6, r8, r6, ror #18
     e54:	5f746553 	svcpl	0x00746553
     e58:	61726150 	cmnvs	r2, r0, asr r1
     e5c:	5f00736d 	svcpl	0x0000736d
     e60:	6734315a 			; <UNDEFINED> instruction: 0x6734315a
     e64:	745f7465 	ldrbvc	r7, [pc], #-1125	; e6c <shift+0xe6c>
     e68:	5f6b6369 	svcpl	0x006b6369
     e6c:	6e756f63 	cdpvs	15, 7, cr6, cr5, cr3, {3}
     e70:	73007674 	movwvc	r7, #1652	; 0x674
     e74:	7065656c 	rsbvc	r6, r5, ip, ror #10
     e78:	73694400 	cmnvc	r9, #0, 8
     e7c:	656c6261 	strbvs	r6, [ip, #-609]!	; 0xfffffd9f
     e80:	6576455f 	ldrbvs	r4, [r6, #-1375]!	; 0xfffffaa1
     e84:	445f746e 	ldrbmi	r7, [pc], #-1134	; e8c <shift+0xe8c>
     e88:	63657465 	cmnvs	r5, #1694498816	; 0x65000000
     e8c:	6e6f6974 			; <UNDEFINED> instruction: 0x6e6f6974
     e90:	395a5f00 	ldmdbcc	sl, {r8, r9, sl, fp, ip, lr}^
     e94:	6d726574 	cfldr64vs	mvdx6, [r2, #-464]!	; 0xfffffe30
     e98:	74616e69 	strbtvc	r6, [r1], #-3689	; 0xfffff197
     e9c:	6f006965 	svcvs	0x00006965
     ea0:	61726570 	cmnvs	r2, r0, ror r5
     ea4:	6e6f6974 			; <UNDEFINED> instruction: 0x6e6f6974
     ea8:	355a5f00 	ldrbcc	r5, [sl, #-3840]	; 0xfffff100
     eac:	736f6c63 	cmnvc	pc, #25344	; 0x6300
     eb0:	5f006a65 	svcpl	0x00006a65
     eb4:	6567365a 	strbvs	r3, [r7, #-1626]!	; 0xfffff9a6
     eb8:	64697074 	strbtvs	r7, [r9], #-116	; 0xffffff8c
     ebc:	6e660076 	mcrvs	0, 3, r0, cr6, cr6, {3}
     ec0:	00656d61 	rsbeq	r6, r5, r1, ror #26
     ec4:	74697277 	strbtvc	r7, [r9], #-631	; 0xfffffd89
     ec8:	69740065 	ldmdbvs	r4!, {r0, r2, r5, r6}^
     ecc:	00736b63 	rsbseq	r6, r3, r3, ror #22
     ed0:	6e65706f 	cdpvs	0, 6, cr7, cr5, cr15, {3}
     ed4:	345a5f00 	ldrbcc	r5, [sl], #-3840	; 0xfffff100
     ed8:	65706970 	ldrbvs	r6, [r0, #-2416]!	; 0xfffff690
     edc:	6a634b50 	bvs	18d3c24 <__bss_end+0x18ca4ec>
     ee0:	65444e00 	strbvs	r4, [r4, #-3584]	; 0xfffff200
     ee4:	696c6461 	stmdbvs	ip!, {r0, r5, r6, sl, sp, lr}^
     ee8:	535f656e 	cmppl	pc, #461373440	; 0x1b800000
     eec:	65736275 	ldrbvs	r6, [r3, #-629]!	; 0xfffffd8b
     ef0:	63697672 	cmnvs	r9, #119537664	; 0x7200000
     ef4:	65670065 	strbvs	r0, [r7, #-101]!	; 0xffffff9b
     ef8:	69745f74 	ldmdbvs	r4!, {r2, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     efc:	635f6b63 	cmpvs	pc, #101376	; 0x18c00
     f00:	746e756f 	strbtvc	r7, [lr], #-1391	; 0xfffffa91
     f04:	72617000 	rsbvc	r7, r1, #0
     f08:	5f006d61 	svcpl	0x00006d61
     f0c:	7277355a 	rsbsvc	r3, r7, #377487360	; 0x16800000
     f10:	6a657469 	bvs	195e0bc <__bss_end+0x1954984>
     f14:	6a634b50 	bvs	18d3c5c <__bss_end+0x18ca524>
     f18:	74656700 	strbtvc	r6, [r5], #-1792	; 0xfffff900
     f1c:	7361745f 	cmnvc	r1, #1593835520	; 0x5f000000
     f20:	69745f6b 	ldmdbvs	r4!, {r0, r1, r3, r5, r6, r8, r9, sl, fp, ip, lr}^
     f24:	5f736b63 	svcpl	0x00736b63
     f28:	645f6f74 	ldrbvs	r6, [pc], #-3956	; f30 <shift+0xf30>
     f2c:	6c646165 	stfvse	f6, [r4], #-404	; 0xfffffe6c
     f30:	00656e69 	rsbeq	r6, r5, r9, ror #28
     f34:	5f667562 	svcpl	0x00667562
     f38:	657a6973 	ldrbvs	r6, [sl, #-2419]!	; 0xfffff68d
     f3c:	74657300 	strbtvc	r7, [r5], #-768	; 0xfffffd00
     f40:	7361745f 	cmnvc	r1, #1593835520	; 0x5f000000
     f44:	65645f6b 	strbvs	r5, [r4, #-3947]!	; 0xfffff095
     f48:	696c6461 	stmdbvs	ip!, {r0, r5, r6, sl, sp, lr}^
     f4c:	4700656e 	strmi	r6, [r0, -lr, ror #10]
     f50:	505f7465 	subspl	r7, pc, r5, ror #8
     f54:	6d617261 	sfmvs	f7, 2, [r1, #-388]!	; 0xfffffe7c
     f58:	552f0073 	strpl	r0, [pc, #-115]!	; eed <shift+0xeed>
     f5c:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
     f60:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
     f64:	6a726574 	bvs	1c9a53c <__bss_end+0x1c90e04>
     f68:	65442f69 	strbvs	r2, [r4, #-3945]	; 0xfffff097
     f6c:	6f746b73 	svcvs	0x00746b73
     f70:	41462f70 	hvcmi	25328	; 0x62f0
     f74:	614e2f56 	cmpvs	lr, r6, asr pc
     f78:	757a6176 	ldrbvc	r6, [sl, #-374]!	; 0xfffffe8a
     f7c:	6963696a 	stmdbvs	r3!, {r1, r3, r5, r6, r8, fp, sp, lr}^
     f80:	2f534f2f 	svccs	0x00534f2f
     f84:	656d6573 	strbvs	r6, [sp, #-1395]!	; 0xfffffa8d
     f88:	61727473 	cmnvs	r2, r3, ror r4
     f8c:	2d616b6c 	vstmdbcs	r1!, {d22-<overflow reg d75>}
     f90:	2d76696b 			; <UNDEFINED> instruction: 0x2d76696b
     f94:	732f736f 			; <UNDEFINED> instruction: 0x732f736f
     f98:	6372756f 	cmnvs	r2, #465567744	; 0x1bc00000
     f9c:	732f7365 			; <UNDEFINED> instruction: 0x732f7365
     fa0:	696c6474 	stmdbvs	ip!, {r2, r4, r5, r6, sl, sp, lr}^
     fa4:	72732f62 	rsbsvc	r2, r3, #392	; 0x188
     fa8:	74732f63 	ldrbtvc	r2, [r3], #-3939	; 0xfffff09d
     fac:	6c696664 	stclvs	6, cr6, [r9], #-400	; 0xfffffe70
     fb0:	70632e65 	rsbvc	r2, r3, r5, ror #28
     fb4:	5a5f0070 	bpl	17c117c <__bss_end+0x17b7a44>
     fb8:	656c7335 	strbvs	r7, [ip, #-821]!	; 0xfffffccb
     fbc:	6a6a7065 	bvs	1a9d158 <__bss_end+0x1a93a20>
     fc0:	74654700 	strbtvc	r4, [r5], #-1792	; 0xfffff900
     fc4:	6d65525f 	sfmvs	f5, 2, [r5, #-380]!	; 0xfffffe84
     fc8:	696e6961 	stmdbvs	lr!, {r0, r5, r6, r8, fp, sp, lr}^
     fcc:	4500676e 	strmi	r6, [r0, #-1902]	; 0xfffff892
     fd0:	6c62616e 	stfvse	f6, [r2], #-440	; 0xfffffe48
     fd4:	76455f65 	strbvc	r5, [r5], -r5, ror #30
     fd8:	5f746e65 	svcpl	0x00746e65
     fdc:	65746544 	ldrbvs	r6, [r4, #-1348]!	; 0xfffffabc
     fe0:	6f697463 	svcvs	0x00697463
     fe4:	5a5f006e 	bpl	17c11a4 <__bss_end+0x17b7a6c>
     fe8:	65673632 	strbvs	r3, [r7, #-1586]!	; 0xfffff9ce
     fec:	61745f74 	cmnvs	r4, r4, ror pc
     ff0:	745f6b73 	ldrbvc	r6, [pc], #-2931	; ff8 <shift+0xff8>
     ff4:	736b6369 	cmnvc	fp, #-1543503871	; 0xa4000001
     ff8:	5f6f745f 	svcpl	0x006f745f
     ffc:	64616564 	strbtvs	r6, [r1], #-1380	; 0xfffffa9c
    1000:	656e696c 	strbvs	r6, [lr, #-2412]!	; 0xfffff694
    1004:	534e0076 	movtpl	r0, #57462	; 0xe076
    1008:	525f4957 	subspl	r4, pc, #1425408	; 0x15c000
    100c:	6c757365 	ldclvs	3, cr7, [r5], #-404	; 0xfffffe6c
    1010:	6f435f74 	svcvs	0x00435f74
    1014:	77006564 	strvc	r6, [r0, -r4, ror #10]
    1018:	6d756e72 	ldclvs	14, cr6, [r5, #-456]!	; 0xfffffe38
    101c:	345a5f00 	ldrbcc	r5, [sl], #-3840	; 0xfffff100
    1020:	74696177 	strbtvc	r6, [r9], #-375	; 0xfffffe89
    1024:	006a6a6a 	rsbeq	r6, sl, sl, ror #20
    1028:	69355a5f 	ldmdbvs	r5!, {r0, r1, r2, r3, r4, r6, r9, fp, ip, lr}
    102c:	6c74636f 	ldclvs	3, cr6, [r4], #-444	; 0xfffffe44
    1030:	4e36316a 	rsfmisz	f3, f6, #2.0
    1034:	74434f49 	strbvc	r4, [r3], #-3913	; 0xfffff0b7
    1038:	704f5f6c 	subvc	r5, pc, ip, ror #30
    103c:	74617265 	strbtvc	r7, [r1], #-613	; 0xfffffd9b
    1040:	506e6f69 	rsbpl	r6, lr, r9, ror #30
    1044:	6f690076 	svcvs	0x00690076
    1048:	006c7463 	rsbeq	r7, ip, r3, ror #8
    104c:	63746572 	cmnvs	r4, #478150656	; 0x1c800000
    1050:	6e00746e 	cdpvs	4, 0, cr7, cr0, cr14, {3}
    1054:	6669746f 	strbtvs	r7, [r9], -pc, ror #8
    1058:	65740079 	ldrbvs	r0, [r4, #-121]!	; 0xffffff87
    105c:	6e696d72 	mcrvs	13, 3, r6, cr9, cr2, {3}
    1060:	00657461 	rsbeq	r7, r5, r1, ror #8
    1064:	65646f6d 	strbvs	r6, [r4, #-3949]!	; 0xfffff093
    1068:	66756200 	ldrbtvs	r6, [r5], -r0, lsl #4
    106c:	00726566 	rsbseq	r6, r2, r6, ror #10
    1070:	72345a5f 	eorsvc	r5, r4, #389120	; 0x5f000
    1074:	6a646165 	bvs	1919610 <__bss_end+0x190fed8>
    1078:	006a6350 	rsbeq	r6, sl, r0, asr r3
    107c:	20554e47 	subscs	r4, r5, r7, asr #28
    1080:	312b2b43 			; <UNDEFINED> instruction: 0x312b2b43
    1084:	30312034 	eorscc	r2, r1, r4, lsr r0
    1088:	312e332e 			; <UNDEFINED> instruction: 0x312e332e
    108c:	32303220 	eorscc	r3, r0, #32, 4
    1090:	32383031 	eorscc	r3, r8, #49	; 0x31
    1094:	72282034 	eorvc	r2, r8, #52	; 0x34
    1098:	61656c65 	cmnvs	r5, r5, ror #24
    109c:	20296573 	eorcs	r6, r9, r3, ror r5
    10a0:	6c666d2d 	stclvs	13, cr6, [r6], #-180	; 0xffffff4c
    10a4:	2d74616f 	ldfcse	f6, [r4, #-444]!	; 0xfffffe44
    10a8:	3d696261 	sfmcc	f6, 2, [r9, #-388]!	; 0xfffffe7c
    10ac:	64726168 	ldrbtvs	r6, [r2], #-360	; 0xfffffe98
    10b0:	666d2d20 	strbtvs	r2, [sp], -r0, lsr #26
    10b4:	763d7570 			; <UNDEFINED> instruction: 0x763d7570
    10b8:	2d207066 	stccs	0, cr7, [r0, #-408]!	; 0xfffffe68
    10bc:	6f6c666d 	svcvs	0x006c666d
    10c0:	612d7461 			; <UNDEFINED> instruction: 0x612d7461
    10c4:	683d6962 	ldmdavs	sp!, {r1, r5, r6, r8, fp, sp, lr}
    10c8:	20647261 	rsbcs	r7, r4, r1, ror #4
    10cc:	70666d2d 	rsbvc	r6, r6, sp, lsr #26
    10d0:	66763d75 			; <UNDEFINED> instruction: 0x66763d75
    10d4:	6d2d2070 	stcvs	0, cr2, [sp, #-448]!	; 0xfffffe40
    10d8:	656e7574 	strbvs	r7, [lr, #-1396]!	; 0xfffffa8c
    10dc:	6d72613d 	ldfvse	f6, [r2, #-244]!	; 0xffffff0c
    10e0:	36373131 			; <UNDEFINED> instruction: 0x36373131
    10e4:	2d667a6a 	vstmdbcs	r6!, {s15-s120}
    10e8:	6d2d2073 	stcvs	0, cr2, [sp, #-460]!	; 0xfffffe34
    10ec:	206d7261 	rsbcs	r7, sp, r1, ror #4
    10f0:	72616d2d 	rsbvc	r6, r1, #2880	; 0xb40
    10f4:	613d6863 	teqvs	sp, r3, ror #16
    10f8:	36766d72 			; <UNDEFINED> instruction: 0x36766d72
    10fc:	662b6b7a 			; <UNDEFINED> instruction: 0x662b6b7a
    1100:	672d2070 			; <UNDEFINED> instruction: 0x672d2070
    1104:	20672d20 	rsbcs	r2, r7, r0, lsr #26
    1108:	2d20672d 	stccs	7, cr6, [r0, #-180]!	; 0xffffff4c
    110c:	2d20304f 	stccs	0, cr3, [r0, #-316]!	; 0xfffffec4
    1110:	2d20304f 	stccs	0, cr3, [r0, #-316]!	; 0xfffffec4
    1114:	2d6f6e66 	stclcs	14, cr6, [pc, #-408]!	; f84 <shift+0xf84>
    1118:	65637865 	strbvs	r7, [r3, #-2149]!	; 0xfffff79b
    111c:	6f697470 	svcvs	0x00697470
    1120:	2d20736e 	stccs	3, cr7, [r0, #-440]!	; 0xfffffe48
    1124:	2d6f6e66 	stclcs	14, cr6, [pc, #-408]!	; f94 <shift+0xf94>
    1128:	69747472 	ldmdbvs	r4!, {r1, r4, r5, r6, sl, ip, sp, lr}^
    112c:	4f494e00 	svcmi	0x00494e00
    1130:	5f6c7443 	svcpl	0x006c7443
    1134:	7265704f 	rsbvc	r7, r5, #79	; 0x4f
    1138:	6f697461 	svcvs	0x00697461
    113c:	6572006e 	ldrbvs	r0, [r2, #-110]!	; 0xffffff92
    1140:	646f6374 	strbtvs	r6, [pc], #-884	; 1148 <shift+0x1148>
    1144:	65670065 	strbvs	r0, [r7, #-101]!	; 0xffffff9b
    1148:	63615f74 	cmnvs	r1, #116, 30	; 0x1d0
    114c:	65766974 	ldrbvs	r6, [r6, #-2420]!	; 0xfffff68c
    1150:	6f72705f 	svcvs	0x0072705f
    1154:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
    1158:	756f635f 	strbvc	r6, [pc, #-863]!	; e01 <shift+0xe01>
    115c:	6600746e 	strvs	r7, [r0], -lr, ror #8
    1160:	6e656c69 	cdpvs	12, 6, cr6, cr5, cr9, {3}
    1164:	00656d61 	rsbeq	r6, r5, r1, ror #26
    1168:	64616572 	strbtvs	r6, [r1], #-1394	; 0xfffffa8e
    116c:	74656700 	strbtvc	r6, [r5], #-1792	; 0xfffff900
    1170:	00646970 	rsbeq	r6, r4, r0, ror r9
    1174:	6f345a5f 	svcvs	0x00345a5f
    1178:	506e6570 	rsbpl	r6, lr, r0, ror r5
    117c:	3531634b 	ldrcc	r6, [r1, #-843]!	; 0xfffffcb5
    1180:	6c69464e 	stclvs	6, cr4, [r9], #-312	; 0xfffffec8
    1184:	704f5f65 	subvc	r5, pc, r5, ror #30
    1188:	4d5f6e65 	ldclmi	14, cr6, [pc, #-404]	; ffc <shift+0xffc>
    118c:	0065646f 	rsbeq	r6, r5, pc, ror #8
    1190:	75706e69 	ldrbvc	r6, [r0, #-3689]!	; 0xfffff197
    1194:	65640074 	strbvs	r0, [r4, #-116]!	; 0xffffff8c
    1198:	62007473 	andvs	r7, r0, #1929379840	; 0x73000000
    119c:	6f72657a 	svcvs	0x0072657a
    11a0:	6e656c00 	cdpvs	12, 6, cr6, cr5, cr0, {0}
    11a4:	00687467 	rsbeq	r7, r8, r7, ror #8
    11a8:	62355a5f 	eorsvs	r5, r5, #389120	; 0x5f000
    11ac:	6f72657a 	svcvs	0x0072657a
    11b0:	00697650 	rsbeq	r7, r9, r0, asr r6
    11b4:	6573552f 	ldrbvs	r5, [r3, #-1327]!	; 0xfffffad1
    11b8:	772f7372 			; <UNDEFINED> instruction: 0x772f7372
    11bc:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
    11c0:	2f696a72 	svccs	0x00696a72
    11c4:	6b736544 	blvs	1cda6dc <__bss_end+0x1cd0fa4>
    11c8:	2f706f74 	svccs	0x00706f74
    11cc:	2f564146 	svccs	0x00564146
    11d0:	6176614e 	cmnvs	r6, lr, asr #2
    11d4:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
    11d8:	4f2f6963 	svcmi	0x002f6963
    11dc:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
    11e0:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
    11e4:	6b6c6172 	blvs	1b197b4 <__bss_end+0x1b1007c>
    11e8:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
    11ec:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
    11f0:	756f732f 	strbvc	r7, [pc, #-815]!	; ec9 <shift+0xec9>
    11f4:	73656372 	cmnvc	r5, #-939524095	; 0xc8000001
    11f8:	6474732f 	ldrbtvs	r7, [r4], #-815	; 0xfffffcd1
    11fc:	2f62696c 	svccs	0x0062696c
    1200:	2f637273 	svccs	0x00637273
    1204:	73647473 	cmnvc	r4, #1929379840	; 0x73000000
    1208:	6e697274 	mcrvs	2, 3, r7, cr9, cr4, {3}
    120c:	70632e67 	rsbvc	r2, r3, r7, ror #28
    1210:	5a5f0070 	bpl	17c13d8 <__bss_end+0x17b7ca0>
    1214:	6f746134 	svcvs	0x00746134
    1218:	634b5069 	movtvs	r5, #45161	; 0xb069
    121c:	61684300 	cmnvs	r8, r0, lsl #6
    1220:	6e6f4372 	mcrvs	3, 3, r4, cr15, cr2, {3}
    1224:	72724176 	rsbsvc	r4, r2, #-2147483619	; 0x8000001d
    1228:	6d656d00 	stclvs	13, cr6, [r5, #-0]
    122c:	00747364 	rsbseq	r7, r4, r4, ror #6
    1230:	7074756f 	rsbsvc	r7, r4, pc, ror #10
    1234:	5f007475 	svcpl	0x00007475
    1238:	656d365a 	strbvs	r3, [sp, #-1626]!	; 0xfffff9a6
    123c:	7970636d 	ldmdbvc	r0!, {r0, r2, r3, r5, r6, r8, r9, sp, lr}^
    1240:	50764b50 	rsbspl	r4, r6, r0, asr fp
    1244:	62006976 	andvs	r6, r0, #1933312	; 0x1d8000
    1248:	00657361 	rsbeq	r7, r5, r1, ror #6
    124c:	636d656d 	cmnvs	sp, #457179136	; 0x1b400000
    1250:	73007970 	movwvc	r7, #2416	; 0x970
    1254:	656c7274 	strbvs	r7, [ip, #-628]!	; 0xfffffd8c
    1258:	5a5f006e 	bpl	17c1418 <__bss_end+0x17b7ce0>
    125c:	72747337 	rsbsvc	r7, r4, #-603979776	; 0xdc000000
    1260:	706d636e 	rsbvc	r6, sp, lr, ror #6
    1264:	53634b50 	cmnpl	r3, #80, 22	; 0x14000
    1268:	00695f30 	rsbeq	r5, r9, r0, lsr pc
    126c:	73365a5f 	teqvc	r6, #389120	; 0x5f000
    1270:	656c7274 	strbvs	r7, [ip, #-628]!	; 0xfffffd8c
    1274:	634b506e 	movtvs	r5, #45166	; 0xb06e
    1278:	6f746100 	svcvs	0x00746100
    127c:	5a5f0069 	bpl	17c1428 <__bss_end+0x17b7cf0>
    1280:	72747337 	rsbsvc	r7, r4, #-603979776	; 0xdc000000
    1284:	7970636e 	ldmdbvc	r0!, {r1, r2, r3, r5, r6, r8, r9, sp, lr}^
    1288:	4b506350 	blmi	1419fd0 <__bss_end+0x1410898>
    128c:	73006963 	movwvc	r6, #2403	; 0x963
    1290:	636e7274 	cmnvs	lr, #116, 4	; 0x40000007
    1294:	7300706d 	movwvc	r7, #109	; 0x6d
    1298:	636e7274 	cmnvs	lr, #116, 4	; 0x40000007
    129c:	6d007970 	vstrvs.16	s14, [r0, #-224]	; 0xffffff20	; <UNPREDICTABLE>
    12a0:	726f6d65 	rsbvc	r6, pc, #6464	; 0x1940
    12a4:	656d0079 	strbvs	r0, [sp, #-121]!	; 0xffffff87
    12a8:	6372736d 	cmnvs	r2, #-1275068415	; 0xb4000001
    12ac:	6f746900 	svcvs	0x00746900
    12b0:	5a5f0061 	bpl	17c143c <__bss_end+0x17b7d04>
    12b4:	6f746934 	svcvs	0x00746934
    12b8:	63506a61 	cmpvs	r0, #397312	; 0x61000
    12bc:	5f5f006a 	svcpl	0x005f006a
    12c0:	635f6e69 	cmpvs	pc, #1680	; 0x690
    12c4:	00677268 	rsbeq	r7, r7, r8, ror #4
    12c8:	73694454 	cmnvc	r9, #84, 8	; 0x54000000
    12cc:	79616c70 	stmdbvc	r1!, {r4, r5, r6, sl, fp, sp, lr}^
    12d0:	6361505f 	cmnvs	r1, #95	; 0x5f
    12d4:	5f74656b 	svcpl	0x0074656b
    12d8:	64616548 	strbtvs	r6, [r1], #-1352	; 0xfffffab8
    12dc:	54007265 	strpl	r7, [r0], #-613	; 0xfffffd9b
    12e0:	70736944 	rsbsvc	r6, r3, r4, asr #18
    12e4:	5f79616c 	svcpl	0x0079616c
    12e8:	506e6f4e 	rsbpl	r6, lr, lr, asr #30
    12ec:	6d617261 	sfmvs	f7, 2, [r1, #-388]!	; 0xfffffe7c
    12f0:	69727465 	ldmdbvs	r2!, {r0, r2, r5, r6, sl, ip, sp, lr}^
    12f4:	61505f63 	cmpvs	r0, r3, ror #30
    12f8:	74656b63 	strbtvc	r6, [r5], #-2915	; 0xfffff49d
    12fc:	69687400 	stmdbvs	r8!, {sl, ip, sp, lr}^
    1300:	552f0073 	strpl	r0, [pc, #-115]!	; 1295 <shift+0x1295>
    1304:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
    1308:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
    130c:	6a726574 	bvs	1c9a8e4 <__bss_end+0x1c911ac>
    1310:	65442f69 	strbvs	r2, [r4, #-3945]	; 0xfffff097
    1314:	6f746b73 	svcvs	0x00746b73
    1318:	41462f70 	hvcmi	25328	; 0x62f0
    131c:	614e2f56 	cmpvs	lr, r6, asr pc
    1320:	757a6176 	ldrbvc	r6, [sl, #-374]!	; 0xfffffe8a
    1324:	6963696a 	stmdbvs	r3!, {r1, r3, r5, r6, r8, fp, sp, lr}^
    1328:	2f534f2f 	svccs	0x00534f2f
    132c:	656d6573 	strbvs	r6, [sp, #-1395]!	; 0xfffffa8d
    1330:	61727473 	cmnvs	r2, r3, ror r4
    1334:	2d616b6c 	vstmdbcs	r1!, {d22-<overflow reg d75>}
    1338:	2d76696b 			; <UNDEFINED> instruction: 0x2d76696b
    133c:	732f736f 			; <UNDEFINED> instruction: 0x732f736f
    1340:	6372756f 	cmnvs	r2, #465567744	; 0x1bc00000
    1344:	732f7365 			; <UNDEFINED> instruction: 0x732f7365
    1348:	74756474 	ldrbtvc	r6, [r5], #-1140	; 0xfffffb8c
    134c:	2f736c69 	svccs	0x00736c69
    1350:	2f637273 	svccs	0x00637273
    1354:	64656c6f 	strbtvs	r6, [r5], #-3183	; 0xfffff391
    1358:	7070632e 	rsbsvc	r6, r0, lr, lsr #6
    135c:	454c4f00 	strbmi	r4, [ip, #-3840]	; 0xfffff100
    1360:	6f465f44 	svcvs	0x00465f44
    1364:	445f746e 	ldrbmi	r7, [pc], #-1134	; 136c <shift+0x136c>
    1368:	75616665 	strbvc	r6, [r1, #-1637]!	; 0xfffff99b
    136c:	7600746c 	strvc	r7, [r0], -ip, ror #8
    1370:	70696c66 	rsbvc	r6, r9, r6, ror #24
    1374:	69445400 	stmdbvs	r4, {sl, ip, lr}^
    1378:	616c7073 	smcvs	50947	; 0xc703
    137c:	72445f79 	subvc	r5, r4, #484	; 0x1e4
    1380:	505f7761 	subspl	r7, pc, r1, ror #14
    1384:	6c657869 	stclvs	8, cr7, [r5], #-420	; 0xfffffe5c
    1388:	7272415f 	rsbsvc	r4, r2, #-1073741801	; 0xc0000017
    138c:	505f7961 	subspl	r7, pc, r1, ror #18
    1390:	656b6361 	strbvs	r6, [fp, #-865]!	; 0xfffffc9f
    1394:	72440074 	subvc	r0, r4, #116	; 0x74
    1398:	505f7761 	subspl	r7, pc, r1, ror #14
    139c:	6c657869 	stclvs	8, cr7, [r5], #-420	; 0xfffffe5c
    13a0:	7272415f 	rsbsvc	r4, r2, #-1073741801	; 0xc0000017
    13a4:	545f7961 	ldrbpl	r7, [pc], #-2401	; 13ac <shift+0x13ac>
    13a8:	65525f6f 	ldrbvs	r5, [r2, #-3951]	; 0xfffff091
    13ac:	54007463 	strpl	r7, [r0], #-1123	; 0xfffffb9d
    13b0:	70736944 	rsbsvc	r6, r3, r4, asr #18
    13b4:	5f79616c 	svcpl	0x0079616c
    13b8:	65786950 	ldrbvs	r6, [r8, #-2384]!	; 0xfffff6b0
    13bc:	70535f6c 	subsvc	r5, r3, ip, ror #30
    13c0:	70006365 	andvc	r6, r0, r5, ror #6
    13c4:	00687461 	rsbeq	r7, r8, r1, ror #8
    13c8:	73694454 	cmnvc	r9, #84, 8	; 0x54000000
    13cc:	79616c70 	stmdbvc	r1!, {r4, r5, r6, sl, fp, sp, lr}^
    13d0:	7869505f 	stmdavc	r9!, {r0, r1, r2, r3, r4, r6, ip, lr}^
    13d4:	5f736c65 	svcpl	0x00736c65
    13d8:	525f6f54 	subspl	r6, pc, #84, 30	; 0x150
    13dc:	00746365 	rsbseq	r6, r4, r5, ror #6
    13e0:	72616843 	rsbvc	r6, r1, #4390912	; 0x430000
    13e4:	646e455f 	strbtvs	r4, [lr], #-1375	; 0xfffffaa1
    13e8:	61724400 	cmnvs	r2, r0, lsl #8
    13ec:	69505f77 	ldmdbvs	r0, {r0, r1, r2, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
    13f0:	5f6c6578 	svcpl	0x006c6578
    13f4:	61727241 	cmnvs	r2, r1, asr #4
    13f8:	6c460079 	mcrrvs	0, 7, r0, r6, cr9
    13fc:	435f7069 	cmpmi	pc, #105	; 0x69
    1400:	73726168 	cmnvc	r2, #104, 2
    1404:	69445400 	stmdbvs	r4, {sl, ip, lr}^
    1408:	616c7073 	smcvs	50947	; 0xc703
    140c:	6c435f79 	mcrrvs	15, 7, r5, r3, cr9
    1410:	5f726165 	svcpl	0x00726165
    1414:	6b636150 	blvs	18d995c <__bss_end+0x18d0224>
    1418:	43007465 	movwmi	r7, #1125	; 0x465
    141c:	5f726168 	svcpl	0x00726168
    1420:	74646957 	strbtvc	r6, [r4], #-2391	; 0xfffff6a9
    1424:	4c4f0068 	mcrrmi	0, 6, r0, pc, cr8
    1428:	465f4445 	ldrbmi	r4, [pc], -r5, asr #8
    142c:	00746e6f 	rsbseq	r6, r4, pc, ror #28
    1430:	7369444e 	cmnvc	r9, #1308622848	; 0x4e000000
    1434:	79616c70 	stmdbvc	r1!, {r4, r5, r6, sl, fp, sp, lr}^
    1438:	6d6f435f 	stclvs	3, cr4, [pc, #-380]!	; 12c4 <shift+0x12c4>
    143c:	646e616d 	strbtvs	r6, [lr], #-365	; 0xfffffe93
    1440:	72696600 	rsbvc	r6, r9, #0, 12
    1444:	63007473 	movwvs	r7, #1139	; 0x473
    1448:	7261656c 	rsbvc	r6, r1, #108, 10	; 0x1b000000
    144c:	00746553 	rsbseq	r6, r4, r3, asr r5
    1450:	314e5a5f 	cmpcc	lr, pc, asr sl
    1454:	4c4f4333 	mcrrmi	3, 3, r4, pc, cr3
    1458:	445f4445 	ldrbmi	r4, [pc], #-1093	; 1460 <shift+0x1460>
    145c:	6c707369 	ldclvs	3, cr7, [r0], #-420	; 0xfffffe5c
    1460:	32437961 	subcc	r7, r3, #1589248	; 0x184000
    1464:	634b5045 	movtvs	r5, #45125	; 0xb045
    1468:	6e697500 	cdpvs	5, 6, cr7, cr9, cr0, {0}
    146c:	745f3874 	ldrbvc	r3, [pc], #-2164	; 1474 <shift+0x1474>
    1470:	61684300 	cmnvs	r8, r0, lsl #6
    1474:	65485f72 	strbvs	r5, [r8, #-3954]	; 0xfffff08e
    1478:	74686769 	strbtvc	r6, [r8], #-1897	; 0xfffff897
    147c:	61656800 	cmnvs	r5, r0, lsl #16
    1480:	00726564 	rsbseq	r6, r2, r4, ror #10
    1484:	72616843 	rsbvc	r6, r1, #4390912	; 0x430000
    1488:	6765425f 			; <UNDEFINED> instruction: 0x6765425f
    148c:	5f006e69 	svcpl	0x00006e69
    1490:	33314e5a 	teqcc	r1, #1440	; 0x5a0
    1494:	454c4f43 	strbmi	r4, [ip, #-3907]	; 0xfffff0bd
    1498:	69445f44 	stmdbvs	r4, {r2, r6, r8, r9, sl, fp, ip, lr}^
    149c:	616c7073 	smcvs	50947	; 0xc703
    14a0:	45324479 	ldrmi	r4, [r2, #-1145]!	; 0xfffffb87
    14a4:	Address 0x00000000000014a4 is out of bounds.


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
  20:	8b040e42 	blhi	103930 <__bss_end+0xfa1f8>
  24:	0b0d4201 	bleq	350830 <__bss_end+0x3470f8>
  28:	420d0d62 	andmi	r0, sp, #6272	; 0x1880
  2c:	00000ecb 	andeq	r0, r0, fp, asr #29
  30:	0000001c 	andeq	r0, r0, ip, lsl r0
  34:	00000000 	andeq	r0, r0, r0
  38:	00008064 	andeq	r8, r0, r4, rrx
  3c:	00000040 	andeq	r0, r0, r0, asr #32
  40:	8b080e42 	blhi	203950 <__bss_end+0x1fa218>
  44:	42018e02 	andmi	r8, r1, #2, 28
  48:	5a040b0c 	bpl	102c80 <__bss_end+0xf9548>
  4c:	00080d0c 	andeq	r0, r8, ip, lsl #26
  50:	0000000c 	andeq	r0, r0, ip
  54:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
  58:	7c020001 	stcvc	0, cr0, [r2], {1}
  5c:	000d0c0e 	andeq	r0, sp, lr, lsl #24
  60:	0000001c 	andeq	r0, r0, ip, lsl r0
  64:	00000050 	andeq	r0, r0, r0, asr r0
  68:	000080a4 	andeq	r8, r0, r4, lsr #1
  6c:	00000038 	andeq	r0, r0, r8, lsr r0
  70:	8b040e42 	blhi	103980 <__bss_end+0xfa248>
  74:	0b0d4201 	bleq	350880 <__bss_end+0x347148>
  78:	420d0d54 	andmi	r0, sp, #84, 26	; 0x1500
  7c:	00000ecb 	andeq	r0, r0, fp, asr #29
  80:	0000001c 	andeq	r0, r0, ip, lsl r0
  84:	00000050 	andeq	r0, r0, r0, asr r0
  88:	000080dc 	ldrdeq	r8, [r0], -ip
  8c:	0000002c 	andeq	r0, r0, ip, lsr #32
  90:	8b040e42 	blhi	1039a0 <__bss_end+0xfa268>
  94:	0b0d4201 	bleq	3508a0 <__bss_end+0x347168>
  98:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
  9c:	00000ecb 	andeq	r0, r0, fp, asr #29
  a0:	0000001c 	andeq	r0, r0, ip, lsl r0
  a4:	00000050 	andeq	r0, r0, r0, asr r0
  a8:	00008108 	andeq	r8, r0, r8, lsl #2
  ac:	00000020 	andeq	r0, r0, r0, lsr #32
  b0:	8b040e42 	blhi	1039c0 <__bss_end+0xfa288>
  b4:	0b0d4201 	bleq	3508c0 <__bss_end+0x347188>
  b8:	420d0d48 	andmi	r0, sp, #72, 26	; 0x1200
  bc:	00000ecb 	andeq	r0, r0, fp, asr #29
  c0:	0000001c 	andeq	r0, r0, ip, lsl r0
  c4:	00000050 	andeq	r0, r0, r0, asr r0
  c8:	00008128 	andeq	r8, r0, r8, lsr #2
  cc:	00000018 	andeq	r0, r0, r8, lsl r0
  d0:	8b040e42 	blhi	1039e0 <__bss_end+0xfa2a8>
  d4:	0b0d4201 	bleq	3508e0 <__bss_end+0x3471a8>
  d8:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
  dc:	00000ecb 	andeq	r0, r0, fp, asr #29
  e0:	0000001c 	andeq	r0, r0, ip, lsl r0
  e4:	00000050 	andeq	r0, r0, r0, asr r0
  e8:	00008140 	andeq	r8, r0, r0, asr #2
  ec:	00000018 	andeq	r0, r0, r8, lsl r0
  f0:	8b040e42 	blhi	103a00 <__bss_end+0xfa2c8>
  f4:	0b0d4201 	bleq	350900 <__bss_end+0x3471c8>
  f8:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
  fc:	00000ecb 	andeq	r0, r0, fp, asr #29
 100:	0000001c 	andeq	r0, r0, ip, lsl r0
 104:	00000050 	andeq	r0, r0, r0, asr r0
 108:	00008158 	andeq	r8, r0, r8, asr r1
 10c:	00000018 	andeq	r0, r0, r8, lsl r0
 110:	8b040e42 	blhi	103a20 <__bss_end+0xfa2e8>
 114:	0b0d4201 	bleq	350920 <__bss_end+0x3471e8>
 118:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
 11c:	00000ecb 	andeq	r0, r0, fp, asr #29
 120:	00000014 	andeq	r0, r0, r4, lsl r0
 124:	00000050 	andeq	r0, r0, r0, asr r0
 128:	00008170 	andeq	r8, r0, r0, ror r1
 12c:	0000000c 	andeq	r0, r0, ip
 130:	8b040e42 	blhi	103a40 <__bss_end+0xfa308>
 134:	0b0d4201 	bleq	350940 <__bss_end+0x347208>
 138:	0000001c 	andeq	r0, r0, ip, lsl r0
 13c:	00000050 	andeq	r0, r0, r0, asr r0
 140:	0000817c 	andeq	r8, r0, ip, ror r1
 144:	00000058 	andeq	r0, r0, r8, asr r0
 148:	8b080e42 	blhi	203a58 <__bss_end+0x1fa320>
 14c:	42018e02 	andmi	r8, r1, #2, 28
 150:	62040b0c 	andvs	r0, r4, #12, 22	; 0x3000
 154:	00080d0c 	andeq	r0, r8, ip, lsl #26
 158:	0000001c 	andeq	r0, r0, ip, lsl r0
 15c:	00000050 	andeq	r0, r0, r0, asr r0
 160:	000081d4 	ldrdeq	r8, [r0], -r4
 164:	00000058 	andeq	r0, r0, r8, asr r0
 168:	8b080e42 	blhi	203a78 <__bss_end+0x1fa340>
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
 194:	0000010c 	andeq	r0, r0, ip, lsl #2
 198:	8b080e42 	blhi	203aa8 <__bss_end+0x1fa370>
 19c:	42018e02 	andmi	r8, r1, #2, 28
 1a0:	00040b0c 	andeq	r0, r4, ip, lsl #22
 1a4:	0000000c 	andeq	r0, r0, ip
 1a8:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 1ac:	7c020001 	stcvc	0, cr0, [r2], {1}
 1b0:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 1b4:	0000001c 	andeq	r0, r0, ip, lsl r0
 1b8:	000001a4 	andeq	r0, r0, r4, lsr #3
 1bc:	00008338 	andeq	r8, r0, r8, lsr r3
 1c0:	0000002c 	andeq	r0, r0, ip, lsr #32
 1c4:	8b040e42 	blhi	103ad4 <__bss_end+0xfa39c>
 1c8:	0b0d4201 	bleq	3509d4 <__bss_end+0x34729c>
 1cc:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
 1d0:	00000ecb 	andeq	r0, r0, fp, asr #29
 1d4:	0000001c 	andeq	r0, r0, ip, lsl r0
 1d8:	000001a4 	andeq	r0, r0, r4, lsr #3
 1dc:	00008364 	andeq	r8, r0, r4, ror #6
 1e0:	0000002c 	andeq	r0, r0, ip, lsr #32
 1e4:	8b040e42 	blhi	103af4 <__bss_end+0xfa3bc>
 1e8:	0b0d4201 	bleq	3509f4 <__bss_end+0x3472bc>
 1ec:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
 1f0:	00000ecb 	andeq	r0, r0, fp, asr #29
 1f4:	0000001c 	andeq	r0, r0, ip, lsl r0
 1f8:	000001a4 	andeq	r0, r0, r4, lsr #3
 1fc:	00008390 	muleq	r0, r0, r3
 200:	0000001c 	andeq	r0, r0, ip, lsl r0
 204:	8b040e42 	blhi	103b14 <__bss_end+0xfa3dc>
 208:	0b0d4201 	bleq	350a14 <__bss_end+0x3472dc>
 20c:	420d0d46 	andmi	r0, sp, #4480	; 0x1180
 210:	00000ecb 	andeq	r0, r0, fp, asr #29
 214:	0000001c 	andeq	r0, r0, ip, lsl r0
 218:	000001a4 	andeq	r0, r0, r4, lsr #3
 21c:	000083ac 	andeq	r8, r0, ip, lsr #7
 220:	00000044 	andeq	r0, r0, r4, asr #32
 224:	8b040e42 	blhi	103b34 <__bss_end+0xfa3fc>
 228:	0b0d4201 	bleq	350a34 <__bss_end+0x3472fc>
 22c:	420d0d5a 	andmi	r0, sp, #5760	; 0x1680
 230:	00000ecb 	andeq	r0, r0, fp, asr #29
 234:	0000001c 	andeq	r0, r0, ip, lsl r0
 238:	000001a4 	andeq	r0, r0, r4, lsr #3
 23c:	000083f0 	strdeq	r8, [r0], -r0
 240:	00000050 	andeq	r0, r0, r0, asr r0
 244:	8b040e42 	blhi	103b54 <__bss_end+0xfa41c>
 248:	0b0d4201 	bleq	350a54 <__bss_end+0x34731c>
 24c:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 250:	00000ecb 	andeq	r0, r0, fp, asr #29
 254:	0000001c 	andeq	r0, r0, ip, lsl r0
 258:	000001a4 	andeq	r0, r0, r4, lsr #3
 25c:	00008440 	andeq	r8, r0, r0, asr #8
 260:	00000050 	andeq	r0, r0, r0, asr r0
 264:	8b040e42 	blhi	103b74 <__bss_end+0xfa43c>
 268:	0b0d4201 	bleq	350a74 <__bss_end+0x34733c>
 26c:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 270:	00000ecb 	andeq	r0, r0, fp, asr #29
 274:	0000001c 	andeq	r0, r0, ip, lsl r0
 278:	000001a4 	andeq	r0, r0, r4, lsr #3
 27c:	00008490 	muleq	r0, r0, r4
 280:	0000002c 	andeq	r0, r0, ip, lsr #32
 284:	8b040e42 	blhi	103b94 <__bss_end+0xfa45c>
 288:	0b0d4201 	bleq	350a94 <__bss_end+0x34735c>
 28c:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
 290:	00000ecb 	andeq	r0, r0, fp, asr #29
 294:	0000001c 	andeq	r0, r0, ip, lsl r0
 298:	000001a4 	andeq	r0, r0, r4, lsr #3
 29c:	000084bc 			; <UNDEFINED> instruction: 0x000084bc
 2a0:	00000050 	andeq	r0, r0, r0, asr r0
 2a4:	8b040e42 	blhi	103bb4 <__bss_end+0xfa47c>
 2a8:	0b0d4201 	bleq	350ab4 <__bss_end+0x34737c>
 2ac:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 2b0:	00000ecb 	andeq	r0, r0, fp, asr #29
 2b4:	0000001c 	andeq	r0, r0, ip, lsl r0
 2b8:	000001a4 	andeq	r0, r0, r4, lsr #3
 2bc:	0000850c 	andeq	r8, r0, ip, lsl #10
 2c0:	00000044 	andeq	r0, r0, r4, asr #32
 2c4:	8b040e42 	blhi	103bd4 <__bss_end+0xfa49c>
 2c8:	0b0d4201 	bleq	350ad4 <__bss_end+0x34739c>
 2cc:	420d0d5a 	andmi	r0, sp, #5760	; 0x1680
 2d0:	00000ecb 	andeq	r0, r0, fp, asr #29
 2d4:	0000001c 	andeq	r0, r0, ip, lsl r0
 2d8:	000001a4 	andeq	r0, r0, r4, lsr #3
 2dc:	00008550 	andeq	r8, r0, r0, asr r5
 2e0:	00000050 	andeq	r0, r0, r0, asr r0
 2e4:	8b040e42 	blhi	103bf4 <__bss_end+0xfa4bc>
 2e8:	0b0d4201 	bleq	350af4 <__bss_end+0x3473bc>
 2ec:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 2f0:	00000ecb 	andeq	r0, r0, fp, asr #29
 2f4:	0000001c 	andeq	r0, r0, ip, lsl r0
 2f8:	000001a4 	andeq	r0, r0, r4, lsr #3
 2fc:	000085a0 	andeq	r8, r0, r0, lsr #11
 300:	00000054 	andeq	r0, r0, r4, asr r0
 304:	8b040e42 	blhi	103c14 <__bss_end+0xfa4dc>
 308:	0b0d4201 	bleq	350b14 <__bss_end+0x3473dc>
 30c:	420d0d62 	andmi	r0, sp, #6272	; 0x1880
 310:	00000ecb 	andeq	r0, r0, fp, asr #29
 314:	0000001c 	andeq	r0, r0, ip, lsl r0
 318:	000001a4 	andeq	r0, r0, r4, lsr #3
 31c:	000085f4 	strdeq	r8, [r0], -r4
 320:	0000003c 	andeq	r0, r0, ip, lsr r0
 324:	8b040e42 	blhi	103c34 <__bss_end+0xfa4fc>
 328:	0b0d4201 	bleq	350b34 <__bss_end+0x3473fc>
 32c:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 330:	00000ecb 	andeq	r0, r0, fp, asr #29
 334:	0000001c 	andeq	r0, r0, ip, lsl r0
 338:	000001a4 	andeq	r0, r0, r4, lsr #3
 33c:	00008630 	andeq	r8, r0, r0, lsr r6
 340:	0000003c 	andeq	r0, r0, ip, lsr r0
 344:	8b040e42 	blhi	103c54 <__bss_end+0xfa51c>
 348:	0b0d4201 	bleq	350b54 <__bss_end+0x34741c>
 34c:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 350:	00000ecb 	andeq	r0, r0, fp, asr #29
 354:	0000001c 	andeq	r0, r0, ip, lsl r0
 358:	000001a4 	andeq	r0, r0, r4, lsr #3
 35c:	0000866c 	andeq	r8, r0, ip, ror #12
 360:	0000003c 	andeq	r0, r0, ip, lsr r0
 364:	8b040e42 	blhi	103c74 <__bss_end+0xfa53c>
 368:	0b0d4201 	bleq	350b74 <__bss_end+0x34743c>
 36c:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 370:	00000ecb 	andeq	r0, r0, fp, asr #29
 374:	0000001c 	andeq	r0, r0, ip, lsl r0
 378:	000001a4 	andeq	r0, r0, r4, lsr #3
 37c:	000086a8 	andeq	r8, r0, r8, lsr #13
 380:	0000003c 	andeq	r0, r0, ip, lsr r0
 384:	8b040e42 	blhi	103c94 <__bss_end+0xfa55c>
 388:	0b0d4201 	bleq	350b94 <__bss_end+0x34745c>
 38c:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 390:	00000ecb 	andeq	r0, r0, fp, asr #29
 394:	0000001c 	andeq	r0, r0, ip, lsl r0
 398:	000001a4 	andeq	r0, r0, r4, lsr #3
 39c:	000086e4 	andeq	r8, r0, r4, ror #13
 3a0:	000000b0 	strheq	r0, [r0], -r0	; <UNPREDICTABLE>
 3a4:	8b080e42 	blhi	203cb4 <__bss_end+0x1fa57c>
 3a8:	42018e02 	andmi	r8, r1, #2, 28
 3ac:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 3b0:	080d0c50 	stmdaeq	sp, {r4, r6, sl, fp}
 3b4:	0000000c 	andeq	r0, r0, ip
 3b8:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 3bc:	7c020001 	stcvc	0, cr0, [r2], {1}
 3c0:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 3c4:	0000001c 	andeq	r0, r0, ip, lsl r0
 3c8:	000003b4 			; <UNDEFINED> instruction: 0x000003b4
 3cc:	00008794 	muleq	r0, r4, r7
 3d0:	00000174 	andeq	r0, r0, r4, ror r1
 3d4:	8b080e42 	blhi	203ce4 <__bss_end+0x1fa5ac>
 3d8:	42018e02 	andmi	r8, r1, #2, 28
 3dc:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 3e0:	080d0cb2 	stmdaeq	sp, {r1, r4, r5, r7, sl, fp}
 3e4:	0000001c 	andeq	r0, r0, ip, lsl r0
 3e8:	000003b4 			; <UNDEFINED> instruction: 0x000003b4
 3ec:	00008908 	andeq	r8, r0, r8, lsl #18
 3f0:	0000009c 	muleq	r0, ip, r0
 3f4:	8b040e42 	blhi	103d04 <__bss_end+0xfa5cc>
 3f8:	0b0d4201 	bleq	350c04 <__bss_end+0x3474cc>
 3fc:	0d0d4602 	stceq	6, cr4, [sp, #-8]
 400:	000ecb42 	andeq	ip, lr, r2, asr #22
 404:	0000001c 	andeq	r0, r0, ip, lsl r0
 408:	000003b4 			; <UNDEFINED> instruction: 0x000003b4
 40c:	000089a4 	andeq	r8, r0, r4, lsr #19
 410:	000000c0 	andeq	r0, r0, r0, asr #1
 414:	8b040e42 	blhi	103d24 <__bss_end+0xfa5ec>
 418:	0b0d4201 	bleq	350c24 <__bss_end+0x3474ec>
 41c:	0d0d5802 	stceq	8, cr5, [sp, #-8]
 420:	000ecb42 	andeq	ip, lr, r2, asr #22
 424:	0000001c 	andeq	r0, r0, ip, lsl r0
 428:	000003b4 			; <UNDEFINED> instruction: 0x000003b4
 42c:	00008a64 	andeq	r8, r0, r4, ror #20
 430:	000000ac 	andeq	r0, r0, ip, lsr #1
 434:	8b040e42 	blhi	103d44 <__bss_end+0xfa60c>
 438:	0b0d4201 	bleq	350c44 <__bss_end+0x34750c>
 43c:	0d0d4e02 	stceq	14, cr4, [sp, #-8]
 440:	000ecb42 	andeq	ip, lr, r2, asr #22
 444:	0000001c 	andeq	r0, r0, ip, lsl r0
 448:	000003b4 			; <UNDEFINED> instruction: 0x000003b4
 44c:	00008b10 	andeq	r8, r0, r0, lsl fp
 450:	00000054 	andeq	r0, r0, r4, asr r0
 454:	8b040e42 	blhi	103d64 <__bss_end+0xfa62c>
 458:	0b0d4201 	bleq	350c64 <__bss_end+0x34752c>
 45c:	420d0d62 	andmi	r0, sp, #6272	; 0x1880
 460:	00000ecb 	andeq	r0, r0, fp, asr #29
 464:	0000001c 	andeq	r0, r0, ip, lsl r0
 468:	000003b4 			; <UNDEFINED> instruction: 0x000003b4
 46c:	00008b64 	andeq	r8, r0, r4, ror #22
 470:	00000068 	andeq	r0, r0, r8, rrx
 474:	8b040e42 	blhi	103d84 <__bss_end+0xfa64c>
 478:	0b0d4201 	bleq	350c84 <__bss_end+0x34754c>
 47c:	420d0d6c 	andmi	r0, sp, #108, 26	; 0x1b00
 480:	00000ecb 	andeq	r0, r0, fp, asr #29
 484:	0000001c 	andeq	r0, r0, ip, lsl r0
 488:	000003b4 			; <UNDEFINED> instruction: 0x000003b4
 48c:	00008bcc 	andeq	r8, r0, ip, asr #23
 490:	00000080 	andeq	r0, r0, r0, lsl #1
 494:	8b040e42 	blhi	103da4 <__bss_end+0xfa66c>
 498:	0b0d4201 	bleq	350ca4 <__bss_end+0x34756c>
 49c:	420d0d78 	andmi	r0, sp, #120, 26	; 0x1e00
 4a0:	00000ecb 	andeq	r0, r0, fp, asr #29
 4a4:	0000000c 	andeq	r0, r0, ip
 4a8:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 4ac:	7c020001 	stcvc	0, cr0, [r2], {1}
 4b0:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 4b4:	0000001c 	andeq	r0, r0, ip, lsl r0
 4b8:	000004a4 	andeq	r0, r0, r4, lsr #9
 4bc:	00008c4c 	andeq	r8, r0, ip, asr #24
 4c0:	00000068 	andeq	r0, r0, r8, rrx
 4c4:	8b080e42 	blhi	203dd4 <__bss_end+0x1fa69c>
 4c8:	42018e02 	andmi	r8, r1, #2, 28
 4cc:	6e040b0c 	vmlavs.f64	d0, d4, d12
 4d0:	00080d0c 	andeq	r0, r8, ip, lsl #26
 4d4:	0000001c 	andeq	r0, r0, ip, lsl r0
 4d8:	000004a4 	andeq	r0, r0, r4, lsr #9
 4dc:	00008cb4 			; <UNDEFINED> instruction: 0x00008cb4
 4e0:	0000004c 	andeq	r0, r0, ip, asr #32
 4e4:	8b080e42 	blhi	203df4 <__bss_end+0x1fa6bc>
 4e8:	42018e02 	andmi	r8, r1, #2, 28
 4ec:	60040b0c 	andvs	r0, r4, ip, lsl #22
 4f0:	00080d0c 	andeq	r0, r8, ip, lsl #26
 4f4:	0000001c 	andeq	r0, r0, ip, lsl r0
 4f8:	000004a4 	andeq	r0, r0, r4, lsr #9
 4fc:	00008d00 	andeq	r8, r0, r0, lsl #26
 500:	00000028 	andeq	r0, r0, r8, lsr #32
 504:	8b040e42 	blhi	103e14 <__bss_end+0xfa6dc>
 508:	0b0d4201 	bleq	350d14 <__bss_end+0x3475dc>
 50c:	420d0d4c 	andmi	r0, sp, #76, 26	; 0x1300
 510:	00000ecb 	andeq	r0, r0, fp, asr #29
 514:	0000001c 	andeq	r0, r0, ip, lsl r0
 518:	000004a4 	andeq	r0, r0, r4, lsr #9
 51c:	00008d28 	andeq	r8, r0, r8, lsr #26
 520:	0000007c 	andeq	r0, r0, ip, ror r0
 524:	8b080e42 	blhi	203e34 <__bss_end+0x1fa6fc>
 528:	42018e02 	andmi	r8, r1, #2, 28
 52c:	78040b0c 	stmdavc	r4, {r2, r3, r8, r9, fp}
 530:	00080d0c 	andeq	r0, r8, ip, lsl #26
 534:	0000001c 	andeq	r0, r0, ip, lsl r0
 538:	000004a4 	andeq	r0, r0, r4, lsr #9
 53c:	00008da4 	andeq	r8, r0, r4, lsr #27
 540:	000000ec 	andeq	r0, r0, ip, ror #1
 544:	8b080e42 	blhi	203e54 <__bss_end+0x1fa71c>
 548:	42018e02 	andmi	r8, r1, #2, 28
 54c:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 550:	080d0c70 	stmdaeq	sp, {r4, r5, r6, sl, fp}
 554:	0000001c 	andeq	r0, r0, ip, lsl r0
 558:	000004a4 	andeq	r0, r0, r4, lsr #9
 55c:	00008e90 	muleq	r0, r0, lr
 560:	00000168 	andeq	r0, r0, r8, ror #2
 564:	8b080e42 	blhi	203e74 <__bss_end+0x1fa73c>
 568:	42018e02 	andmi	r8, r1, #2, 28
 56c:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 570:	080d0cac 	stmdaeq	sp, {r2, r3, r5, r7, sl, fp}
 574:	0000001c 	andeq	r0, r0, ip, lsl r0
 578:	000004a4 	andeq	r0, r0, r4, lsr #9
 57c:	00008ff8 	strdeq	r8, [r0], -r8	; <UNPREDICTABLE>
 580:	00000058 	andeq	r0, r0, r8, asr r0
 584:	8b080e42 	blhi	203e94 <__bss_end+0x1fa75c>
 588:	42018e02 	andmi	r8, r1, #2, 28
 58c:	66040b0c 	strvs	r0, [r4], -ip, lsl #22
 590:	00080d0c 	andeq	r0, r8, ip, lsl #26
 594:	0000001c 	andeq	r0, r0, ip, lsl r0
 598:	000004a4 	andeq	r0, r0, r4, lsr #9
 59c:	00009050 	andeq	r9, r0, r0, asr r0
 5a0:	000000b0 	strheq	r0, [r0], -r0	; <UNPREDICTABLE>
 5a4:	8b080e42 	blhi	203eb4 <__bss_end+0x1fa77c>
 5a8:	42018e02 	andmi	r8, r1, #2, 28
 5ac:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 5b0:	080d0c52 	stmdaeq	sp, {r1, r4, r6, sl, fp}
 5b4:	0000000c 	andeq	r0, r0, ip
 5b8:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 5bc:	7c010001 	stcvc	0, cr0, [r1], {1}
 5c0:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 5c4:	0000000c 	andeq	r0, r0, ip
 5c8:	000005b4 			; <UNDEFINED> instruction: 0x000005b4
 5cc:	00009100 	andeq	r9, r0, r0, lsl #2
 5d0:	000001ec 	andeq	r0, r0, ip, ror #3
