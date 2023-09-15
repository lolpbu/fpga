#include <iostream>
#include "include/input.h"
#include "include/mat4.h"
#include "include/tela.h"
#include "include/peca.h"

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

    // Mat4 teste({
    //     {' ', ' ', ' ', ' '},
    //     {' ', ' ', ' ', ' '},
    //     {' ', ' ', ' ', ' '},
    //     {' ', ' ', ' ', ' '}
    // });

    // Mat4 teste('A');

    // Mat4 teste({
    //     {'a', 'b', 'c', 'd'},
    //     {'e', 'f', 'g', 'h'},
    //     {'i', 'j', 'k', 'l'},
    //     {'m', 'n', 'o', 'p'}
    // });

    Mat4 teste({
        {' ', ' ', ' ', ' '},
        {' ', '#', '#', ' '},
        {' ', '#', '#', ' '},
        {' ', ' ', ' ', ' '}
    });

    Peca p(teste);

    KEY_STATE stt = NOSTT;

    while(true) {
        if(Input::key_esc())
            break;
        
        stt = Input::get_key_state();

        //t.add_peca(p);

        //p.move(stt, &t);

        //t.add_peca(p);

        p.move(stt, &t);

        clear();
        //t.clear_mov();
        t.print();
        std::cout << stt  << " / " << Input::key_state_str(stt) << std::endl;
        std::cout << "x " << p.x << std::endl;
        std::cout << "y " << p.y << std::endl;

        sleep(500);
    }


    return 0;
}
