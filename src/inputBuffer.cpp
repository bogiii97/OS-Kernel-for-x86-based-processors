#include "../h/inputBuffer.hpp"

InputBuffer* InputBuffer::inputBuffer = nullptr;

void InputBuffer::createInputBuffer() {
    inputBuffer = new InputBuffer(2048);
}

void InputBuffer::deleteInputBuffer() {
    delete inputBuffer;
}

void InputBuffer::put(char val){
    if(num == cap) return;
    ConsoleBuffer::put(val);
    num++;
}

int InputBuffer::get() {
    int res = ConsoleBuffer::get();
    num--;
    return res;
}