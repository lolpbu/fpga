#ifndef _INPUT_H
#define _INPUT_H

#include <windows.h>
#include <chrono>
#include <thread>
 
#define FPS (1000/60)

inline void sleep(int ms) { std::this_thread::sleep_for(std::chrono::milliseconds(ms)); }

namespace Input {
    inline bool key_left()  { return GetKeyState(VK_LEFT)  & 0x8000; };
    inline bool key_right() { return GetKeyState(VK_RIGHT) & 0x8000; };
    inline bool key_down()  { return GetKeyState(VK_DOWN)  & 0x8000; };
    inline bool key_up()    { return GetKeyState(VK_UP)    & 0x8000; };

    inline bool key_esc() { return GetKeyState(VK_ESCAPE) & 0x8000; };
};



#endif