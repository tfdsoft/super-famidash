
CA65ARGS = --cpu 65816 --smart

make:	
	mkdir -p TMP
	ca65 src/main.s $(CA65ARGS) -o TMP/the_game.o -g
	ca65 src/sniperengine/sniperengine.s $(CA65ARGS) -o TMP/sniperengine.o -g

	mkdir -p OUT
	ld65 TMP/*.o -C exhirom.cfg -o OUT/test.sfc --dbgfile OUT/test.dbg

clean:
