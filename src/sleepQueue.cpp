#include "../h/sleepQueue.hpp"

sleepQueue::Elem *sleepQueue::head = nullptr;
sleepQueue::Elem *sleepQueue::tail = nullptr;


void sleepQueue::put(_thread*t){
    size_t sz = (sizeof(Elem)+sizeof(size_t))/MEM_BLOCK_SIZE + (((sizeof(Elem)+sizeof(size_t))%MEM_BLOCK_SIZE)==0?0:1);
    Elem* novi =(Elem*) MemoryAllocator::kmem_alloc(sz);
    novi->thread = t; novi->next = nullptr;
    if (tail) {
        tail->next = novi;
        tail = novi;
    }
    else
        head = tail = novi;
}

void sleepQueue::iterate() {
    Elem* q = nullptr, *p = head, *old = nullptr;
    while(p){
        p->thread->decTimeToSleep();
        uint64 time = p->thread->getTimeToSleep();
        if(time == 0){
            old = p;
            Scheduler::put(p->thread);
            if(q == nullptr){
                head = p->next;
                if(head == nullptr) {tail = nullptr; MemoryAllocator::kmem_free(old); break;}
                else {p = head;}
            }
            else{
                q->next = p->next;
                if(q->next == nullptr) tail = q;
                p = p->next;
            }
            MemoryAllocator::kmem_free(old);
        }
        else {
            q = p;
            p = p->next;
        }
    }
}