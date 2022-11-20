.data
Consts real4 2 dup(0.2, 0.7, 0.07, 1.0)
roundings real4 8 dup(0.5)
AlphaMask dd 2 dup(0,0,0,0ffffffffh);
NegAlphaMask dd 2 dup(0ffffffffh,0ffffffffh,0ffffffffh,0); Mask for the alpha channel negated
tmp dd ?
constAlg3 dd 255
conversionFactor dd ?
res real4 ?
three real4 3.0
counter DB 0
testvar real4 0.1
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
	movups	xmm0 , xmmword ptr[rcx]; 1 22 55 88
	mulps  xmm0 , [testvar]
	vpextrd [tmp], xmm0 , 0
	;movups xmm1, [tmp]
	;dec R8
	;jnz  MainLoop
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


