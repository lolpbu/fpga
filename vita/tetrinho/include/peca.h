#ifndef _PECA_H
#define _PECA_H

#include "input.h"
#include "mat4.h"

struct Peca {
    Mat4 format;
    int x, y;
    int rotation;
    
    Peca(Mat4 mat);
    //Peca& operator=(const Peca& other);

    void move(KEY_STATE input);
};

#endif