#include "../h/outputBuffer.hpp"

OutputBuffer* OutputBuffer::outputBuffer = nullptr;

void OutputBuffer::createOutputBuffer() {
    outputBuffer = new OutputBuffer(2048);
}

void OutputBuffer::deleteOutputBuffer() {
    delete outputBuffer;
}

int OutputBuffer::get() {
    if(getCnt()>0){
        return ConsoleBuffer::get();
    }
    else return 0;
}

