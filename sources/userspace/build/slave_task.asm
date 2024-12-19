
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
    805c:	00008f84 	andeq	r8, r0, r4, lsl #31
    8060:	00008f9c 	muleq	r0, ip, pc	; <UNPREDICTABLE>

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
    8080:	eb00007a 	bl	8270 <main>
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
    81cc:	00008f81 	andeq	r8, r0, r1, lsl #31
    81d0:	00008f81 	andeq	r8, r0, r1, lsl #31

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
    8224:	00008f81 	andeq	r8, r0, r1, lsl #31
    8228:	00008f81 	andeq	r8, r0, r1, lsl #31

0000822c <_Z3logPKc>:
_Z3logPKc():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:20
constexpr uint32_t char_tick_delay = 0x1000;

uint32_t log_fd, slave;

void log(const char* msg)
{
    822c:	e92d4810 	push	{r4, fp, lr}
    8230:	e28db008 	add	fp, sp, #8
    8234:	e24dd00c 	sub	sp, sp, #12
    8238:	e50b0010 	str	r0, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:21
    write(log_fd, msg, strlen(msg));
    823c:	e59f3028 	ldr	r3, [pc, #40]	; 826c <_Z3logPKc+0x40>
    8240:	e5934000 	ldr	r4, [r3]
    8244:	e51b0010 	ldr	r0, [fp, #-16]
    8248:	eb00022c 	bl	8b00 <_Z6strlenPKc>
    824c:	e1a03000 	mov	r3, r0
    8250:	e1a02003 	mov	r2, r3
    8254:	e51b1010 	ldr	r1, [fp, #-16]
    8258:	e1a00004 	mov	r0, r4
    825c:	eb000073 	bl	8430 <_Z5writejPKcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:22
}
    8260:	e320f000 	nop	{0}
    8264:	e24bd008 	sub	sp, fp, #8
    8268:	e8bd8810 	pop	{r4, fp, pc}
    826c:	00008f84 	andeq	r8, r0, r4, lsl #31

00008270 <main>:
main():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:51
//     itoa(rndNum, temp_buff, 10);
//     write(uart, temp_buff, strlen(temp_buff));
// }

int main(int argc, char** argv)
{
    8270:	e92d4800 	push	{fp, lr}
    8274:	e28db004 	add	fp, sp, #4
    8278:	e24dd010 	sub	sp, sp, #16
    827c:	e50b0010 	str	r0, [fp, #-16]
    8280:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:54
    char buff[4];

    log_fd = pipe("log", 32);
    8284:	e3a01020 	mov	r1, #32
    8288:	e59f0078 	ldr	r0, [pc, #120]	; 8308 <main+0x98>
    828c:	eb000110 	bl	86d4 <_Z4pipePKcj>
    8290:	e1a03000 	mov	r3, r0
    8294:	e59f2070 	ldr	r2, [pc, #112]	; 830c <main+0x9c>
    8298:	e5823000 	str	r3, [r2]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:56

    log("Slave task started\n");
    829c:	e59f006c 	ldr	r0, [pc, #108]	; 8310 <main+0xa0>
    82a0:	ebffffe1 	bl	822c <_Z3logPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:59

    // start i2c connection
    slave = open("DEV:i2c/2", NFile_Open_Mode::Read_Write);
    82a4:	e3a01002 	mov	r1, #2
    82a8:	e59f0064 	ldr	r0, [pc, #100]	; 8314 <main+0xa4>
    82ac:	eb00003a 	bl	839c <_Z4openPKc15NFile_Open_Mode>
    82b0:	e1a03000 	mov	r3, r0
    82b4:	e59f205c 	ldr	r2, [pc, #92]	; 8318 <main+0xa8>
    82b8:	e5823000 	str	r3, [r2]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:60
    if (slave == Invalid_Handle) {
    82bc:	e59f3054 	ldr	r3, [pc, #84]	; 8318 <main+0xa8>
    82c0:	e5933000 	ldr	r3, [r3]
    82c4:	e3730001 	cmn	r3, #1
    82c8:	1a000003 	bne	82dc <main+0x6c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:61
        log("Error opening I2C slave connection\n");
    82cc:	e59f0048 	ldr	r0, [pc, #72]	; 831c <main+0xac>
    82d0:	ebffffd5 	bl	822c <_Z3logPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:62
        return 1;
    82d4:	e3a03001 	mov	r3, #1
    82d8:	ea000007 	b	82fc <main+0x8c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:64
    }
    log("I2C connection slave started...\n");
    82dc:	e59f003c 	ldr	r0, [pc, #60]	; 8320 <main+0xb0>
    82e0:	ebffffd1 	bl	822c <_Z3logPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:66 (discriminator 1)
    for (;;) {
        log("Hello from slave\n");
    82e4:	e59f0038 	ldr	r0, [pc, #56]	; 8324 <main+0xb4>
    82e8:	ebffffcf 	bl	822c <_Z3logPKc>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:67 (discriminator 1)
        sleep(0x10000);
    82ec:	e3e01001 	mvn	r1, #1
    82f0:	e3a00801 	mov	r0, #65536	; 0x10000
    82f4:	eb0000a5 	bl	8590 <_Z5sleepjj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:66 (discriminator 1)
        log("Hello from slave\n");
    82f8:	eafffff9 	b	82e4 <main+0x74>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:75 (discriminator 1)
    close(slave);
    log("Open files closed in slave\n");
    close(log_fd);

    return 0;
}
    82fc:	e1a00003 	mov	r0, r3
    8300:	e24bd004 	sub	sp, fp, #4
    8304:	e8bd8800 	pop	{fp, pc}
    8308:	00008eb8 			; <UNDEFINED> instruction: 0x00008eb8
    830c:	00008f84 	andeq	r8, r0, r4, lsl #31
    8310:	00008ebc 			; <UNDEFINED> instruction: 0x00008ebc
    8314:	00008ed0 	ldrdeq	r8, [r0], -r0
    8318:	00008f88 	andeq	r8, r0, r8, lsl #31
    831c:	00008edc 	ldrdeq	r8, [r0], -ip
    8320:	00008f00 	andeq	r8, r0, r0, lsl #30
    8324:	00008f24 	andeq	r8, r0, r4, lsr #30

00008328 <_Z6getpidv>:
_Z6getpidv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:5
#include <stdfile.h>
#include <stdstring.h>

uint32_t getpid()
{
    8328:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    832c:	e28db000 	add	fp, sp, #0
    8330:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:8
    uint32_t pid;

    asm volatile("swi 0");
    8334:	ef000000 	svc	0x00000000
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:9
    asm volatile("mov %0, r0" : "=r" (pid));
    8338:	e1a03000 	mov	r3, r0
    833c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:11

    return pid;
    8340:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:12
}
    8344:	e1a00003 	mov	r0, r3
    8348:	e28bd000 	add	sp, fp, #0
    834c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8350:	e12fff1e 	bx	lr

00008354 <_Z9terminatei>:
_Z9terminatei():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:15

void terminate(int exitcode)
{
    8354:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8358:	e28db000 	add	fp, sp, #0
    835c:	e24dd00c 	sub	sp, sp, #12
    8360:	e50b0008 	str	r0, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:16
    asm volatile("mov r0, %0" : : "r" (exitcode));
    8364:	e51b3008 	ldr	r3, [fp, #-8]
    8368:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:17
    asm volatile("swi 1");
    836c:	ef000001 	svc	0x00000001
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:18
}
    8370:	e320f000 	nop	{0}
    8374:	e28bd000 	add	sp, fp, #0
    8378:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    837c:	e12fff1e 	bx	lr

00008380 <_Z11sched_yieldv>:
_Z11sched_yieldv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:21

void sched_yield()
{
    8380:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8384:	e28db000 	add	fp, sp, #0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:22
    asm volatile("swi 2");
    8388:	ef000002 	svc	0x00000002
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:23
}
    838c:	e320f000 	nop	{0}
    8390:	e28bd000 	add	sp, fp, #0
    8394:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8398:	e12fff1e 	bx	lr

0000839c <_Z4openPKc15NFile_Open_Mode>:
_Z4openPKc15NFile_Open_Mode():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:26

uint32_t open(const char* filename, NFile_Open_Mode mode)
{
    839c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    83a0:	e28db000 	add	fp, sp, #0
    83a4:	e24dd014 	sub	sp, sp, #20
    83a8:	e50b0010 	str	r0, [fp, #-16]
    83ac:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:29
    uint32_t file;

    asm volatile("mov r0, %0" : : "r" (filename));
    83b0:	e51b3010 	ldr	r3, [fp, #-16]
    83b4:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:30
    asm volatile("mov r1, %0" : : "r" (mode));
    83b8:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    83bc:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:31
    asm volatile("swi 64");
    83c0:	ef000040 	svc	0x00000040
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:32
    asm volatile("mov %0, r0" : "=r" (file));
    83c4:	e1a03000 	mov	r3, r0
    83c8:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:33
    return file;
    83cc:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:34
}
    83d0:	e1a00003 	mov	r0, r3
    83d4:	e28bd000 	add	sp, fp, #0
    83d8:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    83dc:	e12fff1e 	bx	lr

000083e0 <_Z4readjPcj>:
_Z4readjPcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:37

uint32_t read(uint32_t file, char* const buffer, uint32_t size)
{
    83e0:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    83e4:	e28db000 	add	fp, sp, #0
    83e8:	e24dd01c 	sub	sp, sp, #28
    83ec:	e50b0010 	str	r0, [fp, #-16]
    83f0:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    83f4:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:40
    uint32_t rdnum;

    asm volatile("mov r0, %0" : : "r" (file));
    83f8:	e51b3010 	ldr	r3, [fp, #-16]
    83fc:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:41
    asm volatile("mov r1, %0" : : "r" (buffer));
    8400:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8404:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:42
    asm volatile("mov r2, %0" : : "r" (size));
    8408:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    840c:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:43
    asm volatile("swi 65");
    8410:	ef000041 	svc	0x00000041
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:44
    asm volatile("mov %0, r0" : "=r" (rdnum));
    8414:	e1a03000 	mov	r3, r0
    8418:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:46

    return rdnum;
    841c:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:47
}
    8420:	e1a00003 	mov	r0, r3
    8424:	e28bd000 	add	sp, fp, #0
    8428:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    842c:	e12fff1e 	bx	lr

00008430 <_Z5writejPKcj>:
_Z5writejPKcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:50

uint32_t write(uint32_t file, const char* buffer, uint32_t size)
{
    8430:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8434:	e28db000 	add	fp, sp, #0
    8438:	e24dd01c 	sub	sp, sp, #28
    843c:	e50b0010 	str	r0, [fp, #-16]
    8440:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8444:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:53
    uint32_t wrnum;

    asm volatile("mov r0, %0" : : "r" (file));
    8448:	e51b3010 	ldr	r3, [fp, #-16]
    844c:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:54
    asm volatile("mov r1, %0" : : "r" (buffer));
    8450:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8454:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:55
    asm volatile("mov r2, %0" : : "r" (size));
    8458:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    845c:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:56
    asm volatile("swi 66");
    8460:	ef000042 	svc	0x00000042
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:57
    asm volatile("mov %0, r0" : "=r" (wrnum));
    8464:	e1a03000 	mov	r3, r0
    8468:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:59

    return wrnum;
    846c:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:60
}
    8470:	e1a00003 	mov	r0, r3
    8474:	e28bd000 	add	sp, fp, #0
    8478:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    847c:	e12fff1e 	bx	lr

00008480 <_Z5closej>:
_Z5closej():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:63

void close(uint32_t file)
{
    8480:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8484:	e28db000 	add	fp, sp, #0
    8488:	e24dd00c 	sub	sp, sp, #12
    848c:	e50b0008 	str	r0, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:64
    asm volatile("mov r0, %0" : : "r" (file));
    8490:	e51b3008 	ldr	r3, [fp, #-8]
    8494:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:65
    asm volatile("swi 67");
    8498:	ef000043 	svc	0x00000043
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:66
}
    849c:	e320f000 	nop	{0}
    84a0:	e28bd000 	add	sp, fp, #0
    84a4:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    84a8:	e12fff1e 	bx	lr

000084ac <_Z5ioctlj16NIOCtl_OperationPv>:
_Z5ioctlj16NIOCtl_OperationPv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:69

uint32_t ioctl(uint32_t file, NIOCtl_Operation operation, void* param)
{
    84ac:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    84b0:	e28db000 	add	fp, sp, #0
    84b4:	e24dd01c 	sub	sp, sp, #28
    84b8:	e50b0010 	str	r0, [fp, #-16]
    84bc:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    84c0:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:72
    uint32_t retcode;

    asm volatile("mov r0, %0" : : "r" (file));
    84c4:	e51b3010 	ldr	r3, [fp, #-16]
    84c8:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:73
    asm volatile("mov r1, %0" : : "r" (operation));
    84cc:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    84d0:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:74
    asm volatile("mov r2, %0" : : "r" (param));
    84d4:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    84d8:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:75
    asm volatile("swi 68");
    84dc:	ef000044 	svc	0x00000044
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:76
    asm volatile("mov %0, r0" : "=r" (retcode));
    84e0:	e1a03000 	mov	r3, r0
    84e4:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:78

    return retcode;
    84e8:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:79
}
    84ec:	e1a00003 	mov	r0, r3
    84f0:	e28bd000 	add	sp, fp, #0
    84f4:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    84f8:	e12fff1e 	bx	lr

000084fc <_Z6notifyjj>:
_Z6notifyjj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:82

uint32_t notify(uint32_t file, uint32_t count)
{
    84fc:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8500:	e28db000 	add	fp, sp, #0
    8504:	e24dd014 	sub	sp, sp, #20
    8508:	e50b0010 	str	r0, [fp, #-16]
    850c:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:85
    uint32_t retcnt;

    asm volatile("mov r0, %0" : : "r" (file));
    8510:	e51b3010 	ldr	r3, [fp, #-16]
    8514:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:86
    asm volatile("mov r1, %0" : : "r" (count));
    8518:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    851c:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:87
    asm volatile("swi 69");
    8520:	ef000045 	svc	0x00000045
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:88
    asm volatile("mov %0, r0" : "=r" (retcnt));
    8524:	e1a03000 	mov	r3, r0
    8528:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:90

    return retcnt;
    852c:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:91
}
    8530:	e1a00003 	mov	r0, r3
    8534:	e28bd000 	add	sp, fp, #0
    8538:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    853c:	e12fff1e 	bx	lr

00008540 <_Z4waitjjj>:
_Z4waitjjj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:94

NSWI_Result_Code wait(uint32_t file, uint32_t count, uint32_t notified_deadline)
{
    8540:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8544:	e28db000 	add	fp, sp, #0
    8548:	e24dd01c 	sub	sp, sp, #28
    854c:	e50b0010 	str	r0, [fp, #-16]
    8550:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8554:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:97
    NSWI_Result_Code retcode;

    asm volatile("mov r0, %0" : : "r" (file));
    8558:	e51b3010 	ldr	r3, [fp, #-16]
    855c:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:98
    asm volatile("mov r1, %0" : : "r" (count));
    8560:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8564:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:99
    asm volatile("mov r2, %0" : : "r" (notified_deadline));
    8568:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    856c:	e1a02003 	mov	r2, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:100
    asm volatile("swi 70");
    8570:	ef000046 	svc	0x00000046
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:101
    asm volatile("mov %0, r0" : "=r" (retcode));
    8574:	e1a03000 	mov	r3, r0
    8578:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:103

    return retcode;
    857c:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:104
}
    8580:	e1a00003 	mov	r0, r3
    8584:	e28bd000 	add	sp, fp, #0
    8588:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    858c:	e12fff1e 	bx	lr

00008590 <_Z5sleepjj>:
_Z5sleepjj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:107

bool sleep(uint32_t ticks, uint32_t notified_deadline)
{
    8590:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8594:	e28db000 	add	fp, sp, #0
    8598:	e24dd014 	sub	sp, sp, #20
    859c:	e50b0010 	str	r0, [fp, #-16]
    85a0:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:110
    uint32_t retcode;

    asm volatile("mov r0, %0" : : "r" (ticks));
    85a4:	e51b3010 	ldr	r3, [fp, #-16]
    85a8:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:111
    asm volatile("mov r1, %0" : : "r" (notified_deadline));
    85ac:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    85b0:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:112
    asm volatile("swi 3");
    85b4:	ef000003 	svc	0x00000003
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:113
    asm volatile("mov %0, r0" : "=r" (retcode));
    85b8:	e1a03000 	mov	r3, r0
    85bc:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:115

    return retcode;
    85c0:	e51b3008 	ldr	r3, [fp, #-8]
    85c4:	e3530000 	cmp	r3, #0
    85c8:	13a03001 	movne	r3, #1
    85cc:	03a03000 	moveq	r3, #0
    85d0:	e6ef3073 	uxtb	r3, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:116
}
    85d4:	e1a00003 	mov	r0, r3
    85d8:	e28bd000 	add	sp, fp, #0
    85dc:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    85e0:	e12fff1e 	bx	lr

000085e4 <_Z24get_active_process_countv>:
_Z24get_active_process_countv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:119

uint32_t get_active_process_count()
{
    85e4:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    85e8:	e28db000 	add	fp, sp, #0
    85ec:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:120
    const NGet_Sched_Info_Type req = NGet_Sched_Info_Type::Active_Process_Count;
    85f0:	e3a03000 	mov	r3, #0
    85f4:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:123
    uint32_t retval;

    asm volatile("mov r0, %0" : : "r" (req));
    85f8:	e3a03000 	mov	r3, #0
    85fc:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:124
    asm volatile("mov r1, %0" : : "r" (&retval));
    8600:	e24b300c 	sub	r3, fp, #12
    8604:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:125
    asm volatile("swi 4");
    8608:	ef000004 	svc	0x00000004
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:127

    return retval;
    860c:	e51b300c 	ldr	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:128
}
    8610:	e1a00003 	mov	r0, r3
    8614:	e28bd000 	add	sp, fp, #0
    8618:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    861c:	e12fff1e 	bx	lr

00008620 <_Z14get_tick_countv>:
_Z14get_tick_countv():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:131

uint32_t get_tick_count()
{
    8620:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8624:	e28db000 	add	fp, sp, #0
    8628:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:132
    const NGet_Sched_Info_Type req = NGet_Sched_Info_Type::Tick_Count;
    862c:	e3a03001 	mov	r3, #1
    8630:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:135
    uint32_t retval;

    asm volatile("mov r0, %0" : : "r" (req));
    8634:	e3a03001 	mov	r3, #1
    8638:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:136
    asm volatile("mov r1, %0" : : "r" (&retval));
    863c:	e24b300c 	sub	r3, fp, #12
    8640:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:137
    asm volatile("swi 4");
    8644:	ef000004 	svc	0x00000004
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:139

    return retval;
    8648:	e51b300c 	ldr	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:140
}
    864c:	e1a00003 	mov	r0, r3
    8650:	e28bd000 	add	sp, fp, #0
    8654:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8658:	e12fff1e 	bx	lr

0000865c <_Z17set_task_deadlinej>:
_Z17set_task_deadlinej():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:143

void set_task_deadline(uint32_t tick_count_required)
{
    865c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8660:	e28db000 	add	fp, sp, #0
    8664:	e24dd014 	sub	sp, sp, #20
    8668:	e50b0010 	str	r0, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:144
    const NDeadline_Subservice req = NDeadline_Subservice::Set_Relative;
    866c:	e3a03000 	mov	r3, #0
    8670:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:146

    asm volatile("mov r0, %0" : : "r" (req));
    8674:	e3a03000 	mov	r3, #0
    8678:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:147
    asm volatile("mov r1, %0" : : "r" (&tick_count_required));
    867c:	e24b3010 	sub	r3, fp, #16
    8680:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:148
    asm volatile("swi 5");
    8684:	ef000005 	svc	0x00000005
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:149
}
    8688:	e320f000 	nop	{0}
    868c:	e28bd000 	add	sp, fp, #0
    8690:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8694:	e12fff1e 	bx	lr

00008698 <_Z26get_task_ticks_to_deadlinev>:
_Z26get_task_ticks_to_deadlinev():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:152

uint32_t get_task_ticks_to_deadline()
{
    8698:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    869c:	e28db000 	add	fp, sp, #0
    86a0:	e24dd00c 	sub	sp, sp, #12
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:153
    const NDeadline_Subservice req = NDeadline_Subservice::Get_Remaining;
    86a4:	e3a03001 	mov	r3, #1
    86a8:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:156
    uint32_t ticks;

    asm volatile("mov r0, %0" : : "r" (req));
    86ac:	e3a03001 	mov	r3, #1
    86b0:	e1a00003 	mov	r0, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:157
    asm volatile("mov r1, %0" : : "r" (&ticks));
    86b4:	e24b300c 	sub	r3, fp, #12
    86b8:	e1a01003 	mov	r1, r3
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:158
    asm volatile("swi 5");
    86bc:	ef000005 	svc	0x00000005
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:160

    return ticks;
    86c0:	e51b300c 	ldr	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:161
}
    86c4:	e1a00003 	mov	r0, r3
    86c8:	e28bd000 	add	sp, fp, #0
    86cc:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    86d0:	e12fff1e 	bx	lr

000086d4 <_Z4pipePKcj>:
_Z4pipePKcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:166

const char Pipe_File_Prefix[] = "SYS:pipe/";

uint32_t pipe(const char* name, uint32_t buf_size)
{
    86d4:	e92d4800 	push	{fp, lr}
    86d8:	e28db004 	add	fp, sp, #4
    86dc:	e24dd050 	sub	sp, sp, #80	; 0x50
    86e0:	e50b0050 	str	r0, [fp, #-80]	; 0xffffffb0
    86e4:	e50b1054 	str	r1, [fp, #-84]	; 0xffffffac
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:168
    char fname[64];
    strncpy(fname, Pipe_File_Prefix, sizeof(Pipe_File_Prefix));
    86e8:	e24b3048 	sub	r3, fp, #72	; 0x48
    86ec:	e3a0200a 	mov	r2, #10
    86f0:	e59f1088 	ldr	r1, [pc, #136]	; 8780 <_Z4pipePKcj+0xac>
    86f4:	e1a00003 	mov	r0, r3
    86f8:	eb0000a5 	bl	8994 <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:169
    strncpy(fname + sizeof(Pipe_File_Prefix), name, sizeof(fname) - sizeof(Pipe_File_Prefix) - 1);
    86fc:	e24b3048 	sub	r3, fp, #72	; 0x48
    8700:	e283300a 	add	r3, r3, #10
    8704:	e3a02035 	mov	r2, #53	; 0x35
    8708:	e51b1050 	ldr	r1, [fp, #-80]	; 0xffffffb0
    870c:	e1a00003 	mov	r0, r3
    8710:	eb00009f 	bl	8994 <_Z7strncpyPcPKci>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:171

    int ncur = sizeof(Pipe_File_Prefix) + strlen(name);
    8714:	e51b0050 	ldr	r0, [fp, #-80]	; 0xffffffb0
    8718:	eb0000f8 	bl	8b00 <_Z6strlenPKc>
    871c:	e1a03000 	mov	r3, r0
    8720:	e283300a 	add	r3, r3, #10
    8724:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:173

    fname[ncur++] = '#';
    8728:	e51b3008 	ldr	r3, [fp, #-8]
    872c:	e2832001 	add	r2, r3, #1
    8730:	e50b2008 	str	r2, [fp, #-8]
    8734:	e2433004 	sub	r3, r3, #4
    8738:	e083300b 	add	r3, r3, fp
    873c:	e3a02023 	mov	r2, #35	; 0x23
    8740:	e5432044 	strb	r2, [r3, #-68]	; 0xffffffbc
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:175

    itoa(buf_size, &fname[ncur], 10);
    8744:	e24b2048 	sub	r2, fp, #72	; 0x48
    8748:	e51b3008 	ldr	r3, [fp, #-8]
    874c:	e0823003 	add	r3, r2, r3
    8750:	e3a0200a 	mov	r2, #10
    8754:	e1a01003 	mov	r1, r3
    8758:	e51b0054 	ldr	r0, [fp, #-84]	; 0xffffffac
    875c:	eb000008 	bl	8784 <_Z4itoajPcj>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:177

    return open(fname, NFile_Open_Mode::Read_Write);
    8760:	e24b3048 	sub	r3, fp, #72	; 0x48
    8764:	e3a01002 	mov	r1, #2
    8768:	e1a00003 	mov	r0, r3
    876c:	ebffff0a 	bl	839c <_Z4openPKc15NFile_Open_Mode>
    8770:	e1a03000 	mov	r3, r0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdfile.cpp:178
}
    8774:	e1a00003 	mov	r0, r3
    8778:	e24bd004 	sub	sp, fp, #4
    877c:	e8bd8800 	pop	{fp, pc}
    8780:	00008f64 	andeq	r8, r0, r4, ror #30

00008784 <_Z4itoajPcj>:
_Z4itoajPcj():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:9
{
    const char CharConvArr[] = "0123456789ABCDEF";
}

void itoa(unsigned int input, char* output, unsigned int base)
{
    8784:	e92d4800 	push	{fp, lr}
    8788:	e28db004 	add	fp, sp, #4
    878c:	e24dd020 	sub	sp, sp, #32
    8790:	e50b0018 	str	r0, [fp, #-24]	; 0xffffffe8
    8794:	e50b101c 	str	r1, [fp, #-28]	; 0xffffffe4
    8798:	e50b2020 	str	r2, [fp, #-32]	; 0xffffffe0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:10
	int i = 0;
    879c:	e3a03000 	mov	r3, #0
    87a0:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:12

	while (input > 0)
    87a4:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    87a8:	e3530000 	cmp	r3, #0
    87ac:	0a000014 	beq	8804 <_Z4itoajPcj+0x80>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:14
	{
		output[i] = CharConvArr[input % base];
    87b0:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    87b4:	e51b1020 	ldr	r1, [fp, #-32]	; 0xffffffe0
    87b8:	e1a00003 	mov	r0, r3
    87bc:	eb000199 	bl	8e28 <__aeabi_uidivmod>
    87c0:	e1a03001 	mov	r3, r1
    87c4:	e1a01003 	mov	r1, r3
    87c8:	e51b3008 	ldr	r3, [fp, #-8]
    87cc:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    87d0:	e0823003 	add	r3, r2, r3
    87d4:	e59f2118 	ldr	r2, [pc, #280]	; 88f4 <_Z4itoajPcj+0x170>
    87d8:	e7d22001 	ldrb	r2, [r2, r1]
    87dc:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:15
		input /= base;
    87e0:	e51b1020 	ldr	r1, [fp, #-32]	; 0xffffffe0
    87e4:	e51b0018 	ldr	r0, [fp, #-24]	; 0xffffffe8
    87e8:	eb000113 	bl	8c3c <__udivsi3>
    87ec:	e1a03000 	mov	r3, r0
    87f0:	e50b3018 	str	r3, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:16
		i++;
    87f4:	e51b3008 	ldr	r3, [fp, #-8]
    87f8:	e2833001 	add	r3, r3, #1
    87fc:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:12
	while (input > 0)
    8800:	eaffffe7 	b	87a4 <_Z4itoajPcj+0x20>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:19
	}

    if (i == 0)
    8804:	e51b3008 	ldr	r3, [fp, #-8]
    8808:	e3530000 	cmp	r3, #0
    880c:	1a000007 	bne	8830 <_Z4itoajPcj+0xac>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:21
    {
        output[i] = CharConvArr[0];
    8810:	e51b3008 	ldr	r3, [fp, #-8]
    8814:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    8818:	e0823003 	add	r3, r2, r3
    881c:	e3a02030 	mov	r2, #48	; 0x30
    8820:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:22
        i++;
    8824:	e51b3008 	ldr	r3, [fp, #-8]
    8828:	e2833001 	add	r3, r3, #1
    882c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:25
    }

	output[i] = '\0';
    8830:	e51b3008 	ldr	r3, [fp, #-8]
    8834:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    8838:	e0823003 	add	r3, r2, r3
    883c:	e3a02000 	mov	r2, #0
    8840:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:26
	i--;
    8844:	e51b3008 	ldr	r3, [fp, #-8]
    8848:	e2433001 	sub	r3, r3, #1
    884c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:28

	for (int j = 0; j <= i/2; j++)
    8850:	e3a03000 	mov	r3, #0
    8854:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:28 (discriminator 3)
    8858:	e51b3008 	ldr	r3, [fp, #-8]
    885c:	e1a02fa3 	lsr	r2, r3, #31
    8860:	e0823003 	add	r3, r2, r3
    8864:	e1a030c3 	asr	r3, r3, #1
    8868:	e1a02003 	mov	r2, r3
    886c:	e51b300c 	ldr	r3, [fp, #-12]
    8870:	e1530002 	cmp	r3, r2
    8874:	ca00001b 	bgt	88e8 <_Z4itoajPcj+0x164>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:30 (discriminator 2)
	{
		char c = output[i - j];
    8878:	e51b2008 	ldr	r2, [fp, #-8]
    887c:	e51b300c 	ldr	r3, [fp, #-12]
    8880:	e0423003 	sub	r3, r2, r3
    8884:	e1a02003 	mov	r2, r3
    8888:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    888c:	e0833002 	add	r3, r3, r2
    8890:	e5d33000 	ldrb	r3, [r3]
    8894:	e54b300d 	strb	r3, [fp, #-13]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:31 (discriminator 2)
		output[i - j] = output[j];
    8898:	e51b300c 	ldr	r3, [fp, #-12]
    889c:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    88a0:	e0822003 	add	r2, r2, r3
    88a4:	e51b1008 	ldr	r1, [fp, #-8]
    88a8:	e51b300c 	ldr	r3, [fp, #-12]
    88ac:	e0413003 	sub	r3, r1, r3
    88b0:	e1a01003 	mov	r1, r3
    88b4:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    88b8:	e0833001 	add	r3, r3, r1
    88bc:	e5d22000 	ldrb	r2, [r2]
    88c0:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:32 (discriminator 2)
		output[j] = c;
    88c4:	e51b300c 	ldr	r3, [fp, #-12]
    88c8:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    88cc:	e0823003 	add	r3, r2, r3
    88d0:	e55b200d 	ldrb	r2, [fp, #-13]
    88d4:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:28 (discriminator 2)
	for (int j = 0; j <= i/2; j++)
    88d8:	e51b300c 	ldr	r3, [fp, #-12]
    88dc:	e2833001 	add	r3, r3, #1
    88e0:	e50b300c 	str	r3, [fp, #-12]
    88e4:	eaffffdb 	b	8858 <_Z4itoajPcj+0xd4>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:34
	}
}
    88e8:	e320f000 	nop	{0}
    88ec:	e24bd004 	sub	sp, fp, #4
    88f0:	e8bd8800 	pop	{fp, pc}
    88f4:	00008f70 	andeq	r8, r0, r0, ror pc

000088f8 <_Z4atoiPKc>:
_Z4atoiPKc():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:37

int atoi(const char* input)
{
    88f8:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    88fc:	e28db000 	add	fp, sp, #0
    8900:	e24dd014 	sub	sp, sp, #20
    8904:	e50b0010 	str	r0, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:38
	int output = 0;
    8908:	e3a03000 	mov	r3, #0
    890c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:40

	while (*input != '\0')
    8910:	e51b3010 	ldr	r3, [fp, #-16]
    8914:	e5d33000 	ldrb	r3, [r3]
    8918:	e3530000 	cmp	r3, #0
    891c:	0a000017 	beq	8980 <_Z4atoiPKc+0x88>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:42
	{
		output *= 10;
    8920:	e51b2008 	ldr	r2, [fp, #-8]
    8924:	e1a03002 	mov	r3, r2
    8928:	e1a03103 	lsl	r3, r3, #2
    892c:	e0833002 	add	r3, r3, r2
    8930:	e1a03083 	lsl	r3, r3, #1
    8934:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:43
		if (*input > '9' || *input < '0')
    8938:	e51b3010 	ldr	r3, [fp, #-16]
    893c:	e5d33000 	ldrb	r3, [r3]
    8940:	e3530039 	cmp	r3, #57	; 0x39
    8944:	8a00000d 	bhi	8980 <_Z4atoiPKc+0x88>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:43 (discriminator 1)
    8948:	e51b3010 	ldr	r3, [fp, #-16]
    894c:	e5d33000 	ldrb	r3, [r3]
    8950:	e353002f 	cmp	r3, #47	; 0x2f
    8954:	9a000009 	bls	8980 <_Z4atoiPKc+0x88>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:46
			break;

		output += *input - '0';
    8958:	e51b3010 	ldr	r3, [fp, #-16]
    895c:	e5d33000 	ldrb	r3, [r3]
    8960:	e2433030 	sub	r3, r3, #48	; 0x30
    8964:	e51b2008 	ldr	r2, [fp, #-8]
    8968:	e0823003 	add	r3, r2, r3
    896c:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:48

		input++;
    8970:	e51b3010 	ldr	r3, [fp, #-16]
    8974:	e2833001 	add	r3, r3, #1
    8978:	e50b3010 	str	r3, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:40
	while (*input != '\0')
    897c:	eaffffe3 	b	8910 <_Z4atoiPKc+0x18>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:51
	}

	return output;
    8980:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:52
}
    8984:	e1a00003 	mov	r0, r3
    8988:	e28bd000 	add	sp, fp, #0
    898c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8990:	e12fff1e 	bx	lr

00008994 <_Z7strncpyPcPKci>:
_Z7strncpyPcPKci():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:55

char* strncpy(char* dest, const char *src, int num)
{
    8994:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8998:	e28db000 	add	fp, sp, #0
    899c:	e24dd01c 	sub	sp, sp, #28
    89a0:	e50b0010 	str	r0, [fp, #-16]
    89a4:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    89a8:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:58
	int i;

	for (i = 0; i < num && src[i] != '\0'; i++)
    89ac:	e3a03000 	mov	r3, #0
    89b0:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:58 (discriminator 4)
    89b4:	e51b2008 	ldr	r2, [fp, #-8]
    89b8:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    89bc:	e1520003 	cmp	r2, r3
    89c0:	aa000011 	bge	8a0c <_Z7strncpyPcPKci+0x78>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:58 (discriminator 2)
    89c4:	e51b3008 	ldr	r3, [fp, #-8]
    89c8:	e51b2014 	ldr	r2, [fp, #-20]	; 0xffffffec
    89cc:	e0823003 	add	r3, r2, r3
    89d0:	e5d33000 	ldrb	r3, [r3]
    89d4:	e3530000 	cmp	r3, #0
    89d8:	0a00000b 	beq	8a0c <_Z7strncpyPcPKci+0x78>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:59 (discriminator 3)
		dest[i] = src[i];
    89dc:	e51b3008 	ldr	r3, [fp, #-8]
    89e0:	e51b2014 	ldr	r2, [fp, #-20]	; 0xffffffec
    89e4:	e0822003 	add	r2, r2, r3
    89e8:	e51b3008 	ldr	r3, [fp, #-8]
    89ec:	e51b1010 	ldr	r1, [fp, #-16]
    89f0:	e0813003 	add	r3, r1, r3
    89f4:	e5d22000 	ldrb	r2, [r2]
    89f8:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:58 (discriminator 3)
	for (i = 0; i < num && src[i] != '\0'; i++)
    89fc:	e51b3008 	ldr	r3, [fp, #-8]
    8a00:	e2833001 	add	r3, r3, #1
    8a04:	e50b3008 	str	r3, [fp, #-8]
    8a08:	eaffffe9 	b	89b4 <_Z7strncpyPcPKci+0x20>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:60 (discriminator 2)
	for (; i < num; i++)
    8a0c:	e51b2008 	ldr	r2, [fp, #-8]
    8a10:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8a14:	e1520003 	cmp	r2, r3
    8a18:	aa000008 	bge	8a40 <_Z7strncpyPcPKci+0xac>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:61 (discriminator 1)
		dest[i] = '\0';
    8a1c:	e51b3008 	ldr	r3, [fp, #-8]
    8a20:	e51b2010 	ldr	r2, [fp, #-16]
    8a24:	e0823003 	add	r3, r2, r3
    8a28:	e3a02000 	mov	r2, #0
    8a2c:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:60 (discriminator 1)
	for (; i < num; i++)
    8a30:	e51b3008 	ldr	r3, [fp, #-8]
    8a34:	e2833001 	add	r3, r3, #1
    8a38:	e50b3008 	str	r3, [fp, #-8]
    8a3c:	eafffff2 	b	8a0c <_Z7strncpyPcPKci+0x78>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:63

   return dest;
    8a40:	e51b3010 	ldr	r3, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:64
}
    8a44:	e1a00003 	mov	r0, r3
    8a48:	e28bd000 	add	sp, fp, #0
    8a4c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8a50:	e12fff1e 	bx	lr

00008a54 <_Z7strncmpPKcS0_i>:
_Z7strncmpPKcS0_i():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:67

int strncmp(const char *s1, const char *s2, int num)
{
    8a54:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8a58:	e28db000 	add	fp, sp, #0
    8a5c:	e24dd01c 	sub	sp, sp, #28
    8a60:	e50b0010 	str	r0, [fp, #-16]
    8a64:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8a68:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:69
	unsigned char u1, u2;
  	while (num-- > 0)
    8a6c:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8a70:	e2432001 	sub	r2, r3, #1
    8a74:	e50b2018 	str	r2, [fp, #-24]	; 0xffffffe8
    8a78:	e3530000 	cmp	r3, #0
    8a7c:	c3a03001 	movgt	r3, #1
    8a80:	d3a03000 	movle	r3, #0
    8a84:	e6ef3073 	uxtb	r3, r3
    8a88:	e3530000 	cmp	r3, #0
    8a8c:	0a000016 	beq	8aec <_Z7strncmpPKcS0_i+0x98>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:71
    {
      	u1 = (unsigned char) *s1++;
    8a90:	e51b3010 	ldr	r3, [fp, #-16]
    8a94:	e2832001 	add	r2, r3, #1
    8a98:	e50b2010 	str	r2, [fp, #-16]
    8a9c:	e5d33000 	ldrb	r3, [r3]
    8aa0:	e54b3005 	strb	r3, [fp, #-5]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:72
     	u2 = (unsigned char) *s2++;
    8aa4:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8aa8:	e2832001 	add	r2, r3, #1
    8aac:	e50b2014 	str	r2, [fp, #-20]	; 0xffffffec
    8ab0:	e5d33000 	ldrb	r3, [r3]
    8ab4:	e54b3006 	strb	r3, [fp, #-6]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:73
      	if (u1 != u2)
    8ab8:	e55b2005 	ldrb	r2, [fp, #-5]
    8abc:	e55b3006 	ldrb	r3, [fp, #-6]
    8ac0:	e1520003 	cmp	r2, r3
    8ac4:	0a000003 	beq	8ad8 <_Z7strncmpPKcS0_i+0x84>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:74
        	return u1 - u2;
    8ac8:	e55b2005 	ldrb	r2, [fp, #-5]
    8acc:	e55b3006 	ldrb	r3, [fp, #-6]
    8ad0:	e0423003 	sub	r3, r2, r3
    8ad4:	ea000005 	b	8af0 <_Z7strncmpPKcS0_i+0x9c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:75
      	if (u1 == '\0')
    8ad8:	e55b3005 	ldrb	r3, [fp, #-5]
    8adc:	e3530000 	cmp	r3, #0
    8ae0:	1affffe1 	bne	8a6c <_Z7strncmpPKcS0_i+0x18>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:76
        	return 0;
    8ae4:	e3a03000 	mov	r3, #0
    8ae8:	ea000000 	b	8af0 <_Z7strncmpPKcS0_i+0x9c>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:79
    }

  	return 0;
    8aec:	e3a03000 	mov	r3, #0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:80
}
    8af0:	e1a00003 	mov	r0, r3
    8af4:	e28bd000 	add	sp, fp, #0
    8af8:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8afc:	e12fff1e 	bx	lr

00008b00 <_Z6strlenPKc>:
_Z6strlenPKc():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:83

int strlen(const char* s)
{
    8b00:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8b04:	e28db000 	add	fp, sp, #0
    8b08:	e24dd014 	sub	sp, sp, #20
    8b0c:	e50b0010 	str	r0, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:84
	int i = 0;
    8b10:	e3a03000 	mov	r3, #0
    8b14:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:86

	while (s[i] != '\0')
    8b18:	e51b3008 	ldr	r3, [fp, #-8]
    8b1c:	e51b2010 	ldr	r2, [fp, #-16]
    8b20:	e0823003 	add	r3, r2, r3
    8b24:	e5d33000 	ldrb	r3, [r3]
    8b28:	e3530000 	cmp	r3, #0
    8b2c:	0a000003 	beq	8b40 <_Z6strlenPKc+0x40>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:87
		i++;
    8b30:	e51b3008 	ldr	r3, [fp, #-8]
    8b34:	e2833001 	add	r3, r3, #1
    8b38:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:86
	while (s[i] != '\0')
    8b3c:	eafffff5 	b	8b18 <_Z6strlenPKc+0x18>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:89

	return i;
    8b40:	e51b3008 	ldr	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:90
}
    8b44:	e1a00003 	mov	r0, r3
    8b48:	e28bd000 	add	sp, fp, #0
    8b4c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8b50:	e12fff1e 	bx	lr

00008b54 <_Z5bzeroPvi>:
_Z5bzeroPvi():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:93

void bzero(void* memory, int length)
{
    8b54:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8b58:	e28db000 	add	fp, sp, #0
    8b5c:	e24dd014 	sub	sp, sp, #20
    8b60:	e50b0010 	str	r0, [fp, #-16]
    8b64:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:94
	char* mem = reinterpret_cast<char*>(memory);
    8b68:	e51b3010 	ldr	r3, [fp, #-16]
    8b6c:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:96

	for (int i = 0; i < length; i++)
    8b70:	e3a03000 	mov	r3, #0
    8b74:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:96 (discriminator 3)
    8b78:	e51b2008 	ldr	r2, [fp, #-8]
    8b7c:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8b80:	e1520003 	cmp	r2, r3
    8b84:	aa000008 	bge	8bac <_Z5bzeroPvi+0x58>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:97 (discriminator 2)
		mem[i] = 0;
    8b88:	e51b3008 	ldr	r3, [fp, #-8]
    8b8c:	e51b200c 	ldr	r2, [fp, #-12]
    8b90:	e0823003 	add	r3, r2, r3
    8b94:	e3a02000 	mov	r2, #0
    8b98:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:96 (discriminator 2)
	for (int i = 0; i < length; i++)
    8b9c:	e51b3008 	ldr	r3, [fp, #-8]
    8ba0:	e2833001 	add	r3, r3, #1
    8ba4:	e50b3008 	str	r3, [fp, #-8]
    8ba8:	eafffff2 	b	8b78 <_Z5bzeroPvi+0x24>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:98
}
    8bac:	e320f000 	nop	{0}
    8bb0:	e28bd000 	add	sp, fp, #0
    8bb4:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8bb8:	e12fff1e 	bx	lr

00008bbc <_Z6memcpyPKvPvi>:
_Z6memcpyPKvPvi():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:101

void memcpy(const void* src, void* dst, int num)
{
    8bbc:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8bc0:	e28db000 	add	fp, sp, #0
    8bc4:	e24dd024 	sub	sp, sp, #36	; 0x24
    8bc8:	e50b0018 	str	r0, [fp, #-24]	; 0xffffffe8
    8bcc:	e50b101c 	str	r1, [fp, #-28]	; 0xffffffe4
    8bd0:	e50b2020 	str	r2, [fp, #-32]	; 0xffffffe0
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:102
	const char* memsrc = reinterpret_cast<const char*>(src);
    8bd4:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8bd8:	e50b300c 	str	r3, [fp, #-12]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:103
	char* memdst = reinterpret_cast<char*>(dst);
    8bdc:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    8be0:	e50b3010 	str	r3, [fp, #-16]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:105

	for (int i = 0; i < num; i++)
    8be4:	e3a03000 	mov	r3, #0
    8be8:	e50b3008 	str	r3, [fp, #-8]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:105 (discriminator 3)
    8bec:	e51b2008 	ldr	r2, [fp, #-8]
    8bf0:	e51b3020 	ldr	r3, [fp, #-32]	; 0xffffffe0
    8bf4:	e1520003 	cmp	r2, r3
    8bf8:	aa00000b 	bge	8c2c <_Z6memcpyPKvPvi+0x70>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:106 (discriminator 2)
		memdst[i] = memsrc[i];
    8bfc:	e51b3008 	ldr	r3, [fp, #-8]
    8c00:	e51b200c 	ldr	r2, [fp, #-12]
    8c04:	e0822003 	add	r2, r2, r3
    8c08:	e51b3008 	ldr	r3, [fp, #-8]
    8c0c:	e51b1010 	ldr	r1, [fp, #-16]
    8c10:	e0813003 	add	r3, r1, r3
    8c14:	e5d22000 	ldrb	r2, [r2]
    8c18:	e5c32000 	strb	r2, [r3]
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:105 (discriminator 2)
	for (int i = 0; i < num; i++)
    8c1c:	e51b3008 	ldr	r3, [fp, #-8]
    8c20:	e2833001 	add	r3, r3, #1
    8c24:	e50b3008 	str	r3, [fp, #-8]
    8c28:	eaffffef 	b	8bec <_Z6memcpyPKvPvi+0x30>
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/stdlib/src/stdstring.cpp:107
}
    8c2c:	e320f000 	nop	{0}
    8c30:	e28bd000 	add	sp, fp, #0
    8c34:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8c38:	e12fff1e 	bx	lr

00008c3c <__udivsi3>:
__udivsi3():
    8c3c:	e2512001 	subs	r2, r1, #1
    8c40:	012fff1e 	bxeq	lr
    8c44:	3a000074 	bcc	8e1c <__udivsi3+0x1e0>
    8c48:	e1500001 	cmp	r0, r1
    8c4c:	9a00006b 	bls	8e00 <__udivsi3+0x1c4>
    8c50:	e1110002 	tst	r1, r2
    8c54:	0a00006c 	beq	8e0c <__udivsi3+0x1d0>
    8c58:	e16f3f10 	clz	r3, r0
    8c5c:	e16f2f11 	clz	r2, r1
    8c60:	e0423003 	sub	r3, r2, r3
    8c64:	e273301f 	rsbs	r3, r3, #31
    8c68:	10833083 	addne	r3, r3, r3, lsl #1
    8c6c:	e3a02000 	mov	r2, #0
    8c70:	108ff103 	addne	pc, pc, r3, lsl #2
    8c74:	e1a00000 	nop			; (mov r0, r0)
    8c78:	e1500f81 	cmp	r0, r1, lsl #31
    8c7c:	e0a22002 	adc	r2, r2, r2
    8c80:	20400f81 	subcs	r0, r0, r1, lsl #31
    8c84:	e1500f01 	cmp	r0, r1, lsl #30
    8c88:	e0a22002 	adc	r2, r2, r2
    8c8c:	20400f01 	subcs	r0, r0, r1, lsl #30
    8c90:	e1500e81 	cmp	r0, r1, lsl #29
    8c94:	e0a22002 	adc	r2, r2, r2
    8c98:	20400e81 	subcs	r0, r0, r1, lsl #29
    8c9c:	e1500e01 	cmp	r0, r1, lsl #28
    8ca0:	e0a22002 	adc	r2, r2, r2
    8ca4:	20400e01 	subcs	r0, r0, r1, lsl #28
    8ca8:	e1500d81 	cmp	r0, r1, lsl #27
    8cac:	e0a22002 	adc	r2, r2, r2
    8cb0:	20400d81 	subcs	r0, r0, r1, lsl #27
    8cb4:	e1500d01 	cmp	r0, r1, lsl #26
    8cb8:	e0a22002 	adc	r2, r2, r2
    8cbc:	20400d01 	subcs	r0, r0, r1, lsl #26
    8cc0:	e1500c81 	cmp	r0, r1, lsl #25
    8cc4:	e0a22002 	adc	r2, r2, r2
    8cc8:	20400c81 	subcs	r0, r0, r1, lsl #25
    8ccc:	e1500c01 	cmp	r0, r1, lsl #24
    8cd0:	e0a22002 	adc	r2, r2, r2
    8cd4:	20400c01 	subcs	r0, r0, r1, lsl #24
    8cd8:	e1500b81 	cmp	r0, r1, lsl #23
    8cdc:	e0a22002 	adc	r2, r2, r2
    8ce0:	20400b81 	subcs	r0, r0, r1, lsl #23
    8ce4:	e1500b01 	cmp	r0, r1, lsl #22
    8ce8:	e0a22002 	adc	r2, r2, r2
    8cec:	20400b01 	subcs	r0, r0, r1, lsl #22
    8cf0:	e1500a81 	cmp	r0, r1, lsl #21
    8cf4:	e0a22002 	adc	r2, r2, r2
    8cf8:	20400a81 	subcs	r0, r0, r1, lsl #21
    8cfc:	e1500a01 	cmp	r0, r1, lsl #20
    8d00:	e0a22002 	adc	r2, r2, r2
    8d04:	20400a01 	subcs	r0, r0, r1, lsl #20
    8d08:	e1500981 	cmp	r0, r1, lsl #19
    8d0c:	e0a22002 	adc	r2, r2, r2
    8d10:	20400981 	subcs	r0, r0, r1, lsl #19
    8d14:	e1500901 	cmp	r0, r1, lsl #18
    8d18:	e0a22002 	adc	r2, r2, r2
    8d1c:	20400901 	subcs	r0, r0, r1, lsl #18
    8d20:	e1500881 	cmp	r0, r1, lsl #17
    8d24:	e0a22002 	adc	r2, r2, r2
    8d28:	20400881 	subcs	r0, r0, r1, lsl #17
    8d2c:	e1500801 	cmp	r0, r1, lsl #16
    8d30:	e0a22002 	adc	r2, r2, r2
    8d34:	20400801 	subcs	r0, r0, r1, lsl #16
    8d38:	e1500781 	cmp	r0, r1, lsl #15
    8d3c:	e0a22002 	adc	r2, r2, r2
    8d40:	20400781 	subcs	r0, r0, r1, lsl #15
    8d44:	e1500701 	cmp	r0, r1, lsl #14
    8d48:	e0a22002 	adc	r2, r2, r2
    8d4c:	20400701 	subcs	r0, r0, r1, lsl #14
    8d50:	e1500681 	cmp	r0, r1, lsl #13
    8d54:	e0a22002 	adc	r2, r2, r2
    8d58:	20400681 	subcs	r0, r0, r1, lsl #13
    8d5c:	e1500601 	cmp	r0, r1, lsl #12
    8d60:	e0a22002 	adc	r2, r2, r2
    8d64:	20400601 	subcs	r0, r0, r1, lsl #12
    8d68:	e1500581 	cmp	r0, r1, lsl #11
    8d6c:	e0a22002 	adc	r2, r2, r2
    8d70:	20400581 	subcs	r0, r0, r1, lsl #11
    8d74:	e1500501 	cmp	r0, r1, lsl #10
    8d78:	e0a22002 	adc	r2, r2, r2
    8d7c:	20400501 	subcs	r0, r0, r1, lsl #10
    8d80:	e1500481 	cmp	r0, r1, lsl #9
    8d84:	e0a22002 	adc	r2, r2, r2
    8d88:	20400481 	subcs	r0, r0, r1, lsl #9
    8d8c:	e1500401 	cmp	r0, r1, lsl #8
    8d90:	e0a22002 	adc	r2, r2, r2
    8d94:	20400401 	subcs	r0, r0, r1, lsl #8
    8d98:	e1500381 	cmp	r0, r1, lsl #7
    8d9c:	e0a22002 	adc	r2, r2, r2
    8da0:	20400381 	subcs	r0, r0, r1, lsl #7
    8da4:	e1500301 	cmp	r0, r1, lsl #6
    8da8:	e0a22002 	adc	r2, r2, r2
    8dac:	20400301 	subcs	r0, r0, r1, lsl #6
    8db0:	e1500281 	cmp	r0, r1, lsl #5
    8db4:	e0a22002 	adc	r2, r2, r2
    8db8:	20400281 	subcs	r0, r0, r1, lsl #5
    8dbc:	e1500201 	cmp	r0, r1, lsl #4
    8dc0:	e0a22002 	adc	r2, r2, r2
    8dc4:	20400201 	subcs	r0, r0, r1, lsl #4
    8dc8:	e1500181 	cmp	r0, r1, lsl #3
    8dcc:	e0a22002 	adc	r2, r2, r2
    8dd0:	20400181 	subcs	r0, r0, r1, lsl #3
    8dd4:	e1500101 	cmp	r0, r1, lsl #2
    8dd8:	e0a22002 	adc	r2, r2, r2
    8ddc:	20400101 	subcs	r0, r0, r1, lsl #2
    8de0:	e1500081 	cmp	r0, r1, lsl #1
    8de4:	e0a22002 	adc	r2, r2, r2
    8de8:	20400081 	subcs	r0, r0, r1, lsl #1
    8dec:	e1500001 	cmp	r0, r1
    8df0:	e0a22002 	adc	r2, r2, r2
    8df4:	20400001 	subcs	r0, r0, r1
    8df8:	e1a00002 	mov	r0, r2
    8dfc:	e12fff1e 	bx	lr
    8e00:	03a00001 	moveq	r0, #1
    8e04:	13a00000 	movne	r0, #0
    8e08:	e12fff1e 	bx	lr
    8e0c:	e16f2f11 	clz	r2, r1
    8e10:	e262201f 	rsb	r2, r2, #31
    8e14:	e1a00230 	lsr	r0, r0, r2
    8e18:	e12fff1e 	bx	lr
    8e1c:	e3500000 	cmp	r0, #0
    8e20:	13e00000 	mvnne	r0, #0
    8e24:	ea000007 	b	8e48 <__aeabi_idiv0>

00008e28 <__aeabi_uidivmod>:
__aeabi_uidivmod():
    8e28:	e3510000 	cmp	r1, #0
    8e2c:	0afffffa 	beq	8e1c <__udivsi3+0x1e0>
    8e30:	e92d4003 	push	{r0, r1, lr}
    8e34:	ebffff80 	bl	8c3c <__udivsi3>
    8e38:	e8bd4006 	pop	{r1, r2, lr}
    8e3c:	e0030092 	mul	r3, r2, r0
    8e40:	e0411003 	sub	r1, r1, r3
    8e44:	e12fff1e 	bx	lr

00008e48 <__aeabi_idiv0>:
__aeabi_ldiv0():
    8e48:	e12fff1e 	bx	lr

Disassembly of section .rodata:

00008e4c <_ZL13Lock_Unlocked>:
    8e4c:	00000000 	andeq	r0, r0, r0

00008e50 <_ZL11Lock_Locked>:
    8e50:	00000001 	andeq	r0, r0, r1

00008e54 <_ZL21MaxFSDriverNameLength>:
    8e54:	00000010 	andeq	r0, r0, r0, lsl r0

00008e58 <_ZL17MaxFilenameLength>:
    8e58:	00000010 	andeq	r0, r0, r0, lsl r0

00008e5c <_ZL13MaxPathLength>:
    8e5c:	00000080 	andeq	r0, r0, r0, lsl #1

00008e60 <_ZL18NoFilesystemDriver>:
    8e60:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008e64 <_ZL9NotifyAll>:
    8e64:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008e68 <_ZL24Max_Process_Opened_Files>:
    8e68:	00000010 	andeq	r0, r0, r0, lsl r0

00008e6c <_ZL10Indefinite>:
    8e6c:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008e70 <_ZL18Deadline_Unchanged>:
    8e70:	fffffffe 			; <UNDEFINED> instruction: 0xfffffffe

00008e74 <_ZL14Invalid_Handle>:
    8e74:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008e78 <_ZN3halL18Default_Clock_RateE>:
    8e78:	0ee6b280 	cdpeq	2, 14, cr11, cr6, cr0, {4}

00008e7c <_ZN3halL15Peripheral_BaseE>:
    8e7c:	20000000 	andcs	r0, r0, r0

00008e80 <_ZN3halL9GPIO_BaseE>:
    8e80:	20200000 	eorcs	r0, r0, r0

00008e84 <_ZN3halL14GPIO_Pin_CountE>:
    8e84:	00000036 	andeq	r0, r0, r6, lsr r0

00008e88 <_ZN3halL8AUX_BaseE>:
    8e88:	20215000 	eorcs	r5, r1, r0

00008e8c <_ZN3halL25Interrupt_Controller_BaseE>:
    8e8c:	2000b200 	andcs	fp, r0, r0, lsl #4

00008e90 <_ZN3halL10Timer_BaseE>:
    8e90:	2000b400 	andcs	fp, r0, r0, lsl #8

00008e94 <_ZN3halL9TRNG_BaseE>:
    8e94:	20104000 	andscs	r4, r0, r0

00008e98 <_ZN3halL9BSC0_BaseE>:
    8e98:	20205000 	eorcs	r5, r0, r0

00008e9c <_ZN3halL9BSC1_BaseE>:
    8e9c:	20804000 	addcs	r4, r0, r0

00008ea0 <_ZN3halL9BSC2_BaseE>:
    8ea0:	20805000 	addcs	r5, r0, r0

00008ea4 <_ZN3halL14I2C_SLAVE_BaseE>:
    8ea4:	20214000 	eorcs	r4, r1, r0

00008ea8 <_ZL11Invalid_Pin>:
    8ea8:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008eac <_ZL24I2C_Transaction_Max_Size>:
    8eac:	00000008 	andeq	r0, r0, r8

00008eb0 <_ZL17symbol_tick_delay>:
    8eb0:	00000400 	andeq	r0, r0, r0, lsl #8

00008eb4 <_ZL15char_tick_delay>:
    8eb4:	00001000 	andeq	r1, r0, r0
    8eb8:	00676f6c 	rsbeq	r6, r7, ip, ror #30
    8ebc:	76616c53 			; <UNDEFINED> instruction: 0x76616c53
    8ec0:	61742065 	cmnvs	r4, r5, rrx
    8ec4:	73206b73 			; <UNDEFINED> instruction: 0x73206b73
    8ec8:	74726174 	ldrbtvc	r6, [r2], #-372	; 0xfffffe8c
    8ecc:	000a6465 	andeq	r6, sl, r5, ror #8
    8ed0:	3a564544 	bcc	159a3e8 <__bss_end+0x159144c>
    8ed4:	2f633269 	svccs	0x00633269
    8ed8:	00000032 	andeq	r0, r0, r2, lsr r0
    8edc:	6f727245 	svcvs	0x00727245
    8ee0:	706f2072 	rsbvc	r2, pc, r2, ror r0	; <UNPREDICTABLE>
    8ee4:	6e696e65 	cdpvs	14, 6, cr6, cr9, cr5, {3}
    8ee8:	32492067 	subcc	r2, r9, #103	; 0x67
    8eec:	6c732043 	ldclvs	0, cr2, [r3], #-268	; 0xfffffef4
    8ef0:	20657661 	rsbcs	r7, r5, r1, ror #12
    8ef4:	6e6e6f63 	cdpvs	15, 6, cr6, cr14, cr3, {3}
    8ef8:	69746365 	ldmdbvs	r4!, {r0, r2, r5, r6, r8, r9, sp, lr}^
    8efc:	000a6e6f 	andeq	r6, sl, pc, ror #28
    8f00:	20433249 	subcs	r3, r3, r9, asr #4
    8f04:	6e6e6f63 	cdpvs	15, 6, cr6, cr14, cr3, {3}
    8f08:	69746365 	ldmdbvs	r4!, {r0, r2, r5, r6, r8, r9, sp, lr}^
    8f0c:	73206e6f 			; <UNDEFINED> instruction: 0x73206e6f
    8f10:	6576616c 	ldrbvs	r6, [r6, #-364]!	; 0xfffffe94
    8f14:	61747320 	cmnvs	r4, r0, lsr #6
    8f18:	64657472 	strbtvs	r7, [r5], #-1138	; 0xfffffb8e
    8f1c:	0a2e2e2e 	beq	b947dc <__bss_end+0xb8b840>
    8f20:	00000000 	andeq	r0, r0, r0
    8f24:	6c6c6548 	cfstr64vs	mvdx6, [ip], #-288	; 0xfffffee0
    8f28:	7266206f 	rsbvc	r2, r6, #111	; 0x6f
    8f2c:	73206d6f 			; <UNDEFINED> instruction: 0x73206d6f
    8f30:	6576616c 	ldrbvs	r6, [r6, #-364]!	; 0xfffffe94
    8f34:	0000000a 	andeq	r0, r0, sl

00008f38 <_ZL13Lock_Unlocked>:
    8f38:	00000000 	andeq	r0, r0, r0

00008f3c <_ZL11Lock_Locked>:
    8f3c:	00000001 	andeq	r0, r0, r1

00008f40 <_ZL21MaxFSDriverNameLength>:
    8f40:	00000010 	andeq	r0, r0, r0, lsl r0

00008f44 <_ZL17MaxFilenameLength>:
    8f44:	00000010 	andeq	r0, r0, r0, lsl r0

00008f48 <_ZL13MaxPathLength>:
    8f48:	00000080 	andeq	r0, r0, r0, lsl #1

00008f4c <_ZL18NoFilesystemDriver>:
    8f4c:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008f50 <_ZL9NotifyAll>:
    8f50:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008f54 <_ZL24Max_Process_Opened_Files>:
    8f54:	00000010 	andeq	r0, r0, r0, lsl r0

00008f58 <_ZL10Indefinite>:
    8f58:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008f5c <_ZL18Deadline_Unchanged>:
    8f5c:	fffffffe 			; <UNDEFINED> instruction: 0xfffffffe

00008f60 <_ZL14Invalid_Handle>:
    8f60:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff

00008f64 <_ZL16Pipe_File_Prefix>:
    8f64:	3a535953 	bcc	14df4b8 <__bss_end+0x14d651c>
    8f68:	65706970 	ldrbvs	r6, [r0, #-2416]!	; 0xfffff690
    8f6c:	0000002f 	andeq	r0, r0, pc, lsr #32

00008f70 <_ZN12_GLOBAL__N_1L11CharConvArrE>:
    8f70:	33323130 	teqcc	r2, #48, 2
    8f74:	37363534 			; <UNDEFINED> instruction: 0x37363534
    8f78:	42413938 	submi	r3, r1, #56, 18	; 0xe0000
    8f7c:	46454443 	strbmi	r4, [r5], -r3, asr #8
	...

Disassembly of section .bss:

00008f84 <log_fd>:
__bss_start():
/Users/winterji/Desktop/FAV/Navazujici/OS/semestralka-kiv-os/sources/userspace/slave_task/main.cpp:17
uint32_t log_fd, slave;
    8f84:	00000000 	andeq	r0, r0, r0

00008f88 <slave>:
	...

Disassembly of section .ARM.attributes:

00000000 <.ARM.attributes>:
   0:	00002e41 	andeq	r2, r0, r1, asr #28
   4:	61656100 	cmnvs	r5, r0, lsl #2
   8:	01006962 	tsteq	r0, r2, ror #18
   c:	00000024 	andeq	r0, r0, r4, lsr #32
  10:	4b5a3605 	blmi	168d82c <__bss_end+0x1684890>
  14:	08070600 	stmdaeq	r7, {r9, sl}
  18:	0a010901 	beq	42424 <__bss_end+0x39488>
  1c:	14041202 	strne	r1, [r4], #-514	; 0xfffffdfe
  20:	17011501 	strne	r1, [r1, -r1, lsl #10]
  24:	1a011803 	bne	46038 <__bss_end+0x3d09c>
  28:	22011c01 	andcs	r1, r1, #256	; 0x100
  2c:	Address 0x000000000000002c is out of bounds.


Disassembly of section .comment:

00000000 <.comment>:
   0:	3a434347 	bcc	10d0d24 <__bss_end+0x10c7d88>
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
  38:	7a617661 	bvc	185d9c4 <__bss_end+0x1854a28>
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
  c0:	6a757a61 	bvs	1d5ea4c <__bss_end+0x1d55ab0>
  c4:	2f696369 	svccs	0x00696369
  c8:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
  cc:	73656d65 	cmnvc	r5, #6464	; 0x1940
  d0:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
  d4:	6b2d616b 	blvs	b58688 <__bss_end+0xb4f6ec>
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
 144:	fb010200 	blx	4094e <__bss_end+0x379b2>
 148:	01000d0e 	tsteq	r0, lr, lsl #26
 14c:	00010101 	andeq	r0, r1, r1, lsl #2
 150:	00010000 	andeq	r0, r1, r0
 154:	552f0100 	strpl	r0, [pc, #-256]!	; 5c <shift+0x5c>
 158:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 15c:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 160:	6a726574 	bvs	1c99738 <__bss_end+0x1c9079c>
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
 198:	752f7365 	strvc	r7, [pc, #-869]!	; fffffe3b <__bss_end+0xffff6e9f>
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
 1d0:	0a05830b 	beq	160e04 <__bss_end+0x157e68>
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
 1fc:	4a030402 	bmi	c120c <__bss_end+0xb8270>
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
 230:	4a020402 	bmi	81240 <__bss_end+0x782a4>
 234:	02000205 	andeq	r0, r0, #1342177280	; 0x50000000
 238:	052d0204 	streq	r0, [sp, #-516]!	; 0xfffffdfc
 23c:	01058509 	tsteq	r5, r9, lsl #10
 240:	000a022f 	andeq	r0, sl, pc, lsr #4
 244:	02fa0101 	rscseq	r0, sl, #1073741824	; 0x40000000
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
 280:	6a757a61 	bvs	1d5ec0c <__bss_end+0x1d55c70>
 284:	2f696369 	svccs	0x00696369
 288:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
 28c:	73656d65 	cmnvc	r5, #6464	; 0x1940
 290:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
 294:	6b2d616b 	blvs	b58848 <__bss_end+0xb4f8ac>
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
 2d8:	7a617661 	bvc	185dc64 <__bss_end+0x1854cc8>
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
 334:	6b736544 	blvs	1cd984c <__bss_end+0x1cd08b0>
 338:	2f706f74 	svccs	0x00706f74
 33c:	2f564146 	svccs	0x00564146
 340:	6176614e 	cmnvs	r6, lr, asr #2
 344:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
 348:	4f2f6963 	svcmi	0x002f6963
 34c:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
 350:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
 354:	6b6c6172 	blvs	1b18924 <__bss_end+0x1b0f988>
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
 398:	6b736544 	blvs	1cd98b0 <__bss_end+0x1cd0914>
 39c:	2f706f74 	svccs	0x00706f74
 3a0:	2f564146 	svccs	0x00564146
 3a4:	6176614e 	cmnvs	r6, lr, asr #2
 3a8:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
 3ac:	4f2f6963 	svcmi	0x002f6963
 3b0:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
 3b4:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
 3b8:	6b6c6172 	blvs	1b18988 <__bss_end+0x1b0f9ec>
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
 408:	6b736544 	blvs	1cd9920 <__bss_end+0x1cd0984>
 40c:	2f706f74 	svccs	0x00706f74
 410:	2f564146 	svccs	0x00564146
 414:	6176614e 	cmnvs	r6, lr, asr #2
 418:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
 41c:	4f2f6963 	svcmi	0x002f6963
 420:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
 424:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
 428:	6b6c6172 	blvs	1b189f8 <__bss_end+0x1b0fa5c>
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
 4f0:	01130300 	tsteq	r3, r0, lsl #6
 4f4:	05830a05 	streq	r0, [r3, #2565]	; 0xa05
 4f8:	0a054a1e 	beq	152d78 <__bss_end+0x149ddc>
 4fc:	83010566 	movwhi	r0, #5478	; 0x1566
 500:	05821d03 	streq	r1, [r2, #3331]	; 0xd03
 504:	0c05a112 	stfeqd	f2, [r5], {18}
 508:	4c080582 	cfstr32mi	mvfx0, [r8], {130}	; 0x82
 50c:	054d1105 	strbeq	r1, [sp, #-261]	; 0xfffffefb
 510:	0f05820b 	svceq	0x0005820b
 514:	4a05054b 	bmi	141a48 <__bss_end+0x138aac>
 518:	054b0c05 	strbeq	r0, [fp, #-3077]	; 0xfffff3fb
 51c:	08054b10 	stmdaeq	r5, {r4, r8, r9, fp, lr}
 520:	000c054c 	andeq	r0, ip, ip, asr #10
 524:	4c010402 	cfstrsmi	mvf0, [r1], {2}
 528:	02000e05 	andeq	r0, r0, #5, 28	; 0x50
 52c:	054b0104 	strbeq	r0, [fp, #-260]	; 0xfffffefc
 530:	0402000c 	streq	r0, [r2], #-12
 534:	01056501 	tsteq	r5, r1, lsl #10
 538:	01040200 	mrseq	r0, R12_usr
 53c:	022e0903 	eoreq	r0, lr, #49152	; 0xc000
 540:	01010016 	tsteq	r1, r6, lsl r0
 544:	000002c8 	andeq	r0, r0, r8, asr #5
 548:	01dd0003 	bicseq	r0, sp, r3
 54c:	01020000 	mrseq	r0, (UNDEF: 2)
 550:	000d0efb 	strdeq	r0, [sp], -fp
 554:	01010101 	tsteq	r1, r1, lsl #2
 558:	01000000 	mrseq	r0, (UNDEF: 0)
 55c:	2f010000 	svccs	0x00010000
 560:	72657355 	rsbvc	r7, r5, #1409286145	; 0x54000001
 564:	69772f73 	ldmdbvs	r7!, {r0, r1, r4, r5, r6, r8, r9, sl, fp, sp}^
 568:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
 56c:	442f696a 	strtmi	r6, [pc], #-2410	; 574 <shift+0x574>
 570:	746b7365 	strbtvc	r7, [fp], #-869	; 0xfffffc9b
 574:	462f706f 	strtmi	r7, [pc], -pc, rrx
 578:	4e2f5641 	cfmadda32mi	mvax2, mvax5, mvfx15, mvfx1
 57c:	7a617661 	bvc	185df08 <__bss_end+0x1854f6c>
 580:	63696a75 	cmnvs	r9, #479232	; 0x75000
 584:	534f2f69 	movtpl	r2, #65385	; 0xff69
 588:	6d65732f 	stclvs	3, cr7, [r5, #-188]!	; 0xffffff44
 58c:	72747365 	rsbsvc	r7, r4, #-1811939327	; 0x94000001
 590:	616b6c61 	cmnvs	fp, r1, ror #24
 594:	76696b2d 	strbtvc	r6, [r9], -sp, lsr #22
 598:	2f736f2d 	svccs	0x00736f2d
 59c:	72756f73 	rsbsvc	r6, r5, #460	; 0x1cc
 5a0:	2f736563 	svccs	0x00736563
 5a4:	6c647473 	cfstrdvs	mvd7, [r4], #-460	; 0xfffffe34
 5a8:	732f6269 			; <UNDEFINED> instruction: 0x732f6269
 5ac:	2f006372 	svccs	0x00006372
 5b0:	72657355 	rsbvc	r7, r5, #1409286145	; 0x54000001
 5b4:	69772f73 	ldmdbvs	r7!, {r0, r1, r4, r5, r6, r8, r9, sl, fp, sp}^
 5b8:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
 5bc:	442f696a 	strtmi	r6, [pc], #-2410	; 5c4 <shift+0x5c4>
 5c0:	746b7365 	strbtvc	r7, [fp], #-869	; 0xfffffc9b
 5c4:	462f706f 	strtmi	r7, [pc], -pc, rrx
 5c8:	4e2f5641 	cfmadda32mi	mvax2, mvax5, mvfx15, mvfx1
 5cc:	7a617661 	bvc	185df58 <__bss_end+0x1854fbc>
 5d0:	63696a75 	cmnvs	r9, #479232	; 0x75000
 5d4:	534f2f69 	movtpl	r2, #65385	; 0xff69
 5d8:	6d65732f 	stclvs	3, cr7, [r5, #-188]!	; 0xffffff44
 5dc:	72747365 	rsbsvc	r7, r4, #-1811939327	; 0x94000001
 5e0:	616b6c61 	cmnvs	fp, r1, ror #24
 5e4:	76696b2d 	strbtvc	r6, [r9], -sp, lsr #22
 5e8:	2f736f2d 	svccs	0x00736f2d
 5ec:	72756f73 	rsbsvc	r6, r5, #460	; 0x1cc
 5f0:	2f736563 	svccs	0x00736563
 5f4:	6e72656b 	cdpvs	5, 7, cr6, cr2, cr11, {3}
 5f8:	692f6c65 	stmdbvs	pc!, {r0, r2, r5, r6, sl, fp, sp, lr}	; <UNPREDICTABLE>
 5fc:	756c636e 	strbvc	r6, [ip, #-878]!	; 0xfffffc92
 600:	702f6564 	eorvc	r6, pc, r4, ror #10
 604:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
 608:	2f007373 	svccs	0x00007373
 60c:	72657355 	rsbvc	r7, r5, #1409286145	; 0x54000001
 610:	69772f73 	ldmdbvs	r7!, {r0, r1, r4, r5, r6, r8, r9, sl, fp, sp}^
 614:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
 618:	442f696a 	strtmi	r6, [pc], #-2410	; 620 <shift+0x620>
 61c:	746b7365 	strbtvc	r7, [fp], #-869	; 0xfffffc9b
 620:	462f706f 	strtmi	r7, [pc], -pc, rrx
 624:	4e2f5641 	cfmadda32mi	mvax2, mvax5, mvfx15, mvfx1
 628:	7a617661 	bvc	185dfb4 <__bss_end+0x1855018>
 62c:	63696a75 	cmnvs	r9, #479232	; 0x75000
 630:	534f2f69 	movtpl	r2, #65385	; 0xff69
 634:	6d65732f 	stclvs	3, cr7, [r5, #-188]!	; 0xffffff44
 638:	72747365 	rsbsvc	r7, r4, #-1811939327	; 0x94000001
 63c:	616b6c61 	cmnvs	fp, r1, ror #24
 640:	76696b2d 	strbtvc	r6, [r9], -sp, lsr #22
 644:	2f736f2d 	svccs	0x00736f2d
 648:	72756f73 	rsbsvc	r6, r5, #460	; 0x1cc
 64c:	2f736563 	svccs	0x00736563
 650:	6e72656b 	cdpvs	5, 7, cr6, cr2, cr11, {3}
 654:	692f6c65 	stmdbvs	pc!, {r0, r2, r5, r6, sl, fp, sp, lr}	; <UNPREDICTABLE>
 658:	756c636e 	strbvc	r6, [ip, #-878]!	; 0xfffffc92
 65c:	662f6564 	strtvs	r6, [pc], -r4, ror #10
 660:	552f0073 	strpl	r0, [pc, #-115]!	; 5f5 <shift+0x5f5>
 664:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
 668:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 66c:	6a726574 	bvs	1c99c44 <__bss_end+0x1c90ca8>
 670:	65442f69 	strbvs	r2, [r4, #-3945]	; 0xfffff097
 674:	6f746b73 	svcvs	0x00746b73
 678:	41462f70 	hvcmi	25328	; 0x62f0
 67c:	614e2f56 	cmpvs	lr, r6, asr pc
 680:	757a6176 	ldrbvc	r6, [sl, #-374]!	; 0xfffffe8a
 684:	6963696a 	stmdbvs	r3!, {r1, r3, r5, r6, r8, fp, sp, lr}^
 688:	2f534f2f 	svccs	0x00534f2f
 68c:	656d6573 	strbvs	r6, [sp, #-1395]!	; 0xfffffa8d
 690:	61727473 	cmnvs	r2, r3, ror r4
 694:	2d616b6c 	vstmdbcs	r1!, {d22-<overflow reg d75>}
 698:	2d76696b 			; <UNDEFINED> instruction: 0x2d76696b
 69c:	732f736f 			; <UNDEFINED> instruction: 0x732f736f
 6a0:	6372756f 	cmnvs	r2, #465567744	; 0x1bc00000
 6a4:	6b2f7365 	blvs	bdd440 <__bss_end+0xbd44a4>
 6a8:	656e7265 	strbvs	r7, [lr, #-613]!	; 0xfffffd9b
 6ac:	6e692f6c 	cdpvs	15, 6, cr2, cr9, cr12, {3}
 6b0:	64756c63 	ldrbtvs	r6, [r5], #-3171	; 0xfffff39d
 6b4:	6f622f65 	svcvs	0x00622f65
 6b8:	2f647261 	svccs	0x00647261
 6bc:	30697072 	rsbcc	r7, r9, r2, ror r0
 6c0:	6c61682f 	stclvs	8, cr6, [r1], #-188	; 0xffffff44
 6c4:	74730000 	ldrbtvc	r0, [r3], #-0
 6c8:	6c696664 	stclvs	6, cr6, [r9], #-400	; 0xfffffe70
 6cc:	70632e65 	rsbvc	r2, r3, r5, ror #28
 6d0:	00010070 	andeq	r0, r1, r0, ror r0
 6d4:	69777300 	ldmdbvs	r7!, {r8, r9, ip, sp, lr}^
 6d8:	0200682e 	andeq	r6, r0, #3014656	; 0x2e0000
 6dc:	70730000 	rsbsvc	r0, r3, r0
 6e0:	6f6c6e69 	svcvs	0x006c6e69
 6e4:	682e6b63 	stmdavs	lr!, {r0, r1, r5, r6, r8, r9, fp, sp, lr}
 6e8:	00000200 	andeq	r0, r0, r0, lsl #4
 6ec:	656c6966 	strbvs	r6, [ip, #-2406]!	; 0xfffff69a
 6f0:	74737973 	ldrbtvc	r7, [r3], #-2419	; 0xfffff68d
 6f4:	682e6d65 	stmdavs	lr!, {r0, r2, r5, r6, r8, sl, fp, sp, lr}
 6f8:	00000300 	andeq	r0, r0, r0, lsl #6
 6fc:	636f7270 	cmnvs	pc, #112, 4
 700:	2e737365 	cdpcs	3, 7, cr7, cr3, cr5, {3}
 704:	00020068 	andeq	r0, r2, r8, rrx
 708:	6f727000 	svcvs	0x00727000
 70c:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
 710:	6e616d5f 	mcrvs	13, 3, r6, cr1, cr15, {2}
 714:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
 718:	0200682e 	andeq	r6, r0, #3014656	; 0x2e0000
 71c:	6e690000 	cdpvs	0, 6, cr0, cr9, cr0, {0}
 720:	66656474 			; <UNDEFINED> instruction: 0x66656474
 724:	0400682e 	streq	r6, [r0], #-2094	; 0xfffff7d2
 728:	05000000 	streq	r0, [r0, #-0]
 72c:	02050001 	andeq	r0, r5, #1
 730:	00008328 	andeq	r8, r0, r8, lsr #6
 734:	69050516 	stmdbvs	r5, {r1, r2, r4, r8, sl}
 738:	4c0c052f 	cfstr32mi	mvfx0, [ip], {47}	; 0x2f
 73c:	852f0105 	strhi	r0, [pc, #-261]!	; 63f <shift+0x63f>
 740:	4b830505 	blmi	fe0c1b5c <__bss_end+0xfe0b8bc0>
 744:	852f0105 	strhi	r0, [pc, #-261]!	; 647 <shift+0x647>
 748:	054b0505 	strbeq	r0, [fp, #-1285]	; 0xfffffafb
 74c:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 750:	4b4ba105 	blmi	12e8b6c <__bss_end+0x12dfbd0>
 754:	4b0c052f 	blmi	301c18 <__bss_end+0x2f8c7c>
 758:	852f0105 	strhi	r0, [pc, #-261]!	; 65b <shift+0x65b>
 75c:	4bbd0505 	blmi	fef41b78 <__bss_end+0xfef38bdc>
 760:	052f4b4b 	streq	r4, [pc, #-2891]!	; fffffc1d <__bss_end+0xffff6c81>
 764:	01054c0c 	tsteq	r5, ip, lsl #24
 768:	0505852f 	streq	r8, [r5, #-1327]	; 0xfffffad1
 76c:	4b4b4bbd 	blmi	12d3668 <__bss_end+0x12ca6cc>
 770:	4c0c052f 	cfstr32mi	mvfx0, [ip], {47}	; 0x2f
 774:	852f0105 	strhi	r0, [pc, #-261]!	; 677 <shift+0x677>
 778:	4b830505 	blmi	fe0c1b94 <__bss_end+0xfe0b8bf8>
 77c:	852f0105 	strhi	r0, [pc, #-261]!	; 67f <shift+0x67f>
 780:	4bbd0505 	blmi	fef41b9c <__bss_end+0xfef38c00>
 784:	052f4b4b 	streq	r4, [pc, #-2891]!	; fffffc41 <__bss_end+0xffff6ca5>
 788:	01054c0c 	tsteq	r5, ip, lsl #24
 78c:	0505852f 	streq	r8, [r5, #-1327]	; 0xfffffad1
 790:	2f4b4ba1 	svccs	0x004b4ba1
 794:	054c0c05 	strbeq	r0, [ip, #-3077]	; 0xfffff3fb
 798:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 79c:	4b4bbd05 	blmi	12efbb8 <__bss_end+0x12e6c1c>
 7a0:	0c052f4b 	stceq	15, cr2, [r5], {75}	; 0x4b
 7a4:	2f01054c 	svccs	0x0001054c
 7a8:	a1050585 	smlabbge	r5, r5, r5, r0
 7ac:	052f4b4b 	streq	r4, [pc, #-2891]!	; fffffc69 <__bss_end+0xffff6ccd>
 7b0:	01054c0c 	tsteq	r5, ip, lsl #24
 7b4:	2005859f 	mulcs	r5, pc, r5	; <UNPREDICTABLE>
 7b8:	4d050567 	cfstr32mi	mvfx0, [r5, #-412]	; 0xfffffe64
 7bc:	0c054b4b 			; <UNDEFINED> instruction: 0x0c054b4b
 7c0:	2f010530 	svccs	0x00010530
 7c4:	67200585 	strvs	r0, [r0, -r5, lsl #11]!
 7c8:	4b4d0505 	blmi	1341be4 <__bss_end+0x1338c48>
 7cc:	300c054b 	andcc	r0, ip, fp, asr #10
 7d0:	852f0105 	strhi	r0, [pc, #-261]!	; 6d3 <shift+0x6d3>
 7d4:	05832005 	streq	r2, [r3, #5]
 7d8:	4b4b4c05 	blmi	12d37f4 <__bss_end+0x12ca858>
 7dc:	852f0105 	strhi	r0, [pc, #-261]!	; 6df <shift+0x6df>
 7e0:	05672005 	strbeq	r2, [r7, #-5]!
 7e4:	4b4b4d05 	blmi	12d3c00 <__bss_end+0x12cac64>
 7e8:	05300c05 	ldreq	r0, [r0, #-3077]!	; 0xfffff3fb
 7ec:	05872f01 	streq	r2, [r7, #3841]	; 0xf01
 7f0:	059fa00c 	ldreq	sl, [pc, #12]	; 804 <shift+0x804>
 7f4:	2905bc31 	stmdbcs	r5, {r0, r4, r5, sl, fp, ip, sp, pc}
 7f8:	2e360566 	cdpcs	5, 3, cr0, cr6, cr6, {3}
 7fc:	05300f05 	ldreq	r0, [r0, #-3845]!	; 0xfffff0fb
 800:	09056613 	stmdbeq	r5, {r0, r1, r4, r9, sl, sp, lr}
 804:	d8100584 	ldmdale	r0, {r2, r7, r8, sl}
 808:	029f0105 	addseq	r0, pc, #1073741825	; 0x40000001
 80c:	01010008 	tsteq	r1, r8
 810:	0000029b 	muleq	r0, fp, r2
 814:	00740003 	rsbseq	r0, r4, r3
 818:	01020000 	mrseq	r0, (UNDEF: 2)
 81c:	000d0efb 	strdeq	r0, [sp], -fp
 820:	01010101 	tsteq	r1, r1, lsl #2
 824:	01000000 	mrseq	r0, (UNDEF: 0)
 828:	2f010000 	svccs	0x00010000
 82c:	72657355 	rsbvc	r7, r5, #1409286145	; 0x54000001
 830:	69772f73 	ldmdbvs	r7!, {r0, r1, r4, r5, r6, r8, r9, sl, fp, sp}^
 834:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
 838:	442f696a 	strtmi	r6, [pc], #-2410	; 840 <shift+0x840>
 83c:	746b7365 	strbtvc	r7, [fp], #-869	; 0xfffffc9b
 840:	462f706f 	strtmi	r7, [pc], -pc, rrx
 844:	4e2f5641 	cfmadda32mi	mvax2, mvax5, mvfx15, mvfx1
 848:	7a617661 	bvc	185e1d4 <__bss_end+0x1855238>
 84c:	63696a75 	cmnvs	r9, #479232	; 0x75000
 850:	534f2f69 	movtpl	r2, #65385	; 0xff69
 854:	6d65732f 	stclvs	3, cr7, [r5, #-188]!	; 0xffffff44
 858:	72747365 	rsbsvc	r7, r4, #-1811939327	; 0x94000001
 85c:	616b6c61 	cmnvs	fp, r1, ror #24
 860:	76696b2d 	strbtvc	r6, [r9], -sp, lsr #22
 864:	2f736f2d 	svccs	0x00736f2d
 868:	72756f73 	rsbsvc	r6, r5, #460	; 0x1cc
 86c:	2f736563 	svccs	0x00736563
 870:	6c647473 	cfstrdvs	mvd7, [r4], #-460	; 0xfffffe34
 874:	732f6269 			; <UNDEFINED> instruction: 0x732f6269
 878:	00006372 	andeq	r6, r0, r2, ror r3
 87c:	73647473 	cmnvc	r4, #1929379840	; 0x73000000
 880:	6e697274 	mcrvs	2, 3, r7, cr9, cr4, {3}
 884:	70632e67 	rsbvc	r2, r3, r7, ror #28
 888:	00010070 	andeq	r0, r1, r0, ror r0
 88c:	01050000 	mrseq	r0, (UNDEF: 5)
 890:	84020500 	strhi	r0, [r2], #-1280	; 0xfffffb00
 894:	1a000087 	bne	ab8 <shift+0xab8>
 898:	05bb0605 	ldreq	r0, [fp, #1541]!	; 0x605
 89c:	21054c0f 	tstcs	r5, pc, lsl #24
 8a0:	ba0a0568 	blt	281e48 <__bss_end+0x278eac>
 8a4:	052e0b05 	streq	r0, [lr, #-2821]!	; 0xfffff4fb
 8a8:	0d054a27 	vstreq	s8, [r5, #-156]	; 0xffffff64
 8ac:	2f09054a 	svccs	0x0009054a
 8b0:	059f0405 	ldreq	r0, [pc, #1029]	; cbd <shift+0xcbd>
 8b4:	05056202 	streq	r6, [r5, #-514]	; 0xfffffdfe
 8b8:	68100535 	ldmdavs	r0, {r0, r2, r4, r5, r8, sl}
 8bc:	052e1105 	streq	r1, [lr, #-261]!	; 0xfffffefb
 8c0:	13054a22 	movwne	r4, #23074	; 0x5a22
 8c4:	2f0a052e 	svccs	0x000a052e
 8c8:	05690905 	strbeq	r0, [r9, #-2309]!	; 0xfffff6fb
 8cc:	0c052e0a 	stceq	14, cr2, [r5], {10}
 8d0:	4b03054a 	blmi	c1e00 <__bss_end+0xb8e64>
 8d4:	05680b05 	strbeq	r0, [r8, #-2821]!	; 0xfffff4fb
 8d8:	04020018 	streq	r0, [r2], #-24	; 0xffffffe8
 8dc:	14054a03 	strne	r4, [r5], #-2563	; 0xfffff5fd
 8e0:	03040200 	movweq	r0, #16896	; 0x4200
 8e4:	0015059e 	mulseq	r5, lr, r5
 8e8:	68020402 	stmdavs	r2, {r1, sl}
 8ec:	02001805 	andeq	r1, r0, #327680	; 0x50000
 8f0:	05820204 	streq	r0, [r2, #516]	; 0x204
 8f4:	04020008 	streq	r0, [r2], #-8
 8f8:	1a054a02 	bne	153108 <__bss_end+0x14a16c>
 8fc:	02040200 	andeq	r0, r4, #0, 4
 900:	001b054b 	andseq	r0, fp, fp, asr #10
 904:	2e020402 	cdpcs	4, 0, cr0, cr2, cr2, {0}
 908:	02000c05 	andeq	r0, r0, #1280	; 0x500
 90c:	054a0204 	strbeq	r0, [sl, #-516]	; 0xfffffdfc
 910:	0402000f 	streq	r0, [r2], #-15
 914:	1b058202 	blne	161124 <__bss_end+0x158188>
 918:	02040200 	andeq	r0, r4, #0, 4
 91c:	0011054a 	andseq	r0, r1, sl, asr #10
 920:	2e020402 	cdpcs	4, 0, cr0, cr2, cr2, {0}
 924:	02000a05 	andeq	r0, r0, #20480	; 0x5000
 928:	052f0204 	streq	r0, [pc, #-516]!	; 72c <shift+0x72c>
 92c:	0402000b 	streq	r0, [r2], #-11
 930:	0d052e02 	stceq	14, cr2, [r5, #-8]
 934:	02040200 	andeq	r0, r4, #0, 4
 938:	0002054a 	andeq	r0, r2, sl, asr #10
 93c:	46020402 	strmi	r0, [r2], -r2, lsl #8
 940:	85880105 	strhi	r0, [r8, #261]	; 0x105
 944:	05830605 	streq	r0, [r3, #1541]	; 0x605
 948:	10054c09 	andne	r4, r5, r9, lsl #24
 94c:	4c0a054a 	cfstr32mi	mvfx0, [sl], {74}	; 0x4a
 950:	05bb0705 	ldreq	r0, [fp, #1797]!	; 0x705
 954:	17054a03 	strne	r4, [r5, -r3, lsl #20]
 958:	01040200 	mrseq	r0, R12_usr
 95c:	0014054a 	andseq	r0, r4, sl, asr #10
 960:	4a010402 	bmi	41970 <__bss_end+0x389d4>
 964:	054d0d05 	strbeq	r0, [sp, #-3333]	; 0xfffff2fb
 968:	0a054a14 	beq	1531c0 <__bss_end+0x14a224>
 96c:	6808052e 	stmdavs	r8, {r1, r2, r3, r5, r8, sl}
 970:	78030205 	stmdavc	r3, {r0, r2, r9}
 974:	03090566 	movweq	r0, #38246	; 0x9566
 978:	01052e0b 	tsteq	r5, fp, lsl #28
 97c:	0905852f 	stmdbeq	r5, {r0, r1, r2, r3, r5, r8, sl, pc}
 980:	001605bd 			; <UNDEFINED> instruction: 0x001605bd
 984:	4a040402 	bmi	101994 <__bss_end+0xf89f8>
 988:	02001d05 	andeq	r1, r0, #320	; 0x140
 98c:	05820204 	streq	r0, [r2, #516]	; 0x204
 990:	0402001e 	streq	r0, [r2], #-30	; 0xffffffe2
 994:	16052e02 	strne	r2, [r5], -r2, lsl #28
 998:	02040200 	andeq	r0, r4, #0, 4
 99c:	00110566 	andseq	r0, r1, r6, ror #10
 9a0:	4b030402 	blmi	c19b0 <__bss_end+0xb8a14>
 9a4:	02001205 	andeq	r1, r0, #1342177280	; 0x50000000
 9a8:	052e0304 	streq	r0, [lr, #-772]!	; 0xfffffcfc
 9ac:	04020008 	streq	r0, [r2], #-8
 9b0:	09054a03 	stmdbeq	r5, {r0, r1, r9, fp, lr}
 9b4:	03040200 	movweq	r0, #16896	; 0x4200
 9b8:	0012052e 	andseq	r0, r2, lr, lsr #10
 9bc:	4a030402 	bmi	c19cc <__bss_end+0xb8a30>
 9c0:	02000b05 	andeq	r0, r0, #5120	; 0x1400
 9c4:	052e0304 	streq	r0, [lr, #-772]!	; 0xfffffcfc
 9c8:	04020002 	streq	r0, [r2], #-2
 9cc:	0b052d03 	bleq	14bde0 <__bss_end+0x142e44>
 9d0:	02040200 	andeq	r0, r4, #0, 4
 9d4:	00080584 	andeq	r0, r8, r4, lsl #11
 9d8:	83010402 	movwhi	r0, #5122	; 0x1402
 9dc:	02000905 	andeq	r0, r0, #81920	; 0x14000
 9e0:	052e0104 	streq	r0, [lr, #-260]!	; 0xfffffefc
 9e4:	0402000b 	streq	r0, [r2], #-11
 9e8:	02054a01 	andeq	r4, r5, #4096	; 0x1000
 9ec:	01040200 	mrseq	r0, R12_usr
 9f0:	850b0549 	strhi	r0, [fp, #-1353]	; 0xfffffab7
 9f4:	852f0105 	strhi	r0, [pc, #-261]!	; 8f7 <shift+0x8f7>
 9f8:	05bc0e05 	ldreq	r0, [ip, #3589]!	; 0xe05
 9fc:	20056611 	andcs	r6, r5, r1, lsl r6
 a00:	660b05bc 			; <UNDEFINED> instruction: 0x660b05bc
 a04:	054b1f05 	strbeq	r1, [fp, #-3845]	; 0xfffff0fb
 a08:	0805660a 	stmdaeq	r5, {r1, r3, r9, sl, sp, lr}
 a0c:	8311054b 	tsthi	r1, #314572800	; 0x12c00000
 a10:	052e1605 	streq	r1, [lr, #-1541]!	; 0xfffff9fb
 a14:	11056708 	tstne	r5, r8, lsl #14
 a18:	4d0b0567 	cfstr32mi	mvfx0, [fp, #-412]	; 0xfffffe64
 a1c:	852f0105 	strhi	r0, [pc, #-261]!	; 91f <shift+0x91f>
 a20:	05830605 	streq	r0, [r3, #1541]	; 0x605
 a24:	0c054c0b 	stceq	12, cr4, [r5], {11}
 a28:	660e052e 	strvs	r0, [lr], -lr, lsr #10
 a2c:	054b0405 	strbeq	r0, [fp, #-1029]	; 0xfffffbfb
 a30:	09056502 	stmdbeq	r5, {r1, r8, sl, sp, lr}
 a34:	2f010531 	svccs	0x00010531
 a38:	9f080585 	svcls	0x00080585
 a3c:	054c0b05 	strbeq	r0, [ip, #-2821]	; 0xfffff4fb
 a40:	04020014 	streq	r0, [r2], #-20	; 0xffffffec
 a44:	07054a03 	streq	r4, [r5, -r3, lsl #20]
 a48:	02040200 	andeq	r0, r4, #0, 4
 a4c:	00080583 	andeq	r0, r8, r3, lsl #11
 a50:	2e020402 	cdpcs	4, 0, cr0, cr2, cr2, {0}
 a54:	02000a05 	andeq	r0, r0, #20480	; 0x5000
 a58:	054a0204 	strbeq	r0, [sl, #-516]	; 0xfffffdfc
 a5c:	04020002 	streq	r0, [r2], #-2
 a60:	01054902 	tsteq	r5, r2, lsl #18
 a64:	0e058584 	cfsh32eq	mvfx8, mvfx5, #-60
 a68:	4b0805bb 	blmi	20215c <__bss_end+0x1f91c0>
 a6c:	054c0b05 	strbeq	r0, [ip, #-2821]	; 0xfffff4fb
 a70:	04020014 	streq	r0, [r2], #-20	; 0xffffffec
 a74:	16054a03 	strne	r4, [r5], -r3, lsl #20
 a78:	02040200 	andeq	r0, r4, #0, 4
 a7c:	00170583 	andseq	r0, r7, r3, lsl #11
 a80:	2e020402 	cdpcs	4, 0, cr0, cr2, cr2, {0}
 a84:	02000a05 	andeq	r0, r0, #20480	; 0x5000
 a88:	054a0204 	strbeq	r0, [sl, #-516]	; 0xfffffdfc
 a8c:	0402000b 	streq	r0, [r2], #-11
 a90:	17052e02 	strne	r2, [r5, -r2, lsl #28]
 a94:	02040200 	andeq	r0, r4, #0, 4
 a98:	000d054a 	andeq	r0, sp, sl, asr #10
 a9c:	2e020402 	cdpcs	4, 0, cr0, cr2, cr2, {0}
 aa0:	02000205 	andeq	r0, r0, #1342177280	; 0x50000000
 aa4:	052d0204 	streq	r0, [sp, #-516]!	; 0xfffffdfc
 aa8:	08028401 	stmdaeq	r2, {r0, sl, pc}
 aac:	Address 0x0000000000000aac is out of bounds.


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
      58:	0a5a0704 	beq	1681c70 <__bss_end+0x1678cd4>
      5c:	5b020000 	blpl	80064 <__bss_end+0x770c8>
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
     128:	00000a5a 	andeq	r0, r0, sl, asr sl
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
     174:	cb104801 	blgt	412180 <__bss_end+0x4091e4>
     178:	d4000000 	strle	r0, [r0], #-0
     17c:	58000081 	stmdapl	r0, {r0, r7}
     180:	01000000 	mrseq	r0, (UNDEF: 0)
     184:	0000cb9c 	muleq	r0, ip, fp
     188:	02b40a00 	adcseq	r0, r4, #0, 20
     18c:	4a010000 	bmi	40194 <__bss_end+0x371f8>
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
     21c:	ba0d9c01 	blt	367228 <__bss_end+0x35e28c>
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
     24c:	8b120f01 	blhi	483e58 <__bss_end+0x47aebc>
     250:	0f000001 	svceq	0x00000001
     254:	0000019e 	muleq	r0, lr, r1
     258:	03d51000 	bicseq	r1, r5, #0
     25c:	0a010000 	beq	40264 <__bss_end+0x372c8>
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
     2b4:	8b140074 	blhi	50048c <__bss_end+0x4f74f0>
     2b8:	a4000001 	strge	r0, [r0], #-1
     2bc:	38000080 	stmdacc	r0, {r7}
     2c0:	01000000 	mrseq	r0, (UNDEF: 0)
     2c4:	0067139c 	mlseq	r7, ip, r3, r1
     2c8:	9e2f0a01 	vmulls.f32	s0, s30, s2
     2cc:	02000001 	andeq	r0, r0, #1
     2d0:	00007491 	muleq	r0, r1, r4
     2d4:	0000083f 	andeq	r0, r0, pc, lsr r8
     2d8:	01e00004 	mvneq	r0, r4
     2dc:	01040000 	mrseq	r0, (UNDEF: 4)
     2e0:	000001e1 	andeq	r0, r0, r1, ror #3
     2e4:	00099c04 	andeq	r9, r9, r4, lsl #24
     2e8:	00005600 	andeq	r5, r0, r0, lsl #12
     2ec:	00822c00 	addeq	r2, r2, r0, lsl #24
     2f0:	0000fc00 	andeq	pc, r0, r0, lsl #24
     2f4:	00024600 	andeq	r4, r2, r0, lsl #12
     2f8:	08010200 	stmdaeq	r1, {r9}
     2fc:	00000ae8 	andeq	r0, r0, r8, ror #21
     300:	00002503 	andeq	r2, r0, r3, lsl #10
     304:	05020200 	streq	r0, [r2, #-512]	; 0xfffffe00
     308:	00000951 	andeq	r0, r0, r1, asr r9
     30c:	69050404 	stmdbvs	r5, {r2, sl}
     310:	0200746e 	andeq	r7, r0, #1845493760	; 0x6e000000
     314:	0adf0801 	beq	ff7c2320 <__bss_end+0xff7b9384>
     318:	02020000 	andeq	r0, r2, #0
     31c:	000b9607 	andeq	r9, fp, r7, lsl #12
     320:	060a0500 	streq	r0, [sl], -r0, lsl #10
     324:	090a0000 	stmdbeq	sl, {}	; <UNPREDICTABLE>
     328:	00005e07 	andeq	r5, r0, r7, lsl #28
     32c:	004d0300 	subeq	r0, sp, r0, lsl #6
     330:	04020000 	streq	r0, [r2], #-0
     334:	000a5a07 	andeq	r5, sl, r7, lsl #20
     338:	005e0300 	subseq	r0, lr, r0, lsl #6
     33c:	46060000 	strmi	r0, [r6], -r0
     340:	0800000c 	stmdaeq	r0, {r2, r3}
     344:	90080602 	andls	r0, r8, r2, lsl #12
     348:	07000000 	streq	r0, [r0, -r0]
     34c:	02003072 	andeq	r3, r0, #114	; 0x72
     350:	004d0e08 	subeq	r0, sp, r8, lsl #28
     354:	07000000 	streq	r0, [r0, -r0]
     358:	02003172 	andeq	r3, r0, #-2147483620	; 0x8000001c
     35c:	004d0e09 	subeq	r0, sp, r9, lsl #28
     360:	00040000 	andeq	r0, r4, r0
     364:	0009ff08 	andeq	pc, r9, r8, lsl #30
     368:	38040500 	stmdacc	r4, {r8, sl}
     36c:	02000000 	andeq	r0, r0, #0
     370:	00c70c1e 	sbceq	r0, r7, lr, lsl ip
     374:	02090000 	andeq	r0, r9, #0
     378:	00000006 	andeq	r0, r0, r6
     37c:	00073809 	andeq	r3, r7, r9, lsl #16
     380:	21090100 	mrscs	r0, (UNDEF: 25)
     384:	0200000a 	andeq	r0, r0, #10
     388:	000b0a09 	andeq	r0, fp, r9, lsl #20
     38c:	18090300 	stmdane	r9, {r8, r9}
     390:	04000007 	streq	r0, [r0], #-7
     394:	00094809 	andeq	r4, r9, r9, lsl #16
     398:	08000500 	stmdaeq	r0, {r8, sl}
     39c:	00000984 	andeq	r0, r0, r4, lsl #19
     3a0:	00380405 	eorseq	r0, r8, r5, lsl #8
     3a4:	3f020000 	svccc	0x00020000
     3a8:	0001040c 	andeq	r0, r1, ip, lsl #8
     3ac:	06c30900 	strbeq	r0, [r3], r0, lsl #18
     3b0:	09000000 	stmdbeq	r0, {}	; <UNPREDICTABLE>
     3b4:	00000733 	andeq	r0, r0, r3, lsr r7
     3b8:	0bcd0901 	bleq	ff3427c4 <__bss_end+0xff339828>
     3bc:	09020000 	stmdbeq	r2, {}	; <UNPREDICTABLE>
     3c0:	000008bb 			; <UNDEFINED> instruction: 0x000008bb
     3c4:	07270903 	streq	r0, [r7, -r3, lsl #18]!
     3c8:	09040000 	stmdbeq	r4, {}	; <UNPREDICTABLE>
     3cc:	0000076b 	andeq	r0, r0, fp, ror #14
     3d0:	061d0905 	ldreq	r0, [sp], -r5, lsl #18
     3d4:	00060000 	andeq	r0, r6, r0
     3d8:	0008990a 	andeq	r9, r8, sl, lsl #18
     3dc:	14050300 	strne	r0, [r5], #-768	; 0xfffffd00
     3e0:	00000059 	andeq	r0, r0, r9, asr r0
     3e4:	8e4c0305 	cdphi	3, 4, cr0, cr12, cr5, {0}
     3e8:	730a0000 	movwvc	r0, #40960	; 0xa000
     3ec:	0300000a 	movweq	r0, #10
     3f0:	00591406 	subseq	r1, r9, r6, lsl #8
     3f4:	03050000 	movweq	r0, #20480	; 0x5000
     3f8:	00008e50 	andeq	r8, r0, r0, asr lr
     3fc:	0007800a 	andeq	r8, r7, sl
     400:	1a070400 	bne	1c1408 <__bss_end+0x1b846c>
     404:	00000059 	andeq	r0, r0, r9, asr r0
     408:	8e540305 	cdphi	3, 5, cr0, cr4, cr5, {0}
     40c:	5b0a0000 	blpl	280414 <__bss_end+0x277478>
     410:	04000009 	streq	r0, [r0], #-9
     414:	00591a09 	subseq	r1, r9, r9, lsl #20
     418:	03050000 	movweq	r0, #20480	; 0x5000
     41c:	00008e58 	andeq	r8, r0, r8, asr lr
     420:	0007720a 	andeq	r7, r7, sl, lsl #4
     424:	1a0b0400 	bne	2c142c <__bss_end+0x2b8490>
     428:	00000059 	andeq	r0, r0, r9, asr r0
     42c:	8e5c0305 	cdphi	3, 5, cr0, cr12, cr5, {0}
     430:	350a0000 	strcc	r0, [sl, #-0]
     434:	04000009 	streq	r0, [r0], #-9
     438:	00591a0d 	subseq	r1, r9, sp, lsl #20
     43c:	03050000 	movweq	r0, #20480	; 0x5000
     440:	00008e60 	andeq	r8, r0, r0, ror #28
     444:	0005e20a 	andeq	lr, r5, sl, lsl #4
     448:	1a0f0400 	bne	3c1450 <__bss_end+0x3b84b4>
     44c:	00000059 	andeq	r0, r0, r9, asr r0
     450:	8e640305 	cdphi	3, 6, cr0, cr4, cr5, {0}
     454:	8e080000 	cdphi	0, 0, cr0, cr8, cr0, {0}
     458:	05000010 	streq	r0, [r0, #-16]
     45c:	00003804 	andeq	r3, r0, r4, lsl #16
     460:	0c1b0400 	cfldrseq	mvf0, [fp], {-0}
     464:	000001a7 	andeq	r0, r0, r7, lsr #3
     468:	00059109 	andeq	r9, r5, r9, lsl #2
     46c:	35090000 	strcc	r0, [r9, #-0]
     470:	0100000b 	tsteq	r0, fp
     474:	000bc809 	andeq	ip, fp, r9, lsl #16
     478:	0b000200 	bleq	c80 <shift+0xc80>
     47c:	00000459 	andeq	r0, r0, r9, asr r4
     480:	e4020102 	str	r0, [r2], #-258	; 0xfffffefe
     484:	0c000007 	stceq	0, cr0, [r0], {7}
     488:	00002c04 	andeq	r2, r0, r4, lsl #24
     48c:	a7040c00 	strge	r0, [r4, -r0, lsl #24]
     490:	0a000001 	beq	49c <shift+0x49c>
     494:	0000059b 	muleq	r0, fp, r5
     498:	59140405 	ldmdbpl	r4, {r0, r2, sl}
     49c:	05000000 	streq	r0, [r0, #-0]
     4a0:	008e6803 	addeq	r6, lr, r3, lsl #16
     4a4:	0a270a00 	beq	9c2cac <__bss_end+0x9b9d10>
     4a8:	07050000 	streq	r0, [r5, -r0]
     4ac:	00005914 	andeq	r5, r0, r4, lsl r9
     4b0:	6c030500 	cfstr32vs	mvfx0, [r3], {-0}
     4b4:	0a00008e 	beq	6f4 <shift+0x6f4>
     4b8:	000004e9 	andeq	r0, r0, r9, ror #9
     4bc:	59140a05 	ldmdbpl	r4, {r0, r2, r9, fp}
     4c0:	05000000 	streq	r0, [r0, #-0]
     4c4:	008e7003 	addeq	r7, lr, r3
     4c8:	06220800 	strteq	r0, [r2], -r0, lsl #16
     4cc:	04050000 	streq	r0, [r5], #-0
     4d0:	00000038 	andeq	r0, r0, r8, lsr r0
     4d4:	2c0c0d05 	stccs	13, cr0, [ip], {5}
     4d8:	0d000002 	stceq	0, cr0, [r0, #-8]
     4dc:	0077654e 	rsbseq	r6, r7, lr, asr #10
     4e0:	04c90900 	strbeq	r0, [r9], #2304	; 0x900
     4e4:	09010000 	stmdbeq	r1, {}	; <UNPREDICTABLE>
     4e8:	000004e1 	andeq	r0, r0, r1, ror #9
     4ec:	063b0902 	ldrteq	r0, [fp], -r2, lsl #18
     4f0:	09030000 	stmdbeq	r3, {}	; <UNPREDICTABLE>
     4f4:	00000afc 	strdeq	r0, [r0], -ip
     4f8:	04b60904 	ldrteq	r0, [r6], #2308	; 0x904
     4fc:	00050000 	andeq	r0, r5, r0
     500:	0005b406 	andeq	fp, r5, r6, lsl #8
     504:	1b051000 	blne	14450c <__bss_end+0x13b570>
     508:	00026b08 	andeq	r6, r2, r8, lsl #22
     50c:	726c0700 	rsbvc	r0, ip, #0, 14
     510:	131d0500 	tstne	sp, #0, 10
     514:	0000026b 	andeq	r0, r0, fp, ror #4
     518:	70730700 	rsbsvc	r0, r3, r0, lsl #14
     51c:	131e0500 	tstne	lr, #0, 10
     520:	0000026b 	andeq	r0, r0, fp, ror #4
     524:	63700704 	cmnvs	r0, #4, 14	; 0x100000
     528:	131f0500 	tstne	pc, #0, 10
     52c:	0000026b 	andeq	r0, r0, fp, ror #4
     530:	097e0e08 	ldmdbeq	lr!, {r3, r9, sl, fp}^
     534:	20050000 	andcs	r0, r5, r0
     538:	00026b13 	andeq	r6, r2, r3, lsl fp
     53c:	02000c00 	andeq	r0, r0, #0, 24
     540:	0a550704 	beq	1542158 <__bss_end+0x15391bc>
     544:	6b030000 	blvs	c054c <__bss_end+0xb75b0>
     548:	06000002 	streq	r0, [r0], -r2
     54c:	0000070b 	andeq	r0, r0, fp, lsl #14
     550:	08280570 	stmdaeq	r8!, {r4, r5, r6, r8, sl}
     554:	00000307 	andeq	r0, r0, r7, lsl #6
     558:	0006a80e 	andeq	sl, r6, lr, lsl #16
     55c:	122a0500 	eorne	r0, sl, #0, 10
     560:	0000022c 	andeq	r0, r0, ip, lsr #4
     564:	69700700 	ldmdbvs	r0!, {r8, r9, sl}^
     568:	2b050064 	blcs	140700 <__bss_end+0x137764>
     56c:	00005e12 	andeq	r5, r0, r2, lsl lr
     570:	2f0e1000 	svccs	0x000e1000
     574:	0500000b 	streq	r0, [r0, #-11]
     578:	01f5112c 	mvnseq	r1, ip, lsr #2
     57c:	0e140000 	cdpeq	0, 1, cr0, cr4, cr0, {0}
     580:	00000ad1 	ldrdeq	r0, [r0], -r1
     584:	5e122d05 	cdppl	13, 1, cr2, cr2, cr5, {0}
     588:	18000000 	stmdane	r0, {}	; <UNPREDICTABLE>
     58c:	0003e90e 	andeq	lr, r3, lr, lsl #18
     590:	122e0500 	eorne	r0, lr, #0, 10
     594:	0000005e 	andeq	r0, r0, lr, asr r0
     598:	0a140e1c 	beq	503e10 <__bss_end+0x4fae74>
     59c:	2f050000 	svccs	0x00050000
     5a0:	0003070c 	andeq	r0, r3, ip, lsl #14
     5a4:	720e2000 	andvc	r2, lr, #0
     5a8:	05000004 	streq	r0, [r0, #-4]
     5ac:	00380930 	eorseq	r0, r8, r0, lsr r9
     5b0:	0e600000 	cdpeq	0, 6, cr0, cr0, cr0, {0}
     5b4:	00000666 	andeq	r0, r0, r6, ror #12
     5b8:	4d0e3105 	stfmis	f3, [lr, #-20]	; 0xffffffec
     5bc:	64000000 	strvs	r0, [r0], #-0
     5c0:	0008ff0e 	andeq	pc, r8, lr, lsl #30
     5c4:	0e330500 	cfabs32eq	mvfx0, mvfx3
     5c8:	0000004d 	andeq	r0, r0, sp, asr #32
     5cc:	08f60e68 	ldmeq	r6!, {r3, r5, r6, r9, sl, fp}^
     5d0:	34050000 	strcc	r0, [r5], #-0
     5d4:	00004d0e 	andeq	r4, r0, lr, lsl #26
     5d8:	0f006c00 	svceq	0x00006c00
     5dc:	000001b9 			; <UNDEFINED> instruction: 0x000001b9
     5e0:	00000317 	andeq	r0, r0, r7, lsl r3
     5e4:	00005e10 	andeq	r5, r0, r0, lsl lr
     5e8:	0a000f00 	beq	41f0 <shift+0x41f0>
     5ec:	000004d2 	ldrdeq	r0, [r0], -r2
     5f0:	59140a06 	ldmdbpl	r4, {r1, r2, r9, fp}
     5f4:	05000000 	streq	r0, [r0, #-0]
     5f8:	008e7403 	addeq	r7, lr, r3, lsl #8
     5fc:	07bb0800 	ldreq	r0, [fp, r0, lsl #16]!
     600:	04050000 	streq	r0, [r5], #-0
     604:	00000038 	andeq	r0, r0, r8, lsr r0
     608:	480c0d06 	stmdami	ip, {r1, r2, r8, sl, fp}
     60c:	09000003 	stmdbeq	r0, {r0, r1}
     610:	00000bd3 	ldrdeq	r0, [r0], -r3
     614:	0b490900 	bleq	1242a1c <__bss_end+0x1239a80>
     618:	00010000 	andeq	r0, r1, r0
     61c:	00069506 	andeq	r9, r6, r6, lsl #10
     620:	1b060c00 	blne	183628 <__bss_end+0x17a68c>
     624:	00037d08 	andeq	r7, r3, r8, lsl #26
     628:	055e0e00 	ldrbeq	r0, [lr, #-3584]	; 0xfffff200
     62c:	1d060000 	stcne	0, cr0, [r6, #-0]
     630:	00037d19 	andeq	r7, r3, r9, lsl sp
     634:	c40e0000 	strgt	r0, [lr], #-0
     638:	06000004 	streq	r0, [r0], -r4
     63c:	037d191e 	cmneq	sp, #491520	; 0x78000
     640:	0e040000 	cdpeq	0, 0, cr0, cr4, cr0, {0}
     644:	000007df 	ldrdeq	r0, [r0], -pc	; <UNPREDICTABLE>
     648:	83131f06 	tsthi	r3, #6, 30
     64c:	08000003 	stmdaeq	r0, {r0, r1}
     650:	48040c00 	stmdami	r4, {sl, fp}
     654:	0c000003 	stceq	0, cr0, [r0], {3}
     658:	00027704 	andeq	r7, r2, r4, lsl #14
     65c:	096d1100 	stmdbeq	sp!, {r8, ip}^
     660:	06140000 	ldreq	r0, [r4], -r0
     664:	060b0722 	streq	r0, [fp], -r2, lsr #14
     668:	a70e0000 	strge	r0, [lr, -r0]
     66c:	06000008 	streq	r0, [r0], -r8
     670:	004d1226 	subeq	r1, sp, r6, lsr #4
     674:	0e000000 	cdpeq	0, 0, cr0, cr0, cr0, {0}
     678:	00000849 	andeq	r0, r0, r9, asr #16
     67c:	7d1d2906 	vldrvc.16	s4, [sp, #-12]	; <UNPREDICTABLE>
     680:	04000003 	streq	r0, [r0], #-3
     684:	0006430e 	andeq	r4, r6, lr, lsl #6
     688:	1d2c0600 	stcne	6, cr0, [ip, #-0]
     68c:	0000037d 	andeq	r0, r0, sp, ror r3
     690:	08b11208 	ldmeq	r1!, {r3, r9, ip}
     694:	2f060000 	svccs	0x00060000
     698:	0006720e 	andeq	r7, r6, lr, lsl #4
     69c:	0003d100 	andeq	sp, r3, r0, lsl #2
     6a0:	0003dc00 	andeq	sp, r3, r0, lsl #24
     6a4:	06101300 	ldreq	r1, [r0], -r0, lsl #6
     6a8:	7d140000 	ldcvc	0, cr0, [r4, #-0]
     6ac:	00000003 	andeq	r0, r0, r3
     6b0:	00074215 	andeq	r4, r7, r5, lsl r2
     6b4:	0e310600 	cfmsuba32eq	mvax0, mvax0, mvfx1, mvfx0
     6b8:	000006e2 	andeq	r0, r0, r2, ror #13
     6bc:	000001ac 	andeq	r0, r0, ip, lsr #3
     6c0:	000003f4 	strdeq	r0, [r0], -r4
     6c4:	000003ff 	strdeq	r0, [r0], -pc	; <UNPREDICTABLE>
     6c8:	00061013 	andeq	r1, r6, r3, lsl r0
     6cc:	03831400 	orreq	r1, r3, #0, 8
     6d0:	16000000 	strne	r0, [r0], -r0
     6d4:	00000b10 	andeq	r0, r0, r0, lsl fp
     6d8:	961d3506 	ldrls	r3, [sp], -r6, lsl #10
     6dc:	7d000007 	stcvc	0, cr0, [r0, #-28]	; 0xffffffe4
     6e0:	02000003 	andeq	r0, r0, #3
     6e4:	00000418 	andeq	r0, r0, r8, lsl r4
     6e8:	0000041e 	andeq	r0, r0, lr, lsl r4
     6ec:	00061013 	andeq	r1, r6, r3, lsl r0
     6f0:	2e160000 	cdpcs	0, 1, cr0, cr6, cr0, {0}
     6f4:	06000006 	streq	r0, [r0], -r6
     6f8:	08c11d37 	stmiaeq	r1, {r0, r1, r2, r4, r5, r8, sl, fp, ip}^
     6fc:	037d0000 	cmneq	sp, #0
     700:	37020000 	strcc	r0, [r2, -r0]
     704:	3d000004 	stccc	0, cr0, [r0, #-16]
     708:	13000004 	movwne	r0, #4
     70c:	00000610 	andeq	r0, r0, r0, lsl r6
     710:	085c1700 	ldmdaeq	ip, {r8, r9, sl, ip}^
     714:	39060000 	stmdbcc	r6, {}	; <UNPREDICTABLE>
     718:	00062931 	andeq	r2, r6, r1, lsr r9
     71c:	16020c00 	strne	r0, [r2], -r0, lsl #24
     720:	0000096d 	andeq	r0, r0, sp, ror #18
     724:	51093c06 	tstpl	r9, r6, lsl #24
     728:	10000007 	andne	r0, r0, r7
     72c:	01000006 	tsteq	r0, r6
     730:	00000464 	andeq	r0, r0, r4, ror #8
     734:	0000046a 	andeq	r0, r0, sl, ror #8
     738:	00061013 	andeq	r1, r6, r3, lsl r0
     73c:	b4160000 	ldrlt	r0, [r6], #-0
     740:	06000006 	streq	r0, [r0], -r6
     744:	051a123f 	ldreq	r1, [sl, #-575]	; 0xfffffdc1
     748:	004d0000 	subeq	r0, sp, r0
     74c:	83010000 	movwhi	r0, #4096	; 0x1000
     750:	98000004 	stmdals	r0, {r2}
     754:	13000004 	movwne	r0, #4
     758:	00000610 	andeq	r0, r0, r0, lsl r6
     75c:	00063214 	andeq	r3, r6, r4, lsl r2
     760:	005e1400 	subseq	r1, lr, r0, lsl #8
     764:	ac140000 	ldcge	0, cr0, [r4], {-0}
     768:	00000001 	andeq	r0, r0, r1
     76c:	000b4018 	andeq	r4, fp, r8, lsl r0
     770:	0e420600 	cdpeq	6, 4, cr0, cr2, cr0, {0}
     774:	000005c1 	andeq	r0, r0, r1, asr #11
     778:	0004ad01 	andeq	sl, r4, r1, lsl #26
     77c:	0004b300 	andeq	fp, r4, r0, lsl #6
     780:	06101300 	ldreq	r1, [r0], -r0, lsl #6
     784:	16000000 	strne	r0, [r0], -r0
     788:	000004fc 	strdeq	r0, [r0], -ip
     78c:	63174506 	tstvs	r7, #25165824	; 0x1800000
     790:	83000005 	movwhi	r0, #5
     794:	01000003 	tsteq	r0, r3
     798:	000004cc 	andeq	r0, r0, ip, asr #9
     79c:	000004d2 	ldrdeq	r0, [r0], -r2
     7a0:	00063813 	andeq	r3, r6, r3, lsl r8
     7a4:	32160000 	andscc	r0, r6, #0
     7a8:	0600000a 	streq	r0, [r0], -sl
     7ac:	03ff1748 	mvnseq	r1, #72, 14	; 0x1200000
     7b0:	03830000 	orreq	r0, r3, #0
     7b4:	eb010000 	bl	407bc <__bss_end+0x37820>
     7b8:	f6000004 			; <UNDEFINED> instruction: 0xf6000004
     7bc:	13000004 	movwne	r0, #4
     7c0:	00000638 	andeq	r0, r0, r8, lsr r6
     7c4:	00004d14 	andeq	r4, r0, r4, lsl sp
     7c8:	ec180000 	ldc	0, cr0, [r8], {-0}
     7cc:	06000005 	streq	r0, [r0], -r5
     7d0:	086a0e4b 	stmdaeq	sl!, {r0, r1, r3, r6, r9, sl, fp}^
     7d4:	0b010000 	bleq	407dc <__bss_end+0x37840>
     7d8:	11000005 	tstne	r0, r5
     7dc:	13000005 	movwne	r0, #5
     7e0:	00000610 	andeq	r0, r0, r0, lsl r6
     7e4:	07421600 	strbeq	r1, [r2, -r0, lsl #12]
     7e8:	4d060000 	stcmi	0, cr0, [r6, #-0]
     7ec:	00090d0e 	andeq	r0, r9, lr, lsl #26
     7f0:	0001ac00 	andeq	sl, r1, r0, lsl #24
     7f4:	052a0100 	streq	r0, [sl, #-256]!	; 0xffffff00
     7f8:	05350000 	ldreq	r0, [r5, #-0]!
     7fc:	10130000 	andsne	r0, r3, r0
     800:	14000006 	strne	r0, [r0], #-6
     804:	0000004d 	andeq	r0, r0, sp, asr #32
     808:	04a21600 	strteq	r1, [r2], #1536	; 0x600
     80c:	50060000 	andpl	r0, r6, r0
     810:	00042c12 	andeq	r2, r4, r2, lsl ip
     814:	00004d00 	andeq	r4, r0, r0, lsl #26
     818:	054e0100 	strbeq	r0, [lr, #-256]	; 0xffffff00
     81c:	05590000 	ldrbeq	r0, [r9, #-0]
     820:	10130000 	andsne	r0, r3, r0
     824:	14000006 	strne	r0, [r0], #-6
     828:	000001b9 			; <UNDEFINED> instruction: 0x000001b9
     82c:	045f1600 	ldrbeq	r1, [pc], #-1536	; 834 <shift+0x834>
     830:	53060000 	movwpl	r0, #24576	; 0x6000
     834:	000b540e 	andeq	r5, fp, lr, lsl #8
     838:	0001ac00 	andeq	sl, r1, r0, lsl #24
     83c:	05720100 	ldrbeq	r0, [r2, #-256]!	; 0xffffff00
     840:	057d0000 	ldrbeq	r0, [sp, #-0]!
     844:	10130000 	andsne	r0, r3, r0
     848:	14000006 	strne	r0, [r0], #-6
     84c:	0000004d 	andeq	r0, r0, sp, asr #32
     850:	047c1800 	ldrbteq	r1, [ip], #-2048	; 0xfffff800
     854:	56060000 	strpl	r0, [r6], -r0
     858:	000a7f0e 	andeq	r7, sl, lr, lsl #30
     85c:	05920100 	ldreq	r0, [r2, #256]	; 0x100
     860:	05b10000 	ldreq	r0, [r1, #0]!
     864:	10130000 	andsne	r0, r3, r0
     868:	14000006 	strne	r0, [r0], #-6
     86c:	00000090 	muleq	r0, r0, r0
     870:	00004d14 	andeq	r4, r0, r4, lsl sp
     874:	004d1400 	subeq	r1, sp, r0, lsl #8
     878:	4d140000 	ldcmi	0, cr0, [r4, #-0]
     87c:	14000000 	strne	r0, [r0], #-0
     880:	0000063e 	andeq	r0, r0, lr, lsr r6
     884:	0b801800 	bleq	fe00688c <__bss_end+0xfdffd8f0>
     888:	58060000 	stmdapl	r6, {}	; <UNPREDICTABLE>
     88c:	000bfa0e 	andeq	pc, fp, lr, lsl #20
     890:	05c60100 	strbeq	r0, [r6, #256]	; 0x100
     894:	05e50000 	strbeq	r0, [r5, #0]!
     898:	10130000 	andsne	r0, r3, r0
     89c:	14000006 	strne	r0, [r0], #-6
     8a0:	000000c7 	andeq	r0, r0, r7, asr #1
     8a4:	00004d14 	andeq	r4, r0, r4, lsl sp
     8a8:	004d1400 	subeq	r1, sp, r0, lsl #8
     8ac:	4d140000 	ldcmi	0, cr0, [r4, #-0]
     8b0:	14000000 	strne	r0, [r0], #-0
     8b4:	0000063e 	andeq	r0, r0, lr, lsr r6
     8b8:	048f1900 	streq	r1, [pc], #2304	; 8c0 <shift+0x8c0>
     8bc:	5b060000 	blpl	1808c4 <__bss_end+0x177928>
     8c0:	0007e90e 	andeq	lr, r7, lr, lsl #18
     8c4:	0001ac00 	andeq	sl, r1, r0, lsl #24
     8c8:	05fa0100 	ldrbeq	r0, [sl, #256]!	; 0x100
     8cc:	10130000 	andsne	r0, r3, r0
     8d0:	14000006 	strne	r0, [r0], #-6
     8d4:	00000329 	andeq	r0, r0, r9, lsr #6
     8d8:	00064414 	andeq	r4, r6, r4, lsl r4
     8dc:	03000000 	movweq	r0, #0
     8e0:	00000389 	andeq	r0, r0, r9, lsl #7
     8e4:	0389040c 	orreq	r0, r9, #12, 8	; 0xc000000
     8e8:	7d1a0000 	ldcvc	0, cr0, [sl, #-0]
     8ec:	23000003 	movwcs	r0, #3
     8f0:	29000006 	stmdbcs	r0, {r1, r2}
     8f4:	13000006 	movwne	r0, #6
     8f8:	00000610 	andeq	r0, r0, r0, lsl r6
     8fc:	03891b00 	orreq	r1, r9, #0, 22
     900:	06160000 	ldreq	r0, [r6], -r0
     904:	040c0000 	streq	r0, [ip], #-0
     908:	0000003f 	andeq	r0, r0, pc, lsr r0
     90c:	060b040c 	streq	r0, [fp], -ip, lsl #8
     910:	041c0000 	ldreq	r0, [ip], #-0
     914:	0000006a 	andeq	r0, r0, sl, rrx
     918:	681e041d 	ldmdavs	lr, {r0, r2, r3, r4, sl}
     91c:	07006c61 	streq	r6, [r0, -r1, ror #24]
     920:	07100b05 	ldreq	r0, [r0, -r5, lsl #22]
     924:	361f0000 	ldrcc	r0, [pc], -r0
     928:	07000008 	streq	r0, [r0, -r8]
     92c:	00651907 	rsbeq	r1, r5, r7, lsl #18
     930:	b2800000 	addlt	r0, r0, #0
     934:	451f0ee6 	ldrmi	r0, [pc, #-3814]	; fffffa56 <__bss_end+0xffff6aba>
     938:	0700000a 	streq	r0, [r0, -sl]
     93c:	02721a0a 	rsbseq	r1, r2, #40960	; 0xa000
     940:	00000000 	andeq	r0, r0, r0
     944:	101f2000 	andsne	r2, pc, r0
     948:	07000005 	streq	r0, [r0, -r5]
     94c:	02721a0d 	rsbseq	r1, r2, #53248	; 0xd000
     950:	00000000 	andeq	r0, r0, r0
     954:	d0202020 	eorle	r2, r0, r0, lsr #32
     958:	07000007 	streq	r0, [r0, -r7]
     95c:	00591510 	subseq	r1, r9, r0, lsl r5
     960:	1f360000 	svcne	0x00360000
     964:	00000b1c 	andeq	r0, r0, ip, lsl fp
     968:	721a4207 	andsvc	r4, sl, #1879048192	; 0x70000000
     96c:	00000002 	andeq	r0, r0, r2
     970:	1f202150 	svcne	0x00202150
     974:	00000bae 	andeq	r0, r0, lr, lsr #23
     978:	721a7107 	andsvc	r7, sl, #-1073741823	; 0xc0000001
     97c:	00000002 	andeq	r0, r0, r2
     980:	1f2000b2 	svcne	0x002000b2
     984:	000006cd 	andeq	r0, r0, sp, asr #13
     988:	721aa407 	andsvc	sl, sl, #117440512	; 0x7000000
     98c:	00000002 	andeq	r0, r0, r2
     990:	1f2000b4 	svcne	0x002000b4
     994:	0000082c 	andeq	r0, r0, ip, lsr #16
     998:	721ab307 	andsvc	fp, sl, #469762048	; 0x1c000000
     99c:	00000002 	andeq	r0, r0, r2
     9a0:	1f201040 	svcne	0x00201040
     9a4:	000008e7 	andeq	r0, r0, r7, ror #17
     9a8:	721abe07 	andsvc	fp, sl, #7, 28	; 0x70
     9ac:	00000002 	andeq	r0, r0, r2
     9b0:	1f202050 	svcne	0x00202050
     9b4:	00000613 	andeq	r0, r0, r3, lsl r6
     9b8:	721abf07 	andsvc	fp, sl, #7, 30
     9bc:	00000002 	andeq	r0, r0, r2
     9c0:	1f208040 	svcne	0x00208040
     9c4:	00000b25 	andeq	r0, r0, r5, lsr #22
     9c8:	721ac007 	andsvc	ip, sl, #7
     9cc:	00000002 	andeq	r0, r0, r2
     9d0:	1f208050 	svcne	0x00208050
     9d4:	00000aed 	andeq	r0, r0, sp, ror #21
     9d8:	721ace07 	andsvc	ip, sl, #7, 28	; 0x70
     9dc:	00000002 	andeq	r0, r0, r2
     9e0:	00202140 	eoreq	r2, r0, r0, asr #2
     9e4:	00065221 	andeq	r5, r6, r1, lsr #4
     9e8:	06622100 	strbteq	r2, [r2], -r0, lsl #2
     9ec:	72210000 	eorvc	r0, r1, #0
     9f0:	21000006 	tstcs	r0, r6
     9f4:	00000682 	andeq	r0, r0, r2, lsl #13
     9f8:	00068f21 	andeq	r8, r6, r1, lsr #30
     9fc:	069f2100 	ldreq	r2, [pc], r0, lsl #2
     a00:	af210000 	svcge	0x00210000
     a04:	21000006 	tstcs	r0, r6
     a08:	000006bf 			; <UNDEFINED> instruction: 0x000006bf
     a0c:	0006cf21 	andeq	ip, r6, r1, lsr #30
     a10:	06df2100 	ldrbeq	r2, [pc], r0, lsl #2
     a14:	ef210000 	svc	0x00210000
     a18:	21000006 	tstcs	r0, r6
     a1c:	000006ff 	strdeq	r0, [r0], -pc	; <UNPREDICTABLE>
     a20:	000a670a 	andeq	r6, sl, sl, lsl #14
     a24:	14080800 	strne	r0, [r8], #-2048	; 0xfffff800
     a28:	00000059 	andeq	r0, r0, r9, asr r0
     a2c:	8ea80305 	cdphi	3, 10, cr0, cr8, cr5, {0}
     a30:	450a0000 	strmi	r0, [sl, #-0]
     a34:	09000005 	stmdbeq	r0, {r0, r2}
     a38:	00591408 	subseq	r1, r9, r8, lsl #8
     a3c:	03050000 	movweq	r0, #20480	; 0x5000
     a40:	00008eac 	andeq	r8, r0, ip, lsr #29
     a44:	0025040c 	eoreq	r0, r5, ip, lsl #8
     a48:	e80a0000 	stmda	sl, {}	; <UNPREDICTABLE>
     a4c:	0100000b 	tsteq	r0, fp
     a50:	0059140e 	subseq	r1, r9, lr, lsl #8
     a54:	03050000 	movweq	r0, #20480	; 0x5000
     a58:	00008eb0 			; <UNDEFINED> instruction: 0x00008eb0
     a5c:	0006560a 	andeq	r5, r6, sl, lsl #12
     a60:	140f0100 	strne	r0, [pc], #-256	; a68 <shift+0xa68>
     a64:	00000059 	andeq	r0, r0, r9, asr r0
     a68:	8eb40305 	cdphi	3, 11, cr0, cr4, cr5, {0}
     a6c:	bd220000 	stclt	0, cr0, [r2, #-0]
     a70:	01000004 	tsteq	r0, r4
     a74:	004d0a11 	subeq	r0, sp, r1, lsl sl
     a78:	03050000 	movweq	r0, #20480	; 0x5000
     a7c:	00008f84 	andeq	r8, r0, r4, lsl #31
     a80:	00072d22 	andeq	r2, r7, r2, lsr #26
     a84:	12110100 	andsne	r0, r1, #0, 2
     a88:	0000004d 	andeq	r0, r0, sp, asr #32
     a8c:	8f880305 	svchi	0x00880305
     a90:	a9230000 	stmdbge	r3!, {}	; <UNPREDICTABLE>
     a94:	0100000b 	tsteq	r0, fp
     a98:	00380532 	eorseq	r0, r8, r2, lsr r5
     a9c:	82700000 	rsbshi	r0, r0, #0
     aa0:	00b80000 	adcseq	r0, r8, r0
     aa4:	9c010000 	stcls	0, cr0, [r1], {-0}
     aa8:	00000806 	andeq	r0, r0, r6, lsl #16
     aac:	0008f124 	andeq	pc, r8, r4, lsr #2
     ab0:	0e320100 	rsfeqs	f0, f2, f0
     ab4:	00000038 	andeq	r0, r0, r8, lsr r0
     ab8:	246c9102 	strbtcs	r9, [ip], #-258	; 0xfffffefe
     abc:	00000908 	andeq	r0, r0, r8, lsl #18
     ac0:	061b3201 	ldreq	r3, [fp], -r1, lsl #4
     ac4:	02000008 	andeq	r0, r0, #8
     ac8:	c8256891 	stmdagt	r5!, {r0, r4, r7, fp, sp, lr}
     acc:	01000006 	tsteq	r0, r6
     ad0:	080c0a34 	stmdaeq	ip, {r2, r4, r5, r9, fp}
     ad4:	91020000 	mrsls	r0, (UNDEF: 2)
     ad8:	040c0074 	streq	r0, [ip], #-116	; 0xffffff8c
     adc:	00000770 	andeq	r0, r0, r0, ror r7
     ae0:	0000250f 	andeq	r2, r0, pc, lsl #10
     ae4:	00081c00 	andeq	r1, r8, r0, lsl #24
     ae8:	005e1000 	subseq	r1, lr, r0
     aec:	00030000 	andeq	r0, r3, r0
     af0:	676f6c26 	strbvs	r6, [pc, -r6, lsr #24]!
     af4:	06130100 	ldreq	r0, [r3], -r0, lsl #2
     af8:	000006d8 	ldrdeq	r0, [r0], -r8
     afc:	0000822c 	andeq	r8, r0, ip, lsr #4
     b00:	00000044 	andeq	r0, r0, r4, asr #32
     b04:	6d279c01 	stcvs	12, cr9, [r7, #-4]!
     b08:	01006773 	tsteq	r0, r3, ror r7
     b0c:	01b31613 			; <UNDEFINED> instruction: 0x01b31613
     b10:	91020000 	mrsls	r0, (UNDEF: 2)
     b14:	1f00006c 	svcne	0x0000006c
     b18:	0400000b 	streq	r0, [r0], #-11
     b1c:	00044400 	andeq	r4, r4, r0, lsl #8
     b20:	8a010400 	bhi	41b28 <__bss_end+0x38b8c>
     b24:	0400000f 	streq	r0, [r0], #-15
     b28:	00000e63 	andeq	r0, r0, r3, ror #28
     b2c:	00000c52 	andeq	r0, r0, r2, asr ip
     b30:	00008328 	andeq	r8, r0, r8, lsr #6
     b34:	0000045c 	andeq	r0, r0, ip, asr r4
     b38:	00000544 	andeq	r0, r0, r4, asr #10
     b3c:	e8080102 	stmda	r8, {r1, r8}
     b40:	0300000a 	movweq	r0, #10
     b44:	00000025 	andeq	r0, r0, r5, lsr #32
     b48:	51050202 	tstpl	r5, r2, lsl #4
     b4c:	04000009 	streq	r0, [r0], #-9
     b50:	6e690504 	cdpvs	5, 6, cr0, cr9, cr4, {0}
     b54:	01020074 	tsteq	r2, r4, ror r0
     b58:	000adf08 	andeq	sp, sl, r8, lsl #30
     b5c:	07020200 	streq	r0, [r2, -r0, lsl #4]
     b60:	00000b96 	muleq	r0, r6, fp
     b64:	00060a05 	andeq	r0, r6, r5, lsl #20
     b68:	07090700 	streq	r0, [r9, -r0, lsl #14]
     b6c:	0000005e 	andeq	r0, r0, lr, asr r0
     b70:	00004d03 	andeq	r4, r0, r3, lsl #26
     b74:	07040200 	streq	r0, [r4, -r0, lsl #4]
     b78:	00000a5a 	andeq	r0, r0, sl, asr sl
     b7c:	000c4606 	andeq	r4, ip, r6, lsl #12
     b80:	06020800 	streq	r0, [r2], -r0, lsl #16
     b84:	00008b08 	andeq	r8, r0, r8, lsl #22
     b88:	30720700 	rsbscc	r0, r2, r0, lsl #14
     b8c:	0e080200 	cdpeq	2, 0, cr0, cr8, cr0, {0}
     b90:	0000004d 	andeq	r0, r0, sp, asr #32
     b94:	31720700 	cmncc	r2, r0, lsl #14
     b98:	0e090200 	cdpeq	2, 0, cr0, cr9, cr0, {0}
     b9c:	0000004d 	andeq	r0, r0, sp, asr #32
     ba0:	14080004 	strne	r0, [r8], #-4
     ba4:	0500000f 	streq	r0, [r0, #-15]
     ba8:	00003804 	andeq	r3, r0, r4, lsl #16
     bac:	0c0d0200 	sfmeq	f0, 4, [sp], {-0}
     bb0:	000000a9 	andeq	r0, r0, r9, lsr #1
     bb4:	004b4f09 	subeq	r4, fp, r9, lsl #30
     bb8:	0d000a00 	vstreq	s0, [r0, #-0]
     bbc:	00010000 	andeq	r0, r1, r0
     bc0:	0009ff08 	andeq	pc, r9, r8, lsl #30
     bc4:	38040500 	stmdacc	r4, {r8, sl}
     bc8:	02000000 	andeq	r0, r0, #0
     bcc:	00e00c1e 	rsceq	r0, r0, lr, lsl ip
     bd0:	020a0000 	andeq	r0, sl, #0
     bd4:	00000006 	andeq	r0, r0, r6
     bd8:	0007380a 	andeq	r3, r7, sl, lsl #16
     bdc:	210a0100 	mrscs	r0, (UNDEF: 26)
     be0:	0200000a 	andeq	r0, r0, #10
     be4:	000b0a0a 	andeq	r0, fp, sl, lsl #20
     be8:	180a0300 	stmdane	sl, {r8, r9}
     bec:	04000007 	streq	r0, [r0], #-7
     bf0:	0009480a 	andeq	r4, r9, sl, lsl #16
     bf4:	08000500 	stmdaeq	r0, {r8, sl}
     bf8:	00000984 	andeq	r0, r0, r4, lsl #19
     bfc:	00380405 	eorseq	r0, r8, r5, lsl #8
     c00:	3f020000 	svccc	0x00020000
     c04:	00011d0c 	andeq	r1, r1, ip, lsl #26
     c08:	06c30a00 	strbeq	r0, [r3], r0, lsl #20
     c0c:	0a000000 	beq	c14 <shift+0xc14>
     c10:	00000733 	andeq	r0, r0, r3, lsr r7
     c14:	0bcd0a01 	bleq	ff343420 <__bss_end+0xff33a484>
     c18:	0a020000 	beq	80c20 <__bss_end+0x77c84>
     c1c:	000008bb 			; <UNDEFINED> instruction: 0x000008bb
     c20:	07270a03 	streq	r0, [r7, -r3, lsl #20]!
     c24:	0a040000 	beq	100c2c <__bss_end+0xf7c90>
     c28:	0000076b 	andeq	r0, r0, fp, ror #14
     c2c:	061d0a05 	ldreq	r0, [sp], -r5, lsl #20
     c30:	00060000 	andeq	r0, r6, r0
     c34:	00103b08 	andseq	r3, r0, r8, lsl #22
     c38:	38040500 	stmdacc	r4, {r8, sl}
     c3c:	02000000 	andeq	r0, r0, #0
     c40:	01480c66 	cmpeq	r8, r6, ror #24
     c44:	580a0000 	stmdapl	sl, {}	; <UNPREDICTABLE>
     c48:	0000000e 	andeq	r0, r0, lr
     c4c:	000d5d0a 	andeq	r5, sp, sl, lsl #26
     c50:	dd0a0100 	stfles	f0, [sl, #-0]
     c54:	0200000e 	andeq	r0, r0, #14
     c58:	000d820a 	andeq	r8, sp, sl, lsl #4
     c5c:	0b000300 	bleq	1864 <shift+0x1864>
     c60:	00000899 	muleq	r0, r9, r8
     c64:	59140503 	ldmdbpl	r4, {r0, r1, r8, sl}
     c68:	05000000 	streq	r0, [r0, #-0]
     c6c:	008f3803 	addeq	r3, pc, r3, lsl #16
     c70:	0a730b00 	beq	1cc3878 <__bss_end+0x1cba8dc>
     c74:	06030000 	streq	r0, [r3], -r0
     c78:	00005914 	andeq	r5, r0, r4, lsl r9
     c7c:	3c030500 	cfstr32cc	mvfx0, [r3], {-0}
     c80:	0b00008f 	bleq	ec4 <shift+0xec4>
     c84:	00000780 	andeq	r0, r0, r0, lsl #15
     c88:	591a0704 	ldmdbpl	sl, {r2, r8, r9, sl}
     c8c:	05000000 	streq	r0, [r0, #-0]
     c90:	008f4003 	addeq	r4, pc, r3
     c94:	095b0b00 	ldmdbeq	fp, {r8, r9, fp}^
     c98:	09040000 	stmdbeq	r4, {}	; <UNPREDICTABLE>
     c9c:	0000591a 	andeq	r5, r0, sl, lsl r9
     ca0:	44030500 	strmi	r0, [r3], #-1280	; 0xfffffb00
     ca4:	0b00008f 	bleq	ee8 <shift+0xee8>
     ca8:	00000772 	andeq	r0, r0, r2, ror r7
     cac:	591a0b04 	ldmdbpl	sl, {r2, r8, r9, fp}
     cb0:	05000000 	streq	r0, [r0, #-0]
     cb4:	008f4803 	addeq	r4, pc, r3, lsl #16
     cb8:	09350b00 	ldmdbeq	r5!, {r8, r9, fp}
     cbc:	0d040000 	stceq	0, cr0, [r4, #-0]
     cc0:	0000591a 	andeq	r5, r0, sl, lsl r9
     cc4:	4c030500 	cfstr32mi	mvfx0, [r3], {-0}
     cc8:	0b00008f 	bleq	f0c <shift+0xf0c>
     ccc:	000005e2 	andeq	r0, r0, r2, ror #11
     cd0:	591a0f04 	ldmdbpl	sl, {r2, r8, r9, sl, fp}
     cd4:	05000000 	streq	r0, [r0, #-0]
     cd8:	008f5003 	addeq	r5, pc, r3
     cdc:	108e0800 	addne	r0, lr, r0, lsl #16
     ce0:	04050000 	streq	r0, [r5], #-0
     ce4:	00000038 	andeq	r0, r0, r8, lsr r0
     ce8:	eb0c1b04 	bl	307900 <__bss_end+0x2fe964>
     cec:	0a000001 	beq	cf8 <shift+0xcf8>
     cf0:	00000591 	muleq	r0, r1, r5
     cf4:	0b350a00 	bleq	d434fc <__bss_end+0xd3a560>
     cf8:	0a010000 	beq	40d00 <__bss_end+0x37d64>
     cfc:	00000bc8 	andeq	r0, r0, r8, asr #23
     d00:	590c0002 	stmdbpl	ip, {r1}
     d04:	02000004 	andeq	r0, r0, #4
     d08:	07e40201 	strbeq	r0, [r4, r1, lsl #4]!
     d0c:	040d0000 	streq	r0, [sp], #-0
     d10:	0000002c 	andeq	r0, r0, ip, lsr #32
     d14:	01eb040d 	mvneq	r0, sp, lsl #8
     d18:	9b0b0000 	blls	2c0d20 <__bss_end+0x2b7d84>
     d1c:	05000005 	streq	r0, [r0, #-5]
     d20:	00591404 	subseq	r1, r9, r4, lsl #8
     d24:	03050000 	movweq	r0, #20480	; 0x5000
     d28:	00008f54 	andeq	r8, r0, r4, asr pc
     d2c:	000a270b 	andeq	r2, sl, fp, lsl #14
     d30:	14070500 	strne	r0, [r7], #-1280	; 0xfffffb00
     d34:	00000059 	andeq	r0, r0, r9, asr r0
     d38:	8f580305 	svchi	0x00580305
     d3c:	e90b0000 	stmdb	fp, {}	; <UNPREDICTABLE>
     d40:	05000004 	streq	r0, [r0, #-4]
     d44:	0059140a 	subseq	r1, r9, sl, lsl #8
     d48:	03050000 	movweq	r0, #20480	; 0x5000
     d4c:	00008f5c 	andeq	r8, r0, ip, asr pc
     d50:	00062208 	andeq	r2, r6, r8, lsl #4
     d54:	38040500 	stmdacc	r4, {r8, sl}
     d58:	05000000 	streq	r0, [r0, #-0]
     d5c:	02700c0d 	rsbseq	r0, r0, #3328	; 0xd00
     d60:	4e090000 	cdpmi	0, 0, cr0, cr9, cr0, {0}
     d64:	00007765 	andeq	r7, r0, r5, ror #14
     d68:	0004c90a 	andeq	ip, r4, sl, lsl #18
     d6c:	e10a0100 	mrs	r0, (UNDEF: 26)
     d70:	02000004 	andeq	r0, r0, #4
     d74:	00063b0a 	andeq	r3, r6, sl, lsl #22
     d78:	fc0a0300 	stc2	3, cr0, [sl], {-0}
     d7c:	0400000a 	streq	r0, [r0], #-10
     d80:	0004b60a 	andeq	fp, r4, sl, lsl #12
     d84:	06000500 	streq	r0, [r0], -r0, lsl #10
     d88:	000005b4 			; <UNDEFINED> instruction: 0x000005b4
     d8c:	081b0510 	ldmdaeq	fp, {r4, r8, sl}
     d90:	000002af 	andeq	r0, r0, pc, lsr #5
     d94:	00726c07 	rsbseq	r6, r2, r7, lsl #24
     d98:	af131d05 	svcge	0x00131d05
     d9c:	00000002 	andeq	r0, r0, r2
     da0:	00707307 	rsbseq	r7, r0, r7, lsl #6
     da4:	af131e05 	svcge	0x00131e05
     da8:	04000002 	streq	r0, [r0], #-2
     dac:	00637007 	rsbeq	r7, r3, r7
     db0:	af131f05 	svcge	0x00131f05
     db4:	08000002 	stmdaeq	r0, {r1}
     db8:	00097e0e 	andeq	r7, r9, lr, lsl #28
     dbc:	13200500 	nopne	{0}	; <UNPREDICTABLE>
     dc0:	000002af 	andeq	r0, r0, pc, lsr #5
     dc4:	0402000c 	streq	r0, [r2], #-12
     dc8:	000a5507 	andeq	r5, sl, r7, lsl #10
     dcc:	070b0600 	streq	r0, [fp, -r0, lsl #12]
     dd0:	05700000 	ldrbeq	r0, [r0, #-0]!
     dd4:	03460828 	movteq	r0, #26664	; 0x6828
     dd8:	a80e0000 	stmdage	lr, {}	; <UNPREDICTABLE>
     ddc:	05000006 	streq	r0, [r0, #-6]
     de0:	0270122a 	rsbseq	r1, r0, #-1610612734	; 0xa0000002
     de4:	07000000 	streq	r0, [r0, -r0]
     de8:	00646970 	rsbeq	r6, r4, r0, ror r9
     dec:	5e122b05 	vnmlspl.f64	d2, d2, d5
     df0:	10000000 	andne	r0, r0, r0
     df4:	000b2f0e 	andeq	r2, fp, lr, lsl #30
     df8:	112c0500 			; <UNDEFINED> instruction: 0x112c0500
     dfc:	00000239 	andeq	r0, r0, r9, lsr r2
     e00:	0ad10e14 	beq	ff444658 <__bss_end+0xff43b6bc>
     e04:	2d050000 	stccs	0, cr0, [r5, #-0]
     e08:	00005e12 	andeq	r5, r0, r2, lsl lr
     e0c:	e90e1800 	stmdb	lr, {fp, ip}
     e10:	05000003 	streq	r0, [r0, #-3]
     e14:	005e122e 	subseq	r1, lr, lr, lsr #4
     e18:	0e1c0000 	cdpeq	0, 1, cr0, cr12, cr0, {0}
     e1c:	00000a14 	andeq	r0, r0, r4, lsl sl
     e20:	460c2f05 	strmi	r2, [ip], -r5, lsl #30
     e24:	20000003 	andcs	r0, r0, r3
     e28:	0004720e 	andeq	r7, r4, lr, lsl #4
     e2c:	09300500 	ldmdbeq	r0!, {r8, sl}
     e30:	00000038 	andeq	r0, r0, r8, lsr r0
     e34:	06660e60 	strbteq	r0, [r6], -r0, ror #28
     e38:	31050000 	mrscc	r0, (UNDEF: 5)
     e3c:	00004d0e 	andeq	r4, r0, lr, lsl #26
     e40:	ff0e6400 			; <UNDEFINED> instruction: 0xff0e6400
     e44:	05000008 	streq	r0, [r0, #-8]
     e48:	004d0e33 	subeq	r0, sp, r3, lsr lr
     e4c:	0e680000 	cdpeq	0, 6, cr0, cr8, cr0, {0}
     e50:	000008f6 	strdeq	r0, [r0], -r6
     e54:	4d0e3405 	cfstrsmi	mvf3, [lr, #-20]	; 0xffffffec
     e58:	6c000000 	stcvs	0, cr0, [r0], {-0}
     e5c:	01fd0f00 	mvnseq	r0, r0, lsl #30
     e60:	03560000 	cmpeq	r6, #0
     e64:	5e100000 	cdppl	0, 1, cr0, cr0, cr0, {0}
     e68:	0f000000 	svceq	0x00000000
     e6c:	04d20b00 	ldrbeq	r0, [r2], #2816	; 0xb00
     e70:	0a060000 	beq	180e78 <__bss_end+0x177edc>
     e74:	00005914 	andeq	r5, r0, r4, lsl r9
     e78:	60030500 	andvs	r0, r3, r0, lsl #10
     e7c:	0800008f 	stmdaeq	r0, {r0, r1, r2, r3, r7}
     e80:	000007bb 			; <UNDEFINED> instruction: 0x000007bb
     e84:	00380405 	eorseq	r0, r8, r5, lsl #8
     e88:	0d060000 	stceq	0, cr0, [r6, #-0]
     e8c:	0003870c 	andeq	r8, r3, ip, lsl #14
     e90:	0bd30a00 	bleq	ff4c3698 <__bss_end+0xff4ba6fc>
     e94:	0a000000 	beq	e9c <shift+0xe9c>
     e98:	00000b49 	andeq	r0, r0, r9, asr #22
     e9c:	68030001 	stmdavs	r3, {r0}
     ea0:	08000003 	stmdaeq	r0, {r0, r1}
     ea4:	00000dea 	andeq	r0, r0, sl, ror #27
     ea8:	00380405 	eorseq	r0, r8, r5, lsl #8
     eac:	14060000 	strne	r0, [r6], #-0
     eb0:	0003ab0c 	andeq	sl, r3, ip, lsl #22
     eb4:	0ca30a00 	vstmiaeq	r3!, {s0-s-1}
     eb8:	0a000000 	beq	ec0 <shift+0xec0>
     ebc:	00000ecf 	andeq	r0, r0, pc, asr #29
     ec0:	8c030001 	stchi	0, cr0, [r3], {1}
     ec4:	06000003 	streq	r0, [r0], -r3
     ec8:	00000695 	muleq	r0, r5, r6
     ecc:	081b060c 	ldmdaeq	fp, {r2, r3, r9, sl}
     ed0:	000003e5 	andeq	r0, r0, r5, ror #7
     ed4:	00055e0e 	andeq	r5, r5, lr, lsl #28
     ed8:	191d0600 	ldmdbne	sp, {r9, sl}
     edc:	000003e5 	andeq	r0, r0, r5, ror #7
     ee0:	04c40e00 	strbeq	r0, [r4], #3584	; 0xe00
     ee4:	1e060000 	cdpne	0, 0, cr0, cr6, cr0, {0}
     ee8:	0003e519 	andeq	lr, r3, r9, lsl r5
     eec:	df0e0400 	svcle	0x000e0400
     ef0:	06000007 	streq	r0, [r0], -r7
     ef4:	03eb131f 	mvneq	r1, #2080374784	; 0x7c000000
     ef8:	00080000 	andeq	r0, r8, r0
     efc:	03b0040d 	movseq	r0, #218103808	; 0xd000000
     f00:	040d0000 	streq	r0, [sp], #-0
     f04:	000002b6 			; <UNDEFINED> instruction: 0x000002b6
     f08:	00096d11 	andeq	r6, r9, r1, lsl sp
     f0c:	22061400 	andcs	r1, r6, #0, 8
     f10:	00067307 	andeq	r7, r6, r7, lsl #6
     f14:	08a70e00 	stmiaeq	r7!, {r9, sl, fp}
     f18:	26060000 	strcs	r0, [r6], -r0
     f1c:	00004d12 	andeq	r4, r0, r2, lsl sp
     f20:	490e0000 	stmdbmi	lr, {}	; <UNPREDICTABLE>
     f24:	06000008 	streq	r0, [r0], -r8
     f28:	03e51d29 	mvneq	r1, #2624	; 0xa40
     f2c:	0e040000 	cdpeq	0, 0, cr0, cr4, cr0, {0}
     f30:	00000643 	andeq	r0, r0, r3, asr #12
     f34:	e51d2c06 	ldr	r2, [sp, #-3078]	; 0xfffff3fa
     f38:	08000003 	stmdaeq	r0, {r0, r1}
     f3c:	0008b112 	andeq	fp, r8, r2, lsl r1
     f40:	0e2f0600 	cfmadda32eq	mvax0, mvax0, mvfx15, mvfx0
     f44:	00000672 	andeq	r0, r0, r2, ror r6
     f48:	00000439 	andeq	r0, r0, r9, lsr r4
     f4c:	00000444 	andeq	r0, r0, r4, asr #8
     f50:	00067813 	andeq	r7, r6, r3, lsl r8
     f54:	03e51400 	mvneq	r1, #0, 8
     f58:	15000000 	strne	r0, [r0, #-0]
     f5c:	00000742 	andeq	r0, r0, r2, asr #14
     f60:	e20e3106 	and	r3, lr, #-2147483647	; 0x80000001
     f64:	f0000006 			; <UNDEFINED> instruction: 0xf0000006
     f68:	5c000001 	stcpl	0, cr0, [r0], {1}
     f6c:	67000004 	strvs	r0, [r0, -r4]
     f70:	13000004 	movwne	r0, #4
     f74:	00000678 	andeq	r0, r0, r8, ror r6
     f78:	0003eb14 	andeq	lr, r3, r4, lsl fp
     f7c:	10160000 	andsne	r0, r6, r0
     f80:	0600000b 	streq	r0, [r0], -fp
     f84:	07961d35 			; <UNDEFINED> instruction: 0x07961d35
     f88:	03e50000 	mvneq	r0, #0
     f8c:	80020000 	andhi	r0, r2, r0
     f90:	86000004 	strhi	r0, [r0], -r4
     f94:	13000004 	movwne	r0, #4
     f98:	00000678 	andeq	r0, r0, r8, ror r6
     f9c:	062e1600 	strteq	r1, [lr], -r0, lsl #12
     fa0:	37060000 	strcc	r0, [r6, -r0]
     fa4:	0008c11d 	andeq	ip, r8, sp, lsl r1
     fa8:	0003e500 	andeq	lr, r3, r0, lsl #10
     fac:	049f0200 	ldreq	r0, [pc], #512	; fb4 <shift+0xfb4>
     fb0:	04a50000 	strteq	r0, [r5], #0
     fb4:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
     fb8:	00000006 	andeq	r0, r0, r6
     fbc:	00085c17 	andeq	r5, r8, r7, lsl ip
     fc0:	31390600 	teqcc	r9, r0, lsl #12
     fc4:	00000691 	muleq	r0, r1, r6
     fc8:	6d16020c 	lfmvs	f0, 4, [r6, #-48]	; 0xffffffd0
     fcc:	06000009 	streq	r0, [r0], -r9
     fd0:	0751093c 	smmlareq	r1, ip, r9, r0
     fd4:	06780000 	ldrbteq	r0, [r8], -r0
     fd8:	cc010000 	stcgt	0, cr0, [r1], {-0}
     fdc:	d2000004 	andle	r0, r0, #4
     fe0:	13000004 	movwne	r0, #4
     fe4:	00000678 	andeq	r0, r0, r8, ror r6
     fe8:	06b41600 	ldrteq	r1, [r4], r0, lsl #12
     fec:	3f060000 	svccc	0x00060000
     ff0:	00051a12 	andeq	r1, r5, r2, lsl sl
     ff4:	00004d00 	andeq	r4, r0, r0, lsl #26
     ff8:	04eb0100 	strbteq	r0, [fp], #256	; 0x100
     ffc:	05000000 	streq	r0, [r0, #-0]
    1000:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
    1004:	14000006 	strne	r0, [r0], #-6
    1008:	0000069a 	muleq	r0, sl, r6
    100c:	00005e14 	andeq	r5, r0, r4, lsl lr
    1010:	01f01400 	mvnseq	r1, r0, lsl #8
    1014:	18000000 	stmdane	r0, {}	; <UNPREDICTABLE>
    1018:	00000b40 	andeq	r0, r0, r0, asr #22
    101c:	c10e4206 	tstgt	lr, r6, lsl #4
    1020:	01000005 	tsteq	r0, r5
    1024:	00000515 	andeq	r0, r0, r5, lsl r5
    1028:	0000051b 	andeq	r0, r0, fp, lsl r5
    102c:	00067813 	andeq	r7, r6, r3, lsl r8
    1030:	fc160000 	ldc2	0, cr0, [r6], {-0}
    1034:	06000004 	streq	r0, [r0], -r4
    1038:	05631745 	strbeq	r1, [r3, #-1861]!	; 0xfffff8bb
    103c:	03eb0000 	mvneq	r0, #0
    1040:	34010000 	strcc	r0, [r1], #-0
    1044:	3a000005 	bcc	1060 <shift+0x1060>
    1048:	13000005 	movwne	r0, #5
    104c:	000006a0 	andeq	r0, r0, r0, lsr #13
    1050:	0a321600 	beq	c86858 <__bss_end+0xc7d8bc>
    1054:	48060000 	stmdami	r6, {}	; <UNPREDICTABLE>
    1058:	0003ff17 	andeq	pc, r3, r7, lsl pc	; <UNPREDICTABLE>
    105c:	0003eb00 	andeq	lr, r3, r0, lsl #22
    1060:	05530100 	ldrbeq	r0, [r3, #-256]	; 0xffffff00
    1064:	055e0000 	ldrbeq	r0, [lr, #-0]
    1068:	a0130000 	andsge	r0, r3, r0
    106c:	14000006 	strne	r0, [r0], #-6
    1070:	0000004d 	andeq	r0, r0, sp, asr #32
    1074:	05ec1800 	strbeq	r1, [ip, #2048]!	; 0x800
    1078:	4b060000 	blmi	181080 <__bss_end+0x1780e4>
    107c:	00086a0e 	andeq	r6, r8, lr, lsl #20
    1080:	05730100 	ldrbeq	r0, [r3, #-256]!	; 0xffffff00
    1084:	05790000 	ldrbeq	r0, [r9, #-0]!
    1088:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
    108c:	00000006 	andeq	r0, r0, r6
    1090:	00074216 	andeq	r4, r7, r6, lsl r2
    1094:	0e4d0600 	cdpeq	6, 4, cr0, cr13, cr0, {0}
    1098:	0000090d 	andeq	r0, r0, sp, lsl #18
    109c:	000001f0 	strdeq	r0, [r0], -r0	; <UNPREDICTABLE>
    10a0:	00059201 	andeq	r9, r5, r1, lsl #4
    10a4:	00059d00 	andeq	r9, r5, r0, lsl #26
    10a8:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
    10ac:	4d140000 	ldcmi	0, cr0, [r4, #-0]
    10b0:	00000000 	andeq	r0, r0, r0
    10b4:	0004a216 	andeq	sl, r4, r6, lsl r2
    10b8:	12500600 	subsne	r0, r0, #0, 12
    10bc:	0000042c 	andeq	r0, r0, ip, lsr #8
    10c0:	0000004d 	andeq	r0, r0, sp, asr #32
    10c4:	0005b601 	andeq	fp, r5, r1, lsl #12
    10c8:	0005c100 	andeq	ip, r5, r0, lsl #2
    10cc:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
    10d0:	fd140000 	ldc2	0, cr0, [r4, #-0]
    10d4:	00000001 	andeq	r0, r0, r1
    10d8:	00045f16 	andeq	r5, r4, r6, lsl pc
    10dc:	0e530600 	cdpeq	6, 5, cr0, cr3, cr0, {0}
    10e0:	00000b54 	andeq	r0, r0, r4, asr fp
    10e4:	000001f0 	strdeq	r0, [r0], -r0	; <UNPREDICTABLE>
    10e8:	0005da01 	andeq	sp, r5, r1, lsl #20
    10ec:	0005e500 	andeq	lr, r5, r0, lsl #10
    10f0:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
    10f4:	4d140000 	ldcmi	0, cr0, [r4, #-0]
    10f8:	00000000 	andeq	r0, r0, r0
    10fc:	00047c18 	andeq	r7, r4, r8, lsl ip
    1100:	0e560600 	cdpeq	6, 5, cr0, cr6, cr0, {0}
    1104:	00000a7f 	andeq	r0, r0, pc, ror sl
    1108:	0005fa01 	andeq	pc, r5, r1, lsl #20
    110c:	00061900 	andeq	r1, r6, r0, lsl #18
    1110:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
    1114:	a9140000 	ldmdbge	r4, {}	; <UNPREDICTABLE>
    1118:	14000000 	strne	r0, [r0], #-0
    111c:	0000004d 	andeq	r0, r0, sp, asr #32
    1120:	00004d14 	andeq	r4, r0, r4, lsl sp
    1124:	004d1400 	subeq	r1, sp, r0, lsl #8
    1128:	a6140000 	ldrge	r0, [r4], -r0
    112c:	00000006 	andeq	r0, r0, r6
    1130:	000b8018 	andeq	r8, fp, r8, lsl r0
    1134:	0e580600 	cdpeq	6, 5, cr0, cr8, cr0, {0}
    1138:	00000bfa 	strdeq	r0, [r0], -sl
    113c:	00062e01 	andeq	r2, r6, r1, lsl #28
    1140:	00064d00 	andeq	r4, r6, r0, lsl #26
    1144:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
    1148:	e0140000 	ands	r0, r4, r0
    114c:	14000000 	strne	r0, [r0], #-0
    1150:	0000004d 	andeq	r0, r0, sp, asr #32
    1154:	00004d14 	andeq	r4, r0, r4, lsl sp
    1158:	004d1400 	subeq	r1, sp, r0, lsl #8
    115c:	a6140000 	ldrge	r0, [r4], -r0
    1160:	00000006 	andeq	r0, r0, r6
    1164:	00048f19 	andeq	r8, r4, r9, lsl pc
    1168:	0e5b0600 	cdpeq	6, 5, cr0, cr11, cr0, {0}
    116c:	000007e9 	andeq	r0, r0, r9, ror #15
    1170:	000001f0 	strdeq	r0, [r0], -r0	; <UNPREDICTABLE>
    1174:	00066201 	andeq	r6, r6, r1, lsl #4
    1178:	06781300 	ldrbteq	r1, [r8], -r0, lsl #6
    117c:	68140000 	ldmdavs	r4, {}	; <UNPREDICTABLE>
    1180:	14000003 	strne	r0, [r0], #-3
    1184:	000006ac 	andeq	r0, r0, ip, lsr #13
    1188:	f1030000 			; <UNDEFINED> instruction: 0xf1030000
    118c:	0d000003 	stceq	0, cr0, [r0, #-12]
    1190:	0003f104 	andeq	pc, r3, r4, lsl #2
    1194:	03e51a00 	mvneq	r1, #0, 20
    1198:	068b0000 	streq	r0, [fp], r0
    119c:	06910000 	ldreq	r0, [r1], r0
    11a0:	78130000 	ldmdavc	r3, {}	; <UNPREDICTABLE>
    11a4:	00000006 	andeq	r0, r0, r6
    11a8:	0003f11b 	andeq	pc, r3, fp, lsl r1	; <UNPREDICTABLE>
    11ac:	00067e00 	andeq	r7, r6, r0, lsl #28
    11b0:	3f040d00 	svccc	0x00040d00
    11b4:	0d000000 	stceq	0, cr0, [r0, #-0]
    11b8:	00067304 	andeq	r7, r6, r4, lsl #6
    11bc:	65041c00 	strvs	r1, [r4, #-3072]	; 0xfffff400
    11c0:	1d000000 	stcne	0, cr0, [r0, #-0]
    11c4:	002c0f04 	eoreq	r0, ip, r4, lsl #30
    11c8:	06be0000 	ldrteq	r0, [lr], r0
    11cc:	5e100000 	cdppl	0, 1, cr0, cr0, cr0, {0}
    11d0:	09000000 	stmdbeq	r0, {}	; <UNPREDICTABLE>
    11d4:	06ae0300 	strteq	r0, [lr], r0, lsl #6
    11d8:	4c1e0000 	ldcmi	0, cr0, [lr], {-0}
    11dc:	0100000d 	tsteq	r0, sp
    11e0:	06be0ca3 	ldrteq	r0, [lr], r3, lsr #25
    11e4:	03050000 	movweq	r0, #20480	; 0x5000
    11e8:	00008f64 	andeq	r8, r0, r4, ror #30
    11ec:	000cbc1f 	andeq	fp, ip, pc, lsl ip
    11f0:	0aa50100 	beq	fe9415f8 <__bss_end+0xfe93865c>
    11f4:	00000dde 	ldrdeq	r0, [r0], -lr
    11f8:	0000004d 	andeq	r0, r0, sp, asr #32
    11fc:	000086d4 	ldrdeq	r8, [r0], -r4
    1200:	000000b0 	strheq	r0, [r0], -r0	; <UNPREDICTABLE>
    1204:	07339c01 	ldreq	r9, [r3, -r1, lsl #24]!
    1208:	71200000 			; <UNDEFINED> instruction: 0x71200000
    120c:	01000010 	tsteq	r0, r0, lsl r0
    1210:	01f71ba5 	mvnseq	r1, r5, lsr #23
    1214:	91030000 	mrsls	r0, (UNDEF: 3)
    1218:	3d207fac 	stccc	15, cr7, [r0, #-688]!	; 0xfffffd50
    121c:	0100000e 	tsteq	r0, lr
    1220:	004d2aa5 	subeq	r2, sp, r5, lsr #21
    1224:	91030000 	mrsls	r0, (UNDEF: 3)
    1228:	c71e7fa8 	ldrgt	r7, [lr, -r8, lsr #31]
    122c:	0100000d 	tsteq	r0, sp
    1230:	07330aa7 	ldreq	r0, [r3, -r7, lsr #21]!
    1234:	91030000 	mrsls	r0, (UNDEF: 3)
    1238:	b71e7fb4 			; <UNDEFINED> instruction: 0xb71e7fb4
    123c:	0100000c 	tsteq	r0, ip
    1240:	003809ab 	eorseq	r0, r8, fp, lsr #19
    1244:	91020000 	mrsls	r0, (UNDEF: 2)
    1248:	250f0074 	strcs	r0, [pc, #-116]	; 11dc <shift+0x11dc>
    124c:	43000000 	movwmi	r0, #0
    1250:	10000007 	andne	r0, r0, r7
    1254:	0000005e 	andeq	r0, r0, lr, asr r0
    1258:	2221003f 	eorcs	r0, r1, #63	; 0x3f
    125c:	0100000e 	tsteq	r0, lr
    1260:	0ef40a97 			; <UNDEFINED> instruction: 0x0ef40a97
    1264:	004d0000 	subeq	r0, sp, r0
    1268:	86980000 	ldrhi	r0, [r8], r0
    126c:	003c0000 	eorseq	r0, ip, r0
    1270:	9c010000 	stcls	0, cr0, [r1], {-0}
    1274:	00000780 	andeq	r0, r0, r0, lsl #15
    1278:	71657222 	cmnvc	r5, r2, lsr #4
    127c:	20990100 	addscs	r0, r9, r0, lsl #2
    1280:	000003ab 	andeq	r0, r0, fp, lsr #7
    1284:	1e749102 	expnes	f1, f2
    1288:	00000dd3 	ldrdeq	r0, [r0], -r3
    128c:	4d0e9a01 	vstrmi	s18, [lr, #-4]
    1290:	02000000 	andeq	r0, r0, #0
    1294:	23007091 	movwcs	r7, #145	; 0x91
    1298:	00000e46 	andeq	r0, r0, r6, asr #28
    129c:	d8068e01 	stmdale	r6, {r0, r9, sl, fp, pc}
    12a0:	5c00000c 	stcpl	0, cr0, [r0], {12}
    12a4:	3c000086 	stccc	0, cr0, [r0], {134}	; 0x86
    12a8:	01000000 	mrseq	r0, (UNDEF: 0)
    12ac:	0007b99c 	muleq	r7, ip, r9
    12b0:	0d1a2000 	ldceq	0, cr2, [sl, #-0]
    12b4:	8e010000 	cdphi	0, 0, cr0, cr1, cr0, {0}
    12b8:	00004d21 	andeq	r4, r0, r1, lsr #26
    12bc:	6c910200 	lfmvs	f0, 4, [r1], {0}
    12c0:	71657222 	cmnvc	r5, r2, lsr #4
    12c4:	20900100 	addscs	r0, r0, r0, lsl #2
    12c8:	000003ab 	andeq	r0, r0, fp, lsr #7
    12cc:	00749102 	rsbseq	r9, r4, r2, lsl #2
    12d0:	000dff21 	andeq	pc, sp, r1, lsr #30
    12d4:	0a820100 	beq	fe0816dc <__bss_end+0xfe078740>
    12d8:	00000d68 	andeq	r0, r0, r8, ror #26
    12dc:	0000004d 	andeq	r0, r0, sp, asr #32
    12e0:	00008620 	andeq	r8, r0, r0, lsr #12
    12e4:	0000003c 	andeq	r0, r0, ip, lsr r0
    12e8:	07f69c01 	ldrbeq	r9, [r6, r1, lsl #24]!
    12ec:	72220000 	eorvc	r0, r2, #0
    12f0:	01007165 	tsteq	r0, r5, ror #2
    12f4:	03872084 	orreq	r2, r7, #132	; 0x84
    12f8:	91020000 	mrsls	r0, (UNDEF: 2)
    12fc:	0cb01e74 	ldceq	14, cr1, [r0], #464	; 0x1d0
    1300:	85010000 	strhi	r0, [r1, #-0]
    1304:	00004d0e 	andeq	r4, r0, lr, lsl #26
    1308:	70910200 	addsvc	r0, r1, r0, lsl #4
    130c:	10542100 	subsne	r2, r4, r0, lsl #2
    1310:	76010000 	strvc	r0, [r1], -r0
    1314:	000d2e0a 	andeq	r2, sp, sl, lsl #28
    1318:	00004d00 	andeq	r4, r0, r0, lsl #26
    131c:	0085e400 	addeq	lr, r5, r0, lsl #8
    1320:	00003c00 	andeq	r3, r0, r0, lsl #24
    1324:	339c0100 	orrscc	r0, ip, #0, 2
    1328:	22000008 	andcs	r0, r0, #8
    132c:	00716572 	rsbseq	r6, r1, r2, ror r5
    1330:	87207801 	strhi	r7, [r0, -r1, lsl #16]!
    1334:	02000003 	andeq	r0, r0, #3
    1338:	b01e7491 	mulslt	lr, r1, r4
    133c:	0100000c 	tsteq	r0, ip
    1340:	004d0e79 	subeq	r0, sp, r9, ror lr
    1344:	91020000 	mrsls	r0, (UNDEF: 2)
    1348:	7c210070 	stcvc	0, cr0, [r1], #-448	; 0xfffffe40
    134c:	0100000d 	tsteq	r0, sp
    1350:	0ebf066a 	cdpeq	6, 11, cr0, cr15, cr10, {3}
    1354:	01f00000 	mvnseq	r0, r0
    1358:	85900000 	ldrhi	r0, [r0]
    135c:	00540000 	subseq	r0, r4, r0
    1360:	9c010000 	stcls	0, cr0, [r1], {-0}
    1364:	0000087f 	andeq	r0, r0, pc, ror r8
    1368:	000dd320 	andeq	sp, sp, r0, lsr #6
    136c:	156a0100 	strbne	r0, [sl, #-256]!	; 0xffffff00
    1370:	0000004d 	andeq	r0, r0, sp, asr #32
    1374:	206c9102 	rsbcs	r9, ip, r2, lsl #2
    1378:	000008f6 	strdeq	r0, [r0], -r6
    137c:	4d256a01 	vstmdbmi	r5!, {s12}
    1380:	02000000 	andeq	r0, r0, #0
    1384:	4c1e6891 	ldcmi	8, cr6, [lr], {145}	; 0x91
    1388:	01000010 	tsteq	r0, r0, lsl r0
    138c:	004d0e6c 	subeq	r0, sp, ip, ror #28
    1390:	91020000 	mrsls	r0, (UNDEF: 2)
    1394:	ef210074 	svc	0x00210074
    1398:	0100000c 	tsteq	r0, ip
    139c:	0f2b125d 	svceq	0x002b125d
    13a0:	008b0000 	addeq	r0, fp, r0
    13a4:	85400000 	strbhi	r0, [r0, #-0]
    13a8:	00500000 	subseq	r0, r0, r0
    13ac:	9c010000 	stcls	0, cr0, [r1], {-0}
    13b0:	000008da 	ldrdeq	r0, [r0], -sl
    13b4:	000eca20 	andeq	ip, lr, r0, lsr #20
    13b8:	205d0100 	subscs	r0, sp, r0, lsl #2
    13bc:	0000004d 	andeq	r0, r0, sp, asr #32
    13c0:	206c9102 	rsbcs	r9, ip, r2, lsl #2
    13c4:	00000e08 	andeq	r0, r0, r8, lsl #28
    13c8:	4d2f5d01 	stcmi	13, cr5, [pc, #-4]!	; 13cc <shift+0x13cc>
    13cc:	02000000 	andeq	r0, r0, #0
    13d0:	f6206891 			; <UNDEFINED> instruction: 0xf6206891
    13d4:	01000008 	tsteq	r0, r8
    13d8:	004d3f5d 	subeq	r3, sp, sp, asr pc
    13dc:	91020000 	mrsls	r0, (UNDEF: 2)
    13e0:	104c1e64 	subne	r1, ip, r4, ror #28
    13e4:	5f010000 	svcpl	0x00010000
    13e8:	00008b16 	andeq	r8, r0, r6, lsl fp
    13ec:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    13f0:	0f612100 	svceq	0x00612100
    13f4:	51010000 	mrspl	r0, (UNDEF: 1)
    13f8:	000cf40a 	andeq	pc, ip, sl, lsl #8
    13fc:	00004d00 	andeq	r4, r0, r0, lsl #26
    1400:	0084fc00 	addeq	pc, r4, r0, lsl #24
    1404:	00004400 	andeq	r4, r0, r0, lsl #8
    1408:	269c0100 	ldrcs	r0, [ip], r0, lsl #2
    140c:	20000009 	andcs	r0, r0, r9
    1410:	00000eca 	andeq	r0, r0, sl, asr #29
    1414:	4d1a5101 	ldfmis	f5, [sl, #-4]
    1418:	02000000 	andeq	r0, r0, #0
    141c:	08206c91 	stmdaeq	r0!, {r0, r4, r7, sl, fp, sp, lr}
    1420:	0100000e 	tsteq	r0, lr
    1424:	004d2951 	subeq	r2, sp, r1, asr r9
    1428:	91020000 	mrsls	r0, (UNDEF: 2)
    142c:	0f5a1e68 	svceq	0x005a1e68
    1430:	53010000 	movwpl	r0, #4096	; 0x1000
    1434:	00004d0e 	andeq	r4, r0, lr, lsl #26
    1438:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    143c:	0f542100 	svceq	0x00542100
    1440:	44010000 	strmi	r0, [r1], #-0
    1444:	000f360a 	andeq	r3, pc, sl, lsl #12
    1448:	00004d00 	andeq	r4, r0, r0, lsl #26
    144c:	0084ac00 	addeq	sl, r4, r0, lsl #24
    1450:	00005000 	andeq	r5, r0, r0
    1454:	819c0100 	orrshi	r0, ip, r0, lsl #2
    1458:	20000009 	andcs	r0, r0, r9
    145c:	00000eca 	andeq	r0, r0, sl, asr #29
    1460:	4d194401 	cfldrsmi	mvf4, [r9, #-4]
    1464:	02000000 	andeq	r0, r0, #0
    1468:	a8206c91 	stmdage	r0!, {r0, r4, r7, sl, fp, sp, lr}
    146c:	0100000d 	tsteq	r0, sp
    1470:	011d3044 	tsteq	sp, r4, asr #32
    1474:	91020000 	mrsls	r0, (UNDEF: 2)
    1478:	0e0e2068 	cdpeq	0, 0, cr2, cr14, cr8, {3}
    147c:	44010000 	strmi	r0, [r1], #-0
    1480:	0006ac41 	andeq	sl, r6, r1, asr #24
    1484:	64910200 	ldrvs	r0, [r1], #512	; 0x200
    1488:	00104c1e 	andseq	r4, r0, lr, lsl ip
    148c:	0e460100 	dvfeqs	f0, f6, f0
    1490:	0000004d 	andeq	r0, r0, sp, asr #32
    1494:	00749102 	rsbseq	r9, r4, r2, lsl #2
    1498:	000c9d23 	andeq	r9, ip, r3, lsr #26
    149c:	063e0100 	ldrteq	r0, [lr], -r0, lsl #2
    14a0:	00000db2 			; <UNDEFINED> instruction: 0x00000db2
    14a4:	00008480 	andeq	r8, r0, r0, lsl #9
    14a8:	0000002c 	andeq	r0, r0, ip, lsr #32
    14ac:	09ab9c01 	stmibeq	fp!, {r0, sl, fp, ip, pc}
    14b0:	ca200000 	bgt	8014b8 <__bss_end+0x7f851c>
    14b4:	0100000e 	tsteq	r0, lr
    14b8:	004d153e 	subeq	r1, sp, lr, lsr r5
    14bc:	91020000 	mrsls	r0, (UNDEF: 2)
    14c0:	cd210074 	stcgt	0, cr0, [r1, #-464]!	; 0xfffffe30
    14c4:	0100000d 	tsteq	r0, sp
    14c8:	0e140a31 			; <UNDEFINED> instruction: 0x0e140a31
    14cc:	004d0000 	subeq	r0, sp, r0
    14d0:	84300000 	ldrthi	r0, [r0], #-0
    14d4:	00500000 	subseq	r0, r0, r0
    14d8:	9c010000 	stcls	0, cr0, [r1], {-0}
    14dc:	00000a06 	andeq	r0, r0, r6, lsl #20
    14e0:	000eca20 	andeq	ip, lr, r0, lsr #20
    14e4:	19310100 	ldmdbne	r1!, {r8}
    14e8:	0000004d 	andeq	r0, r0, sp, asr #32
    14ec:	206c9102 	rsbcs	r9, ip, r2, lsl #2
    14f0:	00000f77 	andeq	r0, r0, r7, ror pc
    14f4:	f72b3101 			; <UNDEFINED> instruction: 0xf72b3101
    14f8:	02000001 	andeq	r0, r0, #1
    14fc:	41206891 			; <UNDEFINED> instruction: 0x41206891
    1500:	0100000e 	tsteq	r0, lr
    1504:	004d3c31 	subeq	r3, sp, r1, lsr ip
    1508:	91020000 	mrsls	r0, (UNDEF: 2)
    150c:	0f251e64 	svceq	0x00251e64
    1510:	33010000 	movwcc	r0, #4096	; 0x1000
    1514:	00004d0e 	andeq	r4, r0, lr, lsl #26
    1518:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    151c:	10762100 	rsbsne	r2, r6, r0, lsl #2
    1520:	24010000 	strcs	r0, [r1], #-0
    1524:	000f7e0a 	andeq	r7, pc, sl, lsl #28
    1528:	00004d00 	andeq	r4, r0, r0, lsl #26
    152c:	0083e000 	addeq	lr, r3, r0
    1530:	00005000 	andeq	r5, r0, r0
    1534:	619c0100 	orrsvs	r0, ip, r0, lsl #2
    1538:	2000000a 	andcs	r0, r0, sl
    153c:	00000eca 	andeq	r0, r0, sl, asr #29
    1540:	4d182401 	cfldrsmi	mvf2, [r8, #-4]
    1544:	02000000 	andeq	r0, r0, #0
    1548:	77206c91 			; <UNDEFINED> instruction: 0x77206c91
    154c:	0100000f 	tsteq	r0, pc
    1550:	0a672a24 	beq	19cbde8 <__bss_end+0x19c2e4c>
    1554:	91020000 	mrsls	r0, (UNDEF: 2)
    1558:	0e412068 	cdpeq	0, 4, cr2, cr1, cr8, {3}
    155c:	24010000 	strcs	r0, [r1], #-0
    1560:	00004d3b 	andeq	r4, r0, fp, lsr sp
    1564:	64910200 	ldrvs	r0, [r1], #512	; 0x200
    1568:	000cc11e 	andeq	ip, ip, lr, lsl r1
    156c:	0e260100 	sufeqs	f0, f6, f0
    1570:	0000004d 	andeq	r0, r0, sp, asr #32
    1574:	00749102 	rsbseq	r9, r4, r2, lsl #2
    1578:	0025040d 	eoreq	r0, r5, sp, lsl #8
    157c:	61030000 	mrsvs	r0, (UNDEF: 3)
    1580:	2100000a 	tstcs	r0, sl
    1584:	00000dd9 	ldrdeq	r0, [r0], -r9
    1588:	820a1901 	andhi	r1, sl, #16384	; 0x4000
    158c:	4d000010 	stcmi	0, cr0, [r0, #-64]	; 0xffffffc0
    1590:	9c000000 	stcls	0, cr0, [r0], {-0}
    1594:	44000083 	strmi	r0, [r0], #-131	; 0xffffff7d
    1598:	01000000 	mrseq	r0, (UNDEF: 0)
    159c:	000ab89c 	muleq	sl, ip, r8
    15a0:	106d2000 	rsbne	r2, sp, r0
    15a4:	19010000 	stmdbne	r1, {}	; <UNPREDICTABLE>
    15a8:	0001f71b 	andeq	pc, r1, fp, lsl r7	; <UNPREDICTABLE>
    15ac:	6c910200 	lfmvs	f0, 4, [r1], {0}
    15b0:	000f7220 	andeq	r7, pc, r0, lsr #4
    15b4:	35190100 	ldrcc	r0, [r9, #-256]	; 0xffffff00
    15b8:	000001c6 	andeq	r0, r0, r6, asr #3
    15bc:	1e689102 	lgnnee	f1, f2
    15c0:	00000eca 	andeq	r0, r0, sl, asr #29
    15c4:	4d0e1b01 	vstrmi	d1, [lr, #-4]
    15c8:	02000000 	andeq	r0, r0, #0
    15cc:	24007491 	strcs	r7, [r0], #-1169	; 0xfffffb6f
    15d0:	00000d0e 	andeq	r0, r0, lr, lsl #26
    15d4:	c7061401 	strgt	r1, [r6, -r1, lsl #8]
    15d8:	8000000c 	andhi	r0, r0, ip
    15dc:	1c000083 	stcne	0, cr0, [r0], {131}	; 0x83
    15e0:	01000000 	mrseq	r0, (UNDEF: 0)
    15e4:	0f68239c 	svceq	0x0068239c
    15e8:	0e010000 	cdpeq	0, 0, cr0, cr1, cr0, {0}
    15ec:	000d9a06 	andeq	r9, sp, r6, lsl #20
    15f0:	00835400 	addeq	r5, r3, r0, lsl #8
    15f4:	00002c00 	andeq	r2, r0, r0, lsl #24
    15f8:	f89c0100 			; <UNDEFINED> instruction: 0xf89c0100
    15fc:	2000000a 	andcs	r0, r0, sl
    1600:	00000d05 	andeq	r0, r0, r5, lsl #26
    1604:	38140e01 	ldmdacc	r4, {r0, r9, sl, fp}
    1608:	02000000 	andeq	r0, r0, #0
    160c:	25007491 	strcs	r7, [r0, #-1169]	; 0xfffffb6f
    1610:	0000107b 	andeq	r1, r0, fp, ror r0
    1614:	bc0a0401 	cfstrslt	mvf0, [sl], {1}
    1618:	4d00000d 	stcmi	0, cr0, [r0, #-52]	; 0xffffffcc
    161c:	28000000 	stmdacs	r0, {}	; <UNPREDICTABLE>
    1620:	2c000083 	stccs	0, cr0, [r0], {131}	; 0x83
    1624:	01000000 	mrseq	r0, (UNDEF: 0)
    1628:	6970229c 	ldmdbvs	r0!, {r2, r3, r4, r7, r9, sp}^
    162c:	06010064 	streq	r0, [r1], -r4, rrx
    1630:	00004d0e 	andeq	r4, r0, lr, lsl #26
    1634:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    1638:	032e0000 			; <UNDEFINED> instruction: 0x032e0000
    163c:	00040000 	andeq	r0, r4, r0
    1640:	000006ad 	andeq	r0, r0, sp, lsr #13
    1644:	0f8a0104 	svceq	0x008a0104
    1648:	c2040000 	andgt	r0, r4, #0
    164c:	52000010 	andpl	r0, r0, #16
    1650:	8400000c 	strhi	r0, [r0], #-12
    1654:	b8000087 	stmdalt	r0, {r0, r1, r2, r7}
    1658:	10000004 	andne	r0, r0, r4
    165c:	02000008 	andeq	r0, r0, #8
    1660:	00000049 	andeq	r0, r0, r9, asr #32
    1664:	00112b03 	andseq	r2, r1, r3, lsl #22
    1668:	10050100 	andne	r0, r5, r0, lsl #2
    166c:	00000061 	andeq	r0, r0, r1, rrx
    1670:	32313011 	eorscc	r3, r1, #17
    1674:	36353433 			; <UNDEFINED> instruction: 0x36353433
    1678:	41393837 	teqmi	r9, r7, lsr r8
    167c:	45444342 	strbmi	r4, [r4, #-834]	; 0xfffffcbe
    1680:	04000046 	streq	r0, [r0], #-70	; 0xffffffba
    1684:	25010301 	strcs	r0, [r1, #-769]	; 0xfffffcff
    1688:	05000000 	streq	r0, [r0, #-0]
    168c:	00000074 	andeq	r0, r0, r4, ror r0
    1690:	00000061 	andeq	r0, r0, r1, rrx
    1694:	00006606 	andeq	r6, r0, r6, lsl #12
    1698:	07001000 	streq	r1, [r0, -r0]
    169c:	00000051 	andeq	r0, r0, r1, asr r0
    16a0:	5a070408 	bpl	1c26c8 <__bss_end+0x1b972c>
    16a4:	0800000a 	stmdaeq	r0, {r1, r3}
    16a8:	0ae80801 	beq	ffa036b4 <__bss_end+0xff9fa718>
    16ac:	6d070000 	stcvs	0, cr0, [r7, #-0]
    16b0:	09000000 	stmdbeq	r0, {}	; <UNPREDICTABLE>
    16b4:	0000002a 	andeq	r0, r0, sl, lsr #32
    16b8:	00115a0a 	andseq	r5, r1, sl, lsl #20
    16bc:	06640100 	strbteq	r0, [r4], -r0, lsl #2
    16c0:	00001145 	andeq	r1, r0, r5, asr #2
    16c4:	00008bbc 			; <UNDEFINED> instruction: 0x00008bbc
    16c8:	00000080 	andeq	r0, r0, r0, lsl #1
    16cc:	00fb9c01 	rscseq	r9, fp, r1, lsl #24
    16d0:	730b0000 	movwvc	r0, #45056	; 0xb000
    16d4:	01006372 	tsteq	r0, r2, ror r3
    16d8:	00fb1964 	rscseq	r1, fp, r4, ror #18
    16dc:	91020000 	mrsls	r0, (UNDEF: 2)
    16e0:	73640b64 	cmnvc	r4, #100, 22	; 0x19000
    16e4:	64010074 	strvs	r0, [r1], #-116	; 0xffffff8c
    16e8:	00010224 	andeq	r0, r1, r4, lsr #4
    16ec:	60910200 	addsvs	r0, r1, r0, lsl #4
    16f0:	6d756e0b 	ldclvs	14, cr6, [r5, #-44]!	; 0xffffffd4
    16f4:	2d640100 	stfcse	f0, [r4, #-0]
    16f8:	00000104 	andeq	r0, r0, r4, lsl #2
    16fc:	0c5c9102 	ldfeqp	f1, [ip], {2}
    1700:	000011b4 			; <UNDEFINED> instruction: 0x000011b4
    1704:	0b0e6601 	bleq	39af10 <__bss_end+0x391f74>
    1708:	02000001 	andeq	r0, r0, #1
    170c:	370c7091 			; <UNDEFINED> instruction: 0x370c7091
    1710:	01000011 	tsteq	r0, r1, lsl r0
    1714:	01110867 	tsteq	r1, r7, ror #16
    1718:	91020000 	mrsls	r0, (UNDEF: 2)
    171c:	8be40d6c 	blhi	ff904cd4 <__bss_end+0xff8fbd38>
    1720:	00480000 	subeq	r0, r8, r0
    1724:	690e0000 	stmdbvs	lr, {}	; <UNPREDICTABLE>
    1728:	0b690100 	bleq	1a41b30 <__bss_end+0x1a38b94>
    172c:	00000104 	andeq	r0, r0, r4, lsl #2
    1730:	00749102 	rsbseq	r9, r4, r2, lsl #2
    1734:	01040f00 	tsteq	r4, r0, lsl #30
    1738:	10000001 	andne	r0, r0, r1
    173c:	04120411 	ldreq	r0, [r2], #-1041	; 0xfffffbef
    1740:	746e6905 	strbtvc	r6, [lr], #-2309	; 0xfffff6fb
    1744:	74040f00 	strvc	r0, [r4], #-3840	; 0xfffff100
    1748:	0f000000 	svceq	0x00000000
    174c:	00006d04 	andeq	r6, r0, r4, lsl #26
    1750:	10a90a00 	adcne	r0, r9, r0, lsl #20
    1754:	5c010000 	stcpl	0, cr0, [r1], {-0}
    1758:	0010b606 	andseq	fp, r0, r6, lsl #12
    175c:	008b5400 	addeq	r5, fp, r0, lsl #8
    1760:	00006800 	andeq	r6, r0, r0, lsl #16
    1764:	769c0100 	ldrvc	r0, [ip], r0, lsl #2
    1768:	13000001 	movwne	r0, #1
    176c:	000011ad 	andeq	r1, r0, sp, lsr #3
    1770:	02125c01 	andseq	r5, r2, #256	; 0x100
    1774:	02000001 	andeq	r0, r0, #1
    1778:	af136c91 	svcge	0x00136c91
    177c:	01000010 	tsteq	r0, r0, lsl r0
    1780:	01041e5c 	tsteq	r4, ip, asr lr
    1784:	91020000 	mrsls	r0, (UNDEF: 2)
    1788:	656d0e68 	strbvs	r0, [sp, #-3688]!	; 0xfffff198
    178c:	5e01006d 	cdppl	0, 0, cr0, cr1, cr13, {3}
    1790:	00011108 	andeq	r1, r1, r8, lsl #2
    1794:	70910200 	addsvc	r0, r1, r0, lsl #4
    1798:	008b700d 	addeq	r7, fp, sp
    179c:	00003c00 	andeq	r3, r0, r0, lsl #24
    17a0:	00690e00 	rsbeq	r0, r9, r0, lsl #28
    17a4:	040b6001 	streq	r6, [fp], #-1
    17a8:	02000001 	andeq	r0, r0, #1
    17ac:	00007491 	muleq	r0, r1, r4
    17b0:	00116114 	andseq	r6, r1, r4, lsl r1
    17b4:	05520100 	ldrbeq	r0, [r2, #-256]	; 0xffffff00
    17b8:	0000117a 	andeq	r1, r0, sl, ror r1
    17bc:	00000104 	andeq	r0, r0, r4, lsl #2
    17c0:	00008b00 	andeq	r8, r0, r0, lsl #22
    17c4:	00000054 	andeq	r0, r0, r4, asr r0
    17c8:	01af9c01 			; <UNDEFINED> instruction: 0x01af9c01
    17cc:	730b0000 	movwvc	r0, #45056	; 0xb000
    17d0:	18520100 	ldmdane	r2, {r8}^
    17d4:	0000010b 	andeq	r0, r0, fp, lsl #2
    17d8:	0e6c9102 	lgneqe	f1, f2
    17dc:	54010069 	strpl	r0, [r1], #-105	; 0xffffff97
    17e0:	00010406 	andeq	r0, r1, r6, lsl #8
    17e4:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    17e8:	119d1400 	orrsne	r1, sp, r0, lsl #8
    17ec:	42010000 	andmi	r0, r1, #0
    17f0:	00116805 	andseq	r6, r1, r5, lsl #16
    17f4:	00010400 	andeq	r0, r1, r0, lsl #8
    17f8:	008a5400 	addeq	r5, sl, r0, lsl #8
    17fc:	0000ac00 	andeq	sl, r0, r0, lsl #24
    1800:	159c0100 	ldrne	r0, [ip, #256]	; 0x100
    1804:	0b000002 	bleq	1814 <shift+0x1814>
    1808:	01003173 	tsteq	r0, r3, ror r1
    180c:	010b1942 	tsteq	fp, r2, asr #18
    1810:	91020000 	mrsls	r0, (UNDEF: 2)
    1814:	32730b6c 	rsbscc	r0, r3, #108, 22	; 0x1b000
    1818:	29420100 	stmdbcs	r2, {r8}^
    181c:	0000010b 	andeq	r0, r0, fp, lsl #2
    1820:	0b689102 	bleq	1a25c30 <__bss_end+0x1a1cc94>
    1824:	006d756e 	rsbeq	r7, sp, lr, ror #10
    1828:	04314201 	ldrteq	r4, [r1], #-513	; 0xfffffdff
    182c:	02000001 	andeq	r0, r0, #1
    1830:	750e6491 	strvc	r6, [lr, #-1169]	; 0xfffffb6f
    1834:	44010031 	strmi	r0, [r1], #-49	; 0xffffffcf
    1838:	00021510 	andeq	r1, r2, r0, lsl r5
    183c:	77910200 	ldrvc	r0, [r1, r0, lsl #4]
    1840:	0032750e 	eorseq	r7, r2, lr, lsl #10
    1844:	15144401 	ldrne	r4, [r4, #-1025]	; 0xfffffbff
    1848:	02000002 	andeq	r0, r0, #2
    184c:	08007691 	stmdaeq	r0, {r0, r4, r7, r9, sl, ip, sp, lr}
    1850:	0adf0801 	beq	ff7c385c <__bss_end+0xff7ba8c0>
    1854:	a5140000 	ldrge	r0, [r4, #-0]
    1858:	01000011 	tsteq	r0, r1, lsl r0
    185c:	118c0736 	orrne	r0, ip, r6, lsr r7
    1860:	01110000 	tsteq	r1, r0
    1864:	89940000 	ldmibhi	r4, {}	; <UNPREDICTABLE>
    1868:	00c00000 	sbceq	r0, r0, r0
    186c:	9c010000 	stcls	0, cr0, [r1], {-0}
    1870:	00000275 	andeq	r0, r0, r5, ror r2
    1874:	0010a413 	andseq	sl, r0, r3, lsl r4
    1878:	15360100 	ldrne	r0, [r6, #-256]!	; 0xffffff00
    187c:	00000111 	andeq	r0, r0, r1, lsl r1
    1880:	0b6c9102 	bleq	1b25c90 <__bss_end+0x1b1ccf4>
    1884:	00637273 	rsbeq	r7, r3, r3, ror r2
    1888:	0b273601 	bleq	9cf094 <__bss_end+0x9c60f8>
    188c:	02000001 	andeq	r0, r0, #1
    1890:	6e0b6891 	mcrvs	8, 0, r6, cr11, cr1, {4}
    1894:	01006d75 	tsteq	r0, r5, ror sp
    1898:	01043036 	tsteq	r4, r6, lsr r0
    189c:	91020000 	mrsls	r0, (UNDEF: 2)
    18a0:	00690e64 	rsbeq	r0, r9, r4, ror #28
    18a4:	04063801 	streq	r3, [r6], #-2049	; 0xfffff7ff
    18a8:	02000001 	andeq	r0, r0, #1
    18ac:	14007491 	strne	r7, [r0], #-1169	; 0xfffffb6f
    18b0:	00001187 	andeq	r1, r0, r7, lsl #3
    18b4:	20052401 	andcs	r2, r5, r1, lsl #8
    18b8:	04000011 	streq	r0, [r0], #-17	; 0xffffffef
    18bc:	f8000001 			; <UNDEFINED> instruction: 0xf8000001
    18c0:	9c000088 	stcls	0, cr0, [r0], {136}	; 0x88
    18c4:	01000000 	mrseq	r0, (UNDEF: 0)
    18c8:	0002b29c 	muleq	r2, ip, r2
    18cc:	109e1300 	addsne	r1, lr, r0, lsl #6
    18d0:	24010000 	strcs	r0, [r1], #-0
    18d4:	00010b16 	andeq	r0, r1, r6, lsl fp
    18d8:	6c910200 	lfmvs	f0, 4, [r1], {0}
    18dc:	00113e0c 	andseq	r3, r1, ip, lsl #28
    18e0:	06260100 	strteq	r0, [r6], -r0, lsl #2
    18e4:	00000104 	andeq	r0, r0, r4, lsl #2
    18e8:	00749102 	rsbseq	r9, r4, r2, lsl #2
    18ec:	0011bb15 	andseq	fp, r1, r5, lsl fp
    18f0:	06080100 	streq	r0, [r8], -r0, lsl #2
    18f4:	000011c0 	andeq	r1, r0, r0, asr #3
    18f8:	00008784 	andeq	r8, r0, r4, lsl #15
    18fc:	00000174 	andeq	r0, r0, r4, ror r1
    1900:	9e139c01 	cdpls	12, 1, cr9, cr3, cr1, {0}
    1904:	01000010 	tsteq	r0, r0, lsl r0
    1908:	00661808 	rsbeq	r1, r6, r8, lsl #16
    190c:	91020000 	mrsls	r0, (UNDEF: 2)
    1910:	113e1364 	teqne	lr, r4, ror #6
    1914:	08010000 	stmdaeq	r1, {}	; <UNPREDICTABLE>
    1918:	00011125 	andeq	r1, r1, r5, lsr #2
    191c:	60910200 	addsvs	r0, r1, r0, lsl #4
    1920:	00115513 	andseq	r5, r1, r3, lsl r5
    1924:	3a080100 	bcc	201d2c <__bss_end+0x1f8d90>
    1928:	00000066 	andeq	r0, r0, r6, rrx
    192c:	0e5c9102 	logeqe	f1, f2
    1930:	0a010069 	beq	41adc <__bss_end+0x38b40>
    1934:	00010406 	andeq	r0, r1, r6, lsl #8
    1938:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    193c:	0088500d 	addeq	r5, r8, sp
    1940:	00009800 	andeq	r9, r0, r0, lsl #16
    1944:	006a0e00 	rsbeq	r0, sl, r0, lsl #28
    1948:	040b1c01 	streq	r1, [fp], #-3073	; 0xfffff3ff
    194c:	02000001 	andeq	r0, r0, #1
    1950:	780d7091 	stmdavc	sp, {r0, r4, r7, ip, sp, lr}
    1954:	60000088 	andvs	r0, r0, r8, lsl #1
    1958:	0e000000 	cdpeq	0, 0, cr0, cr0, cr0, {0}
    195c:	1e010063 	cdpne	0, 0, cr0, cr1, cr3, {3}
    1960:	00006d08 	andeq	r6, r0, r8, lsl #26
    1964:	6f910200 	svcvs	0x00910200
    1968:	00000000 	andeq	r0, r0, r0

Disassembly of section .debug_abbrev:

00000000 <.debug_abbrev>:
   0:	10001101 	andne	r1, r0, r1, lsl #2
   4:	12011106 	andne	r1, r1, #-2147483647	; 0x80000001
   8:	1b0e0301 	blne	380c14 <__bss_end+0x377c78>
   c:	130e250e 	movwne	r2, #58638	; 0xe50e
  10:	00000005 	andeq	r0, r0, r5
  14:	25011101 	strcs	r1, [r1, #-257]	; 0xfffffeff
  18:	030b130e 	movweq	r1, #45838	; 0xb30e
  1c:	110e1b0e 	tstne	lr, lr, lsl #22
  20:	10061201 	andne	r1, r6, r1, lsl #4
  24:	02000017 	andeq	r0, r0, #23
  28:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
  2c:	0b3b0b3a 	bleq	ec2d1c <__bss_end+0xeb9d80>
  30:	13490b39 	movtne	r0, #39737	; 0x9b39
  34:	193c193f 	ldmdbne	ip!, {r0, r1, r2, r3, r4, r5, r8, fp, ip}
  38:	24030000 	strcs	r0, [r3], #-0
  3c:	3e0b0b00 	vmlacc.f64	d0, d11, d0
  40:	000e030b 	andeq	r0, lr, fp, lsl #6
  44:	012e0400 			; <UNDEFINED> instruction: 0x012e0400
  48:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
  4c:	0b3b0b3a 	bleq	ec2d3c <__bss_end+0xeb9da0>
  50:	01110b39 	tsteq	r1, r9, lsr fp
  54:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
  58:	01194296 			; <UNDEFINED> instruction: 0x01194296
  5c:	05000013 	streq	r0, [r0, #-19]	; 0xffffffed
  60:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
  64:	0b3b0b3a 	bleq	ec2d54 <__bss_end+0xeb9db8>
  68:	13490b39 	movtne	r0, #39737	; 0x9b39
  6c:	00001802 	andeq	r1, r0, r2, lsl #16
  70:	0b002406 	bleq	9090 <__bss_end+0xf4>
  74:	030b3e0b 	movweq	r3, #48651	; 0xbe0b
  78:	07000008 	streq	r0, [r0, -r8]
  7c:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
  80:	0b3a0e03 	bleq	e83894 <__bss_end+0xe7a8f8>
  84:	0b390b3b 	bleq	e42d78 <__bss_end+0xe39ddc>
  88:	06120111 			; <UNDEFINED> instruction: 0x06120111
  8c:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
  90:	00130119 	andseq	r0, r3, r9, lsl r1
  94:	010b0800 	tsteq	fp, r0, lsl #16
  98:	06120111 			; <UNDEFINED> instruction: 0x06120111
  9c:	34090000 	strcc	r0, [r9], #-0
  a0:	3a080300 	bcc	200ca8 <__bss_end+0x1f7d0c>
  a4:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
  a8:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
  ac:	0a000018 	beq	114 <shift+0x114>
  b0:	0b0b000f 	bleq	2c00f4 <__bss_end+0x2b7158>
  b4:	00001349 	andeq	r1, r0, r9, asr #6
  b8:	01110100 	tsteq	r1, r0, lsl #2
  bc:	0b130e25 	bleq	4c3958 <__bss_end+0x4ba9bc>
  c0:	0e1b0e03 	cdpeq	14, 1, cr0, cr11, cr3, {0}
  c4:	06120111 			; <UNDEFINED> instruction: 0x06120111
  c8:	00001710 	andeq	r1, r0, r0, lsl r7
  cc:	03001602 	movweq	r1, #1538	; 0x602
  d0:	3b0b3a0e 	blcc	2ce910 <__bss_end+0x2c5974>
  d4:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
  d8:	03000013 	movweq	r0, #19
  dc:	0b0b000f 	bleq	2c0120 <__bss_end+0x2b7184>
  e0:	00001349 	andeq	r1, r0, r9, asr #6
  e4:	00001504 	andeq	r1, r0, r4, lsl #10
  e8:	01010500 	tsteq	r1, r0, lsl #10
  ec:	13011349 	movwne	r1, #4937	; 0x1349
  f0:	21060000 	mrscs	r0, (UNDEF: 6)
  f4:	2f134900 	svccs	0x00134900
  f8:	07000006 	streq	r0, [r0, -r6]
  fc:	0b0b0024 	bleq	2c0194 <__bss_end+0x2b71f8>
 100:	0e030b3e 	vmoveq.16	d3[0], r0
 104:	34080000 	strcc	r0, [r8], #-0
 108:	3a0e0300 	bcc	380d10 <__bss_end+0x377d74>
 10c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 110:	3f13490b 	svccc	0x0013490b
 114:	00193c19 	andseq	r3, r9, r9, lsl ip
 118:	012e0900 			; <UNDEFINED> instruction: 0x012e0900
 11c:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 120:	0b3b0b3a 	bleq	ec2e10 <__bss_end+0xeb9e74>
 124:	13490b39 	movtne	r0, #39737	; 0x9b39
 128:	06120111 			; <UNDEFINED> instruction: 0x06120111
 12c:	42961840 	addsmi	r1, r6, #64, 16	; 0x400000
 130:	00130119 	andseq	r0, r3, r9, lsl r1
 134:	00340a00 	eorseq	r0, r4, r0, lsl #20
 138:	0b3a0e03 	bleq	e8394c <__bss_end+0xe7a9b0>
 13c:	0b390b3b 	bleq	e42e30 <__bss_end+0xe39e94>
 140:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 144:	240b0000 	strcs	r0, [fp], #-0
 148:	3e0b0b00 	vmlacc.f64	d0, d11, d0
 14c:	0008030b 	andeq	r0, r8, fp, lsl #6
 150:	002e0c00 	eoreq	r0, lr, r0, lsl #24
 154:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 158:	0b3b0b3a 	bleq	ec2e48 <__bss_end+0xeb9eac>
 15c:	01110b39 	tsteq	r1, r9, lsr fp
 160:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 164:	00194297 	mulseq	r9, r7, r2
 168:	01390d00 	teqeq	r9, r0, lsl #26
 16c:	0b3a0e03 	bleq	e83980 <__bss_end+0xe7a9e4>
 170:	13010b3b 	movwne	r0, #6971	; 0x1b3b
 174:	2e0e0000 	cdpcs	0, 0, cr0, cr14, cr0, {0}
 178:	03193f01 	tsteq	r9, #1, 30
 17c:	3b0b3a0e 	blcc	2ce9bc <__bss_end+0x2c5a20>
 180:	3c0b390b 			; <UNDEFINED> instruction: 0x3c0b390b
 184:	00130119 	andseq	r0, r3, r9, lsl r1
 188:	00050f00 	andeq	r0, r5, r0, lsl #30
 18c:	00001349 	andeq	r1, r0, r9, asr #6
 190:	3f012e10 	svccc	0x00012e10
 194:	3a0e0319 	bcc	380e00 <__bss_end+0x377e64>
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
 1c0:	3a080300 	bcc	200dc8 <__bss_end+0x1f7e2c>
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
 1f4:	0b0b0024 	bleq	2c028c <__bss_end+0x2b72f0>
 1f8:	0e030b3e 	vmoveq.16	d3[0], r0
 1fc:	26030000 	strcs	r0, [r3], -r0
 200:	00134900 	andseq	r4, r3, r0, lsl #18
 204:	00240400 	eoreq	r0, r4, r0, lsl #8
 208:	0b3e0b0b 	bleq	f82e3c <__bss_end+0xf79ea0>
 20c:	00000803 	andeq	r0, r0, r3, lsl #16
 210:	03001605 	movweq	r1, #1541	; 0x605
 214:	3b0b3a0e 	blcc	2cea54 <__bss_end+0x2c5ab8>
 218:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 21c:	06000013 			; <UNDEFINED> instruction: 0x06000013
 220:	0e030113 	mcreq	1, 0, r0, cr3, cr3, {0}
 224:	0b3a0b0b 	bleq	e82e58 <__bss_end+0xe79ebc>
 228:	0b390b3b 	bleq	e42f1c <__bss_end+0xe39f80>
 22c:	00001301 	andeq	r1, r0, r1, lsl #6
 230:	03000d07 	movweq	r0, #3335	; 0xd07
 234:	3b0b3a08 	blcc	2cea5c <__bss_end+0x2c5ac0>
 238:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 23c:	000b3813 	andeq	r3, fp, r3, lsl r8
 240:	01040800 	tsteq	r4, r0, lsl #16
 244:	196d0e03 	stmdbne	sp!, {r0, r1, r9, sl, fp}^
 248:	0b0b0b3e 	bleq	2c2f48 <__bss_end+0x2b9fac>
 24c:	0b3a1349 	bleq	e84f78 <__bss_end+0xe7bfdc>
 250:	0b390b3b 	bleq	e42f44 <__bss_end+0xe39fa8>
 254:	00001301 	andeq	r1, r0, r1, lsl #6
 258:	03002809 	movweq	r2, #2057	; 0x809
 25c:	000b1c0e 	andeq	r1, fp, lr, lsl #24
 260:	00340a00 	eorseq	r0, r4, r0, lsl #20
 264:	0b3a0e03 	bleq	e83a78 <__bss_end+0xe7aadc>
 268:	0b390b3b 	bleq	e42f5c <__bss_end+0xe39fc0>
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
 294:	0b3b0b3a 	bleq	ec2f84 <__bss_end+0xeb9fe8>
 298:	13490b39 	movtne	r0, #39737	; 0x9b39
 29c:	00000b38 	andeq	r0, r0, r8, lsr fp
 2a0:	4901010f 	stmdbmi	r1, {r0, r1, r2, r3, r8}
 2a4:	00130113 	andseq	r0, r3, r3, lsl r1
 2a8:	00211000 	eoreq	r1, r1, r0
 2ac:	0b2f1349 	bleq	bc4fd8 <__bss_end+0xbbc03c>
 2b0:	02110000 	andseq	r0, r1, #0
 2b4:	0b0e0301 	bleq	380ec0 <__bss_end+0x377f24>
 2b8:	3b0b3a0b 	blcc	2ceaec <__bss_end+0x2c5b50>
 2bc:	010b390b 	tsteq	fp, fp, lsl #18
 2c0:	12000013 	andne	r0, r0, #19
 2c4:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 2c8:	0b3a0e03 	bleq	e83adc <__bss_end+0xe7ab40>
 2cc:	0b390b3b 	bleq	e42fc0 <__bss_end+0xe3a024>
 2d0:	193c0e6e 	ldmdbne	ip!, {r1, r2, r3, r5, r6, r9, sl, fp}
 2d4:	13011364 	movwne	r1, #4964	; 0x1364
 2d8:	05130000 	ldreq	r0, [r3, #-0]
 2dc:	34134900 	ldrcc	r4, [r3], #-2304	; 0xfffff700
 2e0:	14000019 	strne	r0, [r0], #-25	; 0xffffffe7
 2e4:	13490005 	movtne	r0, #36869	; 0x9005
 2e8:	2e150000 	cdpcs	0, 1, cr0, cr5, cr0, {0}
 2ec:	03193f01 	tsteq	r9, #1, 30
 2f0:	3b0b3a0e 	blcc	2ceb30 <__bss_end+0x2c5b94>
 2f4:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 2f8:	3c13490e 			; <UNDEFINED> instruction: 0x3c13490e
 2fc:	01136419 	tsteq	r3, r9, lsl r4
 300:	16000013 			; <UNDEFINED> instruction: 0x16000013
 304:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 308:	0b3a0e03 	bleq	e83b1c <__bss_end+0xe7ab80>
 30c:	0b390b3b 	bleq	e43000 <__bss_end+0xe3a064>
 310:	13490e6e 	movtne	r0, #40558	; 0x9e6e
 314:	193c0b32 	ldmdbne	ip!, {r1, r4, r5, r8, r9, fp}
 318:	13011364 	movwne	r1, #4964	; 0x1364
 31c:	0d170000 	ldceq	0, cr0, [r7, #-0]
 320:	3a0e0300 	bcc	380f28 <__bss_end+0x377f8c>
 324:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 328:	3813490b 	ldmdacc	r3, {r0, r1, r3, r8, fp, lr}
 32c:	000b320b 	andeq	r3, fp, fp, lsl #4
 330:	012e1800 			; <UNDEFINED> instruction: 0x012e1800
 334:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 338:	0b3b0b3a 	bleq	ec3028 <__bss_end+0xeba08c>
 33c:	0e6e0b39 	vmoveq.8	d14[5], r0
 340:	193c0b32 	ldmdbne	ip!, {r1, r4, r5, r8, r9, fp}
 344:	13011364 	movwne	r1, #4964	; 0x1364
 348:	2e190000 	cdpcs	0, 1, cr0, cr9, cr0, {0}
 34c:	03193f01 	tsteq	r9, #1, 30
 350:	3b0b3a0e 	blcc	2ceb90 <__bss_end+0x2c5bf4>
 354:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 358:	3213490e 	andscc	r4, r3, #229376	; 0x38000
 35c:	64193c0b 	ldrvs	r3, [r9], #-3083	; 0xfffff3f5
 360:	1a000013 	bne	3b4 <shift+0x3b4>
 364:	13490115 	movtne	r0, #37141	; 0x9115
 368:	13011364 	movwne	r1, #4964	; 0x1364
 36c:	1f1b0000 	svcne	0x001b0000
 370:	49131d00 	ldmdbmi	r3, {r8, sl, fp, ip}
 374:	1c000013 	stcne	0, cr0, [r0], {19}
 378:	0b0b0010 	bleq	2c03c0 <__bss_end+0x2b7424>
 37c:	00001349 	andeq	r1, r0, r9, asr #6
 380:	0b000f1d 	bleq	3ffc <shift+0x3ffc>
 384:	1e00000b 	cdpne	0, 0, cr0, cr0, cr11, {0}
 388:	08030139 	stmdaeq	r3, {r0, r3, r4, r5, r8}
 38c:	0b3b0b3a 	bleq	ec307c <__bss_end+0xeba0e0>
 390:	13010b39 	movwne	r0, #6969	; 0x1b39
 394:	341f0000 	ldrcc	r0, [pc], #-0	; 39c <shift+0x39c>
 398:	3a0e0300 	bcc	380fa0 <__bss_end+0x378004>
 39c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 3a0:	3c13490b 			; <UNDEFINED> instruction: 0x3c13490b
 3a4:	6c061c19 	stcvs	12, cr1, [r6], {25}
 3a8:	20000019 	andcs	r0, r0, r9, lsl r0
 3ac:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 3b0:	0b3b0b3a 	bleq	ec30a0 <__bss_end+0xeba104>
 3b4:	13490b39 	movtne	r0, #39737	; 0x9b39
 3b8:	0b1c193c 	bleq	7068b0 <__bss_end+0x6fd914>
 3bc:	0000196c 	andeq	r1, r0, ip, ror #18
 3c0:	47003421 	strmi	r3, [r0, -r1, lsr #8]
 3c4:	22000013 	andcs	r0, r0, #19
 3c8:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 3cc:	0b3b0b3a 	bleq	ec30bc <__bss_end+0xeba120>
 3d0:	13490b39 	movtne	r0, #39737	; 0x9b39
 3d4:	1802193f 	stmdane	r2, {r0, r1, r2, r3, r4, r5, r8, fp, ip}
 3d8:	2e230000 	cdpcs	0, 2, cr0, cr3, cr0, {0}
 3dc:	03193f01 	tsteq	r9, #1, 30
 3e0:	3b0b3a0e 	blcc	2cec20 <__bss_end+0x2c5c84>
 3e4:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 3e8:	12011113 	andne	r1, r1, #-1073741820	; 0xc0000004
 3ec:	96184006 	ldrls	r4, [r8], -r6
 3f0:	13011942 	movwne	r1, #6466	; 0x1942
 3f4:	05240000 	streq	r0, [r4, #-0]!
 3f8:	3a0e0300 	bcc	381000 <__bss_end+0x378064>
 3fc:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 400:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 404:	25000018 	strcs	r0, [r0, #-24]	; 0xffffffe8
 408:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 40c:	0b3b0b3a 	bleq	ec30fc <__bss_end+0xeba160>
 410:	13490b39 	movtne	r0, #39737	; 0x9b39
 414:	00001802 	andeq	r1, r0, r2, lsl #16
 418:	3f012e26 	svccc	0x00012e26
 41c:	3a080319 	bcc	201088 <__bss_end+0x1f80ec>
 420:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 424:	110e6e0b 	tstne	lr, fp, lsl #28
 428:	40061201 	andmi	r1, r6, r1, lsl #4
 42c:	19429618 	stmdbne	r2, {r3, r4, r9, sl, ip, pc}^
 430:	05270000 	streq	r0, [r7, #-0]!
 434:	3a080300 	bcc	20103c <__bss_end+0x1f80a0>
 438:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 43c:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 440:	00000018 	andeq	r0, r0, r8, lsl r0
 444:	25011101 	strcs	r1, [r1, #-257]	; 0xfffffeff
 448:	030b130e 	movweq	r1, #45838	; 0xb30e
 44c:	110e1b0e 	tstne	lr, lr, lsl #22
 450:	10061201 	andne	r1, r6, r1, lsl #4
 454:	02000017 	andeq	r0, r0, #23
 458:	0b0b0024 	bleq	2c04f0 <__bss_end+0x2b7554>
 45c:	0e030b3e 	vmoveq.16	d3[0], r0
 460:	26030000 	strcs	r0, [r3], -r0
 464:	00134900 	andseq	r4, r3, r0, lsl #18
 468:	00240400 	eoreq	r0, r4, r0, lsl #8
 46c:	0b3e0b0b 	bleq	f830a0 <__bss_end+0xf7a104>
 470:	00000803 	andeq	r0, r0, r3, lsl #16
 474:	03001605 	movweq	r1, #1541	; 0x605
 478:	3b0b3a0e 	blcc	2cecb8 <__bss_end+0x2c5d1c>
 47c:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 480:	06000013 			; <UNDEFINED> instruction: 0x06000013
 484:	0e030113 	mcreq	1, 0, r0, cr3, cr3, {0}
 488:	0b3a0b0b 	bleq	e830bc <__bss_end+0xe7a120>
 48c:	0b390b3b 	bleq	e43180 <__bss_end+0xe3a1e4>
 490:	00001301 	andeq	r1, r0, r1, lsl #6
 494:	03000d07 	movweq	r0, #3335	; 0xd07
 498:	3b0b3a08 	blcc	2cecc0 <__bss_end+0x2c5d24>
 49c:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 4a0:	000b3813 	andeq	r3, fp, r3, lsl r8
 4a4:	01040800 	tsteq	r4, r0, lsl #16
 4a8:	196d0e03 	stmdbne	sp!, {r0, r1, r9, sl, fp}^
 4ac:	0b0b0b3e 	bleq	2c31ac <__bss_end+0x2ba210>
 4b0:	0b3a1349 	bleq	e851dc <__bss_end+0xe7c240>
 4b4:	0b390b3b 	bleq	e431a8 <__bss_end+0xe3a20c>
 4b8:	00001301 	andeq	r1, r0, r1, lsl #6
 4bc:	03002809 	movweq	r2, #2057	; 0x809
 4c0:	000b1c08 	andeq	r1, fp, r8, lsl #24
 4c4:	00280a00 	eoreq	r0, r8, r0, lsl #20
 4c8:	0b1c0e03 	bleq	703cdc <__bss_end+0x6fad40>
 4cc:	340b0000 	strcc	r0, [fp], #-0
 4d0:	3a0e0300 	bcc	3810d8 <__bss_end+0x37813c>
 4d4:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 4d8:	6c13490b 			; <UNDEFINED> instruction: 0x6c13490b
 4dc:	00180219 	andseq	r0, r8, r9, lsl r2
 4e0:	00020c00 	andeq	r0, r2, r0, lsl #24
 4e4:	193c0e03 	ldmdbne	ip!, {r0, r1, r9, sl, fp}
 4e8:	0f0d0000 	svceq	0x000d0000
 4ec:	490b0b00 	stmdbmi	fp, {r8, r9, fp}
 4f0:	0e000013 	mcreq	0, 0, r0, cr0, cr3, {0}
 4f4:	0e03000d 	cdpeq	0, 0, cr0, cr3, cr13, {0}
 4f8:	0b3b0b3a 	bleq	ec31e8 <__bss_end+0xeba24c>
 4fc:	13490b39 	movtne	r0, #39737	; 0x9b39
 500:	00000b38 	andeq	r0, r0, r8, lsr fp
 504:	4901010f 	stmdbmi	r1, {r0, r1, r2, r3, r8}
 508:	00130113 	andseq	r0, r3, r3, lsl r1
 50c:	00211000 	eoreq	r1, r1, r0
 510:	0b2f1349 	bleq	bc523c <__bss_end+0xbbc2a0>
 514:	02110000 	andseq	r0, r1, #0
 518:	0b0e0301 	bleq	381124 <__bss_end+0x378188>
 51c:	3b0b3a0b 	blcc	2ced50 <__bss_end+0x2c5db4>
 520:	010b390b 	tsteq	fp, fp, lsl #18
 524:	12000013 	andne	r0, r0, #19
 528:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 52c:	0b3a0e03 	bleq	e83d40 <__bss_end+0xe7ada4>
 530:	0b390b3b 	bleq	e43224 <__bss_end+0xe3a288>
 534:	193c0e6e 	ldmdbne	ip!, {r1, r2, r3, r5, r6, r9, sl, fp}
 538:	13011364 	movwne	r1, #4964	; 0x1364
 53c:	05130000 	ldreq	r0, [r3, #-0]
 540:	34134900 	ldrcc	r4, [r3], #-2304	; 0xfffff700
 544:	14000019 	strne	r0, [r0], #-25	; 0xffffffe7
 548:	13490005 	movtne	r0, #36869	; 0x9005
 54c:	2e150000 	cdpcs	0, 1, cr0, cr5, cr0, {0}
 550:	03193f01 	tsteq	r9, #1, 30
 554:	3b0b3a0e 	blcc	2ced94 <__bss_end+0x2c5df8>
 558:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 55c:	3c13490e 			; <UNDEFINED> instruction: 0x3c13490e
 560:	01136419 	tsteq	r3, r9, lsl r4
 564:	16000013 			; <UNDEFINED> instruction: 0x16000013
 568:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 56c:	0b3a0e03 	bleq	e83d80 <__bss_end+0xe7ade4>
 570:	0b390b3b 	bleq	e43264 <__bss_end+0xe3a2c8>
 574:	13490e6e 	movtne	r0, #40558	; 0x9e6e
 578:	193c0b32 	ldmdbne	ip!, {r1, r4, r5, r8, r9, fp}
 57c:	13011364 	movwne	r1, #4964	; 0x1364
 580:	0d170000 	ldceq	0, cr0, [r7, #-0]
 584:	3a0e0300 	bcc	38118c <__bss_end+0x3781f0>
 588:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 58c:	3813490b 	ldmdacc	r3, {r0, r1, r3, r8, fp, lr}
 590:	000b320b 	andeq	r3, fp, fp, lsl #4
 594:	012e1800 			; <UNDEFINED> instruction: 0x012e1800
 598:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 59c:	0b3b0b3a 	bleq	ec328c <__bss_end+0xeba2f0>
 5a0:	0e6e0b39 	vmoveq.8	d14[5], r0
 5a4:	193c0b32 	ldmdbne	ip!, {r1, r4, r5, r8, r9, fp}
 5a8:	13011364 	movwne	r1, #4964	; 0x1364
 5ac:	2e190000 	cdpcs	0, 1, cr0, cr9, cr0, {0}
 5b0:	03193f01 	tsteq	r9, #1, 30
 5b4:	3b0b3a0e 	blcc	2cedf4 <__bss_end+0x2c5e58>
 5b8:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 5bc:	3213490e 	andscc	r4, r3, #229376	; 0x38000
 5c0:	64193c0b 	ldrvs	r3, [r9], #-3083	; 0xfffff3f5
 5c4:	1a000013 	bne	618 <shift+0x618>
 5c8:	13490115 	movtne	r0, #37141	; 0x9115
 5cc:	13011364 	movwne	r1, #4964	; 0x1364
 5d0:	1f1b0000 	svcne	0x001b0000
 5d4:	49131d00 	ldmdbmi	r3, {r8, sl, fp, ip}
 5d8:	1c000013 	stcne	0, cr0, [r0], {19}
 5dc:	0b0b0010 	bleq	2c0624 <__bss_end+0x2b7688>
 5e0:	00001349 	andeq	r1, r0, r9, asr #6
 5e4:	0b000f1d 	bleq	4260 <shift+0x4260>
 5e8:	1e00000b 	cdpne	0, 0, cr0, cr0, cr11, {0}
 5ec:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 5f0:	0b3b0b3a 	bleq	ec32e0 <__bss_end+0xeba344>
 5f4:	13490b39 	movtne	r0, #39737	; 0x9b39
 5f8:	00001802 	andeq	r1, r0, r2, lsl #16
 5fc:	3f012e1f 	svccc	0x00012e1f
 600:	3a0e0319 	bcc	38126c <__bss_end+0x3782d0>
 604:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 608:	490e6e0b 	stmdbmi	lr, {r0, r1, r3, r9, sl, fp, sp, lr}
 60c:	12011113 	andne	r1, r1, #-1073741820	; 0xc0000004
 610:	96184006 	ldrls	r4, [r8], -r6
 614:	13011942 	movwne	r1, #6466	; 0x1942
 618:	05200000 	streq	r0, [r0, #-0]!
 61c:	3a0e0300 	bcc	381224 <__bss_end+0x378288>
 620:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 624:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 628:	21000018 	tstcs	r0, r8, lsl r0
 62c:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 630:	0b3a0e03 	bleq	e83e44 <__bss_end+0xe7aea8>
 634:	0b390b3b 	bleq	e43328 <__bss_end+0xe3a38c>
 638:	13490e6e 	movtne	r0, #40558	; 0x9e6e
 63c:	06120111 			; <UNDEFINED> instruction: 0x06120111
 640:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
 644:	00130119 	andseq	r0, r3, r9, lsl r1
 648:	00342200 	eorseq	r2, r4, r0, lsl #4
 64c:	0b3a0803 	bleq	e82660 <__bss_end+0xe796c4>
 650:	0b390b3b 	bleq	e43344 <__bss_end+0xe3a3a8>
 654:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 658:	2e230000 	cdpcs	0, 2, cr0, cr3, cr0, {0}
 65c:	03193f01 	tsteq	r9, #1, 30
 660:	3b0b3a0e 	blcc	2ceea0 <__bss_end+0x2c5f04>
 664:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 668:	1201110e 	andne	r1, r1, #-2147483645	; 0x80000003
 66c:	97184006 	ldrls	r4, [r8, -r6]
 670:	13011942 	movwne	r1, #6466	; 0x1942
 674:	2e240000 	cdpcs	0, 2, cr0, cr4, cr0, {0}
 678:	03193f00 	tsteq	r9, #0, 30
 67c:	3b0b3a0e 	blcc	2ceebc <__bss_end+0x2c5f20>
 680:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 684:	1201110e 	andne	r1, r1, #-2147483645	; 0x80000003
 688:	97184006 	ldrls	r4, [r8, -r6]
 68c:	00001942 	andeq	r1, r0, r2, asr #18
 690:	3f012e25 	svccc	0x00012e25
 694:	3a0e0319 	bcc	381300 <__bss_end+0x378364>
 698:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 69c:	490e6e0b 	stmdbmi	lr, {r0, r1, r3, r9, sl, fp, sp, lr}
 6a0:	12011113 	andne	r1, r1, #-1073741820	; 0xc0000004
 6a4:	97184006 	ldrls	r4, [r8, -r6]
 6a8:	00001942 	andeq	r1, r0, r2, asr #18
 6ac:	01110100 	tsteq	r1, r0, lsl #2
 6b0:	0b130e25 	bleq	4c3f4c <__bss_end+0x4bafb0>
 6b4:	0e1b0e03 	cdpeq	14, 1, cr0, cr11, cr3, {0}
 6b8:	06120111 			; <UNDEFINED> instruction: 0x06120111
 6bc:	00001710 	andeq	r1, r0, r0, lsl r7
 6c0:	01013902 	tsteq	r1, r2, lsl #18
 6c4:	03000013 	movweq	r0, #19
 6c8:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 6cc:	0b3b0b3a 	bleq	ec33bc <__bss_end+0xeba420>
 6d0:	13490b39 	movtne	r0, #39737	; 0x9b39
 6d4:	0a1c193c 	beq	706bcc <__bss_end+0x6fdc30>
 6d8:	3a040000 	bcc	1006e0 <__bss_end+0xf7744>
 6dc:	3b0b3a00 	blcc	2ceee4 <__bss_end+0x2c5f48>
 6e0:	180b390b 	stmdane	fp, {r0, r1, r3, r8, fp, ip, sp}
 6e4:	05000013 	streq	r0, [r0, #-19]	; 0xffffffed
 6e8:	13490101 	movtne	r0, #37121	; 0x9101
 6ec:	00001301 	andeq	r1, r0, r1, lsl #6
 6f0:	49002106 	stmdbmi	r0, {r1, r2, r8, sp}
 6f4:	000b2f13 	andeq	r2, fp, r3, lsl pc
 6f8:	00260700 	eoreq	r0, r6, r0, lsl #14
 6fc:	00001349 	andeq	r1, r0, r9, asr #6
 700:	0b002408 	bleq	9728 <__bss_end+0x78c>
 704:	030b3e0b 	movweq	r3, #48651	; 0xbe0b
 708:	0900000e 	stmdbeq	r0, {r1, r2, r3}
 70c:	13470034 	movtne	r0, #28724	; 0x7034
 710:	2e0a0000 	cdpcs	0, 0, cr0, cr10, cr0, {0}
 714:	03193f01 	tsteq	r9, #1, 30
 718:	3b0b3a0e 	blcc	2cef58 <__bss_end+0x2c5fbc>
 71c:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 720:	1201110e 	andne	r1, r1, #-2147483645	; 0x80000003
 724:	97184006 	ldrls	r4, [r8, -r6]
 728:	13011942 	movwne	r1, #6466	; 0x1942
 72c:	050b0000 	streq	r0, [fp, #-0]
 730:	3a080300 	bcc	201338 <__bss_end+0x1f839c>
 734:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 738:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 73c:	0c000018 	stceq	0, cr0, [r0], {24}
 740:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 744:	0b3b0b3a 	bleq	ec3434 <__bss_end+0xeba498>
 748:	13490b39 	movtne	r0, #39737	; 0x9b39
 74c:	00001802 	andeq	r1, r0, r2, lsl #16
 750:	11010b0d 	tstne	r1, sp, lsl #22
 754:	00061201 	andeq	r1, r6, r1, lsl #4
 758:	00340e00 	eorseq	r0, r4, r0, lsl #28
 75c:	0b3a0803 	bleq	e82770 <__bss_end+0xe797d4>
 760:	0b390b3b 	bleq	e43454 <__bss_end+0xe3a4b8>
 764:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 768:	0f0f0000 	svceq	0x000f0000
 76c:	490b0b00 	stmdbmi	fp, {r8, r9, fp}
 770:	10000013 	andne	r0, r0, r3, lsl r0
 774:	00000026 	andeq	r0, r0, r6, lsr #32
 778:	0b000f11 	bleq	43c4 <shift+0x43c4>
 77c:	1200000b 	andne	r0, r0, #11
 780:	0b0b0024 	bleq	2c0818 <__bss_end+0x2b787c>
 784:	08030b3e 	stmdaeq	r3, {r1, r2, r3, r4, r5, r8, r9, fp}
 788:	05130000 	ldreq	r0, [r3, #-0]
 78c:	3a0e0300 	bcc	381394 <__bss_end+0x3783f8>
 790:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 794:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 798:	14000018 	strne	r0, [r0], #-24	; 0xffffffe8
 79c:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 7a0:	0b3a0e03 	bleq	e83fb4 <__bss_end+0xe7b018>
 7a4:	0b390b3b 	bleq	e43498 <__bss_end+0xe3a4fc>
 7a8:	13490e6e 	movtne	r0, #40558	; 0x9e6e
 7ac:	06120111 			; <UNDEFINED> instruction: 0x06120111
 7b0:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
 7b4:	00130119 	andseq	r0, r3, r9, lsl r1
 7b8:	012e1500 			; <UNDEFINED> instruction: 0x012e1500
 7bc:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 7c0:	0b3b0b3a 	bleq	ec34b0 <__bss_end+0xeba514>
 7c4:	0e6e0b39 	vmoveq.8	d14[5], r0
 7c8:	06120111 			; <UNDEFINED> instruction: 0x06120111
 7cc:	42961840 	addsmi	r1, r6, #64, 16	; 0x400000
 7d0:	00000019 	andeq	r0, r0, r9, lsl r0

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
  74:	000000fc 	strdeq	r0, [r0], -ip
	...
  80:	0000001c 	andeq	r0, r0, ip, lsl r0
  84:	0b170002 	bleq	5c0094 <__bss_end+0x5b70f8>
  88:	00040000 	andeq	r0, r4, r0
  8c:	00000000 	andeq	r0, r0, r0
  90:	00008328 	andeq	r8, r0, r8, lsr #6
  94:	0000045c 	andeq	r0, r0, ip, asr r4
	...
  a0:	0000001c 	andeq	r0, r0, ip, lsl r0
  a4:	163a0002 	ldrtne	r0, [sl], -r2
  a8:	00040000 	andeq	r0, r4, r0
  ac:	00000000 	andeq	r0, r0, r0
  b0:	00008784 	andeq	r8, r0, r4, lsl #15
  b4:	000004b8 			; <UNDEFINED> instruction: 0x000004b8
	...

Disassembly of section .debug_str:

00000000 <.debug_str>:
       0:	6573552f 	ldrbvs	r5, [r3, #-1327]!	; 0xfffffad1
       4:	772f7372 			; <UNDEFINED> instruction: 0x772f7372
       8:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
       c:	2f696a72 	svccs	0x00696a72
      10:	6b736544 	blvs	1cd9528 <__bss_end+0x1cd058c>
      14:	2f706f74 	svccs	0x00706f74
      18:	2f564146 	svccs	0x00564146
      1c:	6176614e 	cmnvs	r6, lr, asr #2
      20:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
      24:	4f2f6963 	svcmi	0x002f6963
      28:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
      2c:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
      30:	6b6c6172 	blvs	1b18600 <__bss_end+0x1b0f664>
      34:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
      38:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
      3c:	756f732f 	strbvc	r7, [pc, #-815]!	; fffffd15 <__bss_end+0xffff6d79>
      40:	73656372 	cmnvc	r5, #-939524095	; 0xc8000001
      44:	6573752f 	ldrbvs	r7, [r3, #-1327]!	; 0xfffffad1
      48:	61707372 	cmnvs	r0, r2, ror r3
      4c:	632f6563 			; <UNDEFINED> instruction: 0x632f6563
      50:	2e307472 	mrccs	4, 1, r7, cr0, cr2, {3}
      54:	552f0073 	strpl	r0, [pc, #-115]!	; ffffffe9 <__bss_end+0xffff704d>
      58:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
      5c:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
      60:	6a726574 	bvs	1c99638 <__bss_end+0x1c9069c>
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
      98:	752f7365 	strvc	r7, [pc, #-869]!	; fffffd3b <__bss_end+0xffff6d9f>
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
     12c:	6a363731 	bvs	d8ddf8 <__bss_end+0xd84e5c>
     130:	732d667a 			; <UNDEFINED> instruction: 0x732d667a
     134:	616d2d20 	cmnvs	sp, r0, lsr #26
     138:	2d206d72 	stccs	13, cr6, [r0, #-456]!	; 0xfffffe38
     13c:	6372616d 	cmnvs	r2, #1073741851	; 0x4000001b
     140:	72613d68 	rsbvc	r3, r1, #104, 26	; 0x1a00
     144:	7a36766d 	bvc	d9db00 <__bss_end+0xd94b64>
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
     184:	6a757a61 	bvs	1d5eb10 <__bss_end+0x1d55b74>
     188:	2f696369 	svccs	0x00696369
     18c:	732f534f 			; <UNDEFINED> instruction: 0x732f534f
     190:	73656d65 	cmnvc	r5, #6464	; 0x1940
     194:	6c617274 	sfmvs	f7, 2, [r1], #-464	; 0xfffffe30
     198:	6b2d616b 	blvs	b5874c <__bss_end+0xb4f7b0>
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
     1e4:	2b2b4320 	blcs	ad0e6c <__bss_end+0xac7ed0>
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
     260:	2b6b7a36 	blcs	1adeb40 <__bss_end+0x1ad5ba4>
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
     294:	755f6962 	ldrbvc	r6, [pc, #-2402]	; fffff93a <__bss_end+0xffff699e>
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
     324:	6b736544 	blvs	1cd983c <__bss_end+0x1cd08a0>
     328:	2f706f74 	svccs	0x00706f74
     32c:	2f564146 	svccs	0x00564146
     330:	6176614e 	cmnvs	r6, lr, asr #2
     334:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
     338:	4f2f6963 	svcmi	0x002f6963
     33c:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
     340:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
     344:	6b6c6172 	blvs	1b18914 <__bss_end+0x1b0f978>
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
     4bc:	676f6c00 	strbvs	r6, [pc, -r0, lsl #24]!
     4c0:	0064665f 	rsbeq	r6, r4, pc, asr r6
     4c4:	7478656e 	ldrbtvc	r6, [r8], #-1390	; 0xfffffa92
     4c8:	6e755200 	cdpvs	2, 7, cr5, cr5, cr0, {0}
     4cc:	6c62616e 	stfvse	f6, [r2], #-440	; 0xfffffe48
     4d0:	6e490065 	cdpvs	0, 4, cr0, cr9, cr5, {3}
     4d4:	696c6176 	stmdbvs	ip!, {r1, r2, r4, r5, r6, r8, sp, lr}^
     4d8:	61485f64 	cmpvs	r8, r4, ror #30
     4dc:	656c646e 	strbvs	r6, [ip, #-1134]!	; 0xfffffb92
     4e0:	6e755200 	cdpvs	2, 7, cr5, cr5, cr0, {0}
     4e4:	676e696e 	strbvs	r6, [lr, -lr, ror #18]!
     4e8:	61654400 	cmnvs	r5, r0, lsl #8
     4ec:	6e696c64 	cdpvs	12, 6, cr6, cr9, cr4, {3}
     4f0:	6e555f65 	cdpvs	15, 5, cr5, cr5, cr5, {3}
     4f4:	6e616863 	cdpvs	8, 6, cr6, cr1, cr3, {3}
     4f8:	00646567 	rsbeq	r6, r4, r7, ror #10
     4fc:	5f746547 	svcpl	0x00746547
     500:	72727543 	rsbsvc	r7, r2, #281018368	; 0x10c00000
     504:	5f746e65 	svcpl	0x00746e65
     508:	636f7250 	cmnvs	pc, #80, 4
     50c:	00737365 	rsbseq	r7, r3, r5, ror #6
     510:	4f495047 	svcmi	0x00495047
     514:	7361425f 	cmnvc	r1, #-268435451	; 0xf0000005
     518:	5a5f0065 	bpl	17c06b4 <__bss_end+0x17b7718>
     51c:	4336314e 	teqmi	r6, #-2147483629	; 0x80000013
     520:	636f7250 	cmnvs	pc, #80, 4
     524:	5f737365 	svcpl	0x00737365
     528:	616e614d 	cmnvs	lr, sp, asr #2
     52c:	31726567 	cmncc	r2, r7, ror #10
     530:	65724334 	ldrbvs	r4, [r2, #-820]!	; 0xfffffccc
     534:	5f657461 	svcpl	0x00657461
     538:	636f7250 	cmnvs	pc, #80, 4
     53c:	45737365 	ldrbmi	r7, [r3, #-869]!	; 0xfffffc9b
     540:	626a6850 	rsbvs	r6, sl, #80, 16	; 0x500000
     544:	43324900 	teqmi	r2, #0, 18
     548:	6172545f 	cmnvs	r2, pc, asr r4
     54c:	6361736e 	cmnvs	r1, #-1207959551	; 0xb8000001
     550:	6e6f6974 			; <UNDEFINED> instruction: 0x6e6f6974
     554:	78614d5f 	stmdavc	r1!, {r0, r1, r2, r3, r4, r6, r8, sl, fp, lr}^
     558:	7a69535f 	bvc	1a552dc <__bss_end+0x1a4c340>
     55c:	72700065 	rsbsvc	r0, r0, #101	; 0x65
     560:	5f007665 	svcpl	0x00007665
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
     5e0:	6f4e0076 	svcvs	0x004e0076
     5e4:	79666974 	stmdbvc	r6!, {r2, r4, r5, r6, r8, fp, sp, lr}^
     5e8:	006c6c41 	rsbeq	r6, ip, r1, asr #24
     5ec:	636f6c42 	cmnvs	pc, #16896	; 0x4200
     5f0:	75435f6b 	strbvc	r5, [r3, #-3947]	; 0xfffff095
     5f4:	6e657272 	mcrvs	2, 3, r7, cr5, cr2, {3}
     5f8:	72505f74 	subsvc	r5, r0, #116, 30	; 0x1d0
     5fc:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     600:	65470073 	strbvs	r0, [r7, #-115]	; 0xffffff8d
     604:	49505f74 	ldmdbmi	r0, {r2, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     608:	69750044 	ldmdbvs	r5!, {r2, r6}^
     60c:	3233746e 	eorscc	r7, r3, #1845493760	; 0x6e000000
     610:	4200745f 	andmi	r7, r0, #1593835520	; 0x5f000000
     614:	5f314353 	svcpl	0x00314353
     618:	65736142 	ldrbvs	r6, [r3, #-322]!	; 0xfffffebe
     61c:	69615700 	stmdbvs	r1!, {r8, r9, sl, ip, lr}^
     620:	544e0074 	strbpl	r0, [lr], #-116	; 0xffffff8c
     624:	5f6b7361 	svcpl	0x006b7361
     628:	74617453 	strbtvc	r7, [r1], #-1107	; 0xfffffbad
     62c:	63530065 	cmpvs	r3, #101	; 0x65
     630:	75646568 	strbvc	r6, [r4, #-1384]!	; 0xfffffa98
     634:	455f656c 	ldrbmi	r6, [pc, #-1388]	; d0 <shift+0xd0>
     638:	42004644 	andmi	r4, r0, #68, 12	; 0x4400000
     63c:	6b636f6c 	blvs	18dc3f4 <__bss_end+0x18d3458>
     640:	6d006465 	cfstrsvs	mvf6, [r0, #-404]	; 0xfffffe6c
     644:	72727543 	rsbsvc	r7, r2, #281018368	; 0x10c00000
     648:	5f746e65 	svcpl	0x00746e65
     64c:	6b736154 	blvs	1cd8ba4 <__bss_end+0x1ccfc08>
     650:	646f4e5f 	strbtvs	r4, [pc], #-3679	; 658 <shift+0x658>
     654:	68630065 	stmdavs	r3!, {r0, r2, r5, r6}^
     658:	745f7261 	ldrbvc	r7, [pc], #-609	; 660 <shift+0x660>
     65c:	5f6b6369 	svcpl	0x006b6369
     660:	616c6564 	cmnvs	ip, r4, ror #10
     664:	6c730079 	ldclvs	0, cr0, [r3], #-484	; 0xfffffe1c
     668:	5f706565 	svcpl	0x00706565
     66c:	656d6974 	strbvs	r6, [sp, #-2420]!	; 0xfffff68c
     670:	5a5f0072 	bpl	17c0840 <__bss_end+0x17b78a4>
     674:	4336314e 	teqmi	r6, #-2147483629	; 0x80000013
     678:	636f7250 	cmnvs	pc, #80, 4
     67c:	5f737365 	svcpl	0x00737365
     680:	616e614d 	cmnvs	lr, sp, asr #2
     684:	39726567 	ldmdbcc	r2!, {r0, r1, r2, r5, r6, r8, sl, sp, lr}^
     688:	74697753 	strbtvc	r7, [r9], #-1875	; 0xfffff8ad
     68c:	545f6863 	ldrbpl	r6, [pc], #-2147	; 694 <shift+0x694>
     690:	3150456f 	cmpcc	r0, pc, ror #10
     694:	72504338 	subsvc	r4, r0, #56, 6	; 0xe0000000
     698:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     69c:	694c5f73 	stmdbvs	ip, {r0, r1, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     6a0:	4e5f7473 	mrcmi	4, 2, r7, cr15, cr3, {3}
     6a4:	0065646f 	rsbeq	r6, r5, pc, ror #8
     6a8:	5f757063 	svcpl	0x00757063
     6ac:	746e6f63 	strbtvc	r6, [lr], #-3939	; 0xfffff09d
     6b0:	00747865 	rsbseq	r7, r4, r5, ror #16
     6b4:	61657243 	cmnvs	r5, r3, asr #4
     6b8:	505f6574 	subspl	r6, pc, r4, ror r5	; <UNPREDICTABLE>
     6bc:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     6c0:	4f007373 	svcmi	0x00007373
     6c4:	006e6570 	rsbeq	r6, lr, r0, ror r5
     6c8:	66667562 	strbtvs	r7, [r6], -r2, ror #10
     6cc:	6d695400 	cfstrdvs	mvd5, [r9, #-0]
     6d0:	425f7265 	subsmi	r7, pc, #1342177286	; 0x50000006
     6d4:	00657361 	rsbeq	r7, r5, r1, ror #6
     6d8:	6c335a5f 			; <UNDEFINED> instruction: 0x6c335a5f
     6dc:	4b50676f 	blmi	141a4a0 <__bss_end+0x1411504>
     6e0:	5a5f0063 	bpl	17c0874 <__bss_end+0x17b78d8>
     6e4:	4336314e 	teqmi	r6, #-2147483629	; 0x80000013
     6e8:	636f7250 	cmnvs	pc, #80, 4
     6ec:	5f737365 	svcpl	0x00737365
     6f0:	616e614d 	cmnvs	lr, sp, asr #2
     6f4:	31726567 	cmncc	r2, r7, ror #10
     6f8:	746f4e34 	strbtvc	r4, [pc], #-3636	; 700 <shift+0x700>
     6fc:	5f796669 	svcpl	0x00796669
     700:	636f7250 	cmnvs	pc, #80, 4
     704:	45737365 	ldrbmi	r7, [r3, #-869]!	; 0xfffffc9b
     708:	54323150 	ldrtpl	r3, [r2], #-336	; 0xfffffeb0
     70c:	6b736154 	blvs	1cd8c64 <__bss_end+0x1ccfcc8>
     710:	7274535f 	rsbsvc	r5, r4, #2080374785	; 0x7c000001
     714:	00746375 	rsbseq	r6, r4, r5, ror r3
     718:	5f746547 	svcpl	0x00746547
     71c:	65686353 	strbvs	r6, [r8, #-851]!	; 0xfffffcad
     720:	6e495f64 	cdpvs	15, 4, cr5, cr9, cr4, {3}
     724:	49006f66 	stmdbmi	r0, {r1, r2, r5, r6, r8, r9, sl, fp, sp, lr}
     728:	6c74434f 	ldclvs	3, cr4, [r4], #-316	; 0xfffffec4
     72c:	616c7300 	cmnvs	ip, r0, lsl #6
     730:	52006576 	andpl	r6, r0, #494927872	; 0x1d800000
     734:	00646165 	rsbeq	r6, r4, r5, ror #2
     738:	6d726554 	cfldr64vs	mvdx6, [r2, #-336]!	; 0xfffffeb0
     73c:	74616e69 	strbtvc	r6, [r1], #-3689	; 0xfffff197
     740:	6f4e0065 	svcvs	0x004e0065
     744:	79666974 	stmdbvc	r6!, {r2, r4, r5, r6, r8, fp, sp, lr}^
     748:	6f72505f 	svcvs	0x0072505f
     74c:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     750:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     754:	50433631 	subpl	r3, r3, r1, lsr r6
     758:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     75c:	4d5f7373 	ldclmi	3, cr7, [pc, #-460]	; 598 <shift+0x598>
     760:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
     764:	34437265 	strbcc	r7, [r3], #-613	; 0xfffffd9b
     768:	4e007645 	cfmadd32mi	mvax2, mvfx7, mvfx0, mvfx5
     76c:	6669746f 	strbtvs	r7, [r9], -pc, ror #8
     770:	614d0079 	hvcvs	53257	; 0xd009
     774:	74615078 	strbtvc	r5, [r1], #-120	; 0xffffff88
     778:	6e654c68 	cdpvs	12, 6, cr4, cr5, cr8, {3}
     77c:	00687467 	rsbeq	r7, r8, r7, ror #8
     780:	4678614d 	ldrbtmi	r6, [r8], -sp, asr #2
     784:	69724453 	ldmdbvs	r2!, {r0, r1, r4, r6, sl, lr}^
     788:	4e726576 	mrcmi	5, 3, r6, cr2, cr6, {3}
     78c:	4c656d61 	stclmi	13, cr6, [r5], #-388	; 0xfffffe7c
     790:	74676e65 	strbtvc	r6, [r7], #-3685	; 0xfffff19b
     794:	5a5f0068 	bpl	17c093c <__bss_end+0x17b79a0>
     798:	4336314e 	teqmi	r6, #-2147483629	; 0x80000013
     79c:	636f7250 	cmnvs	pc, #80, 4
     7a0:	5f737365 	svcpl	0x00737365
     7a4:	616e614d 	cmnvs	lr, sp, asr #2
     7a8:	31726567 	cmncc	r2, r7, ror #10
     7ac:	68635331 	stmdavs	r3!, {r0, r4, r5, r8, r9, ip, lr}^
     7b0:	6c756465 	cfldrdvs	mvd6, [r5], #-404	; 0xfffffe6c
     7b4:	52525f65 	subspl	r5, r2, #404	; 0x194
     7b8:	4e007645 	cfmadd32mi	mvax2, mvfx7, mvfx0, mvfx5
     7bc:	5f746547 	svcpl	0x00746547
     7c0:	65686353 	strbvs	r6, [r8, #-851]!	; 0xfffffcad
     7c4:	6e495f64 	cdpvs	15, 4, cr5, cr9, cr4, {3}
     7c8:	545f6f66 	ldrbpl	r6, [pc], #-3942	; 7d0 <shift+0x7d0>
     7cc:	00657079 	rsbeq	r7, r5, r9, ror r0
     7d0:	4f495047 	svcmi	0x00495047
     7d4:	6e69505f 	mcrvs	0, 3, r5, cr9, cr15, {2}
     7d8:	756f435f 	strbvc	r4, [pc, #-863]!	; 481 <shift+0x481>
     7dc:	7400746e 	strvc	r7, [r0], #-1134	; 0xfffffb92
     7e0:	006b7361 	rsbeq	r7, fp, r1, ror #6
     7e4:	6c6f6f62 	stclvs	15, cr6, [pc], #-392	; 664 <shift+0x664>
     7e8:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     7ec:	50433631 	subpl	r3, r3, r1, lsr r6
     7f0:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     7f4:	4d5f7373 	ldclmi	3, cr7, [pc, #-460]	; 630 <shift+0x630>
     7f8:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
     7fc:	38317265 	ldmdacc	r1!, {r0, r2, r5, r6, r9, ip, sp, lr}
     800:	5f746547 	svcpl	0x00746547
     804:	65686353 	strbvs	r6, [r8, #-851]!	; 0xfffffcad
     808:	656c7564 	strbvs	r7, [ip, #-1380]!	; 0xfffffa9c
     80c:	6e495f72 	mcrvs	15, 2, r5, cr9, cr2, {3}
     810:	32456f66 	subcc	r6, r5, #408	; 0x198
     814:	65474e30 	strbvs	r4, [r7, #-3632]	; 0xfffff1d0
     818:	63535f74 	cmpvs	r3, #116, 30	; 0x1d0
     81c:	5f646568 	svcpl	0x00646568
     820:	6f666e49 	svcvs	0x00666e49
     824:	7079545f 	rsbsvc	r5, r9, pc, asr r4
     828:	00765065 	rsbseq	r5, r6, r5, rrx
     82c:	474e5254 	smlsldmi	r5, lr, r4, r2
     830:	7361425f 	cmnvc	r1, #-268435451	; 0xf0000005
     834:	65440065 	strbvs	r0, [r4, #-101]	; 0xffffff9b
     838:	6c756166 	ldfvse	f6, [r5], #-408	; 0xfffffe68
     83c:	6c435f74 	mcrrvs	15, 7, r5, r3, cr4
     840:	5f6b636f 	svcpl	0x006b636f
     844:	65746152 	ldrbvs	r6, [r4, #-338]!	; 0xfffffeae
     848:	72506d00 	subsvc	r6, r0, #0, 26
     84c:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     850:	694c5f73 	stmdbvs	ip, {r0, r1, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     854:	485f7473 	ldmdami	pc, {r0, r1, r4, r5, r6, sl, ip, sp, lr}^	; <UNPREDICTABLE>
     858:	00646165 	rsbeq	r6, r4, r5, ror #2
     85c:	6863536d 	stmdavs	r3!, {r0, r2, r3, r5, r6, r8, r9, ip, lr}^
     860:	6c756465 	cfldrdvs	mvd6, [r5], #-404	; 0xfffffe6c
     864:	6e465f65 	cdpvs	15, 4, cr5, cr6, cr5, {3}
     868:	5a5f0063 	bpl	17c09fc <__bss_end+0x17b7a60>
     86c:	4336314e 	teqmi	r6, #-2147483629	; 0x80000013
     870:	636f7250 	cmnvs	pc, #80, 4
     874:	5f737365 	svcpl	0x00737365
     878:	616e614d 	cmnvs	lr, sp, asr #2
     87c:	32726567 	rsbscc	r6, r2, #432013312	; 0x19c00000
     880:	6f6c4231 	svcvs	0x006c4231
     884:	435f6b63 	cmpmi	pc, #101376	; 0x18c00
     888:	65727275 	ldrbvs	r7, [r2, #-629]!	; 0xfffffd8b
     88c:	505f746e 	subspl	r7, pc, lr, ror #8
     890:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     894:	76457373 			; <UNDEFINED> instruction: 0x76457373
     898:	636f4c00 	cmnvs	pc, #0, 24
     89c:	6e555f6b 	cdpvs	15, 5, cr5, cr5, cr11, {3}
     8a0:	6b636f6c 	blvs	18dc658 <__bss_end+0x18d36bc>
     8a4:	6d006465 	cfstrsvs	mvf6, [r0, #-404]	; 0xfffffe6c
     8a8:	7473614c 	ldrbtvc	r6, [r3], #-332	; 0xfffffeb4
     8ac:	4449505f 	strbmi	r5, [r9], #-95	; 0xffffffa1
     8b0:	69775300 	ldmdbvs	r7!, {r8, r9, ip, lr}^
     8b4:	5f686374 	svcpl	0x00686374
     8b8:	43006f54 	movwmi	r6, #3924	; 0xf54
     8bc:	65736f6c 	ldrbvs	r6, [r3, #-3948]!	; 0xfffff094
     8c0:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     8c4:	50433631 	subpl	r3, r3, r1, lsr r6
     8c8:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     8cc:	4d5f7373 	ldclmi	3, cr7, [pc, #-460]	; 708 <shift+0x708>
     8d0:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
     8d4:	32317265 	eorscc	r7, r1, #1342177286	; 0x50000006
     8d8:	65686353 	strbvs	r6, [r8, #-851]!	; 0xfffffcad
     8dc:	656c7564 	strbvs	r7, [ip, #-1380]!	; 0xfffffa9c
     8e0:	4644455f 			; <UNDEFINED> instruction: 0x4644455f
     8e4:	42007645 	andmi	r7, r0, #72351744	; 0x4500000
     8e8:	5f304353 	svcpl	0x00304353
     8ec:	65736142 	ldrbvs	r6, [r3, #-322]!	; 0xfffffebe
     8f0:	67726100 	ldrbvs	r6, [r2, -r0, lsl #2]!
     8f4:	6f6e0063 	svcvs	0x006e0063
     8f8:	69666974 	stmdbvs	r6!, {r2, r4, r5, r6, r8, fp, sp, lr}^
     8fc:	645f6465 	ldrbvs	r6, [pc], #-1125	; 904 <shift+0x904>
     900:	6c646165 	stfvse	f6, [r4], #-404	; 0xfffffe6c
     904:	00656e69 	rsbeq	r6, r5, r9, ror #28
     908:	76677261 	strbtvc	r7, [r7], -r1, ror #4
     90c:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     910:	50433631 	subpl	r3, r3, r1, lsr r6
     914:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     918:	4d5f7373 	ldclmi	3, cr7, [pc, #-460]	; 754 <shift+0x754>
     91c:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
     920:	34317265 	ldrtcc	r7, [r1], #-613	; 0xfffffd9b
     924:	69746f4e 	ldmdbvs	r4!, {r1, r2, r3, r6, r8, r9, sl, fp, sp, lr}^
     928:	505f7966 	subspl	r7, pc, r6, ror #18
     92c:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
     930:	6a457373 	bvs	115d704 <__bss_end+0x1154768>
     934:	466f4e00 	strbtmi	r4, [pc], -r0, lsl #28
     938:	73656c69 	cmnvc	r5, #26880	; 0x6900
     93c:	65747379 	ldrbvs	r7, [r4, #-889]!	; 0xfffffc87
     940:	6972446d 	ldmdbvs	r2!, {r0, r2, r3, r5, r6, sl, lr}^
     944:	00726576 	rsbseq	r6, r2, r6, ror r5
     948:	64616544 	strbtvs	r6, [r1], #-1348	; 0xfffffabc
     94c:	656e696c 	strbvs	r6, [lr, #-2412]!	; 0xfffff694
     950:	6f687300 	svcvs	0x00687300
     954:	69207472 	stmdbvs	r0!, {r1, r4, r5, r6, sl, ip, sp, lr}
     958:	4d00746e 	cfstrsmi	mvf7, [r0, #-440]	; 0xfffffe48
     95c:	69467861 	stmdbvs	r6, {r0, r5, r6, fp, ip, sp, lr}^
     960:	616e656c 	cmnvs	lr, ip, ror #10
     964:	654c656d 	strbvs	r6, [ip, #-1389]	; 0xfffffa93
     968:	6874676e 	ldmdavs	r4!, {r1, r2, r3, r5, r6, r8, r9, sl, sp, lr}^
     96c:	72504300 	subsvc	r4, r0, #0, 6
     970:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     974:	614d5f73 	hvcvs	54771	; 0xd5f3
     978:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     97c:	74740072 	ldrbtvc	r0, [r4], #-114	; 0xffffff8e
     980:	00307262 	eorseq	r7, r0, r2, ror #4
     984:	4957534e 	ldmdbmi	r7, {r1, r2, r3, r6, r8, r9, ip, lr}^
     988:	6c69465f 	stclvs	6, cr4, [r9], #-380	; 0xfffffe84
     98c:	73797365 	cmnvc	r9, #-1811939327	; 0x94000001
     990:	5f6d6574 	svcpl	0x006d6574
     994:	76726553 			; <UNDEFINED> instruction: 0x76726553
     998:	00656369 	rsbeq	r6, r5, r9, ror #6
     99c:	6573552f 	ldrbvs	r5, [r3, #-1327]!	; 0xfffffad1
     9a0:	772f7372 			; <UNDEFINED> instruction: 0x772f7372
     9a4:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
     9a8:	2f696a72 	svccs	0x00696a72
     9ac:	6b736544 	blvs	1cd9ec4 <__bss_end+0x1cd0f28>
     9b0:	2f706f74 	svccs	0x00706f74
     9b4:	2f564146 	svccs	0x00564146
     9b8:	6176614e 	cmnvs	r6, lr, asr #2
     9bc:	696a757a 	stmdbvs	sl!, {r1, r3, r4, r5, r6, r8, sl, ip, sp, lr}^
     9c0:	4f2f6963 	svcmi	0x002f6963
     9c4:	65732f53 	ldrbvs	r2, [r3, #-3923]!	; 0xfffff0ad
     9c8:	7473656d 	ldrbtvc	r6, [r3], #-1389	; 0xfffffa93
     9cc:	6b6c6172 	blvs	1b18f9c <__bss_end+0x1b10000>
     9d0:	696b2d61 	stmdbvs	fp!, {r0, r5, r6, r8, sl, fp, sp}^
     9d4:	736f2d76 	cmnvc	pc, #7552	; 0x1d80
     9d8:	756f732f 	strbvc	r7, [pc, #-815]!	; 6b1 <shift+0x6b1>
     9dc:	73656372 	cmnvc	r5, #-939524095	; 0xc8000001
     9e0:	6573752f 	ldrbvs	r7, [r3, #-1327]!	; 0xfffffad1
     9e4:	61707372 	cmnvs	r0, r2, ror r3
     9e8:	732f6563 			; <UNDEFINED> instruction: 0x732f6563
     9ec:	6576616c 	ldrbvs	r6, [r6, #-364]!	; 0xfffffe94
     9f0:	7361745f 	cmnvc	r1, #1593835520	; 0x5f000000
     9f4:	616d2f6b 	cmnvs	sp, fp, ror #30
     9f8:	632e6e69 			; <UNDEFINED> instruction: 0x632e6e69
     9fc:	4e007070 	mcrmi	0, 0, r7, cr0, cr0, {3}
     a00:	5f495753 	svcpl	0x00495753
     a04:	636f7250 	cmnvs	pc, #80, 4
     a08:	5f737365 	svcpl	0x00737365
     a0c:	76726553 			; <UNDEFINED> instruction: 0x76726553
     a10:	00656369 	rsbeq	r6, r5, r9, ror #6
     a14:	6e65706f 	cdpvs	0, 6, cr7, cr5, cr15, {3}
     a18:	665f6465 	ldrbvs	r6, [pc], -r5, ror #8
     a1c:	73656c69 	cmnvc	r5, #26880	; 0x6900
     a20:	65695900 	strbvs	r5, [r9, #-2304]!	; 0xfffff700
     a24:	4900646c 	stmdbmi	r0, {r2, r3, r5, r6, sl, sp, lr}
     a28:	6665646e 	strbtvs	r6, [r5], -lr, ror #8
     a2c:	74696e69 	strbtvc	r6, [r9], #-3689	; 0xfffff197
     a30:	65470065 	strbvs	r0, [r7, #-101]	; 0xffffff9b
     a34:	72505f74 	subsvc	r5, r0, #116, 30	; 0x1d0
     a38:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     a3c:	79425f73 	stmdbvc	r2, {r0, r1, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     a40:	4449505f 	strbmi	r5, [r9], #-95	; 0xffffffa1
     a44:	72655000 	rsbvc	r5, r5, #0
     a48:	65687069 	strbvs	r7, [r8, #-105]!	; 0xffffff97
     a4c:	5f6c6172 	svcpl	0x006c6172
     a50:	65736142 	ldrbvs	r6, [r3, #-322]!	; 0xfffffebe
     a54:	6e6f6c00 	cdpvs	12, 6, cr6, cr15, cr0, {0}
     a58:	6e752067 	cdpvs	0, 7, cr2, cr5, cr7, {3}
     a5c:	6e676973 			; <UNDEFINED> instruction: 0x6e676973
     a60:	69206465 	stmdbvs	r0!, {r0, r2, r5, r6, sl, sp, lr}
     a64:	4900746e 	stmdbmi	r0, {r1, r2, r3, r5, r6, sl, ip, sp, lr}
     a68:	6c61766e 	stclvs	6, cr7, [r1], #-440	; 0xfffffe48
     a6c:	505f6469 	subspl	r6, pc, r9, ror #8
     a70:	4c006e69 	stcmi	14, cr6, [r0], {105}	; 0x69
     a74:	5f6b636f 	svcpl	0x006b636f
     a78:	6b636f4c 	blvs	18dc7b0 <__bss_end+0x18d3814>
     a7c:	5f006465 	svcpl	0x00006465
     a80:	36314e5a 			; <UNDEFINED> instruction: 0x36314e5a
     a84:	6f725043 	svcvs	0x00725043
     a88:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     a8c:	6e614d5f 	mcrvs	13, 3, r4, cr1, cr15, {2}
     a90:	72656761 	rsbvc	r6, r5, #25427968	; 0x1840000
     a94:	61483831 	cmpvs	r8, r1, lsr r8
     a98:	656c646e 	strbvs	r6, [ip, #-1134]!	; 0xfffffb92
     a9c:	6f72505f 	svcvs	0x0072505f
     aa0:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     aa4:	4957535f 	ldmdbmi	r7, {r0, r1, r2, r3, r4, r6, r8, r9, ip, lr}^
     aa8:	4e303245 	cdpmi	2, 3, cr3, cr0, cr5, {2}
     aac:	5f495753 	svcpl	0x00495753
     ab0:	636f7250 	cmnvs	pc, #80, 4
     ab4:	5f737365 	svcpl	0x00737365
     ab8:	76726553 			; <UNDEFINED> instruction: 0x76726553
     abc:	6a656369 	bvs	1959868 <__bss_end+0x19508cc>
     ac0:	31526a6a 	cmpcc	r2, sl, ror #20
     ac4:	57535431 	smmlarpl	r3, r1, r4, r5
     ac8:	65525f49 	ldrbvs	r5, [r2, #-3913]	; 0xfffff0b7
     acc:	746c7573 	strbtvc	r7, [ip], #-1395	; 0xfffffa8d
     ad0:	68637300 	stmdavs	r3!, {r8, r9, ip, sp, lr}^
     ad4:	635f6465 	cmpvs	pc, #1694498816	; 0x65000000
     ad8:	746e756f 	strbtvc	r7, [lr], #-1391	; 0xfffffa91
     adc:	75007265 	strvc	r7, [r0, #-613]	; 0xfffffd9b
     ae0:	6769736e 	strbvs	r7, [r9, -lr, ror #6]!
     ae4:	2064656e 	rsbcs	r6, r4, lr, ror #10
     ae8:	72616863 	rsbvc	r6, r1, #6488064	; 0x630000
     aec:	43324900 	teqmi	r2, #0, 18
     af0:	414c535f 	cmpmi	ip, pc, asr r3
     af4:	425f4556 	subsmi	r4, pc, #360710144	; 0x15800000
     af8:	00657361 	rsbeq	r7, r5, r1, ror #6
     afc:	65746e49 	ldrbvs	r6, [r4, #-3657]!	; 0xfffff1b7
     b00:	70757272 	rsbsvc	r7, r5, r2, ror r2
     b04:	6c626174 	stfvse	f6, [r2], #-464	; 0xfffffe30
     b08:	6c535f65 	mrrcvs	15, 6, r5, r3, cr5
     b0c:	00706565 	rsbseq	r6, r0, r5, ror #10
     b10:	65686353 	strbvs	r6, [r8, #-851]!	; 0xfffffcad
     b14:	656c7564 	strbvs	r7, [ip, #-1380]!	; 0xfffffa9c
     b18:	0052525f 	subseq	r5, r2, pc, asr r2
     b1c:	5f585541 	svcpl	0x00585541
     b20:	65736142 	ldrbvs	r6, [r3, #-322]!	; 0xfffffebe
     b24:	43534200 	cmpmi	r3, #0, 4
     b28:	61425f32 	cmpvs	r2, r2, lsr pc
     b2c:	73006573 	movwvc	r6, #1395	; 0x573
     b30:	65746174 	ldrbvs	r6, [r4, #-372]!	; 0xfffffe8c
     b34:	69725700 	ldmdbvs	r2!, {r8, r9, sl, ip, lr}^
     b38:	4f5f6574 	svcmi	0x005f6574
     b3c:	00796c6e 	rsbseq	r6, r9, lr, ror #24
     b40:	65686353 	strbvs	r6, [r8, #-851]!	; 0xfffffcad
     b44:	656c7564 	strbvs	r7, [ip, #-1380]!	; 0xfffffa9c
     b48:	63695400 	cmnvs	r9, #0, 8
     b4c:	6f435f6b 	svcvs	0x00435f6b
     b50:	00746e75 	rsbseq	r6, r4, r5, ror lr
     b54:	314e5a5f 	cmpcc	lr, pc, asr sl
     b58:	72504336 	subsvc	r4, r0, #-671088640	; 0xd8000000
     b5c:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     b60:	614d5f73 	hvcvs	54771	; 0xd5f3
     b64:	6567616e 	strbvs	r6, [r7, #-366]!	; 0xfffffe92
     b68:	55383172 	ldrpl	r3, [r8, #-370]!	; 0xfffffe8e
     b6c:	70616d6e 	rsbvc	r6, r1, lr, ror #26
     b70:	6c69465f 	stclvs	6, cr4, [r9], #-380	; 0xfffffe84
     b74:	75435f65 	strbvc	r5, [r3, #-3941]	; 0xfffff09b
     b78:	6e657272 	mcrvs	2, 3, r7, cr5, cr2, {3}
     b7c:	006a4574 	rsbeq	r4, sl, r4, ror r5
     b80:	646e6148 	strbtvs	r6, [lr], #-328	; 0xfffffeb8
     b84:	465f656c 	ldrbmi	r6, [pc], -ip, ror #10
     b88:	73656c69 	cmnvc	r5, #26880	; 0x6900
     b8c:	65747379 	ldrbvs	r7, [r4, #-889]!	; 0xfffffc87
     b90:	57535f6d 	ldrbpl	r5, [r3, -sp, ror #30]
     b94:	68730049 	ldmdavs	r3!, {r0, r3, r6}^
     b98:	2074726f 	rsbscs	r7, r4, pc, ror #4
     b9c:	69736e75 	ldmdbvs	r3!, {r0, r2, r4, r5, r6, r9, sl, fp, sp, lr}^
     ba0:	64656e67 	strbtvs	r6, [r5], #-3687	; 0xfffff199
     ba4:	746e6920 	strbtvc	r6, [lr], #-2336	; 0xfffff6e0
     ba8:	69616d00 	stmdbvs	r1!, {r8, sl, fp, sp, lr}^
     bac:	6e49006e 	cdpvs	0, 4, cr0, cr9, cr14, {3}
     bb0:	72726574 	rsbsvc	r6, r2, #116, 10	; 0x1d000000
     bb4:	5f747075 	svcpl	0x00747075
     bb8:	746e6f43 	strbtvc	r6, [lr], #-3907	; 0xfffff0bd
     bbc:	6c6c6f72 	stclvs	15, cr6, [ip], #-456	; 0xfffffe38
     bc0:	425f7265 	subsmi	r7, pc, #1342177286	; 0x50000006
     bc4:	00657361 	rsbeq	r7, r5, r1, ror #6
     bc8:	64616552 	strbtvs	r6, [r1], #-1362	; 0xfffffaae
     bcc:	6972575f 	ldmdbvs	r2!, {r0, r1, r2, r3, r4, r6, r8, r9, sl, ip, lr}^
     bd0:	41006574 	tstmi	r0, r4, ror r5
     bd4:	76697463 	strbtvc	r7, [r9], -r3, ror #8
     bd8:	72505f65 	subsvc	r5, r0, #404	; 0x194
     bdc:	7365636f 	cmnvc	r5, #-1140850687	; 0xbc000001
     be0:	6f435f73 	svcvs	0x00435f73
     be4:	00746e75 	rsbseq	r6, r4, r5, ror lr
     be8:	626d7973 	rsbvs	r7, sp, #1884160	; 0x1cc000
     bec:	745f6c6f 	ldrbvc	r6, [pc], #-3183	; bf4 <shift+0xbf4>
     bf0:	5f6b6369 	svcpl	0x006b6369
     bf4:	616c6564 	cmnvs	ip, r4, ror #10
     bf8:	5a5f0079 	bpl	17c0de4 <__bss_end+0x17b7e48>
     bfc:	4336314e 	teqmi	r6, #-2147483629	; 0x80000013
     c00:	636f7250 	cmnvs	pc, #80, 4
     c04:	5f737365 	svcpl	0x00737365
     c08:	616e614d 	cmnvs	lr, sp, asr #2
     c0c:	32726567 	rsbscc	r6, r2, #432013312	; 0x19c00000
     c10:	6e614831 	mcrvs	8, 3, r4, cr1, cr1, {1}
     c14:	5f656c64 	svcpl	0x00656c64
     c18:	656c6946 	strbvs	r6, [ip, #-2374]!	; 0xfffff6ba
     c1c:	74737973 	ldrbtvc	r7, [r3], #-2419	; 0xfffff68d
     c20:	535f6d65 	cmppl	pc, #6464	; 0x1940
     c24:	32454957 	subcc	r4, r5, #1425408	; 0x15c000
     c28:	57534e33 	smmlarpl	r3, r3, lr, r4
     c2c:	69465f49 	stmdbvs	r6, {r0, r3, r6, r8, r9, sl, fp, ip, lr}^
     c30:	7973656c 	ldmdbvc	r3!, {r2, r3, r5, r6, r8, sl, sp, lr}^
     c34:	6d657473 	cfstrdvs	mvd7, [r5, #-460]!	; 0xfffffe34
     c38:	7265535f 	rsbvc	r5, r5, #2080374785	; 0x7c000001
     c3c:	65636976 	strbvs	r6, [r3, #-2422]!	; 0xfffff68a
     c40:	526a6a6a 	rsbpl	r6, sl, #434176	; 0x6a000
     c44:	53543131 	cmppl	r4, #1073741836	; 0x4000000c
     c48:	525f4957 	subspl	r4, pc, #1425408	; 0x15c000
     c4c:	6c757365 	ldclvs	3, cr7, [r5], #-404	; 0xfffffe6c
     c50:	552f0074 	strpl	r0, [pc, #-116]!	; be4 <shift+0xbe4>
     c54:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
     c58:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
     c5c:	6a726574 	bvs	1c9a234 <__bss_end+0x1c91298>
     c60:	65442f69 	strbvs	r2, [r4, #-3945]	; 0xfffff097
     c64:	6f746b73 	svcvs	0x00746b73
     c68:	41462f70 	hvcmi	25328	; 0x62f0
     c6c:	614e2f56 	cmpvs	lr, r6, asr pc
     c70:	757a6176 	ldrbvc	r6, [sl, #-374]!	; 0xfffffe8a
     c74:	6963696a 	stmdbvs	r3!, {r1, r3, r5, r6, r8, fp, sp, lr}^
     c78:	2f534f2f 	svccs	0x00534f2f
     c7c:	656d6573 	strbvs	r6, [sp, #-1395]!	; 0xfffffa8d
     c80:	61727473 	cmnvs	r2, r3, ror r4
     c84:	2d616b6c 	vstmdbcs	r1!, {d22-<overflow reg d75>}
     c88:	2d76696b 			; <UNDEFINED> instruction: 0x2d76696b
     c8c:	732f736f 			; <UNDEFINED> instruction: 0x732f736f
     c90:	6372756f 	cmnvs	r2, #465567744	; 0x1bc00000
     c94:	622f7365 	eorvs	r7, pc, #-1811939327	; 0x94000001
     c98:	646c6975 	strbtvs	r6, [ip], #-2421	; 0xfffff68b
     c9c:	6f6c6300 	svcvs	0x006c6300
     ca0:	53006573 	movwpl	r6, #1395	; 0x573
     ca4:	525f7465 	subspl	r7, pc, #1694498816	; 0x65000000
     ca8:	74616c65 	strbtvc	r6, [r1], #-3173	; 0xfffff39b
     cac:	00657669 	rsbeq	r7, r5, r9, ror #12
     cb0:	76746572 			; <UNDEFINED> instruction: 0x76746572
     cb4:	6e006c61 	cdpvs	12, 0, cr6, cr0, cr1, {3}
     cb8:	00727563 	rsbseq	r7, r2, r3, ror #10
     cbc:	65706970 	ldrbvs	r6, [r0, #-2416]!	; 0xfffff690
     cc0:	6e647200 	cdpvs	2, 6, cr7, cr4, cr0, {0}
     cc4:	5f006d75 	svcpl	0x00006d75
     cc8:	7331315a 	teqvc	r1, #-2147483626	; 0x80000016
     ccc:	64656863 	strbtvs	r6, [r5], #-2147	; 0xfffff79d
     cd0:	6569795f 	strbvs	r7, [r9, #-2399]!	; 0xfffff6a1
     cd4:	0076646c 	rsbseq	r6, r6, ip, ror #8
     cd8:	37315a5f 			; <UNDEFINED> instruction: 0x37315a5f
     cdc:	5f746573 	svcpl	0x00746573
     ce0:	6b736174 	blvs	1cd92b8 <__bss_end+0x1cd031c>
     ce4:	6165645f 	cmnvs	r5, pc, asr r4
     ce8:	6e696c64 	cdpvs	12, 6, cr6, cr9, cr4, {3}
     cec:	77006a65 	strvc	r6, [r0, -r5, ror #20]
     cf0:	00746961 	rsbseq	r6, r4, r1, ror #18
     cf4:	6e365a5f 			; <UNDEFINED> instruction: 0x6e365a5f
     cf8:	6669746f 	strbtvs	r7, [r9], -pc, ror #8
     cfc:	006a6a79 	rsbeq	r6, sl, r9, ror sl
     d00:	6c696146 	stfvse	f6, [r9], #-280	; 0xfffffee8
     d04:	69786500 	ldmdbvs	r8!, {r8, sl, sp, lr}^
     d08:	646f6374 	strbtvs	r6, [pc], #-884	; d10 <shift+0xd10>
     d0c:	63730065 	cmnvs	r3, #101	; 0x65
     d10:	5f646568 	svcpl	0x00646568
     d14:	6c656979 			; <UNDEFINED> instruction: 0x6c656979
     d18:	69740064 	ldmdbvs	r4!, {r2, r5, r6}^
     d1c:	635f6b63 	cmpvs	pc, #101376	; 0x18c00
     d20:	746e756f 	strbtvc	r7, [lr], #-1391	; 0xfffffa91
     d24:	7165725f 	cmnvc	r5, pc, asr r2
     d28:	65726975 	ldrbvs	r6, [r2, #-2421]!	; 0xfffff68b
     d2c:	5a5f0064 	bpl	17c0ec4 <__bss_end+0x17b7f28>
     d30:	65673432 	strbvs	r3, [r7, #-1074]!	; 0xfffffbce
     d34:	63615f74 	cmnvs	r1, #116, 30	; 0x1d0
     d38:	65766974 	ldrbvs	r6, [r6, #-2420]!	; 0xfffff68c
     d3c:	6f72705f 	svcvs	0x0072705f
     d40:	73736563 	cmnvc	r3, #415236096	; 0x18c00000
     d44:	756f635f 	strbvc	r6, [pc, #-863]!	; 9ed <shift+0x9ed>
     d48:	0076746e 	rsbseq	r7, r6, lr, ror #8
     d4c:	65706950 	ldrbvs	r6, [r0, #-2384]!	; 0xfffff6b0
     d50:	6c69465f 	stclvs	6, cr4, [r9], #-380	; 0xfffffe84
     d54:	72505f65 	subsvc	r5, r0, #404	; 0x194
     d58:	78696665 	stmdavc	r9!, {r0, r2, r5, r6, r9, sl, sp, lr}^
     d5c:	74655300 	strbtvc	r5, [r5], #-768	; 0xfffffd00
     d60:	7261505f 	rsbvc	r5, r1, #95	; 0x5f
     d64:	00736d61 	rsbseq	r6, r3, r1, ror #26
     d68:	34315a5f 	ldrtcc	r5, [r1], #-2655	; 0xfffff5a1
     d6c:	5f746567 	svcpl	0x00746567
     d70:	6b636974 	blvs	18db348 <__bss_end+0x18d23ac>
     d74:	756f635f 	strbvc	r6, [pc, #-863]!	; a1d <shift+0xa1d>
     d78:	0076746e 	rsbseq	r7, r6, lr, ror #8
     d7c:	65656c73 	strbvs	r6, [r5, #-3187]!	; 0xfffff38d
     d80:	69440070 	stmdbvs	r4, {r4, r5, r6}^
     d84:	6c626173 	stfvse	f6, [r2], #-460	; 0xfffffe34
     d88:	76455f65 	strbvc	r5, [r5], -r5, ror #30
     d8c:	5f746e65 	svcpl	0x00746e65
     d90:	65746544 	ldrbvs	r6, [r4, #-1348]!	; 0xfffffabc
     d94:	6f697463 	svcvs	0x00697463
     d98:	5a5f006e 	bpl	17c0f58 <__bss_end+0x17b7fbc>
     d9c:	72657439 	rsbvc	r7, r5, #956301312	; 0x39000000
     da0:	616e696d 	cmnvs	lr, sp, ror #18
     da4:	00696574 	rsbeq	r6, r9, r4, ror r5
     da8:	7265706f 	rsbvc	r7, r5, #111	; 0x6f
     dac:	6f697461 	svcvs	0x00697461
     db0:	5a5f006e 	bpl	17c0f70 <__bss_end+0x17b7fd4>
     db4:	6f6c6335 	svcvs	0x006c6335
     db8:	006a6573 	rsbeq	r6, sl, r3, ror r5
     dbc:	67365a5f 			; <UNDEFINED> instruction: 0x67365a5f
     dc0:	69707465 	ldmdbvs	r0!, {r0, r2, r5, r6, sl, ip, sp, lr}^
     dc4:	66007664 	strvs	r7, [r0], -r4, ror #12
     dc8:	656d616e 	strbvs	r6, [sp, #-366]!	; 0xfffffe92
     dcc:	69727700 	ldmdbvs	r2!, {r8, r9, sl, ip, sp, lr}^
     dd0:	74006574 	strvc	r6, [r0], #-1396	; 0xfffffa8c
     dd4:	736b6369 	cmnvc	fp, #-1543503871	; 0xa4000001
     dd8:	65706f00 	ldrbvs	r6, [r0, #-3840]!	; 0xfffff100
     ddc:	5a5f006e 	bpl	17c0f9c <__bss_end+0x17b8000>
     de0:	70697034 	rsbvc	r7, r9, r4, lsr r0
     de4:	634b5065 	movtvs	r5, #45157	; 0xb065
     de8:	444e006a 	strbmi	r0, [lr], #-106	; 0xffffff96
     dec:	6c646165 	stfvse	f6, [r4], #-404	; 0xfffffe6c
     df0:	5f656e69 	svcpl	0x00656e69
     df4:	73627553 	cmnvc	r2, #348127232	; 0x14c00000
     df8:	69767265 	ldmdbvs	r6!, {r0, r2, r5, r6, r9, ip, sp, lr}^
     dfc:	67006563 	strvs	r6, [r0, -r3, ror #10]
     e00:	745f7465 	ldrbvc	r7, [pc], #-1125	; e08 <shift+0xe08>
     e04:	5f6b6369 	svcpl	0x006b6369
     e08:	6e756f63 	cdpvs	15, 7, cr6, cr5, cr3, {3}
     e0c:	61700074 	cmnvs	r0, r4, ror r0
     e10:	006d6172 	rsbeq	r6, sp, r2, ror r1
     e14:	77355a5f 			; <UNDEFINED> instruction: 0x77355a5f
     e18:	65746972 	ldrbvs	r6, [r4, #-2418]!	; 0xfffff68e
     e1c:	634b506a 	movtvs	r5, #45162	; 0xb06a
     e20:	6567006a 	strbvs	r0, [r7, #-106]!	; 0xffffff96
     e24:	61745f74 	cmnvs	r4, r4, ror pc
     e28:	745f6b73 	ldrbvc	r6, [pc], #-2931	; e30 <shift+0xe30>
     e2c:	736b6369 	cmnvc	fp, #-1543503871	; 0xa4000001
     e30:	5f6f745f 	svcpl	0x006f745f
     e34:	64616564 	strbtvs	r6, [r1], #-1380	; 0xfffffa9c
     e38:	656e696c 	strbvs	r6, [lr, #-2412]!	; 0xfffff694
     e3c:	66756200 	ldrbtvs	r6, [r5], -r0, lsl #4
     e40:	7a69735f 	bvc	1a5dbc4 <__bss_end+0x1a54c28>
     e44:	65730065 	ldrbvs	r0, [r3, #-101]!	; 0xffffff9b
     e48:	61745f74 	cmnvs	r4, r4, ror pc
     e4c:	645f6b73 	ldrbvs	r6, [pc], #-2931	; e54 <shift+0xe54>
     e50:	6c646165 	stfvse	f6, [r4], #-404	; 0xfffffe6c
     e54:	00656e69 	rsbeq	r6, r5, r9, ror #28
     e58:	5f746547 	svcpl	0x00746547
     e5c:	61726150 	cmnvs	r2, r0, asr r1
     e60:	2f00736d 	svccs	0x0000736d
     e64:	72657355 	rsbvc	r7, r5, #1409286145	; 0x54000001
     e68:	69772f73 	ldmdbvs	r7!, {r0, r1, r4, r5, r6, r8, r9, sl, fp, sp}^
     e6c:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
     e70:	442f696a 	strtmi	r6, [pc], #-2410	; e78 <shift+0xe78>
     e74:	746b7365 	strbtvc	r7, [fp], #-869	; 0xfffffc9b
     e78:	462f706f 	strtmi	r7, [pc], -pc, rrx
     e7c:	4e2f5641 	cfmadda32mi	mvax2, mvax5, mvfx15, mvfx1
     e80:	7a617661 	bvc	185e80c <__bss_end+0x1855870>
     e84:	63696a75 	cmnvs	r9, #479232	; 0x75000
     e88:	534f2f69 	movtpl	r2, #65385	; 0xff69
     e8c:	6d65732f 	stclvs	3, cr7, [r5, #-188]!	; 0xffffff44
     e90:	72747365 	rsbsvc	r7, r4, #-1811939327	; 0x94000001
     e94:	616b6c61 	cmnvs	fp, r1, ror #24
     e98:	76696b2d 	strbtvc	r6, [r9], -sp, lsr #22
     e9c:	2f736f2d 	svccs	0x00736f2d
     ea0:	72756f73 	rsbsvc	r6, r5, #460	; 0x1cc
     ea4:	2f736563 	svccs	0x00736563
     ea8:	6c647473 	cfstrdvs	mvd7, [r4], #-460	; 0xfffffe34
     eac:	732f6269 			; <UNDEFINED> instruction: 0x732f6269
     eb0:	732f6372 			; <UNDEFINED> instruction: 0x732f6372
     eb4:	69666474 	stmdbvs	r6!, {r2, r4, r5, r6, sl, sp, lr}^
     eb8:	632e656c 			; <UNDEFINED> instruction: 0x632e656c
     ebc:	5f007070 	svcpl	0x00007070
     ec0:	6c73355a 	cfldr64vs	mvdx3, [r3], #-360	; 0xfffffe98
     ec4:	6a706565 	bvs	1c1a460 <__bss_end+0x1c114c4>
     ec8:	6966006a 	stmdbvs	r6!, {r1, r3, r5, r6}^
     ecc:	4700656c 	strmi	r6, [r0, -ip, ror #10]
     ed0:	525f7465 	subspl	r7, pc, #1694498816	; 0x65000000
     ed4:	69616d65 	stmdbvs	r1!, {r0, r2, r5, r6, r8, sl, fp, sp, lr}^
     ed8:	676e696e 	strbvs	r6, [lr, -lr, ror #18]!
     edc:	616e4500 	cmnvs	lr, r0, lsl #10
     ee0:	5f656c62 	svcpl	0x00656c62
     ee4:	6e657645 	cdpvs	6, 6, cr7, cr5, cr5, {2}
     ee8:	65445f74 	strbvs	r5, [r4, #-3956]	; 0xfffff08c
     eec:	74636574 	strbtvc	r6, [r3], #-1396	; 0xfffffa8c
     ef0:	006e6f69 	rsbeq	r6, lr, r9, ror #30
     ef4:	36325a5f 			; <UNDEFINED> instruction: 0x36325a5f
     ef8:	5f746567 	svcpl	0x00746567
     efc:	6b736174 	blvs	1cd94d4 <__bss_end+0x1cd0538>
     f00:	6369745f 	cmnvs	r9, #1593835520	; 0x5f000000
     f04:	745f736b 	ldrbvc	r7, [pc], #-875	; f0c <shift+0xf0c>
     f08:	65645f6f 	strbvs	r5, [r4, #-3951]!	; 0xfffff091
     f0c:	696c6461 	stmdbvs	ip!, {r0, r5, r6, sl, sp, lr}^
     f10:	0076656e 	rsbseq	r6, r6, lr, ror #10
     f14:	4957534e 	ldmdbmi	r7, {r1, r2, r3, r6, r8, r9, ip, lr}^
     f18:	7365525f 	cmnvc	r5, #-268435451	; 0xf0000005
     f1c:	5f746c75 	svcpl	0x00746c75
     f20:	65646f43 	strbvs	r6, [r4, #-3907]!	; 0xfffff0bd
     f24:	6e727700 	cdpvs	7, 7, cr7, cr2, cr0, {0}
     f28:	5f006d75 	svcpl	0x00006d75
     f2c:	6177345a 	cmnvs	r7, sl, asr r4
     f30:	6a6a7469 	bvs	1a9e0dc <__bss_end+0x1a95140>
     f34:	5a5f006a 	bpl	17c10e4 <__bss_end+0x17b8148>
     f38:	636f6935 	cmnvs	pc, #868352	; 0xd4000
     f3c:	316a6c74 	smccc	42692	; 0xa6c4
     f40:	4f494e36 	svcmi	0x00494e36
     f44:	5f6c7443 	svcpl	0x006c7443
     f48:	7265704f 	rsbvc	r7, r5, #79	; 0x4f
     f4c:	6f697461 	svcvs	0x00697461
     f50:	0076506e 	rsbseq	r5, r6, lr, rrx
     f54:	74636f69 	strbtvc	r6, [r3], #-3945	; 0xfffff097
     f58:	6572006c 	ldrbvs	r0, [r2, #-108]!	; 0xffffff94
     f5c:	746e6374 	strbtvc	r6, [lr], #-884	; 0xfffffc8c
     f60:	746f6e00 	strbtvc	r6, [pc], #-3584	; f68 <shift+0xf68>
     f64:	00796669 	rsbseq	r6, r9, r9, ror #12
     f68:	6d726574 	cfldr64vs	mvdx6, [r2, #-464]!	; 0xfffffe30
     f6c:	74616e69 	strbtvc	r6, [r1], #-3689	; 0xfffff197
     f70:	6f6d0065 	svcvs	0x006d0065
     f74:	62006564 	andvs	r6, r0, #100, 10	; 0x19000000
     f78:	65666675 	strbvs	r6, [r6, #-1653]!	; 0xfffff98b
     f7c:	5a5f0072 	bpl	17c114c <__bss_end+0x17b81b0>
     f80:	61657234 	cmnvs	r5, r4, lsr r2
     f84:	63506a64 	cmpvs	r0, #100, 20	; 0x64000
     f88:	4e47006a 	cdpmi	0, 4, cr0, cr7, cr10, {3}
     f8c:	2b432055 	blcs	10c90e8 <__bss_end+0x10c014c>
     f90:	2034312b 	eorscs	r3, r4, fp, lsr #2
     f94:	332e3031 			; <UNDEFINED> instruction: 0x332e3031
     f98:	3220312e 	eorcc	r3, r0, #-2147483637	; 0x8000000b
     f9c:	30313230 	eorscc	r3, r1, r0, lsr r2
     fa0:	20343238 	eorscs	r3, r4, r8, lsr r2
     fa4:	6c657228 	sfmvs	f7, 2, [r5], #-160	; 0xffffff60
     fa8:	65736165 	ldrbvs	r6, [r3, #-357]!	; 0xfffffe9b
     fac:	6d2d2029 	stcvs	0, cr2, [sp, #-164]!	; 0xffffff5c
     fb0:	616f6c66 	cmnvs	pc, r6, ror #24
     fb4:	62612d74 	rsbvs	r2, r1, #116, 26	; 0x1d00
     fb8:	61683d69 	cmnvs	r8, r9, ror #26
     fbc:	2d206472 	cfstrscs	mvf6, [r0, #-456]!	; 0xfffffe38
     fc0:	7570666d 	ldrbvc	r6, [r0, #-1645]!	; 0xfffff993
     fc4:	7066763d 	rsbvc	r7, r6, sp, lsr r6
     fc8:	666d2d20 	strbtvs	r2, [sp], -r0, lsr #26
     fcc:	74616f6c 	strbtvc	r6, [r1], #-3948	; 0xfffff094
     fd0:	6962612d 	stmdbvs	r2!, {r0, r2, r3, r5, r8, sp, lr}^
     fd4:	7261683d 	rsbvc	r6, r1, #3997696	; 0x3d0000
     fd8:	6d2d2064 	stcvs	0, cr2, [sp, #-400]!	; 0xfffffe70
     fdc:	3d757066 	ldclcc	0, cr7, [r5, #-408]!	; 0xfffffe68
     fe0:	20706676 	rsbscs	r6, r0, r6, ror r6
     fe4:	75746d2d 	ldrbvc	r6, [r4, #-3373]!	; 0xfffff2d3
     fe8:	613d656e 	teqvs	sp, lr, ror #10
     fec:	31316d72 	teqcc	r1, r2, ror sp
     ff0:	7a6a3637 	bvc	1a8e8d4 <__bss_end+0x1a85938>
     ff4:	20732d66 	rsbscs	r2, r3, r6, ror #26
     ff8:	72616d2d 	rsbvc	r6, r1, #2880	; 0xb40
     ffc:	6d2d206d 	stcvs	0, cr2, [sp, #-436]!	; 0xfffffe4c
    1000:	68637261 	stmdavs	r3!, {r0, r5, r6, r9, ip, sp, lr}^
    1004:	6d72613d 	ldfvse	f6, [r2, #-244]!	; 0xffffff0c
    1008:	6b7a3676 	blvs	1e8e9e8 <__bss_end+0x1e85a4c>
    100c:	2070662b 	rsbscs	r6, r0, fp, lsr #12
    1010:	2d20672d 	stccs	7, cr6, [r0, #-180]!	; 0xffffff4c
    1014:	672d2067 	strvs	r2, [sp, -r7, rrx]!
    1018:	304f2d20 	subcc	r2, pc, r0, lsr #26
    101c:	304f2d20 	subcc	r2, pc, r0, lsr #26
    1020:	6e662d20 	cdpvs	13, 6, cr2, cr6, cr0, {1}
    1024:	78652d6f 	stmdavc	r5!, {r0, r1, r2, r3, r5, r6, r8, sl, fp, sp}^
    1028:	74706563 	ldrbtvc	r6, [r0], #-1379	; 0xfffffa9d
    102c:	736e6f69 	cmnvc	lr, #420	; 0x1a4
    1030:	6e662d20 	cdpvs	13, 6, cr2, cr6, cr0, {1}
    1034:	74722d6f 	ldrbtvc	r2, [r2], #-3439	; 0xfffff291
    1038:	4e006974 			; <UNDEFINED> instruction: 0x4e006974
    103c:	74434f49 	strbvc	r4, [r3], #-3913	; 0xfffff0b7
    1040:	704f5f6c 	subvc	r5, pc, ip, ror #30
    1044:	74617265 	strbtvc	r7, [r1], #-613	; 0xfffffd9b
    1048:	006e6f69 	rsbeq	r6, lr, r9, ror #30
    104c:	63746572 	cmnvs	r4, #478150656	; 0x1c800000
    1050:	0065646f 	rsbeq	r6, r5, pc, ror #8
    1054:	5f746567 	svcpl	0x00746567
    1058:	69746361 	ldmdbvs	r4!, {r0, r5, r6, r8, r9, sp, lr}^
    105c:	705f6576 	subsvc	r6, pc, r6, ror r5	; <UNPREDICTABLE>
    1060:	65636f72 	strbvs	r6, [r3, #-3954]!	; 0xfffff08e
    1064:	635f7373 	cmpvs	pc, #-872415231	; 0xcc000001
    1068:	746e756f 	strbtvc	r7, [lr], #-1391	; 0xfffffa91
    106c:	6c696600 	stclvs	6, cr6, [r9], #-0
    1070:	6d616e65 	stclvs	14, cr6, [r1, #-404]!	; 0xfffffe6c
    1074:	65720065 	ldrbvs	r0, [r2, #-101]!	; 0xffffff9b
    1078:	67006461 	strvs	r6, [r0, -r1, ror #8]
    107c:	69707465 	ldmdbvs	r0!, {r0, r2, r5, r6, sl, ip, sp, lr}^
    1080:	5a5f0064 	bpl	17c1218 <__bss_end+0x17b827c>
    1084:	65706f34 	ldrbvs	r6, [r0, #-3892]!	; 0xfffff0cc
    1088:	634b506e 	movtvs	r5, #45166	; 0xb06e
    108c:	464e3531 			; <UNDEFINED> instruction: 0x464e3531
    1090:	5f656c69 	svcpl	0x00656c69
    1094:	6e65704f 	cdpvs	0, 6, cr7, cr5, cr15, {2}
    1098:	646f4d5f 	strbtvs	r4, [pc], #-3423	; 10a0 <shift+0x10a0>
    109c:	6e690065 	cdpvs	0, 6, cr0, cr9, cr5, {3}
    10a0:	00747570 	rsbseq	r7, r4, r0, ror r5
    10a4:	74736564 	ldrbtvc	r6, [r3], #-1380	; 0xfffffa9c
    10a8:	657a6200 	ldrbvs	r6, [sl, #-512]!	; 0xfffffe00
    10ac:	6c006f72 	stcvs	15, cr6, [r0], {114}	; 0x72
    10b0:	74676e65 	strbtvc	r6, [r7], #-3685	; 0xfffff19b
    10b4:	5a5f0068 	bpl	17c125c <__bss_end+0x17b82c0>
    10b8:	657a6235 	ldrbvs	r6, [sl, #-565]!	; 0xfffffdcb
    10bc:	76506f72 	usub16vc	r6, r0, r2
    10c0:	552f0069 	strpl	r0, [pc, #-105]!	; 105f <shift+0x105f>
    10c4:	73726573 	cmnvc	r2, #482344960	; 0x1cc00000
    10c8:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
    10cc:	6a726574 	bvs	1c9a6a4 <__bss_end+0x1c91708>
    10d0:	65442f69 	strbvs	r2, [r4, #-3945]	; 0xfffff097
    10d4:	6f746b73 	svcvs	0x00746b73
    10d8:	41462f70 	hvcmi	25328	; 0x62f0
    10dc:	614e2f56 	cmpvs	lr, r6, asr pc
    10e0:	757a6176 	ldrbvc	r6, [sl, #-374]!	; 0xfffffe8a
    10e4:	6963696a 	stmdbvs	r3!, {r1, r3, r5, r6, r8, fp, sp, lr}^
    10e8:	2f534f2f 	svccs	0x00534f2f
    10ec:	656d6573 	strbvs	r6, [sp, #-1395]!	; 0xfffffa8d
    10f0:	61727473 	cmnvs	r2, r3, ror r4
    10f4:	2d616b6c 	vstmdbcs	r1!, {d22-<overflow reg d75>}
    10f8:	2d76696b 			; <UNDEFINED> instruction: 0x2d76696b
    10fc:	732f736f 			; <UNDEFINED> instruction: 0x732f736f
    1100:	6372756f 	cmnvs	r2, #465567744	; 0x1bc00000
    1104:	732f7365 			; <UNDEFINED> instruction: 0x732f7365
    1108:	696c6474 	stmdbvs	ip!, {r2, r4, r5, r6, sl, sp, lr}^
    110c:	72732f62 	rsbsvc	r2, r3, #392	; 0x188
    1110:	74732f63 	ldrbtvc	r2, [r3], #-3939	; 0xfffff09d
    1114:	72747364 	rsbsvc	r7, r4, #100, 6	; 0x90000001
    1118:	2e676e69 	cdpcs	14, 6, cr6, cr7, cr9, {3}
    111c:	00707063 	rsbseq	r7, r0, r3, rrx
    1120:	61345a5f 	teqvs	r4, pc, asr sl
    1124:	50696f74 	rsbpl	r6, r9, r4, ror pc
    1128:	4300634b 	movwmi	r6, #843	; 0x34b
    112c:	43726168 	cmnmi	r2, #104, 2
    1130:	41766e6f 	cmnmi	r6, pc, ror #28
    1134:	6d007272 	sfmvs	f7, 4, [r0, #-456]	; 0xfffffe38
    1138:	73646d65 	cmnvc	r4, #6464	; 0x1940
    113c:	756f0074 	strbvc	r0, [pc, #-116]!	; 10d0 <shift+0x10d0>
    1140:	74757074 	ldrbtvc	r7, [r5], #-116	; 0xffffff8c
    1144:	365a5f00 	ldrbcc	r5, [sl], -r0, lsl #30
    1148:	636d656d 	cmnvs	sp, #457179136	; 0x1b400000
    114c:	4b507970 	blmi	141f714 <__bss_end+0x1416778>
    1150:	69765076 	ldmdbvs	r6!, {r1, r2, r4, r5, r6, ip, lr}^
    1154:	73616200 	cmnvc	r1, #0, 4
    1158:	656d0065 	strbvs	r0, [sp, #-101]!	; 0xffffff9b
    115c:	7970636d 	ldmdbvc	r0!, {r0, r2, r3, r5, r6, r8, r9, sp, lr}^
    1160:	72747300 	rsbsvc	r7, r4, #0, 6
    1164:	006e656c 	rsbeq	r6, lr, ip, ror #10
    1168:	73375a5f 	teqvc	r7, #389120	; 0x5f000
    116c:	636e7274 	cmnvs	lr, #116, 4	; 0x40000007
    1170:	4b50706d 	blmi	141d32c <__bss_end+0x1414390>
    1174:	5f305363 	svcpl	0x00305363
    1178:	5a5f0069 	bpl	17c1324 <__bss_end+0x17b8388>
    117c:	72747336 	rsbsvc	r7, r4, #-671088640	; 0xd8000000
    1180:	506e656c 	rsbpl	r6, lr, ip, ror #10
    1184:	6100634b 	tstvs	r0, fp, asr #6
    1188:	00696f74 	rsbeq	r6, r9, r4, ror pc
    118c:	73375a5f 	teqvc	r7, #389120	; 0x5f000
    1190:	636e7274 	cmnvs	lr, #116, 4	; 0x40000007
    1194:	63507970 	cmpvs	r0, #112, 18	; 0x1c0000
    1198:	69634b50 	stmdbvs	r3!, {r4, r6, r8, r9, fp, lr}^
    119c:	72747300 	rsbsvc	r7, r4, #0, 6
    11a0:	706d636e 	rsbvc	r6, sp, lr, ror #6
    11a4:	72747300 	rsbsvc	r7, r4, #0, 6
    11a8:	7970636e 	ldmdbvc	r0!, {r1, r2, r3, r5, r6, r8, r9, sp, lr}^
    11ac:	6d656d00 	stclvs	13, cr6, [r5, #-0]
    11b0:	0079726f 	rsbseq	r7, r9, pc, ror #4
    11b4:	736d656d 	cmnvc	sp, #457179136	; 0x1b400000
    11b8:	69006372 	stmdbvs	r0, {r1, r4, r5, r6, r8, r9, sp, lr}
    11bc:	00616f74 	rsbeq	r6, r1, r4, ror pc
    11c0:	69345a5f 	ldmdbvs	r4!, {r0, r1, r2, r3, r4, r6, r9, fp, ip, lr}
    11c4:	6a616f74 	bvs	185cf9c <__bss_end+0x1854000>
    11c8:	006a6350 	rsbeq	r6, sl, r0, asr r3

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
  20:	8b040e42 	blhi	103930 <__bss_end+0xfa994>
  24:	0b0d4201 	bleq	350830 <__bss_end+0x347894>
  28:	420d0d62 	andmi	r0, sp, #6272	; 0x1880
  2c:	00000ecb 	andeq	r0, r0, fp, asr #29
  30:	0000001c 	andeq	r0, r0, ip, lsl r0
  34:	00000000 	andeq	r0, r0, r0
  38:	00008064 	andeq	r8, r0, r4, rrx
  3c:	00000040 	andeq	r0, r0, r0, asr #32
  40:	8b080e42 	blhi	203950 <__bss_end+0x1fa9b4>
  44:	42018e02 	andmi	r8, r1, #2, 28
  48:	5a040b0c 	bpl	102c80 <__bss_end+0xf9ce4>
  4c:	00080d0c 	andeq	r0, r8, ip, lsl #26
  50:	0000000c 	andeq	r0, r0, ip
  54:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
  58:	7c020001 	stcvc	0, cr0, [r2], {1}
  5c:	000d0c0e 	andeq	r0, sp, lr, lsl #24
  60:	0000001c 	andeq	r0, r0, ip, lsl r0
  64:	00000050 	andeq	r0, r0, r0, asr r0
  68:	000080a4 	andeq	r8, r0, r4, lsr #1
  6c:	00000038 	andeq	r0, r0, r8, lsr r0
  70:	8b040e42 	blhi	103980 <__bss_end+0xfa9e4>
  74:	0b0d4201 	bleq	350880 <__bss_end+0x3478e4>
  78:	420d0d54 	andmi	r0, sp, #84, 26	; 0x1500
  7c:	00000ecb 	andeq	r0, r0, fp, asr #29
  80:	0000001c 	andeq	r0, r0, ip, lsl r0
  84:	00000050 	andeq	r0, r0, r0, asr r0
  88:	000080dc 	ldrdeq	r8, [r0], -ip
  8c:	0000002c 	andeq	r0, r0, ip, lsr #32
  90:	8b040e42 	blhi	1039a0 <__bss_end+0xfaa04>
  94:	0b0d4201 	bleq	3508a0 <__bss_end+0x347904>
  98:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
  9c:	00000ecb 	andeq	r0, r0, fp, asr #29
  a0:	0000001c 	andeq	r0, r0, ip, lsl r0
  a4:	00000050 	andeq	r0, r0, r0, asr r0
  a8:	00008108 	andeq	r8, r0, r8, lsl #2
  ac:	00000020 	andeq	r0, r0, r0, lsr #32
  b0:	8b040e42 	blhi	1039c0 <__bss_end+0xfaa24>
  b4:	0b0d4201 	bleq	3508c0 <__bss_end+0x347924>
  b8:	420d0d48 	andmi	r0, sp, #72, 26	; 0x1200
  bc:	00000ecb 	andeq	r0, r0, fp, asr #29
  c0:	0000001c 	andeq	r0, r0, ip, lsl r0
  c4:	00000050 	andeq	r0, r0, r0, asr r0
  c8:	00008128 	andeq	r8, r0, r8, lsr #2
  cc:	00000018 	andeq	r0, r0, r8, lsl r0
  d0:	8b040e42 	blhi	1039e0 <__bss_end+0xfaa44>
  d4:	0b0d4201 	bleq	3508e0 <__bss_end+0x347944>
  d8:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
  dc:	00000ecb 	andeq	r0, r0, fp, asr #29
  e0:	0000001c 	andeq	r0, r0, ip, lsl r0
  e4:	00000050 	andeq	r0, r0, r0, asr r0
  e8:	00008140 	andeq	r8, r0, r0, asr #2
  ec:	00000018 	andeq	r0, r0, r8, lsl r0
  f0:	8b040e42 	blhi	103a00 <__bss_end+0xfaa64>
  f4:	0b0d4201 	bleq	350900 <__bss_end+0x347964>
  f8:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
  fc:	00000ecb 	andeq	r0, r0, fp, asr #29
 100:	0000001c 	andeq	r0, r0, ip, lsl r0
 104:	00000050 	andeq	r0, r0, r0, asr r0
 108:	00008158 	andeq	r8, r0, r8, asr r1
 10c:	00000018 	andeq	r0, r0, r8, lsl r0
 110:	8b040e42 	blhi	103a20 <__bss_end+0xfaa84>
 114:	0b0d4201 	bleq	350920 <__bss_end+0x347984>
 118:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
 11c:	00000ecb 	andeq	r0, r0, fp, asr #29
 120:	00000014 	andeq	r0, r0, r4, lsl r0
 124:	00000050 	andeq	r0, r0, r0, asr r0
 128:	00008170 	andeq	r8, r0, r0, ror r1
 12c:	0000000c 	andeq	r0, r0, ip
 130:	8b040e42 	blhi	103a40 <__bss_end+0xfaaa4>
 134:	0b0d4201 	bleq	350940 <__bss_end+0x3479a4>
 138:	0000001c 	andeq	r0, r0, ip, lsl r0
 13c:	00000050 	andeq	r0, r0, r0, asr r0
 140:	0000817c 	andeq	r8, r0, ip, ror r1
 144:	00000058 	andeq	r0, r0, r8, asr r0
 148:	8b080e42 	blhi	203a58 <__bss_end+0x1faabc>
 14c:	42018e02 	andmi	r8, r1, #2, 28
 150:	62040b0c 	andvs	r0, r4, #12, 22	; 0x3000
 154:	00080d0c 	andeq	r0, r8, ip, lsl #26
 158:	0000001c 	andeq	r0, r0, ip, lsl r0
 15c:	00000050 	andeq	r0, r0, r0, asr r0
 160:	000081d4 	ldrdeq	r8, [r0], -r4
 164:	00000058 	andeq	r0, r0, r8, asr r0
 168:	8b080e42 	blhi	203a78 <__bss_end+0x1faadc>
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
 194:	00000044 	andeq	r0, r0, r4, asr #32
 198:	840c0e42 	strhi	r0, [ip], #-3650	; 0xfffff1be
 19c:	8e028b03 	vmlahi.f64	d8, d2, d3
 1a0:	0b0c4201 	bleq	3109ac <__bss_end+0x307a10>
 1a4:	0d0c5a04 	vstreq	s10, [ip, #-16]
 1a8:	0000000c 	andeq	r0, r0, ip
 1ac:	0000001c 	andeq	r0, r0, ip, lsl r0
 1b0:	00000178 	andeq	r0, r0, r8, ror r1
 1b4:	00008270 	andeq	r8, r0, r0, ror r2
 1b8:	000000b8 	strheq	r0, [r0], -r8
 1bc:	8b080e42 	blhi	203acc <__bss_end+0x1fab30>
 1c0:	42018e02 	andmi	r8, r1, #2, 28
 1c4:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 1c8:	080d0c46 	stmdaeq	sp, {r1, r2, r6, sl, fp}
 1cc:	0000000c 	andeq	r0, r0, ip
 1d0:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 1d4:	7c020001 	stcvc	0, cr0, [r2], {1}
 1d8:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 1dc:	0000001c 	andeq	r0, r0, ip, lsl r0
 1e0:	000001cc 	andeq	r0, r0, ip, asr #3
 1e4:	00008328 	andeq	r8, r0, r8, lsr #6
 1e8:	0000002c 	andeq	r0, r0, ip, lsr #32
 1ec:	8b040e42 	blhi	103afc <__bss_end+0xfab60>
 1f0:	0b0d4201 	bleq	3509fc <__bss_end+0x347a60>
 1f4:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
 1f8:	00000ecb 	andeq	r0, r0, fp, asr #29
 1fc:	0000001c 	andeq	r0, r0, ip, lsl r0
 200:	000001cc 	andeq	r0, r0, ip, asr #3
 204:	00008354 	andeq	r8, r0, r4, asr r3
 208:	0000002c 	andeq	r0, r0, ip, lsr #32
 20c:	8b040e42 	blhi	103b1c <__bss_end+0xfab80>
 210:	0b0d4201 	bleq	350a1c <__bss_end+0x347a80>
 214:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
 218:	00000ecb 	andeq	r0, r0, fp, asr #29
 21c:	0000001c 	andeq	r0, r0, ip, lsl r0
 220:	000001cc 	andeq	r0, r0, ip, asr #3
 224:	00008380 	andeq	r8, r0, r0, lsl #7
 228:	0000001c 	andeq	r0, r0, ip, lsl r0
 22c:	8b040e42 	blhi	103b3c <__bss_end+0xfaba0>
 230:	0b0d4201 	bleq	350a3c <__bss_end+0x347aa0>
 234:	420d0d46 	andmi	r0, sp, #4480	; 0x1180
 238:	00000ecb 	andeq	r0, r0, fp, asr #29
 23c:	0000001c 	andeq	r0, r0, ip, lsl r0
 240:	000001cc 	andeq	r0, r0, ip, asr #3
 244:	0000839c 	muleq	r0, ip, r3
 248:	00000044 	andeq	r0, r0, r4, asr #32
 24c:	8b040e42 	blhi	103b5c <__bss_end+0xfabc0>
 250:	0b0d4201 	bleq	350a5c <__bss_end+0x347ac0>
 254:	420d0d5a 	andmi	r0, sp, #5760	; 0x1680
 258:	00000ecb 	andeq	r0, r0, fp, asr #29
 25c:	0000001c 	andeq	r0, r0, ip, lsl r0
 260:	000001cc 	andeq	r0, r0, ip, asr #3
 264:	000083e0 	andeq	r8, r0, r0, ror #7
 268:	00000050 	andeq	r0, r0, r0, asr r0
 26c:	8b040e42 	blhi	103b7c <__bss_end+0xfabe0>
 270:	0b0d4201 	bleq	350a7c <__bss_end+0x347ae0>
 274:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 278:	00000ecb 	andeq	r0, r0, fp, asr #29
 27c:	0000001c 	andeq	r0, r0, ip, lsl r0
 280:	000001cc 	andeq	r0, r0, ip, asr #3
 284:	00008430 	andeq	r8, r0, r0, lsr r4
 288:	00000050 	andeq	r0, r0, r0, asr r0
 28c:	8b040e42 	blhi	103b9c <__bss_end+0xfac00>
 290:	0b0d4201 	bleq	350a9c <__bss_end+0x347b00>
 294:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 298:	00000ecb 	andeq	r0, r0, fp, asr #29
 29c:	0000001c 	andeq	r0, r0, ip, lsl r0
 2a0:	000001cc 	andeq	r0, r0, ip, asr #3
 2a4:	00008480 	andeq	r8, r0, r0, lsl #9
 2a8:	0000002c 	andeq	r0, r0, ip, lsr #32
 2ac:	8b040e42 	blhi	103bbc <__bss_end+0xfac20>
 2b0:	0b0d4201 	bleq	350abc <__bss_end+0x347b20>
 2b4:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
 2b8:	00000ecb 	andeq	r0, r0, fp, asr #29
 2bc:	0000001c 	andeq	r0, r0, ip, lsl r0
 2c0:	000001cc 	andeq	r0, r0, ip, asr #3
 2c4:	000084ac 	andeq	r8, r0, ip, lsr #9
 2c8:	00000050 	andeq	r0, r0, r0, asr r0
 2cc:	8b040e42 	blhi	103bdc <__bss_end+0xfac40>
 2d0:	0b0d4201 	bleq	350adc <__bss_end+0x347b40>
 2d4:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 2d8:	00000ecb 	andeq	r0, r0, fp, asr #29
 2dc:	0000001c 	andeq	r0, r0, ip, lsl r0
 2e0:	000001cc 	andeq	r0, r0, ip, asr #3
 2e4:	000084fc 	strdeq	r8, [r0], -ip
 2e8:	00000044 	andeq	r0, r0, r4, asr #32
 2ec:	8b040e42 	blhi	103bfc <__bss_end+0xfac60>
 2f0:	0b0d4201 	bleq	350afc <__bss_end+0x347b60>
 2f4:	420d0d5a 	andmi	r0, sp, #5760	; 0x1680
 2f8:	00000ecb 	andeq	r0, r0, fp, asr #29
 2fc:	0000001c 	andeq	r0, r0, ip, lsl r0
 300:	000001cc 	andeq	r0, r0, ip, asr #3
 304:	00008540 	andeq	r8, r0, r0, asr #10
 308:	00000050 	andeq	r0, r0, r0, asr r0
 30c:	8b040e42 	blhi	103c1c <__bss_end+0xfac80>
 310:	0b0d4201 	bleq	350b1c <__bss_end+0x347b80>
 314:	420d0d60 	andmi	r0, sp, #96, 26	; 0x1800
 318:	00000ecb 	andeq	r0, r0, fp, asr #29
 31c:	0000001c 	andeq	r0, r0, ip, lsl r0
 320:	000001cc 	andeq	r0, r0, ip, asr #3
 324:	00008590 	muleq	r0, r0, r5
 328:	00000054 	andeq	r0, r0, r4, asr r0
 32c:	8b040e42 	blhi	103c3c <__bss_end+0xfaca0>
 330:	0b0d4201 	bleq	350b3c <__bss_end+0x347ba0>
 334:	420d0d62 	andmi	r0, sp, #6272	; 0x1880
 338:	00000ecb 	andeq	r0, r0, fp, asr #29
 33c:	0000001c 	andeq	r0, r0, ip, lsl r0
 340:	000001cc 	andeq	r0, r0, ip, asr #3
 344:	000085e4 	andeq	r8, r0, r4, ror #11
 348:	0000003c 	andeq	r0, r0, ip, lsr r0
 34c:	8b040e42 	blhi	103c5c <__bss_end+0xfacc0>
 350:	0b0d4201 	bleq	350b5c <__bss_end+0x347bc0>
 354:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 358:	00000ecb 	andeq	r0, r0, fp, asr #29
 35c:	0000001c 	andeq	r0, r0, ip, lsl r0
 360:	000001cc 	andeq	r0, r0, ip, asr #3
 364:	00008620 	andeq	r8, r0, r0, lsr #12
 368:	0000003c 	andeq	r0, r0, ip, lsr r0
 36c:	8b040e42 	blhi	103c7c <__bss_end+0xface0>
 370:	0b0d4201 	bleq	350b7c <__bss_end+0x347be0>
 374:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 378:	00000ecb 	andeq	r0, r0, fp, asr #29
 37c:	0000001c 	andeq	r0, r0, ip, lsl r0
 380:	000001cc 	andeq	r0, r0, ip, asr #3
 384:	0000865c 	andeq	r8, r0, ip, asr r6
 388:	0000003c 	andeq	r0, r0, ip, lsr r0
 38c:	8b040e42 	blhi	103c9c <__bss_end+0xfad00>
 390:	0b0d4201 	bleq	350b9c <__bss_end+0x347c00>
 394:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 398:	00000ecb 	andeq	r0, r0, fp, asr #29
 39c:	0000001c 	andeq	r0, r0, ip, lsl r0
 3a0:	000001cc 	andeq	r0, r0, ip, asr #3
 3a4:	00008698 	muleq	r0, r8, r6
 3a8:	0000003c 	andeq	r0, r0, ip, lsr r0
 3ac:	8b040e42 	blhi	103cbc <__bss_end+0xfad20>
 3b0:	0b0d4201 	bleq	350bbc <__bss_end+0x347c20>
 3b4:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 3b8:	00000ecb 	andeq	r0, r0, fp, asr #29
 3bc:	0000001c 	andeq	r0, r0, ip, lsl r0
 3c0:	000001cc 	andeq	r0, r0, ip, asr #3
 3c4:	000086d4 	ldrdeq	r8, [r0], -r4
 3c8:	000000b0 	strheq	r0, [r0], -r0	; <UNPREDICTABLE>
 3cc:	8b080e42 	blhi	203cdc <__bss_end+0x1fad40>
 3d0:	42018e02 	andmi	r8, r1, #2, 28
 3d4:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 3d8:	080d0c50 	stmdaeq	sp, {r4, r6, sl, fp}
 3dc:	0000000c 	andeq	r0, r0, ip
 3e0:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 3e4:	7c020001 	stcvc	0, cr0, [r2], {1}
 3e8:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 3ec:	0000001c 	andeq	r0, r0, ip, lsl r0
 3f0:	000003dc 	ldrdeq	r0, [r0], -ip
 3f4:	00008784 	andeq	r8, r0, r4, lsl #15
 3f8:	00000174 	andeq	r0, r0, r4, ror r1
 3fc:	8b080e42 	blhi	203d0c <__bss_end+0x1fad70>
 400:	42018e02 	andmi	r8, r1, #2, 28
 404:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 408:	080d0cb2 	stmdaeq	sp, {r1, r4, r5, r7, sl, fp}
 40c:	0000001c 	andeq	r0, r0, ip, lsl r0
 410:	000003dc 	ldrdeq	r0, [r0], -ip
 414:	000088f8 	strdeq	r8, [r0], -r8	; <UNPREDICTABLE>
 418:	0000009c 	muleq	r0, ip, r0
 41c:	8b040e42 	blhi	103d2c <__bss_end+0xfad90>
 420:	0b0d4201 	bleq	350c2c <__bss_end+0x347c90>
 424:	0d0d4602 	stceq	6, cr4, [sp, #-8]
 428:	000ecb42 	andeq	ip, lr, r2, asr #22
 42c:	0000001c 	andeq	r0, r0, ip, lsl r0
 430:	000003dc 	ldrdeq	r0, [r0], -ip
 434:	00008994 	muleq	r0, r4, r9
 438:	000000c0 	andeq	r0, r0, r0, asr #1
 43c:	8b040e42 	blhi	103d4c <__bss_end+0xfadb0>
 440:	0b0d4201 	bleq	350c4c <__bss_end+0x347cb0>
 444:	0d0d5802 	stceq	8, cr5, [sp, #-8]
 448:	000ecb42 	andeq	ip, lr, r2, asr #22
 44c:	0000001c 	andeq	r0, r0, ip, lsl r0
 450:	000003dc 	ldrdeq	r0, [r0], -ip
 454:	00008a54 	andeq	r8, r0, r4, asr sl
 458:	000000ac 	andeq	r0, r0, ip, lsr #1
 45c:	8b040e42 	blhi	103d6c <__bss_end+0xfadd0>
 460:	0b0d4201 	bleq	350c6c <__bss_end+0x347cd0>
 464:	0d0d4e02 	stceq	14, cr4, [sp, #-8]
 468:	000ecb42 	andeq	ip, lr, r2, asr #22
 46c:	0000001c 	andeq	r0, r0, ip, lsl r0
 470:	000003dc 	ldrdeq	r0, [r0], -ip
 474:	00008b00 	andeq	r8, r0, r0, lsl #22
 478:	00000054 	andeq	r0, r0, r4, asr r0
 47c:	8b040e42 	blhi	103d8c <__bss_end+0xfadf0>
 480:	0b0d4201 	bleq	350c8c <__bss_end+0x347cf0>
 484:	420d0d62 	andmi	r0, sp, #6272	; 0x1880
 488:	00000ecb 	andeq	r0, r0, fp, asr #29
 48c:	0000001c 	andeq	r0, r0, ip, lsl r0
 490:	000003dc 	ldrdeq	r0, [r0], -ip
 494:	00008b54 	andeq	r8, r0, r4, asr fp
 498:	00000068 	andeq	r0, r0, r8, rrx
 49c:	8b040e42 	blhi	103dac <__bss_end+0xfae10>
 4a0:	0b0d4201 	bleq	350cac <__bss_end+0x347d10>
 4a4:	420d0d6c 	andmi	r0, sp, #108, 26	; 0x1b00
 4a8:	00000ecb 	andeq	r0, r0, fp, asr #29
 4ac:	0000001c 	andeq	r0, r0, ip, lsl r0
 4b0:	000003dc 	ldrdeq	r0, [r0], -ip
 4b4:	00008bbc 			; <UNDEFINED> instruction: 0x00008bbc
 4b8:	00000080 	andeq	r0, r0, r0, lsl #1
 4bc:	8b040e42 	blhi	103dcc <__bss_end+0xfae30>
 4c0:	0b0d4201 	bleq	350ccc <__bss_end+0x347d30>
 4c4:	420d0d78 	andmi	r0, sp, #120, 26	; 0x1e00
 4c8:	00000ecb 	andeq	r0, r0, fp, asr #29
 4cc:	0000000c 	andeq	r0, r0, ip
 4d0:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 4d4:	7c010001 	stcvc	0, cr0, [r1], {1}
 4d8:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 4dc:	0000000c 	andeq	r0, r0, ip
 4e0:	000004cc 	andeq	r0, r0, ip, asr #9
 4e4:	00008c3c 	andeq	r8, r0, ip, lsr ip
 4e8:	000001ec 	andeq	r0, r0, ip, ror #3
