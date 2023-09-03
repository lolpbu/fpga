#ifndef _INPUT_H
#define _INPUT_H

#include <windows.h>
#include <chrono>
#include <thread>

typedef enum {
    RIGHT,
    LEFT,
    DOWN,
    UP,
    NOSTT = -1
} KEY_STATE;

inline void sleep(int ms) { std::this_thread::sleep_for(std::chrono::milliseconds(ms)); }
inline void clear() { system("CLS"); }

namespace Input {
    inline bool key_left()  { return GetKeyState(VK_LEFT)  & 0x8000; };
    inline bool key_right() { return GetKeyState(VK_RIGHT) & 0x8000; };
    inline bool key_down()  { return GetKeyState(VK_DOWN)  & 0x8000; };
    inline bool key_up()    { return GetKeyState(VK_UP)    & 0x8000; };

    inline bool key_esc() { return GetKeyState(VK_ESCAPE) & 0x8000; };

    inline KEY_STATE get_key_state() {
        if(key_left())
            return LEFT;
        else if(key_right())
            return RIGHT;
        else if(key_down())
            return DOWN;
        else if(key_up())
            return UP;
        return NOSTT;
    }
};



#endif