#include "include/peca.h"
#include <iostream>

Peca::Peca(Mat4& frmt) {
    x = 1;
    y = 0;
    rotation = 0;
    format = frmt;
    sol = false;
}

void Peca::move(KEY_STATE input, Tela* t) {
    const int w = 12;
    const int h = 24;

    //while(y < h-1) {
        switch(input) {
            case LEFT:
                x--;
                break;
            case RIGHT:
                x++;
                break;
            case DOWN:
                y++;
                break;
            case UP:
                y--;
                break;
        }
        //format.print();
    //}
    t->clear_mov();
     for(int i=0; i<4; i++)
         for(int j=0; j<4; j++)
            t->tile.at(i + y).at(j + x) = format.at(i, j);
    // t->add_peca(*this);
}