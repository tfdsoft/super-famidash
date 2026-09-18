
CA65ARGS = --cpu 65816 --smart

make:	
	mkdir -p TMP
	ca65 src/main.s $(CA65ARGS) -o TMP/bruh.o -g
	ca65 src/sniperengine/sniperengine.s $(CA65ARGS) -o TMP/sniperengine.o -g

	mkdir -p OUT
	ld65 TMP/*.o -C hirom.cfg -o OUT/test.sfc --dbgfile OUT/test.dbg

clean:
