
make:	
	mkdir -p TMP
	ca65 src/main.s --cpu 65816 -o TMP/bruh.o -g

	mkdir -p OUT
	ld65 TMP/bruh.o -C hirom.cfg -o OUT/test.sfc

clean:
