# GrayScaleAsm
Grayscale algorithm is about switching the original colors from an image to ones representing only the amount of light. The colors possible to obtain in such an image vary from white to black. The amount of light goes from 0%, that is black color to 100%, that is white color.

All grayscale algorithms use the same basic three-step process: Get the red, green, and blue values of a pixel. Use fancy math to turn those numbers into a single gray value. Replace the original red, green, and blue values with the new gray value.

The method to be implemented is called correcting for the human eye. It takes into account that the cone density is different for different colors. During evolution humans developed great sensitivity for green light, a bit lower for the blue one and significantly lower for red light.

Algorithms used:

1. Grayscale = 0.2126R + 0.7152G + 0.0722B$

2. Grayscale = $Max(R,G,B) + Min(R,G,B) \over 2$

3. Grayscale = $Int({AverageValue \over 2}) + CoversionFactor$

      CoversionFactor = $255 \over {NumberOfShades - 1}$
      
      AverageValue = ${R+G+B} \over 3$

      NumberOfShades is a value between 2 and 256, chosen by a user
