   M S B A M L   `   `   `  ????G  CGrayScaleApp, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null+clr-namespace:GrayScaleAppGrayScaleApp  5   	       GrayScaleApp.MainWindow   5   	   W SPresentationCore, Version=5.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=5.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=5.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089R NWindowsBase, Version=5.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35^ ZWindowsFormsIntegration, Version=5.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35H 9http://schemas.microsoft.com/winfx/2006/xaml/presentation      5   	   R NSystem.Xaml, Version=5.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   ,localclr-namespace:GrayScaleApp     5   	     ? Title$  
MainWindow??5   	   $	??798??6   $	??809??6)   .??5	      ?  ? ColumnDefinitions 5
   
   ?? 5      $	??48* ?6   ?? 5      $	??85* ?6   ?? 5      $	??67* ?6   .+?5   
   ?? -   5         ??Name$ PictureBox1??5      $
??Left=?6%   $	??282??6@   $??	16,10,0,0q?6M   $	??Top=?6`   $	??375??6x   $??2??6?   ?? 5   
   -   5        $ PictureBox2??5      $
??Left=?6%   $	??282??6@   $??
227,10,0,0q?6M   $	??Top=?6a   $	??375??6y   $??1??6?   $??2??6?   ?? 5   
   -   5         ??Name$ button1??5      $??Browse??6"   $
??Left=?63   $??163,320,0,0q?6N   $	??Top=?6c   $??44??6{   $	??100??6?   $??2??6?   ?? 5   
   -   5        $ button2??5      $??	Grayscale??6"   $
??Left=?66   $??336,320,0,0q?6Q   $	??Top=?6f   $??44??6~   $	??100??6?   $??1??6?   $??2??6?   ?? 5   
   -   5         ??Name$ 	textBlock??5      $
??Left=?6'   $??
38,400,0,0q?6B   $
??Wrap=?6V   $??C# Time:??6j   $	??Top=?6z   ?? 5   
   -   5        $ cTime??5      $
??Left=?6#   $??
88,400,0,0q?6>   $
??Wrap=?6R   $?? ??6f   $	??Top=?6n   ?? 5   
   -   5        $ 
textBlock1??5      $
??Left=?6(   $??
24,400,0,0q?6C   $
??Wrap=?6W   $??AsmTime:??6k   $	??Top=?6{   $??54??6?   $??1??6?   ?? 5   
   -   5        $ asmTime??5      $
??Left=?6%   $??
84,400,0,0q?6@   $
??Wrap=?6T   $?? ??6h   $	??Top=?6p   $??1??6?   ?? 5   
   $??38,440,0,10q?6    J? RenderTransformOrigin$ 0.5,0.5&?6*   z?5      V? 5      .~?5      ??  ?? ScaleY$ 1Q?6%   ?? 5      ?? 5      T? 5      5      .+?5!      	? -	   5         	?Name$ radioButton1??5!       	? 	GroupName$ group1??60   $??Algorithm 1??6C   	 d? 	IsChecked$
	 TrueY?6Y   	? 5"      -
   5        $ radioButton2??5"      $ group1??60   $??Algorithm 2??6C   	? 5#      -   5        $ radioButton3??5#      $ group1??60   $??Algorithm 3??6C   5$   5   5%      ?? 5&   
   -   5        
 ??Name$
 shadesPanel??5&      $??194,440,150,241q?6*   $ 0.525,0.469&?6C   $y?	Collapsed=?6g   $??2??6   .+?5(      ?? $??Shades number: (2-256)??6   ?? 5)      -   5         ??Name$ shadesTextBox??5)      5*      5+      5,      