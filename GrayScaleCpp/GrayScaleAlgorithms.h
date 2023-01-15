#pragma once


struct Pixel
{
    float r;
    float g;
    float b;
    float a;
};

extern "C" __declspec(dllexport) void getGrayScaleCpp1(Pixel * inBmp, Pixel * outBmp, int size);
extern "C" __declspec(dllexport) void getGrayScaleCpp2(Pixel * inBmp, Pixel * outBmp, int size);
extern "C" __declspec(dllexport) void getGrayScaleCpp3(Pixel * inBmp, Pixel * outBmp, int size, int shades);


