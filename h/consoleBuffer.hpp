#ifndef PROJECT_BASE_V1_0_CONSOLEBUFFER_HPP
#define PROJECT_BASE_V1_0_CONSOLEBUFFER_HPP
#include "../h/memory.hpp"
#include "../h/semaphore.hpp"

class ConsoleBuffer{
protected:
    int cap;
    char *buffer;
    int head, tail;

    _sem* spaceAvailable;
    _sem* itemAvailable;
    _sem* mutexHead;
    _sem* mutexTail;

public:

    ConsoleBuffer(int _cap);

    virtual ~ConsoleBuffer();

    virtual void put(char val);
    virtual int get();

    int getCnt();


    void* operator new(size_t sz){
        sz = (sz + sizeof(size_t))/MEM_BLOCK_SIZE + (((sz + sizeof(size_t))%MEM_BLOCK_SIZE)==0?0:1);
        return MemoryAllocator::kmem_alloc(sz);
    }

    void operator delete(void* arg){
        MemoryAllocator::kmem_free(arg);
    }



};

#endif