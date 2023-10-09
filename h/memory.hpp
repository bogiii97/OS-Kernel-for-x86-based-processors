#ifndef PROJECT_BASE_V1_0_MEMORY_HPP
#define PROJECT_BASE_V1_0_MEMORY_HPP

#include "../lib/hw.h"

class MemoryAllocator {
private:
    MemoryAllocator(const MemoryAllocator&) = delete;
    MemoryAllocator& operator=(const MemoryAllocator&) = delete;

    struct Elem {
        Elem* next = nullptr, *prev = nullptr;
        size_t numbersOfBlocks;
    };
    static Elem* head;


public:

    static void kinitMemory();
    static void* kmem_alloc(size_t num_of_blocks);
    static int kmem_free(void* mem);
};

#endif