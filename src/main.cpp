#include "../h/memory.hpp"
#include "../h/riscV.hpp"
#include "../h/syscall_c.hpp"
#include "../h/printing.hpp"
#include "../h/thread.hpp"
#include "../h/inputBuffer.hpp"
#include "../h/outputBuffer.hpp"

//#include "../h/Threads_C_API_test.hpp" // zadatak 2, niti C API i sinhrona promena konteksta
//#include "../h/Threads_CPP_API_test.hpp" // zadatak 2., niti CPP API i sinhrona promena konteksta

//#include "../h/ConsumerProducer_C_API_test.hpp" // zadatak 3., kompletan C API sa semaforima, sinhrona promena konteksta
//#include "../h/ConsumerProducer_CPP_Sync_API_test.hpp" // zadatak 3., kompletan CPP API sa semaforima, sinhrona promena konteksta

//#include "../h/ThreadSleep_C_API_test.hpp" // thread_sleep test C API
//#include "../h/ConsumerProducer_CPP_API_test.hpp" // zadatak 4. CPP API i asinhrona promena konteksta


void idleFunction(void* arg){
    while(true){
        thread_dispatch();
    }
}

thread_t idle;
thread_t consoleThread;
thread_t mainThread;

void kernelInit(){
    MemoryAllocator::kinitMemory();
    Riscv::w_stvec((uint64) &Riscv::supervisorTrap);

    InputBuffer::createInputBuffer();
    OutputBuffer::createOutputBuffer();

    thread_create(&mainThread, nullptr, nullptr);
    _thread::running = mainThread;

    thread_create(&idle, idleFunction, nullptr);

    thread_create(&consoleThread, Riscv::consoleFunc, nullptr); //fja,globalna ili u riscv, uzimanje iz output bufera dok ima nesto i stavljam u registar

    Riscv::ms_sstatus(Riscv::SSTATUS_SSIE);

}

void dealocate(){
    InputBuffer::deleteInputBuffer();
    OutputBuffer::deleteOutputBuffer();
    delete idle;
    delete consoleThread;
    delete mainThread;
}

void userMain() {

    //Threads_C_API_test(); // zadatak 2., niti C API i sinhrona promena konteksta
    //Threads_CPP_API_test(); // zadatak 2., niti CPP API i sinhrona promena konteksta

    //producerConsumer_C_API(); // zadatak 3., kompletan C API sa semaforima, sinhrona promena konteksta
    //producerConsumer_CPP_Sync_API(); // zadatak 3., kompletan CPP API sa semaforima, sinhrona promena konteksta

    //testSleeping(); // thread_sleep test C API
    //ConsumerProducerCPP::testConsumerProducer(); // zadatak 4. CPP API i asinhrona promena konteksta, kompletan test svega

}

void main() {
    kernelInit();
    userMode();
    userMain();
    kernelMode();
    dealocate();
}