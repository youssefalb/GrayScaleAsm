.data
Consts real4 2 dup(0.2, 0.7, 0.07, 1.0)
AlphaMask dd 2 dup(0,0,0,0ffffffffh);
NegAlphaMask dd 2 dup(0ffffffffh,0ffffffffh,0ffffffffh,0); Mask for the alpha channel negated
tmp dd ?
.code

;Structs registers instructions

;shufps to brodcast to all the floats
;

 ;getGrayScaleAsm(
 ;Pixel* inBMP, RCX
 ;Pixel* outBMP,RDX
 ;size R8

getGrayScaleAsm1 proc
	shr R8, 1
MainLoop:
	vmovups	ymm0 , ymmword ptr[rcx]
	vandps	ymm1 ,ymm0 ,[AlphaMask]
	vmulps ymm0, ymm0, [Consts]
	vandps	ymm0 , ymm0, [NegAlphaMask] 

	VHADDPS ymm0 , ymm0 , ymm0
	VHADDPS ymm0 , ymm0 , ymm0
	vorps	ymm0 ,ymm1 , ymm0
	vmovups	ymmword ptr[rdx], ymm0

	add rcx , 32
	add rdx , 32
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
	shr R8, 1
MainLoop:
	movups	xmm0 , xmmword ptr[rcx]
	movups	xmm1 , xmmword ptr[rcx + 16]
	vpextrd [tmp], xmm0 , 0
	movups xmm1, [tmp]
	dec R8
	jnz  MainLoop
	ret
getGrayScaleAsm2 endp

end