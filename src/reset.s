.segment "INIT" ; you get 4kb in this section, make it count

    reset:
        jml @goto_fastrom

    @goto_fastrom:
        ; switch to native mode
        sei 
        clc 
        xce 

        ; go to wherever main is
        jml main
