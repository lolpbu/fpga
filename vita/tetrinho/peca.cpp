#include "include/peca.h"
#include <iostream>

Peca::Peca(Tela* t) {
    this->x = 0;
    this->y = 0;
    this->rotation = 0;
    this->_arr = Mat4();
    this->_t = t;
}

void Peca::print() {
    for(int i=0; i<4; i++) {
        for(int j=0; j<4; j++) 
            std::cout << this->_arr.at(i, j);
        std::cout << std::endl;
    }
}

void Peca::set(Mat4 format) {
    this->_arr = format;
}

void Peca::update_board() {
    for(int i=y; i<y+4; i++)
        for(int j=x; j<x+4; j++)
            if(this->_arr.at(i, j) != ' ')
                this->_t->tile[i][j+1] = this->_arr.at(i, j);
}