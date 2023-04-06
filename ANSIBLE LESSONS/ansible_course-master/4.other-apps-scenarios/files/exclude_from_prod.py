#!/usr/bin/env python3
from random import randrange

res = randrange(10)  # здесь мы эмулируем ненадежный скрипт, проваливаем вызов с какой то веряотностью
if randrange(10) > 6:
    print("success")
else:
    print("failure") # бывают в нашей работе скрипты, которые просто пишут "удалось/не удалось" без всяких там кодов выхода