#ifndef _syscall_cpp
#define _syscall_cpp

#include "syscall_c.hpp"
#include "thread.hpp"
#include "../lib/console.h"


void* operator new (size_t);
void* operator new[](size_t);
void operator delete (void*);
void operator delete[](void*);

class Thread{
public:
    Thread(void (*body)(void*), void* arg){
        thread_create_cpp(&myHandle, body, arg);
    }

    virtual ~Thread(){}

    void start();

    static void dispatch();
    static void sleep(time_t);

protected:
    Thread(){
        thread_create_cpp(&myHandle, runWrapper, this);
    }
    virtual void run(){}
private:
    static void runWrapper(void*);
    thread_t myHandle;
};

class Semaphore{
public:
    Semaphore(unsigned init = 1){
        sem_open(&myHandle, init);
    }
    virtual ~Semaphore(){
        sem_close(myHandle);
    }

    void wait();
    void signal();

private:
    sem_t myHandle;
};

class PeriodicThread : public Thread{
protected:
    PeriodicThread (time_t period);
    virtual void periodicActivation(){}

private:
    struct Elem{
        time_t time;
        PeriodicThread* thread;
        Elem(time_t t, PeriodicThread*thr) : time(t), thread(thr) {}
    };

    static void wrapper(void*);
    bool flag;
};

class Console{
public:
    static char getc();
    static void putc(char);
};

#endif
