#!/bin/bash
clang -march=native -O2 -funroll-loops -Wall -Wextra h4m_audio_decode.c -o h4m -DNATIVE=1
