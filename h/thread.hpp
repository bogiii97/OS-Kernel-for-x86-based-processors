#ifndef PROJECT_BASE_V1_0_THREAD_HPP
#define PROJECT_BASE_V1_0_THREAD_HPP
#include "../lib/hw.h"
#include "../h/scheduler.hpp"
#include "../h/riscV.hpp"
#include "../h/syscall_c.hpp"
#include "../h/sleepQueue.hpp"
#include "../h/memory.hpp"

class _thread {
public:
    ~_thread() {
        if(stack)
            MemoryAllocator::kmem_free(stack);
    }
    bool isFinished() const { return finished; }
    void setFinished(bool value) { finished = value; }
    uint64 getTimeSlice() const { return timeSlice; }
    uint64 getTimeToSleep() const { return timeToSleep; }
    void decTimeToSleep() { timeToSleep--; }
    using Body = void (*)(void*);
    static int createThread(thread_t* handle, Body body, void*arg, uint64*stek, int flag);
    static _thread *running;
    static void kdispatch(int flag);
    static void threadWrapper();
    static int sleep(time_t time);
    static void addToScheduler(thread_t);
    static void setTimeSliceCounter(){ timeSliceCounter = 0; }

    void operator delete(void * arg){
        MemoryAllocator::kmem_free(arg);
    }

private:
    struct Context { uint64 ra; uint64 sp; };
    Context context;
    static void contextSwitch(Context *oldContext, Context *runningContext);
    Body body;

    void* arg; uint64* stack; uint64 timeSlice; bool finished;
    uint64 timeToSleep;
    friend class Riscv;
    static uint64 timeSliceCounter;

};


#endif