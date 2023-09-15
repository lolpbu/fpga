#ifndef _TELA_H
#define _TELA_H

#include <iostream>
#include <vector>
//#include "peca.h"
#include "mat4.h"

#define W 12
#define H 24

const char BG_CHAR = ' ';

struct Tela {
public:
    char2d tile;
    //std::vector<std::vector<char>> tile(4, std::vector<char>(4, ' '));

    Tela();
    ~Tela();

    void clear_mov();
    void print();
    //void add_peca(Peca& p);
};

#endif