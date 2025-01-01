
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
    805c:	00009cf0 	strdeq	r9, [r0], -r0
    8060:	00009d90 	muleq	r0, r0, sp

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
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:28
float prev_value = random_values[0];

float received_values[32];
uint32_t received_values_len = 0;

void prep_msg(char* buff, const char* msg) {
    822c:	e92d4810 	push	{r4, fp, lr}
    8230:	e28db008 	add	fp, sp, #8
    8234:	e24dd00c 	sub	sp, sp, #12
    8238:	e50b0010 	str	r0, [fp, #-16]
    823c:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:29
    switch (agreed_role)
    8240:	e59f3080 	ldr	r3, [pc, #128]	; 82c8 <_Z8prep_msgPcPKc+0x9c>
    8244:	e5933000 	ldr	r3, [r3]
    8248:	e3530000 	cmp	r3, #0
    824c:	0a000002 	beq	825c <_Z8prep_msgPcPKc+0x30>
    8250:	e3530001 	cmp	r3, #1
    8254:	0a000005 	beq	8270 <_Z8prep_msgPcPKc+0x44>
    8258:	ea000009 	b	8284 <_Z8prep_msgPcPKc+0x58>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:32
    {
    case CI2C_Mode::Master:
        strncpy(buff, "MASTER: ", 8);
    825c:	e3a02008 	mov	r2, #8
    8260:	e59f1064 	ldr	r1, [pc, #100]	; 82cc <_Z8prep_msgPcPKc+0xa0>
    8264:	e51b0010 	ldr	r0, [fp, #-16]
    8268:	eb0004cc 	bl	95a0 <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:33
        break;
    826c:	ea000009 	b	8298 <_Z8prep_msgPcPKc+0x6c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:35
    case CI2C_Mode::Slave:
        strncpy(buff, "SLAVE: ", 7);
    8270:	e3a02007 	mov	r2, #7
    8274:	e59f1054 	ldr	r1, [pc, #84]	; 82d0 <_Z8prep_msgPcPKc+0xa4>
    8278:	e51b0010 	ldr	r0, [fp, #-16]
    827c:	eb0004c7 	bl	95a0 <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:36
        break;
    8280:	ea000004 	b	8298 <_Z8prep_msgPcPKc+0x6c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:38
    default:
        strncpy(buff, "UNSET: ", 7);
    8284:	e3a02007 	mov	r2, #7
    8288:	e59f1044 	ldr	r1, [pc, #68]	; 82d4 <_Z8prep_msgPcPKc+0xa8>
    828c:	e51b0010 	ldr	r0, [fp, #-16]
    8290:	eb0004c2 	bl	95a0 <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:39
        break;
    8294:	e320f000 	nop	{0}
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:42
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
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:43
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
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:46

void log(const char* msg)
{
    82d8:	e92d49f0 	push	{r4, r5, r6, r7, r8, fp, lr}
    82dc:	e28db018 	add	fp, sp, #24
    82e0:	e24dd014 	sub	sp, sp, #20
    82e4:	e50b0028 	str	r0, [fp, #-40]	; 0xffffffd8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:49
    char new_buff[strlen(msg) + 7];
    prep_msg(new_buff, msg);
    write(log_fd, new_buff, strlen(msg)+7);
    82e8:	e1a0300d 	mov	r3, sp
    82ec:	e1a08003 	mov	r8, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:47
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
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:48
    prep_msg(new_buff, msg);
    8378:	e51b1028 	ldr	r1, [fp, #-40]	; 0xffffffd8
    837c:	e51b0024 	ldr	r0, [fp, #-36]	; 0xffffffdc
    8380:	ebffffa9 	bl	822c <_Z8prep_msgPcPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:49
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
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:50
}
    83b0:	e320f000 	nop	{0}
    83b4:	e24bd018 	sub	sp, fp, #24
    83b8:	e8bd89f0 	pop	{r4, r5, r6, r7, r8, fp, pc}
    83bc:	00009cf0 	strdeq	r9, [r0], -r0

000083c0 <_Z3logj>:
_Z3logj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:52

void log(const uint32_t value) {
    83c0:	e92d4810 	push	{r4, fp, lr}
    83c4:	e28db008 	add	fp, sp, #8
    83c8:	e24dd04c 	sub	sp, sp, #76	; 0x4c
    83cc:	e50b0050 	str	r0, [fp, #-80]	; 0xffffffb0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:54
    char buff[32], pom[32];
    itoa(value, pom, 10);
    83d0:	e24b304c 	sub	r3, fp, #76	; 0x4c
    83d4:	e3a0200a 	mov	r2, #10
    83d8:	e1a01003 	mov	r1, r3
    83dc:	e51b0050 	ldr	r0, [fp, #-80]	; 0xffffffb0
    83e0:	eb000345 	bl	90fc <_Z4itoajPcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:55
    prep_msg(buff, pom);
    83e4:	e24b204c 	sub	r2, fp, #76	; 0x4c
    83e8:	e24b302c 	sub	r3, fp, #44	; 0x2c
    83ec:	e1a01002 	mov	r1, r2
    83f0:	e1a00003 	mov	r0, r3
    83f4:	ebffff8c 	bl	822c <_Z8prep_msgPcPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:56
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
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:57
}
    8424:	e320f000 	nop	{0}
    8428:	e24bd008 	sub	sp, fp, #8
    842c:	e8bd8810 	pop	{r4, fp, pc}
    8430:	00009cf0 	strdeq	r9, [r0], -r0

00008434 <_Z9send_dataf>:
_Z9send_dataf():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:60

void send_data(const float value)
{
    8434:	e92d4800 	push	{fp, lr}
    8438:	e28db004 	add	fp, sp, #4
    843c:	e24dd018 	sub	sp, sp, #24
    8440:	ed0b0a06 	vstr	s0, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:61
    float next_predict = -1.0f;
    8444:	e59f30d8 	ldr	r3, [pc, #216]	; 8524 <_Z9send_dataf+0xf0>
    8448:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:63
    char msg[6];
    if (value < LOWER_BOUND || value > UPPER_BOUND)
    844c:	ed5b7a06 	vldr	s15, [fp, #-24]	; 0xffffffe8
    8450:	ed9f7a31 	vldr	s14, [pc, #196]	; 851c <_Z9send_dataf+0xe8>
    8454:	eef47ac7 	vcmpe.f32	s15, s14
    8458:	eef1fa10 	vmrs	APSR_nzcv, fpscr
    845c:	4a000004 	bmi	8474 <_Z9send_dataf+0x40>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:63 (discriminator 1)
    8460:	ed5b7a06 	vldr	s15, [fp, #-24]	; 0xffffffe8
    8464:	ed9f7a2d 	vldr	s14, [pc, #180]	; 8520 <_Z9send_dataf+0xec>
    8468:	eef47ac7 	vcmpe.f32	s15, s14
    846c:	eef1fa10 	vmrs	APSR_nzcv, fpscr
    8470:	da000002 	ble	8480 <_Z9send_dataf+0x4c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:64
        msg[0] = 'd';
    8474:	e3a03064 	mov	r3, #100	; 0x64
    8478:	e54b3010 	strb	r3, [fp, #-16]
    847c:	ea000015 	b	84d8 <_Z9send_dataf+0xa4>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:67
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
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:68
        if (next_predict < LOWER_BOUND || next_predict > UPPER_BOUND) {
    849c:	ed5b7a02 	vldr	s15, [fp, #-8]
    84a0:	ed9f7a1d 	vldr	s14, [pc, #116]	; 851c <_Z9send_dataf+0xe8>
    84a4:	eef47ac7 	vcmpe.f32	s15, s14
    84a8:	eef1fa10 	vmrs	APSR_nzcv, fpscr
    84ac:	4a000004 	bmi	84c4 <_Z9send_dataf+0x90>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:68 (discriminator 1)
    84b0:	ed5b7a02 	vldr	s15, [fp, #-8]
    84b4:	ed9f7a19 	vldr	s14, [pc, #100]	; 8520 <_Z9send_dataf+0xec>
    84b8:	eef47ac7 	vcmpe.f32	s15, s14
    84bc:	eef1fa10 	vmrs	APSR_nzcv, fpscr
    84c0:	da000002 	ble	84d0 <_Z9send_dataf+0x9c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:69
            msg[0] = 't';
    84c4:	e3a03074 	mov	r3, #116	; 0x74
    84c8:	e54b3010 	strb	r3, [fp, #-16]
    84cc:	ea000001 	b	84d8 <_Z9send_dataf+0xa4>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:72
        }
        else {
            msg[0] = 'v';
    84d0:	e3a03076 	mov	r3, #118	; 0x76
    84d4:	e54b3010 	strb	r3, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:75
        }
    }
    memcpy(&value, msg + 1, 4);
    84d8:	e24b3010 	sub	r3, fp, #16
    84dc:	e2833001 	add	r3, r3, #1
    84e0:	e24b0018 	sub	r0, fp, #24
    84e4:	e3a02004 	mov	r2, #4
    84e8:	e1a01003 	mov	r1, r3
    84ec:	eb0004b5 	bl	97c8 <_Z6memcpyPKvPvi>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:76
    msg[5] = '\0';
    84f0:	e3a03000 	mov	r3, #0
    84f4:	e54b300b 	strb	r3, [fp, #-11]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:77
    write(i2c_fd, msg, 6);
    84f8:	e59f302c 	ldr	r3, [pc, #44]	; 852c <_Z9send_dataf+0xf8>
    84fc:	e5933000 	ldr	r3, [r3]
    8500:	e24b1010 	sub	r1, fp, #16
    8504:	e3a02006 	mov	r2, #6
    8508:	e1a00003 	mov	r0, r3
    850c:	eb000225 	bl	8da8 <_Z5writejPKcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:78
}
    8510:	e320f000 	nop	{0}
    8514:	e24bd004 	sub	sp, fp, #4
    8518:	e8bd8800 	pop	{fp, pc}
    851c:	40600000 	rsbmi	r0, r0, r0
    8520:	41300000 	teqmi	r0, r0
    8524:	bf800000 	svclt	0x00800000
    8528:	00009cec 	andeq	r9, r0, ip, ror #25
    852c:	00009cf8 	strdeq	r9, [r0], -r8

00008530 <_Z10send_valuef>:
_Z10send_valuef():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:80

void send_value(const float value) {
    8530:	e92d4800 	push	{fp, lr}
    8534:	e28db004 	add	fp, sp, #4
    8538:	e24dd030 	sub	sp, sp, #48	; 0x30
    853c:	ed0b0a0c 	vstr	s0, [fp, #-48]	; 0xffffffd0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:82
    char pom[5], buff[32];
    bzero(pom, 5);
    8540:	e24b300c 	sub	r3, fp, #12
    8544:	e3a01005 	mov	r1, #5
    8548:	e1a00003 	mov	r0, r3
    854c:	eb000483 	bl	9760 <_Z5bzeroPvi>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:83
    bzero(buff, 32);
    8550:	e24b302c 	sub	r3, fp, #44	; 0x2c
    8554:	e3a01020 	mov	r1, #32
    8558:	e1a00003 	mov	r0, r3
    855c:	eb00047f 	bl	9760 <_Z5bzeroPvi>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:84
    strncpy(buff, "Sending: ", 15);
    8560:	e24b302c 	sub	r3, fp, #44	; 0x2c
    8564:	e3a0200f 	mov	r2, #15
    8568:	e59f105c 	ldr	r1, [pc, #92]	; 85cc <_Z10send_valuef+0x9c>
    856c:	e1a00003 	mov	r0, r3
    8570:	eb00040a 	bl	95a0 <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:85
    ftoa(value, pom, 2);
    8574:	e24b300c 	sub	r3, fp, #12
    8578:	e3a01002 	mov	r1, #2
    857c:	e1a00003 	mov	r0, r3
    8580:	ed1b0a0c 	vldr	s0, [fp, #-48]	; 0xffffffd0
    8584:	eb000360 	bl	930c <_Z4ftoafPcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:86
    concat(buff, pom);
    8588:	e24b200c 	sub	r2, fp, #12
    858c:	e24b302c 	sub	r3, fp, #44	; 0x2c
    8590:	e1a01002 	mov	r1, r2
    8594:	e1a00003 	mov	r0, r3
    8598:	eb0004aa 	bl	9848 <_Z6concatPcPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:87
    concat(buff, "\n");
    859c:	e24b302c 	sub	r3, fp, #44	; 0x2c
    85a0:	e59f1028 	ldr	r1, [pc, #40]	; 85d0 <_Z10send_valuef+0xa0>
    85a4:	e1a00003 	mov	r0, r3
    85a8:	eb0004a6 	bl	9848 <_Z6concatPcPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:88
    log(buff);
    85ac:	e24b302c 	sub	r3, fp, #44	; 0x2c
    85b0:	e1a00003 	mov	r0, r3
    85b4:	ebffff47 	bl	82d8 <_Z3logPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:89
    send_data(value);
    85b8:	ed1b0a0c 	vldr	s0, [fp, #-48]	; 0xffffffd0
    85bc:	ebffff9c 	bl	8434 <_Z9send_dataf>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:90
}
    85c0:	e320f000 	nop	{0}
    85c4:	e24bd004 	sub	sp, fp, #4
    85c8:	e8bd8800 	pop	{fp, pc}
    85cc:	00009b88 	andeq	r9, r0, r8, lsl #23
    85d0:	00009b94 	muleq	r0, r4, fp

000085d4 <_Z11decide_role9CI2C_ModePc>:
_Z11decide_role9CI2C_ModePc():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:93

CI2C_Mode decide_role(CI2C_Mode my_role, char* other_role_buff)
{
    85d4:	e92d4800 	push	{fp, lr}
    85d8:	e28db004 	add	fp, sp, #4
    85dc:	e24dd010 	sub	sp, sp, #16
    85e0:	e50b0010 	str	r0, [fp, #-16]
    85e4:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:94
    CI2C_Mode other_role = CI2C_Mode::Undefined;
    85e8:	e3a03002 	mov	r3, #2
    85ec:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:95
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
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:97
    {
        other_role = CI2C_Mode::Master;
    861c:	e3a03000 	mov	r3, #0
    8620:	e50b3008 	str	r3, [fp, #-8]
    8624:	ea00000c 	b	865c <_Z11decide_role9CI2C_ModePc+0x88>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:99
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
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:101
    {
        other_role = CI2C_Mode::Slave;
    8654:	e3a03001 	mov	r3, #1
    8658:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:104
    }

    if (my_role == CI2C_Mode::Undefined)
    865c:	e51b3010 	ldr	r3, [fp, #-16]
    8660:	e3530002 	cmp	r3, #2
    8664:	1a000009 	bne	8690 <_Z11decide_role9CI2C_ModePc+0xbc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:106
    {
        if (other_role == CI2C_Mode::Master)
    8668:	e51b3008 	ldr	r3, [fp, #-8]
    866c:	e3530000 	cmp	r3, #0
    8670:	1a000001 	bne	867c <_Z11decide_role9CI2C_ModePc+0xa8>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:108
        {
            return CI2C_Mode::Slave;
    8674:	e3a03001 	mov	r3, #1
    8678:	ea00000d 	b	86b4 <_Z11decide_role9CI2C_ModePc+0xe0>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:110
        }
        else if (other_role == CI2C_Mode::Slave)
    867c:	e51b3008 	ldr	r3, [fp, #-8]
    8680:	e3530001 	cmp	r3, #1
    8684:	1a000009 	bne	86b0 <_Z11decide_role9CI2C_ModePc+0xdc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:112
        {
            return CI2C_Mode::Master;
    8688:	e3a03000 	mov	r3, #0
    868c:	ea000008 	b	86b4 <_Z11decide_role9CI2C_ModePc+0xe0>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:116
        }
    }
    else {
        if (my_role == other_role)
    8690:	e51b2010 	ldr	r2, [fp, #-16]
    8694:	e51b3008 	ldr	r3, [fp, #-8]
    8698:	e1520003 	cmp	r2, r3
    869c:	1a000003 	bne	86b0 <_Z11decide_role9CI2C_ModePc+0xdc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:118
        {
            log("Desired roles are the same\n");
    86a0:	e59f0020 	ldr	r0, [pc, #32]	; 86c8 <_Z11decide_role9CI2C_ModePc+0xf4>
    86a4:	ebffff0b 	bl	82d8 <_Z3logPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:122
            if (ADDRESS < TARGET_ADDRESS)
                return CI2C_Mode::Master;
            else
                return CI2C_Mode::Slave;
    86a8:	e3a03001 	mov	r3, #1
    86ac:	ea000000 	b	86b4 <_Z11decide_role9CI2C_ModePc+0xe0>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:125
        }
    }
    return my_role;
    86b0:	e51b3010 	ldr	r3, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:126
}
    86b4:	e1a00003 	mov	r0, r3
    86b8:	e24bd004 	sub	sp, fp, #4
    86bc:	e8bd8800 	pop	{fp, pc}
    86c0:	00009b98 	muleq	r0, r8, fp
    86c4:	00009b9c 	muleq	r0, ip, fp
    86c8:	00009ba0 	andeq	r9, r0, r0, lsr #23

000086cc <_Z9set_roles9CI2C_Mode>:
_Z9set_roles9CI2C_Mode():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:129

bool set_roles(CI2C_Mode desired_role)
{
    86cc:	e92d4800 	push	{fp, lr}
    86d0:	e28db004 	add	fp, sp, #4
    86d4:	e24dd050 	sub	sp, sp, #80	; 0x50
    86d8:	e50b0050 	str	r0, [fp, #-80]	; 0xffffffb0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:131
    char role[4], buff[32], log_msg[32];
    bzero(role, 4);
    86dc:	e24b3008 	sub	r3, fp, #8
    86e0:	e3a01004 	mov	r1, #4
    86e4:	e1a00003 	mov	r0, r3
    86e8:	eb00041c 	bl	9760 <_Z5bzeroPvi>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:132
    bzero(buff, 32);
    86ec:	e24b3028 	sub	r3, fp, #40	; 0x28
    86f0:	e3a01020 	mov	r1, #32
    86f4:	e1a00003 	mov	r0, r3
    86f8:	eb000418 	bl	9760 <_Z5bzeroPvi>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:133
    bzero(log_msg, 32);
    86fc:	e24b3048 	sub	r3, fp, #72	; 0x48
    8700:	e3a01020 	mov	r1, #32
    8704:	e1a00003 	mov	r0, r3
    8708:	eb000414 	bl	9760 <_Z5bzeroPvi>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:134
    switch (desired_role)
    870c:	e51b3050 	ldr	r3, [fp, #-80]	; 0xffffffb0
    8710:	e3530000 	cmp	r3, #0
    8714:	0a000003 	beq	8728 <_Z9set_roles9CI2C_Mode+0x5c>
    8718:	e51b3050 	ldr	r3, [fp, #-80]	; 0xffffffb0
    871c:	e3530001 	cmp	r3, #1
    8720:	0a000006 	beq	8740 <_Z9set_roles9CI2C_Mode+0x74>
    8724:	ea00000b 	b	8758 <_Z9set_roles9CI2C_Mode+0x8c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:137
    {
    case CI2C_Mode::Master:
        strncpy(role, "mst", 3);
    8728:	e24b3008 	sub	r3, fp, #8
    872c:	e3a02003 	mov	r2, #3
    8730:	e59f1148 	ldr	r1, [pc, #328]	; 8880 <_Z9set_roles9CI2C_Mode+0x1b4>
    8734:	e1a00003 	mov	r0, r3
    8738:	eb000398 	bl	95a0 <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:138
        break;
    873c:	ea00000b 	b	8770 <_Z9set_roles9CI2C_Mode+0xa4>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:140
    case CI2C_Mode::Slave:
        strncpy(role, "slv", 3);
    8740:	e24b3008 	sub	r3, fp, #8
    8744:	e3a02003 	mov	r2, #3
    8748:	e59f1134 	ldr	r1, [pc, #308]	; 8884 <_Z9set_roles9CI2C_Mode+0x1b8>
    874c:	e1a00003 	mov	r0, r3
    8750:	eb000392 	bl	95a0 <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:141
        break;
    8754:	ea000005 	b	8770 <_Z9set_roles9CI2C_Mode+0xa4>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:143
    default:
        strncpy(role, "slv", 3);
    8758:	e24b3008 	sub	r3, fp, #8
    875c:	e3a02003 	mov	r2, #3
    8760:	e59f111c 	ldr	r1, [pc, #284]	; 8884 <_Z9set_roles9CI2C_Mode+0x1b8>
    8764:	e1a00003 	mov	r0, r3
    8768:	eb00038c 	bl	95a0 <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:144
        break;
    876c:	e320f000 	nop	{0}
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:147
    }

    write(i2c_fd, role, 4);
    8770:	e59f3110 	ldr	r3, [pc, #272]	; 8888 <_Z9set_roles9CI2C_Mode+0x1bc>
    8774:	e5933000 	ldr	r3, [r3]
    8778:	e24b1008 	sub	r1, fp, #8
    877c:	e3a02004 	mov	r2, #4
    8780:	e1a00003 	mov	r0, r3
    8784:	eb000187 	bl	8da8 <_Z5writejPKcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:148
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
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:149
        read(i2c_fd, buff, 4);
    87b0:	e59f30d0 	ldr	r3, [pc, #208]	; 8888 <_Z9set_roles9CI2C_Mode+0x1bc>
    87b4:	e5933000 	ldr	r3, [r3]
    87b8:	e24b1028 	sub	r1, fp, #40	; 0x28
    87bc:	e3a02004 	mov	r2, #4
    87c0:	e1a00003 	mov	r0, r3
    87c4:	eb000163 	bl	8d58 <_Z4readjPcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:150
        sleep(0x100);
    87c8:	e3e01001 	mvn	r1, #1
    87cc:	e3a00c01 	mov	r0, #256	; 0x100
    87d0:	eb0001cc 	bl	8f08 <_Z5sleepjj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:148
    while (strlen(buff) == 0) {
    87d4:	eaffffeb 	b	8788 <_Z9set_roles9CI2C_Mode+0xbc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:153
    }

    agreed_role = decide_role(desired_role, buff);
    87d8:	e24b3028 	sub	r3, fp, #40	; 0x28
    87dc:	e1a01003 	mov	r1, r3
    87e0:	e51b0050 	ldr	r0, [fp, #-80]	; 0xffffffb0
    87e4:	ebffff7a 	bl	85d4 <_Z11decide_role9CI2C_ModePc>
    87e8:	e1a03000 	mov	r3, r0
    87ec:	e59f2098 	ldr	r2, [pc, #152]	; 888c <_Z9set_roles9CI2C_Mode+0x1c0>
    87f0:	e5823000 	str	r3, [r2]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:154
    strncpy(log_msg, "Roles set. I am ", 16);
    87f4:	e24b3048 	sub	r3, fp, #72	; 0x48
    87f8:	e3a02010 	mov	r2, #16
    87fc:	e59f108c 	ldr	r1, [pc, #140]	; 8890 <_Z9set_roles9CI2C_Mode+0x1c4>
    8800:	e1a00003 	mov	r0, r3
    8804:	eb000365 	bl	95a0 <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:155
    switch (agreed_role)
    8808:	e59f307c 	ldr	r3, [pc, #124]	; 888c <_Z9set_roles9CI2C_Mode+0x1c0>
    880c:	e5933000 	ldr	r3, [r3]
    8810:	e3530000 	cmp	r3, #0
    8814:	0a000002 	beq	8824 <_Z9set_roles9CI2C_Mode+0x158>
    8818:	e3530001 	cmp	r3, #1
    881c:	0a000005 	beq	8838 <_Z9set_roles9CI2C_Mode+0x16c>
    8820:	ea000009 	b	884c <_Z9set_roles9CI2C_Mode+0x180>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:158
    {
    case CI2C_Mode::Master:
        concat(log_msg, "Master\n");
    8824:	e24b3048 	sub	r3, fp, #72	; 0x48
    8828:	e59f1064 	ldr	r1, [pc, #100]	; 8894 <_Z9set_roles9CI2C_Mode+0x1c8>
    882c:	e1a00003 	mov	r0, r3
    8830:	eb000404 	bl	9848 <_Z6concatPcPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:159
        break;
    8834:	ea000004 	b	884c <_Z9set_roles9CI2C_Mode+0x180>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:161
    case CI2C_Mode::Slave:
        concat(log_msg, "Slave\n");
    8838:	e24b3048 	sub	r3, fp, #72	; 0x48
    883c:	e59f1054 	ldr	r1, [pc, #84]	; 8898 <_Z9set_roles9CI2C_Mode+0x1cc>
    8840:	e1a00003 	mov	r0, r3
    8844:	eb0003ff 	bl	9848 <_Z6concatPcPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:162
        break;
    8848:	e320f000 	nop	{0}
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:164
    }
    log(log_msg);
    884c:	e24b3048 	sub	r3, fp, #72	; 0x48
    8850:	e1a00003 	mov	r0, r3
    8854:	ebfffe9f 	bl	82d8 <_Z3logPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:165
    return agreed_role == desired_role;
    8858:	e59f302c 	ldr	r3, [pc, #44]	; 888c <_Z9set_roles9CI2C_Mode+0x1c0>
    885c:	e5933000 	ldr	r3, [r3]
    8860:	e51b2050 	ldr	r2, [fp, #-80]	; 0xffffffb0
    8864:	e1520003 	cmp	r2, r3
    8868:	03a03001 	moveq	r3, #1
    886c:	13a03000 	movne	r3, #0
    8870:	e6ef3073 	uxtb	r3, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:166
}
    8874:	e1a00003 	mov	r0, r3
    8878:	e24bd004 	sub	sp, fp, #4
    887c:	e8bd8800 	pop	{fp, pc}
    8880:	00009b98 	muleq	r0, r8, fp
    8884:	00009b9c 	muleq	r0, ip, fp
    8888:	00009cf8 	strdeq	r9, [r0], -r8
    888c:	00009ce8 	andeq	r9, r0, r8, ror #25
    8890:	00009bbc 			; <UNDEFINED> instruction: 0x00009bbc
    8894:	00009bd0 	ldrdeq	r9, [r0], -r0
    8898:	00009bd8 	ldrdeq	r9, [r0], -r8

0000889c <_Z11handle_datacf>:
_Z11handle_datacf():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:169

void handle_data(char value_state, float value)
{
    889c:	e92d4800 	push	{fp, lr}
    88a0:	e28db004 	add	fp, sp, #4
    88a4:	e24dd038 	sub	sp, sp, #56	; 0x38
    88a8:	e1a03000 	mov	r3, r0
    88ac:	ed0b0a0f 	vstr	s0, [fp, #-60]	; 0xffffffc4
    88b0:	e54b3035 	strb	r3, [fp, #-53]	; 0xffffffcb
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:171
    char log_msg[32], value_str[16];
    bzero(log_msg, 32);
    88b4:	e24b3024 	sub	r3, fp, #36	; 0x24
    88b8:	e3a01020 	mov	r1, #32
    88bc:	e1a00003 	mov	r0, r3
    88c0:	eb0003a6 	bl	9760 <_Z5bzeroPvi>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:172
    bzero(value_str, 16);
    88c4:	e24b3034 	sub	r3, fp, #52	; 0x34
    88c8:	e3a01010 	mov	r1, #16
    88cc:	e1a00003 	mov	r0, r3
    88d0:	eb0003a2 	bl	9760 <_Z5bzeroPvi>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:173
    strncpy(log_msg, "Received ", 10);
    88d4:	e24b3024 	sub	r3, fp, #36	; 0x24
    88d8:	e3a0200a 	mov	r2, #10
    88dc:	e59f10b8 	ldr	r1, [pc, #184]	; 899c <_Z11handle_datacf+0x100>
    88e0:	e1a00003 	mov	r0, r3
    88e4:	eb00032d 	bl	95a0 <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:174
    ftoa(value, value_str, 2);
    88e8:	e24b3034 	sub	r3, fp, #52	; 0x34
    88ec:	e3a01002 	mov	r1, #2
    88f0:	e1a00003 	mov	r0, r3
    88f4:	ed1b0a0f 	vldr	s0, [fp, #-60]	; 0xffffffc4
    88f8:	eb000283 	bl	930c <_Z4ftoafPcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:175
    concat(log_msg, value_str);
    88fc:	e24b2034 	sub	r2, fp, #52	; 0x34
    8900:	e24b3024 	sub	r3, fp, #36	; 0x24
    8904:	e1a01002 	mov	r1, r2
    8908:	e1a00003 	mov	r0, r3
    890c:	eb0003cd 	bl	9848 <_Z6concatPcPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:176
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
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:180
    {
    case 'v':
        // vse v poradku
        concat(log_msg, " - OK");
    8938:	e24b3024 	sub	r3, fp, #36	; 0x24
    893c:	e59f105c 	ldr	r1, [pc, #92]	; 89a0 <_Z11handle_datacf+0x104>
    8940:	e1a00003 	mov	r0, r3
    8944:	eb0003bf 	bl	9848 <_Z6concatPcPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:181
        break;
    8948:	ea000009 	b	8974 <_Z11handle_datacf+0xd8>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:184
    case 'd':
        // nebezpecna hodnota
        concat(log_msg, " - DANGER");
    894c:	e24b3024 	sub	r3, fp, #36	; 0x24
    8950:	e59f104c 	ldr	r1, [pc, #76]	; 89a4 <_Z11handle_datacf+0x108>
    8954:	e1a00003 	mov	r0, r3
    8958:	eb0003ba 	bl	9848 <_Z6concatPcPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:185
        break;
    895c:	ea000004 	b	8974 <_Z11handle_datacf+0xd8>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:188
    case 't':
        // dalsi hodnota muze byt nebezpecna
        concat(log_msg, " - WARNING");
    8960:	e24b3024 	sub	r3, fp, #36	; 0x24
    8964:	e59f103c 	ldr	r1, [pc, #60]	; 89a8 <_Z11handle_datacf+0x10c>
    8968:	e1a00003 	mov	r0, r3
    896c:	eb0003b5 	bl	9848 <_Z6concatPcPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:189
        break;
    8970:	e320f000 	nop	{0}
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:192
    
    }
    concat(log_msg, "\n");
    8974:	e24b3024 	sub	r3, fp, #36	; 0x24
    8978:	e59f102c 	ldr	r1, [pc, #44]	; 89ac <_Z11handle_datacf+0x110>
    897c:	e1a00003 	mov	r0, r3
    8980:	eb0003b0 	bl	9848 <_Z6concatPcPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:193
    log(log_msg);
    8984:	e24b3024 	sub	r3, fp, #36	; 0x24
    8988:	e1a00003 	mov	r0, r3
    898c:	ebfffe51 	bl	82d8 <_Z3logPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:194
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
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:197

void receive_data()
{
    89b0:	e92d4800 	push	{fp, lr}
    89b4:	e28db004 	add	fp, sp, #4
    89b8:	e24dd030 	sub	sp, sp, #48	; 0x30
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:199
    char buff[6], log_msg[32];
    bzero(buff, 6);
    89bc:	e24b300c 	sub	r3, fp, #12
    89c0:	e3a01006 	mov	r1, #6
    89c4:	e1a00003 	mov	r0, r3
    89c8:	eb000364 	bl	9760 <_Z5bzeroPvi>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:200
    bzero(log_msg, 32);
    89cc:	e24b302c 	sub	r3, fp, #44	; 0x2c
    89d0:	e3a01020 	mov	r1, #32
    89d4:	e1a00003 	mov	r0, r3
    89d8:	eb000360 	bl	9760 <_Z5bzeroPvi>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:204
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
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:205
        read(i2c_fd, buff, 6);
    8a04:	e59f3060 	ldr	r3, [pc, #96]	; 8a6c <_Z12receive_datav+0xbc>
    8a08:	e5933000 	ldr	r3, [r3]
    8a0c:	e24b100c 	sub	r1, fp, #12
    8a10:	e3a02006 	mov	r2, #6
    8a14:	e1a00003 	mov	r0, r3
    8a18:	eb0000ce 	bl	8d58 <_Z4readjPcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:206
        sleep(0x100);
    8a1c:	e3e01001 	mvn	r1, #1
    8a20:	e3a00c01 	mov	r0, #256	; 0x100
    8a24:	eb000137 	bl	8f08 <_Z5sleepjj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:204
    while (strlen(buff) == 0) {
    8a28:	eaffffeb 	b	89dc <_Z12receive_datav+0x2c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:209
    }

    value_state = buff[0];
    8a2c:	e55b300c 	ldrb	r3, [fp, #-12]
    8a30:	e54b3005 	strb	r3, [fp, #-5]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:210
    memcpy(buff + 1, &value, 4);
    8a34:	e24b300c 	sub	r3, fp, #12
    8a38:	e2833001 	add	r3, r3, #1
    8a3c:	e24b1030 	sub	r1, fp, #48	; 0x30
    8a40:	e3a02004 	mov	r2, #4
    8a44:	e1a00003 	mov	r0, r3
    8a48:	eb00035e 	bl	97c8 <_Z6memcpyPKvPvi>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:212

    handle_data(value_state, value);
    8a4c:	ed5b7a0c 	vldr	s15, [fp, #-48]	; 0xffffffd0
    8a50:	e55b3005 	ldrb	r3, [fp, #-5]
    8a54:	eeb00a67 	vmov.f32	s0, s15
    8a58:	e1a00003 	mov	r0, r3
    8a5c:	ebffff8e 	bl	889c <_Z11handle_datacf>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:213
}
    8a60:	e320f000 	nop	{0}
    8a64:	e24bd004 	sub	sp, fp, #4
    8a68:	e8bd8800 	pop	{fp, pc}
    8a6c:	00009cf8 	strdeq	r9, [r0], -r8

00008a70 <_Z11master_taskv>:
_Z11master_taskv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:215

void master_task() {
    8a70:	e92d4800 	push	{fp, lr}
    8a74:	e28db004 	add	fp, sp, #4
    8a78:	e24dd030 	sub	sp, sp, #48	; 0x30
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:219 (discriminator 1)
    char buff[9], msg[32];

    for (;;) {
        bzero(msg, 32);
    8a7c:	e24b3030 	sub	r3, fp, #48	; 0x30
    8a80:	e3a01020 	mov	r1, #32
    8a84:	e1a00003 	mov	r0, r3
    8a88:	eb000334 	bl	9760 <_Z5bzeroPvi>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:220 (discriminator 1)
        bzero(buff, 9);
    8a8c:	e24b3010 	sub	r3, fp, #16
    8a90:	e3a01009 	mov	r1, #9
    8a94:	e1a00003 	mov	r0, r3
    8a98:	eb000330 	bl	9760 <_Z5bzeroPvi>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:221 (discriminator 1)
        receive_data();
    8a9c:	ebffffc3 	bl	89b0 <_Z12receive_datav>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:223 (discriminator 1)

        sleep(0x15000);
    8aa0:	e3e01001 	mvn	r1, #1
    8aa4:	e3a00a15 	mov	r0, #86016	; 0x15000
    8aa8:	eb000116 	bl	8f08 <_Z5sleepjj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:219 (discriminator 1)
        bzero(msg, 32);
    8aac:	eafffff2 	b	8a7c <_Z11master_taskv+0xc>

00008ab0 <_Z10slave_taskv>:
_Z10slave_taskv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:227
    }
}

void slave_task() {
    8ab0:	e92d4800 	push	{fp, lr}
    8ab4:	e28db004 	add	fp, sp, #4
    8ab8:	e24dd008 	sub	sp, sp, #8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:228
    uint32_t counter = 0;
    8abc:	e3a03000 	mov	r3, #0
    8ac0:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:230 (discriminator 1)
    for (;;) {
        send_value(random_values[counter]);
    8ac4:	e59f2050 	ldr	r2, [pc, #80]	; 8b1c <_Z10slave_taskv+0x6c>
    8ac8:	e51b3008 	ldr	r3, [fp, #-8]
    8acc:	e1a03103 	lsl	r3, r3, #2
    8ad0:	e0823003 	add	r3, r2, r3
    8ad4:	edd37a00 	vldr	s15, [r3]
    8ad8:	eeb00a67 	vmov.f32	s0, s15
    8adc:	ebfffe93 	bl	8530 <_Z10send_valuef>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:231 (discriminator 1)
        prev_value = random_values[counter];
    8ae0:	e59f2034 	ldr	r2, [pc, #52]	; 8b1c <_Z10slave_taskv+0x6c>
    8ae4:	e51b3008 	ldr	r3, [fp, #-8]
    8ae8:	e1a03103 	lsl	r3, r3, #2
    8aec:	e0823003 	add	r3, r2, r3
    8af0:	e5933000 	ldr	r3, [r3]
    8af4:	e59f2024 	ldr	r2, [pc, #36]	; 8b20 <_Z10slave_taskv+0x70>
    8af8:	e5823000 	str	r3, [r2]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:232 (discriminator 1)
        counter = (counter + 1) % random_values_len;
    8afc:	e51b3008 	ldr	r3, [fp, #-8]
    8b00:	e2833001 	add	r3, r3, #1
    8b04:	e2033007 	and	r3, r3, #7
    8b08:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:233 (discriminator 1)
        sleep(0x15000);
    8b0c:	e3e01001 	mvn	r1, #1
    8b10:	e3a00a15 	mov	r0, #86016	; 0x15000
    8b14:	eb0000fb 	bl	8f08 <_Z5sleepjj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:230 (discriminator 1)
        send_value(random_values[counter]);
    8b18:	eaffffe9 	b	8ac4 <_Z10slave_taskv+0x14>
    8b1c:	00009b48 	andeq	r9, r0, r8, asr #22
    8b20:	00009cec 	andeq	r9, r0, ip, ror #25

00008b24 <main>:
main():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:238
    }
}

int main(int argc, char** argv)
{
    8b24:	e92d4800 	push	{fp, lr}
    8b28:	e28db004 	add	fp, sp, #4
    8b2c:	e24dd030 	sub	sp, sp, #48	; 0x30
    8b30:	e50b0030 	str	r0, [fp, #-48]	; 0xffffffd0
    8b34:	e50b1034 	str	r1, [fp, #-52]	; 0xffffffcc
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:239
    uint32_t counter = 0;
    8b38:	e3a03000 	mov	r3, #0
    8b3c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:241
    char buff[32];
    bzero(buff, 32);
    8b40:	e24b3028 	sub	r3, fp, #40	; 0x28
    8b44:	e3a01020 	mov	r1, #32
    8b48:	e1a00003 	mov	r0, r3
    8b4c:	eb000303 	bl	9760 <_Z5bzeroPvi>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:243

    log_fd = pipe("log", 128);
    8b50:	e3a01080 	mov	r1, #128	; 0x80
    8b54:	e59f011c 	ldr	r0, [pc, #284]	; 8c78 <main+0x154>
    8b58:	eb00013b 	bl	904c <_Z4pipePKcj>
    8b5c:	e1a03000 	mov	r3, r0
    8b60:	e59f2114 	ldr	r2, [pc, #276]	; 8c7c <main+0x158>
    8b64:	e5823000 	str	r3, [r2]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:245

    log("Task 1 started\n");
    8b68:	e59f0110 	ldr	r0, [pc, #272]	; 8c80 <main+0x15c>
    8b6c:	ebfffdd9 	bl	82d8 <_Z3logPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:248

    // start i2c connection - primarly master
    i2c_fd = open("DEV:i2c/1", NFile_Open_Mode::Read_Write);
    8b70:	e3a01002 	mov	r1, #2
    8b74:	e59f0108 	ldr	r0, [pc, #264]	; 8c84 <main+0x160>
    8b78:	eb000065 	bl	8d14 <_Z4openPKc15NFile_Open_Mode>
    8b7c:	e1a03000 	mov	r3, r0
    8b80:	e59f2100 	ldr	r2, [pc, #256]	; 8c88 <main+0x164>
    8b84:	e5823000 	str	r3, [r2]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:249
    if (i2c_fd == Invalid_Handle) {
    8b88:	e59f30f8 	ldr	r3, [pc, #248]	; 8c88 <main+0x164>
    8b8c:	e5933000 	ldr	r3, [r3]
    8b90:	e3730001 	cmn	r3, #1
    8b94:	1a00000d 	bne	8bd0 <main+0xac>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:251
        // if master already opened, open slave
        i2c_fd = open("DEV:i2c/2", NFile_Open_Mode::Read_Write);
    8b98:	e3a01002 	mov	r1, #2
    8b9c:	e59f00e8 	ldr	r0, [pc, #232]	; 8c8c <main+0x168>
    8ba0:	eb00005b 	bl	8d14 <_Z4openPKc15NFile_Open_Mode>
    8ba4:	e1a03000 	mov	r3, r0
    8ba8:	e59f20d8 	ldr	r2, [pc, #216]	; 8c88 <main+0x164>
    8bac:	e5823000 	str	r3, [r2]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:252
        if (i2c_fd == Invalid_Handle) {
    8bb0:	e59f30d0 	ldr	r3, [pc, #208]	; 8c88 <main+0x164>
    8bb4:	e5933000 	ldr	r3, [r3]
    8bb8:	e3730001 	cmn	r3, #1
    8bbc:	1a000003 	bne	8bd0 <main+0xac>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:253
            log("Error opening I2C connection\n");
    8bc0:	e59f00c8 	ldr	r0, [pc, #200]	; 8c90 <main+0x16c>
    8bc4:	ebfffdc3 	bl	82d8 <_Z3logPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:254
            return 1;
    8bc8:	e3a03001 	mov	r3, #1
    8bcc:	ea000026 	b	8c6c <main+0x148>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:259
        }
    }
    // set addresses
    TI2C_IOCtl_Params params;
    params.address = ADDRESS;
    8bd0:	e3a03002 	mov	r3, #2
    8bd4:	e54b302c 	strb	r3, [fp, #-44]	; 0xffffffd4
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:260
    params.targetAdress = TARGET_ADDRESS;
    8bd8:	e3a03001 	mov	r3, #1
    8bdc:	e54b302b 	strb	r3, [fp, #-43]	; 0xffffffd5
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:261
    ioctl(i2c_fd, NIOCtl_Operation::Set_Params, &params);
    8be0:	e59f30a0 	ldr	r3, [pc, #160]	; 8c88 <main+0x164>
    8be4:	e5933000 	ldr	r3, [r3]
    8be8:	e24b202c 	sub	r2, fp, #44	; 0x2c
    8bec:	e3a01001 	mov	r1, #1
    8bf0:	e1a00003 	mov	r0, r3
    8bf4:	eb00008a 	bl	8e24 <_Z5ioctlj16NIOCtl_OperationPv>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:262
    log("Task 1: I2C connection started...\n");
    8bf8:	e59f0094 	ldr	r0, [pc, #148]	; 8c94 <main+0x170>
    8bfc:	ebfffdb5 	bl	82d8 <_Z3logPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:270
    // if (slave == Invalid_Handle) {
    //     log("Error opening I2C slave connection\n");
    //     return 1;
    // }

    sleep(0x100);
    8c00:	e3e01001 	mvn	r1, #1
    8c04:	e3a00c01 	mov	r0, #256	; 0x100
    8c08:	eb0000be 	bl	8f08 <_Z5sleepjj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:271
    set_roles(DESIRED_ROLE);
    8c0c:	e3a00001 	mov	r0, #1
    8c10:	ebfffead 	bl	86cc <_Z9set_roles9CI2C_Mode>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:273

    switch (agreed_role)
    8c14:	e59f307c 	ldr	r3, [pc, #124]	; 8c98 <main+0x174>
    8c18:	e5933000 	ldr	r3, [r3]
    8c1c:	e3530000 	cmp	r3, #0
    8c20:	0a000002 	beq	8c30 <main+0x10c>
    8c24:	e3530001 	cmp	r3, #1
    8c28:	0a000002 	beq	8c38 <main+0x114>
    8c2c:	ea000003 	b	8c40 <main+0x11c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:276
    {
    case CI2C_Mode::Master:
        master_task();
    8c30:	ebffff8e 	bl	8a70 <_Z11master_taskv>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:277
        break;
    8c34:	ea000001 	b	8c40 <main+0x11c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:279
    case CI2C_Mode::Slave:
        slave_task();
    8c38:	ebffff9c 	bl	8ab0 <_Z10slave_taskv>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:280
        break;
    8c3c:	e320f000 	nop	{0}
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:283
    }

    close(i2c_fd);
    8c40:	e59f3040 	ldr	r3, [pc, #64]	; 8c88 <main+0x164>
    8c44:	e5933000 	ldr	r3, [r3]
    8c48:	e1a00003 	mov	r0, r3
    8c4c:	eb000069 	bl	8df8 <_Z5closej>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:284
    log("Open files closed in task 1\n");
    8c50:	e59f0044 	ldr	r0, [pc, #68]	; 8c9c <main+0x178>
    8c54:	ebfffd9f 	bl	82d8 <_Z3logPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:285
    close(log_fd);
    8c58:	e59f301c 	ldr	r3, [pc, #28]	; 8c7c <main+0x158>
    8c5c:	e5933000 	ldr	r3, [r3]
    8c60:	e1a00003 	mov	r0, r3
    8c64:	eb000063 	bl	8df8 <_Z5closej>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:287

    return 0;
    8c68:	e3a03000 	mov	r3, #0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:288 (discriminator 1)
}
    8c6c:	e1a00003 	mov	r0, r3
    8c70:	e24bd004 	sub	sp, fp, #4
    8c74:	e8bd8800 	pop	{fp, pc}
    8c78:	00009c0c 	andeq	r9, r0, ip, lsl #24
    8c7c:	00009cf0 	strdeq	r9, [r0], -r0
    8c80:	00009c10 	andeq	r9, r0, r0, lsl ip
    8c84:	00009c20 	andeq	r9, r0, r0, lsr #24
    8c88:	00009cf8 	strdeq	r9, [r0], -r8
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
    9b3c:	00000002 	andeq	r0, r0, r2

00009b40 <_ZL14TARGET_ADDRESS>:
    9b40:	00000001 	andeq	r0, r0, r1

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
    9b8c:	3a676e69 	bcc	19e5538 <__bss_end+0x19db7a8>
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
    9c10:	6b736154 	blvs	1ce2168 <__bss_end+0x1cd83d8>
    9c14:	73203120 			; <UNDEFINED> instruction: 0x73203120
    9c18:	74726174 	ldrbtvc	r6, [r2], #-372	; 0xfffffe8c
    9c1c:	000a6465 	andeq	r6, sl, r5, ror #8
    9c20:	3a564544 	bcc	159b138 <__bss_end+0x15913a8>
    9c24:	2f633269 	svccs	0x00633269
    9c28:	00000031 	andeq	r0, r0, r1, lsr r0
    9c2c:	3a564544 	bcc	159b144 <__bss_end+0x15913b4>
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
    9c58:	6b736154 	blvs	1ce21b0 <__bss_end+0x1cd8420>
    9c5c:	203a3120 	eorscs	r3, sl, r0, lsr #2
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
    9c94:	0a31206b 	beq	c51e48 <__bss_end+0xc480b8>
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
    9cc8:	3a535953 	bcc	14e021c <__bss_end+0x14d648c>
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
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:23
float prev_value = random_values[0];
    9cec:	40d6b852 	sbcsmi	fp, r6, r2, asr r8

Disassembly of section .bss:

00009cf0 <log_fd>:
__bss_start():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:17
uint32_t log_fd, slave, i2c_fd;
    9cf0:	00000000 	andeq	r0, r0, r0

00009cf4 <slave>:
    9cf4:	00000000 	andeq	r0, r0, r0

00009cf8 <i2c_fd>:
    9cf8:	00000000 	andeq	r0, r0, r0

00009cfc <received_values>:
	...

00009d7c <received_values_len>:
	...

Disassembly of section .ARM.attributes:

00000000 <.ARM.attributes>:
   0:	00002e41 	andeq	r2, r0, r1, asr #28
   4:	61656100 	cmnvs	r5, r0, lsl #2
   8:	01006962 	tsteq	r0, r2, ror #18
   c:	00000024 	andeq	r0, r0, r4, lsr #32
  10:	4b5a3605 	blmi	168d82c <__bss_end+0x1683a9c>
  14:	08070600 	stmdaeq	r7, {r9, sl}
  18:	0a010901 	beq	42424 <__bss_end+0x38694>
  1c:	14041202 	strne	r1, [r4], #-514	; 0xfffffdfe
  20:	17011501 	strne	r1, [r1, -r1, lsl #10]
  24:	1a011803 	bne	46038 <__bss_end+0x3c2a8>
  28:	22011c01 	andcs	r1, r1, #256	; 0x100
  2c:	Address 0x000000000000002c is out of bounds.


Disassembly of section .comment:

00000000 <.comment>:
   0:	3a434347 	bcc	10d0d24 <__bss_end+0x10c6f94>
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
  38:	7a617661 	bvc	185d9c4 <__bss_end+0x1853c34>
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
  c0:	6a757a61 	bvs	1d5ea4c <__bss_end+0x1d54cbc>
  c4:	2f696369 	svccs	0x00696369
  c8:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
  cc:	73656d65 	cmnvc	r5, #6464	; 0x1940
  d0:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
  d4:	6b2d616b 	blvs	b58688 <__bss_end+0xb4e8f8>
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
 144:	fb010200 	blx	4094e <__bss_end+0x36bbe>
 148:	01000d0e 	tsteq	r0, lr, lsl #26
 14c:	00010101 	andeq	r0, r1, r1, lsl #2
 150:	00010000 	andeq	r0, r1, r0
 154:	552f0100 	strpl	r0, [pc, #-256]!	; 5c <shift+0x5c>
 158:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 15c:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 160:	6a726574 	bvs	1c99738 <__bss_end+0x1c8f9a8>
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
 198:	752f7365 	strvc	r7, [pc, #-869]!	; fffffe3b <__bss_end+0xffff60ab>
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
 1d0:	0a05830b 	beq	160e04 <__bss_end+0x157074>
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
 1fc:	4a030402 	bmi	c120c <__bss_end+0xb747c>
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
 230:	4a020402 	bmi	81240 <__bss_end+0x774b0>
 234:	02000205 	andeq	r0, r0, #1342177280	; 0x50000000
 238:	052d0204 	streq	r0, [sp, #-516]!	; 0xfffffdfc
 23c:	01058509 	tsteq	r5, r9, lsl #10
 240:	000a022f 	andeq	r0, sl, pc, lsr #4
 244:	05880101 	streq	r0, [r8, #257]	; 0x101
 248:	00030000 	andeq	r0, r3, r0
 24c:	00000326 	andeq	r0, r0, r6, lsr #6
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
 280:	6a757a61 	bvs	1d5ec0c <__bss_end+0x1d54e7c>
 284:	2f696369 	svccs	0x00696369
 288:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
 28c:	73656d65 	cmnvc	r5, #6464	; 0x1940
 290:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
 294:	6b2d616b 	blvs	b58848 <__bss_end+0xb4eab8>
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
 2d8:	7a617661 	bvc	185dc64 <__bss_end+0x1853ed4>
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
 31c:	72616f62 	rsbvc	r6, r1, #392	; 0x188
 320:	70722f64 	rsbsvc	r2, r2, r4, ror #30
 324:	682f3069 	stmdavs	pc!, {r0, r3, r5, r6, ip, sp}	; <UNPREDICTABLE>
 328:	2f006c61 	svccs	0x00006c61
 32c:	72657355 	rsbvc	r7, r5, #1409286145	; 0x54000001
 330:	69772f73 	ldmdbvs	r7!, {r0, r1, r4, r5, r6, r8, r9, sl, fp, sp}^
 334:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
 338:	442f696a 	strtmi	r6, [pc], #-2410	; 340 <shift+0x340>
 33c:	746b7365 	strbtvc	r7, [fp], #-869	; 0xfffffc9b
 340:	462f706f 	strtmi	r7, [pc], -pc, rrx
 344:	4e2f5641 	cfmadda32mi	mvax2, mvax5, mvfx15, mvfx1
 348:	7a617661 	bvc	185dcd4 <__bss_end+0x1853f44>
 34c:	63696a75 	cmnvs	r9, #479232	; 0x75000
 350:	534f2f69 	movtpl	r2, #65385	; 0xff69
 354:	6d65732f 	stclvs	3, cr7, [r5, #-188]!	; 0xffffff44
 358:	72747365 	rsbsvc	r7, r4, #-1811939327	; 0x94000001
 35c:	616b6c61 	cmnvs	fp, r1, ror #24
 360:	76696b2d 	strbtvc	r6, [r9], -sp, lsr #22
 364:	2f736f2d 	svccs	0x00736f2d
 368:	72756f73 	rsbsvc	r6, r5, #460	; 0x1cc
 36c:	2f736563 	svccs	0x00736563
 370:	72657375 	rsbvc	r7, r5, #-738197503	; 0xd4000001
 374:	63617073 	cmnvs	r1, #115	; 0x73
 378:	2e2e2f65 	cdpcs	15, 2, cr2, cr14, cr5, {3}
 37c:	72656b2f 	rsbvc	r6, r5, #48128	; 0xbc00
 380:	2f6c656e 	svccs	0x006c656e
 384:	6c636e69 	stclvs	14, cr6, [r3], #-420	; 0xfffffe5c
 388:	2f656475 	svccs	0x00656475
 38c:	636f7270 	cmnvs	pc, #112, 4
 390:	00737365 	rsbseq	r7, r3, r5, ror #6
 394:	6573552f 	ldrbvs	r5, [r3, #-1327]!	; 0xfffffad1
 398:	772f7372 			; <UNDEFINED> instruction: 0x772f7372
 39c:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
 3a0:	2f696a72 	svccs	0x00696a72
 3a4:	6b736544 	blvs	1cd98bc <__bss_end+0x1ccfb2c>
 3a8:	2f706f74 	svccs	0x00706f74
 3ac:	2f564146 	svccs	0x00564146
 3b0:	6176614e 	cmnvs	r6, lr, asr #2
 3b4:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
 3b8:	4f2f6963 	svcmi	0x002f6963
 3bc:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
 3c0:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
 3c4:	6b6c6172 	blvs	1b18994 <__bss_end+0x1b0ec04>
 3c8:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
 3cc:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
 3d0:	756f732f 	strbvc	r7, [pc, #-815]!	; a9 <shift+0xa9>
 3d4:	73656372 	cmnvc	r5, #-939524095	; 0xc8000001
 3d8:	6573752f 	ldrbvs	r7, [r3, #-1327]!	; 0xfffffad1
 3dc:	61707372 	cmnvs	r0, r2, ror r3
 3e0:	2e2f6563 	cfsh64cs	mvdx6, mvdx15, #51
 3e4:	656b2f2e 	strbvs	r2, [fp, #-3886]!	; 0xfffff0d2
 3e8:	6c656e72 	stclvs	14, cr6, [r5], #-456	; 0xfffffe38
 3ec:	636e692f 	cmnvs	lr, #770048	; 0xbc000
 3f0:	6564756c 	strbvs	r7, [r4, #-1388]!	; 0xfffffa94
 3f4:	0073662f 	rsbseq	r6, r3, pc, lsr #12
 3f8:	6573552f 	ldrbvs	r5, [r3, #-1327]!	; 0xfffffad1
 3fc:	772f7372 			; <UNDEFINED> instruction: 0x772f7372
 400:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
 404:	2f696a72 	svccs	0x00696a72
 408:	6b736544 	blvs	1cd9920 <__bss_end+0x1ccfb90>
 40c:	2f706f74 	svccs	0x00706f74
 410:	2f564146 	svccs	0x00564146
 414:	6176614e 	cmnvs	r6, lr, asr #2
 418:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
 41c:	4f2f6963 	svcmi	0x002f6963
 420:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
 424:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
 428:	6b6c6172 	blvs	1b189f8 <__bss_end+0x1b0ec68>
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
 460:	73552f00 	cmpvc	r5, #0, 30
 464:	2f737265 	svccs	0x00737265
 468:	746e6977 	strbtvc	r6, [lr], #-2423	; 0xfffff689
 46c:	696a7265 	stmdbvs	sl!, {r0, r2, r5, r6, r9, ip, sp, lr}^
 470:	7365442f 	cmnvc	r5, #788529152	; 0x2f000000
 474:	706f746b 	rsbvc	r7, pc, fp, ror #8
 478:	5641462f 	strbpl	r4, [r1], -pc, lsr #12
 47c:	76614e2f 	strbtvc	r4, [r1], -pc, lsr #28
 480:	6a757a61 	bvs	1d5ee0c <__bss_end+0x1d5507c>
 484:	2f696369 	svccs	0x00696369
 488:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
 48c:	73656d65 	cmnvc	r5, #6464	; 0x1940
 490:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
 494:	6b2d616b 	blvs	b58a48 <__bss_end+0xb4ecb8>
 498:	6f2d7669 	svcvs	0x002d7669
 49c:	6f732f73 	svcvs	0x00732f73
 4a0:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
 4a4:	73752f73 	cmnvc	r5, #460	; 0x1cc
 4a8:	70737265 	rsbsvc	r7, r3, r5, ror #4
 4ac:	2f656361 	svccs	0x00656361
 4b0:	6b2f2e2e 	blvs	bcbd70 <__bss_end+0xbc1fe0>
 4b4:	656e7265 	strbvs	r7, [lr, #-613]!	; 0xfffffd9b
 4b8:	6e692f6c 	cdpvs	15, 6, cr2, cr9, cr12, {3}
 4bc:	64756c63 	ldrbtvs	r6, [r5], #-3171	; 0xfffff39d
 4c0:	72642f65 	rsbvc	r2, r4, #404	; 0x194
 4c4:	72657669 	rsbvc	r7, r5, #110100480	; 0x6900000
 4c8:	72622f73 	rsbvc	r2, r2, #460	; 0x1cc
 4cc:	65676469 	strbvs	r6, [r7, #-1129]!	; 0xfffffb97
 4d0:	6d000073 	stcvs	0, cr0, [r0, #-460]	; 0xfffffe34
 4d4:	2e6e6961 	vnmulcs.f16	s13, s28, s3	; <UNPREDICTABLE>
 4d8:	00707063 	rsbseq	r7, r0, r3, rrx
 4dc:	69000001 	stmdbvs	r0, {r0}
 4e0:	6564746e 	strbvs	r7, [r4, #-1134]!	; 0xfffffb92
 4e4:	00682e66 	rsbeq	r2, r8, r6, ror #28
 4e8:	73000002 	movwvc	r0, #2
 4ec:	682e6977 	stmdavs	lr!, {r0, r1, r2, r4, r5, r6, r8, fp, sp, lr}
 4f0:	00000300 	andeq	r0, r0, r0, lsl #6
 4f4:	6e697073 	mcrvs	0, 3, r7, cr9, cr3, {3}
 4f8:	6b636f6c 	blvs	18dc2b0 <__bss_end+0x18d2520>
 4fc:	0300682e 	movweq	r6, #2094	; 0x82e
 500:	69660000 	stmdbvs	r6!, {}^	; <UNPREDICTABLE>
 504:	7973656c 	ldmdbvc	r3!, {r2, r3, r5, r6, r8, sl, sp, lr}^
 508:	6d657473 	cfstrdvs	mvd7, [r5, #-460]!	; 0xfffffe34
 50c:	0400682e 	streq	r6, [r0], #-2094	; 0xfffff7d2
 510:	72700000 	rsbsvc	r0, r0, #0
 514:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
 518:	00682e73 	rsbeq	r2, r8, r3, ror lr
 51c:	70000003 	andvc	r0, r0, r3
 520:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
 524:	6d5f7373 	ldclvs	3, cr7, [pc, #-460]	; 360 <shift+0x360>
 528:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
 52c:	682e7265 	stmdavs	lr!, {r0, r2, r5, r6, r9, ip, sp, lr}
 530:	00000300 	andeq	r0, r0, r0, lsl #6
 534:	69726570 	ldmdbvs	r2!, {r4, r5, r6, r8, sl, sp, lr}^
 538:	72656870 	rsbvc	r6, r5, #112, 16	; 0x700000
 53c:	2e736c61 	cdpcs	12, 7, cr6, cr3, cr1, {3}
 540:	00020068 	andeq	r0, r2, r8, rrx
 544:	69706700 	ldmdbvs	r0!, {r8, r9, sl, sp, lr}^
 548:	00682e6f 	rsbeq	r2, r8, pc, ror #28
 54c:	69000005 	stmdbvs	r0, {r0, r2}
 550:	645f6332 	ldrbvs	r6, [pc], #-818	; 558 <shift+0x558>
 554:	2e736665 	cdpcs	6, 7, cr6, cr3, cr5, {3}
 558:	00060068 	andeq	r0, r6, r8, rrx
 55c:	63326900 	teqvs	r2, #0, 18
 560:	0500682e 	streq	r6, [r0, #-2094]	; 0xfffff7d2
 564:	32690000 	rsbcc	r0, r9, #0
 568:	6c735f63 	ldclvs	15, cr5, [r3], #-396	; 0xfffffe74
 56c:	2e657661 	cdpcs	6, 6, cr7, cr5, cr1, {3}
 570:	00050068 	andeq	r0, r5, r8, rrx
 574:	2c050000 	stccs	0, cr0, [r5], {-0}
 578:	2c020500 	cfstr32cs	mvfx0, [r2], {-0}
 57c:	03000082 	movweq	r0, #130	; 0x82
 580:	0505011b 	streq	r0, [r5, #-283]	; 0xfffffee5
 584:	d910059f 	ldmdble	r0, {r0, r1, r2, r3, r4, r7, r8, sl}
 588:	05830905 	streq	r0, [r3, #2309]	; 0x905
 58c:	09053010 	stmdbeq	r5, {r4, ip, sp}
 590:	30100583 	andscc	r0, r0, r3, lsl #11
 594:	05830905 	streq	r0, [r3, #2309]	; 0x905
 598:	0105310c 	tsteq	r5, ip, lsl #2
 59c:	05d92108 	ldrbeq	r2, [r9, #264]	; 0x108
 5a0:	1905852b 	stmdbne	r5, {r0, r1, r3, r5, r8, sl, pc}
 5a4:	66220548 	strtvs	r0, [r2], -r8, asr #10
 5a8:	052e0a05 	streq	r0, [lr, #-2565]!	; 0xfffff5fb
 5ac:	133c020d 	teqne	ip, #-805306368	; 0xd0000000
 5b0:	05670a05 	strbeq	r0, [r7, #-2565]!	; 0xfffff5fb
 5b4:	28054a23 	stmdacs	r5, {r0, r1, r5, r9, fp, lr}
 5b8:	2e0a0566 	cfsh32cs	mvfx0, mvfx10, #54
 5bc:	059f0105 	ldreq	r0, [pc, #261]	; 6c9 <shift+0x6c9>
 5c0:	09058420 	stmdbeq	r5, {r5, sl, pc}
 5c4:	9f0d0584 	svcls	0x000d0584
 5c8:	059f0a05 	ldreq	r0, [pc, #2565]	; fd5 <shift+0xfd5>
 5cc:	0a054a1f 	beq	152e50 <__bss_end+0x1490c0>
 5d0:	9f010582 	svcls	0x00010582
 5d4:	830b0585 	movwhi	r0, #46469	; 0xb585
 5d8:	054c0905 	strbeq	r0, [ip, #-2309]	; 0xfffff6fb
 5dc:	20052e05 	andcs	r2, r5, r5, lsl #28
 5e0:	01040200 	mrseq	r0, R12_usr
 5e4:	001d0582 	andseq	r0, sp, r2, lsl #11
 5e8:	2e010402 	cdpcs	4, 0, cr0, cr1, cr2, {0}
 5ec:	05831005 	streq	r1, [r3, #5]
 5f0:	27056921 	strcs	r6, [r5, -r1, lsr #18]
 5f4:	6618052e 	ldrvs	r0, [r8], -lr, lsr #10
 5f8:	052e1605 	streq	r1, [lr, #-1541]!	; 0xfffff9fb
 5fc:	28054b09 	stmdacs	r5, {r0, r3, r8, r9, fp, lr}
 600:	01040200 	mrseq	r0, R12_usr
 604:	9f14059e 	svcls	0x0014059e
 608:	4d0b0569 	cfstr32mi	mvfx0, [fp, #-420]	; 0xfffffe5c
 60c:	05bb0c05 	ldreq	r0, [fp, #3077]!	; 0xc05
 610:	01054b0a 	tsteq	r5, sl, lsl #22
 614:	f42405bb 	vld3.32	{d0,d2,d4}, [r4 :256], fp
 618:	83840a05 	orrhi	r0, r4, #20480	; 0x5000
 61c:	05830c05 	streq	r0, [r3, #3077]	; 0xc05
 620:	0b059f09 	bleq	16824c <__bss_end+0x15e4bc>
 624:	08059f9f 	stmdaeq	r5, {r0, r1, r2, r3, r4, r7, r8, r9, sl, fp, ip, pc}
 628:	670e0583 	strvs	r0, [lr, -r3, lsl #11]
 62c:	a14b0105 	cmpge	fp, r5, lsl #2
 630:	059f0f05 	ldreq	r0, [pc, #3845]	; 153d <shift+0x153d>
 634:	2c054b10 			; <UNDEFINED> instruction: 0x2c054b10
 638:	8205059e 	andhi	r0, r5, #662700032	; 0x27800000
 63c:	054c1405 	strbeq	r1, [ip, #-1029]	; 0xfffffbfb
 640:	31056815 	tstcc	r5, r5, lsl r8
 644:	820a059e 	andhi	r0, sl, #662700032	; 0x27800000
 648:	054c1405 	strbeq	r1, [ip, #-1029]	; 0xfffffbfb
 64c:	09054d05 	stmdbeq	r5, {r0, r2, r8, sl, fp, lr}
 650:	681f0568 	ldmdavs	pc, {r3, r5, r6, r8, sl}	; <UNPREDICTABLE>
 654:	054c0e05 	strbeq	r0, [ip, #-3589]	; 0xfffff1fb
 658:	0905681f 	stmdbeq	r5, {r0, r1, r2, r3, r4, fp, sp, lr}
 65c:	8410054e 	ldrhi	r0, [r0], #-1358	; 0xfffffab2
 660:	054e2305 	strbeq	r2, [lr, #-773]	; 0xfffffcfb
 664:	01054d0c 	tsteq	r5, ip, lsl #26
 668:	0a05bd2f 	beq	16fb2c <__bss_end+0x165d9c>
 66c:	05838384 	streq	r8, [r3, #900]	; 0x384
 670:	10058305 	andne	r8, r5, r5, lsl #6
 674:	9f0905d9 	svcls	0x000905d9
 678:	05301005 	ldreq	r1, [r0, #-5]!
 67c:	10059f09 	andne	r9, r5, r9, lsl #30
 680:	9f090530 	svcls	0x00090530
 684:	05310a05 	ldreq	r0, [r1, #-2565]!	; 0xfffff5fb
 688:	1905bb12 	stmdbne	r5, {r1, r4, r8, r9, fp, ip, sp, pc}
 68c:	bb0d0582 	bllt	341c9c <__bss_end+0x337f0c>
 690:	05bb0e05 	ldreq	r0, [fp, #3589]!	; 0xe05
 694:	1e056405 	cdpne	4, 0, cr6, cr5, cr5, {0}
 698:	9e110533 	mrcls	5, 0, r0, cr1, cr3, {1}
 69c:	054b0c05 	strbeq	r0, [fp, #-3077]	; 0xfffff3fb
 6a0:	0f059f05 	svceq	0x00059f05
 6a4:	830905d9 	movwhi	r0, #38361	; 0x95d9
 6a8:	05300f05 	ldreq	r0, [r0, #-3845]!	; 0xfffff0fb
 6ac:	08058309 	stmdaeq	r5, {r0, r3, r8, r9, pc}
 6b0:	67180530 			; <UNDEFINED> instruction: 0x67180530
 6b4:	054a1b05 	strbeq	r1, [sl, #-2821]	; 0xfffff4fb
 6b8:	3f089f01 	svccc	0x00089f01
 6bc:	83bc0a05 			; <UNDEFINED> instruction: 0x83bc0a05
 6c0:	05830c05 	streq	r0, [r3, #3077]	; 0xc05
 6c4:	0b059f09 	bleq	1682f0 <__bss_end+0x15e560>
 6c8:	9f0d059f 	svcls	0x000d059f
 6cc:	052e0505 	streq	r0, [lr, #-1285]!	; 0xfffffafb
 6d0:	0524080f 	streq	r0, [r4, #-2063]!	; 0xfffff7f1
 6d4:	0f058309 	svceq	0x00058309
 6d8:	83090531 	movwhi	r0, #38193	; 0x9531
 6dc:	05310f05 	ldreq	r0, [r1, #-3845]!	; 0xfffff0fb
 6e0:	0b058309 	bleq	16130c <__bss_end+0x15757c>
 6e4:	83080531 	movwhi	r0, #34097	; 0x8531
 6e8:	f5670105 			; <UNDEFINED> instruction: 0xf5670105
 6ec:	83680a05 	cmnhi	r8, #20480	; 0x5000
 6f0:	05861205 	streq	r1, [r6, #517]	; 0x205
 6f4:	0d058219 	sfmeq	f0, 1, [r5, #-100]	; 0xffffff9c
 6f8:	bb0e05bb 	bllt	381dec <__bss_end+0x37805c>
 6fc:	05640505 	strbeq	r0, [r4, #-1285]!	; 0xfffffafb
 700:	0b053311 	bleq	14d34c <__bss_end+0x1435bc>
 704:	bc10054b 	cfldr32lt	mvfx0, [r0], {75}	; 0x4b
 708:	059f0105 	ldreq	r0, [pc, #261]	; 815 <shift+0x815>
 70c:	0e058414 	cfmvdlreq	mvd5, r8
 710:	01040200 	mrseq	r0, R12_usr
 714:	0402006a 	streq	r0, [r2], #-106	; 0xffffff96
 718:	15058301 	strne	r8, [r5, #-769]	; 0xfffffcff
 71c:	01040200 	mrseq	r0, R12_usr
 720:	000e0583 	andeq	r0, lr, r3, lsl #11
 724:	30010402 	andcc	r0, r1, r2, lsl #8
 728:	01040200 	mrseq	r0, R12_usr
 72c:	36130562 	ldrcc	r0, [r3], -r2, ror #10
 730:	05670e05 	strbeq	r0, [r7, #-3589]!	; 0xfffff1fb
 734:	04020029 	streq	r0, [r2], #-41	; 0xffffffd7
 738:	13054c01 	movwne	r4, #23553	; 0x5c01
 73c:	01040200 	mrseq	r0, R12_usr
 740:	002b059e 	mlaeq	fp, lr, r5, r0
 744:	4b010402 	blmi	41754 <__bss_end+0x379c4>
 748:	02001405 	andeq	r1, r0, #83886080	; 0x5000000
 74c:	059e0104 	ldreq	r0, [lr, #260]	; 0x104
 750:	0402001c 	streq	r0, [r2], #-28	; 0xffffffe4
 754:	11054b01 	tstne	r5, r1, lsl #22
 758:	01040200 	mrseq	r0, R12_usr
 75c:	000e054a 	andeq	r0, lr, sl, asr #10
 760:	4b010402 	blmi	41770 <__bss_end+0x379e0>
 764:	02001305 	andeq	r1, r0, #335544320	; 0x14000000
 768:	05630104 	strbeq	r0, [r3, #-260]!	; 0xfffffefc
 76c:	0e056e01 	cdpeq	14, 0, cr6, cr5, cr1, {0}
 770:	4c0a059f 	cfstr32mi	mvfx0, [sl], {159}	; 0x9f
 774:	05841205 	streq	r1, [r4, #517]	; 0x205
 778:	0805820c 	stmdaeq	r5, {r2, r3, r9, pc}
 77c:	4d12054c 	cfldr32mi	mvfx0, [r2, #-304]	; 0xfffffed0
 780:	05820c05 	streq	r0, [r2, #3077]	; 0xc05
 784:	05054b10 	streq	r4, [r5, #-2832]	; 0xfffff4f0
 788:	4c16054a 	cfldr32mi	mvfx0, [r6], {74}	; 0x4a
 78c:	05821005 	streq	r1, [r2, #5]
 790:	09054b14 	stmdbeq	r5, {r2, r4, r8, r9, fp, lr}
 794:	4b10054a 	blmi	401cc4 <__bss_end+0x3f7f34>
 798:	4f4b1405 	svcmi	0x004b1405
 79c:	054b1905 	strbeq	r1, [fp, #-2309]	; 0xfffff6fb
 7a0:	08054b0a 	stmdaeq	r5, {r1, r3, r8, r9, fp, lr}
 7a4:	520a05bb 	andpl	r0, sl, #784334848	; 0x2ec00000
 7a8:	05670e05 	strbeq	r0, [r7, #-3589]!	; 0xfffff1fb
 7ac:	14054c05 	strne	r4, [r5], #-3077	; 0xfffff3fb
 7b0:	2f0905d9 	svccs	0x000905d9
 7b4:	05301305 	ldreq	r1, [r0, #-773]!	; 0xfffffcfb
 7b8:	0a052f09 	beq	14c3e4 <__bss_end+0x142654>
 7bc:	83080531 	movwhi	r0, #34097	; 0x8531
 7c0:	054b0a05 	strbeq	r0, [fp, #-2565]	; 0xfffff5fb
 7c4:	0105840c 	tsteq	r5, ip, lsl #8
 7c8:	01040200 	mrseq	r0, R12_usr
 7cc:	001a022f 	andseq	r0, sl, pc, lsr #4
 7d0:	02c80101 	sbceq	r0, r8, #1073741824	; 0x40000000
 7d4:	00030000 	andeq	r0, r3, r0
 7d8:	000001dd 	ldrdeq	r0, [r0], -sp
 7dc:	0efb0102 	cdpeq	1, 15, cr0, cr11, cr2, {0}
 7e0:	0101000d 	tsteq	r1, sp
 7e4:	00000101 	andeq	r0, r0, r1, lsl #2
 7e8:	00000100 	andeq	r0, r0, r0, lsl #2
 7ec:	73552f01 	cmpvc	r5, #1, 30
 7f0:	2f737265 	svccs	0x00737265
 7f4:	746e6977 	strbtvc	r6, [lr], #-2423	; 0xfffff689
 7f8:	696a7265 	stmdbvs	sl!, {r0, r2, r5, r6, r9, ip, sp, lr}^
 7fc:	7365442f 	cmnvc	r5, #788529152	; 0x2f000000
 800:	706f746b 	rsbvc	r7, pc, fp, ror #8
 804:	5641462f 	strbpl	r4, [r1], -pc, lsr #12
 808:	76614e2f 	strbtvc	r4, [r1], -pc, lsr #28
 80c:	6a757a61 	bvs	1d5f198 <__bss_end+0x1d55408>
 810:	2f696369 	svccs	0x00696369
 814:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
 818:	73656d65 	cmnvc	r5, #6464	; 0x1940
 81c:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
 820:	6b2d616b 	blvs	b58dd4 <__bss_end+0xb4f044>
 824:	6f2d7669 	svcvs	0x002d7669
 828:	6f732f73 	svcvs	0x00732f73
 82c:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
 830:	74732f73 	ldrbtvc	r2, [r3], #-3955	; 0xfffff08d
 834:	62696c64 	rsbvs	r6, r9, #100, 24	; 0x6400
 838:	6372732f 	cmnvs	r2, #-1140850688	; 0xbc000000
 83c:	73552f00 	cmpvc	r5, #0, 30
 840:	2f737265 	svccs	0x00737265
 844:	746e6977 	strbtvc	r6, [lr], #-2423	; 0xfffff689
 848:	696a7265 	stmdbvs	sl!, {r0, r2, r5, r6, r9, ip, sp, lr}^
 84c:	7365442f 	cmnvc	r5, #788529152	; 0x2f000000
 850:	706f746b 	rsbvc	r7, pc, fp, ror #8
 854:	5641462f 	strbpl	r4, [r1], -pc, lsr #12
 858:	76614e2f 	strbtvc	r4, [r1], -pc, lsr #28
 85c:	6a757a61 	bvs	1d5f1e8 <__bss_end+0x1d55458>
 860:	2f696369 	svccs	0x00696369
 864:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
 868:	73656d65 	cmnvc	r5, #6464	; 0x1940
 86c:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
 870:	6b2d616b 	blvs	b58e24 <__bss_end+0xb4f094>
 874:	6f2d7669 	svcvs	0x002d7669
 878:	6f732f73 	svcvs	0x00732f73
 87c:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
 880:	656b2f73 	strbvs	r2, [fp, #-3955]!	; 0xfffff08d
 884:	6c656e72 	stclvs	14, cr6, [r5], #-456	; 0xfffffe38
 888:	636e692f 	cmnvs	lr, #770048	; 0xbc000
 88c:	6564756c 	strbvs	r7, [r4, #-1388]!	; 0xfffffa94
 890:	6f72702f 	svcvs	0x0072702f
 894:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
 898:	73552f00 	cmpvc	r5, #0, 30
 89c:	2f737265 	svccs	0x00737265
 8a0:	746e6977 	strbtvc	r6, [lr], #-2423	; 0xfffff689
 8a4:	696a7265 	stmdbvs	sl!, {r0, r2, r5, r6, r9, ip, sp, lr}^
 8a8:	7365442f 	cmnvc	r5, #788529152	; 0x2f000000
 8ac:	706f746b 	rsbvc	r7, pc, fp, ror #8
 8b0:	5641462f 	strbpl	r4, [r1], -pc, lsr #12
 8b4:	76614e2f 	strbtvc	r4, [r1], -pc, lsr #28
 8b8:	6a757a61 	bvs	1d5f244 <__bss_end+0x1d554b4>
 8bc:	2f696369 	svccs	0x00696369
 8c0:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
 8c4:	73656d65 	cmnvc	r5, #6464	; 0x1940
 8c8:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
 8cc:	6b2d616b 	blvs	b58e80 <__bss_end+0xb4f0f0>
 8d0:	6f2d7669 	svcvs	0x002d7669
 8d4:	6f732f73 	svcvs	0x00732f73
 8d8:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
 8dc:	656b2f73 	strbvs	r2, [fp, #-3955]!	; 0xfffff08d
 8e0:	6c656e72 	stclvs	14, cr6, [r5], #-456	; 0xfffffe38
 8e4:	636e692f 	cmnvs	lr, #770048	; 0xbc000
 8e8:	6564756c 	strbvs	r7, [r4, #-1388]!	; 0xfffffa94
 8ec:	0073662f 	rsbseq	r6, r3, pc, lsr #12
 8f0:	6573552f 	ldrbvs	r5, [r3, #-1327]!	; 0xfffffad1
 8f4:	772f7372 			; <UNDEFINED> instruction: 0x772f7372
 8f8:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
 8fc:	2f696a72 	svccs	0x00696a72
 900:	6b736544 	blvs	1cd9e18 <__bss_end+0x1cd0088>
 904:	2f706f74 	svccs	0x00706f74
 908:	2f564146 	svccs	0x00564146
 90c:	6176614e 	cmnvs	r6, lr, asr #2
 910:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
 914:	4f2f6963 	svcmi	0x002f6963
 918:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
 91c:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
 920:	6b6c6172 	blvs	1b18ef0 <__bss_end+0x1b0f160>
 924:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
 928:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
 92c:	756f732f 	strbvc	r7, [pc, #-815]!	; 605 <shift+0x605>
 930:	73656372 	cmnvc	r5, #-939524095	; 0xc8000001
 934:	72656b2f 	rsbvc	r6, r5, #48128	; 0xbc00
 938:	2f6c656e 	svccs	0x006c656e
 93c:	6c636e69 	stclvs	14, cr6, [r3], #-420	; 0xfffffe5c
 940:	2f656475 	svccs	0x00656475
 944:	72616f62 	rsbvc	r6, r1, #392	; 0x188
 948:	70722f64 	rsbsvc	r2, r2, r4, ror #30
 94c:	682f3069 	stmdavs	pc!, {r0, r3, r5, r6, ip, sp}	; <UNPREDICTABLE>
 950:	00006c61 	andeq	r6, r0, r1, ror #24
 954:	66647473 			; <UNDEFINED> instruction: 0x66647473
 958:	2e656c69 	cdpcs	12, 6, cr6, cr5, cr9, {3}
 95c:	00707063 	rsbseq	r7, r0, r3, rrx
 960:	73000001 	movwvc	r0, #1
 964:	682e6977 	stmdavs	lr!, {r0, r1, r2, r4, r5, r6, r8, fp, sp, lr}
 968:	00000200 	andeq	r0, r0, r0, lsl #4
 96c:	6e697073 	mcrvs	0, 3, r7, cr9, cr3, {3}
 970:	6b636f6c 	blvs	18dc728 <__bss_end+0x18d2998>
 974:	0200682e 	andeq	r6, r0, #3014656	; 0x2e0000
 978:	69660000 	stmdbvs	r6!, {}^	; <UNPREDICTABLE>
 97c:	7973656c 	ldmdbvc	r3!, {r2, r3, r5, r6, r8, sl, sp, lr}^
 980:	6d657473 	cfstrdvs	mvd7, [r5, #-460]!	; 0xfffffe34
 984:	0300682e 	movweq	r6, #2094	; 0x82e
 988:	72700000 	rsbsvc	r0, r0, #0
 98c:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
 990:	00682e73 	rsbeq	r2, r8, r3, ror lr
 994:	70000002 	andvc	r0, r0, r2
 998:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
 99c:	6d5f7373 	ldclvs	3, cr7, [pc, #-460]	; 7d8 <shift+0x7d8>
 9a0:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
 9a4:	682e7265 	stmdavs	lr!, {r0, r2, r5, r6, r9, ip, sp, lr}
 9a8:	00000200 	andeq	r0, r0, r0, lsl #4
 9ac:	64746e69 	ldrbtvs	r6, [r4], #-3689	; 0xfffff197
 9b0:	682e6665 	stmdavs	lr!, {r0, r2, r5, r6, r9, sl, sp, lr}
 9b4:	00000400 	andeq	r0, r0, r0, lsl #8
 9b8:	00010500 	andeq	r0, r1, r0, lsl #10
 9bc:	8ca00205 	sfmhi	f0, 4, [r0], #20
 9c0:	05160000 	ldreq	r0, [r6, #-0]
 9c4:	052f6905 	streq	r6, [pc, #-2309]!	; c7 <shift+0xc7>
 9c8:	01054c0c 	tsteq	r5, ip, lsl #24
 9cc:	0505852f 	streq	r8, [r5, #-1327]	; 0xfffffad1
 9d0:	01054b83 	smlabbeq	r5, r3, fp, r4
 9d4:	0505852f 	streq	r8, [r5, #-1327]	; 0xfffffad1
 9d8:	2f01054b 	svccs	0x0001054b
 9dc:	a1050585 	smlabbge	r5, r5, r5, r0
 9e0:	052f4b4b 	streq	r4, [pc, #-2891]!	; fffffe9d <__bss_end+0xffff610d>
 9e4:	01054b0c 	tsteq	r5, ip, lsl #22
 9e8:	0505852f 	streq	r8, [r5, #-1327]	; 0xfffffad1
 9ec:	4b4b4bbd 	blmi	12d38e8 <__bss_end+0x12c9b58>
 9f0:	4c0c052f 	cfstr32mi	mvfx0, [ip], {47}	; 0x2f
 9f4:	852f0105 	strhi	r0, [pc, #-261]!	; 8f7 <shift+0x8f7>
 9f8:	4bbd0505 	blmi	fef41e14 <__bss_end+0xfef38084>
 9fc:	052f4b4b 	streq	r4, [pc, #-2891]!	; fffffeb9 <__bss_end+0xffff6129>
 a00:	01054c0c 	tsteq	r5, ip, lsl #24
 a04:	0505852f 	streq	r8, [r5, #-1327]	; 0xfffffad1
 a08:	01054b83 	smlabbeq	r5, r3, fp, r4
 a0c:	0505852f 	streq	r8, [r5, #-1327]	; 0xfffffad1
 a10:	4b4b4bbd 	blmi	12d390c <__bss_end+0x12c9b7c>
 a14:	4c0c052f 	cfstr32mi	mvfx0, [ip], {47}	; 0x2f
 a18:	852f0105 	strhi	r0, [pc, #-261]!	; 91b <shift+0x91b>
 a1c:	4ba10505 	blmi	fe841e38 <__bss_end+0xfe8380a8>
 a20:	0c052f4b 	stceq	15, cr2, [r5], {75}	; 0x4b
 a24:	2f01054c 	svccs	0x0001054c
 a28:	bd050585 	cfstr32lt	mvfx0, [r5, #-532]	; 0xfffffdec
 a2c:	2f4b4b4b 	svccs	0x004b4b4b
 a30:	054c0c05 	strbeq	r0, [ip, #-3077]	; 0xfffff3fb
 a34:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 a38:	4b4ba105 	blmi	12e8e54 <__bss_end+0x12df0c4>
 a3c:	4c0c052f 	cfstr32mi	mvfx0, [ip], {47}	; 0x2f
 a40:	859f0105 	ldrhi	r0, [pc, #261]	; b4d <shift+0xb4d>
 a44:	05672005 	strbeq	r2, [r7, #-5]!
 a48:	4b4b4d05 	blmi	12d3e64 <__bss_end+0x12ca0d4>
 a4c:	05300c05 	ldreq	r0, [r0, #-3077]!	; 0xfffff3fb
 a50:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 a54:	05056720 	streq	r6, [r5, #-1824]	; 0xfffff8e0
 a58:	054b4b4d 	strbeq	r4, [fp, #-2893]	; 0xfffff4b3
 a5c:	0105300c 	tsteq	r5, ip
 a60:	2005852f 	andcs	r8, r5, pc, lsr #10
 a64:	4c050583 	cfstr32mi	mvfx0, [r5], {131}	; 0x83
 a68:	01054b4b 	tsteq	r5, fp, asr #22
 a6c:	2005852f 	andcs	r8, r5, pc, lsr #10
 a70:	4d050567 	cfstr32mi	mvfx0, [r5, #-412]	; 0xfffffe64
 a74:	0c054b4b 			; <UNDEFINED> instruction: 0x0c054b4b
 a78:	2f010530 	svccs	0x00010530
 a7c:	a00c0587 	andge	r0, ip, r7, lsl #11
 a80:	bc31059f 	cfldr32lt	mvfx0, [r1], #-636	; 0xfffffd84
 a84:	05662905 	strbeq	r2, [r6, #-2309]!	; 0xfffff6fb
 a88:	0f052e36 	svceq	0x00052e36
 a8c:	66130530 			; <UNDEFINED> instruction: 0x66130530
 a90:	05840905 	streq	r0, [r4, #2309]	; 0x905
 a94:	0105d810 	tsteq	r5, r0, lsl r8
 a98:	0008029f 	muleq	r8, pc, r2	; <UNPREDICTABLE>
 a9c:	038b0101 	orreq	r0, fp, #1073741824	; 0x40000000
 aa0:	00030000 	andeq	r0, r3, r0
 aa4:	00000074 	andeq	r0, r0, r4, ror r0
 aa8:	0efb0102 	cdpeq	1, 15, cr0, cr11, cr2, {0}
 aac:	0101000d 	tsteq	r1, sp
 ab0:	00000101 	andeq	r0, r0, r1, lsl #2
 ab4:	00000100 	andeq	r0, r0, r0, lsl #2
 ab8:	73552f01 	cmpvc	r5, #1, 30
 abc:	2f737265 	svccs	0x00737265
 ac0:	746e6977 	strbtvc	r6, [lr], #-2423	; 0xfffff689
 ac4:	696a7265 	stmdbvs	sl!, {r0, r2, r5, r6, r9, ip, sp, lr}^
 ac8:	7365442f 	cmnvc	r5, #788529152	; 0x2f000000
 acc:	706f746b 	rsbvc	r7, pc, fp, ror #8
 ad0:	5641462f 	strbpl	r4, [r1], -pc, lsr #12
 ad4:	76614e2f 	strbtvc	r4, [r1], -pc, lsr #28
 ad8:	6a757a61 	bvs	1d5f464 <__bss_end+0x1d556d4>
 adc:	2f696369 	svccs	0x00696369
 ae0:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
 ae4:	73656d65 	cmnvc	r5, #6464	; 0x1940
 ae8:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
 aec:	6b2d616b 	blvs	b590a0 <__bss_end+0xb4f310>
 af0:	6f2d7669 	svcvs	0x002d7669
 af4:	6f732f73 	svcvs	0x00732f73
 af8:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
 afc:	74732f73 	ldrbtvc	r2, [r3], #-3955	; 0xfffff08d
 b00:	62696c64 	rsbvs	r6, r9, #100, 24	; 0x6400
 b04:	6372732f 	cmnvs	r2, #-1140850688	; 0xbc000000
 b08:	74730000 	ldrbtvc	r0, [r3], #-0
 b0c:	72747364 	rsbsvc	r7, r4, #100, 6	; 0x90000001
 b10:	2e676e69 	cdpcs	14, 6, cr6, cr7, cr9, {3}
 b14:	00707063 	rsbseq	r7, r0, r3, rrx
 b18:	00000001 	andeq	r0, r0, r1
 b1c:	05000105 	streq	r0, [r0, #-261]	; 0xfffffefb
 b20:	0090fc02 	addseq	pc, r0, r2, lsl #24
 b24:	06051a00 	streq	r1, [r5], -r0, lsl #20
 b28:	4c0f05bb 	cfstr32mi	mvfx0, [pc], {187}	; 0xbb
 b2c:	05682105 	strbeq	r2, [r8, #-261]!	; 0xfffffefb
 b30:	0b05ba0a 	bleq	16f360 <__bss_end+0x1655d0>
 b34:	4a27052e 	bmi	9c1ff4 <__bss_end+0x9b8264>
 b38:	054a0d05 	strbeq	r0, [sl, #-3333]	; 0xfffff2fb
 b3c:	04052f09 	streq	r2, [r5], #-3849	; 0xfffff0f7
 b40:	6202059f 	andvs	r0, r2, #666894336	; 0x27c00000
 b44:	05350505 	ldreq	r0, [r5, #-1285]!	; 0xfffffafb
 b48:	11056810 	tstne	r5, r0, lsl r8
 b4c:	4a22052e 	bmi	88200c <__bss_end+0x87827c>
 b50:	052e1305 	streq	r1, [lr, #-773]!	; 0xfffffcfb
 b54:	09052f0a 	stmdbeq	r5, {r1, r3, r8, r9, sl, fp, sp}
 b58:	2e0a0569 	cfsh32cs	mvfx0, mvfx10, #57
 b5c:	054a0c05 	strbeq	r0, [sl, #-3077]	; 0xfffff3fb
 b60:	0b054b03 	bleq	153774 <__bss_end+0x1499e4>
 b64:	00180568 	andseq	r0, r8, r8, ror #10
 b68:	4a030402 	bmi	c1b78 <__bss_end+0xb7de8>
 b6c:	02001405 	andeq	r1, r0, #83886080	; 0x5000000
 b70:	059e0304 	ldreq	r0, [lr, #772]	; 0x304
 b74:	04020015 	streq	r0, [r2], #-21	; 0xffffffeb
 b78:	18056802 	stmdane	r5, {r1, fp, sp, lr}
 b7c:	02040200 	andeq	r0, r4, #0, 4
 b80:	00080582 	andeq	r0, r8, r2, lsl #11
 b84:	4a020402 	bmi	81b94 <__bss_end+0x77e04>
 b88:	02001a05 	andeq	r1, r0, #20480	; 0x5000
 b8c:	054b0204 	strbeq	r0, [fp, #-516]	; 0xfffffdfc
 b90:	0402001b 	streq	r0, [r2], #-27	; 0xffffffe5
 b94:	0c052e02 	stceq	14, cr2, [r5], {2}
 b98:	02040200 	andeq	r0, r4, #0, 4
 b9c:	000f054a 	andeq	r0, pc, sl, asr #10
 ba0:	82020402 	andhi	r0, r2, #33554432	; 0x2000000
 ba4:	02001b05 	andeq	r1, r0, #5120	; 0x1400
 ba8:	054a0204 	strbeq	r0, [sl, #-516]	; 0xfffffdfc
 bac:	04020011 	streq	r0, [r2], #-17	; 0xffffffef
 bb0:	0a052e02 	beq	14c3c0 <__bss_end+0x142630>
 bb4:	02040200 	andeq	r0, r4, #0, 4
 bb8:	000b052f 	andeq	r0, fp, pc, lsr #10
 bbc:	2e020402 	cdpcs	4, 0, cr0, cr2, cr2, {0}
 bc0:	02000d05 	andeq	r0, r0, #320	; 0x140
 bc4:	054a0204 	strbeq	r0, [sl, #-516]	; 0xfffffdfc
 bc8:	04020002 	streq	r0, [r2], #-2
 bcc:	01054602 	tsteq	r5, r2, lsl #12
 bd0:	06058588 	streq	r8, [r5], -r8, lsl #11
 bd4:	4c090583 	cfstr32mi	mvfx0, [r9], {131}	; 0x83
 bd8:	054a1005 	strbeq	r1, [sl, #-5]
 bdc:	07054c0a 	streq	r4, [r5, -sl, lsl #24]
 be0:	4a0305bb 	bmi	c22d4 <__bss_end+0xb8544>
 be4:	02001705 	andeq	r1, r0, #1310720	; 0x140000
 be8:	054a0104 	strbeq	r0, [sl, #-260]	; 0xfffffefc
 bec:	04020014 	streq	r0, [r2], #-20	; 0xffffffec
 bf0:	0d054a01 	vstreq	s8, [r5, #-4]
 bf4:	4a14054d 	bmi	502130 <__bss_end+0x4f83a0>
 bf8:	052e0a05 	streq	r0, [lr, #-2565]!	; 0xfffff5fb
 bfc:	02056808 	andeq	r6, r5, #8, 16	; 0x80000
 c00:	05667803 	strbeq	r7, [r6, #-2051]!	; 0xfffff7fd
 c04:	2e0b0309 	cdpcs	3, 0, cr0, cr11, cr9, {0}
 c08:	852f0105 	strhi	r0, [pc, #-261]!	; b0b <shift+0xb0b>
 c0c:	05bb0805 	ldreq	r0, [fp, #2053]!	; 0x805
 c10:	0d054d05 	stceq	13, cr4, [r5, #-20]	; 0xffffffec
 c14:	66100583 	ldrvs	r0, [r0], -r3, lsl #11
 c18:	054b0f05 	strbeq	r0, [fp, #-3845]	; 0xfffff0fb
 c1c:	1c056a09 			; <UNDEFINED> instruction: 0x1c056a09
 c20:	660b0583 	strvs	r0, [fp], -r3, lsl #11
 c24:	4b05056a 	blmi	1421d4 <__bss_end+0x138444>
 c28:	05671105 	strbeq	r1, [r7, #-261]!	; 0xfffffefb
 c2c:	19056614 	stmdbne	r5, {r2, r4, r9, sl, sp, lr}
 c30:	672a0568 	strvs	r0, [sl, -r8, ror #10]!
 c34:	58081e05 	stmdapl	r8, {r0, r2, r9, sl, fp, ip}
 c38:	052e1505 	streq	r1, [lr, #-1285]!	; 0xfffffafb
 c3c:	1805661e 	stmdane	r5, {r1, r2, r3, r4, r9, sl, sp, lr}
 c40:	2f16054a 	svccs	0x0016054a
 c44:	05d40905 	ldrbeq	r0, [r4, #2309]	; 0x905
 c48:	10053514 	andne	r3, r5, r4, lsl r5
 c4c:	660d0583 	strvs	r0, [sp], -r3, lsl #11
 c50:	05661205 	strbeq	r1, [r6, #-517]!	; 0xfffffdfb
 c54:	05054a10 	streq	r4, [r5, #-2576]	; 0xfffff5f0
 c58:	0d05332d 	stceq	3, cr3, [r5, #-180]	; 0xffffff4c
 c5c:	66100567 	ldrvs	r0, [r0], -r7, ror #10
 c60:	054e0e05 	strbeq	r0, [lr, #-3589]	; 0xfffff1fb
 c64:	04020015 	streq	r0, [r2], #-21	; 0xffffffeb
 c68:	17054a03 	strne	r4, [r5, -r3, lsl #20]
 c6c:	03040200 	movweq	r0, #16896	; 0x4200
 c70:	0012052e 	andseq	r0, r2, lr, lsr #10
 c74:	67020402 	strvs	r0, [r2, -r2, lsl #8]
 c78:	02000d05 	andeq	r0, r0, #320	; 0x140
 c7c:	05830204 	streq	r0, [r3, #516]	; 0x204
 c80:	04020016 	streq	r0, [r2], #-22	; 0xffffffea
 c84:	0d058302 	stceq	3, cr8, [r5, #-8]
 c88:	02040200 	andeq	r0, r4, #0, 4
 c8c:	0016054a 	andseq	r0, r6, sl, asr #10
 c90:	66020402 	strvs	r0, [r2], -r2, lsl #8
 c94:	02001005 	andeq	r1, r0, #5
 c98:	054a0204 	strbeq	r0, [sl, #-516]	; 0xfffffdfc
 c9c:	04020012 	streq	r0, [r2], #-18	; 0xffffffee
 ca0:	05052f02 	streq	r2, [r5, #-3842]	; 0xfffff0fe
 ca4:	02040200 	andeq	r0, r4, #0, 4
 ca8:	8a0a05b6 	bhi	282388 <__bss_end+0x2785f8>
 cac:	05690505 	strbeq	r0, [r9, #-1285]!	; 0xfffffafb
 cb0:	1d05670f 	stcne	7, cr6, [r5, #-60]	; 0xffffffc4
 cb4:	00200567 	eoreq	r0, r0, r7, ror #10
 cb8:	82010402 	andhi	r0, r1, #33554432	; 0x2000000
 cbc:	02001d05 	andeq	r1, r0, #320	; 0x140
 cc0:	054a0104 	strbeq	r0, [sl, #-260]	; 0xfffffefc
 cc4:	14054b11 	strne	r4, [r5], #-2833	; 0xfffff4ef
 cc8:	49090566 	stmdbmi	r9, {r1, r2, r5, r6, r8, sl}
 ccc:	001d0531 	andseq	r0, sp, r1, lsr r5
 cd0:	82010402 	andhi	r0, r1, #33554432	; 0x2000000
 cd4:	02001a05 	andeq	r1, r0, #20480	; 0x5000
 cd8:	054a0104 	strbeq	r0, [sl, #-260]	; 0xfffffefc
 cdc:	0c054b12 			; <UNDEFINED> instruction: 0x0c054b12
 ce0:	2f01056a 	svccs	0x0001056a
 ce4:	bd0905bd 	cfstr32lt	mvfx0, [r9, #-756]	; 0xfffffd0c
 ce8:	02001605 	andeq	r1, r0, #5242880	; 0x500000
 cec:	054a0404 	strbeq	r0, [sl, #-1028]	; 0xfffffbfc
 cf0:	0402001d 	streq	r0, [r2], #-29	; 0xffffffe3
 cf4:	1e058202 	cdpne	2, 0, cr8, cr5, cr2, {0}
 cf8:	02040200 	andeq	r0, r4, #0, 4
 cfc:	0016052e 	andseq	r0, r6, lr, lsr #10
 d00:	66020402 	strvs	r0, [r2], -r2, lsl #8
 d04:	02001105 	andeq	r1, r0, #1073741825	; 0x40000001
 d08:	054b0304 	strbeq	r0, [fp, #-772]	; 0xfffffcfc
 d0c:	04020012 	streq	r0, [r2], #-18	; 0xffffffee
 d10:	08052e03 	stmdaeq	r5, {r0, r1, r9, sl, fp, sp}
 d14:	03040200 	movweq	r0, #16896	; 0x4200
 d18:	0009054a 	andeq	r0, r9, sl, asr #10
 d1c:	2e030402 	cdpcs	4, 0, cr0, cr3, cr2, {0}
 d20:	02001205 	andeq	r1, r0, #1342177280	; 0x50000000
 d24:	054a0304 	strbeq	r0, [sl, #-772]	; 0xfffffcfc
 d28:	0402000b 	streq	r0, [r2], #-11
 d2c:	02052e03 	andeq	r2, r5, #3, 28	; 0x30
 d30:	03040200 	movweq	r0, #16896	; 0x4200
 d34:	000b052d 	andeq	r0, fp, sp, lsr #10
 d38:	84020402 	strhi	r0, [r2], #-1026	; 0xfffffbfe
 d3c:	02000805 	andeq	r0, r0, #327680	; 0x50000
 d40:	05830104 	streq	r0, [r3, #260]	; 0x104
 d44:	04020009 	streq	r0, [r2], #-9
 d48:	0b052e01 	bleq	14c554 <__bss_end+0x1427c4>
 d4c:	01040200 	mrseq	r0, R12_usr
 d50:	0002054a 	andeq	r0, r2, sl, asr #10
 d54:	49010402 	stmdbmi	r1, {r1, sl}
 d58:	05850b05 	streq	r0, [r5, #2821]	; 0xb05
 d5c:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 d60:	1105bc0e 	tstne	r5, lr, lsl #24
 d64:	bc200566 	cfstr32lt	mvfx0, [r0], #-408	; 0xfffffe68
 d68:	05660b05 	strbeq	r0, [r6, #-2821]!	; 0xfffff4fb
 d6c:	0a054b1f 	beq	1539f0 <__bss_end+0x149c60>
 d70:	4b080566 	blmi	202310 <__bss_end+0x1f8580>
 d74:	05831105 	streq	r1, [r3, #261]	; 0x105
 d78:	08052e16 	stmdaeq	r5, {r1, r2, r4, r9, sl, fp, sp}
 d7c:	67110567 	ldrvs	r0, [r1, -r7, ror #10]
 d80:	054d0b05 	strbeq	r0, [sp, #-2821]	; 0xfffff4fb
 d84:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 d88:	0b058306 	bleq	1619a8 <__bss_end+0x157c18>
 d8c:	2e0c054c 	cfsh32cs	mvfx0, mvfx12, #44
 d90:	05660e05 	strbeq	r0, [r6, #-3589]!	; 0xfffff1fb
 d94:	02054b04 	andeq	r4, r5, #4, 22	; 0x1000
 d98:	31090565 	tstcc	r9, r5, ror #10
 d9c:	852f0105 	strhi	r0, [pc, #-261]!	; c9f <shift+0xc9f>
 da0:	059f0805 	ldreq	r0, [pc, #2053]	; 15ad <shift+0x15ad>
 da4:	14054c0b 	strne	r4, [r5], #-3083	; 0xfffff3f5
 da8:	03040200 	movweq	r0, #16896	; 0x4200
 dac:	0007054a 	andeq	r0, r7, sl, asr #10
 db0:	83020402 	movwhi	r0, #9218	; 0x2402
 db4:	02000805 	andeq	r0, r0, #327680	; 0x50000
 db8:	052e0204 	streq	r0, [lr, #-516]!	; 0xfffffdfc
 dbc:	0402000a 	streq	r0, [r2], #-10
 dc0:	02054a02 	andeq	r4, r5, #8192	; 0x2000
 dc4:	02040200 	andeq	r0, r4, #0, 4
 dc8:	84010549 	strhi	r0, [r1], #-1353	; 0xfffffab7
 dcc:	bb0e0585 	bllt	3823e8 <__bss_end+0x378658>
 dd0:	054b0805 	strbeq	r0, [fp, #-2053]	; 0xfffff7fb
 dd4:	14054c0b 	strne	r4, [r5], #-3083	; 0xfffff3f5
 dd8:	03040200 	movweq	r0, #16896	; 0x4200
 ddc:	0016054a 	andseq	r0, r6, sl, asr #10
 de0:	83020402 	movwhi	r0, #9218	; 0x2402
 de4:	02001705 	andeq	r1, r0, #1310720	; 0x140000
 de8:	052e0204 	streq	r0, [lr, #-516]!	; 0xfffffdfc
 dec:	0402000a 	streq	r0, [r2], #-10
 df0:	0b054a02 	bleq	153600 <__bss_end+0x149870>
 df4:	02040200 	andeq	r0, r4, #0, 4
 df8:	0017052e 	andseq	r0, r7, lr, lsr #10
 dfc:	4a020402 	bmi	81e0c <__bss_end+0x7807c>
 e00:	02000d05 	andeq	r0, r0, #320	; 0x140
 e04:	052e0204 	streq	r0, [lr, #-516]!	; 0xfffffdfc
 e08:	04020002 	streq	r0, [r2], #-2
 e0c:	01052d02 	tsteq	r5, r2, lsl #26
 e10:	842a0584 	strthi	r0, [sl], #-1412	; 0xfffffa7c
 e14:	679f1005 	ldrvs	r1, [pc, r5]
 e18:	05671105 	strbeq	r1, [r7, #-261]!	; 0xfffffefb
 e1c:	05bb2e09 	ldreq	r2, [fp, #3593]!	; 0xe09
 e20:	12056610 	andne	r6, r5, #16, 12	; 0x1000000
 e24:	4b010566 	blmi	423c4 <__bss_end+0x38634>
 e28:	01000602 	tsteq	r0, r2, lsl #12
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
      58:	0c4b0704 	mcrreq	7, 0, r0, fp, cr4
      5c:	5b020000 	blpl	80064 <__bss_end+0x762d4>
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
     128:	00000c4b 	andeq	r0, r0, fp, asr #24
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
     174:	cb104801 	blgt	412180 <__bss_end+0x4083f0>
     178:	d4000000 	strle	r0, [r0], #-0
     17c:	58000081 	stmdapl	r0, {r0, r7}
     180:	01000000 	mrseq	r0, (UNDEF: 0)
     184:	0000cb9c 	muleq	r0, ip, fp
     188:	02b40a00 	adcseq	r0, r4, #0, 20
     18c:	4a010000 	bmi	40194 <__bss_end+0x36404>
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
     21c:	ba0d9c01 	blt	367228 <__bss_end+0x35d498>
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
     24c:	8b120f01 	blhi	483e58 <__bss_end+0x47a0c8>
     250:	0f000001 	svceq	0x00000001
     254:	0000019e 	muleq	r0, lr, r1
     258:	03d51000 	bicseq	r1, r5, #0
     25c:	0a010000 	beq	40264 <__bss_end+0x364d4>
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
     2b4:	8b140074 	blhi	50048c <__bss_end+0x4f66fc>
     2b8:	a4000001 	strge	r0, [r0], #-1
     2bc:	38000080 	stmdacc	r0, {r7}
     2c0:	01000000 	mrseq	r0, (UNDEF: 0)
     2c4:	0067139c 	mlseq	r7, ip, r3, r1
     2c8:	9e2f0a01 	vmulls.f32	s0, s30, s2
     2cc:	02000001 	andeq	r0, r0, #1
     2d0:	00007491 	muleq	r0, r1, r4
     2d4:	00000d1e 	andeq	r0, r0, lr, lsl sp
     2d8:	01e00004 	mvneq	r0, r4
     2dc:	01040000 	mrseq	r0, (UNDEF: 4)
     2e0:	000001e1 	andeq	r0, r0, r1, ror #3
     2e4:	000b5104 	andeq	r5, fp, r4, lsl #2
     2e8:	00005600 	andeq	r5, r0, r0, lsl #12
     2ec:	00822c00 	addeq	r2, r2, r0, lsl #24
     2f0:	000a7400 	andeq	r7, sl, r0, lsl #8
     2f4:	00024600 	andeq	r4, r2, r0, lsl #12
     2f8:	08010200 	stmdaeq	r1, {r9}
     2fc:	00000d0a 	andeq	r0, r0, sl, lsl #26
     300:	00002503 	andeq	r2, r0, r3, lsl #10
     304:	05020200 	streq	r0, [r2, #-512]	; 0xfffffe00
     308:	00000aef 	andeq	r0, r0, pc, ror #21
     30c:	69050404 	stmdbvs	r5, {r2, sl}
     310:	0500746e 	streq	r7, [r0, #-1134]	; 0xfffffb92
     314:	00000877 	andeq	r0, r0, r7, ror r8
     318:	4b070702 	blmi	1c1f28 <__bss_end+0x1b8198>
     31c:	02000000 	andeq	r0, r0, #0
     320:	0d010801 	stceq	8, cr0, [r1, #-4]
     324:	02020000 	andeq	r0, r2, #0
     328:	000e0a07 	andeq	r0, lr, r7, lsl #20
     32c:	066e0500 	strbteq	r0, [lr], -r0, lsl #10
     330:	09020000 	stmdbeq	r2, {}	; <UNPREDICTABLE>
     334:	00006a07 	andeq	r6, r0, r7, lsl #20
     338:	00590300 	subseq	r0, r9, r0, lsl #6
     33c:	04020000 	streq	r0, [r2], #-0
     340:	000c4b07 	andeq	r4, ip, r7, lsl #22
     344:	006a0300 	rsbeq	r0, sl, r0, lsl #6
     348:	e0060000 	and	r0, r6, r0
     34c:	0800000e 	stmdaeq	r0, {r1, r2, r3}
     350:	9c080603 	stcls	6, cr0, [r8], {3}
     354:	07000000 	streq	r0, [r0, -r0]
     358:	03003072 	movweq	r3, #114	; 0x72
     35c:	00590e08 	subseq	r0, r9, r8, lsl #28
     360:	07000000 	streq	r0, [r0, -r0]
     364:	03003172 	movweq	r3, #370	; 0x172
     368:	00590e09 	subseq	r0, r9, r9, lsl #28
     36c:	00040000 	andeq	r0, r4, r0
     370:	000bb408 	andeq	fp, fp, r8, lsl #8
     374:	38040500 	stmdacc	r4, {r8, sl}
     378:	03000000 	movweq	r0, #0
     37c:	00d30c1e 	sbcseq	r0, r3, lr, lsl ip
     380:	66090000 	strvs	r0, [r9], -r0
     384:	00000006 	andeq	r0, r0, r6
     388:	00080a09 	andeq	r0, r8, r9, lsl #20
     38c:	d6090100 	strle	r0, [r9], -r0, lsl #2
     390:	0200000b 	andeq	r0, r0, #11
     394:	000d3d09 	andeq	r3, sp, r9, lsl #26
     398:	dd090300 	stcle	3, cr0, [r9, #-0]
     39c:	04000007 	streq	r0, [r0], #-7
     3a0:	000ace09 	andeq	ip, sl, r9, lsl #28
     3a4:	08000500 	stmdaeq	r0, {r8, sl}
     3a8:	00000b39 	andeq	r0, r0, r9, lsr fp
     3ac:	00380405 	eorseq	r0, r8, r5, lsl #8
     3b0:	3f030000 	svccc	0x00030000
     3b4:	0001100c 	andeq	r1, r1, ip
     3b8:	074c0900 	strbeq	r0, [ip, -r0, lsl #18]
     3bc:	09000000 	stmdbeq	r0, {}	; <UNPREDICTABLE>
     3c0:	00000805 	andeq	r0, r0, r5, lsl #16
     3c4:	0e790901 	vaddeq.f16	s1, s18, s2	; <UNPREDICTABLE>
     3c8:	09020000 	stmdbeq	r2, {}	; <UNPREDICTABLE>
     3cc:	000009f8 	strdeq	r0, [r0], -r8
     3d0:	07f10903 	ldrbeq	r0, [r1, r3, lsl #18]!
     3d4:	09040000 	stmdbeq	r4, {}	; <UNPREDICTABLE>
     3d8:	0000087f 	andeq	r0, r0, pc, ror r8
     3dc:	06ab0905 	strteq	r0, [fp], r5, lsl #18
     3e0:	00060000 	andeq	r0, r6, r0
     3e4:	00068308 	andeq	r8, r6, r8, lsl #6
     3e8:	38040500 	stmdacc	r4, {r8, sl}
     3ec:	03000000 	movweq	r0, #0
     3f0:	013b0c66 	teqeq	fp, r6, ror #24
     3f4:	f6090000 			; <UNDEFINED> instruction: 0xf6090000
     3f8:	0000000c 	andeq	r0, r0, ip
     3fc:	00059409 	andeq	r9, r5, r9, lsl #8
     400:	06090100 	streq	r0, [r9], -r0, lsl #2
     404:	0200000c 	andeq	r0, r0, #12
     408:	000ad709 	andeq	sp, sl, r9, lsl #14
     40c:	0a000300 	beq	1014 <shift+0x1014>
     410:	000009ca 	andeq	r0, r0, sl, asr #19
     414:	65140504 	ldrvs	r0, [r4, #-1284]	; 0xfffffafc
     418:	05000000 	streq	r0, [r0, #-0]
     41c:	009acc03 	addseq	ip, sl, r3, lsl #24
     420:	0c6c0a00 			; <UNDEFINED> instruction: 0x0c6c0a00
     424:	06040000 	streq	r0, [r4], -r0
     428:	00006514 	andeq	r6, r0, r4, lsl r5
     42c:	d0030500 	andle	r0, r3, r0, lsl #10
     430:	0a00009a 	beq	6a0 <shift+0x6a0>
     434:	00000894 	muleq	r0, r4, r8
     438:	651a0705 	ldrvs	r0, [sl, #-1797]	; 0xfffff8fb
     43c:	05000000 	streq	r0, [r0, #-0]
     440:	009ad403 	addseq	sp, sl, r3, lsl #8
     444:	0af90a00 	beq	ffe42c4c <__bss_end+0xffe38ebc>
     448:	09050000 	stmdbeq	r5, {}	; <UNPREDICTABLE>
     44c:	0000651a 	andeq	r6, r0, sl, lsl r5
     450:	d8030500 	stmdale	r3, {r8, sl}
     454:	0a00009a 	beq	6c4 <shift+0x6c4>
     458:	00000886 	andeq	r0, r0, r6, lsl #17
     45c:	651a0b05 	ldrvs	r0, [sl, #-2821]	; 0xfffff4fb
     460:	05000000 	streq	r0, [r0, #-0]
     464:	009adc03 	addseq	sp, sl, r3, lsl #24
     468:	0abb0a00 	beq	feec2c70 <__bss_end+0xfeeb8ee0>
     46c:	0d050000 	stceq	0, cr0, [r5, #-0]
     470:	0000651a 	andeq	r6, r0, sl, lsl r5
     474:	e0030500 	and	r0, r3, r0, lsl #10
     478:	0a00009a 	beq	6e8 <shift+0x6e8>
     47c:	00000646 	andeq	r0, r0, r6, asr #12
     480:	651a0f05 	ldrvs	r0, [sl, #-3845]	; 0xfffff0fb
     484:	05000000 	streq	r0, [r0, #-0]
     488:	009ae403 	addseq	lr, sl, r3, lsl #8
     48c:	12d20800 	sbcsne	r0, r2, #0, 16
     490:	04050000 	streq	r0, [r5], #-0
     494:	00000038 	andeq	r0, r0, r8, lsr r0
     498:	de0c1b05 	vmlale.f64	d1, d12, d5
     49c:	09000001 	stmdbeq	r0, {r0}
     4a0:	000005eb 	andeq	r0, r0, fp, ror #11
     4a4:	0d930900 	vldreq.16	s0, [r3]	; <UNPREDICTABLE>
     4a8:	09010000 	stmdbeq	r1, {}	; <UNPREDICTABLE>
     4ac:	00000e74 	andeq	r0, r0, r4, ror lr
     4b0:	590b0002 	stmdbpl	fp, {r1}
     4b4:	0c000004 	stceq	0, cr0, [r0], {4}
     4b8:	00000025 	andeq	r0, r0, r5, lsr #32
     4bc:	000001f3 	strdeq	r0, [r0], -r3
     4c0:	00006a0d 	andeq	r6, r0, sp, lsl #20
     4c4:	02000f00 	andeq	r0, r0, #0, 30
     4c8:	08f30201 	ldmeq	r3!, {r0, r9}^
     4cc:	040e0000 	streq	r0, [lr], #-0
     4d0:	0000002c 	andeq	r0, r0, ip, lsr #32
     4d4:	01de040e 	bicseq	r0, lr, lr, lsl #8
     4d8:	ff0a0000 			; <UNDEFINED> instruction: 0xff0a0000
     4dc:	06000005 	streq	r0, [r0], -r5
     4e0:	00651404 	rsbeq	r1, r5, r4, lsl #8
     4e4:	03050000 	movweq	r0, #20480	; 0x5000
     4e8:	00009ae8 	andeq	r9, r0, r8, ror #21
     4ec:	000be80a 	andeq	lr, fp, sl, lsl #16
     4f0:	14070600 	strne	r0, [r7], #-1536	; 0xfffffa00
     4f4:	00000065 	andeq	r0, r0, r5, rrx
     4f8:	9aec0305 	bls	ffb01114 <__bss_end+0xffaf7384>
     4fc:	2a0a0000 	bcs	280504 <__bss_end+0x276774>
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
     538:	2f090300 	svccs	0x00090300
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
     578:	000b2910 	andeq	r2, fp, r0, lsl r9
     57c:	13200600 	nopne	{0}	; <UNPREDICTABLE>
     580:	000002b2 			; <UNDEFINED> instruction: 0x000002b2
     584:	0402000c 	streq	r0, [r2], #-12
     588:	000c4607 	andeq	r4, ip, r7, lsl #12
     58c:	02b20300 	adcseq	r0, r2, #0, 6
     590:	d0060000 	andle	r0, r6, r0
     594:	70000007 	andvc	r0, r0, r7
     598:	4e082806 	cdpmi	8, 0, cr2, cr8, cr6, {0}
     59c:	10000003 	andne	r0, r0, r3
     5a0:	00000731 	andeq	r0, r0, r1, lsr r7
     5a4:	73122a06 	tstvc	r2, #24576	; 0x6000
     5a8:	00000002 	andeq	r0, r0, r2
     5ac:	64697007 	strbtvs	r7, [r9], #-7
     5b0:	122b0600 	eorne	r0, fp, #0, 12
     5b4:	0000006a 	andeq	r0, r0, sl, rrx
     5b8:	0a8d1010 	beq	fe344600 <__bss_end+0xfe33a870>
     5bc:	2c060000 	stccs	0, cr0, [r6], {-0}
     5c0:	00023c11 	andeq	r3, r2, r1, lsl ip
     5c4:	dc101400 	cfldrsle	mvf1, [r0], {-0}
     5c8:	0600000c 	streq	r0, [r0], -ip
     5cc:	006a122d 	rsbeq	r1, sl, sp, lsr #4
     5d0:	10180000 	andsne	r0, r8, r0
     5d4:	000003e9 	andeq	r0, r0, r9, ror #7
     5d8:	6a122e06 	bvs	48bdf8 <__bss_end+0x482068>
     5dc:	1c000000 	stcne	0, cr0, [r0], {-0}
     5e0:	000bc910 	andeq	ip, fp, r0, lsl r9
     5e4:	0c2f0600 	stceq	6, cr0, [pc], #-0	; 5ec <shift+0x5ec>
     5e8:	0000034e 	andeq	r0, r0, lr, asr #6
     5ec:	04861020 	streq	r1, [r6], #32
     5f0:	30060000 	andcc	r0, r6, r0
     5f4:	00003809 	andeq	r3, r0, r9, lsl #16
     5f8:	e4106000 	ldr	r6, [r0], #-0
     5fc:	06000006 	streq	r0, [r0], -r6
     600:	00590e31 	subseq	r0, r9, r1, lsr lr
     604:	10640000 	rsbne	r0, r4, r0
     608:	00000a62 	andeq	r0, r0, r2, ror #20
     60c:	590e3306 	stmdbpl	lr, {r1, r2, r8, r9, ip, sp}
     610:	68000000 	stmdavs	r0, {}	; <UNPREDICTABLE>
     614:	000a5910 	andeq	r5, sl, r0, lsl r9
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
     644:	0008cf08 	andeq	ip, r8, r8, lsl #30
     648:	38040500 	stmdacc	r4, {r8, sl}
     64c:	07000000 	streq	r0, [r0, -r0]
     650:	038f0c0d 	orreq	r0, pc, #3328	; 0xd00
     654:	7f090000 	svcvc	0x00090000
     658:	0000000e 	andeq	r0, r0, lr
     65c:	000da709 	andeq	sl, sp, r9, lsl #14
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
     688:	34100400 	ldrcc	r0, [r0], #-1024	; 0xfffffc00
     68c:	0700000a 	streq	r0, [r0, -sl]
     690:	03ca131f 	biceq	r1, sl, #2080374784	; 0x7c000000
     694:	00080000 	andeq	r0, r8, r0
     698:	038f040e 	orreq	r0, pc, #234881024	; 0xe000000
     69c:	040e0000 	streq	r0, [lr], #-0
     6a0:	000002be 			; <UNDEFINED> instruction: 0x000002be
     6a4:	000b0b11 	andeq	r0, fp, r1, lsl fp
     6a8:	22071400 	andcs	r1, r7, #0, 8
     6ac:	00065207 	andeq	r5, r6, r7, lsl #4
     6b0:	09d81000 	ldmibeq	r8, {ip}^
     6b4:	26070000 	strcs	r0, [r7], -r0
     6b8:	00005912 	andeq	r5, r0, r2, lsl r9
     6bc:	7a100000 	bvc	4006c4 <__bss_end+0x3f6934>
     6c0:	07000009 	streq	r0, [r0, -r9]
     6c4:	03c41d29 	biceq	r1, r4, #2624	; 0xa40
     6c8:	10040000 	andne	r0, r4, r0
     6cc:	000006d1 	ldrdeq	r0, [r0], -r1
     6d0:	c41d2c07 	ldrgt	r2, [sp], #-3079	; 0xfffff3f9
     6d4:	08000003 	stmdaeq	r0, {r0, r1}
     6d8:	0009ee12 	andeq	lr, r9, r2, lsl lr
     6dc:	0e2f0700 	cdpeq	7, 2, cr0, cr15, cr0, {0}
     6e0:	000006f0 	strdeq	r0, [r0], -r0	; <UNPREDICTABLE>
     6e4:	00000418 	andeq	r0, r0, r8, lsl r4
     6e8:	00000423 	andeq	r0, r0, r3, lsr #8
     6ec:	00065713 	andeq	r5, r6, r3, lsl r7
     6f0:	03c41400 	biceq	r1, r4, #0, 8
     6f4:	15000000 	strne	r0, [r0, #-0]
     6f8:	00000824 	andeq	r0, r0, r4, lsr #16
     6fc:	a70e3107 	strge	r3, [lr, -r7, lsl #2]
     700:	f3000007 	vhadd.u8	d0, d0, d7
     704:	3b000001 	blcc	710 <shift+0x710>
     708:	46000004 	strmi	r0, [r0], -r4
     70c:	13000004 	movwne	r0, #4
     710:	00000657 	andeq	r0, r0, r7, asr r6
     714:	0003ca14 	andeq	ip, r3, r4, lsl sl
     718:	43160000 	tstmi	r6, #0
     71c:	0700000d 	streq	r0, [r0, -sp]
     720:	08aa1d35 	stmiaeq	sl!, {r0, r2, r4, r5, r8, sl, fp, ip}
     724:	03c40000 	biceq	r0, r4, #0
     728:	5f020000 	svcpl	0x00020000
     72c:	65000004 	strvs	r0, [r0, #-4]
     730:	13000004 	movwne	r0, #4
     734:	00000657 	andeq	r0, r0, r7, asr r6
     738:	06bc1600 	ldrteq	r1, [ip], r0, lsl #12
     73c:	37070000 	strcc	r0, [r7, -r0]
     740:	0009fe1d 	andeq	pc, r9, sp, lsl lr	; <UNPREDICTABLE>
     744:	0003c400 	andeq	ip, r3, r0, lsl #8
     748:	047e0200 	ldrbteq	r0, [lr], #-512	; 0xfffffe00
     74c:	04840000 	streq	r0, [r4], #0
     750:	57130000 	ldrpl	r0, [r3, -r0]
     754:	00000006 	andeq	r0, r0, r6
     758:	00098d17 	andeq	r8, r9, r7, lsl sp
     75c:	31390700 	teqcc	r9, r0, lsl #14
     760:	00000670 	andeq	r0, r0, r0, ror r6
     764:	0b16020c 	bleq	580f9c <__bss_end+0x57720c>
     768:	0700000b 	streq	r0, [r0, -fp]
     76c:	0833093c 	ldmdaeq	r3!, {r2, r3, r4, r5, r8, fp}
     770:	06570000 	ldrbeq	r0, [r7], -r0
     774:	ab010000 	blge	4077c <__bss_end+0x369ec>
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
     7b4:	00000d9e 	muleq	r0, lr, sp
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
     7ec:	0bf31600 	bleq	ffcc5ff4 <__bss_end+0xffcbc264>
     7f0:	48070000 	stmdami	r7, {}	; <UNPREDICTABLE>
     7f4:	0003ff17 	andeq	pc, r3, r7, lsl pc	; <UNPREDICTABLE>
     7f8:	0003ca00 	andeq	ip, r3, r0, lsl #20
     7fc:	05320100 	ldreq	r0, [r2, #-256]!	; 0xffffff00
     800:	053d0000 	ldreq	r0, [sp, #-0]!
     804:	7f130000 	svcvc	0x00130000
     808:	14000006 	strne	r0, [r0], #-6
     80c:	00000059 	andeq	r0, r0, r9, asr r0
     810:	06501800 	ldrbeq	r1, [r0], -r0, lsl #16
     814:	4b070000 	blmi	1c081c <__bss_end+0x1b6a8c>
     818:	00099b0e 	andeq	r9, r9, lr, lsl #22
     81c:	05520100 	ldrbeq	r0, [r2, #-256]	; 0xffffff00
     820:	05580000 	ldrbeq	r0, [r8, #-0]
     824:	57130000 	ldrpl	r0, [r3, -r0]
     828:	00000006 	andeq	r0, r0, r6
     82c:	00082416 	andeq	r2, r8, r6, lsl r4
     830:	0e4d0700 	cdpeq	7, 4, cr0, cr13, cr0, {0}
     834:	00000a93 	muleq	r0, r3, sl
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
     87c:	00000db2 			; <UNDEFINED> instruction: 0x00000db2
     880:	000001f3 	strdeq	r0, [r0], -r3
     884:	0005b901 	andeq	fp, r5, r1, lsl #18
     888:	0005c400 	andeq	ip, r5, r0, lsl #8
     88c:	06571300 	ldrbeq	r1, [r7], -r0, lsl #6
     890:	59140000 	ldmdbpl	r4, {}	; <UNPREDICTABLE>
     894:	00000000 	andeq	r0, r0, r0
     898:	0004a018 	andeq	sl, r4, r8, lsl r0
     89c:	0e560700 	cdpeq	7, 5, cr0, cr6, cr0, {0}
     8a0:	00000c78 	andeq	r0, r0, r8, ror ip
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
     8cc:	000df418 	andeq	pc, sp, r8, lsl r4	; <UNPREDICTABLE>
     8d0:	0e580700 	cdpeq	7, 5, cr0, cr8, cr0, {0}
     8d4:	00000e94 	muleq	r0, r4, lr
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
     908:	00000914 	andeq	r0, r0, r4, lsl r9
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
     94c:	4b040e00 	blmi	104154 <__bss_end+0xfa3c4>
     950:	0e000000 	cdpeq	0, 0, cr0, cr0, cr0, {0}
     954:	00065204 	andeq	r5, r6, r4, lsl #4
     958:	76041c00 	strvc	r1, [r4], -r0, lsl #24
     95c:	1d000000 	stcne	0, cr0, [r0, #-0]
     960:	61681e04 	cmnvs	r8, r4, lsl #28
     964:	0508006c 	streq	r0, [r8, #-108]	; 0xffffff94
     968:	0007570b 	andeq	r5, r7, fp, lsl #14
     96c:	09671f00 	stmdbeq	r7!, {r8, r9, sl, fp, ip}^
     970:	07080000 	streq	r0, [r8, -r0]
     974:	00007119 	andeq	r7, r0, r9, lsl r1
     978:	e6b28000 	ldrt	r8, [r2], r0
     97c:	0c1d1f0e 	ldceq	15, cr1, [sp], {14}
     980:	0a080000 	beq	200988 <__bss_end+0x1f6bf8>
     984:	0002b91a 	andeq	fp, r2, sl, lsl r9
     988:	00000000 	andeq	r0, r0, r0
     98c:	05511f20 	ldrbeq	r1, [r1, #-3872]	; 0xfffff0e0
     990:	0d080000 	stceq	0, cr0, [r8, #-0]
     994:	0002b91a 	andeq	fp, r2, sl, lsl r9
     998:	20000000 	andcs	r0, r0, r0
     99c:	08e42020 	stmiaeq	r4!, {r5, sp}^
     9a0:	10080000 	andne	r0, r8, r0
     9a4:	00006515 	andeq	r6, r0, r5, lsl r5
     9a8:	4f1f3600 	svcmi	0x001f3600
     9ac:	0800000d 	stmdaeq	r0, {r0, r2, r3}
     9b0:	02b91a42 	adcseq	r1, r9, #270336	; 0x42000
     9b4:	50000000 	andpl	r0, r0, r0
     9b8:	4a1f2021 	bmi	7c8a44 <__bss_end+0x7becb4>
     9bc:	0800000e 	stmdaeq	r0, {r1, r2, r3}
     9c0:	02b91a71 	adcseq	r1, r9, #462848	; 0x71000
     9c4:	b2000000 	andlt	r0, r0, #0
     9c8:	611f2000 	tstvs	pc, r0
     9cc:	08000007 	stmdaeq	r0, {r0, r1, r2}
     9d0:	02b91aa4 	adcseq	r1, r9, #164, 20	; 0xa4000
     9d4:	b4000000 	strlt	r0, [r0], #-0
     9d8:	571f2000 	ldrpl	r2, [pc, -r0]
     9dc:	08000009 	stmdaeq	r0, {r0, r3}
     9e0:	02b91ab3 	adcseq	r1, r9, #733184	; 0xb3000
     9e4:	40000000 	andmi	r0, r0, r0
     9e8:	241f2010 	ldrcs	r2, [pc], #-16	; 9f0 <shift+0x9f0>
     9ec:	0800000a 	stmdaeq	r0, {r1, r3}
     9f0:	02b91abe 	adcseq	r1, r9, #778240	; 0xbe000
     9f4:	50000000 	andpl	r0, r0, r0
     9f8:	a11f2020 	tstge	pc, r0, lsr #32
     9fc:	08000006 	stmdaeq	r0, {r1, r2}
     a00:	02b91abf 	adcseq	r1, r9, #782336	; 0xbf000
     a04:	40000000 	andmi	r0, r0, r0
     a08:	581f2080 	ldmdapl	pc, {r7, sp}	; <UNPREDICTABLE>
     a0c:	0800000d 	stmdaeq	r0, {r0, r2, r3}
     a10:	02b91ac0 	adcseq	r1, r9, #192, 20	; 0xc0000
     a14:	50000000 	andpl	r0, r0, r0
     a18:	201f2080 	andscs	r2, pc, r0, lsl #1
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
     a68:	00000c60 	andeq	r0, r0, r0, ror #24
     a6c:	65140809 	ldrvs	r0, [r4, #-2057]	; 0xfffff7f7
     a70:	05000000 	streq	r0, [r0, #-0]
     a74:	009b2803 	addseq	r2, fp, r3, lsl #16
     a78:	0d6f0800 	stcleq	8, cr0, [pc, #-0]	; a80 <shift+0xa80>
     a7c:	04050000 	streq	r0, [r5], #-0
     a80:	00000038 	andeq	r0, r0, r8, lsr r0
     a84:	ca0c0d0a 	bgt	303eb4 <__bss_end+0x2fa124>
     a88:	09000007 	stmdbeq	r0, {r0, r1, r2}
     a8c:	0000081d 	andeq	r0, r0, sp, lsl r8
     a90:	09610900 	stmdbeq	r1!, {r8, fp}^
     a94:	09010000 	stmdbeq	r1, {}	; <UNPREDICTABLE>
     a98:	00000a39 	andeq	r0, r0, r9, lsr sl
     a9c:	a5030002 	strge	r0, [r3, #-2]
     aa0:	06000007 	streq	r0, [r0], -r7
     aa4:	000004da 	ldrdeq	r0, [r0], -sl
     aa8:	08150a02 	ldmdaeq	r5, {r1, r9, fp}
     aac:	000007f7 	strdeq	r0, [r0], -r7
     ab0:	000c5810 	andeq	r5, ip, r0, lsl r8
     ab4:	0d170a00 	vldreq	s0, [r7, #-0]
     ab8:	0000003f 	andeq	r0, r0, pc, lsr r0
     abc:	0e3d1000 	cdpeq	0, 3, cr1, cr13, cr0, {0}
     ac0:	180a0000 	stmdane	sl, {}	; <UNPREDICTABLE>
     ac4:	00003f0d 	andeq	r3, r0, sp, lsl #30
     ac8:	0a000100 	beq	ed0 <shift+0xed0>
     acc:	0000059f 	muleq	r0, pc, r5	; <UNPREDICTABLE>
     ad0:	6514080b 	ldrvs	r0, [r4, #-2059]	; 0xfffff7f5
     ad4:	05000000 	streq	r0, [r0, #-0]
     ad8:	009b2c03 	addseq	r2, fp, r3, lsl #24
     adc:	0dde0a00 	vldreq	s1, [lr]
     ae0:	070c0000 	streq	r0, [ip, -r0]
     ae4:	00006514 	andeq	r6, r0, r4, lsl r5
     ae8:	30030500 	andcc	r0, r3, r0, lsl #10
     aec:	0a00009b 	beq	d60 <shift+0xd60>
     af0:	00000cea 	andeq	r0, r0, sl, ror #25
     af4:	34110901 	ldrcc	r0, [r1], #-2305	; 0xfffff6ff
     af8:	05000008 	streq	r0, [r0, #-8]
     afc:	009b3403 	addseq	r3, fp, r3, lsl #8
     b00:	04040200 	streq	r0, [r4], #-512	; 0xfffffe00
     b04:	00000694 	muleq	r0, r4, r6
     b08:	00082d03 	andeq	r2, r8, r3, lsl #26
     b0c:	06770a00 	ldrbteq	r0, [r7], -r0, lsl #20
     b10:	0a010000 	beq	40b18 <__bss_end+0x36d88>
     b14:	00083411 	andeq	r3, r8, r1, lsl r4
     b18:	38030500 	stmdacc	r3, {r8, sl}
     b1c:	0a00009b 	beq	d90 <shift+0xd90>
     b20:	0000085d 	andeq	r0, r0, sp, asr r8
     b24:	65140c01 	ldrvs	r0, [r4, #-3073]	; 0xfffff3ff
     b28:	05000000 	streq	r0, [r0, #-0]
     b2c:	009b3c03 	addseq	r3, fp, r3, lsl #24
     b30:	08560a00 	ldmdaeq	r6, {r9, fp}^
     b34:	0d010000 	stceq	0, cr0, [r1, #-0]
     b38:	00006514 	andeq	r6, r0, r4, lsl r5
     b3c:	40030500 	andmi	r0, r3, r0, lsl #10
     b40:	0a00009b 	beq	db4 <shift+0xdb4>
     b44:	00000c39 	andeq	r0, r0, r9, lsr ip
     b48:	ca150e01 	bgt	544354 <__bss_end+0x53a5c4>
     b4c:	05000007 	streq	r0, [r0, #-7]
     b50:	009b4403 	addseq	r4, fp, r3, lsl #8
     b54:	09e22200 	stmibeq	r2!, {r9, sp}^
     b58:	0f010000 	svceq	0x00010000
     b5c:	0007a50b 	andeq	sl, r7, fp, lsl #10
     b60:	e8030500 	stmda	r3, {r8, sl}
     b64:	2200009c 	andcs	r0, r0, #156	; 0x9c
     b68:	000004f3 	strdeq	r0, [r0], -r3
     b6c:	590a1101 	stmdbpl	sl, {r0, r8, ip}
     b70:	05000000 	streq	r0, [r0, #-0]
     b74:	009cf003 	addseq	pc, ip, r3
     b78:	07ff2200 	ldrbeq	r2, [pc, r0, lsl #4]!
     b7c:	11010000 	mrsne	r0, (UNDEF: 1)
     b80:	00005912 	andeq	r5, r0, r2, lsl r9
     b84:	f4030500 	vst3.8	{d0,d2,d4}, [r3], r0
     b88:	2200009c 	andcs	r0, r0, #156	; 0x9c
     b8c:	0000069a 	muleq	r0, sl, r6
     b90:	59191101 	ldmdbpl	r9, {r0, r8, ip}
     b94:	05000000 	streq	r0, [r0, #-0]
     b98:	009cf803 	addseq	pc, ip, r3, lsl #16
     b9c:	08340c00 	ldmdaeq	r4!, {sl, fp}
     ba0:	08d90000 	ldmeq	r9, {}^	; <UNPREDICTABLE>
     ba4:	6a0d0000 	bvs	340bac <__bss_end+0x336e1c>
     ba8:	07000000 	streq	r0, [r0, -r0]
     bac:	08c90300 	stmiaeq	r9, {r8, r9}^
     bb0:	85230000 	strhi	r0, [r3, #-0]!
     bb4:	0100000d 	tsteq	r0, sp
     bb8:	08d90d13 	ldmeq	r9, {r0, r1, r4, r8, sl, fp}^
     bbc:	03050000 	movweq	r0, #20480	; 0x5000
     bc0:	00009b48 	andeq	r9, r0, r8, asr #22
     bc4:	00086523 	andeq	r6, r8, r3, lsr #10
     bc8:	10160100 	andsne	r0, r6, r0, lsl #2
     bcc:	00000065 	andeq	r0, r0, r5, rrx
     bd0:	9b680305 	blls	1a017ec <__bss_end+0x19f7a5c>
     bd4:	1d220000 	stcne	0, cr0, [r2, #-0]
     bd8:	0100000e 	tsteq	r0, lr
     bdc:	082d0717 	stmdaeq	sp!, {r0, r1, r2, r4, r8, r9, sl}
     be0:	03050000 	movweq	r0, #20480	; 0x5000
     be4:	00009cec 	andeq	r9, r0, ip, ror #25
     be8:	00082d0c 	andeq	r2, r8, ip, lsl #26
     bec:	00092400 	andeq	r2, r9, r0, lsl #8
     bf0:	006a0d00 	rsbeq	r0, sl, r0, lsl #26
     bf4:	001f0000 	andseq	r0, pc, r0
     bf8:	000e6422 	andeq	r6, lr, r2, lsr #8
     bfc:	07190100 	ldreq	r0, [r9, -r0, lsl #2]
     c00:	00000914 	andeq	r0, r0, r4, lsl r9
     c04:	9cfc0305 	ldclls	3, cr0, [ip], #20
     c08:	6b220000 	blvs	880c10 <__bss_end+0x876e80>
     c0c:	0100000a 	tsteq	r0, sl
     c10:	00590a1a 	subseq	r0, r9, sl, lsl sl
     c14:	03050000 	movweq	r0, #20480	; 0x5000
     c18:	00009d7c 	andeq	r9, r0, ip, ror sp
     c1c:	000e2824 	andeq	r2, lr, r4, lsr #16
     c20:	05ed0100 	strbeq	r0, [sp, #256]!	; 0x100
     c24:	00000038 	andeq	r0, r0, r8, lsr r0
     c28:	00008b24 	andeq	r8, r0, r4, lsr #22
     c2c:	0000017c 	andeq	r0, r0, ip, ror r1
     c30:	09af9c01 	stmibeq	pc!, {r0, sl, fp, ip, pc}	; <UNPREDICTABLE>
     c34:	43250000 			; <UNDEFINED> instruction: 0x43250000
     c38:	0100000a 	tsteq	r0, sl
     c3c:	00380eed 	eorseq	r0, r8, sp, ror #29
     c40:	91020000 	mrsls	r0, (UNDEF: 2)
     c44:	07ec254c 	strbeq	r2, [ip, ip, asr #10]!
     c48:	ed010000 	stc	0, cr0, [r1, #-0]
     c4c:	0009af1b 	andeq	sl, r9, fp, lsl pc
     c50:	48910200 	ldmmi	r1, {r9}
     c54:	000ce223 	andeq	lr, ip, r3, lsr #4
     c58:	0eef0100 	cdpeq	1, 14, cr0, cr15, cr0, {0}
     c5c:	00000059 	andeq	r0, r0, r9, asr r0
     c60:	23749102 	cmncs	r4, #-2147483648	; 0x80000000
     c64:	0000049b 	muleq	r0, fp, r4
     c68:	bb0af001 	bllt	2bcc74 <__bss_end+0x2b2ee4>
     c6c:	02000009 	andeq	r0, r0, #9
     c70:	7f265491 	svcvc	0x00265491
     c74:	01000004 	tsteq	r0, r4
     c78:	cf170102 	svcgt	0x00170102
     c7c:	02000007 	andeq	r0, r0, #7
     c80:	0e005091 	mcreq	0, 0, r5, cr0, cr1, {4}
     c84:	0009b504 	andeq	fp, r9, r4, lsl #10
     c88:	25040e00 	strcs	r0, [r4, #-3584]	; 0xfffff200
     c8c:	0c000000 	stceq	0, cr0, [r0], {-0}
     c90:	00000025 	andeq	r0, r0, r5, lsr #32
     c94:	000009cb 	andeq	r0, r0, fp, asr #19
     c98:	00006a0d 	andeq	r6, r0, sp, lsl #20
     c9c:	27001f00 	strcs	r1, [r0, -r0, lsl #30]
     ca0:	00000a2e 	andeq	r0, r0, lr, lsr #20
     ca4:	5106e301 	tstpl	r6, r1, lsl #6
     ca8:	b0000007 	andlt	r0, r0, r7
     cac:	7400008a 	strvc	r0, [r0], #-138	; 0xffffff76
     cb0:	01000000 	mrseq	r0, (UNDEF: 0)
     cb4:	0009f59c 	muleq	r9, ip, r5
     cb8:	0ce22300 	stcleq	3, cr2, [r2]
     cbc:	e4010000 	str	r0, [r1], #-0
     cc0:	0000590e 	andeq	r5, r0, lr, lsl #18
     cc4:	74910200 	ldrvc	r0, [r1], #512	; 0x200
     cc8:	0c2d2700 	stceq	7, cr2, [sp], #-0
     ccc:	d7010000 	strle	r0, [r1, -r0]
     cd0:	000a4806 	andeq	r4, sl, r6, lsl #16
     cd4:	008a7000 	addeq	r7, sl, r0
     cd8:	00004000 	andeq	r4, r0, r0
     cdc:	2e9c0100 	fmlcse	f0, f4, f0
     ce0:	2300000a 	movwcs	r0, #10
     ce4:	0000049b 	muleq	r0, fp, r4
     ce8:	2e0ad801 	cdpcs	8, 0, cr13, cr10, cr1, {0}
     cec:	0200000a 	andeq	r0, r0, #10
     cf0:	6d286c91 	stcvs	12, cr6, [r8, #-580]!	; 0xfffffdbc
     cf4:	01006773 	tsteq	r0, r3, ror r7
     cf8:	09bb13d8 	ldmibeq	fp!, {r3, r4, r6, r7, r8, r9, ip}
     cfc:	91020000 	mrsls	r0, (UNDEF: 2)
     d00:	250c004c 	strcs	r0, [ip, #-76]	; 0xffffffb4
     d04:	3e000000 	cdpcc	0, 0, cr0, cr0, cr0, {0}
     d08:	0d00000a 	stceq	0, cr0, [r0, #-40]	; 0xffffffd8
     d0c:	0000006a 	andeq	r0, r0, sl, rrx
     d10:	72270008 	eorvc	r0, r7, #8
     d14:	01000004 	tsteq	r0, r4
     d18:	0cca06c4 	stcleq	6, cr0, [sl], {196}	; 0xc4
     d1c:	89b00000 	ldmibhi	r0!, {}	; <UNPREDICTABLE>
     d20:	00c00000 	sbceq	r0, r0, r0
     d24:	9c010000 	stcls	0, cr0, [r1], {-0}
     d28:	00000a95 	muleq	r0, r5, sl
     d2c:	00049b23 	andeq	r9, r4, r3, lsr #22
     d30:	0ac60100 	beq	ff181138 <__bss_end+0xff1773a8>
     d34:	00000a95 	muleq	r0, r5, sl
     d38:	23709102 	cmncs	r0, #-2147483648	; 0x80000000
     d3c:	00000a7f 	andeq	r0, r0, pc, ror sl
     d40:	bb13c601 	bllt	4f254c <__bss_end+0x4e87bc>
     d44:	02000009 	andeq	r0, r0, #9
     d48:	87235091 			; <UNDEFINED> instruction: 0x87235091
     d4c:	0100000a 	tsteq	r0, sl
     d50:	00250ac9 	eoreq	r0, r5, r9, asr #21
     d54:	91020000 	mrsls	r0, (UNDEF: 2)
     d58:	050d2377 	streq	r2, [sp, #-887]	; 0xfffffc89
     d5c:	ca010000 	bgt	40d64 <__bss_end+0x36fd4>
     d60:	00082d0b 	andeq	r2, r8, fp, lsl #26
     d64:	4c910200 	lfmmi	f0, 4, [r1], {0}
     d68:	00250c00 	eoreq	r0, r5, r0, lsl #24
     d6c:	0aa50000 	beq	fe940d74 <__bss_end+0xfe936fe4>
     d70:	6a0d0000 	bvs	340d78 <__bss_end+0x336fe8>
     d74:	05000000 	streq	r0, [r0, #-0]
     d78:	0d792700 	ldcleq	7, cr2, [r9, #-0]
     d7c:	a8010000 	stmdage	r1, {}	; <UNPREDICTABLE>
     d80:	00078006 	andeq	r8, r7, r6
     d84:	00889c00 	addeq	r9, r8, r0, lsl #24
     d88:	00011400 	andeq	r1, r1, r0, lsl #8
     d8c:	fc9c0100 	ldc2	1, cr0, [ip], {0}
     d90:	2500000a 	strcs	r0, [r0, #-10]
     d94:	00000a87 	andeq	r0, r0, r7, lsl #21
     d98:	2517a801 	ldrcs	sl, [r7, #-2049]	; 0xfffff7ff
     d9c:	02000000 	andeq	r0, r0, #0
     da0:	0d254791 	stceq	7, cr4, [r5, #-580]!	; 0xfffffdbc
     da4:	01000005 	tsteq	r0, r5
     da8:	082d2aa8 	stmdaeq	sp!, {r3, r5, r7, r9, fp, sp}
     dac:	91020000 	mrsls	r0, (UNDEF: 2)
     db0:	0a7f2340 	beq	1fc9ab8 <__bss_end+0x1fbfd28>
     db4:	aa010000 	bge	40dbc <__bss_end+0x3702c>
     db8:	0009bb0a 	andeq	fp, r9, sl, lsl #22
     dbc:	58910200 	ldmpl	r1, {r9}
     dc0:	0005f523 	andeq	pc, r5, r3, lsr #10
     dc4:	17aa0100 	strne	r0, [sl, r0, lsl #2]!
     dc8:	000001e3 	andeq	r0, r0, r3, ror #3
     dcc:	00489102 	subeq	r9, r8, r2, lsl #2
     dd0:	000b2f29 	andeq	r2, fp, r9, lsr #30
     dd4:	06800100 	streq	r0, [r0], r0, lsl #2
     dd8:	00000d62 	andeq	r0, r0, r2, ror #26
     ddc:	000001f3 	strdeq	r0, [r0], -r3
     de0:	000086cc 	andeq	r8, r0, ip, asr #13
     de4:	000001d0 	ldrdeq	r0, [r0], -r0	; <UNPREDICTABLE>
     de8:	0b599c01 	bleq	1667df4 <__bss_end+0x165e064>
     dec:	92250000 	eorls	r0, r5, #0
     df0:	01000007 	tsteq	r0, r7
     df4:	07a51a80 	streq	r1, [r5, r0, lsl #21]!
     df8:	91030000 	mrsls	r0, (UNDEF: 3)
     dfc:	e9237fac 	stmdb	r3!, {r2, r3, r5, r7, r8, r9, sl, fp, ip, sp, lr}
     e00:	01000009 	tsteq	r0, r9
     e04:	0b590a82 	bleq	1643814 <__bss_end+0x1639a84>
     e08:	91020000 	mrsls	r0, (UNDEF: 2)
     e0c:	049b2374 	ldreq	r2, [fp], #884	; 0x374
     e10:	82010000 	andhi	r0, r1, #0
     e14:	0009bb13 	andeq	fp, r9, r3, lsl fp
     e18:	54910200 	ldrpl	r0, [r1], #512	; 0x200
     e1c:	000a7f23 	andeq	r7, sl, r3, lsr #30
     e20:	1d820100 	stfnes	f0, [r2]
     e24:	000009bb 			; <UNDEFINED> instruction: 0x000009bb
     e28:	7fb49103 	svcvc	0x00b49103
     e2c:	00250c00 	eoreq	r0, r5, r0, lsl #24
     e30:	0b690000 	bleq	1a40e38 <__bss_end+0x1a370a8>
     e34:	6a0d0000 	bvs	340e3c <__bss_end+0x3370ac>
     e38:	03000000 	movweq	r0, #0
     e3c:	0bdc2900 	bleq	ff70b244 <__bss_end+0xff7014b4>
     e40:	5c010000 	stcpl	0, cr0, [r1], {-0}
     e44:	0008f80b 	andeq	pc, r8, fp, lsl #16
     e48:	0007a500 	andeq	sl, r7, r0, lsl #10
     e4c:	0085d400 	addeq	sp, r5, r0, lsl #8
     e50:	0000f800 	andeq	pc, r0, r0, lsl #16
     e54:	b59c0100 	ldrlt	r0, [ip, #256]	; 0x100
     e58:	2500000b 	strcs	r0, [r0, #-11]
     e5c:	0000079f 	muleq	r0, pc, r7	; <UNPREDICTABLE>
     e60:	a5215c01 	strge	r5, [r1, #-3073]!	; 0xfffff3ff
     e64:	02000007 	andeq	r0, r0, #7
     e68:	90256c91 	mlals	r5, r1, ip, r6
     e6c:	01000004 	tsteq	r0, r4
     e70:	09b5305c 	ldmibeq	r5!, {r2, r3, r4, r6, ip, sp}
     e74:	91020000 	mrsls	r0, (UNDEF: 2)
     e78:	07262368 	streq	r2, [r6, -r8, ror #6]!
     e7c:	5e010000 	cdppl	0, 0, cr0, cr1, cr0, {0}
     e80:	0007a50f 	andeq	sl, r7, pc, lsl #10
     e84:	74910200 	ldrvc	r0, [r1], #512	; 0x200
     e88:	05082700 	streq	r2, [r8, #-1792]	; 0xfffff900
     e8c:	50010000 	andpl	r0, r1, r0
     e90:	000e2d06 	andeq	r2, lr, r6, lsl #26
     e94:	00853000 	addeq	r3, r5, r0
     e98:	0000a400 	andeq	sl, r0, r0, lsl #8
     e9c:	fd9c0100 	ldc2	1, cr0, [ip]
     ea0:	2500000b 	strcs	r0, [r0, #-11]
     ea4:	0000050d 	andeq	r0, r0, sp, lsl #10
     ea8:	341d5001 	ldrcc	r5, [sp], #-1
     eac:	02000008 	andeq	r0, r0, #8
     eb0:	70284c91 	mlavc	r8, r1, ip, r4
     eb4:	01006d6f 	tsteq	r0, pc, ror #26
     eb8:	0bfd0a51 	bleq	fff43804 <__bss_end+0xfff39a74>
     ebc:	91020000 	mrsls	r0, (UNDEF: 2)
     ec0:	049b2370 	ldreq	r2, [fp], #880	; 0x370
     ec4:	51010000 	mrspl	r0, (UNDEF: 1)
     ec8:	0009bb12 	andeq	fp, r9, r2, lsl fp
     ecc:	50910200 	addspl	r0, r1, r0, lsl #4
     ed0:	00250c00 	eoreq	r0, r5, r0, lsl #24
     ed4:	0c0d0000 	stceq	0, cr0, [sp], {-0}
     ed8:	6a0d0000 	bvs	340ee0 <__bss_end+0x337150>
     edc:	04000000 	streq	r0, [r0], #-0
     ee0:	07762700 	ldrbeq	r2, [r6, -r0, lsl #14]!
     ee4:	3b010000 	blcc	40eec <__bss_end+0x3715c>
     ee8:	00058606 	andeq	r8, r5, r6, lsl #12
     eec:	00843400 	addeq	r3, r4, r0, lsl #8
     ef0:	0000fc00 	andeq	pc, r0, r0, lsl #24
     ef4:	559c0100 	ldrpl	r0, [ip, #256]	; 0x100
     ef8:	2500000c 	strcs	r0, [r0, #-12]
     efc:	0000050d 	andeq	r0, r0, sp, lsl #10
     f00:	341c3b01 	ldrcc	r3, [ip], #-2817	; 0xfffff4ff
     f04:	02000008 	andeq	r0, r0, #8
     f08:	1c236491 	cfstrsne	mvf6, [r3], #-580	; 0xfffffdbc
     f0c:	0100000b 	tsteq	r0, fp
     f10:	082d0b3d 	stmdaeq	sp!, {r0, r2, r3, r4, r5, r8, r9, fp}
     f14:	91020000 	mrsls	r0, (UNDEF: 2)
     f18:	736d2874 	cmnvc	sp, #116, 16	; 0x740000
     f1c:	3e010067 	cdpcc	0, 0, cr0, cr1, cr7, {3}
     f20:	000a950a 	andeq	r9, sl, sl, lsl #10
     f24:	6c910200 	lfmvs	f0, 4, [r1], {0}
     f28:	6f6c2a00 	svcvs	0x006c2a00
     f2c:	34010067 	strcc	r0, [r1], #-103	; 0xffffff99
     f30:	0007f706 	andeq	pc, r7, r6, lsl #14
     f34:	0083c000 	addeq	ip, r3, r0
     f38:	00007400 	andeq	r7, r0, r0, lsl #8
     f3c:	9f9c0100 	svcls	0x009c0100
     f40:	2500000c 	strcs	r0, [r0, #-12]
     f44:	0000050d 	andeq	r0, r0, sp, lsl #10
     f48:	65193401 	ldrvs	r3, [r9, #-1025]	; 0xfffffbff
     f4c:	03000000 	movweq	r0, #0
     f50:	237fac91 	cmncs	pc, #37120	; 0x9100
     f54:	0000049b 	muleq	r0, fp, r4
     f58:	bb0a3501 	bllt	28e364 <__bss_end+0x2845d4>
     f5c:	02000009 	andeq	r0, r0, #9
     f60:	70285091 	mlavc	r8, r1, r0, r5
     f64:	01006d6f 	tsteq	r0, pc, ror #26
     f68:	09bb1435 	ldmibeq	fp!, {r0, r2, r4, r5, sl, ip}
     f6c:	91030000 	mrsls	r0, (UNDEF: 3)
     f70:	2a007fb0 	bcs	20e38 <__bss_end+0x170a8>
     f74:	00676f6c 	rsbeq	r6, r7, ip, ror #30
     f78:	6c062d01 	stcvs	13, cr2, [r6], {1}
     f7c:	d8000007 	stmdale	r0, {r0, r1, r2}
     f80:	e8000082 	stmda	r0, {r1, r7}
     f84:	01000000 	mrseq	r0, (UNDEF: 0)
     f88:	000cd99c 	muleq	ip, ip, r9
     f8c:	736d2b00 	cmnvc	sp, #0, 22
     f90:	2d010067 	stccs	0, cr0, [r1, #-412]	; 0xfffffe64
     f94:	0001fa16 	andeq	pc, r1, r6, lsl sl	; <UNPREDICTABLE>
     f98:	54910200 	ldrpl	r0, [r1], #512	; 0x200
     f9c:	00081423 	andeq	r1, r8, r3, lsr #8
     fa0:	0a2f0100 	beq	bc13a8 <__bss_end+0xbb7618>
     fa4:	00000cd9 	ldrdeq	r0, [r0], -r9
     fa8:	06589103 	ldrbeq	r9, [r8], -r3, lsl #2
     fac:	00250c00 	eoreq	r0, r5, r0, lsl #24
     fb0:	0cec0000 	stcleq	0, cr0, [ip]
     fb4:	6a2c0000 	bvs	b00fbc <__bss_end+0xaf722c>
     fb8:	03000000 	movweq	r0, #0
     fbc:	00065c91 	muleq	r6, r1, ip
     fc0:	00084d2d 	andeq	r4, r8, sp, lsr #26
     fc4:	061c0100 	ldreq	r0, [ip], -r0, lsl #2
     fc8:	00000d0f 	andeq	r0, r0, pc, lsl #26
     fcc:	0000822c 	andeq	r8, r0, ip, lsr #4
     fd0:	000000ac 	andeq	r0, r0, ip, lsr #1
     fd4:	9b259c01 	blls	967fe0 <__bss_end+0x95e250>
     fd8:	01000004 	tsteq	r0, r4
     fdc:	09b5151c 	ldmibeq	r5!, {r2, r3, r4, r8, sl, ip}
     fe0:	91020000 	mrsls	r0, (UNDEF: 2)
     fe4:	736d2b6c 	cmnvc	sp, #108, 22	; 0x1b000
     fe8:	1c010067 	stcne	0, cr0, [r1], {103}	; 0x67
     fec:	0001fa27 	andeq	pc, r1, r7, lsr #20
     ff0:	68910200 	ldmvs	r1, {r9}
     ff4:	0b1f0000 	bleq	7c0ffc <__bss_end+0x7b726c>
     ff8:	00040000 	andeq	r0, r4, r0
     ffc:	000004c5 	andeq	r0, r0, r5, asr #9
    1000:	11df0104 	bicsne	r0, pc, r4, lsl #2
    1004:	cf040000 	svcgt	0x00040000
    1008:	ec000010 	stc	0, cr0, [r0], {16}
    100c:	a000000e 	andge	r0, r0, lr
    1010:	5c00008c 	stcpl	0, cr0, [r0], {140}	; 0x8c
    1014:	d2000004 	andle	r0, r0, #4
    1018:	02000007 	andeq	r0, r0, #7
    101c:	0d0a0801 	stceq	8, cr0, [sl, #-4]
    1020:	25030000 	strcs	r0, [r3, #-0]
    1024:	02000000 	andeq	r0, r0, #0
    1028:	0aef0502 	beq	ffbc2438 <__bss_end+0xffbb86a8>
    102c:	04040000 	streq	r0, [r4], #-0
    1030:	746e6905 	strbtvc	r6, [lr], #-2309	; 0xfffff6fb
    1034:	08010200 	stmdaeq	r1, {r9}
    1038:	00000d01 	andeq	r0, r0, r1, lsl #26
    103c:	0a070202 	beq	1c184c <__bss_end+0x1b7abc>
    1040:	0500000e 	streq	r0, [r0, #-14]
    1044:	0000066e 	andeq	r0, r0, lr, ror #12
    1048:	5e070907 	vmlapl.f16	s0, s14, s14	; <UNPREDICTABLE>
    104c:	03000000 	movweq	r0, #0
    1050:	0000004d 	andeq	r0, r0, sp, asr #32
    1054:	4b070402 	blmi	1c2064 <__bss_end+0x1b82d4>
    1058:	0600000c 	streq	r0, [r0], -ip
    105c:	00000ee0 	andeq	r0, r0, r0, ror #29
    1060:	08060208 	stmdaeq	r6, {r3, r9}
    1064:	0000008b 	andeq	r0, r0, fp, lsl #1
    1068:	00307207 	eorseq	r7, r0, r7, lsl #4
    106c:	4d0e0802 	stcmi	8, cr0, [lr, #-8]
    1070:	00000000 	andeq	r0, r0, r0
    1074:	00317207 	eorseq	r7, r1, r7, lsl #4
    1078:	4d0e0902 	vstrmi.16	s0, [lr, #-4]	; <UNPREDICTABLE>
    107c:	04000000 	streq	r0, [r0], #-0
    1080:	11690800 	cmnne	r9, r0, lsl #16
    1084:	04050000 	streq	r0, [r5], #-0
    1088:	00000038 	andeq	r0, r0, r8, lsr r0
    108c:	a90c0d02 	stmdbge	ip, {r1, r8, sl, fp}
    1090:	09000000 	stmdbeq	r0, {}	; <UNPREDICTABLE>
    1094:	00004b4f 	andeq	r4, r0, pc, asr #22
    1098:	000f9a0a 	andeq	r9, pc, sl, lsl #20
    109c:	08000100 	stmdaeq	r0, {r8}
    10a0:	00000bb4 			; <UNDEFINED> instruction: 0x00000bb4
    10a4:	00380405 	eorseq	r0, r8, r5, lsl #8
    10a8:	1e020000 	cdpne	0, 0, cr0, cr2, cr0, {0}
    10ac:	0000e00c 	andeq	lr, r0, ip
    10b0:	06660a00 	strbteq	r0, [r6], -r0, lsl #20
    10b4:	0a000000 	beq	10bc <shift+0x10bc>
    10b8:	0000080a 	andeq	r0, r0, sl, lsl #16
    10bc:	0bd60a01 	bleq	ff5838c8 <__bss_end+0xff579b38>
    10c0:	0a020000 	beq	810c8 <__bss_end+0x77338>
    10c4:	00000d3d 	andeq	r0, r0, sp, lsr sp
    10c8:	07dd0a03 	ldrbeq	r0, [sp, r3, lsl #20]
    10cc:	0a040000 	beq	1010d4 <__bss_end+0xf7344>
    10d0:	00000ace 	andeq	r0, r0, lr, asr #21
    10d4:	39080005 	stmdbcc	r8, {r0, r2}
    10d8:	0500000b 	streq	r0, [r0, #-11]
    10dc:	00003804 	andeq	r3, r0, r4, lsl #16
    10e0:	0c3f0200 	lfmeq	f0, 4, [pc], #-0	; 10e8 <shift+0x10e8>
    10e4:	0000011d 	andeq	r0, r0, sp, lsl r1
    10e8:	00074c0a 	andeq	r4, r7, sl, lsl #24
    10ec:	050a0000 	streq	r0, [sl, #-0]
    10f0:	01000008 	tsteq	r0, r8
    10f4:	000e790a 	andeq	r7, lr, sl, lsl #18
    10f8:	f80a0200 			; <UNDEFINED> instruction: 0xf80a0200
    10fc:	03000009 	movweq	r0, #9
    1100:	0007f10a 	andeq	pc, r7, sl, lsl #2
    1104:	7f0a0400 	svcvc	0x000a0400
    1108:	05000008 	streq	r0, [r0, #-8]
    110c:	0006ab0a 	andeq	sl, r6, sl, lsl #22
    1110:	08000600 	stmdaeq	r0, {r9, sl}
    1114:	00000683 	andeq	r0, r0, r3, lsl #13
    1118:	00380405 	eorseq	r0, r8, r5, lsl #8
    111c:	66020000 	strvs	r0, [r2], -r0
    1120:	0001480c 	andeq	r4, r1, ip, lsl #16
    1124:	0cf60a00 	vldmiaeq	r6!, {s1-s0}
    1128:	0a000000 	beq	1130 <shift+0x1130>
    112c:	00000594 	muleq	r0, r4, r5
    1130:	0c060a01 			; <UNDEFINED> instruction: 0x0c060a01
    1134:	0a020000 	beq	8113c <__bss_end+0x773ac>
    1138:	00000ad7 	ldrdeq	r0, [r0], -r7
    113c:	ca0b0003 	bgt	2c1150 <__bss_end+0x2b73c0>
    1140:	03000009 	movweq	r0, #9
    1144:	00591405 	subseq	r1, r9, r5, lsl #8
    1148:	03050000 	movweq	r0, #20480	; 0x5000
    114c:	00009c9c 	muleq	r0, ip, ip
    1150:	000c6c0b 	andeq	r6, ip, fp, lsl #24
    1154:	14060300 	strne	r0, [r6], #-768	; 0xfffffd00
    1158:	00000059 	andeq	r0, r0, r9, asr r0
    115c:	9ca00305 	stcls	3, cr0, [r0], #20
    1160:	940b0000 	strls	r0, [fp], #-0
    1164:	04000008 	streq	r0, [r0], #-8
    1168:	00591a07 	subseq	r1, r9, r7, lsl #20
    116c:	03050000 	movweq	r0, #20480	; 0x5000
    1170:	00009ca4 	andeq	r9, r0, r4, lsr #25
    1174:	000af90b 	andeq	pc, sl, fp, lsl #18
    1178:	1a090400 	bne	242180 <__bss_end+0x2383f0>
    117c:	00000059 	andeq	r0, r0, r9, asr r0
    1180:	9ca80305 	stcls	3, cr0, [r8], #20
    1184:	860b0000 	strhi	r0, [fp], -r0
    1188:	04000008 	streq	r0, [r0], #-8
    118c:	00591a0b 	subseq	r1, r9, fp, lsl #20
    1190:	03050000 	movweq	r0, #20480	; 0x5000
    1194:	00009cac 	andeq	r9, r0, ip, lsr #25
    1198:	000abb0b 	andeq	fp, sl, fp, lsl #22
    119c:	1a0d0400 	bne	3421a4 <__bss_end+0x338414>
    11a0:	00000059 	andeq	r0, r0, r9, asr r0
    11a4:	9cb00305 	ldcls	3, cr0, [r0], #20
    11a8:	460b0000 	strmi	r0, [fp], -r0
    11ac:	04000006 	streq	r0, [r0], #-6
    11b0:	00591a0f 	subseq	r1, r9, pc, lsl #20
    11b4:	03050000 	movweq	r0, #20480	; 0x5000
    11b8:	00009cb4 			; <UNDEFINED> instruction: 0x00009cb4
    11bc:	0012d208 	andseq	sp, r2, r8, lsl #4
    11c0:	38040500 	stmdacc	r4, {r8, sl}
    11c4:	04000000 	streq	r0, [r0], #-0
    11c8:	01eb0c1b 	mvneq	r0, fp, lsl ip
    11cc:	eb0a0000 	bl	2811d4 <__bss_end+0x277444>
    11d0:	00000005 	andeq	r0, r0, r5
    11d4:	000d930a 	andeq	r9, sp, sl, lsl #6
    11d8:	740a0100 	strvc	r0, [sl], #-256	; 0xffffff00
    11dc:	0200000e 	andeq	r0, r0, #14
    11e0:	04590c00 	ldrbeq	r0, [r9], #-3072	; 0xfffff400
    11e4:	01020000 	mrseq	r0, (UNDEF: 2)
    11e8:	0008f302 	andeq	pc, r8, r2, lsl #6
    11ec:	2c040d00 	stccs	13, cr0, [r4], {-0}
    11f0:	0d000000 	stceq	0, cr0, [r0, #-0]
    11f4:	0001eb04 	andeq	lr, r1, r4, lsl #22
    11f8:	05ff0b00 	ldrbeq	r0, [pc, #2816]!	; 1d00 <shift+0x1d00>
    11fc:	04050000 	streq	r0, [r5], #-0
    1200:	00005914 	andeq	r5, r0, r4, lsl r9
    1204:	b8030500 	stmdalt	r3, {r8, sl}
    1208:	0b00009c 	bleq	1480 <shift+0x1480>
    120c:	00000be8 	andeq	r0, r0, r8, ror #23
    1210:	59140705 	ldmdbpl	r4, {r0, r2, r8, r9, sl}
    1214:	05000000 	streq	r0, [r0, #-0]
    1218:	009cbc03 	addseq	fp, ip, r3, lsl #24
    121c:	052a0b00 	streq	r0, [sl, #-2816]!	; 0xfffff500
    1220:	0a050000 	beq	141228 <__bss_end+0x137498>
    1224:	00005914 	andeq	r5, r0, r4, lsl r9
    1228:	c0030500 	andgt	r0, r3, r0, lsl #10
    122c:	0800009c 	stmdaeq	r0, {r2, r3, r4, r7}
    1230:	000006b0 			; <UNDEFINED> instruction: 0x000006b0
    1234:	00380405 	eorseq	r0, r8, r5, lsl #8
    1238:	0d050000 	stceq	0, cr0, [r5, #-0]
    123c:	0002700c 	andeq	r7, r2, ip
    1240:	654e0900 	strbvs	r0, [lr, #-2304]	; 0xfffff700
    1244:	0a000077 	beq	1428 <shift+0x1428>
    1248:	000004ff 	strdeq	r0, [r0], -pc	; <UNPREDICTABLE>
    124c:	05220a01 	streq	r0, [r2, #-2561]!	; 0xfffff5ff
    1250:	0a020000 	beq	81258 <__bss_end+0x774c8>
    1254:	000006c9 	andeq	r0, r0, r9, asr #13
    1258:	0d2f0a03 	vstmdbeq	pc!, {s0-s2}
    125c:	0a040000 	beq	101264 <__bss_end+0xf74d4>
    1260:	000004ec 	andeq	r0, r0, ip, ror #9
    1264:	18060005 	stmdane	r6, {r0, r2}
    1268:	10000006 	andne	r0, r0, r6
    126c:	af081b05 	svcge	0x00081b05
    1270:	07000002 	streq	r0, [r0, -r2]
    1274:	0500726c 	streq	r7, [r0, #-620]	; 0xfffffd94
    1278:	02af131d 	adceq	r1, pc, #1946157056	; 0x74000000
    127c:	07000000 	streq	r0, [r0, -r0]
    1280:	05007073 	streq	r7, [r0, #-115]	; 0xffffff8d
    1284:	02af131e 	adceq	r1, pc, #2013265920	; 0x78000000
    1288:	07040000 	streq	r0, [r4, -r0]
    128c:	05006370 	streq	r6, [r0, #-880]	; 0xfffffc90
    1290:	02af131f 	adceq	r1, pc, #2080374784	; 0x7c000000
    1294:	0e080000 	cdpeq	0, 0, cr0, cr8, cr0, {0}
    1298:	00000b29 	andeq	r0, r0, r9, lsr #22
    129c:	af132005 	svcge	0x00132005
    12a0:	0c000002 	stceq	0, cr0, [r0], {2}
    12a4:	07040200 	streq	r0, [r4, -r0, lsl #4]
    12a8:	00000c46 	andeq	r0, r0, r6, asr #24
    12ac:	0007d006 	andeq	sp, r7, r6
    12b0:	28057000 	stmdacs	r5, {ip, sp, lr}
    12b4:	00034608 	andeq	r4, r3, r8, lsl #12
    12b8:	07310e00 	ldreq	r0, [r1, -r0, lsl #28]!
    12bc:	2a050000 	bcs	1412c4 <__bss_end+0x137534>
    12c0:	00027012 	andeq	r7, r2, r2, lsl r0
    12c4:	70070000 	andvc	r0, r7, r0
    12c8:	05006469 	streq	r6, [r0, #-1129]	; 0xfffffb97
    12cc:	005e122b 	subseq	r1, lr, fp, lsr #4
    12d0:	0e100000 	cdpeq	0, 1, cr0, cr0, cr0, {0}
    12d4:	00000a8d 	andeq	r0, r0, sp, lsl #21
    12d8:	39112c05 	ldmdbcc	r1, {r0, r2, sl, fp, sp}
    12dc:	14000002 	strne	r0, [r0], #-2
    12e0:	000cdc0e 	andeq	sp, ip, lr, lsl #24
    12e4:	122d0500 	eorne	r0, sp, #0, 10
    12e8:	0000005e 	andeq	r0, r0, lr, asr r0
    12ec:	03e90e18 	mvneq	r0, #24, 28	; 0x180
    12f0:	2e050000 	cdpcs	0, 0, cr0, cr5, cr0, {0}
    12f4:	00005e12 	andeq	r5, r0, r2, lsl lr
    12f8:	c90e1c00 	stmdbgt	lr, {sl, fp, ip}
    12fc:	0500000b 	streq	r0, [r0, #-11]
    1300:	03460c2f 	movteq	r0, #27695	; 0x6c2f
    1304:	0e200000 	cdpeq	0, 2, cr0, cr0, cr0, {0}
    1308:	00000486 	andeq	r0, r0, r6, lsl #9
    130c:	38093005 	stmdacc	r9, {r0, r2, ip, sp}
    1310:	60000000 	andvs	r0, r0, r0
    1314:	0006e40e 	andeq	lr, r6, lr, lsl #8
    1318:	0e310500 	cfabs32eq	mvfx0, mvfx1
    131c:	0000004d 	andeq	r0, r0, sp, asr #32
    1320:	0a620e64 	beq	1884cb8 <__bss_end+0x187af28>
    1324:	33050000 	movwcc	r0, #20480	; 0x5000
    1328:	00004d0e 	andeq	r4, r0, lr, lsl #26
    132c:	590e6800 	stmdbpl	lr, {fp, sp, lr}
    1330:	0500000a 	streq	r0, [r0, #-10]
    1334:	004d0e34 	subeq	r0, sp, r4, lsr lr
    1338:	006c0000 	rsbeq	r0, ip, r0
    133c:	0001fd0f 	andeq	pc, r1, pc, lsl #26
    1340:	00035600 	andeq	r5, r3, r0, lsl #12
    1344:	005e1000 	subseq	r1, lr, r0
    1348:	000f0000 	andeq	r0, pc, r0
    134c:	0005130b 	andeq	r1, r5, fp, lsl #6
    1350:	140a0600 	strne	r0, [sl], #-1536	; 0xfffffa00
    1354:	00000059 	andeq	r0, r0, r9, asr r0
    1358:	9cc40305 	stclls	3, cr0, [r4], {5}
    135c:	cf080000 	svcgt	0x00080000
    1360:	05000008 	streq	r0, [r0, #-8]
    1364:	00003804 	andeq	r3, r0, r4, lsl #16
    1368:	0c0d0600 	stceq	6, cr0, [sp], {-0}
    136c:	00000387 	andeq	r0, r0, r7, lsl #7
    1370:	000e7f0a 	andeq	r7, lr, sl, lsl #30
    1374:	a70a0000 	strge	r0, [sl, -r0]
    1378:	0100000d 	tsteq	r0, sp
    137c:	03680300 	cmneq	r8, #0, 6
    1380:	61080000 	mrsvs	r0, (UNDEF: 8)
    1384:	05000010 	streq	r0, [r0, #-16]
    1388:	00003804 	andeq	r3, r0, r4, lsl #16
    138c:	0c140600 	ldceq	6, cr0, [r4], {-0}
    1390:	000003ab 	andeq	r0, r0, fp, lsr #7
    1394:	000f3d0a 	andeq	r3, pc, sl, lsl #26
    1398:	3b0a0000 	blcc	2813a0 <__bss_end+0x277610>
    139c:	01000011 	tsteq	r0, r1, lsl r0
    13a0:	038c0300 	orreq	r0, ip, #0, 6
    13a4:	13060000 	movwne	r0, #24576	; 0x6000
    13a8:	0c000007 	stceq	0, cr0, [r0], {7}
    13ac:	e5081b06 	str	r1, [r8, #-2822]	; 0xfffff4fa
    13b0:	0e000003 	cdpeq	0, 0, cr0, cr0, cr3, {0}
    13b4:	000005b8 			; <UNDEFINED> instruction: 0x000005b8
    13b8:	e5191d06 	ldr	r1, [r9, #-3334]	; 0xfffff2fa
    13bc:	00000003 	andeq	r0, r0, r3
    13c0:	0004fa0e 	andeq	pc, r4, lr, lsl #20
    13c4:	191e0600 	ldmdbne	lr, {r9, sl}
    13c8:	000003e5 	andeq	r0, r0, r5, ror #7
    13cc:	0a340e04 	beq	d04be4 <__bss_end+0xcfae54>
    13d0:	1f060000 	svcne	0x00060000
    13d4:	0003eb13 	andeq	lr, r3, r3, lsl fp
    13d8:	0d000800 	stceq	8, cr0, [r0, #-0]
    13dc:	0003b004 	andeq	fp, r3, r4
    13e0:	b6040d00 	strlt	r0, [r4], -r0, lsl #26
    13e4:	11000002 	tstne	r0, r2
    13e8:	00000b0b 	andeq	r0, r0, fp, lsl #22
    13ec:	07220614 			; <UNDEFINED> instruction: 0x07220614
    13f0:	00000673 	andeq	r0, r0, r3, ror r6
    13f4:	0009d80e 	andeq	sp, r9, lr, lsl #16
    13f8:	12260600 	eorne	r0, r6, #0, 12
    13fc:	0000004d 	andeq	r0, r0, sp, asr #32
    1400:	097a0e00 	ldmdbeq	sl!, {r9, sl, fp}^
    1404:	29060000 	stmdbcs	r6, {}	; <UNPREDICTABLE>
    1408:	0003e51d 	andeq	lr, r3, sp, lsl r5
    140c:	d10e0400 	tstle	lr, r0, lsl #8
    1410:	06000006 	streq	r0, [r0], -r6
    1414:	03e51d2c 	mvneq	r1, #44, 26	; 0xb00
    1418:	12080000 	andne	r0, r8, #0
    141c:	000009ee 	andeq	r0, r0, lr, ror #19
    1420:	f00e2f06 			; <UNDEFINED> instruction: 0xf00e2f06
    1424:	39000006 	stmdbcc	r0, {r1, r2}
    1428:	44000004 	strmi	r0, [r0], #-4
    142c:	13000004 	movwne	r0, #4
    1430:	00000678 	andeq	r0, r0, r8, ror r6
    1434:	0003e514 	andeq	lr, r3, r4, lsl r5
    1438:	24150000 	ldrcs	r0, [r5], #-0
    143c:	06000008 	streq	r0, [r0], -r8
    1440:	07a70e31 			; <UNDEFINED> instruction: 0x07a70e31
    1444:	01f00000 	mvnseq	r0, r0
    1448:	045c0000 	ldrbeq	r0, [ip], #-0
    144c:	04670000 	strbteq	r0, [r7], #-0
    1450:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
    1454:	14000006 	strne	r0, [r0], #-6
    1458:	000003eb 	andeq	r0, r0, fp, ror #7
    145c:	0d431600 	stcleq	6, cr1, [r3, #-0]
    1460:	35060000 	strcc	r0, [r6, #-0]
    1464:	0008aa1d 	andeq	sl, r8, sp, lsl sl
    1468:	0003e500 	andeq	lr, r3, r0, lsl #10
    146c:	04800200 	streq	r0, [r0], #512	; 0x200
    1470:	04860000 	streq	r0, [r6], #0
    1474:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
    1478:	00000006 	andeq	r0, r0, r6
    147c:	0006bc16 	andeq	fp, r6, r6, lsl ip
    1480:	1d370600 	ldcne	6, cr0, [r7, #-0]
    1484:	000009fe 	strdeq	r0, [r0], -lr
    1488:	000003e5 	andeq	r0, r0, r5, ror #7
    148c:	00049f02 	andeq	r9, r4, r2, lsl #30
    1490:	0004a500 	andeq	sl, r4, r0, lsl #10
    1494:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
    1498:	17000000 	strne	r0, [r0, -r0]
    149c:	0000098d 	andeq	r0, r0, sp, lsl #19
    14a0:	91313906 	teqls	r1, r6, lsl #18
    14a4:	0c000006 	stceq	0, cr0, [r0], {6}
    14a8:	0b0b1602 	bleq	2c6cb8 <__bss_end+0x2bcf28>
    14ac:	3c060000 	stccc	0, cr0, [r6], {-0}
    14b0:	00083309 	andeq	r3, r8, r9, lsl #6
    14b4:	00067800 	andeq	r7, r6, r0, lsl #16
    14b8:	04cc0100 	strbeq	r0, [ip], #256	; 0x100
    14bc:	04d20000 	ldrbeq	r0, [r2], #0
    14c0:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
    14c4:	00000006 	andeq	r0, r0, r6
    14c8:	00073d16 	andeq	r3, r7, r6, lsl sp
    14cc:	123f0600 	eorsne	r0, pc, #0, 12
    14d0:	0000055b 	andeq	r0, r0, fp, asr r5
    14d4:	0000004d 	andeq	r0, r0, sp, asr #32
    14d8:	0004eb01 	andeq	lr, r4, r1, lsl #22
    14dc:	00050000 	andeq	r0, r5, r0
    14e0:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
    14e4:	9a140000 	bls	5014ec <__bss_end+0x4f775c>
    14e8:	14000006 	strne	r0, [r0], #-6
    14ec:	0000005e 	andeq	r0, r0, lr, asr r0
    14f0:	0001f014 	andeq	pc, r1, r4, lsl r0	; <UNPREDICTABLE>
    14f4:	9e180000 	cdpls	0, 1, cr0, cr8, cr0, {0}
    14f8:	0600000d 	streq	r0, [r0], -sp
    14fc:	06250e42 	strteq	r0, [r5], -r2, asr #28
    1500:	15010000 	strne	r0, [r1, #-0]
    1504:	1b000005 	blne	1520 <shift+0x1520>
    1508:	13000005 	movwne	r0, #5
    150c:	00000678 	andeq	r0, r0, r8, ror r6
    1510:	053d1600 	ldreq	r1, [sp, #-1536]!	; 0xfffffa00
    1514:	45060000 	strmi	r0, [r6, #-0]
    1518:	0005bd17 	andeq	fp, r5, r7, lsl sp
    151c:	0003eb00 	andeq	lr, r3, r0, lsl #22
    1520:	05340100 	ldreq	r0, [r4, #-256]!	; 0xffffff00
    1524:	053a0000 	ldreq	r0, [sl, #-0]!
    1528:	a0130000 	andsge	r0, r3, r0
    152c:	00000006 	andeq	r0, r0, r6
    1530:	000bf316 	andeq	pc, fp, r6, lsl r3	; <UNPREDICTABLE>
    1534:	17480600 	strbne	r0, [r8, -r0, lsl #12]
    1538:	000003ff 	strdeq	r0, [r0], -pc	; <UNPREDICTABLE>
    153c:	000003eb 	andeq	r0, r0, fp, ror #7
    1540:	00055301 	andeq	r5, r5, r1, lsl #6
    1544:	00055e00 	andeq	r5, r5, r0, lsl #28
    1548:	06a01300 	strteq	r1, [r0], r0, lsl #6
    154c:	4d140000 	ldcmi	0, cr0, [r4, #-0]
    1550:	00000000 	andeq	r0, r0, r0
    1554:	00065018 	andeq	r5, r6, r8, lsl r0
    1558:	0e4b0600 	cdpeq	6, 4, cr0, cr11, cr0, {0}
    155c:	0000099b 	muleq	r0, fp, r9
    1560:	00057301 	andeq	r7, r5, r1, lsl #6
    1564:	00057900 	andeq	r7, r5, r0, lsl #18
    1568:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
    156c:	16000000 	strne	r0, [r0], -r0
    1570:	00000824 	andeq	r0, r0, r4, lsr #16
    1574:	930e4d06 	movwls	r4, #60678	; 0xed06
    1578:	f000000a 			; <UNDEFINED> instruction: 0xf000000a
    157c:	01000001 	tsteq	r0, r1
    1580:	00000592 	muleq	r0, r2, r5
    1584:	0000059d 	muleq	r0, sp, r5
    1588:	00067813 	andeq	r7, r6, r3, lsl r8
    158c:	004d1400 	subeq	r1, sp, r0, lsl #8
    1590:	16000000 	strne	r0, [r0], -r0
    1594:	000004c6 	andeq	r0, r0, r6, asr #9
    1598:	2c125006 	ldccs	0, cr5, [r2], {6}
    159c:	4d000004 	stcmi	0, cr0, [r0, #-16]
    15a0:	01000000 	mrseq	r0, (UNDEF: 0)
    15a4:	000005b6 			; <UNDEFINED> instruction: 0x000005b6
    15a8:	000005c1 	andeq	r0, r0, r1, asr #11
    15ac:	00067813 	andeq	r7, r6, r3, lsl r8
    15b0:	01fd1400 	mvnseq	r1, r0, lsl #8
    15b4:	16000000 	strne	r0, [r0], -r0
    15b8:	0000045f 	andeq	r0, r0, pc, asr r4
    15bc:	b20e5306 	andlt	r5, lr, #402653184	; 0x18000000
    15c0:	f000000d 			; <UNDEFINED> instruction: 0xf000000d
    15c4:	01000001 	tsteq	r0, r1
    15c8:	000005da 	ldrdeq	r0, [r0], -sl
    15cc:	000005e5 	andeq	r0, r0, r5, ror #11
    15d0:	00067813 	andeq	r7, r6, r3, lsl r8
    15d4:	004d1400 	subeq	r1, sp, r0, lsl #8
    15d8:	18000000 	stmdane	r0, {}	; <UNPREDICTABLE>
    15dc:	000004a0 	andeq	r0, r0, r0, lsr #9
    15e0:	780e5606 	stmdavc	lr, {r1, r2, r9, sl, ip, lr}
    15e4:	0100000c 	tsteq	r0, ip
    15e8:	000005fa 	strdeq	r0, [r0], -sl
    15ec:	00000619 	andeq	r0, r0, r9, lsl r6
    15f0:	00067813 	andeq	r7, r6, r3, lsl r8
    15f4:	00a91400 	adceq	r1, r9, r0, lsl #8
    15f8:	4d140000 	ldcmi	0, cr0, [r4, #-0]
    15fc:	14000000 	strne	r0, [r0], #-0
    1600:	0000004d 	andeq	r0, r0, sp, asr #32
    1604:	00004d14 	andeq	r4, r0, r4, lsl sp
    1608:	06a61400 	strteq	r1, [r6], r0, lsl #8
    160c:	18000000 	stmdane	r0, {}	; <UNPREDICTABLE>
    1610:	00000df4 	strdeq	r0, [r0], -r4
    1614:	940e5806 	strls	r5, [lr], #-2054	; 0xfffff7fa
    1618:	0100000e 	tsteq	r0, lr
    161c:	0000062e 	andeq	r0, r0, lr, lsr #12
    1620:	0000064d 	andeq	r0, r0, sp, asr #12
    1624:	00067813 	andeq	r7, r6, r3, lsl r8
    1628:	00e01400 	rsceq	r1, r0, r0, lsl #8
    162c:	4d140000 	ldcmi	0, cr0, [r4, #-0]
    1630:	14000000 	strne	r0, [r0], #-0
    1634:	0000004d 	andeq	r0, r0, sp, asr #32
    1638:	00004d14 	andeq	r4, r0, r4, lsl sp
    163c:	06a61400 	strteq	r1, [r6], r0, lsl #8
    1640:	19000000 	stmdbne	r0, {}	; <UNPREDICTABLE>
    1644:	000004b3 			; <UNDEFINED> instruction: 0x000004b3
    1648:	140e5b06 	strne	r5, [lr], #-2822	; 0xfffff4fa
    164c:	f0000009 			; <UNDEFINED> instruction: 0xf0000009
    1650:	01000001 	tsteq	r0, r1
    1654:	00000662 	andeq	r0, r0, r2, ror #12
    1658:	00067813 	andeq	r7, r6, r3, lsl r8
    165c:	03681400 	cmneq	r8, #0, 8
    1660:	ac140000 	ldcge	0, cr0, [r4], {-0}
    1664:	00000006 	andeq	r0, r0, r6
    1668:	03f10300 	mvnseq	r0, #0, 6
    166c:	040d0000 	streq	r0, [sp], #-0
    1670:	000003f1 	strdeq	r0, [r0], -r1
    1674:	0003e51a 	andeq	lr, r3, sl, lsl r5
    1678:	00068b00 	andeq	r8, r6, r0, lsl #22
    167c:	00069100 	andeq	r9, r6, r0, lsl #2
    1680:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
    1684:	1b000000 	blne	168c <shift+0x168c>
    1688:	000003f1 	strdeq	r0, [r0], -r1
    168c:	0000067e 	andeq	r0, r0, lr, ror r6
    1690:	003f040d 	eorseq	r0, pc, sp, lsl #8
    1694:	040d0000 	streq	r0, [sp], #-0
    1698:	00000673 	andeq	r0, r0, r3, ror r6
    169c:	0065041c 	rsbeq	r0, r5, ip, lsl r4
    16a0:	041d0000 	ldreq	r0, [sp], #-0
    16a4:	00002c0f 	andeq	r2, r0, pc, lsl #24
    16a8:	0006be00 	andeq	fp, r6, r0, lsl #28
    16ac:	005e1000 	subseq	r1, lr, r0
    16b0:	00090000 	andeq	r0, r9, r0
    16b4:	0006ae03 	andeq	sl, r6, r3, lsl #28
    16b8:	0fe61e00 	svceq	0x00e61e00
    16bc:	a3010000 	movwge	r0, #4096	; 0x1000
    16c0:	0006be0c 	andeq	fp, r6, ip, lsl #28
    16c4:	c8030500 	stmdagt	r3, {r8, sl}
    16c8:	1f00009c 	svcne	0x0000009c
    16cc:	00000f56 	andeq	r0, r0, r6, asr pc
    16d0:	550aa501 	strpl	sl, [sl, #-1281]	; 0xfffffaff
    16d4:	4d000010 	stcmi	0, cr0, [r0, #-64]	; 0xffffffc0
    16d8:	4c000000 	stcmi	0, cr0, [r0], {-0}
    16dc:	b0000090 	mullt	r0, r0, r0
    16e0:	01000000 	mrseq	r0, (UNDEF: 0)
    16e4:	0007339c 	muleq	r7, ip, r3
    16e8:	12b52000 	adcsne	r2, r5, #0
    16ec:	a5010000 	strge	r0, [r1, #-0]
    16f0:	0001f71b 	andeq	pc, r1, fp, lsl r7	; <UNPREDICTABLE>
    16f4:	ac910300 	ldcge	3, cr0, [r1], {0}
    16f8:	10b4207f 	adcsne	r2, r4, pc, ror r0
    16fc:	a5010000 	strge	r0, [r1, #-0]
    1700:	00004d2a 	andeq	r4, r0, sl, lsr #26
    1704:	a8910300 	ldmge	r1, {r8, r9}
    1708:	103e1e7f 	eorsne	r1, lr, pc, ror lr
    170c:	a7010000 	strge	r0, [r1, -r0]
    1710:	0007330a 	andeq	r3, r7, sl, lsl #6
    1714:	b4910300 	ldrlt	r0, [r1], #768	; 0x300
    1718:	0f511e7f 	svceq	0x00511e7f
    171c:	ab010000 	blge	41724 <__bss_end+0x37994>
    1720:	00003809 	andeq	r3, r0, r9, lsl #16
    1724:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    1728:	00250f00 	eoreq	r0, r5, r0, lsl #30
    172c:	07430000 	strbeq	r0, [r3, -r0]
    1730:	5e100000 	cdppl	0, 1, cr0, cr0, cr0, {0}
    1734:	3f000000 	svccc	0x00000000
    1738:	10992100 	addsne	r2, r9, r0, lsl #2
    173c:	97010000 	strls	r0, [r1, -r0]
    1740:	0011490a 	andseq	r4, r1, sl, lsl #18
    1744:	00004d00 	andeq	r4, r0, r0, lsl #26
    1748:	00901000 	addseq	r1, r0, r0
    174c:	00003c00 	andeq	r3, r0, r0, lsl #24
    1750:	809c0100 	addshi	r0, ip, r0, lsl #2
    1754:	22000007 	andcs	r0, r0, #7
    1758:	00716572 	rsbseq	r6, r1, r2, ror r5
    175c:	ab209901 	blge	827b68 <__bss_end+0x81ddd8>
    1760:	02000003 	andeq	r0, r0, #3
    1764:	4a1e7491 	bmi	79e9b0 <__bss_end+0x794c20>
    1768:	01000010 	tsteq	r0, r0, lsl r0
    176c:	004d0e9a 	umaaleq	r0, sp, sl, lr
    1770:	91020000 	mrsls	r0, (UNDEF: 2)
    1774:	bd230070 	stclt	0, cr0, [r3, #-448]!	; 0xfffffe40
    1778:	01000010 	tsteq	r0, r0, lsl r0
    177c:	0f72068e 	svceq	0x0072068e
    1780:	8fd40000 	svchi	0x00d40000
    1784:	003c0000 	eorseq	r0, ip, r0
    1788:	9c010000 	stcls	0, cr0, [r1], {-0}
    178c:	000007b9 			; <UNDEFINED> instruction: 0x000007b9
    1790:	000fb420 	andeq	fp, pc, r0, lsr #8
    1794:	218e0100 	orrcs	r0, lr, r0, lsl #2
    1798:	0000004d 	andeq	r0, r0, sp, asr #32
    179c:	226c9102 	rsbcs	r9, ip, #-2147483648	; 0x80000000
    17a0:	00716572 	rsbseq	r6, r1, r2, ror r5
    17a4:	ab209001 	blge	8257b0 <__bss_end+0x81ba20>
    17a8:	02000003 	andeq	r0, r0, #3
    17ac:	21007491 			; <UNDEFINED> instruction: 0x21007491
    17b0:	00001076 	andeq	r1, r0, r6, ror r0
    17b4:	f70a8201 			; <UNDEFINED> instruction: 0xf70a8201
    17b8:	4d00000f 	stcmi	0, cr0, [r0, #-60]	; 0xffffffc4
    17bc:	98000000 	stmdals	r0, {}	; <UNPREDICTABLE>
    17c0:	3c00008f 	stccc	0, cr0, [r0], {143}	; 0x8f
    17c4:	01000000 	mrseq	r0, (UNDEF: 0)
    17c8:	0007f69c 	muleq	r7, ip, r6
    17cc:	65722200 	ldrbvs	r2, [r2, #-512]!	; 0xfffffe00
    17d0:	84010071 	strhi	r0, [r1], #-113	; 0xffffff8f
    17d4:	00038720 	andeq	r8, r3, r0, lsr #14
    17d8:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    17dc:	000f4a1e 	andeq	r4, pc, lr, lsl sl	; <UNPREDICTABLE>
    17e0:	0e850100 	rmfeqs	f0, f5, f0
    17e4:	0000004d 	andeq	r0, r0, sp, asr #32
    17e8:	00709102 	rsbseq	r9, r0, r2, lsl #2
    17ec:	00129821 	andseq	r9, r2, r1, lsr #16
    17f0:	0a760100 	beq	1d81bf8 <__bss_end+0x1d77e68>
    17f4:	00000fc8 	andeq	r0, r0, r8, asr #31
    17f8:	0000004d 	andeq	r0, r0, sp, asr #32
    17fc:	00008f5c 	andeq	r8, r0, ip, asr pc
    1800:	0000003c 	andeq	r0, r0, ip, lsr r0
    1804:	08339c01 	ldmdaeq	r3!, {r0, sl, fp, ip, pc}
    1808:	72220000 	eorvc	r0, r2, #0
    180c:	01007165 	tsteq	r0, r5, ror #2
    1810:	03872078 	orreq	r2, r7, #120	; 0x78
    1814:	91020000 	mrsls	r0, (UNDEF: 2)
    1818:	0f4a1e74 	svceq	0x004a1e74
    181c:	79010000 	stmdbvc	r1, {}	; <UNPREDICTABLE>
    1820:	00004d0e 	andeq	r4, r0, lr, lsl #26
    1824:	70910200 	addsvc	r0, r1, r0, lsl #4
    1828:	100b2100 	andne	r2, fp, r0, lsl #2
    182c:	6a010000 	bvs	41834 <__bss_end+0x37aa4>
    1830:	00112b06 	andseq	r2, r1, r6, lsl #22
    1834:	0001f000 	andeq	pc, r1, r0
    1838:	008f0800 	addeq	r0, pc, r0, lsl #16
    183c:	00005400 	andeq	r5, r0, r0, lsl #8
    1840:	7f9c0100 	svcvc	0x009c0100
    1844:	20000008 	andcs	r0, r0, r8
    1848:	0000104a 	andeq	r1, r0, sl, asr #32
    184c:	4d156a01 	vldrmi	s12, [r5, #-4]
    1850:	02000000 	andeq	r0, r0, #0
    1854:	59206c91 	stmdbpl	r0!, {r0, r4, r7, sl, fp, sp, lr}
    1858:	0100000a 	tsteq	r0, sl
    185c:	004d256a 	subeq	r2, sp, sl, ror #10
    1860:	91020000 	mrsls	r0, (UNDEF: 2)
    1864:	12901e68 	addsne	r1, r0, #104, 28	; 0x680
    1868:	6c010000 	stcvs	0, cr0, [r1], {-0}
    186c:	00004d0e 	andeq	r4, r0, lr, lsl #26
    1870:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    1874:	0f892100 	svceq	0x00892100
    1878:	5d010000 	stcpl	0, cr0, [r1, #-0]
    187c:	00118012 	andseq	r8, r1, r2, lsl r0
    1880:	00008b00 	andeq	r8, r0, r0, lsl #22
    1884:	008eb800 	addeq	fp, lr, r0, lsl #16
    1888:	00005000 	andeq	r5, r0, r0
    188c:	da9c0100 	ble	fe701c94 <__bss_end+0xfe6f7f04>
    1890:	20000008 	andcs	r0, r0, r8
    1894:	00001136 	andeq	r1, r0, r6, lsr r1
    1898:	4d205d01 	stcmi	13, cr5, [r0, #-4]!
    189c:	02000000 	andeq	r0, r0, #0
    18a0:	7f206c91 	svcvc	0x00206c91
    18a4:	01000010 	tsteq	r0, r0, lsl r0
    18a8:	004d2f5d 	subeq	r2, sp, sp, asr pc
    18ac:	91020000 	mrsls	r0, (UNDEF: 2)
    18b0:	0a592068 	beq	1649a58 <__bss_end+0x163fcc8>
    18b4:	5d010000 	stcpl	0, cr0, [r1, #-0]
    18b8:	00004d3f 	andeq	r4, r0, pc, lsr sp
    18bc:	64910200 	ldrvs	r0, [r1], #512	; 0x200
    18c0:	0012901e 	andseq	r9, r2, lr, lsl r0
    18c4:	165f0100 	ldrbne	r0, [pc], -r0, lsl #2
    18c8:	0000008b 	andeq	r0, r0, fp, lsl #1
    18cc:	00749102 	rsbseq	r9, r4, r2, lsl #2
    18d0:	0011b621 	andseq	fp, r1, r1, lsr #12
    18d4:	0a510100 	beq	1441cdc <__bss_end+0x1437f4c>
    18d8:	00000f8e 	andeq	r0, r0, lr, lsl #31
    18dc:	0000004d 	andeq	r0, r0, sp, asr #32
    18e0:	00008e74 	andeq	r8, r0, r4, ror lr
    18e4:	00000044 	andeq	r0, r0, r4, asr #32
    18e8:	09269c01 	stmdbeq	r6!, {r0, sl, fp, ip, pc}
    18ec:	36200000 	strtcc	r0, [r0], -r0
    18f0:	01000011 	tsteq	r0, r1, lsl r0
    18f4:	004d1a51 	subeq	r1, sp, r1, asr sl
    18f8:	91020000 	mrsls	r0, (UNDEF: 2)
    18fc:	107f206c 	rsbsne	r2, pc, ip, rrx
    1900:	51010000 	mrspl	r0, (UNDEF: 1)
    1904:	00004d29 	andeq	r4, r0, r9, lsr #26
    1908:	68910200 	ldmvs	r1, {r9}
    190c:	0011af1e 	andseq	sl, r1, lr, lsl pc
    1910:	0e530100 	rdfeqs	f0, f3, f0
    1914:	0000004d 	andeq	r0, r0, sp, asr #32
    1918:	00749102 	rsbseq	r9, r4, r2, lsl #2
    191c:	0011a921 	andseq	sl, r1, r1, lsr #18
    1920:	0a440100 	beq	1101d28 <__bss_end+0x10f7f98>
    1924:	0000118b 	andeq	r1, r0, fp, lsl #3
    1928:	0000004d 	andeq	r0, r0, sp, asr #32
    192c:	00008e24 	andeq	r8, r0, r4, lsr #28
    1930:	00000050 	andeq	r0, r0, r0, asr r0
    1934:	09819c01 	stmibeq	r1, {r0, sl, fp, ip, pc}
    1938:	36200000 	strtcc	r0, [r0], -r0
    193c:	01000011 	tsteq	r0, r1, lsl r0
    1940:	004d1944 	subeq	r1, sp, r4, asr #18
    1944:	91020000 	mrsls	r0, (UNDEF: 2)
    1948:	101f206c 	andsne	r2, pc, ip, rrx
    194c:	44010000 	strmi	r0, [r1], #-0
    1950:	00011d30 	andeq	r1, r1, r0, lsr sp
    1954:	68910200 	ldmvs	r1, {r9}
    1958:	00108520 	andseq	r8, r0, r0, lsr #10
    195c:	41440100 	mrsmi	r0, (UNDEF: 84)
    1960:	000006ac 	andeq	r0, r0, ip, lsr #13
    1964:	1e649102 	lgnnes	f1, f2
    1968:	00001290 	muleq	r0, r0, r2
    196c:	4d0e4601 	stcmi	6, cr4, [lr, #-4]
    1970:	02000000 	andeq	r0, r0, #0
    1974:	23007491 	movwcs	r7, #1169	; 0x491
    1978:	00000f37 	andeq	r0, r0, r7, lsr pc
    197c:	29063e01 	stmdbcs	r6, {r0, r9, sl, fp, ip, sp}
    1980:	f8000010 			; <UNDEFINED> instruction: 0xf8000010
    1984:	2c00008d 	stccs	0, cr0, [r0], {141}	; 0x8d
    1988:	01000000 	mrseq	r0, (UNDEF: 0)
    198c:	0009ab9c 	muleq	r9, ip, fp
    1990:	11362000 	teqne	r6, r0
    1994:	3e010000 	cdpcc	0, 0, cr0, cr1, cr0, {0}
    1998:	00004d15 	andeq	r4, r0, r5, lsl sp
    199c:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    19a0:	10442100 	subne	r2, r4, r0, lsl #2
    19a4:	31010000 	mrscc	r0, (UNDEF: 1)
    19a8:	00108b0a 	andseq	r8, r0, sl, lsl #22
    19ac:	00004d00 	andeq	r4, r0, r0, lsl #26
    19b0:	008da800 	addeq	sl, sp, r0, lsl #16
    19b4:	00005000 	andeq	r5, r0, r0
    19b8:	069c0100 	ldreq	r0, [ip], r0, lsl #2
    19bc:	2000000a 	andcs	r0, r0, sl
    19c0:	00001136 	andeq	r1, r0, r6, lsr r1
    19c4:	4d193101 	ldfmis	f3, [r9, #-4]
    19c8:	02000000 	andeq	r0, r0, #0
    19cc:	cc206c91 	stcgt	12, cr6, [r0], #-580	; 0xfffffdbc
    19d0:	01000011 	tsteq	r0, r1, lsl r0
    19d4:	01f72b31 	mvnseq	r2, r1, lsr fp
    19d8:	91020000 	mrsls	r0, (UNDEF: 2)
    19dc:	10b82068 	adcsne	r2, r8, r8, rrx
    19e0:	31010000 	mrscc	r0, (UNDEF: 1)
    19e4:	00004d3c 	andeq	r4, r0, ip, lsr sp
    19e8:	64910200 	ldrvs	r0, [r1], #512	; 0x200
    19ec:	00117a1e 	andseq	r7, r1, lr, lsl sl
    19f0:	0e330100 	rsfeqs	f0, f3, f0
    19f4:	0000004d 	andeq	r0, r0, sp, asr #32
    19f8:	00749102 	rsbseq	r9, r4, r2, lsl #2
    19fc:	0012ba21 	andseq	fp, r2, r1, lsr #20
    1a00:	0a240100 	beq	901e08 <__bss_end+0x8f8078>
    1a04:	000011d3 	ldrdeq	r1, [r0], -r3
    1a08:	0000004d 	andeq	r0, r0, sp, asr #32
    1a0c:	00008d58 	andeq	r8, r0, r8, asr sp
    1a10:	00000050 	andeq	r0, r0, r0, asr r0
    1a14:	0a619c01 	beq	1868a20 <__bss_end+0x185ec90>
    1a18:	36200000 	strtcc	r0, [r0], -r0
    1a1c:	01000011 	tsteq	r0, r1, lsl r0
    1a20:	004d1824 	subeq	r1, sp, r4, lsr #16
    1a24:	91020000 	mrsls	r0, (UNDEF: 2)
    1a28:	11cc206c 	bicne	r2, ip, ip, rrx
    1a2c:	24010000 	strcs	r0, [r1], #-0
    1a30:	000a672a 	andeq	r6, sl, sl, lsr #14
    1a34:	68910200 	ldmvs	r1, {r9}
    1a38:	0010b820 	andseq	fp, r0, r0, lsr #16
    1a3c:	3b240100 	blcc	901e44 <__bss_end+0x8f80b4>
    1a40:	0000004d 	andeq	r0, r0, sp, asr #32
    1a44:	1e649102 	lgnnes	f1, f2
    1a48:	00000f5b 	andeq	r0, r0, fp, asr pc
    1a4c:	4d0e2601 	stcmi	6, cr2, [lr, #-4]
    1a50:	02000000 	andeq	r0, r0, #0
    1a54:	0d007491 	cfstrseq	mvf7, [r0, #-580]	; 0xfffffdbc
    1a58:	00002504 	andeq	r2, r0, r4, lsl #10
    1a5c:	0a610300 	beq	1842664 <__bss_end+0x18388d4>
    1a60:	50210000 	eorpl	r0, r1, r0
    1a64:	01000010 	tsteq	r0, r0, lsl r0
    1a68:	12c60a19 	sbcne	r0, r6, #102400	; 0x19000
    1a6c:	004d0000 	subeq	r0, sp, r0
    1a70:	8d140000 	ldchi	0, cr0, [r4, #-0]
    1a74:	00440000 	subeq	r0, r4, r0
    1a78:	9c010000 	stcls	0, cr0, [r1], {-0}
    1a7c:	00000ab8 			; <UNDEFINED> instruction: 0x00000ab8
    1a80:	0012b120 	andseq	fp, r2, r0, lsr #2
    1a84:	1b190100 	blne	641e8c <__bss_end+0x6380fc>
    1a88:	000001f7 	strdeq	r0, [r0], -r7
    1a8c:	206c9102 	rsbcs	r9, ip, r2, lsl #2
    1a90:	000011c7 	andeq	r1, r0, r7, asr #3
    1a94:	c6351901 	ldrtgt	r1, [r5], -r1, lsl #18
    1a98:	02000001 	andeq	r0, r0, #1
    1a9c:	361e6891 			; <UNDEFINED> instruction: 0x361e6891
    1aa0:	01000011 	tsteq	r0, r1, lsl r0
    1aa4:	004d0e1b 	subeq	r0, sp, fp, lsl lr
    1aa8:	91020000 	mrsls	r0, (UNDEF: 2)
    1aac:	a8240074 	stmdage	r4!, {r2, r4, r5, r6}
    1ab0:	0100000f 	tsteq	r0, pc
    1ab4:	0f610614 	svceq	0x00610614
    1ab8:	8cf80000 	ldclhi	0, cr0, [r8]
    1abc:	001c0000 	andseq	r0, ip, r0
    1ac0:	9c010000 	stcls	0, cr0, [r1], {-0}
    1ac4:	0011bd23 	andseq	fp, r1, r3, lsr #26
    1ac8:	060e0100 	streq	r0, [lr], -r0, lsl #2
    1acc:	00001011 	andeq	r1, r0, r1, lsl r0
    1ad0:	00008ccc 	andeq	r8, r0, ip, asr #25
    1ad4:	0000002c 	andeq	r0, r0, ip, lsr #32
    1ad8:	0af89c01 	beq	ffe28ae4 <__bss_end+0xffe1ed54>
    1adc:	9f200000 	svcls	0x00200000
    1ae0:	0100000f 	tsteq	r0, pc
    1ae4:	0038140e 	eorseq	r1, r8, lr, lsl #8
    1ae8:	91020000 	mrsls	r0, (UNDEF: 2)
    1aec:	bf250074 	svclt	0x00250074
    1af0:	01000012 	tsteq	r0, r2, lsl r0
    1af4:	10330a04 	eorsne	r0, r3, r4, lsl #20
    1af8:	004d0000 	subeq	r0, sp, r0
    1afc:	8ca00000 	stchi	0, cr0, [r0]
    1b00:	002c0000 	eoreq	r0, ip, r0
    1b04:	9c010000 	stcls	0, cr0, [r1], {-0}
    1b08:	64697022 	strbtvs	r7, [r9], #-34	; 0xffffffde
    1b0c:	0e060100 	adfeqs	f0, f6, f0
    1b10:	0000004d 	andeq	r0, r0, sp, asr #32
    1b14:	00749102 	rsbseq	r9, r4, r2, lsl #2
    1b18:	00047c00 	andeq	r7, r4, r0, lsl #24
    1b1c:	2e000400 	cfcpyscs	mvf0, mvf0
    1b20:	04000007 	streq	r0, [r0], #-7
    1b24:	0011df01 	andseq	sp, r1, r1, lsl #30
    1b28:	14100400 	ldrne	r0, [r0], #-1024	; 0xfffffc00
    1b2c:	0eec0000 	cdpeq	0, 14, cr0, cr12, cr0, {0}
    1b30:	90fc0000 	rscsls	r0, ip, r0
    1b34:	07c00000 	strbeq	r0, [r0, r0]
    1b38:	0a9e0000 	beq	fe781b40 <__bss_end+0xfe777db0>
    1b3c:	49020000 	stmdbmi	r2, {}	; <UNPREDICTABLE>
    1b40:	03000000 	movweq	r0, #0
    1b44:	00001381 	andeq	r1, r0, r1, lsl #7
    1b48:	61100501 	tstvs	r0, r1, lsl #10
    1b4c:	11000000 	mrsne	r0, (UNDEF: 0)
    1b50:	33323130 	teqcc	r2, #48, 2
    1b54:	37363534 			; <UNDEFINED> instruction: 0x37363534
    1b58:	42413938 	submi	r3, r1, #56, 18	; 0xe0000
    1b5c:	46454443 	strbmi	r4, [r5], -r3, asr #8
    1b60:	01040000 	mrseq	r0, (UNDEF: 4)
    1b64:	00250103 	eoreq	r0, r5, r3, lsl #2
    1b68:	74050000 	strvc	r0, [r5], #-0
    1b6c:	61000000 	mrsvs	r0, (UNDEF: 0)
    1b70:	06000000 	streq	r0, [r0], -r0
    1b74:	00000066 	andeq	r0, r0, r6, rrx
    1b78:	51070010 	tstpl	r7, r0, lsl r0
    1b7c:	08000000 	stmdaeq	r0, {}	; <UNPREDICTABLE>
    1b80:	0c4b0704 	mcrreq	7, 0, r0, fp, cr4
    1b84:	01080000 	mrseq	r0, (UNDEF: 8)
    1b88:	000d0a08 	andeq	r0, sp, r8, lsl #20
    1b8c:	006d0700 	rsbeq	r0, sp, r0, lsl #14
    1b90:	2a090000 	bcs	241b98 <__bss_end+0x237e08>
    1b94:	0a000000 	beq	1b9c <shift+0x1b9c>
    1b98:	0000130a 	andeq	r1, r0, sl, lsl #6
    1b9c:	6b06aa01 	blvs	1ac3a8 <__bss_end+0x1a2618>
    1ba0:	48000013 	stmdami	r0, {r0, r1, r4}
    1ba4:	74000098 	strvc	r0, [r0], #-152	; 0xffffff68
    1ba8:	01000000 	mrseq	r0, (UNDEF: 0)
    1bac:	0000d19c 	muleq	r0, ip, r1
    1bb0:	13110b00 	tstne	r1, #0, 22
    1bb4:	aa010000 	bge	41bbc <__bss_end+0x37e2c>
    1bb8:	0000d113 	andeq	sp, r0, r3, lsl r1
    1bbc:	6c910200 	lfmvs	f0, 4, [r1], {0}
    1bc0:	6372730c 	cmnvs	r2, #12, 6	; 0x30000000
    1bc4:	25aa0100 	strcs	r0, [sl, #256]!	; 0x100
    1bc8:	000000d7 	ldrdeq	r0, [r0], -r7
    1bcc:	0d689102 	stfeqp	f1, [r8, #-8]!
    1bd0:	ab010069 	blge	41d7c <__bss_end+0x37fec>
    1bd4:	0000dd06 	andeq	sp, r0, r6, lsl #26
    1bd8:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    1bdc:	01006a0d 	tsteq	r0, sp, lsl #20
    1be0:	00dd06ac 	sbcseq	r0, sp, ip, lsr #13
    1be4:	91020000 	mrsls	r0, (UNDEF: 2)
    1be8:	040e0070 	streq	r0, [lr], #-112	; 0xffffff90
    1bec:	0000006d 	andeq	r0, r0, sp, rrx
    1bf0:	0074040e 	rsbseq	r0, r4, lr, lsl #8
    1bf4:	040f0000 	streq	r0, [pc], #-0	; 1bfc <shift+0x1bfc>
    1bf8:	746e6905 	strbtvc	r6, [lr], #-2309	; 0xfffff6fb
    1bfc:	139f1000 	orrsne	r1, pc, #0
    1c00:	a1010000 	mrsge	r0, (UNDEF: 1)
    1c04:	0012e206 	andseq	lr, r2, r6, lsl #4
    1c08:	0097c800 	addseq	ip, r7, r0, lsl #16
    1c0c:	00008000 	andeq	r8, r0, r0
    1c10:	619c0100 	orrsvs	r0, ip, r0, lsl #2
    1c14:	0c000001 	stceq	0, cr0, [r0], {1}
    1c18:	00637273 	rsbeq	r7, r3, r3, ror r2
    1c1c:	6119a101 	tstvs	r9, r1, lsl #2
    1c20:	02000001 	andeq	r0, r0, #1
    1c24:	640c6491 	strvs	r6, [ip], #-1169	; 0xfffffb6f
    1c28:	01007473 	tsteq	r0, r3, ror r4
    1c2c:	016824a1 	cmneq	r8, r1, lsr #9
    1c30:	91020000 	mrsls	r0, (UNDEF: 2)
    1c34:	756e0c60 	strbvc	r0, [lr, #-3168]!	; 0xfffff3a0
    1c38:	a101006d 	tstge	r1, sp, rrx
    1c3c:	0000dd2d 	andeq	sp, r0, sp, lsr #26
    1c40:	5c910200 	lfmpl	f0, 4, [r1], {0}
    1c44:	00139211 	andseq	r9, r3, r1, lsl r2
    1c48:	0ea30100 	fdveqs	f0, f3, f0
    1c4c:	000000d7 	ldrdeq	r0, [r0], -r7
    1c50:	11709102 	cmnne	r0, r2, lsl #2
    1c54:	0000137a 	andeq	r1, r0, sl, ror r3
    1c58:	d108a401 	tstle	r8, r1, lsl #8
    1c5c:	02000000 	andeq	r0, r0, #0
    1c60:	f0126c91 			; <UNDEFINED> instruction: 0xf0126c91
    1c64:	48000097 	stmdami	r0, {r0, r1, r2, r4, r7}
    1c68:	0d000000 	stceq	0, cr0, [r0, #-0]
    1c6c:	a6010069 	strge	r0, [r1], -r9, rrx
    1c70:	0000dd0b 	andeq	sp, r0, fp, lsl #26
    1c74:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    1c78:	040e0000 	streq	r0, [lr], #-0
    1c7c:	00000167 	andeq	r0, r0, r7, ror #2
    1c80:	10041413 	andne	r1, r4, r3, lsl r4
    1c84:	00001399 	muleq	r0, r9, r3
    1c88:	2e069901 	vmlacs.f16	s18, s12, s2	; <UNPREDICTABLE>
    1c8c:	60000013 	andvs	r0, r0, r3, lsl r0
    1c90:	68000097 	stmdavs	r0, {r0, r1, r2, r4, r7}
    1c94:	01000000 	mrseq	r0, (UNDEF: 0)
    1c98:	0001c99c 	muleq	r1, ip, r9
    1c9c:	14020b00 	strne	r0, [r2], #-2816	; 0xfffff500
    1ca0:	99010000 	stmdbls	r1, {}	; <UNPREDICTABLE>
    1ca4:	00016812 	andeq	r6, r1, r2, lsl r8
    1ca8:	6c910200 	lfmvs	f0, 4, [r1], {0}
    1cac:	0014090b 	andseq	r0, r4, fp, lsl #18
    1cb0:	1e990100 	fmlnee	f0, f1, f0
    1cb4:	000000dd 	ldrdeq	r0, [r0], -sp
    1cb8:	0d689102 	stfeqp	f1, [r8, #-8]!
    1cbc:	006d656d 	rsbeq	r6, sp, sp, ror #10
    1cc0:	d1089b01 	tstle	r8, r1, lsl #22
    1cc4:	02000000 	andeq	r0, r0, #0
    1cc8:	7c127091 	ldcvc	0, cr7, [r2], {145}	; 0x91
    1ccc:	3c000097 	stccc	0, cr0, [r0], {151}	; 0x97
    1cd0:	0d000000 	stceq	0, cr0, [r0, #-0]
    1cd4:	9d010069 	stcls	0, cr0, [r1, #-420]	; 0xfffffe5c
    1cd8:	0000dd0b 	andeq	sp, r0, fp, lsl #26
    1cdc:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    1ce0:	03150000 	tsteq	r5, #0
    1ce4:	01000013 	tsteq	r0, r3, lsl r0
    1ce8:	13db058f 	bicsne	r0, fp, #599785472	; 0x23c00000
    1cec:	00dd0000 	sbcseq	r0, sp, r0
    1cf0:	970c0000 	strls	r0, [ip, -r0]
    1cf4:	00540000 	subseq	r0, r4, r0
    1cf8:	9c010000 	stcls	0, cr0, [r1], {-0}
    1cfc:	00000202 	andeq	r0, r0, r2, lsl #4
    1d00:	0100730c 	tsteq	r0, ip, lsl #6
    1d04:	00d7188f 	sbcseq	r1, r7, pc, lsl #17
    1d08:	91020000 	mrsls	r0, (UNDEF: 2)
    1d0c:	00690d6c 	rsbeq	r0, r9, ip, ror #26
    1d10:	dd069101 	stfled	f1, [r6, #-4]
    1d14:	02000000 	andeq	r0, r0, #0
    1d18:	15007491 	strne	r7, [r0, #-1169]	; 0xfffffb6f
    1d1c:	000013a6 	andeq	r1, r0, r6, lsr #7
    1d20:	e8057f01 	stmda	r5, {r0, r8, r9, sl, fp, ip, sp, lr}
    1d24:	dd000013 	stcle	0, cr0, [r0, #-76]	; 0xffffffb4
    1d28:	60000000 	andvs	r0, r0, r0
    1d2c:	ac000096 	stcge	0, cr0, [r0], {150}	; 0x96
    1d30:	01000000 	mrseq	r0, (UNDEF: 0)
    1d34:	0002689c 	muleq	r2, ip, r8
    1d38:	31730c00 	cmncc	r3, r0, lsl #24
    1d3c:	197f0100 	ldmdbne	pc!, {r8}^	; <UNPREDICTABLE>
    1d40:	000000d7 	ldrdeq	r0, [r0], -r7
    1d44:	0c6c9102 	stfeqp	f1, [ip], #-8
    1d48:	01003273 	tsteq	r0, r3, ror r2
    1d4c:	00d7297f 	sbcseq	r2, r7, pc, ror r9
    1d50:	91020000 	mrsls	r0, (UNDEF: 2)
    1d54:	756e0c68 	strbvc	r0, [lr, #-3176]!	; 0xfffff398
    1d58:	7f01006d 	svcvc	0x0001006d
    1d5c:	0000dd31 	andeq	sp, r0, r1, lsr sp
    1d60:	64910200 	ldrvs	r0, [r1], #512	; 0x200
    1d64:	0031750d 	eorseq	r7, r1, sp, lsl #10
    1d68:	68108101 	ldmdavs	r0, {r0, r8, pc}
    1d6c:	02000002 	andeq	r0, r0, #2
    1d70:	750d7791 	strvc	r7, [sp, #-1937]	; 0xfffff86f
    1d74:	81010032 	tsthi	r1, r2, lsr r0
    1d78:	00026814 	andeq	r6, r2, r4, lsl r8
    1d7c:	76910200 	ldrvc	r0, [r1], r0, lsl #4
    1d80:	08010800 	stmdaeq	r1, {fp}
    1d84:	00000d01 	andeq	r0, r0, r1, lsl #26
    1d88:	00133a15 	andseq	r3, r3, r5, lsl sl
    1d8c:	07730100 	ldrbeq	r0, [r3, -r0, lsl #2]!
    1d90:	00001342 	andeq	r1, r0, r2, asr #6
    1d94:	000000d1 	ldrdeq	r0, [r0], -r1
    1d98:	000095a0 	andeq	r9, r0, r0, lsr #11
    1d9c:	000000c0 	andeq	r0, r0, r0, asr #1
    1da0:	02c89c01 	sbceq	r9, r8, #256	; 0x100
    1da4:	110b0000 	mrsne	r0, (UNDEF: 11)
    1da8:	01000013 	tsteq	r0, r3, lsl r0
    1dac:	00d11573 	sbcseq	r1, r1, r3, ror r5
    1db0:	91020000 	mrsls	r0, (UNDEF: 2)
    1db4:	72730c6c 	rsbsvc	r0, r3, #108, 24	; 0x6c00
    1db8:	73010063 	movwvc	r0, #4195	; 0x1063
    1dbc:	0000d727 	andeq	sp, r0, r7, lsr #14
    1dc0:	68910200 	ldmvs	r1, {r9}
    1dc4:	6d756e0c 	ldclvs	14, cr6, [r5, #-48]!	; 0xffffffd0
    1dc8:	30730100 	rsbscc	r0, r3, r0, lsl #2
    1dcc:	000000dd 	ldrdeq	r0, [r0], -sp
    1dd0:	0d649102 	stfeqp	f1, [r4, #-8]!
    1dd4:	75010069 	strvc	r0, [r1, #-105]	; 0xffffff97
    1dd8:	0000dd06 	andeq	sp, r0, r6, lsl #26
    1ddc:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    1de0:	138d1500 	orrne	r1, sp, #0, 10
    1de4:	36010000 	strcc	r0, [r1], -r0
    1de8:	0013cf07 	andseq	ip, r3, r7, lsl #30
    1dec:	0000d100 	andeq	sp, r0, r0, lsl #2
    1df0:	00930c00 	addseq	r0, r3, r0, lsl #24
    1df4:	00029400 	andeq	r9, r2, r0, lsl #8
    1df8:	ac9c0100 	ldfges	f0, [ip], {0}
    1dfc:	0b000003 	bleq	1e10 <shift+0x1e10>
    1e00:	00001316 	andeq	r1, r0, r6, lsl r3
    1e04:	ac123601 	ldcge	6, cr3, [r2], {1}
    1e08:	02000003 	andeq	r0, r0, #3
    1e0c:	c80b4c91 	stmdagt	fp, {r0, r4, r7, sl, fp, lr}
    1e10:	01000013 	tsteq	r0, r3, lsl r0
    1e14:	00d11f36 	sbcseq	r1, r1, r6, lsr pc
    1e18:	91020000 	mrsls	r0, (UNDEF: 2)
    1e1c:	13ae0b48 			; <UNDEFINED> instruction: 0x13ae0b48
    1e20:	36010000 	strcc	r0, [r1], -r0
    1e24:	00006634 	andeq	r6, r0, r4, lsr r6
    1e28:	44910200 	ldrmi	r0, [r1], #512	; 0x200
    1e2c:	7274700d 	rsbsvc	r7, r4, #13
    1e30:	08380100 	ldmdaeq	r8!, {r8}
    1e34:	000000d1 	ldrdeq	r0, [r0], -r1
    1e38:	11749102 	cmnne	r4, r2, lsl #2
    1e3c:	00001353 	andeq	r1, r0, r3, asr r3
    1e40:	dd094101 	stfles	f4, [r9, #-4]
    1e44:	02000000 	andeq	r0, r0, #0
    1e48:	5c117091 	ldcpl	0, cr7, [r1], {145}	; 0x91
    1e4c:	01000013 	tsteq	r0, r3, lsl r0
    1e50:	03ac0b42 			; <UNDEFINED> instruction: 0x03ac0b42
    1e54:	91020000 	mrsls	r0, (UNDEF: 2)
    1e58:	13fa116c 	mvnsne	r1, #108, 2
    1e5c:	45010000 	strmi	r0, [r1, #-0]
    1e60:	0003b30a 	andeq	fp, r3, sl, lsl #6
    1e64:	50910200 	addspl	r0, r1, r0, lsl #4
    1e68:	00132611 	andseq	r2, r3, r1, lsl r6
    1e6c:	0b460100 	bleq	1182274 <__bss_end+0x11784e4>
    1e70:	000000d1 	ldrdeq	r0, [r0], -r1
    1e74:	16689102 	strbtne	r9, [r8], -r2, lsl #2
    1e78:	0000947c 	andeq	r9, r0, ip, ror r4
    1e7c:	00000080 	andeq	r0, r0, r0, lsl #1
    1e80:	00000392 	muleq	r0, r2, r3
    1e84:	0100690d 	tsteq	r0, sp, lsl #18
    1e88:	00dd0e5b 	sbcseq	r0, sp, fp, asr lr
    1e8c:	91020000 	mrsls	r0, (UNDEF: 2)
    1e90:	94941264 	ldrls	r1, [r4], #612	; 0x264
    1e94:	00580000 	subseq	r0, r8, r0
    1e98:	65110000 	ldrvs	r0, [r1, #-0]
    1e9c:	01000013 	tsteq	r0, r3, lsl r0
    1ea0:	00dd0d5d 	sbcseq	r0, sp, sp, asr sp
    1ea4:	91020000 	mrsls	r0, (UNDEF: 2)
    1ea8:	1200005c 	andne	r0, r0, #92	; 0x5c
    1eac:	00009514 	andeq	r9, r0, r4, lsl r5
    1eb0:	00000070 	andeq	r0, r0, r0, ror r0
    1eb4:	646e650d 	strbtvs	r6, [lr], #-1293	; 0xfffffaf3
    1eb8:	0f670100 	svceq	0x00670100
    1ebc:	000000d1 	ldrdeq	r0, [r0], -r1
    1ec0:	00609102 	rsbeq	r9, r0, r2, lsl #2
    1ec4:	04040800 	streq	r0, [r4], #-2048	; 0xfffff800
    1ec8:	00000694 	muleq	r0, r4, r6
    1ecc:	00006d05 	andeq	r6, r0, r5, lsl #26
    1ed0:	0003c300 	andeq	ip, r3, r0, lsl #6
    1ed4:	00660600 	rsbeq	r0, r6, r0, lsl #12
    1ed8:	000b0000 	andeq	r0, fp, r0
    1edc:	0012fe15 	andseq	pc, r2, r5, lsl lr	; <UNPREDICTABLE>
    1ee0:	05240100 	streq	r0, [r4, #-256]!	; 0xffffff00
    1ee4:	000013bd 			; <UNDEFINED> instruction: 0x000013bd
    1ee8:	000000dd 	ldrdeq	r0, [r0], -sp
    1eec:	00009270 	andeq	r9, r0, r0, ror r2
    1ef0:	0000009c 	muleq	r0, ip, r0
    1ef4:	04009c01 	streq	r9, [r0], #-3073	; 0xfffff3ff
    1ef8:	160b0000 	strne	r0, [fp], -r0
    1efc:	01000013 	tsteq	r0, r3, lsl r0
    1f00:	00d71624 	sbcseq	r1, r7, r4, lsr #12
    1f04:	91020000 	mrsls	r0, (UNDEF: 2)
    1f08:	13c8116c 	bicne	r1, r8, #108, 2
    1f0c:	26010000 	strcs	r0, [r1], -r0
    1f10:	0000dd06 	andeq	sp, r0, r6, lsl #26
    1f14:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    1f18:	13211700 			; <UNDEFINED> instruction: 0x13211700
    1f1c:	08010000 	stmdaeq	r1, {}	; <UNPREDICTABLE>
    1f20:	0012f206 	andseq	pc, r2, r6, lsl #4
    1f24:	0090fc00 	addseq	pc, r0, r0, lsl #24
    1f28:	00017400 	andeq	r7, r1, r0, lsl #8
    1f2c:	0b9c0100 	bleq	fe702334 <__bss_end+0xfe6f85a4>
    1f30:	00001316 	andeq	r1, r0, r6, lsl r3
    1f34:	66180801 	ldrvs	r0, [r8], -r1, lsl #16
    1f38:	02000000 	andeq	r0, r0, #0
    1f3c:	c80b6491 	stmdagt	fp, {r0, r4, r7, sl, sp, lr}
    1f40:	01000013 	tsteq	r0, r3, lsl r0
    1f44:	00d12508 	sbcseq	r2, r1, r8, lsl #10
    1f48:	91020000 	mrsls	r0, (UNDEF: 2)
    1f4c:	131c0b60 	tstne	ip, #96, 22	; 0x18000
    1f50:	08010000 	stmdaeq	r1, {}	; <UNPREDICTABLE>
    1f54:	0000663a 	andeq	r6, r0, sl, lsr r6
    1f58:	5c910200 	lfmpl	f0, 4, [r1], {0}
    1f5c:	0100690d 	tsteq	r0, sp, lsl #18
    1f60:	00dd060a 	sbcseq	r0, sp, sl, lsl #12
    1f64:	91020000 	mrsls	r0, (UNDEF: 2)
    1f68:	91c81274 	bicls	r1, r8, r4, ror r2
    1f6c:	00980000 	addseq	r0, r8, r0
    1f70:	6a0d0000 	bvs	341f78 <__bss_end+0x3381e8>
    1f74:	0b1c0100 	bleq	70237c <__bss_end+0x6f85ec>
    1f78:	000000dd 	ldrdeq	r0, [r0], -sp
    1f7c:	12709102 	rsbsne	r9, r0, #-2147483648	; 0x80000000
    1f80:	000091f0 	strdeq	r9, [r0], -r0
    1f84:	00000060 	andeq	r0, r0, r0, rrx
    1f88:	0100630d 	tsteq	r0, sp, lsl #6
    1f8c:	006d081e 	rsbeq	r0, sp, lr, lsl r8
    1f90:	91020000 	mrsls	r0, (UNDEF: 2)
    1f94:	0000006f 	andeq	r0, r0, pc, rrx
	...

Disassembly of section .debug_abbrev:

00000000 <.debug_abbrev>:
   0:	10001101 	andne	r1, r0, r1, lsl #2
   4:	12011106 	andne	r1, r1, #-2147483647	; 0x80000001
   8:	1b0e0301 	blne	380c14 <__bss_end+0x376e84>
   c:	130e250e 	movwne	r2, #58638	; 0xe50e
  10:	00000005 	andeq	r0, r0, r5
  14:	25011101 	strcs	r1, [r1, #-257]	; 0xfffffeff
  18:	030b130e 	movweq	r1, #45838	; 0xb30e
  1c:	110e1b0e 	tstne	lr, lr, lsl #22
  20:	10061201 	andne	r1, r6, r1, lsl #4
  24:	02000017 	andeq	r0, r0, #23
  28:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
  2c:	0b3b0b3a 	bleq	ec2d1c <__bss_end+0xeb8f8c>
  30:	13490b39 	movtne	r0, #39737	; 0x9b39
  34:	193c193f 	ldmdbne	ip!, {r0, r1, r2, r3, r4, r5, r8, fp, ip}
  38:	24030000 	strcs	r0, [r3], #-0
  3c:	3e0b0b00 	vmlacc.f64	d0, d11, d0
  40:	000e030b 	andeq	r0, lr, fp, lsl #6
  44:	012e0400 			; <UNDEFINED> instruction: 0x012e0400
  48:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
  4c:	0b3b0b3a 	bleq	ec2d3c <__bss_end+0xeb8fac>
  50:	01110b39 	tsteq	r1, r9, lsr fp
  54:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
  58:	01194296 			; <UNDEFINED> instruction: 0x01194296
  5c:	05000013 	streq	r0, [r0, #-19]	; 0xffffffed
  60:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
  64:	0b3b0b3a 	bleq	ec2d54 <__bss_end+0xeb8fc4>
  68:	13490b39 	movtne	r0, #39737	; 0x9b39
  6c:	00001802 	andeq	r1, r0, r2, lsl #16
  70:	0b002406 	bleq	9090 <_Z4pipePKcj+0x44>
  74:	030b3e0b 	movweq	r3, #48651	; 0xbe0b
  78:	07000008 	streq	r0, [r0, -r8]
  7c:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
  80:	0b3a0e03 	bleq	e83894 <__bss_end+0xe79b04>
  84:	0b390b3b 	bleq	e42d78 <__bss_end+0xe38fe8>
  88:	06120111 			; <UNDEFINED> instruction: 0x06120111
  8c:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
  90:	00130119 	andseq	r0, r3, r9, lsl r1
  94:	010b0800 	tsteq	fp, r0, lsl #16
  98:	06120111 			; <UNDEFINED> instruction: 0x06120111
  9c:	34090000 	strcc	r0, [r9], #-0
  a0:	3a080300 	bcc	200ca8 <__bss_end+0x1f6f18>
  a4:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
  a8:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
  ac:	0a000018 	beq	114 <shift+0x114>
  b0:	0b0b000f 	bleq	2c00f4 <__bss_end+0x2b6364>
  b4:	00001349 	andeq	r1, r0, r9, asr #6
  b8:	01110100 	tsteq	r1, r0, lsl #2
  bc:	0b130e25 	bleq	4c3958 <__bss_end+0x4b9bc8>
  c0:	0e1b0e03 	cdpeq	14, 1, cr0, cr11, cr3, {0}
  c4:	06120111 			; <UNDEFINED> instruction: 0x06120111
  c8:	00001710 	andeq	r1, r0, r0, lsl r7
  cc:	03001602 	movweq	r1, #1538	; 0x602
  d0:	3b0b3a0e 	blcc	2ce910 <__bss_end+0x2c4b80>
  d4:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
  d8:	03000013 	movweq	r0, #19
  dc:	0b0b000f 	bleq	2c0120 <__bss_end+0x2b6390>
  e0:	00001349 	andeq	r1, r0, r9, asr #6
  e4:	00001504 	andeq	r1, r0, r4, lsl #10
  e8:	01010500 	tsteq	r1, r0, lsl #10
  ec:	13011349 	movwne	r1, #4937	; 0x1349
  f0:	21060000 	mrscs	r0, (UNDEF: 6)
  f4:	2f134900 	svccs	0x00134900
  f8:	07000006 	streq	r0, [r0, -r6]
  fc:	0b0b0024 	bleq	2c0194 <__bss_end+0x2b6404>
 100:	0e030b3e 	vmoveq.16	d3[0], r0
 104:	34080000 	strcc	r0, [r8], #-0
 108:	3a0e0300 	bcc	380d10 <__bss_end+0x376f80>
 10c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 110:	3f13490b 	svccc	0x0013490b
 114:	00193c19 	andseq	r3, r9, r9, lsl ip
 118:	012e0900 			; <UNDEFINED> instruction: 0x012e0900
 11c:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 120:	0b3b0b3a 	bleq	ec2e10 <__bss_end+0xeb9080>
 124:	13490b39 	movtne	r0, #39737	; 0x9b39
 128:	06120111 			; <UNDEFINED> instruction: 0x06120111
 12c:	42961840 	addsmi	r1, r6, #64, 16	; 0x400000
 130:	00130119 	andseq	r0, r3, r9, lsl r1
 134:	00340a00 	eorseq	r0, r4, r0, lsl #20
 138:	0b3a0e03 	bleq	e8394c <__bss_end+0xe79bbc>
 13c:	0b390b3b 	bleq	e42e30 <__bss_end+0xe390a0>
 140:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 144:	240b0000 	strcs	r0, [fp], #-0
 148:	3e0b0b00 	vmlacc.f64	d0, d11, d0
 14c:	0008030b 	andeq	r0, r8, fp, lsl #6
 150:	002e0c00 	eoreq	r0, lr, r0, lsl #24
 154:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 158:	0b3b0b3a 	bleq	ec2e48 <__bss_end+0xeb90b8>
 15c:	01110b39 	tsteq	r1, r9, lsr fp
 160:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 164:	00194297 	mulseq	r9, r7, r2
 168:	01390d00 	teqeq	r9, r0, lsl #26
 16c:	0b3a0e03 	bleq	e83980 <__bss_end+0xe79bf0>
 170:	13010b3b 	movwne	r0, #6971	; 0x1b3b
 174:	2e0e0000 	cdpcs	0, 0, cr0, cr14, cr0, {0}
 178:	03193f01 	tsteq	r9, #1, 30
 17c:	3b0b3a0e 	blcc	2ce9bc <__bss_end+0x2c4c2c>
 180:	3c0b390b 			; <UNDEFINED> instruction: 0x3c0b390b
 184:	00130119 	andseq	r0, r3, r9, lsl r1
 188:	00050f00 	andeq	r0, r5, r0, lsl #30
 18c:	00001349 	andeq	r1, r0, r9, asr #6
 190:	3f012e10 	svccc	0x00012e10
 194:	3a0e0319 	bcc	380e00 <__bss_end+0x377070>
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
 1c0:	3a080300 	bcc	200dc8 <__bss_end+0x1f7038>
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
 1f4:	0b0b0024 	bleq	2c028c <__bss_end+0x2b64fc>
 1f8:	0e030b3e 	vmoveq.16	d3[0], r0
 1fc:	26030000 	strcs	r0, [r3], -r0
 200:	00134900 	andseq	r4, r3, r0, lsl #18
 204:	00240400 	eoreq	r0, r4, r0, lsl #8
 208:	0b3e0b0b 	bleq	f82e3c <__bss_end+0xf790ac>
 20c:	00000803 	andeq	r0, r0, r3, lsl #16
 210:	03001605 	movweq	r1, #1541	; 0x605
 214:	3b0b3a0e 	blcc	2cea54 <__bss_end+0x2c4cc4>
 218:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 21c:	06000013 			; <UNDEFINED> instruction: 0x06000013
 220:	0e030113 	mcreq	1, 0, r0, cr3, cr3, {0}
 224:	0b3a0b0b 	bleq	e82e58 <__bss_end+0xe790c8>
 228:	0b390b3b 	bleq	e42f1c <__bss_end+0xe3918c>
 22c:	00001301 	andeq	r1, r0, r1, lsl #6
 230:	03000d07 	movweq	r0, #3335	; 0xd07
 234:	3b0b3a08 	blcc	2cea5c <__bss_end+0x2c4ccc>
 238:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 23c:	000b3813 	andeq	r3, fp, r3, lsl r8
 240:	01040800 	tsteq	r4, r0, lsl #16
 244:	196d0e03 	stmdbne	sp!, {r0, r1, r9, sl, fp}^
 248:	0b0b0b3e 	bleq	2c2f48 <__bss_end+0x2b91b8>
 24c:	0b3a1349 	bleq	e84f78 <__bss_end+0xe7b1e8>
 250:	0b390b3b 	bleq	e42f44 <__bss_end+0xe391b4>
 254:	00001301 	andeq	r1, r0, r1, lsl #6
 258:	03002809 	movweq	r2, #2057	; 0x809
 25c:	000b1c0e 	andeq	r1, fp, lr, lsl #24
 260:	00340a00 	eorseq	r0, r4, r0, lsl #20
 264:	0b3a0e03 	bleq	e83a78 <__bss_end+0xe79ce8>
 268:	0b390b3b 	bleq	e42f5c <__bss_end+0xe391cc>
 26c:	196c1349 	stmdbne	ip!, {r0, r3, r6, r8, r9, ip}^
 270:	00001802 	andeq	r1, r0, r2, lsl #16
 274:	0300020b 	movweq	r0, #523	; 0x20b
 278:	00193c0e 	andseq	r3, r9, lr, lsl #24
 27c:	01010c00 	tsteq	r1, r0, lsl #24
 280:	13011349 	movwne	r1, #4937	; 0x1349
 284:	210d0000 	mrscs	r0, (UNDEF: 13)
 288:	2f134900 	svccs	0x00134900
 28c:	0e00000b 	cdpeq	0, 0, cr0, cr0, cr11, {0}
 290:	0b0b000f 	bleq	2c02d4 <__bss_end+0x2b6544>
 294:	00001349 	andeq	r1, r0, r9, asr #6
 298:	0300280f 	movweq	r2, #2063	; 0x80f
 29c:	000b1c08 	andeq	r1, fp, r8, lsl #24
 2a0:	000d1000 	andeq	r1, sp, r0
 2a4:	0b3a0e03 	bleq	e83ab8 <__bss_end+0xe79d28>
 2a8:	0b390b3b 	bleq	e42f9c <__bss_end+0xe3920c>
 2ac:	0b381349 	bleq	e04fd8 <__bss_end+0xdfb248>
 2b0:	02110000 	andseq	r0, r1, #0
 2b4:	0b0e0301 	bleq	380ec0 <__bss_end+0x377130>
 2b8:	3b0b3a0b 	blcc	2ceaec <__bss_end+0x2c4d5c>
 2bc:	010b390b 	tsteq	fp, fp, lsl #18
 2c0:	12000013 	andne	r0, r0, #19
 2c4:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 2c8:	0b3a0e03 	bleq	e83adc <__bss_end+0xe79d4c>
 2cc:	0b390b3b 	bleq	e42fc0 <__bss_end+0xe39230>
 2d0:	193c0e6e 	ldmdbne	ip!, {r1, r2, r3, r5, r6, r9, sl, fp}
 2d4:	13011364 	movwne	r1, #4964	; 0x1364
 2d8:	05130000 	ldreq	r0, [r3, #-0]
 2dc:	34134900 	ldrcc	r4, [r3], #-2304	; 0xfffff700
 2e0:	14000019 	strne	r0, [r0], #-25	; 0xffffffe7
 2e4:	13490005 	movtne	r0, #36869	; 0x9005
 2e8:	2e150000 	cdpcs	0, 1, cr0, cr5, cr0, {0}
 2ec:	03193f01 	tsteq	r9, #1, 30
 2f0:	3b0b3a0e 	blcc	2ceb30 <__bss_end+0x2c4da0>
 2f4:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 2f8:	3c13490e 			; <UNDEFINED> instruction: 0x3c13490e
 2fc:	01136419 	tsteq	r3, r9, lsl r4
 300:	16000013 			; <UNDEFINED> instruction: 0x16000013
 304:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 308:	0b3a0e03 	bleq	e83b1c <__bss_end+0xe79d8c>
 30c:	0b390b3b 	bleq	e43000 <__bss_end+0xe39270>
 310:	13490e6e 	movtne	r0, #40558	; 0x9e6e
 314:	193c0b32 	ldmdbne	ip!, {r1, r4, r5, r8, r9, fp}
 318:	13011364 	movwne	r1, #4964	; 0x1364
 31c:	0d170000 	ldceq	0, cr0, [r7, #-0]
 320:	3a0e0300 	bcc	380f28 <__bss_end+0x377198>
 324:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 328:	3813490b 	ldmdacc	r3, {r0, r1, r3, r8, fp, lr}
 32c:	000b320b 	andeq	r3, fp, fp, lsl #4
 330:	012e1800 			; <UNDEFINED> instruction: 0x012e1800
 334:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 338:	0b3b0b3a 	bleq	ec3028 <__bss_end+0xeb9298>
 33c:	0e6e0b39 	vmoveq.8	d14[5], r0
 340:	193c0b32 	ldmdbne	ip!, {r1, r4, r5, r8, r9, fp}
 344:	13011364 	movwne	r1, #4964	; 0x1364
 348:	2e190000 	cdpcs	0, 1, cr0, cr9, cr0, {0}
 34c:	03193f01 	tsteq	r9, #1, 30
 350:	3b0b3a0e 	blcc	2ceb90 <__bss_end+0x2c4e00>
 354:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 358:	3213490e 	andscc	r4, r3, #229376	; 0x38000
 35c:	64193c0b 	ldrvs	r3, [r9], #-3083	; 0xfffff3f5
 360:	1a000013 	bne	3b4 <shift+0x3b4>
 364:	13490115 	movtne	r0, #37141	; 0x9115
 368:	13011364 	movwne	r1, #4964	; 0x1364
 36c:	1f1b0000 	svcne	0x001b0000
 370:	49131d00 	ldmdbmi	r3, {r8, sl, fp, ip}
 374:	1c000013 	stcne	0, cr0, [r0], {19}
 378:	0b0b0010 	bleq	2c03c0 <__bss_end+0x2b6630>
 37c:	00001349 	andeq	r1, r0, r9, asr #6
 380:	0b000f1d 	bleq	3ffc <shift+0x3ffc>
 384:	1e00000b 	cdpne	0, 0, cr0, cr0, cr11, {0}
 388:	08030139 	stmdaeq	r3, {r0, r3, r4, r5, r8}
 38c:	0b3b0b3a 	bleq	ec307c <__bss_end+0xeb92ec>
 390:	13010b39 	movwne	r0, #6969	; 0x1b39
 394:	341f0000 	ldrcc	r0, [pc], #-0	; 39c <shift+0x39c>
 398:	3a0e0300 	bcc	380fa0 <__bss_end+0x377210>
 39c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 3a0:	3c13490b 			; <UNDEFINED> instruction: 0x3c13490b
 3a4:	6c061c19 	stcvs	12, cr1, [r6], {25}
 3a8:	20000019 	andcs	r0, r0, r9, lsl r0
 3ac:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 3b0:	0b3b0b3a 	bleq	ec30a0 <__bss_end+0xeb9310>
 3b4:	13490b39 	movtne	r0, #39737	; 0x9b39
 3b8:	0b1c193c 	bleq	7068b0 <__bss_end+0x6fcb20>
 3bc:	0000196c 	andeq	r1, r0, ip, ror #18
 3c0:	47003421 	strmi	r3, [r0, -r1, lsr #8]
 3c4:	22000013 	andcs	r0, r0, #19
 3c8:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 3cc:	0b3b0b3a 	bleq	ec30bc <__bss_end+0xeb932c>
 3d0:	13490b39 	movtne	r0, #39737	; 0x9b39
 3d4:	1802193f 	stmdane	r2, {r0, r1, r2, r3, r4, r5, r8, fp, ip}
 3d8:	34230000 	strtcc	r0, [r3], #-0
 3dc:	3a0e0300 	bcc	380fe4 <__bss_end+0x377254>
 3e0:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 3e4:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 3e8:	24000018 	strcs	r0, [r0], #-24	; 0xffffffe8
 3ec:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 3f0:	0b3a0e03 	bleq	e83c04 <__bss_end+0xe79e74>
 3f4:	0b390b3b 	bleq	e430e8 <__bss_end+0xe39358>
 3f8:	01111349 	tsteq	r1, r9, asr #6
 3fc:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 400:	01194296 			; <UNDEFINED> instruction: 0x01194296
 404:	25000013 	strcs	r0, [r0, #-19]	; 0xffffffed
 408:	0e030005 	cdpeq	0, 0, cr0, cr3, cr5, {0}
 40c:	0b3b0b3a 	bleq	ec30fc <__bss_end+0xeb936c>
 410:	13490b39 	movtne	r0, #39737	; 0x9b39
 414:	00001802 	andeq	r1, r0, r2, lsl #16
 418:	03003426 	movweq	r3, #1062	; 0x426
 41c:	3b0b3a0e 	blcc	2cec5c <__bss_end+0x2c4ecc>
 420:	490b3905 	stmdbmi	fp, {r0, r2, r8, fp, ip, sp}
 424:	00180213 	andseq	r0, r8, r3, lsl r2
 428:	012e2700 			; <UNDEFINED> instruction: 0x012e2700
 42c:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 430:	0b3b0b3a 	bleq	ec3120 <__bss_end+0xeb9390>
 434:	0e6e0b39 	vmoveq.8	d14[5], r0
 438:	06120111 			; <UNDEFINED> instruction: 0x06120111
 43c:	42961840 	addsmi	r1, r6, #64, 16	; 0x400000
 440:	00130119 	andseq	r0, r3, r9, lsl r1
 444:	00342800 	eorseq	r2, r4, r0, lsl #16
 448:	0b3a0803 	bleq	e8245c <__bss_end+0xe786cc>
 44c:	0b390b3b 	bleq	e43140 <__bss_end+0xe393b0>
 450:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 454:	2e290000 	cdpcs	0, 2, cr0, cr9, cr0, {0}
 458:	03193f01 	tsteq	r9, #1, 30
 45c:	3b0b3a0e 	blcc	2cec9c <__bss_end+0x2c4f0c>
 460:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 464:	1113490e 	tstne	r3, lr, lsl #18
 468:	40061201 	andmi	r1, r6, r1, lsl #4
 46c:	19429618 	stmdbne	r2, {r3, r4, r9, sl, ip, pc}^
 470:	00001301 	andeq	r1, r0, r1, lsl #6
 474:	3f012e2a 	svccc	0x00012e2a
 478:	3a080319 	bcc	2010e4 <__bss_end+0x1f7354>
 47c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 480:	110e6e0b 	tstne	lr, fp, lsl #28
 484:	40061201 	andmi	r1, r6, r1, lsl #4
 488:	19429618 	stmdbne	r2, {r3, r4, r9, sl, ip, pc}^
 48c:	00001301 	andeq	r1, r0, r1, lsl #6
 490:	0300052b 	movweq	r0, #1323	; 0x52b
 494:	3b0b3a08 	blcc	2cecbc <__bss_end+0x2c4f2c>
 498:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 49c:	00180213 	andseq	r0, r8, r3, lsl r2
 4a0:	00212c00 	eoreq	r2, r1, r0, lsl #24
 4a4:	182f1349 	stmdane	pc!, {r0, r3, r6, r8, r9, ip}	; <UNPREDICTABLE>
 4a8:	2e2d0000 	cdpcs	0, 2, cr0, cr13, cr0, {0}
 4ac:	03193f01 	tsteq	r9, #1, 30
 4b0:	3b0b3a0e 	blcc	2cecf0 <__bss_end+0x2c4f60>
 4b4:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 4b8:	1201110e 	andne	r1, r1, #-2147483645	; 0x80000003
 4bc:	96184006 	ldrls	r4, [r8], -r6
 4c0:	00001942 	andeq	r1, r0, r2, asr #18
 4c4:	01110100 	tsteq	r1, r0, lsl #2
 4c8:	0b130e25 	bleq	4c3d64 <__bss_end+0x4b9fd4>
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
 4f8:	0b3a0e03 	bleq	e83d0c <__bss_end+0xe79f7c>
 4fc:	0b390b3b 	bleq	e431f0 <__bss_end+0xe39460>
 500:	00001349 	andeq	r1, r0, r9, asr #6
 504:	03011306 	movweq	r1, #4870	; 0x1306
 508:	3a0b0b0e 	bcc	2c3148 <__bss_end+0x2b93b8>
 50c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 510:	0013010b 	andseq	r0, r3, fp, lsl #2
 514:	000d0700 	andeq	r0, sp, r0, lsl #14
 518:	0b3a0803 	bleq	e8252c <__bss_end+0xe7879c>
 51c:	0b390b3b 	bleq	e43210 <__bss_end+0xe39480>
 520:	0b381349 	bleq	e0524c <__bss_end+0xdfb4bc>
 524:	04080000 	streq	r0, [r8], #-0
 528:	6d0e0301 	stcvs	3, cr0, [lr, #-4]
 52c:	0b0b3e19 	bleq	2cfd98 <__bss_end+0x2c6008>
 530:	3a13490b 	bcc	4d2964 <__bss_end+0x4c8bd4>
 534:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 538:	0013010b 	andseq	r0, r3, fp, lsl #2
 53c:	00280900 	eoreq	r0, r8, r0, lsl #18
 540:	0b1c0803 	bleq	702554 <__bss_end+0x6f87c4>
 544:	280a0000 	stmdacs	sl, {}	; <UNPREDICTABLE>
 548:	1c0e0300 	stcne	3, cr0, [lr], {-0}
 54c:	0b00000b 	bleq	580 <shift+0x580>
 550:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 554:	0b3b0b3a 	bleq	ec3244 <__bss_end+0xeb94b4>
 558:	13490b39 	movtne	r0, #39737	; 0x9b39
 55c:	1802196c 	stmdane	r2, {r2, r3, r5, r6, r8, fp, ip}
 560:	020c0000 	andeq	r0, ip, #0
 564:	3c0e0300 	stccc	3, cr0, [lr], {-0}
 568:	0d000019 	stceq	0, cr0, [r0, #-100]	; 0xffffff9c
 56c:	0b0b000f 	bleq	2c05b0 <__bss_end+0x2b6820>
 570:	00001349 	andeq	r1, r0, r9, asr #6
 574:	03000d0e 	movweq	r0, #3342	; 0xd0e
 578:	3b0b3a0e 	blcc	2cedb8 <__bss_end+0x2c5028>
 57c:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 580:	000b3813 	andeq	r3, fp, r3, lsl r8
 584:	01010f00 	tsteq	r1, r0, lsl #30
 588:	13011349 	movwne	r1, #4937	; 0x1349
 58c:	21100000 	tstcs	r0, r0
 590:	2f134900 	svccs	0x00134900
 594:	1100000b 	tstne	r0, fp
 598:	0e030102 	adfeqs	f0, f3, f2
 59c:	0b3a0b0b 	bleq	e831d0 <__bss_end+0xe79440>
 5a0:	0b390b3b 	bleq	e43294 <__bss_end+0xe39504>
 5a4:	00001301 	andeq	r1, r0, r1, lsl #6
 5a8:	3f012e12 	svccc	0x00012e12
 5ac:	3a0e0319 	bcc	381218 <__bss_end+0x377488>
 5b0:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 5b4:	3c0e6e0b 	stccc	14, cr6, [lr], {11}
 5b8:	01136419 	tsteq	r3, r9, lsl r4
 5bc:	13000013 	movwne	r0, #19
 5c0:	13490005 	movtne	r0, #36869	; 0x9005
 5c4:	00001934 	andeq	r1, r0, r4, lsr r9
 5c8:	49000514 	stmdbmi	r0, {r2, r4, r8, sl}
 5cc:	15000013 	strne	r0, [r0, #-19]	; 0xffffffed
 5d0:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 5d4:	0b3a0e03 	bleq	e83de8 <__bss_end+0xe7a058>
 5d8:	0b390b3b 	bleq	e432cc <__bss_end+0xe3953c>
 5dc:	13490e6e 	movtne	r0, #40558	; 0x9e6e
 5e0:	1364193c 	cmnne	r4, #60, 18	; 0xf0000
 5e4:	00001301 	andeq	r1, r0, r1, lsl #6
 5e8:	3f012e16 	svccc	0x00012e16
 5ec:	3a0e0319 	bcc	381258 <__bss_end+0x3774c8>
 5f0:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 5f4:	490e6e0b 	stmdbmi	lr, {r0, r1, r3, r9, sl, fp, sp, lr}
 5f8:	3c0b3213 	sfmcc	f3, 4, [fp], {19}
 5fc:	01136419 	tsteq	r3, r9, lsl r4
 600:	17000013 	smladne	r0, r3, r0, r0
 604:	0e03000d 	cdpeq	0, 0, cr0, cr3, cr13, {0}
 608:	0b3b0b3a 	bleq	ec32f8 <__bss_end+0xeb9568>
 60c:	13490b39 	movtne	r0, #39737	; 0x9b39
 610:	0b320b38 	bleq	c832f8 <__bss_end+0xc79568>
 614:	2e180000 	cdpcs	0, 1, cr0, cr8, cr0, {0}
 618:	03193f01 	tsteq	r9, #1, 30
 61c:	3b0b3a0e 	blcc	2cee5c <__bss_end+0x2c50cc>
 620:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 624:	3c0b320e 	sfmcc	f3, 4, [fp], {14}
 628:	01136419 	tsteq	r3, r9, lsl r4
 62c:	19000013 	stmdbne	r0, {r0, r1, r4}
 630:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 634:	0b3a0e03 	bleq	e83e48 <__bss_end+0xe7a0b8>
 638:	0b390b3b 	bleq	e4332c <__bss_end+0xe3959c>
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
 670:	3b0b3a0e 	blcc	2ceeb0 <__bss_end+0x2c5120>
 674:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 678:	00180213 	andseq	r0, r8, r3, lsl r2
 67c:	012e1f00 			; <UNDEFINED> instruction: 0x012e1f00
 680:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 684:	0b3b0b3a 	bleq	ec3374 <__bss_end+0xeb95e4>
 688:	0e6e0b39 	vmoveq.8	d14[5], r0
 68c:	01111349 	tsteq	r1, r9, asr #6
 690:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 694:	01194296 			; <UNDEFINED> instruction: 0x01194296
 698:	20000013 	andcs	r0, r0, r3, lsl r0
 69c:	0e030005 	cdpeq	0, 0, cr0, cr3, cr5, {0}
 6a0:	0b3b0b3a 	bleq	ec3390 <__bss_end+0xeb9600>
 6a4:	13490b39 	movtne	r0, #39737	; 0x9b39
 6a8:	00001802 	andeq	r1, r0, r2, lsl #16
 6ac:	3f012e21 	svccc	0x00012e21
 6b0:	3a0e0319 	bcc	38131c <__bss_end+0x37758c>
 6b4:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 6b8:	490e6e0b 	stmdbmi	lr, {r0, r1, r3, r9, sl, fp, sp, lr}
 6bc:	12011113 	andne	r1, r1, #-1073741820	; 0xc0000004
 6c0:	97184006 	ldrls	r4, [r8, -r6]
 6c4:	13011942 	movwne	r1, #6466	; 0x1942
 6c8:	34220000 	strtcc	r0, [r2], #-0
 6cc:	3a080300 	bcc	2012d4 <__bss_end+0x1f7544>
 6d0:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 6d4:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 6d8:	23000018 	movwcs	r0, #24
 6dc:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 6e0:	0b3a0e03 	bleq	e83ef4 <__bss_end+0xe7a164>
 6e4:	0b390b3b 	bleq	e433d8 <__bss_end+0xe39648>
 6e8:	01110e6e 	tsteq	r1, lr, ror #28
 6ec:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 6f0:	01194297 			; <UNDEFINED> instruction: 0x01194297
 6f4:	24000013 	strcs	r0, [r0], #-19	; 0xffffffed
 6f8:	193f002e 	ldmdbne	pc!, {r1, r2, r3, r5}	; <UNPREDICTABLE>
 6fc:	0b3a0e03 	bleq	e83f10 <__bss_end+0xe7a180>
 700:	0b390b3b 	bleq	e433f4 <__bss_end+0xe39664>
 704:	01110e6e 	tsteq	r1, lr, ror #28
 708:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 70c:	00194297 	mulseq	r9, r7, r2
 710:	012e2500 			; <UNDEFINED> instruction: 0x012e2500
 714:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 718:	0b3b0b3a 	bleq	ec3408 <__bss_end+0xeb9678>
 71c:	0e6e0b39 	vmoveq.8	d14[5], r0
 720:	01111349 	tsteq	r1, r9, asr #6
 724:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 728:	00194297 	mulseq	r9, r7, r2
 72c:	11010000 	mrsne	r0, (UNDEF: 1)
 730:	130e2501 	movwne	r2, #58625	; 0xe501
 734:	1b0e030b 	blne	381368 <__bss_end+0x3775d8>
 738:	1201110e 	andne	r1, r1, #-2147483645	; 0x80000003
 73c:	00171006 	andseq	r1, r7, r6
 740:	01390200 	teqeq	r9, r0, lsl #4
 744:	00001301 	andeq	r1, r0, r1, lsl #6
 748:	03003403 	movweq	r3, #1027	; 0x403
 74c:	3b0b3a0e 	blcc	2cef8c <__bss_end+0x2c51fc>
 750:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 754:	1c193c13 	ldcne	12, cr3, [r9], {19}
 758:	0400000a 	streq	r0, [r0], #-10
 75c:	0b3a003a 	bleq	e8084c <__bss_end+0xe76abc>
 760:	0b390b3b 	bleq	e43454 <__bss_end+0xe396c4>
 764:	00001318 	andeq	r1, r0, r8, lsl r3
 768:	49010105 	stmdbmi	r1, {r0, r2, r8}
 76c:	00130113 	andseq	r0, r3, r3, lsl r1
 770:	00210600 	eoreq	r0, r1, r0, lsl #12
 774:	0b2f1349 	bleq	bc54a0 <__bss_end+0xbbb710>
 778:	26070000 	strcs	r0, [r7], -r0
 77c:	00134900 	andseq	r4, r3, r0, lsl #18
 780:	00240800 	eoreq	r0, r4, r0, lsl #16
 784:	0b3e0b0b 	bleq	f833b8 <__bss_end+0xf79628>
 788:	00000e03 	andeq	r0, r0, r3, lsl #28
 78c:	47003409 	strmi	r3, [r0, -r9, lsl #8]
 790:	0a000013 	beq	7e4 <shift+0x7e4>
 794:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 798:	0b3a0e03 	bleq	e83fac <__bss_end+0xe7a21c>
 79c:	0b390b3b 	bleq	e43490 <__bss_end+0xe39700>
 7a0:	01110e6e 	tsteq	r1, lr, ror #28
 7a4:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 7a8:	01194296 			; <UNDEFINED> instruction: 0x01194296
 7ac:	0b000013 	bleq	800 <shift+0x800>
 7b0:	0e030005 	cdpeq	0, 0, cr0, cr3, cr5, {0}
 7b4:	0b3b0b3a 	bleq	ec34a4 <__bss_end+0xeb9714>
 7b8:	13490b39 	movtne	r0, #39737	; 0x9b39
 7bc:	00001802 	andeq	r1, r0, r2, lsl #16
 7c0:	0300050c 	movweq	r0, #1292	; 0x50c
 7c4:	3b0b3a08 	blcc	2cefec <__bss_end+0x2c525c>
 7c8:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 7cc:	00180213 	andseq	r0, r8, r3, lsl r2
 7d0:	00340d00 	eorseq	r0, r4, r0, lsl #26
 7d4:	0b3a0803 	bleq	e827e8 <__bss_end+0xe78a58>
 7d8:	0b390b3b 	bleq	e434cc <__bss_end+0xe3973c>
 7dc:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 7e0:	0f0e0000 	svceq	0x000e0000
 7e4:	490b0b00 	stmdbmi	fp, {r8, r9, fp}
 7e8:	0f000013 	svceq	0x00000013
 7ec:	0b0b0024 	bleq	2c0884 <__bss_end+0x2b6af4>
 7f0:	08030b3e 	stmdaeq	r3, {r1, r2, r3, r4, r5, r8, r9, fp}
 7f4:	2e100000 	cdpcs	0, 1, cr0, cr0, cr0, {0}
 7f8:	03193f01 	tsteq	r9, #1, 30
 7fc:	3b0b3a0e 	blcc	2cf03c <__bss_end+0x2c52ac>
 800:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 804:	1201110e 	andne	r1, r1, #-2147483645	; 0x80000003
 808:	97184006 	ldrls	r4, [r8, -r6]
 80c:	13011942 	movwne	r1, #6466	; 0x1942
 810:	34110000 	ldrcc	r0, [r1], #-0
 814:	3a0e0300 	bcc	38141c <__bss_end+0x37768c>
 818:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 81c:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 820:	12000018 	andne	r0, r0, #24
 824:	0111010b 	tsteq	r1, fp, lsl #2
 828:	00000612 	andeq	r0, r0, r2, lsl r6
 82c:	00002613 	andeq	r2, r0, r3, lsl r6
 830:	000f1400 	andeq	r1, pc, r0, lsl #8
 834:	00000b0b 	andeq	r0, r0, fp, lsl #22
 838:	3f012e15 	svccc	0x00012e15
 83c:	3a0e0319 	bcc	3814a8 <__bss_end+0x377718>
 840:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 844:	490e6e0b 	stmdbmi	lr, {r0, r1, r3, r9, sl, fp, sp, lr}
 848:	12011113 	andne	r1, r1, #-1073741820	; 0xc0000004
 84c:	97184006 	ldrls	r4, [r8, -r6]
 850:	13011942 	movwne	r1, #6466	; 0x1942
 854:	0b160000 	bleq	58085c <__bss_end+0x576acc>
 858:	12011101 	andne	r1, r1, #1073741824	; 0x40000000
 85c:	00130106 	andseq	r0, r3, r6, lsl #2
 860:	012e1700 			; <UNDEFINED> instruction: 0x012e1700
 864:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 868:	0b3b0b3a 	bleq	ec3558 <__bss_end+0xeb97c8>
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
  84:	0ff60002 	svceq	0x00f60002
  88:	00040000 	andeq	r0, r4, r0
  8c:	00000000 	andeq	r0, r0, r0
  90:	00008ca0 	andeq	r8, r0, r0, lsr #25
  94:	0000045c 	andeq	r0, r0, ip, asr r4
	...
  a0:	0000001c 	andeq	r0, r0, ip, lsl r0
  a4:	1b190002 	blne	6400b4 <__bss_end+0x636324>
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
      10:	6b736544 	blvs	1cd9528 <__bss_end+0x1ccf798>
      14:	2f706f74 	svccs	0x00706f74
      18:	2f564146 	svccs	0x00564146
      1c:	6176614e 	cmnvs	r6, lr, asr #2
      20:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
      24:	4f2f6963 	svcmi	0x002f6963
      28:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
      2c:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
      30:	6b6c6172 	blvs	1b18600 <__bss_end+0x1b0e870>
      34:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
      38:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
      3c:	756f732f 	strbvc	r7, [pc, #-815]!	; fffffd15 <__bss_end+0xffff5f85>
      40:	73656372 	cmnvc	r5, #-939524095	; 0xc8000001
      44:	6573752f 	ldrbvs	r7, [r3, #-1327]!	; 0xfffffad1
      48:	61707372 	cmnvs	r0, r2, ror r3
      4c:	632f6563 			; <UNDEFINED> instruction: 0x632f6563
      50:	2e307472 	mrccs	4, 1, r7, cr0, cr2, {3}
      54:	552f0073 	strpl	r0, [pc, #-115]!	; ffffffe9 <__bss_end+0xffff6259>
      58:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
      5c:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
      60:	6a726574 	bvs	1c99638 <__bss_end+0x1c8f8a8>
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
      98:	752f7365 	strvc	r7, [pc, #-869]!	; fffffd3b <__bss_end+0xffff5fab>
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
     12c:	6a363731 	bvs	d8ddf8 <__bss_end+0xd84068>
     130:	732d667a 			; <UNDEFINED> instruction: 0x732d667a
     134:	616d2d20 	cmnvs	sp, r0, lsr #26
     138:	2d206d72 	stccs	13, cr6, [r0, #-456]!	; 0xfffffe38
     13c:	6372616d 	cmnvs	r2, #1073741851	; 0x4000001b
     140:	72613d68 	rsbvc	r3, r1, #104, 26	; 0x1a00
     144:	7a36766d 	bvc	d9db00 <__bss_end+0xd93d70>
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
     184:	6a757a61 	bvs	1d5eb10 <__bss_end+0x1d54d80>
     188:	2f696369 	svccs	0x00696369
     18c:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
     190:	73656d65 	cmnvc	r5, #6464	; 0x1940
     194:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
     198:	6b2d616b 	blvs	b5874c <__bss_end+0xb4e9bc>
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
     1e4:	2b2b4320 	blcs	ad0e6c <__bss_end+0xac70dc>
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
     260:	2b6b7a36 	blcs	1adeb40 <__bss_end+0x1ad4db0>
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
     294:	755f6962 	ldrbvc	r6, [pc, #-2402]	; fffff93a <__bss_end+0xffff5baa>
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
     324:	6b736544 	blvs	1cd983c <__bss_end+0x1ccfaac>
     328:	2f706f74 	svccs	0x00706f74
     32c:	2f564146 	svccs	0x00564146
     330:	6176614e 	cmnvs	r6, lr, asr #2
     334:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
     338:	4f2f6963 	svcmi	0x002f6963
     33c:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
     340:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
     344:	6b6c6172 	blvs	1b18914 <__bss_end+0x1b0eb84>
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
     530:	555f656e 	ldrbpl	r6, [pc, #-1390]	; ffffffca <__bss_end+0xffff623a>
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
     580:	6a685045 	bvs	1a1469c <__bss_end+0x1a0a90c>
     584:	5a5f0062 	bpl	17c0714 <__bss_end+0x17b6984>
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
     770:	4b50676f 	blmi	141a534 <__bss_end+0x14107a4>
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
     79c:	6d00656c 	cfstr32vs	mvfx6, [r0, #-432]	; 0xfffffe50
     7a0:	6f725f79 	svcvs	0x00725f79
     7a4:	5f00656c 	svcpl	0x0000656c
     7a8:	36314e5a 			; <UNDEFINED> instruction: 0x36314e5a
     7ac:	6f725043 	svcvs	0x00725043
     7b0:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     7b4:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     7b8:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     7bc:	6f4e3431 	svcvs	0x004e3431
     7c0:	79666974 	stmdbvc	r6!, {r2, r4, r5, r6, r8, fp, sp, lr}^
     7c4:	6f72505f 	svcvs	0x0072505f
     7c8:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     7cc:	32315045 	eorscc	r5, r1, #69	; 0x45
     7d0:	73615454 	cmnvc	r1, #84, 8	; 0x54000000
     7d4:	74535f6b 	ldrbvc	r5, [r3], #-3947	; 0xfffff095
     7d8:	74637572 	strbtvc	r7, [r3], #-1394	; 0xfffffa8e
     7dc:	74654700 	strbtvc	r4, [r5], #-1792	; 0xfffff900
     7e0:	6863535f 	stmdavs	r3!, {r0, r1, r2, r3, r4, r6, r8, r9, ip, lr}^
     7e4:	495f6465 	ldmdbmi	pc, {r0, r2, r5, r6, sl, sp, lr}^	; <UNPREDICTABLE>
     7e8:	006f666e 	rsbeq	r6, pc, lr, ror #12
     7ec:	76677261 	strbtvc	r7, [r7], -r1, ror #4
     7f0:	434f4900 	movtmi	r4, #63744	; 0xf900
     7f4:	5f006c74 	svcpl	0x00006c74
     7f8:	6f6c335a 	svcvs	0x006c335a
     7fc:	73006a67 	movwvc	r6, #2663	; 0xa67
     800:	6576616c 	ldrbvs	r6, [r6, #-364]!	; 0xfffffe94
     804:	61655200 	cmnvs	r5, r0, lsl #4
     808:	65540064 	ldrbvs	r0, [r4, #-100]	; 0xffffff9c
     80c:	6e696d72 	mcrvs	13, 3, r6, cr9, cr2, {3}
     810:	00657461 	rsbeq	r7, r5, r1, ror #8
     814:	5f77656e 	svcpl	0x0077656e
     818:	66667562 	strbtvs	r7, [r6], -r2, ror #10
     81c:	73614d00 	cmnvc	r1, #0, 26
     820:	00726574 	rsbseq	r6, r2, r4, ror r5
     824:	69746f4e 	ldmdbvs	r4!, {r1, r2, r3, r6, r8, r9, sl, fp, sp, lr}^
     828:	505f7966 	subspl	r7, pc, r6, ror #18
     82c:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     830:	5f007373 	svcpl	0x00007373
     834:	36314e5a 			; <UNDEFINED> instruction: 0x36314e5a
     838:	6f725043 	svcvs	0x00725043
     83c:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     840:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     844:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     848:	76453443 	strbvc	r3, [r5], -r3, asr #8
     84c:	65727000 	ldrbvs	r7, [r2, #-0]!
     850:	736d5f70 	cmnvc	sp, #112, 30	; 0x1c0
     854:	41540067 	cmpmi	r4, r7, rrx
     858:	54454752 	strbpl	r4, [r5], #-1874	; 0xfffff8ae
     85c:	4444415f 	strbmi	r4, [r4], #-351	; 0xfffffea1
     860:	53534552 	cmppl	r3, #343932928	; 0x14800000
     864:	6e617200 	cdpvs	2, 6, cr7, cr1, cr0, {0}
     868:	5f6d6f64 	svcpl	0x006d6f64
     86c:	756c6176 	strbvc	r6, [ip, #-374]!	; 0xfffffe8a
     870:	6c5f7365 	mrrcvs	3, 6, r7, pc, cr5	; <UNPREDICTABLE>
     874:	75006e65 	strvc	r6, [r0, #-3685]	; 0xfffff19b
     878:	38746e69 	ldmdacc	r4!, {r0, r3, r5, r6, r9, sl, fp, sp, lr}^
     87c:	4e00745f 	cfmvsrmi	mvf0, r7
     880:	6669746f 	strbtvs	r7, [r9], -pc, ror #8
     884:	614d0079 	hvcvs	53257	; 0xd009
     888:	74615078 	strbtvc	r5, [r1], #-120	; 0xffffff88
     88c:	6e654c68 	cdpvs	12, 6, cr4, cr5, cr8, {3}
     890:	00687467 	rsbeq	r7, r8, r7, ror #8
     894:	4678614d 	ldrbtmi	r6, [r8], -sp, asr #2
     898:	69724453 	ldmdbvs	r2!, {r0, r1, r4, r6, sl, lr}^
     89c:	4e726576 	mrcmi	5, 3, r6, cr2, cr6, {3}
     8a0:	4c656d61 	stclmi	13, cr6, [r5], #-388	; 0xfffffe7c
     8a4:	74676e65 	strbtvc	r6, [r7], #-3685	; 0xfffff19b
     8a8:	5a5f0068 	bpl	17c0a50 <__bss_end+0x17b6cc0>
     8ac:	4336314e 	teqmi	r6, #-2147483629	; 0x80000013
     8b0:	636f7250 	cmnvs	pc, #80, 4
     8b4:	5f737365 	svcpl	0x00737365
     8b8:	616e614d 	cmnvs	lr, sp, asr #2
     8bc:	31726567 	cmncc	r2, r7, ror #10
     8c0:	68635331 	stmdavs	r3!, {r0, r4, r5, r8, r9, ip, lr}^
     8c4:	6c756465 	cfldrdvs	mvd6, [r5], #-404	; 0xfffffe6c
     8c8:	52525f65 	subspl	r5, r2, #404	; 0x194
     8cc:	4e007645 	cfmadd32mi	mvax2, mvfx7, mvfx0, mvfx5
     8d0:	5f746547 	svcpl	0x00746547
     8d4:	65686353 	strbvs	r6, [r8, #-851]!	; 0xfffffcad
     8d8:	6e495f64 	cdpvs	15, 4, cr5, cr9, cr4, {3}
     8dc:	545f6f66 	ldrbpl	r6, [pc], #-3942	; 8e4 <shift+0x8e4>
     8e0:	00657079 	rsbeq	r7, r5, r9, ror r0
     8e4:	4f495047 	svcmi	0x00495047
     8e8:	6e69505f 	mcrvs	0, 3, r5, cr9, cr15, {2}
     8ec:	756f435f 	strbvc	r4, [pc, #-863]!	; 595 <shift+0x595>
     8f0:	6200746e 	andvs	r7, r0, #1845493760	; 0x6e000000
     8f4:	006c6f6f 	rsbeq	r6, ip, pc, ror #30
     8f8:	31315a5f 	teqcc	r1, pc, asr sl
     8fc:	69636564 	stmdbvs	r3!, {r2, r5, r6, r8, sl, sp, lr}^
     900:	725f6564 	subsvc	r6, pc, #100, 10	; 0x19000000
     904:	39656c6f 	stmdbcc	r5!, {r0, r1, r2, r3, r5, r6, sl, fp, sp, lr}^
     908:	43324943 	teqmi	r2, #1097728	; 0x10c000
     90c:	646f4d5f 	strbtvs	r4, [pc], #-3423	; 914 <shift+0x914>
     910:	00635065 	rsbeq	r5, r3, r5, rrx
     914:	314e5a5f 	cmpcc	lr, pc, asr sl
     918:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     91c:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     920:	614d5f73 	hvcvs	54771	; 0xd5f3
     924:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     928:	47383172 			; <UNDEFINED> instruction: 0x47383172
     92c:	535f7465 	cmppl	pc, #1694498816	; 0x65000000
     930:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     934:	72656c75 	rsbvc	r6, r5, #29952	; 0x7500
     938:	666e495f 			; <UNDEFINED> instruction: 0x666e495f
     93c:	3032456f 	eorscc	r4, r2, pc, ror #10
     940:	7465474e 	strbtvc	r4, [r5], #-1870	; 0xfffff8b2
     944:	6863535f 	stmdavs	r3!, {r0, r1, r2, r3, r4, r6, r8, r9, ip, lr}^
     948:	495f6465 	ldmdbmi	pc, {r0, r2, r5, r6, sl, sp, lr}^	; <UNPREDICTABLE>
     94c:	5f6f666e 	svcpl	0x006f666e
     950:	65707954 	ldrbvs	r7, [r0, #-2388]!	; 0xfffff6ac
     954:	54007650 	strpl	r7, [r0], #-1616	; 0xfffff9b0
     958:	5f474e52 	svcpl	0x00474e52
     95c:	65736142 	ldrbvs	r6, [r3, #-322]!	; 0xfffffebe
     960:	616c5300 	cmnvs	ip, r0, lsl #6
     964:	44006576 	strmi	r6, [r0], #-1398	; 0xfffffa8a
     968:	75616665 	strbvc	r6, [r1, #-1637]!	; 0xfffff99b
     96c:	435f746c 	cmpmi	pc, #108, 8	; 0x6c000000
     970:	6b636f6c 	blvs	18dc728 <__bss_end+0x18d2998>
     974:	7461525f 	strbtvc	r5, [r1], #-607	; 0xfffffda1
     978:	506d0065 	rsbpl	r0, sp, r5, rrx
     97c:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     980:	4c5f7373 	mrrcmi	3, 7, r7, pc, cr3	; <UNPREDICTABLE>
     984:	5f747369 	svcpl	0x00747369
     988:	64616548 	strbtvs	r6, [r1], #-1352	; 0xfffffab8
     98c:	63536d00 	cmpvs	r3, #0, 26
     990:	75646568 	strbvc	r6, [r4, #-1384]!	; 0xfffffa98
     994:	465f656c 	ldrbmi	r6, [pc], -ip, ror #10
     998:	5f00636e 	svcpl	0x0000636e
     99c:	36314e5a 			; <UNDEFINED> instruction: 0x36314e5a
     9a0:	6f725043 	svcvs	0x00725043
     9a4:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     9a8:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     9ac:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     9b0:	6c423132 	stfvse	f3, [r2], {50}	; 0x32
     9b4:	5f6b636f 	svcpl	0x006b636f
     9b8:	72727543 	rsbsvc	r7, r2, #281018368	; 0x10c00000
     9bc:	5f746e65 	svcpl	0x00746e65
     9c0:	636f7250 	cmnvs	pc, #80, 4
     9c4:	45737365 	ldrbmi	r7, [r3, #-869]!	; 0xfffffc9b
     9c8:	6f4c0076 	svcvs	0x004c0076
     9cc:	555f6b63 	ldrbpl	r6, [pc, #-2915]	; fffffe71 <__bss_end+0xffff60e1>
     9d0:	636f6c6e 	cmnvs	pc, #28160	; 0x6e00
     9d4:	0064656b 	rsbeq	r6, r4, fp, ror #10
     9d8:	73614c6d 	cmnvc	r1, #27904	; 0x6d00
     9dc:	49505f74 	ldmdbmi	r0, {r2, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     9e0:	67610044 	strbvs	r0, [r1, -r4, asr #32]!
     9e4:	64656572 	strbtvs	r6, [r5], #-1394	; 0xfffffa8e
     9e8:	6c6f725f 	sfmvs	f7, 2, [pc], #-380	; 874 <shift+0x874>
     9ec:	77530065 	ldrbvc	r0, [r3, -r5, rrx]
     9f0:	68637469 	stmdavs	r3!, {r0, r3, r5, r6, sl, ip, sp, lr}^
     9f4:	006f545f 	rsbeq	r5, pc, pc, asr r4	; <UNPREDICTABLE>
     9f8:	736f6c43 	cmnvc	pc, #17152	; 0x4300
     9fc:	5a5f0065 	bpl	17c0b98 <__bss_end+0x17b6e08>
     a00:	4336314e 	teqmi	r6, #-2147483629	; 0x80000013
     a04:	636f7250 	cmnvs	pc, #80, 4
     a08:	5f737365 	svcpl	0x00737365
     a0c:	616e614d 	cmnvs	lr, sp, asr #2
     a10:	31726567 	cmncc	r2, r7, ror #10
     a14:	68635332 	stmdavs	r3!, {r1, r4, r5, r8, r9, ip, lr}^
     a18:	6c756465 	cfldrdvs	mvd6, [r5], #-404	; 0xfffffe6c
     a1c:	44455f65 	strbmi	r5, [r5], #-3941	; 0xfffff09b
     a20:	00764546 	rsbseq	r4, r6, r6, asr #10
     a24:	30435342 	subcc	r5, r3, r2, asr #6
     a28:	7361425f 	cmnvc	r1, #-268435451	; 0xf0000005
     a2c:	6c730065 	ldclvs	0, cr0, [r3], #-404	; 0xfffffe6c
     a30:	5f657661 	svcpl	0x00657661
     a34:	6b736174 	blvs	1cd900c <__bss_end+0x1ccf27c>
     a38:	646e5500 	strbtvs	r5, [lr], #-1280	; 0xfffffb00
     a3c:	6e696665 	cdpvs	6, 6, cr6, cr9, cr5, {3}
     a40:	61006465 	tstvs	r0, r5, ror #8
     a44:	00636772 	rsbeq	r6, r3, r2, ror r7
     a48:	31315a5f 	teqcc	r1, pc, asr sl
     a4c:	7473616d 	ldrbtvc	r6, [r3], #-365	; 0xfffffe93
     a50:	745f7265 	ldrbvc	r7, [pc], #-613	; a58 <shift+0xa58>
     a54:	766b7361 	strbtvc	r7, [fp], -r1, ror #6
     a58:	746f6e00 	strbtvc	r6, [pc], #-3584	; a60 <shift+0xa60>
     a5c:	65696669 	strbvs	r6, [r9, #-1641]!	; 0xfffff997
     a60:	65645f64 	strbvs	r5, [r4, #-3940]!	; 0xfffff09c
     a64:	696c6461 	stmdbvs	ip!, {r0, r5, r6, sl, sp, lr}^
     a68:	7200656e 	andvc	r6, r0, #461373440	; 0x1b800000
     a6c:	69656365 	stmdbvs	r5!, {r0, r2, r5, r6, r8, r9, sp, lr}^
     a70:	5f646576 	svcpl	0x00646576
     a74:	756c6176 	strbvc	r6, [ip, #-374]!	; 0xfffffe8a
     a78:	6c5f7365 	mrrcvs	3, 6, r7, pc, cr5	; <UNPREDICTABLE>
     a7c:	6c006e65 	stcvs	14, cr6, [r0], {101}	; 0x65
     a80:	6d5f676f 	ldclvs	7, cr6, [pc, #-444]	; 8cc <shift+0x8cc>
     a84:	76006773 			; <UNDEFINED> instruction: 0x76006773
     a88:	65756c61 	ldrbvs	r6, [r5, #-3169]!	; 0xfffff39f
     a8c:	6174735f 	cmnvs	r4, pc, asr r3
     a90:	5f006574 	svcpl	0x00006574
     a94:	36314e5a 			; <UNDEFINED> instruction: 0x36314e5a
     a98:	6f725043 	svcvs	0x00725043
     a9c:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     aa0:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     aa4:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     aa8:	6f4e3431 	svcvs	0x004e3431
     aac:	79666974 	stmdbvc	r6!, {r2, r4, r5, r6, r8, fp, sp, lr}^
     ab0:	6f72505f 	svcvs	0x0072505f
     ab4:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     ab8:	4e006a45 	vmlsmi.f32	s12, s0, s10
     abc:	6c69466f 	stclvs	6, cr4, [r9], #-444	; 0xfffffe44
     ac0:	73797365 	cmnvc	r9, #-1811939327	; 0x94000001
     ac4:	446d6574 	strbtmi	r6, [sp], #-1396	; 0xfffffa8c
     ac8:	65766972 	ldrbvs	r6, [r6, #-2418]!	; 0xfffff68e
     acc:	65440072 	strbvs	r0, [r4, #-114]	; 0xffffff8e
     ad0:	696c6461 	stmdbvs	ip!, {r0, r5, r6, sl, sp, lr}^
     ad4:	4400656e 	strmi	r6, [r0], #-1390	; 0xfffffa92
     ad8:	62617369 	rsbvs	r7, r1, #-1543503871	; 0xa4000001
     adc:	455f656c 	ldrbmi	r6, [pc, #-1388]	; 578 <shift+0x578>
     ae0:	746e6576 	strbtvc	r6, [lr], #-1398	; 0xfffffa8a
     ae4:	7465445f 	strbtvc	r4, [r5], #-1119	; 0xfffffba1
     ae8:	69746365 	ldmdbvs	r4!, {r0, r2, r5, r6, r8, r9, sp, lr}^
     aec:	73006e6f 	movwvc	r6, #3695	; 0xe6f
     af0:	74726f68 	ldrbtvc	r6, [r2], #-3944	; 0xfffff098
     af4:	746e6920 	strbtvc	r6, [lr], #-2336	; 0xfffff6e0
     af8:	78614d00 	stmdavc	r1!, {r8, sl, fp, lr}^
     afc:	656c6946 	strbvs	r6, [ip, #-2374]!	; 0xfffff6ba
     b00:	656d616e 	strbvs	r6, [sp, #-366]!	; 0xfffffe92
     b04:	676e654c 	strbvs	r6, [lr, -ip, asr #10]!
     b08:	43006874 	movwmi	r6, #2164	; 0x874
     b0c:	636f7250 	cmnvs	pc, #80, 4
     b10:	5f737365 	svcpl	0x00737365
     b14:	616e614d 	cmnvs	lr, sp, asr #2
     b18:	00726567 	rsbseq	r6, r2, r7, ror #10
     b1c:	7478656e 	ldrbtvc	r6, [r8], #-1390	; 0xfffffa92
     b20:	6572705f 	ldrbvs	r7, [r2, #-95]!	; 0xffffffa1
     b24:	74636964 	strbtvc	r6, [r3], #-2404	; 0xfffff69c
     b28:	62747400 	rsbsvs	r7, r4, #0, 8
     b2c:	73003072 	movwvc	r3, #114	; 0x72
     b30:	725f7465 	subsvc	r7, pc, #1694498816	; 0x65000000
     b34:	73656c6f 	cmnvc	r5, #28416	; 0x6f00
     b38:	57534e00 	ldrbpl	r4, [r3, -r0, lsl #28]
     b3c:	69465f49 	stmdbvs	r6, {r0, r3, r6, r8, r9, sl, fp, ip, lr}^
     b40:	7973656c 	ldmdbvc	r3!, {r2, r3, r5, r6, r8, sl, sp, lr}^
     b44:	6d657473 	cfstrdvs	mvd7, [r5, #-460]!	; 0xfffffe34
     b48:	7265535f 	rsbvc	r5, r5, #2080374785	; 0x7c000001
     b4c:	65636976 	strbvs	r6, [r3, #-2422]!	; 0xfffff68a
     b50:	73552f00 	cmpvc	r5, #0, 30
     b54:	2f737265 	svccs	0x00737265
     b58:	746e6977 	strbtvc	r6, [lr], #-2423	; 0xfffff689
     b5c:	696a7265 	stmdbvs	sl!, {r0, r2, r5, r6, r9, ip, sp, lr}^
     b60:	7365442f 	cmnvc	r5, #788529152	; 0x2f000000
     b64:	706f746b 	rsbvc	r7, pc, fp, ror #8
     b68:	5641462f 	strbpl	r4, [r1], -pc, lsr #12
     b6c:	76614e2f 	strbtvc	r4, [r1], -pc, lsr #28
     b70:	6a757a61 	bvs	1d5f4fc <__bss_end+0x1d5576c>
     b74:	2f696369 	svccs	0x00696369
     b78:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
     b7c:	73656d65 	cmnvc	r5, #6464	; 0x1940
     b80:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
     b84:	6b2d616b 	blvs	b59138 <__bss_end+0xb4f3a8>
     b88:	6f2d7669 	svcvs	0x002d7669
     b8c:	6f732f73 	svcvs	0x00732f73
     b90:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
     b94:	73752f73 	cmnvc	r5, #460	; 0x1cc
     b98:	70737265 	rsbsvc	r7, r3, r5, ror #4
     b9c:	2f656361 	svccs	0x00656361
     ba0:	76616c73 			; <UNDEFINED> instruction: 0x76616c73
     ba4:	61745f65 	cmnvs	r4, r5, ror #30
     ba8:	6d2f6b73 	fstmdbxvs	pc!, {d6-d62}	;@ Deprecated
     bac:	2e6e6961 	vnmulcs.f16	s13, s28, s3	; <UNPREDICTABLE>
     bb0:	00707063 	rsbseq	r7, r0, r3, rrx
     bb4:	4957534e 	ldmdbmi	r7, {r1, r2, r3, r6, r8, r9, ip, lr}^
     bb8:	6f72505f 	svcvs	0x0072505f
     bbc:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     bc0:	7265535f 	rsbvc	r5, r5, #2080374785	; 0x7c000001
     bc4:	65636976 	strbvs	r6, [r3, #-2422]!	; 0xfffff68a
     bc8:	65706f00 	ldrbvs	r6, [r0, #-3840]!	; 0xfffff100
     bcc:	5f64656e 	svcpl	0x0064656e
     bd0:	656c6966 	strbvs	r6, [ip, #-2406]!	; 0xfffff69a
     bd4:	69590073 	ldmdbvs	r9, {r0, r1, r4, r5, r6}^
     bd8:	00646c65 	rsbeq	r6, r4, r5, ror #24
     bdc:	69636564 	stmdbvs	r3!, {r2, r5, r6, r8, sl, sp, lr}^
     be0:	725f6564 	subsvc	r6, pc, #100, 10	; 0x19000000
     be4:	00656c6f 	rsbeq	r6, r5, pc, ror #24
     be8:	65646e49 	strbvs	r6, [r4, #-3657]!	; 0xfffff1b7
     bec:	696e6966 	stmdbvs	lr!, {r1, r2, r5, r6, r8, fp, sp, lr}^
     bf0:	47006574 	smlsdxmi	r0, r4, r5, r6
     bf4:	505f7465 	subspl	r7, pc, r5, ror #8
     bf8:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     bfc:	425f7373 	subsmi	r7, pc, #-872415231	; 0xcc000001
     c00:	49505f79 	ldmdbmi	r0, {r0, r3, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     c04:	6e450044 	cdpvs	0, 4, cr0, cr5, cr4, {2}
     c08:	656c6261 	strbvs	r6, [ip, #-609]!	; 0xfffffd9f
     c0c:	6576455f 	ldrbvs	r4, [r6, #-1375]!	; 0xfffffaa1
     c10:	445f746e 	ldrbmi	r7, [pc], #-1134	; c18 <shift+0xc18>
     c14:	63657465 	cmnvs	r5, #1694498816	; 0x65000000
     c18:	6e6f6974 			; <UNDEFINED> instruction: 0x6e6f6974
     c1c:	72655000 	rsbvc	r5, r5, #0
     c20:	65687069 	strbvs	r7, [r8, #-105]!	; 0xffffff97
     c24:	5f6c6172 	svcpl	0x006c6172
     c28:	65736142 	ldrbvs	r6, [r3, #-322]!	; 0xfffffebe
     c2c:	73616d00 	cmnvc	r1, #0, 26
     c30:	5f726574 	svcpl	0x00726574
     c34:	6b736174 	blvs	1cd920c <__bss_end+0x1ccf47c>
     c38:	53454400 	movtpl	r4, #21504	; 0x5400
     c3c:	44455249 	strbmi	r5, [r5], #-585	; 0xfffffdb7
     c40:	4c4f525f 	sfmmi	f5, 2, [pc], {95}	; 0x5f
     c44:	6f6c0045 	svcvs	0x006c0045
     c48:	7520676e 	strvc	r6, [r0, #-1902]!	; 0xfffff892
     c4c:	6769736e 	strbvs	r7, [r9, -lr, ror #6]!
     c50:	2064656e 	rsbcs	r6, r4, lr, ror #10
     c54:	00746e69 	rsbseq	r6, r4, r9, ror #28
     c58:	72646461 	rsbvc	r6, r4, #1627389952	; 0x61000000
     c5c:	00737365 	rsbseq	r7, r3, r5, ror #6
     c60:	61766e49 	cmnvs	r6, r9, asr #28
     c64:	5f64696c 	svcpl	0x0064696c
     c68:	006e6950 	rsbeq	r6, lr, r0, asr r9
     c6c:	6b636f4c 	blvs	18dc9a4 <__bss_end+0x18d2c14>
     c70:	636f4c5f 	cmnvs	pc, #24320	; 0x5f00
     c74:	0064656b 	rsbeq	r6, r4, fp, ror #10
     c78:	314e5a5f 	cmpcc	lr, pc, asr sl
     c7c:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     c80:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     c84:	614d5f73 	hvcvs	54771	; 0xd5f3
     c88:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     c8c:	48383172 	ldmdami	r8!, {r1, r4, r5, r6, r8, ip, sp}
     c90:	6c646e61 	stclvs	14, cr6, [r4], #-388	; 0xfffffe7c
     c94:	72505f65 	subsvc	r5, r0, #404	; 0x194
     c98:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     c9c:	57535f73 			; <UNDEFINED> instruction: 0x57535f73
     ca0:	30324549 	eorscc	r4, r2, r9, asr #10
     ca4:	4957534e 	ldmdbmi	r7, {r1, r2, r3, r6, r8, r9, ip, lr}^
     ca8:	6f72505f 	svcvs	0x0072505f
     cac:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     cb0:	7265535f 	rsbvc	r5, r5, #2080374785	; 0x7c000001
     cb4:	65636976 	strbvs	r6, [r3, #-2422]!	; 0xfffff68a
     cb8:	526a6a6a 	rsbpl	r6, sl, #434176	; 0x6a000
     cbc:	53543131 	cmppl	r4, #1073741836	; 0x4000000c
     cc0:	525f4957 	subspl	r4, pc, #1425408	; 0x15c000
     cc4:	6c757365 	ldclvs	3, cr7, [r5], #-404	; 0xfffffe6c
     cc8:	5a5f0074 	bpl	17c0ea0 <__bss_end+0x17b7110>
     ccc:	65723231 	ldrbvs	r3, [r2, #-561]!	; 0xfffffdcf
     cd0:	76696563 	strbtvc	r6, [r9], -r3, ror #10
     cd4:	61645f65 	cmnvs	r4, r5, ror #30
     cd8:	00766174 	rsbseq	r6, r6, r4, ror r1
     cdc:	65686373 	strbvs	r6, [r8, #-883]!	; 0xfffffc8d
     ce0:	6f635f64 	svcvs	0x00635f64
     ce4:	65746e75 	ldrbvs	r6, [r4, #-3701]!	; 0xfffff18b
     ce8:	50550072 	subspl	r0, r5, r2, ror r0
     cec:	5f524550 	svcpl	0x00524550
     cf0:	4e554f42 	cdpmi	15, 5, cr4, cr5, cr2, {2}
     cf4:	65470044 	strbvs	r0, [r7, #-68]	; 0xffffffbc
     cf8:	61505f74 	cmpvs	r0, r4, ror pc
     cfc:	736d6172 	cmnvc	sp, #-2147483620	; 0x8000001c
     d00:	736e7500 	cmnvc	lr, #0, 10
     d04:	656e6769 	strbvs	r6, [lr, #-1897]!	; 0xfffff897
     d08:	68632064 	stmdavs	r3!, {r2, r5, r6, sp}^
     d0c:	5f007261 	svcpl	0x00007261
     d10:	7270385a 	rsbsvc	r3, r0, #5898240	; 0x5a0000
     d14:	6d5f7065 	ldclvs	0, cr7, [pc, #-404]	; b88 <shift+0xb88>
     d18:	63506773 	cmpvs	r0, #30146560	; 0x1cc0000
     d1c:	00634b50 	rsbeq	r4, r3, r0, asr fp
     d20:	5f433249 	svcpl	0x00433249
     d24:	56414c53 			; <UNDEFINED> instruction: 0x56414c53
     d28:	61425f45 	cmpvs	r2, r5, asr #30
     d2c:	49006573 	stmdbmi	r0, {r0, r1, r4, r5, r6, r8, sl, sp, lr}
     d30:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
     d34:	74707572 	ldrbtvc	r7, [r0], #-1394	; 0xfffffa8e
     d38:	656c6261 	strbvs	r6, [ip, #-609]!	; 0xfffffd9f
     d3c:	656c535f 	strbvs	r5, [ip, #-863]!	; 0xfffffca1
     d40:	53007065 	movwpl	r7, #101	; 0x65
     d44:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     d48:	5f656c75 	svcpl	0x00656c75
     d4c:	41005252 	tstmi	r0, r2, asr r2
     d50:	425f5855 	subsmi	r5, pc, #5570560	; 0x550000
     d54:	00657361 	rsbeq	r7, r5, r1, ror #6
     d58:	32435342 	subcc	r5, r3, #134217729	; 0x8000001
     d5c:	7361425f 	cmnvc	r1, #-268435451	; 0xf0000005
     d60:	5a5f0065 	bpl	17c0efc <__bss_end+0x17b716c>
     d64:	74657339 	strbtvc	r7, [r5], #-825	; 0xfffffcc7
     d68:	6c6f725f 	sfmvs	f7, 2, [pc], #-380	; bf4 <shift+0xbf4>
     d6c:	43397365 	teqmi	r9, #-1811939327	; 0x94000001
     d70:	5f433249 	svcpl	0x00433249
     d74:	65646f4d 	strbvs	r6, [r4, #-3917]!	; 0xfffff0b3
     d78:	6e616800 	cdpvs	8, 6, cr6, cr1, cr0, {0}
     d7c:	5f656c64 	svcpl	0x00656c64
     d80:	61746164 	cmnvs	r4, r4, ror #2
     d84:	6e617200 	cdpvs	2, 6, cr7, cr1, cr0, {0}
     d88:	5f6d6f64 	svcpl	0x006d6f64
     d8c:	756c6176 	strbvc	r6, [ip, #-374]!	; 0xfffffe8a
     d90:	57007365 	strpl	r7, [r0, -r5, ror #6]
     d94:	65746972 	ldrbvs	r6, [r4, #-2418]!	; 0xfffff68e
     d98:	6c6e4f5f 	stclvs	15, cr4, [lr], #-380	; 0xfffffe84
     d9c:	63530079 	cmpvs	r3, #121	; 0x79
     da0:	75646568 	strbvc	r6, [r4, #-1384]!	; 0xfffffa98
     da4:	5400656c 	strpl	r6, [r0], #-1388	; 0xfffffa94
     da8:	5f6b6369 	svcpl	0x006b6369
     dac:	6e756f43 	cdpvs	15, 7, cr6, cr5, cr3, {2}
     db0:	5a5f0074 	bpl	17c0f88 <__bss_end+0x17b71f8>
     db4:	4336314e 	teqmi	r6, #-2147483629	; 0x80000013
     db8:	636f7250 	cmnvs	pc, #80, 4
     dbc:	5f737365 	svcpl	0x00737365
     dc0:	616e614d 	cmnvs	lr, sp, asr #2
     dc4:	31726567 	cmncc	r2, r7, ror #10
     dc8:	6d6e5538 	cfstr64vs	mvdx5, [lr, #-224]!	; 0xffffff20
     dcc:	465f7061 	ldrbmi	r7, [pc], -r1, rrx
     dd0:	5f656c69 	svcpl	0x00656c69
     dd4:	72727543 	rsbsvc	r7, r2, #281018368	; 0x10c00000
     dd8:	45746e65 	ldrbmi	r6, [r4, #-3685]!	; 0xfffff19b
     ddc:	3249006a 	subcc	r0, r9, #106	; 0x6a
     de0:	4c535f43 	mrrcmi	15, 4, r5, r3, cr3
     de4:	5f455641 	svcpl	0x00455641
     de8:	66667542 	strbtvs	r7, [r6], -r2, asr #10
     dec:	535f7265 	cmppl	pc, #1342177286	; 0x50000006
     df0:	00657a69 	rsbeq	r7, r5, r9, ror #20
     df4:	646e6148 	strbtvs	r6, [lr], #-328	; 0xfffffeb8
     df8:	465f656c 	ldrbmi	r6, [pc], -ip, ror #10
     dfc:	73656c69 	cmnvc	r5, #26880	; 0x6900
     e00:	65747379 	ldrbvs	r7, [r4, #-889]!	; 0xfffffc87
     e04:	57535f6d 	ldrbpl	r5, [r3, -sp, ror #30]
     e08:	68730049 	ldmdavs	r3!, {r0, r3, r6}^
     e0c:	2074726f 	rsbscs	r7, r4, pc, ror #4
     e10:	69736e75 	ldmdbvs	r3!, {r0, r2, r4, r5, r6, r9, sl, fp, sp, lr}^
     e14:	64656e67 	strbtvs	r6, [r5], #-3687	; 0xfffff199
     e18:	746e6920 	strbtvc	r6, [lr], #-2336	; 0xfffff6e0
     e1c:	65727000 	ldrbvs	r7, [r2, #-0]!
     e20:	61765f76 	cmnvs	r6, r6, ror pc
     e24:	0065756c 	rsbeq	r7, r5, ip, ror #10
     e28:	6e69616d 	powvsez	f6, f1, #5.0
     e2c:	315a5f00 	cmpcc	sl, r0, lsl #30
     e30:	6e657330 	mcrvs	3, 3, r7, cr5, cr0, {1}
     e34:	61765f64 	cmnvs	r6, r4, ror #30
     e38:	6665756c 	strbtvs	r7, [r5], -ip, ror #10
     e3c:	72617400 	rsbvc	r7, r1, #0, 8
     e40:	41746567 	cmnmi	r4, r7, ror #10
     e44:	73657264 	cmnvc	r5, #100, 4	; 0x40000006
     e48:	6e490073 	mcrvs	0, 2, r0, cr9, cr3, {3}
     e4c:	72726574 	rsbsvc	r6, r2, #116, 10	; 0x1d000000
     e50:	5f747075 	svcpl	0x00747075
     e54:	746e6f43 	strbtvc	r6, [lr], #-3907	; 0xfffff0bd
     e58:	6c6c6f72 	stclvs	15, cr6, [ip], #-456	; 0xfffffe38
     e5c:	425f7265 	subsmi	r7, pc, #1342177286	; 0x50000006
     e60:	00657361 	rsbeq	r7, r5, r1, ror #6
     e64:	65636572 	strbvs	r6, [r3, #-1394]!	; 0xfffffa8e
     e68:	64657669 	strbtvs	r7, [r5], #-1641	; 0xfffff997
     e6c:	6c61765f 	stclvs	6, cr7, [r1], #-380	; 0xfffffe84
     e70:	00736575 	rsbseq	r6, r3, r5, ror r5
     e74:	64616552 	strbtvs	r6, [r1], #-1362	; 0xfffffaae
     e78:	6972575f 	ldmdbvs	r2!, {r0, r1, r2, r3, r4, r6, r8, r9, sl, ip, lr}^
     e7c:	41006574 	tstmi	r0, r4, ror r5
     e80:	76697463 	strbtvc	r7, [r9], -r3, ror #8
     e84:	72505f65 	subsvc	r5, r0, #404	; 0x194
     e88:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     e8c:	6f435f73 	svcvs	0x00435f73
     e90:	00746e75 	rsbseq	r6, r4, r5, ror lr
     e94:	314e5a5f 	cmpcc	lr, pc, asr sl
     e98:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     e9c:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     ea0:	614d5f73 	hvcvs	54771	; 0xd5f3
     ea4:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     ea8:	48313272 	ldmdami	r1!, {r1, r4, r5, r6, r9, ip, sp}
     eac:	6c646e61 	stclvs	14, cr6, [r4], #-388	; 0xfffffe7c
     eb0:	69465f65 	stmdbvs	r6, {r0, r2, r5, r6, r8, r9, sl, fp, ip, lr}^
     eb4:	7973656c 	ldmdbvc	r3!, {r2, r3, r5, r6, r8, sl, sp, lr}^
     eb8:	6d657473 	cfstrdvs	mvd7, [r5, #-460]!	; 0xfffffe34
     ebc:	4957535f 	ldmdbmi	r7, {r0, r1, r2, r3, r4, r6, r8, r9, ip, lr}^
     ec0:	4e333245 	cdpmi	2, 3, cr3, cr3, cr5, {2}
     ec4:	5f495753 	svcpl	0x00495753
     ec8:	656c6946 	strbvs	r6, [ip, #-2374]!	; 0xfffff6ba
     ecc:	74737973 	ldrbtvc	r7, [r3], #-2419	; 0xfffff68d
     ed0:	535f6d65 	cmppl	pc, #6464	; 0x1940
     ed4:	69767265 	ldmdbvs	r6!, {r0, r2, r5, r6, r9, ip, sp, lr}^
     ed8:	6a6a6563 	bvs	1a9a46c <__bss_end+0x1a906dc>
     edc:	3131526a 	teqcc	r1, sl, ror #4
     ee0:	49575354 	ldmdbmi	r7, {r2, r4, r6, r8, r9, ip, lr}^
     ee4:	7365525f 	cmnvc	r5, #-268435451	; 0xf0000005
     ee8:	00746c75 	rsbseq	r6, r4, r5, ror ip
     eec:	6573552f 	ldrbvs	r5, [r3, #-1327]!	; 0xfffffad1
     ef0:	772f7372 			; <UNDEFINED> instruction: 0x772f7372
     ef4:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
     ef8:	2f696a72 	svccs	0x00696a72
     efc:	6b736544 	blvs	1cda414 <__bss_end+0x1cd0684>
     f00:	2f706f74 	svccs	0x00706f74
     f04:	2f564146 	svccs	0x00564146
     f08:	6176614e 	cmnvs	r6, lr, asr #2
     f0c:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
     f10:	4f2f6963 	svcmi	0x002f6963
     f14:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
     f18:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
     f1c:	6b6c6172 	blvs	1b194ec <__bss_end+0x1b0f75c>
     f20:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
     f24:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
     f28:	756f732f 	strbvc	r7, [pc, #-815]!	; c01 <shift+0xc01>
     f2c:	73656372 	cmnvc	r5, #-939524095	; 0xc8000001
     f30:	6975622f 	ldmdbvs	r5!, {r0, r1, r2, r3, r5, r9, sp, lr}^
     f34:	6300646c 	movwvs	r6, #1132	; 0x46c
     f38:	65736f6c 	ldrbvs	r6, [r3, #-3948]!	; 0xfffff094
     f3c:	74655300 	strbtvc	r5, [r5], #-768	; 0xfffffd00
     f40:	6c65525f 	sfmvs	f5, 2, [r5], #-380	; 0xfffffe84
     f44:	76697461 	strbtvc	r7, [r9], -r1, ror #8
     f48:	65720065 	ldrbvs	r0, [r2, #-101]!	; 0xffffff9b
     f4c:	6c617674 	stclvs	6, cr7, [r1], #-464	; 0xfffffe30
     f50:	75636e00 	strbvc	r6, [r3, #-3584]!	; 0xfffff200
     f54:	69700072 	ldmdbvs	r0!, {r1, r4, r5, r6}^
     f58:	72006570 	andvc	r6, r0, #112, 10	; 0x1c000000
     f5c:	6d756e64 	ldclvs	14, cr6, [r5, #-400]!	; 0xfffffe70
     f60:	315a5f00 	cmpcc	sl, r0, lsl #30
     f64:	68637331 	stmdavs	r3!, {r0, r4, r5, r8, r9, ip, sp, lr}^
     f68:	795f6465 	ldmdbvc	pc, {r0, r2, r5, r6, sl, sp, lr}^	; <UNPREDICTABLE>
     f6c:	646c6569 	strbtvs	r6, [ip], #-1385	; 0xfffffa97
     f70:	5a5f0076 	bpl	17c1150 <__bss_end+0x17b73c0>
     f74:	65733731 	ldrbvs	r3, [r3, #-1841]!	; 0xfffff8cf
     f78:	61745f74 	cmnvs	r4, r4, ror pc
     f7c:	645f6b73 	ldrbvs	r6, [pc], #-2931	; f84 <shift+0xf84>
     f80:	6c646165 	stfvse	f6, [r4], #-404	; 0xfffffe6c
     f84:	6a656e69 	bvs	195c930 <__bss_end+0x1952ba0>
     f88:	69617700 	stmdbvs	r1!, {r8, r9, sl, ip, sp, lr}^
     f8c:	5a5f0074 	bpl	17c1164 <__bss_end+0x17b73d4>
     f90:	746f6e36 	strbtvc	r6, [pc], #-3638	; f98 <shift+0xf98>
     f94:	6a796669 	bvs	1e5a940 <__bss_end+0x1e50bb0>
     f98:	6146006a 	cmpvs	r6, sl, rrx
     f9c:	65006c69 	strvs	r6, [r0, #-3177]	; 0xfffff397
     fa0:	63746978 	cmnvs	r4, #120, 18	; 0x1e0000
     fa4:	0065646f 	rsbeq	r6, r5, pc, ror #8
     fa8:	65686373 	strbvs	r6, [r8, #-883]!	; 0xfffffc8d
     fac:	69795f64 	ldmdbvs	r9!, {r2, r5, r6, r8, r9, sl, fp, ip, lr}^
     fb0:	00646c65 	rsbeq	r6, r4, r5, ror #24
     fb4:	6b636974 	blvs	18db58c <__bss_end+0x18d17fc>
     fb8:	756f635f 	strbvc	r6, [pc, #-863]!	; c61 <shift+0xc61>
     fbc:	725f746e 	subsvc	r7, pc, #1845493760	; 0x6e000000
     fc0:	69757165 	ldmdbvs	r5!, {r0, r2, r5, r6, r8, ip, sp, lr}^
     fc4:	00646572 	rsbeq	r6, r4, r2, ror r5
     fc8:	34325a5f 	ldrtcc	r5, [r2], #-2655	; 0xfffff5a1
     fcc:	5f746567 	svcpl	0x00746567
     fd0:	69746361 	ldmdbvs	r4!, {r0, r5, r6, r8, r9, sp, lr}^
     fd4:	705f6576 	subsvc	r6, pc, r6, ror r5	; <UNPREDICTABLE>
     fd8:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     fdc:	635f7373 	cmpvs	pc, #-872415231	; 0xcc000001
     fe0:	746e756f 	strbtvc	r7, [lr], #-1391	; 0xfffffa91
     fe4:	69500076 	ldmdbvs	r0, {r1, r2, r4, r5, r6}^
     fe8:	465f6570 			; <UNDEFINED> instruction: 0x465f6570
     fec:	5f656c69 	svcpl	0x00656c69
     ff0:	66657250 			; <UNDEFINED> instruction: 0x66657250
     ff4:	5f007869 	svcpl	0x00007869
     ff8:	6734315a 			; <UNDEFINED> instruction: 0x6734315a
     ffc:	745f7465 	ldrbvc	r7, [pc], #-1125	; 1004 <shift+0x1004>
    1000:	5f6b6369 	svcpl	0x006b6369
    1004:	6e756f63 	cdpvs	15, 7, cr6, cr5, cr3, {3}
    1008:	73007674 	movwvc	r7, #1652	; 0x674
    100c:	7065656c 	rsbvc	r6, r5, ip, ror #10
    1010:	395a5f00 	ldmdbcc	sl, {r8, r9, sl, fp, ip, lr}^
    1014:	6d726574 	cfldr64vs	mvdx6, [r2, #-464]!	; 0xfffffe30
    1018:	74616e69 	strbtvc	r6, [r1], #-3689	; 0xfffff197
    101c:	6f006965 	svcvs	0x00006965
    1020:	61726570 	cmnvs	r2, r0, ror r5
    1024:	6e6f6974 			; <UNDEFINED> instruction: 0x6e6f6974
    1028:	355a5f00 	ldrbcc	r5, [sl, #-3840]	; 0xfffff100
    102c:	736f6c63 	cmnvc	pc, #25344	; 0x6300
    1030:	5f006a65 	svcpl	0x00006a65
    1034:	6567365a 	strbvs	r3, [r7, #-1626]!	; 0xfffff9a6
    1038:	64697074 	strbtvs	r7, [r9], #-116	; 0xffffff8c
    103c:	6e660076 	mcrvs	0, 3, r0, cr6, cr6, {3}
    1040:	00656d61 	rsbeq	r6, r5, r1, ror #26
    1044:	74697277 	strbtvc	r7, [r9], #-631	; 0xfffffd89
    1048:	69740065 	ldmdbvs	r4!, {r0, r2, r5, r6}^
    104c:	00736b63 	rsbseq	r6, r3, r3, ror #22
    1050:	6e65706f 	cdpvs	0, 6, cr7, cr5, cr15, {3}
    1054:	345a5f00 	ldrbcc	r5, [sl], #-3840	; 0xfffff100
    1058:	65706970 	ldrbvs	r6, [r0, #-2416]!	; 0xfffff690
    105c:	6a634b50 	bvs	18d3da4 <__bss_end+0x18ca014>
    1060:	65444e00 	strbvs	r4, [r4, #-3584]	; 0xfffff200
    1064:	696c6461 	stmdbvs	ip!, {r0, r5, r6, sl, sp, lr}^
    1068:	535f656e 	cmppl	pc, #461373440	; 0x1b800000
    106c:	65736275 	ldrbvs	r6, [r3, #-629]!	; 0xfffffd8b
    1070:	63697672 	cmnvs	r9, #119537664	; 0x7200000
    1074:	65670065 	strbvs	r0, [r7, #-101]!	; 0xffffff9b
    1078:	69745f74 	ldmdbvs	r4!, {r2, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
    107c:	635f6b63 	cmpvs	pc, #101376	; 0x18c00
    1080:	746e756f 	strbtvc	r7, [lr], #-1391	; 0xfffffa91
    1084:	72617000 	rsbvc	r7, r1, #0
    1088:	5f006d61 	svcpl	0x00006d61
    108c:	7277355a 	rsbsvc	r3, r7, #377487360	; 0x16800000
    1090:	6a657469 	bvs	195e23c <__bss_end+0x19544ac>
    1094:	6a634b50 	bvs	18d3ddc <__bss_end+0x18ca04c>
    1098:	74656700 	strbtvc	r6, [r5], #-1792	; 0xfffff900
    109c:	7361745f 	cmnvc	r1, #1593835520	; 0x5f000000
    10a0:	69745f6b 	ldmdbvs	r4!, {r0, r1, r3, r5, r6, r8, r9, sl, fp, ip, lr}^
    10a4:	5f736b63 	svcpl	0x00736b63
    10a8:	645f6f74 	ldrbvs	r6, [pc], #-3956	; 10b0 <shift+0x10b0>
    10ac:	6c646165 	stfvse	f6, [r4], #-404	; 0xfffffe6c
    10b0:	00656e69 	rsbeq	r6, r5, r9, ror #28
    10b4:	5f667562 	svcpl	0x00667562
    10b8:	657a6973 	ldrbvs	r6, [sl, #-2419]!	; 0xfffff68d
    10bc:	74657300 	strbtvc	r7, [r5], #-768	; 0xfffffd00
    10c0:	7361745f 	cmnvc	r1, #1593835520	; 0x5f000000
    10c4:	65645f6b 	strbvs	r5, [r4, #-3947]!	; 0xfffff095
    10c8:	696c6461 	stmdbvs	ip!, {r0, r5, r6, sl, sp, lr}^
    10cc:	2f00656e 	svccs	0x0000656e
    10d0:	72657355 	rsbvc	r7, r5, #1409286145	; 0x54000001
    10d4:	69772f73 	ldmdbvs	r7!, {r0, r1, r4, r5, r6, r8, r9, sl, fp, sp}^
    10d8:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
    10dc:	442f696a 	strtmi	r6, [pc], #-2410	; 10e4 <shift+0x10e4>
    10e0:	746b7365 	strbtvc	r7, [fp], #-869	; 0xfffffc9b
    10e4:	462f706f 	strtmi	r7, [pc], -pc, rrx
    10e8:	4e2f5641 	cfmadda32mi	mvax2, mvax5, mvfx15, mvfx1
    10ec:	7a617661 	bvc	185ea78 <__bss_end+0x1854ce8>
    10f0:	63696a75 	cmnvs	r9, #479232	; 0x75000
    10f4:	534f2f69 	movtpl	r2, #65385	; 0xff69
    10f8:	6d65732f 	stclvs	3, cr7, [r5, #-188]!	; 0xffffff44
    10fc:	72747365 	rsbsvc	r7, r4, #-1811939327	; 0x94000001
    1100:	616b6c61 	cmnvs	fp, r1, ror #24
    1104:	76696b2d 	strbtvc	r6, [r9], -sp, lsr #22
    1108:	2f736f2d 	svccs	0x00736f2d
    110c:	72756f73 	rsbsvc	r6, r5, #460	; 0x1cc
    1110:	2f736563 	svccs	0x00736563
    1114:	6c647473 	cfstrdvs	mvd7, [r4], #-460	; 0xfffffe34
    1118:	732f6269 			; <UNDEFINED> instruction: 0x732f6269
    111c:	732f6372 			; <UNDEFINED> instruction: 0x732f6372
    1120:	69666474 	stmdbvs	r6!, {r2, r4, r5, r6, sl, sp, lr}^
    1124:	632e656c 			; <UNDEFINED> instruction: 0x632e656c
    1128:	5f007070 	svcpl	0x00007070
    112c:	6c73355a 	cfldr64vs	mvdx3, [r3], #-360	; 0xfffffe98
    1130:	6a706565 	bvs	1c1a6cc <__bss_end+0x1c1093c>
    1134:	6966006a 	stmdbvs	r6!, {r1, r3, r5, r6}^
    1138:	4700656c 	strmi	r6, [r0, -ip, ror #10]
    113c:	525f7465 	subspl	r7, pc, #1694498816	; 0x65000000
    1140:	69616d65 	stmdbvs	r1!, {r0, r2, r5, r6, r8, sl, fp, sp, lr}^
    1144:	676e696e 	strbvs	r6, [lr, -lr, ror #18]!
    1148:	325a5f00 	subscc	r5, sl, #0, 30
    114c:	74656736 	strbtvc	r6, [r5], #-1846	; 0xfffff8ca
    1150:	7361745f 	cmnvc	r1, #1593835520	; 0x5f000000
    1154:	69745f6b 	ldmdbvs	r4!, {r0, r1, r3, r5, r6, r8, r9, sl, fp, ip, lr}^
    1158:	5f736b63 	svcpl	0x00736b63
    115c:	645f6f74 	ldrbvs	r6, [pc], #-3956	; 1164 <shift+0x1164>
    1160:	6c646165 	stfvse	f6, [r4], #-404	; 0xfffffe6c
    1164:	76656e69 	strbtvc	r6, [r5], -r9, ror #28
    1168:	57534e00 	ldrbpl	r4, [r3, -r0, lsl #28]
    116c:	65525f49 	ldrbvs	r5, [r2, #-3913]	; 0xfffff0b7
    1170:	746c7573 	strbtvc	r7, [ip], #-1395	; 0xfffffa8d
    1174:	646f435f 	strbtvs	r4, [pc], #-863	; 117c <shift+0x117c>
    1178:	72770065 	rsbsvc	r0, r7, #101	; 0x65
    117c:	006d756e 	rsbeq	r7, sp, lr, ror #10
    1180:	77345a5f 			; <UNDEFINED> instruction: 0x77345a5f
    1184:	6a746961 	bvs	1d1b710 <__bss_end+0x1d11980>
    1188:	5f006a6a 	svcpl	0x00006a6a
    118c:	6f69355a 	svcvs	0x0069355a
    1190:	6a6c7463 	bvs	1b1e324 <__bss_end+0x1b14594>
    1194:	494e3631 	stmdbmi	lr, {r0, r4, r5, r9, sl, ip, sp}^
    1198:	6c74434f 	ldclvs	3, cr4, [r4], #-316	; 0xfffffec4
    119c:	65704f5f 	ldrbvs	r4, [r0, #-3935]!	; 0xfffff0a1
    11a0:	69746172 	ldmdbvs	r4!, {r1, r4, r5, r6, r8, sp, lr}^
    11a4:	76506e6f 	ldrbvc	r6, [r0], -pc, ror #28
    11a8:	636f6900 	cmnvs	pc, #0, 18
    11ac:	72006c74 	andvc	r6, r0, #116, 24	; 0x7400
    11b0:	6e637465 	cdpvs	4, 6, cr7, cr3, cr5, {3}
    11b4:	6f6e0074 	svcvs	0x006e0074
    11b8:	79666974 	stmdbvc	r6!, {r2, r4, r5, r6, r8, fp, sp, lr}^
    11bc:	72657400 	rsbvc	r7, r5, #0, 8
    11c0:	616e696d 	cmnvs	lr, sp, ror #18
    11c4:	6d006574 	cfstr32vs	mvfx6, [r0, #-464]	; 0xfffffe30
    11c8:	0065646f 	rsbeq	r6, r5, pc, ror #8
    11cc:	66667562 	strbtvs	r7, [r6], -r2, ror #10
    11d0:	5f007265 	svcpl	0x00007265
    11d4:	6572345a 	ldrbvs	r3, [r2, #-1114]!	; 0xfffffba6
    11d8:	506a6461 	rsbpl	r6, sl, r1, ror #8
    11dc:	47006a63 	strmi	r6, [r0, -r3, ror #20]
    11e0:	4320554e 			; <UNDEFINED> instruction: 0x4320554e
    11e4:	34312b2b 	ldrtcc	r2, [r1], #-2859	; 0xfffff4d5
    11e8:	2e303120 	rsfcssp	f3, f0, f0
    11ec:	20312e33 	eorscs	r2, r1, r3, lsr lr
    11f0:	31323032 	teqcc	r2, r2, lsr r0
    11f4:	34323830 	ldrtcc	r3, [r2], #-2096	; 0xfffff7d0
    11f8:	65722820 	ldrbvs	r2, [r2, #-2080]!	; 0xfffff7e0
    11fc:	7361656c 	cmnvc	r1, #108, 10	; 0x1b000000
    1200:	2d202965 			; <UNDEFINED> instruction: 0x2d202965
    1204:	6f6c666d 	svcvs	0x006c666d
    1208:	612d7461 			; <UNDEFINED> instruction: 0x612d7461
    120c:	683d6962 	ldmdavs	sp!, {r1, r5, r6, r8, fp, sp, lr}
    1210:	20647261 	rsbcs	r7, r4, r1, ror #4
    1214:	70666d2d 	rsbvc	r6, r6, sp, lsr #26
    1218:	66763d75 			; <UNDEFINED> instruction: 0x66763d75
    121c:	6d2d2070 	stcvs	0, cr2, [sp, #-448]!	; 0xfffffe40
    1220:	616f6c66 	cmnvs	pc, r6, ror #24
    1224:	62612d74 	rsbvs	r2, r1, #116, 26	; 0x1d00
    1228:	61683d69 	cmnvs	r8, r9, ror #26
    122c:	2d206472 	cfstrscs	mvf6, [r0, #-456]!	; 0xfffffe38
    1230:	7570666d 	ldrbvc	r6, [r0, #-1645]!	; 0xfffff993
    1234:	7066763d 	rsbvc	r7, r6, sp, lsr r6
    1238:	746d2d20 	strbtvc	r2, [sp], #-3360	; 0xfffff2e0
    123c:	3d656e75 	stclcc	14, cr6, [r5, #-468]!	; 0xfffffe2c
    1240:	316d7261 	cmncc	sp, r1, ror #4
    1244:	6a363731 	bvs	d8ef10 <__bss_end+0xd85180>
    1248:	732d667a 			; <UNDEFINED> instruction: 0x732d667a
    124c:	616d2d20 	cmnvs	sp, r0, lsr #26
    1250:	2d206d72 	stccs	13, cr6, [r0, #-456]!	; 0xfffffe38
    1254:	6372616d 	cmnvs	r2, #1073741851	; 0x4000001b
    1258:	72613d68 	rsbvc	r3, r1, #104, 26	; 0x1a00
    125c:	7a36766d 	bvc	d9ec18 <__bss_end+0xd94e88>
    1260:	70662b6b 	rsbvc	r2, r6, fp, ror #22
    1264:	20672d20 	rsbcs	r2, r7, r0, lsr #26
    1268:	2d20672d 	stccs	7, cr6, [r0, #-180]!	; 0xffffff4c
    126c:	4f2d2067 	svcmi	0x002d2067
    1270:	4f2d2030 	svcmi	0x002d2030
    1274:	662d2030 			; <UNDEFINED> instruction: 0x662d2030
    1278:	652d6f6e 	strvs	r6, [sp, #-3950]!	; 0xfffff092
    127c:	70656378 	rsbvc	r6, r5, r8, ror r3
    1280:	6e6f6974 			; <UNDEFINED> instruction: 0x6e6f6974
    1284:	662d2073 			; <UNDEFINED> instruction: 0x662d2073
    1288:	722d6f6e 	eorvc	r6, sp, #440	; 0x1b8
    128c:	00697474 	rsbeq	r7, r9, r4, ror r4
    1290:	63746572 	cmnvs	r4, #478150656	; 0x1c800000
    1294:	0065646f 	rsbeq	r6, r5, pc, ror #8
    1298:	5f746567 	svcpl	0x00746567
    129c:	69746361 	ldmdbvs	r4!, {r0, r5, r6, r8, r9, sp, lr}^
    12a0:	705f6576 	subsvc	r6, pc, r6, ror r5	; <UNPREDICTABLE>
    12a4:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
    12a8:	635f7373 	cmpvs	pc, #-872415231	; 0xcc000001
    12ac:	746e756f 	strbtvc	r7, [lr], #-1391	; 0xfffffa91
    12b0:	6c696600 	stclvs	6, cr6, [r9], #-0
    12b4:	6d616e65 	stclvs	14, cr6, [r1, #-404]!	; 0xfffffe6c
    12b8:	65720065 	ldrbvs	r0, [r2, #-101]!	; 0xffffff9b
    12bc:	67006461 	strvs	r6, [r0, -r1, ror #8]
    12c0:	69707465 	ldmdbvs	r0!, {r0, r2, r5, r6, sl, ip, sp, lr}^
    12c4:	5a5f0064 	bpl	17c145c <__bss_end+0x17b76cc>
    12c8:	65706f34 	ldrbvs	r6, [r0, #-3892]!	; 0xfffff0cc
    12cc:	634b506e 	movtvs	r5, #45166	; 0xb06e
    12d0:	464e3531 			; <UNDEFINED> instruction: 0x464e3531
    12d4:	5f656c69 	svcpl	0x00656c69
    12d8:	6e65704f 	cdpvs	0, 6, cr7, cr5, cr15, {2}
    12dc:	646f4d5f 	strbtvs	r4, [pc], #-3423	; 12e4 <shift+0x12e4>
    12e0:	5a5f0065 	bpl	17c147c <__bss_end+0x17b76ec>
    12e4:	6d656d36 	stclvs	13, cr6, [r5, #-216]!	; 0xffffff28
    12e8:	50797063 	rsbspl	r7, r9, r3, rrx
    12ec:	7650764b 	ldrbvc	r7, [r0], -fp, asr #12
    12f0:	5a5f0069 	bpl	17c149c <__bss_end+0x17b770c>
    12f4:	6f746934 	svcvs	0x00746934
    12f8:	63506a61 	cmpvs	r0, #397312	; 0x61000
    12fc:	7461006a 	strbtvc	r0, [r1], #-106	; 0xffffff96
    1300:	7300696f 	movwvc	r6, #2415	; 0x96f
    1304:	656c7274 	strbvs	r7, [ip, #-628]!	; 0xfffffd8c
    1308:	6f63006e 	svcvs	0x0063006e
    130c:	7461636e 	strbtvc	r6, [r1], #-878	; 0xfffffc92
    1310:	73656400 	cmnvc	r5, #0, 8
    1314:	6e690074 	mcrvs	0, 3, r0, cr9, cr4, {3}
    1318:	00747570 	rsbseq	r7, r4, r0, ror r5
    131c:	65736162 	ldrbvs	r6, [r3, #-354]!	; 0xfffffe9e
    1320:	6f746900 	svcvs	0x00746900
    1324:	6e690061 	cdpvs	0, 6, cr0, cr9, cr1, {3}
    1328:	74705f74 	ldrbtvc	r5, [r0], #-3956	; 0xfffff08c
    132c:	5a5f0072 	bpl	17c14fc <__bss_end+0x17b776c>
    1330:	657a6235 	ldrbvs	r6, [sl, #-565]!	; 0xfffffdcb
    1334:	76506f72 	usub16vc	r6, r0, r2
    1338:	74730069 	ldrbtvc	r0, [r3], #-105	; 0xffffff97
    133c:	70636e72 	rsbvc	r6, r3, r2, ror lr
    1340:	5a5f0079 	bpl	17c152c <__bss_end+0x17b779c>
    1344:	72747337 	rsbsvc	r7, r4, #-603979776	; 0xdc000000
    1348:	7970636e 	ldmdbvc	r0!, {r1, r2, r3, r5, r6, r8, r9, sp, lr}^
    134c:	4b506350 	blmi	141a094 <__bss_end+0x1410304>
    1350:	69006963 	stmdbvs	r0, {r0, r1, r5, r6, r8, fp, sp, lr}
    1354:	705f746e 	subsvc	r7, pc, lr, ror #8
    1358:	00747261 	rsbseq	r7, r4, r1, ror #4
    135c:	63617266 	cmnvs	r1, #1610612742	; 0x60000006
    1360:	6e6f6974 			; <UNDEFINED> instruction: 0x6e6f6974
    1364:	67696400 	strbvs	r6, [r9, -r0, lsl #8]!
    1368:	5f007469 	svcpl	0x00007469
    136c:	6f63365a 	svcvs	0x0063365a
    1370:	7461636e 	strbtvc	r6, [r1], #-878	; 0xfffffc92
    1374:	4b506350 	blmi	141a0bc <__bss_end+0x141032c>
    1378:	656d0063 	strbvs	r0, [sp, #-99]!	; 0xffffff9d
    137c:	7473646d 	ldrbtvc	r6, [r3], #-1133	; 0xfffffb93
    1380:	61684300 	cmnvs	r8, r0, lsl #6
    1384:	6e6f4372 	mcrvs	3, 3, r4, cr15, cr2, {3}
    1388:	72724176 	rsbsvc	r4, r2, #-2147483619	; 0x8000001d
    138c:	6f746600 	svcvs	0x00746600
    1390:	656d0061 	strbvs	r0, [sp, #-97]!	; 0xffffff9f
    1394:	6372736d 	cmnvs	r2, #-1275068415	; 0xb4000001
    1398:	657a6200 	ldrbvs	r6, [sl, #-512]!	; 0xfffffe00
    139c:	6d006f72 	stcvs	15, cr6, [r0, #-456]	; 0xfffffe38
    13a0:	70636d65 	rsbvc	r6, r3, r5, ror #26
    13a4:	74730079 	ldrbtvc	r0, [r3], #-121	; 0xffffff87
    13a8:	6d636e72 	stclvs	14, cr6, [r3, #-456]!	; 0xfffffe38
    13ac:	65640070 	strbvs	r0, [r4, #-112]!	; 0xffffff90
    13b0:	616d6963 	cmnvs	sp, r3, ror #18
    13b4:	6c705f6c 	ldclvs	15, cr5, [r0], #-432	; 0xfffffe50
    13b8:	73656361 	cmnvc	r5, #-2080374783	; 0x84000001
    13bc:	345a5f00 	ldrbcc	r5, [sl], #-3840	; 0xfffff100
    13c0:	696f7461 	stmdbvs	pc!, {r0, r5, r6, sl, ip, sp, lr}^	; <UNPREDICTABLE>
    13c4:	00634b50 	rsbeq	r4, r3, r0, asr fp
    13c8:	7074756f 	rsbsvc	r7, r4, pc, ror #10
    13cc:	5f007475 	svcpl	0x00007475
    13d0:	7466345a 	strbtvc	r3, [r6], #-1114	; 0xfffffba6
    13d4:	5066616f 	rsbpl	r6, r6, pc, ror #2
    13d8:	5f006a63 	svcpl	0x00006a63
    13dc:	7473365a 	ldrbtvc	r3, [r3], #-1626	; 0xfffff9a6
    13e0:	6e656c72 	mcrvs	12, 3, r6, cr5, cr2, {3}
    13e4:	00634b50 	rsbeq	r4, r3, r0, asr fp
    13e8:	73375a5f 	teqvc	r7, #389120	; 0x5f000
    13ec:	636e7274 	cmnvs	lr, #116, 4	; 0x40000007
    13f0:	4b50706d 	blmi	141d5ac <__bss_end+0x141381c>
    13f4:	5f305363 	svcpl	0x00305363
    13f8:	6e690069 	cdpvs	0, 6, cr0, cr9, cr9, {3}
    13fc:	74735f74 	ldrbtvc	r5, [r3], #-3956	; 0xfffff08c
    1400:	656d0072 	strbvs	r0, [sp, #-114]!	; 0xffffff8e
    1404:	79726f6d 	ldmdbvc	r2!, {r0, r2, r3, r5, r6, r8, r9, sl, fp, sp, lr}^
    1408:	6e656c00 	cdpvs	12, 6, cr6, cr5, cr0, {0}
    140c:	00687467 	rsbeq	r7, r8, r7, ror #8
    1410:	6573552f 	ldrbvs	r5, [r3, #-1327]!	; 0xfffffad1
    1414:	772f7372 			; <UNDEFINED> instruction: 0x772f7372
    1418:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
    141c:	2f696a72 	svccs	0x00696a72
    1420:	6b736544 	blvs	1cda938 <__bss_end+0x1cd0ba8>
    1424:	2f706f74 	svccs	0x00706f74
    1428:	2f564146 	svccs	0x00564146
    142c:	6176614e 	cmnvs	r6, lr, asr #2
    1430:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
    1434:	4f2f6963 	svcmi	0x002f6963
    1438:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
    143c:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
    1440:	6b6c6172 	blvs	1b19a10 <__bss_end+0x1b0fc80>
    1444:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
    1448:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
    144c:	756f732f 	strbvc	r7, [pc, #-815]!	; 1125 <shift+0x1125>
    1450:	73656372 	cmnvc	r5, #-939524095	; 0xc8000001
    1454:	6474732f 	ldrbtvs	r7, [r4], #-815	; 0xfffffcd1
    1458:	2f62696c 	svccs	0x0062696c
    145c:	2f637273 	svccs	0x00637273
    1460:	73647473 	cmnvc	r4, #1929379840	; 0x73000000
    1464:	6e697274 	mcrvs	2, 3, r7, cr9, cr4, {3}
    1468:	70632e67 	rsbvc	r2, r3, r7, ror #28
    146c:	Address 0x000000000000146c is out of bounds.


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
  20:	8b040e42 	blhi	103930 <__bss_end+0xf9ba0>
  24:	0b0d4201 	bleq	350830 <__bss_end+0x346aa0>
  28:	420d0d62 	andmi	r0, sp, #6272	; 0x1880
  2c:	00000ecb 	andeq	r0, r0, fp, asr #29
  30:	0000001c 	andeq	r0, r0, ip, lsl r0
  34:	00000000 	andeq	r0, r0, r0
  38:	00008064 	andeq	r8, r0, r4, rrx
  3c:	00000040 	andeq	r0, r0, r0, asr #32
  40:	8b080e42 	blhi	203950 <__bss_end+0x1f9bc0>
  44:	42018e02 	andmi	r8, r1, #2, 28
  48:	5a040b0c 	bpl	102c80 <__bss_end+0xf8ef0>
  4c:	00080d0c 	andeq	r0, r8, ip, lsl #26
  50:	0000000c 	andeq	r0, r0, ip
  54:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
  58:	7c020001 	stcvc	0, cr0, [r2], {1}
  5c:	000d0c0e 	andeq	r0, sp, lr, lsl #24
  60:	0000001c 	andeq	r0, r0, ip, lsl r0
  64:	00000050 	andeq	r0, r0, r0, asr r0
  68:	000080a4 	andeq	r8, r0, r4, lsr #1
  6c:	00000038 	andeq	r0, r0, r8, lsr r0
  70:	8b040e42 	blhi	103980 <__bss_end+0xf9bf0>
  74:	0b0d4201 	bleq	350880 <__bss_end+0x346af0>
  78:	420d0d54 	andmi	r0, sp, #84, 26	; 0x1500
  7c:	00000ecb 	andeq	r0, r0, fp, asr #29
  80:	0000001c 	andeq	r0, r0, ip, lsl r0
  84:	00000050 	andeq	r0, r0, r0, asr r0
  88:	000080dc 	ldrdeq	r8, [r0], -ip
  8c:	0000002c 	andeq	r0, r0, ip, lsr #32
  90:	8b040e42 	blhi	1039a0 <__bss_end+0xf9c10>
  94:	0b0d4201 	bleq	3508a0 <__bss_end+0x346b10>
  98:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
  9c:	00000ecb 	andeq	r0, r0, fp, asr #29
  a0:	0000001c 	andeq	r0, r0, ip, lsl r0
  a4:	00000050 	andeq	r0, r0, r0, asr r0
  a8:	00008108 	andeq	r8, r0, r8, lsl #2
  ac:	00000020 	andeq	r0, r0, r0, lsr #32
  b0:	8b040e42 	blhi	1039c0 <__bss_end+0xf9c30>
  b4:	0b0d4201 	bleq	3508c0 <__bss_end+0x346b30>
  b8:	420d0d48 	andmi	r0, sp, #72, 26	; 0x1200
  bc:	00000ecb 	andeq	r0, r0, fp, asr #29
  c0:	0000001c 	andeq	r0, r0, ip, lsl r0
  c4:	00000050 	andeq	r0, r0, r0, asr r0
  c8:	00008128 	andeq	r8, r0, r8, lsr #2
  cc:	00000018 	andeq	r0, r0, r8, lsl r0
  d0:	8b040e42 	blhi	1039e0 <__bss_end+0xf9c50>
  d4:	0b0d4201 	bleq	3508e0 <__bss_end+0x346b50>
  d8:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
  dc:	00000ecb 	andeq	r0, r0, fp, asr #29
  e0:	0000001c 	andeq	r0, r0, ip, lsl r0
  e4:	00000050 	andeq	r0, r0, r0, asr r0
  e8:	00008140 	andeq	r8, r0, r0, asr #2
  ec:	00000018 	andeq	r0, r0, r8, lsl r0
  f0:	8b040e42 	blhi	103a00 <__bss_end+0xf9c70>
  f4:	0b0d4201 	bleq	350900 <__bss_end+0x346b70>
  f8:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
  fc:	00000ecb 	andeq	r0, r0, fp, asr #29
 100:	0000001c 	andeq	r0, r0, ip, lsl r0
 104:	00000050 	andeq	r0, r0, r0, asr r0
 108:	00008158 	andeq	r8, r0, r8, asr r1
 10c:	00000018 	andeq	r0, r0, r8, lsl r0
 110:	8b040e42 	blhi	103a20 <__bss_end+0xf9c90>
 114:	0b0d4201 	bleq	350920 <__bss_end+0x346b90>
 118:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
 11c:	00000ecb 	andeq	r0, r0, fp, asr #29
 120:	00000014 	andeq	r0, r0, r4, lsl r0
 124:	00000050 	andeq	r0, r0, r0, asr r0
 128:	00008170 	andeq	r8, r0, r0, ror r1
 12c:	0000000c 	andeq	r0, r0, ip
 130:	8b040e42 	blhi	103a40 <__bss_end+0xf9cb0>
 134:	0b0d4201 	bleq	350940 <__bss_end+0x346bb0>
 138:	0000001c 	andeq	r0, r0, ip, lsl r0
 13c:	00000050 	andeq	r0, r0, r0, asr r0
 140:	0000817c 	andeq	r8, r0, ip, ror r1
 144:	00000058 	andeq	r0, r0, r8, asr r0
 148:	8b080e42 	blhi	203a58 <__bss_end+0x1f9cc8>
 14c:	42018e02 	andmi	r8, r1, #2, 28
 150:	62040b0c 	andvs	r0, r4, #12, 22	; 0x3000
 154:	00080d0c 	andeq	r0, r8, ip, lsl #26
 158:	0000001c 	andeq	r0, r0, ip, lsl r0
 15c:	00000050 	andeq	r0, r0, r0, asr r0
 160:	000081d4 	ldrdeq	r8, [r0], -r4
 164:	00000058 	andeq	r0, r0, r8, asr r0
 168:	8b080e42 	blhi	203a78 <__bss_end+0x1f9ce8>
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
 1a0:	0b0c4201 	bleq	3109ac <__bss_end+0x306c1c>
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
 1cc:	0b0c4201 	bleq	3109d8 <__bss_end+0x306c48>
 1d0:	0c6c0204 	sfmeq	f0, 2, [ip], #-16
 1d4:	00001c0d 	andeq	r1, r0, sp, lsl #24
 1d8:	00000020 	andeq	r0, r0, r0, lsr #32
 1dc:	00000178 	andeq	r0, r0, r8, ror r1
 1e0:	000083c0 	andeq	r8, r0, r0, asr #7
 1e4:	00000074 	andeq	r0, r0, r4, ror r0
 1e8:	840c0e42 	strhi	r0, [ip], #-3650	; 0xfffff1be
 1ec:	8e028b03 	vmlahi.f64	d8, d2, d3
 1f0:	0b0c4201 	bleq	3109fc <__bss_end+0x306c6c>
 1f4:	0d0c7204 	sfmeq	f7, 4, [ip, #-16]
 1f8:	0000000c 	andeq	r0, r0, ip
 1fc:	0000001c 	andeq	r0, r0, ip, lsl r0
 200:	00000178 	andeq	r0, r0, r8, ror r1
 204:	00008434 	andeq	r8, r0, r4, lsr r4
 208:	000000fc 	strdeq	r0, [r0], -ip
 20c:	8b080e42 	blhi	203b1c <__bss_end+0x1f9d8c>
 210:	42018e02 	andmi	r8, r1, #2, 28
 214:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 218:	080d0c6e 	stmdaeq	sp, {r1, r2, r3, r5, r6, sl, fp}
 21c:	0000001c 	andeq	r0, r0, ip, lsl r0
 220:	00000178 	andeq	r0, r0, r8, ror r1
 224:	00008530 	andeq	r8, r0, r0, lsr r5
 228:	000000a4 	andeq	r0, r0, r4, lsr #1
 22c:	8b080e42 	blhi	203b3c <__bss_end+0x1f9dac>
 230:	42018e02 	andmi	r8, r1, #2, 28
 234:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 238:	080d0c48 	stmdaeq	sp, {r3, r6, sl, fp}
 23c:	0000001c 	andeq	r0, r0, ip, lsl r0
 240:	00000178 	andeq	r0, r0, r8, ror r1
 244:	000085d4 	ldrdeq	r8, [r0], -r4
 248:	000000f8 	strdeq	r0, [r0], -r8
 24c:	8b080e42 	blhi	203b5c <__bss_end+0x1f9dcc>
 250:	42018e02 	andmi	r8, r1, #2, 28
 254:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 258:	080d0c70 	stmdaeq	sp, {r4, r5, r6, sl, fp}
 25c:	0000001c 	andeq	r0, r0, ip, lsl r0
 260:	00000178 	andeq	r0, r0, r8, ror r1
 264:	000086cc 	andeq	r8, r0, ip, asr #13
 268:	000001d0 	ldrdeq	r0, [r0], -r0	; <UNPREDICTABLE>
 26c:	8b080e42 	blhi	203b7c <__bss_end+0x1f9dec>
 270:	42018e02 	andmi	r8, r1, #2, 28
 274:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 278:	080d0cd4 	stmdaeq	sp, {r2, r4, r6, r7, sl, fp}
 27c:	0000001c 	andeq	r0, r0, ip, lsl r0
 280:	00000178 	andeq	r0, r0, r8, ror r1
 284:	0000889c 	muleq	r0, ip, r8
 288:	00000114 	andeq	r0, r0, r4, lsl r1
 28c:	8b080e42 	blhi	203b9c <__bss_end+0x1f9e0c>
 290:	42018e02 	andmi	r8, r1, #2, 28
 294:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 298:	080d0c7a 	stmdaeq	sp, {r1, r3, r4, r5, r6, sl, fp}
 29c:	0000001c 	andeq	r0, r0, ip, lsl r0
 2a0:	00000178 	andeq	r0, r0, r8, ror r1
 2a4:	000089b0 			; <UNDEFINED> instruction: 0x000089b0
 2a8:	000000c0 	andeq	r0, r0, r0, asr #1
 2ac:	8b080e42 	blhi	203bbc <__bss_end+0x1f9e2c>
 2b0:	42018e02 	andmi	r8, r1, #2, 28
 2b4:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 2b8:	080d0c58 	stmdaeq	sp, {r3, r4, r6, sl, fp}
 2bc:	00000018 	andeq	r0, r0, r8, lsl r0
 2c0:	00000178 	andeq	r0, r0, r8, ror r1
 2c4:	00008a70 	andeq	r8, r0, r0, ror sl
 2c8:	00000040 	andeq	r0, r0, r0, asr #32
 2cc:	8b080e42 	blhi	203bdc <__bss_end+0x1f9e4c>
 2d0:	42018e02 	andmi	r8, r1, #2, 28
 2d4:	00040b0c 	andeq	r0, r4, ip, lsl #22
 2d8:	00000018 	andeq	r0, r0, r8, lsl r0
 2dc:	00000178 	andeq	r0, r0, r8, ror r1
 2e0:	00008ab0 			; <UNDEFINED> instruction: 0x00008ab0
 2e4:	00000074 	andeq	r0, r0, r4, ror r0
 2e8:	8b080e42 	blhi	203bf8 <__bss_end+0x1f9e68>
 2ec:	42018e02 	andmi	r8, r1, #2, 28
 2f0:	00040b0c 	andeq	r0, r4, ip, lsl #22
 2f4:	0000001c 	andeq	r0, r0, ip, lsl r0
 2f8:	00000178 	andeq	r0, r0, r8, ror r1
 2fc:	00008b24 	andeq	r8, r0, r4, lsr #22
 300:	0000017c 	andeq	r0, r0, ip, ror r1
 304:	8b080e42 	blhi	203c14 <__bss_end+0x1f9e84>
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
 334:	8b040e42 	blhi	103c44 <__bss_end+0xf9eb4>
 338:	0b0d4201 	bleq	350b44 <__bss_end+0x346db4>
 33c:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
 340:	00000ecb 	andeq	r0, r0, fp, asr #29
 344:	0000001c 	andeq	r0, r0, ip, lsl r0
 348:	00000314 	andeq	r0, r0, r4, lsl r3
 34c:	00008ccc 	andeq	r8, r0, ip, asr #25
 350:	0000002c 	andeq	r0, r0, ip, lsr #32
 354:	8b040e42 	blhi	103c64 <__bss_end+0xf9ed4>
 358:	0b0d4201 	bleq	350b64 <__bss_end+0x346dd4>
 35c:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
 360:	00000ecb 	andeq	r0, r0, fp, asr #29
 364:	0000001c 	andeq	r0, r0, ip, lsl r0
 368:	00000314 	andeq	r0, r0, r4, lsl r3
 36c:	00008cf8 	strdeq	r8, [r0], -r8	; <UNPREDICTABLE>
 370:	0000001c 	andeq	r0, r0, ip, lsl r0
 374:	8b040e42 	blhi	103c84 <__bss_end+0xf9ef4>
 378:	0b0d4201 	bleq	350b84 <__bss_end+0x346df4>
 37c:	420d0d46 	andmi	r0, sp, #4480	; 0x1180
 380:	00000ecb 	andeq	r0, r0, fp, asr #29
 384:	0000001c 	andeq	r0, r0, ip, lsl r0
 388:	00000314 	andeq	r0, r0, r4, lsl r3
 38c:	00008d14 	andeq	r8, r0, r4, lsl sp
 390:	00000044 	andeq	r0, r0, r4, asr #32
 394:	8b040e42 	blhi	103ca4 <__bss_end+0xf9f14>
 398:	0b0d4201 	bleq	350ba4 <__bss_end+0x346e14>
 39c:	420d0d5a 	andmi	r0, sp, #5760	; 0x1680
 3a0:	00000ecb 	andeq	r0, r0, fp, asr #29
 3a4:	0000001c 	andeq	r0, r0, ip, lsl r0
 3a8:	00000314 	andeq	r0, r0, r4, lsl r3
 3ac:	00008d58 	andeq	r8, r0, r8, asr sp
 3b0:	00000050 	andeq	r0, r0, r0, asr r0
 3b4:	8b040e42 	blhi	103cc4 <__bss_end+0xf9f34>
 3b8:	0b0d4201 	bleq	350bc4 <__bss_end+0x346e34>
 3bc:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 3c0:	00000ecb 	andeq	r0, r0, fp, asr #29
 3c4:	0000001c 	andeq	r0, r0, ip, lsl r0
 3c8:	00000314 	andeq	r0, r0, r4, lsl r3
 3cc:	00008da8 	andeq	r8, r0, r8, lsr #27
 3d0:	00000050 	andeq	r0, r0, r0, asr r0
 3d4:	8b040e42 	blhi	103ce4 <__bss_end+0xf9f54>
 3d8:	0b0d4201 	bleq	350be4 <__bss_end+0x346e54>
 3dc:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 3e0:	00000ecb 	andeq	r0, r0, fp, asr #29
 3e4:	0000001c 	andeq	r0, r0, ip, lsl r0
 3e8:	00000314 	andeq	r0, r0, r4, lsl r3
 3ec:	00008df8 	strdeq	r8, [r0], -r8	; <UNPREDICTABLE>
 3f0:	0000002c 	andeq	r0, r0, ip, lsr #32
 3f4:	8b040e42 	blhi	103d04 <__bss_end+0xf9f74>
 3f8:	0b0d4201 	bleq	350c04 <__bss_end+0x346e74>
 3fc:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
 400:	00000ecb 	andeq	r0, r0, fp, asr #29
 404:	0000001c 	andeq	r0, r0, ip, lsl r0
 408:	00000314 	andeq	r0, r0, r4, lsl r3
 40c:	00008e24 	andeq	r8, r0, r4, lsr #28
 410:	00000050 	andeq	r0, r0, r0, asr r0
 414:	8b040e42 	blhi	103d24 <__bss_end+0xf9f94>
 418:	0b0d4201 	bleq	350c24 <__bss_end+0x346e94>
 41c:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 420:	00000ecb 	andeq	r0, r0, fp, asr #29
 424:	0000001c 	andeq	r0, r0, ip, lsl r0
 428:	00000314 	andeq	r0, r0, r4, lsl r3
 42c:	00008e74 	andeq	r8, r0, r4, ror lr
 430:	00000044 	andeq	r0, r0, r4, asr #32
 434:	8b040e42 	blhi	103d44 <__bss_end+0xf9fb4>
 438:	0b0d4201 	bleq	350c44 <__bss_end+0x346eb4>
 43c:	420d0d5a 	andmi	r0, sp, #5760	; 0x1680
 440:	00000ecb 	andeq	r0, r0, fp, asr #29
 444:	0000001c 	andeq	r0, r0, ip, lsl r0
 448:	00000314 	andeq	r0, r0, r4, lsl r3
 44c:	00008eb8 			; <UNDEFINED> instruction: 0x00008eb8
 450:	00000050 	andeq	r0, r0, r0, asr r0
 454:	8b040e42 	blhi	103d64 <__bss_end+0xf9fd4>
 458:	0b0d4201 	bleq	350c64 <__bss_end+0x346ed4>
 45c:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 460:	00000ecb 	andeq	r0, r0, fp, asr #29
 464:	0000001c 	andeq	r0, r0, ip, lsl r0
 468:	00000314 	andeq	r0, r0, r4, lsl r3
 46c:	00008f08 	andeq	r8, r0, r8, lsl #30
 470:	00000054 	andeq	r0, r0, r4, asr r0
 474:	8b040e42 	blhi	103d84 <__bss_end+0xf9ff4>
 478:	0b0d4201 	bleq	350c84 <__bss_end+0x346ef4>
 47c:	420d0d62 	andmi	r0, sp, #6272	; 0x1880
 480:	00000ecb 	andeq	r0, r0, fp, asr #29
 484:	0000001c 	andeq	r0, r0, ip, lsl r0
 488:	00000314 	andeq	r0, r0, r4, lsl r3
 48c:	00008f5c 	andeq	r8, r0, ip, asr pc
 490:	0000003c 	andeq	r0, r0, ip, lsr r0
 494:	8b040e42 	blhi	103da4 <__bss_end+0xfa014>
 498:	0b0d4201 	bleq	350ca4 <__bss_end+0x346f14>
 49c:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 4a0:	00000ecb 	andeq	r0, r0, fp, asr #29
 4a4:	0000001c 	andeq	r0, r0, ip, lsl r0
 4a8:	00000314 	andeq	r0, r0, r4, lsl r3
 4ac:	00008f98 	muleq	r0, r8, pc	; <UNPREDICTABLE>
 4b0:	0000003c 	andeq	r0, r0, ip, lsr r0
 4b4:	8b040e42 	blhi	103dc4 <__bss_end+0xfa034>
 4b8:	0b0d4201 	bleq	350cc4 <__bss_end+0x346f34>
 4bc:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 4c0:	00000ecb 	andeq	r0, r0, fp, asr #29
 4c4:	0000001c 	andeq	r0, r0, ip, lsl r0
 4c8:	00000314 	andeq	r0, r0, r4, lsl r3
 4cc:	00008fd4 	ldrdeq	r8, [r0], -r4
 4d0:	0000003c 	andeq	r0, r0, ip, lsr r0
 4d4:	8b040e42 	blhi	103de4 <__bss_end+0xfa054>
 4d8:	0b0d4201 	bleq	350ce4 <__bss_end+0x346f54>
 4dc:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 4e0:	00000ecb 	andeq	r0, r0, fp, asr #29
 4e4:	0000001c 	andeq	r0, r0, ip, lsl r0
 4e8:	00000314 	andeq	r0, r0, r4, lsl r3
 4ec:	00009010 	andeq	r9, r0, r0, lsl r0
 4f0:	0000003c 	andeq	r0, r0, ip, lsr r0
 4f4:	8b040e42 	blhi	103e04 <__bss_end+0xfa074>
 4f8:	0b0d4201 	bleq	350d04 <__bss_end+0x346f74>
 4fc:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 500:	00000ecb 	andeq	r0, r0, fp, asr #29
 504:	0000001c 	andeq	r0, r0, ip, lsl r0
 508:	00000314 	andeq	r0, r0, r4, lsl r3
 50c:	0000904c 	andeq	r9, r0, ip, asr #32
 510:	000000b0 	strheq	r0, [r0], -r0	; <UNPREDICTABLE>
 514:	8b080e42 	blhi	203e24 <__bss_end+0x1fa094>
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
 544:	8b080e42 	blhi	203e54 <__bss_end+0x1fa0c4>
 548:	42018e02 	andmi	r8, r1, #2, 28
 54c:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 550:	080d0cb2 	stmdaeq	sp, {r1, r4, r5, r7, sl, fp}
 554:	0000001c 	andeq	r0, r0, ip, lsl r0
 558:	00000524 	andeq	r0, r0, r4, lsr #10
 55c:	00009270 	andeq	r9, r0, r0, ror r2
 560:	0000009c 	muleq	r0, ip, r0
 564:	8b040e42 	blhi	103e74 <__bss_end+0xfa0e4>
 568:	0b0d4201 	bleq	350d74 <__bss_end+0x346fe4>
 56c:	0d0d4602 	stceq	6, cr4, [sp, #-8]
 570:	000ecb42 	andeq	ip, lr, r2, asr #22
 574:	00000020 	andeq	r0, r0, r0, lsr #32
 578:	00000524 	andeq	r0, r0, r4, lsr #10
 57c:	0000930c 	andeq	r9, r0, ip, lsl #6
 580:	00000294 	muleq	r0, r4, r2
 584:	8b040e42 	blhi	103e94 <__bss_end+0xfa104>
 588:	0b0d4201 	bleq	350d94 <__bss_end+0x347004>
 58c:	0d013e03 	stceq	14, cr3, [r1, #-12]
 590:	0ecb420d 	cdpeq	2, 12, cr4, cr11, cr13, {0}
 594:	00000000 	andeq	r0, r0, r0
 598:	0000001c 	andeq	r0, r0, ip, lsl r0
 59c:	00000524 	andeq	r0, r0, r4, lsr #10
 5a0:	000095a0 	andeq	r9, r0, r0, lsr #11
 5a4:	000000c0 	andeq	r0, r0, r0, asr #1
 5a8:	8b040e42 	blhi	103eb8 <__bss_end+0xfa128>
 5ac:	0b0d4201 	bleq	350db8 <__bss_end+0x347028>
 5b0:	0d0d5802 	stceq	8, cr5, [sp, #-8]
 5b4:	000ecb42 	andeq	ip, lr, r2, asr #22
 5b8:	0000001c 	andeq	r0, r0, ip, lsl r0
 5bc:	00000524 	andeq	r0, r0, r4, lsr #10
 5c0:	00009660 	andeq	r9, r0, r0, ror #12
 5c4:	000000ac 	andeq	r0, r0, ip, lsr #1
 5c8:	8b040e42 	blhi	103ed8 <__bss_end+0xfa148>
 5cc:	0b0d4201 	bleq	350dd8 <__bss_end+0x347048>
 5d0:	0d0d4e02 	stceq	14, cr4, [sp, #-8]
 5d4:	000ecb42 	andeq	ip, lr, r2, asr #22
 5d8:	0000001c 	andeq	r0, r0, ip, lsl r0
 5dc:	00000524 	andeq	r0, r0, r4, lsr #10
 5e0:	0000970c 	andeq	r9, r0, ip, lsl #14
 5e4:	00000054 	andeq	r0, r0, r4, asr r0
 5e8:	8b040e42 	blhi	103ef8 <__bss_end+0xfa168>
 5ec:	0b0d4201 	bleq	350df8 <__bss_end+0x347068>
 5f0:	420d0d62 	andmi	r0, sp, #6272	; 0x1880
 5f4:	00000ecb 	andeq	r0, r0, fp, asr #29
 5f8:	0000001c 	andeq	r0, r0, ip, lsl r0
 5fc:	00000524 	andeq	r0, r0, r4, lsr #10
 600:	00009760 	andeq	r9, r0, r0, ror #14
 604:	00000068 	andeq	r0, r0, r8, rrx
 608:	8b040e42 	blhi	103f18 <__bss_end+0xfa188>
 60c:	0b0d4201 	bleq	350e18 <__bss_end+0x347088>
 610:	420d0d6c 	andmi	r0, sp, #108, 26	; 0x1b00
 614:	00000ecb 	andeq	r0, r0, fp, asr #29
 618:	0000001c 	andeq	r0, r0, ip, lsl r0
 61c:	00000524 	andeq	r0, r0, r4, lsr #10
 620:	000097c8 	andeq	r9, r0, r8, asr #15
 624:	00000080 	andeq	r0, r0, r0, lsl #1
 628:	8b040e42 	blhi	103f38 <__bss_end+0xfa1a8>
 62c:	0b0d4201 	bleq	350e38 <__bss_end+0x3470a8>
 630:	420d0d78 	andmi	r0, sp, #120, 26	; 0x1e00
 634:	00000ecb 	andeq	r0, r0, fp, asr #29
 638:	0000001c 	andeq	r0, r0, ip, lsl r0
 63c:	00000524 	andeq	r0, r0, r4, lsr #10
 640:	00009848 	andeq	r9, r0, r8, asr #16
 644:	00000074 	andeq	r0, r0, r4, ror r0
 648:	8b080e42 	blhi	203f58 <__bss_end+0x1fa1c8>
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
