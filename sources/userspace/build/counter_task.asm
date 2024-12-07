
./counter_task:     file format elf32-littlearm


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
    805c:	00008fb0 			; <UNDEFINED> instruction: 0x00008fb0
    8060:	00008fc0 	andeq	r8, r0, r0, asr #31

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
    81cc:	00008fad 	andeq	r8, r0, sp, lsr #31
    81d0:	00008fad 	andeq	r8, r0, sp, lsr #31

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
    8224:	00008fad 	andeq	r8, r0, sp, lsr #31
    8228:	00008fad 	andeq	r8, r0, sp, lsr #31

0000822c <main>:
main():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/counter_task/main.cpp:17
 *  - vzestupne pokud je prepinac 1 v poloze "zapnuto", jinak sestupne
 *  - rychle pokud je prepinac 2 v poloze "zapnuto", jinak pomalu
 **/

int main(int argc, char** argv)
{
    822c:	e92d4800 	push	{fp, lr}
    8230:	e28db004 	add	fp, sp, #4
    8234:	e24dd020 	sub	sp, sp, #32
    8238:	e50b0020 	str	r0, [fp, #-32]	; 0xffffffe0
    823c:	e50b1024 	str	r1, [fp, #-36]	; 0xffffffdc
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/counter_task/main.cpp:18
	uint32_t display_file = open("DEV:segd", NFile_Open_Mode::Write_Only);
    8240:	e3a01001 	mov	r1, #1
    8244:	e59f0164 	ldr	r0, [pc, #356]	; 83b0 <main+0x184>
    8248:	eb000079 	bl	8434 <_Z4openPKc15NFile_Open_Mode>
    824c:	e50b000c 	str	r0, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/counter_task/main.cpp:19
	uint32_t switch1_file = open("DEV:gpio/4", NFile_Open_Mode::Read_Only);
    8250:	e3a01000 	mov	r1, #0
    8254:	e59f0158 	ldr	r0, [pc, #344]	; 83b4 <main+0x188>
    8258:	eb000075 	bl	8434 <_Z4openPKc15NFile_Open_Mode>
    825c:	e50b0010 	str	r0, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/counter_task/main.cpp:20
	uint32_t switch2_file = open("DEV:gpio/17", NFile_Open_Mode::Read_Only);
    8260:	e3a01000 	mov	r1, #0
    8264:	e59f014c 	ldr	r0, [pc, #332]	; 83b8 <main+0x18c>
    8268:	eb000071 	bl	8434 <_Z4openPKc15NFile_Open_Mode>
    826c:	e50b0014 	str	r0, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/counter_task/main.cpp:22

	unsigned int counter = 0;
    8270:	e3a03000 	mov	r3, #0
    8274:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/counter_task/main.cpp:23
	bool fast = false;
    8278:	e3a03000 	mov	r3, #0
    827c:	e54b3015 	strb	r3, [fp, #-21]	; 0xffffffeb
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/counter_task/main.cpp:24
	bool ascending = true;
    8280:	e3a03001 	mov	r3, #1
    8284:	e54b3016 	strb	r3, [fp, #-22]	; 0xffffffea
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/counter_task/main.cpp:26

	set_task_deadline(fast ? 0x1000 : 0x2800);
    8288:	e55b3015 	ldrb	r3, [fp, #-21]	; 0xffffffeb
    828c:	e3530000 	cmp	r3, #0
    8290:	0a000001 	beq	829c <main+0x70>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/counter_task/main.cpp:26 (discriminator 1)
    8294:	e3a03a01 	mov	r3, #4096	; 0x1000
    8298:	ea000000 	b	82a0 <main+0x74>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/counter_task/main.cpp:26 (discriminator 2)
    829c:	e3a03b0a 	mov	r3, #10240	; 0x2800
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/counter_task/main.cpp:26 (discriminator 4)
    82a0:	e1a00003 	mov	r0, r3
    82a4:	eb000112 	bl	86f4 <_Z17set_task_deadlinej>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/counter_task/main.cpp:30

	while (true)
	{
		char tmp = '0';
    82a8:	e3a03030 	mov	r3, #48	; 0x30
    82ac:	e54b3017 	strb	r3, [fp, #-23]	; 0xffffffe9
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/counter_task/main.cpp:32

		read(switch1_file, &tmp, 1);
    82b0:	e24b3017 	sub	r3, fp, #23
    82b4:	e3a02001 	mov	r2, #1
    82b8:	e1a01003 	mov	r1, r3
    82bc:	e51b0010 	ldr	r0, [fp, #-16]
    82c0:	eb00006c 	bl	8478 <_Z4readjPcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/counter_task/main.cpp:33
		ascending = (tmp == '1');
    82c4:	e55b3017 	ldrb	r3, [fp, #-23]	; 0xffffffe9
    82c8:	e3530031 	cmp	r3, #49	; 0x31
    82cc:	03a03001 	moveq	r3, #1
    82d0:	13a03000 	movne	r3, #0
    82d4:	e54b3016 	strb	r3, [fp, #-22]	; 0xffffffea
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/counter_task/main.cpp:35

		read(switch2_file, &tmp, 1);
    82d8:	e24b3017 	sub	r3, fp, #23
    82dc:	e3a02001 	mov	r2, #1
    82e0:	e1a01003 	mov	r1, r3
    82e4:	e51b0014 	ldr	r0, [fp, #-20]	; 0xffffffec
    82e8:	eb000062 	bl	8478 <_Z4readjPcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/counter_task/main.cpp:36
		fast = (tmp == '1');
    82ec:	e55b3017 	ldrb	r3, [fp, #-23]	; 0xffffffe9
    82f0:	e3530031 	cmp	r3, #49	; 0x31
    82f4:	03a03001 	moveq	r3, #1
    82f8:	13a03000 	movne	r3, #0
    82fc:	e54b3015 	strb	r3, [fp, #-21]	; 0xffffffeb
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/counter_task/main.cpp:38

		if (ascending)
    8300:	e55b3016 	ldrb	r3, [fp, #-22]	; 0xffffffea
    8304:	e3530000 	cmp	r3, #0
    8308:	0a000003 	beq	831c <main+0xf0>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/counter_task/main.cpp:39
			counter++;
    830c:	e51b3008 	ldr	r3, [fp, #-8]
    8310:	e2833001 	add	r3, r3, #1
    8314:	e50b3008 	str	r3, [fp, #-8]
    8318:	ea000002 	b	8328 <main+0xfc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/counter_task/main.cpp:41
		else
			counter--;
    831c:	e51b3008 	ldr	r3, [fp, #-8]
    8320:	e2433001 	sub	r3, r3, #1
    8324:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/counter_task/main.cpp:43

		tmp = '0' + (counter % 10);
    8328:	e51b1008 	ldr	r1, [fp, #-8]
    832c:	e59f3088 	ldr	r3, [pc, #136]	; 83bc <main+0x190>
    8330:	e0832193 	umull	r2, r3, r3, r1
    8334:	e1a021a3 	lsr	r2, r3, #3
    8338:	e1a03002 	mov	r3, r2
    833c:	e1a03103 	lsl	r3, r3, #2
    8340:	e0833002 	add	r3, r3, r2
    8344:	e1a03083 	lsl	r3, r3, #1
    8348:	e0412003 	sub	r2, r1, r3
    834c:	e6ef3072 	uxtb	r3, r2
    8350:	e2833030 	add	r3, r3, #48	; 0x30
    8354:	e6ef3073 	uxtb	r3, r3
    8358:	e54b3017 	strb	r3, [fp, #-23]	; 0xffffffe9
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/counter_task/main.cpp:44
		write(display_file, &tmp, 1);
    835c:	e24b3017 	sub	r3, fp, #23
    8360:	e3a02001 	mov	r2, #1
    8364:	e1a01003 	mov	r1, r3
    8368:	e51b000c 	ldr	r0, [fp, #-12]
    836c:	eb000055 	bl	84c8 <_Z5writejPKcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/counter_task/main.cpp:46

		sleep(fast ? 0x400 : 0x600, fast ? 0x1000 : 0x2800);
    8370:	e55b3015 	ldrb	r3, [fp, #-21]	; 0xffffffeb
    8374:	e3530000 	cmp	r3, #0
    8378:	0a000001 	beq	8384 <main+0x158>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/counter_task/main.cpp:46 (discriminator 1)
    837c:	e3a02b01 	mov	r2, #1024	; 0x400
    8380:	ea000000 	b	8388 <main+0x15c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/counter_task/main.cpp:46 (discriminator 2)
    8384:	e3a02c06 	mov	r2, #1536	; 0x600
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/counter_task/main.cpp:46 (discriminator 4)
    8388:	e55b3015 	ldrb	r3, [fp, #-21]	; 0xffffffeb
    838c:	e3530000 	cmp	r3, #0
    8390:	0a000001 	beq	839c <main+0x170>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/counter_task/main.cpp:46 (discriminator 5)
    8394:	e3a03a01 	mov	r3, #4096	; 0x1000
    8398:	ea000000 	b	83a0 <main+0x174>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/counter_task/main.cpp:46 (discriminator 6)
    839c:	e3a03b0a 	mov	r3, #10240	; 0x2800
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/counter_task/main.cpp:46 (discriminator 8)
    83a0:	e1a01003 	mov	r1, r3
    83a4:	e1a00002 	mov	r0, r2
    83a8:	eb00009e 	bl	8628 <_Z5sleepjj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/counter_task/main.cpp:47 (discriminator 8)
	}
    83ac:	eaffffbd 	b	82a8 <main+0x7c>
    83b0:	00008f40 	andeq	r8, r0, r0, asr #30
    83b4:	00008f4c 	andeq	r8, r0, ip, asr #30
    83b8:	00008f58 	andeq	r8, r0, r8, asr pc
    83bc:	cccccccd 	stclgt	12, cr12, [ip], {205}	; 0xcd

000083c0 <_Z6getpidv>:
_Z6getpidv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:5
#include <stdfile.h>
#include <stdstring.h>

uint32_t getpid()
{
    83c0:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    83c4:	e28db000 	add	fp, sp, #0
    83c8:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:8
    uint32_t pid;

    asm volatile("swi 0");
    83cc:	ef000000 	svc	0x00000000
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:9
    asm volatile("mov %0, r0" : "=r" (pid));
    83d0:	e1a03000 	mov	r3, r0
    83d4:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:11

    return pid;
    83d8:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:12
}
    83dc:	e1a00003 	mov	r0, r3
    83e0:	e28bd000 	add	sp, fp, #0
    83e4:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    83e8:	e12fff1e 	bx	lr

000083ec <_Z9terminatei>:
_Z9terminatei():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:15

void terminate(int exitcode)
{
    83ec:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    83f0:	e28db000 	add	fp, sp, #0
    83f4:	e24dd00c 	sub	sp, sp, #12
    83f8:	e50b0008 	str	r0, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:16
    asm volatile("mov r0, %0" : : "r" (exitcode));
    83fc:	e51b3008 	ldr	r3, [fp, #-8]
    8400:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:17
    asm volatile("swi 1");
    8404:	ef000001 	svc	0x00000001
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:18
}
    8408:	e320f000 	nop	{0}
    840c:	e28bd000 	add	sp, fp, #0
    8410:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8414:	e12fff1e 	bx	lr

00008418 <_Z11sched_yieldv>:
_Z11sched_yieldv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:21

void sched_yield()
{
    8418:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    841c:	e28db000 	add	fp, sp, #0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:22
    asm volatile("swi 2");
    8420:	ef000002 	svc	0x00000002
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:23
}
    8424:	e320f000 	nop	{0}
    8428:	e28bd000 	add	sp, fp, #0
    842c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8430:	e12fff1e 	bx	lr

00008434 <_Z4openPKc15NFile_Open_Mode>:
_Z4openPKc15NFile_Open_Mode():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:26

uint32_t open(const char* filename, NFile_Open_Mode mode)
{
    8434:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8438:	e28db000 	add	fp, sp, #0
    843c:	e24dd014 	sub	sp, sp, #20
    8440:	e50b0010 	str	r0, [fp, #-16]
    8444:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:29
    uint32_t file;

    asm volatile("mov r0, %0" : : "r" (filename));
    8448:	e51b3010 	ldr	r3, [fp, #-16]
    844c:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:30
    asm volatile("mov r1, %0" : : "r" (mode));
    8450:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8454:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:31
    asm volatile("swi 64");
    8458:	ef000040 	svc	0x00000040
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:32
    asm volatile("mov %0, r0" : "=r" (file));
    845c:	e1a03000 	mov	r3, r0
    8460:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:34

    return file;
    8464:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:35
}
    8468:	e1a00003 	mov	r0, r3
    846c:	e28bd000 	add	sp, fp, #0
    8470:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8474:	e12fff1e 	bx	lr

00008478 <_Z4readjPcj>:
_Z4readjPcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:38

uint32_t read(uint32_t file, char* const buffer, uint32_t size)
{
    8478:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    847c:	e28db000 	add	fp, sp, #0
    8480:	e24dd01c 	sub	sp, sp, #28
    8484:	e50b0010 	str	r0, [fp, #-16]
    8488:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    848c:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:41
    uint32_t rdnum;

    asm volatile("mov r0, %0" : : "r" (file));
    8490:	e51b3010 	ldr	r3, [fp, #-16]
    8494:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:42
    asm volatile("mov r1, %0" : : "r" (buffer));
    8498:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    849c:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:43
    asm volatile("mov r2, %0" : : "r" (size));
    84a0:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    84a4:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:44
    asm volatile("swi 65");
    84a8:	ef000041 	svc	0x00000041
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:45
    asm volatile("mov %0, r0" : "=r" (rdnum));
    84ac:	e1a03000 	mov	r3, r0
    84b0:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:47

    return rdnum;
    84b4:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:48
}
    84b8:	e1a00003 	mov	r0, r3
    84bc:	e28bd000 	add	sp, fp, #0
    84c0:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    84c4:	e12fff1e 	bx	lr

000084c8 <_Z5writejPKcj>:
_Z5writejPKcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:51

uint32_t write(uint32_t file, const char* buffer, uint32_t size)
{
    84c8:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    84cc:	e28db000 	add	fp, sp, #0
    84d0:	e24dd01c 	sub	sp, sp, #28
    84d4:	e50b0010 	str	r0, [fp, #-16]
    84d8:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    84dc:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:54
    uint32_t wrnum;

    asm volatile("mov r0, %0" : : "r" (file));
    84e0:	e51b3010 	ldr	r3, [fp, #-16]
    84e4:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:55
    asm volatile("mov r1, %0" : : "r" (buffer));
    84e8:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    84ec:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:56
    asm volatile("mov r2, %0" : : "r" (size));
    84f0:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    84f4:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:57
    asm volatile("swi 66");
    84f8:	ef000042 	svc	0x00000042
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:58
    asm volatile("mov %0, r0" : "=r" (wrnum));
    84fc:	e1a03000 	mov	r3, r0
    8500:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:60

    return wrnum;
    8504:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:61
}
    8508:	e1a00003 	mov	r0, r3
    850c:	e28bd000 	add	sp, fp, #0
    8510:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8514:	e12fff1e 	bx	lr

00008518 <_Z5closej>:
_Z5closej():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:64

void close(uint32_t file)
{
    8518:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    851c:	e28db000 	add	fp, sp, #0
    8520:	e24dd00c 	sub	sp, sp, #12
    8524:	e50b0008 	str	r0, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:65
    asm volatile("mov r0, %0" : : "r" (file));
    8528:	e51b3008 	ldr	r3, [fp, #-8]
    852c:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:66
    asm volatile("swi 67");
    8530:	ef000043 	svc	0x00000043
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:67
}
    8534:	e320f000 	nop	{0}
    8538:	e28bd000 	add	sp, fp, #0
    853c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8540:	e12fff1e 	bx	lr

00008544 <_Z5ioctlj16NIOCtl_OperationPv>:
_Z5ioctlj16NIOCtl_OperationPv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:70

uint32_t ioctl(uint32_t file, NIOCtl_Operation operation, void* param)
{
    8544:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8548:	e28db000 	add	fp, sp, #0
    854c:	e24dd01c 	sub	sp, sp, #28
    8550:	e50b0010 	str	r0, [fp, #-16]
    8554:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8558:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:73
    uint32_t retcode;

    asm volatile("mov r0, %0" : : "r" (file));
    855c:	e51b3010 	ldr	r3, [fp, #-16]
    8560:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:74
    asm volatile("mov r1, %0" : : "r" (operation));
    8564:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8568:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:75
    asm volatile("mov r2, %0" : : "r" (param));
    856c:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8570:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:76
    asm volatile("swi 68");
    8574:	ef000044 	svc	0x00000044
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:77
    asm volatile("mov %0, r0" : "=r" (retcode));
    8578:	e1a03000 	mov	r3, r0
    857c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:79

    return retcode;
    8580:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:80
}
    8584:	e1a00003 	mov	r0, r3
    8588:	e28bd000 	add	sp, fp, #0
    858c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8590:	e12fff1e 	bx	lr

00008594 <_Z6notifyjj>:
_Z6notifyjj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:83

uint32_t notify(uint32_t file, uint32_t count)
{
    8594:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8598:	e28db000 	add	fp, sp, #0
    859c:	e24dd014 	sub	sp, sp, #20
    85a0:	e50b0010 	str	r0, [fp, #-16]
    85a4:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:86
    uint32_t retcnt;

    asm volatile("mov r0, %0" : : "r" (file));
    85a8:	e51b3010 	ldr	r3, [fp, #-16]
    85ac:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:87
    asm volatile("mov r1, %0" : : "r" (count));
    85b0:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    85b4:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:88
    asm volatile("swi 69");
    85b8:	ef000045 	svc	0x00000045
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:89
    asm volatile("mov %0, r0" : "=r" (retcnt));
    85bc:	e1a03000 	mov	r3, r0
    85c0:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:91

    return retcnt;
    85c4:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:92
}
    85c8:	e1a00003 	mov	r0, r3
    85cc:	e28bd000 	add	sp, fp, #0
    85d0:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    85d4:	e12fff1e 	bx	lr

000085d8 <_Z4waitjjj>:
_Z4waitjjj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:95

NSWI_Result_Code wait(uint32_t file, uint32_t count, uint32_t notified_deadline)
{
    85d8:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    85dc:	e28db000 	add	fp, sp, #0
    85e0:	e24dd01c 	sub	sp, sp, #28
    85e4:	e50b0010 	str	r0, [fp, #-16]
    85e8:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    85ec:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:98
    NSWI_Result_Code retcode;

    asm volatile("mov r0, %0" : : "r" (file));
    85f0:	e51b3010 	ldr	r3, [fp, #-16]
    85f4:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:99
    asm volatile("mov r1, %0" : : "r" (count));
    85f8:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    85fc:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:100
    asm volatile("mov r2, %0" : : "r" (notified_deadline));
    8600:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8604:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:101
    asm volatile("swi 70");
    8608:	ef000046 	svc	0x00000046
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:102
    asm volatile("mov %0, r0" : "=r" (retcode));
    860c:	e1a03000 	mov	r3, r0
    8610:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:104

    return retcode;
    8614:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:105
}
    8618:	e1a00003 	mov	r0, r3
    861c:	e28bd000 	add	sp, fp, #0
    8620:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8624:	e12fff1e 	bx	lr

00008628 <_Z5sleepjj>:
_Z5sleepjj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:108

bool sleep(uint32_t ticks, uint32_t notified_deadline)
{
    8628:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    862c:	e28db000 	add	fp, sp, #0
    8630:	e24dd014 	sub	sp, sp, #20
    8634:	e50b0010 	str	r0, [fp, #-16]
    8638:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:111
    uint32_t retcode;

    asm volatile("mov r0, %0" : : "r" (ticks));
    863c:	e51b3010 	ldr	r3, [fp, #-16]
    8640:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:112
    asm volatile("mov r1, %0" : : "r" (notified_deadline));
    8644:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8648:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:113
    asm volatile("swi 3");
    864c:	ef000003 	svc	0x00000003
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:114
    asm volatile("mov %0, r0" : "=r" (retcode));
    8650:	e1a03000 	mov	r3, r0
    8654:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:116

    return retcode;
    8658:	e51b3008 	ldr	r3, [fp, #-8]
    865c:	e3530000 	cmp	r3, #0
    8660:	13a03001 	movne	r3, #1
    8664:	03a03000 	moveq	r3, #0
    8668:	e6ef3073 	uxtb	r3, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:117
}
    866c:	e1a00003 	mov	r0, r3
    8670:	e28bd000 	add	sp, fp, #0
    8674:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8678:	e12fff1e 	bx	lr

0000867c <_Z24get_active_process_countv>:
_Z24get_active_process_countv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:120

uint32_t get_active_process_count()
{
    867c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8680:	e28db000 	add	fp, sp, #0
    8684:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:121
    const NGet_Sched_Info_Type req = NGet_Sched_Info_Type::Active_Process_Count;
    8688:	e3a03000 	mov	r3, #0
    868c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:124
    uint32_t retval;

    asm volatile("mov r0, %0" : : "r" (req));
    8690:	e3a03000 	mov	r3, #0
    8694:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:125
    asm volatile("mov r1, %0" : : "r" (&retval));
    8698:	e24b300c 	sub	r3, fp, #12
    869c:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:126
    asm volatile("swi 4");
    86a0:	ef000004 	svc	0x00000004
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:128

    return retval;
    86a4:	e51b300c 	ldr	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:129
}
    86a8:	e1a00003 	mov	r0, r3
    86ac:	e28bd000 	add	sp, fp, #0
    86b0:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    86b4:	e12fff1e 	bx	lr

000086b8 <_Z14get_tick_countv>:
_Z14get_tick_countv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:132

uint32_t get_tick_count()
{
    86b8:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    86bc:	e28db000 	add	fp, sp, #0
    86c0:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:133
    const NGet_Sched_Info_Type req = NGet_Sched_Info_Type::Tick_Count;
    86c4:	e3a03001 	mov	r3, #1
    86c8:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:136
    uint32_t retval;

    asm volatile("mov r0, %0" : : "r" (req));
    86cc:	e3a03001 	mov	r3, #1
    86d0:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:137
    asm volatile("mov r1, %0" : : "r" (&retval));
    86d4:	e24b300c 	sub	r3, fp, #12
    86d8:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:138
    asm volatile("swi 4");
    86dc:	ef000004 	svc	0x00000004
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:140

    return retval;
    86e0:	e51b300c 	ldr	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:141
}
    86e4:	e1a00003 	mov	r0, r3
    86e8:	e28bd000 	add	sp, fp, #0
    86ec:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    86f0:	e12fff1e 	bx	lr

000086f4 <_Z17set_task_deadlinej>:
_Z17set_task_deadlinej():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:144

void set_task_deadline(uint32_t tick_count_required)
{
    86f4:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    86f8:	e28db000 	add	fp, sp, #0
    86fc:	e24dd014 	sub	sp, sp, #20
    8700:	e50b0010 	str	r0, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:145
    const NDeadline_Subservice req = NDeadline_Subservice::Set_Relative;
    8704:	e3a03000 	mov	r3, #0
    8708:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:147

    asm volatile("mov r0, %0" : : "r" (req));
    870c:	e3a03000 	mov	r3, #0
    8710:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:148
    asm volatile("mov r1, %0" : : "r" (&tick_count_required));
    8714:	e24b3010 	sub	r3, fp, #16
    8718:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:149
    asm volatile("swi 5");
    871c:	ef000005 	svc	0x00000005
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:150
}
    8720:	e320f000 	nop	{0}
    8724:	e28bd000 	add	sp, fp, #0
    8728:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    872c:	e12fff1e 	bx	lr

00008730 <_Z26get_task_ticks_to_deadlinev>:
_Z26get_task_ticks_to_deadlinev():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:153

uint32_t get_task_ticks_to_deadline()
{
    8730:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8734:	e28db000 	add	fp, sp, #0
    8738:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:154
    const NDeadline_Subservice req = NDeadline_Subservice::Get_Remaining;
    873c:	e3a03001 	mov	r3, #1
    8740:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:157
    uint32_t ticks;

    asm volatile("mov r0, %0" : : "r" (req));
    8744:	e3a03001 	mov	r3, #1
    8748:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:158
    asm volatile("mov r1, %0" : : "r" (&ticks));
    874c:	e24b300c 	sub	r3, fp, #12
    8750:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:159
    asm volatile("swi 5");
    8754:	ef000005 	svc	0x00000005
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:161

    return ticks;
    8758:	e51b300c 	ldr	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:162
}
    875c:	e1a00003 	mov	r0, r3
    8760:	e28bd000 	add	sp, fp, #0
    8764:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8768:	e12fff1e 	bx	lr

0000876c <_Z4pipePKcj>:
_Z4pipePKcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:167

const char Pipe_File_Prefix[] = "SYS:pipe/";

uint32_t pipe(const char* name, uint32_t buf_size)
{
    876c:	e92d4800 	push	{fp, lr}
    8770:	e28db004 	add	fp, sp, #4
    8774:	e24dd050 	sub	sp, sp, #80	; 0x50
    8778:	e50b0050 	str	r0, [fp, #-80]	; 0xffffffb0
    877c:	e50b1054 	str	r1, [fp, #-84]	; 0xffffffac
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:169
    char fname[64];
    strncpy(fname, Pipe_File_Prefix, sizeof(Pipe_File_Prefix));
    8780:	e24b3048 	sub	r3, fp, #72	; 0x48
    8784:	e3a0200a 	mov	r2, #10
    8788:	e59f1088 	ldr	r1, [pc, #136]	; 8818 <_Z4pipePKcj+0xac>
    878c:	e1a00003 	mov	r0, r3
    8790:	eb0000a5 	bl	8a2c <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:170
    strncpy(fname + sizeof(Pipe_File_Prefix), name, sizeof(fname) - sizeof(Pipe_File_Prefix) - 1);
    8794:	e24b3048 	sub	r3, fp, #72	; 0x48
    8798:	e283300a 	add	r3, r3, #10
    879c:	e3a02035 	mov	r2, #53	; 0x35
    87a0:	e51b1050 	ldr	r1, [fp, #-80]	; 0xffffffb0
    87a4:	e1a00003 	mov	r0, r3
    87a8:	eb00009f 	bl	8a2c <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:172

    int ncur = sizeof(Pipe_File_Prefix) + strlen(name);
    87ac:	e51b0050 	ldr	r0, [fp, #-80]	; 0xffffffb0
    87b0:	eb0000f8 	bl	8b98 <_Z6strlenPKc>
    87b4:	e1a03000 	mov	r3, r0
    87b8:	e283300a 	add	r3, r3, #10
    87bc:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:174

    fname[ncur++] = '#';
    87c0:	e51b3008 	ldr	r3, [fp, #-8]
    87c4:	e2832001 	add	r2, r3, #1
    87c8:	e50b2008 	str	r2, [fp, #-8]
    87cc:	e2433004 	sub	r3, r3, #4
    87d0:	e083300b 	add	r3, r3, fp
    87d4:	e3a02023 	mov	r2, #35	; 0x23
    87d8:	e5432044 	strb	r2, [r3, #-68]	; 0xffffffbc
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:176

    itoa(buf_size, &fname[ncur], 10);
    87dc:	e24b2048 	sub	r2, fp, #72	; 0x48
    87e0:	e51b3008 	ldr	r3, [fp, #-8]
    87e4:	e0823003 	add	r3, r2, r3
    87e8:	e3a0200a 	mov	r2, #10
    87ec:	e1a01003 	mov	r1, r3
    87f0:	e51b0054 	ldr	r0, [fp, #-84]	; 0xffffffac
    87f4:	eb000008 	bl	881c <_Z4itoajPcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:178

    return open(fname, NFile_Open_Mode::Read_Write);
    87f8:	e24b3048 	sub	r3, fp, #72	; 0x48
    87fc:	e3a01002 	mov	r1, #2
    8800:	e1a00003 	mov	r0, r3
    8804:	ebffff0a 	bl	8434 <_Z4openPKc15NFile_Open_Mode>
    8808:	e1a03000 	mov	r3, r0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:179
}
    880c:	e1a00003 	mov	r0, r3
    8810:	e24bd004 	sub	sp, fp, #4
    8814:	e8bd8800 	pop	{fp, pc}
    8818:	00008f90 	muleq	r0, r0, pc	; <UNPREDICTABLE>

0000881c <_Z4itoajPcj>:
_Z4itoajPcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:9
{
    const char CharConvArr[] = "0123456789ABCDEF";
}

void itoa(unsigned int input, char* output, unsigned int base)
{
    881c:	e92d4800 	push	{fp, lr}
    8820:	e28db004 	add	fp, sp, #4
    8824:	e24dd020 	sub	sp, sp, #32
    8828:	e50b0018 	str	r0, [fp, #-24]	; 0xffffffe8
    882c:	e50b101c 	str	r1, [fp, #-28]	; 0xffffffe4
    8830:	e50b2020 	str	r2, [fp, #-32]	; 0xffffffe0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:10
	int i = 0;
    8834:	e3a03000 	mov	r3, #0
    8838:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:12

	while (input > 0)
    883c:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8840:	e3530000 	cmp	r3, #0
    8844:	0a000014 	beq	889c <_Z4itoajPcj+0x80>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:14
	{
		output[i] = CharConvArr[input % base];
    8848:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    884c:	e51b1020 	ldr	r1, [fp, #-32]	; 0xffffffe0
    8850:	e1a00003 	mov	r0, r3
    8854:	eb000199 	bl	8ec0 <__aeabi_uidivmod>
    8858:	e1a03001 	mov	r3, r1
    885c:	e1a01003 	mov	r1, r3
    8860:	e51b3008 	ldr	r3, [fp, #-8]
    8864:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    8868:	e0823003 	add	r3, r2, r3
    886c:	e59f2118 	ldr	r2, [pc, #280]	; 898c <_Z4itoajPcj+0x170>
    8870:	e7d22001 	ldrb	r2, [r2, r1]
    8874:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:15
		input /= base;
    8878:	e51b1020 	ldr	r1, [fp, #-32]	; 0xffffffe0
    887c:	e51b0018 	ldr	r0, [fp, #-24]	; 0xffffffe8
    8880:	eb000113 	bl	8cd4 <__udivsi3>
    8884:	e1a03000 	mov	r3, r0
    8888:	e50b3018 	str	r3, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:16
		i++;
    888c:	e51b3008 	ldr	r3, [fp, #-8]
    8890:	e2833001 	add	r3, r3, #1
    8894:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:12
	while (input > 0)
    8898:	eaffffe7 	b	883c <_Z4itoajPcj+0x20>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:19
	}

    if (i == 0)
    889c:	e51b3008 	ldr	r3, [fp, #-8]
    88a0:	e3530000 	cmp	r3, #0
    88a4:	1a000007 	bne	88c8 <_Z4itoajPcj+0xac>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:21
    {
        output[i] = CharConvArr[0];
    88a8:	e51b3008 	ldr	r3, [fp, #-8]
    88ac:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    88b0:	e0823003 	add	r3, r2, r3
    88b4:	e3a02030 	mov	r2, #48	; 0x30
    88b8:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:22
        i++;
    88bc:	e51b3008 	ldr	r3, [fp, #-8]
    88c0:	e2833001 	add	r3, r3, #1
    88c4:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:25
    }

	output[i] = '\0';
    88c8:	e51b3008 	ldr	r3, [fp, #-8]
    88cc:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    88d0:	e0823003 	add	r3, r2, r3
    88d4:	e3a02000 	mov	r2, #0
    88d8:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:26
	i--;
    88dc:	e51b3008 	ldr	r3, [fp, #-8]
    88e0:	e2433001 	sub	r3, r3, #1
    88e4:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:28

	for (int j = 0; j <= i/2; j++)
    88e8:	e3a03000 	mov	r3, #0
    88ec:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:28 (discriminator 3)
    88f0:	e51b3008 	ldr	r3, [fp, #-8]
    88f4:	e1a02fa3 	lsr	r2, r3, #31
    88f8:	e0823003 	add	r3, r2, r3
    88fc:	e1a030c3 	asr	r3, r3, #1
    8900:	e1a02003 	mov	r2, r3
    8904:	e51b300c 	ldr	r3, [fp, #-12]
    8908:	e1530002 	cmp	r3, r2
    890c:	ca00001b 	bgt	8980 <_Z4itoajPcj+0x164>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:30 (discriminator 2)
	{
		char c = output[i - j];
    8910:	e51b2008 	ldr	r2, [fp, #-8]
    8914:	e51b300c 	ldr	r3, [fp, #-12]
    8918:	e0423003 	sub	r3, r2, r3
    891c:	e1a02003 	mov	r2, r3
    8920:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    8924:	e0833002 	add	r3, r3, r2
    8928:	e5d33000 	ldrb	r3, [r3]
    892c:	e54b300d 	strb	r3, [fp, #-13]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:31 (discriminator 2)
		output[i - j] = output[j];
    8930:	e51b300c 	ldr	r3, [fp, #-12]
    8934:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    8938:	e0822003 	add	r2, r2, r3
    893c:	e51b1008 	ldr	r1, [fp, #-8]
    8940:	e51b300c 	ldr	r3, [fp, #-12]
    8944:	e0413003 	sub	r3, r1, r3
    8948:	e1a01003 	mov	r1, r3
    894c:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    8950:	e0833001 	add	r3, r3, r1
    8954:	e5d22000 	ldrb	r2, [r2]
    8958:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:32 (discriminator 2)
		output[j] = c;
    895c:	e51b300c 	ldr	r3, [fp, #-12]
    8960:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    8964:	e0823003 	add	r3, r2, r3
    8968:	e55b200d 	ldrb	r2, [fp, #-13]
    896c:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:28 (discriminator 2)
	for (int j = 0; j <= i/2; j++)
    8970:	e51b300c 	ldr	r3, [fp, #-12]
    8974:	e2833001 	add	r3, r3, #1
    8978:	e50b300c 	str	r3, [fp, #-12]
    897c:	eaffffdb 	b	88f0 <_Z4itoajPcj+0xd4>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:34
	}
}
    8980:	e320f000 	nop	{0}
    8984:	e24bd004 	sub	sp, fp, #4
    8988:	e8bd8800 	pop	{fp, pc}
    898c:	00008f9c 	muleq	r0, ip, pc	; <UNPREDICTABLE>

00008990 <_Z4atoiPKc>:
_Z4atoiPKc():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:37

int atoi(const char* input)
{
    8990:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8994:	e28db000 	add	fp, sp, #0
    8998:	e24dd014 	sub	sp, sp, #20
    899c:	e50b0010 	str	r0, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:38
	int output = 0;
    89a0:	e3a03000 	mov	r3, #0
    89a4:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:40

	while (*input != '\0')
    89a8:	e51b3010 	ldr	r3, [fp, #-16]
    89ac:	e5d33000 	ldrb	r3, [r3]
    89b0:	e3530000 	cmp	r3, #0
    89b4:	0a000017 	beq	8a18 <_Z4atoiPKc+0x88>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:42
	{
		output *= 10;
    89b8:	e51b2008 	ldr	r2, [fp, #-8]
    89bc:	e1a03002 	mov	r3, r2
    89c0:	e1a03103 	lsl	r3, r3, #2
    89c4:	e0833002 	add	r3, r3, r2
    89c8:	e1a03083 	lsl	r3, r3, #1
    89cc:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:43
		if (*input > '9' || *input < '0')
    89d0:	e51b3010 	ldr	r3, [fp, #-16]
    89d4:	e5d33000 	ldrb	r3, [r3]
    89d8:	e3530039 	cmp	r3, #57	; 0x39
    89dc:	8a00000d 	bhi	8a18 <_Z4atoiPKc+0x88>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:43 (discriminator 1)
    89e0:	e51b3010 	ldr	r3, [fp, #-16]
    89e4:	e5d33000 	ldrb	r3, [r3]
    89e8:	e353002f 	cmp	r3, #47	; 0x2f
    89ec:	9a000009 	bls	8a18 <_Z4atoiPKc+0x88>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:46
			break;

		output += *input - '0';
    89f0:	e51b3010 	ldr	r3, [fp, #-16]
    89f4:	e5d33000 	ldrb	r3, [r3]
    89f8:	e2433030 	sub	r3, r3, #48	; 0x30
    89fc:	e51b2008 	ldr	r2, [fp, #-8]
    8a00:	e0823003 	add	r3, r2, r3
    8a04:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:48

		input++;
    8a08:	e51b3010 	ldr	r3, [fp, #-16]
    8a0c:	e2833001 	add	r3, r3, #1
    8a10:	e50b3010 	str	r3, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:40
	while (*input != '\0')
    8a14:	eaffffe3 	b	89a8 <_Z4atoiPKc+0x18>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:51
	}

	return output;
    8a18:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:52
}
    8a1c:	e1a00003 	mov	r0, r3
    8a20:	e28bd000 	add	sp, fp, #0
    8a24:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8a28:	e12fff1e 	bx	lr

00008a2c <_Z7strncpyPcPKci>:
_Z7strncpyPcPKci():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:55

char* strncpy(char* dest, const char *src, int num)
{
    8a2c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8a30:	e28db000 	add	fp, sp, #0
    8a34:	e24dd01c 	sub	sp, sp, #28
    8a38:	e50b0010 	str	r0, [fp, #-16]
    8a3c:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8a40:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:58
	int i;

	for (i = 0; i < num && src[i] != '\0'; i++)
    8a44:	e3a03000 	mov	r3, #0
    8a48:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:58 (discriminator 4)
    8a4c:	e51b2008 	ldr	r2, [fp, #-8]
    8a50:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8a54:	e1520003 	cmp	r2, r3
    8a58:	aa000011 	bge	8aa4 <_Z7strncpyPcPKci+0x78>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:58 (discriminator 2)
    8a5c:	e51b3008 	ldr	r3, [fp, #-8]
    8a60:	e51b2014 	ldr	r2, [fp, #-20]	; 0xffffffec
    8a64:	e0823003 	add	r3, r2, r3
    8a68:	e5d33000 	ldrb	r3, [r3]
    8a6c:	e3530000 	cmp	r3, #0
    8a70:	0a00000b 	beq	8aa4 <_Z7strncpyPcPKci+0x78>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:59 (discriminator 3)
		dest[i] = src[i];
    8a74:	e51b3008 	ldr	r3, [fp, #-8]
    8a78:	e51b2014 	ldr	r2, [fp, #-20]	; 0xffffffec
    8a7c:	e0822003 	add	r2, r2, r3
    8a80:	e51b3008 	ldr	r3, [fp, #-8]
    8a84:	e51b1010 	ldr	r1, [fp, #-16]
    8a88:	e0813003 	add	r3, r1, r3
    8a8c:	e5d22000 	ldrb	r2, [r2]
    8a90:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:58 (discriminator 3)
	for (i = 0; i < num && src[i] != '\0'; i++)
    8a94:	e51b3008 	ldr	r3, [fp, #-8]
    8a98:	e2833001 	add	r3, r3, #1
    8a9c:	e50b3008 	str	r3, [fp, #-8]
    8aa0:	eaffffe9 	b	8a4c <_Z7strncpyPcPKci+0x20>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:60 (discriminator 2)
	for (; i < num; i++)
    8aa4:	e51b2008 	ldr	r2, [fp, #-8]
    8aa8:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8aac:	e1520003 	cmp	r2, r3
    8ab0:	aa000008 	bge	8ad8 <_Z7strncpyPcPKci+0xac>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:61 (discriminator 1)
		dest[i] = '\0';
    8ab4:	e51b3008 	ldr	r3, [fp, #-8]
    8ab8:	e51b2010 	ldr	r2, [fp, #-16]
    8abc:	e0823003 	add	r3, r2, r3
    8ac0:	e3a02000 	mov	r2, #0
    8ac4:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:60 (discriminator 1)
	for (; i < num; i++)
    8ac8:	e51b3008 	ldr	r3, [fp, #-8]
    8acc:	e2833001 	add	r3, r3, #1
    8ad0:	e50b3008 	str	r3, [fp, #-8]
    8ad4:	eafffff2 	b	8aa4 <_Z7strncpyPcPKci+0x78>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:63

   return dest;
    8ad8:	e51b3010 	ldr	r3, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:64
}
    8adc:	e1a00003 	mov	r0, r3
    8ae0:	e28bd000 	add	sp, fp, #0
    8ae4:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8ae8:	e12fff1e 	bx	lr

00008aec <_Z7strncmpPKcS0_i>:
_Z7strncmpPKcS0_i():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:67

int strncmp(const char *s1, const char *s2, int num)
{
    8aec:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8af0:	e28db000 	add	fp, sp, #0
    8af4:	e24dd01c 	sub	sp, sp, #28
    8af8:	e50b0010 	str	r0, [fp, #-16]
    8afc:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8b00:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:69
	unsigned char u1, u2;
  	while (num-- > 0)
    8b04:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8b08:	e2432001 	sub	r2, r3, #1
    8b0c:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
    8b10:	e3530000 	cmp	r3, #0
    8b14:	c3a03001 	movgt	r3, #1
    8b18:	d3a03000 	movle	r3, #0
    8b1c:	e6ef3073 	uxtb	r3, r3
    8b20:	e3530000 	cmp	r3, #0
    8b24:	0a000016 	beq	8b84 <_Z7strncmpPKcS0_i+0x98>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:71
    {
      	u1 = (unsigned char) *s1++;
    8b28:	e51b3010 	ldr	r3, [fp, #-16]
    8b2c:	e2832001 	add	r2, r3, #1
    8b30:	e50b2010 	str	r2, [fp, #-16]
    8b34:	e5d33000 	ldrb	r3, [r3]
    8b38:	e54b3005 	strb	r3, [fp, #-5]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:72
     	u2 = (unsigned char) *s2++;
    8b3c:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8b40:	e2832001 	add	r2, r3, #1
    8b44:	e50b2014 	str	r2, [fp, #-20]	; 0xffffffec
    8b48:	e5d33000 	ldrb	r3, [r3]
    8b4c:	e54b3006 	strb	r3, [fp, #-6]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:73
      	if (u1 != u2)
    8b50:	e55b2005 	ldrb	r2, [fp, #-5]
    8b54:	e55b3006 	ldrb	r3, [fp, #-6]
    8b58:	e1520003 	cmp	r2, r3
    8b5c:	0a000003 	beq	8b70 <_Z7strncmpPKcS0_i+0x84>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:74
        	return u1 - u2;
    8b60:	e55b2005 	ldrb	r2, [fp, #-5]
    8b64:	e55b3006 	ldrb	r3, [fp, #-6]
    8b68:	e0423003 	sub	r3, r2, r3
    8b6c:	ea000005 	b	8b88 <_Z7strncmpPKcS0_i+0x9c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:75
      	if (u1 == '\0')
    8b70:	e55b3005 	ldrb	r3, [fp, #-5]
    8b74:	e3530000 	cmp	r3, #0
    8b78:	1affffe1 	bne	8b04 <_Z7strncmpPKcS0_i+0x18>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:76
        	return 0;
    8b7c:	e3a03000 	mov	r3, #0
    8b80:	ea000000 	b	8b88 <_Z7strncmpPKcS0_i+0x9c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:79
    }

  	return 0;
    8b84:	e3a03000 	mov	r3, #0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:80
}
    8b88:	e1a00003 	mov	r0, r3
    8b8c:	e28bd000 	add	sp, fp, #0
    8b90:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8b94:	e12fff1e 	bx	lr

00008b98 <_Z6strlenPKc>:
_Z6strlenPKc():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:83

int strlen(const char* s)
{
    8b98:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8b9c:	e28db000 	add	fp, sp, #0
    8ba0:	e24dd014 	sub	sp, sp, #20
    8ba4:	e50b0010 	str	r0, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:84
	int i = 0;
    8ba8:	e3a03000 	mov	r3, #0
    8bac:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:86

	while (s[i] != '\0')
    8bb0:	e51b3008 	ldr	r3, [fp, #-8]
    8bb4:	e51b2010 	ldr	r2, [fp, #-16]
    8bb8:	e0823003 	add	r3, r2, r3
    8bbc:	e5d33000 	ldrb	r3, [r3]
    8bc0:	e3530000 	cmp	r3, #0
    8bc4:	0a000003 	beq	8bd8 <_Z6strlenPKc+0x40>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:87
		i++;
    8bc8:	e51b3008 	ldr	r3, [fp, #-8]
    8bcc:	e2833001 	add	r3, r3, #1
    8bd0:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:86
	while (s[i] != '\0')
    8bd4:	eafffff5 	b	8bb0 <_Z6strlenPKc+0x18>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:89

	return i;
    8bd8:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:90
}
    8bdc:	e1a00003 	mov	r0, r3
    8be0:	e28bd000 	add	sp, fp, #0
    8be4:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8be8:	e12fff1e 	bx	lr

00008bec <_Z5bzeroPvi>:
_Z5bzeroPvi():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:93

void bzero(void* memory, int length)
{
    8bec:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8bf0:	e28db000 	add	fp, sp, #0
    8bf4:	e24dd014 	sub	sp, sp, #20
    8bf8:	e50b0010 	str	r0, [fp, #-16]
    8bfc:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:94
	char* mem = reinterpret_cast<char*>(memory);
    8c00:	e51b3010 	ldr	r3, [fp, #-16]
    8c04:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:96

	for (int i = 0; i < length; i++)
    8c08:	e3a03000 	mov	r3, #0
    8c0c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:96 (discriminator 3)
    8c10:	e51b2008 	ldr	r2, [fp, #-8]
    8c14:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8c18:	e1520003 	cmp	r2, r3
    8c1c:	aa000008 	bge	8c44 <_Z5bzeroPvi+0x58>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:97 (discriminator 2)
		mem[i] = 0;
    8c20:	e51b3008 	ldr	r3, [fp, #-8]
    8c24:	e51b200c 	ldr	r2, [fp, #-12]
    8c28:	e0823003 	add	r3, r2, r3
    8c2c:	e3a02000 	mov	r2, #0
    8c30:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:96 (discriminator 2)
	for (int i = 0; i < length; i++)
    8c34:	e51b3008 	ldr	r3, [fp, #-8]
    8c38:	e2833001 	add	r3, r3, #1
    8c3c:	e50b3008 	str	r3, [fp, #-8]
    8c40:	eafffff2 	b	8c10 <_Z5bzeroPvi+0x24>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:98
}
    8c44:	e320f000 	nop	{0}
    8c48:	e28bd000 	add	sp, fp, #0
    8c4c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8c50:	e12fff1e 	bx	lr

00008c54 <_Z6memcpyPKvPvi>:
_Z6memcpyPKvPvi():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:101

void memcpy(const void* src, void* dst, int num)
{
    8c54:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8c58:	e28db000 	add	fp, sp, #0
    8c5c:	e24dd024 	sub	sp, sp, #36	; 0x24
    8c60:	e50b0018 	str	r0, [fp, #-24]	; 0xffffffe8
    8c64:	e50b101c 	str	r1, [fp, #-28]	; 0xffffffe4
    8c68:	e50b2020 	str	r2, [fp, #-32]	; 0xffffffe0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:102
	const char* memsrc = reinterpret_cast<const char*>(src);
    8c6c:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8c70:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:103
	char* memdst = reinterpret_cast<char*>(dst);
    8c74:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    8c78:	e50b3010 	str	r3, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:105

	for (int i = 0; i < num; i++)
    8c7c:	e3a03000 	mov	r3, #0
    8c80:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:105 (discriminator 3)
    8c84:	e51b2008 	ldr	r2, [fp, #-8]
    8c88:	e51b3020 	ldr	r3, [fp, #-32]	; 0xffffffe0
    8c8c:	e1520003 	cmp	r2, r3
    8c90:	aa00000b 	bge	8cc4 <_Z6memcpyPKvPvi+0x70>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:106 (discriminator 2)
		memdst[i] = memsrc[i];
    8c94:	e51b3008 	ldr	r3, [fp, #-8]
    8c98:	e51b200c 	ldr	r2, [fp, #-12]
    8c9c:	e0822003 	add	r2, r2, r3
    8ca0:	e51b3008 	ldr	r3, [fp, #-8]
    8ca4:	e51b1010 	ldr	r1, [fp, #-16]
    8ca8:	e0813003 	add	r3, r1, r3
    8cac:	e5d22000 	ldrb	r2, [r2]
    8cb0:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:105 (discriminator 2)
	for (int i = 0; i < num; i++)
    8cb4:	e51b3008 	ldr	r3, [fp, #-8]
    8cb8:	e2833001 	add	r3, r3, #1
    8cbc:	e50b3008 	str	r3, [fp, #-8]
    8cc0:	eaffffef 	b	8c84 <_Z6memcpyPKvPvi+0x30>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:107
}
    8cc4:	e320f000 	nop	{0}
    8cc8:	e28bd000 	add	sp, fp, #0
    8ccc:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8cd0:	e12fff1e 	bx	lr

00008cd4 <__udivsi3>:
__udivsi3():
    8cd4:	e2512001 	subs	r2, r1, #1
    8cd8:	012fff1e 	bxeq	lr
    8cdc:	3a000074 	bcc	8eb4 <__udivsi3+0x1e0>
    8ce0:	e1500001 	cmp	r0, r1
    8ce4:	9a00006b 	bls	8e98 <__udivsi3+0x1c4>
    8ce8:	e1110002 	tst	r1, r2
    8cec:	0a00006c 	beq	8ea4 <__udivsi3+0x1d0>
    8cf0:	e16f3f10 	clz	r3, r0
    8cf4:	e16f2f11 	clz	r2, r1
    8cf8:	e0423003 	sub	r3, r2, r3
    8cfc:	e273301f 	rsbs	r3, r3, #31
    8d00:	10833083 	addne	r3, r3, r3, lsl #1
    8d04:	e3a02000 	mov	r2, #0
    8d08:	108ff103 	addne	pc, pc, r3, lsl #2
    8d0c:	e1a00000 	nop			; (mov r0, r0)
    8d10:	e1500f81 	cmp	r0, r1, lsl #31
    8d14:	e0a22002 	adc	r2, r2, r2
    8d18:	20400f81 	subcs	r0, r0, r1, lsl #31
    8d1c:	e1500f01 	cmp	r0, r1, lsl #30
    8d20:	e0a22002 	adc	r2, r2, r2
    8d24:	20400f01 	subcs	r0, r0, r1, lsl #30
    8d28:	e1500e81 	cmp	r0, r1, lsl #29
    8d2c:	e0a22002 	adc	r2, r2, r2
    8d30:	20400e81 	subcs	r0, r0, r1, lsl #29
    8d34:	e1500e01 	cmp	r0, r1, lsl #28
    8d38:	e0a22002 	adc	r2, r2, r2
    8d3c:	20400e01 	subcs	r0, r0, r1, lsl #28
    8d40:	e1500d81 	cmp	r0, r1, lsl #27
    8d44:	e0a22002 	adc	r2, r2, r2
    8d48:	20400d81 	subcs	r0, r0, r1, lsl #27
    8d4c:	e1500d01 	cmp	r0, r1, lsl #26
    8d50:	e0a22002 	adc	r2, r2, r2
    8d54:	20400d01 	subcs	r0, r0, r1, lsl #26
    8d58:	e1500c81 	cmp	r0, r1, lsl #25
    8d5c:	e0a22002 	adc	r2, r2, r2
    8d60:	20400c81 	subcs	r0, r0, r1, lsl #25
    8d64:	e1500c01 	cmp	r0, r1, lsl #24
    8d68:	e0a22002 	adc	r2, r2, r2
    8d6c:	20400c01 	subcs	r0, r0, r1, lsl #24
    8d70:	e1500b81 	cmp	r0, r1, lsl #23
    8d74:	e0a22002 	adc	r2, r2, r2
    8d78:	20400b81 	subcs	r0, r0, r1, lsl #23
    8d7c:	e1500b01 	cmp	r0, r1, lsl #22
    8d80:	e0a22002 	adc	r2, r2, r2
    8d84:	20400b01 	subcs	r0, r0, r1, lsl #22
    8d88:	e1500a81 	cmp	r0, r1, lsl #21
    8d8c:	e0a22002 	adc	r2, r2, r2
    8d90:	20400a81 	subcs	r0, r0, r1, lsl #21
    8d94:	e1500a01 	cmp	r0, r1, lsl #20
    8d98:	e0a22002 	adc	r2, r2, r2
    8d9c:	20400a01 	subcs	r0, r0, r1, lsl #20
    8da0:	e1500981 	cmp	r0, r1, lsl #19
    8da4:	e0a22002 	adc	r2, r2, r2
    8da8:	20400981 	subcs	r0, r0, r1, lsl #19
    8dac:	e1500901 	cmp	r0, r1, lsl #18
    8db0:	e0a22002 	adc	r2, r2, r2
    8db4:	20400901 	subcs	r0, r0, r1, lsl #18
    8db8:	e1500881 	cmp	r0, r1, lsl #17
    8dbc:	e0a22002 	adc	r2, r2, r2
    8dc0:	20400881 	subcs	r0, r0, r1, lsl #17
    8dc4:	e1500801 	cmp	r0, r1, lsl #16
    8dc8:	e0a22002 	adc	r2, r2, r2
    8dcc:	20400801 	subcs	r0, r0, r1, lsl #16
    8dd0:	e1500781 	cmp	r0, r1, lsl #15
    8dd4:	e0a22002 	adc	r2, r2, r2
    8dd8:	20400781 	subcs	r0, r0, r1, lsl #15
    8ddc:	e1500701 	cmp	r0, r1, lsl #14
    8de0:	e0a22002 	adc	r2, r2, r2
    8de4:	20400701 	subcs	r0, r0, r1, lsl #14
    8de8:	e1500681 	cmp	r0, r1, lsl #13
    8dec:	e0a22002 	adc	r2, r2, r2
    8df0:	20400681 	subcs	r0, r0, r1, lsl #13
    8df4:	e1500601 	cmp	r0, r1, lsl #12
    8df8:	e0a22002 	adc	r2, r2, r2
    8dfc:	20400601 	subcs	r0, r0, r1, lsl #12
    8e00:	e1500581 	cmp	r0, r1, lsl #11
    8e04:	e0a22002 	adc	r2, r2, r2
    8e08:	20400581 	subcs	r0, r0, r1, lsl #11
    8e0c:	e1500501 	cmp	r0, r1, lsl #10
    8e10:	e0a22002 	adc	r2, r2, r2
    8e14:	20400501 	subcs	r0, r0, r1, lsl #10
    8e18:	e1500481 	cmp	r0, r1, lsl #9
    8e1c:	e0a22002 	adc	r2, r2, r2
    8e20:	20400481 	subcs	r0, r0, r1, lsl #9
    8e24:	e1500401 	cmp	r0, r1, lsl #8
    8e28:	e0a22002 	adc	r2, r2, r2
    8e2c:	20400401 	subcs	r0, r0, r1, lsl #8
    8e30:	e1500381 	cmp	r0, r1, lsl #7
    8e34:	e0a22002 	adc	r2, r2, r2
    8e38:	20400381 	subcs	r0, r0, r1, lsl #7
    8e3c:	e1500301 	cmp	r0, r1, lsl #6
    8e40:	e0a22002 	adc	r2, r2, r2
    8e44:	20400301 	subcs	r0, r0, r1, lsl #6
    8e48:	e1500281 	cmp	r0, r1, lsl #5
    8e4c:	e0a22002 	adc	r2, r2, r2
    8e50:	20400281 	subcs	r0, r0, r1, lsl #5
    8e54:	e1500201 	cmp	r0, r1, lsl #4
    8e58:	e0a22002 	adc	r2, r2, r2
    8e5c:	20400201 	subcs	r0, r0, r1, lsl #4
    8e60:	e1500181 	cmp	r0, r1, lsl #3
    8e64:	e0a22002 	adc	r2, r2, r2
    8e68:	20400181 	subcs	r0, r0, r1, lsl #3
    8e6c:	e1500101 	cmp	r0, r1, lsl #2
    8e70:	e0a22002 	adc	r2, r2, r2
    8e74:	20400101 	subcs	r0, r0, r1, lsl #2
    8e78:	e1500081 	cmp	r0, r1, lsl #1
    8e7c:	e0a22002 	adc	r2, r2, r2
    8e80:	20400081 	subcs	r0, r0, r1, lsl #1
    8e84:	e1500001 	cmp	r0, r1
    8e88:	e0a22002 	adc	r2, r2, r2
    8e8c:	20400001 	subcs	r0, r0, r1
    8e90:	e1a00002 	mov	r0, r2
    8e94:	e12fff1e 	bx	lr
    8e98:	03a00001 	moveq	r0, #1
    8e9c:	13a00000 	movne	r0, #0
    8ea0:	e12fff1e 	bx	lr
    8ea4:	e16f2f11 	clz	r2, r1
    8ea8:	e262201f 	rsb	r2, r2, #31
    8eac:	e1a00230 	lsr	r0, r0, r2
    8eb0:	e12fff1e 	bx	lr
    8eb4:	e3500000 	cmp	r0, #0
    8eb8:	13e00000 	mvnne	r0, #0
    8ebc:	ea000007 	b	8ee0 <__aeabi_idiv0>

00008ec0 <__aeabi_uidivmod>:
__aeabi_uidivmod():
    8ec0:	e3510000 	cmp	r1, #0
    8ec4:	0afffffa 	beq	8eb4 <__udivsi3+0x1e0>
    8ec8:	e92d4003 	push	{r0, r1, lr}
    8ecc:	ebffff80 	bl	8cd4 <__udivsi3>
    8ed0:	e8bd4006 	pop	{r1, r2, lr}
    8ed4:	e0030092 	mul	r3, r2, r0
    8ed8:	e0411003 	sub	r1, r1, r3
    8edc:	e12fff1e 	bx	lr

00008ee0 <__aeabi_idiv0>:
__aeabi_ldiv0():
    8ee0:	e12fff1e 	bx	lr

Disassembly of section .rodata:

00008ee4 <_ZL13Lock_Unlocked>:
    8ee4:	00000000 	andeq	r0, r0, r0

00008ee8 <_ZL11Lock_Locked>:
    8ee8:	00000001 	andeq	r0, r0, r1

00008eec <_ZL21MaxFSDriverNameLength>:
    8eec:	00000010 	andeq	r0, r0, r0, lsl r0

00008ef0 <_ZL17MaxFilenameLength>:
    8ef0:	00000010 	andeq	r0, r0, r0, lsl r0

00008ef4 <_ZL13MaxPathLength>:
    8ef4:	00000080 	andeq	r0, r0, r0, lsl #1

00008ef8 <_ZL18NoFilesystemDriver>:
    8ef8:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008efc <_ZL9NotifyAll>:
    8efc:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008f00 <_ZL24Max_Process_Opened_Files>:
    8f00:	00000010 	andeq	r0, r0, r0, lsl r0

00008f04 <_ZL10Indefinite>:
    8f04:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008f08 <_ZL18Deadline_Unchanged>:
    8f08:	fffffffe 			; <UNDEFINED> instruction: 0xfffffffe

00008f0c <_ZL14Invalid_Handle>:
    8f0c:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008f10 <_ZN3halL18Default_Clock_RateE>:
    8f10:	0ee6b280 	cdpeq	2, 14, cr11, cr6, cr0, {4}

00008f14 <_ZN3halL15Peripheral_BaseE>:
    8f14:	20000000 	andcs	r0, r0, r0

00008f18 <_ZN3halL9GPIO_BaseE>:
    8f18:	20200000 	eorcs	r0, r0, r0

00008f1c <_ZN3halL14GPIO_Pin_CountE>:
    8f1c:	00000036 	andeq	r0, r0, r6, lsr r0

00008f20 <_ZN3halL8AUX_BaseE>:
    8f20:	20215000 	eorcs	r5, r1, r0

00008f24 <_ZN3halL25Interrupt_Controller_BaseE>:
    8f24:	2000b200 	andcs	fp, r0, r0, lsl #4

00008f28 <_ZN3halL10Timer_BaseE>:
    8f28:	2000b400 	andcs	fp, r0, r0, lsl #8

00008f2c <_ZN3halL9TRNG_BaseE>:
    8f2c:	20104000 	andscs	r4, r0, r0

00008f30 <_ZN3halL9BSC0_BaseE>:
    8f30:	20205000 	eorcs	r5, r0, r0

00008f34 <_ZN3halL9BSC1_BaseE>:
    8f34:	20804000 	addcs	r4, r0, r0

00008f38 <_ZN3halL9BSC2_BaseE>:
    8f38:	20805000 	addcs	r5, r0, r0

00008f3c <_ZL11Invalid_Pin>:
    8f3c:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
    8f40:	3a564544 	bcc	159a458 <__bss_end+0x1591498>
    8f44:	64676573 	strbtvs	r6, [r7], #-1395	; 0xfffffa8d
    8f48:	00000000 	andeq	r0, r0, r0
    8f4c:	3a564544 	bcc	159a464 <__bss_end+0x15914a4>
    8f50:	6f697067 	svcvs	0x00697067
    8f54:	0000342f 	andeq	r3, r0, pc, lsr #8
    8f58:	3a564544 	bcc	159a470 <__bss_end+0x15914b0>
    8f5c:	6f697067 	svcvs	0x00697067
    8f60:	0037312f 	eorseq	r3, r7, pc, lsr #2

00008f64 <_ZL13Lock_Unlocked>:
    8f64:	00000000 	andeq	r0, r0, r0

00008f68 <_ZL11Lock_Locked>:
    8f68:	00000001 	andeq	r0, r0, r1

00008f6c <_ZL21MaxFSDriverNameLength>:
    8f6c:	00000010 	andeq	r0, r0, r0, lsl r0

00008f70 <_ZL17MaxFilenameLength>:
    8f70:	00000010 	andeq	r0, r0, r0, lsl r0

00008f74 <_ZL13MaxPathLength>:
    8f74:	00000080 	andeq	r0, r0, r0, lsl #1

00008f78 <_ZL18NoFilesystemDriver>:
    8f78:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008f7c <_ZL9NotifyAll>:
    8f7c:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008f80 <_ZL24Max_Process_Opened_Files>:
    8f80:	00000010 	andeq	r0, r0, r0, lsl r0

00008f84 <_ZL10Indefinite>:
    8f84:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008f88 <_ZL18Deadline_Unchanged>:
    8f88:	fffffffe 			; <UNDEFINED> instruction: 0xfffffffe

00008f8c <_ZL14Invalid_Handle>:
    8f8c:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008f90 <_ZL16Pipe_File_Prefix>:
    8f90:	3a535953 	bcc	14df4e4 <__bss_end+0x14d6524>
    8f94:	65706970 	ldrbvs	r6, [r0, #-2416]!	; 0xfffff690
    8f98:	0000002f 	andeq	r0, r0, pc, lsr #32

00008f9c <_ZN12_GLOBAL__N_1L11CharConvArrE>:
    8f9c:	33323130 	teqcc	r2, #48, 2
    8fa0:	37363534 			; <UNDEFINED> instruction: 0x37363534
    8fa4:	42413938 	submi	r3, r1, #56, 18	; 0xe0000
    8fa8:	46454443 	strbmi	r4, [r5], -r3, asr #8
	...

Disassembly of section .bss:

00008fb0 <__bss_start>:
	...

Disassembly of section .ARM.attributes:

00000000 <.ARM.attributes>:
   0:	00002e41 	andeq	r2, r0, r1, asr #28
   4:	61656100 	cmnvs	r5, r0, lsl #2
   8:	01006962 	tsteq	r0, r2, ror #18
   c:	00000024 	andeq	r0, r0, r4, lsr #32
  10:	4b5a3605 	blmi	168d82c <__bss_end+0x168486c>
  14:	08070600 	stmdaeq	r7, {r9, sl}
  18:	0a010901 	beq	42424 <__bss_end+0x39464>
  1c:	14041202 	strne	r1, [r4], #-514	; 0xfffffdfe
  20:	17011501 	strne	r1, [r1, -r1, lsl #10]
  24:	1a011803 	bne	46038 <__bss_end+0x3d078>
  28:	22011c01 	andcs	r1, r1, #256	; 0x100
  2c:	Address 0x000000000000002c is out of bounds.


Disassembly of section .comment:

00000000 <.comment>:
   0:	3a434347 	bcc	10d0d24 <__bss_end+0x10c7d64>
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
  38:	7a617661 	bvc	185d9c4 <__bss_end+0x1854a04>
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
  c0:	6a757a61 	bvs	1d5ea4c <__bss_end+0x1d55a8c>
  c4:	2f696369 	svccs	0x00696369
  c8:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
  cc:	73656d65 	cmnvc	r5, #6464	; 0x1940
  d0:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
  d4:	6b2d616b 	blvs	b58688 <__bss_end+0xb4f6c8>
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
 144:	fb010200 	blx	4094e <__bss_end+0x3798e>
 148:	01000d0e 	tsteq	r0, lr, lsl #26
 14c:	00010101 	andeq	r0, r1, r1, lsl #2
 150:	00010000 	andeq	r0, r1, r0
 154:	552f0100 	strpl	r0, [pc, #-256]!	; 5c <shift+0x5c>
 158:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 15c:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 160:	6a726574 	bvs	1c99738 <__bss_end+0x1c90778>
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
 198:	752f7365 	strvc	r7, [pc, #-869]!	; fffffe3b <__bss_end+0xffff6e7b>
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
 1d0:	0a05830b 	beq	160e04 <__bss_end+0x157e44>
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
 1fc:	4a030402 	bmi	c120c <__bss_end+0xb824c>
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
 230:	4a020402 	bmi	81240 <__bss_end+0x78280>
 234:	02000205 	andeq	r0, r0, #1342177280	; 0x50000000
 238:	052d0204 	streq	r0, [sp, #-516]!	; 0xfffffdfc
 23c:	01058509 	tsteq	r5, r9, lsl #10
 240:	000a022f 	andeq	r0, sl, pc, lsr #4
 244:	03190101 	tsteq	r9, #1073741824	; 0x40000000
 248:	00030000 	andeq	r0, r3, r0
 24c:	00000291 	muleq	r0, r1, r2
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
 280:	6a757a61 	bvs	1d5ec0c <__bss_end+0x1d55c4c>
 284:	2f696369 	svccs	0x00696369
 288:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
 28c:	73656d65 	cmnvc	r5, #6464	; 0x1940
 290:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
 294:	6b2d616b 	blvs	b58848 <__bss_end+0xb4f888>
 298:	6f2d7669 	svcvs	0x002d7669
 29c:	6f732f73 	svcvs	0x00732f73
 2a0:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
 2a4:	73752f73 	cmnvc	r5, #460	; 0x1cc
 2a8:	70737265 	rsbsvc	r7, r3, r5, ror #4
 2ac:	2f656361 	svccs	0x00656361
 2b0:	6e756f63 	cdpvs	15, 7, cr6, cr5, cr3, {3}
 2b4:	5f726574 	svcpl	0x00726574
 2b8:	6b736174 	blvs	1cd8890 <__bss_end+0x1ccf8d0>
 2bc:	73552f00 	cmpvc	r5, #0, 30
 2c0:	2f737265 	svccs	0x00737265
 2c4:	746e6977 	strbtvc	r6, [lr], #-2423	; 0xfffff689
 2c8:	696a7265 	stmdbvs	sl!, {r0, r2, r5, r6, r9, ip, sp, lr}^
 2cc:	7365442f 	cmnvc	r5, #788529152	; 0x2f000000
 2d0:	706f746b 	rsbvc	r7, pc, fp, ror #8
 2d4:	5641462f 	strbpl	r4, [r1], -pc, lsr #12
 2d8:	76614e2f 	strbtvc	r4, [r1], -pc, lsr #28
 2dc:	6a757a61 	bvs	1d5ec68 <__bss_end+0x1d55ca8>
 2e0:	2f696369 	svccs	0x00696369
 2e4:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
 2e8:	73656d65 	cmnvc	r5, #6464	; 0x1940
 2ec:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
 2f0:	6b2d616b 	blvs	b588a4 <__bss_end+0xb4f8e4>
 2f4:	6f2d7669 	svcvs	0x002d7669
 2f8:	6f732f73 	svcvs	0x00732f73
 2fc:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
 300:	73752f73 	cmnvc	r5, #460	; 0x1cc
 304:	70737265 	rsbsvc	r7, r3, r5, ror #4
 308:	2f656361 	svccs	0x00656361
 30c:	6b2f2e2e 	blvs	bcbbcc <__bss_end+0xbc2c0c>
 310:	656e7265 	strbvs	r7, [lr, #-613]!	; 0xfffffd9b
 314:	6e692f6c 	cdpvs	15, 6, cr2, cr9, cr12, {3}
 318:	64756c63 	ldrbtvs	r6, [r5], #-3171	; 0xfffff39d
 31c:	72702f65 	rsbsvc	r2, r0, #404	; 0x194
 320:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
 324:	552f0073 	strpl	r0, [pc, #-115]!	; 2b9 <shift+0x2b9>
 328:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 32c:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 330:	6a726574 	bvs	1c99908 <__bss_end+0x1c90948>
 334:	65442f69 	strbvs	r2, [r4, #-3945]	; 0xfffff097
 338:	6f746b73 	svcvs	0x00746b73
 33c:	41462f70 	hvcmi	25328	; 0x62f0
 340:	614e2f56 	cmpvs	lr, r6, asr pc
 344:	757a6176 	ldrbvc	r6, [sl, #-374]!	; 0xfffffe8a
 348:	6963696a 	stmdbvs	r3!, {r1, r3, r5, r6, r8, fp, sp, lr}^
 34c:	2f534f2f 	svccs	0x00534f2f
 350:	656d6573 	strbvs	r6, [sp, #-1395]!	; 0xfffffa8d
 354:	61727473 	cmnvs	r2, r3, ror r4
 358:	2d616b6c 	vstmdbcs	r1!, {d22-<overflow reg d75>}
 35c:	2d76696b 			; <UNDEFINED> instruction: 0x2d76696b
 360:	732f736f 			; <UNDEFINED> instruction: 0x732f736f
 364:	6372756f 	cmnvs	r2, #465567744	; 0x1bc00000
 368:	752f7365 	strvc	r7, [pc, #-869]!	; b <shift+0xb>
 36c:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 370:	65636170 	strbvs	r6, [r3, #-368]!	; 0xfffffe90
 374:	2f2e2e2f 	svccs	0x002e2e2f
 378:	6e72656b 	cdpvs	5, 7, cr6, cr2, cr11, {3}
 37c:	692f6c65 	stmdbvs	pc!, {r0, r2, r5, r6, sl, fp, sp, lr}	; <UNPREDICTABLE>
 380:	756c636e 	strbvc	r6, [ip, #-878]!	; 0xfffffc92
 384:	662f6564 	strtvs	r6, [pc], -r4, ror #10
 388:	552f0073 	strpl	r0, [pc, #-115]!	; 31d <shift+0x31d>
 38c:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 390:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 394:	6a726574 	bvs	1c9996c <__bss_end+0x1c909ac>
 398:	65442f69 	strbvs	r2, [r4, #-3945]	; 0xfffff097
 39c:	6f746b73 	svcvs	0x00746b73
 3a0:	41462f70 	hvcmi	25328	; 0x62f0
 3a4:	614e2f56 	cmpvs	lr, r6, asr pc
 3a8:	757a6176 	ldrbvc	r6, [sl, #-374]!	; 0xfffffe8a
 3ac:	6963696a 	stmdbvs	r3!, {r1, r3, r5, r6, r8, fp, sp, lr}^
 3b0:	2f534f2f 	svccs	0x00534f2f
 3b4:	656d6573 	strbvs	r6, [sp, #-1395]!	; 0xfffffa8d
 3b8:	61727473 	cmnvs	r2, r3, ror r4
 3bc:	2d616b6c 	vstmdbcs	r1!, {d22-<overflow reg d75>}
 3c0:	2d76696b 			; <UNDEFINED> instruction: 0x2d76696b
 3c4:	732f736f 			; <UNDEFINED> instruction: 0x732f736f
 3c8:	6372756f 	cmnvs	r2, #465567744	; 0x1bc00000
 3cc:	752f7365 	strvc	r7, [pc, #-869]!	; 6f <shift+0x6f>
 3d0:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 3d4:	65636170 	strbvs	r6, [r3, #-368]!	; 0xfffffe90
 3d8:	2f2e2e2f 	svccs	0x002e2e2f
 3dc:	6e72656b 	cdpvs	5, 7, cr6, cr2, cr11, {3}
 3e0:	692f6c65 	stmdbvs	pc!, {r0, r2, r5, r6, sl, fp, sp, lr}	; <UNPREDICTABLE>
 3e4:	756c636e 	strbvc	r6, [ip, #-878]!	; 0xfffffc92
 3e8:	622f6564 	eorvs	r6, pc, #100, 10	; 0x19000000
 3ec:	6472616f 	ldrbtvs	r6, [r2], #-367	; 0xfffffe91
 3f0:	6970722f 	ldmdbvs	r0!, {r0, r1, r2, r3, r5, r9, ip, sp, lr}^
 3f4:	61682f30 	cmnvs	r8, r0, lsr pc
 3f8:	552f006c 	strpl	r0, [pc, #-108]!	; 394 <shift+0x394>
 3fc:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 400:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 404:	6a726574 	bvs	1c999dc <__bss_end+0x1c90a1c>
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
 458:	642f6564 	strtvs	r6, [pc], #-1380	; 460 <shift+0x460>
 45c:	65766972 	ldrbvs	r6, [r6, #-2418]!	; 0xfffff68e
 460:	00007372 	andeq	r7, r0, r2, ror r3
 464:	6e69616d 	powvsez	f6, f1, #5.0
 468:	7070632e 	rsbsvc	r6, r0, lr, lsr #6
 46c:	00000100 	andeq	r0, r0, r0, lsl #2
 470:	2e697773 	mcrcs	7, 3, r7, cr9, cr3, {3}
 474:	00020068 	andeq	r0, r2, r8, rrx
 478:	69707300 	ldmdbvs	r0!, {r8, r9, ip, sp, lr}^
 47c:	636f6c6e 	cmnvs	pc, #28160	; 0x6e00
 480:	00682e6b 	rsbeq	r2, r8, fp, ror #28
 484:	66000002 	strvs	r0, [r0], -r2
 488:	73656c69 	cmnvc	r5, #26880	; 0x6900
 48c:	65747379 	ldrbvs	r7, [r4, #-889]!	; 0xfffffc87
 490:	00682e6d 	rsbeq	r2, r8, sp, ror #28
 494:	70000003 	andvc	r0, r0, r3
 498:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
 49c:	682e7373 	stmdavs	lr!, {r0, r1, r4, r5, r6, r8, r9, ip, sp, lr}
 4a0:	00000200 	andeq	r0, r0, r0, lsl #4
 4a4:	636f7270 	cmnvs	pc, #112, 4
 4a8:	5f737365 	svcpl	0x00737365
 4ac:	616e616d 	cmnvs	lr, sp, ror #2
 4b0:	2e726567 	cdpcs	5, 7, cr6, cr2, cr7, {3}
 4b4:	00020068 	andeq	r0, r2, r8, rrx
 4b8:	72657000 	rsbvc	r7, r5, #0
 4bc:	65687069 	strbvs	r7, [r8, #-105]!	; 0xffffff97
 4c0:	736c6172 	cmnvc	ip, #-2147483620	; 0x8000001c
 4c4:	0400682e 	streq	r6, [r0], #-2094	; 0xfffff7d2
 4c8:	70670000 	rsbvc	r0, r7, r0
 4cc:	682e6f69 	stmdavs	lr!, {r0, r3, r5, r6, r8, r9, sl, fp, sp, lr}
 4d0:	00000500 	andeq	r0, r0, r0, lsl #10
 4d4:	64746e69 	ldrbtvs	r6, [r4], #-3689	; 0xfffff197
 4d8:	682e6665 	stmdavs	lr!, {r0, r2, r5, r6, r9, sl, sp, lr}
 4dc:	00000400 	andeq	r0, r0, r0, lsl #8
 4e0:	00010500 	andeq	r0, r1, r0, lsl #10
 4e4:	822c0205 	eorhi	r0, ip, #1342177280	; 0x50000000
 4e8:	10030000 	andne	r0, r3, r0
 4ec:	9f1e0501 	svcls	0x001e0501
 4f0:	0f058383 	svceq	0x00058383
 4f4:	4b070584 	blmi	1c1b0c <__bss_end+0x1b8b4c>
 4f8:	4c13054b 	cfldr32mi	mvfx0, [r3], {75}	; 0x4b
 4fc:	01040200 	mrseq	r0, R12_usr
 500:	02006606 	andeq	r6, r0, #6291456	; 0x600000
 504:	004a0204 	subeq	r0, sl, r4, lsl #4
 508:	2e040402 	cdpcs	4, 0, cr0, cr4, cr2, {0}
 50c:	4e060805 	cdpmi	8, 0, cr0, cr6, cr5, {0}
 510:	054c0705 	strbeq	r0, [ip, #-1797]	; 0xfffff8fb
 514:	0d059f14 	stceq	15, cr9, [r5, #-80]	; 0xffffffb0
 518:	8407052e 	strhi	r0, [r7], #-1326	; 0xfffffad2
 51c:	059f0f05 	ldreq	r0, [pc, #3845]	; 1429 <shift+0x1429>
 520:	03052e08 	movweq	r2, #24072	; 0x5e08
 524:	670b0584 	strvs	r0, [fp, -r4, lsl #11]
 528:	68180584 	ldmdavs	r8, {r2, r7, r8, sl}
 52c:	20080d05 	andcs	r0, r8, r5, lsl #26
 530:	05660705 	strbeq	r0, [r6, #-1797]!	; 0xfffff8fb
 534:	00a02f08 	adceq	r2, r0, r8, lsl #30
 538:	06010402 	streq	r0, [r1], -r2, lsl #8
 53c:	04020066 	streq	r0, [r2], #-102	; 0xffffff9a
 540:	02004a02 	andeq	r4, r0, #8192	; 0x2000
 544:	002e0404 	eoreq	r0, lr, r4, lsl #8
 548:	66050402 	strvs	r0, [r5], -r2, lsl #8
 54c:	06040200 	streq	r0, [r4], -r0, lsl #4
 550:	0402004a 	streq	r0, [r2], #-74	; 0xffffffb6
 554:	02052e08 	andeq	r2, r5, #8, 28	; 0x80
 558:	08040200 	stmdaeq	r4, {r9}
 55c:	0a026706 	beq	9a17c <__bss_end+0x911bc>
 560:	c8010100 	stmdagt	r1, {r8}
 564:	03000002 	movweq	r0, #2
 568:	0001dd00 	andeq	sp, r1, r0, lsl #26
 56c:	fb010200 	blx	40d76 <__bss_end+0x37db6>
 570:	01000d0e 	tsteq	r0, lr, lsl #26
 574:	00010101 	andeq	r0, r1, r1, lsl #2
 578:	00010000 	andeq	r0, r1, r0
 57c:	552f0100 	strpl	r0, [pc, #-256]!	; 484 <shift+0x484>
 580:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 584:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 588:	6a726574 	bvs	1c99b60 <__bss_end+0x1c90ba0>
 58c:	65442f69 	strbvs	r2, [r4, #-3945]	; 0xfffff097
 590:	6f746b73 	svcvs	0x00746b73
 594:	41462f70 	hvcmi	25328	; 0x62f0
 598:	614e2f56 	cmpvs	lr, r6, asr pc
 59c:	757a6176 	ldrbvc	r6, [sl, #-374]!	; 0xfffffe8a
 5a0:	6963696a 	stmdbvs	r3!, {r1, r3, r5, r6, r8, fp, sp, lr}^
 5a4:	2f534f2f 	svccs	0x00534f2f
 5a8:	656d6573 	strbvs	r6, [sp, #-1395]!	; 0xfffffa8d
 5ac:	61727473 	cmnvs	r2, r3, ror r4
 5b0:	2d616b6c 	vstmdbcs	r1!, {d22-<overflow reg d75>}
 5b4:	2d76696b 			; <UNDEFINED> instruction: 0x2d76696b
 5b8:	732f736f 			; <UNDEFINED> instruction: 0x732f736f
 5bc:	6372756f 	cmnvs	r2, #465567744	; 0x1bc00000
 5c0:	732f7365 			; <UNDEFINED> instruction: 0x732f7365
 5c4:	696c6474 	stmdbvs	ip!, {r2, r4, r5, r6, sl, sp, lr}^
 5c8:	72732f62 	rsbsvc	r2, r3, #392	; 0x188
 5cc:	552f0063 	strpl	r0, [pc, #-99]!	; 571 <shift+0x571>
 5d0:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 5d4:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 5d8:	6a726574 	bvs	1c99bb0 <__bss_end+0x1c90bf0>
 5dc:	65442f69 	strbvs	r2, [r4, #-3945]	; 0xfffff097
 5e0:	6f746b73 	svcvs	0x00746b73
 5e4:	41462f70 	hvcmi	25328	; 0x62f0
 5e8:	614e2f56 	cmpvs	lr, r6, asr pc
 5ec:	757a6176 	ldrbvc	r6, [sl, #-374]!	; 0xfffffe8a
 5f0:	6963696a 	stmdbvs	r3!, {r1, r3, r5, r6, r8, fp, sp, lr}^
 5f4:	2f534f2f 	svccs	0x00534f2f
 5f8:	656d6573 	strbvs	r6, [sp, #-1395]!	; 0xfffffa8d
 5fc:	61727473 	cmnvs	r2, r3, ror r4
 600:	2d616b6c 	vstmdbcs	r1!, {d22-<overflow reg d75>}
 604:	2d76696b 			; <UNDEFINED> instruction: 0x2d76696b
 608:	732f736f 			; <UNDEFINED> instruction: 0x732f736f
 60c:	6372756f 	cmnvs	r2, #465567744	; 0x1bc00000
 610:	6b2f7365 	blvs	bdd3ac <__bss_end+0xbd43ec>
 614:	656e7265 	strbvs	r7, [lr, #-613]!	; 0xfffffd9b
 618:	6e692f6c 	cdpvs	15, 6, cr2, cr9, cr12, {3}
 61c:	64756c63 	ldrbtvs	r6, [r5], #-3171	; 0xfffff39d
 620:	72702f65 	rsbsvc	r2, r0, #404	; 0x194
 624:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
 628:	552f0073 	strpl	r0, [pc, #-115]!	; 5bd <shift+0x5bd>
 62c:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 630:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 634:	6a726574 	bvs	1c99c0c <__bss_end+0x1c90c4c>
 638:	65442f69 	strbvs	r2, [r4, #-3945]	; 0xfffff097
 63c:	6f746b73 	svcvs	0x00746b73
 640:	41462f70 	hvcmi	25328	; 0x62f0
 644:	614e2f56 	cmpvs	lr, r6, asr pc
 648:	757a6176 	ldrbvc	r6, [sl, #-374]!	; 0xfffffe8a
 64c:	6963696a 	stmdbvs	r3!, {r1, r3, r5, r6, r8, fp, sp, lr}^
 650:	2f534f2f 	svccs	0x00534f2f
 654:	656d6573 	strbvs	r6, [sp, #-1395]!	; 0xfffffa8d
 658:	61727473 	cmnvs	r2, r3, ror r4
 65c:	2d616b6c 	vstmdbcs	r1!, {d22-<overflow reg d75>}
 660:	2d76696b 			; <UNDEFINED> instruction: 0x2d76696b
 664:	732f736f 			; <UNDEFINED> instruction: 0x732f736f
 668:	6372756f 	cmnvs	r2, #465567744	; 0x1bc00000
 66c:	6b2f7365 	blvs	bdd408 <__bss_end+0xbd4448>
 670:	656e7265 	strbvs	r7, [lr, #-613]!	; 0xfffffd9b
 674:	6e692f6c 	cdpvs	15, 6, cr2, cr9, cr12, {3}
 678:	64756c63 	ldrbtvs	r6, [r5], #-3171	; 0xfffff39d
 67c:	73662f65 	cmnvc	r6, #404	; 0x194
 680:	73552f00 	cmpvc	r5, #0, 30
 684:	2f737265 	svccs	0x00737265
 688:	746e6977 	strbtvc	r6, [lr], #-2423	; 0xfffff689
 68c:	696a7265 	stmdbvs	sl!, {r0, r2, r5, r6, r9, ip, sp, lr}^
 690:	7365442f 	cmnvc	r5, #788529152	; 0x2f000000
 694:	706f746b 	rsbvc	r7, pc, fp, ror #8
 698:	5641462f 	strbpl	r4, [r1], -pc, lsr #12
 69c:	76614e2f 	strbtvc	r4, [r1], -pc, lsr #28
 6a0:	6a757a61 	bvs	1d5f02c <__bss_end+0x1d5606c>
 6a4:	2f696369 	svccs	0x00696369
 6a8:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
 6ac:	73656d65 	cmnvc	r5, #6464	; 0x1940
 6b0:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
 6b4:	6b2d616b 	blvs	b58c68 <__bss_end+0xb4fca8>
 6b8:	6f2d7669 	svcvs	0x002d7669
 6bc:	6f732f73 	svcvs	0x00732f73
 6c0:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
 6c4:	656b2f73 	strbvs	r2, [fp, #-3955]!	; 0xfffff08d
 6c8:	6c656e72 	stclvs	14, cr6, [r5], #-456	; 0xfffffe38
 6cc:	636e692f 	cmnvs	lr, #770048	; 0xbc000
 6d0:	6564756c 	strbvs	r7, [r4, #-1388]!	; 0xfffffa94
 6d4:	616f622f 	cmnvs	pc, pc, lsr #4
 6d8:	722f6472 	eorvc	r6, pc, #1912602624	; 0x72000000
 6dc:	2f306970 	svccs	0x00306970
 6e0:	006c6168 	rsbeq	r6, ip, r8, ror #2
 6e4:	64747300 	ldrbtvs	r7, [r4], #-768	; 0xfffffd00
 6e8:	656c6966 	strbvs	r6, [ip, #-2406]!	; 0xfffff69a
 6ec:	7070632e 	rsbsvc	r6, r0, lr, lsr #6
 6f0:	00000100 	andeq	r0, r0, r0, lsl #2
 6f4:	2e697773 	mcrcs	7, 3, r7, cr9, cr3, {3}
 6f8:	00020068 	andeq	r0, r2, r8, rrx
 6fc:	69707300 	ldmdbvs	r0!, {r8, r9, ip, sp, lr}^
 700:	636f6c6e 	cmnvs	pc, #28160	; 0x6e00
 704:	00682e6b 	rsbeq	r2, r8, fp, ror #28
 708:	66000002 	strvs	r0, [r0], -r2
 70c:	73656c69 	cmnvc	r5, #26880	; 0x6900
 710:	65747379 	ldrbvs	r7, [r4, #-889]!	; 0xfffffc87
 714:	00682e6d 	rsbeq	r2, r8, sp, ror #28
 718:	70000003 	andvc	r0, r0, r3
 71c:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
 720:	682e7373 	stmdavs	lr!, {r0, r1, r4, r5, r6, r8, r9, ip, sp, lr}
 724:	00000200 	andeq	r0, r0, r0, lsl #4
 728:	636f7270 	cmnvs	pc, #112, 4
 72c:	5f737365 	svcpl	0x00737365
 730:	616e616d 	cmnvs	lr, sp, ror #2
 734:	2e726567 	cdpcs	5, 7, cr6, cr2, cr7, {3}
 738:	00020068 	andeq	r0, r2, r8, rrx
 73c:	746e6900 	strbtvc	r6, [lr], #-2304	; 0xfffff700
 740:	2e666564 	cdpcs	5, 6, cr6, cr6, cr4, {3}
 744:	00040068 	andeq	r0, r4, r8, rrx
 748:	01050000 	mrseq	r0, (UNDEF: 5)
 74c:	c0020500 	andgt	r0, r2, r0, lsl #10
 750:	16000083 	strne	r0, [r0], -r3, lsl #1
 754:	2f690505 	svccs	0x00690505
 758:	054c0c05 	strbeq	r0, [ip, #-3077]	; 0xfffff3fb
 75c:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 760:	054b8305 	strbeq	r8, [fp, #-773]	; 0xfffffcfb
 764:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 768:	01054b05 	tsteq	r5, r5, lsl #22
 76c:	0505852f 	streq	r8, [r5, #-1327]	; 0xfffffad1
 770:	2f4b4ba1 	svccs	0x004b4ba1
 774:	054c0c05 	strbeq	r0, [ip, #-3077]	; 0xfffff3fb
 778:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 77c:	4b4bbd05 	blmi	12efb98 <__bss_end+0x12e6bd8>
 780:	0c052f4b 	stceq	15, cr2, [r5], {75}	; 0x4b
 784:	2f01054c 	svccs	0x0001054c
 788:	bd050585 	cfstr32lt	mvfx0, [r5, #-532]	; 0xfffffdec
 78c:	2f4b4b4b 	svccs	0x004b4b4b
 790:	054c0c05 	strbeq	r0, [ip, #-3077]	; 0xfffff3fb
 794:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 798:	054b8305 	strbeq	r8, [fp, #-773]	; 0xfffffcfb
 79c:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 7a0:	4b4bbd05 	blmi	12efbbc <__bss_end+0x12e6bfc>
 7a4:	0c052f4b 	stceq	15, cr2, [r5], {75}	; 0x4b
 7a8:	2f01054c 	svccs	0x0001054c
 7ac:	a1050585 	smlabbge	r5, r5, r5, r0
 7b0:	052f4b4b 	streq	r4, [pc, #-2891]!	; fffffc6d <__bss_end+0xffff6cad>
 7b4:	01054c0c 	tsteq	r5, ip, lsl #24
 7b8:	0505852f 	streq	r8, [r5, #-1327]	; 0xfffffad1
 7bc:	4b4b4bbd 	blmi	12d36b8 <__bss_end+0x12ca6f8>
 7c0:	4c0c052f 	cfstr32mi	mvfx0, [ip], {47}	; 0x2f
 7c4:	852f0105 	strhi	r0, [pc, #-261]!	; 6c7 <shift+0x6c7>
 7c8:	4ba10505 	blmi	fe841be4 <__bss_end+0xfe838c24>
 7cc:	0c052f4b 	stceq	15, cr2, [r5], {75}	; 0x4b
 7d0:	9f01054c 	svcls	0x0001054c
 7d4:	67200585 	strvs	r0, [r0, -r5, lsl #11]!
 7d8:	4b4d0505 	blmi	1341bf4 <__bss_end+0x1338c34>
 7dc:	300c054b 	andcc	r0, ip, fp, asr #10
 7e0:	852f0105 	strhi	r0, [pc, #-261]!	; 6e3 <shift+0x6e3>
 7e4:	05672005 	strbeq	r2, [r7, #-5]!
 7e8:	4b4b4d05 	blmi	12d3c04 <__bss_end+0x12cac44>
 7ec:	05300c05 	ldreq	r0, [r0, #-3077]!	; 0xfffff3fb
 7f0:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 7f4:	05058320 	streq	r8, [r5, #-800]	; 0xfffffce0
 7f8:	054b4b4c 	strbeq	r4, [fp, #-2892]	; 0xfffff4b4
 7fc:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 800:	05056720 	streq	r6, [r5, #-1824]	; 0xfffff8e0
 804:	054b4b4d 	strbeq	r4, [fp, #-2893]	; 0xfffff4b3
 808:	0105300c 	tsteq	r5, ip
 80c:	0c05872f 	stceq	7, cr8, [r5], {47}	; 0x2f
 810:	31059fa0 	smlatbcc	r5, r0, pc, r9	; <UNPREDICTABLE>
 814:	662905bc 			; <UNDEFINED> instruction: 0x662905bc
 818:	052e3605 	streq	r3, [lr, #-1541]!	; 0xfffff9fb
 81c:	1305300f 	movwne	r3, #20495	; 0x500f
 820:	84090566 	strhi	r0, [r9], #-1382	; 0xfffffa9a
 824:	05d81005 	ldrbeq	r1, [r8, #5]
 828:	08029f01 	stmdaeq	r2, {r0, r8, r9, sl, fp, ip, pc}
 82c:	9b010100 	blls	40c34 <__bss_end+0x37c74>
 830:	03000002 	movweq	r0, #2
 834:	00007400 	andeq	r7, r0, r0, lsl #8
 838:	fb010200 	blx	41042 <__bss_end+0x38082>
 83c:	01000d0e 	tsteq	r0, lr, lsl #26
 840:	00010101 	andeq	r0, r1, r1, lsl #2
 844:	00010000 	andeq	r0, r1, r0
 848:	552f0100 	strpl	r0, [pc, #-256]!	; 750 <shift+0x750>
 84c:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 850:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 854:	6a726574 	bvs	1c99e2c <__bss_end+0x1c90e6c>
 858:	65442f69 	strbvs	r2, [r4, #-3945]	; 0xfffff097
 85c:	6f746b73 	svcvs	0x00746b73
 860:	41462f70 	hvcmi	25328	; 0x62f0
 864:	614e2f56 	cmpvs	lr, r6, asr pc
 868:	757a6176 	ldrbvc	r6, [sl, #-374]!	; 0xfffffe8a
 86c:	6963696a 	stmdbvs	r3!, {r1, r3, r5, r6, r8, fp, sp, lr}^
 870:	2f534f2f 	svccs	0x00534f2f
 874:	656d6573 	strbvs	r6, [sp, #-1395]!	; 0xfffffa8d
 878:	61727473 	cmnvs	r2, r3, ror r4
 87c:	2d616b6c 	vstmdbcs	r1!, {d22-<overflow reg d75>}
 880:	2d76696b 			; <UNDEFINED> instruction: 0x2d76696b
 884:	732f736f 			; <UNDEFINED> instruction: 0x732f736f
 888:	6372756f 	cmnvs	r2, #465567744	; 0x1bc00000
 88c:	732f7365 			; <UNDEFINED> instruction: 0x732f7365
 890:	696c6474 	stmdbvs	ip!, {r2, r4, r5, r6, sl, sp, lr}^
 894:	72732f62 	rsbsvc	r2, r3, #392	; 0x188
 898:	73000063 	movwvc	r0, #99	; 0x63
 89c:	74736474 	ldrbtvc	r6, [r3], #-1140	; 0xfffffb8c
 8a0:	676e6972 			; <UNDEFINED> instruction: 0x676e6972
 8a4:	7070632e 	rsbsvc	r6, r0, lr, lsr #6
 8a8:	00000100 	andeq	r0, r0, r0, lsl #2
 8ac:	00010500 	andeq	r0, r1, r0, lsl #10
 8b0:	881c0205 	ldmdahi	ip, {r0, r2, r9}
 8b4:	051a0000 	ldreq	r0, [sl, #-0]
 8b8:	0f05bb06 	svceq	0x0005bb06
 8bc:	6821054c 	stmdavs	r1!, {r2, r3, r6, r8, sl}
 8c0:	05ba0a05 	ldreq	r0, [sl, #2565]!	; 0xa05
 8c4:	27052e0b 	strcs	r2, [r5, -fp, lsl #28]
 8c8:	4a0d054a 	bmi	341df8 <__bss_end+0x338e38>
 8cc:	052f0905 	streq	r0, [pc, #-2309]!	; ffffffcf <__bss_end+0xffff700f>
 8d0:	02059f04 	andeq	r9, r5, #4, 30
 8d4:	35050562 	strcc	r0, [r5, #-1378]	; 0xfffffa9e
 8d8:	05681005 	strbeq	r1, [r8, #-5]!
 8dc:	22052e11 	andcs	r2, r5, #272	; 0x110
 8e0:	2e13054a 	cfmac32cs	mvfx0, mvfx3, mvfx10
 8e4:	052f0a05 	streq	r0, [pc, #-2565]!	; fffffee7 <__bss_end+0xffff6f27>
 8e8:	0a056909 	beq	15ad14 <__bss_end+0x151d54>
 8ec:	4a0c052e 	bmi	301dac <__bss_end+0x2f8dec>
 8f0:	054b0305 	strbeq	r0, [fp, #-773]	; 0xfffffcfb
 8f4:	1805680b 	stmdane	r5, {r0, r1, r3, fp, sp, lr}
 8f8:	03040200 	movweq	r0, #16896	; 0x4200
 8fc:	0014054a 	andseq	r0, r4, sl, asr #10
 900:	9e030402 	cdpls	4, 0, cr0, cr3, cr2, {0}
 904:	02001505 	andeq	r1, r0, #20971520	; 0x1400000
 908:	05680204 	strbeq	r0, [r8, #-516]!	; 0xfffffdfc
 90c:	04020018 	streq	r0, [r2], #-24	; 0xffffffe8
 910:	08058202 	stmdaeq	r5, {r1, r9, pc}
 914:	02040200 	andeq	r0, r4, #0, 4
 918:	001a054a 	andseq	r0, sl, sl, asr #10
 91c:	4b020402 	blmi	8192c <__bss_end+0x7896c>
 920:	02001b05 	andeq	r1, r0, #5120	; 0x1400
 924:	052e0204 	streq	r0, [lr, #-516]!	; 0xfffffdfc
 928:	0402000c 	streq	r0, [r2], #-12
 92c:	0f054a02 	svceq	0x00054a02
 930:	02040200 	andeq	r0, r4, #0, 4
 934:	001b0582 	andseq	r0, fp, r2, lsl #11
 938:	4a020402 	bmi	81948 <__bss_end+0x78988>
 93c:	02001105 	andeq	r1, r0, #1073741825	; 0x40000001
 940:	052e0204 	streq	r0, [lr, #-516]!	; 0xfffffdfc
 944:	0402000a 	streq	r0, [r2], #-10
 948:	0b052f02 	bleq	14c558 <__bss_end+0x143598>
 94c:	02040200 	andeq	r0, r4, #0, 4
 950:	000d052e 	andeq	r0, sp, lr, lsr #10
 954:	4a020402 	bmi	81964 <__bss_end+0x789a4>
 958:	02000205 	andeq	r0, r0, #1342177280	; 0x50000000
 95c:	05460204 	strbeq	r0, [r6, #-516]	; 0xfffffdfc
 960:	05858801 	streq	r8, [r5, #2049]	; 0x801
 964:	09058306 	stmdbeq	r5, {r1, r2, r8, r9, pc}
 968:	4a10054c 	bmi	401ea0 <__bss_end+0x3f8ee0>
 96c:	054c0a05 	strbeq	r0, [ip, #-2565]	; 0xfffff5fb
 970:	0305bb07 	movweq	fp, #23303	; 0x5b07
 974:	0017054a 	andseq	r0, r7, sl, asr #10
 978:	4a010402 	bmi	41988 <__bss_end+0x389c8>
 97c:	02001405 	andeq	r1, r0, #83886080	; 0x5000000
 980:	054a0104 	strbeq	r0, [sl, #-260]	; 0xfffffefc
 984:	14054d0d 	strne	r4, [r5], #-3341	; 0xfffff2f3
 988:	2e0a054a 	cfsh32cs	mvfx0, mvfx10, #42
 98c:	05680805 	strbeq	r0, [r8, #-2053]!	; 0xfffff7fb
 990:	66780302 	ldrbtvs	r0, [r8], -r2, lsl #6
 994:	0b030905 	bleq	c2db0 <__bss_end+0xb9df0>
 998:	2f01052e 	svccs	0x0001052e
 99c:	bd090585 	cfstr32lt	mvfx0, [r9, #-532]	; 0xfffffdec
 9a0:	02001605 	andeq	r1, r0, #5242880	; 0x500000
 9a4:	054a0404 	strbeq	r0, [sl, #-1028]	; 0xfffffbfc
 9a8:	0402001d 	streq	r0, [r2], #-29	; 0xffffffe3
 9ac:	1e058202 	cdpne	2, 0, cr8, cr5, cr2, {0}
 9b0:	02040200 	andeq	r0, r4, #0, 4
 9b4:	0016052e 	andseq	r0, r6, lr, lsr #10
 9b8:	66020402 	strvs	r0, [r2], -r2, lsl #8
 9bc:	02001105 	andeq	r1, r0, #1073741825	; 0x40000001
 9c0:	054b0304 	strbeq	r0, [fp, #-772]	; 0xfffffcfc
 9c4:	04020012 	streq	r0, [r2], #-18	; 0xffffffee
 9c8:	08052e03 	stmdaeq	r5, {r0, r1, r9, sl, fp, sp}
 9cc:	03040200 	movweq	r0, #16896	; 0x4200
 9d0:	0009054a 	andeq	r0, r9, sl, asr #10
 9d4:	2e030402 	cdpcs	4, 0, cr0, cr3, cr2, {0}
 9d8:	02001205 	andeq	r1, r0, #1342177280	; 0x50000000
 9dc:	054a0304 	strbeq	r0, [sl, #-772]	; 0xfffffcfc
 9e0:	0402000b 	streq	r0, [r2], #-11
 9e4:	02052e03 	andeq	r2, r5, #3, 28	; 0x30
 9e8:	03040200 	movweq	r0, #16896	; 0x4200
 9ec:	000b052d 	andeq	r0, fp, sp, lsr #10
 9f0:	84020402 	strhi	r0, [r2], #-1026	; 0xfffffbfe
 9f4:	02000805 	andeq	r0, r0, #327680	; 0x50000
 9f8:	05830104 	streq	r0, [r3, #260]	; 0x104
 9fc:	04020009 	streq	r0, [r2], #-9
 a00:	0b052e01 	bleq	14c20c <__bss_end+0x14324c>
 a04:	01040200 	mrseq	r0, R12_usr
 a08:	0002054a 	andeq	r0, r2, sl, asr #10
 a0c:	49010402 	stmdbmi	r1, {r1, sl}
 a10:	05850b05 	streq	r0, [r5, #2821]	; 0xb05
 a14:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 a18:	1105bc0e 	tstne	r5, lr, lsl #24
 a1c:	bc200566 	cfstr32lt	mvfx0, [r0], #-408	; 0xfffffe68
 a20:	05660b05 	strbeq	r0, [r6, #-2821]!	; 0xfffff4fb
 a24:	0a054b1f 	beq	1536a8 <__bss_end+0x14a6e8>
 a28:	4b080566 	blmi	201fc8 <__bss_end+0x1f9008>
 a2c:	05831105 	streq	r1, [r3, #261]	; 0x105
 a30:	08052e16 	stmdaeq	r5, {r1, r2, r4, r9, sl, fp, sp}
 a34:	67110567 	ldrvs	r0, [r1, -r7, ror #10]
 a38:	054d0b05 	strbeq	r0, [sp, #-2821]	; 0xfffff4fb
 a3c:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 a40:	0b058306 	bleq	161660 <__bss_end+0x1586a0>
 a44:	2e0c054c 	cfsh32cs	mvfx0, mvfx12, #44
 a48:	05660e05 	strbeq	r0, [r6, #-3589]!	; 0xfffff1fb
 a4c:	02054b04 	andeq	r4, r5, #4, 22	; 0x1000
 a50:	31090565 	tstcc	r9, r5, ror #10
 a54:	852f0105 	strhi	r0, [pc, #-261]!	; 957 <shift+0x957>
 a58:	059f0805 	ldreq	r0, [pc, #2053]	; 1265 <shift+0x1265>
 a5c:	14054c0b 	strne	r4, [r5], #-3083	; 0xfffff3f5
 a60:	03040200 	movweq	r0, #16896	; 0x4200
 a64:	0007054a 	andeq	r0, r7, sl, asr #10
 a68:	83020402 	movwhi	r0, #9218	; 0x2402
 a6c:	02000805 	andeq	r0, r0, #327680	; 0x50000
 a70:	052e0204 	streq	r0, [lr, #-516]!	; 0xfffffdfc
 a74:	0402000a 	streq	r0, [r2], #-10
 a78:	02054a02 	andeq	r4, r5, #8192	; 0x2000
 a7c:	02040200 	andeq	r0, r4, #0, 4
 a80:	84010549 	strhi	r0, [r1], #-1353	; 0xfffffab7
 a84:	bb0e0585 	bllt	3820a0 <__bss_end+0x3790e0>
 a88:	054b0805 	strbeq	r0, [fp, #-2053]	; 0xfffff7fb
 a8c:	14054c0b 	strne	r4, [r5], #-3083	; 0xfffff3f5
 a90:	03040200 	movweq	r0, #16896	; 0x4200
 a94:	0016054a 	andseq	r0, r6, sl, asr #10
 a98:	83020402 	movwhi	r0, #9218	; 0x2402
 a9c:	02001705 	andeq	r1, r0, #1310720	; 0x140000
 aa0:	052e0204 	streq	r0, [lr, #-516]!	; 0xfffffdfc
 aa4:	0402000a 	streq	r0, [r2], #-10
 aa8:	0b054a02 	bleq	1532b8 <__bss_end+0x14a2f8>
 aac:	02040200 	andeq	r0, r4, #0, 4
 ab0:	0017052e 	andseq	r0, r7, lr, lsr #10
 ab4:	4a020402 	bmi	81ac4 <__bss_end+0x78b04>
 ab8:	02000d05 	andeq	r0, r0, #320	; 0x140
 abc:	052e0204 	streq	r0, [lr, #-516]!	; 0xfffffdfc
 ac0:	04020002 	streq	r0, [r2], #-2
 ac4:	01052d02 	tsteq	r5, r2, lsl #26
 ac8:	00080284 	andeq	r0, r8, r4, lsl #5
 acc:	Address 0x0000000000000acc is out of bounds.


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
      58:	073a0704 	ldreq	r0, [sl, -r4, lsl #14]!
      5c:	5b020000 	blpl	80064 <__bss_end+0x770a4>
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
     128:	0000073a 	andeq	r0, r0, sl, lsr r7
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
     174:	cb104801 	blgt	412180 <__bss_end+0x4091c0>
     178:	d4000000 	strle	r0, [r0], #-0
     17c:	58000081 	stmdapl	r0, {r0, r7}
     180:	01000000 	mrseq	r0, (UNDEF: 0)
     184:	0000cb9c 	muleq	r0, ip, fp
     188:	02b40a00 	adcseq	r0, r4, #0, 20
     18c:	4a010000 	bmi	40194 <__bss_end+0x371d4>
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
     21c:	ba0d9c01 	blt	367228 <__bss_end+0x35e268>
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
     24c:	8b120f01 	blhi	483e58 <__bss_end+0x47ae98>
     250:	0f000001 	svceq	0x00000001
     254:	0000019e 	muleq	r0, lr, r1
     258:	03d51000 	bicseq	r1, r5, #0
     25c:	0a010000 	beq	40264 <__bss_end+0x372a4>
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
     2b4:	8b140074 	blhi	50048c <__bss_end+0x4f74cc>
     2b8:	a4000001 	strge	r0, [r0], #-1
     2bc:	38000080 	stmdacc	r0, {r7}
     2c0:	01000000 	mrseq	r0, (UNDEF: 0)
     2c4:	0067139c 	mlseq	r7, ip, r3, r1
     2c8:	9e2f0a01 	vmulls.f32	s0, s30, s2
     2cc:	02000001 	andeq	r0, r0, #1
     2d0:	00007491 	muleq	r0, r1, r4
     2d4:	000007f3 	strdeq	r0, [r0], -r3
     2d8:	01e00004 	mvneq	r0, r4
     2dc:	01040000 	mrseq	r0, (UNDEF: 4)
     2e0:	000001e1 	andeq	r0, r0, r1, ror #3
     2e4:	000b6704 	andeq	r6, fp, r4, lsl #14
     2e8:	00005600 	andeq	r5, r0, r0, lsl #12
     2ec:	00822c00 	addeq	r2, r2, r0, lsl #24
     2f0:	00019400 	andeq	r9, r1, r0, lsl #8
     2f4:	00024600 	andeq	r4, r2, r0, lsl #12
     2f8:	08010200 	stmdaeq	r1, {r9}
     2fc:	00000931 	andeq	r0, r0, r1, lsr r9
     300:	6b050202 	blvs	140b10 <__bss_end+0x137b50>
     304:	03000009 	movweq	r0, #9
     308:	6e690504 	cdpvs	5, 6, cr0, cr9, cr4, {0}
     30c:	01020074 	tsteq	r2, r4, ror r0
     310:	00092808 	andeq	r2, r9, r8, lsl #16
     314:	07020200 	streq	r0, [r2, -r0, lsl #4]
     318:	0000078e 	andeq	r0, r0, lr, lsl #15
     31c:	00099904 	andeq	r9, r9, r4, lsl #18
     320:	07090900 	streq	r0, [r9, -r0, lsl #18]
     324:	00000059 	andeq	r0, r0, r9, asr r0
     328:	00004805 	andeq	r4, r0, r5, lsl #16
     32c:	07040200 	streq	r0, [r4, -r0, lsl #4]
     330:	0000073a 	andeq	r0, r0, sl, lsr r7
     334:	00005905 	andeq	r5, r0, r5, lsl #18
     338:	06190600 	ldreq	r0, [r9], -r0, lsl #12
     33c:	02080000 	andeq	r0, r8, #0
     340:	008b0806 	addeq	r0, fp, r6, lsl #16
     344:	72070000 	andvc	r0, r7, #0
     348:	08020030 	stmdaeq	r2, {r4, r5}
     34c:	0000480e 	andeq	r4, r0, lr, lsl #16
     350:	72070000 	andvc	r0, r7, #0
     354:	09020031 	stmdbeq	r2, {r0, r4, r5}
     358:	0000480e 	andeq	r4, r0, lr, lsl #16
     35c:	08000400 	stmdaeq	r0, {sl}
     360:	000004f4 	strdeq	r0, [r0], -r4
     364:	00330405 	eorseq	r0, r3, r5, lsl #8
     368:	1e020000 	cdpne	0, 0, cr0, cr2, cr0, {0}
     36c:	0000c20c 	andeq	ip, r0, ip, lsl #4
     370:	06800900 	streq	r0, [r0], r0, lsl #18
     374:	09000000 	stmdbeq	r0, {}	; <UNPREDICTABLE>
     378:	00000c14 	andeq	r0, r0, r4, lsl ip
     37c:	0bf40901 	bleq	ffd02788 <__bss_end+0xffcf97c8>
     380:	09020000 	stmdbeq	r2, {}	; <UNPREDICTABLE>
     384:	000007c1 	andeq	r0, r0, r1, asr #15
     388:	08b70903 	ldmeq	r7!, {r0, r1, r8, fp}
     38c:	09040000 	stmdbeq	r4, {}	; <UNPREDICTABLE>
     390:	00000649 	andeq	r0, r0, r9, asr #12
     394:	2a080005 	bcs	2003b0 <__bss_end+0x1f73f0>
     398:	0500000b 	streq	r0, [r0, #-11]
     39c:	00003304 	andeq	r3, r0, r4, lsl #6
     3a0:	0c3f0200 	lfmeq	f0, 4, [pc], #-0	; 3a8 <shift+0x3a8>
     3a4:	000000ff 	strdeq	r0, [r0], -pc	; <UNPREDICTABLE>
     3a8:	0003ff09 	andeq	pc, r3, r9, lsl #30
     3ac:	09090000 	stmdbeq	r9, {}	; <UNPREDICTABLE>
     3b0:	01000005 	tsteq	r0, r5
     3b4:	0008aa09 	andeq	sl, r8, r9, lsl #20
     3b8:	cc090200 	sfmgt	f0, 4, [r9], {-0}
     3bc:	0300000b 	movweq	r0, #11
     3c0:	000c1e09 	andeq	r1, ip, r9, lsl #28
     3c4:	71090400 	tstvc	r9, r0, lsl #8
     3c8:	05000008 	streq	r0, [r0, #-8]
     3cc:	0007ae09 	andeq	sl, r7, r9, lsl #28
     3d0:	0a000600 	beq	1bd8 <shift+0x1bd8>
     3d4:	0000088b 	andeq	r0, r0, fp, lsl #17
     3d8:	54140503 	ldrpl	r0, [r4], #-1283	; 0xfffffafd
     3dc:	05000000 	streq	r0, [r0, #-0]
     3e0:	008ee403 	addeq	lr, lr, r3, lsl #8
     3e4:	08990a00 	ldmeq	r9, {r9, fp}
     3e8:	06030000 	streq	r0, [r3], -r0
     3ec:	00005414 	andeq	r5, r0, r4, lsl r4
     3f0:	e8030500 	stmda	r3, {r8, sl}
     3f4:	0a00008e 	beq	634 <shift+0x634>
     3f8:	0000085b 	andeq	r0, r0, fp, asr r8
     3fc:	541a0704 	ldrpl	r0, [sl], #-1796	; 0xfffff8fc
     400:	05000000 	streq	r0, [r0, #-0]
     404:	008eec03 	addeq	lr, lr, r3, lsl #24
     408:	05380a00 	ldreq	r0, [r8, #-2560]!	; 0xfffff600
     40c:	09040000 	stmdbeq	r4, {}	; <UNPREDICTABLE>
     410:	0000541a 	andeq	r5, r0, sl, lsl r4
     414:	f0030500 			; <UNDEFINED> instruction: 0xf0030500
     418:	0a00008e 	beq	658 <shift+0x658>
     41c:	0000091a 	andeq	r0, r0, sl, lsl r9
     420:	541a0b04 	ldrpl	r0, [sl], #-2820	; 0xfffff4fc
     424:	05000000 	streq	r0, [r0, #-0]
     428:	008ef403 	addeq	pc, lr, r3, lsl #8
     42c:	07680a00 	strbeq	r0, [r8, -r0, lsl #20]!
     430:	0d040000 	stceq	0, cr0, [r4, #-0]
     434:	0000541a 	andeq	r5, r0, sl, lsl r4
     438:	f8030500 			; <UNDEFINED> instruction: 0xf8030500
     43c:	0a00008e 	beq	67c <shift+0x67c>
     440:	00000632 	andeq	r0, r0, r2, lsr r6
     444:	541a0f04 	ldrpl	r0, [sl], #-3844	; 0xfffff0fc
     448:	05000000 	streq	r0, [r0, #-0]
     44c:	008efc03 	addeq	pc, lr, r3, lsl #24
     450:	105b0800 	subsne	r0, fp, r0, lsl #16
     454:	04050000 	streq	r0, [r5], #-0
     458:	00000033 	andeq	r0, r0, r3, lsr r0
     45c:	a20c1b04 	andge	r1, ip, #4, 22	; 0x1000
     460:	09000001 	stmdbeq	r0, {r0}
     464:	000009c1 	andeq	r0, r0, r1, asr #19
     468:	0be40900 	bleq	ff902870 <__bss_end+0xff8f98b0>
     46c:	09010000 	stmdbeq	r1, {}	; <UNPREDICTABLE>
     470:	000008a5 	andeq	r0, r0, r5, lsr #17
     474:	140b0002 	strne	r0, [fp], #-2
     478:	02000009 	andeq	r0, r0, #9
     47c:	07d40201 	ldrbeq	r0, [r4, r1, lsl #4]
     480:	040c0000 	streq	r0, [ip], #-0
     484:	000001a2 	andeq	r0, r0, r2, lsr #3
     488:	0006c80a 	andeq	ip, r6, sl, lsl #16
     48c:	14040500 	strne	r0, [r4], #-1280	; 0xfffffb00
     490:	00000054 	andeq	r0, r0, r4, asr r0
     494:	8f000305 	svchi	0x00000305
     498:	f40a0000 	vst4.8	{d0-d3}, [sl], r0
     49c:	05000003 	streq	r0, [r0, #-3]
     4a0:	00541407 	subseq	r1, r4, r7, lsl #8
     4a4:	03050000 	movweq	r0, #20480	; 0x5000
     4a8:	00008f04 	andeq	r8, r0, r4, lsl #30
     4ac:	0005660a 	andeq	r6, r5, sl, lsl #12
     4b0:	140a0500 	strne	r0, [sl], #-1280	; 0xfffffb00
     4b4:	00000054 	andeq	r0, r0, r4, asr r0
     4b8:	8f080305 	svchi	0x00080305
     4bc:	09080000 	stmdbeq	r8, {}	; <UNPREDICTABLE>
     4c0:	05000008 	streq	r0, [r0, #-8]
     4c4:	00003304 	andeq	r3, r0, r4, lsl #6
     4c8:	0c0d0500 	cfstr32eq	mvfx0, [sp], {-0}
     4cc:	00000221 	andeq	r0, r0, r1, lsr #4
     4d0:	77654e0d 	strbvc	r4, [r5, -sp, lsl #28]!
     4d4:	00090000 	andeq	r0, r9, r0
     4d8:	01000008 	tsteq	r0, r8
     4dc:	00099109 	andeq	r9, r9, r9, lsl #2
     4e0:	e3090200 	movw	r0, #37376	; 0x9200
     4e4:	03000007 	movweq	r0, #7
     4e8:	0007b309 	andeq	fp, r7, r9, lsl #6
     4ec:	b0090400 	andlt	r0, r9, r0, lsl #8
     4f0:	05000008 	streq	r0, [r0, #-8]
     4f4:	063c0600 	ldrteq	r0, [ip], -r0, lsl #12
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
     524:	520e0800 	andpl	r0, lr, #0, 16
     528:	05000006 	streq	r0, [r0, #-6]
     52c:	02601320 	rsbeq	r1, r0, #32, 6	; 0x80000000
     530:	000c0000 	andeq	r0, ip, r0
     534:	35070402 	strcc	r0, [r7, #-1026]	; 0xfffffbfe
     538:	05000007 	streq	r0, [r0, #-7]
     53c:	00000260 	andeq	r0, r0, r0, ror #4
     540:	00046106 	andeq	r6, r4, r6, lsl #2
     544:	28057000 	stmdacs	r5, {ip, sp, lr}
     548:	0002fc08 	andeq	pc, r2, r8, lsl #24
     54c:	09b50e00 	ldmibeq	r5!, {r9, sl, fp}
     550:	2a050000 	bcs	140558 <__bss_end+0x137598>
     554:	00022112 	andeq	r2, r2, r2, lsl r1
     558:	70070000 	andvc	r0, r7, r0
     55c:	05006469 	streq	r6, [r0, #-1129]	; 0xfffffb97
     560:	0059122b 	subseq	r1, r9, fp, lsr #4
     564:	0e100000 	cdpeq	0, 1, cr0, cr0, cr0, {0}
     568:	00000532 	andeq	r0, r0, r2, lsr r5
     56c:	ea112c05 	b	44b588 <__bss_end+0x4425c8>
     570:	14000001 	strne	r0, [r0], #-1
     574:	0008150e 	andeq	r1, r8, lr, lsl #10
     578:	122d0500 	eorne	r0, sp, #0, 10
     57c:	00000059 	andeq	r0, r0, r9, asr r0
     580:	08230e18 	stmdaeq	r3!, {r3, r4, r9, sl, fp}
     584:	2e050000 	cdpcs	0, 0, cr0, cr5, cr0, {0}
     588:	00005912 	andeq	r5, r0, r2, lsl r9
     58c:	250e1c00 	strcs	r1, [lr, #-3072]	; 0xfffff400
     590:	05000006 	streq	r0, [r0, #-6]
     594:	02fc0c2f 	rscseq	r0, ip, #12032	; 0x2f00
     598:	0e200000 	cdpeq	0, 2, cr0, cr0, cr0, {0}
     59c:	00000839 	andeq	r0, r0, r9, lsr r8
     5a0:	33093005 	movwcc	r3, #36869	; 0x9005
     5a4:	60000000 	andvs	r0, r0, r0
     5a8:	0009cb0e 	andeq	ip, r9, lr, lsl #22
     5ac:	0e310500 	cfabs32eq	mvfx0, mvfx1
     5b0:	00000048 	andeq	r0, r0, r8, asr #32
     5b4:	069b0e64 	ldreq	r0, [fp], r4, ror #28
     5b8:	33050000 	movwcc	r0, #20480	; 0x5000
     5bc:	0000480e 	andeq	r4, r0, lr, lsl #16
     5c0:	920e6800 	andls	r6, lr, #0, 16
     5c4:	05000006 	streq	r0, [r0, #-6]
     5c8:	00480e34 	subeq	r0, r8, r4, lsr lr
     5cc:	006c0000 	rsbeq	r0, ip, r0
     5d0:	0001ae0f 	andeq	sl, r1, pc, lsl #28
     5d4:	00030c00 	andeq	r0, r3, r0, lsl #24
     5d8:	00591000 	subseq	r1, r9, r0
     5dc:	000f0000 	andeq	r0, pc, r0
     5e0:	000b420a 	andeq	r4, fp, sl, lsl #4
     5e4:	140a0600 	strne	r0, [sl], #-1536	; 0xfffffa00
     5e8:	00000054 	andeq	r0, r0, r4, asr r0
     5ec:	8f0c0305 	svchi	0x000c0305
     5f0:	eb080000 	bl	2005f8 <__bss_end+0x1f7638>
     5f4:	05000007 	streq	r0, [r0, #-7]
     5f8:	00003304 	andeq	r3, r0, r4, lsl #6
     5fc:	0c0d0600 	stceq	6, cr0, [sp], {-0}
     600:	0000033d 	andeq	r0, r0, sp, lsr r3
     604:	00050e09 	andeq	r0, r5, r9, lsl #28
     608:	e9090000 	stmdb	r9, {}	; <UNPREDICTABLE>
     60c:	01000003 	tsteq	r0, r3
     610:	0a7f0600 	beq	1fc1e18 <__bss_end+0x1fb8e58>
     614:	060c0000 	streq	r0, [ip], -r0
     618:	0372081b 	cmneq	r2, #1769472	; 0x1b0000
     61c:	330e0000 	movwcc	r0, #57344	; 0xe000
     620:	06000004 	streq	r0, [r0], -r4
     624:	0372191d 	cmneq	r2, #475136	; 0x74000
     628:	0e000000 	cdpeq	0, 0, cr0, cr0, cr0, {0}
     62c:	000004d1 	ldrdeq	r0, [r0], -r1
     630:	72191e06 	andsvc	r1, r9, #6, 28	; 0x60
     634:	04000003 	streq	r0, [r0], #-3
     638:	000a3f0e 	andeq	r3, sl, lr, lsl #30
     63c:	131f0600 	tstne	pc, #0, 12
     640:	00000378 	andeq	r0, r0, r8, ror r3
     644:	040c0008 	streq	r0, [ip], #-8
     648:	0000033d 	andeq	r0, r0, sp, lsr r3
     64c:	026c040c 	rsbeq	r0, ip, #12, 8	; 0xc000000
     650:	79110000 	ldmdbvc	r1, {}	; <UNPREDICTABLE>
     654:	14000005 	strne	r0, [r0], #-5
     658:	00072206 	andeq	r2, r7, r6, lsl #4
     65c:	0e000006 	cdpeq	0, 0, cr0, cr0, cr6, {0}
     660:	000007d9 	ldrdeq	r0, [r0], -r9
     664:	48122606 	ldmdami	r2, {r1, r2, r9, sl, sp}
     668:	00000000 	andeq	r0, r0, r0
     66c:	0004900e 	andeq	r9, r4, lr
     670:	1d290600 	stcne	6, cr0, [r9, #-0]
     674:	00000372 	andeq	r0, r0, r2, ror r3
     678:	09a20e04 	stmibeq	r2!, {r2, r9, sl, fp}
     67c:	2c060000 	stccs	0, cr0, [r6], {-0}
     680:	0003721d 	andeq	r7, r3, sp, lsl r2
     684:	20120800 	andscs	r0, r2, r0, lsl #16
     688:	0600000b 	streq	r0, [r0], -fp
     68c:	0a5c0e2f 	beq	1703f50 <__bss_end+0x16faf90>
     690:	03c60000 	biceq	r0, r6, #0
     694:	03d10000 	bicseq	r0, r1, #0
     698:	05130000 	ldreq	r0, [r3, #-0]
     69c:	14000006 	strne	r0, [r0], #-6
     6a0:	00000372 	andeq	r0, r0, r2, ror r3
     6a4:	0a441500 	beq	1105aac <__bss_end+0x10fcaec>
     6a8:	31060000 	mrscc	r0, (UNDEF: 6)
     6ac:	0004380e 	andeq	r3, r4, lr, lsl #16
     6b0:	0001a700 	andeq	sl, r1, r0, lsl #14
     6b4:	0003e900 	andeq	lr, r3, r0, lsl #18
     6b8:	0003f400 	andeq	pc, r3, r0, lsl #8
     6bc:	06051300 	streq	r1, [r5], -r0, lsl #6
     6c0:	78140000 	ldmdavc	r4, {}	; <UNPREDICTABLE>
     6c4:	00000003 	andeq	r0, r0, r3
     6c8:	000a9216 	andeq	r9, sl, r6, lsl r2
     6cc:	1d350600 	ldcne	6, cr0, [r5, #-0]
     6d0:	00000a1a 	andeq	r0, r0, sl, lsl sl
     6d4:	00000372 	andeq	r0, r0, r2, ror r3
     6d8:	00040d02 	andeq	r0, r4, r2, lsl #26
     6dc:	00041300 	andeq	r1, r4, r0, lsl #6
     6e0:	06051300 	streq	r1, [r5], -r0, lsl #6
     6e4:	16000000 	strne	r0, [r0], -r0
     6e8:	000007a1 	andeq	r0, r0, r1, lsr #15
     6ec:	361d3706 	ldrcc	r3, [sp], -r6, lsl #14
     6f0:	72000009 	andvc	r0, r0, #9
     6f4:	02000003 	andeq	r0, r0, #3
     6f8:	0000042c 	andeq	r0, r0, ip, lsr #8
     6fc:	00000432 	andeq	r0, r0, r2, lsr r4
     700:	00060513 	andeq	r0, r6, r3, lsl r5
     704:	43170000 	tstmi	r7, #0
     708:	06000008 	streq	r0, [r0], -r8
     70c:	061e3139 			; <UNDEFINED> instruction: 0x061e3139
     710:	020c0000 	andeq	r0, ip, #0
     714:	00057916 	andeq	r7, r5, r6, lsl r9
     718:	093c0600 	ldmdbeq	ip!, {r9, sl}
     71c:	00000bfa 	strdeq	r0, [r0], -sl
     720:	00000605 	andeq	r0, r0, r5, lsl #12
     724:	00045901 	andeq	r5, r4, r1, lsl #18
     728:	00045f00 	andeq	r5, r4, r0, lsl #30
     72c:	06051300 	streq	r1, [r5], -r0, lsl #6
     730:	16000000 	strne	r0, [r0], -r0
     734:	00000523 	andeq	r0, r0, r3, lsr #10
     738:	f5123f06 			; <UNDEFINED> instruction: 0xf5123f06
     73c:	4800000a 	stmdami	r0, {r1, r3}
     740:	01000000 	mrseq	r0, (UNDEF: 0)
     744:	00000478 	andeq	r0, r0, r8, ror r4
     748:	0000048d 	andeq	r0, r0, sp, lsl #9
     74c:	00060513 	andeq	r0, r6, r3, lsl r5
     750:	06271400 	strteq	r1, [r7], -r0, lsl #8
     754:	59140000 	ldmdbpl	r4, {}	; <UNPREDICTABLE>
     758:	14000000 	strne	r0, [r0], #-0
     75c:	000001a7 	andeq	r0, r0, r7, lsr #3
     760:	0a531800 	beq	14c6768 <__bss_end+0x14bd7a8>
     764:	42060000 	andmi	r0, r6, #0
     768:	0008c60e 	andeq	ip, r8, lr, lsl #12
     76c:	04a20100 	strteq	r0, [r2], #256	; 0x100
     770:	04a80000 	strteq	r0, [r8], #0
     774:	05130000 	ldreq	r0, [r3, #-0]
     778:	00000006 	andeq	r0, r0, r6
     77c:	00072116 	andeq	r2, r7, r6, lsl r1
     780:	17450600 	strbne	r0, [r5, -r0, lsl #12]
     784:	000004a3 	andeq	r0, r0, r3, lsr #9
     788:	00000378 	andeq	r0, r0, r8, ror r3
     78c:	0004c101 	andeq	ip, r4, r1, lsl #2
     790:	0004c700 	andeq	ip, r4, r0, lsl #14
     794:	062d1300 	strteq	r1, [sp], -r0, lsl #6
     798:	16000000 	strne	r0, [r0], -r0
     79c:	000004d6 	ldrdeq	r0, [r0], -r6
     7a0:	d7174806 	ldrle	r4, [r7, -r6, lsl #16]
     7a4:	78000009 	stmdavc	r0, {r0, r3}
     7a8:	01000003 	tsteq	r0, r3
     7ac:	000004e0 	andeq	r0, r0, r0, ror #9
     7b0:	000004eb 	andeq	r0, r0, fp, ror #9
     7b4:	00062d13 	andeq	r2, r6, r3, lsl sp
     7b8:	00481400 	subeq	r1, r8, r0, lsl #8
     7bc:	18000000 	stmdane	r0, {}	; <UNPREDICTABLE>
     7c0:	00000b51 	andeq	r0, r0, r1, asr fp
     7c4:	040e4b06 	streq	r4, [lr], #-2822	; 0xfffff4fa
     7c8:	01000004 	tsteq	r0, r4
     7cc:	00000500 	andeq	r0, r0, r0, lsl #10
     7d0:	00000506 	andeq	r0, r0, r6, lsl #10
     7d4:	00060513 	andeq	r0, r6, r3, lsl r5
     7d8:	44160000 	ldrmi	r0, [r6], #-0
     7dc:	0600000a 	streq	r0, [r0], -sl
     7e0:	06580e4d 	ldrbeq	r0, [r8], -sp, asr #28
     7e4:	01a70000 			; <UNDEFINED> instruction: 0x01a70000
     7e8:	1f010000 	svcne	0x00010000
     7ec:	2a000005 	bcs	808 <shift+0x808>
     7f0:	13000005 	movwne	r0, #5
     7f4:	00000605 	andeq	r0, r0, r5, lsl #12
     7f8:	00004814 	andeq	r4, r0, r4, lsl r8
     7fc:	47160000 	ldrmi	r0, [r6, -r0]
     800:	06000007 	streq	r0, [r0], -r7
     804:	08e71250 	stmiaeq	r7!, {r4, r6, r9, ip}^
     808:	00480000 	subeq	r0, r8, r0
     80c:	43010000 	movwmi	r0, #4096	; 0x1000
     810:	4e000005 	cdpmi	0, 0, cr0, cr0, cr5, {0}
     814:	13000005 	movwne	r0, #5
     818:	00000605 	andeq	r0, r0, r5, lsl #12
     81c:	0001ae14 	andeq	sl, r1, r4, lsl lr
     820:	73160000 	tstvc	r6, #0
     824:	06000004 	streq	r0, [r0], -r4
     828:	06e10e53 	usateq	r0, #1, r3, asr #28
     82c:	01a70000 			; <UNDEFINED> instruction: 0x01a70000
     830:	67010000 	strvs	r0, [r1, -r0]
     834:	72000005 	andvc	r0, r0, #5
     838:	13000005 	movwne	r0, #5
     83c:	00000605 	andeq	r0, r0, r5, lsl #12
     840:	00004814 	andeq	r4, r0, r4, lsl r8
     844:	7b180000 	blvc	60084c <__bss_end+0x5f788c>
     848:	06000007 	streq	r0, [r0], -r7
     84c:	0a9e0e56 	beq	fe7841ac <__bss_end+0xfe77b1ec>
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
     878:	04180000 	ldreq	r0, [r8], #-0
     87c:	0600000a 	streq	r0, [r0], -sl
     880:	05cd0e58 	strbeq	r0, [sp, #3672]	; 0xe58
     884:	bb010000 	bllt	4088c <__bss_end+0x378cc>
     888:	da000005 	ble	8a4 <shift+0x8a4>
     88c:	13000005 	movwne	r0, #5
     890:	00000605 	andeq	r0, r0, r5, lsl #12
     894:	0000c214 	andeq	ip, r0, r4, lsl r2
     898:	00481400 	subeq	r1, r8, r0, lsl #8
     89c:	48140000 	ldmdami	r4, {}	; <UNPREDICTABLE>
     8a0:	14000000 	strne	r0, [r0], #-0
     8a4:	00000048 	andeq	r0, r0, r8, asr #32
     8a8:	00063314 	andeq	r3, r6, r4, lsl r3
     8ac:	53190000 	tstpl	r9, #0
     8b0:	06000005 	streq	r0, [r0], -r5
     8b4:	058a0e5b 	streq	r0, [sl, #3675]	; 0xe5b
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
     91c:	00000878 	andeq	r0, r0, r8, ror r8
     920:	60190707 	andsvs	r0, r9, r7, lsl #14
     924:	80000000 	andhi	r0, r0, r0
     928:	1f0ee6b2 	svcne	0x000ee6b2
     92c:	00000981 	andeq	r0, r0, r1, lsl #19
     930:	671a0a07 	ldrvs	r0, [sl, -r7, lsl #20]
     934:	00000002 	andeq	r0, r0, r2
     938:	1f200000 	svcne	0x00200000
     93c:	00000851 	andeq	r0, r0, r1, asr r8
     940:	671a0d07 	ldrvs	r0, [sl, -r7, lsl #26]
     944:	00000002 	andeq	r0, r0, r2
     948:	20202000 	eorcs	r2, r0, r0
     94c:	0000095c 	andeq	r0, r0, ip, asr r9
     950:	54151007 	ldrpl	r1, [r5], #-7
     954:	36000000 	strcc	r0, [r0], -r0
     958:	00054a1f 	andeq	r4, r5, pc, lsl sl
     95c:	1a420700 	bne	1082564 <__bss_end+0x10795a4>
     960:	00000267 	andeq	r0, r0, r7, ror #4
     964:	20215000 	eorcs	r5, r1, r0
     968:	0006a41f 	andeq	sl, r6, pc, lsl r4
     96c:	1a710700 	bne	1c42574 <__bss_end+0x1c395b4>
     970:	00000267 	andeq	r0, r0, r7, ror #4
     974:	2000b200 	andcs	fp, r0, r0, lsl #4
     978:	0004e91f 	andeq	lr, r4, pc, lsl r9
     97c:	1aa40700 	bne	fe902584 <__bss_end+0xfe8f95c4>
     980:	00000267 	andeq	r0, r0, r7, ror #4
     984:	2000b400 	andcs	fp, r0, r0, lsl #8
     988:	00070d1f 	andeq	r0, r7, pc, lsl sp
     98c:	1ab30700 	bne	fecc2594 <__bss_end+0xfecb95d4>
     990:	00000267 	andeq	r0, r0, r7, ror #4
     994:	20104000 	andscs	r4, r0, r0
     998:	0006881f 	andeq	r8, r6, pc, lsl r8
     99c:	1abe0700 	bne	fef825a4 <__bss_end+0xfef795e4>
     9a0:	00000267 	andeq	r0, r0, r7, ror #4
     9a4:	20205000 	eorcs	r5, r0, r0
     9a8:	0006be1f 	andeq	fp, r6, pc, lsl lr
     9ac:	1abf0700 	bne	fefc25b4 <__bss_end+0xfefb95f4>
     9b0:	00000267 	andeq	r0, r0, r7, ror #4
     9b4:	20804000 	addcs	r4, r0, r0
     9b8:	0004861f 	andeq	r8, r4, pc, lsl r6
     9bc:	1ac00700 	bne	ff0025c4 <__bss_end+0xfeff9604>
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
     a00:	0009750a 	andeq	r7, r9, sl, lsl #10
     a04:	14080800 	strne	r0, [r8], #-2048	; 0xfffff800
     a08:	00000054 	andeq	r0, r0, r4, asr r0
     a0c:	8f3c0305 	svchi	0x003c0305
     a10:	ef220000 	svc	0x00220000
     a14:	0100000b 	tsteq	r0, fp
     a18:	00330510 	eorseq	r0, r3, r0, lsl r5
     a1c:	822c0000 	eorhi	r0, ip, #0
     a20:	01940000 	orrseq	r0, r4, r0
     a24:	9c010000 	stcls	0, cr0, [r1], {-0}
     a28:	000007ea 	andeq	r0, r0, sl, ror #15
     a2c:	000bd223 	andeq	sp, fp, r3, lsr #4
     a30:	0e100100 	mufeqs	f0, f0, f0
     a34:	00000033 	andeq	r0, r0, r3, lsr r0
     a38:	235c9102 	cmpcs	ip, #-2147483648	; 0x80000000
     a3c:	00000af0 	strdeq	r0, [r0], -r0	; <UNPREDICTABLE>
     a40:	ea1b1001 	b	6c4a4c <__bss_end+0x6bba8c>
     a44:	02000007 	andeq	r0, r0, #7
     a48:	c7245891 			; <UNDEFINED> instruction: 0xc7245891
     a4c:	01000007 	tsteq	r0, r7
     a50:	00480b12 	subeq	r0, r8, r2, lsl fp
     a54:	91020000 	mrsls	r0, (UNDEF: 2)
     a58:	0bd72470 	bleq	ff5c9c20 <__bss_end+0xff5c0c60>
     a5c:	13010000 	movwne	r0, #4096	; 0x1000
     a60:	0000480b 	andeq	r4, r0, fp, lsl #16
     a64:	6c910200 	lfmvs	f0, 4, [r1], {0}
     a68:	00075b24 	andeq	r5, r7, r4, lsr #22
     a6c:	0b140100 	bleq	500e74 <__bss_end+0x4f7eb4>
     a70:	00000048 	andeq	r0, r0, r8, asr #32
     a74:	24689102 	strbtcs	r9, [r8], #-258	; 0xfffffefe
     a78:	0000081b 	andeq	r0, r0, fp, lsl r8
     a7c:	590f1601 	stmdbpl	pc, {r0, r9, sl, ip}	; <UNPREDICTABLE>
     a80:	02000000 	andeq	r0, r0, #0
     a84:	6e247491 	mcrvs	4, 1, r7, cr4, cr1, {4}
     a88:	01000004 	tsteq	r0, r4
     a8c:	01a70717 			; <UNDEFINED> instruction: 0x01a70717
     a90:	91020000 	mrsls	r0, (UNDEF: 2)
     a94:	07172467 	ldreq	r2, [r7, -r7, ror #8]
     a98:	18010000 	stmdane	r1, {}	; <UNPREDICTABLE>
     a9c:	0001a707 	andeq	sl, r1, r7, lsl #14
     aa0:	66910200 	ldrvs	r0, [r1], r0, lsl #4
     aa4:	0082a825 	addeq	sl, r2, r5, lsr #16
     aa8:	00010400 	andeq	r0, r1, r0, lsl #8
     aac:	6d742600 	ldclvs	6, cr2, [r4, #-0]
     ab0:	1e010070 	mcrne	0, 0, r0, cr1, cr0, {3}
     ab4:	00002508 	andeq	r2, r0, r8, lsl #10
     ab8:	65910200 	ldrvs	r0, [r1, #512]	; 0x200
     abc:	040c0000 	streq	r0, [ip], #-0
     ac0:	000007f0 	strdeq	r0, [r0], -r0	; <UNPREDICTABLE>
     ac4:	0025040c 	eoreq	r0, r5, ip, lsl #8
     ac8:	1f000000 	svcne	0x00000000
     acc:	0400000b 	streq	r0, [r0], #-11
     ad0:	00042000 	andeq	r2, r4, r0
     ad4:	57010400 	strpl	r0, [r1, -r0, lsl #8]
     ad8:	0400000f 	streq	r0, [r0], #-15
     adc:	00000e35 	andeq	r0, r0, r5, lsr lr
     ae0:	00000c24 	andeq	r0, r0, r4, lsr #24
     ae4:	000083c0 	andeq	r8, r0, r0, asr #7
     ae8:	0000045c 	andeq	r0, r0, ip, asr r4
     aec:	00000563 	andeq	r0, r0, r3, ror #10
     af0:	31080102 	tstcc	r8, r2, lsl #2
     af4:	03000009 	movweq	r0, #9
     af8:	00000025 	andeq	r0, r0, r5, lsr #32
     afc:	6b050202 	blvs	14130c <__bss_end+0x13834c>
     b00:	04000009 	streq	r0, [r0], #-9
     b04:	6e690504 	cdpvs	5, 6, cr0, cr9, cr4, {0}
     b08:	01020074 	tsteq	r2, r4, ror r0
     b0c:	00092808 	andeq	r2, r9, r8, lsl #16
     b10:	07020200 	streq	r0, [r2, -r0, lsl #4]
     b14:	0000078e 	andeq	r0, r0, lr, lsl #15
     b18:	00099905 	andeq	r9, r9, r5, lsl #18
     b1c:	07090700 	streq	r0, [r9, -r0, lsl #14]
     b20:	0000005e 	andeq	r0, r0, lr, asr r0
     b24:	00004d03 	andeq	r4, r0, r3, lsl #26
     b28:	07040200 	streq	r0, [r4, -r0, lsl #4]
     b2c:	0000073a 	andeq	r0, r0, sl, lsr r7
     b30:	00061906 	andeq	r1, r6, r6, lsl #18
     b34:	06020800 	streq	r0, [r2], -r0, lsl #16
     b38:	00008b08 	andeq	r8, r0, r8, lsl #22
     b3c:	30720700 	rsbscc	r0, r2, r0, lsl #14
     b40:	0e080200 	cdpeq	2, 0, cr0, cr8, cr0, {0}
     b44:	0000004d 	andeq	r0, r0, sp, asr #32
     b48:	31720700 	cmncc	r2, r0, lsl #14
     b4c:	0e090200 	cdpeq	2, 0, cr0, cr9, cr0, {0}
     b50:	0000004d 	andeq	r0, r0, sp, asr #32
     b54:	e1080004 	tst	r8, r4
     b58:	0500000e 	streq	r0, [r0, #-14]
     b5c:	00003804 	andeq	r3, r0, r4, lsl #16
     b60:	0c0d0200 	sfmeq	f0, 4, [sp], {-0}
     b64:	000000a9 	andeq	r0, r0, r9, lsr #1
     b68:	004b4f09 	subeq	r4, fp, r9, lsl #30
     b6c:	0cd20a00 	vldmiaeq	r2, {s1-s0}
     b70:	00010000 	andeq	r0, r1, r0
     b74:	0004f408 	andeq	pc, r4, r8, lsl #8
     b78:	38040500 	stmdacc	r4, {r8, sl}
     b7c:	02000000 	andeq	r0, r0, #0
     b80:	00e00c1e 	rsceq	r0, r0, lr, lsl ip
     b84:	800a0000 	andhi	r0, sl, r0
     b88:	00000006 	andeq	r0, r0, r6
     b8c:	000c140a 	andeq	r1, ip, sl, lsl #8
     b90:	f40a0100 	vst4.8	{d0,d2,d4,d6}, [sl], r0
     b94:	0200000b 	andeq	r0, r0, #11
     b98:	0007c10a 	andeq	ip, r7, sl, lsl #2
     b9c:	b70a0300 	strlt	r0, [sl, -r0, lsl #6]
     ba0:	04000008 	streq	r0, [r0], #-8
     ba4:	0006490a 	andeq	r4, r6, sl, lsl #18
     ba8:	08000500 	stmdaeq	r0, {r8, sl}
     bac:	00000b2a 	andeq	r0, r0, sl, lsr #22
     bb0:	00380405 	eorseq	r0, r8, r5, lsl #8
     bb4:	3f020000 	svccc	0x00020000
     bb8:	00011d0c 	andeq	r1, r1, ip, lsl #26
     bbc:	03ff0a00 	mvnseq	r0, #0, 20
     bc0:	0a000000 	beq	bc8 <shift+0xbc8>
     bc4:	00000509 	andeq	r0, r0, r9, lsl #10
     bc8:	08aa0a01 	stmiaeq	sl!, {r0, r9, fp}
     bcc:	0a020000 	beq	80bd4 <__bss_end+0x77c14>
     bd0:	00000bcc 	andeq	r0, r0, ip, asr #23
     bd4:	0c1e0a03 			; <UNDEFINED> instruction: 0x0c1e0a03
     bd8:	0a040000 	beq	100be0 <__bss_end+0xf7c20>
     bdc:	00000871 	andeq	r0, r0, r1, ror r8
     be0:	07ae0a05 	streq	r0, [lr, r5, lsl #20]!
     be4:	00060000 	andeq	r0, r6, r0
     be8:	00100808 	andseq	r0, r0, r8, lsl #16
     bec:	38040500 	stmdacc	r4, {r8, sl}
     bf0:	02000000 	andeq	r0, r0, #0
     bf4:	01480c66 	cmpeq	r8, r6, ror #24
     bf8:	2a0a0000 	bcs	280c00 <__bss_end+0x277c40>
     bfc:	0000000e 	andeq	r0, r0, lr
     c00:	000d2f0a 	andeq	r2, sp, sl, lsl #30
     c04:	aa0a0100 	bge	28100c <__bss_end+0x27804c>
     c08:	0200000e 	andeq	r0, r0, #14
     c0c:	000d540a 	andeq	r5, sp, sl, lsl #8
     c10:	0b000300 	bleq	1818 <shift+0x1818>
     c14:	0000088b 	andeq	r0, r0, fp, lsl #17
     c18:	59140503 	ldmdbpl	r4, {r0, r1, r8, sl}
     c1c:	05000000 	streq	r0, [r0, #-0]
     c20:	008f6403 	addeq	r6, pc, r3, lsl #8
     c24:	08990b00 	ldmeq	r9, {r8, r9, fp}
     c28:	06030000 	streq	r0, [r3], -r0
     c2c:	00005914 	andeq	r5, r0, r4, lsl r9
     c30:	68030500 	stmdavs	r3, {r8, sl}
     c34:	0b00008f 	bleq	e78 <shift+0xe78>
     c38:	0000085b 	andeq	r0, r0, fp, asr r8
     c3c:	591a0704 	ldmdbpl	sl, {r2, r8, r9, sl}
     c40:	05000000 	streq	r0, [r0, #-0]
     c44:	008f6c03 	addeq	r6, pc, r3, lsl #24
     c48:	05380b00 	ldreq	r0, [r8, #-2816]!	; 0xfffff500
     c4c:	09040000 	stmdbeq	r4, {}	; <UNPREDICTABLE>
     c50:	0000591a 	andeq	r5, r0, sl, lsl r9
     c54:	70030500 	andvc	r0, r3, r0, lsl #10
     c58:	0b00008f 	bleq	e9c <shift+0xe9c>
     c5c:	0000091a 	andeq	r0, r0, sl, lsl r9
     c60:	591a0b04 	ldmdbpl	sl, {r2, r8, r9, fp}
     c64:	05000000 	streq	r0, [r0, #-0]
     c68:	008f7403 	addeq	r7, pc, r3, lsl #8
     c6c:	07680b00 	strbeq	r0, [r8, -r0, lsl #22]!
     c70:	0d040000 	stceq	0, cr0, [r4, #-0]
     c74:	0000591a 	andeq	r5, r0, sl, lsl r9
     c78:	78030500 	stmdavc	r3, {r8, sl}
     c7c:	0b00008f 	bleq	ec0 <shift+0xec0>
     c80:	00000632 	andeq	r0, r0, r2, lsr r6
     c84:	591a0f04 	ldmdbpl	sl, {r2, r8, r9, sl, fp}
     c88:	05000000 	streq	r0, [r0, #-0]
     c8c:	008f7c03 	addeq	r7, pc, r3, lsl #24
     c90:	105b0800 	subsne	r0, fp, r0, lsl #16
     c94:	04050000 	streq	r0, [r5], #-0
     c98:	00000038 	andeq	r0, r0, r8, lsr r0
     c9c:	eb0c1b04 	bl	3078b4 <__bss_end+0x2fe8f4>
     ca0:	0a000001 	beq	cac <shift+0xcac>
     ca4:	000009c1 	andeq	r0, r0, r1, asr #19
     ca8:	0be40a00 	bleq	ff9034b0 <__bss_end+0xff8fa4f0>
     cac:	0a010000 	beq	40cb4 <__bss_end+0x37cf4>
     cb0:	000008a5 	andeq	r0, r0, r5, lsr #17
     cb4:	140c0002 	strne	r0, [ip], #-2
     cb8:	02000009 	andeq	r0, r0, #9
     cbc:	07d40201 	ldrbeq	r0, [r4, r1, lsl #4]
     cc0:	040d0000 	streq	r0, [sp], #-0
     cc4:	0000002c 	andeq	r0, r0, ip, lsr #32
     cc8:	01eb040d 	mvneq	r0, sp, lsl #8
     ccc:	c80b0000 	stmdagt	fp, {}	; <UNPREDICTABLE>
     cd0:	05000006 	streq	r0, [r0, #-6]
     cd4:	00591404 	subseq	r1, r9, r4, lsl #8
     cd8:	03050000 	movweq	r0, #20480	; 0x5000
     cdc:	00008f80 	andeq	r8, r0, r0, lsl #31
     ce0:	0003f40b 	andeq	pc, r3, fp, lsl #8
     ce4:	14070500 	strne	r0, [r7], #-1280	; 0xfffffb00
     ce8:	00000059 	andeq	r0, r0, r9, asr r0
     cec:	8f840305 	svchi	0x00840305
     cf0:	660b0000 	strvs	r0, [fp], -r0
     cf4:	05000005 	streq	r0, [r0, #-5]
     cf8:	0059140a 	subseq	r1, r9, sl, lsl #8
     cfc:	03050000 	movweq	r0, #20480	; 0x5000
     d00:	00008f88 	andeq	r8, r0, r8, lsl #31
     d04:	00080908 	andeq	r0, r8, r8, lsl #18
     d08:	38040500 	stmdacc	r4, {r8, sl}
     d0c:	05000000 	streq	r0, [r0, #-0]
     d10:	02700c0d 	rsbseq	r0, r0, #3328	; 0xd00
     d14:	4e090000 	cdpmi	0, 0, cr0, cr9, cr0, {0}
     d18:	00007765 	andeq	r7, r0, r5, ror #14
     d1c:	0008000a 	andeq	r0, r8, sl
     d20:	910a0100 	mrsls	r0, (UNDEF: 26)
     d24:	02000009 	andeq	r0, r0, #9
     d28:	0007e30a 	andeq	lr, r7, sl, lsl #6
     d2c:	b30a0300 	movwlt	r0, #41728	; 0xa300
     d30:	04000007 	streq	r0, [r0], #-7
     d34:	0008b00a 	andeq	fp, r8, sl
     d38:	06000500 	streq	r0, [r0], -r0, lsl #10
     d3c:	0000063c 	andeq	r0, r0, ip, lsr r6
     d40:	081b0510 	ldmdaeq	fp, {r4, r8, sl}
     d44:	000002af 	andeq	r0, r0, pc, lsr #5
     d48:	00726c07 	rsbseq	r6, r2, r7, lsl #24
     d4c:	af131d05 	svcge	0x00131d05
     d50:	00000002 	andeq	r0, r0, r2
     d54:	00707307 	rsbseq	r7, r0, r7, lsl #6
     d58:	af131e05 	svcge	0x00131e05
     d5c:	04000002 	streq	r0, [r0], #-2
     d60:	00637007 	rsbeq	r7, r3, r7
     d64:	af131f05 	svcge	0x00131f05
     d68:	08000002 	stmdaeq	r0, {r1}
     d6c:	0006520e 	andeq	r5, r6, lr, lsl #4
     d70:	13200500 	nopne	{0}	; <UNPREDICTABLE>
     d74:	000002af 	andeq	r0, r0, pc, lsr #5
     d78:	0402000c 	streq	r0, [r2], #-12
     d7c:	00073507 	andeq	r3, r7, r7, lsl #10
     d80:	04610600 	strbteq	r0, [r1], #-1536	; 0xfffffa00
     d84:	05700000 	ldrbeq	r0, [r0, #-0]!
     d88:	03460828 	movteq	r0, #26664	; 0x6828
     d8c:	b50e0000 	strlt	r0, [lr, #-0]
     d90:	05000009 	streq	r0, [r0, #-9]
     d94:	0270122a 	rsbseq	r1, r0, #-1610612734	; 0xa0000002
     d98:	07000000 	streq	r0, [r0, -r0]
     d9c:	00646970 	rsbeq	r6, r4, r0, ror r9
     da0:	5e122b05 	vnmlspl.f64	d2, d2, d5
     da4:	10000000 	andne	r0, r0, r0
     da8:	0005320e 	andeq	r3, r5, lr, lsl #4
     dac:	112c0500 			; <UNDEFINED> instruction: 0x112c0500
     db0:	00000239 	andeq	r0, r0, r9, lsr r2
     db4:	08150e14 	ldmdaeq	r5, {r2, r4, r9, sl, fp}
     db8:	2d050000 	stccs	0, cr0, [r5, #-0]
     dbc:	00005e12 	andeq	r5, r0, r2, lsl lr
     dc0:	230e1800 	movwcs	r1, #59392	; 0xe800
     dc4:	05000008 	streq	r0, [r0, #-8]
     dc8:	005e122e 	subseq	r1, lr, lr, lsr #4
     dcc:	0e1c0000 	cdpeq	0, 1, cr0, cr12, cr0, {0}
     dd0:	00000625 	andeq	r0, r0, r5, lsr #12
     dd4:	460c2f05 	strmi	r2, [ip], -r5, lsl #30
     dd8:	20000003 	andcs	r0, r0, r3
     ddc:	0008390e 	andeq	r3, r8, lr, lsl #18
     de0:	09300500 	ldmdbeq	r0!, {r8, sl}
     de4:	00000038 	andeq	r0, r0, r8, lsr r0
     de8:	09cb0e60 	stmibeq	fp, {r5, r6, r9, sl, fp}^
     dec:	31050000 	mrscc	r0, (UNDEF: 5)
     df0:	00004d0e 	andeq	r4, r0, lr, lsl #26
     df4:	9b0e6400 	blls	399dfc <__bss_end+0x390e3c>
     df8:	05000006 	streq	r0, [r0, #-6]
     dfc:	004d0e33 	subeq	r0, sp, r3, lsr lr
     e00:	0e680000 	cdpeq	0, 6, cr0, cr8, cr0, {0}
     e04:	00000692 	muleq	r0, r2, r6
     e08:	4d0e3405 	cfstrsmi	mvf3, [lr, #-20]	; 0xffffffec
     e0c:	6c000000 	stcvs	0, cr0, [r0], {-0}
     e10:	01fd0f00 	mvnseq	r0, r0, lsl #30
     e14:	03560000 	cmpeq	r6, #0
     e18:	5e100000 	cdppl	0, 1, cr0, cr0, cr0, {0}
     e1c:	0f000000 	svceq	0x00000000
     e20:	0b420b00 	bleq	1083a28 <__bss_end+0x107aa68>
     e24:	0a060000 	beq	180e2c <__bss_end+0x177e6c>
     e28:	00005914 	andeq	r5, r0, r4, lsl r9
     e2c:	8c030500 	cfstr32hi	mvfx0, [r3], {-0}
     e30:	0800008f 	stmdaeq	r0, {r0, r1, r2, r3, r7}
     e34:	000007eb 	andeq	r0, r0, fp, ror #15
     e38:	00380405 	eorseq	r0, r8, r5, lsl #8
     e3c:	0d060000 	stceq	0, cr0, [r6, #-0]
     e40:	0003870c 	andeq	r8, r3, ip, lsl #14
     e44:	050e0a00 	streq	r0, [lr, #-2560]	; 0xfffff600
     e48:	0a000000 	beq	e50 <shift+0xe50>
     e4c:	000003e9 	andeq	r0, r0, r9, ror #7
     e50:	68030001 	stmdavs	r3, {r0}
     e54:	08000003 	stmdaeq	r0, {r0, r1}
     e58:	00000dbc 			; <UNDEFINED> instruction: 0x00000dbc
     e5c:	00380405 	eorseq	r0, r8, r5, lsl #8
     e60:	14060000 	strne	r0, [r6], #-0
     e64:	0003ab0c 	andeq	sl, r3, ip, lsl #22
     e68:	0c750a00 			; <UNDEFINED> instruction: 0x0c750a00
     e6c:	0a000000 	beq	e74 <shift+0xe74>
     e70:	00000e9c 	muleq	r0, ip, lr
     e74:	8c030001 	stchi	0, cr0, [r3], {1}
     e78:	06000003 	streq	r0, [r0], -r3
     e7c:	00000a7f 	andeq	r0, r0, pc, ror sl
     e80:	081b060c 	ldmdaeq	fp, {r2, r3, r9, sl}
     e84:	000003e5 	andeq	r0, r0, r5, ror #7
     e88:	0004330e 	andeq	r3, r4, lr, lsl #6
     e8c:	191d0600 	ldmdbne	sp, {r9, sl}
     e90:	000003e5 	andeq	r0, r0, r5, ror #7
     e94:	04d10e00 	ldrbeq	r0, [r1], #3584	; 0xe00
     e98:	1e060000 	cdpne	0, 0, cr0, cr6, cr0, {0}
     e9c:	0003e519 	andeq	lr, r3, r9, lsl r5
     ea0:	3f0e0400 	svccc	0x000e0400
     ea4:	0600000a 	streq	r0, [r0], -sl
     ea8:	03eb131f 	mvneq	r1, #2080374784	; 0x7c000000
     eac:	00080000 	andeq	r0, r8, r0
     eb0:	03b0040d 	movseq	r0, #218103808	; 0xd000000
     eb4:	040d0000 	streq	r0, [sp], #-0
     eb8:	000002b6 			; <UNDEFINED> instruction: 0x000002b6
     ebc:	00057911 	andeq	r7, r5, r1, lsl r9
     ec0:	22061400 	andcs	r1, r6, #0, 8
     ec4:	00067307 	andeq	r7, r6, r7, lsl #6
     ec8:	07d90e00 	ldrbeq	r0, [r9, r0, lsl #28]
     ecc:	26060000 	strcs	r0, [r6], -r0
     ed0:	00004d12 	andeq	r4, r0, r2, lsl sp
     ed4:	900e0000 	andls	r0, lr, r0
     ed8:	06000004 	streq	r0, [r0], -r4
     edc:	03e51d29 	mvneq	r1, #2624	; 0xa40
     ee0:	0e040000 	cdpeq	0, 0, cr0, cr4, cr0, {0}
     ee4:	000009a2 	andeq	r0, r0, r2, lsr #19
     ee8:	e51d2c06 	ldr	r2, [sp, #-3078]	; 0xfffff3fa
     eec:	08000003 	stmdaeq	r0, {r0, r1}
     ef0:	000b2012 	andeq	r2, fp, r2, lsl r0
     ef4:	0e2f0600 	cfmadda32eq	mvax0, mvax0, mvfx15, mvfx0
     ef8:	00000a5c 	andeq	r0, r0, ip, asr sl
     efc:	00000439 	andeq	r0, r0, r9, lsr r4
     f00:	00000444 	andeq	r0, r0, r4, asr #8
     f04:	00067813 	andeq	r7, r6, r3, lsl r8
     f08:	03e51400 	mvneq	r1, #0, 8
     f0c:	15000000 	strne	r0, [r0, #-0]
     f10:	00000a44 	andeq	r0, r0, r4, asr #20
     f14:	380e3106 	stmdacc	lr, {r1, r2, r8, ip, sp}
     f18:	f0000004 			; <UNDEFINED> instruction: 0xf0000004
     f1c:	5c000001 	stcpl	0, cr0, [r0], {1}
     f20:	67000004 	strvs	r0, [r0, -r4]
     f24:	13000004 	movwne	r0, #4
     f28:	00000678 	andeq	r0, r0, r8, ror r6
     f2c:	0003eb14 	andeq	lr, r3, r4, lsl fp
     f30:	92160000 	andsls	r0, r6, #0
     f34:	0600000a 	streq	r0, [r0], -sl
     f38:	0a1a1d35 	beq	688414 <__bss_end+0x67f454>
     f3c:	03e50000 	mvneq	r0, #0
     f40:	80020000 	andhi	r0, r2, r0
     f44:	86000004 	strhi	r0, [r0], -r4
     f48:	13000004 	movwne	r0, #4
     f4c:	00000678 	andeq	r0, r0, r8, ror r6
     f50:	07a11600 	streq	r1, [r1, r0, lsl #12]!
     f54:	37060000 	strcc	r0, [r6, -r0]
     f58:	0009361d 	andeq	r3, r9, sp, lsl r6
     f5c:	0003e500 	andeq	lr, r3, r0, lsl #10
     f60:	049f0200 	ldreq	r0, [pc], #512	; f68 <shift+0xf68>
     f64:	04a50000 	strteq	r0, [r5], #0
     f68:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
     f6c:	00000006 	andeq	r0, r0, r6
     f70:	00084317 	andeq	r4, r8, r7, lsl r3
     f74:	31390600 	teqcc	r9, r0, lsl #12
     f78:	00000691 	muleq	r0, r1, r6
     f7c:	7916020c 	ldmdbvc	r6, {r2, r3, r9}
     f80:	06000005 	streq	r0, [r0], -r5
     f84:	0bfa093c 	bleq	ffe8347c <__bss_end+0xffe7a4bc>
     f88:	06780000 	ldrbteq	r0, [r8], -r0
     f8c:	cc010000 	stcgt	0, cr0, [r1], {-0}
     f90:	d2000004 	andle	r0, r0, #4
     f94:	13000004 	movwne	r0, #4
     f98:	00000678 	andeq	r0, r0, r8, ror r6
     f9c:	05231600 	streq	r1, [r3, #-1536]!	; 0xfffffa00
     fa0:	3f060000 	svccc	0x00060000
     fa4:	000af512 	andeq	pc, sl, r2, lsl r5	; <UNPREDICTABLE>
     fa8:	00004d00 	andeq	r4, r0, r0, lsl #26
     fac:	04eb0100 	strbteq	r0, [fp], #256	; 0x100
     fb0:	05000000 	streq	r0, [r0, #-0]
     fb4:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
     fb8:	14000006 	strne	r0, [r0], #-6
     fbc:	0000069a 	muleq	r0, sl, r6
     fc0:	00005e14 	andeq	r5, r0, r4, lsl lr
     fc4:	01f01400 	mvnseq	r1, r0, lsl #8
     fc8:	18000000 	stmdane	r0, {}	; <UNPREDICTABLE>
     fcc:	00000a53 	andeq	r0, r0, r3, asr sl
     fd0:	c60e4206 	strgt	r4, [lr], -r6, lsl #4
     fd4:	01000008 	tsteq	r0, r8
     fd8:	00000515 	andeq	r0, r0, r5, lsl r5
     fdc:	0000051b 	andeq	r0, r0, fp, lsl r5
     fe0:	00067813 	andeq	r7, r6, r3, lsl r8
     fe4:	21160000 	tstcs	r6, r0
     fe8:	06000007 	streq	r0, [r0], -r7
     fec:	04a31745 	strteq	r1, [r3], #1861	; 0x745
     ff0:	03eb0000 	mvneq	r0, #0
     ff4:	34010000 	strcc	r0, [r1], #-0
     ff8:	3a000005 	bcc	1014 <shift+0x1014>
     ffc:	13000005 	movwne	r0, #5
    1000:	000006a0 	andeq	r0, r0, r0, lsr #13
    1004:	04d61600 	ldrbeq	r1, [r6], #1536	; 0x600
    1008:	48060000 	stmdami	r6, {}	; <UNPREDICTABLE>
    100c:	0009d717 	andeq	sp, r9, r7, lsl r7
    1010:	0003eb00 	andeq	lr, r3, r0, lsl #22
    1014:	05530100 	ldrbeq	r0, [r3, #-256]	; 0xffffff00
    1018:	055e0000 	ldrbeq	r0, [lr, #-0]
    101c:	a0130000 	andsge	r0, r3, r0
    1020:	14000006 	strne	r0, [r0], #-6
    1024:	0000004d 	andeq	r0, r0, sp, asr #32
    1028:	0b511800 	bleq	1447030 <__bss_end+0x143e070>
    102c:	4b060000 	blmi	181034 <__bss_end+0x178074>
    1030:	0004040e 	andeq	r0, r4, lr, lsl #8
    1034:	05730100 	ldrbeq	r0, [r3, #-256]!	; 0xffffff00
    1038:	05790000 	ldrbeq	r0, [r9, #-0]!
    103c:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
    1040:	00000006 	andeq	r0, r0, r6
    1044:	000a4416 	andeq	r4, sl, r6, lsl r4
    1048:	0e4d0600 	cdpeq	6, 4, cr0, cr13, cr0, {0}
    104c:	00000658 	andeq	r0, r0, r8, asr r6
    1050:	000001f0 	strdeq	r0, [r0], -r0	; <UNPREDICTABLE>
    1054:	00059201 	andeq	r9, r5, r1, lsl #4
    1058:	00059d00 	andeq	r9, r5, r0, lsl #26
    105c:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
    1060:	4d140000 	ldcmi	0, cr0, [r4, #-0]
    1064:	00000000 	andeq	r0, r0, r0
    1068:	00074716 	andeq	r4, r7, r6, lsl r7
    106c:	12500600 	subsne	r0, r0, #0, 12
    1070:	000008e7 	andeq	r0, r0, r7, ror #17
    1074:	0000004d 	andeq	r0, r0, sp, asr #32
    1078:	0005b601 	andeq	fp, r5, r1, lsl #12
    107c:	0005c100 	andeq	ip, r5, r0, lsl #2
    1080:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
    1084:	fd140000 	ldc2	0, cr0, [r4, #-0]
    1088:	00000001 	andeq	r0, r0, r1
    108c:	00047316 	andeq	r7, r4, r6, lsl r3
    1090:	0e530600 	cdpeq	6, 5, cr0, cr3, cr0, {0}
    1094:	000006e1 	andeq	r0, r0, r1, ror #13
    1098:	000001f0 	strdeq	r0, [r0], -r0	; <UNPREDICTABLE>
    109c:	0005da01 	andeq	sp, r5, r1, lsl #20
    10a0:	0005e500 	andeq	lr, r5, r0, lsl #10
    10a4:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
    10a8:	4d140000 	ldcmi	0, cr0, [r4, #-0]
    10ac:	00000000 	andeq	r0, r0, r0
    10b0:	00077b18 	andeq	r7, r7, r8, lsl fp
    10b4:	0e560600 	cdpeq	6, 5, cr0, cr6, cr0, {0}
    10b8:	00000a9e 	muleq	r0, lr, sl
    10bc:	0005fa01 	andeq	pc, r5, r1, lsl #20
    10c0:	00061900 	andeq	r1, r6, r0, lsl #18
    10c4:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
    10c8:	a9140000 	ldmdbge	r4, {}	; <UNPREDICTABLE>
    10cc:	14000000 	strne	r0, [r0], #-0
    10d0:	0000004d 	andeq	r0, r0, sp, asr #32
    10d4:	00004d14 	andeq	r4, r0, r4, lsl sp
    10d8:	004d1400 	subeq	r1, sp, r0, lsl #8
    10dc:	a6140000 	ldrge	r0, [r4], -r0
    10e0:	00000006 	andeq	r0, r0, r6
    10e4:	000a0418 	andeq	r0, sl, r8, lsl r4
    10e8:	0e580600 	cdpeq	6, 5, cr0, cr8, cr0, {0}
    10ec:	000005cd 	andeq	r0, r0, sp, asr #11
    10f0:	00062e01 	andeq	r2, r6, r1, lsl #28
    10f4:	00064d00 	andeq	r4, r6, r0, lsl #26
    10f8:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
    10fc:	e0140000 	ands	r0, r4, r0
    1100:	14000000 	strne	r0, [r0], #-0
    1104:	0000004d 	andeq	r0, r0, sp, asr #32
    1108:	00004d14 	andeq	r4, r0, r4, lsl sp
    110c:	004d1400 	subeq	r1, sp, r0, lsl #8
    1110:	a6140000 	ldrge	r0, [r4], -r0
    1114:	00000006 	andeq	r0, r0, r6
    1118:	00055319 	andeq	r5, r5, r9, lsl r3
    111c:	0e5b0600 	cdpeq	6, 5, cr0, cr11, cr0, {0}
    1120:	0000058a 	andeq	r0, r0, sl, lsl #11
    1124:	000001f0 	strdeq	r0, [r0], -r0	; <UNPREDICTABLE>
    1128:	00066201 	andeq	r6, r6, r1, lsl #4
    112c:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
    1130:	68140000 	ldmdavs	r4, {}	; <UNPREDICTABLE>
    1134:	14000003 	strne	r0, [r0], #-3
    1138:	000006ac 	andeq	r0, r0, ip, lsr #13
    113c:	f1030000 			; <UNDEFINED> instruction: 0xf1030000
    1140:	0d000003 	stceq	0, cr0, [r0, #-12]
    1144:	0003f104 	andeq	pc, r3, r4, lsl #2
    1148:	03e51a00 	mvneq	r1, #0, 20
    114c:	068b0000 	streq	r0, [fp], r0
    1150:	06910000 	ldreq	r0, [r1], r0
    1154:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
    1158:	00000006 	andeq	r0, r0, r6
    115c:	0003f11b 	andeq	pc, r3, fp, lsl r1	; <UNPREDICTABLE>
    1160:	00067e00 	andeq	r7, r6, r0, lsl #28
    1164:	3f040d00 	svccc	0x00040d00
    1168:	0d000000 	stceq	0, cr0, [r0, #-0]
    116c:	00067304 	andeq	r7, r6, r4, lsl #6
    1170:	65041c00 	strvs	r1, [r4, #-3072]	; 0xfffff400
    1174:	1d000000 	stcne	0, cr0, [r0, #-0]
    1178:	002c0f04 	eoreq	r0, ip, r4, lsl #30
    117c:	06be0000 	ldrteq	r0, [lr], r0
    1180:	5e100000 	cdppl	0, 1, cr0, cr0, cr0, {0}
    1184:	09000000 	stmdbeq	r0, {}	; <UNPREDICTABLE>
    1188:	06ae0300 	strteq	r0, [lr], r0, lsl #6
    118c:	1e1e0000 	cdpne	0, 1, cr0, cr14, cr0, {0}
    1190:	0100000d 	tsteq	r0, sp
    1194:	06be0ca4 	ldrteq	r0, [lr], r4, lsr #25
    1198:	03050000 	movweq	r0, #20480	; 0x5000
    119c:	00008f90 	muleq	r0, r0, pc	; <UNPREDICTABLE>
    11a0:	000c8e1f 	andeq	r8, ip, pc, lsl lr
    11a4:	0aa60100 	beq	fe9815ac <__bss_end+0xfe9785ec>
    11a8:	00000db0 			; <UNDEFINED> instruction: 0x00000db0
    11ac:	0000004d 	andeq	r0, r0, sp, asr #32
    11b0:	0000876c 	andeq	r8, r0, ip, ror #14
    11b4:	000000b0 	strheq	r0, [r0], -r0	; <UNPREDICTABLE>
    11b8:	07339c01 	ldreq	r9, [r3, -r1, lsl #24]!
    11bc:	3e200000 	cdpcc	0, 2, cr0, cr0, cr0, {0}
    11c0:	01000010 	tsteq	r0, r0, lsl r0
    11c4:	01f71ba6 	mvnseq	r1, r6, lsr #23
    11c8:	91030000 	mrsls	r0, (UNDEF: 3)
    11cc:	0f207fac 	svceq	0x00207fac
    11d0:	0100000e 	tsteq	r0, lr
    11d4:	004d2aa6 	subeq	r2, sp, r6, lsr #21
    11d8:	91030000 	mrsls	r0, (UNDEF: 3)
    11dc:	991e7fa8 	ldmdbls	lr, {r3, r5, r7, r8, r9, sl, fp, ip, sp, lr}
    11e0:	0100000d 	tsteq	r0, sp
    11e4:	07330aa8 	ldreq	r0, [r3, -r8, lsr #21]!
    11e8:	91030000 	mrsls	r0, (UNDEF: 3)
    11ec:	891e7fb4 	ldmdbhi	lr, {r2, r4, r5, r7, r8, r9, sl, fp, ip, sp, lr}
    11f0:	0100000c 	tsteq	r0, ip
    11f4:	003809ac 	eorseq	r0, r8, ip, lsr #19
    11f8:	91020000 	mrsls	r0, (UNDEF: 2)
    11fc:	250f0074 	strcs	r0, [pc, #-116]	; 1190 <shift+0x1190>
    1200:	43000000 	movwmi	r0, #0
    1204:	10000007 	andne	r0, r0, r7
    1208:	0000005e 	andeq	r0, r0, lr, asr r0
    120c:	f421003f 	vld4.8	{d0-d3}, [r1 :256]
    1210:	0100000d 	tsteq	r0, sp
    1214:	0ec10a98 			; <UNDEFINED> instruction: 0x0ec10a98
    1218:	004d0000 	subeq	r0, sp, r0
    121c:	87300000 	ldrhi	r0, [r0, -r0]!
    1220:	003c0000 	eorseq	r0, ip, r0
    1224:	9c010000 	stcls	0, cr0, [r1], {-0}
    1228:	00000780 	andeq	r0, r0, r0, lsl #15
    122c:	71657222 	cmnvc	r5, r2, lsr #4
    1230:	209a0100 	addscs	r0, sl, r0, lsl #2
    1234:	000003ab 	andeq	r0, r0, fp, lsr #7
    1238:	1e749102 	expnes	f1, f2
    123c:	00000da5 	andeq	r0, r0, r5, lsr #27
    1240:	4d0e9b01 	vstrmi	d9, [lr, #-4]
    1244:	02000000 	andeq	r0, r0, #0
    1248:	23007091 	movwcs	r7, #145	; 0x91
    124c:	00000e18 	andeq	r0, r0, r8, lsl lr
    1250:	aa068f01 	bge	1a4e5c <__bss_end+0x19be9c>
    1254:	f400000c 	vst4.8	{d0-d3}, [r0], ip
    1258:	3c000086 	stccc	0, cr0, [r0], {134}	; 0x86
    125c:	01000000 	mrseq	r0, (UNDEF: 0)
    1260:	0007b99c 	muleq	r7, ip, r9
    1264:	0cec2000 	stcleq	0, cr2, [ip]
    1268:	8f010000 	svchi	0x00010000
    126c:	00004d21 	andeq	r4, r0, r1, lsr #26
    1270:	6c910200 	lfmvs	f0, 4, [r1], {0}
    1274:	71657222 	cmnvc	r5, r2, lsr #4
    1278:	20910100 	addscs	r0, r1, r0, lsl #2
    127c:	000003ab 	andeq	r0, r0, fp, lsr #7
    1280:	00749102 	rsbseq	r9, r4, r2, lsl #2
    1284:	000dd121 	andeq	sp, sp, r1, lsr #2
    1288:	0a830100 	beq	fe0c1690 <__bss_end+0xfe0b86d0>
    128c:	00000d3a 	andeq	r0, r0, sl, lsr sp
    1290:	0000004d 	andeq	r0, r0, sp, asr #32
    1294:	000086b8 			; <UNDEFINED> instruction: 0x000086b8
    1298:	0000003c 	andeq	r0, r0, ip, lsr r0
    129c:	07f69c01 	ldrbeq	r9, [r6, r1, lsl #24]!
    12a0:	72220000 	eorvc	r0, r2, #0
    12a4:	01007165 	tsteq	r0, r5, ror #2
    12a8:	03872085 	orreq	r2, r7, #133	; 0x85
    12ac:	91020000 	mrsls	r0, (UNDEF: 2)
    12b0:	0c821e74 	stceq	14, cr1, [r2], {116}	; 0x74
    12b4:	86010000 	strhi	r0, [r1], -r0
    12b8:	00004d0e 	andeq	r4, r0, lr, lsl #26
    12bc:	70910200 	addsvc	r0, r1, r0, lsl #4
    12c0:	10212100 	eorne	r2, r1, r0, lsl #2
    12c4:	77010000 	strvc	r0, [r1, -r0]
    12c8:	000d000a 	andeq	r0, sp, sl
    12cc:	00004d00 	andeq	r4, r0, r0, lsl #26
    12d0:	00867c00 	addeq	r7, r6, r0, lsl #24
    12d4:	00003c00 	andeq	r3, r0, r0, lsl #24
    12d8:	339c0100 	orrscc	r0, ip, #0, 2
    12dc:	22000008 	andcs	r0, r0, #8
    12e0:	00716572 	rsbseq	r6, r1, r2, ror r5
    12e4:	87207901 	strhi	r7, [r0, -r1, lsl #18]!
    12e8:	02000003 	andeq	r0, r0, #3
    12ec:	821e7491 	andshi	r7, lr, #-1862270976	; 0x91000000
    12f0:	0100000c 	tsteq	r0, ip
    12f4:	004d0e7a 	subeq	r0, sp, sl, ror lr
    12f8:	91020000 	mrsls	r0, (UNDEF: 2)
    12fc:	4e210070 	mcrmi	0, 1, r0, cr1, cr0, {3}
    1300:	0100000d 	tsteq	r0, sp
    1304:	0e91066b 	cdpeq	6, 9, cr0, cr1, cr11, {3}
    1308:	01f00000 	mvnseq	r0, r0
    130c:	86280000 	strthi	r0, [r8], -r0
    1310:	00540000 	subseq	r0, r4, r0
    1314:	9c010000 	stcls	0, cr0, [r1], {-0}
    1318:	0000087f 	andeq	r0, r0, pc, ror r8
    131c:	000da520 	andeq	sl, sp, r0, lsr #10
    1320:	156b0100 	strbne	r0, [fp, #-256]!	; 0xffffff00
    1324:	0000004d 	andeq	r0, r0, sp, asr #32
    1328:	206c9102 	rsbcs	r9, ip, r2, lsl #2
    132c:	00000692 	muleq	r0, r2, r6
    1330:	4d256b01 	fstmdbxmi	r5!, {d6-d5}	;@ Deprecated
    1334:	02000000 	andeq	r0, r0, #0
    1338:	191e6891 	ldmdbne	lr, {r0, r4, r7, fp, sp, lr}
    133c:	01000010 	tsteq	r0, r0, lsl r0
    1340:	004d0e6d 	subeq	r0, sp, sp, ror #28
    1344:	91020000 	mrsls	r0, (UNDEF: 2)
    1348:	c1210074 			; <UNDEFINED> instruction: 0xc1210074
    134c:	0100000c 	tsteq	r0, ip
    1350:	0ef8125e 	mrceq	2, 7, r1, cr8, cr14, {2}
    1354:	008b0000 	addeq	r0, fp, r0
    1358:	85d80000 	ldrbhi	r0, [r8]
    135c:	00500000 	subseq	r0, r0, r0
    1360:	9c010000 	stcls	0, cr0, [r1], {-0}
    1364:	000008da 	ldrdeq	r0, [r0], -sl
    1368:	000bdf20 	andeq	sp, fp, r0, lsr #30
    136c:	205e0100 	subscs	r0, lr, r0, lsl #2
    1370:	0000004d 	andeq	r0, r0, sp, asr #32
    1374:	206c9102 	rsbcs	r9, ip, r2, lsl #2
    1378:	00000dda 	ldrdeq	r0, [r0], -sl
    137c:	4d2f5e01 	stcmi	14, cr5, [pc, #-4]!	; 1380 <shift+0x1380>
    1380:	02000000 	andeq	r0, r0, #0
    1384:	92206891 	eorls	r6, r0, #9502720	; 0x910000
    1388:	01000006 	tsteq	r0, r6
    138c:	004d3f5e 	subeq	r3, sp, lr, asr pc
    1390:	91020000 	mrsls	r0, (UNDEF: 2)
    1394:	10191e64 	andsne	r1, r9, r4, ror #28
    1398:	60010000 	andvs	r0, r1, r0
    139c:	00008b16 	andeq	r8, r0, r6, lsl fp
    13a0:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    13a4:	0f2e2100 	svceq	0x002e2100
    13a8:	52010000 	andpl	r0, r1, #0
    13ac:	000cc60a 	andeq	ip, ip, sl, lsl #12
    13b0:	00004d00 	andeq	r4, r0, r0, lsl #26
    13b4:	00859400 	addeq	r9, r5, r0, lsl #8
    13b8:	00004400 	andeq	r4, r0, r0, lsl #8
    13bc:	269c0100 	ldrcs	r0, [ip], r0, lsl #2
    13c0:	20000009 	andcs	r0, r0, r9
    13c4:	00000bdf 	ldrdeq	r0, [r0], -pc	; <UNPREDICTABLE>
    13c8:	4d1a5201 	lfmmi	f5, 4, [sl, #-4]
    13cc:	02000000 	andeq	r0, r0, #0
    13d0:	da206c91 	ble	81c61c <__bss_end+0x81365c>
    13d4:	0100000d 	tsteq	r0, sp
    13d8:	004d2952 	subeq	r2, sp, r2, asr r9
    13dc:	91020000 	mrsls	r0, (UNDEF: 2)
    13e0:	0f271e68 	svceq	0x00271e68
    13e4:	54010000 	strpl	r0, [r1], #-0
    13e8:	00004d0e 	andeq	r4, r0, lr, lsl #26
    13ec:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    13f0:	0f212100 	svceq	0x00212100
    13f4:	45010000 	strmi	r0, [r1, #-0]
    13f8:	000f030a 	andeq	r0, pc, sl, lsl #6
    13fc:	00004d00 	andeq	r4, r0, r0, lsl #26
    1400:	00854400 	addeq	r4, r5, r0, lsl #8
    1404:	00005000 	andeq	r5, r0, r0
    1408:	819c0100 	orrshi	r0, ip, r0, lsl #2
    140c:	20000009 	andcs	r0, r0, r9
    1410:	00000bdf 	ldrdeq	r0, [r0], -pc	; <UNPREDICTABLE>
    1414:	4d194501 	cfldr32mi	mvfx4, [r9, #-4]
    1418:	02000000 	andeq	r0, r0, #0
    141c:	7a206c91 	bvc	81c668 <__bss_end+0x8136a8>
    1420:	0100000d 	tsteq	r0, sp
    1424:	011d3045 	tsteq	sp, r5, asr #32
    1428:	91020000 	mrsls	r0, (UNDEF: 2)
    142c:	0de02068 	stcleq	0, cr2, [r0, #416]!	; 0x1a0
    1430:	45010000 	strmi	r0, [r1, #-0]
    1434:	0006ac41 	andeq	sl, r6, r1, asr #24
    1438:	64910200 	ldrvs	r0, [r1], #512	; 0x200
    143c:	0010191e 	andseq	r1, r0, lr, lsl r9
    1440:	0e470100 	dvfeqs	f0, f7, f0
    1444:	0000004d 	andeq	r0, r0, sp, asr #32
    1448:	00749102 	rsbseq	r9, r4, r2, lsl #2
    144c:	000c6f23 	andeq	r6, ip, r3, lsr #30
    1450:	063f0100 	ldrteq	r0, [pc], -r0, lsl #2
    1454:	00000d84 	andeq	r0, r0, r4, lsl #27
    1458:	00008518 	andeq	r8, r0, r8, lsl r5
    145c:	0000002c 	andeq	r0, r0, ip, lsr #32
    1460:	09ab9c01 	stmibeq	fp!, {r0, sl, fp, ip, pc}
    1464:	df200000 	svcle	0x00200000
    1468:	0100000b 	tsteq	r0, fp
    146c:	004d153f 	subeq	r1, sp, pc, lsr r5
    1470:	91020000 	mrsls	r0, (UNDEF: 2)
    1474:	9f210074 	svcls	0x00210074
    1478:	0100000d 	tsteq	r0, sp
    147c:	0de60a32 			; <UNDEFINED> instruction: 0x0de60a32
    1480:	004d0000 	subeq	r0, sp, r0
    1484:	84c80000 	strbhi	r0, [r8], #0
    1488:	00500000 	subseq	r0, r0, r0
    148c:	9c010000 	stcls	0, cr0, [r1], {-0}
    1490:	00000a06 	andeq	r0, r0, r6, lsl #20
    1494:	000bdf20 	andeq	sp, fp, r0, lsr #30
    1498:	19320100 	ldmdbne	r2!, {r8}
    149c:	0000004d 	andeq	r0, r0, sp, asr #32
    14a0:	206c9102 	rsbcs	r9, ip, r2, lsl #2
    14a4:	00000f44 	andeq	r0, r0, r4, asr #30
    14a8:	f72b3201 			; <UNDEFINED> instruction: 0xf72b3201
    14ac:	02000001 	andeq	r0, r0, #1
    14b0:	13206891 			; <UNDEFINED> instruction: 0x13206891
    14b4:	0100000e 	tsteq	r0, lr
    14b8:	004d3c32 	subeq	r3, sp, r2, lsr ip
    14bc:	91020000 	mrsls	r0, (UNDEF: 2)
    14c0:	0ef21e64 	cdpeq	14, 15, cr1, cr2, cr4, {3}
    14c4:	34010000 	strcc	r0, [r1], #-0
    14c8:	00004d0e 	andeq	r4, r0, lr, lsl #26
    14cc:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    14d0:	10432100 	subne	r2, r3, r0, lsl #2
    14d4:	25010000 	strcs	r0, [r1, #-0]
    14d8:	000f4b0a 	andeq	r4, pc, sl, lsl #22
    14dc:	00004d00 	andeq	r4, r0, r0, lsl #26
    14e0:	00847800 	addeq	r7, r4, r0, lsl #16
    14e4:	00005000 	andeq	r5, r0, r0
    14e8:	619c0100 	orrsvs	r0, ip, r0, lsl #2
    14ec:	2000000a 	andcs	r0, r0, sl
    14f0:	00000bdf 	ldrdeq	r0, [r0], -pc	; <UNPREDICTABLE>
    14f4:	4d182501 	cfldr32mi	mvfx2, [r8, #-4]
    14f8:	02000000 	andeq	r0, r0, #0
    14fc:	44206c91 	strtmi	r6, [r0], #-3217	; 0xfffff36f
    1500:	0100000f 	tsteq	r0, pc
    1504:	0a672a25 	beq	19cbda0 <__bss_end+0x19c2de0>
    1508:	91020000 	mrsls	r0, (UNDEF: 2)
    150c:	0e132068 	cdpeq	0, 1, cr2, cr3, cr8, {3}
    1510:	25010000 	strcs	r0, [r1, #-0]
    1514:	00004d3b 	andeq	r4, r0, fp, lsr sp
    1518:	64910200 	ldrvs	r0, [r1], #512	; 0x200
    151c:	000c931e 	andeq	r9, ip, lr, lsl r3
    1520:	0e270100 	sufeqs	f0, f7, f0
    1524:	0000004d 	andeq	r0, r0, sp, asr #32
    1528:	00749102 	rsbseq	r9, r4, r2, lsl #2
    152c:	0025040d 	eoreq	r0, r5, sp, lsl #8
    1530:	61030000 	mrsvs	r0, (UNDEF: 3)
    1534:	2100000a 	tstcs	r0, sl
    1538:	00000dab 	andeq	r0, r0, fp, lsr #27
    153c:	4f0a1901 	svcmi	0x000a1901
    1540:	4d000010 	stcmi	0, cr0, [r0, #-64]	; 0xffffffc0
    1544:	34000000 	strcc	r0, [r0], #-0
    1548:	44000084 	strmi	r0, [r0], #-132	; 0xffffff7c
    154c:	01000000 	mrseq	r0, (UNDEF: 0)
    1550:	000ab89c 	muleq	sl, ip, r8
    1554:	103a2000 	eorsne	r2, sl, r0
    1558:	19010000 	stmdbne	r1, {}	; <UNPREDICTABLE>
    155c:	0001f71b 	andeq	pc, r1, fp, lsl r7	; <UNPREDICTABLE>
    1560:	6c910200 	lfmvs	f0, 4, [r1], {0}
    1564:	000f3f20 	andeq	r3, pc, r0, lsr #30
    1568:	35190100 	ldrcc	r0, [r9, #-256]	; 0xffffff00
    156c:	000001c6 	andeq	r0, r0, r6, asr #3
    1570:	1e689102 	lgnnee	f1, f2
    1574:	00000bdf 	ldrdeq	r0, [r0], -pc	; <UNPREDICTABLE>
    1578:	4d0e1b01 	vstrmi	d1, [lr, #-4]
    157c:	02000000 	andeq	r0, r0, #0
    1580:	24007491 	strcs	r7, [r0], #-1169	; 0xfffffb6f
    1584:	00000ce0 	andeq	r0, r0, r0, ror #25
    1588:	99061401 	stmdbls	r6, {r0, sl, ip}
    158c:	1800000c 	stmdane	r0, {r2, r3}
    1590:	1c000084 	stcne	0, cr0, [r0], {132}	; 0x84
    1594:	01000000 	mrseq	r0, (UNDEF: 0)
    1598:	0f35239c 	svceq	0x0035239c
    159c:	0e010000 	cdpeq	0, 0, cr0, cr1, cr0, {0}
    15a0:	000d6c06 	andeq	r6, sp, r6, lsl #24
    15a4:	0083ec00 	addeq	lr, r3, r0, lsl #24
    15a8:	00002c00 	andeq	r2, r0, r0, lsl #24
    15ac:	f89c0100 			; <UNDEFINED> instruction: 0xf89c0100
    15b0:	2000000a 	andcs	r0, r0, sl
    15b4:	00000cd7 	ldrdeq	r0, [r0], -r7
    15b8:	38140e01 	ldmdacc	r4, {r0, r9, sl, fp}
    15bc:	02000000 	andeq	r0, r0, #0
    15c0:	25007491 	strcs	r7, [r0, #-1169]	; 0xfffffb6f
    15c4:	00001048 	andeq	r1, r0, r8, asr #32
    15c8:	8e0a0401 	cdphi	4, 0, cr0, cr10, cr1, {0}
    15cc:	4d00000d 	stcmi	0, cr0, [r0, #-52]	; 0xffffffcc
    15d0:	c0000000 	andgt	r0, r0, r0
    15d4:	2c000083 	stccs	0, cr0, [r0], {131}	; 0x83
    15d8:	01000000 	mrseq	r0, (UNDEF: 0)
    15dc:	6970229c 	ldmdbvs	r0!, {r2, r3, r4, r7, r9, sp}^
    15e0:	06010064 	streq	r0, [r1], -r4, rrx
    15e4:	00004d0e 	andeq	r4, r0, lr, lsl #26
    15e8:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    15ec:	032e0000 			; <UNDEFINED> instruction: 0x032e0000
    15f0:	00040000 	andeq	r0, r4, r0
    15f4:	00000689 	andeq	r0, r0, r9, lsl #13
    15f8:	0f570104 	svceq	0x00570104
    15fc:	8f040000 	svchi	0x00040000
    1600:	24000010 	strcs	r0, [r0], #-16
    1604:	1c00000c 	stcne	0, cr0, [r0], {12}
    1608:	b8000088 	stmdalt	r0, {r3, r7}
    160c:	2f000004 	svccs	0x00000004
    1610:	02000008 	andeq	r0, r0, #8
    1614:	00000049 	andeq	r0, r0, r9, asr #32
    1618:	0010f803 	andseq	pc, r0, r3, lsl #16
    161c:	10050100 	andne	r0, r5, r0, lsl #2
    1620:	00000061 	andeq	r0, r0, r1, rrx
    1624:	32313011 	eorscc	r3, r1, #17
    1628:	36353433 			; <UNDEFINED> instruction: 0x36353433
    162c:	41393837 	teqmi	r9, r7, lsr r8
    1630:	45444342 	strbmi	r4, [r4, #-834]	; 0xfffffcbe
    1634:	04000046 	streq	r0, [r0], #-70	; 0xffffffba
    1638:	25010301 	strcs	r0, [r1, #-769]	; 0xfffffcff
    163c:	05000000 	streq	r0, [r0, #-0]
    1640:	00000074 	andeq	r0, r0, r4, ror r0
    1644:	00000061 	andeq	r0, r0, r1, rrx
    1648:	00006606 	andeq	r6, r0, r6, lsl #12
    164c:	07001000 	streq	r1, [r0, -r0]
    1650:	00000051 	andeq	r0, r0, r1, asr r0
    1654:	3a070408 	bcc	1c267c <__bss_end+0x1b96bc>
    1658:	08000007 	stmdaeq	r0, {r0, r1, r2}
    165c:	09310801 	ldmdbeq	r1!, {r0, fp}
    1660:	6d070000 	stcvs	0, cr0, [r7, #-0]
    1664:	09000000 	stmdbeq	r0, {}	; <UNPREDICTABLE>
    1668:	0000002a 	andeq	r0, r0, sl, lsr #32
    166c:	0011270a 	andseq	r2, r1, sl, lsl #14
    1670:	06640100 	strbteq	r0, [r4], -r0, lsl #2
    1674:	00001112 	andeq	r1, r0, r2, lsl r1
    1678:	00008c54 	andeq	r8, r0, r4, asr ip
    167c:	00000080 	andeq	r0, r0, r0, lsl #1
    1680:	00fb9c01 	rscseq	r9, fp, r1, lsl #24
    1684:	730b0000 	movwvc	r0, #45056	; 0xb000
    1688:	01006372 	tsteq	r0, r2, ror r3
    168c:	00fb1964 	rscseq	r1, fp, r4, ror #18
    1690:	91020000 	mrsls	r0, (UNDEF: 2)
    1694:	73640b64 	cmnvc	r4, #100, 22	; 0x19000
    1698:	64010074 	strvs	r0, [r1], #-116	; 0xffffff8c
    169c:	00010224 	andeq	r0, r1, r4, lsr #4
    16a0:	60910200 	addsvs	r0, r1, r0, lsl #4
    16a4:	6d756e0b 	ldclvs	14, cr6, [r5, #-44]!	; 0xffffffd4
    16a8:	2d640100 	stfcse	f0, [r4, #-0]
    16ac:	00000104 	andeq	r0, r0, r4, lsl #2
    16b0:	0c5c9102 	ldfeqp	f1, [ip], {2}
    16b4:	00001181 	andeq	r1, r0, r1, lsl #3
    16b8:	0b0e6601 	bleq	39aec4 <__bss_end+0x391f04>
    16bc:	02000001 	andeq	r0, r0, #1
    16c0:	040c7091 	streq	r7, [ip], #-145	; 0xffffff6f
    16c4:	01000011 	tsteq	r0, r1, lsl r0
    16c8:	01110867 	tsteq	r1, r7, ror #16
    16cc:	91020000 	mrsls	r0, (UNDEF: 2)
    16d0:	8c7c0d6c 	ldclhi	13, cr0, [ip], #-432	; 0xfffffe50
    16d4:	00480000 	subeq	r0, r8, r0
    16d8:	690e0000 	stmdbvs	lr, {}	; <UNPREDICTABLE>
    16dc:	0b690100 	bleq	1a41ae4 <__bss_end+0x1a38b24>
    16e0:	00000104 	andeq	r0, r0, r4, lsl #2
    16e4:	00749102 	rsbseq	r9, r4, r2, lsl #2
    16e8:	01040f00 	tsteq	r4, r0, lsl #30
    16ec:	10000001 	andne	r0, r0, r1
    16f0:	04120411 	ldreq	r0, [r2], #-1041	; 0xfffffbef
    16f4:	746e6905 	strbtvc	r6, [lr], #-2309	; 0xfffff6fb
    16f8:	74040f00 	strvc	r0, [r4], #-3840	; 0xfffff100
    16fc:	0f000000 	svceq	0x00000000
    1700:	00006d04 	andeq	r6, r0, r4, lsl #26
    1704:	10760a00 	rsbsne	r0, r6, r0, lsl #20
    1708:	5c010000 	stcpl	0, cr0, [r1], {-0}
    170c:	00108306 	andseq	r8, r0, r6, lsl #6
    1710:	008bec00 	addeq	lr, fp, r0, lsl #24
    1714:	00006800 	andeq	r6, r0, r0, lsl #16
    1718:	769c0100 	ldrvc	r0, [ip], r0, lsl #2
    171c:	13000001 	movwne	r0, #1
    1720:	0000117a 	andeq	r1, r0, sl, ror r1
    1724:	02125c01 	andseq	r5, r2, #256	; 0x100
    1728:	02000001 	andeq	r0, r0, #1
    172c:	7c136c91 	ldcvc	12, cr6, [r3], {145}	; 0x91
    1730:	01000010 	tsteq	r0, r0, lsl r0
    1734:	01041e5c 	tsteq	r4, ip, asr lr
    1738:	91020000 	mrsls	r0, (UNDEF: 2)
    173c:	656d0e68 	strbvs	r0, [sp, #-3688]!	; 0xfffff198
    1740:	5e01006d 	cdppl	0, 0, cr0, cr1, cr13, {3}
    1744:	00011108 	andeq	r1, r1, r8, lsl #2
    1748:	70910200 	addsvc	r0, r1, r0, lsl #4
    174c:	008c080d 	addeq	r0, ip, sp, lsl #16
    1750:	00003c00 	andeq	r3, r0, r0, lsl #24
    1754:	00690e00 	rsbeq	r0, r9, r0, lsl #28
    1758:	040b6001 	streq	r6, [fp], #-1
    175c:	02000001 	andeq	r0, r0, #1
    1760:	00007491 	muleq	r0, r1, r4
    1764:	00112e14 	andseq	r2, r1, r4, lsl lr
    1768:	05520100 	ldrbeq	r0, [r2, #-256]	; 0xffffff00
    176c:	00001147 	andeq	r1, r0, r7, asr #2
    1770:	00000104 	andeq	r0, r0, r4, lsl #2
    1774:	00008b98 	muleq	r0, r8, fp
    1778:	00000054 	andeq	r0, r0, r4, asr r0
    177c:	01af9c01 			; <UNDEFINED> instruction: 0x01af9c01
    1780:	730b0000 	movwvc	r0, #45056	; 0xb000
    1784:	18520100 	ldmdane	r2, {r8}^
    1788:	0000010b 	andeq	r0, r0, fp, lsl #2
    178c:	0e6c9102 	lgneqe	f1, f2
    1790:	54010069 	strpl	r0, [r1], #-105	; 0xffffff97
    1794:	00010406 	andeq	r0, r1, r6, lsl #8
    1798:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    179c:	116a1400 	cmnne	sl, r0, lsl #8
    17a0:	42010000 	andmi	r0, r1, #0
    17a4:	00113505 	andseq	r3, r1, r5, lsl #10
    17a8:	00010400 	andeq	r0, r1, r0, lsl #8
    17ac:	008aec00 	addeq	lr, sl, r0, lsl #24
    17b0:	0000ac00 	andeq	sl, r0, r0, lsl #24
    17b4:	159c0100 	ldrne	r0, [ip, #256]	; 0x100
    17b8:	0b000002 	bleq	17c8 <shift+0x17c8>
    17bc:	01003173 	tsteq	r0, r3, ror r1
    17c0:	010b1942 	tsteq	fp, r2, asr #18
    17c4:	91020000 	mrsls	r0, (UNDEF: 2)
    17c8:	32730b6c 	rsbscc	r0, r3, #108, 22	; 0x1b000
    17cc:	29420100 	stmdbcs	r2, {r8}^
    17d0:	0000010b 	andeq	r0, r0, fp, lsl #2
    17d4:	0b689102 	bleq	1a25be4 <__bss_end+0x1a1cc24>
    17d8:	006d756e 	rsbeq	r7, sp, lr, ror #10
    17dc:	04314201 	ldrteq	r4, [r1], #-513	; 0xfffffdff
    17e0:	02000001 	andeq	r0, r0, #1
    17e4:	750e6491 	strvc	r6, [lr, #-1169]	; 0xfffffb6f
    17e8:	44010031 	strmi	r0, [r1], #-49	; 0xffffffcf
    17ec:	00021510 	andeq	r1, r2, r0, lsl r5
    17f0:	77910200 	ldrvc	r0, [r1, r0, lsl #4]
    17f4:	0032750e 	eorseq	r7, r2, lr, lsl #10
    17f8:	15144401 	ldrne	r4, [r4, #-1025]	; 0xfffffbff
    17fc:	02000002 	andeq	r0, r0, #2
    1800:	08007691 	stmdaeq	r0, {r0, r4, r7, r9, sl, ip, sp, lr}
    1804:	09280801 	stmdbeq	r8!, {r0, fp}
    1808:	72140000 	andsvc	r0, r4, #0
    180c:	01000011 	tsteq	r0, r1, lsl r0
    1810:	11590736 	cmpne	r9, r6, lsr r7
    1814:	01110000 	tsteq	r1, r0
    1818:	8a2c0000 	bhi	b01820 <__bss_end+0xaf8860>
    181c:	00c00000 	sbceq	r0, r0, r0
    1820:	9c010000 	stcls	0, cr0, [r1], {-0}
    1824:	00000275 	andeq	r0, r0, r5, ror r2
    1828:	00107113 	andseq	r7, r0, r3, lsl r1
    182c:	15360100 	ldrne	r0, [r6, #-256]!	; 0xffffff00
    1830:	00000111 	andeq	r0, r0, r1, lsl r1
    1834:	0b6c9102 	bleq	1b25c44 <__bss_end+0x1b1cc84>
    1838:	00637273 	rsbeq	r7, r3, r3, ror r2
    183c:	0b273601 	bleq	9cf048 <__bss_end+0x9c6088>
    1840:	02000001 	andeq	r0, r0, #1
    1844:	6e0b6891 	mcrvs	8, 0, r6, cr11, cr1, {4}
    1848:	01006d75 	tsteq	r0, r5, ror sp
    184c:	01043036 	tsteq	r4, r6, lsr r0
    1850:	91020000 	mrsls	r0, (UNDEF: 2)
    1854:	00690e64 	rsbeq	r0, r9, r4, ror #28
    1858:	04063801 	streq	r3, [r6], #-2049	; 0xfffff7ff
    185c:	02000001 	andeq	r0, r0, #1
    1860:	14007491 	strne	r7, [r0], #-1169	; 0xfffffb6f
    1864:	00001154 	andeq	r1, r0, r4, asr r1
    1868:	ed052401 	cfstrs	mvf2, [r5, #-4]
    186c:	04000010 	streq	r0, [r0], #-16
    1870:	90000001 	andls	r0, r0, r1
    1874:	9c000089 	stcls	0, cr0, [r0], {137}	; 0x89
    1878:	01000000 	mrseq	r0, (UNDEF: 0)
    187c:	0002b29c 	muleq	r2, ip, r2
    1880:	106b1300 	rsbne	r1, fp, r0, lsl #6
    1884:	24010000 	strcs	r0, [r1], #-0
    1888:	00010b16 	andeq	r0, r1, r6, lsl fp
    188c:	6c910200 	lfmvs	f0, 4, [r1], {0}
    1890:	00110b0c 	andseq	r0, r1, ip, lsl #22
    1894:	06260100 	strteq	r0, [r6], -r0, lsl #2
    1898:	00000104 	andeq	r0, r0, r4, lsl #2
    189c:	00749102 	rsbseq	r9, r4, r2, lsl #2
    18a0:	00118815 	andseq	r8, r1, r5, lsl r8
    18a4:	06080100 	streq	r0, [r8], -r0, lsl #2
    18a8:	0000118d 	andeq	r1, r0, sp, lsl #3
    18ac:	0000881c 	andeq	r8, r0, ip, lsl r8
    18b0:	00000174 	andeq	r0, r0, r4, ror r1
    18b4:	6b139c01 	blvs	4e88c0 <__bss_end+0x4df900>
    18b8:	01000010 	tsteq	r0, r0, lsl r0
    18bc:	00661808 	rsbeq	r1, r6, r8, lsl #16
    18c0:	91020000 	mrsls	r0, (UNDEF: 2)
    18c4:	110b1364 	tstne	fp, r4, ror #6
    18c8:	08010000 	stmdaeq	r1, {}	; <UNPREDICTABLE>
    18cc:	00011125 	andeq	r1, r1, r5, lsr #2
    18d0:	60910200 	addsvs	r0, r1, r0, lsl #4
    18d4:	00112213 	andseq	r2, r1, r3, lsl r2
    18d8:	3a080100 	bcc	201ce0 <__bss_end+0x1f8d20>
    18dc:	00000066 	andeq	r0, r0, r6, rrx
    18e0:	0e5c9102 	logeqe	f1, f2
    18e4:	0a010069 	beq	41a90 <__bss_end+0x38ad0>
    18e8:	00010406 	andeq	r0, r1, r6, lsl #8
    18ec:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    18f0:	0088e80d 	addeq	lr, r8, sp, lsl #16
    18f4:	00009800 	andeq	r9, r0, r0, lsl #16
    18f8:	006a0e00 	rsbeq	r0, sl, r0, lsl #28
    18fc:	040b1c01 	streq	r1, [fp], #-3073	; 0xfffff3ff
    1900:	02000001 	andeq	r0, r0, #1
    1904:	100d7091 	mulne	sp, r1, r0
    1908:	60000089 	andvs	r0, r0, r9, lsl #1
    190c:	0e000000 	cdpeq	0, 0, cr0, cr0, cr0, {0}
    1910:	1e010063 	cdpne	0, 0, cr0, cr1, cr3, {3}
    1914:	00006d08 	andeq	r6, r0, r8, lsl #26
    1918:	6f910200 	svcvs	0x00910200
    191c:	00000000 	andeq	r0, r0, r0

Disassembly of section .debug_abbrev:

00000000 <.debug_abbrev>:
   0:	10001101 	andne	r1, r0, r1, lsl #2
   4:	12011106 	andne	r1, r1, #-2147483647	; 0x80000001
   8:	1b0e0301 	blne	380c14 <__bss_end+0x377c54>
   c:	130e250e 	movwne	r2, #58638	; 0xe50e
  10:	00000005 	andeq	r0, r0, r5
  14:	25011101 	strcs	r1, [r1, #-257]	; 0xfffffeff
  18:	030b130e 	movweq	r1, #45838	; 0xb30e
  1c:	110e1b0e 	tstne	lr, lr, lsl #22
  20:	10061201 	andne	r1, r6, r1, lsl #4
  24:	02000017 	andeq	r0, r0, #23
  28:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
  2c:	0b3b0b3a 	bleq	ec2d1c <__bss_end+0xeb9d5c>
  30:	13490b39 	movtne	r0, #39737	; 0x9b39
  34:	193c193f 	ldmdbne	ip!, {r0, r1, r2, r3, r4, r5, r8, fp, ip}
  38:	24030000 	strcs	r0, [r3], #-0
  3c:	3e0b0b00 	vmlacc.f64	d0, d11, d0
  40:	000e030b 	andeq	r0, lr, fp, lsl #6
  44:	012e0400 			; <UNDEFINED> instruction: 0x012e0400
  48:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
  4c:	0b3b0b3a 	bleq	ec2d3c <__bss_end+0xeb9d7c>
  50:	01110b39 	tsteq	r1, r9, lsr fp
  54:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
  58:	01194296 			; <UNDEFINED> instruction: 0x01194296
  5c:	05000013 	streq	r0, [r0, #-19]	; 0xffffffed
  60:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
  64:	0b3b0b3a 	bleq	ec2d54 <__bss_end+0xeb9d94>
  68:	13490b39 	movtne	r0, #39737	; 0x9b39
  6c:	00001802 	andeq	r1, r0, r2, lsl #16
  70:	0b002406 	bleq	9090 <__bss_end+0xd0>
  74:	030b3e0b 	movweq	r3, #48651	; 0xbe0b
  78:	07000008 	streq	r0, [r0, -r8]
  7c:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
  80:	0b3a0e03 	bleq	e83894 <__bss_end+0xe7a8d4>
  84:	0b390b3b 	bleq	e42d78 <__bss_end+0xe39db8>
  88:	06120111 			; <UNDEFINED> instruction: 0x06120111
  8c:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
  90:	00130119 	andseq	r0, r3, r9, lsl r1
  94:	010b0800 	tsteq	fp, r0, lsl #16
  98:	06120111 			; <UNDEFINED> instruction: 0x06120111
  9c:	34090000 	strcc	r0, [r9], #-0
  a0:	3a080300 	bcc	200ca8 <__bss_end+0x1f7ce8>
  a4:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
  a8:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
  ac:	0a000018 	beq	114 <shift+0x114>
  b0:	0b0b000f 	bleq	2c00f4 <__bss_end+0x2b7134>
  b4:	00001349 	andeq	r1, r0, r9, asr #6
  b8:	01110100 	tsteq	r1, r0, lsl #2
  bc:	0b130e25 	bleq	4c3958 <__bss_end+0x4ba998>
  c0:	0e1b0e03 	cdpeq	14, 1, cr0, cr11, cr3, {0}
  c4:	06120111 			; <UNDEFINED> instruction: 0x06120111
  c8:	00001710 	andeq	r1, r0, r0, lsl r7
  cc:	03001602 	movweq	r1, #1538	; 0x602
  d0:	3b0b3a0e 	blcc	2ce910 <__bss_end+0x2c5950>
  d4:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
  d8:	03000013 	movweq	r0, #19
  dc:	0b0b000f 	bleq	2c0120 <__bss_end+0x2b7160>
  e0:	00001349 	andeq	r1, r0, r9, asr #6
  e4:	00001504 	andeq	r1, r0, r4, lsl #10
  e8:	01010500 	tsteq	r1, r0, lsl #10
  ec:	13011349 	movwne	r1, #4937	; 0x1349
  f0:	21060000 	mrscs	r0, (UNDEF: 6)
  f4:	2f134900 	svccs	0x00134900
  f8:	07000006 	streq	r0, [r0, -r6]
  fc:	0b0b0024 	bleq	2c0194 <__bss_end+0x2b71d4>
 100:	0e030b3e 	vmoveq.16	d3[0], r0
 104:	34080000 	strcc	r0, [r8], #-0
 108:	3a0e0300 	bcc	380d10 <__bss_end+0x377d50>
 10c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 110:	3f13490b 	svccc	0x0013490b
 114:	00193c19 	andseq	r3, r9, r9, lsl ip
 118:	012e0900 			; <UNDEFINED> instruction: 0x012e0900
 11c:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 120:	0b3b0b3a 	bleq	ec2e10 <__bss_end+0xeb9e50>
 124:	13490b39 	movtne	r0, #39737	; 0x9b39
 128:	06120111 			; <UNDEFINED> instruction: 0x06120111
 12c:	42961840 	addsmi	r1, r6, #64, 16	; 0x400000
 130:	00130119 	andseq	r0, r3, r9, lsl r1
 134:	00340a00 	eorseq	r0, r4, r0, lsl #20
 138:	0b3a0e03 	bleq	e8394c <__bss_end+0xe7a98c>
 13c:	0b390b3b 	bleq	e42e30 <__bss_end+0xe39e70>
 140:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 144:	240b0000 	strcs	r0, [fp], #-0
 148:	3e0b0b00 	vmlacc.f64	d0, d11, d0
 14c:	0008030b 	andeq	r0, r8, fp, lsl #6
 150:	002e0c00 	eoreq	r0, lr, r0, lsl #24
 154:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 158:	0b3b0b3a 	bleq	ec2e48 <__bss_end+0xeb9e88>
 15c:	01110b39 	tsteq	r1, r9, lsr fp
 160:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 164:	00194297 	mulseq	r9, r7, r2
 168:	01390d00 	teqeq	r9, r0, lsl #26
 16c:	0b3a0e03 	bleq	e83980 <__bss_end+0xe7a9c0>
 170:	13010b3b 	movwne	r0, #6971	; 0x1b3b
 174:	2e0e0000 	cdpcs	0, 0, cr0, cr14, cr0, {0}
 178:	03193f01 	tsteq	r9, #1, 30
 17c:	3b0b3a0e 	blcc	2ce9bc <__bss_end+0x2c59fc>
 180:	3c0b390b 			; <UNDEFINED> instruction: 0x3c0b390b
 184:	00130119 	andseq	r0, r3, r9, lsl r1
 188:	00050f00 	andeq	r0, r5, r0, lsl #30
 18c:	00001349 	andeq	r1, r0, r9, asr #6
 190:	3f012e10 	svccc	0x00012e10
 194:	3a0e0319 	bcc	380e00 <__bss_end+0x377e40>
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
 1c0:	3a080300 	bcc	200dc8 <__bss_end+0x1f7e08>
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
 1f4:	0b0b0024 	bleq	2c028c <__bss_end+0x2b72cc>
 1f8:	0e030b3e 	vmoveq.16	d3[0], r0
 1fc:	24030000 	strcs	r0, [r3], #-0
 200:	3e0b0b00 	vmlacc.f64	d0, d11, d0
 204:	0008030b 	andeq	r0, r8, fp, lsl #6
 208:	00160400 	andseq	r0, r6, r0, lsl #8
 20c:	0b3a0e03 	bleq	e83a20 <__bss_end+0xe7aa60>
 210:	0b390b3b 	bleq	e42f04 <__bss_end+0xe39f44>
 214:	00001349 	andeq	r1, r0, r9, asr #6
 218:	49002605 	stmdbmi	r0, {r0, r2, r9, sl, sp}
 21c:	06000013 			; <UNDEFINED> instruction: 0x06000013
 220:	0e030113 	mcreq	1, 0, r0, cr3, cr3, {0}
 224:	0b3a0b0b 	bleq	e82e58 <__bss_end+0xe79e98>
 228:	0b390b3b 	bleq	e42f1c <__bss_end+0xe39f5c>
 22c:	00001301 	andeq	r1, r0, r1, lsl #6
 230:	03000d07 	movweq	r0, #3335	; 0xd07
 234:	3b0b3a08 	blcc	2cea5c <__bss_end+0x2c5a9c>
 238:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 23c:	000b3813 	andeq	r3, fp, r3, lsl r8
 240:	01040800 	tsteq	r4, r0, lsl #16
 244:	196d0e03 	stmdbne	sp!, {r0, r1, r9, sl, fp}^
 248:	0b0b0b3e 	bleq	2c2f48 <__bss_end+0x2b9f88>
 24c:	0b3a1349 	bleq	e84f78 <__bss_end+0xe7bfb8>
 250:	0b390b3b 	bleq	e42f44 <__bss_end+0xe39f84>
 254:	00001301 	andeq	r1, r0, r1, lsl #6
 258:	03002809 	movweq	r2, #2057	; 0x809
 25c:	000b1c0e 	andeq	r1, fp, lr, lsl #24
 260:	00340a00 	eorseq	r0, r4, r0, lsl #20
 264:	0b3a0e03 	bleq	e83a78 <__bss_end+0xe7aab8>
 268:	0b390b3b 	bleq	e42f5c <__bss_end+0xe39f9c>
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
 294:	0b3b0b3a 	bleq	ec2f84 <__bss_end+0xeb9fc4>
 298:	13490b39 	movtne	r0, #39737	; 0x9b39
 29c:	00000b38 	andeq	r0, r0, r8, lsr fp
 2a0:	4901010f 	stmdbmi	r1, {r0, r1, r2, r3, r8}
 2a4:	00130113 	andseq	r0, r3, r3, lsl r1
 2a8:	00211000 	eoreq	r1, r1, r0
 2ac:	0b2f1349 	bleq	bc4fd8 <__bss_end+0xbbc018>
 2b0:	02110000 	andseq	r0, r1, #0
 2b4:	0b0e0301 	bleq	380ec0 <__bss_end+0x377f00>
 2b8:	3b0b3a0b 	blcc	2ceaec <__bss_end+0x2c5b2c>
 2bc:	010b390b 	tsteq	fp, fp, lsl #18
 2c0:	12000013 	andne	r0, r0, #19
 2c4:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 2c8:	0b3a0e03 	bleq	e83adc <__bss_end+0xe7ab1c>
 2cc:	0b390b3b 	bleq	e42fc0 <__bss_end+0xe3a000>
 2d0:	193c0e6e 	ldmdbne	ip!, {r1, r2, r3, r5, r6, r9, sl, fp}
 2d4:	13011364 	movwne	r1, #4964	; 0x1364
 2d8:	05130000 	ldreq	r0, [r3, #-0]
 2dc:	34134900 	ldrcc	r4, [r3], #-2304	; 0xfffff700
 2e0:	14000019 	strne	r0, [r0], #-25	; 0xffffffe7
 2e4:	13490005 	movtne	r0, #36869	; 0x9005
 2e8:	2e150000 	cdpcs	0, 1, cr0, cr5, cr0, {0}
 2ec:	03193f01 	tsteq	r9, #1, 30
 2f0:	3b0b3a0e 	blcc	2ceb30 <__bss_end+0x2c5b70>
 2f4:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 2f8:	3c13490e 			; <UNDEFINED> instruction: 0x3c13490e
 2fc:	01136419 	tsteq	r3, r9, lsl r4
 300:	16000013 			; <UNDEFINED> instruction: 0x16000013
 304:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 308:	0b3a0e03 	bleq	e83b1c <__bss_end+0xe7ab5c>
 30c:	0b390b3b 	bleq	e43000 <__bss_end+0xe3a040>
 310:	13490e6e 	movtne	r0, #40558	; 0x9e6e
 314:	193c0b32 	ldmdbne	ip!, {r1, r4, r5, r8, r9, fp}
 318:	13011364 	movwne	r1, #4964	; 0x1364
 31c:	0d170000 	ldceq	0, cr0, [r7, #-0]
 320:	3a0e0300 	bcc	380f28 <__bss_end+0x377f68>
 324:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 328:	3813490b 	ldmdacc	r3, {r0, r1, r3, r8, fp, lr}
 32c:	000b320b 	andeq	r3, fp, fp, lsl #4
 330:	012e1800 			; <UNDEFINED> instruction: 0x012e1800
 334:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 338:	0b3b0b3a 	bleq	ec3028 <__bss_end+0xeba068>
 33c:	0e6e0b39 	vmoveq.8	d14[5], r0
 340:	193c0b32 	ldmdbne	ip!, {r1, r4, r5, r8, r9, fp}
 344:	13011364 	movwne	r1, #4964	; 0x1364
 348:	2e190000 	cdpcs	0, 1, cr0, cr9, cr0, {0}
 34c:	03193f01 	tsteq	r9, #1, 30
 350:	3b0b3a0e 	blcc	2ceb90 <__bss_end+0x2c5bd0>
 354:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 358:	3213490e 	andscc	r4, r3, #229376	; 0x38000
 35c:	64193c0b 	ldrvs	r3, [r9], #-3083	; 0xfffff3f5
 360:	1a000013 	bne	3b4 <shift+0x3b4>
 364:	13490115 	movtne	r0, #37141	; 0x9115
 368:	13011364 	movwne	r1, #4964	; 0x1364
 36c:	1f1b0000 	svcne	0x001b0000
 370:	49131d00 	ldmdbmi	r3, {r8, sl, fp, ip}
 374:	1c000013 	stcne	0, cr0, [r0], {19}
 378:	0b0b0010 	bleq	2c03c0 <__bss_end+0x2b7400>
 37c:	00001349 	andeq	r1, r0, r9, asr #6
 380:	0b000f1d 	bleq	3ffc <shift+0x3ffc>
 384:	1e00000b 	cdpne	0, 0, cr0, cr0, cr11, {0}
 388:	08030139 	stmdaeq	r3, {r0, r3, r4, r5, r8}
 38c:	0b3b0b3a 	bleq	ec307c <__bss_end+0xeba0bc>
 390:	13010b39 	movwne	r0, #6969	; 0x1b39
 394:	341f0000 	ldrcc	r0, [pc], #-0	; 39c <shift+0x39c>
 398:	3a0e0300 	bcc	380fa0 <__bss_end+0x377fe0>
 39c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 3a0:	3c13490b 			; <UNDEFINED> instruction: 0x3c13490b
 3a4:	6c061c19 	stcvs	12, cr1, [r6], {25}
 3a8:	20000019 	andcs	r0, r0, r9, lsl r0
 3ac:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 3b0:	0b3b0b3a 	bleq	ec30a0 <__bss_end+0xeba0e0>
 3b4:	13490b39 	movtne	r0, #39737	; 0x9b39
 3b8:	0b1c193c 	bleq	7068b0 <__bss_end+0x6fd8f0>
 3bc:	0000196c 	andeq	r1, r0, ip, ror #18
 3c0:	47003421 	strmi	r3, [r0, -r1, lsr #8]
 3c4:	22000013 	andcs	r0, r0, #19
 3c8:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 3cc:	0b3a0e03 	bleq	e83be0 <__bss_end+0xe7ac20>
 3d0:	0b390b3b 	bleq	e430c4 <__bss_end+0xe3a104>
 3d4:	01111349 	tsteq	r1, r9, asr #6
 3d8:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 3dc:	01194296 			; <UNDEFINED> instruction: 0x01194296
 3e0:	23000013 	movwcs	r0, #19
 3e4:	0e030005 	cdpeq	0, 0, cr0, cr3, cr5, {0}
 3e8:	0b3b0b3a 	bleq	ec30d8 <__bss_end+0xeba118>
 3ec:	13490b39 	movtne	r0, #39737	; 0x9b39
 3f0:	00001802 	andeq	r1, r0, r2, lsl #16
 3f4:	03003424 	movweq	r3, #1060	; 0x424
 3f8:	3b0b3a0e 	blcc	2cec38 <__bss_end+0x2c5c78>
 3fc:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 400:	00180213 	andseq	r0, r8, r3, lsl r2
 404:	010b2500 	tsteq	fp, r0, lsl #10
 408:	06120111 			; <UNDEFINED> instruction: 0x06120111
 40c:	34260000 	strtcc	r0, [r6], #-0
 410:	3a080300 	bcc	201018 <__bss_end+0x1f8058>
 414:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 418:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 41c:	00000018 	andeq	r0, r0, r8, lsl r0
 420:	25011101 	strcs	r1, [r1, #-257]	; 0xfffffeff
 424:	030b130e 	movweq	r1, #45838	; 0xb30e
 428:	110e1b0e 	tstne	lr, lr, lsl #22
 42c:	10061201 	andne	r1, r6, r1, lsl #4
 430:	02000017 	andeq	r0, r0, #23
 434:	0b0b0024 	bleq	2c04cc <__bss_end+0x2b750c>
 438:	0e030b3e 	vmoveq.16	d3[0], r0
 43c:	26030000 	strcs	r0, [r3], -r0
 440:	00134900 	andseq	r4, r3, r0, lsl #18
 444:	00240400 	eoreq	r0, r4, r0, lsl #8
 448:	0b3e0b0b 	bleq	f8307c <__bss_end+0xf7a0bc>
 44c:	00000803 	andeq	r0, r0, r3, lsl #16
 450:	03001605 	movweq	r1, #1541	; 0x605
 454:	3b0b3a0e 	blcc	2cec94 <__bss_end+0x2c5cd4>
 458:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 45c:	06000013 			; <UNDEFINED> instruction: 0x06000013
 460:	0e030113 	mcreq	1, 0, r0, cr3, cr3, {0}
 464:	0b3a0b0b 	bleq	e83098 <__bss_end+0xe7a0d8>
 468:	0b390b3b 	bleq	e4315c <__bss_end+0xe3a19c>
 46c:	00001301 	andeq	r1, r0, r1, lsl #6
 470:	03000d07 	movweq	r0, #3335	; 0xd07
 474:	3b0b3a08 	blcc	2cec9c <__bss_end+0x2c5cdc>
 478:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 47c:	000b3813 	andeq	r3, fp, r3, lsl r8
 480:	01040800 	tsteq	r4, r0, lsl #16
 484:	196d0e03 	stmdbne	sp!, {r0, r1, r9, sl, fp}^
 488:	0b0b0b3e 	bleq	2c3188 <__bss_end+0x2ba1c8>
 48c:	0b3a1349 	bleq	e851b8 <__bss_end+0xe7c1f8>
 490:	0b390b3b 	bleq	e43184 <__bss_end+0xe3a1c4>
 494:	00001301 	andeq	r1, r0, r1, lsl #6
 498:	03002809 	movweq	r2, #2057	; 0x809
 49c:	000b1c08 	andeq	r1, fp, r8, lsl #24
 4a0:	00280a00 	eoreq	r0, r8, r0, lsl #20
 4a4:	0b1c0e03 	bleq	703cb8 <__bss_end+0x6facf8>
 4a8:	340b0000 	strcc	r0, [fp], #-0
 4ac:	3a0e0300 	bcc	3810b4 <__bss_end+0x3780f4>
 4b0:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 4b4:	6c13490b 			; <UNDEFINED> instruction: 0x6c13490b
 4b8:	00180219 	andseq	r0, r8, r9, lsl r2
 4bc:	00020c00 	andeq	r0, r2, r0, lsl #24
 4c0:	193c0e03 	ldmdbne	ip!, {r0, r1, r9, sl, fp}
 4c4:	0f0d0000 	svceq	0x000d0000
 4c8:	490b0b00 	stmdbmi	fp, {r8, r9, fp}
 4cc:	0e000013 	mcreq	0, 0, r0, cr0, cr3, {0}
 4d0:	0e03000d 	cdpeq	0, 0, cr0, cr3, cr13, {0}
 4d4:	0b3b0b3a 	bleq	ec31c4 <__bss_end+0xeba204>
 4d8:	13490b39 	movtne	r0, #39737	; 0x9b39
 4dc:	00000b38 	andeq	r0, r0, r8, lsr fp
 4e0:	4901010f 	stmdbmi	r1, {r0, r1, r2, r3, r8}
 4e4:	00130113 	andseq	r0, r3, r3, lsl r1
 4e8:	00211000 	eoreq	r1, r1, r0
 4ec:	0b2f1349 	bleq	bc5218 <__bss_end+0xbbc258>
 4f0:	02110000 	andseq	r0, r1, #0
 4f4:	0b0e0301 	bleq	381100 <__bss_end+0x378140>
 4f8:	3b0b3a0b 	blcc	2ced2c <__bss_end+0x2c5d6c>
 4fc:	010b390b 	tsteq	fp, fp, lsl #18
 500:	12000013 	andne	r0, r0, #19
 504:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 508:	0b3a0e03 	bleq	e83d1c <__bss_end+0xe7ad5c>
 50c:	0b390b3b 	bleq	e43200 <__bss_end+0xe3a240>
 510:	193c0e6e 	ldmdbne	ip!, {r1, r2, r3, r5, r6, r9, sl, fp}
 514:	13011364 	movwne	r1, #4964	; 0x1364
 518:	05130000 	ldreq	r0, [r3, #-0]
 51c:	34134900 	ldrcc	r4, [r3], #-2304	; 0xfffff700
 520:	14000019 	strne	r0, [r0], #-25	; 0xffffffe7
 524:	13490005 	movtne	r0, #36869	; 0x9005
 528:	2e150000 	cdpcs	0, 1, cr0, cr5, cr0, {0}
 52c:	03193f01 	tsteq	r9, #1, 30
 530:	3b0b3a0e 	blcc	2ced70 <__bss_end+0x2c5db0>
 534:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 538:	3c13490e 			; <UNDEFINED> instruction: 0x3c13490e
 53c:	01136419 	tsteq	r3, r9, lsl r4
 540:	16000013 			; <UNDEFINED> instruction: 0x16000013
 544:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 548:	0b3a0e03 	bleq	e83d5c <__bss_end+0xe7ad9c>
 54c:	0b390b3b 	bleq	e43240 <__bss_end+0xe3a280>
 550:	13490e6e 	movtne	r0, #40558	; 0x9e6e
 554:	193c0b32 	ldmdbne	ip!, {r1, r4, r5, r8, r9, fp}
 558:	13011364 	movwne	r1, #4964	; 0x1364
 55c:	0d170000 	ldceq	0, cr0, [r7, #-0]
 560:	3a0e0300 	bcc	381168 <__bss_end+0x3781a8>
 564:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 568:	3813490b 	ldmdacc	r3, {r0, r1, r3, r8, fp, lr}
 56c:	000b320b 	andeq	r3, fp, fp, lsl #4
 570:	012e1800 			; <UNDEFINED> instruction: 0x012e1800
 574:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 578:	0b3b0b3a 	bleq	ec3268 <__bss_end+0xeba2a8>
 57c:	0e6e0b39 	vmoveq.8	d14[5], r0
 580:	193c0b32 	ldmdbne	ip!, {r1, r4, r5, r8, r9, fp}
 584:	13011364 	movwne	r1, #4964	; 0x1364
 588:	2e190000 	cdpcs	0, 1, cr0, cr9, cr0, {0}
 58c:	03193f01 	tsteq	r9, #1, 30
 590:	3b0b3a0e 	blcc	2cedd0 <__bss_end+0x2c5e10>
 594:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 598:	3213490e 	andscc	r4, r3, #229376	; 0x38000
 59c:	64193c0b 	ldrvs	r3, [r9], #-3083	; 0xfffff3f5
 5a0:	1a000013 	bne	5f4 <shift+0x5f4>
 5a4:	13490115 	movtne	r0, #37141	; 0x9115
 5a8:	13011364 	movwne	r1, #4964	; 0x1364
 5ac:	1f1b0000 	svcne	0x001b0000
 5b0:	49131d00 	ldmdbmi	r3, {r8, sl, fp, ip}
 5b4:	1c000013 	stcne	0, cr0, [r0], {19}
 5b8:	0b0b0010 	bleq	2c0600 <__bss_end+0x2b7640>
 5bc:	00001349 	andeq	r1, r0, r9, asr #6
 5c0:	0b000f1d 	bleq	423c <shift+0x423c>
 5c4:	1e00000b 	cdpne	0, 0, cr0, cr0, cr11, {0}
 5c8:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 5cc:	0b3b0b3a 	bleq	ec32bc <__bss_end+0xeba2fc>
 5d0:	13490b39 	movtne	r0, #39737	; 0x9b39
 5d4:	00001802 	andeq	r1, r0, r2, lsl #16
 5d8:	3f012e1f 	svccc	0x00012e1f
 5dc:	3a0e0319 	bcc	381248 <__bss_end+0x378288>
 5e0:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 5e4:	490e6e0b 	stmdbmi	lr, {r0, r1, r3, r9, sl, fp, sp, lr}
 5e8:	12011113 	andne	r1, r1, #-1073741820	; 0xc0000004
 5ec:	96184006 	ldrls	r4, [r8], -r6
 5f0:	13011942 	movwne	r1, #6466	; 0x1942
 5f4:	05200000 	streq	r0, [r0, #-0]!
 5f8:	3a0e0300 	bcc	381200 <__bss_end+0x378240>
 5fc:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 600:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 604:	21000018 	tstcs	r0, r8, lsl r0
 608:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 60c:	0b3a0e03 	bleq	e83e20 <__bss_end+0xe7ae60>
 610:	0b390b3b 	bleq	e43304 <__bss_end+0xe3a344>
 614:	13490e6e 	movtne	r0, #40558	; 0x9e6e
 618:	06120111 			; <UNDEFINED> instruction: 0x06120111
 61c:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
 620:	00130119 	andseq	r0, r3, r9, lsl r1
 624:	00342200 	eorseq	r2, r4, r0, lsl #4
 628:	0b3a0803 	bleq	e8263c <__bss_end+0xe7967c>
 62c:	0b390b3b 	bleq	e43320 <__bss_end+0xe3a360>
 630:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 634:	2e230000 	cdpcs	0, 2, cr0, cr3, cr0, {0}
 638:	03193f01 	tsteq	r9, #1, 30
 63c:	3b0b3a0e 	blcc	2cee7c <__bss_end+0x2c5ebc>
 640:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 644:	1201110e 	andne	r1, r1, #-2147483645	; 0x80000003
 648:	97184006 	ldrls	r4, [r8, -r6]
 64c:	13011942 	movwne	r1, #6466	; 0x1942
 650:	2e240000 	cdpcs	0, 2, cr0, cr4, cr0, {0}
 654:	03193f00 	tsteq	r9, #0, 30
 658:	3b0b3a0e 	blcc	2cee98 <__bss_end+0x2c5ed8>
 65c:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 660:	1201110e 	andne	r1, r1, #-2147483645	; 0x80000003
 664:	97184006 	ldrls	r4, [r8, -r6]
 668:	00001942 	andeq	r1, r0, r2, asr #18
 66c:	3f012e25 	svccc	0x00012e25
 670:	3a0e0319 	bcc	3812dc <__bss_end+0x37831c>
 674:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 678:	490e6e0b 	stmdbmi	lr, {r0, r1, r3, r9, sl, fp, sp, lr}
 67c:	12011113 	andne	r1, r1, #-1073741820	; 0xc0000004
 680:	97184006 	ldrls	r4, [r8, -r6]
 684:	00001942 	andeq	r1, r0, r2, asr #18
 688:	01110100 	tsteq	r1, r0, lsl #2
 68c:	0b130e25 	bleq	4c3f28 <__bss_end+0x4baf68>
 690:	0e1b0e03 	cdpeq	14, 1, cr0, cr11, cr3, {0}
 694:	06120111 			; <UNDEFINED> instruction: 0x06120111
 698:	00001710 	andeq	r1, r0, r0, lsl r7
 69c:	01013902 	tsteq	r1, r2, lsl #18
 6a0:	03000013 	movweq	r0, #19
 6a4:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 6a8:	0b3b0b3a 	bleq	ec3398 <__bss_end+0xeba3d8>
 6ac:	13490b39 	movtne	r0, #39737	; 0x9b39
 6b0:	0a1c193c 	beq	706ba8 <__bss_end+0x6fdbe8>
 6b4:	3a040000 	bcc	1006bc <__bss_end+0xf76fc>
 6b8:	3b0b3a00 	blcc	2ceec0 <__bss_end+0x2c5f00>
 6bc:	180b390b 	stmdane	fp, {r0, r1, r3, r8, fp, ip, sp}
 6c0:	05000013 	streq	r0, [r0, #-19]	; 0xffffffed
 6c4:	13490101 	movtne	r0, #37121	; 0x9101
 6c8:	00001301 	andeq	r1, r0, r1, lsl #6
 6cc:	49002106 	stmdbmi	r0, {r1, r2, r8, sp}
 6d0:	000b2f13 	andeq	r2, fp, r3, lsl pc
 6d4:	00260700 	eoreq	r0, r6, r0, lsl #14
 6d8:	00001349 	andeq	r1, r0, r9, asr #6
 6dc:	0b002408 	bleq	9704 <__bss_end+0x744>
 6e0:	030b3e0b 	movweq	r3, #48651	; 0xbe0b
 6e4:	0900000e 	stmdbeq	r0, {r1, r2, r3}
 6e8:	13470034 	movtne	r0, #28724	; 0x7034
 6ec:	2e0a0000 	cdpcs	0, 0, cr0, cr10, cr0, {0}
 6f0:	03193f01 	tsteq	r9, #1, 30
 6f4:	3b0b3a0e 	blcc	2cef34 <__bss_end+0x2c5f74>
 6f8:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 6fc:	1201110e 	andne	r1, r1, #-2147483645	; 0x80000003
 700:	97184006 	ldrls	r4, [r8, -r6]
 704:	13011942 	movwne	r1, #6466	; 0x1942
 708:	050b0000 	streq	r0, [fp, #-0]
 70c:	3a080300 	bcc	201314 <__bss_end+0x1f8354>
 710:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 714:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 718:	0c000018 	stceq	0, cr0, [r0], {24}
 71c:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 720:	0b3b0b3a 	bleq	ec3410 <__bss_end+0xeba450>
 724:	13490b39 	movtne	r0, #39737	; 0x9b39
 728:	00001802 	andeq	r1, r0, r2, lsl #16
 72c:	11010b0d 	tstne	r1, sp, lsl #22
 730:	00061201 	andeq	r1, r6, r1, lsl #4
 734:	00340e00 	eorseq	r0, r4, r0, lsl #28
 738:	0b3a0803 	bleq	e8274c <__bss_end+0xe7978c>
 73c:	0b390b3b 	bleq	e43430 <__bss_end+0xe3a470>
 740:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 744:	0f0f0000 	svceq	0x000f0000
 748:	490b0b00 	stmdbmi	fp, {r8, r9, fp}
 74c:	10000013 	andne	r0, r0, r3, lsl r0
 750:	00000026 	andeq	r0, r0, r6, lsr #32
 754:	0b000f11 	bleq	43a0 <shift+0x43a0>
 758:	1200000b 	andne	r0, r0, #11
 75c:	0b0b0024 	bleq	2c07f4 <__bss_end+0x2b7834>
 760:	08030b3e 	stmdaeq	r3, {r1, r2, r3, r4, r5, r8, r9, fp}
 764:	05130000 	ldreq	r0, [r3, #-0]
 768:	3a0e0300 	bcc	381370 <__bss_end+0x3783b0>
 76c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 770:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 774:	14000018 	strne	r0, [r0], #-24	; 0xffffffe8
 778:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 77c:	0b3a0e03 	bleq	e83f90 <__bss_end+0xe7afd0>
 780:	0b390b3b 	bleq	e43474 <__bss_end+0xe3a4b4>
 784:	13490e6e 	movtne	r0, #40558	; 0x9e6e
 788:	06120111 			; <UNDEFINED> instruction: 0x06120111
 78c:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
 790:	00130119 	andseq	r0, r3, r9, lsl r1
 794:	012e1500 			; <UNDEFINED> instruction: 0x012e1500
 798:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 79c:	0b3b0b3a 	bleq	ec348c <__bss_end+0xeba4cc>
 7a0:	0e6e0b39 	vmoveq.8	d14[5], r0
 7a4:	06120111 			; <UNDEFINED> instruction: 0x06120111
 7a8:	42961840 	addsmi	r1, r6, #64, 16	; 0x400000
 7ac:	00000019 	andeq	r0, r0, r9, lsl r0

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
  74:	00000194 	muleq	r0, r4, r1
	...
  80:	0000001c 	andeq	r0, r0, ip, lsl r0
  84:	0acb0002 	beq	ff2c0094 <__bss_end+0xff2b70d4>
  88:	00040000 	andeq	r0, r4, r0
  8c:	00000000 	andeq	r0, r0, r0
  90:	000083c0 	andeq	r8, r0, r0, asr #7
  94:	0000045c 	andeq	r0, r0, ip, asr r4
	...
  a0:	0000001c 	andeq	r0, r0, ip, lsl r0
  a4:	15ee0002 	strbne	r0, [lr, #2]!
  a8:	00040000 	andeq	r0, r4, r0
  ac:	00000000 	andeq	r0, r0, r0
  b0:	0000881c 	andeq	r8, r0, ip, lsl r8
  b4:	000004b8 			; <UNDEFINED> instruction: 0x000004b8
	...

Disassembly of section .debug_str:

00000000 <.debug_str>:
       0:	6573552f 	ldrbvs	r5, [r3, #-1327]!	; 0xfffffad1
       4:	772f7372 			; <UNDEFINED> instruction: 0x772f7372
       8:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
       c:	2f696a72 	svccs	0x00696a72
      10:	6b736544 	blvs	1cd9528 <__bss_end+0x1cd0568>
      14:	2f706f74 	svccs	0x00706f74
      18:	2f564146 	svccs	0x00564146
      1c:	6176614e 	cmnvs	r6, lr, asr #2
      20:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
      24:	4f2f6963 	svcmi	0x002f6963
      28:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
      2c:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
      30:	6b6c6172 	blvs	1b18600 <__bss_end+0x1b0f640>
      34:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
      38:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
      3c:	756f732f 	strbvc	r7, [pc, #-815]!	; fffffd15 <__bss_end+0xffff6d55>
      40:	73656372 	cmnvc	r5, #-939524095	; 0xc8000001
      44:	6573752f 	ldrbvs	r7, [r3, #-1327]!	; 0xfffffad1
      48:	61707372 	cmnvs	r0, r2, ror r3
      4c:	632f6563 			; <UNDEFINED> instruction: 0x632f6563
      50:	2e307472 	mrccs	4, 1, r7, cr0, cr2, {3}
      54:	552f0073 	strpl	r0, [pc, #-115]!	; ffffffe9 <__bss_end+0xffff7029>
      58:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
      5c:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
      60:	6a726574 	bvs	1c99638 <__bss_end+0x1c90678>
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
      98:	752f7365 	strvc	r7, [pc, #-869]!	; fffffd3b <__bss_end+0xffff6d7b>
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
     12c:	6a363731 	bvs	d8ddf8 <__bss_end+0xd84e38>
     130:	732d667a 			; <UNDEFINED> instruction: 0x732d667a
     134:	616d2d20 	cmnvs	sp, r0, lsr #26
     138:	2d206d72 	stccs	13, cr6, [r0, #-456]!	; 0xfffffe38
     13c:	6372616d 	cmnvs	r2, #1073741851	; 0x4000001b
     140:	72613d68 	rsbvc	r3, r1, #104, 26	; 0x1a00
     144:	7a36766d 	bvc	d9db00 <__bss_end+0xd94b40>
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
     184:	6a757a61 	bvs	1d5eb10 <__bss_end+0x1d55b50>
     188:	2f696369 	svccs	0x00696369
     18c:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
     190:	73656d65 	cmnvc	r5, #6464	; 0x1940
     194:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
     198:	6b2d616b 	blvs	b5874c <__bss_end+0xb4f78c>
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
     1e4:	2b2b4320 	blcs	ad0e6c <__bss_end+0xac7eac>
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
     260:	2b6b7a36 	blcs	1adeb40 <__bss_end+0x1ad5b80>
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
     294:	755f6962 	ldrbvc	r6, [pc, #-2402]	; fffff93a <__bss_end+0xffff697a>
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
     324:	6b736544 	blvs	1cd983c <__bss_end+0x1cd087c>
     328:	2f706f74 	svccs	0x00706f74
     32c:	2f564146 	svccs	0x00564146
     330:	6176614e 	cmnvs	r6, lr, asr #2
     334:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
     338:	4f2f6963 	svcmi	0x002f6963
     33c:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
     340:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
     344:	6b6c6172 	blvs	1b18914 <__bss_end+0x1b0f954>
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
     41c:	6b636f6c 	blvs	18dc1d4 <__bss_end+0x18d3214>
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
     46c:	61660074 	smcvs	24580	; 0x6004
     470:	55007473 	strpl	r7, [r0, #-1139]	; 0xfffffb8d
     474:	70616d6e 	rsbvc	r6, r1, lr, ror #26
     478:	6c69465f 	stclvs	6, cr4, [r9], #-380	; 0xfffffe84
     47c:	75435f65 	strbvc	r5, [r3, #-3941]	; 0xfffff09b
     480:	6e657272 	mcrvs	2, 3, r7, cr5, cr2, {3}
     484:	53420074 	movtpl	r0, #8308	; 0x2074
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
     4e8:	6d695400 	cfstrdvs	mvd5, [r9, #-0]
     4ec:	425f7265 	subsmi	r7, pc, #1342177286	; 0x50000006
     4f0:	00657361 	rsbeq	r7, r5, r1, ror #6
     4f4:	4957534e 	ldmdbmi	r7, {r1, r2, r3, r6, r8, r9, ip, lr}^
     4f8:	6f72505f 	svcvs	0x0072505f
     4fc:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     500:	7265535f 	rsbvc	r5, r5, #2080374785	; 0x7c000001
     504:	65636976 	strbvs	r6, [r3, #-2422]!	; 0xfffff68a
     508:	61655200 	cmnvs	r5, r0, lsl #4
     50c:	63410064 	movtvs	r0, #4196	; 0x1064
     510:	65766974 	ldrbvs	r6, [r6, #-2420]!	; 0xfffff68c
     514:	6f72505f 	svcvs	0x0072505f
     518:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     51c:	756f435f 	strbvc	r4, [pc, #-863]!	; 1c5 <shift+0x1c5>
     520:	4300746e 	movwmi	r7, #1134	; 0x46e
     524:	74616572 	strbtvc	r6, [r1], #-1394	; 0xfffffa8e
     528:	72505f65 	subsvc	r5, r0, #404	; 0x194
     52c:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     530:	74730073 	ldrbtvc	r0, [r3], #-115	; 0xffffff8d
     534:	00657461 	rsbeq	r7, r5, r1, ror #8
     538:	4678614d 	ldrbtmi	r6, [r8], -sp, asr #2
     53c:	6e656c69 	cdpvs	12, 6, cr6, cr5, cr9, {3}
     540:	4c656d61 	stclmi	13, cr6, [r5], #-388	; 0xfffffe7c
     544:	74676e65 	strbtvc	r6, [r7], #-3685	; 0xfffff19b
     548:	55410068 	strbpl	r0, [r1, #-104]	; 0xffffff98
     54c:	61425f58 	cmpvs	r2, r8, asr pc
     550:	47006573 	smlsdxmi	r0, r3, r5, r6
     554:	535f7465 	cmppl	pc, #1694498816	; 0x65000000
     558:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     55c:	72656c75 	rsbvc	r6, r5, #29952	; 0x7500
     560:	666e495f 			; <UNDEFINED> instruction: 0x666e495f
     564:	6544006f 	strbvs	r0, [r4, #-111]	; 0xffffff91
     568:	696c6461 	stmdbvs	ip!, {r0, r5, r6, sl, sp, lr}^
     56c:	555f656e 	ldrbpl	r6, [pc, #-1390]	; 6 <shift+0x6>
     570:	6168636e 	cmnvs	r8, lr, ror #6
     574:	6465676e 	strbtvs	r6, [r5], #-1902	; 0xfffff892
     578:	72504300 	subsvc	r4, r0, #0, 6
     57c:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     580:	614d5f73 	hvcvs	54771	; 0xd5f3
     584:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     588:	5a5f0072 	bpl	17c0758 <__bss_end+0x17b7798>
     58c:	4336314e 	teqmi	r6, #-2147483629	; 0x80000013
     590:	636f7250 	cmnvs	pc, #80, 4
     594:	5f737365 	svcpl	0x00737365
     598:	616e614d 	cmnvs	lr, sp, asr #2
     59c:	31726567 	cmncc	r2, r7, ror #10
     5a0:	74654738 	strbtvc	r4, [r5], #-1848	; 0xfffff8c8
     5a4:	6863535f 	stmdavs	r3!, {r0, r1, r2, r3, r4, r6, r8, r9, ip, lr}^
     5a8:	6c756465 	cfldrdvs	mvd6, [r5], #-404	; 0xfffffe6c
     5ac:	495f7265 	ldmdbmi	pc, {r0, r2, r5, r6, r9, ip, sp, lr}^	; <UNPREDICTABLE>
     5b0:	456f666e 	strbmi	r6, [pc, #-1646]!	; ffffff4a <__bss_end+0xffff6f8a>
     5b4:	474e3032 	smlaldxmi	r3, lr, r2, r0
     5b8:	535f7465 	cmppl	pc, #1694498816	; 0x65000000
     5bc:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     5c0:	666e495f 			; <UNDEFINED> instruction: 0x666e495f
     5c4:	79545f6f 	ldmdbvc	r4, {r0, r1, r2, r3, r5, r6, r8, r9, sl, fp, ip, lr}^
     5c8:	76506570 			; <UNDEFINED> instruction: 0x76506570
     5cc:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     5d0:	50433631 	subpl	r3, r3, r1, lsr r6
     5d4:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     5d8:	4d5f7373 	ldclmi	3, cr7, [pc, #-460]	; 414 <shift+0x414>
     5dc:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
     5e0:	31327265 	teqcc	r2, r5, ror #4
     5e4:	646e6148 	strbtvs	r6, [lr], #-328	; 0xfffffeb8
     5e8:	465f656c 	ldrbmi	r6, [pc], -ip, ror #10
     5ec:	73656c69 	cmnvc	r5, #26880	; 0x6900
     5f0:	65747379 	ldrbvs	r7, [r4, #-889]!	; 0xfffffc87
     5f4:	57535f6d 	ldrbpl	r5, [r3, -sp, ror #30]
     5f8:	33324549 	teqcc	r2, #306184192	; 0x12400000
     5fc:	4957534e 	ldmdbmi	r7, {r1, r2, r3, r6, r8, r9, ip, lr}^
     600:	6c69465f 	stclvs	6, cr4, [r9], #-380	; 0xfffffe84
     604:	73797365 	cmnvc	r9, #-1811939327	; 0x94000001
     608:	5f6d6574 	svcpl	0x006d6574
     60c:	76726553 			; <UNDEFINED> instruction: 0x76726553
     610:	6a656369 	bvs	19593bc <__bss_end+0x19503fc>
     614:	31526a6a 	cmpcc	r2, sl, ror #20
     618:	57535431 	smmlarpl	r3, r1, r4, r5
     61c:	65525f49 	ldrbvs	r5, [r2, #-3913]	; 0xfffff0b7
     620:	746c7573 	strbtvc	r7, [ip], #-1395	; 0xfffffa8d
     624:	65706f00 	ldrbvs	r6, [r0, #-3840]!	; 0xfffff100
     628:	5f64656e 	svcpl	0x0064656e
     62c:	656c6966 	strbvs	r6, [ip, #-2406]!	; 0xfffff69a
     630:	6f4e0073 	svcvs	0x004e0073
     634:	79666974 	stmdbvc	r6!, {r2, r4, r5, r6, r8, fp, sp, lr}^
     638:	006c6c41 	rsbeq	r6, ip, r1, asr #24
     63c:	55504354 	ldrbpl	r4, [r0, #-852]	; 0xfffffcac
     640:	6e6f435f 	mcrvs	3, 3, r4, cr15, cr15, {2}
     644:	74786574 	ldrbtvc	r6, [r8], #-1396	; 0xfffffa8c
     648:	61654400 	cmnvs	r5, r0, lsl #8
     64c:	6e696c64 	cdpvs	12, 6, cr6, cr9, cr4, {3}
     650:	74740065 	ldrbtvc	r0, [r4], #-101	; 0xffffff9b
     654:	00307262 	eorseq	r7, r0, r2, ror #4
     658:	314e5a5f 	cmpcc	lr, pc, asr sl
     65c:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     660:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     664:	614d5f73 	hvcvs	54771	; 0xd5f3
     668:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     66c:	4e343172 	mrcmi	1, 1, r3, cr4, cr2, {3}
     670:	6669746f 	strbtvs	r7, [r9], -pc, ror #8
     674:	72505f79 	subsvc	r5, r0, #484	; 0x1e4
     678:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     67c:	006a4573 	rsbeq	r4, sl, r3, ror r5
     680:	5f746547 	svcpl	0x00746547
     684:	00444950 	subeq	r4, r4, r0, asr r9
     688:	30435342 	subcc	r5, r3, r2, asr #6
     68c:	7361425f 	cmnvc	r1, #-268435451	; 0xf0000005
     690:	6f6e0065 	svcvs	0x006e0065
     694:	69666974 	stmdbvs	r6!, {r2, r4, r5, r6, r8, fp, sp, lr}^
     698:	645f6465 	ldrbvs	r6, [pc], #-1125	; 6a0 <shift+0x6a0>
     69c:	6c646165 	stfvse	f6, [r4], #-404	; 0xfffffe6c
     6a0:	00656e69 	rsbeq	r6, r5, r9, ror #28
     6a4:	65746e49 	ldrbvs	r6, [r4, #-3657]!	; 0xfffff1b7
     6a8:	70757272 	rsbsvc	r7, r5, r2, ror r2
     6ac:	6f435f74 	svcvs	0x00435f74
     6b0:	6f72746e 	svcvs	0x0072746e
     6b4:	72656c6c 	rsbvc	r6, r5, #108, 24	; 0x6c00
     6b8:	7361425f 	cmnvc	r1, #-268435451	; 0xf0000005
     6bc:	53420065 	movtpl	r0, #8293	; 0x2065
     6c0:	425f3143 	subsmi	r3, pc, #-1073741808	; 0xc0000010
     6c4:	00657361 	rsbeq	r7, r5, r1, ror #6
     6c8:	5f78614d 	svcpl	0x0078614d
     6cc:	636f7250 	cmnvs	pc, #80, 4
     6d0:	5f737365 	svcpl	0x00737365
     6d4:	6e65704f 	cdpvs	0, 6, cr7, cr5, cr15, {2}
     6d8:	465f6465 	ldrbmi	r6, [pc], -r5, ror #8
     6dc:	73656c69 	cmnvc	r5, #26880	; 0x6900
     6e0:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     6e4:	50433631 	subpl	r3, r3, r1, lsr r6
     6e8:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     6ec:	4d5f7373 	ldclmi	3, cr7, [pc, #-460]	; 528 <shift+0x528>
     6f0:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
     6f4:	38317265 	ldmdacc	r1!, {r0, r2, r5, r6, r9, ip, sp, lr}
     6f8:	616d6e55 	cmnvs	sp, r5, asr lr
     6fc:	69465f70 	stmdbvs	r6, {r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     700:	435f656c 	cmpmi	pc, #108, 10	; 0x1b000000
     704:	65727275 	ldrbvs	r7, [r2, #-629]!	; 0xfffffd8b
     708:	6a45746e 	bvs	115d8c8 <__bss_end+0x1154908>
     70c:	4e525400 	cdpmi	4, 5, cr5, cr2, cr0, {0}
     710:	61425f47 	cmpvs	r2, r7, asr #30
     714:	61006573 	tstvs	r0, r3, ror r5
     718:	6e656373 	mcrvs	3, 3, r6, cr5, cr3, {3}
     71c:	676e6964 	strbvs	r6, [lr, -r4, ror #18]!
     720:	74654700 	strbtvc	r4, [r5], #-1792	; 0xfffff900
     724:	7275435f 	rsbsvc	r4, r5, #2080374785	; 0x7c000001
     728:	746e6572 	strbtvc	r6, [lr], #-1394	; 0xfffffa8e
     72c:	6f72505f 	svcvs	0x0072505f
     730:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     734:	6e6f6c00 	cdpvs	12, 6, cr6, cr15, cr0, {0}
     738:	6e752067 	cdpvs	0, 7, cr2, cr5, cr7, {3}
     73c:	6e676973 			; <UNDEFINED> instruction: 0x6e676973
     740:	69206465 	stmdbvs	r0!, {r0, r2, r5, r6, sl, sp, lr}
     744:	4d00746e 	cfstrsmi	mvf7, [r0, #-440]	; 0xfffffe48
     748:	465f7061 	ldrbmi	r7, [pc], -r1, rrx
     74c:	5f656c69 	svcpl	0x00656c69
     750:	435f6f54 	cmpmi	pc, #84, 30	; 0x150
     754:	65727275 	ldrbvs	r7, [r2, #-629]!	; 0xfffffd8b
     758:	7300746e 	movwvc	r7, #1134	; 0x46e
     75c:	63746977 	cmnvs	r4, #1949696	; 0x1dc000
     760:	665f3268 	ldrbvs	r3, [pc], -r8, ror #4
     764:	00656c69 	rsbeq	r6, r5, r9, ror #24
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
     7b0:	49007469 	stmdbmi	r0, {r0, r3, r5, r6, sl, ip, sp, lr}
     7b4:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
     7b8:	74707572 	ldrbtvc	r7, [r0], #-1394	; 0xfffffa8e
     7bc:	656c6261 	strbvs	r6, [ip, #-609]!	; 0xfffffd9f
     7c0:	656c535f 	strbvs	r5, [ip, #-863]!	; 0xfffffca1
     7c4:	64007065 	strvs	r7, [r0], #-101	; 0xffffff9b
     7c8:	6c707369 	ldclvs	3, cr7, [r0], #-420	; 0xfffffe5c
     7cc:	665f7961 	ldrbvs	r7, [pc], -r1, ror #18
     7d0:	00656c69 	rsbeq	r6, r5, r9, ror #24
     7d4:	6c6f6f62 	stclvs	15, cr6, [pc], #-392	; 654 <shift+0x654>
     7d8:	614c6d00 	cmpvs	ip, r0, lsl #26
     7dc:	505f7473 	subspl	r7, pc, r3, ror r4	; <UNPREDICTABLE>
     7e0:	42004449 	andmi	r4, r0, #1224736768	; 0x49000000
     7e4:	6b636f6c 	blvs	18dc59c <__bss_end+0x18d35dc>
     7e8:	4e006465 	cdpmi	4, 0, cr6, cr0, cr5, {3}
     7ec:	5f746547 	svcpl	0x00746547
     7f0:	65686353 	strbvs	r6, [r8, #-851]!	; 0xfffffcad
     7f4:	6e495f64 	cdpvs	15, 4, cr5, cr9, cr4, {3}
     7f8:	545f6f66 	ldrbpl	r6, [pc], #-3942	; 800 <shift+0x800>
     7fc:	00657079 	rsbeq	r7, r5, r9, ror r0
     800:	6e6e7552 	mcrvs	5, 3, r7, cr14, cr2, {2}
     804:	656c6261 	strbvs	r6, [ip, #-609]!	; 0xfffffd9f
     808:	61544e00 	cmpvs	r4, r0, lsl #28
     80c:	535f6b73 	cmppl	pc, #117760	; 0x1cc00
     810:	65746174 	ldrbvs	r6, [r4, #-372]!	; 0xfffffe8c
     814:	68637300 	stmdavs	r3!, {r8, r9, ip, sp, lr}^
     818:	635f6465 	cmpvs	pc, #1694498816	; 0x65000000
     81c:	746e756f 	strbtvc	r7, [lr], #-1391	; 0xfffffa91
     820:	73007265 	movwvc	r7, #613	; 0x265
     824:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     828:	6174735f 	cmnvs	r4, pc, asr r3
     82c:	5f636974 	svcpl	0x00636974
     830:	6f697270 	svcvs	0x00697270
     834:	79746972 	ldmdbvc	r4!, {r1, r4, r5, r6, r8, fp, sp, lr}^
     838:	69786500 	ldmdbvs	r8!, {r8, sl, sp, lr}^
     83c:	6f635f74 	svcvs	0x00635f74
     840:	6d006564 	cfstr32vs	mvfx6, [r0, #-400]	; 0xfffffe70
     844:	65686353 	strbvs	r6, [r8, #-851]!	; 0xfffffcad
     848:	656c7564 	strbvs	r7, [ip, #-1380]!	; 0xfffffa9c
     84c:	636e465f 	cmnvs	lr, #99614720	; 0x5f00000
     850:	49504700 	ldmdbmi	r0, {r8, r9, sl, lr}^
     854:	61425f4f 	cmpvs	r2, pc, asr #30
     858:	4d006573 	cfstr32mi	mvfx6, [r0, #-460]	; 0xfffffe34
     85c:	53467861 	movtpl	r7, #26721	; 0x6861
     860:	76697244 	strbtvc	r7, [r9], -r4, asr #4
     864:	614e7265 	cmpvs	lr, r5, ror #4
     868:	654c656d 	strbvs	r6, [ip, #-1389]	; 0xfffffa93
     86c:	6874676e 	ldmdavs	r4!, {r1, r2, r3, r5, r6, r8, r9, sl, sp, lr}^
     870:	746f4e00 	strbtvc	r4, [pc], #-3584	; 878 <shift+0x878>
     874:	00796669 	rsbseq	r6, r9, r9, ror #12
     878:	61666544 	cmnvs	r6, r4, asr #10
     87c:	5f746c75 	svcpl	0x00746c75
     880:	636f6c43 	cmnvs	pc, #17152	; 0x4300
     884:	61525f6b 	cmpvs	r2, fp, ror #30
     888:	4c006574 	cfstr32mi	mvfx6, [r0], {116}	; 0x74
     88c:	5f6b636f 	svcpl	0x006b636f
     890:	6f6c6e55 	svcvs	0x006c6e55
     894:	64656b63 	strbtvs	r6, [r5], #-2915	; 0xfffff49d
     898:	636f4c00 	cmnvs	pc, #0, 24
     89c:	6f4c5f6b 	svcvs	0x004c5f6b
     8a0:	64656b63 	strbtvs	r6, [r5], #-2915	; 0xfffff49d
     8a4:	61655200 	cmnvs	r5, r0, lsl #4
     8a8:	72575f64 	subsvc	r5, r7, #100, 30	; 0x190
     8ac:	00657469 	rsbeq	r7, r5, r9, ror #8
     8b0:	626d6f5a 	rsbvs	r6, sp, #360	; 0x168
     8b4:	47006569 	strmi	r6, [r0, -r9, ror #10]
     8b8:	535f7465 	cmppl	pc, #1694498816	; 0x65000000
     8bc:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     8c0:	666e495f 			; <UNDEFINED> instruction: 0x666e495f
     8c4:	5a5f006f 	bpl	17c0a88 <__bss_end+0x17b7ac8>
     8c8:	4336314e 	teqmi	r6, #-2147483629	; 0x80000013
     8cc:	636f7250 	cmnvs	pc, #80, 4
     8d0:	5f737365 	svcpl	0x00737365
     8d4:	616e614d 	cmnvs	lr, sp, asr #2
     8d8:	38726567 	ldmdacc	r2!, {r0, r1, r2, r5, r6, r8, sl, sp, lr}^
     8dc:	65686353 	strbvs	r6, [r8, #-851]!	; 0xfffffcad
     8e0:	656c7564 	strbvs	r7, [ip, #-1380]!	; 0xfffffa9c
     8e4:	5f007645 	svcpl	0x00007645
     8e8:	36314e5a 			; <UNDEFINED> instruction: 0x36314e5a
     8ec:	6f725043 	svcvs	0x00725043
     8f0:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     8f4:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     8f8:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     8fc:	614d3931 	cmpvs	sp, r1, lsr r9
     900:	69465f70 	stmdbvs	r6, {r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     904:	545f656c 	ldrbpl	r6, [pc], #-1388	; 90c <shift+0x90c>
     908:	75435f6f 	strbvc	r5, [r3, #-3951]	; 0xfffff091
     90c:	6e657272 	mcrvs	2, 3, r7, cr5, cr2, {3}
     910:	35504574 	ldrbcc	r4, [r0, #-1396]	; 0xfffffa8c
     914:	6c694649 	stclvs	6, cr4, [r9], #-292	; 0xfffffedc
     918:	614d0065 	cmpvs	sp, r5, rrx
     91c:	74615078 	strbtvc	r5, [r1], #-120	; 0xffffff88
     920:	6e654c68 	cdpvs	12, 6, cr4, cr5, cr8, {3}
     924:	00687467 	rsbeq	r7, r8, r7, ror #8
     928:	69736e75 	ldmdbvs	r3!, {r0, r2, r4, r5, r6, r9, sl, fp, sp, lr}^
     92c:	64656e67 	strbtvs	r6, [r5], #-3687	; 0xfffff199
     930:	61686320 	cmnvs	r8, r0, lsr #6
     934:	5a5f0072 	bpl	17c0b04 <__bss_end+0x17b7b44>
     938:	4336314e 	teqmi	r6, #-2147483629	; 0x80000013
     93c:	636f7250 	cmnvs	pc, #80, 4
     940:	5f737365 	svcpl	0x00737365
     944:	616e614d 	cmnvs	lr, sp, asr #2
     948:	31726567 	cmncc	r2, r7, ror #10
     94c:	68635332 	stmdavs	r3!, {r1, r4, r5, r8, r9, ip, lr}^
     950:	6c756465 	cfldrdvs	mvd6, [r5], #-404	; 0xfffffe6c
     954:	44455f65 	strbmi	r5, [r5], #-3941	; 0xfffff09b
     958:	00764546 	rsbseq	r4, r6, r6, asr #10
     95c:	4f495047 	svcmi	0x00495047
     960:	6e69505f 	mcrvs	0, 3, r5, cr9, cr15, {2}
     964:	756f435f 	strbvc	r4, [pc, #-863]!	; 60d <shift+0x60d>
     968:	7300746e 	movwvc	r7, #1134	; 0x46e
     96c:	74726f68 	ldrbtvc	r6, [r2], #-3944	; 0xfffff098
     970:	746e6920 	strbtvc	r6, [lr], #-2336	; 0xfffff6e0
     974:	766e4900 	strbtvc	r4, [lr], -r0, lsl #18
     978:	64696c61 	strbtvs	r6, [r9], #-3169	; 0xfffff39f
     97c:	6e69505f 	mcrvs	0, 3, r5, cr9, cr15, {2}
     980:	72655000 	rsbvc	r5, r5, #0
     984:	65687069 	strbvs	r7, [r8, #-105]!	; 0xffffff97
     988:	5f6c6172 	svcpl	0x006c6172
     98c:	65736142 	ldrbvs	r6, [r3, #-322]!	; 0xfffffebe
     990:	6e755200 	cdpvs	2, 7, cr5, cr5, cr0, {0}
     994:	676e696e 	strbvs	r6, [lr, -lr, ror #18]!
     998:	6e697500 	cdpvs	5, 6, cr7, cr9, cr0, {0}
     99c:	5f323374 	svcpl	0x00323374
     9a0:	436d0074 	cmnmi	sp, #116	; 0x74
     9a4:	65727275 	ldrbvs	r7, [r2, #-629]!	; 0xfffffd8b
     9a8:	545f746e 	ldrbpl	r7, [pc], #-1134	; 9b0 <shift+0x9b0>
     9ac:	5f6b7361 	svcpl	0x006b7361
     9b0:	65646f4e 	strbvs	r6, [r4, #-3918]!	; 0xfffff0b2
     9b4:	75706300 	ldrbvc	r6, [r0, #-768]!	; 0xfffffd00
     9b8:	6e6f635f 	mcrvs	3, 3, r6, cr15, cr15, {2}
     9bc:	74786574 	ldrbtvc	r6, [r8], #-1396	; 0xfffffa8c
     9c0:	61655200 	cmnvs	r5, r0, lsl #4
     9c4:	6e4f5f64 	cdpvs	15, 4, cr5, cr15, cr4, {3}
     9c8:	7300796c 	movwvc	r7, #2412	; 0x96c
     9cc:	7065656c 	rsbvc	r6, r5, ip, ror #10
     9d0:	6d69745f 	cfstrdvs	mvd7, [r9, #-380]!	; 0xfffffe84
     9d4:	5f007265 	svcpl	0x00007265
     9d8:	314b4e5a 	cmpcc	fp, sl, asr lr
     9dc:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     9e0:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     9e4:	614d5f73 	hvcvs	54771	; 0xd5f3
     9e8:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     9ec:	47383172 			; <UNDEFINED> instruction: 0x47383172
     9f0:	505f7465 	subspl	r7, pc, r5, ror #8
     9f4:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     9f8:	425f7373 	subsmi	r7, pc, #-872415231	; 0xcc000001
     9fc:	49505f79 	ldmdbmi	r0, {r0, r3, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     a00:	006a4544 	rsbeq	r4, sl, r4, asr #10
     a04:	646e6148 	strbtvs	r6, [lr], #-328	; 0xfffffeb8
     a08:	465f656c 	ldrbmi	r6, [pc], -ip, ror #10
     a0c:	73656c69 	cmnvc	r5, #26880	; 0x6900
     a10:	65747379 	ldrbvs	r7, [r4, #-889]!	; 0xfffffc87
     a14:	57535f6d 	ldrbpl	r5, [r3, -sp, ror #30]
     a18:	5a5f0049 	bpl	17c0b44 <__bss_end+0x17b7b84>
     a1c:	4336314e 	teqmi	r6, #-2147483629	; 0x80000013
     a20:	636f7250 	cmnvs	pc, #80, 4
     a24:	5f737365 	svcpl	0x00737365
     a28:	616e614d 	cmnvs	lr, sp, asr #2
     a2c:	31726567 	cmncc	r2, r7, ror #10
     a30:	68635331 	stmdavs	r3!, {r0, r4, r5, r8, r9, ip, lr}^
     a34:	6c756465 	cfldrdvs	mvd6, [r5], #-404	; 0xfffffe6c
     a38:	52525f65 	subspl	r5, r2, #404	; 0x194
     a3c:	74007645 	strvc	r7, [r0], #-1605	; 0xfffff9bb
     a40:	006b7361 	rsbeq	r7, fp, r1, ror #6
     a44:	69746f4e 	ldmdbvs	r4!, {r1, r2, r3, r6, r8, r9, sl, fp, sp, lr}^
     a48:	505f7966 	subspl	r7, pc, r6, ror #18
     a4c:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     a50:	53007373 	movwpl	r7, #883	; 0x373
     a54:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     a58:	00656c75 	rsbeq	r6, r5, r5, ror ip
     a5c:	314e5a5f 	cmpcc	lr, pc, asr sl
     a60:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     a64:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     a68:	614d5f73 	hvcvs	54771	; 0xd5f3
     a6c:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     a70:	77533972 			; <UNDEFINED> instruction: 0x77533972
     a74:	68637469 	stmdavs	r3!, {r0, r3, r5, r6, sl, ip, sp, lr}^
     a78:	456f545f 	strbmi	r5, [pc, #-1119]!	; 621 <shift+0x621>
     a7c:	43383150 	teqmi	r8, #80, 2
     a80:	636f7250 	cmnvs	pc, #80, 4
     a84:	5f737365 	svcpl	0x00737365
     a88:	7473694c 	ldrbtvc	r6, [r3], #-2380	; 0xfffff6b4
     a8c:	646f4e5f 	strbtvs	r4, [pc], #-3679	; a94 <shift+0xa94>
     a90:	63530065 	cmpvs	r3, #101	; 0x65
     a94:	75646568 	strbvc	r6, [r4, #-1384]!	; 0xfffffa98
     a98:	525f656c 	subspl	r6, pc, #108, 10	; 0x1b000000
     a9c:	5a5f0052 	bpl	17c0bec <__bss_end+0x17b7c2c>
     aa0:	4336314e 	teqmi	r6, #-2147483629	; 0x80000013
     aa4:	636f7250 	cmnvs	pc, #80, 4
     aa8:	5f737365 	svcpl	0x00737365
     aac:	616e614d 	cmnvs	lr, sp, asr #2
     ab0:	31726567 	cmncc	r2, r7, ror #10
     ab4:	6e614838 	mcrvs	8, 3, r4, cr1, cr8, {1}
     ab8:	5f656c64 	svcpl	0x00656c64
     abc:	636f7250 	cmnvs	pc, #80, 4
     ac0:	5f737365 	svcpl	0x00737365
     ac4:	45495753 	strbmi	r5, [r9, #-1875]	; 0xfffff8ad
     ac8:	534e3032 	movtpl	r3, #57394	; 0xe032
     acc:	505f4957 	subspl	r4, pc, r7, asr r9	; <UNPREDICTABLE>
     ad0:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     ad4:	535f7373 	cmppl	pc, #-872415231	; 0xcc000001
     ad8:	69767265 	ldmdbvs	r6!, {r0, r2, r5, r6, r9, ip, sp, lr}^
     adc:	6a6a6563 	bvs	1a9a070 <__bss_end+0x1a910b0>
     ae0:	3131526a 	teqcc	r1, sl, ror #4
     ae4:	49575354 	ldmdbmi	r7, {r2, r4, r6, r8, r9, ip, lr}^
     ae8:	7365525f 	cmnvc	r5, #-268435451	; 0xf0000005
     aec:	00746c75 	rsbseq	r6, r4, r5, ror ip
     af0:	76677261 	strbtvc	r7, [r7], -r1, ror #4
     af4:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     af8:	50433631 	subpl	r3, r3, r1, lsr r6
     afc:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     b00:	4d5f7373 	ldclmi	3, cr7, [pc, #-460]	; 93c <shift+0x93c>
     b04:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
     b08:	34317265 	ldrtcc	r7, [r1], #-613	; 0xfffffd9b
     b0c:	61657243 	cmnvs	r5, r3, asr #4
     b10:	505f6574 	subspl	r6, pc, r4, ror r5	; <UNPREDICTABLE>
     b14:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     b18:	50457373 	subpl	r7, r5, r3, ror r3
     b1c:	00626a68 	rsbeq	r6, r2, r8, ror #20
     b20:	74697753 	strbtvc	r7, [r9], #-1875	; 0xfffff8ad
     b24:	545f6863 	ldrbpl	r6, [pc], #-2147	; b2c <shift+0xb2c>
     b28:	534e006f 	movtpl	r0, #57455	; 0xe06f
     b2c:	465f4957 			; <UNDEFINED> instruction: 0x465f4957
     b30:	73656c69 	cmnvc	r5, #26880	; 0x6900
     b34:	65747379 	ldrbvs	r7, [r4, #-889]!	; 0xfffffc87
     b38:	65535f6d 	ldrbvs	r5, [r3, #-3949]	; 0xfffff093
     b3c:	63697672 	cmnvs	r9, #119537664	; 0x7200000
     b40:	6e490065 	cdpvs	0, 4, cr0, cr9, cr5, {3}
     b44:	696c6176 	stmdbvs	ip!, {r1, r2, r4, r5, r6, r8, sp, lr}^
     b48:	61485f64 	cmpvs	r8, r4, ror #30
     b4c:	656c646e 	strbvs	r6, [ip, #-1134]!	; 0xfffffb92
     b50:	6f6c4200 	svcvs	0x006c4200
     b54:	435f6b63 	cmpmi	pc, #101376	; 0x18c00
     b58:	65727275 	ldrbvs	r7, [r2, #-629]!	; 0xfffffd8b
     b5c:	505f746e 	subspl	r7, pc, lr, ror #8
     b60:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     b64:	2f007373 	svccs	0x00007373
     b68:	72657355 	rsbvc	r7, r5, #1409286145	; 0x54000001
     b6c:	69772f73 	ldmdbvs	r7!, {r0, r1, r4, r5, r6, r8, r9, sl, fp, sp}^
     b70:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
     b74:	442f696a 	strtmi	r6, [pc], #-2410	; b7c <shift+0xb7c>
     b78:	746b7365 	strbtvc	r7, [fp], #-869	; 0xfffffc9b
     b7c:	462f706f 	strtmi	r7, [pc], -pc, rrx
     b80:	4e2f5641 	cfmadda32mi	mvax2, mvax5, mvfx15, mvfx1
     b84:	7a617661 	bvc	185e510 <__bss_end+0x1855550>
     b88:	63696a75 	cmnvs	r9, #479232	; 0x75000
     b8c:	534f2f69 	movtpl	r2, #65385	; 0xff69
     b90:	6d65732f 	stclvs	3, cr7, [r5, #-188]!	; 0xffffff44
     b94:	72747365 	rsbsvc	r7, r4, #-1811939327	; 0x94000001
     b98:	616b6c61 	cmnvs	fp, r1, ror #24
     b9c:	76696b2d 	strbtvc	r6, [r9], -sp, lsr #22
     ba0:	2f736f2d 	svccs	0x00736f2d
     ba4:	72756f73 	rsbsvc	r6, r5, #460	; 0x1cc
     ba8:	2f736563 	svccs	0x00736563
     bac:	72657375 	rsbvc	r7, r5, #-738197503	; 0xd4000001
     bb0:	63617073 	cmnvs	r1, #115	; 0x73
     bb4:	6f632f65 	svcvs	0x00632f65
     bb8:	65746e75 	ldrbvs	r6, [r4, #-3701]!	; 0xfffff18b
     bbc:	61745f72 	cmnvs	r4, r2, ror pc
     bc0:	6d2f6b73 	fstmdbxvs	pc!, {d6-d62}	;@ Deprecated
     bc4:	2e6e6961 	vnmulcs.f16	s13, s28, s3	; <UNPREDICTABLE>
     bc8:	00707063 	rsbseq	r7, r0, r3, rrx
     bcc:	736f6c43 	cmnvc	pc, #17152	; 0x4300
     bd0:	72610065 	rsbvc	r0, r1, #101	; 0x65
     bd4:	73006367 	movwvc	r6, #871	; 0x367
     bd8:	63746977 	cmnvs	r4, #1949696	; 0x1dc000
     bdc:	665f3168 	ldrbvs	r3, [pc], -r8, ror #2
     be0:	00656c69 	rsbeq	r6, r5, r9, ror #24
     be4:	74697257 	strbtvc	r7, [r9], #-599	; 0xfffffda9
     be8:	6e4f5f65 	cdpvs	15, 4, cr5, cr15, cr5, {3}
     bec:	6d00796c 	vstrvs.16	s14, [r0, #-216]	; 0xffffff28	; <UNPREDICTABLE>
     bf0:	006e6961 	rsbeq	r6, lr, r1, ror #18
     bf4:	6c656959 			; <UNDEFINED> instruction: 0x6c656959
     bf8:	5a5f0064 	bpl	17c0d90 <__bss_end+0x17b7dd0>
     bfc:	4336314e 	teqmi	r6, #-2147483629	; 0x80000013
     c00:	636f7250 	cmnvs	pc, #80, 4
     c04:	5f737365 	svcpl	0x00737365
     c08:	616e614d 	cmnvs	lr, sp, asr #2
     c0c:	43726567 	cmnmi	r2, #432013312	; 0x19c00000
     c10:	00764534 	rsbseq	r4, r6, r4, lsr r5
     c14:	6d726554 	cfldr64vs	mvdx6, [r2, #-336]!	; 0xfffffeb0
     c18:	74616e69 	strbtvc	r6, [r1], #-3689	; 0xfffff197
     c1c:	4f490065 	svcmi	0x00490065
     c20:	006c7443 	rsbeq	r7, ip, r3, asr #8
     c24:	6573552f 	ldrbvs	r5, [r3, #-1327]!	; 0xfffffad1
     c28:	772f7372 			; <UNDEFINED> instruction: 0x772f7372
     c2c:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
     c30:	2f696a72 	svccs	0x00696a72
     c34:	6b736544 	blvs	1cda14c <__bss_end+0x1cd118c>
     c38:	2f706f74 	svccs	0x00706f74
     c3c:	2f564146 	svccs	0x00564146
     c40:	6176614e 	cmnvs	r6, lr, asr #2
     c44:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
     c48:	4f2f6963 	svcmi	0x002f6963
     c4c:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
     c50:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
     c54:	6b6c6172 	blvs	1b19224 <__bss_end+0x1b10264>
     c58:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
     c5c:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
     c60:	756f732f 	strbvc	r7, [pc, #-815]!	; 939 <shift+0x939>
     c64:	73656372 	cmnvc	r5, #-939524095	; 0xc8000001
     c68:	6975622f 	ldmdbvs	r5!, {r0, r1, r2, r3, r5, r9, sp, lr}^
     c6c:	6300646c 	movwvs	r6, #1132	; 0x46c
     c70:	65736f6c 	ldrbvs	r6, [r3, #-3948]!	; 0xfffff094
     c74:	74655300 	strbtvc	r5, [r5], #-768	; 0xfffffd00
     c78:	6c65525f 	sfmvs	f5, 2, [r5], #-380	; 0xfffffe84
     c7c:	76697461 	strbtvc	r7, [r9], -r1, ror #8
     c80:	65720065 	ldrbvs	r0, [r2, #-101]!	; 0xffffff9b
     c84:	6c617674 	stclvs	6, cr7, [r1], #-464	; 0xfffffe30
     c88:	75636e00 	strbvc	r6, [r3, #-3584]!	; 0xfffff200
     c8c:	69700072 	ldmdbvs	r0!, {r1, r4, r5, r6}^
     c90:	72006570 	andvc	r6, r0, #112, 10	; 0x1c000000
     c94:	6d756e64 	ldclvs	14, cr6, [r5, #-400]!	; 0xfffffe70
     c98:	315a5f00 	cmpcc	sl, r0, lsl #30
     c9c:	68637331 	stmdavs	r3!, {r0, r4, r5, r8, r9, ip, sp, lr}^
     ca0:	795f6465 	ldmdbvc	pc, {r0, r2, r5, r6, sl, sp, lr}^	; <UNPREDICTABLE>
     ca4:	646c6569 	strbtvs	r6, [ip], #-1385	; 0xfffffa97
     ca8:	5a5f0076 	bpl	17c0e88 <__bss_end+0x17b7ec8>
     cac:	65733731 	ldrbvs	r3, [r3, #-1841]!	; 0xfffff8cf
     cb0:	61745f74 	cmnvs	r4, r4, ror pc
     cb4:	645f6b73 	ldrbvs	r6, [pc], #-2931	; cbc <shift+0xcbc>
     cb8:	6c646165 	stfvse	f6, [r4], #-404	; 0xfffffe6c
     cbc:	6a656e69 	bvs	195c668 <__bss_end+0x19536a8>
     cc0:	69617700 	stmdbvs	r1!, {r8, r9, sl, ip, sp, lr}^
     cc4:	5a5f0074 	bpl	17c0e9c <__bss_end+0x17b7edc>
     cc8:	746f6e36 	strbtvc	r6, [pc], #-3638	; cd0 <shift+0xcd0>
     ccc:	6a796669 	bvs	1e5a678 <__bss_end+0x1e516b8>
     cd0:	6146006a 	cmpvs	r6, sl, rrx
     cd4:	65006c69 	strvs	r6, [r0, #-3177]	; 0xfffff397
     cd8:	63746978 	cmnvs	r4, #120, 18	; 0x1e0000
     cdc:	0065646f 	rsbeq	r6, r5, pc, ror #8
     ce0:	65686373 	strbvs	r6, [r8, #-883]!	; 0xfffffc8d
     ce4:	69795f64 	ldmdbvs	r9!, {r2, r5, r6, r8, r9, sl, fp, ip, lr}^
     ce8:	00646c65 	rsbeq	r6, r4, r5, ror #24
     cec:	6b636974 	blvs	18db2c4 <__bss_end+0x18d2304>
     cf0:	756f635f 	strbvc	r6, [pc, #-863]!	; 999 <shift+0x999>
     cf4:	725f746e 	subsvc	r7, pc, #1845493760	; 0x6e000000
     cf8:	69757165 	ldmdbvs	r5!, {r0, r2, r5, r6, r8, ip, sp, lr}^
     cfc:	00646572 	rsbeq	r6, r4, r2, ror r5
     d00:	34325a5f 	ldrtcc	r5, [r2], #-2655	; 0xfffff5a1
     d04:	5f746567 	svcpl	0x00746567
     d08:	69746361 	ldmdbvs	r4!, {r0, r5, r6, r8, r9, sp, lr}^
     d0c:	705f6576 	subsvc	r6, pc, r6, ror r5	; <UNPREDICTABLE>
     d10:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     d14:	635f7373 	cmpvs	pc, #-872415231	; 0xcc000001
     d18:	746e756f 	strbtvc	r7, [lr], #-1391	; 0xfffffa91
     d1c:	69500076 	ldmdbvs	r0, {r1, r2, r4, r5, r6}^
     d20:	465f6570 			; <UNDEFINED> instruction: 0x465f6570
     d24:	5f656c69 	svcpl	0x00656c69
     d28:	66657250 			; <UNDEFINED> instruction: 0x66657250
     d2c:	53007869 	movwpl	r7, #2153	; 0x869
     d30:	505f7465 	subspl	r7, pc, r5, ror #8
     d34:	6d617261 	sfmvs	f7, 2, [r1, #-388]!	; 0xfffffe7c
     d38:	5a5f0073 	bpl	17c0f0c <__bss_end+0x17b7f4c>
     d3c:	65673431 	strbvs	r3, [r7, #-1073]!	; 0xfffffbcf
     d40:	69745f74 	ldmdbvs	r4!, {r2, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     d44:	635f6b63 	cmpvs	pc, #101376	; 0x18c00
     d48:	746e756f 	strbtvc	r7, [lr], #-1391	; 0xfffffa91
     d4c:	6c730076 	ldclvs	0, cr0, [r3], #-472	; 0xfffffe28
     d50:	00706565 	rsbseq	r6, r0, r5, ror #10
     d54:	61736944 	cmnvs	r3, r4, asr #18
     d58:	5f656c62 	svcpl	0x00656c62
     d5c:	6e657645 	cdpvs	6, 6, cr7, cr5, cr5, {2}
     d60:	65445f74 	strbvs	r5, [r4, #-3956]	; 0xfffff08c
     d64:	74636574 	strbtvc	r6, [r3], #-1396	; 0xfffffa8c
     d68:	006e6f69 	rsbeq	r6, lr, r9, ror #30
     d6c:	74395a5f 	ldrtvc	r5, [r9], #-2655	; 0xfffff5a1
     d70:	696d7265 	stmdbvs	sp!, {r0, r2, r5, r6, r9, ip, sp, lr}^
     d74:	6574616e 	ldrbvs	r6, [r4, #-366]!	; 0xfffffe92
     d78:	706f0069 	rsbvc	r0, pc, r9, rrx
     d7c:	74617265 	strbtvc	r7, [r1], #-613	; 0xfffffd9b
     d80:	006e6f69 	rsbeq	r6, lr, r9, ror #30
     d84:	63355a5f 	teqvs	r5, #389120	; 0x5f000
     d88:	65736f6c 	ldrbvs	r6, [r3, #-3948]!	; 0xfffff094
     d8c:	5a5f006a 	bpl	17c0f3c <__bss_end+0x17b7f7c>
     d90:	74656736 	strbtvc	r6, [r5], #-1846	; 0xfffff8ca
     d94:	76646970 			; <UNDEFINED> instruction: 0x76646970
     d98:	616e6600 	cmnvs	lr, r0, lsl #12
     d9c:	7700656d 	strvc	r6, [r0, -sp, ror #10]
     da0:	65746972 	ldrbvs	r6, [r4, #-2418]!	; 0xfffff68e
     da4:	63697400 	cmnvs	r9, #0, 8
     da8:	6f00736b 	svcvs	0x0000736b
     dac:	006e6570 	rsbeq	r6, lr, r0, ror r5
     db0:	70345a5f 	eorsvc	r5, r4, pc, asr sl
     db4:	50657069 	rsbpl	r7, r5, r9, rrx
     db8:	006a634b 	rsbeq	r6, sl, fp, asr #6
     dbc:	6165444e 	cmnvs	r5, lr, asr #8
     dc0:	6e696c64 	cdpvs	12, 6, cr6, cr9, cr4, {3}
     dc4:	75535f65 	ldrbvc	r5, [r3, #-3941]	; 0xfffff09b
     dc8:	72657362 	rsbvc	r7, r5, #-2013265919	; 0x88000001
     dcc:	65636976 	strbvs	r6, [r3, #-2422]!	; 0xfffff68a
     dd0:	74656700 	strbtvc	r6, [r5], #-1792	; 0xfffff900
     dd4:	6369745f 	cmnvs	r9, #1593835520	; 0x5f000000
     dd8:	6f635f6b 	svcvs	0x00635f6b
     ddc:	00746e75 	rsbseq	r6, r4, r5, ror lr
     de0:	61726170 	cmnvs	r2, r0, ror r1
     de4:	5a5f006d 	bpl	17c0fa0 <__bss_end+0x17b7fe0>
     de8:	69727735 	ldmdbvs	r2!, {r0, r2, r4, r5, r8, r9, sl, ip, sp, lr}^
     dec:	506a6574 	rsbpl	r6, sl, r4, ror r5
     df0:	006a634b 	rsbeq	r6, sl, fp, asr #6
     df4:	5f746567 	svcpl	0x00746567
     df8:	6b736174 	blvs	1cd93d0 <__bss_end+0x1cd0410>
     dfc:	6369745f 	cmnvs	r9, #1593835520	; 0x5f000000
     e00:	745f736b 	ldrbvc	r7, [pc], #-875	; e08 <shift+0xe08>
     e04:	65645f6f 	strbvs	r5, [r4, #-3951]!	; 0xfffff091
     e08:	696c6461 	stmdbvs	ip!, {r0, r5, r6, sl, sp, lr}^
     e0c:	6200656e 	andvs	r6, r0, #461373440	; 0x1b800000
     e10:	735f6675 	cmpvc	pc, #122683392	; 0x7500000
     e14:	00657a69 	rsbeq	r7, r5, r9, ror #20
     e18:	5f746573 	svcpl	0x00746573
     e1c:	6b736174 	blvs	1cd93f4 <__bss_end+0x1cd0434>
     e20:	6165645f 	cmnvs	r5, pc, asr r4
     e24:	6e696c64 	cdpvs	12, 6, cr6, cr9, cr4, {3}
     e28:	65470065 	strbvs	r0, [r7, #-101]	; 0xffffff9b
     e2c:	61505f74 	cmpvs	r0, r4, ror pc
     e30:	736d6172 	cmnvc	sp, #-2147483620	; 0x8000001c
     e34:	73552f00 	cmpvc	r5, #0, 30
     e38:	2f737265 	svccs	0x00737265
     e3c:	746e6977 	strbtvc	r6, [lr], #-2423	; 0xfffff689
     e40:	696a7265 	stmdbvs	sl!, {r0, r2, r5, r6, r9, ip, sp, lr}^
     e44:	7365442f 	cmnvc	r5, #788529152	; 0x2f000000
     e48:	706f746b 	rsbvc	r7, pc, fp, ror #8
     e4c:	5641462f 	strbpl	r4, [r1], -pc, lsr #12
     e50:	76614e2f 	strbtvc	r4, [r1], -pc, lsr #28
     e54:	6a757a61 	bvs	1d5f7e0 <__bss_end+0x1d56820>
     e58:	2f696369 	svccs	0x00696369
     e5c:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
     e60:	73656d65 	cmnvc	r5, #6464	; 0x1940
     e64:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
     e68:	6b2d616b 	blvs	b5941c <__bss_end+0xb5045c>
     e6c:	6f2d7669 	svcvs	0x002d7669
     e70:	6f732f73 	svcvs	0x00732f73
     e74:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
     e78:	74732f73 	ldrbtvc	r2, [r3], #-3955	; 0xfffff08d
     e7c:	62696c64 	rsbvs	r6, r9, #100, 24	; 0x6400
     e80:	6372732f 	cmnvs	r2, #-1140850688	; 0xbc000000
     e84:	6474732f 	ldrbtvs	r7, [r4], #-815	; 0xfffffcd1
     e88:	656c6966 	strbvs	r6, [ip, #-2406]!	; 0xfffff69a
     e8c:	7070632e 	rsbsvc	r6, r0, lr, lsr #6
     e90:	355a5f00 	ldrbcc	r5, [sl, #-3840]	; 0xfffff100
     e94:	65656c73 	strbvs	r6, [r5, #-3187]!	; 0xfffff38d
     e98:	006a6a70 	rsbeq	r6, sl, r0, ror sl
     e9c:	5f746547 	svcpl	0x00746547
     ea0:	616d6552 	cmnvs	sp, r2, asr r5
     ea4:	6e696e69 	cdpvs	14, 6, cr6, cr9, cr9, {3}
     ea8:	6e450067 	cdpvs	0, 4, cr0, cr5, cr7, {3}
     eac:	656c6261 	strbvs	r6, [ip, #-609]!	; 0xfffffd9f
     eb0:	6576455f 	ldrbvs	r4, [r6, #-1375]!	; 0xfffffaa1
     eb4:	445f746e 	ldrbmi	r7, [pc], #-1134	; ebc <shift+0xebc>
     eb8:	63657465 	cmnvs	r5, #1694498816	; 0x65000000
     ebc:	6e6f6974 			; <UNDEFINED> instruction: 0x6e6f6974
     ec0:	325a5f00 	subscc	r5, sl, #0, 30
     ec4:	74656736 	strbtvc	r6, [r5], #-1846	; 0xfffff8ca
     ec8:	7361745f 	cmnvc	r1, #1593835520	; 0x5f000000
     ecc:	69745f6b 	ldmdbvs	r4!, {r0, r1, r3, r5, r6, r8, r9, sl, fp, ip, lr}^
     ed0:	5f736b63 	svcpl	0x00736b63
     ed4:	645f6f74 	ldrbvs	r6, [pc], #-3956	; edc <shift+0xedc>
     ed8:	6c646165 	stfvse	f6, [r4], #-404	; 0xfffffe6c
     edc:	76656e69 	strbtvc	r6, [r5], -r9, ror #28
     ee0:	57534e00 	ldrbpl	r4, [r3, -r0, lsl #28]
     ee4:	65525f49 	ldrbvs	r5, [r2, #-3913]	; 0xfffff0b7
     ee8:	746c7573 	strbtvc	r7, [ip], #-1395	; 0xfffffa8d
     eec:	646f435f 	strbtvs	r4, [pc], #-863	; ef4 <shift+0xef4>
     ef0:	72770065 	rsbsvc	r0, r7, #101	; 0x65
     ef4:	006d756e 	rsbeq	r7, sp, lr, ror #10
     ef8:	77345a5f 			; <UNDEFINED> instruction: 0x77345a5f
     efc:	6a746961 	bvs	1d1b488 <__bss_end+0x1d124c8>
     f00:	5f006a6a 	svcpl	0x00006a6a
     f04:	6f69355a 	svcvs	0x0069355a
     f08:	6a6c7463 	bvs	1b1e09c <__bss_end+0x1b150dc>
     f0c:	494e3631 	stmdbmi	lr, {r0, r4, r5, r9, sl, ip, sp}^
     f10:	6c74434f 	ldclvs	3, cr4, [r4], #-316	; 0xfffffec4
     f14:	65704f5f 	ldrbvs	r4, [r0, #-3935]!	; 0xfffff0a1
     f18:	69746172 	ldmdbvs	r4!, {r1, r4, r5, r6, r8, sp, lr}^
     f1c:	76506e6f 	ldrbvc	r6, [r0], -pc, ror #28
     f20:	636f6900 	cmnvs	pc, #0, 18
     f24:	72006c74 	andvc	r6, r0, #116, 24	; 0x7400
     f28:	6e637465 	cdpvs	4, 6, cr7, cr3, cr5, {3}
     f2c:	6f6e0074 	svcvs	0x006e0074
     f30:	79666974 	stmdbvc	r6!, {r2, r4, r5, r6, r8, fp, sp, lr}^
     f34:	72657400 	rsbvc	r7, r5, #0, 8
     f38:	616e696d 	cmnvs	lr, sp, ror #18
     f3c:	6d006574 	cfstr32vs	mvfx6, [r0, #-464]	; 0xfffffe30
     f40:	0065646f 	rsbeq	r6, r5, pc, ror #8
     f44:	66667562 	strbtvs	r7, [r6], -r2, ror #10
     f48:	5f007265 	svcpl	0x00007265
     f4c:	6572345a 	ldrbvs	r3, [r2, #-1114]!	; 0xfffffba6
     f50:	506a6461 	rsbpl	r6, sl, r1, ror #8
     f54:	47006a63 	strmi	r6, [r0, -r3, ror #20]
     f58:	4320554e 			; <UNDEFINED> instruction: 0x4320554e
     f5c:	34312b2b 	ldrtcc	r2, [r1], #-2859	; 0xfffff4d5
     f60:	2e303120 	rsfcssp	f3, f0, f0
     f64:	20312e33 	eorscs	r2, r1, r3, lsr lr
     f68:	31323032 	teqcc	r2, r2, lsr r0
     f6c:	34323830 	ldrtcc	r3, [r2], #-2096	; 0xfffff7d0
     f70:	65722820 	ldrbvs	r2, [r2, #-2080]!	; 0xfffff7e0
     f74:	7361656c 	cmnvc	r1, #108, 10	; 0x1b000000
     f78:	2d202965 			; <UNDEFINED> instruction: 0x2d202965
     f7c:	6f6c666d 	svcvs	0x006c666d
     f80:	612d7461 			; <UNDEFINED> instruction: 0x612d7461
     f84:	683d6962 	ldmdavs	sp!, {r1, r5, r6, r8, fp, sp, lr}
     f88:	20647261 	rsbcs	r7, r4, r1, ror #4
     f8c:	70666d2d 	rsbvc	r6, r6, sp, lsr #26
     f90:	66763d75 			; <UNDEFINED> instruction: 0x66763d75
     f94:	6d2d2070 	stcvs	0, cr2, [sp, #-448]!	; 0xfffffe40
     f98:	616f6c66 	cmnvs	pc, r6, ror #24
     f9c:	62612d74 	rsbvs	r2, r1, #116, 26	; 0x1d00
     fa0:	61683d69 	cmnvs	r8, r9, ror #26
     fa4:	2d206472 	cfstrscs	mvf6, [r0, #-456]!	; 0xfffffe38
     fa8:	7570666d 	ldrbvc	r6, [r0, #-1645]!	; 0xfffff993
     fac:	7066763d 	rsbvc	r7, r6, sp, lsr r6
     fb0:	746d2d20 	strbtvc	r2, [sp], #-3360	; 0xfffff2e0
     fb4:	3d656e75 	stclcc	14, cr6, [r5, #-468]!	; 0xfffffe2c
     fb8:	316d7261 	cmncc	sp, r1, ror #4
     fbc:	6a363731 	bvs	d8ec88 <__bss_end+0xd85cc8>
     fc0:	732d667a 			; <UNDEFINED> instruction: 0x732d667a
     fc4:	616d2d20 	cmnvs	sp, r0, lsr #26
     fc8:	2d206d72 	stccs	13, cr6, [r0, #-456]!	; 0xfffffe38
     fcc:	6372616d 	cmnvs	r2, #1073741851	; 0x4000001b
     fd0:	72613d68 	rsbvc	r3, r1, #104, 26	; 0x1a00
     fd4:	7a36766d 	bvc	d9e990 <__bss_end+0xd959d0>
     fd8:	70662b6b 	rsbvc	r2, r6, fp, ror #22
     fdc:	20672d20 	rsbcs	r2, r7, r0, lsr #26
     fe0:	2d20672d 	stccs	7, cr6, [r0, #-180]!	; 0xffffff4c
     fe4:	4f2d2067 	svcmi	0x002d2067
     fe8:	4f2d2030 	svcmi	0x002d2030
     fec:	662d2030 			; <UNDEFINED> instruction: 0x662d2030
     ff0:	652d6f6e 	strvs	r6, [sp, #-3950]!	; 0xfffff092
     ff4:	70656378 	rsbvc	r6, r5, r8, ror r3
     ff8:	6e6f6974 			; <UNDEFINED> instruction: 0x6e6f6974
     ffc:	662d2073 			; <UNDEFINED> instruction: 0x662d2073
    1000:	722d6f6e 	eorvc	r6, sp, #440	; 0x1b8
    1004:	00697474 	rsbeq	r7, r9, r4, ror r4
    1008:	434f494e 	movtmi	r4, #63822	; 0xf94e
    100c:	4f5f6c74 	svcmi	0x005f6c74
    1010:	61726570 	cmnvs	r2, r0, ror r5
    1014:	6e6f6974 			; <UNDEFINED> instruction: 0x6e6f6974
    1018:	74657200 	strbtvc	r7, [r5], #-512	; 0xfffffe00
    101c:	65646f63 	strbvs	r6, [r4, #-3939]!	; 0xfffff09d
    1020:	74656700 	strbtvc	r6, [r5], #-1792	; 0xfffff900
    1024:	7463615f 	strbtvc	r6, [r3], #-351	; 0xfffffea1
    1028:	5f657669 	svcpl	0x00657669
    102c:	636f7270 	cmnvs	pc, #112, 4
    1030:	5f737365 	svcpl	0x00737365
    1034:	6e756f63 	cdpvs	15, 7, cr6, cr5, cr3, {3}
    1038:	69660074 	stmdbvs	r6!, {r2, r4, r5, r6}^
    103c:	616e656c 	cmnvs	lr, ip, ror #10
    1040:	7200656d 	andvc	r6, r0, #457179136	; 0x1b400000
    1044:	00646165 	rsbeq	r6, r4, r5, ror #2
    1048:	70746567 	rsbsvc	r6, r4, r7, ror #10
    104c:	5f006469 	svcpl	0x00006469
    1050:	706f345a 	rsbvc	r3, pc, sl, asr r4	; <UNPREDICTABLE>
    1054:	4b506e65 	blmi	141c9f0 <__bss_end+0x1413a30>
    1058:	4e353163 	rsfmisz	f3, f5, f3
    105c:	656c6946 	strbvs	r6, [ip, #-2374]!	; 0xfffff6ba
    1060:	65704f5f 	ldrbvs	r4, [r0, #-3935]!	; 0xfffff0a1
    1064:	6f4d5f6e 	svcvs	0x004d5f6e
    1068:	69006564 	stmdbvs	r0, {r2, r5, r6, r8, sl, sp, lr}
    106c:	7475706e 	ldrbtvc	r7, [r5], #-110	; 0xffffff92
    1070:	73656400 	cmnvc	r5, #0, 8
    1074:	7a620074 	bvc	188124c <__bss_end+0x187828c>
    1078:	006f7265 	rsbeq	r7, pc, r5, ror #4
    107c:	676e656c 	strbvs	r6, [lr, -ip, ror #10]!
    1080:	5f006874 	svcpl	0x00006874
    1084:	7a62355a 	bvc	188e5f4 <__bss_end+0x1885634>
    1088:	506f7265 	rsbpl	r7, pc, r5, ror #4
    108c:	2f006976 	svccs	0x00006976
    1090:	72657355 	rsbvc	r7, r5, #1409286145	; 0x54000001
    1094:	69772f73 	ldmdbvs	r7!, {r0, r1, r4, r5, r6, r8, r9, sl, fp, sp}^
    1098:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
    109c:	442f696a 	strtmi	r6, [pc], #-2410	; 10a4 <shift+0x10a4>
    10a0:	746b7365 	strbtvc	r7, [fp], #-869	; 0xfffffc9b
    10a4:	462f706f 	strtmi	r7, [pc], -pc, rrx
    10a8:	4e2f5641 	cfmadda32mi	mvax2, mvax5, mvfx15, mvfx1
    10ac:	7a617661 	bvc	185ea38 <__bss_end+0x1855a78>
    10b0:	63696a75 	cmnvs	r9, #479232	; 0x75000
    10b4:	534f2f69 	movtpl	r2, #65385	; 0xff69
    10b8:	6d65732f 	stclvs	3, cr7, [r5, #-188]!	; 0xffffff44
    10bc:	72747365 	rsbsvc	r7, r4, #-1811939327	; 0x94000001
    10c0:	616b6c61 	cmnvs	fp, r1, ror #24
    10c4:	76696b2d 	strbtvc	r6, [r9], -sp, lsr #22
    10c8:	2f736f2d 	svccs	0x00736f2d
    10cc:	72756f73 	rsbsvc	r6, r5, #460	; 0x1cc
    10d0:	2f736563 	svccs	0x00736563
    10d4:	6c647473 	cfstrdvs	mvd7, [r4], #-460	; 0xfffffe34
    10d8:	732f6269 			; <UNDEFINED> instruction: 0x732f6269
    10dc:	732f6372 			; <UNDEFINED> instruction: 0x732f6372
    10e0:	74736474 	ldrbtvc	r6, [r3], #-1140	; 0xfffffb8c
    10e4:	676e6972 			; <UNDEFINED> instruction: 0x676e6972
    10e8:	7070632e 	rsbsvc	r6, r0, lr, lsr #6
    10ec:	345a5f00 	ldrbcc	r5, [sl], #-3840	; 0xfffff100
    10f0:	696f7461 	stmdbvs	pc!, {r0, r5, r6, sl, ip, sp, lr}^	; <UNPREDICTABLE>
    10f4:	00634b50 	rsbeq	r4, r3, r0, asr fp
    10f8:	72616843 	rsbvc	r6, r1, #4390912	; 0x430000
    10fc:	766e6f43 	strbtvc	r6, [lr], -r3, asr #30
    1100:	00727241 	rsbseq	r7, r2, r1, asr #4
    1104:	646d656d 	strbtvs	r6, [sp], #-1389	; 0xfffffa93
    1108:	6f007473 	svcvs	0x00007473
    110c:	75707475 	ldrbvc	r7, [r0, #-1141]!	; 0xfffffb8b
    1110:	5a5f0074 	bpl	17c12e8 <__bss_end+0x17b8328>
    1114:	6d656d36 	stclvs	13, cr6, [r5, #-216]!	; 0xffffff28
    1118:	50797063 	rsbspl	r7, r9, r3, rrx
    111c:	7650764b 	ldrbvc	r7, [r0], -fp, asr #12
    1120:	61620069 	cmnvs	r2, r9, rrx
    1124:	6d006573 	cfstr32vs	mvfx6, [r0, #-460]	; 0xfffffe34
    1128:	70636d65 	rsbvc	r6, r3, r5, ror #26
    112c:	74730079 	ldrbtvc	r0, [r3], #-121	; 0xffffff87
    1130:	6e656c72 	mcrvs	12, 3, r6, cr5, cr2, {3}
    1134:	375a5f00 	ldrbcc	r5, [sl, -r0, lsl #30]
    1138:	6e727473 	mrcvs	4, 3, r7, cr2, cr3, {3}
    113c:	50706d63 	rsbspl	r6, r0, r3, ror #26
    1140:	3053634b 	subscc	r6, r3, fp, asr #6
    1144:	5f00695f 	svcpl	0x0000695f
    1148:	7473365a 	ldrbtvc	r3, [r3], #-1626	; 0xfffff9a6
    114c:	6e656c72 	mcrvs	12, 3, r6, cr5, cr2, {3}
    1150:	00634b50 	rsbeq	r4, r3, r0, asr fp
    1154:	696f7461 	stmdbvs	pc!, {r0, r5, r6, sl, ip, sp, lr}^	; <UNPREDICTABLE>
    1158:	375a5f00 	ldrbcc	r5, [sl, -r0, lsl #30]
    115c:	6e727473 	mrcvs	4, 3, r7, cr2, cr3, {3}
    1160:	50797063 	rsbspl	r7, r9, r3, rrx
    1164:	634b5063 	movtvs	r5, #45155	; 0xb063
    1168:	74730069 	ldrbtvc	r0, [r3], #-105	; 0xffffff97
    116c:	6d636e72 	stclvs	14, cr6, [r3, #-456]!	; 0xfffffe38
    1170:	74730070 	ldrbtvc	r0, [r3], #-112	; 0xffffff90
    1174:	70636e72 	rsbvc	r6, r3, r2, ror lr
    1178:	656d0079 	strbvs	r0, [sp, #-121]!	; 0xffffff87
    117c:	79726f6d 	ldmdbvc	r2!, {r0, r2, r3, r5, r6, r8, r9, sl, fp, sp, lr}^
    1180:	6d656d00 	stclvs	13, cr6, [r5, #-0]
    1184:	00637273 	rsbeq	r7, r3, r3, ror r2
    1188:	616f7469 	cmnvs	pc, r9, ror #8
    118c:	345a5f00 	ldrbcc	r5, [sl], #-3840	; 0xfffff100
    1190:	616f7469 	cmnvs	pc, r9, ror #8
    1194:	6a63506a 	bvs	18d5344 <__bss_end+0x18cc384>
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
  20:	8b040e42 	blhi	103930 <__bss_end+0xfa970>
  24:	0b0d4201 	bleq	350830 <__bss_end+0x347870>
  28:	420d0d62 	andmi	r0, sp, #6272	; 0x1880
  2c:	00000ecb 	andeq	r0, r0, fp, asr #29
  30:	0000001c 	andeq	r0, r0, ip, lsl r0
  34:	00000000 	andeq	r0, r0, r0
  38:	00008064 	andeq	r8, r0, r4, rrx
  3c:	00000040 	andeq	r0, r0, r0, asr #32
  40:	8b080e42 	blhi	203950 <__bss_end+0x1fa990>
  44:	42018e02 	andmi	r8, r1, #2, 28
  48:	5a040b0c 	bpl	102c80 <__bss_end+0xf9cc0>
  4c:	00080d0c 	andeq	r0, r8, ip, lsl #26
  50:	0000000c 	andeq	r0, r0, ip
  54:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
  58:	7c020001 	stcvc	0, cr0, [r2], {1}
  5c:	000d0c0e 	andeq	r0, sp, lr, lsl #24
  60:	0000001c 	andeq	r0, r0, ip, lsl r0
  64:	00000050 	andeq	r0, r0, r0, asr r0
  68:	000080a4 	andeq	r8, r0, r4, lsr #1
  6c:	00000038 	andeq	r0, r0, r8, lsr r0
  70:	8b040e42 	blhi	103980 <__bss_end+0xfa9c0>
  74:	0b0d4201 	bleq	350880 <__bss_end+0x3478c0>
  78:	420d0d54 	andmi	r0, sp, #84, 26	; 0x1500
  7c:	00000ecb 	andeq	r0, r0, fp, asr #29
  80:	0000001c 	andeq	r0, r0, ip, lsl r0
  84:	00000050 	andeq	r0, r0, r0, asr r0
  88:	000080dc 	ldrdeq	r8, [r0], -ip
  8c:	0000002c 	andeq	r0, r0, ip, lsr #32
  90:	8b040e42 	blhi	1039a0 <__bss_end+0xfa9e0>
  94:	0b0d4201 	bleq	3508a0 <__bss_end+0x3478e0>
  98:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
  9c:	00000ecb 	andeq	r0, r0, fp, asr #29
  a0:	0000001c 	andeq	r0, r0, ip, lsl r0
  a4:	00000050 	andeq	r0, r0, r0, asr r0
  a8:	00008108 	andeq	r8, r0, r8, lsl #2
  ac:	00000020 	andeq	r0, r0, r0, lsr #32
  b0:	8b040e42 	blhi	1039c0 <__bss_end+0xfaa00>
  b4:	0b0d4201 	bleq	3508c0 <__bss_end+0x347900>
  b8:	420d0d48 	andmi	r0, sp, #72, 26	; 0x1200
  bc:	00000ecb 	andeq	r0, r0, fp, asr #29
  c0:	0000001c 	andeq	r0, r0, ip, lsl r0
  c4:	00000050 	andeq	r0, r0, r0, asr r0
  c8:	00008128 	andeq	r8, r0, r8, lsr #2
  cc:	00000018 	andeq	r0, r0, r8, lsl r0
  d0:	8b040e42 	blhi	1039e0 <__bss_end+0xfaa20>
  d4:	0b0d4201 	bleq	3508e0 <__bss_end+0x347920>
  d8:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
  dc:	00000ecb 	andeq	r0, r0, fp, asr #29
  e0:	0000001c 	andeq	r0, r0, ip, lsl r0
  e4:	00000050 	andeq	r0, r0, r0, asr r0
  e8:	00008140 	andeq	r8, r0, r0, asr #2
  ec:	00000018 	andeq	r0, r0, r8, lsl r0
  f0:	8b040e42 	blhi	103a00 <__bss_end+0xfaa40>
  f4:	0b0d4201 	bleq	350900 <__bss_end+0x347940>
  f8:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
  fc:	00000ecb 	andeq	r0, r0, fp, asr #29
 100:	0000001c 	andeq	r0, r0, ip, lsl r0
 104:	00000050 	andeq	r0, r0, r0, asr r0
 108:	00008158 	andeq	r8, r0, r8, asr r1
 10c:	00000018 	andeq	r0, r0, r8, lsl r0
 110:	8b040e42 	blhi	103a20 <__bss_end+0xfaa60>
 114:	0b0d4201 	bleq	350920 <__bss_end+0x347960>
 118:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
 11c:	00000ecb 	andeq	r0, r0, fp, asr #29
 120:	00000014 	andeq	r0, r0, r4, lsl r0
 124:	00000050 	andeq	r0, r0, r0, asr r0
 128:	00008170 	andeq	r8, r0, r0, ror r1
 12c:	0000000c 	andeq	r0, r0, ip
 130:	8b040e42 	blhi	103a40 <__bss_end+0xfaa80>
 134:	0b0d4201 	bleq	350940 <__bss_end+0x347980>
 138:	0000001c 	andeq	r0, r0, ip, lsl r0
 13c:	00000050 	andeq	r0, r0, r0, asr r0
 140:	0000817c 	andeq	r8, r0, ip, ror r1
 144:	00000058 	andeq	r0, r0, r8, asr r0
 148:	8b080e42 	blhi	203a58 <__bss_end+0x1faa98>
 14c:	42018e02 	andmi	r8, r1, #2, 28
 150:	62040b0c 	andvs	r0, r4, #12, 22	; 0x3000
 154:	00080d0c 	andeq	r0, r8, ip, lsl #26
 158:	0000001c 	andeq	r0, r0, ip, lsl r0
 15c:	00000050 	andeq	r0, r0, r0, asr r0
 160:	000081d4 	ldrdeq	r8, [r0], -r4
 164:	00000058 	andeq	r0, r0, r8, asr r0
 168:	8b080e42 	blhi	203a78 <__bss_end+0x1faab8>
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
 194:	00000194 	muleq	r0, r4, r1
 198:	8b080e42 	blhi	203aa8 <__bss_end+0x1faae8>
 19c:	42018e02 	andmi	r8, r1, #2, 28
 1a0:	00040b0c 	andeq	r0, r4, ip, lsl #22
 1a4:	0000000c 	andeq	r0, r0, ip
 1a8:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 1ac:	7c020001 	stcvc	0, cr0, [r2], {1}
 1b0:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 1b4:	0000001c 	andeq	r0, r0, ip, lsl r0
 1b8:	000001a4 	andeq	r0, r0, r4, lsr #3
 1bc:	000083c0 	andeq	r8, r0, r0, asr #7
 1c0:	0000002c 	andeq	r0, r0, ip, lsr #32
 1c4:	8b040e42 	blhi	103ad4 <__bss_end+0xfab14>
 1c8:	0b0d4201 	bleq	3509d4 <__bss_end+0x347a14>
 1cc:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
 1d0:	00000ecb 	andeq	r0, r0, fp, asr #29
 1d4:	0000001c 	andeq	r0, r0, ip, lsl r0
 1d8:	000001a4 	andeq	r0, r0, r4, lsr #3
 1dc:	000083ec 	andeq	r8, r0, ip, ror #7
 1e0:	0000002c 	andeq	r0, r0, ip, lsr #32
 1e4:	8b040e42 	blhi	103af4 <__bss_end+0xfab34>
 1e8:	0b0d4201 	bleq	3509f4 <__bss_end+0x347a34>
 1ec:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
 1f0:	00000ecb 	andeq	r0, r0, fp, asr #29
 1f4:	0000001c 	andeq	r0, r0, ip, lsl r0
 1f8:	000001a4 	andeq	r0, r0, r4, lsr #3
 1fc:	00008418 	andeq	r8, r0, r8, lsl r4
 200:	0000001c 	andeq	r0, r0, ip, lsl r0
 204:	8b040e42 	blhi	103b14 <__bss_end+0xfab54>
 208:	0b0d4201 	bleq	350a14 <__bss_end+0x347a54>
 20c:	420d0d46 	andmi	r0, sp, #4480	; 0x1180
 210:	00000ecb 	andeq	r0, r0, fp, asr #29
 214:	0000001c 	andeq	r0, r0, ip, lsl r0
 218:	000001a4 	andeq	r0, r0, r4, lsr #3
 21c:	00008434 	andeq	r8, r0, r4, lsr r4
 220:	00000044 	andeq	r0, r0, r4, asr #32
 224:	8b040e42 	blhi	103b34 <__bss_end+0xfab74>
 228:	0b0d4201 	bleq	350a34 <__bss_end+0x347a74>
 22c:	420d0d5a 	andmi	r0, sp, #5760	; 0x1680
 230:	00000ecb 	andeq	r0, r0, fp, asr #29
 234:	0000001c 	andeq	r0, r0, ip, lsl r0
 238:	000001a4 	andeq	r0, r0, r4, lsr #3
 23c:	00008478 	andeq	r8, r0, r8, ror r4
 240:	00000050 	andeq	r0, r0, r0, asr r0
 244:	8b040e42 	blhi	103b54 <__bss_end+0xfab94>
 248:	0b0d4201 	bleq	350a54 <__bss_end+0x347a94>
 24c:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 250:	00000ecb 	andeq	r0, r0, fp, asr #29
 254:	0000001c 	andeq	r0, r0, ip, lsl r0
 258:	000001a4 	andeq	r0, r0, r4, lsr #3
 25c:	000084c8 	andeq	r8, r0, r8, asr #9
 260:	00000050 	andeq	r0, r0, r0, asr r0
 264:	8b040e42 	blhi	103b74 <__bss_end+0xfabb4>
 268:	0b0d4201 	bleq	350a74 <__bss_end+0x347ab4>
 26c:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 270:	00000ecb 	andeq	r0, r0, fp, asr #29
 274:	0000001c 	andeq	r0, r0, ip, lsl r0
 278:	000001a4 	andeq	r0, r0, r4, lsr #3
 27c:	00008518 	andeq	r8, r0, r8, lsl r5
 280:	0000002c 	andeq	r0, r0, ip, lsr #32
 284:	8b040e42 	blhi	103b94 <__bss_end+0xfabd4>
 288:	0b0d4201 	bleq	350a94 <__bss_end+0x347ad4>
 28c:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
 290:	00000ecb 	andeq	r0, r0, fp, asr #29
 294:	0000001c 	andeq	r0, r0, ip, lsl r0
 298:	000001a4 	andeq	r0, r0, r4, lsr #3
 29c:	00008544 	andeq	r8, r0, r4, asr #10
 2a0:	00000050 	andeq	r0, r0, r0, asr r0
 2a4:	8b040e42 	blhi	103bb4 <__bss_end+0xfabf4>
 2a8:	0b0d4201 	bleq	350ab4 <__bss_end+0x347af4>
 2ac:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 2b0:	00000ecb 	andeq	r0, r0, fp, asr #29
 2b4:	0000001c 	andeq	r0, r0, ip, lsl r0
 2b8:	000001a4 	andeq	r0, r0, r4, lsr #3
 2bc:	00008594 	muleq	r0, r4, r5
 2c0:	00000044 	andeq	r0, r0, r4, asr #32
 2c4:	8b040e42 	blhi	103bd4 <__bss_end+0xfac14>
 2c8:	0b0d4201 	bleq	350ad4 <__bss_end+0x347b14>
 2cc:	420d0d5a 	andmi	r0, sp, #5760	; 0x1680
 2d0:	00000ecb 	andeq	r0, r0, fp, asr #29
 2d4:	0000001c 	andeq	r0, r0, ip, lsl r0
 2d8:	000001a4 	andeq	r0, r0, r4, lsr #3
 2dc:	000085d8 	ldrdeq	r8, [r0], -r8	; <UNPREDICTABLE>
 2e0:	00000050 	andeq	r0, r0, r0, asr r0
 2e4:	8b040e42 	blhi	103bf4 <__bss_end+0xfac34>
 2e8:	0b0d4201 	bleq	350af4 <__bss_end+0x347b34>
 2ec:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 2f0:	00000ecb 	andeq	r0, r0, fp, asr #29
 2f4:	0000001c 	andeq	r0, r0, ip, lsl r0
 2f8:	000001a4 	andeq	r0, r0, r4, lsr #3
 2fc:	00008628 	andeq	r8, r0, r8, lsr #12
 300:	00000054 	andeq	r0, r0, r4, asr r0
 304:	8b040e42 	blhi	103c14 <__bss_end+0xfac54>
 308:	0b0d4201 	bleq	350b14 <__bss_end+0x347b54>
 30c:	420d0d62 	andmi	r0, sp, #6272	; 0x1880
 310:	00000ecb 	andeq	r0, r0, fp, asr #29
 314:	0000001c 	andeq	r0, r0, ip, lsl r0
 318:	000001a4 	andeq	r0, r0, r4, lsr #3
 31c:	0000867c 	andeq	r8, r0, ip, ror r6
 320:	0000003c 	andeq	r0, r0, ip, lsr r0
 324:	8b040e42 	blhi	103c34 <__bss_end+0xfac74>
 328:	0b0d4201 	bleq	350b34 <__bss_end+0x347b74>
 32c:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 330:	00000ecb 	andeq	r0, r0, fp, asr #29
 334:	0000001c 	andeq	r0, r0, ip, lsl r0
 338:	000001a4 	andeq	r0, r0, r4, lsr #3
 33c:	000086b8 			; <UNDEFINED> instruction: 0x000086b8
 340:	0000003c 	andeq	r0, r0, ip, lsr r0
 344:	8b040e42 	blhi	103c54 <__bss_end+0xfac94>
 348:	0b0d4201 	bleq	350b54 <__bss_end+0x347b94>
 34c:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 350:	00000ecb 	andeq	r0, r0, fp, asr #29
 354:	0000001c 	andeq	r0, r0, ip, lsl r0
 358:	000001a4 	andeq	r0, r0, r4, lsr #3
 35c:	000086f4 	strdeq	r8, [r0], -r4
 360:	0000003c 	andeq	r0, r0, ip, lsr r0
 364:	8b040e42 	blhi	103c74 <__bss_end+0xfacb4>
 368:	0b0d4201 	bleq	350b74 <__bss_end+0x347bb4>
 36c:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 370:	00000ecb 	andeq	r0, r0, fp, asr #29
 374:	0000001c 	andeq	r0, r0, ip, lsl r0
 378:	000001a4 	andeq	r0, r0, r4, lsr #3
 37c:	00008730 	andeq	r8, r0, r0, lsr r7
 380:	0000003c 	andeq	r0, r0, ip, lsr r0
 384:	8b040e42 	blhi	103c94 <__bss_end+0xfacd4>
 388:	0b0d4201 	bleq	350b94 <__bss_end+0x347bd4>
 38c:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 390:	00000ecb 	andeq	r0, r0, fp, asr #29
 394:	0000001c 	andeq	r0, r0, ip, lsl r0
 398:	000001a4 	andeq	r0, r0, r4, lsr #3
 39c:	0000876c 	andeq	r8, r0, ip, ror #14
 3a0:	000000b0 	strheq	r0, [r0], -r0	; <UNPREDICTABLE>
 3a4:	8b080e42 	blhi	203cb4 <__bss_end+0x1facf4>
 3a8:	42018e02 	andmi	r8, r1, #2, 28
 3ac:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 3b0:	080d0c50 	stmdaeq	sp, {r4, r6, sl, fp}
 3b4:	0000000c 	andeq	r0, r0, ip
 3b8:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 3bc:	7c020001 	stcvc	0, cr0, [r2], {1}
 3c0:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 3c4:	0000001c 	andeq	r0, r0, ip, lsl r0
 3c8:	000003b4 			; <UNDEFINED> instruction: 0x000003b4
 3cc:	0000881c 	andeq	r8, r0, ip, lsl r8
 3d0:	00000174 	andeq	r0, r0, r4, ror r1
 3d4:	8b080e42 	blhi	203ce4 <__bss_end+0x1fad24>
 3d8:	42018e02 	andmi	r8, r1, #2, 28
 3dc:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 3e0:	080d0cb2 	stmdaeq	sp, {r1, r4, r5, r7, sl, fp}
 3e4:	0000001c 	andeq	r0, r0, ip, lsl r0
 3e8:	000003b4 			; <UNDEFINED> instruction: 0x000003b4
 3ec:	00008990 	muleq	r0, r0, r9
 3f0:	0000009c 	muleq	r0, ip, r0
 3f4:	8b040e42 	blhi	103d04 <__bss_end+0xfad44>
 3f8:	0b0d4201 	bleq	350c04 <__bss_end+0x347c44>
 3fc:	0d0d4602 	stceq	6, cr4, [sp, #-8]
 400:	000ecb42 	andeq	ip, lr, r2, asr #22
 404:	0000001c 	andeq	r0, r0, ip, lsl r0
 408:	000003b4 			; <UNDEFINED> instruction: 0x000003b4
 40c:	00008a2c 	andeq	r8, r0, ip, lsr #20
 410:	000000c0 	andeq	r0, r0, r0, asr #1
 414:	8b040e42 	blhi	103d24 <__bss_end+0xfad64>
 418:	0b0d4201 	bleq	350c24 <__bss_end+0x347c64>
 41c:	0d0d5802 	stceq	8, cr5, [sp, #-8]
 420:	000ecb42 	andeq	ip, lr, r2, asr #22
 424:	0000001c 	andeq	r0, r0, ip, lsl r0
 428:	000003b4 			; <UNDEFINED> instruction: 0x000003b4
 42c:	00008aec 	andeq	r8, r0, ip, ror #21
 430:	000000ac 	andeq	r0, r0, ip, lsr #1
 434:	8b040e42 	blhi	103d44 <__bss_end+0xfad84>
 438:	0b0d4201 	bleq	350c44 <__bss_end+0x347c84>
 43c:	0d0d4e02 	stceq	14, cr4, [sp, #-8]
 440:	000ecb42 	andeq	ip, lr, r2, asr #22
 444:	0000001c 	andeq	r0, r0, ip, lsl r0
 448:	000003b4 			; <UNDEFINED> instruction: 0x000003b4
 44c:	00008b98 	muleq	r0, r8, fp
 450:	00000054 	andeq	r0, r0, r4, asr r0
 454:	8b040e42 	blhi	103d64 <__bss_end+0xfada4>
 458:	0b0d4201 	bleq	350c64 <__bss_end+0x347ca4>
 45c:	420d0d62 	andmi	r0, sp, #6272	; 0x1880
 460:	00000ecb 	andeq	r0, r0, fp, asr #29
 464:	0000001c 	andeq	r0, r0, ip, lsl r0
 468:	000003b4 			; <UNDEFINED> instruction: 0x000003b4
 46c:	00008bec 	andeq	r8, r0, ip, ror #23
 470:	00000068 	andeq	r0, r0, r8, rrx
 474:	8b040e42 	blhi	103d84 <__bss_end+0xfadc4>
 478:	0b0d4201 	bleq	350c84 <__bss_end+0x347cc4>
 47c:	420d0d6c 	andmi	r0, sp, #108, 26	; 0x1b00
 480:	00000ecb 	andeq	r0, r0, fp, asr #29
 484:	0000001c 	andeq	r0, r0, ip, lsl r0
 488:	000003b4 			; <UNDEFINED> instruction: 0x000003b4
 48c:	00008c54 	andeq	r8, r0, r4, asr ip
 490:	00000080 	andeq	r0, r0, r0, lsl #1
 494:	8b040e42 	blhi	103da4 <__bss_end+0xfade4>
 498:	0b0d4201 	bleq	350ca4 <__bss_end+0x347ce4>
 49c:	420d0d78 	andmi	r0, sp, #120, 26	; 0x1e00
 4a0:	00000ecb 	andeq	r0, r0, fp, asr #29
 4a4:	0000000c 	andeq	r0, r0, ip
 4a8:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 4ac:	7c010001 	stcvc	0, cr0, [r1], {1}
 4b0:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 4b4:	0000000c 	andeq	r0, r0, ip
 4b8:	000004a4 	andeq	r0, r0, r4, lsr #9
 4bc:	00008cd4 	ldrdeq	r8, [r0], -r4
 4c0:	000001ec 	andeq	r0, r0, ip, ror #3
