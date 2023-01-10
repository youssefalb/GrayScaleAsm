#pragma once

struct Pixel
{
    float r;
    float g;
    float b;
    float a;
};

extern "C" __declspec(dllexport) void getGrayScaleCpp1(Pixel * inBmp, Pixel * outBmp, int size);


