.data
Consts real4 2 dup(0.2, 0.7, 0.07, 1.0)
dividebytwo real4 4 dup(2.0f) 
AlphaMask dd 2 dup(0,0,0,0ffffffffh);
NegAlphaMask dd 2 dup(0ffffffffh,0ffffffffh,0ffffffffh,0); Mask for the alpha channel negated
tmp dd ?
constAlg3 dd 255
res real4 ?
three real4 3.0
counter DB 0
testvar dd 0.1
.code

;Structs registers instructions

;shufps to brodcast to all the floats
;

 ;getGrayScaleAsm(
 ;Pixel* inBMP, RCX
 ;Pixel* outBMP,RDX
 ;size R8

getGrayScaleAsm1 proc
	shr R8, 1; Dividing the size by two
MainLoop:
	vmovups	ymm0 , ymmword ptr[rcx]; Moving the pixels values from input array to ymm0 register
	vandps	ymm1 ,ymm0 ,[AlphaMask]; Saving the value of AlphaChannel to ymm1 register
	vmulps ymm0, ymm0, [Consts]; Multiplying the RGB values of pixels by constants

	vandps	ymm0 , ymm0, [NegAlphaMask] ;Making AlphaChannel to be 0


	VHADDPS ymm0 , ymm0 , ymm0
	VHADDPS ymm0 , ymm0 ,ymm0; Adding two times horizontally the values so that the sum of RGB coefficients is obtained
	vorps	ymm0 ,ymm1 , ymm0; restoring the AlphaChannel
	vmovups	ymmword ptr[rdx], ymm0

	add rcx , 32; moving by two pixels
	add rdx , 32; moving by two pixels
	dec R8
	jnz  MainLoop
	;to check if the r8 is 0 after its divided 2 jnz
	ret
getGrayScaleAsm1 endp

 ;getGrayScaleAsm(
 ;Pixel* inBMP, RCX
 ;Pixel* outBMP,RDX
 ;size R8

getGrayScaleAsm2 proc
	shr R8, 2; Dividing the size by two
MainLoop:
	vmovups	ymm0 , ymmword ptr[rcx]
	;Moving the pixels values from input image to ymm0 register
	;xmm1 -red, xmm2-green, xmm3-blue

InterMainLoop:
	vpextrd [tmp], xmm0, 0
	vpinsrd	xmm1, xmm1, [tmp], 0
	;Extracting red value of first pixel 
	;into tmp and inserts it onto the first place of xmm1 register 
	vpextrd [tmp], xmm0, 1
	vpinsrd	xmm2, xmm2, [tmp], 0
	;Extracting green value of first pixel 
	;into tmp and inserts it onto the first place of xmm1 register 
	vpextrd [tmp], xmm0, 2 ;b pixel 1
	vpinsrd	xmm3, xmm3, [tmp], 0
		;Extracting green value of first pixel 
	;into tmp and inserts it onto the first place of xmm1 register 
	VEXTRACTF128 xmm0, ymm0, 1
	;Going to the next pixel
	vpextrd [tmp], xmm0, 0 
	vpinsrd	xmm1, xmm1, [tmp], 1
	vpextrd [tmp], xmm0, 1 
	vpinsrd	xmm2, xmm2, [tmp], 1
	vpextrd [tmp], xmm0, 2 
	vpinsrd	xmm3, xmm3, [tmp], 1

	add rcx, 32 ; moving two pixels

	vmovups	ymm0 , ymmword ptr[rcx]
	vpextrd [tmp], xmm0, 0 
	vpinsrd	xmm1, xmm1, [tmp], 2
	vpextrd [tmp], xmm0, 1 
	vpinsrd	xmm2, xmm2, [tmp], 2
	vpextrd [tmp], xmm0, 2 
	vpinsrd	xmm3, xmm3, [tmp], 2

	VEXTRACTF128 xmm0, ymm0, 1

	vpextrd [tmp], xmm0, 0 ;r pixel 1
	vpinsrd	xmm1, xmm1, [tmp], 3
	vpextrd [tmp], xmm0, 1 ;r pixel 1
	vpinsrd	xmm2, xmm2, [tmp], 3
	vpextrd [tmp], xmm0, 2 ;r pixel 1
	vpinsrd	xmm3, xmm3, [tmp], 3
	;vinsertf128 ymm0 , ymm0, xmm1, 1
	;[r,r,r,r]
	;[g,g,g,g]
	;[b,b,b,b]

	vmaxps xmm4, xmm1, xmm2
	vmaxps xmm4, xmm4, xmm3

	vminps xmm5, xmm1, xmm2
	vminps xmm5, xmm5, xmm3

	vaddps xmm4, xmm4, xmm5
	divps xmm4, [dividebytwo]

	vpextrd [tmp], xmm4, 0
	VBROADCASTSS xmm0, [tmp]
	vpextrd [tmp], xmm4, 1
	VBROADCASTSS xmm1, [tmp]

	vinsertf128 ymm0, ymm0, xmm1, 1

	vmovups	ymmword ptr[rdx], ymm0
	add rdx, 32

	vpextrd [tmp], xmm4, 2;r pixel 1
	VBROADCASTSS xmm0, [tmp]
	vpextrd [tmp], xmm4, 3 
	VBROADCASTSS xmm1, [tmp]

	vinsertf128 ymm0, ymm0, xmm1, 1

	vmovups	ymmword ptr[rdx], ymm0

	add rcx , 32
	add rdx , 32
	dec R8
	jnz  MainLoop
	ret
getGrayScaleAsm2 endp

 ;getGrayScaleAsm(
 ;Pixel* inBMP, RCX
 ;Pixel* outBMP,RDX
 ;size R8
 ;ShadesNumber R9 

getGrayScaleAsm3 proc
	shr R8, 1
	dec r9d
	mov [tmp] , R9d
	fld dword ptr [constAlg3]; st(0) = 255
	fld dword ptr [tmp]; st(0) = shades -1 , st(1) = 255
	fdivp
	fstp  [res]
	vpbroadcastd ymm3, three
	vpbroadcastd ymm4, res
	MainLoop: 
	vmovups	ymm0 , ymmword ptr[rcx]
	vandps	ymm1 ,ymm0 ,[AlphaMask]
	vandps	ymm0 , ymm0, [NegAlphaMask]
	VHADDPS ymm0 , ymm0 , ymm0
	VHADDPS ymm0 , ymm0 , ymm0
	vdivps ymm0 , ymm0,  ymm3
	vdivps	ymm0 , ymm0 , ymm4
	VROUNDPS	ymm0 , ymm0 , 0
	vmulps	ymm0 , ymm0 , ymm4
	vmovups	ymmword ptr[rdx], ymm0
	add rcx , 32
	add rdx , 32
	dec R8
	jnz  MainLoop
	ret
getGrayScaleAsm3 endp

end


