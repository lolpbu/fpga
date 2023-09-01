#include "include/mat4.h"
#include "include/peca.h"
#define W 12
#define H 24

int main(int argc, char** argv) {
    Tela t;

    Peca peca_L(&t);
    peca_L.set( Mat4({
        {' ', ' ', ' ', ' '},
        {'#', ' ', ' ', ' '},
        {'#', ' ', ' ', ' '},
        {'#', '#', ' ', ' '}
    }) );

    t.print();
    std::cout << "=======================" << std::endl;

    peca_L.update_board();
    t.print();

    return 0;
}