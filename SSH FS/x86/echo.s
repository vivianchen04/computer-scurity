  ; .section .rodata

; hello:
;   # Constant holding the message string to print.
;   .ascii "Hello World\n"

error_message:
  .ascii "This command expects exactly one argument.\n"

newline:
  .ascii "\n"
  .section .text
  .globl _start

# eax: system call 
# ebx: first argument: fd
# ecx: second arugment: string
# edx: third arguemnt: length of the string

_start:
# error situation argument != 2

  ## Print message to standard output.
  movl  0(%esp), %eax
  cmpl  $2, %eax
  jne    error_argument
  
  movl  $0, %eax	
  movl  8(%esp), %ecx	

.loop:
  movb  (%ecx,%eax,1), %dh
  cmpb  $0, %dh
  je    null_terminate	
  incl  %eax
  jmp   .loop


null_terminate: 
  movl  %eax, %edx
  	
  movl  $4, %eax
  # Select the 'sys_write' syscall.
  # ===============================
  # The value in %eax determines which syscall the kernel will execute when
  # interrupt 0x80 is triggered by our code.

  movl  $1, %ebx
  # Set the output to file descriptor #1 (standard output).
  # =======================================================
  # The value in %ebx is the first argument to the syscall. In the case of
  # sys_write, that first argument is the file descriptor (fd) number to which
  # the string should be written.

  movl 8(%esp), %ecx
  # Set the target string to our message.
  # =====================================
  # The value in %ecx is the second argument to the syscall. In the case of
  # sys_write, that second argument is the address in memory of the string to
  # print. Since we defined 'hello' as our message string constant in the
  # .rodata section above, this will place its address in memory into %ecx.
  
  int   $0x80
  # Invoke the syscall and print the message string.
  # ===================
  # This triggers interrupt number 0x80, which the Linux kernel intercepts to
  # run the syscall we select in the %eax register, using the %ebx-%edx
  # registers as its arguments.

  # EAX EBX ECX EDX

  ## Exit the program with code 0.
  movl  $4, %eax
  movl  $1, %ebx
  movl  $newline, %ecx
  movl  $1, %edx
  int   $0x80

  movl  $1, %eax
  movl  $0, %ebx
  int   $0x80

error_argument: 
  movl  %eax, %edx	
  movl  $4, %eax	
  movl  $2, %ebx	
  movl  $error_message, %ecx	
  movl  $43, %edx
  int   $0x80	

  # exit with code 1
  movl  $1, %eax	
  movl  $1, %ebx	
  int   $0x80  