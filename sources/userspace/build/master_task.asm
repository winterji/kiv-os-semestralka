
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
    805c:	00009cf0 	strdeq	r9, [r0], -r0
    8060:	00009d8c 	andeq	r9, r0, ip, lsl #27

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
    8080:	eb0002a7 	bl	8b24 <main>
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
    81cc:	00009ce8 	andeq	r9, r0, r8, ror #25
    81d0:	00009ce8 	andeq	r9, r0, r8, ror #25

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
    8224:	00009ce8 	andeq	r9, r0, r8, ror #25
    8228:	00009ce8 	andeq	r9, r0, r8, ror #25

0000822c <_Z8prep_msgPcPKc>:
_Z8prep_msgPcPKc():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:28
float prev_value = random_values[0];

float received_values[32];
uint32_t received_values_len = 0;

void prep_msg(char* buff, const char* msg) {
    822c:	e92d4810 	push	{r4, fp, lr}
    8230:	e28db008 	add	fp, sp, #8
    8234:	e24dd00c 	sub	sp, sp, #12
    8238:	e50b0010 	str	r0, [fp, #-16]
    823c:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:29
    switch (agreed_role)
    8240:	e59f3080 	ldr	r3, [pc, #128]	; 82c8 <_Z8prep_msgPcPKc+0x9c>
    8244:	e5933000 	ldr	r3, [r3]
    8248:	e3530000 	cmp	r3, #0
    824c:	0a000002 	beq	825c <_Z8prep_msgPcPKc+0x30>
    8250:	e3530001 	cmp	r3, #1
    8254:	0a000005 	beq	8270 <_Z8prep_msgPcPKc+0x44>
    8258:	ea000009 	b	8284 <_Z8prep_msgPcPKc+0x58>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:32
    {
    case CI2C_Mode::Master:
        strncpy(buff, "MASTER: ", 8);
    825c:	e3a02008 	mov	r2, #8
    8260:	e59f1064 	ldr	r1, [pc, #100]	; 82cc <_Z8prep_msgPcPKc+0xa0>
    8264:	e51b0010 	ldr	r0, [fp, #-16]
    8268:	eb0004cc 	bl	95a0 <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:33
        break;
    826c:	ea000009 	b	8298 <_Z8prep_msgPcPKc+0x6c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:35
    case CI2C_Mode::Slave:
        strncpy(buff, "SLAVE: ", 7);
    8270:	e3a02007 	mov	r2, #7
    8274:	e59f1054 	ldr	r1, [pc, #84]	; 82d0 <_Z8prep_msgPcPKc+0xa4>
    8278:	e51b0010 	ldr	r0, [fp, #-16]
    827c:	eb0004c7 	bl	95a0 <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:36
        break;
    8280:	ea000004 	b	8298 <_Z8prep_msgPcPKc+0x6c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:38
    default:
        strncpy(buff, "UNSET: ", 7);
    8284:	e3a02007 	mov	r2, #7
    8288:	e59f1044 	ldr	r1, [pc, #68]	; 82d4 <_Z8prep_msgPcPKc+0xa8>
    828c:	e51b0010 	ldr	r0, [fp, #-16]
    8290:	eb0004c2 	bl	95a0 <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:39
        break;
    8294:	e320f000 	nop	{0}
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:42
    }
    
    strncpy(buff + 7, msg, strlen(msg));
    8298:	e51b3010 	ldr	r3, [fp, #-16]
    829c:	e2834007 	add	r4, r3, #7
    82a0:	e51b0014 	ldr	r0, [fp, #-20]	; 0xffffffec
    82a4:	eb000518 	bl	970c <_Z6strlenPKc>
    82a8:	e1a03000 	mov	r3, r0
    82ac:	e1a02003 	mov	r2, r3
    82b0:	e51b1014 	ldr	r1, [fp, #-20]	; 0xffffffec
    82b4:	e1a00004 	mov	r0, r4
    82b8:	eb0004b8 	bl	95a0 <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:43
}
    82bc:	e320f000 	nop	{0}
    82c0:	e24bd008 	sub	sp, fp, #8
    82c4:	e8bd8810 	pop	{r4, fp, pc}
    82c8:	00009ce8 	andeq	r9, r0, r8, ror #25
    82cc:	00009b6c 	andeq	r9, r0, ip, ror #22
    82d0:	00009b78 	andeq	r9, r0, r8, ror fp
    82d4:	00009b80 	andeq	r9, r0, r0, lsl #23

000082d8 <_Z3logPKc>:
_Z3logPKc():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:46

void log(const char* msg)
{
    82d8:	e92d49f0 	push	{r4, r5, r6, r7, r8, fp, lr}
    82dc:	e28db018 	add	fp, sp, #24
    82e0:	e24dd014 	sub	sp, sp, #20
    82e4:	e50b0028 	str	r0, [fp, #-40]	; 0xffffffd8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:49
    char new_buff[strlen(msg) + 7];
    prep_msg(new_buff, msg);
    write(log_fd, new_buff, strlen(msg)+7);
    82e8:	e1a0300d 	mov	r3, sp
    82ec:	e1a08003 	mov	r8, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:47
    char new_buff[strlen(msg) + 7];
    82f0:	e51b0028 	ldr	r0, [fp, #-40]	; 0xffffffd8
    82f4:	eb000504 	bl	970c <_Z6strlenPKc>
    82f8:	e1a03000 	mov	r3, r0
    82fc:	e2831006 	add	r1, r3, #6
    8300:	e50b1020 	str	r1, [fp, #-32]	; 0xffffffe0
    8304:	e1a03001 	mov	r3, r1
    8308:	e2833001 	add	r3, r3, #1
    830c:	e3a02000 	mov	r2, #0
    8310:	e1a06003 	mov	r6, r3
    8314:	e1a07002 	mov	r7, r2
    8318:	e3a02000 	mov	r2, #0
    831c:	e3a03000 	mov	r3, #0
    8320:	e1a03187 	lsl	r3, r7, #3
    8324:	e1833ea6 	orr	r3, r3, r6, lsr #29
    8328:	e1a02186 	lsl	r2, r6, #3
    832c:	e1a03001 	mov	r3, r1
    8330:	e2833001 	add	r3, r3, #1
    8334:	e3a02000 	mov	r2, #0
    8338:	e1a04003 	mov	r4, r3
    833c:	e1a05002 	mov	r5, r2
    8340:	e3a02000 	mov	r2, #0
    8344:	e3a03000 	mov	r3, #0
    8348:	e1a03185 	lsl	r3, r5, #3
    834c:	e1833ea4 	orr	r3, r3, r4, lsr #29
    8350:	e1a02184 	lsl	r2, r4, #3
    8354:	e1a03001 	mov	r3, r1
    8358:	e2833001 	add	r3, r3, #1
    835c:	e2833007 	add	r3, r3, #7
    8360:	e1a031a3 	lsr	r3, r3, #3
    8364:	e1a03183 	lsl	r3, r3, #3
    8368:	e04dd003 	sub	sp, sp, r3
    836c:	e1a0300d 	mov	r3, sp
    8370:	e2833000 	add	r3, r3, #0
    8374:	e50b3024 	str	r3, [fp, #-36]	; 0xffffffdc
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:48
    prep_msg(new_buff, msg);
    8378:	e51b1028 	ldr	r1, [fp, #-40]	; 0xffffffd8
    837c:	e51b0024 	ldr	r0, [fp, #-36]	; 0xffffffdc
    8380:	ebffffa9 	bl	822c <_Z8prep_msgPcPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:49
    write(log_fd, new_buff, strlen(msg)+7);
    8384:	e59f3030 	ldr	r3, [pc, #48]	; 83bc <_Z3logPKc+0xe4>
    8388:	e5934000 	ldr	r4, [r3]
    838c:	e51b0028 	ldr	r0, [fp, #-40]	; 0xffffffd8
    8390:	eb0004dd 	bl	970c <_Z6strlenPKc>
    8394:	e1a03000 	mov	r3, r0
    8398:	e2833007 	add	r3, r3, #7
    839c:	e1a02003 	mov	r2, r3
    83a0:	e51b1024 	ldr	r1, [fp, #-36]	; 0xffffffdc
    83a4:	e1a00004 	mov	r0, r4
    83a8:	eb00027e 	bl	8da8 <_Z5writejPKcj>
    83ac:	e1a0d008 	mov	sp, r8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:50
}
    83b0:	e320f000 	nop	{0}
    83b4:	e24bd018 	sub	sp, fp, #24
    83b8:	e8bd89f0 	pop	{r4, r5, r6, r7, r8, fp, pc}
    83bc:	00009cf0 	strdeq	r9, [r0], -r0

000083c0 <_Z3logj>:
_Z3logj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:52

void log(const uint32_t value) {
    83c0:	e92d4810 	push	{r4, fp, lr}
    83c4:	e28db008 	add	fp, sp, #8
    83c8:	e24dd04c 	sub	sp, sp, #76	; 0x4c
    83cc:	e50b0050 	str	r0, [fp, #-80]	; 0xffffffb0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:54
    char buff[32], pom[32];
    itoa(value, pom, 10);
    83d0:	e24b304c 	sub	r3, fp, #76	; 0x4c
    83d4:	e3a0200a 	mov	r2, #10
    83d8:	e1a01003 	mov	r1, r3
    83dc:	e51b0050 	ldr	r0, [fp, #-80]	; 0xffffffb0
    83e0:	eb000345 	bl	90fc <_Z4itoajPcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:55
    prep_msg(buff, pom);
    83e4:	e24b204c 	sub	r2, fp, #76	; 0x4c
    83e8:	e24b302c 	sub	r3, fp, #44	; 0x2c
    83ec:	e1a01002 	mov	r1, r2
    83f0:	e1a00003 	mov	r0, r3
    83f4:	ebffff8c 	bl	822c <_Z8prep_msgPcPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:56
    write(log_fd, buff, strlen(buff));
    83f8:	e59f3030 	ldr	r3, [pc, #48]	; 8430 <_Z3logj+0x70>
    83fc:	e5934000 	ldr	r4, [r3]
    8400:	e24b302c 	sub	r3, fp, #44	; 0x2c
    8404:	e1a00003 	mov	r0, r3
    8408:	eb0004bf 	bl	970c <_Z6strlenPKc>
    840c:	e1a03000 	mov	r3, r0
    8410:	e1a02003 	mov	r2, r3
    8414:	e24b302c 	sub	r3, fp, #44	; 0x2c
    8418:	e1a01003 	mov	r1, r3
    841c:	e1a00004 	mov	r0, r4
    8420:	eb000260 	bl	8da8 <_Z5writejPKcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:57
}
    8424:	e320f000 	nop	{0}
    8428:	e24bd008 	sub	sp, fp, #8
    842c:	e8bd8810 	pop	{r4, fp, pc}
    8430:	00009cf0 	strdeq	r9, [r0], -r0

00008434 <_Z9send_dataf>:
_Z9send_dataf():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:60

void send_data(const float value)
{
    8434:	e92d4800 	push	{fp, lr}
    8438:	e28db004 	add	fp, sp, #4
    843c:	e24dd018 	sub	sp, sp, #24
    8440:	ed0b0a06 	vstr	s0, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:61
    float next_predict = -1.0f;
    8444:	e59f30d8 	ldr	r3, [pc, #216]	; 8524 <_Z9send_dataf+0xf0>
    8448:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:63
    char msg[6];
    if (value < LOWER_BOUND || value > UPPER_BOUND)
    844c:	ed5b7a06 	vldr	s15, [fp, #-24]	; 0xffffffe8
    8450:	ed9f7a31 	vldr	s14, [pc, #196]	; 851c <_Z9send_dataf+0xe8>
    8454:	eef47ac7 	vcmpe.f32	s15, s14
    8458:	eef1fa10 	vmrs	APSR_nzcv, fpscr
    845c:	4a000004 	bmi	8474 <_Z9send_dataf+0x40>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:63 (discriminator 1)
    8460:	ed5b7a06 	vldr	s15, [fp, #-24]	; 0xffffffe8
    8464:	ed9f7a2d 	vldr	s14, [pc, #180]	; 8520 <_Z9send_dataf+0xec>
    8468:	eef47ac7 	vcmpe.f32	s15, s14
    846c:	eef1fa10 	vmrs	APSR_nzcv, fpscr
    8470:	da000002 	ble	8480 <_Z9send_dataf+0x4c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:64
        msg[0] = 'd';
    8474:	e3a03064 	mov	r3, #100	; 0x64
    8478:	e54b3010 	strb	r3, [fp, #-16]
    847c:	ea000015 	b	84d8 <_Z9send_dataf+0xa4>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:67
    else {
        // doplnit vypocet trendu
        next_predict = value + (value - prev_value);
    8480:	ed1b7a06 	vldr	s14, [fp, #-24]	; 0xffffffe8
    8484:	e59f309c 	ldr	r3, [pc, #156]	; 8528 <_Z9send_dataf+0xf4>
    8488:	edd37a00 	vldr	s15, [r3]
    848c:	ee377a67 	vsub.f32	s14, s14, s15
    8490:	ed5b7a06 	vldr	s15, [fp, #-24]	; 0xffffffe8
    8494:	ee777a27 	vadd.f32	s15, s14, s15
    8498:	ed4b7a02 	vstr	s15, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:68
        if (next_predict < LOWER_BOUND || next_predict > UPPER_BOUND) {
    849c:	ed5b7a02 	vldr	s15, [fp, #-8]
    84a0:	ed9f7a1d 	vldr	s14, [pc, #116]	; 851c <_Z9send_dataf+0xe8>
    84a4:	eef47ac7 	vcmpe.f32	s15, s14
    84a8:	eef1fa10 	vmrs	APSR_nzcv, fpscr
    84ac:	4a000004 	bmi	84c4 <_Z9send_dataf+0x90>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:68 (discriminator 1)
    84b0:	ed5b7a02 	vldr	s15, [fp, #-8]
    84b4:	ed9f7a19 	vldr	s14, [pc, #100]	; 8520 <_Z9send_dataf+0xec>
    84b8:	eef47ac7 	vcmpe.f32	s15, s14
    84bc:	eef1fa10 	vmrs	APSR_nzcv, fpscr
    84c0:	da000002 	ble	84d0 <_Z9send_dataf+0x9c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:69
            msg[0] = 't';
    84c4:	e3a03074 	mov	r3, #116	; 0x74
    84c8:	e54b3010 	strb	r3, [fp, #-16]
    84cc:	ea000001 	b	84d8 <_Z9send_dataf+0xa4>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:72
        }
        else {
            msg[0] = 'v';
    84d0:	e3a03076 	mov	r3, #118	; 0x76
    84d4:	e54b3010 	strb	r3, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:75
        }
    }
    memcpy(&value, msg + 1, 4);
    84d8:	e24b3010 	sub	r3, fp, #16
    84dc:	e2833001 	add	r3, r3, #1
    84e0:	e24b0018 	sub	r0, fp, #24
    84e4:	e3a02004 	mov	r2, #4
    84e8:	e1a01003 	mov	r1, r3
    84ec:	eb0004b5 	bl	97c8 <_Z6memcpyPKvPvi>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:76
    msg[5] = '\0';
    84f0:	e3a03000 	mov	r3, #0
    84f4:	e54b300b 	strb	r3, [fp, #-11]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:77
    write(i2c_fd, msg, 6);
    84f8:	e59f302c 	ldr	r3, [pc, #44]	; 852c <_Z9send_dataf+0xf8>
    84fc:	e5933000 	ldr	r3, [r3]
    8500:	e24b1010 	sub	r1, fp, #16
    8504:	e3a02006 	mov	r2, #6
    8508:	e1a00003 	mov	r0, r3
    850c:	eb000225 	bl	8da8 <_Z5writejPKcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:78
}
    8510:	e320f000 	nop	{0}
    8514:	e24bd004 	sub	sp, fp, #4
    8518:	e8bd8800 	pop	{fp, pc}
    851c:	40600000 	rsbmi	r0, r0, r0
    8520:	41300000 	teqmi	r0, r0
    8524:	bf800000 	svclt	0x00800000
    8528:	00009cec 	andeq	r9, r0, ip, ror #25
    852c:	00009cf4 	strdeq	r9, [r0], -r4

00008530 <_Z10send_valuef>:
_Z10send_valuef():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:80

void send_value(const float value) {
    8530:	e92d4800 	push	{fp, lr}
    8534:	e28db004 	add	fp, sp, #4
    8538:	e24dd030 	sub	sp, sp, #48	; 0x30
    853c:	ed0b0a0c 	vstr	s0, [fp, #-48]	; 0xffffffd0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:82
    char pom[5], buff[32];
    bzero(pom, 5);
    8540:	e24b300c 	sub	r3, fp, #12
    8544:	e3a01005 	mov	r1, #5
    8548:	e1a00003 	mov	r0, r3
    854c:	eb000483 	bl	9760 <_Z5bzeroPvi>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:83
    bzero(buff, 32);
    8550:	e24b302c 	sub	r3, fp, #44	; 0x2c
    8554:	e3a01020 	mov	r1, #32
    8558:	e1a00003 	mov	r0, r3
    855c:	eb00047f 	bl	9760 <_Z5bzeroPvi>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:84
    strncpy(buff, "Sending: ", 15);
    8560:	e24b302c 	sub	r3, fp, #44	; 0x2c
    8564:	e3a0200f 	mov	r2, #15
    8568:	e59f105c 	ldr	r1, [pc, #92]	; 85cc <_Z10send_valuef+0x9c>
    856c:	e1a00003 	mov	r0, r3
    8570:	eb00040a 	bl	95a0 <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:85
    ftoa(value, pom, 2);
    8574:	e24b300c 	sub	r3, fp, #12
    8578:	e3a01002 	mov	r1, #2
    857c:	e1a00003 	mov	r0, r3
    8580:	ed1b0a0c 	vldr	s0, [fp, #-48]	; 0xffffffd0
    8584:	eb000360 	bl	930c <_Z4ftoafPcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:86
    concat(buff, pom);
    8588:	e24b200c 	sub	r2, fp, #12
    858c:	e24b302c 	sub	r3, fp, #44	; 0x2c
    8590:	e1a01002 	mov	r1, r2
    8594:	e1a00003 	mov	r0, r3
    8598:	eb0004aa 	bl	9848 <_Z6concatPcPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:87
    concat(buff, "\n");
    859c:	e24b302c 	sub	r3, fp, #44	; 0x2c
    85a0:	e59f1028 	ldr	r1, [pc, #40]	; 85d0 <_Z10send_valuef+0xa0>
    85a4:	e1a00003 	mov	r0, r3
    85a8:	eb0004a6 	bl	9848 <_Z6concatPcPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:88
    log(buff);
    85ac:	e24b302c 	sub	r3, fp, #44	; 0x2c
    85b0:	e1a00003 	mov	r0, r3
    85b4:	ebffff47 	bl	82d8 <_Z3logPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:89
    send_data(value);
    85b8:	ed1b0a0c 	vldr	s0, [fp, #-48]	; 0xffffffd0
    85bc:	ebffff9c 	bl	8434 <_Z9send_dataf>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:90
}
    85c0:	e320f000 	nop	{0}
    85c4:	e24bd004 	sub	sp, fp, #4
    85c8:	e8bd8800 	pop	{fp, pc}
    85cc:	00009b88 	andeq	r9, r0, r8, lsl #23
    85d0:	00009b94 	muleq	r0, r4, fp

000085d4 <_Z11decide_role9CI2C_ModePc>:
_Z11decide_role9CI2C_ModePc():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:93

CI2C_Mode decide_role(CI2C_Mode my_role, char* other_role_buff)
{
    85d4:	e92d4800 	push	{fp, lr}
    85d8:	e28db004 	add	fp, sp, #4
    85dc:	e24dd010 	sub	sp, sp, #16
    85e0:	e50b0010 	str	r0, [fp, #-16]
    85e4:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:94
    CI2C_Mode other_role = CI2C_Mode::Undefined;
    85e8:	e3a03002 	mov	r3, #2
    85ec:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:95
    if (strncmp(other_role_buff, "mst", 3) == 0)
    85f0:	e3a02003 	mov	r2, #3
    85f4:	e59f10c4 	ldr	r1, [pc, #196]	; 86c0 <_Z11decide_role9CI2C_ModePc+0xec>
    85f8:	e51b0014 	ldr	r0, [fp, #-20]	; 0xffffffec
    85fc:	eb000417 	bl	9660 <_Z7strncmpPKcS0_i>
    8600:	e1a03000 	mov	r3, r0
    8604:	e3530000 	cmp	r3, #0
    8608:	03a03001 	moveq	r3, #1
    860c:	13a03000 	movne	r3, #0
    8610:	e6ef3073 	uxtb	r3, r3
    8614:	e3530000 	cmp	r3, #0
    8618:	0a000002 	beq	8628 <_Z11decide_role9CI2C_ModePc+0x54>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:97
    {
        other_role = CI2C_Mode::Master;
    861c:	e3a03000 	mov	r3, #0
    8620:	e50b3008 	str	r3, [fp, #-8]
    8624:	ea00000c 	b	865c <_Z11decide_role9CI2C_ModePc+0x88>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:99
    }
    else if (strncmp(other_role_buff, "slv", 3) == 0)
    8628:	e3a02003 	mov	r2, #3
    862c:	e59f1090 	ldr	r1, [pc, #144]	; 86c4 <_Z11decide_role9CI2C_ModePc+0xf0>
    8630:	e51b0014 	ldr	r0, [fp, #-20]	; 0xffffffec
    8634:	eb000409 	bl	9660 <_Z7strncmpPKcS0_i>
    8638:	e1a03000 	mov	r3, r0
    863c:	e3530000 	cmp	r3, #0
    8640:	03a03001 	moveq	r3, #1
    8644:	13a03000 	movne	r3, #0
    8648:	e6ef3073 	uxtb	r3, r3
    864c:	e3530000 	cmp	r3, #0
    8650:	0a000001 	beq	865c <_Z11decide_role9CI2C_ModePc+0x88>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:101
    {
        other_role = CI2C_Mode::Slave;
    8654:	e3a03001 	mov	r3, #1
    8658:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:104
    }

    if (my_role == CI2C_Mode::Undefined)
    865c:	e51b3010 	ldr	r3, [fp, #-16]
    8660:	e3530002 	cmp	r3, #2
    8664:	1a000009 	bne	8690 <_Z11decide_role9CI2C_ModePc+0xbc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:106
    {
        if (other_role == CI2C_Mode::Master)
    8668:	e51b3008 	ldr	r3, [fp, #-8]
    866c:	e3530000 	cmp	r3, #0
    8670:	1a000001 	bne	867c <_Z11decide_role9CI2C_ModePc+0xa8>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:108
        {
            return CI2C_Mode::Slave;
    8674:	e3a03001 	mov	r3, #1
    8678:	ea00000d 	b	86b4 <_Z11decide_role9CI2C_ModePc+0xe0>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:110
        }
        else if (other_role == CI2C_Mode::Slave)
    867c:	e51b3008 	ldr	r3, [fp, #-8]
    8680:	e3530001 	cmp	r3, #1
    8684:	1a000009 	bne	86b0 <_Z11decide_role9CI2C_ModePc+0xdc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:112
        {
            return CI2C_Mode::Master;
    8688:	e3a03000 	mov	r3, #0
    868c:	ea000008 	b	86b4 <_Z11decide_role9CI2C_ModePc+0xe0>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:116
        }
    }
    else {
        if (my_role == other_role)
    8690:	e51b2010 	ldr	r2, [fp, #-16]
    8694:	e51b3008 	ldr	r3, [fp, #-8]
    8698:	e1520003 	cmp	r2, r3
    869c:	1a000003 	bne	86b0 <_Z11decide_role9CI2C_ModePc+0xdc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:118
        {
            log("Desired roles are the same\n");
    86a0:	e59f0020 	ldr	r0, [pc, #32]	; 86c8 <_Z11decide_role9CI2C_ModePc+0xf4>
    86a4:	ebffff0b 	bl	82d8 <_Z3logPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:120
            if (ADDRESS < TARGET_ADDRESS)
                return CI2C_Mode::Master;
    86a8:	e3a03000 	mov	r3, #0
    86ac:	ea000000 	b	86b4 <_Z11decide_role9CI2C_ModePc+0xe0>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:125
            else
                return CI2C_Mode::Slave;
        }
    }
    return my_role;
    86b0:	e51b3010 	ldr	r3, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:126
}
    86b4:	e1a00003 	mov	r0, r3
    86b8:	e24bd004 	sub	sp, fp, #4
    86bc:	e8bd8800 	pop	{fp, pc}
    86c0:	00009b98 	muleq	r0, r8, fp
    86c4:	00009b9c 	muleq	r0, ip, fp
    86c8:	00009ba0 	andeq	r9, r0, r0, lsr #23

000086cc <_Z9set_roles9CI2C_Mode>:
_Z9set_roles9CI2C_Mode():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:129

bool set_roles(CI2C_Mode desired_role)
{
    86cc:	e92d4800 	push	{fp, lr}
    86d0:	e28db004 	add	fp, sp, #4
    86d4:	e24dd050 	sub	sp, sp, #80	; 0x50
    86d8:	e50b0050 	str	r0, [fp, #-80]	; 0xffffffb0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:131
    char role[4], buff[32], log_msg[32];
    bzero(role, 4);
    86dc:	e24b3008 	sub	r3, fp, #8
    86e0:	e3a01004 	mov	r1, #4
    86e4:	e1a00003 	mov	r0, r3
    86e8:	eb00041c 	bl	9760 <_Z5bzeroPvi>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:132
    bzero(buff, 32);
    86ec:	e24b3028 	sub	r3, fp, #40	; 0x28
    86f0:	e3a01020 	mov	r1, #32
    86f4:	e1a00003 	mov	r0, r3
    86f8:	eb000418 	bl	9760 <_Z5bzeroPvi>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:133
    bzero(log_msg, 32);
    86fc:	e24b3048 	sub	r3, fp, #72	; 0x48
    8700:	e3a01020 	mov	r1, #32
    8704:	e1a00003 	mov	r0, r3
    8708:	eb000414 	bl	9760 <_Z5bzeroPvi>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:134
    switch (desired_role)
    870c:	e51b3050 	ldr	r3, [fp, #-80]	; 0xffffffb0
    8710:	e3530000 	cmp	r3, #0
    8714:	0a000003 	beq	8728 <_Z9set_roles9CI2C_Mode+0x5c>
    8718:	e51b3050 	ldr	r3, [fp, #-80]	; 0xffffffb0
    871c:	e3530001 	cmp	r3, #1
    8720:	0a000006 	beq	8740 <_Z9set_roles9CI2C_Mode+0x74>
    8724:	ea00000b 	b	8758 <_Z9set_roles9CI2C_Mode+0x8c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:137
    {
    case CI2C_Mode::Master:
        strncpy(role, "mst", 3);
    8728:	e24b3008 	sub	r3, fp, #8
    872c:	e3a02003 	mov	r2, #3
    8730:	e59f1148 	ldr	r1, [pc, #328]	; 8880 <_Z9set_roles9CI2C_Mode+0x1b4>
    8734:	e1a00003 	mov	r0, r3
    8738:	eb000398 	bl	95a0 <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:138
        break;
    873c:	ea00000b 	b	8770 <_Z9set_roles9CI2C_Mode+0xa4>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:140
    case CI2C_Mode::Slave:
        strncpy(role, "slv", 3);
    8740:	e24b3008 	sub	r3, fp, #8
    8744:	e3a02003 	mov	r2, #3
    8748:	e59f1134 	ldr	r1, [pc, #308]	; 8884 <_Z9set_roles9CI2C_Mode+0x1b8>
    874c:	e1a00003 	mov	r0, r3
    8750:	eb000392 	bl	95a0 <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:141
        break;
    8754:	ea000005 	b	8770 <_Z9set_roles9CI2C_Mode+0xa4>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:143
    default:
        strncpy(role, "slv", 3);
    8758:	e24b3008 	sub	r3, fp, #8
    875c:	e3a02003 	mov	r2, #3
    8760:	e59f111c 	ldr	r1, [pc, #284]	; 8884 <_Z9set_roles9CI2C_Mode+0x1b8>
    8764:	e1a00003 	mov	r0, r3
    8768:	eb00038c 	bl	95a0 <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:144
        break;
    876c:	e320f000 	nop	{0}
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:147
    }

    write(i2c_fd, role, 4);
    8770:	e59f3110 	ldr	r3, [pc, #272]	; 8888 <_Z9set_roles9CI2C_Mode+0x1bc>
    8774:	e5933000 	ldr	r3, [r3]
    8778:	e24b1008 	sub	r1, fp, #8
    877c:	e3a02004 	mov	r2, #4
    8780:	e1a00003 	mov	r0, r3
    8784:	eb000187 	bl	8da8 <_Z5writejPKcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:148
    while (strlen(buff) == 0) {
    8788:	e24b3028 	sub	r3, fp, #40	; 0x28
    878c:	e1a00003 	mov	r0, r3
    8790:	eb0003dd 	bl	970c <_Z6strlenPKc>
    8794:	e1a03000 	mov	r3, r0
    8798:	e3530000 	cmp	r3, #0
    879c:	03a03001 	moveq	r3, #1
    87a0:	13a03000 	movne	r3, #0
    87a4:	e6ef3073 	uxtb	r3, r3
    87a8:	e3530000 	cmp	r3, #0
    87ac:	0a000009 	beq	87d8 <_Z9set_roles9CI2C_Mode+0x10c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:149
        read(i2c_fd, buff, 4);
    87b0:	e59f30d0 	ldr	r3, [pc, #208]	; 8888 <_Z9set_roles9CI2C_Mode+0x1bc>
    87b4:	e5933000 	ldr	r3, [r3]
    87b8:	e24b1028 	sub	r1, fp, #40	; 0x28
    87bc:	e3a02004 	mov	r2, #4
    87c0:	e1a00003 	mov	r0, r3
    87c4:	eb000163 	bl	8d58 <_Z4readjPcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:150
        sleep(0x100);
    87c8:	e3e01001 	mvn	r1, #1
    87cc:	e3a00c01 	mov	r0, #256	; 0x100
    87d0:	eb0001cc 	bl	8f08 <_Z5sleepjj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:148
    while (strlen(buff) == 0) {
    87d4:	eaffffeb 	b	8788 <_Z9set_roles9CI2C_Mode+0xbc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:153
    }

    agreed_role = decide_role(desired_role, buff);
    87d8:	e24b3028 	sub	r3, fp, #40	; 0x28
    87dc:	e1a01003 	mov	r1, r3
    87e0:	e51b0050 	ldr	r0, [fp, #-80]	; 0xffffffb0
    87e4:	ebffff7a 	bl	85d4 <_Z11decide_role9CI2C_ModePc>
    87e8:	e1a03000 	mov	r3, r0
    87ec:	e59f2098 	ldr	r2, [pc, #152]	; 888c <_Z9set_roles9CI2C_Mode+0x1c0>
    87f0:	e5823000 	str	r3, [r2]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:154
    strncpy(log_msg, "Roles set. I am ", 16);
    87f4:	e24b3048 	sub	r3, fp, #72	; 0x48
    87f8:	e3a02010 	mov	r2, #16
    87fc:	e59f108c 	ldr	r1, [pc, #140]	; 8890 <_Z9set_roles9CI2C_Mode+0x1c4>
    8800:	e1a00003 	mov	r0, r3
    8804:	eb000365 	bl	95a0 <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:155
    switch (agreed_role)
    8808:	e59f307c 	ldr	r3, [pc, #124]	; 888c <_Z9set_roles9CI2C_Mode+0x1c0>
    880c:	e5933000 	ldr	r3, [r3]
    8810:	e3530000 	cmp	r3, #0
    8814:	0a000002 	beq	8824 <_Z9set_roles9CI2C_Mode+0x158>
    8818:	e3530001 	cmp	r3, #1
    881c:	0a000005 	beq	8838 <_Z9set_roles9CI2C_Mode+0x16c>
    8820:	ea000009 	b	884c <_Z9set_roles9CI2C_Mode+0x180>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:158
    {
    case CI2C_Mode::Master:
        concat(log_msg, "Master\n");
    8824:	e24b3048 	sub	r3, fp, #72	; 0x48
    8828:	e59f1064 	ldr	r1, [pc, #100]	; 8894 <_Z9set_roles9CI2C_Mode+0x1c8>
    882c:	e1a00003 	mov	r0, r3
    8830:	eb000404 	bl	9848 <_Z6concatPcPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:159
        break;
    8834:	ea000004 	b	884c <_Z9set_roles9CI2C_Mode+0x180>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:161
    case CI2C_Mode::Slave:
        concat(log_msg, "Slave\n");
    8838:	e24b3048 	sub	r3, fp, #72	; 0x48
    883c:	e59f1054 	ldr	r1, [pc, #84]	; 8898 <_Z9set_roles9CI2C_Mode+0x1cc>
    8840:	e1a00003 	mov	r0, r3
    8844:	eb0003ff 	bl	9848 <_Z6concatPcPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:162
        break;
    8848:	e320f000 	nop	{0}
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:164
    }
    log(log_msg);
    884c:	e24b3048 	sub	r3, fp, #72	; 0x48
    8850:	e1a00003 	mov	r0, r3
    8854:	ebfffe9f 	bl	82d8 <_Z3logPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:165
    return agreed_role == desired_role;
    8858:	e59f302c 	ldr	r3, [pc, #44]	; 888c <_Z9set_roles9CI2C_Mode+0x1c0>
    885c:	e5933000 	ldr	r3, [r3]
    8860:	e51b2050 	ldr	r2, [fp, #-80]	; 0xffffffb0
    8864:	e1520003 	cmp	r2, r3
    8868:	03a03001 	moveq	r3, #1
    886c:	13a03000 	movne	r3, #0
    8870:	e6ef3073 	uxtb	r3, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:166
}
    8874:	e1a00003 	mov	r0, r3
    8878:	e24bd004 	sub	sp, fp, #4
    887c:	e8bd8800 	pop	{fp, pc}
    8880:	00009b98 	muleq	r0, r8, fp
    8884:	00009b9c 	muleq	r0, ip, fp
    8888:	00009cf4 	strdeq	r9, [r0], -r4
    888c:	00009ce8 	andeq	r9, r0, r8, ror #25
    8890:	00009bbc 			; <UNDEFINED> instruction: 0x00009bbc
    8894:	00009bd0 	ldrdeq	r9, [r0], -r0
    8898:	00009bd8 	ldrdeq	r9, [r0], -r8

0000889c <_Z11handle_datacf>:
_Z11handle_datacf():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:169

void handle_data(char value_state, float value)
{
    889c:	e92d4800 	push	{fp, lr}
    88a0:	e28db004 	add	fp, sp, #4
    88a4:	e24dd038 	sub	sp, sp, #56	; 0x38
    88a8:	e1a03000 	mov	r3, r0
    88ac:	ed0b0a0f 	vstr	s0, [fp, #-60]	; 0xffffffc4
    88b0:	e54b3035 	strb	r3, [fp, #-53]	; 0xffffffcb
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:171
    char log_msg[32], value_str[16];
    bzero(log_msg, 32);
    88b4:	e24b3024 	sub	r3, fp, #36	; 0x24
    88b8:	e3a01020 	mov	r1, #32
    88bc:	e1a00003 	mov	r0, r3
    88c0:	eb0003a6 	bl	9760 <_Z5bzeroPvi>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:172
    bzero(value_str, 16);
    88c4:	e24b3034 	sub	r3, fp, #52	; 0x34
    88c8:	e3a01010 	mov	r1, #16
    88cc:	e1a00003 	mov	r0, r3
    88d0:	eb0003a2 	bl	9760 <_Z5bzeroPvi>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:173
    strncpy(log_msg, "Received ", 10);
    88d4:	e24b3024 	sub	r3, fp, #36	; 0x24
    88d8:	e3a0200a 	mov	r2, #10
    88dc:	e59f10b8 	ldr	r1, [pc, #184]	; 899c <_Z11handle_datacf+0x100>
    88e0:	e1a00003 	mov	r0, r3
    88e4:	eb00032d 	bl	95a0 <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:174
    ftoa(value, value_str, 2);
    88e8:	e24b3034 	sub	r3, fp, #52	; 0x34
    88ec:	e3a01002 	mov	r1, #2
    88f0:	e1a00003 	mov	r0, r3
    88f4:	ed1b0a0f 	vldr	s0, [fp, #-60]	; 0xffffffc4
    88f8:	eb000283 	bl	930c <_Z4ftoafPcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:175
    concat(log_msg, value_str);
    88fc:	e24b2034 	sub	r2, fp, #52	; 0x34
    8900:	e24b3024 	sub	r3, fp, #36	; 0x24
    8904:	e1a01002 	mov	r1, r2
    8908:	e1a00003 	mov	r0, r3
    890c:	eb0003cd 	bl	9848 <_Z6concatPcPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:176
    switch (value_state)
    8910:	e55b3035 	ldrb	r3, [fp, #-53]	; 0xffffffcb
    8914:	e3530076 	cmp	r3, #118	; 0x76
    8918:	0a000006 	beq	8938 <_Z11handle_datacf+0x9c>
    891c:	e3530076 	cmp	r3, #118	; 0x76
    8920:	ca000013 	bgt	8974 <_Z11handle_datacf+0xd8>
    8924:	e3530064 	cmp	r3, #100	; 0x64
    8928:	0a000007 	beq	894c <_Z11handle_datacf+0xb0>
    892c:	e3530074 	cmp	r3, #116	; 0x74
    8930:	0a00000a 	beq	8960 <_Z11handle_datacf+0xc4>
    8934:	ea00000e 	b	8974 <_Z11handle_datacf+0xd8>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:180
    {
    case 'v':
        // vse v poradku
        concat(log_msg, " - OK");
    8938:	e24b3024 	sub	r3, fp, #36	; 0x24
    893c:	e59f105c 	ldr	r1, [pc, #92]	; 89a0 <_Z11handle_datacf+0x104>
    8940:	e1a00003 	mov	r0, r3
    8944:	eb0003bf 	bl	9848 <_Z6concatPcPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:181
        break;
    8948:	ea000009 	b	8974 <_Z11handle_datacf+0xd8>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:184
    case 'd':
        // nebezpecna hodnota
        concat(log_msg, " - DANGER");
    894c:	e24b3024 	sub	r3, fp, #36	; 0x24
    8950:	e59f104c 	ldr	r1, [pc, #76]	; 89a4 <_Z11handle_datacf+0x108>
    8954:	e1a00003 	mov	r0, r3
    8958:	eb0003ba 	bl	9848 <_Z6concatPcPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:185
        break;
    895c:	ea000004 	b	8974 <_Z11handle_datacf+0xd8>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:188
    case 't':
        // dalsi hodnota muze byt nebezpecna
        concat(log_msg, " - WARNING");
    8960:	e24b3024 	sub	r3, fp, #36	; 0x24
    8964:	e59f103c 	ldr	r1, [pc, #60]	; 89a8 <_Z11handle_datacf+0x10c>
    8968:	e1a00003 	mov	r0, r3
    896c:	eb0003b5 	bl	9848 <_Z6concatPcPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:189
        break;
    8970:	e320f000 	nop	{0}
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:192
    
    }
    concat(log_msg, "\n");
    8974:	e24b3024 	sub	r3, fp, #36	; 0x24
    8978:	e59f102c 	ldr	r1, [pc, #44]	; 89ac <_Z11handle_datacf+0x110>
    897c:	e1a00003 	mov	r0, r3
    8980:	eb0003b0 	bl	9848 <_Z6concatPcPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:193
    log(log_msg);
    8984:	e24b3024 	sub	r3, fp, #36	; 0x24
    8988:	e1a00003 	mov	r0, r3
    898c:	ebfffe51 	bl	82d8 <_Z3logPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:194
}
    8990:	e320f000 	nop	{0}
    8994:	e24bd004 	sub	sp, fp, #4
    8998:	e8bd8800 	pop	{fp, pc}
    899c:	00009be0 	andeq	r9, r0, r0, ror #23
    89a0:	00009bec 	andeq	r9, r0, ip, ror #23
    89a4:	00009bf4 	strdeq	r9, [r0], -r4
    89a8:	00009c00 	andeq	r9, r0, r0, lsl #24
    89ac:	00009b94 	muleq	r0, r4, fp

000089b0 <_Z12receive_datav>:
_Z12receive_datav():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:197

void receive_data()
{
    89b0:	e92d4800 	push	{fp, lr}
    89b4:	e28db004 	add	fp, sp, #4
    89b8:	e24dd030 	sub	sp, sp, #48	; 0x30
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:199
    char buff[6], log_msg[32];
    bzero(buff, 6);
    89bc:	e24b300c 	sub	r3, fp, #12
    89c0:	e3a01006 	mov	r1, #6
    89c4:	e1a00003 	mov	r0, r3
    89c8:	eb000364 	bl	9760 <_Z5bzeroPvi>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:200
    bzero(log_msg, 32);
    89cc:	e24b302c 	sub	r3, fp, #44	; 0x2c
    89d0:	e3a01020 	mov	r1, #32
    89d4:	e1a00003 	mov	r0, r3
    89d8:	eb000360 	bl	9760 <_Z5bzeroPvi>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:204
    char value_state;
    float value;

    while (strlen(buff) == 0) {
    89dc:	e24b300c 	sub	r3, fp, #12
    89e0:	e1a00003 	mov	r0, r3
    89e4:	eb000348 	bl	970c <_Z6strlenPKc>
    89e8:	e1a03000 	mov	r3, r0
    89ec:	e3530000 	cmp	r3, #0
    89f0:	03a03001 	moveq	r3, #1
    89f4:	13a03000 	movne	r3, #0
    89f8:	e6ef3073 	uxtb	r3, r3
    89fc:	e3530000 	cmp	r3, #0
    8a00:	0a000009 	beq	8a2c <_Z12receive_datav+0x7c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:205
        read(i2c_fd, buff, 6);
    8a04:	e59f3060 	ldr	r3, [pc, #96]	; 8a6c <_Z12receive_datav+0xbc>
    8a08:	e5933000 	ldr	r3, [r3]
    8a0c:	e24b100c 	sub	r1, fp, #12
    8a10:	e3a02006 	mov	r2, #6
    8a14:	e1a00003 	mov	r0, r3
    8a18:	eb0000ce 	bl	8d58 <_Z4readjPcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:206
        sleep(0x100);
    8a1c:	e3e01001 	mvn	r1, #1
    8a20:	e3a00c01 	mov	r0, #256	; 0x100
    8a24:	eb000137 	bl	8f08 <_Z5sleepjj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:204
    while (strlen(buff) == 0) {
    8a28:	eaffffeb 	b	89dc <_Z12receive_datav+0x2c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:209
    }

    value_state = buff[0];
    8a2c:	e55b300c 	ldrb	r3, [fp, #-12]
    8a30:	e54b3005 	strb	r3, [fp, #-5]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:210
    memcpy(buff + 1, &value, 4);
    8a34:	e24b300c 	sub	r3, fp, #12
    8a38:	e2833001 	add	r3, r3, #1
    8a3c:	e24b1030 	sub	r1, fp, #48	; 0x30
    8a40:	e3a02004 	mov	r2, #4
    8a44:	e1a00003 	mov	r0, r3
    8a48:	eb00035e 	bl	97c8 <_Z6memcpyPKvPvi>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:212

    handle_data(value_state, value);
    8a4c:	ed5b7a0c 	vldr	s15, [fp, #-48]	; 0xffffffd0
    8a50:	e55b3005 	ldrb	r3, [fp, #-5]
    8a54:	eeb00a67 	vmov.f32	s0, s15
    8a58:	e1a00003 	mov	r0, r3
    8a5c:	ebffff8e 	bl	889c <_Z11handle_datacf>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:213
}
    8a60:	e320f000 	nop	{0}
    8a64:	e24bd004 	sub	sp, fp, #4
    8a68:	e8bd8800 	pop	{fp, pc}
    8a6c:	00009cf4 	strdeq	r9, [r0], -r4

00008a70 <_Z11master_taskv>:
_Z11master_taskv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:215

void master_task() {
    8a70:	e92d4800 	push	{fp, lr}
    8a74:	e28db004 	add	fp, sp, #4
    8a78:	e24dd030 	sub	sp, sp, #48	; 0x30
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:219 (discriminator 1)
    char buff[9], msg[32];

    for (;;) {
        bzero(msg, 32);
    8a7c:	e24b3030 	sub	r3, fp, #48	; 0x30
    8a80:	e3a01020 	mov	r1, #32
    8a84:	e1a00003 	mov	r0, r3
    8a88:	eb000334 	bl	9760 <_Z5bzeroPvi>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:220 (discriminator 1)
        bzero(buff, 9);
    8a8c:	e24b3010 	sub	r3, fp, #16
    8a90:	e3a01009 	mov	r1, #9
    8a94:	e1a00003 	mov	r0, r3
    8a98:	eb000330 	bl	9760 <_Z5bzeroPvi>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:221 (discriminator 1)
        receive_data();
    8a9c:	ebffffc3 	bl	89b0 <_Z12receive_datav>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:223 (discriminator 1)

        sleep(0x15000);
    8aa0:	e3e01001 	mvn	r1, #1
    8aa4:	e3a00a15 	mov	r0, #86016	; 0x15000
    8aa8:	eb000116 	bl	8f08 <_Z5sleepjj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:219 (discriminator 1)
        bzero(msg, 32);
    8aac:	eafffff2 	b	8a7c <_Z11master_taskv+0xc>

00008ab0 <_Z10slave_taskv>:
_Z10slave_taskv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:227
    }
}

void slave_task() {
    8ab0:	e92d4800 	push	{fp, lr}
    8ab4:	e28db004 	add	fp, sp, #4
    8ab8:	e24dd008 	sub	sp, sp, #8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:228
    uint32_t counter = 0;
    8abc:	e3a03000 	mov	r3, #0
    8ac0:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:230 (discriminator 1)
    for (;;) {
        send_value(random_values[counter]);
    8ac4:	e59f2050 	ldr	r2, [pc, #80]	; 8b1c <_Z10slave_taskv+0x6c>
    8ac8:	e51b3008 	ldr	r3, [fp, #-8]
    8acc:	e1a03103 	lsl	r3, r3, #2
    8ad0:	e0823003 	add	r3, r2, r3
    8ad4:	edd37a00 	vldr	s15, [r3]
    8ad8:	eeb00a67 	vmov.f32	s0, s15
    8adc:	ebfffe93 	bl	8530 <_Z10send_valuef>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:231 (discriminator 1)
        prev_value = random_values[counter];
    8ae0:	e59f2034 	ldr	r2, [pc, #52]	; 8b1c <_Z10slave_taskv+0x6c>
    8ae4:	e51b3008 	ldr	r3, [fp, #-8]
    8ae8:	e1a03103 	lsl	r3, r3, #2
    8aec:	e0823003 	add	r3, r2, r3
    8af0:	e5933000 	ldr	r3, [r3]
    8af4:	e59f2024 	ldr	r2, [pc, #36]	; 8b20 <_Z10slave_taskv+0x70>
    8af8:	e5823000 	str	r3, [r2]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:232 (discriminator 1)
        counter = (counter + 1) % random_values_len;
    8afc:	e51b3008 	ldr	r3, [fp, #-8]
    8b00:	e2833001 	add	r3, r3, #1
    8b04:	e2033007 	and	r3, r3, #7
    8b08:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:233 (discriminator 1)
        sleep(0x15000);
    8b0c:	e3e01001 	mvn	r1, #1
    8b10:	e3a00a15 	mov	r0, #86016	; 0x15000
    8b14:	eb0000fb 	bl	8f08 <_Z5sleepjj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:230 (discriminator 1)
        send_value(random_values[counter]);
    8b18:	eaffffe9 	b	8ac4 <_Z10slave_taskv+0x14>
    8b1c:	00009b48 	andeq	r9, r0, r8, asr #22
    8b20:	00009cec 	andeq	r9, r0, ip, ror #25

00008b24 <main>:
main():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:238
    }
}

int main(int argc, char** argv)
{
    8b24:	e92d4800 	push	{fp, lr}
    8b28:	e28db004 	add	fp, sp, #4
    8b2c:	e24dd030 	sub	sp, sp, #48	; 0x30
    8b30:	e50b0030 	str	r0, [fp, #-48]	; 0xffffffd0
    8b34:	e50b1034 	str	r1, [fp, #-52]	; 0xffffffcc
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:239
    uint32_t counter = 0;
    8b38:	e3a03000 	mov	r3, #0
    8b3c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:241
    char buff[32];
    bzero(buff, 32);
    8b40:	e24b3028 	sub	r3, fp, #40	; 0x28
    8b44:	e3a01020 	mov	r1, #32
    8b48:	e1a00003 	mov	r0, r3
    8b4c:	eb000303 	bl	9760 <_Z5bzeroPvi>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:243

    log_fd = pipe("log", 128);
    8b50:	e3a01080 	mov	r1, #128	; 0x80
    8b54:	e59f011c 	ldr	r0, [pc, #284]	; 8c78 <main+0x154>
    8b58:	eb00013b 	bl	904c <_Z4pipePKcj>
    8b5c:	e1a03000 	mov	r3, r0
    8b60:	e59f2114 	ldr	r2, [pc, #276]	; 8c7c <main+0x158>
    8b64:	e5823000 	str	r3, [r2]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:245

    log("Task 2 started\n");
    8b68:	e59f0110 	ldr	r0, [pc, #272]	; 8c80 <main+0x15c>
    8b6c:	ebfffdd9 	bl	82d8 <_Z3logPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:248

    // start i2c connection - primarly master
    i2c_fd = open("DEV:i2c/1", NFile_Open_Mode::Read_Write);
    8b70:	e3a01002 	mov	r1, #2
    8b74:	e59f0108 	ldr	r0, [pc, #264]	; 8c84 <main+0x160>
    8b78:	eb000065 	bl	8d14 <_Z4openPKc15NFile_Open_Mode>
    8b7c:	e1a03000 	mov	r3, r0
    8b80:	e59f2100 	ldr	r2, [pc, #256]	; 8c88 <main+0x164>
    8b84:	e5823000 	str	r3, [r2]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:249
    if (i2c_fd == Invalid_Handle) {
    8b88:	e59f30f8 	ldr	r3, [pc, #248]	; 8c88 <main+0x164>
    8b8c:	e5933000 	ldr	r3, [r3]
    8b90:	e3730001 	cmn	r3, #1
    8b94:	1a00000d 	bne	8bd0 <main+0xac>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:251
        // if master already opened, open slave
        i2c_fd = open("DEV:i2c/2", NFile_Open_Mode::Read_Write);
    8b98:	e3a01002 	mov	r1, #2
    8b9c:	e59f00e8 	ldr	r0, [pc, #232]	; 8c8c <main+0x168>
    8ba0:	eb00005b 	bl	8d14 <_Z4openPKc15NFile_Open_Mode>
    8ba4:	e1a03000 	mov	r3, r0
    8ba8:	e59f20d8 	ldr	r2, [pc, #216]	; 8c88 <main+0x164>
    8bac:	e5823000 	str	r3, [r2]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:252
        if (i2c_fd == Invalid_Handle) {
    8bb0:	e59f30d0 	ldr	r3, [pc, #208]	; 8c88 <main+0x164>
    8bb4:	e5933000 	ldr	r3, [r3]
    8bb8:	e3730001 	cmn	r3, #1
    8bbc:	1a000003 	bne	8bd0 <main+0xac>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:253
            log("Error opening I2C connection\n");
    8bc0:	e59f00c8 	ldr	r0, [pc, #200]	; 8c90 <main+0x16c>
    8bc4:	ebfffdc3 	bl	82d8 <_Z3logPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:254
            return 1;
    8bc8:	e3a03001 	mov	r3, #1
    8bcc:	ea000026 	b	8c6c <main+0x148>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:259
        }
    }
    // set addresses
    TI2C_IOCtl_Params params;
    params.address = ADDRESS;
    8bd0:	e3a03001 	mov	r3, #1
    8bd4:	e54b302c 	strb	r3, [fp, #-44]	; 0xffffffd4
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:260
    params.targetAdress = TARGET_ADDRESS;
    8bd8:	e3a03002 	mov	r3, #2
    8bdc:	e54b302b 	strb	r3, [fp, #-43]	; 0xffffffd5
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:261
    ioctl(i2c_fd, NIOCtl_Operation::Set_Params, &params);
    8be0:	e59f30a0 	ldr	r3, [pc, #160]	; 8c88 <main+0x164>
    8be4:	e5933000 	ldr	r3, [r3]
    8be8:	e24b202c 	sub	r2, fp, #44	; 0x2c
    8bec:	e3a01001 	mov	r1, #1
    8bf0:	e1a00003 	mov	r0, r3
    8bf4:	eb00008a 	bl	8e24 <_Z5ioctlj16NIOCtl_OperationPv>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:262
    log("Task 2: I2C connection started...\n");
    8bf8:	e59f0094 	ldr	r0, [pc, #148]	; 8c94 <main+0x170>
    8bfc:	ebfffdb5 	bl	82d8 <_Z3logPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:270
    // if (slave == Invalid_Handle) {
    //     log("Error opening I2C slave connection\n");
    //     return 1;
    // }

    sleep(0x100);
    8c00:	e3e01001 	mvn	r1, #1
    8c04:	e3a00c01 	mov	r0, #256	; 0x100
    8c08:	eb0000be 	bl	8f08 <_Z5sleepjj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:271
    set_roles(DESIRED_ROLE);
    8c0c:	e3a00001 	mov	r0, #1
    8c10:	ebfffead 	bl	86cc <_Z9set_roles9CI2C_Mode>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:273

    switch (agreed_role)
    8c14:	e59f307c 	ldr	r3, [pc, #124]	; 8c98 <main+0x174>
    8c18:	e5933000 	ldr	r3, [r3]
    8c1c:	e3530000 	cmp	r3, #0
    8c20:	0a000002 	beq	8c30 <main+0x10c>
    8c24:	e3530001 	cmp	r3, #1
    8c28:	0a000002 	beq	8c38 <main+0x114>
    8c2c:	ea000003 	b	8c40 <main+0x11c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:276
    {
    case CI2C_Mode::Master:
        master_task();
    8c30:	ebffff8e 	bl	8a70 <_Z11master_taskv>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:277
        break;
    8c34:	ea000001 	b	8c40 <main+0x11c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:279
    case CI2C_Mode::Slave:
        slave_task();
    8c38:	ebffff9c 	bl	8ab0 <_Z10slave_taskv>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:280
        break;
    8c3c:	e320f000 	nop	{0}
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:283
    }

    close(i2c_fd);
    8c40:	e59f3040 	ldr	r3, [pc, #64]	; 8c88 <main+0x164>
    8c44:	e5933000 	ldr	r3, [r3]
    8c48:	e1a00003 	mov	r0, r3
    8c4c:	eb000069 	bl	8df8 <_Z5closej>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:284
    log("Open files closed in task 2\n");
    8c50:	e59f0044 	ldr	r0, [pc, #68]	; 8c9c <main+0x178>
    8c54:	ebfffd9f 	bl	82d8 <_Z3logPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:285
    close(log_fd);
    8c58:	e59f301c 	ldr	r3, [pc, #28]	; 8c7c <main+0x158>
    8c5c:	e5933000 	ldr	r3, [r3]
    8c60:	e1a00003 	mov	r0, r3
    8c64:	eb000063 	bl	8df8 <_Z5closej>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:287

    return 0;
    8c68:	e3a03000 	mov	r3, #0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:288 (discriminator 1)
}
    8c6c:	e1a00003 	mov	r0, r3
    8c70:	e24bd004 	sub	sp, fp, #4
    8c74:	e8bd8800 	pop	{fp, pc}
    8c78:	00009c0c 	andeq	r9, r0, ip, lsl #24
    8c7c:	00009cf0 	strdeq	r9, [r0], -r0
    8c80:	00009c10 	andeq	r9, r0, r0, lsl ip
    8c84:	00009c20 	andeq	r9, r0, r0, lsr #24
    8c88:	00009cf4 	strdeq	r9, [r0], -r4
    8c8c:	00009c2c 	andeq	r9, r0, ip, lsr #24
    8c90:	00009c38 	andeq	r9, r0, r8, lsr ip
    8c94:	00009c58 	andeq	r9, r0, r8, asr ip
    8c98:	00009ce8 	andeq	r9, r0, r8, ror #25
    8c9c:	00009c7c 	andeq	r9, r0, ip, ror ip

00008ca0 <_Z6getpidv>:
_Z6getpidv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:5
#include <stdfile.h>
#include <stdstring.h>

uint32_t getpid()
{
    8ca0:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8ca4:	e28db000 	add	fp, sp, #0
    8ca8:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:8
    uint32_t pid;

    asm volatile("swi 0");
    8cac:	ef000000 	svc	0x00000000
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:9
    asm volatile("mov %0, r0" : "=r" (pid));
    8cb0:	e1a03000 	mov	r3, r0
    8cb4:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:11

    return pid;
    8cb8:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:12
}
    8cbc:	e1a00003 	mov	r0, r3
    8cc0:	e28bd000 	add	sp, fp, #0
    8cc4:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8cc8:	e12fff1e 	bx	lr

00008ccc <_Z9terminatei>:
_Z9terminatei():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:15

void terminate(int exitcode)
{
    8ccc:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8cd0:	e28db000 	add	fp, sp, #0
    8cd4:	e24dd00c 	sub	sp, sp, #12
    8cd8:	e50b0008 	str	r0, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:16
    asm volatile("mov r0, %0" : : "r" (exitcode));
    8cdc:	e51b3008 	ldr	r3, [fp, #-8]
    8ce0:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:17
    asm volatile("swi 1");
    8ce4:	ef000001 	svc	0x00000001
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:18
}
    8ce8:	e320f000 	nop	{0}
    8cec:	e28bd000 	add	sp, fp, #0
    8cf0:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8cf4:	e12fff1e 	bx	lr

00008cf8 <_Z11sched_yieldv>:
_Z11sched_yieldv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:21

void sched_yield()
{
    8cf8:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8cfc:	e28db000 	add	fp, sp, #0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:22
    asm volatile("swi 2");
    8d00:	ef000002 	svc	0x00000002
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:23
}
    8d04:	e320f000 	nop	{0}
    8d08:	e28bd000 	add	sp, fp, #0
    8d0c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8d10:	e12fff1e 	bx	lr

00008d14 <_Z4openPKc15NFile_Open_Mode>:
_Z4openPKc15NFile_Open_Mode():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:26

uint32_t open(const char* filename, NFile_Open_Mode mode)
{
    8d14:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8d18:	e28db000 	add	fp, sp, #0
    8d1c:	e24dd014 	sub	sp, sp, #20
    8d20:	e50b0010 	str	r0, [fp, #-16]
    8d24:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:29
    uint32_t file;

    asm volatile("mov r0, %0" : : "r" (filename));
    8d28:	e51b3010 	ldr	r3, [fp, #-16]
    8d2c:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:30
    asm volatile("mov r1, %0" : : "r" (mode));
    8d30:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8d34:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:31
    asm volatile("swi 64");
    8d38:	ef000040 	svc	0x00000040
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:32
    asm volatile("mov %0, r0" : "=r" (file));
    8d3c:	e1a03000 	mov	r3, r0
    8d40:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:33
    return file;
    8d44:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:34
}
    8d48:	e1a00003 	mov	r0, r3
    8d4c:	e28bd000 	add	sp, fp, #0
    8d50:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8d54:	e12fff1e 	bx	lr

00008d58 <_Z4readjPcj>:
_Z4readjPcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:37

uint32_t read(uint32_t file, char* const buffer, uint32_t size)
{
    8d58:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8d5c:	e28db000 	add	fp, sp, #0
    8d60:	e24dd01c 	sub	sp, sp, #28
    8d64:	e50b0010 	str	r0, [fp, #-16]
    8d68:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8d6c:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:40
    uint32_t rdnum;

    asm volatile("mov r0, %0" : : "r" (file));
    8d70:	e51b3010 	ldr	r3, [fp, #-16]
    8d74:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:41
    asm volatile("mov r1, %0" : : "r" (buffer));
    8d78:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8d7c:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:42
    asm volatile("mov r2, %0" : : "r" (size));
    8d80:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8d84:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:43
    asm volatile("swi 65");
    8d88:	ef000041 	svc	0x00000041
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:44
    asm volatile("mov %0, r0" : "=r" (rdnum));
    8d8c:	e1a03000 	mov	r3, r0
    8d90:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:46

    return rdnum;
    8d94:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:47
}
    8d98:	e1a00003 	mov	r0, r3
    8d9c:	e28bd000 	add	sp, fp, #0
    8da0:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8da4:	e12fff1e 	bx	lr

00008da8 <_Z5writejPKcj>:
_Z5writejPKcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:50

uint32_t write(uint32_t file, const char* buffer, uint32_t size)
{
    8da8:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8dac:	e28db000 	add	fp, sp, #0
    8db0:	e24dd01c 	sub	sp, sp, #28
    8db4:	e50b0010 	str	r0, [fp, #-16]
    8db8:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8dbc:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:53
    uint32_t wrnum;

    asm volatile("mov r0, %0" : : "r" (file));
    8dc0:	e51b3010 	ldr	r3, [fp, #-16]
    8dc4:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:54
    asm volatile("mov r1, %0" : : "r" (buffer));
    8dc8:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8dcc:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:55
    asm volatile("mov r2, %0" : : "r" (size));
    8dd0:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8dd4:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:56
    asm volatile("swi 66");
    8dd8:	ef000042 	svc	0x00000042
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:57
    asm volatile("mov %0, r0" : "=r" (wrnum));
    8ddc:	e1a03000 	mov	r3, r0
    8de0:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:59

    return wrnum;
    8de4:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:60
}
    8de8:	e1a00003 	mov	r0, r3
    8dec:	e28bd000 	add	sp, fp, #0
    8df0:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8df4:	e12fff1e 	bx	lr

00008df8 <_Z5closej>:
_Z5closej():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:63

void close(uint32_t file)
{
    8df8:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8dfc:	e28db000 	add	fp, sp, #0
    8e00:	e24dd00c 	sub	sp, sp, #12
    8e04:	e50b0008 	str	r0, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:64
    asm volatile("mov r0, %0" : : "r" (file));
    8e08:	e51b3008 	ldr	r3, [fp, #-8]
    8e0c:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:65
    asm volatile("swi 67");
    8e10:	ef000043 	svc	0x00000043
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:66
}
    8e14:	e320f000 	nop	{0}
    8e18:	e28bd000 	add	sp, fp, #0
    8e1c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8e20:	e12fff1e 	bx	lr

00008e24 <_Z5ioctlj16NIOCtl_OperationPv>:
_Z5ioctlj16NIOCtl_OperationPv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:69

uint32_t ioctl(uint32_t file, NIOCtl_Operation operation, void* param)
{
    8e24:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8e28:	e28db000 	add	fp, sp, #0
    8e2c:	e24dd01c 	sub	sp, sp, #28
    8e30:	e50b0010 	str	r0, [fp, #-16]
    8e34:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8e38:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:72
    uint32_t retcode;

    asm volatile("mov r0, %0" : : "r" (file));
    8e3c:	e51b3010 	ldr	r3, [fp, #-16]
    8e40:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:73
    asm volatile("mov r1, %0" : : "r" (operation));
    8e44:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8e48:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:74
    asm volatile("mov r2, %0" : : "r" (param));
    8e4c:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8e50:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:75
    asm volatile("swi 68");
    8e54:	ef000044 	svc	0x00000044
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:76
    asm volatile("mov %0, r0" : "=r" (retcode));
    8e58:	e1a03000 	mov	r3, r0
    8e5c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:78

    return retcode;
    8e60:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:79
}
    8e64:	e1a00003 	mov	r0, r3
    8e68:	e28bd000 	add	sp, fp, #0
    8e6c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8e70:	e12fff1e 	bx	lr

00008e74 <_Z6notifyjj>:
_Z6notifyjj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:82

uint32_t notify(uint32_t file, uint32_t count)
{
    8e74:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8e78:	e28db000 	add	fp, sp, #0
    8e7c:	e24dd014 	sub	sp, sp, #20
    8e80:	e50b0010 	str	r0, [fp, #-16]
    8e84:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:85
    uint32_t retcnt;

    asm volatile("mov r0, %0" : : "r" (file));
    8e88:	e51b3010 	ldr	r3, [fp, #-16]
    8e8c:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:86
    asm volatile("mov r1, %0" : : "r" (count));
    8e90:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8e94:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:87
    asm volatile("swi 69");
    8e98:	ef000045 	svc	0x00000045
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:88
    asm volatile("mov %0, r0" : "=r" (retcnt));
    8e9c:	e1a03000 	mov	r3, r0
    8ea0:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:90

    return retcnt;
    8ea4:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:91
}
    8ea8:	e1a00003 	mov	r0, r3
    8eac:	e28bd000 	add	sp, fp, #0
    8eb0:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8eb4:	e12fff1e 	bx	lr

00008eb8 <_Z4waitjjj>:
_Z4waitjjj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:94

NSWI_Result_Code wait(uint32_t file, uint32_t count, uint32_t notified_deadline)
{
    8eb8:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8ebc:	e28db000 	add	fp, sp, #0
    8ec0:	e24dd01c 	sub	sp, sp, #28
    8ec4:	e50b0010 	str	r0, [fp, #-16]
    8ec8:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8ecc:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:97
    NSWI_Result_Code retcode;

    asm volatile("mov r0, %0" : : "r" (file));
    8ed0:	e51b3010 	ldr	r3, [fp, #-16]
    8ed4:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:98
    asm volatile("mov r1, %0" : : "r" (count));
    8ed8:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8edc:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:99
    asm volatile("mov r2, %0" : : "r" (notified_deadline));
    8ee0:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8ee4:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:100
    asm volatile("swi 70");
    8ee8:	ef000046 	svc	0x00000046
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:101
    asm volatile("mov %0, r0" : "=r" (retcode));
    8eec:	e1a03000 	mov	r3, r0
    8ef0:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:103

    return retcode;
    8ef4:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:104
}
    8ef8:	e1a00003 	mov	r0, r3
    8efc:	e28bd000 	add	sp, fp, #0
    8f00:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8f04:	e12fff1e 	bx	lr

00008f08 <_Z5sleepjj>:
_Z5sleepjj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:107

bool sleep(uint32_t ticks, uint32_t notified_deadline)
{
    8f08:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8f0c:	e28db000 	add	fp, sp, #0
    8f10:	e24dd014 	sub	sp, sp, #20
    8f14:	e50b0010 	str	r0, [fp, #-16]
    8f18:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:110
    uint32_t retcode;

    asm volatile("mov r0, %0" : : "r" (ticks));
    8f1c:	e51b3010 	ldr	r3, [fp, #-16]
    8f20:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:111
    asm volatile("mov r1, %0" : : "r" (notified_deadline));
    8f24:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8f28:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:112
    asm volatile("swi 3");
    8f2c:	ef000003 	svc	0x00000003
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:113
    asm volatile("mov %0, r0" : "=r" (retcode));
    8f30:	e1a03000 	mov	r3, r0
    8f34:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:115

    return retcode;
    8f38:	e51b3008 	ldr	r3, [fp, #-8]
    8f3c:	e3530000 	cmp	r3, #0
    8f40:	13a03001 	movne	r3, #1
    8f44:	03a03000 	moveq	r3, #0
    8f48:	e6ef3073 	uxtb	r3, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:116
}
    8f4c:	e1a00003 	mov	r0, r3
    8f50:	e28bd000 	add	sp, fp, #0
    8f54:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8f58:	e12fff1e 	bx	lr

00008f5c <_Z24get_active_process_countv>:
_Z24get_active_process_countv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:119

uint32_t get_active_process_count()
{
    8f5c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8f60:	e28db000 	add	fp, sp, #0
    8f64:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:120
    const NGet_Sched_Info_Type req = NGet_Sched_Info_Type::Active_Process_Count;
    8f68:	e3a03000 	mov	r3, #0
    8f6c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:123
    uint32_t retval;

    asm volatile("mov r0, %0" : : "r" (req));
    8f70:	e3a03000 	mov	r3, #0
    8f74:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:124
    asm volatile("mov r1, %0" : : "r" (&retval));
    8f78:	e24b300c 	sub	r3, fp, #12
    8f7c:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:125
    asm volatile("swi 4");
    8f80:	ef000004 	svc	0x00000004
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:127

    return retval;
    8f84:	e51b300c 	ldr	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:128
}
    8f88:	e1a00003 	mov	r0, r3
    8f8c:	e28bd000 	add	sp, fp, #0
    8f90:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8f94:	e12fff1e 	bx	lr

00008f98 <_Z14get_tick_countv>:
_Z14get_tick_countv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:131

uint32_t get_tick_count()
{
    8f98:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8f9c:	e28db000 	add	fp, sp, #0
    8fa0:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:132
    const NGet_Sched_Info_Type req = NGet_Sched_Info_Type::Tick_Count;
    8fa4:	e3a03001 	mov	r3, #1
    8fa8:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:135
    uint32_t retval;

    asm volatile("mov r0, %0" : : "r" (req));
    8fac:	e3a03001 	mov	r3, #1
    8fb0:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:136
    asm volatile("mov r1, %0" : : "r" (&retval));
    8fb4:	e24b300c 	sub	r3, fp, #12
    8fb8:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:137
    asm volatile("swi 4");
    8fbc:	ef000004 	svc	0x00000004
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:139

    return retval;
    8fc0:	e51b300c 	ldr	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:140
}
    8fc4:	e1a00003 	mov	r0, r3
    8fc8:	e28bd000 	add	sp, fp, #0
    8fcc:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8fd0:	e12fff1e 	bx	lr

00008fd4 <_Z17set_task_deadlinej>:
_Z17set_task_deadlinej():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:143

void set_task_deadline(uint32_t tick_count_required)
{
    8fd4:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8fd8:	e28db000 	add	fp, sp, #0
    8fdc:	e24dd014 	sub	sp, sp, #20
    8fe0:	e50b0010 	str	r0, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:144
    const NDeadline_Subservice req = NDeadline_Subservice::Set_Relative;
    8fe4:	e3a03000 	mov	r3, #0
    8fe8:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:146

    asm volatile("mov r0, %0" : : "r" (req));
    8fec:	e3a03000 	mov	r3, #0
    8ff0:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:147
    asm volatile("mov r1, %0" : : "r" (&tick_count_required));
    8ff4:	e24b3010 	sub	r3, fp, #16
    8ff8:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:148
    asm volatile("swi 5");
    8ffc:	ef000005 	svc	0x00000005
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:149
}
    9000:	e320f000 	nop	{0}
    9004:	e28bd000 	add	sp, fp, #0
    9008:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    900c:	e12fff1e 	bx	lr

00009010 <_Z26get_task_ticks_to_deadlinev>:
_Z26get_task_ticks_to_deadlinev():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:152

uint32_t get_task_ticks_to_deadline()
{
    9010:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    9014:	e28db000 	add	fp, sp, #0
    9018:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:153
    const NDeadline_Subservice req = NDeadline_Subservice::Get_Remaining;
    901c:	e3a03001 	mov	r3, #1
    9020:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:156
    uint32_t ticks;

    asm volatile("mov r0, %0" : : "r" (req));
    9024:	e3a03001 	mov	r3, #1
    9028:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:157
    asm volatile("mov r1, %0" : : "r" (&ticks));
    902c:	e24b300c 	sub	r3, fp, #12
    9030:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:158
    asm volatile("swi 5");
    9034:	ef000005 	svc	0x00000005
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:160

    return ticks;
    9038:	e51b300c 	ldr	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:161
}
    903c:	e1a00003 	mov	r0, r3
    9040:	e28bd000 	add	sp, fp, #0
    9044:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    9048:	e12fff1e 	bx	lr

0000904c <_Z4pipePKcj>:
_Z4pipePKcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:166

const char Pipe_File_Prefix[] = "SYS:pipe/";

uint32_t pipe(const char* name, uint32_t buf_size)
{
    904c:	e92d4800 	push	{fp, lr}
    9050:	e28db004 	add	fp, sp, #4
    9054:	e24dd050 	sub	sp, sp, #80	; 0x50
    9058:	e50b0050 	str	r0, [fp, #-80]	; 0xffffffb0
    905c:	e50b1054 	str	r1, [fp, #-84]	; 0xffffffac
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:168
    char fname[64];
    strncpy(fname, Pipe_File_Prefix, sizeof(Pipe_File_Prefix));
    9060:	e24b3048 	sub	r3, fp, #72	; 0x48
    9064:	e3a0200a 	mov	r2, #10
    9068:	e59f1088 	ldr	r1, [pc, #136]	; 90f8 <_Z4pipePKcj+0xac>
    906c:	e1a00003 	mov	r0, r3
    9070:	eb00014a 	bl	95a0 <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:169
    strncpy(fname + sizeof(Pipe_File_Prefix), name, sizeof(fname) - sizeof(Pipe_File_Prefix) - 1);
    9074:	e24b3048 	sub	r3, fp, #72	; 0x48
    9078:	e283300a 	add	r3, r3, #10
    907c:	e3a02035 	mov	r2, #53	; 0x35
    9080:	e51b1050 	ldr	r1, [fp, #-80]	; 0xffffffb0
    9084:	e1a00003 	mov	r0, r3
    9088:	eb000144 	bl	95a0 <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:171

    int ncur = sizeof(Pipe_File_Prefix) + strlen(name);
    908c:	e51b0050 	ldr	r0, [fp, #-80]	; 0xffffffb0
    9090:	eb00019d 	bl	970c <_Z6strlenPKc>
    9094:	e1a03000 	mov	r3, r0
    9098:	e283300a 	add	r3, r3, #10
    909c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:173

    fname[ncur++] = '#';
    90a0:	e51b3008 	ldr	r3, [fp, #-8]
    90a4:	e2832001 	add	r2, r3, #1
    90a8:	e50b2008 	str	r2, [fp, #-8]
    90ac:	e2433004 	sub	r3, r3, #4
    90b0:	e083300b 	add	r3, r3, fp
    90b4:	e3a02023 	mov	r2, #35	; 0x23
    90b8:	e5432044 	strb	r2, [r3, #-68]	; 0xffffffbc
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:175

    itoa(buf_size, &fname[ncur], 10);
    90bc:	e24b2048 	sub	r2, fp, #72	; 0x48
    90c0:	e51b3008 	ldr	r3, [fp, #-8]
    90c4:	e0823003 	add	r3, r2, r3
    90c8:	e3a0200a 	mov	r2, #10
    90cc:	e1a01003 	mov	r1, r3
    90d0:	e51b0054 	ldr	r0, [fp, #-84]	; 0xffffffac
    90d4:	eb000008 	bl	90fc <_Z4itoajPcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:177

    return open(fname, NFile_Open_Mode::Read_Write);
    90d8:	e24b3048 	sub	r3, fp, #72	; 0x48
    90dc:	e3a01002 	mov	r1, #2
    90e0:	e1a00003 	mov	r0, r3
    90e4:	ebffff0a 	bl	8d14 <_Z4openPKc15NFile_Open_Mode>
    90e8:	e1a03000 	mov	r3, r0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:178
}
    90ec:	e1a00003 	mov	r0, r3
    90f0:	e24bd004 	sub	sp, fp, #4
    90f4:	e8bd8800 	pop	{fp, pc}
    90f8:	00009cc8 	andeq	r9, r0, r8, asr #25

000090fc <_Z4itoajPcj>:
_Z4itoajPcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:9
{
    const char CharConvArr[] = "0123456789ABCDEF";
}

void itoa(unsigned int input, char* output, unsigned int base)
{
    90fc:	e92d4800 	push	{fp, lr}
    9100:	e28db004 	add	fp, sp, #4
    9104:	e24dd020 	sub	sp, sp, #32
    9108:	e50b0018 	str	r0, [fp, #-24]	; 0xffffffe8
    910c:	e50b101c 	str	r1, [fp, #-28]	; 0xffffffe4
    9110:	e50b2020 	str	r2, [fp, #-32]	; 0xffffffe0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:10
	int i = 0;
    9114:	e3a03000 	mov	r3, #0
    9118:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:12

	while (input > 0)
    911c:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    9120:	e3530000 	cmp	r3, #0
    9124:	0a000014 	beq	917c <_Z4itoajPcj+0x80>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:14
	{
		output[i] = CharConvArr[input % base];
    9128:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    912c:	e51b1020 	ldr	r1, [fp, #-32]	; 0xffffffe0
    9130:	e1a00003 	mov	r0, r3
    9134:	eb00025b 	bl	9aa8 <__aeabi_uidivmod>
    9138:	e1a03001 	mov	r3, r1
    913c:	e1a01003 	mov	r1, r3
    9140:	e51b3008 	ldr	r3, [fp, #-8]
    9144:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    9148:	e0823003 	add	r3, r2, r3
    914c:	e59f2118 	ldr	r2, [pc, #280]	; 926c <_Z4itoajPcj+0x170>
    9150:	e7d22001 	ldrb	r2, [r2, r1]
    9154:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:15
		input /= base;
    9158:	e51b1020 	ldr	r1, [fp, #-32]	; 0xffffffe0
    915c:	e51b0018 	ldr	r0, [fp, #-24]	; 0xffffffe8
    9160:	eb0001d5 	bl	98bc <__udivsi3>
    9164:	e1a03000 	mov	r3, r0
    9168:	e50b3018 	str	r3, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:16
		i++;
    916c:	e51b3008 	ldr	r3, [fp, #-8]
    9170:	e2833001 	add	r3, r3, #1
    9174:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:12
	while (input > 0)
    9178:	eaffffe7 	b	911c <_Z4itoajPcj+0x20>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:19
	}

    if (i == 0)
    917c:	e51b3008 	ldr	r3, [fp, #-8]
    9180:	e3530000 	cmp	r3, #0
    9184:	1a000007 	bne	91a8 <_Z4itoajPcj+0xac>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:21
    {
        output[i] = CharConvArr[0];
    9188:	e51b3008 	ldr	r3, [fp, #-8]
    918c:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    9190:	e0823003 	add	r3, r2, r3
    9194:	e3a02030 	mov	r2, #48	; 0x30
    9198:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:22
        i++;
    919c:	e51b3008 	ldr	r3, [fp, #-8]
    91a0:	e2833001 	add	r3, r3, #1
    91a4:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:25
    }

	output[i] = '\0';
    91a8:	e51b3008 	ldr	r3, [fp, #-8]
    91ac:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    91b0:	e0823003 	add	r3, r2, r3
    91b4:	e3a02000 	mov	r2, #0
    91b8:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:26
	i--;
    91bc:	e51b3008 	ldr	r3, [fp, #-8]
    91c0:	e2433001 	sub	r3, r3, #1
    91c4:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:28

	for (int j = 0; j <= i/2; j++)
    91c8:	e3a03000 	mov	r3, #0
    91cc:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:28 (discriminator 3)
    91d0:	e51b3008 	ldr	r3, [fp, #-8]
    91d4:	e1a02fa3 	lsr	r2, r3, #31
    91d8:	e0823003 	add	r3, r2, r3
    91dc:	e1a030c3 	asr	r3, r3, #1
    91e0:	e1a02003 	mov	r2, r3
    91e4:	e51b300c 	ldr	r3, [fp, #-12]
    91e8:	e1530002 	cmp	r3, r2
    91ec:	ca00001b 	bgt	9260 <_Z4itoajPcj+0x164>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:30 (discriminator 2)
	{
		char c = output[i - j];
    91f0:	e51b2008 	ldr	r2, [fp, #-8]
    91f4:	e51b300c 	ldr	r3, [fp, #-12]
    91f8:	e0423003 	sub	r3, r2, r3
    91fc:	e1a02003 	mov	r2, r3
    9200:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    9204:	e0833002 	add	r3, r3, r2
    9208:	e5d33000 	ldrb	r3, [r3]
    920c:	e54b300d 	strb	r3, [fp, #-13]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:31 (discriminator 2)
		output[i - j] = output[j];
    9210:	e51b300c 	ldr	r3, [fp, #-12]
    9214:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    9218:	e0822003 	add	r2, r2, r3
    921c:	e51b1008 	ldr	r1, [fp, #-8]
    9220:	e51b300c 	ldr	r3, [fp, #-12]
    9224:	e0413003 	sub	r3, r1, r3
    9228:	e1a01003 	mov	r1, r3
    922c:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    9230:	e0833001 	add	r3, r3, r1
    9234:	e5d22000 	ldrb	r2, [r2]
    9238:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:32 (discriminator 2)
		output[j] = c;
    923c:	e51b300c 	ldr	r3, [fp, #-12]
    9240:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    9244:	e0823003 	add	r3, r2, r3
    9248:	e55b200d 	ldrb	r2, [fp, #-13]
    924c:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:28 (discriminator 2)
	for (int j = 0; j <= i/2; j++)
    9250:	e51b300c 	ldr	r3, [fp, #-12]
    9254:	e2833001 	add	r3, r3, #1
    9258:	e50b300c 	str	r3, [fp, #-12]
    925c:	eaffffdb 	b	91d0 <_Z4itoajPcj+0xd4>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:34
	}
}
    9260:	e320f000 	nop	{0}
    9264:	e24bd004 	sub	sp, fp, #4
    9268:	e8bd8800 	pop	{fp, pc}
    926c:	00009cd4 	ldrdeq	r9, [r0], -r4

00009270 <_Z4atoiPKc>:
_Z4atoiPKc():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:37

int atoi(const char* input)
{
    9270:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    9274:	e28db000 	add	fp, sp, #0
    9278:	e24dd014 	sub	sp, sp, #20
    927c:	e50b0010 	str	r0, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:38
	int output = 0;
    9280:	e3a03000 	mov	r3, #0
    9284:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:40

	while (*input != '\0')
    9288:	e51b3010 	ldr	r3, [fp, #-16]
    928c:	e5d33000 	ldrb	r3, [r3]
    9290:	e3530000 	cmp	r3, #0
    9294:	0a000017 	beq	92f8 <_Z4atoiPKc+0x88>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:42
	{
		output *= 10;
    9298:	e51b2008 	ldr	r2, [fp, #-8]
    929c:	e1a03002 	mov	r3, r2
    92a0:	e1a03103 	lsl	r3, r3, #2
    92a4:	e0833002 	add	r3, r3, r2
    92a8:	e1a03083 	lsl	r3, r3, #1
    92ac:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:43
		if (*input > '9' || *input < '0')
    92b0:	e51b3010 	ldr	r3, [fp, #-16]
    92b4:	e5d33000 	ldrb	r3, [r3]
    92b8:	e3530039 	cmp	r3, #57	; 0x39
    92bc:	8a00000d 	bhi	92f8 <_Z4atoiPKc+0x88>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:43 (discriminator 1)
    92c0:	e51b3010 	ldr	r3, [fp, #-16]
    92c4:	e5d33000 	ldrb	r3, [r3]
    92c8:	e353002f 	cmp	r3, #47	; 0x2f
    92cc:	9a000009 	bls	92f8 <_Z4atoiPKc+0x88>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:46
			break;

		output += *input - '0';
    92d0:	e51b3010 	ldr	r3, [fp, #-16]
    92d4:	e5d33000 	ldrb	r3, [r3]
    92d8:	e2433030 	sub	r3, r3, #48	; 0x30
    92dc:	e51b2008 	ldr	r2, [fp, #-8]
    92e0:	e0823003 	add	r3, r2, r3
    92e4:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:48

		input++;
    92e8:	e51b3010 	ldr	r3, [fp, #-16]
    92ec:	e2833001 	add	r3, r3, #1
    92f0:	e50b3010 	str	r3, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:40
	while (*input != '\0')
    92f4:	eaffffe3 	b	9288 <_Z4atoiPKc+0x18>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:51
	}

	return output;
    92f8:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:52
}
    92fc:	e1a00003 	mov	r0, r3
    9300:	e28bd000 	add	sp, fp, #0
    9304:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    9308:	e12fff1e 	bx	lr

0000930c <_Z4ftoafPcj>:
_Z4ftoafPcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:55

char* ftoa(float input, char* output, unsigned int decimal_places)
{
    930c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    9310:	e28db000 	add	fp, sp, #0
    9314:	e24dd03c 	sub	sp, sp, #60	; 0x3c
    9318:	ed0b0a0c 	vstr	s0, [fp, #-48]	; 0xffffffd0
    931c:	e50b0034 	str	r0, [fp, #-52]	; 0xffffffcc
    9320:	e50b1038 	str	r1, [fp, #-56]	; 0xffffffc8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:56
	char* ptr = output;
    9324:	e51b3034 	ldr	r3, [fp, #-52]	; 0xffffffcc
    9328:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:59

    // Handle negative numbers
    if (input < 0) {
    932c:	ed5b7a0c 	vldr	s15, [fp, #-48]	; 0xffffffd0
    9330:	eef57ac0 	vcmpe.f32	s15, #0.0
    9334:	eef1fa10 	vmrs	APSR_nzcv, fpscr
    9338:	5a000007 	bpl	935c <_Z4ftoafPcj+0x50>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:60
        *ptr++ = '-';
    933c:	e51b3008 	ldr	r3, [fp, #-8]
    9340:	e2832001 	add	r2, r3, #1
    9344:	e50b2008 	str	r2, [fp, #-8]
    9348:	e3a0202d 	mov	r2, #45	; 0x2d
    934c:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:61
        input = -input;
    9350:	ed5b7a0c 	vldr	s15, [fp, #-48]	; 0xffffffd0
    9354:	eef17a67 	vneg.f32	s15, s15
    9358:	ed4b7a0c 	vstr	s15, [fp, #-48]	; 0xffffffd0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:65
    }

    // Extract the integer part
    int int_part = (int)input;
    935c:	ed5b7a0c 	vldr	s15, [fp, #-48]	; 0xffffffd0
    9360:	eefd7ae7 	vcvt.s32.f32	s15, s15
    9364:	ee173a90 	vmov	r3, s15
    9368:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:66
    float fraction = input - int_part;
    936c:	e51b300c 	ldr	r3, [fp, #-12]
    9370:	ee073a90 	vmov	s15, r3
    9374:	eef87ae7 	vcvt.f32.s32	s15, s15
    9378:	ed1b7a0c 	vldr	s14, [fp, #-48]	; 0xffffffd0
    937c:	ee777a67 	vsub.f32	s15, s14, s15
    9380:	ed4b7a04 	vstr	s15, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:70

    // Convert the integer part to a string
    char int_str[12]; // Temporary buffer for the integer part
    char* int_ptr = int_str;
    9384:	e24b302c 	sub	r3, fp, #44	; 0x2c
    9388:	e50b3014 	str	r3, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:71
    if (int_part == 0) {
    938c:	e51b300c 	ldr	r3, [fp, #-12]
    9390:	e3530000 	cmp	r3, #0
    9394:	1a000005 	bne	93b0 <_Z4ftoafPcj+0xa4>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:72
        *int_ptr++ = '0';
    9398:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    939c:	e2832001 	add	r2, r3, #1
    93a0:	e50b2014 	str	r2, [fp, #-20]	; 0xffffffec
    93a4:	e3a02030 	mov	r2, #48	; 0x30
    93a8:	e5c32000 	strb	r2, [r3]
    93ac:	ea00001c 	b	9424 <_Z4ftoafPcj+0x118>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:74
    } else {
        while (int_part > 0) {
    93b0:	e51b300c 	ldr	r3, [fp, #-12]
    93b4:	e3530000 	cmp	r3, #0
    93b8:	da000019 	ble	9424 <_Z4ftoafPcj+0x118>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:75
            *int_ptr++ = '0' + (int_part % 10);
    93bc:	e51b200c 	ldr	r2, [fp, #-12]
    93c0:	e59f31d4 	ldr	r3, [pc, #468]	; 959c <_Z4ftoafPcj+0x290>
    93c4:	e0c31293 	smull	r1, r3, r3, r2
    93c8:	e1a01143 	asr	r1, r3, #2
    93cc:	e1a03fc2 	asr	r3, r2, #31
    93d0:	e0411003 	sub	r1, r1, r3
    93d4:	e1a03001 	mov	r3, r1
    93d8:	e1a03103 	lsl	r3, r3, #2
    93dc:	e0833001 	add	r3, r3, r1
    93e0:	e1a03083 	lsl	r3, r3, #1
    93e4:	e0421003 	sub	r1, r2, r3
    93e8:	e6ef2071 	uxtb	r2, r1
    93ec:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    93f0:	e2831001 	add	r1, r3, #1
    93f4:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    93f8:	e2822030 	add	r2, r2, #48	; 0x30
    93fc:	e6ef2072 	uxtb	r2, r2
    9400:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:76
            int_part /= 10;
    9404:	e51b300c 	ldr	r3, [fp, #-12]
    9408:	e59f218c 	ldr	r2, [pc, #396]	; 959c <_Z4ftoafPcj+0x290>
    940c:	e0c21392 	smull	r1, r2, r2, r3
    9410:	e1a02142 	asr	r2, r2, #2
    9414:	e1a03fc3 	asr	r3, r3, #31
    9418:	e0423003 	sub	r3, r2, r3
    941c:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:74
        while (int_part > 0) {
    9420:	eaffffe2 	b	93b0 <_Z4ftoafPcj+0xa4>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:81
        }
    }

    // Reverse the integer part string and write to buffer
    while (int_ptr != int_str) {
    9424:	e24b302c 	sub	r3, fp, #44	; 0x2c
    9428:	e51b2014 	ldr	r2, [fp, #-20]	; 0xffffffec
    942c:	e1520003 	cmp	r2, r3
    9430:	0a000009 	beq	945c <_Z4ftoafPcj+0x150>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:82
        *ptr++ = *(--int_ptr);
    9434:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    9438:	e2433001 	sub	r3, r3, #1
    943c:	e50b3014 	str	r3, [fp, #-20]	; 0xffffffec
    9440:	e51b3008 	ldr	r3, [fp, #-8]
    9444:	e2832001 	add	r2, r3, #1
    9448:	e50b2008 	str	r2, [fp, #-8]
    944c:	e51b2014 	ldr	r2, [fp, #-20]	; 0xffffffec
    9450:	e5d22000 	ldrb	r2, [r2]
    9454:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:81
    while (int_ptr != int_str) {
    9458:	eafffff1 	b	9424 <_Z4ftoafPcj+0x118>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:86
    }

    // Add the decimal point
    if (decimal_places > 0) {
    945c:	e51b3038 	ldr	r3, [fp, #-56]	; 0xffffffc8
    9460:	e3530000 	cmp	r3, #0
    9464:	0a000004 	beq	947c <_Z4ftoafPcj+0x170>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:87
        *ptr++ = '.';
    9468:	e51b3008 	ldr	r3, [fp, #-8]
    946c:	e2832001 	add	r2, r3, #1
    9470:	e50b2008 	str	r2, [fp, #-8]
    9474:	e3a0202e 	mov	r2, #46	; 0x2e
    9478:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:91
    }

    // Convert the fractional part to the specified number of decimal places
    for (int i = 0; i < decimal_places; i++) {
    947c:	e3a03000 	mov	r3, #0
    9480:	e50b3018 	str	r3, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:91 (discriminator 3)
    9484:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    9488:	e51b2038 	ldr	r2, [fp, #-56]	; 0xffffffc8
    948c:	e1520003 	cmp	r2, r3
    9490:	9a000019 	bls	94fc <_Z4ftoafPcj+0x1f0>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:92 (discriminator 2)
        fraction *= 10;
    9494:	ed5b7a04 	vldr	s15, [fp, #-16]
    9498:	ed9f7a3e 	vldr	s14, [pc, #248]	; 9598 <_Z4ftoafPcj+0x28c>
    949c:	ee677a87 	vmul.f32	s15, s15, s14
    94a0:	ed4b7a04 	vstr	s15, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:93 (discriminator 2)
        int digit = (int)fraction;
    94a4:	ed5b7a04 	vldr	s15, [fp, #-16]
    94a8:	eefd7ae7 	vcvt.s32.f32	s15, s15
    94ac:	ee173a90 	vmov	r3, s15
    94b0:	e50b3020 	str	r3, [fp, #-32]	; 0xffffffe0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:94 (discriminator 2)
        *ptr++ = '0' + digit;
    94b4:	e51b3020 	ldr	r3, [fp, #-32]	; 0xffffffe0
    94b8:	e6ef2073 	uxtb	r2, r3
    94bc:	e51b3008 	ldr	r3, [fp, #-8]
    94c0:	e2831001 	add	r1, r3, #1
    94c4:	e50b1008 	str	r1, [fp, #-8]
    94c8:	e2822030 	add	r2, r2, #48	; 0x30
    94cc:	e6ef2072 	uxtb	r2, r2
    94d0:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:95 (discriminator 2)
        fraction -= digit;
    94d4:	e51b3020 	ldr	r3, [fp, #-32]	; 0xffffffe0
    94d8:	ee073a90 	vmov	s15, r3
    94dc:	eef87ae7 	vcvt.f32.s32	s15, s15
    94e0:	ed1b7a04 	vldr	s14, [fp, #-16]
    94e4:	ee777a67 	vsub.f32	s15, s14, s15
    94e8:	ed4b7a04 	vstr	s15, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:91 (discriminator 2)
    for (int i = 0; i < decimal_places; i++) {
    94ec:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    94f0:	e2833001 	add	r3, r3, #1
    94f4:	e50b3018 	str	r3, [fp, #-24]	; 0xffffffe8
    94f8:	eaffffe1 	b	9484 <_Z4ftoafPcj+0x178>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:99
    }

    // Null-terminate the string
    *ptr = '\0';
    94fc:	e51b3008 	ldr	r3, [fp, #-8]
    9500:	e3a02000 	mov	r2, #0
    9504:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:102

    // Remove trailing zeros if any decimal places were specified
    if (decimal_places > 0) {
    9508:	e51b3038 	ldr	r3, [fp, #-56]	; 0xffffffc8
    950c:	e3530000 	cmp	r3, #0
    9510:	0a00001b 	beq	9584 <_Z4ftoafPcj+0x278>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:103
        char* end = ptr - 1;
    9514:	e51b3008 	ldr	r3, [fp, #-8]
    9518:	e2433001 	sub	r3, r3, #1
    951c:	e50b301c 	str	r3, [fp, #-28]	; 0xffffffe4
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:104
        while (end > output && *end == '0') {
    9520:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    9524:	e51b3034 	ldr	r3, [fp, #-52]	; 0xffffffcc
    9528:	e1520003 	cmp	r2, r3
    952c:	9a000009 	bls	9558 <_Z4ftoafPcj+0x24c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:104 (discriminator 1)
    9530:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    9534:	e5d33000 	ldrb	r3, [r3]
    9538:	e3530030 	cmp	r3, #48	; 0x30
    953c:	1a000005 	bne	9558 <_Z4ftoafPcj+0x24c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:105
            *end-- = '\0';
    9540:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    9544:	e2432001 	sub	r2, r3, #1
    9548:	e50b201c 	str	r2, [fp, #-28]	; 0xffffffe4
    954c:	e3a02000 	mov	r2, #0
    9550:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:104
        while (end > output && *end == '0') {
    9554:	eafffff1 	b	9520 <_Z4ftoafPcj+0x214>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:107
        }
        if (end > output && *end == '.') {
    9558:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    955c:	e51b3034 	ldr	r3, [fp, #-52]	; 0xffffffcc
    9560:	e1520003 	cmp	r2, r3
    9564:	9a000006 	bls	9584 <_Z4ftoafPcj+0x278>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:107 (discriminator 1)
    9568:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    956c:	e5d33000 	ldrb	r3, [r3]
    9570:	e353002e 	cmp	r3, #46	; 0x2e
    9574:	1a000002 	bne	9584 <_Z4ftoafPcj+0x278>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:108
            *end = '\0'; // Remove the decimal point if no fractional part remains
    9578:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    957c:	e3a02000 	mov	r2, #0
    9580:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:112
        }
    }

    return output;
    9584:	e51b3034 	ldr	r3, [fp, #-52]	; 0xffffffcc
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:113
}
    9588:	e1a00003 	mov	r0, r3
    958c:	e28bd000 	add	sp, fp, #0
    9590:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    9594:	e12fff1e 	bx	lr
    9598:	41200000 			; <UNDEFINED> instruction: 0x41200000
    959c:	66666667 	strbtvs	r6, [r6], -r7, ror #12

000095a0 <_Z7strncpyPcPKci>:
_Z7strncpyPcPKci():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:116

char* strncpy(char* dest, const char *src, int num)
{
    95a0:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    95a4:	e28db000 	add	fp, sp, #0
    95a8:	e24dd01c 	sub	sp, sp, #28
    95ac:	e50b0010 	str	r0, [fp, #-16]
    95b0:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    95b4:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:119
	int i;

	for (i = 0; i < num && src[i] != '\0'; i++)
    95b8:	e3a03000 	mov	r3, #0
    95bc:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:119 (discriminator 4)
    95c0:	e51b2008 	ldr	r2, [fp, #-8]
    95c4:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    95c8:	e1520003 	cmp	r2, r3
    95cc:	aa000011 	bge	9618 <_Z7strncpyPcPKci+0x78>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:119 (discriminator 2)
    95d0:	e51b3008 	ldr	r3, [fp, #-8]
    95d4:	e51b2014 	ldr	r2, [fp, #-20]	; 0xffffffec
    95d8:	e0823003 	add	r3, r2, r3
    95dc:	e5d33000 	ldrb	r3, [r3]
    95e0:	e3530000 	cmp	r3, #0
    95e4:	0a00000b 	beq	9618 <_Z7strncpyPcPKci+0x78>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:120 (discriminator 3)
		dest[i] = src[i];
    95e8:	e51b3008 	ldr	r3, [fp, #-8]
    95ec:	e51b2014 	ldr	r2, [fp, #-20]	; 0xffffffec
    95f0:	e0822003 	add	r2, r2, r3
    95f4:	e51b3008 	ldr	r3, [fp, #-8]
    95f8:	e51b1010 	ldr	r1, [fp, #-16]
    95fc:	e0813003 	add	r3, r1, r3
    9600:	e5d22000 	ldrb	r2, [r2]
    9604:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:119 (discriminator 3)
	for (i = 0; i < num && src[i] != '\0'; i++)
    9608:	e51b3008 	ldr	r3, [fp, #-8]
    960c:	e2833001 	add	r3, r3, #1
    9610:	e50b3008 	str	r3, [fp, #-8]
    9614:	eaffffe9 	b	95c0 <_Z7strncpyPcPKci+0x20>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:121 (discriminator 2)
	for (; i < num; i++)
    9618:	e51b2008 	ldr	r2, [fp, #-8]
    961c:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    9620:	e1520003 	cmp	r2, r3
    9624:	aa000008 	bge	964c <_Z7strncpyPcPKci+0xac>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:122 (discriminator 1)
		dest[i] = '\0';
    9628:	e51b3008 	ldr	r3, [fp, #-8]
    962c:	e51b2010 	ldr	r2, [fp, #-16]
    9630:	e0823003 	add	r3, r2, r3
    9634:	e3a02000 	mov	r2, #0
    9638:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:121 (discriminator 1)
	for (; i < num; i++)
    963c:	e51b3008 	ldr	r3, [fp, #-8]
    9640:	e2833001 	add	r3, r3, #1
    9644:	e50b3008 	str	r3, [fp, #-8]
    9648:	eafffff2 	b	9618 <_Z7strncpyPcPKci+0x78>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:124

   return dest;
    964c:	e51b3010 	ldr	r3, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:125
}
    9650:	e1a00003 	mov	r0, r3
    9654:	e28bd000 	add	sp, fp, #0
    9658:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    965c:	e12fff1e 	bx	lr

00009660 <_Z7strncmpPKcS0_i>:
_Z7strncmpPKcS0_i():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:128

int strncmp(const char *s1, const char *s2, int num)
{
    9660:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    9664:	e28db000 	add	fp, sp, #0
    9668:	e24dd01c 	sub	sp, sp, #28
    966c:	e50b0010 	str	r0, [fp, #-16]
    9670:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    9674:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:130
	unsigned char u1, u2;
  	while (num-- > 0)
    9678:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    967c:	e2432001 	sub	r2, r3, #1
    9680:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
    9684:	e3530000 	cmp	r3, #0
    9688:	c3a03001 	movgt	r3, #1
    968c:	d3a03000 	movle	r3, #0
    9690:	e6ef3073 	uxtb	r3, r3
    9694:	e3530000 	cmp	r3, #0
    9698:	0a000016 	beq	96f8 <_Z7strncmpPKcS0_i+0x98>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:132
    {
      	u1 = (unsigned char) *s1++;
    969c:	e51b3010 	ldr	r3, [fp, #-16]
    96a0:	e2832001 	add	r2, r3, #1
    96a4:	e50b2010 	str	r2, [fp, #-16]
    96a8:	e5d33000 	ldrb	r3, [r3]
    96ac:	e54b3005 	strb	r3, [fp, #-5]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:133
     	u2 = (unsigned char) *s2++;
    96b0:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    96b4:	e2832001 	add	r2, r3, #1
    96b8:	e50b2014 	str	r2, [fp, #-20]	; 0xffffffec
    96bc:	e5d33000 	ldrb	r3, [r3]
    96c0:	e54b3006 	strb	r3, [fp, #-6]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:134
      	if (u1 != u2)
    96c4:	e55b2005 	ldrb	r2, [fp, #-5]
    96c8:	e55b3006 	ldrb	r3, [fp, #-6]
    96cc:	e1520003 	cmp	r2, r3
    96d0:	0a000003 	beq	96e4 <_Z7strncmpPKcS0_i+0x84>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:135
        	return u1 - u2;
    96d4:	e55b2005 	ldrb	r2, [fp, #-5]
    96d8:	e55b3006 	ldrb	r3, [fp, #-6]
    96dc:	e0423003 	sub	r3, r2, r3
    96e0:	ea000005 	b	96fc <_Z7strncmpPKcS0_i+0x9c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:136
      	if (u1 == '\0')
    96e4:	e55b3005 	ldrb	r3, [fp, #-5]
    96e8:	e3530000 	cmp	r3, #0
    96ec:	1affffe1 	bne	9678 <_Z7strncmpPKcS0_i+0x18>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:137
        	return 0;
    96f0:	e3a03000 	mov	r3, #0
    96f4:	ea000000 	b	96fc <_Z7strncmpPKcS0_i+0x9c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:140
    }

  	return 0;
    96f8:	e3a03000 	mov	r3, #0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:141
}
    96fc:	e1a00003 	mov	r0, r3
    9700:	e28bd000 	add	sp, fp, #0
    9704:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    9708:	e12fff1e 	bx	lr

0000970c <_Z6strlenPKc>:
_Z6strlenPKc():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:144

int strlen(const char* s)
{
    970c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    9710:	e28db000 	add	fp, sp, #0
    9714:	e24dd014 	sub	sp, sp, #20
    9718:	e50b0010 	str	r0, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:145
	int i = 0;
    971c:	e3a03000 	mov	r3, #0
    9720:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:147

	while (s[i] != '\0')
    9724:	e51b3008 	ldr	r3, [fp, #-8]
    9728:	e51b2010 	ldr	r2, [fp, #-16]
    972c:	e0823003 	add	r3, r2, r3
    9730:	e5d33000 	ldrb	r3, [r3]
    9734:	e3530000 	cmp	r3, #0
    9738:	0a000003 	beq	974c <_Z6strlenPKc+0x40>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:148
		i++;
    973c:	e51b3008 	ldr	r3, [fp, #-8]
    9740:	e2833001 	add	r3, r3, #1
    9744:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:147
	while (s[i] != '\0')
    9748:	eafffff5 	b	9724 <_Z6strlenPKc+0x18>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:150

	return i;
    974c:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:151
}
    9750:	e1a00003 	mov	r0, r3
    9754:	e28bd000 	add	sp, fp, #0
    9758:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    975c:	e12fff1e 	bx	lr

00009760 <_Z5bzeroPvi>:
_Z5bzeroPvi():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:154

void bzero(void* memory, int length)
{
    9760:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    9764:	e28db000 	add	fp, sp, #0
    9768:	e24dd014 	sub	sp, sp, #20
    976c:	e50b0010 	str	r0, [fp, #-16]
    9770:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:155
	char* mem = reinterpret_cast<char*>(memory);
    9774:	e51b3010 	ldr	r3, [fp, #-16]
    9778:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:157

	for (int i = 0; i < length; i++)
    977c:	e3a03000 	mov	r3, #0
    9780:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:157 (discriminator 3)
    9784:	e51b2008 	ldr	r2, [fp, #-8]
    9788:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    978c:	e1520003 	cmp	r2, r3
    9790:	aa000008 	bge	97b8 <_Z5bzeroPvi+0x58>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:158 (discriminator 2)
		mem[i] = 0;
    9794:	e51b3008 	ldr	r3, [fp, #-8]
    9798:	e51b200c 	ldr	r2, [fp, #-12]
    979c:	e0823003 	add	r3, r2, r3
    97a0:	e3a02000 	mov	r2, #0
    97a4:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:157 (discriminator 2)
	for (int i = 0; i < length; i++)
    97a8:	e51b3008 	ldr	r3, [fp, #-8]
    97ac:	e2833001 	add	r3, r3, #1
    97b0:	e50b3008 	str	r3, [fp, #-8]
    97b4:	eafffff2 	b	9784 <_Z5bzeroPvi+0x24>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:159
}
    97b8:	e320f000 	nop	{0}
    97bc:	e28bd000 	add	sp, fp, #0
    97c0:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    97c4:	e12fff1e 	bx	lr

000097c8 <_Z6memcpyPKvPvi>:
_Z6memcpyPKvPvi():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:162

void memcpy(const void* src, void* dst, int num)
{
    97c8:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    97cc:	e28db000 	add	fp, sp, #0
    97d0:	e24dd024 	sub	sp, sp, #36	; 0x24
    97d4:	e50b0018 	str	r0, [fp, #-24]	; 0xffffffe8
    97d8:	e50b101c 	str	r1, [fp, #-28]	; 0xffffffe4
    97dc:	e50b2020 	str	r2, [fp, #-32]	; 0xffffffe0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:163
	const char* memsrc = reinterpret_cast<const char*>(src);
    97e0:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    97e4:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:164
	char* memdst = reinterpret_cast<char*>(dst);
    97e8:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    97ec:	e50b3010 	str	r3, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:166

	for (int i = 0; i < num; i++)
    97f0:	e3a03000 	mov	r3, #0
    97f4:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:166 (discriminator 3)
    97f8:	e51b2008 	ldr	r2, [fp, #-8]
    97fc:	e51b3020 	ldr	r3, [fp, #-32]	; 0xffffffe0
    9800:	e1520003 	cmp	r2, r3
    9804:	aa00000b 	bge	9838 <_Z6memcpyPKvPvi+0x70>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:167 (discriminator 2)
		memdst[i] = memsrc[i];
    9808:	e51b3008 	ldr	r3, [fp, #-8]
    980c:	e51b200c 	ldr	r2, [fp, #-12]
    9810:	e0822003 	add	r2, r2, r3
    9814:	e51b3008 	ldr	r3, [fp, #-8]
    9818:	e51b1010 	ldr	r1, [fp, #-16]
    981c:	e0813003 	add	r3, r1, r3
    9820:	e5d22000 	ldrb	r2, [r2]
    9824:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:166 (discriminator 2)
	for (int i = 0; i < num; i++)
    9828:	e51b3008 	ldr	r3, [fp, #-8]
    982c:	e2833001 	add	r3, r3, #1
    9830:	e50b3008 	str	r3, [fp, #-8]
    9834:	eaffffef 	b	97f8 <_Z6memcpyPKvPvi+0x30>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:168
}
    9838:	e320f000 	nop	{0}
    983c:	e28bd000 	add	sp, fp, #0
    9840:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    9844:	e12fff1e 	bx	lr

00009848 <_Z6concatPcPKc>:
_Z6concatPcPKc():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:170

void concat(char* dest, const char* src) {
    9848:	e92d4800 	push	{fp, lr}
    984c:	e28db004 	add	fp, sp, #4
    9850:	e24dd010 	sub	sp, sp, #16
    9854:	e50b0010 	str	r0, [fp, #-16]
    9858:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:171
	int i = strlen(dest);
    985c:	e51b0010 	ldr	r0, [fp, #-16]
    9860:	ebffffa9 	bl	970c <_Z6strlenPKc>
    9864:	e50b0008 	str	r0, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:172
	int j = strlen(src);
    9868:	e51b0014 	ldr	r0, [fp, #-20]	; 0xffffffec
    986c:	ebffffa6 	bl	970c <_Z6strlenPKc>
    9870:	e50b000c 	str	r0, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:173
	strncpy(dest + i, src, j);
    9874:	e51b3008 	ldr	r3, [fp, #-8]
    9878:	e51b2010 	ldr	r2, [fp, #-16]
    987c:	e0823003 	add	r3, r2, r3
    9880:	e51b200c 	ldr	r2, [fp, #-12]
    9884:	e51b1014 	ldr	r1, [fp, #-20]	; 0xffffffec
    9888:	e1a00003 	mov	r0, r3
    988c:	ebffff43 	bl	95a0 <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:174
	dest[i + j + 1] = '\0';
    9890:	e51b2008 	ldr	r2, [fp, #-8]
    9894:	e51b300c 	ldr	r3, [fp, #-12]
    9898:	e0823003 	add	r3, r2, r3
    989c:	e2833001 	add	r3, r3, #1
    98a0:	e51b2010 	ldr	r2, [fp, #-16]
    98a4:	e0823003 	add	r3, r2, r3
    98a8:	e3a02000 	mov	r2, #0
    98ac:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:175
    98b0:	e320f000 	nop	{0}
    98b4:	e24bd004 	sub	sp, fp, #4
    98b8:	e8bd8800 	pop	{fp, pc}

000098bc <__udivsi3>:
__udivsi3():
    98bc:	e2512001 	subs	r2, r1, #1
    98c0:	012fff1e 	bxeq	lr
    98c4:	3a000074 	bcc	9a9c <__udivsi3+0x1e0>
    98c8:	e1500001 	cmp	r0, r1
    98cc:	9a00006b 	bls	9a80 <__udivsi3+0x1c4>
    98d0:	e1110002 	tst	r1, r2
    98d4:	0a00006c 	beq	9a8c <__udivsi3+0x1d0>
    98d8:	e16f3f10 	clz	r3, r0
    98dc:	e16f2f11 	clz	r2, r1
    98e0:	e0423003 	sub	r3, r2, r3
    98e4:	e273301f 	rsbs	r3, r3, #31
    98e8:	10833083 	addne	r3, r3, r3, lsl #1
    98ec:	e3a02000 	mov	r2, #0
    98f0:	108ff103 	addne	pc, pc, r3, lsl #2
    98f4:	e1a00000 	nop			; (mov r0, r0)
    98f8:	e1500f81 	cmp	r0, r1, lsl #31
    98fc:	e0a22002 	adc	r2, r2, r2
    9900:	20400f81 	subcs	r0, r0, r1, lsl #31
    9904:	e1500f01 	cmp	r0, r1, lsl #30
    9908:	e0a22002 	adc	r2, r2, r2
    990c:	20400f01 	subcs	r0, r0, r1, lsl #30
    9910:	e1500e81 	cmp	r0, r1, lsl #29
    9914:	e0a22002 	adc	r2, r2, r2
    9918:	20400e81 	subcs	r0, r0, r1, lsl #29
    991c:	e1500e01 	cmp	r0, r1, lsl #28
    9920:	e0a22002 	adc	r2, r2, r2
    9924:	20400e01 	subcs	r0, r0, r1, lsl #28
    9928:	e1500d81 	cmp	r0, r1, lsl #27
    992c:	e0a22002 	adc	r2, r2, r2
    9930:	20400d81 	subcs	r0, r0, r1, lsl #27
    9934:	e1500d01 	cmp	r0, r1, lsl #26
    9938:	e0a22002 	adc	r2, r2, r2
    993c:	20400d01 	subcs	r0, r0, r1, lsl #26
    9940:	e1500c81 	cmp	r0, r1, lsl #25
    9944:	e0a22002 	adc	r2, r2, r2
    9948:	20400c81 	subcs	r0, r0, r1, lsl #25
    994c:	e1500c01 	cmp	r0, r1, lsl #24
    9950:	e0a22002 	adc	r2, r2, r2
    9954:	20400c01 	subcs	r0, r0, r1, lsl #24
    9958:	e1500b81 	cmp	r0, r1, lsl #23
    995c:	e0a22002 	adc	r2, r2, r2
    9960:	20400b81 	subcs	r0, r0, r1, lsl #23
    9964:	e1500b01 	cmp	r0, r1, lsl #22
    9968:	e0a22002 	adc	r2, r2, r2
    996c:	20400b01 	subcs	r0, r0, r1, lsl #22
    9970:	e1500a81 	cmp	r0, r1, lsl #21
    9974:	e0a22002 	adc	r2, r2, r2
    9978:	20400a81 	subcs	r0, r0, r1, lsl #21
    997c:	e1500a01 	cmp	r0, r1, lsl #20
    9980:	e0a22002 	adc	r2, r2, r2
    9984:	20400a01 	subcs	r0, r0, r1, lsl #20
    9988:	e1500981 	cmp	r0, r1, lsl #19
    998c:	e0a22002 	adc	r2, r2, r2
    9990:	20400981 	subcs	r0, r0, r1, lsl #19
    9994:	e1500901 	cmp	r0, r1, lsl #18
    9998:	e0a22002 	adc	r2, r2, r2
    999c:	20400901 	subcs	r0, r0, r1, lsl #18
    99a0:	e1500881 	cmp	r0, r1, lsl #17
    99a4:	e0a22002 	adc	r2, r2, r2
    99a8:	20400881 	subcs	r0, r0, r1, lsl #17
    99ac:	e1500801 	cmp	r0, r1, lsl #16
    99b0:	e0a22002 	adc	r2, r2, r2
    99b4:	20400801 	subcs	r0, r0, r1, lsl #16
    99b8:	e1500781 	cmp	r0, r1, lsl #15
    99bc:	e0a22002 	adc	r2, r2, r2
    99c0:	20400781 	subcs	r0, r0, r1, lsl #15
    99c4:	e1500701 	cmp	r0, r1, lsl #14
    99c8:	e0a22002 	adc	r2, r2, r2
    99cc:	20400701 	subcs	r0, r0, r1, lsl #14
    99d0:	e1500681 	cmp	r0, r1, lsl #13
    99d4:	e0a22002 	adc	r2, r2, r2
    99d8:	20400681 	subcs	r0, r0, r1, lsl #13
    99dc:	e1500601 	cmp	r0, r1, lsl #12
    99e0:	e0a22002 	adc	r2, r2, r2
    99e4:	20400601 	subcs	r0, r0, r1, lsl #12
    99e8:	e1500581 	cmp	r0, r1, lsl #11
    99ec:	e0a22002 	adc	r2, r2, r2
    99f0:	20400581 	subcs	r0, r0, r1, lsl #11
    99f4:	e1500501 	cmp	r0, r1, lsl #10
    99f8:	e0a22002 	adc	r2, r2, r2
    99fc:	20400501 	subcs	r0, r0, r1, lsl #10
    9a00:	e1500481 	cmp	r0, r1, lsl #9
    9a04:	e0a22002 	adc	r2, r2, r2
    9a08:	20400481 	subcs	r0, r0, r1, lsl #9
    9a0c:	e1500401 	cmp	r0, r1, lsl #8
    9a10:	e0a22002 	adc	r2, r2, r2
    9a14:	20400401 	subcs	r0, r0, r1, lsl #8
    9a18:	e1500381 	cmp	r0, r1, lsl #7
    9a1c:	e0a22002 	adc	r2, r2, r2
    9a20:	20400381 	subcs	r0, r0, r1, lsl #7
    9a24:	e1500301 	cmp	r0, r1, lsl #6
    9a28:	e0a22002 	adc	r2, r2, r2
    9a2c:	20400301 	subcs	r0, r0, r1, lsl #6
    9a30:	e1500281 	cmp	r0, r1, lsl #5
    9a34:	e0a22002 	adc	r2, r2, r2
    9a38:	20400281 	subcs	r0, r0, r1, lsl #5
    9a3c:	e1500201 	cmp	r0, r1, lsl #4
    9a40:	e0a22002 	adc	r2, r2, r2
    9a44:	20400201 	subcs	r0, r0, r1, lsl #4
    9a48:	e1500181 	cmp	r0, r1, lsl #3
    9a4c:	e0a22002 	adc	r2, r2, r2
    9a50:	20400181 	subcs	r0, r0, r1, lsl #3
    9a54:	e1500101 	cmp	r0, r1, lsl #2
    9a58:	e0a22002 	adc	r2, r2, r2
    9a5c:	20400101 	subcs	r0, r0, r1, lsl #2
    9a60:	e1500081 	cmp	r0, r1, lsl #1
    9a64:	e0a22002 	adc	r2, r2, r2
    9a68:	20400081 	subcs	r0, r0, r1, lsl #1
    9a6c:	e1500001 	cmp	r0, r1
    9a70:	e0a22002 	adc	r2, r2, r2
    9a74:	20400001 	subcs	r0, r0, r1
    9a78:	e1a00002 	mov	r0, r2
    9a7c:	e12fff1e 	bx	lr
    9a80:	03a00001 	moveq	r0, #1
    9a84:	13a00000 	movne	r0, #0
    9a88:	e12fff1e 	bx	lr
    9a8c:	e16f2f11 	clz	r2, r1
    9a90:	e262201f 	rsb	r2, r2, #31
    9a94:	e1a00230 	lsr	r0, r0, r2
    9a98:	e12fff1e 	bx	lr
    9a9c:	e3500000 	cmp	r0, #0
    9aa0:	13e00000 	mvnne	r0, #0
    9aa4:	ea000007 	b	9ac8 <__aeabi_idiv0>

00009aa8 <__aeabi_uidivmod>:
__aeabi_uidivmod():
    9aa8:	e3510000 	cmp	r1, #0
    9aac:	0afffffa 	beq	9a9c <__udivsi3+0x1e0>
    9ab0:	e92d4003 	push	{r0, r1, lr}
    9ab4:	ebffff80 	bl	98bc <__udivsi3>
    9ab8:	e8bd4006 	pop	{r1, r2, lr}
    9abc:	e0030092 	mul	r3, r2, r0
    9ac0:	e0411003 	sub	r1, r1, r3
    9ac4:	e12fff1e 	bx	lr

00009ac8 <__aeabi_idiv0>:
__aeabi_ldiv0():
    9ac8:	e12fff1e 	bx	lr

Disassembly of section .rodata:

00009acc <_ZL13Lock_Unlocked>:
    9acc:	00000000 	andeq	r0, r0, r0

00009ad0 <_ZL11Lock_Locked>:
    9ad0:	00000001 	andeq	r0, r0, r1

00009ad4 <_ZL21MaxFSDriverNameLength>:
    9ad4:	00000010 	andeq	r0, r0, r0, lsl r0

00009ad8 <_ZL17MaxFilenameLength>:
    9ad8:	00000010 	andeq	r0, r0, r0, lsl r0

00009adc <_ZL13MaxPathLength>:
    9adc:	00000080 	andeq	r0, r0, r0, lsl #1

00009ae0 <_ZL18NoFilesystemDriver>:
    9ae0:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00009ae4 <_ZL9NotifyAll>:
    9ae4:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00009ae8 <_ZL24Max_Process_Opened_Files>:
    9ae8:	00000010 	andeq	r0, r0, r0, lsl r0

00009aec <_ZL10Indefinite>:
    9aec:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00009af0 <_ZL18Deadline_Unchanged>:
    9af0:	fffffffe 			; <UNDEFINED> instruction: 0xfffffffe

00009af4 <_ZL14Invalid_Handle>:
    9af4:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00009af8 <_ZN3halL18Default_Clock_RateE>:
    9af8:	0ee6b280 	cdpeq	2, 14, cr11, cr6, cr0, {4}

00009afc <_ZN3halL15Peripheral_BaseE>:
    9afc:	20000000 	andcs	r0, r0, r0

00009b00 <_ZN3halL9GPIO_BaseE>:
    9b00:	20200000 	eorcs	r0, r0, r0

00009b04 <_ZN3halL14GPIO_Pin_CountE>:
    9b04:	00000036 	andeq	r0, r0, r6, lsr r0

00009b08 <_ZN3halL8AUX_BaseE>:
    9b08:	20215000 	eorcs	r5, r1, r0

00009b0c <_ZN3halL25Interrupt_Controller_BaseE>:
    9b0c:	2000b200 	andcs	fp, r0, r0, lsl #4

00009b10 <_ZN3halL10Timer_BaseE>:
    9b10:	2000b400 	andcs	fp, r0, r0, lsl #8

00009b14 <_ZN3halL9TRNG_BaseE>:
    9b14:	20104000 	andscs	r4, r0, r0

00009b18 <_ZN3halL9BSC0_BaseE>:
    9b18:	20205000 	eorcs	r5, r0, r0

00009b1c <_ZN3halL9BSC1_BaseE>:
    9b1c:	20804000 	addcs	r4, r0, r0

00009b20 <_ZN3halL9BSC2_BaseE>:
    9b20:	20805000 	addcs	r5, r0, r0

00009b24 <_ZN3halL14I2C_SLAVE_BaseE>:
    9b24:	20214000 	eorcs	r4, r1, r0

00009b28 <_ZL11Invalid_Pin>:
    9b28:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00009b2c <_ZL24I2C_Transaction_Max_Size>:
    9b2c:	00000008 	andeq	r0, r0, r8

00009b30 <_ZL21I2C_SLAVE_Buffer_Size>:
    9b30:	00000080 	andeq	r0, r0, r0, lsl #1

00009b34 <_ZL11UPPER_BOUND>:
    9b34:	41300000 	teqmi	r0, r0

00009b38 <_ZL11LOWER_BOUND>:
    9b38:	40600000 	rsbmi	r0, r0, r0

00009b3c <_ZL7ADDRESS>:
    9b3c:	00000001 	andeq	r0, r0, r1

00009b40 <_ZL14TARGET_ADDRESS>:
    9b40:	00000002 	andeq	r0, r0, r2

00009b44 <_ZL12DESIRED_ROLE>:
    9b44:	00000001 	andeq	r0, r0, r1

00009b48 <_ZL13random_values>:
    9b48:	40d6b852 	sbcsmi	fp, r6, r2, asr r8
    9b4c:	40875c29 	addmi	r5, r7, r9, lsr #24
    9b50:	40a3d70a 	adcmi	sp, r3, sl, lsl #14
    9b54:	407f5c29 	rsbsmi	r5, pc, r9, lsr #24
    9b58:	400e147b 	andmi	r1, lr, fp, ror r4
    9b5c:	40e66666 	rscmi	r6, r6, r6, ror #12
    9b60:	413ee148 	teqmi	lr, r8, asr #2
    9b64:	412f5c29 			; <UNDEFINED> instruction: 0x412f5c29

00009b68 <_ZL17random_values_len>:
    9b68:	00000008 	andeq	r0, r0, r8
    9b6c:	5453414d 	ldrbpl	r4, [r3], #-333	; 0xfffffeb3
    9b70:	203a5245 	eorscs	r5, sl, r5, asr #4
    9b74:	00000000 	andeq	r0, r0, r0
    9b78:	56414c53 			; <UNDEFINED> instruction: 0x56414c53
    9b7c:	00203a45 	eoreq	r3, r0, r5, asr #20
    9b80:	45534e55 	ldrbmi	r4, [r3, #-3669]	; 0xfffff1ab
    9b84:	00203a54 	eoreq	r3, r0, r4, asr sl
    9b88:	646e6553 	strbtvs	r6, [lr], #-1363	; 0xfffffaad
    9b8c:	3a676e69 	bcc	19e5538 <__bss_end+0x19db7ac>
    9b90:	00000020 	andeq	r0, r0, r0, lsr #32
    9b94:	0000000a 	andeq	r0, r0, sl
    9b98:	0074736d 	rsbseq	r7, r4, sp, ror #6
    9b9c:	00766c73 	rsbseq	r6, r6, r3, ror ip
    9ba0:	69736544 	ldmdbvs	r3!, {r2, r6, r8, sl, sp, lr}^
    9ba4:	20646572 	rsbcs	r6, r4, r2, ror r5
    9ba8:	656c6f72 	strbvs	r6, [ip, #-3954]!	; 0xfffff08e
    9bac:	72612073 	rsbvc	r2, r1, #115	; 0x73
    9bb0:	68742065 	ldmdavs	r4!, {r0, r2, r5, r6, sp}^
    9bb4:	61732065 	cmnvs	r3, r5, rrx
    9bb8:	000a656d 	andeq	r6, sl, sp, ror #10
    9bbc:	656c6f52 	strbvs	r6, [ip, #-3922]!	; 0xfffff0ae
    9bc0:	65732073 	ldrbvs	r2, [r3, #-115]!	; 0xffffff8d
    9bc4:	49202e74 	stmdbmi	r0!, {r2, r4, r5, r6, r9, sl, fp, sp}
    9bc8:	206d6120 	rsbcs	r6, sp, r0, lsr #2
    9bcc:	00000000 	andeq	r0, r0, r0
    9bd0:	7473614d 	ldrbtvc	r6, [r3], #-333	; 0xfffffeb3
    9bd4:	000a7265 	andeq	r7, sl, r5, ror #4
    9bd8:	76616c53 			; <UNDEFINED> instruction: 0x76616c53
    9bdc:	00000a65 	andeq	r0, r0, r5, ror #20
    9be0:	65636552 	strbvs	r6, [r3, #-1362]!	; 0xfffffaae
    9be4:	64657669 	strbtvs	r7, [r5], #-1641	; 0xfffff997
    9be8:	00000020 	andeq	r0, r0, r0, lsr #32
    9bec:	4f202d20 	svcmi	0x00202d20
    9bf0:	0000004b 	andeq	r0, r0, fp, asr #32
    9bf4:	44202d20 	strtmi	r2, [r0], #-3360	; 0xfffff2e0
    9bf8:	45474e41 	strbmi	r4, [r7, #-3649]	; 0xfffff1bf
    9bfc:	00000052 	andeq	r0, r0, r2, asr r0
    9c00:	57202d20 	strpl	r2, [r0, -r0, lsr #26]!
    9c04:	494e5241 	stmdbmi	lr, {r0, r6, r9, ip, lr}^
    9c08:	0000474e 	andeq	r4, r0, lr, asr #14
    9c0c:	00676f6c 	rsbeq	r6, r7, ip, ror #30
    9c10:	6b736154 	blvs	1ce2168 <__bss_end+0x1cd83dc>
    9c14:	73203220 			; <UNDEFINED> instruction: 0x73203220
    9c18:	74726174 	ldrbtvc	r6, [r2], #-372	; 0xfffffe8c
    9c1c:	000a6465 	andeq	r6, sl, r5, ror #8
    9c20:	3a564544 	bcc	159b138 <__bss_end+0x15913ac>
    9c24:	2f633269 	svccs	0x00633269
    9c28:	00000031 	andeq	r0, r0, r1, lsr r0
    9c2c:	3a564544 	bcc	159b144 <__bss_end+0x15913b8>
    9c30:	2f633269 	svccs	0x00633269
    9c34:	00000032 	andeq	r0, r0, r2, lsr r0
    9c38:	6f727245 	svcvs	0x00727245
    9c3c:	706f2072 	rsbvc	r2, pc, r2, ror r0	; <UNPREDICTABLE>
    9c40:	6e696e65 	cdpvs	14, 6, cr6, cr9, cr5, {3}
    9c44:	32492067 	subcc	r2, r9, #103	; 0x67
    9c48:	6f632043 	svcvs	0x00632043
    9c4c:	63656e6e 	cmnvs	r5, #1760	; 0x6e0
    9c50:	6e6f6974 			; <UNDEFINED> instruction: 0x6e6f6974
    9c54:	0000000a 	andeq	r0, r0, sl
    9c58:	6b736154 	blvs	1ce21b0 <__bss_end+0x1cd8424>
    9c5c:	203a3220 	eorscs	r3, sl, r0, lsr #4
    9c60:	20433249 	subcs	r3, r3, r9, asr #4
    9c64:	6e6e6f63 	cdpvs	15, 6, cr6, cr14, cr3, {3}
    9c68:	69746365 	ldmdbvs	r4!, {r0, r2, r5, r6, r8, r9, sp, lr}^
    9c6c:	73206e6f 			; <UNDEFINED> instruction: 0x73206e6f
    9c70:	74726174 	ldrbtvc	r6, [r2], #-372	; 0xfffffe8c
    9c74:	2e2e6465 	cdpcs	4, 2, cr6, cr14, cr5, {3}
    9c78:	00000a2e 	andeq	r0, r0, lr, lsr #20
    9c7c:	6e65704f 	cdpvs	0, 6, cr7, cr5, cr15, {2}
    9c80:	6c696620 	stclvs	6, cr6, [r9], #-128	; 0xffffff80
    9c84:	63207365 			; <UNDEFINED> instruction: 0x63207365
    9c88:	65736f6c 	ldrbvs	r6, [r3, #-3948]!	; 0xfffff094
    9c8c:	6e692064 	cdpvs	0, 6, cr2, cr9, cr4, {3}
    9c90:	73617420 	cmnvc	r1, #32, 8	; 0x20000000
    9c94:	0a32206b 	beq	c91e48 <__bss_end+0xc880bc>
    9c98:	00000000 	andeq	r0, r0, r0

00009c9c <_ZL13Lock_Unlocked>:
    9c9c:	00000000 	andeq	r0, r0, r0

00009ca0 <_ZL11Lock_Locked>:
    9ca0:	00000001 	andeq	r0, r0, r1

00009ca4 <_ZL21MaxFSDriverNameLength>:
    9ca4:	00000010 	andeq	r0, r0, r0, lsl r0

00009ca8 <_ZL17MaxFilenameLength>:
    9ca8:	00000010 	andeq	r0, r0, r0, lsl r0

00009cac <_ZL13MaxPathLength>:
    9cac:	00000080 	andeq	r0, r0, r0, lsl #1

00009cb0 <_ZL18NoFilesystemDriver>:
    9cb0:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00009cb4 <_ZL9NotifyAll>:
    9cb4:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00009cb8 <_ZL24Max_Process_Opened_Files>:
    9cb8:	00000010 	andeq	r0, r0, r0, lsl r0

00009cbc <_ZL10Indefinite>:
    9cbc:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00009cc0 <_ZL18Deadline_Unchanged>:
    9cc0:	fffffffe 			; <UNDEFINED> instruction: 0xfffffffe

00009cc4 <_ZL14Invalid_Handle>:
    9cc4:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00009cc8 <_ZL16Pipe_File_Prefix>:
    9cc8:	3a535953 	bcc	14e021c <__bss_end+0x14d6490>
    9ccc:	65706970 	ldrbvs	r6, [r0, #-2416]!	; 0xfffff690
    9cd0:	0000002f 	andeq	r0, r0, pc, lsr #32

00009cd4 <_ZN12_GLOBAL__N_1L11CharConvArrE>:
    9cd4:	33323130 	teqcc	r2, #48, 2
    9cd8:	37363534 			; <UNDEFINED> instruction: 0x37363534
    9cdc:	42413938 	submi	r3, r1, #56, 18	; 0xe0000
    9ce0:	46454443 	strbmi	r4, [r5], -r3, asr #8
	...

Disassembly of section .data:

00009ce8 <__CTOR_LIST__>:
__DTOR_END__():
    9ce8:	00000002 	andeq	r0, r0, r2

00009cec <prev_value>:
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:23
float prev_value = random_values[0];
    9cec:	40d6b852 	sbcsmi	fp, r6, r2, asr r8

Disassembly of section .bss:

00009cf0 <log_fd>:
__bss_start():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/master_task/main.cpp:17
uint32_t log_fd, i2c_fd;
    9cf0:	00000000 	andeq	r0, r0, r0

00009cf4 <i2c_fd>:
    9cf4:	00000000 	andeq	r0, r0, r0

00009cf8 <received_values>:
	...

00009d78 <received_values_len>:
	...

Disassembly of section .ARM.attributes:

00000000 <.ARM.attributes>:
   0:	00002e41 	andeq	r2, r0, r1, asr #28
   4:	61656100 	cmnvs	r5, r0, lsl #2
   8:	01006962 	tsteq	r0, r2, ror #18
   c:	00000024 	andeq	r0, r0, r4, lsr #32
  10:	4b5a3605 	blmi	168d82c <__bss_end+0x1683aa0>
  14:	08070600 	stmdaeq	r7, {r9, sl}
  18:	0a010901 	beq	42424 <__bss_end+0x38698>
  1c:	14041202 	strne	r1, [r4], #-514	; 0xfffffdfe
  20:	17011501 	strne	r1, [r1, -r1, lsl #10]
  24:	1a011803 	bne	46038 <__bss_end+0x3c2ac>
  28:	22011c01 	andcs	r1, r1, #256	; 0x100
  2c:	Address 0x000000000000002c is out of bounds.


Disassembly of section .comment:

00000000 <.comment>:
   0:	3a434347 	bcc	10d0d24 <__bss_end+0x10c6f98>
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
  38:	7a617661 	bvc	185d9c4 <__bss_end+0x1853c38>
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
  c0:	6a757a61 	bvs	1d5ea4c <__bss_end+0x1d54cc0>
  c4:	2f696369 	svccs	0x00696369
  c8:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
  cc:	73656d65 	cmnvc	r5, #6464	; 0x1940
  d0:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
  d4:	6b2d616b 	blvs	b58688 <__bss_end+0xb4e8fc>
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
 144:	fb010200 	blx	4094e <__bss_end+0x36bc2>
 148:	01000d0e 	tsteq	r0, lr, lsl #26
 14c:	00010101 	andeq	r0, r1, r1, lsl #2
 150:	00010000 	andeq	r0, r1, r0
 154:	552f0100 	strpl	r0, [pc, #-256]!	; 5c <shift+0x5c>
 158:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 15c:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 160:	6a726574 	bvs	1c99738 <__bss_end+0x1c8f9ac>
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
 198:	752f7365 	strvc	r7, [pc, #-869]!	; fffffe3b <__bss_end+0xffff60af>
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
 1d0:	0a05830b 	beq	160e04 <__bss_end+0x157078>
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
 1fc:	4a030402 	bmi	c120c <__bss_end+0xb7480>
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
 230:	4a020402 	bmi	81240 <__bss_end+0x774b4>
 234:	02000205 	andeq	r0, r0, #1342177280	; 0x50000000
 238:	052d0204 	streq	r0, [sp, #-516]!	; 0xfffffdfc
 23c:	01058509 	tsteq	r5, r9, lsl #10
 240:	000a022f 	andeq	r0, sl, pc, lsr #4
 244:	05890101 	streq	r0, [r9, #257]	; 0x101
 248:	00030000 	andeq	r0, r3, r0
 24c:	00000327 	andeq	r0, r0, r7, lsr #6
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
 280:	6a757a61 	bvs	1d5ec0c <__bss_end+0x1d54e80>
 284:	2f696369 	svccs	0x00696369
 288:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
 28c:	73656d65 	cmnvc	r5, #6464	; 0x1940
 290:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
 294:	6b2d616b 	blvs	b58848 <__bss_end+0xb4eabc>
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
 2cc:	6b736544 	blvs	1cd97e4 <__bss_end+0x1ccfa58>
 2d0:	2f706f74 	svccs	0x00706f74
 2d4:	2f564146 	svccs	0x00564146
 2d8:	6176614e 	cmnvs	r6, lr, asr #2
 2dc:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
 2e0:	4f2f6963 	svcmi	0x002f6963
 2e4:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
 2e8:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
 2ec:	6b6c6172 	blvs	1b188bc <__bss_end+0x1b0eb30>
 2f0:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
 2f4:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
 2f8:	756f732f 	strbvc	r7, [pc, #-815]!	; ffffffd1 <__bss_end+0xffff6245>
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
 33c:	6b736544 	blvs	1cd9854 <__bss_end+0x1ccfac8>
 340:	2f706f74 	svccs	0x00706f74
 344:	2f564146 	svccs	0x00564146
 348:	6176614e 	cmnvs	r6, lr, asr #2
 34c:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
 350:	4f2f6963 	svcmi	0x002f6963
 354:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
 358:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
 35c:	6b6c6172 	blvs	1b1892c <__bss_end+0x1b0eba0>
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
 3b4:	6a757a61 	bvs	1d5ed40 <__bss_end+0x1d54fb4>
 3b8:	2f696369 	svccs	0x00696369
 3bc:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
 3c0:	73656d65 	cmnvc	r5, #6464	; 0x1940
 3c4:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
 3c8:	6b2d616b 	blvs	b5897c <__bss_end+0xb4ebf0>
 3cc:	6f2d7669 	svcvs	0x002d7669
 3d0:	6f732f73 	svcvs	0x00732f73
 3d4:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
 3d8:	73752f73 	cmnvc	r5, #460	; 0x1cc
 3dc:	70737265 	rsbsvc	r7, r3, r5, ror #4
 3e0:	2f656361 	svccs	0x00656361
 3e4:	6b2f2e2e 	blvs	bcbca4 <__bss_end+0xbc1f18>
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
 418:	6a757a61 	bvs	1d5eda4 <__bss_end+0x1d55018>
 41c:	2f696369 	svccs	0x00696369
 420:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
 424:	73656d65 	cmnvc	r5, #6464	; 0x1940
 428:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
 42c:	6b2d616b 	blvs	b589e0 <__bss_end+0xb4ec54>
 430:	6f2d7669 	svcvs	0x002d7669
 434:	6f732f73 	svcvs	0x00732f73
 438:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
 43c:	73752f73 	cmnvc	r5, #460	; 0x1cc
 440:	70737265 	rsbsvc	r7, r3, r5, ror #4
 444:	2f656361 	svccs	0x00656361
 448:	6b2f2e2e 	blvs	bcbd08 <__bss_end+0xbc1f7c>
 44c:	656e7265 	strbvs	r7, [lr, #-613]!	; 0xfffffd9b
 450:	6e692f6c 	cdpvs	15, 6, cr2, cr9, cr12, {3}
 454:	64756c63 	ldrbtvs	r6, [r5], #-3171	; 0xfffff39d
 458:	72642f65 	rsbvc	r2, r4, #404	; 0x194
 45c:	72657669 	rsbvc	r7, r5, #110100480	; 0x6900000
 460:	552f0073 	strpl	r0, [pc, #-115]!	; 3f5 <shift+0x3f5>
 464:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 468:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 46c:	6a726574 	bvs	1c99a44 <__bss_end+0x1c8fcb8>
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
 564:	69000005 	stmdbvs	r0, {r0, r2}
 568:	735f6332 	cmpvc	pc, #-939524096	; 0xc8000000
 56c:	6576616c 	ldrbvs	r6, [r6, #-364]!	; 0xfffffe94
 570:	0500682e 	streq	r6, [r0, #-2094]	; 0xfffff7d2
 574:	05000000 	streq	r0, [r0, #-0]
 578:	0205002c 	andeq	r0, r5, #44	; 0x2c
 57c:	0000822c 	andeq	r8, r0, ip, lsr #4
 580:	05011b03 	streq	r1, [r1, #-2819]	; 0xfffff4fd
 584:	10059f05 	andne	r9, r5, r5, lsl #30
 588:	830905d9 	movwhi	r0, #38361	; 0x95d9
 58c:	05301005 	ldreq	r1, [r0, #-5]!
 590:	10058309 	andne	r8, r5, r9, lsl #6
 594:	83090530 	movwhi	r0, #38192	; 0x9530
 598:	05310c05 	ldreq	r0, [r1, #-3077]!	; 0xfffff3fb
 59c:	d9210801 	stmdble	r1!, {r0, fp}
 5a0:	05852b05 	streq	r2, [r5, #2821]	; 0xb05
 5a4:	22054819 	andcs	r4, r5, #1638400	; 0x190000
 5a8:	2e0a0566 	cfsh32cs	mvfx0, mvfx10, #54
 5ac:	3c020d05 	stccc	13, cr0, [r2], {5}
 5b0:	670a0513 	smladvs	sl, r3, r5, r0
 5b4:	054a2305 	strbeq	r2, [sl, #-773]	; 0xfffffcfb
 5b8:	0a056628 	beq	159e60 <__bss_end+0x1500d4>
 5bc:	9f01052e 	svcls	0x0001052e
 5c0:	05842005 	streq	r2, [r4, #5]
 5c4:	0d058409 	cfstrseq	mvf8, [r5, #-36]	; 0xffffffdc
 5c8:	9f0a059f 	svcls	0x000a059f
 5cc:	054a1f05 	strbeq	r1, [sl, #-3845]	; 0xfffff0fb
 5d0:	0105820a 	tsteq	r5, sl, lsl #4
 5d4:	0b05859f 	bleq	161c58 <__bss_end+0x157ecc>
 5d8:	4c090583 	cfstr32mi	mvfx0, [r9], {131}	; 0x83
 5dc:	052e0505 	streq	r0, [lr, #-1285]!	; 0xfffffafb
 5e0:	04020020 	streq	r0, [r2], #-32	; 0xffffffe0
 5e4:	1d058201 	sfmne	f0, 1, [r5, #-4]
 5e8:	01040200 	mrseq	r0, R12_usr
 5ec:	8310052e 	tsthi	r0, #192937984	; 0xb800000
 5f0:	05692105 	strbeq	r2, [r9, #-261]!	; 0xfffffefb
 5f4:	18052e27 	stmdane	r5, {r0, r1, r2, r5, r9, sl, fp, sp}
 5f8:	2e160566 	cfmsc32cs	mvfx0, mvfx6, mvfx6
 5fc:	054b0905 	strbeq	r0, [fp, #-2309]	; 0xfffff6fb
 600:	04020028 	streq	r0, [r2], #-40	; 0xffffffd8
 604:	14059e01 	strne	r9, [r5], #-3585	; 0xfffff1ff
 608:	0b05699f 	bleq	15ac8c <__bss_end+0x150f00>
 60c:	bb0c054d 	bllt	301b48 <__bss_end+0x2f7dbc>
 610:	054b0a05 	strbeq	r0, [fp, #-2565]	; 0xfffff5fb
 614:	2405bb01 	strcs	fp, [r5], #-2817	; 0xfffff4ff
 618:	840a05f4 	strhi	r0, [sl], #-1524	; 0xfffffa0c
 61c:	830c0583 	movwhi	r0, #50563	; 0xc583
 620:	059f0905 	ldreq	r0, [pc, #2309]	; f2d <shift+0xf2d>
 624:	059f9f0b 	ldreq	r9, [pc, #3851]	; 1537 <shift+0x1537>
 628:	0e058308 	cdpeq	3, 0, cr8, cr5, cr8, {0}
 62c:	4b010567 	blmi	41bd0 <__bss_end+0x37e44>
 630:	9f0f05a1 	svcls	0x000f05a1
 634:	054b1005 	strbeq	r1, [fp, #-5]
 638:	05059e2c 	streq	r9, [r5, #-3628]	; 0xfffff1d4
 63c:	4c140582 	cfldr32mi	mvfx0, [r4], {130}	; 0x82
 640:	05681505 	strbeq	r1, [r8, #-1285]!	; 0xfffffafb
 644:	0a059e31 	beq	167f10 <__bss_end+0x15e184>
 648:	4c140582 	cfldr32mi	mvfx0, [r4], {130}	; 0x82
 64c:	054d0505 	strbeq	r0, [sp, #-1285]	; 0xfffffafb
 650:	1f056809 	svcne	0x00056809
 654:	4c0e0568 	cfstr32mi	mvfx0, [lr], {104}	; 0x68
 658:	05681f05 	strbeq	r1, [r8, #-3845]!	; 0xfffff0fb
 65c:	10054e09 	andne	r4, r5, r9, lsl #28
 660:	4c230584 	cfstr32mi	mvfx0, [r3], #-528	; 0xfffffdf0
 664:	054f0c05 	strbeq	r0, [pc, #-3077]	; fffffa67 <__bss_end+0xffff5cdb>
 668:	05bd2f01 	ldreq	r2, [sp, #3841]!	; 0xf01
 66c:	8383840a 	orrhi	r8, r3, #167772160	; 0xa000000
 670:	05830505 	streq	r0, [r3, #1285]	; 0x505
 674:	0905d910 	stmdbeq	r5, {r4, r8, fp, ip, lr, pc}
 678:	3010059f 	mulscc	r0, pc, r5	; <UNPREDICTABLE>
 67c:	059f0905 	ldreq	r0, [pc, #2309]	; f89 <shift+0xf89>
 680:	09053010 	stmdbeq	r5, {r4, ip, sp}
 684:	310a059f 			; <UNDEFINED> instruction: 0x310a059f
 688:	05bb1205 	ldreq	r1, [fp, #517]!	; 0x205
 68c:	0d058219 	sfmeq	f0, 1, [r5, #-100]	; 0xffffff9c
 690:	bb0e05bb 	bllt	381d84 <__bss_end+0x377ff8>
 694:	05640505 	strbeq	r0, [r4, #-1285]!	; 0xfffffafb
 698:	1105331e 	tstne	r5, lr, lsl r3
 69c:	4b0c059e 	blmi	301d1c <__bss_end+0x2f7f90>
 6a0:	059f0505 	ldreq	r0, [pc, #1285]	; bad <shift+0xbad>
 6a4:	0905d90f 	stmdbeq	r5, {r0, r1, r2, r3, r8, fp, ip, lr, pc}
 6a8:	300f0583 	andcc	r0, pc, r3, lsl #11
 6ac:	05830905 	streq	r0, [r3, #2309]	; 0x905
 6b0:	18053008 	stmdane	r5, {r3, ip, sp}
 6b4:	4a1b0567 	bmi	6c1c58 <__bss_end+0x6b7ecc>
 6b8:	089f0105 	ldmeq	pc, {r0, r2, r8}	; <UNPREDICTABLE>
 6bc:	bc0a053f 	cfstr32lt	mvfx0, [sl], {63}	; 0x3f
 6c0:	830c0583 	movwhi	r0, #50563	; 0xc583
 6c4:	059f0905 	ldreq	r0, [pc, #2309]	; fd1 <shift+0xfd1>
 6c8:	0d059f0b 	stceq	15, cr9, [r5, #-44]	; 0xffffffd4
 6cc:	2e05059f 	mcrcs	5, 0, r0, cr5, cr15, {4}
 6d0:	24080f05 	strcs	r0, [r8], #-3845	; 0xfffff0fb
 6d4:	05830905 	streq	r0, [r3, #2309]	; 0x905
 6d8:	0905310f 	stmdbeq	r5, {r0, r1, r2, r3, r8, ip, sp}
 6dc:	310f0583 	smlabbcc	pc, r3, r5, r0	; <UNPREDICTABLE>
 6e0:	05830905 	streq	r0, [r3, #2309]	; 0x905
 6e4:	0805310b 	stmdaeq	r5, {r0, r1, r3, r8, ip, sp}
 6e8:	67010583 	strvs	r0, [r1, -r3, lsl #11]
 6ec:	680a05f5 	stmdavs	sl, {r0, r2, r4, r5, r6, r7, r8, sl}
 6f0:	86120583 	ldrhi	r0, [r2], -r3, lsl #11
 6f4:	05821905 	streq	r1, [r2, #2309]	; 0x905
 6f8:	0e05bb0d 	vmlaeq.f64	d11, d5, d13
 6fc:	640505bb 	strvs	r0, [r5], #-1467	; 0xfffffa45
 700:	05331105 	ldreq	r1, [r3, #-261]!	; 0xfffffefb
 704:	10054b0b 	andne	r4, r5, fp, lsl #22
 708:	9f0105bc 	svcls	0x000105bc
 70c:	05841405 	streq	r1, [r4, #1029]	; 0x405
 710:	0402000e 	streq	r0, [r2], #-14
 714:	02006a01 	andeq	r6, r0, #4096	; 0x1000
 718:	05830104 	streq	r0, [r3, #260]	; 0x104
 71c:	04020015 	streq	r0, [r2], #-21	; 0xffffffeb
 720:	0e058301 	cdpeq	3, 0, cr8, cr5, cr1, {0}
 724:	01040200 	mrseq	r0, R12_usr
 728:	04020030 	streq	r0, [r2], #-48	; 0xffffffd0
 72c:	13056201 	movwne	r6, #20993	; 0x5201
 730:	670e0536 	smladxvs	lr, r6, r5, r0
 734:	02002905 	andeq	r2, r0, #81920	; 0x14000
 738:	054c0104 	strbeq	r0, [ip, #-260]	; 0xfffffefc
 73c:	04020013 	streq	r0, [r2], #-19	; 0xffffffed
 740:	2b059e01 	blcs	167f4c <__bss_end+0x15e1c0>
 744:	01040200 	mrseq	r0, R12_usr
 748:	0014054b 	andseq	r0, r4, fp, asr #10
 74c:	9e010402 	cdpls	4, 0, cr0, cr1, cr2, {0}
 750:	02001c05 	andeq	r1, r0, #1280	; 0x500
 754:	054b0104 	strbeq	r0, [fp, #-260]	; 0xfffffefc
 758:	04020011 	streq	r0, [r2], #-17	; 0xffffffef
 75c:	0e054a01 	vmlaeq.f32	s8, s10, s2
 760:	01040200 	mrseq	r0, R12_usr
 764:	0013054b 	andseq	r0, r3, fp, asr #10
 768:	63010402 	movwvs	r0, #5122	; 0x1402
 76c:	056e0105 	strbeq	r0, [lr, #-261]!	; 0xfffffefb
 770:	0a059f0e 	beq	1683b0 <__bss_end+0x15e624>
 774:	8412054c 	ldrhi	r0, [r2], #-1356	; 0xfffffab4
 778:	05820c05 	streq	r0, [r2, #3077]	; 0xc05
 77c:	12054c08 	andne	r4, r5, #8, 24	; 0x800
 780:	820c054d 	andhi	r0, ip, #322961408	; 0x13400000
 784:	054b1005 	strbeq	r1, [fp, #-5]
 788:	16054a05 	strne	r4, [r5], -r5, lsl #20
 78c:	8210054c 	andshi	r0, r0, #76, 10	; 0x13000000
 790:	054b1405 	strbeq	r1, [fp, #-1029]	; 0xfffffbfb
 794:	10054a09 	andne	r4, r5, r9, lsl #20
 798:	4b14054b 	blmi	501ccc <__bss_end+0x4f7f40>
 79c:	4b19054f 	blmi	641ce0 <__bss_end+0x637f54>
 7a0:	054b0a05 	strbeq	r0, [fp, #-2565]	; 0xfffff5fb
 7a4:	0a05bb08 	beq	16f3cc <__bss_end+0x165640>
 7a8:	670e0552 	smlsdvs	lr, r2, r5, r0
 7ac:	054c0505 	strbeq	r0, [ip, #-1285]	; 0xfffffafb
 7b0:	0905d914 	stmdbeq	r5, {r2, r4, r8, fp, ip, lr, pc}
 7b4:	3013052f 	andscc	r0, r3, pc, lsr #10
 7b8:	052f0905 	streq	r0, [pc, #-2309]!	; fffffebb <__bss_end+0xffff612f>
 7bc:	0805310a 	stmdaeq	r5, {r1, r3, r8, ip, sp}
 7c0:	4b0a0583 	blmi	281dd4 <__bss_end+0x278048>
 7c4:	05840c05 	streq	r0, [r4, #3077]	; 0xc05
 7c8:	04020001 	streq	r0, [r2], #-1
 7cc:	1a022f01 	bne	8c3d8 <__bss_end+0x8264c>
 7d0:	c8010100 	stmdagt	r1, {r8}
 7d4:	03000002 	movweq	r0, #2
 7d8:	0001dd00 	andeq	sp, r1, r0, lsl #26
 7dc:	fb010200 	blx	40fe6 <__bss_end+0x3725a>
 7e0:	01000d0e 	tsteq	r0, lr, lsl #26
 7e4:	00010101 	andeq	r0, r1, r1, lsl #2
 7e8:	00010000 	andeq	r0, r1, r0
 7ec:	552f0100 	strpl	r0, [pc, #-256]!	; 6f4 <shift+0x6f4>
 7f0:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 7f4:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 7f8:	6a726574 	bvs	1c99dd0 <__bss_end+0x1c90044>
 7fc:	65442f69 	strbvs	r2, [r4, #-3945]	; 0xfffff097
 800:	6f746b73 	svcvs	0x00746b73
 804:	41462f70 	hvcmi	25328	; 0x62f0
 808:	614e2f56 	cmpvs	lr, r6, asr pc
 80c:	757a6176 	ldrbvc	r6, [sl, #-374]!	; 0xfffffe8a
 810:	6963696a 	stmdbvs	r3!, {r1, r3, r5, r6, r8, fp, sp, lr}^
 814:	2f534f2f 	svccs	0x00534f2f
 818:	656d6573 	strbvs	r6, [sp, #-1395]!	; 0xfffffa8d
 81c:	61727473 	cmnvs	r2, r3, ror r4
 820:	2d616b6c 	vstmdbcs	r1!, {d22-<overflow reg d75>}
 824:	2d76696b 			; <UNDEFINED> instruction: 0x2d76696b
 828:	732f736f 			; <UNDEFINED> instruction: 0x732f736f
 82c:	6372756f 	cmnvs	r2, #465567744	; 0x1bc00000
 830:	732f7365 			; <UNDEFINED> instruction: 0x732f7365
 834:	696c6474 	stmdbvs	ip!, {r2, r4, r5, r6, sl, sp, lr}^
 838:	72732f62 	rsbsvc	r2, r3, #392	; 0x188
 83c:	552f0063 	strpl	r0, [pc, #-99]!	; 7e1 <shift+0x7e1>
 840:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 844:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 848:	6a726574 	bvs	1c99e20 <__bss_end+0x1c90094>
 84c:	65442f69 	strbvs	r2, [r4, #-3945]	; 0xfffff097
 850:	6f746b73 	svcvs	0x00746b73
 854:	41462f70 	hvcmi	25328	; 0x62f0
 858:	614e2f56 	cmpvs	lr, r6, asr pc
 85c:	757a6176 	ldrbvc	r6, [sl, #-374]!	; 0xfffffe8a
 860:	6963696a 	stmdbvs	r3!, {r1, r3, r5, r6, r8, fp, sp, lr}^
 864:	2f534f2f 	svccs	0x00534f2f
 868:	656d6573 	strbvs	r6, [sp, #-1395]!	; 0xfffffa8d
 86c:	61727473 	cmnvs	r2, r3, ror r4
 870:	2d616b6c 	vstmdbcs	r1!, {d22-<overflow reg d75>}
 874:	2d76696b 			; <UNDEFINED> instruction: 0x2d76696b
 878:	732f736f 			; <UNDEFINED> instruction: 0x732f736f
 87c:	6372756f 	cmnvs	r2, #465567744	; 0x1bc00000
 880:	6b2f7365 	blvs	bdd61c <__bss_end+0xbd3890>
 884:	656e7265 	strbvs	r7, [lr, #-613]!	; 0xfffffd9b
 888:	6e692f6c 	cdpvs	15, 6, cr2, cr9, cr12, {3}
 88c:	64756c63 	ldrbtvs	r6, [r5], #-3171	; 0xfffff39d
 890:	72702f65 	rsbsvc	r2, r0, #404	; 0x194
 894:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
 898:	552f0073 	strpl	r0, [pc, #-115]!	; 82d <shift+0x82d>
 89c:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 8a0:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 8a4:	6a726574 	bvs	1c99e7c <__bss_end+0x1c900f0>
 8a8:	65442f69 	strbvs	r2, [r4, #-3945]	; 0xfffff097
 8ac:	6f746b73 	svcvs	0x00746b73
 8b0:	41462f70 	hvcmi	25328	; 0x62f0
 8b4:	614e2f56 	cmpvs	lr, r6, asr pc
 8b8:	757a6176 	ldrbvc	r6, [sl, #-374]!	; 0xfffffe8a
 8bc:	6963696a 	stmdbvs	r3!, {r1, r3, r5, r6, r8, fp, sp, lr}^
 8c0:	2f534f2f 	svccs	0x00534f2f
 8c4:	656d6573 	strbvs	r6, [sp, #-1395]!	; 0xfffffa8d
 8c8:	61727473 	cmnvs	r2, r3, ror r4
 8cc:	2d616b6c 	vstmdbcs	r1!, {d22-<overflow reg d75>}
 8d0:	2d76696b 			; <UNDEFINED> instruction: 0x2d76696b
 8d4:	732f736f 			; <UNDEFINED> instruction: 0x732f736f
 8d8:	6372756f 	cmnvs	r2, #465567744	; 0x1bc00000
 8dc:	6b2f7365 	blvs	bdd678 <__bss_end+0xbd38ec>
 8e0:	656e7265 	strbvs	r7, [lr, #-613]!	; 0xfffffd9b
 8e4:	6e692f6c 	cdpvs	15, 6, cr2, cr9, cr12, {3}
 8e8:	64756c63 	ldrbtvs	r6, [r5], #-3171	; 0xfffff39d
 8ec:	73662f65 	cmnvc	r6, #404	; 0x194
 8f0:	73552f00 	cmpvc	r5, #0, 30
 8f4:	2f737265 	svccs	0x00737265
 8f8:	746e6977 	strbtvc	r6, [lr], #-2423	; 0xfffff689
 8fc:	696a7265 	stmdbvs	sl!, {r0, r2, r5, r6, r9, ip, sp, lr}^
 900:	7365442f 	cmnvc	r5, #788529152	; 0x2f000000
 904:	706f746b 	rsbvc	r7, pc, fp, ror #8
 908:	5641462f 	strbpl	r4, [r1], -pc, lsr #12
 90c:	76614e2f 	strbtvc	r4, [r1], -pc, lsr #28
 910:	6a757a61 	bvs	1d5f29c <__bss_end+0x1d55510>
 914:	2f696369 	svccs	0x00696369
 918:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
 91c:	73656d65 	cmnvc	r5, #6464	; 0x1940
 920:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
 924:	6b2d616b 	blvs	b58ed8 <__bss_end+0xb4f14c>
 928:	6f2d7669 	svcvs	0x002d7669
 92c:	6f732f73 	svcvs	0x00732f73
 930:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
 934:	656b2f73 	strbvs	r2, [fp, #-3955]!	; 0xfffff08d
 938:	6c656e72 	stclvs	14, cr6, [r5], #-456	; 0xfffffe38
 93c:	636e692f 	cmnvs	lr, #770048	; 0xbc000
 940:	6564756c 	strbvs	r7, [r4, #-1388]!	; 0xfffffa94
 944:	616f622f 	cmnvs	pc, pc, lsr #4
 948:	722f6472 	eorvc	r6, pc, #1912602624	; 0x72000000
 94c:	2f306970 	svccs	0x00306970
 950:	006c6168 	rsbeq	r6, ip, r8, ror #2
 954:	64747300 	ldrbtvs	r7, [r4], #-768	; 0xfffffd00
 958:	656c6966 	strbvs	r6, [ip, #-2406]!	; 0xfffff69a
 95c:	7070632e 	rsbsvc	r6, r0, lr, lsr #6
 960:	00000100 	andeq	r0, r0, r0, lsl #2
 964:	2e697773 	mcrcs	7, 3, r7, cr9, cr3, {3}
 968:	00020068 	andeq	r0, r2, r8, rrx
 96c:	69707300 	ldmdbvs	r0!, {r8, r9, ip, sp, lr}^
 970:	636f6c6e 	cmnvs	pc, #28160	; 0x6e00
 974:	00682e6b 	rsbeq	r2, r8, fp, ror #28
 978:	66000002 	strvs	r0, [r0], -r2
 97c:	73656c69 	cmnvc	r5, #26880	; 0x6900
 980:	65747379 	ldrbvs	r7, [r4, #-889]!	; 0xfffffc87
 984:	00682e6d 	rsbeq	r2, r8, sp, ror #28
 988:	70000003 	andvc	r0, r0, r3
 98c:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
 990:	682e7373 	stmdavs	lr!, {r0, r1, r4, r5, r6, r8, r9, ip, sp, lr}
 994:	00000200 	andeq	r0, r0, r0, lsl #4
 998:	636f7270 	cmnvs	pc, #112, 4
 99c:	5f737365 	svcpl	0x00737365
 9a0:	616e616d 	cmnvs	lr, sp, ror #2
 9a4:	2e726567 	cdpcs	5, 7, cr6, cr2, cr7, {3}
 9a8:	00020068 	andeq	r0, r2, r8, rrx
 9ac:	746e6900 	strbtvc	r6, [lr], #-2304	; 0xfffff700
 9b0:	2e666564 	cdpcs	5, 6, cr6, cr6, cr4, {3}
 9b4:	00040068 	andeq	r0, r4, r8, rrx
 9b8:	01050000 	mrseq	r0, (UNDEF: 5)
 9bc:	a0020500 	andge	r0, r2, r0, lsl #10
 9c0:	1600008c 	strne	r0, [r0], -ip, lsl #1
 9c4:	2f690505 	svccs	0x00690505
 9c8:	054c0c05 	strbeq	r0, [ip, #-3077]	; 0xfffff3fb
 9cc:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 9d0:	054b8305 	strbeq	r8, [fp, #-773]	; 0xfffffcfb
 9d4:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 9d8:	01054b05 	tsteq	r5, r5, lsl #22
 9dc:	0505852f 	streq	r8, [r5, #-1327]	; 0xfffffad1
 9e0:	2f4b4ba1 	svccs	0x004b4ba1
 9e4:	054b0c05 	strbeq	r0, [fp, #-3077]	; 0xfffff3fb
 9e8:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 9ec:	4b4bbd05 	blmi	12efe08 <__bss_end+0x12e607c>
 9f0:	0c052f4b 	stceq	15, cr2, [r5], {75}	; 0x4b
 9f4:	2f01054c 	svccs	0x0001054c
 9f8:	bd050585 	cfstr32lt	mvfx0, [r5, #-532]	; 0xfffffdec
 9fc:	2f4b4b4b 	svccs	0x004b4b4b
 a00:	054c0c05 	strbeq	r0, [ip, #-3077]	; 0xfffff3fb
 a04:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 a08:	054b8305 	strbeq	r8, [fp, #-773]	; 0xfffffcfb
 a0c:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 a10:	4b4bbd05 	blmi	12efe2c <__bss_end+0x12e60a0>
 a14:	0c052f4b 	stceq	15, cr2, [r5], {75}	; 0x4b
 a18:	2f01054c 	svccs	0x0001054c
 a1c:	a1050585 	smlabbge	r5, r5, r5, r0
 a20:	052f4b4b 	streq	r4, [pc, #-2891]!	; fffffedd <__bss_end+0xffff6151>
 a24:	01054c0c 	tsteq	r5, ip, lsl #24
 a28:	0505852f 	streq	r8, [r5, #-1327]	; 0xfffffad1
 a2c:	4b4b4bbd 	blmi	12d3928 <__bss_end+0x12c9b9c>
 a30:	4c0c052f 	cfstr32mi	mvfx0, [ip], {47}	; 0x2f
 a34:	852f0105 	strhi	r0, [pc, #-261]!	; 937 <shift+0x937>
 a38:	4ba10505 	blmi	fe841e54 <__bss_end+0xfe8380c8>
 a3c:	0c052f4b 	stceq	15, cr2, [r5], {75}	; 0x4b
 a40:	9f01054c 	svcls	0x0001054c
 a44:	67200585 	strvs	r0, [r0, -r5, lsl #11]!
 a48:	4b4d0505 	blmi	1341e64 <__bss_end+0x13380d8>
 a4c:	300c054b 	andcc	r0, ip, fp, asr #10
 a50:	852f0105 	strhi	r0, [pc, #-261]!	; 953 <shift+0x953>
 a54:	05672005 	strbeq	r2, [r7, #-5]!
 a58:	4b4b4d05 	blmi	12d3e74 <__bss_end+0x12ca0e8>
 a5c:	05300c05 	ldreq	r0, [r0, #-3077]!	; 0xfffff3fb
 a60:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 a64:	05058320 	streq	r8, [r5, #-800]	; 0xfffffce0
 a68:	054b4b4c 	strbeq	r4, [fp, #-2892]	; 0xfffff4b4
 a6c:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 a70:	05056720 	streq	r6, [r5, #-1824]	; 0xfffff8e0
 a74:	054b4b4d 	strbeq	r4, [fp, #-2893]	; 0xfffff4b3
 a78:	0105300c 	tsteq	r5, ip
 a7c:	0c05872f 	stceq	7, cr8, [r5], {47}	; 0x2f
 a80:	31059fa0 	smlatbcc	r5, r0, pc, r9	; <UNPREDICTABLE>
 a84:	662905bc 			; <UNDEFINED> instruction: 0x662905bc
 a88:	052e3605 	streq	r3, [lr, #-1541]!	; 0xfffff9fb
 a8c:	1305300f 	movwne	r3, #20495	; 0x500f
 a90:	84090566 	strhi	r0, [r9], #-1382	; 0xfffffa9a
 a94:	05d81005 	ldrbeq	r1, [r8, #5]
 a98:	08029f01 	stmdaeq	r2, {r0, r8, r9, sl, fp, ip, pc}
 a9c:	8b010100 	blhi	40ea4 <__bss_end+0x37118>
 aa0:	03000003 	movweq	r0, #3
 aa4:	00007400 	andeq	r7, r0, r0, lsl #8
 aa8:	fb010200 	blx	412b2 <__bss_end+0x37526>
 aac:	01000d0e 	tsteq	r0, lr, lsl #26
 ab0:	00010101 	andeq	r0, r1, r1, lsl #2
 ab4:	00010000 	andeq	r0, r1, r0
 ab8:	552f0100 	strpl	r0, [pc, #-256]!	; 9c0 <shift+0x9c0>
 abc:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 ac0:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 ac4:	6a726574 	bvs	1c9a09c <__bss_end+0x1c90310>
 ac8:	65442f69 	strbvs	r2, [r4, #-3945]	; 0xfffff097
 acc:	6f746b73 	svcvs	0x00746b73
 ad0:	41462f70 	hvcmi	25328	; 0x62f0
 ad4:	614e2f56 	cmpvs	lr, r6, asr pc
 ad8:	757a6176 	ldrbvc	r6, [sl, #-374]!	; 0xfffffe8a
 adc:	6963696a 	stmdbvs	r3!, {r1, r3, r5, r6, r8, fp, sp, lr}^
 ae0:	2f534f2f 	svccs	0x00534f2f
 ae4:	656d6573 	strbvs	r6, [sp, #-1395]!	; 0xfffffa8d
 ae8:	61727473 	cmnvs	r2, r3, ror r4
 aec:	2d616b6c 	vstmdbcs	r1!, {d22-<overflow reg d75>}
 af0:	2d76696b 			; <UNDEFINED> instruction: 0x2d76696b
 af4:	732f736f 			; <UNDEFINED> instruction: 0x732f736f
 af8:	6372756f 	cmnvs	r2, #465567744	; 0x1bc00000
 afc:	732f7365 			; <UNDEFINED> instruction: 0x732f7365
 b00:	696c6474 	stmdbvs	ip!, {r2, r4, r5, r6, sl, sp, lr}^
 b04:	72732f62 	rsbsvc	r2, r3, #392	; 0x188
 b08:	73000063 	movwvc	r0, #99	; 0x63
 b0c:	74736474 	ldrbtvc	r6, [r3], #-1140	; 0xfffffb8c
 b10:	676e6972 			; <UNDEFINED> instruction: 0x676e6972
 b14:	7070632e 	rsbsvc	r6, r0, lr, lsr #6
 b18:	00000100 	andeq	r0, r0, r0, lsl #2
 b1c:	00010500 	andeq	r0, r1, r0, lsl #10
 b20:	90fc0205 	rscsls	r0, ip, r5, lsl #4
 b24:	051a0000 	ldreq	r0, [sl, #-0]
 b28:	0f05bb06 	svceq	0x0005bb06
 b2c:	6821054c 	stmdavs	r1!, {r2, r3, r6, r8, sl}
 b30:	05ba0a05 	ldreq	r0, [sl, #2565]!	; 0xa05
 b34:	27052e0b 	strcs	r2, [r5, -fp, lsl #28]
 b38:	4a0d054a 	bmi	342068 <__bss_end+0x3382dc>
 b3c:	052f0905 	streq	r0, [pc, #-2309]!	; 23f <shift+0x23f>
 b40:	02059f04 	andeq	r9, r5, #4, 30
 b44:	35050562 	strcc	r0, [r5, #-1378]	; 0xfffffa9e
 b48:	05681005 	strbeq	r1, [r8, #-5]!
 b4c:	22052e11 	andcs	r2, r5, #272	; 0x110
 b50:	2e13054a 	cfmac32cs	mvfx0, mvfx3, mvfx10
 b54:	052f0a05 	streq	r0, [pc, #-2565]!	; 157 <shift+0x157>
 b58:	0a056909 	beq	15af84 <__bss_end+0x1511f8>
 b5c:	4a0c052e 	bmi	30201c <__bss_end+0x2f8290>
 b60:	054b0305 	strbeq	r0, [fp, #-773]	; 0xfffffcfb
 b64:	1805680b 	stmdane	r5, {r0, r1, r3, fp, sp, lr}
 b68:	03040200 	movweq	r0, #16896	; 0x4200
 b6c:	0014054a 	andseq	r0, r4, sl, asr #10
 b70:	9e030402 	cdpls	4, 0, cr0, cr3, cr2, {0}
 b74:	02001505 	andeq	r1, r0, #20971520	; 0x1400000
 b78:	05680204 	strbeq	r0, [r8, #-516]!	; 0xfffffdfc
 b7c:	04020018 	streq	r0, [r2], #-24	; 0xffffffe8
 b80:	08058202 	stmdaeq	r5, {r1, r9, pc}
 b84:	02040200 	andeq	r0, r4, #0, 4
 b88:	001a054a 	andseq	r0, sl, sl, asr #10
 b8c:	4b020402 	blmi	81b9c <__bss_end+0x77e10>
 b90:	02001b05 	andeq	r1, r0, #5120	; 0x1400
 b94:	052e0204 	streq	r0, [lr, #-516]!	; 0xfffffdfc
 b98:	0402000c 	streq	r0, [r2], #-12
 b9c:	0f054a02 	svceq	0x00054a02
 ba0:	02040200 	andeq	r0, r4, #0, 4
 ba4:	001b0582 	andseq	r0, fp, r2, lsl #11
 ba8:	4a020402 	bmi	81bb8 <__bss_end+0x77e2c>
 bac:	02001105 	andeq	r1, r0, #1073741825	; 0x40000001
 bb0:	052e0204 	streq	r0, [lr, #-516]!	; 0xfffffdfc
 bb4:	0402000a 	streq	r0, [r2], #-10
 bb8:	0b052f02 	bleq	14c7c8 <__bss_end+0x142a3c>
 bbc:	02040200 	andeq	r0, r4, #0, 4
 bc0:	000d052e 	andeq	r0, sp, lr, lsr #10
 bc4:	4a020402 	bmi	81bd4 <__bss_end+0x77e48>
 bc8:	02000205 	andeq	r0, r0, #1342177280	; 0x50000000
 bcc:	05460204 	strbeq	r0, [r6, #-516]	; 0xfffffdfc
 bd0:	05858801 	streq	r8, [r5, #2049]	; 0x801
 bd4:	09058306 	stmdbeq	r5, {r1, r2, r8, r9, pc}
 bd8:	4a10054c 	bmi	402110 <__bss_end+0x3f8384>
 bdc:	054c0a05 	strbeq	r0, [ip, #-2565]	; 0xfffff5fb
 be0:	0305bb07 	movweq	fp, #23303	; 0x5b07
 be4:	0017054a 	andseq	r0, r7, sl, asr #10
 be8:	4a010402 	bmi	41bf8 <__bss_end+0x37e6c>
 bec:	02001405 	andeq	r1, r0, #83886080	; 0x5000000
 bf0:	054a0104 	strbeq	r0, [sl, #-260]	; 0xfffffefc
 bf4:	14054d0d 	strne	r4, [r5], #-3341	; 0xfffff2f3
 bf8:	2e0a054a 	cfsh32cs	mvfx0, mvfx10, #42
 bfc:	05680805 	strbeq	r0, [r8, #-2053]!	; 0xfffff7fb
 c00:	66780302 	ldrbtvs	r0, [r8], -r2, lsl #6
 c04:	0b030905 	bleq	c3020 <__bss_end+0xb9294>
 c08:	2f01052e 	svccs	0x0001052e
 c0c:	bb080585 	bllt	202228 <__bss_end+0x1f849c>
 c10:	054d0505 	strbeq	r0, [sp, #-1285]	; 0xfffffafb
 c14:	1005830d 	andne	r8, r5, sp, lsl #6
 c18:	4b0f0566 	blmi	3c21b8 <__bss_end+0x3b842c>
 c1c:	056a0905 	strbeq	r0, [sl, #-2309]!	; 0xfffff6fb
 c20:	0b05831c 	bleq	161898 <__bss_end+0x157b0c>
 c24:	05056a66 	streq	r6, [r5, #-2662]	; 0xfffff59a
 c28:	6711054b 	ldrvs	r0, [r1, -fp, asr #10]
 c2c:	05661405 	strbeq	r1, [r6, #-1029]!	; 0xfffffbfb
 c30:	2a056819 	bcs	15ac9c <__bss_end+0x150f10>
 c34:	081e0567 	ldmdaeq	lr, {r0, r1, r2, r5, r6, r8, sl}
 c38:	2e150558 	mrccs	5, 0, r0, cr5, cr8, {2}
 c3c:	05661e05 	strbeq	r1, [r6, #-3589]!	; 0xfffff1fb
 c40:	16054a18 			; <UNDEFINED> instruction: 0x16054a18
 c44:	d409052f 	strle	r0, [r9], #-1327	; 0xfffffad1
 c48:	05351405 	ldreq	r1, [r5, #-1029]!	; 0xfffffbfb
 c4c:	0d058310 	stceq	3, cr8, [r5, #-64]	; 0xffffffc0
 c50:	66120566 	ldrvs	r0, [r2], -r6, ror #10
 c54:	054a1005 	strbeq	r1, [sl, #-5]
 c58:	05332d05 	ldreq	r2, [r3, #-3333]!	; 0xfffff2fb
 c5c:	1005670d 	andne	r6, r5, sp, lsl #14
 c60:	4e0e0566 	cfsh32mi	mvfx0, mvfx14, #54
 c64:	02001505 	andeq	r1, r0, #20971520	; 0x1400000
 c68:	054a0304 	strbeq	r0, [sl, #-772]	; 0xfffffcfc
 c6c:	04020017 	streq	r0, [r2], #-23	; 0xffffffe9
 c70:	12052e03 	andne	r2, r5, #3, 28	; 0x30
 c74:	02040200 	andeq	r0, r4, #0, 4
 c78:	000d0567 	andeq	r0, sp, r7, ror #10
 c7c:	83020402 	movwhi	r0, #9218	; 0x2402
 c80:	02001605 	andeq	r1, r0, #5242880	; 0x500000
 c84:	05830204 	streq	r0, [r3, #516]	; 0x204
 c88:	0402000d 	streq	r0, [r2], #-13
 c8c:	16054a02 	strne	r4, [r5], -r2, lsl #20
 c90:	02040200 	andeq	r0, r4, #0, 4
 c94:	00100566 	andseq	r0, r0, r6, ror #10
 c98:	4a020402 	bmi	81ca8 <__bss_end+0x77f1c>
 c9c:	02001205 	andeq	r1, r0, #1342177280	; 0x50000000
 ca0:	052f0204 	streq	r0, [pc, #-516]!	; aa4 <shift+0xaa4>
 ca4:	04020005 	streq	r0, [r2], #-5
 ca8:	0a05b602 	beq	16e4b8 <__bss_end+0x16472c>
 cac:	6905058a 	stmdbvs	r5, {r1, r3, r7, r8, sl}
 cb0:	05670f05 	strbeq	r0, [r7, #-3845]!	; 0xfffff0fb
 cb4:	2005671d 	andcs	r6, r5, sp, lsl r7
 cb8:	01040200 	mrseq	r0, R12_usr
 cbc:	001d0582 	andseq	r0, sp, r2, lsl #11
 cc0:	4a010402 	bmi	41cd0 <__bss_end+0x37f44>
 cc4:	054b1105 	strbeq	r1, [fp, #-261]	; 0xfffffefb
 cc8:	09056614 	stmdbeq	r5, {r2, r4, r9, sl, sp, lr}
 ccc:	1d053149 	stfnes	f3, [r5, #-292]	; 0xfffffedc
 cd0:	01040200 	mrseq	r0, R12_usr
 cd4:	001a0582 	andseq	r0, sl, r2, lsl #11
 cd8:	4a010402 	bmi	41ce8 <__bss_end+0x37f5c>
 cdc:	054b1205 	strbeq	r1, [fp, #-517]	; 0xfffffdfb
 ce0:	01056a0c 	tsteq	r5, ip, lsl #20
 ce4:	0905bd2f 	stmdbeq	r5, {r0, r1, r2, r3, r5, r8, sl, fp, ip, sp, pc}
 ce8:	001605bd 			; <UNDEFINED> instruction: 0x001605bd
 cec:	4a040402 	bmi	101cfc <__bss_end+0xf7f70>
 cf0:	02001d05 	andeq	r1, r0, #320	; 0x140
 cf4:	05820204 	streq	r0, [r2, #516]	; 0x204
 cf8:	0402001e 	streq	r0, [r2], #-30	; 0xffffffe2
 cfc:	16052e02 	strne	r2, [r5], -r2, lsl #28
 d00:	02040200 	andeq	r0, r4, #0, 4
 d04:	00110566 	andseq	r0, r1, r6, ror #10
 d08:	4b030402 	blmi	c1d18 <__bss_end+0xb7f8c>
 d0c:	02001205 	andeq	r1, r0, #1342177280	; 0x50000000
 d10:	052e0304 	streq	r0, [lr, #-772]!	; 0xfffffcfc
 d14:	04020008 	streq	r0, [r2], #-8
 d18:	09054a03 	stmdbeq	r5, {r0, r1, r9, fp, lr}
 d1c:	03040200 	movweq	r0, #16896	; 0x4200
 d20:	0012052e 	andseq	r0, r2, lr, lsr #10
 d24:	4a030402 	bmi	c1d34 <__bss_end+0xb7fa8>
 d28:	02000b05 	andeq	r0, r0, #5120	; 0x1400
 d2c:	052e0304 	streq	r0, [lr, #-772]!	; 0xfffffcfc
 d30:	04020002 	streq	r0, [r2], #-2
 d34:	0b052d03 	bleq	14c148 <__bss_end+0x1423bc>
 d38:	02040200 	andeq	r0, r4, #0, 4
 d3c:	00080584 	andeq	r0, r8, r4, lsl #11
 d40:	83010402 	movwhi	r0, #5122	; 0x1402
 d44:	02000905 	andeq	r0, r0, #81920	; 0x14000
 d48:	052e0104 	streq	r0, [lr, #-260]!	; 0xfffffefc
 d4c:	0402000b 	streq	r0, [r2], #-11
 d50:	02054a01 	andeq	r4, r5, #4096	; 0x1000
 d54:	01040200 	mrseq	r0, R12_usr
 d58:	850b0549 	strhi	r0, [fp, #-1353]	; 0xfffffab7
 d5c:	852f0105 	strhi	r0, [pc, #-261]!	; c5f <shift+0xc5f>
 d60:	05bc0e05 	ldreq	r0, [ip, #3589]!	; 0xe05
 d64:	20056611 	andcs	r6, r5, r1, lsl r6
 d68:	660b05bc 			; <UNDEFINED> instruction: 0x660b05bc
 d6c:	054b1f05 	strbeq	r1, [fp, #-3845]	; 0xfffff0fb
 d70:	0805660a 	stmdaeq	r5, {r1, r3, r9, sl, sp, lr}
 d74:	8311054b 	tsthi	r1, #314572800	; 0x12c00000
 d78:	052e1605 	streq	r1, [lr, #-1541]!	; 0xfffff9fb
 d7c:	11056708 	tstne	r5, r8, lsl #14
 d80:	4d0b0567 	cfstr32mi	mvfx0, [fp, #-412]	; 0xfffffe64
 d84:	852f0105 	strhi	r0, [pc, #-261]!	; c87 <shift+0xc87>
 d88:	05830605 	streq	r0, [r3, #1541]	; 0x605
 d8c:	0c054c0b 	stceq	12, cr4, [r5], {11}
 d90:	660e052e 	strvs	r0, [lr], -lr, lsr #10
 d94:	054b0405 	strbeq	r0, [fp, #-1029]	; 0xfffffbfb
 d98:	09056502 	stmdbeq	r5, {r1, r8, sl, sp, lr}
 d9c:	2f010531 	svccs	0x00010531
 da0:	9f080585 	svcls	0x00080585
 da4:	054c0b05 	strbeq	r0, [ip, #-2821]	; 0xfffff4fb
 da8:	04020014 	streq	r0, [r2], #-20	; 0xffffffec
 dac:	07054a03 	streq	r4, [r5, -r3, lsl #20]
 db0:	02040200 	andeq	r0, r4, #0, 4
 db4:	00080583 	andeq	r0, r8, r3, lsl #11
 db8:	2e020402 	cdpcs	4, 0, cr0, cr2, cr2, {0}
 dbc:	02000a05 	andeq	r0, r0, #20480	; 0x5000
 dc0:	054a0204 	strbeq	r0, [sl, #-516]	; 0xfffffdfc
 dc4:	04020002 	streq	r0, [r2], #-2
 dc8:	01054902 	tsteq	r5, r2, lsl #18
 dcc:	0e058584 	cfsh32eq	mvfx8, mvfx5, #-60
 dd0:	4b0805bb 	blmi	2024c4 <__bss_end+0x1f8738>
 dd4:	054c0b05 	strbeq	r0, [ip, #-2821]	; 0xfffff4fb
 dd8:	04020014 	streq	r0, [r2], #-20	; 0xffffffec
 ddc:	16054a03 	strne	r4, [r5], -r3, lsl #20
 de0:	02040200 	andeq	r0, r4, #0, 4
 de4:	00170583 	andseq	r0, r7, r3, lsl #11
 de8:	2e020402 	cdpcs	4, 0, cr0, cr2, cr2, {0}
 dec:	02000a05 	andeq	r0, r0, #20480	; 0x5000
 df0:	054a0204 	strbeq	r0, [sl, #-516]	; 0xfffffdfc
 df4:	0402000b 	streq	r0, [r2], #-11
 df8:	17052e02 	strne	r2, [r5, -r2, lsl #28]
 dfc:	02040200 	andeq	r0, r4, #0, 4
 e00:	000d054a 	andeq	r0, sp, sl, asr #10
 e04:	2e020402 	cdpcs	4, 0, cr0, cr2, cr2, {0}
 e08:	02000205 	andeq	r0, r0, #1342177280	; 0x50000000
 e0c:	052d0204 	streq	r0, [sp, #-516]!	; 0xfffffdfc
 e10:	2a058401 	bcs	161e1c <__bss_end+0x158090>
 e14:	9f100584 	svcls	0x00100584
 e18:	67110567 	ldrvs	r0, [r1, -r7, ror #10]
 e1c:	bb2e0905 	bllt	b83238 <__bss_end+0xb794ac>
 e20:	05661005 	strbeq	r1, [r6, #-5]!
 e24:	01056612 	tsteq	r5, r2, lsl r6
 e28:	0006024b 	andeq	r0, r6, fp, asr #4
 e2c:	Address 0x0000000000000e2c is out of bounds.


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
      58:	0c460704 	mcrreq	7, 0, r0, r6, cr4
      5c:	5b020000 	blpl	80064 <__bss_end+0x762d8>
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
     128:	00000c46 	andeq	r0, r0, r6, asr #24
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
     174:	cb104801 	blgt	412180 <__bss_end+0x4083f4>
     178:	d4000000 	strle	r0, [r0], #-0
     17c:	58000081 	stmdapl	r0, {r0, r7}
     180:	01000000 	mrseq	r0, (UNDEF: 0)
     184:	0000cb9c 	muleq	r0, ip, fp
     188:	02b40a00 	adcseq	r0, r4, #0, 20
     18c:	4a010000 	bmi	40194 <__bss_end+0x36408>
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
     21c:	ba0d9c01 	blt	367228 <__bss_end+0x35d49c>
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
     24c:	8b120f01 	blhi	483e58 <__bss_end+0x47a0cc>
     250:	0f000001 	svceq	0x00000001
     254:	0000019e 	muleq	r0, lr, r1
     258:	03d51000 	bicseq	r1, r5, #0
     25c:	0a010000 	beq	40264 <__bss_end+0x364d8>
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
     2b4:	8b140074 	blhi	50048c <__bss_end+0x4f6700>
     2b8:	a4000001 	strge	r0, [r0], #-1
     2bc:	38000080 	stmdacc	r0, {r7}
     2c0:	01000000 	mrseq	r0, (UNDEF: 0)
     2c4:	0067139c 	mlseq	r7, ip, r3, r1
     2c8:	9e2f0a01 	vmulls.f32	s0, s30, s2
     2cc:	02000001 	andeq	r0, r0, #1
     2d0:	00007491 	muleq	r0, r1, r4
     2d4:	00000d0c 	andeq	r0, r0, ip, lsl #26
     2d8:	01e00004 	mvneq	r0, r4
     2dc:	01040000 	mrseq	r0, (UNDEF: 4)
     2e0:	000001e1 	andeq	r0, r0, r1, ror #3
     2e4:	00079f04 	andeq	r9, r7, r4, lsl #30
     2e8:	00005600 	andeq	r5, r0, r0, lsl #12
     2ec:	00822c00 	addeq	r2, r2, r0, lsl #24
     2f0:	000a7400 	andeq	r7, sl, r0, lsl #8
     2f4:	00024600 	andeq	r4, r2, r0, lsl #12
     2f8:	08010200 	stmdaeq	r1, {r9}
     2fc:	00000d05 	andeq	r0, r0, r5, lsl #26
     300:	00002503 	andeq	r2, r0, r3, lsl #10
     304:	05020200 	streq	r0, [r2, #-512]	; 0xfffffe00
     308:	00000b59 	andeq	r0, r0, r9, asr fp
     30c:	69050404 	stmdbvs	r5, {r2, sl}
     310:	0500746e 	streq	r7, [r0, #-1134]	; 0xfffffb92
     314:	000008e1 	andeq	r0, r0, r1, ror #17
     318:	4b070702 	blmi	1c1f28 <__bss_end+0x1b819c>
     31c:	02000000 	andeq	r0, r0, #0
     320:	0cfc0801 	ldcleq	8, cr0, [ip], #4
     324:	02020000 	andeq	r0, r2, #0
     328:	000e0507 	andeq	r0, lr, r7, lsl #10
     32c:	066e0500 	strbteq	r0, [lr], -r0, lsl #10
     330:	09020000 	stmdbeq	r2, {}	; <UNPREDICTABLE>
     334:	00006a07 	andeq	r6, r0, r7, lsl #20
     338:	00590300 	subseq	r0, r9, r0, lsl #6
     33c:	04020000 	streq	r0, [r2], #-0
     340:	000c4607 	andeq	r4, ip, r7, lsl #12
     344:	006a0300 	rsbeq	r0, sl, r0, lsl #6
     348:	db060000 	blle	180350 <__bss_end+0x1765c4>
     34c:	0800000e 	stmdaeq	r0, {r1, r2, r3}
     350:	9c080603 	stcls	6, cr0, [r8], {3}
     354:	07000000 	streq	r0, [r0, -r0]
     358:	03003072 	movweq	r3, #114	; 0x72
     35c:	00590e08 	subseq	r0, r9, r8, lsl #28
     360:	07000000 	streq	r0, [r0, -r0]
     364:	03003172 	movweq	r3, #370	; 0x172
     368:	00590e09 	subseq	r0, r9, r9, lsl #28
     36c:	00040000 	andeq	r0, r4, r0
     370:	000bbb08 	andeq	fp, fp, r8, lsl #22
     374:	38040500 	stmdacc	r4, {r8, sl}
     378:	03000000 	movweq	r0, #0
     37c:	00d30c1e 	sbcseq	r0, r3, lr, lsl ip
     380:	66090000 	strvs	r0, [r9], -r0
     384:	00000006 	andeq	r0, r0, r6
     388:	00087409 	andeq	r7, r8, r9, lsl #8
     38c:	dd090100 	stfles	f0, [r9, #-0]
     390:	0200000b 	andeq	r0, r0, #11
     394:	000d3809 	andeq	r3, sp, r9, lsl #16
     398:	41090300 	mrsmi	r0, (UNDEF: 57)
     39c:	04000008 	streq	r0, [r0], #-8
     3a0:	000b3809 	andeq	r3, fp, r9, lsl #16
     3a4:	08000500 	stmdaeq	r0, {r8, sl}
     3a8:	00000ba3 	andeq	r0, r0, r3, lsr #23
     3ac:	00380405 	eorseq	r0, r8, r5, lsl #8
     3b0:	3f030000 	svccc	0x00030000
     3b4:	0001100c 	andeq	r1, r1, ip
     3b8:	074c0900 	strbeq	r0, [ip, -r0, lsl #18]
     3bc:	09000000 	stmdbeq	r0, {}	; <UNPREDICTABLE>
     3c0:	0000086f 	andeq	r0, r0, pc, ror #16
     3c4:	0e740901 	vaddeq.f16	s1, s8, s2	; <UNPREDICTABLE>
     3c8:	09020000 	stmdbeq	r2, {}	; <UNPREDICTABLE>
     3cc:	00000a62 	andeq	r0, r0, r2, ror #20
     3d0:	08550903 	ldmdaeq	r5, {r0, r1, r8, fp}^
     3d4:	09040000 	stmdbeq	r4, {}	; <UNPREDICTABLE>
     3d8:	000008e9 	andeq	r0, r0, r9, ror #17
     3dc:	06ab0905 	strteq	r0, [fp], r5, lsl #18
     3e0:	00060000 	andeq	r0, r6, r0
     3e4:	00068308 	andeq	r8, r6, r8, lsl #6
     3e8:	38040500 	stmdacc	r4, {r8, sl}
     3ec:	03000000 	movweq	r0, #0
     3f0:	013b0c66 	teqeq	fp, r6, ror #24
     3f4:	f1090000 			; <UNDEFINED> instruction: 0xf1090000
     3f8:	0000000c 	andeq	r0, r0, ip
     3fc:	00059409 	andeq	r9, r5, r9, lsl #8
     400:	0d090100 	stfeqs	f0, [r9, #-0]
     404:	0200000c 	andeq	r0, r0, #12
     408:	000b4109 	andeq	r4, fp, r9, lsl #2
     40c:	0a000300 	beq	1014 <shift+0x1014>
     410:	00000a34 	andeq	r0, r0, r4, lsr sl
     414:	65140504 	ldrvs	r0, [r4, #-1284]	; 0xfffffafc
     418:	05000000 	streq	r0, [r0, #-0]
     41c:	009acc03 	addseq	ip, sl, r3, lsl #24
     420:	0c670a00 			; <UNDEFINED> instruction: 0x0c670a00
     424:	06040000 	streq	r0, [r4], -r0
     428:	00006514 	andeq	r6, r0, r4, lsl r5
     42c:	d0030500 	andle	r0, r3, r0, lsl #10
     430:	0a00009a 	beq	6a0 <shift+0x6a0>
     434:	000008fe 	strdeq	r0, [r0], -lr
     438:	651a0705 	ldrvs	r0, [sl, #-1797]	; 0xfffff8fb
     43c:	05000000 	streq	r0, [r0, #-0]
     440:	009ad403 	addseq	sp, sl, r3, lsl #8
     444:	0b630a00 	bleq	18c2c4c <__bss_end+0x18b8ec0>
     448:	09050000 	stmdbeq	r5, {}	; <UNPREDICTABLE>
     44c:	0000651a 	andeq	r6, r0, sl, lsl r5
     450:	d8030500 	stmdale	r3, {r8, sl}
     454:	0a00009a 	beq	6c4 <shift+0x6c4>
     458:	000008f0 	strdeq	r0, [r0], -r0	; <UNPREDICTABLE>
     45c:	651a0b05 	ldrvs	r0, [sl, #-2821]	; 0xfffff4fb
     460:	05000000 	streq	r0, [r0, #-0]
     464:	009adc03 	addseq	sp, sl, r3, lsl #24
     468:	0b250a00 	bleq	942c70 <__bss_end+0x938ee4>
     46c:	0d050000 	stceq	0, cr0, [r5, #-0]
     470:	0000651a 	andeq	r6, r0, sl, lsl r5
     474:	e0030500 	and	r0, r3, r0, lsl #10
     478:	0a00009a 	beq	6e8 <shift+0x6e8>
     47c:	00000646 	andeq	r0, r0, r6, asr #12
     480:	651a0f05 	ldrvs	r0, [sl, #-3845]	; 0xfffff0fb
     484:	05000000 	streq	r0, [r0, #-0]
     488:	009ae403 	addseq	lr, sl, r3, lsl #8
     48c:	12cd0800 	sbcne	r0, sp, #0, 16
     490:	04050000 	streq	r0, [r5], #-0
     494:	00000038 	andeq	r0, r0, r8, lsr r0
     498:	de0c1b05 	vmlale.f64	d1, d12, d5
     49c:	09000001 	stmdbeq	r0, {r0}
     4a0:	000005eb 	andeq	r0, r0, fp, ror #11
     4a4:	0d8e0900 	vstreq.16	s0, [lr]	; <UNPREDICTABLE>
     4a8:	09010000 	stmdbeq	r1, {}	; <UNPREDICTABLE>
     4ac:	00000e6f 	andeq	r0, r0, pc, ror #28
     4b0:	590b0002 	stmdbpl	fp, {r1}
     4b4:	0c000004 	stceq	0, cr0, [r0], {4}
     4b8:	00000025 	andeq	r0, r0, r5, lsr #32
     4bc:	000001f3 	strdeq	r0, [r0], -r3
     4c0:	00006a0d 	andeq	r6, r0, sp, lsl #20
     4c4:	02000f00 	andeq	r0, r0, #0, 30
     4c8:	095d0201 	ldmdbeq	sp, {r0, r9}^
     4cc:	040e0000 	streq	r0, [lr], #-0
     4d0:	0000002c 	andeq	r0, r0, ip, lsr #32
     4d4:	01de040e 	bicseq	r0, lr, lr, lsl #8
     4d8:	ff0a0000 			; <UNDEFINED> instruction: 0xff0a0000
     4dc:	06000005 	streq	r0, [r0], -r5
     4e0:	00651404 	rsbeq	r1, r5, r4, lsl #8
     4e4:	03050000 	movweq	r0, #20480	; 0x5000
     4e8:	00009ae8 	andeq	r9, r0, r8, ror #21
     4ec:	000bef0a 	andeq	lr, fp, sl, lsl #30
     4f0:	14070600 	strne	r0, [r7], #-1536	; 0xfffffa00
     4f4:	00000065 	andeq	r0, r0, r5, rrx
     4f8:	9aec0305 	bls	ffb01114 <__bss_end+0xffaf7388>
     4fc:	2a0a0000 	bcs	280504 <__bss_end+0x276778>
     500:	06000005 	streq	r0, [r0], -r5
     504:	0065140a 	rsbeq	r1, r5, sl, lsl #8
     508:	03050000 	movweq	r0, #20480	; 0x5000
     50c:	00009af0 	strdeq	r9, [r0], -r0
     510:	0006b008 	andeq	fp, r6, r8
     514:	38040500 	stmdacc	r4, {r8, sl}
     518:	06000000 	streq	r0, [r0], -r0
     51c:	02730c0d 	rsbseq	r0, r3, #3328	; 0xd00
     520:	4e0f0000 	cdpmi	0, 0, cr0, cr15, cr0, {0}
     524:	00007765 	andeq	r7, r0, r5, ror #14
     528:	0004ff09 	andeq	pc, r4, r9, lsl #30
     52c:	22090100 	andcs	r0, r9, #0, 2
     530:	02000005 	andeq	r0, r0, #5
     534:	0006c909 	andeq	ip, r6, r9, lsl #18
     538:	2a090300 	bcs	241140 <__bss_end+0x2373b4>
     53c:	0400000d 	streq	r0, [r0], #-13
     540:	0004ec09 	andeq	lr, r4, r9, lsl #24
     544:	06000500 	streq	r0, [r0], -r0, lsl #10
     548:	00000618 	andeq	r0, r0, r8, lsl r6
     54c:	081b0610 	ldmdaeq	fp, {r4, r9, sl}
     550:	000002b2 			; <UNDEFINED> instruction: 0x000002b2
     554:	00726c07 	rsbseq	r6, r2, r7, lsl #24
     558:	b2131d06 	andslt	r1, r3, #384	; 0x180
     55c:	00000002 	andeq	r0, r0, r2
     560:	00707307 	rsbseq	r7, r0, r7, lsl #6
     564:	b2131e06 	andslt	r1, r3, #6, 28	; 0x60
     568:	04000002 	streq	r0, [r0], #-2
     56c:	00637007 	rsbeq	r7, r3, r7
     570:	b2131f06 	andslt	r1, r3, #6, 30
     574:	08000002 	stmdaeq	r0, {r1}
     578:	000b9310 	andeq	r9, fp, r0, lsl r3
     57c:	13200600 	nopne	{0}	; <UNPREDICTABLE>
     580:	000002b2 			; <UNDEFINED> instruction: 0x000002b2
     584:	0402000c 	streq	r0, [r2], #-12
     588:	000c4107 	andeq	r4, ip, r7, lsl #2
     58c:	02b20300 	adcseq	r0, r2, #0, 6
     590:	34060000 	strcc	r0, [r6], #-0
     594:	70000008 	andvc	r0, r0, r8
     598:	4e082806 	cdpmi	8, 0, cr2, cr8, cr6, {0}
     59c:	10000003 	andne	r0, r0, r3
     5a0:	00000731 	andeq	r0, r0, r1, lsr r7
     5a4:	73122a06 	tstvc	r2, #24576	; 0x6000
     5a8:	00000002 	andeq	r0, r0, r2
     5ac:	64697007 	strbtvs	r7, [r9], #-7
     5b0:	122b0600 	eorne	r0, fp, #0, 12
     5b4:	0000006a 	andeq	r0, r0, sl, rrx
     5b8:	0af71010 	beq	ffdc4600 <__bss_end+0xffdba874>
     5bc:	2c060000 	stccs	0, cr0, [r6], {-0}
     5c0:	00023c11 	andeq	r3, r2, r1, lsl ip
     5c4:	d7101400 	ldrle	r1, [r0, -r0, lsl #8]
     5c8:	0600000c 	streq	r0, [r0], -ip
     5cc:	006a122d 	rsbeq	r1, sl, sp, lsr #4
     5d0:	10180000 	andsne	r0, r8, r0
     5d4:	000003e9 	andeq	r0, r0, r9, ror #7
     5d8:	6a122e06 	bvs	48bdf8 <__bss_end+0x48206c>
     5dc:	1c000000 	stcne	0, cr0, [r0], {-0}
     5e0:	000bd010 	andeq	sp, fp, r0, lsl r0
     5e4:	0c2f0600 	stceq	6, cr0, [pc], #-0	; 5ec <shift+0x5ec>
     5e8:	0000034e 	andeq	r0, r0, lr, asr #6
     5ec:	04861020 	streq	r1, [r6], #32
     5f0:	30060000 	andcc	r0, r6, r0
     5f4:	00003809 	andeq	r3, r0, r9, lsl #16
     5f8:	e4106000 	ldr	r6, [r0], #-0
     5fc:	06000006 	streq	r0, [r0], -r6
     600:	00590e31 	subseq	r0, r9, r1, lsr lr
     604:	10640000 	rsbne	r0, r4, r0
     608:	00000acc 	andeq	r0, r0, ip, asr #21
     60c:	590e3306 	stmdbpl	lr, {r1, r2, r8, r9, ip, sp}
     610:	68000000 	stmdavs	r0, {}	; <UNPREDICTABLE>
     614:	000ac310 	andeq	ip, sl, r0, lsl r3
     618:	0e340600 	cfmsuba32eq	mvax0, mvax0, mvfx4, mvfx0
     61c:	00000059 	andeq	r0, r0, r9, asr r0
     620:	000c006c 	andeq	r0, ip, ip, rrx
     624:	5e000002 	cdppl	0, 0, cr0, cr0, cr2, {0}
     628:	0d000003 	stceq	0, cr0, [r0, #-12]
     62c:	0000006a 	andeq	r0, r0, sl, rrx
     630:	130a000f 	movwne	r0, #40975	; 0xa00f
     634:	07000005 	streq	r0, [r0, -r5]
     638:	0065140a 	rsbeq	r1, r5, sl, lsl #8
     63c:	03050000 	movweq	r0, #20480	; 0x5000
     640:	00009af4 	strdeq	r9, [r0], -r4
     644:	00093908 	andeq	r3, r9, r8, lsl #18
     648:	38040500 	stmdacc	r4, {r8, sl}
     64c:	07000000 	streq	r0, [r0, -r0]
     650:	038f0c0d 	orreq	r0, pc, #3328	; 0xd00
     654:	7a090000 	bvc	24065c <__bss_end+0x2368d0>
     658:	0000000e 	andeq	r0, r0, lr
     65c:	000da209 	andeq	sl, sp, r9, lsl #4
     660:	06000100 	streq	r0, [r0], -r0, lsl #2
     664:	00000713 	andeq	r0, r0, r3, lsl r7
     668:	081b070c 	ldmdaeq	fp, {r2, r3, r8, r9, sl}
     66c:	000003c4 	andeq	r0, r0, r4, asr #7
     670:	0005b810 	andeq	fp, r5, r0, lsl r8
     674:	191d0700 	ldmdbne	sp, {r8, r9, sl}
     678:	000003c4 	andeq	r0, r0, r4, asr #7
     67c:	04fa1000 	ldrbteq	r1, [sl], #0
     680:	1e070000 	cdpne	0, 0, cr0, cr7, cr0, {0}
     684:	0003c419 	andeq	ip, r3, r9, lsl r4
     688:	9e100400 	cfmulsls	mvf0, mvf0, mvf0
     68c:	0700000a 	streq	r0, [r0, -sl]
     690:	03ca131f 	biceq	r1, sl, #2080374784	; 0x7c000000
     694:	00080000 	andeq	r0, r8, r0
     698:	038f040e 	orreq	r0, pc, #234881024	; 0xe000000
     69c:	040e0000 	streq	r0, [lr], #-0
     6a0:	000002be 			; <UNDEFINED> instruction: 0x000002be
     6a4:	000b7511 	andeq	r7, fp, r1, lsl r5
     6a8:	22071400 	andcs	r1, r7, #0, 8
     6ac:	00065207 	andeq	r5, r6, r7, lsl #4
     6b0:	0a421000 	beq	10846b8 <__bss_end+0x107a92c>
     6b4:	26070000 	strcs	r0, [r7], -r0
     6b8:	00005912 	andeq	r5, r0, r2, lsl r9
     6bc:	e4100000 	ldr	r0, [r0], #-0
     6c0:	07000009 	streq	r0, [r0, -r9]
     6c4:	03c41d29 	biceq	r1, r4, #2624	; 0xa40
     6c8:	10040000 	andne	r0, r4, r0
     6cc:	000006d1 	ldrdeq	r0, [r0], -r1
     6d0:	c41d2c07 	ldrgt	r2, [sp], #-3079	; 0xfffff3f9
     6d4:	08000003 	stmdaeq	r0, {r0, r1}
     6d8:	000a5812 	andeq	r5, sl, r2, lsl r8
     6dc:	0e2f0700 	cdpeq	7, 2, cr0, cr15, cr0, {0}
     6e0:	000006f0 	strdeq	r0, [r0], -r0	; <UNPREDICTABLE>
     6e4:	00000418 	andeq	r0, r0, r8, lsl r4
     6e8:	00000423 	andeq	r0, r0, r3, lsr #8
     6ec:	00065713 	andeq	r5, r6, r3, lsl r7
     6f0:	03c41400 	biceq	r1, r4, #0, 8
     6f4:	15000000 	strne	r0, [r0, #-0]
     6f8:	0000088e 	andeq	r0, r0, lr, lsl #17
     6fc:	0b0e3107 	bleq	38cb20 <__bss_end+0x382d94>
     700:	f3000008 	vhadd.u8	d0, d0, d8
     704:	3b000001 	blcc	710 <shift+0x710>
     708:	46000004 	strmi	r0, [r0], -r4
     70c:	13000004 	movwne	r0, #4
     710:	00000657 	andeq	r0, r0, r7, asr r6
     714:	0003ca14 	andeq	ip, r3, r4, lsl sl
     718:	3e160000 	cdpcc	0, 1, cr0, cr6, cr0, {0}
     71c:	0700000d 	streq	r0, [r0, -sp]
     720:	09141d35 	ldmdbeq	r4, {r0, r2, r4, r5, r8, sl, fp, ip}
     724:	03c40000 	biceq	r0, r4, #0
     728:	5f020000 	svcpl	0x00020000
     72c:	65000004 	strvs	r0, [r0, #-4]
     730:	13000004 	movwne	r0, #4
     734:	00000657 	andeq	r0, r0, r7, asr r6
     738:	06bc1600 	ldrteq	r1, [ip], r0, lsl #12
     73c:	37070000 	strcc	r0, [r7, -r0]
     740:	000a681d 	andeq	r6, sl, sp, lsl r8
     744:	0003c400 	andeq	ip, r3, r0, lsl #8
     748:	047e0200 	ldrbteq	r0, [lr], #-512	; 0xfffffe00
     74c:	04840000 	streq	r0, [r4], #0
     750:	57130000 	ldrpl	r0, [r3, -r0]
     754:	00000006 	andeq	r0, r0, r6
     758:	0009f717 	andeq	pc, r9, r7, lsl r7	; <UNPREDICTABLE>
     75c:	31390700 	teqcc	r9, r0, lsl #14
     760:	00000670 	andeq	r0, r0, r0, ror r6
     764:	7516020c 	ldrvc	r0, [r6, #-524]	; 0xfffffdf4
     768:	0700000b 	streq	r0, [r0, -fp]
     76c:	089d093c 	ldmeq	sp, {r2, r3, r4, r5, r8, fp}
     770:	06570000 	ldrbeq	r0, [r7], -r0
     774:	ab010000 	blge	4077c <__bss_end+0x369f0>
     778:	b1000004 	tstlt	r0, r4
     77c:	13000004 	movwne	r0, #4
     780:	00000657 	andeq	r0, r0, r7, asr r6
     784:	073d1600 	ldreq	r1, [sp, -r0, lsl #12]!
     788:	3f070000 	svccc	0x00070000
     78c:	00055b12 	andeq	r5, r5, r2, lsl fp
     790:	00005900 	andeq	r5, r0, r0, lsl #18
     794:	04ca0100 	strbeq	r0, [sl], #256	; 0x100
     798:	04df0000 	ldrbeq	r0, [pc], #0	; 7a0 <shift+0x7a0>
     79c:	57130000 	ldrpl	r0, [r3, -r0]
     7a0:	14000006 	strne	r0, [r0], #-6
     7a4:	00000679 	andeq	r0, r0, r9, ror r6
     7a8:	00006a14 	andeq	r6, r0, r4, lsl sl
     7ac:	01f31400 	mvnseq	r1, r0, lsl #8
     7b0:	18000000 	stmdane	r0, {}	; <UNPREDICTABLE>
     7b4:	00000d99 	muleq	r0, r9, sp
     7b8:	250e4207 	strcs	r4, [lr, #-519]	; 0xfffffdf9
     7bc:	01000006 	tsteq	r0, r6
     7c0:	000004f4 	strdeq	r0, [r0], -r4
     7c4:	000004fa 	strdeq	r0, [r0], -sl
     7c8:	00065713 	andeq	r5, r6, r3, lsl r7
     7cc:	3d160000 	ldccc	0, cr0, [r6, #-0]
     7d0:	07000005 	streq	r0, [r0, -r5]
     7d4:	05bd1745 	ldreq	r1, [sp, #1861]!	; 0x745
     7d8:	03ca0000 	biceq	r0, sl, #0
     7dc:	13010000 	movwne	r0, #4096	; 0x1000
     7e0:	19000005 	stmdbne	r0, {r0, r2}
     7e4:	13000005 	movwne	r0, #5
     7e8:	0000067f 	andeq	r0, r0, pc, ror r6
     7ec:	0bfa1600 	bleq	ffe85ff4 <__bss_end+0xffe7c268>
     7f0:	48070000 	stmdami	r7, {}	; <UNPREDICTABLE>
     7f4:	0003ff17 	andeq	pc, r3, r7, lsl pc	; <UNPREDICTABLE>
     7f8:	0003ca00 	andeq	ip, r3, r0, lsl #20
     7fc:	05320100 	ldreq	r0, [r2, #-256]!	; 0xffffff00
     800:	053d0000 	ldreq	r0, [sp, #-0]!
     804:	7f130000 	svcvc	0x00130000
     808:	14000006 	strne	r0, [r0], #-6
     80c:	00000059 	andeq	r0, r0, r9, asr r0
     810:	06501800 	ldrbeq	r1, [r0], -r0, lsl #16
     814:	4b070000 	blmi	1c081c <__bss_end+0x1b6a90>
     818:	000a050e 	andeq	r0, sl, lr, lsl #10
     81c:	05520100 	ldrbeq	r0, [r2, #-256]	; 0xffffff00
     820:	05580000 	ldrbeq	r0, [r8, #-0]
     824:	57130000 	ldrpl	r0, [r3, -r0]
     828:	00000006 	andeq	r0, r0, r6
     82c:	00088e16 	andeq	r8, r8, r6, lsl lr
     830:	0e4d0700 	cdpeq	7, 4, cr0, cr13, cr0, {0}
     834:	00000afd 	strdeq	r0, [r0], -sp
     838:	000001f3 	strdeq	r0, [r0], -r3
     83c:	00057101 	andeq	r7, r5, r1, lsl #2
     840:	00057c00 	andeq	r7, r5, r0, lsl #24
     844:	06571300 	ldrbeq	r1, [r7], -r0, lsl #6
     848:	59140000 	ldmdbpl	r4, {}	; <UNPREDICTABLE>
     84c:	00000000 	andeq	r0, r0, r0
     850:	0004c616 	andeq	ip, r4, r6, lsl r6
     854:	12500700 	subsne	r0, r0, #0, 14
     858:	0000042c 	andeq	r0, r0, ip, lsr #8
     85c:	00000059 	andeq	r0, r0, r9, asr r0
     860:	00059501 	andeq	r9, r5, r1, lsl #10
     864:	0005a000 	andeq	sl, r5, r0
     868:	06571300 	ldrbeq	r1, [r7], -r0, lsl #6
     86c:	00140000 	andseq	r0, r4, r0
     870:	00000002 	andeq	r0, r0, r2
     874:	00045f16 	andeq	r5, r4, r6, lsl pc
     878:	0e530700 	cdpeq	7, 5, cr0, cr3, cr0, {0}
     87c:	00000dad 	andeq	r0, r0, sp, lsr #27
     880:	000001f3 	strdeq	r0, [r0], -r3
     884:	0005b901 	andeq	fp, r5, r1, lsl #18
     888:	0005c400 	andeq	ip, r5, r0, lsl #8
     88c:	06571300 	ldrbeq	r1, [r7], -r0, lsl #6
     890:	59140000 	ldmdbpl	r4, {}	; <UNPREDICTABLE>
     894:	00000000 	andeq	r0, r0, r0
     898:	0004a018 	andeq	sl, r4, r8, lsl r0
     89c:	0e560700 	cdpeq	7, 5, cr0, cr6, cr0, {0}
     8a0:	00000c73 	andeq	r0, r0, r3, ror ip
     8a4:	0005d901 	andeq	sp, r5, r1, lsl #18
     8a8:	0005f800 	andeq	pc, r5, r0, lsl #16
     8ac:	06571300 	ldrbeq	r1, [r7], -r0, lsl #6
     8b0:	9c140000 	ldcls	0, cr0, [r4], {-0}
     8b4:	14000000 	strne	r0, [r0], #-0
     8b8:	00000059 	andeq	r0, r0, r9, asr r0
     8bc:	00005914 	andeq	r5, r0, r4, lsl r9
     8c0:	00591400 	subseq	r1, r9, r0, lsl #8
     8c4:	85140000 	ldrhi	r0, [r4, #-0]
     8c8:	00000006 	andeq	r0, r0, r6
     8cc:	000def18 	andeq	lr, sp, r8, lsl pc
     8d0:	0e580700 	cdpeq	7, 5, cr0, cr8, cr0, {0}
     8d4:	00000e8f 	andeq	r0, r0, pc, lsl #29
     8d8:	00060d01 	andeq	r0, r6, r1, lsl #26
     8dc:	00062c00 	andeq	r2, r6, r0, lsl #24
     8e0:	06571300 	ldrbeq	r1, [r7], -r0, lsl #6
     8e4:	d3140000 	tstle	r4, #0
     8e8:	14000000 	strne	r0, [r0], #-0
     8ec:	00000059 	andeq	r0, r0, r9, asr r0
     8f0:	00005914 	andeq	r5, r0, r4, lsl r9
     8f4:	00591400 	subseq	r1, r9, r0, lsl #8
     8f8:	85140000 	ldrhi	r0, [r4, #-0]
     8fc:	00000006 	andeq	r0, r0, r6
     900:	0004b319 	andeq	fp, r4, r9, lsl r3
     904:	0e5b0700 	cdpeq	7, 5, cr0, cr11, cr0, {0}
     908:	0000097e 	andeq	r0, r0, lr, ror r9
     90c:	000001f3 	strdeq	r0, [r0], -r3
     910:	00064101 	andeq	r4, r6, r1, lsl #2
     914:	06571300 	ldrbeq	r1, [r7], -r0, lsl #6
     918:	70140000 	andsvc	r0, r4, r0
     91c:	14000003 	strne	r0, [r0], #-3
     920:	0000068b 	andeq	r0, r0, fp, lsl #13
     924:	d0030000 	andle	r0, r3, r0
     928:	0e000003 	cdpeq	0, 0, cr0, cr0, cr3, {0}
     92c:	0003d004 	andeq	sp, r3, r4
     930:	03c41a00 	biceq	r1, r4, #0, 20
     934:	066a0000 	strbteq	r0, [sl], -r0
     938:	06700000 	ldrbteq	r0, [r0], -r0
     93c:	57130000 	ldrpl	r0, [r3, -r0]
     940:	00000006 	andeq	r0, r0, r6
     944:	0003d01b 	andeq	sp, r3, fp, lsl r0
     948:	00065d00 	andeq	r5, r6, r0, lsl #26
     94c:	4b040e00 	blmi	104154 <__bss_end+0xfa3c8>
     950:	0e000000 	cdpeq	0, 0, cr0, cr0, cr0, {0}
     954:	00065204 	andeq	r5, r6, r4, lsl #4
     958:	76041c00 	strvc	r1, [r4], -r0, lsl #24
     95c:	1d000000 	stcne	0, cr0, [r0, #-0]
     960:	61681e04 	cmnvs	r8, r4, lsl #28
     964:	0508006c 	streq	r0, [r8, #-108]	; 0xffffff94
     968:	0007570b 	andeq	r5, r7, fp, lsl #14
     96c:	09d11f00 	ldmibeq	r1, {r8, r9, sl, fp, ip}^
     970:	07080000 	streq	r0, [r8, -r0]
     974:	00007119 	andeq	r7, r0, r9, lsl r1
     978:	e6b28000 	ldrt	r8, [r2], r0
     97c:	0c241f0e 	stceq	15, cr1, [r4], #-56	; 0xffffffc8
     980:	0a080000 	beq	200988 <__bss_end+0x1f6bfc>
     984:	0002b91a 	andeq	fp, r2, sl, lsl r9
     988:	00000000 	andeq	r0, r0, r0
     98c:	05511f20 	ldrbeq	r1, [r1, #-3872]	; 0xfffff0e0
     990:	0d080000 	stceq	0, cr0, [r8, #-0]
     994:	0002b91a 	andeq	fp, r2, sl, lsl r9
     998:	20000000 	andcs	r0, r0, r0
     99c:	094e2020 	stmdbeq	lr, {r5, sp}^
     9a0:	10080000 	andne	r0, r8, r0
     9a4:	00006515 	andeq	r6, r0, r5, lsl r5
     9a8:	4a1f3600 	bmi	7ce1b0 <__bss_end+0x7c4424>
     9ac:	0800000d 	stmdaeq	r0, {r0, r2, r3}
     9b0:	02b91a42 	adcseq	r1, r9, #270336	; 0x42000
     9b4:	50000000 	andpl	r0, r0, r0
     9b8:	451f2021 	ldrmi	r2, [pc, #-33]	; 99f <shift+0x99f>
     9bc:	0800000e 	stmdaeq	r0, {r1, r2, r3}
     9c0:	02b91a71 	adcseq	r1, r9, #462848	; 0x71000
     9c4:	b2000000 	andlt	r0, r0, #0
     9c8:	611f2000 	tstvs	pc, r0
     9cc:	08000007 	stmdaeq	r0, {r0, r1, r2}
     9d0:	02b91aa4 	adcseq	r1, r9, #164, 20	; 0xa4000
     9d4:	b4000000 	strlt	r0, [r0], #-0
     9d8:	c11f2000 	tstgt	pc, r0
     9dc:	08000009 	stmdaeq	r0, {r0, r3}
     9e0:	02b91ab3 	adcseq	r1, r9, #733184	; 0xb3000
     9e4:	40000000 	andmi	r0, r0, r0
     9e8:	8e1f2010 	mrchi	0, 0, r2, cr15, cr0, {0}
     9ec:	0800000a 	stmdaeq	r0, {r1, r3}
     9f0:	02b91abe 	adcseq	r1, r9, #778240	; 0xbe000
     9f4:	50000000 	andpl	r0, r0, r0
     9f8:	a11f2020 	tstge	pc, r0, lsr #32
     9fc:	08000006 	stmdaeq	r0, {r1, r2}
     a00:	02b91abf 	adcseq	r1, r9, #782336	; 0xbf000
     a04:	40000000 	andmi	r0, r0, r0
     a08:	531f2080 	tstpl	pc, #128	; 0x80
     a0c:	0800000d 	stmdaeq	r0, {r0, r2, r3}
     a10:	02b91ac0 	adcseq	r1, r9, #192, 20	; 0xc0000
     a14:	50000000 	andpl	r0, r0, r0
     a18:	1b1f2080 	blne	7c8c20 <__bss_end+0x7bee94>
     a1c:	0800000d 	stmdaeq	r0, {r0, r2, r3}
     a20:	02b91ace 	adcseq	r1, r9, #843776	; 0xce000
     a24:	40000000 	andmi	r0, r0, r0
     a28:	21002021 	tstcs	r0, r1, lsr #32
     a2c:	00000699 	muleq	r0, r9, r6
     a30:	0006a921 	andeq	sl, r6, r1, lsr #18
     a34:	06b92100 	ldrteq	r2, [r9], r0, lsl #2
     a38:	c9210000 	stmdbgt	r1!, {}	; <UNPREDICTABLE>
     a3c:	21000006 	tstcs	r0, r6
     a40:	000006d6 	ldrdeq	r0, [r0], -r6
     a44:	0006e621 	andeq	lr, r6, r1, lsr #12
     a48:	06f62100 	ldrbteq	r2, [r6], r0, lsl #2
     a4c:	06210000 	strteq	r0, [r1], -r0
     a50:	21000007 	tstcs	r0, r7
     a54:	00000716 	andeq	r0, r0, r6, lsl r7
     a58:	00072621 	andeq	r2, r7, r1, lsr #12
     a5c:	07362100 	ldreq	r2, [r6, -r0, lsl #2]!
     a60:	46210000 	strtmi	r0, [r1], -r0
     a64:	0a000007 	beq	a88 <shift+0xa88>
     a68:	00000c5b 	andeq	r0, r0, fp, asr ip
     a6c:	65140809 	ldrvs	r0, [r4, #-2057]	; 0xfffff7f7
     a70:	05000000 	streq	r0, [r0, #-0]
     a74:	009b2803 	addseq	r2, fp, r3, lsl #16
     a78:	0d6a0800 	stcleq	8, cr0, [sl, #-0]
     a7c:	04050000 	streq	r0, [r5], #-0
     a80:	00000038 	andeq	r0, r0, r8, lsr r0
     a84:	ca0c0d0a 	bgt	303eb4 <__bss_end+0x2fa128>
     a88:	09000007 	stmdbeq	r0, {r0, r1, r2}
     a8c:	00000887 	andeq	r0, r0, r7, lsl #17
     a90:	09cb0900 	stmibeq	fp, {r8, fp}^
     a94:	09010000 	stmdbeq	r1, {}	; <UNPREDICTABLE>
     a98:	00000aa3 	andeq	r0, r0, r3, lsr #21
     a9c:	a5030002 	strge	r0, [r3, #-2]
     aa0:	06000007 	streq	r0, [r0], -r7
     aa4:	000004da 	ldrdeq	r0, [r0], -sl
     aa8:	08150a02 	ldmdaeq	r5, {r1, r9, fp}
     aac:	000007f7 	strdeq	r0, [r0], -r7
     ab0:	000c5310 	andeq	r5, ip, r0, lsl r3
     ab4:	0d170a00 	vldreq	s0, [r7, #-0]
     ab8:	0000003f 	andeq	r0, r0, pc, lsr r0
     abc:	0e381000 	cdpeq	0, 3, cr1, cr8, cr0, {0}
     ac0:	180a0000 	stmdane	sl, {}	; <UNPREDICTABLE>
     ac4:	00003f0d 	andeq	r3, r0, sp, lsl #30
     ac8:	0a000100 	beq	ed0 <shift+0xed0>
     acc:	0000059f 	muleq	r0, pc, r5	; <UNPREDICTABLE>
     ad0:	6514080b 	ldrvs	r0, [r4, #-2059]	; 0xfffff7f5
     ad4:	05000000 	streq	r0, [r0, #-0]
     ad8:	009b2c03 	addseq	r2, fp, r3, lsl #24
     adc:	0dd90a00 	vldreq	s1, [r9]
     ae0:	070c0000 	streq	r0, [ip, -r0]
     ae4:	00006514 	andeq	r6, r0, r4, lsl r5
     ae8:	30030500 	andcc	r0, r3, r0, lsl #10
     aec:	0a00009b 	beq	d60 <shift+0xd60>
     af0:	00000ce5 	andeq	r0, r0, r5, ror #25
     af4:	34110901 	ldrcc	r0, [r1], #-2305	; 0xfffff6ff
     af8:	05000008 	streq	r0, [r0, #-8]
     afc:	009b3403 	addseq	r3, fp, r3, lsl #8
     b00:	04040200 	streq	r0, [r4], #-512	; 0xfffffe00
     b04:	00000694 	muleq	r0, r4, r6
     b08:	00082d03 	andeq	r2, r8, r3, lsl #26
     b0c:	06770a00 	ldrbteq	r0, [r7], -r0, lsl #20
     b10:	0a010000 	beq	40b18 <__bss_end+0x36d8c>
     b14:	00083411 	andeq	r3, r8, r1, lsl r4
     b18:	38030500 	stmdacc	r3, {r8, sl}
     b1c:	0a00009b 	beq	d90 <shift+0xd90>
     b20:	000008c7 	andeq	r0, r0, r7, asr #17
     b24:	65140c01 	ldrvs	r0, [r4, #-3073]	; 0xfffff3ff
     b28:	05000000 	streq	r0, [r0, #-0]
     b2c:	009b3c03 	addseq	r3, fp, r3, lsl #24
     b30:	08c00a00 	stmiaeq	r0, {r9, fp}^
     b34:	0d010000 	stceq	0, cr0, [r1, #-0]
     b38:	00006514 	andeq	r6, r0, r4, lsl r5
     b3c:	40030500 	andmi	r0, r3, r0, lsl #10
     b40:	0a00009b 	beq	db4 <shift+0xdb4>
     b44:	00000c34 	andeq	r0, r0, r4, lsr ip
     b48:	ca150e01 	bgt	544354 <__bss_end+0x53a5c8>
     b4c:	05000007 	streq	r0, [r0, #-7]
     b50:	009b4403 	addseq	r4, fp, r3, lsl #8
     b54:	0a4c2200 	beq	130935c <__bss_end+0x12ff5d0>
     b58:	0f010000 	svceq	0x00010000
     b5c:	0007a50b 	andeq	sl, r7, fp, lsl #10
     b60:	e8030500 	stmda	r3, {r8, sl}
     b64:	2200009c 	andcs	r0, r0, #156	; 0x9c
     b68:	000004f3 	strdeq	r0, [r0], -r3
     b6c:	590a1101 	stmdbpl	sl, {r0, r8, ip}
     b70:	05000000 	streq	r0, [r0, #-0]
     b74:	009cf003 	addseq	pc, ip, r3
     b78:	069a2200 	ldreq	r2, [sl], r0, lsl #4
     b7c:	11010000 	mrsne	r0, (UNDEF: 1)
     b80:	00005912 	andeq	r5, r0, r2, lsl r9
     b84:	f4030500 	vst3.8	{d0,d2,d4}, [r3], r0
     b88:	0c00009c 	stceq	0, cr0, [r0], {156}	; 0x9c
     b8c:	00000834 	andeq	r0, r0, r4, lsr r8
     b90:	000008c7 	andeq	r0, r0, r7, asr #17
     b94:	00006a0d 	andeq	r6, r0, sp, lsl #20
     b98:	03000700 	movweq	r0, #1792	; 0x700
     b9c:	000008b7 			; <UNDEFINED> instruction: 0x000008b7
     ba0:	000d8023 	andeq	r8, sp, r3, lsr #32
     ba4:	0d130100 	ldfeqs	f0, [r3, #-0]
     ba8:	000008c7 	andeq	r0, r0, r7, asr #17
     bac:	9b480305 	blls	12017c8 <__bss_end+0x11f7a3c>
     bb0:	cf230000 	svcgt	0x00230000
     bb4:	01000008 	tsteq	r0, r8
     bb8:	00651016 	rsbeq	r1, r5, r6, lsl r0
     bbc:	03050000 	movweq	r0, #20480	; 0x5000
     bc0:	00009b68 	andeq	r9, r0, r8, ror #22
     bc4:	000e1822 	andeq	r1, lr, r2, lsr #16
     bc8:	07170100 	ldreq	r0, [r7, -r0, lsl #2]
     bcc:	0000082d 	andeq	r0, r0, sp, lsr #16
     bd0:	9cec0305 	stclls	3, cr0, [ip], #20
     bd4:	2d0c0000 	stccs	0, cr0, [ip, #-0]
     bd8:	12000008 	andne	r0, r0, #8
     bdc:	0d000009 	stceq	0, cr0, [r0, #-36]	; 0xffffffdc
     be0:	0000006a 	andeq	r0, r0, sl, rrx
     be4:	5f22001f 	svcpl	0x0022001f
     be8:	0100000e 	tsteq	r0, lr
     bec:	09020719 	stmdbeq	r2, {r0, r3, r4, r8, r9, sl}
     bf0:	03050000 	movweq	r0, #20480	; 0x5000
     bf4:	00009cf8 	strdeq	r9, [r0], -r8
     bf8:	000ad522 	andeq	sp, sl, r2, lsr #10
     bfc:	0a1a0100 	beq	681004 <__bss_end+0x677278>
     c00:	00000059 	andeq	r0, r0, r9, asr r0
     c04:	9d780305 	ldclls	3, cr0, [r8, #-20]!	; 0xffffffec
     c08:	23240000 			; <UNDEFINED> instruction: 0x23240000
     c0c:	0100000e 	tsteq	r0, lr
     c10:	003805ed 	eorseq	r0, r8, sp, ror #11
     c14:	8b240000 	blhi	900c1c <__bss_end+0x8f6e90>
     c18:	017c0000 	cmneq	ip, r0
     c1c:	9c010000 	stcls	0, cr0, [r1], {-0}
     c20:	0000099d 	muleq	r0, sp, r9
     c24:	000aad25 	andeq	sl, sl, r5, lsr #26
     c28:	0eed0100 	cdpeq	1, 14, cr0, cr13, cr0, {0}
     c2c:	00000038 	andeq	r0, r0, r8, lsr r0
     c30:	254c9102 	strbcs	r9, [ip, #-258]	; 0xfffffefe
     c34:	00000850 	andeq	r0, r0, r0, asr r8
     c38:	9d1bed01 	ldcls	13, cr14, [fp, #-4]
     c3c:	02000009 	andeq	r0, r0, #9
     c40:	dd234891 	stcle	8, cr4, [r3, #-580]!	; 0xfffffdbc
     c44:	0100000c 	tsteq	r0, ip
     c48:	00590eef 	subseq	r0, r9, pc, ror #29
     c4c:	91020000 	mrsls	r0, (UNDEF: 2)
     c50:	049b2374 	ldreq	r2, [fp], #884	; 0x374
     c54:	f0010000 			; <UNDEFINED> instruction: 0xf0010000
     c58:	0009a90a 	andeq	sl, r9, sl, lsl #18
     c5c:	54910200 	ldrpl	r0, [r1], #512	; 0x200
     c60:	00047f26 	andeq	r7, r4, r6, lsr #30
     c64:	01020100 	mrseq	r0, (UNDEF: 18)
     c68:	0007cf17 	andeq	ip, r7, r7, lsl pc
     c6c:	50910200 	addspl	r0, r1, r0, lsl #4
     c70:	a3040e00 	movwge	r0, #19968	; 0x4e00
     c74:	0e000009 	cdpeq	0, 0, cr0, cr0, cr9, {0}
     c78:	00002504 	andeq	r2, r0, r4, lsl #10
     c7c:	00250c00 	eoreq	r0, r5, r0, lsl #24
     c80:	09b90000 	ldmibeq	r9!, {}	; <UNPREDICTABLE>
     c84:	6a0d0000 	bvs	340c8c <__bss_end+0x336f00>
     c88:	1f000000 	svcne	0x00000000
     c8c:	0a982700 	beq	fe60a894 <__bss_end+0xfe600b08>
     c90:	e3010000 	movw	r0, #4096	; 0x1000
     c94:	00075106 	andeq	r5, r7, r6, lsl #2
     c98:	008ab000 	addeq	fp, sl, r0
     c9c:	00007400 	andeq	r7, r0, r0, lsl #8
     ca0:	e39c0100 	orrs	r0, ip, #0, 2
     ca4:	23000009 	movwcs	r0, #9
     ca8:	00000cdd 	ldrdeq	r0, [r0], -sp
     cac:	590ee401 	stmdbpl	lr, {r0, sl, sp, lr, pc}
     cb0:	02000000 	andeq	r0, r0, #0
     cb4:	27007491 			; <UNDEFINED> instruction: 0x27007491
     cb8:	00000863 	andeq	r0, r0, r3, ror #16
     cbc:	b206d701 	andlt	sp, r6, #262144	; 0x40000
     cc0:	7000000a 	andvc	r0, r0, sl
     cc4:	4000008a 	andmi	r0, r0, sl, lsl #1
     cc8:	01000000 	mrseq	r0, (UNDEF: 0)
     ccc:	000a1c9c 	muleq	sl, ip, ip
     cd0:	049b2300 	ldreq	r2, [fp], #768	; 0x300
     cd4:	d8010000 	stmdale	r1, {}	; <UNPREDICTABLE>
     cd8:	000a1c0a 	andeq	r1, sl, sl, lsl #24
     cdc:	6c910200 	lfmvs	f0, 4, [r1], {0}
     ce0:	67736d28 	ldrbvs	r6, [r3, -r8, lsr #26]!
     ce4:	13d80100 	bicsne	r0, r8, #0, 2
     ce8:	000009a9 	andeq	r0, r0, r9, lsr #19
     cec:	004c9102 	subeq	r9, ip, r2, lsl #2
     cf0:	0000250c 	andeq	r2, r0, ip, lsl #10
     cf4:	000a2c00 	andeq	r2, sl, r0, lsl #24
     cf8:	006a0d00 	rsbeq	r0, sl, r0, lsl #26
     cfc:	00080000 	andeq	r0, r8, r0
     d00:	00047227 	andeq	r7, r4, r7, lsr #4
     d04:	06c40100 	strbeq	r0, [r4], r0, lsl #2
     d08:	00000cc5 	andeq	r0, r0, r5, asr #25
     d0c:	000089b0 			; <UNDEFINED> instruction: 0x000089b0
     d10:	000000c0 	andeq	r0, r0, r0, asr #1
     d14:	0a839c01 	beq	fe0e7d20 <__bss_end+0xfe0ddf94>
     d18:	9b230000 	blls	8c0d20 <__bss_end+0x8b6f94>
     d1c:	01000004 	tsteq	r0, r4
     d20:	0a830ac6 	beq	fe0c3840 <__bss_end+0xfe0b9ab4>
     d24:	91020000 	mrsls	r0, (UNDEF: 2)
     d28:	0ae92370 	beq	ffa49af0 <__bss_end+0xffa3fd64>
     d2c:	c6010000 	strgt	r0, [r1], -r0
     d30:	0009a913 	andeq	sl, r9, r3, lsl r9
     d34:	50910200 	addspl	r0, r1, r0, lsl #4
     d38:	000af123 	andeq	pc, sl, r3, lsr #2
     d3c:	0ac90100 	beq	ff241144 <__bss_end+0xff2373b8>
     d40:	00000025 	andeq	r0, r0, r5, lsr #32
     d44:	23779102 	cmncs	r7, #-2147483648	; 0x80000000
     d48:	0000050d 	andeq	r0, r0, sp, lsl #10
     d4c:	2d0bca01 	vstrcs	s24, [fp, #-4]
     d50:	02000008 	andeq	r0, r0, #8
     d54:	0c004c91 	stceq	12, cr4, [r0], {145}	; 0x91
     d58:	00000025 	andeq	r0, r0, r5, lsr #32
     d5c:	00000a93 	muleq	r0, r3, sl
     d60:	00006a0d 	andeq	r6, r0, sp, lsl #20
     d64:	27000500 	strcs	r0, [r0, -r0, lsl #10]
     d68:	00000d74 	andeq	r0, r0, r4, ror sp
     d6c:	8006a801 	andhi	sl, r6, r1, lsl #16
     d70:	9c000007 	stcls	0, cr0, [r0], {7}
     d74:	14000088 	strne	r0, [r0], #-136	; 0xffffff78
     d78:	01000001 	tsteq	r0, r1
     d7c:	000aea9c 	muleq	sl, ip, sl
     d80:	0af12500 	beq	ffc4a188 <__bss_end+0xffc403fc>
     d84:	a8010000 	stmdage	r1, {}	; <UNPREDICTABLE>
     d88:	00002517 	andeq	r2, r0, r7, lsl r5
     d8c:	47910200 	ldrmi	r0, [r1, r0, lsl #4]
     d90:	00050d25 	andeq	r0, r5, r5, lsr #26
     d94:	2aa80100 	bcs	fea0119c <__bss_end+0xfe9f7410>
     d98:	0000082d 	andeq	r0, r0, sp, lsr #16
     d9c:	23409102 	movtcs	r9, #258	; 0x102
     da0:	00000ae9 	andeq	r0, r0, r9, ror #21
     da4:	a90aaa01 	stmdbge	sl, {r0, r9, fp, sp, pc}
     da8:	02000009 	andeq	r0, r0, #9
     dac:	f5235891 			; <UNDEFINED> instruction: 0xf5235891
     db0:	01000005 	tsteq	r0, r5
     db4:	01e317aa 	mvneq	r1, sl, lsr #15
     db8:	91020000 	mrsls	r0, (UNDEF: 2)
     dbc:	99290048 	stmdbls	r9!, {r3, r6}
     dc0:	0100000b 	tsteq	r0, fp
     dc4:	0d5d0680 	ldcleq	6, cr0, [sp, #-512]	; 0xfffffe00
     dc8:	01f30000 	mvnseq	r0, r0
     dcc:	86cc0000 	strbhi	r0, [ip], r0
     dd0:	01d00000 	bicseq	r0, r0, r0
     dd4:	9c010000 	stcls	0, cr0, [r1], {-0}
     dd8:	00000b47 	andeq	r0, r0, r7, asr #22
     ddc:	00079225 	andeq	r9, r7, r5, lsr #4
     de0:	1a800100 	bne	fe0011e8 <__bss_end+0xfdff745c>
     de4:	000007a5 	andeq	r0, r0, r5, lsr #15
     de8:	7fac9103 	svcvc	0x00ac9103
     dec:	000a5323 	andeq	r5, sl, r3, lsr #6
     df0:	0a820100 	beq	fe0811f8 <__bss_end+0xfe07746c>
     df4:	00000b47 	andeq	r0, r0, r7, asr #22
     df8:	23749102 	cmncs	r4, #-2147483648	; 0x80000000
     dfc:	0000049b 	muleq	r0, fp, r4
     e00:	a9138201 	ldmdbge	r3, {r0, r9, pc}
     e04:	02000009 	andeq	r0, r0, #9
     e08:	e9235491 	stmdb	r3!, {r0, r4, r7, sl, ip, lr}
     e0c:	0100000a 	tsteq	r0, sl
     e10:	09a91d82 	stmibeq	r9!, {r1, r7, r8, sl, fp, ip}
     e14:	91030000 	mrsls	r0, (UNDEF: 3)
     e18:	0c007fb4 	stceq	15, cr7, [r0], {180}	; 0xb4
     e1c:	00000025 	andeq	r0, r0, r5, lsr #32
     e20:	00000b57 	andeq	r0, r0, r7, asr fp
     e24:	00006a0d 	andeq	r6, r0, sp, lsl #20
     e28:	29000300 	stmdbcs	r0, {r8, r9}
     e2c:	00000be3 	andeq	r0, r0, r3, ror #23
     e30:	620b5c01 	andvs	r5, fp, #256	; 0x100
     e34:	a5000009 	strge	r0, [r0, #-9]
     e38:	d4000007 	strle	r0, [r0], #-7
     e3c:	f8000085 			; <UNDEFINED> instruction: 0xf8000085
     e40:	01000000 	mrseq	r0, (UNDEF: 0)
     e44:	000ba39c 	muleq	fp, ip, r3
     e48:	08032500 	stmdaeq	r3, {r8, sl, sp}
     e4c:	5c010000 	stcpl	0, cr0, [r1], {-0}
     e50:	0007a521 	andeq	sl, r7, r1, lsr #10
     e54:	6c910200 	lfmvs	f0, 4, [r1], {0}
     e58:	00049025 	andeq	r9, r4, r5, lsr #32
     e5c:	305c0100 	subscc	r0, ip, r0, lsl #2
     e60:	000009a3 	andeq	r0, r0, r3, lsr #19
     e64:	23689102 	cmncs	r8, #-2147483648	; 0x80000000
     e68:	00000726 	andeq	r0, r0, r6, lsr #14
     e6c:	a50f5e01 	strge	r5, [pc, #-3585]	; 73 <shift+0x73>
     e70:	02000007 	andeq	r0, r0, #7
     e74:	27007491 			; <UNDEFINED> instruction: 0x27007491
     e78:	00000508 	andeq	r0, r0, r8, lsl #10
     e7c:	28065001 	stmdacs	r6, {r0, ip, lr}
     e80:	3000000e 	andcc	r0, r0, lr
     e84:	a4000085 	strge	r0, [r0], #-133	; 0xffffff7b
     e88:	01000000 	mrseq	r0, (UNDEF: 0)
     e8c:	000beb9c 	muleq	fp, ip, fp
     e90:	050d2500 	streq	r2, [sp, #-1280]	; 0xfffffb00
     e94:	50010000 	andpl	r0, r1, r0
     e98:	0008341d 	andeq	r3, r8, sp, lsl r4
     e9c:	4c910200 	lfmmi	f0, 4, [r1], {0}
     ea0:	6d6f7028 	stclvs	0, cr7, [pc, #-160]!	; e08 <shift+0xe08>
     ea4:	0a510100 	beq	14412ac <__bss_end+0x1437520>
     ea8:	00000beb 	andeq	r0, r0, fp, ror #23
     eac:	23709102 	cmncs	r0, #-2147483648	; 0x80000000
     eb0:	0000049b 	muleq	r0, fp, r4
     eb4:	a9125101 	ldmdbge	r2, {r0, r8, ip, lr}
     eb8:	02000009 	andeq	r0, r0, #9
     ebc:	0c005091 	stceq	0, cr5, [r0], {145}	; 0x91
     ec0:	00000025 	andeq	r0, r0, r5, lsr #32
     ec4:	00000bfb 	strdeq	r0, [r0], -fp
     ec8:	00006a0d 	andeq	r6, r0, sp, lsl #20
     ecc:	27000400 	strcs	r0, [r0, -r0, lsl #8]
     ed0:	00000776 	andeq	r0, r0, r6, ror r7
     ed4:	86063b01 	strhi	r3, [r6], -r1, lsl #22
     ed8:	34000005 	strcc	r0, [r0], #-5
     edc:	fc000084 	stc2	0, cr0, [r0], {132}	; 0x84
     ee0:	01000000 	mrseq	r0, (UNDEF: 0)
     ee4:	000c439c 	muleq	ip, ip, r3
     ee8:	050d2500 	streq	r2, [sp, #-1280]	; 0xfffffb00
     eec:	3b010000 	blcc	40ef4 <__bss_end+0x37168>
     ef0:	0008341c 	andeq	r3, r8, ip, lsl r4
     ef4:	64910200 	ldrvs	r0, [r1], #512	; 0x200
     ef8:	000b8623 	andeq	r8, fp, r3, lsr #12
     efc:	0b3d0100 	bleq	f41304 <__bss_end+0xf37578>
     f00:	0000082d 	andeq	r0, r0, sp, lsr #16
     f04:	28749102 	ldmdacs	r4!, {r1, r8, ip, pc}^
     f08:	0067736d 	rsbeq	r7, r7, sp, ror #6
     f0c:	830a3e01 	movwhi	r3, #44545	; 0xae01
     f10:	0200000a 	andeq	r0, r0, #10
     f14:	2a006c91 	bcs	1c160 <__bss_end+0x123d4>
     f18:	00676f6c 	rsbeq	r6, r7, ip, ror #30
     f1c:	5b063401 	blpl	18df28 <__bss_end+0x18419c>
     f20:	c0000008 	andgt	r0, r0, r8
     f24:	74000083 	strvc	r0, [r0], #-131	; 0xffffff7d
     f28:	01000000 	mrseq	r0, (UNDEF: 0)
     f2c:	000c8d9c 	muleq	ip, ip, sp
     f30:	050d2500 	streq	r2, [sp, #-1280]	; 0xfffffb00
     f34:	34010000 	strcc	r0, [r1], #-0
     f38:	00006519 	andeq	r6, r0, r9, lsl r5
     f3c:	ac910300 	ldcge	3, cr0, [r1], {0}
     f40:	049b237f 	ldreq	r2, [fp], #895	; 0x37f
     f44:	35010000 	strcc	r0, [r1, #-0]
     f48:	0009a90a 	andeq	sl, r9, sl, lsl #18
     f4c:	50910200 	addspl	r0, r1, r0, lsl #4
     f50:	6d6f7028 	stclvs	0, cr7, [pc, #-160]!	; eb8 <shift+0xeb8>
     f54:	14350100 	ldrtne	r0, [r5], #-256	; 0xffffff00
     f58:	000009a9 	andeq	r0, r0, r9, lsr #19
     f5c:	7fb09103 	svcvc	0x00b09103
     f60:	6f6c2a00 	svcvs	0x006c2a00
     f64:	2d010067 	stccs	0, cr0, [r1, #-412]	; 0xfffffe64
     f68:	00076c06 	andeq	r6, r7, r6, lsl #24
     f6c:	0082d800 	addeq	sp, r2, r0, lsl #16
     f70:	0000e800 	andeq	lr, r0, r0, lsl #16
     f74:	c79c0100 	ldrgt	r0, [ip, r0, lsl #2]
     f78:	2b00000c 	blcs	fb0 <shift+0xfb0>
     f7c:	0067736d 	rsbeq	r7, r7, sp, ror #6
     f80:	fa162d01 	blx	58c38c <__bss_end+0x582600>
     f84:	02000001 	andeq	r0, r0, #1
     f88:	7e235491 	mcrvc	4, 1, r5, cr3, cr1, {4}
     f8c:	01000008 	tsteq	r0, r8
     f90:	0cc70a2f 	vstmiaeq	r7, {s1-s47}
     f94:	91030000 	mrsls	r0, (UNDEF: 3)
     f98:	0c000658 	stceq	6, cr0, [r0], {88}	; 0x58
     f9c:	00000025 	andeq	r0, r0, r5, lsr #32
     fa0:	00000cda 	ldrdeq	r0, [r0], -sl
     fa4:	00006a2c 	andeq	r6, r0, ip, lsr #20
     fa8:	5c910300 	ldcpl	3, cr0, [r1], {0}
     fac:	b72d0006 	strlt	r0, [sp, -r6]!
     fb0:	01000008 	tsteq	r0, r8
     fb4:	0d0a061c 	stceq	6, cr0, [sl, #-112]	; 0xffffff90
     fb8:	822c0000 	eorhi	r0, ip, #0
     fbc:	00ac0000 	adceq	r0, ip, r0
     fc0:	9c010000 	stcls	0, cr0, [r1], {-0}
     fc4:	00049b25 	andeq	r9, r4, r5, lsr #22
     fc8:	151c0100 	ldrne	r0, [ip, #-256]	; 0xffffff00
     fcc:	000009a3 	andeq	r0, r0, r3, lsr #19
     fd0:	2b6c9102 	blcs	1b253e0 <__bss_end+0x1b1b654>
     fd4:	0067736d 	rsbeq	r7, r7, sp, ror #6
     fd8:	fa271c01 	blx	9c7fe4 <__bss_end+0x9be258>
     fdc:	02000001 	andeq	r0, r0, #1
     fe0:	00006891 	muleq	r0, r1, r8
     fe4:	00000b1f 	andeq	r0, r0, pc, lsl fp
     fe8:	04c50004 	strbeq	r0, [r5], #4
     fec:	01040000 	mrseq	r0, (UNDEF: 4)
     ff0:	000011da 	ldrdeq	r1, [r0], -sl
     ff4:	0010ca04 	andseq	ip, r0, r4, lsl #20
     ff8:	000ee700 	andeq	lr, lr, r0, lsl #14
     ffc:	008ca000 	addeq	sl, ip, r0
    1000:	00045c00 	andeq	r5, r4, r0, lsl #24
    1004:	0007d300 	andeq	sp, r7, r0, lsl #6
    1008:	08010200 	stmdaeq	r1, {r9}
    100c:	00000d05 	andeq	r0, r0, r5, lsl #26
    1010:	00002503 	andeq	r2, r0, r3, lsl #10
    1014:	05020200 	streq	r0, [r2, #-512]	; 0xfffffe00
    1018:	00000b59 	andeq	r0, r0, r9, asr fp
    101c:	69050404 	stmdbvs	r5, {r2, sl}
    1020:	0200746e 	andeq	r7, r0, #1845493760	; 0x6e000000
    1024:	0cfc0801 	ldcleq	8, cr0, [ip], #4
    1028:	02020000 	andeq	r0, r2, #0
    102c:	000e0507 	andeq	r0, lr, r7, lsl #10
    1030:	066e0500 	strbteq	r0, [lr], -r0, lsl #10
    1034:	09070000 	stmdbeq	r7, {}	; <UNPREDICTABLE>
    1038:	00005e07 	andeq	r5, r0, r7, lsl #28
    103c:	004d0300 	subeq	r0, sp, r0, lsl #6
    1040:	04020000 	streq	r0, [r2], #-0
    1044:	000c4607 	andeq	r4, ip, r7, lsl #12
    1048:	0edb0600 	cdpeq	6, 13, cr0, cr11, cr0, {0}
    104c:	02080000 	andeq	r0, r8, #0
    1050:	008b0806 	addeq	r0, fp, r6, lsl #16
    1054:	72070000 	andvc	r0, r7, #0
    1058:	08020030 	stmdaeq	r2, {r4, r5}
    105c:	00004d0e 	andeq	r4, r0, lr, lsl #26
    1060:	72070000 	andvc	r0, r7, #0
    1064:	09020031 	stmdbeq	r2, {r0, r4, r5}
    1068:	00004d0e 	andeq	r4, r0, lr, lsl #26
    106c:	08000400 	stmdaeq	r0, {sl}
    1070:	00001164 	andeq	r1, r0, r4, ror #2
    1074:	00380405 	eorseq	r0, r8, r5, lsl #8
    1078:	0d020000 	stceq	0, cr0, [r2, #-0]
    107c:	0000a90c 	andeq	sl, r0, ip, lsl #18
    1080:	4b4f0900 	blmi	13c3488 <__bss_end+0x13b96fc>
    1084:	950a0000 	strls	r0, [sl, #-0]
    1088:	0100000f 	tsteq	r0, pc
    108c:	0bbb0800 	bleq	feec3094 <__bss_end+0xfeeb9308>
    1090:	04050000 	streq	r0, [r5], #-0
    1094:	00000038 	andeq	r0, r0, r8, lsr r0
    1098:	e00c1e02 	and	r1, ip, r2, lsl #28
    109c:	0a000000 	beq	10a4 <shift+0x10a4>
    10a0:	00000666 	andeq	r0, r0, r6, ror #12
    10a4:	08740a00 	ldmdaeq	r4!, {r9, fp}^
    10a8:	0a010000 	beq	410b0 <__bss_end+0x37324>
    10ac:	00000bdd 	ldrdeq	r0, [r0], -sp
    10b0:	0d380a02 	vldmdbeq	r8!, {s0-s1}
    10b4:	0a030000 	beq	c10bc <__bss_end+0xb7330>
    10b8:	00000841 	andeq	r0, r0, r1, asr #16
    10bc:	0b380a04 	bleq	e038d4 <__bss_end+0xdf9b48>
    10c0:	00050000 	andeq	r0, r5, r0
    10c4:	000ba308 	andeq	sl, fp, r8, lsl #6
    10c8:	38040500 	stmdacc	r4, {r8, sl}
    10cc:	02000000 	andeq	r0, r0, #0
    10d0:	011d0c3f 	tsteq	sp, pc, lsr ip
    10d4:	4c0a0000 	stcmi	0, cr0, [sl], {-0}
    10d8:	00000007 	andeq	r0, r0, r7
    10dc:	00086f0a 	andeq	r6, r8, sl, lsl #30
    10e0:	740a0100 	strvc	r0, [sl], #-256	; 0xffffff00
    10e4:	0200000e 	andeq	r0, r0, #14
    10e8:	000a620a 	andeq	r6, sl, sl, lsl #4
    10ec:	550a0300 	strpl	r0, [sl, #-768]	; 0xfffffd00
    10f0:	04000008 	streq	r0, [r0], #-8
    10f4:	0008e90a 	andeq	lr, r8, sl, lsl #18
    10f8:	ab0a0500 	blge	282500 <__bss_end+0x278774>
    10fc:	06000006 	streq	r0, [r0], -r6
    1100:	06830800 	streq	r0, [r3], r0, lsl #16
    1104:	04050000 	streq	r0, [r5], #-0
    1108:	00000038 	andeq	r0, r0, r8, lsr r0
    110c:	480c6602 	stmdami	ip, {r1, r9, sl, sp, lr}
    1110:	0a000001 	beq	111c <shift+0x111c>
    1114:	00000cf1 	strdeq	r0, [r0], -r1
    1118:	05940a00 	ldreq	r0, [r4, #2560]	; 0xa00
    111c:	0a010000 	beq	41124 <__bss_end+0x37398>
    1120:	00000c0d 	andeq	r0, r0, sp, lsl #24
    1124:	0b410a02 	bleq	1043934 <__bss_end+0x1039ba8>
    1128:	00030000 	andeq	r0, r3, r0
    112c:	000a340b 	andeq	r3, sl, fp, lsl #8
    1130:	14050300 	strne	r0, [r5], #-768	; 0xfffffd00
    1134:	00000059 	andeq	r0, r0, r9, asr r0
    1138:	9c9c0305 	ldcls	3, cr0, [ip], {5}
    113c:	670b0000 	strvs	r0, [fp, -r0]
    1140:	0300000c 	movweq	r0, #12
    1144:	00591406 	subseq	r1, r9, r6, lsl #8
    1148:	03050000 	movweq	r0, #20480	; 0x5000
    114c:	00009ca0 	andeq	r9, r0, r0, lsr #25
    1150:	0008fe0b 	andeq	pc, r8, fp, lsl #28
    1154:	1a070400 	bne	1c215c <__bss_end+0x1b83d0>
    1158:	00000059 	andeq	r0, r0, r9, asr r0
    115c:	9ca40305 	stcls	3, cr0, [r4], #20
    1160:	630b0000 	movwvs	r0, #45056	; 0xb000
    1164:	0400000b 	streq	r0, [r0], #-11
    1168:	00591a09 	subseq	r1, r9, r9, lsl #20
    116c:	03050000 	movweq	r0, #20480	; 0x5000
    1170:	00009ca8 	andeq	r9, r0, r8, lsr #25
    1174:	0008f00b 	andeq	pc, r8, fp
    1178:	1a0b0400 	bne	2c2180 <__bss_end+0x2b83f4>
    117c:	00000059 	andeq	r0, r0, r9, asr r0
    1180:	9cac0305 	stcls	3, cr0, [ip], #20
    1184:	250b0000 	strcs	r0, [fp, #-0]
    1188:	0400000b 	streq	r0, [r0], #-11
    118c:	00591a0d 	subseq	r1, r9, sp, lsl #20
    1190:	03050000 	movweq	r0, #20480	; 0x5000
    1194:	00009cb0 			; <UNDEFINED> instruction: 0x00009cb0
    1198:	0006460b 	andeq	r4, r6, fp, lsl #12
    119c:	1a0f0400 	bne	3c21a4 <__bss_end+0x3b8418>
    11a0:	00000059 	andeq	r0, r0, r9, asr r0
    11a4:	9cb40305 	ldcls	3, cr0, [r4], #20
    11a8:	cd080000 	stcgt	0, cr0, [r8, #-0]
    11ac:	05000012 	streq	r0, [r0, #-18]	; 0xffffffee
    11b0:	00003804 	andeq	r3, r0, r4, lsl #16
    11b4:	0c1b0400 	cfldrseq	mvf0, [fp], {-0}
    11b8:	000001eb 	andeq	r0, r0, fp, ror #3
    11bc:	0005eb0a 	andeq	lr, r5, sl, lsl #22
    11c0:	8e0a0000 	cdphi	0, 0, cr0, cr10, cr0, {0}
    11c4:	0100000d 	tsteq	r0, sp
    11c8:	000e6f0a 	andeq	r6, lr, sl, lsl #30
    11cc:	0c000200 	sfmeq	f0, 4, [r0], {-0}
    11d0:	00000459 	andeq	r0, r0, r9, asr r4
    11d4:	5d020102 	stfpls	f0, [r2, #-8]
    11d8:	0d000009 	stceq	0, cr0, [r0, #-36]	; 0xffffffdc
    11dc:	00002c04 	andeq	r2, r0, r4, lsl #24
    11e0:	eb040d00 	bl	1045e8 <__bss_end+0xfa85c>
    11e4:	0b000001 	bleq	11f0 <shift+0x11f0>
    11e8:	000005ff 	strdeq	r0, [r0], -pc	; <UNPREDICTABLE>
    11ec:	59140405 	ldmdbpl	r4, {r0, r2, sl}
    11f0:	05000000 	streq	r0, [r0, #-0]
    11f4:	009cb803 	addseq	fp, ip, r3, lsl #16
    11f8:	0bef0b00 	bleq	ffbc3e00 <__bss_end+0xffbba074>
    11fc:	07050000 	streq	r0, [r5, -r0]
    1200:	00005914 	andeq	r5, r0, r4, lsl r9
    1204:	bc030500 	cfstr32lt	mvfx0, [r3], {-0}
    1208:	0b00009c 	bleq	1480 <shift+0x1480>
    120c:	0000052a 	andeq	r0, r0, sl, lsr #10
    1210:	59140a05 	ldmdbpl	r4, {r0, r2, r9, fp}
    1214:	05000000 	streq	r0, [r0, #-0]
    1218:	009cc003 	addseq	ip, ip, r3
    121c:	06b00800 	ldrteq	r0, [r0], r0, lsl #16
    1220:	04050000 	streq	r0, [r5], #-0
    1224:	00000038 	andeq	r0, r0, r8, lsr r0
    1228:	700c0d05 	andvc	r0, ip, r5, lsl #26
    122c:	09000002 	stmdbeq	r0, {r1}
    1230:	0077654e 	rsbseq	r6, r7, lr, asr #10
    1234:	04ff0a00 	ldrbteq	r0, [pc], #2560	; 123c <shift+0x123c>
    1238:	0a010000 	beq	41240 <__bss_end+0x374b4>
    123c:	00000522 	andeq	r0, r0, r2, lsr #10
    1240:	06c90a02 	strbeq	r0, [r9], r2, lsl #20
    1244:	0a030000 	beq	c124c <__bss_end+0xb74c0>
    1248:	00000d2a 	andeq	r0, r0, sl, lsr #26
    124c:	04ec0a04 	strbteq	r0, [ip], #2564	; 0xa04
    1250:	00050000 	andeq	r0, r5, r0
    1254:	00061806 	andeq	r1, r6, r6, lsl #16
    1258:	1b051000 	blne	145260 <__bss_end+0x13b4d4>
    125c:	0002af08 	andeq	sl, r2, r8, lsl #30
    1260:	726c0700 	rsbvc	r0, ip, #0, 14
    1264:	131d0500 	tstne	sp, #0, 10
    1268:	000002af 	andeq	r0, r0, pc, lsr #5
    126c:	70730700 	rsbsvc	r0, r3, r0, lsl #14
    1270:	131e0500 	tstne	lr, #0, 10
    1274:	000002af 	andeq	r0, r0, pc, lsr #5
    1278:	63700704 	cmnvs	r0, #4, 14	; 0x100000
    127c:	131f0500 	tstne	pc, #0, 10
    1280:	000002af 	andeq	r0, r0, pc, lsr #5
    1284:	0b930e08 	bleq	fe4c4aac <__bss_end+0xfe4bad20>
    1288:	20050000 	andcs	r0, r5, r0
    128c:	0002af13 	andeq	sl, r2, r3, lsl pc
    1290:	02000c00 	andeq	r0, r0, #0, 24
    1294:	0c410704 	mcrreq	7, 0, r0, r1, cr4
    1298:	34060000 	strcc	r0, [r6], #-0
    129c:	70000008 	andvc	r0, r0, r8
    12a0:	46082805 	strmi	r2, [r8], -r5, lsl #16
    12a4:	0e000003 	cdpeq	0, 0, cr0, cr0, cr3, {0}
    12a8:	00000731 	andeq	r0, r0, r1, lsr r7
    12ac:	70122a05 	andsvc	r2, r2, r5, lsl #20
    12b0:	00000002 	andeq	r0, r0, r2
    12b4:	64697007 	strbtvs	r7, [r9], #-7
    12b8:	122b0500 	eorne	r0, fp, #0, 10
    12bc:	0000005e 	andeq	r0, r0, lr, asr r0
    12c0:	0af70e10 	beq	ffdc4b08 <__bss_end+0xffdbad7c>
    12c4:	2c050000 	stccs	0, cr0, [r5], {-0}
    12c8:	00023911 	andeq	r3, r2, r1, lsl r9
    12cc:	d70e1400 	strle	r1, [lr, -r0, lsl #8]
    12d0:	0500000c 	streq	r0, [r0, #-12]
    12d4:	005e122d 	subseq	r1, lr, sp, lsr #4
    12d8:	0e180000 	cdpeq	0, 1, cr0, cr8, cr0, {0}
    12dc:	000003e9 	andeq	r0, r0, r9, ror #7
    12e0:	5e122e05 	cdppl	14, 1, cr2, cr2, cr5, {0}
    12e4:	1c000000 	stcne	0, cr0, [r0], {-0}
    12e8:	000bd00e 	andeq	sp, fp, lr
    12ec:	0c2f0500 	cfstr32eq	mvfx0, [pc], #-0	; 12f4 <shift+0x12f4>
    12f0:	00000346 	andeq	r0, r0, r6, asr #6
    12f4:	04860e20 	streq	r0, [r6], #3616	; 0xe20
    12f8:	30050000 	andcc	r0, r5, r0
    12fc:	00003809 	andeq	r3, r0, r9, lsl #16
    1300:	e40e6000 	str	r6, [lr], #-0
    1304:	05000006 	streq	r0, [r0, #-6]
    1308:	004d0e31 	subeq	r0, sp, r1, lsr lr
    130c:	0e640000 	cdpeq	0, 6, cr0, cr4, cr0, {0}
    1310:	00000acc 	andeq	r0, r0, ip, asr #21
    1314:	4d0e3305 	stcmi	3, cr3, [lr, #-20]	; 0xffffffec
    1318:	68000000 	stmdavs	r0, {}	; <UNPREDICTABLE>
    131c:	000ac30e 	andeq	ip, sl, lr, lsl #6
    1320:	0e340500 	cfabs32eq	mvfx0, mvfx4
    1324:	0000004d 	andeq	r0, r0, sp, asr #32
    1328:	fd0f006c 	stc2	0, cr0, [pc, #-432]	; 1180 <shift+0x1180>
    132c:	56000001 	strpl	r0, [r0], -r1
    1330:	10000003 	andne	r0, r0, r3
    1334:	0000005e 	andeq	r0, r0, lr, asr r0
    1338:	130b000f 	movwne	r0, #45071	; 0xb00f
    133c:	06000005 	streq	r0, [r0], -r5
    1340:	0059140a 	subseq	r1, r9, sl, lsl #8
    1344:	03050000 	movweq	r0, #20480	; 0x5000
    1348:	00009cc4 	andeq	r9, r0, r4, asr #25
    134c:	00093908 	andeq	r3, r9, r8, lsl #18
    1350:	38040500 	stmdacc	r4, {r8, sl}
    1354:	06000000 	streq	r0, [r0], -r0
    1358:	03870c0d 	orreq	r0, r7, #3328	; 0xd00
    135c:	7a0a0000 	bvc	281364 <__bss_end+0x2775d8>
    1360:	0000000e 	andeq	r0, r0, lr
    1364:	000da20a 	andeq	sl, sp, sl, lsl #4
    1368:	03000100 	movweq	r0, #256	; 0x100
    136c:	00000368 	andeq	r0, r0, r8, ror #6
    1370:	00105c08 	andseq	r5, r0, r8, lsl #24
    1374:	38040500 	stmdacc	r4, {r8, sl}
    1378:	06000000 	streq	r0, [r0], -r0
    137c:	03ab0c14 			; <UNDEFINED> instruction: 0x03ab0c14
    1380:	380a0000 	stmdacc	sl, {}	; <UNPREDICTABLE>
    1384:	0000000f 	andeq	r0, r0, pc
    1388:	0011360a 	andseq	r3, r1, sl, lsl #12
    138c:	03000100 	movweq	r0, #256	; 0x100
    1390:	0000038c 	andeq	r0, r0, ip, lsl #7
    1394:	00071306 	andeq	r1, r7, r6, lsl #6
    1398:	1b060c00 	blne	1843a0 <__bss_end+0x17a614>
    139c:	0003e508 	andeq	lr, r3, r8, lsl #10
    13a0:	05b80e00 	ldreq	r0, [r8, #3584]!	; 0xe00
    13a4:	1d060000 	stcne	0, cr0, [r6, #-0]
    13a8:	0003e519 	andeq	lr, r3, r9, lsl r5
    13ac:	fa0e0000 	blx	3813b4 <__bss_end+0x377628>
    13b0:	06000004 	streq	r0, [r0], -r4
    13b4:	03e5191e 	mvneq	r1, #491520	; 0x78000
    13b8:	0e040000 	cdpeq	0, 0, cr0, cr4, cr0, {0}
    13bc:	00000a9e 	muleq	r0, lr, sl
    13c0:	eb131f06 	bl	4c8fe0 <__bss_end+0x4bf254>
    13c4:	08000003 	stmdaeq	r0, {r0, r1}
    13c8:	b0040d00 	andlt	r0, r4, r0, lsl #26
    13cc:	0d000003 	stceq	0, cr0, [r0, #-12]
    13d0:	0002b604 	andeq	fp, r2, r4, lsl #12
    13d4:	0b751100 	bleq	1d457dc <__bss_end+0x1d3ba50>
    13d8:	06140000 	ldreq	r0, [r4], -r0
    13dc:	06730722 	ldrbteq	r0, [r3], -r2, lsr #14
    13e0:	420e0000 	andmi	r0, lr, #0
    13e4:	0600000a 	streq	r0, [r0], -sl
    13e8:	004d1226 	subeq	r1, sp, r6, lsr #4
    13ec:	0e000000 	cdpeq	0, 0, cr0, cr0, cr0, {0}
    13f0:	000009e4 	andeq	r0, r0, r4, ror #19
    13f4:	e51d2906 	ldr	r2, [sp, #-2310]	; 0xfffff6fa
    13f8:	04000003 	streq	r0, [r0], #-3
    13fc:	0006d10e 	andeq	sp, r6, lr, lsl #2
    1400:	1d2c0600 	stcne	6, cr0, [ip, #-0]
    1404:	000003e5 	andeq	r0, r0, r5, ror #7
    1408:	0a581208 	beq	1605c30 <__bss_end+0x15fbea4>
    140c:	2f060000 	svccs	0x00060000
    1410:	0006f00e 	andeq	pc, r6, lr
    1414:	00043900 	andeq	r3, r4, r0, lsl #18
    1418:	00044400 	andeq	r4, r4, r0, lsl #8
    141c:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
    1420:	e5140000 	ldr	r0, [r4, #-0]
    1424:	00000003 	andeq	r0, r0, r3
    1428:	00088e15 	andeq	r8, r8, r5, lsl lr
    142c:	0e310600 	cfmsuba32eq	mvax0, mvax0, mvfx1, mvfx0
    1430:	0000080b 	andeq	r0, r0, fp, lsl #16
    1434:	000001f0 	strdeq	r0, [r0], -r0	; <UNPREDICTABLE>
    1438:	0000045c 	andeq	r0, r0, ip, asr r4
    143c:	00000467 	andeq	r0, r0, r7, ror #8
    1440:	00067813 	andeq	r7, r6, r3, lsl r8
    1444:	03eb1400 	mvneq	r1, #0, 8
    1448:	16000000 	strne	r0, [r0], -r0
    144c:	00000d3e 	andeq	r0, r0, lr, lsr sp
    1450:	141d3506 	ldrne	r3, [sp], #-1286	; 0xfffffafa
    1454:	e5000009 	str	r0, [r0, #-9]
    1458:	02000003 	andeq	r0, r0, #3
    145c:	00000480 	andeq	r0, r0, r0, lsl #9
    1460:	00000486 	andeq	r0, r0, r6, lsl #9
    1464:	00067813 	andeq	r7, r6, r3, lsl r8
    1468:	bc160000 	ldclt	0, cr0, [r6], {-0}
    146c:	06000006 	streq	r0, [r0], -r6
    1470:	0a681d37 	beq	1a08954 <__bss_end+0x19febc8>
    1474:	03e50000 	mvneq	r0, #0
    1478:	9f020000 	svcls	0x00020000
    147c:	a5000004 	strge	r0, [r0, #-4]
    1480:	13000004 	movwne	r0, #4
    1484:	00000678 	andeq	r0, r0, r8, ror r6
    1488:	09f71700 	ldmibeq	r7!, {r8, r9, sl, ip}^
    148c:	39060000 	stmdbcc	r6, {}	; <UNPREDICTABLE>
    1490:	00069131 	andeq	r9, r6, r1, lsr r1
    1494:	16020c00 	strne	r0, [r2], -r0, lsl #24
    1498:	00000b75 	andeq	r0, r0, r5, ror fp
    149c:	9d093c06 	stcls	12, cr3, [r9, #-24]	; 0xffffffe8
    14a0:	78000008 	stmdavc	r0, {r3}
    14a4:	01000006 	tsteq	r0, r6
    14a8:	000004cc 	andeq	r0, r0, ip, asr #9
    14ac:	000004d2 	ldrdeq	r0, [r0], -r2
    14b0:	00067813 	andeq	r7, r6, r3, lsl r8
    14b4:	3d160000 	ldccc	0, cr0, [r6, #-0]
    14b8:	06000007 	streq	r0, [r0], -r7
    14bc:	055b123f 	ldrbeq	r1, [fp, #-575]	; 0xfffffdc1
    14c0:	004d0000 	subeq	r0, sp, r0
    14c4:	eb010000 	bl	414cc <__bss_end+0x37740>
    14c8:	00000004 	andeq	r0, r0, r4
    14cc:	13000005 	movwne	r0, #5
    14d0:	00000678 	andeq	r0, r0, r8, ror r6
    14d4:	00069a14 	andeq	r9, r6, r4, lsl sl
    14d8:	005e1400 	subseq	r1, lr, r0, lsl #8
    14dc:	f0140000 			; <UNDEFINED> instruction: 0xf0140000
    14e0:	00000001 	andeq	r0, r0, r1
    14e4:	000d9918 	andeq	r9, sp, r8, lsl r9
    14e8:	0e420600 	cdpeq	6, 4, cr0, cr2, cr0, {0}
    14ec:	00000625 	andeq	r0, r0, r5, lsr #12
    14f0:	00051501 	andeq	r1, r5, r1, lsl #10
    14f4:	00051b00 	andeq	r1, r5, r0, lsl #22
    14f8:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
    14fc:	16000000 	strne	r0, [r0], -r0
    1500:	0000053d 	andeq	r0, r0, sp, lsr r5
    1504:	bd174506 	cfldr32lt	mvfx4, [r7, #-24]	; 0xffffffe8
    1508:	eb000005 	bl	1524 <shift+0x1524>
    150c:	01000003 	tsteq	r0, r3
    1510:	00000534 	andeq	r0, r0, r4, lsr r5
    1514:	0000053a 	andeq	r0, r0, sl, lsr r5
    1518:	0006a013 	andeq	sl, r6, r3, lsl r0
    151c:	fa160000 	blx	581524 <__bss_end+0x577798>
    1520:	0600000b 	streq	r0, [r0], -fp
    1524:	03ff1748 	mvnseq	r1, #72, 14	; 0x1200000
    1528:	03eb0000 	mvneq	r0, #0
    152c:	53010000 	movwpl	r0, #4096	; 0x1000
    1530:	5e000005 	cdppl	0, 0, cr0, cr0, cr5, {0}
    1534:	13000005 	movwne	r0, #5
    1538:	000006a0 	andeq	r0, r0, r0, lsr #13
    153c:	00004d14 	andeq	r4, r0, r4, lsl sp
    1540:	50180000 	andspl	r0, r8, r0
    1544:	06000006 	streq	r0, [r0], -r6
    1548:	0a050e4b 	beq	144e7c <__bss_end+0x13b0f0>
    154c:	73010000 	movwvc	r0, #4096	; 0x1000
    1550:	79000005 	stmdbvc	r0, {r0, r2}
    1554:	13000005 	movwne	r0, #5
    1558:	00000678 	andeq	r0, r0, r8, ror r6
    155c:	088e1600 	stmeq	lr, {r9, sl, ip}
    1560:	4d060000 	stcmi	0, cr0, [r6, #-0]
    1564:	000afd0e 	andeq	pc, sl, lr, lsl #26
    1568:	0001f000 	andeq	pc, r1, r0
    156c:	05920100 	ldreq	r0, [r2, #256]	; 0x100
    1570:	059d0000 	ldreq	r0, [sp]
    1574:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
    1578:	14000006 	strne	r0, [r0], #-6
    157c:	0000004d 	andeq	r0, r0, sp, asr #32
    1580:	04c61600 	strbeq	r1, [r6], #1536	; 0x600
    1584:	50060000 	andpl	r0, r6, r0
    1588:	00042c12 	andeq	r2, r4, r2, lsl ip
    158c:	00004d00 	andeq	r4, r0, r0, lsl #26
    1590:	05b60100 	ldreq	r0, [r6, #256]!	; 0x100
    1594:	05c10000 	strbeq	r0, [r1]
    1598:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
    159c:	14000006 	strne	r0, [r0], #-6
    15a0:	000001fd 	strdeq	r0, [r0], -sp
    15a4:	045f1600 	ldrbeq	r1, [pc], #-1536	; 15ac <shift+0x15ac>
    15a8:	53060000 	movwpl	r0, #24576	; 0x6000
    15ac:	000dad0e 	andeq	sl, sp, lr, lsl #26
    15b0:	0001f000 	andeq	pc, r1, r0
    15b4:	05da0100 	ldrbeq	r0, [sl, #256]	; 0x100
    15b8:	05e50000 	strbeq	r0, [r5, #0]!
    15bc:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
    15c0:	14000006 	strne	r0, [r0], #-6
    15c4:	0000004d 	andeq	r0, r0, sp, asr #32
    15c8:	04a01800 	strteq	r1, [r0], #2048	; 0x800
    15cc:	56060000 	strpl	r0, [r6], -r0
    15d0:	000c730e 	andeq	r7, ip, lr, lsl #6
    15d4:	05fa0100 	ldrbeq	r0, [sl, #256]!	; 0x100
    15d8:	06190000 	ldreq	r0, [r9], -r0
    15dc:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
    15e0:	14000006 	strne	r0, [r0], #-6
    15e4:	000000a9 	andeq	r0, r0, r9, lsr #1
    15e8:	00004d14 	andeq	r4, r0, r4, lsl sp
    15ec:	004d1400 	subeq	r1, sp, r0, lsl #8
    15f0:	4d140000 	ldcmi	0, cr0, [r4, #-0]
    15f4:	14000000 	strne	r0, [r0], #-0
    15f8:	000006a6 	andeq	r0, r0, r6, lsr #13
    15fc:	0def1800 	stcleq	8, cr1, [pc]	; 1604 <shift+0x1604>
    1600:	58060000 	stmdapl	r6, {}	; <UNPREDICTABLE>
    1604:	000e8f0e 	andeq	r8, lr, lr, lsl #30
    1608:	062e0100 	strteq	r0, [lr], -r0, lsl #2
    160c:	064d0000 	strbeq	r0, [sp], -r0
    1610:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
    1614:	14000006 	strne	r0, [r0], #-6
    1618:	000000e0 	andeq	r0, r0, r0, ror #1
    161c:	00004d14 	andeq	r4, r0, r4, lsl sp
    1620:	004d1400 	subeq	r1, sp, r0, lsl #8
    1624:	4d140000 	ldcmi	0, cr0, [r4, #-0]
    1628:	14000000 	strne	r0, [r0], #-0
    162c:	000006a6 	andeq	r0, r0, r6, lsr #13
    1630:	04b31900 	ldrteq	r1, [r3], #2304	; 0x900
    1634:	5b060000 	blpl	18163c <__bss_end+0x1778b0>
    1638:	00097e0e 	andeq	r7, r9, lr, lsl #28
    163c:	0001f000 	andeq	pc, r1, r0
    1640:	06620100 	strbteq	r0, [r2], -r0, lsl #2
    1644:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
    1648:	14000006 	strne	r0, [r0], #-6
    164c:	00000368 	andeq	r0, r0, r8, ror #6
    1650:	0006ac14 	andeq	sl, r6, r4, lsl ip
    1654:	03000000 	movweq	r0, #0
    1658:	000003f1 	strdeq	r0, [r0], -r1
    165c:	03f1040d 	mvnseq	r0, #218103808	; 0xd000000
    1660:	e51a0000 	ldr	r0, [sl, #-0]
    1664:	8b000003 	blhi	1678 <shift+0x1678>
    1668:	91000006 	tstls	r0, r6
    166c:	13000006 	movwne	r0, #6
    1670:	00000678 	andeq	r0, r0, r8, ror r6
    1674:	03f11b00 	mvnseq	r1, #0, 22
    1678:	067e0000 	ldrbteq	r0, [lr], -r0
    167c:	040d0000 	streq	r0, [sp], #-0
    1680:	0000003f 	andeq	r0, r0, pc, lsr r0
    1684:	0673040d 	ldrbteq	r0, [r3], -sp, lsl #8
    1688:	041c0000 	ldreq	r0, [ip], #-0
    168c:	00000065 	andeq	r0, r0, r5, rrx
    1690:	2c0f041d 	cfstrscs	mvf0, [pc], {29}
    1694:	be000000 	cdplt	0, 0, cr0, cr0, cr0, {0}
    1698:	10000006 	andne	r0, r0, r6
    169c:	0000005e 	andeq	r0, r0, lr, asr r0
    16a0:	ae030009 	cdpge	0, 0, cr0, cr3, cr9, {0}
    16a4:	1e000006 	cdpne	0, 0, cr0, cr0, cr6, {0}
    16a8:	00000fe1 	andeq	r0, r0, r1, ror #31
    16ac:	be0ca301 	cdplt	3, 0, cr10, cr12, cr1, {0}
    16b0:	05000006 	streq	r0, [r0, #-6]
    16b4:	009cc803 	addseq	ip, ip, r3, lsl #16
    16b8:	0f511f00 	svceq	0x00511f00
    16bc:	a5010000 	strge	r0, [r1, #-0]
    16c0:	0010500a 	andseq	r5, r0, sl
    16c4:	00004d00 	andeq	r4, r0, r0, lsl #26
    16c8:	00904c00 	addseq	r4, r0, r0, lsl #24
    16cc:	0000b000 	andeq	fp, r0, r0
    16d0:	339c0100 	orrscc	r0, ip, #0, 2
    16d4:	20000007 	andcs	r0, r0, r7
    16d8:	000012b0 			; <UNDEFINED> instruction: 0x000012b0
    16dc:	f71ba501 			; <UNDEFINED> instruction: 0xf71ba501
    16e0:	03000001 	movweq	r0, #1
    16e4:	207fac91 			; <UNDEFINED> instruction: 0x207fac91
    16e8:	000010af 	andeq	r1, r0, pc, lsr #1
    16ec:	4d2aa501 	cfstr32mi	mvfx10, [sl, #-4]!
    16f0:	03000000 	movweq	r0, #0
    16f4:	1e7fa891 	mrcne	8, 3, sl, cr15, cr1, {4}
    16f8:	00001039 	andeq	r1, r0, r9, lsr r0
    16fc:	330aa701 	movwcc	sl, #42753	; 0xa701
    1700:	03000007 	movweq	r0, #7
    1704:	1e7fb491 	mrcne	4, 3, fp, cr15, cr1, {4}
    1708:	00000f4c 	andeq	r0, r0, ip, asr #30
    170c:	3809ab01 	stmdacc	r9, {r0, r8, r9, fp, sp, pc}
    1710:	02000000 	andeq	r0, r0, #0
    1714:	0f007491 	svceq	0x00007491
    1718:	00000025 	andeq	r0, r0, r5, lsr #32
    171c:	00000743 	andeq	r0, r0, r3, asr #14
    1720:	00005e10 	andeq	r5, r0, r0, lsl lr
    1724:	21003f00 	tstcs	r0, r0, lsl #30
    1728:	00001094 	muleq	r0, r4, r0
    172c:	440a9701 	strmi	r9, [sl], #-1793	; 0xfffff8ff
    1730:	4d000011 	stcmi	0, cr0, [r0, #-68]	; 0xffffffbc
    1734:	10000000 	andne	r0, r0, r0
    1738:	3c000090 	stccc	0, cr0, [r0], {144}	; 0x90
    173c:	01000000 	mrseq	r0, (UNDEF: 0)
    1740:	0007809c 	muleq	r7, ip, r0
    1744:	65722200 	ldrbvs	r2, [r2, #-512]!	; 0xfffffe00
    1748:	99010071 	stmdbls	r1, {r0, r4, r5, r6}
    174c:	0003ab20 	andeq	sl, r3, r0, lsr #22
    1750:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    1754:	0010451e 	andseq	r4, r0, lr, lsl r5
    1758:	0e9a0100 	fmleqe	f0, f2, f0
    175c:	0000004d 	andeq	r0, r0, sp, asr #32
    1760:	00709102 	rsbseq	r9, r0, r2, lsl #2
    1764:	0010b823 	andseq	fp, r0, r3, lsr #16
    1768:	068e0100 	streq	r0, [lr], r0, lsl #2
    176c:	00000f6d 	andeq	r0, r0, sp, ror #30
    1770:	00008fd4 	ldrdeq	r8, [r0], -r4
    1774:	0000003c 	andeq	r0, r0, ip, lsr r0
    1778:	07b99c01 	ldreq	r9, [r9, r1, lsl #24]!
    177c:	af200000 	svcge	0x00200000
    1780:	0100000f 	tsteq	r0, pc
    1784:	004d218e 	subeq	r2, sp, lr, lsl #3
    1788:	91020000 	mrsls	r0, (UNDEF: 2)
    178c:	6572226c 	ldrbvs	r2, [r2, #-620]!	; 0xfffffd94
    1790:	90010071 	andls	r0, r1, r1, ror r0
    1794:	0003ab20 	andeq	sl, r3, r0, lsr #22
    1798:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    179c:	10712100 	rsbsne	r2, r1, r0, lsl #2
    17a0:	82010000 	andhi	r0, r1, #0
    17a4:	000ff20a 	andeq	pc, pc, sl, lsl #4
    17a8:	00004d00 	andeq	r4, r0, r0, lsl #26
    17ac:	008f9800 	addeq	r9, pc, r0, lsl #16
    17b0:	00003c00 	andeq	r3, r0, r0, lsl #24
    17b4:	f69c0100 			; <UNDEFINED> instruction: 0xf69c0100
    17b8:	22000007 	andcs	r0, r0, #7
    17bc:	00716572 	rsbseq	r6, r1, r2, ror r5
    17c0:	87208401 	strhi	r8, [r0, -r1, lsl #8]!
    17c4:	02000003 	andeq	r0, r0, #3
    17c8:	451e7491 	ldrmi	r7, [lr, #-1169]	; 0xfffffb6f
    17cc:	0100000f 	tsteq	r0, pc
    17d0:	004d0e85 	subeq	r0, sp, r5, lsl #29
    17d4:	91020000 	mrsls	r0, (UNDEF: 2)
    17d8:	93210070 			; <UNDEFINED> instruction: 0x93210070
    17dc:	01000012 	tsteq	r0, r2, lsl r0
    17e0:	0fc30a76 	svceq	0x00c30a76
    17e4:	004d0000 	subeq	r0, sp, r0
    17e8:	8f5c0000 	svchi	0x005c0000
    17ec:	003c0000 	eorseq	r0, ip, r0
    17f0:	9c010000 	stcls	0, cr0, [r1], {-0}
    17f4:	00000833 	andeq	r0, r0, r3, lsr r8
    17f8:	71657222 	cmnvc	r5, r2, lsr #4
    17fc:	20780100 	rsbscs	r0, r8, r0, lsl #2
    1800:	00000387 	andeq	r0, r0, r7, lsl #7
    1804:	1e749102 	expnes	f1, f2
    1808:	00000f45 	andeq	r0, r0, r5, asr #30
    180c:	4d0e7901 	vstrmi.16	s14, [lr, #-2]	; <UNPREDICTABLE>
    1810:	02000000 	andeq	r0, r0, #0
    1814:	21007091 	swpcs	r7, r1, [r0]
    1818:	00001006 	andeq	r1, r0, r6
    181c:	26066a01 	strcs	r6, [r6], -r1, lsl #20
    1820:	f0000011 			; <UNDEFINED> instruction: 0xf0000011
    1824:	08000001 	stmdaeq	r0, {r0}
    1828:	5400008f 	strpl	r0, [r0], #-143	; 0xffffff71
    182c:	01000000 	mrseq	r0, (UNDEF: 0)
    1830:	00087f9c 	muleq	r8, ip, pc	; <UNPREDICTABLE>
    1834:	10452000 	subne	r2, r5, r0
    1838:	6a010000 	bvs	41840 <__bss_end+0x37ab4>
    183c:	00004d15 	andeq	r4, r0, r5, lsl sp
    1840:	6c910200 	lfmvs	f0, 4, [r1], {0}
    1844:	000ac320 	andeq	ip, sl, r0, lsr #6
    1848:	256a0100 	strbcs	r0, [sl, #-256]!	; 0xffffff00
    184c:	0000004d 	andeq	r0, r0, sp, asr #32
    1850:	1e689102 	lgnnee	f1, f2
    1854:	0000128b 	andeq	r1, r0, fp, lsl #5
    1858:	4d0e6c01 	stcmi	12, cr6, [lr, #-4]
    185c:	02000000 	andeq	r0, r0, #0
    1860:	21007491 			; <UNDEFINED> instruction: 0x21007491
    1864:	00000f84 	andeq	r0, r0, r4, lsl #31
    1868:	7b125d01 	blvc	498c74 <__bss_end+0x48eee8>
    186c:	8b000011 	blhi	18b8 <shift+0x18b8>
    1870:	b8000000 	stmdalt	r0, {}	; <UNPREDICTABLE>
    1874:	5000008e 	andpl	r0, r0, lr, lsl #1
    1878:	01000000 	mrseq	r0, (UNDEF: 0)
    187c:	0008da9c 	muleq	r8, ip, sl
    1880:	11312000 	teqne	r1, r0
    1884:	5d010000 	stcpl	0, cr0, [r1, #-0]
    1888:	00004d20 	andeq	r4, r0, r0, lsr #26
    188c:	6c910200 	lfmvs	f0, 4, [r1], {0}
    1890:	00107a20 	andseq	r7, r0, r0, lsr #20
    1894:	2f5d0100 	svccs	0x005d0100
    1898:	0000004d 	andeq	r0, r0, sp, asr #32
    189c:	20689102 	rsbcs	r9, r8, r2, lsl #2
    18a0:	00000ac3 	andeq	r0, r0, r3, asr #21
    18a4:	4d3f5d01 	ldcmi	13, cr5, [pc, #-4]!	; 18a8 <shift+0x18a8>
    18a8:	02000000 	andeq	r0, r0, #0
    18ac:	8b1e6491 	blhi	79aaf8 <__bss_end+0x790d6c>
    18b0:	01000012 	tsteq	r0, r2, lsl r0
    18b4:	008b165f 	addeq	r1, fp, pc, asr r6
    18b8:	91020000 	mrsls	r0, (UNDEF: 2)
    18bc:	b1210074 			; <UNDEFINED> instruction: 0xb1210074
    18c0:	01000011 	tsteq	r0, r1, lsl r0
    18c4:	0f890a51 	svceq	0x00890a51
    18c8:	004d0000 	subeq	r0, sp, r0
    18cc:	8e740000 	cdphi	0, 7, cr0, cr4, cr0, {0}
    18d0:	00440000 	subeq	r0, r4, r0
    18d4:	9c010000 	stcls	0, cr0, [r1], {-0}
    18d8:	00000926 	andeq	r0, r0, r6, lsr #18
    18dc:	00113120 	andseq	r3, r1, r0, lsr #2
    18e0:	1a510100 	bne	1441ce8 <__bss_end+0x1437f5c>
    18e4:	0000004d 	andeq	r0, r0, sp, asr #32
    18e8:	206c9102 	rsbcs	r9, ip, r2, lsl #2
    18ec:	0000107a 	andeq	r1, r0, sl, ror r0
    18f0:	4d295101 	stfmis	f5, [r9, #-4]!
    18f4:	02000000 	andeq	r0, r0, #0
    18f8:	aa1e6891 	bge	79bb44 <__bss_end+0x791db8>
    18fc:	01000011 	tsteq	r0, r1, lsl r0
    1900:	004d0e53 	subeq	r0, sp, r3, asr lr
    1904:	91020000 	mrsls	r0, (UNDEF: 2)
    1908:	a4210074 	strtge	r0, [r1], #-116	; 0xffffff8c
    190c:	01000011 	tsteq	r0, r1, lsl r0
    1910:	11860a44 	orrne	r0, r6, r4, asr #20
    1914:	004d0000 	subeq	r0, sp, r0
    1918:	8e240000 	cdphi	0, 2, cr0, cr4, cr0, {0}
    191c:	00500000 	subseq	r0, r0, r0
    1920:	9c010000 	stcls	0, cr0, [r1], {-0}
    1924:	00000981 	andeq	r0, r0, r1, lsl #19
    1928:	00113120 	andseq	r3, r1, r0, lsr #2
    192c:	19440100 	stmdbne	r4, {r8}^
    1930:	0000004d 	andeq	r0, r0, sp, asr #32
    1934:	206c9102 	rsbcs	r9, ip, r2, lsl #2
    1938:	0000101a 	andeq	r1, r0, sl, lsl r0
    193c:	1d304401 	cfldrsne	mvf4, [r0, #-4]!
    1940:	02000001 	andeq	r0, r0, #1
    1944:	80206891 	mlahi	r0, r1, r8, r6
    1948:	01000010 	tsteq	r0, r0, lsl r0
    194c:	06ac4144 	strteq	r4, [ip], r4, asr #2
    1950:	91020000 	mrsls	r0, (UNDEF: 2)
    1954:	128b1e64 	addne	r1, fp, #100, 28	; 0x640
    1958:	46010000 	strmi	r0, [r1], -r0
    195c:	00004d0e 	andeq	r4, r0, lr, lsl #26
    1960:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    1964:	0f322300 	svceq	0x00322300
    1968:	3e010000 	cdpcc	0, 0, cr0, cr1, cr0, {0}
    196c:	00102406 	andseq	r2, r0, r6, lsl #8
    1970:	008df800 	addeq	pc, sp, r0, lsl #16
    1974:	00002c00 	andeq	r2, r0, r0, lsl #24
    1978:	ab9c0100 	blge	fe701d80 <__bss_end+0xfe6f7ff4>
    197c:	20000009 	andcs	r0, r0, r9
    1980:	00001131 	andeq	r1, r0, r1, lsr r1
    1984:	4d153e01 	ldcmi	14, cr3, [r5, #-4]
    1988:	02000000 	andeq	r0, r0, #0
    198c:	21007491 			; <UNDEFINED> instruction: 0x21007491
    1990:	0000103f 	andeq	r1, r0, pc, lsr r0
    1994:	860a3101 	strhi	r3, [sl], -r1, lsl #2
    1998:	4d000010 	stcmi	0, cr0, [r0, #-64]	; 0xffffffc0
    199c:	a8000000 	stmdage	r0, {}	; <UNPREDICTABLE>
    19a0:	5000008d 	andpl	r0, r0, sp, lsl #1
    19a4:	01000000 	mrseq	r0, (UNDEF: 0)
    19a8:	000a069c 	muleq	sl, ip, r6
    19ac:	11312000 	teqne	r1, r0
    19b0:	31010000 	mrscc	r0, (UNDEF: 1)
    19b4:	00004d19 	andeq	r4, r0, r9, lsl sp
    19b8:	6c910200 	lfmvs	f0, 4, [r1], {0}
    19bc:	0011c720 	andseq	ip, r1, r0, lsr #14
    19c0:	2b310100 	blcs	c41dc8 <__bss_end+0xc3803c>
    19c4:	000001f7 	strdeq	r0, [r0], -r7
    19c8:	20689102 	rsbcs	r9, r8, r2, lsl #2
    19cc:	000010b3 	strheq	r1, [r0], -r3
    19d0:	4d3c3101 	ldfmis	f3, [ip, #-4]!
    19d4:	02000000 	andeq	r0, r0, #0
    19d8:	751e6491 	ldrvc	r6, [lr, #-1169]	; 0xfffffb6f
    19dc:	01000011 	tsteq	r0, r1, lsl r0
    19e0:	004d0e33 	subeq	r0, sp, r3, lsr lr
    19e4:	91020000 	mrsls	r0, (UNDEF: 2)
    19e8:	b5210074 	strlt	r0, [r1, #-116]!	; 0xffffff8c
    19ec:	01000012 	tsteq	r0, r2, lsl r0
    19f0:	11ce0a24 	bicne	r0, lr, r4, lsr #20
    19f4:	004d0000 	subeq	r0, sp, r0
    19f8:	8d580000 	ldclhi	0, cr0, [r8, #-0]
    19fc:	00500000 	subseq	r0, r0, r0
    1a00:	9c010000 	stcls	0, cr0, [r1], {-0}
    1a04:	00000a61 	andeq	r0, r0, r1, ror #20
    1a08:	00113120 	andseq	r3, r1, r0, lsr #2
    1a0c:	18240100 	stmdane	r4!, {r8}
    1a10:	0000004d 	andeq	r0, r0, sp, asr #32
    1a14:	206c9102 	rsbcs	r9, ip, r2, lsl #2
    1a18:	000011c7 	andeq	r1, r0, r7, asr #3
    1a1c:	672a2401 	strvs	r2, [sl, -r1, lsl #8]!
    1a20:	0200000a 	andeq	r0, r0, #10
    1a24:	b3206891 			; <UNDEFINED> instruction: 0xb3206891
    1a28:	01000010 	tsteq	r0, r0, lsl r0
    1a2c:	004d3b24 	subeq	r3, sp, r4, lsr #22
    1a30:	91020000 	mrsls	r0, (UNDEF: 2)
    1a34:	0f561e64 	svceq	0x00561e64
    1a38:	26010000 	strcs	r0, [r1], -r0
    1a3c:	00004d0e 	andeq	r4, r0, lr, lsl #26
    1a40:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    1a44:	25040d00 	strcs	r0, [r4, #-3328]	; 0xfffff300
    1a48:	03000000 	movweq	r0, #0
    1a4c:	00000a61 	andeq	r0, r0, r1, ror #20
    1a50:	00104b21 	andseq	r4, r0, r1, lsr #22
    1a54:	0a190100 	beq	641e5c <__bss_end+0x6380d0>
    1a58:	000012c1 	andeq	r1, r0, r1, asr #5
    1a5c:	0000004d 	andeq	r0, r0, sp, asr #32
    1a60:	00008d14 	andeq	r8, r0, r4, lsl sp
    1a64:	00000044 	andeq	r0, r0, r4, asr #32
    1a68:	0ab89c01 	beq	fee28a74 <__bss_end+0xfee1ece8>
    1a6c:	ac200000 	stcge	0, cr0, [r0], #-0
    1a70:	01000012 	tsteq	r0, r2, lsl r0
    1a74:	01f71b19 	mvnseq	r1, r9, lsl fp
    1a78:	91020000 	mrsls	r0, (UNDEF: 2)
    1a7c:	11c2206c 	bicne	r2, r2, ip, rrx
    1a80:	19010000 	stmdbne	r1, {}	; <UNPREDICTABLE>
    1a84:	0001c635 	andeq	ip, r1, r5, lsr r6
    1a88:	68910200 	ldmvs	r1, {r9}
    1a8c:	0011311e 	andseq	r3, r1, lr, lsl r1
    1a90:	0e1b0100 	mufeqe	f0, f3, f0
    1a94:	0000004d 	andeq	r0, r0, sp, asr #32
    1a98:	00749102 	rsbseq	r9, r4, r2, lsl #2
    1a9c:	000fa324 	andeq	sl, pc, r4, lsr #6
    1aa0:	06140100 	ldreq	r0, [r4], -r0, lsl #2
    1aa4:	00000f5c 	andeq	r0, r0, ip, asr pc
    1aa8:	00008cf8 	strdeq	r8, [r0], -r8	; <UNPREDICTABLE>
    1aac:	0000001c 	andeq	r0, r0, ip, lsl r0
    1ab0:	b8239c01 	stmdalt	r3!, {r0, sl, fp, ip, pc}
    1ab4:	01000011 	tsteq	r0, r1, lsl r0
    1ab8:	100c060e 	andne	r0, ip, lr, lsl #12
    1abc:	8ccc0000 	stclhi	0, cr0, [ip], {0}
    1ac0:	002c0000 	eoreq	r0, ip, r0
    1ac4:	9c010000 	stcls	0, cr0, [r1], {-0}
    1ac8:	00000af8 	strdeq	r0, [r0], -r8
    1acc:	000f9a20 	andeq	r9, pc, r0, lsr #20
    1ad0:	140e0100 	strne	r0, [lr], #-256	; 0xffffff00
    1ad4:	00000038 	andeq	r0, r0, r8, lsr r0
    1ad8:	00749102 	rsbseq	r9, r4, r2, lsl #2
    1adc:	0012ba25 	andseq	fp, r2, r5, lsr #20
    1ae0:	0a040100 	beq	101ee8 <__bss_end+0xf815c>
    1ae4:	0000102e 	andeq	r1, r0, lr, lsr #32
    1ae8:	0000004d 	andeq	r0, r0, sp, asr #32
    1aec:	00008ca0 	andeq	r8, r0, r0, lsr #25
    1af0:	0000002c 	andeq	r0, r0, ip, lsr #32
    1af4:	70229c01 	eorvc	r9, r2, r1, lsl #24
    1af8:	01006469 	tsteq	r0, r9, ror #8
    1afc:	004d0e06 	subeq	r0, sp, r6, lsl #28
    1b00:	91020000 	mrsls	r0, (UNDEF: 2)
    1b04:	7c000074 	stcvc	0, cr0, [r0], {116}	; 0x74
    1b08:	04000004 	streq	r0, [r0], #-4
    1b0c:	00072e00 	andeq	r2, r7, r0, lsl #28
    1b10:	da010400 	ble	42b18 <__bss_end+0x38d8c>
    1b14:	04000011 	streq	r0, [r0], #-17	; 0xffffffef
    1b18:	0000140b 	andeq	r1, r0, fp, lsl #8
    1b1c:	00000ee7 	andeq	r0, r0, r7, ror #29
    1b20:	000090fc 	strdeq	r9, [r0], -ip
    1b24:	000007c0 	andeq	r0, r0, r0, asr #15
    1b28:	00000a9f 	muleq	r0, pc, sl	; <UNPREDICTABLE>
    1b2c:	00004902 	andeq	r4, r0, r2, lsl #18
    1b30:	137c0300 	cmnne	ip, #0, 6
    1b34:	05010000 	streq	r0, [r1, #-0]
    1b38:	00006110 	andeq	r6, r0, r0, lsl r1
    1b3c:	31301100 	teqcc	r0, r0, lsl #2
    1b40:	35343332 	ldrcc	r3, [r4, #-818]!	; 0xfffffcce
    1b44:	39383736 	ldmdbcc	r8!, {r1, r2, r4, r5, r8, r9, sl, ip, sp}
    1b48:	44434241 	strbmi	r4, [r3], #-577	; 0xfffffdbf
    1b4c:	00004645 	andeq	r4, r0, r5, asr #12
    1b50:	01030104 	tsteq	r3, r4, lsl #2
    1b54:	00000025 	andeq	r0, r0, r5, lsr #32
    1b58:	00007405 	andeq	r7, r0, r5, lsl #8
    1b5c:	00006100 	andeq	r6, r0, r0, lsl #2
    1b60:	00660600 	rsbeq	r0, r6, r0, lsl #12
    1b64:	00100000 	andseq	r0, r0, r0
    1b68:	00005107 	andeq	r5, r0, r7, lsl #2
    1b6c:	07040800 	streq	r0, [r4, -r0, lsl #16]
    1b70:	00000c46 	andeq	r0, r0, r6, asr #24
    1b74:	05080108 	streq	r0, [r8, #-264]	; 0xfffffef8
    1b78:	0700000d 	streq	r0, [r0, -sp]
    1b7c:	0000006d 	andeq	r0, r0, sp, rrx
    1b80:	00002a09 	andeq	r2, r0, r9, lsl #20
    1b84:	13050a00 	movwne	r0, #23040	; 0x5a00
    1b88:	aa010000 	bge	41b90 <__bss_end+0x37e04>
    1b8c:	00136606 	andseq	r6, r3, r6, lsl #12
    1b90:	00984800 	addseq	r4, r8, r0, lsl #16
    1b94:	00007400 	andeq	r7, r0, r0, lsl #8
    1b98:	d19c0100 	orrsle	r0, ip, r0, lsl #2
    1b9c:	0b000000 	bleq	1ba4 <shift+0x1ba4>
    1ba0:	0000130c 	andeq	r1, r0, ip, lsl #6
    1ba4:	d113aa01 	tstle	r3, r1, lsl #20
    1ba8:	02000000 	andeq	r0, r0, #0
    1bac:	730c6c91 	movwvc	r6, #52369	; 0xcc91
    1bb0:	01006372 	tsteq	r0, r2, ror r3
    1bb4:	00d725aa 	sbcseq	r2, r7, sl, lsr #11
    1bb8:	91020000 	mrsls	r0, (UNDEF: 2)
    1bbc:	00690d68 	rsbeq	r0, r9, r8, ror #26
    1bc0:	dd06ab01 	vstrle	d10, [r6, #-4]
    1bc4:	02000000 	andeq	r0, r0, #0
    1bc8:	6a0d7491 	bvs	35ee14 <__bss_end+0x355088>
    1bcc:	06ac0100 	strteq	r0, [ip], r0, lsl #2
    1bd0:	000000dd 	ldrdeq	r0, [r0], -sp
    1bd4:	00709102 	rsbseq	r9, r0, r2, lsl #2
    1bd8:	006d040e 	rsbeq	r0, sp, lr, lsl #8
    1bdc:	040e0000 	streq	r0, [lr], #-0
    1be0:	00000074 	andeq	r0, r0, r4, ror r0
    1be4:	6905040f 	stmdbvs	r5, {r0, r1, r2, r3, sl}
    1be8:	1000746e 	andne	r7, r0, lr, ror #8
    1bec:	0000139a 	muleq	r0, sl, r3
    1bf0:	dd06a101 	stfled	f2, [r6, #-4]
    1bf4:	c8000012 	stmdagt	r0, {r1, r4}
    1bf8:	80000097 	mulhi	r0, r7, r0
    1bfc:	01000000 	mrseq	r0, (UNDEF: 0)
    1c00:	0001619c 	muleq	r1, ip, r1
    1c04:	72730c00 	rsbsvc	r0, r3, #0, 24
    1c08:	a1010063 	tstge	r1, r3, rrx
    1c0c:	00016119 	andeq	r6, r1, r9, lsl r1
    1c10:	64910200 	ldrvs	r0, [r1], #512	; 0x200
    1c14:	7473640c 	ldrbtvc	r6, [r3], #-1036	; 0xfffffbf4
    1c18:	24a10100 	strtcs	r0, [r1], #256	; 0x100
    1c1c:	00000168 	andeq	r0, r0, r8, ror #2
    1c20:	0c609102 	stfeqp	f1, [r0], #-8
    1c24:	006d756e 	rsbeq	r7, sp, lr, ror #10
    1c28:	dd2da101 	stfled	f2, [sp, #-4]!
    1c2c:	02000000 	andeq	r0, r0, #0
    1c30:	8d115c91 	ldchi	12, cr5, [r1, #-580]	; 0xfffffdbc
    1c34:	01000013 	tsteq	r0, r3, lsl r0
    1c38:	00d70ea3 	sbcseq	r0, r7, r3, lsr #29
    1c3c:	91020000 	mrsls	r0, (UNDEF: 2)
    1c40:	13751170 	cmnne	r5, #112, 2
    1c44:	a4010000 	strge	r0, [r1], #-0
    1c48:	0000d108 	andeq	sp, r0, r8, lsl #2
    1c4c:	6c910200 	lfmvs	f0, 4, [r1], {0}
    1c50:	0097f012 	addseq	pc, r7, r2, lsl r0	; <UNPREDICTABLE>
    1c54:	00004800 	andeq	r4, r0, r0, lsl #16
    1c58:	00690d00 	rsbeq	r0, r9, r0, lsl #26
    1c5c:	dd0ba601 	stcle	6, cr10, [fp, #-4]
    1c60:	02000000 	andeq	r0, r0, #0
    1c64:	00007491 	muleq	r0, r1, r4
    1c68:	0167040e 	cmneq	r7, lr, lsl #8
    1c6c:	14130000 	ldrne	r0, [r3], #-0
    1c70:	13941004 	orrsne	r1, r4, #4
    1c74:	99010000 	stmdbls	r1, {}	; <UNPREDICTABLE>
    1c78:	00132906 	andseq	r2, r3, r6, lsl #18
    1c7c:	00976000 	addseq	r6, r7, r0
    1c80:	00006800 	andeq	r6, r0, r0, lsl #16
    1c84:	c99c0100 	ldmibgt	ip, {r8}
    1c88:	0b000001 	bleq	1c94 <shift+0x1c94>
    1c8c:	000013fd 	strdeq	r1, [r0], -sp
    1c90:	68129901 	ldmdavs	r2, {r0, r8, fp, ip, pc}
    1c94:	02000001 	andeq	r0, r0, #1
    1c98:	040b6c91 	streq	r6, [fp], #-3217	; 0xfffff36f
    1c9c:	01000014 	tsteq	r0, r4, lsl r0
    1ca0:	00dd1e99 	smullseq	r1, sp, r9, lr
    1ca4:	91020000 	mrsls	r0, (UNDEF: 2)
    1ca8:	656d0d68 	strbvs	r0, [sp, #-3432]!	; 0xfffff298
    1cac:	9b01006d 	blls	41e68 <__bss_end+0x380dc>
    1cb0:	0000d108 	andeq	sp, r0, r8, lsl #2
    1cb4:	70910200 	addsvc	r0, r1, r0, lsl #4
    1cb8:	00977c12 	addseq	r7, r7, r2, lsl ip
    1cbc:	00003c00 	andeq	r3, r0, r0, lsl #24
    1cc0:	00690d00 	rsbeq	r0, r9, r0, lsl #26
    1cc4:	dd0b9d01 	stcle	13, cr9, [fp, #-4]
    1cc8:	02000000 	andeq	r0, r0, #0
    1ccc:	00007491 	muleq	r0, r1, r4
    1cd0:	0012fe15 	andseq	pc, r2, r5, lsl lr	; <UNPREDICTABLE>
    1cd4:	058f0100 	streq	r0, [pc, #256]	; 1ddc <shift+0x1ddc>
    1cd8:	000013d6 	ldrdeq	r1, [r0], -r6
    1cdc:	000000dd 	ldrdeq	r0, [r0], -sp
    1ce0:	0000970c 	andeq	r9, r0, ip, lsl #14
    1ce4:	00000054 	andeq	r0, r0, r4, asr r0
    1ce8:	02029c01 	andeq	r9, r2, #256	; 0x100
    1cec:	730c0000 	movwvc	r0, #49152	; 0xc000
    1cf0:	188f0100 	stmne	pc, {r8}	; <UNPREDICTABLE>
    1cf4:	000000d7 	ldrdeq	r0, [r0], -r7
    1cf8:	0d6c9102 	stfeqp	f1, [ip, #-8]!
    1cfc:	91010069 	tstls	r1, r9, rrx
    1d00:	0000dd06 	andeq	sp, r0, r6, lsl #26
    1d04:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    1d08:	13a11500 			; <UNDEFINED> instruction: 0x13a11500
    1d0c:	7f010000 	svcvc	0x00010000
    1d10:	0013e305 	andseq	lr, r3, r5, lsl #6
    1d14:	0000dd00 	andeq	sp, r0, r0, lsl #26
    1d18:	00966000 	addseq	r6, r6, r0
    1d1c:	0000ac00 	andeq	sl, r0, r0, lsl #24
    1d20:	689c0100 	ldmvs	ip, {r8}
    1d24:	0c000002 	stceq	0, cr0, [r0], {2}
    1d28:	01003173 	tsteq	r0, r3, ror r1
    1d2c:	00d7197f 	sbcseq	r1, r7, pc, ror r9
    1d30:	91020000 	mrsls	r0, (UNDEF: 2)
    1d34:	32730c6c 	rsbscc	r0, r3, #108, 24	; 0x6c00
    1d38:	297f0100 	ldmdbcs	pc!, {r8}^	; <UNPREDICTABLE>
    1d3c:	000000d7 	ldrdeq	r0, [r0], -r7
    1d40:	0c689102 	stfeqp	f1, [r8], #-8
    1d44:	006d756e 	rsbeq	r7, sp, lr, ror #10
    1d48:	dd317f01 	ldcle	15, cr7, [r1, #-4]!
    1d4c:	02000000 	andeq	r0, r0, #0
    1d50:	750d6491 	strvc	r6, [sp, #-1169]	; 0xfffffb6f
    1d54:	81010031 	tsthi	r1, r1, lsr r0
    1d58:	00026810 	andeq	r6, r2, r0, lsl r8
    1d5c:	77910200 	ldrvc	r0, [r1, r0, lsl #4]
    1d60:	0032750d 	eorseq	r7, r2, sp, lsl #10
    1d64:	68148101 	ldmdavs	r4, {r0, r8, pc}
    1d68:	02000002 	andeq	r0, r0, #2
    1d6c:	08007691 	stmdaeq	r0, {r0, r4, r7, r9, sl, ip, sp, lr}
    1d70:	0cfc0801 	ldcleq	8, cr0, [ip], #4
    1d74:	35150000 	ldrcc	r0, [r5, #-0]
    1d78:	01000013 	tsteq	r0, r3, lsl r0
    1d7c:	133d0773 	teqne	sp, #30146560	; 0x1cc0000
    1d80:	00d10000 	sbcseq	r0, r1, r0
    1d84:	95a00000 	strls	r0, [r0, #0]!
    1d88:	00c00000 	sbceq	r0, r0, r0
    1d8c:	9c010000 	stcls	0, cr0, [r1], {-0}
    1d90:	000002c8 	andeq	r0, r0, r8, asr #5
    1d94:	00130c0b 	andseq	r0, r3, fp, lsl #24
    1d98:	15730100 	ldrbne	r0, [r3, #-256]!	; 0xffffff00
    1d9c:	000000d1 	ldrdeq	r0, [r0], -r1
    1da0:	0c6c9102 	stfeqp	f1, [ip], #-8
    1da4:	00637273 	rsbeq	r7, r3, r3, ror r2
    1da8:	d7277301 	strle	r7, [r7, -r1, lsl #6]!
    1dac:	02000000 	andeq	r0, r0, #0
    1db0:	6e0c6891 	mcrvs	8, 0, r6, cr12, cr1, {4}
    1db4:	01006d75 	tsteq	r0, r5, ror sp
    1db8:	00dd3073 	sbcseq	r3, sp, r3, ror r0
    1dbc:	91020000 	mrsls	r0, (UNDEF: 2)
    1dc0:	00690d64 	rsbeq	r0, r9, r4, ror #26
    1dc4:	dd067501 	cfstr32le	mvfx7, [r6, #-4]
    1dc8:	02000000 	andeq	r0, r0, #0
    1dcc:	15007491 	strne	r7, [r0, #-1169]	; 0xfffffb6f
    1dd0:	00001388 	andeq	r1, r0, r8, lsl #7
    1dd4:	ca073601 	bgt	1cf5e0 <__bss_end+0x1c5854>
    1dd8:	d1000013 	tstle	r0, r3, lsl r0
    1ddc:	0c000000 	stceq	0, cr0, [r0], {-0}
    1de0:	94000093 	strls	r0, [r0], #-147	; 0xffffff6d
    1de4:	01000002 	tsteq	r0, r2
    1de8:	0003ac9c 	muleq	r3, ip, ip
    1dec:	13110b00 	tstne	r1, #0, 22
    1df0:	36010000 	strcc	r0, [r1], -r0
    1df4:	0003ac12 	andeq	sl, r3, r2, lsl ip
    1df8:	4c910200 	lfmmi	f0, 4, [r1], {0}
    1dfc:	0013c30b 	andseq	ip, r3, fp, lsl #6
    1e00:	1f360100 	svcne	0x00360100
    1e04:	000000d1 	ldrdeq	r0, [r0], -r1
    1e08:	0b489102 	bleq	1226218 <__bss_end+0x121c48c>
    1e0c:	000013a9 	andeq	r1, r0, r9, lsr #7
    1e10:	66343601 	ldrtvs	r3, [r4], -r1, lsl #12
    1e14:	02000000 	andeq	r0, r0, #0
    1e18:	700d4491 	mulvc	sp, r1, r4
    1e1c:	01007274 	tsteq	r0, r4, ror r2
    1e20:	00d10838 	sbcseq	r0, r1, r8, lsr r8
    1e24:	91020000 	mrsls	r0, (UNDEF: 2)
    1e28:	134e1174 	movtne	r1, #57716	; 0xe174
    1e2c:	41010000 	mrsmi	r0, (UNDEF: 1)
    1e30:	0000dd09 	andeq	sp, r0, r9, lsl #26
    1e34:	70910200 	addsvc	r0, r1, r0, lsl #4
    1e38:	00135711 	andseq	r5, r3, r1, lsl r7
    1e3c:	0b420100 	bleq	1082244 <__bss_end+0x10784b8>
    1e40:	000003ac 	andeq	r0, r0, ip, lsr #7
    1e44:	116c9102 	cmnne	ip, r2, lsl #2
    1e48:	000013f5 	strdeq	r1, [r0], -r5
    1e4c:	b30a4501 	movwlt	r4, #42241	; 0xa501
    1e50:	02000003 	andeq	r0, r0, #3
    1e54:	21115091 			; <UNDEFINED> instruction: 0x21115091
    1e58:	01000013 	tsteq	r0, r3, lsl r0
    1e5c:	00d10b46 	sbcseq	r0, r1, r6, asr #22
    1e60:	91020000 	mrsls	r0, (UNDEF: 2)
    1e64:	947c1668 	ldrbtls	r1, [ip], #-1640	; 0xfffff998
    1e68:	00800000 	addeq	r0, r0, r0
    1e6c:	03920000 	orrseq	r0, r2, #0
    1e70:	690d0000 	stmdbvs	sp, {}	; <UNPREDICTABLE>
    1e74:	0e5b0100 	rdfeqe	f0, f3, f0
    1e78:	000000dd 	ldrdeq	r0, [r0], -sp
    1e7c:	12649102 	rsbne	r9, r4, #-2147483648	; 0x80000000
    1e80:	00009494 	muleq	r0, r4, r4
    1e84:	00000058 	andeq	r0, r0, r8, asr r0
    1e88:	00136011 	andseq	r6, r3, r1, lsl r0
    1e8c:	0d5d0100 	ldfeqe	f0, [sp, #-0]
    1e90:	000000dd 	ldrdeq	r0, [r0], -sp
    1e94:	005c9102 	subseq	r9, ip, r2, lsl #2
    1e98:	95141200 	ldrls	r1, [r4, #-512]	; 0xfffffe00
    1e9c:	00700000 	rsbseq	r0, r0, r0
    1ea0:	650d0000 	strvs	r0, [sp, #-0]
    1ea4:	0100646e 	tsteq	r0, lr, ror #8
    1ea8:	00d10f67 	sbcseq	r0, r1, r7, ror #30
    1eac:	91020000 	mrsls	r0, (UNDEF: 2)
    1eb0:	08000060 	stmdaeq	r0, {r5, r6}
    1eb4:	06940404 	ldreq	r0, [r4], r4, lsl #8
    1eb8:	6d050000 	stcvs	0, cr0, [r5, #-0]
    1ebc:	c3000000 	movwgt	r0, #0
    1ec0:	06000003 	streq	r0, [r0], -r3
    1ec4:	00000066 	andeq	r0, r0, r6, rrx
    1ec8:	f915000b 			; <UNDEFINED> instruction: 0xf915000b
    1ecc:	01000012 	tsteq	r0, r2, lsl r0
    1ed0:	13b80524 			; <UNDEFINED> instruction: 0x13b80524
    1ed4:	00dd0000 	sbcseq	r0, sp, r0
    1ed8:	92700000 	rsbsls	r0, r0, #0
    1edc:	009c0000 	addseq	r0, ip, r0
    1ee0:	9c010000 	stcls	0, cr0, [r1], {-0}
    1ee4:	00000400 	andeq	r0, r0, r0, lsl #8
    1ee8:	0013110b 	andseq	r1, r3, fp, lsl #2
    1eec:	16240100 	strtne	r0, [r4], -r0, lsl #2
    1ef0:	000000d7 	ldrdeq	r0, [r0], -r7
    1ef4:	116c9102 	cmnne	ip, r2, lsl #2
    1ef8:	000013c3 	andeq	r1, r0, r3, asr #7
    1efc:	dd062601 	stcle	6, cr2, [r6, #-4]
    1f00:	02000000 	andeq	r0, r0, #0
    1f04:	17007491 			; <UNDEFINED> instruction: 0x17007491
    1f08:	0000131c 	andeq	r1, r0, ip, lsl r3
    1f0c:	ed060801 	stc	8, cr0, [r6, #-4]
    1f10:	fc000012 	stc2	0, cr0, [r0], {18}
    1f14:	74000090 	strvc	r0, [r0], #-144	; 0xffffff70
    1f18:	01000001 	tsteq	r0, r1
    1f1c:	13110b9c 	tstne	r1, #156, 22	; 0x27000
    1f20:	08010000 	stmdaeq	r1, {}	; <UNPREDICTABLE>
    1f24:	00006618 	andeq	r6, r0, r8, lsl r6
    1f28:	64910200 	ldrvs	r0, [r1], #512	; 0x200
    1f2c:	0013c30b 	andseq	ip, r3, fp, lsl #6
    1f30:	25080100 	strcs	r0, [r8, #-256]	; 0xffffff00
    1f34:	000000d1 	ldrdeq	r0, [r0], -r1
    1f38:	0b609102 	bleq	1826348 <__bss_end+0x181c5bc>
    1f3c:	00001317 	andeq	r1, r0, r7, lsl r3
    1f40:	663a0801 	ldrtvs	r0, [sl], -r1, lsl #16
    1f44:	02000000 	andeq	r0, r0, #0
    1f48:	690d5c91 	stmdbvs	sp, {r0, r4, r7, sl, fp, ip, lr}
    1f4c:	060a0100 	streq	r0, [sl], -r0, lsl #2
    1f50:	000000dd 	ldrdeq	r0, [r0], -sp
    1f54:	12749102 	rsbsne	r9, r4, #-2147483648	; 0x80000000
    1f58:	000091c8 	andeq	r9, r0, r8, asr #3
    1f5c:	00000098 	muleq	r0, r8, r0
    1f60:	01006a0d 	tsteq	r0, sp, lsl #20
    1f64:	00dd0b1c 	sbcseq	r0, sp, ip, lsl fp
    1f68:	91020000 	mrsls	r0, (UNDEF: 2)
    1f6c:	91f01270 	mvnsls	r1, r0, ror r2
    1f70:	00600000 	rsbeq	r0, r0, r0
    1f74:	630d0000 	movwvs	r0, #53248	; 0xd000
    1f78:	081e0100 	ldmdaeq	lr, {r8}
    1f7c:	0000006d 	andeq	r0, r0, sp, rrx
    1f80:	006f9102 	rsbeq	r9, pc, r2, lsl #2
    1f84:	Address 0x0000000000001f84 is out of bounds.


Disassembly of section .debug_abbrev:

00000000 <.debug_abbrev>:
   0:	10001101 	andne	r1, r0, r1, lsl #2
   4:	12011106 	andne	r1, r1, #-2147483647	; 0x80000001
   8:	1b0e0301 	blne	380c14 <__bss_end+0x376e88>
   c:	130e250e 	movwne	r2, #58638	; 0xe50e
  10:	00000005 	andeq	r0, r0, r5
  14:	25011101 	strcs	r1, [r1, #-257]	; 0xfffffeff
  18:	030b130e 	movweq	r1, #45838	; 0xb30e
  1c:	110e1b0e 	tstne	lr, lr, lsl #22
  20:	10061201 	andne	r1, r6, r1, lsl #4
  24:	02000017 	andeq	r0, r0, #23
  28:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
  2c:	0b3b0b3a 	bleq	ec2d1c <__bss_end+0xeb8f90>
  30:	13490b39 	movtne	r0, #39737	; 0x9b39
  34:	193c193f 	ldmdbne	ip!, {r0, r1, r2, r3, r4, r5, r8, fp, ip}
  38:	24030000 	strcs	r0, [r3], #-0
  3c:	3e0b0b00 	vmlacc.f64	d0, d11, d0
  40:	000e030b 	andeq	r0, lr, fp, lsl #6
  44:	012e0400 			; <UNDEFINED> instruction: 0x012e0400
  48:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
  4c:	0b3b0b3a 	bleq	ec2d3c <__bss_end+0xeb8fb0>
  50:	01110b39 	tsteq	r1, r9, lsr fp
  54:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
  58:	01194296 			; <UNDEFINED> instruction: 0x01194296
  5c:	05000013 	streq	r0, [r0, #-19]	; 0xffffffed
  60:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
  64:	0b3b0b3a 	bleq	ec2d54 <__bss_end+0xeb8fc8>
  68:	13490b39 	movtne	r0, #39737	; 0x9b39
  6c:	00001802 	andeq	r1, r0, r2, lsl #16
  70:	0b002406 	bleq	9090 <_Z4pipePKcj+0x44>
  74:	030b3e0b 	movweq	r3, #48651	; 0xbe0b
  78:	07000008 	streq	r0, [r0, -r8]
  7c:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
  80:	0b3a0e03 	bleq	e83894 <__bss_end+0xe79b08>
  84:	0b390b3b 	bleq	e42d78 <__bss_end+0xe38fec>
  88:	06120111 			; <UNDEFINED> instruction: 0x06120111
  8c:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
  90:	00130119 	andseq	r0, r3, r9, lsl r1
  94:	010b0800 	tsteq	fp, r0, lsl #16
  98:	06120111 			; <UNDEFINED> instruction: 0x06120111
  9c:	34090000 	strcc	r0, [r9], #-0
  a0:	3a080300 	bcc	200ca8 <__bss_end+0x1f6f1c>
  a4:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
  a8:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
  ac:	0a000018 	beq	114 <shift+0x114>
  b0:	0b0b000f 	bleq	2c00f4 <__bss_end+0x2b6368>
  b4:	00001349 	andeq	r1, r0, r9, asr #6
  b8:	01110100 	tsteq	r1, r0, lsl #2
  bc:	0b130e25 	bleq	4c3958 <__bss_end+0x4b9bcc>
  c0:	0e1b0e03 	cdpeq	14, 1, cr0, cr11, cr3, {0}
  c4:	06120111 			; <UNDEFINED> instruction: 0x06120111
  c8:	00001710 	andeq	r1, r0, r0, lsl r7
  cc:	03001602 	movweq	r1, #1538	; 0x602
  d0:	3b0b3a0e 	blcc	2ce910 <__bss_end+0x2c4b84>
  d4:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
  d8:	03000013 	movweq	r0, #19
  dc:	0b0b000f 	bleq	2c0120 <__bss_end+0x2b6394>
  e0:	00001349 	andeq	r1, r0, r9, asr #6
  e4:	00001504 	andeq	r1, r0, r4, lsl #10
  e8:	01010500 	tsteq	r1, r0, lsl #10
  ec:	13011349 	movwne	r1, #4937	; 0x1349
  f0:	21060000 	mrscs	r0, (UNDEF: 6)
  f4:	2f134900 	svccs	0x00134900
  f8:	07000006 	streq	r0, [r0, -r6]
  fc:	0b0b0024 	bleq	2c0194 <__bss_end+0x2b6408>
 100:	0e030b3e 	vmoveq.16	d3[0], r0
 104:	34080000 	strcc	r0, [r8], #-0
 108:	3a0e0300 	bcc	380d10 <__bss_end+0x376f84>
 10c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 110:	3f13490b 	svccc	0x0013490b
 114:	00193c19 	andseq	r3, r9, r9, lsl ip
 118:	012e0900 			; <UNDEFINED> instruction: 0x012e0900
 11c:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 120:	0b3b0b3a 	bleq	ec2e10 <__bss_end+0xeb9084>
 124:	13490b39 	movtne	r0, #39737	; 0x9b39
 128:	06120111 			; <UNDEFINED> instruction: 0x06120111
 12c:	42961840 	addsmi	r1, r6, #64, 16	; 0x400000
 130:	00130119 	andseq	r0, r3, r9, lsl r1
 134:	00340a00 	eorseq	r0, r4, r0, lsl #20
 138:	0b3a0e03 	bleq	e8394c <__bss_end+0xe79bc0>
 13c:	0b390b3b 	bleq	e42e30 <__bss_end+0xe390a4>
 140:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 144:	240b0000 	strcs	r0, [fp], #-0
 148:	3e0b0b00 	vmlacc.f64	d0, d11, d0
 14c:	0008030b 	andeq	r0, r8, fp, lsl #6
 150:	002e0c00 	eoreq	r0, lr, r0, lsl #24
 154:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 158:	0b3b0b3a 	bleq	ec2e48 <__bss_end+0xeb90bc>
 15c:	01110b39 	tsteq	r1, r9, lsr fp
 160:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 164:	00194297 	mulseq	r9, r7, r2
 168:	01390d00 	teqeq	r9, r0, lsl #26
 16c:	0b3a0e03 	bleq	e83980 <__bss_end+0xe79bf4>
 170:	13010b3b 	movwne	r0, #6971	; 0x1b3b
 174:	2e0e0000 	cdpcs	0, 0, cr0, cr14, cr0, {0}
 178:	03193f01 	tsteq	r9, #1, 30
 17c:	3b0b3a0e 	blcc	2ce9bc <__bss_end+0x2c4c30>
 180:	3c0b390b 			; <UNDEFINED> instruction: 0x3c0b390b
 184:	00130119 	andseq	r0, r3, r9, lsl r1
 188:	00050f00 	andeq	r0, r5, r0, lsl #30
 18c:	00001349 	andeq	r1, r0, r9, asr #6
 190:	3f012e10 	svccc	0x00012e10
 194:	3a0e0319 	bcc	380e00 <__bss_end+0x377074>
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
 1c0:	3a080300 	bcc	200dc8 <__bss_end+0x1f703c>
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
 1f4:	0b0b0024 	bleq	2c028c <__bss_end+0x2b6500>
 1f8:	0e030b3e 	vmoveq.16	d3[0], r0
 1fc:	26030000 	strcs	r0, [r3], -r0
 200:	00134900 	andseq	r4, r3, r0, lsl #18
 204:	00240400 	eoreq	r0, r4, r0, lsl #8
 208:	0b3e0b0b 	bleq	f82e3c <__bss_end+0xf790b0>
 20c:	00000803 	andeq	r0, r0, r3, lsl #16
 210:	03001605 	movweq	r1, #1541	; 0x605
 214:	3b0b3a0e 	blcc	2cea54 <__bss_end+0x2c4cc8>
 218:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 21c:	06000013 			; <UNDEFINED> instruction: 0x06000013
 220:	0e030113 	mcreq	1, 0, r0, cr3, cr3, {0}
 224:	0b3a0b0b 	bleq	e82e58 <__bss_end+0xe790cc>
 228:	0b390b3b 	bleq	e42f1c <__bss_end+0xe39190>
 22c:	00001301 	andeq	r1, r0, r1, lsl #6
 230:	03000d07 	movweq	r0, #3335	; 0xd07
 234:	3b0b3a08 	blcc	2cea5c <__bss_end+0x2c4cd0>
 238:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 23c:	000b3813 	andeq	r3, fp, r3, lsl r8
 240:	01040800 	tsteq	r4, r0, lsl #16
 244:	196d0e03 	stmdbne	sp!, {r0, r1, r9, sl, fp}^
 248:	0b0b0b3e 	bleq	2c2f48 <__bss_end+0x2b91bc>
 24c:	0b3a1349 	bleq	e84f78 <__bss_end+0xe7b1ec>
 250:	0b390b3b 	bleq	e42f44 <__bss_end+0xe391b8>
 254:	00001301 	andeq	r1, r0, r1, lsl #6
 258:	03002809 	movweq	r2, #2057	; 0x809
 25c:	000b1c0e 	andeq	r1, fp, lr, lsl #24
 260:	00340a00 	eorseq	r0, r4, r0, lsl #20
 264:	0b3a0e03 	bleq	e83a78 <__bss_end+0xe79cec>
 268:	0b390b3b 	bleq	e42f5c <__bss_end+0xe391d0>
 26c:	196c1349 	stmdbne	ip!, {r0, r3, r6, r8, r9, ip}^
 270:	00001802 	andeq	r1, r0, r2, lsl #16
 274:	0300020b 	movweq	r0, #523	; 0x20b
 278:	00193c0e 	andseq	r3, r9, lr, lsl #24
 27c:	01010c00 	tsteq	r1, r0, lsl #24
 280:	13011349 	movwne	r1, #4937	; 0x1349
 284:	210d0000 	mrscs	r0, (UNDEF: 13)
 288:	2f134900 	svccs	0x00134900
 28c:	0e00000b 	cdpeq	0, 0, cr0, cr0, cr11, {0}
 290:	0b0b000f 	bleq	2c02d4 <__bss_end+0x2b6548>
 294:	00001349 	andeq	r1, r0, r9, asr #6
 298:	0300280f 	movweq	r2, #2063	; 0x80f
 29c:	000b1c08 	andeq	r1, fp, r8, lsl #24
 2a0:	000d1000 	andeq	r1, sp, r0
 2a4:	0b3a0e03 	bleq	e83ab8 <__bss_end+0xe79d2c>
 2a8:	0b390b3b 	bleq	e42f9c <__bss_end+0xe39210>
 2ac:	0b381349 	bleq	e04fd8 <__bss_end+0xdfb24c>
 2b0:	02110000 	andseq	r0, r1, #0
 2b4:	0b0e0301 	bleq	380ec0 <__bss_end+0x377134>
 2b8:	3b0b3a0b 	blcc	2ceaec <__bss_end+0x2c4d60>
 2bc:	010b390b 	tsteq	fp, fp, lsl #18
 2c0:	12000013 	andne	r0, r0, #19
 2c4:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 2c8:	0b3a0e03 	bleq	e83adc <__bss_end+0xe79d50>
 2cc:	0b390b3b 	bleq	e42fc0 <__bss_end+0xe39234>
 2d0:	193c0e6e 	ldmdbne	ip!, {r1, r2, r3, r5, r6, r9, sl, fp}
 2d4:	13011364 	movwne	r1, #4964	; 0x1364
 2d8:	05130000 	ldreq	r0, [r3, #-0]
 2dc:	34134900 	ldrcc	r4, [r3], #-2304	; 0xfffff700
 2e0:	14000019 	strne	r0, [r0], #-25	; 0xffffffe7
 2e4:	13490005 	movtne	r0, #36869	; 0x9005
 2e8:	2e150000 	cdpcs	0, 1, cr0, cr5, cr0, {0}
 2ec:	03193f01 	tsteq	r9, #1, 30
 2f0:	3b0b3a0e 	blcc	2ceb30 <__bss_end+0x2c4da4>
 2f4:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 2f8:	3c13490e 			; <UNDEFINED> instruction: 0x3c13490e
 2fc:	01136419 	tsteq	r3, r9, lsl r4
 300:	16000013 			; <UNDEFINED> instruction: 0x16000013
 304:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 308:	0b3a0e03 	bleq	e83b1c <__bss_end+0xe79d90>
 30c:	0b390b3b 	bleq	e43000 <__bss_end+0xe39274>
 310:	13490e6e 	movtne	r0, #40558	; 0x9e6e
 314:	193c0b32 	ldmdbne	ip!, {r1, r4, r5, r8, r9, fp}
 318:	13011364 	movwne	r1, #4964	; 0x1364
 31c:	0d170000 	ldceq	0, cr0, [r7, #-0]
 320:	3a0e0300 	bcc	380f28 <__bss_end+0x37719c>
 324:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 328:	3813490b 	ldmdacc	r3, {r0, r1, r3, r8, fp, lr}
 32c:	000b320b 	andeq	r3, fp, fp, lsl #4
 330:	012e1800 			; <UNDEFINED> instruction: 0x012e1800
 334:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 338:	0b3b0b3a 	bleq	ec3028 <__bss_end+0xeb929c>
 33c:	0e6e0b39 	vmoveq.8	d14[5], r0
 340:	193c0b32 	ldmdbne	ip!, {r1, r4, r5, r8, r9, fp}
 344:	13011364 	movwne	r1, #4964	; 0x1364
 348:	2e190000 	cdpcs	0, 1, cr0, cr9, cr0, {0}
 34c:	03193f01 	tsteq	r9, #1, 30
 350:	3b0b3a0e 	blcc	2ceb90 <__bss_end+0x2c4e04>
 354:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 358:	3213490e 	andscc	r4, r3, #229376	; 0x38000
 35c:	64193c0b 	ldrvs	r3, [r9], #-3083	; 0xfffff3f5
 360:	1a000013 	bne	3b4 <shift+0x3b4>
 364:	13490115 	movtne	r0, #37141	; 0x9115
 368:	13011364 	movwne	r1, #4964	; 0x1364
 36c:	1f1b0000 	svcne	0x001b0000
 370:	49131d00 	ldmdbmi	r3, {r8, sl, fp, ip}
 374:	1c000013 	stcne	0, cr0, [r0], {19}
 378:	0b0b0010 	bleq	2c03c0 <__bss_end+0x2b6634>
 37c:	00001349 	andeq	r1, r0, r9, asr #6
 380:	0b000f1d 	bleq	3ffc <shift+0x3ffc>
 384:	1e00000b 	cdpne	0, 0, cr0, cr0, cr11, {0}
 388:	08030139 	stmdaeq	r3, {r0, r3, r4, r5, r8}
 38c:	0b3b0b3a 	bleq	ec307c <__bss_end+0xeb92f0>
 390:	13010b39 	movwne	r0, #6969	; 0x1b39
 394:	341f0000 	ldrcc	r0, [pc], #-0	; 39c <shift+0x39c>
 398:	3a0e0300 	bcc	380fa0 <__bss_end+0x377214>
 39c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 3a0:	3c13490b 			; <UNDEFINED> instruction: 0x3c13490b
 3a4:	6c061c19 	stcvs	12, cr1, [r6], {25}
 3a8:	20000019 	andcs	r0, r0, r9, lsl r0
 3ac:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 3b0:	0b3b0b3a 	bleq	ec30a0 <__bss_end+0xeb9314>
 3b4:	13490b39 	movtne	r0, #39737	; 0x9b39
 3b8:	0b1c193c 	bleq	7068b0 <__bss_end+0x6fcb24>
 3bc:	0000196c 	andeq	r1, r0, ip, ror #18
 3c0:	47003421 	strmi	r3, [r0, -r1, lsr #8]
 3c4:	22000013 	andcs	r0, r0, #19
 3c8:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 3cc:	0b3b0b3a 	bleq	ec30bc <__bss_end+0xeb9330>
 3d0:	13490b39 	movtne	r0, #39737	; 0x9b39
 3d4:	1802193f 	stmdane	r2, {r0, r1, r2, r3, r4, r5, r8, fp, ip}
 3d8:	34230000 	strtcc	r0, [r3], #-0
 3dc:	3a0e0300 	bcc	380fe4 <__bss_end+0x377258>
 3e0:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 3e4:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 3e8:	24000018 	strcs	r0, [r0], #-24	; 0xffffffe8
 3ec:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 3f0:	0b3a0e03 	bleq	e83c04 <__bss_end+0xe79e78>
 3f4:	0b390b3b 	bleq	e430e8 <__bss_end+0xe3935c>
 3f8:	01111349 	tsteq	r1, r9, asr #6
 3fc:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 400:	01194296 			; <UNDEFINED> instruction: 0x01194296
 404:	25000013 	strcs	r0, [r0, #-19]	; 0xffffffed
 408:	0e030005 	cdpeq	0, 0, cr0, cr3, cr5, {0}
 40c:	0b3b0b3a 	bleq	ec30fc <__bss_end+0xeb9370>
 410:	13490b39 	movtne	r0, #39737	; 0x9b39
 414:	00001802 	andeq	r1, r0, r2, lsl #16
 418:	03003426 	movweq	r3, #1062	; 0x426
 41c:	3b0b3a0e 	blcc	2cec5c <__bss_end+0x2c4ed0>
 420:	490b3905 	stmdbmi	fp, {r0, r2, r8, fp, ip, sp}
 424:	00180213 	andseq	r0, r8, r3, lsl r2
 428:	012e2700 			; <UNDEFINED> instruction: 0x012e2700
 42c:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 430:	0b3b0b3a 	bleq	ec3120 <__bss_end+0xeb9394>
 434:	0e6e0b39 	vmoveq.8	d14[5], r0
 438:	06120111 			; <UNDEFINED> instruction: 0x06120111
 43c:	42961840 	addsmi	r1, r6, #64, 16	; 0x400000
 440:	00130119 	andseq	r0, r3, r9, lsl r1
 444:	00342800 	eorseq	r2, r4, r0, lsl #16
 448:	0b3a0803 	bleq	e8245c <__bss_end+0xe786d0>
 44c:	0b390b3b 	bleq	e43140 <__bss_end+0xe393b4>
 450:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 454:	2e290000 	cdpcs	0, 2, cr0, cr9, cr0, {0}
 458:	03193f01 	tsteq	r9, #1, 30
 45c:	3b0b3a0e 	blcc	2cec9c <__bss_end+0x2c4f10>
 460:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 464:	1113490e 	tstne	r3, lr, lsl #18
 468:	40061201 	andmi	r1, r6, r1, lsl #4
 46c:	19429618 	stmdbne	r2, {r3, r4, r9, sl, ip, pc}^
 470:	00001301 	andeq	r1, r0, r1, lsl #6
 474:	3f012e2a 	svccc	0x00012e2a
 478:	3a080319 	bcc	2010e4 <__bss_end+0x1f7358>
 47c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 480:	110e6e0b 	tstne	lr, fp, lsl #28
 484:	40061201 	andmi	r1, r6, r1, lsl #4
 488:	19429618 	stmdbne	r2, {r3, r4, r9, sl, ip, pc}^
 48c:	00001301 	andeq	r1, r0, r1, lsl #6
 490:	0300052b 	movweq	r0, #1323	; 0x52b
 494:	3b0b3a08 	blcc	2cecbc <__bss_end+0x2c4f30>
 498:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 49c:	00180213 	andseq	r0, r8, r3, lsl r2
 4a0:	00212c00 	eoreq	r2, r1, r0, lsl #24
 4a4:	182f1349 	stmdane	pc!, {r0, r3, r6, r8, r9, ip}	; <UNPREDICTABLE>
 4a8:	2e2d0000 	cdpcs	0, 2, cr0, cr13, cr0, {0}
 4ac:	03193f01 	tsteq	r9, #1, 30
 4b0:	3b0b3a0e 	blcc	2cecf0 <__bss_end+0x2c4f64>
 4b4:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 4b8:	1201110e 	andne	r1, r1, #-2147483645	; 0x80000003
 4bc:	96184006 	ldrls	r4, [r8], -r6
 4c0:	00001942 	andeq	r1, r0, r2, asr #18
 4c4:	01110100 	tsteq	r1, r0, lsl #2
 4c8:	0b130e25 	bleq	4c3d64 <__bss_end+0x4b9fd8>
 4cc:	0e1b0e03 	cdpeq	14, 1, cr0, cr11, cr3, {0}
 4d0:	06120111 			; <UNDEFINED> instruction: 0x06120111
 4d4:	00001710 	andeq	r1, r0, r0, lsl r7
 4d8:	0b002402 	bleq	94e8 <_Z4ftoafPcj+0x1dc>
 4dc:	030b3e0b 	movweq	r3, #48651	; 0xbe0b
 4e0:	0300000e 	movweq	r0, #14
 4e4:	13490026 	movtne	r0, #36902	; 0x9026
 4e8:	24040000 	strcs	r0, [r4], #-0
 4ec:	3e0b0b00 	vmlacc.f64	d0, d11, d0
 4f0:	0008030b 	andeq	r0, r8, fp, lsl #6
 4f4:	00160500 	andseq	r0, r6, r0, lsl #10
 4f8:	0b3a0e03 	bleq	e83d0c <__bss_end+0xe79f80>
 4fc:	0b390b3b 	bleq	e431f0 <__bss_end+0xe39464>
 500:	00001349 	andeq	r1, r0, r9, asr #6
 504:	03011306 	movweq	r1, #4870	; 0x1306
 508:	3a0b0b0e 	bcc	2c3148 <__bss_end+0x2b93bc>
 50c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 510:	0013010b 	andseq	r0, r3, fp, lsl #2
 514:	000d0700 	andeq	r0, sp, r0, lsl #14
 518:	0b3a0803 	bleq	e8252c <__bss_end+0xe787a0>
 51c:	0b390b3b 	bleq	e43210 <__bss_end+0xe39484>
 520:	0b381349 	bleq	e0524c <__bss_end+0xdfb4c0>
 524:	04080000 	streq	r0, [r8], #-0
 528:	6d0e0301 	stcvs	3, cr0, [lr, #-4]
 52c:	0b0b3e19 	bleq	2cfd98 <__bss_end+0x2c600c>
 530:	3a13490b 	bcc	4d2964 <__bss_end+0x4c8bd8>
 534:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 538:	0013010b 	andseq	r0, r3, fp, lsl #2
 53c:	00280900 	eoreq	r0, r8, r0, lsl #18
 540:	0b1c0803 	bleq	702554 <__bss_end+0x6f87c8>
 544:	280a0000 	stmdacs	sl, {}	; <UNPREDICTABLE>
 548:	1c0e0300 	stcne	3, cr0, [lr], {-0}
 54c:	0b00000b 	bleq	580 <shift+0x580>
 550:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 554:	0b3b0b3a 	bleq	ec3244 <__bss_end+0xeb94b8>
 558:	13490b39 	movtne	r0, #39737	; 0x9b39
 55c:	1802196c 	stmdane	r2, {r2, r3, r5, r6, r8, fp, ip}
 560:	020c0000 	andeq	r0, ip, #0
 564:	3c0e0300 	stccc	3, cr0, [lr], {-0}
 568:	0d000019 	stceq	0, cr0, [r0, #-100]	; 0xffffff9c
 56c:	0b0b000f 	bleq	2c05b0 <__bss_end+0x2b6824>
 570:	00001349 	andeq	r1, r0, r9, asr #6
 574:	03000d0e 	movweq	r0, #3342	; 0xd0e
 578:	3b0b3a0e 	blcc	2cedb8 <__bss_end+0x2c502c>
 57c:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 580:	000b3813 	andeq	r3, fp, r3, lsl r8
 584:	01010f00 	tsteq	r1, r0, lsl #30
 588:	13011349 	movwne	r1, #4937	; 0x1349
 58c:	21100000 	tstcs	r0, r0
 590:	2f134900 	svccs	0x00134900
 594:	1100000b 	tstne	r0, fp
 598:	0e030102 	adfeqs	f0, f3, f2
 59c:	0b3a0b0b 	bleq	e831d0 <__bss_end+0xe79444>
 5a0:	0b390b3b 	bleq	e43294 <__bss_end+0xe39508>
 5a4:	00001301 	andeq	r1, r0, r1, lsl #6
 5a8:	3f012e12 	svccc	0x00012e12
 5ac:	3a0e0319 	bcc	381218 <__bss_end+0x37748c>
 5b0:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 5b4:	3c0e6e0b 	stccc	14, cr6, [lr], {11}
 5b8:	01136419 	tsteq	r3, r9, lsl r4
 5bc:	13000013 	movwne	r0, #19
 5c0:	13490005 	movtne	r0, #36869	; 0x9005
 5c4:	00001934 	andeq	r1, r0, r4, lsr r9
 5c8:	49000514 	stmdbmi	r0, {r2, r4, r8, sl}
 5cc:	15000013 	strne	r0, [r0, #-19]	; 0xffffffed
 5d0:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 5d4:	0b3a0e03 	bleq	e83de8 <__bss_end+0xe7a05c>
 5d8:	0b390b3b 	bleq	e432cc <__bss_end+0xe39540>
 5dc:	13490e6e 	movtne	r0, #40558	; 0x9e6e
 5e0:	1364193c 	cmnne	r4, #60, 18	; 0xf0000
 5e4:	00001301 	andeq	r1, r0, r1, lsl #6
 5e8:	3f012e16 	svccc	0x00012e16
 5ec:	3a0e0319 	bcc	381258 <__bss_end+0x3774cc>
 5f0:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 5f4:	490e6e0b 	stmdbmi	lr, {r0, r1, r3, r9, sl, fp, sp, lr}
 5f8:	3c0b3213 	sfmcc	f3, 4, [fp], {19}
 5fc:	01136419 	tsteq	r3, r9, lsl r4
 600:	17000013 	smladne	r0, r3, r0, r0
 604:	0e03000d 	cdpeq	0, 0, cr0, cr3, cr13, {0}
 608:	0b3b0b3a 	bleq	ec32f8 <__bss_end+0xeb956c>
 60c:	13490b39 	movtne	r0, #39737	; 0x9b39
 610:	0b320b38 	bleq	c832f8 <__bss_end+0xc7956c>
 614:	2e180000 	cdpcs	0, 1, cr0, cr8, cr0, {0}
 618:	03193f01 	tsteq	r9, #1, 30
 61c:	3b0b3a0e 	blcc	2cee5c <__bss_end+0x2c50d0>
 620:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 624:	3c0b320e 	sfmcc	f3, 4, [fp], {14}
 628:	01136419 	tsteq	r3, r9, lsl r4
 62c:	19000013 	stmdbne	r0, {r0, r1, r4}
 630:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 634:	0b3a0e03 	bleq	e83e48 <__bss_end+0xe7a0bc>
 638:	0b390b3b 	bleq	e4332c <__bss_end+0xe395a0>
 63c:	13490e6e 	movtne	r0, #40558	; 0x9e6e
 640:	193c0b32 	ldmdbne	ip!, {r1, r4, r5, r8, r9, fp}
 644:	00001364 	andeq	r1, r0, r4, ror #6
 648:	4901151a 	stmdbmi	r1, {r1, r3, r4, r8, sl, ip}
 64c:	01136413 	tsteq	r3, r3, lsl r4
 650:	1b000013 	blne	6a4 <shift+0x6a4>
 654:	131d001f 	tstne	sp, #31
 658:	00001349 	andeq	r1, r0, r9, asr #6
 65c:	0b00101c 	bleq	46d4 <shift+0x46d4>
 660:	0013490b 	andseq	r4, r3, fp, lsl #18
 664:	000f1d00 	andeq	r1, pc, r0, lsl #26
 668:	00000b0b 	andeq	r0, r0, fp, lsl #22
 66c:	0300341e 	movweq	r3, #1054	; 0x41e
 670:	3b0b3a0e 	blcc	2ceeb0 <__bss_end+0x2c5124>
 674:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 678:	00180213 	andseq	r0, r8, r3, lsl r2
 67c:	012e1f00 			; <UNDEFINED> instruction: 0x012e1f00
 680:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 684:	0b3b0b3a 	bleq	ec3374 <__bss_end+0xeb95e8>
 688:	0e6e0b39 	vmoveq.8	d14[5], r0
 68c:	01111349 	tsteq	r1, r9, asr #6
 690:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 694:	01194296 			; <UNDEFINED> instruction: 0x01194296
 698:	20000013 	andcs	r0, r0, r3, lsl r0
 69c:	0e030005 	cdpeq	0, 0, cr0, cr3, cr5, {0}
 6a0:	0b3b0b3a 	bleq	ec3390 <__bss_end+0xeb9604>
 6a4:	13490b39 	movtne	r0, #39737	; 0x9b39
 6a8:	00001802 	andeq	r1, r0, r2, lsl #16
 6ac:	3f012e21 	svccc	0x00012e21
 6b0:	3a0e0319 	bcc	38131c <__bss_end+0x377590>
 6b4:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 6b8:	490e6e0b 	stmdbmi	lr, {r0, r1, r3, r9, sl, fp, sp, lr}
 6bc:	12011113 	andne	r1, r1, #-1073741820	; 0xc0000004
 6c0:	97184006 	ldrls	r4, [r8, -r6]
 6c4:	13011942 	movwne	r1, #6466	; 0x1942
 6c8:	34220000 	strtcc	r0, [r2], #-0
 6cc:	3a080300 	bcc	2012d4 <__bss_end+0x1f7548>
 6d0:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 6d4:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 6d8:	23000018 	movwcs	r0, #24
 6dc:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 6e0:	0b3a0e03 	bleq	e83ef4 <__bss_end+0xe7a168>
 6e4:	0b390b3b 	bleq	e433d8 <__bss_end+0xe3964c>
 6e8:	01110e6e 	tsteq	r1, lr, ror #28
 6ec:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 6f0:	01194297 			; <UNDEFINED> instruction: 0x01194297
 6f4:	24000013 	strcs	r0, [r0], #-19	; 0xffffffed
 6f8:	193f002e 	ldmdbne	pc!, {r1, r2, r3, r5}	; <UNPREDICTABLE>
 6fc:	0b3a0e03 	bleq	e83f10 <__bss_end+0xe7a184>
 700:	0b390b3b 	bleq	e433f4 <__bss_end+0xe39668>
 704:	01110e6e 	tsteq	r1, lr, ror #28
 708:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 70c:	00194297 	mulseq	r9, r7, r2
 710:	012e2500 			; <UNDEFINED> instruction: 0x012e2500
 714:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 718:	0b3b0b3a 	bleq	ec3408 <__bss_end+0xeb967c>
 71c:	0e6e0b39 	vmoveq.8	d14[5], r0
 720:	01111349 	tsteq	r1, r9, asr #6
 724:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 728:	00194297 	mulseq	r9, r7, r2
 72c:	11010000 	mrsne	r0, (UNDEF: 1)
 730:	130e2501 	movwne	r2, #58625	; 0xe501
 734:	1b0e030b 	blne	381368 <__bss_end+0x3775dc>
 738:	1201110e 	andne	r1, r1, #-2147483645	; 0x80000003
 73c:	00171006 	andseq	r1, r7, r6
 740:	01390200 	teqeq	r9, r0, lsl #4
 744:	00001301 	andeq	r1, r0, r1, lsl #6
 748:	03003403 	movweq	r3, #1027	; 0x403
 74c:	3b0b3a0e 	blcc	2cef8c <__bss_end+0x2c5200>
 750:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 754:	1c193c13 	ldcne	12, cr3, [r9], {19}
 758:	0400000a 	streq	r0, [r0], #-10
 75c:	0b3a003a 	bleq	e8084c <__bss_end+0xe76ac0>
 760:	0b390b3b 	bleq	e43454 <__bss_end+0xe396c8>
 764:	00001318 	andeq	r1, r0, r8, lsl r3
 768:	49010105 	stmdbmi	r1, {r0, r2, r8}
 76c:	00130113 	andseq	r0, r3, r3, lsl r1
 770:	00210600 	eoreq	r0, r1, r0, lsl #12
 774:	0b2f1349 	bleq	bc54a0 <__bss_end+0xbbb714>
 778:	26070000 	strcs	r0, [r7], -r0
 77c:	00134900 	andseq	r4, r3, r0, lsl #18
 780:	00240800 	eoreq	r0, r4, r0, lsl #16
 784:	0b3e0b0b 	bleq	f833b8 <__bss_end+0xf7962c>
 788:	00000e03 	andeq	r0, r0, r3, lsl #28
 78c:	47003409 	strmi	r3, [r0, -r9, lsl #8]
 790:	0a000013 	beq	7e4 <shift+0x7e4>
 794:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 798:	0b3a0e03 	bleq	e83fac <__bss_end+0xe7a220>
 79c:	0b390b3b 	bleq	e43490 <__bss_end+0xe39704>
 7a0:	01110e6e 	tsteq	r1, lr, ror #28
 7a4:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 7a8:	01194296 			; <UNDEFINED> instruction: 0x01194296
 7ac:	0b000013 	bleq	800 <shift+0x800>
 7b0:	0e030005 	cdpeq	0, 0, cr0, cr3, cr5, {0}
 7b4:	0b3b0b3a 	bleq	ec34a4 <__bss_end+0xeb9718>
 7b8:	13490b39 	movtne	r0, #39737	; 0x9b39
 7bc:	00001802 	andeq	r1, r0, r2, lsl #16
 7c0:	0300050c 	movweq	r0, #1292	; 0x50c
 7c4:	3b0b3a08 	blcc	2cefec <__bss_end+0x2c5260>
 7c8:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 7cc:	00180213 	andseq	r0, r8, r3, lsl r2
 7d0:	00340d00 	eorseq	r0, r4, r0, lsl #26
 7d4:	0b3a0803 	bleq	e827e8 <__bss_end+0xe78a5c>
 7d8:	0b390b3b 	bleq	e434cc <__bss_end+0xe39740>
 7dc:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 7e0:	0f0e0000 	svceq	0x000e0000
 7e4:	490b0b00 	stmdbmi	fp, {r8, r9, fp}
 7e8:	0f000013 	svceq	0x00000013
 7ec:	0b0b0024 	bleq	2c0884 <__bss_end+0x2b6af8>
 7f0:	08030b3e 	stmdaeq	r3, {r1, r2, r3, r4, r5, r8, r9, fp}
 7f4:	2e100000 	cdpcs	0, 1, cr0, cr0, cr0, {0}
 7f8:	03193f01 	tsteq	r9, #1, 30
 7fc:	3b0b3a0e 	blcc	2cf03c <__bss_end+0x2c52b0>
 800:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 804:	1201110e 	andne	r1, r1, #-2147483645	; 0x80000003
 808:	97184006 	ldrls	r4, [r8, -r6]
 80c:	13011942 	movwne	r1, #6466	; 0x1942
 810:	34110000 	ldrcc	r0, [r1], #-0
 814:	3a0e0300 	bcc	38141c <__bss_end+0x377690>
 818:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 81c:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 820:	12000018 	andne	r0, r0, #24
 824:	0111010b 	tsteq	r1, fp, lsl #2
 828:	00000612 	andeq	r0, r0, r2, lsl r6
 82c:	00002613 	andeq	r2, r0, r3, lsl r6
 830:	000f1400 	andeq	r1, pc, r0, lsl #8
 834:	00000b0b 	andeq	r0, r0, fp, lsl #22
 838:	3f012e15 	svccc	0x00012e15
 83c:	3a0e0319 	bcc	3814a8 <__bss_end+0x37771c>
 840:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 844:	490e6e0b 	stmdbmi	lr, {r0, r1, r3, r9, sl, fp, sp, lr}
 848:	12011113 	andne	r1, r1, #-1073741820	; 0xc0000004
 84c:	97184006 	ldrls	r4, [r8, -r6]
 850:	13011942 	movwne	r1, #6466	; 0x1942
 854:	0b160000 	bleq	58085c <__bss_end+0x576ad0>
 858:	12011101 	andne	r1, r1, #1073741824	; 0x40000000
 85c:	00130106 	andseq	r0, r3, r6, lsl #2
 860:	012e1700 			; <UNDEFINED> instruction: 0x012e1700
 864:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 868:	0b3b0b3a 	bleq	ec3558 <__bss_end+0xeb97cc>
 86c:	0e6e0b39 	vmoveq.8	d14[5], r0
 870:	06120111 			; <UNDEFINED> instruction: 0x06120111
 874:	42961840 	addsmi	r1, r6, #64, 16	; 0x400000
 878:	00000019 	andeq	r0, r0, r9, lsl r0

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
  74:	00000a74 	andeq	r0, r0, r4, ror sl
	...
  80:	0000001c 	andeq	r0, r0, ip, lsl r0
  84:	0fe40002 	svceq	0x00e40002
  88:	00040000 	andeq	r0, r4, r0
  8c:	00000000 	andeq	r0, r0, r0
  90:	00008ca0 	andeq	r8, r0, r0, lsr #25
  94:	0000045c 	andeq	r0, r0, ip, asr r4
	...
  a0:	0000001c 	andeq	r0, r0, ip, lsl r0
  a4:	1b070002 	blne	1c00b4 <__bss_end+0x1b6328>
  a8:	00040000 	andeq	r0, r4, r0
  ac:	00000000 	andeq	r0, r0, r0
  b0:	000090fc 	strdeq	r9, [r0], -ip
  b4:	000007c0 	andeq	r0, r0, r0, asr #15
	...

Disassembly of section .debug_str:

00000000 <.debug_str>:
       0:	6573552f 	ldrbvs	r5, [r3, #-1327]!	; 0xfffffad1
       4:	772f7372 			; <UNDEFINED> instruction: 0x772f7372
       8:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
       c:	2f696a72 	svccs	0x00696a72
      10:	6b736544 	blvs	1cd9528 <__bss_end+0x1ccf79c>
      14:	2f706f74 	svccs	0x00706f74
      18:	2f564146 	svccs	0x00564146
      1c:	6176614e 	cmnvs	r6, lr, asr #2
      20:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
      24:	4f2f6963 	svcmi	0x002f6963
      28:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
      2c:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
      30:	6b6c6172 	blvs	1b18600 <__bss_end+0x1b0e874>
      34:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
      38:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
      3c:	756f732f 	strbvc	r7, [pc, #-815]!	; fffffd15 <__bss_end+0xffff5f89>
      40:	73656372 	cmnvc	r5, #-939524095	; 0xc8000001
      44:	6573752f 	ldrbvs	r7, [r3, #-1327]!	; 0xfffffad1
      48:	61707372 	cmnvs	r0, r2, ror r3
      4c:	632f6563 			; <UNDEFINED> instruction: 0x632f6563
      50:	2e307472 	mrccs	4, 1, r7, cr0, cr2, {3}
      54:	552f0073 	strpl	r0, [pc, #-115]!	; ffffffe9 <__bss_end+0xffff625d>
      58:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
      5c:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
      60:	6a726574 	bvs	1c99638 <__bss_end+0x1c8f8ac>
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
      98:	752f7365 	strvc	r7, [pc, #-869]!	; fffffd3b <__bss_end+0xffff5faf>
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
     12c:	6a363731 	bvs	d8ddf8 <__bss_end+0xd8406c>
     130:	732d667a 			; <UNDEFINED> instruction: 0x732d667a
     134:	616d2d20 	cmnvs	sp, r0, lsr #26
     138:	2d206d72 	stccs	13, cr6, [r0, #-456]!	; 0xfffffe38
     13c:	6372616d 	cmnvs	r2, #1073741851	; 0x4000001b
     140:	72613d68 	rsbvc	r3, r1, #104, 26	; 0x1a00
     144:	7a36766d 	bvc	d9db00 <__bss_end+0xd93d74>
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
     184:	6a757a61 	bvs	1d5eb10 <__bss_end+0x1d54d84>
     188:	2f696369 	svccs	0x00696369
     18c:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
     190:	73656d65 	cmnvc	r5, #6464	; 0x1940
     194:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
     198:	6b2d616b 	blvs	b5874c <__bss_end+0xb4e9c0>
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
     1e4:	2b2b4320 	blcs	ad0e6c <__bss_end+0xac70e0>
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
     260:	2b6b7a36 	blcs	1adeb40 <__bss_end+0x1ad4db4>
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
     294:	755f6962 	ldrbvc	r6, [pc, #-2402]	; fffff93a <__bss_end+0xffff5bae>
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
     324:	6b736544 	blvs	1cd983c <__bss_end+0x1ccfab0>
     328:	2f706f74 	svccs	0x00706f74
     32c:	2f564146 	svccs	0x00564146
     330:	6176614e 	cmnvs	r6, lr, asr #2
     334:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
     338:	4f2f6963 	svcmi	0x002f6963
     33c:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
     340:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
     344:	6b6c6172 	blvs	1b18914 <__bss_end+0x1b0eb88>
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
     4ec:	626d6f5a 	rsbvs	r6, sp, #360	; 0x168
     4f0:	6c006569 	cfstr32vs	mvfx6, [r0], {105}	; 0x69
     4f4:	665f676f 	ldrbvs	r6, [pc], -pc, ror #14
     4f8:	656e0064 	strbvs	r0, [lr, #-100]!	; 0xffffff9c
     4fc:	52007478 	andpl	r7, r0, #120, 8	; 0x78000000
     500:	616e6e75 	smcvs	59109	; 0xe6e5
     504:	00656c62 	rsbeq	r6, r5, r2, ror #24
     508:	646e6573 	strbtvs	r6, [lr], #-1395	; 0xfffffa8d
     50c:	6c61765f 	stclvs	6, cr7, [r1], #-380	; 0xfffffe84
     510:	49006575 	stmdbmi	r0, {r0, r2, r4, r5, r6, r8, sl, sp, lr}
     514:	6c61766e 	stclvs	6, cr7, [r1], #-440	; 0xfffffe48
     518:	485f6469 	ldmdami	pc, {r0, r3, r5, r6, sl, sp, lr}^	; <UNPREDICTABLE>
     51c:	6c646e61 	stclvs	14, cr6, [r4], #-388	; 0xfffffe7c
     520:	75520065 	ldrbvc	r0, [r2, #-101]	; 0xffffff9b
     524:	6e696e6e 	cdpvs	14, 6, cr6, cr9, cr14, {3}
     528:	65440067 	strbvs	r0, [r4, #-103]	; 0xffffff99
     52c:	696c6461 	stmdbvs	ip!, {r0, r5, r6, sl, sp, lr}^
     530:	555f656e 	ldrbpl	r6, [pc, #-1390]	; ffffffca <__bss_end+0xffff623e>
     534:	6168636e 	cmnvs	r8, lr, ror #6
     538:	6465676e 	strbtvs	r6, [r5], #-1902	; 0xfffff892
     53c:	74654700 	strbtvc	r4, [r5], #-1792	; 0xfffff900
     540:	7275435f 	rsbsvc	r4, r5, #2080374785	; 0x7c000001
     544:	746e6572 	strbtvc	r6, [lr], #-1394	; 0xfffffa8e
     548:	6f72505f 	svcvs	0x0072505f
     54c:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     550:	49504700 	ldmdbmi	r0, {r8, r9, sl, lr}^
     554:	61425f4f 	cmpvs	r2, pc, asr #30
     558:	5f006573 	svcpl	0x00006573
     55c:	36314e5a 			; <UNDEFINED> instruction: 0x36314e5a
     560:	6f725043 	svcvs	0x00725043
     564:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     568:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     56c:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     570:	72433431 	subvc	r3, r3, #822083584	; 0x31000000
     574:	65746165 	ldrbvs	r6, [r4, #-357]!	; 0xfffffe9b
     578:	6f72505f 	svcvs	0x0072505f
     57c:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     580:	6a685045 	bvs	1a1469c <__bss_end+0x1a0a910>
     584:	5a5f0062 	bpl	17c0714 <__bss_end+0x17b6988>
     588:	6e657339 	mcrvs	3, 3, r7, cr5, cr9, {1}
     58c:	61645f64 	cmnvs	r4, r4, ror #30
     590:	00666174 	rsbeq	r6, r6, r4, ror r1
     594:	5f746553 	svcpl	0x00746553
     598:	61726150 	cmnvs	r2, r0, asr r1
     59c:	4900736d 	stmdbmi	r0, {r0, r2, r3, r5, r6, r8, r9, ip, sp, lr}
     5a0:	545f4332 	ldrbpl	r4, [pc], #-818	; 5a8 <shift+0x5a8>
     5a4:	736e6172 	cmnvc	lr, #-2147483620	; 0x8000001c
     5a8:	69746361 	ldmdbvs	r4!, {r0, r5, r6, r8, r9, sp, lr}^
     5ac:	4d5f6e6f 	ldclmi	14, cr6, [pc, #-444]	; 3f8 <shift+0x3f8>
     5b0:	535f7861 	cmppl	pc, #6356992	; 0x610000
     5b4:	00657a69 	rsbeq	r7, r5, r9, ror #20
     5b8:	76657270 			; <UNDEFINED> instruction: 0x76657270
     5bc:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     5c0:	4336314b 	teqmi	r6, #-1073741806	; 0xc0000012
     5c4:	636f7250 	cmnvs	pc, #80, 4
     5c8:	5f737365 	svcpl	0x00737365
     5cc:	616e614d 	cmnvs	lr, sp, asr #2
     5d0:	31726567 	cmncc	r2, r7, ror #10
     5d4:	74654739 	strbtvc	r4, [r5], #-1849	; 0xfffff8c7
     5d8:	7275435f 	rsbsvc	r4, r5, #2080374785	; 0x7c000001
     5dc:	746e6572 	strbtvc	r6, [lr], #-1394	; 0xfffffa8e
     5e0:	6f72505f 	svcvs	0x0072505f
     5e4:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     5e8:	52007645 	andpl	r7, r0, #72351744	; 0x4500000
     5ec:	5f646165 	svcpl	0x00646165
     5f0:	796c6e4f 	stmdbvc	ip!, {r0, r1, r2, r3, r6, r9, sl, fp, sp, lr}^
     5f4:	6c617600 	stclvs	6, cr7, [r1], #-0
     5f8:	735f6575 	cmpvc	pc, #490733568	; 0x1d400000
     5fc:	4d007274 	sfmmi	f7, 4, [r0, #-464]	; 0xfffffe30
     600:	505f7861 	subspl	r7, pc, r1, ror #16
     604:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     608:	4f5f7373 	svcmi	0x005f7373
     60c:	656e6570 	strbvs	r6, [lr, #-1392]!	; 0xfffffa90
     610:	69465f64 	stmdbvs	r6, {r2, r5, r6, r8, r9, sl, fp, ip, lr}^
     614:	0073656c 	rsbseq	r6, r3, ip, ror #10
     618:	55504354 	ldrbpl	r4, [r0, #-852]	; 0xfffffcac
     61c:	6e6f435f 	mcrvs	3, 3, r4, cr15, cr15, {2}
     620:	74786574 	ldrbtvc	r6, [r8], #-1396	; 0xfffffa8c
     624:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     628:	50433631 	subpl	r3, r3, r1, lsr r6
     62c:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     630:	4d5f7373 	ldclmi	3, cr7, [pc, #-460]	; 46c <shift+0x46c>
     634:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
     638:	53387265 	teqpl	r8, #1342177286	; 0x50000006
     63c:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     640:	45656c75 	strbmi	r6, [r5, #-3189]!	; 0xfffff38b
     644:	6f4e0076 	svcvs	0x004e0076
     648:	79666974 	stmdbvc	r6!, {r2, r4, r5, r6, r8, fp, sp, lr}^
     64c:	006c6c41 	rsbeq	r6, ip, r1, asr #24
     650:	636f6c42 	cmnvs	pc, #16896	; 0x4200
     654:	75435f6b 	strbvc	r5, [r3, #-3947]	; 0xfffff095
     658:	6e657272 	mcrvs	2, 3, r7, cr5, cr2, {3}
     65c:	72505f74 	subsvc	r5, r0, #116, 30	; 0x1d0
     660:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     664:	65470073 	strbvs	r0, [r7, #-115]	; 0xffffff8d
     668:	49505f74 	ldmdbmi	r0, {r2, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     66c:	69750044 	ldmdbvs	r5!, {r2, r6}^
     670:	3233746e 	eorscc	r7, r3, #1845493760	; 0x6e000000
     674:	4c00745f 	cfstrsmi	mvf7, [r0], {95}	; 0x5f
     678:	5245574f 	subpl	r5, r5, #20709376	; 0x13c0000
     67c:	554f425f 	strbpl	r4, [pc, #-607]	; 425 <shift+0x425>
     680:	4e00444e 	cdpmi	4, 0, cr4, cr0, cr14, {2}
     684:	74434f49 	strbvc	r4, [r3], #-3913	; 0xfffff0b7
     688:	704f5f6c 	subvc	r5, pc, ip, ror #30
     68c:	74617265 	strbtvc	r7, [r1], #-613	; 0xfffffd9b
     690:	006e6f69 	rsbeq	r6, lr, r9, ror #30
     694:	616f6c66 	cmnvs	pc, r6, ror #24
     698:	32690074 	rsbcc	r0, r9, #116	; 0x74
     69c:	64665f63 	strbtvs	r5, [r6], #-3939	; 0xfffff09d
     6a0:	43534200 	cmpmi	r3, #0, 4
     6a4:	61425f31 	cmpvs	r2, r1, lsr pc
     6a8:	57006573 	smlsdxpl	r0, r3, r5, r6
     6ac:	00746961 	rsbseq	r6, r4, r1, ror #18
     6b0:	7361544e 	cmnvc	r1, #1308622848	; 0x4e000000
     6b4:	74535f6b 	ldrbvc	r5, [r3], #-3947	; 0xfffff095
     6b8:	00657461 	rsbeq	r7, r5, r1, ror #8
     6bc:	65686353 	strbvs	r6, [r8, #-851]!	; 0xfffffcad
     6c0:	656c7564 	strbvs	r7, [ip, #-1380]!	; 0xfffffa9c
     6c4:	4644455f 			; <UNDEFINED> instruction: 0x4644455f
     6c8:	6f6c4200 	svcvs	0x006c4200
     6cc:	64656b63 	strbtvs	r6, [r5], #-2915	; 0xfffff49d
     6d0:	75436d00 	strbvc	r6, [r3, #-3328]	; 0xfffff300
     6d4:	6e657272 	mcrvs	2, 3, r7, cr5, cr2, {3}
     6d8:	61545f74 	cmpvs	r4, r4, ror pc
     6dc:	4e5f6b73 	vmovmi.s8	r6, d15[3]
     6e0:	0065646f 	rsbeq	r6, r5, pc, ror #8
     6e4:	65656c73 	strbvs	r6, [r5, #-3187]!	; 0xfffff38d
     6e8:	69745f70 	ldmdbvs	r4!, {r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     6ec:	0072656d 	rsbseq	r6, r2, sp, ror #10
     6f0:	314e5a5f 	cmpcc	lr, pc, asr sl
     6f4:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     6f8:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     6fc:	614d5f73 	hvcvs	54771	; 0xd5f3
     700:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     704:	77533972 			; <UNDEFINED> instruction: 0x77533972
     708:	68637469 	stmdavs	r3!, {r0, r3, r5, r6, sl, ip, sp, lr}^
     70c:	456f545f 	strbmi	r5, [pc, #-1119]!	; 2b5 <shift+0x2b5>
     710:	43383150 	teqmi	r8, #80, 2
     714:	636f7250 	cmnvs	pc, #80, 4
     718:	5f737365 	svcpl	0x00737365
     71c:	7473694c 	ldrbtvc	r6, [r3], #-2380	; 0xfffff6b4
     720:	646f4e5f 	strbtvs	r4, [pc], #-3679	; 728 <shift+0x728>
     724:	746f0065 	strbtvc	r0, [pc], #-101	; 72c <shift+0x72c>
     728:	5f726568 	svcpl	0x00726568
     72c:	656c6f72 	strbvs	r6, [ip, #-3954]!	; 0xfffff08e
     730:	75706300 	ldrbvc	r6, [r0, #-768]!	; 0xfffffd00
     734:	6e6f635f 	mcrvs	3, 3, r6, cr15, cr15, {2}
     738:	74786574 	ldrbtvc	r6, [r8], #-1396	; 0xfffffa8c
     73c:	65724300 	ldrbvs	r4, [r2, #-768]!	; 0xfffffd00
     740:	5f657461 	svcpl	0x00657461
     744:	636f7250 	cmnvs	pc, #80, 4
     748:	00737365 	rsbseq	r7, r3, r5, ror #6
     74c:	6e65704f 	cdpvs	0, 6, cr7, cr5, cr15, {2}
     750:	315a5f00 	cmpcc	sl, r0, lsl #30
     754:	616c7330 	cmnvs	ip, r0, lsr r3
     758:	745f6576 	ldrbvc	r6, [pc], #-1398	; 760 <shift+0x760>
     75c:	766b7361 	strbtvc	r7, [fp], -r1, ror #6
     760:	6d695400 	cfstrdvs	mvd5, [r9, #-0]
     764:	425f7265 	subsmi	r7, pc, #1342177286	; 0x50000006
     768:	00657361 	rsbeq	r7, r5, r1, ror #6
     76c:	6c335a5f 			; <UNDEFINED> instruction: 0x6c335a5f
     770:	4b50676f 	blmi	141a534 <__bss_end+0x14107a8>
     774:	65730063 	ldrbvs	r0, [r3, #-99]!	; 0xffffff9d
     778:	645f646e 	ldrbvs	r6, [pc], #-1134	; 780 <shift+0x780>
     77c:	00617461 	rsbeq	r7, r1, r1, ror #8
     780:	31315a5f 	teqcc	r1, pc, asr sl
     784:	646e6168 	strbtvs	r6, [lr], #-360	; 0xfffffe98
     788:	645f656c 	ldrbvs	r6, [pc], #-1388	; 790 <shift+0x790>
     78c:	63617461 	cmnvs	r1, #1627389952	; 0x61000000
     790:	65640066 	strbvs	r0, [r4, #-102]!	; 0xffffff9a
     794:	65726973 	ldrbvs	r6, [r2, #-2419]!	; 0xfffff68d
     798:	6f725f64 	svcvs	0x00725f64
     79c:	2f00656c 	svccs	0x0000656c
     7a0:	72657355 	rsbvc	r7, r5, #1409286145	; 0x54000001
     7a4:	69772f73 	ldmdbvs	r7!, {r0, r1, r4, r5, r6, r8, r9, sl, fp, sp}^
     7a8:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
     7ac:	442f696a 	strtmi	r6, [pc], #-2410	; 7b4 <shift+0x7b4>
     7b0:	746b7365 	strbtvc	r7, [fp], #-869	; 0xfffffc9b
     7b4:	462f706f 	strtmi	r7, [pc], -pc, rrx
     7b8:	4e2f5641 	cfmadda32mi	mvax2, mvax5, mvfx15, mvfx1
     7bc:	7a617661 	bvc	185e148 <__bss_end+0x18543bc>
     7c0:	63696a75 	cmnvs	r9, #479232	; 0x75000
     7c4:	534f2f69 	movtpl	r2, #65385	; 0xff69
     7c8:	6d65732f 	stclvs	3, cr7, [r5, #-188]!	; 0xffffff44
     7cc:	72747365 	rsbsvc	r7, r4, #-1811939327	; 0x94000001
     7d0:	616b6c61 	cmnvs	fp, r1, ror #24
     7d4:	76696b2d 	strbtvc	r6, [r9], -sp, lsr #22
     7d8:	2f736f2d 	svccs	0x00736f2d
     7dc:	72756f73 	rsbsvc	r6, r5, #460	; 0x1cc
     7e0:	2f736563 	svccs	0x00736563
     7e4:	72657375 	rsbvc	r7, r5, #-738197503	; 0xd4000001
     7e8:	63617073 	cmnvs	r1, #115	; 0x73
     7ec:	616d2f65 	cmnvs	sp, r5, ror #30
     7f0:	72657473 	rsbvc	r7, r5, #1929379840	; 0x73000000
     7f4:	7361745f 	cmnvc	r1, #1593835520	; 0x5f000000
     7f8:	616d2f6b 	cmnvs	sp, fp, ror #30
     7fc:	632e6e69 			; <UNDEFINED> instruction: 0x632e6e69
     800:	6d007070 	stcvs	0, cr7, [r0, #-448]	; 0xfffffe40
     804:	6f725f79 	svcvs	0x00725f79
     808:	5f00656c 	svcpl	0x0000656c
     80c:	36314e5a 			; <UNDEFINED> instruction: 0x36314e5a
     810:	6f725043 	svcvs	0x00725043
     814:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     818:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     81c:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     820:	6f4e3431 	svcvs	0x004e3431
     824:	79666974 	stmdbvc	r6!, {r2, r4, r5, r6, r8, fp, sp, lr}^
     828:	6f72505f 	svcvs	0x0072505f
     82c:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     830:	32315045 	eorscc	r5, r1, #69	; 0x45
     834:	73615454 	cmnvc	r1, #84, 8	; 0x54000000
     838:	74535f6b 	ldrbvc	r5, [r3], #-3947	; 0xfffff095
     83c:	74637572 	strbtvc	r7, [r3], #-1394	; 0xfffffa8e
     840:	74654700 	strbtvc	r4, [r5], #-1792	; 0xfffff900
     844:	6863535f 	stmdavs	r3!, {r0, r1, r2, r3, r4, r6, r8, r9, ip, lr}^
     848:	495f6465 	ldmdbmi	pc, {r0, r2, r5, r6, sl, sp, lr}^	; <UNPREDICTABLE>
     84c:	006f666e 	rsbeq	r6, pc, lr, ror #12
     850:	76677261 	strbtvc	r7, [r7], -r1, ror #4
     854:	434f4900 	movtmi	r4, #63744	; 0xf900
     858:	5f006c74 	svcpl	0x00006c74
     85c:	6f6c335a 	svcvs	0x006c335a
     860:	6d006a67 	vstrvs	s12, [r0, #-412]	; 0xfffffe64
     864:	65747361 	ldrbvs	r7, [r4, #-865]!	; 0xfffffc9f
     868:	61745f72 	cmnvs	r4, r2, ror pc
     86c:	52006b73 	andpl	r6, r0, #117760	; 0x1cc00
     870:	00646165 	rsbeq	r6, r4, r5, ror #2
     874:	6d726554 	cfldr64vs	mvdx6, [r2, #-336]!	; 0xfffffeb0
     878:	74616e69 	strbtvc	r6, [r1], #-3689	; 0xfffff197
     87c:	656e0065 	strbvs	r0, [lr, #-101]!	; 0xffffff9b
     880:	75625f77 	strbvc	r5, [r2, #-3959]!	; 0xfffff089
     884:	4d006666 	stcmi	6, cr6, [r0, #-408]	; 0xfffffe68
     888:	65747361 	ldrbvs	r7, [r4, #-865]!	; 0xfffffc9f
     88c:	6f4e0072 	svcvs	0x004e0072
     890:	79666974 	stmdbvc	r6!, {r2, r4, r5, r6, r8, fp, sp, lr}^
     894:	6f72505f 	svcvs	0x0072505f
     898:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     89c:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     8a0:	50433631 	subpl	r3, r3, r1, lsr r6
     8a4:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     8a8:	4d5f7373 	ldclmi	3, cr7, [pc, #-460]	; 6e4 <shift+0x6e4>
     8ac:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
     8b0:	34437265 	strbcc	r7, [r3], #-613	; 0xfffffd9b
     8b4:	70007645 	andvc	r7, r0, r5, asr #12
     8b8:	5f706572 	svcpl	0x00706572
     8bc:	0067736d 	rsbeq	r7, r7, sp, ror #6
     8c0:	47524154 			; <UNDEFINED> instruction: 0x47524154
     8c4:	415f5445 	cmpmi	pc, r5, asr #8
     8c8:	45524444 	ldrbmi	r4, [r2, #-1092]	; 0xfffffbbc
     8cc:	72005353 	andvc	r5, r0, #1275068417	; 0x4c000001
     8d0:	6f646e61 	svcvs	0x00646e61
     8d4:	61765f6d 	cmnvs	r6, sp, ror #30
     8d8:	7365756c 	cmnvc	r5, #108, 10	; 0x1b000000
     8dc:	6e656c5f 	mcrvs	12, 3, r6, cr5, cr15, {2}
     8e0:	6e697500 	cdpvs	5, 6, cr7, cr9, cr0, {0}
     8e4:	745f3874 	ldrbvc	r3, [pc], #-2164	; 8ec <shift+0x8ec>
     8e8:	746f4e00 	strbtvc	r4, [pc], #-3584	; 8f0 <shift+0x8f0>
     8ec:	00796669 	rsbseq	r6, r9, r9, ror #12
     8f0:	5078614d 	rsbspl	r6, r8, sp, asr #2
     8f4:	4c687461 	cfstrdmi	mvd7, [r8], #-388	; 0xfffffe7c
     8f8:	74676e65 	strbtvc	r6, [r7], #-3685	; 0xfffff19b
     8fc:	614d0068 	cmpvs	sp, r8, rrx
     900:	44534678 	ldrbmi	r4, [r3], #-1656	; 0xfffff988
     904:	65766972 	ldrbvs	r6, [r6, #-2418]!	; 0xfffff68e
     908:	6d614e72 	stclvs	14, cr4, [r1, #-456]!	; 0xfffffe38
     90c:	6e654c65 	cdpvs	12, 6, cr4, cr5, cr5, {3}
     910:	00687467 	rsbeq	r7, r8, r7, ror #8
     914:	314e5a5f 	cmpcc	lr, pc, asr sl
     918:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     91c:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     920:	614d5f73 	hvcvs	54771	; 0xd5f3
     924:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     928:	53313172 	teqpl	r1, #-2147483620	; 0x8000001c
     92c:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     930:	5f656c75 	svcpl	0x00656c75
     934:	76455252 			; <UNDEFINED> instruction: 0x76455252
     938:	65474e00 	strbvs	r4, [r7, #-3584]	; 0xfffff200
     93c:	63535f74 	cmpvs	r3, #116, 30	; 0x1d0
     940:	5f646568 	svcpl	0x00646568
     944:	6f666e49 	svcvs	0x00666e49
     948:	7079545f 	rsbsvc	r5, r9, pc, asr r4
     94c:	50470065 	subpl	r0, r7, r5, rrx
     950:	505f4f49 	subspl	r4, pc, r9, asr #30
     954:	435f6e69 	cmpmi	pc, #1680	; 0x690
     958:	746e756f 	strbtvc	r7, [lr], #-1391	; 0xfffffa91
     95c:	6f6f6200 	svcvs	0x006f6200
     960:	5a5f006c 	bpl	17c0b18 <__bss_end+0x17b6d8c>
     964:	65643131 	strbvs	r3, [r4, #-305]!	; 0xfffffecf
     968:	65646963 	strbvs	r6, [r4, #-2403]!	; 0xfffff69d
     96c:	6c6f725f 	sfmvs	f7, 2, [pc], #-380	; 7f8 <shift+0x7f8>
     970:	49433965 	stmdbmi	r3, {r0, r2, r5, r6, r8, fp, ip, sp}^
     974:	4d5f4332 	ldclmi	3, cr4, [pc, #-200]	; 8b4 <shift+0x8b4>
     978:	5065646f 	rsbpl	r6, r5, pc, ror #8
     97c:	5a5f0063 	bpl	17c0b10 <__bss_end+0x17b6d84>
     980:	4336314e 	teqmi	r6, #-2147483629	; 0x80000013
     984:	636f7250 	cmnvs	pc, #80, 4
     988:	5f737365 	svcpl	0x00737365
     98c:	616e614d 	cmnvs	lr, sp, asr #2
     990:	31726567 	cmncc	r2, r7, ror #10
     994:	74654738 	strbtvc	r4, [r5], #-1848	; 0xfffff8c8
     998:	6863535f 	stmdavs	r3!, {r0, r1, r2, r3, r4, r6, r8, r9, ip, lr}^
     99c:	6c756465 	cfldrdvs	mvd6, [r5], #-404	; 0xfffffe6c
     9a0:	495f7265 	ldmdbmi	pc, {r0, r2, r5, r6, r9, ip, sp, lr}^	; <UNPREDICTABLE>
     9a4:	456f666e 	strbmi	r6, [pc, #-1646]!	; 33e <shift+0x33e>
     9a8:	474e3032 	smlaldxmi	r3, lr, r2, r0
     9ac:	535f7465 	cmppl	pc, #1694498816	; 0x65000000
     9b0:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     9b4:	666e495f 			; <UNDEFINED> instruction: 0x666e495f
     9b8:	79545f6f 	ldmdbvc	r4, {r0, r1, r2, r3, r5, r6, r8, r9, sl, fp, ip, lr}^
     9bc:	76506570 			; <UNDEFINED> instruction: 0x76506570
     9c0:	4e525400 	cdpmi	4, 5, cr5, cr2, cr0, {0}
     9c4:	61425f47 	cmpvs	r2, r7, asr #30
     9c8:	53006573 	movwpl	r6, #1395	; 0x573
     9cc:	6576616c 	ldrbvs	r6, [r6, #-364]!	; 0xfffffe94
     9d0:	66654400 	strbtvs	r4, [r5], -r0, lsl #8
     9d4:	746c7561 	strbtvc	r7, [ip], #-1377	; 0xfffffa9f
     9d8:	6f6c435f 	svcvs	0x006c435f
     9dc:	525f6b63 	subspl	r6, pc, #101376	; 0x18c00
     9e0:	00657461 	rsbeq	r7, r5, r1, ror #8
     9e4:	6f72506d 	svcvs	0x0072506d
     9e8:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     9ec:	73694c5f 	cmnvc	r9, #24320	; 0x5f00
     9f0:	65485f74 	strbvs	r5, [r8, #-3956]	; 0xfffff08c
     9f4:	6d006461 	cfstrsvs	mvf6, [r0, #-388]	; 0xfffffe7c
     9f8:	65686353 	strbvs	r6, [r8, #-851]!	; 0xfffffcad
     9fc:	656c7564 	strbvs	r7, [ip, #-1380]!	; 0xfffffa9c
     a00:	636e465f 	cmnvs	lr, #99614720	; 0x5f00000
     a04:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     a08:	50433631 	subpl	r3, r3, r1, lsr r6
     a0c:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     a10:	4d5f7373 	ldclmi	3, cr7, [pc, #-460]	; 84c <shift+0x84c>
     a14:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
     a18:	31327265 	teqcc	r2, r5, ror #4
     a1c:	636f6c42 	cmnvs	pc, #16896	; 0x4200
     a20:	75435f6b 	strbvc	r5, [r3, #-3947]	; 0xfffff095
     a24:	6e657272 	mcrvs	2, 3, r7, cr5, cr2, {3}
     a28:	72505f74 	subsvc	r5, r0, #116, 30	; 0x1d0
     a2c:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     a30:	00764573 	rsbseq	r4, r6, r3, ror r5
     a34:	6b636f4c 	blvs	18dc76c <__bss_end+0x18d29e0>
     a38:	6c6e555f 	cfstr64vs	mvdx5, [lr], #-380	; 0xfffffe84
     a3c:	656b636f 	strbvs	r6, [fp, #-879]!	; 0xfffffc91
     a40:	4c6d0064 	stclmi	0, cr0, [sp], #-400	; 0xfffffe70
     a44:	5f747361 	svcpl	0x00747361
     a48:	00444950 	subeq	r4, r4, r0, asr r9
     a4c:	65726761 	ldrbvs	r6, [r2, #-1889]!	; 0xfffff89f
     a50:	725f6465 	subsvc	r6, pc, #1694498816	; 0x65000000
     a54:	00656c6f 	rsbeq	r6, r5, pc, ror #24
     a58:	74697753 	strbtvc	r7, [r9], #-1875	; 0xfffff8ad
     a5c:	545f6863 	ldrbpl	r6, [pc], #-2147	; a64 <shift+0xa64>
     a60:	6c43006f 	mcrrvs	0, 6, r0, r3, cr15
     a64:	0065736f 	rsbeq	r7, r5, pc, ror #6
     a68:	314e5a5f 	cmpcc	lr, pc, asr sl
     a6c:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     a70:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     a74:	614d5f73 	hvcvs	54771	; 0xd5f3
     a78:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     a7c:	53323172 	teqpl	r2, #-2147483620	; 0x8000001c
     a80:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     a84:	5f656c75 	svcpl	0x00656c75
     a88:	45464445 	strbmi	r4, [r6, #-1093]	; 0xfffffbbb
     a8c:	53420076 	movtpl	r0, #8310	; 0x2076
     a90:	425f3043 	subsmi	r3, pc, #67	; 0x43
     a94:	00657361 	rsbeq	r7, r5, r1, ror #6
     a98:	76616c73 			; <UNDEFINED> instruction: 0x76616c73
     a9c:	61745f65 	cmnvs	r4, r5, ror #30
     aa0:	55006b73 	strpl	r6, [r0, #-2931]	; 0xfffff48d
     aa4:	6665646e 	strbtvs	r6, [r5], -lr, ror #8
     aa8:	64656e69 	strbtvs	r6, [r5], #-3689	; 0xfffff197
     aac:	67726100 	ldrbvs	r6, [r2, -r0, lsl #2]!
     ab0:	5a5f0063 	bpl	17c0c44 <__bss_end+0x17b6eb8>
     ab4:	616d3131 	cmnvs	sp, r1, lsr r1
     ab8:	72657473 	rsbvc	r7, r5, #1929379840	; 0x73000000
     abc:	7361745f 	cmnvc	r1, #1593835520	; 0x5f000000
     ac0:	6e00766b 	cfmadd32vs	mvax3, mvfx7, mvfx0, mvfx11
     ac4:	6669746f 	strbtvs	r7, [r9], -pc, ror #8
     ac8:	5f646569 	svcpl	0x00646569
     acc:	64616564 	strbtvs	r6, [r1], #-1380	; 0xfffffa9c
     ad0:	656e696c 	strbvs	r6, [lr, #-2412]!	; 0xfffff694
     ad4:	63657200 	cmnvs	r5, #0, 4
     ad8:	65766965 	ldrbvs	r6, [r6, #-2405]!	; 0xfffff69b
     adc:	61765f64 	cmnvs	r6, r4, ror #30
     ae0:	7365756c 	cmnvc	r5, #108, 10	; 0x1b000000
     ae4:	6e656c5f 	mcrvs	12, 3, r6, cr5, cr15, {2}
     ae8:	676f6c00 	strbvs	r6, [pc, -r0, lsl #24]!
     aec:	67736d5f 			; <UNDEFINED> instruction: 0x67736d5f
     af0:	6c617600 	stclvs	6, cr7, [r1], #-0
     af4:	735f6575 	cmpvc	pc, #490733568	; 0x1d400000
     af8:	65746174 	ldrbvs	r6, [r4, #-372]!	; 0xfffffe8c
     afc:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     b00:	50433631 	subpl	r3, r3, r1, lsr r6
     b04:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     b08:	4d5f7373 	ldclmi	3, cr7, [pc, #-460]	; 944 <shift+0x944>
     b0c:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
     b10:	34317265 	ldrtcc	r7, [r1], #-613	; 0xfffffd9b
     b14:	69746f4e 	ldmdbvs	r4!, {r1, r2, r3, r6, r8, r9, sl, fp, sp, lr}^
     b18:	505f7966 	subspl	r7, pc, r6, ror #18
     b1c:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     b20:	6a457373 	bvs	115d8f4 <__bss_end+0x1153b68>
     b24:	466f4e00 	strbtmi	r4, [pc], -r0, lsl #28
     b28:	73656c69 	cmnvc	r5, #26880	; 0x6900
     b2c:	65747379 	ldrbvs	r7, [r4, #-889]!	; 0xfffffc87
     b30:	6972446d 	ldmdbvs	r2!, {r0, r2, r3, r5, r6, sl, lr}^
     b34:	00726576 	rsbseq	r6, r2, r6, ror r5
     b38:	64616544 	strbtvs	r6, [r1], #-1348	; 0xfffffabc
     b3c:	656e696c 	strbvs	r6, [lr, #-2412]!	; 0xfffff694
     b40:	73694400 	cmnvc	r9, #0, 8
     b44:	656c6261 	strbvs	r6, [ip, #-609]!	; 0xfffffd9f
     b48:	6576455f 	ldrbvs	r4, [r6, #-1375]!	; 0xfffffaa1
     b4c:	445f746e 	ldrbmi	r7, [pc], #-1134	; b54 <shift+0xb54>
     b50:	63657465 	cmnvs	r5, #1694498816	; 0x65000000
     b54:	6e6f6974 			; <UNDEFINED> instruction: 0x6e6f6974
     b58:	6f687300 	svcvs	0x00687300
     b5c:	69207472 	stmdbvs	r0!, {r1, r4, r5, r6, sl, ip, sp, lr}
     b60:	4d00746e 	cfstrsmi	mvf7, [r0, #-440]	; 0xfffffe48
     b64:	69467861 	stmdbvs	r6, {r0, r5, r6, fp, ip, sp, lr}^
     b68:	616e656c 	cmnvs	lr, ip, ror #10
     b6c:	654c656d 	strbvs	r6, [ip, #-1389]	; 0xfffffa93
     b70:	6874676e 	ldmdavs	r4!, {r1, r2, r3, r5, r6, r8, r9, sl, sp, lr}^
     b74:	72504300 	subsvc	r4, r0, #0, 6
     b78:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     b7c:	614d5f73 	hvcvs	54771	; 0xd5f3
     b80:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     b84:	656e0072 	strbvs	r0, [lr, #-114]!	; 0xffffff8e
     b88:	705f7478 	subsvc	r7, pc, r8, ror r4	; <UNPREDICTABLE>
     b8c:	69646572 	stmdbvs	r4!, {r1, r4, r5, r6, r8, sl, sp, lr}^
     b90:	74007463 	strvc	r7, [r0], #-1123	; 0xfffffb9d
     b94:	30726274 	rsbscc	r6, r2, r4, ror r2
     b98:	74657300 	strbtvc	r7, [r5], #-768	; 0xfffffd00
     b9c:	6c6f725f 	sfmvs	f7, 2, [pc], #-380	; a28 <shift+0xa28>
     ba0:	4e007365 	cdpmi	3, 0, cr7, cr0, cr5, {3}
     ba4:	5f495753 	svcpl	0x00495753
     ba8:	656c6946 	strbvs	r6, [ip, #-2374]!	; 0xfffff6ba
     bac:	74737973 	ldrbtvc	r7, [r3], #-2419	; 0xfffff68d
     bb0:	535f6d65 	cmppl	pc, #6464	; 0x1940
     bb4:	69767265 	ldmdbvs	r6!, {r0, r2, r5, r6, r9, ip, sp, lr}^
     bb8:	4e006563 	cfsh32mi	mvfx6, mvfx0, #51
     bbc:	5f495753 	svcpl	0x00495753
     bc0:	636f7250 	cmnvs	pc, #80, 4
     bc4:	5f737365 	svcpl	0x00737365
     bc8:	76726553 			; <UNDEFINED> instruction: 0x76726553
     bcc:	00656369 	rsbeq	r6, r5, r9, ror #6
     bd0:	6e65706f 	cdpvs	0, 6, cr7, cr5, cr15, {3}
     bd4:	665f6465 	ldrbvs	r6, [pc], -r5, ror #8
     bd8:	73656c69 	cmnvc	r5, #26880	; 0x6900
     bdc:	65695900 	strbvs	r5, [r9, #-2304]!	; 0xfffff700
     be0:	6400646c 	strvs	r6, [r0], #-1132	; 0xfffffb94
     be4:	64696365 	strbtvs	r6, [r9], #-869	; 0xfffffc9b
     be8:	6f725f65 	svcvs	0x00725f65
     bec:	4900656c 	stmdbmi	r0, {r2, r3, r5, r6, r8, sl, sp, lr}
     bf0:	6665646e 	strbtvs	r6, [r5], -lr, ror #8
     bf4:	74696e69 	strbtvc	r6, [r9], #-3689	; 0xfffff197
     bf8:	65470065 	strbvs	r0, [r7, #-101]	; 0xffffff9b
     bfc:	72505f74 	subsvc	r5, r0, #116, 30	; 0x1d0
     c00:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     c04:	79425f73 	stmdbvc	r2, {r0, r1, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     c08:	4449505f 	strbmi	r5, [r9], #-95	; 0xffffffa1
     c0c:	616e4500 	cmnvs	lr, r0, lsl #10
     c10:	5f656c62 	svcpl	0x00656c62
     c14:	6e657645 	cdpvs	6, 6, cr7, cr5, cr5, {2}
     c18:	65445f74 	strbvs	r5, [r4, #-3956]	; 0xfffff08c
     c1c:	74636574 	strbtvc	r6, [r3], #-1396	; 0xfffffa8c
     c20:	006e6f69 	rsbeq	r6, lr, r9, ror #30
     c24:	69726550 	ldmdbvs	r2!, {r4, r6, r8, sl, sp, lr}^
     c28:	72656870 	rsbvc	r6, r5, #112, 16	; 0x700000
     c2c:	425f6c61 	subsmi	r6, pc, #24832	; 0x6100
     c30:	00657361 	rsbeq	r7, r5, r1, ror #6
     c34:	49534544 	ldmdbmi	r3, {r2, r6, r8, sl, lr}^
     c38:	5f444552 	svcpl	0x00444552
     c3c:	454c4f52 	strbmi	r4, [ip, #-3922]	; 0xfffff0ae
     c40:	6e6f6c00 	cdpvs	12, 6, cr6, cr15, cr0, {0}
     c44:	6e752067 	cdpvs	0, 7, cr2, cr5, cr7, {3}
     c48:	6e676973 			; <UNDEFINED> instruction: 0x6e676973
     c4c:	69206465 	stmdbvs	r0!, {r0, r2, r5, r6, sl, sp, lr}
     c50:	6100746e 	tstvs	r0, lr, ror #8
     c54:	65726464 	ldrbvs	r6, [r2, #-1124]!	; 0xfffffb9c
     c58:	49007373 	stmdbmi	r0, {r0, r1, r4, r5, r6, r8, r9, ip, sp, lr}
     c5c:	6c61766e 	stclvs	6, cr7, [r1], #-440	; 0xfffffe48
     c60:	505f6469 	subspl	r6, pc, r9, ror #8
     c64:	4c006e69 	stcmi	14, cr6, [r0], {105}	; 0x69
     c68:	5f6b636f 	svcpl	0x006b636f
     c6c:	6b636f4c 	blvs	18dc9a4 <__bss_end+0x18d2c18>
     c70:	5f006465 	svcpl	0x00006465
     c74:	36314e5a 			; <UNDEFINED> instruction: 0x36314e5a
     c78:	6f725043 	svcvs	0x00725043
     c7c:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     c80:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     c84:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     c88:	61483831 	cmpvs	r8, r1, lsr r8
     c8c:	656c646e 	strbvs	r6, [ip, #-1134]!	; 0xfffffb92
     c90:	6f72505f 	svcvs	0x0072505f
     c94:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     c98:	4957535f 	ldmdbmi	r7, {r0, r1, r2, r3, r4, r6, r8, r9, ip, lr}^
     c9c:	4e303245 	cdpmi	2, 3, cr3, cr0, cr5, {2}
     ca0:	5f495753 	svcpl	0x00495753
     ca4:	636f7250 	cmnvs	pc, #80, 4
     ca8:	5f737365 	svcpl	0x00737365
     cac:	76726553 			; <UNDEFINED> instruction: 0x76726553
     cb0:	6a656369 	bvs	1959a5c <__bss_end+0x194fcd0>
     cb4:	31526a6a 	cmpcc	r2, sl, ror #20
     cb8:	57535431 	smmlarpl	r3, r1, r4, r5
     cbc:	65525f49 	ldrbvs	r5, [r2, #-3913]	; 0xfffff0b7
     cc0:	746c7573 	strbtvc	r7, [ip], #-1395	; 0xfffffa8d
     cc4:	315a5f00 	cmpcc	sl, r0, lsl #30
     cc8:	63657232 	cmnvs	r5, #536870915	; 0x20000003
     ccc:	65766965 	ldrbvs	r6, [r6, #-2405]!	; 0xfffff69b
     cd0:	7461645f 	strbtvc	r6, [r1], #-1119	; 0xfffffba1
     cd4:	73007661 	movwvc	r7, #1633	; 0x661
     cd8:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     cdc:	756f635f 	strbvc	r6, [pc, #-863]!	; 985 <shift+0x985>
     ce0:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
     ce4:	50505500 	subspl	r5, r0, r0, lsl #10
     ce8:	425f5245 	subsmi	r5, pc, #1342177284	; 0x50000004
     cec:	444e554f 	strbmi	r5, [lr], #-1359	; 0xfffffab1
     cf0:	74654700 	strbtvc	r4, [r5], #-1792	; 0xfffff900
     cf4:	7261505f 	rsbvc	r5, r1, #95	; 0x5f
     cf8:	00736d61 	rsbseq	r6, r3, r1, ror #26
     cfc:	69736e75 	ldmdbvs	r3!, {r0, r2, r4, r5, r6, r9, sl, fp, sp, lr}^
     d00:	64656e67 	strbtvs	r6, [r5], #-3687	; 0xfffff199
     d04:	61686320 	cmnvs	r8, r0, lsr #6
     d08:	5a5f0072 	bpl	17c0ed8 <__bss_end+0x17b714c>
     d0c:	65727038 	ldrbvs	r7, [r2, #-56]!	; 0xffffffc8
     d10:	736d5f70 	cmnvc	sp, #112, 30	; 0x1c0
     d14:	50635067 	rsbpl	r5, r3, r7, rrx
     d18:	4900634b 	stmdbmi	r0, {r0, r1, r3, r6, r8, r9, sp, lr}
     d1c:	535f4332 	cmppl	pc, #-939524096	; 0xc8000000
     d20:	4556414c 	ldrbmi	r4, [r6, #-332]	; 0xfffffeb4
     d24:	7361425f 	cmnvc	r1, #-268435451	; 0xf0000005
     d28:	6e490065 	cdpvs	0, 4, cr0, cr9, cr5, {3}
     d2c:	72726574 	rsbsvc	r6, r2, #116, 10	; 0x1d000000
     d30:	61747075 	cmnvs	r4, r5, ror r0
     d34:	5f656c62 	svcpl	0x00656c62
     d38:	65656c53 	strbvs	r6, [r5, #-3155]!	; 0xfffff3ad
     d3c:	63530070 	cmpvs	r3, #112	; 0x70
     d40:	75646568 	strbvc	r6, [r4, #-1384]!	; 0xfffffa98
     d44:	525f656c 	subspl	r6, pc, #108, 10	; 0x1b000000
     d48:	55410052 	strbpl	r0, [r1, #-82]	; 0xffffffae
     d4c:	61425f58 	cmpvs	r2, r8, asr pc
     d50:	42006573 	andmi	r6, r0, #482344960	; 0x1cc00000
     d54:	5f324353 	svcpl	0x00324353
     d58:	65736142 	ldrbvs	r6, [r3, #-322]!	; 0xfffffebe
     d5c:	395a5f00 	ldmdbcc	sl, {r8, r9, sl, fp, ip, lr}^
     d60:	5f746573 	svcpl	0x00746573
     d64:	656c6f72 	strbvs	r6, [ip, #-3954]!	; 0xfffff08e
     d68:	49433973 	stmdbmi	r3, {r0, r1, r4, r5, r6, r8, fp, ip, sp}^
     d6c:	4d5f4332 	ldclmi	3, cr4, [pc, #-200]	; cac <shift+0xcac>
     d70:	0065646f 	rsbeq	r6, r5, pc, ror #8
     d74:	646e6168 	strbtvs	r6, [lr], #-360	; 0xfffffe98
     d78:	645f656c 	ldrbvs	r6, [pc], #-1388	; d80 <shift+0xd80>
     d7c:	00617461 	rsbeq	r7, r1, r1, ror #8
     d80:	646e6172 	strbtvs	r6, [lr], #-370	; 0xfffffe8e
     d84:	765f6d6f 	ldrbvc	r6, [pc], -pc, ror #26
     d88:	65756c61 	ldrbvs	r6, [r5, #-3169]!	; 0xfffff39f
     d8c:	72570073 	subsvc	r0, r7, #115	; 0x73
     d90:	5f657469 	svcpl	0x00657469
     d94:	796c6e4f 	stmdbvc	ip!, {r0, r1, r2, r3, r6, r9, sl, fp, sp, lr}^
     d98:	68635300 	stmdavs	r3!, {r8, r9, ip, lr}^
     d9c:	6c756465 	cfldrdvs	mvd6, [r5], #-404	; 0xfffffe6c
     da0:	69540065 	ldmdbvs	r4, {r0, r2, r5, r6}^
     da4:	435f6b63 	cmpmi	pc, #101376	; 0x18c00
     da8:	746e756f 	strbtvc	r7, [lr], #-1391	; 0xfffffa91
     dac:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     db0:	50433631 	subpl	r3, r3, r1, lsr r6
     db4:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     db8:	4d5f7373 	ldclmi	3, cr7, [pc, #-460]	; bf4 <shift+0xbf4>
     dbc:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
     dc0:	38317265 	ldmdacc	r1!, {r0, r2, r5, r6, r9, ip, sp, lr}
     dc4:	616d6e55 	cmnvs	sp, r5, asr lr
     dc8:	69465f70 	stmdbvs	r6, {r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     dcc:	435f656c 	cmpmi	pc, #108, 10	; 0x1b000000
     dd0:	65727275 	ldrbvs	r7, [r2, #-629]!	; 0xfffffd8b
     dd4:	6a45746e 	bvs	115df94 <__bss_end+0x1154208>
     dd8:	43324900 	teqmi	r2, #0, 18
     ddc:	414c535f 	cmpmi	ip, pc, asr r3
     de0:	425f4556 	subsmi	r4, pc, #360710144	; 0x15800000
     de4:	65666675 	strbvs	r6, [r6, #-1653]!	; 0xfffff98b
     de8:	69535f72 	ldmdbvs	r3, {r1, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     dec:	4800657a 	stmdami	r0, {r1, r3, r4, r5, r6, r8, sl, sp, lr}
     df0:	6c646e61 	stclvs	14, cr6, [r4], #-388	; 0xfffffe7c
     df4:	69465f65 	stmdbvs	r6, {r0, r2, r5, r6, r8, r9, sl, fp, ip, lr}^
     df8:	7973656c 	ldmdbvc	r3!, {r2, r3, r5, r6, r8, sl, sp, lr}^
     dfc:	6d657473 	cfstrdvs	mvd7, [r5, #-460]!	; 0xfffffe34
     e00:	4957535f 	ldmdbmi	r7, {r0, r1, r2, r3, r4, r6, r8, r9, ip, lr}^
     e04:	6f687300 	svcvs	0x00687300
     e08:	75207472 	strvc	r7, [r0, #-1138]!	; 0xfffffb8e
     e0c:	6769736e 	strbvs	r7, [r9, -lr, ror #6]!
     e10:	2064656e 	rsbcs	r6, r4, lr, ror #10
     e14:	00746e69 	rsbseq	r6, r4, r9, ror #28
     e18:	76657270 			; <UNDEFINED> instruction: 0x76657270
     e1c:	6c61765f 	stclvs	6, cr7, [r1], #-380	; 0xfffffe84
     e20:	6d006575 	cfstr32vs	mvfx6, [r0, #-468]	; 0xfffffe2c
     e24:	006e6961 	rsbeq	r6, lr, r1, ror #18
     e28:	30315a5f 	eorscc	r5, r1, pc, asr sl
     e2c:	646e6573 	strbtvs	r6, [lr], #-1395	; 0xfffffa8d
     e30:	6c61765f 	stclvs	6, cr7, [r1], #-380	; 0xfffffe84
     e34:	00666575 	rsbeq	r6, r6, r5, ror r5
     e38:	67726174 			; <UNDEFINED> instruction: 0x67726174
     e3c:	64417465 	strbvs	r7, [r1], #-1125	; 0xfffffb9b
     e40:	73736572 	cmnvc	r3, #478150656	; 0x1c800000
     e44:	746e4900 	strbtvc	r4, [lr], #-2304	; 0xfffff700
     e48:	75727265 	ldrbvc	r7, [r2, #-613]!	; 0xfffffd9b
     e4c:	435f7470 	cmpmi	pc, #112, 8	; 0x70000000
     e50:	72746e6f 	rsbsvc	r6, r4, #1776	; 0x6f0
     e54:	656c6c6f 	strbvs	r6, [ip, #-3183]!	; 0xfffff391
     e58:	61425f72 	hvcvs	9714	; 0x25f2
     e5c:	72006573 	andvc	r6, r0, #482344960	; 0x1cc00000
     e60:	69656365 	stmdbvs	r5!, {r0, r2, r5, r6, r8, r9, sp, lr}^
     e64:	5f646576 	svcpl	0x00646576
     e68:	756c6176 	strbvc	r6, [ip, #-374]!	; 0xfffffe8a
     e6c:	52007365 	andpl	r7, r0, #-1811939327	; 0x94000001
     e70:	5f646165 	svcpl	0x00646165
     e74:	74697257 	strbtvc	r7, [r9], #-599	; 0xfffffda9
     e78:	63410065 	movtvs	r0, #4197	; 0x1065
     e7c:	65766974 	ldrbvs	r6, [r6, #-2420]!	; 0xfffff68c
     e80:	6f72505f 	svcvs	0x0072505f
     e84:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     e88:	756f435f 	strbvc	r4, [pc, #-863]!	; b31 <shift+0xb31>
     e8c:	5f00746e 	svcpl	0x0000746e
     e90:	36314e5a 			; <UNDEFINED> instruction: 0x36314e5a
     e94:	6f725043 	svcvs	0x00725043
     e98:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     e9c:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     ea0:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     ea4:	61483132 	cmpvs	r8, r2, lsr r1
     ea8:	656c646e 	strbvs	r6, [ip, #-1134]!	; 0xfffffb92
     eac:	6c69465f 	stclvs	6, cr4, [r9], #-380	; 0xfffffe84
     eb0:	73797365 	cmnvc	r9, #-1811939327	; 0x94000001
     eb4:	5f6d6574 	svcpl	0x006d6574
     eb8:	45495753 	strbmi	r5, [r9, #-1875]	; 0xfffff8ad
     ebc:	534e3332 	movtpl	r3, #58162	; 0xe332
     ec0:	465f4957 			; <UNDEFINED> instruction: 0x465f4957
     ec4:	73656c69 	cmnvc	r5, #26880	; 0x6900
     ec8:	65747379 	ldrbvs	r7, [r4, #-889]!	; 0xfffffc87
     ecc:	65535f6d 	ldrbvs	r5, [r3, #-3949]	; 0xfffff093
     ed0:	63697672 	cmnvs	r9, #119537664	; 0x7200000
     ed4:	6a6a6a65 	bvs	1a9b870 <__bss_end+0x1a91ae4>
     ed8:	54313152 	ldrtpl	r3, [r1], #-338	; 0xfffffeae
     edc:	5f495753 	svcpl	0x00495753
     ee0:	75736552 	ldrbvc	r6, [r3, #-1362]!	; 0xfffffaae
     ee4:	2f00746c 	svccs	0x0000746c
     ee8:	72657355 	rsbvc	r7, r5, #1409286145	; 0x54000001
     eec:	69772f73 	ldmdbvs	r7!, {r0, r1, r4, r5, r6, r8, r9, sl, fp, sp}^
     ef0:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
     ef4:	442f696a 	strtmi	r6, [pc], #-2410	; efc <shift+0xefc>
     ef8:	746b7365 	strbtvc	r7, [fp], #-869	; 0xfffffc9b
     efc:	462f706f 	strtmi	r7, [pc], -pc, rrx
     f00:	4e2f5641 	cfmadda32mi	mvax2, mvax5, mvfx15, mvfx1
     f04:	7a617661 	bvc	185e890 <__bss_end+0x1854b04>
     f08:	63696a75 	cmnvs	r9, #479232	; 0x75000
     f0c:	534f2f69 	movtpl	r2, #65385	; 0xff69
     f10:	6d65732f 	stclvs	3, cr7, [r5, #-188]!	; 0xffffff44
     f14:	72747365 	rsbsvc	r7, r4, #-1811939327	; 0x94000001
     f18:	616b6c61 	cmnvs	fp, r1, ror #24
     f1c:	76696b2d 	strbtvc	r6, [r9], -sp, lsr #22
     f20:	2f736f2d 	svccs	0x00736f2d
     f24:	72756f73 	rsbsvc	r6, r5, #460	; 0x1cc
     f28:	2f736563 	svccs	0x00736563
     f2c:	6c697562 	cfstr64vs	mvdx7, [r9], #-392	; 0xfffffe78
     f30:	6c630064 	stclvs	0, cr0, [r3], #-400	; 0xfffffe70
     f34:	0065736f 	rsbeq	r7, r5, pc, ror #6
     f38:	5f746553 	svcpl	0x00746553
     f3c:	616c6552 	cmnvs	ip, r2, asr r5
     f40:	65766974 	ldrbvs	r6, [r6, #-2420]!	; 0xfffff68c
     f44:	74657200 	strbtvc	r7, [r5], #-512	; 0xfffffe00
     f48:	006c6176 	rsbeq	r6, ip, r6, ror r1
     f4c:	7275636e 	rsbsvc	r6, r5, #-1207959551	; 0xb8000001
     f50:	70697000 	rsbvc	r7, r9, r0
     f54:	64720065 	ldrbtvs	r0, [r2], #-101	; 0xffffff9b
     f58:	006d756e 	rsbeq	r7, sp, lr, ror #10
     f5c:	31315a5f 	teqcc	r1, pc, asr sl
     f60:	65686373 	strbvs	r6, [r8, #-883]!	; 0xfffffc8d
     f64:	69795f64 	ldmdbvs	r9!, {r2, r5, r6, r8, r9, sl, fp, ip, lr}^
     f68:	76646c65 	strbtvc	r6, [r4], -r5, ror #24
     f6c:	315a5f00 	cmpcc	sl, r0, lsl #30
     f70:	74657337 	strbtvc	r7, [r5], #-823	; 0xfffffcc9
     f74:	7361745f 	cmnvc	r1, #1593835520	; 0x5f000000
     f78:	65645f6b 	strbvs	r5, [r4, #-3947]!	; 0xfffff095
     f7c:	696c6461 	stmdbvs	ip!, {r0, r5, r6, sl, sp, lr}^
     f80:	006a656e 	rsbeq	r6, sl, lr, ror #10
     f84:	74696177 	strbtvc	r6, [r9], #-375	; 0xfffffe89
     f88:	365a5f00 	ldrbcc	r5, [sl], -r0, lsl #30
     f8c:	69746f6e 	ldmdbvs	r4!, {r1, r2, r3, r5, r6, r8, r9, sl, fp, sp, lr}^
     f90:	6a6a7966 	bvs	1a9f530 <__bss_end+0x1a957a4>
     f94:	69614600 	stmdbvs	r1!, {r9, sl, lr}^
     f98:	7865006c 	stmdavc	r5!, {r2, r3, r5, r6}^
     f9c:	6f637469 	svcvs	0x00637469
     fa0:	73006564 	movwvc	r6, #1380	; 0x564
     fa4:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     fa8:	6569795f 	strbvs	r7, [r9, #-2399]!	; 0xfffff6a1
     fac:	7400646c 	strvc	r6, [r0], #-1132	; 0xfffffb94
     fb0:	5f6b6369 	svcpl	0x006b6369
     fb4:	6e756f63 	cdpvs	15, 7, cr6, cr5, cr3, {3}
     fb8:	65725f74 	ldrbvs	r5, [r2, #-3956]!	; 0xfffff08c
     fbc:	72697571 	rsbvc	r7, r9, #473956352	; 0x1c400000
     fc0:	5f006465 	svcpl	0x00006465
     fc4:	6734325a 			; <UNDEFINED> instruction: 0x6734325a
     fc8:	615f7465 	cmpvs	pc, r5, ror #8
     fcc:	76697463 	strbtvc	r7, [r9], -r3, ror #8
     fd0:	72705f65 	rsbsvc	r5, r0, #404	; 0x194
     fd4:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     fd8:	6f635f73 	svcvs	0x00635f73
     fdc:	76746e75 			; <UNDEFINED> instruction: 0x76746e75
     fe0:	70695000 	rsbvc	r5, r9, r0
     fe4:	69465f65 	stmdbvs	r6, {r0, r2, r5, r6, r8, r9, sl, fp, ip, lr}^
     fe8:	505f656c 	subspl	r6, pc, ip, ror #10
     fec:	69666572 	stmdbvs	r6!, {r1, r4, r5, r6, r8, sl, sp, lr}^
     ff0:	5a5f0078 	bpl	17c11d8 <__bss_end+0x17b744c>
     ff4:	65673431 	strbvs	r3, [r7, #-1073]!	; 0xfffffbcf
     ff8:	69745f74 	ldmdbvs	r4!, {r2, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     ffc:	635f6b63 	cmpvs	pc, #101376	; 0x18c00
    1000:	746e756f 	strbtvc	r7, [lr], #-1391	; 0xfffffa91
    1004:	6c730076 	ldclvs	0, cr0, [r3], #-472	; 0xfffffe28
    1008:	00706565 	rsbseq	r6, r0, r5, ror #10
    100c:	74395a5f 	ldrtvc	r5, [r9], #-2655	; 0xfffff5a1
    1010:	696d7265 	stmdbvs	sp!, {r0, r2, r5, r6, r9, ip, sp, lr}^
    1014:	6574616e 	ldrbvs	r6, [r4, #-366]!	; 0xfffffe92
    1018:	706f0069 	rsbvc	r0, pc, r9, rrx
    101c:	74617265 	strbtvc	r7, [r1], #-613	; 0xfffffd9b
    1020:	006e6f69 	rsbeq	r6, lr, r9, ror #30
    1024:	63355a5f 	teqvs	r5, #389120	; 0x5f000
    1028:	65736f6c 	ldrbvs	r6, [r3, #-3948]!	; 0xfffff094
    102c:	5a5f006a 	bpl	17c11dc <__bss_end+0x17b7450>
    1030:	74656736 	strbtvc	r6, [r5], #-1846	; 0xfffff8ca
    1034:	76646970 			; <UNDEFINED> instruction: 0x76646970
    1038:	616e6600 	cmnvs	lr, r0, lsl #12
    103c:	7700656d 	strvc	r6, [r0, -sp, ror #10]
    1040:	65746972 	ldrbvs	r6, [r4, #-2418]!	; 0xfffff68e
    1044:	63697400 	cmnvs	r9, #0, 8
    1048:	6f00736b 	svcvs	0x0000736b
    104c:	006e6570 	rsbeq	r6, lr, r0, ror r5
    1050:	70345a5f 	eorsvc	r5, r4, pc, asr sl
    1054:	50657069 	rsbpl	r7, r5, r9, rrx
    1058:	006a634b 	rsbeq	r6, sl, fp, asr #6
    105c:	6165444e 	cmnvs	r5, lr, asr #8
    1060:	6e696c64 	cdpvs	12, 6, cr6, cr9, cr4, {3}
    1064:	75535f65 	ldrbvc	r5, [r3, #-3941]	; 0xfffff09b
    1068:	72657362 	rsbvc	r7, r5, #-2013265919	; 0x88000001
    106c:	65636976 	strbvs	r6, [r3, #-2422]!	; 0xfffff68a
    1070:	74656700 	strbtvc	r6, [r5], #-1792	; 0xfffff900
    1074:	6369745f 	cmnvs	r9, #1593835520	; 0x5f000000
    1078:	6f635f6b 	svcvs	0x00635f6b
    107c:	00746e75 	rsbseq	r6, r4, r5, ror lr
    1080:	61726170 	cmnvs	r2, r0, ror r1
    1084:	5a5f006d 	bpl	17c1240 <__bss_end+0x17b74b4>
    1088:	69727735 	ldmdbvs	r2!, {r0, r2, r4, r5, r8, r9, sl, ip, sp, lr}^
    108c:	506a6574 	rsbpl	r6, sl, r4, ror r5
    1090:	006a634b 	rsbeq	r6, sl, fp, asr #6
    1094:	5f746567 	svcpl	0x00746567
    1098:	6b736174 	blvs	1cd9670 <__bss_end+0x1ccf8e4>
    109c:	6369745f 	cmnvs	r9, #1593835520	; 0x5f000000
    10a0:	745f736b 	ldrbvc	r7, [pc], #-875	; 10a8 <shift+0x10a8>
    10a4:	65645f6f 	strbvs	r5, [r4, #-3951]!	; 0xfffff091
    10a8:	696c6461 	stmdbvs	ip!, {r0, r5, r6, sl, sp, lr}^
    10ac:	6200656e 	andvs	r6, r0, #461373440	; 0x1b800000
    10b0:	735f6675 	cmpvc	pc, #122683392	; 0x7500000
    10b4:	00657a69 	rsbeq	r7, r5, r9, ror #20
    10b8:	5f746573 	svcpl	0x00746573
    10bc:	6b736174 	blvs	1cd9694 <__bss_end+0x1ccf908>
    10c0:	6165645f 	cmnvs	r5, pc, asr r4
    10c4:	6e696c64 	cdpvs	12, 6, cr6, cr9, cr4, {3}
    10c8:	552f0065 	strpl	r0, [pc, #-101]!	; 106b <shift+0x106b>
    10cc:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
    10d0:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
    10d4:	6a726574 	bvs	1c9a6ac <__bss_end+0x1c90920>
    10d8:	65442f69 	strbvs	r2, [r4, #-3945]	; 0xfffff097
    10dc:	6f746b73 	svcvs	0x00746b73
    10e0:	41462f70 	hvcmi	25328	; 0x62f0
    10e4:	614e2f56 	cmpvs	lr, r6, asr pc
    10e8:	757a6176 	ldrbvc	r6, [sl, #-374]!	; 0xfffffe8a
    10ec:	6963696a 	stmdbvs	r3!, {r1, r3, r5, r6, r8, fp, sp, lr}^
    10f0:	2f534f2f 	svccs	0x00534f2f
    10f4:	656d6573 	strbvs	r6, [sp, #-1395]!	; 0xfffffa8d
    10f8:	61727473 	cmnvs	r2, r3, ror r4
    10fc:	2d616b6c 	vstmdbcs	r1!, {d22-<overflow reg d75>}
    1100:	2d76696b 			; <UNDEFINED> instruction: 0x2d76696b
    1104:	732f736f 			; <UNDEFINED> instruction: 0x732f736f
    1108:	6372756f 	cmnvs	r2, #465567744	; 0x1bc00000
    110c:	732f7365 			; <UNDEFINED> instruction: 0x732f7365
    1110:	696c6474 	stmdbvs	ip!, {r2, r4, r5, r6, sl, sp, lr}^
    1114:	72732f62 	rsbsvc	r2, r3, #392	; 0x188
    1118:	74732f63 	ldrbtvc	r2, [r3], #-3939	; 0xfffff09d
    111c:	6c696664 	stclvs	6, cr6, [r9], #-400	; 0xfffffe70
    1120:	70632e65 	rsbvc	r2, r3, r5, ror #28
    1124:	5a5f0070 	bpl	17c12ec <__bss_end+0x17b7560>
    1128:	656c7335 	strbvs	r7, [ip, #-821]!	; 0xfffffccb
    112c:	6a6a7065 	bvs	1a9d2c8 <__bss_end+0x1a9353c>
    1130:	6c696600 	stclvs	6, cr6, [r9], #-0
    1134:	65470065 	strbvs	r0, [r7, #-101]	; 0xffffff9b
    1138:	65525f74 	ldrbvs	r5, [r2, #-3956]	; 0xfffff08c
    113c:	6e69616d 	powvsez	f6, f1, #5.0
    1140:	00676e69 	rsbeq	r6, r7, r9, ror #28
    1144:	36325a5f 			; <UNDEFINED> instruction: 0x36325a5f
    1148:	5f746567 	svcpl	0x00746567
    114c:	6b736174 	blvs	1cd9724 <__bss_end+0x1ccf998>
    1150:	6369745f 	cmnvs	r9, #1593835520	; 0x5f000000
    1154:	745f736b 	ldrbvc	r7, [pc], #-875	; 115c <shift+0x115c>
    1158:	65645f6f 	strbvs	r5, [r4, #-3951]!	; 0xfffff091
    115c:	696c6461 	stmdbvs	ip!, {r0, r5, r6, sl, sp, lr}^
    1160:	0076656e 	rsbseq	r6, r6, lr, ror #10
    1164:	4957534e 	ldmdbmi	r7, {r1, r2, r3, r6, r8, r9, ip, lr}^
    1168:	7365525f 	cmnvc	r5, #-268435451	; 0xf0000005
    116c:	5f746c75 	svcpl	0x00746c75
    1170:	65646f43 	strbvs	r6, [r4, #-3907]!	; 0xfffff0bd
    1174:	6e727700 	cdpvs	7, 7, cr7, cr2, cr0, {0}
    1178:	5f006d75 	svcpl	0x00006d75
    117c:	6177345a 	cmnvs	r7, sl, asr r4
    1180:	6a6a7469 	bvs	1a9e32c <__bss_end+0x1a945a0>
    1184:	5a5f006a 	bpl	17c1334 <__bss_end+0x17b75a8>
    1188:	636f6935 	cmnvs	pc, #868352	; 0xd4000
    118c:	316a6c74 	smccc	42692	; 0xa6c4
    1190:	4f494e36 	svcmi	0x00494e36
    1194:	5f6c7443 	svcpl	0x006c7443
    1198:	7265704f 	rsbvc	r7, r5, #79	; 0x4f
    119c:	6f697461 	svcvs	0x00697461
    11a0:	0076506e 	rsbseq	r5, r6, lr, rrx
    11a4:	74636f69 	strbtvc	r6, [r3], #-3945	; 0xfffff097
    11a8:	6572006c 	ldrbvs	r0, [r2, #-108]!	; 0xffffff94
    11ac:	746e6374 	strbtvc	r6, [lr], #-884	; 0xfffffc8c
    11b0:	746f6e00 	strbtvc	r6, [pc], #-3584	; 11b8 <shift+0x11b8>
    11b4:	00796669 	rsbseq	r6, r9, r9, ror #12
    11b8:	6d726574 	cfldr64vs	mvdx6, [r2, #-464]!	; 0xfffffe30
    11bc:	74616e69 	strbtvc	r6, [r1], #-3689	; 0xfffff197
    11c0:	6f6d0065 	svcvs	0x006d0065
    11c4:	62006564 	andvs	r6, r0, #100, 10	; 0x19000000
    11c8:	65666675 	strbvs	r6, [r6, #-1653]!	; 0xfffff98b
    11cc:	5a5f0072 	bpl	17c139c <__bss_end+0x17b7610>
    11d0:	61657234 	cmnvs	r5, r4, lsr r2
    11d4:	63506a64 	cmpvs	r0, #100, 20	; 0x64000
    11d8:	4e47006a 	cdpmi	0, 4, cr0, cr7, cr10, {3}
    11dc:	2b432055 	blcs	10c9338 <__bss_end+0x10bf5ac>
    11e0:	2034312b 	eorscs	r3, r4, fp, lsr #2
    11e4:	332e3031 			; <UNDEFINED> instruction: 0x332e3031
    11e8:	3220312e 	eorcc	r3, r0, #-2147483637	; 0x8000000b
    11ec:	30313230 	eorscc	r3, r1, r0, lsr r2
    11f0:	20343238 	eorscs	r3, r4, r8, lsr r2
    11f4:	6c657228 	sfmvs	f7, 2, [r5], #-160	; 0xffffff60
    11f8:	65736165 	ldrbvs	r6, [r3, #-357]!	; 0xfffffe9b
    11fc:	6d2d2029 	stcvs	0, cr2, [sp, #-164]!	; 0xffffff5c
    1200:	616f6c66 	cmnvs	pc, r6, ror #24
    1204:	62612d74 	rsbvs	r2, r1, #116, 26	; 0x1d00
    1208:	61683d69 	cmnvs	r8, r9, ror #26
    120c:	2d206472 	cfstrscs	mvf6, [r0, #-456]!	; 0xfffffe38
    1210:	7570666d 	ldrbvc	r6, [r0, #-1645]!	; 0xfffff993
    1214:	7066763d 	rsbvc	r7, r6, sp, lsr r6
    1218:	666d2d20 	strbtvs	r2, [sp], -r0, lsr #26
    121c:	74616f6c 	strbtvc	r6, [r1], #-3948	; 0xfffff094
    1220:	6962612d 	stmdbvs	r2!, {r0, r2, r3, r5, r8, sp, lr}^
    1224:	7261683d 	rsbvc	r6, r1, #3997696	; 0x3d0000
    1228:	6d2d2064 	stcvs	0, cr2, [sp, #-400]!	; 0xfffffe70
    122c:	3d757066 	ldclcc	0, cr7, [r5, #-408]!	; 0xfffffe68
    1230:	20706676 	rsbscs	r6, r0, r6, ror r6
    1234:	75746d2d 	ldrbvc	r6, [r4, #-3373]!	; 0xfffff2d3
    1238:	613d656e 	teqvs	sp, lr, ror #10
    123c:	31316d72 	teqcc	r1, r2, ror sp
    1240:	7a6a3637 	bvc	1a8eb24 <__bss_end+0x1a84d98>
    1244:	20732d66 	rsbscs	r2, r3, r6, ror #26
    1248:	72616d2d 	rsbvc	r6, r1, #2880	; 0xb40
    124c:	6d2d206d 	stcvs	0, cr2, [sp, #-436]!	; 0xfffffe4c
    1250:	68637261 	stmdavs	r3!, {r0, r5, r6, r9, ip, sp, lr}^
    1254:	6d72613d 	ldfvse	f6, [r2, #-244]!	; 0xffffff0c
    1258:	6b7a3676 	blvs	1e8ec38 <__bss_end+0x1e84eac>
    125c:	2070662b 	rsbscs	r6, r0, fp, lsr #12
    1260:	2d20672d 	stccs	7, cr6, [r0, #-180]!	; 0xffffff4c
    1264:	672d2067 	strvs	r2, [sp, -r7, rrx]!
    1268:	304f2d20 	subcc	r2, pc, r0, lsr #26
    126c:	304f2d20 	subcc	r2, pc, r0, lsr #26
    1270:	6e662d20 	cdpvs	13, 6, cr2, cr6, cr0, {1}
    1274:	78652d6f 	stmdavc	r5!, {r0, r1, r2, r3, r5, r6, r8, sl, fp, sp}^
    1278:	74706563 	ldrbtvc	r6, [r0], #-1379	; 0xfffffa9d
    127c:	736e6f69 	cmnvc	lr, #420	; 0x1a4
    1280:	6e662d20 	cdpvs	13, 6, cr2, cr6, cr0, {1}
    1284:	74722d6f 	ldrbtvc	r2, [r2], #-3439	; 0xfffff291
    1288:	72006974 	andvc	r6, r0, #116, 18	; 0x1d0000
    128c:	6f637465 	svcvs	0x00637465
    1290:	67006564 	strvs	r6, [r0, -r4, ror #10]
    1294:	615f7465 	cmpvs	pc, r5, ror #8
    1298:	76697463 	strbtvc	r7, [r9], -r3, ror #8
    129c:	72705f65 	rsbsvc	r5, r0, #404	; 0x194
    12a0:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
    12a4:	6f635f73 	svcvs	0x00635f73
    12a8:	00746e75 	rsbseq	r6, r4, r5, ror lr
    12ac:	656c6966 	strbvs	r6, [ip, #-2406]!	; 0xfffff69a
    12b0:	656d616e 	strbvs	r6, [sp, #-366]!	; 0xfffffe92
    12b4:	61657200 	cmnvs	r5, r0, lsl #4
    12b8:	65670064 	strbvs	r0, [r7, #-100]!	; 0xffffff9c
    12bc:	64697074 	strbtvs	r7, [r9], #-116	; 0xffffff8c
    12c0:	345a5f00 	ldrbcc	r5, [sl], #-3840	; 0xfffff100
    12c4:	6e65706f 	cdpvs	0, 6, cr7, cr5, cr15, {3}
    12c8:	31634b50 	cmncc	r3, r0, asr fp
    12cc:	69464e35 	stmdbvs	r6, {r0, r2, r4, r5, r9, sl, fp, lr}^
    12d0:	4f5f656c 	svcmi	0x005f656c
    12d4:	5f6e6570 	svcpl	0x006e6570
    12d8:	65646f4d 	strbvs	r6, [r4, #-3917]!	; 0xfffff0b3
    12dc:	365a5f00 	ldrbcc	r5, [sl], -r0, lsl #30
    12e0:	636d656d 	cmnvs	sp, #457179136	; 0x1b400000
    12e4:	4b507970 	blmi	141f8ac <__bss_end+0x1415b20>
    12e8:	69765076 	ldmdbvs	r6!, {r1, r2, r4, r5, r6, ip, lr}^
    12ec:	345a5f00 	ldrbcc	r5, [sl], #-3840	; 0xfffff100
    12f0:	616f7469 	cmnvs	pc, r9, ror #8
    12f4:	6a63506a 	bvs	18d54a4 <__bss_end+0x18cb718>
    12f8:	6f746100 	svcvs	0x00746100
    12fc:	74730069 	ldrbtvc	r0, [r3], #-105	; 0xffffff97
    1300:	6e656c72 	mcrvs	12, 3, r6, cr5, cr2, {3}
    1304:	6e6f6300 	cdpvs	3, 6, cr6, cr15, cr0, {0}
    1308:	00746163 	rsbseq	r6, r4, r3, ror #2
    130c:	74736564 	ldrbtvc	r6, [r3], #-1380	; 0xfffffa9c
    1310:	706e6900 	rsbvc	r6, lr, r0, lsl #18
    1314:	62007475 	andvs	r7, r0, #1962934272	; 0x75000000
    1318:	00657361 	rsbeq	r7, r5, r1, ror #6
    131c:	616f7469 	cmnvs	pc, r9, ror #8
    1320:	746e6900 	strbtvc	r6, [lr], #-2304	; 0xfffff700
    1324:	7274705f 	rsbsvc	r7, r4, #95	; 0x5f
    1328:	355a5f00 	ldrbcc	r5, [sl, #-3840]	; 0xfffff100
    132c:	72657a62 	rsbvc	r7, r5, #401408	; 0x62000
    1330:	6976506f 	ldmdbvs	r6!, {r0, r1, r2, r3, r5, r6, ip, lr}^
    1334:	72747300 	rsbsvc	r7, r4, #0, 6
    1338:	7970636e 	ldmdbvc	r0!, {r1, r2, r3, r5, r6, r8, r9, sp, lr}^
    133c:	375a5f00 	ldrbcc	r5, [sl, -r0, lsl #30]
    1340:	6e727473 	mrcvs	4, 3, r7, cr2, cr3, {3}
    1344:	50797063 	rsbspl	r7, r9, r3, rrx
    1348:	634b5063 	movtvs	r5, #45155	; 0xb063
    134c:	6e690069 	cdpvs	0, 6, cr0, cr9, cr9, {3}
    1350:	61705f74 	cmnvs	r0, r4, ror pc
    1354:	66007472 			; <UNDEFINED> instruction: 0x66007472
    1358:	74636172 	strbtvc	r6, [r3], #-370	; 0xfffffe8e
    135c:	006e6f69 	rsbeq	r6, lr, r9, ror #30
    1360:	69676964 	stmdbvs	r7!, {r2, r5, r6, r8, fp, sp, lr}^
    1364:	5a5f0074 	bpl	17c153c <__bss_end+0x17b77b0>
    1368:	6e6f6336 	mcrvs	3, 3, r6, cr15, cr6, {1}
    136c:	50746163 	rsbspl	r6, r4, r3, ror #2
    1370:	634b5063 	movtvs	r5, #45155	; 0xb063
    1374:	6d656d00 	stclvs	13, cr6, [r5, #-0]
    1378:	00747364 	rsbseq	r7, r4, r4, ror #6
    137c:	72616843 	rsbvc	r6, r1, #4390912	; 0x430000
    1380:	766e6f43 	strbtvc	r6, [lr], -r3, asr #30
    1384:	00727241 	rsbseq	r7, r2, r1, asr #4
    1388:	616f7466 	cmnvs	pc, r6, ror #8
    138c:	6d656d00 	stclvs	13, cr6, [r5, #-0]
    1390:	00637273 	rsbeq	r7, r3, r3, ror r2
    1394:	72657a62 	rsbvc	r7, r5, #401408	; 0x62000
    1398:	656d006f 	strbvs	r0, [sp, #-111]!	; 0xffffff91
    139c:	7970636d 	ldmdbvc	r0!, {r0, r2, r3, r5, r6, r8, r9, sp, lr}^
    13a0:	72747300 	rsbsvc	r7, r4, #0, 6
    13a4:	706d636e 	rsbvc	r6, sp, lr, ror #6
    13a8:	63656400 	cmnvs	r5, #0, 8
    13ac:	6c616d69 	stclvs	13, cr6, [r1], #-420	; 0xfffffe5c
    13b0:	616c705f 	qdsubvs	r7, pc, ip	; <UNPREDICTABLE>
    13b4:	00736563 	rsbseq	r6, r3, r3, ror #10
    13b8:	61345a5f 	teqvs	r4, pc, asr sl
    13bc:	50696f74 	rsbpl	r6, r9, r4, ror pc
    13c0:	6f00634b 	svcvs	0x0000634b
    13c4:	75707475 	ldrbvc	r7, [r0, #-1141]!	; 0xfffffb8b
    13c8:	5a5f0074 	bpl	17c15a0 <__bss_end+0x17b7814>
    13cc:	6f746634 	svcvs	0x00746634
    13d0:	63506661 	cmpvs	r0, #101711872	; 0x6100000
    13d4:	5a5f006a 	bpl	17c1584 <__bss_end+0x17b77f8>
    13d8:	72747336 	rsbsvc	r7, r4, #-671088640	; 0xd8000000
    13dc:	506e656c 	rsbpl	r6, lr, ip, ror #10
    13e0:	5f00634b 	svcpl	0x0000634b
    13e4:	7473375a 	ldrbtvc	r3, [r3], #-1882	; 0xfffff8a6
    13e8:	6d636e72 	stclvs	14, cr6, [r3, #-456]!	; 0xfffffe38
    13ec:	634b5070 	movtvs	r5, #45168	; 0xb070
    13f0:	695f3053 	ldmdbvs	pc, {r0, r1, r4, r6, ip, sp}^	; <UNPREDICTABLE>
    13f4:	746e6900 	strbtvc	r6, [lr], #-2304	; 0xfffff700
    13f8:	7274735f 	rsbsvc	r7, r4, #2080374785	; 0x7c000001
    13fc:	6d656d00 	stclvs	13, cr6, [r5, #-0]
    1400:	0079726f 	rsbseq	r7, r9, pc, ror #4
    1404:	676e656c 	strbvs	r6, [lr, -ip, ror #10]!
    1408:	2f006874 	svccs	0x00006874
    140c:	72657355 	rsbvc	r7, r5, #1409286145	; 0x54000001
    1410:	69772f73 	ldmdbvs	r7!, {r0, r1, r4, r5, r6, r8, r9, sl, fp, sp}^
    1414:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
    1418:	442f696a 	strtmi	r6, [pc], #-2410	; 1420 <shift+0x1420>
    141c:	746b7365 	strbtvc	r7, [fp], #-869	; 0xfffffc9b
    1420:	462f706f 	strtmi	r7, [pc], -pc, rrx
    1424:	4e2f5641 	cfmadda32mi	mvax2, mvax5, mvfx15, mvfx1
    1428:	7a617661 	bvc	185edb4 <__bss_end+0x1855028>
    142c:	63696a75 	cmnvs	r9, #479232	; 0x75000
    1430:	534f2f69 	movtpl	r2, #65385	; 0xff69
    1434:	6d65732f 	stclvs	3, cr7, [r5, #-188]!	; 0xffffff44
    1438:	72747365 	rsbsvc	r7, r4, #-1811939327	; 0x94000001
    143c:	616b6c61 	cmnvs	fp, r1, ror #24
    1440:	76696b2d 	strbtvc	r6, [r9], -sp, lsr #22
    1444:	2f736f2d 	svccs	0x00736f2d
    1448:	72756f73 	rsbsvc	r6, r5, #460	; 0x1cc
    144c:	2f736563 	svccs	0x00736563
    1450:	6c647473 	cfstrdvs	mvd7, [r4], #-460	; 0xfffffe34
    1454:	732f6269 			; <UNDEFINED> instruction: 0x732f6269
    1458:	732f6372 			; <UNDEFINED> instruction: 0x732f6372
    145c:	74736474 	ldrbtvc	r6, [r3], #-1140	; 0xfffffb8c
    1460:	676e6972 			; <UNDEFINED> instruction: 0x676e6972
    1464:	7070632e 	rsbsvc	r6, r0, lr, lsr #6
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
  20:	8b040e42 	blhi	103930 <__bss_end+0xf9ba4>
  24:	0b0d4201 	bleq	350830 <__bss_end+0x346aa4>
  28:	420d0d62 	andmi	r0, sp, #6272	; 0x1880
  2c:	00000ecb 	andeq	r0, r0, fp, asr #29
  30:	0000001c 	andeq	r0, r0, ip, lsl r0
  34:	00000000 	andeq	r0, r0, r0
  38:	00008064 	andeq	r8, r0, r4, rrx
  3c:	00000040 	andeq	r0, r0, r0, asr #32
  40:	8b080e42 	blhi	203950 <__bss_end+0x1f9bc4>
  44:	42018e02 	andmi	r8, r1, #2, 28
  48:	5a040b0c 	bpl	102c80 <__bss_end+0xf8ef4>
  4c:	00080d0c 	andeq	r0, r8, ip, lsl #26
  50:	0000000c 	andeq	r0, r0, ip
  54:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
  58:	7c020001 	stcvc	0, cr0, [r2], {1}
  5c:	000d0c0e 	andeq	r0, sp, lr, lsl #24
  60:	0000001c 	andeq	r0, r0, ip, lsl r0
  64:	00000050 	andeq	r0, r0, r0, asr r0
  68:	000080a4 	andeq	r8, r0, r4, lsr #1
  6c:	00000038 	andeq	r0, r0, r8, lsr r0
  70:	8b040e42 	blhi	103980 <__bss_end+0xf9bf4>
  74:	0b0d4201 	bleq	350880 <__bss_end+0x346af4>
  78:	420d0d54 	andmi	r0, sp, #84, 26	; 0x1500
  7c:	00000ecb 	andeq	r0, r0, fp, asr #29
  80:	0000001c 	andeq	r0, r0, ip, lsl r0
  84:	00000050 	andeq	r0, r0, r0, asr r0
  88:	000080dc 	ldrdeq	r8, [r0], -ip
  8c:	0000002c 	andeq	r0, r0, ip, lsr #32
  90:	8b040e42 	blhi	1039a0 <__bss_end+0xf9c14>
  94:	0b0d4201 	bleq	3508a0 <__bss_end+0x346b14>
  98:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
  9c:	00000ecb 	andeq	r0, r0, fp, asr #29
  a0:	0000001c 	andeq	r0, r0, ip, lsl r0
  a4:	00000050 	andeq	r0, r0, r0, asr r0
  a8:	00008108 	andeq	r8, r0, r8, lsl #2
  ac:	00000020 	andeq	r0, r0, r0, lsr #32
  b0:	8b040e42 	blhi	1039c0 <__bss_end+0xf9c34>
  b4:	0b0d4201 	bleq	3508c0 <__bss_end+0x346b34>
  b8:	420d0d48 	andmi	r0, sp, #72, 26	; 0x1200
  bc:	00000ecb 	andeq	r0, r0, fp, asr #29
  c0:	0000001c 	andeq	r0, r0, ip, lsl r0
  c4:	00000050 	andeq	r0, r0, r0, asr r0
  c8:	00008128 	andeq	r8, r0, r8, lsr #2
  cc:	00000018 	andeq	r0, r0, r8, lsl r0
  d0:	8b040e42 	blhi	1039e0 <__bss_end+0xf9c54>
  d4:	0b0d4201 	bleq	3508e0 <__bss_end+0x346b54>
  d8:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
  dc:	00000ecb 	andeq	r0, r0, fp, asr #29
  e0:	0000001c 	andeq	r0, r0, ip, lsl r0
  e4:	00000050 	andeq	r0, r0, r0, asr r0
  e8:	00008140 	andeq	r8, r0, r0, asr #2
  ec:	00000018 	andeq	r0, r0, r8, lsl r0
  f0:	8b040e42 	blhi	103a00 <__bss_end+0xf9c74>
  f4:	0b0d4201 	bleq	350900 <__bss_end+0x346b74>
  f8:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
  fc:	00000ecb 	andeq	r0, r0, fp, asr #29
 100:	0000001c 	andeq	r0, r0, ip, lsl r0
 104:	00000050 	andeq	r0, r0, r0, asr r0
 108:	00008158 	andeq	r8, r0, r8, asr r1
 10c:	00000018 	andeq	r0, r0, r8, lsl r0
 110:	8b040e42 	blhi	103a20 <__bss_end+0xf9c94>
 114:	0b0d4201 	bleq	350920 <__bss_end+0x346b94>
 118:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
 11c:	00000ecb 	andeq	r0, r0, fp, asr #29
 120:	00000014 	andeq	r0, r0, r4, lsl r0
 124:	00000050 	andeq	r0, r0, r0, asr r0
 128:	00008170 	andeq	r8, r0, r0, ror r1
 12c:	0000000c 	andeq	r0, r0, ip
 130:	8b040e42 	blhi	103a40 <__bss_end+0xf9cb4>
 134:	0b0d4201 	bleq	350940 <__bss_end+0x346bb4>
 138:	0000001c 	andeq	r0, r0, ip, lsl r0
 13c:	00000050 	andeq	r0, r0, r0, asr r0
 140:	0000817c 	andeq	r8, r0, ip, ror r1
 144:	00000058 	andeq	r0, r0, r8, asr r0
 148:	8b080e42 	blhi	203a58 <__bss_end+0x1f9ccc>
 14c:	42018e02 	andmi	r8, r1, #2, 28
 150:	62040b0c 	andvs	r0, r4, #12, 22	; 0x3000
 154:	00080d0c 	andeq	r0, r8, ip, lsl #26
 158:	0000001c 	andeq	r0, r0, ip, lsl r0
 15c:	00000050 	andeq	r0, r0, r0, asr r0
 160:	000081d4 	ldrdeq	r8, [r0], -r4
 164:	00000058 	andeq	r0, r0, r8, asr r0
 168:	8b080e42 	blhi	203a78 <__bss_end+0x1f9cec>
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
 194:	000000ac 	andeq	r0, r0, ip, lsr #1
 198:	840c0e42 	strhi	r0, [ip], #-3650	; 0xfffff1be
 19c:	8e028b03 	vmlahi.f64	d8, d2, d3
 1a0:	0b0c4201 	bleq	3109ac <__bss_end+0x306c20>
 1a4:	0c480204 	sfmeq	f0, 2, [r8], {4}
 1a8:	00000c0d 	andeq	r0, r0, sp, lsl #24
 1ac:	00000028 	andeq	r0, r0, r8, lsr #32
 1b0:	00000178 	andeq	r0, r0, r8, ror r1
 1b4:	000082d8 	ldrdeq	r8, [r0], -r8	; <UNPREDICTABLE>
 1b8:	000000e8 	andeq	r0, r0, r8, ror #1
 1bc:	841c0e42 	ldrhi	r0, [ip], #-3650	; 0xfffff1be
 1c0:	86068507 	strhi	r8, [r6], -r7, lsl #10
 1c4:	88048705 	stmdahi	r4, {r0, r2, r8, r9, sl, pc}
 1c8:	8e028b03 	vmlahi.f64	d8, d2, d3
 1cc:	0b0c4201 	bleq	3109d8 <__bss_end+0x306c4c>
 1d0:	0c6c0204 	sfmeq	f0, 2, [ip], #-16
 1d4:	00001c0d 	andeq	r1, r0, sp, lsl #24
 1d8:	00000020 	andeq	r0, r0, r0, lsr #32
 1dc:	00000178 	andeq	r0, r0, r8, ror r1
 1e0:	000083c0 	andeq	r8, r0, r0, asr #7
 1e4:	00000074 	andeq	r0, r0, r4, ror r0
 1e8:	840c0e42 	strhi	r0, [ip], #-3650	; 0xfffff1be
 1ec:	8e028b03 	vmlahi.f64	d8, d2, d3
 1f0:	0b0c4201 	bleq	3109fc <__bss_end+0x306c70>
 1f4:	0d0c7204 	sfmeq	f7, 4, [ip, #-16]
 1f8:	0000000c 	andeq	r0, r0, ip
 1fc:	0000001c 	andeq	r0, r0, ip, lsl r0
 200:	00000178 	andeq	r0, r0, r8, ror r1
 204:	00008434 	andeq	r8, r0, r4, lsr r4
 208:	000000fc 	strdeq	r0, [r0], -ip
 20c:	8b080e42 	blhi	203b1c <__bss_end+0x1f9d90>
 210:	42018e02 	andmi	r8, r1, #2, 28
 214:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 218:	080d0c6e 	stmdaeq	sp, {r1, r2, r3, r5, r6, sl, fp}
 21c:	0000001c 	andeq	r0, r0, ip, lsl r0
 220:	00000178 	andeq	r0, r0, r8, ror r1
 224:	00008530 	andeq	r8, r0, r0, lsr r5
 228:	000000a4 	andeq	r0, r0, r4, lsr #1
 22c:	8b080e42 	blhi	203b3c <__bss_end+0x1f9db0>
 230:	42018e02 	andmi	r8, r1, #2, 28
 234:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 238:	080d0c48 	stmdaeq	sp, {r3, r6, sl, fp}
 23c:	0000001c 	andeq	r0, r0, ip, lsl r0
 240:	00000178 	andeq	r0, r0, r8, ror r1
 244:	000085d4 	ldrdeq	r8, [r0], -r4
 248:	000000f8 	strdeq	r0, [r0], -r8
 24c:	8b080e42 	blhi	203b5c <__bss_end+0x1f9dd0>
 250:	42018e02 	andmi	r8, r1, #2, 28
 254:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 258:	080d0c70 	stmdaeq	sp, {r4, r5, r6, sl, fp}
 25c:	0000001c 	andeq	r0, r0, ip, lsl r0
 260:	00000178 	andeq	r0, r0, r8, ror r1
 264:	000086cc 	andeq	r8, r0, ip, asr #13
 268:	000001d0 	ldrdeq	r0, [r0], -r0	; <UNPREDICTABLE>
 26c:	8b080e42 	blhi	203b7c <__bss_end+0x1f9df0>
 270:	42018e02 	andmi	r8, r1, #2, 28
 274:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 278:	080d0cd4 	stmdaeq	sp, {r2, r4, r6, r7, sl, fp}
 27c:	0000001c 	andeq	r0, r0, ip, lsl r0
 280:	00000178 	andeq	r0, r0, r8, ror r1
 284:	0000889c 	muleq	r0, ip, r8
 288:	00000114 	andeq	r0, r0, r4, lsl r1
 28c:	8b080e42 	blhi	203b9c <__bss_end+0x1f9e10>
 290:	42018e02 	andmi	r8, r1, #2, 28
 294:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 298:	080d0c7a 	stmdaeq	sp, {r1, r3, r4, r5, r6, sl, fp}
 29c:	0000001c 	andeq	r0, r0, ip, lsl r0
 2a0:	00000178 	andeq	r0, r0, r8, ror r1
 2a4:	000089b0 			; <UNDEFINED> instruction: 0x000089b0
 2a8:	000000c0 	andeq	r0, r0, r0, asr #1
 2ac:	8b080e42 	blhi	203bbc <__bss_end+0x1f9e30>
 2b0:	42018e02 	andmi	r8, r1, #2, 28
 2b4:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 2b8:	080d0c58 	stmdaeq	sp, {r3, r4, r6, sl, fp}
 2bc:	00000018 	andeq	r0, r0, r8, lsl r0
 2c0:	00000178 	andeq	r0, r0, r8, ror r1
 2c4:	00008a70 	andeq	r8, r0, r0, ror sl
 2c8:	00000040 	andeq	r0, r0, r0, asr #32
 2cc:	8b080e42 	blhi	203bdc <__bss_end+0x1f9e50>
 2d0:	42018e02 	andmi	r8, r1, #2, 28
 2d4:	00040b0c 	andeq	r0, r4, ip, lsl #22
 2d8:	00000018 	andeq	r0, r0, r8, lsl r0
 2dc:	00000178 	andeq	r0, r0, r8, ror r1
 2e0:	00008ab0 			; <UNDEFINED> instruction: 0x00008ab0
 2e4:	00000074 	andeq	r0, r0, r4, ror r0
 2e8:	8b080e42 	blhi	203bf8 <__bss_end+0x1f9e6c>
 2ec:	42018e02 	andmi	r8, r1, #2, 28
 2f0:	00040b0c 	andeq	r0, r4, ip, lsl #22
 2f4:	0000001c 	andeq	r0, r0, ip, lsl r0
 2f8:	00000178 	andeq	r0, r0, r8, ror r1
 2fc:	00008b24 	andeq	r8, r0, r4, lsr #22
 300:	0000017c 	andeq	r0, r0, ip, ror r1
 304:	8b080e42 	blhi	203c14 <__bss_end+0x1f9e88>
 308:	42018e02 	andmi	r8, r1, #2, 28
 30c:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 310:	080d0ca4 	stmdaeq	sp, {r2, r5, r7, sl, fp}
 314:	0000000c 	andeq	r0, r0, ip
 318:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 31c:	7c020001 	stcvc	0, cr0, [r2], {1}
 320:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 324:	0000001c 	andeq	r0, r0, ip, lsl r0
 328:	00000314 	andeq	r0, r0, r4, lsl r3
 32c:	00008ca0 	andeq	r8, r0, r0, lsr #25
 330:	0000002c 	andeq	r0, r0, ip, lsr #32
 334:	8b040e42 	blhi	103c44 <__bss_end+0xf9eb8>
 338:	0b0d4201 	bleq	350b44 <__bss_end+0x346db8>
 33c:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
 340:	00000ecb 	andeq	r0, r0, fp, asr #29
 344:	0000001c 	andeq	r0, r0, ip, lsl r0
 348:	00000314 	andeq	r0, r0, r4, lsl r3
 34c:	00008ccc 	andeq	r8, r0, ip, asr #25
 350:	0000002c 	andeq	r0, r0, ip, lsr #32
 354:	8b040e42 	blhi	103c64 <__bss_end+0xf9ed8>
 358:	0b0d4201 	bleq	350b64 <__bss_end+0x346dd8>
 35c:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
 360:	00000ecb 	andeq	r0, r0, fp, asr #29
 364:	0000001c 	andeq	r0, r0, ip, lsl r0
 368:	00000314 	andeq	r0, r0, r4, lsl r3
 36c:	00008cf8 	strdeq	r8, [r0], -r8	; <UNPREDICTABLE>
 370:	0000001c 	andeq	r0, r0, ip, lsl r0
 374:	8b040e42 	blhi	103c84 <__bss_end+0xf9ef8>
 378:	0b0d4201 	bleq	350b84 <__bss_end+0x346df8>
 37c:	420d0d46 	andmi	r0, sp, #4480	; 0x1180
 380:	00000ecb 	andeq	r0, r0, fp, asr #29
 384:	0000001c 	andeq	r0, r0, ip, lsl r0
 388:	00000314 	andeq	r0, r0, r4, lsl r3
 38c:	00008d14 	andeq	r8, r0, r4, lsl sp
 390:	00000044 	andeq	r0, r0, r4, asr #32
 394:	8b040e42 	blhi	103ca4 <__bss_end+0xf9f18>
 398:	0b0d4201 	bleq	350ba4 <__bss_end+0x346e18>
 39c:	420d0d5a 	andmi	r0, sp, #5760	; 0x1680
 3a0:	00000ecb 	andeq	r0, r0, fp, asr #29
 3a4:	0000001c 	andeq	r0, r0, ip, lsl r0
 3a8:	00000314 	andeq	r0, r0, r4, lsl r3
 3ac:	00008d58 	andeq	r8, r0, r8, asr sp
 3b0:	00000050 	andeq	r0, r0, r0, asr r0
 3b4:	8b040e42 	blhi	103cc4 <__bss_end+0xf9f38>
 3b8:	0b0d4201 	bleq	350bc4 <__bss_end+0x346e38>
 3bc:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 3c0:	00000ecb 	andeq	r0, r0, fp, asr #29
 3c4:	0000001c 	andeq	r0, r0, ip, lsl r0
 3c8:	00000314 	andeq	r0, r0, r4, lsl r3
 3cc:	00008da8 	andeq	r8, r0, r8, lsr #27
 3d0:	00000050 	andeq	r0, r0, r0, asr r0
 3d4:	8b040e42 	blhi	103ce4 <__bss_end+0xf9f58>
 3d8:	0b0d4201 	bleq	350be4 <__bss_end+0x346e58>
 3dc:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 3e0:	00000ecb 	andeq	r0, r0, fp, asr #29
 3e4:	0000001c 	andeq	r0, r0, ip, lsl r0
 3e8:	00000314 	andeq	r0, r0, r4, lsl r3
 3ec:	00008df8 	strdeq	r8, [r0], -r8	; <UNPREDICTABLE>
 3f0:	0000002c 	andeq	r0, r0, ip, lsr #32
 3f4:	8b040e42 	blhi	103d04 <__bss_end+0xf9f78>
 3f8:	0b0d4201 	bleq	350c04 <__bss_end+0x346e78>
 3fc:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
 400:	00000ecb 	andeq	r0, r0, fp, asr #29
 404:	0000001c 	andeq	r0, r0, ip, lsl r0
 408:	00000314 	andeq	r0, r0, r4, lsl r3
 40c:	00008e24 	andeq	r8, r0, r4, lsr #28
 410:	00000050 	andeq	r0, r0, r0, asr r0
 414:	8b040e42 	blhi	103d24 <__bss_end+0xf9f98>
 418:	0b0d4201 	bleq	350c24 <__bss_end+0x346e98>
 41c:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 420:	00000ecb 	andeq	r0, r0, fp, asr #29
 424:	0000001c 	andeq	r0, r0, ip, lsl r0
 428:	00000314 	andeq	r0, r0, r4, lsl r3
 42c:	00008e74 	andeq	r8, r0, r4, ror lr
 430:	00000044 	andeq	r0, r0, r4, asr #32
 434:	8b040e42 	blhi	103d44 <__bss_end+0xf9fb8>
 438:	0b0d4201 	bleq	350c44 <__bss_end+0x346eb8>
 43c:	420d0d5a 	andmi	r0, sp, #5760	; 0x1680
 440:	00000ecb 	andeq	r0, r0, fp, asr #29
 444:	0000001c 	andeq	r0, r0, ip, lsl r0
 448:	00000314 	andeq	r0, r0, r4, lsl r3
 44c:	00008eb8 			; <UNDEFINED> instruction: 0x00008eb8
 450:	00000050 	andeq	r0, r0, r0, asr r0
 454:	8b040e42 	blhi	103d64 <__bss_end+0xf9fd8>
 458:	0b0d4201 	bleq	350c64 <__bss_end+0x346ed8>
 45c:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 460:	00000ecb 	andeq	r0, r0, fp, asr #29
 464:	0000001c 	andeq	r0, r0, ip, lsl r0
 468:	00000314 	andeq	r0, r0, r4, lsl r3
 46c:	00008f08 	andeq	r8, r0, r8, lsl #30
 470:	00000054 	andeq	r0, r0, r4, asr r0
 474:	8b040e42 	blhi	103d84 <__bss_end+0xf9ff8>
 478:	0b0d4201 	bleq	350c84 <__bss_end+0x346ef8>
 47c:	420d0d62 	andmi	r0, sp, #6272	; 0x1880
 480:	00000ecb 	andeq	r0, r0, fp, asr #29
 484:	0000001c 	andeq	r0, r0, ip, lsl r0
 488:	00000314 	andeq	r0, r0, r4, lsl r3
 48c:	00008f5c 	andeq	r8, r0, ip, asr pc
 490:	0000003c 	andeq	r0, r0, ip, lsr r0
 494:	8b040e42 	blhi	103da4 <__bss_end+0xfa018>
 498:	0b0d4201 	bleq	350ca4 <__bss_end+0x346f18>
 49c:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 4a0:	00000ecb 	andeq	r0, r0, fp, asr #29
 4a4:	0000001c 	andeq	r0, r0, ip, lsl r0
 4a8:	00000314 	andeq	r0, r0, r4, lsl r3
 4ac:	00008f98 	muleq	r0, r8, pc	; <UNPREDICTABLE>
 4b0:	0000003c 	andeq	r0, r0, ip, lsr r0
 4b4:	8b040e42 	blhi	103dc4 <__bss_end+0xfa038>
 4b8:	0b0d4201 	bleq	350cc4 <__bss_end+0x346f38>
 4bc:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 4c0:	00000ecb 	andeq	r0, r0, fp, asr #29
 4c4:	0000001c 	andeq	r0, r0, ip, lsl r0
 4c8:	00000314 	andeq	r0, r0, r4, lsl r3
 4cc:	00008fd4 	ldrdeq	r8, [r0], -r4
 4d0:	0000003c 	andeq	r0, r0, ip, lsr r0
 4d4:	8b040e42 	blhi	103de4 <__bss_end+0xfa058>
 4d8:	0b0d4201 	bleq	350ce4 <__bss_end+0x346f58>
 4dc:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 4e0:	00000ecb 	andeq	r0, r0, fp, asr #29
 4e4:	0000001c 	andeq	r0, r0, ip, lsl r0
 4e8:	00000314 	andeq	r0, r0, r4, lsl r3
 4ec:	00009010 	andeq	r9, r0, r0, lsl r0
 4f0:	0000003c 	andeq	r0, r0, ip, lsr r0
 4f4:	8b040e42 	blhi	103e04 <__bss_end+0xfa078>
 4f8:	0b0d4201 	bleq	350d04 <__bss_end+0x346f78>
 4fc:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 500:	00000ecb 	andeq	r0, r0, fp, asr #29
 504:	0000001c 	andeq	r0, r0, ip, lsl r0
 508:	00000314 	andeq	r0, r0, r4, lsl r3
 50c:	0000904c 	andeq	r9, r0, ip, asr #32
 510:	000000b0 	strheq	r0, [r0], -r0	; <UNPREDICTABLE>
 514:	8b080e42 	blhi	203e24 <__bss_end+0x1fa098>
 518:	42018e02 	andmi	r8, r1, #2, 28
 51c:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 520:	080d0c50 	stmdaeq	sp, {r4, r6, sl, fp}
 524:	0000000c 	andeq	r0, r0, ip
 528:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 52c:	7c020001 	stcvc	0, cr0, [r2], {1}
 530:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 534:	0000001c 	andeq	r0, r0, ip, lsl r0
 538:	00000524 	andeq	r0, r0, r4, lsr #10
 53c:	000090fc 	strdeq	r9, [r0], -ip
 540:	00000174 	andeq	r0, r0, r4, ror r1
 544:	8b080e42 	blhi	203e54 <__bss_end+0x1fa0c8>
 548:	42018e02 	andmi	r8, r1, #2, 28
 54c:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 550:	080d0cb2 	stmdaeq	sp, {r1, r4, r5, r7, sl, fp}
 554:	0000001c 	andeq	r0, r0, ip, lsl r0
 558:	00000524 	andeq	r0, r0, r4, lsr #10
 55c:	00009270 	andeq	r9, r0, r0, ror r2
 560:	0000009c 	muleq	r0, ip, r0
 564:	8b040e42 	blhi	103e74 <__bss_end+0xfa0e8>
 568:	0b0d4201 	bleq	350d74 <__bss_end+0x346fe8>
 56c:	0d0d4602 	stceq	6, cr4, [sp, #-8]
 570:	000ecb42 	andeq	ip, lr, r2, asr #22
 574:	00000020 	andeq	r0, r0, r0, lsr #32
 578:	00000524 	andeq	r0, r0, r4, lsr #10
 57c:	0000930c 	andeq	r9, r0, ip, lsl #6
 580:	00000294 	muleq	r0, r4, r2
 584:	8b040e42 	blhi	103e94 <__bss_end+0xfa108>
 588:	0b0d4201 	bleq	350d94 <__bss_end+0x347008>
 58c:	0d013e03 	stceq	14, cr3, [r1, #-12]
 590:	0ecb420d 	cdpeq	2, 12, cr4, cr11, cr13, {0}
 594:	00000000 	andeq	r0, r0, r0
 598:	0000001c 	andeq	r0, r0, ip, lsl r0
 59c:	00000524 	andeq	r0, r0, r4, lsr #10
 5a0:	000095a0 	andeq	r9, r0, r0, lsr #11
 5a4:	000000c0 	andeq	r0, r0, r0, asr #1
 5a8:	8b040e42 	blhi	103eb8 <__bss_end+0xfa12c>
 5ac:	0b0d4201 	bleq	350db8 <__bss_end+0x34702c>
 5b0:	0d0d5802 	stceq	8, cr5, [sp, #-8]
 5b4:	000ecb42 	andeq	ip, lr, r2, asr #22
 5b8:	0000001c 	andeq	r0, r0, ip, lsl r0
 5bc:	00000524 	andeq	r0, r0, r4, lsr #10
 5c0:	00009660 	andeq	r9, r0, r0, ror #12
 5c4:	000000ac 	andeq	r0, r0, ip, lsr #1
 5c8:	8b040e42 	blhi	103ed8 <__bss_end+0xfa14c>
 5cc:	0b0d4201 	bleq	350dd8 <__bss_end+0x34704c>
 5d0:	0d0d4e02 	stceq	14, cr4, [sp, #-8]
 5d4:	000ecb42 	andeq	ip, lr, r2, asr #22
 5d8:	0000001c 	andeq	r0, r0, ip, lsl r0
 5dc:	00000524 	andeq	r0, r0, r4, lsr #10
 5e0:	0000970c 	andeq	r9, r0, ip, lsl #14
 5e4:	00000054 	andeq	r0, r0, r4, asr r0
 5e8:	8b040e42 	blhi	103ef8 <__bss_end+0xfa16c>
 5ec:	0b0d4201 	bleq	350df8 <__bss_end+0x34706c>
 5f0:	420d0d62 	andmi	r0, sp, #6272	; 0x1880
 5f4:	00000ecb 	andeq	r0, r0, fp, asr #29
 5f8:	0000001c 	andeq	r0, r0, ip, lsl r0
 5fc:	00000524 	andeq	r0, r0, r4, lsr #10
 600:	00009760 	andeq	r9, r0, r0, ror #14
 604:	00000068 	andeq	r0, r0, r8, rrx
 608:	8b040e42 	blhi	103f18 <__bss_end+0xfa18c>
 60c:	0b0d4201 	bleq	350e18 <__bss_end+0x34708c>
 610:	420d0d6c 	andmi	r0, sp, #108, 26	; 0x1b00
 614:	00000ecb 	andeq	r0, r0, fp, asr #29
 618:	0000001c 	andeq	r0, r0, ip, lsl r0
 61c:	00000524 	andeq	r0, r0, r4, lsr #10
 620:	000097c8 	andeq	r9, r0, r8, asr #15
 624:	00000080 	andeq	r0, r0, r0, lsl #1
 628:	8b040e42 	blhi	103f38 <__bss_end+0xfa1ac>
 62c:	0b0d4201 	bleq	350e38 <__bss_end+0x3470ac>
 630:	420d0d78 	andmi	r0, sp, #120, 26	; 0x1e00
 634:	00000ecb 	andeq	r0, r0, fp, asr #29
 638:	0000001c 	andeq	r0, r0, ip, lsl r0
 63c:	00000524 	andeq	r0, r0, r4, lsr #10
 640:	00009848 	andeq	r9, r0, r8, asr #16
 644:	00000074 	andeq	r0, r0, r4, ror r0
 648:	8b080e42 	blhi	203f58 <__bss_end+0x1fa1cc>
 64c:	42018e02 	andmi	r8, r1, #2, 28
 650:	74040b0c 	strvc	r0, [r4], #-2828	; 0xfffff4f4
 654:	00080d0c 	andeq	r0, r8, ip, lsl #26
 658:	0000000c 	andeq	r0, r0, ip
 65c:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 660:	7c010001 	stcvc	0, cr0, [r1], {1}
 664:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 668:	0000000c 	andeq	r0, r0, ip
 66c:	00000658 	andeq	r0, r0, r8, asr r6
 670:	000098bc 			; <UNDEFINED> instruction: 0x000098bc
 674:	000001ec 	andeq	r0, r0, ip, ror #3
