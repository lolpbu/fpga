#include "include/tela.h"

Tela::Tela() : tile(H, std::vector<char> (W)) {
    for(int i=0; i<H; i++)
        for(int j=0; j<W; j++)
            tile[i][j] = BG_CHAR;
        
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

void Tela::clear_mov() {
    for(int i=0; i<H; i++) {
        for(int j=0; j<W; j++) {
            if(tile.at(i).at(j) == MOV_CHAR)
                tile[i][j] = BG_CHAR;
        }
    }
}

// void Tela::add_peca(Peca& p) {
//     if(!p.sol) {
//         for(int i=0; i<4; i++)
//             for(int j=0; j<4; j++)
//                 if(p.format.at(i, j) == MOV_CHAR)
//                     tile[i + p.y][j + p.x] = p.format.at(i, j);
//     }
//     // while(!p.sol) {
//     //     clear_mov();
//     //     p.move(stt);
//     // }
//     // for(int i=0; i<4; i++)
//     //     for(int j=0; j<4; j++)
//     //         if(p.format.at(i, j) == 'A')
//     //             tile[i + p.y][j + p.x] = p.format.at(i, j);
// }