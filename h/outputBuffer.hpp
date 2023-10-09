#include "consoleBuffer.hpp"


class OutputBuffer : public ConsoleBuffer{
private:
    int num;
public:
    OutputBuffer(int cap) : ConsoleBuffer(cap) {}

    ~OutputBuffer(){
        kernelMode();
        Riscv::mc_sstatus(Riscv::SSTATUS_SSIE);
        while((*((char*)CONSOLE_STATUS)&CONSOLE_TX_STATUS_BIT)){
            int val = OutputBuffer::outputBuffer->get();
            if(val == 0) break;
            *((char*)CONSOLE_TX_DATA) = val;
        }
        Riscv::ms_sstatus(Riscv::SSTATUS_SSIE);
        userMode();
    }

    static OutputBuffer* outputBuffer;
    static void createOutputBuffer();
    static void deleteOutputBuffer();

    int get() override;

    void* operator new(size_t sz){
        sz = (sz + sizeof(size_t))/MEM_BLOCK_SIZE + (((sz + sizeof(size_t))%MEM_BLOCK_SIZE)==0?0:1);
        return MemoryAllocator::kmem_alloc(sz);
    }

    void operator delete(void* arg){
        MemoryAllocator::kmem_free(arg);
    }
};