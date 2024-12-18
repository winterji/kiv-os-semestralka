
./slave_task:     file format elf32-littlearm


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
    805c:	00008f1c 	andeq	r8, r0, ip, lsl pc
    8060:	00008f34 	andeq	r8, r0, r4, lsr pc

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
    81cc:	00008f19 	andeq	r8, r0, r9, lsl pc
    81d0:	00008f19 	andeq	r8, r0, r9, lsl pc

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
    8224:	00008f19 	andeq	r8, r0, r9, lsl pc
    8228:	00008f19 	andeq	r8, r0, r9, lsl pc

0000822c <main>:
main():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:46
//     itoa(rndNum, temp_buff, 10);
//     write(uart, temp_buff, strlen(temp_buff));
// }

int main(int argc, char** argv)
{
    822c:	e92d4800 	push	{fp, lr}
    8230:	e28db004 	add	fp, sp, #4
    8234:	e24dd010 	sub	sp, sp, #16
    8238:	e50b0010 	str	r0, [fp, #-16]
    823c:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:49
    char buff[4];

    log = pipe("log", 32);
    8240:	e3a01020 	mov	r1, #32
    8244:	e59f007c 	ldr	r0, [pc, #124]	; 82c8 <main+0x9c>
    8248:	eb000110 	bl	8690 <_Z4pipePKcj>
    824c:	e1a03000 	mov	r3, r0
    8250:	e59f2074 	ldr	r2, [pc, #116]	; 82cc <main+0xa0>
    8254:	e5823000 	str	r3, [r2]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:51

    write(log, "Slave task started\n", 19);
    8258:	e59f306c 	ldr	r3, [pc, #108]	; 82cc <main+0xa0>
    825c:	e5933000 	ldr	r3, [r3]
    8260:	e3a02013 	mov	r2, #19
    8264:	e59f1064 	ldr	r1, [pc, #100]	; 82d0 <main+0xa4>
    8268:	e1a00003 	mov	r0, r3
    826c:	eb00005e 	bl	83ec <_Z5writejPKcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:54

    // start i2c connection
    slave = open("DEV:i2c/2", NFile_Open_Mode::Read_Write);
    8270:	e3a01002 	mov	r1, #2
    8274:	e59f0058 	ldr	r0, [pc, #88]	; 82d4 <main+0xa8>
    8278:	eb000036 	bl	8358 <_Z4openPKc15NFile_Open_Mode>
    827c:	e1a03000 	mov	r3, r0
    8280:	e59f2050 	ldr	r2, [pc, #80]	; 82d8 <main+0xac>
    8284:	e5823000 	str	r3, [r2]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:55
    write(log, "I2C connection slave started...\n", 30);
    8288:	e59f303c 	ldr	r3, [pc, #60]	; 82cc <main+0xa0>
    828c:	e5933000 	ldr	r3, [r3]
    8290:	e3a0201e 	mov	r2, #30
    8294:	e59f1040 	ldr	r1, [pc, #64]	; 82dc <main+0xb0>
    8298:	e1a00003 	mov	r0, r3
    829c:	eb000052 	bl	83ec <_Z5writejPKcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:57 (discriminator 1)
    for (;;) {
        write(log, "Hello from slave\n", 17);
    82a0:	e59f3024 	ldr	r3, [pc, #36]	; 82cc <main+0xa0>
    82a4:	e5933000 	ldr	r3, [r3]
    82a8:	e3a02011 	mov	r2, #17
    82ac:	e59f102c 	ldr	r1, [pc, #44]	; 82e0 <main+0xb4>
    82b0:	e1a00003 	mov	r0, r3
    82b4:	eb00004c 	bl	83ec <_Z5writejPKcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:58 (discriminator 1)
        sleep(0x10000);
    82b8:	e3e01001 	mvn	r1, #1
    82bc:	e3a00801 	mov	r0, #65536	; 0x10000
    82c0:	eb0000a1 	bl	854c <_Z5sleepjj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:57 (discriminator 1)
        write(log, "Hello from slave\n", 17);
    82c4:	eafffff5 	b	82a0 <main+0x74>
    82c8:	00008e74 	andeq	r8, r0, r4, ror lr
    82cc:	00008f1c 	andeq	r8, r0, ip, lsl pc
    82d0:	00008e78 	andeq	r8, r0, r8, ror lr
    82d4:	00008e8c 	andeq	r8, r0, ip, lsl #29
    82d8:	00008f20 	andeq	r8, r0, r0, lsr #30
    82dc:	00008e98 	muleq	r0, r8, lr
    82e0:	00008ebc 			; <UNDEFINED> instruction: 0x00008ebc

000082e4 <_Z6getpidv>:
_Z6getpidv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:5
#include <stdfile.h>
#include <stdstring.h>

uint32_t getpid()
{
    82e4:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    82e8:	e28db000 	add	fp, sp, #0
    82ec:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:8
    uint32_t pid;

    asm volatile("swi 0");
    82f0:	ef000000 	svc	0x00000000
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:9
    asm volatile("mov %0, r0" : "=r" (pid));
    82f4:	e1a03000 	mov	r3, r0
    82f8:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:11

    return pid;
    82fc:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:12
}
    8300:	e1a00003 	mov	r0, r3
    8304:	e28bd000 	add	sp, fp, #0
    8308:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    830c:	e12fff1e 	bx	lr

00008310 <_Z9terminatei>:
_Z9terminatei():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:15

void terminate(int exitcode)
{
    8310:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8314:	e28db000 	add	fp, sp, #0
    8318:	e24dd00c 	sub	sp, sp, #12
    831c:	e50b0008 	str	r0, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:16
    asm volatile("mov r0, %0" : : "r" (exitcode));
    8320:	e51b3008 	ldr	r3, [fp, #-8]
    8324:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:17
    asm volatile("swi 1");
    8328:	ef000001 	svc	0x00000001
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:18
}
    832c:	e320f000 	nop	{0}
    8330:	e28bd000 	add	sp, fp, #0
    8334:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8338:	e12fff1e 	bx	lr

0000833c <_Z11sched_yieldv>:
_Z11sched_yieldv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:21

void sched_yield()
{
    833c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8340:	e28db000 	add	fp, sp, #0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:22
    asm volatile("swi 2");
    8344:	ef000002 	svc	0x00000002
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:23
}
    8348:	e320f000 	nop	{0}
    834c:	e28bd000 	add	sp, fp, #0
    8350:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8354:	e12fff1e 	bx	lr

00008358 <_Z4openPKc15NFile_Open_Mode>:
_Z4openPKc15NFile_Open_Mode():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:26

uint32_t open(const char* filename, NFile_Open_Mode mode)
{
    8358:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    835c:	e28db000 	add	fp, sp, #0
    8360:	e24dd014 	sub	sp, sp, #20
    8364:	e50b0010 	str	r0, [fp, #-16]
    8368:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:29
    uint32_t file;

    asm volatile("mov r0, %0" : : "r" (filename));
    836c:	e51b3010 	ldr	r3, [fp, #-16]
    8370:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:30
    asm volatile("mov r1, %0" : : "r" (mode));
    8374:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8378:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:31
    asm volatile("swi 64");
    837c:	ef000040 	svc	0x00000040
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:32
    asm volatile("mov %0, r0" : "=r" (file));
    8380:	e1a03000 	mov	r3, r0
    8384:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:34

    return file;
    8388:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:35
}
    838c:	e1a00003 	mov	r0, r3
    8390:	e28bd000 	add	sp, fp, #0
    8394:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8398:	e12fff1e 	bx	lr

0000839c <_Z4readjPcj>:
_Z4readjPcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:38

uint32_t read(uint32_t file, char* const buffer, uint32_t size)
{
    839c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    83a0:	e28db000 	add	fp, sp, #0
    83a4:	e24dd01c 	sub	sp, sp, #28
    83a8:	e50b0010 	str	r0, [fp, #-16]
    83ac:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    83b0:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:41
    uint32_t rdnum;

    asm volatile("mov r0, %0" : : "r" (file));
    83b4:	e51b3010 	ldr	r3, [fp, #-16]
    83b8:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:42
    asm volatile("mov r1, %0" : : "r" (buffer));
    83bc:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    83c0:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:43
    asm volatile("mov r2, %0" : : "r" (size));
    83c4:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    83c8:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:44
    asm volatile("swi 65");
    83cc:	ef000041 	svc	0x00000041
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:45
    asm volatile("mov %0, r0" : "=r" (rdnum));
    83d0:	e1a03000 	mov	r3, r0
    83d4:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:47

    return rdnum;
    83d8:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:48
}
    83dc:	e1a00003 	mov	r0, r3
    83e0:	e28bd000 	add	sp, fp, #0
    83e4:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    83e8:	e12fff1e 	bx	lr

000083ec <_Z5writejPKcj>:
_Z5writejPKcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:51

uint32_t write(uint32_t file, const char* buffer, uint32_t size)
{
    83ec:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    83f0:	e28db000 	add	fp, sp, #0
    83f4:	e24dd01c 	sub	sp, sp, #28
    83f8:	e50b0010 	str	r0, [fp, #-16]
    83fc:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8400:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:54
    uint32_t wrnum;

    asm volatile("mov r0, %0" : : "r" (file));
    8404:	e51b3010 	ldr	r3, [fp, #-16]
    8408:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:55
    asm volatile("mov r1, %0" : : "r" (buffer));
    840c:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8410:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:56
    asm volatile("mov r2, %0" : : "r" (size));
    8414:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8418:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:57
    asm volatile("swi 66");
    841c:	ef000042 	svc	0x00000042
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:58
    asm volatile("mov %0, r0" : "=r" (wrnum));
    8420:	e1a03000 	mov	r3, r0
    8424:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:60

    return wrnum;
    8428:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:61
}
    842c:	e1a00003 	mov	r0, r3
    8430:	e28bd000 	add	sp, fp, #0
    8434:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8438:	e12fff1e 	bx	lr

0000843c <_Z5closej>:
_Z5closej():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:64

void close(uint32_t file)
{
    843c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8440:	e28db000 	add	fp, sp, #0
    8444:	e24dd00c 	sub	sp, sp, #12
    8448:	e50b0008 	str	r0, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:65
    asm volatile("mov r0, %0" : : "r" (file));
    844c:	e51b3008 	ldr	r3, [fp, #-8]
    8450:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:66
    asm volatile("swi 67");
    8454:	ef000043 	svc	0x00000043
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:67
}
    8458:	e320f000 	nop	{0}
    845c:	e28bd000 	add	sp, fp, #0
    8460:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8464:	e12fff1e 	bx	lr

00008468 <_Z5ioctlj16NIOCtl_OperationPv>:
_Z5ioctlj16NIOCtl_OperationPv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:70

uint32_t ioctl(uint32_t file, NIOCtl_Operation operation, void* param)
{
    8468:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    846c:	e28db000 	add	fp, sp, #0
    8470:	e24dd01c 	sub	sp, sp, #28
    8474:	e50b0010 	str	r0, [fp, #-16]
    8478:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    847c:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:73
    uint32_t retcode;

    asm volatile("mov r0, %0" : : "r" (file));
    8480:	e51b3010 	ldr	r3, [fp, #-16]
    8484:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:74
    asm volatile("mov r1, %0" : : "r" (operation));
    8488:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    848c:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:75
    asm volatile("mov r2, %0" : : "r" (param));
    8490:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8494:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:76
    asm volatile("swi 68");
    8498:	ef000044 	svc	0x00000044
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:77
    asm volatile("mov %0, r0" : "=r" (retcode));
    849c:	e1a03000 	mov	r3, r0
    84a0:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:79

    return retcode;
    84a4:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:80
}
    84a8:	e1a00003 	mov	r0, r3
    84ac:	e28bd000 	add	sp, fp, #0
    84b0:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    84b4:	e12fff1e 	bx	lr

000084b8 <_Z6notifyjj>:
_Z6notifyjj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:83

uint32_t notify(uint32_t file, uint32_t count)
{
    84b8:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    84bc:	e28db000 	add	fp, sp, #0
    84c0:	e24dd014 	sub	sp, sp, #20
    84c4:	e50b0010 	str	r0, [fp, #-16]
    84c8:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:86
    uint32_t retcnt;

    asm volatile("mov r0, %0" : : "r" (file));
    84cc:	e51b3010 	ldr	r3, [fp, #-16]
    84d0:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:87
    asm volatile("mov r1, %0" : : "r" (count));
    84d4:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    84d8:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:88
    asm volatile("swi 69");
    84dc:	ef000045 	svc	0x00000045
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:89
    asm volatile("mov %0, r0" : "=r" (retcnt));
    84e0:	e1a03000 	mov	r3, r0
    84e4:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:91

    return retcnt;
    84e8:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:92
}
    84ec:	e1a00003 	mov	r0, r3
    84f0:	e28bd000 	add	sp, fp, #0
    84f4:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    84f8:	e12fff1e 	bx	lr

000084fc <_Z4waitjjj>:
_Z4waitjjj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:95

NSWI_Result_Code wait(uint32_t file, uint32_t count, uint32_t notified_deadline)
{
    84fc:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8500:	e28db000 	add	fp, sp, #0
    8504:	e24dd01c 	sub	sp, sp, #28
    8508:	e50b0010 	str	r0, [fp, #-16]
    850c:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8510:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:98
    NSWI_Result_Code retcode;

    asm volatile("mov r0, %0" : : "r" (file));
    8514:	e51b3010 	ldr	r3, [fp, #-16]
    8518:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:99
    asm volatile("mov r1, %0" : : "r" (count));
    851c:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8520:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:100
    asm volatile("mov r2, %0" : : "r" (notified_deadline));
    8524:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8528:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:101
    asm volatile("swi 70");
    852c:	ef000046 	svc	0x00000046
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:102
    asm volatile("mov %0, r0" : "=r" (retcode));
    8530:	e1a03000 	mov	r3, r0
    8534:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:104

    return retcode;
    8538:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:105
}
    853c:	e1a00003 	mov	r0, r3
    8540:	e28bd000 	add	sp, fp, #0
    8544:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8548:	e12fff1e 	bx	lr

0000854c <_Z5sleepjj>:
_Z5sleepjj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:108

bool sleep(uint32_t ticks, uint32_t notified_deadline)
{
    854c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8550:	e28db000 	add	fp, sp, #0
    8554:	e24dd014 	sub	sp, sp, #20
    8558:	e50b0010 	str	r0, [fp, #-16]
    855c:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:111
    uint32_t retcode;

    asm volatile("mov r0, %0" : : "r" (ticks));
    8560:	e51b3010 	ldr	r3, [fp, #-16]
    8564:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:112
    asm volatile("mov r1, %0" : : "r" (notified_deadline));
    8568:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    856c:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:113
    asm volatile("swi 3");
    8570:	ef000003 	svc	0x00000003
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:114
    asm volatile("mov %0, r0" : "=r" (retcode));
    8574:	e1a03000 	mov	r3, r0
    8578:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:116

    return retcode;
    857c:	e51b3008 	ldr	r3, [fp, #-8]
    8580:	e3530000 	cmp	r3, #0
    8584:	13a03001 	movne	r3, #1
    8588:	03a03000 	moveq	r3, #0
    858c:	e6ef3073 	uxtb	r3, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:117
}
    8590:	e1a00003 	mov	r0, r3
    8594:	e28bd000 	add	sp, fp, #0
    8598:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    859c:	e12fff1e 	bx	lr

000085a0 <_Z24get_active_process_countv>:
_Z24get_active_process_countv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:120

uint32_t get_active_process_count()
{
    85a0:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    85a4:	e28db000 	add	fp, sp, #0
    85a8:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:121
    const NGet_Sched_Info_Type req = NGet_Sched_Info_Type::Active_Process_Count;
    85ac:	e3a03000 	mov	r3, #0
    85b0:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:124
    uint32_t retval;

    asm volatile("mov r0, %0" : : "r" (req));
    85b4:	e3a03000 	mov	r3, #0
    85b8:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:125
    asm volatile("mov r1, %0" : : "r" (&retval));
    85bc:	e24b300c 	sub	r3, fp, #12
    85c0:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:126
    asm volatile("swi 4");
    85c4:	ef000004 	svc	0x00000004
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:128

    return retval;
    85c8:	e51b300c 	ldr	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:129
}
    85cc:	e1a00003 	mov	r0, r3
    85d0:	e28bd000 	add	sp, fp, #0
    85d4:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    85d8:	e12fff1e 	bx	lr

000085dc <_Z14get_tick_countv>:
_Z14get_tick_countv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:132

uint32_t get_tick_count()
{
    85dc:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    85e0:	e28db000 	add	fp, sp, #0
    85e4:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:133
    const NGet_Sched_Info_Type req = NGet_Sched_Info_Type::Tick_Count;
    85e8:	e3a03001 	mov	r3, #1
    85ec:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:136
    uint32_t retval;

    asm volatile("mov r0, %0" : : "r" (req));
    85f0:	e3a03001 	mov	r3, #1
    85f4:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:137
    asm volatile("mov r1, %0" : : "r" (&retval));
    85f8:	e24b300c 	sub	r3, fp, #12
    85fc:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:138
    asm volatile("swi 4");
    8600:	ef000004 	svc	0x00000004
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:140

    return retval;
    8604:	e51b300c 	ldr	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:141
}
    8608:	e1a00003 	mov	r0, r3
    860c:	e28bd000 	add	sp, fp, #0
    8610:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8614:	e12fff1e 	bx	lr

00008618 <_Z17set_task_deadlinej>:
_Z17set_task_deadlinej():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:144

void set_task_deadline(uint32_t tick_count_required)
{
    8618:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    861c:	e28db000 	add	fp, sp, #0
    8620:	e24dd014 	sub	sp, sp, #20
    8624:	e50b0010 	str	r0, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:145
    const NDeadline_Subservice req = NDeadline_Subservice::Set_Relative;
    8628:	e3a03000 	mov	r3, #0
    862c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:147

    asm volatile("mov r0, %0" : : "r" (req));
    8630:	e3a03000 	mov	r3, #0
    8634:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:148
    asm volatile("mov r1, %0" : : "r" (&tick_count_required));
    8638:	e24b3010 	sub	r3, fp, #16
    863c:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:149
    asm volatile("swi 5");
    8640:	ef000005 	svc	0x00000005
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:150
}
    8644:	e320f000 	nop	{0}
    8648:	e28bd000 	add	sp, fp, #0
    864c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8650:	e12fff1e 	bx	lr

00008654 <_Z26get_task_ticks_to_deadlinev>:
_Z26get_task_ticks_to_deadlinev():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:153

uint32_t get_task_ticks_to_deadline()
{
    8654:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8658:	e28db000 	add	fp, sp, #0
    865c:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:154
    const NDeadline_Subservice req = NDeadline_Subservice::Get_Remaining;
    8660:	e3a03001 	mov	r3, #1
    8664:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:157
    uint32_t ticks;

    asm volatile("mov r0, %0" : : "r" (req));
    8668:	e3a03001 	mov	r3, #1
    866c:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:158
    asm volatile("mov r1, %0" : : "r" (&ticks));
    8670:	e24b300c 	sub	r3, fp, #12
    8674:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:159
    asm volatile("swi 5");
    8678:	ef000005 	svc	0x00000005
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:161

    return ticks;
    867c:	e51b300c 	ldr	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:162
}
    8680:	e1a00003 	mov	r0, r3
    8684:	e28bd000 	add	sp, fp, #0
    8688:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    868c:	e12fff1e 	bx	lr

00008690 <_Z4pipePKcj>:
_Z4pipePKcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:167

const char Pipe_File_Prefix[] = "SYS:pipe/";

uint32_t pipe(const char* name, uint32_t buf_size)
{
    8690:	e92d4800 	push	{fp, lr}
    8694:	e28db004 	add	fp, sp, #4
    8698:	e24dd050 	sub	sp, sp, #80	; 0x50
    869c:	e50b0050 	str	r0, [fp, #-80]	; 0xffffffb0
    86a0:	e50b1054 	str	r1, [fp, #-84]	; 0xffffffac
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:169
    char fname[64];
    strncpy(fname, Pipe_File_Prefix, sizeof(Pipe_File_Prefix));
    86a4:	e24b3048 	sub	r3, fp, #72	; 0x48
    86a8:	e3a0200a 	mov	r2, #10
    86ac:	e59f1088 	ldr	r1, [pc, #136]	; 873c <_Z4pipePKcj+0xac>
    86b0:	e1a00003 	mov	r0, r3
    86b4:	eb0000a5 	bl	8950 <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:170
    strncpy(fname + sizeof(Pipe_File_Prefix), name, sizeof(fname) - sizeof(Pipe_File_Prefix) - 1);
    86b8:	e24b3048 	sub	r3, fp, #72	; 0x48
    86bc:	e283300a 	add	r3, r3, #10
    86c0:	e3a02035 	mov	r2, #53	; 0x35
    86c4:	e51b1050 	ldr	r1, [fp, #-80]	; 0xffffffb0
    86c8:	e1a00003 	mov	r0, r3
    86cc:	eb00009f 	bl	8950 <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:172

    int ncur = sizeof(Pipe_File_Prefix) + strlen(name);
    86d0:	e51b0050 	ldr	r0, [fp, #-80]	; 0xffffffb0
    86d4:	eb0000f8 	bl	8abc <_Z6strlenPKc>
    86d8:	e1a03000 	mov	r3, r0
    86dc:	e283300a 	add	r3, r3, #10
    86e0:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:174

    fname[ncur++] = '#';
    86e4:	e51b3008 	ldr	r3, [fp, #-8]
    86e8:	e2832001 	add	r2, r3, #1
    86ec:	e50b2008 	str	r2, [fp, #-8]
    86f0:	e2433004 	sub	r3, r3, #4
    86f4:	e083300b 	add	r3, r3, fp
    86f8:	e3a02023 	mov	r2, #35	; 0x23
    86fc:	e5432044 	strb	r2, [r3, #-68]	; 0xffffffbc
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:176

    itoa(buf_size, &fname[ncur], 10);
    8700:	e24b2048 	sub	r2, fp, #72	; 0x48
    8704:	e51b3008 	ldr	r3, [fp, #-8]
    8708:	e0823003 	add	r3, r2, r3
    870c:	e3a0200a 	mov	r2, #10
    8710:	e1a01003 	mov	r1, r3
    8714:	e51b0054 	ldr	r0, [fp, #-84]	; 0xffffffac
    8718:	eb000008 	bl	8740 <_Z4itoajPcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:178

    return open(fname, NFile_Open_Mode::Read_Write);
    871c:	e24b3048 	sub	r3, fp, #72	; 0x48
    8720:	e3a01002 	mov	r1, #2
    8724:	e1a00003 	mov	r0, r3
    8728:	ebffff0a 	bl	8358 <_Z4openPKc15NFile_Open_Mode>
    872c:	e1a03000 	mov	r3, r0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:179
}
    8730:	e1a00003 	mov	r0, r3
    8734:	e24bd004 	sub	sp, fp, #4
    8738:	e8bd8800 	pop	{fp, pc}
    873c:	00008efc 	strdeq	r8, [r0], -ip

00008740 <_Z4itoajPcj>:
_Z4itoajPcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:9
{
    const char CharConvArr[] = "0123456789ABCDEF";
}

void itoa(unsigned int input, char* output, unsigned int base)
{
    8740:	e92d4800 	push	{fp, lr}
    8744:	e28db004 	add	fp, sp, #4
    8748:	e24dd020 	sub	sp, sp, #32
    874c:	e50b0018 	str	r0, [fp, #-24]	; 0xffffffe8
    8750:	e50b101c 	str	r1, [fp, #-28]	; 0xffffffe4
    8754:	e50b2020 	str	r2, [fp, #-32]	; 0xffffffe0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:10
	int i = 0;
    8758:	e3a03000 	mov	r3, #0
    875c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:12

	while (input > 0)
    8760:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8764:	e3530000 	cmp	r3, #0
    8768:	0a000014 	beq	87c0 <_Z4itoajPcj+0x80>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:14
	{
		output[i] = CharConvArr[input % base];
    876c:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8770:	e51b1020 	ldr	r1, [fp, #-32]	; 0xffffffe0
    8774:	e1a00003 	mov	r0, r3
    8778:	eb000199 	bl	8de4 <__aeabi_uidivmod>
    877c:	e1a03001 	mov	r3, r1
    8780:	e1a01003 	mov	r1, r3
    8784:	e51b3008 	ldr	r3, [fp, #-8]
    8788:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    878c:	e0823003 	add	r3, r2, r3
    8790:	e59f2118 	ldr	r2, [pc, #280]	; 88b0 <_Z4itoajPcj+0x170>
    8794:	e7d22001 	ldrb	r2, [r2, r1]
    8798:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:15
		input /= base;
    879c:	e51b1020 	ldr	r1, [fp, #-32]	; 0xffffffe0
    87a0:	e51b0018 	ldr	r0, [fp, #-24]	; 0xffffffe8
    87a4:	eb000113 	bl	8bf8 <__udivsi3>
    87a8:	e1a03000 	mov	r3, r0
    87ac:	e50b3018 	str	r3, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:16
		i++;
    87b0:	e51b3008 	ldr	r3, [fp, #-8]
    87b4:	e2833001 	add	r3, r3, #1
    87b8:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:12
	while (input > 0)
    87bc:	eaffffe7 	b	8760 <_Z4itoajPcj+0x20>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:19
	}

    if (i == 0)
    87c0:	e51b3008 	ldr	r3, [fp, #-8]
    87c4:	e3530000 	cmp	r3, #0
    87c8:	1a000007 	bne	87ec <_Z4itoajPcj+0xac>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:21
    {
        output[i] = CharConvArr[0];
    87cc:	e51b3008 	ldr	r3, [fp, #-8]
    87d0:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    87d4:	e0823003 	add	r3, r2, r3
    87d8:	e3a02030 	mov	r2, #48	; 0x30
    87dc:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:22
        i++;
    87e0:	e51b3008 	ldr	r3, [fp, #-8]
    87e4:	e2833001 	add	r3, r3, #1
    87e8:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:25
    }

	output[i] = '\0';
    87ec:	e51b3008 	ldr	r3, [fp, #-8]
    87f0:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    87f4:	e0823003 	add	r3, r2, r3
    87f8:	e3a02000 	mov	r2, #0
    87fc:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:26
	i--;
    8800:	e51b3008 	ldr	r3, [fp, #-8]
    8804:	e2433001 	sub	r3, r3, #1
    8808:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:28

	for (int j = 0; j <= i/2; j++)
    880c:	e3a03000 	mov	r3, #0
    8810:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:28 (discriminator 3)
    8814:	e51b3008 	ldr	r3, [fp, #-8]
    8818:	e1a02fa3 	lsr	r2, r3, #31
    881c:	e0823003 	add	r3, r2, r3
    8820:	e1a030c3 	asr	r3, r3, #1
    8824:	e1a02003 	mov	r2, r3
    8828:	e51b300c 	ldr	r3, [fp, #-12]
    882c:	e1530002 	cmp	r3, r2
    8830:	ca00001b 	bgt	88a4 <_Z4itoajPcj+0x164>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:30 (discriminator 2)
	{
		char c = output[i - j];
    8834:	e51b2008 	ldr	r2, [fp, #-8]
    8838:	e51b300c 	ldr	r3, [fp, #-12]
    883c:	e0423003 	sub	r3, r2, r3
    8840:	e1a02003 	mov	r2, r3
    8844:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    8848:	e0833002 	add	r3, r3, r2
    884c:	e5d33000 	ldrb	r3, [r3]
    8850:	e54b300d 	strb	r3, [fp, #-13]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:31 (discriminator 2)
		output[i - j] = output[j];
    8854:	e51b300c 	ldr	r3, [fp, #-12]
    8858:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    885c:	e0822003 	add	r2, r2, r3
    8860:	e51b1008 	ldr	r1, [fp, #-8]
    8864:	e51b300c 	ldr	r3, [fp, #-12]
    8868:	e0413003 	sub	r3, r1, r3
    886c:	e1a01003 	mov	r1, r3
    8870:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    8874:	e0833001 	add	r3, r3, r1
    8878:	e5d22000 	ldrb	r2, [r2]
    887c:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:32 (discriminator 2)
		output[j] = c;
    8880:	e51b300c 	ldr	r3, [fp, #-12]
    8884:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    8888:	e0823003 	add	r3, r2, r3
    888c:	e55b200d 	ldrb	r2, [fp, #-13]
    8890:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:28 (discriminator 2)
	for (int j = 0; j <= i/2; j++)
    8894:	e51b300c 	ldr	r3, [fp, #-12]
    8898:	e2833001 	add	r3, r3, #1
    889c:	e50b300c 	str	r3, [fp, #-12]
    88a0:	eaffffdb 	b	8814 <_Z4itoajPcj+0xd4>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:34
	}
}
    88a4:	e320f000 	nop	{0}
    88a8:	e24bd004 	sub	sp, fp, #4
    88ac:	e8bd8800 	pop	{fp, pc}
    88b0:	00008f08 	andeq	r8, r0, r8, lsl #30

000088b4 <_Z4atoiPKc>:
_Z4atoiPKc():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:37

int atoi(const char* input)
{
    88b4:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    88b8:	e28db000 	add	fp, sp, #0
    88bc:	e24dd014 	sub	sp, sp, #20
    88c0:	e50b0010 	str	r0, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:38
	int output = 0;
    88c4:	e3a03000 	mov	r3, #0
    88c8:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:40

	while (*input != '\0')
    88cc:	e51b3010 	ldr	r3, [fp, #-16]
    88d0:	e5d33000 	ldrb	r3, [r3]
    88d4:	e3530000 	cmp	r3, #0
    88d8:	0a000017 	beq	893c <_Z4atoiPKc+0x88>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:42
	{
		output *= 10;
    88dc:	e51b2008 	ldr	r2, [fp, #-8]
    88e0:	e1a03002 	mov	r3, r2
    88e4:	e1a03103 	lsl	r3, r3, #2
    88e8:	e0833002 	add	r3, r3, r2
    88ec:	e1a03083 	lsl	r3, r3, #1
    88f0:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:43
		if (*input > '9' || *input < '0')
    88f4:	e51b3010 	ldr	r3, [fp, #-16]
    88f8:	e5d33000 	ldrb	r3, [r3]
    88fc:	e3530039 	cmp	r3, #57	; 0x39
    8900:	8a00000d 	bhi	893c <_Z4atoiPKc+0x88>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:43 (discriminator 1)
    8904:	e51b3010 	ldr	r3, [fp, #-16]
    8908:	e5d33000 	ldrb	r3, [r3]
    890c:	e353002f 	cmp	r3, #47	; 0x2f
    8910:	9a000009 	bls	893c <_Z4atoiPKc+0x88>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:46
			break;

		output += *input - '0';
    8914:	e51b3010 	ldr	r3, [fp, #-16]
    8918:	e5d33000 	ldrb	r3, [r3]
    891c:	e2433030 	sub	r3, r3, #48	; 0x30
    8920:	e51b2008 	ldr	r2, [fp, #-8]
    8924:	e0823003 	add	r3, r2, r3
    8928:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:48

		input++;
    892c:	e51b3010 	ldr	r3, [fp, #-16]
    8930:	e2833001 	add	r3, r3, #1
    8934:	e50b3010 	str	r3, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:40
	while (*input != '\0')
    8938:	eaffffe3 	b	88cc <_Z4atoiPKc+0x18>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:51
	}

	return output;
    893c:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:52
}
    8940:	e1a00003 	mov	r0, r3
    8944:	e28bd000 	add	sp, fp, #0
    8948:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    894c:	e12fff1e 	bx	lr

00008950 <_Z7strncpyPcPKci>:
_Z7strncpyPcPKci():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:55

char* strncpy(char* dest, const char *src, int num)
{
    8950:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8954:	e28db000 	add	fp, sp, #0
    8958:	e24dd01c 	sub	sp, sp, #28
    895c:	e50b0010 	str	r0, [fp, #-16]
    8960:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8964:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:58
	int i;

	for (i = 0; i < num && src[i] != '\0'; i++)
    8968:	e3a03000 	mov	r3, #0
    896c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:58 (discriminator 4)
    8970:	e51b2008 	ldr	r2, [fp, #-8]
    8974:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8978:	e1520003 	cmp	r2, r3
    897c:	aa000011 	bge	89c8 <_Z7strncpyPcPKci+0x78>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:58 (discriminator 2)
    8980:	e51b3008 	ldr	r3, [fp, #-8]
    8984:	e51b2014 	ldr	r2, [fp, #-20]	; 0xffffffec
    8988:	e0823003 	add	r3, r2, r3
    898c:	e5d33000 	ldrb	r3, [r3]
    8990:	e3530000 	cmp	r3, #0
    8994:	0a00000b 	beq	89c8 <_Z7strncpyPcPKci+0x78>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:59 (discriminator 3)
		dest[i] = src[i];
    8998:	e51b3008 	ldr	r3, [fp, #-8]
    899c:	e51b2014 	ldr	r2, [fp, #-20]	; 0xffffffec
    89a0:	e0822003 	add	r2, r2, r3
    89a4:	e51b3008 	ldr	r3, [fp, #-8]
    89a8:	e51b1010 	ldr	r1, [fp, #-16]
    89ac:	e0813003 	add	r3, r1, r3
    89b0:	e5d22000 	ldrb	r2, [r2]
    89b4:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:58 (discriminator 3)
	for (i = 0; i < num && src[i] != '\0'; i++)
    89b8:	e51b3008 	ldr	r3, [fp, #-8]
    89bc:	e2833001 	add	r3, r3, #1
    89c0:	e50b3008 	str	r3, [fp, #-8]
    89c4:	eaffffe9 	b	8970 <_Z7strncpyPcPKci+0x20>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:60 (discriminator 2)
	for (; i < num; i++)
    89c8:	e51b2008 	ldr	r2, [fp, #-8]
    89cc:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    89d0:	e1520003 	cmp	r2, r3
    89d4:	aa000008 	bge	89fc <_Z7strncpyPcPKci+0xac>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:61 (discriminator 1)
		dest[i] = '\0';
    89d8:	e51b3008 	ldr	r3, [fp, #-8]
    89dc:	e51b2010 	ldr	r2, [fp, #-16]
    89e0:	e0823003 	add	r3, r2, r3
    89e4:	e3a02000 	mov	r2, #0
    89e8:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:60 (discriminator 1)
	for (; i < num; i++)
    89ec:	e51b3008 	ldr	r3, [fp, #-8]
    89f0:	e2833001 	add	r3, r3, #1
    89f4:	e50b3008 	str	r3, [fp, #-8]
    89f8:	eafffff2 	b	89c8 <_Z7strncpyPcPKci+0x78>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:63

   return dest;
    89fc:	e51b3010 	ldr	r3, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:64
}
    8a00:	e1a00003 	mov	r0, r3
    8a04:	e28bd000 	add	sp, fp, #0
    8a08:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8a0c:	e12fff1e 	bx	lr

00008a10 <_Z7strncmpPKcS0_i>:
_Z7strncmpPKcS0_i():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:67

int strncmp(const char *s1, const char *s2, int num)
{
    8a10:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8a14:	e28db000 	add	fp, sp, #0
    8a18:	e24dd01c 	sub	sp, sp, #28
    8a1c:	e50b0010 	str	r0, [fp, #-16]
    8a20:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8a24:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:69
	unsigned char u1, u2;
  	while (num-- > 0)
    8a28:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8a2c:	e2432001 	sub	r2, r3, #1
    8a30:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
    8a34:	e3530000 	cmp	r3, #0
    8a38:	c3a03001 	movgt	r3, #1
    8a3c:	d3a03000 	movle	r3, #0
    8a40:	e6ef3073 	uxtb	r3, r3
    8a44:	e3530000 	cmp	r3, #0
    8a48:	0a000016 	beq	8aa8 <_Z7strncmpPKcS0_i+0x98>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:71
    {
      	u1 = (unsigned char) *s1++;
    8a4c:	e51b3010 	ldr	r3, [fp, #-16]
    8a50:	e2832001 	add	r2, r3, #1
    8a54:	e50b2010 	str	r2, [fp, #-16]
    8a58:	e5d33000 	ldrb	r3, [r3]
    8a5c:	e54b3005 	strb	r3, [fp, #-5]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:72
     	u2 = (unsigned char) *s2++;
    8a60:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8a64:	e2832001 	add	r2, r3, #1
    8a68:	e50b2014 	str	r2, [fp, #-20]	; 0xffffffec
    8a6c:	e5d33000 	ldrb	r3, [r3]
    8a70:	e54b3006 	strb	r3, [fp, #-6]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:73
      	if (u1 != u2)
    8a74:	e55b2005 	ldrb	r2, [fp, #-5]
    8a78:	e55b3006 	ldrb	r3, [fp, #-6]
    8a7c:	e1520003 	cmp	r2, r3
    8a80:	0a000003 	beq	8a94 <_Z7strncmpPKcS0_i+0x84>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:74
        	return u1 - u2;
    8a84:	e55b2005 	ldrb	r2, [fp, #-5]
    8a88:	e55b3006 	ldrb	r3, [fp, #-6]
    8a8c:	e0423003 	sub	r3, r2, r3
    8a90:	ea000005 	b	8aac <_Z7strncmpPKcS0_i+0x9c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:75
      	if (u1 == '\0')
    8a94:	e55b3005 	ldrb	r3, [fp, #-5]
    8a98:	e3530000 	cmp	r3, #0
    8a9c:	1affffe1 	bne	8a28 <_Z7strncmpPKcS0_i+0x18>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:76
        	return 0;
    8aa0:	e3a03000 	mov	r3, #0
    8aa4:	ea000000 	b	8aac <_Z7strncmpPKcS0_i+0x9c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:79
    }

  	return 0;
    8aa8:	e3a03000 	mov	r3, #0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:80
}
    8aac:	e1a00003 	mov	r0, r3
    8ab0:	e28bd000 	add	sp, fp, #0
    8ab4:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8ab8:	e12fff1e 	bx	lr

00008abc <_Z6strlenPKc>:
_Z6strlenPKc():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:83

int strlen(const char* s)
{
    8abc:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8ac0:	e28db000 	add	fp, sp, #0
    8ac4:	e24dd014 	sub	sp, sp, #20
    8ac8:	e50b0010 	str	r0, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:84
	int i = 0;
    8acc:	e3a03000 	mov	r3, #0
    8ad0:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:86

	while (s[i] != '\0')
    8ad4:	e51b3008 	ldr	r3, [fp, #-8]
    8ad8:	e51b2010 	ldr	r2, [fp, #-16]
    8adc:	e0823003 	add	r3, r2, r3
    8ae0:	e5d33000 	ldrb	r3, [r3]
    8ae4:	e3530000 	cmp	r3, #0
    8ae8:	0a000003 	beq	8afc <_Z6strlenPKc+0x40>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:87
		i++;
    8aec:	e51b3008 	ldr	r3, [fp, #-8]
    8af0:	e2833001 	add	r3, r3, #1
    8af4:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:86
	while (s[i] != '\0')
    8af8:	eafffff5 	b	8ad4 <_Z6strlenPKc+0x18>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:89

	return i;
    8afc:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:90
}
    8b00:	e1a00003 	mov	r0, r3
    8b04:	e28bd000 	add	sp, fp, #0
    8b08:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8b0c:	e12fff1e 	bx	lr

00008b10 <_Z5bzeroPvi>:
_Z5bzeroPvi():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:93

void bzero(void* memory, int length)
{
    8b10:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8b14:	e28db000 	add	fp, sp, #0
    8b18:	e24dd014 	sub	sp, sp, #20
    8b1c:	e50b0010 	str	r0, [fp, #-16]
    8b20:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:94
	char* mem = reinterpret_cast<char*>(memory);
    8b24:	e51b3010 	ldr	r3, [fp, #-16]
    8b28:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:96

	for (int i = 0; i < length; i++)
    8b2c:	e3a03000 	mov	r3, #0
    8b30:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:96 (discriminator 3)
    8b34:	e51b2008 	ldr	r2, [fp, #-8]
    8b38:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8b3c:	e1520003 	cmp	r2, r3
    8b40:	aa000008 	bge	8b68 <_Z5bzeroPvi+0x58>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:97 (discriminator 2)
		mem[i] = 0;
    8b44:	e51b3008 	ldr	r3, [fp, #-8]
    8b48:	e51b200c 	ldr	r2, [fp, #-12]
    8b4c:	e0823003 	add	r3, r2, r3
    8b50:	e3a02000 	mov	r2, #0
    8b54:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:96 (discriminator 2)
	for (int i = 0; i < length; i++)
    8b58:	e51b3008 	ldr	r3, [fp, #-8]
    8b5c:	e2833001 	add	r3, r3, #1
    8b60:	e50b3008 	str	r3, [fp, #-8]
    8b64:	eafffff2 	b	8b34 <_Z5bzeroPvi+0x24>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:98
}
    8b68:	e320f000 	nop	{0}
    8b6c:	e28bd000 	add	sp, fp, #0
    8b70:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8b74:	e12fff1e 	bx	lr

00008b78 <_Z6memcpyPKvPvi>:
_Z6memcpyPKvPvi():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:101

void memcpy(const void* src, void* dst, int num)
{
    8b78:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8b7c:	e28db000 	add	fp, sp, #0
    8b80:	e24dd024 	sub	sp, sp, #36	; 0x24
    8b84:	e50b0018 	str	r0, [fp, #-24]	; 0xffffffe8
    8b88:	e50b101c 	str	r1, [fp, #-28]	; 0xffffffe4
    8b8c:	e50b2020 	str	r2, [fp, #-32]	; 0xffffffe0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:102
	const char* memsrc = reinterpret_cast<const char*>(src);
    8b90:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8b94:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:103
	char* memdst = reinterpret_cast<char*>(dst);
    8b98:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    8b9c:	e50b3010 	str	r3, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:105

	for (int i = 0; i < num; i++)
    8ba0:	e3a03000 	mov	r3, #0
    8ba4:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:105 (discriminator 3)
    8ba8:	e51b2008 	ldr	r2, [fp, #-8]
    8bac:	e51b3020 	ldr	r3, [fp, #-32]	; 0xffffffe0
    8bb0:	e1520003 	cmp	r2, r3
    8bb4:	aa00000b 	bge	8be8 <_Z6memcpyPKvPvi+0x70>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:106 (discriminator 2)
		memdst[i] = memsrc[i];
    8bb8:	e51b3008 	ldr	r3, [fp, #-8]
    8bbc:	e51b200c 	ldr	r2, [fp, #-12]
    8bc0:	e0822003 	add	r2, r2, r3
    8bc4:	e51b3008 	ldr	r3, [fp, #-8]
    8bc8:	e51b1010 	ldr	r1, [fp, #-16]
    8bcc:	e0813003 	add	r3, r1, r3
    8bd0:	e5d22000 	ldrb	r2, [r2]
    8bd4:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:105 (discriminator 2)
	for (int i = 0; i < num; i++)
    8bd8:	e51b3008 	ldr	r3, [fp, #-8]
    8bdc:	e2833001 	add	r3, r3, #1
    8be0:	e50b3008 	str	r3, [fp, #-8]
    8be4:	eaffffef 	b	8ba8 <_Z6memcpyPKvPvi+0x30>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:107
}
    8be8:	e320f000 	nop	{0}
    8bec:	e28bd000 	add	sp, fp, #0
    8bf0:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8bf4:	e12fff1e 	bx	lr

00008bf8 <__udivsi3>:
__udivsi3():
    8bf8:	e2512001 	subs	r2, r1, #1
    8bfc:	012fff1e 	bxeq	lr
    8c00:	3a000074 	bcc	8dd8 <__udivsi3+0x1e0>
    8c04:	e1500001 	cmp	r0, r1
    8c08:	9a00006b 	bls	8dbc <__udivsi3+0x1c4>
    8c0c:	e1110002 	tst	r1, r2
    8c10:	0a00006c 	beq	8dc8 <__udivsi3+0x1d0>
    8c14:	e16f3f10 	clz	r3, r0
    8c18:	e16f2f11 	clz	r2, r1
    8c1c:	e0423003 	sub	r3, r2, r3
    8c20:	e273301f 	rsbs	r3, r3, #31
    8c24:	10833083 	addne	r3, r3, r3, lsl #1
    8c28:	e3a02000 	mov	r2, #0
    8c2c:	108ff103 	addne	pc, pc, r3, lsl #2
    8c30:	e1a00000 	nop			; (mov r0, r0)
    8c34:	e1500f81 	cmp	r0, r1, lsl #31
    8c38:	e0a22002 	adc	r2, r2, r2
    8c3c:	20400f81 	subcs	r0, r0, r1, lsl #31
    8c40:	e1500f01 	cmp	r0, r1, lsl #30
    8c44:	e0a22002 	adc	r2, r2, r2
    8c48:	20400f01 	subcs	r0, r0, r1, lsl #30
    8c4c:	e1500e81 	cmp	r0, r1, lsl #29
    8c50:	e0a22002 	adc	r2, r2, r2
    8c54:	20400e81 	subcs	r0, r0, r1, lsl #29
    8c58:	e1500e01 	cmp	r0, r1, lsl #28
    8c5c:	e0a22002 	adc	r2, r2, r2
    8c60:	20400e01 	subcs	r0, r0, r1, lsl #28
    8c64:	e1500d81 	cmp	r0, r1, lsl #27
    8c68:	e0a22002 	adc	r2, r2, r2
    8c6c:	20400d81 	subcs	r0, r0, r1, lsl #27
    8c70:	e1500d01 	cmp	r0, r1, lsl #26
    8c74:	e0a22002 	adc	r2, r2, r2
    8c78:	20400d01 	subcs	r0, r0, r1, lsl #26
    8c7c:	e1500c81 	cmp	r0, r1, lsl #25
    8c80:	e0a22002 	adc	r2, r2, r2
    8c84:	20400c81 	subcs	r0, r0, r1, lsl #25
    8c88:	e1500c01 	cmp	r0, r1, lsl #24
    8c8c:	e0a22002 	adc	r2, r2, r2
    8c90:	20400c01 	subcs	r0, r0, r1, lsl #24
    8c94:	e1500b81 	cmp	r0, r1, lsl #23
    8c98:	e0a22002 	adc	r2, r2, r2
    8c9c:	20400b81 	subcs	r0, r0, r1, lsl #23
    8ca0:	e1500b01 	cmp	r0, r1, lsl #22
    8ca4:	e0a22002 	adc	r2, r2, r2
    8ca8:	20400b01 	subcs	r0, r0, r1, lsl #22
    8cac:	e1500a81 	cmp	r0, r1, lsl #21
    8cb0:	e0a22002 	adc	r2, r2, r2
    8cb4:	20400a81 	subcs	r0, r0, r1, lsl #21
    8cb8:	e1500a01 	cmp	r0, r1, lsl #20
    8cbc:	e0a22002 	adc	r2, r2, r2
    8cc0:	20400a01 	subcs	r0, r0, r1, lsl #20
    8cc4:	e1500981 	cmp	r0, r1, lsl #19
    8cc8:	e0a22002 	adc	r2, r2, r2
    8ccc:	20400981 	subcs	r0, r0, r1, lsl #19
    8cd0:	e1500901 	cmp	r0, r1, lsl #18
    8cd4:	e0a22002 	adc	r2, r2, r2
    8cd8:	20400901 	subcs	r0, r0, r1, lsl #18
    8cdc:	e1500881 	cmp	r0, r1, lsl #17
    8ce0:	e0a22002 	adc	r2, r2, r2
    8ce4:	20400881 	subcs	r0, r0, r1, lsl #17
    8ce8:	e1500801 	cmp	r0, r1, lsl #16
    8cec:	e0a22002 	adc	r2, r2, r2
    8cf0:	20400801 	subcs	r0, r0, r1, lsl #16
    8cf4:	e1500781 	cmp	r0, r1, lsl #15
    8cf8:	e0a22002 	adc	r2, r2, r2
    8cfc:	20400781 	subcs	r0, r0, r1, lsl #15
    8d00:	e1500701 	cmp	r0, r1, lsl #14
    8d04:	e0a22002 	adc	r2, r2, r2
    8d08:	20400701 	subcs	r0, r0, r1, lsl #14
    8d0c:	e1500681 	cmp	r0, r1, lsl #13
    8d10:	e0a22002 	adc	r2, r2, r2
    8d14:	20400681 	subcs	r0, r0, r1, lsl #13
    8d18:	e1500601 	cmp	r0, r1, lsl #12
    8d1c:	e0a22002 	adc	r2, r2, r2
    8d20:	20400601 	subcs	r0, r0, r1, lsl #12
    8d24:	e1500581 	cmp	r0, r1, lsl #11
    8d28:	e0a22002 	adc	r2, r2, r2
    8d2c:	20400581 	subcs	r0, r0, r1, lsl #11
    8d30:	e1500501 	cmp	r0, r1, lsl #10
    8d34:	e0a22002 	adc	r2, r2, r2
    8d38:	20400501 	subcs	r0, r0, r1, lsl #10
    8d3c:	e1500481 	cmp	r0, r1, lsl #9
    8d40:	e0a22002 	adc	r2, r2, r2
    8d44:	20400481 	subcs	r0, r0, r1, lsl #9
    8d48:	e1500401 	cmp	r0, r1, lsl #8
    8d4c:	e0a22002 	adc	r2, r2, r2
    8d50:	20400401 	subcs	r0, r0, r1, lsl #8
    8d54:	e1500381 	cmp	r0, r1, lsl #7
    8d58:	e0a22002 	adc	r2, r2, r2
    8d5c:	20400381 	subcs	r0, r0, r1, lsl #7
    8d60:	e1500301 	cmp	r0, r1, lsl #6
    8d64:	e0a22002 	adc	r2, r2, r2
    8d68:	20400301 	subcs	r0, r0, r1, lsl #6
    8d6c:	e1500281 	cmp	r0, r1, lsl #5
    8d70:	e0a22002 	adc	r2, r2, r2
    8d74:	20400281 	subcs	r0, r0, r1, lsl #5
    8d78:	e1500201 	cmp	r0, r1, lsl #4
    8d7c:	e0a22002 	adc	r2, r2, r2
    8d80:	20400201 	subcs	r0, r0, r1, lsl #4
    8d84:	e1500181 	cmp	r0, r1, lsl #3
    8d88:	e0a22002 	adc	r2, r2, r2
    8d8c:	20400181 	subcs	r0, r0, r1, lsl #3
    8d90:	e1500101 	cmp	r0, r1, lsl #2
    8d94:	e0a22002 	adc	r2, r2, r2
    8d98:	20400101 	subcs	r0, r0, r1, lsl #2
    8d9c:	e1500081 	cmp	r0, r1, lsl #1
    8da0:	e0a22002 	adc	r2, r2, r2
    8da4:	20400081 	subcs	r0, r0, r1, lsl #1
    8da8:	e1500001 	cmp	r0, r1
    8dac:	e0a22002 	adc	r2, r2, r2
    8db0:	20400001 	subcs	r0, r0, r1
    8db4:	e1a00002 	mov	r0, r2
    8db8:	e12fff1e 	bx	lr
    8dbc:	03a00001 	moveq	r0, #1
    8dc0:	13a00000 	movne	r0, #0
    8dc4:	e12fff1e 	bx	lr
    8dc8:	e16f2f11 	clz	r2, r1
    8dcc:	e262201f 	rsb	r2, r2, #31
    8dd0:	e1a00230 	lsr	r0, r0, r2
    8dd4:	e12fff1e 	bx	lr
    8dd8:	e3500000 	cmp	r0, #0
    8ddc:	13e00000 	mvnne	r0, #0
    8de0:	ea000007 	b	8e04 <__aeabi_idiv0>

00008de4 <__aeabi_uidivmod>:
__aeabi_uidivmod():
    8de4:	e3510000 	cmp	r1, #0
    8de8:	0afffffa 	beq	8dd8 <__udivsi3+0x1e0>
    8dec:	e92d4003 	push	{r0, r1, lr}
    8df0:	ebffff80 	bl	8bf8 <__udivsi3>
    8df4:	e8bd4006 	pop	{r1, r2, lr}
    8df8:	e0030092 	mul	r3, r2, r0
    8dfc:	e0411003 	sub	r1, r1, r3
    8e00:	e12fff1e 	bx	lr

00008e04 <__aeabi_idiv0>:
__aeabi_ldiv0():
    8e04:	e12fff1e 	bx	lr

Disassembly of section .rodata:

00008e08 <_ZL13Lock_Unlocked>:
    8e08:	00000000 	andeq	r0, r0, r0

00008e0c <_ZL11Lock_Locked>:
    8e0c:	00000001 	andeq	r0, r0, r1

00008e10 <_ZL21MaxFSDriverNameLength>:
    8e10:	00000010 	andeq	r0, r0, r0, lsl r0

00008e14 <_ZL17MaxFilenameLength>:
    8e14:	00000010 	andeq	r0, r0, r0, lsl r0

00008e18 <_ZL13MaxPathLength>:
    8e18:	00000080 	andeq	r0, r0, r0, lsl #1

00008e1c <_ZL18NoFilesystemDriver>:
    8e1c:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008e20 <_ZL9NotifyAll>:
    8e20:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008e24 <_ZL24Max_Process_Opened_Files>:
    8e24:	00000010 	andeq	r0, r0, r0, lsl r0

00008e28 <_ZL10Indefinite>:
    8e28:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008e2c <_ZL18Deadline_Unchanged>:
    8e2c:	fffffffe 			; <UNDEFINED> instruction: 0xfffffffe

00008e30 <_ZL14Invalid_Handle>:
    8e30:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008e34 <_ZN3halL18Default_Clock_RateE>:
    8e34:	0ee6b280 	cdpeq	2, 14, cr11, cr6, cr0, {4}

00008e38 <_ZN3halL15Peripheral_BaseE>:
    8e38:	20000000 	andcs	r0, r0, r0

00008e3c <_ZN3halL9GPIO_BaseE>:
    8e3c:	20200000 	eorcs	r0, r0, r0

00008e40 <_ZN3halL14GPIO_Pin_CountE>:
    8e40:	00000036 	andeq	r0, r0, r6, lsr r0

00008e44 <_ZN3halL8AUX_BaseE>:
    8e44:	20215000 	eorcs	r5, r1, r0

00008e48 <_ZN3halL25Interrupt_Controller_BaseE>:
    8e48:	2000b200 	andcs	fp, r0, r0, lsl #4

00008e4c <_ZN3halL10Timer_BaseE>:
    8e4c:	2000b400 	andcs	fp, r0, r0, lsl #8

00008e50 <_ZN3halL9TRNG_BaseE>:
    8e50:	20104000 	andscs	r4, r0, r0

00008e54 <_ZN3halL9BSC0_BaseE>:
    8e54:	20205000 	eorcs	r5, r0, r0

00008e58 <_ZN3halL9BSC1_BaseE>:
    8e58:	20804000 	addcs	r4, r0, r0

00008e5c <_ZN3halL9BSC2_BaseE>:
    8e5c:	20805000 	addcs	r5, r0, r0

00008e60 <_ZN3halL14I2C_SLAVE_BaseE>:
    8e60:	20214000 	eorcs	r4, r1, r0

00008e64 <_ZL11Invalid_Pin>:
    8e64:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008e68 <_ZL24I2C_Transaction_Max_Size>:
    8e68:	00000008 	andeq	r0, r0, r8

00008e6c <_ZL17symbol_tick_delay>:
    8e6c:	00000400 	andeq	r0, r0, r0, lsl #8

00008e70 <_ZL15char_tick_delay>:
    8e70:	00001000 	andeq	r1, r0, r0
    8e74:	00676f6c 	rsbeq	r6, r7, ip, ror #30
    8e78:	76616c53 			; <UNDEFINED> instruction: 0x76616c53
    8e7c:	61742065 	cmnvs	r4, r5, rrx
    8e80:	73206b73 			; <UNDEFINED> instruction: 0x73206b73
    8e84:	74726174 	ldrbtvc	r6, [r2], #-372	; 0xfffffe8c
    8e88:	000a6465 	andeq	r6, sl, r5, ror #8
    8e8c:	3a564544 	bcc	159a3a4 <__bss_end+0x1591470>
    8e90:	2f633269 	svccs	0x00633269
    8e94:	00000032 	andeq	r0, r0, r2, lsr r0
    8e98:	20433249 	subcs	r3, r3, r9, asr #4
    8e9c:	6e6e6f63 	cdpvs	15, 6, cr6, cr14, cr3, {3}
    8ea0:	69746365 	ldmdbvs	r4!, {r0, r2, r5, r6, r8, r9, sp, lr}^
    8ea4:	73206e6f 			; <UNDEFINED> instruction: 0x73206e6f
    8ea8:	6576616c 	ldrbvs	r6, [r6, #-364]!	; 0xfffffe94
    8eac:	61747320 	cmnvs	r4, r0, lsr #6
    8eb0:	64657472 	strbtvs	r7, [r5], #-1138	; 0xfffffb8e
    8eb4:	0a2e2e2e 	beq	b94774 <__bss_end+0xb8b840>
    8eb8:	00000000 	andeq	r0, r0, r0
    8ebc:	6c6c6548 	cfstr64vs	mvdx6, [ip], #-288	; 0xfffffee0
    8ec0:	7266206f 	rsbvc	r2, r6, #111	; 0x6f
    8ec4:	73206d6f 			; <UNDEFINED> instruction: 0x73206d6f
    8ec8:	6576616c 	ldrbvs	r6, [r6, #-364]!	; 0xfffffe94
    8ecc:	0000000a 	andeq	r0, r0, sl

00008ed0 <_ZL13Lock_Unlocked>:
    8ed0:	00000000 	andeq	r0, r0, r0

00008ed4 <_ZL11Lock_Locked>:
    8ed4:	00000001 	andeq	r0, r0, r1

00008ed8 <_ZL21MaxFSDriverNameLength>:
    8ed8:	00000010 	andeq	r0, r0, r0, lsl r0

00008edc <_ZL17MaxFilenameLength>:
    8edc:	00000010 	andeq	r0, r0, r0, lsl r0

00008ee0 <_ZL13MaxPathLength>:
    8ee0:	00000080 	andeq	r0, r0, r0, lsl #1

00008ee4 <_ZL18NoFilesystemDriver>:
    8ee4:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008ee8 <_ZL9NotifyAll>:
    8ee8:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008eec <_ZL24Max_Process_Opened_Files>:
    8eec:	00000010 	andeq	r0, r0, r0, lsl r0

00008ef0 <_ZL10Indefinite>:
    8ef0:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008ef4 <_ZL18Deadline_Unchanged>:
    8ef4:	fffffffe 			; <UNDEFINED> instruction: 0xfffffffe

00008ef8 <_ZL14Invalid_Handle>:
    8ef8:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008efc <_ZL16Pipe_File_Prefix>:
    8efc:	3a535953 	bcc	14df450 <__bss_end+0x14d651c>
    8f00:	65706970 	ldrbvs	r6, [r0, #-2416]!	; 0xfffff690
    8f04:	0000002f 	andeq	r0, r0, pc, lsr #32

00008f08 <_ZN12_GLOBAL__N_1L11CharConvArrE>:
    8f08:	33323130 	teqcc	r2, #48, 2
    8f0c:	37363534 			; <UNDEFINED> instruction: 0x37363534
    8f10:	42413938 	submi	r3, r1, #56, 18	; 0xe0000
    8f14:	46454443 	strbmi	r4, [r5], -r3, asr #8
	...

Disassembly of section .bss:

00008f1c <log>:
__bss_start():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:17
uint32_t log, slave;
    8f1c:	00000000 	andeq	r0, r0, r0

00008f20 <slave>:
	...

Disassembly of section .ARM.attributes:

00000000 <.ARM.attributes>:
   0:	00002e41 	andeq	r2, r0, r1, asr #28
   4:	61656100 	cmnvs	r5, r0, lsl #2
   8:	01006962 	tsteq	r0, r2, ror #18
   c:	00000024 	andeq	r0, r0, r4, lsr #32
  10:	4b5a3605 	blmi	168d82c <__bss_end+0x16848f8>
  14:	08070600 	stmdaeq	r7, {r9, sl}
  18:	0a010901 	beq	42424 <__bss_end+0x394f0>
  1c:	14041202 	strne	r1, [r4], #-514	; 0xfffffdfe
  20:	17011501 	strne	r1, [r1, -r1, lsl #10]
  24:	1a011803 	bne	46038 <__bss_end+0x3d104>
  28:	22011c01 	andcs	r1, r1, #256	; 0x100
  2c:	Address 0x000000000000002c is out of bounds.


Disassembly of section .comment:

00000000 <.comment>:
   0:	3a434347 	bcc	10d0d24 <__bss_end+0x10c7df0>
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
  38:	7a617661 	bvc	185d9c4 <__bss_end+0x1854a90>
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
  c0:	6a757a61 	bvs	1d5ea4c <__bss_end+0x1d55b18>
  c4:	2f696369 	svccs	0x00696369
  c8:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
  cc:	73656d65 	cmnvc	r5, #6464	; 0x1940
  d0:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
  d4:	6b2d616b 	blvs	b58688 <__bss_end+0xb4f754>
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
 144:	fb010200 	blx	4094e <__bss_end+0x37a1a>
 148:	01000d0e 	tsteq	r0, lr, lsl #26
 14c:	00010101 	andeq	r0, r1, r1, lsl #2
 150:	00010000 	andeq	r0, r1, r0
 154:	552f0100 	strpl	r0, [pc, #-256]!	; 5c <shift+0x5c>
 158:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 15c:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 160:	6a726574 	bvs	1c99738 <__bss_end+0x1c90804>
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
 198:	752f7365 	strvc	r7, [pc, #-869]!	; fffffe3b <__bss_end+0xffff6f07>
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
 1d0:	0a05830b 	beq	160e04 <__bss_end+0x157ed0>
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
 1fc:	4a030402 	bmi	c120c <__bss_end+0xb82d8>
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
 230:	4a020402 	bmi	81240 <__bss_end+0x7830c>
 234:	02000205 	andeq	r0, r0, #1342177280	; 0x50000000
 238:	052d0204 	streq	r0, [sp, #-516]!	; 0xfffffdfc
 23c:	01058509 	tsteq	r5, r9, lsl #10
 240:	000a022f 	andeq	r0, sl, pc, lsr #4
 244:	02d20101 	sbcseq	r0, r2, #1073741824	; 0x40000000
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
 280:	6a757a61 	bvs	1d5ec0c <__bss_end+0x1d55cd8>
 284:	2f696369 	svccs	0x00696369
 288:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
 28c:	73656d65 	cmnvc	r5, #6464	; 0x1940
 290:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
 294:	6b2d616b 	blvs	b58848 <__bss_end+0xb4f914>
 298:	6f2d7669 	svcvs	0x002d7669
 29c:	6f732f73 	svcvs	0x00732f73
 2a0:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
 2a4:	73752f73 	cmnvc	r5, #460	; 0x1cc
 2a8:	70737265 	rsbsvc	r7, r3, r5, ror #4
 2ac:	2f656361 	svccs	0x00656361
 2b0:	76616c73 			; <UNDEFINED> instruction: 0x76616c73
 2b4:	61745f65 	cmnvs	r4, r5, ror #30
 2b8:	2f006b73 	svccs	0x00006b73
 2bc:	72657355 	rsbvc	r7, r5, #1409286145	; 0x54000001
 2c0:	69772f73 	ldmdbvs	r7!, {r0, r1, r4, r5, r6, r8, r9, sl, fp, sp}^
 2c4:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
 2c8:	442f696a 	strtmi	r6, [pc], #-2410	; 2d0 <shift+0x2d0>
 2cc:	746b7365 	strbtvc	r7, [fp], #-869	; 0xfffffc9b
 2d0:	462f706f 	strtmi	r7, [pc], -pc, rrx
 2d4:	4e2f5641 	cfmadda32mi	mvax2, mvax5, mvfx15, mvfx1
 2d8:	7a617661 	bvc	185dc64 <__bss_end+0x1854d30>
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
 334:	6b736544 	blvs	1cd984c <__bss_end+0x1cd0918>
 338:	2f706f74 	svccs	0x00706f74
 33c:	2f564146 	svccs	0x00564146
 340:	6176614e 	cmnvs	r6, lr, asr #2
 344:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
 348:	4f2f6963 	svcmi	0x002f6963
 34c:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
 350:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
 354:	6b6c6172 	blvs	1b18924 <__bss_end+0x1b0f9f0>
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
 398:	6b736544 	blvs	1cd98b0 <__bss_end+0x1cd097c>
 39c:	2f706f74 	svccs	0x00706f74
 3a0:	2f564146 	svccs	0x00564146
 3a4:	6176614e 	cmnvs	r6, lr, asr #2
 3a8:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
 3ac:	4f2f6963 	svcmi	0x002f6963
 3b0:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
 3b4:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
 3b8:	6b6c6172 	blvs	1b18988 <__bss_end+0x1b0fa54>
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
 408:	6b736544 	blvs	1cd9920 <__bss_end+0x1cd09ec>
 40c:	2f706f74 	svccs	0x00706f74
 410:	2f564146 	svccs	0x00564146
 414:	6176614e 	cmnvs	r6, lr, asr #2
 418:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
 41c:	4f2f6963 	svcmi	0x002f6963
 420:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
 424:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
 428:	6b6c6172 	blvs	1b189f8 <__bss_end+0x1b0fac4>
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
 4f0:	012d0300 			; <UNDEFINED> instruction: 0x012d0300
 4f4:	05a10f05 	streq	r0, [r1, #3845]!	; 0xf05
 4f8:	0a058209 	beq	160d24 <__bss_end+0x157df0>
 4fc:	bd11054c 	cfldr32lt	mvfx0, [r1, #-304]	; 0xfffffed0
 500:	05820b05 	streq	r0, [r2, #2821]	; 0xb05
 504:	0e054b0a 	vmlaeq.f64	d4, d5, d10
 508:	01040200 	mrseq	r0, R12_usr
 50c:	040200bc 	streq	r0, [r2], #-188	; 0xffffff44
 510:	0200bb01 	andeq	fp, r0, #1024	; 0x400
 514:	02650104 	rsbeq	r0, r5, #4, 2
 518:	01010010 	tsteq	r1, r0, lsl r0
 51c:	000002c8 	andeq	r0, r0, r8, asr #5
 520:	01dd0003 	bicseq	r0, sp, r3
 524:	01020000 	mrseq	r0, (UNDEF: 2)
 528:	000d0efb 	strdeq	r0, [sp], -fp
 52c:	01010101 	tsteq	r1, r1, lsl #2
 530:	01000000 	mrseq	r0, (UNDEF: 0)
 534:	2f010000 	svccs	0x00010000
 538:	72657355 	rsbvc	r7, r5, #1409286145	; 0x54000001
 53c:	69772f73 	ldmdbvs	r7!, {r0, r1, r4, r5, r6, r8, r9, sl, fp, sp}^
 540:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
 544:	442f696a 	strtmi	r6, [pc], #-2410	; 54c <shift+0x54c>
 548:	746b7365 	strbtvc	r7, [fp], #-869	; 0xfffffc9b
 54c:	462f706f 	strtmi	r7, [pc], -pc, rrx
 550:	4e2f5641 	cfmadda32mi	mvax2, mvax5, mvfx15, mvfx1
 554:	7a617661 	bvc	185dee0 <__bss_end+0x1854fac>
 558:	63696a75 	cmnvs	r9, #479232	; 0x75000
 55c:	534f2f69 	movtpl	r2, #65385	; 0xff69
 560:	6d65732f 	stclvs	3, cr7, [r5, #-188]!	; 0xffffff44
 564:	72747365 	rsbsvc	r7, r4, #-1811939327	; 0x94000001
 568:	616b6c61 	cmnvs	fp, r1, ror #24
 56c:	76696b2d 	strbtvc	r6, [r9], -sp, lsr #22
 570:	2f736f2d 	svccs	0x00736f2d
 574:	72756f73 	rsbsvc	r6, r5, #460	; 0x1cc
 578:	2f736563 	svccs	0x00736563
 57c:	6c647473 	cfstrdvs	mvd7, [r4], #-460	; 0xfffffe34
 580:	732f6269 			; <UNDEFINED> instruction: 0x732f6269
 584:	2f006372 	svccs	0x00006372
 588:	72657355 	rsbvc	r7, r5, #1409286145	; 0x54000001
 58c:	69772f73 	ldmdbvs	r7!, {r0, r1, r4, r5, r6, r8, r9, sl, fp, sp}^
 590:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
 594:	442f696a 	strtmi	r6, [pc], #-2410	; 59c <shift+0x59c>
 598:	746b7365 	strbtvc	r7, [fp], #-869	; 0xfffffc9b
 59c:	462f706f 	strtmi	r7, [pc], -pc, rrx
 5a0:	4e2f5641 	cfmadda32mi	mvax2, mvax5, mvfx15, mvfx1
 5a4:	7a617661 	bvc	185df30 <__bss_end+0x1854ffc>
 5a8:	63696a75 	cmnvs	r9, #479232	; 0x75000
 5ac:	534f2f69 	movtpl	r2, #65385	; 0xff69
 5b0:	6d65732f 	stclvs	3, cr7, [r5, #-188]!	; 0xffffff44
 5b4:	72747365 	rsbsvc	r7, r4, #-1811939327	; 0x94000001
 5b8:	616b6c61 	cmnvs	fp, r1, ror #24
 5bc:	76696b2d 	strbtvc	r6, [r9], -sp, lsr #22
 5c0:	2f736f2d 	svccs	0x00736f2d
 5c4:	72756f73 	rsbsvc	r6, r5, #460	; 0x1cc
 5c8:	2f736563 	svccs	0x00736563
 5cc:	6e72656b 	cdpvs	5, 7, cr6, cr2, cr11, {3}
 5d0:	692f6c65 	stmdbvs	pc!, {r0, r2, r5, r6, sl, fp, sp, lr}	; <UNPREDICTABLE>
 5d4:	756c636e 	strbvc	r6, [ip, #-878]!	; 0xfffffc92
 5d8:	702f6564 	eorvc	r6, pc, r4, ror #10
 5dc:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
 5e0:	2f007373 	svccs	0x00007373
 5e4:	72657355 	rsbvc	r7, r5, #1409286145	; 0x54000001
 5e8:	69772f73 	ldmdbvs	r7!, {r0, r1, r4, r5, r6, r8, r9, sl, fp, sp}^
 5ec:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
 5f0:	442f696a 	strtmi	r6, [pc], #-2410	; 5f8 <shift+0x5f8>
 5f4:	746b7365 	strbtvc	r7, [fp], #-869	; 0xfffffc9b
 5f8:	462f706f 	strtmi	r7, [pc], -pc, rrx
 5fc:	4e2f5641 	cfmadda32mi	mvax2, mvax5, mvfx15, mvfx1
 600:	7a617661 	bvc	185df8c <__bss_end+0x1855058>
 604:	63696a75 	cmnvs	r9, #479232	; 0x75000
 608:	534f2f69 	movtpl	r2, #65385	; 0xff69
 60c:	6d65732f 	stclvs	3, cr7, [r5, #-188]!	; 0xffffff44
 610:	72747365 	rsbsvc	r7, r4, #-1811939327	; 0x94000001
 614:	616b6c61 	cmnvs	fp, r1, ror #24
 618:	76696b2d 	strbtvc	r6, [r9], -sp, lsr #22
 61c:	2f736f2d 	svccs	0x00736f2d
 620:	72756f73 	rsbsvc	r6, r5, #460	; 0x1cc
 624:	2f736563 	svccs	0x00736563
 628:	6e72656b 	cdpvs	5, 7, cr6, cr2, cr11, {3}
 62c:	692f6c65 	stmdbvs	pc!, {r0, r2, r5, r6, sl, fp, sp, lr}	; <UNPREDICTABLE>
 630:	756c636e 	strbvc	r6, [ip, #-878]!	; 0xfffffc92
 634:	662f6564 	strtvs	r6, [pc], -r4, ror #10
 638:	552f0073 	strpl	r0, [pc, #-115]!	; 5cd <shift+0x5cd>
 63c:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 640:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 644:	6a726574 	bvs	1c99c1c <__bss_end+0x1c90ce8>
 648:	65442f69 	strbvs	r2, [r4, #-3945]	; 0xfffff097
 64c:	6f746b73 	svcvs	0x00746b73
 650:	41462f70 	hvcmi	25328	; 0x62f0
 654:	614e2f56 	cmpvs	lr, r6, asr pc
 658:	757a6176 	ldrbvc	r6, [sl, #-374]!	; 0xfffffe8a
 65c:	6963696a 	stmdbvs	r3!, {r1, r3, r5, r6, r8, fp, sp, lr}^
 660:	2f534f2f 	svccs	0x00534f2f
 664:	656d6573 	strbvs	r6, [sp, #-1395]!	; 0xfffffa8d
 668:	61727473 	cmnvs	r2, r3, ror r4
 66c:	2d616b6c 	vstmdbcs	r1!, {d22-<overflow reg d75>}
 670:	2d76696b 			; <UNDEFINED> instruction: 0x2d76696b
 674:	732f736f 			; <UNDEFINED> instruction: 0x732f736f
 678:	6372756f 	cmnvs	r2, #465567744	; 0x1bc00000
 67c:	6b2f7365 	blvs	bdd418 <__bss_end+0xbd44e4>
 680:	656e7265 	strbvs	r7, [lr, #-613]!	; 0xfffffd9b
 684:	6e692f6c 	cdpvs	15, 6, cr2, cr9, cr12, {3}
 688:	64756c63 	ldrbtvs	r6, [r5], #-3171	; 0xfffff39d
 68c:	6f622f65 	svcvs	0x00622f65
 690:	2f647261 	svccs	0x00647261
 694:	30697072 	rsbcc	r7, r9, r2, ror r0
 698:	6c61682f 	stclvs	8, cr6, [r1], #-188	; 0xffffff44
 69c:	74730000 	ldrbtvc	r0, [r3], #-0
 6a0:	6c696664 	stclvs	6, cr6, [r9], #-400	; 0xfffffe70
 6a4:	70632e65 	rsbvc	r2, r3, r5, ror #28
 6a8:	00010070 	andeq	r0, r1, r0, ror r0
 6ac:	69777300 	ldmdbvs	r7!, {r8, r9, ip, sp, lr}^
 6b0:	0200682e 	andeq	r6, r0, #3014656	; 0x2e0000
 6b4:	70730000 	rsbsvc	r0, r3, r0
 6b8:	6f6c6e69 	svcvs	0x006c6e69
 6bc:	682e6b63 	stmdavs	lr!, {r0, r1, r5, r6, r8, r9, fp, sp, lr}
 6c0:	00000200 	andeq	r0, r0, r0, lsl #4
 6c4:	656c6966 	strbvs	r6, [ip, #-2406]!	; 0xfffff69a
 6c8:	74737973 	ldrbtvc	r7, [r3], #-2419	; 0xfffff68d
 6cc:	682e6d65 	stmdavs	lr!, {r0, r2, r5, r6, r8, sl, fp, sp, lr}
 6d0:	00000300 	andeq	r0, r0, r0, lsl #6
 6d4:	636f7270 	cmnvs	pc, #112, 4
 6d8:	2e737365 	cdpcs	3, 7, cr7, cr3, cr5, {3}
 6dc:	00020068 	andeq	r0, r2, r8, rrx
 6e0:	6f727000 	svcvs	0x00727000
 6e4:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
 6e8:	6e616d5f 	mcrvs	13, 3, r6, cr1, cr15, {2}
 6ec:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
 6f0:	0200682e 	andeq	r6, r0, #3014656	; 0x2e0000
 6f4:	6e690000 	cdpvs	0, 6, cr0, cr9, cr0, {0}
 6f8:	66656474 			; <UNDEFINED> instruction: 0x66656474
 6fc:	0400682e 	streq	r6, [r0], #-2094	; 0xfffff7d2
 700:	05000000 	streq	r0, [r0, #-0]
 704:	02050001 	andeq	r0, r5, #1
 708:	000082e4 	andeq	r8, r0, r4, ror #5
 70c:	69050516 	stmdbvs	r5, {r1, r2, r4, r8, sl}
 710:	4c0c052f 	cfstr32mi	mvfx0, [ip], {47}	; 0x2f
 714:	852f0105 	strhi	r0, [pc, #-261]!	; 617 <shift+0x617>
 718:	4b830505 	blmi	fe0c1b34 <__bss_end+0xfe0b8c00>
 71c:	852f0105 	strhi	r0, [pc, #-261]!	; 61f <shift+0x61f>
 720:	054b0505 	strbeq	r0, [fp, #-1285]	; 0xfffffafb
 724:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 728:	4b4ba105 	blmi	12e8b44 <__bss_end+0x12dfc10>
 72c:	4c0c052f 	cfstr32mi	mvfx0, [ip], {47}	; 0x2f
 730:	852f0105 	strhi	r0, [pc, #-261]!	; 633 <shift+0x633>
 734:	4bbd0505 	blmi	fef41b50 <__bss_end+0xfef38c1c>
 738:	052f4b4b 	streq	r4, [pc, #-2891]!	; fffffbf5 <__bss_end+0xffff6cc1>
 73c:	01054c0c 	tsteq	r5, ip, lsl #24
 740:	0505852f 	streq	r8, [r5, #-1327]	; 0xfffffad1
 744:	4b4b4bbd 	blmi	12d3640 <__bss_end+0x12ca70c>
 748:	4c0c052f 	cfstr32mi	mvfx0, [ip], {47}	; 0x2f
 74c:	852f0105 	strhi	r0, [pc, #-261]!	; 64f <shift+0x64f>
 750:	4b830505 	blmi	fe0c1b6c <__bss_end+0xfe0b8c38>
 754:	852f0105 	strhi	r0, [pc, #-261]!	; 657 <shift+0x657>
 758:	4bbd0505 	blmi	fef41b74 <__bss_end+0xfef38c40>
 75c:	052f4b4b 	streq	r4, [pc, #-2891]!	; fffffc19 <__bss_end+0xffff6ce5>
 760:	01054c0c 	tsteq	r5, ip, lsl #24
 764:	0505852f 	streq	r8, [r5, #-1327]	; 0xfffffad1
 768:	2f4b4ba1 	svccs	0x004b4ba1
 76c:	054c0c05 	strbeq	r0, [ip, #-3077]	; 0xfffff3fb
 770:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 774:	4b4bbd05 	blmi	12efb90 <__bss_end+0x12e6c5c>
 778:	0c052f4b 	stceq	15, cr2, [r5], {75}	; 0x4b
 77c:	2f01054c 	svccs	0x0001054c
 780:	a1050585 	smlabbge	r5, r5, r5, r0
 784:	052f4b4b 	streq	r4, [pc, #-2891]!	; fffffc41 <__bss_end+0xffff6d0d>
 788:	01054c0c 	tsteq	r5, ip, lsl #24
 78c:	2005859f 	mulcs	r5, pc, r5	; <UNPREDICTABLE>
 790:	4d050567 	cfstr32mi	mvfx0, [r5, #-412]	; 0xfffffe64
 794:	0c054b4b 			; <UNDEFINED> instruction: 0x0c054b4b
 798:	2f010530 	svccs	0x00010530
 79c:	67200585 	strvs	r0, [r0, -r5, lsl #11]!
 7a0:	4b4d0505 	blmi	1341bbc <__bss_end+0x1338c88>
 7a4:	300c054b 	andcc	r0, ip, fp, asr #10
 7a8:	852f0105 	strhi	r0, [pc, #-261]!	; 6ab <shift+0x6ab>
 7ac:	05832005 	streq	r2, [r3, #5]
 7b0:	4b4b4c05 	blmi	12d37cc <__bss_end+0x12ca898>
 7b4:	852f0105 	strhi	r0, [pc, #-261]!	; 6b7 <shift+0x6b7>
 7b8:	05672005 	strbeq	r2, [r7, #-5]!
 7bc:	4b4b4d05 	blmi	12d3bd8 <__bss_end+0x12caca4>
 7c0:	05300c05 	ldreq	r0, [r0, #-3077]!	; 0xfffff3fb
 7c4:	05872f01 	streq	r2, [r7, #3841]	; 0xf01
 7c8:	059fa00c 	ldreq	sl, [pc, #12]	; 7dc <shift+0x7dc>
 7cc:	2905bc31 	stmdbcs	r5, {r0, r4, r5, sl, fp, ip, sp, pc}
 7d0:	2e360566 	cdpcs	5, 3, cr0, cr6, cr6, {3}
 7d4:	05300f05 	ldreq	r0, [r0, #-3845]!	; 0xfffff0fb
 7d8:	09056613 	stmdbeq	r5, {r0, r1, r4, r9, sl, sp, lr}
 7dc:	d8100584 	ldmdale	r0, {r2, r7, r8, sl}
 7e0:	029f0105 	addseq	r0, pc, #1073741825	; 0x40000001
 7e4:	01010008 	tsteq	r1, r8
 7e8:	0000029b 	muleq	r0, fp, r2
 7ec:	00740003 	rsbseq	r0, r4, r3
 7f0:	01020000 	mrseq	r0, (UNDEF: 2)
 7f4:	000d0efb 	strdeq	r0, [sp], -fp
 7f8:	01010101 	tsteq	r1, r1, lsl #2
 7fc:	01000000 	mrseq	r0, (UNDEF: 0)
 800:	2f010000 	svccs	0x00010000
 804:	72657355 	rsbvc	r7, r5, #1409286145	; 0x54000001
 808:	69772f73 	ldmdbvs	r7!, {r0, r1, r4, r5, r6, r8, r9, sl, fp, sp}^
 80c:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
 810:	442f696a 	strtmi	r6, [pc], #-2410	; 818 <shift+0x818>
 814:	746b7365 	strbtvc	r7, [fp], #-869	; 0xfffffc9b
 818:	462f706f 	strtmi	r7, [pc], -pc, rrx
 81c:	4e2f5641 	cfmadda32mi	mvax2, mvax5, mvfx15, mvfx1
 820:	7a617661 	bvc	185e1ac <__bss_end+0x1855278>
 824:	63696a75 	cmnvs	r9, #479232	; 0x75000
 828:	534f2f69 	movtpl	r2, #65385	; 0xff69
 82c:	6d65732f 	stclvs	3, cr7, [r5, #-188]!	; 0xffffff44
 830:	72747365 	rsbsvc	r7, r4, #-1811939327	; 0x94000001
 834:	616b6c61 	cmnvs	fp, r1, ror #24
 838:	76696b2d 	strbtvc	r6, [r9], -sp, lsr #22
 83c:	2f736f2d 	svccs	0x00736f2d
 840:	72756f73 	rsbsvc	r6, r5, #460	; 0x1cc
 844:	2f736563 	svccs	0x00736563
 848:	6c647473 	cfstrdvs	mvd7, [r4], #-460	; 0xfffffe34
 84c:	732f6269 			; <UNDEFINED> instruction: 0x732f6269
 850:	00006372 	andeq	r6, r0, r2, ror r3
 854:	73647473 	cmnvc	r4, #1929379840	; 0x73000000
 858:	6e697274 	mcrvs	2, 3, r7, cr9, cr4, {3}
 85c:	70632e67 	rsbvc	r2, r3, r7, ror #28
 860:	00010070 	andeq	r0, r1, r0, ror r0
 864:	01050000 	mrseq	r0, (UNDEF: 5)
 868:	40020500 	andmi	r0, r2, r0, lsl #10
 86c:	1a000087 	bne	a90 <shift+0xa90>
 870:	05bb0605 	ldreq	r0, [fp, #1541]!	; 0x605
 874:	21054c0f 	tstcs	r5, pc, lsl #24
 878:	ba0a0568 	blt	281e20 <__bss_end+0x278eec>
 87c:	052e0b05 	streq	r0, [lr, #-2821]!	; 0xfffff4fb
 880:	0d054a27 	vstreq	s8, [r5, #-156]	; 0xffffff64
 884:	2f09054a 	svccs	0x0009054a
 888:	059f0405 	ldreq	r0, [pc, #1029]	; c95 <shift+0xc95>
 88c:	05056202 	streq	r6, [r5, #-514]	; 0xfffffdfe
 890:	68100535 	ldmdavs	r0, {r0, r2, r4, r5, r8, sl}
 894:	052e1105 	streq	r1, [lr, #-261]!	; 0xfffffefb
 898:	13054a22 	movwne	r4, #23074	; 0x5a22
 89c:	2f0a052e 	svccs	0x000a052e
 8a0:	05690905 	strbeq	r0, [r9, #-2309]!	; 0xfffff6fb
 8a4:	0c052e0a 	stceq	14, cr2, [r5], {10}
 8a8:	4b03054a 	blmi	c1dd8 <__bss_end+0xb8ea4>
 8ac:	05680b05 	strbeq	r0, [r8, #-2821]!	; 0xfffff4fb
 8b0:	04020018 	streq	r0, [r2], #-24	; 0xffffffe8
 8b4:	14054a03 	strne	r4, [r5], #-2563	; 0xfffff5fd
 8b8:	03040200 	movweq	r0, #16896	; 0x4200
 8bc:	0015059e 	mulseq	r5, lr, r5
 8c0:	68020402 	stmdavs	r2, {r1, sl}
 8c4:	02001805 	andeq	r1, r0, #327680	; 0x50000
 8c8:	05820204 	streq	r0, [r2, #516]	; 0x204
 8cc:	04020008 	streq	r0, [r2], #-8
 8d0:	1a054a02 	bne	1530e0 <__bss_end+0x14a1ac>
 8d4:	02040200 	andeq	r0, r4, #0, 4
 8d8:	001b054b 	andseq	r0, fp, fp, asr #10
 8dc:	2e020402 	cdpcs	4, 0, cr0, cr2, cr2, {0}
 8e0:	02000c05 	andeq	r0, r0, #1280	; 0x500
 8e4:	054a0204 	strbeq	r0, [sl, #-516]	; 0xfffffdfc
 8e8:	0402000f 	streq	r0, [r2], #-15
 8ec:	1b058202 	blne	1610fc <__bss_end+0x1581c8>
 8f0:	02040200 	andeq	r0, r4, #0, 4
 8f4:	0011054a 	andseq	r0, r1, sl, asr #10
 8f8:	2e020402 	cdpcs	4, 0, cr0, cr2, cr2, {0}
 8fc:	02000a05 	andeq	r0, r0, #20480	; 0x5000
 900:	052f0204 	streq	r0, [pc, #-516]!	; 704 <shift+0x704>
 904:	0402000b 	streq	r0, [r2], #-11
 908:	0d052e02 	stceq	14, cr2, [r5, #-8]
 90c:	02040200 	andeq	r0, r4, #0, 4
 910:	0002054a 	andeq	r0, r2, sl, asr #10
 914:	46020402 	strmi	r0, [r2], -r2, lsl #8
 918:	85880105 	strhi	r0, [r8, #261]	; 0x105
 91c:	05830605 	streq	r0, [r3, #1541]	; 0x605
 920:	10054c09 	andne	r4, r5, r9, lsl #24
 924:	4c0a054a 	cfstr32mi	mvfx0, [sl], {74}	; 0x4a
 928:	05bb0705 	ldreq	r0, [fp, #1797]!	; 0x705
 92c:	17054a03 	strne	r4, [r5, -r3, lsl #20]
 930:	01040200 	mrseq	r0, R12_usr
 934:	0014054a 	andseq	r0, r4, sl, asr #10
 938:	4a010402 	bmi	41948 <__bss_end+0x38a14>
 93c:	054d0d05 	strbeq	r0, [sp, #-3333]	; 0xfffff2fb
 940:	0a054a14 	beq	153198 <__bss_end+0x14a264>
 944:	6808052e 	stmdavs	r8, {r1, r2, r3, r5, r8, sl}
 948:	78030205 	stmdavc	r3, {r0, r2, r9}
 94c:	03090566 	movweq	r0, #38246	; 0x9566
 950:	01052e0b 	tsteq	r5, fp, lsl #28
 954:	0905852f 	stmdbeq	r5, {r0, r1, r2, r3, r5, r8, sl, pc}
 958:	001605bd 			; <UNDEFINED> instruction: 0x001605bd
 95c:	4a040402 	bmi	10196c <__bss_end+0xf8a38>
 960:	02001d05 	andeq	r1, r0, #320	; 0x140
 964:	05820204 	streq	r0, [r2, #516]	; 0x204
 968:	0402001e 	streq	r0, [r2], #-30	; 0xffffffe2
 96c:	16052e02 	strne	r2, [r5], -r2, lsl #28
 970:	02040200 	andeq	r0, r4, #0, 4
 974:	00110566 	andseq	r0, r1, r6, ror #10
 978:	4b030402 	blmi	c1988 <__bss_end+0xb8a54>
 97c:	02001205 	andeq	r1, r0, #1342177280	; 0x50000000
 980:	052e0304 	streq	r0, [lr, #-772]!	; 0xfffffcfc
 984:	04020008 	streq	r0, [r2], #-8
 988:	09054a03 	stmdbeq	r5, {r0, r1, r9, fp, lr}
 98c:	03040200 	movweq	r0, #16896	; 0x4200
 990:	0012052e 	andseq	r0, r2, lr, lsr #10
 994:	4a030402 	bmi	c19a4 <__bss_end+0xb8a70>
 998:	02000b05 	andeq	r0, r0, #5120	; 0x1400
 99c:	052e0304 	streq	r0, [lr, #-772]!	; 0xfffffcfc
 9a0:	04020002 	streq	r0, [r2], #-2
 9a4:	0b052d03 	bleq	14bdb8 <__bss_end+0x142e84>
 9a8:	02040200 	andeq	r0, r4, #0, 4
 9ac:	00080584 	andeq	r0, r8, r4, lsl #11
 9b0:	83010402 	movwhi	r0, #5122	; 0x1402
 9b4:	02000905 	andeq	r0, r0, #81920	; 0x14000
 9b8:	052e0104 	streq	r0, [lr, #-260]!	; 0xfffffefc
 9bc:	0402000b 	streq	r0, [r2], #-11
 9c0:	02054a01 	andeq	r4, r5, #4096	; 0x1000
 9c4:	01040200 	mrseq	r0, R12_usr
 9c8:	850b0549 	strhi	r0, [fp, #-1353]	; 0xfffffab7
 9cc:	852f0105 	strhi	r0, [pc, #-261]!	; 8cf <shift+0x8cf>
 9d0:	05bc0e05 	ldreq	r0, [ip, #3589]!	; 0xe05
 9d4:	20056611 	andcs	r6, r5, r1, lsl r6
 9d8:	660b05bc 			; <UNDEFINED> instruction: 0x660b05bc
 9dc:	054b1f05 	strbeq	r1, [fp, #-3845]	; 0xfffff0fb
 9e0:	0805660a 	stmdaeq	r5, {r1, r3, r9, sl, sp, lr}
 9e4:	8311054b 	tsthi	r1, #314572800	; 0x12c00000
 9e8:	052e1605 	streq	r1, [lr, #-1541]!	; 0xfffff9fb
 9ec:	11056708 	tstne	r5, r8, lsl #14
 9f0:	4d0b0567 	cfstr32mi	mvfx0, [fp, #-412]	; 0xfffffe64
 9f4:	852f0105 	strhi	r0, [pc, #-261]!	; 8f7 <shift+0x8f7>
 9f8:	05830605 	streq	r0, [r3, #1541]	; 0x605
 9fc:	0c054c0b 	stceq	12, cr4, [r5], {11}
 a00:	660e052e 	strvs	r0, [lr], -lr, lsr #10
 a04:	054b0405 	strbeq	r0, [fp, #-1029]	; 0xfffffbfb
 a08:	09056502 	stmdbeq	r5, {r1, r8, sl, sp, lr}
 a0c:	2f010531 	svccs	0x00010531
 a10:	9f080585 	svcls	0x00080585
 a14:	054c0b05 	strbeq	r0, [ip, #-2821]	; 0xfffff4fb
 a18:	04020014 	streq	r0, [r2], #-20	; 0xffffffec
 a1c:	07054a03 	streq	r4, [r5, -r3, lsl #20]
 a20:	02040200 	andeq	r0, r4, #0, 4
 a24:	00080583 	andeq	r0, r8, r3, lsl #11
 a28:	2e020402 	cdpcs	4, 0, cr0, cr2, cr2, {0}
 a2c:	02000a05 	andeq	r0, r0, #20480	; 0x5000
 a30:	054a0204 	strbeq	r0, [sl, #-516]	; 0xfffffdfc
 a34:	04020002 	streq	r0, [r2], #-2
 a38:	01054902 	tsteq	r5, r2, lsl #18
 a3c:	0e058584 	cfsh32eq	mvfx8, mvfx5, #-60
 a40:	4b0805bb 	blmi	202134 <__bss_end+0x1f9200>
 a44:	054c0b05 	strbeq	r0, [ip, #-2821]	; 0xfffff4fb
 a48:	04020014 	streq	r0, [r2], #-20	; 0xffffffec
 a4c:	16054a03 	strne	r4, [r5], -r3, lsl #20
 a50:	02040200 	andeq	r0, r4, #0, 4
 a54:	00170583 	andseq	r0, r7, r3, lsl #11
 a58:	2e020402 	cdpcs	4, 0, cr0, cr2, cr2, {0}
 a5c:	02000a05 	andeq	r0, r0, #20480	; 0x5000
 a60:	054a0204 	strbeq	r0, [sl, #-516]	; 0xfffffdfc
 a64:	0402000b 	streq	r0, [r2], #-11
 a68:	17052e02 	strne	r2, [r5, -r2, lsl #28]
 a6c:	02040200 	andeq	r0, r4, #0, 4
 a70:	000d054a 	andeq	r0, sp, sl, asr #10
 a74:	2e020402 	cdpcs	4, 0, cr0, cr2, cr2, {0}
 a78:	02000205 	andeq	r0, r0, #1342177280	; 0x50000000
 a7c:	052d0204 	streq	r0, [sp, #-516]!	; 0xfffffdfc
 a80:	08028401 	stmdaeq	r2, {r0, sl, pc}
 a84:	Address 0x0000000000000a84 is out of bounds.


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
      58:	0a490704 	beq	1241c70 <__bss_end+0x1238d3c>
      5c:	5b020000 	blpl	80064 <__bss_end+0x77130>
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
     128:	00000a49 	andeq	r0, r0, r9, asr #20
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
     174:	cb104801 	blgt	412180 <__bss_end+0x40924c>
     178:	d4000000 	strle	r0, [r0], #-0
     17c:	58000081 	stmdapl	r0, {r0, r7}
     180:	01000000 	mrseq	r0, (UNDEF: 0)
     184:	0000cb9c 	muleq	r0, ip, fp
     188:	02b40a00 	adcseq	r0, r4, #0, 20
     18c:	4a010000 	bmi	40194 <__bss_end+0x37260>
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
     21c:	ba0d9c01 	blt	367228 <__bss_end+0x35e2f4>
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
     24c:	8b120f01 	blhi	483e58 <__bss_end+0x47af24>
     250:	0f000001 	svceq	0x00000001
     254:	0000019e 	muleq	r0, lr, r1
     258:	03d51000 	bicseq	r1, r5, #0
     25c:	0a010000 	beq	40264 <__bss_end+0x37330>
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
     2b4:	8b140074 	blhi	50048c <__bss_end+0x4f7558>
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
     2e4:	00098b04 	andeq	r8, r9, r4, lsl #22
     2e8:	00005600 	andeq	r5, r0, r0, lsl #12
     2ec:	00822c00 	addeq	r2, r2, r0, lsl #24
     2f0:	0000b800 	andeq	fp, r0, r0, lsl #16
     2f4:	00024600 	andeq	r4, r2, r0, lsl #12
     2f8:	08010200 	stmdaeq	r1, {r9}
     2fc:	00000ad7 	ldrdeq	r0, [r0], -r7
     300:	40050202 	andmi	r0, r5, r2, lsl #4
     304:	03000009 	movweq	r0, #9
     308:	6e690504 	cdpvs	5, 6, cr0, cr9, cr4, {0}
     30c:	01020074 	tsteq	r2, r4, ror r0
     310:	000ace08 	andeq	ip, sl, r8, lsl #28
     314:	07020200 	streq	r0, [r2, -r0, lsl #4]
     318:	00000b85 	andeq	r0, r0, r5, lsl #23
     31c:	00060304 	andeq	r0, r6, r4, lsl #6
     320:	07090a00 	streq	r0, [r9, -r0, lsl #20]
     324:	00000059 	andeq	r0, r0, r9, asr r0
     328:	00004805 	andeq	r4, r0, r5, lsl #16
     32c:	07040200 	streq	r0, [r4, -r0, lsl #4]
     330:	00000a49 	andeq	r0, r0, r9, asr #20
     334:	00005905 	andeq	r5, r0, r5, lsl #18
     338:	0c350600 	ldceq	6, cr0, [r5], #-0
     33c:	02080000 	andeq	r0, r8, #0
     340:	008b0806 	addeq	r0, fp, r6, lsl #16
     344:	72070000 	andvc	r0, r7, #0
     348:	08020030 	stmdaeq	r2, {r4, r5}
     34c:	0000480e 	andeq	r4, r0, lr, lsl #16
     350:	72070000 	andvc	r0, r7, #0
     354:	09020031 	stmdbeq	r2, {r0, r4, r5}
     358:	0000480e 	andeq	r4, r0, lr, lsl #16
     35c:	08000400 	stmdaeq	r0, {sl}
     360:	000009ee 	andeq	r0, r0, lr, ror #19
     364:	00330405 	eorseq	r0, r3, r5, lsl #8
     368:	1e020000 	cdpne	0, 0, cr0, cr2, cr0, {0}
     36c:	0000c20c 	andeq	ip, r0, ip, lsl #4
     370:	05fb0900 	ldrbeq	r0, [fp, #2304]!	; 0x900
     374:	09000000 	stmdbeq	r0, {}	; <UNPREDICTABLE>
     378:	00000727 	andeq	r0, r0, r7, lsr #14
     37c:	0a100901 	beq	402788 <__bss_end+0x3f9854>
     380:	09020000 	stmdbeq	r2, {}	; <UNPREDICTABLE>
     384:	00000af9 	strdeq	r0, [r0], -r9
     388:	07070903 	streq	r0, [r7, -r3, lsl #18]
     38c:	09040000 	stmdbeq	r4, {}	; <UNPREDICTABLE>
     390:	00000937 	andeq	r0, r0, r7, lsr r9
     394:	73080005 	movwvc	r0, #32773	; 0x8005
     398:	05000009 	streq	r0, [r0, #-9]
     39c:	00003304 	andeq	r3, r0, r4, lsl #6
     3a0:	0c3f0200 	lfmeq	f0, 4, [pc], #-0	; 3a8 <shift+0x3a8>
     3a4:	000000ff 	strdeq	r0, [r0], -pc	; <UNPREDICTABLE>
     3a8:	0006bc09 	andeq	fp, r6, r9, lsl #24
     3ac:	22090000 	andcs	r0, r9, #0
     3b0:	01000007 	tsteq	r0, r7
     3b4:	000bbc09 	andeq	fp, fp, r9, lsl #24
     3b8:	aa090200 	bge	240bc0 <__bss_end+0x237c8c>
     3bc:	03000008 	movweq	r0, #8
     3c0:	00071609 	andeq	r1, r7, r9, lsl #12
     3c4:	5a090400 	bpl	2413cc <__bss_end+0x238498>
     3c8:	05000007 	streq	r0, [r0, #-7]
     3cc:	00061609 	andeq	r1, r6, r9, lsl #12
     3d0:	0a000600 	beq	1bd8 <shift+0x1bd8>
     3d4:	00000888 	andeq	r0, r0, r8, lsl #17
     3d8:	54140503 	ldrpl	r0, [r4], #-1283	; 0xfffffafd
     3dc:	05000000 	streq	r0, [r0, #-0]
     3e0:	008e0803 	addeq	r0, lr, r3, lsl #16
     3e4:	0a620a00 	beq	1882bec <__bss_end+0x1879cb8>
     3e8:	06030000 	streq	r0, [r3], -r0
     3ec:	00005414 	andeq	r5, r0, r4, lsl r4
     3f0:	0c030500 	cfstr32eq	mvfx0, [r3], {-0}
     3f4:	0a00008e 	beq	634 <shift+0x634>
     3f8:	0000076f 	andeq	r0, r0, pc, ror #14
     3fc:	541a0704 	ldrpl	r0, [sl], #-1796	; 0xfffff8fc
     400:	05000000 	streq	r0, [r0, #-0]
     404:	008e1003 	addeq	r1, lr, r3
     408:	094a0a00 	stmdbeq	sl, {r9, fp}^
     40c:	09040000 	stmdbeq	r4, {}	; <UNPREDICTABLE>
     410:	0000541a 	andeq	r5, r0, sl, lsl r4
     414:	14030500 	strne	r0, [r3], #-1280	; 0xfffffb00
     418:	0a00008e 	beq	658 <shift+0x658>
     41c:	00000761 	andeq	r0, r0, r1, ror #14
     420:	541a0b04 	ldrpl	r0, [sl], #-2820	; 0xfffff4fc
     424:	05000000 	streq	r0, [r0, #-0]
     428:	008e1803 	addeq	r1, lr, r3, lsl #16
     42c:	09240a00 	stmdbeq	r4!, {r9, fp}
     430:	0d040000 	stceq	0, cr0, [r4, #-0]
     434:	0000541a 	andeq	r5, r0, sl, lsl r4
     438:	1c030500 	cfstr32ne	mvfx0, [r3], {-0}
     43c:	0a00008e 	beq	67c <shift+0x67c>
     440:	000005db 	ldrdeq	r0, [r0], -fp
     444:	541a0f04 	ldrpl	r0, [sl], #-3844	; 0xfffff0fc
     448:	05000000 	streq	r0, [r0, #-0]
     44c:	008e2003 	addeq	r2, lr, r3
     450:	107d0800 	rsbsne	r0, sp, r0, lsl #16
     454:	04050000 	streq	r0, [r5], #-0
     458:	00000033 	andeq	r0, r0, r3, lsr r0
     45c:	a20c1b04 	andge	r1, ip, #4, 22	; 0x1000
     460:	09000001 	stmdbeq	r0, {r0}
     464:	0000058a 	andeq	r0, r0, sl, lsl #11
     468:	0b240900 	bleq	902870 <__bss_end+0x8f993c>
     46c:	09010000 	stmdbeq	r1, {}	; <UNPREDICTABLE>
     470:	00000bb7 			; <UNDEFINED> instruction: 0x00000bb7
     474:	590b0002 	stmdbpl	fp, {r1}
     478:	02000004 	andeq	r0, r0, #4
     47c:	07d30201 	ldrbeq	r0, [r3, r1, lsl #4]
     480:	040c0000 	streq	r0, [ip], #-0
     484:	000001a2 	andeq	r0, r0, r2, lsr #3
     488:	0005940a 	andeq	r9, r5, sl, lsl #8
     48c:	14040500 	strne	r0, [r4], #-1280	; 0xfffffb00
     490:	00000054 	andeq	r0, r0, r4, asr r0
     494:	8e240305 	cdphi	3, 2, cr0, cr4, cr5, {0}
     498:	160a0000 	strne	r0, [sl], -r0
     49c:	0500000a 	streq	r0, [r0, #-10]
     4a0:	00541407 	subseq	r1, r4, r7, lsl #8
     4a4:	03050000 	movweq	r0, #20480	; 0x5000
     4a8:	00008e28 	andeq	r8, r0, r8, lsr #28
     4ac:	0004e20a 	andeq	lr, r4, sl, lsl #4
     4b0:	140a0500 	strne	r0, [sl], #-1280	; 0xfffffb00
     4b4:	00000054 	andeq	r0, r0, r4, asr r0
     4b8:	8e2c0305 	cdphi	3, 2, cr0, cr12, cr5, {0}
     4bc:	1b080000 	blne	2004c4 <__bss_end+0x1f7590>
     4c0:	05000006 	streq	r0, [r0, #-6]
     4c4:	00003304 	andeq	r3, r0, r4, lsl #6
     4c8:	0c0d0500 	cfstr32eq	mvfx0, [sp], {-0}
     4cc:	00000221 	andeq	r0, r0, r1, lsr #4
     4d0:	77654e0d 	strbvc	r4, [r5, -sp, lsl #28]!
     4d4:	c2090000 	andgt	r0, r9, #0
     4d8:	01000004 	tsteq	r0, r4
     4dc:	0004da09 	andeq	sp, r4, r9, lsl #20
     4e0:	34090200 	strcc	r0, [r9], #-512	; 0xfffffe00
     4e4:	03000006 	movweq	r0, #6
     4e8:	000aeb09 	andeq	lr, sl, r9, lsl #22
     4ec:	b6090400 	strlt	r0, [r9], -r0, lsl #8
     4f0:	05000004 	streq	r0, [r0, #-4]
     4f4:	05ad0600 	streq	r0, [sp, #1536]!	; 0x600
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
     524:	6d0e0800 	stcvs	8, cr0, [lr, #-0]
     528:	05000009 	streq	r0, [r0, #-9]
     52c:	02601320 	rsbeq	r1, r0, #32, 6	; 0x80000000
     530:	000c0000 	andeq	r0, ip, r0
     534:	44070402 	strmi	r0, [r7], #-1026	; 0xfffffbfe
     538:	0500000a 	streq	r0, [r0, #-10]
     53c:	00000260 	andeq	r0, r0, r0, ror #4
     540:	0006fa06 	andeq	pc, r6, r6, lsl #20
     544:	28057000 	stmdacs	r5, {ip, sp, lr}
     548:	0002fc08 	andeq	pc, r2, r8, lsl #24
     54c:	06a10e00 	strteq	r0, [r1], r0, lsl #28
     550:	2a050000 	bcs	140558 <__bss_end+0x137624>
     554:	00022112 	andeq	r2, r2, r2, lsl r1
     558:	70070000 	andvc	r0, r7, r0
     55c:	05006469 	streq	r6, [r0, #-1129]	; 0xfffffb97
     560:	0059122b 	subseq	r1, r9, fp, lsr #4
     564:	0e100000 	cdpeq	0, 1, cr0, cr0, cr0, {0}
     568:	00000b1e 	andeq	r0, r0, lr, lsl fp
     56c:	ea112c05 	b	44b588 <__bss_end+0x442654>
     570:	14000001 	strne	r0, [r0], #-1
     574:	000ac00e 	andeq	ip, sl, lr
     578:	122d0500 	eorne	r0, sp, #0, 10
     57c:	00000059 	andeq	r0, r0, r9, asr r0
     580:	03e90e18 	mvneq	r0, #24, 28	; 0x180
     584:	2e050000 	cdpcs	0, 0, cr0, cr5, cr0, {0}
     588:	00005912 	andeq	r5, r0, r2, lsl r9
     58c:	030e1c00 	movweq	r1, #60416	; 0xec00
     590:	0500000a 	streq	r0, [r0, #-10]
     594:	02fc0c2f 	rscseq	r0, ip, #12032	; 0x2f00
     598:	0e200000 	cdpeq	0, 2, cr0, cr0, cr0, {0}
     59c:	00000472 	andeq	r0, r0, r2, ror r4
     5a0:	33093005 	movwcc	r3, #36869	; 0x9005
     5a4:	60000000 	andvs	r0, r0, r0
     5a8:	00065f0e 	andeq	r5, r6, lr, lsl #30
     5ac:	0e310500 	cfabs32eq	mvfx0, mvfx1
     5b0:	00000048 	andeq	r0, r0, r8, asr #32
     5b4:	08ee0e64 	stmiaeq	lr!, {r2, r5, r6, r9, sl, fp}^
     5b8:	33050000 	movwcc	r0, #20480	; 0x5000
     5bc:	0000480e 	andeq	r4, r0, lr, lsl #16
     5c0:	e50e6800 	str	r6, [lr, #-2048]	; 0xfffff800
     5c4:	05000008 	streq	r0, [r0, #-8]
     5c8:	00480e34 	subeq	r0, r8, r4, lsr lr
     5cc:	006c0000 	rsbeq	r0, ip, r0
     5d0:	0001ae0f 	andeq	sl, r1, pc, lsl #28
     5d4:	00030c00 	andeq	r0, r3, r0, lsl #24
     5d8:	00591000 	subseq	r1, r9, r0
     5dc:	000f0000 	andeq	r0, pc, r0
     5e0:	0004cb0a 	andeq	ip, r4, sl, lsl #22
     5e4:	140a0600 	strne	r0, [sl], #-1536	; 0xfffffa00
     5e8:	00000054 	andeq	r0, r0, r4, asr r0
     5ec:	8e300305 	cdphi	3, 3, cr0, cr0, cr5, {0}
     5f0:	aa080000 	bge	2005f8 <__bss_end+0x1f76c4>
     5f4:	05000007 	streq	r0, [r0, #-7]
     5f8:	00003304 	andeq	r3, r0, r4, lsl #6
     5fc:	0c0d0600 	stceq	6, cr0, [sp], {-0}
     600:	0000033d 	andeq	r0, r0, sp, lsr r3
     604:	000bc209 	andeq	ip, fp, r9, lsl #4
     608:	38090000 	stmdacc	r9, {}	; <UNPREDICTABLE>
     60c:	0100000b 	tsteq	r0, fp
     610:	068e0600 	streq	r0, [lr], r0, lsl #12
     614:	060c0000 	streq	r0, [ip], -r0
     618:	0372081b 	cmneq	r2, #1769472	; 0x1b0000
     61c:	570e0000 	strpl	r0, [lr, -r0]
     620:	06000005 	streq	r0, [r0], -r5
     624:	0372191d 	cmneq	r2, #475136	; 0x74000
     628:	0e000000 	cdpeq	0, 0, cr0, cr0, cr0, {0}
     62c:	000004bd 			; <UNDEFINED> instruction: 0x000004bd
     630:	72191e06 	andsvc	r1, r9, #6, 28	; 0x60
     634:	04000003 	streq	r0, [r0], #-3
     638:	0007ce0e 	andeq	ip, r7, lr, lsl #28
     63c:	131f0600 	tstne	pc, #0, 12
     640:	00000378 	andeq	r0, r0, r8, ror r3
     644:	040c0008 	streq	r0, [ip], #-8
     648:	0000033d 	andeq	r0, r0, sp, lsr r3
     64c:	026c040c 	rsbeq	r0, ip, #12, 8	; 0xc000000
     650:	5c110000 	ldcpl	0, cr0, [r1], {-0}
     654:	14000009 	strne	r0, [r0], #-9
     658:	00072206 	andeq	r2, r7, r6, lsl #4
     65c:	0e000006 	cdpeq	0, 0, cr0, cr0, cr6, {0}
     660:	00000896 	muleq	r0, r6, r8
     664:	48122606 	ldmdami	r2, {r1, r2, r9, sl, sp}
     668:	00000000 	andeq	r0, r0, r0
     66c:	0008380e 	andeq	r3, r8, lr, lsl #16
     670:	1d290600 	stcne	6, cr0, [r9, #-0]
     674:	00000372 	andeq	r0, r0, r2, ror r3
     678:	063c0e04 	ldrteq	r0, [ip], -r4, lsl #28
     67c:	2c060000 	stccs	0, cr0, [r6], {-0}
     680:	0003721d 	andeq	r7, r3, sp, lsl r2
     684:	a0120800 	andsge	r0, r2, r0, lsl #16
     688:	06000008 	streq	r0, [r0], -r8
     68c:	066b0e2f 	strbteq	r0, [fp], -pc, lsr #28
     690:	03c60000 	biceq	r0, r6, #0
     694:	03d10000 	bicseq	r0, r1, #0
     698:	05130000 	ldreq	r0, [r3, #-0]
     69c:	14000006 	strne	r0, [r0], #-6
     6a0:	00000372 	andeq	r0, r0, r2, ror r3
     6a4:	07311500 	ldreq	r1, [r1, -r0, lsl #10]!
     6a8:	31060000 	mrscc	r0, (UNDEF: 6)
     6ac:	0006d10e 	andeq	sp, r6, lr, lsl #2
     6b0:	0001a700 	andeq	sl, r1, r0, lsl #14
     6b4:	0003e900 	andeq	lr, r3, r0, lsl #18
     6b8:	0003f400 	andeq	pc, r3, r0, lsl #8
     6bc:	06051300 	streq	r1, [r5], -r0, lsl #6
     6c0:	78140000 	ldmdavc	r4, {}	; <UNPREDICTABLE>
     6c4:	00000003 	andeq	r0, r0, r3
     6c8:	000aff16 	andeq	pc, sl, r6, lsl pc	; <UNPREDICTABLE>
     6cc:	1d350600 	ldcne	6, cr0, [r5, #-0]
     6d0:	00000785 	andeq	r0, r0, r5, lsl #15
     6d4:	00000372 	andeq	r0, r0, r2, ror r3
     6d8:	00040d02 	andeq	r0, r4, r2, lsl #26
     6dc:	00041300 	andeq	r1, r4, r0, lsl #6
     6e0:	06051300 	streq	r1, [r5], -r0, lsl #6
     6e4:	16000000 	strne	r0, [r0], -r0
     6e8:	00000627 	andeq	r0, r0, r7, lsr #12
     6ec:	b01d3706 	andslt	r3, sp, r6, lsl #14
     6f0:	72000008 	andvc	r0, r0, #8
     6f4:	02000003 	andeq	r0, r0, #3
     6f8:	0000042c 	andeq	r0, r0, ip, lsr #8
     6fc:	00000432 	andeq	r0, r0, r2, lsr r4
     700:	00060513 	andeq	r0, r6, r3, lsl r5
     704:	4b170000 	blmi	5c070c <__bss_end+0x5b77d8>
     708:	06000008 	streq	r0, [r0], -r8
     70c:	061e3139 			; <UNDEFINED> instruction: 0x061e3139
     710:	020c0000 	andeq	r0, ip, #0
     714:	00095c16 	andeq	r5, r9, r6, lsl ip
     718:	093c0600 	ldmdbeq	ip!, {r9, sl}
     71c:	00000740 	andeq	r0, r0, r0, asr #14
     720:	00000605 	andeq	r0, r0, r5, lsl #12
     724:	00045901 	andeq	r5, r4, r1, lsl #18
     728:	00045f00 	andeq	r5, r4, r0, lsl #30
     72c:	06051300 	streq	r1, [r5], -r0, lsl #6
     730:	16000000 	strne	r0, [r0], -r0
     734:	000006ad 	andeq	r0, r0, sp, lsr #13
     738:	13123f06 	tstne	r2, #6, 30
     73c:	48000005 	stmdami	r0, {r0, r2}
     740:	01000000 	mrseq	r0, (UNDEF: 0)
     744:	00000478 	andeq	r0, r0, r8, ror r4
     748:	0000048d 	andeq	r0, r0, sp, lsl #9
     74c:	00060513 	andeq	r0, r6, r3, lsl r5
     750:	06271400 	strteq	r1, [r7], -r0, lsl #8
     754:	59140000 	ldmdbpl	r4, {}	; <UNPREDICTABLE>
     758:	14000000 	strne	r0, [r0], #-0
     75c:	000001a7 	andeq	r0, r0, r7, lsr #3
     760:	0b2f1800 	bleq	bc6768 <__bss_end+0xbbd834>
     764:	42060000 	andmi	r0, r6, #0
     768:	0005ba0e 	andeq	fp, r5, lr, lsl #20
     76c:	04a20100 	strteq	r0, [r2], #256	; 0x100
     770:	04a80000 	strteq	r0, [r8], #0
     774:	05130000 	ldreq	r0, [r3, #-0]
     778:	00000006 	andeq	r0, r0, r6
     77c:	0004f516 	andeq	pc, r4, r6, lsl r5	; <UNPREDICTABLE>
     780:	17450600 	strbne	r0, [r5, -r0, lsl #12]
     784:	0000055c 	andeq	r0, r0, ip, asr r5
     788:	00000378 	andeq	r0, r0, r8, ror r3
     78c:	0004c101 	andeq	ip, r4, r1, lsl #2
     790:	0004c700 	andeq	ip, r4, r0, lsl #14
     794:	062d1300 	strteq	r1, [sp], -r0, lsl #6
     798:	16000000 	strne	r0, [r0], -r0
     79c:	00000a21 	andeq	r0, r0, r1, lsr #20
     7a0:	ff174806 			; <UNDEFINED> instruction: 0xff174806
     7a4:	78000003 	stmdavc	r0, {r0, r1}
     7a8:	01000003 	tsteq	r0, r3
     7ac:	000004e0 	andeq	r0, r0, r0, ror #9
     7b0:	000004eb 	andeq	r0, r0, fp, ror #9
     7b4:	00062d13 	andeq	r2, r6, r3, lsl sp
     7b8:	00481400 	subeq	r1, r8, r0, lsl #8
     7bc:	18000000 	stmdane	r0, {}	; <UNPREDICTABLE>
     7c0:	000005e5 	andeq	r0, r0, r5, ror #11
     7c4:	590e4b06 	stmdbpl	lr, {r1, r2, r8, r9, fp, lr}
     7c8:	01000008 	tsteq	r0, r8
     7cc:	00000500 	andeq	r0, r0, r0, lsl #10
     7d0:	00000506 	andeq	r0, r0, r6, lsl #10
     7d4:	00060513 	andeq	r0, r6, r3, lsl r5
     7d8:	31160000 	tstcc	r6, r0
     7dc:	06000007 	streq	r0, [r0], -r7
     7e0:	08fc0e4d 	ldmeq	ip!, {r0, r2, r3, r6, r9, sl, fp}^
     7e4:	01a70000 			; <UNDEFINED> instruction: 0x01a70000
     7e8:	1f010000 	svcne	0x00010000
     7ec:	2a000005 	bcs	808 <shift+0x808>
     7f0:	13000005 	movwne	r0, #5
     7f4:	00000605 	andeq	r0, r0, r5, lsl #12
     7f8:	00004814 	andeq	r4, r0, r4, lsl r8
     7fc:	a2160000 	andsge	r0, r6, #0
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
     828:	0b430e53 	bleq	10c417c <__bss_end+0x10bb248>
     82c:	01a70000 			; <UNDEFINED> instruction: 0x01a70000
     830:	67010000 	strvs	r0, [r1, -r0]
     834:	72000005 	andvc	r0, r0, #5
     838:	13000005 	movwne	r0, #5
     83c:	00000605 	andeq	r0, r0, r5, lsl #12
     840:	00004814 	andeq	r4, r0, r4, lsl r8
     844:	7c180000 	ldcvc	0, cr0, [r8], {-0}
     848:	06000004 	streq	r0, [r0], -r4
     84c:	0a6e0e56 	beq	1b841ac <__bss_end+0x1b7b278>
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
     878:	6f180000 	svcvs	0x00180000
     87c:	0600000b 	streq	r0, [r0], -fp
     880:	0be90e58 	bleq	ffa441e8 <__bss_end+0xffa3b2b4>
     884:	bb010000 	bllt	4088c <__bss_end+0x37958>
     888:	da000005 	ble	8a4 <shift+0x8a4>
     88c:	13000005 	movwne	r0, #5
     890:	00000605 	andeq	r0, r0, r5, lsl #12
     894:	0000c214 	andeq	ip, r0, r4, lsl r2
     898:	00481400 	subeq	r1, r8, r0, lsl #8
     89c:	48140000 	ldmdami	r4, {}	; <UNPREDICTABLE>
     8a0:	14000000 	strne	r0, [r0], #-0
     8a4:	00000048 	andeq	r0, r0, r8, asr #32
     8a8:	00063314 	andeq	r3, r6, r4, lsl r3
     8ac:	8f190000 	svchi	0x00190000
     8b0:	06000004 	streq	r0, [r0], -r4
     8b4:	07d80e5b 			; <UNDEFINED> instruction: 0x07d80e5b
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
     91c:	00000825 	andeq	r0, r0, r5, lsr #16
     920:	60190707 	andsvs	r0, r9, r7, lsl #14
     924:	80000000 	andhi	r0, r0, r0
     928:	1f0ee6b2 	svcne	0x000ee6b2
     92c:	00000a34 	andeq	r0, r0, r4, lsr sl
     930:	671a0a07 	ldrvs	r0, [sl, -r7, lsl #20]
     934:	00000002 	andeq	r0, r0, r2
     938:	1f200000 	svcne	0x00200000
     93c:	00000509 	andeq	r0, r0, r9, lsl #10
     940:	671a0d07 	ldrvs	r0, [sl, -r7, lsl #26]
     944:	00000002 	andeq	r0, r0, r2
     948:	20202000 	eorcs	r2, r0, r0
     94c:	000007bf 			; <UNDEFINED> instruction: 0x000007bf
     950:	54151007 	ldrpl	r1, [r5], #-7
     954:	36000000 	strcc	r0, [r0], -r0
     958:	000b0b1f 	andeq	r0, fp, pc, lsl fp
     95c:	1a420700 	bne	1082564 <__bss_end+0x1079630>
     960:	00000267 	andeq	r0, r0, r7, ror #4
     964:	20215000 	eorcs	r5, r1, r0
     968:	000b9d1f 	andeq	r9, fp, pc, lsl sp
     96c:	1a710700 	bne	1c42574 <__bss_end+0x1c39640>
     970:	00000267 	andeq	r0, r0, r7, ror #4
     974:	2000b200 	andcs	fp, r0, r0, lsl #4
     978:	0006c61f 	andeq	ip, r6, pc, lsl r6
     97c:	1aa40700 	bne	fe902584 <__bss_end+0xfe8f9650>
     980:	00000267 	andeq	r0, r0, r7, ror #4
     984:	2000b400 	andcs	fp, r0, r0, lsl #8
     988:	00081b1f 	andeq	r1, r8, pc, lsl fp
     98c:	1ab30700 	bne	fecc2594 <__bss_end+0xfecb9660>
     990:	00000267 	andeq	r0, r0, r7, ror #4
     994:	20104000 	andscs	r4, r0, r0
     998:	0008d61f 	andeq	sp, r8, pc, lsl r6
     99c:	1abe0700 	bne	fef825a4 <__bss_end+0xfef79670>
     9a0:	00000267 	andeq	r0, r0, r7, ror #4
     9a4:	20205000 	eorcs	r5, r0, r0
     9a8:	00060c1f 	andeq	r0, r6, pc, lsl ip
     9ac:	1abf0700 	bne	fefc25b4 <__bss_end+0xfefb9680>
     9b0:	00000267 	andeq	r0, r0, r7, ror #4
     9b4:	20804000 	addcs	r4, r0, r0
     9b8:	000b141f 	andeq	r1, fp, pc, lsl r4
     9bc:	1ac00700 	bne	ff0025c4 <__bss_end+0xfeff9690>
     9c0:	00000267 	andeq	r0, r0, r7, ror #4
     9c4:	20805000 	addcs	r5, r0, r0
     9c8:	000adc1f 	andeq	sp, sl, pc, lsl ip
     9cc:	1ace0700 	bne	ff3825d4 <__bss_end+0xff3796a0>
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
     a14:	0a560a00 	beq	158321c <__bss_end+0x157a2e8>
     a18:	08080000 	stmdaeq	r8, {}	; <UNPREDICTABLE>
     a1c:	00005414 	andeq	r5, r0, r4, lsl r4
     a20:	64030500 	strvs	r0, [r3], #-1280	; 0xfffffb00
     a24:	0a00008e 	beq	c64 <shift+0xc64>
     a28:	0000053e 	andeq	r0, r0, lr, lsr r5
     a2c:	54140809 	ldrpl	r0, [r4], #-2057	; 0xfffff7f7
     a30:	05000000 	streq	r0, [r0, #-0]
     a34:	008e6803 	addeq	r6, lr, r3, lsl #16
     a38:	25040c00 	strcs	r0, [r4, #-3072]	; 0xfffff400
     a3c:	0a000000 	beq	a44 <shift+0xa44>
     a40:	00000bd7 	ldrdeq	r0, [r0], -r7
     a44:	54140e01 	ldrpl	r0, [r4], #-3585	; 0xfffff1ff
     a48:	05000000 	streq	r0, [r0, #-0]
     a4c:	008e6c03 	addeq	r6, lr, r3, lsl #24
     a50:	064f0a00 	strbeq	r0, [pc], -r0, lsl #20
     a54:	0f010000 	svceq	0x00010000
     a58:	00005414 	andeq	r5, r0, r4, lsl r4
     a5c:	70030500 	andvc	r0, r3, r0, lsl #10
     a60:	2200008e 	andcs	r0, r0, #142	; 0x8e
     a64:	00676f6c 	rsbeq	r6, r7, ip, ror #30
     a68:	480a1101 	stmdami	sl, {r0, r8, ip}
     a6c:	05000000 	streq	r0, [r0, #-0]
     a70:	008f1c03 	addeq	r1, pc, r3, lsl #24
     a74:	071c2300 	ldreq	r2, [ip, -r0, lsl #6]
     a78:	11010000 	mrsne	r0, (UNDEF: 1)
     a7c:	0000480f 	andeq	r4, r0, pc, lsl #16
     a80:	20030500 	andcs	r0, r3, r0, lsl #10
     a84:	2400008f 	strcs	r0, [r0], #-143	; 0xffffff71
     a88:	00000b98 	muleq	r0, r8, fp
     a8c:	33052d01 	movwcc	r2, #23809	; 0x5d01
     a90:	2c000000 	stccs	0, cr0, [r0], {-0}
     a94:	b8000082 	stmdalt	r0, {r1, r7}
     a98:	01000000 	mrseq	r0, (UNDEF: 0)
     a9c:	0007fb9c 	muleq	r7, ip, fp
     aa0:	08e02500 	stmiaeq	r0!, {r8, sl, sp}^
     aa4:	2d010000 	stccs	0, cr0, [r1, #-0]
     aa8:	0000330e 	andeq	r3, r0, lr, lsl #6
     aac:	6c910200 	lfmvs	f0, 4, [r1], {0}
     ab0:	0008f725 	andeq	pc, r8, r5, lsr #14
     ab4:	1b2d0100 	blne	b40ebc <__bss_end+0xb37f88>
     ab8:	000007fb 	strdeq	r0, [r0], -fp
     abc:	26689102 	strbtcs	r9, [r8], -r2, lsl #2
     ac0:	000006c1 	andeq	r0, r0, r1, asr #13
     ac4:	010a2f01 	tsteq	sl, r1, lsl #30
     ac8:	02000008 	andeq	r0, r0, #8
     acc:	0c007491 	cfstrseq	mvf7, [r0], {145}	; 0x91
     ad0:	00076504 	andeq	r6, r7, r4, lsl #10
     ad4:	00252700 	eoreq	r2, r5, r0, lsl #14
     ad8:	59100000 	ldmdbpl	r0, {}	; <UNPREDICTABLE>
     adc:	03000000 	movweq	r0, #0
     ae0:	0b1f0000 	bleq	7c0ae8 <__bss_end+0x7b7bb4>
     ae4:	00040000 	andeq	r0, r4, r0
     ae8:	00000433 	andeq	r0, r0, r3, lsr r4
     aec:	0f790104 	svceq	0x00790104
     af0:	52040000 	andpl	r0, r4, #0
     af4:	4100000e 	tstmi	r0, lr
     af8:	e400000c 	str	r0, [r0], #-12
     afc:	5c000082 	stcpl	0, cr0, [r0], {130}	; 0x82
     b00:	1c000004 	stcne	0, cr0, [r0], {4}
     b04:	02000005 	andeq	r0, r0, #5
     b08:	0ad70801 	beq	ff5c2b14 <__bss_end+0xff5b9be0>
     b0c:	25030000 	strcs	r0, [r3, #-0]
     b10:	02000000 	andeq	r0, r0, #0
     b14:	09400502 	stmdbeq	r0, {r1, r8, sl}^
     b18:	04040000 	streq	r0, [r4], #-0
     b1c:	746e6905 	strbtvc	r6, [lr], #-2309	; 0xfffff6fb
     b20:	08010200 	stmdaeq	r1, {r9}
     b24:	00000ace 	andeq	r0, r0, lr, asr #21
     b28:	85070202 	strhi	r0, [r7, #-514]	; 0xfffffdfe
     b2c:	0500000b 	streq	r0, [r0, #-11]
     b30:	00000603 	andeq	r0, r0, r3, lsl #12
     b34:	5e070907 	vmlapl.f16	s0, s14, s14	; <UNPREDICTABLE>
     b38:	03000000 	movweq	r0, #0
     b3c:	0000004d 	andeq	r0, r0, sp, asr #32
     b40:	49070402 	stmdbmi	r7, {r1, sl}
     b44:	0600000a 	streq	r0, [r0], -sl
     b48:	00000c35 	andeq	r0, r0, r5, lsr ip
     b4c:	08060208 	stmdaeq	r6, {r3, r9}
     b50:	0000008b 	andeq	r0, r0, fp, lsl #1
     b54:	00307207 	eorseq	r7, r0, r7, lsl #4
     b58:	4d0e0802 	stcmi	8, cr0, [lr, #-8]
     b5c:	00000000 	andeq	r0, r0, r0
     b60:	00317207 	eorseq	r7, r1, r7, lsl #4
     b64:	4d0e0902 	vstrmi.16	s0, [lr, #-4]	; <UNPREDICTABLE>
     b68:	04000000 	streq	r0, [r0], #-0
     b6c:	0f030800 	svceq	0x00030800
     b70:	04050000 	streq	r0, [r5], #-0
     b74:	00000038 	andeq	r0, r0, r8, lsr r0
     b78:	a90c0d02 	stmdbge	ip, {r1, r8, sl, fp}
     b7c:	09000000 	stmdbeq	r0, {}	; <UNPREDICTABLE>
     b80:	00004b4f 	andeq	r4, r0, pc, asr #22
     b84:	000cef0a 	andeq	lr, ip, sl, lsl #30
     b88:	08000100 	stmdaeq	r0, {r8}
     b8c:	000009ee 	andeq	r0, r0, lr, ror #19
     b90:	00380405 	eorseq	r0, r8, r5, lsl #8
     b94:	1e020000 	cdpne	0, 0, cr0, cr2, cr0, {0}
     b98:	0000e00c 	andeq	lr, r0, ip
     b9c:	05fb0a00 	ldrbeq	r0, [fp, #2560]!	; 0xa00
     ba0:	0a000000 	beq	ba8 <shift+0xba8>
     ba4:	00000727 	andeq	r0, r0, r7, lsr #14
     ba8:	0a100a01 	beq	4033b4 <__bss_end+0x3fa480>
     bac:	0a020000 	beq	80bb4 <__bss_end+0x77c80>
     bb0:	00000af9 	strdeq	r0, [r0], -r9
     bb4:	07070a03 	streq	r0, [r7, -r3, lsl #20]
     bb8:	0a040000 	beq	100bc0 <__bss_end+0xf7c8c>
     bbc:	00000937 	andeq	r0, r0, r7, lsr r9
     bc0:	73080005 	movwvc	r0, #32773	; 0x8005
     bc4:	05000009 	streq	r0, [r0, #-9]
     bc8:	00003804 	andeq	r3, r0, r4, lsl #16
     bcc:	0c3f0200 	lfmeq	f0, 4, [pc], #-0	; bd4 <shift+0xbd4>
     bd0:	0000011d 	andeq	r0, r0, sp, lsl r1
     bd4:	0006bc0a 	andeq	fp, r6, sl, lsl #24
     bd8:	220a0000 	andcs	r0, sl, #0
     bdc:	01000007 	tsteq	r0, r7
     be0:	000bbc0a 	andeq	fp, fp, sl, lsl #24
     be4:	aa0a0200 	bge	2813ec <__bss_end+0x2784b8>
     be8:	03000008 	movweq	r0, #8
     bec:	0007160a 	andeq	r1, r7, sl, lsl #12
     bf0:	5a0a0400 	bpl	281bf8 <__bss_end+0x278cc4>
     bf4:	05000007 	streq	r0, [r0, #-7]
     bf8:	0006160a 	andeq	r1, r6, sl, lsl #12
     bfc:	08000600 	stmdaeq	r0, {r9, sl}
     c00:	0000102a 	andeq	r1, r0, sl, lsr #32
     c04:	00380405 	eorseq	r0, r8, r5, lsl #8
     c08:	66020000 	strvs	r0, [r2], -r0
     c0c:	0001480c 	andeq	r4, r1, ip, lsl #16
     c10:	0e470a00 	vmlaeq.f32	s1, s14, s0
     c14:	0a000000 	beq	c1c <shift+0xc1c>
     c18:	00000d4c 	andeq	r0, r0, ip, asr #26
     c1c:	0ecc0a01 	vdiveq.f32	s1, s24, s2
     c20:	0a020000 	beq	80c28 <__bss_end+0x77cf4>
     c24:	00000d71 	andeq	r0, r0, r1, ror sp
     c28:	880b0003 	stmdahi	fp, {r0, r1}
     c2c:	03000008 	movweq	r0, #8
     c30:	00591405 	subseq	r1, r9, r5, lsl #8
     c34:	03050000 	movweq	r0, #20480	; 0x5000
     c38:	00008ed0 	ldrdeq	r8, [r0], -r0
     c3c:	000a620b 	andeq	r6, sl, fp, lsl #4
     c40:	14060300 	strne	r0, [r6], #-768	; 0xfffffd00
     c44:	00000059 	andeq	r0, r0, r9, asr r0
     c48:	8ed40305 	cdphi	3, 13, cr0, cr4, cr5, {0}
     c4c:	6f0b0000 	svcvs	0x000b0000
     c50:	04000007 	streq	r0, [r0], #-7
     c54:	00591a07 	subseq	r1, r9, r7, lsl #20
     c58:	03050000 	movweq	r0, #20480	; 0x5000
     c5c:	00008ed8 	ldrdeq	r8, [r0], -r8	; <UNPREDICTABLE>
     c60:	00094a0b 	andeq	r4, r9, fp, lsl #20
     c64:	1a090400 	bne	241c6c <__bss_end+0x238d38>
     c68:	00000059 	andeq	r0, r0, r9, asr r0
     c6c:	8edc0305 	cdphi	3, 13, cr0, cr12, cr5, {0}
     c70:	610b0000 	mrsvs	r0, (UNDEF: 11)
     c74:	04000007 	streq	r0, [r0], #-7
     c78:	00591a0b 	subseq	r1, r9, fp, lsl #20
     c7c:	03050000 	movweq	r0, #20480	; 0x5000
     c80:	00008ee0 	andeq	r8, r0, r0, ror #29
     c84:	0009240b 	andeq	r2, r9, fp, lsl #8
     c88:	1a0d0400 	bne	341c90 <__bss_end+0x338d5c>
     c8c:	00000059 	andeq	r0, r0, r9, asr r0
     c90:	8ee40305 	cdphi	3, 14, cr0, cr4, cr5, {0}
     c94:	db0b0000 	blle	2c0c9c <__bss_end+0x2b7d68>
     c98:	04000005 	streq	r0, [r0], #-5
     c9c:	00591a0f 	subseq	r1, r9, pc, lsl #20
     ca0:	03050000 	movweq	r0, #20480	; 0x5000
     ca4:	00008ee8 	andeq	r8, r0, r8, ror #29
     ca8:	00107d08 	andseq	r7, r0, r8, lsl #26
     cac:	38040500 	stmdacc	r4, {r8, sl}
     cb0:	04000000 	streq	r0, [r0], #-0
     cb4:	01eb0c1b 	mvneq	r0, fp, lsl ip
     cb8:	8a0a0000 	bhi	280cc0 <__bss_end+0x277d8c>
     cbc:	00000005 	andeq	r0, r0, r5
     cc0:	000b240a 	andeq	r2, fp, sl, lsl #8
     cc4:	b70a0100 	strlt	r0, [sl, -r0, lsl #2]
     cc8:	0200000b 	andeq	r0, r0, #11
     ccc:	04590c00 	ldrbeq	r0, [r9], #-3072	; 0xfffff400
     cd0:	01020000 	mrseq	r0, (UNDEF: 2)
     cd4:	0007d302 	andeq	sp, r7, r2, lsl #6
     cd8:	2c040d00 	stccs	13, cr0, [r4], {-0}
     cdc:	0d000000 	stceq	0, cr0, [r0, #-0]
     ce0:	0001eb04 	andeq	lr, r1, r4, lsl #22
     ce4:	05940b00 	ldreq	r0, [r4, #2816]	; 0xb00
     ce8:	04050000 	streq	r0, [r5], #-0
     cec:	00005914 	andeq	r5, r0, r4, lsl r9
     cf0:	ec030500 	cfstr32	mvfx0, [r3], {-0}
     cf4:	0b00008e 	bleq	f34 <shift+0xf34>
     cf8:	00000a16 	andeq	r0, r0, r6, lsl sl
     cfc:	59140705 	ldmdbpl	r4, {r0, r2, r8, r9, sl}
     d00:	05000000 	streq	r0, [r0, #-0]
     d04:	008ef003 	addeq	pc, lr, r3
     d08:	04e20b00 	strbteq	r0, [r2], #2816	; 0xb00
     d0c:	0a050000 	beq	140d14 <__bss_end+0x137de0>
     d10:	00005914 	andeq	r5, r0, r4, lsl r9
     d14:	f4030500 	vst3.8	{d0,d2,d4}, [r3], r0
     d18:	0800008e 	stmdaeq	r0, {r1, r2, r3, r7}
     d1c:	0000061b 	andeq	r0, r0, fp, lsl r6
     d20:	00380405 	eorseq	r0, r8, r5, lsl #8
     d24:	0d050000 	stceq	0, cr0, [r5, #-0]
     d28:	0002700c 	andeq	r7, r2, ip
     d2c:	654e0900 	strbvs	r0, [lr, #-2304]	; 0xfffff700
     d30:	0a000077 	beq	f14 <shift+0xf14>
     d34:	000004c2 	andeq	r0, r0, r2, asr #9
     d38:	04da0a01 	ldrbeq	r0, [sl], #2561	; 0xa01
     d3c:	0a020000 	beq	80d44 <__bss_end+0x77e10>
     d40:	00000634 	andeq	r0, r0, r4, lsr r6
     d44:	0aeb0a03 	beq	ffac3558 <__bss_end+0xffaba624>
     d48:	0a040000 	beq	100d50 <__bss_end+0xf7e1c>
     d4c:	000004b6 			; <UNDEFINED> instruction: 0x000004b6
     d50:	ad060005 	stcge	0, cr0, [r6, #-20]	; 0xffffffec
     d54:	10000005 	andne	r0, r0, r5
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
     d84:	0000096d 	andeq	r0, r0, sp, ror #18
     d88:	af132005 	svcge	0x00132005
     d8c:	0c000002 	stceq	0, cr0, [r0], {2}
     d90:	07040200 	streq	r0, [r4, -r0, lsl #4]
     d94:	00000a44 	andeq	r0, r0, r4, asr #20
     d98:	0006fa06 	andeq	pc, r6, r6, lsl #20
     d9c:	28057000 	stmdacs	r5, {ip, sp, lr}
     da0:	00034608 	andeq	r4, r3, r8, lsl #12
     da4:	06a10e00 	strteq	r0, [r1], r0, lsl #28
     da8:	2a050000 	bcs	140db0 <__bss_end+0x137e7c>
     dac:	00027012 	andeq	r7, r2, r2, lsl r0
     db0:	70070000 	andvc	r0, r7, r0
     db4:	05006469 	streq	r6, [r0, #-1129]	; 0xfffffb97
     db8:	005e122b 	subseq	r1, lr, fp, lsr #4
     dbc:	0e100000 	cdpeq	0, 1, cr0, cr0, cr0, {0}
     dc0:	00000b1e 	andeq	r0, r0, lr, lsl fp
     dc4:	39112c05 	ldmdbcc	r1, {r0, r2, sl, fp, sp}
     dc8:	14000002 	strne	r0, [r0], #-2
     dcc:	000ac00e 	andeq	ip, sl, lr
     dd0:	122d0500 	eorne	r0, sp, #0, 10
     dd4:	0000005e 	andeq	r0, r0, lr, asr r0
     dd8:	03e90e18 	mvneq	r0, #24, 28	; 0x180
     ddc:	2e050000 	cdpcs	0, 0, cr0, cr5, cr0, {0}
     de0:	00005e12 	andeq	r5, r0, r2, lsl lr
     de4:	030e1c00 	movweq	r1, #60416	; 0xec00
     de8:	0500000a 	streq	r0, [r0, #-10]
     dec:	03460c2f 	movteq	r0, #27695	; 0x6c2f
     df0:	0e200000 	cdpeq	0, 2, cr0, cr0, cr0, {0}
     df4:	00000472 	andeq	r0, r0, r2, ror r4
     df8:	38093005 	stmdacc	r9, {r0, r2, ip, sp}
     dfc:	60000000 	andvs	r0, r0, r0
     e00:	00065f0e 	andeq	r5, r6, lr, lsl #30
     e04:	0e310500 	cfabs32eq	mvfx0, mvfx1
     e08:	0000004d 	andeq	r0, r0, sp, asr #32
     e0c:	08ee0e64 	stmiaeq	lr!, {r2, r5, r6, r9, sl, fp}^
     e10:	33050000 	movwcc	r0, #20480	; 0x5000
     e14:	00004d0e 	andeq	r4, r0, lr, lsl #26
     e18:	e50e6800 	str	r6, [lr, #-2048]	; 0xfffff800
     e1c:	05000008 	streq	r0, [r0, #-8]
     e20:	004d0e34 	subeq	r0, sp, r4, lsr lr
     e24:	006c0000 	rsbeq	r0, ip, r0
     e28:	0001fd0f 	andeq	pc, r1, pc, lsl #26
     e2c:	00035600 	andeq	r5, r3, r0, lsl #12
     e30:	005e1000 	subseq	r1, lr, r0
     e34:	000f0000 	andeq	r0, pc, r0
     e38:	0004cb0b 	andeq	ip, r4, fp, lsl #22
     e3c:	140a0600 	strne	r0, [sl], #-1536	; 0xfffffa00
     e40:	00000059 	andeq	r0, r0, r9, asr r0
     e44:	8ef80305 	cdphi	3, 15, cr0, cr8, cr5, {0}
     e48:	aa080000 	bge	200e50 <__bss_end+0x1f7f1c>
     e4c:	05000007 	streq	r0, [r0, #-7]
     e50:	00003804 	andeq	r3, r0, r4, lsl #16
     e54:	0c0d0600 	stceq	6, cr0, [sp], {-0}
     e58:	00000387 	andeq	r0, r0, r7, lsl #7
     e5c:	000bc20a 	andeq	ip, fp, sl, lsl #4
     e60:	380a0000 	stmdacc	sl, {}	; <UNPREDICTABLE>
     e64:	0100000b 	tsteq	r0, fp
     e68:	03680300 	cmneq	r8, #0, 6
     e6c:	d9080000 	stmdble	r8, {}	; <UNPREDICTABLE>
     e70:	0500000d 	streq	r0, [r0, #-13]
     e74:	00003804 	andeq	r3, r0, r4, lsl #16
     e78:	0c140600 	ldceq	6, cr0, [r4], {-0}
     e7c:	000003ab 	andeq	r0, r0, fp, lsr #7
     e80:	000c920a 	andeq	r9, ip, sl, lsl #4
     e84:	be0a0000 	cdplt	0, 0, cr0, cr10, cr0, {0}
     e88:	0100000e 	tsteq	r0, lr
     e8c:	038c0300 	orreq	r0, ip, #0, 6
     e90:	8e060000 	cdphi	0, 0, cr0, cr6, cr0, {0}
     e94:	0c000006 	stceq	0, cr0, [r0], {6}
     e98:	e5081b06 	str	r1, [r8, #-2822]	; 0xfffff4fa
     e9c:	0e000003 	cdpeq	0, 0, cr0, cr0, cr3, {0}
     ea0:	00000557 	andeq	r0, r0, r7, asr r5
     ea4:	e5191d06 	ldr	r1, [r9, #-3334]	; 0xfffff2fa
     ea8:	00000003 	andeq	r0, r0, r3
     eac:	0004bd0e 	andeq	fp, r4, lr, lsl #26
     eb0:	191e0600 	ldmdbne	lr, {r9, sl}
     eb4:	000003e5 	andeq	r0, r0, r5, ror #7
     eb8:	07ce0e04 	strbeq	r0, [lr, r4, lsl #28]
     ebc:	1f060000 	svcne	0x00060000
     ec0:	0003eb13 	andeq	lr, r3, r3, lsl fp
     ec4:	0d000800 	stceq	8, cr0, [r0, #-0]
     ec8:	0003b004 	andeq	fp, r3, r4
     ecc:	b6040d00 	strlt	r0, [r4], -r0, lsl #26
     ed0:	11000002 	tstne	r0, r2
     ed4:	0000095c 	andeq	r0, r0, ip, asr r9
     ed8:	07220614 			; <UNDEFINED> instruction: 0x07220614
     edc:	00000673 	andeq	r0, r0, r3, ror r6
     ee0:	0008960e 	andeq	r9, r8, lr, lsl #12
     ee4:	12260600 	eorne	r0, r6, #0, 12
     ee8:	0000004d 	andeq	r0, r0, sp, asr #32
     eec:	08380e00 	ldmdaeq	r8!, {r9, sl, fp}
     ef0:	29060000 	stmdbcs	r6, {}	; <UNPREDICTABLE>
     ef4:	0003e51d 	andeq	lr, r3, sp, lsl r5
     ef8:	3c0e0400 	cfstrscc	mvf0, [lr], {-0}
     efc:	06000006 	streq	r0, [r0], -r6
     f00:	03e51d2c 	mvneq	r1, #44, 26	; 0xb00
     f04:	12080000 	andne	r0, r8, #0
     f08:	000008a0 	andeq	r0, r0, r0, lsr #17
     f0c:	6b0e2f06 	blvs	38cb2c <__bss_end+0x383bf8>
     f10:	39000006 	stmdbcc	r0, {r1, r2}
     f14:	44000004 	strmi	r0, [r0], #-4
     f18:	13000004 	movwne	r0, #4
     f1c:	00000678 	andeq	r0, r0, r8, ror r6
     f20:	0003e514 	andeq	lr, r3, r4, lsl r5
     f24:	31150000 	tstcc	r5, r0
     f28:	06000007 	streq	r0, [r0], -r7
     f2c:	06d10e31 			; <UNDEFINED> instruction: 0x06d10e31
     f30:	01f00000 	mvnseq	r0, r0
     f34:	045c0000 	ldrbeq	r0, [ip], #-0
     f38:	04670000 	strbteq	r0, [r7], #-0
     f3c:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
     f40:	14000006 	strne	r0, [r0], #-6
     f44:	000003eb 	andeq	r0, r0, fp, ror #7
     f48:	0aff1600 	beq	fffc6750 <__bss_end+0xfffbd81c>
     f4c:	35060000 	strcc	r0, [r6, #-0]
     f50:	0007851d 	andeq	r8, r7, sp, lsl r5
     f54:	0003e500 	andeq	lr, r3, r0, lsl #10
     f58:	04800200 	streq	r0, [r0], #512	; 0x200
     f5c:	04860000 	streq	r0, [r6], #0
     f60:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
     f64:	00000006 	andeq	r0, r0, r6
     f68:	00062716 	andeq	r2, r6, r6, lsl r7
     f6c:	1d370600 	ldcne	6, cr0, [r7, #-0]
     f70:	000008b0 			; <UNDEFINED> instruction: 0x000008b0
     f74:	000003e5 	andeq	r0, r0, r5, ror #7
     f78:	00049f02 	andeq	r9, r4, r2, lsl #30
     f7c:	0004a500 	andeq	sl, r4, r0, lsl #10
     f80:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
     f84:	17000000 	strne	r0, [r0, -r0]
     f88:	0000084b 	andeq	r0, r0, fp, asr #16
     f8c:	91313906 	teqls	r1, r6, lsl #18
     f90:	0c000006 	stceq	0, cr0, [r0], {6}
     f94:	095c1602 	ldmdbeq	ip, {r1, r9, sl, ip}^
     f98:	3c060000 	stccc	0, cr0, [r6], {-0}
     f9c:	00074009 	andeq	r4, r7, r9
     fa0:	00067800 	andeq	r7, r6, r0, lsl #16
     fa4:	04cc0100 	strbeq	r0, [ip], #256	; 0x100
     fa8:	04d20000 	ldrbeq	r0, [r2], #0
     fac:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
     fb0:	00000006 	andeq	r0, r0, r6
     fb4:	0006ad16 	andeq	sl, r6, r6, lsl sp
     fb8:	123f0600 	eorsne	r0, pc, #0, 12
     fbc:	00000513 	andeq	r0, r0, r3, lsl r5
     fc0:	0000004d 	andeq	r0, r0, sp, asr #32
     fc4:	0004eb01 	andeq	lr, r4, r1, lsl #22
     fc8:	00050000 	andeq	r0, r5, r0
     fcc:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
     fd0:	9a140000 	bls	500fd8 <__bss_end+0x4f80a4>
     fd4:	14000006 	strne	r0, [r0], #-6
     fd8:	0000005e 	andeq	r0, r0, lr, asr r0
     fdc:	0001f014 	andeq	pc, r1, r4, lsl r0	; <UNPREDICTABLE>
     fe0:	2f180000 	svccs	0x00180000
     fe4:	0600000b 	streq	r0, [r0], -fp
     fe8:	05ba0e42 	ldreq	r0, [sl, #3650]!	; 0xe42
     fec:	15010000 	strne	r0, [r1, #-0]
     ff0:	1b000005 	blne	100c <shift+0x100c>
     ff4:	13000005 	movwne	r0, #5
     ff8:	00000678 	andeq	r0, r0, r8, ror r6
     ffc:	04f51600 	ldrbteq	r1, [r5], #1536	; 0x600
    1000:	45060000 	strmi	r0, [r6, #-0]
    1004:	00055c17 	andeq	r5, r5, r7, lsl ip
    1008:	0003eb00 	andeq	lr, r3, r0, lsl #22
    100c:	05340100 	ldreq	r0, [r4, #-256]!	; 0xffffff00
    1010:	053a0000 	ldreq	r0, [sl, #-0]!
    1014:	a0130000 	andsge	r0, r3, r0
    1018:	00000006 	andeq	r0, r0, r6
    101c:	000a2116 	andeq	r2, sl, r6, lsl r1
    1020:	17480600 	strbne	r0, [r8, -r0, lsl #12]
    1024:	000003ff 	strdeq	r0, [r0], -pc	; <UNPREDICTABLE>
    1028:	000003eb 	andeq	r0, r0, fp, ror #7
    102c:	00055301 	andeq	r5, r5, r1, lsl #6
    1030:	00055e00 	andeq	r5, r5, r0, lsl #28
    1034:	06a01300 	strteq	r1, [r0], r0, lsl #6
    1038:	4d140000 	ldcmi	0, cr0, [r4, #-0]
    103c:	00000000 	andeq	r0, r0, r0
    1040:	0005e518 	andeq	lr, r5, r8, lsl r5
    1044:	0e4b0600 	cdpeq	6, 4, cr0, cr11, cr0, {0}
    1048:	00000859 	andeq	r0, r0, r9, asr r8
    104c:	00057301 	andeq	r7, r5, r1, lsl #6
    1050:	00057900 	andeq	r7, r5, r0, lsl #18
    1054:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
    1058:	16000000 	strne	r0, [r0], -r0
    105c:	00000731 	andeq	r0, r0, r1, lsr r7
    1060:	fc0e4d06 	vdot.bf16	d4, d14, d6
    1064:	f0000008 			; <UNDEFINED> instruction: 0xf0000008
    1068:	01000001 	tsteq	r0, r1
    106c:	00000592 	muleq	r0, r2, r5
    1070:	0000059d 	muleq	r0, sp, r5
    1074:	00067813 	andeq	r7, r6, r3, lsl r8
    1078:	004d1400 	subeq	r1, sp, r0, lsl #8
    107c:	16000000 	strne	r0, [r0], -r0
    1080:	000004a2 	andeq	r0, r0, r2, lsr #9
    1084:	2c125006 	ldccs	0, cr5, [r2], {6}
    1088:	4d000004 	stcmi	0, cr0, [r0, #-16]
    108c:	01000000 	mrseq	r0, (UNDEF: 0)
    1090:	000005b6 			; <UNDEFINED> instruction: 0x000005b6
    1094:	000005c1 	andeq	r0, r0, r1, asr #11
    1098:	00067813 	andeq	r7, r6, r3, lsl r8
    109c:	01fd1400 	mvnseq	r1, r0, lsl #8
    10a0:	16000000 	strne	r0, [r0], -r0
    10a4:	0000045f 	andeq	r0, r0, pc, asr r4
    10a8:	430e5306 	movwmi	r5, #58118	; 0xe306
    10ac:	f000000b 			; <UNDEFINED> instruction: 0xf000000b
    10b0:	01000001 	tsteq	r0, r1
    10b4:	000005da 	ldrdeq	r0, [r0], -sl
    10b8:	000005e5 	andeq	r0, r0, r5, ror #11
    10bc:	00067813 	andeq	r7, r6, r3, lsl r8
    10c0:	004d1400 	subeq	r1, sp, r0, lsl #8
    10c4:	18000000 	stmdane	r0, {}	; <UNPREDICTABLE>
    10c8:	0000047c 	andeq	r0, r0, ip, ror r4
    10cc:	6e0e5606 	cfmadd32vs	mvax0, mvfx5, mvfx14, mvfx6
    10d0:	0100000a 	tsteq	r0, sl
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
    10fc:	00000b6f 	andeq	r0, r0, pc, ror #22
    1100:	e90e5806 	stmdb	lr, {r1, r2, fp, ip, lr}
    1104:	0100000b 	tsteq	r0, fp
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
    1130:	0000048f 	andeq	r0, r0, pc, lsl #9
    1134:	d80e5b06 	stmdale	lr, {r1, r2, r8, r9, fp, ip, lr}
    1138:	f0000007 			; <UNDEFINED> instruction: 0xf0000007
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
    11a4:	0d3b1e00 	ldceq	14, cr1, [fp, #-0]
    11a8:	a4010000 	strge	r0, [r1], #-0
    11ac:	0006be0c 	andeq	fp, r6, ip, lsl #28
    11b0:	fc030500 	stc2	5, cr0, [r3], {-0}
    11b4:	1f00008e 	svcne	0x0000008e
    11b8:	00000cab 	andeq	r0, r0, fp, lsr #25
    11bc:	cd0aa601 	stcgt	6, cr10, [sl, #-4]
    11c0:	4d00000d 	stcmi	0, cr0, [r0, #-52]	; 0xffffffcc
    11c4:	90000000 	andls	r0, r0, r0
    11c8:	b0000086 	andlt	r0, r0, r6, lsl #1
    11cc:	01000000 	mrseq	r0, (UNDEF: 0)
    11d0:	0007339c 	muleq	r7, ip, r3
    11d4:	10602000 	rsbne	r2, r0, r0
    11d8:	a6010000 	strge	r0, [r1], -r0
    11dc:	0001f71b 	andeq	pc, r1, fp, lsl r7	; <UNPREDICTABLE>
    11e0:	ac910300 	ldcge	3, cr0, [r1], {0}
    11e4:	0e2c207f 	mcreq	0, 1, r2, cr12, cr15, {3}
    11e8:	a6010000 	strge	r0, [r1], -r0
    11ec:	00004d2a 	andeq	r4, r0, sl, lsr #26
    11f0:	a8910300 	ldmge	r1, {r8, r9}
    11f4:	0db61e7f 	ldceq	14, cr1, [r6, #508]!	; 0x1fc
    11f8:	a8010000 	stmdage	r1, {}	; <UNPREDICTABLE>
    11fc:	0007330a 	andeq	r3, r7, sl, lsl #6
    1200:	b4910300 	ldrlt	r0, [r1], #768	; 0x300
    1204:	0ca61e7f 	stceq	14, cr1, [r6], #508	; 0x1fc
    1208:	ac010000 	stcge	0, cr0, [r1], {-0}
    120c:	00003809 	andeq	r3, r0, r9, lsl #16
    1210:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    1214:	00250f00 	eoreq	r0, r5, r0, lsl #30
    1218:	07430000 	strbeq	r0, [r3, -r0]
    121c:	5e100000 	cdppl	0, 1, cr0, cr0, cr0, {0}
    1220:	3f000000 	svccc	0x00000000
    1224:	0e112100 	mufeqs	f2, f1, f0
    1228:	98010000 	stmdals	r1, {}	; <UNPREDICTABLE>
    122c:	000ee30a 	andeq	lr, lr, sl, lsl #6
    1230:	00004d00 	andeq	r4, r0, r0, lsl #26
    1234:	00865400 	addeq	r5, r6, r0, lsl #8
    1238:	00003c00 	andeq	r3, r0, r0, lsl #24
    123c:	809c0100 	addshi	r0, ip, r0, lsl #2
    1240:	22000007 	andcs	r0, r0, #7
    1244:	00716572 	rsbseq	r6, r1, r2, ror r5
    1248:	ab209a01 	blge	827a54 <__bss_end+0x81eb20>
    124c:	02000003 	andeq	r0, r0, #3
    1250:	c21e7491 	andsgt	r7, lr, #-1862270976	; 0x91000000
    1254:	0100000d 	tsteq	r0, sp
    1258:	004d0e9b 	umaaleq	r0, sp, fp, lr
    125c:	91020000 	mrsls	r0, (UNDEF: 2)
    1260:	35230070 	strcc	r0, [r3, #-112]!	; 0xffffff90
    1264:	0100000e 	tsteq	r0, lr
    1268:	0cc7068f 	stcleq	6, cr0, [r7], {143}	; 0x8f
    126c:	86180000 	ldrhi	r0, [r8], -r0
    1270:	003c0000 	eorseq	r0, ip, r0
    1274:	9c010000 	stcls	0, cr0, [r1], {-0}
    1278:	000007b9 			; <UNDEFINED> instruction: 0x000007b9
    127c:	000d0920 	andeq	r0, sp, r0, lsr #18
    1280:	218f0100 	orrcs	r0, pc, r0, lsl #2
    1284:	0000004d 	andeq	r0, r0, sp, asr #32
    1288:	226c9102 	rsbcs	r9, ip, #-2147483648	; 0x80000000
    128c:	00716572 	rsbseq	r6, r1, r2, ror r5
    1290:	ab209101 	blge	82569c <__bss_end+0x81c768>
    1294:	02000003 	andeq	r0, r0, #3
    1298:	21007491 			; <UNDEFINED> instruction: 0x21007491
    129c:	00000dee 	andeq	r0, r0, lr, ror #27
    12a0:	570a8301 	strpl	r8, [sl, -r1, lsl #6]
    12a4:	4d00000d 	stcmi	0, cr0, [r0, #-52]	; 0xffffffcc
    12a8:	dc000000 	stcle	0, cr0, [r0], {-0}
    12ac:	3c000085 	stccc	0, cr0, [r0], {133}	; 0x85
    12b0:	01000000 	mrseq	r0, (UNDEF: 0)
    12b4:	0007f69c 	muleq	r7, ip, r6
    12b8:	65722200 	ldrbvs	r2, [r2, #-512]!	; 0xfffffe00
    12bc:	85010071 	strhi	r0, [r1, #-113]	; 0xffffff8f
    12c0:	00038720 	andeq	r8, r3, r0, lsr #14
    12c4:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    12c8:	000c9f1e 	andeq	r9, ip, lr, lsl pc
    12cc:	0e860100 	rmfeqs	f0, f6, f0
    12d0:	0000004d 	andeq	r0, r0, sp, asr #32
    12d4:	00709102 	rsbseq	r9, r0, r2, lsl #2
    12d8:	00104321 	andseq	r4, r0, r1, lsr #6
    12dc:	0a770100 	beq	1dc16e4 <__bss_end+0x1db87b0>
    12e0:	00000d1d 	andeq	r0, r0, sp, lsl sp
    12e4:	0000004d 	andeq	r0, r0, sp, asr #32
    12e8:	000085a0 	andeq	r8, r0, r0, lsr #11
    12ec:	0000003c 	andeq	r0, r0, ip, lsr r0
    12f0:	08339c01 	ldmdaeq	r3!, {r0, sl, fp, ip, pc}
    12f4:	72220000 	eorvc	r0, r2, #0
    12f8:	01007165 	tsteq	r0, r5, ror #2
    12fc:	03872079 	orreq	r2, r7, #121	; 0x79
    1300:	91020000 	mrsls	r0, (UNDEF: 2)
    1304:	0c9f1e74 	ldceq	14, cr1, [pc], {116}	; 0x74
    1308:	7a010000 	bvc	41310 <__bss_end+0x383dc>
    130c:	00004d0e 	andeq	r4, r0, lr, lsl #26
    1310:	70910200 	addsvc	r0, r1, r0, lsl #4
    1314:	0d6b2100 	stfeqe	f2, [fp, #-0]
    1318:	6b010000 	blvs	41320 <__bss_end+0x383ec>
    131c:	000eae06 	andeq	sl, lr, r6, lsl #28
    1320:	0001f000 	andeq	pc, r1, r0
    1324:	00854c00 	addeq	r4, r5, r0, lsl #24
    1328:	00005400 	andeq	r5, r0, r0, lsl #8
    132c:	7f9c0100 	svcvc	0x009c0100
    1330:	20000008 	andcs	r0, r0, r8
    1334:	00000dc2 	andeq	r0, r0, r2, asr #27
    1338:	4d156b01 	vldrmi	d6, [r5, #-4]
    133c:	02000000 	andeq	r0, r0, #0
    1340:	e5206c91 	str	r6, [r0, #-3217]!	; 0xfffff36f
    1344:	01000008 	tsteq	r0, r8
    1348:	004d256b 	subeq	r2, sp, fp, ror #10
    134c:	91020000 	mrsls	r0, (UNDEF: 2)
    1350:	103b1e68 	eorsne	r1, fp, r8, ror #28
    1354:	6d010000 	stcvs	0, cr0, [r1, #-0]
    1358:	00004d0e 	andeq	r4, r0, lr, lsl #26
    135c:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    1360:	0cde2100 	ldfeqe	f2, [lr], {0}
    1364:	5e010000 	cdppl	0, 0, cr0, cr1, cr0, {0}
    1368:	000f1a12 	andeq	r1, pc, r2, lsl sl	; <UNPREDICTABLE>
    136c:	00008b00 	andeq	r8, r0, r0, lsl #22
    1370:	0084fc00 	addeq	pc, r4, r0, lsl #24
    1374:	00005000 	andeq	r5, r0, r0
    1378:	da9c0100 	ble	fe701780 <__bss_end+0xfe6f884c>
    137c:	20000008 	andcs	r0, r0, r8
    1380:	00000eb9 			; <UNDEFINED> instruction: 0x00000eb9
    1384:	4d205e01 	stcmi	14, cr5, [r0, #-4]!
    1388:	02000000 	andeq	r0, r0, #0
    138c:	f7206c91 			; <UNDEFINED> instruction: 0xf7206c91
    1390:	0100000d 	tsteq	r0, sp
    1394:	004d2f5e 	subeq	r2, sp, lr, asr pc
    1398:	91020000 	mrsls	r0, (UNDEF: 2)
    139c:	08e52068 	stmiaeq	r5!, {r3, r5, r6, sp}^
    13a0:	5e010000 	cdppl	0, 0, cr0, cr1, cr0, {0}
    13a4:	00004d3f 	andeq	r4, r0, pc, lsr sp
    13a8:	64910200 	ldrvs	r0, [r1], #512	; 0x200
    13ac:	00103b1e 	andseq	r3, r0, lr, lsl fp
    13b0:	16600100 	strbtne	r0, [r0], -r0, lsl #2
    13b4:	0000008b 	andeq	r0, r0, fp, lsl #1
    13b8:	00749102 	rsbseq	r9, r4, r2, lsl #2
    13bc:	000f5021 	andeq	r5, pc, r1, lsr #32
    13c0:	0a520100 	beq	14817c8 <__bss_end+0x1478894>
    13c4:	00000ce3 	andeq	r0, r0, r3, ror #25
    13c8:	0000004d 	andeq	r0, r0, sp, asr #32
    13cc:	000084b8 			; <UNDEFINED> instruction: 0x000084b8
    13d0:	00000044 	andeq	r0, r0, r4, asr #32
    13d4:	09269c01 	stmdbeq	r6!, {r0, sl, fp, ip, pc}
    13d8:	b9200000 	stmdblt	r0!, {}	; <UNPREDICTABLE>
    13dc:	0100000e 	tsteq	r0, lr
    13e0:	004d1a52 	subeq	r1, sp, r2, asr sl
    13e4:	91020000 	mrsls	r0, (UNDEF: 2)
    13e8:	0df7206c 	ldcleq	0, cr2, [r7, #432]!	; 0x1b0
    13ec:	52010000 	andpl	r0, r1, #0
    13f0:	00004d29 	andeq	r4, r0, r9, lsr #26
    13f4:	68910200 	ldmvs	r1, {r9}
    13f8:	000f491e 	andeq	r4, pc, lr, lsl r9	; <UNPREDICTABLE>
    13fc:	0e540100 	rdfeqs	f0, f4, f0
    1400:	0000004d 	andeq	r0, r0, sp, asr #32
    1404:	00749102 	rsbseq	r9, r4, r2, lsl #2
    1408:	000f4321 	andeq	r4, pc, r1, lsr #6
    140c:	0a450100 	beq	1141814 <__bss_end+0x11388e0>
    1410:	00000f25 	andeq	r0, r0, r5, lsr #30
    1414:	0000004d 	andeq	r0, r0, sp, asr #32
    1418:	00008468 	andeq	r8, r0, r8, ror #8
    141c:	00000050 	andeq	r0, r0, r0, asr r0
    1420:	09819c01 	stmibeq	r1, {r0, sl, fp, ip, pc}
    1424:	b9200000 	stmdblt	r0!, {}	; <UNPREDICTABLE>
    1428:	0100000e 	tsteq	r0, lr
    142c:	004d1945 	subeq	r1, sp, r5, asr #18
    1430:	91020000 	mrsls	r0, (UNDEF: 2)
    1434:	0d97206c 	ldceq	0, cr2, [r7, #432]	; 0x1b0
    1438:	45010000 	strmi	r0, [r1, #-0]
    143c:	00011d30 	andeq	r1, r1, r0, lsr sp
    1440:	68910200 	ldmvs	r1, {r9}
    1444:	000dfd20 	andeq	pc, sp, r0, lsr #26
    1448:	41450100 	mrsmi	r0, (UNDEF: 85)
    144c:	000006ac 	andeq	r0, r0, ip, lsr #13
    1450:	1e649102 	lgnnes	f1, f2
    1454:	0000103b 	andeq	r1, r0, fp, lsr r0
    1458:	4d0e4701 	stcmi	7, cr4, [lr, #-4]
    145c:	02000000 	andeq	r0, r0, #0
    1460:	23007491 	movwcs	r7, #1169	; 0x491
    1464:	00000c8c 	andeq	r0, r0, ip, lsl #25
    1468:	a1063f01 	tstge	r6, r1, lsl #30
    146c:	3c00000d 	stccc	0, cr0, [r0], {13}
    1470:	2c000084 	stccs	0, cr0, [r0], {132}	; 0x84
    1474:	01000000 	mrseq	r0, (UNDEF: 0)
    1478:	0009ab9c 	muleq	r9, ip, fp
    147c:	0eb92000 	cdpeq	0, 11, cr2, cr9, cr0, {0}
    1480:	3f010000 	svccc	0x00010000
    1484:	00004d15 	andeq	r4, r0, r5, lsl sp
    1488:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    148c:	0dbc2100 	ldfeqs	f2, [ip]
    1490:	32010000 	andcc	r0, r1, #0
    1494:	000e030a 	andeq	r0, lr, sl, lsl #6
    1498:	00004d00 	andeq	r4, r0, r0, lsl #26
    149c:	0083ec00 	addeq	lr, r3, r0, lsl #24
    14a0:	00005000 	andeq	r5, r0, r0
    14a4:	069c0100 	ldreq	r0, [ip], r0, lsl #2
    14a8:	2000000a 	andcs	r0, r0, sl
    14ac:	00000eb9 			; <UNDEFINED> instruction: 0x00000eb9
    14b0:	4d193201 	lfmmi	f3, 4, [r9, #-4]
    14b4:	02000000 	andeq	r0, r0, #0
    14b8:	66206c91 			; <UNDEFINED> instruction: 0x66206c91
    14bc:	0100000f 	tsteq	r0, pc
    14c0:	01f72b32 	mvnseq	r2, r2, lsr fp
    14c4:	91020000 	mrsls	r0, (UNDEF: 2)
    14c8:	0e302068 	cdpeq	0, 3, cr2, cr0, cr8, {3}
    14cc:	32010000 	andcc	r0, r1, #0
    14d0:	00004d3c 	andeq	r4, r0, ip, lsr sp
    14d4:	64910200 	ldrvs	r0, [r1], #512	; 0x200
    14d8:	000f141e 	andeq	r1, pc, lr, lsl r4	; <UNPREDICTABLE>
    14dc:	0e340100 	rsfeqs	f0, f4, f0
    14e0:	0000004d 	andeq	r0, r0, sp, asr #32
    14e4:	00749102 	rsbseq	r9, r4, r2, lsl #2
    14e8:	00106521 	andseq	r6, r0, r1, lsr #10
    14ec:	0a250100 	beq	9418f4 <__bss_end+0x9389c0>
    14f0:	00000f6d 	andeq	r0, r0, sp, ror #30
    14f4:	0000004d 	andeq	r0, r0, sp, asr #32
    14f8:	0000839c 	muleq	r0, ip, r3
    14fc:	00000050 	andeq	r0, r0, r0, asr r0
    1500:	0a619c01 	beq	186850c <__bss_end+0x185f5d8>
    1504:	b9200000 	stmdblt	r0!, {}	; <UNPREDICTABLE>
    1508:	0100000e 	tsteq	r0, lr
    150c:	004d1825 	subeq	r1, sp, r5, lsr #16
    1510:	91020000 	mrsls	r0, (UNDEF: 2)
    1514:	0f66206c 	svceq	0x0066206c
    1518:	25010000 	strcs	r0, [r1, #-0]
    151c:	000a672a 	andeq	r6, sl, sl, lsr #14
    1520:	68910200 	ldmvs	r1, {r9}
    1524:	000e3020 	andeq	r3, lr, r0, lsr #32
    1528:	3b250100 	blcc	941930 <__bss_end+0x9389fc>
    152c:	0000004d 	andeq	r0, r0, sp, asr #32
    1530:	1e649102 	lgnnes	f1, f2
    1534:	00000cb0 			; <UNDEFINED> instruction: 0x00000cb0
    1538:	4d0e2701 	stcmi	7, cr2, [lr, #-4]
    153c:	02000000 	andeq	r0, r0, #0
    1540:	0d007491 	cfstrseq	mvf7, [r0, #-580]	; 0xfffffdbc
    1544:	00002504 	andeq	r2, r0, r4, lsl #10
    1548:	0a610300 	beq	1842150 <__bss_end+0x183921c>
    154c:	c8210000 	stmdagt	r1!, {}	; <UNPREDICTABLE>
    1550:	0100000d 	tsteq	r0, sp
    1554:	10710a19 	rsbsne	r0, r1, r9, lsl sl
    1558:	004d0000 	subeq	r0, sp, r0
    155c:	83580000 	cmphi	r8, #0
    1560:	00440000 	subeq	r0, r4, r0
    1564:	9c010000 	stcls	0, cr0, [r1], {-0}
    1568:	00000ab8 			; <UNDEFINED> instruction: 0x00000ab8
    156c:	00105c20 	andseq	r5, r0, r0, lsr #24
    1570:	1b190100 	blne	641978 <__bss_end+0x638a44>
    1574:	000001f7 	strdeq	r0, [r0], -r7
    1578:	206c9102 	rsbcs	r9, ip, r2, lsl #2
    157c:	00000f61 	andeq	r0, r0, r1, ror #30
    1580:	c6351901 	ldrtgt	r1, [r5], -r1, lsl #18
    1584:	02000001 	andeq	r0, r0, #1
    1588:	b91e6891 	ldmdblt	lr, {r0, r4, r7, fp, sp, lr}
    158c:	0100000e 	tsteq	r0, lr
    1590:	004d0e1b 	subeq	r0, sp, fp, lsl lr
    1594:	91020000 	mrsls	r0, (UNDEF: 2)
    1598:	fd240074 	stc2	0, cr0, [r4, #-464]!	; 0xfffffe30
    159c:	0100000c 	tsteq	r0, ip
    15a0:	0cb60614 	ldceq	6, cr0, [r6], #80	; 0x50
    15a4:	833c0000 	teqhi	ip, #0
    15a8:	001c0000 	andseq	r0, ip, r0
    15ac:	9c010000 	stcls	0, cr0, [r1], {-0}
    15b0:	000f5723 	andeq	r5, pc, r3, lsr #14
    15b4:	060e0100 	streq	r0, [lr], -r0, lsl #2
    15b8:	00000d89 	andeq	r0, r0, r9, lsl #27
    15bc:	00008310 	andeq	r8, r0, r0, lsl r3
    15c0:	0000002c 	andeq	r0, r0, ip, lsr #32
    15c4:	0af89c01 	beq	ffe285d0 <__bss_end+0xffe1f69c>
    15c8:	f4200000 	vld4.8	{d0-d3}, [r0], r0
    15cc:	0100000c 	tsteq	r0, ip
    15d0:	0038140e 	eorseq	r1, r8, lr, lsl #8
    15d4:	91020000 	mrsls	r0, (UNDEF: 2)
    15d8:	6a250074 	bvs	9417b0 <__bss_end+0x93887c>
    15dc:	01000010 	tsteq	r0, r0, lsl r0
    15e0:	0dab0a04 			; <UNDEFINED> instruction: 0x0dab0a04
    15e4:	004d0000 	subeq	r0, sp, r0
    15e8:	82e40000 	rschi	r0, r4, #0
    15ec:	002c0000 	eoreq	r0, ip, r0
    15f0:	9c010000 	stcls	0, cr0, [r1], {-0}
    15f4:	64697022 	strbtvs	r7, [r9], #-34	; 0xffffffde
    15f8:	0e060100 	adfeqs	f0, f6, f0
    15fc:	0000004d 	andeq	r0, r0, sp, asr #32
    1600:	00749102 	rsbseq	r9, r4, r2, lsl #2
    1604:	00032e00 	andeq	r2, r3, r0, lsl #28
    1608:	9c000400 	cfstrsls	mvf0, [r0], {-0}
    160c:	04000006 	streq	r0, [r0], #-6
    1610:	000f7901 	andeq	r7, pc, r1, lsl #18
    1614:	10b10400 	adcsne	r0, r1, r0, lsl #8
    1618:	0c410000 	mareq	acc0, r0, r1
    161c:	87400000 	strbhi	r0, [r0, -r0]
    1620:	04b80000 	ldrteq	r0, [r8], #0
    1624:	07e80000 	strbeq	r0, [r8, r0]!
    1628:	49020000 	stmdbmi	r2, {}	; <UNPREDICTABLE>
    162c:	03000000 	movweq	r0, #0
    1630:	0000111a 	andeq	r1, r0, sl, lsl r1
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
    166c:	0a490704 	beq	1243284 <__bss_end+0x123a350>
    1670:	01080000 	mrseq	r0, (UNDEF: 8)
    1674:	000ad708 	andeq	sp, sl, r8, lsl #14
    1678:	006d0700 	rsbeq	r0, sp, r0, lsl #14
    167c:	2a090000 	bcs	241684 <__bss_end+0x238750>
    1680:	0a000000 	beq	1688 <shift+0x1688>
    1684:	00001149 	andeq	r1, r0, r9, asr #2
    1688:	34066401 	strcc	r6, [r6], #-1025	; 0xfffffbff
    168c:	78000011 	stmdavc	r0, {r0, r4}
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
    16b8:	0b609102 	bleq	1825ac8 <__bss_end+0x181cb94>
    16bc:	006d756e 	rsbeq	r7, sp, lr, ror #10
    16c0:	042d6401 	strteq	r6, [sp], #-1025	; 0xfffffbff
    16c4:	02000001 	andeq	r0, r0, #1
    16c8:	a30c5c91 	movwge	r5, #52369	; 0xcc91
    16cc:	01000011 	tsteq	r0, r1, lsl r0
    16d0:	010b0e66 	tsteq	fp, r6, ror #28
    16d4:	91020000 	mrsls	r0, (UNDEF: 2)
    16d8:	11260c70 			; <UNDEFINED> instruction: 0x11260c70
    16dc:	67010000 	strvs	r0, [r1, -r0]
    16e0:	00011108 	andeq	r1, r1, r8, lsl #2
    16e4:	6c910200 	lfmvs	f0, 4, [r1], {0}
    16e8:	008ba00d 	addeq	sl, fp, sp
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
    171c:	0010980a 	andseq	r9, r0, sl, lsl #16
    1720:	065c0100 	ldrbeq	r0, [ip], -r0, lsl #2
    1724:	000010a5 	andeq	r1, r0, r5, lsr #1
    1728:	00008b10 	andeq	r8, r0, r0, lsl fp
    172c:	00000068 	andeq	r0, r0, r8, rrx
    1730:	01769c01 	cmneq	r6, r1, lsl #24
    1734:	9c130000 	ldcls	0, cr0, [r3], {-0}
    1738:	01000011 	tsteq	r0, r1, lsl r0
    173c:	0102125c 	tsteq	r2, ip, asr r2
    1740:	91020000 	mrsls	r0, (UNDEF: 2)
    1744:	109e136c 	addsne	r1, lr, ip, ror #6
    1748:	5c010000 	stcpl	0, cr0, [r1], {-0}
    174c:	0001041e 	andeq	r0, r1, lr, lsl r4
    1750:	68910200 	ldmvs	r1, {r9}
    1754:	6d656d0e 	stclvs	13, cr6, [r5, #-56]!	; 0xffffffc8
    1758:	085e0100 	ldmdaeq	lr, {r8}^
    175c:	00000111 	andeq	r0, r0, r1, lsl r1
    1760:	0d709102 	ldfeqp	f1, [r0, #-8]!
    1764:	00008b2c 	andeq	r8, r0, ip, lsr #22
    1768:	0000003c 	andeq	r0, r0, ip, lsr r0
    176c:	0100690e 	tsteq	r0, lr, lsl #18
    1770:	01040b60 	tsteq	r4, r0, ror #22
    1774:	91020000 	mrsls	r0, (UNDEF: 2)
    1778:	14000074 	strne	r0, [r0], #-116	; 0xffffff8c
    177c:	00001150 	andeq	r1, r0, r0, asr r1
    1780:	69055201 	stmdbvs	r5, {r0, r9, ip, lr}
    1784:	04000011 	streq	r0, [r0], #-17	; 0xffffffef
    1788:	bc000001 	stclt	0, cr0, [r0], {1}
    178c:	5400008a 	strpl	r0, [r0], #-138	; 0xffffff76
    1790:	01000000 	mrseq	r0, (UNDEF: 0)
    1794:	0001af9c 	muleq	r1, ip, pc	; <UNPREDICTABLE>
    1798:	00730b00 	rsbseq	r0, r3, r0, lsl #22
    179c:	0b185201 	bleq	615fa8 <__bss_end+0x60d074>
    17a0:	02000001 	andeq	r0, r0, #1
    17a4:	690e6c91 	stmdbvs	lr, {r0, r4, r7, sl, fp, sp, lr}
    17a8:	06540100 	ldrbeq	r0, [r4], -r0, lsl #2
    17ac:	00000104 	andeq	r0, r0, r4, lsl #2
    17b0:	00749102 	rsbseq	r9, r4, r2, lsl #2
    17b4:	00118c14 	andseq	r8, r1, r4, lsl ip
    17b8:	05420100 	strbeq	r0, [r2, #-256]	; 0xffffff00
    17bc:	00001157 	andeq	r1, r0, r7, asr r1
    17c0:	00000104 	andeq	r0, r0, r4, lsl #2
    17c4:	00008a10 	andeq	r8, r0, r0, lsl sl
    17c8:	000000ac 	andeq	r0, r0, ip, lsr #1
    17cc:	02159c01 	andseq	r9, r5, #256	; 0x100
    17d0:	730b0000 	movwvc	r0, #45056	; 0xb000
    17d4:	42010031 	andmi	r0, r1, #49	; 0x31
    17d8:	00010b19 	andeq	r0, r1, r9, lsl fp
    17dc:	6c910200 	lfmvs	f0, 4, [r1], {0}
    17e0:	0032730b 	eorseq	r7, r2, fp, lsl #6
    17e4:	0b294201 	bleq	a51ff0 <__bss_end+0xa490bc>
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
    181c:	000ace08 	andeq	ip, sl, r8, lsl #28
    1820:	11941400 	orrsne	r1, r4, r0, lsl #8
    1824:	36010000 	strcc	r0, [r1], -r0
    1828:	00117b07 	andseq	r7, r1, r7, lsl #22
    182c:	00011100 	andeq	r1, r1, r0, lsl #2
    1830:	00895000 	addeq	r5, r9, r0
    1834:	0000c000 	andeq	ip, r0, r0
    1838:	759c0100 	ldrvc	r0, [ip, #256]	; 0x100
    183c:	13000002 	movwne	r0, #2
    1840:	00001093 	muleq	r0, r3, r0
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
    1878:	76140074 			; <UNDEFINED> instruction: 0x76140074
    187c:	01000011 	tsteq	r0, r1, lsl r0
    1880:	110f0524 	tstne	pc, r4, lsr #10
    1884:	01040000 	mrseq	r0, (UNDEF: 4)
    1888:	88b40000 	ldmhi	r4!, {}	; <UNPREDICTABLE>
    188c:	009c0000 	addseq	r0, ip, r0
    1890:	9c010000 	stcls	0, cr0, [r1], {-0}
    1894:	000002b2 			; <UNDEFINED> instruction: 0x000002b2
    1898:	00108d13 	andseq	r8, r0, r3, lsl sp
    189c:	16240100 	strtne	r0, [r4], -r0, lsl #2
    18a0:	0000010b 	andeq	r0, r0, fp, lsl #2
    18a4:	0c6c9102 	stfeqp	f1, [ip], #-8
    18a8:	0000112d 	andeq	r1, r0, sp, lsr #2
    18ac:	04062601 	streq	r2, [r6], #-1537	; 0xfffff9ff
    18b0:	02000001 	andeq	r0, r0, #1
    18b4:	15007491 	strne	r7, [r0, #-1169]	; 0xfffffb6f
    18b8:	000011aa 	andeq	r1, r0, sl, lsr #3
    18bc:	af060801 	svcge	0x00060801
    18c0:	40000011 	andmi	r0, r0, r1, lsl r0
    18c4:	74000087 	strvc	r0, [r0], #-135	; 0xffffff79
    18c8:	01000001 	tsteq	r0, r1
    18cc:	108d139c 	umullne	r1, sp, ip, r3
    18d0:	08010000 	stmdaeq	r1, {}	; <UNPREDICTABLE>
    18d4:	00006618 	andeq	r6, r0, r8, lsl r6
    18d8:	64910200 	ldrvs	r0, [r1], #512	; 0x200
    18dc:	00112d13 	andseq	r2, r1, r3, lsl sp
    18e0:	25080100 	strcs	r0, [r8, #-256]	; 0xffffff00
    18e4:	00000111 	andeq	r0, r0, r1, lsl r1
    18e8:	13609102 	cmnne	r0, #-2147483648	; 0x80000000
    18ec:	00001144 	andeq	r1, r0, r4, asr #2
    18f0:	663a0801 	ldrtvs	r0, [sl], -r1, lsl #16
    18f4:	02000000 	andeq	r0, r0, #0
    18f8:	690e5c91 	stmdbvs	lr, {r0, r4, r7, sl, fp, ip, lr}
    18fc:	060a0100 	streq	r0, [sl], -r0, lsl #2
    1900:	00000104 	andeq	r0, r0, r4, lsl #2
    1904:	0d749102 	ldfeqp	f1, [r4, #-8]!
    1908:	0000880c 	andeq	r8, r0, ip, lsl #16
    190c:	00000098 	muleq	r0, r8, r0
    1910:	01006a0e 	tsteq	r0, lr, lsl #20
    1914:	01040b1c 	tsteq	r4, ip, lsl fp
    1918:	91020000 	mrsls	r0, (UNDEF: 2)
    191c:	88340d70 	ldmdahi	r4!, {r4, r5, r6, r8, sl, fp}
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
   8:	1b0e0301 	blne	380c14 <__bss_end+0x377ce0>
   c:	130e250e 	movwne	r2, #58638	; 0xe50e
  10:	00000005 	andeq	r0, r0, r5
  14:	25011101 	strcs	r1, [r1, #-257]	; 0xfffffeff
  18:	030b130e 	movweq	r1, #45838	; 0xb30e
  1c:	110e1b0e 	tstne	lr, lr, lsl #22
  20:	10061201 	andne	r1, r6, r1, lsl #4
  24:	02000017 	andeq	r0, r0, #23
  28:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
  2c:	0b3b0b3a 	bleq	ec2d1c <__bss_end+0xeb9de8>
  30:	13490b39 	movtne	r0, #39737	; 0x9b39
  34:	193c193f 	ldmdbne	ip!, {r0, r1, r2, r3, r4, r5, r8, fp, ip}
  38:	24030000 	strcs	r0, [r3], #-0
  3c:	3e0b0b00 	vmlacc.f64	d0, d11, d0
  40:	000e030b 	andeq	r0, lr, fp, lsl #6
  44:	012e0400 			; <UNDEFINED> instruction: 0x012e0400
  48:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
  4c:	0b3b0b3a 	bleq	ec2d3c <__bss_end+0xeb9e08>
  50:	01110b39 	tsteq	r1, r9, lsr fp
  54:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
  58:	01194296 			; <UNDEFINED> instruction: 0x01194296
  5c:	05000013 	streq	r0, [r0, #-19]	; 0xffffffed
  60:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
  64:	0b3b0b3a 	bleq	ec2d54 <__bss_end+0xeb9e20>
  68:	13490b39 	movtne	r0, #39737	; 0x9b39
  6c:	00001802 	andeq	r1, r0, r2, lsl #16
  70:	0b002406 	bleq	9090 <__bss_end+0x15c>
  74:	030b3e0b 	movweq	r3, #48651	; 0xbe0b
  78:	07000008 	streq	r0, [r0, -r8]
  7c:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
  80:	0b3a0e03 	bleq	e83894 <__bss_end+0xe7a960>
  84:	0b390b3b 	bleq	e42d78 <__bss_end+0xe39e44>
  88:	06120111 			; <UNDEFINED> instruction: 0x06120111
  8c:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
  90:	00130119 	andseq	r0, r3, r9, lsl r1
  94:	010b0800 	tsteq	fp, r0, lsl #16
  98:	06120111 			; <UNDEFINED> instruction: 0x06120111
  9c:	34090000 	strcc	r0, [r9], #-0
  a0:	3a080300 	bcc	200ca8 <__bss_end+0x1f7d74>
  a4:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
  a8:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
  ac:	0a000018 	beq	114 <shift+0x114>
  b0:	0b0b000f 	bleq	2c00f4 <__bss_end+0x2b71c0>
  b4:	00001349 	andeq	r1, r0, r9, asr #6
  b8:	01110100 	tsteq	r1, r0, lsl #2
  bc:	0b130e25 	bleq	4c3958 <__bss_end+0x4baa24>
  c0:	0e1b0e03 	cdpeq	14, 1, cr0, cr11, cr3, {0}
  c4:	06120111 			; <UNDEFINED> instruction: 0x06120111
  c8:	00001710 	andeq	r1, r0, r0, lsl r7
  cc:	03001602 	movweq	r1, #1538	; 0x602
  d0:	3b0b3a0e 	blcc	2ce910 <__bss_end+0x2c59dc>
  d4:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
  d8:	03000013 	movweq	r0, #19
  dc:	0b0b000f 	bleq	2c0120 <__bss_end+0x2b71ec>
  e0:	00001349 	andeq	r1, r0, r9, asr #6
  e4:	00001504 	andeq	r1, r0, r4, lsl #10
  e8:	01010500 	tsteq	r1, r0, lsl #10
  ec:	13011349 	movwne	r1, #4937	; 0x1349
  f0:	21060000 	mrscs	r0, (UNDEF: 6)
  f4:	2f134900 	svccs	0x00134900
  f8:	07000006 	streq	r0, [r0, -r6]
  fc:	0b0b0024 	bleq	2c0194 <__bss_end+0x2b7260>
 100:	0e030b3e 	vmoveq.16	d3[0], r0
 104:	34080000 	strcc	r0, [r8], #-0
 108:	3a0e0300 	bcc	380d10 <__bss_end+0x377ddc>
 10c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 110:	3f13490b 	svccc	0x0013490b
 114:	00193c19 	andseq	r3, r9, r9, lsl ip
 118:	012e0900 			; <UNDEFINED> instruction: 0x012e0900
 11c:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 120:	0b3b0b3a 	bleq	ec2e10 <__bss_end+0xeb9edc>
 124:	13490b39 	movtne	r0, #39737	; 0x9b39
 128:	06120111 			; <UNDEFINED> instruction: 0x06120111
 12c:	42961840 	addsmi	r1, r6, #64, 16	; 0x400000
 130:	00130119 	andseq	r0, r3, r9, lsl r1
 134:	00340a00 	eorseq	r0, r4, r0, lsl #20
 138:	0b3a0e03 	bleq	e8394c <__bss_end+0xe7aa18>
 13c:	0b390b3b 	bleq	e42e30 <__bss_end+0xe39efc>
 140:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 144:	240b0000 	strcs	r0, [fp], #-0
 148:	3e0b0b00 	vmlacc.f64	d0, d11, d0
 14c:	0008030b 	andeq	r0, r8, fp, lsl #6
 150:	002e0c00 	eoreq	r0, lr, r0, lsl #24
 154:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 158:	0b3b0b3a 	bleq	ec2e48 <__bss_end+0xeb9f14>
 15c:	01110b39 	tsteq	r1, r9, lsr fp
 160:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 164:	00194297 	mulseq	r9, r7, r2
 168:	01390d00 	teqeq	r9, r0, lsl #26
 16c:	0b3a0e03 	bleq	e83980 <__bss_end+0xe7aa4c>
 170:	13010b3b 	movwne	r0, #6971	; 0x1b3b
 174:	2e0e0000 	cdpcs	0, 0, cr0, cr14, cr0, {0}
 178:	03193f01 	tsteq	r9, #1, 30
 17c:	3b0b3a0e 	blcc	2ce9bc <__bss_end+0x2c5a88>
 180:	3c0b390b 			; <UNDEFINED> instruction: 0x3c0b390b
 184:	00130119 	andseq	r0, r3, r9, lsl r1
 188:	00050f00 	andeq	r0, r5, r0, lsl #30
 18c:	00001349 	andeq	r1, r0, r9, asr #6
 190:	3f012e10 	svccc	0x00012e10
 194:	3a0e0319 	bcc	380e00 <__bss_end+0x377ecc>
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
 1c0:	3a080300 	bcc	200dc8 <__bss_end+0x1f7e94>
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
 1f4:	0b0b0024 	bleq	2c028c <__bss_end+0x2b7358>
 1f8:	0e030b3e 	vmoveq.16	d3[0], r0
 1fc:	24030000 	strcs	r0, [r3], #-0
 200:	3e0b0b00 	vmlacc.f64	d0, d11, d0
 204:	0008030b 	andeq	r0, r8, fp, lsl #6
 208:	00160400 	andseq	r0, r6, r0, lsl #8
 20c:	0b3a0e03 	bleq	e83a20 <__bss_end+0xe7aaec>
 210:	0b390b3b 	bleq	e42f04 <__bss_end+0xe39fd0>
 214:	00001349 	andeq	r1, r0, r9, asr #6
 218:	49002605 	stmdbmi	r0, {r0, r2, r9, sl, sp}
 21c:	06000013 			; <UNDEFINED> instruction: 0x06000013
 220:	0e030113 	mcreq	1, 0, r0, cr3, cr3, {0}
 224:	0b3a0b0b 	bleq	e82e58 <__bss_end+0xe79f24>
 228:	0b390b3b 	bleq	e42f1c <__bss_end+0xe39fe8>
 22c:	00001301 	andeq	r1, r0, r1, lsl #6
 230:	03000d07 	movweq	r0, #3335	; 0xd07
 234:	3b0b3a08 	blcc	2cea5c <__bss_end+0x2c5b28>
 238:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 23c:	000b3813 	andeq	r3, fp, r3, lsl r8
 240:	01040800 	tsteq	r4, r0, lsl #16
 244:	196d0e03 	stmdbne	sp!, {r0, r1, r9, sl, fp}^
 248:	0b0b0b3e 	bleq	2c2f48 <__bss_end+0x2ba014>
 24c:	0b3a1349 	bleq	e84f78 <__bss_end+0xe7c044>
 250:	0b390b3b 	bleq	e42f44 <__bss_end+0xe3a010>
 254:	00001301 	andeq	r1, r0, r1, lsl #6
 258:	03002809 	movweq	r2, #2057	; 0x809
 25c:	000b1c0e 	andeq	r1, fp, lr, lsl #24
 260:	00340a00 	eorseq	r0, r4, r0, lsl #20
 264:	0b3a0e03 	bleq	e83a78 <__bss_end+0xe7ab44>
 268:	0b390b3b 	bleq	e42f5c <__bss_end+0xe3a028>
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
 294:	0b3b0b3a 	bleq	ec2f84 <__bss_end+0xeba050>
 298:	13490b39 	movtne	r0, #39737	; 0x9b39
 29c:	00000b38 	andeq	r0, r0, r8, lsr fp
 2a0:	4901010f 	stmdbmi	r1, {r0, r1, r2, r3, r8}
 2a4:	00130113 	andseq	r0, r3, r3, lsl r1
 2a8:	00211000 	eoreq	r1, r1, r0
 2ac:	0b2f1349 	bleq	bc4fd8 <__bss_end+0xbbc0a4>
 2b0:	02110000 	andseq	r0, r1, #0
 2b4:	0b0e0301 	bleq	380ec0 <__bss_end+0x377f8c>
 2b8:	3b0b3a0b 	blcc	2ceaec <__bss_end+0x2c5bb8>
 2bc:	010b390b 	tsteq	fp, fp, lsl #18
 2c0:	12000013 	andne	r0, r0, #19
 2c4:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 2c8:	0b3a0e03 	bleq	e83adc <__bss_end+0xe7aba8>
 2cc:	0b390b3b 	bleq	e42fc0 <__bss_end+0xe3a08c>
 2d0:	193c0e6e 	ldmdbne	ip!, {r1, r2, r3, r5, r6, r9, sl, fp}
 2d4:	13011364 	movwne	r1, #4964	; 0x1364
 2d8:	05130000 	ldreq	r0, [r3, #-0]
 2dc:	34134900 	ldrcc	r4, [r3], #-2304	; 0xfffff700
 2e0:	14000019 	strne	r0, [r0], #-25	; 0xffffffe7
 2e4:	13490005 	movtne	r0, #36869	; 0x9005
 2e8:	2e150000 	cdpcs	0, 1, cr0, cr5, cr0, {0}
 2ec:	03193f01 	tsteq	r9, #1, 30
 2f0:	3b0b3a0e 	blcc	2ceb30 <__bss_end+0x2c5bfc>
 2f4:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 2f8:	3c13490e 			; <UNDEFINED> instruction: 0x3c13490e
 2fc:	01136419 	tsteq	r3, r9, lsl r4
 300:	16000013 			; <UNDEFINED> instruction: 0x16000013
 304:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 308:	0b3a0e03 	bleq	e83b1c <__bss_end+0xe7abe8>
 30c:	0b390b3b 	bleq	e43000 <__bss_end+0xe3a0cc>
 310:	13490e6e 	movtne	r0, #40558	; 0x9e6e
 314:	193c0b32 	ldmdbne	ip!, {r1, r4, r5, r8, r9, fp}
 318:	13011364 	movwne	r1, #4964	; 0x1364
 31c:	0d170000 	ldceq	0, cr0, [r7, #-0]
 320:	3a0e0300 	bcc	380f28 <__bss_end+0x377ff4>
 324:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 328:	3813490b 	ldmdacc	r3, {r0, r1, r3, r8, fp, lr}
 32c:	000b320b 	andeq	r3, fp, fp, lsl #4
 330:	012e1800 			; <UNDEFINED> instruction: 0x012e1800
 334:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 338:	0b3b0b3a 	bleq	ec3028 <__bss_end+0xeba0f4>
 33c:	0e6e0b39 	vmoveq.8	d14[5], r0
 340:	193c0b32 	ldmdbne	ip!, {r1, r4, r5, r8, r9, fp}
 344:	13011364 	movwne	r1, #4964	; 0x1364
 348:	2e190000 	cdpcs	0, 1, cr0, cr9, cr0, {0}
 34c:	03193f01 	tsteq	r9, #1, 30
 350:	3b0b3a0e 	blcc	2ceb90 <__bss_end+0x2c5c5c>
 354:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 358:	3213490e 	andscc	r4, r3, #229376	; 0x38000
 35c:	64193c0b 	ldrvs	r3, [r9], #-3083	; 0xfffff3f5
 360:	1a000013 	bne	3b4 <shift+0x3b4>
 364:	13490115 	movtne	r0, #37141	; 0x9115
 368:	13011364 	movwne	r1, #4964	; 0x1364
 36c:	1f1b0000 	svcne	0x001b0000
 370:	49131d00 	ldmdbmi	r3, {r8, sl, fp, ip}
 374:	1c000013 	stcne	0, cr0, [r0], {19}
 378:	0b0b0010 	bleq	2c03c0 <__bss_end+0x2b748c>
 37c:	00001349 	andeq	r1, r0, r9, asr #6
 380:	0b000f1d 	bleq	3ffc <shift+0x3ffc>
 384:	1e00000b 	cdpne	0, 0, cr0, cr0, cr11, {0}
 388:	08030139 	stmdaeq	r3, {r0, r3, r4, r5, r8}
 38c:	0b3b0b3a 	bleq	ec307c <__bss_end+0xeba148>
 390:	13010b39 	movwne	r0, #6969	; 0x1b39
 394:	341f0000 	ldrcc	r0, [pc], #-0	; 39c <shift+0x39c>
 398:	3a0e0300 	bcc	380fa0 <__bss_end+0x37806c>
 39c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 3a0:	3c13490b 			; <UNDEFINED> instruction: 0x3c13490b
 3a4:	6c061c19 	stcvs	12, cr1, [r6], {25}
 3a8:	20000019 	andcs	r0, r0, r9, lsl r0
 3ac:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 3b0:	0b3b0b3a 	bleq	ec30a0 <__bss_end+0xeba16c>
 3b4:	13490b39 	movtne	r0, #39737	; 0x9b39
 3b8:	0b1c193c 	bleq	7068b0 <__bss_end+0x6fd97c>
 3bc:	0000196c 	andeq	r1, r0, ip, ror #18
 3c0:	47003421 	strmi	r3, [r0, -r1, lsr #8]
 3c4:	22000013 	andcs	r0, r0, #19
 3c8:	08030034 	stmdaeq	r3, {r2, r4, r5}
 3cc:	0b3b0b3a 	bleq	ec30bc <__bss_end+0xeba188>
 3d0:	13490b39 	movtne	r0, #39737	; 0x9b39
 3d4:	1802193f 	stmdane	r2, {r0, r1, r2, r3, r4, r5, r8, fp, ip}
 3d8:	34230000 	strtcc	r0, [r3], #-0
 3dc:	3a0e0300 	bcc	380fe4 <__bss_end+0x3780b0>
 3e0:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 3e4:	3f13490b 	svccc	0x0013490b
 3e8:	00180219 	andseq	r0, r8, r9, lsl r2
 3ec:	012e2400 			; <UNDEFINED> instruction: 0x012e2400
 3f0:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 3f4:	0b3b0b3a 	bleq	ec30e4 <__bss_end+0xeba1b0>
 3f8:	13490b39 	movtne	r0, #39737	; 0x9b39
 3fc:	06120111 			; <UNDEFINED> instruction: 0x06120111
 400:	42961840 	addsmi	r1, r6, #64, 16	; 0x400000
 404:	00130119 	andseq	r0, r3, r9, lsl r1
 408:	00052500 	andeq	r2, r5, r0, lsl #10
 40c:	0b3a0e03 	bleq	e83c20 <__bss_end+0xe7acec>
 410:	0b390b3b 	bleq	e43104 <__bss_end+0xe3a1d0>
 414:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 418:	34260000 	strtcc	r0, [r6], #-0
 41c:	3a0e0300 	bcc	381024 <__bss_end+0x3780f0>
 420:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 424:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 428:	27000018 	smladcs	r0, r8, r0, r0
 42c:	13490101 	movtne	r0, #37121	; 0x9101
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
 458:	0b002404 	bleq	9470 <__bss_end+0x53c>
 45c:	030b3e0b 	movweq	r3, #48651	; 0xbe0b
 460:	05000008 	streq	r0, [r0, #-8]
 464:	0e030016 	mcreq	0, 0, r0, cr3, cr6, {0}
 468:	0b3b0b3a 	bleq	ec3158 <__bss_end+0xeba224>
 46c:	13490b39 	movtne	r0, #39737	; 0x9b39
 470:	13060000 	movwne	r0, #24576	; 0x6000
 474:	0b0e0301 	bleq	381080 <__bss_end+0x37814c>
 478:	3b0b3a0b 	blcc	2cecac <__bss_end+0x2c5d78>
 47c:	010b390b 	tsteq	fp, fp, lsl #18
 480:	07000013 	smladeq	r0, r3, r0, r0
 484:	0803000d 	stmdaeq	r3, {r0, r2, r3}
 488:	0b3b0b3a 	bleq	ec3178 <__bss_end+0xeba244>
 48c:	13490b39 	movtne	r0, #39737	; 0x9b39
 490:	00000b38 	andeq	r0, r0, r8, lsr fp
 494:	03010408 	movweq	r0, #5128	; 0x1408
 498:	3e196d0e 	cdpcc	13, 1, cr6, cr9, cr14, {0}
 49c:	490b0b0b 	stmdbmi	fp, {r0, r1, r3, r8, r9, fp}
 4a0:	3b0b3a13 	blcc	2cecf4 <__bss_end+0x2c5dc0>
 4a4:	010b390b 	tsteq	fp, fp, lsl #18
 4a8:	09000013 	stmdbeq	r0, {r0, r1, r4}
 4ac:	08030028 	stmdaeq	r3, {r3, r5}
 4b0:	00000b1c 	andeq	r0, r0, ip, lsl fp
 4b4:	0300280a 	movweq	r2, #2058	; 0x80a
 4b8:	000b1c0e 	andeq	r1, fp, lr, lsl #24
 4bc:	00340b00 	eorseq	r0, r4, r0, lsl #22
 4c0:	0b3a0e03 	bleq	e83cd4 <__bss_end+0xe7ada0>
 4c4:	0b390b3b 	bleq	e431b8 <__bss_end+0xe3a284>
 4c8:	196c1349 	stmdbne	ip!, {r0, r3, r6, r8, r9, ip}^
 4cc:	00001802 	andeq	r1, r0, r2, lsl #16
 4d0:	0300020c 	movweq	r0, #524	; 0x20c
 4d4:	00193c0e 	andseq	r3, r9, lr, lsl #24
 4d8:	000f0d00 	andeq	r0, pc, r0, lsl #26
 4dc:	13490b0b 	movtne	r0, #39691	; 0x9b0b
 4e0:	0d0e0000 	stceq	0, cr0, [lr, #-0]
 4e4:	3a0e0300 	bcc	3810ec <__bss_end+0x3781b8>
 4e8:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 4ec:	3813490b 	ldmdacc	r3, {r0, r1, r3, r8, fp, lr}
 4f0:	0f00000b 	svceq	0x0000000b
 4f4:	13490101 	movtne	r0, #37121	; 0x9101
 4f8:	00001301 	andeq	r1, r0, r1, lsl #6
 4fc:	49002110 	stmdbmi	r0, {r4, r8, sp}
 500:	000b2f13 	andeq	r2, fp, r3, lsl pc
 504:	01021100 	mrseq	r1, (UNDEF: 18)
 508:	0b0b0e03 	bleq	2c3d1c <__bss_end+0x2bade8>
 50c:	0b3b0b3a 	bleq	ec31fc <__bss_end+0xeba2c8>
 510:	13010b39 	movwne	r0, #6969	; 0x1b39
 514:	2e120000 	cdpcs	0, 1, cr0, cr2, cr0, {0}
 518:	03193f01 	tsteq	r9, #1, 30
 51c:	3b0b3a0e 	blcc	2ced5c <__bss_end+0x2c5e28>
 520:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 524:	64193c0e 	ldrvs	r3, [r9], #-3086	; 0xfffff3f2
 528:	00130113 	andseq	r0, r3, r3, lsl r1
 52c:	00051300 	andeq	r1, r5, r0, lsl #6
 530:	19341349 	ldmdbne	r4!, {r0, r3, r6, r8, r9, ip}
 534:	05140000 	ldreq	r0, [r4, #-0]
 538:	00134900 	andseq	r4, r3, r0, lsl #18
 53c:	012e1500 			; <UNDEFINED> instruction: 0x012e1500
 540:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 544:	0b3b0b3a 	bleq	ec3234 <__bss_end+0xeba300>
 548:	0e6e0b39 	vmoveq.8	d14[5], r0
 54c:	193c1349 	ldmdbne	ip!, {r0, r3, r6, r8, r9, ip}
 550:	13011364 	movwne	r1, #4964	; 0x1364
 554:	2e160000 	cdpcs	0, 1, cr0, cr6, cr0, {0}
 558:	03193f01 	tsteq	r9, #1, 30
 55c:	3b0b3a0e 	blcc	2ced9c <__bss_end+0x2c5e68>
 560:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 564:	3213490e 	andscc	r4, r3, #229376	; 0x38000
 568:	64193c0b 	ldrvs	r3, [r9], #-3083	; 0xfffff3f5
 56c:	00130113 	andseq	r0, r3, r3, lsl r1
 570:	000d1700 	andeq	r1, sp, r0, lsl #14
 574:	0b3a0e03 	bleq	e83d88 <__bss_end+0xe7ae54>
 578:	0b390b3b 	bleq	e4326c <__bss_end+0xe3a338>
 57c:	0b381349 	bleq	e052a8 <__bss_end+0xdfc374>
 580:	00000b32 	andeq	r0, r0, r2, lsr fp
 584:	3f012e18 	svccc	0x00012e18
 588:	3a0e0319 	bcc	3811f4 <__bss_end+0x3782c0>
 58c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 590:	320e6e0b 	andcc	r6, lr, #11, 28	; 0xb0
 594:	64193c0b 	ldrvs	r3, [r9], #-3083	; 0xfffff3f5
 598:	00130113 	andseq	r0, r3, r3, lsl r1
 59c:	012e1900 			; <UNDEFINED> instruction: 0x012e1900
 5a0:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 5a4:	0b3b0b3a 	bleq	ec3294 <__bss_end+0xeba360>
 5a8:	0e6e0b39 	vmoveq.8	d14[5], r0
 5ac:	0b321349 	bleq	c852d8 <__bss_end+0xc7c3a4>
 5b0:	1364193c 	cmnne	r4, #60, 18	; 0xf0000
 5b4:	151a0000 	ldrne	r0, [sl, #-0]
 5b8:	64134901 	ldrvs	r4, [r3], #-2305	; 0xfffff6ff
 5bc:	00130113 	andseq	r0, r3, r3, lsl r1
 5c0:	001f1b00 	andseq	r1, pc, r0, lsl #22
 5c4:	1349131d 	movtne	r1, #37661	; 0x931d
 5c8:	101c0000 	andsne	r0, ip, r0
 5cc:	490b0b00 	stmdbmi	fp, {r8, r9, fp}
 5d0:	1d000013 	stcne	0, cr0, [r0, #-76]	; 0xffffffb4
 5d4:	0b0b000f 	bleq	2c0618 <__bss_end+0x2b76e4>
 5d8:	341e0000 	ldrcc	r0, [lr], #-0
 5dc:	3a0e0300 	bcc	3811e4 <__bss_end+0x3782b0>
 5e0:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 5e4:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 5e8:	1f000018 	svcne	0x00000018
 5ec:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 5f0:	0b3a0e03 	bleq	e83e04 <__bss_end+0xe7aed0>
 5f4:	0b390b3b 	bleq	e432e8 <__bss_end+0xe3a3b4>
 5f8:	13490e6e 	movtne	r0, #40558	; 0x9e6e
 5fc:	06120111 			; <UNDEFINED> instruction: 0x06120111
 600:	42961840 	addsmi	r1, r6, #64, 16	; 0x400000
 604:	00130119 	andseq	r0, r3, r9, lsl r1
 608:	00052000 	andeq	r2, r5, r0
 60c:	0b3a0e03 	bleq	e83e20 <__bss_end+0xe7aeec>
 610:	0b390b3b 	bleq	e43304 <__bss_end+0xe3a3d0>
 614:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 618:	2e210000 	cdpcs	0, 2, cr0, cr1, cr0, {0}
 61c:	03193f01 	tsteq	r9, #1, 30
 620:	3b0b3a0e 	blcc	2cee60 <__bss_end+0x2c5f2c>
 624:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 628:	1113490e 	tstne	r3, lr, lsl #18
 62c:	40061201 	andmi	r1, r6, r1, lsl #4
 630:	19429718 	stmdbne	r2, {r3, r4, r8, r9, sl, ip, pc}^
 634:	00001301 	andeq	r1, r0, r1, lsl #6
 638:	03003422 	movweq	r3, #1058	; 0x422
 63c:	3b0b3a08 	blcc	2cee64 <__bss_end+0x2c5f30>
 640:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 644:	00180213 	andseq	r0, r8, r3, lsl r2
 648:	012e2300 			; <UNDEFINED> instruction: 0x012e2300
 64c:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 650:	0b3b0b3a 	bleq	ec3340 <__bss_end+0xeba40c>
 654:	0e6e0b39 	vmoveq.8	d14[5], r0
 658:	06120111 			; <UNDEFINED> instruction: 0x06120111
 65c:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
 660:	00130119 	andseq	r0, r3, r9, lsl r1
 664:	002e2400 	eoreq	r2, lr, r0, lsl #8
 668:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 66c:	0b3b0b3a 	bleq	ec335c <__bss_end+0xeba428>
 670:	0e6e0b39 	vmoveq.8	d14[5], r0
 674:	06120111 			; <UNDEFINED> instruction: 0x06120111
 678:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
 67c:	25000019 	strcs	r0, [r0, #-25]	; 0xffffffe7
 680:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 684:	0b3a0e03 	bleq	e83e98 <__bss_end+0xe7af64>
 688:	0b390b3b 	bleq	e4337c <__bss_end+0xe3a448>
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
 6b8:	3a0e0300 	bcc	3812c0 <__bss_end+0x37838c>
 6bc:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 6c0:	3c13490b 			; <UNDEFINED> instruction: 0x3c13490b
 6c4:	000a1c19 	andeq	r1, sl, r9, lsl ip
 6c8:	003a0400 	eorseq	r0, sl, r0, lsl #8
 6cc:	0b3b0b3a 	bleq	ec33bc <__bss_end+0xeba488>
 6d0:	13180b39 	tstne	r8, #58368	; 0xe400
 6d4:	01050000 	mrseq	r0, (UNDEF: 5)
 6d8:	01134901 	tsteq	r3, r1, lsl #18
 6dc:	06000013 			; <UNDEFINED> instruction: 0x06000013
 6e0:	13490021 	movtne	r0, #36897	; 0x9021
 6e4:	00000b2f 	andeq	r0, r0, pc, lsr #22
 6e8:	49002607 	stmdbmi	r0, {r0, r1, r2, r9, sl, sp}
 6ec:	08000013 	stmdaeq	r0, {r0, r1, r4}
 6f0:	0b0b0024 	bleq	2c0788 <__bss_end+0x2b7854>
 6f4:	0e030b3e 	vmoveq.16	d3[0], r0
 6f8:	34090000 	strcc	r0, [r9], #-0
 6fc:	00134700 	andseq	r4, r3, r0, lsl #14
 700:	012e0a00 			; <UNDEFINED> instruction: 0x012e0a00
 704:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 708:	0b3b0b3a 	bleq	ec33f8 <__bss_end+0xeba4c4>
 70c:	0e6e0b39 	vmoveq.8	d14[5], r0
 710:	06120111 			; <UNDEFINED> instruction: 0x06120111
 714:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
 718:	00130119 	andseq	r0, r3, r9, lsl r1
 71c:	00050b00 	andeq	r0, r5, r0, lsl #22
 720:	0b3a0803 	bleq	e82734 <__bss_end+0xe79800>
 724:	0b390b3b 	bleq	e43418 <__bss_end+0xe3a4e4>
 728:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 72c:	340c0000 	strcc	r0, [ip], #-0
 730:	3a0e0300 	bcc	381338 <__bss_end+0x378404>
 734:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 738:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 73c:	0d000018 	stceq	0, cr0, [r0, #-96]	; 0xffffffa0
 740:	0111010b 	tsteq	r1, fp, lsl #2
 744:	00000612 	andeq	r0, r0, r2, lsl r6
 748:	0300340e 	movweq	r3, #1038	; 0x40e
 74c:	3b0b3a08 	blcc	2cef74 <__bss_end+0x2c6040>
 750:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 754:	00180213 	andseq	r0, r8, r3, lsl r2
 758:	000f0f00 	andeq	r0, pc, r0, lsl #30
 75c:	13490b0b 	movtne	r0, #39691	; 0x9b0b
 760:	26100000 	ldrcs	r0, [r0], -r0
 764:	11000000 	mrsne	r0, (UNDEF: 0)
 768:	0b0b000f 	bleq	2c07ac <__bss_end+0x2b7878>
 76c:	24120000 	ldrcs	r0, [r2], #-0
 770:	3e0b0b00 	vmlacc.f64	d0, d11, d0
 774:	0008030b 	andeq	r0, r8, fp, lsl #6
 778:	00051300 	andeq	r1, r5, r0, lsl #6
 77c:	0b3a0e03 	bleq	e83f90 <__bss_end+0xe7b05c>
 780:	0b390b3b 	bleq	e43474 <__bss_end+0xe3a540>
 784:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 788:	2e140000 	cdpcs	0, 1, cr0, cr4, cr0, {0}
 78c:	03193f01 	tsteq	r9, #1, 30
 790:	3b0b3a0e 	blcc	2cefd0 <__bss_end+0x2c609c>
 794:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 798:	1113490e 	tstne	r3, lr, lsl #18
 79c:	40061201 	andmi	r1, r6, r1, lsl #4
 7a0:	19429718 	stmdbne	r2, {r3, r4, r8, r9, sl, ip, pc}^
 7a4:	00001301 	andeq	r1, r0, r1, lsl #6
 7a8:	3f012e15 	svccc	0x00012e15
 7ac:	3a0e0319 	bcc	381418 <__bss_end+0x3784e4>
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
  74:	000000b8 	strheq	r0, [r0], -r8
	...
  80:	0000001c 	andeq	r0, r0, ip, lsl r0
  84:	0ae20002 	beq	ff880094 <__bss_end+0xff877160>
  88:	00040000 	andeq	r0, r4, r0
  8c:	00000000 	andeq	r0, r0, r0
  90:	000082e4 	andeq	r8, r0, r4, ror #5
  94:	0000045c 	andeq	r0, r0, ip, asr r4
	...
  a0:	0000001c 	andeq	r0, r0, ip, lsl r0
  a4:	16050002 	strne	r0, [r5], -r2
  a8:	00040000 	andeq	r0, r4, r0
  ac:	00000000 	andeq	r0, r0, r0
  b0:	00008740 	andeq	r8, r0, r0, asr #14
  b4:	000004b8 			; <UNDEFINED> instruction: 0x000004b8
	...

Disassembly of section .debug_str:

00000000 <.debug_str>:
       0:	6573552f 	ldrbvs	r5, [r3, #-1327]!	; 0xfffffad1
       4:	772f7372 			; <UNDEFINED> instruction: 0x772f7372
       8:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
       c:	2f696a72 	svccs	0x00696a72
      10:	6b736544 	blvs	1cd9528 <__bss_end+0x1cd05f4>
      14:	2f706f74 	svccs	0x00706f74
      18:	2f564146 	svccs	0x00564146
      1c:	6176614e 	cmnvs	r6, lr, asr #2
      20:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
      24:	4f2f6963 	svcmi	0x002f6963
      28:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
      2c:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
      30:	6b6c6172 	blvs	1b18600 <__bss_end+0x1b0f6cc>
      34:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
      38:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
      3c:	756f732f 	strbvc	r7, [pc, #-815]!	; fffffd15 <__bss_end+0xffff6de1>
      40:	73656372 	cmnvc	r5, #-939524095	; 0xc8000001
      44:	6573752f 	ldrbvs	r7, [r3, #-1327]!	; 0xfffffad1
      48:	61707372 	cmnvs	r0, r2, ror r3
      4c:	632f6563 			; <UNDEFINED> instruction: 0x632f6563
      50:	2e307472 	mrccs	4, 1, r7, cr0, cr2, {3}
      54:	552f0073 	strpl	r0, [pc, #-115]!	; ffffffe9 <__bss_end+0xffff70b5>
      58:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
      5c:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
      60:	6a726574 	bvs	1c99638 <__bss_end+0x1c90704>
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
      98:	752f7365 	strvc	r7, [pc, #-869]!	; fffffd3b <__bss_end+0xffff6e07>
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
     12c:	6a363731 	bvs	d8ddf8 <__bss_end+0xd84ec4>
     130:	732d667a 			; <UNDEFINED> instruction: 0x732d667a
     134:	616d2d20 	cmnvs	sp, r0, lsr #26
     138:	2d206d72 	stccs	13, cr6, [r0, #-456]!	; 0xfffffe38
     13c:	6372616d 	cmnvs	r2, #1073741851	; 0x4000001b
     140:	72613d68 	rsbvc	r3, r1, #104, 26	; 0x1a00
     144:	7a36766d 	bvc	d9db00 <__bss_end+0xd94bcc>
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
     184:	6a757a61 	bvs	1d5eb10 <__bss_end+0x1d55bdc>
     188:	2f696369 	svccs	0x00696369
     18c:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
     190:	73656d65 	cmnvc	r5, #6464	; 0x1940
     194:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
     198:	6b2d616b 	blvs	b5874c <__bss_end+0xb4f818>
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
     1e4:	2b2b4320 	blcs	ad0e6c <__bss_end+0xac7f38>
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
     260:	2b6b7a36 	blcs	1adeb40 <__bss_end+0x1ad5c0c>
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
     294:	755f6962 	ldrbvc	r6, [pc, #-2402]	; fffff93a <__bss_end+0xffff6a06>
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
     324:	6b736544 	blvs	1cd983c <__bss_end+0x1cd0908>
     328:	2f706f74 	svccs	0x00706f74
     32c:	2f564146 	svccs	0x00564146
     330:	6176614e 	cmnvs	r6, lr, asr #2
     334:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
     338:	4f2f6963 	svcmi	0x002f6963
     33c:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
     340:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
     344:	6b6c6172 	blvs	1b18914 <__bss_end+0x1b0f9e0>
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
     4e8:	555f656e 	ldrbpl	r6, [pc, #-1390]	; ffffff82 <__bss_end+0xffff704e>
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
     538:	6a685045 	bvs	1a14654 <__bss_end+0x1a0b720>
     53c:	32490062 	subcc	r0, r9, #98	; 0x62
     540:	72545f43 	subsvc	r5, r4, #268	; 0x10c
     544:	61736e61 	cmnvs	r3, r1, ror #28
     548:	6f697463 	svcvs	0x00697463
     54c:	614d5f6e 	cmpvs	sp, lr, ror #30
     550:	69535f78 	ldmdbvs	r3, {r3, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     554:	7000657a 	andvc	r6, r0, sl, ror r5
     558:	00766572 	rsbseq	r6, r6, r2, ror r5
     55c:	4b4e5a5f 	blmi	1396ee0 <__bss_end+0x138dfac>
     560:	50433631 	subpl	r3, r3, r1, lsr r6
     564:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     568:	4d5f7373 	ldclmi	3, cr7, [pc, #-460]	; 3a4 <shift+0x3a4>
     56c:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
     570:	39317265 	ldmdbcc	r1!, {r0, r2, r5, r6, r9, ip, sp, lr}
     574:	5f746547 	svcpl	0x00746547
     578:	72727543 	rsbsvc	r7, r2, #281018368	; 0x10c00000
     57c:	5f746e65 	svcpl	0x00746e65
     580:	636f7250 	cmnvs	pc, #80, 4
     584:	45737365 	ldrbmi	r7, [r3, #-869]!	; 0xfffffc9b
     588:	65520076 	ldrbvs	r0, [r2, #-118]	; 0xffffff8a
     58c:	4f5f6461 	svcmi	0x005f6461
     590:	00796c6e 	rsbseq	r6, r9, lr, ror #24
     594:	5f78614d 	svcpl	0x0078614d
     598:	636f7250 	cmnvs	pc, #80, 4
     59c:	5f737365 	svcpl	0x00737365
     5a0:	6e65704f 	cdpvs	0, 6, cr7, cr5, cr15, {2}
     5a4:	465f6465 	ldrbmi	r6, [pc], -r5, ror #8
     5a8:	73656c69 	cmnvc	r5, #26880	; 0x6900
     5ac:	50435400 	subpl	r5, r3, r0, lsl #8
     5b0:	6f435f55 	svcvs	0x00435f55
     5b4:	7865746e 	stmdavc	r5!, {r1, r2, r3, r5, r6, sl, ip, sp, lr}^
     5b8:	5a5f0074 	bpl	17c0790 <__bss_end+0x17b785c>
     5bc:	4336314e 	teqmi	r6, #-2147483629	; 0x80000013
     5c0:	636f7250 	cmnvs	pc, #80, 4
     5c4:	5f737365 	svcpl	0x00737365
     5c8:	616e614d 	cmnvs	lr, sp, asr #2
     5cc:	38726567 	ldmdacc	r2!, {r0, r1, r2, r5, r6, r8, sl, sp, lr}^
     5d0:	65686353 	strbvs	r6, [r8, #-851]!	; 0xfffffcad
     5d4:	656c7564 	strbvs	r7, [ip, #-1380]!	; 0xfffffa9c
     5d8:	4e007645 	cfmadd32mi	mvax2, mvfx7, mvfx0, mvfx5
     5dc:	6669746f 	strbtvs	r7, [r9], -pc, ror #8
     5e0:	6c6c4179 	stfvse	f4, [ip], #-484	; 0xfffffe1c
     5e4:	6f6c4200 	svcvs	0x006c4200
     5e8:	435f6b63 	cmpmi	pc, #101376	; 0x18c00
     5ec:	65727275 	ldrbvs	r7, [r2, #-629]!	; 0xfffffd8b
     5f0:	505f746e 	subspl	r7, pc, lr, ror #8
     5f4:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     5f8:	47007373 	smlsdxmi	r0, r3, r3, r7
     5fc:	505f7465 	subspl	r7, pc, r5, ror #8
     600:	75004449 	strvc	r4, [r0, #-1097]	; 0xfffffbb7
     604:	33746e69 	cmncc	r4, #1680	; 0x690
     608:	00745f32 	rsbseq	r5, r4, r2, lsr pc
     60c:	31435342 	cmpcc	r3, r2, asr #6
     610:	7361425f 	cmnvc	r1, #-268435451	; 0xf0000005
     614:	61570065 	cmpvs	r7, r5, rrx
     618:	4e007469 	cdpmi	4, 0, cr7, cr0, cr9, {3}
     61c:	6b736154 	blvs	1cd8b74 <__bss_end+0x1ccfc40>
     620:	6174535f 	cmnvs	r4, pc, asr r3
     624:	53006574 	movwpl	r6, #1396	; 0x574
     628:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     62c:	5f656c75 	svcpl	0x00656c75
     630:	00464445 	subeq	r4, r6, r5, asr #8
     634:	636f6c42 	cmnvs	pc, #16896	; 0x4200
     638:	0064656b 	rsbeq	r6, r4, fp, ror #10
     63c:	7275436d 	rsbsvc	r4, r5, #-1275068415	; 0xb4000001
     640:	746e6572 	strbtvc	r6, [lr], #-1394	; 0xfffffa8e
     644:	7361545f 	cmnvc	r1, #1593835520	; 0x5f000000
     648:	6f4e5f6b 	svcvs	0x004e5f6b
     64c:	63006564 	movwvs	r6, #1380	; 0x564
     650:	5f726168 	svcpl	0x00726168
     654:	6b636974 	blvs	18dac2c <__bss_end+0x18d1cf8>
     658:	6c65645f 	cfstrdvs	mvd6, [r5], #-380	; 0xfffffe84
     65c:	73007961 	movwvc	r7, #2401	; 0x961
     660:	7065656c 	rsbvc	r6, r5, ip, ror #10
     664:	6d69745f 	cfstrdvs	mvd7, [r9, #-380]!	; 0xfffffe84
     668:	5f007265 	svcpl	0x00007265
     66c:	36314e5a 			; <UNDEFINED> instruction: 0x36314e5a
     670:	6f725043 	svcvs	0x00725043
     674:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     678:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     67c:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     680:	69775339 	ldmdbvs	r7!, {r0, r3, r4, r5, r8, r9, ip, lr}^
     684:	5f686374 	svcpl	0x00686374
     688:	50456f54 	subpl	r6, r5, r4, asr pc
     68c:	50433831 	subpl	r3, r3, r1, lsr r8
     690:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     694:	4c5f7373 	mrrcmi	3, 7, r7, pc, cr3	; <UNPREDICTABLE>
     698:	5f747369 	svcpl	0x00747369
     69c:	65646f4e 	strbvs	r6, [r4, #-3918]!	; 0xfffff0b2
     6a0:	75706300 	ldrbvc	r6, [r0, #-768]!	; 0xfffffd00
     6a4:	6e6f635f 	mcrvs	3, 3, r6, cr15, cr15, {2}
     6a8:	74786574 	ldrbtvc	r6, [r8], #-1396	; 0xfffffa8c
     6ac:	65724300 	ldrbvs	r4, [r2, #-768]!	; 0xfffffd00
     6b0:	5f657461 	svcpl	0x00657461
     6b4:	636f7250 	cmnvs	pc, #80, 4
     6b8:	00737365 	rsbseq	r7, r3, r5, ror #6
     6bc:	6e65704f 	cdpvs	0, 6, cr7, cr5, cr15, {2}
     6c0:	66756200 	ldrbtvs	r6, [r5], -r0, lsl #4
     6c4:	69540066 	ldmdbvs	r4, {r1, r2, r5, r6}^
     6c8:	5f72656d 	svcpl	0x0072656d
     6cc:	65736142 	ldrbvs	r6, [r3, #-322]!	; 0xfffffebe
     6d0:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     6d4:	50433631 	subpl	r3, r3, r1, lsr r6
     6d8:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     6dc:	4d5f7373 	ldclmi	3, cr7, [pc, #-460]	; 518 <shift+0x518>
     6e0:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
     6e4:	34317265 	ldrtcc	r7, [r1], #-613	; 0xfffffd9b
     6e8:	69746f4e 	ldmdbvs	r4!, {r1, r2, r3, r6, r8, r9, sl, fp, sp, lr}^
     6ec:	505f7966 	subspl	r7, pc, r6, ror #18
     6f0:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     6f4:	50457373 	subpl	r7, r5, r3, ror r3
     6f8:	54543231 	ldrbpl	r3, [r4], #-561	; 0xfffffdcf
     6fc:	5f6b7361 	svcpl	0x006b7361
     700:	75727453 	ldrbvc	r7, [r2, #-1107]!	; 0xfffffbad
     704:	47007463 	strmi	r7, [r0, -r3, ror #8]
     708:	535f7465 	cmppl	pc, #1694498816	; 0x65000000
     70c:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     710:	666e495f 			; <UNDEFINED> instruction: 0x666e495f
     714:	4f49006f 	svcmi	0x0049006f
     718:	006c7443 	rsbeq	r7, ip, r3, asr #8
     71c:	76616c73 			; <UNDEFINED> instruction: 0x76616c73
     720:	65520065 	ldrbvs	r0, [r2, #-101]	; 0xffffff9b
     724:	54006461 	strpl	r6, [r0], #-1121	; 0xfffffb9f
     728:	696d7265 	stmdbvs	sp!, {r0, r2, r5, r6, r9, ip, sp, lr}^
     72c:	6574616e 	ldrbvs	r6, [r4, #-366]!	; 0xfffffe92
     730:	746f4e00 	strbtvc	r4, [pc], #-3584	; 738 <shift+0x738>
     734:	5f796669 	svcpl	0x00796669
     738:	636f7250 	cmnvs	pc, #80, 4
     73c:	00737365 	rsbseq	r7, r3, r5, ror #6
     740:	314e5a5f 	cmpcc	lr, pc, asr sl
     744:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     748:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     74c:	614d5f73 	hvcvs	54771	; 0xd5f3
     750:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     754:	45344372 	ldrmi	r4, [r4, #-882]!	; 0xfffffc8e
     758:	6f4e0076 	svcvs	0x004e0076
     75c:	79666974 	stmdbvc	r6!, {r2, r4, r5, r6, r8, fp, sp, lr}^
     760:	78614d00 	stmdavc	r1!, {r8, sl, fp, lr}^
     764:	68746150 	ldmdavs	r4!, {r4, r6, r8, sp, lr}^
     768:	676e654c 	strbvs	r6, [lr, -ip, asr #10]!
     76c:	4d006874 	stcmi	8, cr6, [r0, #-464]	; 0xfffffe30
     770:	53467861 	movtpl	r7, #26721	; 0x6861
     774:	76697244 	strbtvc	r7, [r9], -r4, asr #4
     778:	614e7265 	cmpvs	lr, r5, ror #4
     77c:	654c656d 	strbvs	r6, [ip, #-1389]	; 0xfffffa93
     780:	6874676e 	ldmdavs	r4!, {r1, r2, r3, r5, r6, r8, r9, sl, sp, lr}^
     784:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     788:	50433631 	subpl	r3, r3, r1, lsr r6
     78c:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     790:	4d5f7373 	ldclmi	3, cr7, [pc, #-460]	; 5cc <shift+0x5cc>
     794:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
     798:	31317265 	teqcc	r1, r5, ror #4
     79c:	65686353 	strbvs	r6, [r8, #-851]!	; 0xfffffcad
     7a0:	656c7564 	strbvs	r7, [ip, #-1380]!	; 0xfffffa9c
     7a4:	4552525f 	ldrbmi	r5, [r2, #-607]	; 0xfffffda1
     7a8:	474e0076 	smlsldxmi	r0, lr, r6, r0
     7ac:	535f7465 	cmppl	pc, #1694498816	; 0x65000000
     7b0:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     7b4:	666e495f 			; <UNDEFINED> instruction: 0x666e495f
     7b8:	79545f6f 	ldmdbvc	r4, {r0, r1, r2, r3, r5, r6, r8, r9, sl, fp, ip, lr}^
     7bc:	47006570 	smlsdxmi	r0, r0, r5, r6
     7c0:	5f4f4950 	svcpl	0x004f4950
     7c4:	5f6e6950 	svcpl	0x006e6950
     7c8:	6e756f43 	cdpvs	15, 7, cr6, cr5, cr3, {2}
     7cc:	61740074 	cmnvs	r4, r4, ror r0
     7d0:	62006b73 	andvs	r6, r0, #117760	; 0x1cc00
     7d4:	006c6f6f 	rsbeq	r6, ip, pc, ror #30
     7d8:	314e5a5f 	cmpcc	lr, pc, asr sl
     7dc:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     7e0:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     7e4:	614d5f73 	hvcvs	54771	; 0xd5f3
     7e8:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     7ec:	47383172 			; <UNDEFINED> instruction: 0x47383172
     7f0:	535f7465 	cmppl	pc, #1694498816	; 0x65000000
     7f4:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     7f8:	72656c75 	rsbvc	r6, r5, #29952	; 0x7500
     7fc:	666e495f 			; <UNDEFINED> instruction: 0x666e495f
     800:	3032456f 	eorscc	r4, r2, pc, ror #10
     804:	7465474e 	strbtvc	r4, [r5], #-1870	; 0xfffff8b2
     808:	6863535f 	stmdavs	r3!, {r0, r1, r2, r3, r4, r6, r8, r9, ip, lr}^
     80c:	495f6465 	ldmdbmi	pc, {r0, r2, r5, r6, sl, sp, lr}^	; <UNPREDICTABLE>
     810:	5f6f666e 	svcpl	0x006f666e
     814:	65707954 	ldrbvs	r7, [r0, #-2388]!	; 0xfffff6ac
     818:	54007650 	strpl	r7, [r0], #-1616	; 0xfffff9b0
     81c:	5f474e52 	svcpl	0x00474e52
     820:	65736142 	ldrbvs	r6, [r3, #-322]!	; 0xfffffebe
     824:	66654400 	strbtvs	r4, [r5], -r0, lsl #8
     828:	746c7561 	strbtvc	r7, [ip], #-1377	; 0xfffffa9f
     82c:	6f6c435f 	svcvs	0x006c435f
     830:	525f6b63 	subspl	r6, pc, #101376	; 0x18c00
     834:	00657461 	rsbeq	r7, r5, r1, ror #8
     838:	6f72506d 	svcvs	0x0072506d
     83c:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     840:	73694c5f 	cmnvc	r9, #24320	; 0x5f00
     844:	65485f74 	strbvs	r5, [r8, #-3956]	; 0xfffff08c
     848:	6d006461 	cfstrsvs	mvf6, [r0, #-388]	; 0xfffffe7c
     84c:	65686353 	strbvs	r6, [r8, #-851]!	; 0xfffffcad
     850:	656c7564 	strbvs	r7, [ip, #-1380]!	; 0xfffffa9c
     854:	636e465f 	cmnvs	lr, #99614720	; 0x5f00000
     858:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     85c:	50433631 	subpl	r3, r3, r1, lsr r6
     860:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     864:	4d5f7373 	ldclmi	3, cr7, [pc, #-460]	; 6a0 <shift+0x6a0>
     868:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
     86c:	31327265 	teqcc	r2, r5, ror #4
     870:	636f6c42 	cmnvs	pc, #16896	; 0x4200
     874:	75435f6b 	strbvc	r5, [r3, #-3947]	; 0xfffff095
     878:	6e657272 	mcrvs	2, 3, r7, cr5, cr2, {3}
     87c:	72505f74 	subsvc	r5, r0, #116, 30	; 0x1d0
     880:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     884:	00764573 	rsbseq	r4, r6, r3, ror r5
     888:	6b636f4c 	blvs	18dc5c0 <__bss_end+0x18d368c>
     88c:	6c6e555f 	cfstr64vs	mvdx5, [lr], #-380	; 0xfffffe84
     890:	656b636f 	strbvs	r6, [fp, #-879]!	; 0xfffffc91
     894:	4c6d0064 	stclmi	0, cr0, [sp], #-400	; 0xfffffe70
     898:	5f747361 	svcpl	0x00747361
     89c:	00444950 	subeq	r4, r4, r0, asr r9
     8a0:	74697753 	strbtvc	r7, [r9], #-1875	; 0xfffff8ad
     8a4:	545f6863 	ldrbpl	r6, [pc], #-2147	; 8ac <shift+0x8ac>
     8a8:	6c43006f 	mcrrvs	0, 6, r0, r3, cr15
     8ac:	0065736f 	rsbeq	r7, r5, pc, ror #6
     8b0:	314e5a5f 	cmpcc	lr, pc, asr sl
     8b4:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     8b8:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     8bc:	614d5f73 	hvcvs	54771	; 0xd5f3
     8c0:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     8c4:	53323172 	teqpl	r2, #-2147483620	; 0x8000001c
     8c8:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     8cc:	5f656c75 	svcpl	0x00656c75
     8d0:	45464445 	strbmi	r4, [r6, #-1093]	; 0xfffffbbb
     8d4:	53420076 	movtpl	r0, #8310	; 0x2076
     8d8:	425f3043 	subsmi	r3, pc, #67	; 0x43
     8dc:	00657361 	rsbeq	r7, r5, r1, ror #6
     8e0:	63677261 	cmnvs	r7, #268435462	; 0x10000006
     8e4:	746f6e00 	strbtvc	r6, [pc], #-3584	; 8ec <shift+0x8ec>
     8e8:	65696669 	strbvs	r6, [r9, #-1641]!	; 0xfffff997
     8ec:	65645f64 	strbvs	r5, [r4, #-3940]!	; 0xfffff09c
     8f0:	696c6461 	stmdbvs	ip!, {r0, r5, r6, sl, sp, lr}^
     8f4:	6100656e 	tstvs	r0, lr, ror #10
     8f8:	00766772 	rsbseq	r6, r6, r2, ror r7
     8fc:	314e5a5f 	cmpcc	lr, pc, asr sl
     900:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     904:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     908:	614d5f73 	hvcvs	54771	; 0xd5f3
     90c:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     910:	4e343172 	mrcmi	1, 1, r3, cr4, cr2, {3}
     914:	6669746f 	strbtvs	r7, [r9], -pc, ror #8
     918:	72505f79 	subsvc	r5, r0, #484	; 0x1e4
     91c:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     920:	006a4573 	rsbeq	r4, sl, r3, ror r5
     924:	69466f4e 	stmdbvs	r6, {r1, r2, r3, r6, r8, r9, sl, fp, sp, lr}^
     928:	7973656c 	ldmdbvc	r3!, {r2, r3, r5, r6, r8, sl, sp, lr}^
     92c:	6d657473 	cfstrdvs	mvd7, [r5, #-460]!	; 0xfffffe34
     930:	76697244 	strbtvc	r7, [r9], -r4, asr #4
     934:	44007265 	strmi	r7, [r0], #-613	; 0xfffffd9b
     938:	6c646165 	stfvse	f6, [r4], #-404	; 0xfffffe6c
     93c:	00656e69 	rsbeq	r6, r5, r9, ror #28
     940:	726f6873 	rsbvc	r6, pc, #7536640	; 0x730000
     944:	6e692074 	mcrvs	0, 3, r2, cr9, cr4, {3}
     948:	614d0074 	hvcvs	53252	; 0xd004
     94c:	6c694678 	stclvs	6, cr4, [r9], #-480	; 0xfffffe20
     950:	6d616e65 	stclvs	14, cr6, [r1, #-404]!	; 0xfffffe6c
     954:	6e654c65 	cdpvs	12, 6, cr4, cr5, cr5, {3}
     958:	00687467 	rsbeq	r7, r8, r7, ror #8
     95c:	6f725043 	svcvs	0x00725043
     960:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     964:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     968:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     96c:	62747400 	rsbsvs	r7, r4, #0, 8
     970:	4e003072 	mcrmi	0, 0, r3, cr0, cr2, {3}
     974:	5f495753 	svcpl	0x00495753
     978:	656c6946 	strbvs	r6, [ip, #-2374]!	; 0xfffff6ba
     97c:	74737973 	ldrbtvc	r7, [r3], #-2419	; 0xfffff68d
     980:	535f6d65 	cmppl	pc, #6464	; 0x1940
     984:	69767265 	ldmdbvs	r6!, {r0, r2, r5, r6, r9, ip, sp, lr}^
     988:	2f006563 	svccs	0x00006563
     98c:	72657355 	rsbvc	r7, r5, #1409286145	; 0x54000001
     990:	69772f73 	ldmdbvs	r7!, {r0, r1, r4, r5, r6, r8, r9, sl, fp, sp}^
     994:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
     998:	442f696a 	strtmi	r6, [pc], #-2410	; 9a0 <shift+0x9a0>
     99c:	746b7365 	strbtvc	r7, [fp], #-869	; 0xfffffc9b
     9a0:	462f706f 	strtmi	r7, [pc], -pc, rrx
     9a4:	4e2f5641 	cfmadda32mi	mvax2, mvax5, mvfx15, mvfx1
     9a8:	7a617661 	bvc	185e334 <__bss_end+0x1855400>
     9ac:	63696a75 	cmnvs	r9, #479232	; 0x75000
     9b0:	534f2f69 	movtpl	r2, #65385	; 0xff69
     9b4:	6d65732f 	stclvs	3, cr7, [r5, #-188]!	; 0xffffff44
     9b8:	72747365 	rsbsvc	r7, r4, #-1811939327	; 0x94000001
     9bc:	616b6c61 	cmnvs	fp, r1, ror #24
     9c0:	76696b2d 	strbtvc	r6, [r9], -sp, lsr #22
     9c4:	2f736f2d 	svccs	0x00736f2d
     9c8:	72756f73 	rsbsvc	r6, r5, #460	; 0x1cc
     9cc:	2f736563 	svccs	0x00736563
     9d0:	72657375 	rsbvc	r7, r5, #-738197503	; 0xd4000001
     9d4:	63617073 	cmnvs	r1, #115	; 0x73
     9d8:	6c732f65 	ldclvs	15, cr2, [r3], #-404	; 0xfffffe6c
     9dc:	5f657661 	svcpl	0x00657661
     9e0:	6b736174 	blvs	1cd8fb8 <__bss_end+0x1cd0084>
     9e4:	69616d2f 	stmdbvs	r1!, {r0, r1, r2, r3, r5, r8, sl, fp, sp, lr}^
     9e8:	70632e6e 	rsbvc	r2, r3, lr, ror #28
     9ec:	534e0070 	movtpl	r0, #57456	; 0xe070
     9f0:	505f4957 	subspl	r4, pc, r7, asr r9	; <UNPREDICTABLE>
     9f4:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     9f8:	535f7373 	cmppl	pc, #-872415231	; 0xcc000001
     9fc:	69767265 	ldmdbvs	r6!, {r0, r2, r5, r6, r9, ip, sp, lr}^
     a00:	6f006563 	svcvs	0x00006563
     a04:	656e6570 	strbvs	r6, [lr, #-1392]!	; 0xfffffa90
     a08:	69665f64 	stmdbvs	r6!, {r2, r5, r6, r8, r9, sl, fp, ip, lr}^
     a0c:	0073656c 	rsbseq	r6, r3, ip, ror #10
     a10:	6c656959 			; <UNDEFINED> instruction: 0x6c656959
     a14:	6e490064 	cdpvs	0, 4, cr0, cr9, cr4, {3}
     a18:	69666564 	stmdbvs	r6!, {r2, r5, r6, r8, sl, sp, lr}^
     a1c:	6574696e 	ldrbvs	r6, [r4, #-2414]!	; 0xfffff692
     a20:	74654700 	strbtvc	r4, [r5], #-1792	; 0xfffff900
     a24:	6f72505f 	svcvs	0x0072505f
     a28:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     a2c:	5f79425f 	svcpl	0x0079425f
     a30:	00444950 	subeq	r4, r4, r0, asr r9
     a34:	69726550 	ldmdbvs	r2!, {r4, r6, r8, sl, sp, lr}^
     a38:	72656870 	rsbvc	r6, r5, #112, 16	; 0x700000
     a3c:	425f6c61 	subsmi	r6, pc, #24832	; 0x6100
     a40:	00657361 	rsbeq	r7, r5, r1, ror #6
     a44:	676e6f6c 	strbvs	r6, [lr, -ip, ror #30]!
     a48:	736e7520 	cmnvc	lr, #32, 10	; 0x8000000
     a4c:	656e6769 	strbvs	r6, [lr, #-1897]!	; 0xfffff897
     a50:	6e692064 	cdpvs	0, 6, cr2, cr9, cr4, {3}
     a54:	6e490074 	mcrvs	0, 2, r0, cr9, cr4, {3}
     a58:	696c6176 	stmdbvs	ip!, {r1, r2, r4, r5, r6, r8, sp, lr}^
     a5c:	69505f64 	ldmdbvs	r0, {r2, r5, r6, r8, r9, sl, fp, ip, lr}^
     a60:	6f4c006e 	svcvs	0x004c006e
     a64:	4c5f6b63 	mrrcmi	11, 6, r6, pc, cr3	; <UNPREDICTABLE>
     a68:	656b636f 	strbvs	r6, [fp, #-879]!	; 0xfffffc91
     a6c:	5a5f0064 	bpl	17c0c04 <__bss_end+0x17b7cd0>
     a70:	4336314e 	teqmi	r6, #-2147483629	; 0x80000013
     a74:	636f7250 	cmnvs	pc, #80, 4
     a78:	5f737365 	svcpl	0x00737365
     a7c:	616e614d 	cmnvs	lr, sp, asr #2
     a80:	31726567 	cmncc	r2, r7, ror #10
     a84:	6e614838 	mcrvs	8, 3, r4, cr1, cr8, {1}
     a88:	5f656c64 	svcpl	0x00656c64
     a8c:	636f7250 	cmnvs	pc, #80, 4
     a90:	5f737365 	svcpl	0x00737365
     a94:	45495753 	strbmi	r5, [r9, #-1875]	; 0xfffff8ad
     a98:	534e3032 	movtpl	r3, #57394	; 0xe032
     a9c:	505f4957 	subspl	r4, pc, r7, asr r9	; <UNPREDICTABLE>
     aa0:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     aa4:	535f7373 	cmppl	pc, #-872415231	; 0xcc000001
     aa8:	69767265 	ldmdbvs	r6!, {r0, r2, r5, r6, r9, ip, sp, lr}^
     aac:	6a6a6563 	bvs	1a9a040 <__bss_end+0x1a9110c>
     ab0:	3131526a 	teqcc	r1, sl, ror #4
     ab4:	49575354 	ldmdbmi	r7, {r2, r4, r6, r8, r9, ip, lr}^
     ab8:	7365525f 	cmnvc	r5, #-268435451	; 0xf0000005
     abc:	00746c75 	rsbseq	r6, r4, r5, ror ip
     ac0:	65686373 	strbvs	r6, [r8, #-883]!	; 0xfffffc8d
     ac4:	6f635f64 	svcvs	0x00635f64
     ac8:	65746e75 	ldrbvs	r6, [r4, #-3701]!	; 0xfffff18b
     acc:	6e750072 	mrcvs	0, 3, r0, cr5, cr2, {3}
     ad0:	6e676973 			; <UNDEFINED> instruction: 0x6e676973
     ad4:	63206465 			; <UNDEFINED> instruction: 0x63206465
     ad8:	00726168 	rsbseq	r6, r2, r8, ror #2
     adc:	5f433249 	svcpl	0x00433249
     ae0:	56414c53 			; <UNDEFINED> instruction: 0x56414c53
     ae4:	61425f45 	cmpvs	r2, r5, asr #30
     ae8:	49006573 	stmdbmi	r0, {r0, r1, r4, r5, r6, r8, sl, sp, lr}
     aec:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
     af0:	74707572 	ldrbtvc	r7, [r0], #-1394	; 0xfffffa8e
     af4:	656c6261 	strbvs	r6, [ip, #-609]!	; 0xfffffd9f
     af8:	656c535f 	strbvs	r5, [ip, #-863]!	; 0xfffffca1
     afc:	53007065 	movwpl	r7, #101	; 0x65
     b00:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     b04:	5f656c75 	svcpl	0x00656c75
     b08:	41005252 	tstmi	r0, r2, asr r2
     b0c:	425f5855 	subsmi	r5, pc, #5570560	; 0x550000
     b10:	00657361 	rsbeq	r7, r5, r1, ror #6
     b14:	32435342 	subcc	r5, r3, #134217729	; 0x8000001
     b18:	7361425f 	cmnvc	r1, #-268435451	; 0xf0000005
     b1c:	74730065 	ldrbtvc	r0, [r3], #-101	; 0xffffff9b
     b20:	00657461 	rsbeq	r7, r5, r1, ror #8
     b24:	74697257 	strbtvc	r7, [r9], #-599	; 0xfffffda9
     b28:	6e4f5f65 	cdpvs	15, 4, cr5, cr15, cr5, {3}
     b2c:	5300796c 	movwpl	r7, #2412	; 0x96c
     b30:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     b34:	00656c75 	rsbeq	r6, r5, r5, ror ip
     b38:	6b636954 	blvs	18db090 <__bss_end+0x18d215c>
     b3c:	756f435f 	strbvc	r4, [pc, #-863]!	; 7e5 <shift+0x7e5>
     b40:	5f00746e 	svcpl	0x0000746e
     b44:	36314e5a 			; <UNDEFINED> instruction: 0x36314e5a
     b48:	6f725043 	svcvs	0x00725043
     b4c:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     b50:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     b54:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     b58:	6e553831 	mrcvs	8, 2, r3, cr5, cr1, {1}
     b5c:	5f70616d 	svcpl	0x0070616d
     b60:	656c6946 	strbvs	r6, [ip, #-2374]!	; 0xfffff6ba
     b64:	7275435f 	rsbsvc	r4, r5, #2080374785	; 0x7c000001
     b68:	746e6572 	strbtvc	r6, [lr], #-1394	; 0xfffffa8e
     b6c:	48006a45 	stmdami	r0, {r0, r2, r6, r9, fp, sp, lr}
     b70:	6c646e61 	stclvs	14, cr6, [r4], #-388	; 0xfffffe7c
     b74:	69465f65 	stmdbvs	r6, {r0, r2, r5, r6, r8, r9, sl, fp, ip, lr}^
     b78:	7973656c 	ldmdbvc	r3!, {r2, r3, r5, r6, r8, sl, sp, lr}^
     b7c:	6d657473 	cfstrdvs	mvd7, [r5, #-460]!	; 0xfffffe34
     b80:	4957535f 	ldmdbmi	r7, {r0, r1, r2, r3, r4, r6, r8, r9, ip, lr}^
     b84:	6f687300 	svcvs	0x00687300
     b88:	75207472 	strvc	r7, [r0, #-1138]!	; 0xfffffb8e
     b8c:	6769736e 	strbvs	r7, [r9, -lr, ror #6]!
     b90:	2064656e 	rsbcs	r6, r4, lr, ror #10
     b94:	00746e69 	rsbseq	r6, r4, r9, ror #28
     b98:	6e69616d 	powvsez	f6, f1, #5.0
     b9c:	746e4900 	strbtvc	r4, [lr], #-2304	; 0xfffff700
     ba0:	75727265 	ldrbvc	r7, [r2, #-613]!	; 0xfffffd9b
     ba4:	435f7470 	cmpmi	pc, #112, 8	; 0x70000000
     ba8:	72746e6f 	rsbsvc	r6, r4, #1776	; 0x6f0
     bac:	656c6c6f 	strbvs	r6, [ip, #-3183]!	; 0xfffff391
     bb0:	61425f72 	hvcvs	9714	; 0x25f2
     bb4:	52006573 	andpl	r6, r0, #482344960	; 0x1cc00000
     bb8:	5f646165 	svcpl	0x00646165
     bbc:	74697257 	strbtvc	r7, [r9], #-599	; 0xfffffda9
     bc0:	63410065 	movtvs	r0, #4197	; 0x1065
     bc4:	65766974 	ldrbvs	r6, [r6, #-2420]!	; 0xfffff68c
     bc8:	6f72505f 	svcvs	0x0072505f
     bcc:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     bd0:	756f435f 	strbvc	r4, [pc, #-863]!	; 879 <shift+0x879>
     bd4:	7300746e 	movwvc	r7, #1134	; 0x46e
     bd8:	6f626d79 	svcvs	0x00626d79
     bdc:	69745f6c 	ldmdbvs	r4!, {r2, r3, r5, r6, r8, r9, sl, fp, ip, lr}^
     be0:	645f6b63 	ldrbvs	r6, [pc], #-2915	; be8 <shift+0xbe8>
     be4:	79616c65 	stmdbvc	r1!, {r0, r2, r5, r6, sl, fp, sp, lr}^
     be8:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     bec:	50433631 	subpl	r3, r3, r1, lsr r6
     bf0:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     bf4:	4d5f7373 	ldclmi	3, cr7, [pc, #-460]	; a30 <shift+0xa30>
     bf8:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
     bfc:	31327265 	teqcc	r2, r5, ror #4
     c00:	646e6148 	strbtvs	r6, [lr], #-328	; 0xfffffeb8
     c04:	465f656c 	ldrbmi	r6, [pc], -ip, ror #10
     c08:	73656c69 	cmnvc	r5, #26880	; 0x6900
     c0c:	65747379 	ldrbvs	r7, [r4, #-889]!	; 0xfffffc87
     c10:	57535f6d 	ldrbpl	r5, [r3, -sp, ror #30]
     c14:	33324549 	teqcc	r2, #306184192	; 0x12400000
     c18:	4957534e 	ldmdbmi	r7, {r1, r2, r3, r6, r8, r9, ip, lr}^
     c1c:	6c69465f 	stclvs	6, cr4, [r9], #-380	; 0xfffffe84
     c20:	73797365 	cmnvc	r9, #-1811939327	; 0x94000001
     c24:	5f6d6574 	svcpl	0x006d6574
     c28:	76726553 			; <UNDEFINED> instruction: 0x76726553
     c2c:	6a656369 	bvs	19599d8 <__bss_end+0x1950aa4>
     c30:	31526a6a 	cmpcc	r2, sl, ror #20
     c34:	57535431 	smmlarpl	r3, r1, r4, r5
     c38:	65525f49 	ldrbvs	r5, [r2, #-3913]	; 0xfffff0b7
     c3c:	746c7573 	strbtvc	r7, [ip], #-1395	; 0xfffffa8d
     c40:	73552f00 	cmpvc	r5, #0, 30
     c44:	2f737265 	svccs	0x00737265
     c48:	746e6977 	strbtvc	r6, [lr], #-2423	; 0xfffff689
     c4c:	696a7265 	stmdbvs	sl!, {r0, r2, r5, r6, r9, ip, sp, lr}^
     c50:	7365442f 	cmnvc	r5, #788529152	; 0x2f000000
     c54:	706f746b 	rsbvc	r7, pc, fp, ror #8
     c58:	5641462f 	strbpl	r4, [r1], -pc, lsr #12
     c5c:	76614e2f 	strbtvc	r4, [r1], -pc, lsr #28
     c60:	6a757a61 	bvs	1d5f5ec <__bss_end+0x1d566b8>
     c64:	2f696369 	svccs	0x00696369
     c68:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
     c6c:	73656d65 	cmnvc	r5, #6464	; 0x1940
     c70:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
     c74:	6b2d616b 	blvs	b59228 <__bss_end+0xb502f4>
     c78:	6f2d7669 	svcvs	0x002d7669
     c7c:	6f732f73 	svcvs	0x00732f73
     c80:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
     c84:	75622f73 	strbvc	r2, [r2, #-3955]!	; 0xfffff08d
     c88:	00646c69 	rsbeq	r6, r4, r9, ror #24
     c8c:	736f6c63 	cmnvc	pc, #25344	; 0x6300
     c90:	65530065 	ldrbvs	r0, [r3, #-101]	; 0xffffff9b
     c94:	65525f74 	ldrbvs	r5, [r2, #-3956]	; 0xfffff08c
     c98:	6974616c 	ldmdbvs	r4!, {r2, r3, r5, r6, r8, sp, lr}^
     c9c:	72006576 	andvc	r6, r0, #494927872	; 0x1d800000
     ca0:	61767465 	cmnvs	r6, r5, ror #8
     ca4:	636e006c 	cmnvs	lr, #108	; 0x6c
     ca8:	70007275 	andvc	r7, r0, r5, ror r2
     cac:	00657069 	rsbeq	r7, r5, r9, rrx
     cb0:	756e6472 	strbvc	r6, [lr, #-1138]!	; 0xfffffb8e
     cb4:	5a5f006d 	bpl	17c0e70 <__bss_end+0x17b7f3c>
     cb8:	63733131 	cmnvs	r3, #1073741836	; 0x4000000c
     cbc:	5f646568 	svcpl	0x00646568
     cc0:	6c656979 			; <UNDEFINED> instruction: 0x6c656979
     cc4:	5f007664 	svcpl	0x00007664
     cc8:	7337315a 	teqvc	r7, #-2147483626	; 0x80000016
     ccc:	745f7465 	ldrbvc	r7, [pc], #-1125	; cd4 <shift+0xcd4>
     cd0:	5f6b7361 	svcpl	0x006b7361
     cd4:	64616564 	strbtvs	r6, [r1], #-1380	; 0xfffffa9c
     cd8:	656e696c 	strbvs	r6, [lr, #-2412]!	; 0xfffff694
     cdc:	6177006a 	cmnvs	r7, sl, rrx
     ce0:	5f007469 	svcpl	0x00007469
     ce4:	6f6e365a 	svcvs	0x006e365a
     ce8:	79666974 	stmdbvc	r6!, {r2, r4, r5, r6, r8, fp, sp, lr}^
     cec:	46006a6a 	strmi	r6, [r0], -sl, ror #20
     cf0:	006c6961 	rsbeq	r6, ip, r1, ror #18
     cf4:	74697865 	strbtvc	r7, [r9], #-2149	; 0xfffff79b
     cf8:	65646f63 	strbvs	r6, [r4, #-3939]!	; 0xfffff09d
     cfc:	68637300 	stmdavs	r3!, {r8, r9, ip, sp, lr}^
     d00:	795f6465 	ldmdbvc	pc, {r0, r2, r5, r6, sl, sp, lr}^	; <UNPREDICTABLE>
     d04:	646c6569 	strbtvs	r6, [ip], #-1385	; 0xfffffa97
     d08:	63697400 	cmnvs	r9, #0, 8
     d0c:	6f635f6b 	svcvs	0x00635f6b
     d10:	5f746e75 	svcpl	0x00746e75
     d14:	75716572 	ldrbvc	r6, [r1, #-1394]!	; 0xfffffa8e
     d18:	64657269 	strbtvs	r7, [r5], #-617	; 0xfffffd97
     d1c:	325a5f00 	subscc	r5, sl, #0, 30
     d20:	74656734 	strbtvc	r6, [r5], #-1844	; 0xfffff8cc
     d24:	7463615f 	strbtvc	r6, [r3], #-351	; 0xfffffea1
     d28:	5f657669 	svcpl	0x00657669
     d2c:	636f7270 	cmnvs	pc, #112, 4
     d30:	5f737365 	svcpl	0x00737365
     d34:	6e756f63 	cdpvs	15, 7, cr6, cr5, cr3, {3}
     d38:	50007674 	andpl	r7, r0, r4, ror r6
     d3c:	5f657069 	svcpl	0x00657069
     d40:	656c6946 	strbvs	r6, [ip, #-2374]!	; 0xfffff6ba
     d44:	6572505f 	ldrbvs	r5, [r2, #-95]!	; 0xffffffa1
     d48:	00786966 	rsbseq	r6, r8, r6, ror #18
     d4c:	5f746553 	svcpl	0x00746553
     d50:	61726150 	cmnvs	r2, r0, asr r1
     d54:	5f00736d 	svcpl	0x0000736d
     d58:	6734315a 			; <UNDEFINED> instruction: 0x6734315a
     d5c:	745f7465 	ldrbvc	r7, [pc], #-1125	; d64 <shift+0xd64>
     d60:	5f6b6369 	svcpl	0x006b6369
     d64:	6e756f63 	cdpvs	15, 7, cr6, cr5, cr3, {3}
     d68:	73007674 	movwvc	r7, #1652	; 0x674
     d6c:	7065656c 	rsbvc	r6, r5, ip, ror #10
     d70:	73694400 	cmnvc	r9, #0, 8
     d74:	656c6261 	strbvs	r6, [ip, #-609]!	; 0xfffffd9f
     d78:	6576455f 	ldrbvs	r4, [r6, #-1375]!	; 0xfffffaa1
     d7c:	445f746e 	ldrbmi	r7, [pc], #-1134	; d84 <shift+0xd84>
     d80:	63657465 	cmnvs	r5, #1694498816	; 0x65000000
     d84:	6e6f6974 			; <UNDEFINED> instruction: 0x6e6f6974
     d88:	395a5f00 	ldmdbcc	sl, {r8, r9, sl, fp, ip, lr}^
     d8c:	6d726574 	cfldr64vs	mvdx6, [r2, #-464]!	; 0xfffffe30
     d90:	74616e69 	strbtvc	r6, [r1], #-3689	; 0xfffff197
     d94:	6f006965 	svcvs	0x00006965
     d98:	61726570 	cmnvs	r2, r0, ror r5
     d9c:	6e6f6974 			; <UNDEFINED> instruction: 0x6e6f6974
     da0:	355a5f00 	ldrbcc	r5, [sl, #-3840]	; 0xfffff100
     da4:	736f6c63 	cmnvc	pc, #25344	; 0x6300
     da8:	5f006a65 	svcpl	0x00006a65
     dac:	6567365a 	strbvs	r3, [r7, #-1626]!	; 0xfffff9a6
     db0:	64697074 	strbtvs	r7, [r9], #-116	; 0xffffff8c
     db4:	6e660076 	mcrvs	0, 3, r0, cr6, cr6, {3}
     db8:	00656d61 	rsbeq	r6, r5, r1, ror #26
     dbc:	74697277 	strbtvc	r7, [r9], #-631	; 0xfffffd89
     dc0:	69740065 	ldmdbvs	r4!, {r0, r2, r5, r6}^
     dc4:	00736b63 	rsbseq	r6, r3, r3, ror #22
     dc8:	6e65706f 	cdpvs	0, 6, cr7, cr5, cr15, {3}
     dcc:	345a5f00 	ldrbcc	r5, [sl], #-3840	; 0xfffff100
     dd0:	65706970 	ldrbvs	r6, [r0, #-2416]!	; 0xfffff690
     dd4:	6a634b50 	bvs	18d3b1c <__bss_end+0x18cabe8>
     dd8:	65444e00 	strbvs	r4, [r4, #-3584]	; 0xfffff200
     ddc:	696c6461 	stmdbvs	ip!, {r0, r5, r6, sl, sp, lr}^
     de0:	535f656e 	cmppl	pc, #461373440	; 0x1b800000
     de4:	65736275 	ldrbvs	r6, [r3, #-629]!	; 0xfffffd8b
     de8:	63697672 	cmnvs	r9, #119537664	; 0x7200000
     dec:	65670065 	strbvs	r0, [r7, #-101]!	; 0xffffff9b
     df0:	69745f74 	ldmdbvs	r4!, {r2, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     df4:	635f6b63 	cmpvs	pc, #101376	; 0x18c00
     df8:	746e756f 	strbtvc	r7, [lr], #-1391	; 0xfffffa91
     dfc:	72617000 	rsbvc	r7, r1, #0
     e00:	5f006d61 	svcpl	0x00006d61
     e04:	7277355a 	rsbsvc	r3, r7, #377487360	; 0x16800000
     e08:	6a657469 	bvs	195dfb4 <__bss_end+0x1955080>
     e0c:	6a634b50 	bvs	18d3b54 <__bss_end+0x18cac20>
     e10:	74656700 	strbtvc	r6, [r5], #-1792	; 0xfffff900
     e14:	7361745f 	cmnvc	r1, #1593835520	; 0x5f000000
     e18:	69745f6b 	ldmdbvs	r4!, {r0, r1, r3, r5, r6, r8, r9, sl, fp, ip, lr}^
     e1c:	5f736b63 	svcpl	0x00736b63
     e20:	645f6f74 	ldrbvs	r6, [pc], #-3956	; e28 <shift+0xe28>
     e24:	6c646165 	stfvse	f6, [r4], #-404	; 0xfffffe6c
     e28:	00656e69 	rsbeq	r6, r5, r9, ror #28
     e2c:	5f667562 	svcpl	0x00667562
     e30:	657a6973 	ldrbvs	r6, [sl, #-2419]!	; 0xfffff68d
     e34:	74657300 	strbtvc	r7, [r5], #-768	; 0xfffffd00
     e38:	7361745f 	cmnvc	r1, #1593835520	; 0x5f000000
     e3c:	65645f6b 	strbvs	r5, [r4, #-3947]!	; 0xfffff095
     e40:	696c6461 	stmdbvs	ip!, {r0, r5, r6, sl, sp, lr}^
     e44:	4700656e 	strmi	r6, [r0, -lr, ror #10]
     e48:	505f7465 	subspl	r7, pc, r5, ror #8
     e4c:	6d617261 	sfmvs	f7, 2, [r1, #-388]!	; 0xfffffe7c
     e50:	552f0073 	strpl	r0, [pc, #-115]!	; de5 <shift+0xde5>
     e54:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
     e58:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
     e5c:	6a726574 	bvs	1c9a434 <__bss_end+0x1c91500>
     e60:	65442f69 	strbvs	r2, [r4, #-3945]	; 0xfffff097
     e64:	6f746b73 	svcvs	0x00746b73
     e68:	41462f70 	hvcmi	25328	; 0x62f0
     e6c:	614e2f56 	cmpvs	lr, r6, asr pc
     e70:	757a6176 	ldrbvc	r6, [sl, #-374]!	; 0xfffffe8a
     e74:	6963696a 	stmdbvs	r3!, {r1, r3, r5, r6, r8, fp, sp, lr}^
     e78:	2f534f2f 	svccs	0x00534f2f
     e7c:	656d6573 	strbvs	r6, [sp, #-1395]!	; 0xfffffa8d
     e80:	61727473 	cmnvs	r2, r3, ror r4
     e84:	2d616b6c 	vstmdbcs	r1!, {d22-<overflow reg d75>}
     e88:	2d76696b 			; <UNDEFINED> instruction: 0x2d76696b
     e8c:	732f736f 			; <UNDEFINED> instruction: 0x732f736f
     e90:	6372756f 	cmnvs	r2, #465567744	; 0x1bc00000
     e94:	732f7365 			; <UNDEFINED> instruction: 0x732f7365
     e98:	696c6474 	stmdbvs	ip!, {r2, r4, r5, r6, sl, sp, lr}^
     e9c:	72732f62 	rsbsvc	r2, r3, #392	; 0x188
     ea0:	74732f63 	ldrbtvc	r2, [r3], #-3939	; 0xfffff09d
     ea4:	6c696664 	stclvs	6, cr6, [r9], #-400	; 0xfffffe70
     ea8:	70632e65 	rsbvc	r2, r3, r5, ror #28
     eac:	5a5f0070 	bpl	17c1074 <__bss_end+0x17b8140>
     eb0:	656c7335 	strbvs	r7, [ip, #-821]!	; 0xfffffccb
     eb4:	6a6a7065 	bvs	1a9d050 <__bss_end+0x1a9411c>
     eb8:	6c696600 	stclvs	6, cr6, [r9], #-0
     ebc:	65470065 	strbvs	r0, [r7, #-101]	; 0xffffff9b
     ec0:	65525f74 	ldrbvs	r5, [r2, #-3956]	; 0xfffff08c
     ec4:	6e69616d 	powvsez	f6, f1, #5.0
     ec8:	00676e69 	rsbeq	r6, r7, r9, ror #28
     ecc:	62616e45 	rsbvs	r6, r1, #1104	; 0x450
     ed0:	455f656c 	ldrbmi	r6, [pc, #-1388]	; 96c <shift+0x96c>
     ed4:	746e6576 	strbtvc	r6, [lr], #-1398	; 0xfffffa8a
     ed8:	7465445f 	strbtvc	r4, [r5], #-1119	; 0xfffffba1
     edc:	69746365 	ldmdbvs	r4!, {r0, r2, r5, r6, r8, r9, sp, lr}^
     ee0:	5f006e6f 	svcpl	0x00006e6f
     ee4:	6736325a 			; <UNDEFINED> instruction: 0x6736325a
     ee8:	745f7465 	ldrbvc	r7, [pc], #-1125	; ef0 <shift+0xef0>
     eec:	5f6b7361 	svcpl	0x006b7361
     ef0:	6b636974 	blvs	18db4c8 <__bss_end+0x18d2594>
     ef4:	6f745f73 	svcvs	0x00745f73
     ef8:	6165645f 	cmnvs	r5, pc, asr r4
     efc:	6e696c64 	cdpvs	12, 6, cr6, cr9, cr4, {3}
     f00:	4e007665 	cfmadd32mi	mvax3, mvfx7, mvfx0, mvfx5
     f04:	5f495753 	svcpl	0x00495753
     f08:	75736552 	ldrbvc	r6, [r3, #-1362]!	; 0xfffffaae
     f0c:	435f746c 	cmpmi	pc, #108, 8	; 0x6c000000
     f10:	0065646f 	rsbeq	r6, r5, pc, ror #8
     f14:	756e7277 	strbvc	r7, [lr, #-631]!	; 0xfffffd89
     f18:	5a5f006d 	bpl	17c10d4 <__bss_end+0x17b81a0>
     f1c:	69617734 	stmdbvs	r1!, {r2, r4, r5, r8, r9, sl, ip, sp, lr}^
     f20:	6a6a6a74 	bvs	1a9b8f8 <__bss_end+0x1a929c4>
     f24:	355a5f00 	ldrbcc	r5, [sl, #-3840]	; 0xfffff100
     f28:	74636f69 	strbtvc	r6, [r3], #-3945	; 0xfffff097
     f2c:	36316a6c 	ldrtcc	r6, [r1], -ip, ror #20
     f30:	434f494e 	movtmi	r4, #63822	; 0xf94e
     f34:	4f5f6c74 	svcmi	0x005f6c74
     f38:	61726570 	cmnvs	r2, r0, ror r5
     f3c:	6e6f6974 			; <UNDEFINED> instruction: 0x6e6f6974
     f40:	69007650 	stmdbvs	r0, {r4, r6, r9, sl, ip, sp, lr}
     f44:	6c74636f 	ldclvs	3, cr6, [r4], #-444	; 0xfffffe44
     f48:	74657200 	strbtvc	r7, [r5], #-512	; 0xfffffe00
     f4c:	00746e63 	rsbseq	r6, r4, r3, ror #28
     f50:	69746f6e 	ldmdbvs	r4!, {r1, r2, r3, r5, r6, r8, r9, sl, fp, sp, lr}^
     f54:	74007966 	strvc	r7, [r0], #-2406	; 0xfffff69a
     f58:	696d7265 	stmdbvs	sp!, {r0, r2, r5, r6, r9, ip, sp, lr}^
     f5c:	6574616e 	ldrbvs	r6, [r4, #-366]!	; 0xfffffe92
     f60:	646f6d00 	strbtvs	r6, [pc], #-3328	; f68 <shift+0xf68>
     f64:	75620065 	strbvc	r0, [r2, #-101]!	; 0xffffff9b
     f68:	72656666 	rsbvc	r6, r5, #106954752	; 0x6600000
     f6c:	345a5f00 	ldrbcc	r5, [sl], #-3840	; 0xfffff100
     f70:	64616572 	strbtvs	r6, [r1], #-1394	; 0xfffffa8e
     f74:	6a63506a 	bvs	18d5124 <__bss_end+0x18cc1f0>
     f78:	554e4700 	strbpl	r4, [lr, #-1792]	; 0xfffff900
     f7c:	2b2b4320 	blcs	ad1c04 <__bss_end+0xac8cd0>
     f80:	31203431 			; <UNDEFINED> instruction: 0x31203431
     f84:	2e332e30 	mrccs	14, 1, r2, cr3, cr0, {1}
     f88:	30322031 	eorscc	r2, r2, r1, lsr r0
     f8c:	38303132 	ldmdacc	r0!, {r1, r4, r5, r8, ip, sp}
     f90:	28203432 	stmdacs	r0!, {r1, r4, r5, sl, ip, sp}
     f94:	656c6572 	strbvs	r6, [ip, #-1394]!	; 0xfffffa8e
     f98:	29657361 	stmdbcs	r5!, {r0, r5, r6, r8, r9, ip, sp, lr}^
     f9c:	666d2d20 	strbtvs	r2, [sp], -r0, lsr #26
     fa0:	74616f6c 	strbtvc	r6, [r1], #-3948	; 0xfffff094
     fa4:	6962612d 	stmdbvs	r2!, {r0, r2, r3, r5, r8, sp, lr}^
     fa8:	7261683d 	rsbvc	r6, r1, #3997696	; 0x3d0000
     fac:	6d2d2064 	stcvs	0, cr2, [sp, #-400]!	; 0xfffffe70
     fb0:	3d757066 	ldclcc	0, cr7, [r5, #-408]!	; 0xfffffe68
     fb4:	20706676 	rsbscs	r6, r0, r6, ror r6
     fb8:	6c666d2d 	stclvs	13, cr6, [r6], #-180	; 0xffffff4c
     fbc:	2d74616f 	ldfcse	f6, [r4, #-444]!	; 0xfffffe44
     fc0:	3d696261 	sfmcc	f6, 2, [r9, #-388]!	; 0xfffffe7c
     fc4:	64726168 	ldrbtvs	r6, [r2], #-360	; 0xfffffe98
     fc8:	666d2d20 	strbtvs	r2, [sp], -r0, lsr #26
     fcc:	763d7570 			; <UNDEFINED> instruction: 0x763d7570
     fd0:	2d207066 	stccs	0, cr7, [r0, #-408]!	; 0xfffffe68
     fd4:	6e75746d 	cdpvs	4, 7, cr7, cr5, cr13, {3}
     fd8:	72613d65 	rsbvc	r3, r1, #6464	; 0x1940
     fdc:	3731316d 	ldrcc	r3, [r1, -sp, ror #2]!
     fe0:	667a6a36 			; <UNDEFINED> instruction: 0x667a6a36
     fe4:	2d20732d 	stccs	3, cr7, [r0, #-180]!	; 0xffffff4c
     fe8:	6d72616d 	ldfvse	f6, [r2, #-436]!	; 0xfffffe4c
     fec:	616d2d20 	cmnvs	sp, r0, lsr #26
     ff0:	3d686372 	stclcc	3, cr6, [r8, #-456]!	; 0xfffffe38
     ff4:	766d7261 	strbtvc	r7, [sp], -r1, ror #4
     ff8:	2b6b7a36 	blcs	1adf8d8 <__bss_end+0x1ad69a4>
     ffc:	2d207066 	stccs	0, cr7, [r0, #-408]!	; 0xfffffe68
    1000:	672d2067 	strvs	r2, [sp, -r7, rrx]!
    1004:	20672d20 	rsbcs	r2, r7, r0, lsr #26
    1008:	20304f2d 	eorscs	r4, r0, sp, lsr #30
    100c:	20304f2d 	eorscs	r4, r0, sp, lsr #30
    1010:	6f6e662d 	svcvs	0x006e662d
    1014:	6378652d 	cmnvs	r8, #188743680	; 0xb400000
    1018:	69747065 	ldmdbvs	r4!, {r0, r2, r5, r6, ip, sp, lr}^
    101c:	20736e6f 	rsbscs	r6, r3, pc, ror #28
    1020:	6f6e662d 	svcvs	0x006e662d
    1024:	7474722d 	ldrbtvc	r7, [r4], #-557	; 0xfffffdd3
    1028:	494e0069 	stmdbmi	lr, {r0, r3, r5, r6}^
    102c:	6c74434f 	ldclvs	3, cr4, [r4], #-316	; 0xfffffec4
    1030:	65704f5f 	ldrbvs	r4, [r0, #-3935]!	; 0xfffff0a1
    1034:	69746172 	ldmdbvs	r4!, {r1, r4, r5, r6, r8, sp, lr}^
    1038:	72006e6f 	andvc	r6, r0, #1776	; 0x6f0
    103c:	6f637465 	svcvs	0x00637465
    1040:	67006564 	strvs	r6, [r0, -r4, ror #10]
    1044:	615f7465 	cmpvs	pc, r5, ror #8
    1048:	76697463 	strbtvc	r7, [r9], -r3, ror #8
    104c:	72705f65 	rsbsvc	r5, r0, #404	; 0x194
    1050:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
    1054:	6f635f73 	svcvs	0x00635f73
    1058:	00746e75 	rsbseq	r6, r4, r5, ror lr
    105c:	656c6966 	strbvs	r6, [ip, #-2406]!	; 0xfffff69a
    1060:	656d616e 	strbvs	r6, [sp, #-366]!	; 0xfffffe92
    1064:	61657200 	cmnvs	r5, r0, lsl #4
    1068:	65670064 	strbvs	r0, [r7, #-100]!	; 0xffffff9c
    106c:	64697074 	strbtvs	r7, [r9], #-116	; 0xffffff8c
    1070:	345a5f00 	ldrbcc	r5, [sl], #-3840	; 0xfffff100
    1074:	6e65706f 	cdpvs	0, 6, cr7, cr5, cr15, {3}
    1078:	31634b50 	cmncc	r3, r0, asr fp
    107c:	69464e35 	stmdbvs	r6, {r0, r2, r4, r5, r9, sl, fp, lr}^
    1080:	4f5f656c 	svcmi	0x005f656c
    1084:	5f6e6570 	svcpl	0x006e6570
    1088:	65646f4d 	strbvs	r6, [r4, #-3917]!	; 0xfffff0b3
    108c:	706e6900 	rsbvc	r6, lr, r0, lsl #18
    1090:	64007475 	strvs	r7, [r0], #-1141	; 0xfffffb8b
    1094:	00747365 	rsbseq	r7, r4, r5, ror #6
    1098:	72657a62 	rsbvc	r7, r5, #401408	; 0x62000
    109c:	656c006f 	strbvs	r0, [ip, #-111]!	; 0xffffff91
    10a0:	6874676e 	ldmdavs	r4!, {r1, r2, r3, r5, r6, r8, r9, sl, sp, lr}^
    10a4:	355a5f00 	ldrbcc	r5, [sl, #-3840]	; 0xfffff100
    10a8:	72657a62 	rsbvc	r7, r5, #401408	; 0x62000
    10ac:	6976506f 	ldmdbvs	r6!, {r0, r1, r2, r3, r5, r6, ip, lr}^
    10b0:	73552f00 	cmpvc	r5, #0, 30
    10b4:	2f737265 	svccs	0x00737265
    10b8:	746e6977 	strbtvc	r6, [lr], #-2423	; 0xfffff689
    10bc:	696a7265 	stmdbvs	sl!, {r0, r2, r5, r6, r9, ip, sp, lr}^
    10c0:	7365442f 	cmnvc	r5, #788529152	; 0x2f000000
    10c4:	706f746b 	rsbvc	r7, pc, fp, ror #8
    10c8:	5641462f 	strbpl	r4, [r1], -pc, lsr #12
    10cc:	76614e2f 	strbtvc	r4, [r1], -pc, lsr #28
    10d0:	6a757a61 	bvs	1d5fa5c <__bss_end+0x1d56b28>
    10d4:	2f696369 	svccs	0x00696369
    10d8:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
    10dc:	73656d65 	cmnvc	r5, #6464	; 0x1940
    10e0:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
    10e4:	6b2d616b 	blvs	b59698 <__bss_end+0xb50764>
    10e8:	6f2d7669 	svcvs	0x002d7669
    10ec:	6f732f73 	svcvs	0x00732f73
    10f0:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
    10f4:	74732f73 	ldrbtvc	r2, [r3], #-3955	; 0xfffff08d
    10f8:	62696c64 	rsbvs	r6, r9, #100, 24	; 0x6400
    10fc:	6372732f 	cmnvs	r2, #-1140850688	; 0xbc000000
    1100:	6474732f 	ldrbtvs	r7, [r4], #-815	; 0xfffffcd1
    1104:	69727473 	ldmdbvs	r2!, {r0, r1, r4, r5, r6, sl, ip, sp, lr}^
    1108:	632e676e 			; <UNDEFINED> instruction: 0x632e676e
    110c:	5f007070 	svcpl	0x00007070
    1110:	7461345a 	strbtvc	r3, [r1], #-1114	; 0xfffffba6
    1114:	4b50696f 	blmi	141b6d8 <__bss_end+0x14127a4>
    1118:	68430063 	stmdavs	r3, {r0, r1, r5, r6}^
    111c:	6f437261 	svcvs	0x00437261
    1120:	7241766e 	subvc	r7, r1, #115343360	; 0x6e00000
    1124:	656d0072 	strbvs	r0, [sp, #-114]!	; 0xffffff8e
    1128:	7473646d 	ldrbtvc	r6, [r3], #-1133	; 0xfffffb93
    112c:	74756f00 	ldrbtvc	r6, [r5], #-3840	; 0xfffff100
    1130:	00747570 	rsbseq	r7, r4, r0, ror r5
    1134:	6d365a5f 	vldmdbvs	r6!, {s10-s104}
    1138:	70636d65 	rsbvc	r6, r3, r5, ror #26
    113c:	764b5079 			; <UNDEFINED> instruction: 0x764b5079
    1140:	00697650 	rsbeq	r7, r9, r0, asr r6
    1144:	65736162 	ldrbvs	r6, [r3, #-354]!	; 0xfffffe9e
    1148:	6d656d00 	stclvs	13, cr6, [r5, #-0]
    114c:	00797063 	rsbseq	r7, r9, r3, rrx
    1150:	6c727473 	cfldrdvs	mvd7, [r2], #-460	; 0xfffffe34
    1154:	5f006e65 	svcpl	0x00006e65
    1158:	7473375a 	ldrbtvc	r3, [r3], #-1882	; 0xfffff8a6
    115c:	6d636e72 	stclvs	14, cr6, [r3, #-456]!	; 0xfffffe38
    1160:	634b5070 	movtvs	r5, #45168	; 0xb070
    1164:	695f3053 	ldmdbvs	pc, {r0, r1, r4, r6, ip, sp}^	; <UNPREDICTABLE>
    1168:	365a5f00 	ldrbcc	r5, [sl], -r0, lsl #30
    116c:	6c727473 	cfldrdvs	mvd7, [r2], #-460	; 0xfffffe34
    1170:	4b506e65 	blmi	141cb0c <__bss_end+0x1413bd8>
    1174:	74610063 	strbtvc	r0, [r1], #-99	; 0xffffff9d
    1178:	5f00696f 	svcpl	0x0000696f
    117c:	7473375a 	ldrbtvc	r3, [r3], #-1882	; 0xfffff8a6
    1180:	70636e72 	rsbvc	r6, r3, r2, ror lr
    1184:	50635079 	rsbpl	r5, r3, r9, ror r0
    1188:	0069634b 	rsbeq	r6, r9, fp, asr #6
    118c:	6e727473 	mrcvs	4, 3, r7, cr2, cr3, {3}
    1190:	00706d63 	rsbseq	r6, r0, r3, ror #26
    1194:	6e727473 	mrcvs	4, 3, r7, cr2, cr3, {3}
    1198:	00797063 	rsbseq	r7, r9, r3, rrx
    119c:	6f6d656d 	svcvs	0x006d656d
    11a0:	6d007972 	vstrvs.16	s14, [r0, #-228]	; 0xffffff1c	; <UNPREDICTABLE>
    11a4:	72736d65 	rsbsvc	r6, r3, #6464	; 0x1940
    11a8:	74690063 	strbtvc	r0, [r9], #-99	; 0xffffff9d
    11ac:	5f00616f 	svcpl	0x0000616f
    11b0:	7469345a 	strbtvc	r3, [r9], #-1114	; 0xfffffba6
    11b4:	506a616f 	rsbpl	r6, sl, pc, ror #2
    11b8:	Address 0x00000000000011b8 is out of bounds.


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
  20:	8b040e42 	blhi	103930 <__bss_end+0xfa9fc>
  24:	0b0d4201 	bleq	350830 <__bss_end+0x3478fc>
  28:	420d0d62 	andmi	r0, sp, #6272	; 0x1880
  2c:	00000ecb 	andeq	r0, r0, fp, asr #29
  30:	0000001c 	andeq	r0, r0, ip, lsl r0
  34:	00000000 	andeq	r0, r0, r0
  38:	00008064 	andeq	r8, r0, r4, rrx
  3c:	00000040 	andeq	r0, r0, r0, asr #32
  40:	8b080e42 	blhi	203950 <__bss_end+0x1faa1c>
  44:	42018e02 	andmi	r8, r1, #2, 28
  48:	5a040b0c 	bpl	102c80 <__bss_end+0xf9d4c>
  4c:	00080d0c 	andeq	r0, r8, ip, lsl #26
  50:	0000000c 	andeq	r0, r0, ip
  54:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
  58:	7c020001 	stcvc	0, cr0, [r2], {1}
  5c:	000d0c0e 	andeq	r0, sp, lr, lsl #24
  60:	0000001c 	andeq	r0, r0, ip, lsl r0
  64:	00000050 	andeq	r0, r0, r0, asr r0
  68:	000080a4 	andeq	r8, r0, r4, lsr #1
  6c:	00000038 	andeq	r0, r0, r8, lsr r0
  70:	8b040e42 	blhi	103980 <__bss_end+0xfaa4c>
  74:	0b0d4201 	bleq	350880 <__bss_end+0x34794c>
  78:	420d0d54 	andmi	r0, sp, #84, 26	; 0x1500
  7c:	00000ecb 	andeq	r0, r0, fp, asr #29
  80:	0000001c 	andeq	r0, r0, ip, lsl r0
  84:	00000050 	andeq	r0, r0, r0, asr r0
  88:	000080dc 	ldrdeq	r8, [r0], -ip
  8c:	0000002c 	andeq	r0, r0, ip, lsr #32
  90:	8b040e42 	blhi	1039a0 <__bss_end+0xfaa6c>
  94:	0b0d4201 	bleq	3508a0 <__bss_end+0x34796c>
  98:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
  9c:	00000ecb 	andeq	r0, r0, fp, asr #29
  a0:	0000001c 	andeq	r0, r0, ip, lsl r0
  a4:	00000050 	andeq	r0, r0, r0, asr r0
  a8:	00008108 	andeq	r8, r0, r8, lsl #2
  ac:	00000020 	andeq	r0, r0, r0, lsr #32
  b0:	8b040e42 	blhi	1039c0 <__bss_end+0xfaa8c>
  b4:	0b0d4201 	bleq	3508c0 <__bss_end+0x34798c>
  b8:	420d0d48 	andmi	r0, sp, #72, 26	; 0x1200
  bc:	00000ecb 	andeq	r0, r0, fp, asr #29
  c0:	0000001c 	andeq	r0, r0, ip, lsl r0
  c4:	00000050 	andeq	r0, r0, r0, asr r0
  c8:	00008128 	andeq	r8, r0, r8, lsr #2
  cc:	00000018 	andeq	r0, r0, r8, lsl r0
  d0:	8b040e42 	blhi	1039e0 <__bss_end+0xfaaac>
  d4:	0b0d4201 	bleq	3508e0 <__bss_end+0x3479ac>
  d8:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
  dc:	00000ecb 	andeq	r0, r0, fp, asr #29
  e0:	0000001c 	andeq	r0, r0, ip, lsl r0
  e4:	00000050 	andeq	r0, r0, r0, asr r0
  e8:	00008140 	andeq	r8, r0, r0, asr #2
  ec:	00000018 	andeq	r0, r0, r8, lsl r0
  f0:	8b040e42 	blhi	103a00 <__bss_end+0xfaacc>
  f4:	0b0d4201 	bleq	350900 <__bss_end+0x3479cc>
  f8:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
  fc:	00000ecb 	andeq	r0, r0, fp, asr #29
 100:	0000001c 	andeq	r0, r0, ip, lsl r0
 104:	00000050 	andeq	r0, r0, r0, asr r0
 108:	00008158 	andeq	r8, r0, r8, asr r1
 10c:	00000018 	andeq	r0, r0, r8, lsl r0
 110:	8b040e42 	blhi	103a20 <__bss_end+0xfaaec>
 114:	0b0d4201 	bleq	350920 <__bss_end+0x3479ec>
 118:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
 11c:	00000ecb 	andeq	r0, r0, fp, asr #29
 120:	00000014 	andeq	r0, r0, r4, lsl r0
 124:	00000050 	andeq	r0, r0, r0, asr r0
 128:	00008170 	andeq	r8, r0, r0, ror r1
 12c:	0000000c 	andeq	r0, r0, ip
 130:	8b040e42 	blhi	103a40 <__bss_end+0xfab0c>
 134:	0b0d4201 	bleq	350940 <__bss_end+0x347a0c>
 138:	0000001c 	andeq	r0, r0, ip, lsl r0
 13c:	00000050 	andeq	r0, r0, r0, asr r0
 140:	0000817c 	andeq	r8, r0, ip, ror r1
 144:	00000058 	andeq	r0, r0, r8, asr r0
 148:	8b080e42 	blhi	203a58 <__bss_end+0x1fab24>
 14c:	42018e02 	andmi	r8, r1, #2, 28
 150:	62040b0c 	andvs	r0, r4, #12, 22	; 0x3000
 154:	00080d0c 	andeq	r0, r8, ip, lsl #26
 158:	0000001c 	andeq	r0, r0, ip, lsl r0
 15c:	00000050 	andeq	r0, r0, r0, asr r0
 160:	000081d4 	ldrdeq	r8, [r0], -r4
 164:	00000058 	andeq	r0, r0, r8, asr r0
 168:	8b080e42 	blhi	203a78 <__bss_end+0x1fab44>
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
 194:	000000b8 	strheq	r0, [r0], -r8
 198:	8b080e42 	blhi	203aa8 <__bss_end+0x1fab74>
 19c:	42018e02 	andmi	r8, r1, #2, 28
 1a0:	00040b0c 	andeq	r0, r4, ip, lsl #22
 1a4:	0000000c 	andeq	r0, r0, ip
 1a8:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 1ac:	7c020001 	stcvc	0, cr0, [r2], {1}
 1b0:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 1b4:	0000001c 	andeq	r0, r0, ip, lsl r0
 1b8:	000001a4 	andeq	r0, r0, r4, lsr #3
 1bc:	000082e4 	andeq	r8, r0, r4, ror #5
 1c0:	0000002c 	andeq	r0, r0, ip, lsr #32
 1c4:	8b040e42 	blhi	103ad4 <__bss_end+0xfaba0>
 1c8:	0b0d4201 	bleq	3509d4 <__bss_end+0x347aa0>
 1cc:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
 1d0:	00000ecb 	andeq	r0, r0, fp, asr #29
 1d4:	0000001c 	andeq	r0, r0, ip, lsl r0
 1d8:	000001a4 	andeq	r0, r0, r4, lsr #3
 1dc:	00008310 	andeq	r8, r0, r0, lsl r3
 1e0:	0000002c 	andeq	r0, r0, ip, lsr #32
 1e4:	8b040e42 	blhi	103af4 <__bss_end+0xfabc0>
 1e8:	0b0d4201 	bleq	3509f4 <__bss_end+0x347ac0>
 1ec:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
 1f0:	00000ecb 	andeq	r0, r0, fp, asr #29
 1f4:	0000001c 	andeq	r0, r0, ip, lsl r0
 1f8:	000001a4 	andeq	r0, r0, r4, lsr #3
 1fc:	0000833c 	andeq	r8, r0, ip, lsr r3
 200:	0000001c 	andeq	r0, r0, ip, lsl r0
 204:	8b040e42 	blhi	103b14 <__bss_end+0xfabe0>
 208:	0b0d4201 	bleq	350a14 <__bss_end+0x347ae0>
 20c:	420d0d46 	andmi	r0, sp, #4480	; 0x1180
 210:	00000ecb 	andeq	r0, r0, fp, asr #29
 214:	0000001c 	andeq	r0, r0, ip, lsl r0
 218:	000001a4 	andeq	r0, r0, r4, lsr #3
 21c:	00008358 	andeq	r8, r0, r8, asr r3
 220:	00000044 	andeq	r0, r0, r4, asr #32
 224:	8b040e42 	blhi	103b34 <__bss_end+0xfac00>
 228:	0b0d4201 	bleq	350a34 <__bss_end+0x347b00>
 22c:	420d0d5a 	andmi	r0, sp, #5760	; 0x1680
 230:	00000ecb 	andeq	r0, r0, fp, asr #29
 234:	0000001c 	andeq	r0, r0, ip, lsl r0
 238:	000001a4 	andeq	r0, r0, r4, lsr #3
 23c:	0000839c 	muleq	r0, ip, r3
 240:	00000050 	andeq	r0, r0, r0, asr r0
 244:	8b040e42 	blhi	103b54 <__bss_end+0xfac20>
 248:	0b0d4201 	bleq	350a54 <__bss_end+0x347b20>
 24c:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 250:	00000ecb 	andeq	r0, r0, fp, asr #29
 254:	0000001c 	andeq	r0, r0, ip, lsl r0
 258:	000001a4 	andeq	r0, r0, r4, lsr #3
 25c:	000083ec 	andeq	r8, r0, ip, ror #7
 260:	00000050 	andeq	r0, r0, r0, asr r0
 264:	8b040e42 	blhi	103b74 <__bss_end+0xfac40>
 268:	0b0d4201 	bleq	350a74 <__bss_end+0x347b40>
 26c:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 270:	00000ecb 	andeq	r0, r0, fp, asr #29
 274:	0000001c 	andeq	r0, r0, ip, lsl r0
 278:	000001a4 	andeq	r0, r0, r4, lsr #3
 27c:	0000843c 	andeq	r8, r0, ip, lsr r4
 280:	0000002c 	andeq	r0, r0, ip, lsr #32
 284:	8b040e42 	blhi	103b94 <__bss_end+0xfac60>
 288:	0b0d4201 	bleq	350a94 <__bss_end+0x347b60>
 28c:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
 290:	00000ecb 	andeq	r0, r0, fp, asr #29
 294:	0000001c 	andeq	r0, r0, ip, lsl r0
 298:	000001a4 	andeq	r0, r0, r4, lsr #3
 29c:	00008468 	andeq	r8, r0, r8, ror #8
 2a0:	00000050 	andeq	r0, r0, r0, asr r0
 2a4:	8b040e42 	blhi	103bb4 <__bss_end+0xfac80>
 2a8:	0b0d4201 	bleq	350ab4 <__bss_end+0x347b80>
 2ac:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 2b0:	00000ecb 	andeq	r0, r0, fp, asr #29
 2b4:	0000001c 	andeq	r0, r0, ip, lsl r0
 2b8:	000001a4 	andeq	r0, r0, r4, lsr #3
 2bc:	000084b8 			; <UNDEFINED> instruction: 0x000084b8
 2c0:	00000044 	andeq	r0, r0, r4, asr #32
 2c4:	8b040e42 	blhi	103bd4 <__bss_end+0xfaca0>
 2c8:	0b0d4201 	bleq	350ad4 <__bss_end+0x347ba0>
 2cc:	420d0d5a 	andmi	r0, sp, #5760	; 0x1680
 2d0:	00000ecb 	andeq	r0, r0, fp, asr #29
 2d4:	0000001c 	andeq	r0, r0, ip, lsl r0
 2d8:	000001a4 	andeq	r0, r0, r4, lsr #3
 2dc:	000084fc 	strdeq	r8, [r0], -ip
 2e0:	00000050 	andeq	r0, r0, r0, asr r0
 2e4:	8b040e42 	blhi	103bf4 <__bss_end+0xfacc0>
 2e8:	0b0d4201 	bleq	350af4 <__bss_end+0x347bc0>
 2ec:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 2f0:	00000ecb 	andeq	r0, r0, fp, asr #29
 2f4:	0000001c 	andeq	r0, r0, ip, lsl r0
 2f8:	000001a4 	andeq	r0, r0, r4, lsr #3
 2fc:	0000854c 	andeq	r8, r0, ip, asr #10
 300:	00000054 	andeq	r0, r0, r4, asr r0
 304:	8b040e42 	blhi	103c14 <__bss_end+0xface0>
 308:	0b0d4201 	bleq	350b14 <__bss_end+0x347be0>
 30c:	420d0d62 	andmi	r0, sp, #6272	; 0x1880
 310:	00000ecb 	andeq	r0, r0, fp, asr #29
 314:	0000001c 	andeq	r0, r0, ip, lsl r0
 318:	000001a4 	andeq	r0, r0, r4, lsr #3
 31c:	000085a0 	andeq	r8, r0, r0, lsr #11
 320:	0000003c 	andeq	r0, r0, ip, lsr r0
 324:	8b040e42 	blhi	103c34 <__bss_end+0xfad00>
 328:	0b0d4201 	bleq	350b34 <__bss_end+0x347c00>
 32c:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 330:	00000ecb 	andeq	r0, r0, fp, asr #29
 334:	0000001c 	andeq	r0, r0, ip, lsl r0
 338:	000001a4 	andeq	r0, r0, r4, lsr #3
 33c:	000085dc 	ldrdeq	r8, [r0], -ip
 340:	0000003c 	andeq	r0, r0, ip, lsr r0
 344:	8b040e42 	blhi	103c54 <__bss_end+0xfad20>
 348:	0b0d4201 	bleq	350b54 <__bss_end+0x347c20>
 34c:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 350:	00000ecb 	andeq	r0, r0, fp, asr #29
 354:	0000001c 	andeq	r0, r0, ip, lsl r0
 358:	000001a4 	andeq	r0, r0, r4, lsr #3
 35c:	00008618 	andeq	r8, r0, r8, lsl r6
 360:	0000003c 	andeq	r0, r0, ip, lsr r0
 364:	8b040e42 	blhi	103c74 <__bss_end+0xfad40>
 368:	0b0d4201 	bleq	350b74 <__bss_end+0x347c40>
 36c:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 370:	00000ecb 	andeq	r0, r0, fp, asr #29
 374:	0000001c 	andeq	r0, r0, ip, lsl r0
 378:	000001a4 	andeq	r0, r0, r4, lsr #3
 37c:	00008654 	andeq	r8, r0, r4, asr r6
 380:	0000003c 	andeq	r0, r0, ip, lsr r0
 384:	8b040e42 	blhi	103c94 <__bss_end+0xfad60>
 388:	0b0d4201 	bleq	350b94 <__bss_end+0x347c60>
 38c:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 390:	00000ecb 	andeq	r0, r0, fp, asr #29
 394:	0000001c 	andeq	r0, r0, ip, lsl r0
 398:	000001a4 	andeq	r0, r0, r4, lsr #3
 39c:	00008690 	muleq	r0, r0, r6
 3a0:	000000b0 	strheq	r0, [r0], -r0	; <UNPREDICTABLE>
 3a4:	8b080e42 	blhi	203cb4 <__bss_end+0x1fad80>
 3a8:	42018e02 	andmi	r8, r1, #2, 28
 3ac:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 3b0:	080d0c50 	stmdaeq	sp, {r4, r6, sl, fp}
 3b4:	0000000c 	andeq	r0, r0, ip
 3b8:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 3bc:	7c020001 	stcvc	0, cr0, [r2], {1}
 3c0:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 3c4:	0000001c 	andeq	r0, r0, ip, lsl r0
 3c8:	000003b4 			; <UNDEFINED> instruction: 0x000003b4
 3cc:	00008740 	andeq	r8, r0, r0, asr #14
 3d0:	00000174 	andeq	r0, r0, r4, ror r1
 3d4:	8b080e42 	blhi	203ce4 <__bss_end+0x1fadb0>
 3d8:	42018e02 	andmi	r8, r1, #2, 28
 3dc:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 3e0:	080d0cb2 	stmdaeq	sp, {r1, r4, r5, r7, sl, fp}
 3e4:	0000001c 	andeq	r0, r0, ip, lsl r0
 3e8:	000003b4 			; <UNDEFINED> instruction: 0x000003b4
 3ec:	000088b4 			; <UNDEFINED> instruction: 0x000088b4
 3f0:	0000009c 	muleq	r0, ip, r0
 3f4:	8b040e42 	blhi	103d04 <__bss_end+0xfadd0>
 3f8:	0b0d4201 	bleq	350c04 <__bss_end+0x347cd0>
 3fc:	0d0d4602 	stceq	6, cr4, [sp, #-8]
 400:	000ecb42 	andeq	ip, lr, r2, asr #22
 404:	0000001c 	andeq	r0, r0, ip, lsl r0
 408:	000003b4 			; <UNDEFINED> instruction: 0x000003b4
 40c:	00008950 	andeq	r8, r0, r0, asr r9
 410:	000000c0 	andeq	r0, r0, r0, asr #1
 414:	8b040e42 	blhi	103d24 <__bss_end+0xfadf0>
 418:	0b0d4201 	bleq	350c24 <__bss_end+0x347cf0>
 41c:	0d0d5802 	stceq	8, cr5, [sp, #-8]
 420:	000ecb42 	andeq	ip, lr, r2, asr #22
 424:	0000001c 	andeq	r0, r0, ip, lsl r0
 428:	000003b4 			; <UNDEFINED> instruction: 0x000003b4
 42c:	00008a10 	andeq	r8, r0, r0, lsl sl
 430:	000000ac 	andeq	r0, r0, ip, lsr #1
 434:	8b040e42 	blhi	103d44 <__bss_end+0xfae10>
 438:	0b0d4201 	bleq	350c44 <__bss_end+0x347d10>
 43c:	0d0d4e02 	stceq	14, cr4, [sp, #-8]
 440:	000ecb42 	andeq	ip, lr, r2, asr #22
 444:	0000001c 	andeq	r0, r0, ip, lsl r0
 448:	000003b4 			; <UNDEFINED> instruction: 0x000003b4
 44c:	00008abc 			; <UNDEFINED> instruction: 0x00008abc
 450:	00000054 	andeq	r0, r0, r4, asr r0
 454:	8b040e42 	blhi	103d64 <__bss_end+0xfae30>
 458:	0b0d4201 	bleq	350c64 <__bss_end+0x347d30>
 45c:	420d0d62 	andmi	r0, sp, #6272	; 0x1880
 460:	00000ecb 	andeq	r0, r0, fp, asr #29
 464:	0000001c 	andeq	r0, r0, ip, lsl r0
 468:	000003b4 			; <UNDEFINED> instruction: 0x000003b4
 46c:	00008b10 	andeq	r8, r0, r0, lsl fp
 470:	00000068 	andeq	r0, r0, r8, rrx
 474:	8b040e42 	blhi	103d84 <__bss_end+0xfae50>
 478:	0b0d4201 	bleq	350c84 <__bss_end+0x347d50>
 47c:	420d0d6c 	andmi	r0, sp, #108, 26	; 0x1b00
 480:	00000ecb 	andeq	r0, r0, fp, asr #29
 484:	0000001c 	andeq	r0, r0, ip, lsl r0
 488:	000003b4 			; <UNDEFINED> instruction: 0x000003b4
 48c:	00008b78 	andeq	r8, r0, r8, ror fp
 490:	00000080 	andeq	r0, r0, r0, lsl #1
 494:	8b040e42 	blhi	103da4 <__bss_end+0xfae70>
 498:	0b0d4201 	bleq	350ca4 <__bss_end+0x347d70>
 49c:	420d0d78 	andmi	r0, sp, #120, 26	; 0x1e00
 4a0:	00000ecb 	andeq	r0, r0, fp, asr #29
 4a4:	0000000c 	andeq	r0, r0, ip
 4a8:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 4ac:	7c010001 	stcvc	0, cr0, [r1], {1}
 4b0:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 4b4:	0000000c 	andeq	r0, r0, ip
 4b8:	000004a4 	andeq	r0, r0, r4, lsr #9
 4bc:	00008bf8 	strdeq	r8, [r0], -r8	; <UNPREDICTABLE>
 4c0:	000001ec 	andeq	r0, r0, ip, ror #3
