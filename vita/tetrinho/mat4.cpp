#include "include/mat4.h"

Mat4::Mat4() : _array(4, std::vector<char> (4)) {
    for(int i=0; i<4; i++)
        for(int j=0; j<4; j++)
            _array[i][j] = ' ';
}

Mat4::~Mat4() {
    for(int i=0; i<4; i++)
        delete[] &_array[i];
    delete[] &_array;
}

Mat4::Mat4(const char2d format) : _array(4, std::vector<char> (4)) {
    for(int i=0; i<4; i++)
        for(int j=0; j<4; j++)
            this->_array[i][j] = format[i][j];
}

Mat4::Mat4(const char c) : _array(4, std::vector<char> (4)) {
    for(int i=0; i<4; i++)
        for(int j=0; j<4; j++)
            this->_array[i][j] = c;
}

Mat4& Mat4::operator=(const Mat4& other) {
    for(int i=0; i<4; i++)
        for(int j=0; j<4; j++)
            this->_array[i][j] = other._array[i][j];
    
    return *this;
}

Mat4& Mat4::operator=(const char2d other) {
    for(int i=0; i<4; i++)
        for(int j=0; j<4; j++)
            this->_array[i][j] = other[i][j];

    return *this;
}

void Mat4::print() {
    for(int i=0; i<4; i++) {
        for(int j=0; j<4; j++)
            std::cout << _array[i][j];
        std::cout << std::endl;
    }
}