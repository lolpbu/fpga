#include "include/include.h"
#define W 12
#define H 24

#include <winbase.h>

int main(int argc, char** argv) {


    int i = 0;
    double start = 0.0;
    Tela t;

    char input = ' ';
    
    while(true) {
        start = GetCurrentTime();

        //process input
        if(Input::key_down())
            input = 'd';
        else if(Input::key_left())
            input = 'l';
        else if(Input::key_right())
            input = 'r';
        else if(Input::key_up())
            input = 'u';
        else if(Input::key_esc())
            input = 'e';

        // update
        i++;

        // render
        printf("(i%d) (%lf): %c \n", i, start - GetCurrentTime(), input);
        //sleep(1000/60);
        sleep(FPS + start - GetCurrentTime());

        //Sleep(start + MS_PER_FRAME);
    }

    /*
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
    t.print();*/

    return 0;
}