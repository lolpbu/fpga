#include "include/mat4.h"


Tela::Tela() {
    for(int i=0; i<H; i++)
        for(int j=0; j<W; j++)
            this->tile[i][j] = ' ';
        
    for(int i=0; i<H; i++) {
        this->tile[i][0] = '|';
        this->tile[i][W-1] = '|';
    }

    for(int i=0; i<W; i++)
        this->tile[H-1][i] = '-';
}

void Tela::print() {
    for(int i=0; i<H; i++) {
        for(int j=0; j<W; j++)
            std::cout << this->tile[i][j];
        std::cout << std::endl;
    }
};

void Tela::clear() {
    system("CLS");
}

// ------------------

Mat4::Mat4() {
    for(int i=0; i<4; i++)
        for(int j=0; j<4; j++)
            this->_array[i][j] = ' ';
}

Mat4::Mat4(const char (&format)[4][4]) {
    for(int i=0; i<4; i++)
        for(int j=0; j<4; j++)
            this->_array[i][j] = format[i][j];
}

Mat4& Mat4::operator=(const Mat4& other) {
    for(int i=0; i<4; i++)
        for(int j=0; j<4; j++)
            this->_array[i][j] = other._array[i][j];
    
    return *this;
}

Mat4& Mat4::operator=(const char other[4][4]) {
    for(int i=0; i<4; i++)
        for(int j=0; j<4; j++)
            this->_array[i][j] = other[i][j];

    return *this;
}

