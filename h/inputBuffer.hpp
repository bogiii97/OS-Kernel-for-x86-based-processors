#include "consoleBuffer.hpp"


class InputBuffer : public ConsoleBuffer{
private:
    int num;
public:
    InputBuffer(int cap) : ConsoleBuffer(cap) {}

    static InputBuffer* inputBuffer;
    static void createInputBuffer();
    static void deleteInputBuffer();

    void put(char val) override;
    int get() override;

    void* operator new(size_t sz){
        sz = (sz + sizeof(size_t))/MEM_BLOCK_SIZE + (((sz + sizeof(size_t))%MEM_BLOCK_SIZE)==0?0:1);
        return MemoryAllocator::kmem_alloc(sz);
    }

    void operator delete(void* arg){
        MemoryAllocator::kmem_free(arg);
    }
};