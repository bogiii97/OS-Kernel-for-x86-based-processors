#ifndef PROJECT_BASE_V1_0_RISCV_HPP
#define PROJECT_BASE_V1_0_RISCV_HPP
#include "../lib/hw.h"

class Riscv {
public:

    static void popSppSpie();

    static void consoleFunc(void*);


    static uint64 r_scause();
    static void w_scause(uint64 scause);

    static uint64 r_sepc();
    static void w_sepc(uint64 sepc);

    static uint64 r_stvec();
    static void w_stvec(uint64 stvec);

    static uint64 r_stval();
    static void w_stval(uint64 stval);

    enum BitMaskSip {
        SIP_SSIE = (1 << 1),
        SIP_STIE = (1 << 5),
        SIP_SEIE = (1 << 9),
    };

    static void ms_sip(uint64 mask);

    static void mc_sip(uint64 mask);

    static void mc_sie(uint64 mask);
    static void ms_sie(uint64 mask);
    enum BitMaskSie{
        SIE_SSIE = (1 << 1),
    };

    static uint64 r_sip();
    static void w_sip(uint64 sip);

    enum BitMaskSstatus {
        SSTATUS_SSIE = (1 << 1),
        SSTATUS_STIE = (1 << 5),
        SSTATUS_SEIE = (1 << 8),
    };

    static void ms_sstatus(uint64 mask);

    static void mc_sstatus(uint64 mask);

    static uint64 r_sstatus();
    static void w_sstatus(uint64 sstatus);


    static void sysCall(uint64, void*, void*, void*, void*);
    static void supervisorTrap();


private:
    static void handleSupervisorTrap();
};


inline uint64 Riscv::r_scause() {
    uint64 volatile scause;
    __asm__ volatile("csrr %[scause], scause" : [scause] "=r"(scause));
    return scause;
}

inline void Riscv::w_scause(uint64 scause) {
    __asm__ volatile("csrw scause, %[scause]" : : [scause] "r"(scause));
}

inline uint64 Riscv::r_sepc() {
    uint64 volatile sepc;
    __asm__ volatile("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    return sepc;
}

inline void Riscv::w_sepc(uint64 sepc) {
    __asm__ volatile("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
}

inline uint64 Riscv::r_stvec() {
    uint64 volatile stvec;
    __asm__ volatile("csrr %[stvec], stvec" : [stvec] "=r"(stvec));
    return stvec;
}

inline void Riscv::w_stvec(uint64 stvec) {
    __asm__ volatile("csrw stvec, %[stvec]" : : [stvec] "r"(stvec));
}

inline uint64 Riscv::r_stval() {
    uint64 volatile stval;
    __asm__ volatile("csrr %[stval], stval": [stval] "=r"(stval));
    return stval;
}

inline void Riscv::w_stval(uint64 stval) {
    __asm__ volatile("csrw stval, %[stval]" : : [stval] "r"(stval));
}

inline uint64 Riscv::r_sip() {
    uint64 volatile sip;
    __asm__ volatile("csrr %[sip], sip": [sip] "=r"(sip));
    return sip;
}

inline void Riscv::w_sip(uint64 sip) {
    __asm__ volatile("csrw sip, %[sip]" : : [sip] "r"(sip));
}

inline uint64 Riscv::r_sstatus() {
    uint64 volatile sstatus;
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    return sstatus;
}

inline void Riscv::w_sstatus(uint64 sstatus) {
    __asm__ volatile("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
}

inline void Riscv::ms_sstatus(uint64 mask) {
    __asm__ volatile("csrs sstatus, %[mask]" : : [mask] "r"(mask));
}

inline void Riscv::mc_sstatus(uint64 mask) {
    __asm__ volatile("csrc sstatus, %[mask]" : : [mask] "r"(mask));
}

inline void Riscv::ms_sie(uint64 mask) {
    __asm__ volatile("csrs sie, %[mask]" : : [mask] "r"(mask));
}

inline void Riscv::mc_sie(uint64 mask) {
    __asm__ volatile("csrc sie, %[mask]" : : [mask] "r"(mask));
}

inline void Riscv::ms_sip(uint64 mask) {
    __asm__ volatile("csrs sip, %[mask]" : : [mask] "r"(mask));
}

inline void Riscv::mc_sip(uint64 mask) {
    __asm__ volatile("csrc sip, %[mask]" : : [mask] "r"(mask));
}

#endif