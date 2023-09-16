#include <iostream>
#include <chrono>
#include <thread>

#include "include/input.h"
#include "include/mat4.h"
#include "include/tela.h"
#include "include/peca.h"

using namespace std;

chrono::system_clock::time_point t_a = chrono::system_clock::now();
chrono::system_clock::time_point t_b = chrono::system_clock::now();

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

    const double period = 1000.0/5.5; //1s/hz -> 1000ms/hz
    
    while(true) {
        if(Input::key_esc())
            break;
        
        //step clock
        t_a = chrono::system_clock::now();
        chrono::duration<double, milli> deltaT = t_a - t_b;
        if(deltaT.count() < period) { 
            chrono::duration<double, milli> deltaT_ms(period - deltaT.count());
            auto deltaT_ms_duration = chrono::duration_cast<chrono::milliseconds>(deltaT_ms);
            this_thread::sleep_for(chrono::milliseconds(deltaT_ms_duration.count()));
        }
        t_b = chrono::system_clock::now();
        chrono::duration<double, milli> work_time = t_b - t_a;


        //input handle
        stt = Input::get_key_state();

        //update
        p.move(stt, &t);
        if(p.y == H - 1 - 4) {
            p.format.setChar(SOL_CHAR);
        }

        //draw
        cout << "\x1b[2J\x1b[H";
        t.print();

        //debug
        cout << "hz " << 1000.0/(work_time + deltaT).count() << endl;
        cout << endl;

        cout << stt  << " / " << Input::key_state_str(stt) << endl;
        cout << "x " << p.x << endl;
        cout << "y " << p.y << endl;
        cout << endl;

        cout << "coll R " << p.coll(RIGHT, &t) << endl;
        cout << "coll L " << p.coll(LEFT, &t) << endl;
        cout << "coll D " << p.coll(DOWN, &t) << endl;
        cout << "coll U " << p.coll(UP, &t) << endl;
    }
    return 0;
}
