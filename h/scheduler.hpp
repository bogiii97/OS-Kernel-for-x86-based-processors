#ifndef PROJECT_BASE_V1_0_SCHEDULER_HPP
#define PROJECT_BASE_V1_0_SCHEDULER_HPP

#include "list.hpp"
#include "syscall_c.hpp"

class Scheduler {
private:
    static List<_thread*> readyThreadQueue;

public:
    static _thread* get();

    static void put(_thread*);

};


#endif