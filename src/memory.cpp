#include "../h/memory.hpp"

MemoryAllocator::Elem* MemoryAllocator::head = nullptr;

void MemoryAllocator::kinitMemory() {
    head = (Elem*)HEAP_START_ADDR;
    head->next = head->prev = nullptr;
    head->numbersOfBlocks = ((char*)HEAP_END_ADDR - (char*)HEAP_START_ADDR - sizeof(size_t)) / MEM_BLOCK_SIZE + (((((char*)HEAP_END_ADDR - (char*)HEAP_START_ADDR - sizeof(size_t))%MEM_BLOCK_SIZE)==0)?0:1);
}
void* MemoryAllocator::kmem_alloc(size_t numOfBlocks) {
    Elem* blockToAllocate = nullptr;
    size_t minimum = 0;
    Elem* curr = head;
    while (curr) {
        if (curr->numbersOfBlocks >= numOfBlocks) {
            if (curr->numbersOfBlocks - numOfBlocks < minimum || !blockToAllocate) {
                blockToAllocate = curr;
                minimum = curr->numbersOfBlocks - numOfBlocks;
            }
        }
        curr = curr->next;
    }
    if (!blockToAllocate) return nullptr;
    size_t remaining = blockToAllocate->numbersOfBlocks - numOfBlocks;
    if (remaining == 0) {
        Elem* q = blockToAllocate->prev;
        if (q) {
            q->next = blockToAllocate->next;
            if (blockToAllocate->next) {
                blockToAllocate->next->prev = q;
            }
        }
        else{
            head = blockToAllocate->next;
            if(head)
                blockToAllocate->next->prev = nullptr;
        }
    }
    else {
        Elem* newBlock = (Elem*)((char*)blockToAllocate + numOfBlocks * MEM_BLOCK_SIZE);
        newBlock->prev = blockToAllocate->prev;
        newBlock->next = blockToAllocate->next;
        if (blockToAllocate->prev)
            blockToAllocate->prev->next = newBlock;
        else
            head = newBlock;
        if (blockToAllocate->next)
            blockToAllocate->next->prev = newBlock;
        newBlock->numbersOfBlocks = remaining;
    }
    //blockToAllocate->next = blockToAllocate->prev = nullptr;
    size_t* blocks = (size_t*)(blockToAllocate);
    *blocks = numOfBlocks;
    return (char*)blockToAllocate + sizeof(size_t);
}

int MemoryAllocator::kmem_free(void* addr) {
    size_t allocatedPartSize = *(size_t*)((char*)addr - sizeof(size_t));
    char* allocatedPart = (char*)addr - sizeof(size_t); //allocated_part ukazuje na pocetak bloka, dok smo velicinu alociranog dela u blokovima sacuvali u prethodnom redu

    //pronalazimo cvor koji se nalazi neposredno pre nase adresu koju zelimo osloboditi
    Elem* curr = nullptr;
    if (!head || allocatedPart < (char*)head) {} //ukoliko je lista slobodnih clanova prazna ili je adresa alociranog dela pre glave liste slobodnih blokova
    else {
        for (curr = head; curr->next != nullptr && allocatedPart > (char*)curr->next; curr = curr->next);
    }

    //pokusaj spajanja sa prethodnim slobodnim segmentom
    if (curr && (char*)curr + curr->numbersOfBlocks * MEM_BLOCK_SIZE == allocatedPart) {
        curr->numbersOfBlocks += allocatedPartSize;
        if (curr->next && (char*)curr + curr->numbersOfBlocks * MEM_BLOCK_SIZE == (char*)curr->next) {
            curr->numbersOfBlocks += curr->next->numbersOfBlocks;
            curr->next = curr->next->next;
            if (curr->next) curr->next->prev = curr;
        }
        return 0;
    }

    //pokusaj spajanja sa narednim blokom
    Elem* nextBlock = curr ? curr->next : head;
    if (nextBlock && allocatedPart + allocatedPartSize * MEM_BLOCK_SIZE == (char*)nextBlock) {
        Elem* newBlock = (Elem*)allocatedPart;
        newBlock->numbersOfBlocks = nextBlock->numbersOfBlocks + allocatedPartSize;
        newBlock->prev = nextBlock->prev;
        newBlock->next = nextBlock->next;
        if (nextBlock->next) nextBlock->next->prev = newBlock;
        if (nextBlock->prev) nextBlock->prev->next = newBlock;
        else head = newBlock;
        return 0;
    }

    // nema mogucnosti za spajanje, ulancavamo samo slobodan fragment sa curr i njegovim sledbenikom ako postoje
    Elem* newBlock =(Elem*)allocatedPart;
    newBlock->numbersOfBlocks = allocatedPartSize;
    newBlock->prev = curr;
    if (curr) newBlock->next = curr->next;
    else newBlock->next = head;
    if (newBlock->next) newBlock->next->prev = newBlock;
    if (curr) curr->next = newBlock;
    else head = newBlock;
    return 0;
}