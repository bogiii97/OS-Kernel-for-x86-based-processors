#ifndef PROJECT_BASE_V1_0_SLEEPQUEUE_HPP
#define PROJECT_BASE_V1_0_SLEEPQUEUE_HPP

#include "list.hpp"
#include "thread.hpp"

class sleepQueue {
private:
    struct Elem {
        Elem* next;
        _thread* thread;
    };
    static Elem* head,* tail;

public:
    static void put(_thread*);

    static void iterate();

};






#endif
