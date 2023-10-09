#include "../h/riscV.hpp"
#include "../h/memory.hpp"
#include "../h/thread.hpp"
#include "../h/semaphore.hpp"
#include "../h/syscall_c.hpp"
#include "../h/sleepQueue.hpp"
#include "../h/inputBuffer.hpp"
#include "../h/outputBuffer.hpp"
#include "../lib/hw.h"

void Riscv::popSppSpie(){
    __asm__ volatile("csrw sepc, ra");
    __asm__ volatile("sret");
}

void Riscv::consoleFunc(void *arg) {
    while(true){
        kernelMode();
        Riscv::mc_sstatus(Riscv::SSTATUS_SSIE);
        while((*((char*)CONSOLE_STATUS)&CONSOLE_TX_STATUS_BIT)){
            int val = OutputBuffer::outputBuffer->get();
            if(val == 0) break;
            *((char*)CONSOLE_TX_DATA) = val;
        }
        Riscv::ms_sstatus(Riscv::SSTATUS_SSIE);
        userMode();
        thread_dispatch();
    }
}


void Riscv::handleSupervisorTrap() {
    void* volatile arg0 = nullptr, *volatile arg1 = nullptr, *volatile arg2 = nullptr, *volatile arg3 = nullptr,
            *volatile arg4 = nullptr, *volatile arg5 = nullptr, *volatile arg6 = nullptr;
    uint64 volatile a0 = 0;
    __asm__ volatile ("mv %[a0], a0" : [a0] "=r"(a0));
    __asm__ volatile ("mv %[arg6], a7" : [arg6] "=r"(arg6));
    __asm__ volatile ("mv %[arg5], a6" : [arg5] "=r"(arg5));
    __asm__ volatile ("mv %[arg4], a5" : [arg4] "=r"(arg4));
    __asm__ volatile ("mv %[arg3], a4" : [arg3] "=r"(arg3));
    __asm__ volatile ("mv %[arg2], a3" : [arg2] "=r"(arg2));
    __asm__ volatile ("mv %[arg1], a2" : [arg1] "=r"(arg1));
    __asm__ volatile ("mv %[arg0], a1" : [arg0] "=r"(arg0));

    uint64 scause = Riscv::r_scause();
    if (scause == 0x0000000000000009UL || scause == 0x0000000000000008UL)
    {
        long volatile sepc = Riscv::r_sepc() + 4;
        long volatile sstatus = Riscv::r_sstatus();

        uint64 resVal;
        __asm__ volatile("csrr %0, sscratch": "=r"(resVal));

        switch(a0) {
            case 0x01:
                MemoryAllocator::kmem_alloc(*(uint64*)arg0);
                break;
            case 0x02:
                MemoryAllocator::kmem_free(arg0);
                break;
            case 0x11:
                _thread::createThread((thread_t*)arg0, (void (*)(void*))arg1, arg2, (uint64*)arg3,1);
                break;
            case 0x12:
                _thread::running->setFinished(true);
                _thread::setTimeSliceCounter();
                _thread::kdispatch(0);
                break;
            case 0x13:
                _thread::setTimeSliceCounter();
                _thread::kdispatch(0);
                break;
            case 0x14:
                _thread::createThread((thread_t*)arg0, (void (*)(void*))arg1, arg2, (uint64*)arg3,0);
                break;
            case 0x15:
                _thread::addToScheduler((thread_t)arg0);
                break;
            case 0x21:
                _sem::ksem_open((sem_t*)arg0, *(uint64*)arg1);
                break;
            case 0x22:
                _sem::ksem_close((sem_t)arg0);
                break;
            case 0x23:
                _sem::kwait((sem_t)arg0);
                break;
            case 0x24:
                _sem::ksignal((sem_t)arg0);
                break;
            case 0x31:
                _thread::sleep(*(time_t*)arg0);
                break;
            case 0x41:
                InputBuffer::inputBuffer->get();
                break;
            case 0x42:
                OutputBuffer::outputBuffer->put(*(char*)arg0);
                break;
            case 0x50:
                mc_sstatus(0x100);
                break;
            case 0x51:
                ms_sstatus(0x100);
                break;
            default:
                break;
        }

        __asm__ volatile("sd a0, 80(%0)": : "r" (resVal));

        if(a0!= 0x50 && a0 != 0x51){
            Riscv::w_sstatus(sstatus);
        }
        Riscv::w_sepc(sepc);
    } else if (scause == 0x8000000000000001UL) {
        mc_sip(SIP_SSIE);
        sleepQueue::iterate();
        _thread::timeSliceCounter++;
        if (_thread::timeSliceCounter >= _thread::running->getTimeSlice()) {
            uint64 volatile sepc = r_sepc();
            uint64 volatile sstatus = r_sstatus();
            _thread::timeSliceCounter = 0;
            _thread::kdispatch(0);
            w_sstatus(sstatus);
            w_sepc(sepc);
        }
    } else if (scause == 0x8000000000000009UL) {
        int id = plic_claim();
        int max_loaded = 100;
        while((*((char*)CONSOLE_STATUS)&CONSOLE_RX_STATUS_BIT) && max_loaded>0){
            char val = *((char*)CONSOLE_RX_DATA);
            InputBuffer::inputBuffer->put(val);
            max_loaded--;
        }
        plic_complete(id);

    } else {
        // unexpected trap cause
    }

}

void Riscv::sysCall(uint64 code, void* arg1, void* arg2, void* arg3, void* arg4) {
    __asm__ volatile("ecall");
}
