#ifndef _PECA_H
#define _PECA_H

#include "input.h"
#include "mat4.h"
#include "tela.h"

struct Peca {
    Mat4 format;
    int x, y;
    int rotation;
    bool sol;
    
    Peca(Mat4& frmt);
    //Peca& operator=(const Peca& other);

    void move(KEY_STATE input, Tela* t);

//private:
    bool coll(KEY_STATE input, Tela* t);
};

#endif