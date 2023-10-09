#ifndef PROJECT_BASE_V1_0_LIST_HPP
#define PROJECT_BASE_V1_0_LIST_HPP
#include "memory.hpp"
#include "../lib/console.h"
template<typename T>
class List {
private:
    struct Elem {
        Elem* next;
        T data;
    };

public:
    Elem* head, *tail;

    List() : head(nullptr), tail(nullptr) {}
    List(const List<T>&) = delete;
    List<T>& operator=(const List<T>&) = delete;

    void addFirst(T data) {
        size_t sz = (sizeof(Elem)+sizeof(size_t))/MEM_BLOCK_SIZE + (((sizeof(Elem)+sizeof(size_t))%MEM_BLOCK_SIZE)==0?0:1);
        Elem* novi =(Elem*) MemoryAllocator::kmem_alloc(sz);
        novi->data = data; novi->next = head;
        head = novi;
        if (!tail) tail = novi;
    }

    void addLast(T data) {
        size_t sz = (sizeof(Elem)+sizeof(size_t))/MEM_BLOCK_SIZE + (((sizeof(Elem)+sizeof(size_t))%MEM_BLOCK_SIZE)==0?0:1);
        Elem* novi = (Elem*) MemoryAllocator::kmem_alloc(sz);
        novi->data = data; novi->next = nullptr;
        if (tail) {
            tail->next = novi;
            tail = novi;
        }
        else
            head = tail = novi;
    }

    T removeFirst() {
        //if (!head) return nullptr;
        if(!head) return 0;
        Elem* elem = head;
        head = head->next;
        if (!head) tail = nullptr;
        T data = elem->data;
        MemoryAllocator::kmem_free(elem);
        //delete elem;
        return data;
    }

    T removeLast() {
        //if (!head) return nullptr;
        if(!head) return nullptr;
        Elem* prev = nullptr;
        for (Elem* curr = head; curr && curr != tail; curr = curr->next) prev = curr;
        Elem* elem = tail;
        if (prev) prev->next = nullptr;
        else head = nullptr;
        tail = prev;
        T* data = elem->data;
        MemoryAllocator::kmem_free(elem);
        return data;
    }

    T peekFirst() {
        if (!head) return nullptr;
        return head->data;
    }

    T peekLast() {
        if (!tail) return nullptr;
        return tail->data;
    }


};

#endif