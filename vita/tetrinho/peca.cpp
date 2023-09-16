#include "include/peca.h"
#include <iostream>
#include "include/input.h"

Peca::Peca(Mat4& frmt) {
    x = W/2 -2;
    y = H/2 -2;
    rotation = 0;
    format = frmt;
    sol = false;
}

bool Peca::coll(KEY_STATE input, Tela* t) {
    for(int i=0; i<4; i++) {
        for(int j=0; j<4; j++) {
            if(format.at(i, j) == BG_CHAR) 
                continue;

            int dX = (input == RIGHT) - (input == LEFT);
            int dY = (input == DOWN)  - (input == UP);

            if(t->tile.at(i + y + dY).at(j + x + dX) == MOV_CHAR)
                continue;
            
            if(t->tile.at(i + y + dY).at(j + x + dX) == BG_CHAR)
                return false;
        }
    }

    return true;
}

void Peca::move(KEY_STATE input, Tela* t) {
    int x_in = (input == RIGHT) - (input == LEFT);
    int y_in = (input == DOWN)  - (input == UP);

    if(x_in != 0 && !coll(input, t))
        x += x_in;

    if(y_in != 0 && !coll(input, t))
        y += y_in;
    
    //draw
    t->clear_mov();
    for(int i=0; i<4; i++) {
        for(int j=0; j<4; j++) {
            if(t->tile.at(i + y).at(j + x) == BG_CHAR)
                t->tile.at(i + y).at(j + x) = format.at(i, j);
        }
    }
}