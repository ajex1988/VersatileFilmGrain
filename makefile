# Handmade makefile for film grain wrapper

obj/vfgs.so: obj/yuv.o obj/vfgs_hw.o obj/vfgs_fw.o obj/vfgs.o
	gcc -fPIC -shared -o obj/vfgs.so obj/yuv.o obj/vfgs_hw.o obj/vfgs_fw.o obj/vfgs.o
obj/vfgs.o: src/vfgs.c src/vfgs.h
	gcc -fPIC -c -o obj/vfgs.o src/vfgs.c
obj/vfgs_fw.o: src/vfgs_fw.h src/vfgs_fw.h
	gcc -fPIC -c -o obj/vfgs_fw.o src/vfgs_fw.c
obj/vfgs_hw.o: src/vfgs_hw.h src/vfgs_hw.c
	gcc -fPIC -c -o obj/vfgs_hw.o src/vfgs_hw.c
obj/yuv.o: src/yuv.h src/yuv.c
	gcc -fPIC -c -o obj/yuv.o src/yuv.c
