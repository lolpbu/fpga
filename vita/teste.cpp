#include <iostream>
/*
....
.AA.
.AA.
....


quad: [[0, 0, 0, 0],
      [0, 1, 1, 0],
      [0, 1, 1, 0],
      [0, 0, 0, 0]}

*/

#define W 12
#define H 24

class tela {
    char c[H][W];
public:

    tela() {
        for(int i=0; i<H; i++)
            for(int j=0; j<W; j++)
                c[i][j] = ' ';
        
        for(int i=0; i<H; i++) {
            c[i][0] = '|';
            c[i][W-1] = '|';
        }

        for(int i=0; i<W; i++) {
            c[H-1][i] = '-';
        }
    }

    void print() {
        for(int i=0; i<H; i++) {
            for(int j=0; j<W; j++)
                std::cout << c[i][j];
            std::cout << std::endl;
        }
    };
};

int main(int argc, char** argv) {

    tela* t = new tela();
    t->print();


    return 0;
}
