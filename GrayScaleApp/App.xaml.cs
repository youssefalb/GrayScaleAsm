using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using System.Windows;
using System.Runtime.InteropServices;
using static GrayScaleApp.MainWindow;

public unsafe class AsmProxy
{
    [DllImport("GrayScaleAsm.dll")]

    private static unsafe extern float getGrayScaleAsm1(Pixel* inBmp, Pixel* outBmp, int size);
    [DllImport("GrayScaleAsm.dll")]
    private static unsafe extern float getGrayScaleAsm2(Pixel* inBmp, Pixel* outBmp, int size);

    [DllImport("GrayScaleAsm.dll")]
    private static unsafe extern float getGrayScaleAsm3(Pixel* inBmp, Pixel* outBmp, int size, int shadesNumber);
    public void getGrayScale1(Pixel* inBmp, Pixel* outBmp, int size)
    {
        getGrayScaleAsm1(inBmp, outBmp, size);
    }
    public float getGrayScale2(Pixel* inBmp, Pixel* outBmp, int size)
    {
        return getGrayScaleAsm2(inBmp, outBmp, size);
    }
    public float getGrayScale3(Pixel* inBmp, Pixel* outBmp, int size, int shades)
    {
        return getGrayScaleAsm3(inBmp, outBmp, size, shades);
    }

}


public unsafe class CppProxy
{
    [DllImport("GrayScaleCpp.dll")]

    private static unsafe extern float getGrayScaleCpp1(Pixel* inBmp, Pixel* outBmp, int size);
    [DllImport("GrayScaleCpp.dll")]

    private static unsafe extern float getGrayScaleCpp2(Pixel* inBmp, Pixel* outBmp, int size);

    [DllImport("GrayScaleCpp.dll")]

    private static unsafe extern float getGrayScaleCpp3(Pixel* inBmp, Pixel* outBmp, int size, int shades);
    public void getGrayScale1(Pixel* inBmp, Pixel* outBmp, int size)
    {
        getGrayScaleCpp1(inBmp, outBmp, size);
    }

    public void getGrayScale2(Pixel* inBmp, Pixel* outBmp, int size)
    {
        getGrayScaleCpp2(inBmp, outBmp, size);
    }

    public void getGrayScale3(Pixel* inBmp, Pixel* outBmp, int size , int shades)
    {
        getGrayScaleCpp3(inBmp, outBmp, size, shades);
    }

}


namespace GrayScaleApp
{
    /// <summary>
    /// Interaction logic for App.xaml
    /// </summary>
    public partial class App : Application
    {
    }
}
