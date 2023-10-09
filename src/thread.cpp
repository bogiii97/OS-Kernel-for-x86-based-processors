#include "../h/thread.hpp"
_thread *_thread::running = nullptr;
uint64 _thread::timeSliceCounter = 0;

int _thread::sleep(time_t time) {
    if(time == 0) return 0;
    _thread::running->timeToSleep = time;
    sleepQueue::put(_thread::running);
    timeSliceCounter = 0;
    kdispatch(1);
    return 0;
}

int _thread::createThread(thread_t* handle, Body body, void*arg, uint64*stek, int flag) {
    size_t sz = (sizeof(_thread)+sizeof(size_t))/MEM_BLOCK_SIZE + (((sizeof(_thread)+sizeof(size_t))%MEM_BLOCK_SIZE)==0?0:1);
    thread_t thread = (thread_t)(MemoryAllocator::kmem_alloc(sz));
    thread->body = body;
    thread->arg = arg;
    thread->timeSlice = DEFAULT_TIME_SLICE;
    thread->finished = false;
    thread->timeToSleep = 0;
    if (thread->body !=nullptr) {
        thread->context.ra = (uint64) &threadWrapper;
        thread->stack = stek;
        thread->context.sp = (uint64) &thread->stack[DEFAULT_STACK_SIZE];
        if(flag) Scheduler::put(thread);
    }
    else {
        thread->context.ra = 0;
        thread->context.sp = 0;
        thread->stack = nullptr;
    }
    *handle = thread;
    return 0;
}

void _thread::kdispatch(int flag) {
    _thread *old = running;
    if (!old->isFinished() && flag == 0) { Scheduler::put(old); }
    running = Scheduler::get();
    _thread::contextSwitch(&old->context, &running->context);
}

void _thread::threadWrapper() {
    Riscv::popSppSpie();
    running->body(running->arg);
    thread_exit();
}

void _thread::addToScheduler(thread_t t) {
    Scheduler::put(t);
}
