using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Runtime.InteropServices;
using System.Windows.Forms;
using System.Drawing;
using System.IO;
using System.Windows.Interop;
using System.Drawing.Imaging;
using System.Diagnostics;
using MessageBox = System.Windows.Forms.MessageBox;

namespace GrayScaleApp
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public struct Pixel
        {
            public float r; 
            public float g;
            public float b;
            public float a;
            public Pixel(float _r , float _g, float _b, float _a)
            {
                r = _r;
                g = _g;
                b = _b;
                a = _a;
            }
        }
        public MainWindow()
        {
            InitializeComponent();
        }
        private void RadioButton_Checked(object sender, RoutedEventArgs e)
        {
            shadesPanel.Visibility = Visibility.Visible;
        }

        private void RadioButton_Unchecked(object sender, RoutedEventArgs e)
        {
            shadesPanel.Visibility = Visibility.Collapsed;
        }
        private void button2_Click(object sender, RoutedEventArgs e)
        {
            BitmapImage mybitmapImage = (BitmapImage)(PictureBox1.Source);
            Bitmap bitMapCopy = BitmapImage2Bitmap(mybitmapImage);
            int width = bitMapCopy.Width;
            int height = bitMapCopy.Height;
            Pixel[] inBMP = new Pixel[width*height];
            Pixel[] test = new Pixel[width*height];
            test[0] = new Pixel(255, 255.1f, 0, 55);
            test[1] = new Pixel(100, 100, 100, 100);
            Pixel[] outBMPAsm = new Pixel[width*height];
            Pixel[] outBMPCpp = new Pixel[width*height];
            for (int i = 0; i < width * height; i++) inBMP[i] = new Pixel();
            for (int y = 0; y < height; y++)
                for (int x = 0; x < width; x++)
                {
                    System.Drawing.Color bmpColor = bitMapCopy.GetPixel(x,y);

                    inBMP[y * width + x] = new Pixel(bmpColor.R, bmpColor.G, bmpColor.B, bmpColor.A);
                
                }

            if (radioButton1.IsChecked == true)
            {
                unsafe
                {

                    AsmProxy asmP = new AsmProxy();
                    CppProxy cppP = new CppProxy();
                    fixed (Pixel* inBMPAddr = inBMP)
                    {
                        fixed (Pixel* outBMPAddr = outBMPAsm, outBMPAddr2 =outBMPCpp)
                        {
                            cppP.getGrayScale1(inBMPAddr, outBMPAddr2, inBMP.Length);
                            asmP.getGrayScale1(inBMPAddr, outBMPAddr, inBMP.Length);
                            long totalTimeCpp = 0;
                            long totalTimeAsm = 0;
                            for (int i = 0; i < 100; i++)
                            {
                                Stopwatch stopwatch = Stopwatch.StartNew();
                                asmP.getGrayScale2(inBMPAddr, outBMPAddr, inBMP.Length);
                                stopwatch.Stop();
                                totalTimeAsm += stopwatch.ElapsedMilliseconds;

                                Stopwatch stopwatch_2 = Stopwatch.StartNew();
                                cppP.getGrayScale2(inBMPAddr, outBMPAddr2, inBMP.Length);
                                stopwatch.Stop();
                                totalTimeCpp += stopwatch_2.ElapsedMilliseconds;
                            }
                            totalTimeCpp = totalTimeCpp / 100;
                            totalTimeAsm = totalTimeAsm / 100;
                            asmTime.Text = totalTimeAsm + " milliseconds";
                            cppTime.Text = totalTimeCpp + " milliseconds";


                        }
                    }
                }
            }
            else if (radioButton2.IsChecked == true)
            {
                unsafe
                {

                    AsmProxy asmP = new AsmProxy();
                    CppProxy cppP = new CppProxy();
                    fixed (Pixel* inBMPAddr = inBMP)
                    {
                        fixed (Pixel* outBMPAddr = outBMPAsm, outBMPAddr2 = outBMPCpp)
                        {
                            cppP.getGrayScale2(inBMPAddr, outBMPAddr2, inBMP.Length);
                            asmP.getGrayScale2(inBMPAddr, outBMPAddr, inBMP.Length);
                            long totalTimeCpp = 0;
                            long totalTimeAsm = 0;


                            for (int i = 0; i < 100; i++)
                            {
                                Stopwatch stopwatch = Stopwatch.StartNew();
                                asmP.getGrayScale2(inBMPAddr, outBMPAddr, inBMP.Length);
                                stopwatch.Stop();
                                totalTimeAsm += stopwatch.ElapsedMilliseconds;

                                Stopwatch stopwatch_2 = Stopwatch.StartNew();
                                cppP.getGrayScale2(inBMPAddr, outBMPAddr2, inBMP.Length);
                                stopwatch.Stop();
                                totalTimeCpp += stopwatch_2.ElapsedMilliseconds;
                            }
                            totalTimeCpp = totalTimeCpp /100;
                            totalTimeAsm = totalTimeAsm /100;
                            asmTime.Text = totalTimeAsm + " milliseconds";
                            cppTime.Text = totalTimeCpp + " milliseconds";

                        }
                    }
                }
            }
            else if (radioButton3.IsChecked == true)
            {
                int shades = 0;
                if (int.TryParse(shadesTextBox.Text.Trim(), out shades))
                {
                    if (shades < 256 && shades > 2)
                    {
                        unsafe
                        {
                            AsmProxy asmP = new AsmProxy();
                            CppProxy cppP = new CppProxy();
                            fixed (Pixel* inBMPAddr = inBMP)
                            {
                                fixed (Pixel* outBMPAddr = outBMPAsm, outBMPAddr2 = outBMPCpp)
                                {
                                    cppP.getGrayScale3(inBMPAddr, outBMPAddr2, inBMP.Length , shades);
                                    asmP.getGrayScale3(inBMPAddr, outBMPAddr, inBMP.Length, shades);
                                    long totalTimeCpp = 0;
                                    long totalTimeAsm = 0;
                                    for (int i = 0; i < 100; i++)
                                    {
                                        Stopwatch stopwatch = Stopwatch.StartNew();
                                        asmP.getGrayScale3(inBMPAddr, outBMPAddr, inBMP.Length , shades);
                                        stopwatch.Stop();
                                        totalTimeAsm += stopwatch.ElapsedMilliseconds;

                                        Stopwatch stopwatch_2 = Stopwatch.StartNew();
                                        cppP.getGrayScale3(inBMPAddr, outBMPAddr2, inBMP.Length, shades);
                                        stopwatch.Stop();
                                        totalTimeCpp += stopwatch_2.ElapsedMilliseconds;
                                    }
                                    totalTimeCpp = totalTimeCpp / 100;
                                    totalTimeAsm = totalTimeAsm / 100;
                                    asmTime.Text = totalTimeAsm + " milliseconds";
                                    cppTime.Text = totalTimeCpp + " milliseconds";
                                }
                            }
                        }
                    }
                    else MessageBox.Show("Please enter a valid number of shades (2-256)", "Invalid Input", (MessageBoxButtons)MessageBoxButton.OK, (MessageBoxIcon)MessageBoxImage.Error);
                }
                else MessageBox.Show("Choose a number please", "Invalid Input", (MessageBoxButtons)MessageBoxButton.OK, (MessageBoxIcon)MessageBoxImage.Error);


            }

            for (int y = 0; y < height; y++)
                for (int x = 0; x < width; x++)
                {
                    bitMapCopy.SetPixel(x, y, System.Drawing.Color.FromArgb((int)outBMPAsm[y*width + x].r, (int)outBMPAsm[y * width + x].g , (int)outBMPAsm[y * width + x].b));

                }
            PictureBox2.Source = ToBitmapImage(bitMapCopy);

            for (int y = 0; y < height; y++)
                for (int x = 0; x < width; x++)
                {
                    bitMapCopy.SetPixel(x, y, System.Drawing.Color.FromArgb((int)outBMPCpp[y * width + x].r, (int)outBMPCpp[y * width + x].g, (int)outBMPCpp[y * width + x].b));

                }
            PictureBox3.Source = ToBitmapImage(bitMapCopy);

        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            OpenFileDialog openFile = new OpenFileDialog();
            if (openFile.ShowDialog() == System.Windows.Forms.DialogResult.OK)
            {
                Uri fileUri = new Uri(openFile.FileName);
                var fileExt = System.IO.Path.GetExtension(fileUri.LocalPath);
                if (fileExt == ".jpg" || fileExt == ".png")
                {
                    PictureBox1.Source = new BitmapImage(fileUri);
                }
                else
                {
                    MessageBox.Show("Upload only .jpg or .png files", "Invalid Image", (MessageBoxButtons)MessageBoxButton.OK, (MessageBoxIcon)MessageBoxImage.Error);
                }
            }
        }

        public bool ProccesImage(Bitmap bmp){


            for (int i = 0; i < bmp.Width; i++) {
                for (int j = 0; j < bmp.Height; j++) {
                    System.Drawing.Color bmpColor = bmp.GetPixel(i, j);
                    float red = bmpColor.R;
                    float green = bmpColor.G;
                    float blue = bmpColor.B;
                    int gray = (int) (0.299 * red + .587 * green + .114 * blue);
                    bmp.SetPixel(i, j, System.Drawing.Color.FromArgb(gray, gray, gray));
                }
            }

            return true;
        }
        private Bitmap BitmapImage2Bitmap(BitmapImage bitmapImage)
        {
            // BitmapImage bitmapImage = new BitmapImage(new Uri("../Images/test.png", UriKind.Relative));

            using (MemoryStream outStream = new MemoryStream())
            {
                BitmapEncoder enc = new BmpBitmapEncoder();
                enc.Frames.Add(BitmapFrame.Create(bitmapImage));
                enc.Save(outStream);
                System.Drawing.Bitmap bitmap = new System.Drawing.Bitmap(outStream);

                return new Bitmap(bitmap);
            }
        }



        public  BitmapImage ToBitmapImage(Bitmap bitmap)
        {
            using (var memory = new MemoryStream())
            {
                bitmap.Save(memory, ImageFormat.Png);
                memory.Position = 0;

                var bitmapImage = new BitmapImage();
                bitmapImage.BeginInit();
                bitmapImage.StreamSource = memory;
                bitmapImage.CacheOption = BitmapCacheOption.OnLoad;
                bitmapImage.EndInit();
                bitmapImage.Freeze();

                return bitmapImage;
            }
        }
  
    }
}
