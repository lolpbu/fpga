#include "include/peca.h"
#include <iostream>
#include "include/include.h"

Peca::Peca(Mat4& frmt) {
    x = W/2 -2;
    y = H/2 -2;
    rotation = 0;
    format = frmt;
    sol = false;
}

bool Peca::coll(KEY_STATE input, Tela* t) {
    bool out = true;
    for(int i=0; i<4; i++) {
        for(int j=0; j<4; j++) {
            if(format.at(i, j) == BG_CHAR) {
                //std::cout << "caraactere vazio fds" << i << j << std::endl;
                continue;
            }
            
            switch(input) {
                case LEFT: 
                    if(t->tile.at(i+y).at(j + x - 1) == MOV_CHAR) {
                        //std::cout << "caractere # fds" << i << j << std::endl;
                        continue;
                    }
                    
                    if(t->tile.at(i+y).at(j + x - 1) == BG_CHAR)
                        out = false;
                    //std::cout << "sequerda vazia "<< i << j<< std::endl;
                    break;

                case RIGHT:
                    if(t->tile.at(i+y).at(j + x + 1) == MOV_CHAR) {
                        //std::cout << "caractere # fds" << i << j << std::endl;
                        continue;
                    }
                    
                    if(t->tile.at(i+y).at(j + x + 1) == BG_CHAR)
                        out = false;
                    //std::cout << "direitaa vazia "<< i << j<< std::endl;
                    break;

                case DOWN: 
                    if(t->tile.at(i + y + 1).at(j+x) == MOV_CHAR) {
                         //std::cout << "caractere # fds" << i << j << std::endl;
                        continue;
                    }
                    if(t->tile.at(i + y + 1).at(j+x) == BG_CHAR)
                        out = false;
                    //std::cout << "baixo vazia "<< i << j<< std::endl;
                    break;

                case UP: 
                    if(t->tile.at(i + y - 1).at(j+x) == MOV_CHAR) {
                         //std::cout << "caractere # fds" << i << j << std::endl;
                        continue;
                    }

                    if(t->tile.at(i + y - 1).at(j+x) == BG_CHAR)
                        out = false;
                    //std::cout << "cima vazia "<< i << j<< std::endl;
                    break;
            }
        }
    }

    //std::cout << "porraa nenhuma" << std::endl;
    //sleep(5000);
    //while(!Input::key_esc())
        //sleep(100);
    return out;
}

void Peca::move(KEY_STATE input, Tela* t) {
    // (0,0)- - - -(3,0)
    // (0,1)- - - -(3,1)
    // (0,2)- - - -(3,2)
    // (0,3)- - - -(3,2)
    switch(input) {
        case LEFT:
            if(!coll(input, t))
                x--;
            break;
        case RIGHT:
            if(!coll(input, t))
                x++;
            break;
        case DOWN:
            if(!coll(input, t))
                y++;
            break;
        case UP:
            if(!coll(input, t) && y > 0)
                y--;
            break;
    }

    t->clear_mov();

    // collisao
    for(int i=0; i<4; i++) {
        for(int j=0; j<4; j++) {
            if(t->tile.at(i + y).at(j + x) == BG_CHAR)
                t->tile.at(i + y).at(j + x) = format.at(i, j);
        }
    }
    // t->add_peca(*this);
}