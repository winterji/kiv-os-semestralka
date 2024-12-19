
./init_task:     file format elf32-littlearm


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
    805c:	00008e10 	andeq	r8, r0, r0, lsl lr
    8060:	00008e20 	andeq	r8, r0, r0, lsr #28

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
    81cc:	00008e0d 	andeq	r8, r0, sp, lsl #28
    81d0:	00008e0d 	andeq	r8, r0, sp, lsl #28

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
    8224:	00008e0d 	andeq	r8, r0, sp, lsl #28
    8228:	00008e0d 	andeq	r8, r0, sp, lsl #28

0000822c <main>:
main():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/init_task/main.cpp:6
#include <stdfile.h>

#include <process/process_manager.h>

int main(int argc, char** argv)
{
    822c:	e92d4800 	push	{fp, lr}
    8230:	e28db004 	add	fp, sp, #4
    8234:	e24dd008 	sub	sp, sp, #8
    8238:	e50b0008 	str	r0, [fp, #-8]
    823c:	e50b100c 	str	r1, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/init_task/main.cpp:11
	// systemovy init task startuje jako prvni, a ma nejnizsi prioritu ze vsech - bude se tedy planovat v podstate jen tehdy,
	// kdy nic jineho nikdo nema na praci

	// nastavime deadline na "nekonecno" = vlastne snizime dynamickou prioritu na nejnizsi moznou
	set_task_deadline(Indefinite);
    8240:	e3e00000 	mvn	r0, #0
    8244:	eb0000d7 	bl	85a8 <_Z17set_task_deadlinej>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/init_task/main.cpp:18
	// TODO: tady budeme chtit nechat spoustet zbytek procesu, az budeme umet nacitat treba z eMMC a SD karty
	
	while (true)
	{
		// kdyz je planovany jen tento proces, pockame na udalost (preruseni, ...)
		if (get_active_process_count() == 1)
    8248:	eb0000b8 	bl	8530 <_Z24get_active_process_countv>
    824c:	e1a03000 	mov	r3, r0
    8250:	e3530001 	cmp	r3, #1
    8254:	03a03001 	moveq	r3, #1
    8258:	13a03000 	movne	r3, #0
    825c:	e6ef3073 	uxtb	r3, r3
    8260:	e3530000 	cmp	r3, #0
    8264:	0a000000 	beq	826c <main+0x40>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/init_task/main.cpp:19
			asm volatile("wfe");
    8268:	e320f002 	wfe
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/init_task/main.cpp:22

		// predame zbytek casoveho kvanta dalsimu procesu
		sched_yield();
    826c:	eb000016 	bl	82cc <_Z11sched_yieldv>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/init_task/main.cpp:18
		if (get_active_process_count() == 1)
    8270:	eafffff4 	b	8248 <main+0x1c>

00008274 <_Z6getpidv>:
_Z6getpidv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:5
#include <stdfile.h>
#include <stdstring.h>

uint32_t getpid()
{
    8274:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8278:	e28db000 	add	fp, sp, #0
    827c:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:8
    uint32_t pid;

    asm volatile("swi 0");
    8280:	ef000000 	svc	0x00000000
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:9
    asm volatile("mov %0, r0" : "=r" (pid));
    8284:	e1a03000 	mov	r3, r0
    8288:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:11

    return pid;
    828c:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:12
}
    8290:	e1a00003 	mov	r0, r3
    8294:	e28bd000 	add	sp, fp, #0
    8298:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    829c:	e12fff1e 	bx	lr

000082a0 <_Z9terminatei>:
_Z9terminatei():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:15

void terminate(int exitcode)
{
    82a0:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    82a4:	e28db000 	add	fp, sp, #0
    82a8:	e24dd00c 	sub	sp, sp, #12
    82ac:	e50b0008 	str	r0, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:16
    asm volatile("mov r0, %0" : : "r" (exitcode));
    82b0:	e51b3008 	ldr	r3, [fp, #-8]
    82b4:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:17
    asm volatile("swi 1");
    82b8:	ef000001 	svc	0x00000001
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:18
}
    82bc:	e320f000 	nop	{0}
    82c0:	e28bd000 	add	sp, fp, #0
    82c4:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    82c8:	e12fff1e 	bx	lr

000082cc <_Z11sched_yieldv>:
_Z11sched_yieldv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:21

void sched_yield()
{
    82cc:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    82d0:	e28db000 	add	fp, sp, #0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:22
    asm volatile("swi 2");
    82d4:	ef000002 	svc	0x00000002
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:23
}
    82d8:	e320f000 	nop	{0}
    82dc:	e28bd000 	add	sp, fp, #0
    82e0:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    82e4:	e12fff1e 	bx	lr

000082e8 <_Z4openPKc15NFile_Open_Mode>:
_Z4openPKc15NFile_Open_Mode():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:26

uint32_t open(const char* filename, NFile_Open_Mode mode)
{
    82e8:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    82ec:	e28db000 	add	fp, sp, #0
    82f0:	e24dd014 	sub	sp, sp, #20
    82f4:	e50b0010 	str	r0, [fp, #-16]
    82f8:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:29
    uint32_t file;

    asm volatile("mov r0, %0" : : "r" (filename));
    82fc:	e51b3010 	ldr	r3, [fp, #-16]
    8300:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:30
    asm volatile("mov r1, %0" : : "r" (mode));
    8304:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8308:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:31
    asm volatile("swi 64");
    830c:	ef000040 	svc	0x00000040
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:32
    asm volatile("mov %0, r0" : "=r" (file));
    8310:	e1a03000 	mov	r3, r0
    8314:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:33
    return file;
    8318:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:34
}
    831c:	e1a00003 	mov	r0, r3
    8320:	e28bd000 	add	sp, fp, #0
    8324:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8328:	e12fff1e 	bx	lr

0000832c <_Z4readjPcj>:
_Z4readjPcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:37

uint32_t read(uint32_t file, char* const buffer, uint32_t size)
{
    832c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8330:	e28db000 	add	fp, sp, #0
    8334:	e24dd01c 	sub	sp, sp, #28
    8338:	e50b0010 	str	r0, [fp, #-16]
    833c:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8340:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:40
    uint32_t rdnum;

    asm volatile("mov r0, %0" : : "r" (file));
    8344:	e51b3010 	ldr	r3, [fp, #-16]
    8348:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:41
    asm volatile("mov r1, %0" : : "r" (buffer));
    834c:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8350:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:42
    asm volatile("mov r2, %0" : : "r" (size));
    8354:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8358:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:43
    asm volatile("swi 65");
    835c:	ef000041 	svc	0x00000041
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:44
    asm volatile("mov %0, r0" : "=r" (rdnum));
    8360:	e1a03000 	mov	r3, r0
    8364:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:46

    return rdnum;
    8368:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:47
}
    836c:	e1a00003 	mov	r0, r3
    8370:	e28bd000 	add	sp, fp, #0
    8374:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8378:	e12fff1e 	bx	lr

0000837c <_Z5writejPKcj>:
_Z5writejPKcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:50

uint32_t write(uint32_t file, const char* buffer, uint32_t size)
{
    837c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8380:	e28db000 	add	fp, sp, #0
    8384:	e24dd01c 	sub	sp, sp, #28
    8388:	e50b0010 	str	r0, [fp, #-16]
    838c:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8390:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:53
    uint32_t wrnum;

    asm volatile("mov r0, %0" : : "r" (file));
    8394:	e51b3010 	ldr	r3, [fp, #-16]
    8398:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:54
    asm volatile("mov r1, %0" : : "r" (buffer));
    839c:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    83a0:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:55
    asm volatile("mov r2, %0" : : "r" (size));
    83a4:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    83a8:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:56
    asm volatile("swi 66");
    83ac:	ef000042 	svc	0x00000042
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:57
    asm volatile("mov %0, r0" : "=r" (wrnum));
    83b0:	e1a03000 	mov	r3, r0
    83b4:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:59

    return wrnum;
    83b8:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:60
}
    83bc:	e1a00003 	mov	r0, r3
    83c0:	e28bd000 	add	sp, fp, #0
    83c4:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    83c8:	e12fff1e 	bx	lr

000083cc <_Z5closej>:
_Z5closej():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:63

void close(uint32_t file)
{
    83cc:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    83d0:	e28db000 	add	fp, sp, #0
    83d4:	e24dd00c 	sub	sp, sp, #12
    83d8:	e50b0008 	str	r0, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:64
    asm volatile("mov r0, %0" : : "r" (file));
    83dc:	e51b3008 	ldr	r3, [fp, #-8]
    83e0:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:65
    asm volatile("swi 67");
    83e4:	ef000043 	svc	0x00000043
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:66
}
    83e8:	e320f000 	nop	{0}
    83ec:	e28bd000 	add	sp, fp, #0
    83f0:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    83f4:	e12fff1e 	bx	lr

000083f8 <_Z5ioctlj16NIOCtl_OperationPv>:
_Z5ioctlj16NIOCtl_OperationPv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:69

uint32_t ioctl(uint32_t file, NIOCtl_Operation operation, void* param)
{
    83f8:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    83fc:	e28db000 	add	fp, sp, #0
    8400:	e24dd01c 	sub	sp, sp, #28
    8404:	e50b0010 	str	r0, [fp, #-16]
    8408:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    840c:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:72
    uint32_t retcode;

    asm volatile("mov r0, %0" : : "r" (file));
    8410:	e51b3010 	ldr	r3, [fp, #-16]
    8414:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:73
    asm volatile("mov r1, %0" : : "r" (operation));
    8418:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    841c:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:74
    asm volatile("mov r2, %0" : : "r" (param));
    8420:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8424:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:75
    asm volatile("swi 68");
    8428:	ef000044 	svc	0x00000044
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:76
    asm volatile("mov %0, r0" : "=r" (retcode));
    842c:	e1a03000 	mov	r3, r0
    8430:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:78

    return retcode;
    8434:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:79
}
    8438:	e1a00003 	mov	r0, r3
    843c:	e28bd000 	add	sp, fp, #0
    8440:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8444:	e12fff1e 	bx	lr

00008448 <_Z6notifyjj>:
_Z6notifyjj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:82

uint32_t notify(uint32_t file, uint32_t count)
{
    8448:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    844c:	e28db000 	add	fp, sp, #0
    8450:	e24dd014 	sub	sp, sp, #20
    8454:	e50b0010 	str	r0, [fp, #-16]
    8458:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:85
    uint32_t retcnt;

    asm volatile("mov r0, %0" : : "r" (file));
    845c:	e51b3010 	ldr	r3, [fp, #-16]
    8460:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:86
    asm volatile("mov r1, %0" : : "r" (count));
    8464:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8468:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:87
    asm volatile("swi 69");
    846c:	ef000045 	svc	0x00000045
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:88
    asm volatile("mov %0, r0" : "=r" (retcnt));
    8470:	e1a03000 	mov	r3, r0
    8474:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:90

    return retcnt;
    8478:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:91
}
    847c:	e1a00003 	mov	r0, r3
    8480:	e28bd000 	add	sp, fp, #0
    8484:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8488:	e12fff1e 	bx	lr

0000848c <_Z4waitjjj>:
_Z4waitjjj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:94

NSWI_Result_Code wait(uint32_t file, uint32_t count, uint32_t notified_deadline)
{
    848c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8490:	e28db000 	add	fp, sp, #0
    8494:	e24dd01c 	sub	sp, sp, #28
    8498:	e50b0010 	str	r0, [fp, #-16]
    849c:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    84a0:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:97
    NSWI_Result_Code retcode;

    asm volatile("mov r0, %0" : : "r" (file));
    84a4:	e51b3010 	ldr	r3, [fp, #-16]
    84a8:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:98
    asm volatile("mov r1, %0" : : "r" (count));
    84ac:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    84b0:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:99
    asm volatile("mov r2, %0" : : "r" (notified_deadline));
    84b4:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    84b8:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:100
    asm volatile("swi 70");
    84bc:	ef000046 	svc	0x00000046
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:101
    asm volatile("mov %0, r0" : "=r" (retcode));
    84c0:	e1a03000 	mov	r3, r0
    84c4:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:103

    return retcode;
    84c8:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:104
}
    84cc:	e1a00003 	mov	r0, r3
    84d0:	e28bd000 	add	sp, fp, #0
    84d4:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    84d8:	e12fff1e 	bx	lr

000084dc <_Z5sleepjj>:
_Z5sleepjj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:107

bool sleep(uint32_t ticks, uint32_t notified_deadline)
{
    84dc:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    84e0:	e28db000 	add	fp, sp, #0
    84e4:	e24dd014 	sub	sp, sp, #20
    84e8:	e50b0010 	str	r0, [fp, #-16]
    84ec:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:110
    uint32_t retcode;

    asm volatile("mov r0, %0" : : "r" (ticks));
    84f0:	e51b3010 	ldr	r3, [fp, #-16]
    84f4:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:111
    asm volatile("mov r1, %0" : : "r" (notified_deadline));
    84f8:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    84fc:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:112
    asm volatile("swi 3");
    8500:	ef000003 	svc	0x00000003
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:113
    asm volatile("mov %0, r0" : "=r" (retcode));
    8504:	e1a03000 	mov	r3, r0
    8508:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:115

    return retcode;
    850c:	e51b3008 	ldr	r3, [fp, #-8]
    8510:	e3530000 	cmp	r3, #0
    8514:	13a03001 	movne	r3, #1
    8518:	03a03000 	moveq	r3, #0
    851c:	e6ef3073 	uxtb	r3, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:116
}
    8520:	e1a00003 	mov	r0, r3
    8524:	e28bd000 	add	sp, fp, #0
    8528:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    852c:	e12fff1e 	bx	lr

00008530 <_Z24get_active_process_countv>:
_Z24get_active_process_countv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:119

uint32_t get_active_process_count()
{
    8530:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8534:	e28db000 	add	fp, sp, #0
    8538:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:120
    const NGet_Sched_Info_Type req = NGet_Sched_Info_Type::Active_Process_Count;
    853c:	e3a03000 	mov	r3, #0
    8540:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:123
    uint32_t retval;

    asm volatile("mov r0, %0" : : "r" (req));
    8544:	e3a03000 	mov	r3, #0
    8548:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:124
    asm volatile("mov r1, %0" : : "r" (&retval));
    854c:	e24b300c 	sub	r3, fp, #12
    8550:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:125
    asm volatile("swi 4");
    8554:	ef000004 	svc	0x00000004
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:127

    return retval;
    8558:	e51b300c 	ldr	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:128
}
    855c:	e1a00003 	mov	r0, r3
    8560:	e28bd000 	add	sp, fp, #0
    8564:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8568:	e12fff1e 	bx	lr

0000856c <_Z14get_tick_countv>:
_Z14get_tick_countv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:131

uint32_t get_tick_count()
{
    856c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8570:	e28db000 	add	fp, sp, #0
    8574:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:132
    const NGet_Sched_Info_Type req = NGet_Sched_Info_Type::Tick_Count;
    8578:	e3a03001 	mov	r3, #1
    857c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:135
    uint32_t retval;

    asm volatile("mov r0, %0" : : "r" (req));
    8580:	e3a03001 	mov	r3, #1
    8584:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:136
    asm volatile("mov r1, %0" : : "r" (&retval));
    8588:	e24b300c 	sub	r3, fp, #12
    858c:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:137
    asm volatile("swi 4");
    8590:	ef000004 	svc	0x00000004
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:139

    return retval;
    8594:	e51b300c 	ldr	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:140
}
    8598:	e1a00003 	mov	r0, r3
    859c:	e28bd000 	add	sp, fp, #0
    85a0:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    85a4:	e12fff1e 	bx	lr

000085a8 <_Z17set_task_deadlinej>:
_Z17set_task_deadlinej():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:143

void set_task_deadline(uint32_t tick_count_required)
{
    85a8:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    85ac:	e28db000 	add	fp, sp, #0
    85b0:	e24dd014 	sub	sp, sp, #20
    85b4:	e50b0010 	str	r0, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:144
    const NDeadline_Subservice req = NDeadline_Subservice::Set_Relative;
    85b8:	e3a03000 	mov	r3, #0
    85bc:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:146

    asm volatile("mov r0, %0" : : "r" (req));
    85c0:	e3a03000 	mov	r3, #0
    85c4:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:147
    asm volatile("mov r1, %0" : : "r" (&tick_count_required));
    85c8:	e24b3010 	sub	r3, fp, #16
    85cc:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:148
    asm volatile("swi 5");
    85d0:	ef000005 	svc	0x00000005
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:149
}
    85d4:	e320f000 	nop	{0}
    85d8:	e28bd000 	add	sp, fp, #0
    85dc:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    85e0:	e12fff1e 	bx	lr

000085e4 <_Z26get_task_ticks_to_deadlinev>:
_Z26get_task_ticks_to_deadlinev():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:152

uint32_t get_task_ticks_to_deadline()
{
    85e4:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    85e8:	e28db000 	add	fp, sp, #0
    85ec:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:153
    const NDeadline_Subservice req = NDeadline_Subservice::Get_Remaining;
    85f0:	e3a03001 	mov	r3, #1
    85f4:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:156
    uint32_t ticks;

    asm volatile("mov r0, %0" : : "r" (req));
    85f8:	e3a03001 	mov	r3, #1
    85fc:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:157
    asm volatile("mov r1, %0" : : "r" (&ticks));
    8600:	e24b300c 	sub	r3, fp, #12
    8604:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:158
    asm volatile("swi 5");
    8608:	ef000005 	svc	0x00000005
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:160

    return ticks;
    860c:	e51b300c 	ldr	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:161
}
    8610:	e1a00003 	mov	r0, r3
    8614:	e28bd000 	add	sp, fp, #0
    8618:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    861c:	e12fff1e 	bx	lr

00008620 <_Z4pipePKcj>:
_Z4pipePKcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:166

const char Pipe_File_Prefix[] = "SYS:pipe/";

uint32_t pipe(const char* name, uint32_t buf_size)
{
    8620:	e92d4800 	push	{fp, lr}
    8624:	e28db004 	add	fp, sp, #4
    8628:	e24dd050 	sub	sp, sp, #80	; 0x50
    862c:	e50b0050 	str	r0, [fp, #-80]	; 0xffffffb0
    8630:	e50b1054 	str	r1, [fp, #-84]	; 0xffffffac
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:168
    char fname[64];
    strncpy(fname, Pipe_File_Prefix, sizeof(Pipe_File_Prefix));
    8634:	e24b3048 	sub	r3, fp, #72	; 0x48
    8638:	e3a0200a 	mov	r2, #10
    863c:	e59f1088 	ldr	r1, [pc, #136]	; 86cc <_Z4pipePKcj+0xac>
    8640:	e1a00003 	mov	r0, r3
    8644:	eb0000a5 	bl	88e0 <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:169
    strncpy(fname + sizeof(Pipe_File_Prefix), name, sizeof(fname) - sizeof(Pipe_File_Prefix) - 1);
    8648:	e24b3048 	sub	r3, fp, #72	; 0x48
    864c:	e283300a 	add	r3, r3, #10
    8650:	e3a02035 	mov	r2, #53	; 0x35
    8654:	e51b1050 	ldr	r1, [fp, #-80]	; 0xffffffb0
    8658:	e1a00003 	mov	r0, r3
    865c:	eb00009f 	bl	88e0 <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:171

    int ncur = sizeof(Pipe_File_Prefix) + strlen(name);
    8660:	e51b0050 	ldr	r0, [fp, #-80]	; 0xffffffb0
    8664:	eb0000f8 	bl	8a4c <_Z6strlenPKc>
    8668:	e1a03000 	mov	r3, r0
    866c:	e283300a 	add	r3, r3, #10
    8670:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:173

    fname[ncur++] = '#';
    8674:	e51b3008 	ldr	r3, [fp, #-8]
    8678:	e2832001 	add	r2, r3, #1
    867c:	e50b2008 	str	r2, [fp, #-8]
    8680:	e2433004 	sub	r3, r3, #4
    8684:	e083300b 	add	r3, r3, fp
    8688:	e3a02023 	mov	r2, #35	; 0x23
    868c:	e5432044 	strb	r2, [r3, #-68]	; 0xffffffbc
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:175

    itoa(buf_size, &fname[ncur], 10);
    8690:	e24b2048 	sub	r2, fp, #72	; 0x48
    8694:	e51b3008 	ldr	r3, [fp, #-8]
    8698:	e0823003 	add	r3, r2, r3
    869c:	e3a0200a 	mov	r2, #10
    86a0:	e1a01003 	mov	r1, r3
    86a4:	e51b0054 	ldr	r0, [fp, #-84]	; 0xffffffac
    86a8:	eb000008 	bl	86d0 <_Z4itoajPcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:177

    return open(fname, NFile_Open_Mode::Read_Write);
    86ac:	e24b3048 	sub	r3, fp, #72	; 0x48
    86b0:	e3a01002 	mov	r1, #2
    86b4:	e1a00003 	mov	r0, r3
    86b8:	ebffff0a 	bl	82e8 <_Z4openPKc15NFile_Open_Mode>
    86bc:	e1a03000 	mov	r3, r0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:178
}
    86c0:	e1a00003 	mov	r0, r3
    86c4:	e24bd004 	sub	sp, fp, #4
    86c8:	e8bd8800 	pop	{fp, pc}
    86cc:	00008df0 	strdeq	r8, [r0], -r0

000086d0 <_Z4itoajPcj>:
_Z4itoajPcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:9
{
    const char CharConvArr[] = "0123456789ABCDEF";
}

void itoa(unsigned int input, char* output, unsigned int base)
{
    86d0:	e92d4800 	push	{fp, lr}
    86d4:	e28db004 	add	fp, sp, #4
    86d8:	e24dd020 	sub	sp, sp, #32
    86dc:	e50b0018 	str	r0, [fp, #-24]	; 0xffffffe8
    86e0:	e50b101c 	str	r1, [fp, #-28]	; 0xffffffe4
    86e4:	e50b2020 	str	r2, [fp, #-32]	; 0xffffffe0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:10
	int i = 0;
    86e8:	e3a03000 	mov	r3, #0
    86ec:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:12

	while (input > 0)
    86f0:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    86f4:	e3530000 	cmp	r3, #0
    86f8:	0a000014 	beq	8750 <_Z4itoajPcj+0x80>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:14
	{
		output[i] = CharConvArr[input % base];
    86fc:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8700:	e51b1020 	ldr	r1, [fp, #-32]	; 0xffffffe0
    8704:	e1a00003 	mov	r0, r3
    8708:	eb000199 	bl	8d74 <__aeabi_uidivmod>
    870c:	e1a03001 	mov	r3, r1
    8710:	e1a01003 	mov	r1, r3
    8714:	e51b3008 	ldr	r3, [fp, #-8]
    8718:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    871c:	e0823003 	add	r3, r2, r3
    8720:	e59f2118 	ldr	r2, [pc, #280]	; 8840 <_Z4itoajPcj+0x170>
    8724:	e7d22001 	ldrb	r2, [r2, r1]
    8728:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:15
		input /= base;
    872c:	e51b1020 	ldr	r1, [fp, #-32]	; 0xffffffe0
    8730:	e51b0018 	ldr	r0, [fp, #-24]	; 0xffffffe8
    8734:	eb000113 	bl	8b88 <__udivsi3>
    8738:	e1a03000 	mov	r3, r0
    873c:	e50b3018 	str	r3, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:16
		i++;
    8740:	e51b3008 	ldr	r3, [fp, #-8]
    8744:	e2833001 	add	r3, r3, #1
    8748:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:12
	while (input > 0)
    874c:	eaffffe7 	b	86f0 <_Z4itoajPcj+0x20>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:19
	}

    if (i == 0)
    8750:	e51b3008 	ldr	r3, [fp, #-8]
    8754:	e3530000 	cmp	r3, #0
    8758:	1a000007 	bne	877c <_Z4itoajPcj+0xac>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:21
    {
        output[i] = CharConvArr[0];
    875c:	e51b3008 	ldr	r3, [fp, #-8]
    8760:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    8764:	e0823003 	add	r3, r2, r3
    8768:	e3a02030 	mov	r2, #48	; 0x30
    876c:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:22
        i++;
    8770:	e51b3008 	ldr	r3, [fp, #-8]
    8774:	e2833001 	add	r3, r3, #1
    8778:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:25
    }

	output[i] = '\0';
    877c:	e51b3008 	ldr	r3, [fp, #-8]
    8780:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    8784:	e0823003 	add	r3, r2, r3
    8788:	e3a02000 	mov	r2, #0
    878c:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:26
	i--;
    8790:	e51b3008 	ldr	r3, [fp, #-8]
    8794:	e2433001 	sub	r3, r3, #1
    8798:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:28

	for (int j = 0; j <= i/2; j++)
    879c:	e3a03000 	mov	r3, #0
    87a0:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:28 (discriminator 3)
    87a4:	e51b3008 	ldr	r3, [fp, #-8]
    87a8:	e1a02fa3 	lsr	r2, r3, #31
    87ac:	e0823003 	add	r3, r2, r3
    87b0:	e1a030c3 	asr	r3, r3, #1
    87b4:	e1a02003 	mov	r2, r3
    87b8:	e51b300c 	ldr	r3, [fp, #-12]
    87bc:	e1530002 	cmp	r3, r2
    87c0:	ca00001b 	bgt	8834 <_Z4itoajPcj+0x164>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:30 (discriminator 2)
	{
		char c = output[i - j];
    87c4:	e51b2008 	ldr	r2, [fp, #-8]
    87c8:	e51b300c 	ldr	r3, [fp, #-12]
    87cc:	e0423003 	sub	r3, r2, r3
    87d0:	e1a02003 	mov	r2, r3
    87d4:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    87d8:	e0833002 	add	r3, r3, r2
    87dc:	e5d33000 	ldrb	r3, [r3]
    87e0:	e54b300d 	strb	r3, [fp, #-13]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:31 (discriminator 2)
		output[i - j] = output[j];
    87e4:	e51b300c 	ldr	r3, [fp, #-12]
    87e8:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    87ec:	e0822003 	add	r2, r2, r3
    87f0:	e51b1008 	ldr	r1, [fp, #-8]
    87f4:	e51b300c 	ldr	r3, [fp, #-12]
    87f8:	e0413003 	sub	r3, r1, r3
    87fc:	e1a01003 	mov	r1, r3
    8800:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    8804:	e0833001 	add	r3, r3, r1
    8808:	e5d22000 	ldrb	r2, [r2]
    880c:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:32 (discriminator 2)
		output[j] = c;
    8810:	e51b300c 	ldr	r3, [fp, #-12]
    8814:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    8818:	e0823003 	add	r3, r2, r3
    881c:	e55b200d 	ldrb	r2, [fp, #-13]
    8820:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:28 (discriminator 2)
	for (int j = 0; j <= i/2; j++)
    8824:	e51b300c 	ldr	r3, [fp, #-12]
    8828:	e2833001 	add	r3, r3, #1
    882c:	e50b300c 	str	r3, [fp, #-12]
    8830:	eaffffdb 	b	87a4 <_Z4itoajPcj+0xd4>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:34
	}
}
    8834:	e320f000 	nop	{0}
    8838:	e24bd004 	sub	sp, fp, #4
    883c:	e8bd8800 	pop	{fp, pc}
    8840:	00008dfc 	strdeq	r8, [r0], -ip

00008844 <_Z4atoiPKc>:
_Z4atoiPKc():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:37

int atoi(const char* input)
{
    8844:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8848:	e28db000 	add	fp, sp, #0
    884c:	e24dd014 	sub	sp, sp, #20
    8850:	e50b0010 	str	r0, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:38
	int output = 0;
    8854:	e3a03000 	mov	r3, #0
    8858:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:40

	while (*input != '\0')
    885c:	e51b3010 	ldr	r3, [fp, #-16]
    8860:	e5d33000 	ldrb	r3, [r3]
    8864:	e3530000 	cmp	r3, #0
    8868:	0a000017 	beq	88cc <_Z4atoiPKc+0x88>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:42
	{
		output *= 10;
    886c:	e51b2008 	ldr	r2, [fp, #-8]
    8870:	e1a03002 	mov	r3, r2
    8874:	e1a03103 	lsl	r3, r3, #2
    8878:	e0833002 	add	r3, r3, r2
    887c:	e1a03083 	lsl	r3, r3, #1
    8880:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:43
		if (*input > '9' || *input < '0')
    8884:	e51b3010 	ldr	r3, [fp, #-16]
    8888:	e5d33000 	ldrb	r3, [r3]
    888c:	e3530039 	cmp	r3, #57	; 0x39
    8890:	8a00000d 	bhi	88cc <_Z4atoiPKc+0x88>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:43 (discriminator 1)
    8894:	e51b3010 	ldr	r3, [fp, #-16]
    8898:	e5d33000 	ldrb	r3, [r3]
    889c:	e353002f 	cmp	r3, #47	; 0x2f
    88a0:	9a000009 	bls	88cc <_Z4atoiPKc+0x88>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:46
			break;

		output += *input - '0';
    88a4:	e51b3010 	ldr	r3, [fp, #-16]
    88a8:	e5d33000 	ldrb	r3, [r3]
    88ac:	e2433030 	sub	r3, r3, #48	; 0x30
    88b0:	e51b2008 	ldr	r2, [fp, #-8]
    88b4:	e0823003 	add	r3, r2, r3
    88b8:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:48

		input++;
    88bc:	e51b3010 	ldr	r3, [fp, #-16]
    88c0:	e2833001 	add	r3, r3, #1
    88c4:	e50b3010 	str	r3, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:40
	while (*input != '\0')
    88c8:	eaffffe3 	b	885c <_Z4atoiPKc+0x18>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:51
	}

	return output;
    88cc:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:52
}
    88d0:	e1a00003 	mov	r0, r3
    88d4:	e28bd000 	add	sp, fp, #0
    88d8:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    88dc:	e12fff1e 	bx	lr

000088e0 <_Z7strncpyPcPKci>:
_Z7strncpyPcPKci():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:55

char* strncpy(char* dest, const char *src, int num)
{
    88e0:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    88e4:	e28db000 	add	fp, sp, #0
    88e8:	e24dd01c 	sub	sp, sp, #28
    88ec:	e50b0010 	str	r0, [fp, #-16]
    88f0:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    88f4:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:58
	int i;

	for (i = 0; i < num && src[i] != '\0'; i++)
    88f8:	e3a03000 	mov	r3, #0
    88fc:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:58 (discriminator 4)
    8900:	e51b2008 	ldr	r2, [fp, #-8]
    8904:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8908:	e1520003 	cmp	r2, r3
    890c:	aa000011 	bge	8958 <_Z7strncpyPcPKci+0x78>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:58 (discriminator 2)
    8910:	e51b3008 	ldr	r3, [fp, #-8]
    8914:	e51b2014 	ldr	r2, [fp, #-20]	; 0xffffffec
    8918:	e0823003 	add	r3, r2, r3
    891c:	e5d33000 	ldrb	r3, [r3]
    8920:	e3530000 	cmp	r3, #0
    8924:	0a00000b 	beq	8958 <_Z7strncpyPcPKci+0x78>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:59 (discriminator 3)
		dest[i] = src[i];
    8928:	e51b3008 	ldr	r3, [fp, #-8]
    892c:	e51b2014 	ldr	r2, [fp, #-20]	; 0xffffffec
    8930:	e0822003 	add	r2, r2, r3
    8934:	e51b3008 	ldr	r3, [fp, #-8]
    8938:	e51b1010 	ldr	r1, [fp, #-16]
    893c:	e0813003 	add	r3, r1, r3
    8940:	e5d22000 	ldrb	r2, [r2]
    8944:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:58 (discriminator 3)
	for (i = 0; i < num && src[i] != '\0'; i++)
    8948:	e51b3008 	ldr	r3, [fp, #-8]
    894c:	e2833001 	add	r3, r3, #1
    8950:	e50b3008 	str	r3, [fp, #-8]
    8954:	eaffffe9 	b	8900 <_Z7strncpyPcPKci+0x20>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:60 (discriminator 2)
	for (; i < num; i++)
    8958:	e51b2008 	ldr	r2, [fp, #-8]
    895c:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8960:	e1520003 	cmp	r2, r3
    8964:	aa000008 	bge	898c <_Z7strncpyPcPKci+0xac>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:61 (discriminator 1)
		dest[i] = '\0';
    8968:	e51b3008 	ldr	r3, [fp, #-8]
    896c:	e51b2010 	ldr	r2, [fp, #-16]
    8970:	e0823003 	add	r3, r2, r3
    8974:	e3a02000 	mov	r2, #0
    8978:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:60 (discriminator 1)
	for (; i < num; i++)
    897c:	e51b3008 	ldr	r3, [fp, #-8]
    8980:	e2833001 	add	r3, r3, #1
    8984:	e50b3008 	str	r3, [fp, #-8]
    8988:	eafffff2 	b	8958 <_Z7strncpyPcPKci+0x78>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:63

   return dest;
    898c:	e51b3010 	ldr	r3, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:64
}
    8990:	e1a00003 	mov	r0, r3
    8994:	e28bd000 	add	sp, fp, #0
    8998:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    899c:	e12fff1e 	bx	lr

000089a0 <_Z7strncmpPKcS0_i>:
_Z7strncmpPKcS0_i():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:67

int strncmp(const char *s1, const char *s2, int num)
{
    89a0:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    89a4:	e28db000 	add	fp, sp, #0
    89a8:	e24dd01c 	sub	sp, sp, #28
    89ac:	e50b0010 	str	r0, [fp, #-16]
    89b0:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    89b4:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:69
	unsigned char u1, u2;
  	while (num-- > 0)
    89b8:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    89bc:	e2432001 	sub	r2, r3, #1
    89c0:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
    89c4:	e3530000 	cmp	r3, #0
    89c8:	c3a03001 	movgt	r3, #1
    89cc:	d3a03000 	movle	r3, #0
    89d0:	e6ef3073 	uxtb	r3, r3
    89d4:	e3530000 	cmp	r3, #0
    89d8:	0a000016 	beq	8a38 <_Z7strncmpPKcS0_i+0x98>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:71
    {
      	u1 = (unsigned char) *s1++;
    89dc:	e51b3010 	ldr	r3, [fp, #-16]
    89e0:	e2832001 	add	r2, r3, #1
    89e4:	e50b2010 	str	r2, [fp, #-16]
    89e8:	e5d33000 	ldrb	r3, [r3]
    89ec:	e54b3005 	strb	r3, [fp, #-5]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:72
     	u2 = (unsigned char) *s2++;
    89f0:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    89f4:	e2832001 	add	r2, r3, #1
    89f8:	e50b2014 	str	r2, [fp, #-20]	; 0xffffffec
    89fc:	e5d33000 	ldrb	r3, [r3]
    8a00:	e54b3006 	strb	r3, [fp, #-6]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:73
      	if (u1 != u2)
    8a04:	e55b2005 	ldrb	r2, [fp, #-5]
    8a08:	e55b3006 	ldrb	r3, [fp, #-6]
    8a0c:	e1520003 	cmp	r2, r3
    8a10:	0a000003 	beq	8a24 <_Z7strncmpPKcS0_i+0x84>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:74
        	return u1 - u2;
    8a14:	e55b2005 	ldrb	r2, [fp, #-5]
    8a18:	e55b3006 	ldrb	r3, [fp, #-6]
    8a1c:	e0423003 	sub	r3, r2, r3
    8a20:	ea000005 	b	8a3c <_Z7strncmpPKcS0_i+0x9c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:75
      	if (u1 == '\0')
    8a24:	e55b3005 	ldrb	r3, [fp, #-5]
    8a28:	e3530000 	cmp	r3, #0
    8a2c:	1affffe1 	bne	89b8 <_Z7strncmpPKcS0_i+0x18>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:76
        	return 0;
    8a30:	e3a03000 	mov	r3, #0
    8a34:	ea000000 	b	8a3c <_Z7strncmpPKcS0_i+0x9c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:79
    }

  	return 0;
    8a38:	e3a03000 	mov	r3, #0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:80
}
    8a3c:	e1a00003 	mov	r0, r3
    8a40:	e28bd000 	add	sp, fp, #0
    8a44:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8a48:	e12fff1e 	bx	lr

00008a4c <_Z6strlenPKc>:
_Z6strlenPKc():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:83

int strlen(const char* s)
{
    8a4c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8a50:	e28db000 	add	fp, sp, #0
    8a54:	e24dd014 	sub	sp, sp, #20
    8a58:	e50b0010 	str	r0, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:84
	int i = 0;
    8a5c:	e3a03000 	mov	r3, #0
    8a60:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:86

	while (s[i] != '\0')
    8a64:	e51b3008 	ldr	r3, [fp, #-8]
    8a68:	e51b2010 	ldr	r2, [fp, #-16]
    8a6c:	e0823003 	add	r3, r2, r3
    8a70:	e5d33000 	ldrb	r3, [r3]
    8a74:	e3530000 	cmp	r3, #0
    8a78:	0a000003 	beq	8a8c <_Z6strlenPKc+0x40>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:87
		i++;
    8a7c:	e51b3008 	ldr	r3, [fp, #-8]
    8a80:	e2833001 	add	r3, r3, #1
    8a84:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:86
	while (s[i] != '\0')
    8a88:	eafffff5 	b	8a64 <_Z6strlenPKc+0x18>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:89

	return i;
    8a8c:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:90
}
    8a90:	e1a00003 	mov	r0, r3
    8a94:	e28bd000 	add	sp, fp, #0
    8a98:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8a9c:	e12fff1e 	bx	lr

00008aa0 <_Z5bzeroPvi>:
_Z5bzeroPvi():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:93

void bzero(void* memory, int length)
{
    8aa0:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8aa4:	e28db000 	add	fp, sp, #0
    8aa8:	e24dd014 	sub	sp, sp, #20
    8aac:	e50b0010 	str	r0, [fp, #-16]
    8ab0:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:94
	char* mem = reinterpret_cast<char*>(memory);
    8ab4:	e51b3010 	ldr	r3, [fp, #-16]
    8ab8:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:96

	for (int i = 0; i < length; i++)
    8abc:	e3a03000 	mov	r3, #0
    8ac0:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:96 (discriminator 3)
    8ac4:	e51b2008 	ldr	r2, [fp, #-8]
    8ac8:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8acc:	e1520003 	cmp	r2, r3
    8ad0:	aa000008 	bge	8af8 <_Z5bzeroPvi+0x58>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:97 (discriminator 2)
		mem[i] = 0;
    8ad4:	e51b3008 	ldr	r3, [fp, #-8]
    8ad8:	e51b200c 	ldr	r2, [fp, #-12]
    8adc:	e0823003 	add	r3, r2, r3
    8ae0:	e3a02000 	mov	r2, #0
    8ae4:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:96 (discriminator 2)
	for (int i = 0; i < length; i++)
    8ae8:	e51b3008 	ldr	r3, [fp, #-8]
    8aec:	e2833001 	add	r3, r3, #1
    8af0:	e50b3008 	str	r3, [fp, #-8]
    8af4:	eafffff2 	b	8ac4 <_Z5bzeroPvi+0x24>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:98
}
    8af8:	e320f000 	nop	{0}
    8afc:	e28bd000 	add	sp, fp, #0
    8b00:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8b04:	e12fff1e 	bx	lr

00008b08 <_Z6memcpyPKvPvi>:
_Z6memcpyPKvPvi():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:101

void memcpy(const void* src, void* dst, int num)
{
    8b08:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8b0c:	e28db000 	add	fp, sp, #0
    8b10:	e24dd024 	sub	sp, sp, #36	; 0x24
    8b14:	e50b0018 	str	r0, [fp, #-24]	; 0xffffffe8
    8b18:	e50b101c 	str	r1, [fp, #-28]	; 0xffffffe4
    8b1c:	e50b2020 	str	r2, [fp, #-32]	; 0xffffffe0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:102
	const char* memsrc = reinterpret_cast<const char*>(src);
    8b20:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8b24:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:103
	char* memdst = reinterpret_cast<char*>(dst);
    8b28:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    8b2c:	e50b3010 	str	r3, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:105

	for (int i = 0; i < num; i++)
    8b30:	e3a03000 	mov	r3, #0
    8b34:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:105 (discriminator 3)
    8b38:	e51b2008 	ldr	r2, [fp, #-8]
    8b3c:	e51b3020 	ldr	r3, [fp, #-32]	; 0xffffffe0
    8b40:	e1520003 	cmp	r2, r3
    8b44:	aa00000b 	bge	8b78 <_Z6memcpyPKvPvi+0x70>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:106 (discriminator 2)
		memdst[i] = memsrc[i];
    8b48:	e51b3008 	ldr	r3, [fp, #-8]
    8b4c:	e51b200c 	ldr	r2, [fp, #-12]
    8b50:	e0822003 	add	r2, r2, r3
    8b54:	e51b3008 	ldr	r3, [fp, #-8]
    8b58:	e51b1010 	ldr	r1, [fp, #-16]
    8b5c:	e0813003 	add	r3, r1, r3
    8b60:	e5d22000 	ldrb	r2, [r2]
    8b64:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:105 (discriminator 2)
	for (int i = 0; i < num; i++)
    8b68:	e51b3008 	ldr	r3, [fp, #-8]
    8b6c:	e2833001 	add	r3, r3, #1
    8b70:	e50b3008 	str	r3, [fp, #-8]
    8b74:	eaffffef 	b	8b38 <_Z6memcpyPKvPvi+0x30>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:107
}
    8b78:	e320f000 	nop	{0}
    8b7c:	e28bd000 	add	sp, fp, #0
    8b80:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8b84:	e12fff1e 	bx	lr

00008b88 <__udivsi3>:
__udivsi3():
    8b88:	e2512001 	subs	r2, r1, #1
    8b8c:	012fff1e 	bxeq	lr
    8b90:	3a000074 	bcc	8d68 <__udivsi3+0x1e0>
    8b94:	e1500001 	cmp	r0, r1
    8b98:	9a00006b 	bls	8d4c <__udivsi3+0x1c4>
    8b9c:	e1110002 	tst	r1, r2
    8ba0:	0a00006c 	beq	8d58 <__udivsi3+0x1d0>
    8ba4:	e16f3f10 	clz	r3, r0
    8ba8:	e16f2f11 	clz	r2, r1
    8bac:	e0423003 	sub	r3, r2, r3
    8bb0:	e273301f 	rsbs	r3, r3, #31
    8bb4:	10833083 	addne	r3, r3, r3, lsl #1
    8bb8:	e3a02000 	mov	r2, #0
    8bbc:	108ff103 	addne	pc, pc, r3, lsl #2
    8bc0:	e1a00000 	nop			; (mov r0, r0)
    8bc4:	e1500f81 	cmp	r0, r1, lsl #31
    8bc8:	e0a22002 	adc	r2, r2, r2
    8bcc:	20400f81 	subcs	r0, r0, r1, lsl #31
    8bd0:	e1500f01 	cmp	r0, r1, lsl #30
    8bd4:	e0a22002 	adc	r2, r2, r2
    8bd8:	20400f01 	subcs	r0, r0, r1, lsl #30
    8bdc:	e1500e81 	cmp	r0, r1, lsl #29
    8be0:	e0a22002 	adc	r2, r2, r2
    8be4:	20400e81 	subcs	r0, r0, r1, lsl #29
    8be8:	e1500e01 	cmp	r0, r1, lsl #28
    8bec:	e0a22002 	adc	r2, r2, r2
    8bf0:	20400e01 	subcs	r0, r0, r1, lsl #28
    8bf4:	e1500d81 	cmp	r0, r1, lsl #27
    8bf8:	e0a22002 	adc	r2, r2, r2
    8bfc:	20400d81 	subcs	r0, r0, r1, lsl #27
    8c00:	e1500d01 	cmp	r0, r1, lsl #26
    8c04:	e0a22002 	adc	r2, r2, r2
    8c08:	20400d01 	subcs	r0, r0, r1, lsl #26
    8c0c:	e1500c81 	cmp	r0, r1, lsl #25
    8c10:	e0a22002 	adc	r2, r2, r2
    8c14:	20400c81 	subcs	r0, r0, r1, lsl #25
    8c18:	e1500c01 	cmp	r0, r1, lsl #24
    8c1c:	e0a22002 	adc	r2, r2, r2
    8c20:	20400c01 	subcs	r0, r0, r1, lsl #24
    8c24:	e1500b81 	cmp	r0, r1, lsl #23
    8c28:	e0a22002 	adc	r2, r2, r2
    8c2c:	20400b81 	subcs	r0, r0, r1, lsl #23
    8c30:	e1500b01 	cmp	r0, r1, lsl #22
    8c34:	e0a22002 	adc	r2, r2, r2
    8c38:	20400b01 	subcs	r0, r0, r1, lsl #22
    8c3c:	e1500a81 	cmp	r0, r1, lsl #21
    8c40:	e0a22002 	adc	r2, r2, r2
    8c44:	20400a81 	subcs	r0, r0, r1, lsl #21
    8c48:	e1500a01 	cmp	r0, r1, lsl #20
    8c4c:	e0a22002 	adc	r2, r2, r2
    8c50:	20400a01 	subcs	r0, r0, r1, lsl #20
    8c54:	e1500981 	cmp	r0, r1, lsl #19
    8c58:	e0a22002 	adc	r2, r2, r2
    8c5c:	20400981 	subcs	r0, r0, r1, lsl #19
    8c60:	e1500901 	cmp	r0, r1, lsl #18
    8c64:	e0a22002 	adc	r2, r2, r2
    8c68:	20400901 	subcs	r0, r0, r1, lsl #18
    8c6c:	e1500881 	cmp	r0, r1, lsl #17
    8c70:	e0a22002 	adc	r2, r2, r2
    8c74:	20400881 	subcs	r0, r0, r1, lsl #17
    8c78:	e1500801 	cmp	r0, r1, lsl #16
    8c7c:	e0a22002 	adc	r2, r2, r2
    8c80:	20400801 	subcs	r0, r0, r1, lsl #16
    8c84:	e1500781 	cmp	r0, r1, lsl #15
    8c88:	e0a22002 	adc	r2, r2, r2
    8c8c:	20400781 	subcs	r0, r0, r1, lsl #15
    8c90:	e1500701 	cmp	r0, r1, lsl #14
    8c94:	e0a22002 	adc	r2, r2, r2
    8c98:	20400701 	subcs	r0, r0, r1, lsl #14
    8c9c:	e1500681 	cmp	r0, r1, lsl #13
    8ca0:	e0a22002 	adc	r2, r2, r2
    8ca4:	20400681 	subcs	r0, r0, r1, lsl #13
    8ca8:	e1500601 	cmp	r0, r1, lsl #12
    8cac:	e0a22002 	adc	r2, r2, r2
    8cb0:	20400601 	subcs	r0, r0, r1, lsl #12
    8cb4:	e1500581 	cmp	r0, r1, lsl #11
    8cb8:	e0a22002 	adc	r2, r2, r2
    8cbc:	20400581 	subcs	r0, r0, r1, lsl #11
    8cc0:	e1500501 	cmp	r0, r1, lsl #10
    8cc4:	e0a22002 	adc	r2, r2, r2
    8cc8:	20400501 	subcs	r0, r0, r1, lsl #10
    8ccc:	e1500481 	cmp	r0, r1, lsl #9
    8cd0:	e0a22002 	adc	r2, r2, r2
    8cd4:	20400481 	subcs	r0, r0, r1, lsl #9
    8cd8:	e1500401 	cmp	r0, r1, lsl #8
    8cdc:	e0a22002 	adc	r2, r2, r2
    8ce0:	20400401 	subcs	r0, r0, r1, lsl #8
    8ce4:	e1500381 	cmp	r0, r1, lsl #7
    8ce8:	e0a22002 	adc	r2, r2, r2
    8cec:	20400381 	subcs	r0, r0, r1, lsl #7
    8cf0:	e1500301 	cmp	r0, r1, lsl #6
    8cf4:	e0a22002 	adc	r2, r2, r2
    8cf8:	20400301 	subcs	r0, r0, r1, lsl #6
    8cfc:	e1500281 	cmp	r0, r1, lsl #5
    8d00:	e0a22002 	adc	r2, r2, r2
    8d04:	20400281 	subcs	r0, r0, r1, lsl #5
    8d08:	e1500201 	cmp	r0, r1, lsl #4
    8d0c:	e0a22002 	adc	r2, r2, r2
    8d10:	20400201 	subcs	r0, r0, r1, lsl #4
    8d14:	e1500181 	cmp	r0, r1, lsl #3
    8d18:	e0a22002 	adc	r2, r2, r2
    8d1c:	20400181 	subcs	r0, r0, r1, lsl #3
    8d20:	e1500101 	cmp	r0, r1, lsl #2
    8d24:	e0a22002 	adc	r2, r2, r2
    8d28:	20400101 	subcs	r0, r0, r1, lsl #2
    8d2c:	e1500081 	cmp	r0, r1, lsl #1
    8d30:	e0a22002 	adc	r2, r2, r2
    8d34:	20400081 	subcs	r0, r0, r1, lsl #1
    8d38:	e1500001 	cmp	r0, r1
    8d3c:	e0a22002 	adc	r2, r2, r2
    8d40:	20400001 	subcs	r0, r0, r1
    8d44:	e1a00002 	mov	r0, r2
    8d48:	e12fff1e 	bx	lr
    8d4c:	03a00001 	moveq	r0, #1
    8d50:	13a00000 	movne	r0, #0
    8d54:	e12fff1e 	bx	lr
    8d58:	e16f2f11 	clz	r2, r1
    8d5c:	e262201f 	rsb	r2, r2, #31
    8d60:	e1a00230 	lsr	r0, r0, r2
    8d64:	e12fff1e 	bx	lr
    8d68:	e3500000 	cmp	r0, #0
    8d6c:	13e00000 	mvnne	r0, #0
    8d70:	ea000007 	b	8d94 <__aeabi_idiv0>

00008d74 <__aeabi_uidivmod>:
__aeabi_uidivmod():
    8d74:	e3510000 	cmp	r1, #0
    8d78:	0afffffa 	beq	8d68 <__udivsi3+0x1e0>
    8d7c:	e92d4003 	push	{r0, r1, lr}
    8d80:	ebffff80 	bl	8b88 <__udivsi3>
    8d84:	e8bd4006 	pop	{r1, r2, lr}
    8d88:	e0030092 	mul	r3, r2, r0
    8d8c:	e0411003 	sub	r1, r1, r3
    8d90:	e12fff1e 	bx	lr

00008d94 <__aeabi_idiv0>:
__aeabi_ldiv0():
    8d94:	e12fff1e 	bx	lr

Disassembly of section .rodata:

00008d98 <_ZL13Lock_Unlocked>:
    8d98:	00000000 	andeq	r0, r0, r0

00008d9c <_ZL11Lock_Locked>:
    8d9c:	00000001 	andeq	r0, r0, r1

00008da0 <_ZL21MaxFSDriverNameLength>:
    8da0:	00000010 	andeq	r0, r0, r0, lsl r0

00008da4 <_ZL17MaxFilenameLength>:
    8da4:	00000010 	andeq	r0, r0, r0, lsl r0

00008da8 <_ZL13MaxPathLength>:
    8da8:	00000080 	andeq	r0, r0, r0, lsl #1

00008dac <_ZL18NoFilesystemDriver>:
    8dac:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008db0 <_ZL9NotifyAll>:
    8db0:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008db4 <_ZL24Max_Process_Opened_Files>:
    8db4:	00000010 	andeq	r0, r0, r0, lsl r0

00008db8 <_ZL10Indefinite>:
    8db8:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008dbc <_ZL18Deadline_Unchanged>:
    8dbc:	fffffffe 			; <UNDEFINED> instruction: 0xfffffffe

00008dc0 <_ZL14Invalid_Handle>:
    8dc0:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008dc4 <_ZL13Lock_Unlocked>:
    8dc4:	00000000 	andeq	r0, r0, r0

00008dc8 <_ZL11Lock_Locked>:
    8dc8:	00000001 	andeq	r0, r0, r1

00008dcc <_ZL21MaxFSDriverNameLength>:
    8dcc:	00000010 	andeq	r0, r0, r0, lsl r0

00008dd0 <_ZL17MaxFilenameLength>:
    8dd0:	00000010 	andeq	r0, r0, r0, lsl r0

00008dd4 <_ZL13MaxPathLength>:
    8dd4:	00000080 	andeq	r0, r0, r0, lsl #1

00008dd8 <_ZL18NoFilesystemDriver>:
    8dd8:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008ddc <_ZL9NotifyAll>:
    8ddc:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008de0 <_ZL24Max_Process_Opened_Files>:
    8de0:	00000010 	andeq	r0, r0, r0, lsl r0

00008de4 <_ZL10Indefinite>:
    8de4:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008de8 <_ZL18Deadline_Unchanged>:
    8de8:	fffffffe 			; <UNDEFINED> instruction: 0xfffffffe

00008dec <_ZL14Invalid_Handle>:
    8dec:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008df0 <_ZL16Pipe_File_Prefix>:
    8df0:	3a535953 	bcc	14df344 <__bss_end+0x14d6524>
    8df4:	65706970 	ldrbvs	r6, [r0, #-2416]!	; 0xfffff690
    8df8:	0000002f 	andeq	r0, r0, pc, lsr #32

00008dfc <_ZN12_GLOBAL__N_1L11CharConvArrE>:
    8dfc:	33323130 	teqcc	r2, #48, 2
    8e00:	37363534 			; <UNDEFINED> instruction: 0x37363534
    8e04:	42413938 	submi	r3, r1, #56, 18	; 0xe0000
    8e08:	46454443 	strbmi	r4, [r5], -r3, asr #8
	...

Disassembly of section .bss:

00008e10 <__bss_start>:
	...

Disassembly of section .ARM.attributes:

00000000 <.ARM.attributes>:
   0:	00002e41 	andeq	r2, r0, r1, asr #28
   4:	61656100 	cmnvs	r5, r0, lsl #2
   8:	01006962 	tsteq	r0, r2, ror #18
   c:	00000024 	andeq	r0, r0, r4, lsr #32
  10:	4b5a3605 	blmi	168d82c <__bss_end+0x1684a0c>
  14:	08070600 	stmdaeq	r7, {r9, sl}
  18:	0a010901 	beq	42424 <__bss_end+0x39604>
  1c:	14041202 	strne	r1, [r4], #-514	; 0xfffffdfe
  20:	17011501 	strne	r1, [r1, -r1, lsl #10]
  24:	1a011803 	bne	46038 <__bss_end+0x3d218>
  28:	22011c01 	andcs	r1, r1, #256	; 0x100
  2c:	Address 0x000000000000002c is out of bounds.


Disassembly of section .comment:

00000000 <.comment>:
   0:	3a434347 	bcc	10d0d24 <__bss_end+0x10c7f04>
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
  38:	7a617661 	bvc	185d9c4 <__bss_end+0x1854ba4>
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
  c0:	6a757a61 	bvs	1d5ea4c <__bss_end+0x1d55c2c>
  c4:	2f696369 	svccs	0x00696369
  c8:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
  cc:	73656d65 	cmnvc	r5, #6464	; 0x1940
  d0:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
  d4:	6b2d616b 	blvs	b58688 <__bss_end+0xb4f868>
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
 144:	fb010200 	blx	4094e <__bss_end+0x37b2e>
 148:	01000d0e 	tsteq	r0, lr, lsl #26
 14c:	00010101 	andeq	r0, r1, r1, lsl #2
 150:	00010000 	andeq	r0, r1, r0
 154:	552f0100 	strpl	r0, [pc, #-256]!	; 5c <shift+0x5c>
 158:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 15c:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 160:	6a726574 	bvs	1c99738 <__bss_end+0x1c90918>
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
 198:	752f7365 	strvc	r7, [pc, #-869]!	; fffffe3b <__bss_end+0xffff701b>
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
 1d0:	0a05830b 	beq	160e04 <__bss_end+0x157fe4>
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
 1fc:	4a030402 	bmi	c120c <__bss_end+0xb83ec>
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
 230:	4a020402 	bmi	81240 <__bss_end+0x78420>
 234:	02000205 	andeq	r0, r0, #1342177280	; 0x50000000
 238:	052d0204 	streq	r0, [sp, #-516]!	; 0xfffffdfc
 23c:	01058509 	tsteq	r5, r9, lsl #10
 240:	000a022f 	andeq	r0, sl, pc, lsr #4
 244:	022b0101 	eoreq	r0, fp, #1073741824	; 0x40000000
 248:	00030000 	andeq	r0, r3, r0
 24c:	00000201 	andeq	r0, r0, r1, lsl #4
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
 280:	6a757a61 	bvs	1d5ec0c <__bss_end+0x1d55dec>
 284:	2f696369 	svccs	0x00696369
 288:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
 28c:	73656d65 	cmnvc	r5, #6464	; 0x1940
 290:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
 294:	6b2d616b 	blvs	b58848 <__bss_end+0xb4fa28>
 298:	6f2d7669 	svcvs	0x002d7669
 29c:	6f732f73 	svcvs	0x00732f73
 2a0:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
 2a4:	73752f73 	cmnvc	r5, #460	; 0x1cc
 2a8:	70737265 	rsbsvc	r7, r3, r5, ror #4
 2ac:	2f656361 	svccs	0x00656361
 2b0:	74696e69 	strbtvc	r6, [r9], #-3689	; 0xfffff197
 2b4:	7361745f 	cmnvc	r1, #1593835520	; 0x5f000000
 2b8:	552f006b 	strpl	r0, [pc, #-107]!	; 255 <shift+0x255>
 2bc:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 2c0:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 2c4:	6a726574 	bvs	1c9989c <__bss_end+0x1c90a7c>
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
 2fc:	752f7365 	strvc	r7, [pc, #-869]!	; ffffff9f <__bss_end+0xffff717f>
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
 340:	7a617661 	bvc	185dccc <__bss_end+0x1854eac>
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
 3a4:	7a617661 	bvc	185dd30 <__bss_end+0x1854f10>
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
 3f4:	00006c61 	andeq	r6, r0, r1, ror #24
 3f8:	6e69616d 	powvsez	f6, f1, #5.0
 3fc:	7070632e 	rsbsvc	r6, r0, lr, lsr #6
 400:	00000100 	andeq	r0, r0, r0, lsl #2
 404:	6e697073 	mcrvs	0, 3, r7, cr9, cr3, {3}
 408:	6b636f6c 	blvs	18dc1c0 <__bss_end+0x18d33a0>
 40c:	0200682e 	andeq	r6, r0, #3014656	; 0x2e0000
 410:	69660000 	stmdbvs	r6!, {}^	; <UNPREDICTABLE>
 414:	7973656c 	ldmdbvc	r3!, {r2, r3, r5, r6, r8, sl, sp, lr}^
 418:	6d657473 	cfstrdvs	mvd7, [r5, #-460]!	; 0xfffffe34
 41c:	0300682e 	movweq	r6, #2094	; 0x82e
 420:	72700000 	rsbsvc	r0, r0, #0
 424:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
 428:	00682e73 	rsbeq	r2, r8, r3, ror lr
 42c:	70000002 	andvc	r0, r0, r2
 430:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
 434:	6d5f7373 	ldclvs	3, cr7, [pc, #-460]	; 270 <shift+0x270>
 438:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
 43c:	682e7265 	stmdavs	lr!, {r0, r2, r5, r6, r9, ip, sp, lr}
 440:	00000200 	andeq	r0, r0, r0, lsl #4
 444:	64746e69 	ldrbtvs	r6, [r4], #-3689	; 0xfffff197
 448:	682e6665 	stmdavs	lr!, {r0, r2, r5, r6, r9, sl, sp, lr}
 44c:	00000400 	andeq	r0, r0, r0, lsl #8
 450:	00010500 	andeq	r0, r1, r0, lsl #10
 454:	822c0205 	eorhi	r0, ip, #1342177280	; 0x50000000
 458:	05170000 	ldreq	r0, [r7, #-0]
 45c:	1f05a313 	svcne	0x0005a313
 460:	4a220551 	bmi	8819ac <__bss_end+0x878b8c>
 464:	05820305 	streq	r0, [r2, #773]	; 0x305
 468:	0e054b04 	vmlaeq.f64	d4, d5, d4
 46c:	2a030531 	bcs	c1938 <__bss_end+0xb8b18>
 470:	01000202 	tsteq	r0, r2, lsl #4
 474:	0002c801 	andeq	ip, r2, r1, lsl #16
 478:	dd000300 	stcle	3, cr0, [r0, #-0]
 47c:	02000001 	andeq	r0, r0, #1
 480:	0d0efb01 	vstreq	d15, [lr, #-4]
 484:	01010100 	mrseq	r0, (UNDEF: 17)
 488:	00000001 	andeq	r0, r0, r1
 48c:	01000001 	tsteq	r0, r1
 490:	6573552f 	ldrbvs	r5, [r3, #-1327]!	; 0xfffffad1
 494:	772f7372 			; <UNDEFINED> instruction: 0x772f7372
 498:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
 49c:	2f696a72 	svccs	0x00696a72
 4a0:	6b736544 	blvs	1cd99b8 <__bss_end+0x1cd0b98>
 4a4:	2f706f74 	svccs	0x00706f74
 4a8:	2f564146 	svccs	0x00564146
 4ac:	6176614e 	cmnvs	r6, lr, asr #2
 4b0:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
 4b4:	4f2f6963 	svcmi	0x002f6963
 4b8:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
 4bc:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
 4c0:	6b6c6172 	blvs	1b18a90 <__bss_end+0x1b0fc70>
 4c4:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
 4c8:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
 4cc:	756f732f 	strbvc	r7, [pc, #-815]!	; 1a5 <shift+0x1a5>
 4d0:	73656372 	cmnvc	r5, #-939524095	; 0xc8000001
 4d4:	6474732f 	ldrbtvs	r7, [r4], #-815	; 0xfffffcd1
 4d8:	2f62696c 	svccs	0x0062696c
 4dc:	00637273 	rsbeq	r7, r3, r3, ror r2
 4e0:	6573552f 	ldrbvs	r5, [r3, #-1327]!	; 0xfffffad1
 4e4:	772f7372 			; <UNDEFINED> instruction: 0x772f7372
 4e8:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
 4ec:	2f696a72 	svccs	0x00696a72
 4f0:	6b736544 	blvs	1cd9a08 <__bss_end+0x1cd0be8>
 4f4:	2f706f74 	svccs	0x00706f74
 4f8:	2f564146 	svccs	0x00564146
 4fc:	6176614e 	cmnvs	r6, lr, asr #2
 500:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
 504:	4f2f6963 	svcmi	0x002f6963
 508:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
 50c:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
 510:	6b6c6172 	blvs	1b18ae0 <__bss_end+0x1b0fcc0>
 514:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
 518:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
 51c:	756f732f 	strbvc	r7, [pc, #-815]!	; 1f5 <shift+0x1f5>
 520:	73656372 	cmnvc	r5, #-939524095	; 0xc8000001
 524:	72656b2f 	rsbvc	r6, r5, #48128	; 0xbc00
 528:	2f6c656e 	svccs	0x006c656e
 52c:	6c636e69 	stclvs	14, cr6, [r3], #-420	; 0xfffffe5c
 530:	2f656475 	svccs	0x00656475
 534:	636f7270 	cmnvs	pc, #112, 4
 538:	00737365 	rsbseq	r7, r3, r5, ror #6
 53c:	6573552f 	ldrbvs	r5, [r3, #-1327]!	; 0xfffffad1
 540:	772f7372 			; <UNDEFINED> instruction: 0x772f7372
 544:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
 548:	2f696a72 	svccs	0x00696a72
 54c:	6b736544 	blvs	1cd9a64 <__bss_end+0x1cd0c44>
 550:	2f706f74 	svccs	0x00706f74
 554:	2f564146 	svccs	0x00564146
 558:	6176614e 	cmnvs	r6, lr, asr #2
 55c:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
 560:	4f2f6963 	svcmi	0x002f6963
 564:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
 568:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
 56c:	6b6c6172 	blvs	1b18b3c <__bss_end+0x1b0fd1c>
 570:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
 574:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
 578:	756f732f 	strbvc	r7, [pc, #-815]!	; 251 <shift+0x251>
 57c:	73656372 	cmnvc	r5, #-939524095	; 0xc8000001
 580:	72656b2f 	rsbvc	r6, r5, #48128	; 0xbc00
 584:	2f6c656e 	svccs	0x006c656e
 588:	6c636e69 	stclvs	14, cr6, [r3], #-420	; 0xfffffe5c
 58c:	2f656475 	svccs	0x00656475
 590:	2f007366 	svccs	0x00007366
 594:	72657355 	rsbvc	r7, r5, #1409286145	; 0x54000001
 598:	69772f73 	ldmdbvs	r7!, {r0, r1, r4, r5, r6, r8, r9, sl, fp, sp}^
 59c:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
 5a0:	442f696a 	strtmi	r6, [pc], #-2410	; 5a8 <shift+0x5a8>
 5a4:	746b7365 	strbtvc	r7, [fp], #-869	; 0xfffffc9b
 5a8:	462f706f 	strtmi	r7, [pc], -pc, rrx
 5ac:	4e2f5641 	cfmadda32mi	mvax2, mvax5, mvfx15, mvfx1
 5b0:	7a617661 	bvc	185df3c <__bss_end+0x185511c>
 5b4:	63696a75 	cmnvs	r9, #479232	; 0x75000
 5b8:	534f2f69 	movtpl	r2, #65385	; 0xff69
 5bc:	6d65732f 	stclvs	3, cr7, [r5, #-188]!	; 0xffffff44
 5c0:	72747365 	rsbsvc	r7, r4, #-1811939327	; 0x94000001
 5c4:	616b6c61 	cmnvs	fp, r1, ror #24
 5c8:	76696b2d 	strbtvc	r6, [r9], -sp, lsr #22
 5cc:	2f736f2d 	svccs	0x00736f2d
 5d0:	72756f73 	rsbsvc	r6, r5, #460	; 0x1cc
 5d4:	2f736563 	svccs	0x00736563
 5d8:	6e72656b 	cdpvs	5, 7, cr6, cr2, cr11, {3}
 5dc:	692f6c65 	stmdbvs	pc!, {r0, r2, r5, r6, sl, fp, sp, lr}	; <UNPREDICTABLE>
 5e0:	756c636e 	strbvc	r6, [ip, #-878]!	; 0xfffffc92
 5e4:	622f6564 	eorvs	r6, pc, #100, 10	; 0x19000000
 5e8:	6472616f 	ldrbtvs	r6, [r2], #-367	; 0xfffffe91
 5ec:	6970722f 	ldmdbvs	r0!, {r0, r1, r2, r3, r5, r9, ip, sp, lr}^
 5f0:	61682f30 	cmnvs	r8, r0, lsr pc
 5f4:	7300006c 	movwvc	r0, #108	; 0x6c
 5f8:	69666474 	stmdbvs	r6!, {r2, r4, r5, r6, sl, sp, lr}^
 5fc:	632e656c 			; <UNDEFINED> instruction: 0x632e656c
 600:	01007070 	tsteq	r0, r0, ror r0
 604:	77730000 	ldrbvc	r0, [r3, -r0]!
 608:	00682e69 	rsbeq	r2, r8, r9, ror #28
 60c:	73000002 	movwvc	r0, #2
 610:	6c6e6970 			; <UNDEFINED> instruction: 0x6c6e6970
 614:	2e6b636f 	cdpcs	3, 6, cr6, cr11, cr15, {3}
 618:	00020068 	andeq	r0, r2, r8, rrx
 61c:	6c696600 	stclvs	6, cr6, [r9], #-0
 620:	73797365 	cmnvc	r9, #-1811939327	; 0x94000001
 624:	2e6d6574 	mcrcs	5, 3, r6, cr13, cr4, {3}
 628:	00030068 	andeq	r0, r3, r8, rrx
 62c:	6f727000 	svcvs	0x00727000
 630:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
 634:	0200682e 	andeq	r6, r0, #3014656	; 0x2e0000
 638:	72700000 	rsbsvc	r0, r0, #0
 63c:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
 640:	616d5f73 	smcvs	54771	; 0xd5f3
 644:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
 648:	00682e72 	rsbeq	r2, r8, r2, ror lr
 64c:	69000002 	stmdbvs	r0, {r1}
 650:	6564746e 	strbvs	r7, [r4, #-1134]!	; 0xfffffb92
 654:	00682e66 	rsbeq	r2, r8, r6, ror #28
 658:	00000004 	andeq	r0, r0, r4
 65c:	05000105 	streq	r0, [r0, #-261]	; 0xfffffefb
 660:	00827402 	addeq	r7, r2, r2, lsl #8
 664:	05051600 	streq	r1, [r5, #-1536]	; 0xfffffa00
 668:	0c052f69 	stceq	15, cr2, [r5], {105}	; 0x69
 66c:	2f01054c 	svccs	0x0001054c
 670:	83050585 	movwhi	r0, #21893	; 0x5585
 674:	2f01054b 	svccs	0x0001054b
 678:	4b050585 	blmi	141c94 <__bss_end+0x138e74>
 67c:	852f0105 	strhi	r0, [pc, #-261]!	; 57f <shift+0x57f>
 680:	4ba10505 	blmi	fe841a9c <__bss_end+0xfe838c7c>
 684:	0c052f4b 	stceq	15, cr2, [r5], {75}	; 0x4b
 688:	2f01054b 	svccs	0x0001054b
 68c:	bd050585 	cfstr32lt	mvfx0, [r5, #-532]	; 0xfffffdec
 690:	2f4b4b4b 	svccs	0x004b4b4b
 694:	054c0c05 	strbeq	r0, [ip, #-3077]	; 0xfffff3fb
 698:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 69c:	4b4bbd05 	blmi	12efab8 <__bss_end+0x12e6c98>
 6a0:	0c052f4b 	stceq	15, cr2, [r5], {75}	; 0x4b
 6a4:	2f01054c 	svccs	0x0001054c
 6a8:	83050585 	movwhi	r0, #21893	; 0x5585
 6ac:	2f01054b 	svccs	0x0001054b
 6b0:	bd050585 	cfstr32lt	mvfx0, [r5, #-532]	; 0xfffffdec
 6b4:	2f4b4b4b 	svccs	0x004b4b4b
 6b8:	054c0c05 	strbeq	r0, [ip, #-3077]	; 0xfffff3fb
 6bc:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 6c0:	4b4ba105 	blmi	12e8adc <__bss_end+0x12dfcbc>
 6c4:	4c0c052f 	cfstr32mi	mvfx0, [ip], {47}	; 0x2f
 6c8:	852f0105 	strhi	r0, [pc, #-261]!	; 5cb <shift+0x5cb>
 6cc:	4bbd0505 	blmi	fef41ae8 <__bss_end+0xfef38cc8>
 6d0:	052f4b4b 	streq	r4, [pc, #-2891]!	; fffffb8d <__bss_end+0xffff6d6d>
 6d4:	01054c0c 	tsteq	r5, ip, lsl #24
 6d8:	0505852f 	streq	r8, [r5, #-1327]	; 0xfffffad1
 6dc:	2f4b4ba1 	svccs	0x004b4ba1
 6e0:	054c0c05 	strbeq	r0, [ip, #-3077]	; 0xfffff3fb
 6e4:	05859f01 	streq	r9, [r5, #3841]	; 0xf01
 6e8:	05056720 	streq	r6, [r5, #-1824]	; 0xfffff8e0
 6ec:	054b4b4d 	strbeq	r4, [fp, #-2893]	; 0xfffff4b3
 6f0:	0105300c 	tsteq	r5, ip
 6f4:	2005852f 	andcs	r8, r5, pc, lsr #10
 6f8:	4d050567 	cfstr32mi	mvfx0, [r5, #-412]	; 0xfffffe64
 6fc:	0c054b4b 			; <UNDEFINED> instruction: 0x0c054b4b
 700:	2f010530 	svccs	0x00010530
 704:	83200585 			; <UNDEFINED> instruction: 0x83200585
 708:	4b4c0505 	blmi	1301b24 <__bss_end+0x12f8d04>
 70c:	2f01054b 	svccs	0x0001054b
 710:	67200585 	strvs	r0, [r0, -r5, lsl #11]!
 714:	4b4d0505 	blmi	1341b30 <__bss_end+0x1338d10>
 718:	300c054b 	andcc	r0, ip, fp, asr #10
 71c:	872f0105 	strhi	r0, [pc, -r5, lsl #2]!
 720:	9fa00c05 	svcls	0x00a00c05
 724:	05bc3105 	ldreq	r3, [ip, #261]!	; 0x105
 728:	36056629 	strcc	r6, [r5], -r9, lsr #12
 72c:	300f052e 	andcc	r0, pc, lr, lsr #10
 730:	05661305 	strbeq	r1, [r6, #-773]!	; 0xfffffcfb
 734:	10058409 	andne	r8, r5, r9, lsl #8
 738:	9f0105d8 	svcls	0x000105d8
 73c:	01000802 	tsteq	r0, r2, lsl #16
 740:	00029b01 	andeq	r9, r2, r1, lsl #22
 744:	74000300 	strvc	r0, [r0], #-768	; 0xfffffd00
 748:	02000000 	andeq	r0, r0, #0
 74c:	0d0efb01 	vstreq	d15, [lr, #-4]
 750:	01010100 	mrseq	r0, (UNDEF: 17)
 754:	00000001 	andeq	r0, r0, r1
 758:	01000001 	tsteq	r0, r1
 75c:	6573552f 	ldrbvs	r5, [r3, #-1327]!	; 0xfffffad1
 760:	772f7372 			; <UNDEFINED> instruction: 0x772f7372
 764:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
 768:	2f696a72 	svccs	0x00696a72
 76c:	6b736544 	blvs	1cd9c84 <__bss_end+0x1cd0e64>
 770:	2f706f74 	svccs	0x00706f74
 774:	2f564146 	svccs	0x00564146
 778:	6176614e 	cmnvs	r6, lr, asr #2
 77c:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
 780:	4f2f6963 	svcmi	0x002f6963
 784:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
 788:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
 78c:	6b6c6172 	blvs	1b18d5c <__bss_end+0x1b0ff3c>
 790:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
 794:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
 798:	756f732f 	strbvc	r7, [pc, #-815]!	; 471 <shift+0x471>
 79c:	73656372 	cmnvc	r5, #-939524095	; 0xc8000001
 7a0:	6474732f 	ldrbtvs	r7, [r4], #-815	; 0xfffffcd1
 7a4:	2f62696c 	svccs	0x0062696c
 7a8:	00637273 	rsbeq	r7, r3, r3, ror r2
 7ac:	64747300 	ldrbtvs	r7, [r4], #-768	; 0xfffffd00
 7b0:	69727473 	ldmdbvs	r2!, {r0, r1, r4, r5, r6, sl, ip, sp, lr}^
 7b4:	632e676e 			; <UNDEFINED> instruction: 0x632e676e
 7b8:	01007070 	tsteq	r0, r0, ror r0
 7bc:	05000000 	streq	r0, [r0, #-0]
 7c0:	02050001 	andeq	r0, r5, #1
 7c4:	000086d0 	ldrdeq	r8, [r0], -r0
 7c8:	bb06051a 	bllt	181c38 <__bss_end+0x178e18>
 7cc:	054c0f05 	strbeq	r0, [ip, #-3845]	; 0xfffff0fb
 7d0:	0a056821 	beq	15a85c <__bss_end+0x151a3c>
 7d4:	2e0b05ba 	mcrcs	5, 0, r0, cr11, cr10, {5}
 7d8:	054a2705 	strbeq	r2, [sl, #-1797]	; 0xfffff8fb
 7dc:	09054a0d 	stmdbeq	r5, {r0, r2, r3, r9, fp, lr}
 7e0:	9f04052f 	svcls	0x0004052f
 7e4:	05620205 	strbeq	r0, [r2, #-517]!	; 0xfffffdfb
 7e8:	10053505 	andne	r3, r5, r5, lsl #10
 7ec:	2e110568 	cfmsc32cs	mvfx0, mvfx1, mvfx8
 7f0:	054a2205 	strbeq	r2, [sl, #-517]	; 0xfffffdfb
 7f4:	0a052e13 	beq	14c048 <__bss_end+0x143228>
 7f8:	6909052f 	stmdbvs	r9, {r0, r1, r2, r3, r5, r8, sl}
 7fc:	052e0a05 	streq	r0, [lr, #-2565]!	; 0xfffff5fb
 800:	03054a0c 	movweq	r4, #23052	; 0x5a0c
 804:	680b054b 	stmdavs	fp, {r0, r1, r3, r6, r8, sl}
 808:	02001805 	andeq	r1, r0, #327680	; 0x50000
 80c:	054a0304 	strbeq	r0, [sl, #-772]	; 0xfffffcfc
 810:	04020014 	streq	r0, [r2], #-20	; 0xffffffec
 814:	15059e03 	strne	r9, [r5, #-3587]	; 0xfffff1fd
 818:	02040200 	andeq	r0, r4, #0, 4
 81c:	00180568 	andseq	r0, r8, r8, ror #10
 820:	82020402 	andhi	r0, r2, #33554432	; 0x2000000
 824:	02000805 	andeq	r0, r0, #327680	; 0x50000
 828:	054a0204 	strbeq	r0, [sl, #-516]	; 0xfffffdfc
 82c:	0402001a 	streq	r0, [r2], #-26	; 0xffffffe6
 830:	1b054b02 	blne	153440 <__bss_end+0x14a620>
 834:	02040200 	andeq	r0, r4, #0, 4
 838:	000c052e 	andeq	r0, ip, lr, lsr #10
 83c:	4a020402 	bmi	8184c <__bss_end+0x78a2c>
 840:	02000f05 	andeq	r0, r0, #5, 30
 844:	05820204 	streq	r0, [r2, #516]	; 0x204
 848:	0402001b 	streq	r0, [r2], #-27	; 0xffffffe5
 84c:	11054a02 	tstne	r5, r2, lsl #20
 850:	02040200 	andeq	r0, r4, #0, 4
 854:	000a052e 	andeq	r0, sl, lr, lsr #10
 858:	2f020402 	svccs	0x00020402
 85c:	02000b05 	andeq	r0, r0, #5120	; 0x1400
 860:	052e0204 	streq	r0, [lr, #-516]!	; 0xfffffdfc
 864:	0402000d 	streq	r0, [r2], #-13
 868:	02054a02 	andeq	r4, r5, #8192	; 0x2000
 86c:	02040200 	andeq	r0, r4, #0, 4
 870:	88010546 	stmdahi	r1, {r1, r2, r6, r8, sl}
 874:	83060585 	movwhi	r0, #25989	; 0x6585
 878:	054c0905 	strbeq	r0, [ip, #-2309]	; 0xfffff6fb
 87c:	0a054a10 	beq	1530c4 <__bss_end+0x14a2a4>
 880:	bb07054c 	bllt	1c1db8 <__bss_end+0x1b8f98>
 884:	054a0305 	strbeq	r0, [sl, #-773]	; 0xfffffcfb
 888:	04020017 	streq	r0, [r2], #-23	; 0xffffffe9
 88c:	14054a01 	strne	r4, [r5], #-2561	; 0xfffff5ff
 890:	01040200 	mrseq	r0, R12_usr
 894:	4d0d054a 	cfstr32mi	mvfx0, [sp, #-296]	; 0xfffffed8
 898:	054a1405 	strbeq	r1, [sl, #-1029]	; 0xfffffbfb
 89c:	08052e0a 	stmdaeq	r5, {r1, r3, r9, sl, fp, sp}
 8a0:	03020568 	movweq	r0, #9576	; 0x2568
 8a4:	09056678 	stmdbeq	r5, {r3, r4, r5, r6, r9, sl, sp, lr}
 8a8:	052e0b03 	streq	r0, [lr, #-2819]!	; 0xfffff4fd
 8ac:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 8b0:	1605bd09 	strne	fp, [r5], -r9, lsl #26
 8b4:	04040200 	streq	r0, [r4], #-512	; 0xfffffe00
 8b8:	001d054a 	andseq	r0, sp, sl, asr #10
 8bc:	82020402 	andhi	r0, r2, #33554432	; 0x2000000
 8c0:	02001e05 	andeq	r1, r0, #5, 28	; 0x50
 8c4:	052e0204 	streq	r0, [lr, #-516]!	; 0xfffffdfc
 8c8:	04020016 	streq	r0, [r2], #-22	; 0xffffffea
 8cc:	11056602 	tstne	r5, r2, lsl #12
 8d0:	03040200 	movweq	r0, #16896	; 0x4200
 8d4:	0012054b 	andseq	r0, r2, fp, asr #10
 8d8:	2e030402 	cdpcs	4, 0, cr0, cr3, cr2, {0}
 8dc:	02000805 	andeq	r0, r0, #327680	; 0x50000
 8e0:	054a0304 	strbeq	r0, [sl, #-772]	; 0xfffffcfc
 8e4:	04020009 	streq	r0, [r2], #-9
 8e8:	12052e03 	andne	r2, r5, #3, 28	; 0x30
 8ec:	03040200 	movweq	r0, #16896	; 0x4200
 8f0:	000b054a 	andeq	r0, fp, sl, asr #10
 8f4:	2e030402 	cdpcs	4, 0, cr0, cr3, cr2, {0}
 8f8:	02000205 	andeq	r0, r0, #1342177280	; 0x50000000
 8fc:	052d0304 	streq	r0, [sp, #-772]!	; 0xfffffcfc
 900:	0402000b 	streq	r0, [r2], #-11
 904:	08058402 	stmdaeq	r5, {r1, sl, pc}
 908:	01040200 	mrseq	r0, R12_usr
 90c:	00090583 	andeq	r0, r9, r3, lsl #11
 910:	2e010402 	cdpcs	4, 0, cr0, cr1, cr2, {0}
 914:	02000b05 	andeq	r0, r0, #5120	; 0x1400
 918:	054a0104 	strbeq	r0, [sl, #-260]	; 0xfffffefc
 91c:	04020002 	streq	r0, [r2], #-2
 920:	0b054901 	bleq	152d2c <__bss_end+0x149f0c>
 924:	2f010585 	svccs	0x00010585
 928:	bc0e0585 	cfstr32lt	mvfx0, [lr], {133}	; 0x85
 92c:	05661105 	strbeq	r1, [r6, #-261]!	; 0xfffffefb
 930:	0b05bc20 	bleq	16f9b8 <__bss_end+0x166b98>
 934:	4b1f0566 	blmi	7c1ed4 <__bss_end+0x7b90b4>
 938:	05660a05 	strbeq	r0, [r6, #-2565]!	; 0xfffff5fb
 93c:	11054b08 	tstne	r5, r8, lsl #22
 940:	2e160583 	cdpcs	5, 1, cr0, cr6, cr3, {4}
 944:	05670805 	strbeq	r0, [r7, #-2053]!	; 0xfffff7fb
 948:	0b056711 	bleq	15a594 <__bss_end+0x151774>
 94c:	2f01054d 	svccs	0x0001054d
 950:	83060585 	movwhi	r0, #25989	; 0x6585
 954:	054c0b05 	strbeq	r0, [ip, #-2821]	; 0xfffff4fb
 958:	0e052e0c 	cdpeq	14, 0, cr2, cr5, cr12, {0}
 95c:	4b040566 	blmi	101efc <__bss_end+0xf90dc>
 960:	05650205 	strbeq	r0, [r5, #-517]!	; 0xfffffdfb
 964:	01053109 	tsteq	r5, r9, lsl #2
 968:	0805852f 	stmdaeq	r5, {r0, r1, r2, r3, r5, r8, sl, pc}
 96c:	4c0b059f 	cfstr32mi	mvfx0, [fp], {159}	; 0x9f
 970:	02001405 	andeq	r1, r0, #83886080	; 0x5000000
 974:	054a0304 	strbeq	r0, [sl, #-772]	; 0xfffffcfc
 978:	04020007 	streq	r0, [r2], #-7
 97c:	08058302 	stmdaeq	r5, {r1, r8, r9, pc}
 980:	02040200 	andeq	r0, r4, #0, 4
 984:	000a052e 	andeq	r0, sl, lr, lsr #10
 988:	4a020402 	bmi	81998 <__bss_end+0x78b78>
 98c:	02000205 	andeq	r0, r0, #1342177280	; 0x50000000
 990:	05490204 	strbeq	r0, [r9, #-516]	; 0xfffffdfc
 994:	05858401 	streq	r8, [r5, #1025]	; 0x401
 998:	0805bb0e 	stmdaeq	r5, {r1, r2, r3, r8, r9, fp, ip, sp, pc}
 99c:	4c0b054b 	cfstr32mi	mvfx0, [fp], {75}	; 0x4b
 9a0:	02001405 	andeq	r1, r0, #83886080	; 0x5000000
 9a4:	054a0304 	strbeq	r0, [sl, #-772]	; 0xfffffcfc
 9a8:	04020016 	streq	r0, [r2], #-22	; 0xffffffea
 9ac:	17058302 	strne	r8, [r5, -r2, lsl #6]
 9b0:	02040200 	andeq	r0, r4, #0, 4
 9b4:	000a052e 	andeq	r0, sl, lr, lsr #10
 9b8:	4a020402 	bmi	819c8 <__bss_end+0x78ba8>
 9bc:	02000b05 	andeq	r0, r0, #5120	; 0x1400
 9c0:	052e0204 	streq	r0, [lr, #-516]!	; 0xfffffdfc
 9c4:	04020017 	streq	r0, [r2], #-23	; 0xffffffe9
 9c8:	0d054a02 	vstreq	s8, [r5, #-8]
 9cc:	02040200 	andeq	r0, r4, #0, 4
 9d0:	0002052e 	andeq	r0, r2, lr, lsr #10
 9d4:	2d020402 	cfstrscs	mvf0, [r2, #-8]
 9d8:	02840105 	addeq	r0, r4, #1073741825	; 0x40000001
 9dc:	01010008 	tsteq	r1, r8

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
      58:	04220704 	strteq	r0, [r2], #-1796	; 0xfffff8fc
      5c:	5b020000 	blpl	80064 <__bss_end+0x77244>
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
     128:	00000422 	andeq	r0, r0, r2, lsr #8
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
     174:	cb104801 	blgt	412180 <__bss_end+0x409360>
     178:	d4000000 	strle	r0, [r0], #-0
     17c:	58000081 	stmdapl	r0, {r0, r7}
     180:	01000000 	mrseq	r0, (UNDEF: 0)
     184:	0000cb9c 	muleq	r0, ip, fp
     188:	02b40a00 	adcseq	r0, r4, #0, 20
     18c:	4a010000 	bmi	40194 <__bss_end+0x37374>
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
     21c:	ba0d9c01 	blt	367228 <__bss_end+0x35e408>
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
     24c:	8b120f01 	blhi	483e58 <__bss_end+0x47b038>
     250:	0f000001 	svceq	0x00000001
     254:	0000019e 	muleq	r0, lr, r1
     258:	03d51000 	bicseq	r1, r5, #0
     25c:	0a010000 	beq	40264 <__bss_end+0x37444>
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
     2b4:	8b140074 	blhi	50048c <__bss_end+0x4f766c>
     2b8:	a4000001 	strge	r0, [r0], #-1
     2bc:	38000080 	stmdacc	r0, {r7}
     2c0:	01000000 	mrseq	r0, (UNDEF: 0)
     2c4:	0067139c 	mlseq	r7, ip, r3, r1
     2c8:	9e2f0a01 	vmulls.f32	s0, s30, s2
     2cc:	02000001 	andeq	r0, r0, #1
     2d0:	00007491 	muleq	r0, r1, r4
     2d4:	00000176 	andeq	r0, r0, r6, ror r1
     2d8:	01e00004 	mvneq	r0, r4
     2dc:	01040000 	mrseq	r0, (UNDEF: 4)
     2e0:	000001e1 	andeq	r0, r0, r1, ror #3
     2e4:	0004c304 	andeq	ip, r4, r4, lsl #6
     2e8:	00005600 	andeq	r5, r0, r0, lsl #12
     2ec:	00822c00 	addeq	r2, r2, r0, lsl #24
     2f0:	00004800 	andeq	r4, r0, r0, lsl #16
     2f4:	00024600 	andeq	r4, r2, r0, lsl #12
     2f8:	08010200 	stmdaeq	r1, {r9}
     2fc:	0000047c 	andeq	r0, r0, ip, ror r4
     300:	33050202 	movwcc	r0, #20994	; 0x5202
     304:	03000005 	movweq	r0, #5
     308:	6e690504 	cdpvs	5, 6, cr0, cr9, cr4, {0}
     30c:	01020074 	tsteq	r2, r4, ror r0
     310:	00047308 	andeq	r7, r4, r8, lsl #6
     314:	07020200 	streq	r0, [r2, -r0, lsl #4]
     318:	000004b0 			; <UNDEFINED> instruction: 0x000004b0
     31c:	00049004 	andeq	r9, r4, r4
     320:	07090600 	streq	r0, [r9, -r0, lsl #12]
     324:	00000059 	andeq	r0, r0, r9, asr r0
     328:	00004805 	andeq	r4, r0, r5, lsl #16
     32c:	07040200 	streq	r0, [r4, -r0, lsl #4]
     330:	00000422 	andeq	r0, r0, r2, lsr #8
     334:	00040006 	andeq	r0, r4, r6
     338:	14050200 	strne	r0, [r5], #-512	; 0xfffffe00
     33c:	00000054 	andeq	r0, r0, r4, asr r0
     340:	8d980305 	ldchi	3, cr0, [r8, #20]
     344:	99060000 	stmdbls	r6, {}	; <UNPREDICTABLE>
     348:	02000004 	andeq	r0, r0, #4
     34c:	00541406 	subseq	r1, r4, r6, lsl #8
     350:	03050000 	movweq	r0, #20480	; 0x5000
     354:	00008d9c 	muleq	r0, ip, sp
     358:	00053d06 	andeq	r3, r5, r6, lsl #26
     35c:	1a070300 	bne	1c0f64 <__bss_end+0x1b8144>
     360:	00000054 	andeq	r0, r0, r4, asr r0
     364:	8da00305 	stchi	3, cr0, [r0, #20]!
     368:	e9060000 	stmdb	r6, {}	; <UNPREDICTABLE>
     36c:	03000003 	movweq	r0, #3
     370:	00541a09 	subseq	r1, r4, r9, lsl #20
     374:	03050000 	movweq	r0, #20480	; 0x5000
     378:	00008da4 	andeq	r8, r0, r4, lsr #27
     37c:	00052506 	andeq	r2, r5, r6, lsl #10
     380:	1a0b0300 	bne	2c0f88 <__bss_end+0x2b8168>
     384:	00000054 	andeq	r0, r0, r4, asr r0
     388:	8da80305 	stchi	3, cr0, [r8, #20]!
     38c:	60060000 	andvs	r0, r6, r0
     390:	03000004 	movweq	r0, #4
     394:	00541a0d 	subseq	r1, r4, sp, lsl #20
     398:	03050000 	movweq	r0, #20480	; 0x5000
     39c:	00008dac 	andeq	r8, r0, ip, lsr #27
     3a0:	00048606 	andeq	r8, r4, r6, lsl #12
     3a4:	1a0f0300 	bne	3c0fac <__bss_end+0x3b818c>
     3a8:	00000054 	andeq	r0, r0, r4, asr r0
     3ac:	8db00305 	ldchi	3, cr0, [r0, #20]!
     3b0:	01020000 	mrseq	r0, (UNDEF: 2)
     3b4:	00044802 	andeq	r4, r4, r2, lsl #16
     3b8:	042f0600 	strteq	r0, [pc], #-1536	; 3c0 <shift+0x3c0>
     3bc:	04040000 	streq	r0, [r4], #-0
     3c0:	00005414 	andeq	r5, r0, r4, lsl r4
     3c4:	b4030500 	strlt	r0, [r3], #-1280	; 0xfffffb00
     3c8:	0600008d 	streq	r0, [r0], -sp, lsl #1
     3cc:	000004a5 	andeq	r0, r0, r5, lsr #9
     3d0:	54140704 	ldrpl	r0, [r4], #-1796	; 0xfffff8fc
     3d4:	05000000 	streq	r0, [r0, #-0]
     3d8:	008db803 	addeq	fp, sp, r3, lsl #16
     3dc:	044d0600 	strbeq	r0, [sp], #-1536	; 0xfffffa00
     3e0:	0a040000 	beq	1003e8 <__bss_end+0xf75c8>
     3e4:	00005414 	andeq	r5, r0, r4, lsl r4
     3e8:	bc030500 	cfstr32lt	mvfx0, [r3], {-0}
     3ec:	0200008d 	andeq	r0, r0, #141	; 0x8d
     3f0:	041d0704 	ldreq	r0, [sp], #-1796	; 0xfffff8fc
     3f4:	0e060000 	cdpeq	0, 0, cr0, cr6, cr0, {0}
     3f8:	05000004 	streq	r0, [r0, #-4]
     3fc:	0054140a 	subseq	r1, r4, sl, lsl #8
     400:	03050000 	movweq	r0, #20480	; 0x5000
     404:	00008dc0 	andeq	r8, r0, r0, asr #27
     408:	00048107 	andeq	r8, r4, r7, lsl #2
     40c:	05050100 	streq	r0, [r5, #-256]	; 0xffffff00
     410:	00000033 	andeq	r0, r0, r3, lsr r0
     414:	0000822c 	andeq	r8, r0, ip, lsr #4
     418:	00000048 	andeq	r0, r0, r8, asr #32
     41c:	016d9c01 	cmneq	sp, r1, lsl #24
     420:	fb080000 	blx	20042a <__bss_end+0x1f760a>
     424:	01000003 	tsteq	r0, r3
     428:	00330e05 	eorseq	r0, r3, r5, lsl #28
     42c:	91020000 	mrsls	r0, (UNDEF: 2)
     430:	05530874 	ldrbeq	r0, [r3, #-2164]	; 0xfffff78c
     434:	05010000 	streq	r0, [r1, #-0]
     438:	00016d1b 	andeq	r6, r1, fp, lsl sp
     43c:	70910200 	addsvc	r0, r1, r0, lsl #4
     440:	73040900 	movwvc	r0, #18688	; 0x4900
     444:	09000001 	stmdbeq	r0, {r0}
     448:	00002504 	andeq	r2, r0, r4, lsl #10
     44c:	0b1f0000 	bleq	7c0454 <__bss_end+0x7b7634>
     450:	00040000 	andeq	r0, r4, r0
     454:	00000269 	andeq	r0, r0, r9, ror #4
     458:	0d4d0104 	stfeqe	f0, [sp, #-16]
     45c:	3e040000 	cdpcc	0, 0, cr0, cr4, cr0, {0}
     460:	6300000b 	movwvs	r0, #11
     464:	74000005 	strvc	r0, [r0], #-5
     468:	5c000082 	stcpl	0, cr0, [r0], {130}	; 0x82
     46c:	75000004 	strvc	r0, [r0, #-4]
     470:	02000004 	andeq	r0, r0, #4
     474:	047c0801 	ldrbteq	r0, [ip], #-2049	; 0xfffff7ff
     478:	25030000 	strcs	r0, [r3, #-0]
     47c:	02000000 	andeq	r0, r0, #0
     480:	05330502 	ldreq	r0, [r3, #-1282]!	; 0xfffffafe
     484:	04040000 	streq	r0, [r4], #-0
     488:	746e6905 	strbtvc	r6, [lr], #-2309	; 0xfffff6fb
     48c:	08010200 	stmdaeq	r1, {r9}
     490:	00000473 	andeq	r0, r0, r3, ror r4
     494:	b0070202 	andlt	r0, r7, r2, lsl #4
     498:	05000004 	streq	r0, [r0, #-4]
     49c:	00000490 	muleq	r0, r0, r4
     4a0:	5e070907 	vmlapl.f16	s0, s14, s14	; <UNPREDICTABLE>
     4a4:	03000000 	movweq	r0, #0
     4a8:	0000004d 	andeq	r0, r0, sp, asr #32
     4ac:	22070402 	andcs	r0, r7, #33554432	; 0x2000000
     4b0:	06000004 	streq	r0, [r0], -r4
     4b4:	000007ad 	andeq	r0, r0, sp, lsr #15
     4b8:	08060208 	stmdaeq	r6, {r3, r9}
     4bc:	0000008b 	andeq	r0, r0, fp, lsl #1
     4c0:	00307207 	eorseq	r7, r0, r7, lsl #4
     4c4:	4d0e0802 	stcmi	8, cr0, [lr, #-8]
     4c8:	00000000 	andeq	r0, r0, r0
     4cc:	00317207 	eorseq	r7, r1, r7, lsl #4
     4d0:	4d0e0902 	vstrmi.16	s0, [lr, #-4]	; <UNPREDICTABLE>
     4d4:	04000000 	streq	r0, [r0], #-0
     4d8:	0c150800 	ldceq	8, cr0, [r5], {-0}
     4dc:	04050000 	streq	r0, [r5], #-0
     4e0:	00000038 	andeq	r0, r0, r8, lsr r0
     4e4:	a90c0d02 	stmdbge	ip, {r1, r8, sl, fp}
     4e8:	09000000 	stmdbeq	r0, {}	; <UNPREDICTABLE>
     4ec:	00004b4f 	andeq	r4, r0, pc, asr #22
     4f0:	0007c60a 	andeq	ip, r7, sl, lsl #12
     4f4:	08000100 	stmdaeq	r0, {r8}
     4f8:	0000068e 	andeq	r0, r0, lr, lsl #13
     4fc:	00380405 	eorseq	r0, r8, r5, lsl #8
     500:	1e020000 	cdpne	0, 0, cr0, cr2, cr0, {0}
     504:	0000e00c 	andeq	lr, r0, ip
     508:	08180a00 	ldmdaeq	r8, {r9, fp}
     50c:	0a000000 	beq	514 <shift+0x514>
     510:	00000f89 	andeq	r0, r0, r9, lsl #31
     514:	0f690a01 	svceq	0x00690a01
     518:	0a020000 	beq	80520 <__bss_end+0x77700>
     51c:	00000989 	andeq	r0, r0, r9, lsl #19
     520:	0abe0a03 	beq	fef82d34 <__bss_end+0xfef79f14>
     524:	0a040000 	beq	10052c <__bss_end+0xf770c>
     528:	000007d8 	ldrdeq	r0, [r0], -r8
     52c:	d8080005 	stmdale	r8, {r0, r2}
     530:	0500000e 	streq	r0, [r0, #-14]
     534:	00003804 	andeq	r3, r0, r4, lsl #16
     538:	0c3f0200 	lfmeq	f0, 4, [pc], #-0	; 540 <shift+0x540>
     53c:	0000011d 	andeq	r0, r0, sp, lsl r1
     540:	0005ae0a 	andeq	sl, r5, sl, lsl #28
     544:	a30a0000 	movwge	r0, #40960	; 0xa000
     548:	01000006 	tsteq	r0, r6
     54c:	000ab10a 	andeq	fp, sl, sl, lsl #2
     550:	350a0200 	strcc	r0, [sl, #-512]	; 0xfffffe00
     554:	0300000f 	movweq	r0, #15
     558:	000f930a 	andeq	r9, pc, sl, lsl #6
     55c:	6d0a0400 	cfstrsvs	mvf0, [sl, #-0]
     560:	0500000a 	streq	r0, [r0, #-10]
     564:	0009500a 	andeq	r5, r9, sl
     568:	08000600 	stmdaeq	r0, {r9, sl}
     56c:	00000e92 	muleq	r0, r2, lr
     570:	00380405 	eorseq	r0, r8, r5, lsl #8
     574:	66020000 	strvs	r0, [r2], -r0
     578:	0001480c 	andeq	r4, r1, ip, lsl #16
     57c:	0b330a00 	bleq	cc2d84 <__bss_end+0xcb9f64>
     580:	0a000000 	beq	588 <shift+0x588>
     584:	0000090b 	andeq	r0, r0, fp, lsl #18
     588:	0bde0a01 	bleq	ff782d94 <__bss_end+0xff779f74>
     58c:	0a020000 	beq	80594 <__bss_end+0x77774>
     590:	00000955 	andeq	r0, r0, r5, asr r9
     594:	000b0003 	andeq	r0, fp, r3
     598:	03000004 	movweq	r0, #4
     59c:	00591405 	subseq	r1, r9, r5, lsl #8
     5a0:	03050000 	movweq	r0, #20480	; 0x5000
     5a4:	00008dc4 	andeq	r8, r0, r4, asr #27
     5a8:	0004990b 	andeq	r9, r4, fp, lsl #18
     5ac:	14060300 	strne	r0, [r6], #-768	; 0xfffffd00
     5b0:	00000059 	andeq	r0, r0, r9, asr r0
     5b4:	8dc80305 	stclhi	3, cr0, [r8, #20]
     5b8:	3d0b0000 	stccc	0, cr0, [fp, #-0]
     5bc:	04000005 	streq	r0, [r0], #-5
     5c0:	00591a07 	subseq	r1, r9, r7, lsl #20
     5c4:	03050000 	movweq	r0, #20480	; 0x5000
     5c8:	00008dcc 	andeq	r8, r0, ip, asr #27
     5cc:	0003e90b 	andeq	lr, r3, fp, lsl #18
     5d0:	1a090400 	bne	2415d8 <__bss_end+0x2387b8>
     5d4:	00000059 	andeq	r0, r0, r9, asr r0
     5d8:	8dd00305 	ldclhi	3, cr0, [r0, #20]
     5dc:	250b0000 	strcs	r0, [fp, #-0]
     5e0:	04000005 	streq	r0, [r0], #-5
     5e4:	00591a0b 	subseq	r1, r9, fp, lsl #20
     5e8:	03050000 	movweq	r0, #20480	; 0x5000
     5ec:	00008dd4 	ldrdeq	r8, [r0], -r4
     5f0:	0004600b 	andeq	r6, r4, fp
     5f4:	1a0d0400 	bne	3415fc <__bss_end+0x3387dc>
     5f8:	00000059 	andeq	r0, r0, r9, asr r0
     5fc:	8dd80305 	ldclhi	3, cr0, [r8, #20]
     600:	860b0000 	strhi	r0, [fp], -r0
     604:	04000004 	streq	r0, [r0], #-4
     608:	00591a0f 	subseq	r1, r9, pc, lsl #20
     60c:	03050000 	movweq	r0, #20480	; 0x5000
     610:	00008ddc 	ldrdeq	r8, [r0], -ip
     614:	000f4e08 	andeq	r4, pc, r8, lsl #28
     618:	38040500 	stmdacc	r4, {r8, sl}
     61c:	04000000 	streq	r0, [r0], #-0
     620:	01eb0c1b 	mvneq	r0, fp, lsl ip
     624:	9f0a0000 	svcls	0x000a0000
     628:	0000000c 	andeq	r0, r0, ip
     62c:	000f5e0a 	andeq	r5, pc, sl, lsl #28
     630:	ac0a0100 	stfges	f0, [sl], {-0}
     634:	0200000a 	andeq	r0, r0, #10
     638:	0b2d0c00 	bleq	b43640 <__bss_end+0xb3a820>
     63c:	01020000 	mrseq	r0, (UNDEF: 2)
     640:	00044802 	andeq	r4, r4, r2, lsl #16
     644:	2c040d00 	stccs	13, cr0, [r4], {-0}
     648:	0d000000 	stceq	0, cr0, [r0, #-0]
     64c:	0001eb04 	andeq	lr, r1, r4, lsl #22
     650:	042f0b00 	strteq	r0, [pc], #-2816	; 658 <shift+0x658>
     654:	04050000 	streq	r0, [r5], #-0
     658:	00005914 	andeq	r5, r0, r4, lsl r9
     65c:	e0030500 	and	r0, r3, r0, lsl #10
     660:	0b00008d 	bleq	89c <shift+0x89c>
     664:	000004a5 	andeq	r0, r0, r5, lsr #9
     668:	59140705 	ldmdbpl	r4, {r0, r2, r8, r9, sl}
     66c:	05000000 	streq	r0, [r0, #-0]
     670:	008de403 	addeq	lr, sp, r3, lsl #8
     674:	044d0b00 	strbeq	r0, [sp], #-2816	; 0xfffff500
     678:	0a050000 	beq	140680 <__bss_end+0x137860>
     67c:	00005914 	andeq	r5, r0, r4, lsl r9
     680:	e8030500 	stmda	r3, {r8, sl}
     684:	0800008d 	stmdaeq	r0, {r0, r2, r3, r7}
     688:	000009e4 	andeq	r0, r0, r4, ror #19
     68c:	00380405 	eorseq	r0, r8, r5, lsl #8
     690:	0d050000 	stceq	0, cr0, [r5, #-0]
     694:	0002700c 	andeq	r7, r2, ip
     698:	654e0900 	strbvs	r0, [lr, #-2304]	; 0xfffff700
     69c:	0a000077 	beq	880 <shift+0x880>
     6a0:	000009db 	ldrdeq	r0, [r0], -fp
     6a4:	0c260a01 			; <UNDEFINED> instruction: 0x0c260a01
     6a8:	0a020000 	beq	806b0 <__bss_end+0x77890>
     6ac:	000009ad 	andeq	r0, r0, sp, lsr #19
     6b0:	097b0a03 	ldmdbeq	fp!, {r0, r1, r9, fp}^
     6b4:	0a040000 	beq	1006bc <__bss_end+0xf789c>
     6b8:	00000ab7 			; <UNDEFINED> instruction: 0x00000ab7
     6bc:	cb060005 	blgt	1806d8 <__bss_end+0x1778b8>
     6c0:	10000007 	andne	r0, r0, r7
     6c4:	af081b05 	svcge	0x00081b05
     6c8:	07000002 	streq	r0, [r0, -r2]
     6cc:	0500726c 	streq	r7, [r0, #-620]	; 0xfffffd94
     6d0:	02af131d 	adceq	r1, pc, #1946157056	; 0x74000000
     6d4:	07000000 	streq	r0, [r0, -r0]
     6d8:	05007073 	streq	r7, [r0, #-115]	; 0xffffff8d
     6dc:	02af131e 	adceq	r1, pc, #2013265920	; 0x78000000
     6e0:	07040000 	streq	r0, [r4, -r0]
     6e4:	05006370 	streq	r6, [r0, #-880]	; 0xfffffc90
     6e8:	02af131f 	adceq	r1, pc, #2080374784	; 0x7c000000
     6ec:	0e080000 	cdpeq	0, 0, cr0, cr8, cr0, {0}
     6f0:	000007ea 	andeq	r0, r0, sl, ror #15
     6f4:	af132005 	svcge	0x00132005
     6f8:	0c000002 	stceq	0, cr0, [r0], {2}
     6fc:	07040200 	streq	r0, [r4, -r0, lsl #4]
     700:	0000041d 	andeq	r0, r0, sp, lsl r4
     704:	00088706 	andeq	r8, r8, r6, lsl #14
     708:	28057000 	stmdacs	r5, {ip, sp, lr}
     70c:	00034608 	andeq	r4, r3, r8, lsl #12
     710:	0c930e00 	ldceq	14, cr0, [r3], {0}
     714:	2a050000 	bcs	14071c <__bss_end+0x1378fc>
     718:	00027012 	andeq	r7, r2, r2, lsl r0
     71c:	70070000 	andvc	r0, r7, r0
     720:	05006469 	streq	r6, [r0, #-1129]	; 0xfffffb97
     724:	005e122b 	subseq	r1, lr, fp, lsr #4
     728:	0e100000 	cdpeq	0, 1, cr0, cr0, cr0, {0}
     72c:	000006e8 	andeq	r0, r0, r8, ror #13
     730:	39112c05 	ldmdbcc	r1, {r0, r2, sl, fp, sp}
     734:	14000002 	strne	r0, [r0], #-2
     738:	0009f00e 	andeq	pc, r9, lr
     73c:	122d0500 	eorne	r0, sp, #0, 10
     740:	0000005e 	andeq	r0, r0, lr, asr r0
     744:	09fe0e18 	ldmibeq	lr!, {r3, r4, r9, sl, fp}^
     748:	2e050000 	cdpcs	0, 0, cr0, cr5, cr0, {0}
     74c:	00005e12 	andeq	r5, r0, r2, lsl lr
     750:	b90e1c00 	stmdblt	lr, {sl, fp, ip}
     754:	05000007 	streq	r0, [r0, #-7]
     758:	03460c2f 	movteq	r0, #27695	; 0x6c2f
     75c:	0e200000 	cdpeq	0, 2, cr0, cr0, cr0, {0}
     760:	00000a1a 	andeq	r0, r0, sl, lsl sl
     764:	38093005 	stmdacc	r9, {r0, r2, ip, sp}
     768:	60000000 	andvs	r0, r0, r0
     76c:	000cb00e 	andeq	fp, ip, lr
     770:	0e310500 	cfabs32eq	mvfx0, mvfx1
     774:	0000004d 	andeq	r0, r0, sp, asr #32
     778:	08290e64 	stmdaeq	r9!, {r2, r5, r6, r9, sl, fp}
     77c:	33050000 	movwcc	r0, #20480	; 0x5000
     780:	00004d0e 	andeq	r4, r0, lr, lsl #26
     784:	200e6800 	andcs	r6, lr, r0, lsl #16
     788:	05000008 	streq	r0, [r0, #-8]
     78c:	004d0e34 	subeq	r0, sp, r4, lsr lr
     790:	006c0000 	rsbeq	r0, ip, r0
     794:	0001fd0f 	andeq	pc, r1, pc, lsl #26
     798:	00035600 	andeq	r5, r3, r0, lsl #12
     79c:	005e1000 	subseq	r1, lr, r0
     7a0:	000f0000 	andeq	r0, pc, r0
     7a4:	00040e0b 	andeq	r0, r4, fp, lsl #28
     7a8:	140a0600 	strne	r0, [sl], #-1536	; 0xfffffa00
     7ac:	00000059 	andeq	r0, r0, r9, asr r0
     7b0:	8dec0305 	stclhi	3, cr0, [ip, #20]!
     7b4:	b5080000 	strlt	r0, [r8, #-0]
     7b8:	05000009 	streq	r0, [r0, #-9]
     7bc:	00003804 	andeq	r3, r0, r4, lsl #16
     7c0:	0c0d0600 	stceq	6, cr0, [sp], {-0}
     7c4:	00000387 	andeq	r0, r0, r7, lsl #7
     7c8:	0006a80a 	andeq	sl, r6, sl, lsl #16
     7cc:	580a0000 	stmdapl	sl, {}	; <UNPREDICTABLE>
     7d0:	01000005 	tsteq	r0, r5
     7d4:	03680300 	cmneq	r8, #0, 6
     7d8:	49080000 	stmdbmi	r8, {}	; <UNPREDICTABLE>
     7dc:	0500000a 	streq	r0, [r0, #-10]
     7e0:	00003804 	andeq	r3, r0, r4, lsl #16
     7e4:	0c140600 	ldceq	6, cr0, [r4], {-0}
     7e8:	000003ab 	andeq	r0, r0, fp, lsr #7
     7ec:	0005ed0a 	andeq	lr, r5, sl, lsl #26
     7f0:	d00a0000 	andle	r0, sl, r0
     7f4:	0100000b 	tsteq	r0, fp
     7f8:	038c0300 	orreq	r0, ip, #0, 6
     7fc:	21060000 	mrscs	r0, (UNDEF: 6)
     800:	0c00000e 	stceq	0, cr0, [r0], {14}
     804:	e5081b06 	str	r1, [r8, #-2822]	; 0xfffff4fa
     808:	0e000003 	cdpeq	0, 0, cr0, cr0, cr3, {0}
     80c:	000005e8 	andeq	r0, r0, r8, ror #11
     810:	e5191d06 	ldr	r1, [r9, #-3334]	; 0xfffff2fa
     814:	00000003 	andeq	r0, r0, r3
     818:	0006650e 	andeq	r6, r6, lr, lsl #10
     81c:	191e0600 	ldmdbne	lr, {r9, sl}
     820:	000003e5 	andeq	r0, r0, r5, ror #7
     824:	0d240e04 	stceq	14, cr0, [r4, #-16]!
     828:	1f060000 	svcne	0x00060000
     82c:	0003eb13 	andeq	lr, r3, r3, lsl fp
     830:	0d000800 	stceq	8, cr0, [r0, #-0]
     834:	0003b004 	andeq	fp, r3, r4
     838:	b6040d00 	strlt	r0, [r4], -r0, lsl #26
     83c:	11000002 	tstne	r0, r2
     840:	0000070d 	andeq	r0, r0, sp, lsl #14
     844:	07220614 			; <UNDEFINED> instruction: 0x07220614
     848:	00000673 	andeq	r0, r0, r3, ror r6
     84c:	0009a30e 	andeq	sl, r9, lr, lsl #6
     850:	12260600 	eorne	r0, r6, #0, 12
     854:	0000004d 	andeq	r0, r0, sp, asr #32
     858:	06190e00 	ldreq	r0, [r9], -r0, lsl #28
     85c:	29060000 	stmdbcs	r6, {}	; <UNPREDICTABLE>
     860:	0003e51d 	andeq	lr, r3, sp, lsl r5
     864:	6a0e0400 	bvs	38186c <__bss_end+0x378a4c>
     868:	0600000c 	streq	r0, [r0], -ip
     86c:	03e51d2c 	mvneq	r1, #44, 26	; 0xb00
     870:	12080000 	andne	r0, r8, #0
     874:	00000ece 	andeq	r0, r0, lr, asr #29
     878:	fe0e2f06 	cdp2	15, 0, cr2, cr14, cr6, {0}
     87c:	3900000d 	stmdbcc	r0, {r0, r2, r3}
     880:	44000004 	strmi	r0, [r0], #-4
     884:	13000004 	movwne	r0, #4
     888:	00000678 	andeq	r0, r0, r8, ror r6
     88c:	0003e514 	andeq	lr, r3, r4, lsl r5
     890:	35150000 	ldrcc	r0, [r5, #-0]
     894:	0600000d 	streq	r0, [r0], -sp
     898:	085e0e31 	ldmdaeq	lr, {r0, r4, r5, r9, sl, fp}^
     89c:	01f00000 	mvnseq	r0, r0
     8a0:	045c0000 	ldrbeq	r0, [ip], #-0
     8a4:	04670000 	strbteq	r0, [r7], #-0
     8a8:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
     8ac:	14000006 	strne	r0, [r0], #-6
     8b0:	000003eb 	andeq	r0, r0, fp, ror #7
     8b4:	0e341600 	cfmsuba32eq	mvax0, mvax1, mvfx4, mvfx0
     8b8:	35060000 	strcc	r0, [r6, #-0]
     8bc:	000cff1d 	andeq	pc, ip, sp, lsl pc	; <UNPREDICTABLE>
     8c0:	0003e500 	andeq	lr, r3, r0, lsl #10
     8c4:	04800200 	streq	r0, [r0], #512	; 0x200
     8c8:	04860000 	streq	r0, [r6], #0
     8cc:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
     8d0:	00000006 	andeq	r0, r0, r6
     8d4:	00094316 	andeq	r4, r9, r6, lsl r3
     8d8:	1d370600 	ldcne	6, cr0, [r7, #-0]
     8dc:	00000b9a 	muleq	r0, sl, fp
     8e0:	000003e5 	andeq	r0, r0, r5, ror #7
     8e4:	00049f02 	andeq	r9, r4, r2, lsl #30
     8e8:	0004a500 	andeq	sl, r4, r0, lsl #10
     8ec:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
     8f0:	17000000 	strne	r0, [r0, -r0]
     8f4:	00000a2a 	andeq	r0, r0, sl, lsr #20
     8f8:	91313906 	teqls	r1, r6, lsl #18
     8fc:	0c000006 	stceq	0, cr0, [r0], {6}
     900:	070d1602 	streq	r1, [sp, -r2, lsl #12]
     904:	3c060000 	stccc	0, cr0, [r6], {-0}
     908:	000f6f09 	andeq	r6, pc, r9, lsl #30
     90c:	00067800 	andeq	r7, r6, r0, lsl #16
     910:	04cc0100 	strbeq	r0, [ip], #256	; 0x100
     914:	04d20000 	ldrbeq	r0, [r2], #0
     918:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
     91c:	00000006 	andeq	r0, r0, r6
     920:	0006bd16 	andeq	fp, r6, r6, lsl sp
     924:	123f0600 	eorsne	r0, pc, #0, 12
     928:	00000ea3 	andeq	r0, r0, r3, lsr #29
     92c:	0000004d 	andeq	r0, r0, sp, asr #32
     930:	0004eb01 	andeq	lr, r4, r1, lsl #22
     934:	00050000 	andeq	r0, r5, r0
     938:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
     93c:	9a140000 	bls	500944 <__bss_end+0x4f7b24>
     940:	14000006 	strne	r0, [r0], #-6
     944:	0000005e 	andeq	r0, r0, lr, asr r0
     948:	0001f014 	andeq	pc, r1, r4, lsl r0	; <UNPREDICTABLE>
     94c:	44180000 	ldrmi	r0, [r8], #-0
     950:	0600000d 	streq	r0, [r0], -sp
     954:	0adf0e42 	beq	ff7c4264 <__bss_end+0xff7bb444>
     958:	15010000 	strne	r0, [r1, #-0]
     95c:	1b000005 	blne	978 <shift+0x978>
     960:	13000005 	movwne	r0, #5
     964:	00000678 	andeq	r0, r0, r8, ror r6
     968:	08d21600 	ldmeq	r2, {r9, sl, ip}^
     96c:	45060000 	strmi	r0, [r6, #-0]
     970:	00063117 	andeq	r3, r6, r7, lsl r1
     974:	0003eb00 	andeq	lr, r3, r0, lsl #22
     978:	05340100 	ldreq	r0, [r4, #-256]!	; 0xffffff00
     97c:	053a0000 	ldreq	r0, [sl, #-0]!
     980:	a0130000 	andsge	r0, r3, r0
     984:	00000006 	andeq	r0, r0, r6
     988:	00066a16 	andeq	r6, r6, r6, lsl sl
     98c:	17480600 	strbne	r0, [r8, -r0, lsl #12]
     990:	00000cbc 			; <UNDEFINED> instruction: 0x00000cbc
     994:	000003eb 	andeq	r0, r0, fp, ror #7
     998:	00055301 	andeq	r5, r5, r1, lsl #6
     99c:	00055e00 	andeq	r5, r5, r0, lsl #28
     9a0:	06a01300 	strteq	r1, [r0], r0, lsl #6
     9a4:	4d140000 	ldcmi	0, cr0, [r4, #-0]
     9a8:	00000000 	andeq	r0, r0, r0
     9ac:	000f1a18 	andeq	r1, pc, r8, lsl sl	; <UNPREDICTABLE>
     9b0:	0e4b0600 	cdpeq	6, 4, cr0, cr11, cr0, {0}
     9b4:	000005b3 			; <UNDEFINED> instruction: 0x000005b3
     9b8:	00057301 	andeq	r7, r5, r1, lsl #6
     9bc:	00057900 	andeq	r7, r5, r0, lsl #18
     9c0:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
     9c4:	16000000 	strne	r0, [r0], -r0
     9c8:	00000d35 	andeq	r0, r0, r5, lsr sp
     9cc:	f00e4d06 			; <UNDEFINED> instruction: 0xf00e4d06
     9d0:	f0000007 			; <UNDEFINED> instruction: 0xf0000007
     9d4:	01000001 	tsteq	r0, r1
     9d8:	00000592 	muleq	r0, r2, r5
     9dc:	0000059d 	muleq	r0, sp, r5
     9e0:	00067813 	andeq	r7, r6, r3, lsl r8
     9e4:	004d1400 	subeq	r1, sp, r0, lsl #8
     9e8:	16000000 	strne	r0, [r0], -r0
     9ec:	000008f7 	strdeq	r0, [r0], -r7
     9f0:	00125006 	andseq	r5, r2, r6
     9f4:	4d00000b 	stcmi	0, cr0, [r0, #-44]	; 0xffffffd4
     9f8:	01000000 	mrseq	r0, (UNDEF: 0)
     9fc:	000005b6 			; <UNDEFINED> instruction: 0x000005b6
     a00:	000005c1 	andeq	r0, r0, r1, asr #11
     a04:	00067813 	andeq	r7, r6, r3, lsl r8
     a08:	01fd1400 	mvnseq	r1, r0, lsl #8
     a0c:	16000000 	strne	r0, [r0], -r0
     a10:	000005fa 	strdeq	r0, [r0], -sl
     a14:	320e5306 	andcc	r5, lr, #402653184	; 0x18000000
     a18:	f0000008 			; <UNDEFINED> instruction: 0xf0000008
     a1c:	01000001 	tsteq	r0, r1
     a20:	000005da 	ldrdeq	r0, [r0], -sl
     a24:	000005e5 	andeq	r0, r0, r5, ror #11
     a28:	00067813 	andeq	r7, r6, r3, lsl r8
     a2c:	004d1400 	subeq	r1, sp, r0, lsl #8
     a30:	18000000 	stmdane	r0, {}	; <UNPREDICTABLE>
     a34:	0000092a 	andeq	r0, r0, sl, lsr #18
     a38:	400e5606 	andmi	r5, lr, r6, lsl #12
     a3c:	0100000e 	tsteq	r0, lr
     a40:	000005fa 	strdeq	r0, [r0], -sl
     a44:	00000619 	andeq	r0, r0, r9, lsl r6
     a48:	00067813 	andeq	r7, r6, r3, lsl r8
     a4c:	00a91400 	adceq	r1, r9, r0, lsl #8
     a50:	4d140000 	ldcmi	0, cr0, [r4, #-0]
     a54:	14000000 	strne	r0, [r0], #-0
     a58:	0000004d 	andeq	r0, r0, sp, asr #32
     a5c:	00004d14 	andeq	r4, r0, r4, lsl sp
     a60:	06a61400 	strteq	r1, [r6], r0, lsl #8
     a64:	18000000 	stmdane	r0, {}	; <UNPREDICTABLE>
     a68:	00000ce9 	andeq	r0, r0, r9, ror #25
     a6c:	610e5806 	tstvs	lr, r6, lsl #16
     a70:	01000007 	tsteq	r0, r7
     a74:	0000062e 	andeq	r0, r0, lr, lsr #12
     a78:	0000064d 	andeq	r0, r0, sp, asr #12
     a7c:	00067813 	andeq	r7, r6, r3, lsl r8
     a80:	00e01400 	rsceq	r1, r0, r0, lsl #8
     a84:	4d140000 	ldcmi	0, cr0, [r4, #-0]
     a88:	14000000 	strne	r0, [r0], #-0
     a8c:	0000004d 	andeq	r0, r0, sp, asr #32
     a90:	00004d14 	andeq	r4, r0, r4, lsl sp
     a94:	06a61400 	strteq	r1, [r6], r0, lsl #8
     a98:	19000000 	stmdbne	r0, {}	; <UNPREDICTABLE>
     a9c:	000006fa 	strdeq	r0, [r0], -sl
     aa0:	1e0e5b06 	vmlane.f64	d5, d14, d6
     aa4:	f0000007 			; <UNDEFINED> instruction: 0xf0000007
     aa8:	01000001 	tsteq	r0, r1
     aac:	00000662 	andeq	r0, r0, r2, ror #12
     ab0:	00067813 	andeq	r7, r6, r3, lsl r8
     ab4:	03681400 	cmneq	r8, #0, 8
     ab8:	ac140000 	ldcge	0, cr0, [r4], {-0}
     abc:	00000006 	andeq	r0, r0, r6
     ac0:	03f10300 	mvnseq	r0, #0, 6
     ac4:	040d0000 	streq	r0, [sp], #-0
     ac8:	000003f1 	strdeq	r0, [r0], -r1
     acc:	0003e51a 	andeq	lr, r3, sl, lsl r5
     ad0:	00068b00 	andeq	r8, r6, r0, lsl #22
     ad4:	00069100 	andeq	r9, r6, r0, lsl #2
     ad8:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
     adc:	1b000000 	blne	ae4 <shift+0xae4>
     ae0:	000003f1 	strdeq	r0, [r0], -r1
     ae4:	0000067e 	andeq	r0, r0, lr, ror r6
     ae8:	003f040d 	eorseq	r0, pc, sp, lsl #8
     aec:	040d0000 	streq	r0, [sp], #-0
     af0:	00000673 	andeq	r0, r0, r3, ror r6
     af4:	0065041c 	rsbeq	r0, r5, ip, lsl r4
     af8:	041d0000 	ldreq	r0, [sp], #-0
     afc:	00002c0f 	andeq	r2, r0, pc, lsl #24
     b00:	0006be00 	andeq	fp, r6, r0, lsl #28
     b04:	005e1000 	subseq	r1, lr, r0
     b08:	00090000 	andeq	r0, r9, r0
     b0c:	0006ae03 	andeq	sl, r6, r3, lsl #28
     b10:	08e61e00 	stmiaeq	r6!, {r9, sl, fp, ip}^
     b14:	a3010000 	movwge	r0, #4096	; 0x1000
     b18:	0006be0c 	andeq	fp, r6, ip, lsl #28
     b1c:	f0030500 			; <UNDEFINED> instruction: 0xf0030500
     b20:	1f00008d 	svcne	0x0000008d
     b24:	0000062c 	andeq	r0, r0, ip, lsr #12
     b28:	3d0aa501 	cfstr32cc	mvfx10, [sl, #-4]
     b2c:	4d00000a 	stcmi	0, cr0, [r0, #-40]	; 0xffffffd8
     b30:	20000000 	andcs	r0, r0, r0
     b34:	b0000086 	andlt	r0, r0, r6, lsl #1
     b38:	01000000 	mrseq	r0, (UNDEF: 0)
     b3c:	0007339c 	muleq	r7, ip, r3
     b40:	0f152000 	svceq	0x00152000
     b44:	a5010000 	strge	r0, [r1, #-0]
     b48:	0001f71b 	andeq	pc, r1, fp, lsl r7	; <UNPREDICTABLE>
     b4c:	ac910300 	ldcge	3, cr0, [r1], {0}
     b50:	0aa3207f 	beq	fe8c8d54 <__bss_end+0xfe8bff34>
     b54:	a5010000 	strge	r0, [r1, #-0]
     b58:	00004d2a 	andeq	r4, r0, sl, lsr #26
     b5c:	a8910300 	ldmge	r1, {r8, r9}
     b60:	09d51e7f 	ldmibeq	r5, {r0, r1, r2, r3, r4, r5, r6, r9, sl, fp, ip}^
     b64:	a7010000 	strge	r0, [r1, -r0]
     b68:	0007330a 	andeq	r3, r7, sl, lsl #6
     b6c:	b4910300 	ldrlt	r0, [r1], #768	; 0x300
     b70:	06141e7f 			; <UNDEFINED> instruction: 0x06141e7f
     b74:	ab010000 	blge	40b7c <__bss_end+0x37d5c>
     b78:	00003809 	andeq	r3, r0, r9, lsl #16
     b7c:	74910200 	ldrvc	r0, [r1], #512	; 0x200
     b80:	00250f00 	eoreq	r0, r5, r0, lsl #30
     b84:	07430000 	strbeq	r0, [r3, -r0]
     b88:	5e100000 	cdppl	0, 1, cr0, cr0, cr0, {0}
     b8c:	3f000000 	svccc	0x00000000
     b90:	0a882100 	beq	fe208f98 <__bss_end+0xfe200178>
     b94:	97010000 	strls	r0, [r1, -r0]
     b98:	000bf50a 	andeq	pc, fp, sl, lsl #10
     b9c:	00004d00 	andeq	r4, r0, r0, lsl #26
     ba0:	0085e400 	addeq	lr, r5, r0, lsl #8
     ba4:	00003c00 	andeq	r3, r0, r0, lsl #24
     ba8:	809c0100 	addshi	r0, ip, r0, lsl #2
     bac:	22000007 	andcs	r0, r0, #7
     bb0:	00716572 	rsbseq	r6, r1, r2, ror r5
     bb4:	ab209901 	blge	826fc0 <__bss_end+0x81e1a0>
     bb8:	02000003 	andeq	r0, r0, #3
     bbc:	241e7491 	ldrcs	r7, [lr], #-1169	; 0xfffffb6f
     bc0:	0100000a 	tsteq	r0, sl
     bc4:	004d0e9a 	umaaleq	r0, sp, sl, lr
     bc8:	91020000 	mrsls	r0, (UNDEF: 2)
     bcc:	cd230070 	stcgt	0, cr0, [r3, #-448]!	; 0xfffffe40
     bd0:	0100000a 	tsteq	r0, sl
     bd4:	06cc068e 	strbeq	r0, [ip], lr, lsl #13
     bd8:	85a80000 	strhi	r0, [r8, #0]!
     bdc:	003c0000 	eorseq	r0, ip, r0
     be0:	9c010000 	stcls	0, cr0, [r1], {-0}
     be4:	000007b9 			; <UNDEFINED> instruction: 0x000007b9
     be8:	0008a020 	andeq	sl, r8, r0, lsr #32
     bec:	218e0100 	orrcs	r0, lr, r0, lsl #2
     bf0:	0000004d 	andeq	r0, r0, sp, asr #32
     bf4:	226c9102 	rsbcs	r9, ip, #-2147483648	; 0x80000000
     bf8:	00716572 	rsbseq	r6, r1, r2, ror r5
     bfc:	ab209001 	blge	824c08 <__bss_end+0x81bde8>
     c00:	02000003 	andeq	r0, r0, #3
     c04:	21007491 			; <UNDEFINED> instruction: 0x21007491
     c08:	00000a5e 	andeq	r0, r0, lr, asr sl
     c0c:	160a8201 	strne	r8, [sl], -r1, lsl #4
     c10:	4d000009 	stcmi	0, cr0, [r0, #-36]	; 0xffffffdc
     c14:	6c000000 	stcvs	0, cr0, [r0], {-0}
     c18:	3c000085 	stccc	0, cr0, [r0], {133}	; 0x85
     c1c:	01000000 	mrseq	r0, (UNDEF: 0)
     c20:	0007f69c 	muleq	r7, ip, r6
     c24:	65722200 	ldrbvs	r2, [r2, #-512]!	; 0xfffffe00
     c28:	84010071 	strhi	r0, [r1], #-113	; 0xffffff8f
     c2c:	00038720 	andeq	r8, r3, r0, lsr #14
     c30:	74910200 	ldrvc	r0, [r1], #512	; 0x200
     c34:	00060d1e 	andeq	r0, r6, lr, lsl sp
     c38:	0e850100 	rmfeqs	f0, f5, f0
     c3c:	0000004d 	andeq	r0, r0, sp, asr #32
     c40:	00709102 	rsbseq	r9, r0, r2, lsl #2
     c44:	000ef821 	andeq	pc, lr, r1, lsr #16
     c48:	0a760100 	beq	1d81050 <__bss_end+0x1d78230>
     c4c:	000008b4 			; <UNDEFINED> instruction: 0x000008b4
     c50:	0000004d 	andeq	r0, r0, sp, asr #32
     c54:	00008530 	andeq	r8, r0, r0, lsr r5
     c58:	0000003c 	andeq	r0, r0, ip, lsr r0
     c5c:	08339c01 	ldmdaeq	r3!, {r0, sl, fp, ip, pc}
     c60:	72220000 	eorvc	r0, r2, #0
     c64:	01007165 	tsteq	r0, r5, ror #2
     c68:	03872078 	orreq	r2, r7, #120	; 0x78
     c6c:	91020000 	mrsls	r0, (UNDEF: 2)
     c70:	060d1e74 			; <UNDEFINED> instruction: 0x060d1e74
     c74:	79010000 	stmdbvc	r1, {}	; <UNPREDICTABLE>
     c78:	00004d0e 	andeq	r4, r0, lr, lsl #26
     c7c:	70910200 	addsvc	r0, r1, r0, lsl #4
     c80:	093d2100 	ldmdbeq	sp!, {r8, sp}
     c84:	6a010000 	bvs	40c8c <__bss_end+0x37e6c>
     c88:	000bc006 	andeq	ip, fp, r6
     c8c:	0001f000 	andeq	pc, r1, r0
     c90:	0084dc00 	addeq	sp, r4, r0, lsl #24
     c94:	00005400 	andeq	r5, r0, r0, lsl #8
     c98:	7f9c0100 	svcvc	0x009c0100
     c9c:	20000008 	andcs	r0, r0, r8
     ca0:	00000a24 	andeq	r0, r0, r4, lsr #20
     ca4:	4d156a01 	vldrmi	s12, [r5, #-4]
     ca8:	02000000 	andeq	r0, r0, #0
     cac:	20206c91 	mlacs	r0, r1, ip, r6
     cb0:	01000008 	tsteq	r0, r8
     cb4:	004d256a 	subeq	r2, sp, sl, ror #10
     cb8:	91020000 	mrsls	r0, (UNDEF: 2)
     cbc:	0ef01e68 	cdpeq	14, 15, cr1, cr0, cr8, {3}
     cc0:	6c010000 	stcvs	0, cr0, [r1], {-0}
     cc4:	00004d0e 	andeq	r4, r0, lr, lsl #26
     cc8:	74910200 	ldrvc	r0, [r1], #512	; 0x200
     ccc:	06e32100 	strbteq	r2, [r3], r0, lsl #2
     cd0:	5d010000 	stcpl	0, cr0, [r1, #-0]
     cd4:	000c3412 	andeq	r3, ip, r2, lsl r4
     cd8:	00008b00 	andeq	r8, r0, r0, lsl #22
     cdc:	00848c00 	addeq	r8, r4, r0, lsl #24
     ce0:	00005000 	andeq	r5, r0, r0
     ce4:	da9c0100 	ble	fe7010ec <__bss_end+0xfe6f82cc>
     ce8:	20000008 	andcs	r0, r0, r8
     cec:	00000bcb 	andeq	r0, r0, fp, asr #23
     cf0:	4d205d01 	stcmi	13, cr5, [r0, #-4]!
     cf4:	02000000 	andeq	r0, r0, #0
     cf8:	67206c91 			; <UNDEFINED> instruction: 0x67206c91
     cfc:	0100000a 	tsteq	r0, sl
     d00:	004d2f5d 	subeq	r2, sp, sp, asr pc
     d04:	91020000 	mrsls	r0, (UNDEF: 2)
     d08:	08202068 	stmdaeq	r0!, {r3, r5, r6, sp}
     d0c:	5d010000 	stcpl	0, cr0, [r1, #-0]
     d10:	00004d3f 	andeq	r4, r0, pc, lsr sp
     d14:	64910200 	ldrvs	r0, [r1], #512	; 0x200
     d18:	000ef01e 	andeq	pc, lr, lr, lsl r0	; <UNPREDICTABLE>
     d1c:	165f0100 	ldrbne	r0, [pc], -r0, lsl #2
     d20:	0000008b 	andeq	r0, r0, fp, lsl #1
     d24:	00749102 	rsbseq	r9, r4, r2, lsl #2
     d28:	000c7d21 	andeq	r7, ip, r1, lsr #26
     d2c:	0a510100 	beq	1441134 <__bss_end+0x1438314>
     d30:	000006ee 	andeq	r0, r0, lr, ror #13
     d34:	0000004d 	andeq	r0, r0, sp, asr #32
     d38:	00008448 	andeq	r8, r0, r8, asr #8
     d3c:	00000044 	andeq	r0, r0, r4, asr #32
     d40:	09269c01 	stmdbeq	r6!, {r0, sl, fp, ip, pc}
     d44:	cb200000 	blgt	800d4c <__bss_end+0x7f7f2c>
     d48:	0100000b 	tsteq	r0, fp
     d4c:	004d1a51 	subeq	r1, sp, r1, asr sl
     d50:	91020000 	mrsls	r0, (UNDEF: 2)
     d54:	0a67206c 	beq	19c8f0c <__bss_end+0x19c00ec>
     d58:	51010000 	mrspl	r0, (UNDEF: 1)
     d5c:	00004d29 	andeq	r4, r0, r9, lsr #26
     d60:	68910200 	ldmvs	r1, {r9}
     d64:	000c631e 	andeq	r6, ip, lr, lsl r3
     d68:	0e530100 	rdfeqs	f0, f3, f0
     d6c:	0000004d 	andeq	r0, r0, sp, asr #32
     d70:	00749102 	rsbseq	r9, r4, r2, lsl #2
     d74:	000c5d21 	andeq	r5, ip, r1, lsr #26
     d78:	0a440100 	beq	1101180 <__bss_end+0x10f8360>
     d7c:	00000c3f 	andeq	r0, r0, pc, lsr ip
     d80:	0000004d 	andeq	r0, r0, sp, asr #32
     d84:	000083f8 	strdeq	r8, [r0], -r8	; <UNPREDICTABLE>
     d88:	00000050 	andeq	r0, r0, r0, asr r0
     d8c:	09819c01 	stmibeq	r1, {r0, sl, fp, ip, pc}
     d90:	cb200000 	blgt	800d98 <__bss_end+0x7f7f78>
     d94:	0100000b 	tsteq	r0, fp
     d98:	004d1944 	subeq	r1, sp, r4, asr #18
     d9c:	91020000 	mrsls	r0, (UNDEF: 2)
     da0:	098f206c 	stmibeq	pc, {r2, r3, r5, r6, sp}	; <UNPREDICTABLE>
     da4:	44010000 	strmi	r0, [r1], #-0
     da8:	00011d30 	andeq	r1, r1, r0, lsr sp
     dac:	68910200 	ldmvs	r1, {r9}
     db0:	000a7420 	andeq	r7, sl, r0, lsr #8
     db4:	41440100 	mrsmi	r0, (UNDEF: 84)
     db8:	000006ac 	andeq	r0, r0, ip, lsr #13
     dbc:	1e649102 	lgnnes	f1, f2
     dc0:	00000ef0 	strdeq	r0, [r0], -r0	; <UNPREDICTABLE>
     dc4:	4d0e4601 	stcmi	6, cr4, [lr, #-4]
     dc8:	02000000 	andeq	r0, r0, #0
     dcc:	23007491 	movwcs	r7, #1169	; 0x491
     dd0:	000005e2 	andeq	r0, r0, r2, ror #11
     dd4:	99063e01 	stmdbls	r6, {r0, r9, sl, fp, ip, sp}
     dd8:	cc000009 	stcgt	0, cr0, [r0], {9}
     ddc:	2c000083 	stccs	0, cr0, [r0], {131}	; 0x83
     de0:	01000000 	mrseq	r0, (UNDEF: 0)
     de4:	0009ab9c 	muleq	r9, ip, fp
     de8:	0bcb2000 	bleq	ff2c8df0 <__bss_end+0xff2bffd0>
     dec:	3e010000 	cdpcc	0, 0, cr0, cr1, cr0, {0}
     df0:	00004d15 	andeq	r4, r0, r5, lsl sp
     df4:	74910200 	ldrvc	r0, [r1], #512	; 0x200
     df8:	0a142100 	beq	509200 <__bss_end+0x5003e0>
     dfc:	31010000 	mrscc	r0, (UNDEF: 1)
     e00:	000a7a0a 	andeq	r7, sl, sl, lsl #20
     e04:	00004d00 	andeq	r4, r0, r0, lsl #26
     e08:	00837c00 	addeq	r7, r3, r0, lsl #24
     e0c:	00005000 	andeq	r5, r0, r0
     e10:	069c0100 	ldreq	r0, [ip], r0, lsl #2
     e14:	2000000a 	andcs	r0, r0, sl
     e18:	00000bcb 	andeq	r0, r0, fp, asr #23
     e1c:	4d193101 	ldfmis	f3, [r9, #-4]
     e20:	02000000 	andeq	r0, r0, #0
     e24:	a9206c91 	stmdbge	r0!, {r0, r4, r7, sl, fp, sp, lr}
     e28:	0100000c 	tsteq	r0, ip
     e2c:	01f72b31 	mvnseq	r2, r1, lsr fp
     e30:	91020000 	mrsls	r0, (UNDEF: 2)
     e34:	0aa72068 	beq	fe9c8fdc <__bss_end+0xfe9c01bc>
     e38:	31010000 	mrscc	r0, (UNDEF: 1)
     e3c:	00004d3c 	andeq	r4, r0, ip, lsr sp
     e40:	64910200 	ldrvs	r0, [r1], #512	; 0x200
     e44:	000c2e1e 	andeq	r2, ip, lr, lsl lr
     e48:	0e330100 	rsfeqs	f0, f3, f0
     e4c:	0000004d 	andeq	r0, r0, sp, asr #32
     e50:	00749102 	rsbseq	r9, r4, r2, lsl #2
     e54:	000f3021 	andeq	r3, pc, r1, lsr #32
     e58:	0a240100 	beq	901260 <__bss_end+0x8f8440>
     e5c:	00000d29 	andeq	r0, r0, r9, lsr #26
     e60:	0000004d 	andeq	r0, r0, sp, asr #32
     e64:	0000832c 	andeq	r8, r0, ip, lsr #6
     e68:	00000050 	andeq	r0, r0, r0, asr r0
     e6c:	0a619c01 	beq	1867e78 <__bss_end+0x185f058>
     e70:	cb200000 	blgt	800e78 <__bss_end+0x7f8058>
     e74:	0100000b 	tsteq	r0, fp
     e78:	004d1824 	subeq	r1, sp, r4, lsr #16
     e7c:	91020000 	mrsls	r0, (UNDEF: 2)
     e80:	0ca9206c 	stceq	0, cr2, [r9], #432	; 0x1b0
     e84:	24010000 	strcs	r0, [r1], #-0
     e88:	000a672a 	andeq	r6, sl, sl, lsr #14
     e8c:	68910200 	ldmvs	r1, {r9}
     e90:	000aa720 	andeq	sl, sl, r0, lsr #14
     e94:	3b240100 	blcc	90129c <__bss_end+0x8f847c>
     e98:	0000004d 	andeq	r0, r0, sp, asr #32
     e9c:	1e649102 	lgnnes	f1, f2
     ea0:	0000065f 	andeq	r0, r0, pc, asr r6
     ea4:	4d0e2601 	stcmi	6, cr2, [lr, #-4]
     ea8:	02000000 	andeq	r0, r0, #0
     eac:	0d007491 	cfstrseq	mvf7, [r0, #-580]	; 0xfffffdbc
     eb0:	00002504 	andeq	r2, r0, r4, lsl #10
     eb4:	0a610300 	beq	1841abc <__bss_end+0x1838c9c>
     eb8:	38210000 	stmdacc	r1!, {}	; <UNPREDICTABLE>
     ebc:	0100000a 	tsteq	r0, sl
     ec0:	0f420a19 	svceq	0x00420a19
     ec4:	004d0000 	subeq	r0, sp, r0
     ec8:	82e80000 	rschi	r0, r8, #0
     ecc:	00440000 	subeq	r0, r4, r0
     ed0:	9c010000 	stcls	0, cr0, [r1], {-0}
     ed4:	00000ab8 			; <UNDEFINED> instruction: 0x00000ab8
     ed8:	000f1120 	andeq	r1, pc, r0, lsr #2
     edc:	1b190100 	blne	6412e4 <__bss_end+0x6384c4>
     ee0:	000001f7 	strdeq	r0, [r0], -r7
     ee4:	206c9102 	rsbcs	r9, ip, r2, lsl #2
     ee8:	00000c8e 	andeq	r0, r0, lr, lsl #25
     eec:	c6351901 	ldrtgt	r1, [r5], -r1, lsl #18
     ef0:	02000001 	andeq	r0, r0, #1
     ef4:	cb1e6891 	blgt	79b140 <__bss_end+0x792320>
     ef8:	0100000b 	tsteq	r0, fp
     efc:	004d0e1b 	subeq	r0, sp, fp, lsl lr
     f00:	91020000 	mrsls	r0, (UNDEF: 2)
     f04:	94240074 	strtls	r0, [r4], #-116	; 0xffffff8c
     f08:	01000008 	tsteq	r0, r8
     f0c:	067d0614 			; <UNDEFINED> instruction: 0x067d0614
     f10:	82cc0000 	sbchi	r0, ip, #0
     f14:	001c0000 	andseq	r0, ip, r0
     f18:	9c010000 	stcls	0, cr0, [r1], {-0}
     f1c:	000c8423 	andeq	r8, ip, r3, lsr #8
     f20:	060e0100 	streq	r0, [lr], -r0, lsl #2
     f24:	0000096d 	andeq	r0, r0, sp, ror #18
     f28:	000082a0 	andeq	r8, r0, r0, lsr #5
     f2c:	0000002c 	andeq	r0, r0, ip, lsr #32
     f30:	0af89c01 	beq	ffe27f3c <__bss_end+0xffe1f11c>
     f34:	e1200000 			; <UNDEFINED> instruction: 0xe1200000
     f38:	01000007 	tsteq	r0, r7
     f3c:	0038140e 	eorseq	r1, r8, lr, lsl #8
     f40:	91020000 	mrsls	r0, (UNDEF: 2)
     f44:	3b250074 	blcc	94111c <__bss_end+0x9382fc>
     f48:	0100000f 	tsteq	r0, pc
     f4c:	09ca0a04 	stmibeq	sl, {r2, r9, fp}^
     f50:	004d0000 	subeq	r0, sp, r0
     f54:	82740000 	rsbshi	r0, r4, #0
     f58:	002c0000 	eoreq	r0, ip, r0
     f5c:	9c010000 	stcls	0, cr0, [r1], {-0}
     f60:	64697022 	strbtvs	r7, [r9], #-34	; 0xffffffde
     f64:	0e060100 	adfeqs	f0, f6, f0
     f68:	0000004d 	andeq	r0, r0, sp, asr #32
     f6c:	00749102 	rsbseq	r9, r4, r2, lsl #2
     f70:	00032e00 	andeq	r2, r3, r0, lsl #28
     f74:	d2000400 	andle	r0, r0, #0, 8
     f78:	04000004 	streq	r0, [r0], #-4
     f7c:	000d4d01 	andeq	r4, sp, r1, lsl #26
     f80:	0fbd0400 	svceq	0x00bd0400
     f84:	05630000 	strbeq	r0, [r3, #-0]!
     f88:	86d00000 	ldrbhi	r0, [r0], r0
     f8c:	04b80000 	ldrteq	r0, [r8], #0
     f90:	07410000 	strbeq	r0, [r1, -r0]
     f94:	49020000 	stmdbmi	r2, {}	; <UNPREDICTABLE>
     f98:	03000000 	movweq	r0, #0
     f9c:	00001026 	andeq	r1, r0, r6, lsr #32
     fa0:	61100501 	tstvs	r0, r1, lsl #10
     fa4:	11000000 	mrsne	r0, (UNDEF: 0)
     fa8:	33323130 	teqcc	r2, #48, 2
     fac:	37363534 			; <UNDEFINED> instruction: 0x37363534
     fb0:	42413938 	submi	r3, r1, #56, 18	; 0xe0000
     fb4:	46454443 	strbmi	r4, [r5], -r3, asr #8
     fb8:	01040000 	mrseq	r0, (UNDEF: 4)
     fbc:	00250103 	eoreq	r0, r5, r3, lsl #2
     fc0:	74050000 	strvc	r0, [r5], #-0
     fc4:	61000000 	mrsvs	r0, (UNDEF: 0)
     fc8:	06000000 	streq	r0, [r0], -r0
     fcc:	00000066 	andeq	r0, r0, r6, rrx
     fd0:	51070010 	tstpl	r7, r0, lsl r0
     fd4:	08000000 	stmdaeq	r0, {}	; <UNPREDICTABLE>
     fd8:	04220704 	strteq	r0, [r2], #-1796	; 0xfffff8fc
     fdc:	01080000 	mrseq	r0, (UNDEF: 8)
     fe0:	00047c08 	andeq	r7, r4, r8, lsl #24
     fe4:	006d0700 	rsbeq	r0, sp, r0, lsl #14
     fe8:	2a090000 	bcs	240ff0 <__bss_end+0x2381d0>
     fec:	0a000000 	beq	ff4 <shift+0xff4>
     ff0:	00001055 	andeq	r1, r0, r5, asr r0
     ff4:	40066401 	andmi	r6, r6, r1, lsl #8
     ff8:	08000010 	stmdaeq	r0, {r4}
     ffc:	8000008b 	andhi	r0, r0, fp, lsl #1
    1000:	01000000 	mrseq	r0, (UNDEF: 0)
    1004:	0000fb9c 	muleq	r0, ip, fp
    1008:	72730b00 	rsbsvc	r0, r3, #0, 22
    100c:	64010063 	strvs	r0, [r1], #-99	; 0xffffff9d
    1010:	0000fb19 	andeq	pc, r0, r9, lsl fp	; <UNPREDICTABLE>
    1014:	64910200 	ldrvs	r0, [r1], #512	; 0x200
    1018:	7473640b 	ldrbtvc	r6, [r3], #-1035	; 0xfffffbf5
    101c:	24640100 	strbtcs	r0, [r4], #-256	; 0xffffff00
    1020:	00000102 	andeq	r0, r0, r2, lsl #2
    1024:	0b609102 	bleq	1825434 <__bss_end+0x181c614>
    1028:	006d756e 	rsbeq	r7, sp, lr, ror #10
    102c:	042d6401 	strteq	r6, [sp], #-1025	; 0xfffffbff
    1030:	02000001 	andeq	r0, r0, #1
    1034:	af0c5c91 	svcge	0x000c5c91
    1038:	01000010 	tsteq	r0, r0, lsl r0
    103c:	010b0e66 	tsteq	fp, r6, ror #28
    1040:	91020000 	mrsls	r0, (UNDEF: 2)
    1044:	10320c70 	eorsne	r0, r2, r0, ror ip
    1048:	67010000 	strvs	r0, [r1, -r0]
    104c:	00011108 	andeq	r1, r1, r8, lsl #2
    1050:	6c910200 	lfmvs	f0, 4, [r1], {0}
    1054:	008b300d 	addeq	r3, fp, sp
    1058:	00004800 	andeq	r4, r0, r0, lsl #16
    105c:	00690e00 	rsbeq	r0, r9, r0, lsl #28
    1060:	040b6901 	streq	r6, [fp], #-2305	; 0xfffff6ff
    1064:	02000001 	andeq	r0, r0, #1
    1068:	00007491 	muleq	r0, r1, r4
    106c:	0101040f 	tsteq	r1, pc, lsl #8
    1070:	11100000 	tstne	r0, r0
    1074:	05041204 	streq	r1, [r4, #-516]	; 0xfffffdfc
    1078:	00746e69 	rsbseq	r6, r4, r9, ror #28
    107c:	0074040f 	rsbseq	r0, r4, pc, lsl #8
    1080:	040f0000 	streq	r0, [pc], #-0	; 1088 <shift+0x1088>
    1084:	0000006d 	andeq	r0, r0, sp, rrx
    1088:	000fa40a 	andeq	sl, pc, sl, lsl #8
    108c:	065c0100 	ldrbeq	r0, [ip], -r0, lsl #2
    1090:	00000fb1 			; <UNDEFINED> instruction: 0x00000fb1
    1094:	00008aa0 	andeq	r8, r0, r0, lsr #21
    1098:	00000068 	andeq	r0, r0, r8, rrx
    109c:	01769c01 	cmneq	r6, r1, lsl #24
    10a0:	a8130000 	ldmdage	r3, {}	; <UNPREDICTABLE>
    10a4:	01000010 	tsteq	r0, r0, lsl r0
    10a8:	0102125c 	tsteq	r2, ip, asr r2
    10ac:	91020000 	mrsls	r0, (UNDEF: 2)
    10b0:	0faa136c 	svceq	0x00aa136c
    10b4:	5c010000 	stcpl	0, cr0, [r1], {-0}
    10b8:	0001041e 	andeq	r0, r1, lr, lsl r4
    10bc:	68910200 	ldmvs	r1, {r9}
    10c0:	6d656d0e 	stclvs	13, cr6, [r5, #-56]!	; 0xffffffc8
    10c4:	085e0100 	ldmdaeq	lr, {r8}^
    10c8:	00000111 	andeq	r0, r0, r1, lsl r1
    10cc:	0d709102 	ldfeqp	f1, [r0, #-8]!
    10d0:	00008abc 			; <UNDEFINED> instruction: 0x00008abc
    10d4:	0000003c 	andeq	r0, r0, ip, lsr r0
    10d8:	0100690e 	tsteq	r0, lr, lsl #18
    10dc:	01040b60 	tsteq	r4, r0, ror #22
    10e0:	91020000 	mrsls	r0, (UNDEF: 2)
    10e4:	14000074 	strne	r0, [r0], #-116	; 0xffffff8c
    10e8:	0000105c 	andeq	r1, r0, ip, asr r0
    10ec:	75055201 	strvc	r5, [r5, #-513]	; 0xfffffdff
    10f0:	04000010 	streq	r0, [r0], #-16
    10f4:	4c000001 	stcmi	0, cr0, [r0], {1}
    10f8:	5400008a 	strpl	r0, [r0], #-138	; 0xffffff76
    10fc:	01000000 	mrseq	r0, (UNDEF: 0)
    1100:	0001af9c 	muleq	r1, ip, pc	; <UNPREDICTABLE>
    1104:	00730b00 	rsbseq	r0, r3, r0, lsl #22
    1108:	0b185201 	bleq	615914 <__bss_end+0x60caf4>
    110c:	02000001 	andeq	r0, r0, #1
    1110:	690e6c91 	stmdbvs	lr, {r0, r4, r7, sl, fp, sp, lr}
    1114:	06540100 	ldrbeq	r0, [r4], -r0, lsl #2
    1118:	00000104 	andeq	r0, r0, r4, lsl #2
    111c:	00749102 	rsbseq	r9, r4, r2, lsl #2
    1120:	00109814 	andseq	r9, r0, r4, lsl r8
    1124:	05420100 	strbeq	r0, [r2, #-256]	; 0xffffff00
    1128:	00001063 	andeq	r1, r0, r3, rrx
    112c:	00000104 	andeq	r0, r0, r4, lsl #2
    1130:	000089a0 	andeq	r8, r0, r0, lsr #19
    1134:	000000ac 	andeq	r0, r0, ip, lsr #1
    1138:	02159c01 	andseq	r9, r5, #256	; 0x100
    113c:	730b0000 	movwvc	r0, #45056	; 0xb000
    1140:	42010031 	andmi	r0, r1, #49	; 0x31
    1144:	00010b19 	andeq	r0, r1, r9, lsl fp
    1148:	6c910200 	lfmvs	f0, 4, [r1], {0}
    114c:	0032730b 	eorseq	r7, r2, fp, lsl #6
    1150:	0b294201 	bleq	a5195c <__bss_end+0xa48b3c>
    1154:	02000001 	andeq	r0, r0, #1
    1158:	6e0b6891 	mcrvs	8, 0, r6, cr11, cr1, {4}
    115c:	01006d75 	tsteq	r0, r5, ror sp
    1160:	01043142 	tsteq	r4, r2, asr #2
    1164:	91020000 	mrsls	r0, (UNDEF: 2)
    1168:	31750e64 	cmncc	r5, r4, ror #28
    116c:	10440100 	subne	r0, r4, r0, lsl #2
    1170:	00000215 	andeq	r0, r0, r5, lsl r2
    1174:	0e779102 	expeqs	f1, f2
    1178:	01003275 	tsteq	r0, r5, ror r2
    117c:	02151444 	andseq	r1, r5, #68, 8	; 0x44000000
    1180:	91020000 	mrsls	r0, (UNDEF: 2)
    1184:	01080076 	tsteq	r8, r6, ror r0
    1188:	00047308 	andeq	r7, r4, r8, lsl #6
    118c:	10a01400 	adcne	r1, r0, r0, lsl #8
    1190:	36010000 	strcc	r0, [r1], -r0
    1194:	00108707 	andseq	r8, r0, r7, lsl #14
    1198:	00011100 	andeq	r1, r1, r0, lsl #2
    119c:	0088e000 	addeq	lr, r8, r0
    11a0:	0000c000 	andeq	ip, r0, r0
    11a4:	759c0100 	ldrvc	r0, [ip, #256]	; 0x100
    11a8:	13000002 	movwne	r0, #2
    11ac:	00000f9f 	muleq	r0, pc, pc	; <UNPREDICTABLE>
    11b0:	11153601 	tstne	r5, r1, lsl #12
    11b4:	02000001 	andeq	r0, r0, #1
    11b8:	730b6c91 	movwvc	r6, #48273	; 0xbc91
    11bc:	01006372 	tsteq	r0, r2, ror r3
    11c0:	010b2736 	tsteq	fp, r6, lsr r7
    11c4:	91020000 	mrsls	r0, (UNDEF: 2)
    11c8:	756e0b68 	strbvc	r0, [lr, #-2920]!	; 0xfffff498
    11cc:	3601006d 	strcc	r0, [r1], -sp, rrx
    11d0:	00010430 	andeq	r0, r1, r0, lsr r4
    11d4:	64910200 	ldrvs	r0, [r1], #512	; 0x200
    11d8:	0100690e 	tsteq	r0, lr, lsl #18
    11dc:	01040638 	tsteq	r4, r8, lsr r6
    11e0:	91020000 	mrsls	r0, (UNDEF: 2)
    11e4:	82140074 	andshi	r0, r4, #116	; 0x74
    11e8:	01000010 	tsteq	r0, r0, lsl r0
    11ec:	101b0524 	andsne	r0, fp, r4, lsr #10
    11f0:	01040000 	mrseq	r0, (UNDEF: 4)
    11f4:	88440000 	stmdahi	r4, {}^	; <UNPREDICTABLE>
    11f8:	009c0000 	addseq	r0, ip, r0
    11fc:	9c010000 	stcls	0, cr0, [r1], {-0}
    1200:	000002b2 			; <UNDEFINED> instruction: 0x000002b2
    1204:	000f9913 	andeq	r9, pc, r3, lsl r9	; <UNPREDICTABLE>
    1208:	16240100 	strtne	r0, [r4], -r0, lsl #2
    120c:	0000010b 	andeq	r0, r0, fp, lsl #2
    1210:	0c6c9102 	stfeqp	f1, [ip], #-8
    1214:	00001039 	andeq	r1, r0, r9, lsr r0
    1218:	04062601 	streq	r2, [r6], #-1537	; 0xfffff9ff
    121c:	02000001 	andeq	r0, r0, #1
    1220:	15007491 	strne	r7, [r0, #-1169]	; 0xfffffb6f
    1224:	000010b6 	strheq	r1, [r0], -r6
    1228:	bb060801 	bllt	183234 <__bss_end+0x17a414>
    122c:	d0000010 	andle	r0, r0, r0, lsl r0
    1230:	74000086 	strvc	r0, [r0], #-134	; 0xffffff7a
    1234:	01000001 	tsteq	r0, r1
    1238:	0f99139c 	svceq	0x0099139c
    123c:	08010000 	stmdaeq	r1, {}	; <UNPREDICTABLE>
    1240:	00006618 	andeq	r6, r0, r8, lsl r6
    1244:	64910200 	ldrvs	r0, [r1], #512	; 0x200
    1248:	00103913 	andseq	r3, r0, r3, lsl r9
    124c:	25080100 	strcs	r0, [r8, #-256]	; 0xffffff00
    1250:	00000111 	andeq	r0, r0, r1, lsl r1
    1254:	13609102 	cmnne	r0, #-2147483648	; 0x80000000
    1258:	00001050 	andeq	r1, r0, r0, asr r0
    125c:	663a0801 	ldrtvs	r0, [sl], -r1, lsl #16
    1260:	02000000 	andeq	r0, r0, #0
    1264:	690e5c91 	stmdbvs	lr, {r0, r4, r7, sl, fp, ip, lr}
    1268:	060a0100 	streq	r0, [sl], -r0, lsl #2
    126c:	00000104 	andeq	r0, r0, r4, lsl #2
    1270:	0d749102 	ldfeqp	f1, [r4, #-8]!
    1274:	0000879c 	muleq	r0, ip, r7
    1278:	00000098 	muleq	r0, r8, r0
    127c:	01006a0e 	tsteq	r0, lr, lsl #20
    1280:	01040b1c 	tsteq	r4, ip, lsl fp
    1284:	91020000 	mrsls	r0, (UNDEF: 2)
    1288:	87c40d70 			; <UNDEFINED> instruction: 0x87c40d70
    128c:	00600000 	rsbeq	r0, r0, r0
    1290:	630e0000 	movwvs	r0, #57344	; 0xe000
    1294:	081e0100 	ldmdaeq	lr, {r8}
    1298:	0000006d 	andeq	r0, r0, sp, rrx
    129c:	006f9102 	rsbeq	r9, pc, r2, lsl #2
    12a0:	Address 0x00000000000012a0 is out of bounds.


Disassembly of section .debug_abbrev:

00000000 <.debug_abbrev>:
   0:	10001101 	andne	r1, r0, r1, lsl #2
   4:	12011106 	andne	r1, r1, #-2147483647	; 0x80000001
   8:	1b0e0301 	blne	380c14 <__bss_end+0x377df4>
   c:	130e250e 	movwne	r2, #58638	; 0xe50e
  10:	00000005 	andeq	r0, r0, r5
  14:	25011101 	strcs	r1, [r1, #-257]	; 0xfffffeff
  18:	030b130e 	movweq	r1, #45838	; 0xb30e
  1c:	110e1b0e 	tstne	lr, lr, lsl #22
  20:	10061201 	andne	r1, r6, r1, lsl #4
  24:	02000017 	andeq	r0, r0, #23
  28:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
  2c:	0b3b0b3a 	bleq	ec2d1c <__bss_end+0xeb9efc>
  30:	13490b39 	movtne	r0, #39737	; 0x9b39
  34:	193c193f 	ldmdbne	ip!, {r0, r1, r2, r3, r4, r5, r8, fp, ip}
  38:	24030000 	strcs	r0, [r3], #-0
  3c:	3e0b0b00 	vmlacc.f64	d0, d11, d0
  40:	000e030b 	andeq	r0, lr, fp, lsl #6
  44:	012e0400 			; <UNDEFINED> instruction: 0x012e0400
  48:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
  4c:	0b3b0b3a 	bleq	ec2d3c <__bss_end+0xeb9f1c>
  50:	01110b39 	tsteq	r1, r9, lsr fp
  54:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
  58:	01194296 			; <UNDEFINED> instruction: 0x01194296
  5c:	05000013 	streq	r0, [r0, #-19]	; 0xffffffed
  60:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
  64:	0b3b0b3a 	bleq	ec2d54 <__bss_end+0xeb9f34>
  68:	13490b39 	movtne	r0, #39737	; 0x9b39
  6c:	00001802 	andeq	r1, r0, r2, lsl #16
  70:	0b002406 	bleq	9090 <__bss_end+0x270>
  74:	030b3e0b 	movweq	r3, #48651	; 0xbe0b
  78:	07000008 	streq	r0, [r0, -r8]
  7c:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
  80:	0b3a0e03 	bleq	e83894 <__bss_end+0xe7aa74>
  84:	0b390b3b 	bleq	e42d78 <__bss_end+0xe39f58>
  88:	06120111 			; <UNDEFINED> instruction: 0x06120111
  8c:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
  90:	00130119 	andseq	r0, r3, r9, lsl r1
  94:	010b0800 	tsteq	fp, r0, lsl #16
  98:	06120111 			; <UNDEFINED> instruction: 0x06120111
  9c:	34090000 	strcc	r0, [r9], #-0
  a0:	3a080300 	bcc	200ca8 <__bss_end+0x1f7e88>
  a4:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
  a8:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
  ac:	0a000018 	beq	114 <shift+0x114>
  b0:	0b0b000f 	bleq	2c00f4 <__bss_end+0x2b72d4>
  b4:	00001349 	andeq	r1, r0, r9, asr #6
  b8:	01110100 	tsteq	r1, r0, lsl #2
  bc:	0b130e25 	bleq	4c3958 <__bss_end+0x4bab38>
  c0:	0e1b0e03 	cdpeq	14, 1, cr0, cr11, cr3, {0}
  c4:	06120111 			; <UNDEFINED> instruction: 0x06120111
  c8:	00001710 	andeq	r1, r0, r0, lsl r7
  cc:	03001602 	movweq	r1, #1538	; 0x602
  d0:	3b0b3a0e 	blcc	2ce910 <__bss_end+0x2c5af0>
  d4:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
  d8:	03000013 	movweq	r0, #19
  dc:	0b0b000f 	bleq	2c0120 <__bss_end+0x2b7300>
  e0:	00001349 	andeq	r1, r0, r9, asr #6
  e4:	00001504 	andeq	r1, r0, r4, lsl #10
  e8:	01010500 	tsteq	r1, r0, lsl #10
  ec:	13011349 	movwne	r1, #4937	; 0x1349
  f0:	21060000 	mrscs	r0, (UNDEF: 6)
  f4:	2f134900 	svccs	0x00134900
  f8:	07000006 	streq	r0, [r0, -r6]
  fc:	0b0b0024 	bleq	2c0194 <__bss_end+0x2b7374>
 100:	0e030b3e 	vmoveq.16	d3[0], r0
 104:	34080000 	strcc	r0, [r8], #-0
 108:	3a0e0300 	bcc	380d10 <__bss_end+0x377ef0>
 10c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 110:	3f13490b 	svccc	0x0013490b
 114:	00193c19 	andseq	r3, r9, r9, lsl ip
 118:	012e0900 			; <UNDEFINED> instruction: 0x012e0900
 11c:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 120:	0b3b0b3a 	bleq	ec2e10 <__bss_end+0xeb9ff0>
 124:	13490b39 	movtne	r0, #39737	; 0x9b39
 128:	06120111 			; <UNDEFINED> instruction: 0x06120111
 12c:	42961840 	addsmi	r1, r6, #64, 16	; 0x400000
 130:	00130119 	andseq	r0, r3, r9, lsl r1
 134:	00340a00 	eorseq	r0, r4, r0, lsl #20
 138:	0b3a0e03 	bleq	e8394c <__bss_end+0xe7ab2c>
 13c:	0b390b3b 	bleq	e42e30 <__bss_end+0xe3a010>
 140:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 144:	240b0000 	strcs	r0, [fp], #-0
 148:	3e0b0b00 	vmlacc.f64	d0, d11, d0
 14c:	0008030b 	andeq	r0, r8, fp, lsl #6
 150:	002e0c00 	eoreq	r0, lr, r0, lsl #24
 154:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 158:	0b3b0b3a 	bleq	ec2e48 <__bss_end+0xeba028>
 15c:	01110b39 	tsteq	r1, r9, lsr fp
 160:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 164:	00194297 	mulseq	r9, r7, r2
 168:	01390d00 	teqeq	r9, r0, lsl #26
 16c:	0b3a0e03 	bleq	e83980 <__bss_end+0xe7ab60>
 170:	13010b3b 	movwne	r0, #6971	; 0x1b3b
 174:	2e0e0000 	cdpcs	0, 0, cr0, cr14, cr0, {0}
 178:	03193f01 	tsteq	r9, #1, 30
 17c:	3b0b3a0e 	blcc	2ce9bc <__bss_end+0x2c5b9c>
 180:	3c0b390b 			; <UNDEFINED> instruction: 0x3c0b390b
 184:	00130119 	andseq	r0, r3, r9, lsl r1
 188:	00050f00 	andeq	r0, r5, r0, lsl #30
 18c:	00001349 	andeq	r1, r0, r9, asr #6
 190:	3f012e10 	svccc	0x00012e10
 194:	3a0e0319 	bcc	380e00 <__bss_end+0x377fe0>
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
 1c0:	3a080300 	bcc	200dc8 <__bss_end+0x1f7fa8>
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
 1f4:	0b0b0024 	bleq	2c028c <__bss_end+0x2b746c>
 1f8:	0e030b3e 	vmoveq.16	d3[0], r0
 1fc:	24030000 	strcs	r0, [r3], #-0
 200:	3e0b0b00 	vmlacc.f64	d0, d11, d0
 204:	0008030b 	andeq	r0, r8, fp, lsl #6
 208:	00160400 	andseq	r0, r6, r0, lsl #8
 20c:	0b3a0e03 	bleq	e83a20 <__bss_end+0xe7ac00>
 210:	0b390b3b 	bleq	e42f04 <__bss_end+0xe3a0e4>
 214:	00001349 	andeq	r1, r0, r9, asr #6
 218:	49002605 	stmdbmi	r0, {r0, r2, r9, sl, sp}
 21c:	06000013 			; <UNDEFINED> instruction: 0x06000013
 220:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 224:	0b3b0b3a 	bleq	ec2f14 <__bss_end+0xeba0f4>
 228:	13490b39 	movtne	r0, #39737	; 0x9b39
 22c:	1802196c 	stmdane	r2, {r2, r3, r5, r6, r8, fp, ip}
 230:	2e070000 	cdpcs	0, 0, cr0, cr7, cr0, {0}
 234:	03193f01 	tsteq	r9, #1, 30
 238:	3b0b3a0e 	blcc	2cea78 <__bss_end+0x2c5c58>
 23c:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 240:	12011113 	andne	r1, r1, #-1073741820	; 0xc0000004
 244:	96184006 	ldrls	r4, [r8], -r6
 248:	13011942 	movwne	r1, #6466	; 0x1942
 24c:	05080000 	streq	r0, [r8, #-0]
 250:	3a0e0300 	bcc	380e58 <__bss_end+0x378038>
 254:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 258:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 25c:	09000018 	stmdbeq	r0, {r3, r4}
 260:	0b0b000f 	bleq	2c02a4 <__bss_end+0x2b7484>
 264:	00001349 	andeq	r1, r0, r9, asr #6
 268:	01110100 	tsteq	r1, r0, lsl #2
 26c:	0b130e25 	bleq	4c3b08 <__bss_end+0x4bace8>
 270:	0e1b0e03 	cdpeq	14, 1, cr0, cr11, cr3, {0}
 274:	06120111 			; <UNDEFINED> instruction: 0x06120111
 278:	00001710 	andeq	r1, r0, r0, lsl r7
 27c:	0b002402 	bleq	928c <__bss_end+0x46c>
 280:	030b3e0b 	movweq	r3, #48651	; 0xbe0b
 284:	0300000e 	movweq	r0, #14
 288:	13490026 	movtne	r0, #36902	; 0x9026
 28c:	24040000 	strcs	r0, [r4], #-0
 290:	3e0b0b00 	vmlacc.f64	d0, d11, d0
 294:	0008030b 	andeq	r0, r8, fp, lsl #6
 298:	00160500 	andseq	r0, r6, r0, lsl #10
 29c:	0b3a0e03 	bleq	e83ab0 <__bss_end+0xe7ac90>
 2a0:	0b390b3b 	bleq	e42f94 <__bss_end+0xe3a174>
 2a4:	00001349 	andeq	r1, r0, r9, asr #6
 2a8:	03011306 	movweq	r1, #4870	; 0x1306
 2ac:	3a0b0b0e 	bcc	2c2eec <__bss_end+0x2ba0cc>
 2b0:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 2b4:	0013010b 	andseq	r0, r3, fp, lsl #2
 2b8:	000d0700 	andeq	r0, sp, r0, lsl #14
 2bc:	0b3a0803 	bleq	e822d0 <__bss_end+0xe794b0>
 2c0:	0b390b3b 	bleq	e42fb4 <__bss_end+0xe3a194>
 2c4:	0b381349 	bleq	e04ff0 <__bss_end+0xdfc1d0>
 2c8:	04080000 	streq	r0, [r8], #-0
 2cc:	6d0e0301 	stcvs	3, cr0, [lr, #-4]
 2d0:	0b0b3e19 	bleq	2cfb3c <__bss_end+0x2c6d1c>
 2d4:	3a13490b 	bcc	4d2708 <__bss_end+0x4c98e8>
 2d8:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 2dc:	0013010b 	andseq	r0, r3, fp, lsl #2
 2e0:	00280900 	eoreq	r0, r8, r0, lsl #18
 2e4:	0b1c0803 	bleq	7022f8 <__bss_end+0x6f94d8>
 2e8:	280a0000 	stmdacs	sl, {}	; <UNPREDICTABLE>
 2ec:	1c0e0300 	stcne	3, cr0, [lr], {-0}
 2f0:	0b00000b 	bleq	324 <shift+0x324>
 2f4:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 2f8:	0b3b0b3a 	bleq	ec2fe8 <__bss_end+0xeba1c8>
 2fc:	13490b39 	movtne	r0, #39737	; 0x9b39
 300:	1802196c 	stmdane	r2, {r2, r3, r5, r6, r8, fp, ip}
 304:	020c0000 	andeq	r0, ip, #0
 308:	3c0e0300 	stccc	3, cr0, [lr], {-0}
 30c:	0d000019 	stceq	0, cr0, [r0, #-100]	; 0xffffff9c
 310:	0b0b000f 	bleq	2c0354 <__bss_end+0x2b7534>
 314:	00001349 	andeq	r1, r0, r9, asr #6
 318:	03000d0e 	movweq	r0, #3342	; 0xd0e
 31c:	3b0b3a0e 	blcc	2ceb5c <__bss_end+0x2c5d3c>
 320:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 324:	000b3813 	andeq	r3, fp, r3, lsl r8
 328:	01010f00 	tsteq	r1, r0, lsl #30
 32c:	13011349 	movwne	r1, #4937	; 0x1349
 330:	21100000 	tstcs	r0, r0
 334:	2f134900 	svccs	0x00134900
 338:	1100000b 	tstne	r0, fp
 33c:	0e030102 	adfeqs	f0, f3, f2
 340:	0b3a0b0b 	bleq	e82f74 <__bss_end+0xe7a154>
 344:	0b390b3b 	bleq	e43038 <__bss_end+0xe3a218>
 348:	00001301 	andeq	r1, r0, r1, lsl #6
 34c:	3f012e12 	svccc	0x00012e12
 350:	3a0e0319 	bcc	380fbc <__bss_end+0x37819c>
 354:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 358:	3c0e6e0b 	stccc	14, cr6, [lr], {11}
 35c:	01136419 	tsteq	r3, r9, lsl r4
 360:	13000013 	movwne	r0, #19
 364:	13490005 	movtne	r0, #36869	; 0x9005
 368:	00001934 	andeq	r1, r0, r4, lsr r9
 36c:	49000514 	stmdbmi	r0, {r2, r4, r8, sl}
 370:	15000013 	strne	r0, [r0, #-19]	; 0xffffffed
 374:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 378:	0b3a0e03 	bleq	e83b8c <__bss_end+0xe7ad6c>
 37c:	0b390b3b 	bleq	e43070 <__bss_end+0xe3a250>
 380:	13490e6e 	movtne	r0, #40558	; 0x9e6e
 384:	1364193c 	cmnne	r4, #60, 18	; 0xf0000
 388:	00001301 	andeq	r1, r0, r1, lsl #6
 38c:	3f012e16 	svccc	0x00012e16
 390:	3a0e0319 	bcc	380ffc <__bss_end+0x3781dc>
 394:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 398:	490e6e0b 	stmdbmi	lr, {r0, r1, r3, r9, sl, fp, sp, lr}
 39c:	3c0b3213 	sfmcc	f3, 4, [fp], {19}
 3a0:	01136419 	tsteq	r3, r9, lsl r4
 3a4:	17000013 	smladne	r0, r3, r0, r0
 3a8:	0e03000d 	cdpeq	0, 0, cr0, cr3, cr13, {0}
 3ac:	0b3b0b3a 	bleq	ec309c <__bss_end+0xeba27c>
 3b0:	13490b39 	movtne	r0, #39737	; 0x9b39
 3b4:	0b320b38 	bleq	c8309c <__bss_end+0xc7a27c>
 3b8:	2e180000 	cdpcs	0, 1, cr0, cr8, cr0, {0}
 3bc:	03193f01 	tsteq	r9, #1, 30
 3c0:	3b0b3a0e 	blcc	2cec00 <__bss_end+0x2c5de0>
 3c4:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 3c8:	3c0b320e 	sfmcc	f3, 4, [fp], {14}
 3cc:	01136419 	tsteq	r3, r9, lsl r4
 3d0:	19000013 	stmdbne	r0, {r0, r1, r4}
 3d4:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 3d8:	0b3a0e03 	bleq	e83bec <__bss_end+0xe7adcc>
 3dc:	0b390b3b 	bleq	e430d0 <__bss_end+0xe3a2b0>
 3e0:	13490e6e 	movtne	r0, #40558	; 0x9e6e
 3e4:	193c0b32 	ldmdbne	ip!, {r1, r4, r5, r8, r9, fp}
 3e8:	00001364 	andeq	r1, r0, r4, ror #6
 3ec:	4901151a 	stmdbmi	r1, {r1, r3, r4, r8, sl, ip}
 3f0:	01136413 	tsteq	r3, r3, lsl r4
 3f4:	1b000013 	blne	448 <shift+0x448>
 3f8:	131d001f 	tstne	sp, #31
 3fc:	00001349 	andeq	r1, r0, r9, asr #6
 400:	0b00101c 	bleq	4478 <shift+0x4478>
 404:	0013490b 	andseq	r4, r3, fp, lsl #18
 408:	000f1d00 	andeq	r1, pc, r0, lsl #26
 40c:	00000b0b 	andeq	r0, r0, fp, lsl #22
 410:	0300341e 	movweq	r3, #1054	; 0x41e
 414:	3b0b3a0e 	blcc	2cec54 <__bss_end+0x2c5e34>
 418:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 41c:	00180213 	andseq	r0, r8, r3, lsl r2
 420:	012e1f00 			; <UNDEFINED> instruction: 0x012e1f00
 424:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 428:	0b3b0b3a 	bleq	ec3118 <__bss_end+0xeba2f8>
 42c:	0e6e0b39 	vmoveq.8	d14[5], r0
 430:	01111349 	tsteq	r1, r9, asr #6
 434:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 438:	01194296 			; <UNDEFINED> instruction: 0x01194296
 43c:	20000013 	andcs	r0, r0, r3, lsl r0
 440:	0e030005 	cdpeq	0, 0, cr0, cr3, cr5, {0}
 444:	0b3b0b3a 	bleq	ec3134 <__bss_end+0xeba314>
 448:	13490b39 	movtne	r0, #39737	; 0x9b39
 44c:	00001802 	andeq	r1, r0, r2, lsl #16
 450:	3f012e21 	svccc	0x00012e21
 454:	3a0e0319 	bcc	3810c0 <__bss_end+0x3782a0>
 458:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 45c:	490e6e0b 	stmdbmi	lr, {r0, r1, r3, r9, sl, fp, sp, lr}
 460:	12011113 	andne	r1, r1, #-1073741820	; 0xc0000004
 464:	97184006 	ldrls	r4, [r8, -r6]
 468:	13011942 	movwne	r1, #6466	; 0x1942
 46c:	34220000 	strtcc	r0, [r2], #-0
 470:	3a080300 	bcc	201078 <__bss_end+0x1f8258>
 474:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 478:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 47c:	23000018 	movwcs	r0, #24
 480:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 484:	0b3a0e03 	bleq	e83c98 <__bss_end+0xe7ae78>
 488:	0b390b3b 	bleq	e4317c <__bss_end+0xe3a35c>
 48c:	01110e6e 	tsteq	r1, lr, ror #28
 490:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 494:	01194297 			; <UNDEFINED> instruction: 0x01194297
 498:	24000013 	strcs	r0, [r0], #-19	; 0xffffffed
 49c:	193f002e 	ldmdbne	pc!, {r1, r2, r3, r5}	; <UNPREDICTABLE>
 4a0:	0b3a0e03 	bleq	e83cb4 <__bss_end+0xe7ae94>
 4a4:	0b390b3b 	bleq	e43198 <__bss_end+0xe3a378>
 4a8:	01110e6e 	tsteq	r1, lr, ror #28
 4ac:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 4b0:	00194297 	mulseq	r9, r7, r2
 4b4:	012e2500 			; <UNDEFINED> instruction: 0x012e2500
 4b8:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 4bc:	0b3b0b3a 	bleq	ec31ac <__bss_end+0xeba38c>
 4c0:	0e6e0b39 	vmoveq.8	d14[5], r0
 4c4:	01111349 	tsteq	r1, r9, asr #6
 4c8:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 4cc:	00194297 	mulseq	r9, r7, r2
 4d0:	11010000 	mrsne	r0, (UNDEF: 1)
 4d4:	130e2501 	movwne	r2, #58625	; 0xe501
 4d8:	1b0e030b 	blne	38110c <__bss_end+0x3782ec>
 4dc:	1201110e 	andne	r1, r1, #-2147483645	; 0x80000003
 4e0:	00171006 	andseq	r1, r7, r6
 4e4:	01390200 	teqeq	r9, r0, lsl #4
 4e8:	00001301 	andeq	r1, r0, r1, lsl #6
 4ec:	03003403 	movweq	r3, #1027	; 0x403
 4f0:	3b0b3a0e 	blcc	2ced30 <__bss_end+0x2c5f10>
 4f4:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 4f8:	1c193c13 	ldcne	12, cr3, [r9], {19}
 4fc:	0400000a 	streq	r0, [r0], #-10
 500:	0b3a003a 	bleq	e805f0 <__bss_end+0xe777d0>
 504:	0b390b3b 	bleq	e431f8 <__bss_end+0xe3a3d8>
 508:	00001318 	andeq	r1, r0, r8, lsl r3
 50c:	49010105 	stmdbmi	r1, {r0, r2, r8}
 510:	00130113 	andseq	r0, r3, r3, lsl r1
 514:	00210600 	eoreq	r0, r1, r0, lsl #12
 518:	0b2f1349 	bleq	bc5244 <__bss_end+0xbbc424>
 51c:	26070000 	strcs	r0, [r7], -r0
 520:	00134900 	andseq	r4, r3, r0, lsl #18
 524:	00240800 	eoreq	r0, r4, r0, lsl #16
 528:	0b3e0b0b 	bleq	f8315c <__bss_end+0xf7a33c>
 52c:	00000e03 	andeq	r0, r0, r3, lsl #28
 530:	47003409 	strmi	r3, [r0, -r9, lsl #8]
 534:	0a000013 	beq	588 <shift+0x588>
 538:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 53c:	0b3a0e03 	bleq	e83d50 <__bss_end+0xe7af30>
 540:	0b390b3b 	bleq	e43234 <__bss_end+0xe3a414>
 544:	01110e6e 	tsteq	r1, lr, ror #28
 548:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 54c:	01194297 			; <UNDEFINED> instruction: 0x01194297
 550:	0b000013 	bleq	5a4 <shift+0x5a4>
 554:	08030005 	stmdaeq	r3, {r0, r2}
 558:	0b3b0b3a 	bleq	ec3248 <__bss_end+0xeba428>
 55c:	13490b39 	movtne	r0, #39737	; 0x9b39
 560:	00001802 	andeq	r1, r0, r2, lsl #16
 564:	0300340c 	movweq	r3, #1036	; 0x40c
 568:	3b0b3a0e 	blcc	2ceda8 <__bss_end+0x2c5f88>
 56c:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 570:	00180213 	andseq	r0, r8, r3, lsl r2
 574:	010b0d00 	tsteq	fp, r0, lsl #26
 578:	06120111 			; <UNDEFINED> instruction: 0x06120111
 57c:	340e0000 	strcc	r0, [lr], #-0
 580:	3a080300 	bcc	201188 <__bss_end+0x1f8368>
 584:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 588:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 58c:	0f000018 	svceq	0x00000018
 590:	0b0b000f 	bleq	2c05d4 <__bss_end+0x2b77b4>
 594:	00001349 	andeq	r1, r0, r9, asr #6
 598:	00002610 	andeq	r2, r0, r0, lsl r6
 59c:	000f1100 	andeq	r1, pc, r0, lsl #2
 5a0:	00000b0b 	andeq	r0, r0, fp, lsl #22
 5a4:	0b002412 	bleq	95f4 <__bss_end+0x7d4>
 5a8:	030b3e0b 	movweq	r3, #48651	; 0xbe0b
 5ac:	13000008 	movwne	r0, #8
 5b0:	0e030005 	cdpeq	0, 0, cr0, cr3, cr5, {0}
 5b4:	0b3b0b3a 	bleq	ec32a4 <__bss_end+0xeba484>
 5b8:	13490b39 	movtne	r0, #39737	; 0x9b39
 5bc:	00001802 	andeq	r1, r0, r2, lsl #16
 5c0:	3f012e14 	svccc	0x00012e14
 5c4:	3a0e0319 	bcc	381230 <__bss_end+0x378410>
 5c8:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 5cc:	490e6e0b 	stmdbmi	lr, {r0, r1, r3, r9, sl, fp, sp, lr}
 5d0:	12011113 	andne	r1, r1, #-1073741820	; 0xc0000004
 5d4:	97184006 	ldrls	r4, [r8, -r6]
 5d8:	13011942 	movwne	r1, #6466	; 0x1942
 5dc:	2e150000 	cdpcs	0, 1, cr0, cr5, cr0, {0}
 5e0:	03193f01 	tsteq	r9, #1, 30
 5e4:	3b0b3a0e 	blcc	2cee24 <__bss_end+0x2c6004>
 5e8:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 5ec:	1201110e 	andne	r1, r1, #-2147483645	; 0x80000003
 5f0:	96184006 	ldrls	r4, [r8], -r6
 5f4:	00001942 	andeq	r1, r0, r2, asr #18
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
  74:	00000048 	andeq	r0, r0, r8, asr #32
	...
  80:	0000001c 	andeq	r0, r0, ip, lsl r0
  84:	044e0002 	strbeq	r0, [lr], #-2
  88:	00040000 	andeq	r0, r4, r0
  8c:	00000000 	andeq	r0, r0, r0
  90:	00008274 	andeq	r8, r0, r4, ror r2
  94:	0000045c 	andeq	r0, r0, ip, asr r4
	...
  a0:	0000001c 	andeq	r0, r0, ip, lsl r0
  a4:	0f710002 	svceq	0x00710002
  a8:	00040000 	andeq	r0, r4, r0
  ac:	00000000 	andeq	r0, r0, r0
  b0:	000086d0 	ldrdeq	r8, [r0], -r0
  b4:	000004b8 			; <UNDEFINED> instruction: 0x000004b8
	...

Disassembly of section .debug_str:

00000000 <.debug_str>:
       0:	6573552f 	ldrbvs	r5, [r3, #-1327]!	; 0xfffffad1
       4:	772f7372 			; <UNDEFINED> instruction: 0x772f7372
       8:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
       c:	2f696a72 	svccs	0x00696a72
      10:	6b736544 	blvs	1cd9528 <__bss_end+0x1cd0708>
      14:	2f706f74 	svccs	0x00706f74
      18:	2f564146 	svccs	0x00564146
      1c:	6176614e 	cmnvs	r6, lr, asr #2
      20:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
      24:	4f2f6963 	svcmi	0x002f6963
      28:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
      2c:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
      30:	6b6c6172 	blvs	1b18600 <__bss_end+0x1b0f7e0>
      34:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
      38:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
      3c:	756f732f 	strbvc	r7, [pc, #-815]!	; fffffd15 <__bss_end+0xffff6ef5>
      40:	73656372 	cmnvc	r5, #-939524095	; 0xc8000001
      44:	6573752f 	ldrbvs	r7, [r3, #-1327]!	; 0xfffffad1
      48:	61707372 	cmnvs	r0, r2, ror r3
      4c:	632f6563 			; <UNDEFINED> instruction: 0x632f6563
      50:	2e307472 	mrccs	4, 1, r7, cr0, cr2, {3}
      54:	552f0073 	strpl	r0, [pc, #-115]!	; ffffffe9 <__bss_end+0xffff71c9>
      58:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
      5c:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
      60:	6a726574 	bvs	1c99638 <__bss_end+0x1c90818>
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
      98:	752f7365 	strvc	r7, [pc, #-869]!	; fffffd3b <__bss_end+0xffff6f1b>
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
     12c:	6a363731 	bvs	d8ddf8 <__bss_end+0xd84fd8>
     130:	732d667a 			; <UNDEFINED> instruction: 0x732d667a
     134:	616d2d20 	cmnvs	sp, r0, lsr #26
     138:	2d206d72 	stccs	13, cr6, [r0, #-456]!	; 0xfffffe38
     13c:	6372616d 	cmnvs	r2, #1073741851	; 0x4000001b
     140:	72613d68 	rsbvc	r3, r1, #104, 26	; 0x1a00
     144:	7a36766d 	bvc	d9db00 <__bss_end+0xd94ce0>
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
     184:	6a757a61 	bvs	1d5eb10 <__bss_end+0x1d55cf0>
     188:	2f696369 	svccs	0x00696369
     18c:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
     190:	73656d65 	cmnvc	r5, #6464	; 0x1940
     194:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
     198:	6b2d616b 	blvs	b5874c <__bss_end+0xb4f92c>
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
     1e4:	2b2b4320 	blcs	ad0e6c <__bss_end+0xac804c>
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
     260:	2b6b7a36 	blcs	1adeb40 <__bss_end+0x1ad5d20>
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
     294:	755f6962 	ldrbvc	r6, [pc, #-2402]	; fffff93a <__bss_end+0xffff6b1a>
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
     324:	6b736544 	blvs	1cd983c <__bss_end+0x1cd0a1c>
     328:	2f706f74 	svccs	0x00706f74
     32c:	2f564146 	svccs	0x00564146
     330:	6176614e 	cmnvs	r6, lr, asr #2
     334:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
     338:	4f2f6963 	svcmi	0x002f6963
     33c:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
     340:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
     344:	6b6c6172 	blvs	1b18914 <__bss_end+0x1b0faf4>
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
     3e8:	78614d00 	stmdavc	r1!, {r8, sl, fp, lr}^
     3ec:	656c6946 	strbvs	r6, [ip, #-2374]!	; 0xfffff6ba
     3f0:	656d616e 	strbvs	r6, [sp, #-366]!	; 0xfffffe92
     3f4:	676e654c 	strbvs	r6, [lr, -ip, asr #10]!
     3f8:	61006874 	tstvs	r0, r4, ror r8
     3fc:	00636772 	rsbeq	r6, r3, r2, ror r7
     400:	6b636f4c 	blvs	18dc138 <__bss_end+0x18d3318>
     404:	6c6e555f 	cfstr64vs	mvdx5, [lr], #-380	; 0xfffffe84
     408:	656b636f 	strbvs	r6, [fp, #-879]!	; 0xfffffc91
     40c:	6e490064 	cdpvs	0, 4, cr0, cr9, cr4, {3}
     410:	696c6176 	stmdbvs	ip!, {r1, r2, r4, r5, r6, r8, sp, lr}^
     414:	61485f64 	cmpvs	r8, r4, ror #30
     418:	656c646e 	strbvs	r6, [ip, #-1134]!	; 0xfffffb92
     41c:	6e6f6c00 	cdpvs	12, 6, cr6, cr15, cr0, {0}
     420:	6e752067 	cdpvs	0, 7, cr2, cr5, cr7, {3}
     424:	6e676973 			; <UNDEFINED> instruction: 0x6e676973
     428:	69206465 	stmdbvs	r0!, {r0, r2, r5, r6, sl, sp, lr}
     42c:	4d00746e 	cfstrsmi	mvf7, [r0, #-440]	; 0xfffffe48
     430:	505f7861 	subspl	r7, pc, r1, ror #16
     434:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     438:	4f5f7373 	svcmi	0x005f7373
     43c:	656e6570 	strbvs	r6, [lr, #-1392]!	; 0xfffffa90
     440:	69465f64 	stmdbvs	r6, {r2, r5, r6, r8, r9, sl, fp, ip, lr}^
     444:	0073656c 	rsbseq	r6, r3, ip, ror #10
     448:	6c6f6f62 	stclvs	15, cr6, [pc], #-392	; 2c8 <shift+0x2c8>
     44c:	61654400 	cmnvs	r5, r0, lsl #8
     450:	6e696c64 	cdpvs	12, 6, cr6, cr9, cr4, {3}
     454:	6e555f65 	cdpvs	15, 5, cr5, cr5, cr5, {3}
     458:	6e616863 	cdpvs	8, 6, cr6, cr1, cr3, {3}
     45c:	00646567 	rsbeq	r6, r4, r7, ror #10
     460:	69466f4e 	stmdbvs	r6, {r1, r2, r3, r6, r8, r9, sl, fp, sp, lr}^
     464:	7973656c 	ldmdbvc	r3!, {r2, r3, r5, r6, r8, sl, sp, lr}^
     468:	6d657473 	cfstrdvs	mvd7, [r5, #-460]!	; 0xfffffe34
     46c:	76697244 	strbtvc	r7, [r9], -r4, asr #4
     470:	75007265 	strvc	r7, [r0, #-613]	; 0xfffffd9b
     474:	6769736e 	strbvs	r7, [r9, -lr, ror #6]!
     478:	2064656e 	rsbcs	r6, r4, lr, ror #10
     47c:	72616863 	rsbvc	r6, r1, #6488064	; 0x630000
     480:	69616d00 	stmdbvs	r1!, {r8, sl, fp, sp, lr}^
     484:	6f4e006e 	svcvs	0x004e006e
     488:	79666974 	stmdbvc	r6!, {r2, r4, r5, r6, r8, fp, sp, lr}^
     48c:	006c6c41 	rsbeq	r6, ip, r1, asr #24
     490:	746e6975 	strbtvc	r6, [lr], #-2421	; 0xfffff68b
     494:	745f3233 	ldrbvc	r3, [pc], #-563	; 49c <shift+0x49c>
     498:	636f4c00 	cmnvs	pc, #0, 24
     49c:	6f4c5f6b 	svcvs	0x004c5f6b
     4a0:	64656b63 	strbtvs	r6, [r5], #-2915	; 0xfffff49d
     4a4:	646e4900 	strbtvs	r4, [lr], #-2304	; 0xfffff700
     4a8:	6e696665 	cdpvs	6, 6, cr6, cr9, cr5, {3}
     4ac:	00657469 	rsbeq	r7, r5, r9, ror #8
     4b0:	726f6873 	rsbvc	r6, pc, #7536640	; 0x730000
     4b4:	6e752074 	mrcvs	0, 3, r2, cr5, cr4, {3}
     4b8:	6e676973 			; <UNDEFINED> instruction: 0x6e676973
     4bc:	69206465 	stmdbvs	r0!, {r0, r2, r5, r6, sl, sp, lr}
     4c0:	2f00746e 	svccs	0x0000746e
     4c4:	72657355 	rsbvc	r7, r5, #1409286145	; 0x54000001
     4c8:	69772f73 	ldmdbvs	r7!, {r0, r1, r4, r5, r6, r8, r9, sl, fp, sp}^
     4cc:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
     4d0:	442f696a 	strtmi	r6, [pc], #-2410	; 4d8 <shift+0x4d8>
     4d4:	746b7365 	strbtvc	r7, [fp], #-869	; 0xfffffc9b
     4d8:	462f706f 	strtmi	r7, [pc], -pc, rrx
     4dc:	4e2f5641 	cfmadda32mi	mvax2, mvax5, mvfx15, mvfx1
     4e0:	7a617661 	bvc	185de6c <__bss_end+0x185504c>
     4e4:	63696a75 	cmnvs	r9, #479232	; 0x75000
     4e8:	534f2f69 	movtpl	r2, #65385	; 0xff69
     4ec:	6d65732f 	stclvs	3, cr7, [r5, #-188]!	; 0xffffff44
     4f0:	72747365 	rsbsvc	r7, r4, #-1811939327	; 0x94000001
     4f4:	616b6c61 	cmnvs	fp, r1, ror #24
     4f8:	76696b2d 	strbtvc	r6, [r9], -sp, lsr #22
     4fc:	2f736f2d 	svccs	0x00736f2d
     500:	72756f73 	rsbsvc	r6, r5, #460	; 0x1cc
     504:	2f736563 	svccs	0x00736563
     508:	72657375 	rsbvc	r7, r5, #-738197503	; 0xd4000001
     50c:	63617073 	cmnvs	r1, #115	; 0x73
     510:	6e692f65 	cdpvs	15, 6, cr2, cr9, cr5, {3}
     514:	745f7469 	ldrbvc	r7, [pc], #-1129	; 51c <shift+0x51c>
     518:	2f6b7361 	svccs	0x006b7361
     51c:	6e69616d 	powvsez	f6, f1, #5.0
     520:	7070632e 	rsbsvc	r6, r0, lr, lsr #6
     524:	78614d00 	stmdavc	r1!, {r8, sl, fp, lr}^
     528:	68746150 	ldmdavs	r4!, {r4, r6, r8, sp, lr}^
     52c:	676e654c 	strbvs	r6, [lr, -ip, asr #10]!
     530:	73006874 	movwvc	r6, #2164	; 0x874
     534:	74726f68 	ldrbtvc	r6, [r2], #-3944	; 0xfffff098
     538:	746e6920 	strbtvc	r6, [lr], #-2336	; 0xfffff6e0
     53c:	78614d00 	stmdavc	r1!, {r8, sl, fp, lr}^
     540:	72445346 	subvc	r5, r4, #402653185	; 0x18000001
     544:	72657669 	rsbvc	r7, r5, #110100480	; 0x6900000
     548:	656d614e 	strbvs	r6, [sp, #-334]!	; 0xfffffeb2
     54c:	676e654c 	strbvs	r6, [lr, -ip, asr #10]!
     550:	61006874 	tstvs	r0, r4, ror r8
     554:	00766772 	rsbseq	r6, r6, r2, ror r7
     558:	6b636954 	blvs	18daab0 <__bss_end+0x18d1c90>
     55c:	756f435f 	strbvc	r4, [pc, #-863]!	; 205 <shift+0x205>
     560:	2f00746e 	svccs	0x0000746e
     564:	72657355 	rsbvc	r7, r5, #1409286145	; 0x54000001
     568:	69772f73 	ldmdbvs	r7!, {r0, r1, r4, r5, r6, r8, r9, sl, fp, sp}^
     56c:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
     570:	442f696a 	strtmi	r6, [pc], #-2410	; 578 <shift+0x578>
     574:	746b7365 	strbtvc	r7, [fp], #-869	; 0xfffffc9b
     578:	462f706f 	strtmi	r7, [pc], -pc, rrx
     57c:	4e2f5641 	cfmadda32mi	mvax2, mvax5, mvfx15, mvfx1
     580:	7a617661 	bvc	185df0c <__bss_end+0x18550ec>
     584:	63696a75 	cmnvs	r9, #479232	; 0x75000
     588:	534f2f69 	movtpl	r2, #65385	; 0xff69
     58c:	6d65732f 	stclvs	3, cr7, [r5, #-188]!	; 0xffffff44
     590:	72747365 	rsbsvc	r7, r4, #-1811939327	; 0x94000001
     594:	616b6c61 	cmnvs	fp, r1, ror #24
     598:	76696b2d 	strbtvc	r6, [r9], -sp, lsr #22
     59c:	2f736f2d 	svccs	0x00736f2d
     5a0:	72756f73 	rsbsvc	r6, r5, #460	; 0x1cc
     5a4:	2f736563 	svccs	0x00736563
     5a8:	6c697562 	cfstr64vs	mvdx7, [r9], #-392	; 0xfffffe78
     5ac:	704f0064 	subvc	r0, pc, r4, rrx
     5b0:	5f006e65 	svcpl	0x00006e65
     5b4:	36314e5a 			; <UNDEFINED> instruction: 0x36314e5a
     5b8:	6f725043 	svcvs	0x00725043
     5bc:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     5c0:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     5c4:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     5c8:	6c423132 	stfvse	f3, [r2], {50}	; 0x32
     5cc:	5f6b636f 	svcpl	0x006b636f
     5d0:	72727543 	rsbsvc	r7, r2, #281018368	; 0x10c00000
     5d4:	5f746e65 	svcpl	0x00746e65
     5d8:	636f7250 	cmnvs	pc, #80, 4
     5dc:	45737365 	ldrbmi	r7, [r3, #-869]!	; 0xfffffc9b
     5e0:	6c630076 	stclvs	0, cr0, [r3], #-472	; 0xfffffe28
     5e4:	0065736f 	rsbeq	r7, r5, pc, ror #6
     5e8:	76657270 			; <UNDEFINED> instruction: 0x76657270
     5ec:	74655300 	strbtvc	r5, [r5], #-768	; 0xfffffd00
     5f0:	6c65525f 	sfmvs	f5, 2, [r5], #-380	; 0xfffffe84
     5f4:	76697461 	strbtvc	r7, [r9], -r1, ror #8
     5f8:	6e550065 	cdpvs	0, 5, cr0, cr5, cr5, {3}
     5fc:	5f70616d 	svcpl	0x0070616d
     600:	656c6946 	strbvs	r6, [ip, #-2374]!	; 0xfffff6ba
     604:	7275435f 	rsbsvc	r4, r5, #2080374785	; 0x7c000001
     608:	746e6572 	strbtvc	r6, [lr], #-1394	; 0xfffffa8e
     60c:	74657200 	strbtvc	r7, [r5], #-512	; 0xfffffe00
     610:	006c6176 	rsbeq	r6, ip, r6, ror r1
     614:	7275636e 	rsbsvc	r6, r5, #-1207959551	; 0xb8000001
     618:	72506d00 	subsvc	r6, r0, #0, 26
     61c:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     620:	694c5f73 	stmdbvs	ip, {r0, r1, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     624:	485f7473 	ldmdami	pc, {r0, r1, r4, r5, r6, sl, ip, sp, lr}^	; <UNPREDICTABLE>
     628:	00646165 	rsbeq	r6, r4, r5, ror #2
     62c:	65706970 	ldrbvs	r6, [r0, #-2416]!	; 0xfffff690
     630:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     634:	4336314b 	teqmi	r6, #-1073741806	; 0xc0000012
     638:	636f7250 	cmnvs	pc, #80, 4
     63c:	5f737365 	svcpl	0x00737365
     640:	616e614d 	cmnvs	lr, sp, asr #2
     644:	31726567 	cmncc	r2, r7, ror #10
     648:	74654739 	strbtvc	r4, [r5], #-1849	; 0xfffff8c7
     64c:	7275435f 	rsbsvc	r4, r5, #2080374785	; 0x7c000001
     650:	746e6572 	strbtvc	r6, [lr], #-1394	; 0xfffffa8e
     654:	6f72505f 	svcvs	0x0072505f
     658:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     65c:	72007645 	andvc	r7, r0, #72351744	; 0x4500000
     660:	6d756e64 	ldclvs	14, cr6, [r5, #-400]!	; 0xfffffe70
     664:	78656e00 	stmdavc	r5!, {r9, sl, fp, sp, lr}^
     668:	65470074 	strbvs	r0, [r7, #-116]	; 0xffffff8c
     66c:	72505f74 	subsvc	r5, r0, #116, 30	; 0x1d0
     670:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     674:	79425f73 	stmdbvc	r2, {r0, r1, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     678:	4449505f 	strbmi	r5, [r9], #-95	; 0xffffffa1
     67c:	315a5f00 	cmpcc	sl, r0, lsl #30
     680:	68637331 	stmdavs	r3!, {r0, r4, r5, r8, r9, ip, sp, lr}^
     684:	795f6465 	ldmdbvc	pc, {r0, r2, r5, r6, sl, sp, lr}^	; <UNPREDICTABLE>
     688:	646c6569 	strbtvs	r6, [ip], #-1385	; 0xfffffa97
     68c:	534e0076 	movtpl	r0, #57462	; 0xe076
     690:	505f4957 	subspl	r4, pc, r7, asr r9	; <UNPREDICTABLE>
     694:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     698:	535f7373 	cmppl	pc, #-872415231	; 0xcc000001
     69c:	69767265 	ldmdbvs	r6!, {r0, r2, r5, r6, r9, ip, sp, lr}^
     6a0:	52006563 	andpl	r6, r0, #415236096	; 0x18c00000
     6a4:	00646165 	rsbeq	r6, r4, r5, ror #2
     6a8:	69746341 	ldmdbvs	r4!, {r0, r6, r8, r9, sp, lr}^
     6ac:	505f6576 	subspl	r6, pc, r6, ror r5	; <UNPREDICTABLE>
     6b0:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     6b4:	435f7373 	cmpmi	pc, #-872415231	; 0xcc000001
     6b8:	746e756f 	strbtvc	r7, [lr], #-1391	; 0xfffffa91
     6bc:	65724300 	ldrbvs	r4, [r2, #-768]!	; 0xfffffd00
     6c0:	5f657461 	svcpl	0x00657461
     6c4:	636f7250 	cmnvs	pc, #80, 4
     6c8:	00737365 	rsbseq	r7, r3, r5, ror #6
     6cc:	37315a5f 			; <UNDEFINED> instruction: 0x37315a5f
     6d0:	5f746573 	svcpl	0x00746573
     6d4:	6b736174 	blvs	1cd8cac <__bss_end+0x1ccfe8c>
     6d8:	6165645f 	cmnvs	r5, pc, asr r4
     6dc:	6e696c64 	cdpvs	12, 6, cr6, cr9, cr4, {3}
     6e0:	77006a65 	strvc	r6, [r0, -r5, ror #20]
     6e4:	00746961 	rsbseq	r6, r4, r1, ror #18
     6e8:	74617473 	strbtvc	r7, [r1], #-1139	; 0xfffffb8d
     6ec:	5a5f0065 	bpl	17c0888 <__bss_end+0x17b7a68>
     6f0:	746f6e36 	strbtvc	r6, [pc], #-3638	; 6f8 <shift+0x6f8>
     6f4:	6a796669 	bvs	1e5a0a0 <__bss_end+0x1e51280>
     6f8:	6547006a 	strbvs	r0, [r7, #-106]	; 0xffffff96
     6fc:	63535f74 	cmpvs	r3, #116, 30	; 0x1d0
     700:	75646568 	strbvc	r6, [r4, #-1384]!	; 0xfffffa98
     704:	5f72656c 	svcpl	0x0072656c
     708:	6f666e49 	svcvs	0x00666e49
     70c:	72504300 	subsvc	r4, r0, #0, 6
     710:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     714:	614d5f73 	hvcvs	54771	; 0xd5f3
     718:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     71c:	5a5f0072 	bpl	17c08ec <__bss_end+0x17b7acc>
     720:	4336314e 	teqmi	r6, #-2147483629	; 0x80000013
     724:	636f7250 	cmnvs	pc, #80, 4
     728:	5f737365 	svcpl	0x00737365
     72c:	616e614d 	cmnvs	lr, sp, asr #2
     730:	31726567 	cmncc	r2, r7, ror #10
     734:	74654738 	strbtvc	r4, [r5], #-1848	; 0xfffff8c8
     738:	6863535f 	stmdavs	r3!, {r0, r1, r2, r3, r4, r6, r8, r9, ip, lr}^
     73c:	6c756465 	cfldrdvs	mvd6, [r5], #-404	; 0xfffffe6c
     740:	495f7265 	ldmdbmi	pc, {r0, r2, r5, r6, r9, ip, sp, lr}^	; <UNPREDICTABLE>
     744:	456f666e 	strbmi	r6, [pc, #-1646]!	; de <shift+0xde>
     748:	474e3032 	smlaldxmi	r3, lr, r2, r0
     74c:	535f7465 	cmppl	pc, #1694498816	; 0x65000000
     750:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     754:	666e495f 			; <UNDEFINED> instruction: 0x666e495f
     758:	79545f6f 	ldmdbvc	r4, {r0, r1, r2, r3, r5, r6, r8, r9, sl, fp, ip, lr}^
     75c:	76506570 			; <UNDEFINED> instruction: 0x76506570
     760:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     764:	50433631 	subpl	r3, r3, r1, lsr r6
     768:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     76c:	4d5f7373 	ldclmi	3, cr7, [pc, #-460]	; 5a8 <shift+0x5a8>
     770:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
     774:	31327265 	teqcc	r2, r5, ror #4
     778:	646e6148 	strbtvs	r6, [lr], #-328	; 0xfffffeb8
     77c:	465f656c 	ldrbmi	r6, [pc], -ip, ror #10
     780:	73656c69 	cmnvc	r5, #26880	; 0x6900
     784:	65747379 	ldrbvs	r7, [r4, #-889]!	; 0xfffffc87
     788:	57535f6d 	ldrbpl	r5, [r3, -sp, ror #30]
     78c:	33324549 	teqcc	r2, #306184192	; 0x12400000
     790:	4957534e 	ldmdbmi	r7, {r1, r2, r3, r6, r8, r9, ip, lr}^
     794:	6c69465f 	stclvs	6, cr4, [r9], #-380	; 0xfffffe84
     798:	73797365 	cmnvc	r9, #-1811939327	; 0x94000001
     79c:	5f6d6574 	svcpl	0x006d6574
     7a0:	76726553 			; <UNDEFINED> instruction: 0x76726553
     7a4:	6a656369 	bvs	1959550 <__bss_end+0x1950730>
     7a8:	31526a6a 	cmpcc	r2, sl, ror #20
     7ac:	57535431 	smmlarpl	r3, r1, r4, r5
     7b0:	65525f49 	ldrbvs	r5, [r2, #-3913]	; 0xfffff0b7
     7b4:	746c7573 	strbtvc	r7, [ip], #-1395	; 0xfffffa8d
     7b8:	65706f00 	ldrbvs	r6, [r0, #-3840]!	; 0xfffff100
     7bc:	5f64656e 	svcpl	0x0064656e
     7c0:	656c6966 	strbvs	r6, [ip, #-2406]!	; 0xfffff69a
     7c4:	61460073 	hvcvs	24579	; 0x6003
     7c8:	54006c69 	strpl	r6, [r0], #-3177	; 0xfffff397
     7cc:	5f555043 	svcpl	0x00555043
     7d0:	746e6f43 	strbtvc	r6, [lr], #-3907	; 0xfffff0bd
     7d4:	00747865 	rsbseq	r7, r4, r5, ror #16
     7d8:	64616544 	strbtvs	r6, [r1], #-1348	; 0xfffffabc
     7dc:	656e696c 	strbvs	r6, [lr, #-2412]!	; 0xfffff694
     7e0:	69786500 	ldmdbvs	r8!, {r8, sl, sp, lr}^
     7e4:	646f6374 	strbtvs	r6, [pc], #-884	; 7ec <shift+0x7ec>
     7e8:	74740065 	ldrbtvc	r0, [r4], #-101	; 0xffffff9b
     7ec:	00307262 	eorseq	r7, r0, r2, ror #4
     7f0:	314e5a5f 	cmpcc	lr, pc, asr sl
     7f4:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     7f8:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     7fc:	614d5f73 	hvcvs	54771	; 0xd5f3
     800:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     804:	4e343172 	mrcmi	1, 1, r3, cr4, cr2, {3}
     808:	6669746f 	strbtvs	r7, [r9], -pc, ror #8
     80c:	72505f79 	subsvc	r5, r0, #484	; 0x1e4
     810:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     814:	006a4573 	rsbeq	r4, sl, r3, ror r5
     818:	5f746547 	svcpl	0x00746547
     81c:	00444950 	subeq	r4, r4, r0, asr r9
     820:	69746f6e 	ldmdbvs	r4!, {r1, r2, r3, r5, r6, r8, r9, sl, fp, sp, lr}^
     824:	64656966 	strbtvs	r6, [r5], #-2406	; 0xfffff69a
     828:	6165645f 	cmnvs	r5, pc, asr r4
     82c:	6e696c64 	cdpvs	12, 6, cr6, cr9, cr4, {3}
     830:	5a5f0065 	bpl	17c09cc <__bss_end+0x17b7bac>
     834:	4336314e 	teqmi	r6, #-2147483629	; 0x80000013
     838:	636f7250 	cmnvs	pc, #80, 4
     83c:	5f737365 	svcpl	0x00737365
     840:	616e614d 	cmnvs	lr, sp, asr #2
     844:	31726567 	cmncc	r2, r7, ror #10
     848:	6d6e5538 	cfstr64vs	mvdx5, [lr, #-224]!	; 0xffffff20
     84c:	465f7061 	ldrbmi	r7, [pc], -r1, rrx
     850:	5f656c69 	svcpl	0x00656c69
     854:	72727543 	rsbsvc	r7, r2, #281018368	; 0x10c00000
     858:	45746e65 	ldrbmi	r6, [r4, #-3685]!	; 0xfffff19b
     85c:	5a5f006a 	bpl	17c0a0c <__bss_end+0x17b7bec>
     860:	4336314e 	teqmi	r6, #-2147483629	; 0x80000013
     864:	636f7250 	cmnvs	pc, #80, 4
     868:	5f737365 	svcpl	0x00737365
     86c:	616e614d 	cmnvs	lr, sp, asr #2
     870:	31726567 	cmncc	r2, r7, ror #10
     874:	746f4e34 	strbtvc	r4, [pc], #-3636	; 87c <shift+0x87c>
     878:	5f796669 	svcpl	0x00796669
     87c:	636f7250 	cmnvs	pc, #80, 4
     880:	45737365 	ldrbmi	r7, [r3, #-869]!	; 0xfffffc9b
     884:	54323150 	ldrtpl	r3, [r2], #-336	; 0xfffffeb0
     888:	6b736154 	blvs	1cd8de0 <__bss_end+0x1ccffc0>
     88c:	7274535f 	rsbsvc	r5, r4, #2080374785	; 0x7c000001
     890:	00746375 	rsbseq	r6, r4, r5, ror r3
     894:	65686373 	strbvs	r6, [r8, #-883]!	; 0xfffffc8d
     898:	69795f64 	ldmdbvs	r9!, {r2, r5, r6, r8, r9, sl, fp, ip, lr}^
     89c:	00646c65 	rsbeq	r6, r4, r5, ror #24
     8a0:	6b636974 	blvs	18dae78 <__bss_end+0x18d2058>
     8a4:	756f635f 	strbvc	r6, [pc, #-863]!	; 54d <shift+0x54d>
     8a8:	725f746e 	subsvc	r7, pc, #1845493760	; 0x6e000000
     8ac:	69757165 	ldmdbvs	r5!, {r0, r2, r5, r6, r8, ip, sp, lr}^
     8b0:	00646572 	rsbeq	r6, r4, r2, ror r5
     8b4:	34325a5f 	ldrtcc	r5, [r2], #-2655	; 0xfffff5a1
     8b8:	5f746567 	svcpl	0x00746567
     8bc:	69746361 	ldmdbvs	r4!, {r0, r5, r6, r8, r9, sp, lr}^
     8c0:	705f6576 	subsvc	r6, pc, r6, ror r5	; <UNPREDICTABLE>
     8c4:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     8c8:	635f7373 	cmpvs	pc, #-872415231	; 0xcc000001
     8cc:	746e756f 	strbtvc	r7, [lr], #-1391	; 0xfffffa91
     8d0:	65470076 	strbvs	r0, [r7, #-118]	; 0xffffff8a
     8d4:	75435f74 	strbvc	r5, [r3, #-3956]	; 0xfffff08c
     8d8:	6e657272 	mcrvs	2, 3, r7, cr5, cr2, {3}
     8dc:	72505f74 	subsvc	r5, r0, #116, 30	; 0x1d0
     8e0:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     8e4:	69500073 	ldmdbvs	r0, {r0, r1, r4, r5, r6}^
     8e8:	465f6570 			; <UNDEFINED> instruction: 0x465f6570
     8ec:	5f656c69 	svcpl	0x00656c69
     8f0:	66657250 			; <UNDEFINED> instruction: 0x66657250
     8f4:	4d007869 	stcmi	8, cr7, [r0, #-420]	; 0xfffffe5c
     8f8:	465f7061 	ldrbmi	r7, [pc], -r1, rrx
     8fc:	5f656c69 	svcpl	0x00656c69
     900:	435f6f54 	cmpmi	pc, #84, 30	; 0x150
     904:	65727275 	ldrbvs	r7, [r2, #-629]!	; 0xfffffd8b
     908:	5300746e 	movwpl	r7, #1134	; 0x46e
     90c:	505f7465 	subspl	r7, pc, r5, ror #8
     910:	6d617261 	sfmvs	f7, 2, [r1, #-388]!	; 0xfffffe7c
     914:	5a5f0073 	bpl	17c0ae8 <__bss_end+0x17b7cc8>
     918:	65673431 	strbvs	r3, [r7, #-1073]!	; 0xfffffbcf
     91c:	69745f74 	ldmdbvs	r4!, {r2, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     920:	635f6b63 	cmpvs	pc, #101376	; 0x18c00
     924:	746e756f 	strbtvc	r7, [lr], #-1391	; 0xfffffa91
     928:	61480076 	hvcvs	32774	; 0x8006
     92c:	656c646e 	strbvs	r6, [ip, #-1134]!	; 0xfffffb92
     930:	6f72505f 	svcvs	0x0072505f
     934:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     938:	4957535f 	ldmdbmi	r7, {r0, r1, r2, r3, r4, r6, r8, r9, ip, lr}^
     93c:	656c7300 	strbvs	r7, [ip, #-768]!	; 0xfffffd00
     940:	53007065 	movwpl	r7, #101	; 0x65
     944:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     948:	5f656c75 	svcpl	0x00656c75
     94c:	00464445 	subeq	r4, r6, r5, asr #8
     950:	74696157 	strbtvc	r6, [r9], #-343	; 0xfffffea9
     954:	73694400 	cmnvc	r9, #0, 8
     958:	656c6261 	strbvs	r6, [ip, #-609]!	; 0xfffffd9f
     95c:	6576455f 	ldrbvs	r4, [r6, #-1375]!	; 0xfffffaa1
     960:	445f746e 	ldrbmi	r7, [pc], #-1134	; 968 <shift+0x968>
     964:	63657465 	cmnvs	r5, #1694498816	; 0x65000000
     968:	6e6f6974 			; <UNDEFINED> instruction: 0x6e6f6974
     96c:	395a5f00 	ldmdbcc	sl, {r8, r9, sl, fp, ip, lr}^
     970:	6d726574 	cfldr64vs	mvdx6, [r2, #-464]!	; 0xfffffe30
     974:	74616e69 	strbtvc	r6, [r1], #-3689	; 0xfffff197
     978:	49006965 	stmdbmi	r0, {r0, r2, r5, r6, r8, fp, sp, lr}
     97c:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
     980:	74707572 	ldrbtvc	r7, [r0], #-1394	; 0xfffffa8e
     984:	656c6261 	strbvs	r6, [ip, #-609]!	; 0xfffffd9f
     988:	656c535f 	strbvs	r5, [ip, #-863]!	; 0xfffffca1
     98c:	6f007065 	svcvs	0x00007065
     990:	61726570 	cmnvs	r2, r0, ror r5
     994:	6e6f6974 			; <UNDEFINED> instruction: 0x6e6f6974
     998:	355a5f00 	ldrbcc	r5, [sl, #-3840]	; 0xfffff100
     99c:	736f6c63 	cmnvc	pc, #25344	; 0x6300
     9a0:	6d006a65 	vstrvs	s12, [r0, #-404]	; 0xfffffe6c
     9a4:	7473614c 	ldrbtvc	r6, [r3], #-332	; 0xfffffeb4
     9a8:	4449505f 	strbmi	r5, [r9], #-95	; 0xffffffa1
     9ac:	6f6c4200 	svcvs	0x006c4200
     9b0:	64656b63 	strbtvs	r6, [r5], #-2915	; 0xfffff49d
     9b4:	65474e00 	strbvs	r4, [r7, #-3584]	; 0xfffff200
     9b8:	63535f74 	cmpvs	r3, #116, 30	; 0x1d0
     9bc:	5f646568 	svcpl	0x00646568
     9c0:	6f666e49 	svcvs	0x00666e49
     9c4:	7079545f 	rsbsvc	r5, r9, pc, asr r4
     9c8:	5a5f0065 	bpl	17c0b64 <__bss_end+0x17b7d44>
     9cc:	74656736 	strbtvc	r6, [r5], #-1846	; 0xfffff8ca
     9d0:	76646970 			; <UNDEFINED> instruction: 0x76646970
     9d4:	616e6600 	cmnvs	lr, r0, lsl #12
     9d8:	5200656d 	andpl	r6, r0, #457179136	; 0x1b400000
     9dc:	616e6e75 	smcvs	59109	; 0xe6e5
     9e0:	00656c62 	rsbeq	r6, r5, r2, ror #24
     9e4:	7361544e 	cmnvc	r1, #1308622848	; 0x4e000000
     9e8:	74535f6b 	ldrbvc	r5, [r3], #-3947	; 0xfffff095
     9ec:	00657461 	rsbeq	r7, r5, r1, ror #8
     9f0:	65686373 	strbvs	r6, [r8, #-883]!	; 0xfffffc8d
     9f4:	6f635f64 	svcvs	0x00635f64
     9f8:	65746e75 	ldrbvs	r6, [r4, #-3701]!	; 0xfffff18b
     9fc:	63730072 	cmnvs	r3, #114	; 0x72
     a00:	5f646568 	svcpl	0x00646568
     a04:	74617473 	strbtvc	r7, [r1], #-1139	; 0xfffffb8d
     a08:	705f6369 	subsvc	r6, pc, r9, ror #6
     a0c:	726f6972 	rsbvc	r6, pc, #1867776	; 0x1c8000
     a10:	00797469 	rsbseq	r7, r9, r9, ror #8
     a14:	74697277 	strbtvc	r7, [r9], #-631	; 0xfffffd89
     a18:	78650065 	stmdavc	r5!, {r0, r2, r5, r6}^
     a1c:	635f7469 	cmpvs	pc, #1761607680	; 0x69000000
     a20:	0065646f 	rsbeq	r6, r5, pc, ror #8
     a24:	6b636974 	blvs	18daffc <__bss_end+0x18d21dc>
     a28:	536d0073 	cmnpl	sp, #115	; 0x73
     a2c:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     a30:	5f656c75 	svcpl	0x00656c75
     a34:	00636e46 	rsbeq	r6, r3, r6, asr #28
     a38:	6e65706f 	cdpvs	0, 6, cr7, cr5, cr15, {3}
     a3c:	345a5f00 	ldrbcc	r5, [sl], #-3840	; 0xfffff100
     a40:	65706970 	ldrbvs	r6, [r0, #-2416]!	; 0xfffff690
     a44:	6a634b50 	bvs	18d378c <__bss_end+0x18ca96c>
     a48:	65444e00 	strbvs	r4, [r4, #-3584]	; 0xfffff200
     a4c:	696c6461 	stmdbvs	ip!, {r0, r5, r6, sl, sp, lr}^
     a50:	535f656e 	cmppl	pc, #461373440	; 0x1b800000
     a54:	65736275 	ldrbvs	r6, [r3, #-629]!	; 0xfffffd8b
     a58:	63697672 	cmnvs	r9, #119537664	; 0x7200000
     a5c:	65670065 	strbvs	r0, [r7, #-101]!	; 0xffffff9b
     a60:	69745f74 	ldmdbvs	r4!, {r2, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     a64:	635f6b63 	cmpvs	pc, #101376	; 0x18c00
     a68:	746e756f 	strbtvc	r7, [lr], #-1391	; 0xfffffa91
     a6c:	746f4e00 	strbtvc	r4, [pc], #-3584	; a74 <shift+0xa74>
     a70:	00796669 	rsbseq	r6, r9, r9, ror #12
     a74:	61726170 	cmnvs	r2, r0, ror r1
     a78:	5a5f006d 	bpl	17c0c34 <__bss_end+0x17b7e14>
     a7c:	69727735 	ldmdbvs	r2!, {r0, r2, r4, r5, r8, r9, sl, ip, sp, lr}^
     a80:	506a6574 	rsbpl	r6, sl, r4, ror r5
     a84:	006a634b 	rsbeq	r6, sl, fp, asr #6
     a88:	5f746567 	svcpl	0x00746567
     a8c:	6b736174 	blvs	1cd9064 <__bss_end+0x1cd0244>
     a90:	6369745f 	cmnvs	r9, #1593835520	; 0x5f000000
     a94:	745f736b 	ldrbvc	r7, [pc], #-875	; a9c <shift+0xa9c>
     a98:	65645f6f 	strbvs	r5, [r4, #-3951]!	; 0xfffff091
     a9c:	696c6461 	stmdbvs	ip!, {r0, r5, r6, sl, sp, lr}^
     aa0:	6200656e 	andvs	r6, r0, #461373440	; 0x1b800000
     aa4:	735f6675 	cmpvc	pc, #122683392	; 0x7500000
     aa8:	00657a69 	rsbeq	r7, r5, r9, ror #20
     aac:	64616552 	strbtvs	r6, [r1], #-1362	; 0xfffffaae
     ab0:	6972575f 	ldmdbvs	r2!, {r0, r1, r2, r3, r4, r6, r8, r9, sl, ip, lr}^
     ab4:	5a006574 	bpl	1a08c <__bss_end+0x1126c>
     ab8:	69626d6f 	stmdbvs	r2!, {r0, r1, r2, r3, r5, r6, r8, sl, fp, sp, lr}^
     abc:	65470065 	strbvs	r0, [r7, #-101]	; 0xffffff9b
     ac0:	63535f74 	cmpvs	r3, #116, 30	; 0x1d0
     ac4:	5f646568 	svcpl	0x00646568
     ac8:	6f666e49 	svcvs	0x00666e49
     acc:	74657300 	strbtvc	r7, [r5], #-768	; 0xfffffd00
     ad0:	7361745f 	cmnvc	r1, #1593835520	; 0x5f000000
     ad4:	65645f6b 	strbvs	r5, [r4, #-3947]!	; 0xfffff095
     ad8:	696c6461 	stmdbvs	ip!, {r0, r5, r6, sl, sp, lr}^
     adc:	5f00656e 	svcpl	0x0000656e
     ae0:	36314e5a 			; <UNDEFINED> instruction: 0x36314e5a
     ae4:	6f725043 	svcvs	0x00725043
     ae8:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     aec:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     af0:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     af4:	68635338 	stmdavs	r3!, {r3, r4, r5, r8, r9, ip, lr}^
     af8:	6c756465 	cfldrdvs	mvd6, [r5], #-404	; 0xfffffe6c
     afc:	00764565 	rsbseq	r4, r6, r5, ror #10
     b00:	314e5a5f 	cmpcc	lr, pc, asr sl
     b04:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     b08:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     b0c:	614d5f73 	hvcvs	54771	; 0xd5f3
     b10:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     b14:	4d393172 	ldfmis	f3, [r9, #-456]!	; 0xfffffe38
     b18:	465f7061 	ldrbmi	r7, [pc], -r1, rrx
     b1c:	5f656c69 	svcpl	0x00656c69
     b20:	435f6f54 	cmpmi	pc, #84, 30	; 0x150
     b24:	65727275 	ldrbvs	r7, [r2, #-629]!	; 0xfffffd8b
     b28:	5045746e 	subpl	r7, r5, lr, ror #8
     b2c:	69464935 	stmdbvs	r6, {r0, r2, r4, r5, r8, fp, lr}^
     b30:	4700656c 	strmi	r6, [r0, -ip, ror #10]
     b34:	505f7465 	subspl	r7, pc, r5, ror #8
     b38:	6d617261 	sfmvs	f7, 2, [r1, #-388]!	; 0xfffffe7c
     b3c:	552f0073 	strpl	r0, [pc, #-115]!	; ad1 <shift+0xad1>
     b40:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
     b44:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
     b48:	6a726574 	bvs	1c9a120 <__bss_end+0x1c91300>
     b4c:	65442f69 	strbvs	r2, [r4, #-3945]	; 0xfffff097
     b50:	6f746b73 	svcvs	0x00746b73
     b54:	41462f70 	hvcmi	25328	; 0x62f0
     b58:	614e2f56 	cmpvs	lr, r6, asr pc
     b5c:	757a6176 	ldrbvc	r6, [sl, #-374]!	; 0xfffffe8a
     b60:	6963696a 	stmdbvs	r3!, {r1, r3, r5, r6, r8, fp, sp, lr}^
     b64:	2f534f2f 	svccs	0x00534f2f
     b68:	656d6573 	strbvs	r6, [sp, #-1395]!	; 0xfffffa8d
     b6c:	61727473 	cmnvs	r2, r3, ror r4
     b70:	2d616b6c 	vstmdbcs	r1!, {d22-<overflow reg d75>}
     b74:	2d76696b 			; <UNDEFINED> instruction: 0x2d76696b
     b78:	732f736f 			; <UNDEFINED> instruction: 0x732f736f
     b7c:	6372756f 	cmnvs	r2, #465567744	; 0x1bc00000
     b80:	732f7365 			; <UNDEFINED> instruction: 0x732f7365
     b84:	696c6474 	stmdbvs	ip!, {r2, r4, r5, r6, sl, sp, lr}^
     b88:	72732f62 	rsbsvc	r2, r3, #392	; 0x188
     b8c:	74732f63 	ldrbtvc	r2, [r3], #-3939	; 0xfffff09d
     b90:	6c696664 	stclvs	6, cr6, [r9], #-400	; 0xfffffe70
     b94:	70632e65 	rsbvc	r2, r3, r5, ror #28
     b98:	5a5f0070 	bpl	17c0d60 <__bss_end+0x17b7f40>
     b9c:	4336314e 	teqmi	r6, #-2147483629	; 0x80000013
     ba0:	636f7250 	cmnvs	pc, #80, 4
     ba4:	5f737365 	svcpl	0x00737365
     ba8:	616e614d 	cmnvs	lr, sp, asr #2
     bac:	31726567 	cmncc	r2, r7, ror #10
     bb0:	68635332 	stmdavs	r3!, {r1, r4, r5, r8, r9, ip, lr}^
     bb4:	6c756465 	cfldrdvs	mvd6, [r5], #-404	; 0xfffffe6c
     bb8:	44455f65 	strbmi	r5, [r5], #-3941	; 0xfffff09b
     bbc:	00764546 	rsbseq	r4, r6, r6, asr #10
     bc0:	73355a5f 	teqvc	r5, #389120	; 0x5f000
     bc4:	7065656c 	rsbvc	r6, r5, ip, ror #10
     bc8:	66006a6a 	strvs	r6, [r0], -sl, ror #20
     bcc:	00656c69 	rsbeq	r6, r5, r9, ror #24
     bd0:	5f746547 	svcpl	0x00746547
     bd4:	616d6552 	cmnvs	sp, r2, asr r5
     bd8:	6e696e69 	cdpvs	14, 6, cr6, cr9, cr9, {3}
     bdc:	6e450067 	cdpvs	0, 4, cr0, cr5, cr7, {3}
     be0:	656c6261 	strbvs	r6, [ip, #-609]!	; 0xfffffd9f
     be4:	6576455f 	ldrbvs	r4, [r6, #-1375]!	; 0xfffffaa1
     be8:	445f746e 	ldrbmi	r7, [pc], #-1134	; bf0 <shift+0xbf0>
     bec:	63657465 	cmnvs	r5, #1694498816	; 0x65000000
     bf0:	6e6f6974 			; <UNDEFINED> instruction: 0x6e6f6974
     bf4:	325a5f00 	subscc	r5, sl, #0, 30
     bf8:	74656736 	strbtvc	r6, [r5], #-1846	; 0xfffff8ca
     bfc:	7361745f 	cmnvc	r1, #1593835520	; 0x5f000000
     c00:	69745f6b 	ldmdbvs	r4!, {r0, r1, r3, r5, r6, r8, r9, sl, fp, ip, lr}^
     c04:	5f736b63 	svcpl	0x00736b63
     c08:	645f6f74 	ldrbvs	r6, [pc], #-3956	; c10 <shift+0xc10>
     c0c:	6c646165 	stfvse	f6, [r4], #-404	; 0xfffffe6c
     c10:	76656e69 	strbtvc	r6, [r5], -r9, ror #28
     c14:	57534e00 	ldrbpl	r4, [r3, -r0, lsl #28]
     c18:	65525f49 	ldrbvs	r5, [r2, #-3913]	; 0xfffff0b7
     c1c:	746c7573 	strbtvc	r7, [ip], #-1395	; 0xfffffa8d
     c20:	646f435f 	strbtvs	r4, [pc], #-863	; c28 <shift+0xc28>
     c24:	75520065 	ldrbvc	r0, [r2, #-101]	; 0xffffff9b
     c28:	6e696e6e 	cdpvs	14, 6, cr6, cr9, cr14, {3}
     c2c:	72770067 	rsbsvc	r0, r7, #103	; 0x67
     c30:	006d756e 	rsbeq	r7, sp, lr, ror #10
     c34:	77345a5f 			; <UNDEFINED> instruction: 0x77345a5f
     c38:	6a746961 	bvs	1d1b1c4 <__bss_end+0x1d123a4>
     c3c:	5f006a6a 	svcpl	0x00006a6a
     c40:	6f69355a 	svcvs	0x0069355a
     c44:	6a6c7463 	bvs	1b1ddd8 <__bss_end+0x1b14fb8>
     c48:	494e3631 	stmdbmi	lr, {r0, r4, r5, r9, sl, ip, sp}^
     c4c:	6c74434f 	ldclvs	3, cr4, [r4], #-316	; 0xfffffec4
     c50:	65704f5f 	ldrbvs	r4, [r0, #-3935]!	; 0xfffff0a1
     c54:	69746172 	ldmdbvs	r4!, {r1, r4, r5, r6, r8, sp, lr}^
     c58:	76506e6f 	ldrbvc	r6, [r0], -pc, ror #28
     c5c:	636f6900 	cmnvs	pc, #0, 18
     c60:	72006c74 	andvc	r6, r0, #116, 24	; 0x7400
     c64:	6e637465 	cdpvs	4, 6, cr7, cr3, cr5, {3}
     c68:	436d0074 	cmnmi	sp, #116	; 0x74
     c6c:	65727275 	ldrbvs	r7, [r2, #-629]!	; 0xfffffd8b
     c70:	545f746e 	ldrbpl	r7, [pc], #-1134	; c78 <shift+0xc78>
     c74:	5f6b7361 	svcpl	0x006b7361
     c78:	65646f4e 	strbvs	r6, [r4, #-3918]!	; 0xfffff0b2
     c7c:	746f6e00 	strbtvc	r6, [pc], #-3584	; c84 <shift+0xc84>
     c80:	00796669 	rsbseq	r6, r9, r9, ror #12
     c84:	6d726574 	cfldr64vs	mvdx6, [r2, #-464]!	; 0xfffffe30
     c88:	74616e69 	strbtvc	r6, [r1], #-3689	; 0xfffff197
     c8c:	6f6d0065 	svcvs	0x006d0065
     c90:	63006564 	movwvs	r6, #1380	; 0x564
     c94:	635f7570 	cmpvs	pc, #112, 10	; 0x1c000000
     c98:	65746e6f 	ldrbvs	r6, [r4, #-3695]!	; 0xfffff191
     c9c:	52007478 	andpl	r7, r0, #120, 8	; 0x78000000
     ca0:	5f646165 	svcpl	0x00646165
     ca4:	796c6e4f 	stmdbvc	ip!, {r0, r1, r2, r3, r6, r9, sl, fp, sp, lr}^
     ca8:	66756200 	ldrbtvs	r6, [r5], -r0, lsl #4
     cac:	00726566 	rsbseq	r6, r2, r6, ror #10
     cb0:	65656c73 	strbvs	r6, [r5, #-3187]!	; 0xfffff38d
     cb4:	69745f70 	ldmdbvs	r4!, {r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     cb8:	0072656d 	rsbseq	r6, r2, sp, ror #10
     cbc:	4b4e5a5f 	blmi	1397640 <__bss_end+0x138e820>
     cc0:	50433631 	subpl	r3, r3, r1, lsr r6
     cc4:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     cc8:	4d5f7373 	ldclmi	3, cr7, [pc, #-460]	; b04 <shift+0xb04>
     ccc:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
     cd0:	38317265 	ldmdacc	r1!, {r0, r2, r5, r6, r9, ip, sp, lr}
     cd4:	5f746547 	svcpl	0x00746547
     cd8:	636f7250 	cmnvs	pc, #80, 4
     cdc:	5f737365 	svcpl	0x00737365
     ce0:	505f7942 	subspl	r7, pc, r2, asr #18
     ce4:	6a454449 	bvs	1151e10 <__bss_end+0x1148ff0>
     ce8:	6e614800 	cdpvs	8, 6, cr4, cr1, cr0, {0}
     cec:	5f656c64 	svcpl	0x00656c64
     cf0:	656c6946 	strbvs	r6, [ip, #-2374]!	; 0xfffff6ba
     cf4:	74737973 	ldrbtvc	r7, [r3], #-2419	; 0xfffff68d
     cf8:	535f6d65 	cmppl	pc, #6464	; 0x1940
     cfc:	5f004957 	svcpl	0x00004957
     d00:	36314e5a 			; <UNDEFINED> instruction: 0x36314e5a
     d04:	6f725043 	svcvs	0x00725043
     d08:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     d0c:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     d10:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     d14:	63533131 	cmpvs	r3, #1073741836	; 0x4000000c
     d18:	75646568 	strbvc	r6, [r4, #-1384]!	; 0xfffffa98
     d1c:	525f656c 	subspl	r6, pc, #108, 10	; 0x1b000000
     d20:	00764552 	rsbseq	r4, r6, r2, asr r5
     d24:	6b736174 	blvs	1cd92fc <__bss_end+0x1cd04dc>
     d28:	345a5f00 	ldrbcc	r5, [sl], #-3840	; 0xfffff100
     d2c:	64616572 	strbtvs	r6, [r1], #-1394	; 0xfffffa8e
     d30:	6a63506a 	bvs	18d4ee0 <__bss_end+0x18cc0c0>
     d34:	746f4e00 	strbtvc	r4, [pc], #-3584	; d3c <shift+0xd3c>
     d38:	5f796669 	svcpl	0x00796669
     d3c:	636f7250 	cmnvs	pc, #80, 4
     d40:	00737365 	rsbseq	r7, r3, r5, ror #6
     d44:	65686353 	strbvs	r6, [r8, #-851]!	; 0xfffffcad
     d48:	656c7564 	strbvs	r7, [ip, #-1380]!	; 0xfffffa9c
     d4c:	554e4700 	strbpl	r4, [lr, #-1792]	; 0xfffff900
     d50:	2b2b4320 	blcs	ad19d8 <__bss_end+0xac8bb8>
     d54:	31203431 			; <UNDEFINED> instruction: 0x31203431
     d58:	2e332e30 	mrccs	14, 1, r2, cr3, cr0, {1}
     d5c:	30322031 	eorscc	r2, r2, r1, lsr r0
     d60:	38303132 	ldmdacc	r0!, {r1, r4, r5, r8, ip, sp}
     d64:	28203432 	stmdacs	r0!, {r1, r4, r5, sl, ip, sp}
     d68:	656c6572 	strbvs	r6, [ip, #-1394]!	; 0xfffffa8e
     d6c:	29657361 	stmdbcs	r5!, {r0, r5, r6, r8, r9, ip, sp, lr}^
     d70:	666d2d20 	strbtvs	r2, [sp], -r0, lsr #26
     d74:	74616f6c 	strbtvc	r6, [r1], #-3948	; 0xfffff094
     d78:	6962612d 	stmdbvs	r2!, {r0, r2, r3, r5, r8, sp, lr}^
     d7c:	7261683d 	rsbvc	r6, r1, #3997696	; 0x3d0000
     d80:	6d2d2064 	stcvs	0, cr2, [sp, #-400]!	; 0xfffffe70
     d84:	3d757066 	ldclcc	0, cr7, [r5, #-408]!	; 0xfffffe68
     d88:	20706676 	rsbscs	r6, r0, r6, ror r6
     d8c:	6c666d2d 	stclvs	13, cr6, [r6], #-180	; 0xffffff4c
     d90:	2d74616f 	ldfcse	f6, [r4, #-444]!	; 0xfffffe44
     d94:	3d696261 	sfmcc	f6, 2, [r9, #-388]!	; 0xfffffe7c
     d98:	64726168 	ldrbtvs	r6, [r2], #-360	; 0xfffffe98
     d9c:	666d2d20 	strbtvs	r2, [sp], -r0, lsr #26
     da0:	763d7570 			; <UNDEFINED> instruction: 0x763d7570
     da4:	2d207066 	stccs	0, cr7, [r0, #-408]!	; 0xfffffe68
     da8:	6e75746d 	cdpvs	4, 7, cr7, cr5, cr13, {3}
     dac:	72613d65 	rsbvc	r3, r1, #6464	; 0x1940
     db0:	3731316d 	ldrcc	r3, [r1, -sp, ror #2]!
     db4:	667a6a36 			; <UNDEFINED> instruction: 0x667a6a36
     db8:	2d20732d 	stccs	3, cr7, [r0, #-180]!	; 0xffffff4c
     dbc:	6d72616d 	ldfvse	f6, [r2, #-436]!	; 0xfffffe4c
     dc0:	616d2d20 	cmnvs	sp, r0, lsr #26
     dc4:	3d686372 	stclcc	3, cr6, [r8, #-456]!	; 0xfffffe38
     dc8:	766d7261 	strbtvc	r7, [sp], -r1, ror #4
     dcc:	2b6b7a36 	blcs	1adf6ac <__bss_end+0x1ad688c>
     dd0:	2d207066 	stccs	0, cr7, [r0, #-408]!	; 0xfffffe68
     dd4:	672d2067 	strvs	r2, [sp, -r7, rrx]!
     dd8:	20672d20 	rsbcs	r2, r7, r0, lsr #26
     ddc:	20304f2d 	eorscs	r4, r0, sp, lsr #30
     de0:	20304f2d 	eorscs	r4, r0, sp, lsr #30
     de4:	6f6e662d 	svcvs	0x006e662d
     de8:	6378652d 	cmnvs	r8, #188743680	; 0xb400000
     dec:	69747065 	ldmdbvs	r4!, {r0, r2, r5, r6, ip, sp, lr}^
     df0:	20736e6f 	rsbscs	r6, r3, pc, ror #28
     df4:	6f6e662d 	svcvs	0x006e662d
     df8:	7474722d 	ldrbtvc	r7, [r4], #-557	; 0xfffffdd3
     dfc:	5a5f0069 	bpl	17c0fa8 <__bss_end+0x17b8188>
     e00:	4336314e 	teqmi	r6, #-2147483629	; 0x80000013
     e04:	636f7250 	cmnvs	pc, #80, 4
     e08:	5f737365 	svcpl	0x00737365
     e0c:	616e614d 	cmnvs	lr, sp, asr #2
     e10:	39726567 	ldmdbcc	r2!, {r0, r1, r2, r5, r6, r8, sl, sp, lr}^
     e14:	74697753 	strbtvc	r7, [r9], #-1875	; 0xfffff8ad
     e18:	545f6863 	ldrbpl	r6, [pc], #-2147	; e20 <shift+0xe20>
     e1c:	3150456f 	cmpcc	r0, pc, ror #10
     e20:	72504338 	subsvc	r4, r0, #56, 6	; 0xe0000000
     e24:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     e28:	694c5f73 	stmdbvs	ip, {r0, r1, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     e2c:	4e5f7473 	mrcmi	4, 2, r7, cr15, cr3, {3}
     e30:	0065646f 	rsbeq	r6, r5, pc, ror #8
     e34:	65686353 	strbvs	r6, [r8, #-851]!	; 0xfffffcad
     e38:	656c7564 	strbvs	r7, [ip, #-1380]!	; 0xfffffa9c
     e3c:	0052525f 	subseq	r5, r2, pc, asr r2
     e40:	314e5a5f 	cmpcc	lr, pc, asr sl
     e44:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     e48:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     e4c:	614d5f73 	hvcvs	54771	; 0xd5f3
     e50:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     e54:	48383172 	ldmdami	r8!, {r1, r4, r5, r6, r8, ip, sp}
     e58:	6c646e61 	stclvs	14, cr6, [r4], #-388	; 0xfffffe7c
     e5c:	72505f65 	subsvc	r5, r0, #404	; 0x194
     e60:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     e64:	57535f73 			; <UNDEFINED> instruction: 0x57535f73
     e68:	30324549 	eorscc	r4, r2, r9, asr #10
     e6c:	4957534e 	ldmdbmi	r7, {r1, r2, r3, r6, r8, r9, ip, lr}^
     e70:	6f72505f 	svcvs	0x0072505f
     e74:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     e78:	7265535f 	rsbvc	r5, r5, #2080374785	; 0x7c000001
     e7c:	65636976 	strbvs	r6, [r3, #-2422]!	; 0xfffff68a
     e80:	526a6a6a 	rsbpl	r6, sl, #434176	; 0x6a000
     e84:	53543131 	cmppl	r4, #1073741836	; 0x4000000c
     e88:	525f4957 	subspl	r4, pc, #1425408	; 0x15c000
     e8c:	6c757365 	ldclvs	3, cr7, [r5], #-404	; 0xfffffe6c
     e90:	494e0074 	stmdbmi	lr, {r2, r4, r5, r6}^
     e94:	6c74434f 	ldclvs	3, cr4, [r4], #-316	; 0xfffffec4
     e98:	65704f5f 	ldrbvs	r4, [r0, #-3935]!	; 0xfffff0a1
     e9c:	69746172 	ldmdbvs	r4!, {r1, r4, r5, r6, r8, sp, lr}^
     ea0:	5f006e6f 	svcpl	0x00006e6f
     ea4:	36314e5a 			; <UNDEFINED> instruction: 0x36314e5a
     ea8:	6f725043 	svcvs	0x00725043
     eac:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     eb0:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     eb4:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     eb8:	72433431 	subvc	r3, r3, #822083584	; 0x31000000
     ebc:	65746165 	ldrbvs	r6, [r4, #-357]!	; 0xfffffe9b
     ec0:	6f72505f 	svcvs	0x0072505f
     ec4:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     ec8:	6a685045 	bvs	1a14fe4 <__bss_end+0x1a0c1c4>
     ecc:	77530062 	ldrbvc	r0, [r3, -r2, rrx]
     ed0:	68637469 	stmdavs	r3!, {r0, r3, r5, r6, sl, ip, sp, lr}^
     ed4:	006f545f 	rsbeq	r5, pc, pc, asr r4	; <UNPREDICTABLE>
     ed8:	4957534e 	ldmdbmi	r7, {r1, r2, r3, r6, r8, r9, ip, lr}^
     edc:	6c69465f 	stclvs	6, cr4, [r9], #-380	; 0xfffffe84
     ee0:	73797365 	cmnvc	r9, #-1811939327	; 0x94000001
     ee4:	5f6d6574 	svcpl	0x006d6574
     ee8:	76726553 			; <UNDEFINED> instruction: 0x76726553
     eec:	00656369 	rsbeq	r6, r5, r9, ror #6
     ef0:	63746572 	cmnvs	r4, #478150656	; 0x1c800000
     ef4:	0065646f 	rsbeq	r6, r5, pc, ror #8
     ef8:	5f746567 	svcpl	0x00746567
     efc:	69746361 	ldmdbvs	r4!, {r0, r5, r6, r8, r9, sp, lr}^
     f00:	705f6576 	subsvc	r6, pc, r6, ror r5	; <UNPREDICTABLE>
     f04:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     f08:	635f7373 	cmpvs	pc, #-872415231	; 0xcc000001
     f0c:	746e756f 	strbtvc	r7, [lr], #-1391	; 0xfffffa91
     f10:	6c696600 	stclvs	6, cr6, [r9], #-0
     f14:	6d616e65 	stclvs	14, cr6, [r1, #-404]!	; 0xfffffe6c
     f18:	6c420065 	mcrrvs	0, 6, r0, r2, cr5
     f1c:	5f6b636f 	svcpl	0x006b636f
     f20:	72727543 	rsbsvc	r7, r2, #281018368	; 0x10c00000
     f24:	5f746e65 	svcpl	0x00746e65
     f28:	636f7250 	cmnvs	pc, #80, 4
     f2c:	00737365 	rsbseq	r7, r3, r5, ror #6
     f30:	64616572 	strbtvs	r6, [r1], #-1394	; 0xfffffa8e
     f34:	6f6c4300 	svcvs	0x006c4300
     f38:	67006573 	smlsdxvs	r0, r3, r5, r6
     f3c:	69707465 	ldmdbvs	r0!, {r0, r2, r5, r6, sl, ip, sp, lr}^
     f40:	5a5f0064 	bpl	17c10d8 <__bss_end+0x17b82b8>
     f44:	65706f34 	ldrbvs	r6, [r0, #-3892]!	; 0xfffff0cc
     f48:	634b506e 	movtvs	r5, #45166	; 0xb06e
     f4c:	464e3531 			; <UNDEFINED> instruction: 0x464e3531
     f50:	5f656c69 	svcpl	0x00656c69
     f54:	6e65704f 	cdpvs	0, 6, cr7, cr5, cr15, {2}
     f58:	646f4d5f 	strbtvs	r4, [pc], #-3423	; f60 <shift+0xf60>
     f5c:	72570065 	subsvc	r0, r7, #101	; 0x65
     f60:	5f657469 	svcpl	0x00657469
     f64:	796c6e4f 	stmdbvc	ip!, {r0, r1, r2, r3, r6, r9, sl, fp, sp, lr}^
     f68:	65695900 	strbvs	r5, [r9, #-2304]!	; 0xfffff700
     f6c:	5f00646c 	svcpl	0x0000646c
     f70:	36314e5a 			; <UNDEFINED> instruction: 0x36314e5a
     f74:	6f725043 	svcvs	0x00725043
     f78:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     f7c:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     f80:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     f84:	76453443 	strbvc	r3, [r5], -r3, asr #8
     f88:	72655400 	rsbvc	r5, r5, #0, 8
     f8c:	616e696d 	cmnvs	lr, sp, ror #18
     f90:	49006574 	stmdbmi	r0, {r2, r4, r5, r6, r8, sl, sp, lr}
     f94:	6c74434f 	ldclvs	3, cr4, [r4], #-316	; 0xfffffec4
     f98:	706e6900 	rsbvc	r6, lr, r0, lsl #18
     f9c:	64007475 	strvs	r7, [r0], #-1141	; 0xfffffb8b
     fa0:	00747365 	rsbseq	r7, r4, r5, ror #6
     fa4:	72657a62 	rsbvc	r7, r5, #401408	; 0x62000
     fa8:	656c006f 	strbvs	r0, [ip, #-111]!	; 0xffffff91
     fac:	6874676e 	ldmdavs	r4!, {r1, r2, r3, r5, r6, r8, r9, sl, sp, lr}^
     fb0:	355a5f00 	ldrbcc	r5, [sl, #-3840]	; 0xfffff100
     fb4:	72657a62 	rsbvc	r7, r5, #401408	; 0x62000
     fb8:	6976506f 	ldmdbvs	r6!, {r0, r1, r2, r3, r5, r6, ip, lr}^
     fbc:	73552f00 	cmpvc	r5, #0, 30
     fc0:	2f737265 	svccs	0x00737265
     fc4:	746e6977 	strbtvc	r6, [lr], #-2423	; 0xfffff689
     fc8:	696a7265 	stmdbvs	sl!, {r0, r2, r5, r6, r9, ip, sp, lr}^
     fcc:	7365442f 	cmnvc	r5, #788529152	; 0x2f000000
     fd0:	706f746b 	rsbvc	r7, pc, fp, ror #8
     fd4:	5641462f 	strbpl	r4, [r1], -pc, lsr #12
     fd8:	76614e2f 	strbtvc	r4, [r1], -pc, lsr #28
     fdc:	6a757a61 	bvs	1d5f968 <__bss_end+0x1d56b48>
     fe0:	2f696369 	svccs	0x00696369
     fe4:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
     fe8:	73656d65 	cmnvc	r5, #6464	; 0x1940
     fec:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
     ff0:	6b2d616b 	blvs	b595a4 <__bss_end+0xb50784>
     ff4:	6f2d7669 	svcvs	0x002d7669
     ff8:	6f732f73 	svcvs	0x00732f73
     ffc:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
    1000:	74732f73 	ldrbtvc	r2, [r3], #-3955	; 0xfffff08d
    1004:	62696c64 	rsbvs	r6, r9, #100, 24	; 0x6400
    1008:	6372732f 	cmnvs	r2, #-1140850688	; 0xbc000000
    100c:	6474732f 	ldrbtvs	r7, [r4], #-815	; 0xfffffcd1
    1010:	69727473 	ldmdbvs	r2!, {r0, r1, r4, r5, r6, sl, ip, sp, lr}^
    1014:	632e676e 			; <UNDEFINED> instruction: 0x632e676e
    1018:	5f007070 	svcpl	0x00007070
    101c:	7461345a 	strbtvc	r3, [r1], #-1114	; 0xfffffba6
    1020:	4b50696f 	blmi	141b5e4 <__bss_end+0x14127c4>
    1024:	68430063 	stmdavs	r3, {r0, r1, r5, r6}^
    1028:	6f437261 	svcvs	0x00437261
    102c:	7241766e 	subvc	r7, r1, #115343360	; 0x6e00000
    1030:	656d0072 	strbvs	r0, [sp, #-114]!	; 0xffffff8e
    1034:	7473646d 	ldrbtvc	r6, [r3], #-1133	; 0xfffffb93
    1038:	74756f00 	ldrbtvc	r6, [r5], #-3840	; 0xfffff100
    103c:	00747570 	rsbseq	r7, r4, r0, ror r5
    1040:	6d365a5f 	vldmdbvs	r6!, {s10-s104}
    1044:	70636d65 	rsbvc	r6, r3, r5, ror #26
    1048:	764b5079 			; <UNDEFINED> instruction: 0x764b5079
    104c:	00697650 	rsbeq	r7, r9, r0, asr r6
    1050:	65736162 	ldrbvs	r6, [r3, #-354]!	; 0xfffffe9e
    1054:	6d656d00 	stclvs	13, cr6, [r5, #-0]
    1058:	00797063 	rsbseq	r7, r9, r3, rrx
    105c:	6c727473 	cfldrdvs	mvd7, [r2], #-460	; 0xfffffe34
    1060:	5f006e65 	svcpl	0x00006e65
    1064:	7473375a 	ldrbtvc	r3, [r3], #-1882	; 0xfffff8a6
    1068:	6d636e72 	stclvs	14, cr6, [r3, #-456]!	; 0xfffffe38
    106c:	634b5070 	movtvs	r5, #45168	; 0xb070
    1070:	695f3053 	ldmdbvs	pc, {r0, r1, r4, r6, ip, sp}^	; <UNPREDICTABLE>
    1074:	365a5f00 	ldrbcc	r5, [sl], -r0, lsl #30
    1078:	6c727473 	cfldrdvs	mvd7, [r2], #-460	; 0xfffffe34
    107c:	4b506e65 	blmi	141ca18 <__bss_end+0x1413bf8>
    1080:	74610063 	strbtvc	r0, [r1], #-99	; 0xffffff9d
    1084:	5f00696f 	svcpl	0x0000696f
    1088:	7473375a 	ldrbtvc	r3, [r3], #-1882	; 0xfffff8a6
    108c:	70636e72 	rsbvc	r6, r3, r2, ror lr
    1090:	50635079 	rsbpl	r5, r3, r9, ror r0
    1094:	0069634b 	rsbeq	r6, r9, fp, asr #6
    1098:	6e727473 	mrcvs	4, 3, r7, cr2, cr3, {3}
    109c:	00706d63 	rsbseq	r6, r0, r3, ror #26
    10a0:	6e727473 	mrcvs	4, 3, r7, cr2, cr3, {3}
    10a4:	00797063 	rsbseq	r7, r9, r3, rrx
    10a8:	6f6d656d 	svcvs	0x006d656d
    10ac:	6d007972 	vstrvs.16	s14, [r0, #-228]	; 0xffffff1c	; <UNPREDICTABLE>
    10b0:	72736d65 	rsbsvc	r6, r3, #6464	; 0x1940
    10b4:	74690063 	strbtvc	r0, [r9], #-99	; 0xffffff9d
    10b8:	5f00616f 	svcpl	0x0000616f
    10bc:	7469345a 	strbtvc	r3, [r9], #-1114	; 0xfffffba6
    10c0:	506a616f 	rsbpl	r6, sl, pc, ror #2
    10c4:	Address 0x00000000000010c4 is out of bounds.


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
  20:	8b040e42 	blhi	103930 <__bss_end+0xfab10>
  24:	0b0d4201 	bleq	350830 <__bss_end+0x347a10>
  28:	420d0d62 	andmi	r0, sp, #6272	; 0x1880
  2c:	00000ecb 	andeq	r0, r0, fp, asr #29
  30:	0000001c 	andeq	r0, r0, ip, lsl r0
  34:	00000000 	andeq	r0, r0, r0
  38:	00008064 	andeq	r8, r0, r4, rrx
  3c:	00000040 	andeq	r0, r0, r0, asr #32
  40:	8b080e42 	blhi	203950 <__bss_end+0x1fab30>
  44:	42018e02 	andmi	r8, r1, #2, 28
  48:	5a040b0c 	bpl	102c80 <__bss_end+0xf9e60>
  4c:	00080d0c 	andeq	r0, r8, ip, lsl #26
  50:	0000000c 	andeq	r0, r0, ip
  54:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
  58:	7c020001 	stcvc	0, cr0, [r2], {1}
  5c:	000d0c0e 	andeq	r0, sp, lr, lsl #24
  60:	0000001c 	andeq	r0, r0, ip, lsl r0
  64:	00000050 	andeq	r0, r0, r0, asr r0
  68:	000080a4 	andeq	r8, r0, r4, lsr #1
  6c:	00000038 	andeq	r0, r0, r8, lsr r0
  70:	8b040e42 	blhi	103980 <__bss_end+0xfab60>
  74:	0b0d4201 	bleq	350880 <__bss_end+0x347a60>
  78:	420d0d54 	andmi	r0, sp, #84, 26	; 0x1500
  7c:	00000ecb 	andeq	r0, r0, fp, asr #29
  80:	0000001c 	andeq	r0, r0, ip, lsl r0
  84:	00000050 	andeq	r0, r0, r0, asr r0
  88:	000080dc 	ldrdeq	r8, [r0], -ip
  8c:	0000002c 	andeq	r0, r0, ip, lsr #32
  90:	8b040e42 	blhi	1039a0 <__bss_end+0xfab80>
  94:	0b0d4201 	bleq	3508a0 <__bss_end+0x347a80>
  98:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
  9c:	00000ecb 	andeq	r0, r0, fp, asr #29
  a0:	0000001c 	andeq	r0, r0, ip, lsl r0
  a4:	00000050 	andeq	r0, r0, r0, asr r0
  a8:	00008108 	andeq	r8, r0, r8, lsl #2
  ac:	00000020 	andeq	r0, r0, r0, lsr #32
  b0:	8b040e42 	blhi	1039c0 <__bss_end+0xfaba0>
  b4:	0b0d4201 	bleq	3508c0 <__bss_end+0x347aa0>
  b8:	420d0d48 	andmi	r0, sp, #72, 26	; 0x1200
  bc:	00000ecb 	andeq	r0, r0, fp, asr #29
  c0:	0000001c 	andeq	r0, r0, ip, lsl r0
  c4:	00000050 	andeq	r0, r0, r0, asr r0
  c8:	00008128 	andeq	r8, r0, r8, lsr #2
  cc:	00000018 	andeq	r0, r0, r8, lsl r0
  d0:	8b040e42 	blhi	1039e0 <__bss_end+0xfabc0>
  d4:	0b0d4201 	bleq	3508e0 <__bss_end+0x347ac0>
  d8:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
  dc:	00000ecb 	andeq	r0, r0, fp, asr #29
  e0:	0000001c 	andeq	r0, r0, ip, lsl r0
  e4:	00000050 	andeq	r0, r0, r0, asr r0
  e8:	00008140 	andeq	r8, r0, r0, asr #2
  ec:	00000018 	andeq	r0, r0, r8, lsl r0
  f0:	8b040e42 	blhi	103a00 <__bss_end+0xfabe0>
  f4:	0b0d4201 	bleq	350900 <__bss_end+0x347ae0>
  f8:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
  fc:	00000ecb 	andeq	r0, r0, fp, asr #29
 100:	0000001c 	andeq	r0, r0, ip, lsl r0
 104:	00000050 	andeq	r0, r0, r0, asr r0
 108:	00008158 	andeq	r8, r0, r8, asr r1
 10c:	00000018 	andeq	r0, r0, r8, lsl r0
 110:	8b040e42 	blhi	103a20 <__bss_end+0xfac00>
 114:	0b0d4201 	bleq	350920 <__bss_end+0x347b00>
 118:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
 11c:	00000ecb 	andeq	r0, r0, fp, asr #29
 120:	00000014 	andeq	r0, r0, r4, lsl r0
 124:	00000050 	andeq	r0, r0, r0, asr r0
 128:	00008170 	andeq	r8, r0, r0, ror r1
 12c:	0000000c 	andeq	r0, r0, ip
 130:	8b040e42 	blhi	103a40 <__bss_end+0xfac20>
 134:	0b0d4201 	bleq	350940 <__bss_end+0x347b20>
 138:	0000001c 	andeq	r0, r0, ip, lsl r0
 13c:	00000050 	andeq	r0, r0, r0, asr r0
 140:	0000817c 	andeq	r8, r0, ip, ror r1
 144:	00000058 	andeq	r0, r0, r8, asr r0
 148:	8b080e42 	blhi	203a58 <__bss_end+0x1fac38>
 14c:	42018e02 	andmi	r8, r1, #2, 28
 150:	62040b0c 	andvs	r0, r4, #12, 22	; 0x3000
 154:	00080d0c 	andeq	r0, r8, ip, lsl #26
 158:	0000001c 	andeq	r0, r0, ip, lsl r0
 15c:	00000050 	andeq	r0, r0, r0, asr r0
 160:	000081d4 	ldrdeq	r8, [r0], -r4
 164:	00000058 	andeq	r0, r0, r8, asr r0
 168:	8b080e42 	blhi	203a78 <__bss_end+0x1fac58>
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
 194:	00000048 	andeq	r0, r0, r8, asr #32
 198:	8b080e42 	blhi	203aa8 <__bss_end+0x1fac88>
 19c:	42018e02 	andmi	r8, r1, #2, 28
 1a0:	00040b0c 	andeq	r0, r4, ip, lsl #22
 1a4:	0000000c 	andeq	r0, r0, ip
 1a8:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 1ac:	7c020001 	stcvc	0, cr0, [r2], {1}
 1b0:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 1b4:	0000001c 	andeq	r0, r0, ip, lsl r0
 1b8:	000001a4 	andeq	r0, r0, r4, lsr #3
 1bc:	00008274 	andeq	r8, r0, r4, ror r2
 1c0:	0000002c 	andeq	r0, r0, ip, lsr #32
 1c4:	8b040e42 	blhi	103ad4 <__bss_end+0xfacb4>
 1c8:	0b0d4201 	bleq	3509d4 <__bss_end+0x347bb4>
 1cc:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
 1d0:	00000ecb 	andeq	r0, r0, fp, asr #29
 1d4:	0000001c 	andeq	r0, r0, ip, lsl r0
 1d8:	000001a4 	andeq	r0, r0, r4, lsr #3
 1dc:	000082a0 	andeq	r8, r0, r0, lsr #5
 1e0:	0000002c 	andeq	r0, r0, ip, lsr #32
 1e4:	8b040e42 	blhi	103af4 <__bss_end+0xfacd4>
 1e8:	0b0d4201 	bleq	3509f4 <__bss_end+0x347bd4>
 1ec:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
 1f0:	00000ecb 	andeq	r0, r0, fp, asr #29
 1f4:	0000001c 	andeq	r0, r0, ip, lsl r0
 1f8:	000001a4 	andeq	r0, r0, r4, lsr #3
 1fc:	000082cc 	andeq	r8, r0, ip, asr #5
 200:	0000001c 	andeq	r0, r0, ip, lsl r0
 204:	8b040e42 	blhi	103b14 <__bss_end+0xfacf4>
 208:	0b0d4201 	bleq	350a14 <__bss_end+0x347bf4>
 20c:	420d0d46 	andmi	r0, sp, #4480	; 0x1180
 210:	00000ecb 	andeq	r0, r0, fp, asr #29
 214:	0000001c 	andeq	r0, r0, ip, lsl r0
 218:	000001a4 	andeq	r0, r0, r4, lsr #3
 21c:	000082e8 	andeq	r8, r0, r8, ror #5
 220:	00000044 	andeq	r0, r0, r4, asr #32
 224:	8b040e42 	blhi	103b34 <__bss_end+0xfad14>
 228:	0b0d4201 	bleq	350a34 <__bss_end+0x347c14>
 22c:	420d0d5a 	andmi	r0, sp, #5760	; 0x1680
 230:	00000ecb 	andeq	r0, r0, fp, asr #29
 234:	0000001c 	andeq	r0, r0, ip, lsl r0
 238:	000001a4 	andeq	r0, r0, r4, lsr #3
 23c:	0000832c 	andeq	r8, r0, ip, lsr #6
 240:	00000050 	andeq	r0, r0, r0, asr r0
 244:	8b040e42 	blhi	103b54 <__bss_end+0xfad34>
 248:	0b0d4201 	bleq	350a54 <__bss_end+0x347c34>
 24c:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 250:	00000ecb 	andeq	r0, r0, fp, asr #29
 254:	0000001c 	andeq	r0, r0, ip, lsl r0
 258:	000001a4 	andeq	r0, r0, r4, lsr #3
 25c:	0000837c 	andeq	r8, r0, ip, ror r3
 260:	00000050 	andeq	r0, r0, r0, asr r0
 264:	8b040e42 	blhi	103b74 <__bss_end+0xfad54>
 268:	0b0d4201 	bleq	350a74 <__bss_end+0x347c54>
 26c:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 270:	00000ecb 	andeq	r0, r0, fp, asr #29
 274:	0000001c 	andeq	r0, r0, ip, lsl r0
 278:	000001a4 	andeq	r0, r0, r4, lsr #3
 27c:	000083cc 	andeq	r8, r0, ip, asr #7
 280:	0000002c 	andeq	r0, r0, ip, lsr #32
 284:	8b040e42 	blhi	103b94 <__bss_end+0xfad74>
 288:	0b0d4201 	bleq	350a94 <__bss_end+0x347c74>
 28c:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
 290:	00000ecb 	andeq	r0, r0, fp, asr #29
 294:	0000001c 	andeq	r0, r0, ip, lsl r0
 298:	000001a4 	andeq	r0, r0, r4, lsr #3
 29c:	000083f8 	strdeq	r8, [r0], -r8	; <UNPREDICTABLE>
 2a0:	00000050 	andeq	r0, r0, r0, asr r0
 2a4:	8b040e42 	blhi	103bb4 <__bss_end+0xfad94>
 2a8:	0b0d4201 	bleq	350ab4 <__bss_end+0x347c94>
 2ac:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 2b0:	00000ecb 	andeq	r0, r0, fp, asr #29
 2b4:	0000001c 	andeq	r0, r0, ip, lsl r0
 2b8:	000001a4 	andeq	r0, r0, r4, lsr #3
 2bc:	00008448 	andeq	r8, r0, r8, asr #8
 2c0:	00000044 	andeq	r0, r0, r4, asr #32
 2c4:	8b040e42 	blhi	103bd4 <__bss_end+0xfadb4>
 2c8:	0b0d4201 	bleq	350ad4 <__bss_end+0x347cb4>
 2cc:	420d0d5a 	andmi	r0, sp, #5760	; 0x1680
 2d0:	00000ecb 	andeq	r0, r0, fp, asr #29
 2d4:	0000001c 	andeq	r0, r0, ip, lsl r0
 2d8:	000001a4 	andeq	r0, r0, r4, lsr #3
 2dc:	0000848c 	andeq	r8, r0, ip, lsl #9
 2e0:	00000050 	andeq	r0, r0, r0, asr r0
 2e4:	8b040e42 	blhi	103bf4 <__bss_end+0xfadd4>
 2e8:	0b0d4201 	bleq	350af4 <__bss_end+0x347cd4>
 2ec:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 2f0:	00000ecb 	andeq	r0, r0, fp, asr #29
 2f4:	0000001c 	andeq	r0, r0, ip, lsl r0
 2f8:	000001a4 	andeq	r0, r0, r4, lsr #3
 2fc:	000084dc 	ldrdeq	r8, [r0], -ip
 300:	00000054 	andeq	r0, r0, r4, asr r0
 304:	8b040e42 	blhi	103c14 <__bss_end+0xfadf4>
 308:	0b0d4201 	bleq	350b14 <__bss_end+0x347cf4>
 30c:	420d0d62 	andmi	r0, sp, #6272	; 0x1880
 310:	00000ecb 	andeq	r0, r0, fp, asr #29
 314:	0000001c 	andeq	r0, r0, ip, lsl r0
 318:	000001a4 	andeq	r0, r0, r4, lsr #3
 31c:	00008530 	andeq	r8, r0, r0, lsr r5
 320:	0000003c 	andeq	r0, r0, ip, lsr r0
 324:	8b040e42 	blhi	103c34 <__bss_end+0xfae14>
 328:	0b0d4201 	bleq	350b34 <__bss_end+0x347d14>
 32c:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 330:	00000ecb 	andeq	r0, r0, fp, asr #29
 334:	0000001c 	andeq	r0, r0, ip, lsl r0
 338:	000001a4 	andeq	r0, r0, r4, lsr #3
 33c:	0000856c 	andeq	r8, r0, ip, ror #10
 340:	0000003c 	andeq	r0, r0, ip, lsr r0
 344:	8b040e42 	blhi	103c54 <__bss_end+0xfae34>
 348:	0b0d4201 	bleq	350b54 <__bss_end+0x347d34>
 34c:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 350:	00000ecb 	andeq	r0, r0, fp, asr #29
 354:	0000001c 	andeq	r0, r0, ip, lsl r0
 358:	000001a4 	andeq	r0, r0, r4, lsr #3
 35c:	000085a8 	andeq	r8, r0, r8, lsr #11
 360:	0000003c 	andeq	r0, r0, ip, lsr r0
 364:	8b040e42 	blhi	103c74 <__bss_end+0xfae54>
 368:	0b0d4201 	bleq	350b74 <__bss_end+0x347d54>
 36c:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 370:	00000ecb 	andeq	r0, r0, fp, asr #29
 374:	0000001c 	andeq	r0, r0, ip, lsl r0
 378:	000001a4 	andeq	r0, r0, r4, lsr #3
 37c:	000085e4 	andeq	r8, r0, r4, ror #11
 380:	0000003c 	andeq	r0, r0, ip, lsr r0
 384:	8b040e42 	blhi	103c94 <__bss_end+0xfae74>
 388:	0b0d4201 	bleq	350b94 <__bss_end+0x347d74>
 38c:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 390:	00000ecb 	andeq	r0, r0, fp, asr #29
 394:	0000001c 	andeq	r0, r0, ip, lsl r0
 398:	000001a4 	andeq	r0, r0, r4, lsr #3
 39c:	00008620 	andeq	r8, r0, r0, lsr #12
 3a0:	000000b0 	strheq	r0, [r0], -r0	; <UNPREDICTABLE>
 3a4:	8b080e42 	blhi	203cb4 <__bss_end+0x1fae94>
 3a8:	42018e02 	andmi	r8, r1, #2, 28
 3ac:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 3b0:	080d0c50 	stmdaeq	sp, {r4, r6, sl, fp}
 3b4:	0000000c 	andeq	r0, r0, ip
 3b8:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 3bc:	7c020001 	stcvc	0, cr0, [r2], {1}
 3c0:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 3c4:	0000001c 	andeq	r0, r0, ip, lsl r0
 3c8:	000003b4 			; <UNDEFINED> instruction: 0x000003b4
 3cc:	000086d0 	ldrdeq	r8, [r0], -r0
 3d0:	00000174 	andeq	r0, r0, r4, ror r1
 3d4:	8b080e42 	blhi	203ce4 <__bss_end+0x1faec4>
 3d8:	42018e02 	andmi	r8, r1, #2, 28
 3dc:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 3e0:	080d0cb2 	stmdaeq	sp, {r1, r4, r5, r7, sl, fp}
 3e4:	0000001c 	andeq	r0, r0, ip, lsl r0
 3e8:	000003b4 			; <UNDEFINED> instruction: 0x000003b4
 3ec:	00008844 	andeq	r8, r0, r4, asr #16
 3f0:	0000009c 	muleq	r0, ip, r0
 3f4:	8b040e42 	blhi	103d04 <__bss_end+0xfaee4>
 3f8:	0b0d4201 	bleq	350c04 <__bss_end+0x347de4>
 3fc:	0d0d4602 	stceq	6, cr4, [sp, #-8]
 400:	000ecb42 	andeq	ip, lr, r2, asr #22
 404:	0000001c 	andeq	r0, r0, ip, lsl r0
 408:	000003b4 			; <UNDEFINED> instruction: 0x000003b4
 40c:	000088e0 	andeq	r8, r0, r0, ror #17
 410:	000000c0 	andeq	r0, r0, r0, asr #1
 414:	8b040e42 	blhi	103d24 <__bss_end+0xfaf04>
 418:	0b0d4201 	bleq	350c24 <__bss_end+0x347e04>
 41c:	0d0d5802 	stceq	8, cr5, [sp, #-8]
 420:	000ecb42 	andeq	ip, lr, r2, asr #22
 424:	0000001c 	andeq	r0, r0, ip, lsl r0
 428:	000003b4 			; <UNDEFINED> instruction: 0x000003b4
 42c:	000089a0 	andeq	r8, r0, r0, lsr #19
 430:	000000ac 	andeq	r0, r0, ip, lsr #1
 434:	8b040e42 	blhi	103d44 <__bss_end+0xfaf24>
 438:	0b0d4201 	bleq	350c44 <__bss_end+0x347e24>
 43c:	0d0d4e02 	stceq	14, cr4, [sp, #-8]
 440:	000ecb42 	andeq	ip, lr, r2, asr #22
 444:	0000001c 	andeq	r0, r0, ip, lsl r0
 448:	000003b4 			; <UNDEFINED> instruction: 0x000003b4
 44c:	00008a4c 	andeq	r8, r0, ip, asr #20
 450:	00000054 	andeq	r0, r0, r4, asr r0
 454:	8b040e42 	blhi	103d64 <__bss_end+0xfaf44>
 458:	0b0d4201 	bleq	350c64 <__bss_end+0x347e44>
 45c:	420d0d62 	andmi	r0, sp, #6272	; 0x1880
 460:	00000ecb 	andeq	r0, r0, fp, asr #29
 464:	0000001c 	andeq	r0, r0, ip, lsl r0
 468:	000003b4 			; <UNDEFINED> instruction: 0x000003b4
 46c:	00008aa0 	andeq	r8, r0, r0, lsr #21
 470:	00000068 	andeq	r0, r0, r8, rrx
 474:	8b040e42 	blhi	103d84 <__bss_end+0xfaf64>
 478:	0b0d4201 	bleq	350c84 <__bss_end+0x347e64>
 47c:	420d0d6c 	andmi	r0, sp, #108, 26	; 0x1b00
 480:	00000ecb 	andeq	r0, r0, fp, asr #29
 484:	0000001c 	andeq	r0, r0, ip, lsl r0
 488:	000003b4 			; <UNDEFINED> instruction: 0x000003b4
 48c:	00008b08 	andeq	r8, r0, r8, lsl #22
 490:	00000080 	andeq	r0, r0, r0, lsl #1
 494:	8b040e42 	blhi	103da4 <__bss_end+0xfaf84>
 498:	0b0d4201 	bleq	350ca4 <__bss_end+0x347e84>
 49c:	420d0d78 	andmi	r0, sp, #120, 26	; 0x1e00
 4a0:	00000ecb 	andeq	r0, r0, fp, asr #29
 4a4:	0000000c 	andeq	r0, r0, ip
 4a8:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 4ac:	7c010001 	stcvc	0, cr0, [r1], {1}
 4b0:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 4b4:	0000000c 	andeq	r0, r0, ip
 4b8:	000004a4 	andeq	r0, r0, r4, lsr #9
 4bc:	00008b88 	andeq	r8, r0, r8, lsl #23
 4c0:	000001ec 	andeq	r0, r0, ip, ror #3
