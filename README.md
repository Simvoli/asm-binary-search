# Binary Search in x86 Assembly (8086)

Binary search algorithm implemented in x86 assembly for the 8086 processor using Turbo Assembler (TASM) IDEAL mode syntax.

## Overview

The program performs binary search on a sorted array of signed bytes (`db`). The search uses tail recursion (`jmp` instead of `call`), which avoids stack growth on each iteration.

### Features

- Signed number support (uses `jl` for comparison)
- Tail recursion — safe for large arrays
- Parameters passed via stack
- Returns the index of the found element, or `0FFh` if not found

## Build & Run

Requires [Turbo Assembler (TASM)](https://en.wikipedia.org/wiki/Turbo_Assembler) and [Turbo Linker (TLINK)](https://en.wikipedia.org/wiki/Turbo_Assembler):

```bash
tasm binsearch.asm
tlink binsearch.obj
binsearch.exe
```

You can use [DOSBox](https://www.dosbox.com/) or any compatible DOS emulator to run the program.

## Structure

```
.
├── binsearch.asm    # Source code
├── LICENSE
└── README.md
```

## Procedure Interface

```
BinarySearchH(num_to_search, result_ptr, array_offset, length)
```

Parameters are passed via the stack (from last `push` to first):

| Parameter | Size | Description |
|---|---|---|
| `num_to_search` | word | Value to search for |
| `result_ptr` | word | Pointer to the result variable |
| `array_offset` | word | Offset of the array |
| `length` | word | Number of elements |

## Example

```asm
array db -3, -1, 0, 2, 5
len   dw 5
result dw ?

push [len]
push offset array
push offset result
push 2                  ; search for 2
call BinarySearchH
; result = 3 (index of element 2 in the array)
```
