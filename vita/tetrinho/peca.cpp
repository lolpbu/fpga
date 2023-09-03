#include "include/peca.h"
#include <iostream>

Peca::Peca(Mat4 mat) {
    x = 0;
    y = 0;
    rotation = 0;
    format = mat;
}

void Peca::move(KEY_STATE input) {
    const int w = 12;
    const int h = 24;

    switch(input) {
        case LEFT:
            if(x > 0) {
                x--;
            }
            break;
        case RIGHT:
            if(x < w-1) {
                x++;
            }
            break;
        case DOWN:
            if(y < h-1) {
                y++;
            }
            break;
        case UP:
            if(y > 0) {
                y--;
            }
            break;
    }
}