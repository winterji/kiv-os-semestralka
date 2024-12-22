
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
    805c:	000099ec 	andeq	r9, r0, ip, ror #19
    8060:	00009a04 	andeq	r9, r0, r4, lsl #20

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
    8080:	eb000205 	bl	889c <main>
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
    81cc:	000099e4 	andeq	r9, r0, r4, ror #19
    81d0:	000099e4 	andeq	r9, r0, r4, ror #19

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
    8224:	000099e4 	andeq	r9, r0, r4, ror #19
    8228:	000099e4 	andeq	r9, r0, r4, ror #19

0000822c <_Z8prep_msgPcPKc>:
_Z8prep_msgPcPKc():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:30
    6.71f, 4.23f, 5.12f, 3.99f, 2.22f, 7.20f, 11.93f, 10.96f
};
const uint32_t random_values_len = 8;
float prev_value = random_values[0];

void prep_msg(char* buff, const char* msg) {
    822c:	e92d4810 	push	{r4, fp, lr}
    8230:	e28db008 	add	fp, sp, #8
    8234:	e24dd00c 	sub	sp, sp, #12
    8238:	e50b0010 	str	r0, [fp, #-16]
    823c:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:31
    switch (agreed_role)
    8240:	e59f3080 	ldr	r3, [pc, #128]	; 82c8 <_Z8prep_msgPcPKc+0x9c>
    8244:	e5933000 	ldr	r3, [r3]
    8248:	e3530000 	cmp	r3, #0
    824c:	0a000002 	beq	825c <_Z8prep_msgPcPKc+0x30>
    8250:	e3530001 	cmp	r3, #1
    8254:	0a000005 	beq	8270 <_Z8prep_msgPcPKc+0x44>
    8258:	ea000009 	b	8284 <_Z8prep_msgPcPKc+0x58>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:34
    {
    case CI2C_Mode::Master:
        strncpy(buff, "MASTER: ", 8);
    825c:	e3a02008 	mov	r2, #8
    8260:	e59f1064 	ldr	r1, [pc, #100]	; 82cc <_Z8prep_msgPcPKc+0xa0>
    8264:	e51b0010 	ldr	r0, [fp, #-16]
    8268:	eb00041f 	bl	92ec <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:35
        break;
    826c:	ea000009 	b	8298 <_Z8prep_msgPcPKc+0x6c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:37
    case CI2C_Mode::Slave:
        strncpy(buff, "SLAVE: ", 7);
    8270:	e3a02007 	mov	r2, #7
    8274:	e59f1054 	ldr	r1, [pc, #84]	; 82d0 <_Z8prep_msgPcPKc+0xa4>
    8278:	e51b0010 	ldr	r0, [fp, #-16]
    827c:	eb00041a 	bl	92ec <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:38
        break;
    8280:	ea000004 	b	8298 <_Z8prep_msgPcPKc+0x6c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:40
    default:
        strncpy(buff, "UNSET: ", 7);
    8284:	e3a02007 	mov	r2, #7
    8288:	e59f1044 	ldr	r1, [pc, #68]	; 82d4 <_Z8prep_msgPcPKc+0xa8>
    828c:	e51b0010 	ldr	r0, [fp, #-16]
    8290:	eb000415 	bl	92ec <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:41
        break;
    8294:	e320f000 	nop	{0}
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:44
    }
    
    strncpy(buff + 7, msg, strlen(msg));
    8298:	e51b3010 	ldr	r3, [fp, #-16]
    829c:	e2834007 	add	r4, r3, #7
    82a0:	e51b0014 	ldr	r0, [fp, #-20]	; 0xffffffec
    82a4:	eb00046b 	bl	9458 <_Z6strlenPKc>
    82a8:	e1a03000 	mov	r3, r0
    82ac:	e1a02003 	mov	r2, r3
    82b0:	e51b1014 	ldr	r1, [fp, #-20]	; 0xffffffec
    82b4:	e1a00004 	mov	r0, r4
    82b8:	eb00040b 	bl	92ec <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:45
}
    82bc:	e320f000 	nop	{0}
    82c0:	e24bd008 	sub	sp, fp, #8
    82c4:	e8bd8810 	pop	{r4, fp, pc}
    82c8:	000099e4 	andeq	r9, r0, r4, ror #19
    82cc:	000098b8 			; <UNDEFINED> instruction: 0x000098b8
    82d0:	000098c4 	andeq	r9, r0, r4, asr #17
    82d4:	000098cc 	andeq	r9, r0, ip, asr #17

000082d8 <_Z3logPKc>:
_Z3logPKc():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:48

void log(const char* msg)
{
    82d8:	e92d49f0 	push	{r4, r5, r6, r7, r8, fp, lr}
    82dc:	e28db018 	add	fp, sp, #24
    82e0:	e24dd014 	sub	sp, sp, #20
    82e4:	e50b0028 	str	r0, [fp, #-40]	; 0xffffffd8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:51
    char new_buff[strlen(msg) + 7];
    prep_msg(new_buff, msg);
    write(log_fd, new_buff, strlen(msg)+7);
    82e8:	e1a0300d 	mov	r3, sp
    82ec:	e1a08003 	mov	r8, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:49
    char new_buff[strlen(msg) + 7];
    82f0:	e51b0028 	ldr	r0, [fp, #-40]	; 0xffffffd8
    82f4:	eb000457 	bl	9458 <_Z6strlenPKc>
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
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:50
    prep_msg(new_buff, msg);
    8378:	e51b1028 	ldr	r1, [fp, #-40]	; 0xffffffd8
    837c:	e51b0024 	ldr	r0, [fp, #-36]	; 0xffffffdc
    8380:	ebffffa9 	bl	822c <_Z8prep_msgPcPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:51
    write(log_fd, new_buff, strlen(msg)+7);
    8384:	e59f3030 	ldr	r3, [pc, #48]	; 83bc <_Z3logPKc+0xe4>
    8388:	e5934000 	ldr	r4, [r3]
    838c:	e51b0028 	ldr	r0, [fp, #-40]	; 0xffffffd8
    8390:	eb000430 	bl	9458 <_Z6strlenPKc>
    8394:	e1a03000 	mov	r3, r0
    8398:	e2833007 	add	r3, r3, #7
    839c:	e1a02003 	mov	r2, r3
    83a0:	e51b1024 	ldr	r1, [fp, #-36]	; 0xffffffdc
    83a4:	e1a00004 	mov	r0, r4
    83a8:	eb0001d1 	bl	8af4 <_Z5writejPKcj>
    83ac:	e1a0d008 	mov	sp, r8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:52
}
    83b0:	e320f000 	nop	{0}
    83b4:	e24bd018 	sub	sp, fp, #24
    83b8:	e8bd89f0 	pop	{r4, r5, r6, r7, r8, fp, pc}
    83bc:	000099ec 	andeq	r9, r0, ip, ror #19

000083c0 <_Z3logj>:
_Z3logj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:54

void log(const uint32_t value) {
    83c0:	e92d4810 	push	{r4, fp, lr}
    83c4:	e28db008 	add	fp, sp, #8
    83c8:	e24dd04c 	sub	sp, sp, #76	; 0x4c
    83cc:	e50b0050 	str	r0, [fp, #-80]	; 0xffffffb0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:56
    char buff[32], pom[32];
    itoa(value, pom, 10);
    83d0:	e24b304c 	sub	r3, fp, #76	; 0x4c
    83d4:	e3a0200a 	mov	r2, #10
    83d8:	e1a01003 	mov	r1, r3
    83dc:	e51b0050 	ldr	r0, [fp, #-80]	; 0xffffffb0
    83e0:	eb000298 	bl	8e48 <_Z4itoajPcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:57
    prep_msg(buff, pom);
    83e4:	e24b204c 	sub	r2, fp, #76	; 0x4c
    83e8:	e24b302c 	sub	r3, fp, #44	; 0x2c
    83ec:	e1a01002 	mov	r1, r2
    83f0:	e1a00003 	mov	r0, r3
    83f4:	ebffff8c 	bl	822c <_Z8prep_msgPcPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:58
    write(log_fd, buff, strlen(buff));
    83f8:	e59f3030 	ldr	r3, [pc, #48]	; 8430 <_Z3logj+0x70>
    83fc:	e5934000 	ldr	r4, [r3]
    8400:	e24b302c 	sub	r3, fp, #44	; 0x2c
    8404:	e1a00003 	mov	r0, r3
    8408:	eb000412 	bl	9458 <_Z6strlenPKc>
    840c:	e1a03000 	mov	r3, r0
    8410:	e1a02003 	mov	r2, r3
    8414:	e24b302c 	sub	r3, fp, #44	; 0x2c
    8418:	e1a01003 	mov	r1, r3
    841c:	e1a00004 	mov	r0, r4
    8420:	eb0001b3 	bl	8af4 <_Z5writejPKcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:59
}
    8424:	e320f000 	nop	{0}
    8428:	e24bd008 	sub	sp, fp, #8
    842c:	e8bd8810 	pop	{r4, fp, pc}
    8430:	000099ec 	andeq	r9, r0, ip, ror #19

00008434 <_Z9send_dataf>:
_Z9send_dataf():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:62

void send_data(const float value)
{
    8434:	e92d4800 	push	{fp, lr}
    8438:	e28db004 	add	fp, sp, #4
    843c:	e24dd018 	sub	sp, sp, #24
    8440:	ed0b0a06 	vstr	s0, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:63
    float next_predict = -1.0f;
    8444:	e59f30d8 	ldr	r3, [pc, #216]	; 8524 <_Z9send_dataf+0xf0>
    8448:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:65
    char msg[6];
    if (value < LOWER_BOUND || value > UPPER_BOUND)
    844c:	ed5b7a06 	vldr	s15, [fp, #-24]	; 0xffffffe8
    8450:	ed9f7a31 	vldr	s14, [pc, #196]	; 851c <_Z9send_dataf+0xe8>
    8454:	eef47ac7 	vcmpe.f32	s15, s14
    8458:	eef1fa10 	vmrs	APSR_nzcv, fpscr
    845c:	4a000004 	bmi	8474 <_Z9send_dataf+0x40>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:65 (discriminator 1)
    8460:	ed5b7a06 	vldr	s15, [fp, #-24]	; 0xffffffe8
    8464:	ed9f7a2d 	vldr	s14, [pc, #180]	; 8520 <_Z9send_dataf+0xec>
    8468:	eef47ac7 	vcmpe.f32	s15, s14
    846c:	eef1fa10 	vmrs	APSR_nzcv, fpscr
    8470:	da000002 	ble	8480 <_Z9send_dataf+0x4c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:66
        msg[0] = 'd';
    8474:	e3a03064 	mov	r3, #100	; 0x64
    8478:	e54b3010 	strb	r3, [fp, #-16]
    847c:	ea000015 	b	84d8 <_Z9send_dataf+0xa4>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:69
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
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:70
        if (next_predict < LOWER_BOUND || next_predict > UPPER_BOUND) {
    849c:	ed5b7a02 	vldr	s15, [fp, #-8]
    84a0:	ed9f7a1d 	vldr	s14, [pc, #116]	; 851c <_Z9send_dataf+0xe8>
    84a4:	eef47ac7 	vcmpe.f32	s15, s14
    84a8:	eef1fa10 	vmrs	APSR_nzcv, fpscr
    84ac:	4a000004 	bmi	84c4 <_Z9send_dataf+0x90>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:70 (discriminator 1)
    84b0:	ed5b7a02 	vldr	s15, [fp, #-8]
    84b4:	ed9f7a19 	vldr	s14, [pc, #100]	; 8520 <_Z9send_dataf+0xec>
    84b8:	eef47ac7 	vcmpe.f32	s15, s14
    84bc:	eef1fa10 	vmrs	APSR_nzcv, fpscr
    84c0:	da000002 	ble	84d0 <_Z9send_dataf+0x9c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:71
            msg[0] = 't';
    84c4:	e3a03074 	mov	r3, #116	; 0x74
    84c8:	e54b3010 	strb	r3, [fp, #-16]
    84cc:	ea000001 	b	84d8 <_Z9send_dataf+0xa4>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:74
        }
        else {
            msg[0] = 'v';
    84d0:	e3a03076 	mov	r3, #118	; 0x76
    84d4:	e54b3010 	strb	r3, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:77
        }
    }
    memcpy(&value, msg + 1, 4);
    84d8:	e24b3010 	sub	r3, fp, #16
    84dc:	e2833001 	add	r3, r3, #1
    84e0:	e24b0018 	sub	r0, fp, #24
    84e4:	e3a02004 	mov	r2, #4
    84e8:	e1a01003 	mov	r1, r3
    84ec:	eb000408 	bl	9514 <_Z6memcpyPKvPvi>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:78
    msg[5] = '\0';
    84f0:	e3a03000 	mov	r3, #0
    84f4:	e54b300b 	strb	r3, [fp, #-11]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:79
    write(slave, msg, 6);
    84f8:	e59f302c 	ldr	r3, [pc, #44]	; 852c <_Z9send_dataf+0xf8>
    84fc:	e5933000 	ldr	r3, [r3]
    8500:	e24b1010 	sub	r1, fp, #16
    8504:	e3a02006 	mov	r2, #6
    8508:	e1a00003 	mov	r0, r3
    850c:	eb000178 	bl	8af4 <_Z5writejPKcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:80
}
    8510:	e320f000 	nop	{0}
    8514:	e24bd004 	sub	sp, fp, #4
    8518:	e8bd8800 	pop	{fp, pc}
    851c:	40600000 	rsbmi	r0, r0, r0
    8520:	41300000 	teqmi	r0, r0
    8524:	bf800000 	svclt	0x00800000
    8528:	000099e8 	andeq	r9, r0, r8, ror #19
    852c:	000099f0 	strdeq	r9, [r0], -r0

00008530 <_Z10send_valuef>:
_Z10send_valuef():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:82

void send_value(const float value) {
    8530:	e92d4800 	push	{fp, lr}
    8534:	e28db004 	add	fp, sp, #4
    8538:	e24dd030 	sub	sp, sp, #48	; 0x30
    853c:	ed0b0a0c 	vstr	s0, [fp, #-48]	; 0xffffffd0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:84
    char pom[5], buff[32];
    bzero(pom, 5);
    8540:	e24b300c 	sub	r3, fp, #12
    8544:	e3a01005 	mov	r1, #5
    8548:	e1a00003 	mov	r0, r3
    854c:	eb0003d6 	bl	94ac <_Z5bzeroPvi>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:85
    bzero(buff, 32);
    8550:	e24b302c 	sub	r3, fp, #44	; 0x2c
    8554:	e3a01020 	mov	r1, #32
    8558:	e1a00003 	mov	r0, r3
    855c:	eb0003d2 	bl	94ac <_Z5bzeroPvi>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:86
    strncpy(buff, "Sending: ", 15);
    8560:	e24b302c 	sub	r3, fp, #44	; 0x2c
    8564:	e3a0200f 	mov	r2, #15
    8568:	e59f105c 	ldr	r1, [pc, #92]	; 85cc <_Z10send_valuef+0x9c>
    856c:	e1a00003 	mov	r0, r3
    8570:	eb00035d 	bl	92ec <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:87
    ftoa(value, pom, 2);
    8574:	e24b300c 	sub	r3, fp, #12
    8578:	e3a01002 	mov	r1, #2
    857c:	e1a00003 	mov	r0, r3
    8580:	ed1b0a0c 	vldr	s0, [fp, #-48]	; 0xffffffd0
    8584:	eb0002b3 	bl	9058 <_Z4ftoafPcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:88
    concat(buff, pom);
    8588:	e24b200c 	sub	r2, fp, #12
    858c:	e24b302c 	sub	r3, fp, #44	; 0x2c
    8590:	e1a01002 	mov	r1, r2
    8594:	e1a00003 	mov	r0, r3
    8598:	eb0003fd 	bl	9594 <_Z6concatPcPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:89
    concat(buff, "\n");
    859c:	e24b302c 	sub	r3, fp, #44	; 0x2c
    85a0:	e59f1028 	ldr	r1, [pc, #40]	; 85d0 <_Z10send_valuef+0xa0>
    85a4:	e1a00003 	mov	r0, r3
    85a8:	eb0003f9 	bl	9594 <_Z6concatPcPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:90
    log(buff);
    85ac:	e24b302c 	sub	r3, fp, #44	; 0x2c
    85b0:	e1a00003 	mov	r0, r3
    85b4:	ebffff47 	bl	82d8 <_Z3logPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:91
    send_data(value);
    85b8:	ed1b0a0c 	vldr	s0, [fp, #-48]	; 0xffffffd0
    85bc:	ebffff9c 	bl	8434 <_Z9send_dataf>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:92
}
    85c0:	e320f000 	nop	{0}
    85c4:	e24bd004 	sub	sp, fp, #4
    85c8:	e8bd8800 	pop	{fp, pc}
    85cc:	000098d4 	ldrdeq	r9, [r0], -r4
    85d0:	000098e0 	andeq	r9, r0, r0, ror #17

000085d4 <_Z11decide_role9CI2C_ModePc>:
_Z11decide_role9CI2C_ModePc():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:95

CI2C_Mode decide_role(CI2C_Mode my_role, char* other_role_buff)
{
    85d4:	e92d4800 	push	{fp, lr}
    85d8:	e28db004 	add	fp, sp, #4
    85dc:	e24dd010 	sub	sp, sp, #16
    85e0:	e50b0010 	str	r0, [fp, #-16]
    85e4:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:96
    CI2C_Mode other_role = CI2C_Mode::Undefined;
    85e8:	e3a03002 	mov	r3, #2
    85ec:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:97
    if (strncmp(other_role_buff, "mst", 3) == 0)
    85f0:	e3a02003 	mov	r2, #3
    85f4:	e59f10c4 	ldr	r1, [pc, #196]	; 86c0 <_Z11decide_role9CI2C_ModePc+0xec>
    85f8:	e51b0014 	ldr	r0, [fp, #-20]	; 0xffffffec
    85fc:	eb00036a 	bl	93ac <_Z7strncmpPKcS0_i>
    8600:	e1a03000 	mov	r3, r0
    8604:	e3530000 	cmp	r3, #0
    8608:	03a03001 	moveq	r3, #1
    860c:	13a03000 	movne	r3, #0
    8610:	e6ef3073 	uxtb	r3, r3
    8614:	e3530000 	cmp	r3, #0
    8618:	0a000002 	beq	8628 <_Z11decide_role9CI2C_ModePc+0x54>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:99
    {
        other_role = CI2C_Mode::Master;
    861c:	e3a03000 	mov	r3, #0
    8620:	e50b3008 	str	r3, [fp, #-8]
    8624:	ea00000c 	b	865c <_Z11decide_role9CI2C_ModePc+0x88>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:101
    }
    else if (strncmp(other_role_buff, "slv", 3) == 0)
    8628:	e3a02003 	mov	r2, #3
    862c:	e59f1090 	ldr	r1, [pc, #144]	; 86c4 <_Z11decide_role9CI2C_ModePc+0xf0>
    8630:	e51b0014 	ldr	r0, [fp, #-20]	; 0xffffffec
    8634:	eb00035c 	bl	93ac <_Z7strncmpPKcS0_i>
    8638:	e1a03000 	mov	r3, r0
    863c:	e3530000 	cmp	r3, #0
    8640:	03a03001 	moveq	r3, #1
    8644:	13a03000 	movne	r3, #0
    8648:	e6ef3073 	uxtb	r3, r3
    864c:	e3530000 	cmp	r3, #0
    8650:	0a000001 	beq	865c <_Z11decide_role9CI2C_ModePc+0x88>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:103
    {
        other_role = CI2C_Mode::Slave;
    8654:	e3a03001 	mov	r3, #1
    8658:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:106
    }

    if (my_role == CI2C_Mode::Undefined)
    865c:	e51b3010 	ldr	r3, [fp, #-16]
    8660:	e3530002 	cmp	r3, #2
    8664:	1a000009 	bne	8690 <_Z11decide_role9CI2C_ModePc+0xbc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:108
    {
        if (other_role == CI2C_Mode::Master)
    8668:	e51b3008 	ldr	r3, [fp, #-8]
    866c:	e3530000 	cmp	r3, #0
    8670:	1a000001 	bne	867c <_Z11decide_role9CI2C_ModePc+0xa8>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:110
        {
            return CI2C_Mode::Slave;
    8674:	e3a03001 	mov	r3, #1
    8678:	ea00000d 	b	86b4 <_Z11decide_role9CI2C_ModePc+0xe0>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:112
        }
        else if (other_role == CI2C_Mode::Slave)
    867c:	e51b3008 	ldr	r3, [fp, #-8]
    8680:	e3530001 	cmp	r3, #1
    8684:	1a000009 	bne	86b0 <_Z11decide_role9CI2C_ModePc+0xdc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:114
        {
            return CI2C_Mode::Master;
    8688:	e3a03000 	mov	r3, #0
    868c:	ea000008 	b	86b4 <_Z11decide_role9CI2C_ModePc+0xe0>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:118
        }
    }
    else {
        if (my_role == other_role)
    8690:	e51b2010 	ldr	r2, [fp, #-16]
    8694:	e51b3008 	ldr	r3, [fp, #-8]
    8698:	e1520003 	cmp	r2, r3
    869c:	1a000003 	bne	86b0 <_Z11decide_role9CI2C_ModePc+0xdc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:120
        {
            log("Desired roles are the same\n");
    86a0:	e59f0020 	ldr	r0, [pc, #32]	; 86c8 <_Z11decide_role9CI2C_ModePc+0xf4>
    86a4:	ebffff0b 	bl	82d8 <_Z3logPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:124
            if (ADDRESS < TARGET_ADDRESS)
                return CI2C_Mode::Master;
            else
                return CI2C_Mode::Slave;
    86a8:	e3a03001 	mov	r3, #1
    86ac:	ea000000 	b	86b4 <_Z11decide_role9CI2C_ModePc+0xe0>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:127
        }
    }
    return my_role;
    86b0:	e51b3010 	ldr	r3, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:128
}
    86b4:	e1a00003 	mov	r0, r3
    86b8:	e24bd004 	sub	sp, fp, #4
    86bc:	e8bd8800 	pop	{fp, pc}
    86c0:	000098e4 	andeq	r9, r0, r4, ror #17
    86c4:	000098e8 	andeq	r9, r0, r8, ror #17
    86c8:	000098ec 	andeq	r9, r0, ip, ror #17

000086cc <_Z9set_roles9CI2C_Mode>:
_Z9set_roles9CI2C_Mode():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:131

bool set_roles(CI2C_Mode desired_role)
{
    86cc:	e92d4800 	push	{fp, lr}
    86d0:	e28db004 	add	fp, sp, #4
    86d4:	e24dd050 	sub	sp, sp, #80	; 0x50
    86d8:	e50b0050 	str	r0, [fp, #-80]	; 0xffffffb0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:133
    char role[4], buff[32], log_msg[32];
    bzero(role, 4);
    86dc:	e24b3008 	sub	r3, fp, #8
    86e0:	e3a01004 	mov	r1, #4
    86e4:	e1a00003 	mov	r0, r3
    86e8:	eb00036f 	bl	94ac <_Z5bzeroPvi>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:134
    bzero(buff, 32);
    86ec:	e24b3028 	sub	r3, fp, #40	; 0x28
    86f0:	e3a01020 	mov	r1, #32
    86f4:	e1a00003 	mov	r0, r3
    86f8:	eb00036b 	bl	94ac <_Z5bzeroPvi>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:135
    bzero(log_msg, 32);
    86fc:	e24b3048 	sub	r3, fp, #72	; 0x48
    8700:	e3a01020 	mov	r1, #32
    8704:	e1a00003 	mov	r0, r3
    8708:	eb000367 	bl	94ac <_Z5bzeroPvi>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:136
    switch (desired_role)
    870c:	e51b3050 	ldr	r3, [fp, #-80]	; 0xffffffb0
    8710:	e3530000 	cmp	r3, #0
    8714:	0a000003 	beq	8728 <_Z9set_roles9CI2C_Mode+0x5c>
    8718:	e51b3050 	ldr	r3, [fp, #-80]	; 0xffffffb0
    871c:	e3530001 	cmp	r3, #1
    8720:	0a000006 	beq	8740 <_Z9set_roles9CI2C_Mode+0x74>
    8724:	ea00000b 	b	8758 <_Z9set_roles9CI2C_Mode+0x8c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:139
    {
    case CI2C_Mode::Master:
        strncpy(role, "mst", 3);
    8728:	e24b3008 	sub	r3, fp, #8
    872c:	e3a02003 	mov	r2, #3
    8730:	e59f1148 	ldr	r1, [pc, #328]	; 8880 <_Z9set_roles9CI2C_Mode+0x1b4>
    8734:	e1a00003 	mov	r0, r3
    8738:	eb0002eb 	bl	92ec <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:140
        break;
    873c:	ea00000b 	b	8770 <_Z9set_roles9CI2C_Mode+0xa4>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:142
    case CI2C_Mode::Slave:
        strncpy(role, "slv", 3);
    8740:	e24b3008 	sub	r3, fp, #8
    8744:	e3a02003 	mov	r2, #3
    8748:	e59f1134 	ldr	r1, [pc, #308]	; 8884 <_Z9set_roles9CI2C_Mode+0x1b8>
    874c:	e1a00003 	mov	r0, r3
    8750:	eb0002e5 	bl	92ec <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:143
        break;
    8754:	ea000005 	b	8770 <_Z9set_roles9CI2C_Mode+0xa4>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:145
    default:
        strncpy(role, "slv", 3);
    8758:	e24b3008 	sub	r3, fp, #8
    875c:	e3a02003 	mov	r2, #3
    8760:	e59f111c 	ldr	r1, [pc, #284]	; 8884 <_Z9set_roles9CI2C_Mode+0x1b8>
    8764:	e1a00003 	mov	r0, r3
    8768:	eb0002df 	bl	92ec <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:146
        break;
    876c:	e320f000 	nop	{0}
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:149
    }

    write(slave, role, 4);
    8770:	e59f3110 	ldr	r3, [pc, #272]	; 8888 <_Z9set_roles9CI2C_Mode+0x1bc>
    8774:	e5933000 	ldr	r3, [r3]
    8778:	e24b1008 	sub	r1, fp, #8
    877c:	e3a02004 	mov	r2, #4
    8780:	e1a00003 	mov	r0, r3
    8784:	eb0000da 	bl	8af4 <_Z5writejPKcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:150
    while (strlen(buff) == 0) {
    8788:	e24b3028 	sub	r3, fp, #40	; 0x28
    878c:	e1a00003 	mov	r0, r3
    8790:	eb000330 	bl	9458 <_Z6strlenPKc>
    8794:	e1a03000 	mov	r3, r0
    8798:	e3530000 	cmp	r3, #0
    879c:	03a03001 	moveq	r3, #1
    87a0:	13a03000 	movne	r3, #0
    87a4:	e6ef3073 	uxtb	r3, r3
    87a8:	e3530000 	cmp	r3, #0
    87ac:	0a000009 	beq	87d8 <_Z9set_roles9CI2C_Mode+0x10c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:151
        read(slave, buff, 4);
    87b0:	e59f30d0 	ldr	r3, [pc, #208]	; 8888 <_Z9set_roles9CI2C_Mode+0x1bc>
    87b4:	e5933000 	ldr	r3, [r3]
    87b8:	e24b1028 	sub	r1, fp, #40	; 0x28
    87bc:	e3a02004 	mov	r2, #4
    87c0:	e1a00003 	mov	r0, r3
    87c4:	eb0000b6 	bl	8aa4 <_Z4readjPcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:152
        sleep(0x100);
    87c8:	e3e01001 	mvn	r1, #1
    87cc:	e3a00c01 	mov	r0, #256	; 0x100
    87d0:	eb00011f 	bl	8c54 <_Z5sleepjj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:150
    while (strlen(buff) == 0) {
    87d4:	eaffffeb 	b	8788 <_Z9set_roles9CI2C_Mode+0xbc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:155
    }

    agreed_role = decide_role(desired_role, buff);
    87d8:	e24b3028 	sub	r3, fp, #40	; 0x28
    87dc:	e1a01003 	mov	r1, r3
    87e0:	e51b0050 	ldr	r0, [fp, #-80]	; 0xffffffb0
    87e4:	ebffff7a 	bl	85d4 <_Z11decide_role9CI2C_ModePc>
    87e8:	e1a03000 	mov	r3, r0
    87ec:	e59f2098 	ldr	r2, [pc, #152]	; 888c <_Z9set_roles9CI2C_Mode+0x1c0>
    87f0:	e5823000 	str	r3, [r2]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:156
    strncpy(log_msg, "Roles set. I am ", 16);
    87f4:	e24b3048 	sub	r3, fp, #72	; 0x48
    87f8:	e3a02010 	mov	r2, #16
    87fc:	e59f108c 	ldr	r1, [pc, #140]	; 8890 <_Z9set_roles9CI2C_Mode+0x1c4>
    8800:	e1a00003 	mov	r0, r3
    8804:	eb0002b8 	bl	92ec <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:157
    switch (agreed_role)
    8808:	e59f307c 	ldr	r3, [pc, #124]	; 888c <_Z9set_roles9CI2C_Mode+0x1c0>
    880c:	e5933000 	ldr	r3, [r3]
    8810:	e3530000 	cmp	r3, #0
    8814:	0a000002 	beq	8824 <_Z9set_roles9CI2C_Mode+0x158>
    8818:	e3530001 	cmp	r3, #1
    881c:	0a000005 	beq	8838 <_Z9set_roles9CI2C_Mode+0x16c>
    8820:	ea000009 	b	884c <_Z9set_roles9CI2C_Mode+0x180>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:160
    {
    case CI2C_Mode::Master:
        concat(log_msg, "Master\n");
    8824:	e24b3048 	sub	r3, fp, #72	; 0x48
    8828:	e59f1064 	ldr	r1, [pc, #100]	; 8894 <_Z9set_roles9CI2C_Mode+0x1c8>
    882c:	e1a00003 	mov	r0, r3
    8830:	eb000357 	bl	9594 <_Z6concatPcPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:161
        break;
    8834:	ea000004 	b	884c <_Z9set_roles9CI2C_Mode+0x180>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:163
    case CI2C_Mode::Slave:
        concat(log_msg, "Slave\n");
    8838:	e24b3048 	sub	r3, fp, #72	; 0x48
    883c:	e59f1054 	ldr	r1, [pc, #84]	; 8898 <_Z9set_roles9CI2C_Mode+0x1cc>
    8840:	e1a00003 	mov	r0, r3
    8844:	eb000352 	bl	9594 <_Z6concatPcPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:164
        break;
    8848:	e320f000 	nop	{0}
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:166
    }
    log(log_msg);
    884c:	e24b3048 	sub	r3, fp, #72	; 0x48
    8850:	e1a00003 	mov	r0, r3
    8854:	ebfffe9f 	bl	82d8 <_Z3logPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:167
    return agreed_role == desired_role;
    8858:	e59f302c 	ldr	r3, [pc, #44]	; 888c <_Z9set_roles9CI2C_Mode+0x1c0>
    885c:	e5933000 	ldr	r3, [r3]
    8860:	e51b2050 	ldr	r2, [fp, #-80]	; 0xffffffb0
    8864:	e1520003 	cmp	r2, r3
    8868:	03a03001 	moveq	r3, #1
    886c:	13a03000 	movne	r3, #0
    8870:	e6ef3073 	uxtb	r3, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:168
}
    8874:	e1a00003 	mov	r0, r3
    8878:	e24bd004 	sub	sp, fp, #4
    887c:	e8bd8800 	pop	{fp, pc}
    8880:	000098e4 	andeq	r9, r0, r4, ror #17
    8884:	000098e8 	andeq	r9, r0, r8, ror #17
    8888:	000099f0 	strdeq	r9, [r0], -r0
    888c:	000099e4 	andeq	r9, r0, r4, ror #19
    8890:	00009908 	andeq	r9, r0, r8, lsl #18
    8894:	0000991c 	andeq	r9, r0, ip, lsl r9
    8898:	00009924 	andeq	r9, r0, r4, lsr #18

0000889c <main>:
main():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:171

int main(int argc, char** argv)
{
    889c:	e92d4800 	push	{fp, lr}
    88a0:	e28db004 	add	fp, sp, #4
    88a4:	e24dd030 	sub	sp, sp, #48	; 0x30
    88a8:	e50b0030 	str	r0, [fp, #-48]	; 0xffffffd0
    88ac:	e50b1034 	str	r1, [fp, #-52]	; 0xffffffcc
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:172
    uint32_t counter = 0;
    88b0:	e3a03000 	mov	r3, #0
    88b4:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:174
    char buff[32];
    bzero(buff, 32);
    88b8:	e24b3028 	sub	r3, fp, #40	; 0x28
    88bc:	e3a01020 	mov	r1, #32
    88c0:	e1a00003 	mov	r0, r3
    88c4:	eb0002f8 	bl	94ac <_Z5bzeroPvi>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:176

    log_fd = pipe("log", 128);
    88c8:	e3a01080 	mov	r1, #128	; 0x80
    88cc:	e59f00f4 	ldr	r0, [pc, #244]	; 89c8 <main+0x12c>
    88d0:	eb000130 	bl	8d98 <_Z4pipePKcj>
    88d4:	e1a03000 	mov	r3, r0
    88d8:	e59f20ec 	ldr	r2, [pc, #236]	; 89cc <main+0x130>
    88dc:	e5823000 	str	r3, [r2]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:178

    log("Slave task started\n");
    88e0:	e59f00e8 	ldr	r0, [pc, #232]	; 89d0 <main+0x134>
    88e4:	ebfffe7b 	bl	82d8 <_Z3logPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:181

    // start i2c connection
    slave = open("DEV:i2c/2", NFile_Open_Mode::Read_Write);
    88e8:	e3a01002 	mov	r1, #2
    88ec:	e59f00e0 	ldr	r0, [pc, #224]	; 89d4 <main+0x138>
    88f0:	eb00005a 	bl	8a60 <_Z4openPKc15NFile_Open_Mode>
    88f4:	e1a03000 	mov	r3, r0
    88f8:	e59f20d8 	ldr	r2, [pc, #216]	; 89d8 <main+0x13c>
    88fc:	e5823000 	str	r3, [r2]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:182
    if (slave == Invalid_Handle) {
    8900:	e59f30d0 	ldr	r3, [pc, #208]	; 89d8 <main+0x13c>
    8904:	e5933000 	ldr	r3, [r3]
    8908:	e3730001 	cmn	r3, #1
    890c:	1a000003 	bne	8920 <main+0x84>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:183
        log("Error opening I2C slave connection\n");
    8910:	e59f00c4 	ldr	r0, [pc, #196]	; 89dc <main+0x140>
    8914:	ebfffe6f 	bl	82d8 <_Z3logPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:184
        return 1;
    8918:	e3a03001 	mov	r3, #1
    891c:	ea000026 	b	89bc <main+0x120>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:188
    }
    // set addresses
    TI2C_IOCtl_Params params;
    params.address = ADDRESS;
    8920:	e3a03002 	mov	r3, #2
    8924:	e54b302c 	strb	r3, [fp, #-44]	; 0xffffffd4
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:189
    params.targetAdress = TARGET_ADDRESS;
    8928:	e3a03001 	mov	r3, #1
    892c:	e54b302b 	strb	r3, [fp, #-43]	; 0xffffffd5
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:190
    ioctl(slave, NIOCtl_Operation::Set_Params, &params);
    8930:	e59f30a0 	ldr	r3, [pc, #160]	; 89d8 <main+0x13c>
    8934:	e5933000 	ldr	r3, [r3]
    8938:	e24b202c 	sub	r2, fp, #44	; 0x2c
    893c:	e3a01001 	mov	r1, #1
    8940:	e1a00003 	mov	r0, r3
    8944:	eb000089 	bl	8b70 <_Z5ioctlj16NIOCtl_OperationPv>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:191
    log("I2C connection slave started...\n");
    8948:	e59f0090 	ldr	r0, [pc, #144]	; 89e0 <main+0x144>
    894c:	ebfffe61 	bl	82d8 <_Z3logPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:193

    sleep(0x100);
    8950:	e3e01001 	mvn	r1, #1
    8954:	e3a00c01 	mov	r0, #256	; 0x100
    8958:	eb0000bd 	bl	8c54 <_Z5sleepjj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:194
    set_roles(DESIRED_ROLE);
    895c:	e3a00001 	mov	r0, #1
    8960:	ebffff59 	bl	86cc <_Z9set_roles9CI2C_Mode>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:198 (discriminator 1)

    for (;;) {
        // log("trying to send random value\n");
        send_value(random_values[counter]);
    8964:	e59f2078 	ldr	r2, [pc, #120]	; 89e4 <main+0x148>
    8968:	e51b3008 	ldr	r3, [fp, #-8]
    896c:	e1a03103 	lsl	r3, r3, #2
    8970:	e0823003 	add	r3, r2, r3
    8974:	edd37a00 	vldr	s15, [r3]
    8978:	eeb00a67 	vmov.f32	s0, s15
    897c:	ebfffeeb 	bl	8530 <_Z10send_valuef>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:199 (discriminator 1)
        prev_value = random_values[counter];
    8980:	e59f205c 	ldr	r2, [pc, #92]	; 89e4 <main+0x148>
    8984:	e51b3008 	ldr	r3, [fp, #-8]
    8988:	e1a03103 	lsl	r3, r3, #2
    898c:	e0823003 	add	r3, r2, r3
    8990:	e5933000 	ldr	r3, [r3]
    8994:	e59f204c 	ldr	r2, [pc, #76]	; 89e8 <main+0x14c>
    8998:	e5823000 	str	r3, [r2]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:200 (discriminator 1)
        counter = (counter + 1) % random_values_len;
    899c:	e51b3008 	ldr	r3, [fp, #-8]
    89a0:	e2833001 	add	r3, r3, #1
    89a4:	e2033007 	and	r3, r3, #7
    89a8:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:202 (discriminator 1)
        // log("Data sent from slave\n");
        sleep(0x15000);
    89ac:	e3e01001 	mvn	r1, #1
    89b0:	e3a00a15 	mov	r0, #86016	; 0x15000
    89b4:	eb0000a6 	bl	8c54 <_Z5sleepjj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:198 (discriminator 1)
        send_value(random_values[counter]);
    89b8:	eaffffe9 	b	8964 <main+0xc8>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:210 (discriminator 1)
    close(slave);
    log("Open files closed in slave\n");
    close(log_fd);

    return 0;
}
    89bc:	e1a00003 	mov	r0, r3
    89c0:	e24bd004 	sub	sp, fp, #4
    89c4:	e8bd8800 	pop	{fp, pc}
    89c8:	0000992c 	andeq	r9, r0, ip, lsr #18
    89cc:	000099ec 	andeq	r9, r0, ip, ror #19
    89d0:	00009930 	andeq	r9, r0, r0, lsr r9
    89d4:	00009944 	andeq	r9, r0, r4, asr #18
    89d8:	000099f0 	strdeq	r9, [r0], -r0
    89dc:	00009950 	andeq	r9, r0, r0, asr r9
    89e0:	00009974 	andeq	r9, r0, r4, ror r9
    89e4:	00009894 	muleq	r0, r4, r8
    89e8:	000099e8 	andeq	r9, r0, r8, ror #19

000089ec <_Z6getpidv>:
_Z6getpidv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:5
#include <stdfile.h>
#include <stdstring.h>

uint32_t getpid()
{
    89ec:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    89f0:	e28db000 	add	fp, sp, #0
    89f4:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:8
    uint32_t pid;

    asm volatile("swi 0");
    89f8:	ef000000 	svc	0x00000000
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:9
    asm volatile("mov %0, r0" : "=r" (pid));
    89fc:	e1a03000 	mov	r3, r0
    8a00:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:11

    return pid;
    8a04:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:12
}
    8a08:	e1a00003 	mov	r0, r3
    8a0c:	e28bd000 	add	sp, fp, #0
    8a10:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8a14:	e12fff1e 	bx	lr

00008a18 <_Z9terminatei>:
_Z9terminatei():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:15

void terminate(int exitcode)
{
    8a18:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8a1c:	e28db000 	add	fp, sp, #0
    8a20:	e24dd00c 	sub	sp, sp, #12
    8a24:	e50b0008 	str	r0, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:16
    asm volatile("mov r0, %0" : : "r" (exitcode));
    8a28:	e51b3008 	ldr	r3, [fp, #-8]
    8a2c:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:17
    asm volatile("swi 1");
    8a30:	ef000001 	svc	0x00000001
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:18
}
    8a34:	e320f000 	nop	{0}
    8a38:	e28bd000 	add	sp, fp, #0
    8a3c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8a40:	e12fff1e 	bx	lr

00008a44 <_Z11sched_yieldv>:
_Z11sched_yieldv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:21

void sched_yield()
{
    8a44:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8a48:	e28db000 	add	fp, sp, #0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:22
    asm volatile("swi 2");
    8a4c:	ef000002 	svc	0x00000002
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:23
}
    8a50:	e320f000 	nop	{0}
    8a54:	e28bd000 	add	sp, fp, #0
    8a58:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8a5c:	e12fff1e 	bx	lr

00008a60 <_Z4openPKc15NFile_Open_Mode>:
_Z4openPKc15NFile_Open_Mode():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:26

uint32_t open(const char* filename, NFile_Open_Mode mode)
{
    8a60:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8a64:	e28db000 	add	fp, sp, #0
    8a68:	e24dd014 	sub	sp, sp, #20
    8a6c:	e50b0010 	str	r0, [fp, #-16]
    8a70:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:29
    uint32_t file;

    asm volatile("mov r0, %0" : : "r" (filename));
    8a74:	e51b3010 	ldr	r3, [fp, #-16]
    8a78:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:30
    asm volatile("mov r1, %0" : : "r" (mode));
    8a7c:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8a80:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:31
    asm volatile("swi 64");
    8a84:	ef000040 	svc	0x00000040
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:32
    asm volatile("mov %0, r0" : "=r" (file));
    8a88:	e1a03000 	mov	r3, r0
    8a8c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:33
    return file;
    8a90:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:34
}
    8a94:	e1a00003 	mov	r0, r3
    8a98:	e28bd000 	add	sp, fp, #0
    8a9c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8aa0:	e12fff1e 	bx	lr

00008aa4 <_Z4readjPcj>:
_Z4readjPcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:37

uint32_t read(uint32_t file, char* const buffer, uint32_t size)
{
    8aa4:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8aa8:	e28db000 	add	fp, sp, #0
    8aac:	e24dd01c 	sub	sp, sp, #28
    8ab0:	e50b0010 	str	r0, [fp, #-16]
    8ab4:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8ab8:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:40
    uint32_t rdnum;

    asm volatile("mov r0, %0" : : "r" (file));
    8abc:	e51b3010 	ldr	r3, [fp, #-16]
    8ac0:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:41
    asm volatile("mov r1, %0" : : "r" (buffer));
    8ac4:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8ac8:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:42
    asm volatile("mov r2, %0" : : "r" (size));
    8acc:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8ad0:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:43
    asm volatile("swi 65");
    8ad4:	ef000041 	svc	0x00000041
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:44
    asm volatile("mov %0, r0" : "=r" (rdnum));
    8ad8:	e1a03000 	mov	r3, r0
    8adc:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:46

    return rdnum;
    8ae0:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:47
}
    8ae4:	e1a00003 	mov	r0, r3
    8ae8:	e28bd000 	add	sp, fp, #0
    8aec:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8af0:	e12fff1e 	bx	lr

00008af4 <_Z5writejPKcj>:
_Z5writejPKcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:50

uint32_t write(uint32_t file, const char* buffer, uint32_t size)
{
    8af4:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8af8:	e28db000 	add	fp, sp, #0
    8afc:	e24dd01c 	sub	sp, sp, #28
    8b00:	e50b0010 	str	r0, [fp, #-16]
    8b04:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8b08:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:53
    uint32_t wrnum;

    asm volatile("mov r0, %0" : : "r" (file));
    8b0c:	e51b3010 	ldr	r3, [fp, #-16]
    8b10:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:54
    asm volatile("mov r1, %0" : : "r" (buffer));
    8b14:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8b18:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:55
    asm volatile("mov r2, %0" : : "r" (size));
    8b1c:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8b20:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:56
    asm volatile("swi 66");
    8b24:	ef000042 	svc	0x00000042
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:57
    asm volatile("mov %0, r0" : "=r" (wrnum));
    8b28:	e1a03000 	mov	r3, r0
    8b2c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:59

    return wrnum;
    8b30:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:60
}
    8b34:	e1a00003 	mov	r0, r3
    8b38:	e28bd000 	add	sp, fp, #0
    8b3c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8b40:	e12fff1e 	bx	lr

00008b44 <_Z5closej>:
_Z5closej():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:63

void close(uint32_t file)
{
    8b44:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8b48:	e28db000 	add	fp, sp, #0
    8b4c:	e24dd00c 	sub	sp, sp, #12
    8b50:	e50b0008 	str	r0, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:64
    asm volatile("mov r0, %0" : : "r" (file));
    8b54:	e51b3008 	ldr	r3, [fp, #-8]
    8b58:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:65
    asm volatile("swi 67");
    8b5c:	ef000043 	svc	0x00000043
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:66
}
    8b60:	e320f000 	nop	{0}
    8b64:	e28bd000 	add	sp, fp, #0
    8b68:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8b6c:	e12fff1e 	bx	lr

00008b70 <_Z5ioctlj16NIOCtl_OperationPv>:
_Z5ioctlj16NIOCtl_OperationPv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:69

uint32_t ioctl(uint32_t file, NIOCtl_Operation operation, void* param)
{
    8b70:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8b74:	e28db000 	add	fp, sp, #0
    8b78:	e24dd01c 	sub	sp, sp, #28
    8b7c:	e50b0010 	str	r0, [fp, #-16]
    8b80:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8b84:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:72
    uint32_t retcode;

    asm volatile("mov r0, %0" : : "r" (file));
    8b88:	e51b3010 	ldr	r3, [fp, #-16]
    8b8c:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:73
    asm volatile("mov r1, %0" : : "r" (operation));
    8b90:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8b94:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:74
    asm volatile("mov r2, %0" : : "r" (param));
    8b98:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8b9c:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:75
    asm volatile("swi 68");
    8ba0:	ef000044 	svc	0x00000044
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:76
    asm volatile("mov %0, r0" : "=r" (retcode));
    8ba4:	e1a03000 	mov	r3, r0
    8ba8:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:78

    return retcode;
    8bac:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:79
}
    8bb0:	e1a00003 	mov	r0, r3
    8bb4:	e28bd000 	add	sp, fp, #0
    8bb8:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8bbc:	e12fff1e 	bx	lr

00008bc0 <_Z6notifyjj>:
_Z6notifyjj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:82

uint32_t notify(uint32_t file, uint32_t count)
{
    8bc0:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8bc4:	e28db000 	add	fp, sp, #0
    8bc8:	e24dd014 	sub	sp, sp, #20
    8bcc:	e50b0010 	str	r0, [fp, #-16]
    8bd0:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:85
    uint32_t retcnt;

    asm volatile("mov r0, %0" : : "r" (file));
    8bd4:	e51b3010 	ldr	r3, [fp, #-16]
    8bd8:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:86
    asm volatile("mov r1, %0" : : "r" (count));
    8bdc:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8be0:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:87
    asm volatile("swi 69");
    8be4:	ef000045 	svc	0x00000045
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:88
    asm volatile("mov %0, r0" : "=r" (retcnt));
    8be8:	e1a03000 	mov	r3, r0
    8bec:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:90

    return retcnt;
    8bf0:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:91
}
    8bf4:	e1a00003 	mov	r0, r3
    8bf8:	e28bd000 	add	sp, fp, #0
    8bfc:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8c00:	e12fff1e 	bx	lr

00008c04 <_Z4waitjjj>:
_Z4waitjjj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:94

NSWI_Result_Code wait(uint32_t file, uint32_t count, uint32_t notified_deadline)
{
    8c04:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8c08:	e28db000 	add	fp, sp, #0
    8c0c:	e24dd01c 	sub	sp, sp, #28
    8c10:	e50b0010 	str	r0, [fp, #-16]
    8c14:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8c18:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:97
    NSWI_Result_Code retcode;

    asm volatile("mov r0, %0" : : "r" (file));
    8c1c:	e51b3010 	ldr	r3, [fp, #-16]
    8c20:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:98
    asm volatile("mov r1, %0" : : "r" (count));
    8c24:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8c28:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:99
    asm volatile("mov r2, %0" : : "r" (notified_deadline));
    8c2c:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8c30:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:100
    asm volatile("swi 70");
    8c34:	ef000046 	svc	0x00000046
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:101
    asm volatile("mov %0, r0" : "=r" (retcode));
    8c38:	e1a03000 	mov	r3, r0
    8c3c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:103

    return retcode;
    8c40:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:104
}
    8c44:	e1a00003 	mov	r0, r3
    8c48:	e28bd000 	add	sp, fp, #0
    8c4c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8c50:	e12fff1e 	bx	lr

00008c54 <_Z5sleepjj>:
_Z5sleepjj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:107

bool sleep(uint32_t ticks, uint32_t notified_deadline)
{
    8c54:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8c58:	e28db000 	add	fp, sp, #0
    8c5c:	e24dd014 	sub	sp, sp, #20
    8c60:	e50b0010 	str	r0, [fp, #-16]
    8c64:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:110
    uint32_t retcode;

    asm volatile("mov r0, %0" : : "r" (ticks));
    8c68:	e51b3010 	ldr	r3, [fp, #-16]
    8c6c:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:111
    asm volatile("mov r1, %0" : : "r" (notified_deadline));
    8c70:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8c74:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:112
    asm volatile("swi 3");
    8c78:	ef000003 	svc	0x00000003
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:113
    asm volatile("mov %0, r0" : "=r" (retcode));
    8c7c:	e1a03000 	mov	r3, r0
    8c80:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:115

    return retcode;
    8c84:	e51b3008 	ldr	r3, [fp, #-8]
    8c88:	e3530000 	cmp	r3, #0
    8c8c:	13a03001 	movne	r3, #1
    8c90:	03a03000 	moveq	r3, #0
    8c94:	e6ef3073 	uxtb	r3, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:116
}
    8c98:	e1a00003 	mov	r0, r3
    8c9c:	e28bd000 	add	sp, fp, #0
    8ca0:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8ca4:	e12fff1e 	bx	lr

00008ca8 <_Z24get_active_process_countv>:
_Z24get_active_process_countv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:119

uint32_t get_active_process_count()
{
    8ca8:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8cac:	e28db000 	add	fp, sp, #0
    8cb0:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:120
    const NGet_Sched_Info_Type req = NGet_Sched_Info_Type::Active_Process_Count;
    8cb4:	e3a03000 	mov	r3, #0
    8cb8:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:123
    uint32_t retval;

    asm volatile("mov r0, %0" : : "r" (req));
    8cbc:	e3a03000 	mov	r3, #0
    8cc0:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:124
    asm volatile("mov r1, %0" : : "r" (&retval));
    8cc4:	e24b300c 	sub	r3, fp, #12
    8cc8:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:125
    asm volatile("swi 4");
    8ccc:	ef000004 	svc	0x00000004
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:127

    return retval;
    8cd0:	e51b300c 	ldr	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:128
}
    8cd4:	e1a00003 	mov	r0, r3
    8cd8:	e28bd000 	add	sp, fp, #0
    8cdc:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8ce0:	e12fff1e 	bx	lr

00008ce4 <_Z14get_tick_countv>:
_Z14get_tick_countv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:131

uint32_t get_tick_count()
{
    8ce4:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8ce8:	e28db000 	add	fp, sp, #0
    8cec:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:132
    const NGet_Sched_Info_Type req = NGet_Sched_Info_Type::Tick_Count;
    8cf0:	e3a03001 	mov	r3, #1
    8cf4:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:135
    uint32_t retval;

    asm volatile("mov r0, %0" : : "r" (req));
    8cf8:	e3a03001 	mov	r3, #1
    8cfc:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:136
    asm volatile("mov r1, %0" : : "r" (&retval));
    8d00:	e24b300c 	sub	r3, fp, #12
    8d04:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:137
    asm volatile("swi 4");
    8d08:	ef000004 	svc	0x00000004
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:139

    return retval;
    8d0c:	e51b300c 	ldr	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:140
}
    8d10:	e1a00003 	mov	r0, r3
    8d14:	e28bd000 	add	sp, fp, #0
    8d18:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8d1c:	e12fff1e 	bx	lr

00008d20 <_Z17set_task_deadlinej>:
_Z17set_task_deadlinej():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:143

void set_task_deadline(uint32_t tick_count_required)
{
    8d20:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8d24:	e28db000 	add	fp, sp, #0
    8d28:	e24dd014 	sub	sp, sp, #20
    8d2c:	e50b0010 	str	r0, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:144
    const NDeadline_Subservice req = NDeadline_Subservice::Set_Relative;
    8d30:	e3a03000 	mov	r3, #0
    8d34:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:146

    asm volatile("mov r0, %0" : : "r" (req));
    8d38:	e3a03000 	mov	r3, #0
    8d3c:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:147
    asm volatile("mov r1, %0" : : "r" (&tick_count_required));
    8d40:	e24b3010 	sub	r3, fp, #16
    8d44:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:148
    asm volatile("swi 5");
    8d48:	ef000005 	svc	0x00000005
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:149
}
    8d4c:	e320f000 	nop	{0}
    8d50:	e28bd000 	add	sp, fp, #0
    8d54:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8d58:	e12fff1e 	bx	lr

00008d5c <_Z26get_task_ticks_to_deadlinev>:
_Z26get_task_ticks_to_deadlinev():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:152

uint32_t get_task_ticks_to_deadline()
{
    8d5c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8d60:	e28db000 	add	fp, sp, #0
    8d64:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:153
    const NDeadline_Subservice req = NDeadline_Subservice::Get_Remaining;
    8d68:	e3a03001 	mov	r3, #1
    8d6c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:156
    uint32_t ticks;

    asm volatile("mov r0, %0" : : "r" (req));
    8d70:	e3a03001 	mov	r3, #1
    8d74:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:157
    asm volatile("mov r1, %0" : : "r" (&ticks));
    8d78:	e24b300c 	sub	r3, fp, #12
    8d7c:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:158
    asm volatile("swi 5");
    8d80:	ef000005 	svc	0x00000005
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:160

    return ticks;
    8d84:	e51b300c 	ldr	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:161
}
    8d88:	e1a00003 	mov	r0, r3
    8d8c:	e28bd000 	add	sp, fp, #0
    8d90:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8d94:	e12fff1e 	bx	lr

00008d98 <_Z4pipePKcj>:
_Z4pipePKcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:166

const char Pipe_File_Prefix[] = "SYS:pipe/";

uint32_t pipe(const char* name, uint32_t buf_size)
{
    8d98:	e92d4800 	push	{fp, lr}
    8d9c:	e28db004 	add	fp, sp, #4
    8da0:	e24dd050 	sub	sp, sp, #80	; 0x50
    8da4:	e50b0050 	str	r0, [fp, #-80]	; 0xffffffb0
    8da8:	e50b1054 	str	r1, [fp, #-84]	; 0xffffffac
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:168
    char fname[64];
    strncpy(fname, Pipe_File_Prefix, sizeof(Pipe_File_Prefix));
    8dac:	e24b3048 	sub	r3, fp, #72	; 0x48
    8db0:	e3a0200a 	mov	r2, #10
    8db4:	e59f1088 	ldr	r1, [pc, #136]	; 8e44 <_Z4pipePKcj+0xac>
    8db8:	e1a00003 	mov	r0, r3
    8dbc:	eb00014a 	bl	92ec <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:169
    strncpy(fname + sizeof(Pipe_File_Prefix), name, sizeof(fname) - sizeof(Pipe_File_Prefix) - 1);
    8dc0:	e24b3048 	sub	r3, fp, #72	; 0x48
    8dc4:	e283300a 	add	r3, r3, #10
    8dc8:	e3a02035 	mov	r2, #53	; 0x35
    8dcc:	e51b1050 	ldr	r1, [fp, #-80]	; 0xffffffb0
    8dd0:	e1a00003 	mov	r0, r3
    8dd4:	eb000144 	bl	92ec <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:171

    int ncur = sizeof(Pipe_File_Prefix) + strlen(name);
    8dd8:	e51b0050 	ldr	r0, [fp, #-80]	; 0xffffffb0
    8ddc:	eb00019d 	bl	9458 <_Z6strlenPKc>
    8de0:	e1a03000 	mov	r3, r0
    8de4:	e283300a 	add	r3, r3, #10
    8de8:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:173

    fname[ncur++] = '#';
    8dec:	e51b3008 	ldr	r3, [fp, #-8]
    8df0:	e2832001 	add	r2, r3, #1
    8df4:	e50b2008 	str	r2, [fp, #-8]
    8df8:	e2433004 	sub	r3, r3, #4
    8dfc:	e083300b 	add	r3, r3, fp
    8e00:	e3a02023 	mov	r2, #35	; 0x23
    8e04:	e5432044 	strb	r2, [r3, #-68]	; 0xffffffbc
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:175

    itoa(buf_size, &fname[ncur], 10);
    8e08:	e24b2048 	sub	r2, fp, #72	; 0x48
    8e0c:	e51b3008 	ldr	r3, [fp, #-8]
    8e10:	e0823003 	add	r3, r2, r3
    8e14:	e3a0200a 	mov	r2, #10
    8e18:	e1a01003 	mov	r1, r3
    8e1c:	e51b0054 	ldr	r0, [fp, #-84]	; 0xffffffac
    8e20:	eb000008 	bl	8e48 <_Z4itoajPcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:177

    return open(fname, NFile_Open_Mode::Read_Write);
    8e24:	e24b3048 	sub	r3, fp, #72	; 0x48
    8e28:	e3a01002 	mov	r1, #2
    8e2c:	e1a00003 	mov	r0, r3
    8e30:	ebffff0a 	bl	8a60 <_Z4openPKc15NFile_Open_Mode>
    8e34:	e1a03000 	mov	r3, r0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:178
}
    8e38:	e1a00003 	mov	r0, r3
    8e3c:	e24bd004 	sub	sp, fp, #4
    8e40:	e8bd8800 	pop	{fp, pc}
    8e44:	000099c4 	andeq	r9, r0, r4, asr #19

00008e48 <_Z4itoajPcj>:
_Z4itoajPcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:9
{
    const char CharConvArr[] = "0123456789ABCDEF";
}

void itoa(unsigned int input, char* output, unsigned int base)
{
    8e48:	e92d4800 	push	{fp, lr}
    8e4c:	e28db004 	add	fp, sp, #4
    8e50:	e24dd020 	sub	sp, sp, #32
    8e54:	e50b0018 	str	r0, [fp, #-24]	; 0xffffffe8
    8e58:	e50b101c 	str	r1, [fp, #-28]	; 0xffffffe4
    8e5c:	e50b2020 	str	r2, [fp, #-32]	; 0xffffffe0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:10
	int i = 0;
    8e60:	e3a03000 	mov	r3, #0
    8e64:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:12

	while (input > 0)
    8e68:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8e6c:	e3530000 	cmp	r3, #0
    8e70:	0a000014 	beq	8ec8 <_Z4itoajPcj+0x80>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:14
	{
		output[i] = CharConvArr[input % base];
    8e74:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8e78:	e51b1020 	ldr	r1, [fp, #-32]	; 0xffffffe0
    8e7c:	e1a00003 	mov	r0, r3
    8e80:	eb00025b 	bl	97f4 <__aeabi_uidivmod>
    8e84:	e1a03001 	mov	r3, r1
    8e88:	e1a01003 	mov	r1, r3
    8e8c:	e51b3008 	ldr	r3, [fp, #-8]
    8e90:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    8e94:	e0823003 	add	r3, r2, r3
    8e98:	e59f2118 	ldr	r2, [pc, #280]	; 8fb8 <_Z4itoajPcj+0x170>
    8e9c:	e7d22001 	ldrb	r2, [r2, r1]
    8ea0:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:15
		input /= base;
    8ea4:	e51b1020 	ldr	r1, [fp, #-32]	; 0xffffffe0
    8ea8:	e51b0018 	ldr	r0, [fp, #-24]	; 0xffffffe8
    8eac:	eb0001d5 	bl	9608 <__udivsi3>
    8eb0:	e1a03000 	mov	r3, r0
    8eb4:	e50b3018 	str	r3, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:16
		i++;
    8eb8:	e51b3008 	ldr	r3, [fp, #-8]
    8ebc:	e2833001 	add	r3, r3, #1
    8ec0:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:12
	while (input > 0)
    8ec4:	eaffffe7 	b	8e68 <_Z4itoajPcj+0x20>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:19
	}

    if (i == 0)
    8ec8:	e51b3008 	ldr	r3, [fp, #-8]
    8ecc:	e3530000 	cmp	r3, #0
    8ed0:	1a000007 	bne	8ef4 <_Z4itoajPcj+0xac>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:21
    {
        output[i] = CharConvArr[0];
    8ed4:	e51b3008 	ldr	r3, [fp, #-8]
    8ed8:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    8edc:	e0823003 	add	r3, r2, r3
    8ee0:	e3a02030 	mov	r2, #48	; 0x30
    8ee4:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:22
        i++;
    8ee8:	e51b3008 	ldr	r3, [fp, #-8]
    8eec:	e2833001 	add	r3, r3, #1
    8ef0:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:25
    }

	output[i] = '\0';
    8ef4:	e51b3008 	ldr	r3, [fp, #-8]
    8ef8:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    8efc:	e0823003 	add	r3, r2, r3
    8f00:	e3a02000 	mov	r2, #0
    8f04:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:26
	i--;
    8f08:	e51b3008 	ldr	r3, [fp, #-8]
    8f0c:	e2433001 	sub	r3, r3, #1
    8f10:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:28

	for (int j = 0; j <= i/2; j++)
    8f14:	e3a03000 	mov	r3, #0
    8f18:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:28 (discriminator 3)
    8f1c:	e51b3008 	ldr	r3, [fp, #-8]
    8f20:	e1a02fa3 	lsr	r2, r3, #31
    8f24:	e0823003 	add	r3, r2, r3
    8f28:	e1a030c3 	asr	r3, r3, #1
    8f2c:	e1a02003 	mov	r2, r3
    8f30:	e51b300c 	ldr	r3, [fp, #-12]
    8f34:	e1530002 	cmp	r3, r2
    8f38:	ca00001b 	bgt	8fac <_Z4itoajPcj+0x164>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:30 (discriminator 2)
	{
		char c = output[i - j];
    8f3c:	e51b2008 	ldr	r2, [fp, #-8]
    8f40:	e51b300c 	ldr	r3, [fp, #-12]
    8f44:	e0423003 	sub	r3, r2, r3
    8f48:	e1a02003 	mov	r2, r3
    8f4c:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    8f50:	e0833002 	add	r3, r3, r2
    8f54:	e5d33000 	ldrb	r3, [r3]
    8f58:	e54b300d 	strb	r3, [fp, #-13]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:31 (discriminator 2)
		output[i - j] = output[j];
    8f5c:	e51b300c 	ldr	r3, [fp, #-12]
    8f60:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    8f64:	e0822003 	add	r2, r2, r3
    8f68:	e51b1008 	ldr	r1, [fp, #-8]
    8f6c:	e51b300c 	ldr	r3, [fp, #-12]
    8f70:	e0413003 	sub	r3, r1, r3
    8f74:	e1a01003 	mov	r1, r3
    8f78:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    8f7c:	e0833001 	add	r3, r3, r1
    8f80:	e5d22000 	ldrb	r2, [r2]
    8f84:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:32 (discriminator 2)
		output[j] = c;
    8f88:	e51b300c 	ldr	r3, [fp, #-12]
    8f8c:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    8f90:	e0823003 	add	r3, r2, r3
    8f94:	e55b200d 	ldrb	r2, [fp, #-13]
    8f98:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:28 (discriminator 2)
	for (int j = 0; j <= i/2; j++)
    8f9c:	e51b300c 	ldr	r3, [fp, #-12]
    8fa0:	e2833001 	add	r3, r3, #1
    8fa4:	e50b300c 	str	r3, [fp, #-12]
    8fa8:	eaffffdb 	b	8f1c <_Z4itoajPcj+0xd4>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:34
	}
}
    8fac:	e320f000 	nop	{0}
    8fb0:	e24bd004 	sub	sp, fp, #4
    8fb4:	e8bd8800 	pop	{fp, pc}
    8fb8:	000099d0 	ldrdeq	r9, [r0], -r0

00008fbc <_Z4atoiPKc>:
_Z4atoiPKc():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:37

int atoi(const char* input)
{
    8fbc:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8fc0:	e28db000 	add	fp, sp, #0
    8fc4:	e24dd014 	sub	sp, sp, #20
    8fc8:	e50b0010 	str	r0, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:38
	int output = 0;
    8fcc:	e3a03000 	mov	r3, #0
    8fd0:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:40

	while (*input != '\0')
    8fd4:	e51b3010 	ldr	r3, [fp, #-16]
    8fd8:	e5d33000 	ldrb	r3, [r3]
    8fdc:	e3530000 	cmp	r3, #0
    8fe0:	0a000017 	beq	9044 <_Z4atoiPKc+0x88>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:42
	{
		output *= 10;
    8fe4:	e51b2008 	ldr	r2, [fp, #-8]
    8fe8:	e1a03002 	mov	r3, r2
    8fec:	e1a03103 	lsl	r3, r3, #2
    8ff0:	e0833002 	add	r3, r3, r2
    8ff4:	e1a03083 	lsl	r3, r3, #1
    8ff8:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:43
		if (*input > '9' || *input < '0')
    8ffc:	e51b3010 	ldr	r3, [fp, #-16]
    9000:	e5d33000 	ldrb	r3, [r3]
    9004:	e3530039 	cmp	r3, #57	; 0x39
    9008:	8a00000d 	bhi	9044 <_Z4atoiPKc+0x88>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:43 (discriminator 1)
    900c:	e51b3010 	ldr	r3, [fp, #-16]
    9010:	e5d33000 	ldrb	r3, [r3]
    9014:	e353002f 	cmp	r3, #47	; 0x2f
    9018:	9a000009 	bls	9044 <_Z4atoiPKc+0x88>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:46
			break;

		output += *input - '0';
    901c:	e51b3010 	ldr	r3, [fp, #-16]
    9020:	e5d33000 	ldrb	r3, [r3]
    9024:	e2433030 	sub	r3, r3, #48	; 0x30
    9028:	e51b2008 	ldr	r2, [fp, #-8]
    902c:	e0823003 	add	r3, r2, r3
    9030:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:48

		input++;
    9034:	e51b3010 	ldr	r3, [fp, #-16]
    9038:	e2833001 	add	r3, r3, #1
    903c:	e50b3010 	str	r3, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:40
	while (*input != '\0')
    9040:	eaffffe3 	b	8fd4 <_Z4atoiPKc+0x18>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:51
	}

	return output;
    9044:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:52
}
    9048:	e1a00003 	mov	r0, r3
    904c:	e28bd000 	add	sp, fp, #0
    9050:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    9054:	e12fff1e 	bx	lr

00009058 <_Z4ftoafPcj>:
_Z4ftoafPcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:55

char* ftoa(float input, char* output, unsigned int decimal_places)
{
    9058:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    905c:	e28db000 	add	fp, sp, #0
    9060:	e24dd03c 	sub	sp, sp, #60	; 0x3c
    9064:	ed0b0a0c 	vstr	s0, [fp, #-48]	; 0xffffffd0
    9068:	e50b0034 	str	r0, [fp, #-52]	; 0xffffffcc
    906c:	e50b1038 	str	r1, [fp, #-56]	; 0xffffffc8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:56
	char* ptr = output;
    9070:	e51b3034 	ldr	r3, [fp, #-52]	; 0xffffffcc
    9074:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:59

    // Handle negative numbers
    if (input < 0) {
    9078:	ed5b7a0c 	vldr	s15, [fp, #-48]	; 0xffffffd0
    907c:	eef57ac0 	vcmpe.f32	s15, #0.0
    9080:	eef1fa10 	vmrs	APSR_nzcv, fpscr
    9084:	5a000007 	bpl	90a8 <_Z4ftoafPcj+0x50>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:60
        *ptr++ = '-';
    9088:	e51b3008 	ldr	r3, [fp, #-8]
    908c:	e2832001 	add	r2, r3, #1
    9090:	e50b2008 	str	r2, [fp, #-8]
    9094:	e3a0202d 	mov	r2, #45	; 0x2d
    9098:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:61
        input = -input;
    909c:	ed5b7a0c 	vldr	s15, [fp, #-48]	; 0xffffffd0
    90a0:	eef17a67 	vneg.f32	s15, s15
    90a4:	ed4b7a0c 	vstr	s15, [fp, #-48]	; 0xffffffd0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:65
    }

    // Extract the integer part
    int int_part = (int)input;
    90a8:	ed5b7a0c 	vldr	s15, [fp, #-48]	; 0xffffffd0
    90ac:	eefd7ae7 	vcvt.s32.f32	s15, s15
    90b0:	ee173a90 	vmov	r3, s15
    90b4:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:66
    float fraction = input - int_part;
    90b8:	e51b300c 	ldr	r3, [fp, #-12]
    90bc:	ee073a90 	vmov	s15, r3
    90c0:	eef87ae7 	vcvt.f32.s32	s15, s15
    90c4:	ed1b7a0c 	vldr	s14, [fp, #-48]	; 0xffffffd0
    90c8:	ee777a67 	vsub.f32	s15, s14, s15
    90cc:	ed4b7a04 	vstr	s15, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:70

    // Convert the integer part to a string
    char int_str[12]; // Temporary buffer for the integer part
    char* int_ptr = int_str;
    90d0:	e24b302c 	sub	r3, fp, #44	; 0x2c
    90d4:	e50b3014 	str	r3, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:71
    if (int_part == 0) {
    90d8:	e51b300c 	ldr	r3, [fp, #-12]
    90dc:	e3530000 	cmp	r3, #0
    90e0:	1a000005 	bne	90fc <_Z4ftoafPcj+0xa4>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:72
        *int_ptr++ = '0';
    90e4:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    90e8:	e2832001 	add	r2, r3, #1
    90ec:	e50b2014 	str	r2, [fp, #-20]	; 0xffffffec
    90f0:	e3a02030 	mov	r2, #48	; 0x30
    90f4:	e5c32000 	strb	r2, [r3]
    90f8:	ea00001c 	b	9170 <_Z4ftoafPcj+0x118>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:74
    } else {
        while (int_part > 0) {
    90fc:	e51b300c 	ldr	r3, [fp, #-12]
    9100:	e3530000 	cmp	r3, #0
    9104:	da000019 	ble	9170 <_Z4ftoafPcj+0x118>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:75
            *int_ptr++ = '0' + (int_part % 10);
    9108:	e51b200c 	ldr	r2, [fp, #-12]
    910c:	e59f31d4 	ldr	r3, [pc, #468]	; 92e8 <_Z4ftoafPcj+0x290>
    9110:	e0c31293 	smull	r1, r3, r3, r2
    9114:	e1a01143 	asr	r1, r3, #2
    9118:	e1a03fc2 	asr	r3, r2, #31
    911c:	e0411003 	sub	r1, r1, r3
    9120:	e1a03001 	mov	r3, r1
    9124:	e1a03103 	lsl	r3, r3, #2
    9128:	e0833001 	add	r3, r3, r1
    912c:	e1a03083 	lsl	r3, r3, #1
    9130:	e0421003 	sub	r1, r2, r3
    9134:	e6ef2071 	uxtb	r2, r1
    9138:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    913c:	e2831001 	add	r1, r3, #1
    9140:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    9144:	e2822030 	add	r2, r2, #48	; 0x30
    9148:	e6ef2072 	uxtb	r2, r2
    914c:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:76
            int_part /= 10;
    9150:	e51b300c 	ldr	r3, [fp, #-12]
    9154:	e59f218c 	ldr	r2, [pc, #396]	; 92e8 <_Z4ftoafPcj+0x290>
    9158:	e0c21392 	smull	r1, r2, r2, r3
    915c:	e1a02142 	asr	r2, r2, #2
    9160:	e1a03fc3 	asr	r3, r3, #31
    9164:	e0423003 	sub	r3, r2, r3
    9168:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:74
        while (int_part > 0) {
    916c:	eaffffe2 	b	90fc <_Z4ftoafPcj+0xa4>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:81
        }
    }

    // Reverse the integer part string and write to buffer
    while (int_ptr != int_str) {
    9170:	e24b302c 	sub	r3, fp, #44	; 0x2c
    9174:	e51b2014 	ldr	r2, [fp, #-20]	; 0xffffffec
    9178:	e1520003 	cmp	r2, r3
    917c:	0a000009 	beq	91a8 <_Z4ftoafPcj+0x150>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:82
        *ptr++ = *(--int_ptr);
    9180:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    9184:	e2433001 	sub	r3, r3, #1
    9188:	e50b3014 	str	r3, [fp, #-20]	; 0xffffffec
    918c:	e51b3008 	ldr	r3, [fp, #-8]
    9190:	e2832001 	add	r2, r3, #1
    9194:	e50b2008 	str	r2, [fp, #-8]
    9198:	e51b2014 	ldr	r2, [fp, #-20]	; 0xffffffec
    919c:	e5d22000 	ldrb	r2, [r2]
    91a0:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:81
    while (int_ptr != int_str) {
    91a4:	eafffff1 	b	9170 <_Z4ftoafPcj+0x118>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:86
    }

    // Add the decimal point
    if (decimal_places > 0) {
    91a8:	e51b3038 	ldr	r3, [fp, #-56]	; 0xffffffc8
    91ac:	e3530000 	cmp	r3, #0
    91b0:	0a000004 	beq	91c8 <_Z4ftoafPcj+0x170>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:87
        *ptr++ = '.';
    91b4:	e51b3008 	ldr	r3, [fp, #-8]
    91b8:	e2832001 	add	r2, r3, #1
    91bc:	e50b2008 	str	r2, [fp, #-8]
    91c0:	e3a0202e 	mov	r2, #46	; 0x2e
    91c4:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:91
    }

    // Convert the fractional part to the specified number of decimal places
    for (int i = 0; i < decimal_places; i++) {
    91c8:	e3a03000 	mov	r3, #0
    91cc:	e50b3018 	str	r3, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:91 (discriminator 3)
    91d0:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    91d4:	e51b2038 	ldr	r2, [fp, #-56]	; 0xffffffc8
    91d8:	e1520003 	cmp	r2, r3
    91dc:	9a000019 	bls	9248 <_Z4ftoafPcj+0x1f0>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:92 (discriminator 2)
        fraction *= 10;
    91e0:	ed5b7a04 	vldr	s15, [fp, #-16]
    91e4:	ed9f7a3e 	vldr	s14, [pc, #248]	; 92e4 <_Z4ftoafPcj+0x28c>
    91e8:	ee677a87 	vmul.f32	s15, s15, s14
    91ec:	ed4b7a04 	vstr	s15, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:93 (discriminator 2)
        int digit = (int)fraction;
    91f0:	ed5b7a04 	vldr	s15, [fp, #-16]
    91f4:	eefd7ae7 	vcvt.s32.f32	s15, s15
    91f8:	ee173a90 	vmov	r3, s15
    91fc:	e50b3020 	str	r3, [fp, #-32]	; 0xffffffe0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:94 (discriminator 2)
        *ptr++ = '0' + digit;
    9200:	e51b3020 	ldr	r3, [fp, #-32]	; 0xffffffe0
    9204:	e6ef2073 	uxtb	r2, r3
    9208:	e51b3008 	ldr	r3, [fp, #-8]
    920c:	e2831001 	add	r1, r3, #1
    9210:	e50b1008 	str	r1, [fp, #-8]
    9214:	e2822030 	add	r2, r2, #48	; 0x30
    9218:	e6ef2072 	uxtb	r2, r2
    921c:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:95 (discriminator 2)
        fraction -= digit;
    9220:	e51b3020 	ldr	r3, [fp, #-32]	; 0xffffffe0
    9224:	ee073a90 	vmov	s15, r3
    9228:	eef87ae7 	vcvt.f32.s32	s15, s15
    922c:	ed1b7a04 	vldr	s14, [fp, #-16]
    9230:	ee777a67 	vsub.f32	s15, s14, s15
    9234:	ed4b7a04 	vstr	s15, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:91 (discriminator 2)
    for (int i = 0; i < decimal_places; i++) {
    9238:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    923c:	e2833001 	add	r3, r3, #1
    9240:	e50b3018 	str	r3, [fp, #-24]	; 0xffffffe8
    9244:	eaffffe1 	b	91d0 <_Z4ftoafPcj+0x178>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:99
    }

    // Null-terminate the string
    *ptr = '\0';
    9248:	e51b3008 	ldr	r3, [fp, #-8]
    924c:	e3a02000 	mov	r2, #0
    9250:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:102

    // Remove trailing zeros if any decimal places were specified
    if (decimal_places > 0) {
    9254:	e51b3038 	ldr	r3, [fp, #-56]	; 0xffffffc8
    9258:	e3530000 	cmp	r3, #0
    925c:	0a00001b 	beq	92d0 <_Z4ftoafPcj+0x278>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:103
        char* end = ptr - 1;
    9260:	e51b3008 	ldr	r3, [fp, #-8]
    9264:	e2433001 	sub	r3, r3, #1
    9268:	e50b301c 	str	r3, [fp, #-28]	; 0xffffffe4
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:104
        while (end > output && *end == '0') {
    926c:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    9270:	e51b3034 	ldr	r3, [fp, #-52]	; 0xffffffcc
    9274:	e1520003 	cmp	r2, r3
    9278:	9a000009 	bls	92a4 <_Z4ftoafPcj+0x24c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:104 (discriminator 1)
    927c:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    9280:	e5d33000 	ldrb	r3, [r3]
    9284:	e3530030 	cmp	r3, #48	; 0x30
    9288:	1a000005 	bne	92a4 <_Z4ftoafPcj+0x24c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:105
            *end-- = '\0';
    928c:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    9290:	e2432001 	sub	r2, r3, #1
    9294:	e50b201c 	str	r2, [fp, #-28]	; 0xffffffe4
    9298:	e3a02000 	mov	r2, #0
    929c:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:104
        while (end > output && *end == '0') {
    92a0:	eafffff1 	b	926c <_Z4ftoafPcj+0x214>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:107
        }
        if (end > output && *end == '.') {
    92a4:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    92a8:	e51b3034 	ldr	r3, [fp, #-52]	; 0xffffffcc
    92ac:	e1520003 	cmp	r2, r3
    92b0:	9a000006 	bls	92d0 <_Z4ftoafPcj+0x278>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:107 (discriminator 1)
    92b4:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    92b8:	e5d33000 	ldrb	r3, [r3]
    92bc:	e353002e 	cmp	r3, #46	; 0x2e
    92c0:	1a000002 	bne	92d0 <_Z4ftoafPcj+0x278>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:108
            *end = '\0'; // Remove the decimal point if no fractional part remains
    92c4:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    92c8:	e3a02000 	mov	r2, #0
    92cc:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:112
        }
    }

    return output;
    92d0:	e51b3034 	ldr	r3, [fp, #-52]	; 0xffffffcc
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:113
}
    92d4:	e1a00003 	mov	r0, r3
    92d8:	e28bd000 	add	sp, fp, #0
    92dc:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    92e0:	e12fff1e 	bx	lr
    92e4:	41200000 			; <UNDEFINED> instruction: 0x41200000
    92e8:	66666667 	strbtvs	r6, [r6], -r7, ror #12

000092ec <_Z7strncpyPcPKci>:
_Z7strncpyPcPKci():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:116

char* strncpy(char* dest, const char *src, int num)
{
    92ec:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    92f0:	e28db000 	add	fp, sp, #0
    92f4:	e24dd01c 	sub	sp, sp, #28
    92f8:	e50b0010 	str	r0, [fp, #-16]
    92fc:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    9300:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:119
	int i;

	for (i = 0; i < num && src[i] != '\0'; i++)
    9304:	e3a03000 	mov	r3, #0
    9308:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:119 (discriminator 4)
    930c:	e51b2008 	ldr	r2, [fp, #-8]
    9310:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    9314:	e1520003 	cmp	r2, r3
    9318:	aa000011 	bge	9364 <_Z7strncpyPcPKci+0x78>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:119 (discriminator 2)
    931c:	e51b3008 	ldr	r3, [fp, #-8]
    9320:	e51b2014 	ldr	r2, [fp, #-20]	; 0xffffffec
    9324:	e0823003 	add	r3, r2, r3
    9328:	e5d33000 	ldrb	r3, [r3]
    932c:	e3530000 	cmp	r3, #0
    9330:	0a00000b 	beq	9364 <_Z7strncpyPcPKci+0x78>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:120 (discriminator 3)
		dest[i] = src[i];
    9334:	e51b3008 	ldr	r3, [fp, #-8]
    9338:	e51b2014 	ldr	r2, [fp, #-20]	; 0xffffffec
    933c:	e0822003 	add	r2, r2, r3
    9340:	e51b3008 	ldr	r3, [fp, #-8]
    9344:	e51b1010 	ldr	r1, [fp, #-16]
    9348:	e0813003 	add	r3, r1, r3
    934c:	e5d22000 	ldrb	r2, [r2]
    9350:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:119 (discriminator 3)
	for (i = 0; i < num && src[i] != '\0'; i++)
    9354:	e51b3008 	ldr	r3, [fp, #-8]
    9358:	e2833001 	add	r3, r3, #1
    935c:	e50b3008 	str	r3, [fp, #-8]
    9360:	eaffffe9 	b	930c <_Z7strncpyPcPKci+0x20>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:121 (discriminator 2)
	for (; i < num; i++)
    9364:	e51b2008 	ldr	r2, [fp, #-8]
    9368:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    936c:	e1520003 	cmp	r2, r3
    9370:	aa000008 	bge	9398 <_Z7strncpyPcPKci+0xac>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:122 (discriminator 1)
		dest[i] = '\0';
    9374:	e51b3008 	ldr	r3, [fp, #-8]
    9378:	e51b2010 	ldr	r2, [fp, #-16]
    937c:	e0823003 	add	r3, r2, r3
    9380:	e3a02000 	mov	r2, #0
    9384:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:121 (discriminator 1)
	for (; i < num; i++)
    9388:	e51b3008 	ldr	r3, [fp, #-8]
    938c:	e2833001 	add	r3, r3, #1
    9390:	e50b3008 	str	r3, [fp, #-8]
    9394:	eafffff2 	b	9364 <_Z7strncpyPcPKci+0x78>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:124

   return dest;
    9398:	e51b3010 	ldr	r3, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:125
}
    939c:	e1a00003 	mov	r0, r3
    93a0:	e28bd000 	add	sp, fp, #0
    93a4:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    93a8:	e12fff1e 	bx	lr

000093ac <_Z7strncmpPKcS0_i>:
_Z7strncmpPKcS0_i():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:128

int strncmp(const char *s1, const char *s2, int num)
{
    93ac:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    93b0:	e28db000 	add	fp, sp, #0
    93b4:	e24dd01c 	sub	sp, sp, #28
    93b8:	e50b0010 	str	r0, [fp, #-16]
    93bc:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    93c0:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:130
	unsigned char u1, u2;
  	while (num-- > 0)
    93c4:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    93c8:	e2432001 	sub	r2, r3, #1
    93cc:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
    93d0:	e3530000 	cmp	r3, #0
    93d4:	c3a03001 	movgt	r3, #1
    93d8:	d3a03000 	movle	r3, #0
    93dc:	e6ef3073 	uxtb	r3, r3
    93e0:	e3530000 	cmp	r3, #0
    93e4:	0a000016 	beq	9444 <_Z7strncmpPKcS0_i+0x98>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:132
    {
      	u1 = (unsigned char) *s1++;
    93e8:	e51b3010 	ldr	r3, [fp, #-16]
    93ec:	e2832001 	add	r2, r3, #1
    93f0:	e50b2010 	str	r2, [fp, #-16]
    93f4:	e5d33000 	ldrb	r3, [r3]
    93f8:	e54b3005 	strb	r3, [fp, #-5]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:133
     	u2 = (unsigned char) *s2++;
    93fc:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    9400:	e2832001 	add	r2, r3, #1
    9404:	e50b2014 	str	r2, [fp, #-20]	; 0xffffffec
    9408:	e5d33000 	ldrb	r3, [r3]
    940c:	e54b3006 	strb	r3, [fp, #-6]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:134
      	if (u1 != u2)
    9410:	e55b2005 	ldrb	r2, [fp, #-5]
    9414:	e55b3006 	ldrb	r3, [fp, #-6]
    9418:	e1520003 	cmp	r2, r3
    941c:	0a000003 	beq	9430 <_Z7strncmpPKcS0_i+0x84>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:135
        	return u1 - u2;
    9420:	e55b2005 	ldrb	r2, [fp, #-5]
    9424:	e55b3006 	ldrb	r3, [fp, #-6]
    9428:	e0423003 	sub	r3, r2, r3
    942c:	ea000005 	b	9448 <_Z7strncmpPKcS0_i+0x9c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:136
      	if (u1 == '\0')
    9430:	e55b3005 	ldrb	r3, [fp, #-5]
    9434:	e3530000 	cmp	r3, #0
    9438:	1affffe1 	bne	93c4 <_Z7strncmpPKcS0_i+0x18>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:137
        	return 0;
    943c:	e3a03000 	mov	r3, #0
    9440:	ea000000 	b	9448 <_Z7strncmpPKcS0_i+0x9c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:140
    }

  	return 0;
    9444:	e3a03000 	mov	r3, #0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:141
}
    9448:	e1a00003 	mov	r0, r3
    944c:	e28bd000 	add	sp, fp, #0
    9450:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    9454:	e12fff1e 	bx	lr

00009458 <_Z6strlenPKc>:
_Z6strlenPKc():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:144

int strlen(const char* s)
{
    9458:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    945c:	e28db000 	add	fp, sp, #0
    9460:	e24dd014 	sub	sp, sp, #20
    9464:	e50b0010 	str	r0, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:145
	int i = 0;
    9468:	e3a03000 	mov	r3, #0
    946c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:147

	while (s[i] != '\0')
    9470:	e51b3008 	ldr	r3, [fp, #-8]
    9474:	e51b2010 	ldr	r2, [fp, #-16]
    9478:	e0823003 	add	r3, r2, r3
    947c:	e5d33000 	ldrb	r3, [r3]
    9480:	e3530000 	cmp	r3, #0
    9484:	0a000003 	beq	9498 <_Z6strlenPKc+0x40>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:148
		i++;
    9488:	e51b3008 	ldr	r3, [fp, #-8]
    948c:	e2833001 	add	r3, r3, #1
    9490:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:147
	while (s[i] != '\0')
    9494:	eafffff5 	b	9470 <_Z6strlenPKc+0x18>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:150

	return i;
    9498:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:151
}
    949c:	e1a00003 	mov	r0, r3
    94a0:	e28bd000 	add	sp, fp, #0
    94a4:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    94a8:	e12fff1e 	bx	lr

000094ac <_Z5bzeroPvi>:
_Z5bzeroPvi():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:154

void bzero(void* memory, int length)
{
    94ac:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    94b0:	e28db000 	add	fp, sp, #0
    94b4:	e24dd014 	sub	sp, sp, #20
    94b8:	e50b0010 	str	r0, [fp, #-16]
    94bc:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:155
	char* mem = reinterpret_cast<char*>(memory);
    94c0:	e51b3010 	ldr	r3, [fp, #-16]
    94c4:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:157

	for (int i = 0; i < length; i++)
    94c8:	e3a03000 	mov	r3, #0
    94cc:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:157 (discriminator 3)
    94d0:	e51b2008 	ldr	r2, [fp, #-8]
    94d4:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    94d8:	e1520003 	cmp	r2, r3
    94dc:	aa000008 	bge	9504 <_Z5bzeroPvi+0x58>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:158 (discriminator 2)
		mem[i] = 0;
    94e0:	e51b3008 	ldr	r3, [fp, #-8]
    94e4:	e51b200c 	ldr	r2, [fp, #-12]
    94e8:	e0823003 	add	r3, r2, r3
    94ec:	e3a02000 	mov	r2, #0
    94f0:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:157 (discriminator 2)
	for (int i = 0; i < length; i++)
    94f4:	e51b3008 	ldr	r3, [fp, #-8]
    94f8:	e2833001 	add	r3, r3, #1
    94fc:	e50b3008 	str	r3, [fp, #-8]
    9500:	eafffff2 	b	94d0 <_Z5bzeroPvi+0x24>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:159
}
    9504:	e320f000 	nop	{0}
    9508:	e28bd000 	add	sp, fp, #0
    950c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    9510:	e12fff1e 	bx	lr

00009514 <_Z6memcpyPKvPvi>:
_Z6memcpyPKvPvi():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:162

void memcpy(const void* src, void* dst, int num)
{
    9514:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    9518:	e28db000 	add	fp, sp, #0
    951c:	e24dd024 	sub	sp, sp, #36	; 0x24
    9520:	e50b0018 	str	r0, [fp, #-24]	; 0xffffffe8
    9524:	e50b101c 	str	r1, [fp, #-28]	; 0xffffffe4
    9528:	e50b2020 	str	r2, [fp, #-32]	; 0xffffffe0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:163
	const char* memsrc = reinterpret_cast<const char*>(src);
    952c:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    9530:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:164
	char* memdst = reinterpret_cast<char*>(dst);
    9534:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    9538:	e50b3010 	str	r3, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:166

	for (int i = 0; i < num; i++)
    953c:	e3a03000 	mov	r3, #0
    9540:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:166 (discriminator 3)
    9544:	e51b2008 	ldr	r2, [fp, #-8]
    9548:	e51b3020 	ldr	r3, [fp, #-32]	; 0xffffffe0
    954c:	e1520003 	cmp	r2, r3
    9550:	aa00000b 	bge	9584 <_Z6memcpyPKvPvi+0x70>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:167 (discriminator 2)
		memdst[i] = memsrc[i];
    9554:	e51b3008 	ldr	r3, [fp, #-8]
    9558:	e51b200c 	ldr	r2, [fp, #-12]
    955c:	e0822003 	add	r2, r2, r3
    9560:	e51b3008 	ldr	r3, [fp, #-8]
    9564:	e51b1010 	ldr	r1, [fp, #-16]
    9568:	e0813003 	add	r3, r1, r3
    956c:	e5d22000 	ldrb	r2, [r2]
    9570:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:166 (discriminator 2)
	for (int i = 0; i < num; i++)
    9574:	e51b3008 	ldr	r3, [fp, #-8]
    9578:	e2833001 	add	r3, r3, #1
    957c:	e50b3008 	str	r3, [fp, #-8]
    9580:	eaffffef 	b	9544 <_Z6memcpyPKvPvi+0x30>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:168
}
    9584:	e320f000 	nop	{0}
    9588:	e28bd000 	add	sp, fp, #0
    958c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    9590:	e12fff1e 	bx	lr

00009594 <_Z6concatPcPKc>:
_Z6concatPcPKc():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:170

void concat(char* dest, const char* src) {
    9594:	e92d4800 	push	{fp, lr}
    9598:	e28db004 	add	fp, sp, #4
    959c:	e24dd010 	sub	sp, sp, #16
    95a0:	e50b0010 	str	r0, [fp, #-16]
    95a4:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:171
	int i = strlen(dest);
    95a8:	e51b0010 	ldr	r0, [fp, #-16]
    95ac:	ebffffa9 	bl	9458 <_Z6strlenPKc>
    95b0:	e50b0008 	str	r0, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:172
	int j = strlen(src);
    95b4:	e51b0014 	ldr	r0, [fp, #-20]	; 0xffffffec
    95b8:	ebffffa6 	bl	9458 <_Z6strlenPKc>
    95bc:	e50b000c 	str	r0, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:173
	strncpy(dest + i, src, j);
    95c0:	e51b3008 	ldr	r3, [fp, #-8]
    95c4:	e51b2010 	ldr	r2, [fp, #-16]
    95c8:	e0823003 	add	r3, r2, r3
    95cc:	e51b200c 	ldr	r2, [fp, #-12]
    95d0:	e51b1014 	ldr	r1, [fp, #-20]	; 0xffffffec
    95d4:	e1a00003 	mov	r0, r3
    95d8:	ebffff43 	bl	92ec <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:174
	dest[i + j + 1] = '\0';
    95dc:	e51b2008 	ldr	r2, [fp, #-8]
    95e0:	e51b300c 	ldr	r3, [fp, #-12]
    95e4:	e0823003 	add	r3, r2, r3
    95e8:	e2833001 	add	r3, r3, #1
    95ec:	e51b2010 	ldr	r2, [fp, #-16]
    95f0:	e0823003 	add	r3, r2, r3
    95f4:	e3a02000 	mov	r2, #0
    95f8:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:175
    95fc:	e320f000 	nop	{0}
    9600:	e24bd004 	sub	sp, fp, #4
    9604:	e8bd8800 	pop	{fp, pc}

00009608 <__udivsi3>:
__udivsi3():
    9608:	e2512001 	subs	r2, r1, #1
    960c:	012fff1e 	bxeq	lr
    9610:	3a000074 	bcc	97e8 <__udivsi3+0x1e0>
    9614:	e1500001 	cmp	r0, r1
    9618:	9a00006b 	bls	97cc <__udivsi3+0x1c4>
    961c:	e1110002 	tst	r1, r2
    9620:	0a00006c 	beq	97d8 <__udivsi3+0x1d0>
    9624:	e16f3f10 	clz	r3, r0
    9628:	e16f2f11 	clz	r2, r1
    962c:	e0423003 	sub	r3, r2, r3
    9630:	e273301f 	rsbs	r3, r3, #31
    9634:	10833083 	addne	r3, r3, r3, lsl #1
    9638:	e3a02000 	mov	r2, #0
    963c:	108ff103 	addne	pc, pc, r3, lsl #2
    9640:	e1a00000 	nop			; (mov r0, r0)
    9644:	e1500f81 	cmp	r0, r1, lsl #31
    9648:	e0a22002 	adc	r2, r2, r2
    964c:	20400f81 	subcs	r0, r0, r1, lsl #31
    9650:	e1500f01 	cmp	r0, r1, lsl #30
    9654:	e0a22002 	adc	r2, r2, r2
    9658:	20400f01 	subcs	r0, r0, r1, lsl #30
    965c:	e1500e81 	cmp	r0, r1, lsl #29
    9660:	e0a22002 	adc	r2, r2, r2
    9664:	20400e81 	subcs	r0, r0, r1, lsl #29
    9668:	e1500e01 	cmp	r0, r1, lsl #28
    966c:	e0a22002 	adc	r2, r2, r2
    9670:	20400e01 	subcs	r0, r0, r1, lsl #28
    9674:	e1500d81 	cmp	r0, r1, lsl #27
    9678:	e0a22002 	adc	r2, r2, r2
    967c:	20400d81 	subcs	r0, r0, r1, lsl #27
    9680:	e1500d01 	cmp	r0, r1, lsl #26
    9684:	e0a22002 	adc	r2, r2, r2
    9688:	20400d01 	subcs	r0, r0, r1, lsl #26
    968c:	e1500c81 	cmp	r0, r1, lsl #25
    9690:	e0a22002 	adc	r2, r2, r2
    9694:	20400c81 	subcs	r0, r0, r1, lsl #25
    9698:	e1500c01 	cmp	r0, r1, lsl #24
    969c:	e0a22002 	adc	r2, r2, r2
    96a0:	20400c01 	subcs	r0, r0, r1, lsl #24
    96a4:	e1500b81 	cmp	r0, r1, lsl #23
    96a8:	e0a22002 	adc	r2, r2, r2
    96ac:	20400b81 	subcs	r0, r0, r1, lsl #23
    96b0:	e1500b01 	cmp	r0, r1, lsl #22
    96b4:	e0a22002 	adc	r2, r2, r2
    96b8:	20400b01 	subcs	r0, r0, r1, lsl #22
    96bc:	e1500a81 	cmp	r0, r1, lsl #21
    96c0:	e0a22002 	adc	r2, r2, r2
    96c4:	20400a81 	subcs	r0, r0, r1, lsl #21
    96c8:	e1500a01 	cmp	r0, r1, lsl #20
    96cc:	e0a22002 	adc	r2, r2, r2
    96d0:	20400a01 	subcs	r0, r0, r1, lsl #20
    96d4:	e1500981 	cmp	r0, r1, lsl #19
    96d8:	e0a22002 	adc	r2, r2, r2
    96dc:	20400981 	subcs	r0, r0, r1, lsl #19
    96e0:	e1500901 	cmp	r0, r1, lsl #18
    96e4:	e0a22002 	adc	r2, r2, r2
    96e8:	20400901 	subcs	r0, r0, r1, lsl #18
    96ec:	e1500881 	cmp	r0, r1, lsl #17
    96f0:	e0a22002 	adc	r2, r2, r2
    96f4:	20400881 	subcs	r0, r0, r1, lsl #17
    96f8:	e1500801 	cmp	r0, r1, lsl #16
    96fc:	e0a22002 	adc	r2, r2, r2
    9700:	20400801 	subcs	r0, r0, r1, lsl #16
    9704:	e1500781 	cmp	r0, r1, lsl #15
    9708:	e0a22002 	adc	r2, r2, r2
    970c:	20400781 	subcs	r0, r0, r1, lsl #15
    9710:	e1500701 	cmp	r0, r1, lsl #14
    9714:	e0a22002 	adc	r2, r2, r2
    9718:	20400701 	subcs	r0, r0, r1, lsl #14
    971c:	e1500681 	cmp	r0, r1, lsl #13
    9720:	e0a22002 	adc	r2, r2, r2
    9724:	20400681 	subcs	r0, r0, r1, lsl #13
    9728:	e1500601 	cmp	r0, r1, lsl #12
    972c:	e0a22002 	adc	r2, r2, r2
    9730:	20400601 	subcs	r0, r0, r1, lsl #12
    9734:	e1500581 	cmp	r0, r1, lsl #11
    9738:	e0a22002 	adc	r2, r2, r2
    973c:	20400581 	subcs	r0, r0, r1, lsl #11
    9740:	e1500501 	cmp	r0, r1, lsl #10
    9744:	e0a22002 	adc	r2, r2, r2
    9748:	20400501 	subcs	r0, r0, r1, lsl #10
    974c:	e1500481 	cmp	r0, r1, lsl #9
    9750:	e0a22002 	adc	r2, r2, r2
    9754:	20400481 	subcs	r0, r0, r1, lsl #9
    9758:	e1500401 	cmp	r0, r1, lsl #8
    975c:	e0a22002 	adc	r2, r2, r2
    9760:	20400401 	subcs	r0, r0, r1, lsl #8
    9764:	e1500381 	cmp	r0, r1, lsl #7
    9768:	e0a22002 	adc	r2, r2, r2
    976c:	20400381 	subcs	r0, r0, r1, lsl #7
    9770:	e1500301 	cmp	r0, r1, lsl #6
    9774:	e0a22002 	adc	r2, r2, r2
    9778:	20400301 	subcs	r0, r0, r1, lsl #6
    977c:	e1500281 	cmp	r0, r1, lsl #5
    9780:	e0a22002 	adc	r2, r2, r2
    9784:	20400281 	subcs	r0, r0, r1, lsl #5
    9788:	e1500201 	cmp	r0, r1, lsl #4
    978c:	e0a22002 	adc	r2, r2, r2
    9790:	20400201 	subcs	r0, r0, r1, lsl #4
    9794:	e1500181 	cmp	r0, r1, lsl #3
    9798:	e0a22002 	adc	r2, r2, r2
    979c:	20400181 	subcs	r0, r0, r1, lsl #3
    97a0:	e1500101 	cmp	r0, r1, lsl #2
    97a4:	e0a22002 	adc	r2, r2, r2
    97a8:	20400101 	subcs	r0, r0, r1, lsl #2
    97ac:	e1500081 	cmp	r0, r1, lsl #1
    97b0:	e0a22002 	adc	r2, r2, r2
    97b4:	20400081 	subcs	r0, r0, r1, lsl #1
    97b8:	e1500001 	cmp	r0, r1
    97bc:	e0a22002 	adc	r2, r2, r2
    97c0:	20400001 	subcs	r0, r0, r1
    97c4:	e1a00002 	mov	r0, r2
    97c8:	e12fff1e 	bx	lr
    97cc:	03a00001 	moveq	r0, #1
    97d0:	13a00000 	movne	r0, #0
    97d4:	e12fff1e 	bx	lr
    97d8:	e16f2f11 	clz	r2, r1
    97dc:	e262201f 	rsb	r2, r2, #31
    97e0:	e1a00230 	lsr	r0, r0, r2
    97e4:	e12fff1e 	bx	lr
    97e8:	e3500000 	cmp	r0, #0
    97ec:	13e00000 	mvnne	r0, #0
    97f0:	ea000007 	b	9814 <__aeabi_idiv0>

000097f4 <__aeabi_uidivmod>:
__aeabi_uidivmod():
    97f4:	e3510000 	cmp	r1, #0
    97f8:	0afffffa 	beq	97e8 <__udivsi3+0x1e0>
    97fc:	e92d4003 	push	{r0, r1, lr}
    9800:	ebffff80 	bl	9608 <__udivsi3>
    9804:	e8bd4006 	pop	{r1, r2, lr}
    9808:	e0030092 	mul	r3, r2, r0
    980c:	e0411003 	sub	r1, r1, r3
    9810:	e12fff1e 	bx	lr

00009814 <__aeabi_idiv0>:
__aeabi_ldiv0():
    9814:	e12fff1e 	bx	lr

Disassembly of section .rodata:

00009818 <_ZL13Lock_Unlocked>:
    9818:	00000000 	andeq	r0, r0, r0

0000981c <_ZL11Lock_Locked>:
    981c:	00000001 	andeq	r0, r0, r1

00009820 <_ZL21MaxFSDriverNameLength>:
    9820:	00000010 	andeq	r0, r0, r0, lsl r0

00009824 <_ZL17MaxFilenameLength>:
    9824:	00000010 	andeq	r0, r0, r0, lsl r0

00009828 <_ZL13MaxPathLength>:
    9828:	00000080 	andeq	r0, r0, r0, lsl #1

0000982c <_ZL18NoFilesystemDriver>:
    982c:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00009830 <_ZL9NotifyAll>:
    9830:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00009834 <_ZL24Max_Process_Opened_Files>:
    9834:	00000010 	andeq	r0, r0, r0, lsl r0

00009838 <_ZL10Indefinite>:
    9838:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

0000983c <_ZL18Deadline_Unchanged>:
    983c:	fffffffe 			; <UNDEFINED> instruction: 0xfffffffe

00009840 <_ZL14Invalid_Handle>:
    9840:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00009844 <_ZN3halL18Default_Clock_RateE>:
    9844:	0ee6b280 	cdpeq	2, 14, cr11, cr6, cr0, {4}

00009848 <_ZN3halL15Peripheral_BaseE>:
    9848:	20000000 	andcs	r0, r0, r0

0000984c <_ZN3halL9GPIO_BaseE>:
    984c:	20200000 	eorcs	r0, r0, r0

00009850 <_ZN3halL14GPIO_Pin_CountE>:
    9850:	00000036 	andeq	r0, r0, r6, lsr r0

00009854 <_ZN3halL8AUX_BaseE>:
    9854:	20215000 	eorcs	r5, r1, r0

00009858 <_ZN3halL25Interrupt_Controller_BaseE>:
    9858:	2000b200 	andcs	fp, r0, r0, lsl #4

0000985c <_ZN3halL10Timer_BaseE>:
    985c:	2000b400 	andcs	fp, r0, r0, lsl #8

00009860 <_ZN3halL9TRNG_BaseE>:
    9860:	20104000 	andscs	r4, r0, r0

00009864 <_ZN3halL9BSC0_BaseE>:
    9864:	20205000 	eorcs	r5, r0, r0

00009868 <_ZN3halL9BSC1_BaseE>:
    9868:	20804000 	addcs	r4, r0, r0

0000986c <_ZN3halL9BSC2_BaseE>:
    986c:	20805000 	addcs	r5, r0, r0

00009870 <_ZN3halL14I2C_SLAVE_BaseE>:
    9870:	20214000 	eorcs	r4, r1, r0

00009874 <_ZL11Invalid_Pin>:
    9874:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00009878 <_ZL24I2C_Transaction_Max_Size>:
    9878:	00000008 	andeq	r0, r0, r8

0000987c <_ZL21I2C_SLAVE_Buffer_Size>:
    987c:	00000080 	andeq	r0, r0, r0, lsl #1

00009880 <_ZL11UPPER_BOUND>:
    9880:	41300000 	teqmi	r0, r0

00009884 <_ZL11LOWER_BOUND>:
    9884:	40600000 	rsbmi	r0, r0, r0

00009888 <_ZL7ADDRESS>:
    9888:	00000002 	andeq	r0, r0, r2

0000988c <_ZL14TARGET_ADDRESS>:
    988c:	00000001 	andeq	r0, r0, r1

00009890 <_ZL12DESIRED_ROLE>:
    9890:	00000001 	andeq	r0, r0, r1

00009894 <_ZL13random_values>:
    9894:	40d6b852 	sbcsmi	fp, r6, r2, asr r8
    9898:	40875c29 	addmi	r5, r7, r9, lsr #24
    989c:	40a3d70a 	adcmi	sp, r3, sl, lsl #14
    98a0:	407f5c29 	rsbsmi	r5, pc, r9, lsr #24
    98a4:	400e147b 	andmi	r1, lr, fp, ror r4
    98a8:	40e66666 	rscmi	r6, r6, r6, ror #12
    98ac:	413ee148 	teqmi	lr, r8, asr #2
    98b0:	412f5c29 			; <UNDEFINED> instruction: 0x412f5c29

000098b4 <_ZL17random_values_len>:
    98b4:	00000008 	andeq	r0, r0, r8
    98b8:	5453414d 	ldrbpl	r4, [r3], #-333	; 0xfffffeb3
    98bc:	203a5245 	eorscs	r5, sl, r5, asr #4
    98c0:	00000000 	andeq	r0, r0, r0
    98c4:	56414c53 			; <UNDEFINED> instruction: 0x56414c53
    98c8:	00203a45 	eoreq	r3, r0, r5, asr #20
    98cc:	45534e55 	ldrbmi	r4, [r3, #-3669]	; 0xfffff1ab
    98d0:	00203a54 	eoreq	r3, r0, r4, asr sl
    98d4:	646e6553 	strbtvs	r6, [lr], #-1363	; 0xfffffaad
    98d8:	3a676e69 	bcc	19e5284 <__bss_end+0x19db880>
    98dc:	00000020 	andeq	r0, r0, r0, lsr #32
    98e0:	0000000a 	andeq	r0, r0, sl
    98e4:	0074736d 	rsbseq	r7, r4, sp, ror #6
    98e8:	00766c73 	rsbseq	r6, r6, r3, ror ip
    98ec:	69736544 	ldmdbvs	r3!, {r2, r6, r8, sl, sp, lr}^
    98f0:	20646572 	rsbcs	r6, r4, r2, ror r5
    98f4:	656c6f72 	strbvs	r6, [ip, #-3954]!	; 0xfffff08e
    98f8:	72612073 	rsbvc	r2, r1, #115	; 0x73
    98fc:	68742065 	ldmdavs	r4!, {r0, r2, r5, r6, sp}^
    9900:	61732065 	cmnvs	r3, r5, rrx
    9904:	000a656d 	andeq	r6, sl, sp, ror #10
    9908:	656c6f52 	strbvs	r6, [ip, #-3922]!	; 0xfffff0ae
    990c:	65732073 	ldrbvs	r2, [r3, #-115]!	; 0xffffff8d
    9910:	49202e74 	stmdbmi	r0!, {r2, r4, r5, r6, r9, sl, fp, sp}
    9914:	206d6120 	rsbcs	r6, sp, r0, lsr #2
    9918:	00000000 	andeq	r0, r0, r0
    991c:	7473614d 	ldrbtvc	r6, [r3], #-333	; 0xfffffeb3
    9920:	000a7265 	andeq	r7, sl, r5, ror #4
    9924:	76616c53 			; <UNDEFINED> instruction: 0x76616c53
    9928:	00000a65 	andeq	r0, r0, r5, ror #20
    992c:	00676f6c 	rsbeq	r6, r7, ip, ror #30
    9930:	76616c53 			; <UNDEFINED> instruction: 0x76616c53
    9934:	61742065 	cmnvs	r4, r5, rrx
    9938:	73206b73 			; <UNDEFINED> instruction: 0x73206b73
    993c:	74726174 	ldrbtvc	r6, [r2], #-372	; 0xfffffe8c
    9940:	000a6465 	andeq	r6, sl, r5, ror #8
    9944:	3a564544 	bcc	159ae5c <__bss_end+0x1591458>
    9948:	2f633269 	svccs	0x00633269
    994c:	00000032 	andeq	r0, r0, r2, lsr r0
    9950:	6f727245 	svcvs	0x00727245
    9954:	706f2072 	rsbvc	r2, pc, r2, ror r0	; <UNPREDICTABLE>
    9958:	6e696e65 	cdpvs	14, 6, cr6, cr9, cr5, {3}
    995c:	32492067 	subcc	r2, r9, #103	; 0x67
    9960:	6c732043 	ldclvs	0, cr2, [r3], #-268	; 0xfffffef4
    9964:	20657661 	rsbcs	r7, r5, r1, ror #12
    9968:	6e6e6f63 	cdpvs	15, 6, cr6, cr14, cr3, {3}
    996c:	69746365 	ldmdbvs	r4!, {r0, r2, r5, r6, r8, r9, sp, lr}^
    9970:	000a6e6f 	andeq	r6, sl, pc, ror #28
    9974:	20433249 	subcs	r3, r3, r9, asr #4
    9978:	6e6e6f63 	cdpvs	15, 6, cr6, cr14, cr3, {3}
    997c:	69746365 	ldmdbvs	r4!, {r0, r2, r5, r6, r8, r9, sp, lr}^
    9980:	73206e6f 			; <UNDEFINED> instruction: 0x73206e6f
    9984:	6576616c 	ldrbvs	r6, [r6, #-364]!	; 0xfffffe94
    9988:	61747320 	cmnvs	r4, r0, lsr #6
    998c:	64657472 	strbtvs	r7, [r5], #-1138	; 0xfffffb8e
    9990:	0a2e2e2e 	beq	b95250 <__bss_end+0xb8b84c>
    9994:	00000000 	andeq	r0, r0, r0

00009998 <_ZL13Lock_Unlocked>:
    9998:	00000000 	andeq	r0, r0, r0

0000999c <_ZL11Lock_Locked>:
    999c:	00000001 	andeq	r0, r0, r1

000099a0 <_ZL21MaxFSDriverNameLength>:
    99a0:	00000010 	andeq	r0, r0, r0, lsl r0

000099a4 <_ZL17MaxFilenameLength>:
    99a4:	00000010 	andeq	r0, r0, r0, lsl r0

000099a8 <_ZL13MaxPathLength>:
    99a8:	00000080 	andeq	r0, r0, r0, lsl #1

000099ac <_ZL18NoFilesystemDriver>:
    99ac:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

000099b0 <_ZL9NotifyAll>:
    99b0:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

000099b4 <_ZL24Max_Process_Opened_Files>:
    99b4:	00000010 	andeq	r0, r0, r0, lsl r0

000099b8 <_ZL10Indefinite>:
    99b8:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

000099bc <_ZL18Deadline_Unchanged>:
    99bc:	fffffffe 			; <UNDEFINED> instruction: 0xfffffffe

000099c0 <_ZL14Invalid_Handle>:
    99c0:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

000099c4 <_ZL16Pipe_File_Prefix>:
    99c4:	3a535953 	bcc	14dff18 <__bss_end+0x14d6514>
    99c8:	65706970 	ldrbvs	r6, [r0, #-2416]!	; 0xfffff690
    99cc:	0000002f 	andeq	r0, r0, pc, lsr #32

000099d0 <_ZN12_GLOBAL__N_1L11CharConvArrE>:
    99d0:	33323130 	teqcc	r2, #48, 2
    99d4:	37363534 			; <UNDEFINED> instruction: 0x37363534
    99d8:	42413938 	submi	r3, r1, #56, 18	; 0xe0000
    99dc:	46454443 	strbmi	r4, [r5], -r3, asr #8
	...

Disassembly of section .data:

000099e4 <__CTOR_LIST__>:
__DTOR_END__():
    99e4:	00000002 	andeq	r0, r0, r2

000099e8 <prev_value>:
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:28
float prev_value = random_values[0];
    99e8:	40d6b852 	sbcsmi	fp, r6, r2, asr r8

Disassembly of section .bss:

000099ec <log_fd>:
__bss_start():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:22
uint32_t log_fd, slave;
    99ec:	00000000 	andeq	r0, r0, r0

000099f0 <slave>:
	...

Disassembly of section .ARM.attributes:

00000000 <.ARM.attributes>:
   0:	00002e41 	andeq	r2, r0, r1, asr #28
   4:	61656100 	cmnvs	r5, r0, lsl #2
   8:	01006962 	tsteq	r0, r2, ror #18
   c:	00000024 	andeq	r0, r0, r4, lsr #32
  10:	4b5a3605 	blmi	168d82c <__bss_end+0x1683e28>
  14:	08070600 	stmdaeq	r7, {r9, sl}
  18:	0a010901 	beq	42424 <__bss_end+0x38a20>
  1c:	14041202 	strne	r1, [r4], #-514	; 0xfffffdfe
  20:	17011501 	strne	r1, [r1, -r1, lsl #10]
  24:	1a011803 	bne	46038 <__bss_end+0x3c634>
  28:	22011c01 	andcs	r1, r1, #256	; 0x100
  2c:	Address 0x000000000000002c is out of bounds.


Disassembly of section .comment:

00000000 <.comment>:
   0:	3a434347 	bcc	10d0d24 <__bss_end+0x10c7320>
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
  38:	7a617661 	bvc	185d9c4 <__bss_end+0x1853fc0>
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
  c0:	6a757a61 	bvs	1d5ea4c <__bss_end+0x1d55048>
  c4:	2f696369 	svccs	0x00696369
  c8:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
  cc:	73656d65 	cmnvc	r5, #6464	; 0x1940
  d0:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
  d4:	6b2d616b 	blvs	b58688 <__bss_end+0xb4ec84>
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
 144:	fb010200 	blx	4094e <__bss_end+0x36f4a>
 148:	01000d0e 	tsteq	r0, lr, lsl #26
 14c:	00010101 	andeq	r0, r1, r1, lsl #2
 150:	00010000 	andeq	r0, r1, r0
 154:	552f0100 	strpl	r0, [pc, #-256]!	; 5c <shift+0x5c>
 158:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 15c:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 160:	6a726574 	bvs	1c99738 <__bss_end+0x1c8fd34>
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
 198:	752f7365 	strvc	r7, [pc, #-869]!	; fffffe3b <__bss_end+0xffff6437>
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
 1d0:	0a05830b 	beq	160e04 <__bss_end+0x157400>
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
 1fc:	4a030402 	bmi	c120c <__bss_end+0xb7808>
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
 230:	4a020402 	bmi	81240 <__bss_end+0x7783c>
 234:	02000205 	andeq	r0, r0, #1342177280	; 0x50000000
 238:	052d0204 	streq	r0, [sp, #-516]!	; 0xfffffdfc
 23c:	01058509 	tsteq	r5, r9, lsl #10
 240:	000a022f 	andeq	r0, sl, pc, lsr #4
 244:	04eb0101 	strbteq	r0, [fp], #257	; 0x101
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
 280:	6a757a61 	bvs	1d5ec0c <__bss_end+0x1d55208>
 284:	2f696369 	svccs	0x00696369
 288:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
 28c:	73656d65 	cmnvc	r5, #6464	; 0x1940
 290:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
 294:	6b2d616b 	blvs	b58848 <__bss_end+0xb4ee44>
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
 2d8:	7a617661 	bvc	185dc64 <__bss_end+0x1854260>
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
 348:	7a617661 	bvc	185dcd4 <__bss_end+0x18542d0>
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
 3a4:	6b736544 	blvs	1cd98bc <__bss_end+0x1ccfeb8>
 3a8:	2f706f74 	svccs	0x00706f74
 3ac:	2f564146 	svccs	0x00564146
 3b0:	6176614e 	cmnvs	r6, lr, asr #2
 3b4:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
 3b8:	4f2f6963 	svcmi	0x002f6963
 3bc:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
 3c0:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
 3c4:	6b6c6172 	blvs	1b18994 <__bss_end+0x1b0ef90>
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
 408:	6b736544 	blvs	1cd9920 <__bss_end+0x1ccff1c>
 40c:	2f706f74 	svccs	0x00706f74
 410:	2f564146 	svccs	0x00564146
 414:	6176614e 	cmnvs	r6, lr, asr #2
 418:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
 41c:	4f2f6963 	svcmi	0x002f6963
 420:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
 424:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
 428:	6b6c6172 	blvs	1b189f8 <__bss_end+0x1b0eff4>
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
 480:	6a757a61 	bvs	1d5ee0c <__bss_end+0x1d55408>
 484:	2f696369 	svccs	0x00696369
 488:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
 48c:	73656d65 	cmnvc	r5, #6464	; 0x1940
 490:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
 494:	6b2d616b 	blvs	b58a48 <__bss_end+0xb4f044>
 498:	6f2d7669 	svcvs	0x002d7669
 49c:	6f732f73 	svcvs	0x00732f73
 4a0:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
 4a4:	73752f73 	cmnvc	r5, #460	; 0x1cc
 4a8:	70737265 	rsbsvc	r7, r3, r5, ror #4
 4ac:	2f656361 	svccs	0x00656361
 4b0:	6b2f2e2e 	blvs	bcbd70 <__bss_end+0xbc236c>
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
 4f8:	6b636f6c 	blvs	18dc2b0 <__bss_end+0x18d28ac>
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
 580:	0505011d 	streq	r0, [r5, #-285]	; 0xfffffee3
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
 5cc:	0a054a1f 	beq	152e50 <__bss_end+0x14944c>
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
 620:	0b059f09 	bleq	16824c <__bss_end+0x15e848>
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
 668:	0a05bd2f 	beq	16fb2c <__bss_end+0x166128>
 66c:	05838384 	streq	r8, [r3, #900]	; 0x384
 670:	10058305 	andne	r8, r5, r5, lsl #6
 674:	9f0905d9 	svcls	0x000905d9
 678:	05301005 	ldreq	r1, [r0, #-5]!
 67c:	10059f09 	andne	r9, r5, r9, lsl #30
 680:	9f090530 	svcls	0x00090530
 684:	05310a05 	ldreq	r0, [r1, #-2565]!	; 0xfffff5fb
 688:	1905bb12 	stmdbne	r5, {r1, r4, r8, r9, fp, ip, sp, pc}
 68c:	bb0d0582 	bllt	341c9c <__bss_end+0x338298>
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
 6bc:	059f0e05 	ldreq	r0, [pc, #3589]	; 14c9 <shift+0x14c9>
 6c0:	12054c0a 	andne	r4, r5, #2560	; 0xa00
 6c4:	820c0584 	andhi	r0, ip, #132, 10	; 0x21000000
 6c8:	054c0805 	strbeq	r0, [ip, #-2053]	; 0xfffff7fb
 6cc:	0b054d11 	bleq	153b18 <__bss_end+0x14a114>
 6d0:	4b0f0582 	blmi	3c1ce0 <__bss_end+0x3b82dc>
 6d4:	054a0505 	strbeq	r0, [sl, #-1285]	; 0xfffffafb
 6d8:	10054b0c 	andne	r4, r5, ip, lsl #22
 6dc:	4e14054b 	cfmac32mi	mvfx0, mvfx4, mvfx11
 6e0:	054b1905 	strbeq	r1, [fp, #-2309]	; 0xfffff6fb
 6e4:	08054b0a 	stmdaeq	r5, {r1, r3, r8, r9, fp, lr}
 6e8:	4c0a05bb 	cfstr32mi	mvfx0, [sl], {187}	; 0xbb
 6ec:	05670e05 	strbeq	r0, [r7, #-3589]!	; 0xfffff1fb
 6f0:	04020029 	streq	r0, [r2], #-41	; 0xffffffd7
 6f4:	13054e01 	movwne	r4, #24065	; 0x5e01
 6f8:	01040200 	mrseq	r0, R12_usr
 6fc:	002b059e 	mlaeq	fp, lr, r5, r0
 700:	4b010402 	blmi	41710 <__bss_end+0x37d0c>
 704:	02001405 	andeq	r1, r0, #83886080	; 0x5000000
 708:	059e0104 	ldreq	r0, [lr, #260]	; 0x104
 70c:	0402001c 	streq	r0, [r2], #-28	; 0xffffffe4
 710:	11054b01 	tstne	r5, r1, lsl #22
 714:	01040200 	mrseq	r0, R12_usr
 718:	000e054a 	andeq	r0, lr, sl, asr #10
 71c:	4c010402 	cfstrsmi	mvf0, [r1], {2}
 720:	02001305 	andeq	r1, r0, #335544320	; 0x14000000
 724:	05620104 	strbeq	r0, [r2, #-260]!	; 0xfffffefc
 728:	04020001 	streq	r0, [r2], #-1
 72c:	2e0c0301 	cdpcs	3, 0, cr0, cr12, cr1, {0}
 730:	01001802 	tsteq	r0, r2, lsl #16
 734:	0002c801 	andeq	ip, r2, r1, lsl #16
 738:	dd000300 	stcle	3, cr0, [r0, #-0]
 73c:	02000001 	andeq	r0, r0, #1
 740:	0d0efb01 	vstreq	d15, [lr, #-4]
 744:	01010100 	mrseq	r0, (UNDEF: 17)
 748:	00000001 	andeq	r0, r0, r1
 74c:	01000001 	tsteq	r0, r1
 750:	6573552f 	ldrbvs	r5, [r3, #-1327]!	; 0xfffffad1
 754:	772f7372 			; <UNDEFINED> instruction: 0x772f7372
 758:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
 75c:	2f696a72 	svccs	0x00696a72
 760:	6b736544 	blvs	1cd9c78 <__bss_end+0x1cd0274>
 764:	2f706f74 	svccs	0x00706f74
 768:	2f564146 	svccs	0x00564146
 76c:	6176614e 	cmnvs	r6, lr, asr #2
 770:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
 774:	4f2f6963 	svcmi	0x002f6963
 778:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
 77c:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
 780:	6b6c6172 	blvs	1b18d50 <__bss_end+0x1b0f34c>
 784:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
 788:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
 78c:	756f732f 	strbvc	r7, [pc, #-815]!	; 465 <shift+0x465>
 790:	73656372 	cmnvc	r5, #-939524095	; 0xc8000001
 794:	6474732f 	ldrbtvs	r7, [r4], #-815	; 0xfffffcd1
 798:	2f62696c 	svccs	0x0062696c
 79c:	00637273 	rsbeq	r7, r3, r3, ror r2
 7a0:	6573552f 	ldrbvs	r5, [r3, #-1327]!	; 0xfffffad1
 7a4:	772f7372 			; <UNDEFINED> instruction: 0x772f7372
 7a8:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
 7ac:	2f696a72 	svccs	0x00696a72
 7b0:	6b736544 	blvs	1cd9cc8 <__bss_end+0x1cd02c4>
 7b4:	2f706f74 	svccs	0x00706f74
 7b8:	2f564146 	svccs	0x00564146
 7bc:	6176614e 	cmnvs	r6, lr, asr #2
 7c0:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
 7c4:	4f2f6963 	svcmi	0x002f6963
 7c8:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
 7cc:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
 7d0:	6b6c6172 	blvs	1b18da0 <__bss_end+0x1b0f39c>
 7d4:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
 7d8:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
 7dc:	756f732f 	strbvc	r7, [pc, #-815]!	; 4b5 <shift+0x4b5>
 7e0:	73656372 	cmnvc	r5, #-939524095	; 0xc8000001
 7e4:	72656b2f 	rsbvc	r6, r5, #48128	; 0xbc00
 7e8:	2f6c656e 	svccs	0x006c656e
 7ec:	6c636e69 	stclvs	14, cr6, [r3], #-420	; 0xfffffe5c
 7f0:	2f656475 	svccs	0x00656475
 7f4:	636f7270 	cmnvs	pc, #112, 4
 7f8:	00737365 	rsbseq	r7, r3, r5, ror #6
 7fc:	6573552f 	ldrbvs	r5, [r3, #-1327]!	; 0xfffffad1
 800:	772f7372 			; <UNDEFINED> instruction: 0x772f7372
 804:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
 808:	2f696a72 	svccs	0x00696a72
 80c:	6b736544 	blvs	1cd9d24 <__bss_end+0x1cd0320>
 810:	2f706f74 	svccs	0x00706f74
 814:	2f564146 	svccs	0x00564146
 818:	6176614e 	cmnvs	r6, lr, asr #2
 81c:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
 820:	4f2f6963 	svcmi	0x002f6963
 824:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
 828:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
 82c:	6b6c6172 	blvs	1b18dfc <__bss_end+0x1b0f3f8>
 830:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
 834:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
 838:	756f732f 	strbvc	r7, [pc, #-815]!	; 511 <shift+0x511>
 83c:	73656372 	cmnvc	r5, #-939524095	; 0xc8000001
 840:	72656b2f 	rsbvc	r6, r5, #48128	; 0xbc00
 844:	2f6c656e 	svccs	0x006c656e
 848:	6c636e69 	stclvs	14, cr6, [r3], #-420	; 0xfffffe5c
 84c:	2f656475 	svccs	0x00656475
 850:	2f007366 	svccs	0x00007366
 854:	72657355 	rsbvc	r7, r5, #1409286145	; 0x54000001
 858:	69772f73 	ldmdbvs	r7!, {r0, r1, r4, r5, r6, r8, r9, sl, fp, sp}^
 85c:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
 860:	442f696a 	strtmi	r6, [pc], #-2410	; 868 <shift+0x868>
 864:	746b7365 	strbtvc	r7, [fp], #-869	; 0xfffffc9b
 868:	462f706f 	strtmi	r7, [pc], -pc, rrx
 86c:	4e2f5641 	cfmadda32mi	mvax2, mvax5, mvfx15, mvfx1
 870:	7a617661 	bvc	185e1fc <__bss_end+0x18547f8>
 874:	63696a75 	cmnvs	r9, #479232	; 0x75000
 878:	534f2f69 	movtpl	r2, #65385	; 0xff69
 87c:	6d65732f 	stclvs	3, cr7, [r5, #-188]!	; 0xffffff44
 880:	72747365 	rsbsvc	r7, r4, #-1811939327	; 0x94000001
 884:	616b6c61 	cmnvs	fp, r1, ror #24
 888:	76696b2d 	strbtvc	r6, [r9], -sp, lsr #22
 88c:	2f736f2d 	svccs	0x00736f2d
 890:	72756f73 	rsbsvc	r6, r5, #460	; 0x1cc
 894:	2f736563 	svccs	0x00736563
 898:	6e72656b 	cdpvs	5, 7, cr6, cr2, cr11, {3}
 89c:	692f6c65 	stmdbvs	pc!, {r0, r2, r5, r6, sl, fp, sp, lr}	; <UNPREDICTABLE>
 8a0:	756c636e 	strbvc	r6, [ip, #-878]!	; 0xfffffc92
 8a4:	622f6564 	eorvs	r6, pc, #100, 10	; 0x19000000
 8a8:	6472616f 	ldrbtvs	r6, [r2], #-367	; 0xfffffe91
 8ac:	6970722f 	ldmdbvs	r0!, {r0, r1, r2, r3, r5, r9, ip, sp, lr}^
 8b0:	61682f30 	cmnvs	r8, r0, lsr pc
 8b4:	7300006c 	movwvc	r0, #108	; 0x6c
 8b8:	69666474 	stmdbvs	r6!, {r2, r4, r5, r6, sl, sp, lr}^
 8bc:	632e656c 			; <UNDEFINED> instruction: 0x632e656c
 8c0:	01007070 	tsteq	r0, r0, ror r0
 8c4:	77730000 	ldrbvc	r0, [r3, -r0]!
 8c8:	00682e69 	rsbeq	r2, r8, r9, ror #28
 8cc:	73000002 	movwvc	r0, #2
 8d0:	6c6e6970 			; <UNDEFINED> instruction: 0x6c6e6970
 8d4:	2e6b636f 	cdpcs	3, 6, cr6, cr11, cr15, {3}
 8d8:	00020068 	andeq	r0, r2, r8, rrx
 8dc:	6c696600 	stclvs	6, cr6, [r9], #-0
 8e0:	73797365 	cmnvc	r9, #-1811939327	; 0x94000001
 8e4:	2e6d6574 	mcrcs	5, 3, r6, cr13, cr4, {3}
 8e8:	00030068 	andeq	r0, r3, r8, rrx
 8ec:	6f727000 	svcvs	0x00727000
 8f0:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
 8f4:	0200682e 	andeq	r6, r0, #3014656	; 0x2e0000
 8f8:	72700000 	rsbsvc	r0, r0, #0
 8fc:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
 900:	616d5f73 	smcvs	54771	; 0xd5f3
 904:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
 908:	00682e72 	rsbeq	r2, r8, r2, ror lr
 90c:	69000002 	stmdbvs	r0, {r1}
 910:	6564746e 	strbvs	r7, [r4, #-1134]!	; 0xfffffb92
 914:	00682e66 	rsbeq	r2, r8, r6, ror #28
 918:	00000004 	andeq	r0, r0, r4
 91c:	05000105 	streq	r0, [r0, #-261]	; 0xfffffefb
 920:	0089ec02 	addeq	lr, r9, r2, lsl #24
 924:	05051600 	streq	r1, [r5, #-1536]	; 0xfffffa00
 928:	0c052f69 	stceq	15, cr2, [r5], {105}	; 0x69
 92c:	2f01054c 	svccs	0x0001054c
 930:	83050585 	movwhi	r0, #21893	; 0x5585
 934:	2f01054b 	svccs	0x0001054b
 938:	4b050585 	blmi	141f54 <__bss_end+0x138550>
 93c:	852f0105 	strhi	r0, [pc, #-261]!	; 83f <shift+0x83f>
 940:	4ba10505 	blmi	fe841d5c <__bss_end+0xfe838358>
 944:	0c052f4b 	stceq	15, cr2, [r5], {75}	; 0x4b
 948:	2f01054b 	svccs	0x0001054b
 94c:	bd050585 	cfstr32lt	mvfx0, [r5, #-532]	; 0xfffffdec
 950:	2f4b4b4b 	svccs	0x004b4b4b
 954:	054c0c05 	strbeq	r0, [ip, #-3077]	; 0xfffff3fb
 958:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 95c:	4b4bbd05 	blmi	12efd78 <__bss_end+0x12e6374>
 960:	0c052f4b 	stceq	15, cr2, [r5], {75}	; 0x4b
 964:	2f01054c 	svccs	0x0001054c
 968:	83050585 	movwhi	r0, #21893	; 0x5585
 96c:	2f01054b 	svccs	0x0001054b
 970:	bd050585 	cfstr32lt	mvfx0, [r5, #-532]	; 0xfffffdec
 974:	2f4b4b4b 	svccs	0x004b4b4b
 978:	054c0c05 	strbeq	r0, [ip, #-3077]	; 0xfffff3fb
 97c:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 980:	4b4ba105 	blmi	12e8d9c <__bss_end+0x12df398>
 984:	4c0c052f 	cfstr32mi	mvfx0, [ip], {47}	; 0x2f
 988:	852f0105 	strhi	r0, [pc, #-261]!	; 88b <shift+0x88b>
 98c:	4bbd0505 	blmi	fef41da8 <__bss_end+0xfef383a4>
 990:	052f4b4b 	streq	r4, [pc, #-2891]!	; fffffe4d <__bss_end+0xffff6449>
 994:	01054c0c 	tsteq	r5, ip, lsl #24
 998:	0505852f 	streq	r8, [r5, #-1327]	; 0xfffffad1
 99c:	2f4b4ba1 	svccs	0x004b4ba1
 9a0:	054c0c05 	strbeq	r0, [ip, #-3077]	; 0xfffff3fb
 9a4:	05859f01 	streq	r9, [r5, #3841]	; 0xf01
 9a8:	05056720 	streq	r6, [r5, #-1824]	; 0xfffff8e0
 9ac:	054b4b4d 	strbeq	r4, [fp, #-2893]	; 0xfffff4b3
 9b0:	0105300c 	tsteq	r5, ip
 9b4:	2005852f 	andcs	r8, r5, pc, lsr #10
 9b8:	4d050567 	cfstr32mi	mvfx0, [r5, #-412]	; 0xfffffe64
 9bc:	0c054b4b 			; <UNDEFINED> instruction: 0x0c054b4b
 9c0:	2f010530 	svccs	0x00010530
 9c4:	83200585 			; <UNDEFINED> instruction: 0x83200585
 9c8:	4b4c0505 	blmi	1301de4 <__bss_end+0x12f83e0>
 9cc:	2f01054b 	svccs	0x0001054b
 9d0:	67200585 	strvs	r0, [r0, -r5, lsl #11]!
 9d4:	4b4d0505 	blmi	1341df0 <__bss_end+0x13383ec>
 9d8:	300c054b 	andcc	r0, ip, fp, asr #10
 9dc:	872f0105 	strhi	r0, [pc, -r5, lsl #2]!
 9e0:	9fa00c05 	svcls	0x00a00c05
 9e4:	05bc3105 	ldreq	r3, [ip, #261]!	; 0x105
 9e8:	36056629 	strcc	r6, [r5], -r9, lsr #12
 9ec:	300f052e 	andcc	r0, pc, lr, lsr #10
 9f0:	05661305 	strbeq	r1, [r6, #-773]!	; 0xfffffcfb
 9f4:	10058409 	andne	r8, r5, r9, lsl #8
 9f8:	9f0105d8 	svcls	0x000105d8
 9fc:	01000802 	tsteq	r0, r2, lsl #16
 a00:	00038b01 	andeq	r8, r3, r1, lsl #22
 a04:	74000300 	strvc	r0, [r0], #-768	; 0xfffffd00
 a08:	02000000 	andeq	r0, r0, #0
 a0c:	0d0efb01 	vstreq	d15, [lr, #-4]
 a10:	01010100 	mrseq	r0, (UNDEF: 17)
 a14:	00000001 	andeq	r0, r0, r1
 a18:	01000001 	tsteq	r0, r1
 a1c:	6573552f 	ldrbvs	r5, [r3, #-1327]!	; 0xfffffad1
 a20:	772f7372 			; <UNDEFINED> instruction: 0x772f7372
 a24:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
 a28:	2f696a72 	svccs	0x00696a72
 a2c:	6b736544 	blvs	1cd9f44 <__bss_end+0x1cd0540>
 a30:	2f706f74 	svccs	0x00706f74
 a34:	2f564146 	svccs	0x00564146
 a38:	6176614e 	cmnvs	r6, lr, asr #2
 a3c:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
 a40:	4f2f6963 	svcmi	0x002f6963
 a44:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
 a48:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
 a4c:	6b6c6172 	blvs	1b1901c <__bss_end+0x1b0f618>
 a50:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
 a54:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
 a58:	756f732f 	strbvc	r7, [pc, #-815]!	; 731 <shift+0x731>
 a5c:	73656372 	cmnvc	r5, #-939524095	; 0xc8000001
 a60:	6474732f 	ldrbtvs	r7, [r4], #-815	; 0xfffffcd1
 a64:	2f62696c 	svccs	0x0062696c
 a68:	00637273 	rsbeq	r7, r3, r3, ror r2
 a6c:	64747300 	ldrbtvs	r7, [r4], #-768	; 0xfffffd00
 a70:	69727473 	ldmdbvs	r2!, {r0, r1, r4, r5, r6, sl, ip, sp, lr}^
 a74:	632e676e 			; <UNDEFINED> instruction: 0x632e676e
 a78:	01007070 	tsteq	r0, r0, ror r0
 a7c:	05000000 	streq	r0, [r0, #-0]
 a80:	02050001 	andeq	r0, r5, #1
 a84:	00008e48 	andeq	r8, r0, r8, asr #28
 a88:	bb06051a 	bllt	181ef8 <__bss_end+0x1784f4>
 a8c:	054c0f05 	strbeq	r0, [ip, #-3845]	; 0xfffff0fb
 a90:	0a056821 	beq	15ab1c <__bss_end+0x151118>
 a94:	2e0b05ba 	mcrcs	5, 0, r0, cr11, cr10, {5}
 a98:	054a2705 	strbeq	r2, [sl, #-1797]	; 0xfffff8fb
 a9c:	09054a0d 	stmdbeq	r5, {r0, r2, r3, r9, fp, lr}
 aa0:	9f04052f 	svcls	0x0004052f
 aa4:	05620205 	strbeq	r0, [r2, #-517]!	; 0xfffffdfb
 aa8:	10053505 	andne	r3, r5, r5, lsl #10
 aac:	2e110568 	cfmsc32cs	mvfx0, mvfx1, mvfx8
 ab0:	054a2205 	strbeq	r2, [sl, #-517]	; 0xfffffdfb
 ab4:	0a052e13 	beq	14c308 <__bss_end+0x142904>
 ab8:	6909052f 	stmdbvs	r9, {r0, r1, r2, r3, r5, r8, sl}
 abc:	052e0a05 	streq	r0, [lr, #-2565]!	; 0xfffff5fb
 ac0:	03054a0c 	movweq	r4, #23052	; 0x5a0c
 ac4:	680b054b 	stmdavs	fp, {r0, r1, r3, r6, r8, sl}
 ac8:	02001805 	andeq	r1, r0, #327680	; 0x50000
 acc:	054a0304 	strbeq	r0, [sl, #-772]	; 0xfffffcfc
 ad0:	04020014 	streq	r0, [r2], #-20	; 0xffffffec
 ad4:	15059e03 	strne	r9, [r5, #-3587]	; 0xfffff1fd
 ad8:	02040200 	andeq	r0, r4, #0, 4
 adc:	00180568 	andseq	r0, r8, r8, ror #10
 ae0:	82020402 	andhi	r0, r2, #33554432	; 0x2000000
 ae4:	02000805 	andeq	r0, r0, #327680	; 0x50000
 ae8:	054a0204 	strbeq	r0, [sl, #-516]	; 0xfffffdfc
 aec:	0402001a 	streq	r0, [r2], #-26	; 0xffffffe6
 af0:	1b054b02 	blne	153700 <__bss_end+0x149cfc>
 af4:	02040200 	andeq	r0, r4, #0, 4
 af8:	000c052e 	andeq	r0, ip, lr, lsr #10
 afc:	4a020402 	bmi	81b0c <__bss_end+0x78108>
 b00:	02000f05 	andeq	r0, r0, #5, 30
 b04:	05820204 	streq	r0, [r2, #516]	; 0x204
 b08:	0402001b 	streq	r0, [r2], #-27	; 0xffffffe5
 b0c:	11054a02 	tstne	r5, r2, lsl #20
 b10:	02040200 	andeq	r0, r4, #0, 4
 b14:	000a052e 	andeq	r0, sl, lr, lsr #10
 b18:	2f020402 	svccs	0x00020402
 b1c:	02000b05 	andeq	r0, r0, #5120	; 0x1400
 b20:	052e0204 	streq	r0, [lr, #-516]!	; 0xfffffdfc
 b24:	0402000d 	streq	r0, [r2], #-13
 b28:	02054a02 	andeq	r4, r5, #8192	; 0x2000
 b2c:	02040200 	andeq	r0, r4, #0, 4
 b30:	88010546 	stmdahi	r1, {r1, r2, r6, r8, sl}
 b34:	83060585 	movwhi	r0, #25989	; 0x6585
 b38:	054c0905 	strbeq	r0, [ip, #-2309]	; 0xfffff6fb
 b3c:	0a054a10 	beq	153384 <__bss_end+0x149980>
 b40:	bb07054c 	bllt	1c2078 <__bss_end+0x1b8674>
 b44:	054a0305 	strbeq	r0, [sl, #-773]	; 0xfffffcfb
 b48:	04020017 	streq	r0, [r2], #-23	; 0xffffffe9
 b4c:	14054a01 	strne	r4, [r5], #-2561	; 0xfffff5ff
 b50:	01040200 	mrseq	r0, R12_usr
 b54:	4d0d054a 	cfstr32mi	mvfx0, [sp, #-296]	; 0xfffffed8
 b58:	054a1405 	strbeq	r1, [sl, #-1029]	; 0xfffffbfb
 b5c:	08052e0a 	stmdaeq	r5, {r1, r3, r9, sl, fp, sp}
 b60:	03020568 	movweq	r0, #9576	; 0x2568
 b64:	09056678 	stmdbeq	r5, {r3, r4, r5, r6, r9, sl, sp, lr}
 b68:	052e0b03 	streq	r0, [lr, #-2819]!	; 0xfffff4fd
 b6c:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 b70:	0505bb08 	streq	fp, [r5, #-2824]	; 0xfffff4f8
 b74:	830d054d 	movwhi	r0, #54605	; 0xd54d
 b78:	05661005 	strbeq	r1, [r6, #-5]!
 b7c:	09054b0f 	stmdbeq	r5, {r0, r1, r2, r3, r8, r9, fp, lr}
 b80:	831c056a 	tsthi	ip, #444596224	; 0x1a800000
 b84:	6a660b05 	bvs	19837a0 <__bss_end+0x1979d9c>
 b88:	054b0505 	strbeq	r0, [fp, #-1285]	; 0xfffffafb
 b8c:	14056711 	strne	r6, [r5], #-1809	; 0xfffff8ef
 b90:	68190566 	ldmdavs	r9, {r1, r2, r5, r6, r8, sl}
 b94:	05672a05 	strbeq	r2, [r7, #-2565]!	; 0xfffff5fb
 b98:	0558081e 	ldrbeq	r0, [r8, #-2078]	; 0xfffff7e2
 b9c:	1e052e15 	mcrne	14, 0, r2, cr5, cr5, {0}
 ba0:	4a180566 	bmi	602140 <__bss_end+0x5f873c>
 ba4:	052f1605 	streq	r1, [pc, #-1541]!	; 5a7 <shift+0x5a7>
 ba8:	1405d409 	strne	sp, [r5], #-1033	; 0xfffffbf7
 bac:	83100535 	tsthi	r0, #222298112	; 0xd400000
 bb0:	05660d05 	strbeq	r0, [r6, #-3333]!	; 0xfffff2fb
 bb4:	10056612 	andne	r6, r5, r2, lsl r6
 bb8:	2d05054a 	cfstr32cs	mvfx0, [r5, #-296]	; 0xfffffed8
 bbc:	670d0533 	smladxvs	sp, r3, r5, r0
 bc0:	05661005 	strbeq	r1, [r6, #-5]!
 bc4:	15054e0e 	strne	r4, [r5, #-3598]	; 0xfffff1f2
 bc8:	03040200 	movweq	r0, #16896	; 0x4200
 bcc:	0017054a 	andseq	r0, r7, sl, asr #10
 bd0:	2e030402 	cdpcs	4, 0, cr0, cr3, cr2, {0}
 bd4:	02001205 	andeq	r1, r0, #1342177280	; 0x50000000
 bd8:	05670204 	strbeq	r0, [r7, #-516]!	; 0xfffffdfc
 bdc:	0402000d 	streq	r0, [r2], #-13
 be0:	16058302 	strne	r8, [r5], -r2, lsl #6
 be4:	02040200 	andeq	r0, r4, #0, 4
 be8:	000d0583 	andeq	r0, sp, r3, lsl #11
 bec:	4a020402 	bmi	81bfc <__bss_end+0x781f8>
 bf0:	02001605 	andeq	r1, r0, #5242880	; 0x500000
 bf4:	05660204 	strbeq	r0, [r6, #-516]!	; 0xfffffdfc
 bf8:	04020010 	streq	r0, [r2], #-16
 bfc:	12054a02 	andne	r4, r5, #8192	; 0x2000
 c00:	02040200 	andeq	r0, r4, #0, 4
 c04:	0005052f 	andeq	r0, r5, pc, lsr #10
 c08:	b6020402 	strlt	r0, [r2], -r2, lsl #8
 c0c:	058a0a05 	streq	r0, [sl, #2565]	; 0xa05
 c10:	0f056905 	svceq	0x00056905
 c14:	671d0567 	ldrvs	r0, [sp, -r7, ror #10]
 c18:	02002005 	andeq	r2, r0, #5
 c1c:	05820104 	streq	r0, [r2, #260]	; 0x104
 c20:	0402001d 	streq	r0, [r2], #-29	; 0xffffffe3
 c24:	11054a01 	tstne	r5, r1, lsl #20
 c28:	6614054b 	ldrvs	r0, [r4], -fp, asr #10
 c2c:	31490905 	cmpcc	r9, r5, lsl #18
 c30:	02001d05 	andeq	r1, r0, #320	; 0x140
 c34:	05820104 	streq	r0, [r2, #260]	; 0x104
 c38:	0402001a 	streq	r0, [r2], #-26	; 0xffffffe6
 c3c:	12054a01 	andne	r4, r5, #4096	; 0x1000
 c40:	6a0c054b 	bvs	302174 <__bss_end+0x2f8770>
 c44:	bd2f0105 	stflts	f0, [pc, #-20]!	; c38 <shift+0xc38>
 c48:	05bd0905 	ldreq	r0, [sp, #2309]!	; 0x905
 c4c:	04020016 	streq	r0, [r2], #-22	; 0xffffffea
 c50:	1d054a04 	vstrne	s8, [r5, #-16]
 c54:	02040200 	andeq	r0, r4, #0, 4
 c58:	001e0582 	andseq	r0, lr, r2, lsl #11
 c5c:	2e020402 	cdpcs	4, 0, cr0, cr2, cr2, {0}
 c60:	02001605 	andeq	r1, r0, #5242880	; 0x500000
 c64:	05660204 	strbeq	r0, [r6, #-516]!	; 0xfffffdfc
 c68:	04020011 	streq	r0, [r2], #-17	; 0xffffffef
 c6c:	12054b03 	andne	r4, r5, #3072	; 0xc00
 c70:	03040200 	movweq	r0, #16896	; 0x4200
 c74:	0008052e 	andeq	r0, r8, lr, lsr #10
 c78:	4a030402 	bmi	c1c88 <__bss_end+0xb8284>
 c7c:	02000905 	andeq	r0, r0, #81920	; 0x14000
 c80:	052e0304 	streq	r0, [lr, #-772]!	; 0xfffffcfc
 c84:	04020012 	streq	r0, [r2], #-18	; 0xffffffee
 c88:	0b054a03 	bleq	15349c <__bss_end+0x149a98>
 c8c:	03040200 	movweq	r0, #16896	; 0x4200
 c90:	0002052e 	andeq	r0, r2, lr, lsr #10
 c94:	2d030402 	cfstrscs	mvf0, [r3, #-8]
 c98:	02000b05 	andeq	r0, r0, #5120	; 0x1400
 c9c:	05840204 	streq	r0, [r4, #516]	; 0x204
 ca0:	04020008 	streq	r0, [r2], #-8
 ca4:	09058301 	stmdbeq	r5, {r0, r8, r9, pc}
 ca8:	01040200 	mrseq	r0, R12_usr
 cac:	000b052e 	andeq	r0, fp, lr, lsr #10
 cb0:	4a010402 	bmi	41cc0 <__bss_end+0x382bc>
 cb4:	02000205 	andeq	r0, r0, #1342177280	; 0x50000000
 cb8:	05490104 	strbeq	r0, [r9, #-260]	; 0xfffffefc
 cbc:	0105850b 	tsteq	r5, fp, lsl #10
 cc0:	0e05852f 	cfsh32eq	mvfx8, mvfx5, #31
 cc4:	661105bc 			; <UNDEFINED> instruction: 0x661105bc
 cc8:	05bc2005 	ldreq	r2, [ip, #5]!
 ccc:	1f05660b 	svcne	0x0005660b
 cd0:	660a054b 	strvs	r0, [sl], -fp, asr #10
 cd4:	054b0805 	strbeq	r0, [fp, #-2053]	; 0xfffff7fb
 cd8:	16058311 			; <UNDEFINED> instruction: 0x16058311
 cdc:	6708052e 	strvs	r0, [r8, -lr, lsr #10]
 ce0:	05671105 	strbeq	r1, [r7, #-261]!	; 0xfffffefb
 ce4:	01054d0b 	tsteq	r5, fp, lsl #26
 ce8:	0605852f 	streq	r8, [r5], -pc, lsr #10
 cec:	4c0b0583 	cfstr32mi	mvfx0, [fp], {131}	; 0x83
 cf0:	052e0c05 	streq	r0, [lr, #-3077]!	; 0xfffff3fb
 cf4:	0405660e 	streq	r6, [r5], #-1550	; 0xfffff9f2
 cf8:	6502054b 	strvs	r0, [r2, #-1355]	; 0xfffffab5
 cfc:	05310905 	ldreq	r0, [r1, #-2309]!	; 0xfffff6fb
 d00:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 d04:	0b059f08 	bleq	16892c <__bss_end+0x15ef28>
 d08:	0014054c 	andseq	r0, r4, ip, asr #10
 d0c:	4a030402 	bmi	c1d1c <__bss_end+0xb8318>
 d10:	02000705 	andeq	r0, r0, #1310720	; 0x140000
 d14:	05830204 	streq	r0, [r3, #516]	; 0x204
 d18:	04020008 	streq	r0, [r2], #-8
 d1c:	0a052e02 	beq	14c52c <__bss_end+0x142b28>
 d20:	02040200 	andeq	r0, r4, #0, 4
 d24:	0002054a 	andeq	r0, r2, sl, asr #10
 d28:	49020402 	stmdbmi	r2, {r1, sl}
 d2c:	85840105 	strhi	r0, [r4, #261]	; 0x105
 d30:	05bb0e05 	ldreq	r0, [fp, #3589]!	; 0xe05
 d34:	0b054b08 	bleq	15395c <__bss_end+0x149f58>
 d38:	0014054c 	andseq	r0, r4, ip, asr #10
 d3c:	4a030402 	bmi	c1d4c <__bss_end+0xb8348>
 d40:	02001605 	andeq	r1, r0, #5242880	; 0x500000
 d44:	05830204 	streq	r0, [r3, #516]	; 0x204
 d48:	04020017 	streq	r0, [r2], #-23	; 0xffffffe9
 d4c:	0a052e02 	beq	14c55c <__bss_end+0x142b58>
 d50:	02040200 	andeq	r0, r4, #0, 4
 d54:	000b054a 	andeq	r0, fp, sl, asr #10
 d58:	2e020402 	cdpcs	4, 0, cr0, cr2, cr2, {0}
 d5c:	02001705 	andeq	r1, r0, #1310720	; 0x140000
 d60:	054a0204 	strbeq	r0, [sl, #-516]	; 0xfffffdfc
 d64:	0402000d 	streq	r0, [r2], #-13
 d68:	02052e02 	andeq	r2, r5, #2, 28
 d6c:	02040200 	andeq	r0, r4, #0, 4
 d70:	8401052d 	strhi	r0, [r1], #-1325	; 0xfffffad3
 d74:	05842a05 	streq	r2, [r4, #2565]	; 0xa05
 d78:	05679f10 	strbeq	r9, [r7, #-3856]!	; 0xfffff0f0
 d7c:	09056711 	stmdbeq	r5, {r0, r4, r8, r9, sl, sp, lr}
 d80:	1005bb2e 	andne	fp, r5, lr, lsr #22
 d84:	66120566 	ldrvs	r0, [r2], -r6, ror #10
 d88:	024b0105 	subeq	r0, fp, #1073741825	; 0x40000001
 d8c:	01010006 	tsteq	r1, r6

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
      58:	0bc80704 	bleq	ff201c70 <__bss_end+0xff1f826c>
      5c:	5b020000 	blpl	80064 <__bss_end+0x76660>
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
     128:	00000bc8 	andeq	r0, r0, r8, asr #23
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
     174:	cb104801 	blgt	412180 <__bss_end+0x40877c>
     178:	d4000000 	strle	r0, [r0], #-0
     17c:	58000081 	stmdapl	r0, {r0, r7}
     180:	01000000 	mrseq	r0, (UNDEF: 0)
     184:	0000cb9c 	muleq	r0, ip, fp
     188:	02b40a00 	adcseq	r0, r4, #0, 20
     18c:	4a010000 	bmi	40194 <__bss_end+0x36790>
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
     21c:	ba0d9c01 	blt	367228 <__bss_end+0x35d824>
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
     24c:	8b120f01 	blhi	483e58 <__bss_end+0x47a454>
     250:	0f000001 	svceq	0x00000001
     254:	0000019e 	muleq	r0, lr, r1
     258:	03d51000 	bicseq	r1, r5, #0
     25c:	0a010000 	beq	40264 <__bss_end+0x36860>
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
     2b4:	8b140074 	blhi	50048c <__bss_end+0x4f6a88>
     2b8:	a4000001 	strge	r0, [r0], #-1
     2bc:	38000080 	stmdacc	r0, {r7}
     2c0:	01000000 	mrseq	r0, (UNDEF: 0)
     2c4:	0067139c 	mlseq	r7, ip, r3, r1
     2c8:	9e2f0a01 	vmulls.f32	s0, s30, s2
     2cc:	02000001 	andeq	r0, r0, #1
     2d0:	00007491 	muleq	r0, r1, r4
     2d4:	00000ba6 	andeq	r0, r0, r6, lsr #23
     2d8:	01e00004 	mvneq	r0, r4
     2dc:	01040000 	mrseq	r0, (UNDEF: 4)
     2e0:	000001e1 	andeq	r0, r0, r1, ror #3
     2e4:	000ada04 	andeq	sp, sl, r4, lsl #20
     2e8:	00005600 	andeq	r5, r0, r0, lsl #12
     2ec:	00822c00 	addeq	r2, r2, r0, lsl #24
     2f0:	0007c000 	andeq	ip, r7, r0
     2f4:	00024600 	andeq	r4, r2, r0, lsl #12
     2f8:	08010200 	stmdaeq	r1, {r9}
     2fc:	00000c75 	andeq	r0, r0, r5, ror ip
     300:	00002503 	andeq	r2, r0, r3, lsl #10
     304:	05020200 	streq	r0, [r2, #-512]	; 0xfffffe00
     308:	00000a78 	andeq	r0, r0, r8, ror sl
     30c:	69050404 	stmdbvs	r5, {r2, sl}
     310:	0500746e 	streq	r7, [r0, #-1134]	; 0xfffffb92
     314:	00000832 	andeq	r0, r0, r2, lsr r8
     318:	4b070702 	blmi	1c1f28 <__bss_end+0x1b8524>
     31c:	02000000 	andeq	r0, r0, #0
     320:	0c6c0801 	stcleq	8, cr0, [ip], #-4
     324:	02020000 	andeq	r0, r2, #0
     328:	000d6f07 	andeq	r6, sp, r7, lsl #30
     32c:	06570500 	ldrbeq	r0, [r7], -r0, lsl #10
     330:	09020000 	stmdbeq	r2, {}	; <UNPREDICTABLE>
     334:	00006a07 	andeq	r6, r0, r7, lsl #20
     338:	00590300 	subseq	r0, r9, r0, lsl #6
     33c:	04020000 	streq	r0, [r2], #-0
     340:	000bc807 	andeq	ip, fp, r7, lsl #16
     344:	006a0300 	rsbeq	r0, sl, r0, lsl #6
     348:	35060000 	strcc	r0, [r6, #-0]
     34c:	0800000e 	stmdaeq	r0, {r1, r2, r3}
     350:	9c080603 	stcls	6, cr0, [r8], {3}
     354:	07000000 	streq	r0, [r0, -r0]
     358:	03003072 	movweq	r3, #114	; 0x72
     35c:	00590e08 	subseq	r0, r9, r8, lsl #28
     360:	07000000 	streq	r0, [r0, -r0]
     364:	03003172 	movweq	r3, #370	; 0x172
     368:	00590e09 	subseq	r0, r9, r9, lsl #28
     36c:	00040000 	andeq	r0, r4, r0
     370:	000b3d08 	andeq	r3, fp, r8, lsl #26
     374:	38040500 	stmdacc	r4, {r8, sl}
     378:	03000000 	movweq	r0, #0
     37c:	00d30c1e 	sbcseq	r0, r3, lr, lsl ip
     380:	4f090000 	svcmi	0x00090000
     384:	00000006 	andeq	r0, r0, r6
     388:	0007c509 	andeq	ip, r7, r9, lsl #10
     38c:	5f090100 	svcpl	0x00090100
     390:	0200000b 	andeq	r0, r0, #11
     394:	000ca809 	andeq	sl, ip, r9, lsl #16
     398:	9d090300 	stcls	3, cr0, [r9, #-0]
     39c:	04000007 	streq	r0, [r0], #-7
     3a0:	000a5709 	andeq	r5, sl, r9, lsl #14
     3a4:	08000500 	stmdaeq	r0, {r8, sl}
     3a8:	00000ac2 	andeq	r0, r0, r2, asr #21
     3ac:	00380405 	eorseq	r0, r8, r5, lsl #8
     3b0:	3f030000 	svccc	0x00030000
     3b4:	0001100c 	andeq	r1, r1, ip
     3b8:	072e0900 	streq	r0, [lr, -r0, lsl #18]!
     3bc:	09000000 	stmdbeq	r0, {}	; <UNPREDICTABLE>
     3c0:	000007c0 	andeq	r0, r0, r0, asr #15
     3c4:	0dce0901 	vstreq.16	s1, [lr, #2]	; <UNPREDICTABLE>
     3c8:	09020000 	stmdbeq	r2, {}	; <UNPREDICTABLE>
     3cc:	000009b8 			; <UNDEFINED> instruction: 0x000009b8
     3d0:	07ac0903 	streq	r0, [ip, r3, lsl #18]!
     3d4:	09040000 	stmdbeq	r4, {}	; <UNPREDICTABLE>
     3d8:	0000083a 	andeq	r0, r0, sl, lsr r8
     3dc:	068d0905 	streq	r0, [sp], r5, lsl #18
     3e0:	00060000 	andeq	r0, r6, r0
     3e4:	00066c08 	andeq	r6, r6, r8, lsl #24
     3e8:	38040500 	stmdacc	r4, {r8, sl}
     3ec:	03000000 	movweq	r0, #0
     3f0:	013b0c66 	teqeq	fp, r6, ror #24
     3f4:	61090000 	mrsvs	r0, (UNDEF: 9)
     3f8:	0000000c 	andeq	r0, r0, ip
     3fc:	00058709 	andeq	r8, r5, r9, lsl #14
     400:	8f090100 	svchi	0x00090100
     404:	0200000b 	andeq	r0, r0, #11
     408:	000a6009 	andeq	r6, sl, r9
     40c:	0a000300 	beq	1014 <shift+0x1014>
     410:	0000098a 	andeq	r0, r0, sl, lsl #19
     414:	65140504 	ldrvs	r0, [r4, #-1284]	; 0xfffffafc
     418:	05000000 	streq	r0, [r0, #-0]
     41c:	00981803 	addseq	r1, r8, r3, lsl #16
     420:	0be90a00 	bleq	ffa42c28 <__bss_end+0xffa39224>
     424:	06040000 	streq	r0, [r4], -r0
     428:	00006514 	andeq	r6, r0, r4, lsl r5
     42c:	1c030500 	cfstr32ne	mvfx0, [r3], {-0}
     430:	0a000098 	beq	698 <shift+0x698>
     434:	0000084f 	andeq	r0, r0, pc, asr #16
     438:	651a0705 	ldrvs	r0, [sl, #-1797]	; 0xfffff8fb
     43c:	05000000 	streq	r0, [r0, #-0]
     440:	00982003 	addseq	r2, r8, r3
     444:	0a820a00 	beq	fe082c4c <__bss_end+0xfe079248>
     448:	09050000 	stmdbeq	r5, {}	; <UNPREDICTABLE>
     44c:	0000651a 	andeq	r6, r0, sl, lsl r5
     450:	24030500 	strcs	r0, [r3], #-1280	; 0xfffffb00
     454:	0a000098 	beq	6bc <shift+0x6bc>
     458:	00000841 	andeq	r0, r0, r1, asr #16
     45c:	651a0b05 	ldrvs	r0, [sl, #-2821]	; 0xfffff4fb
     460:	05000000 	streq	r0, [r0, #-0]
     464:	00982803 	addseq	r2, r8, r3, lsl #16
     468:	0a440a00 	beq	1102c70 <__bss_end+0x10f926c>
     46c:	0d050000 	stceq	0, cr0, [r5, #-0]
     470:	0000651a 	andeq	r6, r0, sl, lsl r5
     474:	2c030500 	cfstr32cs	mvfx0, [r3], {-0}
     478:	0a000098 	beq	6e0 <shift+0x6e0>
     47c:	0000062f 	andeq	r0, r0, pc, lsr #12
     480:	651a0f05 	ldrvs	r0, [sl, #-3845]	; 0xfffff0fb
     484:	05000000 	streq	r0, [r0, #-0]
     488:	00983003 	addseq	r3, r8, r3
     48c:	12270800 	eorne	r0, r7, #0, 16
     490:	04050000 	streq	r0, [r5], #-0
     494:	00000038 	andeq	r0, r0, r8, lsr r0
     498:	de0c1b05 	vmlale.f64	d1, d12, d5
     49c:	09000001 	stmdbeq	r0, {r0}
     4a0:	000005de 	ldrdeq	r0, [r0], -lr
     4a4:	0cf80900 			; <UNDEFINED> instruction: 0x0cf80900
     4a8:	09010000 	stmdbeq	r1, {}	; <UNPREDICTABLE>
     4ac:	00000dc9 	andeq	r0, r0, r9, asr #27
     4b0:	590b0002 	stmdbpl	fp, {r1}
     4b4:	02000004 	andeq	r0, r0, #4
     4b8:	08b30201 	ldmeq	r3!, {r0, r9}
     4bc:	040c0000 	streq	r0, [ip], #-0
     4c0:	0000002c 	andeq	r0, r0, ip, lsr #32
     4c4:	01de040c 	bicseq	r0, lr, ip, lsl #8
     4c8:	e80a0000 	stmda	sl, {}	; <UNPREDICTABLE>
     4cc:	06000005 	streq	r0, [r0], -r5
     4d0:	00651404 	rsbeq	r1, r5, r4, lsl #8
     4d4:	03050000 	movweq	r0, #20480	; 0x5000
     4d8:	00009834 	andeq	r9, r0, r4, lsr r8
     4dc:	000b710a 	andeq	r7, fp, sl, lsl #2
     4e0:	14070600 	strne	r0, [r7], #-1536	; 0xfffffa00
     4e4:	00000065 	andeq	r0, r0, r5, rrx
     4e8:	98380305 	ldmdals	r8!, {r0, r2, r8, r9}
     4ec:	1d0a0000 	stcne	0, cr0, [sl, #-0]
     4f0:	06000005 	streq	r0, [r0], -r5
     4f4:	0065140a 	rsbeq	r1, r5, sl, lsl #8
     4f8:	03050000 	movweq	r0, #20480	; 0x5000
     4fc:	0000983c 	andeq	r9, r0, ip, lsr r8
     500:	00069208 	andeq	r9, r6, r8, lsl #4
     504:	38040500 	stmdacc	r4, {r8, sl}
     508:	06000000 	streq	r0, [r0], -r0
     50c:	02630c0d 	rsbeq	r0, r3, #3328	; 0xd00
     510:	4e0d0000 	cdpmi	0, 0, cr0, cr13, cr0, {0}
     514:	00007765 	andeq	r7, r0, r5, ror #14
     518:	0004f209 	andeq	pc, r4, r9, lsl #4
     51c:	15090100 	strne	r0, [r9, #-256]	; 0xffffff00
     520:	02000005 	andeq	r0, r0, #5
     524:	0006ab09 	andeq	sl, r6, r9, lsl #22
     528:	9a090300 	bls	241130 <__bss_end+0x23772c>
     52c:	0400000c 	streq	r0, [r0], #-12
     530:	0004df09 	andeq	sp, r4, r9, lsl #30
     534:	06000500 	streq	r0, [r0], -r0, lsl #10
     538:	00000601 	andeq	r0, r0, r1, lsl #12
     53c:	081b0610 	ldmdaeq	fp, {r4, r9, sl}
     540:	000002a2 	andeq	r0, r0, r2, lsr #5
     544:	00726c07 	rsbseq	r6, r2, r7, lsl #24
     548:	a2131d06 	andsge	r1, r3, #384	; 0x180
     54c:	00000002 	andeq	r0, r0, r2
     550:	00707307 	rsbseq	r7, r0, r7, lsl #6
     554:	a2131e06 	andsge	r1, r3, #6, 28	; 0x60
     558:	04000002 	streq	r0, [r0], #-2
     55c:	00637007 	rsbeq	r7, r3, r7
     560:	a2131f06 	andsge	r1, r3, #6, 30
     564:	08000002 	stmdaeq	r0, {r1}
     568:	000ab20e 	andeq	fp, sl, lr, lsl #4
     56c:	13200600 	nopne	{0}	; <UNPREDICTABLE>
     570:	000002a2 	andeq	r0, r0, r2, lsr #5
     574:	0402000c 	streq	r0, [r2], #-12
     578:	000bc307 	andeq	ip, fp, r7, lsl #6
     57c:	02a20300 	adceq	r0, r2, #0, 6
     580:	90060000 	andls	r0, r6, r0
     584:	70000007 	andvc	r0, r0, r7
     588:	3e082806 	cdpcc	8, 0, cr2, cr8, cr6, {0}
     58c:	0e000003 	cdpeq	0, 0, cr0, cr0, cr3, {0}
     590:	00000713 	andeq	r0, r0, r3, lsl r7
     594:	63122a06 	tstvs	r2, #24576	; 0x6000
     598:	00000002 	andeq	r0, r0, r2
     59c:	64697007 	strbtvs	r7, [r9], #-7
     5a0:	122b0600 	eorne	r0, fp, #0, 12
     5a4:	0000006a 	andeq	r0, r0, sl, rrx
     5a8:	0ce40e10 	stcleq	14, cr0, [r4], #64	; 0x40
     5ac:	2c060000 	stccs	0, cr0, [r6], {-0}
     5b0:	00022c11 	andeq	r2, r2, r1, lsl ip
     5b4:	470e1400 	strmi	r1, [lr, -r0, lsl #8]
     5b8:	0600000c 	streq	r0, [r0], -ip
     5bc:	006a122d 	rsbeq	r1, sl, sp, lsr #4
     5c0:	0e180000 	cdpeq	0, 1, cr0, cr8, cr0, {0}
     5c4:	000003e9 	andeq	r0, r0, r9, ror #7
     5c8:	6a122e06 	bvs	48bde8 <__bss_end+0x4823e4>
     5cc:	1c000000 	stcne	0, cr0, [r0], {-0}
     5d0:	000b520e 	andeq	r5, fp, lr, lsl #4
     5d4:	0c2f0600 	stceq	6, cr0, [pc], #-0	; 5dc <shift+0x5dc>
     5d8:	0000033e 	andeq	r0, r0, lr, lsr r3
     5dc:	04790e20 	ldrbteq	r0, [r9], #-3616	; 0xfffff1e0
     5e0:	30060000 	andcc	r0, r6, r0
     5e4:	00003809 	andeq	r3, r0, r9, lsl #16
     5e8:	c60e6000 	strgt	r6, [lr], -r0
     5ec:	06000006 	streq	r0, [r0], -r6
     5f0:	00590e31 	subseq	r0, r9, r1, lsr lr
     5f4:	0e640000 	cdpeq	0, 6, cr0, cr4, cr0, {0}
     5f8:	00000a06 	andeq	r0, r0, r6, lsl #20
     5fc:	590e3306 	stmdbpl	lr, {r1, r2, r8, r9, ip, sp}
     600:	68000000 	stmdavs	r0, {}	; <UNPREDICTABLE>
     604:	0009fd0e 	andeq	pc, r9, lr, lsl #26
     608:	0e340600 	cfmsuba32eq	mvax0, mvax0, mvfx4, mvfx0
     60c:	00000059 	andeq	r0, r0, r9, asr r0
     610:	f00f006c 			; <UNDEFINED> instruction: 0xf00f006c
     614:	4e000001 	cdpmi	0, 0, cr0, cr0, cr1, {0}
     618:	10000003 	andne	r0, r0, r3
     61c:	0000006a 	andeq	r0, r0, sl, rrx
     620:	060a000f 	streq	r0, [sl], -pc
     624:	07000005 	streq	r0, [r0, -r5]
     628:	0065140a 	rsbeq	r1, r5, sl, lsl #8
     62c:	03050000 	movweq	r0, #20480	; 0x5000
     630:	00009840 	andeq	r9, r0, r0, asr #16
     634:	00088a08 	andeq	r8, r8, r8, lsl #20
     638:	38040500 	stmdacc	r4, {r8, sl}
     63c:	07000000 	streq	r0, [r0, -r0]
     640:	037f0c0d 	cmneq	pc, #3328	; 0xd00
     644:	d4090000 	strle	r0, [r9], #-0
     648:	0000000d 	andeq	r0, r0, sp
     64c:	000d0c09 	andeq	r0, sp, r9, lsl #24
     650:	06000100 	streq	r0, [r0], -r0, lsl #2
     654:	000006f5 	strdeq	r0, [r0], -r5
     658:	081b070c 	ldmdaeq	fp, {r2, r3, r8, r9, sl}
     65c:	000003b4 			; <UNDEFINED> instruction: 0x000003b4
     660:	0005ab0e 	andeq	sl, r5, lr, lsl #22
     664:	191d0700 	ldmdbne	sp, {r8, r9, sl}
     668:	000003b4 			; <UNDEFINED> instruction: 0x000003b4
     66c:	04ed0e00 	strbteq	r0, [sp], #3584	; 0xe00
     670:	1e070000 	cdpne	0, 0, cr0, cr7, cr0, {0}
     674:	0003b419 	andeq	fp, r3, r9, lsl r4
     678:	ae0e0400 	cfcpysge	mvf0, mvf14
     67c:	07000008 	streq	r0, [r0, -r8]
     680:	03ba131f 			; <UNDEFINED> instruction: 0x03ba131f
     684:	00080000 	andeq	r0, r8, r0
     688:	037f040c 	cmneq	pc, #12, 8	; 0xc000000
     68c:	040c0000 	streq	r0, [ip], #-0
     690:	000002ae 	andeq	r0, r0, lr, lsr #5
     694:	000a9411 	andeq	r9, sl, r1, lsl r4
     698:	22071400 	andcs	r1, r7, #0, 8
     69c:	00064207 	andeq	r4, r6, r7, lsl #4
     6a0:	09980e00 	ldmibeq	r8, {r9, sl, fp}
     6a4:	26070000 	strcs	r0, [r7], -r0
     6a8:	00005912 	andeq	r5, r0, r2, lsl r9
     6ac:	3a0e0000 	bcc	3806b4 <__bss_end+0x376cb0>
     6b0:	07000009 	streq	r0, [r0, -r9]
     6b4:	03b41d29 			; <UNDEFINED> instruction: 0x03b41d29
     6b8:	0e040000 	cdpeq	0, 0, cr0, cr4, cr0, {0}
     6bc:	000006b3 			; <UNDEFINED> instruction: 0x000006b3
     6c0:	b41d2c07 	ldrlt	r2, [sp], #-3079	; 0xfffff3f9
     6c4:	08000003 	stmdaeq	r0, {r0, r1}
     6c8:	0009ae12 	andeq	sl, r9, r2, lsl lr
     6cc:	0e2f0700 	cdpeq	7, 2, cr0, cr15, cr0, {0}
     6d0:	000006d2 	ldrdeq	r0, [r0], -r2
     6d4:	00000408 	andeq	r0, r0, r8, lsl #8
     6d8:	00000413 	andeq	r0, r0, r3, lsl r4
     6dc:	00064713 	andeq	r4, r6, r3, lsl r7
     6e0:	03b41400 			; <UNDEFINED> instruction: 0x03b41400
     6e4:	15000000 	strne	r0, [r0, #-0]
     6e8:	000007df 	ldrdeq	r0, [r0], -pc	; <UNPREDICTABLE>
     6ec:	670e3107 	strvs	r3, [lr, -r7, lsl #2]
     6f0:	e3000007 	movw	r0, #7
     6f4:	2b000001 	blcs	700 <shift+0x700>
     6f8:	36000004 	strcc	r0, [r0], -r4
     6fc:	13000004 	movwne	r0, #4
     700:	00000647 	andeq	r0, r0, r7, asr #12
     704:	0003ba14 	andeq	fp, r3, r4, lsl sl
     708:	ae160000 	cdpge	0, 1, cr0, cr6, cr0, {0}
     70c:	0700000c 	streq	r0, [r0, -ip]
     710:	08651d35 	stmdaeq	r5!, {r0, r2, r4, r5, r8, sl, fp, ip}^
     714:	03b40000 			; <UNDEFINED> instruction: 0x03b40000
     718:	4f020000 	svcmi	0x00020000
     71c:	55000004 	strpl	r0, [r0, #-4]
     720:	13000004 	movwne	r0, #4
     724:	00000647 	andeq	r0, r0, r7, asr #12
     728:	069e1600 	ldreq	r1, [lr], r0, lsl #12
     72c:	37070000 	strcc	r0, [r7, -r0]
     730:	0009be1d 	andeq	fp, r9, sp, lsl lr
     734:	0003b400 	andeq	fp, r3, r0, lsl #8
     738:	046e0200 	strbteq	r0, [lr], #-512	; 0xfffffe00
     73c:	04740000 	ldrbteq	r0, [r4], #-0
     740:	47130000 	ldrmi	r0, [r3, -r0]
     744:	00000006 	andeq	r0, r0, r6
     748:	00094d17 	andeq	r4, r9, r7, lsl sp
     74c:	31390700 	teqcc	r9, r0, lsl #14
     750:	00000660 	andeq	r0, r0, r0, ror #12
     754:	9416020c 	ldrls	r0, [r6], #-524	; 0xfffffdf4
     758:	0700000a 	streq	r0, [r0, -sl]
     75c:	07ee093c 			; <UNDEFINED> instruction: 0x07ee093c
     760:	06470000 	strbeq	r0, [r7], -r0
     764:	9b010000 	blls	4076c <__bss_end+0x36d68>
     768:	a1000004 	tstge	r0, r4
     76c:	13000004 	movwne	r0, #4
     770:	00000647 	andeq	r0, r0, r7, asr #12
     774:	071f1600 	ldreq	r1, [pc, -r0, lsl #12]
     778:	3f070000 	svccc	0x00070000
     77c:	00054e12 	andeq	r4, r5, r2, lsl lr
     780:	00005900 	andeq	r5, r0, r0, lsl #18
     784:	04ba0100 	ldrteq	r0, [sl], #256	; 0x100
     788:	04cf0000 	strbeq	r0, [pc], #0	; 790 <shift+0x790>
     78c:	47130000 	ldrmi	r0, [r3, -r0]
     790:	14000006 	strne	r0, [r0], #-6
     794:	00000669 	andeq	r0, r0, r9, ror #12
     798:	00006a14 	andeq	r6, r0, r4, lsl sl
     79c:	01e31400 	mvneq	r1, r0, lsl #8
     7a0:	18000000 	stmdane	r0, {}	; <UNPREDICTABLE>
     7a4:	00000d03 	andeq	r0, r0, r3, lsl #26
     7a8:	0e0e4207 	cdpeq	2, 0, cr4, cr14, cr7, {0}
     7ac:	01000006 	tsteq	r0, r6
     7b0:	000004e4 	andeq	r0, r0, r4, ror #9
     7b4:	000004ea 	andeq	r0, r0, sl, ror #9
     7b8:	00064713 	andeq	r4, r6, r3, lsl r7
     7bc:	30160000 	andscc	r0, r6, r0
     7c0:	07000005 	streq	r0, [r0, -r5]
     7c4:	05b01745 	ldreq	r1, [r0, #1861]!	; 0x745
     7c8:	03ba0000 			; <UNDEFINED> instruction: 0x03ba0000
     7cc:	03010000 	movweq	r0, #4096	; 0x1000
     7d0:	09000005 	stmdbeq	r0, {r0, r2}
     7d4:	13000005 	movwne	r0, #5
     7d8:	0000066f 	andeq	r0, r0, pc, ror #12
     7dc:	0b7c1600 	bleq	1f05fe4 <__bss_end+0x1efc5e0>
     7e0:	48070000 	stmdami	r7, {}	; <UNPREDICTABLE>
     7e4:	0003ff17 	andeq	pc, r3, r7, lsl pc	; <UNPREDICTABLE>
     7e8:	0003ba00 	andeq	fp, r3, r0, lsl #20
     7ec:	05220100 	streq	r0, [r2, #-256]!	; 0xffffff00
     7f0:	052d0000 	streq	r0, [sp, #-0]!
     7f4:	6f130000 	svcvs	0x00130000
     7f8:	14000006 	strne	r0, [r0], #-6
     7fc:	00000059 	andeq	r0, r0, r9, asr r0
     800:	06391800 	ldrteq	r1, [r9], -r0, lsl #16
     804:	4b070000 	blmi	1c080c <__bss_end+0x1b6e08>
     808:	00095b0e 	andeq	r5, r9, lr, lsl #22
     80c:	05420100 	strbeq	r0, [r2, #-256]	; 0xffffff00
     810:	05480000 	strbeq	r0, [r8, #-0]
     814:	47130000 	ldrmi	r0, [r3, -r0]
     818:	00000006 	andeq	r0, r0, r6
     81c:	0007df16 	andeq	sp, r7, r6, lsl pc
     820:	0e4d0700 	cdpeq	7, 4, cr0, cr13, cr0, {0}
     824:	00000a1c 	andeq	r0, r0, ip, lsl sl
     828:	000001e3 	andeq	r0, r0, r3, ror #3
     82c:	00056101 	andeq	r6, r5, r1, lsl #2
     830:	00056c00 	andeq	r6, r5, r0, lsl #24
     834:	06471300 	strbeq	r1, [r7], -r0, lsl #6
     838:	59140000 	ldmdbpl	r4, {}	; <UNPREDICTABLE>
     83c:	00000000 	andeq	r0, r0, r0
     840:	0004b916 	andeq	fp, r4, r6, lsl r9
     844:	12500700 	subsne	r0, r0, #0, 14
     848:	0000042c 	andeq	r0, r0, ip, lsr #8
     84c:	00000059 	andeq	r0, r0, r9, asr r0
     850:	00058501 	andeq	r8, r5, r1, lsl #10
     854:	00059000 	andeq	r9, r5, r0
     858:	06471300 	strbeq	r1, [r7], -r0, lsl #6
     85c:	f0140000 			; <UNDEFINED> instruction: 0xf0140000
     860:	00000001 	andeq	r0, r0, r1
     864:	00045f16 	andeq	r5, r4, r6, lsl pc
     868:	0e530700 	cdpeq	7, 5, cr0, cr3, cr0, {0}
     86c:	00000d17 	andeq	r0, r0, r7, lsl sp
     870:	000001e3 	andeq	r0, r0, r3, ror #3
     874:	0005a901 	andeq	sl, r5, r1, lsl #18
     878:	0005b400 	andeq	fp, r5, r0, lsl #8
     87c:	06471300 	strbeq	r1, [r7], -r0, lsl #6
     880:	59140000 	ldmdbpl	r4, {}	; <UNPREDICTABLE>
     884:	00000000 	andeq	r0, r0, r0
     888:	00049318 	andeq	r9, r4, r8, lsl r3
     88c:	0e560700 	cdpeq	7, 5, cr0, cr6, cr0, {0}
     890:	00000bf5 	strdeq	r0, [r0], -r5
     894:	0005c901 	andeq	ip, r5, r1, lsl #18
     898:	0005e800 	andeq	lr, r5, r0, lsl #16
     89c:	06471300 	strbeq	r1, [r7], -r0, lsl #6
     8a0:	9c140000 	ldcls	0, cr0, [r4], {-0}
     8a4:	14000000 	strne	r0, [r0], #-0
     8a8:	00000059 	andeq	r0, r0, r9, asr r0
     8ac:	00005914 	andeq	r5, r0, r4, lsl r9
     8b0:	00591400 	subseq	r1, r9, r0, lsl #8
     8b4:	75140000 	ldrvc	r0, [r4, #-0]
     8b8:	00000006 	andeq	r0, r0, r6
     8bc:	000d5918 	andeq	r5, sp, r8, lsl r9
     8c0:	0e580700 	cdpeq	7, 5, cr0, cr8, cr0, {0}
     8c4:	00000de9 	andeq	r0, r0, r9, ror #27
     8c8:	0005fd01 	andeq	pc, r5, r1, lsl #26
     8cc:	00061c00 	andeq	r1, r6, r0, lsl #24
     8d0:	06471300 	strbeq	r1, [r7], -r0, lsl #6
     8d4:	d3140000 	tstle	r4, #0
     8d8:	14000000 	strne	r0, [r0], #-0
     8dc:	00000059 	andeq	r0, r0, r9, asr r0
     8e0:	00005914 	andeq	r5, r0, r4, lsl r9
     8e4:	00591400 	subseq	r1, r9, r0, lsl #8
     8e8:	75140000 	ldrvc	r0, [r4, #-0]
     8ec:	00000006 	andeq	r0, r0, r6
     8f0:	0004a619 	andeq	sl, r4, r9, lsl r6
     8f4:	0e5b0700 	cdpeq	7, 5, cr0, cr11, cr0, {0}
     8f8:	000008d4 	ldrdeq	r0, [r0], -r4
     8fc:	000001e3 	andeq	r0, r0, r3, ror #3
     900:	00063101 	andeq	r3, r6, r1, lsl #2
     904:	06471300 	strbeq	r1, [r7], -r0, lsl #6
     908:	60140000 	andsvs	r0, r4, r0
     90c:	14000003 	strne	r0, [r0], #-3
     910:	0000067b 	andeq	r0, r0, fp, ror r6
     914:	c0030000 	andgt	r0, r3, r0
     918:	0c000003 	stceq	0, cr0, [r0], {3}
     91c:	0003c004 	andeq	ip, r3, r4
     920:	03b41a00 			; <UNDEFINED> instruction: 0x03b41a00
     924:	065a0000 	ldrbeq	r0, [sl], -r0
     928:	06600000 	strbteq	r0, [r0], -r0
     92c:	47130000 	ldrmi	r0, [r3, -r0]
     930:	00000006 	andeq	r0, r0, r6
     934:	0003c01b 	andeq	ip, r3, fp, lsl r0
     938:	00064d00 	andeq	r4, r6, r0, lsl #26
     93c:	4b040c00 	blmi	103944 <__bss_end+0xf9f40>
     940:	0c000000 	stceq	0, cr0, [r0], {-0}
     944:	00064204 	andeq	r4, r6, r4, lsl #4
     948:	76041c00 	strvc	r1, [r4], -r0, lsl #24
     94c:	1d000000 	stcne	0, cr0, [r0, #-0]
     950:	61681e04 	cmnvs	r8, r4, lsl #28
     954:	0508006c 	streq	r0, [r8, #-108]	; 0xffffff94
     958:	0007470b 	andeq	r4, r7, fp, lsl #14
     95c:	09271f00 	stmdbeq	r7!, {r8, r9, sl, fp, ip}
     960:	07080000 	streq	r0, [r8, -r0]
     964:	00007119 	andeq	r7, r0, r9, lsl r1
     968:	e6b28000 	ldrt	r8, [r2], r0
     96c:	0ba61f0e 	bleq	fe9885ac <__bss_end+0xfe97eba8>
     970:	0a080000 	beq	200978 <__bss_end+0x1f6f74>
     974:	0002a91a 	andeq	sl, r2, sl, lsl r9
     978:	00000000 	andeq	r0, r0, r0
     97c:	05441f20 	strbeq	r1, [r4, #-3872]	; 0xfffff0e0
     980:	0d080000 	stceq	0, cr0, [r8, #-0]
     984:	0002a91a 	andeq	sl, r2, sl, lsl r9
     988:	20000000 	andcs	r0, r0, r0
     98c:	089f2020 	ldmeq	pc, {r5, sp}	; <UNPREDICTABLE>
     990:	10080000 	andne	r0, r8, r0
     994:	00006515 	andeq	r6, r0, r5, lsl r5
     998:	ba1f3600 	blt	7ce1a0 <__bss_end+0x7c479c>
     99c:	0800000c 	stmdaeq	r0, {r2, r3}
     9a0:	02a91a42 	adceq	r1, r9, #270336	; 0x42000
     9a4:	50000000 	andpl	r0, r0, r0
     9a8:	af1f2021 	svcge	0x001f2021
     9ac:	0800000d 	stmdaeq	r0, {r0, r2, r3}
     9b0:	02a91a71 	adceq	r1, r9, #462848	; 0x71000
     9b4:	b2000000 	andlt	r0, r0, #0
     9b8:	331f2000 	tstcc	pc, #0
     9bc:	08000007 	stmdaeq	r0, {r0, r1, r2}
     9c0:	02a91aa4 	adceq	r1, r9, #164, 20	; 0xa4000
     9c4:	b4000000 	strlt	r0, [r0], #-0
     9c8:	171f2000 	ldrne	r2, [pc, -r0]
     9cc:	08000009 	stmdaeq	r0, {r0, r3}
     9d0:	02a91ab3 	adceq	r1, r9, #733184	; 0xb3000
     9d4:	40000000 	andmi	r0, r0, r0
     9d8:	e41f2010 	ldr	r2, [pc], #-16	; 9e0 <shift+0x9e0>
     9dc:	08000009 	stmdaeq	r0, {r0, r3}
     9e0:	02a91abe 	adceq	r1, r9, #778240	; 0xbe000
     9e4:	50000000 	andpl	r0, r0, r0
     9e8:	831f2020 	tsthi	pc, #32
     9ec:	08000006 	stmdaeq	r0, {r1, r2}
     9f0:	02a91abf 	adceq	r1, r9, #782336	; 0xbf000
     9f4:	40000000 	andmi	r0, r0, r0
     9f8:	c31f2080 	tstgt	pc, #128	; 0x80
     9fc:	0800000c 	stmdaeq	r0, {r2, r3}
     a00:	02a91ac0 	adceq	r1, r9, #192, 20	; 0xc0000
     a04:	50000000 	andpl	r0, r0, r0
     a08:	8b1f2080 	blhi	7c8c10 <__bss_end+0x7bf20c>
     a0c:	0800000c 	stmdaeq	r0, {r2, r3}
     a10:	02a91ace 	adceq	r1, r9, #843776	; 0xce000
     a14:	40000000 	andmi	r0, r0, r0
     a18:	21002021 	tstcs	r0, r1, lsr #32
     a1c:	00000689 	andeq	r0, r0, r9, lsl #13
     a20:	00069921 	andeq	r9, r6, r1, lsr #18
     a24:	06a92100 	strteq	r2, [r9], r0, lsl #2
     a28:	b9210000 	stmdblt	r1!, {}	; <UNPREDICTABLE>
     a2c:	21000006 	tstcs	r0, r6
     a30:	000006c6 	andeq	r0, r0, r6, asr #13
     a34:	0006d621 	andeq	sp, r6, r1, lsr #12
     a38:	06e62100 	strbteq	r2, [r6], r0, lsl #2
     a3c:	f6210000 			; <UNDEFINED> instruction: 0xf6210000
     a40:	21000006 	tstcs	r0, r6
     a44:	00000706 	andeq	r0, r0, r6, lsl #14
     a48:	00071621 	andeq	r1, r7, r1, lsr #12
     a4c:	07262100 	streq	r2, [r6, -r0, lsl #2]!
     a50:	36210000 	strtcc	r0, [r1], -r0
     a54:	0a000007 	beq	a78 <shift+0xa78>
     a58:	00000bdd 	ldrdeq	r0, [r0], -sp
     a5c:	65140809 	ldrvs	r0, [r4, #-2057]	; 0xfffff7f7
     a60:	05000000 	streq	r0, [r0, #-0]
     a64:	00987403 	addseq	r7, r8, r3, lsl #8
     a68:	0cda0800 	ldcleq	8, cr0, [sl], {0}
     a6c:	04050000 	streq	r0, [r5], #-0
     a70:	00000038 	andeq	r0, r0, r8, lsr r0
     a74:	ba0c0d0a 	blt	303ea4 <__bss_end+0x2fa4a0>
     a78:	09000007 	stmdbeq	r0, {r0, r1, r2}
     a7c:	000007d8 	ldrdeq	r0, [r0], -r8
     a80:	09210900 	stmdbeq	r1!, {r8, fp}
     a84:	09010000 	stmdbeq	r1, {}	; <UNPREDICTABLE>
     a88:	000009ee 	andeq	r0, r0, lr, ror #19
     a8c:	95030002 	strls	r0, [r3, #-2]
     a90:	06000007 	streq	r0, [r0], -r7
     a94:	000004cd 	andeq	r0, r0, sp, asr #9
     a98:	08150a02 	ldmdaeq	r5, {r1, r9, fp}
     a9c:	000007e7 	andeq	r0, r0, r7, ror #15
     aa0:	000bd50e 	andeq	sp, fp, lr, lsl #10
     aa4:	0d170a00 	vldreq	s0, [r7, #-0]
     aa8:	0000003f 	andeq	r0, r0, pc, lsr r0
     aac:	0da20e00 	stceq	14, cr0, [r2]
     ab0:	180a0000 	stmdane	sl, {}	; <UNPREDICTABLE>
     ab4:	00003f0d 	andeq	r3, r0, sp, lsl #30
     ab8:	0a000100 	beq	ec0 <shift+0xec0>
     abc:	00000592 	muleq	r0, r2, r5
     ac0:	6514080b 	ldrvs	r0, [r4, #-2059]	; 0xfffff7f5
     ac4:	05000000 	streq	r0, [r0, #-0]
     ac8:	00987803 	addseq	r7, r8, r3, lsl #16
     acc:	0d430a00 	vstreq	s1, [r3, #-0]
     ad0:	070c0000 	streq	r0, [ip, -r0]
     ad4:	00006514 	andeq	r6, r0, r4, lsl r5
     ad8:	7c030500 	cfstr32vc	mvfx0, [r3], {-0}
     adc:	0a000098 	beq	d44 <shift+0xd44>
     ae0:	00000c55 	andeq	r0, r0, r5, asr ip
     ae4:	24110e01 	ldrcs	r0, [r1], #-3585	; 0xfffff1ff
     ae8:	05000008 	streq	r0, [r0, #-8]
     aec:	00988003 	addseq	r8, r8, r3
     af0:	04040200 	streq	r0, [r4], #-512	; 0xfffffe00
     af4:	0000067d 	andeq	r0, r0, sp, ror r6
     af8:	00081d03 	andeq	r1, r8, r3, lsl #26
     afc:	06600a00 	strbteq	r0, [r0], -r0, lsl #20
     b00:	0f010000 	svceq	0x00010000
     b04:	00082411 	andeq	r2, r8, r1, lsl r4
     b08:	84030500 	strhi	r0, [r3], #-1280	; 0xfffffb00
     b0c:	0a000098 	beq	d74 <shift+0xd74>
     b10:	00000818 	andeq	r0, r0, r8, lsl r8
     b14:	65141101 	ldrvs	r1, [r4, #-257]	; 0xfffffeff
     b18:	05000000 	streq	r0, [r0, #-0]
     b1c:	00988803 	addseq	r8, r8, r3, lsl #16
     b20:	08110a00 	ldmdaeq	r1, {r9, fp}
     b24:	12010000 	andne	r0, r1, #0
     b28:	00006514 	andeq	r6, r0, r4, lsl r5
     b2c:	8c030500 	cfstr32hi	mvfx0, [r3], {-0}
     b30:	0a000098 	beq	d98 <shift+0xd98>
     b34:	00000bb6 			; <UNDEFINED> instruction: 0x00000bb6
     b38:	ba151301 	blt	545744 <__bss_end+0x53bd40>
     b3c:	05000007 	streq	r0, [r0, #-7]
     b40:	00989003 	addseq	r9, r8, r3
     b44:	09a22200 	stmibeq	r2!, {r9, sp}
     b48:	14010000 	strne	r0, [r1], #-0
     b4c:	0007950b 	andeq	r9, r7, fp, lsl #10
     b50:	e4030500 	str	r0, [r3], #-1280	; 0xfffffb00
     b54:	22000099 	andcs	r0, r0, #153	; 0x99
     b58:	000004e6 	andeq	r0, r0, r6, ror #9
     b5c:	590a1601 	stmdbpl	sl, {r0, r9, sl, ip}
     b60:	05000000 	streq	r0, [r0, #-0]
     b64:	0099ec03 	addseq	lr, r9, r3, lsl #24
     b68:	07ba2200 	ldreq	r2, [sl, r0, lsl #4]!
     b6c:	16010000 	strne	r0, [r1], -r0
     b70:	00005912 	andeq	r5, r0, r2, lsl r9
     b74:	f0030500 			; <UNDEFINED> instruction: 0xf0030500
     b78:	0f000099 	svceq	0x00000099
     b7c:	00000824 	andeq	r0, r0, r4, lsr #16
     b80:	000008b7 			; <UNDEFINED> instruction: 0x000008b7
     b84:	00006a10 	andeq	r6, r0, r0, lsl sl
     b88:	03000700 	movweq	r0, #1792	; 0x700
     b8c:	000008a7 	andeq	r0, r0, r7, lsr #17
     b90:	000cea23 	andeq	lr, ip, r3, lsr #20
     b94:	0d180100 	ldfeqs	f0, [r8, #-0]
     b98:	000008b7 			; <UNDEFINED> instruction: 0x000008b7
     b9c:	98940305 	ldmls	r4, {r0, r2, r8, r9}
     ba0:	20230000 	eorcs	r0, r3, r0
     ba4:	01000008 	tsteq	r0, r8
     ba8:	0065101b 	rsbeq	r1, r5, fp, lsl r0
     bac:	03050000 	movweq	r0, #20480	; 0x5000
     bb0:	000098b4 			; <UNDEFINED> instruction: 0x000098b4
     bb4:	000d8222 	andeq	r8, sp, r2, lsr #4
     bb8:	071c0100 	ldreq	r0, [ip, -r0, lsl #2]
     bbc:	0000081d 	andeq	r0, r0, sp, lsl r8
     bc0:	99e80305 	stmibls	r8!, {r0, r2, r8, r9}^
     bc4:	8d240000 	stchi	0, cr0, [r4, #-0]
     bc8:	0100000d 	tsteq	r0, sp
     bcc:	003805aa 	eorseq	r0, r8, sl, lsr #11
     bd0:	889c0000 	ldmhi	ip, {}	; <UNPREDICTABLE>
     bd4:	01500000 	cmpeq	r0, r0
     bd8:	9c010000 	stcls	0, cr0, [r1], {-0}
     bdc:	00000958 	andeq	r0, r0, r8, asr r9
     be0:	0009f825 	andeq	pc, r9, r5, lsr #16
     be4:	0eaa0100 	fdveqe	f0, f2, f0
     be8:	00000038 	andeq	r0, r0, r8, lsr r0
     bec:	254c9102 	strbcs	r9, [ip, #-258]	; 0xfffffefe
     bf0:	00000a0f 	andeq	r0, r0, pc, lsl #20
     bf4:	581baa01 	ldmdapl	fp, {r0, r9, fp, sp, pc}
     bf8:	02000009 	andeq	r0, r0, #9
     bfc:	4d234891 	stcmi	8, cr4, [r3, #-580]!	; 0xfffffdbc
     c00:	0100000c 	tsteq	r0, ip
     c04:	00590eac 	subseq	r0, r9, ip, lsr #29
     c08:	91020000 	mrsls	r0, (UNDEF: 2)
     c0c:	048e2374 	streq	r2, [lr], #884	; 0x374
     c10:	ad010000 	stcge	0, cr0, [r1, #-0]
     c14:	0009640a 	andeq	r6, r9, sl, lsl #8
     c18:	54910200 	ldrpl	r0, [r1], #512	; 0x200
     c1c:	00047223 	andeq	r7, r4, r3, lsr #4
     c20:	17bb0100 	ldrne	r0, [fp, r0, lsl #2]!
     c24:	000007bf 			; <UNDEFINED> instruction: 0x000007bf
     c28:	00509102 	subseq	r9, r0, r2, lsl #2
     c2c:	095e040c 	ldmdbeq	lr, {r2, r3, sl}^
     c30:	040c0000 	streq	r0, [ip], #-0
     c34:	00000025 	andeq	r0, r0, r5, lsr #32
     c38:	0000250f 	andeq	r2, r0, pc, lsl #10
     c3c:	00097400 	andeq	r7, r9, r0, lsl #8
     c40:	006a1000 	rsbeq	r1, sl, r0
     c44:	001f0000 	andseq	r0, pc, r0
     c48:	000ab826 	andeq	fp, sl, r6, lsr #16
     c4c:	06820100 	streq	r0, [r2], r0, lsl #2
     c50:	00000ccd 	andeq	r0, r0, sp, asr #25
     c54:	000001e3 	andeq	r0, r0, r3, ror #3
     c58:	000086cc 	andeq	r8, r0, ip, asr #13
     c5c:	000001d0 	ldrdeq	r0, [r0], -r0	; <UNPREDICTABLE>
     c60:	09d19c01 	ldmibeq	r1, {r0, sl, fp, ip, pc}^
     c64:	52250000 	eorpl	r0, r5, #0
     c68:	01000007 	tsteq	r0, r7
     c6c:	07951a82 	ldreq	r1, [r5, r2, lsl #21]
     c70:	91030000 	mrsls	r0, (UNDEF: 3)
     c74:	a9237fac 	stmdbge	r3!, {r2, r3, r5, r7, r8, r9, sl, fp, ip, sp, lr}
     c78:	01000009 	tsteq	r0, r9
     c7c:	09d10a84 	ldmibeq	r1, {r2, r7, r9, fp}^
     c80:	91020000 	mrsls	r0, (UNDEF: 2)
     c84:	048e2374 	streq	r2, [lr], #884	; 0x374
     c88:	84010000 	strhi	r0, [r1], #-0
     c8c:	00096413 	andeq	r6, r9, r3, lsl r4
     c90:	54910200 	ldrpl	r0, [r1], #512	; 0x200
     c94:	000a1423 	andeq	r1, sl, r3, lsr #8
     c98:	1d840100 	stfnes	f0, [r4]
     c9c:	00000964 	andeq	r0, r0, r4, ror #18
     ca0:	7fb49103 	svcvc	0x00b49103
     ca4:	00250f00 	eoreq	r0, r5, r0, lsl #30
     ca8:	09e10000 	stmibeq	r1!, {}^	; <UNPREDICTABLE>
     cac:	6a100000 	bvs	400cb4 <__bss_end+0x3f72b0>
     cb0:	03000000 	movweq	r0, #0
     cb4:	0b652600 	bleq	194a4bc <__bss_end+0x1940ab8>
     cb8:	5e010000 	cdppl	0, 0, cr0, cr1, cr0, {0}
     cbc:	0008b80b 	andeq	fp, r8, fp, lsl #16
     cc0:	00079500 	andeq	r9, r7, r0, lsl #10
     cc4:	0085d400 	addeq	sp, r5, r0, lsl #8
     cc8:	0000f800 	andeq	pc, r0, r0, lsl #16
     ccc:	2d9c0100 	ldfcss	f0, [ip]
     cd0:	2500000a 	strcs	r0, [r0, #-10]
     cd4:	0000075f 	andeq	r0, r0, pc, asr r7
     cd8:	95215e01 	strls	r5, [r1, #-3585]!	; 0xfffff1ff
     cdc:	02000007 	andeq	r0, r0, #7
     ce0:	83256c91 			; <UNDEFINED> instruction: 0x83256c91
     ce4:	01000004 	tsteq	r0, r4
     ce8:	095e305e 	ldmdbeq	lr, {r1, r2, r3, r4, r6, ip, sp}^
     cec:	91020000 	mrsls	r0, (UNDEF: 2)
     cf0:	07082368 	streq	r2, [r8, -r8, ror #6]
     cf4:	60010000 	andvs	r0, r1, r0
     cf8:	0007950f 	andeq	r9, r7, pc, lsl #10
     cfc:	74910200 	ldrvc	r0, [r1], #512	; 0x200
     d00:	04fb2700 	ldrbteq	r2, [fp], #1792	; 0x700
     d04:	52010000 	andpl	r0, r1, #0
     d08:	000d9206 	andeq	r9, sp, r6, lsl #4
     d0c:	00853000 	addeq	r3, r5, r0
     d10:	0000a400 	andeq	sl, r0, r0, lsl #8
     d14:	759c0100 	ldrvc	r0, [ip, #256]	; 0x100
     d18:	2500000a 	strcs	r0, [r0, #-10]
     d1c:	00000500 	andeq	r0, r0, r0, lsl #10
     d20:	241d5201 	ldrcs	r5, [sp], #-513	; 0xfffffdff
     d24:	02000008 	andeq	r0, r0, #8
     d28:	70284c91 	mlavc	r8, r1, ip, r4
     d2c:	01006d6f 	tsteq	r0, pc, ror #26
     d30:	0a750a53 	beq	1d43684 <__bss_end+0x1d39c80>
     d34:	91020000 	mrsls	r0, (UNDEF: 2)
     d38:	048e2370 	streq	r2, [lr], #880	; 0x370
     d3c:	53010000 	movwpl	r0, #4096	; 0x1000
     d40:	00096412 	andeq	r6, r9, r2, lsl r4
     d44:	50910200 	addspl	r0, r1, r0, lsl #4
     d48:	00250f00 	eoreq	r0, r5, r0, lsl #30
     d4c:	0a850000 	beq	fe140d54 <__bss_end+0xfe137350>
     d50:	6a100000 	bvs	400d58 <__bss_end+0x3f7354>
     d54:	04000000 	streq	r0, [r0], #-0
     d58:	07482700 	strbeq	r2, [r8, -r0, lsl #14]
     d5c:	3d010000 	stccc	0, cr0, [r1, #-0]
     d60:	00057906 	andeq	r7, r5, r6, lsl #18
     d64:	00843400 	addeq	r3, r4, r0, lsl #8
     d68:	0000fc00 	andeq	pc, r0, r0, lsl #24
     d6c:	cd9c0100 	ldfgts	f0, [ip]
     d70:	2500000a 	strcs	r0, [r0, #-10]
     d74:	00000500 	andeq	r0, r0, r0, lsl #10
     d78:	241c3d01 	ldrcs	r3, [ip], #-3329	; 0xfffff2ff
     d7c:	02000008 	andeq	r0, r0, #8
     d80:	a5236491 	strge	r6, [r3, #-1169]!	; 0xfffffb6f
     d84:	0100000a 	tsteq	r0, sl
     d88:	081d0b3f 	ldmdaeq	sp, {r0, r1, r2, r3, r4, r5, r8, r9, fp}
     d8c:	91020000 	mrsls	r0, (UNDEF: 2)
     d90:	736d2874 	cmnvc	sp, #116, 16	; 0x740000
     d94:	40010067 	andmi	r0, r1, r7, rrx
     d98:	000acd0a 	andeq	ip, sl, sl, lsl #26
     d9c:	6c910200 	lfmvs	f0, 4, [r1], {0}
     da0:	00250f00 	eoreq	r0, r5, r0, lsl #30
     da4:	0add0000 	beq	ff740dac <__bss_end+0xff7373a8>
     da8:	6a100000 	bvs	400db0 <__bss_end+0x3f73ac>
     dac:	05000000 	streq	r0, [r0, #-0]
     db0:	6f6c2900 	svcvs	0x006c2900
     db4:	36010067 	strcc	r0, [r1], -r7, rrx
     db8:	0007b206 	andeq	fp, r7, r6, lsl #4
     dbc:	0083c000 	addeq	ip, r3, r0
     dc0:	00007400 	andeq	r7, r0, r0, lsl #8
     dc4:	279c0100 	ldrcs	r0, [ip, r0, lsl #2]
     dc8:	2500000b 	strcs	r0, [r0, #-11]
     dcc:	00000500 	andeq	r0, r0, r0, lsl #10
     dd0:	65193601 	ldrvs	r3, [r9, #-1537]	; 0xfffff9ff
     dd4:	03000000 	movweq	r0, #0
     dd8:	237fac91 	cmncs	pc, #37120	; 0x9100
     ddc:	0000048e 	andeq	r0, r0, lr, lsl #9
     de0:	640a3701 	strvs	r3, [sl], #-1793	; 0xfffff8ff
     de4:	02000009 	andeq	r0, r0, #9
     de8:	70285091 	mlavc	r8, r1, r0, r5
     dec:	01006d6f 	tsteq	r0, pc, ror #26
     df0:	09641437 	stmdbeq	r4!, {r0, r1, r2, r4, r5, sl, ip}^
     df4:	91030000 	mrsls	r0, (UNDEF: 3)
     df8:	29007fb0 	stmdbcs	r0, {r4, r5, r7, r8, r9, sl, fp, ip, sp, lr}
     dfc:	00676f6c 	rsbeq	r6, r7, ip, ror #30
     e00:	3e062f01 	cdpcc	15, 0, cr2, cr6, cr1, {0}
     e04:	d8000007 	stmdale	r0, {r0, r1, r2}
     e08:	e8000082 	stmda	r0, {r1, r7}
     e0c:	01000000 	mrseq	r0, (UNDEF: 0)
     e10:	000b619c 	muleq	fp, ip, r1
     e14:	736d2a00 	cmnvc	sp, #0, 20
     e18:	2f010067 	svccs	0x00010067
     e1c:	0001ea16 	andeq	lr, r1, r6, lsl sl
     e20:	54910200 	ldrpl	r0, [r1], #512	; 0x200
     e24:	0007cf23 	andeq	ip, r7, r3, lsr #30
     e28:	0a310100 	beq	c41230 <__bss_end+0xc3782c>
     e2c:	00000b61 	andeq	r0, r0, r1, ror #22
     e30:	06589103 	ldrbeq	r9, [r8], -r3, lsl #2
     e34:	00250f00 	eoreq	r0, r5, r0, lsl #30
     e38:	0b740000 	bleq	1d00e40 <__bss_end+0x1cf743c>
     e3c:	6a2b0000 	bvs	ac0e44 <__bss_end+0xab7440>
     e40:	03000000 	movweq	r0, #0
     e44:	00065c91 	muleq	r6, r1, ip
     e48:	0008082c 	andeq	r0, r8, ip, lsr #16
     e4c:	061e0100 	ldreq	r0, [lr], -r0, lsl #2
     e50:	00000c7a 	andeq	r0, r0, sl, ror ip
     e54:	0000822c 	andeq	r8, r0, ip, lsr #4
     e58:	000000ac 	andeq	r0, r0, ip, lsr #1
     e5c:	8e259c01 	cdphi	12, 2, cr9, cr5, cr1, {0}
     e60:	01000004 	tsteq	r0, r4
     e64:	095e151e 	ldmdbeq	lr, {r1, r2, r3, r4, r8, sl, ip}^
     e68:	91020000 	mrsls	r0, (UNDEF: 2)
     e6c:	736d2a6c 	cmnvc	sp, #108, 20	; 0x6c000
     e70:	1e010067 	cdpne	0, 0, cr0, cr1, cr7, {3}
     e74:	0001ea27 	andeq	lr, r1, r7, lsr #20
     e78:	68910200 	ldmvs	r1, {r9}
     e7c:	0b1f0000 	bleq	7c0e84 <__bss_end+0x7b7480>
     e80:	00040000 	andeq	r0, r4, r0
     e84:	000004b4 			; <UNDEFINED> instruction: 0x000004b4
     e88:	11340104 	teqne	r4, r4, lsl #2
     e8c:	24040000 	strcs	r0, [r4], #-0
     e90:	41000010 	tstmi	r0, r0, lsl r0
     e94:	ec00000e 	stc	0, cr0, [r0], {14}
     e98:	5c000089 	stcpl	0, cr0, [r0], {137}	; 0x89
     e9c:	35000004 	strcc	r0, [r0, #-4]
     ea0:	02000007 	andeq	r0, r0, #7
     ea4:	0c750801 	ldcleq	8, cr0, [r5], #-4
     ea8:	25030000 	strcs	r0, [r3, #-0]
     eac:	02000000 	andeq	r0, r0, #0
     eb0:	0a780502 	beq	1e022c0 <__bss_end+0x1df88bc>
     eb4:	04040000 	streq	r0, [r4], #-0
     eb8:	746e6905 	strbtvc	r6, [lr], #-2309	; 0xfffff6fb
     ebc:	08010200 	stmdaeq	r1, {r9}
     ec0:	00000c6c 	andeq	r0, r0, ip, ror #24
     ec4:	6f070202 	svcvs	0x00070202
     ec8:	0500000d 	streq	r0, [r0, #-13]
     ecc:	00000657 	andeq	r0, r0, r7, asr r6
     ed0:	5e070907 	vmlapl.f16	s0, s14, s14	; <UNPREDICTABLE>
     ed4:	03000000 	movweq	r0, #0
     ed8:	0000004d 	andeq	r0, r0, sp, asr #32
     edc:	c8070402 	stmdagt	r7, {r1, sl}
     ee0:	0600000b 	streq	r0, [r0], -fp
     ee4:	00000e35 	andeq	r0, r0, r5, lsr lr
     ee8:	08060208 	stmdaeq	r6, {r3, r9}
     eec:	0000008b 	andeq	r0, r0, fp, lsl #1
     ef0:	00307207 	eorseq	r7, r0, r7, lsl #4
     ef4:	4d0e0802 	stcmi	8, cr0, [lr, #-8]
     ef8:	00000000 	andeq	r0, r0, r0
     efc:	00317207 	eorseq	r7, r1, r7, lsl #4
     f00:	4d0e0902 	vstrmi.16	s0, [lr, #-4]	; <UNPREDICTABLE>
     f04:	04000000 	streq	r0, [r0], #-0
     f08:	10be0800 	adcsne	r0, lr, r0, lsl #16
     f0c:	04050000 	streq	r0, [r5], #-0
     f10:	00000038 	andeq	r0, r0, r8, lsr r0
     f14:	a90c0d02 	stmdbge	ip, {r1, r8, sl, fp}
     f18:	09000000 	stmdbeq	r0, {}	; <UNPREDICTABLE>
     f1c:	00004b4f 	andeq	r4, r0, pc, asr #22
     f20:	000eef0a 	andeq	lr, lr, sl, lsl #30
     f24:	08000100 	stmdaeq	r0, {r8}
     f28:	00000b3d 	andeq	r0, r0, sp, lsr fp
     f2c:	00380405 	eorseq	r0, r8, r5, lsl #8
     f30:	1e020000 	cdpne	0, 0, cr0, cr2, cr0, {0}
     f34:	0000e00c 	andeq	lr, r0, ip
     f38:	064f0a00 	strbeq	r0, [pc], -r0, lsl #20
     f3c:	0a000000 	beq	f44 <shift+0xf44>
     f40:	000007c5 	andeq	r0, r0, r5, asr #15
     f44:	0b5f0a01 	bleq	17c3750 <__bss_end+0x17b9d4c>
     f48:	0a020000 	beq	80f50 <__bss_end+0x7754c>
     f4c:	00000ca8 	andeq	r0, r0, r8, lsr #25
     f50:	079d0a03 	ldreq	r0, [sp, r3, lsl #20]
     f54:	0a040000 	beq	100f5c <__bss_end+0xf7558>
     f58:	00000a57 	andeq	r0, r0, r7, asr sl
     f5c:	c2080005 	andgt	r0, r8, #5
     f60:	0500000a 	streq	r0, [r0, #-10]
     f64:	00003804 	andeq	r3, r0, r4, lsl #16
     f68:	0c3f0200 	lfmeq	f0, 4, [pc], #-0	; f70 <shift+0xf70>
     f6c:	0000011d 	andeq	r0, r0, sp, lsl r1
     f70:	00072e0a 	andeq	r2, r7, sl, lsl #28
     f74:	c00a0000 	andgt	r0, sl, r0
     f78:	01000007 	tsteq	r0, r7
     f7c:	000dce0a 	andeq	ip, sp, sl, lsl #28
     f80:	b80a0200 	stmdalt	sl, {r9}
     f84:	03000009 	movweq	r0, #9
     f88:	0007ac0a 	andeq	sl, r7, sl, lsl #24
     f8c:	3a0a0400 	bcc	281f94 <__bss_end+0x278590>
     f90:	05000008 	streq	r0, [r0, #-8]
     f94:	00068d0a 	andeq	r8, r6, sl, lsl #26
     f98:	08000600 	stmdaeq	r0, {r9, sl}
     f9c:	0000066c 	andeq	r0, r0, ip, ror #12
     fa0:	00380405 	eorseq	r0, r8, r5, lsl #8
     fa4:	66020000 	strvs	r0, [r2], -r0
     fa8:	0001480c 	andeq	r4, r1, ip, lsl #16
     fac:	0c610a00 			; <UNDEFINED> instruction: 0x0c610a00
     fb0:	0a000000 	beq	fb8 <shift+0xfb8>
     fb4:	00000587 	andeq	r0, r0, r7, lsl #11
     fb8:	0b8f0a01 	bleq	fe3c37c4 <__bss_end+0xfe3b9dc0>
     fbc:	0a020000 	beq	80fc4 <__bss_end+0x775c0>
     fc0:	00000a60 	andeq	r0, r0, r0, ror #20
     fc4:	8a0b0003 	bhi	2c0fd8 <__bss_end+0x2b75d4>
     fc8:	03000009 	movweq	r0, #9
     fcc:	00591405 	subseq	r1, r9, r5, lsl #8
     fd0:	03050000 	movweq	r0, #20480	; 0x5000
     fd4:	00009998 	muleq	r0, r8, r9
     fd8:	000be90b 	andeq	lr, fp, fp, lsl #18
     fdc:	14060300 	strne	r0, [r6], #-768	; 0xfffffd00
     fe0:	00000059 	andeq	r0, r0, r9, asr r0
     fe4:	999c0305 	ldmibls	ip, {r0, r2, r8, r9}
     fe8:	4f0b0000 	svcmi	0x000b0000
     fec:	04000008 	streq	r0, [r0], #-8
     ff0:	00591a07 	subseq	r1, r9, r7, lsl #20
     ff4:	03050000 	movweq	r0, #20480	; 0x5000
     ff8:	000099a0 	andeq	r9, r0, r0, lsr #19
     ffc:	000a820b 	andeq	r8, sl, fp, lsl #4
    1000:	1a090400 	bne	242008 <__bss_end+0x238604>
    1004:	00000059 	andeq	r0, r0, r9, asr r0
    1008:	99a40305 	stmibls	r4!, {r0, r2, r8, r9}
    100c:	410b0000 	mrsmi	r0, (UNDEF: 11)
    1010:	04000008 	streq	r0, [r0], #-8
    1014:	00591a0b 	subseq	r1, r9, fp, lsl #20
    1018:	03050000 	movweq	r0, #20480	; 0x5000
    101c:	000099a8 	andeq	r9, r0, r8, lsr #19
    1020:	000a440b 	andeq	r4, sl, fp, lsl #8
    1024:	1a0d0400 	bne	34202c <__bss_end+0x338628>
    1028:	00000059 	andeq	r0, r0, r9, asr r0
    102c:	99ac0305 	stmibls	ip!, {r0, r2, r8, r9}
    1030:	2f0b0000 	svccs	0x000b0000
    1034:	04000006 	streq	r0, [r0], #-6
    1038:	00591a0f 	subseq	r1, r9, pc, lsl #20
    103c:	03050000 	movweq	r0, #20480	; 0x5000
    1040:	000099b0 			; <UNDEFINED> instruction: 0x000099b0
    1044:	00122708 	andseq	r2, r2, r8, lsl #14
    1048:	38040500 	stmdacc	r4, {r8, sl}
    104c:	04000000 	streq	r0, [r0], #-0
    1050:	01eb0c1b 	mvneq	r0, fp, lsl ip
    1054:	de0a0000 	cdple	0, 0, cr0, cr10, cr0, {0}
    1058:	00000005 	andeq	r0, r0, r5
    105c:	000cf80a 	andeq	pc, ip, sl, lsl #16
    1060:	c90a0100 	stmdbgt	sl, {r8}
    1064:	0200000d 	andeq	r0, r0, #13
    1068:	04590c00 	ldrbeq	r0, [r9], #-3072	; 0xfffff400
    106c:	01020000 	mrseq	r0, (UNDEF: 2)
    1070:	0008b302 	andeq	fp, r8, r2, lsl #6
    1074:	2c040d00 	stccs	13, cr0, [r4], {-0}
    1078:	0d000000 	stceq	0, cr0, [r0, #-0]
    107c:	0001eb04 	andeq	lr, r1, r4, lsl #22
    1080:	05e80b00 	strbeq	r0, [r8, #2816]!	; 0xb00
    1084:	04050000 	streq	r0, [r5], #-0
    1088:	00005914 	andeq	r5, r0, r4, lsl r9
    108c:	b4030500 	strlt	r0, [r3], #-1280	; 0xfffffb00
    1090:	0b000099 	bleq	12fc <shift+0x12fc>
    1094:	00000b71 	andeq	r0, r0, r1, ror fp
    1098:	59140705 	ldmdbpl	r4, {r0, r2, r8, r9, sl}
    109c:	05000000 	streq	r0, [r0, #-0]
    10a0:	0099b803 	addseq	fp, r9, r3, lsl #16
    10a4:	051d0b00 	ldreq	r0, [sp, #-2816]	; 0xfffff500
    10a8:	0a050000 	beq	1410b0 <__bss_end+0x1376ac>
    10ac:	00005914 	andeq	r5, r0, r4, lsl r9
    10b0:	bc030500 	cfstr32lt	mvfx0, [r3], {-0}
    10b4:	08000099 	stmdaeq	r0, {r0, r3, r4, r7}
    10b8:	00000692 	muleq	r0, r2, r6
    10bc:	00380405 	eorseq	r0, r8, r5, lsl #8
    10c0:	0d050000 	stceq	0, cr0, [r5, #-0]
    10c4:	0002700c 	andeq	r7, r2, ip
    10c8:	654e0900 	strbvs	r0, [lr, #-2304]	; 0xfffff700
    10cc:	0a000077 	beq	12b0 <shift+0x12b0>
    10d0:	000004f2 	strdeq	r0, [r0], -r2
    10d4:	05150a01 	ldreq	r0, [r5, #-2561]	; 0xfffff5ff
    10d8:	0a020000 	beq	810e0 <__bss_end+0x776dc>
    10dc:	000006ab 	andeq	r0, r0, fp, lsr #13
    10e0:	0c9a0a03 	vldmiaeq	sl, {s0-s2}
    10e4:	0a040000 	beq	1010ec <__bss_end+0xf76e8>
    10e8:	000004df 	ldrdeq	r0, [r0], -pc	; <UNPREDICTABLE>
    10ec:	01060005 	tsteq	r6, r5
    10f0:	10000006 	andne	r0, r0, r6
    10f4:	af081b05 	svcge	0x00081b05
    10f8:	07000002 	streq	r0, [r0, -r2]
    10fc:	0500726c 	streq	r7, [r0, #-620]	; 0xfffffd94
    1100:	02af131d 	adceq	r1, pc, #1946157056	; 0x74000000
    1104:	07000000 	streq	r0, [r0, -r0]
    1108:	05007073 	streq	r7, [r0, #-115]	; 0xffffff8d
    110c:	02af131e 	adceq	r1, pc, #2013265920	; 0x78000000
    1110:	07040000 	streq	r0, [r4, -r0]
    1114:	05006370 	streq	r6, [r0, #-880]	; 0xfffffc90
    1118:	02af131f 	adceq	r1, pc, #2080374784	; 0x7c000000
    111c:	0e080000 	cdpeq	0, 0, cr0, cr8, cr0, {0}
    1120:	00000ab2 			; <UNDEFINED> instruction: 0x00000ab2
    1124:	af132005 	svcge	0x00132005
    1128:	0c000002 	stceq	0, cr0, [r0], {2}
    112c:	07040200 	streq	r0, [r4, -r0, lsl #4]
    1130:	00000bc3 	andeq	r0, r0, r3, asr #23
    1134:	00079006 	andeq	r9, r7, r6
    1138:	28057000 	stmdacs	r5, {ip, sp, lr}
    113c:	00034608 	andeq	r4, r3, r8, lsl #12
    1140:	07130e00 	ldreq	r0, [r3, -r0, lsl #28]
    1144:	2a050000 	bcs	14114c <__bss_end+0x137748>
    1148:	00027012 	andeq	r7, r2, r2, lsl r0
    114c:	70070000 	andvc	r0, r7, r0
    1150:	05006469 	streq	r6, [r0, #-1129]	; 0xfffffb97
    1154:	005e122b 	subseq	r1, lr, fp, lsr #4
    1158:	0e100000 	cdpeq	0, 1, cr0, cr0, cr0, {0}
    115c:	00000ce4 	andeq	r0, r0, r4, ror #25
    1160:	39112c05 	ldmdbcc	r1, {r0, r2, sl, fp, sp}
    1164:	14000002 	strne	r0, [r0], #-2
    1168:	000c470e 	andeq	r4, ip, lr, lsl #14
    116c:	122d0500 	eorne	r0, sp, #0, 10
    1170:	0000005e 	andeq	r0, r0, lr, asr r0
    1174:	03e90e18 	mvneq	r0, #24, 28	; 0x180
    1178:	2e050000 	cdpcs	0, 0, cr0, cr5, cr0, {0}
    117c:	00005e12 	andeq	r5, r0, r2, lsl lr
    1180:	520e1c00 	andpl	r1, lr, #0, 24
    1184:	0500000b 	streq	r0, [r0, #-11]
    1188:	03460c2f 	movteq	r0, #27695	; 0x6c2f
    118c:	0e200000 	cdpeq	0, 2, cr0, cr0, cr0, {0}
    1190:	00000479 	andeq	r0, r0, r9, ror r4
    1194:	38093005 	stmdacc	r9, {r0, r2, ip, sp}
    1198:	60000000 	andvs	r0, r0, r0
    119c:	0006c60e 	andeq	ip, r6, lr, lsl #12
    11a0:	0e310500 	cfabs32eq	mvfx0, mvfx1
    11a4:	0000004d 	andeq	r0, r0, sp, asr #32
    11a8:	0a060e64 	beq	184b40 <__bss_end+0x17b13c>
    11ac:	33050000 	movwcc	r0, #20480	; 0x5000
    11b0:	00004d0e 	andeq	r4, r0, lr, lsl #26
    11b4:	fd0e6800 	stc2	8, cr6, [lr, #-0]
    11b8:	05000009 	streq	r0, [r0, #-9]
    11bc:	004d0e34 	subeq	r0, sp, r4, lsr lr
    11c0:	006c0000 	rsbeq	r0, ip, r0
    11c4:	0001fd0f 	andeq	pc, r1, pc, lsl #26
    11c8:	00035600 	andeq	r5, r3, r0, lsl #12
    11cc:	005e1000 	subseq	r1, lr, r0
    11d0:	000f0000 	andeq	r0, pc, r0
    11d4:	0005060b 	andeq	r0, r5, fp, lsl #12
    11d8:	140a0600 	strne	r0, [sl], #-1536	; 0xfffffa00
    11dc:	00000059 	andeq	r0, r0, r9, asr r0
    11e0:	99c00305 	stmibls	r0, {r0, r2, r8, r9}^
    11e4:	8a080000 	bhi	2011ec <__bss_end+0x1f77e8>
    11e8:	05000008 	streq	r0, [r0, #-8]
    11ec:	00003804 	andeq	r3, r0, r4, lsl #16
    11f0:	0c0d0600 	stceq	6, cr0, [sp], {-0}
    11f4:	00000387 	andeq	r0, r0, r7, lsl #7
    11f8:	000dd40a 	andeq	sp, sp, sl, lsl #8
    11fc:	0c0a0000 	stceq	0, cr0, [sl], {-0}
    1200:	0100000d 	tsteq	r0, sp
    1204:	03680300 	cmneq	r8, #0, 6
    1208:	b6080000 	strlt	r0, [r8], -r0
    120c:	0500000f 	streq	r0, [r0, #-15]
    1210:	00003804 	andeq	r3, r0, r4, lsl #16
    1214:	0c140600 	ldceq	6, cr0, [r4], {-0}
    1218:	000003ab 	andeq	r0, r0, fp, lsr #7
    121c:	000e920a 	andeq	r9, lr, sl, lsl #4
    1220:	900a0000 	andls	r0, sl, r0
    1224:	01000010 	tsteq	r0, r0, lsl r0
    1228:	038c0300 	orreq	r0, ip, #0, 6
    122c:	f5060000 			; <UNDEFINED> instruction: 0xf5060000
    1230:	0c000006 	stceq	0, cr0, [r0], {6}
    1234:	e5081b06 	str	r1, [r8, #-2822]	; 0xfffff4fa
    1238:	0e000003 	cdpeq	0, 0, cr0, cr0, cr3, {0}
    123c:	000005ab 	andeq	r0, r0, fp, lsr #11
    1240:	e5191d06 	ldr	r1, [r9, #-3334]	; 0xfffff2fa
    1244:	00000003 	andeq	r0, r0, r3
    1248:	0004ed0e 	andeq	lr, r4, lr, lsl #26
    124c:	191e0600 	ldmdbne	lr, {r9, sl}
    1250:	000003e5 	andeq	r0, r0, r5, ror #7
    1254:	08ae0e04 	stmiaeq	lr!, {r2, r9, sl, fp}
    1258:	1f060000 	svcne	0x00060000
    125c:	0003eb13 	andeq	lr, r3, r3, lsl fp
    1260:	0d000800 	stceq	8, cr0, [r0, #-0]
    1264:	0003b004 	andeq	fp, r3, r4
    1268:	b6040d00 	strlt	r0, [r4], -r0, lsl #26
    126c:	11000002 	tstne	r0, r2
    1270:	00000a94 	muleq	r0, r4, sl
    1274:	07220614 			; <UNDEFINED> instruction: 0x07220614
    1278:	00000673 	andeq	r0, r0, r3, ror r6
    127c:	0009980e 	andeq	r9, r9, lr, lsl #16
    1280:	12260600 	eorne	r0, r6, #0, 12
    1284:	0000004d 	andeq	r0, r0, sp, asr #32
    1288:	093a0e00 	ldmdbeq	sl!, {r9, sl, fp}
    128c:	29060000 	stmdbcs	r6, {}	; <UNPREDICTABLE>
    1290:	0003e51d 	andeq	lr, r3, sp, lsl r5
    1294:	b30e0400 	movwlt	r0, #58368	; 0xe400
    1298:	06000006 	streq	r0, [r0], -r6
    129c:	03e51d2c 	mvneq	r1, #44, 26	; 0xb00
    12a0:	12080000 	andne	r0, r8, #0
    12a4:	000009ae 	andeq	r0, r0, lr, lsr #19
    12a8:	d20e2f06 	andle	r2, lr, #6, 30
    12ac:	39000006 	stmdbcc	r0, {r1, r2}
    12b0:	44000004 	strmi	r0, [r0], #-4
    12b4:	13000004 	movwne	r0, #4
    12b8:	00000678 	andeq	r0, r0, r8, ror r6
    12bc:	0003e514 	andeq	lr, r3, r4, lsl r5
    12c0:	df150000 	svcle	0x00150000
    12c4:	06000007 	streq	r0, [r0], -r7
    12c8:	07670e31 			; <UNDEFINED> instruction: 0x07670e31
    12cc:	01f00000 	mvnseq	r0, r0
    12d0:	045c0000 	ldrbeq	r0, [ip], #-0
    12d4:	04670000 	strbteq	r0, [r7], #-0
    12d8:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
    12dc:	14000006 	strne	r0, [r0], #-6
    12e0:	000003eb 	andeq	r0, r0, fp, ror #7
    12e4:	0cae1600 	stceq	6, cr1, [lr]
    12e8:	35060000 	strcc	r0, [r6, #-0]
    12ec:	0008651d 	andeq	r6, r8, sp, lsl r5
    12f0:	0003e500 	andeq	lr, r3, r0, lsl #10
    12f4:	04800200 	streq	r0, [r0], #512	; 0x200
    12f8:	04860000 	streq	r0, [r6], #0
    12fc:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
    1300:	00000006 	andeq	r0, r0, r6
    1304:	00069e16 	andeq	r9, r6, r6, lsl lr
    1308:	1d370600 	ldcne	6, cr0, [r7, #-0]
    130c:	000009be 			; <UNDEFINED> instruction: 0x000009be
    1310:	000003e5 	andeq	r0, r0, r5, ror #7
    1314:	00049f02 	andeq	r9, r4, r2, lsl #30
    1318:	0004a500 	andeq	sl, r4, r0, lsl #10
    131c:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
    1320:	17000000 	strne	r0, [r0, -r0]
    1324:	0000094d 	andeq	r0, r0, sp, asr #18
    1328:	91313906 	teqls	r1, r6, lsl #18
    132c:	0c000006 	stceq	0, cr0, [r0], {6}
    1330:	0a941602 	beq	fe506b40 <__bss_end+0xfe4fd13c>
    1334:	3c060000 	stccc	0, cr0, [r6], {-0}
    1338:	0007ee09 	andeq	lr, r7, r9, lsl #28
    133c:	00067800 	andeq	r7, r6, r0, lsl #16
    1340:	04cc0100 	strbeq	r0, [ip], #256	; 0x100
    1344:	04d20000 	ldrbeq	r0, [r2], #0
    1348:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
    134c:	00000006 	andeq	r0, r0, r6
    1350:	00071f16 	andeq	r1, r7, r6, lsl pc
    1354:	123f0600 	eorsne	r0, pc, #0, 12
    1358:	0000054e 	andeq	r0, r0, lr, asr #10
    135c:	0000004d 	andeq	r0, r0, sp, asr #32
    1360:	0004eb01 	andeq	lr, r4, r1, lsl #22
    1364:	00050000 	andeq	r0, r5, r0
    1368:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
    136c:	9a140000 	bls	501374 <__bss_end+0x4f7970>
    1370:	14000006 	strne	r0, [r0], #-6
    1374:	0000005e 	andeq	r0, r0, lr, asr r0
    1378:	0001f014 	andeq	pc, r1, r4, lsl r0	; <UNPREDICTABLE>
    137c:	03180000 	tsteq	r8, #0
    1380:	0600000d 	streq	r0, [r0], -sp
    1384:	060e0e42 	streq	r0, [lr], -r2, asr #28
    1388:	15010000 	strne	r0, [r1, #-0]
    138c:	1b000005 	blne	13a8 <shift+0x13a8>
    1390:	13000005 	movwne	r0, #5
    1394:	00000678 	andeq	r0, r0, r8, ror r6
    1398:	05301600 	ldreq	r1, [r0, #-1536]!	; 0xfffffa00
    139c:	45060000 	strmi	r0, [r6, #-0]
    13a0:	0005b017 	andeq	fp, r5, r7, lsl r0
    13a4:	0003eb00 	andeq	lr, r3, r0, lsl #22
    13a8:	05340100 	ldreq	r0, [r4, #-256]!	; 0xffffff00
    13ac:	053a0000 	ldreq	r0, [sl, #-0]!
    13b0:	a0130000 	andsge	r0, r3, r0
    13b4:	00000006 	andeq	r0, r0, r6
    13b8:	000b7c16 	andeq	r7, fp, r6, lsl ip
    13bc:	17480600 	strbne	r0, [r8, -r0, lsl #12]
    13c0:	000003ff 	strdeq	r0, [r0], -pc	; <UNPREDICTABLE>
    13c4:	000003eb 	andeq	r0, r0, fp, ror #7
    13c8:	00055301 	andeq	r5, r5, r1, lsl #6
    13cc:	00055e00 	andeq	r5, r5, r0, lsl #28
    13d0:	06a01300 	strteq	r1, [r0], r0, lsl #6
    13d4:	4d140000 	ldcmi	0, cr0, [r4, #-0]
    13d8:	00000000 	andeq	r0, r0, r0
    13dc:	00063918 	andeq	r3, r6, r8, lsl r9
    13e0:	0e4b0600 	cdpeq	6, 4, cr0, cr11, cr0, {0}
    13e4:	0000095b 	andeq	r0, r0, fp, asr r9
    13e8:	00057301 	andeq	r7, r5, r1, lsl #6
    13ec:	00057900 	andeq	r7, r5, r0, lsl #18
    13f0:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
    13f4:	16000000 	strne	r0, [r0], -r0
    13f8:	000007df 	ldrdeq	r0, [r0], -pc	; <UNPREDICTABLE>
    13fc:	1c0e4d06 	stcne	13, cr4, [lr], {6}
    1400:	f000000a 			; <UNDEFINED> instruction: 0xf000000a
    1404:	01000001 	tsteq	r0, r1
    1408:	00000592 	muleq	r0, r2, r5
    140c:	0000059d 	muleq	r0, sp, r5
    1410:	00067813 	andeq	r7, r6, r3, lsl r8
    1414:	004d1400 	subeq	r1, sp, r0, lsl #8
    1418:	16000000 	strne	r0, [r0], -r0
    141c:	000004b9 			; <UNDEFINED> instruction: 0x000004b9
    1420:	2c125006 	ldccs	0, cr5, [r2], {6}
    1424:	4d000004 	stcmi	0, cr0, [r0, #-16]
    1428:	01000000 	mrseq	r0, (UNDEF: 0)
    142c:	000005b6 			; <UNDEFINED> instruction: 0x000005b6
    1430:	000005c1 	andeq	r0, r0, r1, asr #11
    1434:	00067813 	andeq	r7, r6, r3, lsl r8
    1438:	01fd1400 	mvnseq	r1, r0, lsl #8
    143c:	16000000 	strne	r0, [r0], -r0
    1440:	0000045f 	andeq	r0, r0, pc, asr r4
    1444:	170e5306 	strne	r5, [lr, -r6, lsl #6]
    1448:	f000000d 			; <UNDEFINED> instruction: 0xf000000d
    144c:	01000001 	tsteq	r0, r1
    1450:	000005da 	ldrdeq	r0, [r0], -sl
    1454:	000005e5 	andeq	r0, r0, r5, ror #11
    1458:	00067813 	andeq	r7, r6, r3, lsl r8
    145c:	004d1400 	subeq	r1, sp, r0, lsl #8
    1460:	18000000 	stmdane	r0, {}	; <UNPREDICTABLE>
    1464:	00000493 	muleq	r0, r3, r4
    1468:	f50e5606 			; <UNDEFINED> instruction: 0xf50e5606
    146c:	0100000b 	tsteq	r0, fp
    1470:	000005fa 	strdeq	r0, [r0], -sl
    1474:	00000619 	andeq	r0, r0, r9, lsl r6
    1478:	00067813 	andeq	r7, r6, r3, lsl r8
    147c:	00a91400 	adceq	r1, r9, r0, lsl #8
    1480:	4d140000 	ldcmi	0, cr0, [r4, #-0]
    1484:	14000000 	strne	r0, [r0], #-0
    1488:	0000004d 	andeq	r0, r0, sp, asr #32
    148c:	00004d14 	andeq	r4, r0, r4, lsl sp
    1490:	06a61400 	strteq	r1, [r6], r0, lsl #8
    1494:	18000000 	stmdane	r0, {}	; <UNPREDICTABLE>
    1498:	00000d59 	andeq	r0, r0, r9, asr sp
    149c:	e90e5806 	stmdb	lr, {r1, r2, fp, ip, lr}
    14a0:	0100000d 	tsteq	r0, sp
    14a4:	0000062e 	andeq	r0, r0, lr, lsr #12
    14a8:	0000064d 	andeq	r0, r0, sp, asr #12
    14ac:	00067813 	andeq	r7, r6, r3, lsl r8
    14b0:	00e01400 	rsceq	r1, r0, r0, lsl #8
    14b4:	4d140000 	ldcmi	0, cr0, [r4, #-0]
    14b8:	14000000 	strne	r0, [r0], #-0
    14bc:	0000004d 	andeq	r0, r0, sp, asr #32
    14c0:	00004d14 	andeq	r4, r0, r4, lsl sp
    14c4:	06a61400 	strteq	r1, [r6], r0, lsl #8
    14c8:	19000000 	stmdbne	r0, {}	; <UNPREDICTABLE>
    14cc:	000004a6 	andeq	r0, r0, r6, lsr #9
    14d0:	d40e5b06 	strle	r5, [lr], #-2822	; 0xfffff4fa
    14d4:	f0000008 			; <UNDEFINED> instruction: 0xf0000008
    14d8:	01000001 	tsteq	r0, r1
    14dc:	00000662 	andeq	r0, r0, r2, ror #12
    14e0:	00067813 	andeq	r7, r6, r3, lsl r8
    14e4:	03681400 	cmneq	r8, #0, 8
    14e8:	ac140000 	ldcge	0, cr0, [r4], {-0}
    14ec:	00000006 	andeq	r0, r0, r6
    14f0:	03f10300 	mvnseq	r0, #0, 6
    14f4:	040d0000 	streq	r0, [sp], #-0
    14f8:	000003f1 	strdeq	r0, [r0], -r1
    14fc:	0003e51a 	andeq	lr, r3, sl, lsl r5
    1500:	00068b00 	andeq	r8, r6, r0, lsl #22
    1504:	00069100 	andeq	r9, r6, r0, lsl #2
    1508:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
    150c:	1b000000 	blne	1514 <shift+0x1514>
    1510:	000003f1 	strdeq	r0, [r0], -r1
    1514:	0000067e 	andeq	r0, r0, lr, ror r6
    1518:	003f040d 	eorseq	r0, pc, sp, lsl #8
    151c:	040d0000 	streq	r0, [sp], #-0
    1520:	00000673 	andeq	r0, r0, r3, ror r6
    1524:	0065041c 	rsbeq	r0, r5, ip, lsl r4
    1528:	041d0000 	ldreq	r0, [sp], #-0
    152c:	00002c0f 	andeq	r2, r0, pc, lsl #24
    1530:	0006be00 	andeq	fp, r6, r0, lsl #28
    1534:	005e1000 	subseq	r1, lr, r0
    1538:	00090000 	andeq	r0, r9, r0
    153c:	0006ae03 	andeq	sl, r6, r3, lsl #28
    1540:	0f3b1e00 	svceq	0x003b1e00
    1544:	a3010000 	movwge	r0, #4096	; 0x1000
    1548:	0006be0c 	andeq	fp, r6, ip, lsl #28
    154c:	c4030500 	strgt	r0, [r3], #-1280	; 0xfffffb00
    1550:	1f000099 	svcne	0x00000099
    1554:	00000eab 	andeq	r0, r0, fp, lsr #29
    1558:	aa0aa501 	bge	2aa964 <__bss_end+0x2a0f60>
    155c:	4d00000f 	stcmi	0, cr0, [r0, #-60]	; 0xffffffc4
    1560:	98000000 	stmdals	r0, {}	; <UNPREDICTABLE>
    1564:	b000008d 	andlt	r0, r0, sp, lsl #1
    1568:	01000000 	mrseq	r0, (UNDEF: 0)
    156c:	0007339c 	muleq	r7, ip, r3
    1570:	120a2000 	andne	r2, sl, #0
    1574:	a5010000 	strge	r0, [r1, #-0]
    1578:	0001f71b 	andeq	pc, r1, fp, lsl r7	; <UNPREDICTABLE>
    157c:	ac910300 	ldcge	3, cr0, [r1], {0}
    1580:	1009207f 	andne	r2, r9, pc, ror r0
    1584:	a5010000 	strge	r0, [r1, #-0]
    1588:	00004d2a 	andeq	r4, r0, sl, lsr #26
    158c:	a8910300 	ldmge	r1, {r8, r9}
    1590:	0f931e7f 	svceq	0x00931e7f
    1594:	a7010000 	strge	r0, [r1, -r0]
    1598:	0007330a 	andeq	r3, r7, sl, lsl #6
    159c:	b4910300 	ldrlt	r0, [r1], #768	; 0x300
    15a0:	0ea61e7f 	mcreq	14, 5, r1, cr6, cr15, {3}
    15a4:	ab010000 	blge	415ac <__bss_end+0x37ba8>
    15a8:	00003809 	andeq	r3, r0, r9, lsl #16
    15ac:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    15b0:	00250f00 	eoreq	r0, r5, r0, lsl #30
    15b4:	07430000 	strbeq	r0, [r3, -r0]
    15b8:	5e100000 	cdppl	0, 1, cr0, cr0, cr0, {0}
    15bc:	3f000000 	svccc	0x00000000
    15c0:	0fee2100 	svceq	0x00ee2100
    15c4:	97010000 	strls	r0, [r1, -r0]
    15c8:	00109e0a 	andseq	r9, r0, sl, lsl #28
    15cc:	00004d00 	andeq	r4, r0, r0, lsl #26
    15d0:	008d5c00 	addeq	r5, sp, r0, lsl #24
    15d4:	00003c00 	andeq	r3, r0, r0, lsl #24
    15d8:	809c0100 	addshi	r0, ip, r0, lsl #2
    15dc:	22000007 	andcs	r0, r0, #7
    15e0:	00716572 	rsbseq	r6, r1, r2, ror r5
    15e4:	ab209901 	blge	8279f0 <__bss_end+0x81dfec>
    15e8:	02000003 	andeq	r0, r0, #3
    15ec:	9f1e7491 	svcls	0x001e7491
    15f0:	0100000f 	tsteq	r0, pc
    15f4:	004d0e9a 	umaaleq	r0, sp, sl, lr
    15f8:	91020000 	mrsls	r0, (UNDEF: 2)
    15fc:	12230070 	eorne	r0, r3, #112	; 0x70
    1600:	01000010 	tsteq	r0, r0, lsl r0
    1604:	0ec7068e 	cdpeq	6, 12, cr0, cr7, cr14, {4}
    1608:	8d200000 	stchi	0, cr0, [r0, #-0]
    160c:	003c0000 	eorseq	r0, ip, r0
    1610:	9c010000 	stcls	0, cr0, [r1], {-0}
    1614:	000007b9 			; <UNDEFINED> instruction: 0x000007b9
    1618:	000f0920 	andeq	r0, pc, r0, lsr #18
    161c:	218e0100 	orrcs	r0, lr, r0, lsl #2
    1620:	0000004d 	andeq	r0, r0, sp, asr #32
    1624:	226c9102 	rsbcs	r9, ip, #-2147483648	; 0x80000000
    1628:	00716572 	rsbseq	r6, r1, r2, ror r5
    162c:	ab209001 	blge	825638 <__bss_end+0x81bc34>
    1630:	02000003 	andeq	r0, r0, #3
    1634:	21007491 			; <UNDEFINED> instruction: 0x21007491
    1638:	00000fcb 	andeq	r0, r0, fp, asr #31
    163c:	4c0a8201 	sfmmi	f0, 1, [sl], {1}
    1640:	4d00000f 	stcmi	0, cr0, [r0, #-60]	; 0xffffffc4
    1644:	e4000000 	str	r0, [r0], #-0
    1648:	3c00008c 	stccc	0, cr0, [r0], {140}	; 0x8c
    164c:	01000000 	mrseq	r0, (UNDEF: 0)
    1650:	0007f69c 	muleq	r7, ip, r6
    1654:	65722200 	ldrbvs	r2, [r2, #-512]!	; 0xfffffe00
    1658:	84010071 	strhi	r0, [r1], #-113	; 0xffffff8f
    165c:	00038720 	andeq	r8, r3, r0, lsr #14
    1660:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    1664:	000e9f1e 	andeq	r9, lr, lr, lsl pc
    1668:	0e850100 	rmfeqs	f0, f5, f0
    166c:	0000004d 	andeq	r0, r0, sp, asr #32
    1670:	00709102 	rsbseq	r9, r0, r2, lsl #2
    1674:	0011ed21 	andseq	lr, r1, r1, lsr #26
    1678:	0a760100 	beq	1d81a80 <__bss_end+0x1d7807c>
    167c:	00000f1d 	andeq	r0, r0, sp, lsl pc
    1680:	0000004d 	andeq	r0, r0, sp, asr #32
    1684:	00008ca8 	andeq	r8, r0, r8, lsr #25
    1688:	0000003c 	andeq	r0, r0, ip, lsr r0
    168c:	08339c01 	ldmdaeq	r3!, {r0, sl, fp, ip, pc}
    1690:	72220000 	eorvc	r0, r2, #0
    1694:	01007165 	tsteq	r0, r5, ror #2
    1698:	03872078 	orreq	r2, r7, #120	; 0x78
    169c:	91020000 	mrsls	r0, (UNDEF: 2)
    16a0:	0e9f1e74 	mrceq	14, 4, r1, cr15, cr4, {3}
    16a4:	79010000 	stmdbvc	r1, {}	; <UNPREDICTABLE>
    16a8:	00004d0e 	andeq	r4, r0, lr, lsl #26
    16ac:	70910200 	addsvc	r0, r1, r0, lsl #4
    16b0:	0f602100 	svceq	0x00602100
    16b4:	6a010000 	bvs	416bc <__bss_end+0x37cb8>
    16b8:	00108006 	andseq	r8, r0, r6
    16bc:	0001f000 	andeq	pc, r1, r0
    16c0:	008c5400 	addeq	r5, ip, r0, lsl #8
    16c4:	00005400 	andeq	r5, r0, r0, lsl #8
    16c8:	7f9c0100 	svcvc	0x009c0100
    16cc:	20000008 	andcs	r0, r0, r8
    16d0:	00000f9f 	muleq	r0, pc, pc	; <UNPREDICTABLE>
    16d4:	4d156a01 	vldrmi	s12, [r5, #-4]
    16d8:	02000000 	andeq	r0, r0, #0
    16dc:	fd206c91 	stc2	12, cr6, [r0, #-580]!	; 0xfffffdbc
    16e0:	01000009 	tsteq	r0, r9
    16e4:	004d256a 	subeq	r2, sp, sl, ror #10
    16e8:	91020000 	mrsls	r0, (UNDEF: 2)
    16ec:	11e51e68 	mvnne	r1, r8, ror #28
    16f0:	6c010000 	stcvs	0, cr0, [r1], {-0}
    16f4:	00004d0e 	andeq	r4, r0, lr, lsl #26
    16f8:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    16fc:	0ede2100 	cdpeq	1, 13, cr2, cr14, cr0, {0}
    1700:	5d010000 	stcpl	0, cr0, [r1, #-0]
    1704:	0010d512 	andseq	sp, r0, r2, lsl r5
    1708:	00008b00 	andeq	r8, r0, r0, lsl #22
    170c:	008c0400 	addeq	r0, ip, r0, lsl #8
    1710:	00005000 	andeq	r5, r0, r0
    1714:	da9c0100 	ble	fe701b1c <__bss_end+0xfe6f8118>
    1718:	20000008 	andcs	r0, r0, r8
    171c:	0000108b 	andeq	r1, r0, fp, lsl #1
    1720:	4d205d01 	stcmi	13, cr5, [r0, #-4]!
    1724:	02000000 	andeq	r0, r0, #0
    1728:	d4206c91 	strtle	r6, [r0], #-3217	; 0xfffff36f
    172c:	0100000f 	tsteq	r0, pc
    1730:	004d2f5d 	subeq	r2, sp, sp, asr pc
    1734:	91020000 	mrsls	r0, (UNDEF: 2)
    1738:	09fd2068 	ldmibeq	sp!, {r3, r5, r6, sp}^
    173c:	5d010000 	stcpl	0, cr0, [r1, #-0]
    1740:	00004d3f 	andeq	r4, r0, pc, lsr sp
    1744:	64910200 	ldrvs	r0, [r1], #512	; 0x200
    1748:	0011e51e 	andseq	lr, r1, lr, lsl r5
    174c:	165f0100 	ldrbne	r0, [pc], -r0, lsl #2
    1750:	0000008b 	andeq	r0, r0, fp, lsl #1
    1754:	00749102 	rsbseq	r9, r4, r2, lsl #2
    1758:	00110b21 	andseq	r0, r1, r1, lsr #22
    175c:	0a510100 	beq	1441b64 <__bss_end+0x1438160>
    1760:	00000ee3 	andeq	r0, r0, r3, ror #29
    1764:	0000004d 	andeq	r0, r0, sp, asr #32
    1768:	00008bc0 	andeq	r8, r0, r0, asr #23
    176c:	00000044 	andeq	r0, r0, r4, asr #32
    1770:	09269c01 	stmdbeq	r6!, {r0, sl, fp, ip, pc}
    1774:	8b200000 	blhi	80177c <__bss_end+0x7f7d78>
    1778:	01000010 	tsteq	r0, r0, lsl r0
    177c:	004d1a51 	subeq	r1, sp, r1, asr sl
    1780:	91020000 	mrsls	r0, (UNDEF: 2)
    1784:	0fd4206c 	svceq	0x00d4206c
    1788:	51010000 	mrspl	r0, (UNDEF: 1)
    178c:	00004d29 	andeq	r4, r0, r9, lsr #26
    1790:	68910200 	ldmvs	r1, {r9}
    1794:	0011041e 	andseq	r0, r1, lr, lsl r4
    1798:	0e530100 	rdfeqs	f0, f3, f0
    179c:	0000004d 	andeq	r0, r0, sp, asr #32
    17a0:	00749102 	rsbseq	r9, r4, r2, lsl #2
    17a4:	0010fe21 	andseq	pc, r0, r1, lsr #28
    17a8:	0a440100 	beq	1101bb0 <__bss_end+0x10f81ac>
    17ac:	000010e0 	andeq	r1, r0, r0, ror #1
    17b0:	0000004d 	andeq	r0, r0, sp, asr #32
    17b4:	00008b70 	andeq	r8, r0, r0, ror fp
    17b8:	00000050 	andeq	r0, r0, r0, asr r0
    17bc:	09819c01 	stmibeq	r1, {r0, sl, fp, ip, pc}
    17c0:	8b200000 	blhi	8017c8 <__bss_end+0x7f7dc4>
    17c4:	01000010 	tsteq	r0, r0, lsl r0
    17c8:	004d1944 	subeq	r1, sp, r4, asr #18
    17cc:	91020000 	mrsls	r0, (UNDEF: 2)
    17d0:	0f74206c 	svceq	0x0074206c
    17d4:	44010000 	strmi	r0, [r1], #-0
    17d8:	00011d30 	andeq	r1, r1, r0, lsr sp
    17dc:	68910200 	ldmvs	r1, {r9}
    17e0:	000fda20 	andeq	sp, pc, r0, lsr #20
    17e4:	41440100 	mrsmi	r0, (UNDEF: 84)
    17e8:	000006ac 	andeq	r0, r0, ip, lsr #13
    17ec:	1e649102 	lgnnes	f1, f2
    17f0:	000011e5 	andeq	r1, r0, r5, ror #3
    17f4:	4d0e4601 	stcmi	6, cr4, [lr, #-4]
    17f8:	02000000 	andeq	r0, r0, #0
    17fc:	23007491 	movwcs	r7, #1169	; 0x491
    1800:	00000e8c 	andeq	r0, r0, ip, lsl #29
    1804:	7e063e01 	cdpvc	14, 0, cr3, cr6, cr1, {0}
    1808:	4400000f 	strmi	r0, [r0], #-15
    180c:	2c00008b 	stccs	0, cr0, [r0], {139}	; 0x8b
    1810:	01000000 	mrseq	r0, (UNDEF: 0)
    1814:	0009ab9c 	muleq	r9, ip, fp
    1818:	108b2000 	addne	r2, fp, r0
    181c:	3e010000 	cdpcc	0, 0, cr0, cr1, cr0, {0}
    1820:	00004d15 	andeq	r4, r0, r5, lsl sp
    1824:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    1828:	0f992100 	svceq	0x00992100
    182c:	31010000 	mrscc	r0, (UNDEF: 1)
    1830:	000fe00a 	andeq	lr, pc, sl
    1834:	00004d00 	andeq	r4, r0, r0, lsl #26
    1838:	008af400 	addeq	pc, sl, r0, lsl #8
    183c:	00005000 	andeq	r5, r0, r0
    1840:	069c0100 	ldreq	r0, [ip], r0, lsl #2
    1844:	2000000a 	andcs	r0, r0, sl
    1848:	0000108b 	andeq	r1, r0, fp, lsl #1
    184c:	4d193101 	ldfmis	f3, [r9, #-4]
    1850:	02000000 	andeq	r0, r0, #0
    1854:	21206c91 			; <UNDEFINED> instruction: 0x21206c91
    1858:	01000011 	tsteq	r0, r1, lsl r0
    185c:	01f72b31 	mvnseq	r2, r1, lsr fp
    1860:	91020000 	mrsls	r0, (UNDEF: 2)
    1864:	100d2068 	andne	r2, sp, r8, rrx
    1868:	31010000 	mrscc	r0, (UNDEF: 1)
    186c:	00004d3c 	andeq	r4, r0, ip, lsr sp
    1870:	64910200 	ldrvs	r0, [r1], #512	; 0x200
    1874:	0010cf1e 	andseq	ip, r0, lr, lsl pc
    1878:	0e330100 	rsfeqs	f0, f3, f0
    187c:	0000004d 	andeq	r0, r0, sp, asr #32
    1880:	00749102 	rsbseq	r9, r4, r2, lsl #2
    1884:	00120f21 	andseq	r0, r2, r1, lsr #30
    1888:	0a240100 	beq	901c90 <__bss_end+0x8f828c>
    188c:	00001128 	andeq	r1, r0, r8, lsr #2
    1890:	0000004d 	andeq	r0, r0, sp, asr #32
    1894:	00008aa4 	andeq	r8, r0, r4, lsr #21
    1898:	00000050 	andeq	r0, r0, r0, asr r0
    189c:	0a619c01 	beq	18688a8 <__bss_end+0x185eea4>
    18a0:	8b200000 	blhi	8018a8 <__bss_end+0x7f7ea4>
    18a4:	01000010 	tsteq	r0, r0, lsl r0
    18a8:	004d1824 	subeq	r1, sp, r4, lsr #16
    18ac:	91020000 	mrsls	r0, (UNDEF: 2)
    18b0:	1121206c 			; <UNDEFINED> instruction: 0x1121206c
    18b4:	24010000 	strcs	r0, [r1], #-0
    18b8:	000a672a 	andeq	r6, sl, sl, lsr #14
    18bc:	68910200 	ldmvs	r1, {r9}
    18c0:	00100d20 	andseq	r0, r0, r0, lsr #26
    18c4:	3b240100 	blcc	901ccc <__bss_end+0x8f82c8>
    18c8:	0000004d 	andeq	r0, r0, sp, asr #32
    18cc:	1e649102 	lgnnes	f1, f2
    18d0:	00000eb0 			; <UNDEFINED> instruction: 0x00000eb0
    18d4:	4d0e2601 	stcmi	6, cr2, [lr, #-4]
    18d8:	02000000 	andeq	r0, r0, #0
    18dc:	0d007491 	cfstrseq	mvf7, [r0, #-580]	; 0xfffffdbc
    18e0:	00002504 	andeq	r2, r0, r4, lsl #10
    18e4:	0a610300 	beq	18424ec <__bss_end+0x1838ae8>
    18e8:	a5210000 	strge	r0, [r1, #-0]!
    18ec:	0100000f 	tsteq	r0, pc
    18f0:	121b0a19 	andsne	r0, fp, #102400	; 0x19000
    18f4:	004d0000 	subeq	r0, sp, r0
    18f8:	8a600000 	bhi	1801900 <__bss_end+0x17f7efc>
    18fc:	00440000 	subeq	r0, r4, r0
    1900:	9c010000 	stcls	0, cr0, [r1], {-0}
    1904:	00000ab8 			; <UNDEFINED> instruction: 0x00000ab8
    1908:	00120620 	andseq	r0, r2, r0, lsr #12
    190c:	1b190100 	blne	641d14 <__bss_end+0x638310>
    1910:	000001f7 	strdeq	r0, [r0], -r7
    1914:	206c9102 	rsbcs	r9, ip, r2, lsl #2
    1918:	0000111c 	andeq	r1, r0, ip, lsl r1
    191c:	c6351901 	ldrtgt	r1, [r5], -r1, lsl #18
    1920:	02000001 	andeq	r0, r0, #1
    1924:	8b1e6891 	blhi	79bb70 <__bss_end+0x79216c>
    1928:	01000010 	tsteq	r0, r0, lsl r0
    192c:	004d0e1b 	subeq	r0, sp, fp, lsl lr
    1930:	91020000 	mrsls	r0, (UNDEF: 2)
    1934:	fd240074 	stc2	0, cr0, [r4, #-464]!	; 0xfffffe30
    1938:	0100000e 	tsteq	r0, lr
    193c:	0eb60614 	mrceq	6, 5, r0, cr6, cr4, {0}
    1940:	8a440000 	bhi	1101948 <__bss_end+0x10f7f44>
    1944:	001c0000 	andseq	r0, ip, r0
    1948:	9c010000 	stcls	0, cr0, [r1], {-0}
    194c:	00111223 	andseq	r1, r1, r3, lsr #4
    1950:	060e0100 	streq	r0, [lr], -r0, lsl #2
    1954:	00000f66 	andeq	r0, r0, r6, ror #30
    1958:	00008a18 	andeq	r8, r0, r8, lsl sl
    195c:	0000002c 	andeq	r0, r0, ip, lsr #32
    1960:	0af89c01 	beq	ffe2896c <__bss_end+0xffe1ef68>
    1964:	f4200000 	vld4.8	{d0-d3}, [r0], r0
    1968:	0100000e 	tsteq	r0, lr
    196c:	0038140e 	eorseq	r1, r8, lr, lsl #8
    1970:	91020000 	mrsls	r0, (UNDEF: 2)
    1974:	14250074 	strtne	r0, [r5], #-116	; 0xffffff8c
    1978:	01000012 	tsteq	r0, r2, lsl r0
    197c:	0f880a04 	svceq	0x00880a04
    1980:	004d0000 	subeq	r0, sp, r0
    1984:	89ec0000 	stmibhi	ip!, {}^	; <UNPREDICTABLE>
    1988:	002c0000 	eoreq	r0, ip, r0
    198c:	9c010000 	stcls	0, cr0, [r1], {-0}
    1990:	64697022 	strbtvs	r7, [r9], #-34	; 0xffffffde
    1994:	0e060100 	adfeqs	f0, f6, f0
    1998:	0000004d 	andeq	r0, r0, sp, asr #32
    199c:	00749102 	rsbseq	r9, r4, r2, lsl #2
    19a0:	00047c00 	andeq	r7, r4, r0, lsl #24
    19a4:	1d000400 	cfstrsne	mvf0, [r0, #-0]
    19a8:	04000007 	streq	r0, [r0], #-7
    19ac:	00113401 	andseq	r3, r1, r1, lsl #8
    19b0:	13650400 	cmnne	r5, #0, 8
    19b4:	0e410000 	cdpeq	0, 4, cr0, cr1, cr0, {0}
    19b8:	8e480000 	cdphi	0, 4, cr0, cr8, cr0, {0}
    19bc:	07c00000 	strbeq	r0, [r0, r0]
    19c0:	0a010000 	beq	419c8 <__bss_end+0x37fc4>
    19c4:	49020000 	stmdbmi	r2, {}	; <UNPREDICTABLE>
    19c8:	03000000 	movweq	r0, #0
    19cc:	000012d6 	ldrdeq	r1, [r0], -r6
    19d0:	61100501 	tstvs	r0, r1, lsl #10
    19d4:	11000000 	mrsne	r0, (UNDEF: 0)
    19d8:	33323130 	teqcc	r2, #48, 2
    19dc:	37363534 			; <UNDEFINED> instruction: 0x37363534
    19e0:	42413938 	submi	r3, r1, #56, 18	; 0xe0000
    19e4:	46454443 	strbmi	r4, [r5], -r3, asr #8
    19e8:	01040000 	mrseq	r0, (UNDEF: 4)
    19ec:	00250103 	eoreq	r0, r5, r3, lsl #2
    19f0:	74050000 	strvc	r0, [r5], #-0
    19f4:	61000000 	mrsvs	r0, (UNDEF: 0)
    19f8:	06000000 	streq	r0, [r0], -r0
    19fc:	00000066 	andeq	r0, r0, r6, rrx
    1a00:	51070010 	tstpl	r7, r0, lsl r0
    1a04:	08000000 	stmdaeq	r0, {}	; <UNPREDICTABLE>
    1a08:	0bc80704 	bleq	ff203620 <__bss_end+0xff1f9c1c>
    1a0c:	01080000 	mrseq	r0, (UNDEF: 8)
    1a10:	000c7508 	andeq	r7, ip, r8, lsl #10
    1a14:	006d0700 	rsbeq	r0, sp, r0, lsl #14
    1a18:	2a090000 	bcs	241a20 <__bss_end+0x23801c>
    1a1c:	0a000000 	beq	1a24 <shift+0x1a24>
    1a20:	0000125f 	andeq	r1, r0, pc, asr r2
    1a24:	c006aa01 	andgt	sl, r6, r1, lsl #20
    1a28:	94000012 	strls	r0, [r0], #-18	; 0xffffffee
    1a2c:	74000095 	strvc	r0, [r0], #-149	; 0xffffff6b
    1a30:	01000000 	mrseq	r0, (UNDEF: 0)
    1a34:	0000d19c 	muleq	r0, ip, r1
    1a38:	12660b00 	rsbne	r0, r6, #0, 22
    1a3c:	aa010000 	bge	41a44 <__bss_end+0x38040>
    1a40:	0000d113 	andeq	sp, r0, r3, lsl r1
    1a44:	6c910200 	lfmvs	f0, 4, [r1], {0}
    1a48:	6372730c 	cmnvs	r2, #12, 6	; 0x30000000
    1a4c:	25aa0100 	strcs	r0, [sl, #256]!	; 0x100
    1a50:	000000d7 	ldrdeq	r0, [r0], -r7
    1a54:	0d689102 	stfeqp	f1, [r8, #-8]!
    1a58:	ab010069 	blge	41c04 <__bss_end+0x38200>
    1a5c:	0000dd06 	andeq	sp, r0, r6, lsl #26
    1a60:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    1a64:	01006a0d 	tsteq	r0, sp, lsl #20
    1a68:	00dd06ac 	sbcseq	r0, sp, ip, lsr #13
    1a6c:	91020000 	mrsls	r0, (UNDEF: 2)
    1a70:	040e0070 	streq	r0, [lr], #-112	; 0xffffff90
    1a74:	0000006d 	andeq	r0, r0, sp, rrx
    1a78:	0074040e 	rsbseq	r0, r4, lr, lsl #8
    1a7c:	040f0000 	streq	r0, [pc], #-0	; 1a84 <shift+0x1a84>
    1a80:	746e6905 	strbtvc	r6, [lr], #-2309	; 0xfffff6fb
    1a84:	12f41000 	rscsne	r1, r4, #0
    1a88:	a1010000 	mrsge	r0, (UNDEF: 1)
    1a8c:	00123706 	andseq	r3, r2, r6, lsl #14
    1a90:	00951400 	addseq	r1, r5, r0, lsl #8
    1a94:	00008000 	andeq	r8, r0, r0
    1a98:	619c0100 	orrsvs	r0, ip, r0, lsl #2
    1a9c:	0c000001 	stceq	0, cr0, [r0], {1}
    1aa0:	00637273 	rsbeq	r7, r3, r3, ror r2
    1aa4:	6119a101 	tstvs	r9, r1, lsl #2
    1aa8:	02000001 	andeq	r0, r0, #1
    1aac:	640c6491 	strvs	r6, [ip], #-1169	; 0xfffffb6f
    1ab0:	01007473 	tsteq	r0, r3, ror r4
    1ab4:	016824a1 	cmneq	r8, r1, lsr #9
    1ab8:	91020000 	mrsls	r0, (UNDEF: 2)
    1abc:	756e0c60 	strbvc	r0, [lr, #-3168]!	; 0xfffff3a0
    1ac0:	a101006d 	tstge	r1, sp, rrx
    1ac4:	0000dd2d 	andeq	sp, r0, sp, lsr #26
    1ac8:	5c910200 	lfmpl	f0, 4, [r1], {0}
    1acc:	0012e711 	andseq	lr, r2, r1, lsl r7
    1ad0:	0ea30100 	fdveqs	f0, f3, f0
    1ad4:	000000d7 	ldrdeq	r0, [r0], -r7
    1ad8:	11709102 	cmnne	r0, r2, lsl #2
    1adc:	000012cf 	andeq	r1, r0, pc, asr #5
    1ae0:	d108a401 	tstle	r8, r1, lsl #8
    1ae4:	02000000 	andeq	r0, r0, #0
    1ae8:	3c126c91 	ldccc	12, cr6, [r2], {145}	; 0x91
    1aec:	48000095 	stmdami	r0, {r0, r2, r4, r7}
    1af0:	0d000000 	stceq	0, cr0, [r0, #-0]
    1af4:	a6010069 	strge	r0, [r1], -r9, rrx
    1af8:	0000dd0b 	andeq	sp, r0, fp, lsl #26
    1afc:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    1b00:	040e0000 	streq	r0, [lr], #-0
    1b04:	00000167 	andeq	r0, r0, r7, ror #2
    1b08:	10041413 	andne	r1, r4, r3, lsl r4
    1b0c:	000012ee 	andeq	r1, r0, lr, ror #5
    1b10:	83069901 	movwhi	r9, #26881	; 0x6901
    1b14:	ac000012 	stcge	0, cr0, [r0], {18}
    1b18:	68000094 	stmdavs	r0, {r2, r4, r7}
    1b1c:	01000000 	mrseq	r0, (UNDEF: 0)
    1b20:	0001c99c 	muleq	r1, ip, r9
    1b24:	13570b00 	cmpne	r7, #0, 22
    1b28:	99010000 	stmdbls	r1, {}	; <UNPREDICTABLE>
    1b2c:	00016812 	andeq	r6, r1, r2, lsl r8
    1b30:	6c910200 	lfmvs	f0, 4, [r1], {0}
    1b34:	00135e0b 	andseq	r5, r3, fp, lsl #28
    1b38:	1e990100 	fmlnee	f0, f1, f0
    1b3c:	000000dd 	ldrdeq	r0, [r0], -sp
    1b40:	0d689102 	stfeqp	f1, [r8, #-8]!
    1b44:	006d656d 	rsbeq	r6, sp, sp, ror #10
    1b48:	d1089b01 	tstle	r8, r1, lsl #22
    1b4c:	02000000 	andeq	r0, r0, #0
    1b50:	c8127091 	ldmdagt	r2, {r0, r4, r7, ip, sp, lr}
    1b54:	3c000094 	stccc	0, cr0, [r0], {148}	; 0x94
    1b58:	0d000000 	stceq	0, cr0, [r0, #-0]
    1b5c:	9d010069 	stcls	0, cr0, [r1, #-420]	; 0xfffffe5c
    1b60:	0000dd0b 	andeq	sp, r0, fp, lsl #26
    1b64:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    1b68:	58150000 	ldmdapl	r5, {}	; <UNPREDICTABLE>
    1b6c:	01000012 	tsteq	r0, r2, lsl r0
    1b70:	1330058f 	teqne	r0, #599785472	; 0x23c00000
    1b74:	00dd0000 	sbcseq	r0, sp, r0
    1b78:	94580000 	ldrbls	r0, [r8], #-0
    1b7c:	00540000 	subseq	r0, r4, r0
    1b80:	9c010000 	stcls	0, cr0, [r1], {-0}
    1b84:	00000202 	andeq	r0, r0, r2, lsl #4
    1b88:	0100730c 	tsteq	r0, ip, lsl #6
    1b8c:	00d7188f 	sbcseq	r1, r7, pc, lsl #17
    1b90:	91020000 	mrsls	r0, (UNDEF: 2)
    1b94:	00690d6c 	rsbeq	r0, r9, ip, ror #26
    1b98:	dd069101 	stfled	f1, [r6, #-4]
    1b9c:	02000000 	andeq	r0, r0, #0
    1ba0:	15007491 	strne	r7, [r0, #-1169]	; 0xfffffb6f
    1ba4:	000012fb 	strdeq	r1, [r0], -fp
    1ba8:	3d057f01 	stccc	15, cr7, [r5, #-4]
    1bac:	dd000013 	stcle	0, cr0, [r0, #-76]	; 0xffffffb4
    1bb0:	ac000000 	stcge	0, cr0, [r0], {-0}
    1bb4:	ac000093 	stcge	0, cr0, [r0], {147}	; 0x93
    1bb8:	01000000 	mrseq	r0, (UNDEF: 0)
    1bbc:	0002689c 	muleq	r2, ip, r8
    1bc0:	31730c00 	cmncc	r3, r0, lsl #24
    1bc4:	197f0100 	ldmdbne	pc!, {r8}^	; <UNPREDICTABLE>
    1bc8:	000000d7 	ldrdeq	r0, [r0], -r7
    1bcc:	0c6c9102 	stfeqp	f1, [ip], #-8
    1bd0:	01003273 	tsteq	r0, r3, ror r2
    1bd4:	00d7297f 	sbcseq	r2, r7, pc, ror r9
    1bd8:	91020000 	mrsls	r0, (UNDEF: 2)
    1bdc:	756e0c68 	strbvc	r0, [lr, #-3176]!	; 0xfffff398
    1be0:	7f01006d 	svcvc	0x0001006d
    1be4:	0000dd31 	andeq	sp, r0, r1, lsr sp
    1be8:	64910200 	ldrvs	r0, [r1], #512	; 0x200
    1bec:	0031750d 	eorseq	r7, r1, sp, lsl #10
    1bf0:	68108101 	ldmdavs	r0, {r0, r8, pc}
    1bf4:	02000002 	andeq	r0, r0, #2
    1bf8:	750d7791 	strvc	r7, [sp, #-1937]	; 0xfffff86f
    1bfc:	81010032 	tsthi	r1, r2, lsr r0
    1c00:	00026814 	andeq	r6, r2, r4, lsl r8
    1c04:	76910200 	ldrvc	r0, [r1], r0, lsl #4
    1c08:	08010800 	stmdaeq	r1, {fp}
    1c0c:	00000c6c 	andeq	r0, r0, ip, ror #24
    1c10:	00128f15 	andseq	r8, r2, r5, lsl pc
    1c14:	07730100 	ldrbeq	r0, [r3, -r0, lsl #2]!
    1c18:	00001297 	muleq	r0, r7, r2
    1c1c:	000000d1 	ldrdeq	r0, [r0], -r1
    1c20:	000092ec 	andeq	r9, r0, ip, ror #5
    1c24:	000000c0 	andeq	r0, r0, r0, asr #1
    1c28:	02c89c01 	sbceq	r9, r8, #256	; 0x100
    1c2c:	660b0000 	strvs	r0, [fp], -r0
    1c30:	01000012 	tsteq	r0, r2, lsl r0
    1c34:	00d11573 	sbcseq	r1, r1, r3, ror r5
    1c38:	91020000 	mrsls	r0, (UNDEF: 2)
    1c3c:	72730c6c 	rsbsvc	r0, r3, #108, 24	; 0x6c00
    1c40:	73010063 	movwvc	r0, #4195	; 0x1063
    1c44:	0000d727 	andeq	sp, r0, r7, lsr #14
    1c48:	68910200 	ldmvs	r1, {r9}
    1c4c:	6d756e0c 	ldclvs	14, cr6, [r5, #-48]!	; 0xffffffd0
    1c50:	30730100 	rsbscc	r0, r3, r0, lsl #2
    1c54:	000000dd 	ldrdeq	r0, [r0], -sp
    1c58:	0d649102 	stfeqp	f1, [r4, #-8]!
    1c5c:	75010069 	strvc	r0, [r1, #-105]	; 0xffffff97
    1c60:	0000dd06 	andeq	sp, r0, r6, lsl #26
    1c64:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    1c68:	12e21500 	rscne	r1, r2, #0, 10
    1c6c:	36010000 	strcc	r0, [r1], -r0
    1c70:	00132407 	andseq	r2, r3, r7, lsl #8
    1c74:	0000d100 	andeq	sp, r0, r0, lsl #2
    1c78:	00905800 	addseq	r5, r0, r0, lsl #16
    1c7c:	00029400 	andeq	r9, r2, r0, lsl #8
    1c80:	ac9c0100 	ldfges	f0, [ip], {0}
    1c84:	0b000003 	bleq	1c98 <shift+0x1c98>
    1c88:	0000126b 	andeq	r1, r0, fp, ror #4
    1c8c:	ac123601 	ldcge	6, cr3, [r2], {1}
    1c90:	02000003 	andeq	r0, r0, #3
    1c94:	1d0b4c91 	stcne	12, cr4, [fp, #-580]	; 0xfffffdbc
    1c98:	01000013 	tsteq	r0, r3, lsl r0
    1c9c:	00d11f36 	sbcseq	r1, r1, r6, lsr pc
    1ca0:	91020000 	mrsls	r0, (UNDEF: 2)
    1ca4:	13030b48 	movwne	r0, #15176	; 0x3b48
    1ca8:	36010000 	strcc	r0, [r1], -r0
    1cac:	00006634 	andeq	r6, r0, r4, lsr r6
    1cb0:	44910200 	ldrmi	r0, [r1], #512	; 0x200
    1cb4:	7274700d 	rsbsvc	r7, r4, #13
    1cb8:	08380100 	ldmdaeq	r8!, {r8}
    1cbc:	000000d1 	ldrdeq	r0, [r0], -r1
    1cc0:	11749102 	cmnne	r4, r2, lsl #2
    1cc4:	000012a8 	andeq	r1, r0, r8, lsr #5
    1cc8:	dd094101 	stfles	f4, [r9, #-4]
    1ccc:	02000000 	andeq	r0, r0, #0
    1cd0:	b1117091 			; <UNDEFINED> instruction: 0xb1117091
    1cd4:	01000012 	tsteq	r0, r2, lsl r0
    1cd8:	03ac0b42 			; <UNDEFINED> instruction: 0x03ac0b42
    1cdc:	91020000 	mrsls	r0, (UNDEF: 2)
    1ce0:	134f116c 	movtne	r1, #61804	; 0xf16c
    1ce4:	45010000 	strmi	r0, [r1, #-0]
    1ce8:	0003b30a 	andeq	fp, r3, sl, lsl #6
    1cec:	50910200 	addspl	r0, r1, r0, lsl #4
    1cf0:	00127b11 	andseq	r7, r2, r1, lsl fp
    1cf4:	0b460100 	bleq	11820fc <__bss_end+0x11786f8>
    1cf8:	000000d1 	ldrdeq	r0, [r0], -r1
    1cfc:	16689102 	strbtne	r9, [r8], -r2, lsl #2
    1d00:	000091c8 	andeq	r9, r0, r8, asr #3
    1d04:	00000080 	andeq	r0, r0, r0, lsl #1
    1d08:	00000392 	muleq	r0, r2, r3
    1d0c:	0100690d 	tsteq	r0, sp, lsl #18
    1d10:	00dd0e5b 	sbcseq	r0, sp, fp, asr lr
    1d14:	91020000 	mrsls	r0, (UNDEF: 2)
    1d18:	91e01264 	mvnls	r1, r4, ror #4
    1d1c:	00580000 	subseq	r0, r8, r0
    1d20:	ba110000 	blt	441d28 <__bss_end+0x438324>
    1d24:	01000012 	tsteq	r0, r2, lsl r0
    1d28:	00dd0d5d 	sbcseq	r0, sp, sp, asr sp
    1d2c:	91020000 	mrsls	r0, (UNDEF: 2)
    1d30:	1200005c 	andne	r0, r0, #92	; 0x5c
    1d34:	00009260 	andeq	r9, r0, r0, ror #4
    1d38:	00000070 	andeq	r0, r0, r0, ror r0
    1d3c:	646e650d 	strbtvs	r6, [lr], #-1293	; 0xfffffaf3
    1d40:	0f670100 	svceq	0x00670100
    1d44:	000000d1 	ldrdeq	r0, [r0], -r1
    1d48:	00609102 	rsbeq	r9, r0, r2, lsl #2
    1d4c:	04040800 	streq	r0, [r4], #-2048	; 0xfffff800
    1d50:	0000067d 	andeq	r0, r0, sp, ror r6
    1d54:	00006d05 	andeq	r6, r0, r5, lsl #26
    1d58:	0003c300 	andeq	ip, r3, r0, lsl #6
    1d5c:	00660600 	rsbeq	r0, r6, r0, lsl #12
    1d60:	000b0000 	andeq	r0, fp, r0
    1d64:	00125315 	andseq	r5, r2, r5, lsl r3
    1d68:	05240100 	streq	r0, [r4, #-256]!	; 0xffffff00
    1d6c:	00001312 	andeq	r1, r0, r2, lsl r3
    1d70:	000000dd 	ldrdeq	r0, [r0], -sp
    1d74:	00008fbc 			; <UNDEFINED> instruction: 0x00008fbc
    1d78:	0000009c 	muleq	r0, ip, r0
    1d7c:	04009c01 	streq	r9, [r0], #-3073	; 0xfffff3ff
    1d80:	6b0b0000 	blvs	2c1d88 <__bss_end+0x2b8384>
    1d84:	01000012 	tsteq	r0, r2, lsl r0
    1d88:	00d71624 	sbcseq	r1, r7, r4, lsr #12
    1d8c:	91020000 	mrsls	r0, (UNDEF: 2)
    1d90:	131d116c 	tstne	sp, #108, 2
    1d94:	26010000 	strcs	r0, [r1], -r0
    1d98:	0000dd06 	andeq	sp, r0, r6, lsl #26
    1d9c:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    1da0:	12761700 	rsbsne	r1, r6, #0, 14
    1da4:	08010000 	stmdaeq	r1, {}	; <UNPREDICTABLE>
    1da8:	00124706 	andseq	r4, r2, r6, lsl #14
    1dac:	008e4800 	addeq	r4, lr, r0, lsl #16
    1db0:	00017400 	andeq	r7, r1, r0, lsl #8
    1db4:	0b9c0100 	bleq	fe7021bc <__bss_end+0xfe6f87b8>
    1db8:	0000126b 	andeq	r1, r0, fp, ror #4
    1dbc:	66180801 	ldrvs	r0, [r8], -r1, lsl #16
    1dc0:	02000000 	andeq	r0, r0, #0
    1dc4:	1d0b6491 	cfstrsne	mvf6, [fp, #-580]	; 0xfffffdbc
    1dc8:	01000013 	tsteq	r0, r3, lsl r0
    1dcc:	00d12508 	sbcseq	r2, r1, r8, lsl #10
    1dd0:	91020000 	mrsls	r0, (UNDEF: 2)
    1dd4:	12710b60 	rsbsne	r0, r1, #96, 22	; 0x18000
    1dd8:	08010000 	stmdaeq	r1, {}	; <UNPREDICTABLE>
    1ddc:	0000663a 	andeq	r6, r0, sl, lsr r6
    1de0:	5c910200 	lfmpl	f0, 4, [r1], {0}
    1de4:	0100690d 	tsteq	r0, sp, lsl #18
    1de8:	00dd060a 	sbcseq	r0, sp, sl, lsl #12
    1dec:	91020000 	mrsls	r0, (UNDEF: 2)
    1df0:	8f141274 	svchi	0x00141274
    1df4:	00980000 	addseq	r0, r8, r0
    1df8:	6a0d0000 	bvs	341e00 <__bss_end+0x3383fc>
    1dfc:	0b1c0100 	bleq	702204 <__bss_end+0x6f8800>
    1e00:	000000dd 	ldrdeq	r0, [r0], -sp
    1e04:	12709102 	rsbsne	r9, r0, #-2147483648	; 0x80000000
    1e08:	00008f3c 	andeq	r8, r0, ip, lsr pc
    1e0c:	00000060 	andeq	r0, r0, r0, rrx
    1e10:	0100630d 	tsteq	r0, sp, lsl #6
    1e14:	006d081e 	rsbeq	r0, sp, lr, lsl r8
    1e18:	91020000 	mrsls	r0, (UNDEF: 2)
    1e1c:	0000006f 	andeq	r0, r0, pc, rrx
	...

Disassembly of section .debug_abbrev:

00000000 <.debug_abbrev>:
   0:	10001101 	andne	r1, r0, r1, lsl #2
   4:	12011106 	andne	r1, r1, #-2147483647	; 0x80000001
   8:	1b0e0301 	blne	380c14 <__bss_end+0x377210>
   c:	130e250e 	movwne	r2, #58638	; 0xe50e
  10:	00000005 	andeq	r0, r0, r5
  14:	25011101 	strcs	r1, [r1, #-257]	; 0xfffffeff
  18:	030b130e 	movweq	r1, #45838	; 0xb30e
  1c:	110e1b0e 	tstne	lr, lr, lsl #22
  20:	10061201 	andne	r1, r6, r1, lsl #4
  24:	02000017 	andeq	r0, r0, #23
  28:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
  2c:	0b3b0b3a 	bleq	ec2d1c <__bss_end+0xeb9318>
  30:	13490b39 	movtne	r0, #39737	; 0x9b39
  34:	193c193f 	ldmdbne	ip!, {r0, r1, r2, r3, r4, r5, r8, fp, ip}
  38:	24030000 	strcs	r0, [r3], #-0
  3c:	3e0b0b00 	vmlacc.f64	d0, d11, d0
  40:	000e030b 	andeq	r0, lr, fp, lsl #6
  44:	012e0400 			; <UNDEFINED> instruction: 0x012e0400
  48:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
  4c:	0b3b0b3a 	bleq	ec2d3c <__bss_end+0xeb9338>
  50:	01110b39 	tsteq	r1, r9, lsr fp
  54:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
  58:	01194296 			; <UNDEFINED> instruction: 0x01194296
  5c:	05000013 	streq	r0, [r0, #-19]	; 0xffffffed
  60:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
  64:	0b3b0b3a 	bleq	ec2d54 <__bss_end+0xeb9350>
  68:	13490b39 	movtne	r0, #39737	; 0x9b39
  6c:	00001802 	andeq	r1, r0, r2, lsl #16
  70:	0b002406 	bleq	9090 <_Z4ftoafPcj+0x38>
  74:	030b3e0b 	movweq	r3, #48651	; 0xbe0b
  78:	07000008 	streq	r0, [r0, -r8]
  7c:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
  80:	0b3a0e03 	bleq	e83894 <__bss_end+0xe79e90>
  84:	0b390b3b 	bleq	e42d78 <__bss_end+0xe39374>
  88:	06120111 			; <UNDEFINED> instruction: 0x06120111
  8c:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
  90:	00130119 	andseq	r0, r3, r9, lsl r1
  94:	010b0800 	tsteq	fp, r0, lsl #16
  98:	06120111 			; <UNDEFINED> instruction: 0x06120111
  9c:	34090000 	strcc	r0, [r9], #-0
  a0:	3a080300 	bcc	200ca8 <__bss_end+0x1f72a4>
  a4:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
  a8:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
  ac:	0a000018 	beq	114 <shift+0x114>
  b0:	0b0b000f 	bleq	2c00f4 <__bss_end+0x2b66f0>
  b4:	00001349 	andeq	r1, r0, r9, asr #6
  b8:	01110100 	tsteq	r1, r0, lsl #2
  bc:	0b130e25 	bleq	4c3958 <__bss_end+0x4b9f54>
  c0:	0e1b0e03 	cdpeq	14, 1, cr0, cr11, cr3, {0}
  c4:	06120111 			; <UNDEFINED> instruction: 0x06120111
  c8:	00001710 	andeq	r1, r0, r0, lsl r7
  cc:	03001602 	movweq	r1, #1538	; 0x602
  d0:	3b0b3a0e 	blcc	2ce910 <__bss_end+0x2c4f0c>
  d4:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
  d8:	03000013 	movweq	r0, #19
  dc:	0b0b000f 	bleq	2c0120 <__bss_end+0x2b671c>
  e0:	00001349 	andeq	r1, r0, r9, asr #6
  e4:	00001504 	andeq	r1, r0, r4, lsl #10
  e8:	01010500 	tsteq	r1, r0, lsl #10
  ec:	13011349 	movwne	r1, #4937	; 0x1349
  f0:	21060000 	mrscs	r0, (UNDEF: 6)
  f4:	2f134900 	svccs	0x00134900
  f8:	07000006 	streq	r0, [r0, -r6]
  fc:	0b0b0024 	bleq	2c0194 <__bss_end+0x2b6790>
 100:	0e030b3e 	vmoveq.16	d3[0], r0
 104:	34080000 	strcc	r0, [r8], #-0
 108:	3a0e0300 	bcc	380d10 <__bss_end+0x37730c>
 10c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 110:	3f13490b 	svccc	0x0013490b
 114:	00193c19 	andseq	r3, r9, r9, lsl ip
 118:	012e0900 			; <UNDEFINED> instruction: 0x012e0900
 11c:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 120:	0b3b0b3a 	bleq	ec2e10 <__bss_end+0xeb940c>
 124:	13490b39 	movtne	r0, #39737	; 0x9b39
 128:	06120111 			; <UNDEFINED> instruction: 0x06120111
 12c:	42961840 	addsmi	r1, r6, #64, 16	; 0x400000
 130:	00130119 	andseq	r0, r3, r9, lsl r1
 134:	00340a00 	eorseq	r0, r4, r0, lsl #20
 138:	0b3a0e03 	bleq	e8394c <__bss_end+0xe79f48>
 13c:	0b390b3b 	bleq	e42e30 <__bss_end+0xe3942c>
 140:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 144:	240b0000 	strcs	r0, [fp], #-0
 148:	3e0b0b00 	vmlacc.f64	d0, d11, d0
 14c:	0008030b 	andeq	r0, r8, fp, lsl #6
 150:	002e0c00 	eoreq	r0, lr, r0, lsl #24
 154:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 158:	0b3b0b3a 	bleq	ec2e48 <__bss_end+0xeb9444>
 15c:	01110b39 	tsteq	r1, r9, lsr fp
 160:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 164:	00194297 	mulseq	r9, r7, r2
 168:	01390d00 	teqeq	r9, r0, lsl #26
 16c:	0b3a0e03 	bleq	e83980 <__bss_end+0xe79f7c>
 170:	13010b3b 	movwne	r0, #6971	; 0x1b3b
 174:	2e0e0000 	cdpcs	0, 0, cr0, cr14, cr0, {0}
 178:	03193f01 	tsteq	r9, #1, 30
 17c:	3b0b3a0e 	blcc	2ce9bc <__bss_end+0x2c4fb8>
 180:	3c0b390b 			; <UNDEFINED> instruction: 0x3c0b390b
 184:	00130119 	andseq	r0, r3, r9, lsl r1
 188:	00050f00 	andeq	r0, r5, r0, lsl #30
 18c:	00001349 	andeq	r1, r0, r9, asr #6
 190:	3f012e10 	svccc	0x00012e10
 194:	3a0e0319 	bcc	380e00 <__bss_end+0x3773fc>
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
 1c0:	3a080300 	bcc	200dc8 <__bss_end+0x1f73c4>
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
 1f4:	0b0b0024 	bleq	2c028c <__bss_end+0x2b6888>
 1f8:	0e030b3e 	vmoveq.16	d3[0], r0
 1fc:	26030000 	strcs	r0, [r3], -r0
 200:	00134900 	andseq	r4, r3, r0, lsl #18
 204:	00240400 	eoreq	r0, r4, r0, lsl #8
 208:	0b3e0b0b 	bleq	f82e3c <__bss_end+0xf79438>
 20c:	00000803 	andeq	r0, r0, r3, lsl #16
 210:	03001605 	movweq	r1, #1541	; 0x605
 214:	3b0b3a0e 	blcc	2cea54 <__bss_end+0x2c5050>
 218:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 21c:	06000013 			; <UNDEFINED> instruction: 0x06000013
 220:	0e030113 	mcreq	1, 0, r0, cr3, cr3, {0}
 224:	0b3a0b0b 	bleq	e82e58 <__bss_end+0xe79454>
 228:	0b390b3b 	bleq	e42f1c <__bss_end+0xe39518>
 22c:	00001301 	andeq	r1, r0, r1, lsl #6
 230:	03000d07 	movweq	r0, #3335	; 0xd07
 234:	3b0b3a08 	blcc	2cea5c <__bss_end+0x2c5058>
 238:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 23c:	000b3813 	andeq	r3, fp, r3, lsl r8
 240:	01040800 	tsteq	r4, r0, lsl #16
 244:	196d0e03 	stmdbne	sp!, {r0, r1, r9, sl, fp}^
 248:	0b0b0b3e 	bleq	2c2f48 <__bss_end+0x2b9544>
 24c:	0b3a1349 	bleq	e84f78 <__bss_end+0xe7b574>
 250:	0b390b3b 	bleq	e42f44 <__bss_end+0xe39540>
 254:	00001301 	andeq	r1, r0, r1, lsl #6
 258:	03002809 	movweq	r2, #2057	; 0x809
 25c:	000b1c0e 	andeq	r1, fp, lr, lsl #24
 260:	00340a00 	eorseq	r0, r4, r0, lsl #20
 264:	0b3a0e03 	bleq	e83a78 <__bss_end+0xe7a074>
 268:	0b390b3b 	bleq	e42f5c <__bss_end+0xe39558>
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
 294:	0b3b0b3a 	bleq	ec2f84 <__bss_end+0xeb9580>
 298:	13490b39 	movtne	r0, #39737	; 0x9b39
 29c:	00000b38 	andeq	r0, r0, r8, lsr fp
 2a0:	4901010f 	stmdbmi	r1, {r0, r1, r2, r3, r8}
 2a4:	00130113 	andseq	r0, r3, r3, lsl r1
 2a8:	00211000 	eoreq	r1, r1, r0
 2ac:	0b2f1349 	bleq	bc4fd8 <__bss_end+0xbbb5d4>
 2b0:	02110000 	andseq	r0, r1, #0
 2b4:	0b0e0301 	bleq	380ec0 <__bss_end+0x3774bc>
 2b8:	3b0b3a0b 	blcc	2ceaec <__bss_end+0x2c50e8>
 2bc:	010b390b 	tsteq	fp, fp, lsl #18
 2c0:	12000013 	andne	r0, r0, #19
 2c4:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 2c8:	0b3a0e03 	bleq	e83adc <__bss_end+0xe7a0d8>
 2cc:	0b390b3b 	bleq	e42fc0 <__bss_end+0xe395bc>
 2d0:	193c0e6e 	ldmdbne	ip!, {r1, r2, r3, r5, r6, r9, sl, fp}
 2d4:	13011364 	movwne	r1, #4964	; 0x1364
 2d8:	05130000 	ldreq	r0, [r3, #-0]
 2dc:	34134900 	ldrcc	r4, [r3], #-2304	; 0xfffff700
 2e0:	14000019 	strne	r0, [r0], #-25	; 0xffffffe7
 2e4:	13490005 	movtne	r0, #36869	; 0x9005
 2e8:	2e150000 	cdpcs	0, 1, cr0, cr5, cr0, {0}
 2ec:	03193f01 	tsteq	r9, #1, 30
 2f0:	3b0b3a0e 	blcc	2ceb30 <__bss_end+0x2c512c>
 2f4:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 2f8:	3c13490e 			; <UNDEFINED> instruction: 0x3c13490e
 2fc:	01136419 	tsteq	r3, r9, lsl r4
 300:	16000013 			; <UNDEFINED> instruction: 0x16000013
 304:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 308:	0b3a0e03 	bleq	e83b1c <__bss_end+0xe7a118>
 30c:	0b390b3b 	bleq	e43000 <__bss_end+0xe395fc>
 310:	13490e6e 	movtne	r0, #40558	; 0x9e6e
 314:	193c0b32 	ldmdbne	ip!, {r1, r4, r5, r8, r9, fp}
 318:	13011364 	movwne	r1, #4964	; 0x1364
 31c:	0d170000 	ldceq	0, cr0, [r7, #-0]
 320:	3a0e0300 	bcc	380f28 <__bss_end+0x377524>
 324:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 328:	3813490b 	ldmdacc	r3, {r0, r1, r3, r8, fp, lr}
 32c:	000b320b 	andeq	r3, fp, fp, lsl #4
 330:	012e1800 			; <UNDEFINED> instruction: 0x012e1800
 334:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 338:	0b3b0b3a 	bleq	ec3028 <__bss_end+0xeb9624>
 33c:	0e6e0b39 	vmoveq.8	d14[5], r0
 340:	193c0b32 	ldmdbne	ip!, {r1, r4, r5, r8, r9, fp}
 344:	13011364 	movwne	r1, #4964	; 0x1364
 348:	2e190000 	cdpcs	0, 1, cr0, cr9, cr0, {0}
 34c:	03193f01 	tsteq	r9, #1, 30
 350:	3b0b3a0e 	blcc	2ceb90 <__bss_end+0x2c518c>
 354:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 358:	3213490e 	andscc	r4, r3, #229376	; 0x38000
 35c:	64193c0b 	ldrvs	r3, [r9], #-3083	; 0xfffff3f5
 360:	1a000013 	bne	3b4 <shift+0x3b4>
 364:	13490115 	movtne	r0, #37141	; 0x9115
 368:	13011364 	movwne	r1, #4964	; 0x1364
 36c:	1f1b0000 	svcne	0x001b0000
 370:	49131d00 	ldmdbmi	r3, {r8, sl, fp, ip}
 374:	1c000013 	stcne	0, cr0, [r0], {19}
 378:	0b0b0010 	bleq	2c03c0 <__bss_end+0x2b69bc>
 37c:	00001349 	andeq	r1, r0, r9, asr #6
 380:	0b000f1d 	bleq	3ffc <shift+0x3ffc>
 384:	1e00000b 	cdpne	0, 0, cr0, cr0, cr11, {0}
 388:	08030139 	stmdaeq	r3, {r0, r3, r4, r5, r8}
 38c:	0b3b0b3a 	bleq	ec307c <__bss_end+0xeb9678>
 390:	13010b39 	movwne	r0, #6969	; 0x1b39
 394:	341f0000 	ldrcc	r0, [pc], #-0	; 39c <shift+0x39c>
 398:	3a0e0300 	bcc	380fa0 <__bss_end+0x37759c>
 39c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 3a0:	3c13490b 			; <UNDEFINED> instruction: 0x3c13490b
 3a4:	6c061c19 	stcvs	12, cr1, [r6], {25}
 3a8:	20000019 	andcs	r0, r0, r9, lsl r0
 3ac:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 3b0:	0b3b0b3a 	bleq	ec30a0 <__bss_end+0xeb969c>
 3b4:	13490b39 	movtne	r0, #39737	; 0x9b39
 3b8:	0b1c193c 	bleq	7068b0 <__bss_end+0x6fceac>
 3bc:	0000196c 	andeq	r1, r0, ip, ror #18
 3c0:	47003421 	strmi	r3, [r0, -r1, lsr #8]
 3c4:	22000013 	andcs	r0, r0, #19
 3c8:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 3cc:	0b3b0b3a 	bleq	ec30bc <__bss_end+0xeb96b8>
 3d0:	13490b39 	movtne	r0, #39737	; 0x9b39
 3d4:	1802193f 	stmdane	r2, {r0, r1, r2, r3, r4, r5, r8, fp, ip}
 3d8:	34230000 	strtcc	r0, [r3], #-0
 3dc:	3a0e0300 	bcc	380fe4 <__bss_end+0x3775e0>
 3e0:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 3e4:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 3e8:	24000018 	strcs	r0, [r0], #-24	; 0xffffffe8
 3ec:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 3f0:	0b3a0e03 	bleq	e83c04 <__bss_end+0xe7a200>
 3f4:	0b390b3b 	bleq	e430e8 <__bss_end+0xe396e4>
 3f8:	01111349 	tsteq	r1, r9, asr #6
 3fc:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 400:	01194296 			; <UNDEFINED> instruction: 0x01194296
 404:	25000013 	strcs	r0, [r0, #-19]	; 0xffffffed
 408:	0e030005 	cdpeq	0, 0, cr0, cr3, cr5, {0}
 40c:	0b3b0b3a 	bleq	ec30fc <__bss_end+0xeb96f8>
 410:	13490b39 	movtne	r0, #39737	; 0x9b39
 414:	00001802 	andeq	r1, r0, r2, lsl #16
 418:	3f012e26 	svccc	0x00012e26
 41c:	3a0e0319 	bcc	381088 <__bss_end+0x377684>
 420:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 424:	490e6e0b 	stmdbmi	lr, {r0, r1, r3, r9, sl, fp, sp, lr}
 428:	12011113 	andne	r1, r1, #-1073741820	; 0xc0000004
 42c:	96184006 	ldrls	r4, [r8], -r6
 430:	13011942 	movwne	r1, #6466	; 0x1942
 434:	2e270000 	cdpcs	0, 2, cr0, cr7, cr0, {0}
 438:	03193f01 	tsteq	r9, #1, 30
 43c:	3b0b3a0e 	blcc	2cec7c <__bss_end+0x2c5278>
 440:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 444:	1201110e 	andne	r1, r1, #-2147483645	; 0x80000003
 448:	96184006 	ldrls	r4, [r8], -r6
 44c:	13011942 	movwne	r1, #6466	; 0x1942
 450:	34280000 	strtcc	r0, [r8], #-0
 454:	3a080300 	bcc	20105c <__bss_end+0x1f7658>
 458:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 45c:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 460:	29000018 	stmdbcs	r0, {r3, r4}
 464:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 468:	0b3a0803 	bleq	e8247c <__bss_end+0xe78a78>
 46c:	0b390b3b 	bleq	e43160 <__bss_end+0xe3975c>
 470:	01110e6e 	tsteq	r1, lr, ror #28
 474:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 478:	01194296 			; <UNDEFINED> instruction: 0x01194296
 47c:	2a000013 	bcs	4d0 <shift+0x4d0>
 480:	08030005 	stmdaeq	r3, {r0, r2}
 484:	0b3b0b3a 	bleq	ec3174 <__bss_end+0xeb9770>
 488:	13490b39 	movtne	r0, #39737	; 0x9b39
 48c:	00001802 	andeq	r1, r0, r2, lsl #16
 490:	4900212b 	stmdbmi	r0, {r0, r1, r3, r5, r8, sp}
 494:	00182f13 	andseq	r2, r8, r3, lsl pc
 498:	012e2c00 			; <UNDEFINED> instruction: 0x012e2c00
 49c:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 4a0:	0b3b0b3a 	bleq	ec3190 <__bss_end+0xeb978c>
 4a4:	0e6e0b39 	vmoveq.8	d14[5], r0
 4a8:	06120111 			; <UNDEFINED> instruction: 0x06120111
 4ac:	42961840 	addsmi	r1, r6, #64, 16	; 0x400000
 4b0:	00000019 	andeq	r0, r0, r9, lsl r0
 4b4:	25011101 	strcs	r1, [r1, #-257]	; 0xfffffeff
 4b8:	030b130e 	movweq	r1, #45838	; 0xb30e
 4bc:	110e1b0e 	tstne	lr, lr, lsl #22
 4c0:	10061201 	andne	r1, r6, r1, lsl #4
 4c4:	02000017 	andeq	r0, r0, #23
 4c8:	0b0b0024 	bleq	2c0560 <__bss_end+0x2b6b5c>
 4cc:	0e030b3e 	vmoveq.16	d3[0], r0
 4d0:	26030000 	strcs	r0, [r3], -r0
 4d4:	00134900 	andseq	r4, r3, r0, lsl #18
 4d8:	00240400 	eoreq	r0, r4, r0, lsl #8
 4dc:	0b3e0b0b 	bleq	f83110 <__bss_end+0xf7970c>
 4e0:	00000803 	andeq	r0, r0, r3, lsl #16
 4e4:	03001605 	movweq	r1, #1541	; 0x605
 4e8:	3b0b3a0e 	blcc	2ced28 <__bss_end+0x2c5324>
 4ec:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 4f0:	06000013 			; <UNDEFINED> instruction: 0x06000013
 4f4:	0e030113 	mcreq	1, 0, r0, cr3, cr3, {0}
 4f8:	0b3a0b0b 	bleq	e8312c <__bss_end+0xe79728>
 4fc:	0b390b3b 	bleq	e431f0 <__bss_end+0xe397ec>
 500:	00001301 	andeq	r1, r0, r1, lsl #6
 504:	03000d07 	movweq	r0, #3335	; 0xd07
 508:	3b0b3a08 	blcc	2ced30 <__bss_end+0x2c532c>
 50c:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 510:	000b3813 	andeq	r3, fp, r3, lsl r8
 514:	01040800 	tsteq	r4, r0, lsl #16
 518:	196d0e03 	stmdbne	sp!, {r0, r1, r9, sl, fp}^
 51c:	0b0b0b3e 	bleq	2c321c <__bss_end+0x2b9818>
 520:	0b3a1349 	bleq	e8524c <__bss_end+0xe7b848>
 524:	0b390b3b 	bleq	e43218 <__bss_end+0xe39814>
 528:	00001301 	andeq	r1, r0, r1, lsl #6
 52c:	03002809 	movweq	r2, #2057	; 0x809
 530:	000b1c08 	andeq	r1, fp, r8, lsl #24
 534:	00280a00 	eoreq	r0, r8, r0, lsl #20
 538:	0b1c0e03 	bleq	703d4c <__bss_end+0x6fa348>
 53c:	340b0000 	strcc	r0, [fp], #-0
 540:	3a0e0300 	bcc	381148 <__bss_end+0x377744>
 544:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 548:	6c13490b 			; <UNDEFINED> instruction: 0x6c13490b
 54c:	00180219 	andseq	r0, r8, r9, lsl r2
 550:	00020c00 	andeq	r0, r2, r0, lsl #24
 554:	193c0e03 	ldmdbne	ip!, {r0, r1, r9, sl, fp}
 558:	0f0d0000 	svceq	0x000d0000
 55c:	490b0b00 	stmdbmi	fp, {r8, r9, fp}
 560:	0e000013 	mcreq	0, 0, r0, cr0, cr3, {0}
 564:	0e03000d 	cdpeq	0, 0, cr0, cr3, cr13, {0}
 568:	0b3b0b3a 	bleq	ec3258 <__bss_end+0xeb9854>
 56c:	13490b39 	movtne	r0, #39737	; 0x9b39
 570:	00000b38 	andeq	r0, r0, r8, lsr fp
 574:	4901010f 	stmdbmi	r1, {r0, r1, r2, r3, r8}
 578:	00130113 	andseq	r0, r3, r3, lsl r1
 57c:	00211000 	eoreq	r1, r1, r0
 580:	0b2f1349 	bleq	bc52ac <__bss_end+0xbbb8a8>
 584:	02110000 	andseq	r0, r1, #0
 588:	0b0e0301 	bleq	381194 <__bss_end+0x377790>
 58c:	3b0b3a0b 	blcc	2cedc0 <__bss_end+0x2c53bc>
 590:	010b390b 	tsteq	fp, fp, lsl #18
 594:	12000013 	andne	r0, r0, #19
 598:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 59c:	0b3a0e03 	bleq	e83db0 <__bss_end+0xe7a3ac>
 5a0:	0b390b3b 	bleq	e43294 <__bss_end+0xe39890>
 5a4:	193c0e6e 	ldmdbne	ip!, {r1, r2, r3, r5, r6, r9, sl, fp}
 5a8:	13011364 	movwne	r1, #4964	; 0x1364
 5ac:	05130000 	ldreq	r0, [r3, #-0]
 5b0:	34134900 	ldrcc	r4, [r3], #-2304	; 0xfffff700
 5b4:	14000019 	strne	r0, [r0], #-25	; 0xffffffe7
 5b8:	13490005 	movtne	r0, #36869	; 0x9005
 5bc:	2e150000 	cdpcs	0, 1, cr0, cr5, cr0, {0}
 5c0:	03193f01 	tsteq	r9, #1, 30
 5c4:	3b0b3a0e 	blcc	2cee04 <__bss_end+0x2c5400>
 5c8:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 5cc:	3c13490e 			; <UNDEFINED> instruction: 0x3c13490e
 5d0:	01136419 	tsteq	r3, r9, lsl r4
 5d4:	16000013 			; <UNDEFINED> instruction: 0x16000013
 5d8:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 5dc:	0b3a0e03 	bleq	e83df0 <__bss_end+0xe7a3ec>
 5e0:	0b390b3b 	bleq	e432d4 <__bss_end+0xe398d0>
 5e4:	13490e6e 	movtne	r0, #40558	; 0x9e6e
 5e8:	193c0b32 	ldmdbne	ip!, {r1, r4, r5, r8, r9, fp}
 5ec:	13011364 	movwne	r1, #4964	; 0x1364
 5f0:	0d170000 	ldceq	0, cr0, [r7, #-0]
 5f4:	3a0e0300 	bcc	3811fc <__bss_end+0x3777f8>
 5f8:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 5fc:	3813490b 	ldmdacc	r3, {r0, r1, r3, r8, fp, lr}
 600:	000b320b 	andeq	r3, fp, fp, lsl #4
 604:	012e1800 			; <UNDEFINED> instruction: 0x012e1800
 608:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 60c:	0b3b0b3a 	bleq	ec32fc <__bss_end+0xeb98f8>
 610:	0e6e0b39 	vmoveq.8	d14[5], r0
 614:	193c0b32 	ldmdbne	ip!, {r1, r4, r5, r8, r9, fp}
 618:	13011364 	movwne	r1, #4964	; 0x1364
 61c:	2e190000 	cdpcs	0, 1, cr0, cr9, cr0, {0}
 620:	03193f01 	tsteq	r9, #1, 30
 624:	3b0b3a0e 	blcc	2cee64 <__bss_end+0x2c5460>
 628:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 62c:	3213490e 	andscc	r4, r3, #229376	; 0x38000
 630:	64193c0b 	ldrvs	r3, [r9], #-3083	; 0xfffff3f5
 634:	1a000013 	bne	688 <shift+0x688>
 638:	13490115 	movtne	r0, #37141	; 0x9115
 63c:	13011364 	movwne	r1, #4964	; 0x1364
 640:	1f1b0000 	svcne	0x001b0000
 644:	49131d00 	ldmdbmi	r3, {r8, sl, fp, ip}
 648:	1c000013 	stcne	0, cr0, [r0], {19}
 64c:	0b0b0010 	bleq	2c0694 <__bss_end+0x2b6c90>
 650:	00001349 	andeq	r1, r0, r9, asr #6
 654:	0b000f1d 	bleq	42d0 <shift+0x42d0>
 658:	1e00000b 	cdpne	0, 0, cr0, cr0, cr11, {0}
 65c:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 660:	0b3b0b3a 	bleq	ec3350 <__bss_end+0xeb994c>
 664:	13490b39 	movtne	r0, #39737	; 0x9b39
 668:	00001802 	andeq	r1, r0, r2, lsl #16
 66c:	3f012e1f 	svccc	0x00012e1f
 670:	3a0e0319 	bcc	3812dc <__bss_end+0x3778d8>
 674:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 678:	490e6e0b 	stmdbmi	lr, {r0, r1, r3, r9, sl, fp, sp, lr}
 67c:	12011113 	andne	r1, r1, #-1073741820	; 0xc0000004
 680:	96184006 	ldrls	r4, [r8], -r6
 684:	13011942 	movwne	r1, #6466	; 0x1942
 688:	05200000 	streq	r0, [r0, #-0]!
 68c:	3a0e0300 	bcc	381294 <__bss_end+0x377890>
 690:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 694:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 698:	21000018 	tstcs	r0, r8, lsl r0
 69c:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 6a0:	0b3a0e03 	bleq	e83eb4 <__bss_end+0xe7a4b0>
 6a4:	0b390b3b 	bleq	e43398 <__bss_end+0xe39994>
 6a8:	13490e6e 	movtne	r0, #40558	; 0x9e6e
 6ac:	06120111 			; <UNDEFINED> instruction: 0x06120111
 6b0:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
 6b4:	00130119 	andseq	r0, r3, r9, lsl r1
 6b8:	00342200 	eorseq	r2, r4, r0, lsl #4
 6bc:	0b3a0803 	bleq	e826d0 <__bss_end+0xe78ccc>
 6c0:	0b390b3b 	bleq	e433b4 <__bss_end+0xe399b0>
 6c4:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 6c8:	2e230000 	cdpcs	0, 2, cr0, cr3, cr0, {0}
 6cc:	03193f01 	tsteq	r9, #1, 30
 6d0:	3b0b3a0e 	blcc	2cef10 <__bss_end+0x2c550c>
 6d4:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 6d8:	1201110e 	andne	r1, r1, #-2147483645	; 0x80000003
 6dc:	97184006 	ldrls	r4, [r8, -r6]
 6e0:	13011942 	movwne	r1, #6466	; 0x1942
 6e4:	2e240000 	cdpcs	0, 2, cr0, cr4, cr0, {0}
 6e8:	03193f00 	tsteq	r9, #0, 30
 6ec:	3b0b3a0e 	blcc	2cef2c <__bss_end+0x2c5528>
 6f0:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 6f4:	1201110e 	andne	r1, r1, #-2147483645	; 0x80000003
 6f8:	97184006 	ldrls	r4, [r8, -r6]
 6fc:	00001942 	andeq	r1, r0, r2, asr #18
 700:	3f012e25 	svccc	0x00012e25
 704:	3a0e0319 	bcc	381370 <__bss_end+0x37796c>
 708:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 70c:	490e6e0b 	stmdbmi	lr, {r0, r1, r3, r9, sl, fp, sp, lr}
 710:	12011113 	andne	r1, r1, #-1073741820	; 0xc0000004
 714:	97184006 	ldrls	r4, [r8, -r6]
 718:	00001942 	andeq	r1, r0, r2, asr #18
 71c:	01110100 	tsteq	r1, r0, lsl #2
 720:	0b130e25 	bleq	4c3fbc <__bss_end+0x4ba5b8>
 724:	0e1b0e03 	cdpeq	14, 1, cr0, cr11, cr3, {0}
 728:	06120111 			; <UNDEFINED> instruction: 0x06120111
 72c:	00001710 	andeq	r1, r0, r0, lsl r7
 730:	01013902 	tsteq	r1, r2, lsl #18
 734:	03000013 	movweq	r0, #19
 738:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 73c:	0b3b0b3a 	bleq	ec342c <__bss_end+0xeb9a28>
 740:	13490b39 	movtne	r0, #39737	; 0x9b39
 744:	0a1c193c 	beq	706c3c <__bss_end+0x6fd238>
 748:	3a040000 	bcc	100750 <__bss_end+0xf6d4c>
 74c:	3b0b3a00 	blcc	2cef54 <__bss_end+0x2c5550>
 750:	180b390b 	stmdane	fp, {r0, r1, r3, r8, fp, ip, sp}
 754:	05000013 	streq	r0, [r0, #-19]	; 0xffffffed
 758:	13490101 	movtne	r0, #37121	; 0x9101
 75c:	00001301 	andeq	r1, r0, r1, lsl #6
 760:	49002106 	stmdbmi	r0, {r1, r2, r8, sp}
 764:	000b2f13 	andeq	r2, fp, r3, lsl pc
 768:	00260700 	eoreq	r0, r6, r0, lsl #14
 76c:	00001349 	andeq	r1, r0, r9, asr #6
 770:	0b002408 	bleq	9798 <__udivsi3+0x190>
 774:	030b3e0b 	movweq	r3, #48651	; 0xbe0b
 778:	0900000e 	stmdbeq	r0, {r1, r2, r3}
 77c:	13470034 	movtne	r0, #28724	; 0x7034
 780:	2e0a0000 	cdpcs	0, 0, cr0, cr10, cr0, {0}
 784:	03193f01 	tsteq	r9, #1, 30
 788:	3b0b3a0e 	blcc	2cefc8 <__bss_end+0x2c55c4>
 78c:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 790:	1201110e 	andne	r1, r1, #-2147483645	; 0x80000003
 794:	96184006 	ldrls	r4, [r8], -r6
 798:	13011942 	movwne	r1, #6466	; 0x1942
 79c:	050b0000 	streq	r0, [fp, #-0]
 7a0:	3a0e0300 	bcc	3813a8 <__bss_end+0x3779a4>
 7a4:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 7a8:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 7ac:	0c000018 	stceq	0, cr0, [r0], {24}
 7b0:	08030005 	stmdaeq	r3, {r0, r2}
 7b4:	0b3b0b3a 	bleq	ec34a4 <__bss_end+0xeb9aa0>
 7b8:	13490b39 	movtne	r0, #39737	; 0x9b39
 7bc:	00001802 	andeq	r1, r0, r2, lsl #16
 7c0:	0300340d 	movweq	r3, #1037	; 0x40d
 7c4:	3b0b3a08 	blcc	2cefec <__bss_end+0x2c55e8>
 7c8:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 7cc:	00180213 	andseq	r0, r8, r3, lsl r2
 7d0:	000f0e00 	andeq	r0, pc, r0, lsl #28
 7d4:	13490b0b 	movtne	r0, #39691	; 0x9b0b
 7d8:	240f0000 	strcs	r0, [pc], #-0	; 7e0 <shift+0x7e0>
 7dc:	3e0b0b00 	vmlacc.f64	d0, d11, d0
 7e0:	0008030b 	andeq	r0, r8, fp, lsl #6
 7e4:	012e1000 			; <UNDEFINED> instruction: 0x012e1000
 7e8:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 7ec:	0b3b0b3a 	bleq	ec34dc <__bss_end+0xeb9ad8>
 7f0:	0e6e0b39 	vmoveq.8	d14[5], r0
 7f4:	06120111 			; <UNDEFINED> instruction: 0x06120111
 7f8:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
 7fc:	00130119 	andseq	r0, r3, r9, lsl r1
 800:	00341100 	eorseq	r1, r4, r0, lsl #2
 804:	0b3a0e03 	bleq	e84018 <__bss_end+0xe7a614>
 808:	0b390b3b 	bleq	e434fc <__bss_end+0xe39af8>
 80c:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 810:	0b120000 	bleq	480818 <__bss_end+0x476e14>
 814:	12011101 	andne	r1, r1, #1073741824	; 0x40000000
 818:	13000006 	movwne	r0, #6
 81c:	00000026 	andeq	r0, r0, r6, lsr #32
 820:	0b000f14 	bleq	4478 <shift+0x4478>
 824:	1500000b 	strne	r0, [r0, #-11]
 828:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 82c:	0b3a0e03 	bleq	e84040 <__bss_end+0xe7a63c>
 830:	0b390b3b 	bleq	e43524 <__bss_end+0xe39b20>
 834:	13490e6e 	movtne	r0, #40558	; 0x9e6e
 838:	06120111 			; <UNDEFINED> instruction: 0x06120111
 83c:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
 840:	00130119 	andseq	r0, r3, r9, lsl r1
 844:	010b1600 	tsteq	fp, r0, lsl #12
 848:	06120111 			; <UNDEFINED> instruction: 0x06120111
 84c:	00001301 	andeq	r1, r0, r1, lsl #6
 850:	3f012e17 	svccc	0x00012e17
 854:	3a0e0319 	bcc	3814c0 <__bss_end+0x377abc>
 858:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 85c:	110e6e0b 	tstne	lr, fp, lsl #28
 860:	40061201 	andmi	r1, r6, r1, lsl #4
 864:	19429618 	stmdbne	r2, {r3, r4, r9, sl, ip, pc}^
 868:	Address 0x0000000000000868 is out of bounds.


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
  74:	000007c0 	andeq	r0, r0, r0, asr #15
	...
  80:	0000001c 	andeq	r0, r0, ip, lsl r0
  84:	0e7e0002 	cdpeq	0, 7, cr0, cr14, cr2, {0}
  88:	00040000 	andeq	r0, r4, r0
  8c:	00000000 	andeq	r0, r0, r0
  90:	000089ec 	andeq	r8, r0, ip, ror #19
  94:	0000045c 	andeq	r0, r0, ip, asr r4
	...
  a0:	0000001c 	andeq	r0, r0, ip, lsl r0
  a4:	19a10002 	stmibne	r1!, {r1}
  a8:	00040000 	andeq	r0, r4, r0
  ac:	00000000 	andeq	r0, r0, r0
  b0:	00008e48 	andeq	r8, r0, r8, asr #28
  b4:	000007c0 	andeq	r0, r0, r0, asr #15
	...

Disassembly of section .debug_str:

00000000 <.debug_str>:
       0:	6573552f 	ldrbvs	r5, [r3, #-1327]!	; 0xfffffad1
       4:	772f7372 			; <UNDEFINED> instruction: 0x772f7372
       8:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
       c:	2f696a72 	svccs	0x00696a72
      10:	6b736544 	blvs	1cd9528 <__bss_end+0x1ccfb24>
      14:	2f706f74 	svccs	0x00706f74
      18:	2f564146 	svccs	0x00564146
      1c:	6176614e 	cmnvs	r6, lr, asr #2
      20:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
      24:	4f2f6963 	svcmi	0x002f6963
      28:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
      2c:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
      30:	6b6c6172 	blvs	1b18600 <__bss_end+0x1b0ebfc>
      34:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
      38:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
      3c:	756f732f 	strbvc	r7, [pc, #-815]!	; fffffd15 <__bss_end+0xffff6311>
      40:	73656372 	cmnvc	r5, #-939524095	; 0xc8000001
      44:	6573752f 	ldrbvs	r7, [r3, #-1327]!	; 0xfffffad1
      48:	61707372 	cmnvs	r0, r2, ror r3
      4c:	632f6563 			; <UNDEFINED> instruction: 0x632f6563
      50:	2e307472 	mrccs	4, 1, r7, cr0, cr2, {3}
      54:	552f0073 	strpl	r0, [pc, #-115]!	; ffffffe9 <__bss_end+0xffff65e5>
      58:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
      5c:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
      60:	6a726574 	bvs	1c99638 <__bss_end+0x1c8fc34>
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
      98:	752f7365 	strvc	r7, [pc, #-869]!	; fffffd3b <__bss_end+0xffff6337>
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
     12c:	6a363731 	bvs	d8ddf8 <__bss_end+0xd843f4>
     130:	732d667a 			; <UNDEFINED> instruction: 0x732d667a
     134:	616d2d20 	cmnvs	sp, r0, lsr #26
     138:	2d206d72 	stccs	13, cr6, [r0, #-456]!	; 0xfffffe38
     13c:	6372616d 	cmnvs	r2, #1073741851	; 0x4000001b
     140:	72613d68 	rsbvc	r3, r1, #104, 26	; 0x1a00
     144:	7a36766d 	bvc	d9db00 <__bss_end+0xd940fc>
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
     184:	6a757a61 	bvs	1d5eb10 <__bss_end+0x1d5510c>
     188:	2f696369 	svccs	0x00696369
     18c:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
     190:	73656d65 	cmnvc	r5, #6464	; 0x1940
     194:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
     198:	6b2d616b 	blvs	b5874c <__bss_end+0xb4ed48>
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
     1e4:	2b2b4320 	blcs	ad0e6c <__bss_end+0xac7468>
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
     260:	2b6b7a36 	blcs	1adeb40 <__bss_end+0x1ad513c>
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
     294:	755f6962 	ldrbvc	r6, [pc, #-2402]	; fffff93a <__bss_end+0xffff5f36>
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
     324:	6b736544 	blvs	1cd983c <__bss_end+0x1ccfe38>
     328:	2f706f74 	svccs	0x00706f74
     32c:	2f564146 	svccs	0x00564146
     330:	6176614e 	cmnvs	r6, lr, asr #2
     334:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
     338:	4f2f6963 	svcmi	0x002f6963
     33c:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
     340:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
     344:	6b6c6172 	blvs	1b18914 <__bss_end+0x1b0ef10>
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
     470:	61700074 	cmnvs	r0, r4, ror r0
     474:	736d6172 	cmnvc	sp, #-2147483620	; 0x8000001c
     478:	69786500 	ldmdbvs	r8!, {r8, sl, sp, lr}^
     47c:	6f635f74 	svcvs	0x00635f74
     480:	6f006564 	svcvs	0x00006564
     484:	72656874 	rsbvc	r6, r5, #116, 16	; 0x740000
     488:	6c6f725f 	sfmvs	f7, 2, [pc], #-380	; 314 <shift+0x314>
     48c:	75625f65 	strbvc	r5, [r2, #-3941]!	; 0xfffff09b
     490:	48006666 	stmdami	r0, {r1, r2, r5, r6, r9, sl, sp, lr}
     494:	6c646e61 	stclvs	14, cr6, [r4], #-388	; 0xfffffe7c
     498:	72505f65 	subsvc	r5, r0, #404	; 0x194
     49c:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     4a0:	57535f73 			; <UNDEFINED> instruction: 0x57535f73
     4a4:	65470049 	strbvs	r0, [r7, #-73]	; 0xffffffb7
     4a8:	63535f74 	cmpvs	r3, #116, 30	; 0x1d0
     4ac:	75646568 	strbvc	r6, [r4, #-1384]!	; 0xfffffa98
     4b0:	5f72656c 	svcpl	0x0072656c
     4b4:	6f666e49 	svcvs	0x00666e49
     4b8:	70614d00 	rsbvc	r4, r1, r0, lsl #26
     4bc:	6c69465f 	stclvs	6, cr4, [r9], #-380	; 0xfffffe84
     4c0:	6f545f65 	svcvs	0x00545f65
     4c4:	7275435f 	rsbsvc	r4, r5, #2080374785	; 0x7c000001
     4c8:	746e6572 	strbtvc	r6, [lr], #-1394	; 0xfffffa8e
     4cc:	32495400 	subcc	r5, r9, #0, 8
     4d0:	4f495f43 	svcmi	0x00495f43
     4d4:	5f6c7443 	svcpl	0x006c7443
     4d8:	61726150 	cmnvs	r2, r0, asr r1
     4dc:	5a00736d 	bpl	1d298 <__bss_end+0x13894>
     4e0:	69626d6f 	stmdbvs	r2!, {r0, r1, r2, r3, r5, r6, r8, sl, fp, sp, lr}^
     4e4:	6f6c0065 	svcvs	0x006c0065
     4e8:	64665f67 	strbtvs	r5, [r6], #-3943	; 0xfffff099
     4ec:	78656e00 	stmdavc	r5!, {r9, sl, fp, sp, lr}^
     4f0:	75520074 	ldrbvc	r0, [r2, #-116]	; 0xffffff8c
     4f4:	62616e6e 	rsbvs	r6, r1, #1760	; 0x6e0
     4f8:	7300656c 	movwvc	r6, #1388	; 0x56c
     4fc:	5f646e65 	svcpl	0x00646e65
     500:	756c6176 	strbvc	r6, [ip, #-374]!	; 0xfffffe8a
     504:	6e490065 	cdpvs	0, 4, cr0, cr9, cr5, {3}
     508:	696c6176 	stmdbvs	ip!, {r1, r2, r4, r5, r6, r8, sp, lr}^
     50c:	61485f64 	cmpvs	r8, r4, ror #30
     510:	656c646e 	strbvs	r6, [ip, #-1134]!	; 0xfffffb92
     514:	6e755200 	cdpvs	2, 7, cr5, cr5, cr0, {0}
     518:	676e696e 	strbvs	r6, [lr, -lr, ror #18]!
     51c:	61654400 	cmnvs	r5, r0, lsl #8
     520:	6e696c64 	cdpvs	12, 6, cr6, cr9, cr4, {3}
     524:	6e555f65 	cdpvs	15, 5, cr5, cr5, cr5, {3}
     528:	6e616863 	cdpvs	8, 6, cr6, cr1, cr3, {3}
     52c:	00646567 	rsbeq	r6, r4, r7, ror #10
     530:	5f746547 	svcpl	0x00746547
     534:	72727543 	rsbsvc	r7, r2, #281018368	; 0x10c00000
     538:	5f746e65 	svcpl	0x00746e65
     53c:	636f7250 	cmnvs	pc, #80, 4
     540:	00737365 	rsbseq	r7, r3, r5, ror #6
     544:	4f495047 	svcmi	0x00495047
     548:	7361425f 	cmnvc	r1, #-268435451	; 0xf0000005
     54c:	5a5f0065 	bpl	17c06e8 <__bss_end+0x17b6ce4>
     550:	4336314e 	teqmi	r6, #-2147483629	; 0x80000013
     554:	636f7250 	cmnvs	pc, #80, 4
     558:	5f737365 	svcpl	0x00737365
     55c:	616e614d 	cmnvs	lr, sp, asr #2
     560:	31726567 	cmncc	r2, r7, ror #10
     564:	65724334 	ldrbvs	r4, [r2, #-820]!	; 0xfffffccc
     568:	5f657461 	svcpl	0x00657461
     56c:	636f7250 	cmnvs	pc, #80, 4
     570:	45737365 	ldrbmi	r7, [r3, #-869]!	; 0xfffffc9b
     574:	626a6850 	rsbvs	r6, sl, #80, 16	; 0x500000
     578:	395a5f00 	ldmdbcc	sl, {r8, r9, sl, fp, ip, lr}^
     57c:	646e6573 	strbtvs	r6, [lr], #-1395	; 0xfffffa8d
     580:	7461645f 	strbtvc	r6, [r1], #-1119	; 0xfffffba1
     584:	53006661 	movwpl	r6, #1633	; 0x661
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
     5b0:	4b4e5a5f 	blmi	1396f34 <__bss_end+0x138d530>
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
     5e8:	5f78614d 	svcpl	0x0078614d
     5ec:	636f7250 	cmnvs	pc, #80, 4
     5f0:	5f737365 	svcpl	0x00737365
     5f4:	6e65704f 	cdpvs	0, 6, cr7, cr5, cr15, {2}
     5f8:	465f6465 	ldrbmi	r6, [pc], -r5, ror #8
     5fc:	73656c69 	cmnvc	r5, #26880	; 0x6900
     600:	50435400 	subpl	r5, r3, r0, lsl #8
     604:	6f435f55 	svcvs	0x00435f55
     608:	7865746e 	stmdavc	r5!, {r1, r2, r3, r5, r6, sl, ip, sp, lr}^
     60c:	5a5f0074 	bpl	17c07e4 <__bss_end+0x17b6de0>
     610:	4336314e 	teqmi	r6, #-2147483629	; 0x80000013
     614:	636f7250 	cmnvs	pc, #80, 4
     618:	5f737365 	svcpl	0x00737365
     61c:	616e614d 	cmnvs	lr, sp, asr #2
     620:	38726567 	ldmdacc	r2!, {r0, r1, r2, r5, r6, r8, sl, sp, lr}^
     624:	65686353 	strbvs	r6, [r8, #-851]!	; 0xfffffcad
     628:	656c7564 	strbvs	r7, [ip, #-1380]!	; 0xfffffa9c
     62c:	4e007645 	cfmadd32mi	mvax2, mvfx7, mvfx0, mvfx5
     630:	6669746f 	strbtvs	r7, [r9], -pc, ror #8
     634:	6c6c4179 	stfvse	f4, [ip], #-484	; 0xfffffe1c
     638:	6f6c4200 	svcvs	0x006c4200
     63c:	435f6b63 	cmpmi	pc, #101376	; 0x18c00
     640:	65727275 	ldrbvs	r7, [r2, #-629]!	; 0xfffffd8b
     644:	505f746e 	subspl	r7, pc, lr, ror #8
     648:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     64c:	47007373 	smlsdxmi	r0, r3, r3, r7
     650:	505f7465 	subspl	r7, pc, r5, ror #8
     654:	75004449 	strvc	r4, [r0, #-1097]	; 0xfffffbb7
     658:	33746e69 	cmncc	r4, #1680	; 0x690
     65c:	00745f32 	rsbseq	r5, r4, r2, lsr pc
     660:	45574f4c 	ldrbmi	r4, [r7, #-3916]	; 0xfffff0b4
     664:	4f425f52 	svcmi	0x00425f52
     668:	00444e55 	subeq	r4, r4, r5, asr lr
     66c:	434f494e 	movtmi	r4, #63822	; 0xf94e
     670:	4f5f6c74 	svcmi	0x005f6c74
     674:	61726570 	cmnvs	r2, r0, ror r5
     678:	6e6f6974 			; <UNDEFINED> instruction: 0x6e6f6974
     67c:	6f6c6600 	svcvs	0x006c6600
     680:	42007461 	andmi	r7, r0, #1627389952	; 0x61000000
     684:	5f314353 	svcpl	0x00314353
     688:	65736142 	ldrbvs	r6, [r3, #-322]!	; 0xfffffebe
     68c:	69615700 	stmdbvs	r1!, {r8, r9, sl, ip, lr}^
     690:	544e0074 	strbpl	r0, [lr], #-116	; 0xffffff8c
     694:	5f6b7361 	svcpl	0x006b7361
     698:	74617453 	strbtvc	r7, [r1], #-1107	; 0xfffffbad
     69c:	63530065 	cmpvs	r3, #101	; 0x65
     6a0:	75646568 	strbvc	r6, [r4, #-1384]!	; 0xfffffa98
     6a4:	455f656c 	ldrbmi	r6, [pc, #-1388]	; 140 <shift+0x140>
     6a8:	42004644 	andmi	r4, r0, #68, 12	; 0x4400000
     6ac:	6b636f6c 	blvs	18dc464 <__bss_end+0x18d2a60>
     6b0:	6d006465 	cfstrsvs	mvf6, [r0, #-404]	; 0xfffffe6c
     6b4:	72727543 	rsbsvc	r7, r2, #281018368	; 0x10c00000
     6b8:	5f746e65 	svcpl	0x00746e65
     6bc:	6b736154 	blvs	1cd8c14 <__bss_end+0x1ccf210>
     6c0:	646f4e5f 	strbtvs	r4, [pc], #-3679	; 6c8 <shift+0x6c8>
     6c4:	6c730065 	ldclvs	0, cr0, [r3], #-404	; 0xfffffe6c
     6c8:	5f706565 	svcpl	0x00706565
     6cc:	656d6974 	strbvs	r6, [sp, #-2420]!	; 0xfffff68c
     6d0:	5a5f0072 	bpl	17c08a0 <__bss_end+0x17b6e9c>
     6d4:	4336314e 	teqmi	r6, #-2147483629	; 0x80000013
     6d8:	636f7250 	cmnvs	pc, #80, 4
     6dc:	5f737365 	svcpl	0x00737365
     6e0:	616e614d 	cmnvs	lr, sp, asr #2
     6e4:	39726567 	ldmdbcc	r2!, {r0, r1, r2, r5, r6, r8, sl, sp, lr}^
     6e8:	74697753 	strbtvc	r7, [r9], #-1875	; 0xfffff8ad
     6ec:	545f6863 	ldrbpl	r6, [pc], #-2147	; 6f4 <shift+0x6f4>
     6f0:	3150456f 	cmpcc	r0, pc, ror #10
     6f4:	72504338 	subsvc	r4, r0, #56, 6	; 0xe0000000
     6f8:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     6fc:	694c5f73 	stmdbvs	ip, {r0, r1, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     700:	4e5f7473 	mrcmi	4, 2, r7, cr15, cr3, {3}
     704:	0065646f 	rsbeq	r6, r5, pc, ror #8
     708:	6568746f 	strbvs	r7, [r8, #-1135]!	; 0xfffffb91
     70c:	6f725f72 	svcvs	0x00725f72
     710:	6300656c 	movwvs	r6, #1388	; 0x56c
     714:	635f7570 	cmpvs	pc, #112, 10	; 0x1c000000
     718:	65746e6f 	ldrbvs	r6, [r4, #-3695]!	; 0xfffff191
     71c:	43007478 	movwmi	r7, #1144	; 0x478
     720:	74616572 	strbtvc	r6, [r1], #-1394	; 0xfffffa8e
     724:	72505f65 	subsvc	r5, r0, #404	; 0x194
     728:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     72c:	704f0073 	subvc	r0, pc, r3, ror r0	; <UNPREDICTABLE>
     730:	54006e65 	strpl	r6, [r0], #-3685	; 0xfffff19b
     734:	72656d69 	rsbvc	r6, r5, #6720	; 0x1a40
     738:	7361425f 	cmnvc	r1, #-268435451	; 0xf0000005
     73c:	5a5f0065 	bpl	17c08d8 <__bss_end+0x17b6ed4>
     740:	676f6c33 			; <UNDEFINED> instruction: 0x676f6c33
     744:	00634b50 	rsbeq	r4, r3, r0, asr fp
     748:	646e6573 	strbtvs	r6, [lr], #-1395	; 0xfffffa8d
     74c:	7461645f 	strbtvc	r6, [r1], #-1119	; 0xfffffba1
     750:	65640061 	strbvs	r0, [r4, #-97]!	; 0xffffff9f
     754:	65726973 	ldrbvs	r6, [r2, #-2419]!	; 0xfffff68d
     758:	6f725f64 	svcvs	0x00725f64
     75c:	6d00656c 	cfstr32vs	mvfx6, [r0, #-432]	; 0xfffffe50
     760:	6f725f79 	svcvs	0x00725f79
     764:	5f00656c 	svcpl	0x0000656c
     768:	36314e5a 			; <UNDEFINED> instruction: 0x36314e5a
     76c:	6f725043 	svcvs	0x00725043
     770:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     774:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     778:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     77c:	6f4e3431 	svcvs	0x004e3431
     780:	79666974 	stmdbvc	r6!, {r2, r4, r5, r6, r8, fp, sp, lr}^
     784:	6f72505f 	svcvs	0x0072505f
     788:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     78c:	32315045 	eorscc	r5, r1, #69	; 0x45
     790:	73615454 	cmnvc	r1, #84, 8	; 0x54000000
     794:	74535f6b 	ldrbvc	r5, [r3], #-3947	; 0xfffff095
     798:	74637572 	strbtvc	r7, [r3], #-1394	; 0xfffffa8e
     79c:	74654700 	strbtvc	r4, [r5], #-1792	; 0xfffff900
     7a0:	6863535f 	stmdavs	r3!, {r0, r1, r2, r3, r4, r6, r8, r9, ip, lr}^
     7a4:	495f6465 	ldmdbmi	pc, {r0, r2, r5, r6, sl, sp, lr}^	; <UNPREDICTABLE>
     7a8:	006f666e 	rsbeq	r6, pc, lr, ror #12
     7ac:	74434f49 	strbvc	r4, [r3], #-3913	; 0xfffff0b7
     7b0:	5a5f006c 	bpl	17c0968 <__bss_end+0x17b6f64>
     7b4:	676f6c33 			; <UNDEFINED> instruction: 0x676f6c33
     7b8:	6c73006a 	ldclvs	0, cr0, [r3], #-424	; 0xfffffe58
     7bc:	00657661 	rsbeq	r7, r5, r1, ror #12
     7c0:	64616552 	strbtvs	r6, [r1], #-1362	; 0xfffffaae
     7c4:	72655400 	rsbvc	r5, r5, #0, 8
     7c8:	616e696d 	cmnvs	lr, sp, ror #18
     7cc:	6e006574 	cfrshl64vs	mvdx0, mvdx4, r6
     7d0:	625f7765 	subsvs	r7, pc, #26476544	; 0x1940000
     7d4:	00666675 	rsbeq	r6, r6, r5, ror r6
     7d8:	7473614d 	ldrbtvc	r6, [r3], #-333	; 0xfffffeb3
     7dc:	4e007265 	cdpmi	2, 0, cr7, cr0, cr5, {3}
     7e0:	6669746f 	strbtvs	r7, [r9], -pc, ror #8
     7e4:	72505f79 	subsvc	r5, r0, #484	; 0x1e4
     7e8:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     7ec:	5a5f0073 	bpl	17c09c0 <__bss_end+0x17b6fbc>
     7f0:	4336314e 	teqmi	r6, #-2147483629	; 0x80000013
     7f4:	636f7250 	cmnvs	pc, #80, 4
     7f8:	5f737365 	svcpl	0x00737365
     7fc:	616e614d 	cmnvs	lr, sp, asr #2
     800:	43726567 	cmnmi	r2, #432013312	; 0x19c00000
     804:	00764534 	rsbseq	r4, r6, r4, lsr r5
     808:	70657270 	rsbvc	r7, r5, r0, ror r2
     80c:	67736d5f 			; <UNDEFINED> instruction: 0x67736d5f
     810:	52415400 	subpl	r5, r1, #0, 8
     814:	5f544547 	svcpl	0x00544547
     818:	52444441 	subpl	r4, r4, #1090519040	; 0x41000000
     81c:	00535345 	subseq	r5, r3, r5, asr #6
     820:	646e6172 	strbtvs	r6, [lr], #-370	; 0xfffffe8e
     824:	765f6d6f 	ldrbvc	r6, [pc], -pc, ror #26
     828:	65756c61 	ldrbvs	r6, [r5, #-3169]!	; 0xfffff39f
     82c:	656c5f73 	strbvs	r5, [ip, #-3955]!	; 0xfffff08d
     830:	6975006e 	ldmdbvs	r5!, {r1, r2, r3, r5, r6}^
     834:	5f38746e 	svcpl	0x0038746e
     838:	6f4e0074 	svcvs	0x004e0074
     83c:	79666974 	stmdbvc	r6!, {r2, r4, r5, r6, r8, fp, sp, lr}^
     840:	78614d00 	stmdavc	r1!, {r8, sl, fp, lr}^
     844:	68746150 	ldmdavs	r4!, {r4, r6, r8, sp, lr}^
     848:	676e654c 	strbvs	r6, [lr, -ip, asr #10]!
     84c:	4d006874 	stcmi	8, cr6, [r0, #-464]	; 0xfffffe30
     850:	53467861 	movtpl	r7, #26721	; 0x6861
     854:	76697244 	strbtvc	r7, [r9], -r4, asr #4
     858:	614e7265 	cmpvs	lr, r5, ror #4
     85c:	654c656d 	strbvs	r6, [ip, #-1389]	; 0xfffffa93
     860:	6874676e 	ldmdavs	r4!, {r1, r2, r3, r5, r6, r8, r9, sl, sp, lr}^
     864:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     868:	50433631 	subpl	r3, r3, r1, lsr r6
     86c:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     870:	4d5f7373 	ldclmi	3, cr7, [pc, #-460]	; 6ac <shift+0x6ac>
     874:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
     878:	31317265 	teqcc	r1, r5, ror #4
     87c:	65686353 	strbvs	r6, [r8, #-851]!	; 0xfffffcad
     880:	656c7564 	strbvs	r7, [ip, #-1380]!	; 0xfffffa9c
     884:	4552525f 	ldrbmi	r5, [r2, #-607]	; 0xfffffda1
     888:	474e0076 	smlsldxmi	r0, lr, r6, r0
     88c:	535f7465 	cmppl	pc, #1694498816	; 0x65000000
     890:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     894:	666e495f 			; <UNDEFINED> instruction: 0x666e495f
     898:	79545f6f 	ldmdbvc	r4, {r0, r1, r2, r3, r5, r6, r8, r9, sl, fp, ip, lr}^
     89c:	47006570 	smlsdxmi	r0, r0, r5, r6
     8a0:	5f4f4950 	svcpl	0x004f4950
     8a4:	5f6e6950 	svcpl	0x006e6950
     8a8:	6e756f43 	cdpvs	15, 7, cr6, cr5, cr3, {2}
     8ac:	61740074 	cmnvs	r4, r4, ror r0
     8b0:	62006b73 	andvs	r6, r0, #117760	; 0x1cc00
     8b4:	006c6f6f 	rsbeq	r6, ip, pc, ror #30
     8b8:	31315a5f 	teqcc	r1, pc, asr sl
     8bc:	69636564 	stmdbvs	r3!, {r2, r5, r6, r8, sl, sp, lr}^
     8c0:	725f6564 	subsvc	r6, pc, #100, 10	; 0x19000000
     8c4:	39656c6f 	stmdbcc	r5!, {r0, r1, r2, r3, r5, r6, sl, fp, sp, lr}^
     8c8:	43324943 	teqmi	r2, #1097728	; 0x10c000
     8cc:	646f4d5f 	strbtvs	r4, [pc], #-3423	; 8d4 <shift+0x8d4>
     8d0:	00635065 	rsbeq	r5, r3, r5, rrx
     8d4:	314e5a5f 	cmpcc	lr, pc, asr sl
     8d8:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     8dc:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     8e0:	614d5f73 	hvcvs	54771	; 0xd5f3
     8e4:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     8e8:	47383172 			; <UNDEFINED> instruction: 0x47383172
     8ec:	535f7465 	cmppl	pc, #1694498816	; 0x65000000
     8f0:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     8f4:	72656c75 	rsbvc	r6, r5, #29952	; 0x7500
     8f8:	666e495f 			; <UNDEFINED> instruction: 0x666e495f
     8fc:	3032456f 	eorscc	r4, r2, pc, ror #10
     900:	7465474e 	strbtvc	r4, [r5], #-1870	; 0xfffff8b2
     904:	6863535f 	stmdavs	r3!, {r0, r1, r2, r3, r4, r6, r8, r9, ip, lr}^
     908:	495f6465 	ldmdbmi	pc, {r0, r2, r5, r6, sl, sp, lr}^	; <UNPREDICTABLE>
     90c:	5f6f666e 	svcpl	0x006f666e
     910:	65707954 	ldrbvs	r7, [r0, #-2388]!	; 0xfffff6ac
     914:	54007650 	strpl	r7, [r0], #-1616	; 0xfffff9b0
     918:	5f474e52 	svcpl	0x00474e52
     91c:	65736142 	ldrbvs	r6, [r3, #-322]!	; 0xfffffebe
     920:	616c5300 	cmnvs	ip, r0, lsl #6
     924:	44006576 	strmi	r6, [r0], #-1398	; 0xfffffa8a
     928:	75616665 	strbvc	r6, [r1, #-1637]!	; 0xfffff99b
     92c:	435f746c 	cmpmi	pc, #108, 8	; 0x6c000000
     930:	6b636f6c 	blvs	18dc6e8 <__bss_end+0x18d2ce4>
     934:	7461525f 	strbtvc	r5, [r1], #-607	; 0xfffffda1
     938:	506d0065 	rsbpl	r0, sp, r5, rrx
     93c:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     940:	4c5f7373 	mrrcmi	3, 7, r7, pc, cr3	; <UNPREDICTABLE>
     944:	5f747369 	svcpl	0x00747369
     948:	64616548 	strbtvs	r6, [r1], #-1352	; 0xfffffab8
     94c:	63536d00 	cmpvs	r3, #0, 26
     950:	75646568 	strbvc	r6, [r4, #-1384]!	; 0xfffffa98
     954:	465f656c 	ldrbmi	r6, [pc], -ip, ror #10
     958:	5f00636e 	svcpl	0x0000636e
     95c:	36314e5a 			; <UNDEFINED> instruction: 0x36314e5a
     960:	6f725043 	svcvs	0x00725043
     964:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     968:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     96c:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     970:	6c423132 	stfvse	f3, [r2], {50}	; 0x32
     974:	5f6b636f 	svcpl	0x006b636f
     978:	72727543 	rsbsvc	r7, r2, #281018368	; 0x10c00000
     97c:	5f746e65 	svcpl	0x00746e65
     980:	636f7250 	cmnvs	pc, #80, 4
     984:	45737365 	ldrbmi	r7, [r3, #-869]!	; 0xfffffc9b
     988:	6f4c0076 	svcvs	0x004c0076
     98c:	555f6b63 	ldrbpl	r6, [pc, #-2915]	; fffffe31 <__bss_end+0xffff642d>
     990:	636f6c6e 	cmnvs	pc, #28160	; 0x6e00
     994:	0064656b 	rsbeq	r6, r4, fp, ror #10
     998:	73614c6d 	cmnvc	r1, #27904	; 0x6d00
     99c:	49505f74 	ldmdbmi	r0, {r2, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     9a0:	67610044 	strbvs	r0, [r1, -r4, asr #32]!
     9a4:	64656572 	strbtvs	r6, [r5], #-1394	; 0xfffffa8e
     9a8:	6c6f725f 	sfmvs	f7, 2, [pc], #-380	; 834 <shift+0x834>
     9ac:	77530065 	ldrbvc	r0, [r3, -r5, rrx]
     9b0:	68637469 	stmdavs	r3!, {r0, r3, r5, r6, sl, ip, sp, lr}^
     9b4:	006f545f 	rsbeq	r5, pc, pc, asr r4	; <UNPREDICTABLE>
     9b8:	736f6c43 	cmnvc	pc, #17152	; 0x4300
     9bc:	5a5f0065 	bpl	17c0b58 <__bss_end+0x17b7154>
     9c0:	4336314e 	teqmi	r6, #-2147483629	; 0x80000013
     9c4:	636f7250 	cmnvs	pc, #80, 4
     9c8:	5f737365 	svcpl	0x00737365
     9cc:	616e614d 	cmnvs	lr, sp, asr #2
     9d0:	31726567 	cmncc	r2, r7, ror #10
     9d4:	68635332 	stmdavs	r3!, {r1, r4, r5, r8, r9, ip, lr}^
     9d8:	6c756465 	cfldrdvs	mvd6, [r5], #-404	; 0xfffffe6c
     9dc:	44455f65 	strbmi	r5, [r5], #-3941	; 0xfffff09b
     9e0:	00764546 	rsbseq	r4, r6, r6, asr #10
     9e4:	30435342 	subcc	r5, r3, r2, asr #6
     9e8:	7361425f 	cmnvc	r1, #-268435451	; 0xf0000005
     9ec:	6e550065 	cdpvs	0, 5, cr0, cr5, cr5, {3}
     9f0:	69666564 	stmdbvs	r6!, {r2, r5, r6, r8, sl, sp, lr}^
     9f4:	0064656e 	rsbeq	r6, r4, lr, ror #10
     9f8:	63677261 	cmnvs	r7, #268435462	; 0x10000006
     9fc:	746f6e00 	strbtvc	r6, [pc], #-3584	; a04 <shift+0xa04>
     a00:	65696669 	strbvs	r6, [r9, #-1641]!	; 0xfffff997
     a04:	65645f64 	strbvs	r5, [r4, #-3940]!	; 0xfffff09c
     a08:	696c6461 	stmdbvs	ip!, {r0, r5, r6, sl, sp, lr}^
     a0c:	6100656e 	tstvs	r0, lr, ror #10
     a10:	00766772 	rsbseq	r6, r6, r2, ror r7
     a14:	5f676f6c 	svcpl	0x00676f6c
     a18:	0067736d 	rsbeq	r7, r7, sp, ror #6
     a1c:	314e5a5f 	cmpcc	lr, pc, asr sl
     a20:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     a24:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     a28:	614d5f73 	hvcvs	54771	; 0xd5f3
     a2c:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     a30:	4e343172 	mrcmi	1, 1, r3, cr4, cr2, {3}
     a34:	6669746f 	strbtvs	r7, [r9], -pc, ror #8
     a38:	72505f79 	subsvc	r5, r0, #484	; 0x1e4
     a3c:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     a40:	006a4573 	rsbeq	r4, sl, r3, ror r5
     a44:	69466f4e 	stmdbvs	r6, {r1, r2, r3, r6, r8, r9, sl, fp, sp, lr}^
     a48:	7973656c 	ldmdbvc	r3!, {r2, r3, r5, r6, r8, sl, sp, lr}^
     a4c:	6d657473 	cfstrdvs	mvd7, [r5, #-460]!	; 0xfffffe34
     a50:	76697244 	strbtvc	r7, [r9], -r4, asr #4
     a54:	44007265 	strmi	r7, [r0], #-613	; 0xfffffd9b
     a58:	6c646165 	stfvse	f6, [r4], #-404	; 0xfffffe6c
     a5c:	00656e69 	rsbeq	r6, r5, r9, ror #28
     a60:	61736944 	cmnvs	r3, r4, asr #18
     a64:	5f656c62 	svcpl	0x00656c62
     a68:	6e657645 	cdpvs	6, 6, cr7, cr5, cr5, {2}
     a6c:	65445f74 	strbvs	r5, [r4, #-3956]	; 0xfffff08c
     a70:	74636574 	strbtvc	r6, [r3], #-1396	; 0xfffffa8c
     a74:	006e6f69 	rsbeq	r6, lr, r9, ror #30
     a78:	726f6873 	rsbvc	r6, pc, #7536640	; 0x730000
     a7c:	6e692074 	mcrvs	0, 3, r2, cr9, cr4, {3}
     a80:	614d0074 	hvcvs	53252	; 0xd004
     a84:	6c694678 	stclvs	6, cr4, [r9], #-480	; 0xfffffe20
     a88:	6d616e65 	stclvs	14, cr6, [r1, #-404]!	; 0xfffffe6c
     a8c:	6e654c65 	cdpvs	12, 6, cr4, cr5, cr5, {3}
     a90:	00687467 	rsbeq	r7, r8, r7, ror #8
     a94:	6f725043 	svcvs	0x00725043
     a98:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     a9c:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     aa0:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     aa4:	78656e00 	stmdavc	r5!, {r9, sl, fp, sp, lr}^
     aa8:	72705f74 	rsbsvc	r5, r0, #116, 30	; 0x1d0
     aac:	63696465 	cmnvs	r9, #1694498816	; 0x65000000
     ab0:	74740074 	ldrbtvc	r0, [r4], #-116	; 0xffffff8c
     ab4:	00307262 	eorseq	r7, r0, r2, ror #4
     ab8:	5f746573 	svcpl	0x00746573
     abc:	656c6f72 	strbvs	r6, [ip, #-3954]!	; 0xfffff08e
     ac0:	534e0073 	movtpl	r0, #57459	; 0xe073
     ac4:	465f4957 			; <UNDEFINED> instruction: 0x465f4957
     ac8:	73656c69 	cmnvc	r5, #26880	; 0x6900
     acc:	65747379 	ldrbvs	r7, [r4, #-889]!	; 0xfffffc87
     ad0:	65535f6d 	ldrbvs	r5, [r3, #-3949]	; 0xfffff093
     ad4:	63697672 	cmnvs	r9, #119537664	; 0x7200000
     ad8:	552f0065 	strpl	r0, [pc, #-101]!	; a7b <shift+0xa7b>
     adc:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
     ae0:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
     ae4:	6a726574 	bvs	1c9a0bc <__bss_end+0x1c906b8>
     ae8:	65442f69 	strbvs	r2, [r4, #-3945]	; 0xfffff097
     aec:	6f746b73 	svcvs	0x00746b73
     af0:	41462f70 	hvcmi	25328	; 0x62f0
     af4:	614e2f56 	cmpvs	lr, r6, asr pc
     af8:	757a6176 	ldrbvc	r6, [sl, #-374]!	; 0xfffffe8a
     afc:	6963696a 	stmdbvs	r3!, {r1, r3, r5, r6, r8, fp, sp, lr}^
     b00:	2f534f2f 	svccs	0x00534f2f
     b04:	656d6573 	strbvs	r6, [sp, #-1395]!	; 0xfffffa8d
     b08:	61727473 	cmnvs	r2, r3, ror r4
     b0c:	2d616b6c 	vstmdbcs	r1!, {d22-<overflow reg d75>}
     b10:	2d76696b 			; <UNDEFINED> instruction: 0x2d76696b
     b14:	732f736f 			; <UNDEFINED> instruction: 0x732f736f
     b18:	6372756f 	cmnvs	r2, #465567744	; 0x1bc00000
     b1c:	752f7365 	strvc	r7, [pc, #-869]!	; 7bf <shift+0x7bf>
     b20:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
     b24:	65636170 	strbvs	r6, [r3, #-368]!	; 0xfffffe90
     b28:	616c732f 	cmnvs	ip, pc, lsr #6
     b2c:	745f6576 	ldrbvc	r6, [pc], #-1398	; b34 <shift+0xb34>
     b30:	2f6b7361 	svccs	0x006b7361
     b34:	6e69616d 	powvsez	f6, f1, #5.0
     b38:	7070632e 	rsbsvc	r6, r0, lr, lsr #6
     b3c:	57534e00 	ldrbpl	r4, [r3, -r0, lsl #28]
     b40:	72505f49 	subsvc	r5, r0, #292	; 0x124
     b44:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     b48:	65535f73 	ldrbvs	r5, [r3, #-3955]	; 0xfffff08d
     b4c:	63697672 	cmnvs	r9, #119537664	; 0x7200000
     b50:	706f0065 	rsbvc	r0, pc, r5, rrx
     b54:	64656e65 	strbtvs	r6, [r5], #-3685	; 0xfffff19b
     b58:	6c69665f 	stclvs	6, cr6, [r9], #-380	; 0xfffffe84
     b5c:	59007365 	stmdbpl	r0, {r0, r2, r5, r6, r8, r9, ip, sp, lr}
     b60:	646c6569 	strbtvs	r6, [ip], #-1385	; 0xfffffa97
     b64:	63656400 	cmnvs	r5, #0, 8
     b68:	5f656469 	svcpl	0x00656469
     b6c:	656c6f72 	strbvs	r6, [ip, #-3954]!	; 0xfffff08e
     b70:	646e4900 	strbtvs	r4, [lr], #-2304	; 0xfffff700
     b74:	6e696665 	cdpvs	6, 6, cr6, cr9, cr5, {3}
     b78:	00657469 	rsbeq	r7, r5, r9, ror #8
     b7c:	5f746547 	svcpl	0x00746547
     b80:	636f7250 	cmnvs	pc, #80, 4
     b84:	5f737365 	svcpl	0x00737365
     b88:	505f7942 	subspl	r7, pc, r2, asr #18
     b8c:	45004449 	strmi	r4, [r0, #-1097]	; 0xfffffbb7
     b90:	6c62616e 	stfvse	f6, [r2], #-440	; 0xfffffe48
     b94:	76455f65 	strbvc	r5, [r5], -r5, ror #30
     b98:	5f746e65 	svcpl	0x00746e65
     b9c:	65746544 	ldrbvs	r6, [r4, #-1348]!	; 0xfffffabc
     ba0:	6f697463 	svcvs	0x00697463
     ba4:	6550006e 	ldrbvs	r0, [r0, #-110]	; 0xffffff92
     ba8:	68706972 	ldmdavs	r0!, {r1, r4, r5, r6, r8, fp, sp, lr}^
     bac:	6c617265 	sfmvs	f7, 2, [r1], #-404	; 0xfffffe6c
     bb0:	7361425f 	cmnvc	r1, #-268435451	; 0xf0000005
     bb4:	45440065 	strbmi	r0, [r4, #-101]	; 0xffffff9b
     bb8:	45524953 	ldrbmi	r4, [r2, #-2387]	; 0xfffff6ad
     bbc:	4f525f44 	svcmi	0x00525f44
     bc0:	6c00454c 	cfstr32vs	mvfx4, [r0], {76}	; 0x4c
     bc4:	20676e6f 	rsbcs	r6, r7, pc, ror #28
     bc8:	69736e75 	ldmdbvs	r3!, {r0, r2, r4, r5, r6, r9, sl, fp, sp, lr}^
     bcc:	64656e67 	strbtvs	r6, [r5], #-3687	; 0xfffff199
     bd0:	746e6920 	strbtvc	r6, [lr], #-2336	; 0xfffff6e0
     bd4:	64646100 	strbtvs	r6, [r4], #-256	; 0xffffff00
     bd8:	73736572 	cmnvc	r3, #478150656	; 0x1c800000
     bdc:	766e4900 	strbtvc	r4, [lr], -r0, lsl #18
     be0:	64696c61 	strbtvs	r6, [r9], #-3169	; 0xfffff39f
     be4:	6e69505f 	mcrvs	0, 3, r5, cr9, cr15, {2}
     be8:	636f4c00 	cmnvs	pc, #0, 24
     bec:	6f4c5f6b 	svcvs	0x004c5f6b
     bf0:	64656b63 	strbtvs	r6, [r5], #-2915	; 0xfffff49d
     bf4:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     bf8:	50433631 	subpl	r3, r3, r1, lsr r6
     bfc:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     c00:	4d5f7373 	ldclmi	3, cr7, [pc, #-460]	; a3c <shift+0xa3c>
     c04:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
     c08:	38317265 	ldmdacc	r1!, {r0, r2, r5, r6, r9, ip, sp, lr}
     c0c:	646e6148 	strbtvs	r6, [lr], #-328	; 0xfffffeb8
     c10:	505f656c 	subspl	r6, pc, ip, ror #10
     c14:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     c18:	535f7373 	cmppl	pc, #-872415231	; 0xcc000001
     c1c:	32454957 	subcc	r4, r5, #1425408	; 0x15c000
     c20:	57534e30 	smmlarpl	r3, r0, lr, r4
     c24:	72505f49 	subsvc	r5, r0, #292	; 0x124
     c28:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     c2c:	65535f73 	ldrbvs	r5, [r3, #-3955]	; 0xfffff08d
     c30:	63697672 	cmnvs	r9, #119537664	; 0x7200000
     c34:	6a6a6a65 	bvs	1a9b5d0 <__bss_end+0x1a91bcc>
     c38:	54313152 	ldrtpl	r3, [r1], #-338	; 0xfffffeae
     c3c:	5f495753 	svcpl	0x00495753
     c40:	75736552 	ldrbvc	r6, [r3, #-1362]!	; 0xfffffaae
     c44:	7300746c 	movwvc	r7, #1132	; 0x46c
     c48:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     c4c:	756f635f 	strbvc	r6, [pc, #-863]!	; 8f5 <shift+0x8f5>
     c50:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
     c54:	50505500 	subspl	r5, r0, r0, lsl #10
     c58:	425f5245 	subsmi	r5, pc, #1342177284	; 0x50000004
     c5c:	444e554f 	strbmi	r5, [lr], #-1359	; 0xfffffab1
     c60:	74654700 	strbtvc	r4, [r5], #-1792	; 0xfffff900
     c64:	7261505f 	rsbvc	r5, r1, #95	; 0x5f
     c68:	00736d61 	rsbseq	r6, r3, r1, ror #26
     c6c:	69736e75 	ldmdbvs	r3!, {r0, r2, r4, r5, r6, r9, sl, fp, sp, lr}^
     c70:	64656e67 	strbtvs	r6, [r5], #-3687	; 0xfffff199
     c74:	61686320 	cmnvs	r8, r0, lsr #6
     c78:	5a5f0072 	bpl	17c0e48 <__bss_end+0x17b7444>
     c7c:	65727038 	ldrbvs	r7, [r2, #-56]!	; 0xffffffc8
     c80:	736d5f70 	cmnvc	sp, #112, 30	; 0x1c0
     c84:	50635067 	rsbpl	r5, r3, r7, rrx
     c88:	4900634b 	stmdbmi	r0, {r0, r1, r3, r6, r8, r9, sp, lr}
     c8c:	535f4332 	cmppl	pc, #-939524096	; 0xc8000000
     c90:	4556414c 	ldrbmi	r4, [r6, #-332]	; 0xfffffeb4
     c94:	7361425f 	cmnvc	r1, #-268435451	; 0xf0000005
     c98:	6e490065 	cdpvs	0, 4, cr0, cr9, cr5, {3}
     c9c:	72726574 	rsbsvc	r6, r2, #116, 10	; 0x1d000000
     ca0:	61747075 	cmnvs	r4, r5, ror r0
     ca4:	5f656c62 	svcpl	0x00656c62
     ca8:	65656c53 	strbvs	r6, [r5, #-3155]!	; 0xfffff3ad
     cac:	63530070 	cmpvs	r3, #112	; 0x70
     cb0:	75646568 	strbvc	r6, [r4, #-1384]!	; 0xfffffa98
     cb4:	525f656c 	subspl	r6, pc, #108, 10	; 0x1b000000
     cb8:	55410052 	strbpl	r0, [r1, #-82]	; 0xffffffae
     cbc:	61425f58 	cmpvs	r2, r8, asr pc
     cc0:	42006573 	andmi	r6, r0, #482344960	; 0x1cc00000
     cc4:	5f324353 	svcpl	0x00324353
     cc8:	65736142 	ldrbvs	r6, [r3, #-322]!	; 0xfffffebe
     ccc:	395a5f00 	ldmdbcc	sl, {r8, r9, sl, fp, ip, lr}^
     cd0:	5f746573 	svcpl	0x00746573
     cd4:	656c6f72 	strbvs	r6, [ip, #-3954]!	; 0xfffff08e
     cd8:	49433973 	stmdbmi	r3, {r0, r1, r4, r5, r6, r8, fp, ip, sp}^
     cdc:	4d5f4332 	ldclmi	3, cr4, [pc, #-200]	; c1c <shift+0xc1c>
     ce0:	0065646f 	rsbeq	r6, r5, pc, ror #8
     ce4:	74617473 	strbtvc	r7, [r1], #-1139	; 0xfffffb8d
     ce8:	61720065 	cmnvs	r2, r5, rrx
     cec:	6d6f646e 	cfstrdvs	mvd6, [pc, #-440]!	; b3c <shift+0xb3c>
     cf0:	6c61765f 	stclvs	6, cr7, [r1], #-380	; 0xfffffe84
     cf4:	00736575 	rsbseq	r6, r3, r5, ror r5
     cf8:	74697257 	strbtvc	r7, [r9], #-599	; 0xfffffda9
     cfc:	6e4f5f65 	cdpvs	15, 4, cr5, cr15, cr5, {3}
     d00:	5300796c 	movwpl	r7, #2412	; 0x96c
     d04:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     d08:	00656c75 	rsbeq	r6, r5, r5, ror ip
     d0c:	6b636954 	blvs	18db264 <__bss_end+0x18d1860>
     d10:	756f435f 	strbvc	r4, [pc, #-863]!	; 9b9 <shift+0x9b9>
     d14:	5f00746e 	svcpl	0x0000746e
     d18:	36314e5a 			; <UNDEFINED> instruction: 0x36314e5a
     d1c:	6f725043 	svcvs	0x00725043
     d20:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     d24:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     d28:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     d2c:	6e553831 	mrcvs	8, 2, r3, cr5, cr1, {1}
     d30:	5f70616d 	svcpl	0x0070616d
     d34:	656c6946 	strbvs	r6, [ip, #-2374]!	; 0xfffff6ba
     d38:	7275435f 	rsbsvc	r4, r5, #2080374785	; 0x7c000001
     d3c:	746e6572 	strbtvc	r6, [lr], #-1394	; 0xfffffa8e
     d40:	49006a45 	stmdbmi	r0, {r0, r2, r6, r9, fp, sp, lr}
     d44:	535f4332 	cmppl	pc, #-939524096	; 0xc8000000
     d48:	4556414c 	ldrbmi	r4, [r6, #-332]	; 0xfffffeb4
     d4c:	6675425f 			; <UNDEFINED> instruction: 0x6675425f
     d50:	5f726566 	svcpl	0x00726566
     d54:	657a6953 	ldrbvs	r6, [sl, #-2387]!	; 0xfffff6ad
     d58:	6e614800 	cdpvs	8, 6, cr4, cr1, cr0, {0}
     d5c:	5f656c64 	svcpl	0x00656c64
     d60:	656c6946 	strbvs	r6, [ip, #-2374]!	; 0xfffff6ba
     d64:	74737973 	ldrbtvc	r7, [r3], #-2419	; 0xfffff68d
     d68:	535f6d65 	cmppl	pc, #6464	; 0x1940
     d6c:	73004957 	movwvc	r4, #2391	; 0x957
     d70:	74726f68 	ldrbtvc	r6, [r2], #-3944	; 0xfffff098
     d74:	736e7520 	cmnvc	lr, #32, 10	; 0x8000000
     d78:	656e6769 	strbvs	r6, [lr, #-1897]!	; 0xfffff897
     d7c:	6e692064 	cdpvs	0, 6, cr2, cr9, cr4, {3}
     d80:	72700074 	rsbsvc	r0, r0, #116	; 0x74
     d84:	765f7665 	ldrbvc	r7, [pc], -r5, ror #12
     d88:	65756c61 	ldrbvs	r6, [r5, #-3169]!	; 0xfffff39f
     d8c:	69616d00 	stmdbvs	r1!, {r8, sl, fp, sp, lr}^
     d90:	5a5f006e 	bpl	17c0f50 <__bss_end+0x17b754c>
     d94:	65733031 	ldrbvs	r3, [r3, #-49]!	; 0xffffffcf
     d98:	765f646e 	ldrbvc	r6, [pc], -lr, ror #8
     d9c:	65756c61 	ldrbvs	r6, [r5, #-3169]!	; 0xfffff39f
     da0:	61740066 	cmnvs	r4, r6, rrx
     da4:	74656772 	strbtvc	r6, [r5], #-1906	; 0xfffff88e
     da8:	65726441 	ldrbvs	r6, [r2, #-1089]!	; 0xfffffbbf
     dac:	49007373 	stmdbmi	r0, {r0, r1, r4, r5, r6, r8, r9, ip, sp, lr}
     db0:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
     db4:	74707572 	ldrbtvc	r7, [r0], #-1394	; 0xfffffa8e
     db8:	6e6f435f 	mcrvs	3, 3, r4, cr15, cr15, {2}
     dbc:	6c6f7274 	sfmvs	f7, 2, [pc], #-464	; bf4 <shift+0xbf4>
     dc0:	5f72656c 	svcpl	0x0072656c
     dc4:	65736142 	ldrbvs	r6, [r3, #-322]!	; 0xfffffebe
     dc8:	61655200 	cmnvs	r5, r0, lsl #4
     dcc:	72575f64 	subsvc	r5, r7, #100, 30	; 0x190
     dd0:	00657469 	rsbeq	r7, r5, r9, ror #8
     dd4:	69746341 	ldmdbvs	r4!, {r0, r6, r8, r9, sp, lr}^
     dd8:	505f6576 	subspl	r6, pc, r6, ror r5	; <UNPREDICTABLE>
     ddc:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     de0:	435f7373 	cmpmi	pc, #-872415231	; 0xcc000001
     de4:	746e756f 	strbtvc	r7, [lr], #-1391	; 0xfffffa91
     de8:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     dec:	50433631 	subpl	r3, r3, r1, lsr r6
     df0:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     df4:	4d5f7373 	ldclmi	3, cr7, [pc, #-460]	; c30 <shift+0xc30>
     df8:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
     dfc:	31327265 	teqcc	r2, r5, ror #4
     e00:	646e6148 	strbtvs	r6, [lr], #-328	; 0xfffffeb8
     e04:	465f656c 	ldrbmi	r6, [pc], -ip, ror #10
     e08:	73656c69 	cmnvc	r5, #26880	; 0x6900
     e0c:	65747379 	ldrbvs	r7, [r4, #-889]!	; 0xfffffc87
     e10:	57535f6d 	ldrbpl	r5, [r3, -sp, ror #30]
     e14:	33324549 	teqcc	r2, #306184192	; 0x12400000
     e18:	4957534e 	ldmdbmi	r7, {r1, r2, r3, r6, r8, r9, ip, lr}^
     e1c:	6c69465f 	stclvs	6, cr4, [r9], #-380	; 0xfffffe84
     e20:	73797365 	cmnvc	r9, #-1811939327	; 0x94000001
     e24:	5f6d6574 	svcpl	0x006d6574
     e28:	76726553 			; <UNDEFINED> instruction: 0x76726553
     e2c:	6a656369 	bvs	1959bd8 <__bss_end+0x19501d4>
     e30:	31526a6a 	cmpcc	r2, sl, ror #20
     e34:	57535431 	smmlarpl	r3, r1, r4, r5
     e38:	65525f49 	ldrbvs	r5, [r2, #-3913]	; 0xfffff0b7
     e3c:	746c7573 	strbtvc	r7, [ip], #-1395	; 0xfffffa8d
     e40:	73552f00 	cmpvc	r5, #0, 30
     e44:	2f737265 	svccs	0x00737265
     e48:	746e6977 	strbtvc	r6, [lr], #-2423	; 0xfffff689
     e4c:	696a7265 	stmdbvs	sl!, {r0, r2, r5, r6, r9, ip, sp, lr}^
     e50:	7365442f 	cmnvc	r5, #788529152	; 0x2f000000
     e54:	706f746b 	rsbvc	r7, pc, fp, ror #8
     e58:	5641462f 	strbpl	r4, [r1], -pc, lsr #12
     e5c:	76614e2f 	strbtvc	r4, [r1], -pc, lsr #28
     e60:	6a757a61 	bvs	1d5f7ec <__bss_end+0x1d55de8>
     e64:	2f696369 	svccs	0x00696369
     e68:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
     e6c:	73656d65 	cmnvc	r5, #6464	; 0x1940
     e70:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
     e74:	6b2d616b 	blvs	b59428 <__bss_end+0xb4fa24>
     e78:	6f2d7669 	svcvs	0x002d7669
     e7c:	6f732f73 	svcvs	0x00732f73
     e80:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
     e84:	75622f73 	strbvc	r2, [r2, #-3955]!	; 0xfffff08d
     e88:	00646c69 	rsbeq	r6, r4, r9, ror #24
     e8c:	736f6c63 	cmnvc	pc, #25344	; 0x6300
     e90:	65530065 	ldrbvs	r0, [r3, #-101]	; 0xffffff9b
     e94:	65525f74 	ldrbvs	r5, [r2, #-3956]	; 0xfffff08c
     e98:	6974616c 	ldmdbvs	r4!, {r2, r3, r5, r6, r8, sp, lr}^
     e9c:	72006576 	andvc	r6, r0, #494927872	; 0x1d800000
     ea0:	61767465 	cmnvs	r6, r5, ror #8
     ea4:	636e006c 	cmnvs	lr, #108	; 0x6c
     ea8:	70007275 	andvc	r7, r0, r5, ror r2
     eac:	00657069 	rsbeq	r7, r5, r9, rrx
     eb0:	756e6472 	strbvc	r6, [lr, #-1138]!	; 0xfffffb8e
     eb4:	5a5f006d 	bpl	17c1070 <__bss_end+0x17b766c>
     eb8:	63733131 	cmnvs	r3, #1073741836	; 0x4000000c
     ebc:	5f646568 	svcpl	0x00646568
     ec0:	6c656979 			; <UNDEFINED> instruction: 0x6c656979
     ec4:	5f007664 	svcpl	0x00007664
     ec8:	7337315a 	teqvc	r7, #-2147483626	; 0x80000016
     ecc:	745f7465 	ldrbvc	r7, [pc], #-1125	; ed4 <shift+0xed4>
     ed0:	5f6b7361 	svcpl	0x006b7361
     ed4:	64616564 	strbtvs	r6, [r1], #-1380	; 0xfffffa9c
     ed8:	656e696c 	strbvs	r6, [lr, #-2412]!	; 0xfffff694
     edc:	6177006a 	cmnvs	r7, sl, rrx
     ee0:	5f007469 	svcpl	0x00007469
     ee4:	6f6e365a 	svcvs	0x006e365a
     ee8:	79666974 	stmdbvc	r6!, {r2, r4, r5, r6, r8, fp, sp, lr}^
     eec:	46006a6a 	strmi	r6, [r0], -sl, ror #20
     ef0:	006c6961 	rsbeq	r6, ip, r1, ror #18
     ef4:	74697865 	strbtvc	r7, [r9], #-2149	; 0xfffff79b
     ef8:	65646f63 	strbvs	r6, [r4, #-3939]!	; 0xfffff09d
     efc:	68637300 	stmdavs	r3!, {r8, r9, ip, sp, lr}^
     f00:	795f6465 	ldmdbvc	pc, {r0, r2, r5, r6, sl, sp, lr}^	; <UNPREDICTABLE>
     f04:	646c6569 	strbtvs	r6, [ip], #-1385	; 0xfffffa97
     f08:	63697400 	cmnvs	r9, #0, 8
     f0c:	6f635f6b 	svcvs	0x00635f6b
     f10:	5f746e75 	svcpl	0x00746e75
     f14:	75716572 	ldrbvc	r6, [r1, #-1394]!	; 0xfffffa8e
     f18:	64657269 	strbtvs	r7, [r5], #-617	; 0xfffffd97
     f1c:	325a5f00 	subscc	r5, sl, #0, 30
     f20:	74656734 	strbtvc	r6, [r5], #-1844	; 0xfffff8cc
     f24:	7463615f 	strbtvc	r6, [r3], #-351	; 0xfffffea1
     f28:	5f657669 	svcpl	0x00657669
     f2c:	636f7270 	cmnvs	pc, #112, 4
     f30:	5f737365 	svcpl	0x00737365
     f34:	6e756f63 	cdpvs	15, 7, cr6, cr5, cr3, {3}
     f38:	50007674 	andpl	r7, r0, r4, ror r6
     f3c:	5f657069 	svcpl	0x00657069
     f40:	656c6946 	strbvs	r6, [ip, #-2374]!	; 0xfffff6ba
     f44:	6572505f 	ldrbvs	r5, [r2, #-95]!	; 0xffffffa1
     f48:	00786966 	rsbseq	r6, r8, r6, ror #18
     f4c:	34315a5f 	ldrtcc	r5, [r1], #-2655	; 0xfffff5a1
     f50:	5f746567 	svcpl	0x00746567
     f54:	6b636974 	blvs	18db52c <__bss_end+0x18d1b28>
     f58:	756f635f 	strbvc	r6, [pc, #-863]!	; c01 <shift+0xc01>
     f5c:	0076746e 	rsbseq	r7, r6, lr, ror #8
     f60:	65656c73 	strbvs	r6, [r5, #-3187]!	; 0xfffff38d
     f64:	5a5f0070 	bpl	17c112c <__bss_end+0x17b7728>
     f68:	72657439 	rsbvc	r7, r5, #956301312	; 0x39000000
     f6c:	616e696d 	cmnvs	lr, sp, ror #18
     f70:	00696574 	rsbeq	r6, r9, r4, ror r5
     f74:	7265706f 	rsbvc	r7, r5, #111	; 0x6f
     f78:	6f697461 	svcvs	0x00697461
     f7c:	5a5f006e 	bpl	17c113c <__bss_end+0x17b7738>
     f80:	6f6c6335 	svcvs	0x006c6335
     f84:	006a6573 	rsbeq	r6, sl, r3, ror r5
     f88:	67365a5f 			; <UNDEFINED> instruction: 0x67365a5f
     f8c:	69707465 	ldmdbvs	r0!, {r0, r2, r5, r6, sl, ip, sp, lr}^
     f90:	66007664 	strvs	r7, [r0], -r4, ror #12
     f94:	656d616e 	strbvs	r6, [sp, #-366]!	; 0xfffffe92
     f98:	69727700 	ldmdbvs	r2!, {r8, r9, sl, ip, sp, lr}^
     f9c:	74006574 	strvc	r6, [r0], #-1396	; 0xfffffa8c
     fa0:	736b6369 	cmnvc	fp, #-1543503871	; 0xa4000001
     fa4:	65706f00 	ldrbvs	r6, [r0, #-3840]!	; 0xfffff100
     fa8:	5a5f006e 	bpl	17c1168 <__bss_end+0x17b7764>
     fac:	70697034 	rsbvc	r7, r9, r4, lsr r0
     fb0:	634b5065 	movtvs	r5, #45157	; 0xb065
     fb4:	444e006a 	strbmi	r0, [lr], #-106	; 0xffffff96
     fb8:	6c646165 	stfvse	f6, [r4], #-404	; 0xfffffe6c
     fbc:	5f656e69 	svcpl	0x00656e69
     fc0:	73627553 	cmnvc	r2, #348127232	; 0x14c00000
     fc4:	69767265 	ldmdbvs	r6!, {r0, r2, r5, r6, r9, ip, sp, lr}^
     fc8:	67006563 	strvs	r6, [r0, -r3, ror #10]
     fcc:	745f7465 	ldrbvc	r7, [pc], #-1125	; fd4 <shift+0xfd4>
     fd0:	5f6b6369 	svcpl	0x006b6369
     fd4:	6e756f63 	cdpvs	15, 7, cr6, cr5, cr3, {3}
     fd8:	61700074 	cmnvs	r0, r4, ror r0
     fdc:	006d6172 	rsbeq	r6, sp, r2, ror r1
     fe0:	77355a5f 			; <UNDEFINED> instruction: 0x77355a5f
     fe4:	65746972 	ldrbvs	r6, [r4, #-2418]!	; 0xfffff68e
     fe8:	634b506a 	movtvs	r5, #45162	; 0xb06a
     fec:	6567006a 	strbvs	r0, [r7, #-106]!	; 0xffffff96
     ff0:	61745f74 	cmnvs	r4, r4, ror pc
     ff4:	745f6b73 	ldrbvc	r6, [pc], #-2931	; ffc <shift+0xffc>
     ff8:	736b6369 	cmnvc	fp, #-1543503871	; 0xa4000001
     ffc:	5f6f745f 	svcpl	0x006f745f
    1000:	64616564 	strbtvs	r6, [r1], #-1380	; 0xfffffa9c
    1004:	656e696c 	strbvs	r6, [lr, #-2412]!	; 0xfffff694
    1008:	66756200 	ldrbtvs	r6, [r5], -r0, lsl #4
    100c:	7a69735f 	bvc	1a5dd90 <__bss_end+0x1a5438c>
    1010:	65730065 	ldrbvs	r0, [r3, #-101]!	; 0xffffff9b
    1014:	61745f74 	cmnvs	r4, r4, ror pc
    1018:	645f6b73 	ldrbvs	r6, [pc], #-2931	; 1020 <shift+0x1020>
    101c:	6c646165 	stfvse	f6, [r4], #-404	; 0xfffffe6c
    1020:	00656e69 	rsbeq	r6, r5, r9, ror #28
    1024:	6573552f 	ldrbvs	r5, [r3, #-1327]!	; 0xfffffad1
    1028:	772f7372 			; <UNDEFINED> instruction: 0x772f7372
    102c:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
    1030:	2f696a72 	svccs	0x00696a72
    1034:	6b736544 	blvs	1cda54c <__bss_end+0x1cd0b48>
    1038:	2f706f74 	svccs	0x00706f74
    103c:	2f564146 	svccs	0x00564146
    1040:	6176614e 	cmnvs	r6, lr, asr #2
    1044:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
    1048:	4f2f6963 	svcmi	0x002f6963
    104c:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
    1050:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
    1054:	6b6c6172 	blvs	1b19624 <__bss_end+0x1b0fc20>
    1058:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
    105c:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
    1060:	756f732f 	strbvc	r7, [pc, #-815]!	; d39 <shift+0xd39>
    1064:	73656372 	cmnvc	r5, #-939524095	; 0xc8000001
    1068:	6474732f 	ldrbtvs	r7, [r4], #-815	; 0xfffffcd1
    106c:	2f62696c 	svccs	0x0062696c
    1070:	2f637273 	svccs	0x00637273
    1074:	66647473 			; <UNDEFINED> instruction: 0x66647473
    1078:	2e656c69 	cdpcs	12, 6, cr6, cr5, cr9, {3}
    107c:	00707063 	rsbseq	r7, r0, r3, rrx
    1080:	73355a5f 	teqvc	r5, #389120	; 0x5f000
    1084:	7065656c 	rsbvc	r6, r5, ip, ror #10
    1088:	66006a6a 	strvs	r6, [r0], -sl, ror #20
    108c:	00656c69 	rsbeq	r6, r5, r9, ror #24
    1090:	5f746547 	svcpl	0x00746547
    1094:	616d6552 	cmnvs	sp, r2, asr r5
    1098:	6e696e69 	cdpvs	14, 6, cr6, cr9, cr9, {3}
    109c:	5a5f0067 	bpl	17c1240 <__bss_end+0x17b783c>
    10a0:	65673632 	strbvs	r3, [r7, #-1586]!	; 0xfffff9ce
    10a4:	61745f74 	cmnvs	r4, r4, ror pc
    10a8:	745f6b73 	ldrbvc	r6, [pc], #-2931	; 10b0 <shift+0x10b0>
    10ac:	736b6369 	cmnvc	fp, #-1543503871	; 0xa4000001
    10b0:	5f6f745f 	svcpl	0x006f745f
    10b4:	64616564 	strbtvs	r6, [r1], #-1380	; 0xfffffa9c
    10b8:	656e696c 	strbvs	r6, [lr, #-2412]!	; 0xfffff694
    10bc:	534e0076 	movtpl	r0, #57462	; 0xe076
    10c0:	525f4957 	subspl	r4, pc, #1425408	; 0x15c000
    10c4:	6c757365 	ldclvs	3, cr7, [r5], #-404	; 0xfffffe6c
    10c8:	6f435f74 	svcvs	0x00435f74
    10cc:	77006564 	strvc	r6, [r0, -r4, ror #10]
    10d0:	6d756e72 	ldclvs	14, cr6, [r5, #-456]!	; 0xfffffe38
    10d4:	345a5f00 	ldrbcc	r5, [sl], #-3840	; 0xfffff100
    10d8:	74696177 	strbtvc	r6, [r9], #-375	; 0xfffffe89
    10dc:	006a6a6a 	rsbeq	r6, sl, sl, ror #20
    10e0:	69355a5f 	ldmdbvs	r5!, {r0, r1, r2, r3, r4, r6, r9, fp, ip, lr}
    10e4:	6c74636f 	ldclvs	3, cr6, [r4], #-444	; 0xfffffe44
    10e8:	4e36316a 	rsfmisz	f3, f6, #2.0
    10ec:	74434f49 	strbvc	r4, [r3], #-3913	; 0xfffff0b7
    10f0:	704f5f6c 	subvc	r5, pc, ip, ror #30
    10f4:	74617265 	strbtvc	r7, [r1], #-613	; 0xfffffd9b
    10f8:	506e6f69 	rsbpl	r6, lr, r9, ror #30
    10fc:	6f690076 	svcvs	0x00690076
    1100:	006c7463 	rsbeq	r7, ip, r3, ror #8
    1104:	63746572 	cmnvs	r4, #478150656	; 0x1c800000
    1108:	6e00746e 	cdpvs	4, 0, cr7, cr0, cr14, {3}
    110c:	6669746f 	strbtvs	r7, [r9], -pc, ror #8
    1110:	65740079 	ldrbvs	r0, [r4, #-121]!	; 0xffffff87
    1114:	6e696d72 	mcrvs	13, 3, r6, cr9, cr2, {3}
    1118:	00657461 	rsbeq	r7, r5, r1, ror #8
    111c:	65646f6d 	strbvs	r6, [r4, #-3949]!	; 0xfffff093
    1120:	66756200 	ldrbtvs	r6, [r5], -r0, lsl #4
    1124:	00726566 	rsbseq	r6, r2, r6, ror #10
    1128:	72345a5f 	eorsvc	r5, r4, #389120	; 0x5f000
    112c:	6a646165 	bvs	19196c8 <__bss_end+0x190fcc4>
    1130:	006a6350 	rsbeq	r6, sl, r0, asr r3
    1134:	20554e47 	subscs	r4, r5, r7, asr #28
    1138:	312b2b43 			; <UNDEFINED> instruction: 0x312b2b43
    113c:	30312034 	eorscc	r2, r1, r4, lsr r0
    1140:	312e332e 			; <UNDEFINED> instruction: 0x312e332e
    1144:	32303220 	eorscc	r3, r0, #32, 4
    1148:	32383031 	eorscc	r3, r8, #49	; 0x31
    114c:	72282034 	eorvc	r2, r8, #52	; 0x34
    1150:	61656c65 	cmnvs	r5, r5, ror #24
    1154:	20296573 	eorcs	r6, r9, r3, ror r5
    1158:	6c666d2d 	stclvs	13, cr6, [r6], #-180	; 0xffffff4c
    115c:	2d74616f 	ldfcse	f6, [r4, #-444]!	; 0xfffffe44
    1160:	3d696261 	sfmcc	f6, 2, [r9, #-388]!	; 0xfffffe7c
    1164:	64726168 	ldrbtvs	r6, [r2], #-360	; 0xfffffe98
    1168:	666d2d20 	strbtvs	r2, [sp], -r0, lsr #26
    116c:	763d7570 			; <UNDEFINED> instruction: 0x763d7570
    1170:	2d207066 	stccs	0, cr7, [r0, #-408]!	; 0xfffffe68
    1174:	6f6c666d 	svcvs	0x006c666d
    1178:	612d7461 			; <UNDEFINED> instruction: 0x612d7461
    117c:	683d6962 	ldmdavs	sp!, {r1, r5, r6, r8, fp, sp, lr}
    1180:	20647261 	rsbcs	r7, r4, r1, ror #4
    1184:	70666d2d 	rsbvc	r6, r6, sp, lsr #26
    1188:	66763d75 			; <UNDEFINED> instruction: 0x66763d75
    118c:	6d2d2070 	stcvs	0, cr2, [sp, #-448]!	; 0xfffffe40
    1190:	656e7574 	strbvs	r7, [lr, #-1396]!	; 0xfffffa8c
    1194:	6d72613d 	ldfvse	f6, [r2, #-244]!	; 0xffffff0c
    1198:	36373131 			; <UNDEFINED> instruction: 0x36373131
    119c:	2d667a6a 	vstmdbcs	r6!, {s15-s120}
    11a0:	6d2d2073 	stcvs	0, cr2, [sp, #-460]!	; 0xfffffe34
    11a4:	206d7261 	rsbcs	r7, sp, r1, ror #4
    11a8:	72616d2d 	rsbvc	r6, r1, #2880	; 0xb40
    11ac:	613d6863 	teqvs	sp, r3, ror #16
    11b0:	36766d72 			; <UNDEFINED> instruction: 0x36766d72
    11b4:	662b6b7a 			; <UNDEFINED> instruction: 0x662b6b7a
    11b8:	672d2070 			; <UNDEFINED> instruction: 0x672d2070
    11bc:	20672d20 	rsbcs	r2, r7, r0, lsr #26
    11c0:	2d20672d 	stccs	7, cr6, [r0, #-180]!	; 0xffffff4c
    11c4:	2d20304f 	stccs	0, cr3, [r0, #-316]!	; 0xfffffec4
    11c8:	2d20304f 	stccs	0, cr3, [r0, #-316]!	; 0xfffffec4
    11cc:	2d6f6e66 	stclcs	14, cr6, [pc, #-408]!	; 103c <shift+0x103c>
    11d0:	65637865 	strbvs	r7, [r3, #-2149]!	; 0xfffff79b
    11d4:	6f697470 	svcvs	0x00697470
    11d8:	2d20736e 	stccs	3, cr7, [r0, #-440]!	; 0xfffffe48
    11dc:	2d6f6e66 	stclcs	14, cr6, [pc, #-408]!	; 104c <shift+0x104c>
    11e0:	69747472 	ldmdbvs	r4!, {r1, r4, r5, r6, sl, ip, sp, lr}^
    11e4:	74657200 	strbtvc	r7, [r5], #-512	; 0xfffffe00
    11e8:	65646f63 	strbvs	r6, [r4, #-3939]!	; 0xfffff09d
    11ec:	74656700 	strbtvc	r6, [r5], #-1792	; 0xfffff900
    11f0:	7463615f 	strbtvc	r6, [r3], #-351	; 0xfffffea1
    11f4:	5f657669 	svcpl	0x00657669
    11f8:	636f7270 	cmnvs	pc, #112, 4
    11fc:	5f737365 	svcpl	0x00737365
    1200:	6e756f63 	cdpvs	15, 7, cr6, cr5, cr3, {3}
    1204:	69660074 	stmdbvs	r6!, {r2, r4, r5, r6}^
    1208:	616e656c 	cmnvs	lr, ip, ror #10
    120c:	7200656d 	andvc	r6, r0, #457179136	; 0x1b400000
    1210:	00646165 	rsbeq	r6, r4, r5, ror #2
    1214:	70746567 	rsbsvc	r6, r4, r7, ror #10
    1218:	5f006469 	svcpl	0x00006469
    121c:	706f345a 	rsbvc	r3, pc, sl, asr r4	; <UNPREDICTABLE>
    1220:	4b506e65 	blmi	141cbbc <__bss_end+0x14131b8>
    1224:	4e353163 	rsfmisz	f3, f5, f3
    1228:	656c6946 	strbvs	r6, [ip, #-2374]!	; 0xfffff6ba
    122c:	65704f5f 	ldrbvs	r4, [r0, #-3935]!	; 0xfffff0a1
    1230:	6f4d5f6e 	svcvs	0x004d5f6e
    1234:	5f006564 	svcpl	0x00006564
    1238:	656d365a 	strbvs	r3, [sp, #-1626]!	; 0xfffff9a6
    123c:	7970636d 	ldmdbvc	r0!, {r0, r2, r3, r5, r6, r8, r9, sp, lr}^
    1240:	50764b50 	rsbspl	r4, r6, r0, asr fp
    1244:	5f006976 	svcpl	0x00006976
    1248:	7469345a 	strbtvc	r3, [r9], #-1114	; 0xfffffba6
    124c:	506a616f 	rsbpl	r6, sl, pc, ror #2
    1250:	61006a63 	tstvs	r0, r3, ror #20
    1254:	00696f74 	rsbeq	r6, r9, r4, ror pc
    1258:	6c727473 	cfldrdvs	mvd7, [r2], #-460	; 0xfffffe34
    125c:	63006e65 	movwvs	r6, #3685	; 0xe65
    1260:	61636e6f 	cmnvs	r3, pc, ror #28
    1264:	65640074 	strbvs	r0, [r4, #-116]!	; 0xffffff8c
    1268:	69007473 	stmdbvs	r0, {r0, r1, r4, r5, r6, sl, ip, sp, lr}
    126c:	7475706e 	ldrbtvc	r7, [r5], #-110	; 0xffffff92
    1270:	73616200 	cmnvc	r1, #0, 4
    1274:	74690065 	strbtvc	r0, [r9], #-101	; 0xffffff9b
    1278:	6900616f 	stmdbvs	r0, {r0, r1, r2, r3, r5, r6, r8, sp, lr}
    127c:	705f746e 	subsvc	r7, pc, lr, ror #8
    1280:	5f007274 	svcpl	0x00007274
    1284:	7a62355a 	bvc	188e7f4 <__bss_end+0x1884df0>
    1288:	506f7265 	rsbpl	r7, pc, r5, ror #4
    128c:	73006976 	movwvc	r6, #2422	; 0x976
    1290:	636e7274 	cmnvs	lr, #116, 4	; 0x40000007
    1294:	5f007970 	svcpl	0x00007970
    1298:	7473375a 	ldrbtvc	r3, [r3], #-1882	; 0xfffff8a6
    129c:	70636e72 	rsbvc	r6, r3, r2, ror lr
    12a0:	50635079 	rsbpl	r5, r3, r9, ror r0
    12a4:	0069634b 	rsbeq	r6, r9, fp, asr #6
    12a8:	5f746e69 	svcpl	0x00746e69
    12ac:	74726170 	ldrbtvc	r6, [r2], #-368	; 0xfffffe90
    12b0:	61726600 	cmnvs	r2, r0, lsl #12
    12b4:	6f697463 	svcvs	0x00697463
    12b8:	6964006e 	stmdbvs	r4!, {r1, r2, r3, r5, r6}^
    12bc:	00746967 	rsbseq	r6, r4, r7, ror #18
    12c0:	63365a5f 	teqvs	r6, #389120	; 0x5f000
    12c4:	61636e6f 	cmnvs	r3, pc, ror #28
    12c8:	50635074 	rsbpl	r5, r3, r4, ror r0
    12cc:	6d00634b 	stcvs	3, cr6, [r0, #-300]	; 0xfffffed4
    12d0:	73646d65 	cmnvc	r4, #6464	; 0x1940
    12d4:	68430074 	stmdavs	r3, {r2, r4, r5, r6}^
    12d8:	6f437261 	svcvs	0x00437261
    12dc:	7241766e 	subvc	r7, r1, #115343360	; 0x6e00000
    12e0:	74660072 	strbtvc	r0, [r6], #-114	; 0xffffff8e
    12e4:	6d00616f 	stfvss	f6, [r0, #-444]	; 0xfffffe44
    12e8:	72736d65 	rsbsvc	r6, r3, #6464	; 0x1940
    12ec:	7a620063 	bvc	1881480 <__bss_end+0x1877a7c>
    12f0:	006f7265 	rsbeq	r7, pc, r5, ror #4
    12f4:	636d656d 	cmnvs	sp, #457179136	; 0x1b400000
    12f8:	73007970 	movwvc	r7, #2416	; 0x970
    12fc:	636e7274 	cmnvs	lr, #116, 4	; 0x40000007
    1300:	6400706d 	strvs	r7, [r0], #-109	; 0xffffff93
    1304:	6d696365 	stclvs	3, cr6, [r9, #-404]!	; 0xfffffe6c
    1308:	705f6c61 	subsvc	r6, pc, r1, ror #24
    130c:	6563616c 	strbvs	r6, [r3, #-364]!	; 0xfffffe94
    1310:	5a5f0073 	bpl	17c14e4 <__bss_end+0x17b7ae0>
    1314:	6f746134 	svcvs	0x00746134
    1318:	634b5069 	movtvs	r5, #45161	; 0xb069
    131c:	74756f00 	ldrbtvc	r6, [r5], #-3840	; 0xfffff100
    1320:	00747570 	rsbseq	r7, r4, r0, ror r5
    1324:	66345a5f 			; <UNDEFINED> instruction: 0x66345a5f
    1328:	66616f74 	uqsub16vs	r6, r1, r4
    132c:	006a6350 	rsbeq	r6, sl, r0, asr r3
    1330:	73365a5f 	teqvc	r6, #389120	; 0x5f000
    1334:	656c7274 	strbvs	r7, [ip, #-628]!	; 0xfffffd8c
    1338:	634b506e 	movtvs	r5, #45166	; 0xb06e
    133c:	375a5f00 	ldrbcc	r5, [sl, -r0, lsl #30]
    1340:	6e727473 	mrcvs	4, 3, r7, cr2, cr3, {3}
    1344:	50706d63 	rsbspl	r6, r0, r3, ror #26
    1348:	3053634b 	subscc	r6, r3, fp, asr #6
    134c:	6900695f 	stmdbvs	r0, {r0, r1, r2, r3, r4, r6, r8, fp, sp, lr}
    1350:	735f746e 	cmpvc	pc, #1845493760	; 0x6e000000
    1354:	6d007274 	sfmvs	f7, 4, [r0, #-464]	; 0xfffffe30
    1358:	726f6d65 	rsbvc	r6, pc, #6464	; 0x1940
    135c:	656c0079 	strbvs	r0, [ip, #-121]!	; 0xffffff87
    1360:	6874676e 	ldmdavs	r4!, {r1, r2, r3, r5, r6, r8, r9, sl, sp, lr}^
    1364:	73552f00 	cmpvc	r5, #0, 30
    1368:	2f737265 	svccs	0x00737265
    136c:	746e6977 	strbtvc	r6, [lr], #-2423	; 0xfffff689
    1370:	696a7265 	stmdbvs	sl!, {r0, r2, r5, r6, r9, ip, sp, lr}^
    1374:	7365442f 	cmnvc	r5, #788529152	; 0x2f000000
    1378:	706f746b 	rsbvc	r7, pc, fp, ror #8
    137c:	5641462f 	strbpl	r4, [r1], -pc, lsr #12
    1380:	76614e2f 	strbtvc	r4, [r1], -pc, lsr #28
    1384:	6a757a61 	bvs	1d5fd10 <__bss_end+0x1d5630c>
    1388:	2f696369 	svccs	0x00696369
    138c:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
    1390:	73656d65 	cmnvc	r5, #6464	; 0x1940
    1394:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
    1398:	6b2d616b 	blvs	b5994c <__bss_end+0xb4ff48>
    139c:	6f2d7669 	svcvs	0x002d7669
    13a0:	6f732f73 	svcvs	0x00732f73
    13a4:	65637275 	strbvs	r7, [r3, #-629]!	; 0xfffffd8b
    13a8:	74732f73 	ldrbtvc	r2, [r3], #-3955	; 0xfffff08d
    13ac:	62696c64 	rsbvs	r6, r9, #100, 24	; 0x6400
    13b0:	6372732f 	cmnvs	r2, #-1140850688	; 0xbc000000
    13b4:	6474732f 	ldrbtvs	r7, [r4], #-815	; 0xfffffcd1
    13b8:	69727473 	ldmdbvs	r2!, {r0, r1, r4, r5, r6, sl, ip, sp, lr}^
    13bc:	632e676e 			; <UNDEFINED> instruction: 0x632e676e
    13c0:	Address 0x00000000000013c0 is out of bounds.


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
  20:	8b040e42 	blhi	103930 <__bss_end+0xf9f2c>
  24:	0b0d4201 	bleq	350830 <__bss_end+0x346e2c>
  28:	420d0d62 	andmi	r0, sp, #6272	; 0x1880
  2c:	00000ecb 	andeq	r0, r0, fp, asr #29
  30:	0000001c 	andeq	r0, r0, ip, lsl r0
  34:	00000000 	andeq	r0, r0, r0
  38:	00008064 	andeq	r8, r0, r4, rrx
  3c:	00000040 	andeq	r0, r0, r0, asr #32
  40:	8b080e42 	blhi	203950 <__bss_end+0x1f9f4c>
  44:	42018e02 	andmi	r8, r1, #2, 28
  48:	5a040b0c 	bpl	102c80 <__bss_end+0xf927c>
  4c:	00080d0c 	andeq	r0, r8, ip, lsl #26
  50:	0000000c 	andeq	r0, r0, ip
  54:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
  58:	7c020001 	stcvc	0, cr0, [r2], {1}
  5c:	000d0c0e 	andeq	r0, sp, lr, lsl #24
  60:	0000001c 	andeq	r0, r0, ip, lsl r0
  64:	00000050 	andeq	r0, r0, r0, asr r0
  68:	000080a4 	andeq	r8, r0, r4, lsr #1
  6c:	00000038 	andeq	r0, r0, r8, lsr r0
  70:	8b040e42 	blhi	103980 <__bss_end+0xf9f7c>
  74:	0b0d4201 	bleq	350880 <__bss_end+0x346e7c>
  78:	420d0d54 	andmi	r0, sp, #84, 26	; 0x1500
  7c:	00000ecb 	andeq	r0, r0, fp, asr #29
  80:	0000001c 	andeq	r0, r0, ip, lsl r0
  84:	00000050 	andeq	r0, r0, r0, asr r0
  88:	000080dc 	ldrdeq	r8, [r0], -ip
  8c:	0000002c 	andeq	r0, r0, ip, lsr #32
  90:	8b040e42 	blhi	1039a0 <__bss_end+0xf9f9c>
  94:	0b0d4201 	bleq	3508a0 <__bss_end+0x346e9c>
  98:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
  9c:	00000ecb 	andeq	r0, r0, fp, asr #29
  a0:	0000001c 	andeq	r0, r0, ip, lsl r0
  a4:	00000050 	andeq	r0, r0, r0, asr r0
  a8:	00008108 	andeq	r8, r0, r8, lsl #2
  ac:	00000020 	andeq	r0, r0, r0, lsr #32
  b0:	8b040e42 	blhi	1039c0 <__bss_end+0xf9fbc>
  b4:	0b0d4201 	bleq	3508c0 <__bss_end+0x346ebc>
  b8:	420d0d48 	andmi	r0, sp, #72, 26	; 0x1200
  bc:	00000ecb 	andeq	r0, r0, fp, asr #29
  c0:	0000001c 	andeq	r0, r0, ip, lsl r0
  c4:	00000050 	andeq	r0, r0, r0, asr r0
  c8:	00008128 	andeq	r8, r0, r8, lsr #2
  cc:	00000018 	andeq	r0, r0, r8, lsl r0
  d0:	8b040e42 	blhi	1039e0 <__bss_end+0xf9fdc>
  d4:	0b0d4201 	bleq	3508e0 <__bss_end+0x346edc>
  d8:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
  dc:	00000ecb 	andeq	r0, r0, fp, asr #29
  e0:	0000001c 	andeq	r0, r0, ip, lsl r0
  e4:	00000050 	andeq	r0, r0, r0, asr r0
  e8:	00008140 	andeq	r8, r0, r0, asr #2
  ec:	00000018 	andeq	r0, r0, r8, lsl r0
  f0:	8b040e42 	blhi	103a00 <__bss_end+0xf9ffc>
  f4:	0b0d4201 	bleq	350900 <__bss_end+0x346efc>
  f8:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
  fc:	00000ecb 	andeq	r0, r0, fp, asr #29
 100:	0000001c 	andeq	r0, r0, ip, lsl r0
 104:	00000050 	andeq	r0, r0, r0, asr r0
 108:	00008158 	andeq	r8, r0, r8, asr r1
 10c:	00000018 	andeq	r0, r0, r8, lsl r0
 110:	8b040e42 	blhi	103a20 <__bss_end+0xfa01c>
 114:	0b0d4201 	bleq	350920 <__bss_end+0x346f1c>
 118:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
 11c:	00000ecb 	andeq	r0, r0, fp, asr #29
 120:	00000014 	andeq	r0, r0, r4, lsl r0
 124:	00000050 	andeq	r0, r0, r0, asr r0
 128:	00008170 	andeq	r8, r0, r0, ror r1
 12c:	0000000c 	andeq	r0, r0, ip
 130:	8b040e42 	blhi	103a40 <__bss_end+0xfa03c>
 134:	0b0d4201 	bleq	350940 <__bss_end+0x346f3c>
 138:	0000001c 	andeq	r0, r0, ip, lsl r0
 13c:	00000050 	andeq	r0, r0, r0, asr r0
 140:	0000817c 	andeq	r8, r0, ip, ror r1
 144:	00000058 	andeq	r0, r0, r8, asr r0
 148:	8b080e42 	blhi	203a58 <__bss_end+0x1fa054>
 14c:	42018e02 	andmi	r8, r1, #2, 28
 150:	62040b0c 	andvs	r0, r4, #12, 22	; 0x3000
 154:	00080d0c 	andeq	r0, r8, ip, lsl #26
 158:	0000001c 	andeq	r0, r0, ip, lsl r0
 15c:	00000050 	andeq	r0, r0, r0, asr r0
 160:	000081d4 	ldrdeq	r8, [r0], -r4
 164:	00000058 	andeq	r0, r0, r8, asr r0
 168:	8b080e42 	blhi	203a78 <__bss_end+0x1fa074>
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
 1a0:	0b0c4201 	bleq	3109ac <__bss_end+0x306fa8>
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
 1cc:	0b0c4201 	bleq	3109d8 <__bss_end+0x306fd4>
 1d0:	0c6c0204 	sfmeq	f0, 2, [ip], #-16
 1d4:	00001c0d 	andeq	r1, r0, sp, lsl #24
 1d8:	00000020 	andeq	r0, r0, r0, lsr #32
 1dc:	00000178 	andeq	r0, r0, r8, ror r1
 1e0:	000083c0 	andeq	r8, r0, r0, asr #7
 1e4:	00000074 	andeq	r0, r0, r4, ror r0
 1e8:	840c0e42 	strhi	r0, [ip], #-3650	; 0xfffff1be
 1ec:	8e028b03 	vmlahi.f64	d8, d2, d3
 1f0:	0b0c4201 	bleq	3109fc <__bss_end+0x306ff8>
 1f4:	0d0c7204 	sfmeq	f7, 4, [ip, #-16]
 1f8:	0000000c 	andeq	r0, r0, ip
 1fc:	0000001c 	andeq	r0, r0, ip, lsl r0
 200:	00000178 	andeq	r0, r0, r8, ror r1
 204:	00008434 	andeq	r8, r0, r4, lsr r4
 208:	000000fc 	strdeq	r0, [r0], -ip
 20c:	8b080e42 	blhi	203b1c <__bss_end+0x1fa118>
 210:	42018e02 	andmi	r8, r1, #2, 28
 214:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 218:	080d0c6e 	stmdaeq	sp, {r1, r2, r3, r5, r6, sl, fp}
 21c:	0000001c 	andeq	r0, r0, ip, lsl r0
 220:	00000178 	andeq	r0, r0, r8, ror r1
 224:	00008530 	andeq	r8, r0, r0, lsr r5
 228:	000000a4 	andeq	r0, r0, r4, lsr #1
 22c:	8b080e42 	blhi	203b3c <__bss_end+0x1fa138>
 230:	42018e02 	andmi	r8, r1, #2, 28
 234:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 238:	080d0c48 	stmdaeq	sp, {r3, r6, sl, fp}
 23c:	0000001c 	andeq	r0, r0, ip, lsl r0
 240:	00000178 	andeq	r0, r0, r8, ror r1
 244:	000085d4 	ldrdeq	r8, [r0], -r4
 248:	000000f8 	strdeq	r0, [r0], -r8
 24c:	8b080e42 	blhi	203b5c <__bss_end+0x1fa158>
 250:	42018e02 	andmi	r8, r1, #2, 28
 254:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 258:	080d0c70 	stmdaeq	sp, {r4, r5, r6, sl, fp}
 25c:	0000001c 	andeq	r0, r0, ip, lsl r0
 260:	00000178 	andeq	r0, r0, r8, ror r1
 264:	000086cc 	andeq	r8, r0, ip, asr #13
 268:	000001d0 	ldrdeq	r0, [r0], -r0	; <UNPREDICTABLE>
 26c:	8b080e42 	blhi	203b7c <__bss_end+0x1fa178>
 270:	42018e02 	andmi	r8, r1, #2, 28
 274:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 278:	080d0cd4 	stmdaeq	sp, {r2, r4, r6, r7, sl, fp}
 27c:	0000001c 	andeq	r0, r0, ip, lsl r0
 280:	00000178 	andeq	r0, r0, r8, ror r1
 284:	0000889c 	muleq	r0, ip, r8
 288:	00000150 	andeq	r0, r0, r0, asr r1
 28c:	8b080e42 	blhi	203b9c <__bss_end+0x1fa198>
 290:	42018e02 	andmi	r8, r1, #2, 28
 294:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 298:	080d0c90 	stmdaeq	sp, {r4, r7, sl, fp}
 29c:	0000000c 	andeq	r0, r0, ip
 2a0:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 2a4:	7c020001 	stcvc	0, cr0, [r2], {1}
 2a8:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 2ac:	0000001c 	andeq	r0, r0, ip, lsl r0
 2b0:	0000029c 	muleq	r0, ip, r2
 2b4:	000089ec 	andeq	r8, r0, ip, ror #19
 2b8:	0000002c 	andeq	r0, r0, ip, lsr #32
 2bc:	8b040e42 	blhi	103bcc <__bss_end+0xfa1c8>
 2c0:	0b0d4201 	bleq	350acc <__bss_end+0x3470c8>
 2c4:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
 2c8:	00000ecb 	andeq	r0, r0, fp, asr #29
 2cc:	0000001c 	andeq	r0, r0, ip, lsl r0
 2d0:	0000029c 	muleq	r0, ip, r2
 2d4:	00008a18 	andeq	r8, r0, r8, lsl sl
 2d8:	0000002c 	andeq	r0, r0, ip, lsr #32
 2dc:	8b040e42 	blhi	103bec <__bss_end+0xfa1e8>
 2e0:	0b0d4201 	bleq	350aec <__bss_end+0x3470e8>
 2e4:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
 2e8:	00000ecb 	andeq	r0, r0, fp, asr #29
 2ec:	0000001c 	andeq	r0, r0, ip, lsl r0
 2f0:	0000029c 	muleq	r0, ip, r2
 2f4:	00008a44 	andeq	r8, r0, r4, asr #20
 2f8:	0000001c 	andeq	r0, r0, ip, lsl r0
 2fc:	8b040e42 	blhi	103c0c <__bss_end+0xfa208>
 300:	0b0d4201 	bleq	350b0c <__bss_end+0x347108>
 304:	420d0d46 	andmi	r0, sp, #4480	; 0x1180
 308:	00000ecb 	andeq	r0, r0, fp, asr #29
 30c:	0000001c 	andeq	r0, r0, ip, lsl r0
 310:	0000029c 	muleq	r0, ip, r2
 314:	00008a60 	andeq	r8, r0, r0, ror #20
 318:	00000044 	andeq	r0, r0, r4, asr #32
 31c:	8b040e42 	blhi	103c2c <__bss_end+0xfa228>
 320:	0b0d4201 	bleq	350b2c <__bss_end+0x347128>
 324:	420d0d5a 	andmi	r0, sp, #5760	; 0x1680
 328:	00000ecb 	andeq	r0, r0, fp, asr #29
 32c:	0000001c 	andeq	r0, r0, ip, lsl r0
 330:	0000029c 	muleq	r0, ip, r2
 334:	00008aa4 	andeq	r8, r0, r4, lsr #21
 338:	00000050 	andeq	r0, r0, r0, asr r0
 33c:	8b040e42 	blhi	103c4c <__bss_end+0xfa248>
 340:	0b0d4201 	bleq	350b4c <__bss_end+0x347148>
 344:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 348:	00000ecb 	andeq	r0, r0, fp, asr #29
 34c:	0000001c 	andeq	r0, r0, ip, lsl r0
 350:	0000029c 	muleq	r0, ip, r2
 354:	00008af4 	strdeq	r8, [r0], -r4
 358:	00000050 	andeq	r0, r0, r0, asr r0
 35c:	8b040e42 	blhi	103c6c <__bss_end+0xfa268>
 360:	0b0d4201 	bleq	350b6c <__bss_end+0x347168>
 364:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 368:	00000ecb 	andeq	r0, r0, fp, asr #29
 36c:	0000001c 	andeq	r0, r0, ip, lsl r0
 370:	0000029c 	muleq	r0, ip, r2
 374:	00008b44 	andeq	r8, r0, r4, asr #22
 378:	0000002c 	andeq	r0, r0, ip, lsr #32
 37c:	8b040e42 	blhi	103c8c <__bss_end+0xfa288>
 380:	0b0d4201 	bleq	350b8c <__bss_end+0x347188>
 384:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
 388:	00000ecb 	andeq	r0, r0, fp, asr #29
 38c:	0000001c 	andeq	r0, r0, ip, lsl r0
 390:	0000029c 	muleq	r0, ip, r2
 394:	00008b70 	andeq	r8, r0, r0, ror fp
 398:	00000050 	andeq	r0, r0, r0, asr r0
 39c:	8b040e42 	blhi	103cac <__bss_end+0xfa2a8>
 3a0:	0b0d4201 	bleq	350bac <__bss_end+0x3471a8>
 3a4:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 3a8:	00000ecb 	andeq	r0, r0, fp, asr #29
 3ac:	0000001c 	andeq	r0, r0, ip, lsl r0
 3b0:	0000029c 	muleq	r0, ip, r2
 3b4:	00008bc0 	andeq	r8, r0, r0, asr #23
 3b8:	00000044 	andeq	r0, r0, r4, asr #32
 3bc:	8b040e42 	blhi	103ccc <__bss_end+0xfa2c8>
 3c0:	0b0d4201 	bleq	350bcc <__bss_end+0x3471c8>
 3c4:	420d0d5a 	andmi	r0, sp, #5760	; 0x1680
 3c8:	00000ecb 	andeq	r0, r0, fp, asr #29
 3cc:	0000001c 	andeq	r0, r0, ip, lsl r0
 3d0:	0000029c 	muleq	r0, ip, r2
 3d4:	00008c04 	andeq	r8, r0, r4, lsl #24
 3d8:	00000050 	andeq	r0, r0, r0, asr r0
 3dc:	8b040e42 	blhi	103cec <__bss_end+0xfa2e8>
 3e0:	0b0d4201 	bleq	350bec <__bss_end+0x3471e8>
 3e4:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 3e8:	00000ecb 	andeq	r0, r0, fp, asr #29
 3ec:	0000001c 	andeq	r0, r0, ip, lsl r0
 3f0:	0000029c 	muleq	r0, ip, r2
 3f4:	00008c54 	andeq	r8, r0, r4, asr ip
 3f8:	00000054 	andeq	r0, r0, r4, asr r0
 3fc:	8b040e42 	blhi	103d0c <__bss_end+0xfa308>
 400:	0b0d4201 	bleq	350c0c <__bss_end+0x347208>
 404:	420d0d62 	andmi	r0, sp, #6272	; 0x1880
 408:	00000ecb 	andeq	r0, r0, fp, asr #29
 40c:	0000001c 	andeq	r0, r0, ip, lsl r0
 410:	0000029c 	muleq	r0, ip, r2
 414:	00008ca8 	andeq	r8, r0, r8, lsr #25
 418:	0000003c 	andeq	r0, r0, ip, lsr r0
 41c:	8b040e42 	blhi	103d2c <__bss_end+0xfa328>
 420:	0b0d4201 	bleq	350c2c <__bss_end+0x347228>
 424:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 428:	00000ecb 	andeq	r0, r0, fp, asr #29
 42c:	0000001c 	andeq	r0, r0, ip, lsl r0
 430:	0000029c 	muleq	r0, ip, r2
 434:	00008ce4 	andeq	r8, r0, r4, ror #25
 438:	0000003c 	andeq	r0, r0, ip, lsr r0
 43c:	8b040e42 	blhi	103d4c <__bss_end+0xfa348>
 440:	0b0d4201 	bleq	350c4c <__bss_end+0x347248>
 444:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 448:	00000ecb 	andeq	r0, r0, fp, asr #29
 44c:	0000001c 	andeq	r0, r0, ip, lsl r0
 450:	0000029c 	muleq	r0, ip, r2
 454:	00008d20 	andeq	r8, r0, r0, lsr #26
 458:	0000003c 	andeq	r0, r0, ip, lsr r0
 45c:	8b040e42 	blhi	103d6c <__bss_end+0xfa368>
 460:	0b0d4201 	bleq	350c6c <__bss_end+0x347268>
 464:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 468:	00000ecb 	andeq	r0, r0, fp, asr #29
 46c:	0000001c 	andeq	r0, r0, ip, lsl r0
 470:	0000029c 	muleq	r0, ip, r2
 474:	00008d5c 	andeq	r8, r0, ip, asr sp
 478:	0000003c 	andeq	r0, r0, ip, lsr r0
 47c:	8b040e42 	blhi	103d8c <__bss_end+0xfa388>
 480:	0b0d4201 	bleq	350c8c <__bss_end+0x347288>
 484:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 488:	00000ecb 	andeq	r0, r0, fp, asr #29
 48c:	0000001c 	andeq	r0, r0, ip, lsl r0
 490:	0000029c 	muleq	r0, ip, r2
 494:	00008d98 	muleq	r0, r8, sp
 498:	000000b0 	strheq	r0, [r0], -r0	; <UNPREDICTABLE>
 49c:	8b080e42 	blhi	203dac <__bss_end+0x1fa3a8>
 4a0:	42018e02 	andmi	r8, r1, #2, 28
 4a4:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 4a8:	080d0c50 	stmdaeq	sp, {r4, r6, sl, fp}
 4ac:	0000000c 	andeq	r0, r0, ip
 4b0:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 4b4:	7c020001 	stcvc	0, cr0, [r2], {1}
 4b8:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 4bc:	0000001c 	andeq	r0, r0, ip, lsl r0
 4c0:	000004ac 	andeq	r0, r0, ip, lsr #9
 4c4:	00008e48 	andeq	r8, r0, r8, asr #28
 4c8:	00000174 	andeq	r0, r0, r4, ror r1
 4cc:	8b080e42 	blhi	203ddc <__bss_end+0x1fa3d8>
 4d0:	42018e02 	andmi	r8, r1, #2, 28
 4d4:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 4d8:	080d0cb2 	stmdaeq	sp, {r1, r4, r5, r7, sl, fp}
 4dc:	0000001c 	andeq	r0, r0, ip, lsl r0
 4e0:	000004ac 	andeq	r0, r0, ip, lsr #9
 4e4:	00008fbc 			; <UNDEFINED> instruction: 0x00008fbc
 4e8:	0000009c 	muleq	r0, ip, r0
 4ec:	8b040e42 	blhi	103dfc <__bss_end+0xfa3f8>
 4f0:	0b0d4201 	bleq	350cfc <__bss_end+0x3472f8>
 4f4:	0d0d4602 	stceq	6, cr4, [sp, #-8]
 4f8:	000ecb42 	andeq	ip, lr, r2, asr #22
 4fc:	00000020 	andeq	r0, r0, r0, lsr #32
 500:	000004ac 	andeq	r0, r0, ip, lsr #9
 504:	00009058 	andeq	r9, r0, r8, asr r0
 508:	00000294 	muleq	r0, r4, r2
 50c:	8b040e42 	blhi	103e1c <__bss_end+0xfa418>
 510:	0b0d4201 	bleq	350d1c <__bss_end+0x347318>
 514:	0d013e03 	stceq	14, cr3, [r1, #-12]
 518:	0ecb420d 	cdpeq	2, 12, cr4, cr11, cr13, {0}
 51c:	00000000 	andeq	r0, r0, r0
 520:	0000001c 	andeq	r0, r0, ip, lsl r0
 524:	000004ac 	andeq	r0, r0, ip, lsr #9
 528:	000092ec 	andeq	r9, r0, ip, ror #5
 52c:	000000c0 	andeq	r0, r0, r0, asr #1
 530:	8b040e42 	blhi	103e40 <__bss_end+0xfa43c>
 534:	0b0d4201 	bleq	350d40 <__bss_end+0x34733c>
 538:	0d0d5802 	stceq	8, cr5, [sp, #-8]
 53c:	000ecb42 	andeq	ip, lr, r2, asr #22
 540:	0000001c 	andeq	r0, r0, ip, lsl r0
 544:	000004ac 	andeq	r0, r0, ip, lsr #9
 548:	000093ac 	andeq	r9, r0, ip, lsr #7
 54c:	000000ac 	andeq	r0, r0, ip, lsr #1
 550:	8b040e42 	blhi	103e60 <__bss_end+0xfa45c>
 554:	0b0d4201 	bleq	350d60 <__bss_end+0x34735c>
 558:	0d0d4e02 	stceq	14, cr4, [sp, #-8]
 55c:	000ecb42 	andeq	ip, lr, r2, asr #22
 560:	0000001c 	andeq	r0, r0, ip, lsl r0
 564:	000004ac 	andeq	r0, r0, ip, lsr #9
 568:	00009458 	andeq	r9, r0, r8, asr r4
 56c:	00000054 	andeq	r0, r0, r4, asr r0
 570:	8b040e42 	blhi	103e80 <__bss_end+0xfa47c>
 574:	0b0d4201 	bleq	350d80 <__bss_end+0x34737c>
 578:	420d0d62 	andmi	r0, sp, #6272	; 0x1880
 57c:	00000ecb 	andeq	r0, r0, fp, asr #29
 580:	0000001c 	andeq	r0, r0, ip, lsl r0
 584:	000004ac 	andeq	r0, r0, ip, lsr #9
 588:	000094ac 	andeq	r9, r0, ip, lsr #9
 58c:	00000068 	andeq	r0, r0, r8, rrx
 590:	8b040e42 	blhi	103ea0 <__bss_end+0xfa49c>
 594:	0b0d4201 	bleq	350da0 <__bss_end+0x34739c>
 598:	420d0d6c 	andmi	r0, sp, #108, 26	; 0x1b00
 59c:	00000ecb 	andeq	r0, r0, fp, asr #29
 5a0:	0000001c 	andeq	r0, r0, ip, lsl r0
 5a4:	000004ac 	andeq	r0, r0, ip, lsr #9
 5a8:	00009514 	andeq	r9, r0, r4, lsl r5
 5ac:	00000080 	andeq	r0, r0, r0, lsl #1
 5b0:	8b040e42 	blhi	103ec0 <__bss_end+0xfa4bc>
 5b4:	0b0d4201 	bleq	350dc0 <__bss_end+0x3473bc>
 5b8:	420d0d78 	andmi	r0, sp, #120, 26	; 0x1e00
 5bc:	00000ecb 	andeq	r0, r0, fp, asr #29
 5c0:	0000001c 	andeq	r0, r0, ip, lsl r0
 5c4:	000004ac 	andeq	r0, r0, ip, lsr #9
 5c8:	00009594 	muleq	r0, r4, r5
 5cc:	00000074 	andeq	r0, r0, r4, ror r0
 5d0:	8b080e42 	blhi	203ee0 <__bss_end+0x1fa4dc>
 5d4:	42018e02 	andmi	r8, r1, #2, 28
 5d8:	74040b0c 	strvc	r0, [r4], #-2828	; 0xfffff4f4
 5dc:	00080d0c 	andeq	r0, r8, ip, lsl #26
 5e0:	0000000c 	andeq	r0, r0, ip
 5e4:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 5e8:	7c010001 	stcvc	0, cr0, [r1], {1}
 5ec:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 5f0:	0000000c 	andeq	r0, r0, ip
 5f4:	000005e0 	andeq	r0, r0, r0, ror #11
 5f8:	00009608 	andeq	r9, r0, r8, lsl #12
 5fc:	000001ec 	andeq	r0, r0, ip, ror #3
