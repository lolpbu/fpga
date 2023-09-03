#include "include/tela.h"

Tela::Tela() : tile(H, std::vector<char> (W)) {
    for(int i=0; i<H; i++)
        for(int j=0; j<W; j++)
            tile[i][j] = ' ';
        
    for(int i=0; i<H; i++) {
        tile[i][0]   = '|';
        tile[i][W-1] = '|';
    }

    for(int i=0; i<W; i++)
        tile[H-1][i] = '-';
}

Tela::~Tela() {
    for(int i=0; i<W; i++)
        delete[] &tile[i];
    delete[] &tile;
}

void Tela::print() {
    for(int i=0; i<H; i++) {
        for(int j=0; j<W; j++)
            std::cout << tile[i][j];
        std::cout << std::endl;
    }
};

void Tela::add_peca(Peca& p) {
    for(int i=p.y; i<p.y+4; i++)
        for(int j=p.x; j<p.x+4; j++)
            if(p.format.at(i, j) != ' ')
                tile[i][j+1] = p.format.at(i, j);
}