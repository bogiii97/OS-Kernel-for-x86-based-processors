#include "../h/syscall_cpp.hpp"

void *operator new(size_t n) { return mem_alloc(n); }
void *operator new[](size_t n) { return mem_alloc(n); }
void operator delete(void *p) { mem_free(p); }
void operator delete[](void *p) { mem_free(p); }


void Thread::dispatch() {
    thread_dispatch();
}

void Thread::start() {
    addScheduler(myHandle);
}

void Thread::sleep(time_t t) {
    time_sleep(t);
}

void Thread::runWrapper(void *arg) {
    if(arg!=nullptr){
        Thread* t = (Thread*) arg;
        t->run();
    }
}


void Semaphore::wait() {
    sem_wait(myHandle);
}
void Semaphore::signal() {
    sem_signal(myHandle);
}

PeriodicThread::PeriodicThread(time_t period) : Thread(wrapper, new Elem(period, this)){
    flag = true;
}

void PeriodicThread::wrapper(void *arg) {
    Elem* elem = (Elem*) arg;
    time_t time = elem->time;
    PeriodicThread* thr = elem->thread;
    while(thr->flag){
        thr->periodicActivation();
        sleep(time);
    }
}


char Console::getc() {
    return ::getc();
}
void Console::putc(char c) {
     ::putc(c);

}