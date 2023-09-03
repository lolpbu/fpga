#include "include/include.h"

using namespace std;

int main(int argc, char** argv) {
    //const int FPS = 60;

    Tela t;

    // Mat4 frmt_L({
    //     {' ', ' ', ' ', ' '},
    //     {' ', ' ', ' ', ' '},
    //     {' ', ' ', ' ', ' '},
    //     {' ', ' ', ' ', ' '}
    // });

    Mat4 teste({
        {'a', 'b', 'c', 'd'},
        {'e', 'f', 'g', 'h'},
        {'i', 'j', 'k', 'l'},
        {'m', 'n', 'o', 'p'}
    });

    //Mat4 teste('E');
    
    //while(true) {
        //clear();

        //Peca p(teste);

        //t.add_peca(p);
        t.print();
        teste.print();

        //sleep(1000);
    //}

    return 0;
}
