.extern _ZN5Riscv20handleSupervisorTrapEv #to je nekakav spoljasnji simbol koji pozivamo

.align 4  #po strukturi stvec registra imamo da posl dva bita odredjuju mod rada, a za 00 u posl dva bita imamo da se prosledjena adresa za prekidnu rutinu upisuje u pc bez promene
.global _ZN5Riscv14supervisorTrapEv #ovaj simbol je globalan, da bi ova definicija bila vidljiva za deklaraciju u klasi Riscv
.type _ZN5Riscv14supervisorTrapEv, @function  #tip ovog simbola je funkcija
_ZN5Riscv14supervisorTrapEv:

    # push all registers to stack
        addi sp, sp, -256
        csrw sscratch, sp
        .irp index, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
        sd x\index, \index * 8(sp)
        .endr

        call _ZN5Riscv20handleSupervisorTrapEv

        # pop all registers from stack
        .irp index, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
        ld x\index, \index * 8(sp)
        .endr
        addi sp, sp, 256


    sret #iz sstatus se uzima info u kom rezimu rada je bio sistem pre ulaska u prekidnu rutinu, i sret instrukcijom se vracamo u taj rezim rada,
         # gleda se da li su prekidi bili omoguceni ili ne, i zatim se vracamo na onu adresu odakle smo usli u prekidnu rutinu tj na narednu, to se cuva u sepc
