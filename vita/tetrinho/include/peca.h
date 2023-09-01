#ifndef _PECA_H
#define _PECA_H

#include "mat4.h"

class Peca {
private:
    Mat4 _arr;
    Tela* _t;

public:
    int x, y;
    int rotation;
    
    Peca(Tela* board);
    //Peca& operator=(const Peca& other);

    void print();
    void set(Mat4 format);
    void update_board();
};

#endif