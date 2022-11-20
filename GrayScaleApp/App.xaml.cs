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

    public void getGrayScale1(Pixel* inBmp, Pixel* outBmp, int size)
    {
        getGrayScaleAsm1(inBmp, outBmp, size);
    }

}

public unsafe class AsmProxy_2
{
    [DllImport("GrayScaleAsm.dll")]
    private static unsafe extern float getGrayScaleAsm2(Pixel* inBmp, Pixel* outBmp, int size);

  
    public float getGrayScale2(Pixel* inBmp, Pixel* outBmp, int size)
    {
        return getGrayScaleAsm2(inBmp, outBmp, size);
    }
}

public unsafe class AsmProxy_3
{
    [DllImport("GrayScaleAsm.dll")]
    private static unsafe extern float getGrayScaleAsm3(Pixel* inBmp, Pixel* outBmp, int size, int shadesNumber);


    public float getGrayScale3(Pixel* inBmp, Pixel* outBmp, int size)
    {
        return getGrayScaleAsm3(inBmp, outBmp, size, 200);
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
