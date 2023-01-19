#include "pch.h"
#include "GrayScaleAlgorithms.h"
#include <iostream>
#include <algorithm>

const float constGrayScale1[4]{ 0.2126, 0.7152, 0.0722 };

const float& my_max(const float& a, const float& b)
{
    return (a < b) ? b : a;
}

const float& my_min(const float& a, const float& b)
{
    return (a > b) ? b : a;
}
void getGrayScaleCpp1(Pixel* inBMPAddr, Pixel* outBMPAddr, int length) {

    for (int i = 0; i <= length; i++) {
        Pixel pixel = inBMPAddr[i];
        float gray = pixel.r * constGrayScale1[0];
        gray += pixel.g * constGrayScale1[1];
        gray += pixel.b * constGrayScale1[2];
        outBMPAddr[i].r = gray;
        outBMPAddr[i].g = gray;
        outBMPAddr[i].b = gray;
        outBMPAddr[i].a = pixel.a;
    }
}

void getGrayScaleCpp2(Pixel* inBMPAddr, Pixel* outBMPAddr, int length) {
    for (int i = 0; i <= length; i++) {
        Pixel pixel = inBMPAddr[i];
        float gray = my_max(my_max(pixel.b, pixel.r), pixel.g);
        gray += my_min(my_min(pixel.b, pixel.r), pixel.g);
        gray = gray / 2;
        outBMPAddr[i].r = gray;
        outBMPAddr[i].g = gray;
        outBMPAddr[i].b = gray;
        outBMPAddr[i].a = pixel.a;
    }

}

void getGrayScaleCpp3(Pixel* inBMPAddr, Pixel* outBMPAddr, int length, int shades) {
    const float conversionFactor = 255 / (shades - 1);
    for (int i = 0; i <= length; i++) {
        float averageValue = (inBMPAddr[i].r + inBMPAddr[i].g + inBMPAddr[i].b) / 3;
        float grayscale = (int)((averageValue / conversionFactor)+ 0.5) * conversionFactor;
        outBMPAddr[i].r = grayscale;
        outBMPAddr[i].g = grayscale;
        outBMPAddr[i].b = grayscale;
        outBMPAddr[i].a = inBMPAddr[i].a;
    }
}