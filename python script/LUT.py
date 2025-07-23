import math

LUT_DEPTH = 256
DATA_WIDTH = 8

max_val = (2**DATA_WIDTH) - 1
data_range = (2**DATA_WIDTH) / 2
addr_bits = math.ceil(math.log2(LUT_DEPTH))

print("always_comb begin")
print("    case (address)")

for i in range(LUT_DEPTH):
    angle = (i / LUT_DEPTH) * 2 * math.pi
    sine_val = math.sin(angle)
    scaled_val = int(sine_val * (data_range - 1) + data_range)

    if scaled_val > max_val: scaled_val = max_val
    if scaled_val < 0: scaled_val = 0
    
    print(f"        {addr_bits}'d{i}: sine_data = {DATA_WIDTH}'d{scaled_val};")

print(f"        default: sine_data = {DATA_WIDTH}'d{int(data_range)};")
print(f"    endcase")
print(f"end")
