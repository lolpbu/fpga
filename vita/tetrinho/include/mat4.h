#ifndef _MAT_4_H
#define _MAT_4_H

#define W 12
#define H 24

#include <iostream>

struct Tela {
public:
    char tile[H][W];
    Tela();
    void print();
};

class Mat4 {
private:
    char _array[4][4];

public:
    Mat4();
    Mat4(const char (&format)[4][4]);
    Mat4& operator=(const char other[4][4]);
    Mat4& operator=(const Mat4& other);

    //static inline Mat4& from(const char format[4][4]) { return Mat4(format); };
    inline char at(int r, int c) { return this->_array[r][c]; };
};

#endif