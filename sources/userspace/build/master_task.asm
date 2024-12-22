
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
    805c:	00009964 	andeq	r9, r0, r4, ror #18
    8060:	00009a00 	andeq	r9, r0, r0, lsl #20

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
    8080:	eb0001fb 	bl	8874 <main>
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
    81cc:	00009960 	andeq	r9, r0, r0, ror #18
    81d0:	00009960 	andeq	r9, r0, r0, ror #18

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
    8224:	00009960 	andeq	r9, r0, r0, ror #18
    8228:	00009960 	andeq	r9, r0, r0, ror #18

0000822c <_Z8prep_msgPcPKc>:
_Z8prep_msgPcPKc():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:24
uint32_t master, log_fd;

float received_values[32];
uint32_t received_values_len = 0;

void prep_msg(char* buff, const char* msg) {
    822c:	e92d4810 	push	{r4, fp, lr}
    8230:	e28db008 	add	fp, sp, #8
    8234:	e24dd014 	sub	sp, sp, #20
    8238:	e50b0018 	str	r0, [fp, #-24]	; 0xffffffe8
    823c:	e50b101c 	str	r1, [fp, #-28]	; 0xffffffe4
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:25
    uint16_t ofset = 0;
    8240:	e3a03000 	mov	r3, #0
    8244:	e14b30be 	strh	r3, [fp, #-14]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:26
    switch (agreed_role)
    8248:	e59f309c 	ldr	r3, [pc, #156]	; 82ec <_Z8prep_msgPcPKc+0xc0>
    824c:	e5933000 	ldr	r3, [r3]
    8250:	e3530000 	cmp	r3, #0
    8254:	0a000002 	beq	8264 <_Z8prep_msgPcPKc+0x38>
    8258:	e3530001 	cmp	r3, #1
    825c:	0a000007 	beq	8280 <_Z8prep_msgPcPKc+0x54>
    8260:	ea00000d 	b	829c <_Z8prep_msgPcPKc+0x70>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:29
    {
    case CI2C_Mode::Master:
        strncpy(buff, "MASTER: ", 8);
    8264:	e3a02008 	mov	r2, #8
    8268:	e59f1080 	ldr	r1, [pc, #128]	; 82f0 <_Z8prep_msgPcPKc+0xc4>
    826c:	e51b0018 	ldr	r0, [fp, #-24]	; 0xffffffe8
    8270:	eb000405 	bl	928c <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:30
        ofset = 8;
    8274:	e3a03008 	mov	r3, #8
    8278:	e14b30be 	strh	r3, [fp, #-14]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:31
        break;
    827c:	ea00000d 	b	82b8 <_Z8prep_msgPcPKc+0x8c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:33
    case CI2C_Mode::Slave:
        strncpy(buff, "SLAVE: ", 7);
    8280:	e3a02007 	mov	r2, #7
    8284:	e59f1068 	ldr	r1, [pc, #104]	; 82f4 <_Z8prep_msgPcPKc+0xc8>
    8288:	e51b0018 	ldr	r0, [fp, #-24]	; 0xffffffe8
    828c:	eb0003fe 	bl	928c <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:34
        ofset = 7;
    8290:	e3a03007 	mov	r3, #7
    8294:	e14b30be 	strh	r3, [fp, #-14]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:35
        break;
    8298:	ea000006 	b	82b8 <_Z8prep_msgPcPKc+0x8c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:37
    default:
        strncpy(buff, "UNSET: ", 7);
    829c:	e3a02007 	mov	r2, #7
    82a0:	e59f1050 	ldr	r1, [pc, #80]	; 82f8 <_Z8prep_msgPcPKc+0xcc>
    82a4:	e51b0018 	ldr	r0, [fp, #-24]	; 0xffffffe8
    82a8:	eb0003f7 	bl	928c <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:38
        ofset = 7;
    82ac:	e3a03007 	mov	r3, #7
    82b0:	e14b30be 	strh	r3, [fp, #-14]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:39
        break;
    82b4:	e320f000 	nop	{0}
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:42
    }
    
    strncpy(buff + ofset, msg, strlen(msg));
    82b8:	e15b30be 	ldrh	r3, [fp, #-14]
    82bc:	e51b2018 	ldr	r2, [fp, #-24]	; 0xffffffe8
    82c0:	e0824003 	add	r4, r2, r3
    82c4:	e51b001c 	ldr	r0, [fp, #-28]	; 0xffffffe4
    82c8:	eb00044a 	bl	93f8 <_Z6strlenPKc>
    82cc:	e1a03000 	mov	r3, r0
    82d0:	e1a02003 	mov	r2, r3
    82d4:	e51b101c 	ldr	r1, [fp, #-28]	; 0xffffffe4
    82d8:	e1a00004 	mov	r0, r4
    82dc:	eb0003ea 	bl	928c <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:43
}
    82e0:	e320f000 	nop	{0}
    82e4:	e24bd008 	sub	sp, fp, #8
    82e8:	e8bd8810 	pop	{r4, fp, pc}
    82ec:	00009960 	andeq	r9, r0, r0, ror #18
    82f0:	00009828 	andeq	r9, r0, r8, lsr #16
    82f4:	00009834 	andeq	r9, r0, r4, lsr r8
    82f8:	0000983c 	andeq	r9, r0, ip, lsr r8

000082fc <_Z3logPKc>:
_Z3logPKc():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:46

void log(const char* msg)
{
    82fc:	e92d49f0 	push	{r4, r5, r6, r7, r8, fp, lr}
    8300:	e28db018 	add	fp, sp, #24
    8304:	e24dd014 	sub	sp, sp, #20
    8308:	e50b0028 	str	r0, [fp, #-40]	; 0xffffffd8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:49
    char new_buff[strlen(msg) + 7];
    prep_msg(new_buff, msg);
    write(log_fd, new_buff, strlen(msg)+7);
    830c:	e1a0300d 	mov	r3, sp
    8310:	e1a08003 	mov	r8, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:47
    char new_buff[strlen(msg) + 7];
    8314:	e51b0028 	ldr	r0, [fp, #-40]	; 0xffffffd8
    8318:	eb000436 	bl	93f8 <_Z6strlenPKc>
    831c:	e1a03000 	mov	r3, r0
    8320:	e2831006 	add	r1, r3, #6
    8324:	e50b1020 	str	r1, [fp, #-32]	; 0xffffffe0
    8328:	e1a03001 	mov	r3, r1
    832c:	e2833001 	add	r3, r3, #1
    8330:	e3a02000 	mov	r2, #0
    8334:	e1a06003 	mov	r6, r3
    8338:	e1a07002 	mov	r7, r2
    833c:	e3a02000 	mov	r2, #0
    8340:	e3a03000 	mov	r3, #0
    8344:	e1a03187 	lsl	r3, r7, #3
    8348:	e1833ea6 	orr	r3, r3, r6, lsr #29
    834c:	e1a02186 	lsl	r2, r6, #3
    8350:	e1a03001 	mov	r3, r1
    8354:	e2833001 	add	r3, r3, #1
    8358:	e3a02000 	mov	r2, #0
    835c:	e1a04003 	mov	r4, r3
    8360:	e1a05002 	mov	r5, r2
    8364:	e3a02000 	mov	r2, #0
    8368:	e3a03000 	mov	r3, #0
    836c:	e1a03185 	lsl	r3, r5, #3
    8370:	e1833ea4 	orr	r3, r3, r4, lsr #29
    8374:	e1a02184 	lsl	r2, r4, #3
    8378:	e1a03001 	mov	r3, r1
    837c:	e2833001 	add	r3, r3, #1
    8380:	e2833007 	add	r3, r3, #7
    8384:	e1a031a3 	lsr	r3, r3, #3
    8388:	e1a03183 	lsl	r3, r3, #3
    838c:	e04dd003 	sub	sp, sp, r3
    8390:	e1a0300d 	mov	r3, sp
    8394:	e2833000 	add	r3, r3, #0
    8398:	e50b3024 	str	r3, [fp, #-36]	; 0xffffffdc
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:48
    prep_msg(new_buff, msg);
    839c:	e51b1028 	ldr	r1, [fp, #-40]	; 0xffffffd8
    83a0:	e51b0024 	ldr	r0, [fp, #-36]	; 0xffffffdc
    83a4:	ebffffa0 	bl	822c <_Z8prep_msgPcPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:49
    write(log_fd, new_buff, strlen(msg)+7);
    83a8:	e59f3030 	ldr	r3, [pc, #48]	; 83e0 <_Z3logPKc+0xe4>
    83ac:	e5934000 	ldr	r4, [r3]
    83b0:	e51b0028 	ldr	r0, [fp, #-40]	; 0xffffffd8
    83b4:	eb00040f 	bl	93f8 <_Z6strlenPKc>
    83b8:	e1a03000 	mov	r3, r0
    83bc:	e2833007 	add	r3, r3, #7
    83c0:	e1a02003 	mov	r2, r3
    83c4:	e51b1024 	ldr	r1, [fp, #-36]	; 0xffffffdc
    83c8:	e1a00004 	mov	r0, r4
    83cc:	eb0001b0 	bl	8a94 <_Z5writejPKcj>
    83d0:	e1a0d008 	mov	sp, r8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:50
}
    83d4:	e320f000 	nop	{0}
    83d8:	e24bd018 	sub	sp, fp, #24
    83dc:	e8bd89f0 	pop	{r4, r5, r6, r7, r8, fp, pc}
    83e0:	00009968 	andeq	r9, r0, r8, ror #18

000083e4 <_Z11decide_role9CI2C_ModePc>:
_Z11decide_role9CI2C_ModePc():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:53

CI2C_Mode decide_role(CI2C_Mode my_role, char* other_role_buff)
{
    83e4:	e92d4800 	push	{fp, lr}
    83e8:	e28db004 	add	fp, sp, #4
    83ec:	e24dd010 	sub	sp, sp, #16
    83f0:	e50b0010 	str	r0, [fp, #-16]
    83f4:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:54
    CI2C_Mode other_role = CI2C_Mode::Undefined;
    83f8:	e3a03002 	mov	r3, #2
    83fc:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:55
    if (strncmp(other_role_buff, "mst", 3) == 0)
    8400:	e3a02003 	mov	r2, #3
    8404:	e59f10bc 	ldr	r1, [pc, #188]	; 84c8 <_Z11decide_role9CI2C_ModePc+0xe4>
    8408:	e51b0014 	ldr	r0, [fp, #-20]	; 0xffffffec
    840c:	eb0003ce 	bl	934c <_Z7strncmpPKcS0_i>
    8410:	e1a03000 	mov	r3, r0
    8414:	e3530000 	cmp	r3, #0
    8418:	03a03001 	moveq	r3, #1
    841c:	13a03000 	movne	r3, #0
    8420:	e6ef3073 	uxtb	r3, r3
    8424:	e3530000 	cmp	r3, #0
    8428:	0a000002 	beq	8438 <_Z11decide_role9CI2C_ModePc+0x54>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:57
    {
        other_role = CI2C_Mode::Master;
    842c:	e3a03000 	mov	r3, #0
    8430:	e50b3008 	str	r3, [fp, #-8]
    8434:	ea00000c 	b	846c <_Z11decide_role9CI2C_ModePc+0x88>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:59
    }
    else if (strncmp(other_role_buff, "slv", 3) == 0)
    8438:	e3a02003 	mov	r2, #3
    843c:	e59f1088 	ldr	r1, [pc, #136]	; 84cc <_Z11decide_role9CI2C_ModePc+0xe8>
    8440:	e51b0014 	ldr	r0, [fp, #-20]	; 0xffffffec
    8444:	eb0003c0 	bl	934c <_Z7strncmpPKcS0_i>
    8448:	e1a03000 	mov	r3, r0
    844c:	e3530000 	cmp	r3, #0
    8450:	03a03001 	moveq	r3, #1
    8454:	13a03000 	movne	r3, #0
    8458:	e6ef3073 	uxtb	r3, r3
    845c:	e3530000 	cmp	r3, #0
    8460:	0a000001 	beq	846c <_Z11decide_role9CI2C_ModePc+0x88>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:61
    {
        other_role = CI2C_Mode::Slave;
    8464:	e3a03001 	mov	r3, #1
    8468:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:64
    }

    if (my_role == CI2C_Mode::Undefined)
    846c:	e51b3010 	ldr	r3, [fp, #-16]
    8470:	e3530002 	cmp	r3, #2
    8474:	1a000009 	bne	84a0 <_Z11decide_role9CI2C_ModePc+0xbc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:66
    {
        if (other_role == CI2C_Mode::Master)
    8478:	e51b3008 	ldr	r3, [fp, #-8]
    847c:	e3530000 	cmp	r3, #0
    8480:	1a000001 	bne	848c <_Z11decide_role9CI2C_ModePc+0xa8>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:68
        {
            return CI2C_Mode::Slave;
    8484:	e3a03001 	mov	r3, #1
    8488:	ea00000b 	b	84bc <_Z11decide_role9CI2C_ModePc+0xd8>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:70
        }
        else if (other_role == CI2C_Mode::Slave)
    848c:	e51b3008 	ldr	r3, [fp, #-8]
    8490:	e3530001 	cmp	r3, #1
    8494:	1a000007 	bne	84b8 <_Z11decide_role9CI2C_ModePc+0xd4>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:72
        {
            return CI2C_Mode::Master;
    8498:	e3a03000 	mov	r3, #0
    849c:	ea000006 	b	84bc <_Z11decide_role9CI2C_ModePc+0xd8>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:76
        }
    }
    else {
        if (my_role == other_role)
    84a0:	e51b2010 	ldr	r2, [fp, #-16]
    84a4:	e51b3008 	ldr	r3, [fp, #-8]
    84a8:	e1520003 	cmp	r2, r3
    84ac:	1a000001 	bne	84b8 <_Z11decide_role9CI2C_ModePc+0xd4>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:79
        {
            if (ADDRESS < TARGET_ADDRESS)
                return CI2C_Mode::Master;
    84b0:	e3a03000 	mov	r3, #0
    84b4:	ea000000 	b	84bc <_Z11decide_role9CI2C_ModePc+0xd8>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:84
            else
                return CI2C_Mode::Slave;
        }
    }
    return my_role;
    84b8:	e51b3010 	ldr	r3, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:85
}
    84bc:	e1a00003 	mov	r0, r3
    84c0:	e24bd004 	sub	sp, fp, #4
    84c4:	e8bd8800 	pop	{fp, pc}
    84c8:	00009844 	andeq	r9, r0, r4, asr #16
    84cc:	00009848 	andeq	r9, r0, r8, asr #16

000084d0 <_Z9set_roles9CI2C_Mode>:
_Z9set_roles9CI2C_Mode():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:88

bool set_roles(CI2C_Mode desired_role)
{
    84d0:	e92d4800 	push	{fp, lr}
    84d4:	e28db004 	add	fp, sp, #4
    84d8:	e24dd050 	sub	sp, sp, #80	; 0x50
    84dc:	e50b0050 	str	r0, [fp, #-80]	; 0xffffffb0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:90
    char role[4], buff[32], log_msg[32];
    bzero(role, 4);
    84e0:	e24b3008 	sub	r3, fp, #8
    84e4:	e3a01004 	mov	r1, #4
    84e8:	e1a00003 	mov	r0, r3
    84ec:	eb0003d6 	bl	944c <_Z5bzeroPvi>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:91
    bzero(buff, 32);
    84f0:	e24b3028 	sub	r3, fp, #40	; 0x28
    84f4:	e3a01020 	mov	r1, #32
    84f8:	e1a00003 	mov	r0, r3
    84fc:	eb0003d2 	bl	944c <_Z5bzeroPvi>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:92
    bzero(log_msg, 32);
    8500:	e24b3048 	sub	r3, fp, #72	; 0x48
    8504:	e3a01020 	mov	r1, #32
    8508:	e1a00003 	mov	r0, r3
    850c:	eb0003ce 	bl	944c <_Z5bzeroPvi>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:93
    switch (desired_role)
    8510:	e51b3050 	ldr	r3, [fp, #-80]	; 0xffffffb0
    8514:	e3530000 	cmp	r3, #0
    8518:	0a000003 	beq	852c <_Z9set_roles9CI2C_Mode+0x5c>
    851c:	e51b3050 	ldr	r3, [fp, #-80]	; 0xffffffb0
    8520:	e3530001 	cmp	r3, #1
    8524:	0a000006 	beq	8544 <_Z9set_roles9CI2C_Mode+0x74>
    8528:	ea00000b 	b	855c <_Z9set_roles9CI2C_Mode+0x8c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:96
    {
    case CI2C_Mode::Master:
        strncpy(role, "mst", 3);
    852c:	e24b3008 	sub	r3, fp, #8
    8530:	e3a02003 	mov	r2, #3
    8534:	e59f1148 	ldr	r1, [pc, #328]	; 8684 <_Z9set_roles9CI2C_Mode+0x1b4>
    8538:	e1a00003 	mov	r0, r3
    853c:	eb000352 	bl	928c <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:97
        break;
    8540:	ea00000b 	b	8574 <_Z9set_roles9CI2C_Mode+0xa4>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:99
    case CI2C_Mode::Slave:
        strncpy(role, "slv", 3);
    8544:	e24b3008 	sub	r3, fp, #8
    8548:	e3a02003 	mov	r2, #3
    854c:	e59f1134 	ldr	r1, [pc, #308]	; 8688 <_Z9set_roles9CI2C_Mode+0x1b8>
    8550:	e1a00003 	mov	r0, r3
    8554:	eb00034c 	bl	928c <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:100
        break;
    8558:	ea000005 	b	8574 <_Z9set_roles9CI2C_Mode+0xa4>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:102
    default:
        strncpy(role, "slv", 3);
    855c:	e24b3008 	sub	r3, fp, #8
    8560:	e3a02003 	mov	r2, #3
    8564:	e59f111c 	ldr	r1, [pc, #284]	; 8688 <_Z9set_roles9CI2C_Mode+0x1b8>
    8568:	e1a00003 	mov	r0, r3
    856c:	eb000346 	bl	928c <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:103
        break;
    8570:	e320f000 	nop	{0}
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:106
    }

    write(master, role, 4);
    8574:	e59f3110 	ldr	r3, [pc, #272]	; 868c <_Z9set_roles9CI2C_Mode+0x1bc>
    8578:	e5933000 	ldr	r3, [r3]
    857c:	e24b1008 	sub	r1, fp, #8
    8580:	e3a02004 	mov	r2, #4
    8584:	e1a00003 	mov	r0, r3
    8588:	eb000141 	bl	8a94 <_Z5writejPKcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:107
    while (strlen(buff) == 0) {
    858c:	e24b3028 	sub	r3, fp, #40	; 0x28
    8590:	e1a00003 	mov	r0, r3
    8594:	eb000397 	bl	93f8 <_Z6strlenPKc>
    8598:	e1a03000 	mov	r3, r0
    859c:	e3530000 	cmp	r3, #0
    85a0:	03a03001 	moveq	r3, #1
    85a4:	13a03000 	movne	r3, #0
    85a8:	e6ef3073 	uxtb	r3, r3
    85ac:	e3530000 	cmp	r3, #0
    85b0:	0a000009 	beq	85dc <_Z9set_roles9CI2C_Mode+0x10c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:108
        read(master, buff, 4);
    85b4:	e59f30d0 	ldr	r3, [pc, #208]	; 868c <_Z9set_roles9CI2C_Mode+0x1bc>
    85b8:	e5933000 	ldr	r3, [r3]
    85bc:	e24b1028 	sub	r1, fp, #40	; 0x28
    85c0:	e3a02004 	mov	r2, #4
    85c4:	e1a00003 	mov	r0, r3
    85c8:	eb00011d 	bl	8a44 <_Z4readjPcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:109
        sleep(0x100);
    85cc:	e3e01001 	mvn	r1, #1
    85d0:	e3a00c01 	mov	r0, #256	; 0x100
    85d4:	eb000186 	bl	8bf4 <_Z5sleepjj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:107
    while (strlen(buff) == 0) {
    85d8:	eaffffeb 	b	858c <_Z9set_roles9CI2C_Mode+0xbc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:112
    }

    agreed_role = decide_role(desired_role, buff);
    85dc:	e24b3028 	sub	r3, fp, #40	; 0x28
    85e0:	e1a01003 	mov	r1, r3
    85e4:	e51b0050 	ldr	r0, [fp, #-80]	; 0xffffffb0
    85e8:	ebffff7d 	bl	83e4 <_Z11decide_role9CI2C_ModePc>
    85ec:	e1a03000 	mov	r3, r0
    85f0:	e59f2098 	ldr	r2, [pc, #152]	; 8690 <_Z9set_roles9CI2C_Mode+0x1c0>
    85f4:	e5823000 	str	r3, [r2]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:113
    strncpy(log_msg, "Roles set. I am ", 16);
    85f8:	e24b3048 	sub	r3, fp, #72	; 0x48
    85fc:	e3a02010 	mov	r2, #16
    8600:	e59f108c 	ldr	r1, [pc, #140]	; 8694 <_Z9set_roles9CI2C_Mode+0x1c4>
    8604:	e1a00003 	mov	r0, r3
    8608:	eb00031f 	bl	928c <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:114
    switch (agreed_role)
    860c:	e59f307c 	ldr	r3, [pc, #124]	; 8690 <_Z9set_roles9CI2C_Mode+0x1c0>
    8610:	e5933000 	ldr	r3, [r3]
    8614:	e3530000 	cmp	r3, #0
    8618:	0a000002 	beq	8628 <_Z9set_roles9CI2C_Mode+0x158>
    861c:	e3530001 	cmp	r3, #1
    8620:	0a000005 	beq	863c <_Z9set_roles9CI2C_Mode+0x16c>
    8624:	ea000009 	b	8650 <_Z9set_roles9CI2C_Mode+0x180>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:117
    {
    case CI2C_Mode::Master:
        concat(log_msg, "Master\n");
    8628:	e24b3048 	sub	r3, fp, #72	; 0x48
    862c:	e59f1064 	ldr	r1, [pc, #100]	; 8698 <_Z9set_roles9CI2C_Mode+0x1c8>
    8630:	e1a00003 	mov	r0, r3
    8634:	eb0003be 	bl	9534 <_Z6concatPcPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:118
        break;
    8638:	ea000004 	b	8650 <_Z9set_roles9CI2C_Mode+0x180>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:120
    case CI2C_Mode::Slave:
        concat(log_msg, "Slave\n");
    863c:	e24b3048 	sub	r3, fp, #72	; 0x48
    8640:	e59f1054 	ldr	r1, [pc, #84]	; 869c <_Z9set_roles9CI2C_Mode+0x1cc>
    8644:	e1a00003 	mov	r0, r3
    8648:	eb0003b9 	bl	9534 <_Z6concatPcPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:121
        break;
    864c:	e320f000 	nop	{0}
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:123
    }
    log(log_msg);
    8650:	e24b3048 	sub	r3, fp, #72	; 0x48
    8654:	e1a00003 	mov	r0, r3
    8658:	ebffff27 	bl	82fc <_Z3logPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:124
    return agreed_role == desired_role;
    865c:	e59f302c 	ldr	r3, [pc, #44]	; 8690 <_Z9set_roles9CI2C_Mode+0x1c0>
    8660:	e5933000 	ldr	r3, [r3]
    8664:	e51b2050 	ldr	r2, [fp, #-80]	; 0xffffffb0
    8668:	e1520003 	cmp	r2, r3
    866c:	03a03001 	moveq	r3, #1
    8670:	13a03000 	movne	r3, #0
    8674:	e6ef3073 	uxtb	r3, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:125
}
    8678:	e1a00003 	mov	r0, r3
    867c:	e24bd004 	sub	sp, fp, #4
    8680:	e8bd8800 	pop	{fp, pc}
    8684:	00009844 	andeq	r9, r0, r4, asr #16
    8688:	00009848 	andeq	r9, r0, r8, asr #16
    868c:	00009964 	andeq	r9, r0, r4, ror #18
    8690:	00009960 	andeq	r9, r0, r0, ror #18
    8694:	0000984c 	andeq	r9, r0, ip, asr #16
    8698:	00009860 	andeq	r9, r0, r0, ror #16
    869c:	00009868 	andeq	r9, r0, r8, ror #16

000086a0 <_Z11handle_datacf>:
_Z11handle_datacf():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:128

void handle_data(char value_state, float value)
{
    86a0:	e92d4800 	push	{fp, lr}
    86a4:	e28db004 	add	fp, sp, #4
    86a8:	e24dd038 	sub	sp, sp, #56	; 0x38
    86ac:	e1a03000 	mov	r3, r0
    86b0:	ed0b0a0f 	vstr	s0, [fp, #-60]	; 0xffffffc4
    86b4:	e54b3035 	strb	r3, [fp, #-53]	; 0xffffffcb
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:130
    char log_msg[32], value_str[16];
    bzero(log_msg, 32);
    86b8:	e24b3024 	sub	r3, fp, #36	; 0x24
    86bc:	e3a01020 	mov	r1, #32
    86c0:	e1a00003 	mov	r0, r3
    86c4:	eb000360 	bl	944c <_Z5bzeroPvi>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:131
    bzero(value_str, 16);
    86c8:	e24b3034 	sub	r3, fp, #52	; 0x34
    86cc:	e3a01010 	mov	r1, #16
    86d0:	e1a00003 	mov	r0, r3
    86d4:	eb00035c 	bl	944c <_Z5bzeroPvi>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:132
    strncpy(log_msg, "Received ", 10);
    86d8:	e24b3024 	sub	r3, fp, #36	; 0x24
    86dc:	e3a0200a 	mov	r2, #10
    86e0:	e59f10b8 	ldr	r1, [pc, #184]	; 87a0 <_Z11handle_datacf+0x100>
    86e4:	e1a00003 	mov	r0, r3
    86e8:	eb0002e7 	bl	928c <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:133
    ftoa(value, value_str, 2);
    86ec:	e24b3034 	sub	r3, fp, #52	; 0x34
    86f0:	e3a01002 	mov	r1, #2
    86f4:	e1a00003 	mov	r0, r3
    86f8:	ed1b0a0f 	vldr	s0, [fp, #-60]	; 0xffffffc4
    86fc:	eb00023d 	bl	8ff8 <_Z4ftoafPcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:134
    concat(log_msg, value_str);
    8700:	e24b2034 	sub	r2, fp, #52	; 0x34
    8704:	e24b3024 	sub	r3, fp, #36	; 0x24
    8708:	e1a01002 	mov	r1, r2
    870c:	e1a00003 	mov	r0, r3
    8710:	eb000387 	bl	9534 <_Z6concatPcPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:135
    switch (value_state)
    8714:	e55b3035 	ldrb	r3, [fp, #-53]	; 0xffffffcb
    8718:	e3530076 	cmp	r3, #118	; 0x76
    871c:	0a000006 	beq	873c <_Z11handle_datacf+0x9c>
    8720:	e3530076 	cmp	r3, #118	; 0x76
    8724:	ca000013 	bgt	8778 <_Z11handle_datacf+0xd8>
    8728:	e3530064 	cmp	r3, #100	; 0x64
    872c:	0a000007 	beq	8750 <_Z11handle_datacf+0xb0>
    8730:	e3530074 	cmp	r3, #116	; 0x74
    8734:	0a00000a 	beq	8764 <_Z11handle_datacf+0xc4>
    8738:	ea00000e 	b	8778 <_Z11handle_datacf+0xd8>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:139
    {
    case 'v':
        // vse v poradku
        concat(log_msg, " - OK");
    873c:	e24b3024 	sub	r3, fp, #36	; 0x24
    8740:	e59f105c 	ldr	r1, [pc, #92]	; 87a4 <_Z11handle_datacf+0x104>
    8744:	e1a00003 	mov	r0, r3
    8748:	eb000379 	bl	9534 <_Z6concatPcPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:140
        break;
    874c:	ea000009 	b	8778 <_Z11handle_datacf+0xd8>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:143
    case 'd':
        // nebezpecna hodnota
        concat(log_msg, " - DANGER");
    8750:	e24b3024 	sub	r3, fp, #36	; 0x24
    8754:	e59f104c 	ldr	r1, [pc, #76]	; 87a8 <_Z11handle_datacf+0x108>
    8758:	e1a00003 	mov	r0, r3
    875c:	eb000374 	bl	9534 <_Z6concatPcPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:144
        break;
    8760:	ea000004 	b	8778 <_Z11handle_datacf+0xd8>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:147
    case 't':
        // dalsi hodnota muze byt nebezpecna
        concat(log_msg, " - WARNING");
    8764:	e24b3024 	sub	r3, fp, #36	; 0x24
    8768:	e59f103c 	ldr	r1, [pc, #60]	; 87ac <_Z11handle_datacf+0x10c>
    876c:	e1a00003 	mov	r0, r3
    8770:	eb00036f 	bl	9534 <_Z6concatPcPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:148
        break;
    8774:	e320f000 	nop	{0}
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:151
    
    }
    concat(log_msg, "\n");
    8778:	e24b3024 	sub	r3, fp, #36	; 0x24
    877c:	e59f102c 	ldr	r1, [pc, #44]	; 87b0 <_Z11handle_datacf+0x110>
    8780:	e1a00003 	mov	r0, r3
    8784:	eb00036a 	bl	9534 <_Z6concatPcPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:152
    log(log_msg);
    8788:	e24b3024 	sub	r3, fp, #36	; 0x24
    878c:	e1a00003 	mov	r0, r3
    8790:	ebfffed9 	bl	82fc <_Z3logPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:153
}
    8794:	e320f000 	nop	{0}
    8798:	e24bd004 	sub	sp, fp, #4
    879c:	e8bd8800 	pop	{fp, pc}
    87a0:	00009870 	andeq	r9, r0, r0, ror r8
    87a4:	0000987c 	andeq	r9, r0, ip, ror r8
    87a8:	00009884 	andeq	r9, r0, r4, lsl #17
    87ac:	00009890 	muleq	r0, r0, r8
    87b0:	0000989c 	muleq	r0, ip, r8

000087b4 <_Z12receive_datav>:
_Z12receive_datav():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:156

void receive_data()
{
    87b4:	e92d4800 	push	{fp, lr}
    87b8:	e28db004 	add	fp, sp, #4
    87bc:	e24dd030 	sub	sp, sp, #48	; 0x30
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:158
    char buff[6], log_msg[32];
    bzero(buff, 6);
    87c0:	e24b300c 	sub	r3, fp, #12
    87c4:	e3a01006 	mov	r1, #6
    87c8:	e1a00003 	mov	r0, r3
    87cc:	eb00031e 	bl	944c <_Z5bzeroPvi>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:159
    bzero(log_msg, 32);
    87d0:	e24b302c 	sub	r3, fp, #44	; 0x2c
    87d4:	e3a01020 	mov	r1, #32
    87d8:	e1a00003 	mov	r0, r3
    87dc:	eb00031a 	bl	944c <_Z5bzeroPvi>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:163
    char value_state;
    float value;

    while (strlen(buff) == 0) {
    87e0:	e24b300c 	sub	r3, fp, #12
    87e4:	e1a00003 	mov	r0, r3
    87e8:	eb000302 	bl	93f8 <_Z6strlenPKc>
    87ec:	e1a03000 	mov	r3, r0
    87f0:	e3530000 	cmp	r3, #0
    87f4:	03a03001 	moveq	r3, #1
    87f8:	13a03000 	movne	r3, #0
    87fc:	e6ef3073 	uxtb	r3, r3
    8800:	e3530000 	cmp	r3, #0
    8804:	0a000009 	beq	8830 <_Z12receive_datav+0x7c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:164
        read(master, buff, 6);
    8808:	e59f3060 	ldr	r3, [pc, #96]	; 8870 <_Z12receive_datav+0xbc>
    880c:	e5933000 	ldr	r3, [r3]
    8810:	e24b100c 	sub	r1, fp, #12
    8814:	e3a02006 	mov	r2, #6
    8818:	e1a00003 	mov	r0, r3
    881c:	eb000088 	bl	8a44 <_Z4readjPcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:165
        sleep(0x100);
    8820:	e3e01001 	mvn	r1, #1
    8824:	e3a00c01 	mov	r0, #256	; 0x100
    8828:	eb0000f1 	bl	8bf4 <_Z5sleepjj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:163
    while (strlen(buff) == 0) {
    882c:	eaffffeb 	b	87e0 <_Z12receive_datav+0x2c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:168
    }

    value_state = buff[0];
    8830:	e55b300c 	ldrb	r3, [fp, #-12]
    8834:	e54b3005 	strb	r3, [fp, #-5]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:169
    memcpy(buff + 1, &value, 4);
    8838:	e24b300c 	sub	r3, fp, #12
    883c:	e2833001 	add	r3, r3, #1
    8840:	e24b1030 	sub	r1, fp, #48	; 0x30
    8844:	e3a02004 	mov	r2, #4
    8848:	e1a00003 	mov	r0, r3
    884c:	eb000318 	bl	94b4 <_Z6memcpyPKvPvi>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:171

    handle_data(value_state, value);
    8850:	ed5b7a0c 	vldr	s15, [fp, #-48]	; 0xffffffd0
    8854:	e55b3005 	ldrb	r3, [fp, #-5]
    8858:	eeb00a67 	vmov.f32	s0, s15
    885c:	e1a00003 	mov	r0, r3
    8860:	ebffff8e 	bl	86a0 <_Z11handle_datacf>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:172
}
    8864:	e320f000 	nop	{0}
    8868:	e24bd004 	sub	sp, fp, #4
    886c:	e8bd8800 	pop	{fp, pc}
    8870:	00009964 	andeq	r9, r0, r4, ror #18

00008874 <main>:
main():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:175

int main(int argc, char** argv)
{
    8874:	e92d4800 	push	{fp, lr}
    8878:	e28db004 	add	fp, sp, #4
    887c:	e24dd038 	sub	sp, sp, #56	; 0x38
    8880:	e50b0038 	str	r0, [fp, #-56]	; 0xffffffc8
    8884:	e50b103c 	str	r1, [fp, #-60]	; 0xffffffc4
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:179
    char buff[9], msg[32];
    uint32_t slave_input;

    log_fd = pipe("log", 128);
    8888:	e3a01080 	mov	r1, #128	; 0x80
    888c:	e59f00dc 	ldr	r0, [pc, #220]	; 8970 <main+0xfc>
    8890:	eb000128 	bl	8d38 <_Z4pipePKcj>
    8894:	e1a03000 	mov	r3, r0
    8898:	e59f20d4 	ldr	r2, [pc, #212]	; 8974 <main+0x100>
    889c:	e5823000 	str	r3, [r2]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:182
    // trng = open("DEV:trng/0", NFile_Open_Mode::Read_Write);

    log("Master task started\n");
    88a0:	e59f00d0 	ldr	r0, [pc, #208]	; 8978 <main+0x104>
    88a4:	ebfffe94 	bl	82fc <_Z3logPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:185

    // start i2c connection
    master = open("DEV:i2c/1", NFile_Open_Mode::Read_Write);
    88a8:	e3a01002 	mov	r1, #2
    88ac:	e59f00c8 	ldr	r0, [pc, #200]	; 897c <main+0x108>
    88b0:	eb000052 	bl	8a00 <_Z4openPKc15NFile_Open_Mode>
    88b4:	e1a03000 	mov	r3, r0
    88b8:	e59f20c0 	ldr	r2, [pc, #192]	; 8980 <main+0x10c>
    88bc:	e5823000 	str	r3, [r2]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:186
    if (master == Invalid_Handle) {
    88c0:	e59f30b8 	ldr	r3, [pc, #184]	; 8980 <main+0x10c>
    88c4:	e5933000 	ldr	r3, [r3]
    88c8:	e3730001 	cmn	r3, #1
    88cc:	1a000003 	bne	88e0 <main+0x6c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:187
        log("Error opening I2C master connection\n");
    88d0:	e59f00ac 	ldr	r0, [pc, #172]	; 8984 <main+0x110>
    88d4:	ebfffe88 	bl	82fc <_Z3logPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:188
        return 1;
    88d8:	e3a03001 	mov	r3, #1
    88dc:	ea000020 	b	8964 <main+0xf0>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:192
    }
    // set addresses
    TI2C_IOCtl_Params params;
    params.address = ADDRESS;
    88e0:	e3a03001 	mov	r3, #1
    88e4:	e54b3034 	strb	r3, [fp, #-52]	; 0xffffffcc
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:193
    params.targetAdress = TARGET_ADDRESS;
    88e8:	e3a03002 	mov	r3, #2
    88ec:	e54b3033 	strb	r3, [fp, #-51]	; 0xffffffcd
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:194
    ioctl(master, NIOCtl_Operation::Set_Params, &params);
    88f0:	e59f3088 	ldr	r3, [pc, #136]	; 8980 <main+0x10c>
    88f4:	e5933000 	ldr	r3, [r3]
    88f8:	e24b2034 	sub	r2, fp, #52	; 0x34
    88fc:	e3a01001 	mov	r1, #1
    8900:	e1a00003 	mov	r0, r3
    8904:	eb000081 	bl	8b10 <_Z5ioctlj16NIOCtl_OperationPv>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:195
    log("I2C connection master started...\n");
    8908:	e59f0078 	ldr	r0, [pc, #120]	; 8988 <main+0x114>
    890c:	ebfffe7a 	bl	82fc <_Z3logPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:197

    sleep(0x100);
    8910:	e3e01001 	mvn	r1, #1
    8914:	e3a00c01 	mov	r0, #256	; 0x100
    8918:	eb0000b5 	bl	8bf4 <_Z5sleepjj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:198
    set_roles(DESIRED_ROLE);
    891c:	e3a00000 	mov	r0, #0
    8920:	ebfffeea 	bl	84d0 <_Z9set_roles9CI2C_Mode>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:200

    sleep(0x100);
    8924:	e3e01001 	mvn	r1, #1
    8928:	e3a00c01 	mov	r0, #256	; 0x100
    892c:	eb0000b0 	bl	8bf4 <_Z5sleepjj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:202 (discriminator 1)
    for (;;) {
        bzero(msg, 32);
    8930:	e24b3030 	sub	r3, fp, #48	; 0x30
    8934:	e3a01020 	mov	r1, #32
    8938:	e1a00003 	mov	r0, r3
    893c:	eb0002c2 	bl	944c <_Z5bzeroPvi>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:203 (discriminator 1)
        bzero(buff, 9);
    8940:	e24b3010 	sub	r3, fp, #16
    8944:	e3a01009 	mov	r1, #9
    8948:	e1a00003 	mov	r0, r3
    894c:	eb0002be 	bl	944c <_Z5bzeroPvi>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:204 (discriminator 1)
        receive_data();
    8950:	ebffff97 	bl	87b4 <_Z12receive_datav>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:211 (discriminator 1)
        // strncpy(msg, "Received: ", 10);
        // concat(msg, buff);
        // concat(msg, "\n");
        // log(msg);
        // log("Data sent from master\n");
        sleep(0x15000);
    8954:	e3e01001 	mvn	r1, #1
    8958:	e3a00a15 	mov	r0, #86016	; 0x15000
    895c:	eb0000a4 	bl	8bf4 <_Z5sleepjj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:202 (discriminator 1)
        bzero(msg, 32);
    8960:	eafffff2 	b	8930 <main+0xbc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:219 (discriminator 1)
    close(master);
    log("Open files closed in master\n");
    close(log_fd);

    return 0;
}
    8964:	e1a00003 	mov	r0, r3
    8968:	e24bd004 	sub	sp, fp, #4
    896c:	e8bd8800 	pop	{fp, pc}
    8970:	000098a0 	andeq	r9, r0, r0, lsr #17
    8974:	00009968 	andeq	r9, r0, r8, ror #18
    8978:	000098a4 	andeq	r9, r0, r4, lsr #17
    897c:	000098bc 			; <UNDEFINED> instruction: 0x000098bc
    8980:	00009964 	andeq	r9, r0, r4, ror #18
    8984:	000098c8 	andeq	r9, r0, r8, asr #17
    8988:	000098f0 	strdeq	r9, [r0], -r0

0000898c <_Z6getpidv>:
_Z6getpidv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:5
#include <stdfile.h>
#include <stdstring.h>

uint32_t getpid()
{
    898c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8990:	e28db000 	add	fp, sp, #0
    8994:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:8
    uint32_t pid;

    asm volatile("swi 0");
    8998:	ef000000 	svc	0x00000000
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:9
    asm volatile("mov %0, r0" : "=r" (pid));
    899c:	e1a03000 	mov	r3, r0
    89a0:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:11

    return pid;
    89a4:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:12
}
    89a8:	e1a00003 	mov	r0, r3
    89ac:	e28bd000 	add	sp, fp, #0
    89b0:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    89b4:	e12fff1e 	bx	lr

000089b8 <_Z9terminatei>:
_Z9terminatei():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:15

void terminate(int exitcode)
{
    89b8:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    89bc:	e28db000 	add	fp, sp, #0
    89c0:	e24dd00c 	sub	sp, sp, #12
    89c4:	e50b0008 	str	r0, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:16
    asm volatile("mov r0, %0" : : "r" (exitcode));
    89c8:	e51b3008 	ldr	r3, [fp, #-8]
    89cc:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:17
    asm volatile("swi 1");
    89d0:	ef000001 	svc	0x00000001
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:18
}
    89d4:	e320f000 	nop	{0}
    89d8:	e28bd000 	add	sp, fp, #0
    89dc:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    89e0:	e12fff1e 	bx	lr

000089e4 <_Z11sched_yieldv>:
_Z11sched_yieldv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:21

void sched_yield()
{
    89e4:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    89e8:	e28db000 	add	fp, sp, #0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:22
    asm volatile("swi 2");
    89ec:	ef000002 	svc	0x00000002
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:23
}
    89f0:	e320f000 	nop	{0}
    89f4:	e28bd000 	add	sp, fp, #0
    89f8:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    89fc:	e12fff1e 	bx	lr

00008a00 <_Z4openPKc15NFile_Open_Mode>:
_Z4openPKc15NFile_Open_Mode():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:26

uint32_t open(const char* filename, NFile_Open_Mode mode)
{
    8a00:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8a04:	e28db000 	add	fp, sp, #0
    8a08:	e24dd014 	sub	sp, sp, #20
    8a0c:	e50b0010 	str	r0, [fp, #-16]
    8a10:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:29
    uint32_t file;

    asm volatile("mov r0, %0" : : "r" (filename));
    8a14:	e51b3010 	ldr	r3, [fp, #-16]
    8a18:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:30
    asm volatile("mov r1, %0" : : "r" (mode));
    8a1c:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8a20:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:31
    asm volatile("swi 64");
    8a24:	ef000040 	svc	0x00000040
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:32
    asm volatile("mov %0, r0" : "=r" (file));
    8a28:	e1a03000 	mov	r3, r0
    8a2c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:33
    return file;
    8a30:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:34
}
    8a34:	e1a00003 	mov	r0, r3
    8a38:	e28bd000 	add	sp, fp, #0
    8a3c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8a40:	e12fff1e 	bx	lr

00008a44 <_Z4readjPcj>:
_Z4readjPcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:37

uint32_t read(uint32_t file, char* const buffer, uint32_t size)
{
    8a44:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8a48:	e28db000 	add	fp, sp, #0
    8a4c:	e24dd01c 	sub	sp, sp, #28
    8a50:	e50b0010 	str	r0, [fp, #-16]
    8a54:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8a58:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:40
    uint32_t rdnum;

    asm volatile("mov r0, %0" : : "r" (file));
    8a5c:	e51b3010 	ldr	r3, [fp, #-16]
    8a60:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:41
    asm volatile("mov r1, %0" : : "r" (buffer));
    8a64:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8a68:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:42
    asm volatile("mov r2, %0" : : "r" (size));
    8a6c:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8a70:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:43
    asm volatile("swi 65");
    8a74:	ef000041 	svc	0x00000041
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:44
    asm volatile("mov %0, r0" : "=r" (rdnum));
    8a78:	e1a03000 	mov	r3, r0
    8a7c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:46

    return rdnum;
    8a80:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:47
}
    8a84:	e1a00003 	mov	r0, r3
    8a88:	e28bd000 	add	sp, fp, #0
    8a8c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8a90:	e12fff1e 	bx	lr

00008a94 <_Z5writejPKcj>:
_Z5writejPKcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:50

uint32_t write(uint32_t file, const char* buffer, uint32_t size)
{
    8a94:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8a98:	e28db000 	add	fp, sp, #0
    8a9c:	e24dd01c 	sub	sp, sp, #28
    8aa0:	e50b0010 	str	r0, [fp, #-16]
    8aa4:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8aa8:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:53
    uint32_t wrnum;

    asm volatile("mov r0, %0" : : "r" (file));
    8aac:	e51b3010 	ldr	r3, [fp, #-16]
    8ab0:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:54
    asm volatile("mov r1, %0" : : "r" (buffer));
    8ab4:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8ab8:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:55
    asm volatile("mov r2, %0" : : "r" (size));
    8abc:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8ac0:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:56
    asm volatile("swi 66");
    8ac4:	ef000042 	svc	0x00000042
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:57
    asm volatile("mov %0, r0" : "=r" (wrnum));
    8ac8:	e1a03000 	mov	r3, r0
    8acc:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:59

    return wrnum;
    8ad0:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:60
}
    8ad4:	e1a00003 	mov	r0, r3
    8ad8:	e28bd000 	add	sp, fp, #0
    8adc:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8ae0:	e12fff1e 	bx	lr

00008ae4 <_Z5closej>:
_Z5closej():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:63

void close(uint32_t file)
{
    8ae4:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8ae8:	e28db000 	add	fp, sp, #0
    8aec:	e24dd00c 	sub	sp, sp, #12
    8af0:	e50b0008 	str	r0, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:64
    asm volatile("mov r0, %0" : : "r" (file));
    8af4:	e51b3008 	ldr	r3, [fp, #-8]
    8af8:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:65
    asm volatile("swi 67");
    8afc:	ef000043 	svc	0x00000043
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:66
}
    8b00:	e320f000 	nop	{0}
    8b04:	e28bd000 	add	sp, fp, #0
    8b08:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8b0c:	e12fff1e 	bx	lr

00008b10 <_Z5ioctlj16NIOCtl_OperationPv>:
_Z5ioctlj16NIOCtl_OperationPv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:69

uint32_t ioctl(uint32_t file, NIOCtl_Operation operation, void* param)
{
    8b10:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8b14:	e28db000 	add	fp, sp, #0
    8b18:	e24dd01c 	sub	sp, sp, #28
    8b1c:	e50b0010 	str	r0, [fp, #-16]
    8b20:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8b24:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:72
    uint32_t retcode;

    asm volatile("mov r0, %0" : : "r" (file));
    8b28:	e51b3010 	ldr	r3, [fp, #-16]
    8b2c:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:73
    asm volatile("mov r1, %0" : : "r" (operation));
    8b30:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8b34:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:74
    asm volatile("mov r2, %0" : : "r" (param));
    8b38:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8b3c:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:75
    asm volatile("swi 68");
    8b40:	ef000044 	svc	0x00000044
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:76
    asm volatile("mov %0, r0" : "=r" (retcode));
    8b44:	e1a03000 	mov	r3, r0
    8b48:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:78

    return retcode;
    8b4c:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:79
}
    8b50:	e1a00003 	mov	r0, r3
    8b54:	e28bd000 	add	sp, fp, #0
    8b58:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8b5c:	e12fff1e 	bx	lr

00008b60 <_Z6notifyjj>:
_Z6notifyjj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:82

uint32_t notify(uint32_t file, uint32_t count)
{
    8b60:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8b64:	e28db000 	add	fp, sp, #0
    8b68:	e24dd014 	sub	sp, sp, #20
    8b6c:	e50b0010 	str	r0, [fp, #-16]
    8b70:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:85
    uint32_t retcnt;

    asm volatile("mov r0, %0" : : "r" (file));
    8b74:	e51b3010 	ldr	r3, [fp, #-16]
    8b78:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:86
    asm volatile("mov r1, %0" : : "r" (count));
    8b7c:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8b80:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:87
    asm volatile("swi 69");
    8b84:	ef000045 	svc	0x00000045
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:88
    asm volatile("mov %0, r0" : "=r" (retcnt));
    8b88:	e1a03000 	mov	r3, r0
    8b8c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:90

    return retcnt;
    8b90:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:91
}
    8b94:	e1a00003 	mov	r0, r3
    8b98:	e28bd000 	add	sp, fp, #0
    8b9c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8ba0:	e12fff1e 	bx	lr

00008ba4 <_Z4waitjjj>:
_Z4waitjjj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:94

NSWI_Result_Code wait(uint32_t file, uint32_t count, uint32_t notified_deadline)
{
    8ba4:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8ba8:	e28db000 	add	fp, sp, #0
    8bac:	e24dd01c 	sub	sp, sp, #28
    8bb0:	e50b0010 	str	r0, [fp, #-16]
    8bb4:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8bb8:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:97
    NSWI_Result_Code retcode;

    asm volatile("mov r0, %0" : : "r" (file));
    8bbc:	e51b3010 	ldr	r3, [fp, #-16]
    8bc0:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:98
    asm volatile("mov r1, %0" : : "r" (count));
    8bc4:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8bc8:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:99
    asm volatile("mov r2, %0" : : "r" (notified_deadline));
    8bcc:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8bd0:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:100
    asm volatile("swi 70");
    8bd4:	ef000046 	svc	0x00000046
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:101
    asm volatile("mov %0, r0" : "=r" (retcode));
    8bd8:	e1a03000 	mov	r3, r0
    8bdc:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:103

    return retcode;
    8be0:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:104
}
    8be4:	e1a00003 	mov	r0, r3
    8be8:	e28bd000 	add	sp, fp, #0
    8bec:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8bf0:	e12fff1e 	bx	lr

00008bf4 <_Z5sleepjj>:
_Z5sleepjj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:107

bool sleep(uint32_t ticks, uint32_t notified_deadline)
{
    8bf4:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8bf8:	e28db000 	add	fp, sp, #0
    8bfc:	e24dd014 	sub	sp, sp, #20
    8c00:	e50b0010 	str	r0, [fp, #-16]
    8c04:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:110
    uint32_t retcode;

    asm volatile("mov r0, %0" : : "r" (ticks));
    8c08:	e51b3010 	ldr	r3, [fp, #-16]
    8c0c:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:111
    asm volatile("mov r1, %0" : : "r" (notified_deadline));
    8c10:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8c14:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:112
    asm volatile("swi 3");
    8c18:	ef000003 	svc	0x00000003
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:113
    asm volatile("mov %0, r0" : "=r" (retcode));
    8c1c:	e1a03000 	mov	r3, r0
    8c20:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:115

    return retcode;
    8c24:	e51b3008 	ldr	r3, [fp, #-8]
    8c28:	e3530000 	cmp	r3, #0
    8c2c:	13a03001 	movne	r3, #1
    8c30:	03a03000 	moveq	r3, #0
    8c34:	e6ef3073 	uxtb	r3, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:116
}
    8c38:	e1a00003 	mov	r0, r3
    8c3c:	e28bd000 	add	sp, fp, #0
    8c40:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8c44:	e12fff1e 	bx	lr

00008c48 <_Z24get_active_process_countv>:
_Z24get_active_process_countv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:119

uint32_t get_active_process_count()
{
    8c48:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8c4c:	e28db000 	add	fp, sp, #0
    8c50:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:120
    const NGet_Sched_Info_Type req = NGet_Sched_Info_Type::Active_Process_Count;
    8c54:	e3a03000 	mov	r3, #0
    8c58:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:123
    uint32_t retval;

    asm volatile("mov r0, %0" : : "r" (req));
    8c5c:	e3a03000 	mov	r3, #0
    8c60:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:124
    asm volatile("mov r1, %0" : : "r" (&retval));
    8c64:	e24b300c 	sub	r3, fp, #12
    8c68:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:125
    asm volatile("swi 4");
    8c6c:	ef000004 	svc	0x00000004
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:127

    return retval;
    8c70:	e51b300c 	ldr	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:128
}
    8c74:	e1a00003 	mov	r0, r3
    8c78:	e28bd000 	add	sp, fp, #0
    8c7c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8c80:	e12fff1e 	bx	lr

00008c84 <_Z14get_tick_countv>:
_Z14get_tick_countv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:131

uint32_t get_tick_count()
{
    8c84:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8c88:	e28db000 	add	fp, sp, #0
    8c8c:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:132
    const NGet_Sched_Info_Type req = NGet_Sched_Info_Type::Tick_Count;
    8c90:	e3a03001 	mov	r3, #1
    8c94:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:135
    uint32_t retval;

    asm volatile("mov r0, %0" : : "r" (req));
    8c98:	e3a03001 	mov	r3, #1
    8c9c:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:136
    asm volatile("mov r1, %0" : : "r" (&retval));
    8ca0:	e24b300c 	sub	r3, fp, #12
    8ca4:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:137
    asm volatile("swi 4");
    8ca8:	ef000004 	svc	0x00000004
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:139

    return retval;
    8cac:	e51b300c 	ldr	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:140
}
    8cb0:	e1a00003 	mov	r0, r3
    8cb4:	e28bd000 	add	sp, fp, #0
    8cb8:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8cbc:	e12fff1e 	bx	lr

00008cc0 <_Z17set_task_deadlinej>:
_Z17set_task_deadlinej():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:143

void set_task_deadline(uint32_t tick_count_required)
{
    8cc0:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8cc4:	e28db000 	add	fp, sp, #0
    8cc8:	e24dd014 	sub	sp, sp, #20
    8ccc:	e50b0010 	str	r0, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:144
    const NDeadline_Subservice req = NDeadline_Subservice::Set_Relative;
    8cd0:	e3a03000 	mov	r3, #0
    8cd4:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:146

    asm volatile("mov r0, %0" : : "r" (req));
    8cd8:	e3a03000 	mov	r3, #0
    8cdc:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:147
    asm volatile("mov r1, %0" : : "r" (&tick_count_required));
    8ce0:	e24b3010 	sub	r3, fp, #16
    8ce4:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:148
    asm volatile("swi 5");
    8ce8:	ef000005 	svc	0x00000005
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:149
}
    8cec:	e320f000 	nop	{0}
    8cf0:	e28bd000 	add	sp, fp, #0
    8cf4:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8cf8:	e12fff1e 	bx	lr

00008cfc <_Z26get_task_ticks_to_deadlinev>:
_Z26get_task_ticks_to_deadlinev():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:152

uint32_t get_task_ticks_to_deadline()
{
    8cfc:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8d00:	e28db000 	add	fp, sp, #0
    8d04:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:153
    const NDeadline_Subservice req = NDeadline_Subservice::Get_Remaining;
    8d08:	e3a03001 	mov	r3, #1
    8d0c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:156
    uint32_t ticks;

    asm volatile("mov r0, %0" : : "r" (req));
    8d10:	e3a03001 	mov	r3, #1
    8d14:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:157
    asm volatile("mov r1, %0" : : "r" (&ticks));
    8d18:	e24b300c 	sub	r3, fp, #12
    8d1c:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:158
    asm volatile("swi 5");
    8d20:	ef000005 	svc	0x00000005
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:160

    return ticks;
    8d24:	e51b300c 	ldr	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:161
}
    8d28:	e1a00003 	mov	r0, r3
    8d2c:	e28bd000 	add	sp, fp, #0
    8d30:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8d34:	e12fff1e 	bx	lr

00008d38 <_Z4pipePKcj>:
_Z4pipePKcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:166

const char Pipe_File_Prefix[] = "SYS:pipe/";

uint32_t pipe(const char* name, uint32_t buf_size)
{
    8d38:	e92d4800 	push	{fp, lr}
    8d3c:	e28db004 	add	fp, sp, #4
    8d40:	e24dd050 	sub	sp, sp, #80	; 0x50
    8d44:	e50b0050 	str	r0, [fp, #-80]	; 0xffffffb0
    8d48:	e50b1054 	str	r1, [fp, #-84]	; 0xffffffac
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:168
    char fname[64];
    strncpy(fname, Pipe_File_Prefix, sizeof(Pipe_File_Prefix));
    8d4c:	e24b3048 	sub	r3, fp, #72	; 0x48
    8d50:	e3a0200a 	mov	r2, #10
    8d54:	e59f1088 	ldr	r1, [pc, #136]	; 8de4 <_Z4pipePKcj+0xac>
    8d58:	e1a00003 	mov	r0, r3
    8d5c:	eb00014a 	bl	928c <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:169
    strncpy(fname + sizeof(Pipe_File_Prefix), name, sizeof(fname) - sizeof(Pipe_File_Prefix) - 1);
    8d60:	e24b3048 	sub	r3, fp, #72	; 0x48
    8d64:	e283300a 	add	r3, r3, #10
    8d68:	e3a02035 	mov	r2, #53	; 0x35
    8d6c:	e51b1050 	ldr	r1, [fp, #-80]	; 0xffffffb0
    8d70:	e1a00003 	mov	r0, r3
    8d74:	eb000144 	bl	928c <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:171

    int ncur = sizeof(Pipe_File_Prefix) + strlen(name);
    8d78:	e51b0050 	ldr	r0, [fp, #-80]	; 0xffffffb0
    8d7c:	eb00019d 	bl	93f8 <_Z6strlenPKc>
    8d80:	e1a03000 	mov	r3, r0
    8d84:	e283300a 	add	r3, r3, #10
    8d88:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:173

    fname[ncur++] = '#';
    8d8c:	e51b3008 	ldr	r3, [fp, #-8]
    8d90:	e2832001 	add	r2, r3, #1
    8d94:	e50b2008 	str	r2, [fp, #-8]
    8d98:	e2433004 	sub	r3, r3, #4
    8d9c:	e083300b 	add	r3, r3, fp
    8da0:	e3a02023 	mov	r2, #35	; 0x23
    8da4:	e5432044 	strb	r2, [r3, #-68]	; 0xffffffbc
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:175

    itoa(buf_size, &fname[ncur], 10);
    8da8:	e24b2048 	sub	r2, fp, #72	; 0x48
    8dac:	e51b3008 	ldr	r3, [fp, #-8]
    8db0:	e0823003 	add	r3, r2, r3
    8db4:	e3a0200a 	mov	r2, #10
    8db8:	e1a01003 	mov	r1, r3
    8dbc:	e51b0054 	ldr	r0, [fp, #-84]	; 0xffffffac
    8dc0:	eb000008 	bl	8de8 <_Z4itoajPcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:177

    return open(fname, NFile_Open_Mode::Read_Write);
    8dc4:	e24b3048 	sub	r3, fp, #72	; 0x48
    8dc8:	e3a01002 	mov	r1, #2
    8dcc:	e1a00003 	mov	r0, r3
    8dd0:	ebffff0a 	bl	8a00 <_Z4openPKc15NFile_Open_Mode>
    8dd4:	e1a03000 	mov	r3, r0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:178
}
    8dd8:	e1a00003 	mov	r0, r3
    8ddc:	e24bd004 	sub	sp, fp, #4
    8de0:	e8bd8800 	pop	{fp, pc}
    8de4:	00009940 	andeq	r9, r0, r0, asr #18

00008de8 <_Z4itoajPcj>:
_Z4itoajPcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:9
{
    const char CharConvArr[] = "0123456789ABCDEF";
}

void itoa(unsigned int input, char* output, unsigned int base)
{
    8de8:	e92d4800 	push	{fp, lr}
    8dec:	e28db004 	add	fp, sp, #4
    8df0:	e24dd020 	sub	sp, sp, #32
    8df4:	e50b0018 	str	r0, [fp, #-24]	; 0xffffffe8
    8df8:	e50b101c 	str	r1, [fp, #-28]	; 0xffffffe4
    8dfc:	e50b2020 	str	r2, [fp, #-32]	; 0xffffffe0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:10
	int i = 0;
    8e00:	e3a03000 	mov	r3, #0
    8e04:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:12

	while (input > 0)
    8e08:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8e0c:	e3530000 	cmp	r3, #0
    8e10:	0a000014 	beq	8e68 <_Z4itoajPcj+0x80>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:14
	{
		output[i] = CharConvArr[input % base];
    8e14:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8e18:	e51b1020 	ldr	r1, [fp, #-32]	; 0xffffffe0
    8e1c:	e1a00003 	mov	r0, r3
    8e20:	eb00025b 	bl	9794 <__aeabi_uidivmod>
    8e24:	e1a03001 	mov	r3, r1
    8e28:	e1a01003 	mov	r1, r3
    8e2c:	e51b3008 	ldr	r3, [fp, #-8]
    8e30:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    8e34:	e0823003 	add	r3, r2, r3
    8e38:	e59f2118 	ldr	r2, [pc, #280]	; 8f58 <_Z4itoajPcj+0x170>
    8e3c:	e7d22001 	ldrb	r2, [r2, r1]
    8e40:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:15
		input /= base;
    8e44:	e51b1020 	ldr	r1, [fp, #-32]	; 0xffffffe0
    8e48:	e51b0018 	ldr	r0, [fp, #-24]	; 0xffffffe8
    8e4c:	eb0001d5 	bl	95a8 <__udivsi3>
    8e50:	e1a03000 	mov	r3, r0
    8e54:	e50b3018 	str	r3, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:16
		i++;
    8e58:	e51b3008 	ldr	r3, [fp, #-8]
    8e5c:	e2833001 	add	r3, r3, #1
    8e60:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:12
	while (input > 0)
    8e64:	eaffffe7 	b	8e08 <_Z4itoajPcj+0x20>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:19
	}

    if (i == 0)
    8e68:	e51b3008 	ldr	r3, [fp, #-8]
    8e6c:	e3530000 	cmp	r3, #0
    8e70:	1a000007 	bne	8e94 <_Z4itoajPcj+0xac>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:21
    {
        output[i] = CharConvArr[0];
    8e74:	e51b3008 	ldr	r3, [fp, #-8]
    8e78:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    8e7c:	e0823003 	add	r3, r2, r3
    8e80:	e3a02030 	mov	r2, #48	; 0x30
    8e84:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:22
        i++;
    8e88:	e51b3008 	ldr	r3, [fp, #-8]
    8e8c:	e2833001 	add	r3, r3, #1
    8e90:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:25
    }

	output[i] = '\0';
    8e94:	e51b3008 	ldr	r3, [fp, #-8]
    8e98:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    8e9c:	e0823003 	add	r3, r2, r3
    8ea0:	e3a02000 	mov	r2, #0
    8ea4:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:26
	i--;
    8ea8:	e51b3008 	ldr	r3, [fp, #-8]
    8eac:	e2433001 	sub	r3, r3, #1
    8eb0:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:28

	for (int j = 0; j <= i/2; j++)
    8eb4:	e3a03000 	mov	r3, #0
    8eb8:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:28 (discriminator 3)
    8ebc:	e51b3008 	ldr	r3, [fp, #-8]
    8ec0:	e1a02fa3 	lsr	r2, r3, #31
    8ec4:	e0823003 	add	r3, r2, r3
    8ec8:	e1a030c3 	asr	r3, r3, #1
    8ecc:	e1a02003 	mov	r2, r3
    8ed0:	e51b300c 	ldr	r3, [fp, #-12]
    8ed4:	e1530002 	cmp	r3, r2
    8ed8:	ca00001b 	bgt	8f4c <_Z4itoajPcj+0x164>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:30 (discriminator 2)
	{
		char c = output[i - j];
    8edc:	e51b2008 	ldr	r2, [fp, #-8]
    8ee0:	e51b300c 	ldr	r3, [fp, #-12]
    8ee4:	e0423003 	sub	r3, r2, r3
    8ee8:	e1a02003 	mov	r2, r3
    8eec:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    8ef0:	e0833002 	add	r3, r3, r2
    8ef4:	e5d33000 	ldrb	r3, [r3]
    8ef8:	e54b300d 	strb	r3, [fp, #-13]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:31 (discriminator 2)
		output[i - j] = output[j];
    8efc:	e51b300c 	ldr	r3, [fp, #-12]
    8f00:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    8f04:	e0822003 	add	r2, r2, r3
    8f08:	e51b1008 	ldr	r1, [fp, #-8]
    8f0c:	e51b300c 	ldr	r3, [fp, #-12]
    8f10:	e0413003 	sub	r3, r1, r3
    8f14:	e1a01003 	mov	r1, r3
    8f18:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    8f1c:	e0833001 	add	r3, r3, r1
    8f20:	e5d22000 	ldrb	r2, [r2]
    8f24:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:32 (discriminator 2)
		output[j] = c;
    8f28:	e51b300c 	ldr	r3, [fp, #-12]
    8f2c:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    8f30:	e0823003 	add	r3, r2, r3
    8f34:	e55b200d 	ldrb	r2, [fp, #-13]
    8f38:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:28 (discriminator 2)
	for (int j = 0; j <= i/2; j++)
    8f3c:	e51b300c 	ldr	r3, [fp, #-12]
    8f40:	e2833001 	add	r3, r3, #1
    8f44:	e50b300c 	str	r3, [fp, #-12]
    8f48:	eaffffdb 	b	8ebc <_Z4itoajPcj+0xd4>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:34
	}
}
    8f4c:	e320f000 	nop	{0}
    8f50:	e24bd004 	sub	sp, fp, #4
    8f54:	e8bd8800 	pop	{fp, pc}
    8f58:	0000994c 	andeq	r9, r0, ip, asr #18

00008f5c <_Z4atoiPKc>:
_Z4atoiPKc():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:37

int atoi(const char* input)
{
    8f5c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8f60:	e28db000 	add	fp, sp, #0
    8f64:	e24dd014 	sub	sp, sp, #20
    8f68:	e50b0010 	str	r0, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:38
	int output = 0;
    8f6c:	e3a03000 	mov	r3, #0
    8f70:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:40

	while (*input != '\0')
    8f74:	e51b3010 	ldr	r3, [fp, #-16]
    8f78:	e5d33000 	ldrb	r3, [r3]
    8f7c:	e3530000 	cmp	r3, #0
    8f80:	0a000017 	beq	8fe4 <_Z4atoiPKc+0x88>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:42
	{
		output *= 10;
    8f84:	e51b2008 	ldr	r2, [fp, #-8]
    8f88:	e1a03002 	mov	r3, r2
    8f8c:	e1a03103 	lsl	r3, r3, #2
    8f90:	e0833002 	add	r3, r3, r2
    8f94:	e1a03083 	lsl	r3, r3, #1
    8f98:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:43
		if (*input > '9' || *input < '0')
    8f9c:	e51b3010 	ldr	r3, [fp, #-16]
    8fa0:	e5d33000 	ldrb	r3, [r3]
    8fa4:	e3530039 	cmp	r3, #57	; 0x39
    8fa8:	8a00000d 	bhi	8fe4 <_Z4atoiPKc+0x88>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:43 (discriminator 1)
    8fac:	e51b3010 	ldr	r3, [fp, #-16]
    8fb0:	e5d33000 	ldrb	r3, [r3]
    8fb4:	e353002f 	cmp	r3, #47	; 0x2f
    8fb8:	9a000009 	bls	8fe4 <_Z4atoiPKc+0x88>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:46
			break;

		output += *input - '0';
    8fbc:	e51b3010 	ldr	r3, [fp, #-16]
    8fc0:	e5d33000 	ldrb	r3, [r3]
    8fc4:	e2433030 	sub	r3, r3, #48	; 0x30
    8fc8:	e51b2008 	ldr	r2, [fp, #-8]
    8fcc:	e0823003 	add	r3, r2, r3
    8fd0:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:48

		input++;
    8fd4:	e51b3010 	ldr	r3, [fp, #-16]
    8fd8:	e2833001 	add	r3, r3, #1
    8fdc:	e50b3010 	str	r3, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:40
	while (*input != '\0')
    8fe0:	eaffffe3 	b	8f74 <_Z4atoiPKc+0x18>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:51
	}

	return output;
    8fe4:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:52
}
    8fe8:	e1a00003 	mov	r0, r3
    8fec:	e28bd000 	add	sp, fp, #0
    8ff0:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8ff4:	e12fff1e 	bx	lr

00008ff8 <_Z4ftoafPcj>:
_Z4ftoafPcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:55

char* ftoa(float input, char* output, unsigned int decimal_places)
{
    8ff8:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8ffc:	e28db000 	add	fp, sp, #0
    9000:	e24dd03c 	sub	sp, sp, #60	; 0x3c
    9004:	ed0b0a0c 	vstr	s0, [fp, #-48]	; 0xffffffd0
    9008:	e50b0034 	str	r0, [fp, #-52]	; 0xffffffcc
    900c:	e50b1038 	str	r1, [fp, #-56]	; 0xffffffc8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:56
	char* ptr = output;
    9010:	e51b3034 	ldr	r3, [fp, #-52]	; 0xffffffcc
    9014:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:59

    // Handle negative numbers
    if (input < 0) {
    9018:	ed5b7a0c 	vldr	s15, [fp, #-48]	; 0xffffffd0
    901c:	eef57ac0 	vcmpe.f32	s15, #0.0
    9020:	eef1fa10 	vmrs	APSR_nzcv, fpscr
    9024:	5a000007 	bpl	9048 <_Z4ftoafPcj+0x50>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:60
        *ptr++ = '-';
    9028:	e51b3008 	ldr	r3, [fp, #-8]
    902c:	e2832001 	add	r2, r3, #1
    9030:	e50b2008 	str	r2, [fp, #-8]
    9034:	e3a0202d 	mov	r2, #45	; 0x2d
    9038:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:61
        input = -input;
    903c:	ed5b7a0c 	vldr	s15, [fp, #-48]	; 0xffffffd0
    9040:	eef17a67 	vneg.f32	s15, s15
    9044:	ed4b7a0c 	vstr	s15, [fp, #-48]	; 0xffffffd0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:65
    }

    // Extract the integer part
    int int_part = (int)input;
    9048:	ed5b7a0c 	vldr	s15, [fp, #-48]	; 0xffffffd0
    904c:	eefd7ae7 	vcvt.s32.f32	s15, s15
    9050:	ee173a90 	vmov	r3, s15
    9054:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:66
    float fraction = input - int_part;
    9058:	e51b300c 	ldr	r3, [fp, #-12]
    905c:	ee073a90 	vmov	s15, r3
    9060:	eef87ae7 	vcvt.f32.s32	s15, s15
    9064:	ed1b7a0c 	vldr	s14, [fp, #-48]	; 0xffffffd0
    9068:	ee777a67 	vsub.f32	s15, s14, s15
    906c:	ed4b7a04 	vstr	s15, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:70

    // Convert the integer part to a string
    char int_str[12]; // Temporary buffer for the integer part
    char* int_ptr = int_str;
    9070:	e24b302c 	sub	r3, fp, #44	; 0x2c
    9074:	e50b3014 	str	r3, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:71
    if (int_part == 0) {
    9078:	e51b300c 	ldr	r3, [fp, #-12]
    907c:	e3530000 	cmp	r3, #0
    9080:	1a000005 	bne	909c <_Z4ftoafPcj+0xa4>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:72
        *int_ptr++ = '0';
    9084:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    9088:	e2832001 	add	r2, r3, #1
    908c:	e50b2014 	str	r2, [fp, #-20]	; 0xffffffec
    9090:	e3a02030 	mov	r2, #48	; 0x30
    9094:	e5c32000 	strb	r2, [r3]
    9098:	ea00001c 	b	9110 <_Z4ftoafPcj+0x118>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:74
    } else {
        while (int_part > 0) {
    909c:	e51b300c 	ldr	r3, [fp, #-12]
    90a0:	e3530000 	cmp	r3, #0
    90a4:	da000019 	ble	9110 <_Z4ftoafPcj+0x118>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:75
            *int_ptr++ = '0' + (int_part % 10);
    90a8:	e51b200c 	ldr	r2, [fp, #-12]
    90ac:	e59f31d4 	ldr	r3, [pc, #468]	; 9288 <_Z4ftoafPcj+0x290>
    90b0:	e0c31293 	smull	r1, r3, r3, r2
    90b4:	e1a01143 	asr	r1, r3, #2
    90b8:	e1a03fc2 	asr	r3, r2, #31
    90bc:	e0411003 	sub	r1, r1, r3
    90c0:	e1a03001 	mov	r3, r1
    90c4:	e1a03103 	lsl	r3, r3, #2
    90c8:	e0833001 	add	r3, r3, r1
    90cc:	e1a03083 	lsl	r3, r3, #1
    90d0:	e0421003 	sub	r1, r2, r3
    90d4:	e6ef2071 	uxtb	r2, r1
    90d8:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    90dc:	e2831001 	add	r1, r3, #1
    90e0:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    90e4:	e2822030 	add	r2, r2, #48	; 0x30
    90e8:	e6ef2072 	uxtb	r2, r2
    90ec:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:76
            int_part /= 10;
    90f0:	e51b300c 	ldr	r3, [fp, #-12]
    90f4:	e59f218c 	ldr	r2, [pc, #396]	; 9288 <_Z4ftoafPcj+0x290>
    90f8:	e0c21392 	smull	r1, r2, r2, r3
    90fc:	e1a02142 	asr	r2, r2, #2
    9100:	e1a03fc3 	asr	r3, r3, #31
    9104:	e0423003 	sub	r3, r2, r3
    9108:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:74
        while (int_part > 0) {
    910c:	eaffffe2 	b	909c <_Z4ftoafPcj+0xa4>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:81
        }
    }

    // Reverse the integer part string and write to buffer
    while (int_ptr != int_str) {
    9110:	e24b302c 	sub	r3, fp, #44	; 0x2c
    9114:	e51b2014 	ldr	r2, [fp, #-20]	; 0xffffffec
    9118:	e1520003 	cmp	r2, r3
    911c:	0a000009 	beq	9148 <_Z4ftoafPcj+0x150>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:82
        *ptr++ = *(--int_ptr);
    9120:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    9124:	e2433001 	sub	r3, r3, #1
    9128:	e50b3014 	str	r3, [fp, #-20]	; 0xffffffec
    912c:	e51b3008 	ldr	r3, [fp, #-8]
    9130:	e2832001 	add	r2, r3, #1
    9134:	e50b2008 	str	r2, [fp, #-8]
    9138:	e51b2014 	ldr	r2, [fp, #-20]	; 0xffffffec
    913c:	e5d22000 	ldrb	r2, [r2]
    9140:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:81
    while (int_ptr != int_str) {
    9144:	eafffff1 	b	9110 <_Z4ftoafPcj+0x118>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:86
    }

    // Add the decimal point
    if (decimal_places > 0) {
    9148:	e51b3038 	ldr	r3, [fp, #-56]	; 0xffffffc8
    914c:	e3530000 	cmp	r3, #0
    9150:	0a000004 	beq	9168 <_Z4ftoafPcj+0x170>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:87
        *ptr++ = '.';
    9154:	e51b3008 	ldr	r3, [fp, #-8]
    9158:	e2832001 	add	r2, r3, #1
    915c:	e50b2008 	str	r2, [fp, #-8]
    9160:	e3a0202e 	mov	r2, #46	; 0x2e
    9164:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:91
    }

    // Convert the fractional part to the specified number of decimal places
    for (int i = 0; i < decimal_places; i++) {
    9168:	e3a03000 	mov	r3, #0
    916c:	e50b3018 	str	r3, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:91 (discriminator 3)
    9170:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    9174:	e51b2038 	ldr	r2, [fp, #-56]	; 0xffffffc8
    9178:	e1520003 	cmp	r2, r3
    917c:	9a000019 	bls	91e8 <_Z4ftoafPcj+0x1f0>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:92 (discriminator 2)
        fraction *= 10;
    9180:	ed5b7a04 	vldr	s15, [fp, #-16]
    9184:	ed9f7a3e 	vldr	s14, [pc, #248]	; 9284 <_Z4ftoafPcj+0x28c>
    9188:	ee677a87 	vmul.f32	s15, s15, s14
    918c:	ed4b7a04 	vstr	s15, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:93 (discriminator 2)
        int digit = (int)fraction;
    9190:	ed5b7a04 	vldr	s15, [fp, #-16]
    9194:	eefd7ae7 	vcvt.s32.f32	s15, s15
    9198:	ee173a90 	vmov	r3, s15
    919c:	e50b3020 	str	r3, [fp, #-32]	; 0xffffffe0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:94 (discriminator 2)
        *ptr++ = '0' + digit;
    91a0:	e51b3020 	ldr	r3, [fp, #-32]	; 0xffffffe0
    91a4:	e6ef2073 	uxtb	r2, r3
    91a8:	e51b3008 	ldr	r3, [fp, #-8]
    91ac:	e2831001 	add	r1, r3, #1
    91b0:	e50b1008 	str	r1, [fp, #-8]
    91b4:	e2822030 	add	r2, r2, #48	; 0x30
    91b8:	e6ef2072 	uxtb	r2, r2
    91bc:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:95 (discriminator 2)
        fraction -= digit;
    91c0:	e51b3020 	ldr	r3, [fp, #-32]	; 0xffffffe0
    91c4:	ee073a90 	vmov	s15, r3
    91c8:	eef87ae7 	vcvt.f32.s32	s15, s15
    91cc:	ed1b7a04 	vldr	s14, [fp, #-16]
    91d0:	ee777a67 	vsub.f32	s15, s14, s15
    91d4:	ed4b7a04 	vstr	s15, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:91 (discriminator 2)
    for (int i = 0; i < decimal_places; i++) {
    91d8:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    91dc:	e2833001 	add	r3, r3, #1
    91e0:	e50b3018 	str	r3, [fp, #-24]	; 0xffffffe8
    91e4:	eaffffe1 	b	9170 <_Z4ftoafPcj+0x178>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:99
    }

    // Null-terminate the string
    *ptr = '\0';
    91e8:	e51b3008 	ldr	r3, [fp, #-8]
    91ec:	e3a02000 	mov	r2, #0
    91f0:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:102

    // Remove trailing zeros if any decimal places were specified
    if (decimal_places > 0) {
    91f4:	e51b3038 	ldr	r3, [fp, #-56]	; 0xffffffc8
    91f8:	e3530000 	cmp	r3, #0
    91fc:	0a00001b 	beq	9270 <_Z4ftoafPcj+0x278>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:103
        char* end = ptr - 1;
    9200:	e51b3008 	ldr	r3, [fp, #-8]
    9204:	e2433001 	sub	r3, r3, #1
    9208:	e50b301c 	str	r3, [fp, #-28]	; 0xffffffe4
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:104
        while (end > output && *end == '0') {
    920c:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    9210:	e51b3034 	ldr	r3, [fp, #-52]	; 0xffffffcc
    9214:	e1520003 	cmp	r2, r3
    9218:	9a000009 	bls	9244 <_Z4ftoafPcj+0x24c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:104 (discriminator 1)
    921c:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    9220:	e5d33000 	ldrb	r3, [r3]
    9224:	e3530030 	cmp	r3, #48	; 0x30
    9228:	1a000005 	bne	9244 <_Z4ftoafPcj+0x24c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:105
            *end-- = '\0';
    922c:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    9230:	e2432001 	sub	r2, r3, #1
    9234:	e50b201c 	str	r2, [fp, #-28]	; 0xffffffe4
    9238:	e3a02000 	mov	r2, #0
    923c:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:104
        while (end > output && *end == '0') {
    9240:	eafffff1 	b	920c <_Z4ftoafPcj+0x214>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:107
        }
        if (end > output && *end == '.') {
    9244:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    9248:	e51b3034 	ldr	r3, [fp, #-52]	; 0xffffffcc
    924c:	e1520003 	cmp	r2, r3
    9250:	9a000006 	bls	9270 <_Z4ftoafPcj+0x278>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:107 (discriminator 1)
    9254:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    9258:	e5d33000 	ldrb	r3, [r3]
    925c:	e353002e 	cmp	r3, #46	; 0x2e
    9260:	1a000002 	bne	9270 <_Z4ftoafPcj+0x278>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:108
            *end = '\0'; // Remove the decimal point if no fractional part remains
    9264:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    9268:	e3a02000 	mov	r2, #0
    926c:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:112
        }
    }

    return output;
    9270:	e51b3034 	ldr	r3, [fp, #-52]	; 0xffffffcc
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:113
}
    9274:	e1a00003 	mov	r0, r3
    9278:	e28bd000 	add	sp, fp, #0
    927c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    9280:	e12fff1e 	bx	lr
    9284:	41200000 			; <UNDEFINED> instruction: 0x41200000
    9288:	66666667 	strbtvs	r6, [r6], -r7, ror #12

0000928c <_Z7strncpyPcPKci>:
_Z7strncpyPcPKci():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:116

char* strncpy(char* dest, const char *src, int num)
{
    928c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    9290:	e28db000 	add	fp, sp, #0
    9294:	e24dd01c 	sub	sp, sp, #28
    9298:	e50b0010 	str	r0, [fp, #-16]
    929c:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    92a0:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:119
	int i;

	for (i = 0; i < num && src[i] != '\0'; i++)
    92a4:	e3a03000 	mov	r3, #0
    92a8:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:119 (discriminator 4)
    92ac:	e51b2008 	ldr	r2, [fp, #-8]
    92b0:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    92b4:	e1520003 	cmp	r2, r3
    92b8:	aa000011 	bge	9304 <_Z7strncpyPcPKci+0x78>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:119 (discriminator 2)
    92bc:	e51b3008 	ldr	r3, [fp, #-8]
    92c0:	e51b2014 	ldr	r2, [fp, #-20]	; 0xffffffec
    92c4:	e0823003 	add	r3, r2, r3
    92c8:	e5d33000 	ldrb	r3, [r3]
    92cc:	e3530000 	cmp	r3, #0
    92d0:	0a00000b 	beq	9304 <_Z7strncpyPcPKci+0x78>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:120 (discriminator 3)
		dest[i] = src[i];
    92d4:	e51b3008 	ldr	r3, [fp, #-8]
    92d8:	e51b2014 	ldr	r2, [fp, #-20]	; 0xffffffec
    92dc:	e0822003 	add	r2, r2, r3
    92e0:	e51b3008 	ldr	r3, [fp, #-8]
    92e4:	e51b1010 	ldr	r1, [fp, #-16]
    92e8:	e0813003 	add	r3, r1, r3
    92ec:	e5d22000 	ldrb	r2, [r2]
    92f0:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:119 (discriminator 3)
	for (i = 0; i < num && src[i] != '\0'; i++)
    92f4:	e51b3008 	ldr	r3, [fp, #-8]
    92f8:	e2833001 	add	r3, r3, #1
    92fc:	e50b3008 	str	r3, [fp, #-8]
    9300:	eaffffe9 	b	92ac <_Z7strncpyPcPKci+0x20>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:121 (discriminator 2)
	for (; i < num; i++)
    9304:	e51b2008 	ldr	r2, [fp, #-8]
    9308:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    930c:	e1520003 	cmp	r2, r3
    9310:	aa000008 	bge	9338 <_Z7strncpyPcPKci+0xac>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:122 (discriminator 1)
		dest[i] = '\0';
    9314:	e51b3008 	ldr	r3, [fp, #-8]
    9318:	e51b2010 	ldr	r2, [fp, #-16]
    931c:	e0823003 	add	r3, r2, r3
    9320:	e3a02000 	mov	r2, #0
    9324:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:121 (discriminator 1)
	for (; i < num; i++)
    9328:	e51b3008 	ldr	r3, [fp, #-8]
    932c:	e2833001 	add	r3, r3, #1
    9330:	e50b3008 	str	r3, [fp, #-8]
    9334:	eafffff2 	b	9304 <_Z7strncpyPcPKci+0x78>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:124

   return dest;
    9338:	e51b3010 	ldr	r3, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:125
}
    933c:	e1a00003 	mov	r0, r3
    9340:	e28bd000 	add	sp, fp, #0
    9344:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    9348:	e12fff1e 	bx	lr

0000934c <_Z7strncmpPKcS0_i>:
_Z7strncmpPKcS0_i():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:128

int strncmp(const char *s1, const char *s2, int num)
{
    934c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    9350:	e28db000 	add	fp, sp, #0
    9354:	e24dd01c 	sub	sp, sp, #28
    9358:	e50b0010 	str	r0, [fp, #-16]
    935c:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    9360:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:130
	unsigned char u1, u2;
  	while (num-- > 0)
    9364:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    9368:	e2432001 	sub	r2, r3, #1
    936c:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
    9370:	e3530000 	cmp	r3, #0
    9374:	c3a03001 	movgt	r3, #1
    9378:	d3a03000 	movle	r3, #0
    937c:	e6ef3073 	uxtb	r3, r3
    9380:	e3530000 	cmp	r3, #0
    9384:	0a000016 	beq	93e4 <_Z7strncmpPKcS0_i+0x98>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:132
    {
      	u1 = (unsigned char) *s1++;
    9388:	e51b3010 	ldr	r3, [fp, #-16]
    938c:	e2832001 	add	r2, r3, #1
    9390:	e50b2010 	str	r2, [fp, #-16]
    9394:	e5d33000 	ldrb	r3, [r3]
    9398:	e54b3005 	strb	r3, [fp, #-5]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:133
     	u2 = (unsigned char) *s2++;
    939c:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    93a0:	e2832001 	add	r2, r3, #1
    93a4:	e50b2014 	str	r2, [fp, #-20]	; 0xffffffec
    93a8:	e5d33000 	ldrb	r3, [r3]
    93ac:	e54b3006 	strb	r3, [fp, #-6]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:134
      	if (u1 != u2)
    93b0:	e55b2005 	ldrb	r2, [fp, #-5]
    93b4:	e55b3006 	ldrb	r3, [fp, #-6]
    93b8:	e1520003 	cmp	r2, r3
    93bc:	0a000003 	beq	93d0 <_Z7strncmpPKcS0_i+0x84>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:135
        	return u1 - u2;
    93c0:	e55b2005 	ldrb	r2, [fp, #-5]
    93c4:	e55b3006 	ldrb	r3, [fp, #-6]
    93c8:	e0423003 	sub	r3, r2, r3
    93cc:	ea000005 	b	93e8 <_Z7strncmpPKcS0_i+0x9c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:136
      	if (u1 == '\0')
    93d0:	e55b3005 	ldrb	r3, [fp, #-5]
    93d4:	e3530000 	cmp	r3, #0
    93d8:	1affffe1 	bne	9364 <_Z7strncmpPKcS0_i+0x18>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:137
        	return 0;
    93dc:	e3a03000 	mov	r3, #0
    93e0:	ea000000 	b	93e8 <_Z7strncmpPKcS0_i+0x9c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:140
    }

  	return 0;
    93e4:	e3a03000 	mov	r3, #0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:141
}
    93e8:	e1a00003 	mov	r0, r3
    93ec:	e28bd000 	add	sp, fp, #0
    93f0:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    93f4:	e12fff1e 	bx	lr

000093f8 <_Z6strlenPKc>:
_Z6strlenPKc():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:144

int strlen(const char* s)
{
    93f8:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    93fc:	e28db000 	add	fp, sp, #0
    9400:	e24dd014 	sub	sp, sp, #20
    9404:	e50b0010 	str	r0, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:145
	int i = 0;
    9408:	e3a03000 	mov	r3, #0
    940c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:147

	while (s[i] != '\0')
    9410:	e51b3008 	ldr	r3, [fp, #-8]
    9414:	e51b2010 	ldr	r2, [fp, #-16]
    9418:	e0823003 	add	r3, r2, r3
    941c:	e5d33000 	ldrb	r3, [r3]
    9420:	e3530000 	cmp	r3, #0
    9424:	0a000003 	beq	9438 <_Z6strlenPKc+0x40>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:148
		i++;
    9428:	e51b3008 	ldr	r3, [fp, #-8]
    942c:	e2833001 	add	r3, r3, #1
    9430:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:147
	while (s[i] != '\0')
    9434:	eafffff5 	b	9410 <_Z6strlenPKc+0x18>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:150

	return i;
    9438:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:151
}
    943c:	e1a00003 	mov	r0, r3
    9440:	e28bd000 	add	sp, fp, #0
    9444:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    9448:	e12fff1e 	bx	lr

0000944c <_Z5bzeroPvi>:
_Z5bzeroPvi():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:154

void bzero(void* memory, int length)
{
    944c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    9450:	e28db000 	add	fp, sp, #0
    9454:	e24dd014 	sub	sp, sp, #20
    9458:	e50b0010 	str	r0, [fp, #-16]
    945c:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:155
	char* mem = reinterpret_cast<char*>(memory);
    9460:	e51b3010 	ldr	r3, [fp, #-16]
    9464:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:157

	for (int i = 0; i < length; i++)
    9468:	e3a03000 	mov	r3, #0
    946c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:157 (discriminator 3)
    9470:	e51b2008 	ldr	r2, [fp, #-8]
    9474:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    9478:	e1520003 	cmp	r2, r3
    947c:	aa000008 	bge	94a4 <_Z5bzeroPvi+0x58>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:158 (discriminator 2)
		mem[i] = 0;
    9480:	e51b3008 	ldr	r3, [fp, #-8]
    9484:	e51b200c 	ldr	r2, [fp, #-12]
    9488:	e0823003 	add	r3, r2, r3
    948c:	e3a02000 	mov	r2, #0
    9490:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:157 (discriminator 2)
	for (int i = 0; i < length; i++)
    9494:	e51b3008 	ldr	r3, [fp, #-8]
    9498:	e2833001 	add	r3, r3, #1
    949c:	e50b3008 	str	r3, [fp, #-8]
    94a0:	eafffff2 	b	9470 <_Z5bzeroPvi+0x24>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:159
}
    94a4:	e320f000 	nop	{0}
    94a8:	e28bd000 	add	sp, fp, #0
    94ac:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    94b0:	e12fff1e 	bx	lr

000094b4 <_Z6memcpyPKvPvi>:
_Z6memcpyPKvPvi():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:162

void memcpy(const void* src, void* dst, int num)
{
    94b4:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    94b8:	e28db000 	add	fp, sp, #0
    94bc:	e24dd024 	sub	sp, sp, #36	; 0x24
    94c0:	e50b0018 	str	r0, [fp, #-24]	; 0xffffffe8
    94c4:	e50b101c 	str	r1, [fp, #-28]	; 0xffffffe4
    94c8:	e50b2020 	str	r2, [fp, #-32]	; 0xffffffe0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:163
	const char* memsrc = reinterpret_cast<const char*>(src);
    94cc:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    94d0:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:164
	char* memdst = reinterpret_cast<char*>(dst);
    94d4:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    94d8:	e50b3010 	str	r3, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:166

	for (int i = 0; i < num; i++)
    94dc:	e3a03000 	mov	r3, #0
    94e0:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:166 (discriminator 3)
    94e4:	e51b2008 	ldr	r2, [fp, #-8]
    94e8:	e51b3020 	ldr	r3, [fp, #-32]	; 0xffffffe0
    94ec:	e1520003 	cmp	r2, r3
    94f0:	aa00000b 	bge	9524 <_Z6memcpyPKvPvi+0x70>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:167 (discriminator 2)
		memdst[i] = memsrc[i];
    94f4:	e51b3008 	ldr	r3, [fp, #-8]
    94f8:	e51b200c 	ldr	r2, [fp, #-12]
    94fc:	e0822003 	add	r2, r2, r3
    9500:	e51b3008 	ldr	r3, [fp, #-8]
    9504:	e51b1010 	ldr	r1, [fp, #-16]
    9508:	e0813003 	add	r3, r1, r3
    950c:	e5d22000 	ldrb	r2, [r2]
    9510:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:166 (discriminator 2)
	for (int i = 0; i < num; i++)
    9514:	e51b3008 	ldr	r3, [fp, #-8]
    9518:	e2833001 	add	r3, r3, #1
    951c:	e50b3008 	str	r3, [fp, #-8]
    9520:	eaffffef 	b	94e4 <_Z6memcpyPKvPvi+0x30>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:168
}
    9524:	e320f000 	nop	{0}
    9528:	e28bd000 	add	sp, fp, #0
    952c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    9530:	e12fff1e 	bx	lr

00009534 <_Z6concatPcPKc>:
_Z6concatPcPKc():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:170

void concat(char* dest, const char* src) {
    9534:	e92d4800 	push	{fp, lr}
    9538:	e28db004 	add	fp, sp, #4
    953c:	e24dd010 	sub	sp, sp, #16
    9540:	e50b0010 	str	r0, [fp, #-16]
    9544:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:171
	int i = strlen(dest);
    9548:	e51b0010 	ldr	r0, [fp, #-16]
    954c:	ebffffa9 	bl	93f8 <_Z6strlenPKc>
    9550:	e50b0008 	str	r0, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:172
	int j = strlen(src);
    9554:	e51b0014 	ldr	r0, [fp, #-20]	; 0xffffffec
    9558:	ebffffa6 	bl	93f8 <_Z6strlenPKc>
    955c:	e50b000c 	str	r0, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:173
	strncpy(dest + i, src, j);
    9560:	e51b3008 	ldr	r3, [fp, #-8]
    9564:	e51b2010 	ldr	r2, [fp, #-16]
    9568:	e0823003 	add	r3, r2, r3
    956c:	e51b200c 	ldr	r2, [fp, #-12]
    9570:	e51b1014 	ldr	r1, [fp, #-20]	; 0xffffffec
    9574:	e1a00003 	mov	r0, r3
    9578:	ebffff43 	bl	928c <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:174
	dest[i + j + 1] = '\0';
    957c:	e51b2008 	ldr	r2, [fp, #-8]
    9580:	e51b300c 	ldr	r3, [fp, #-12]
    9584:	e0823003 	add	r3, r2, r3
    9588:	e2833001 	add	r3, r3, #1
    958c:	e51b2010 	ldr	r2, [fp, #-16]
    9590:	e0823003 	add	r3, r2, r3
    9594:	e3a02000 	mov	r2, #0
    9598:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:175
    959c:	e320f000 	nop	{0}
    95a0:	e24bd004 	sub	sp, fp, #4
    95a4:	e8bd8800 	pop	{fp, pc}

000095a8 <__udivsi3>:
__udivsi3():
    95a8:	e2512001 	subs	r2, r1, #1
    95ac:	012fff1e 	bxeq	lr
    95b0:	3a000074 	bcc	9788 <__udivsi3+0x1e0>
    95b4:	e1500001 	cmp	r0, r1
    95b8:	9a00006b 	bls	976c <__udivsi3+0x1c4>
    95bc:	e1110002 	tst	r1, r2
    95c0:	0a00006c 	beq	9778 <__udivsi3+0x1d0>
    95c4:	e16f3f10 	clz	r3, r0
    95c8:	e16f2f11 	clz	r2, r1
    95cc:	e0423003 	sub	r3, r2, r3
    95d0:	e273301f 	rsbs	r3, r3, #31
    95d4:	10833083 	addne	r3, r3, r3, lsl #1
    95d8:	e3a02000 	mov	r2, #0
    95dc:	108ff103 	addne	pc, pc, r3, lsl #2
    95e0:	e1a00000 	nop			; (mov r0, r0)
    95e4:	e1500f81 	cmp	r0, r1, lsl #31
    95e8:	e0a22002 	adc	r2, r2, r2
    95ec:	20400f81 	subcs	r0, r0, r1, lsl #31
    95f0:	e1500f01 	cmp	r0, r1, lsl #30
    95f4:	e0a22002 	adc	r2, r2, r2
    95f8:	20400f01 	subcs	r0, r0, r1, lsl #30
    95fc:	e1500e81 	cmp	r0, r1, lsl #29
    9600:	e0a22002 	adc	r2, r2, r2
    9604:	20400e81 	subcs	r0, r0, r1, lsl #29
    9608:	e1500e01 	cmp	r0, r1, lsl #28
    960c:	e0a22002 	adc	r2, r2, r2
    9610:	20400e01 	subcs	r0, r0, r1, lsl #28
    9614:	e1500d81 	cmp	r0, r1, lsl #27
    9618:	e0a22002 	adc	r2, r2, r2
    961c:	20400d81 	subcs	r0, r0, r1, lsl #27
    9620:	e1500d01 	cmp	r0, r1, lsl #26
    9624:	e0a22002 	adc	r2, r2, r2
    9628:	20400d01 	subcs	r0, r0, r1, lsl #26
    962c:	e1500c81 	cmp	r0, r1, lsl #25
    9630:	e0a22002 	adc	r2, r2, r2
    9634:	20400c81 	subcs	r0, r0, r1, lsl #25
    9638:	e1500c01 	cmp	r0, r1, lsl #24
    963c:	e0a22002 	adc	r2, r2, r2
    9640:	20400c01 	subcs	r0, r0, r1, lsl #24
    9644:	e1500b81 	cmp	r0, r1, lsl #23
    9648:	e0a22002 	adc	r2, r2, r2
    964c:	20400b81 	subcs	r0, r0, r1, lsl #23
    9650:	e1500b01 	cmp	r0, r1, lsl #22
    9654:	e0a22002 	adc	r2, r2, r2
    9658:	20400b01 	subcs	r0, r0, r1, lsl #22
    965c:	e1500a81 	cmp	r0, r1, lsl #21
    9660:	e0a22002 	adc	r2, r2, r2
    9664:	20400a81 	subcs	r0, r0, r1, lsl #21
    9668:	e1500a01 	cmp	r0, r1, lsl #20
    966c:	e0a22002 	adc	r2, r2, r2
    9670:	20400a01 	subcs	r0, r0, r1, lsl #20
    9674:	e1500981 	cmp	r0, r1, lsl #19
    9678:	e0a22002 	adc	r2, r2, r2
    967c:	20400981 	subcs	r0, r0, r1, lsl #19
    9680:	e1500901 	cmp	r0, r1, lsl #18
    9684:	e0a22002 	adc	r2, r2, r2
    9688:	20400901 	subcs	r0, r0, r1, lsl #18
    968c:	e1500881 	cmp	r0, r1, lsl #17
    9690:	e0a22002 	adc	r2, r2, r2
    9694:	20400881 	subcs	r0, r0, r1, lsl #17
    9698:	e1500801 	cmp	r0, r1, lsl #16
    969c:	e0a22002 	adc	r2, r2, r2
    96a0:	20400801 	subcs	r0, r0, r1, lsl #16
    96a4:	e1500781 	cmp	r0, r1, lsl #15
    96a8:	e0a22002 	adc	r2, r2, r2
    96ac:	20400781 	subcs	r0, r0, r1, lsl #15
    96b0:	e1500701 	cmp	r0, r1, lsl #14
    96b4:	e0a22002 	adc	r2, r2, r2
    96b8:	20400701 	subcs	r0, r0, r1, lsl #14
    96bc:	e1500681 	cmp	r0, r1, lsl #13
    96c0:	e0a22002 	adc	r2, r2, r2
    96c4:	20400681 	subcs	r0, r0, r1, lsl #13
    96c8:	e1500601 	cmp	r0, r1, lsl #12
    96cc:	e0a22002 	adc	r2, r2, r2
    96d0:	20400601 	subcs	r0, r0, r1, lsl #12
    96d4:	e1500581 	cmp	r0, r1, lsl #11
    96d8:	e0a22002 	adc	r2, r2, r2
    96dc:	20400581 	subcs	r0, r0, r1, lsl #11
    96e0:	e1500501 	cmp	r0, r1, lsl #10
    96e4:	e0a22002 	adc	r2, r2, r2
    96e8:	20400501 	subcs	r0, r0, r1, lsl #10
    96ec:	e1500481 	cmp	r0, r1, lsl #9
    96f0:	e0a22002 	adc	r2, r2, r2
    96f4:	20400481 	subcs	r0, r0, r1, lsl #9
    96f8:	e1500401 	cmp	r0, r1, lsl #8
    96fc:	e0a22002 	adc	r2, r2, r2
    9700:	20400401 	subcs	r0, r0, r1, lsl #8
    9704:	e1500381 	cmp	r0, r1, lsl #7
    9708:	e0a22002 	adc	r2, r2, r2
    970c:	20400381 	subcs	r0, r0, r1, lsl #7
    9710:	e1500301 	cmp	r0, r1, lsl #6
    9714:	e0a22002 	adc	r2, r2, r2
    9718:	20400301 	subcs	r0, r0, r1, lsl #6
    971c:	e1500281 	cmp	r0, r1, lsl #5
    9720:	e0a22002 	adc	r2, r2, r2
    9724:	20400281 	subcs	r0, r0, r1, lsl #5
    9728:	e1500201 	cmp	r0, r1, lsl #4
    972c:	e0a22002 	adc	r2, r2, r2
    9730:	20400201 	subcs	r0, r0, r1, lsl #4
    9734:	e1500181 	cmp	r0, r1, lsl #3
    9738:	e0a22002 	adc	r2, r2, r2
    973c:	20400181 	subcs	r0, r0, r1, lsl #3
    9740:	e1500101 	cmp	r0, r1, lsl #2
    9744:	e0a22002 	adc	r2, r2, r2
    9748:	20400101 	subcs	r0, r0, r1, lsl #2
    974c:	e1500081 	cmp	r0, r1, lsl #1
    9750:	e0a22002 	adc	r2, r2, r2
    9754:	20400081 	subcs	r0, r0, r1, lsl #1
    9758:	e1500001 	cmp	r0, r1
    975c:	e0a22002 	adc	r2, r2, r2
    9760:	20400001 	subcs	r0, r0, r1
    9764:	e1a00002 	mov	r0, r2
    9768:	e12fff1e 	bx	lr
    976c:	03a00001 	moveq	r0, #1
    9770:	13a00000 	movne	r0, #0
    9774:	e12fff1e 	bx	lr
    9778:	e16f2f11 	clz	r2, r1
    977c:	e262201f 	rsb	r2, r2, #31
    9780:	e1a00230 	lsr	r0, r0, r2
    9784:	e12fff1e 	bx	lr
    9788:	e3500000 	cmp	r0, #0
    978c:	13e00000 	mvnne	r0, #0
    9790:	ea000007 	b	97b4 <__aeabi_idiv0>

00009794 <__aeabi_uidivmod>:
__aeabi_uidivmod():
    9794:	e3510000 	cmp	r1, #0
    9798:	0afffffa 	beq	9788 <__udivsi3+0x1e0>
    979c:	e92d4003 	push	{r0, r1, lr}
    97a0:	ebffff80 	bl	95a8 <__udivsi3>
    97a4:	e8bd4006 	pop	{r1, r2, lr}
    97a8:	e0030092 	mul	r3, r2, r0
    97ac:	e0411003 	sub	r1, r1, r3
    97b0:	e12fff1e 	bx	lr

000097b4 <__aeabi_idiv0>:
__aeabi_ldiv0():
    97b4:	e12fff1e 	bx	lr

Disassembly of section .rodata:

000097b8 <_ZL13Lock_Unlocked>:
    97b8:	00000000 	andeq	r0, r0, r0

000097bc <_ZL11Lock_Locked>:
    97bc:	00000001 	andeq	r0, r0, r1

000097c0 <_ZL21MaxFSDriverNameLength>:
    97c0:	00000010 	andeq	r0, r0, r0, lsl r0

000097c4 <_ZL17MaxFilenameLength>:
    97c4:	00000010 	andeq	r0, r0, r0, lsl r0

000097c8 <_ZL13MaxPathLength>:
    97c8:	00000080 	andeq	r0, r0, r0, lsl #1

000097cc <_ZL18NoFilesystemDriver>:
    97cc:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

000097d0 <_ZL9NotifyAll>:
    97d0:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

000097d4 <_ZL24Max_Process_Opened_Files>:
    97d4:	00000010 	andeq	r0, r0, r0, lsl r0

000097d8 <_ZL10Indefinite>:
    97d8:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

000097dc <_ZL18Deadline_Unchanged>:
    97dc:	fffffffe 			; <UNDEFINED> instruction: 0xfffffffe

000097e0 <_ZL14Invalid_Handle>:
    97e0:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

000097e4 <_ZN3halL18Default_Clock_RateE>:
    97e4:	0ee6b280 	cdpeq	2, 14, cr11, cr6, cr0, {4}

000097e8 <_ZN3halL15Peripheral_BaseE>:
    97e8:	20000000 	andcs	r0, r0, r0

000097ec <_ZN3halL9GPIO_BaseE>:
    97ec:	20200000 	eorcs	r0, r0, r0

000097f0 <_ZN3halL14GPIO_Pin_CountE>:
    97f0:	00000036 	andeq	r0, r0, r6, lsr r0

000097f4 <_ZN3halL8AUX_BaseE>:
    97f4:	20215000 	eorcs	r5, r1, r0

000097f8 <_ZN3halL25Interrupt_Controller_BaseE>:
    97f8:	2000b200 	andcs	fp, r0, r0, lsl #4

000097fc <_ZN3halL10Timer_BaseE>:
    97fc:	2000b400 	andcs	fp, r0, r0, lsl #8

00009800 <_ZN3halL9TRNG_BaseE>:
    9800:	20104000 	andscs	r4, r0, r0

00009804 <_ZN3halL9BSC0_BaseE>:
    9804:	20205000 	eorcs	r5, r0, r0

00009808 <_ZN3halL9BSC1_BaseE>:
    9808:	20804000 	addcs	r4, r0, r0

0000980c <_ZN3halL9BSC2_BaseE>:
    980c:	20805000 	addcs	r5, r0, r0

00009810 <_ZN3halL14I2C_SLAVE_BaseE>:
    9810:	20214000 	eorcs	r4, r1, r0

00009814 <_ZL11Invalid_Pin>:
    9814:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00009818 <_ZL24I2C_Transaction_Max_Size>:
    9818:	00000008 	andeq	r0, r0, r8

0000981c <_ZL7ADDRESS>:
    981c:	00000001 	andeq	r0, r0, r1

00009820 <_ZL14TARGET_ADDRESS>:
    9820:	00000002 	andeq	r0, r0, r2

00009824 <_ZL12DESIRED_ROLE>:
    9824:	00000000 	andeq	r0, r0, r0
    9828:	5453414d 	ldrbpl	r4, [r3], #-333	; 0xfffffeb3
    982c:	203a5245 	eorscs	r5, sl, r5, asr #4
    9830:	00000000 	andeq	r0, r0, r0
    9834:	56414c53 			; <UNDEFINED> instruction: 0x56414c53
    9838:	00203a45 	eoreq	r3, r0, r5, asr #20
    983c:	45534e55 	ldrbmi	r4, [r3, #-3669]	; 0xfffff1ab
    9840:	00203a54 	eoreq	r3, r0, r4, asr sl
    9844:	0074736d 	rsbseq	r7, r4, sp, ror #6
    9848:	00766c73 	rsbseq	r6, r6, r3, ror ip
    984c:	656c6f52 	strbvs	r6, [ip, #-3922]!	; 0xfffff0ae
    9850:	65732073 	ldrbvs	r2, [r3, #-115]!	; 0xffffff8d
    9854:	49202e74 	stmdbmi	r0!, {r2, r4, r5, r6, r9, sl, fp, sp}
    9858:	206d6120 	rsbcs	r6, sp, r0, lsr #2
    985c:	00000000 	andeq	r0, r0, r0
    9860:	7473614d 	ldrbtvc	r6, [r3], #-333	; 0xfffffeb3
    9864:	000a7265 	andeq	r7, sl, r5, ror #4
    9868:	76616c53 			; <UNDEFINED> instruction: 0x76616c53
    986c:	00000a65 	andeq	r0, r0, r5, ror #20
    9870:	65636552 	strbvs	r6, [r3, #-1362]!	; 0xfffffaae
    9874:	64657669 	strbtvs	r7, [r5], #-1641	; 0xfffff997
    9878:	00000020 	andeq	r0, r0, r0, lsr #32
    987c:	4f202d20 	svcmi	0x00202d20
    9880:	0000004b 	andeq	r0, r0, fp, asr #32
    9884:	44202d20 	strtmi	r2, [r0], #-3360	; 0xfffff2e0
    9888:	45474e41 	strbmi	r4, [r7, #-3649]	; 0xfffff1bf
    988c:	00000052 	andeq	r0, r0, r2, asr r0
    9890:	57202d20 	strpl	r2, [r0, -r0, lsr #26]!
    9894:	494e5241 	stmdbmi	lr, {r0, r6, r9, ip, lr}^
    9898:	0000474e 	andeq	r4, r0, lr, asr #14
    989c:	0000000a 	andeq	r0, r0, sl
    98a0:	00676f6c 	rsbeq	r6, r7, ip, ror #30
    98a4:	7473614d 	ldrbtvc	r6, [r3], #-333	; 0xfffffeb3
    98a8:	74207265 	strtvc	r7, [r0], #-613	; 0xfffffd9b
    98ac:	206b7361 	rsbcs	r7, fp, r1, ror #6
    98b0:	72617473 	rsbvc	r7, r1, #1929379840	; 0x73000000
    98b4:	0a646574 	beq	1922e8c <__bss_end+0x191948c>
    98b8:	00000000 	andeq	r0, r0, r0
    98bc:	3a564544 	bcc	159add4 <__bss_end+0x15913d4>
    98c0:	2f633269 	svccs	0x00633269
    98c4:	00000031 	andeq	r0, r0, r1, lsr r0
    98c8:	6f727245 	svcvs	0x00727245
    98cc:	706f2072 	rsbvc	r2, pc, r2, ror r0	; <UNPREDICTABLE>
    98d0:	6e696e65 	cdpvs	14, 6, cr6, cr9, cr5, {3}
    98d4:	32492067 	subcc	r2, r9, #103	; 0x67
    98d8:	616d2043 	cmnvs	sp, r3, asr #32
    98dc:	72657473 	rsbvc	r7, r5, #1929379840	; 0x73000000
    98e0:	6e6f6320 	cdpvs	3, 6, cr6, cr15, cr0, {1}
    98e4:	7463656e 	strbtvc	r6, [r3], #-1390	; 0xfffffa92
    98e8:	0a6e6f69 	beq	1ba5694 <__bss_end+0x1b9bc94>
    98ec:	00000000 	andeq	r0, r0, r0
    98f0:	20433249 	subcs	r3, r3, r9, asr #4
    98f4:	6e6e6f63 	cdpvs	15, 6, cr6, cr14, cr3, {3}
    98f8:	69746365 	ldmdbvs	r4!, {r0, r2, r5, r6, r8, r9, sp, lr}^
    98fc:	6d206e6f 	stcvs	14, cr6, [r0, #-444]!	; 0xfffffe44
    9900:	65747361 	ldrbvs	r7, [r4, #-865]!	; 0xfffffc9f
    9904:	74732072 	ldrbtvc	r2, [r3], #-114	; 0xffffff8e
    9908:	65747261 	ldrbvs	r7, [r4, #-609]!	; 0xfffffd9f
    990c:	2e2e2e64 	cdpcs	14, 2, cr2, cr14, cr4, {3}
    9910:	0000000a 	andeq	r0, r0, sl

00009914 <_ZL13Lock_Unlocked>:
    9914:	00000000 	andeq	r0, r0, r0

00009918 <_ZL11Lock_Locked>:
    9918:	00000001 	andeq	r0, r0, r1

0000991c <_ZL21MaxFSDriverNameLength>:
    991c:	00000010 	andeq	r0, r0, r0, lsl r0

00009920 <_ZL17MaxFilenameLength>:
    9920:	00000010 	andeq	r0, r0, r0, lsl r0

00009924 <_ZL13MaxPathLength>:
    9924:	00000080 	andeq	r0, r0, r0, lsl #1

00009928 <_ZL18NoFilesystemDriver>:
    9928:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

0000992c <_ZL9NotifyAll>:
    992c:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00009930 <_ZL24Max_Process_Opened_Files>:
    9930:	00000010 	andeq	r0, r0, r0, lsl r0

00009934 <_ZL10Indefinite>:
    9934:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00009938 <_ZL18Deadline_Unchanged>:
    9938:	fffffffe 			; <UNDEFINED> instruction: 0xfffffffe

0000993c <_ZL14Invalid_Handle>:
    993c:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00009940 <_ZL16Pipe_File_Prefix>:
    9940:	3a535953 	bcc	14dfe94 <__bss_end+0x14d6494>
    9944:	65706970 	ldrbvs	r6, [r0, #-2416]!	; 0xfffff690
    9948:	0000002f 	andeq	r0, r0, pc, lsr #32

0000994c <_ZN12_GLOBAL__N_1L11CharConvArrE>:
    994c:	33323130 	teqcc	r2, #48, 2
    9950:	37363534 			; <UNDEFINED> instruction: 0x37363534
    9954:	42413938 	submi	r3, r1, #56, 18	; 0xe0000
    9958:	46454443 	strbmi	r4, [r5], -r3, asr #8
	...

Disassembly of section .data:

00009960 <__CTOR_LIST__>:
__DTOR_END__():
    9960:	00000002 	andeq	r0, r0, r2

Disassembly of section .bss:

00009964 <master>:
__bss_start():
    9964:	00000000 	andeq	r0, r0, r0

00009968 <log_fd>:
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:19
uint32_t master, log_fd;
    9968:	00000000 	andeq	r0, r0, r0

0000996c <received_values>:
	...

000099ec <received_values_len>:
	...

Disassembly of section .ARM.attributes:

00000000 <.ARM.attributes>:
   0:	00002e41 	andeq	r2, r0, r1, asr #28
   4:	61656100 	cmnvs	r5, r0, lsl #2
   8:	01006962 	tsteq	r0, r2, ror #18
   c:	00000024 	andeq	r0, r0, r4, lsr #32
  10:	4b5a3605 	blmi	168d82c <__bss_end+0x1683e2c>
  14:	08070600 	stmdaeq	r7, {r9, sl}
  18:	0a010901 	beq	42424 <__bss_end+0x38a24>
  1c:	14041202 	strne	r1, [r4], #-514	; 0xfffffdfe
  20:	17011501 	strne	r1, [r1, -r1, lsl #10]
  24:	1a011803 	bne	46038 <__bss_end+0x3c638>
  28:	22011c01 	andcs	r1, r1, #256	; 0x100
  2c:	Address 0x000000000000002c is out of bounds.


Disassembly of section .comment:

00000000 <.comment>:
   0:	3a434347 	bcc	10d0d24 <__bss_end+0x10c7324>
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
  38:	7a617661 	bvc	185d9c4 <__bss_end+0x1853fc4>
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
  c0:	6a757a61 	bvs	1d5ea4c <__bss_end+0x1d5504c>
  c4:	2f696369 	svccs	0x00696369
  c8:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
  cc:	73656d65 	cmnvc	r5, #6464	; 0x1940
  d0:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
  d4:	6b2d616b 	blvs	b58688 <__bss_end+0xb4ec88>
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
 144:	fb010200 	blx	4094e <__bss_end+0x36f4e>
 148:	01000d0e 	tsteq	r0, lr, lsl #26
 14c:	00010101 	andeq	r0, r1, r1, lsl #2
 150:	00010000 	andeq	r0, r1, r0
 154:	552f0100 	strpl	r0, [pc, #-256]!	; 5c <shift+0x5c>
 158:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 15c:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 160:	6a726574 	bvs	1c99738 <__bss_end+0x1c8fd38>
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
 198:	752f7365 	strvc	r7, [pc, #-869]!	; fffffe3b <__bss_end+0xffff643b>
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
 1d0:	0a05830b 	beq	160e04 <__bss_end+0x157404>
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
 1fc:	4a030402 	bmi	c120c <__bss_end+0xb780c>
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
 230:	4a020402 	bmi	81240 <__bss_end+0x77840>
 234:	02000205 	andeq	r0, r0, #1342177280	; 0x50000000
 238:	052d0204 	streq	r0, [sp, #-516]!	; 0xfffffdfc
 23c:	01058509 	tsteq	r5, r9, lsl #10
 240:	000a022f 	andeq	r0, sl, pc, lsr #4
 244:	04af0101 	strteq	r0, [pc], #257	; 24c <shift+0x24c>
 248:	00030000 	andeq	r0, r3, r0
 24c:	00000318 	andeq	r0, r0, r8, lsl r3
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
 280:	6a757a61 	bvs	1d5ec0c <__bss_end+0x1d5520c>
 284:	2f696369 	svccs	0x00696369
 288:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
 28c:	73656d65 	cmnvc	r5, #6464	; 0x1940
 290:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
 294:	6b2d616b 	blvs	b58848 <__bss_end+0xb4ee48>
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
 2cc:	6b736544 	blvs	1cd97e4 <__bss_end+0x1ccfde4>
 2d0:	2f706f74 	svccs	0x00706f74
 2d4:	2f564146 	svccs	0x00564146
 2d8:	6176614e 	cmnvs	r6, lr, asr #2
 2dc:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
 2e0:	4f2f6963 	svcmi	0x002f6963
 2e4:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
 2e8:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
 2ec:	6b6c6172 	blvs	1b188bc <__bss_end+0x1b0eebc>
 2f0:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
 2f4:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
 2f8:	756f732f 	strbvc	r7, [pc, #-815]!	; ffffffd1 <__bss_end+0xffff65d1>
 2fc:	73656372 	cmnvc	r5, #-939524095	; 0xc8000001
 300:	6573752f 	ldrbvs	r7, [r3, #-1327]!	; 0xfffffad1
 304:	61707372 	cmnvs	r0, r2, ror r3
 308:	2e2f6563 	cfsh64cs	mvdx6, mvdx15, #51
 30c:	656b2f2e 	strbvs	r2, [fp, #-3886]!	; 0xfffff0d2
 310:	6c656e72 	stclvs	14, cr6, [r5], #-456	; 0xfffffe38
 314:	636e692f 	cmnvs	lr, #770048	; 0xbc000
 318:	6564756c 	strbvs	r7, [r4, #-1388]!	; 0xfffffa94
 31c:	616f622f 	cmnvs	pc, pc, lsr #4
 320:	722f6472 	eorvc	r6, pc, #1912602624	; 0x72000000
 324:	2f306970 	svccs	0x00306970
 328:	006c6168 	rsbeq	r6, ip, r8, ror #2
 32c:	6573552f 	ldrbvs	r5, [r3, #-1327]!	; 0xfffffad1
 330:	772f7372 			; <UNDEFINED> instruction: 0x772f7372
 334:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
 338:	2f696a72 	svccs	0x00696a72
 33c:	6b736544 	blvs	1cd9854 <__bss_end+0x1ccfe54>
 340:	2f706f74 	svccs	0x00706f74
 344:	2f564146 	svccs	0x00564146
 348:	6176614e 	cmnvs	r6, lr, asr #2
 34c:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
 350:	4f2f6963 	svcmi	0x002f6963
 354:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
 358:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
 35c:	6b6c6172 	blvs	1b1892c <__bss_end+0x1b0ef2c>
 360:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
 364:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
 368:	756f732f 	strbvc	r7, [pc, #-815]!	; 41 <shift+0x41>
 36c:	73656372 	cmnvc	r5, #-939524095	; 0xc8000001
 370:	6573752f 	ldrbvs	r7, [r3, #-1327]!	; 0xfffffad1
 374:	61707372 	cmnvs	r0, r2, ror r3
 378:	2e2f6563 	cfsh64cs	mvdx6, mvdx15, #51
 37c:	656b2f2e 	strbvs	r2, [fp, #-3886]!	; 0xfffff0d2
 380:	6c656e72 	stclvs	14, cr6, [r5], #-456	; 0xfffffe38
 384:	636e692f 	cmnvs	lr, #770048	; 0xbc000
 388:	6564756c 	strbvs	r7, [r4, #-1388]!	; 0xfffffa94
 38c:	6f72702f 	svcvs	0x0072702f
 390:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
 394:	73552f00 	cmpvc	r5, #0, 30
 398:	2f737265 	svccs	0x00737265
 39c:	746e6977 	strbtvc	r6, [lr], #-2423	; 0xfffff689
 3a0:	696a7265 	stmdbvs	sl!, {r0, r2, r5, r6, r9, ip, sp, lr}^
 3a4:	7365442f 	cmnvc	r5, #788529152	; 0x2f000000
 3a8:	706f746b 	rsbvc	r7, pc, fp, ror #8
 3ac:	5641462f 	strbpl	r4, [r1], -pc, lsr #12
 3b0:	76614e2f 	strbtvc	r4, [r1], -pc, lsr #28
 3b4:	6a757a61 	bvs	1d5ed40 <__bss_end+0x1d55340>
 3b8:	2f696369 	svccs	0x00696369
 3bc:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
 3c0:	73656d65 	cmnvc	r5, #6464	; 0x1940
 3c4:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
 3c8:	6b2d616b 	blvs	b5897c <__bss_end+0xb4ef7c>
 3cc:	6f2d7669 	svcvs	0x002d7669
 3d0:	6f732f73 	svcvs	0x00732f73
 3d4:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
 3d8:	73752f73 	cmnvc	r5, #460	; 0x1cc
 3dc:	70737265 	rsbsvc	r7, r3, r5, ror #4
 3e0:	2f656361 	svccs	0x00656361
 3e4:	6b2f2e2e 	blvs	bcbca4 <__bss_end+0xbc22a4>
 3e8:	656e7265 	strbvs	r7, [lr, #-613]!	; 0xfffffd9b
 3ec:	6e692f6c 	cdpvs	15, 6, cr2, cr9, cr12, {3}
 3f0:	64756c63 	ldrbtvs	r6, [r5], #-3171	; 0xfffff39d
 3f4:	73662f65 	cmnvc	r6, #404	; 0x194
 3f8:	73552f00 	cmpvc	r5, #0, 30
 3fc:	2f737265 	svccs	0x00737265
 400:	746e6977 	strbtvc	r6, [lr], #-2423	; 0xfffff689
 404:	696a7265 	stmdbvs	sl!, {r0, r2, r5, r6, r9, ip, sp, lr}^
 408:	7365442f 	cmnvc	r5, #788529152	; 0x2f000000
 40c:	706f746b 	rsbvc	r7, pc, fp, ror #8
 410:	5641462f 	strbpl	r4, [r1], -pc, lsr #12
 414:	76614e2f 	strbtvc	r4, [r1], -pc, lsr #28
 418:	6a757a61 	bvs	1d5eda4 <__bss_end+0x1d553a4>
 41c:	2f696369 	svccs	0x00696369
 420:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
 424:	73656d65 	cmnvc	r5, #6464	; 0x1940
 428:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
 42c:	6b2d616b 	blvs	b589e0 <__bss_end+0xb4efe0>
 430:	6f2d7669 	svcvs	0x002d7669
 434:	6f732f73 	svcvs	0x00732f73
 438:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
 43c:	73752f73 	cmnvc	r5, #460	; 0x1cc
 440:	70737265 	rsbsvc	r7, r3, r5, ror #4
 444:	2f656361 	svccs	0x00656361
 448:	6b2f2e2e 	blvs	bcbd08 <__bss_end+0xbc2308>
 44c:	656e7265 	strbvs	r7, [lr, #-613]!	; 0xfffffd9b
 450:	6e692f6c 	cdpvs	15, 6, cr2, cr9, cr12, {3}
 454:	64756c63 	ldrbtvs	r6, [r5], #-3171	; 0xfffff39d
 458:	72642f65 	rsbvc	r2, r4, #404	; 0x194
 45c:	72657669 	rsbvc	r7, r5, #110100480	; 0x6900000
 460:	552f0073 	strpl	r0, [pc, #-115]!	; 3f5 <shift+0x3f5>
 464:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 468:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 46c:	6a726574 	bvs	1c99a44 <__bss_end+0x1c90044>
 470:	65442f69 	strbvs	r2, [r4, #-3945]	; 0xfffff097
 474:	6f746b73 	svcvs	0x00746b73
 478:	41462f70 	hvcmi	25328	; 0x62f0
 47c:	614e2f56 	cmpvs	lr, r6, asr pc
 480:	757a6176 	ldrbvc	r6, [sl, #-374]!	; 0xfffffe8a
 484:	6963696a 	stmdbvs	r3!, {r1, r3, r5, r6, r8, fp, sp, lr}^
 488:	2f534f2f 	svccs	0x00534f2f
 48c:	656d6573 	strbvs	r6, [sp, #-1395]!	; 0xfffffa8d
 490:	61727473 	cmnvs	r2, r3, ror r4
 494:	2d616b6c 	vstmdbcs	r1!, {d22-<overflow reg d75>}
 498:	2d76696b 			; <UNDEFINED> instruction: 0x2d76696b
 49c:	732f736f 			; <UNDEFINED> instruction: 0x732f736f
 4a0:	6372756f 	cmnvs	r2, #465567744	; 0x1bc00000
 4a4:	752f7365 	strvc	r7, [pc, #-869]!	; 147 <shift+0x147>
 4a8:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 4ac:	65636170 	strbvs	r6, [r3, #-368]!	; 0xfffffe90
 4b0:	2f2e2e2f 	svccs	0x002e2e2f
 4b4:	6e72656b 	cdpvs	5, 7, cr6, cr2, cr11, {3}
 4b8:	692f6c65 	stmdbvs	pc!, {r0, r2, r5, r6, sl, fp, sp, lr}	; <UNPREDICTABLE>
 4bc:	756c636e 	strbvc	r6, [ip, #-878]!	; 0xfffffc92
 4c0:	642f6564 	strtvs	r6, [pc], #-1380	; 4c8 <shift+0x4c8>
 4c4:	65766972 	ldrbvs	r6, [r6, #-2418]!	; 0xfffff68e
 4c8:	622f7372 	eorvs	r7, pc, #-939524095	; 0xc8000001
 4cc:	67646972 			; <UNDEFINED> instruction: 0x67646972
 4d0:	00007365 	andeq	r7, r0, r5, ror #6
 4d4:	6e69616d 	powvsez	f6, f1, #5.0
 4d8:	7070632e 	rsbsvc	r6, r0, lr, lsr #6
 4dc:	00000100 	andeq	r0, r0, r0, lsl #2
 4e0:	64746e69 	ldrbtvs	r6, [r4], #-3689	; 0xfffff197
 4e4:	682e6665 	stmdavs	lr!, {r0, r2, r5, r6, r9, sl, sp, lr}
 4e8:	00000200 	andeq	r0, r0, r0, lsl #4
 4ec:	2e697773 	mcrcs	7, 3, r7, cr9, cr3, {3}
 4f0:	00030068 	andeq	r0, r3, r8, rrx
 4f4:	69707300 	ldmdbvs	r0!, {r8, r9, ip, sp, lr}^
 4f8:	636f6c6e 	cmnvs	pc, #28160	; 0x6e00
 4fc:	00682e6b 	rsbeq	r2, r8, fp, ror #28
 500:	66000003 	strvs	r0, [r0], -r3
 504:	73656c69 	cmnvc	r5, #26880	; 0x6900
 508:	65747379 	ldrbvs	r7, [r4, #-889]!	; 0xfffffc87
 50c:	00682e6d 	rsbeq	r2, r8, sp, ror #28
 510:	70000004 	andvc	r0, r0, r4
 514:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
 518:	682e7373 	stmdavs	lr!, {r0, r1, r4, r5, r6, r8, r9, ip, sp, lr}
 51c:	00000300 	andeq	r0, r0, r0, lsl #6
 520:	636f7270 	cmnvs	pc, #112, 4
 524:	5f737365 	svcpl	0x00737365
 528:	616e616d 	cmnvs	lr, sp, ror #2
 52c:	2e726567 	cdpcs	5, 7, cr6, cr2, cr7, {3}
 530:	00030068 	andeq	r0, r3, r8, rrx
 534:	72657000 	rsbvc	r7, r5, #0
 538:	65687069 	strbvs	r7, [r8, #-105]!	; 0xffffff97
 53c:	736c6172 	cmnvc	ip, #-2147483620	; 0x8000001c
 540:	0200682e 	andeq	r6, r0, #3014656	; 0x2e0000
 544:	70670000 	rsbvc	r0, r7, r0
 548:	682e6f69 	stmdavs	lr!, {r0, r3, r5, r6, r8, r9, sl, fp, sp, lr}
 54c:	00000500 	andeq	r0, r0, r0, lsl #10
 550:	5f633269 	svcpl	0x00633269
 554:	73666564 	cmnvc	r6, #100, 10	; 0x19000000
 558:	0600682e 	streq	r6, [r0], -lr, lsr #16
 55c:	32690000 	rsbcc	r0, r9, #0
 560:	00682e63 	rsbeq	r2, r8, r3, ror #28
 564:	00000005 	andeq	r0, r0, r5
 568:	05002c05 	streq	r2, [r0, #-3077]	; 0xfffff3fb
 56c:	00822c02 	addeq	r2, r2, r2, lsl #24
 570:	01170300 	tsteq	r7, r0, lsl #6
 574:	059f0e05 	ldreq	r0, [pc, #3589]	; 1381 <shift+0x1381>
 578:	10054b05 	andne	r4, r5, r5, lsl #22
 57c:	830f05d9 	movwhi	r0, #62937	; 0xf5d9
 580:	054b0905 	strbeq	r0, [fp, #-2309]	; 0xfffff6fb
 584:	0f053010 	svceq	0x00053010
 588:	4b090583 	blmi	241b9c <__bss_end+0x23819c>
 58c:	05301005 	ldreq	r1, [r0, #-5]!
 590:	0905830f 	stmdbeq	r5, {r0, r1, r2, r3, r8, r9, pc}
 594:	3114054b 	tstcc	r4, fp, asr #10
 598:	052e0c05 	streq	r0, [lr, #-3077]!	; 0xfffff3fb
 59c:	d9210801 	stmdble	r1!, {r0, fp}
 5a0:	05852b05 	streq	r2, [r5, #2821]	; 0xb05
 5a4:	22054819 	andcs	r4, r5, #1638400	; 0x190000
 5a8:	2e0a0566 	cfsh32cs	mvfx0, mvfx10, #54
 5ac:	3c020d05 	stccc	13, cr0, [r2], {5}
 5b0:	670a0513 	smladvs	sl, r3, r5, r0
 5b4:	054a2305 	strbeq	r2, [sl, #-773]	; 0xfffffcfb
 5b8:	0a056628 	beq	159e60 <__bss_end+0x150460>
 5bc:	9f01052e 	svcls	0x0001052e
 5c0:	9f0f0585 	svcls	0x000f0585
 5c4:	054b1005 	strbeq	r1, [fp, #-5]
 5c8:	05059e2c 	streq	r9, [r5, #-3628]	; 0xfffff1d4
 5cc:	4c140582 	cfldr32mi	mvfx0, [r4], {130}	; 0x82
 5d0:	05681505 	strbeq	r1, [r8, #-1285]!	; 0xfffffafb
 5d4:	0a059e31 	beq	167ea0 <__bss_end+0x15e4a0>
 5d8:	4c140582 	cfldr32mi	mvfx0, [r4], {130}	; 0x82
 5dc:	054d0505 	strbeq	r0, [sp, #-1285]	; 0xfffffafb
 5e0:	1f056809 	svcne	0x00056809
 5e4:	4c0e0568 	cfstr32mi	mvfx0, [lr], {104}	; 0x68
 5e8:	05681f05 	strbeq	r1, [r8, #-3845]!	; 0xfffff0fb
 5ec:	23054e09 	movwcs	r4, #24073	; 0x5e09
 5f0:	4f0c0585 	svcmi	0x000c0585
 5f4:	a12f0105 			; <UNDEFINED> instruction: 0xa12f0105
 5f8:	83840a05 	orrhi	r0, r4, #20480	; 0x5000
 5fc:	83050583 	movwhi	r0, #21891	; 0x5583
 600:	05d91005 	ldrbeq	r1, [r9, #5]
 604:	10059f09 	andne	r9, r5, r9, lsl #30
 608:	9f090530 	svcls	0x00090530
 60c:	05301005 	ldreq	r1, [r0, #-5]!
 610:	0a059f09 	beq	16823c <__bss_end+0x15e83c>
 614:	bb120531 	bllt	481ae0 <__bss_end+0x4780e0>
 618:	05821905 	streq	r1, [r2, #2309]	; 0x905
 61c:	0e05bb0d 	vmlaeq.f64	d11, d5, d13
 620:	640505bb 	strvs	r0, [r5], #-1467	; 0xfffffa45
 624:	05331e05 	ldreq	r1, [r3, #-3589]!	; 0xfffff1fb
 628:	0c059e11 	stceq	14, cr9, [r5], {17}
 62c:	9f05054b 	svcls	0x0005054b
 630:	05d90f05 	ldrbeq	r0, [r9, #3845]	; 0xf05
 634:	0f058309 	svceq	0x00058309
 638:	83090530 	movwhi	r0, #38192	; 0x9530
 63c:	05300805 	ldreq	r0, [r0, #-2053]!	; 0xfffff7fb
 640:	1b056718 	blne	15a2a8 <__bss_end+0x1508a8>
 644:	9f01054a 	svcls	0x0001054a
 648:	0a053f08 	beq	150270 <__bss_end+0x146870>
 64c:	0c0583bc 	stceq	3, cr8, [r5], {188}	; 0xbc
 650:	9f090583 	svcls	0x00090583
 654:	059f0b05 	ldreq	r0, [pc, #2821]	; 1161 <shift+0x1161>
 658:	05059f0d 	streq	r9, [r5, #-3853]	; 0xfffff0f3
 65c:	080f052e 	stmdaeq	pc, {r1, r2, r3, r5, r8, sl}	; <UNPREDICTABLE>
 660:	83090524 	movwhi	r0, #38180	; 0x9524
 664:	05310f05 	ldreq	r0, [r1, #-3845]!	; 0xfffff0fb
 668:	0f058309 	svceq	0x00058309
 66c:	83090531 	movwhi	r0, #38193	; 0x9531
 670:	05310b05 	ldreq	r0, [r1, #-2821]!	; 0xfffff4fb
 674:	01058308 	tsteq	r5, r8, lsl #6
 678:	0a05f567 	beq	17dc1c <__bss_end+0x17421c>
 67c:	12058368 	andne	r8, r5, #104, 6	; 0xa0000001
 680:	82190586 	andshi	r0, r9, #562036736	; 0x21800000
 684:	05bb0d05 	ldreq	r0, [fp, #3333]!	; 0xd05
 688:	0505bb0e 	streq	fp, [r5, #-2830]	; 0xfffff4f2
 68c:	33110564 	tstcc	r1, #100, 10	; 0x19000000
 690:	054b0b05 	strbeq	r0, [fp, #-2821]	; 0xfffff4fb
 694:	0105bc10 	tsteq	r5, r0, lsl ip
 698:	1205859f 	andne	r8, r5, #666894336	; 0x27c00000
 69c:	820c05a2 	andhi	r0, ip, #679477248	; 0x28800000
 6a0:	054d0805 	strbeq	r0, [sp, #-2053]	; 0xfffff7fb
 6a4:	0c054d12 	stceq	13, cr4, [r5], {18}
 6a8:	4b100582 	blmi	401cb8 <__bss_end+0x3f82b8>
 6ac:	054a0505 	strbeq	r0, [sl, #-1285]	; 0xfffffafb
 6b0:	10054b0c 	andne	r4, r5, ip, lsl #22
 6b4:	4e14054b 	cfmac32mi	mvfx0, mvfx4, mvfx11
 6b8:	054b1905 	strbeq	r1, [fp, #-2309]	; 0xfffff6fb
 6bc:	08054b0a 	stmdaeq	r5, {r1, r3, r8, r9, fp, lr}
 6c0:	4c0a05bb 	cfstr32mi	mvfx0, [sl], {187}	; 0xbb
 6c4:	05670e05 	strbeq	r0, [r7, #-3589]!	; 0xfffff1fb
 6c8:	0e054c0a 	cdpeq	12, 0, cr4, cr5, cr10, {0}
 6cc:	01040200 	mrseq	r0, R12_usr
 6d0:	04020068 	streq	r0, [r2], #-104	; 0xffffff98
 6d4:	15058301 	strne	r8, [r5, #-769]	; 0xfffffcff
 6d8:	01040200 	mrseq	r0, R12_usr
 6dc:	000e0583 	andeq	r0, lr, r3, lsl #11
 6e0:	35010402 	strcc	r0, [r1, #-1026]	; 0xfffffbfe
 6e4:	01040200 	mrseq	r0, R12_usr
 6e8:	05667703 	strbeq	r7, [r6, #-1795]!	; 0xfffff8fd
 6ec:	04020001 	streq	r0, [r2], #-1
 6f0:	2e110301 	cdpcs	3, 1, cr0, cr1, cr1, {0}
 6f4:	01001402 	tsteq	r0, r2, lsl #8
 6f8:	0002c801 	andeq	ip, r2, r1, lsl #16
 6fc:	dd000300 	stcle	3, cr0, [r0, #-0]
 700:	02000001 	andeq	r0, r0, #1
 704:	0d0efb01 	vstreq	d15, [lr, #-4]
 708:	01010100 	mrseq	r0, (UNDEF: 17)
 70c:	00000001 	andeq	r0, r0, r1
 710:	01000001 	tsteq	r0, r1
 714:	6573552f 	ldrbvs	r5, [r3, #-1327]!	; 0xfffffad1
 718:	772f7372 			; <UNDEFINED> instruction: 0x772f7372
 71c:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
 720:	2f696a72 	svccs	0x00696a72
 724:	6b736544 	blvs	1cd9c3c <__bss_end+0x1cd023c>
 728:	2f706f74 	svccs	0x00706f74
 72c:	2f564146 	svccs	0x00564146
 730:	6176614e 	cmnvs	r6, lr, asr #2
 734:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
 738:	4f2f6963 	svcmi	0x002f6963
 73c:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
 740:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
 744:	6b6c6172 	blvs	1b18d14 <__bss_end+0x1b0f314>
 748:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
 74c:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
 750:	756f732f 	strbvc	r7, [pc, #-815]!	; 429 <shift+0x429>
 754:	73656372 	cmnvc	r5, #-939524095	; 0xc8000001
 758:	6474732f 	ldrbtvs	r7, [r4], #-815	; 0xfffffcd1
 75c:	2f62696c 	svccs	0x0062696c
 760:	00637273 	rsbeq	r7, r3, r3, ror r2
 764:	6573552f 	ldrbvs	r5, [r3, #-1327]!	; 0xfffffad1
 768:	772f7372 			; <UNDEFINED> instruction: 0x772f7372
 76c:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
 770:	2f696a72 	svccs	0x00696a72
 774:	6b736544 	blvs	1cd9c8c <__bss_end+0x1cd028c>
 778:	2f706f74 	svccs	0x00706f74
 77c:	2f564146 	svccs	0x00564146
 780:	6176614e 	cmnvs	r6, lr, asr #2
 784:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
 788:	4f2f6963 	svcmi	0x002f6963
 78c:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
 790:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
 794:	6b6c6172 	blvs	1b18d64 <__bss_end+0x1b0f364>
 798:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
 79c:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
 7a0:	756f732f 	strbvc	r7, [pc, #-815]!	; 479 <shift+0x479>
 7a4:	73656372 	cmnvc	r5, #-939524095	; 0xc8000001
 7a8:	72656b2f 	rsbvc	r6, r5, #48128	; 0xbc00
 7ac:	2f6c656e 	svccs	0x006c656e
 7b0:	6c636e69 	stclvs	14, cr6, [r3], #-420	; 0xfffffe5c
 7b4:	2f656475 	svccs	0x00656475
 7b8:	636f7270 	cmnvs	pc, #112, 4
 7bc:	00737365 	rsbseq	r7, r3, r5, ror #6
 7c0:	6573552f 	ldrbvs	r5, [r3, #-1327]!	; 0xfffffad1
 7c4:	772f7372 			; <UNDEFINED> instruction: 0x772f7372
 7c8:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
 7cc:	2f696a72 	svccs	0x00696a72
 7d0:	6b736544 	blvs	1cd9ce8 <__bss_end+0x1cd02e8>
 7d4:	2f706f74 	svccs	0x00706f74
 7d8:	2f564146 	svccs	0x00564146
 7dc:	6176614e 	cmnvs	r6, lr, asr #2
 7e0:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
 7e4:	4f2f6963 	svcmi	0x002f6963
 7e8:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
 7ec:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
 7f0:	6b6c6172 	blvs	1b18dc0 <__bss_end+0x1b0f3c0>
 7f4:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
 7f8:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
 7fc:	756f732f 	strbvc	r7, [pc, #-815]!	; 4d5 <shift+0x4d5>
 800:	73656372 	cmnvc	r5, #-939524095	; 0xc8000001
 804:	72656b2f 	rsbvc	r6, r5, #48128	; 0xbc00
 808:	2f6c656e 	svccs	0x006c656e
 80c:	6c636e69 	stclvs	14, cr6, [r3], #-420	; 0xfffffe5c
 810:	2f656475 	svccs	0x00656475
 814:	2f007366 	svccs	0x00007366
 818:	72657355 	rsbvc	r7, r5, #1409286145	; 0x54000001
 81c:	69772f73 	ldmdbvs	r7!, {r0, r1, r4, r5, r6, r8, r9, sl, fp, sp}^
 820:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
 824:	442f696a 	strtmi	r6, [pc], #-2410	; 82c <shift+0x82c>
 828:	746b7365 	strbtvc	r7, [fp], #-869	; 0xfffffc9b
 82c:	462f706f 	strtmi	r7, [pc], -pc, rrx
 830:	4e2f5641 	cfmadda32mi	mvax2, mvax5, mvfx15, mvfx1
 834:	7a617661 	bvc	185e1c0 <__bss_end+0x18547c0>
 838:	63696a75 	cmnvs	r9, #479232	; 0x75000
 83c:	534f2f69 	movtpl	r2, #65385	; 0xff69
 840:	6d65732f 	stclvs	3, cr7, [r5, #-188]!	; 0xffffff44
 844:	72747365 	rsbsvc	r7, r4, #-1811939327	; 0x94000001
 848:	616b6c61 	cmnvs	fp, r1, ror #24
 84c:	76696b2d 	strbtvc	r6, [r9], -sp, lsr #22
 850:	2f736f2d 	svccs	0x00736f2d
 854:	72756f73 	rsbsvc	r6, r5, #460	; 0x1cc
 858:	2f736563 	svccs	0x00736563
 85c:	6e72656b 	cdpvs	5, 7, cr6, cr2, cr11, {3}
 860:	692f6c65 	stmdbvs	pc!, {r0, r2, r5, r6, sl, fp, sp, lr}	; <UNPREDICTABLE>
 864:	756c636e 	strbvc	r6, [ip, #-878]!	; 0xfffffc92
 868:	622f6564 	eorvs	r6, pc, #100, 10	; 0x19000000
 86c:	6472616f 	ldrbtvs	r6, [r2], #-367	; 0xfffffe91
 870:	6970722f 	ldmdbvs	r0!, {r0, r1, r2, r3, r5, r9, ip, sp, lr}^
 874:	61682f30 	cmnvs	r8, r0, lsr pc
 878:	7300006c 	movwvc	r0, #108	; 0x6c
 87c:	69666474 	stmdbvs	r6!, {r2, r4, r5, r6, sl, sp, lr}^
 880:	632e656c 			; <UNDEFINED> instruction: 0x632e656c
 884:	01007070 	tsteq	r0, r0, ror r0
 888:	77730000 	ldrbvc	r0, [r3, -r0]!
 88c:	00682e69 	rsbeq	r2, r8, r9, ror #28
 890:	73000002 	movwvc	r0, #2
 894:	6c6e6970 			; <UNDEFINED> instruction: 0x6c6e6970
 898:	2e6b636f 	cdpcs	3, 6, cr6, cr11, cr15, {3}
 89c:	00020068 	andeq	r0, r2, r8, rrx
 8a0:	6c696600 	stclvs	6, cr6, [r9], #-0
 8a4:	73797365 	cmnvc	r9, #-1811939327	; 0x94000001
 8a8:	2e6d6574 	mcrcs	5, 3, r6, cr13, cr4, {3}
 8ac:	00030068 	andeq	r0, r3, r8, rrx
 8b0:	6f727000 	svcvs	0x00727000
 8b4:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
 8b8:	0200682e 	andeq	r6, r0, #3014656	; 0x2e0000
 8bc:	72700000 	rsbsvc	r0, r0, #0
 8c0:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
 8c4:	616d5f73 	smcvs	54771	; 0xd5f3
 8c8:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
 8cc:	00682e72 	rsbeq	r2, r8, r2, ror lr
 8d0:	69000002 	stmdbvs	r0, {r1}
 8d4:	6564746e 	strbvs	r7, [r4, #-1134]!	; 0xfffffb92
 8d8:	00682e66 	rsbeq	r2, r8, r6, ror #28
 8dc:	00000004 	andeq	r0, r0, r4
 8e0:	05000105 	streq	r0, [r0, #-261]	; 0xfffffefb
 8e4:	00898c02 	addeq	r8, r9, r2, lsl #24
 8e8:	05051600 	streq	r1, [r5, #-1536]	; 0xfffffa00
 8ec:	0c052f69 	stceq	15, cr2, [r5], {105}	; 0x69
 8f0:	2f01054c 	svccs	0x0001054c
 8f4:	83050585 	movwhi	r0, #21893	; 0x5585
 8f8:	2f01054b 	svccs	0x0001054b
 8fc:	4b050585 	blmi	141f18 <__bss_end+0x138518>
 900:	852f0105 	strhi	r0, [pc, #-261]!	; 803 <shift+0x803>
 904:	4ba10505 	blmi	fe841d20 <__bss_end+0xfe838320>
 908:	0c052f4b 	stceq	15, cr2, [r5], {75}	; 0x4b
 90c:	2f01054b 	svccs	0x0001054b
 910:	bd050585 	cfstr32lt	mvfx0, [r5, #-532]	; 0xfffffdec
 914:	2f4b4b4b 	svccs	0x004b4b4b
 918:	054c0c05 	strbeq	r0, [ip, #-3077]	; 0xfffff3fb
 91c:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 920:	4b4bbd05 	blmi	12efd3c <__bss_end+0x12e633c>
 924:	0c052f4b 	stceq	15, cr2, [r5], {75}	; 0x4b
 928:	2f01054c 	svccs	0x0001054c
 92c:	83050585 	movwhi	r0, #21893	; 0x5585
 930:	2f01054b 	svccs	0x0001054b
 934:	bd050585 	cfstr32lt	mvfx0, [r5, #-532]	; 0xfffffdec
 938:	2f4b4b4b 	svccs	0x004b4b4b
 93c:	054c0c05 	strbeq	r0, [ip, #-3077]	; 0xfffff3fb
 940:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 944:	4b4ba105 	blmi	12e8d60 <__bss_end+0x12df360>
 948:	4c0c052f 	cfstr32mi	mvfx0, [ip], {47}	; 0x2f
 94c:	852f0105 	strhi	r0, [pc, #-261]!	; 84f <shift+0x84f>
 950:	4bbd0505 	blmi	fef41d6c <__bss_end+0xfef3836c>
 954:	052f4b4b 	streq	r4, [pc, #-2891]!	; fffffe11 <__bss_end+0xffff6411>
 958:	01054c0c 	tsteq	r5, ip, lsl #24
 95c:	0505852f 	streq	r8, [r5, #-1327]	; 0xfffffad1
 960:	2f4b4ba1 	svccs	0x004b4ba1
 964:	054c0c05 	strbeq	r0, [ip, #-3077]	; 0xfffff3fb
 968:	05859f01 	streq	r9, [r5, #3841]	; 0xf01
 96c:	05056720 	streq	r6, [r5, #-1824]	; 0xfffff8e0
 970:	054b4b4d 	strbeq	r4, [fp, #-2893]	; 0xfffff4b3
 974:	0105300c 	tsteq	r5, ip
 978:	2005852f 	andcs	r8, r5, pc, lsr #10
 97c:	4d050567 	cfstr32mi	mvfx0, [r5, #-412]	; 0xfffffe64
 980:	0c054b4b 			; <UNDEFINED> instruction: 0x0c054b4b
 984:	2f010530 	svccs	0x00010530
 988:	83200585 			; <UNDEFINED> instruction: 0x83200585
 98c:	4b4c0505 	blmi	1301da8 <__bss_end+0x12f83a8>
 990:	2f01054b 	svccs	0x0001054b
 994:	67200585 	strvs	r0, [r0, -r5, lsl #11]!
 998:	4b4d0505 	blmi	1341db4 <__bss_end+0x13383b4>
 99c:	300c054b 	andcc	r0, ip, fp, asr #10
 9a0:	872f0105 	strhi	r0, [pc, -r5, lsl #2]!
 9a4:	9fa00c05 	svcls	0x00a00c05
 9a8:	05bc3105 	ldreq	r3, [ip, #261]!	; 0x105
 9ac:	36056629 	strcc	r6, [r5], -r9, lsr #12
 9b0:	300f052e 	andcc	r0, pc, lr, lsr #10
 9b4:	05661305 	strbeq	r1, [r6, #-773]!	; 0xfffffcfb
 9b8:	10058409 	andne	r8, r5, r9, lsl #8
 9bc:	9f0105d8 	svcls	0x000105d8
 9c0:	01000802 	tsteq	r0, r2, lsl #16
 9c4:	00038b01 	andeq	r8, r3, r1, lsl #22
 9c8:	74000300 	strvc	r0, [r0], #-768	; 0xfffffd00
 9cc:	02000000 	andeq	r0, r0, #0
 9d0:	0d0efb01 	vstreq	d15, [lr, #-4]
 9d4:	01010100 	mrseq	r0, (UNDEF: 17)
 9d8:	00000001 	andeq	r0, r0, r1
 9dc:	01000001 	tsteq	r0, r1
 9e0:	6573552f 	ldrbvs	r5, [r3, #-1327]!	; 0xfffffad1
 9e4:	772f7372 			; <UNDEFINED> instruction: 0x772f7372
 9e8:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
 9ec:	2f696a72 	svccs	0x00696a72
 9f0:	6b736544 	blvs	1cd9f08 <__bss_end+0x1cd0508>
 9f4:	2f706f74 	svccs	0x00706f74
 9f8:	2f564146 	svccs	0x00564146
 9fc:	6176614e 	cmnvs	r6, lr, asr #2
 a00:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
 a04:	4f2f6963 	svcmi	0x002f6963
 a08:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
 a0c:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
 a10:	6b6c6172 	blvs	1b18fe0 <__bss_end+0x1b0f5e0>
 a14:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
 a18:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
 a1c:	756f732f 	strbvc	r7, [pc, #-815]!	; 6f5 <shift+0x6f5>
 a20:	73656372 	cmnvc	r5, #-939524095	; 0xc8000001
 a24:	6474732f 	ldrbtvs	r7, [r4], #-815	; 0xfffffcd1
 a28:	2f62696c 	svccs	0x0062696c
 a2c:	00637273 	rsbeq	r7, r3, r3, ror r2
 a30:	64747300 	ldrbtvs	r7, [r4], #-768	; 0xfffffd00
 a34:	69727473 	ldmdbvs	r2!, {r0, r1, r4, r5, r6, sl, ip, sp, lr}^
 a38:	632e676e 			; <UNDEFINED> instruction: 0x632e676e
 a3c:	01007070 	tsteq	r0, r0, ror r0
 a40:	05000000 	streq	r0, [r0, #-0]
 a44:	02050001 	andeq	r0, r5, #1
 a48:	00008de8 	andeq	r8, r0, r8, ror #27
 a4c:	bb06051a 	bllt	181ebc <__bss_end+0x1784bc>
 a50:	054c0f05 	strbeq	r0, [ip, #-3845]	; 0xfffff0fb
 a54:	0a056821 	beq	15aae0 <__bss_end+0x1510e0>
 a58:	2e0b05ba 	mcrcs	5, 0, r0, cr11, cr10, {5}
 a5c:	054a2705 	strbeq	r2, [sl, #-1797]	; 0xfffff8fb
 a60:	09054a0d 	stmdbeq	r5, {r0, r2, r3, r9, fp, lr}
 a64:	9f04052f 	svcls	0x0004052f
 a68:	05620205 	strbeq	r0, [r2, #-517]!	; 0xfffffdfb
 a6c:	10053505 	andne	r3, r5, r5, lsl #10
 a70:	2e110568 	cfmsc32cs	mvfx0, mvfx1, mvfx8
 a74:	054a2205 	strbeq	r2, [sl, #-517]	; 0xfffffdfb
 a78:	0a052e13 	beq	14c2cc <__bss_end+0x1428cc>
 a7c:	6909052f 	stmdbvs	r9, {r0, r1, r2, r3, r5, r8, sl}
 a80:	052e0a05 	streq	r0, [lr, #-2565]!	; 0xfffff5fb
 a84:	03054a0c 	movweq	r4, #23052	; 0x5a0c
 a88:	680b054b 	stmdavs	fp, {r0, r1, r3, r6, r8, sl}
 a8c:	02001805 	andeq	r1, r0, #327680	; 0x50000
 a90:	054a0304 	strbeq	r0, [sl, #-772]	; 0xfffffcfc
 a94:	04020014 	streq	r0, [r2], #-20	; 0xffffffec
 a98:	15059e03 	strne	r9, [r5, #-3587]	; 0xfffff1fd
 a9c:	02040200 	andeq	r0, r4, #0, 4
 aa0:	00180568 	andseq	r0, r8, r8, ror #10
 aa4:	82020402 	andhi	r0, r2, #33554432	; 0x2000000
 aa8:	02000805 	andeq	r0, r0, #327680	; 0x50000
 aac:	054a0204 	strbeq	r0, [sl, #-516]	; 0xfffffdfc
 ab0:	0402001a 	streq	r0, [r2], #-26	; 0xffffffe6
 ab4:	1b054b02 	blne	1536c4 <__bss_end+0x149cc4>
 ab8:	02040200 	andeq	r0, r4, #0, 4
 abc:	000c052e 	andeq	r0, ip, lr, lsr #10
 ac0:	4a020402 	bmi	81ad0 <__bss_end+0x780d0>
 ac4:	02000f05 	andeq	r0, r0, #5, 30
 ac8:	05820204 	streq	r0, [r2, #516]	; 0x204
 acc:	0402001b 	streq	r0, [r2], #-27	; 0xffffffe5
 ad0:	11054a02 	tstne	r5, r2, lsl #20
 ad4:	02040200 	andeq	r0, r4, #0, 4
 ad8:	000a052e 	andeq	r0, sl, lr, lsr #10
 adc:	2f020402 	svccs	0x00020402
 ae0:	02000b05 	andeq	r0, r0, #5120	; 0x1400
 ae4:	052e0204 	streq	r0, [lr, #-516]!	; 0xfffffdfc
 ae8:	0402000d 	streq	r0, [r2], #-13
 aec:	02054a02 	andeq	r4, r5, #8192	; 0x2000
 af0:	02040200 	andeq	r0, r4, #0, 4
 af4:	88010546 	stmdahi	r1, {r1, r2, r6, r8, sl}
 af8:	83060585 	movwhi	r0, #25989	; 0x6585
 afc:	054c0905 	strbeq	r0, [ip, #-2309]	; 0xfffff6fb
 b00:	0a054a10 	beq	153348 <__bss_end+0x149948>
 b04:	bb07054c 	bllt	1c203c <__bss_end+0x1b863c>
 b08:	054a0305 	strbeq	r0, [sl, #-773]	; 0xfffffcfb
 b0c:	04020017 	streq	r0, [r2], #-23	; 0xffffffe9
 b10:	14054a01 	strne	r4, [r5], #-2561	; 0xfffff5ff
 b14:	01040200 	mrseq	r0, R12_usr
 b18:	4d0d054a 	cfstr32mi	mvfx0, [sp, #-296]	; 0xfffffed8
 b1c:	054a1405 	strbeq	r1, [sl, #-1029]	; 0xfffffbfb
 b20:	08052e0a 	stmdaeq	r5, {r1, r3, r9, sl, fp, sp}
 b24:	03020568 	movweq	r0, #9576	; 0x2568
 b28:	09056678 	stmdbeq	r5, {r3, r4, r5, r6, r9, sl, sp, lr}
 b2c:	052e0b03 	streq	r0, [lr, #-2819]!	; 0xfffff4fd
 b30:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 b34:	0505bb08 	streq	fp, [r5, #-2824]	; 0xfffff4f8
 b38:	830d054d 	movwhi	r0, #54605	; 0xd54d
 b3c:	05661005 	strbeq	r1, [r6, #-5]!
 b40:	09054b0f 	stmdbeq	r5, {r0, r1, r2, r3, r8, r9, fp, lr}
 b44:	831c056a 	tsthi	ip, #444596224	; 0x1a800000
 b48:	6a660b05 	bvs	1983764 <__bss_end+0x1979d64>
 b4c:	054b0505 	strbeq	r0, [fp, #-1285]	; 0xfffffafb
 b50:	14056711 	strne	r6, [r5], #-1809	; 0xfffff8ef
 b54:	68190566 	ldmdavs	r9, {r1, r2, r5, r6, r8, sl}
 b58:	05672a05 	strbeq	r2, [r7, #-2565]!	; 0xfffff5fb
 b5c:	0558081e 	ldrbeq	r0, [r8, #-2078]	; 0xfffff7e2
 b60:	1e052e15 	mcrne	14, 0, r2, cr5, cr5, {0}
 b64:	4a180566 	bmi	602104 <__bss_end+0x5f8704>
 b68:	052f1605 	streq	r1, [pc, #-1541]!	; 56b <shift+0x56b>
 b6c:	1405d409 	strne	sp, [r5], #-1033	; 0xfffffbf7
 b70:	83100535 	tsthi	r0, #222298112	; 0xd400000
 b74:	05660d05 	strbeq	r0, [r6, #-3333]!	; 0xfffff2fb
 b78:	10056612 	andne	r6, r5, r2, lsl r6
 b7c:	2d05054a 	cfstr32cs	mvfx0, [r5, #-296]	; 0xfffffed8
 b80:	670d0533 	smladxvs	sp, r3, r5, r0
 b84:	05661005 	strbeq	r1, [r6, #-5]!
 b88:	15054e0e 	strne	r4, [r5, #-3598]	; 0xfffff1f2
 b8c:	03040200 	movweq	r0, #16896	; 0x4200
 b90:	0017054a 	andseq	r0, r7, sl, asr #10
 b94:	2e030402 	cdpcs	4, 0, cr0, cr3, cr2, {0}
 b98:	02001205 	andeq	r1, r0, #1342177280	; 0x50000000
 b9c:	05670204 	strbeq	r0, [r7, #-516]!	; 0xfffffdfc
 ba0:	0402000d 	streq	r0, [r2], #-13
 ba4:	16058302 	strne	r8, [r5], -r2, lsl #6
 ba8:	02040200 	andeq	r0, r4, #0, 4
 bac:	000d0583 	andeq	r0, sp, r3, lsl #11
 bb0:	4a020402 	bmi	81bc0 <__bss_end+0x781c0>
 bb4:	02001605 	andeq	r1, r0, #5242880	; 0x500000
 bb8:	05660204 	strbeq	r0, [r6, #-516]!	; 0xfffffdfc
 bbc:	04020010 	streq	r0, [r2], #-16
 bc0:	12054a02 	andne	r4, r5, #8192	; 0x2000
 bc4:	02040200 	andeq	r0, r4, #0, 4
 bc8:	0005052f 	andeq	r0, r5, pc, lsr #10
 bcc:	b6020402 	strlt	r0, [r2], -r2, lsl #8
 bd0:	058a0a05 	streq	r0, [sl, #2565]	; 0xa05
 bd4:	0f056905 	svceq	0x00056905
 bd8:	671d0567 	ldrvs	r0, [sp, -r7, ror #10]
 bdc:	02002005 	andeq	r2, r0, #5
 be0:	05820104 	streq	r0, [r2, #260]	; 0x104
 be4:	0402001d 	streq	r0, [r2], #-29	; 0xffffffe3
 be8:	11054a01 	tstne	r5, r1, lsl #20
 bec:	6614054b 	ldrvs	r0, [r4], -fp, asr #10
 bf0:	31490905 	cmpcc	r9, r5, lsl #18
 bf4:	02001d05 	andeq	r1, r0, #320	; 0x140
 bf8:	05820104 	streq	r0, [r2, #260]	; 0x104
 bfc:	0402001a 	streq	r0, [r2], #-26	; 0xffffffe6
 c00:	12054a01 	andne	r4, r5, #4096	; 0x1000
 c04:	6a0c054b 	bvs	302138 <__bss_end+0x2f8738>
 c08:	bd2f0105 	stflts	f0, [pc, #-20]!	; bfc <shift+0xbfc>
 c0c:	05bd0905 	ldreq	r0, [sp, #2309]!	; 0x905
 c10:	04020016 	streq	r0, [r2], #-22	; 0xffffffea
 c14:	1d054a04 	vstrne	s8, [r5, #-16]
 c18:	02040200 	andeq	r0, r4, #0, 4
 c1c:	001e0582 	andseq	r0, lr, r2, lsl #11
 c20:	2e020402 	cdpcs	4, 0, cr0, cr2, cr2, {0}
 c24:	02001605 	andeq	r1, r0, #5242880	; 0x500000
 c28:	05660204 	strbeq	r0, [r6, #-516]!	; 0xfffffdfc
 c2c:	04020011 	streq	r0, [r2], #-17	; 0xffffffef
 c30:	12054b03 	andne	r4, r5, #3072	; 0xc00
 c34:	03040200 	movweq	r0, #16896	; 0x4200
 c38:	0008052e 	andeq	r0, r8, lr, lsr #10
 c3c:	4a030402 	bmi	c1c4c <__bss_end+0xb824c>
 c40:	02000905 	andeq	r0, r0, #81920	; 0x14000
 c44:	052e0304 	streq	r0, [lr, #-772]!	; 0xfffffcfc
 c48:	04020012 	streq	r0, [r2], #-18	; 0xffffffee
 c4c:	0b054a03 	bleq	153460 <__bss_end+0x149a60>
 c50:	03040200 	movweq	r0, #16896	; 0x4200
 c54:	0002052e 	andeq	r0, r2, lr, lsr #10
 c58:	2d030402 	cfstrscs	mvf0, [r3, #-8]
 c5c:	02000b05 	andeq	r0, r0, #5120	; 0x1400
 c60:	05840204 	streq	r0, [r4, #516]	; 0x204
 c64:	04020008 	streq	r0, [r2], #-8
 c68:	09058301 	stmdbeq	r5, {r0, r8, r9, pc}
 c6c:	01040200 	mrseq	r0, R12_usr
 c70:	000b052e 	andeq	r0, fp, lr, lsr #10
 c74:	4a010402 	bmi	41c84 <__bss_end+0x38284>
 c78:	02000205 	andeq	r0, r0, #1342177280	; 0x50000000
 c7c:	05490104 	strbeq	r0, [r9, #-260]	; 0xfffffefc
 c80:	0105850b 	tsteq	r5, fp, lsl #10
 c84:	0e05852f 	cfsh32eq	mvfx8, mvfx5, #31
 c88:	661105bc 			; <UNDEFINED> instruction: 0x661105bc
 c8c:	05bc2005 	ldreq	r2, [ip, #5]!
 c90:	1f05660b 	svcne	0x0005660b
 c94:	660a054b 	strvs	r0, [sl], -fp, asr #10
 c98:	054b0805 	strbeq	r0, [fp, #-2053]	; 0xfffff7fb
 c9c:	16058311 			; <UNDEFINED> instruction: 0x16058311
 ca0:	6708052e 	strvs	r0, [r8, -lr, lsr #10]
 ca4:	05671105 	strbeq	r1, [r7, #-261]!	; 0xfffffefb
 ca8:	01054d0b 	tsteq	r5, fp, lsl #26
 cac:	0605852f 	streq	r8, [r5], -pc, lsr #10
 cb0:	4c0b0583 	cfstr32mi	mvfx0, [fp], {131}	; 0x83
 cb4:	052e0c05 	streq	r0, [lr, #-3077]!	; 0xfffff3fb
 cb8:	0405660e 	streq	r6, [r5], #-1550	; 0xfffff9f2
 cbc:	6502054b 	strvs	r0, [r2, #-1355]	; 0xfffffab5
 cc0:	05310905 	ldreq	r0, [r1, #-2309]!	; 0xfffff6fb
 cc4:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 cc8:	0b059f08 	bleq	1688f0 <__bss_end+0x15eef0>
 ccc:	0014054c 	andseq	r0, r4, ip, asr #10
 cd0:	4a030402 	bmi	c1ce0 <__bss_end+0xb82e0>
 cd4:	02000705 	andeq	r0, r0, #1310720	; 0x140000
 cd8:	05830204 	streq	r0, [r3, #516]	; 0x204
 cdc:	04020008 	streq	r0, [r2], #-8
 ce0:	0a052e02 	beq	14c4f0 <__bss_end+0x142af0>
 ce4:	02040200 	andeq	r0, r4, #0, 4
 ce8:	0002054a 	andeq	r0, r2, sl, asr #10
 cec:	49020402 	stmdbmi	r2, {r1, sl}
 cf0:	85840105 	strhi	r0, [r4, #261]	; 0x105
 cf4:	05bb0e05 	ldreq	r0, [fp, #3589]!	; 0xe05
 cf8:	0b054b08 	bleq	153920 <__bss_end+0x149f20>
 cfc:	0014054c 	andseq	r0, r4, ip, asr #10
 d00:	4a030402 	bmi	c1d10 <__bss_end+0xb8310>
 d04:	02001605 	andeq	r1, r0, #5242880	; 0x500000
 d08:	05830204 	streq	r0, [r3, #516]	; 0x204
 d0c:	04020017 	streq	r0, [r2], #-23	; 0xffffffe9
 d10:	0a052e02 	beq	14c520 <__bss_end+0x142b20>
 d14:	02040200 	andeq	r0, r4, #0, 4
 d18:	000b054a 	andeq	r0, fp, sl, asr #10
 d1c:	2e020402 	cdpcs	4, 0, cr0, cr2, cr2, {0}
 d20:	02001705 	andeq	r1, r0, #1310720	; 0x140000
 d24:	054a0204 	strbeq	r0, [sl, #-516]	; 0xfffffdfc
 d28:	0402000d 	streq	r0, [r2], #-13
 d2c:	02052e02 	andeq	r2, r5, #2, 28
 d30:	02040200 	andeq	r0, r4, #0, 4
 d34:	8401052d 	strhi	r0, [r1], #-1325	; 0xfffffad3
 d38:	05842a05 	streq	r2, [r4, #2565]	; 0xa05
 d3c:	05679f10 	strbeq	r9, [r7, #-3856]!	; 0xfffff0f0
 d40:	09056711 	stmdbeq	r5, {r0, r4, r8, r9, sl, sp, lr}
 d44:	1005bb2e 	andne	fp, r5, lr, lsr #22
 d48:	66120566 	ldrvs	r0, [r2], -r6, ror #10
 d4c:	024b0105 	subeq	r0, fp, #1073741825	; 0x40000001
 d50:	01010006 	tsteq	r1, r6

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
      58:	0bd70704 	bleq	ff5c1c70 <__bss_end+0xff5b8270>
      5c:	5b020000 	blpl	80064 <__bss_end+0x76664>
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
     128:	00000bd7 	ldrdeq	r0, [r0], -r7
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
     174:	cb104801 	blgt	412180 <__bss_end+0x408780>
     178:	d4000000 	strle	r0, [r0], #-0
     17c:	58000081 	stmdapl	r0, {r0, r7}
     180:	01000000 	mrseq	r0, (UNDEF: 0)
     184:	0000cb9c 	muleq	r0, ip, fp
     188:	02b40a00 	adcseq	r0, r4, #0, 20
     18c:	4a010000 	bmi	40194 <__bss_end+0x36794>
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
     21c:	ba0d9c01 	blt	367228 <__bss_end+0x35d828>
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
     24c:	8b120f01 	blhi	483e58 <__bss_end+0x47a458>
     250:	0f000001 	svceq	0x00000001
     254:	0000019e 	muleq	r0, lr, r1
     258:	03d51000 	bicseq	r1, r5, #0
     25c:	0a010000 	beq	40264 <__bss_end+0x36864>
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
     2b4:	8b140074 	blhi	50048c <__bss_end+0x4f6a8c>
     2b8:	a4000001 	strge	r0, [r0], #-1
     2bc:	38000080 	stmdacc	r0, {r7}
     2c0:	01000000 	mrseq	r0, (UNDEF: 0)
     2c4:	0067139c 	mlseq	r7, ip, r3, r1
     2c8:	9e2f0a01 	vmulls.f32	s0, s30, s2
     2cc:	02000001 	andeq	r0, r0, #1
     2d0:	00007491 	muleq	r0, r1, r4
     2d4:	00000b5f 	andeq	r0, r0, pc, asr fp
     2d8:	01e00004 	mvneq	r0, r4
     2dc:	01040000 	mrseq	r0, (UNDEF: 4)
     2e0:	000001e1 	andeq	r0, r0, r1, ror #3
     2e4:	00076b04 	andeq	r6, r7, r4, lsl #22
     2e8:	00005600 	andeq	r5, r0, r0, lsl #12
     2ec:	00822c00 	addeq	r2, r2, r0, lsl #24
     2f0:	00076000 	andeq	r6, r7, r0
     2f4:	00024600 	andeq	r4, r2, r0, lsl #12
     2f8:	08010200 	stmdaeq	r1, {r9}
     2fc:	00000c91 	muleq	r0, r1, ip
     300:	00002503 	andeq	r2, r0, r3, lsl #10
     304:	05020200 	streq	r0, [r2, #-512]	; 0xfffffe00
     308:	00000af7 	strdeq	r0, [r0], -r7
     30c:	69050404 	stmdbvs	r5, {r2, sl}
     310:	0500746e 	streq	r7, [r0, #-1134]	; 0xfffffb92
     314:	00000887 	andeq	r0, r0, r7, lsl #17
     318:	4b070702 	blmi	1c1f28 <__bss_end+0x1b8528>
     31c:	02000000 	andeq	r0, r0, #0
     320:	0c880801 	stceq	8, cr0, [r8], {1}
     324:	7e050000 	cdpvc	0, 0, cr0, cr5, cr0, {0}
     328:	0200000a 	andeq	r0, r0, #10
     32c:	005e0708 	subseq	r0, lr, r8, lsl #14
     330:	02020000 	andeq	r0, r2, #0
     334:	000d6d07 	andeq	r6, sp, r7, lsl #26
     338:	06610500 	strbteq	r0, [r1], -r0, lsl #10
     33c:	09020000 	stmdbeq	r2, {}	; <UNPREDICTABLE>
     340:	00007607 	andeq	r7, r0, r7, lsl #12
     344:	00650300 	rsbeq	r0, r5, r0, lsl #6
     348:	04020000 	streq	r0, [r2], #-0
     34c:	000bd707 	andeq	sp, fp, r7, lsl #14
     350:	00760300 	rsbseq	r0, r6, r0, lsl #6
     354:	28060000 	stmdacs	r6, {}	; <UNPREDICTABLE>
     358:	0800000e 	stmdaeq	r0, {r1, r2, r3}
     35c:	a8080603 	stmdage	r8, {r0, r1, r9, sl}
     360:	07000000 	streq	r0, [r0, -r0]
     364:	03003072 	movweq	r3, #114	; 0x72
     368:	00650e08 	rsbeq	r0, r5, r8, lsl #28
     36c:	07000000 	streq	r0, [r0, -r0]
     370:	03003172 	movweq	r3, #370	; 0x172
     374:	00650e09 	rsbeq	r0, r5, r9, lsl #28
     378:	00040000 	andeq	r0, r4, r0
     37c:	000b4c08 	andeq	r4, fp, r8, lsl #24
     380:	38040500 	stmdacc	r4, {r8, sl}
     384:	03000000 	movweq	r0, #0
     388:	00df0c1e 	sbcseq	r0, pc, lr, lsl ip	; <UNPREDICTABLE>
     38c:	59090000 	stmdbpl	r9, {}	; <UNPREDICTABLE>
     390:	00000006 	andeq	r0, r0, r6
     394:	00082c09 	andeq	r2, r8, r9, lsl #24
     398:	6e090100 	adfvse	f0, f1, f0
     39c:	0200000b 	andeq	r0, r0, #11
     3a0:	000cc409 	andeq	ip, ip, r9, lsl #8
     3a4:	0d090300 	stceq	3, cr0, [r9, #-0]
     3a8:	04000008 	streq	r0, [r0], #-8
     3ac:	000ad609 	andeq	sp, sl, r9, lsl #12
     3b0:	08000500 	stmdaeq	r0, {r8, sl}
     3b4:	00000b34 	andeq	r0, r0, r4, lsr fp
     3b8:	00380405 	eorseq	r0, r8, r5, lsl #8
     3bc:	3f030000 	svccc	0x00030000
     3c0:	00011c0c 	andeq	r1, r1, ip, lsl #24
     3c4:	07320900 	ldreq	r0, [r2, -r0, lsl #18]!
     3c8:	09000000 	stmdbeq	r0, {}	; <UNPREDICTABLE>
     3cc:	00000827 	andeq	r0, r0, r7, lsr #16
     3d0:	0dc10901 	vstreq.16	s1, [r1, #2]	; <UNPREDICTABLE>
     3d4:	09020000 	stmdbeq	r2, {}	; <UNPREDICTABLE>
     3d8:	00000a13 	andeq	r0, r0, r3, lsl sl
     3dc:	08210903 	stmdaeq	r1!, {r0, r1, r8, fp}
     3e0:	09040000 	stmdbeq	r4, {}	; <UNPREDICTABLE>
     3e4:	0000088f 	andeq	r0, r0, pc, lsl #17
     3e8:	068b0905 	streq	r0, [fp], r5, lsl #18
     3ec:	00060000 	andeq	r0, r6, r0
     3f0:	00066a08 	andeq	r6, r6, r8, lsl #20
     3f4:	38040500 	stmdacc	r4, {r8, sl}
     3f8:	03000000 	movweq	r0, #0
     3fc:	01470c66 	cmpeq	r7, r6, ror #24
     400:	7d090000 	stcvc	0, cr0, [r9, #-0]
     404:	0000000c 	andeq	r0, r0, ip
     408:	00058709 	andeq	r8, r5, r9, lsl #14
     40c:	9e090100 	adflse	f0, f1, f0
     410:	0200000b 	andeq	r0, r0, #11
     414:	000adf09 	andeq	sp, sl, r9, lsl #30
     418:	0a000300 	beq	1020 <shift+0x1020>
     41c:	000009e5 	andeq	r0, r0, r5, ror #19
     420:	71140504 	tstvc	r4, r4, lsl #10
     424:	05000000 	streq	r0, [r0, #-0]
     428:	0097b803 	addseq	fp, r7, r3, lsl #16
     42c:	0bff0a00 	bleq	fffc2c34 <__bss_end+0xfffb9234>
     430:	06040000 	streq	r0, [r4], -r0
     434:	00007114 	andeq	r7, r0, r4, lsl r1
     438:	bc030500 	cfstr32lt	mvfx0, [r3], {-0}
     43c:	0a000097 	beq	6a0 <shift+0x6a0>
     440:	000008aa 	andeq	r0, r0, sl, lsr #17
     444:	711a0705 	tstvc	sl, r5, lsl #14
     448:	05000000 	streq	r0, [r0, #-0]
     44c:	0097c003 	addseq	ip, r7, r3
     450:	0b010a00 	bleq	42c58 <__bss_end+0x39258>
     454:	09050000 	stmdbeq	r5, {}	; <UNPREDICTABLE>
     458:	0000711a 	andeq	r7, r0, sl, lsl r1
     45c:	c4030500 	strgt	r0, [r3], #-1280	; 0xfffffb00
     460:	0a000097 	beq	6c4 <shift+0x6c4>
     464:	0000089c 	muleq	r0, ip, r8
     468:	711a0b05 	tstvc	sl, r5, lsl #22
     46c:	05000000 	streq	r0, [r0, #-0]
     470:	0097c803 	addseq	ip, r7, r3, lsl #16
     474:	0ac30a00 	beq	ff0c2c7c <__bss_end+0xff0b927c>
     478:	0d050000 	stceq	0, cr0, [r5, #-0]
     47c:	0000711a 	andeq	r7, r0, sl, lsl r1
     480:	cc030500 	cfstr32gt	mvfx0, [r3], {-0}
     484:	0a000097 	beq	6e8 <shift+0x6e8>
     488:	00000639 	andeq	r0, r0, r9, lsr r6
     48c:	711a0f05 	tstvc	sl, r5, lsl #30
     490:	05000000 	streq	r0, [r0, #-0]
     494:	0097d003 	addseq	sp, r7, r3
     498:	121a0800 	andsne	r0, sl, #0, 16
     49c:	04050000 	streq	r0, [r5], #-0
     4a0:	00000038 	andeq	r0, r0, r8, lsr r0
     4a4:	ea0c1b05 	b	3070c0 <__bss_end+0x2fd6c0>
     4a8:	09000001 	stmdbeq	r0, {r0}
     4ac:	000005de 	ldrdeq	r0, [r0], -lr
     4b0:	0d0c0900 	vstreq.16	s0, [ip, #-0]	; <UNPREDICTABLE>
     4b4:	09010000 	stmdbeq	r1, {}	; <UNPREDICTABLE>
     4b8:	00000dbc 			; <UNDEFINED> instruction: 0x00000dbc
     4bc:	590b0002 	stmdbpl	fp, {r1}
     4c0:	0c000004 	stceq	0, cr0, [r0], {4}
     4c4:	00000025 	andeq	r0, r0, r5, lsr #32
     4c8:	000001ff 	strdeq	r0, [r0], -pc	; <UNPREDICTABLE>
     4cc:	0000760d 	andeq	r7, r0, sp, lsl #12
     4d0:	02000f00 	andeq	r0, r0, #0, 30
     4d4:	090e0201 	stmdbeq	lr, {r0, r9}
     4d8:	040e0000 	streq	r0, [lr], #-0
     4dc:	0000002c 	andeq	r0, r0, ip, lsr #32
     4e0:	01ea040e 	mvneq	r0, lr, lsl #8
     4e4:	f20a0000 	vhadd.s8	d0, d10, d0
     4e8:	06000005 	streq	r0, [r0], -r5
     4ec:	00711404 	rsbseq	r1, r1, r4, lsl #8
     4f0:	03050000 	movweq	r0, #20480	; 0x5000
     4f4:	000097d4 	ldrdeq	r9, [r0], -r4
     4f8:	000b800a 	andeq	r8, fp, sl
     4fc:	14070600 	strne	r0, [r7], #-1536	; 0xfffffa00
     500:	00000071 	andeq	r0, r0, r1, ror r0
     504:	97d80305 	ldrbls	r0, [r8, r5, lsl #6]
     508:	2b0a0000 	blcs	280510 <__bss_end+0x276b10>
     50c:	06000005 	streq	r0, [r0], -r5
     510:	0071140a 	rsbseq	r1, r1, sl, lsl #8
     514:	03050000 	movweq	r0, #20480	; 0x5000
     518:	000097dc 	ldrdeq	r9, [r0], -ip
     51c:	00069008 	andeq	r9, r6, r8
     520:	38040500 	stmdacc	r4, {r8, sl}
     524:	06000000 	streq	r0, [r0], -r0
     528:	027f0c0d 	rsbseq	r0, pc, #3328	; 0xd00
     52c:	4e0f0000 	cdpmi	0, 0, cr0, cr15, cr0, {0}
     530:	00007765 	andeq	r7, r0, r5, ror #14
     534:	00050b09 	andeq	r0, r5, r9, lsl #22
     538:	23090100 	movwcs	r0, #37120	; 0x9100
     53c:	02000005 	andeq	r0, r0, #5
     540:	0006a909 	andeq	sl, r6, r9, lsl #18
     544:	b6090300 	strlt	r0, [r9], -r0, lsl #6
     548:	0400000c 	streq	r0, [r0], #-12
     54c:	0004f809 	andeq	pc, r4, r9, lsl #16
     550:	06000500 	streq	r0, [r0], -r0, lsl #10
     554:	0000060b 	andeq	r0, r0, fp, lsl #12
     558:	081b0610 	ldmdaeq	fp, {r4, r9, sl}
     55c:	000002be 			; <UNDEFINED> instruction: 0x000002be
     560:	00726c07 	rsbseq	r6, r2, r7, lsl #24
     564:	be131d06 	cdplt	13, 1, cr1, cr3, cr6, {0}
     568:	00000002 	andeq	r0, r0, r2
     56c:	00707307 	rsbseq	r7, r0, r7, lsl #6
     570:	be131e06 	cdplt	14, 1, cr1, cr3, cr6, {0}
     574:	04000002 	streq	r0, [r0], #-2
     578:	00637007 	rsbeq	r7, r3, r7
     57c:	be131f06 	cdplt	15, 1, cr1, cr3, cr6, {0}
     580:	08000002 	stmdaeq	r0, {r1}
     584:	000b2410 	andeq	r2, fp, r0, lsl r4
     588:	13200600 	nopne	{0}	; <UNPREDICTABLE>
     58c:	000002be 			; <UNDEFINED> instruction: 0x000002be
     590:	0402000c 	streq	r0, [r2], #-12
     594:	000bd207 	andeq	sp, fp, r7, lsl #4
     598:	02be0300 	adcseq	r0, lr, #0, 6
     59c:	00060000 	andeq	r0, r6, r0
     5a0:	70000008 	andvc	r0, r0, r8
     5a4:	5a082806 	bpl	20a5c4 <__bss_end+0x200bc4>
     5a8:	10000003 	andne	r0, r0, r3
     5ac:	00000711 	andeq	r0, r0, r1, lsl r7
     5b0:	7f122a06 	svcvc	0x00122a06
     5b4:	00000002 	andeq	r0, r0, r2
     5b8:	64697007 	strbtvs	r7, [r9], #-7
     5bc:	122b0600 	eorne	r0, fp, #0, 12
     5c0:	00000076 	andeq	r0, r0, r6, ror r0
     5c4:	0a951010 	beq	fe54460c <__bss_end+0xfe53ac0c>
     5c8:	2c060000 	stccs	0, cr0, [r6], {-0}
     5cc:	00024811 	andeq	r4, r2, r1, lsl r8
     5d0:	6f101400 	svcvs	0x00101400
     5d4:	0600000c 	streq	r0, [r0], -ip
     5d8:	0076122d 	rsbseq	r1, r6, sp, lsr #4
     5dc:	10180000 	andsne	r0, r8, r0
     5e0:	000003e9 	andeq	r0, r0, r9, ror #7
     5e4:	76122e06 	ldrvc	r2, [r2], -r6, lsl #28
     5e8:	1c000000 	stcne	0, cr0, [r0], {-0}
     5ec:	000b6110 	andeq	r6, fp, r0, lsl r1
     5f0:	0c2f0600 	stceq	6, cr0, [pc], #-0	; 5f8 <shift+0x5f8>
     5f4:	0000035a 	andeq	r0, r0, sl, asr r3
     5f8:	04861020 	streq	r1, [r6], #32
     5fc:	30060000 	andcc	r0, r6, r0
     600:	00003809 	andeq	r3, r0, r9, lsl #16
     604:	c4106000 	ldrgt	r6, [r0], #-0
     608:	06000006 	streq	r0, [r0], -r6
     60c:	00650e31 	rsbeq	r0, r5, r1, lsr lr
     610:	10640000 	rsbne	r0, r4, r0
     614:	00000a61 	andeq	r0, r0, r1, ror #20
     618:	650e3306 	strvs	r3, [lr, #-774]	; 0xfffffcfa
     61c:	68000000 	stmdavs	r0, {}	; <UNPREDICTABLE>
     620:	000a5810 	andeq	r5, sl, r0, lsl r8
     624:	0e340600 	cfmsuba32eq	mvax0, mvax0, mvfx4, mvfx0
     628:	00000065 	andeq	r0, r0, r5, rrx
     62c:	0c0c006c 	stceq	0, cr0, [ip], {108}	; 0x6c
     630:	6a000002 	bvs	640 <shift+0x640>
     634:	0d000003 	stceq	0, cr0, [r0, #-12]
     638:	00000076 	andeq	r0, r0, r6, ror r0
     63c:	140a000f 	strne	r0, [sl], #-15
     640:	07000005 	streq	r0, [r0, -r5]
     644:	0071140a 	rsbseq	r1, r1, sl, lsl #8
     648:	03050000 	movweq	r0, #20480	; 0x5000
     64c:	000097e0 	andeq	r9, r0, r0, ror #15
     650:	0008e508 	andeq	lr, r8, r8, lsl #10
     654:	38040500 	stmdacc	r4, {r8, sl}
     658:	07000000 	streq	r0, [r0, -r0]
     65c:	039b0c0d 	orrseq	r0, fp, #3328	; 0xd00
     660:	c7090000 	strgt	r0, [r9, -r0]
     664:	0000000d 	andeq	r0, r0, sp
     668:	000d2009 	andeq	r2, sp, r9
     66c:	06000100 	streq	r0, [r0], -r0, lsl #2
     670:	000006f3 	strdeq	r0, [r0], -r3
     674:	081b070c 	ldmdaeq	fp, {r2, r3, r8, r9, sl}
     678:	000003d0 	ldrdeq	r0, [r0], -r0	; <UNPREDICTABLE>
     67c:	0005ab10 	andeq	sl, r5, r0, lsl fp
     680:	191d0700 	ldmdbne	sp, {r8, r9, sl}
     684:	000003d0 	ldrdeq	r0, [r0], -r0	; <UNPREDICTABLE>
     688:	05061000 	streq	r1, [r6, #-0]
     68c:	1e070000 	cdpne	0, 0, cr0, cr7, cr0, {0}
     690:	0003d019 	andeq	sp, r3, r9, lsl r0
     694:	09100400 	ldmdbeq	r0, {sl}
     698:	07000009 	streq	r0, [r0, -r9]
     69c:	03d6131f 	bicseq	r1, r6, #2080374784	; 0x7c000000
     6a0:	00080000 	andeq	r0, r8, r0
     6a4:	039b040e 	orrseq	r0, fp, #234881024	; 0xe000000
     6a8:	040e0000 	streq	r0, [lr], #-0
     6ac:	000002ca 	andeq	r0, r0, sl, asr #5
     6b0:	000b1311 	andeq	r1, fp, r1, lsl r3
     6b4:	22071400 	andcs	r1, r7, #0, 8
     6b8:	00065e07 	andeq	r5, r6, r7, lsl #28
     6bc:	09f31000 	ldmibeq	r3!, {ip}^
     6c0:	26070000 	strcs	r0, [r7], -r0
     6c4:	00006512 	andeq	r6, r0, r2, lsl r5
     6c8:	95100000 	ldrls	r0, [r0, #-0]
     6cc:	07000009 	streq	r0, [r0, -r9]
     6d0:	03d01d29 	bicseq	r1, r0, #2624	; 0xa40
     6d4:	10040000 	andne	r0, r4, r0
     6d8:	000006b1 			; <UNDEFINED> instruction: 0x000006b1
     6dc:	d01d2c07 	andsle	r2, sp, r7, lsl #24
     6e0:	08000003 	stmdaeq	r0, {r0, r1}
     6e4:	000a0912 	andeq	r0, sl, r2, lsl r9
     6e8:	0e2f0700 	cdpeq	7, 2, cr0, cr15, cr0, {0}
     6ec:	000006d0 	ldrdeq	r0, [r0], -r0	; <UNPREDICTABLE>
     6f0:	00000424 	andeq	r0, r0, r4, lsr #8
     6f4:	0000042f 	andeq	r0, r0, pc, lsr #8
     6f8:	00066313 	andeq	r6, r6, r3, lsl r3
     6fc:	03d01400 	bicseq	r1, r0, #0, 8
     700:	15000000 	strne	r0, [r0, #-0]
     704:	00000846 	andeq	r0, r0, r6, asr #16
     708:	d70e3107 	strle	r3, [lr, -r7, lsl #2]
     70c:	ff000007 			; <UNDEFINED> instruction: 0xff000007
     710:	47000001 	strmi	r0, [r0, -r1]
     714:	52000004 	andpl	r0, r0, #4
     718:	13000004 	movwne	r0, #4
     71c:	00000663 	andeq	r0, r0, r3, ror #12
     720:	0003d614 	andeq	sp, r3, r4, lsl r6
     724:	ca160000 	bgt	58072c <__bss_end+0x576d2c>
     728:	0700000c 	streq	r0, [r0, -ip]
     72c:	08c01d35 	stmiaeq	r0, {r0, r2, r4, r5, r8, sl, fp, ip}^
     730:	03d00000 	bicseq	r0, r0, #0
     734:	6b020000 	blvs	8073c <__bss_end+0x76d3c>
     738:	71000004 	tstvc	r0, r4
     73c:	13000004 	movwne	r0, #4
     740:	00000663 	andeq	r0, r0, r3, ror #12
     744:	069c1600 	ldreq	r1, [ip], r0, lsl #12
     748:	37070000 	strcc	r0, [r7, -r0]
     74c:	000a191d 	andeq	r1, sl, sp, lsl r9
     750:	0003d000 	andeq	sp, r3, r0
     754:	048a0200 	streq	r0, [sl], #512	; 0x200
     758:	04900000 	ldreq	r0, [r0], #0
     75c:	63130000 	tstvs	r3, #0
     760:	00000006 	andeq	r0, r0, r6
     764:	0009a817 	andeq	sl, r9, r7, lsl r8
     768:	31390700 	teqcc	r9, r0, lsl #14
     76c:	0000067c 	andeq	r0, r0, ip, ror r6
     770:	1316020c 	tstne	r6, #12, 4	; 0xc0000000
     774:	0700000b 	streq	r0, [r0, -fp]
     778:	0855093c 	ldmdaeq	r5, {r2, r3, r4, r5, r8, fp}^
     77c:	06630000 	strbteq	r0, [r3], -r0
     780:	b7010000 	strlt	r0, [r1, -r0]
     784:	bd000004 	stclt	0, cr0, [r0, #-16]
     788:	13000004 	movwne	r0, #4
     78c:	00000663 	andeq	r0, r0, r3, ror #12
     790:	07231600 	streq	r1, [r3, -r0, lsl #12]!
     794:	3f070000 	svccc	0x00070000
     798:	00055c12 	andeq	r5, r5, r2, lsl ip
     79c:	00006500 	andeq	r6, r0, r0, lsl #10
     7a0:	04d60100 	ldrbeq	r0, [r6], #256	; 0x100
     7a4:	04eb0000 	strbteq	r0, [fp], #0
     7a8:	63130000 	tstvs	r3, #0
     7ac:	14000006 	strne	r0, [r0], #-6
     7b0:	00000685 	andeq	r0, r0, r5, lsl #13
     7b4:	00007614 	andeq	r7, r0, r4, lsl r6
     7b8:	01ff1400 	mvnseq	r1, r0, lsl #8
     7bc:	18000000 	stmdane	r0, {}	; <UNPREDICTABLE>
     7c0:	00000d17 	andeq	r0, r0, r7, lsl sp
     7c4:	180e4207 	stmdane	lr, {r0, r1, r2, r9, lr}
     7c8:	01000006 	tsteq	r0, r6
     7cc:	00000500 	andeq	r0, r0, r0, lsl #10
     7d0:	00000506 	andeq	r0, r0, r6, lsl #10
     7d4:	00066313 	andeq	r6, r6, r3, lsl r3
     7d8:	3e160000 	cdpcc	0, 1, cr0, cr6, cr0, {0}
     7dc:	07000005 	streq	r0, [r0, -r5]
     7e0:	05b01745 	ldreq	r1, [r0, #1861]!	; 0x745
     7e4:	03d60000 	bicseq	r0, r6, #0
     7e8:	1f010000 	svcne	0x00010000
     7ec:	25000005 	strcs	r0, [r0, #-5]
     7f0:	13000005 	movwne	r0, #5
     7f4:	0000068b 	andeq	r0, r0, fp, lsl #13
     7f8:	0b8b1600 	bleq	fe2c6000 <__bss_end+0xfe2bc600>
     7fc:	48070000 	stmdami	r7, {}	; <UNPREDICTABLE>
     800:	0003ff17 	andeq	pc, r3, r7, lsl pc	; <UNPREDICTABLE>
     804:	0003d600 	andeq	sp, r3, r0, lsl #12
     808:	053e0100 	ldreq	r0, [lr, #-256]!	; 0xffffff00
     80c:	05490000 	strbeq	r0, [r9, #-0]
     810:	8b130000 	blhi	4c0818 <__bss_end+0x4b6e18>
     814:	14000006 	strne	r0, [r0], #-6
     818:	00000065 	andeq	r0, r0, r5, rrx
     81c:	06431800 	strbeq	r1, [r3], -r0, lsl #16
     820:	4b070000 	blmi	1c0828 <__bss_end+0x1b6e28>
     824:	0009b60e 	andeq	fp, r9, lr, lsl #12
     828:	055e0100 	ldrbeq	r0, [lr, #-256]	; 0xffffff00
     82c:	05640000 	strbeq	r0, [r4, #-0]!
     830:	63130000 	tstvs	r3, #0
     834:	00000006 	andeq	r0, r0, r6
     838:	00084616 	andeq	r4, r8, r6, lsl r6
     83c:	0e4d0700 	cdpeq	7, 4, cr0, cr13, cr0, {0}
     840:	00000a9b 	muleq	r0, fp, sl
     844:	000001ff 	strdeq	r0, [r0], -pc	; <UNPREDICTABLE>
     848:	00057d01 	andeq	r7, r5, r1, lsl #26
     84c:	00058800 	andeq	r8, r5, r0, lsl #16
     850:	06631300 	strbteq	r1, [r3], -r0, lsl #6
     854:	65140000 	ldrvs	r0, [r4, #-0]
     858:	00000000 	andeq	r0, r0, r0
     85c:	0004c616 	andeq	ip, r4, r6, lsl r6
     860:	12500700 	subsne	r0, r0, #0, 14
     864:	0000042c 	andeq	r0, r0, ip, lsr #8
     868:	00000065 	andeq	r0, r0, r5, rrx
     86c:	0005a101 	andeq	sl, r5, r1, lsl #2
     870:	0005ac00 	andeq	sl, r5, r0, lsl #24
     874:	06631300 	strbteq	r1, [r3], -r0, lsl #6
     878:	0c140000 	ldceq	0, cr0, [r4], {-0}
     87c:	00000002 	andeq	r0, r0, r2
     880:	00045f16 	andeq	r5, r4, r6, lsl pc
     884:	0e530700 	cdpeq	7, 5, cr0, cr3, cr0, {0}
     888:	00000d2b 	andeq	r0, r0, fp, lsr #26
     88c:	000001ff 	strdeq	r0, [r0], -pc	; <UNPREDICTABLE>
     890:	0005c501 	andeq	ip, r5, r1, lsl #10
     894:	0005d000 	andeq	sp, r5, r0
     898:	06631300 	strbteq	r1, [r3], -r0, lsl #6
     89c:	65140000 	ldrvs	r0, [r4, #-0]
     8a0:	00000000 	andeq	r0, r0, r0
     8a4:	0004a018 	andeq	sl, r4, r8, lsl r0
     8a8:	0e560700 	cdpeq	7, 5, cr0, cr6, cr0, {0}
     8ac:	00000c0b 	andeq	r0, r0, fp, lsl #24
     8b0:	0005e501 	andeq	lr, r5, r1, lsl #10
     8b4:	00060400 	andeq	r0, r6, r0, lsl #8
     8b8:	06631300 	strbteq	r1, [r3], -r0, lsl #6
     8bc:	a8140000 	ldmdage	r4, {}	; <UNPREDICTABLE>
     8c0:	14000000 	strne	r0, [r0], #-0
     8c4:	00000065 	andeq	r0, r0, r5, rrx
     8c8:	00006514 	andeq	r6, r0, r4, lsl r5
     8cc:	00651400 	rsbeq	r1, r5, r0, lsl #8
     8d0:	91140000 	tstls	r4, r0
     8d4:	00000006 	andeq	r0, r0, r6
     8d8:	000d5718 	andeq	r5, sp, r8, lsl r7
     8dc:	0e580700 	cdpeq	7, 5, cr0, cr8, cr0, {0}
     8e0:	00000ddc 	ldrdeq	r0, [r0], -ip
     8e4:	00061901 	andeq	r1, r6, r1, lsl #18
     8e8:	00063800 	andeq	r3, r6, r0, lsl #16
     8ec:	06631300 	strbteq	r1, [r3], -r0, lsl #6
     8f0:	df140000 	svcle	0x00140000
     8f4:	14000000 	strne	r0, [r0], #-0
     8f8:	00000065 	andeq	r0, r0, r5, rrx
     8fc:	00006514 	andeq	r6, r0, r4, lsl r5
     900:	00651400 	rsbeq	r1, r5, r0, lsl #8
     904:	91140000 	tstls	r4, r0
     908:	00000006 	andeq	r0, r0, r6
     90c:	0004b319 	andeq	fp, r4, r9, lsl r3
     910:	0e5b0700 	cdpeq	7, 5, cr0, cr11, cr0, {0}
     914:	0000092f 	andeq	r0, r0, pc, lsr #18
     918:	000001ff 	strdeq	r0, [r0], -pc	; <UNPREDICTABLE>
     91c:	00064d01 	andeq	r4, r6, r1, lsl #26
     920:	06631300 	strbteq	r1, [r3], -r0, lsl #6
     924:	7c140000 	ldcvc	0, cr0, [r4], {-0}
     928:	14000003 	strne	r0, [r0], #-3
     92c:	00000697 	muleq	r0, r7, r6
     930:	dc030000 	stcle	0, cr0, [r3], {-0}
     934:	0e000003 	cdpeq	0, 0, cr0, cr0, cr3, {0}
     938:	0003dc04 	andeq	sp, r3, r4, lsl #24
     93c:	03d01a00 	bicseq	r1, r0, #0, 20
     940:	06760000 	ldrbteq	r0, [r6], -r0
     944:	067c0000 	ldrbteq	r0, [ip], -r0
     948:	63130000 	tstvs	r3, #0
     94c:	00000006 	andeq	r0, r0, r6
     950:	0003dc1b 	andeq	sp, r3, fp, lsl ip
     954:	00066900 	andeq	r6, r6, r0, lsl #18
     958:	4b040e00 	blmi	104160 <__bss_end+0xfa760>
     95c:	0e000000 	cdpeq	0, 0, cr0, cr0, cr0, {0}
     960:	00065e04 	andeq	r5, r6, r4, lsl #28
     964:	82041c00 	andhi	r1, r4, #0, 24
     968:	1d000000 	stcne	0, cr0, [r0, #-0]
     96c:	61681e04 	cmnvs	r8, r4, lsl #28
     970:	0508006c 	streq	r0, [r8, #-108]	; 0xffffff94
     974:	0007630b 	andeq	r6, r7, fp, lsl #6
     978:	09821f00 	stmibeq	r2, {r8, r9, sl, fp, ip}
     97c:	07080000 	streq	r0, [r8, -r0]
     980:	00007d19 	andeq	r7, r0, r9, lsl sp
     984:	e6b28000 	ldrt	r8, [r2], r0
     988:	0bb51f0e 	bleq	fed485c8 <__bss_end+0xfed3ebc8>
     98c:	0a080000 	beq	200994 <__bss_end+0x1f6f94>
     990:	0002c51a 	andeq	ip, r2, sl, lsl r5
     994:	00000000 	andeq	r0, r0, r0
     998:	05521f20 	ldrbeq	r1, [r2, #-3872]	; 0xfffff0e0
     99c:	0d080000 	stceq	0, cr0, [r8, #-0]
     9a0:	0002c51a 	andeq	ip, r2, sl, lsl r5
     9a4:	20000000 	andcs	r0, r0, r0
     9a8:	08fa2020 	ldmeq	sl!, {r5, sp}^
     9ac:	10080000 	andne	r0, r8, r0
     9b0:	00007115 	andeq	r7, r0, r5, lsl r1
     9b4:	d61f3600 	ldrle	r3, [pc], -r0, lsl #12
     9b8:	0800000c 	stmdaeq	r0, {r2, r3}
     9bc:	02c51a42 	sbceq	r1, r5, #270336	; 0x42000
     9c0:	50000000 	andpl	r0, r0, r0
     9c4:	921f2021 	andsls	r2, pc, #33	; 0x21
     9c8:	0800000d 	stmdaeq	r0, {r0, r2, r3}
     9cc:	02c51a71 	sbceq	r1, r5, #462848	; 0x71000
     9d0:	b2000000 	andlt	r0, r0, #0
     9d4:	371f2000 	ldrcc	r2, [pc, -r0]
     9d8:	08000007 	stmdaeq	r0, {r0, r1, r2}
     9dc:	02c51aa4 	sbceq	r1, r5, #164, 20	; 0xa4000
     9e0:	b4000000 	strlt	r0, [r0], #-0
     9e4:	721f2000 	andsvc	r2, pc, #0
     9e8:	08000009 	stmdaeq	r0, {r0, r3}
     9ec:	02c51ab3 	sbceq	r1, r5, #733184	; 0xb3000
     9f0:	40000000 	andmi	r0, r0, r0
     9f4:	3f1f2010 	svccc	0x001f2010
     9f8:	0800000a 	stmdaeq	r0, {r1, r3}
     9fc:	02c51abe 	sbceq	r1, r5, #778240	; 0xbe000
     a00:	50000000 	andpl	r0, r0, r0
     a04:	811f2020 	tsthi	pc, r0, lsr #32
     a08:	08000006 	stmdaeq	r0, {r1, r2}
     a0c:	02c51abf 	sbceq	r1, r5, #782336	; 0xbf000
     a10:	40000000 	andmi	r0, r0, r0
     a14:	df1f2080 	svcle	0x001f2080
     a18:	0800000c 	stmdaeq	r0, {r2, r3}
     a1c:	02c51ac0 	sbceq	r1, r5, #192, 20	; 0xc0000
     a20:	50000000 	andpl	r0, r0, r0
     a24:	a71f2080 	ldrge	r2, [pc, -r0, lsl #1]
     a28:	0800000c 	stmdaeq	r0, {r2, r3}
     a2c:	02c51ace 	sbceq	r1, r5, #843776	; 0xce000
     a30:	40000000 	andmi	r0, r0, r0
     a34:	21002021 	tstcs	r0, r1, lsr #32
     a38:	000006a5 	andeq	r0, r0, r5, lsr #13
     a3c:	0006b521 	andeq	fp, r6, r1, lsr #10
     a40:	06c52100 	strbeq	r2, [r5], r0, lsl #2
     a44:	d5210000 	strle	r0, [r1, #-0]!
     a48:	21000006 	tstcs	r0, r6
     a4c:	000006e2 	andeq	r0, r0, r2, ror #13
     a50:	0006f221 	andeq	pc, r6, r1, lsr #4
     a54:	07022100 	streq	r2, [r2, -r0, lsl #2]
     a58:	12210000 	eorne	r0, r1, #0
     a5c:	21000007 	tstcs	r0, r7
     a60:	00000722 	andeq	r0, r0, r2, lsr #14
     a64:	00073221 	andeq	r3, r7, r1, lsr #4
     a68:	07422100 	strbeq	r2, [r2, -r0, lsl #2]
     a6c:	52210000 	eorpl	r0, r1, #0
     a70:	0a000007 	beq	a94 <shift+0xa94>
     a74:	00000bec 	andeq	r0, r0, ip, ror #23
     a78:	71140809 	tstvc	r4, r9, lsl #16
     a7c:	05000000 	streq	r0, [r0, #-0]
     a80:	00981403 	addseq	r1, r8, r3, lsl #8
     a84:	0cf60800 	ldcleq	8, cr0, [r6]
     a88:	04050000 	streq	r0, [r5], #-0
     a8c:	00000038 	andeq	r0, r0, r8, lsr r0
     a90:	d60c0d0a 	strle	r0, [ip], -sl, lsl #26
     a94:	09000007 	stmdbeq	r0, {r0, r1, r2}
     a98:	0000083f 	andeq	r0, r0, pc, lsr r8
     a9c:	097c0900 	ldmdbeq	ip!, {r8, fp}^
     aa0:	09010000 	stmdbeq	r1, {}	; <UNPREDICTABLE>
     aa4:	00000a49 	andeq	r0, r0, r9, asr #20
     aa8:	b1030002 	tstlt	r3, r2
     aac:	06000007 	streq	r0, [r0], -r7
     ab0:	000004da 	ldrdeq	r0, [r0], -sl
     ab4:	08150a02 	ldmdaeq	r5, {r1, r9, fp}
     ab8:	00000803 	andeq	r0, r0, r3, lsl #16
     abc:	000be410 	andeq	lr, fp, r0, lsl r4
     ac0:	0d170a00 	vldreq	s0, [r7, #-0]
     ac4:	0000003f 	andeq	r0, r0, pc, lsr r0
     ac8:	0d851000 	stceq	0, cr1, [r5]
     acc:	180a0000 	stmdane	sl, {}	; <UNPREDICTABLE>
     ad0:	00003f0d 	andeq	r3, r0, sp, lsl #30
     ad4:	0a000100 	beq	edc <shift+0xedc>
     ad8:	00000592 	muleq	r0, r2, r5
     adc:	7114080b 	tstvc	r4, fp, lsl #16
     ae0:	05000000 	streq	r0, [r0, #-0]
     ae4:	00981803 	addseq	r1, r8, r3, lsl #16
     ae8:	087f0a00 	ldmdaeq	pc!, {r9, fp}^	; <UNPREDICTABLE>
     aec:	0e010000 	cdpeq	0, 0, cr0, cr1, cr0, {0}
     af0:	00007114 	andeq	r7, r0, r4, lsl r1
     af4:	1c030500 	cfstr32ne	mvfx0, [r3], {-0}
     af8:	0a000098 	beq	d60 <shift+0xd60>
     afc:	00000878 	andeq	r0, r0, r8, ror r8
     b00:	71140f01 	tstvc	r4, r1, lsl #30
     b04:	05000000 	streq	r0, [r0, #-0]
     b08:	00982003 	addseq	r2, r8, r3
     b0c:	0bc50a00 	bleq	ff143314 <__bss_end+0xff139914>
     b10:	10010000 	andne	r0, r1, r0
     b14:	0007d615 	andeq	sp, r7, r5, lsl r6
     b18:	24030500 	strcs	r0, [r3], #-1280	; 0xfffffb00
     b1c:	22000098 	andcs	r0, r0, #152	; 0x98
     b20:	000009fd 	strdeq	r0, [r0], -sp
     b24:	b10b1101 	tstlt	fp, r1, lsl #2
     b28:	05000007 	streq	r0, [r0, #-7]
     b2c:	00996003 	addseq	r6, r9, r3
     b30:	0bf82200 	bleq	ffe09338 <__bss_end+0xffdff938>
     b34:	13010000 	movwne	r0, #4096	; 0x1000
     b38:	0000650a 	andeq	r6, r0, sl, lsl #10
     b3c:	64030500 	strvs	r0, [r3], #-1280	; 0xfffffb00
     b40:	22000099 	andcs	r0, r0, #153	; 0x99
     b44:	000004ff 	strdeq	r0, [r0], -pc	; <UNPREDICTABLE>
     b48:	65121301 	ldrvs	r1, [r2, #-769]	; 0xfffffcff
     b4c:	05000000 	streq	r0, [r0, #-0]
     b50:	00996803 	addseq	r6, r9, r3, lsl #16
     b54:	08910c00 	ldmeq	r1, {sl, fp}
     b58:	08910000 	ldmeq	r1, {}	; <UNPREDICTABLE>
     b5c:	760d0000 	strvc	r0, [sp], -r0
     b60:	1f000000 	svcne	0x00000000
     b64:	04040200 	streq	r0, [r4], #-512	; 0xfffffe00
     b68:	0000067b 	andeq	r0, r0, fp, ror r6
     b6c:	000dac22 	andeq	sl, sp, r2, lsr #24
     b70:	07150100 	ldreq	r0, [r5, -r0, lsl #2]
     b74:	00000881 	andeq	r0, r0, r1, lsl #17
     b78:	996c0305 	stmdbls	ip!, {r0, r2, r8, r9}^
     b7c:	6a220000 	bvs	880b84 <__bss_end+0x877184>
     b80:	0100000a 	tsteq	r0, sl
     b84:	00650a16 	rsbeq	r0, r5, r6, lsl sl
     b88:	03050000 	movweq	r0, #20480	; 0x5000
     b8c:	000099ec 	andeq	r9, r0, ip, ror #19
     b90:	000d8023 	andeq	r8, sp, r3, lsr #32
     b94:	05ae0100 	streq	r0, [lr, #256]!	; 0x100
     b98:	00000038 	andeq	r0, r0, r8, lsr r0
     b9c:	00008874 	andeq	r8, r0, r4, ror r8
     ba0:	00000118 	andeq	r0, r0, r8, lsl r1
     ba4:	092e9c01 	stmdbeq	lr!, {r0, sl, fp, ip, pc}
     ba8:	53240000 			; <UNDEFINED> instruction: 0x53240000
     bac:	0100000a 	tsteq	r0, sl
     bb0:	00380eae 	eorseq	r0, r8, lr, lsr #29
     bb4:	91020000 	mrsls	r0, (UNDEF: 2)
     bb8:	081c2444 	ldmdaeq	ip, {r2, r6, sl, sp}
     bbc:	ae010000 	cdpge	0, 0, cr0, cr1, cr0, {0}
     bc0:	00092e1b 	andeq	r2, r9, fp, lsl lr
     bc4:	40910200 	addsmi	r0, r1, r0, lsl #4
     bc8:	00049b25 	andeq	r9, r4, r5, lsr #22
     bcc:	0ab00100 	beq	fec00fd4 <__bss_end+0xfebf75d4>
     bd0:	0000093a 	andeq	r0, r0, sl, lsr r9
     bd4:	266c9102 	strbtcs	r9, [ip], -r2, lsl #2
     bd8:	0067736d 	rsbeq	r7, r7, sp, ror #6
     bdc:	4a13b001 	bmi	4ecbe8 <__bss_end+0x4e31e8>
     be0:	02000009 	andeq	r0, r0, #9
     be4:	ec274c91 	stc	12, cr4, [r7], #-580	; 0xfffffdbc
     be8:	01000004 	tsteq	r0, r4
     bec:	00650eb1 	strhteq	r0, [r5], #-225	; 0xffffff1f
     bf0:	7f250000 	svcvc	0x00250000
     bf4:	01000004 	tsteq	r0, r4
     bf8:	07db17bf 			; <UNDEFINED> instruction: 0x07db17bf
     bfc:	91020000 	mrsls	r0, (UNDEF: 2)
     c00:	040e0048 	streq	r0, [lr], #-72	; 0xffffffb8
     c04:	00000934 	andeq	r0, r0, r4, lsr r9
     c08:	0025040e 	eoreq	r0, r5, lr, lsl #8
     c0c:	250c0000 	strcs	r0, [ip, #-0]
     c10:	4a000000 	bmi	c18 <shift+0xc18>
     c14:	0d000009 	stceq	0, cr0, [r0, #-36]	; 0xffffffdc
     c18:	00000076 	andeq	r0, r0, r6, ror r0
     c1c:	250c0008 	strcs	r0, [ip, #-8]
     c20:	5a000000 	bpl	c28 <shift+0xc28>
     c24:	0d000009 	stceq	0, cr0, [r0, #-36]	; 0xffffffdc
     c28:	00000076 	andeq	r0, r0, r6, ror r0
     c2c:	7228001f 	eorvc	r0, r8, #31
     c30:	01000004 	tsteq	r0, r4
     c34:	0c5d069b 	mrrceq	6, 9, r0, sp, cr11
     c38:	87b40000 	ldrhi	r0, [r4, r0]!
     c3c:	00c00000 	sbceq	r0, r0, r0
     c40:	9c010000 	stcls	0, cr0, [r1], {-0}
     c44:	000009b1 			; <UNDEFINED> instruction: 0x000009b1
     c48:	00049b25 	andeq	r9, r4, r5, lsr #22
     c4c:	0a9d0100 	beq	fe741054 <__bss_end+0xfe737654>
     c50:	000009b1 			; <UNDEFINED> instruction: 0x000009b1
     c54:	25709102 	ldrbcs	r9, [r0, #-258]!	; 0xfffffefe
     c58:	00000a87 	andeq	r0, r0, r7, lsl #21
     c5c:	4a139d01 	bmi	4e8068 <__bss_end+0x4de668>
     c60:	02000009 	andeq	r0, r0, #9
     c64:	8f255091 	svchi	0x00255091
     c68:	0100000a 	tsteq	r0, sl
     c6c:	00250aa0 	eoreq	r0, r5, r0, lsr #21
     c70:	91020000 	mrsls	r0, (UNDEF: 2)
     c74:	071d2577 			; <UNDEFINED> instruction: 0x071d2577
     c78:	a1010000 	mrsge	r0, (UNDEF: 1)
     c7c:	0008910b 	andeq	r9, r8, fp, lsl #2
     c80:	4c910200 	lfmmi	f0, 4, [r1], {0}
     c84:	00250c00 	eoreq	r0, r5, r0, lsl #24
     c88:	09c10000 	stmibeq	r1, {}^	; <UNPREDICTABLE>
     c8c:	760d0000 	strvc	r0, [sp], -r0
     c90:	05000000 	streq	r0, [r0, #-0]
     c94:	0d002800 	stceq	8, cr2, [r0, #-0]
     c98:	7f010000 	svcvc	0x00010000
     c9c:	00074c06 	andeq	r4, r7, r6, lsl #24
     ca0:	0086a000 	addeq	sl, r6, r0
     ca4:	00011400 	andeq	r1, r1, r0, lsl #8
     ca8:	189c0100 	ldmne	ip, {r8}
     cac:	2400000a 	strcs	r0, [r0], #-10
     cb0:	00000a8f 	andeq	r0, r0, pc, lsl #21
     cb4:	25177f01 	ldrcs	r7, [r7, #-3841]	; 0xfffff0ff
     cb8:	02000000 	andeq	r0, r0, #0
     cbc:	1d244791 	stcne	7, cr4, [r4, #-580]!	; 0xfffffdbc
     cc0:	01000007 	tsteq	r0, r7
     cc4:	08912a7f 	ldmeq	r1, {r0, r1, r2, r3, r4, r5, r6, r9, fp, sp}
     cc8:	91020000 	mrsls	r0, (UNDEF: 2)
     ccc:	0a872540 	beq	fe1ca1d4 <__bss_end+0xfe1c07d4>
     cd0:	81010000 	mrshi	r0, (UNDEF: 1)
     cd4:	00094a0a 	andeq	r4, r9, sl, lsl #20
     cd8:	58910200 	ldmpl	r1, {r9}
     cdc:	0005e825 	andeq	lr, r5, r5, lsr #16
     ce0:	17810100 	strne	r0, [r1, r0, lsl #2]
     ce4:	000001ef 	andeq	r0, r0, pc, ror #3
     ce8:	00489102 	subeq	r9, r8, r2, lsl #2
     cec:	000b2a29 	andeq	r2, fp, r9, lsr #20
     cf0:	06570100 	ldrbeq	r0, [r7], -r0, lsl #2
     cf4:	00000ce9 	andeq	r0, r0, r9, ror #25
     cf8:	000001ff 	strdeq	r0, [r0], -pc	; <UNPREDICTABLE>
     cfc:	000084d0 	ldrdeq	r8, [r0], -r0
     d00:	000001d0 	ldrdeq	r0, [r0], -r0	; <UNPREDICTABLE>
     d04:	0a759c01 	beq	1d67d10 <__bss_end+0x1d5e310>
     d08:	5e240000 	cdppl	0, 2, cr0, cr4, cr0, {0}
     d0c:	01000007 	tsteq	r0, r7
     d10:	07b11a57 	sbfxeq	r1, r7, #20, #18
     d14:	91030000 	mrsls	r0, (UNDEF: 3)
     d18:	04257fac 	strteq	r7, [r5], #-4012	; 0xfffff054
     d1c:	0100000a 	tsteq	r0, sl
     d20:	0a750a59 	beq	1d4368c <__bss_end+0x1d39c8c>
     d24:	91020000 	mrsls	r0, (UNDEF: 2)
     d28:	049b2574 	ldreq	r2, [fp], #1396	; 0x574
     d2c:	59010000 	stmdbpl	r1, {}	; <UNPREDICTABLE>
     d30:	00094a13 	andeq	r4, r9, r3, lsl sl
     d34:	54910200 	ldrpl	r0, [r1], #512	; 0x200
     d38:	000a8725 	andeq	r8, sl, r5, lsr #14
     d3c:	1d590100 	ldfnee	f0, [r9, #-0]
     d40:	0000094a 	andeq	r0, r0, sl, asr #18
     d44:	7fb49103 	svcvc	0x00b49103
     d48:	00250c00 	eoreq	r0, r5, r0, lsl #24
     d4c:	0a850000 	beq	fe140d54 <__bss_end+0xfe137354>
     d50:	760d0000 	strvc	r0, [sp], -r0
     d54:	03000000 	movweq	r0, #0
     d58:	0b742900 	bleq	1d0b160 <__bss_end+0x1d01760>
     d5c:	34010000 	strcc	r0, [r1], #-0
     d60:	0009130b 	andeq	r1, r9, fp, lsl #6
     d64:	0007b100 	andeq	fp, r7, r0, lsl #2
     d68:	0083e400 	addeq	lr, r3, r0, lsl #8
     d6c:	0000ec00 	andeq	lr, r0, r0, lsl #24
     d70:	d19c0100 	orrsle	r0, ip, r0, lsl #2
     d74:	2400000a 	strcs	r0, [r0], #-10
     d78:	000007cf 	andeq	r0, r0, pc, asr #15
     d7c:	b1213401 			; <UNDEFINED> instruction: 0xb1213401
     d80:	02000007 	andeq	r0, r0, #7
     d84:	90246c91 	mlals	r4, r1, ip, r6
     d88:	01000004 	tsteq	r0, r4
     d8c:	09343034 	ldmdbeq	r4!, {r2, r4, r5, ip, sp}
     d90:	91020000 	mrsls	r0, (UNDEF: 2)
     d94:	07062568 	streq	r2, [r6, -r8, ror #10]
     d98:	36010000 	strcc	r0, [r1], -r0
     d9c:	0007b10f 	andeq	fp, r7, pc, lsl #2
     da0:	74910200 	ldrvc	r0, [r1], #512	; 0x200
     da4:	6f6c2a00 	svcvs	0x006c2a00
     da8:	2d010067 	stccs	0, cr0, [r1, #-412]	; 0xfffffe64
     dac:	00074206 	andeq	r4, r7, r6, lsl #4
     db0:	0082fc00 	addeq	pc, r2, r0, lsl #24
     db4:	0000e800 	andeq	lr, r0, r0, lsl #16
     db8:	0b9c0100 	bleq	fe7011c0 <__bss_end+0xfe6f77c0>
     dbc:	2b00000b 	blcs	df0 <shift+0xdf0>
     dc0:	0067736d 	rsbeq	r7, r7, sp, ror #6
     dc4:	06162d01 	ldreq	r2, [r6], -r1, lsl #26
     dc8:	02000002 	andeq	r0, r0, #2
     dcc:	36255491 			; <UNDEFINED> instruction: 0x36255491
     dd0:	01000008 	tsteq	r0, r8
     dd4:	0b0b0a2f 	bleq	2c3698 <__bss_end+0x2b9c98>
     dd8:	91030000 	mrsls	r0, (UNDEF: 3)
     ddc:	0c000658 	stceq	6, cr0, [r0], {88}	; 0x58
     de0:	00000025 	andeq	r0, r0, r5, lsr #32
     de4:	00000b1e 	andeq	r0, r0, lr, lsl fp
     de8:	0000762c 	andeq	r7, r0, ip, lsr #12
     dec:	5c910300 	ldcpl	3, cr0, [r1], {0}
     df0:	6f2d0006 	svcvs	0x002d0006
     df4:	01000008 	tsteq	r0, r8
     df8:	0c960618 	ldceq	6, cr0, [r6], {24}
     dfc:	822c0000 	eorhi	r0, ip, #0
     e00:	00d00000 	sbcseq	r0, r0, r0
     e04:	9c010000 	stcls	0, cr0, [r1], {-0}
     e08:	00049b24 	andeq	r9, r4, r4, lsr #22
     e0c:	15180100 	ldrne	r0, [r8, #-256]	; 0xffffff00
     e10:	00000934 	andeq	r0, r0, r4, lsr r9
     e14:	2b649102 	blcs	1925224 <__bss_end+0x191b824>
     e18:	0067736d 	rsbeq	r7, r7, sp, ror #6
     e1c:	06271801 	strteq	r1, [r7], -r1, lsl #16
     e20:	02000002 	andeq	r0, r0, #2
     e24:	96256091 			; <UNDEFINED> instruction: 0x96256091
     e28:	01000008 	tsteq	r0, r8
     e2c:	00520e19 	subseq	r0, r2, r9, lsl lr
     e30:	91020000 	mrsls	r0, (UNDEF: 2)
     e34:	1f00006e 	svcne	0x0000006e
     e38:	0400000b 	streq	r0, [r0], #-11
     e3c:	0004c300 	andeq	ip, r4, r0, lsl #6
     e40:	27010400 	strcs	r0, [r1, -r0, lsl #8]
     e44:	04000011 	streq	r0, [r0], #-17	; 0xffffffef
     e48:	00001017 	andeq	r1, r0, r7, lsl r0
     e4c:	00000e34 	andeq	r0, r0, r4, lsr lr
     e50:	0000898c 	andeq	r8, r0, ip, lsl #19
     e54:	0000045c 	andeq	r0, r0, ip, asr r4
     e58:	000006f9 	strdeq	r0, [r0], -r9
     e5c:	91080102 	tstls	r8, r2, lsl #2
     e60:	0300000c 	movweq	r0, #12
     e64:	00000025 	andeq	r0, r0, r5, lsr #32
     e68:	f7050202 			; <UNDEFINED> instruction: 0xf7050202
     e6c:	0400000a 	streq	r0, [r0], #-10
     e70:	6e690504 	cdpvs	5, 6, cr0, cr9, cr4, {0}
     e74:	01020074 	tsteq	r2, r4, ror r0
     e78:	000c8808 	andeq	r8, ip, r8, lsl #16
     e7c:	07020200 	streq	r0, [r2, -r0, lsl #4]
     e80:	00000d6d 	andeq	r0, r0, sp, ror #26
     e84:	00066105 	andeq	r6, r6, r5, lsl #2
     e88:	07090700 	streq	r0, [r9, -r0, lsl #14]
     e8c:	0000005e 	andeq	r0, r0, lr, asr r0
     e90:	00004d03 	andeq	r4, r0, r3, lsl #26
     e94:	07040200 	streq	r0, [r4, -r0, lsl #4]
     e98:	00000bd7 	ldrdeq	r0, [r0], -r7
     e9c:	000e2806 	andeq	r2, lr, r6, lsl #16
     ea0:	06020800 	streq	r0, [r2], -r0, lsl #16
     ea4:	00008b08 	andeq	r8, r0, r8, lsl #22
     ea8:	30720700 	rsbscc	r0, r2, r0, lsl #14
     eac:	0e080200 	cdpeq	2, 0, cr0, cr8, cr0, {0}
     eb0:	0000004d 	andeq	r0, r0, sp, asr #32
     eb4:	31720700 	cmncc	r2, r0, lsl #14
     eb8:	0e090200 	cdpeq	2, 0, cr0, cr9, cr0, {0}
     ebc:	0000004d 	andeq	r0, r0, sp, asr #32
     ec0:	b1080004 	tstlt	r8, r4
     ec4:	05000010 	streq	r0, [r0, #-16]
     ec8:	00003804 	andeq	r3, r0, r4, lsl #16
     ecc:	0c0d0200 	sfmeq	f0, 4, [sp], {-0}
     ed0:	000000a9 	andeq	r0, r0, r9, lsr #1
     ed4:	004b4f09 	subeq	r4, fp, r9, lsl #30
     ed8:	0ee20a00 	vfmaeq.f32	s1, s4, s0
     edc:	00010000 	andeq	r0, r1, r0
     ee0:	000b4c08 	andeq	r4, fp, r8, lsl #24
     ee4:	38040500 	stmdacc	r4, {r8, sl}
     ee8:	02000000 	andeq	r0, r0, #0
     eec:	00e00c1e 	rsceq	r0, r0, lr, lsl ip
     ef0:	590a0000 	stmdbpl	sl, {}	; <UNPREDICTABLE>
     ef4:	00000006 	andeq	r0, r0, r6
     ef8:	00082c0a 	andeq	r2, r8, sl, lsl #24
     efc:	6e0a0100 	adfvse	f0, f2, f0
     f00:	0200000b 	andeq	r0, r0, #11
     f04:	000cc40a 	andeq	ip, ip, sl, lsl #8
     f08:	0d0a0300 	stceq	3, cr0, [sl, #-0]
     f0c:	04000008 	streq	r0, [r0], #-8
     f10:	000ad60a 	andeq	sp, sl, sl, lsl #12
     f14:	08000500 	stmdaeq	r0, {r8, sl}
     f18:	00000b34 	andeq	r0, r0, r4, lsr fp
     f1c:	00380405 	eorseq	r0, r8, r5, lsl #8
     f20:	3f020000 	svccc	0x00020000
     f24:	00011d0c 	andeq	r1, r1, ip, lsl #26
     f28:	07320a00 	ldreq	r0, [r2, -r0, lsl #20]!
     f2c:	0a000000 	beq	f34 <shift+0xf34>
     f30:	00000827 	andeq	r0, r0, r7, lsr #16
     f34:	0dc10a01 	vstreq	s1, [r1, #4]
     f38:	0a020000 	beq	80f40 <__bss_end+0x77540>
     f3c:	00000a13 	andeq	r0, r0, r3, lsl sl
     f40:	08210a03 	stmdaeq	r1!, {r0, r1, r9, fp}
     f44:	0a040000 	beq	100f4c <__bss_end+0xf754c>
     f48:	0000088f 	andeq	r0, r0, pc, lsl #17
     f4c:	068b0a05 	streq	r0, [fp], r5, lsl #20
     f50:	00060000 	andeq	r0, r6, r0
     f54:	00066a08 	andeq	r6, r6, r8, lsl #20
     f58:	38040500 	stmdacc	r4, {r8, sl}
     f5c:	02000000 	andeq	r0, r0, #0
     f60:	01480c66 	cmpeq	r8, r6, ror #24
     f64:	7d0a0000 	stcvc	0, cr0, [sl, #-0]
     f68:	0000000c 	andeq	r0, r0, ip
     f6c:	0005870a 	andeq	r8, r5, sl, lsl #14
     f70:	9e0a0100 	adflse	f0, f2, f0
     f74:	0200000b 	andeq	r0, r0, #11
     f78:	000adf0a 	andeq	sp, sl, sl, lsl #30
     f7c:	0b000300 	bleq	1b84 <shift+0x1b84>
     f80:	000009e5 	andeq	r0, r0, r5, ror #19
     f84:	59140503 	ldmdbpl	r4, {r0, r1, r8, sl}
     f88:	05000000 	streq	r0, [r0, #-0]
     f8c:	00991403 	addseq	r1, r9, r3, lsl #8
     f90:	0bff0b00 	bleq	fffc3b98 <__bss_end+0xfffba198>
     f94:	06030000 	streq	r0, [r3], -r0
     f98:	00005914 	andeq	r5, r0, r4, lsl r9
     f9c:	18030500 	stmdane	r3, {r8, sl}
     fa0:	0b000099 	bleq	120c <shift+0x120c>
     fa4:	000008aa 	andeq	r0, r0, sl, lsr #17
     fa8:	591a0704 	ldmdbpl	sl, {r2, r8, r9, sl}
     fac:	05000000 	streq	r0, [r0, #-0]
     fb0:	00991c03 	addseq	r1, r9, r3, lsl #24
     fb4:	0b010b00 	bleq	43bbc <__bss_end+0x3a1bc>
     fb8:	09040000 	stmdbeq	r4, {}	; <UNPREDICTABLE>
     fbc:	0000591a 	andeq	r5, r0, sl, lsl r9
     fc0:	20030500 	andcs	r0, r3, r0, lsl #10
     fc4:	0b000099 	bleq	1230 <shift+0x1230>
     fc8:	0000089c 	muleq	r0, ip, r8
     fcc:	591a0b04 	ldmdbpl	sl, {r2, r8, r9, fp}
     fd0:	05000000 	streq	r0, [r0, #-0]
     fd4:	00992403 	addseq	r2, r9, r3, lsl #8
     fd8:	0ac30b00 	beq	ff0c3be0 <__bss_end+0xff0ba1e0>
     fdc:	0d040000 	stceq	0, cr0, [r4, #-0]
     fe0:	0000591a 	andeq	r5, r0, sl, lsl r9
     fe4:	28030500 	stmdacs	r3, {r8, sl}
     fe8:	0b000099 	bleq	1254 <shift+0x1254>
     fec:	00000639 	andeq	r0, r0, r9, lsr r6
     ff0:	591a0f04 	ldmdbpl	sl, {r2, r8, r9, sl, fp}
     ff4:	05000000 	streq	r0, [r0, #-0]
     ff8:	00992c03 	addseq	r2, r9, r3, lsl #24
     ffc:	121a0800 	andsne	r0, sl, #0, 16
    1000:	04050000 	streq	r0, [r5], #-0
    1004:	00000038 	andeq	r0, r0, r8, lsr r0
    1008:	eb0c1b04 	bl	307c20 <__bss_end+0x2fe220>
    100c:	0a000001 	beq	1018 <shift+0x1018>
    1010:	000005de 	ldrdeq	r0, [r0], -lr
    1014:	0d0c0a00 	vstreq	s0, [ip, #-0]
    1018:	0a010000 	beq	41020 <__bss_end+0x37620>
    101c:	00000dbc 			; <UNDEFINED> instruction: 0x00000dbc
    1020:	590c0002 	stmdbpl	ip, {r1}
    1024:	02000004 	andeq	r0, r0, #4
    1028:	090e0201 	stmdbeq	lr, {r0, r9}
    102c:	040d0000 	streq	r0, [sp], #-0
    1030:	0000002c 	andeq	r0, r0, ip, lsr #32
    1034:	01eb040d 	mvneq	r0, sp, lsl #8
    1038:	f20b0000 	vhadd.s8	d0, d11, d0
    103c:	05000005 	streq	r0, [r0, #-5]
    1040:	00591404 	subseq	r1, r9, r4, lsl #8
    1044:	03050000 	movweq	r0, #20480	; 0x5000
    1048:	00009930 	andeq	r9, r0, r0, lsr r9
    104c:	000b800b 	andeq	r8, fp, fp
    1050:	14070500 	strne	r0, [r7], #-1280	; 0xfffffb00
    1054:	00000059 	andeq	r0, r0, r9, asr r0
    1058:	99340305 	ldmdbls	r4!, {r0, r2, r8, r9}
    105c:	2b0b0000 	blcs	2c1064 <__bss_end+0x2b7664>
    1060:	05000005 	streq	r0, [r0, #-5]
    1064:	0059140a 	subseq	r1, r9, sl, lsl #8
    1068:	03050000 	movweq	r0, #20480	; 0x5000
    106c:	00009938 	andeq	r9, r0, r8, lsr r9
    1070:	00069008 	andeq	r9, r6, r8
    1074:	38040500 	stmdacc	r4, {r8, sl}
    1078:	05000000 	streq	r0, [r0, #-0]
    107c:	02700c0d 	rsbseq	r0, r0, #3328	; 0xd00
    1080:	4e090000 	cdpmi	0, 0, cr0, cr9, cr0, {0}
    1084:	00007765 	andeq	r7, r0, r5, ror #14
    1088:	00050b0a 	andeq	r0, r5, sl, lsl #22
    108c:	230a0100 	movwcs	r0, #41216	; 0xa100
    1090:	02000005 	andeq	r0, r0, #5
    1094:	0006a90a 	andeq	sl, r6, sl, lsl #18
    1098:	b60a0300 	strlt	r0, [sl], -r0, lsl #6
    109c:	0400000c 	streq	r0, [r0], #-12
    10a0:	0004f80a 	andeq	pc, r4, sl, lsl #16
    10a4:	06000500 	streq	r0, [r0], -r0, lsl #10
    10a8:	0000060b 	andeq	r0, r0, fp, lsl #12
    10ac:	081b0510 	ldmdaeq	fp, {r4, r8, sl}
    10b0:	000002af 	andeq	r0, r0, pc, lsr #5
    10b4:	00726c07 	rsbseq	r6, r2, r7, lsl #24
    10b8:	af131d05 	svcge	0x00131d05
    10bc:	00000002 	andeq	r0, r0, r2
    10c0:	00707307 	rsbseq	r7, r0, r7, lsl #6
    10c4:	af131e05 	svcge	0x00131e05
    10c8:	04000002 	streq	r0, [r0], #-2
    10cc:	00637007 	rsbeq	r7, r3, r7
    10d0:	af131f05 	svcge	0x00131f05
    10d4:	08000002 	stmdaeq	r0, {r1}
    10d8:	000b240e 	andeq	r2, fp, lr, lsl #8
    10dc:	13200500 	nopne	{0}	; <UNPREDICTABLE>
    10e0:	000002af 	andeq	r0, r0, pc, lsr #5
    10e4:	0402000c 	streq	r0, [r2], #-12
    10e8:	000bd207 	andeq	sp, fp, r7, lsl #4
    10ec:	08000600 	stmdaeq	r0, {r9, sl}
    10f0:	05700000 	ldrbeq	r0, [r0, #-0]!
    10f4:	03460828 	movteq	r0, #26664	; 0x6828
    10f8:	110e0000 	mrsne	r0, (UNDEF: 14)
    10fc:	05000007 	streq	r0, [r0, #-7]
    1100:	0270122a 	rsbseq	r1, r0, #-1610612734	; 0xa0000002
    1104:	07000000 	streq	r0, [r0, -r0]
    1108:	00646970 	rsbeq	r6, r4, r0, ror r9
    110c:	5e122b05 	vnmlspl.f64	d2, d2, d5
    1110:	10000000 	andne	r0, r0, r0
    1114:	000a950e 	andeq	r9, sl, lr, lsl #10
    1118:	112c0500 			; <UNDEFINED> instruction: 0x112c0500
    111c:	00000239 	andeq	r0, r0, r9, lsr r2
    1120:	0c6f0e14 	stcleq	14, cr0, [pc], #-80	; 10d8 <shift+0x10d8>
    1124:	2d050000 	stccs	0, cr0, [r5, #-0]
    1128:	00005e12 	andeq	r5, r0, r2, lsl lr
    112c:	e90e1800 	stmdb	lr, {fp, ip}
    1130:	05000003 	streq	r0, [r0, #-3]
    1134:	005e122e 	subseq	r1, lr, lr, lsr #4
    1138:	0e1c0000 	cdpeq	0, 1, cr0, cr12, cr0, {0}
    113c:	00000b61 	andeq	r0, r0, r1, ror #22
    1140:	460c2f05 	strmi	r2, [ip], -r5, lsl #30
    1144:	20000003 	andcs	r0, r0, r3
    1148:	0004860e 	andeq	r8, r4, lr, lsl #12
    114c:	09300500 	ldmdbeq	r0!, {r8, sl}
    1150:	00000038 	andeq	r0, r0, r8, lsr r0
    1154:	06c40e60 	strbeq	r0, [r4], r0, ror #28
    1158:	31050000 	mrscc	r0, (UNDEF: 5)
    115c:	00004d0e 	andeq	r4, r0, lr, lsl #26
    1160:	610e6400 	tstvs	lr, r0, lsl #8
    1164:	0500000a 	streq	r0, [r0, #-10]
    1168:	004d0e33 	subeq	r0, sp, r3, lsr lr
    116c:	0e680000 	cdpeq	0, 6, cr0, cr8, cr0, {0}
    1170:	00000a58 	andeq	r0, r0, r8, asr sl
    1174:	4d0e3405 	cfstrsmi	mvf3, [lr, #-20]	; 0xffffffec
    1178:	6c000000 	stcvs	0, cr0, [r0], {-0}
    117c:	01fd0f00 	mvnseq	r0, r0, lsl #30
    1180:	03560000 	cmpeq	r6, #0
    1184:	5e100000 	cdppl	0, 1, cr0, cr0, cr0, {0}
    1188:	0f000000 	svceq	0x00000000
    118c:	05140b00 	ldreq	r0, [r4, #-2816]	; 0xfffff500
    1190:	0a060000 	beq	181198 <__bss_end+0x177798>
    1194:	00005914 	andeq	r5, r0, r4, lsl r9
    1198:	3c030500 	cfstr32cc	mvfx0, [r3], {-0}
    119c:	08000099 	stmdaeq	r0, {r0, r3, r4, r7}
    11a0:	000008e5 	andeq	r0, r0, r5, ror #17
    11a4:	00380405 	eorseq	r0, r8, r5, lsl #8
    11a8:	0d060000 	stceq	0, cr0, [r6, #-0]
    11ac:	0003870c 	andeq	r8, r3, ip, lsl #14
    11b0:	0dc70a00 	vstreq	s1, [r7]
    11b4:	0a000000 	beq	11bc <shift+0x11bc>
    11b8:	00000d20 	andeq	r0, r0, r0, lsr #26
    11bc:	68030001 	stmdavs	r3, {r0}
    11c0:	08000003 	stmdaeq	r0, {r0, r1}
    11c4:	00000fa9 	andeq	r0, r0, r9, lsr #31
    11c8:	00380405 	eorseq	r0, r8, r5, lsl #8
    11cc:	14060000 	strne	r0, [r6], #-0
    11d0:	0003ab0c 	andeq	sl, r3, ip, lsl #22
    11d4:	0e850a00 	vdiveq.f32	s0, s10, s0
    11d8:	0a000000 	beq	11e0 <shift+0x11e0>
    11dc:	00001083 	andeq	r1, r0, r3, lsl #1
    11e0:	8c030001 	stchi	0, cr0, [r3], {1}
    11e4:	06000003 	streq	r0, [r0], -r3
    11e8:	000006f3 	strdeq	r0, [r0], -r3
    11ec:	081b060c 	ldmdaeq	fp, {r2, r3, r9, sl}
    11f0:	000003e5 	andeq	r0, r0, r5, ror #7
    11f4:	0005ab0e 	andeq	sl, r5, lr, lsl #22
    11f8:	191d0600 	ldmdbne	sp, {r9, sl}
    11fc:	000003e5 	andeq	r0, r0, r5, ror #7
    1200:	05060e00 	streq	r0, [r6, #-3584]	; 0xfffff200
    1204:	1e060000 	cdpne	0, 0, cr0, cr6, cr0, {0}
    1208:	0003e519 	andeq	lr, r3, r9, lsl r5
    120c:	090e0400 	stmdbeq	lr, {sl}
    1210:	06000009 	streq	r0, [r0], -r9
    1214:	03eb131f 	mvneq	r1, #2080374784	; 0x7c000000
    1218:	00080000 	andeq	r0, r8, r0
    121c:	03b0040d 	movseq	r0, #218103808	; 0xd000000
    1220:	040d0000 	streq	r0, [sp], #-0
    1224:	000002b6 			; <UNDEFINED> instruction: 0x000002b6
    1228:	000b1311 	andeq	r1, fp, r1, lsl r3
    122c:	22061400 	andcs	r1, r6, #0, 8
    1230:	00067307 	andeq	r7, r6, r7, lsl #6
    1234:	09f30e00 	ldmibeq	r3!, {r9, sl, fp}^
    1238:	26060000 	strcs	r0, [r6], -r0
    123c:	00004d12 	andeq	r4, r0, r2, lsl sp
    1240:	950e0000 	strls	r0, [lr, #-0]
    1244:	06000009 	streq	r0, [r0], -r9
    1248:	03e51d29 	mvneq	r1, #2624	; 0xa40
    124c:	0e040000 	cdpeq	0, 0, cr0, cr4, cr0, {0}
    1250:	000006b1 			; <UNDEFINED> instruction: 0x000006b1
    1254:	e51d2c06 	ldr	r2, [sp, #-3078]	; 0xfffff3fa
    1258:	08000003 	stmdaeq	r0, {r0, r1}
    125c:	000a0912 	andeq	r0, sl, r2, lsl r9
    1260:	0e2f0600 	cfmadda32eq	mvax0, mvax0, mvfx15, mvfx0
    1264:	000006d0 	ldrdeq	r0, [r0], -r0	; <UNPREDICTABLE>
    1268:	00000439 	andeq	r0, r0, r9, lsr r4
    126c:	00000444 	andeq	r0, r0, r4, asr #8
    1270:	00067813 	andeq	r7, r6, r3, lsl r8
    1274:	03e51400 	mvneq	r1, #0, 8
    1278:	15000000 	strne	r0, [r0, #-0]
    127c:	00000846 	andeq	r0, r0, r6, asr #16
    1280:	d70e3106 	strle	r3, [lr, -r6, lsl #2]
    1284:	f0000007 			; <UNDEFINED> instruction: 0xf0000007
    1288:	5c000001 	stcpl	0, cr0, [r0], {1}
    128c:	67000004 	strvs	r0, [r0, -r4]
    1290:	13000004 	movwne	r0, #4
    1294:	00000678 	andeq	r0, r0, r8, ror r6
    1298:	0003eb14 	andeq	lr, r3, r4, lsl fp
    129c:	ca160000 	bgt	5812a4 <__bss_end+0x5778a4>
    12a0:	0600000c 	streq	r0, [r0], -ip
    12a4:	08c01d35 	stmiaeq	r0, {r0, r2, r4, r5, r8, sl, fp, ip}^
    12a8:	03e50000 	mvneq	r0, #0
    12ac:	80020000 	andhi	r0, r2, r0
    12b0:	86000004 	strhi	r0, [r0], -r4
    12b4:	13000004 	movwne	r0, #4
    12b8:	00000678 	andeq	r0, r0, r8, ror r6
    12bc:	069c1600 	ldreq	r1, [ip], r0, lsl #12
    12c0:	37060000 	strcc	r0, [r6, -r0]
    12c4:	000a191d 	andeq	r1, sl, sp, lsl r9
    12c8:	0003e500 	andeq	lr, r3, r0, lsl #10
    12cc:	049f0200 	ldreq	r0, [pc], #512	; 12d4 <shift+0x12d4>
    12d0:	04a50000 	strteq	r0, [r5], #0
    12d4:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
    12d8:	00000006 	andeq	r0, r0, r6
    12dc:	0009a817 	andeq	sl, r9, r7, lsl r8
    12e0:	31390600 	teqcc	r9, r0, lsl #12
    12e4:	00000691 	muleq	r0, r1, r6
    12e8:	1316020c 	tstne	r6, #12, 4	; 0xc0000000
    12ec:	0600000b 	streq	r0, [r0], -fp
    12f0:	0855093c 	ldmdaeq	r5, {r2, r3, r4, r5, r8, fp}^
    12f4:	06780000 	ldrbteq	r0, [r8], -r0
    12f8:	cc010000 	stcgt	0, cr0, [r1], {-0}
    12fc:	d2000004 	andle	r0, r0, #4
    1300:	13000004 	movwne	r0, #4
    1304:	00000678 	andeq	r0, r0, r8, ror r6
    1308:	07231600 	streq	r1, [r3, -r0, lsl #12]!
    130c:	3f060000 	svccc	0x00060000
    1310:	00055c12 	andeq	r5, r5, r2, lsl ip
    1314:	00004d00 	andeq	r4, r0, r0, lsl #26
    1318:	04eb0100 	strbteq	r0, [fp], #256	; 0x100
    131c:	05000000 	streq	r0, [r0, #-0]
    1320:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
    1324:	14000006 	strne	r0, [r0], #-6
    1328:	0000069a 	muleq	r0, sl, r6
    132c:	00005e14 	andeq	r5, r0, r4, lsl lr
    1330:	01f01400 	mvnseq	r1, r0, lsl #8
    1334:	18000000 	stmdane	r0, {}	; <UNPREDICTABLE>
    1338:	00000d17 	andeq	r0, r0, r7, lsl sp
    133c:	180e4206 	stmdane	lr, {r1, r2, r9, lr}
    1340:	01000006 	tsteq	r0, r6
    1344:	00000515 	andeq	r0, r0, r5, lsl r5
    1348:	0000051b 	andeq	r0, r0, fp, lsl r5
    134c:	00067813 	andeq	r7, r6, r3, lsl r8
    1350:	3e160000 	cdpcc	0, 1, cr0, cr6, cr0, {0}
    1354:	06000005 	streq	r0, [r0], -r5
    1358:	05b01745 	ldreq	r1, [r0, #1861]!	; 0x745
    135c:	03eb0000 	mvneq	r0, #0
    1360:	34010000 	strcc	r0, [r1], #-0
    1364:	3a000005 	bcc	1380 <shift+0x1380>
    1368:	13000005 	movwne	r0, #5
    136c:	000006a0 	andeq	r0, r0, r0, lsr #13
    1370:	0b8b1600 	bleq	fe2c6b78 <__bss_end+0xfe2bd178>
    1374:	48060000 	stmdami	r6, {}	; <UNPREDICTABLE>
    1378:	0003ff17 	andeq	pc, r3, r7, lsl pc	; <UNPREDICTABLE>
    137c:	0003eb00 	andeq	lr, r3, r0, lsl #22
    1380:	05530100 	ldrbeq	r0, [r3, #-256]	; 0xffffff00
    1384:	055e0000 	ldrbeq	r0, [lr, #-0]
    1388:	a0130000 	andsge	r0, r3, r0
    138c:	14000006 	strne	r0, [r0], #-6
    1390:	0000004d 	andeq	r0, r0, sp, asr #32
    1394:	06431800 	strbeq	r1, [r3], -r0, lsl #16
    1398:	4b060000 	blmi	1813a0 <__bss_end+0x1779a0>
    139c:	0009b60e 	andeq	fp, r9, lr, lsl #12
    13a0:	05730100 	ldrbeq	r0, [r3, #-256]!	; 0xffffff00
    13a4:	05790000 	ldrbeq	r0, [r9, #-0]!
    13a8:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
    13ac:	00000006 	andeq	r0, r0, r6
    13b0:	00084616 	andeq	r4, r8, r6, lsl r6
    13b4:	0e4d0600 	cdpeq	6, 4, cr0, cr13, cr0, {0}
    13b8:	00000a9b 	muleq	r0, fp, sl
    13bc:	000001f0 	strdeq	r0, [r0], -r0	; <UNPREDICTABLE>
    13c0:	00059201 	andeq	r9, r5, r1, lsl #4
    13c4:	00059d00 	andeq	r9, r5, r0, lsl #26
    13c8:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
    13cc:	4d140000 	ldcmi	0, cr0, [r4, #-0]
    13d0:	00000000 	andeq	r0, r0, r0
    13d4:	0004c616 	andeq	ip, r4, r6, lsl r6
    13d8:	12500600 	subsne	r0, r0, #0, 12
    13dc:	0000042c 	andeq	r0, r0, ip, lsr #8
    13e0:	0000004d 	andeq	r0, r0, sp, asr #32
    13e4:	0005b601 	andeq	fp, r5, r1, lsl #12
    13e8:	0005c100 	andeq	ip, r5, r0, lsl #2
    13ec:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
    13f0:	fd140000 	ldc2	0, cr0, [r4, #-0]
    13f4:	00000001 	andeq	r0, r0, r1
    13f8:	00045f16 	andeq	r5, r4, r6, lsl pc
    13fc:	0e530600 	cdpeq	6, 5, cr0, cr3, cr0, {0}
    1400:	00000d2b 	andeq	r0, r0, fp, lsr #26
    1404:	000001f0 	strdeq	r0, [r0], -r0	; <UNPREDICTABLE>
    1408:	0005da01 	andeq	sp, r5, r1, lsl #20
    140c:	0005e500 	andeq	lr, r5, r0, lsl #10
    1410:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
    1414:	4d140000 	ldcmi	0, cr0, [r4, #-0]
    1418:	00000000 	andeq	r0, r0, r0
    141c:	0004a018 	andeq	sl, r4, r8, lsl r0
    1420:	0e560600 	cdpeq	6, 5, cr0, cr6, cr0, {0}
    1424:	00000c0b 	andeq	r0, r0, fp, lsl #24
    1428:	0005fa01 	andeq	pc, r5, r1, lsl #20
    142c:	00061900 	andeq	r1, r6, r0, lsl #18
    1430:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
    1434:	a9140000 	ldmdbge	r4, {}	; <UNPREDICTABLE>
    1438:	14000000 	strne	r0, [r0], #-0
    143c:	0000004d 	andeq	r0, r0, sp, asr #32
    1440:	00004d14 	andeq	r4, r0, r4, lsl sp
    1444:	004d1400 	subeq	r1, sp, r0, lsl #8
    1448:	a6140000 	ldrge	r0, [r4], -r0
    144c:	00000006 	andeq	r0, r0, r6
    1450:	000d5718 	andeq	r5, sp, r8, lsl r7
    1454:	0e580600 	cdpeq	6, 5, cr0, cr8, cr0, {0}
    1458:	00000ddc 	ldrdeq	r0, [r0], -ip
    145c:	00062e01 	andeq	r2, r6, r1, lsl #28
    1460:	00064d00 	andeq	r4, r6, r0, lsl #26
    1464:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
    1468:	e0140000 	ands	r0, r4, r0
    146c:	14000000 	strne	r0, [r0], #-0
    1470:	0000004d 	andeq	r0, r0, sp, asr #32
    1474:	00004d14 	andeq	r4, r0, r4, lsl sp
    1478:	004d1400 	subeq	r1, sp, r0, lsl #8
    147c:	a6140000 	ldrge	r0, [r4], -r0
    1480:	00000006 	andeq	r0, r0, r6
    1484:	0004b319 	andeq	fp, r4, r9, lsl r3
    1488:	0e5b0600 	cdpeq	6, 5, cr0, cr11, cr0, {0}
    148c:	0000092f 	andeq	r0, r0, pc, lsr #18
    1490:	000001f0 	strdeq	r0, [r0], -r0	; <UNPREDICTABLE>
    1494:	00066201 	andeq	r6, r6, r1, lsl #4
    1498:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
    149c:	68140000 	ldmdavs	r4, {}	; <UNPREDICTABLE>
    14a0:	14000003 	strne	r0, [r0], #-3
    14a4:	000006ac 	andeq	r0, r0, ip, lsr #13
    14a8:	f1030000 			; <UNDEFINED> instruction: 0xf1030000
    14ac:	0d000003 	stceq	0, cr0, [r0, #-12]
    14b0:	0003f104 	andeq	pc, r3, r4, lsl #2
    14b4:	03e51a00 	mvneq	r1, #0, 20
    14b8:	068b0000 	streq	r0, [fp], r0
    14bc:	06910000 	ldreq	r0, [r1], r0
    14c0:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
    14c4:	00000006 	andeq	r0, r0, r6
    14c8:	0003f11b 	andeq	pc, r3, fp, lsl r1	; <UNPREDICTABLE>
    14cc:	00067e00 	andeq	r7, r6, r0, lsl #28
    14d0:	3f040d00 	svccc	0x00040d00
    14d4:	0d000000 	stceq	0, cr0, [r0, #-0]
    14d8:	00067304 	andeq	r7, r6, r4, lsl #6
    14dc:	65041c00 	strvs	r1, [r4, #-3072]	; 0xfffff400
    14e0:	1d000000 	stcne	0, cr0, [r0, #-0]
    14e4:	002c0f04 	eoreq	r0, ip, r4, lsl #30
    14e8:	06be0000 	ldrteq	r0, [lr], r0
    14ec:	5e100000 	cdppl	0, 1, cr0, cr0, cr0, {0}
    14f0:	09000000 	stmdbeq	r0, {}	; <UNPREDICTABLE>
    14f4:	06ae0300 	strteq	r0, [lr], r0, lsl #6
    14f8:	2e1e0000 	cdpcs	0, 1, cr0, cr14, cr0, {0}
    14fc:	0100000f 	tsteq	r0, pc
    1500:	06be0ca3 	ldrteq	r0, [lr], r3, lsr #25
    1504:	03050000 	movweq	r0, #20480	; 0x5000
    1508:	00009940 	andeq	r9, r0, r0, asr #18
    150c:	000e9e1f 	andeq	r9, lr, pc, lsl lr
    1510:	0aa50100 	beq	fe941918 <__bss_end+0xfe937f18>
    1514:	00000f9d 	muleq	r0, sp, pc	; <UNPREDICTABLE>
    1518:	0000004d 	andeq	r0, r0, sp, asr #32
    151c:	00008d38 	andeq	r8, r0, r8, lsr sp
    1520:	000000b0 	strheq	r0, [r0], -r0	; <UNPREDICTABLE>
    1524:	07339c01 	ldreq	r9, [r3, -r1, lsl #24]!
    1528:	fd200000 	stc2	0, cr0, [r0, #-0]
    152c:	01000011 	tsteq	r0, r1, lsl r0
    1530:	01f71ba5 	mvnseq	r1, r5, lsr #23
    1534:	91030000 	mrsls	r0, (UNDEF: 3)
    1538:	fc207fac 	stc2	15, cr7, [r0], #-688	; 0xfffffd50
    153c:	0100000f 	tsteq	r0, pc
    1540:	004d2aa5 	subeq	r2, sp, r5, lsr #21
    1544:	91030000 	mrsls	r0, (UNDEF: 3)
    1548:	861e7fa8 	ldrhi	r7, [lr], -r8, lsr #31
    154c:	0100000f 	tsteq	r0, pc
    1550:	07330aa7 	ldreq	r0, [r3, -r7, lsr #21]!
    1554:	91030000 	mrsls	r0, (UNDEF: 3)
    1558:	991e7fb4 	ldmdbls	lr, {r2, r4, r5, r7, r8, r9, sl, fp, ip, sp, lr}
    155c:	0100000e 	tsteq	r0, lr
    1560:	003809ab 	eorseq	r0, r8, fp, lsr #19
    1564:	91020000 	mrsls	r0, (UNDEF: 2)
    1568:	250f0074 	strcs	r0, [pc, #-116]	; 14fc <shift+0x14fc>
    156c:	43000000 	movwmi	r0, #0
    1570:	10000007 	andne	r0, r0, r7
    1574:	0000005e 	andeq	r0, r0, lr, asr r0
    1578:	e121003f 			; <UNDEFINED> instruction: 0xe121003f
    157c:	0100000f 	tsteq	r0, pc
    1580:	10910a97 	umullsne	r0, r1, r7, sl
    1584:	004d0000 	subeq	r0, sp, r0
    1588:	8cfc0000 	ldclhi	0, cr0, [ip]
    158c:	003c0000 	eorseq	r0, ip, r0
    1590:	9c010000 	stcls	0, cr0, [r1], {-0}
    1594:	00000780 	andeq	r0, r0, r0, lsl #15
    1598:	71657222 	cmnvc	r5, r2, lsr #4
    159c:	20990100 	addscs	r0, r9, r0, lsl #2
    15a0:	000003ab 	andeq	r0, r0, fp, lsr #7
    15a4:	1e749102 	expnes	f1, f2
    15a8:	00000f92 	muleq	r0, r2, pc	; <UNPREDICTABLE>
    15ac:	4d0e9a01 	vstrmi	s18, [lr, #-4]
    15b0:	02000000 	andeq	r0, r0, #0
    15b4:	23007091 	movwcs	r7, #145	; 0x91
    15b8:	00001005 	andeq	r1, r0, r5
    15bc:	ba068e01 	blt	1a4dc8 <__bss_end+0x19b3c8>
    15c0:	c000000e 	andgt	r0, r0, lr
    15c4:	3c00008c 	stccc	0, cr0, [r0], {140}	; 0x8c
    15c8:	01000000 	mrseq	r0, (UNDEF: 0)
    15cc:	0007b99c 	muleq	r7, ip, r9
    15d0:	0efc2000 	cdpeq	0, 15, cr2, cr12, cr0, {0}
    15d4:	8e010000 	cdphi	0, 0, cr0, cr1, cr0, {0}
    15d8:	00004d21 	andeq	r4, r0, r1, lsr #26
    15dc:	6c910200 	lfmvs	f0, 4, [r1], {0}
    15e0:	71657222 	cmnvc	r5, r2, lsr #4
    15e4:	20900100 	addscs	r0, r0, r0, lsl #2
    15e8:	000003ab 	andeq	r0, r0, fp, lsr #7
    15ec:	00749102 	rsbseq	r9, r4, r2, lsl #2
    15f0:	000fbe21 	andeq	fp, pc, r1, lsr #28
    15f4:	0a820100 	beq	fe0819fc <__bss_end+0xfe077ffc>
    15f8:	00000f3f 	andeq	r0, r0, pc, lsr pc
    15fc:	0000004d 	andeq	r0, r0, sp, asr #32
    1600:	00008c84 	andeq	r8, r0, r4, lsl #25
    1604:	0000003c 	andeq	r0, r0, ip, lsr r0
    1608:	07f69c01 	ldrbeq	r9, [r6, r1, lsl #24]!
    160c:	72220000 	eorvc	r0, r2, #0
    1610:	01007165 	tsteq	r0, r5, ror #2
    1614:	03872084 	orreq	r2, r7, #132	; 0x84
    1618:	91020000 	mrsls	r0, (UNDEF: 2)
    161c:	0e921e74 	mrceq	14, 4, r1, cr2, cr4, {3}
    1620:	85010000 	strhi	r0, [r1, #-0]
    1624:	00004d0e 	andeq	r4, r0, lr, lsl #26
    1628:	70910200 	addsvc	r0, r1, r0, lsl #4
    162c:	11e02100 	mvnne	r2, r0, lsl #2
    1630:	76010000 	strvc	r0, [r1], -r0
    1634:	000f100a 	andeq	r1, pc, sl
    1638:	00004d00 	andeq	r4, r0, r0, lsl #26
    163c:	008c4800 	addeq	r4, ip, r0, lsl #16
    1640:	00003c00 	andeq	r3, r0, r0, lsl #24
    1644:	339c0100 	orrscc	r0, ip, #0, 2
    1648:	22000008 	andcs	r0, r0, #8
    164c:	00716572 	rsbseq	r6, r1, r2, ror r5
    1650:	87207801 	strhi	r7, [r0, -r1, lsl #16]!
    1654:	02000003 	andeq	r0, r0, #3
    1658:	921e7491 	andsls	r7, lr, #-1862270976	; 0x91000000
    165c:	0100000e 	tsteq	r0, lr
    1660:	004d0e79 	subeq	r0, sp, r9, ror lr
    1664:	91020000 	mrsls	r0, (UNDEF: 2)
    1668:	53210070 			; <UNDEFINED> instruction: 0x53210070
    166c:	0100000f 	tsteq	r0, pc
    1670:	1073066a 	rsbsne	r0, r3, sl, ror #12
    1674:	01f00000 	mvnseq	r0, r0
    1678:	8bf40000 	blhi	ffd01680 <__bss_end+0xffcf7c80>
    167c:	00540000 	subseq	r0, r4, r0
    1680:	9c010000 	stcls	0, cr0, [r1], {-0}
    1684:	0000087f 	andeq	r0, r0, pc, ror r8
    1688:	000f9220 	andeq	r9, pc, r0, lsr #4
    168c:	156a0100 	strbne	r0, [sl, #-256]!	; 0xffffff00
    1690:	0000004d 	andeq	r0, r0, sp, asr #32
    1694:	206c9102 	rsbcs	r9, ip, r2, lsl #2
    1698:	00000a58 	andeq	r0, r0, r8, asr sl
    169c:	4d256a01 	vstmdbmi	r5!, {s12}
    16a0:	02000000 	andeq	r0, r0, #0
    16a4:	d81e6891 	ldmdale	lr, {r0, r4, r7, fp, sp, lr}
    16a8:	01000011 	tsteq	r0, r1, lsl r0
    16ac:	004d0e6c 	subeq	r0, sp, ip, ror #28
    16b0:	91020000 	mrsls	r0, (UNDEF: 2)
    16b4:	d1210074 			; <UNDEFINED> instruction: 0xd1210074
    16b8:	0100000e 	tsteq	r0, lr
    16bc:	10c8125d 	sbcne	r1, r8, sp, asr r2
    16c0:	008b0000 	addeq	r0, fp, r0
    16c4:	8ba40000 	blhi	fe9016cc <__bss_end+0xfe8f7ccc>
    16c8:	00500000 	subseq	r0, r0, r0
    16cc:	9c010000 	stcls	0, cr0, [r1], {-0}
    16d0:	000008da 	ldrdeq	r0, [r0], -sl
    16d4:	00107e20 	andseq	r7, r0, r0, lsr #28
    16d8:	205d0100 	subscs	r0, sp, r0, lsl #2
    16dc:	0000004d 	andeq	r0, r0, sp, asr #32
    16e0:	206c9102 	rsbcs	r9, ip, r2, lsl #2
    16e4:	00000fc7 	andeq	r0, r0, r7, asr #31
    16e8:	4d2f5d01 	stcmi	13, cr5, [pc, #-4]!	; 16ec <shift+0x16ec>
    16ec:	02000000 	andeq	r0, r0, #0
    16f0:	58206891 	stmdapl	r0!, {r0, r4, r7, fp, sp, lr}
    16f4:	0100000a 	tsteq	r0, sl
    16f8:	004d3f5d 	subeq	r3, sp, sp, asr pc
    16fc:	91020000 	mrsls	r0, (UNDEF: 2)
    1700:	11d81e64 	bicsne	r1, r8, r4, ror #28
    1704:	5f010000 	svcpl	0x00010000
    1708:	00008b16 	andeq	r8, r0, r6, lsl fp
    170c:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    1710:	10fe2100 	rscsne	r2, lr, r0, lsl #2
    1714:	51010000 	mrspl	r0, (UNDEF: 1)
    1718:	000ed60a 	andeq	sp, lr, sl, lsl #12
    171c:	00004d00 	andeq	r4, r0, r0, lsl #26
    1720:	008b6000 	addeq	r6, fp, r0
    1724:	00004400 	andeq	r4, r0, r0, lsl #8
    1728:	269c0100 	ldrcs	r0, [ip], r0, lsl #2
    172c:	20000009 	andcs	r0, r0, r9
    1730:	0000107e 	andeq	r1, r0, lr, ror r0
    1734:	4d1a5101 	ldfmis	f5, [sl, #-4]
    1738:	02000000 	andeq	r0, r0, #0
    173c:	c7206c91 			; <UNDEFINED> instruction: 0xc7206c91
    1740:	0100000f 	tsteq	r0, pc
    1744:	004d2951 	subeq	r2, sp, r1, asr r9
    1748:	91020000 	mrsls	r0, (UNDEF: 2)
    174c:	10f71e68 	rscsne	r1, r7, r8, ror #28
    1750:	53010000 	movwpl	r0, #4096	; 0x1000
    1754:	00004d0e 	andeq	r4, r0, lr, lsl #26
    1758:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    175c:	10f12100 	rscsne	r2, r1, r0, lsl #2
    1760:	44010000 	strmi	r0, [r1], #-0
    1764:	0010d30a 	andseq	sp, r0, sl, lsl #6
    1768:	00004d00 	andeq	r4, r0, r0, lsl #26
    176c:	008b1000 	addeq	r1, fp, r0
    1770:	00005000 	andeq	r5, r0, r0
    1774:	819c0100 	orrshi	r0, ip, r0, lsl #2
    1778:	20000009 	andcs	r0, r0, r9
    177c:	0000107e 	andeq	r1, r0, lr, ror r0
    1780:	4d194401 	cfldrsmi	mvf4, [r9, #-4]
    1784:	02000000 	andeq	r0, r0, #0
    1788:	67206c91 			; <UNDEFINED> instruction: 0x67206c91
    178c:	0100000f 	tsteq	r0, pc
    1790:	011d3044 	tsteq	sp, r4, asr #32
    1794:	91020000 	mrsls	r0, (UNDEF: 2)
    1798:	0fcd2068 	svceq	0x00cd2068
    179c:	44010000 	strmi	r0, [r1], #-0
    17a0:	0006ac41 	andeq	sl, r6, r1, asr #24
    17a4:	64910200 	ldrvs	r0, [r1], #512	; 0x200
    17a8:	0011d81e 	andseq	sp, r1, lr, lsl r8
    17ac:	0e460100 	dvfeqs	f0, f6, f0
    17b0:	0000004d 	andeq	r0, r0, sp, asr #32
    17b4:	00749102 	rsbseq	r9, r4, r2, lsl #2
    17b8:	000e7f23 	andeq	r7, lr, r3, lsr #30
    17bc:	063e0100 	ldrteq	r0, [lr], -r0, lsl #2
    17c0:	00000f71 	andeq	r0, r0, r1, ror pc
    17c4:	00008ae4 	andeq	r8, r0, r4, ror #21
    17c8:	0000002c 	andeq	r0, r0, ip, lsr #32
    17cc:	09ab9c01 	stmibeq	fp!, {r0, sl, fp, ip, pc}
    17d0:	7e200000 	cdpvc	0, 2, cr0, cr0, cr0, {0}
    17d4:	01000010 	tsteq	r0, r0, lsl r0
    17d8:	004d153e 	subeq	r1, sp, lr, lsr r5
    17dc:	91020000 	mrsls	r0, (UNDEF: 2)
    17e0:	8c210074 	stchi	0, cr0, [r1], #-464	; 0xfffffe30
    17e4:	0100000f 	tsteq	r0, pc
    17e8:	0fd30a31 	svceq	0x00d30a31
    17ec:	004d0000 	subeq	r0, sp, r0
    17f0:	8a940000 	bhi	fe5017f8 <__bss_end+0xfe4f7df8>
    17f4:	00500000 	subseq	r0, r0, r0
    17f8:	9c010000 	stcls	0, cr0, [r1], {-0}
    17fc:	00000a06 	andeq	r0, r0, r6, lsl #20
    1800:	00107e20 	andseq	r7, r0, r0, lsr #28
    1804:	19310100 	ldmdbne	r1!, {r8}
    1808:	0000004d 	andeq	r0, r0, sp, asr #32
    180c:	206c9102 	rsbcs	r9, ip, r2, lsl #2
    1810:	00001114 	andeq	r1, r0, r4, lsl r1
    1814:	f72b3101 			; <UNDEFINED> instruction: 0xf72b3101
    1818:	02000001 	andeq	r0, r0, #1
    181c:	00206891 	mlaeq	r0, r1, r8, r6
    1820:	01000010 	tsteq	r0, r0, lsl r0
    1824:	004d3c31 	subeq	r3, sp, r1, lsr ip
    1828:	91020000 	mrsls	r0, (UNDEF: 2)
    182c:	10c21e64 	sbcne	r1, r2, r4, ror #28
    1830:	33010000 	movwcc	r0, #4096	; 0x1000
    1834:	00004d0e 	andeq	r4, r0, lr, lsl #26
    1838:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    183c:	12022100 	andne	r2, r2, #0, 2
    1840:	24010000 	strcs	r0, [r1], #-0
    1844:	00111b0a 	andseq	r1, r1, sl, lsl #22
    1848:	00004d00 	andeq	r4, r0, r0, lsl #26
    184c:	008a4400 	addeq	r4, sl, r0, lsl #8
    1850:	00005000 	andeq	r5, r0, r0
    1854:	619c0100 	orrsvs	r0, ip, r0, lsl #2
    1858:	2000000a 	andcs	r0, r0, sl
    185c:	0000107e 	andeq	r1, r0, lr, ror r0
    1860:	4d182401 	cfldrsmi	mvf2, [r8, #-4]
    1864:	02000000 	andeq	r0, r0, #0
    1868:	14206c91 	strtne	r6, [r0], #-3217	; 0xfffff36f
    186c:	01000011 	tsteq	r0, r1, lsl r0
    1870:	0a672a24 	beq	19cc108 <__bss_end+0x19c2708>
    1874:	91020000 	mrsls	r0, (UNDEF: 2)
    1878:	10002068 	andne	r2, r0, r8, rrx
    187c:	24010000 	strcs	r0, [r1], #-0
    1880:	00004d3b 	andeq	r4, r0, fp, lsr sp
    1884:	64910200 	ldrvs	r0, [r1], #512	; 0x200
    1888:	000ea31e 	andeq	sl, lr, lr, lsl r3
    188c:	0e260100 	sufeqs	f0, f6, f0
    1890:	0000004d 	andeq	r0, r0, sp, asr #32
    1894:	00749102 	rsbseq	r9, r4, r2, lsl #2
    1898:	0025040d 	eoreq	r0, r5, sp, lsl #8
    189c:	61030000 	mrsvs	r0, (UNDEF: 3)
    18a0:	2100000a 	tstcs	r0, sl
    18a4:	00000f98 	muleq	r0, r8, pc	; <UNPREDICTABLE>
    18a8:	0e0a1901 	vmlaeq.f16	s2, s20, s2	; <UNPREDICTABLE>
    18ac:	4d000012 	stcmi	0, cr0, [r0, #-72]	; 0xffffffb8
    18b0:	00000000 	andeq	r0, r0, r0
    18b4:	4400008a 	strmi	r0, [r0], #-138	; 0xffffff76
    18b8:	01000000 	mrseq	r0, (UNDEF: 0)
    18bc:	000ab89c 	muleq	sl, ip, r8
    18c0:	11f92000 	mvnsne	r2, r0
    18c4:	19010000 	stmdbne	r1, {}	; <UNPREDICTABLE>
    18c8:	0001f71b 	andeq	pc, r1, fp, lsl r7	; <UNPREDICTABLE>
    18cc:	6c910200 	lfmvs	f0, 4, [r1], {0}
    18d0:	00110f20 	andseq	r0, r1, r0, lsr #30
    18d4:	35190100 	ldrcc	r0, [r9, #-256]	; 0xffffff00
    18d8:	000001c6 	andeq	r0, r0, r6, asr #3
    18dc:	1e689102 	lgnnee	f1, f2
    18e0:	0000107e 	andeq	r1, r0, lr, ror r0
    18e4:	4d0e1b01 	vstrmi	d1, [lr, #-4]
    18e8:	02000000 	andeq	r0, r0, #0
    18ec:	24007491 	strcs	r7, [r0], #-1169	; 0xfffffb6f
    18f0:	00000ef0 	strdeq	r0, [r0], -r0	; <UNPREDICTABLE>
    18f4:	a9061401 	stmdbge	r6, {r0, sl, ip}
    18f8:	e400000e 	str	r0, [r0], #-14
    18fc:	1c000089 	stcne	0, cr0, [r0], {137}	; 0x89
    1900:	01000000 	mrseq	r0, (UNDEF: 0)
    1904:	1105239c 			; <UNDEFINED> instruction: 0x1105239c
    1908:	0e010000 	cdpeq	0, 0, cr0, cr1, cr0, {0}
    190c:	000f5906 	andeq	r5, pc, r6, lsl #18
    1910:	0089b800 	addeq	fp, r9, r0, lsl #16
    1914:	00002c00 	andeq	r2, r0, r0, lsl #24
    1918:	f89c0100 			; <UNDEFINED> instruction: 0xf89c0100
    191c:	2000000a 	andcs	r0, r0, sl
    1920:	00000ee7 	andeq	r0, r0, r7, ror #29
    1924:	38140e01 	ldmdacc	r4, {r0, r9, sl, fp}
    1928:	02000000 	andeq	r0, r0, #0
    192c:	25007491 	strcs	r7, [r0, #-1169]	; 0xfffffb6f
    1930:	00001207 	andeq	r1, r0, r7, lsl #4
    1934:	7b0a0401 	blvc	282940 <__bss_end+0x278f40>
    1938:	4d00000f 	stcmi	0, cr0, [r0, #-60]	; 0xffffffc4
    193c:	8c000000 	stchi	0, cr0, [r0], {-0}
    1940:	2c000089 	stccs	0, cr0, [r0], {137}	; 0x89
    1944:	01000000 	mrseq	r0, (UNDEF: 0)
    1948:	6970229c 	ldmdbvs	r0!, {r2, r3, r4, r7, r9, sp}^
    194c:	06010064 	streq	r0, [r1], -r4, rrx
    1950:	00004d0e 	andeq	r4, r0, lr, lsl #26
    1954:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    1958:	047c0000 	ldrbteq	r0, [ip], #-0
    195c:	00040000 	andeq	r0, r4, r0
    1960:	0000072c 	andeq	r0, r0, ip, lsr #14
    1964:	11270104 			; <UNDEFINED> instruction: 0x11270104
    1968:	52040000 	andpl	r0, r4, #0
    196c:	34000013 	strcc	r0, [r0], #-19	; 0xffffffed
    1970:	e800000e 	stmda	r0, {r1, r2, r3}
    1974:	c000008d 	andgt	r0, r0, sp, lsl #1
    1978:	c5000007 	strgt	r0, [r0, #-7]
    197c:	02000009 	andeq	r0, r0, #9
    1980:	00000049 	andeq	r0, r0, r9, asr #32
    1984:	0012c303 	andseq	ip, r2, r3, lsl #6
    1988:	10050100 	andne	r0, r5, r0, lsl #2
    198c:	00000061 	andeq	r0, r0, r1, rrx
    1990:	32313011 	eorscc	r3, r1, #17
    1994:	36353433 			; <UNDEFINED> instruction: 0x36353433
    1998:	41393837 	teqmi	r9, r7, lsr r8
    199c:	45444342 	strbmi	r4, [r4, #-834]	; 0xfffffcbe
    19a0:	04000046 	streq	r0, [r0], #-70	; 0xffffffba
    19a4:	25010301 	strcs	r0, [r1, #-769]	; 0xfffffcff
    19a8:	05000000 	streq	r0, [r0, #-0]
    19ac:	00000074 	andeq	r0, r0, r4, ror r0
    19b0:	00000061 	andeq	r0, r0, r1, rrx
    19b4:	00006606 	andeq	r6, r0, r6, lsl #12
    19b8:	07001000 	streq	r1, [r0, -r0]
    19bc:	00000051 	andeq	r0, r0, r1, asr r0
    19c0:	d7070408 	strle	r0, [r7, -r8, lsl #8]
    19c4:	0800000b 	stmdaeq	r0, {r0, r1, r3}
    19c8:	0c910801 	ldceq	8, cr0, [r1], {1}
    19cc:	6d070000 	stcvs	0, cr0, [r7, #-0]
    19d0:	09000000 	stmdbeq	r0, {}	; <UNPREDICTABLE>
    19d4:	0000002a 	andeq	r0, r0, sl, lsr #32
    19d8:	0012520a 	andseq	r5, r2, sl, lsl #4
    19dc:	06aa0100 	strteq	r0, [sl], r0, lsl #2
    19e0:	000012ad 	andeq	r1, r0, sp, lsr #5
    19e4:	00009534 	andeq	r9, r0, r4, lsr r5
    19e8:	00000074 	andeq	r0, r0, r4, ror r0
    19ec:	00d19c01 	sbcseq	r9, r1, r1, lsl #24
    19f0:	590b0000 	stmdbpl	fp, {}	; <UNPREDICTABLE>
    19f4:	01000012 	tsteq	r0, r2, lsl r0
    19f8:	00d113aa 	sbcseq	r1, r1, sl, lsr #7
    19fc:	91020000 	mrsls	r0, (UNDEF: 2)
    1a00:	72730c6c 	rsbsvc	r0, r3, #108, 24	; 0x6c00
    1a04:	aa010063 	bge	41b98 <__bss_end+0x38198>
    1a08:	0000d725 	andeq	sp, r0, r5, lsr #14
    1a0c:	68910200 	ldmvs	r1, {r9}
    1a10:	0100690d 	tsteq	r0, sp, lsl #18
    1a14:	00dd06ab 	sbcseq	r0, sp, fp, lsr #13
    1a18:	91020000 	mrsls	r0, (UNDEF: 2)
    1a1c:	006a0d74 	rsbeq	r0, sl, r4, ror sp
    1a20:	dd06ac01 	stcle	12, cr10, [r6, #-4]
    1a24:	02000000 	andeq	r0, r0, #0
    1a28:	0e007091 	mcreq	0, 0, r7, cr0, cr1, {4}
    1a2c:	00006d04 	andeq	r6, r0, r4, lsl #26
    1a30:	74040e00 	strvc	r0, [r4], #-3584	; 0xfffff200
    1a34:	0f000000 	svceq	0x00000000
    1a38:	6e690504 	cdpvs	5, 6, cr0, cr9, cr4, {0}
    1a3c:	e1100074 	tst	r0, r4, ror r0
    1a40:	01000012 	tsteq	r0, r2, lsl r0
    1a44:	122a06a1 	eorne	r0, sl, #168820736	; 0xa100000
    1a48:	94b40000 	ldrtls	r0, [r4], #0
    1a4c:	00800000 	addeq	r0, r0, r0
    1a50:	9c010000 	stcls	0, cr0, [r1], {-0}
    1a54:	00000161 	andeq	r0, r0, r1, ror #2
    1a58:	6372730c 	cmnvs	r2, #12, 6	; 0x30000000
    1a5c:	19a10100 	stmibne	r1!, {r8}
    1a60:	00000161 	andeq	r0, r0, r1, ror #2
    1a64:	0c649102 	stfeqp	f1, [r4], #-8
    1a68:	00747364 	rsbseq	r7, r4, r4, ror #6
    1a6c:	6824a101 	stmdavs	r4!, {r0, r8, sp, pc}
    1a70:	02000001 	andeq	r0, r0, #1
    1a74:	6e0c6091 	mcrvs	0, 0, r6, cr12, cr1, {4}
    1a78:	01006d75 	tsteq	r0, r5, ror sp
    1a7c:	00dd2da1 	sbcseq	r2, sp, r1, lsr #27
    1a80:	91020000 	mrsls	r0, (UNDEF: 2)
    1a84:	12d4115c 	sbcsne	r1, r4, #92, 2
    1a88:	a3010000 	movwge	r0, #4096	; 0x1000
    1a8c:	0000d70e 	andeq	sp, r0, lr, lsl #14
    1a90:	70910200 	addsvc	r0, r1, r0, lsl #4
    1a94:	0012bc11 	andseq	fp, r2, r1, lsl ip
    1a98:	08a40100 	stmiaeq	r4!, {r8}
    1a9c:	000000d1 	ldrdeq	r0, [r0], -r1
    1aa0:	126c9102 	rsbne	r9, ip, #-2147483648	; 0x80000000
    1aa4:	000094dc 	ldrdeq	r9, [r0], -ip
    1aa8:	00000048 	andeq	r0, r0, r8, asr #32
    1aac:	0100690d 	tsteq	r0, sp, lsl #18
    1ab0:	00dd0ba6 	sbcseq	r0, sp, r6, lsr #23
    1ab4:	91020000 	mrsls	r0, (UNDEF: 2)
    1ab8:	0e000074 	mcreq	0, 0, r0, cr0, cr4, {3}
    1abc:	00016704 	andeq	r6, r1, r4, lsl #14
    1ac0:	04141300 	ldreq	r1, [r4], #-768	; 0xfffffd00
    1ac4:	0012db10 	andseq	sp, r2, r0, lsl fp
    1ac8:	06990100 	ldreq	r0, [r9], r0, lsl #2
    1acc:	00001270 	andeq	r1, r0, r0, ror r2
    1ad0:	0000944c 	andeq	r9, r0, ip, asr #8
    1ad4:	00000068 	andeq	r0, r0, r8, rrx
    1ad8:	01c99c01 	biceq	r9, r9, r1, lsl #24
    1adc:	440b0000 	strmi	r0, [fp], #-0
    1ae0:	01000013 	tsteq	r0, r3, lsl r0
    1ae4:	01681299 			; <UNDEFINED> instruction: 0x01681299
    1ae8:	91020000 	mrsls	r0, (UNDEF: 2)
    1aec:	134b0b6c 	movtne	r0, #47980	; 0xbb6c
    1af0:	99010000 	stmdbls	r1, {}	; <UNPREDICTABLE>
    1af4:	0000dd1e 	andeq	sp, r0, lr, lsl sp
    1af8:	68910200 	ldmvs	r1, {r9}
    1afc:	6d656d0d 	stclvs	13, cr6, [r5, #-52]!	; 0xffffffcc
    1b00:	089b0100 	ldmeq	fp, {r8}
    1b04:	000000d1 	ldrdeq	r0, [r0], -r1
    1b08:	12709102 	rsbsne	r9, r0, #-2147483648	; 0x80000000
    1b0c:	00009468 	andeq	r9, r0, r8, ror #8
    1b10:	0000003c 	andeq	r0, r0, ip, lsr r0
    1b14:	0100690d 	tsteq	r0, sp, lsl #18
    1b18:	00dd0b9d 	smullseq	r0, sp, sp, fp
    1b1c:	91020000 	mrsls	r0, (UNDEF: 2)
    1b20:	15000074 	strne	r0, [r0, #-116]	; 0xffffff8c
    1b24:	0000124b 	andeq	r1, r0, fp, asr #4
    1b28:	1d058f01 	stcne	15, cr8, [r5, #-4]
    1b2c:	dd000013 	stcle	0, cr0, [r0, #-76]	; 0xffffffb4
    1b30:	f8000000 			; <UNDEFINED> instruction: 0xf8000000
    1b34:	54000093 	strpl	r0, [r0], #-147	; 0xffffff6d
    1b38:	01000000 	mrseq	r0, (UNDEF: 0)
    1b3c:	0002029c 	muleq	r2, ip, r2
    1b40:	00730c00 	rsbseq	r0, r3, r0, lsl #24
    1b44:	d7188f01 	ldrle	r8, [r8, -r1, lsl #30]
    1b48:	02000000 	andeq	r0, r0, #0
    1b4c:	690d6c91 	stmdbvs	sp, {r0, r4, r7, sl, fp, sp, lr}
    1b50:	06910100 	ldreq	r0, [r1], r0, lsl #2
    1b54:	000000dd 	ldrdeq	r0, [r0], -sp
    1b58:	00749102 	rsbseq	r9, r4, r2, lsl #2
    1b5c:	0012e815 	andseq	lr, r2, r5, lsl r8
    1b60:	057f0100 	ldrbeq	r0, [pc, #-256]!	; 1a68 <shift+0x1a68>
    1b64:	0000132a 	andeq	r1, r0, sl, lsr #6
    1b68:	000000dd 	ldrdeq	r0, [r0], -sp
    1b6c:	0000934c 	andeq	r9, r0, ip, asr #6
    1b70:	000000ac 	andeq	r0, r0, ip, lsr #1
    1b74:	02689c01 	rsbeq	r9, r8, #256	; 0x100
    1b78:	730c0000 	movwvc	r0, #49152	; 0xc000
    1b7c:	7f010031 	svcvc	0x00010031
    1b80:	0000d719 	andeq	sp, r0, r9, lsl r7
    1b84:	6c910200 	lfmvs	f0, 4, [r1], {0}
    1b88:	0032730c 	eorseq	r7, r2, ip, lsl #6
    1b8c:	d7297f01 	strle	r7, [r9, -r1, lsl #30]!
    1b90:	02000000 	andeq	r0, r0, #0
    1b94:	6e0c6891 	mcrvs	8, 0, r6, cr12, cr1, {4}
    1b98:	01006d75 	tsteq	r0, r5, ror sp
    1b9c:	00dd317f 	sbcseq	r3, sp, pc, ror r1
    1ba0:	91020000 	mrsls	r0, (UNDEF: 2)
    1ba4:	31750d64 	cmncc	r5, r4, ror #26
    1ba8:	10810100 	addne	r0, r1, r0, lsl #2
    1bac:	00000268 	andeq	r0, r0, r8, ror #4
    1bb0:	0d779102 	ldfeqp	f1, [r7, #-8]!
    1bb4:	01003275 	tsteq	r0, r5, ror r2
    1bb8:	02681481 	rsbeq	r1, r8, #-2130706432	; 0x81000000
    1bbc:	91020000 	mrsls	r0, (UNDEF: 2)
    1bc0:	01080076 	tsteq	r8, r6, ror r0
    1bc4:	000c8808 	andeq	r8, ip, r8, lsl #16
    1bc8:	127c1500 	rsbsne	r1, ip, #0, 10
    1bcc:	73010000 	movwvc	r0, #4096	; 0x1000
    1bd0:	00128407 	andseq	r8, r2, r7, lsl #8
    1bd4:	0000d100 	andeq	sp, r0, r0, lsl #2
    1bd8:	00928c00 	addseq	r8, r2, r0, lsl #24
    1bdc:	0000c000 	andeq	ip, r0, r0
    1be0:	c89c0100 	ldmgt	ip, {r8}
    1be4:	0b000002 	bleq	1bf4 <shift+0x1bf4>
    1be8:	00001259 	andeq	r1, r0, r9, asr r2
    1bec:	d1157301 	tstle	r5, r1, lsl #6
    1bf0:	02000000 	andeq	r0, r0, #0
    1bf4:	730c6c91 	movwvc	r6, #52369	; 0xcc91
    1bf8:	01006372 	tsteq	r0, r2, ror r3
    1bfc:	00d72773 	sbcseq	r2, r7, r3, ror r7
    1c00:	91020000 	mrsls	r0, (UNDEF: 2)
    1c04:	756e0c68 	strbvc	r0, [lr, #-3176]!	; 0xfffff398
    1c08:	7301006d 	movwvc	r0, #4205	; 0x106d
    1c0c:	0000dd30 	andeq	sp, r0, r0, lsr sp
    1c10:	64910200 	ldrvs	r0, [r1], #512	; 0x200
    1c14:	0100690d 	tsteq	r0, sp, lsl #18
    1c18:	00dd0675 	sbcseq	r0, sp, r5, ror r6
    1c1c:	91020000 	mrsls	r0, (UNDEF: 2)
    1c20:	cf150074 	svcgt	0x00150074
    1c24:	01000012 	tsteq	r0, r2, lsl r0
    1c28:	13110736 	tstne	r1, #14155776	; 0xd80000
    1c2c:	00d10000 	sbcseq	r0, r1, r0
    1c30:	8ff80000 	svchi	0x00f80000
    1c34:	02940000 	addseq	r0, r4, #0
    1c38:	9c010000 	stcls	0, cr0, [r1], {-0}
    1c3c:	000003ac 	andeq	r0, r0, ip, lsr #7
    1c40:	0004f20b 	andeq	pc, r4, fp, lsl #4
    1c44:	12360100 	eorsne	r0, r6, #0, 2
    1c48:	000003ac 	andeq	r0, r0, ip, lsr #7
    1c4c:	0b4c9102 	bleq	132605c <__bss_end+0x131c65c>
    1c50:	0000130a 	andeq	r1, r0, sl, lsl #6
    1c54:	d11f3601 	tstle	pc, r1, lsl #12
    1c58:	02000000 	andeq	r0, r0, #0
    1c5c:	f00b4891 			; <UNDEFINED> instruction: 0xf00b4891
    1c60:	01000012 	tsteq	r0, r2, lsl r0
    1c64:	00663436 	rsbeq	r3, r6, r6, lsr r4
    1c68:	91020000 	mrsls	r0, (UNDEF: 2)
    1c6c:	74700d44 	ldrbtvc	r0, [r0], #-3396	; 0xfffff2bc
    1c70:	38010072 	stmdacc	r1, {r1, r4, r5, r6}
    1c74:	0000d108 	andeq	sp, r0, r8, lsl #2
    1c78:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    1c7c:	00129511 	andseq	r9, r2, r1, lsl r5
    1c80:	09410100 	stmdbeq	r1, {r8}^
    1c84:	000000dd 	ldrdeq	r0, [r0], -sp
    1c88:	11709102 	cmnne	r0, r2, lsl #2
    1c8c:	0000129e 	muleq	r0, lr, r2
    1c90:	ac0b4201 	sfmge	f4, 4, [fp], {1}
    1c94:	02000003 	andeq	r0, r0, #3
    1c98:	3c116c91 	ldccc	12, cr6, [r1], {145}	; 0x91
    1c9c:	01000013 	tsteq	r0, r3, lsl r0
    1ca0:	03b30a45 			; <UNDEFINED> instruction: 0x03b30a45
    1ca4:	91020000 	mrsls	r0, (UNDEF: 2)
    1ca8:	12681150 	rsbne	r1, r8, #80, 2
    1cac:	46010000 	strmi	r0, [r1], -r0
    1cb0:	0000d10b 	andeq	sp, r0, fp, lsl #2
    1cb4:	68910200 	ldmvs	r1, {r9}
    1cb8:	00916816 	addseq	r6, r1, r6, lsl r8
    1cbc:	00008000 	andeq	r8, r0, r0
    1cc0:	00039200 	andeq	r9, r3, r0, lsl #4
    1cc4:	00690d00 	rsbeq	r0, r9, r0, lsl #26
    1cc8:	dd0e5b01 	vstrle	d5, [lr, #-4]
    1ccc:	02000000 	andeq	r0, r0, #0
    1cd0:	80126491 	mulshi	r2, r1, r4
    1cd4:	58000091 	stmdapl	r0, {r0, r4, r7}
    1cd8:	11000000 	mrsne	r0, (UNDEF: 0)
    1cdc:	000012a7 	andeq	r1, r0, r7, lsr #5
    1ce0:	dd0d5d01 	stcle	13, cr5, [sp, #-4]
    1ce4:	02000000 	andeq	r0, r0, #0
    1ce8:	00005c91 	muleq	r0, r1, ip
    1cec:	00920012 	addseq	r0, r2, r2, lsl r0
    1cf0:	00007000 	andeq	r7, r0, r0
    1cf4:	6e650d00 	cdpvs	13, 6, cr0, cr5, cr0, {0}
    1cf8:	67010064 	strvs	r0, [r1, -r4, rrx]
    1cfc:	0000d10f 	andeq	sp, r0, pc, lsl #2
    1d00:	60910200 	addsvs	r0, r1, r0, lsl #4
    1d04:	04080000 	streq	r0, [r8], #-0
    1d08:	00067b04 	andeq	r7, r6, r4, lsl #22
    1d0c:	006d0500 	rsbeq	r0, sp, r0, lsl #10
    1d10:	03c30000 	biceq	r0, r3, #0
    1d14:	66060000 	strvs	r0, [r6], -r0
    1d18:	0b000000 	bleq	1d20 <shift+0x1d20>
    1d1c:	12461500 	subne	r1, r6, #0, 10
    1d20:	24010000 	strcs	r0, [r1], #-0
    1d24:	0012ff05 	andseq	pc, r2, r5, lsl #30
    1d28:	0000dd00 	andeq	sp, r0, r0, lsl #26
    1d2c:	008f5c00 	addeq	r5, pc, r0, lsl #24
    1d30:	00009c00 	andeq	r9, r0, r0, lsl #24
    1d34:	009c0100 	addseq	r0, ip, r0, lsl #2
    1d38:	0b000004 	bleq	1d50 <shift+0x1d50>
    1d3c:	000004f2 	strdeq	r0, [r0], -r2
    1d40:	d7162401 	ldrle	r2, [r6, -r1, lsl #8]
    1d44:	02000000 	andeq	r0, r0, #0
    1d48:	0a116c91 	beq	45cf94 <__bss_end+0x453594>
    1d4c:	01000013 	tsteq	r0, r3, lsl r0
    1d50:	00dd0626 	sbcseq	r0, sp, r6, lsr #12
    1d54:	91020000 	mrsls	r0, (UNDEF: 2)
    1d58:	63170074 	tstvs	r7, #116	; 0x74
    1d5c:	01000012 	tsteq	r0, r2, lsl r0
    1d60:	123a0608 	eorsne	r0, sl, #8, 12	; 0x800000
    1d64:	8de80000 	stclhi	0, cr0, [r8]
    1d68:	01740000 	cmneq	r4, r0
    1d6c:	9c010000 	stcls	0, cr0, [r1], {-0}
    1d70:	0004f20b 	andeq	pc, r4, fp, lsl #4
    1d74:	18080100 	stmdane	r8, {r8}
    1d78:	00000066 	andeq	r0, r0, r6, rrx
    1d7c:	0b649102 	bleq	192618c <__bss_end+0x191c78c>
    1d80:	0000130a 	andeq	r1, r0, sl, lsl #6
    1d84:	d1250801 			; <UNDEFINED> instruction: 0xd1250801
    1d88:	02000000 	andeq	r0, r0, #0
    1d8c:	5e0b6091 	mcrpl	0, 0, r6, cr11, cr1, {4}
    1d90:	01000012 	tsteq	r0, r2, lsl r0
    1d94:	00663a08 	rsbeq	r3, r6, r8, lsl #20
    1d98:	91020000 	mrsls	r0, (UNDEF: 2)
    1d9c:	00690d5c 	rsbeq	r0, r9, ip, asr sp
    1da0:	dd060a01 	vstrle	s0, [r6, #-4]
    1da4:	02000000 	andeq	r0, r0, #0
    1da8:	b4127491 	ldrlt	r7, [r2], #-1169	; 0xfffffb6f
    1dac:	9800008e 	stmdals	r0, {r1, r2, r3, r7}
    1db0:	0d000000 	stceq	0, cr0, [r0, #-0]
    1db4:	1c01006a 	stcne	0, cr0, [r1], {106}	; 0x6a
    1db8:	0000dd0b 	andeq	sp, r0, fp, lsl #26
    1dbc:	70910200 	addsvc	r0, r1, r0, lsl #4
    1dc0:	008edc12 	addeq	sp, lr, r2, lsl ip
    1dc4:	00006000 	andeq	r6, r0, r0
    1dc8:	00630d00 	rsbeq	r0, r3, r0, lsl #26
    1dcc:	6d081e01 	stcvs	14, cr1, [r8, #-4]
    1dd0:	02000000 	andeq	r0, r0, #0
    1dd4:	00006f91 	muleq	r0, r1, pc	; <UNPREDICTABLE>
	...

Disassembly of section .debug_abbrev:

00000000 <.debug_abbrev>:
   0:	10001101 	andne	r1, r0, r1, lsl #2
   4:	12011106 	andne	r1, r1, #-2147483647	; 0x80000001
   8:	1b0e0301 	blne	380c14 <__bss_end+0x377214>
   c:	130e250e 	movwne	r2, #58638	; 0xe50e
  10:	00000005 	andeq	r0, r0, r5
  14:	25011101 	strcs	r1, [r1, #-257]	; 0xfffffeff
  18:	030b130e 	movweq	r1, #45838	; 0xb30e
  1c:	110e1b0e 	tstne	lr, lr, lsl #22
  20:	10061201 	andne	r1, r6, r1, lsl #4
  24:	02000017 	andeq	r0, r0, #23
  28:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
  2c:	0b3b0b3a 	bleq	ec2d1c <__bss_end+0xeb931c>
  30:	13490b39 	movtne	r0, #39737	; 0x9b39
  34:	193c193f 	ldmdbne	ip!, {r0, r1, r2, r3, r4, r5, r8, fp, ip}
  38:	24030000 	strcs	r0, [r3], #-0
  3c:	3e0b0b00 	vmlacc.f64	d0, d11, d0
  40:	000e030b 	andeq	r0, lr, fp, lsl #6
  44:	012e0400 			; <UNDEFINED> instruction: 0x012e0400
  48:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
  4c:	0b3b0b3a 	bleq	ec2d3c <__bss_end+0xeb933c>
  50:	01110b39 	tsteq	r1, r9, lsr fp
  54:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
  58:	01194296 			; <UNDEFINED> instruction: 0x01194296
  5c:	05000013 	streq	r0, [r0, #-19]	; 0xffffffed
  60:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
  64:	0b3b0b3a 	bleq	ec2d54 <__bss_end+0xeb9354>
  68:	13490b39 	movtne	r0, #39737	; 0x9b39
  6c:	00001802 	andeq	r1, r0, r2, lsl #16
  70:	0b002406 	bleq	9090 <_Z4ftoafPcj+0x98>
  74:	030b3e0b 	movweq	r3, #48651	; 0xbe0b
  78:	07000008 	streq	r0, [r0, -r8]
  7c:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
  80:	0b3a0e03 	bleq	e83894 <__bss_end+0xe79e94>
  84:	0b390b3b 	bleq	e42d78 <__bss_end+0xe39378>
  88:	06120111 			; <UNDEFINED> instruction: 0x06120111
  8c:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
  90:	00130119 	andseq	r0, r3, r9, lsl r1
  94:	010b0800 	tsteq	fp, r0, lsl #16
  98:	06120111 			; <UNDEFINED> instruction: 0x06120111
  9c:	34090000 	strcc	r0, [r9], #-0
  a0:	3a080300 	bcc	200ca8 <__bss_end+0x1f72a8>
  a4:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
  a8:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
  ac:	0a000018 	beq	114 <shift+0x114>
  b0:	0b0b000f 	bleq	2c00f4 <__bss_end+0x2b66f4>
  b4:	00001349 	andeq	r1, r0, r9, asr #6
  b8:	01110100 	tsteq	r1, r0, lsl #2
  bc:	0b130e25 	bleq	4c3958 <__bss_end+0x4b9f58>
  c0:	0e1b0e03 	cdpeq	14, 1, cr0, cr11, cr3, {0}
  c4:	06120111 			; <UNDEFINED> instruction: 0x06120111
  c8:	00001710 	andeq	r1, r0, r0, lsl r7
  cc:	03001602 	movweq	r1, #1538	; 0x602
  d0:	3b0b3a0e 	blcc	2ce910 <__bss_end+0x2c4f10>
  d4:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
  d8:	03000013 	movweq	r0, #19
  dc:	0b0b000f 	bleq	2c0120 <__bss_end+0x2b6720>
  e0:	00001349 	andeq	r1, r0, r9, asr #6
  e4:	00001504 	andeq	r1, r0, r4, lsl #10
  e8:	01010500 	tsteq	r1, r0, lsl #10
  ec:	13011349 	movwne	r1, #4937	; 0x1349
  f0:	21060000 	mrscs	r0, (UNDEF: 6)
  f4:	2f134900 	svccs	0x00134900
  f8:	07000006 	streq	r0, [r0, -r6]
  fc:	0b0b0024 	bleq	2c0194 <__bss_end+0x2b6794>
 100:	0e030b3e 	vmoveq.16	d3[0], r0
 104:	34080000 	strcc	r0, [r8], #-0
 108:	3a0e0300 	bcc	380d10 <__bss_end+0x377310>
 10c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 110:	3f13490b 	svccc	0x0013490b
 114:	00193c19 	andseq	r3, r9, r9, lsl ip
 118:	012e0900 			; <UNDEFINED> instruction: 0x012e0900
 11c:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 120:	0b3b0b3a 	bleq	ec2e10 <__bss_end+0xeb9410>
 124:	13490b39 	movtne	r0, #39737	; 0x9b39
 128:	06120111 			; <UNDEFINED> instruction: 0x06120111
 12c:	42961840 	addsmi	r1, r6, #64, 16	; 0x400000
 130:	00130119 	andseq	r0, r3, r9, lsl r1
 134:	00340a00 	eorseq	r0, r4, r0, lsl #20
 138:	0b3a0e03 	bleq	e8394c <__bss_end+0xe79f4c>
 13c:	0b390b3b 	bleq	e42e30 <__bss_end+0xe39430>
 140:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 144:	240b0000 	strcs	r0, [fp], #-0
 148:	3e0b0b00 	vmlacc.f64	d0, d11, d0
 14c:	0008030b 	andeq	r0, r8, fp, lsl #6
 150:	002e0c00 	eoreq	r0, lr, r0, lsl #24
 154:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 158:	0b3b0b3a 	bleq	ec2e48 <__bss_end+0xeb9448>
 15c:	01110b39 	tsteq	r1, r9, lsr fp
 160:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 164:	00194297 	mulseq	r9, r7, r2
 168:	01390d00 	teqeq	r9, r0, lsl #26
 16c:	0b3a0e03 	bleq	e83980 <__bss_end+0xe79f80>
 170:	13010b3b 	movwne	r0, #6971	; 0x1b3b
 174:	2e0e0000 	cdpcs	0, 0, cr0, cr14, cr0, {0}
 178:	03193f01 	tsteq	r9, #1, 30
 17c:	3b0b3a0e 	blcc	2ce9bc <__bss_end+0x2c4fbc>
 180:	3c0b390b 			; <UNDEFINED> instruction: 0x3c0b390b
 184:	00130119 	andseq	r0, r3, r9, lsl r1
 188:	00050f00 	andeq	r0, r5, r0, lsl #30
 18c:	00001349 	andeq	r1, r0, r9, asr #6
 190:	3f012e10 	svccc	0x00012e10
 194:	3a0e0319 	bcc	380e00 <__bss_end+0x377400>
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
 1c0:	3a080300 	bcc	200dc8 <__bss_end+0x1f73c8>
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
 1f4:	0b0b0024 	bleq	2c028c <__bss_end+0x2b688c>
 1f8:	0e030b3e 	vmoveq.16	d3[0], r0
 1fc:	26030000 	strcs	r0, [r3], -r0
 200:	00134900 	andseq	r4, r3, r0, lsl #18
 204:	00240400 	eoreq	r0, r4, r0, lsl #8
 208:	0b3e0b0b 	bleq	f82e3c <__bss_end+0xf7943c>
 20c:	00000803 	andeq	r0, r0, r3, lsl #16
 210:	03001605 	movweq	r1, #1541	; 0x605
 214:	3b0b3a0e 	blcc	2cea54 <__bss_end+0x2c5054>
 218:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 21c:	06000013 			; <UNDEFINED> instruction: 0x06000013
 220:	0e030113 	mcreq	1, 0, r0, cr3, cr3, {0}
 224:	0b3a0b0b 	bleq	e82e58 <__bss_end+0xe79458>
 228:	0b390b3b 	bleq	e42f1c <__bss_end+0xe3951c>
 22c:	00001301 	andeq	r1, r0, r1, lsl #6
 230:	03000d07 	movweq	r0, #3335	; 0xd07
 234:	3b0b3a08 	blcc	2cea5c <__bss_end+0x2c505c>
 238:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 23c:	000b3813 	andeq	r3, fp, r3, lsl r8
 240:	01040800 	tsteq	r4, r0, lsl #16
 244:	196d0e03 	stmdbne	sp!, {r0, r1, r9, sl, fp}^
 248:	0b0b0b3e 	bleq	2c2f48 <__bss_end+0x2b9548>
 24c:	0b3a1349 	bleq	e84f78 <__bss_end+0xe7b578>
 250:	0b390b3b 	bleq	e42f44 <__bss_end+0xe39544>
 254:	00001301 	andeq	r1, r0, r1, lsl #6
 258:	03002809 	movweq	r2, #2057	; 0x809
 25c:	000b1c0e 	andeq	r1, fp, lr, lsl #24
 260:	00340a00 	eorseq	r0, r4, r0, lsl #20
 264:	0b3a0e03 	bleq	e83a78 <__bss_end+0xe7a078>
 268:	0b390b3b 	bleq	e42f5c <__bss_end+0xe3955c>
 26c:	196c1349 	stmdbne	ip!, {r0, r3, r6, r8, r9, ip}^
 270:	00001802 	andeq	r1, r0, r2, lsl #16
 274:	0300020b 	movweq	r0, #523	; 0x20b
 278:	00193c0e 	andseq	r3, r9, lr, lsl #24
 27c:	01010c00 	tsteq	r1, r0, lsl #24
 280:	13011349 	movwne	r1, #4937	; 0x1349
 284:	210d0000 	mrscs	r0, (UNDEF: 13)
 288:	2f134900 	svccs	0x00134900
 28c:	0e00000b 	cdpeq	0, 0, cr0, cr0, cr11, {0}
 290:	0b0b000f 	bleq	2c02d4 <__bss_end+0x2b68d4>
 294:	00001349 	andeq	r1, r0, r9, asr #6
 298:	0300280f 	movweq	r2, #2063	; 0x80f
 29c:	000b1c08 	andeq	r1, fp, r8, lsl #24
 2a0:	000d1000 	andeq	r1, sp, r0
 2a4:	0b3a0e03 	bleq	e83ab8 <__bss_end+0xe7a0b8>
 2a8:	0b390b3b 	bleq	e42f9c <__bss_end+0xe3959c>
 2ac:	0b381349 	bleq	e04fd8 <__bss_end+0xdfb5d8>
 2b0:	02110000 	andseq	r0, r1, #0
 2b4:	0b0e0301 	bleq	380ec0 <__bss_end+0x3774c0>
 2b8:	3b0b3a0b 	blcc	2ceaec <__bss_end+0x2c50ec>
 2bc:	010b390b 	tsteq	fp, fp, lsl #18
 2c0:	12000013 	andne	r0, r0, #19
 2c4:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 2c8:	0b3a0e03 	bleq	e83adc <__bss_end+0xe7a0dc>
 2cc:	0b390b3b 	bleq	e42fc0 <__bss_end+0xe395c0>
 2d0:	193c0e6e 	ldmdbne	ip!, {r1, r2, r3, r5, r6, r9, sl, fp}
 2d4:	13011364 	movwne	r1, #4964	; 0x1364
 2d8:	05130000 	ldreq	r0, [r3, #-0]
 2dc:	34134900 	ldrcc	r4, [r3], #-2304	; 0xfffff700
 2e0:	14000019 	strne	r0, [r0], #-25	; 0xffffffe7
 2e4:	13490005 	movtne	r0, #36869	; 0x9005
 2e8:	2e150000 	cdpcs	0, 1, cr0, cr5, cr0, {0}
 2ec:	03193f01 	tsteq	r9, #1, 30
 2f0:	3b0b3a0e 	blcc	2ceb30 <__bss_end+0x2c5130>
 2f4:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 2f8:	3c13490e 			; <UNDEFINED> instruction: 0x3c13490e
 2fc:	01136419 	tsteq	r3, r9, lsl r4
 300:	16000013 			; <UNDEFINED> instruction: 0x16000013
 304:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 308:	0b3a0e03 	bleq	e83b1c <__bss_end+0xe7a11c>
 30c:	0b390b3b 	bleq	e43000 <__bss_end+0xe39600>
 310:	13490e6e 	movtne	r0, #40558	; 0x9e6e
 314:	193c0b32 	ldmdbne	ip!, {r1, r4, r5, r8, r9, fp}
 318:	13011364 	movwne	r1, #4964	; 0x1364
 31c:	0d170000 	ldceq	0, cr0, [r7, #-0]
 320:	3a0e0300 	bcc	380f28 <__bss_end+0x377528>
 324:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 328:	3813490b 	ldmdacc	r3, {r0, r1, r3, r8, fp, lr}
 32c:	000b320b 	andeq	r3, fp, fp, lsl #4
 330:	012e1800 			; <UNDEFINED> instruction: 0x012e1800
 334:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 338:	0b3b0b3a 	bleq	ec3028 <__bss_end+0xeb9628>
 33c:	0e6e0b39 	vmoveq.8	d14[5], r0
 340:	193c0b32 	ldmdbne	ip!, {r1, r4, r5, r8, r9, fp}
 344:	13011364 	movwne	r1, #4964	; 0x1364
 348:	2e190000 	cdpcs	0, 1, cr0, cr9, cr0, {0}
 34c:	03193f01 	tsteq	r9, #1, 30
 350:	3b0b3a0e 	blcc	2ceb90 <__bss_end+0x2c5190>
 354:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 358:	3213490e 	andscc	r4, r3, #229376	; 0x38000
 35c:	64193c0b 	ldrvs	r3, [r9], #-3083	; 0xfffff3f5
 360:	1a000013 	bne	3b4 <shift+0x3b4>
 364:	13490115 	movtne	r0, #37141	; 0x9115
 368:	13011364 	movwne	r1, #4964	; 0x1364
 36c:	1f1b0000 	svcne	0x001b0000
 370:	49131d00 	ldmdbmi	r3, {r8, sl, fp, ip}
 374:	1c000013 	stcne	0, cr0, [r0], {19}
 378:	0b0b0010 	bleq	2c03c0 <__bss_end+0x2b69c0>
 37c:	00001349 	andeq	r1, r0, r9, asr #6
 380:	0b000f1d 	bleq	3ffc <shift+0x3ffc>
 384:	1e00000b 	cdpne	0, 0, cr0, cr0, cr11, {0}
 388:	08030139 	stmdaeq	r3, {r0, r3, r4, r5, r8}
 38c:	0b3b0b3a 	bleq	ec307c <__bss_end+0xeb967c>
 390:	13010b39 	movwne	r0, #6969	; 0x1b39
 394:	341f0000 	ldrcc	r0, [pc], #-0	; 39c <shift+0x39c>
 398:	3a0e0300 	bcc	380fa0 <__bss_end+0x3775a0>
 39c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 3a0:	3c13490b 			; <UNDEFINED> instruction: 0x3c13490b
 3a4:	6c061c19 	stcvs	12, cr1, [r6], {25}
 3a8:	20000019 	andcs	r0, r0, r9, lsl r0
 3ac:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 3b0:	0b3b0b3a 	bleq	ec30a0 <__bss_end+0xeb96a0>
 3b4:	13490b39 	movtne	r0, #39737	; 0x9b39
 3b8:	0b1c193c 	bleq	7068b0 <__bss_end+0x6fceb0>
 3bc:	0000196c 	andeq	r1, r0, ip, ror #18
 3c0:	47003421 	strmi	r3, [r0, -r1, lsr #8]
 3c4:	22000013 	andcs	r0, r0, #19
 3c8:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 3cc:	0b3b0b3a 	bleq	ec30bc <__bss_end+0xeb96bc>
 3d0:	13490b39 	movtne	r0, #39737	; 0x9b39
 3d4:	1802193f 	stmdane	r2, {r0, r1, r2, r3, r4, r5, r8, fp, ip}
 3d8:	2e230000 	cdpcs	0, 2, cr0, cr3, cr0, {0}
 3dc:	03193f01 	tsteq	r9, #1, 30
 3e0:	3b0b3a0e 	blcc	2cec20 <__bss_end+0x2c5220>
 3e4:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 3e8:	12011113 	andne	r1, r1, #-1073741820	; 0xc0000004
 3ec:	96184006 	ldrls	r4, [r8], -r6
 3f0:	13011942 	movwne	r1, #6466	; 0x1942
 3f4:	05240000 	streq	r0, [r4, #-0]!
 3f8:	3a0e0300 	bcc	381000 <__bss_end+0x377600>
 3fc:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 400:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 404:	25000018 	strcs	r0, [r0, #-24]	; 0xffffffe8
 408:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 40c:	0b3b0b3a 	bleq	ec30fc <__bss_end+0xeb96fc>
 410:	13490b39 	movtne	r0, #39737	; 0x9b39
 414:	00001802 	andeq	r1, r0, r2, lsl #16
 418:	03003426 	movweq	r3, #1062	; 0x426
 41c:	3b0b3a08 	blcc	2cec44 <__bss_end+0x2c5244>
 420:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 424:	00180213 	andseq	r0, r8, r3, lsl r2
 428:	00342700 	eorseq	r2, r4, r0, lsl #14
 42c:	0b3a0e03 	bleq	e83c40 <__bss_end+0xe7a240>
 430:	0b390b3b 	bleq	e43124 <__bss_end+0xe39724>
 434:	00001349 	andeq	r1, r0, r9, asr #6
 438:	3f012e28 	svccc	0x00012e28
 43c:	3a0e0319 	bcc	3810a8 <__bss_end+0x3776a8>
 440:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 444:	110e6e0b 	tstne	lr, fp, lsl #28
 448:	40061201 	andmi	r1, r6, r1, lsl #4
 44c:	19429618 	stmdbne	r2, {r3, r4, r9, sl, ip, pc}^
 450:	00001301 	andeq	r1, r0, r1, lsl #6
 454:	3f012e29 	svccc	0x00012e29
 458:	3a0e0319 	bcc	3810c4 <__bss_end+0x3776c4>
 45c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 460:	490e6e0b 	stmdbmi	lr, {r0, r1, r3, r9, sl, fp, sp, lr}
 464:	12011113 	andne	r1, r1, #-1073741820	; 0xc0000004
 468:	96184006 	ldrls	r4, [r8], -r6
 46c:	13011942 	movwne	r1, #6466	; 0x1942
 470:	2e2a0000 	cdpcs	0, 2, cr0, cr10, cr0, {0}
 474:	03193f01 	tsteq	r9, #1, 30
 478:	3b0b3a08 	blcc	2ceca0 <__bss_end+0x2c52a0>
 47c:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 480:	1201110e 	andne	r1, r1, #-2147483645	; 0x80000003
 484:	96184006 	ldrls	r4, [r8], -r6
 488:	13011942 	movwne	r1, #6466	; 0x1942
 48c:	052b0000 	streq	r0, [fp, #-0]!
 490:	3a080300 	bcc	201098 <__bss_end+0x1f7698>
 494:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 498:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 49c:	2c000018 	stccs	0, cr0, [r0], {24}
 4a0:	13490021 	movtne	r0, #36897	; 0x9021
 4a4:	0000182f 	andeq	r1, r0, pc, lsr #16
 4a8:	3f012e2d 	svccc	0x00012e2d
 4ac:	3a0e0319 	bcc	381118 <__bss_end+0x377718>
 4b0:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 4b4:	110e6e0b 	tstne	lr, fp, lsl #28
 4b8:	40061201 	andmi	r1, r6, r1, lsl #4
 4bc:	19429618 	stmdbne	r2, {r3, r4, r9, sl, ip, pc}^
 4c0:	01000000 	mrseq	r0, (UNDEF: 0)
 4c4:	0e250111 	mcreq	1, 1, r0, cr5, cr1, {0}
 4c8:	0e030b13 	vmoveq.32	d3[0], r0
 4cc:	01110e1b 	tsteq	r1, fp, lsl lr
 4d0:	17100612 			; <UNDEFINED> instruction: 0x17100612
 4d4:	24020000 	strcs	r0, [r2], #-0
 4d8:	3e0b0b00 	vmlacc.f64	d0, d11, d0
 4dc:	000e030b 	andeq	r0, lr, fp, lsl #6
 4e0:	00260300 	eoreq	r0, r6, r0, lsl #6
 4e4:	00001349 	andeq	r1, r0, r9, asr #6
 4e8:	0b002404 	bleq	9500 <_Z6memcpyPKvPvi+0x4c>
 4ec:	030b3e0b 	movweq	r3, #48651	; 0xbe0b
 4f0:	05000008 	streq	r0, [r0, #-8]
 4f4:	0e030016 	mcreq	0, 0, r0, cr3, cr6, {0}
 4f8:	0b3b0b3a 	bleq	ec31e8 <__bss_end+0xeb97e8>
 4fc:	13490b39 	movtne	r0, #39737	; 0x9b39
 500:	13060000 	movwne	r0, #24576	; 0x6000
 504:	0b0e0301 	bleq	381110 <__bss_end+0x377710>
 508:	3b0b3a0b 	blcc	2ced3c <__bss_end+0x2c533c>
 50c:	010b390b 	tsteq	fp, fp, lsl #18
 510:	07000013 	smladeq	r0, r3, r0, r0
 514:	0803000d 	stmdaeq	r3, {r0, r2, r3}
 518:	0b3b0b3a 	bleq	ec3208 <__bss_end+0xeb9808>
 51c:	13490b39 	movtne	r0, #39737	; 0x9b39
 520:	00000b38 	andeq	r0, r0, r8, lsr fp
 524:	03010408 	movweq	r0, #5128	; 0x1408
 528:	3e196d0e 	cdpcc	13, 1, cr6, cr9, cr14, {0}
 52c:	490b0b0b 	stmdbmi	fp, {r0, r1, r3, r8, r9, fp}
 530:	3b0b3a13 	blcc	2ced84 <__bss_end+0x2c5384>
 534:	010b390b 	tsteq	fp, fp, lsl #18
 538:	09000013 	stmdbeq	r0, {r0, r1, r4}
 53c:	08030028 	stmdaeq	r3, {r3, r5}
 540:	00000b1c 	andeq	r0, r0, ip, lsl fp
 544:	0300280a 	movweq	r2, #2058	; 0x80a
 548:	000b1c0e 	andeq	r1, fp, lr, lsl #24
 54c:	00340b00 	eorseq	r0, r4, r0, lsl #22
 550:	0b3a0e03 	bleq	e83d64 <__bss_end+0xe7a364>
 554:	0b390b3b 	bleq	e43248 <__bss_end+0xe39848>
 558:	196c1349 	stmdbne	ip!, {r0, r3, r6, r8, r9, ip}^
 55c:	00001802 	andeq	r1, r0, r2, lsl #16
 560:	0300020c 	movweq	r0, #524	; 0x20c
 564:	00193c0e 	andseq	r3, r9, lr, lsl #24
 568:	000f0d00 	andeq	r0, pc, r0, lsl #26
 56c:	13490b0b 	movtne	r0, #39691	; 0x9b0b
 570:	0d0e0000 	stceq	0, cr0, [lr, #-0]
 574:	3a0e0300 	bcc	38117c <__bss_end+0x37777c>
 578:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 57c:	3813490b 	ldmdacc	r3, {r0, r1, r3, r8, fp, lr}
 580:	0f00000b 	svceq	0x0000000b
 584:	13490101 	movtne	r0, #37121	; 0x9101
 588:	00001301 	andeq	r1, r0, r1, lsl #6
 58c:	49002110 	stmdbmi	r0, {r4, r8, sp}
 590:	000b2f13 	andeq	r2, fp, r3, lsl pc
 594:	01021100 	mrseq	r1, (UNDEF: 18)
 598:	0b0b0e03 	bleq	2c3dac <__bss_end+0x2ba3ac>
 59c:	0b3b0b3a 	bleq	ec328c <__bss_end+0xeb988c>
 5a0:	13010b39 	movwne	r0, #6969	; 0x1b39
 5a4:	2e120000 	cdpcs	0, 1, cr0, cr2, cr0, {0}
 5a8:	03193f01 	tsteq	r9, #1, 30
 5ac:	3b0b3a0e 	blcc	2cedec <__bss_end+0x2c53ec>
 5b0:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 5b4:	64193c0e 	ldrvs	r3, [r9], #-3086	; 0xfffff3f2
 5b8:	00130113 	andseq	r0, r3, r3, lsl r1
 5bc:	00051300 	andeq	r1, r5, r0, lsl #6
 5c0:	19341349 	ldmdbne	r4!, {r0, r3, r6, r8, r9, ip}
 5c4:	05140000 	ldreq	r0, [r4, #-0]
 5c8:	00134900 	andseq	r4, r3, r0, lsl #18
 5cc:	012e1500 			; <UNDEFINED> instruction: 0x012e1500
 5d0:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 5d4:	0b3b0b3a 	bleq	ec32c4 <__bss_end+0xeb98c4>
 5d8:	0e6e0b39 	vmoveq.8	d14[5], r0
 5dc:	193c1349 	ldmdbne	ip!, {r0, r3, r6, r8, r9, ip}
 5e0:	13011364 	movwne	r1, #4964	; 0x1364
 5e4:	2e160000 	cdpcs	0, 1, cr0, cr6, cr0, {0}
 5e8:	03193f01 	tsteq	r9, #1, 30
 5ec:	3b0b3a0e 	blcc	2cee2c <__bss_end+0x2c542c>
 5f0:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 5f4:	3213490e 	andscc	r4, r3, #229376	; 0x38000
 5f8:	64193c0b 	ldrvs	r3, [r9], #-3083	; 0xfffff3f5
 5fc:	00130113 	andseq	r0, r3, r3, lsl r1
 600:	000d1700 	andeq	r1, sp, r0, lsl #14
 604:	0b3a0e03 	bleq	e83e18 <__bss_end+0xe7a418>
 608:	0b390b3b 	bleq	e432fc <__bss_end+0xe398fc>
 60c:	0b381349 	bleq	e05338 <__bss_end+0xdfb938>
 610:	00000b32 	andeq	r0, r0, r2, lsr fp
 614:	3f012e18 	svccc	0x00012e18
 618:	3a0e0319 	bcc	381284 <__bss_end+0x377884>
 61c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 620:	320e6e0b 	andcc	r6, lr, #11, 28	; 0xb0
 624:	64193c0b 	ldrvs	r3, [r9], #-3083	; 0xfffff3f5
 628:	00130113 	andseq	r0, r3, r3, lsl r1
 62c:	012e1900 			; <UNDEFINED> instruction: 0x012e1900
 630:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 634:	0b3b0b3a 	bleq	ec3324 <__bss_end+0xeb9924>
 638:	0e6e0b39 	vmoveq.8	d14[5], r0
 63c:	0b321349 	bleq	c85368 <__bss_end+0xc7b968>
 640:	1364193c 	cmnne	r4, #60, 18	; 0xf0000
 644:	151a0000 	ldrne	r0, [sl, #-0]
 648:	64134901 	ldrvs	r4, [r3], #-2305	; 0xfffff6ff
 64c:	00130113 	andseq	r0, r3, r3, lsl r1
 650:	001f1b00 	andseq	r1, pc, r0, lsl #22
 654:	1349131d 	movtne	r1, #37661	; 0x931d
 658:	101c0000 	andsne	r0, ip, r0
 65c:	490b0b00 	stmdbmi	fp, {r8, r9, fp}
 660:	1d000013 	stcne	0, cr0, [r0, #-76]	; 0xffffffb4
 664:	0b0b000f 	bleq	2c06a8 <__bss_end+0x2b6ca8>
 668:	341e0000 	ldrcc	r0, [lr], #-0
 66c:	3a0e0300 	bcc	381274 <__bss_end+0x377874>
 670:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 674:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 678:	1f000018 	svcne	0x00000018
 67c:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 680:	0b3a0e03 	bleq	e83e94 <__bss_end+0xe7a494>
 684:	0b390b3b 	bleq	e43378 <__bss_end+0xe39978>
 688:	13490e6e 	movtne	r0, #40558	; 0x9e6e
 68c:	06120111 			; <UNDEFINED> instruction: 0x06120111
 690:	42961840 	addsmi	r1, r6, #64, 16	; 0x400000
 694:	00130119 	andseq	r0, r3, r9, lsl r1
 698:	00052000 	andeq	r2, r5, r0
 69c:	0b3a0e03 	bleq	e83eb0 <__bss_end+0xe7a4b0>
 6a0:	0b390b3b 	bleq	e43394 <__bss_end+0xe39994>
 6a4:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 6a8:	2e210000 	cdpcs	0, 2, cr0, cr1, cr0, {0}
 6ac:	03193f01 	tsteq	r9, #1, 30
 6b0:	3b0b3a0e 	blcc	2ceef0 <__bss_end+0x2c54f0>
 6b4:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 6b8:	1113490e 	tstne	r3, lr, lsl #18
 6bc:	40061201 	andmi	r1, r6, r1, lsl #4
 6c0:	19429718 	stmdbne	r2, {r3, r4, r8, r9, sl, ip, pc}^
 6c4:	00001301 	andeq	r1, r0, r1, lsl #6
 6c8:	03003422 	movweq	r3, #1058	; 0x422
 6cc:	3b0b3a08 	blcc	2ceef4 <__bss_end+0x2c54f4>
 6d0:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 6d4:	00180213 	andseq	r0, r8, r3, lsl r2
 6d8:	012e2300 			; <UNDEFINED> instruction: 0x012e2300
 6dc:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 6e0:	0b3b0b3a 	bleq	ec33d0 <__bss_end+0xeb99d0>
 6e4:	0e6e0b39 	vmoveq.8	d14[5], r0
 6e8:	06120111 			; <UNDEFINED> instruction: 0x06120111
 6ec:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
 6f0:	00130119 	andseq	r0, r3, r9, lsl r1
 6f4:	002e2400 	eoreq	r2, lr, r0, lsl #8
 6f8:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 6fc:	0b3b0b3a 	bleq	ec33ec <__bss_end+0xeb99ec>
 700:	0e6e0b39 	vmoveq.8	d14[5], r0
 704:	06120111 			; <UNDEFINED> instruction: 0x06120111
 708:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
 70c:	25000019 	strcs	r0, [r0, #-25]	; 0xffffffe7
 710:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 714:	0b3a0e03 	bleq	e83f28 <__bss_end+0xe7a528>
 718:	0b390b3b 	bleq	e4340c <__bss_end+0xe39a0c>
 71c:	13490e6e 	movtne	r0, #40558	; 0x9e6e
 720:	06120111 			; <UNDEFINED> instruction: 0x06120111
 724:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
 728:	00000019 	andeq	r0, r0, r9, lsl r0
 72c:	25011101 	strcs	r1, [r1, #-257]	; 0xfffffeff
 730:	030b130e 	movweq	r1, #45838	; 0xb30e
 734:	110e1b0e 	tstne	lr, lr, lsl #22
 738:	10061201 	andne	r1, r6, r1, lsl #4
 73c:	02000017 	andeq	r0, r0, #23
 740:	13010139 	movwne	r0, #4409	; 0x1139
 744:	34030000 	strcc	r0, [r3], #-0
 748:	3a0e0300 	bcc	381350 <__bss_end+0x377950>
 74c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 750:	3c13490b 			; <UNDEFINED> instruction: 0x3c13490b
 754:	000a1c19 	andeq	r1, sl, r9, lsl ip
 758:	003a0400 	eorseq	r0, sl, r0, lsl #8
 75c:	0b3b0b3a 	bleq	ec344c <__bss_end+0xeb9a4c>
 760:	13180b39 	tstne	r8, #58368	; 0xe400
 764:	01050000 	mrseq	r0, (UNDEF: 5)
 768:	01134901 	tsteq	r3, r1, lsl #18
 76c:	06000013 			; <UNDEFINED> instruction: 0x06000013
 770:	13490021 	movtne	r0, #36897	; 0x9021
 774:	00000b2f 	andeq	r0, r0, pc, lsr #22
 778:	49002607 	stmdbmi	r0, {r0, r1, r2, r9, sl, sp}
 77c:	08000013 	stmdaeq	r0, {r0, r1, r4}
 780:	0b0b0024 	bleq	2c0818 <__bss_end+0x2b6e18>
 784:	0e030b3e 	vmoveq.16	d3[0], r0
 788:	34090000 	strcc	r0, [r9], #-0
 78c:	00134700 	andseq	r4, r3, r0, lsl #14
 790:	012e0a00 			; <UNDEFINED> instruction: 0x012e0a00
 794:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 798:	0b3b0b3a 	bleq	ec3488 <__bss_end+0xeb9a88>
 79c:	0e6e0b39 	vmoveq.8	d14[5], r0
 7a0:	06120111 			; <UNDEFINED> instruction: 0x06120111
 7a4:	42961840 	addsmi	r1, r6, #64, 16	; 0x400000
 7a8:	00130119 	andseq	r0, r3, r9, lsl r1
 7ac:	00050b00 	andeq	r0, r5, r0, lsl #22
 7b0:	0b3a0e03 	bleq	e83fc4 <__bss_end+0xe7a5c4>
 7b4:	0b390b3b 	bleq	e434a8 <__bss_end+0xe39aa8>
 7b8:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 7bc:	050c0000 	streq	r0, [ip, #-0]
 7c0:	3a080300 	bcc	2013c8 <__bss_end+0x1f79c8>
 7c4:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 7c8:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 7cc:	0d000018 	stceq	0, cr0, [r0, #-96]	; 0xffffffa0
 7d0:	08030034 	stmdaeq	r3, {r2, r4, r5}
 7d4:	0b3b0b3a 	bleq	ec34c4 <__bss_end+0xeb9ac4>
 7d8:	13490b39 	movtne	r0, #39737	; 0x9b39
 7dc:	00001802 	andeq	r1, r0, r2, lsl #16
 7e0:	0b000f0e 	bleq	4420 <shift+0x4420>
 7e4:	0013490b 	andseq	r4, r3, fp, lsl #18
 7e8:	00240f00 	eoreq	r0, r4, r0, lsl #30
 7ec:	0b3e0b0b 	bleq	f83420 <__bss_end+0xf79a20>
 7f0:	00000803 	andeq	r0, r0, r3, lsl #16
 7f4:	3f012e10 	svccc	0x00012e10
 7f8:	3a0e0319 	bcc	381464 <__bss_end+0x377a64>
 7fc:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 800:	110e6e0b 	tstne	lr, fp, lsl #28
 804:	40061201 	andmi	r1, r6, r1, lsl #4
 808:	19429718 	stmdbne	r2, {r3, r4, r8, r9, sl, ip, pc}^
 80c:	00001301 	andeq	r1, r0, r1, lsl #6
 810:	03003411 	movweq	r3, #1041	; 0x411
 814:	3b0b3a0e 	blcc	2cf054 <__bss_end+0x2c5654>
 818:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 81c:	00180213 	andseq	r0, r8, r3, lsl r2
 820:	010b1200 	mrseq	r1, R11_fiq
 824:	06120111 			; <UNDEFINED> instruction: 0x06120111
 828:	26130000 	ldrcs	r0, [r3], -r0
 82c:	14000000 	strne	r0, [r0], #-0
 830:	0b0b000f 	bleq	2c0874 <__bss_end+0x2b6e74>
 834:	2e150000 	cdpcs	0, 1, cr0, cr5, cr0, {0}
 838:	03193f01 	tsteq	r9, #1, 30
 83c:	3b0b3a0e 	blcc	2cf07c <__bss_end+0x2c567c>
 840:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 844:	1113490e 	tstne	r3, lr, lsl #18
 848:	40061201 	andmi	r1, r6, r1, lsl #4
 84c:	19429718 	stmdbne	r2, {r3, r4, r8, r9, sl, ip, pc}^
 850:	00001301 	andeq	r1, r0, r1, lsl #6
 854:	11010b16 	tstne	r1, r6, lsl fp
 858:	01061201 	tsteq	r6, r1, lsl #4
 85c:	17000013 	smladne	r0, r3, r0, r0
 860:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 864:	0b3a0e03 	bleq	e84078 <__bss_end+0xe7a678>
 868:	0b390b3b 	bleq	e4355c <__bss_end+0xe39b5c>
 86c:	01110e6e 	tsteq	r1, lr, ror #28
 870:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 874:	00194296 	mulseq	r9, r6, r2
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
  74:	00000760 	andeq	r0, r0, r0, ror #14
	...
  80:	0000001c 	andeq	r0, r0, ip, lsl r0
  84:	0e370002 	cdpeq	0, 3, cr0, cr7, cr2, {0}
  88:	00040000 	andeq	r0, r4, r0
  8c:	00000000 	andeq	r0, r0, r0
  90:	0000898c 	andeq	r8, r0, ip, lsl #19
  94:	0000045c 	andeq	r0, r0, ip, asr r4
	...
  a0:	0000001c 	andeq	r0, r0, ip, lsl r0
  a4:	195a0002 	ldmdbne	sl, {r1}^
  a8:	00040000 	andeq	r0, r4, r0
  ac:	00000000 	andeq	r0, r0, r0
  b0:	00008de8 	andeq	r8, r0, r8, ror #27
  b4:	000007c0 	andeq	r0, r0, r0, asr #15
	...

Disassembly of section .debug_str:

00000000 <.debug_str>:
       0:	6573552f 	ldrbvs	r5, [r3, #-1327]!	; 0xfffffad1
       4:	772f7372 			; <UNDEFINED> instruction: 0x772f7372
       8:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
       c:	2f696a72 	svccs	0x00696a72
      10:	6b736544 	blvs	1cd9528 <__bss_end+0x1ccfb28>
      14:	2f706f74 	svccs	0x00706f74
      18:	2f564146 	svccs	0x00564146
      1c:	6176614e 	cmnvs	r6, lr, asr #2
      20:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
      24:	4f2f6963 	svcmi	0x002f6963
      28:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
      2c:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
      30:	6b6c6172 	blvs	1b18600 <__bss_end+0x1b0ec00>
      34:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
      38:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
      3c:	756f732f 	strbvc	r7, [pc, #-815]!	; fffffd15 <__bss_end+0xffff6315>
      40:	73656372 	cmnvc	r5, #-939524095	; 0xc8000001
      44:	6573752f 	ldrbvs	r7, [r3, #-1327]!	; 0xfffffad1
      48:	61707372 	cmnvs	r0, r2, ror r3
      4c:	632f6563 			; <UNDEFINED> instruction: 0x632f6563
      50:	2e307472 	mrccs	4, 1, r7, cr0, cr2, {3}
      54:	552f0073 	strpl	r0, [pc, #-115]!	; ffffffe9 <__bss_end+0xffff65e9>
      58:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
      5c:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
      60:	6a726574 	bvs	1c99638 <__bss_end+0x1c8fc38>
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
      98:	752f7365 	strvc	r7, [pc, #-869]!	; fffffd3b <__bss_end+0xffff633b>
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
     12c:	6a363731 	bvs	d8ddf8 <__bss_end+0xd843f8>
     130:	732d667a 			; <UNDEFINED> instruction: 0x732d667a
     134:	616d2d20 	cmnvs	sp, r0, lsr #26
     138:	2d206d72 	stccs	13, cr6, [r0, #-456]!	; 0xfffffe38
     13c:	6372616d 	cmnvs	r2, #1073741851	; 0x4000001b
     140:	72613d68 	rsbvc	r3, r1, #104, 26	; 0x1a00
     144:	7a36766d 	bvc	d9db00 <__bss_end+0xd94100>
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
     184:	6a757a61 	bvs	1d5eb10 <__bss_end+0x1d55110>
     188:	2f696369 	svccs	0x00696369
     18c:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
     190:	73656d65 	cmnvc	r5, #6464	; 0x1940
     194:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
     198:	6b2d616b 	blvs	b5874c <__bss_end+0xb4ed4c>
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
     1e4:	2b2b4320 	blcs	ad0e6c <__bss_end+0xac746c>
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
     260:	2b6b7a36 	blcs	1adeb40 <__bss_end+0x1ad5140>
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
     294:	755f6962 	ldrbvc	r6, [pc, #-2402]	; fffff93a <__bss_end+0xffff5f3a>
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
     324:	6b736544 	blvs	1cd983c <__bss_end+0x1ccfe3c>
     328:	2f706f74 	svccs	0x00706f74
     32c:	2f564146 	svccs	0x00564146
     330:	6176614e 	cmnvs	r6, lr, asr #2
     334:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
     338:	4f2f6963 	svcmi	0x002f6963
     33c:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
     340:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
     344:	6b6c6172 	blvs	1b18914 <__bss_end+0x1b0ef14>
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
     470:	65720074 	ldrbvs	r0, [r2, #-116]!	; 0xffffff8c
     474:	76696563 	strbtvc	r6, [r9], -r3, ror #10
     478:	61645f65 	cmnvs	r4, r5, ror #30
     47c:	70006174 	andvc	r6, r0, r4, ror r1
     480:	6d617261 	sfmvs	f7, 2, [r1, #-388]!	; 0xfffffe7c
     484:	78650073 	stmdavc	r5!, {r0, r1, r4, r5, r6}^
     488:	635f7469 	cmpvs	pc, #1761607680	; 0x69000000
     48c:	0065646f 	rsbeq	r6, r5, pc, ror #8
     490:	6568746f 	strbvs	r7, [r8, #-1135]!	; 0xfffffb91
     494:	6f725f72 	svcvs	0x00725f72
     498:	625f656c 	subsvs	r6, pc, #108, 10	; 0x1b000000
     49c:	00666675 	rsbeq	r6, r6, r5, ror r6
     4a0:	646e6148 	strbtvs	r6, [lr], #-328	; 0xfffffeb8
     4a4:	505f656c 	subspl	r6, pc, ip, ror #10
     4a8:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     4ac:	535f7373 	cmppl	pc, #-872415231	; 0xcc000001
     4b0:	47004957 	smlsdmi	r0, r7, r9, r4
     4b4:	535f7465 	cmppl	pc, #1694498816	; 0x65000000
     4b8:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     4bc:	72656c75 	rsbvc	r6, r5, #29952	; 0x7500
     4c0:	666e495f 			; <UNDEFINED> instruction: 0x666e495f
     4c4:	614d006f 	cmpvs	sp, pc, rrx
     4c8:	69465f70 	stmdbvs	r6, {r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     4cc:	545f656c 	ldrbpl	r6, [pc], #-1388	; 4d4 <shift+0x4d4>
     4d0:	75435f6f 	strbvc	r5, [r3, #-3951]	; 0xfffff091
     4d4:	6e657272 	mcrvs	2, 3, r7, cr5, cr2, {3}
     4d8:	49540074 	ldmdbmi	r4, {r2, r4, r5, r6}^
     4dc:	495f4332 	ldmdbmi	pc, {r1, r4, r5, r8, r9, lr}^	; <UNPREDICTABLE>
     4e0:	6c74434f 	ldclvs	3, cr4, [r4], #-316	; 0xfffffec4
     4e4:	7261505f 	rsbvc	r5, r1, #95	; 0x5f
     4e8:	00736d61 	rsbseq	r6, r3, r1, ror #26
     4ec:	76616c73 			; <UNDEFINED> instruction: 0x76616c73
     4f0:	6e695f65 	cdpvs	15, 6, cr5, cr9, cr5, {3}
     4f4:	00747570 	rsbseq	r7, r4, r0, ror r5
     4f8:	626d6f5a 	rsbvs	r6, sp, #360	; 0x168
     4fc:	6c006569 	cfstr32vs	mvfx6, [r0], {105}	; 0x69
     500:	665f676f 	ldrbvs	r6, [pc], -pc, ror #14
     504:	656e0064 	strbvs	r0, [lr, #-100]!	; 0xffffff9c
     508:	52007478 	andpl	r7, r0, #120, 8	; 0x78000000
     50c:	616e6e75 	smcvs	59109	; 0xe6e5
     510:	00656c62 	rsbeq	r6, r5, r2, ror #24
     514:	61766e49 	cmnvs	r6, r9, asr #28
     518:	5f64696c 	svcpl	0x0064696c
     51c:	646e6148 	strbtvs	r6, [lr], #-328	; 0xfffffeb8
     520:	5200656c 	andpl	r6, r0, #108, 10	; 0x1b000000
     524:	696e6e75 	stmdbvs	lr!, {r0, r2, r4, r5, r6, r9, sl, fp, sp, lr}^
     528:	4400676e 	strmi	r6, [r0], #-1902	; 0xfffff892
     52c:	6c646165 	stfvse	f6, [r4], #-404	; 0xfffffe6c
     530:	5f656e69 	svcpl	0x00656e69
     534:	68636e55 	stmdavs	r3!, {r0, r2, r4, r6, r9, sl, fp, sp, lr}^
     538:	65676e61 	strbvs	r6, [r7, #-3681]!	; 0xfffff19f
     53c:	65470064 	strbvs	r0, [r7, #-100]	; 0xffffff9c
     540:	75435f74 	strbvc	r5, [r3, #-3956]	; 0xfffff08c
     544:	6e657272 	mcrvs	2, 3, r7, cr5, cr2, {3}
     548:	72505f74 	subsvc	r5, r0, #116, 30	; 0x1d0
     54c:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     550:	50470073 	subpl	r0, r7, r3, ror r0
     554:	425f4f49 	subsmi	r4, pc, #292	; 0x124
     558:	00657361 	rsbeq	r7, r5, r1, ror #6
     55c:	314e5a5f 	cmpcc	lr, pc, asr sl
     560:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     564:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     568:	614d5f73 	hvcvs	54771	; 0xd5f3
     56c:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     570:	43343172 	teqmi	r4, #-2147483620	; 0x8000001c
     574:	74616572 	strbtvc	r6, [r1], #-1394	; 0xfffffa8e
     578:	72505f65 	subsvc	r5, r0, #404	; 0x194
     57c:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     580:	68504573 	ldmdavs	r0, {r0, r1, r4, r5, r6, r8, sl, lr}^
     584:	5300626a 	movwpl	r6, #618	; 0x26a
     588:	505f7465 	subspl	r7, pc, r5, ror #8
     58c:	6d617261 	sfmvs	f7, 2, [r1, #-388]!	; 0xfffffe7c
     590:	32490073 	subcc	r0, r9, #115	; 0x73
     594:	72545f43 	subsvc	r5, r4, #268	; 0x10c
     598:	61736e61 	cmnvs	r3, r1, ror #28
     59c:	6f697463 	svcvs	0x00697463
     5a0:	614d5f6e 	cmpvs	sp, lr, ror #30
     5a4:	69535f78 	ldmdbvs	r3, {r3, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     5a8:	7000657a 	andvc	r6, r0, sl, ror r5
     5ac:	00766572 	rsbseq	r6, r6, r2, ror r5
     5b0:	4b4e5a5f 	blmi	1396f34 <__bss_end+0x138d534>
     5b4:	50433631 	subpl	r3, r3, r1, lsr r6
     5b8:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     5bc:	4d5f7373 	ldclmi	3, cr7, [pc, #-460]	; 3f8 <shift+0x3f8>
     5c0:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
     5c4:	39317265 	ldmdbcc	r1!, {r0, r2, r5, r6, r9, ip, sp, lr}
     5c8:	5f746547 	svcpl	0x00746547
     5cc:	72727543 	rsbsvc	r7, r2, #281018368	; 0x10c00000
     5d0:	5f746e65 	svcpl	0x00746e65
     5d4:	636f7250 	cmnvs	pc, #80, 4
     5d8:	45737365 	ldrbmi	r7, [r3, #-869]!	; 0xfffffc9b
     5dc:	65520076 	ldrbvs	r0, [r2, #-118]	; 0xffffff8a
     5e0:	4f5f6461 	svcmi	0x005f6461
     5e4:	00796c6e 	rsbseq	r6, r9, lr, ror #24
     5e8:	756c6176 	strbvc	r6, [ip, #-374]!	; 0xfffffe8a
     5ec:	74735f65 	ldrbtvc	r5, [r3], #-3941	; 0xfffff09b
     5f0:	614d0072 	hvcvs	53250	; 0xd002
     5f4:	72505f78 	subsvc	r5, r0, #120, 30	; 0x1e0
     5f8:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     5fc:	704f5f73 	subvc	r5, pc, r3, ror pc	; <UNPREDICTABLE>
     600:	64656e65 	strbtvs	r6, [r5], #-3685	; 0xfffff19b
     604:	6c69465f 	stclvs	6, cr4, [r9], #-380	; 0xfffffe84
     608:	54007365 	strpl	r7, [r0], #-869	; 0xfffffc9b
     60c:	5f555043 	svcpl	0x00555043
     610:	746e6f43 	strbtvc	r6, [lr], #-3907	; 0xfffff0bd
     614:	00747865 	rsbseq	r7, r4, r5, ror #16
     618:	314e5a5f 	cmpcc	lr, pc, asr sl
     61c:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     620:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     624:	614d5f73 	hvcvs	54771	; 0xd5f3
     628:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     62c:	63533872 	cmpvs	r3, #7471104	; 0x720000
     630:	75646568 	strbvc	r6, [r4, #-1384]!	; 0xfffffa98
     634:	7645656c 	strbvc	r6, [r5], -ip, ror #10
     638:	746f4e00 	strbtvc	r4, [pc], #-3584	; 640 <shift+0x640>
     63c:	41796669 	cmnmi	r9, r9, ror #12
     640:	42006c6c 	andmi	r6, r0, #108, 24	; 0x6c00
     644:	6b636f6c 	blvs	18dc3fc <__bss_end+0x18d29fc>
     648:	7275435f 	rsbsvc	r4, r5, #2080374785	; 0x7c000001
     64c:	746e6572 	strbtvc	r6, [lr], #-1394	; 0xfffffa8e
     650:	6f72505f 	svcvs	0x0072505f
     654:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     658:	74654700 	strbtvc	r4, [r5], #-1792	; 0xfffff900
     65c:	4449505f 	strbmi	r5, [r9], #-95	; 0xffffffa1
     660:	6e697500 	cdpvs	5, 6, cr7, cr9, cr0, {0}
     664:	5f323374 	svcpl	0x00323374
     668:	494e0074 	stmdbmi	lr, {r2, r4, r5, r6}^
     66c:	6c74434f 	ldclvs	3, cr4, [r4], #-316	; 0xfffffec4
     670:	65704f5f 	ldrbvs	r4, [r0, #-3935]!	; 0xfffff0a1
     674:	69746172 	ldmdbvs	r4!, {r1, r4, r5, r6, r8, sp, lr}^
     678:	66006e6f 	strvs	r6, [r0], -pc, ror #28
     67c:	74616f6c 	strbtvc	r6, [r1], #-3948	; 0xfffff094
     680:	43534200 	cmpmi	r3, #0, 4
     684:	61425f31 	cmpvs	r2, r1, lsr pc
     688:	57006573 	smlsdxpl	r0, r3, r5, r6
     68c:	00746961 	rsbseq	r6, r4, r1, ror #18
     690:	7361544e 	cmnvc	r1, #1308622848	; 0x4e000000
     694:	74535f6b 	ldrbvc	r5, [r3], #-3947	; 0xfffff095
     698:	00657461 	rsbeq	r7, r5, r1, ror #8
     69c:	65686353 	strbvs	r6, [r8, #-851]!	; 0xfffffcad
     6a0:	656c7564 	strbvs	r7, [ip, #-1380]!	; 0xfffffa9c
     6a4:	4644455f 			; <UNDEFINED> instruction: 0x4644455f
     6a8:	6f6c4200 	svcvs	0x006c4200
     6ac:	64656b63 	strbtvs	r6, [r5], #-2915	; 0xfffff49d
     6b0:	75436d00 	strbvc	r6, [r3, #-3328]	; 0xfffff300
     6b4:	6e657272 	mcrvs	2, 3, r7, cr5, cr2, {3}
     6b8:	61545f74 	cmpvs	r4, r4, ror pc
     6bc:	4e5f6b73 	vmovmi.s8	r6, d15[3]
     6c0:	0065646f 	rsbeq	r6, r5, pc, ror #8
     6c4:	65656c73 	strbvs	r6, [r5, #-3187]!	; 0xfffff38d
     6c8:	69745f70 	ldmdbvs	r4!, {r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     6cc:	0072656d 	rsbseq	r6, r2, sp, ror #10
     6d0:	314e5a5f 	cmpcc	lr, pc, asr sl
     6d4:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     6d8:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     6dc:	614d5f73 	hvcvs	54771	; 0xd5f3
     6e0:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     6e4:	77533972 			; <UNDEFINED> instruction: 0x77533972
     6e8:	68637469 	stmdavs	r3!, {r0, r3, r5, r6, sl, ip, sp, lr}^
     6ec:	456f545f 	strbmi	r5, [pc, #-1119]!	; 295 <shift+0x295>
     6f0:	43383150 	teqmi	r8, #80, 2
     6f4:	636f7250 	cmnvs	pc, #80, 4
     6f8:	5f737365 	svcpl	0x00737365
     6fc:	7473694c 	ldrbtvc	r6, [r3], #-2380	; 0xfffff6b4
     700:	646f4e5f 	strbtvs	r4, [pc], #-3679	; 708 <shift+0x708>
     704:	746f0065 	strbtvc	r0, [pc], #-101	; 70c <shift+0x70c>
     708:	5f726568 	svcpl	0x00726568
     70c:	656c6f72 	strbvs	r6, [ip, #-3954]!	; 0xfffff08e
     710:	75706300 	ldrbvc	r6, [r0, #-768]!	; 0xfffffd00
     714:	6e6f635f 	mcrvs	3, 3, r6, cr15, cr15, {2}
     718:	74786574 	ldrbtvc	r6, [r8], #-1396	; 0xfffffa8c
     71c:	6c617600 	stclvs	6, cr7, [r1], #-0
     720:	43006575 	movwmi	r6, #1397	; 0x575
     724:	74616572 	strbtvc	r6, [r1], #-1394	; 0xfffffa8e
     728:	72505f65 	subsvc	r5, r0, #404	; 0x194
     72c:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     730:	704f0073 	subvc	r0, pc, r3, ror r0	; <UNPREDICTABLE>
     734:	54006e65 	strpl	r6, [r0], #-3685	; 0xfffff19b
     738:	72656d69 	rsbvc	r6, r5, #6720	; 0x1a40
     73c:	7361425f 	cmnvc	r1, #-268435451	; 0xf0000005
     740:	5a5f0065 	bpl	17c08dc <__bss_end+0x17b6edc>
     744:	676f6c33 			; <UNDEFINED> instruction: 0x676f6c33
     748:	00634b50 	rsbeq	r4, r3, r0, asr fp
     74c:	31315a5f 	teqcc	r1, pc, asr sl
     750:	646e6168 	strbtvs	r6, [lr], #-360	; 0xfffffe98
     754:	645f656c 	ldrbvs	r6, [pc], #-1388	; 75c <shift+0x75c>
     758:	63617461 	cmnvs	r1, #1627389952	; 0x61000000
     75c:	65640066 	strbvs	r0, [r4, #-102]!	; 0xffffff9a
     760:	65726973 	ldrbvs	r6, [r2, #-2419]!	; 0xfffff68d
     764:	6f725f64 	svcvs	0x00725f64
     768:	2f00656c 	svccs	0x0000656c
     76c:	72657355 	rsbvc	r7, r5, #1409286145	; 0x54000001
     770:	69772f73 	ldmdbvs	r7!, {r0, r1, r4, r5, r6, r8, r9, sl, fp, sp}^
     774:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
     778:	442f696a 	strtmi	r6, [pc], #-2410	; 780 <shift+0x780>
     77c:	746b7365 	strbtvc	r7, [fp], #-869	; 0xfffffc9b
     780:	462f706f 	strtmi	r7, [pc], -pc, rrx
     784:	4e2f5641 	cfmadda32mi	mvax2, mvax5, mvfx15, mvfx1
     788:	7a617661 	bvc	185e114 <__bss_end+0x1854714>
     78c:	63696a75 	cmnvs	r9, #479232	; 0x75000
     790:	534f2f69 	movtpl	r2, #65385	; 0xff69
     794:	6d65732f 	stclvs	3, cr7, [r5, #-188]!	; 0xffffff44
     798:	72747365 	rsbsvc	r7, r4, #-1811939327	; 0x94000001
     79c:	616b6c61 	cmnvs	fp, r1, ror #24
     7a0:	76696b2d 	strbtvc	r6, [r9], -sp, lsr #22
     7a4:	2f736f2d 	svccs	0x00736f2d
     7a8:	72756f73 	rsbsvc	r6, r5, #460	; 0x1cc
     7ac:	2f736563 	svccs	0x00736563
     7b0:	72657375 	rsbvc	r7, r5, #-738197503	; 0xd4000001
     7b4:	63617073 	cmnvs	r1, #115	; 0x73
     7b8:	616d2f65 	cmnvs	sp, r5, ror #30
     7bc:	72657473 	rsbvc	r7, r5, #1929379840	; 0x73000000
     7c0:	7361745f 	cmnvc	r1, #1593835520	; 0x5f000000
     7c4:	616d2f6b 	cmnvs	sp, fp, ror #30
     7c8:	632e6e69 			; <UNDEFINED> instruction: 0x632e6e69
     7cc:	6d007070 	stcvs	0, cr7, [r0, #-448]	; 0xfffffe40
     7d0:	6f725f79 	svcvs	0x00725f79
     7d4:	5f00656c 	svcpl	0x0000656c
     7d8:	36314e5a 			; <UNDEFINED> instruction: 0x36314e5a
     7dc:	6f725043 	svcvs	0x00725043
     7e0:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     7e4:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     7e8:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     7ec:	6f4e3431 	svcvs	0x004e3431
     7f0:	79666974 	stmdbvc	r6!, {r2, r4, r5, r6, r8, fp, sp, lr}^
     7f4:	6f72505f 	svcvs	0x0072505f
     7f8:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     7fc:	32315045 	eorscc	r5, r1, #69	; 0x45
     800:	73615454 	cmnvc	r1, #84, 8	; 0x54000000
     804:	74535f6b 	ldrbvc	r5, [r3], #-3947	; 0xfffff095
     808:	74637572 	strbtvc	r7, [r3], #-1394	; 0xfffffa8e
     80c:	74654700 	strbtvc	r4, [r5], #-1792	; 0xfffff900
     810:	6863535f 	stmdavs	r3!, {r0, r1, r2, r3, r4, r6, r8, r9, ip, lr}^
     814:	495f6465 	ldmdbmi	pc, {r0, r2, r5, r6, sl, sp, lr}^	; <UNPREDICTABLE>
     818:	006f666e 	rsbeq	r6, pc, lr, ror #12
     81c:	76677261 	strbtvc	r7, [r7], -r1, ror #4
     820:	434f4900 	movtmi	r4, #63744	; 0xf900
     824:	52006c74 	andpl	r6, r0, #116, 24	; 0x7400
     828:	00646165 	rsbeq	r6, r4, r5, ror #2
     82c:	6d726554 	cfldr64vs	mvdx6, [r2, #-336]!	; 0xfffffeb0
     830:	74616e69 	strbtvc	r6, [r1], #-3689	; 0xfffff197
     834:	656e0065 	strbvs	r0, [lr, #-101]!	; 0xffffff9b
     838:	75625f77 	strbvc	r5, [r2, #-3959]!	; 0xfffff089
     83c:	4d006666 	stcmi	6, cr6, [r0, #-408]	; 0xfffffe68
     840:	65747361 	ldrbvs	r7, [r4, #-865]!	; 0xfffffc9f
     844:	6f4e0072 	svcvs	0x004e0072
     848:	79666974 	stmdbvc	r6!, {r2, r4, r5, r6, r8, fp, sp, lr}^
     84c:	6f72505f 	svcvs	0x0072505f
     850:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     854:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     858:	50433631 	subpl	r3, r3, r1, lsr r6
     85c:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     860:	4d5f7373 	ldclmi	3, cr7, [pc, #-460]	; 69c <shift+0x69c>
     864:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
     868:	34437265 	strbcc	r7, [r3], #-613	; 0xfffffd9b
     86c:	70007645 	andvc	r7, r0, r5, asr #12
     870:	5f706572 	svcpl	0x00706572
     874:	0067736d 	rsbeq	r7, r7, sp, ror #6
     878:	47524154 			; <UNDEFINED> instruction: 0x47524154
     87c:	415f5445 	cmpmi	pc, r5, asr #8
     880:	45524444 	ldrbmi	r4, [r2, #-1092]	; 0xfffffbbc
     884:	75005353 	strvc	r5, [r0, #-851]	; 0xfffffcad
     888:	38746e69 	ldmdacc	r4!, {r0, r3, r5, r6, r9, sl, fp, sp, lr}^
     88c:	4e00745f 	cfmvsrmi	mvf0, r7
     890:	6669746f 	strbtvs	r7, [r9], -pc, ror #8
     894:	666f0079 			; <UNDEFINED> instruction: 0x666f0079
     898:	00746573 	rsbseq	r6, r4, r3, ror r5
     89c:	5078614d 	rsbspl	r6, r8, sp, asr #2
     8a0:	4c687461 	cfstrdmi	mvd7, [r8], #-388	; 0xfffffe7c
     8a4:	74676e65 	strbtvc	r6, [r7], #-3685	; 0xfffff19b
     8a8:	614d0068 	cmpvs	sp, r8, rrx
     8ac:	44534678 	ldrbmi	r4, [r3], #-1656	; 0xfffff988
     8b0:	65766972 	ldrbvs	r6, [r6, #-2418]!	; 0xfffff68e
     8b4:	6d614e72 	stclvs	14, cr4, [r1, #-456]!	; 0xfffffe38
     8b8:	6e654c65 	cdpvs	12, 6, cr4, cr5, cr5, {3}
     8bc:	00687467 	rsbeq	r7, r8, r7, ror #8
     8c0:	314e5a5f 	cmpcc	lr, pc, asr sl
     8c4:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     8c8:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     8cc:	614d5f73 	hvcvs	54771	; 0xd5f3
     8d0:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     8d4:	53313172 	teqpl	r1, #-2147483620	; 0x8000001c
     8d8:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     8dc:	5f656c75 	svcpl	0x00656c75
     8e0:	76455252 			; <UNDEFINED> instruction: 0x76455252
     8e4:	65474e00 	strbvs	r4, [r7, #-3584]	; 0xfffff200
     8e8:	63535f74 	cmpvs	r3, #116, 30	; 0x1d0
     8ec:	5f646568 	svcpl	0x00646568
     8f0:	6f666e49 	svcvs	0x00666e49
     8f4:	7079545f 	rsbsvc	r5, r9, pc, asr r4
     8f8:	50470065 	subpl	r0, r7, r5, rrx
     8fc:	505f4f49 	subspl	r4, pc, r9, asr #30
     900:	435f6e69 	cmpmi	pc, #1680	; 0x690
     904:	746e756f 	strbtvc	r7, [lr], #-1391	; 0xfffffa91
     908:	73617400 	cmnvc	r1, #0, 8
     90c:	6f62006b 	svcvs	0x0062006b
     910:	5f006c6f 	svcpl	0x00006c6f
     914:	6431315a 	ldrtvs	r3, [r1], #-346	; 0xfffffea6
     918:	64696365 	strbtvs	r6, [r9], #-869	; 0xfffffc9b
     91c:	6f725f65 	svcvs	0x00725f65
     920:	4339656c 	teqmi	r9, #108, 10	; 0x1b000000
     924:	5f433249 	svcpl	0x00433249
     928:	65646f4d 	strbvs	r6, [r4, #-3917]!	; 0xfffff0b3
     92c:	5f006350 	svcpl	0x00006350
     930:	36314e5a 			; <UNDEFINED> instruction: 0x36314e5a
     934:	6f725043 	svcvs	0x00725043
     938:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     93c:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     940:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     944:	65473831 	strbvs	r3, [r7, #-2097]	; 0xfffff7cf
     948:	63535f74 	cmpvs	r3, #116, 30	; 0x1d0
     94c:	75646568 	strbvc	r6, [r4, #-1384]!	; 0xfffffa98
     950:	5f72656c 	svcpl	0x0072656c
     954:	6f666e49 	svcvs	0x00666e49
     958:	4e303245 	cdpmi	2, 3, cr3, cr0, cr5, {2}
     95c:	5f746547 	svcpl	0x00746547
     960:	65686353 	strbvs	r6, [r8, #-851]!	; 0xfffffcad
     964:	6e495f64 	cdpvs	15, 4, cr5, cr9, cr4, {3}
     968:	545f6f66 	ldrbpl	r6, [pc], #-3942	; 970 <shift+0x970>
     96c:	50657079 	rsbpl	r7, r5, r9, ror r0
     970:	52540076 	subspl	r0, r4, #118	; 0x76
     974:	425f474e 	subsmi	r4, pc, #20447232	; 0x1380000
     978:	00657361 	rsbeq	r7, r5, r1, ror #6
     97c:	76616c53 			; <UNDEFINED> instruction: 0x76616c53
     980:	65440065 	strbvs	r0, [r4, #-101]	; 0xffffff9b
     984:	6c756166 	ldfvse	f6, [r5], #-408	; 0xfffffe68
     988:	6c435f74 	mcrrvs	15, 7, r5, r3, cr4
     98c:	5f6b636f 	svcpl	0x006b636f
     990:	65746152 	ldrbvs	r6, [r4, #-338]!	; 0xfffffeae
     994:	72506d00 	subsvc	r6, r0, #0, 26
     998:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     99c:	694c5f73 	stmdbvs	ip, {r0, r1, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     9a0:	485f7473 	ldmdami	pc, {r0, r1, r4, r5, r6, sl, ip, sp, lr}^	; <UNPREDICTABLE>
     9a4:	00646165 	rsbeq	r6, r4, r5, ror #2
     9a8:	6863536d 	stmdavs	r3!, {r0, r2, r3, r5, r6, r8, r9, ip, lr}^
     9ac:	6c756465 	cfldrdvs	mvd6, [r5], #-404	; 0xfffffe6c
     9b0:	6e465f65 	cdpvs	15, 4, cr5, cr6, cr5, {3}
     9b4:	5a5f0063 	bpl	17c0b48 <__bss_end+0x17b7148>
     9b8:	4336314e 	teqmi	r6, #-2147483629	; 0x80000013
     9bc:	636f7250 	cmnvs	pc, #80, 4
     9c0:	5f737365 	svcpl	0x00737365
     9c4:	616e614d 	cmnvs	lr, sp, asr #2
     9c8:	32726567 	rsbscc	r6, r2, #432013312	; 0x19c00000
     9cc:	6f6c4231 	svcvs	0x006c4231
     9d0:	435f6b63 	cmpmi	pc, #101376	; 0x18c00
     9d4:	65727275 	ldrbvs	r7, [r2, #-629]!	; 0xfffffd8b
     9d8:	505f746e 	subspl	r7, pc, lr, ror #8
     9dc:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     9e0:	76457373 			; <UNDEFINED> instruction: 0x76457373
     9e4:	636f4c00 	cmnvs	pc, #0, 24
     9e8:	6e555f6b 	cdpvs	15, 5, cr5, cr5, cr11, {3}
     9ec:	6b636f6c 	blvs	18dc7a4 <__bss_end+0x18d2da4>
     9f0:	6d006465 	cfstrsvs	mvf6, [r0, #-404]	; 0xfffffe6c
     9f4:	7473614c 	ldrbtvc	r6, [r3], #-332	; 0xfffffeb4
     9f8:	4449505f 	strbmi	r5, [r9], #-95	; 0xffffffa1
     9fc:	72676100 	rsbvc	r6, r7, #0, 2
     a00:	5f646565 	svcpl	0x00646565
     a04:	656c6f72 	strbvs	r6, [ip, #-3954]!	; 0xfffff08e
     a08:	69775300 	ldmdbvs	r7!, {r8, r9, ip, lr}^
     a0c:	5f686374 	svcpl	0x00686374
     a10:	43006f54 	movwmi	r6, #3924	; 0xf54
     a14:	65736f6c 	ldrbvs	r6, [r3, #-3948]!	; 0xfffff094
     a18:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     a1c:	50433631 	subpl	r3, r3, r1, lsr r6
     a20:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     a24:	4d5f7373 	ldclmi	3, cr7, [pc, #-460]	; 860 <shift+0x860>
     a28:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
     a2c:	32317265 	eorscc	r7, r1, #1342177286	; 0x50000006
     a30:	65686353 	strbvs	r6, [r8, #-851]!	; 0xfffffcad
     a34:	656c7564 	strbvs	r7, [ip, #-1380]!	; 0xfffffa9c
     a38:	4644455f 			; <UNDEFINED> instruction: 0x4644455f
     a3c:	42007645 	andmi	r7, r0, #72351744	; 0x4500000
     a40:	5f304353 	svcpl	0x00304353
     a44:	65736142 	ldrbvs	r6, [r3, #-322]!	; 0xfffffebe
     a48:	646e5500 	strbtvs	r5, [lr], #-1280	; 0xfffffb00
     a4c:	6e696665 	cdpvs	6, 6, cr6, cr9, cr5, {3}
     a50:	61006465 	tstvs	r0, r5, ror #8
     a54:	00636772 	rsbeq	r6, r3, r2, ror r7
     a58:	69746f6e 	ldmdbvs	r4!, {r1, r2, r3, r5, r6, r8, r9, sl, fp, sp, lr}^
     a5c:	64656966 	strbtvs	r6, [r5], #-2406	; 0xfffff69a
     a60:	6165645f 	cmnvs	r5, pc, asr r4
     a64:	6e696c64 	cdpvs	12, 6, cr6, cr9, cr4, {3}
     a68:	65720065 	ldrbvs	r0, [r2, #-101]!	; 0xffffff9b
     a6c:	76696563 	strbtvc	r6, [r9], -r3, ror #10
     a70:	765f6465 	ldrbvc	r6, [pc], -r5, ror #8
     a74:	65756c61 	ldrbvs	r6, [r5, #-3169]!	; 0xfffff39f
     a78:	656c5f73 	strbvs	r5, [ip, #-3955]!	; 0xfffff08d
     a7c:	6975006e 	ldmdbvs	r5!, {r1, r2, r3, r5, r6}^
     a80:	3631746e 	ldrtcc	r7, [r1], -lr, ror #8
     a84:	6c00745f 	cfstrsvs	mvf7, [r0], {95}	; 0x5f
     a88:	6d5f676f 	ldclvs	7, cr6, [pc, #-444]	; 8d4 <shift+0x8d4>
     a8c:	76006773 			; <UNDEFINED> instruction: 0x76006773
     a90:	65756c61 	ldrbvs	r6, [r5, #-3169]!	; 0xfffff39f
     a94:	6174735f 	cmnvs	r4, pc, asr r3
     a98:	5f006574 	svcpl	0x00006574
     a9c:	36314e5a 			; <UNDEFINED> instruction: 0x36314e5a
     aa0:	6f725043 	svcvs	0x00725043
     aa4:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     aa8:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     aac:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     ab0:	6f4e3431 	svcvs	0x004e3431
     ab4:	79666974 	stmdbvc	r6!, {r2, r4, r5, r6, r8, fp, sp, lr}^
     ab8:	6f72505f 	svcvs	0x0072505f
     abc:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     ac0:	4e006a45 	vmlsmi.f32	s12, s0, s10
     ac4:	6c69466f 	stclvs	6, cr4, [r9], #-444	; 0xfffffe44
     ac8:	73797365 	cmnvc	r9, #-1811939327	; 0x94000001
     acc:	446d6574 	strbtmi	r6, [sp], #-1396	; 0xfffffa8c
     ad0:	65766972 	ldrbvs	r6, [r6, #-2418]!	; 0xfffff68e
     ad4:	65440072 	strbvs	r0, [r4, #-114]	; 0xffffff8e
     ad8:	696c6461 	stmdbvs	ip!, {r0, r5, r6, sl, sp, lr}^
     adc:	4400656e 	strmi	r6, [r0], #-1390	; 0xfffffa92
     ae0:	62617369 	rsbvs	r7, r1, #-1543503871	; 0xa4000001
     ae4:	455f656c 	ldrbmi	r6, [pc, #-1388]	; 580 <shift+0x580>
     ae8:	746e6576 	strbtvc	r6, [lr], #-1398	; 0xfffffa8a
     aec:	7465445f 	strbtvc	r4, [r5], #-1119	; 0xfffffba1
     af0:	69746365 	ldmdbvs	r4!, {r0, r2, r5, r6, r8, r9, sp, lr}^
     af4:	73006e6f 	movwvc	r6, #3695	; 0xe6f
     af8:	74726f68 	ldrbtvc	r6, [r2], #-3944	; 0xfffff098
     afc:	746e6920 	strbtvc	r6, [lr], #-2336	; 0xfffff6e0
     b00:	78614d00 	stmdavc	r1!, {r8, sl, fp, lr}^
     b04:	656c6946 	strbvs	r6, [ip, #-2374]!	; 0xfffff6ba
     b08:	656d616e 	strbvs	r6, [sp, #-366]!	; 0xfffffe92
     b0c:	676e654c 	strbvs	r6, [lr, -ip, asr #10]!
     b10:	43006874 	movwmi	r6, #2164	; 0x874
     b14:	636f7250 	cmnvs	pc, #80, 4
     b18:	5f737365 	svcpl	0x00737365
     b1c:	616e614d 	cmnvs	lr, sp, asr #2
     b20:	00726567 	rsbseq	r6, r2, r7, ror #10
     b24:	72627474 	rsbvc	r7, r2, #116, 8	; 0x74000000
     b28:	65730030 	ldrbvs	r0, [r3, #-48]!	; 0xffffffd0
     b2c:	6f725f74 	svcvs	0x00725f74
     b30:	0073656c 	rsbseq	r6, r3, ip, ror #10
     b34:	4957534e 	ldmdbmi	r7, {r1, r2, r3, r6, r8, r9, ip, lr}^
     b38:	6c69465f 	stclvs	6, cr4, [r9], #-380	; 0xfffffe84
     b3c:	73797365 	cmnvc	r9, #-1811939327	; 0x94000001
     b40:	5f6d6574 	svcpl	0x006d6574
     b44:	76726553 			; <UNDEFINED> instruction: 0x76726553
     b48:	00656369 	rsbeq	r6, r5, r9, ror #6
     b4c:	4957534e 	ldmdbmi	r7, {r1, r2, r3, r6, r8, r9, ip, lr}^
     b50:	6f72505f 	svcvs	0x0072505f
     b54:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     b58:	7265535f 	rsbvc	r5, r5, #2080374785	; 0x7c000001
     b5c:	65636976 	strbvs	r6, [r3, #-2422]!	; 0xfffff68a
     b60:	65706f00 	ldrbvs	r6, [r0, #-3840]!	; 0xfffff100
     b64:	5f64656e 	svcpl	0x0064656e
     b68:	656c6966 	strbvs	r6, [ip, #-2406]!	; 0xfffff69a
     b6c:	69590073 	ldmdbvs	r9, {r0, r1, r4, r5, r6}^
     b70:	00646c65 	rsbeq	r6, r4, r5, ror #24
     b74:	69636564 	stmdbvs	r3!, {r2, r5, r6, r8, sl, sp, lr}^
     b78:	725f6564 	subsvc	r6, pc, #100, 10	; 0x19000000
     b7c:	00656c6f 	rsbeq	r6, r5, pc, ror #24
     b80:	65646e49 	strbvs	r6, [r4, #-3657]!	; 0xfffff1b7
     b84:	696e6966 	stmdbvs	lr!, {r1, r2, r5, r6, r8, fp, sp, lr}^
     b88:	47006574 	smlsdxmi	r0, r4, r5, r6
     b8c:	505f7465 	subspl	r7, pc, r5, ror #8
     b90:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     b94:	425f7373 	subsmi	r7, pc, #-872415231	; 0xcc000001
     b98:	49505f79 	ldmdbmi	r0, {r0, r3, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     b9c:	6e450044 	cdpvs	0, 4, cr0, cr5, cr4, {2}
     ba0:	656c6261 	strbvs	r6, [ip, #-609]!	; 0xfffffd9f
     ba4:	6576455f 	ldrbvs	r4, [r6, #-1375]!	; 0xfffffaa1
     ba8:	445f746e 	ldrbmi	r7, [pc], #-1134	; bb0 <shift+0xbb0>
     bac:	63657465 	cmnvs	r5, #1694498816	; 0x65000000
     bb0:	6e6f6974 			; <UNDEFINED> instruction: 0x6e6f6974
     bb4:	72655000 	rsbvc	r5, r5, #0
     bb8:	65687069 	strbvs	r7, [r8, #-105]!	; 0xffffff97
     bbc:	5f6c6172 	svcpl	0x006c6172
     bc0:	65736142 	ldrbvs	r6, [r3, #-322]!	; 0xfffffebe
     bc4:	53454400 	movtpl	r4, #21504	; 0x5400
     bc8:	44455249 	strbmi	r5, [r5], #-585	; 0xfffffdb7
     bcc:	4c4f525f 	sfmmi	f5, 2, [pc], {95}	; 0x5f
     bd0:	6f6c0045 	svcvs	0x006c0045
     bd4:	7520676e 	strvc	r6, [r0, #-1902]!	; 0xfffff892
     bd8:	6769736e 	strbvs	r7, [r9, -lr, ror #6]!
     bdc:	2064656e 	rsbcs	r6, r4, lr, ror #10
     be0:	00746e69 	rsbseq	r6, r4, r9, ror #28
     be4:	72646461 	rsbvc	r6, r4, #1627389952	; 0x61000000
     be8:	00737365 	rsbseq	r7, r3, r5, ror #6
     bec:	61766e49 	cmnvs	r6, r9, asr #28
     bf0:	5f64696c 	svcpl	0x0064696c
     bf4:	006e6950 	rsbeq	r6, lr, r0, asr r9
     bf8:	7473616d 	ldrbtvc	r6, [r3], #-365	; 0xfffffe93
     bfc:	4c007265 	sfmmi	f7, 4, [r0], {101}	; 0x65
     c00:	5f6b636f 	svcpl	0x006b636f
     c04:	6b636f4c 	blvs	18dc93c <__bss_end+0x18d2f3c>
     c08:	5f006465 	svcpl	0x00006465
     c0c:	36314e5a 			; <UNDEFINED> instruction: 0x36314e5a
     c10:	6f725043 	svcvs	0x00725043
     c14:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     c18:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     c1c:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     c20:	61483831 	cmpvs	r8, r1, lsr r8
     c24:	656c646e 	strbvs	r6, [ip, #-1134]!	; 0xfffffb92
     c28:	6f72505f 	svcvs	0x0072505f
     c2c:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     c30:	4957535f 	ldmdbmi	r7, {r0, r1, r2, r3, r4, r6, r8, r9, ip, lr}^
     c34:	4e303245 	cdpmi	2, 3, cr3, cr0, cr5, {2}
     c38:	5f495753 	svcpl	0x00495753
     c3c:	636f7250 	cmnvs	pc, #80, 4
     c40:	5f737365 	svcpl	0x00737365
     c44:	76726553 			; <UNDEFINED> instruction: 0x76726553
     c48:	6a656369 	bvs	19599f4 <__bss_end+0x194fff4>
     c4c:	31526a6a 	cmpcc	r2, sl, ror #20
     c50:	57535431 	smmlarpl	r3, r1, r4, r5
     c54:	65525f49 	ldrbvs	r5, [r2, #-3913]	; 0xfffff0b7
     c58:	746c7573 	strbtvc	r7, [ip], #-1395	; 0xfffffa8d
     c5c:	315a5f00 	cmpcc	sl, r0, lsl #30
     c60:	63657232 	cmnvs	r5, #536870915	; 0x20000003
     c64:	65766965 	ldrbvs	r6, [r6, #-2405]!	; 0xfffff69b
     c68:	7461645f 	strbtvc	r6, [r1], #-1119	; 0xfffffba1
     c6c:	73007661 	movwvc	r7, #1633	; 0x661
     c70:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     c74:	756f635f 	strbvc	r6, [pc, #-863]!	; 91d <shift+0x91d>
     c78:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
     c7c:	74654700 	strbtvc	r4, [r5], #-1792	; 0xfffff900
     c80:	7261505f 	rsbvc	r5, r1, #95	; 0x5f
     c84:	00736d61 	rsbseq	r6, r3, r1, ror #26
     c88:	69736e75 	ldmdbvs	r3!, {r0, r2, r4, r5, r6, r9, sl, fp, sp, lr}^
     c8c:	64656e67 	strbtvs	r6, [r5], #-3687	; 0xfffff199
     c90:	61686320 	cmnvs	r8, r0, lsr #6
     c94:	5a5f0072 	bpl	17c0e64 <__bss_end+0x17b7464>
     c98:	65727038 	ldrbvs	r7, [r2, #-56]!	; 0xffffffc8
     c9c:	736d5f70 	cmnvc	sp, #112, 30	; 0x1c0
     ca0:	50635067 	rsbpl	r5, r3, r7, rrx
     ca4:	4900634b 	stmdbmi	r0, {r0, r1, r3, r6, r8, r9, sp, lr}
     ca8:	535f4332 	cmppl	pc, #-939524096	; 0xc8000000
     cac:	4556414c 	ldrbmi	r4, [r6, #-332]	; 0xfffffeb4
     cb0:	7361425f 	cmnvc	r1, #-268435451	; 0xf0000005
     cb4:	6e490065 	cdpvs	0, 4, cr0, cr9, cr5, {3}
     cb8:	72726574 	rsbsvc	r6, r2, #116, 10	; 0x1d000000
     cbc:	61747075 	cmnvs	r4, r5, ror r0
     cc0:	5f656c62 	svcpl	0x00656c62
     cc4:	65656c53 	strbvs	r6, [r5, #-3155]!	; 0xfffff3ad
     cc8:	63530070 	cmpvs	r3, #112	; 0x70
     ccc:	75646568 	strbvc	r6, [r4, #-1384]!	; 0xfffffa98
     cd0:	525f656c 	subspl	r6, pc, #108, 10	; 0x1b000000
     cd4:	55410052 	strbpl	r0, [r1, #-82]	; 0xffffffae
     cd8:	61425f58 	cmpvs	r2, r8, asr pc
     cdc:	42006573 	andmi	r6, r0, #482344960	; 0x1cc00000
     ce0:	5f324353 	svcpl	0x00324353
     ce4:	65736142 	ldrbvs	r6, [r3, #-322]!	; 0xfffffebe
     ce8:	395a5f00 	ldmdbcc	sl, {r8, r9, sl, fp, ip, lr}^
     cec:	5f746573 	svcpl	0x00746573
     cf0:	656c6f72 	strbvs	r6, [ip, #-3954]!	; 0xfffff08e
     cf4:	49433973 	stmdbmi	r3, {r0, r1, r4, r5, r6, r8, fp, ip, sp}^
     cf8:	4d5f4332 	ldclmi	3, cr4, [pc, #-200]	; c38 <shift+0xc38>
     cfc:	0065646f 	rsbeq	r6, r5, pc, ror #8
     d00:	646e6168 	strbtvs	r6, [lr], #-360	; 0xfffffe98
     d04:	645f656c 	ldrbvs	r6, [pc], #-1388	; d0c <shift+0xd0c>
     d08:	00617461 	rsbeq	r7, r1, r1, ror #8
     d0c:	74697257 	strbtvc	r7, [r9], #-599	; 0xfffffda9
     d10:	6e4f5f65 	cdpvs	15, 4, cr5, cr15, cr5, {3}
     d14:	5300796c 	movwpl	r7, #2412	; 0x96c
     d18:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     d1c:	00656c75 	rsbeq	r6, r5, r5, ror ip
     d20:	6b636954 	blvs	18db278 <__bss_end+0x18d1878>
     d24:	756f435f 	strbvc	r4, [pc, #-863]!	; 9cd <shift+0x9cd>
     d28:	5f00746e 	svcpl	0x0000746e
     d2c:	36314e5a 			; <UNDEFINED> instruction: 0x36314e5a
     d30:	6f725043 	svcvs	0x00725043
     d34:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     d38:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     d3c:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     d40:	6e553831 	mrcvs	8, 2, r3, cr5, cr1, {1}
     d44:	5f70616d 	svcpl	0x0070616d
     d48:	656c6946 	strbvs	r6, [ip, #-2374]!	; 0xfffff6ba
     d4c:	7275435f 	rsbsvc	r4, r5, #2080374785	; 0x7c000001
     d50:	746e6572 	strbtvc	r6, [lr], #-1394	; 0xfffffa8e
     d54:	48006a45 	stmdami	r0, {r0, r2, r6, r9, fp, sp, lr}
     d58:	6c646e61 	stclvs	14, cr6, [r4], #-388	; 0xfffffe7c
     d5c:	69465f65 	stmdbvs	r6, {r0, r2, r5, r6, r8, r9, sl, fp, ip, lr}^
     d60:	7973656c 	ldmdbvc	r3!, {r2, r3, r5, r6, r8, sl, sp, lr}^
     d64:	6d657473 	cfstrdvs	mvd7, [r5, #-460]!	; 0xfffffe34
     d68:	4957535f 	ldmdbmi	r7, {r0, r1, r2, r3, r4, r6, r8, r9, ip, lr}^
     d6c:	6f687300 	svcvs	0x00687300
     d70:	75207472 	strvc	r7, [r0, #-1138]!	; 0xfffffb8e
     d74:	6769736e 	strbvs	r7, [r9, -lr, ror #6]!
     d78:	2064656e 	rsbcs	r6, r4, lr, ror #10
     d7c:	00746e69 	rsbseq	r6, r4, r9, ror #28
     d80:	6e69616d 	powvsez	f6, f1, #5.0
     d84:	72617400 	rsbvc	r7, r1, #0, 8
     d88:	41746567 	cmnmi	r4, r7, ror #10
     d8c:	73657264 	cmnvc	r5, #100, 4	; 0x40000006
     d90:	6e490073 	mcrvs	0, 2, r0, cr9, cr3, {3}
     d94:	72726574 	rsbsvc	r6, r2, #116, 10	; 0x1d000000
     d98:	5f747075 	svcpl	0x00747075
     d9c:	746e6f43 	strbtvc	r6, [lr], #-3907	; 0xfffff0bd
     da0:	6c6c6f72 	stclvs	15, cr6, [ip], #-456	; 0xfffffe38
     da4:	425f7265 	subsmi	r7, pc, #1342177286	; 0x50000006
     da8:	00657361 	rsbeq	r7, r5, r1, ror #6
     dac:	65636572 	strbvs	r6, [r3, #-1394]!	; 0xfffffa8e
     db0:	64657669 	strbtvs	r7, [r5], #-1641	; 0xfffff997
     db4:	6c61765f 	stclvs	6, cr7, [r1], #-380	; 0xfffffe84
     db8:	00736575 	rsbseq	r6, r3, r5, ror r5
     dbc:	64616552 	strbtvs	r6, [r1], #-1362	; 0xfffffaae
     dc0:	6972575f 	ldmdbvs	r2!, {r0, r1, r2, r3, r4, r6, r8, r9, sl, ip, lr}^
     dc4:	41006574 	tstmi	r0, r4, ror r5
     dc8:	76697463 	strbtvc	r7, [r9], -r3, ror #8
     dcc:	72505f65 	subsvc	r5, r0, #404	; 0x194
     dd0:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     dd4:	6f435f73 	svcvs	0x00435f73
     dd8:	00746e75 	rsbseq	r6, r4, r5, ror lr
     ddc:	314e5a5f 	cmpcc	lr, pc, asr sl
     de0:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     de4:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     de8:	614d5f73 	hvcvs	54771	; 0xd5f3
     dec:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     df0:	48313272 	ldmdami	r1!, {r1, r4, r5, r6, r9, ip, sp}
     df4:	6c646e61 	stclvs	14, cr6, [r4], #-388	; 0xfffffe7c
     df8:	69465f65 	stmdbvs	r6, {r0, r2, r5, r6, r8, r9, sl, fp, ip, lr}^
     dfc:	7973656c 	ldmdbvc	r3!, {r2, r3, r5, r6, r8, sl, sp, lr}^
     e00:	6d657473 	cfstrdvs	mvd7, [r5, #-460]!	; 0xfffffe34
     e04:	4957535f 	ldmdbmi	r7, {r0, r1, r2, r3, r4, r6, r8, r9, ip, lr}^
     e08:	4e333245 	cdpmi	2, 3, cr3, cr3, cr5, {2}
     e0c:	5f495753 	svcpl	0x00495753
     e10:	656c6946 	strbvs	r6, [ip, #-2374]!	; 0xfffff6ba
     e14:	74737973 	ldrbtvc	r7, [r3], #-2419	; 0xfffff68d
     e18:	535f6d65 	cmppl	pc, #6464	; 0x1940
     e1c:	69767265 	ldmdbvs	r6!, {r0, r2, r5, r6, r9, ip, sp, lr}^
     e20:	6a6a6563 	bvs	1a9a3b4 <__bss_end+0x1a909b4>
     e24:	3131526a 	teqcc	r1, sl, ror #4
     e28:	49575354 	ldmdbmi	r7, {r2, r4, r6, r8, r9, ip, lr}^
     e2c:	7365525f 	cmnvc	r5, #-268435451	; 0xf0000005
     e30:	00746c75 	rsbseq	r6, r4, r5, ror ip
     e34:	6573552f 	ldrbvs	r5, [r3, #-1327]!	; 0xfffffad1
     e38:	772f7372 			; <UNDEFINED> instruction: 0x772f7372
     e3c:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
     e40:	2f696a72 	svccs	0x00696a72
     e44:	6b736544 	blvs	1cda35c <__bss_end+0x1cd095c>
     e48:	2f706f74 	svccs	0x00706f74
     e4c:	2f564146 	svccs	0x00564146
     e50:	6176614e 	cmnvs	r6, lr, asr #2
     e54:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
     e58:	4f2f6963 	svcmi	0x002f6963
     e5c:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
     e60:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
     e64:	6b6c6172 	blvs	1b19434 <__bss_end+0x1b0fa34>
     e68:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
     e6c:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
     e70:	756f732f 	strbvc	r7, [pc, #-815]!	; b49 <shift+0xb49>
     e74:	73656372 	cmnvc	r5, #-939524095	; 0xc8000001
     e78:	6975622f 	ldmdbvs	r5!, {r0, r1, r2, r3, r5, r9, sp, lr}^
     e7c:	6300646c 	movwvs	r6, #1132	; 0x46c
     e80:	65736f6c 	ldrbvs	r6, [r3, #-3948]!	; 0xfffff094
     e84:	74655300 	strbtvc	r5, [r5], #-768	; 0xfffffd00
     e88:	6c65525f 	sfmvs	f5, 2, [r5], #-380	; 0xfffffe84
     e8c:	76697461 	strbtvc	r7, [r9], -r1, ror #8
     e90:	65720065 	ldrbvs	r0, [r2, #-101]!	; 0xffffff9b
     e94:	6c617674 	stclvs	6, cr7, [r1], #-464	; 0xfffffe30
     e98:	75636e00 	strbvc	r6, [r3, #-3584]!	; 0xfffff200
     e9c:	69700072 	ldmdbvs	r0!, {r1, r4, r5, r6}^
     ea0:	72006570 	andvc	r6, r0, #112, 10	; 0x1c000000
     ea4:	6d756e64 	ldclvs	14, cr6, [r5, #-400]!	; 0xfffffe70
     ea8:	315a5f00 	cmpcc	sl, r0, lsl #30
     eac:	68637331 	stmdavs	r3!, {r0, r4, r5, r8, r9, ip, sp, lr}^
     eb0:	795f6465 	ldmdbvc	pc, {r0, r2, r5, r6, sl, sp, lr}^	; <UNPREDICTABLE>
     eb4:	646c6569 	strbtvs	r6, [ip], #-1385	; 0xfffffa97
     eb8:	5a5f0076 	bpl	17c1098 <__bss_end+0x17b7698>
     ebc:	65733731 	ldrbvs	r3, [r3, #-1841]!	; 0xfffff8cf
     ec0:	61745f74 	cmnvs	r4, r4, ror pc
     ec4:	645f6b73 	ldrbvs	r6, [pc], #-2931	; ecc <shift+0xecc>
     ec8:	6c646165 	stfvse	f6, [r4], #-404	; 0xfffffe6c
     ecc:	6a656e69 	bvs	195c878 <__bss_end+0x1952e78>
     ed0:	69617700 	stmdbvs	r1!, {r8, r9, sl, ip, sp, lr}^
     ed4:	5a5f0074 	bpl	17c10ac <__bss_end+0x17b76ac>
     ed8:	746f6e36 	strbtvc	r6, [pc], #-3638	; ee0 <shift+0xee0>
     edc:	6a796669 	bvs	1e5a888 <__bss_end+0x1e50e88>
     ee0:	6146006a 	cmpvs	r6, sl, rrx
     ee4:	65006c69 	strvs	r6, [r0, #-3177]	; 0xfffff397
     ee8:	63746978 	cmnvs	r4, #120, 18	; 0x1e0000
     eec:	0065646f 	rsbeq	r6, r5, pc, ror #8
     ef0:	65686373 	strbvs	r6, [r8, #-883]!	; 0xfffffc8d
     ef4:	69795f64 	ldmdbvs	r9!, {r2, r5, r6, r8, r9, sl, fp, ip, lr}^
     ef8:	00646c65 	rsbeq	r6, r4, r5, ror #24
     efc:	6b636974 	blvs	18db4d4 <__bss_end+0x18d1ad4>
     f00:	756f635f 	strbvc	r6, [pc, #-863]!	; ba9 <shift+0xba9>
     f04:	725f746e 	subsvc	r7, pc, #1845493760	; 0x6e000000
     f08:	69757165 	ldmdbvs	r5!, {r0, r2, r5, r6, r8, ip, sp, lr}^
     f0c:	00646572 	rsbeq	r6, r4, r2, ror r5
     f10:	34325a5f 	ldrtcc	r5, [r2], #-2655	; 0xfffff5a1
     f14:	5f746567 	svcpl	0x00746567
     f18:	69746361 	ldmdbvs	r4!, {r0, r5, r6, r8, r9, sp, lr}^
     f1c:	705f6576 	subsvc	r6, pc, r6, ror r5	; <UNPREDICTABLE>
     f20:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     f24:	635f7373 	cmpvs	pc, #-872415231	; 0xcc000001
     f28:	746e756f 	strbtvc	r7, [lr], #-1391	; 0xfffffa91
     f2c:	69500076 	ldmdbvs	r0, {r1, r2, r4, r5, r6}^
     f30:	465f6570 			; <UNDEFINED> instruction: 0x465f6570
     f34:	5f656c69 	svcpl	0x00656c69
     f38:	66657250 			; <UNDEFINED> instruction: 0x66657250
     f3c:	5f007869 	svcpl	0x00007869
     f40:	6734315a 			; <UNDEFINED> instruction: 0x6734315a
     f44:	745f7465 	ldrbvc	r7, [pc], #-1125	; f4c <shift+0xf4c>
     f48:	5f6b6369 	svcpl	0x006b6369
     f4c:	6e756f63 	cdpvs	15, 7, cr6, cr5, cr3, {3}
     f50:	73007674 	movwvc	r7, #1652	; 0x674
     f54:	7065656c 	rsbvc	r6, r5, ip, ror #10
     f58:	395a5f00 	ldmdbcc	sl, {r8, r9, sl, fp, ip, lr}^
     f5c:	6d726574 	cfldr64vs	mvdx6, [r2, #-464]!	; 0xfffffe30
     f60:	74616e69 	strbtvc	r6, [r1], #-3689	; 0xfffff197
     f64:	6f006965 	svcvs	0x00006965
     f68:	61726570 	cmnvs	r2, r0, ror r5
     f6c:	6e6f6974 			; <UNDEFINED> instruction: 0x6e6f6974
     f70:	355a5f00 	ldrbcc	r5, [sl, #-3840]	; 0xfffff100
     f74:	736f6c63 	cmnvc	pc, #25344	; 0x6300
     f78:	5f006a65 	svcpl	0x00006a65
     f7c:	6567365a 	strbvs	r3, [r7, #-1626]!	; 0xfffff9a6
     f80:	64697074 	strbtvs	r7, [r9], #-116	; 0xffffff8c
     f84:	6e660076 	mcrvs	0, 3, r0, cr6, cr6, {3}
     f88:	00656d61 	rsbeq	r6, r5, r1, ror #26
     f8c:	74697277 	strbtvc	r7, [r9], #-631	; 0xfffffd89
     f90:	69740065 	ldmdbvs	r4!, {r0, r2, r5, r6}^
     f94:	00736b63 	rsbseq	r6, r3, r3, ror #22
     f98:	6e65706f 	cdpvs	0, 6, cr7, cr5, cr15, {3}
     f9c:	345a5f00 	ldrbcc	r5, [sl], #-3840	; 0xfffff100
     fa0:	65706970 	ldrbvs	r6, [r0, #-2416]!	; 0xfffff690
     fa4:	6a634b50 	bvs	18d3cec <__bss_end+0x18ca2ec>
     fa8:	65444e00 	strbvs	r4, [r4, #-3584]	; 0xfffff200
     fac:	696c6461 	stmdbvs	ip!, {r0, r5, r6, sl, sp, lr}^
     fb0:	535f656e 	cmppl	pc, #461373440	; 0x1b800000
     fb4:	65736275 	ldrbvs	r6, [r3, #-629]!	; 0xfffffd8b
     fb8:	63697672 	cmnvs	r9, #119537664	; 0x7200000
     fbc:	65670065 	strbvs	r0, [r7, #-101]!	; 0xffffff9b
     fc0:	69745f74 	ldmdbvs	r4!, {r2, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     fc4:	635f6b63 	cmpvs	pc, #101376	; 0x18c00
     fc8:	746e756f 	strbtvc	r7, [lr], #-1391	; 0xfffffa91
     fcc:	72617000 	rsbvc	r7, r1, #0
     fd0:	5f006d61 	svcpl	0x00006d61
     fd4:	7277355a 	rsbsvc	r3, r7, #377487360	; 0x16800000
     fd8:	6a657469 	bvs	195e184 <__bss_end+0x1954784>
     fdc:	6a634b50 	bvs	18d3d24 <__bss_end+0x18ca324>
     fe0:	74656700 	strbtvc	r6, [r5], #-1792	; 0xfffff900
     fe4:	7361745f 	cmnvc	r1, #1593835520	; 0x5f000000
     fe8:	69745f6b 	ldmdbvs	r4!, {r0, r1, r3, r5, r6, r8, r9, sl, fp, ip, lr}^
     fec:	5f736b63 	svcpl	0x00736b63
     ff0:	645f6f74 	ldrbvs	r6, [pc], #-3956	; ff8 <shift+0xff8>
     ff4:	6c646165 	stfvse	f6, [r4], #-404	; 0xfffffe6c
     ff8:	00656e69 	rsbeq	r6, r5, r9, ror #28
     ffc:	5f667562 	svcpl	0x00667562
    1000:	657a6973 	ldrbvs	r6, [sl, #-2419]!	; 0xfffff68d
    1004:	74657300 	strbtvc	r7, [r5], #-768	; 0xfffffd00
    1008:	7361745f 	cmnvc	r1, #1593835520	; 0x5f000000
    100c:	65645f6b 	strbvs	r5, [r4, #-3947]!	; 0xfffff095
    1010:	696c6461 	stmdbvs	ip!, {r0, r5, r6, sl, sp, lr}^
    1014:	2f00656e 	svccs	0x0000656e
    1018:	72657355 	rsbvc	r7, r5, #1409286145	; 0x54000001
    101c:	69772f73 	ldmdbvs	r7!, {r0, r1, r4, r5, r6, r8, r9, sl, fp, sp}^
    1020:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
    1024:	442f696a 	strtmi	r6, [pc], #-2410	; 102c <shift+0x102c>
    1028:	746b7365 	strbtvc	r7, [fp], #-869	; 0xfffffc9b
    102c:	462f706f 	strtmi	r7, [pc], -pc, rrx
    1030:	4e2f5641 	cfmadda32mi	mvax2, mvax5, mvfx15, mvfx1
    1034:	7a617661 	bvc	185e9c0 <__bss_end+0x1854fc0>
    1038:	63696a75 	cmnvs	r9, #479232	; 0x75000
    103c:	534f2f69 	movtpl	r2, #65385	; 0xff69
    1040:	6d65732f 	stclvs	3, cr7, [r5, #-188]!	; 0xffffff44
    1044:	72747365 	rsbsvc	r7, r4, #-1811939327	; 0x94000001
    1048:	616b6c61 	cmnvs	fp, r1, ror #24
    104c:	76696b2d 	strbtvc	r6, [r9], -sp, lsr #22
    1050:	2f736f2d 	svccs	0x00736f2d
    1054:	72756f73 	rsbsvc	r6, r5, #460	; 0x1cc
    1058:	2f736563 	svccs	0x00736563
    105c:	6c647473 	cfstrdvs	mvd7, [r4], #-460	; 0xfffffe34
    1060:	732f6269 			; <UNDEFINED> instruction: 0x732f6269
    1064:	732f6372 			; <UNDEFINED> instruction: 0x732f6372
    1068:	69666474 	stmdbvs	r6!, {r2, r4, r5, r6, sl, sp, lr}^
    106c:	632e656c 			; <UNDEFINED> instruction: 0x632e656c
    1070:	5f007070 	svcpl	0x00007070
    1074:	6c73355a 	cfldr64vs	mvdx3, [r3], #-360	; 0xfffffe98
    1078:	6a706565 	bvs	1c1a614 <__bss_end+0x1c10c14>
    107c:	6966006a 	stmdbvs	r6!, {r1, r3, r5, r6}^
    1080:	4700656c 	strmi	r6, [r0, -ip, ror #10]
    1084:	525f7465 	subspl	r7, pc, #1694498816	; 0x65000000
    1088:	69616d65 	stmdbvs	r1!, {r0, r2, r5, r6, r8, sl, fp, sp, lr}^
    108c:	676e696e 	strbvs	r6, [lr, -lr, ror #18]!
    1090:	325a5f00 	subscc	r5, sl, #0, 30
    1094:	74656736 	strbtvc	r6, [r5], #-1846	; 0xfffff8ca
    1098:	7361745f 	cmnvc	r1, #1593835520	; 0x5f000000
    109c:	69745f6b 	ldmdbvs	r4!, {r0, r1, r3, r5, r6, r8, r9, sl, fp, ip, lr}^
    10a0:	5f736b63 	svcpl	0x00736b63
    10a4:	645f6f74 	ldrbvs	r6, [pc], #-3956	; 10ac <shift+0x10ac>
    10a8:	6c646165 	stfvse	f6, [r4], #-404	; 0xfffffe6c
    10ac:	76656e69 	strbtvc	r6, [r5], -r9, ror #28
    10b0:	57534e00 	ldrbpl	r4, [r3, -r0, lsl #28]
    10b4:	65525f49 	ldrbvs	r5, [r2, #-3913]	; 0xfffff0b7
    10b8:	746c7573 	strbtvc	r7, [ip], #-1395	; 0xfffffa8d
    10bc:	646f435f 	strbtvs	r4, [pc], #-863	; 10c4 <shift+0x10c4>
    10c0:	72770065 	rsbsvc	r0, r7, #101	; 0x65
    10c4:	006d756e 	rsbeq	r7, sp, lr, ror #10
    10c8:	77345a5f 			; <UNDEFINED> instruction: 0x77345a5f
    10cc:	6a746961 	bvs	1d1b658 <__bss_end+0x1d11c58>
    10d0:	5f006a6a 	svcpl	0x00006a6a
    10d4:	6f69355a 	svcvs	0x0069355a
    10d8:	6a6c7463 	bvs	1b1e26c <__bss_end+0x1b1486c>
    10dc:	494e3631 	stmdbmi	lr, {r0, r4, r5, r9, sl, ip, sp}^
    10e0:	6c74434f 	ldclvs	3, cr4, [r4], #-316	; 0xfffffec4
    10e4:	65704f5f 	ldrbvs	r4, [r0, #-3935]!	; 0xfffff0a1
    10e8:	69746172 	ldmdbvs	r4!, {r1, r4, r5, r6, r8, sp, lr}^
    10ec:	76506e6f 	ldrbvc	r6, [r0], -pc, ror #28
    10f0:	636f6900 	cmnvs	pc, #0, 18
    10f4:	72006c74 	andvc	r6, r0, #116, 24	; 0x7400
    10f8:	6e637465 	cdpvs	4, 6, cr7, cr3, cr5, {3}
    10fc:	6f6e0074 	svcvs	0x006e0074
    1100:	79666974 	stmdbvc	r6!, {r2, r4, r5, r6, r8, fp, sp, lr}^
    1104:	72657400 	rsbvc	r7, r5, #0, 8
    1108:	616e696d 	cmnvs	lr, sp, ror #18
    110c:	6d006574 	cfstr32vs	mvfx6, [r0, #-464]	; 0xfffffe30
    1110:	0065646f 	rsbeq	r6, r5, pc, ror #8
    1114:	66667562 	strbtvs	r7, [r6], -r2, ror #10
    1118:	5f007265 	svcpl	0x00007265
    111c:	6572345a 	ldrbvs	r3, [r2, #-1114]!	; 0xfffffba6
    1120:	506a6461 	rsbpl	r6, sl, r1, ror #8
    1124:	47006a63 	strmi	r6, [r0, -r3, ror #20]
    1128:	4320554e 			; <UNDEFINED> instruction: 0x4320554e
    112c:	34312b2b 	ldrtcc	r2, [r1], #-2859	; 0xfffff4d5
    1130:	2e303120 	rsfcssp	f3, f0, f0
    1134:	20312e33 	eorscs	r2, r1, r3, lsr lr
    1138:	31323032 	teqcc	r2, r2, lsr r0
    113c:	34323830 	ldrtcc	r3, [r2], #-2096	; 0xfffff7d0
    1140:	65722820 	ldrbvs	r2, [r2, #-2080]!	; 0xfffff7e0
    1144:	7361656c 	cmnvc	r1, #108, 10	; 0x1b000000
    1148:	2d202965 			; <UNDEFINED> instruction: 0x2d202965
    114c:	6f6c666d 	svcvs	0x006c666d
    1150:	612d7461 			; <UNDEFINED> instruction: 0x612d7461
    1154:	683d6962 	ldmdavs	sp!, {r1, r5, r6, r8, fp, sp, lr}
    1158:	20647261 	rsbcs	r7, r4, r1, ror #4
    115c:	70666d2d 	rsbvc	r6, r6, sp, lsr #26
    1160:	66763d75 			; <UNDEFINED> instruction: 0x66763d75
    1164:	6d2d2070 	stcvs	0, cr2, [sp, #-448]!	; 0xfffffe40
    1168:	616f6c66 	cmnvs	pc, r6, ror #24
    116c:	62612d74 	rsbvs	r2, r1, #116, 26	; 0x1d00
    1170:	61683d69 	cmnvs	r8, r9, ror #26
    1174:	2d206472 	cfstrscs	mvf6, [r0, #-456]!	; 0xfffffe38
    1178:	7570666d 	ldrbvc	r6, [r0, #-1645]!	; 0xfffff993
    117c:	7066763d 	rsbvc	r7, r6, sp, lsr r6
    1180:	746d2d20 	strbtvc	r2, [sp], #-3360	; 0xfffff2e0
    1184:	3d656e75 	stclcc	14, cr6, [r5, #-468]!	; 0xfffffe2c
    1188:	316d7261 	cmncc	sp, r1, ror #4
    118c:	6a363731 	bvs	d8ee58 <__bss_end+0xd85458>
    1190:	732d667a 			; <UNDEFINED> instruction: 0x732d667a
    1194:	616d2d20 	cmnvs	sp, r0, lsr #26
    1198:	2d206d72 	stccs	13, cr6, [r0, #-456]!	; 0xfffffe38
    119c:	6372616d 	cmnvs	r2, #1073741851	; 0x4000001b
    11a0:	72613d68 	rsbvc	r3, r1, #104, 26	; 0x1a00
    11a4:	7a36766d 	bvc	d9eb60 <__bss_end+0xd95160>
    11a8:	70662b6b 	rsbvc	r2, r6, fp, ror #22
    11ac:	20672d20 	rsbcs	r2, r7, r0, lsr #26
    11b0:	2d20672d 	stccs	7, cr6, [r0, #-180]!	; 0xffffff4c
    11b4:	4f2d2067 	svcmi	0x002d2067
    11b8:	4f2d2030 	svcmi	0x002d2030
    11bc:	662d2030 			; <UNDEFINED> instruction: 0x662d2030
    11c0:	652d6f6e 	strvs	r6, [sp, #-3950]!	; 0xfffff092
    11c4:	70656378 	rsbvc	r6, r5, r8, ror r3
    11c8:	6e6f6974 			; <UNDEFINED> instruction: 0x6e6f6974
    11cc:	662d2073 			; <UNDEFINED> instruction: 0x662d2073
    11d0:	722d6f6e 	eorvc	r6, sp, #440	; 0x1b8
    11d4:	00697474 	rsbeq	r7, r9, r4, ror r4
    11d8:	63746572 	cmnvs	r4, #478150656	; 0x1c800000
    11dc:	0065646f 	rsbeq	r6, r5, pc, ror #8
    11e0:	5f746567 	svcpl	0x00746567
    11e4:	69746361 	ldmdbvs	r4!, {r0, r5, r6, r8, r9, sp, lr}^
    11e8:	705f6576 	subsvc	r6, pc, r6, ror r5	; <UNPREDICTABLE>
    11ec:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
    11f0:	635f7373 	cmpvs	pc, #-872415231	; 0xcc000001
    11f4:	746e756f 	strbtvc	r7, [lr], #-1391	; 0xfffffa91
    11f8:	6c696600 	stclvs	6, cr6, [r9], #-0
    11fc:	6d616e65 	stclvs	14, cr6, [r1, #-404]!	; 0xfffffe6c
    1200:	65720065 	ldrbvs	r0, [r2, #-101]!	; 0xffffff9b
    1204:	67006461 	strvs	r6, [r0, -r1, ror #8]
    1208:	69707465 	ldmdbvs	r0!, {r0, r2, r5, r6, sl, ip, sp, lr}^
    120c:	5a5f0064 	bpl	17c13a4 <__bss_end+0x17b79a4>
    1210:	65706f34 	ldrbvs	r6, [r0, #-3892]!	; 0xfffff0cc
    1214:	634b506e 	movtvs	r5, #45166	; 0xb06e
    1218:	464e3531 			; <UNDEFINED> instruction: 0x464e3531
    121c:	5f656c69 	svcpl	0x00656c69
    1220:	6e65704f 	cdpvs	0, 6, cr7, cr5, cr15, {2}
    1224:	646f4d5f 	strbtvs	r4, [pc], #-3423	; 122c <shift+0x122c>
    1228:	5a5f0065 	bpl	17c13c4 <__bss_end+0x17b79c4>
    122c:	6d656d36 	stclvs	13, cr6, [r5, #-216]!	; 0xffffff28
    1230:	50797063 	rsbspl	r7, r9, r3, rrx
    1234:	7650764b 	ldrbvc	r7, [r0], -fp, asr #12
    1238:	5a5f0069 	bpl	17c13e4 <__bss_end+0x17b79e4>
    123c:	6f746934 	svcvs	0x00746934
    1240:	63506a61 	cmpvs	r0, #397312	; 0x61000
    1244:	7461006a 	strbtvc	r0, [r1], #-106	; 0xffffff96
    1248:	7300696f 	movwvc	r6, #2415	; 0x96f
    124c:	656c7274 	strbvs	r7, [ip, #-628]!	; 0xfffffd8c
    1250:	6f63006e 	svcvs	0x0063006e
    1254:	7461636e 	strbtvc	r6, [r1], #-878	; 0xfffffc92
    1258:	73656400 	cmnvc	r5, #0, 8
    125c:	61620074 	smcvs	8196	; 0x2004
    1260:	69006573 	stmdbvs	r0, {r0, r1, r4, r5, r6, r8, sl, sp, lr}
    1264:	00616f74 	rsbeq	r6, r1, r4, ror pc
    1268:	5f746e69 	svcpl	0x00746e69
    126c:	00727470 	rsbseq	r7, r2, r0, ror r4
    1270:	62355a5f 	eorsvs	r5, r5, #389120	; 0x5f000
    1274:	6f72657a 	svcvs	0x0072657a
    1278:	00697650 	rsbeq	r7, r9, r0, asr r6
    127c:	6e727473 	mrcvs	4, 3, r7, cr2, cr3, {3}
    1280:	00797063 	rsbseq	r7, r9, r3, rrx
    1284:	73375a5f 	teqvc	r7, #389120	; 0x5f000
    1288:	636e7274 	cmnvs	lr, #116, 4	; 0x40000007
    128c:	63507970 	cmpvs	r0, #112, 18	; 0x1c0000
    1290:	69634b50 	stmdbvs	r3!, {r4, r6, r8, r9, fp, lr}^
    1294:	746e6900 	strbtvc	r6, [lr], #-2304	; 0xfffff700
    1298:	7261705f 	rsbvc	r7, r1, #95	; 0x5f
    129c:	72660074 	rsbvc	r0, r6, #116	; 0x74
    12a0:	69746361 	ldmdbvs	r4!, {r0, r5, r6, r8, r9, sp, lr}^
    12a4:	64006e6f 	strvs	r6, [r0], #-3695	; 0xfffff191
    12a8:	74696769 	strbtvc	r6, [r9], #-1897	; 0xfffff897
    12ac:	365a5f00 	ldrbcc	r5, [sl], -r0, lsl #30
    12b0:	636e6f63 	cmnvs	lr, #396	; 0x18c
    12b4:	63507461 	cmpvs	r0, #1627389952	; 0x61000000
    12b8:	00634b50 	rsbeq	r4, r3, r0, asr fp
    12bc:	646d656d 	strbtvs	r6, [sp], #-1389	; 0xfffffa93
    12c0:	43007473 	movwmi	r7, #1139	; 0x473
    12c4:	43726168 	cmnmi	r2, #104, 2
    12c8:	41766e6f 	cmnmi	r6, pc, ror #28
    12cc:	66007272 			; <UNDEFINED> instruction: 0x66007272
    12d0:	00616f74 	rsbeq	r6, r1, r4, ror pc
    12d4:	736d656d 	cmnvc	sp, #457179136	; 0x1b400000
    12d8:	62006372 	andvs	r6, r0, #-939524095	; 0xc8000001
    12dc:	6f72657a 	svcvs	0x0072657a
    12e0:	6d656d00 	stclvs	13, cr6, [r5, #-0]
    12e4:	00797063 	rsbseq	r7, r9, r3, rrx
    12e8:	6e727473 	mrcvs	4, 3, r7, cr2, cr3, {3}
    12ec:	00706d63 	rsbseq	r6, r0, r3, ror #26
    12f0:	69636564 	stmdbvs	r3!, {r2, r5, r6, r8, sl, sp, lr}^
    12f4:	5f6c616d 	svcpl	0x006c616d
    12f8:	63616c70 	cmnvs	r1, #112, 24	; 0x7000
    12fc:	5f007365 	svcpl	0x00007365
    1300:	7461345a 	strbtvc	r3, [r1], #-1114	; 0xfffffba6
    1304:	4b50696f 	blmi	141b8c8 <__bss_end+0x1411ec8>
    1308:	756f0063 	strbvc	r0, [pc, #-99]!	; 12ad <shift+0x12ad>
    130c:	74757074 	ldrbtvc	r7, [r5], #-116	; 0xffffff8c
    1310:	345a5f00 	ldrbcc	r5, [sl], #-3840	; 0xfffff100
    1314:	616f7466 	cmnvs	pc, r6, ror #8
    1318:	6a635066 	bvs	18d54b8 <__bss_end+0x18cbab8>
    131c:	365a5f00 	ldrbcc	r5, [sl], -r0, lsl #30
    1320:	6c727473 	cfldrdvs	mvd7, [r2], #-460	; 0xfffffe34
    1324:	4b506e65 	blmi	141ccc0 <__bss_end+0x14132c0>
    1328:	5a5f0063 	bpl	17c14bc <__bss_end+0x17b7abc>
    132c:	72747337 	rsbsvc	r7, r4, #-603979776	; 0xdc000000
    1330:	706d636e 	rsbvc	r6, sp, lr, ror #6
    1334:	53634b50 	cmnpl	r3, #80, 22	; 0x14000
    1338:	00695f30 	rsbeq	r5, r9, r0, lsr pc
    133c:	5f746e69 	svcpl	0x00746e69
    1340:	00727473 	rsbseq	r7, r2, r3, ror r4
    1344:	6f6d656d 	svcvs	0x006d656d
    1348:	6c007972 			; <UNDEFINED> instruction: 0x6c007972
    134c:	74676e65 	strbtvc	r6, [r7], #-3685	; 0xfffff19b
    1350:	552f0068 	strpl	r0, [pc, #-104]!	; 12f0 <shift+0x12f0>
    1354:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
    1358:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
    135c:	6a726574 	bvs	1c9a934 <__bss_end+0x1c90f34>
    1360:	65442f69 	strbvs	r2, [r4, #-3945]	; 0xfffff097
    1364:	6f746b73 	svcvs	0x00746b73
    1368:	41462f70 	hvcmi	25328	; 0x62f0
    136c:	614e2f56 	cmpvs	lr, r6, asr pc
    1370:	757a6176 	ldrbvc	r6, [sl, #-374]!	; 0xfffffe8a
    1374:	6963696a 	stmdbvs	r3!, {r1, r3, r5, r6, r8, fp, sp, lr}^
    1378:	2f534f2f 	svccs	0x00534f2f
    137c:	656d6573 	strbvs	r6, [sp, #-1395]!	; 0xfffffa8d
    1380:	61727473 	cmnvs	r2, r3, ror r4
    1384:	2d616b6c 	vstmdbcs	r1!, {d22-<overflow reg d75>}
    1388:	2d76696b 			; <UNDEFINED> instruction: 0x2d76696b
    138c:	732f736f 			; <UNDEFINED> instruction: 0x732f736f
    1390:	6372756f 	cmnvs	r2, #465567744	; 0x1bc00000
    1394:	732f7365 			; <UNDEFINED> instruction: 0x732f7365
    1398:	696c6474 	stmdbvs	ip!, {r2, r4, r5, r6, sl, sp, lr}^
    139c:	72732f62 	rsbsvc	r2, r3, #392	; 0x188
    13a0:	74732f63 	ldrbtvc	r2, [r3], #-3939	; 0xfffff09d
    13a4:	72747364 	rsbsvc	r7, r4, #100, 6	; 0x90000001
    13a8:	2e676e69 	cdpcs	14, 6, cr6, cr7, cr9, {3}
    13ac:	00707063 	rsbseq	r7, r0, r3, rrx

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
  20:	8b040e42 	blhi	103930 <__bss_end+0xf9f30>
  24:	0b0d4201 	bleq	350830 <__bss_end+0x346e30>
  28:	420d0d62 	andmi	r0, sp, #6272	; 0x1880
  2c:	00000ecb 	andeq	r0, r0, fp, asr #29
  30:	0000001c 	andeq	r0, r0, ip, lsl r0
  34:	00000000 	andeq	r0, r0, r0
  38:	00008064 	andeq	r8, r0, r4, rrx
  3c:	00000040 	andeq	r0, r0, r0, asr #32
  40:	8b080e42 	blhi	203950 <__bss_end+0x1f9f50>
  44:	42018e02 	andmi	r8, r1, #2, 28
  48:	5a040b0c 	bpl	102c80 <__bss_end+0xf9280>
  4c:	00080d0c 	andeq	r0, r8, ip, lsl #26
  50:	0000000c 	andeq	r0, r0, ip
  54:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
  58:	7c020001 	stcvc	0, cr0, [r2], {1}
  5c:	000d0c0e 	andeq	r0, sp, lr, lsl #24
  60:	0000001c 	andeq	r0, r0, ip, lsl r0
  64:	00000050 	andeq	r0, r0, r0, asr r0
  68:	000080a4 	andeq	r8, r0, r4, lsr #1
  6c:	00000038 	andeq	r0, r0, r8, lsr r0
  70:	8b040e42 	blhi	103980 <__bss_end+0xf9f80>
  74:	0b0d4201 	bleq	350880 <__bss_end+0x346e80>
  78:	420d0d54 	andmi	r0, sp, #84, 26	; 0x1500
  7c:	00000ecb 	andeq	r0, r0, fp, asr #29
  80:	0000001c 	andeq	r0, r0, ip, lsl r0
  84:	00000050 	andeq	r0, r0, r0, asr r0
  88:	000080dc 	ldrdeq	r8, [r0], -ip
  8c:	0000002c 	andeq	r0, r0, ip, lsr #32
  90:	8b040e42 	blhi	1039a0 <__bss_end+0xf9fa0>
  94:	0b0d4201 	bleq	3508a0 <__bss_end+0x346ea0>
  98:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
  9c:	00000ecb 	andeq	r0, r0, fp, asr #29
  a0:	0000001c 	andeq	r0, r0, ip, lsl r0
  a4:	00000050 	andeq	r0, r0, r0, asr r0
  a8:	00008108 	andeq	r8, r0, r8, lsl #2
  ac:	00000020 	andeq	r0, r0, r0, lsr #32
  b0:	8b040e42 	blhi	1039c0 <__bss_end+0xf9fc0>
  b4:	0b0d4201 	bleq	3508c0 <__bss_end+0x346ec0>
  b8:	420d0d48 	andmi	r0, sp, #72, 26	; 0x1200
  bc:	00000ecb 	andeq	r0, r0, fp, asr #29
  c0:	0000001c 	andeq	r0, r0, ip, lsl r0
  c4:	00000050 	andeq	r0, r0, r0, asr r0
  c8:	00008128 	andeq	r8, r0, r8, lsr #2
  cc:	00000018 	andeq	r0, r0, r8, lsl r0
  d0:	8b040e42 	blhi	1039e0 <__bss_end+0xf9fe0>
  d4:	0b0d4201 	bleq	3508e0 <__bss_end+0x346ee0>
  d8:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
  dc:	00000ecb 	andeq	r0, r0, fp, asr #29
  e0:	0000001c 	andeq	r0, r0, ip, lsl r0
  e4:	00000050 	andeq	r0, r0, r0, asr r0
  e8:	00008140 	andeq	r8, r0, r0, asr #2
  ec:	00000018 	andeq	r0, r0, r8, lsl r0
  f0:	8b040e42 	blhi	103a00 <__bss_end+0xfa000>
  f4:	0b0d4201 	bleq	350900 <__bss_end+0x346f00>
  f8:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
  fc:	00000ecb 	andeq	r0, r0, fp, asr #29
 100:	0000001c 	andeq	r0, r0, ip, lsl r0
 104:	00000050 	andeq	r0, r0, r0, asr r0
 108:	00008158 	andeq	r8, r0, r8, asr r1
 10c:	00000018 	andeq	r0, r0, r8, lsl r0
 110:	8b040e42 	blhi	103a20 <__bss_end+0xfa020>
 114:	0b0d4201 	bleq	350920 <__bss_end+0x346f20>
 118:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
 11c:	00000ecb 	andeq	r0, r0, fp, asr #29
 120:	00000014 	andeq	r0, r0, r4, lsl r0
 124:	00000050 	andeq	r0, r0, r0, asr r0
 128:	00008170 	andeq	r8, r0, r0, ror r1
 12c:	0000000c 	andeq	r0, r0, ip
 130:	8b040e42 	blhi	103a40 <__bss_end+0xfa040>
 134:	0b0d4201 	bleq	350940 <__bss_end+0x346f40>
 138:	0000001c 	andeq	r0, r0, ip, lsl r0
 13c:	00000050 	andeq	r0, r0, r0, asr r0
 140:	0000817c 	andeq	r8, r0, ip, ror r1
 144:	00000058 	andeq	r0, r0, r8, asr r0
 148:	8b080e42 	blhi	203a58 <__bss_end+0x1fa058>
 14c:	42018e02 	andmi	r8, r1, #2, 28
 150:	62040b0c 	andvs	r0, r4, #12, 22	; 0x3000
 154:	00080d0c 	andeq	r0, r8, ip, lsl #26
 158:	0000001c 	andeq	r0, r0, ip, lsl r0
 15c:	00000050 	andeq	r0, r0, r0, asr r0
 160:	000081d4 	ldrdeq	r8, [r0], -r4
 164:	00000058 	andeq	r0, r0, r8, asr r0
 168:	8b080e42 	blhi	203a78 <__bss_end+0x1fa078>
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
 194:	000000d0 	ldrdeq	r0, [r0], -r0	; <UNPREDICTABLE>
 198:	840c0e42 	strhi	r0, [ip], #-3650	; 0xfffff1be
 19c:	8e028b03 	vmlahi.f64	d8, d2, d3
 1a0:	0b0c4201 	bleq	3109ac <__bss_end+0x306fac>
 1a4:	0c5a0204 	lfmeq	f0, 2, [sl], {4}
 1a8:	00000c0d 	andeq	r0, r0, sp, lsl #24
 1ac:	00000028 	andeq	r0, r0, r8, lsr #32
 1b0:	00000178 	andeq	r0, r0, r8, ror r1
 1b4:	000082fc 	strdeq	r8, [r0], -ip
 1b8:	000000e8 	andeq	r0, r0, r8, ror #1
 1bc:	841c0e42 	ldrhi	r0, [ip], #-3650	; 0xfffff1be
 1c0:	86068507 	strhi	r8, [r6], -r7, lsl #10
 1c4:	88048705 	stmdahi	r4, {r0, r2, r8, r9, sl, pc}
 1c8:	8e028b03 	vmlahi.f64	d8, d2, d3
 1cc:	0b0c4201 	bleq	3109d8 <__bss_end+0x306fd8>
 1d0:	0c6c0204 	sfmeq	f0, 2, [ip], #-16
 1d4:	00001c0d 	andeq	r1, r0, sp, lsl #24
 1d8:	0000001c 	andeq	r0, r0, ip, lsl r0
 1dc:	00000178 	andeq	r0, r0, r8, ror r1
 1e0:	000083e4 	andeq	r8, r0, r4, ror #7
 1e4:	000000ec 	andeq	r0, r0, ip, ror #1
 1e8:	8b080e42 	blhi	203af8 <__bss_end+0x1fa0f8>
 1ec:	42018e02 	andmi	r8, r1, #2, 28
 1f0:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 1f4:	080d0c6c 	stmdaeq	sp, {r2, r3, r5, r6, sl, fp}
 1f8:	0000001c 	andeq	r0, r0, ip, lsl r0
 1fc:	00000178 	andeq	r0, r0, r8, ror r1
 200:	000084d0 	ldrdeq	r8, [r0], -r0
 204:	000001d0 	ldrdeq	r0, [r0], -r0	; <UNPREDICTABLE>
 208:	8b080e42 	blhi	203b18 <__bss_end+0x1fa118>
 20c:	42018e02 	andmi	r8, r1, #2, 28
 210:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 214:	080d0cd4 	stmdaeq	sp, {r2, r4, r6, r7, sl, fp}
 218:	0000001c 	andeq	r0, r0, ip, lsl r0
 21c:	00000178 	andeq	r0, r0, r8, ror r1
 220:	000086a0 	andeq	r8, r0, r0, lsr #13
 224:	00000114 	andeq	r0, r0, r4, lsl r1
 228:	8b080e42 	blhi	203b38 <__bss_end+0x1fa138>
 22c:	42018e02 	andmi	r8, r1, #2, 28
 230:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 234:	080d0c7a 	stmdaeq	sp, {r1, r3, r4, r5, r6, sl, fp}
 238:	0000001c 	andeq	r0, r0, ip, lsl r0
 23c:	00000178 	andeq	r0, r0, r8, ror r1
 240:	000087b4 			; <UNDEFINED> instruction: 0x000087b4
 244:	000000c0 	andeq	r0, r0, r0, asr #1
 248:	8b080e42 	blhi	203b58 <__bss_end+0x1fa158>
 24c:	42018e02 	andmi	r8, r1, #2, 28
 250:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 254:	080d0c58 	stmdaeq	sp, {r3, r4, r6, sl, fp}
 258:	0000001c 	andeq	r0, r0, ip, lsl r0
 25c:	00000178 	andeq	r0, r0, r8, ror r1
 260:	00008874 	andeq	r8, r0, r4, ror r8
 264:	00000118 	andeq	r0, r0, r8, lsl r1
 268:	8b080e42 	blhi	203b78 <__bss_end+0x1fa178>
 26c:	42018e02 	andmi	r8, r1, #2, 28
 270:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 274:	080d0c78 	stmdaeq	sp, {r3, r4, r5, r6, sl, fp}
 278:	0000000c 	andeq	r0, r0, ip
 27c:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 280:	7c020001 	stcvc	0, cr0, [r2], {1}
 284:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 288:	0000001c 	andeq	r0, r0, ip, lsl r0
 28c:	00000278 	andeq	r0, r0, r8, ror r2
 290:	0000898c 	andeq	r8, r0, ip, lsl #19
 294:	0000002c 	andeq	r0, r0, ip, lsr #32
 298:	8b040e42 	blhi	103ba8 <__bss_end+0xfa1a8>
 29c:	0b0d4201 	bleq	350aa8 <__bss_end+0x3470a8>
 2a0:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
 2a4:	00000ecb 	andeq	r0, r0, fp, asr #29
 2a8:	0000001c 	andeq	r0, r0, ip, lsl r0
 2ac:	00000278 	andeq	r0, r0, r8, ror r2
 2b0:	000089b8 			; <UNDEFINED> instruction: 0x000089b8
 2b4:	0000002c 	andeq	r0, r0, ip, lsr #32
 2b8:	8b040e42 	blhi	103bc8 <__bss_end+0xfa1c8>
 2bc:	0b0d4201 	bleq	350ac8 <__bss_end+0x3470c8>
 2c0:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
 2c4:	00000ecb 	andeq	r0, r0, fp, asr #29
 2c8:	0000001c 	andeq	r0, r0, ip, lsl r0
 2cc:	00000278 	andeq	r0, r0, r8, ror r2
 2d0:	000089e4 	andeq	r8, r0, r4, ror #19
 2d4:	0000001c 	andeq	r0, r0, ip, lsl r0
 2d8:	8b040e42 	blhi	103be8 <__bss_end+0xfa1e8>
 2dc:	0b0d4201 	bleq	350ae8 <__bss_end+0x3470e8>
 2e0:	420d0d46 	andmi	r0, sp, #4480	; 0x1180
 2e4:	00000ecb 	andeq	r0, r0, fp, asr #29
 2e8:	0000001c 	andeq	r0, r0, ip, lsl r0
 2ec:	00000278 	andeq	r0, r0, r8, ror r2
 2f0:	00008a00 	andeq	r8, r0, r0, lsl #20
 2f4:	00000044 	andeq	r0, r0, r4, asr #32
 2f8:	8b040e42 	blhi	103c08 <__bss_end+0xfa208>
 2fc:	0b0d4201 	bleq	350b08 <__bss_end+0x347108>
 300:	420d0d5a 	andmi	r0, sp, #5760	; 0x1680
 304:	00000ecb 	andeq	r0, r0, fp, asr #29
 308:	0000001c 	andeq	r0, r0, ip, lsl r0
 30c:	00000278 	andeq	r0, r0, r8, ror r2
 310:	00008a44 	andeq	r8, r0, r4, asr #20
 314:	00000050 	andeq	r0, r0, r0, asr r0
 318:	8b040e42 	blhi	103c28 <__bss_end+0xfa228>
 31c:	0b0d4201 	bleq	350b28 <__bss_end+0x347128>
 320:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 324:	00000ecb 	andeq	r0, r0, fp, asr #29
 328:	0000001c 	andeq	r0, r0, ip, lsl r0
 32c:	00000278 	andeq	r0, r0, r8, ror r2
 330:	00008a94 	muleq	r0, r4, sl
 334:	00000050 	andeq	r0, r0, r0, asr r0
 338:	8b040e42 	blhi	103c48 <__bss_end+0xfa248>
 33c:	0b0d4201 	bleq	350b48 <__bss_end+0x347148>
 340:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 344:	00000ecb 	andeq	r0, r0, fp, asr #29
 348:	0000001c 	andeq	r0, r0, ip, lsl r0
 34c:	00000278 	andeq	r0, r0, r8, ror r2
 350:	00008ae4 	andeq	r8, r0, r4, ror #21
 354:	0000002c 	andeq	r0, r0, ip, lsr #32
 358:	8b040e42 	blhi	103c68 <__bss_end+0xfa268>
 35c:	0b0d4201 	bleq	350b68 <__bss_end+0x347168>
 360:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
 364:	00000ecb 	andeq	r0, r0, fp, asr #29
 368:	0000001c 	andeq	r0, r0, ip, lsl r0
 36c:	00000278 	andeq	r0, r0, r8, ror r2
 370:	00008b10 	andeq	r8, r0, r0, lsl fp
 374:	00000050 	andeq	r0, r0, r0, asr r0
 378:	8b040e42 	blhi	103c88 <__bss_end+0xfa288>
 37c:	0b0d4201 	bleq	350b88 <__bss_end+0x347188>
 380:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 384:	00000ecb 	andeq	r0, r0, fp, asr #29
 388:	0000001c 	andeq	r0, r0, ip, lsl r0
 38c:	00000278 	andeq	r0, r0, r8, ror r2
 390:	00008b60 	andeq	r8, r0, r0, ror #22
 394:	00000044 	andeq	r0, r0, r4, asr #32
 398:	8b040e42 	blhi	103ca8 <__bss_end+0xfa2a8>
 39c:	0b0d4201 	bleq	350ba8 <__bss_end+0x3471a8>
 3a0:	420d0d5a 	andmi	r0, sp, #5760	; 0x1680
 3a4:	00000ecb 	andeq	r0, r0, fp, asr #29
 3a8:	0000001c 	andeq	r0, r0, ip, lsl r0
 3ac:	00000278 	andeq	r0, r0, r8, ror r2
 3b0:	00008ba4 	andeq	r8, r0, r4, lsr #23
 3b4:	00000050 	andeq	r0, r0, r0, asr r0
 3b8:	8b040e42 	blhi	103cc8 <__bss_end+0xfa2c8>
 3bc:	0b0d4201 	bleq	350bc8 <__bss_end+0x3471c8>
 3c0:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 3c4:	00000ecb 	andeq	r0, r0, fp, asr #29
 3c8:	0000001c 	andeq	r0, r0, ip, lsl r0
 3cc:	00000278 	andeq	r0, r0, r8, ror r2
 3d0:	00008bf4 	strdeq	r8, [r0], -r4
 3d4:	00000054 	andeq	r0, r0, r4, asr r0
 3d8:	8b040e42 	blhi	103ce8 <__bss_end+0xfa2e8>
 3dc:	0b0d4201 	bleq	350be8 <__bss_end+0x3471e8>
 3e0:	420d0d62 	andmi	r0, sp, #6272	; 0x1880
 3e4:	00000ecb 	andeq	r0, r0, fp, asr #29
 3e8:	0000001c 	andeq	r0, r0, ip, lsl r0
 3ec:	00000278 	andeq	r0, r0, r8, ror r2
 3f0:	00008c48 	andeq	r8, r0, r8, asr #24
 3f4:	0000003c 	andeq	r0, r0, ip, lsr r0
 3f8:	8b040e42 	blhi	103d08 <__bss_end+0xfa308>
 3fc:	0b0d4201 	bleq	350c08 <__bss_end+0x347208>
 400:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 404:	00000ecb 	andeq	r0, r0, fp, asr #29
 408:	0000001c 	andeq	r0, r0, ip, lsl r0
 40c:	00000278 	andeq	r0, r0, r8, ror r2
 410:	00008c84 	andeq	r8, r0, r4, lsl #25
 414:	0000003c 	andeq	r0, r0, ip, lsr r0
 418:	8b040e42 	blhi	103d28 <__bss_end+0xfa328>
 41c:	0b0d4201 	bleq	350c28 <__bss_end+0x347228>
 420:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 424:	00000ecb 	andeq	r0, r0, fp, asr #29
 428:	0000001c 	andeq	r0, r0, ip, lsl r0
 42c:	00000278 	andeq	r0, r0, r8, ror r2
 430:	00008cc0 	andeq	r8, r0, r0, asr #25
 434:	0000003c 	andeq	r0, r0, ip, lsr r0
 438:	8b040e42 	blhi	103d48 <__bss_end+0xfa348>
 43c:	0b0d4201 	bleq	350c48 <__bss_end+0x347248>
 440:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 444:	00000ecb 	andeq	r0, r0, fp, asr #29
 448:	0000001c 	andeq	r0, r0, ip, lsl r0
 44c:	00000278 	andeq	r0, r0, r8, ror r2
 450:	00008cfc 	strdeq	r8, [r0], -ip
 454:	0000003c 	andeq	r0, r0, ip, lsr r0
 458:	8b040e42 	blhi	103d68 <__bss_end+0xfa368>
 45c:	0b0d4201 	bleq	350c68 <__bss_end+0x347268>
 460:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 464:	00000ecb 	andeq	r0, r0, fp, asr #29
 468:	0000001c 	andeq	r0, r0, ip, lsl r0
 46c:	00000278 	andeq	r0, r0, r8, ror r2
 470:	00008d38 	andeq	r8, r0, r8, lsr sp
 474:	000000b0 	strheq	r0, [r0], -r0	; <UNPREDICTABLE>
 478:	8b080e42 	blhi	203d88 <__bss_end+0x1fa388>
 47c:	42018e02 	andmi	r8, r1, #2, 28
 480:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 484:	080d0c50 	stmdaeq	sp, {r4, r6, sl, fp}
 488:	0000000c 	andeq	r0, r0, ip
 48c:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 490:	7c020001 	stcvc	0, cr0, [r2], {1}
 494:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 498:	0000001c 	andeq	r0, r0, ip, lsl r0
 49c:	00000488 	andeq	r0, r0, r8, lsl #9
 4a0:	00008de8 	andeq	r8, r0, r8, ror #27
 4a4:	00000174 	andeq	r0, r0, r4, ror r1
 4a8:	8b080e42 	blhi	203db8 <__bss_end+0x1fa3b8>
 4ac:	42018e02 	andmi	r8, r1, #2, 28
 4b0:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 4b4:	080d0cb2 	stmdaeq	sp, {r1, r4, r5, r7, sl, fp}
 4b8:	0000001c 	andeq	r0, r0, ip, lsl r0
 4bc:	00000488 	andeq	r0, r0, r8, lsl #9
 4c0:	00008f5c 	andeq	r8, r0, ip, asr pc
 4c4:	0000009c 	muleq	r0, ip, r0
 4c8:	8b040e42 	blhi	103dd8 <__bss_end+0xfa3d8>
 4cc:	0b0d4201 	bleq	350cd8 <__bss_end+0x3472d8>
 4d0:	0d0d4602 	stceq	6, cr4, [sp, #-8]
 4d4:	000ecb42 	andeq	ip, lr, r2, asr #22
 4d8:	00000020 	andeq	r0, r0, r0, lsr #32
 4dc:	00000488 	andeq	r0, r0, r8, lsl #9
 4e0:	00008ff8 	strdeq	r8, [r0], -r8	; <UNPREDICTABLE>
 4e4:	00000294 	muleq	r0, r4, r2
 4e8:	8b040e42 	blhi	103df8 <__bss_end+0xfa3f8>
 4ec:	0b0d4201 	bleq	350cf8 <__bss_end+0x3472f8>
 4f0:	0d013e03 	stceq	14, cr3, [r1, #-12]
 4f4:	0ecb420d 	cdpeq	2, 12, cr4, cr11, cr13, {0}
 4f8:	00000000 	andeq	r0, r0, r0
 4fc:	0000001c 	andeq	r0, r0, ip, lsl r0
 500:	00000488 	andeq	r0, r0, r8, lsl #9
 504:	0000928c 	andeq	r9, r0, ip, lsl #5
 508:	000000c0 	andeq	r0, r0, r0, asr #1
 50c:	8b040e42 	blhi	103e1c <__bss_end+0xfa41c>
 510:	0b0d4201 	bleq	350d1c <__bss_end+0x34731c>
 514:	0d0d5802 	stceq	8, cr5, [sp, #-8]
 518:	000ecb42 	andeq	ip, lr, r2, asr #22
 51c:	0000001c 	andeq	r0, r0, ip, lsl r0
 520:	00000488 	andeq	r0, r0, r8, lsl #9
 524:	0000934c 	andeq	r9, r0, ip, asr #6
 528:	000000ac 	andeq	r0, r0, ip, lsr #1
 52c:	8b040e42 	blhi	103e3c <__bss_end+0xfa43c>
 530:	0b0d4201 	bleq	350d3c <__bss_end+0x34733c>
 534:	0d0d4e02 	stceq	14, cr4, [sp, #-8]
 538:	000ecb42 	andeq	ip, lr, r2, asr #22
 53c:	0000001c 	andeq	r0, r0, ip, lsl r0
 540:	00000488 	andeq	r0, r0, r8, lsl #9
 544:	000093f8 	strdeq	r9, [r0], -r8
 548:	00000054 	andeq	r0, r0, r4, asr r0
 54c:	8b040e42 	blhi	103e5c <__bss_end+0xfa45c>
 550:	0b0d4201 	bleq	350d5c <__bss_end+0x34735c>
 554:	420d0d62 	andmi	r0, sp, #6272	; 0x1880
 558:	00000ecb 	andeq	r0, r0, fp, asr #29
 55c:	0000001c 	andeq	r0, r0, ip, lsl r0
 560:	00000488 	andeq	r0, r0, r8, lsl #9
 564:	0000944c 	andeq	r9, r0, ip, asr #8
 568:	00000068 	andeq	r0, r0, r8, rrx
 56c:	8b040e42 	blhi	103e7c <__bss_end+0xfa47c>
 570:	0b0d4201 	bleq	350d7c <__bss_end+0x34737c>
 574:	420d0d6c 	andmi	r0, sp, #108, 26	; 0x1b00
 578:	00000ecb 	andeq	r0, r0, fp, asr #29
 57c:	0000001c 	andeq	r0, r0, ip, lsl r0
 580:	00000488 	andeq	r0, r0, r8, lsl #9
 584:	000094b4 			; <UNDEFINED> instruction: 0x000094b4
 588:	00000080 	andeq	r0, r0, r0, lsl #1
 58c:	8b040e42 	blhi	103e9c <__bss_end+0xfa49c>
 590:	0b0d4201 	bleq	350d9c <__bss_end+0x34739c>
 594:	420d0d78 	andmi	r0, sp, #120, 26	; 0x1e00
 598:	00000ecb 	andeq	r0, r0, fp, asr #29
 59c:	0000001c 	andeq	r0, r0, ip, lsl r0
 5a0:	00000488 	andeq	r0, r0, r8, lsl #9
 5a4:	00009534 	andeq	r9, r0, r4, lsr r5
 5a8:	00000074 	andeq	r0, r0, r4, ror r0
 5ac:	8b080e42 	blhi	203ebc <__bss_end+0x1fa4bc>
 5b0:	42018e02 	andmi	r8, r1, #2, 28
 5b4:	74040b0c 	strvc	r0, [r4], #-2828	; 0xfffff4f4
 5b8:	00080d0c 	andeq	r0, r8, ip, lsl #26
 5bc:	0000000c 	andeq	r0, r0, ip
 5c0:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 5c4:	7c010001 	stcvc	0, cr0, [r1], {1}
 5c8:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 5cc:	0000000c 	andeq	r0, r0, ip
 5d0:	000005bc 			; <UNDEFINED> instruction: 0x000005bc
 5d4:	000095a8 	andeq	r9, r0, r8, lsr #11
 5d8:	000001ec 	andeq	r0, r0, ip, ror #3
