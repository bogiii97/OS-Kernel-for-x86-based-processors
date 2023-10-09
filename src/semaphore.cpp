#include "../h/semaphore.hpp"

int _sem::kwait(sem_t id){
    id->value--;
    if(id->value<0){
        id->SemaforQueue.addLast(_thread::running);
        _thread::setTimeSliceCounter();
        _thread::kdispatch(1);
    }
    if(id->sem_exists==0) return -1;
    else return 0;
}
int _sem::ksignal(sem_t id){
    id->value++;
    if(id->value<=0){
        _thread* t = id->SemaforQueue.removeFirst();
        if(t == nullptr) return -1;
        Scheduler::put(t);
    }
    return 0;
}

int _sem::ksem_open(sem_t *handle, unsigned init) {
    size_t sz = (sizeof(_sem)+sizeof(size_t))/MEM_BLOCK_SIZE + (((sizeof(_sem)+sizeof(size_t))%MEM_BLOCK_SIZE)==0?0:1);
    sem_t sem = (sem_t)(MemoryAllocator::kmem_alloc(sz));
    if(sem == nullptr) return -1;
    sem->SemaforQueue.head= nullptr;
    sem->SemaforQueue.tail= nullptr;
    sem->value = init;
    sem->sem_exists = 1;
    *handle = sem;
    return 0;
}

int _sem::ksem_close(sem_t handle) {
    _thread* t = handle->SemaforQueue.peekFirst();
    while(t != nullptr){
        Scheduler::put(t);
        handle->SemaforQueue.removeFirst();
        t = handle->SemaforQueue.peekFirst();
    }
    handle->sem_exists=0;
    return 0;
}