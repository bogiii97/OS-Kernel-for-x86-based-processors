#ifndef PROJECT_BASE_V1_0_SEMAPHORE_HPP
#define PROJECT_BASE_V1_0_SEMAPHORE_HPP

#include "../h/syscall_c.hpp"
#include "../h/list.hpp"
#include "../h/thread.hpp"

class _sem{
private:
    int value;
    List<_thread*> SemaforQueue;
    int sem_exists;
public:
    static int ksem_open(sem_t* handle, unsigned init);
    static int ksem_close(sem_t handle);

    static int kwait(sem_t id);
    static int ksignal(sem_t id);


};


#endif