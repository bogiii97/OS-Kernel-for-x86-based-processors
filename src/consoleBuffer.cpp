#include "../h/consoleBuffer.hpp"


ConsoleBuffer::ConsoleBuffer(int _cap) : cap(_cap + 1), head(0), tail(0) {
    size_t sz = (sizeof(char)*cap + sizeof(size_t))/MEM_BLOCK_SIZE + (((sizeof(char)*cap + sizeof(size_t))%MEM_BLOCK_SIZE)==0?0:1);
    buffer = (char *)MemoryAllocator::kmem_alloc(sz);
    _sem::ksem_open(&itemAvailable,0);
    _sem::ksem_open(&spaceAvailable,_cap);
    _sem::ksem_open(&mutexHead, 1);
    _sem::ksem_open(&mutexTail, 1);
}

ConsoleBuffer::~ConsoleBuffer() {
    MemoryAllocator::kmem_free(buffer);
    _sem::ksem_close(itemAvailable);
    _sem::ksem_close(spaceAvailable);
    _sem::ksem_close(mutexTail);
    _sem::ksem_close(mutexHead);


}

void ConsoleBuffer::put(char val) {
    _sem::kwait(spaceAvailable);

    _sem::kwait(mutexTail);
    buffer[tail] = val;
    tail = (tail + 1) % cap;
    _sem::ksignal(mutexTail);

    _sem::ksignal(itemAvailable);

}

int ConsoleBuffer::get() {
    _sem::kwait(itemAvailable);

    _sem::kwait(mutexHead);

    int ret = buffer[head];
    head = (head + 1) % cap;
    _sem::ksignal(mutexHead);

    _sem::ksignal(spaceAvailable);

    return ret;
}

int ConsoleBuffer::getCnt() {
    int ret;

    _sem::kwait(mutexHead);
    _sem::kwait(mutexTail);


    if (tail >= head) {
        ret = tail - head;
    } else {
        ret = cap - head + tail;
    }

    _sem::ksignal(mutexTail);
    _sem::ksignal(mutexHead);

    return ret;
}