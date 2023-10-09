#include "../h/syscall_c.hpp"
#include "../h/riscV.hpp"
#include "../lib/console.h"

void* mem_alloc(size_t size){
    if(size <= 0 || size > (uint64)HEAP_END_ADDR - (uint64)HEAP_START_ADDR) return nullptr;
    else size = (size + sizeof(size_t))/MEM_BLOCK_SIZE + (((size + sizeof(size_t))%MEM_BLOCK_SIZE)==0?0:1);
    Riscv::sysCall(0x1,&size, nullptr, nullptr, nullptr);
    void* res = nullptr;
    __asm__ ("mv %[res], a0" : [res] "=r"(res));
    return res;
}

int mem_free(void* addr){
    if(addr == nullptr) return -1;
    Riscv::sysCall(0x2, addr, nullptr, nullptr, nullptr);
    uint64 res = 0;
    __asm__ ("mv %[res], a0" : [res] "=r"(res));
    return res;
}

int thread_create(thread_t* handle, void(*start_routine)(void*), void* arg){
    void* stack_size = mem_alloc((uint64)DEFAULT_STACK_SIZE);
    Riscv::sysCall(0x11, handle, (void*)start_routine, arg, stack_size);
    uint64 res = 0;
    __asm__ ("mv %[res], a0" : [res] "=r"(res));
    return res;
}

int thread_exit(){
    Riscv::sysCall(0x12, nullptr, nullptr, nullptr, nullptr);
    uint64 res = 0;
    __asm__ ("mv %[res], a0" : [res] "=r"(res));
    return res;
}
void thread_dispatch(){
    Riscv::sysCall(0x13, nullptr, nullptr, nullptr, nullptr);
}

void thread_create_cpp(thread_t* handle, void(*start_routine)(void*), void* arg){
    void* stack_size = mem_alloc((uint64)DEFAULT_STACK_SIZE);
    Riscv::sysCall(0x14, handle, (void*)start_routine, arg, stack_size);
}

void addScheduler(thread_t t){
    Riscv::sysCall(0x15, t, nullptr, nullptr, nullptr);
}

int sem_open(sem_t* handle, unsigned  init){
    Riscv::sysCall(0x21, handle, &init, nullptr, nullptr);
    uint64 res = 0;
    __asm__ ("mv %[res], a0" : [res] "=r"(res));
    return res;
}
int sem_close(sem_t handle){
    Riscv::sysCall(0x22, handle, nullptr, nullptr, nullptr);
    uint64 res = 0;
    __asm__ ("mv %[res], a0" : [res] "=r"(res));
    return res;
}
int sem_wait(sem_t id){
    Riscv::sysCall(0x23, id, nullptr, nullptr, nullptr);
    uint64 res = 0;
    __asm__ ("mv %[res], a0" : [res] "=r"(res));
    return res;
}
int sem_signal(sem_t id){
    Riscv::sysCall(0x24, id, nullptr, nullptr, nullptr);
    uint64 res = 0;
    __asm__ ("mv %[res], a0" : [res] "=r"(res));
    return res;
}

int time_sleep(time_t time){
    Riscv::sysCall(0x31, &time, nullptr, nullptr, nullptr);
    uint64 res = 0;
    __asm__ ("mv %[res], a0" : [res] "=r"(res));
    return res;
}

char getc(){
    Riscv::sysCall(0x41, nullptr, nullptr, nullptr, nullptr);
    uint64 res = 0;
    __asm__ ("mv %[res], a0" : [res] "=r"(res));
    return res;
}

void putc(char c){
    Riscv::sysCall(0x42, &c, nullptr, nullptr, nullptr);
}

void userMode(){
    Riscv::sysCall(0x50, nullptr, nullptr, nullptr, nullptr);

}

void kernelMode(){
    Riscv::sysCall(0x51, nullptr, nullptr, nullptr, nullptr);
}