Shader "Chickenlord/Skin/Multilayer SSS Skinshader 1.21" {
Properties {
 _Color ("Layer 1 Color", Color) = (1,1,1,1)
 _Color2 ("Layer 2 Color", Color) = (1,1,1,1)
 _Color3 ("Layer 3 Color", Color) = (1,1,1,1)
 _SpecColor ("Specular Color L3", Color) = (0.5,0.5,0.5,1)
 _SpecColor2 ("Specular Color L3", Color) = (0.5,0.5,0.5,1)
 _SpecColor3 ("Specular Color L3", Color) = (0.5,0.5,0.5,1)
 _Shininess ("Shininess L1", Range(0.01,1)) = 0.078125
 _Shininess2 ("Shininess L2", Range(0.01,1)) = 0.078125
 _Shininess3 ("Shininess L3", Range(0.01,1)) = 0.078125
 _MainTex ("Layer1 Base (RGB) Gloss (A)", 2D) = "white" {}
 _MainTex2 ("Layer2 Base (RGB) Gloss (A)", 2D) = "white" {}
 _MainTex3 ("Layer3 Base (RGB) Gloss (A)", 2D) = "white" {}
 _BumpMap ("Normalmap L1", 2D) = "bump" {}
 _BumpMap2 ("Normalmap L2", 2D) = "bump2" {}
 _BumpMap3 ("Normalmap L3", 2D) = "bump3" {}
 _ScatterMap ("Blend Map 1 to 2 (A)", 2D) = "white" {}
 _BlendAdjust1 ("Blend Adjust 2-1", Range(-1,1)) = 0
 _ScatterMap2 ("Blend Map 2 to 3 (A)", 2D) = "white" {}
 _BlendAdjust2 ("Blend Adjust 3-2", Range(-1,1)) = 0
 _ExitColorMap ("Exit Color Map (RGB) Scattering (A)", 2D) = "ecm" {}
 _ExitColorMultiplier ("Exit Color Displacement Range", Range(0,1)) = 1
 _ExitColorRadius ("Exit Color Ammount", Range(0,6)) = 1
 _Layer1Thickness ("Layer 1 Thickness", Range(0,1)) = 0.1
 _Layer2Thickness ("Layer 2 Thickness", Range(0,1)) = 0.1
 _GVar ("Gauss Variance (Brightness)", Range(0,10)) = 1
 _SpecSmoothing ("Specularity Smoothness", Range(0.1,2)) = 0.707107
 _SSSC ("SSSC", Color) = (1,1,1,1)
 _DDXP ("SSS Power", Float) = 4
 _DDXM ("SSS Multplier", Float) = 5
}
SubShader { 
 LOD 200
 Tags { "RenderType"="Opaque" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "RenderType"="Opaque" }
Program "vp" {
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [unity_Scale]
Vector 14 [_WorldSpaceCameraPos]
Vector 15 [_WorldSpaceLightPos0]
Vector 16 [unity_SHAr]
Vector 17 [unity_SHAg]
Vector 18 [unity_SHAb]
Vector 19 [unity_SHBr]
Vector 20 [unity_SHBg]
Vector 21 [unity_SHBb]
Vector 22 [unity_SHC]
Vector 23 [_MainTex_ST]
Vector 24 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 44 ALU
PARAM c[25] = { { 1 },
		state.matrix.mvp,
		program.local[5..24] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R1.xyz, vertex.normal, c[13].w;
DP3 R2.w, R1, c[6];
DP3 R0.x, R1, c[5];
DP3 R0.z, R1, c[7];
MOV R0.y, R2.w;
MUL R1, R0.xyzz, R0.yzzx;
MOV R0.w, c[0].x;
DP4 R2.z, R0, c[18];
DP4 R2.y, R0, c[17];
DP4 R2.x, R0, c[16];
MUL R0.y, R2.w, R2.w;
DP4 R3.z, R1, c[21];
DP4 R3.y, R1, c[20];
DP4 R3.x, R1, c[19];
ADD R2.xyz, R2, R3;
MAD R0.x, R0, R0, -R0.y;
MUL R3.xyz, R0.x, c[22];
MOV R1.xyz, vertex.attrib[14];
MUL R0.xyz, vertex.normal.zxyw, R1.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R1.zxyw, -R0;
ADD result.texcoord[3].xyz, R2, R3;
MOV R0.xyz, c[14];
MOV R0.w, c[0].x;
DP4 R2.z, R0, c[11];
DP4 R2.x, R0, c[9];
DP4 R2.y, R0, c[10];
MAD R0.xyz, R2, c[13].w, -vertex.position;
MUL R2.xyz, R1, vertex.attrib[14].w;
MOV R1, c[15];
DP4 R3.z, R1, c[11];
DP4 R3.x, R1, c[9];
DP4 R3.y, R1, c[10];
DP3 result.texcoord[1].y, R0, R2;
DP3 result.texcoord[2].y, R2, R3;
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
DP3 result.texcoord[2].z, vertex.normal, R3;
DP3 result.texcoord[2].x, vertex.attrib[14], R3;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[24].xyxy, c[24];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[23], c[23].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 44 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [unity_Scale]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Vector 15 [unity_SHAr]
Vector 16 [unity_SHAg]
Vector 17 [unity_SHAb]
Vector 18 [unity_SHBr]
Vector 19 [unity_SHBg]
Vector 20 [unity_SHBb]
Vector 21 [unity_SHC]
Vector 22 [_MainTex_ST]
Vector 23 [_BumpMap_ST]
"vs_3_0
; 47 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c24, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r1.xyz, v2, c12.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c24.x
dp4 r2.z, r0, c17
dp4 r2.y, r0, c16
dp4 r2.x, r0, c15
mul r0.y, r2.w, r2.w
dp4 r3.z, r1, c20
dp4 r3.y, r1, c19
dp4 r3.x, r1, c18
add r1.xyz, r2, r3
mad r0.x, r0, r0, -r0.y
mul r2.xyz, r0.x, c21
add o4.xyz, r1, r2
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r3.xyz, r0, v1.w
mov r0, c10
dp4 r4.z, c14, r0
mov r0, c9
mov r1.w, c24.x
mov r1.xyz, c13
dp4 r4.y, c14, r0
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c12.w, -v0
mov r1, c8
dp4 r4.x, c14, r1
dp3 o2.y, r2, r3
dp3 o3.y, r3, r4
dp3 o2.z, v2, r2
dp3 o2.x, r2, v1
dp3 o3.z, v2, r4
dp3 o3.x, v1, r4
mad o1.zw, v3.xyxy, c23.xyxy, c23
mad o1.xy, v3, c22, c22.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [_ProjectionParams]
Vector 14 [unity_Scale]
Vector 15 [_WorldSpaceCameraPos]
Vector 16 [_WorldSpaceLightPos0]
Vector 17 [unity_SHAr]
Vector 18 [unity_SHAg]
Vector 19 [unity_SHAb]
Vector 20 [unity_SHBr]
Vector 21 [unity_SHBg]
Vector 22 [unity_SHBb]
Vector 23 [unity_SHC]
Vector 24 [_MainTex_ST]
Vector 25 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 49 ALU
PARAM c[26] = { { 1, 0.5 },
		state.matrix.mvp,
		program.local[5..25] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R1.xyz, vertex.normal, c[14].w;
DP3 R2.w, R1, c[6];
DP3 R0.x, R1, c[5];
DP3 R0.z, R1, c[7];
MOV R0.y, R2.w;
MUL R1, R0.xyzz, R0.yzzx;
MOV R0.w, c[0].x;
DP4 R2.z, R0, c[19];
DP4 R2.y, R0, c[18];
DP4 R2.x, R0, c[17];
MUL R0.y, R2.w, R2.w;
DP4 R3.z, R1, c[22];
DP4 R3.y, R1, c[21];
DP4 R3.x, R1, c[20];
ADD R2.xyz, R2, R3;
MAD R0.x, R0, R0, -R0.y;
MUL R3.xyz, R0.x, c[23];
MOV R1.xyz, vertex.attrib[14];
MUL R0.xyz, vertex.normal.zxyw, R1.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R1.zxyw, -R0;
ADD result.texcoord[3].xyz, R2, R3;
MOV R0.w, c[0].x;
MOV R0.xyz, c[15];
DP4 R2.z, R0, c[11];
DP4 R2.x, R0, c[9];
DP4 R2.y, R0, c[10];
MAD R0.xyz, R2, c[14].w, -vertex.position;
MUL R2.xyz, R1, vertex.attrib[14].w;
MOV R1, c[16];
DP4 R3.z, R1, c[11];
DP4 R3.x, R1, c[9];
DP4 R3.y, R1, c[10];
DP3 result.texcoord[1].y, R0, R2;
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[13].x;
DP3 result.texcoord[2].y, R2, R3;
DP3 result.texcoord[2].z, vertex.normal, R3;
DP3 result.texcoord[2].x, vertex.attrib[14], R3;
ADD result.texcoord[4].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[4].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[25].xyxy, c[25];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[24], c[24].zwzw;
END
# 49 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [_ProjectionParams]
Vector 13 [_ScreenParams]
Vector 14 [unity_Scale]
Vector 15 [_WorldSpaceCameraPos]
Vector 16 [_WorldSpaceLightPos0]
Vector 17 [unity_SHAr]
Vector 18 [unity_SHAg]
Vector 19 [unity_SHAb]
Vector 20 [unity_SHBr]
Vector 21 [unity_SHBg]
Vector 22 [unity_SHBb]
Vector 23 [unity_SHC]
Vector 24 [_MainTex_ST]
Vector 25 [_BumpMap_ST]
"vs_3_0
; 52 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c26, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r1.xyz, v2, c14.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c26.x
dp4 r2.z, r0, c19
dp4 r2.y, r0, c18
dp4 r2.x, r0, c17
mul r0.y, r2.w, r2.w
dp4 r3.z, r1, c22
dp4 r3.y, r1, c21
dp4 r3.x, r1, c20
add r1.xyz, r2, r3
mad r0.x, r0, r0, -r0.y
mul r2.xyz, r0.x, c23
add o4.xyz, r1, r2
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r3.xyz, r0, v1.w
mov r0, c10
dp4 r4.z, c16, r0
mov r0, c9
dp4 r4.y, c16, r0
mov r1.w, c26.x
mov r1.xyz, c15
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c14.w, -v0
mov r1, c8
dp4 r4.x, c16, r1
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c26.y
mul r1.y, r1, c12.x
dp3 o2.y, r2, r3
dp3 o3.y, r3, r4
dp3 o2.z, v2, r2
dp3 o2.x, r2, v1
dp3 o3.z, v2, r4
dp3 o3.x, v1, r4
mad o5.xy, r1.z, c13.zwzw, r1
mov o0, r0
mov o5.zw, r0
mad o1.zw, v3.xyxy, c25.xyxy, c25
mad o1.xy, v3, c24, c24.zwzw
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [unity_Scale]
Vector 14 [_WorldSpaceCameraPos]
Vector 15 [_WorldSpaceLightPos0]
Vector 16 [unity_4LightPosX0]
Vector 17 [unity_4LightPosY0]
Vector 18 [unity_4LightPosZ0]
Vector 19 [unity_4LightAtten0]
Vector 20 [unity_LightColor0]
Vector 21 [unity_LightColor1]
Vector 22 [unity_LightColor2]
Vector 23 [unity_LightColor3]
Vector 24 [unity_SHAr]
Vector 25 [unity_SHAg]
Vector 26 [unity_SHAb]
Vector 27 [unity_SHBr]
Vector 28 [unity_SHBg]
Vector 29 [unity_SHBb]
Vector 30 [unity_SHC]
Vector 31 [_MainTex_ST]
Vector 32 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 75 ALU
PARAM c[33] = { { 1, 0 },
		state.matrix.mvp,
		program.local[5..32] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MUL R3.xyz, vertex.normal, c[13].w;
DP4 R0.x, vertex.position, c[6];
ADD R1, -R0.x, c[17];
DP3 R3.w, R3, c[6];
DP3 R4.x, R3, c[5];
DP3 R3.x, R3, c[7];
MUL R2, R3.w, R1;
DP4 R0.x, vertex.position, c[5];
ADD R0, -R0.x, c[16];
MUL R1, R1, R1;
MOV R4.z, R3.x;
MAD R2, R4.x, R0, R2;
MOV R4.w, c[0].x;
DP4 R4.y, vertex.position, c[7];
MAD R1, R0, R0, R1;
ADD R0, -R4.y, c[18];
MAD R1, R0, R0, R1;
MAD R0, R3.x, R0, R2;
MUL R2, R1, c[19];
MOV R4.y, R3.w;
RSQ R1.x, R1.x;
RSQ R1.y, R1.y;
RSQ R1.w, R1.w;
RSQ R1.z, R1.z;
MUL R0, R0, R1;
ADD R1, R2, c[0].x;
RCP R1.x, R1.x;
RCP R1.y, R1.y;
RCP R1.w, R1.w;
RCP R1.z, R1.z;
MAX R0, R0, c[0].y;
MUL R0, R0, R1;
MUL R1.xyz, R0.y, c[21];
MAD R1.xyz, R0.x, c[20], R1;
MAD R0.xyz, R0.z, c[22], R1;
MAD R1.xyz, R0.w, c[23], R0;
MUL R0, R4.xyzz, R4.yzzx;
DP4 R3.z, R0, c[29];
DP4 R3.y, R0, c[28];
DP4 R3.x, R0, c[27];
MUL R1.w, R3, R3;
MAD R0.x, R4, R4, -R1.w;
MOV R0.w, c[0].x;
DP4 R2.z, R4, c[26];
DP4 R2.y, R4, c[25];
DP4 R2.x, R4, c[24];
ADD R2.xyz, R2, R3;
MUL R3.xyz, R0.x, c[30];
ADD R3.xyz, R2, R3;
MOV R0.xyz, vertex.attrib[14];
MUL R2.xyz, vertex.normal.zxyw, R0.yzxw;
ADD result.texcoord[3].xyz, R3, R1;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R2;
MOV R0.xyz, c[14];
DP4 R2.z, R0, c[11];
DP4 R2.x, R0, c[9];
DP4 R2.y, R0, c[10];
MAD R0.xyz, R2, c[13].w, -vertex.position;
MUL R2.xyz, R1, vertex.attrib[14].w;
MOV R1, c[15];
DP4 R3.z, R1, c[11];
DP4 R3.x, R1, c[9];
DP4 R3.y, R1, c[10];
DP3 result.texcoord[1].y, R0, R2;
DP3 result.texcoord[2].y, R2, R3;
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
DP3 result.texcoord[2].z, vertex.normal, R3;
DP3 result.texcoord[2].x, vertex.attrib[14], R3;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[32].xyxy, c[32];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[31], c[31].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 75 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [unity_Scale]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Vector 15 [unity_4LightPosX0]
Vector 16 [unity_4LightPosY0]
Vector 17 [unity_4LightPosZ0]
Vector 18 [unity_4LightAtten0]
Vector 19 [unity_LightColor0]
Vector 20 [unity_LightColor1]
Vector 21 [unity_LightColor2]
Vector 22 [unity_LightColor3]
Vector 23 [unity_SHAr]
Vector 24 [unity_SHAg]
Vector 25 [unity_SHAb]
Vector 26 [unity_SHBr]
Vector 27 [unity_SHBg]
Vector 28 [unity_SHBb]
Vector 29 [unity_SHC]
Vector 30 [_MainTex_ST]
Vector 31 [_BumpMap_ST]
"vs_3_0
; 78 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c32, 1.00000000, 0.00000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r3.xyz, v2, c12.w
dp4 r0.x, v0, c5
add r1, -r0.x, c16
dp3 r3.w, r3, c5
dp3 r4.x, r3, c4
dp3 r3.x, r3, c6
mul r2, r3.w, r1
dp4 r0.x, v0, c4
add r0, -r0.x, c15
mul r1, r1, r1
mov r4.z, r3.x
mad r2, r4.x, r0, r2
mov r4.w, c32.x
dp4 r4.y, v0, c6
mad r1, r0, r0, r1
add r0, -r4.y, c17
mad r1, r0, r0, r1
mad r0, r3.x, r0, r2
mul r2, r1, c18
mov r4.y, r3.w
rsq r1.x, r1.x
rsq r1.y, r1.y
rsq r1.w, r1.w
rsq r1.z, r1.z
mul r0, r0, r1
add r1, r2, c32.x
dp4 r2.z, r4, c25
dp4 r2.y, r4, c24
dp4 r2.x, r4, c23
rcp r1.x, r1.x
rcp r1.y, r1.y
rcp r1.w, r1.w
rcp r1.z, r1.z
max r0, r0, c32.y
mul r0, r0, r1
mul r1.xyz, r0.y, c20
mad r1.xyz, r0.x, c19, r1
mad r0.xyz, r0.z, c21, r1
mad r1.xyz, r0.w, c22, r0
mul r0, r4.xyzz, r4.yzzx
mul r1.w, r3, r3
dp4 r3.z, r0, c28
dp4 r3.y, r0, c27
dp4 r3.x, r0, c26
mad r1.w, r4.x, r4.x, -r1
mul r0.xyz, r1.w, c29
add r2.xyz, r2, r3
add r2.xyz, r2, r0
add o4.xyz, r2, r1
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r3.xyz, r0, v1.w
mov r0, c10
dp4 r4.z, c14, r0
mov r0, c9
mov r1.w, c32.x
mov r1.xyz, c13
dp4 r4.y, c14, r0
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c12.w, -v0
mov r1, c8
dp4 r4.x, c14, r1
dp3 o2.y, r2, r3
dp3 o3.y, r3, r4
dp3 o2.z, v2, r2
dp3 o2.x, r2, v1
dp3 o3.z, v2, r4
dp3 o3.x, v1, r4
mad o1.zw, v3.xyxy, c31.xyxy, c31
mad o1.xy, v3, c30, c30.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [_ProjectionParams]
Vector 14 [unity_Scale]
Vector 15 [_WorldSpaceCameraPos]
Vector 16 [_WorldSpaceLightPos0]
Vector 17 [unity_4LightPosX0]
Vector 18 [unity_4LightPosY0]
Vector 19 [unity_4LightPosZ0]
Vector 20 [unity_4LightAtten0]
Vector 21 [unity_LightColor0]
Vector 22 [unity_LightColor1]
Vector 23 [unity_LightColor2]
Vector 24 [unity_LightColor3]
Vector 25 [unity_SHAr]
Vector 26 [unity_SHAg]
Vector 27 [unity_SHAb]
Vector 28 [unity_SHBr]
Vector 29 [unity_SHBg]
Vector 30 [unity_SHBb]
Vector 31 [unity_SHC]
Vector 32 [_MainTex_ST]
Vector 33 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 80 ALU
PARAM c[34] = { { 1, 0, 0.5 },
		state.matrix.mvp,
		program.local[5..33] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MUL R3.xyz, vertex.normal, c[14].w;
DP4 R0.x, vertex.position, c[6];
ADD R1, -R0.x, c[18];
DP3 R3.w, R3, c[6];
DP3 R4.x, R3, c[5];
DP3 R3.x, R3, c[7];
MUL R2, R3.w, R1;
DP4 R0.x, vertex.position, c[5];
ADD R0, -R0.x, c[17];
MUL R1, R1, R1;
MOV R4.z, R3.x;
MAD R2, R4.x, R0, R2;
MOV R4.w, c[0].x;
DP4 R4.y, vertex.position, c[7];
MAD R1, R0, R0, R1;
ADD R0, -R4.y, c[19];
MAD R1, R0, R0, R1;
MAD R0, R3.x, R0, R2;
MUL R2, R1, c[20];
MOV R4.y, R3.w;
RSQ R1.x, R1.x;
RSQ R1.y, R1.y;
RSQ R1.w, R1.w;
RSQ R1.z, R1.z;
MUL R0, R0, R1;
ADD R1, R2, c[0].x;
RCP R1.x, R1.x;
RCP R1.y, R1.y;
RCP R1.w, R1.w;
RCP R1.z, R1.z;
MAX R0, R0, c[0].y;
MUL R0, R0, R1;
MUL R1.xyz, R0.y, c[22];
MAD R1.xyz, R0.x, c[21], R1;
MAD R0.xyz, R0.z, c[23], R1;
MAD R1.xyz, R0.w, c[24], R0;
MUL R0, R4.xyzz, R4.yzzx;
DP4 R3.z, R0, c[30];
DP4 R3.y, R0, c[29];
DP4 R3.x, R0, c[28];
MUL R1.w, R3, R3;
MOV R0.w, c[0].x;
MAD R0.x, R4, R4, -R1.w;
DP4 R2.z, R4, c[27];
DP4 R2.y, R4, c[26];
DP4 R2.x, R4, c[25];
ADD R2.xyz, R2, R3;
MUL R3.xyz, R0.x, c[31];
ADD R3.xyz, R2, R3;
MOV R0.xyz, vertex.attrib[14];
MUL R2.xyz, vertex.normal.zxyw, R0.yzxw;
ADD result.texcoord[3].xyz, R3, R1;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R2;
MOV R0.xyz, c[15];
DP4 R2.z, R0, c[11];
DP4 R2.x, R0, c[9];
DP4 R2.y, R0, c[10];
MAD R0.xyz, R2, c[14].w, -vertex.position;
MUL R2.xyz, R1, vertex.attrib[14].w;
MOV R1, c[16];
DP4 R3.z, R1, c[11];
DP4 R3.x, R1, c[9];
DP4 R3.y, R1, c[10];
DP3 result.texcoord[1].y, R0, R2;
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].z;
MUL R1.y, R1, c[13].x;
DP3 result.texcoord[2].y, R2, R3;
DP3 result.texcoord[2].z, vertex.normal, R3;
DP3 result.texcoord[2].x, vertex.attrib[14], R3;
ADD result.texcoord[4].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[4].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[33].xyxy, c[33];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[32], c[32].zwzw;
END
# 80 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [_ProjectionParams]
Vector 13 [_ScreenParams]
Vector 14 [unity_Scale]
Vector 15 [_WorldSpaceCameraPos]
Vector 16 [_WorldSpaceLightPos0]
Vector 17 [unity_4LightPosX0]
Vector 18 [unity_4LightPosY0]
Vector 19 [unity_4LightPosZ0]
Vector 20 [unity_4LightAtten0]
Vector 21 [unity_LightColor0]
Vector 22 [unity_LightColor1]
Vector 23 [unity_LightColor2]
Vector 24 [unity_LightColor3]
Vector 25 [unity_SHAr]
Vector 26 [unity_SHAg]
Vector 27 [unity_SHAb]
Vector 28 [unity_SHBr]
Vector 29 [unity_SHBg]
Vector 30 [unity_SHBb]
Vector 31 [unity_SHC]
Vector 32 [_MainTex_ST]
Vector 33 [_BumpMap_ST]
"vs_3_0
; 83 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c34, 1.00000000, 0.00000000, 0.50000000, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r3.xyz, v2, c14.w
dp4 r0.x, v0, c5
add r1, -r0.x, c18
dp3 r3.w, r3, c5
dp3 r4.x, r3, c4
dp3 r3.x, r3, c6
mul r2, r3.w, r1
dp4 r0.x, v0, c4
add r0, -r0.x, c17
mul r1, r1, r1
mov r4.z, r3.x
mad r2, r4.x, r0, r2
mov r4.w, c34.x
dp4 r4.y, v0, c6
mad r1, r0, r0, r1
add r0, -r4.y, c19
mad r1, r0, r0, r1
mad r0, r3.x, r0, r2
mul r2, r1, c20
mov r4.y, r3.w
rsq r1.x, r1.x
rsq r1.y, r1.y
rsq r1.w, r1.w
rsq r1.z, r1.z
mul r0, r0, r1
add r1, r2, c34.x
dp4 r2.z, r4, c27
dp4 r2.y, r4, c26
dp4 r2.x, r4, c25
rcp r1.x, r1.x
rcp r1.y, r1.y
rcp r1.w, r1.w
rcp r1.z, r1.z
max r0, r0, c34.y
mul r0, r0, r1
mul r1.xyz, r0.y, c22
mad r1.xyz, r0.x, c21, r1
mad r0.xyz, r0.z, c23, r1
mad r1.xyz, r0.w, c24, r0
mul r0, r4.xyzz, r4.yzzx
mul r1.w, r3, r3
dp4 r3.z, r0, c30
dp4 r3.y, r0, c29
dp4 r3.x, r0, c28
mad r1.w, r4.x, r4.x, -r1
mul r0.xyz, r1.w, c31
add r2.xyz, r2, r3
add r2.xyz, r2, r0
add o4.xyz, r2, r1
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r3.xyz, r0, v1.w
mov r0, c10
dp4 r4.z, c16, r0
mov r0, c9
dp4 r4.y, c16, r0
mov r1.w, c34.x
mov r1.xyz, c15
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c14.w, -v0
mov r1, c8
dp4 r4.x, c16, r1
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c34.z
mul r1.y, r1, c12.x
dp3 o2.y, r2, r3
dp3 o3.y, r3, r4
dp3 o2.z, v2, r2
dp3 o2.x, r2, v1
dp3 o3.z, v2, r4
dp3 o3.x, v1, r4
mad o5.xy, r1.z, c13.zwzw, r1
mov o0, r0
mov o5.zw, r0
mad o1.zw, v3.xyxy, c33.xyxy, c33
mad o1.xy, v3, c32, c32.zwzw
"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color3]
Float 3 [_Shininess3]
Vector 4 [_SpecColor3]
Float 5 [_Layer1Thickness]
Float 6 [_Layer2Thickness]
Float 7 [_GVar]
Float 8 [_ExitColorMultiplier]
Float 9 [_ExitColorRadius]
Float 10 [_SpecSmoothing]
Vector 11 [_Color2]
Float 12 [_Shininess2]
Vector 13 [_SpecColor2]
Float 14 [_BlendAdjust2]
Vector 15 [_Color]
Float 16 [_Shininess]
Float 17 [_BlendAdjust1]
Float 18 [_DDXP]
Float 19 [_DDXM]
Vector 20 [_SSSC]
SetTexture 0 [_MainTex3] 2D
SetTexture 1 [_ScatterMap] 2D
SetTexture 2 [_MainTex] 2D
SetTexture 3 [_BumpMap] 2D
SetTexture 4 [_MainTex2] 2D
SetTexture 5 [_ScatterMap2] 2D
SetTexture 6 [_BumpMap3] 2D
SetTexture 7 [_ExitColorMap] 2D
SetTexture 8 [_BumpMap2] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 319 ALU, 10 TEX
PARAM c[27] = { program.local[0..20],
		{ 1, 2, 0.73550957, -0.73550957 },
		{ 0, -1, 0.99270076, -0.99270076 },
		{ 2.718282, 2, 0, 0.5 },
		{ 0.39894229, 3.141593, -0.018729299, 0.074261002 },
		{ 0.21211439, 1.570729, 3.1415927, 5 },
		{ 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEMP R7;
TEMP R8;
TEMP R9;
MUL R0.x, fragment.texcoord[2].y, fragment.texcoord[2].y;
MAD R0.x, fragment.texcoord[2], fragment.texcoord[2], R0;
MAD R0.x, fragment.texcoord[2].z, fragment.texcoord[2].z, R0;
RSQ R2.w, R0.x;
MUL R0.y, R2.w, -fragment.texcoord[2].z;
MUL R0.x, R0.y, c[21].z;
COS R0.z, R0.x;
MAD R0.y, R0, c[21].w, R0.z;
DP3 R0.x, fragment.texcoord[2], fragment.texcoord[2];
MUL R1.xy, R0.y, c[22];
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, fragment.texcoord[2];
MAD R2.xyz, R0, c[21].z, R1.xxyw;
MUL R0.x, R2.y, R2.y;
MAD R0.x, R2, R2, R0;
MAD R0.x, R2.z, R2.z, R0;
RSQ R0.x, R0.x;
MUL R0.y, R0.x, -R2.z;
MUL R0.x, R0.y, c[22].z;
COS R0.z, R0.x;
MAD R0.y, R0, c[22].w, R0.z;
DP3 R0.x, R2, R2;
RSQ R0.x, R0.x;
MUL R3.xyz, R0.x, R2;
MUL R0.zw, R0.y, c[22].xyxy;
MAD R0.xyz, R3, c[22].z, R0.zzww;
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R1.xyz, R0.w, R0;
ADD R0.xyz, -R0, fragment.texcoord[2];
MAD R4.xyz, -R3, c[5].x, fragment.texcoord[2];
MAD R1.xyz, -R1, c[6].x, R4;
DP3 R0.w, R1, R1;
RSQ R0.w, R0.w;
MUL R7.xyz, R0.w, R1;
TEX R4.yw, fragment.texcoord[0].zwzw, texture[6], 2D;
MUL R3.w, R0.y, R0.y;
DP3 R0.w, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.w, R0.w;
MUL R5.xyz, R0.w, fragment.texcoord[1];
MAD R4.xy, R4.wyzw, c[21].y, -c[21].x;
ADD R6.xyz, R7, R5;
MUL R0.w, R4.y, R4.y;
MAD R0.w, -R4.x, R4.x, -R0;
DP3 R1.w, R6, R6;
RSQ R1.w, R1.w;
ADD R0.w, R0, c[21].x;
RSQ R0.w, R0.w;
RCP R4.z, R0.w;
MUL R6.xyz, R1.w, R6;
DP3 R5.w, R4, R6;
ABS R1.w, R5;
MAD R0.w, R1, c[24].z, c[24];
MAD R0.w, R0, R1, -c[25].x;
MAD R0.w, R0, R1, c[25].y;
ADD R1.w, -R1, c[21].x;
RSQ R1.w, R1.w;
RCP R1.w, R1.w;
ADD R2.xyz, -R2, fragment.texcoord[2];
DP3 R0.y, R4, R7;
MAD R3.w, R0.x, R0.x, R3;
MAX R0.x, R0.y, c[22];
MAD R0.y, R0.z, R0.z, R3.w;
MOV R0.z, c[5].x;
RSQ R0.y, R0.y;
ADD R0.z, -R0, -c[6].x;
RCP R0.y, R0.y;
MUL R6.w, R0, R1;
MUL R9.xyz, R3, c[5].x;
MUL R0.y, R0, c[7].x;
ADD R0.z, R0, c[23].y;
MUL R0.z, R0.y, R0;
MUL R0.y, R0.x, R0.x;
MUL R0.y, R0, R0.z;
MUL R0.y, R0, R0.z;
MUL R0.z, R1.y, R1.y;
MAD R0.z, R1.x, R1.x, R0;
MUL R0.y, R0, c[23].w;
POW R0.y, c[23].x, -R0.y;
MUL R0.y, -R0, c[24].x;
ADD R4.w, R0.y, c[21].x;
MAD R0.z, R1, R1, R0;
RSQ R0.y, R0.z;
RCP R0.z, R0.y;
MUL R1.w, R0.x, R4;
ADD R0.xy, R1, -fragment.texcoord[2];
DP3 R1.x, R1, fragment.texcoord[2];
MUL R0.z, R2.w, R0;
MUL R0.xy, R0, c[6].x;
MUL R0.xy, R0, R0.z;
ADD_SAT R0.z, -R1.w, c[21].x;
POW R3.w, R0.z, c[18].x;
MAD R0.xy, -R0, c[8].x, fragment.texcoord[0];
TEX R0, R0, texture[7], 2D;
MUL R3.w, R3, c[19].x;
MUL_SAT R7.w, R3, R0;
MUL R7.xyz, R7.w, R0;
SLT R3.w, R5, c[22].x;
MUL R0.w, R3, R6;
MAD R6.w, -R0, c[21].y, R6;
MAD R3.w, R3, c[24].y, R6;
MUL R6.w, c[10].x, c[10].x;
MUL_SAT R1.x, R1, c[9];
MUL R0.xyz, R0, c[0];
MUL R0.xyz, R1.x, R0;
ADD R1.x, -R1, c[21];
MAD R0.xyz, R1.x, c[0], R0;
MUL R1.xyz, R7, c[20];
ADD R7.x, -R7.w, c[21];
MAD R1.xyz, R7.x, R0, R1;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0.xyz, R0, c[2];
MUL R1.xyz, R0, R1;
COS R0.x, R3.w;
MUL R0.x, R0, R0;
MUL R0.z, R0.x, R6.w;
MUL R0.y, R0.x, c[10].x;
MUL R0.z, R0.x, R0;
MUL R0.y, R0, c[10].x;
MOV R3.w, c[26].x;
MOV R7.w, c[21].x;
MUL R0.z, R0, c[25];
RCP R0.y, R0.y;
ADD R0.x, -R0, c[21];
MUL R0.x, R0, R0.y;
RCP R0.y, R0.z;
POW R0.x, c[23].x, -R0.x;
MUL R0.x, R0, R0.y;
ADD R0.y, -R5.w, c[21].x;
ADD R0.z, R7.w, -c[3].x;
POW R0.y, R0.y, c[25].w;
MAD R0.y, R0, c[3].x, R0.z;
MUL R0.x, R0, R0.y;
DP3 R0.z, R4, R5;
RCP R0.y, R0.z;
MUL R0.x, R0.w, R0;
MUL_SAT R8.w, R0.x, R0.y;
DP3 R0.y, R6, R5;
MUL R0.x, R5.w, R0.z;
DP3 R0.z, R4, fragment.texcoord[2];
RCP R0.y, R0.y;
MUL R0.x, R0, R0.y;
MUL R0.z, R5.w, R0;
MUL R0.z, R0.y, R0;
ADD R6.xyz, fragment.texcoord[2], -R9;
MUL R0.y, R0.z, c[21];
MUL R0.x, R0, c[21].y;
MIN_SAT R4.x, R0, R0.y;
MUL R0.y, R3.w, c[3].x;
MAX R0.x, R5.w, c[22];
POW R0.x, R0.x, R0.y;
MUL R4.y, R0.w, R0.x;
DP3 R0.x, R6, R6;
RSQ R0.z, R0.x;
MUL R7.xyz, R0.z, R6;
TEX R0.yw, fragment.texcoord[0].zwzw, texture[8], 2D;
MAD R0.xy, R0.wyzw, c[21].y, -c[21].x;
ADD R3.xyz, R5, R7;
DP3 R0.w, R3, R3;
MUL R0.z, R0.y, R0.y;
MAD R0.z, -R0.x, R0.x, -R0;
RSQ R0.w, R0.w;
MUL R8.xyz, R0.w, R3;
MUL R3.y, R4, c[23].w;
MAD R3.y, R8.w, R4.x, R3;
ADD R0.z, R0, c[21].x;
RSQ R0.z, R0.z;
RCP R0.z, R0.z;
DP3 R0.w, R0, R8;
ABS R3.x, R0.w;
ADD R4.x, -R3, c[21];
MAD R3.z, R3.x, c[24], c[24].w;
MAD R3.z, R3, R3.x, -c[25].x;
RSQ R4.x, R4.x;
MUL_SAT R4.y, R4.w, R3;
RCP R4.x, R4.x;
MAD R3.x, R3.z, R3, c[25].y;
MUL R3.x, R3, R4;
SLT R4.x, R0.w, c[22];
MUL R3.z, R4.x, R3.x;
MAD R4.z, -R3, c[21].y, R3.x;
MAD R4.x, R4, c[24].y, R4.z;
ADD R4.z, R7.w, -c[12].x;
DP3 R7.w, R5, R8;
MOV R3.xyz, c[4];
MUL R3.xyz, R3, c[0];
MUL R3.xyz, R3, R4.y;
MAD R1.xyz, R1, R1.w, R3;
COS R4.x, R4.x;
MUL R1.w, R4.x, R4.x;
MUL R3.xyz, R1, c[21].y;
MUL R1.y, R6.w, R1.w;
MUL R1.x, R1.w, c[10];
MUL R1.z, R1.w, R1.y;
MUL R1.x, R1, c[10];
RCP R1.y, R1.x;
ADD R1.x, -R1.w, c[21];
MUL R1.x, R1, R1.y;
MUL R1.y, R1.z, c[25].z;
ADD R1.z, -R0.w, c[21].x;
RCP R7.w, R7.w;
RCP R1.y, R1.y;
POW R1.x, c[23].x, -R1.x;
MUL R1.x, R1, R1.y;
TEX R1.yw, fragment.texcoord[0].zwzw, texture[3], 2D;
MAD R4.xy, R1.wyzw, c[21].y, -c[21].x;
POW R1.z, R1.z, c[25].w;
MAD R1.y, R1.z, c[12].x, R4.z;
MUL R1.z, R4.y, R4.y;
MAD R4.w, -R4.x, R4.x, -R1.z;
MUL R4.z, R1.x, R1.y;
TEX R1, fragment.texcoord[0], texture[2], 2D;
ADD R5.w, R4, c[21].x;
MUL R4.w, R1, R4.z;
RSQ R4.z, R5.w;
DP3 R5.w, R5, R0;
RCP R4.z, R4.z;
DP3 R6.w, R5, R4;
MUL R6.w, R0, R6;
MUL R6.w, R6, R7;
RCP R5.w, R5.w;
MUL_SAT R5.w, R4, R5;
DP3 R4.w, fragment.texcoord[2], R4;
MUL R8.x, R0.w, R4.w;
MUL R8.x, R7.w, R8;
MUL R7.w, R8.x, c[21].y;
MUL R6.w, R6, c[21].y;
MIN_SAT R6.w, R6, R7;
DP3 R0.x, R0, R7;
MUL R8.x, R2.y, R2.y;
MAX R0.w, R0, c[22].x;
MUL R7.w, R3, c[12].x;
POW R2.y, R0.w, R7.w;
MAD R0.w, R2.x, R2.x, R8.x;
MAD R0.y, R2.z, R2.z, R0.w;
MAX R2.x, R0, c[22];
RSQ R0.x, R0.y;
MOV R0.y, c[21].x;
RCP R0.x, R0.x;
ADD R0.y, R0, -c[5].x;
MUL R0.x, R0, c[7];
MUL R2.z, R0.x, R0.y;
MUL R0.x, R2, R2;
MUL R7.x, R0, R2.z;
TEX R0, fragment.texcoord[0], texture[4], 2D;
MUL R2.z, R7.x, R2;
MUL R0.w, R2.y, R0;
MUL R2.y, R2.z, c[23].w;
MUL R2.z, R6.y, R6.y;
MAD R2.z, R6.x, R6.x, R2;
DP3 R6.x, fragment.texcoord[2], R6;
MUL R0.w, R0, c[23];
POW R2.y, c[23].x, -R2.y;
MUL R2.y, -R2, c[24].x;
MOV R7.xyz, c[13];
MAD R0.w, R5, R6, R0;
ADD R2.y, R2, c[21].x;
MUL_SAT R5.w, R0, R2.y;
MUL R0.w, R2.y, R2.x;
MAD R2.z, R6, R6, R2;
RSQ R2.y, R2.z;
ADD_SAT R2.x, -R0.w, c[21];
POW R2.z, R2.x, c[18].x;
RCP R2.y, R2.y;
MUL R2.w, R2, R2.y;
MUL R7.xyz, R7, c[0];
MUL R2.xy, -R9, c[5].x;
MUL R2.xy, R2, R2.w;
MUL R6.w, R2.z, c[19].x;
MAD R2.xy, -R2, c[8].x, fragment.texcoord[0];
TEX R2, R2, texture[7], 2D;
MUL_SAT R2.w, R6, R2;
MUL R8.xyz, R5.w, R7;
MUL R7.xyz, R2.w, R2;
MUL_SAT R6.x, R6, c[9];
MUL R2.xyz, R2, c[0];
MUL R2.xyz, R6.x, R2;
ADD R6.x, -R6, c[21];
MAD R2.xyz, R6.x, c[0], R2;
MUL R6.xyz, R7, c[20];
ADD R2.w, -R2, c[21].x;
MAD R2.xyz, R2.w, R2, R6;
ADD R5.xyz, fragment.texcoord[2], R5;
DP3 R2.w, R5, R5;
RSQ R6.y, R2.w;
MUL R0.xyz, R0, c[11];
MUL R0.xyz, R0, R2;
MAD R2.xyz, R0, R0.w, R8;
MOV R0, c[1];
MUL R6.x, R0.w, c[0].w;
TEX R0.w, fragment.texcoord[0], texture[5], 2D;
ADD_SAT R0.w, R0, c[14].x;
MUL R5.xyz, R6.y, R5;
DP3 R4.x, R4, R5;
MUL R4.y, R3.w, c[16].x;
MAX R3.w, R4.x, c[22].x;
POW R4.x, R3.w, R4.y;
MAD R2.w, R6.x, R5, R0;
MUL R2.xyz, R2, c[21].y;
MUL R2, R0.w, R2;
ADD R0.w, -R0, c[21].x;
MOV R3.w, c[21].x;
MAD R2, R0.w, R3, R2;
MUL_SAT R3.w, R1, R4.x;
MUL R0.xyz, R0, c[0];
MUL R1.xyz, R1, c[15];
MUL R3.xyz, R3.w, R0;
MAX R1.w, R4, c[22].x;
MUL R0.xyz, R1, c[0];
MAD R0.xyz, R0, R1.w, R3;
TEX R0.w, fragment.texcoord[0], texture[1], 2D;
ADD_SAT R1.w, R0, c[17].x;
MAD R0.w, R6.x, R3, R1;
MUL R0.xyz, R0, c[21].y;
MUL R0, R1.w, R0;
ADD R1.w, -R1, c[21].x;
MAD R0, R1.w, R2, R0;
MAD result.color.xyz, R1, fragment.texcoord[3], R0;
MOV result.color.w, R0;
END
# 319 instructions, 10 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color3]
Float 3 [_Shininess3]
Vector 4 [_SpecColor3]
Float 5 [_Layer1Thickness]
Float 6 [_Layer2Thickness]
Float 7 [_GVar]
Float 8 [_ExitColorMultiplier]
Float 9 [_ExitColorRadius]
Float 10 [_SpecSmoothing]
Vector 11 [_Color2]
Float 12 [_Shininess2]
Vector 13 [_SpecColor2]
Float 14 [_BlendAdjust2]
Vector 15 [_Color]
Float 16 [_Shininess]
Float 17 [_BlendAdjust1]
Float 18 [_DDXP]
Float 19 [_DDXM]
Vector 20 [_SSSC]
SetTexture 0 [_MainTex3] 2D
SetTexture 1 [_ScatterMap] 2D
SetTexture 2 [_MainTex] 2D
SetTexture 3 [_BumpMap] 2D
SetTexture 4 [_MainTex2] 2D
SetTexture 5 [_ScatterMap2] 2D
SetTexture 6 [_BumpMap3] 2D
SetTexture 7 [_ExitColorMap] 2D
SetTexture 8 [_BumpMap2] 2D
"ps_3_0
; 379 ALU, 10 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
dcl_2d s7
dcl_2d s8
def c21, 2.00000000, -1.00000000, 0.11705996, 0.50000000
def c22, 6.28318501, -3.14159298, -0.73550957, 0.73550957
def c23, 0.00000000, -1.00000000, 0.15799320, 0.50000000
def c24, -0.99270076, 0.99270076, 2.71828198, -0.21211439
def c25, 0.39894229, 1.00000000, 0.00000000, 1.57072902
def c26, -0.01872930, 0.07426100, 3.14159298, 3.14159274
def c27, 0.15915491, 0.50000000, 5.00000000, 128.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
mul r0.x, v2.y, v2.y
mad r0.x, v2, v2, r0
mad r0.x, v2.z, v2.z, r0
rsq r3.w, r0.x
mul r1.x, r3.w, -v2.z
mad r0.x, r1, c21.z, c21.w
frc r0.x, r0
mad r1.y, r0.x, c22.x, c22
sincos r0.xy, r1.y
mad r0.z, r1.x, c22, r0.x
dp3 r0.y, v2, v2
mul r1.xy, r0.z, c23
rsq r0.x, r0.y
mul r0.xyz, r0.x, v2
mad r2.xyz, r0, c22.w, r1.xxyw
mul r0.x, r2.y, r2.y
mad r0.x, r2, r2, r0
mad r0.x, r2.z, r2.z, r0
rsq r0.x, r0.x
mul r1.x, r0, -r2.z
mad r0.x, r1, c23.z, c23.w
frc r0.x, r0
mad r1.y, r0.x, c22.x, c22
sincos r0.xy, r1.y
mad r0.z, r1.x, c24.x, r0.x
dp3 r0.y, r2, r2
rsq r0.x, r0.y
mul r3.xyz, r0.x, r2
mul r0.zw, r0.z, c23.xyxy
mad r4.xyz, r3, c24.y, r0.zzww
dp3 r0.x, r4, r4
rsq r0.x, r0.x
mul r0.xyz, r0.x, r4
mad r1.xyz, -r3, c5.x, v2
mad r5.xyz, -r0, c6.x, r1
texld r0.yw, v0.zwzw, s6
mad_pp r1.xy, r0.wyzw, c21.x, c21.y
dp3 r0.x, r5, r5
rsq r0.x, r0.x
mul r6.xyz, r0.x, r5
mul_pp r0.w, r1.y, r1.y
mad_pp r0.w, -r1.x, r1.x, -r0
dp3_pp r0.x, v1, v1
rsq_pp r0.x, r0.x
mul_pp r7.xyz, r0.x, v1
add r0.xyz, r6, r7
dp3 r1.z, r0, r0
rsq r1.z, r1.z
add_pp r0.w, r0, c25.y
add r4.xyz, -r4, v2
mul r8.xyz, r1.z, r0
rsq_pp r0.w, r0.w
rcp_pp r1.z, r0.w
dp3 r1.w, r1, r8
abs r0.x, r1.w
dp3_pp r7.w, r1, v2
add r0.z, -r0.x, c25.y
mad r0.y, r0.x, c26.x, c26
mad r0.y, r0, r0.x, c24.w
rsq r0.z, r0.z
mad r0.x, r0.y, r0, c25.w
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r0.x, r1.w, c25.z, c25.y
mul r0.z, r0.x, r0.y
mad r0.y, -r0.z, c21.x, r0
mad r0.x, r0, c26.z, r0.y
mad r0.x, r0, c27, c27.y
frc r0.x, r0
mad r2.w, r0.x, c22.x, c22.y
sincos r0.xy, r2.w
mul r2.w, r0.x, r0.x
mul r0.x, r2.w, c10
mul r0.y, r0.x, c10.x
mul r4.w, c10.x, c10.x
mul r6.w, r2, r4
add r0.x, -r2.w, c25.y
rcp r0.y, r0.y
mul r5.w, r0.x, r0.y
pow r0, c24.z, -r5.w
mul r0.y, r2.w, r6.w
mov r0.z, r0.x
mul r0.y, r0, c26.w
rcp r0.x, r0.y
add r5.w, -r1, c25.y
mul r2.w, r0.z, r0.x
pow r0, r5.w, c27.z
dp3_pp r5.w, r1, r7
rcp r6.w, r5.w
mov_pp r0.y, c3.x
add_pp r0.y, c25, -r0
mad r0.x, r0, c3, r0.y
mul r2.w, r2, r0.x
texld r0, v0, s0
mul r2.w, r0, r2
mul_sat r2.w, r2, r6
dp3_pp r6.w, r8, r7
dp3 r1.x, r1, r6
rcp r6.w, r6.w
mul r5.w, r1, r5
mul r5.w, r5, r6
mul r7.w, r1, r7
mul r7.w, r6, r7
mul r6.w, r7, c21.x
mul r5.w, r5, c21.x
min_sat r5.w, r5, r6
max r6.w, r1, c23.x
mul r1.w, r4.y, r4.y
mad r1.y, r4.x, r4.x, r1.w
max r4.x, r1, c23
mad r1.x, r4.z, r4.z, r1.y
rsq r1.z, r1.x
mov r1.x, c6
mul r1.y, r4.x, r4.x
add r1.w, -c5.x, -r1.x
rcp r1.z, r1.z
mul r1.x, r1.z, c7
add r1.z, r1.w, c21.x
mul r4.y, r1.x, r1.z
mov_pp r1.w, c3.x
mul r4.z, r1.y, r4.y
mul_pp r6.x, c27.w, r1.w
pow r1, r6.w, r6.x
mul r1.y, r4.z, r4
mov r4.z, r1.x
mul r0.w, r0, r4.z
mul r4.y, r1, c21.w
pow r1, c24.z, -r4.y
mul r4.z, r0.w, c21.w
mov r0.w, r1.x
mad r6.x, -r0.w, c25, c25.y
mul r0.w, r4.x, r6.x
mul r1.x, r5.y, r5.y
mad r1.x, r5, r5, r1
mad r1.x, r5.z, r5.z, r1
add_sat r4.x, -r0.w, c25.y
rsq r4.y, r1.x
pow r1, r4.x, c18.x
rcp r1.y, r4.y
add r1.zw, r5.xyxy, -v2.xyxy
mul r1.y, r3.w, r1
mul r1.zw, r1, c6.x
mul r1.zw, r1, r1.y
mad r4.xy, -r1.zwzw, c8.x, v0
mov r6.y, r1.x
texld r1, r4, s7
mul r4.x, r6.y, c19
mul_sat r6.y, r4.x, r1.w
mad r1.w, r2, r5, r4.z
mul r4.xyz, r6.y, r1
dp3 r2.w, r5, v2
mul_sat r1.w, r6.x, r1
mul_sat r2.w, r2, c9.x
mul_pp r1.xyz, r1, c0
mul r1.xyz, r2.w, r1
add r2.w, -r2, c25.y
mad r1.xyz, r2.w, c0, r1
add r2.w, -r6.y, c25.y
mul r4.xyz, r4, c20
mad r1.xyz, r2.w, r1, r4
mul r6.xyz, r3, c5.x
mul_pp r0.xyz, r0, c2
mul_pp r0.xyz, r0, r1
mov_pp r1.xyz, c0
mul_pp r1.xyz, c4, r1
mul r3.xyz, r1, r1.w
add r4.xyz, v2, -r6
mad r0.xyz, r0, r0.w, r3
dp3 r1.x, r4, r4
rsq r1.z, r1.x
mul r8.xyz, r1.z, r4
texld r1.yw, v0.zwzw, s8
mad_pp r1.xy, r1.wyzw, c21.x, c21.y
mul_pp r1.z, r1.y, r1.y
add r5.xyz, r7, r8
mad_pp r1.z, -r1.x, r1.x, -r1
dp3 r1.w, r5, r5
rsq r1.w, r1.w
add_pp r1.z, r1, c25.y
rsq_pp r1.z, r1.z
mul r5.xyz, r1.w, r5
rcp_pp r1.z, r1.z
dp3 r5.w, r1, r5
abs r0.w, r5
mul r3.xyz, r0, c21.x
add r0.y, -r0.w, c25
mad r0.x, r0.w, c26, c26.y
mad r0.x, r0, r0.w, c24.w
mad r0.x, r0, r0.w, c25.w
rsq r0.y, r0.y
rcp r0.y, r0.y
mul r1.w, r0.x, r0.y
add r0.xyz, -r2, v2
cmp r0.w, r5, c25.z, c25.y
mul r2.w, r0, r1
mad r1.w, -r2, c21.x, r1
mul r2.x, r0.y, r0.y
mad r0.y, r0.w, c26.z, r1.w
mad r0.w, r0.x, r0.x, r2.x
dp3 r0.x, r1, r8
max r1.w, r0.x, c23.x
dp3_pp r1.x, r7, r1
mad r0.z, r0, r0, r0.w
mov r0.x, c5
rsq r0.z, r0.z
add r0.w, c25.y, -r0.x
rcp r0.z, r0.z
mul r0.x, r0.z, c7
mul r0.z, r0.x, r0.w
mul r0.x, r1.w, r1.w
mul r0.w, r0.x, r0.z
mad r0.x, r0.y, c27, c27.y
mul r0.y, r0.w, r0.z
frc r0.x, r0
mul r2.x, r0.y, c21.w
mad r6.z, r0.x, c22.x, c22.y
pow r0, c24.z, -r2.x
mad r6.w, -r0.x, c25.x, c25.y
mul r7.w, r6, r1
mul r0.y, r4, r4
mad r0.y, r4.x, r4.x, r0
mad r0.x, r4.z, r4.z, r0.y
sincos r2.xy, r6.z
rsq r0.x, r0.x
rcp r2.y, r0.x
add_sat r1.w, -r7, c25.y
pow r0, r1.w, c18.x
mul r0.y, r3.w, r2
mul r0.zw, -r6.xyxy, c5.x
mul r0.zw, r0, r0.y
mov r1.w, r0.x
mad r6.xy, -r0.zwzw, c8.x, v0
texld r0, r6, s7
mul r1.w, r1, c19.x
mul_sat r0.w, r1, r0
mul r6.xyz, r0.w, r0
dp3 r1.w, v2, r4
mul r4.xyz, r6, c20
mul_sat r1.w, r1, c9.x
mul_pp r0.xyz, r0, c0
mul r0.xyz, r1.w, r0
add r1.w, -r1, c25.y
mad r0.xyz, r1.w, c0, r0
add r0.w, -r0, c25.y
mad r0.xyz, r0.w, r0, r4
mul r0.w, r2.x, r2.x
texld r2, v0, s4
mul_pp r2.xyz, r2, c11
mul_pp r2.xyz, r2, r0
mul r0.z, r4.w, r0.w
mul r1.w, r0, c10.x
mul r0.x, r1.w, c10
rcp r0.y, r0.x
add r0.x, -r0.w, c25.y
texld r4.yw, v0.zwzw, s3
mad_pp r4.xy, r4.wyzw, c21.x, c21.y
dp3_pp r4.w, r7, r5
rcp r5.x, r4.w
mul r1.w, r0.x, r0.y
mul r3.w, r0, r0.z
pow r0, c24.z, -r1.w
mul r0.y, r3.w, c26.w
rcp r0.y, r0.y
add r3.w, -r5, c25.y
mul r1.w, r0.x, r0.y
pow r0, r3.w, c27.z
mov r0.y, r0.x
mul_pp r0.z, r4.y, r4.y
mad_pp r0.z, -r4.x, r4.x, -r0
mov_pp r0.x, c12
add_pp r0.z, r0, c25.y
rsq_pp r0.z, r0.z
rcp_pp r4.z, r0.z
dp3_pp r3.w, r7, r4
mul r3.w, r5, r3
mul r1.y, r3.w, r5.x
add_pp r0.x, c25.y, -r0
mad r0.x, r0.y, c12, r0
mul r1.w, r1, r0.x
texld r0, v0, s2
dp3_pp r4.w, v2, r4
mul r1.w, r0, r1
rcp r1.x, r1.x
mul_sat r3.w, r1, r1.x
mov_pp r1.x, c12
mul r5.y, r1, c21.x
max r5.z, r5.w, c23.x
mul_pp r6.x, c27.w, r1
pow r1, r5.z, r6.x
mul r1.y, r5.w, r4.w
mul r1.y, r5.x, r1
mov r1.z, r1.x
mul r1.x, r1.y, c21
mul r1.y, r1.z, r2.w
min_sat r1.w, r5.y, r1.x
mul r2.w, r1.y, c21
mad r1.w, r3, r1, r2
mov_pp r1.xyz, c0
mul_sat r2.w, r1, r6
add_pp r5.xyz, v2, r7
mul_pp r1.xyz, c13, r1
mul r1.xyz, r2.w, r1
mad r1.xyz, r2, r7.w, r1
dp3_pp r1.w, r5, r5
rsq_pp r2.y, r1.w
texld r1.w, v0, s5
mov_pp r2.x, c0.w
mul_pp r5.w, c1, r2.x
add_sat r3.w, r1, c14.x
mad r1.w, r5, r2, r3
mul_pp r2.xyz, r2.y, r5
dp3_pp r2.x, r4, r2
mov_pp r2.w, c16.x
mul r1.xyz, r1, c21.x
mul_pp r1, r3.w, r1
mul_pp r4.y, c27.w, r2.w
max_pp r4.x, r2, c23
pow r2, r4.x, r4.y
add_pp r2.y, -r3.w, c25
mov_pp r3.w, c25.y
mad_pp r1, r2.y, r3, r1
mov r2.w, r2.x
mul_sat r3.w, r0, r2
mov_pp r2.xyz, c0
mul_pp r3.xyz, c1, r2
mul_pp r2.xyz, r0, c15
max_pp r2.w, r4, c23.x
texld r0.w, v0, s1
mul r3.xyz, r3.w, r3
mul_pp r0.xyz, r2, c0
mad r0.xyz, r0, r2.w, r3
add_sat r2.w, r0, c17.x
mad r0.w, r5, r3, r2
mul r0.xyz, r0, c21.x
mul_pp r0, r2.w, r0
add_pp r2.w, -r2, c25.y
mad_pp r0, r2.w, r1, r0
mad_pp oC0.xyz, r2, v3, r0
mov_pp oC0.w, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color3]
Float 3 [_Shininess3]
Vector 4 [_SpecColor3]
Float 5 [_Layer1Thickness]
Float 6 [_Layer2Thickness]
Float 7 [_GVar]
Float 8 [_ExitColorMultiplier]
Float 9 [_ExitColorRadius]
Float 10 [_SpecSmoothing]
Vector 11 [_Color2]
Float 12 [_Shininess2]
Vector 13 [_SpecColor2]
Float 14 [_BlendAdjust2]
Vector 15 [_Color]
Float 16 [_Shininess]
Float 17 [_BlendAdjust1]
Float 18 [_DDXP]
Float 19 [_DDXM]
Vector 20 [_SSSC]
SetTexture 0 [_MainTex3] 2D
SetTexture 1 [_ScatterMap] 2D
SetTexture 2 [_MainTex] 2D
SetTexture 3 [_BumpMap] 2D
SetTexture 4 [_MainTex2] 2D
SetTexture 5 [_ScatterMap2] 2D
SetTexture 6 [_ShadowMapTexture] 2D
SetTexture 7 [_BumpMap3] 2D
SetTexture 8 [_ExitColorMap] 2D
SetTexture 9 [_BumpMap2] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 325 ALU, 11 TEX
PARAM c[27] = { program.local[0..20],
		{ 1, 2, 0.73550957, -0.73550957 },
		{ 0, -1, 0.99270076, -0.99270076 },
		{ 2.718282, 2, 0, 0.5 },
		{ 0.39894229, 3.141593, -0.018729299, 0.074261002 },
		{ 0.21211439, 1.570729, 3.1415927, 5 },
		{ 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEMP R7;
TEMP R8;
MUL R0.x, fragment.texcoord[2].y, fragment.texcoord[2].y;
MAD R0.x, fragment.texcoord[2], fragment.texcoord[2], R0;
MAD R0.x, fragment.texcoord[2].z, fragment.texcoord[2].z, R0;
RSQ R2.w, R0.x;
MUL R0.y, R2.w, -fragment.texcoord[2].z;
MUL R0.x, R0.y, c[21].z;
COS R0.z, R0.x;
MAD R0.y, R0, c[21].w, R0.z;
DP3 R0.x, fragment.texcoord[2], fragment.texcoord[2];
MUL R1.xy, R0.y, c[22];
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, fragment.texcoord[2];
MAD R4.xyz, R0, c[21].z, R1.xxyw;
MUL R0.x, R4.y, R4.y;
MAD R0.x, R4, R4, R0;
MAD R0.x, R4.z, R4.z, R0;
RSQ R0.x, R0.x;
MUL R0.y, R0.x, -R4.z;
MUL R0.x, R0.y, c[22].z;
COS R0.z, R0.x;
MAD R0.y, R0, c[22].w, R0.z;
DP3 R0.x, R4, R4;
RSQ R0.x, R0.x;
MUL R2.xyz, R0.x, R4;
MUL R0.zw, R0.y, c[22].xyxy;
MAD R6.xyz, R2, c[22].z, R0.zzww;
DP3 R0.x, R6, R6;
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, R6;
ADD R6.xyz, -R6, fragment.texcoord[2];
MAD R1.xyz, -R2, c[5].x, fragment.texcoord[2];
MAD R3.xyz, -R0, c[6].x, R1;
DP3 R0.x, R3, R3;
RSQ R0.x, R0.x;
MUL R7.xyz, R0.x, R3;
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.z, R0.x;
MUL R5.xyz, R0.z, fragment.texcoord[1];
TEX R0.yw, fragment.texcoord[0].zwzw, texture[7], 2D;
MAD R0.xy, R0.wyzw, c[21].y, -c[21].x;
ADD R1.xyz, R7, R5;
DP3 R0.w, R1, R1;
MUL R0.z, R0.y, R0.y;
MAD R0.z, -R0.x, R0.x, -R0;
RSQ R0.w, R0.w;
ADD R0.z, R0, c[21].x;
RSQ R0.z, R0.z;
RCP R0.z, R0.z;
MUL R8.xyz, R0.w, R1;
DP3 R6.w, R0, R8;
ABS R0.w, R6;
DP3 R5.w, R0, R5;
DP3 R8.w, R0, fragment.texcoord[2];
DP3 R0.x, R0, R7;
RCP R7.w, R5.w;
MAX R0.x, R0, c[22];
ADD R1.y, -R0.w, c[21].x;
MAD R1.x, R0.w, c[24].z, c[24].w;
MAD R1.x, R1, R0.w, -c[25];
MUL R6.y, R6, R6;
MAD R0.y, R6.x, R6.x, R6;
MAD R0.y, R6.z, R6.z, R0;
MOV R6.x, c[5];
ADD R6.y, -R6.x, -c[6].x;
RSQ R1.y, R1.y;
RSQ R0.y, R0.y;
RCP R0.y, R0.y;
MUL R6.x, R0.y, c[7];
ADD R6.y, R6, c[23];
ADD R4.xyz, -R4, fragment.texcoord[2];
MUL R6.x, R6, R6.y;
MOV R0.y, c[26].x;
MUL R0.z, R0.x, R0.x;
MUL R0.z, R0, R6.x;
MUL R0.z, R0, R6.x;
MUL R0.z, R0, c[23].w;
POW R0.z, c[23].x, -R0.z;
MAD R0.w, R1.x, R0, c[25].y;
RCP R1.y, R1.y;
MUL R1.x, R0.w, R1.y;
SLT R0.w, R6, c[22].x;
MUL R1.y, R0.w, R1.x;
MAD R1.x, -R1.y, c[21].y, R1;
MAD R0.w, R0, c[24].y, R1.x;
COS R1.x, R0.w;
MUL R1.x, R1, R1;
MUL R0.w, c[10].x, c[10].x;
MUL R1.z, R1.x, R0.w;
MUL R1.y, R1.x, c[10].x;
MUL R1.z, R1.x, R1;
MUL R1.y, R1, c[10].x;
MOV R3.w, c[21].x;
MUL R1.z, R1, c[25];
RCP R1.y, R1.y;
ADD R1.x, -R1, c[21];
MUL R1.x, R1, R1.y;
RCP R1.y, R1.z;
POW R1.x, c[23].x, -R1.x;
MUL R1.x, R1, R1.y;
ADD R1.y, -R6.w, c[21].x;
ADD R1.z, R3.w, -c[3].x;
POW R1.y, R1.y, c[25].w;
MAD R1.y, R1, c[3].x, R1.z;
MUL R4.w, R1.x, R1.y;
TEX R1, fragment.texcoord[0], texture[0], 2D;
MUL R4.w, R1, R4;
MUL_SAT R4.w, R4, R7;
DP3 R7.w, R8, R5;
RCP R7.w, R7.w;
MUL R5.w, R6, R5;
MUL R8.x, R6.w, R8.w;
MUL R5.w, R5, R7;
MUL R8.x, R7.w, R8;
MUL R7.w, R8.x, c[21].y;
MUL R5.w, R5, c[21].y;
MIN_SAT R5.w, R5, R7;
MUL R8.xyz, R2, c[5].x;
MAX R6.w, R6, c[22].x;
MUL R6.y, R0, c[3].x;
POW R6.y, R6.w, R6.y;
MUL R1.w, R1, R6.y;
MUL R7.x, R1.w, c[23].w;
MAD R4.w, R4, R5, R7.x;
MUL R1.w, R3.y, R3.y;
MAD R6.x, R3, R3, R1.w;
MUL R0.z, -R0, c[24].x;
ADD R1.w, R0.z, c[21].x;
MUL R0.z, R0.x, R1.w;
MAD R6.x, R3.z, R3.z, R6;
RSQ R6.x, R6.x;
RCP R6.z, R6.x;
ADD_SAT R0.x, -R0.z, c[21];
ADD R6.xy, R3, -fragment.texcoord[2];
POW R0.x, R0.x, c[18].x;
MUL R7.y, R0.x, c[19].x;
DP3 R5.w, R3, fragment.texcoord[2];
TXP R0.x, fragment.texcoord[4], texture[6], 2D;
MUL_SAT R1.w, R1, R4;
MUL R6.z, R2.w, R6;
MUL R6.xy, R6, c[6].x;
MUL R6.xy, R6, R6.z;
MAD R6.xy, -R6, c[8].x, fragment.texcoord[0];
TEX R6, R6, texture[8], 2D;
MUL R6.w, R7.y, R6;
MUL_SAT R6.w, R6, R0.x;
MUL R7.xyz, R6.w, R6;
MUL R3.xyz, R6, c[0];
MUL R6.xyz, R7, c[20];
MUL_SAT R5.w, R5, c[9].x;
MUL R3.xyz, R5.w, R3;
ADD R5.w, -R5, c[21].x;
MAD R3.xyz, R5.w, c[0], R3;
ADD R5.w, -R6, c[21].x;
MAD R3.xyz, R5.w, R3, R6;
TEX R7.yw, fragment.texcoord[0].zwzw, texture[9], 2D;
MUL R1.xyz, R1, c[2];
MUL R1.xyz, R1, R3;
MOV R3.xyz, c[4];
MUL R2.xyz, R3, c[0];
MUL R2.xyz, R2, R1.w;
ADD R6.xyz, fragment.texcoord[2], -R8;
MAD R1.xyz, R1, R0.z, R2;
DP3 R0.z, R6, R6;
RSQ R0.z, R0.z;
MUL R2.xyz, R0.z, R6;
MAD R7.xy, R7.wyzw, c[21].y, -c[21].x;
ADD R3.xyz, R5, R2;
MUL R0.z, R7.y, R7.y;
MAD R0.z, -R7.x, R7.x, -R0;
DP3 R1.w, R3, R3;
RSQ R1.w, R1.w;
ADD R0.z, R0, c[21].x;
RSQ R0.z, R0.z;
RCP R7.z, R0.z;
DP3 R2.x, R7, R2;
MUL R3.xyz, R1.w, R3;
DP3 R1.w, R7, R3;
ABS R4.w, R1;
DP3 R3.y, R5, R3;
MUL R0.z, R0.x, c[21].y;
MAD R5.w, R4, c[24].z, c[24];
ADD R6.w, -R4, c[21].x;
MAD R5.w, R5, R4, -c[25].x;
MOV R2.z, c[21].x;
MUL R1.xyz, R1, R0.z;
MAX R2.x, R2, c[22];
RSQ R6.w, R6.w;
MAD R4.w, R5, R4, c[25].y;
RCP R5.w, R6.w;
MUL R4.w, R4, R5;
MUL R5.w, R4.y, R4.y;
MAD R4.x, R4, R4, R5.w;
MAD R2.y, R4.z, R4.z, R4.x;
SLT R4.y, R1.w, c[22].x;
RSQ R2.y, R2.y;
RCP R2.y, R2.y;
MUL R4.x, R4.y, R4.w;
MUL R2.y, R2, c[7].x;
ADD R2.z, R2, -c[5].x;
MUL R2.z, R2.y, R2;
MUL R2.y, R2.x, R2.x;
MUL R2.y, R2, R2.z;
MUL R2.y, R2, R2.z;
MUL R2.z, R6.y, R6.y;
MAD R2.z, R6.x, R6.x, R2;
DP3 R6.x, fragment.texcoord[2], R6;
MAD R2.z, R6, R6, R2;
MUL R2.y, R2, c[23].w;
POW R2.y, c[23].x, -R2.y;
MUL R2.y, -R2, c[24].x;
ADD R6.w, R2.y, c[21].x;
RSQ R2.z, R2.z;
RCP R2.y, R2.z;
MUL R5.w, R6, R2.x;
MUL R2.z, R2.w, R2.y;
MUL R2.xy, -R8, c[5].x;
MUL R2.xy, R2, R2.z;
ADD_SAT R2.z, -R5.w, c[21].x;
POW R4.z, R2.z, c[18].x;
MAD R2.xy, -R2, c[8].x, fragment.texcoord[0];
TEX R2, R2, texture[8], 2D;
MUL R4.z, R4, c[19].x;
MUL R4.z, R4, R2.w;
MAD R2.w, -R4.x, c[21].y, R4;
MAD R2.w, R4.y, c[24].y, R2;
MUL_SAT R4.w, R0.x, R4.z;
MUL R4.xyz, R4.w, R2;
COS R2.w, R2.w;
MUL R2.w, R2, R2;
MUL_SAT R6.x, R6, c[9];
MUL R2.xyz, R2, c[0];
MUL R2.xyz, R6.x, R2;
ADD R6.x, -R6, c[21];
MAD R2.xyz, R6.x, c[0], R2;
MUL R4.xyz, R4, c[20];
ADD R4.w, -R4, c[21].x;
MAD R2.xyz, R4.w, R2, R4;
TEX R4, fragment.texcoord[0], texture[4], 2D;
MUL R4.xyz, R4, c[11];
MUL R4.xyz, R4, R2;
MUL R2.y, R0.w, R2.w;
MUL R2.x, R2.w, c[10];
MUL R0.w, R2.x, c[10].x;
RCP R2.x, R0.w;
ADD R0.w, -R2, c[21].x;
MUL R0.w, R0, R2.x;
MUL R2.y, R2.w, R2;
MUL R2.x, R2.y, c[25].z;
ADD R2.y, -R1.w, c[21].x;
ADD R2.z, R3.w, -c[12].x;
RCP R2.x, R2.x;
POW R0.w, c[23].x, -R0.w;
MUL R0.w, R0, R2.x;
POW R2.x, R2.y, c[25].w;
TEX R2.yw, fragment.texcoord[0].zwzw, texture[3], 2D;
MAD R6.xy, R2.wyzw, c[21].y, -c[21].x;
MAD R2.x, R2, c[12], R2.z;
MUL R0.w, R0, R2.x;
TEX R2, fragment.texcoord[0], texture[2], 2D;
MUL R3.w, R6.y, R6.y;
MAD R3.w, -R6.x, R6.x, -R3;
ADD R6.z, R3.w, c[21].x;
DP3 R3.w, R5, R7;
RSQ R6.z, R6.z;
RCP R6.z, R6.z;
DP3 R7.w, fragment.texcoord[2], R6;
MUL R3.z, R1.w, R7.w;
MUL R0.w, R2, R0;
RCP R3.w, R3.w;
MUL_SAT R0.w, R0, R3;
DP3 R3.w, R5, R6;
MUL R3.x, R1.w, R3.w;
RCP R3.y, R3.y;
MUL R3.x, R3, R3.y;
MUL R3.y, R3, R3.z;
MUL R3.x, R3, c[21].y;
MUL R3.z, R0.y, c[12].x;
MAX R1.w, R1, c[22].x;
POW R3.z, R1.w, R3.z;
MUL R1.w, R3.y, c[21].y;
MUL R3.y, R3.z, R4.w;
ADD R5.xyz, fragment.texcoord[2], R5;
MIN_SAT R1.w, R3.x, R1;
MUL R3.w, R3.y, c[23];
MAD R0.w, R0, R1, R3;
MOV R3.xyz, c[13];
MUL_SAT R0.w, R0, R6;
MUL R3.xyz, R3, c[0];
MUL R7.xyz, R0.w, R3;
MOV R3, c[1];
MAD R4.xyz, R4, R5.w, R7;
MUL R3.w, R3, c[0];
MUL R1.w, R3, R0;
DP3 R4.w, R5, R5;
RSQ R5.w, R4.w;
TEX R0.w, fragment.texcoord[0], texture[5], 2D;
ADD_SAT R0.w, R0, c[14].x;
MAD R4.w, R0.x, R1, R0;
MUL R4.xyz, R0.z, R4;
MUL R5.xyz, R5.w, R5;
DP3 R1.w, R6, R5;
MUL R5.x, R0.y, c[16];
MAX R0.y, R1.w, c[22].x;
POW R5.x, R0.y, R5.x;
MUL R4, R0.w, R4;
ADD R0.y, -R0.w, c[21].x;
MOV R1.w, c[21].x;
MAD R1, R0.y, R1, R4;
MUL_SAT R0.y, R2.w, R5.x;
MUL R3.xyz, R3, c[0];
MUL R4.xyz, R0.y, R3;
MUL R2.xyz, R2, c[15];
MUL R0.y, R3.w, R0;
MAX R0.w, R7, c[22].x;
MUL R3.xyz, R2, c[0];
MAD R3.xyz, R3, R0.w, R4;
TEX R0.w, fragment.texcoord[0], texture[1], 2D;
ADD_SAT R2.w, R0, c[17].x;
MAD R3.w, R0.x, R0.y, R2;
MUL R3.xyz, R0.z, R3;
MUL R0, R2.w, R3;
ADD R2.w, -R2, c[21].x;
MAD R0, R2.w, R1, R0;
MAD result.color.xyz, R2, fragment.texcoord[3], R0;
MOV result.color.w, R0;
END
# 325 instructions, 9 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color3]
Float 3 [_Shininess3]
Vector 4 [_SpecColor3]
Float 5 [_Layer1Thickness]
Float 6 [_Layer2Thickness]
Float 7 [_GVar]
Float 8 [_ExitColorMultiplier]
Float 9 [_ExitColorRadius]
Float 10 [_SpecSmoothing]
Vector 11 [_Color2]
Float 12 [_Shininess2]
Vector 13 [_SpecColor2]
Float 14 [_BlendAdjust2]
Vector 15 [_Color]
Float 16 [_Shininess]
Float 17 [_BlendAdjust1]
Float 18 [_DDXP]
Float 19 [_DDXM]
Vector 20 [_SSSC]
SetTexture 0 [_MainTex3] 2D
SetTexture 1 [_ScatterMap] 2D
SetTexture 2 [_MainTex] 2D
SetTexture 3 [_BumpMap] 2D
SetTexture 4 [_MainTex2] 2D
SetTexture 5 [_ScatterMap2] 2D
SetTexture 6 [_ShadowMapTexture] 2D
SetTexture 7 [_BumpMap3] 2D
SetTexture 8 [_ExitColorMap] 2D
SetTexture 9 [_BumpMap2] 2D
"ps_3_0
; 386 ALU, 11 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
dcl_2d s7
dcl_2d s8
dcl_2d s9
def c21, 2.00000000, -1.00000000, 0.11705996, 0.50000000
def c22, 6.28318501, -3.14159298, -0.73550957, 0.73550957
def c23, 0.00000000, -1.00000000, 0.15799320, 0.50000000
def c24, -0.99270076, 0.99270076, 2.71828198, -0.21211439
def c25, 0.39894229, 1.00000000, 0.00000000, 1.57072902
def c26, -0.01872930, 0.07426100, 3.14159298, 3.14159274
def c27, 0.15915491, 0.50000000, 5.00000000, 128.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4
mul r0.x, v2.y, v2.y
mad r0.x, v2, v2, r0
mad r0.x, v2.z, v2.z, r0
rsq r0.w, r0.x
mul r0.y, r0.w, -v2.z
mad r0.x, r0.y, c21.z, c21.w
frc r0.x, r0
mad r0.x, r0, c22, c22.y
sincos r1.xy, r0.x
mad r0.x, r0.y, c22.z, r1
dp3 r0.z, v2, v2
rsq r0.z, r0.z
mul r0.xy, r0.x, c23
mul r1.xyz, r0.z, v2
mad r3.xyz, r1, c22.w, r0.xxyw
mul r0.x, r3.y, r3.y
mad r0.x, r3, r3, r0
mad r0.x, r3.z, r3.z, r0
rsq r0.x, r0.x
mul r0.y, r0.x, -r3.z
mad r0.x, r0.y, c23.z, c23.w
dp3 r0.z, r3, r3
frc r0.x, r0
mad r0.x, r0, c22, c22.y
sincos r1.xy, r0.x
mad r0.x, r0.y, c24, r1
rsq r0.z, r0.z
mul r1.xyz, r0.z, r3
mul r0.xy, r0.x, c23
mad r0.xyz, r1, c24.y, r0.xxyw
dp3 r1.w, r0, r0
rsq r1.w, r1.w
mul r4.xyz, r1.w, r0
mad r2.xyz, -r1, c5.x, v2
mad r2.xyz, -r4, c6.x, r2
texld r4.yw, v0.zwzw, s7
dp3 r1.w, r2, r2
rsq r1.w, r1.w
mul r6.xyz, r1.w, r2
dp3_pp r1.w, v1, v1
mad_pp r7.xy, r4.wyzw, c21.x, c21.y
rsq_pp r1.w, r1.w
mul_pp r4.xyz, r1.w, v1
mul_pp r1.w, r7.y, r7.y
mad_pp r2.w, -r7.x, r7.x, -r1
add r5.xyz, r6, r4
dp3 r1.w, r5, r5
rsq r1.w, r1.w
mul r8.xyz, r1.w, r5
dp3_pp r7.w, r8, r4
add_pp r2.w, r2, c25.y
rsq_pp r2.w, r2.w
rcp_pp r7.z, r2.w
dp3 r4.w, r7, r8
abs r3.w, r4
add r1.w, -r3, c25.y
mad r2.w, r3, c26.x, c26.y
mad r2.w, r2, r3, c24
mad r2.w, r2, r3, c25
rsq r1.w, r1.w
rcp r1.w, r1.w
add r0.xyz, -r0, v2
dp3 r6.y, r7, r6
mul r6.x, r0.y, r0.y
mad r0.x, r0, r0, r6
max r0.y, r6, c23.x
mad r0.x, r0.z, r0.z, r0
rsq r0.z, r0.x
mov r6.x, c6
add r0.x, -c5, -r6
rcp r0.z, r0.z
add r3.xyz, -r3, v2
mul r2.w, r2, r1
cmp r3.w, r4, c25.z, c25.y
mul r1.w, r3, r2
mad r1.w, -r1, c21.x, r2
mad r1.w, r3, c26.z, r1
mad r1.w, r1, c27.x, c27.y
frc r1.w, r1
mad r1.w, r1, c22.x, c22.y
sincos r5.xy, r1.w
mul r2.w, r5.x, r5.x
mul r1.w, r2, c10.x
mul r1.w, r1, c10.x
rcp r3.w, r1.w
add r5.x, -r2.w, c25.y
mul r6.w, r5.x, r3
pow r5, c24.z, -r6.w
mul r1.w, c10.x, c10.x
mul r3.w, r2, r1
mul r2.w, r2, r3
mul r3.w, r2, c26
mov r2.w, r5.x
rcp r5.x, r3.w
mul r2.w, r2, r5.x
add r3.w, -r4, c25.y
pow r5, r3.w, c27.z
mov_pp r3.w, c3.x
add_pp r5.y, c25, -r3.w
mov r3.w, r5.x
mad r5.x, r3.w, c3, r5.y
mul r6.w, r2, r5.x
texld r5, v0, s0
dp3_pp r3.w, r7, r4
rcp r2.w, r3.w
mul r6.w, r5, r6
mul_sat r2.w, r6, r2
dp3_pp r6.w, r7, v2
mul r3.w, r4, r3
mul r6.w, r4, r6
rcp r7.w, r7.w
mul r6.w, r7, r6
mul r7.w, r3, r7
mul r3.w, r6, c21.x
mul r6.w, r7, c21.x
min_sat r3.w, r6, r3
mul r6.y, r0, r0
max r4.w, r4, c23.x
add r0.x, r0, c21
mul r0.z, r0, c7.x
mul r6.x, r0.z, r0
mul r0.z, r6.y, r6.x
mov_pp r0.x, c3
mul r0.z, r0, r6.x
mul_pp r0.x, c27.w, r0
pow r6, r4.w, r0.x
mul r0.x, r0.z, c21.w
pow r7, c24.z, -r0.x
mov r0.x, r6
mul r0.x, r5.w, r0
mul r4.w, r0.x, c21
mad r2.w, r2, r3, r4
mov r0.z, r7.x
mad r0.z, -r0, c25.x, c25.y
mul r0.y, r0, r0.z
add_sat r5.w, -r0.y, c25.y
pow r6, r5.w, c18.x
mul r0.x, r2.y, r2.y
mad r0.x, r2, r2, r0
mad r0.x, r2.z, r2.z, r0
add r6.zw, r2.xyxy, -v2.xyxy
dp3 r3.w, r2, v2
rsq r0.x, r0.x
rcp r0.x, r0.x
mul_sat r0.z, r0, r2.w
mul r0.x, r0.w, r0
mul r6.zw, r6, c6.x
mul r6.zw, r6, r0.x
mov r0.x, r6
mul r5.w, r0.x, c19.x
mad r6.xy, -r6.zwzw, c8.x, v0
texld r6, r6, s8
texldp r0.x, v4, s6
mul r5.w, r5, r6
mul_sat r5.w, r5, r0.x
mul r7.xyz, r5.w, r6
mul_pp r2.xyz, r6, c0
mul r6.xyz, r7, c20
mul_sat r3.w, r3, c9.x
mul r2.xyz, r3.w, r2
add r3.w, -r3, c25.y
mad r2.xyz, r3.w, c0, r2
add r3.w, -r5, c25.y
mul r7.xyz, r1, c5.x
mad r2.xyz, r3.w, r2, r6
mul_pp r5.xyz, r5, c2
mul_pp r2.xyz, r5, r2
mov_pp r5.xyz, c0
mul_pp r1.xyz, c4, r5
mul r1.xyz, r1, r0.z
mad r1.xyz, r2, r0.y, r1
add r6.xyz, v2, -r7
dp3 r0.y, r6, r6
texld r2.yw, v0.zwzw, s9
rsq r0.y, r0.y
mul r8.xyz, r0.y, r6
mad_pp r2.xy, r2.wyzw, c21.x, c21.y
mul_pp r0.y, r2, r2
mad_pp r0.z, -r2.x, r2.x, -r0.y
add r5.xyz, r4, r8
dp3 r0.y, r5, r5
rsq r0.y, r0.y
add_pp r0.z, r0, c25.y
rsq_pp r0.z, r0.z
rcp_pp r2.z, r0.z
mul r5.xyz, r0.y, r5
dp3 r0.y, r2, r5
abs r2.w, r0.y
mul_pp r0.z, r0.x, c21.x
add r3.w, -r2, c25.y
mad r4.w, r2, c26.x, c26.y
mad r4.w, r4, r2, c24
rsq r3.w, r3.w
mul r1.xyz, r1, r0.z
mad r2.w, r4, r2, c25
rcp r3.w, r3.w
mul r5.w, r2, r3
cmp r3.w, r0.y, c25.z, c25.y
mul r2.w, r3.y, r3.y
mul r4.w, r3, r5
mad r3.y, -r4.w, c21.x, r5.w
dp3 r4.w, r2, r8
dp3_pp r2.y, r4, r2
mad r2.w, r3.x, r3.x, r2
mad r3.x, r3.z, r3.z, r2.w
max r2.w, r4, c23.x
rsq r3.x, r3.x
rcp r3.z, r3.x
mov r4.w, c5.x
mad r3.y, r3.w, c26.z, r3
mad r3.y, r3, c27.x, c27
frc r5.w, r3.y
add r3.x, c25.y, -r4.w
mul r3.z, r3, c7.x
mul r3.z, r3, r3.x
mul r3.x, r2.w, r2.w
mul r3.x, r3, r3.z
mul r3.x, r3, r3.z
mul r4.w, r3.x, c21
pow r3, c24.z, -r4.w
mov r3.z, r3.x
mad r4.w, -r3.z, c25.x, c25.y
mul r2.w, r4, r2
mul r3.y, r6, r6
mad r3.x, r6, r6, r3.y
mad r3.x, r6.z, r6.z, r3
rsq r3.x, r3.x
rcp r6.w, r3.x
add_sat r7.z, -r2.w, c25.y
pow r3, r7.z, c18.x
mul r0.w, r0, r6
mul r3.zw, -r7.xyxy, c5.x
mul r3.zw, r3, r0.w
mad r7.xy, -r3.zwzw, c8.x, v0
mov r0.w, r3.x
mad r5.w, r5, c22.x, c22.y
sincos r3.xy, r5.w
dp3 r3.y, v2, r6
texld r7, r7, s8
mul r0.w, r0, c19.x
mul r0.w, r0, r7
mul_sat r0.w, r0.x, r0
mul r8.xyz, r0.w, r7
mul_pp r6.xyz, r7, c0
mul_sat r3.y, r3, c9.x
mul r6.xyz, r3.y, r6
add r3.y, -r3, c25
mad r6.xyz, r3.y, c0, r6
max r2.z, r0.y, c23.x
add r0.w, -r0, c25.y
mul r7.xyz, r8, c20
mad r7.xyz, r0.w, r6, r7
mul r0.w, r3.x, r3.x
texld r6, v0, s4
mul_pp r3.xyz, r6, c11
mul_pp r6.xyz, r3, r7
mul r3.w, r0, c10.x
mul r3.x, r3.w, c10
texld r7.yw, v0.zwzw, s3
mad_pp r7.xy, r7.wyzw, c21.x, c21.y
mul r1.w, r1, r0
add r3.y, -r0.w, c25
mul r0.w, r0, r1
rcp r3.x, r3.x
mul r5.w, r3.y, r3.x
pow r3, c24.z, -r5.w
mul r0.w, r0, c26
rcp r1.w, r0.w
mov r0.w, r3.x
mul r0.w, r0, r1
add r1.w, -r0.y, c25.y
pow r3, r1.w, c27.z
mul_pp r1.w, r7.y, r7.y
mad_pp r1.w, -r7.x, r7.x, -r1
mov_pp r3.y, c12.x
add_pp r3.y, c25, -r3
add_pp r1.w, r1, c25.y
rsq_pp r1.w, r1.w
rcp_pp r7.z, r1.w
mad r3.x, r3, c12, r3.y
mul r1.w, r0, r3.x
texld r3, v0, s2
mul r5.w, r3, r1
dp3_pp r0.w, r4, r7
mul r1.w, r0.y, r0
dp3_pp r0.w, r4, r5
rcp r2.x, r0.w
rcp r0.w, r2.y
mul r1.w, r1, r2.x
dp3_pp r7.w, v2, r7
mul r0.y, r0, r7.w
mul r2.x, r2, r0.y
mov_pp r2.y, c12.x
mul_sat r0.w, r5, r0
mul_pp r2.y, c27.w, r2
pow r5, r2.z, r2.y
mov r0.y, r5.x
mul r0.y, r0, r6.w
mul r2.x, r2, c21
mul r1.w, r1, c21.x
min_sat r1.w, r1, r2.x
mul r0.y, r0, c21.w
mad r0.y, r0.w, r1.w, r0
mul_sat r0.w, r0.y, r4
add_pp r4.xyz, v2, r4
dp3_pp r1.w, r4, r4
rsq_pp r1.w, r1.w
mul_pp r4.xyz, r1.w, r4
dp3_pp r4.x, r7, r4
mov_pp r2.xyz, c0
mul_pp r2.xyz, c13, r2
mul r2.xyz, r0.w, r2
mad r2.xyz, r6, r2.w, r2
mov_pp r0.y, c0.w
mul_pp r0.y, c1.w, r0
mul r2.w, r0.y, r0
texld r0.w, v0, s5
add_sat r0.w, r0, c14.x
mov_pp r1.w, c16.x
mad r2.w, r0.x, r2, r0
mul r2.xyz, r0.z, r2
mul_pp r2, r0.w, r2
mul_pp r1.w, c27, r1
max_pp r5.x, r4, c23
pow r4, r5.x, r1.w
add_pp r0.w, -r0, c25.y
mov_pp r1.w, c25.y
mad_pp r1, r0.w, r1, r2
mov r0.w, r4.x
mul_sat r2.w, r3, r0
mov_pp r2.xyz, c0
mul_pp r4.xyz, c1, r2
mul_pp r2.xyz, r3, c15
mul r3.xyz, r2.w, r4
mul r0.y, r0, r2.w
mul_pp r4.xyz, r2, c0
max_pp r0.w, r7, c23.x
mad r3.xyz, r4, r0.w, r3
texld r0.w, v0, s1
add_sat r4.x, r0.w, c17
mul r3.xyz, r0.z, r3
mad r3.w, r0.x, r0.y, r4.x
mul_pp r0, r4.x, r3
add_pp r2.w, -r4.x, c25.y
mad_pp r0, r2.w, r1, r0
mad_pp oC0.xyz, r2, v3, r0
mov_pp oC0.w, r0
"
}
}
 }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardAdd" "RenderType"="Opaque" }
  ZWrite Off
  Fog {
   Color (0,0,0,0)
  }
  Blend One One
Program "vp" {
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [unity_Scale]
Vector 18 [_WorldSpaceCameraPos]
Vector 19 [_WorldSpaceLightPos0]
Vector 20 [_MainTex_ST]
Vector 21 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 34 ALU
PARAM c[22] = { { 1 },
		state.matrix.mvp,
		program.local[5..21] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[18];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[17].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[19];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R0.xyz, R3, c[17].w, -vertex.position;
DP3 result.texcoord[1].y, R0, R1;
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 result.texcoord[2].y, R1, R2;
DP3 result.texcoord[2].z, vertex.normal, R2;
DP3 result.texcoord[2].x, vertex.attrib[14], R2;
DP4 result.texcoord[3].z, R0, c[15];
DP4 result.texcoord[3].y, R0, c[14];
DP4 result.texcoord[3].x, R0, c[13];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[21].xyxy, c[21];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[20], c[20].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 34 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [unity_Scale]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Vector 19 [_MainTex_ST]
Vector 20 [_BumpMap_ST]
"vs_3_0
; 37 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c21, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c21.x
mov r0.xyz, c17
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c16.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c18, r0
mov r0, c9
dp4 r4.y, c18, r0
mov r1, c8
dp4 r4.x, c18, r1
mad r0.xyz, r4, c16.w, -v0
dp3 o2.y, r0, r2
dp3 o2.z, v2, r0
dp3 o2.x, r0, v1
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 o3.y, r2, r3
dp3 o3.z, v2, r3
dp3 o3.x, v1, r3
dp4 o4.z, r0, c14
dp4 o4.y, r0, c13
dp4 o4.x, r0, c12
mad o1.zw, v3.xyxy, c20.xyxy, c20
mad o1.xy, v3, c19, c19.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_World2Object]
Vector 9 [unity_Scale]
Vector 10 [_WorldSpaceCameraPos]
Vector 11 [_WorldSpaceLightPos0]
Vector 12 [_MainTex_ST]
Vector 13 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 26 ALU
PARAM c[14] = { { 1 },
		state.matrix.mvp,
		program.local[5..13] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[10];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[7];
DP4 R2.y, R1, c[6];
DP4 R2.x, R1, c[5];
MAD R2.xyz, R2, c[9].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[11];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[7];
DP4 R3.y, R0, c[6];
DP4 R3.x, R0, c[5];
DP3 result.texcoord[1].y, R3, R1;
DP3 result.texcoord[2].y, R1, R2;
DP3 result.texcoord[1].z, vertex.normal, R3;
DP3 result.texcoord[1].x, R3, vertex.attrib[14];
DP3 result.texcoord[2].z, vertex.normal, R2;
DP3 result.texcoord[2].x, vertex.attrib[14], R2;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[13].xyxy, c[13];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[12], c[12].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 26 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_World2Object]
Vector 8 [unity_Scale]
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_WorldSpaceLightPos0]
Vector 11 [_MainTex_ST]
Vector 12 [_BumpMap_ST]
"vs_3_0
; 29 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
def c13, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c13.x
mov r0.xyz, c9
dp4 r1.z, r0, c6
dp4 r1.y, r0, c5
dp4 r1.x, r0, c4
mad r3.xyz, r1, c8.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c6
dp4 r4.z, c10, r0
mov r0, c5
mov r1, c4
dp4 r4.y, c10, r0
dp4 r4.x, c10, r1
dp3 o2.y, r4, r2
dp3 o3.y, r2, r3
dp3 o2.z, v2, r4
dp3 o2.x, r4, v1
dp3 o3.z, v2, r3
dp3 o3.x, v1, r3
mad o1.zw, v3.xyxy, c12.xyxy, c12
mad o1.xy, v3, c11, c11.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [unity_Scale]
Vector 18 [_WorldSpaceCameraPos]
Vector 19 [_WorldSpaceLightPos0]
Vector 20 [_MainTex_ST]
Vector 21 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 35 ALU
PARAM c[22] = { { 1 },
		state.matrix.mvp,
		program.local[5..21] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[18];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[17].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[19];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R0.xyz, R3, c[17].w, -vertex.position;
DP4 R0.w, vertex.position, c[8];
DP3 result.texcoord[1].y, R0, R1;
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 result.texcoord[2].y, R1, R2;
DP3 result.texcoord[2].z, vertex.normal, R2;
DP3 result.texcoord[2].x, vertex.attrib[14], R2;
DP4 result.texcoord[3].w, R0, c[16];
DP4 result.texcoord[3].z, R0, c[15];
DP4 result.texcoord[3].y, R0, c[14];
DP4 result.texcoord[3].x, R0, c[13];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[21].xyxy, c[21];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[20], c[20].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 35 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [unity_Scale]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Vector 19 [_MainTex_ST]
Vector 20 [_BumpMap_ST]
"vs_3_0
; 38 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c21, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c21.x
mov r0.xyz, c17
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c16.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c18, r0
mov r0, c9
dp4 r4.y, c18, r0
mov r1, c8
dp4 r4.x, c18, r1
mad r0.xyz, r4, c16.w, -v0
dp4 r0.w, v0, c7
dp3 o2.y, r0, r2
dp3 o2.z, v2, r0
dp3 o2.x, r0, v1
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 o3.y, r2, r3
dp3 o3.z, v2, r3
dp3 o3.x, v1, r3
dp4 o4.w, r0, c15
dp4 o4.z, r0, c14
dp4 o4.y, r0, c13
dp4 o4.x, r0, c12
mad o1.zw, v3.xyxy, c20.xyxy, c20
mad o1.xy, v3, c19, c19.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [unity_Scale]
Vector 18 [_WorldSpaceCameraPos]
Vector 19 [_WorldSpaceLightPos0]
Vector 20 [_MainTex_ST]
Vector 21 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 34 ALU
PARAM c[22] = { { 1 },
		state.matrix.mvp,
		program.local[5..21] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[18];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[17].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[19];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R0.xyz, R3, c[17].w, -vertex.position;
DP3 result.texcoord[1].y, R0, R1;
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 result.texcoord[2].y, R1, R2;
DP3 result.texcoord[2].z, vertex.normal, R2;
DP3 result.texcoord[2].x, vertex.attrib[14], R2;
DP4 result.texcoord[3].z, R0, c[15];
DP4 result.texcoord[3].y, R0, c[14];
DP4 result.texcoord[3].x, R0, c[13];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[21].xyxy, c[21];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[20], c[20].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 34 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [unity_Scale]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Vector 19 [_MainTex_ST]
Vector 20 [_BumpMap_ST]
"vs_3_0
; 37 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c21, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c21.x
mov r0.xyz, c17
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c16.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c18, r0
mov r0, c9
dp4 r4.y, c18, r0
mov r1, c8
dp4 r4.x, c18, r1
mad r0.xyz, r4, c16.w, -v0
dp3 o2.y, r0, r2
dp3 o2.z, v2, r0
dp3 o2.x, r0, v1
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 o3.y, r2, r3
dp3 o3.z, v2, r3
dp3 o3.x, v1, r3
dp4 o4.z, r0, c14
dp4 o4.y, r0, c13
dp4 o4.x, r0, c12
mad o1.zw, v3.xyxy, c20.xyxy, c20
mad o1.xy, v3, c19, c19.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [unity_Scale]
Vector 18 [_WorldSpaceCameraPos]
Vector 19 [_WorldSpaceLightPos0]
Vector 20 [_MainTex_ST]
Vector 21 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 32 ALU
PARAM c[22] = { { 1 },
		state.matrix.mvp,
		program.local[5..21] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[18];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[17].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[19];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.y, R0, c[10];
DP4 R3.x, R0, c[9];
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 result.texcoord[1].y, R3, R1;
DP3 result.texcoord[2].y, R1, R2;
DP3 result.texcoord[1].z, vertex.normal, R3;
DP3 result.texcoord[1].x, R3, vertex.attrib[14];
DP3 result.texcoord[2].z, vertex.normal, R2;
DP3 result.texcoord[2].x, vertex.attrib[14], R2;
DP4 result.texcoord[3].y, R0, c[14];
DP4 result.texcoord[3].x, R0, c[13];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[21].xyxy, c[21];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[20], c[20].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 32 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [unity_Scale]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Vector 19 [_MainTex_ST]
Vector 20 [_BumpMap_ST]
"vs_3_0
; 35 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c21, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c21.x
mov r0.xyz, c17
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c16.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c18, r0
mov r0, c9
dp4 r4.y, c18, r0
mov r1, c8
dp4 r4.x, c18, r1
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 o2.y, r4, r2
dp3 o3.y, r2, r3
dp3 o2.z, v2, r4
dp3 o2.x, r4, v1
dp3 o3.z, v2, r3
dp3 o3.x, v1, r3
dp4 o4.y, r0, c13
dp4 o4.x, r0, c12
mad o1.zw, v3.xyxy, c20.xyxy, c20
mad o1.xy, v3, c19, c19.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [unity_World2Shadow]
Matrix 17 [_LightMatrix0]
Vector 21 [unity_Scale]
Vector 22 [_WorldSpaceCameraPos]
Vector 23 [_WorldSpaceLightPos0]
Vector 24 [_MainTex_ST]
Vector 25 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 39 ALU
PARAM c[26] = { { 1 },
		state.matrix.mvp,
		program.local[5..25] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[22];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[21].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[23];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R0.xyz, R3, c[21].w, -vertex.position;
DP4 R0.w, vertex.position, c[8];
DP3 result.texcoord[1].y, R0, R1;
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 result.texcoord[2].y, R1, R2;
DP3 result.texcoord[2].z, vertex.normal, R2;
DP3 result.texcoord[2].x, vertex.attrib[14], R2;
DP4 result.texcoord[3].w, R0, c[20];
DP4 result.texcoord[3].z, R0, c[19];
DP4 result.texcoord[3].y, R0, c[18];
DP4 result.texcoord[3].x, R0, c[17];
DP4 result.texcoord[4].w, R0, c[16];
DP4 result.texcoord[4].z, R0, c[15];
DP4 result.texcoord[4].y, R0, c[14];
DP4 result.texcoord[4].x, R0, c[13];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[25].xyxy, c[25];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[24], c[24].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 39 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [unity_World2Shadow]
Matrix 16 [_LightMatrix0]
Vector 20 [unity_Scale]
Vector 21 [_WorldSpaceCameraPos]
Vector 22 [_WorldSpaceLightPos0]
Vector 23 [_MainTex_ST]
Vector 24 [_BumpMap_ST]
"vs_3_0
; 42 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c25, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c25.x
mov r0.xyz, c21
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c20.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c22, r0
mov r0, c9
dp4 r4.y, c22, r0
mov r1, c8
dp4 r4.x, c22, r1
mad r0.xyz, r4, c20.w, -v0
dp4 r0.w, v0, c7
dp3 o2.y, r0, r2
dp3 o2.z, v2, r0
dp3 o2.x, r0, v1
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 o3.y, r2, r3
dp3 o3.z, v2, r3
dp3 o3.x, v1, r3
dp4 o4.w, r0, c19
dp4 o4.z, r0, c18
dp4 o4.y, r0, c17
dp4 o4.x, r0, c16
dp4 o5.w, r0, c15
dp4 o5.z, r0, c14
dp4 o5.y, r0, c13
dp4 o5.x, r0, c12
mad o1.zw, v3.xyxy, c24.xyxy, c24
mad o1.xy, v3, c23, c23.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [unity_World2Shadow]
Matrix 16 [_LightMatrix0]
Vector 20 [unity_Scale]
Vector 21 [_WorldSpaceCameraPos]
Vector 22 [_WorldSpaceLightPos0]
Vector 23 [_MainTex_ST]
Vector 24 [_BumpMap_ST]
"vs_3_0
; 42 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c25, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c25.x
mov r0.xyz, c21
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c20.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c22, r0
mov r0, c9
dp4 r4.y, c22, r0
mov r1, c8
dp4 r4.x, c22, r1
mad r0.xyz, r4, c20.w, -v0
dp4 r0.w, v0, c7
dp3 o2.y, r0, r2
dp3 o2.z, v2, r0
dp3 o2.x, r0, v1
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 o3.y, r2, r3
dp3 o3.z, v2, r3
dp3 o3.x, v1, r3
dp4 o4.w, r0, c19
dp4 o4.z, r0, c18
dp4 o4.y, r0, c17
dp4 o4.x, r0, c16
dp4 o5.w, r0, c15
dp4 o5.z, r0, c14
dp4 o5.y, r0, c13
dp4 o5.x, r0, c12
mad o1.zw, v3.xyxy, c24.xyxy, c24
mad o1.xy, v3, c23, c23.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_World2Object]
Vector 9 [_ProjectionParams]
Vector 10 [unity_Scale]
Vector 11 [_WorldSpaceCameraPos]
Vector 12 [_WorldSpaceLightPos0]
Vector 13 [_MainTex_ST]
Vector 14 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 31 ALU
PARAM c[15] = { { 1, 0.5 },
		state.matrix.mvp,
		program.local[5..14] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[11];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[7];
DP4 R2.y, R1, c[6];
DP4 R2.x, R1, c[5];
MAD R2.xyz, R2, c[10].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[12];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[7];
DP4 R3.y, R0, c[6];
DP4 R3.x, R0, c[5];
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
DP3 result.texcoord[1].y, R3, R1;
DP3 result.texcoord[2].y, R1, R2;
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[9].x;
DP3 result.texcoord[1].z, vertex.normal, R3;
DP3 result.texcoord[1].x, R3, vertex.attrib[14];
DP3 result.texcoord[2].z, vertex.normal, R2;
DP3 result.texcoord[2].x, vertex.attrib[14], R2;
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[3].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[14].xyxy, c[14];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[13], c[13].zwzw;
END
# 31 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_World2Object]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [unity_Scale]
Vector 11 [_WorldSpaceCameraPos]
Vector 12 [_WorldSpaceLightPos0]
Vector 13 [_MainTex_ST]
Vector 14 [_BumpMap_ST]
"vs_3_0
; 34 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c15, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c15.x
mov r0.xyz, c11
dp4 r1.z, r0, c6
dp4 r1.y, r0, c5
dp4 r1.x, r0, c4
mad r3.xyz, r1, c10.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c6
dp4 r4.z, c12, r0
mov r0, c5
dp4 r4.y, c12, r0
mov r1, c4
dp4 r4.x, c12, r1
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c15.y
mul r1.y, r1, c8.x
dp3 o2.y, r4, r2
dp3 o3.y, r2, r3
dp3 o2.z, v2, r4
dp3 o2.x, r4, v1
dp3 o3.z, v2, r3
dp3 o3.x, v1, r3
mad o4.xy, r1.z, c9.zwzw, r1
mov o0, r0
mov o4.zw, r0
mad o1.zw, v3.xyxy, c14.xyxy, c14
mad o1.xy, v3, c13, c13.zwzw
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [_ProjectionParams]
Vector 18 [unity_Scale]
Vector 19 [_WorldSpaceCameraPos]
Vector 20 [_WorldSpaceLightPos0]
Vector 21 [_MainTex_ST]
Vector 22 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 37 ALU
PARAM c[23] = { { 1, 0.5 },
		state.matrix.mvp,
		program.local[5..22] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.w, c[0].x;
MOV R1.xyz, c[19];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[18].w, -vertex.position;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[20];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.y, R0, c[10];
DP4 R3.x, R0, c[9];
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
DP4 R1.w, vertex.position, c[8];
DP3 result.texcoord[1].y, R3, R1;
DP3 result.texcoord[2].y, R1, R2;
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[17].x;
ADD result.texcoord[4].xy, R1, R1.z;
DP4 R1.z, vertex.position, c[7];
DP4 R1.x, vertex.position, c[5];
DP4 R1.y, vertex.position, c[6];
DP3 result.texcoord[1].z, vertex.normal, R3;
DP3 result.texcoord[1].x, R3, vertex.attrib[14];
DP3 result.texcoord[2].z, vertex.normal, R2;
DP3 result.texcoord[2].x, vertex.attrib[14], R2;
MOV result.position, R0;
DP4 result.texcoord[3].y, R1, c[14];
DP4 result.texcoord[3].x, R1, c[13];
MOV result.texcoord[4].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[22].xyxy, c[22];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[21], c[21].zwzw;
END
# 37 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [_ProjectionParams]
Vector 17 [_ScreenParams]
Vector 18 [unity_Scale]
Vector 19 [_WorldSpaceCameraPos]
Vector 20 [_WorldSpaceLightPos0]
Vector 21 [_MainTex_ST]
Vector 22 [_BumpMap_ST]
"vs_3_0
; 40 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c23, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c23.x
mov r0.xyz, c19
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c18.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r1, c8
dp4 r4.x, c20, r1
mov r0, c10
dp4 r4.z, c20, r0
mov r0, c9
dp4 r4.y, c20, r0
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c23.y
mul r1.y, r1, c16.x
mad o5.xy, r1.z, c17.zwzw, r1
dp4 r1.w, v0, c7
dp4 r1.z, v0, c6
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
dp3 o2.y, r4, r2
dp3 o3.y, r2, r3
dp3 o2.z, v2, r4
dp3 o2.x, r4, v1
dp3 o3.z, v2, r3
dp3 o3.x, v1, r3
mov o0, r0
dp4 o4.y, r1, c13
dp4 o4.x, r1, c12
mov o5.zw, r0
mad o1.zw, v3.xyxy, c22.xyxy, c22
mad o1.xy, v3, c21, c21.zwzw
"
}
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [unity_Scale]
Vector 18 [_WorldSpaceCameraPos]
Vector 19 [_WorldSpaceLightPos0]
Vector 20 [_LightPositionRange]
Vector 21 [_MainTex_ST]
Vector 22 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 35 ALU
PARAM c[23] = { { 1 },
		state.matrix.mvp,
		program.local[5..22] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[18];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[17].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[19];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R0.xyz, R3, c[17].w, -vertex.position;
DP3 result.texcoord[1].y, R0, R1;
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP4 R0.w, vertex.position, c[8];
DP3 result.texcoord[2].y, R1, R2;
DP3 result.texcoord[2].z, vertex.normal, R2;
DP3 result.texcoord[2].x, vertex.attrib[14], R2;
DP4 result.texcoord[3].z, R0, c[15];
DP4 result.texcoord[3].y, R0, c[14];
DP4 result.texcoord[3].x, R0, c[13];
ADD result.texcoord[4].xyz, R0, -c[20];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[22].xyxy, c[22];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[21], c[21].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 35 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [unity_Scale]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Vector 19 [_LightPositionRange]
Vector 20 [_MainTex_ST]
Vector 21 [_BumpMap_ST]
"vs_3_0
; 38 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c22, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c22.x
mov r0.xyz, c17
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c16.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c18, r0
mov r0, c9
dp4 r4.y, c18, r0
mov r1, c8
dp4 r4.x, c18, r1
mad r0.xyz, r4, c16.w, -v0
dp3 o2.y, r0, r2
dp3 o2.z, v2, r0
dp3 o2.x, r0, v1
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
dp3 o3.y, r2, r3
dp3 o3.z, v2, r3
dp3 o3.x, v1, r3
dp4 o4.z, r0, c14
dp4 o4.y, r0, c13
dp4 o4.x, r0, c12
add o5.xyz, r0, -c19
mad o1.zw, v3.xyxy, c21.xyxy, c21
mad o1.xy, v3, c20, c20.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [unity_Scale]
Vector 18 [_WorldSpaceCameraPos]
Vector 19 [_WorldSpaceLightPos0]
Vector 20 [_LightPositionRange]
Vector 21 [_MainTex_ST]
Vector 22 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 35 ALU
PARAM c[23] = { { 1 },
		state.matrix.mvp,
		program.local[5..22] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[18];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[17].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[19];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R0.xyz, R3, c[17].w, -vertex.position;
DP3 result.texcoord[1].y, R0, R1;
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP4 R0.w, vertex.position, c[8];
DP3 result.texcoord[2].y, R1, R2;
DP3 result.texcoord[2].z, vertex.normal, R2;
DP3 result.texcoord[2].x, vertex.attrib[14], R2;
DP4 result.texcoord[3].z, R0, c[15];
DP4 result.texcoord[3].y, R0, c[14];
DP4 result.texcoord[3].x, R0, c[13];
ADD result.texcoord[4].xyz, R0, -c[20];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[22].xyxy, c[22];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[21], c[21].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 35 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [unity_Scale]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Vector 19 [_LightPositionRange]
Vector 20 [_MainTex_ST]
Vector 21 [_BumpMap_ST]
"vs_3_0
; 38 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c22, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c22.x
mov r0.xyz, c17
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c16.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c18, r0
mov r0, c9
dp4 r4.y, c18, r0
mov r1, c8
dp4 r4.x, c18, r1
mad r0.xyz, r4, c16.w, -v0
dp3 o2.y, r0, r2
dp3 o2.z, v2, r0
dp3 o2.x, r0, v1
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
dp3 o3.y, r2, r3
dp3 o3.z, v2, r3
dp3 o3.x, v1, r3
dp4 o4.z, r0, c14
dp4 o4.y, r0, c13
dp4 o4.x, r0, c12
add o5.xyz, r0, -c19
mad o1.zw, v3.xyxy, c21.xyxy, c21
mad o1.xy, v3, c20, c20.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [unity_World2Shadow]
Matrix 17 [_LightMatrix0]
Vector 21 [unity_Scale]
Vector 22 [_WorldSpaceCameraPos]
Vector 23 [_WorldSpaceLightPos0]
Vector 24 [_MainTex_ST]
Vector 25 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 39 ALU
PARAM c[26] = { { 1 },
		state.matrix.mvp,
		program.local[5..25] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[22];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[21].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[23];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R0.xyz, R3, c[21].w, -vertex.position;
DP4 R0.w, vertex.position, c[8];
DP3 result.texcoord[1].y, R0, R1;
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 result.texcoord[2].y, R1, R2;
DP3 result.texcoord[2].z, vertex.normal, R2;
DP3 result.texcoord[2].x, vertex.attrib[14], R2;
DP4 result.texcoord[3].w, R0, c[20];
DP4 result.texcoord[3].z, R0, c[19];
DP4 result.texcoord[3].y, R0, c[18];
DP4 result.texcoord[3].x, R0, c[17];
DP4 result.texcoord[4].w, R0, c[16];
DP4 result.texcoord[4].z, R0, c[15];
DP4 result.texcoord[4].y, R0, c[14];
DP4 result.texcoord[4].x, R0, c[13];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[25].xyxy, c[25];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[24], c[24].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 39 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [unity_World2Shadow]
Matrix 16 [_LightMatrix0]
Vector 20 [unity_Scale]
Vector 21 [_WorldSpaceCameraPos]
Vector 22 [_WorldSpaceLightPos0]
Vector 23 [_MainTex_ST]
Vector 24 [_BumpMap_ST]
"vs_3_0
; 42 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c25, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c25.x
mov r0.xyz, c21
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c20.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c22, r0
mov r0, c9
dp4 r4.y, c22, r0
mov r1, c8
dp4 r4.x, c22, r1
mad r0.xyz, r4, c20.w, -v0
dp4 r0.w, v0, c7
dp3 o2.y, r0, r2
dp3 o2.z, v2, r0
dp3 o2.x, r0, v1
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 o3.y, r2, r3
dp3 o3.z, v2, r3
dp3 o3.x, v1, r3
dp4 o4.w, r0, c19
dp4 o4.z, r0, c18
dp4 o4.y, r0, c17
dp4 o4.x, r0, c16
dp4 o5.w, r0, c15
dp4 o5.z, r0, c14
dp4 o5.y, r0, c13
dp4 o5.x, r0, c12
mad o1.zw, v3.xyxy, c24.xyxy, c24
mad o1.xy, v3, c23, c23.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [unity_World2Shadow]
Matrix 16 [_LightMatrix0]
Vector 20 [unity_Scale]
Vector 21 [_WorldSpaceCameraPos]
Vector 22 [_WorldSpaceLightPos0]
Vector 23 [_MainTex_ST]
Vector 24 [_BumpMap_ST]
"vs_3_0
; 42 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c25, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c25.x
mov r0.xyz, c21
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c20.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c22, r0
mov r0, c9
dp4 r4.y, c22, r0
mov r1, c8
dp4 r4.x, c22, r1
mad r0.xyz, r4, c20.w, -v0
dp4 r0.w, v0, c7
dp3 o2.y, r0, r2
dp3 o2.z, v2, r0
dp3 o2.x, r0, v1
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 o3.y, r2, r3
dp3 o3.z, v2, r3
dp3 o3.x, v1, r3
dp4 o4.w, r0, c19
dp4 o4.z, r0, c18
dp4 o4.y, r0, c17
dp4 o4.x, r0, c16
dp4 o5.w, r0, c15
dp4 o5.z, r0, c14
dp4 o5.y, r0, c13
dp4 o5.x, r0, c12
mad o1.zw, v3.xyxy, c24.xyxy, c24
mad o1.xy, v3, c23, c23.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [unity_Scale]
Vector 18 [_WorldSpaceCameraPos]
Vector 19 [_WorldSpaceLightPos0]
Vector 20 [_LightPositionRange]
Vector 21 [_MainTex_ST]
Vector 22 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 35 ALU
PARAM c[23] = { { 1 },
		state.matrix.mvp,
		program.local[5..22] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[18];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[17].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[19];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R0.xyz, R3, c[17].w, -vertex.position;
DP3 result.texcoord[1].y, R0, R1;
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP4 R0.w, vertex.position, c[8];
DP3 result.texcoord[2].y, R1, R2;
DP3 result.texcoord[2].z, vertex.normal, R2;
DP3 result.texcoord[2].x, vertex.attrib[14], R2;
DP4 result.texcoord[3].z, R0, c[15];
DP4 result.texcoord[3].y, R0, c[14];
DP4 result.texcoord[3].x, R0, c[13];
ADD result.texcoord[4].xyz, R0, -c[20];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[22].xyxy, c[22];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[21], c[21].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 35 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [unity_Scale]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Vector 19 [_LightPositionRange]
Vector 20 [_MainTex_ST]
Vector 21 [_BumpMap_ST]
"vs_3_0
; 38 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c22, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c22.x
mov r0.xyz, c17
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c16.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c18, r0
mov r0, c9
dp4 r4.y, c18, r0
mov r1, c8
dp4 r4.x, c18, r1
mad r0.xyz, r4, c16.w, -v0
dp3 o2.y, r0, r2
dp3 o2.z, v2, r0
dp3 o2.x, r0, v1
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
dp3 o3.y, r2, r3
dp3 o3.z, v2, r3
dp3 o3.x, v1, r3
dp4 o4.z, r0, c14
dp4 o4.y, r0, c13
dp4 o4.x, r0, c12
add o5.xyz, r0, -c19
mad o1.zw, v3.xyxy, c21.xyxy, c21
mad o1.xy, v3, c20, c20.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [unity_Scale]
Vector 18 [_WorldSpaceCameraPos]
Vector 19 [_WorldSpaceLightPos0]
Vector 20 [_LightPositionRange]
Vector 21 [_MainTex_ST]
Vector 22 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 35 ALU
PARAM c[23] = { { 1 },
		state.matrix.mvp,
		program.local[5..22] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[18];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[17].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[19];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R0.xyz, R3, c[17].w, -vertex.position;
DP3 result.texcoord[1].y, R0, R1;
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP4 R0.w, vertex.position, c[8];
DP3 result.texcoord[2].y, R1, R2;
DP3 result.texcoord[2].z, vertex.normal, R2;
DP3 result.texcoord[2].x, vertex.attrib[14], R2;
DP4 result.texcoord[3].z, R0, c[15];
DP4 result.texcoord[3].y, R0, c[14];
DP4 result.texcoord[3].x, R0, c[13];
ADD result.texcoord[4].xyz, R0, -c[20];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[22].xyxy, c[22];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[21], c[21].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 35 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [unity_Scale]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Vector 19 [_LightPositionRange]
Vector 20 [_MainTex_ST]
Vector 21 [_BumpMap_ST]
"vs_3_0
; 38 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c22, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c22.x
mov r0.xyz, c17
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c16.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c18, r0
mov r0, c9
dp4 r4.y, c18, r0
mov r1, c8
dp4 r4.x, c18, r1
mad r0.xyz, r4, c16.w, -v0
dp3 o2.y, r0, r2
dp3 o2.z, v2, r0
dp3 o2.x, r0, v1
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
dp3 o3.y, r2, r3
dp3 o3.z, v2, r3
dp3 o3.x, v1, r3
dp4 o4.z, r0, c14
dp4 o4.y, r0, c13
dp4 o4.x, r0, c12
add o5.xyz, r0, -c19
mad o1.zw, v3.xyxy, c21.xyxy, c21
mad o1.xy, v3, c20, c20.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color3]
Float 3 [_Shininess3]
Vector 4 [_SpecColor3]
Float 5 [_Layer1Thickness]
Float 6 [_Layer2Thickness]
Float 7 [_GVar]
Float 8 [_ExitColorMultiplier]
Float 9 [_ExitColorRadius]
Float 10 [_SpecSmoothing]
Vector 11 [_Color2]
Float 12 [_Shininess2]
Vector 13 [_SpecColor2]
Float 14 [_BlendAdjust2]
Vector 15 [_Color]
Float 16 [_Shininess]
Float 17 [_BlendAdjust1]
Float 18 [_DDXP]
Float 19 [_DDXM]
Vector 20 [_SSSC]
SetTexture 0 [_MainTex3] 2D
SetTexture 1 [_ScatterMap] 2D
SetTexture 2 [_MainTex] 2D
SetTexture 3 [_BumpMap] 2D
SetTexture 4 [_MainTex2] 2D
SetTexture 5 [_ScatterMap2] 2D
SetTexture 6 [_LightTexture0] 2D
SetTexture 7 [_BumpMap3] 2D
SetTexture 8 [_ExitColorMap] 2D
SetTexture 9 [_BumpMap2] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 322 ALU, 11 TEX
PARAM c[26] = { program.local[0..20],
		{ 0, 1, 2, 0.73550957 },
		{ -0.73550957, 0, -1, 0.99270076 },
		{ -0.99270076, 2.718282, 0.5, 0.39894229 },
		{ 3.141593, -0.018729299, 0.074261002, 0.21211439 },
		{ 1.570729, 3.1415927, 5, 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEMP R7;
TEMP R8;
TEMP R9;
TEMP R10;
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.x, R0.x;
MUL R2.xyz, R0.x, fragment.texcoord[1];
MUL R0.x, R2.y, R2.y;
MAD R0.x, R2, R2, R0;
MAD R0.x, R2.z, R2.z, R0;
RSQ R2.w, R0.x;
MUL R0.y, R2.w, -R2.z;
MUL R0.x, R0.y, c[21].w;
DP3 R0.z, R2, R2;
RSQ R0.z, R0.z;
COS R0.x, R0.x;
MAD R0.x, R0.y, c[22], R0;
MUL R0.xy, R0.x, c[22].yzzw;
MUL R1.xyz, R0.z, R2;
MAD R3.xyz, R1, c[21].w, R0.xxyw;
MUL R0.x, R3.y, R3.y;
MAD R0.x, R3, R3, R0;
MAD R0.x, R3.z, R3.z, R0;
RSQ R0.x, R0.x;
MUL R0.y, R0.x, -R3.z;
MUL R0.x, R0.y, c[22].w;
DP3 R0.z, R3, R3;
RSQ R0.z, R0.z;
COS R0.x, R0.x;
MAD R0.x, R0.y, c[23], R0;
MUL R4.xyz, R0.z, R3;
MUL R0.xy, R0.x, c[22].yzzw;
MAD R7.xyz, R4, c[22].w, R0.xxyw;
DP3 R0.x, R7, R7;
RSQ R0.w, R0.x;
MUL R1.xyz, R0.w, R7;
MAD R0.xyz, -R4, c[5].x, R2;
MAD R6.xyz, -R1, c[6].x, R0;
TEX R0.yw, fragment.texcoord[0].zwzw, texture[7], 2D;
MAD R1.xy, R0.wyzw, c[21].z, -c[21].y;
MUL R0.w, R1.y, R1.y;
MAD R1.z, -R1.x, R1.x, -R0.w;
DP3 R0.x, R6, R6;
RSQ R0.x, R0.x;
MUL R8.xyz, R0.x, R6;
DP3 R0.x, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, fragment.texcoord[2];
ADD R5.xyz, R8, R0;
DP3 R0.w, R5, R5;
RSQ R0.w, R0.w;
ADD R1.z, R1, c[21].y;
RSQ R1.z, R1.z;
RCP R1.z, R1.z;
MUL R5.xyz, R0.w, R5;
DP3 R5.w, R1, R5;
ABS R3.w, R5;
MAD R0.w, R3, c[24].y, c[24].z;
MAD R0.w, R0, R3, -c[24];
MAD R1.w, R0, R3, c[25].x;
ADD R7.xyz, -R7, R2;
MUL R0.w, R7.y, R7.y;
MAD R4.w, R7.x, R7.x, R0;
DP3 R6.w, R1, R8;
MAX R0.w, R6, c[21].x;
MAD R6.w, R7.z, R7.z, R4;
ADD R7.xy, R6, -R2;
MOV R4.w, c[5].x;
RSQ R6.w, R6.w;
ADD R4.w, -R4, -c[6].x;
RCP R6.w, R6.w;
ADD R3.w, -R3, c[21].y;
RSQ R3.w, R3.w;
DP3 R9.x, R6, R2;
ADD R4.w, R4, c[21].z;
MUL R6.w, R6, c[7].x;
MUL R6.w, R6, R4;
MUL R4.w, R0, R0;
MUL R4.w, R4, R6;
MUL R4.w, R4, R6;
MUL R4.w, R4, c[23].z;
POW R6.w, c[23].y, -R4.w;
RCP R3.w, R3.w;
MUL R4.w, R1, R3;
MUL R3.w, -R6, c[23];
MUL R1.w, R6.y, R6.y;
MAD R6.w, R6.x, R6.x, R1;
ADD R3.w, R3, c[21].y;
MUL R1.w, R0, R3;
MAD R0.w, R6.z, R6.z, R6;
ADD_SAT R6.w, -R1, c[21].y;
RSQ R0.w, R0.w;
POW R6.w, R6.w, c[18].x;
RCP R0.w, R0.w;
MUL R0.w, R2, R0;
MUL R7.xy, R7, c[6].x;
MUL R7.xy, R7, R0.w;
MAD R7.xy, -R7, c[8].x, fragment.texcoord[0];
TEX R7, R7, texture[8], 2D;
MUL R6.w, R6, c[19].x;
MUL R6.w, R6, R7;
DP3 R0.w, fragment.texcoord[3], fragment.texcoord[3];
TEX R0.w, R0.w, texture[6], 2D;
MUL_SAT R8.w, R6, R0;
SLT R7.w, R5, c[21].x;
MUL R6.w, R7, R4;
MAD R4.w, -R6, c[21].z, R4;
MAD R4.w, R7, c[24].x, R4;
MUL R8.xyz, R8.w, R7;
MUL R6.xyz, R7, c[0];
MUL_SAT R7.x, R9, c[9];
MUL R9.xyz, R4, c[5].x;
MUL R6.xyz, R7.x, R6;
ADD R7.x, -R7, c[21].y;
MAD R6.xyz, R7.x, c[0], R6;
MUL R7.xyz, R8, c[20];
ADD R8.x, -R8.w, c[21].y;
MAD R7.xyz, R8.x, R6, R7;
TEX R6, fragment.texcoord[0], texture[0], 2D;
MUL R6.xyz, R6, c[2];
ADD R4.xyz, R2, -R9;
MUL R6.xyz, R6, R7;
COS R4.w, R4.w;
MUL R7.y, R4.w, R4.w;
MUL R8.w, c[10].x, c[10].x;
MUL R4.w, R7.y, R8;
MUL R7.x, R7.y, c[10];
MUL R4.w, R7.y, R4;
MUL R7.x, R7, c[10];
MUL R4.w, R4, c[25].y;
MOV R7.w, c[21].y;
ADD R7.y, -R7, c[21];
RCP R7.x, R7.x;
MUL R7.x, R7.y, R7;
RCP R4.w, R4.w;
POW R7.x, c[23].y, -R7.x;
MUL R7.y, R7.x, R4.w;
ADD R7.x, -R5.w, c[21].y;
ADD R4.w, R7, -c[3].x;
POW R7.x, R7.x, c[25].z;
MAD R4.w, R7.x, c[3].x, R4;
DP3 R7.x, R1, R0;
DP3 R1.x, R1, R2;
MUL R7.y, R7, R4.w;
DP3 R1.y, R5, R0;
RCP R1.z, R1.y;
MUL R1.y, R5.w, R7.x;
MUL R1.y, R1, R1.z;
MUL R1.x, R5.w, R1;
MUL R1.x, R1.z, R1;
RCP R4.w, R7.x;
MUL R7.y, R6.w, R7;
MUL_SAT R9.w, R7.y, R4;
MOV R4.w, c[25];
MUL R1.y, R1, c[21].z;
MUL R1.x, R1, c[21].z;
MIN_SAT R5.x, R1.y, R1;
MAX R1.y, R5.w, c[21].x;
TEX R5.yw, fragment.texcoord[0].zwzw, texture[9], 2D;
MAD R8.xy, R5.wyzw, c[21].z, -c[21].y;
MUL R5.y, R8, R8;
MAD R5.w, -R8.x, R8.x, -R5.y;
MUL R1.x, R4.w, c[3];
POW R1.x, R1.y, R1.x;
MUL R1.x, R6.w, R1;
MUL R5.z, R1.x, c[23];
DP3 R1.x, R4, R4;
RSQ R1.x, R1.x;
MUL R7.xyz, R1.x, R4;
ADD R1.xyz, R0, R7;
DP3 R5.y, R1, R1;
RSQ R5.y, R5.y;
MUL R10.xyz, R5.y, R1;
MAD R1.x, R9.w, R5, R5.z;
DP3 R9.w, R0, R10;
ADD R5.w, R5, c[21].y;
RSQ R5.w, R5.w;
RCP R8.z, R5.w;
DP3 R9.z, R8, R10;
ABS R1.z, R9;
MUL_SAT R5.y, R3.w, R1.x;
DP3 R6.w, R0, R8;
ADD R1.x, -R1.z, c[21].y;
MAD R1.y, R1.z, c[24], c[24].z;
MAD R1.y, R1, R1.z, -c[24].w;
RSQ R1.x, R1.x;
DP3 R7.y, R8, R7;
ADD R10.xyz, -R3, R2;
MUL R5.w, R0, c[21].z;
SLT R3.w, R9.z, c[21].x;
RCP R1.x, R1.x;
MAD R1.y, R1, R1.z, c[25].x;
MUL R5.z, R1.y, R1.x;
MUL R5.x, R3.w, R5.z;
MAD R5.x, -R5, c[21].z, R5.z;
MOV R1.xyz, c[4];
MUL R1.xyz, R1, c[0];
MUL R1.xyz, R1, R5.y;
MAD R1.xyz, R6, R1.w, R1;
MAD R3.w, R3, c[24].x, R5.x;
COS R1.w, R3.w;
MUL R1.w, R1, R1;
MUL R5.xyz, R1, R5.w;
MUL R1.x, R8.w, R1.w;
MUL R1.y, R1.w, c[10].x;
MUL R1.x, R1.w, R1;
MUL R1.y, R1, c[10].x;
ADD R1.z, -R1.w, c[21].y;
RCP R1.y, R1.y;
MUL R1.y, R1.z, R1;
POW R1.z, c[23].y, -R1.y;
MUL R1.x, R1, c[25].y;
RCP R1.y, R1.x;
MUL R3.w, R1.z, R1.y;
ADD R1.x, -R9.z, c[21].y;
POW R1.z, R1.x, c[25].z;
TEX R1.yw, fragment.texcoord[0].zwzw, texture[3], 2D;
MAD R6.xy, R1.wyzw, c[21].z, -c[21].y;
ADD R1.x, R7.w, -c[12];
MAD R1.y, R1.z, c[12].x, R1.x;
MUL R6.z, R3.w, R1.y;
MUL R1.x, R6.y, R6.y;
MAD R3.w, -R6.x, R6.x, -R1.x;
TEX R1, fragment.texcoord[0], texture[2], 2D;
ADD R3.w, R3, c[21].y;
MUL R1.xyz, R1, c[15];
MUL R7.w, R6.z, R1;
RSQ R3.w, R3.w;
RCP R6.z, R3.w;
DP3 R3.w, R0, R6;
RCP R6.w, R6.w;
MUL_SAT R7.w, R7, R6;
DP3 R6.w, R2, R6;
MUL R3.w, R9.z, R3;
MUL R8.w, R9.z, R6;
RCP R9.w, R9.w;
MUL R8.w, R9, R8;
MUL R9.w, R3, R9;
MUL R3.w, R8, c[21].z;
MUL R8.w, R9, c[21].z;
MIN_SAT R8.w, R8, R3;
ADD R0.xyz, R2, R0;
MUL R3.w, R4, c[12].x;
MAX R9.z, R9, c[21].x;
POW R9.z, R9.z, R3.w;
TEX R3, fragment.texcoord[0], texture[4], 2D;
MUL R3.w, R3, R9.z;
MUL R9.z, R3.w, c[23];
MUL R9.w, R10.y, R10.y;
MAD R3.w, R10.x, R10.x, R9;
MAD R7.x, R10.z, R10.z, R3.w;
MAX R3.w, R7.y, c[21].x;
RSQ R7.y, R7.x;
MOV R7.x, c[21].y;
RCP R7.y, R7.y;
ADD R7.x, R7, -c[5];
MUL R7.y, R7, c[7].x;
MUL R7.z, R7.y, R7.x;
MUL R7.x, R3.w, R3.w;
MUL R7.y, R7.x, R7.z;
MUL R7.z, R7.y, R7;
MUL R7.y, R4, R4;
MAD R7.y, R4.x, R4.x, R7;
MAD R7.y, R4.z, R4.z, R7;
MUL R7.z, R7, c[23];
POW R7.z, c[23].y, -R7.z;
MUL R7.z, -R7, c[23].w;
ADD R7.z, R7, c[21].y;
MAD R7.x, R7.w, R8.w, R9.z;
MUL_SAT R7.w, R7.z, R7.x;
RSQ R7.y, R7.y;
RCP R7.x, R7.y;
MUL R2.w, R2, R7.x;
MUL R7.xy, -R9, c[5].x;
MUL R7.xy, R7, R2.w;
MUL R3.w, R3, R7.z;
MAD R7.xy, -R7, c[8].x, fragment.texcoord[0];
TEX R8, R7, texture[8], 2D;
ADD_SAT R2.w, -R3, c[21].y;
POW R2.w, R2.w, c[18].x;
MUL R2.w, R2, c[19].x;
MUL R2.w, R2, R8;
MUL_SAT R0.w, R0, R2;
DP3 R2.w, R2, R4;
MUL R9.xyz, R0.w, R8;
MUL R4.xyz, R8, c[0];
MUL_SAT R2.w, R2, c[9].x;
MUL R4.xyz, R2.w, R4;
ADD R2.w, -R2, c[21].y;
MAD R4.xyz, R2.w, c[0], R4;
DP3 R2.w, R0, R0;
MOV R7.xyz, c[13];
MUL R7.xyz, R7, c[0];
RSQ R2.w, R2.w;
MUL R0.xyz, R2.w, R0;
DP3 R0.y, R6, R0;
ADD R0.w, -R0, c[21].y;
MUL R8.xyz, R9, c[20];
MAD R4.xyz, R0.w, R4, R8;
MUL R3.xyz, R3, c[11];
TEX R0.w, fragment.texcoord[0], texture[5], 2D;
ADD_SAT R0.w, R0, c[14].x;
MAX R0.y, R0, c[21].x;
MUL R0.x, R4.w, c[16];
POW R0.x, R0.y, R0.x;
MUL R7.xyz, R7, R7.w;
MUL R3.xyz, R3, R4;
MAD R3.xyz, R3, R3.w, R7;
MUL R2.xyz, R5.w, R3;
MUL R2.xyz, R0.w, R2;
ADD R0.w, -R0, c[21].y;
MAD R2.xyz, R0.w, R5, R2;
MOV R3.xyz, c[1];
MAX R0.w, R6, c[21].x;
MUL_SAT R0.x, R1.w, R0;
MUL R3.xyz, R3, c[0];
MUL R0.xyz, R3, R0.x;
MUL R1.xyz, R1, c[0];
MAD R0.xyz, R1, R0.w, R0;
TEX R0.w, fragment.texcoord[0], texture[1], 2D;
ADD_SAT R0.w, R0, c[17].x;
MUL R0.xyz, R5.w, R0;
MUL R0.xyz, R0.w, R0;
ADD R0.w, -R0, c[21].y;
MAD result.color.xyz, R0.w, R2, R0;
MOV result.color.w, c[21].x;
END
# 322 instructions, 11 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color3]
Float 3 [_Shininess3]
Vector 4 [_SpecColor3]
Float 5 [_Layer1Thickness]
Float 6 [_Layer2Thickness]
Float 7 [_GVar]
Float 8 [_ExitColorMultiplier]
Float 9 [_ExitColorRadius]
Float 10 [_SpecSmoothing]
Vector 11 [_Color2]
Float 12 [_Shininess2]
Vector 13 [_SpecColor2]
Float 14 [_BlendAdjust2]
Vector 15 [_Color]
Float 16 [_Shininess]
Float 17 [_BlendAdjust1]
Float 18 [_DDXP]
Float 19 [_DDXM]
Vector 20 [_SSSC]
SetTexture 0 [_MainTex3] 2D
SetTexture 1 [_ScatterMap] 2D
SetTexture 2 [_MainTex] 2D
SetTexture 3 [_BumpMap] 2D
SetTexture 4 [_MainTex2] 2D
SetTexture 5 [_ScatterMap2] 2D
SetTexture 6 [_LightTexture0] 2D
SetTexture 7 [_BumpMap3] 2D
SetTexture 8 [_ExitColorMap] 2D
SetTexture 9 [_BumpMap2] 2D
"ps_3_0
; 380 ALU, 11 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
dcl_2d s7
dcl_2d s8
dcl_2d s9
def c21, 2.00000000, -1.00000000, 0.11705996, 0.50000000
def c22, 6.28318501, -3.14159298, -0.73550957, 0.73550957
def c23, 0.00000000, -1.00000000, 0.15799320, 0.50000000
def c24, -0.99270076, 0.99270076, 2.71828198, -0.21211439
def c25, 0.39894229, 1.00000000, 0.00000000, 1.57072902
def c26, -0.01872930, 0.07426100, 3.14159298, 3.14159274
def c27, 0.15915491, 0.50000000, 5.00000000, 128.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
texld r5.yw, v0.zwzw, s7
dp3_pp r0.x, v1, v1
rsq_pp r0.x, r0.x
mul_pp r3.xyz, r0.x, v1
mul r0.x, r3.y, r3.y
mad r0.x, r3, r3, r0
mad r0.x, r3.z, r3.z, r0
rsq r2.w, r0.x
mul r1.x, r2.w, -r3.z
mad r0.x, r1, c21.z, c21.w
frc r0.x, r0
mad r1.y, r0.x, c22.x, c22
sincos r0.xy, r1.y
mad r0.z, r1.x, c22, r0.x
dp3 r0.y, r3, r3
mad_pp r7.xy, r5.wyzw, c21.x, c21.y
mul r1.xy, r0.z, c23
rsq r0.x, r0.y
mul r0.xyz, r0.x, r3
mad r4.xyz, r0, c22.w, r1.xxyw
mul r0.x, r4.y, r4.y
mad r0.x, r4, r4, r0
mad r0.x, r4.z, r4.z, r0
rsq r0.x, r0.x
mul r1.x, r0, -r4.z
mad r0.x, r1, c23.z, c23.w
frc r0.x, r0
mad r1.y, r0.x, c22.x, c22
sincos r0.xy, r1.y
mad r0.z, r1.x, c24.x, r0.x
dp3 r0.y, r4, r4
rsq r0.x, r0.y
mul r8.xyz, r0.x, r4
add r4.xyz, -r4, r3
mul r0.zw, r0.z, c23.xyxy
mad r0.xyz, r8, c24.y, r0.zzww
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, r0
add r0.xyz, -r0, r3
mad r2.xyz, -r8, c5.x, r3
mad r6.xyz, -r1, c6.x, r2
mul r4.w, r0.y, r0.y
dp3 r0.w, r6, r6
rsq r0.w, r0.w
mul r1.xyz, r0.w, r6
dp3_pp r0.w, v2, v2
rsq_pp r0.w, r0.w
mul_pp r2.xyz, r0.w, v2
add r5.xyz, r1, r2
mul_pp r0.w, r7.y, r7.y
mad_pp r0.w, -r7.x, r7.x, -r0
dp3 r1.w, r5, r5
rsq r1.w, r1.w
add_pp r0.w, r0, c25.y
rsq_pp r0.w, r0.w
rcp_pp r7.z, r0.w
dp3 r0.y, r7, r1
mul r9.xyz, r1.w, r5
dp3 r6.w, r7, r9
abs r0.w, r6
add r3.w, -r0, c25.y
mad r1.w, r0, c26.x, c26.y
mad r1.w, r1, r0, c24
rsq r3.w, r3.w
mul r4.y, r4, r4
mad r4.y, r4.x, r4.x, r4
mad r0.x, r0, r0, r4.w
max r1.x, r0.y, c23
mad r0.y, r0.z, r0.z, r0.x
mov r0.x, c6
mad r0.w, r1, r0, c25
rcp r3.w, r3.w
mul r1.w, r0, r3
cmp r0.w, r6, c25.z, c25.y
mul r3.w, r0, r1
add r0.z, -c5.x, -r0.x
rsq r0.y, r0.y
rcp r0.x, r0.y
add r0.y, r0.z, c21.x
mul r0.x, r0, c7
mul r0.y, r0.x, r0
mul r0.x, r1, r1
mul r0.x, r0, r0.y
mul r0.x, r0, r0.y
mad r0.z, -r3.w, c21.x, r1.w
mad r0.y, r0.w, c26.z, r0.z
mul r1.y, r0.x, c21.w
mad r1.z, r0.y, c27.x, c27.y
pow r0, c24.z, -r1.y
frc r0.y, r1.z
mad r4.w, -r0.x, c25.x, c25.y
mul r3.w, r1.x, r4
mul r0.x, r6.y, r6.y
mad r0.y, r0, c22.x, c22
sincos r5.xy, r0.y
mad r1.y, r6.x, r6.x, r0.x
add_sat r1.x, -r3.w, c25.y
pow r0, r1.x, c18.x
mad r0.y, r6.z, r6.z, r1
rsq r0.y, r0.y
mov r0.z, r0.x
rcp r0.w, r0.y
add r0.xy, r6, -r3
mul r0.w, r2, r0
mul r0.xy, r0, c6.x
mul r0.xy, r0, r0.w
mad r1.xy, -r0, c8.x, v0
dp3 r0.w, r6, r3
dp3 r0.x, v3, v3
texld r1, r1, s8
mul r0.z, r0, c19.x
texld r0.x, r0.x, s6
mul r0.y, r0.z, r1.w
mul_sat r0.z, r0.y, r0.x
mul r0.y, r5.x, r5.x
mul r5.xyz, r0.z, r1
mul r7.w, c10.x, c10.x
mad r4.y, r4.z, r4.z, r4
mul_sat r0.w, r0, c9.x
mul_pp r1.xyz, r1, c0
mul r1.xyz, r0.w, r1
add r0.w, -r0, c25.y
mad r1.xyz, r0.w, c0, r1
mul r5.xyz, r5, c20
add r0.z, -r0, c25.y
mad r1.xyz, r0.z, r1, r5
texld r5, v0, s0
mul_pp r5.xyz, r5, c2
mul r0.z, r0.y, c10.x
mul r0.z, r0, c10.x
rcp r0.w, r0.z
add r0.z, -r0.y, c25.y
mul r0.z, r0, r0.w
mul_pp r6.xyz, r5, r1
pow r1, c24.z, -r0.z
mul r0.z, r0.y, r7.w
mul r0.y, r0, r0.z
mul r0.y, r0, c26.w
mov r0.z, r1.x
add r0.w, -r6, c25.y
pow r1, r0.w, c27.z
rcp r0.y, r0.y
mul r0.y, r0.z, r0
mov_pp r0.w, c3.x
add_pp r0.w, c25.y, -r0
mad r0.w, r1.x, c3.x, r0
mul r0.y, r0, r0.w
dp3_pp r0.z, r7, r2
dp3_pp r1.x, r9, r2
mul r0.y, r5.w, r0
rcp r0.w, r0.z
mul_sat r8.w, r0.y, r0
mul r0.y, r6.w, r0.z
dp3_pp r0.z, r7, r3
mul r1.y, r6.w, r0.z
rcp r1.x, r1.x
mul r0.y, r0, r1.x
mul r1.x, r1, r1.y
texld r1.yw, v0.zwzw, s9
mul r9.w, r0.y, c21.x
mul r0.yzw, r8.xxyz, c5.x
add r7.xyz, r3, -r0.yzww
mul r10.x, r1, c21
dp3 r0.w, r7, r7
rsq r0.w, r0.w
mad_pp r5.xy, r1.wyzw, c21.x, c21.y
mul r8.xyz, r0.w, r7
add r1.xyz, r2, r8
dp3 r1.w, r1, r1
mul_pp r0.w, r5.y, r5.y
mad_pp r0.w, -r5.x, r5.x, -r0
rsq r1.w, r1.w
add_pp r0.w, r0, c25.y
rsq_pp r0.w, r0.w
rcp_pp r5.z, r0.w
dp3 r4.x, r5, r8
mul r9.xyz, r1.w, r1
dp3 r0.w, r5, r9
abs r1.x, r0.w
max r8.x, r4, c23
rsq r4.x, r4.y
rcp r4.z, r4.x
min_sat r9.w, r9, r10.x
add r1.z, -r1.x, c25.y
mad r1.y, r1.x, c26.x, c26
mad r1.y, r1, r1.x, c24.w
rsq r1.z, r1.z
mov r4.x, c5
cmp r10.x, r0.w, c25.z, c25.y
mad r1.x, r1.y, r1, c25.w
rcp r1.z, r1.z
mul r1.y, r1.x, r1.z
mul r1.z, r10.x, r1.y
mov_pp r1.x, c3
mul_pp r10.y, c27.w, r1.x
mad r10.z, -r1, c21.x, r1.y
max r6.w, r6, c23.x
pow r1, r6.w, r10.y
mad r1.y, r10.x, c26.z, r10.z
mul r1.x, r5.w, r1
mad r1.y, r1, c27.x, c27
frc r1.y, r1
mad r6.w, r1.y, c22.x, c22.y
mul r5.w, r1.x, c21
sincos r1.xy, r6.w
mad r1.y, r8.w, r9.w, r5.w
mul_sat r1.w, r4, r1.y
mul r4.w, r1.x, r1.x
dp3_pp r8.w, r2, r9
mov_pp r1.xyz, c0
mul_pp r1.xyz, c4, r1
mul r1.xyz, r1, r1.w
mad r6.xyz, r6, r3.w, r1
mul_pp r3.w, r0.x, c21.x
mul r5.w, r4, c10.x
mul r1.w, r5, c10.x
add r1.x, -r4.w, c25.y
rcp r1.y, r1.w
mul r5.w, r1.x, r1.y
pow r1, c24.z, -r5.w
mul r1.y, r7.w, r4.w
mov r5.w, r1.x
mul r1.x, r4.w, r1.y
add r6.w, -r0, c25.y
mul r4.w, r1.x, c26
pow r1, r6.w, c27.z
rcp r1.y, r4.w
mul r1.z, r5.w, r1.y
mov r4.w, r1.x
texld r1.yw, v0.zwzw, s3
mad_pp r10.xy, r1.wyzw, c21.x, c21.y
mul_pp r1.y, r10, r10
mad_pp r5.w, -r10.x, r10.x, -r1.y
add_pp r5.w, r5, c25.y
rsq_pp r6.w, r5.w
dp3_pp r5.w, r2, r5
rcp_pp r10.z, r6.w
mov_pp r1.x, c12
add_pp r1.x, c25.y, -r1
mad r1.x, r4.w, c12, r1
mul r4.w, r1.z, r1.x
texld r1, v0, s2
mul_pp r1.xyz, r1, c15
dp3_pp r6.w, r3, r10
mul r4.y, r8.x, r8.x
mul r4.w, r4, r1
rcp r5.w, r5.w
mul_sat r7.w, r4, r5
dp3_pp r5.w, r2, r10
mul r4.w, r0, r6
mul r5.w, r0, r5
rcp r8.w, r8.w
mul r5.w, r5, r8
mul r8.w, r8, r4
mul r4.w, r5, c21.x
mul r5.w, r8, c21.x
min_sat r8.w, r4, r5
mov_pp r4.w, c12.x
mul_pp r5.z, c27.w, r4.w
max r0.w, r0, c23.x
mul r4.z, r4, c7.x
add r4.x, c25.y, -r4
mul r5.x, r4.z, r4
mul r5.y, r4, r5.x
pow r4, r0.w, r5.z
mul r0.w, r5.y, r5.x
mov r8.y, r4.x
texld r5, v0, s4
mul r0.w, r0, c21
pow r4, c24.z, -r0.w
mov r0.w, r4.x
mul r4.y, r7, r7
mad r4.x, r7, r7, r4.y
dp3 r7.x, r3, r7
add_pp r3.xyz, r3, r2
mad r4.x, r7.z, r7.z, r4
mov_pp r2.xyz, c0
mul r8.z, r5.w, r8.y
mad r0.w, -r0, c25.x, c25.y
mul r5.w, r8.x, r0
rsq r4.x, r4.x
rcp r8.y, r4.x
add_sat r8.x, -r5.w, c25.y
pow r4, r8.x, c18.x
mul r4.zw, -r0.xyyz, c5.x
mul r2.w, r2, r8.y
mul r4.zw, r4, r2.w
mov r0.y, r4.x
mul r0.z, r8, c21.w
mad r2.w, r7, r8, r0.z
mul_sat r0.w, r0, r2
mad r8.xy, -r4.zwzw, c8.x, v0
mul_pp r2.xyz, c13, r2
dp3_pp r2.w, r3, r3
mul r2.xyz, r2, r0.w
texld r4, r8, s8
mul r0.y, r0, c19.x
mul r0.y, r0, r4.w
mul_sat r4.w, r0.x, r0.y
mul r0.xyz, r4.w, r4
rsq_pp r0.w, r2.w
mul_sat r7.x, r7, c9
mul_pp r4.xyz, r4, c0
mul r4.xyz, r7.x, r4
add r7.x, -r7, c25.y
mad r4.xyz, r7.x, c0, r4
mul r6.xyz, r6, r3.w
mul r0.xyz, r0, c20
add r4.w, -r4, c25.y
mad r0.xyz, r4.w, r4, r0
mul_pp r4.xyz, r5, c11
mul_pp r0.xyz, r4, r0
mad r0.xyz, r0, r5.w, r2
mul_pp r2.xyz, r0.w, r3
dp3_pp r0.w, r10, r2
max_pp r3.x, r0.w, c23
mov_pp r2.x, c16
mul_pp r3.y, c27.w, r2.x
pow r2, r3.x, r3.y
texld r0.w, v0, s5
mul r0.xyz, r3.w, r0
add_sat r0.w, r0, c14.x
mul_pp r3.xyz, r0.w, r0
add_pp r0.x, -r0.w, c25.y
mov r0.w, r2.x
mov_pp r2.xyz, c0
mul_sat r0.w, r1, r0
mul_pp r2.xyz, c1, r2
mul r2.xyz, r2, r0.w
max_pp r0.w, r6, c23.x
mul_pp r1.xyz, r1, c0
mad r1.xyz, r1, r0.w, r2
texld r0.w, v0, s1
add_sat r0.w, r0, c17.x
mul r1.xyz, r3.w, r1
mul_pp r1.xyz, r0.w, r1
mad_pp r0.xyz, r0.x, r6, r3
add_pp r0.w, -r0, c25.y
mad_pp oC0.xyz, r0.w, r0, r1
mov_pp oC0.w, c23.x
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color3]
Float 3 [_Shininess3]
Vector 4 [_SpecColor3]
Float 5 [_Layer1Thickness]
Float 6 [_Layer2Thickness]
Float 7 [_GVar]
Float 8 [_ExitColorMultiplier]
Float 9 [_ExitColorRadius]
Float 10 [_SpecSmoothing]
Vector 11 [_Color2]
Float 12 [_Shininess2]
Vector 13 [_SpecColor2]
Float 14 [_BlendAdjust2]
Vector 15 [_Color]
Float 16 [_Shininess]
Float 17 [_BlendAdjust1]
Float 18 [_DDXP]
Float 19 [_DDXM]
Vector 20 [_SSSC]
SetTexture 0 [_MainTex3] 2D
SetTexture 1 [_ScatterMap] 2D
SetTexture 2 [_MainTex] 2D
SetTexture 3 [_BumpMap] 2D
SetTexture 4 [_MainTex2] 2D
SetTexture 5 [_ScatterMap2] 2D
SetTexture 6 [_BumpMap3] 2D
SetTexture 7 [_ExitColorMap] 2D
SetTexture 8 [_BumpMap2] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 314 ALU, 10 TEX
PARAM c[26] = { program.local[0..20],
		{ 0, 1, 2, 0.73550957 },
		{ -0.73550957, 0, -1, 0.99270076 },
		{ -0.99270076, 2.718282, 0.5, 0.39894229 },
		{ 3.141593, -0.018729299, 0.074261002, 0.21211439 },
		{ 1.570729, 3.1415927, 5, 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEMP R7;
TEMP R8;
MUL R0.x, fragment.texcoord[1].y, fragment.texcoord[1].y;
MAD R0.x, fragment.texcoord[1], fragment.texcoord[1], R0;
MAD R0.x, fragment.texcoord[1].z, fragment.texcoord[1].z, R0;
RSQ R2.w, R0.x;
MUL R0.y, R2.w, -fragment.texcoord[1].z;
MUL R0.x, R0.y, c[21].w;
COS R0.z, R0.x;
MAD R0.y, R0, c[22].x, R0.z;
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
MUL R1.xy, R0.y, c[22].yzzw;
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, fragment.texcoord[1];
MAD R2.xyz, R0, c[21].w, R1.xxyw;
MUL R0.x, R2.y, R2.y;
MAD R0.x, R2, R2, R0;
MAD R0.x, R2.z, R2.z, R0;
RSQ R0.x, R0.x;
MUL R0.y, R0.x, -R2.z;
MUL R0.x, R0.y, c[22].w;
COS R0.z, R0.x;
MAD R0.y, R0, c[23].x, R0.z;
DP3 R0.x, R2, R2;
RSQ R0.x, R0.x;
MUL R3.xyz, R0.x, R2;
MUL R0.zw, R0.y, c[22].xyyz;
MAD R4.xyz, R3, c[22].w, R0.zzww;
DP3 R0.x, R4, R4;
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, R4;
ADD R4.xyz, -R4, fragment.texcoord[1];
MAD R1.xyz, -R3, c[5].x, fragment.texcoord[1];
MAD R5.xyz, -R0, c[6].x, R1;
DP3 R0.x, R5, R5;
TEX R0.yw, fragment.texcoord[0].zwzw, texture[6], 2D;
MAD R1.xy, R0.wyzw, c[21].z, -c[21].y;
RSQ R0.x, R0.x;
MUL R6.xyz, R0.x, R5;
MUL R0.w, R1.y, R1.y;
MAD R0.w, -R1.x, R1.x, -R0;
DP3 R0.x, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.x, R0.x;
MUL R7.xyz, R0.x, fragment.texcoord[2];
ADD R0.xyz, R6, R7;
DP3 R1.z, R0, R0;
RSQ R1.z, R1.z;
ADD R0.w, R0, c[21].y;
MUL R8.xyz, R1.z, R0;
RSQ R0.w, R0.w;
RCP R1.z, R0.w;
DP3 R1.w, R1, R8;
ABS R0.x, R1.w;
DP3 R5.w, R1, R7;
DP3 R8.w, R1, fragment.texcoord[1];
DP3 R1.x, R1, R6;
ADD R0.z, -R0.x, c[21].y;
MAD R0.y, R0.x, c[24], c[24].z;
MAD R0.y, R0, R0.x, -c[24].w;
RCP R7.w, R5.w;
MUL R4.y, R4, R4;
MAD R1.y, R4.x, R4.x, R4;
MAD R1.y, R4.z, R4.z, R1;
RSQ R0.z, R0.z;
MOV R1.z, c[5].x;
RSQ R1.y, R1.y;
ADD R1.z, -R1, -c[6].x;
RCP R1.y, R1.y;
ADD R2.xyz, -R2, fragment.texcoord[1];
MAD R0.x, R0.y, R0, c[25];
RCP R0.z, R0.z;
MUL R0.y, R0.x, R0.z;
SLT R0.x, R1.w, c[21];
MUL R0.z, R0.x, R0.y;
MAD R0.y, -R0.z, c[21].z, R0;
MAD R0.x, R0, c[24], R0.y;
COS R0.x, R0.x;
MUL R0.x, R0, R0;
MUL R3.w, c[10].x, c[10].x;
MUL R0.z, R0.x, R3.w;
MUL R0.y, R0.x, c[10].x;
MUL R0.z, R0.x, R0;
MUL R0.y, R0, c[10].x;
MOV R4.w, c[21].y;
MAX R1.x, R1, c[21];
MUL R0.z, R0, c[25].y;
RCP R0.y, R0.y;
ADD R0.x, -R0, c[21].y;
MUL R0.x, R0, R0.y;
RCP R0.y, R0.z;
POW R0.x, c[23].y, -R0.x;
MUL R0.x, R0, R0.y;
ADD R0.y, -R1.w, c[21];
ADD R0.z, R4.w, -c[3].x;
POW R0.y, R0.y, c[25].z;
MAD R0.y, R0, c[3].x, R0.z;
MUL R6.w, R0.x, R0.y;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R6.w, R0, R6;
MUL_SAT R7.w, R6, R7;
DP3 R6.w, R8, R7;
RCP R6.w, R6.w;
MUL R5.w, R1, R5;
MUL R8.x, R1.w, R8.w;
MUL R5.w, R5, R6;
MUL R8.x, R6.w, R8;
MUL R6.w, R8.x, c[21].z;
MUL R5.w, R5, c[21].z;
MIN_SAT R8.x, R5.w, R6.w;
MOV R5.w, c[25];
MUL R6.w, R5, c[3].x;
MAX R1.w, R1, c[21].x;
POW R1.w, R1.w, R6.w;
MUL R1.w, R0, R1;
MUL R4.x, R1.w, c[23].z;
MUL R1.y, R1, c[7].x;
ADD R1.z, R1, c[21];
MUL R1.z, R1.y, R1;
MUL R1.y, R1.x, R1.x;
MUL R1.y, R1, R1.z;
MUL R0.w, R1.y, R1.z;
MUL R1.y, R5, R5;
MAD R1.y, R5.x, R5.x, R1;
MAD R1.y, R5.z, R5.z, R1;
RSQ R1.y, R1.y;
RCP R1.z, R1.y;
MUL R0.w, R0, c[23].z;
POW R0.w, c[23].y, -R0.w;
MUL R0.w, -R0, c[23];
ADD R0.w, R0, c[21].y;
MUL R6.w, R1.x, R0;
ADD R1.xy, R5, -fragment.texcoord[1];
DP3 R5.x, R5, fragment.texcoord[1];
MUL R1.z, R2.w, R1;
MUL R1.xy, R1, c[6].x;
MUL R1.xy, R1, R1.z;
ADD_SAT R1.z, -R6.w, c[21].y;
POW R4.y, R1.z, c[18].x;
MAD R1.xy, -R1, c[8].x, fragment.texcoord[0];
TEX R1, R1, texture[7], 2D;
MUL R4.y, R4, c[19].x;
MUL_SAT R6.x, R4.y, R1.w;
MAD R1.w, R7, R8.x, R4.x;
MUL R4.xyz, R6.x, R1;
MUL_SAT R0.w, R0, R1;
MUL R8.xyz, R3, c[5].x;
MUL_SAT R5.x, R5, c[9];
MUL R1.xyz, R1, c[0];
MUL R1.xyz, R5.x, R1;
ADD R5.x, -R5, c[21].y;
MAD R1.xyz, R5.x, c[0], R1;
ADD R5.x, -R6, c[21].y;
MUL R4.xyz, R4, c[20];
MAD R1.xyz, R5.x, R1, R4;
MUL R0.xyz, R0, c[2];
MUL R0.xyz, R0, R1;
MOV R1.xyz, c[4];
MUL R1.xyz, R1, c[0];
MUL R3.xyz, R1, R0.w;
ADD R4.xyz, fragment.texcoord[1], -R8;
DP3 R0.w, R4, R4;
MAD R0.xyz, R0, R6.w, R3;
TEX R1.yw, fragment.texcoord[0].zwzw, texture[8], 2D;
RSQ R0.w, R0.w;
MUL R5.xyz, R0.w, R4;
MAD R1.xy, R1.wyzw, c[21].z, -c[21].y;
ADD R6.xyz, R7, R5;
MUL R0.w, R1.y, R1.y;
MAD R0.w, -R1.x, R1.x, -R0;
DP3 R1.z, R6, R6;
RSQ R1.z, R1.z;
ADD R0.w, R0, c[21].y;
MUL R6.xyz, R1.z, R6;
RSQ R0.w, R0.w;
RCP R1.z, R0.w;
DP3 R0.w, R1, R6;
ABS R1.w, R0;
ADD R3.y, -R1.w, c[21];
MAD R3.x, R1.w, c[24].y, c[24].z;
MAD R3.x, R3, R1.w, -c[24].w;
MAD R1.w, R3.x, R1, c[25].x;
RSQ R3.y, R3.y;
RCP R3.y, R3.y;
MUL R1.w, R1, R3.y;
MUL R3.y, R2, R2;
MAD R3.y, R2.x, R2.x, R3;
DP3 R2.x, R1, R5;
MAD R2.z, R2, R2, R3.y;
DP3 R1.x, R7, R1;
DP3 R1.z, R7, R6;
SLT R3.x, R0.w, c[21];
RSQ R2.z, R2.z;
MOV R3.y, c[21];
RCP R2.z, R2.z;
MUL R2.y, R3.x, R1.w;
MAX R2.x, R2, c[21];
RCP R1.z, R1.z;
ADD R3.y, R3, -c[5].x;
MUL R2.z, R2, c[7].x;
MUL R3.z, R2, R3.y;
MAD R3.y, -R2, c[21].z, R1.w;
MUL R2.z, R2.x, R2.x;
MUL R2.z, R2, R3;
MUL R1.w, R2.z, R3.z;
MUL R2.y, R4, R4;
MAD R2.y, R4.x, R4.x, R2;
DP3 R4.x, fragment.texcoord[1], R4;
MAD R2.y, R4.z, R4.z, R2;
MUL R1.w, R1, c[23].z;
POW R1.w, c[23].y, -R1.w;
MUL R1.w, -R1, c[23];
ADD R1.w, R1, c[21].y;
RSQ R2.y, R2.y;
RCP R2.y, R2.y;
MUL R5.x, R2, R1.w;
MUL R2.z, R2.w, R2.y;
MUL R2.xy, -R8, c[5].x;
MUL R2.xy, R2, R2.z;
ADD_SAT R2.z, -R5.x, c[21].y;
POW R3.z, R2.z, c[18].x;
MAD R2.xy, -R2, c[8].x, fragment.texcoord[0];
TEX R2, R2, texture[7], 2D;
MUL R3.z, R3, c[19].x;
MUL_SAT R5.y, R3.z, R2.w;
MAD R2.w, R3.x, c[24].x, R3.y;
MUL R3.xyz, R5.y, R2;
MUL_SAT R4.x, R4, c[9];
MUL R2.xyz, R2, c[0];
MUL R2.xyz, R4.x, R2;
ADD R4.x, -R4, c[21].y;
MAD R2.xyz, R4.x, c[0], R2;
ADD R4.x, -R5.y, c[21].y;
MUL R3.xyz, R3, c[20];
MAD R3.xyz, R4.x, R2, R3;
COS R4.x, R2.w;
TEX R2, fragment.texcoord[0], texture[4], 2D;
MUL R2.xyz, R2, c[11];
MUL R2.xyz, R2, R3;
MUL R4.x, R4, R4;
MUL R3.y, R3.w, R4.x;
MUL R3.y, R4.x, R3;
MUL R3.x, R4, c[10];
MUL R3.z, R3.y, c[25].y;
MUL R3.x, R3, c[10];
RCP R3.y, R3.x;
ADD R3.x, -R4, c[21].y;
MUL R3.x, R3, R3.y;
RCP R3.y, R3.z;
POW R3.x, c[23].y, -R3.x;
MUL R3.x, R3, R3.y;
ADD R3.y, -R0.w, c[21];
ADD R3.z, R4.w, -c[12].x;
POW R3.y, R3.y, c[25].z;
MAD R3.z, R3.y, c[12].x, R3;
TEX R3.yw, fragment.texcoord[0].zwzw, texture[3], 2D;
MAD R4.xy, R3.wyzw, c[21].z, -c[21].y;
MUL R4.z, R3.x, R3;
TEX R3, fragment.texcoord[0], texture[2], 2D;
MUL R4.w, R4.y, R4.y;
MAD R4.w, -R4.x, R4.x, -R4;
ADD R1.y, R4.w, c[21];
MUL R4.z, R4, R3.w;
RCP R1.x, R1.x;
MUL_SAT R1.x, R4.z, R1;
RSQ R1.y, R1.y;
RCP R4.z, R1.y;
DP3 R4.w, fragment.texcoord[1], R4;
DP3 R1.y, R7, R4;
MUL R1.y, R0.w, R1;
MUL R1.y, R1, R1.z;
MUL R5.y, R0.w, R4.w;
MUL R1.y, R1, c[21].z;
MAX R0.w, R0, c[21].x;
MUL R5.z, R5.w, c[12].x;
POW R5.z, R0.w, R5.z;
MUL R0.w, R1.z, R5.y;
MUL R1.z, R2.w, R5;
MUL R0.w, R0, c[21].z;
MUL R1.z, R1, c[23];
MIN_SAT R0.w, R1.y, R0;
MAD R0.w, R1.x, R0, R1.z;
MOV R1.xyz, c[13];
MUL_SAT R0.w, R1, R0;
MUL R1.xyz, R1, c[0];
MUL R1.xyz, R1, R0.w;
ADD R6.xyz, fragment.texcoord[1], R7;
MAD R1.xyz, R2, R5.x, R1;
DP3 R0.w, R6, R6;
RSQ R1.w, R0.w;
MUL R2.xyz, R1.w, R6;
DP3 R1.w, R4, R2;
TEX R0.w, fragment.texcoord[0], texture[5], 2D;
ADD_SAT R0.w, R0, c[14].x;
MUL R1.xyz, R1, c[21].z;
MUL R1.xyz, R0.w, R1;
MUL R2.x, R5.w, c[16];
MAX R1.w, R1, c[21].x;
POW R1.w, R1.w, R2.x;
MOV R2.xyz, c[1];
ADD R0.w, -R0, c[21].y;
MUL R0.xyz, R0, c[21].z;
MAD R0.xyz, R0.w, R0, R1;
MUL R1.xyz, R3, c[15];
MUL_SAT R0.w, R3, R1;
MUL R2.xyz, R2, c[0];
MUL R2.xyz, R2, R0.w;
MAX R0.w, R4, c[21].x;
MUL R1.xyz, R1, c[0];
MAD R1.xyz, R1, R0.w, R2;
TEX R0.w, fragment.texcoord[0], texture[1], 2D;
ADD_SAT R0.w, R0, c[17].x;
MUL R1.xyz, R1, c[21].z;
MUL R1.xyz, R0.w, R1;
ADD R0.w, -R0, c[21].y;
MAD result.color.xyz, R0.w, R0, R1;
MOV result.color.w, c[21].x;
END
# 314 instructions, 9 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color3]
Float 3 [_Shininess3]
Vector 4 [_SpecColor3]
Float 5 [_Layer1Thickness]
Float 6 [_Layer2Thickness]
Float 7 [_GVar]
Float 8 [_ExitColorMultiplier]
Float 9 [_ExitColorRadius]
Float 10 [_SpecSmoothing]
Vector 11 [_Color2]
Float 12 [_Shininess2]
Vector 13 [_SpecColor2]
Float 14 [_BlendAdjust2]
Vector 15 [_Color]
Float 16 [_Shininess]
Float 17 [_BlendAdjust1]
Float 18 [_DDXP]
Float 19 [_DDXM]
Vector 20 [_SSSC]
SetTexture 0 [_MainTex3] 2D
SetTexture 1 [_ScatterMap] 2D
SetTexture 2 [_MainTex] 2D
SetTexture 3 [_BumpMap] 2D
SetTexture 4 [_MainTex2] 2D
SetTexture 5 [_ScatterMap2] 2D
SetTexture 6 [_BumpMap3] 2D
SetTexture 7 [_ExitColorMap] 2D
SetTexture 8 [_BumpMap2] 2D
"ps_3_0
; 371 ALU, 10 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
dcl_2d s7
dcl_2d s8
def c21, 2.00000000, -1.00000000, 0.11705996, 0.50000000
def c22, 6.28318501, -3.14159298, -0.73550957, 0.73550957
def c23, 0.00000000, -1.00000000, 0.15799320, 0.50000000
def c24, -0.99270076, 0.99270076, 2.71828198, -0.21211439
def c25, 0.39894229, 1.00000000, 0.00000000, 1.57072902
def c26, -0.01872930, 0.07426100, 3.14159298, 3.14159274
def c27, 0.15915491, 0.50000000, 5.00000000, 128.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
texld r4.yw, v0.zwzw, s6
mul r0.x, v1.y, v1.y
mad r0.x, v1, v1, r0
mad r0.x, v1.z, v1.z, r0
rsq r2.w, r0.x
mul r1.x, r2.w, -v1.z
mad r0.x, r1, c21.z, c21.w
frc r0.x, r0
mad r1.y, r0.x, c22.x, c22
sincos r0.xy, r1.y
mad r0.z, r1.x, c22, r0.x
dp3 r0.y, v1, v1
mad_pp r5.xy, r4.wyzw, c21.x, c21.y
mul r1.xy, r0.z, c23
rsq r0.x, r0.y
mul r0.xyz, r0.x, v1
mad r0.xyz, r0, c22.w, r1.xxyw
mul r0.w, r0.y, r0.y
mad r0.w, r0.x, r0.x, r0
mad r0.w, r0.z, r0.z, r0
rsq r0.w, r0.w
mul r2.x, r0.w, -r0.z
mad r0.w, r2.x, c23.z, c23
frc r0.w, r0
mad r0.w, r0, c22.x, c22.y
sincos r1.xy, r0.w
dp3 r0.w, r0, r0
mad r1.x, r2, c24, r1
rsq r0.w, r0.w
mul r6.xyz, r0.w, r0
mul r1.xy, r1.x, c23
mad r1.xyz, r6, c24.y, r1.xxyw
dp3 r0.w, r1, r1
rsq r0.w, r0.w
mul r2.xyz, r0.w, r1
add r1.xyz, -r1, v1
mad r3.xyz, -r6, c5.x, v1
mad r2.xyz, -r2, c6.x, r3
mul r9.xyz, r6, c5.x
dp3 r0.w, r2, r2
rsq r0.w, r0.w
mul r3.xyz, r0.w, r2
mul r1.y, r1, r1
mad r1.x, r1, r1, r1.y
mad r1.y, r1.z, r1.z, r1.x
mov r1.x, c6
dp3_pp r0.w, v2, v2
rsq_pp r0.w, r0.w
mul_pp r4.xyz, r0.w, v2
add r7.xyz, r3, r4
mul_pp r0.w, r5.y, r5.y
mad_pp r0.w, -r5.x, r5.x, -r0
dp3 r1.w, r7, r7
rsq r1.w, r1.w
add_pp r0.w, r0, c25.y
rsq_pp r0.w, r0.w
add r6.xyz, v1, -r9
rcp_pp r5.z, r0.w
mul r7.xyz, r1.w, r7
dp3 r6.w, r5, r7
abs r0.w, r6
add r3.w, -r0, c25.y
mad r1.w, r0, c26.x, c26.y
mad r1.w, r1, r0, c24
rsq r3.w, r3.w
mad r0.w, r1, r0, c25
rcp r3.w, r3.w
mul r1.w, r0, r3
cmp r0.w, r6, c25.z, c25.y
mul r3.w, r0, r1
mad r1.w, -r3, c21.x, r1
mad r1.w, r0, c26.z, r1
dp3 r0.w, r5, r3
add r1.z, -c5.x, -r1.x
rsq r1.y, r1.y
rcp r1.x, r1.y
add r1.y, r1.z, c21.x
mul r1.x, r1, c7
mul r1.y, r1.x, r1
max r0.w, r0, c23.x
mul r1.x, r0.w, r0.w
mul r1.x, r1, r1.y
mul r1.x, r1, r1.y
mad r1.z, r1.w, c27.x, c27.y
frc r1.y, r1.z
mul r1.x, r1, c21.w
pow r3, c24.z, -r1.x
mad r4.w, r1.y, c22.x, c22.y
sincos r1.xy, r4.w
mov r1.y, r3.x
mad r5.w, -r1.y, c25.x, c25.y
mul r1.z, r2.y, r2.y
mad r1.y, r2.x, r2.x, r1.z
mad r1.z, r2, r2, r1.y
mul r0.w, r0, r5
add_sat r1.y, -r0.w, c25
pow r3, r1.y, c18.x
rsq r1.z, r1.z
rcp r1.y, r1.z
add r1.zw, r2.xyxy, -v1.xyxy
mul r7.w, r1.x, r1.x
mul r1.y, r2.w, r1
mul r1.zw, r1, c6.x
mul r1.zw, r1, r1.y
mov r1.y, r3.x
mad r8.xy, -r1.zwzw, c8.x, v0
texld r3, r8, s7
mul r1.y, r1, c19.x
mul_sat r1.w, r1.y, r3
mul r1.xyz, r1.w, r3
dp3 r3.w, r2, v1
mul_pp r2.xyz, r3, c0
mul_sat r3.x, r3.w, c9
mul r2.xyz, r3.x, r2
add r3.x, -r3, c25.y
mad r2.xyz, r3.x, c0, r2
texld r3, v0, s0
mul r4.w, c10.x, c10.x
add r1.w, -r1, c25.y
mul r1.xyz, r1, c20
mad r1.xyz, r1.w, r2, r1
mul_pp r2.xyz, r3, c2
mul_pp r2.xyz, r2, r1
mul r1.w, r7, c10.x
mul r1.w, r1, c10.x
add r1.x, -r7.w, c25.y
rcp r1.y, r1.w
mul r3.x, r1, r1.y
pow r1, c24.z, -r3.x
mul r1.y, r7.w, r4.w
mul r1.y, r7.w, r1
mov r3.x, r1
mul r1.x, r1.y, c26.w
add r3.z, -r6.w, c25.y
rcp r3.y, r1.x
pow r1, r3.z, c27.z
mov_pp r1.y, c3.x
add_pp r1.y, c25, -r1
mad r1.y, r1.x, c3.x, r1
mul r1.x, r3, r3.y
mul r1.x, r1, r1.y
dp3_pp r1.y, r5, r4
dp3_pp r1.w, r7, r4
mul r1.x, r3.w, r1
rcp r1.z, r1.y
mul_sat r8.w, r1.x, r1.z
mul r1.x, r6.w, r1.y
rcp r1.z, r1.w
dp3_pp r1.y, r5, v1
mul r1.x, r1, r1.z
mul r5.x, r1, c21
mul r1.x, r6.w, r1.y
mul r1.x, r1.z, r1
mul r5.y, r1.x, c21.x
min_sat r5.x, r5, r5.y
texld r1.yw, v0.zwzw, s8
mad_pp r3.xy, r1.wyzw, c21.x, c21.y
dp3 r1.x, r6, r6
rsq r1.x, r1.x
mul r7.xyz, r1.x, r6
add r1.xyz, r4, r7
dp3 r3.z, r1, r1
mul_pp r1.w, r3.y, r3.y
mad_pp r1.w, -r3.x, r3.x, -r1
rsq r3.z, r3.z
add_pp r1.w, r1, c25.y
mul r8.xyz, r3.z, r1
rsq_pp r1.w, r1.w
rcp_pp r3.z, r1.w
dp3 r7.w, r3, r8
abs r1.x, r7.w
add r1.z, -r1.x, c25.y
mad r1.y, r1.x, c26.x, c26
mad r1.y, r1, r1.x, c24.w
mad r1.x, r1.y, r1, c25.w
mov_pp r1.y, c3.x
rsq r1.z, r1.z
rcp r1.z, r1.z
mul r1.z, r1.x, r1
cmp r1.x, r7.w, c25.z, c25.y
mul r1.w, r1.x, r1.z
max r5.y, r6.w, c23.x
mad r1.z, -r1.w, c21.x, r1
mul_pp r5.z, c27.w, r1.y
mad r6.w, r1.x, c26.z, r1.z
pow r1, r5.y, r5.z
mad r1.y, r6.w, c27.x, c27
frc r1.y, r1
mul r3.w, r3, r1.x
mad r5.y, r1, c22.x, c22
sincos r1.xy, r5.y
mul r1.y, r3.w, c21.w
mul r3.w, r1.x, r1.x
mad r1.y, r8.w, r5.x, r1
mul_sat r5.x, r5.w, r1.y
mul r1.w, r3, c10.x
mov_pp r1.xyz, c0
mul_pp r1.xyz, c4, r1
mul r1.xyz, r1, r5.x
mad r2.xyz, r2, r0.w, r1
mul r0.w, r4, r3
mul r1.w, r1, c10.x
rcp r5.x, r1.w
add r1.w, -r3, c25.y
mul r0.w, r3, r0
mul r5.x, r1.w, r5
pow r1, c24.z, -r5.x
mul r5.xyz, r2, c21.x
dp3_pp r3.w, r4, r3
mul r0.w, r0, c26
mov r2.x, r1
add r2.y, -r7.w, c25
pow r1, r2.y, c27.z
mov r1.z, r1.x
rcp r0.w, r0.w
mov_pp r1.x, c12
add_pp r1.x, c25.y, -r1
texld r1.yw, v0.zwzw, s3
mul r0.w, r2.x, r0
mad_pp r2.xy, r1.wyzw, c21.x, c21.y
mul_pp r1.y, r2, r2
mad_pp r2.z, -r2.x, r2.x, -r1.y
mad r1.x, r1.z, c12, r1
mul r0.w, r0, r1.x
texld r1, v0, s2
add_pp r2.z, r2, c25.y
rsq_pp r2.z, r2.z
rcp_pp r2.z, r2.z
mul_pp r1.xyz, r1, c15
dp3_pp r4.w, r4, r2
mul r0.w, r0, r1
rcp r3.w, r3.w
mul_sat r5.w, r0, r3
dp3_pp r3.w, r4, r8
add r8.xyz, -r0, v1
mul r0.w, r7, r4
dp3_pp r4.w, v1, r2
rcp r3.w, r3.w
mul r0.w, r0, r3
mul r6.w, r7, r4
mul r6.w, r3, r6
mul r3.w, r6, c21.x
mul r0.w, r0, c21.x
min_sat r6.w, r0, r3
max r3.w, r7, c23.x
mov_pp r0.w, c12.x
mul_pp r7.w, c27, r0
pow r0, r3.w, r7.w
dp3 r0.y, r3, r7
max r7.x, r0.y, c23
mov r0.y, c5.x
texld r3, v0, s4
mul r8.y, r8, r8
mad r0.z, r8.x, r8.x, r8.y
mad r0.z, r8, r8, r0
rsq r0.z, r0.z
add r0.w, c25.y, -r0.y
rcp r0.z, r0.z
mul r0.y, r0.z, c7.x
mul r0.z, r0.y, r0.w
mul r0.y, r7.x, r7.x
mul r0.y, r0, r0.z
mul r3.w, r3, r0.x
mul r0.y, r0, r0.z
mul r7.y, r0, c21.w
pow r0, c24.z, -r7.y
mul r7.z, r3.w, c21.w
mad r3.w, -r0.x, c25.x, c25.y
mul r7.w, r7.x, r3
mul r0.y, r6, r6
mad r0.y, r6.x, r6.x, r0
mad r0.x, r6.z, r6.z, r0.y
rsq r0.x, r0.x
rcp r7.y, r0.x
add_sat r7.x, -r7.w, c25.y
pow r0, r7.x, c18.x
mul r0.y, r2.w, r7
mul r0.zw, -r9.xyxy, c5.x
mul r0.zw, r0, r0.y
mov r2.w, r0.x
mad r7.xy, -r0.zwzw, c8.x, v0
texld r0, r7, s7
mul r2.w, r2, c19.x
mul_sat r2.w, r2, r0
mad r0.w, r5, r6, r7.z
mul r7.xyz, r2.w, r0
dp3 r5.w, v1, r6
mul_sat r5.w, r5, c9.x
mul_pp r0.xyz, r0, c0
mul r0.xyz, r5.w, r0
add r5.w, -r5, c25.y
add r2.w, -r2, c25.y
mul_pp r3.xyz, r3, c11
mul_sat r0.w, r3, r0
add_pp r4.xyz, v1, r4
mad r0.xyz, r5.w, c0, r0
mul r6.xyz, r7, c20
mad r0.xyz, r2.w, r0, r6
mul_pp r0.xyz, r3, r0
mov_pp r3.xyz, c0
mul_pp r3.xyz, c13, r3
mul r3.xyz, r3, r0.w
mad r0.xyz, r0, r7.w, r3
dp3_pp r0.w, r4, r4
rsq_pp r0.w, r0.w
mul_pp r3.xyz, r0.w, r4
dp3_pp r0.w, r2, r3
mov_pp r2.w, c16.x
max_pp r0.w, r0, c23.x
mul_pp r3.x, c27.w, r2.w
pow r2, r0.w, r3.x
texld r0.w, v0, s5
add_sat r0.w, r0, c14.x
mul r0.xyz, r0, c21.x
mul_pp r0.xyz, r0.w, r0
add_pp r0.w, -r0, c25.y
mad_pp r0.xyz, r0.w, r5, r0
mul_sat r0.w, r1, r2.x
mov_pp r2.xyz, c0
mul_pp r2.xyz, c1, r2
mul r2.xyz, r2, r0.w
max_pp r0.w, r4, c23.x
mul_pp r1.xyz, r1, c0
mad r1.xyz, r1, r0.w, r2
texld r0.w, v0, s1
add_sat r0.w, r0, c17.x
mul r1.xyz, r1, c21.x
mul_pp r1.xyz, r0.w, r1
add_pp r0.w, -r0, c25.y
mad_pp oC0.xyz, r0.w, r0, r1
mov_pp oC0.w, c23.x
"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color3]
Float 3 [_Shininess3]
Vector 4 [_SpecColor3]
Float 5 [_Layer1Thickness]
Float 6 [_Layer2Thickness]
Float 7 [_GVar]
Float 8 [_ExitColorMultiplier]
Float 9 [_ExitColorRadius]
Float 10 [_SpecSmoothing]
Vector 11 [_Color2]
Float 12 [_Shininess2]
Vector 13 [_SpecColor2]
Float 14 [_BlendAdjust2]
Vector 15 [_Color]
Float 16 [_Shininess]
Float 17 [_BlendAdjust1]
Float 18 [_DDXP]
Float 19 [_DDXM]
Vector 20 [_SSSC]
SetTexture 0 [_MainTex3] 2D
SetTexture 1 [_ScatterMap] 2D
SetTexture 2 [_MainTex] 2D
SetTexture 3 [_BumpMap] 2D
SetTexture 4 [_MainTex2] 2D
SetTexture 5 [_ScatterMap2] 2D
SetTexture 6 [_LightTexture0] 2D
SetTexture 7 [_LightTextureB0] 2D
SetTexture 8 [_BumpMap3] 2D
SetTexture 9 [_ExitColorMap] 2D
SetTexture 10 [_BumpMap2] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 328 ALU, 12 TEX
PARAM c[26] = { program.local[0..20],
		{ 0, 1, 2, 0.73550957 },
		{ -0.73550957, 0, -1, 0.99270076 },
		{ -0.99270076, 2.718282, 0.5, 0.39894229 },
		{ 3.141593, -0.018729299, 0.074261002, 0.21211439 },
		{ 1.570729, 3.1415927, 5, 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEMP R7;
TEMP R8;
TEMP R9;
TEMP R10;
TEX R5.yw, fragment.texcoord[0].zwzw, texture[8], 2D;
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.x, R0.x;
MUL R3.xyz, R0.x, fragment.texcoord[1];
MUL R0.x, R3.y, R3.y;
MAD R0.x, R3, R3, R0;
MAD R0.x, R3.z, R3.z, R0;
RSQ R4.w, R0.x;
MUL R0.y, R4.w, -R3.z;
MUL R0.x, R0.y, c[21].w;
COS R0.z, R0.x;
MAD R0.y, R0, c[22].x, R0.z;
DP3 R0.x, R3, R3;
MAD R5.xy, R5.wyzw, c[21].z, -c[21].y;
MUL R1.xy, R0.y, c[22].yzzw;
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, R3;
MAD R0.xyz, R0, c[21].w, R1.xxyw;
MUL R0.w, R0.y, R0.y;
MAD R0.w, R0.x, R0.x, R0;
MAD R0.w, R0.z, R0.z, R0;
RSQ R0.w, R0.w;
MUL R1.x, R0.w, -R0.z;
MUL R0.w, R1.x, c[22];
COS R1.y, R0.w;
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R6.xyz, R0.w, R0;
MAD R1.x, R1, c[23], R1.y;
MUL R1.xy, R1.x, c[22].yzzw;
MAD R2.xyz, R6, c[22].w, R1.xxyw;
DP3 R0.w, R2, R2;
RSQ R0.w, R0.w;
MUL R1.xyz, R0.w, R2;
ADD R2.xyz, -R2, R3;
MAD R4.xyz, -R6, c[5].x, R3;
MAD R1.xyz, -R1, c[6].x, R4;
DP3 R0.w, R1, R1;
RSQ R0.w, R0.w;
MUL R8.xyz, R0.w, R1;
MUL R2.w, R2.y, R2.y;
DP3 R0.w, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.w, R0.w;
MUL R4.xyz, R0.w, fragment.texcoord[2];
ADD R7.xyz, R8, R4;
MUL R0.w, R5.y, R5.y;
MAD R0.w, -R5.x, R5.x, -R0;
DP3 R1.w, R7, R7;
RSQ R1.w, R1.w;
ADD R0.w, R0, c[21].y;
RSQ R0.w, R0.w;
RCP R5.z, R0.w;
MUL R7.xyz, R1.w, R7;
DP3 R8.w, R5, R7;
ABS R0.w, R8;
MAD R1.w, R0, c[24].y, c[24].z;
MAD R1.w, R1, R0, -c[24];
DP3 R2.y, R5, R8;
MAD R2.w, R2.x, R2.x, R2;
MAX R2.x, R2.y, c[21];
MAD R2.y, R2.z, R2.z, R2.w;
MOV R2.z, c[5].x;
RSQ R2.y, R2.y;
ADD R2.z, -R2, -c[6].x;
RCP R2.y, R2.y;
MUL R10.xyz, R6, c[5].x;
MAD R1.w, R1, R0, c[25].x;
ADD R2.w, -R0, c[21].y;
DP3 R9.x, R1, R3;
MUL R2.y, R2, c[7].x;
ADD R2.z, R2, c[21];
MUL R2.z, R2.y, R2;
MUL R2.y, R2.x, R2.x;
MUL R2.y, R2, R2.z;
MUL R0.w, R2.y, R2.z;
RSQ R2.y, R2.w;
RCP R2.y, R2.y;
MUL R5.w, R1, R2.y;
MUL R0.w, R0, c[23].z;
POW R0.w, c[23].y, -R0.w;
MUL R0.w, -R0, c[23];
ADD R7.w, R0, c[21].y;
MUL R6.w, R2.x, R7;
MUL R1.w, R1.y, R1.y;
MAD R0.w, R1.x, R1.x, R1;
MAD R1.w, R1.z, R1.z, R0;
ADD_SAT R0.w, -R6, c[21].y;
POW R0.w, R0.w, c[18].x;
MUL R8.z, R0.w, c[19].x;
ADD R2.xy, R1, -R3;
RCP R0.w, fragment.texcoord[3].w;
MAD R8.xy, fragment.texcoord[3], R0.w, c[23].z;
RSQ R1.w, R1.w;
RCP R1.w, R1.w;
MUL R1.w, R4, R1;
MUL R2.xy, R2, c[6].x;
MUL R2.xy, R2, R1.w;
MAD R2.xy, -R2, c[8].x, fragment.texcoord[0];
TEX R2, R2, texture[9], 2D;
DP3 R1.w, fragment.texcoord[3], fragment.texcoord[3];
MUL R1.xyz, R2, c[0];
TEX R0.w, R8, texture[6], 2D;
SLT R3.w, c[21].x, fragment.texcoord[3].z;
MUL R0.w, R3, R0;
TEX R1.w, R1.w, texture[7], 2D;
MUL R3.w, R0, R1;
MUL R0.w, R8.z, R2;
MUL_SAT R2.w, R0, R3;
MUL R8.xyz, R2.w, R2;
SLT R0.w, R8, c[21].x;
MUL_SAT R2.x, R9, c[9];
MUL R1.xyz, R2.x, R1;
ADD R2.x, -R2, c[21].y;
MAD R1.xyz, R2.x, c[0], R1;
MUL R1.w, R0, R5;
MUL R2.xyz, R8, c[20];
ADD R2.w, -R2, c[21].y;
MAD R2.xyz, R2.w, R1, R2;
MAD R2.w, -R1, c[21].z, R5;
MAD R0.w, R0, c[24].x, R2;
TEX R1, fragment.texcoord[0], texture[0], 2D;
MUL R1.xyz, R1, c[2];
COS R0.w, R0.w;
MUL R1.xyz, R1, R2;
MUL R0.w, R0, R0;
MUL R2.w, c[10].x, c[10].x;
MUL R2.y, R0.w, R2.w;
MUL R2.x, R0.w, c[10];
MUL R2.y, R0.w, R2;
MUL R2.x, R2, c[10];
MOV R5.w, c[25];
MUL R2.y, R2, c[25];
RCP R2.x, R2.x;
ADD R0.w, -R0, c[21].y;
MUL R0.w, R0, R2.x;
RCP R2.x, R2.y;
POW R0.w, c[23].y, -R0.w;
MUL R2.x, R0.w, R2;
MOV R0.w, c[21].y;
ADD R2.z, R0.w, -c[3].x;
ADD R2.y, -R8.w, c[21];
POW R2.y, R2.y, c[25].z;
MAD R2.y, R2, c[3].x, R2.z;
MUL R2.x, R2, R2.y;
DP3 R2.z, R5, R4;
RCP R2.y, R2.z;
MUL R2.x, R1.w, R2;
MUL_SAT R9.w, R2.x, R2.y;
DP3 R2.y, R5, R3;
DP3 R2.x, R7, R4;
MUL R5.x, R8.w, R2.y;
RCP R2.y, R2.x;
MUL R2.x, R8.w, R2.z;
MUL R2.x, R2, R2.y;
MUL R2.y, R2, R5.x;
ADD R7.xyz, R3, -R10;
MUL R2.x, R2, c[21].z;
MUL R2.y, R2, c[21].z;
MIN_SAT R10.w, R2.x, R2.y;
MAX R2.x, R8.w, c[21];
MUL R2.y, R5.w, c[3].x;
POW R2.x, R2.x, R2.y;
MUL R1.w, R1, R2.x;
DP3 R2.x, R7, R7;
MUL R1.w, R1, c[23].z;
MAD R1.w, R9, R10, R1;
MUL_SAT R6.y, R7.w, R1.w;
TEX R8.yw, fragment.texcoord[0].zwzw, texture[10], 2D;
RSQ R2.z, R2.x;
MAD R2.xy, R8.wyzw, c[21].z, -c[21].y;
MUL R8.xyz, R2.z, R7;
ADD R5.xyz, R4, R8;
DP3 R6.x, R5, R5;
MUL R2.z, R2.y, R2.y;
MAD R2.z, -R2.x, R2.x, -R2;
RSQ R6.x, R6.x;
ADD R2.z, R2, c[21].y;
RSQ R2.z, R2.z;
MUL R9.xyz, R6.x, R5;
RCP R2.z, R2.z;
DP3 R8.w, R2, R9;
ABS R5.x, R8.w;
DP3 R9.x, R4, R9;
ADD R5.y, -R5.x, c[21];
MAD R1.w, R5.x, c[24].y, c[24].z;
MAD R1.w, R1, R5.x, -c[24];
RSQ R5.y, R5.y;
MAD R1.w, R1, R5.x, c[25].x;
RCP R5.y, R5.y;
MUL R6.x, R1.w, R5.y;
SLT R1.w, R8, c[21].x;
MUL R6.z, R1.w, R6.x;
MAD R6.x, -R6.z, c[21].z, R6;
MAD R1.w, R1, c[24].x, R6.x;
MOV R5.xyz, c[4];
MUL R5.xyz, R5, c[0];
MUL R5.xyz, R5, R6.y;
MAD R1.xyz, R1, R6.w, R5;
MUL R6.w, R3, c[21].z;
COS R1.w, R1.w;
MUL R1.w, R1, R1;
MUL R6.xyz, R1, R6.w;
MUL R1.y, R2.w, R1.w;
MUL R1.x, R1.w, c[10];
MUL R1.z, R1.w, R1.y;
MUL R1.x, R1, c[10];
RCP R1.y, R1.x;
ADD R1.x, -R1.w, c[21].y;
MUL R1.x, R1, R1.y;
MUL R1.y, R1.z, c[25];
ADD R1.z, -R8.w, c[21].y;
RCP R9.x, R9.x;
RCP R1.y, R1.y;
POW R1.x, c[23].y, -R1.x;
MUL R1.x, R1, R1.y;
TEX R1.yw, fragment.texcoord[0].zwzw, texture[3], 2D;
MAD R5.xy, R1.wyzw, c[21].z, -c[21].y;
MUL R1.y, R5, R5;
MAD R2.w, -R5.x, R5.x, -R1.y;
ADD R2.w, R2, c[21].y;
RSQ R5.z, R2.w;
DP3 R2.w, R4, R2;
DP3 R2.x, R2, R8;
RCP R5.z, R5.z;
MOV R2.z, c[21].y;
MOV R8.xyz, c[13];
MAX R2.x, R2, c[21];
POW R1.z, R1.z, c[25].z;
ADD R0.w, R0, -c[12].x;
MAD R0.w, R1.z, c[12].x, R0;
MUL R0.w, R1.x, R0;
TEX R1, fragment.texcoord[0], texture[2], 2D;
MUL R1.xyz, R1, c[15];
MUL R0.w, R0, R1;
RCP R2.w, R2.w;
DP3 R7.w, R4, R5;
MUL_SAT R2.w, R0, R2;
MUL R0.w, R8, R7;
MUL R0.w, R0, R9.x;
DP3 R7.w, R3, R5;
MUL R9.y, R8.w, R7.w;
MUL R9.y, R9.x, R9;
MUL R9.x, R9.y, c[21].z;
MUL R0.w, R0, c[21].z;
MIN_SAT R9.w, R0, R9.x;
MAX R0.w, R8, c[21].x;
MUL R9.x, R5.w, c[12];
POW R8.w, R0.w, R9.x;
ADD R9.xyz, -R0, R3;
TEX R0, fragment.texcoord[0], texture[4], 2D;
MUL R0.w, R0, R8;
MUL R8.w, R9.y, R9.y;
MAD R8.w, R9.x, R9.x, R8;
MAD R2.y, R9.z, R9.z, R8.w;
MUL R0.w, R0, c[23].z;
RSQ R2.y, R2.y;
RCP R2.y, R2.y;
MAD R2.w, R2, R9, R0;
MUL R2.y, R2, c[7].x;
ADD R2.z, R2, -c[5].x;
MUL R2.z, R2.y, R2;
MUL R2.y, R2.x, R2.x;
MUL R2.y, R2, R2.z;
MUL R0.w, R2.y, R2.z;
MUL R2.y, R7, R7;
MAD R2.y, R7.x, R7.x, R2;
MAD R2.y, R7.z, R7.z, R2;
MUL R0.w, R0, c[23].z;
POW R0.w, c[23].y, -R0.w;
MUL R0.w, -R0, c[23];
ADD R0.w, R0, c[21].y;
MUL_SAT R8.w, R0, R2;
MUL R8.xyz, R8, c[0];
RSQ R2.y, R2.y;
RCP R2.y, R2.y;
MUL R0.w, R2.x, R0;
MUL R2.z, R4.w, R2.y;
MUL R2.xy, -R10, c[5].x;
MUL R2.xy, R2, R2.z;
ADD_SAT R2.z, -R0.w, c[21].y;
POW R4.w, R2.z, c[18].x;
MAD R2.xy, -R2, c[8].x, fragment.texcoord[0];
TEX R2, R2, texture[9], 2D;
MUL R4.w, R4, c[19].x;
MUL R2.w, R4, R2;
MUL_SAT R2.w, R3, R2;
MUL R9.xyz, R8, R8.w;
MUL R8.xyz, R2.w, R2;
DP3 R3.w, R3, R7;
MUL_SAT R3.w, R3, c[9].x;
MUL R2.xyz, R2, c[0];
MUL R2.xyz, R3.w, R2;
ADD R3.w, -R3, c[21].y;
ADD R2.w, -R2, c[21].y;
MAD R2.xyz, R3.w, c[0], R2;
MUL R7.xyz, R8, c[20];
MAD R2.xyz, R2.w, R2, R7;
MUL R0.xyz, R0, c[11];
MUL R0.xyz, R0, R2;
MAD R0.xyz, R0, R0.w, R9;
ADD R2.xyz, R3, R4;
DP3 R2.w, R2, R2;
TEX R0.w, fragment.texcoord[0], texture[5], 2D;
RSQ R2.w, R2.w;
MUL R2.xyz, R2.w, R2;
ADD_SAT R0.w, R0, c[14].x;
MUL R0.xyz, R6.w, R0;
MUL R0.xyz, R0.w, R0;
ADD R0.w, -R0, c[21].y;
MAD R0.xyz, R0.w, R6, R0;
DP3 R0.w, R5, R2;
MUL R2.x, R5.w, c[16];
MAX R0.w, R0, c[21].x;
POW R0.w, R0.w, R2.x;
MOV R2.xyz, c[1];
MUL_SAT R0.w, R1, R0;
MUL R2.xyz, R2, c[0];
MUL R2.xyz, R2, R0.w;
MAX R0.w, R7, c[21].x;
MUL R1.xyz, R1, c[0];
MAD R1.xyz, R1, R0.w, R2;
TEX R0.w, fragment.texcoord[0], texture[1], 2D;
ADD_SAT R0.w, R0, c[17].x;
MUL R1.xyz, R6.w, R1;
MUL R1.xyz, R0.w, R1;
ADD R0.w, -R0, c[21].y;
MAD result.color.xyz, R0.w, R0, R1;
MOV result.color.w, c[21].x;
END
# 328 instructions, 11 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color3]
Float 3 [_Shininess3]
Vector 4 [_SpecColor3]
Float 5 [_Layer1Thickness]
Float 6 [_Layer2Thickness]
Float 7 [_GVar]
Float 8 [_ExitColorMultiplier]
Float 9 [_ExitColorRadius]
Float 10 [_SpecSmoothing]
Vector 11 [_Color2]
Float 12 [_Shininess2]
Vector 13 [_SpecColor2]
Float 14 [_BlendAdjust2]
Vector 15 [_Color]
Float 16 [_Shininess]
Float 17 [_BlendAdjust1]
Float 18 [_DDXP]
Float 19 [_DDXM]
Vector 20 [_SSSC]
SetTexture 0 [_MainTex3] 2D
SetTexture 1 [_ScatterMap] 2D
SetTexture 2 [_MainTex] 2D
SetTexture 3 [_BumpMap] 2D
SetTexture 4 [_MainTex2] 2D
SetTexture 5 [_ScatterMap2] 2D
SetTexture 6 [_LightTexture0] 2D
SetTexture 7 [_LightTextureB0] 2D
SetTexture 8 [_BumpMap3] 2D
SetTexture 9 [_ExitColorMap] 2D
SetTexture 10 [_BumpMap2] 2D
"ps_3_0
; 384 ALU, 12 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
dcl_2d s7
dcl_2d s8
dcl_2d s9
dcl_2d s10
def c21, 2.00000000, -1.00000000, 0.11705996, 0.50000000
def c22, 6.28318501, -3.14159298, -0.73550957, 0.73550957
def c23, 0.00000000, -1.00000000, 0.15799320, 0.50000000
def c24, -0.99270076, 0.99270076, 2.71828198, -0.21211439
def c25, 0.39894229, 1.00000000, 0.00000000, 1.57072902
def c26, -0.01872930, 0.07426100, 3.14159298, 3.14159274
def c27, 0.15915491, 0.50000000, 5.00000000, 128.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3
texld r5.yw, v0.zwzw, s8
dp3_pp r0.x, v1, v1
rsq_pp r0.x, r0.x
mul_pp r2.xyz, r0.x, v1
mul r0.x, r2.y, r2.y
mad r0.x, r2, r2, r0
mad r0.x, r2.z, r2.z, r0
rsq r1.w, r0.x
mul r1.x, r1.w, -r2.z
mad r0.x, r1, c21.z, c21.w
frc r0.x, r0
mad r1.y, r0.x, c22.x, c22
sincos r0.xy, r1.y
mad r0.z, r1.x, c22, r0.x
dp3 r0.y, r2, r2
mad_pp r6.xy, r5.wyzw, c21.x, c21.y
mul r1.xy, r0.z, c23
rsq r0.x, r0.y
mul r0.xyz, r0.x, r2
mad r3.xyz, r0, c22.w, r1.xxyw
mul r0.x, r3.y, r3.y
mad r0.x, r3, r3, r0
mad r0.x, r3.z, r3.z, r0
rsq r0.x, r0.x
mul r1.x, r0, -r3.z
mad r0.x, r1, c23.z, c23.w
frc r0.x, r0
mad r1.y, r0.x, c22.x, c22
sincos r0.xy, r1.y
mad r0.z, r1.x, c24.x, r0.x
dp3 r0.y, r3, r3
rsq r0.x, r0.y
mul r7.xyz, r0.x, r3
add r3.xyz, -r3, r2
mul r0.zw, r0.z, c23.xyxy
mad r0.xyz, r7, c24.y, r0.zzww
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, r0
mad r4.xyz, -r7, c5.x, r2
mad r9.xyz, -r1, c6.x, r4
dp3 r0.w, r9, r9
rsq r0.w, r0.w
mul r4.xyz, r0.w, r9
dp3_pp r0.w, v2, v2
rsq_pp r0.w, r0.w
mul_pp r1.xyz, r0.w, v2
add r5.xyz, r4, r1
mul_pp r0.w, r6.y, r6.y
mad_pp r0.w, -r6.x, r6.x, -r0
dp3 r2.w, r5, r5
rsq r2.w, r2.w
add_pp r0.w, r0, c25.y
rsq_pp r0.w, r0.w
mul r3.y, r3, r3
mad r3.y, r3.x, r3.x, r3
add r0.xyz, -r0, r2
rcp_pp r6.z, r0.w
mul r8.xyz, r2.w, r5
dp3 r6.w, r6, r8
abs r0.w, r6
add r3.w, -r0, c25.y
mad r2.w, r0, c26.x, c26.y
mad r2.w, r2, r0, c24
rsq r3.w, r3.w
mad r0.w, r2, r0, c25
rcp r3.w, r3.w
mul r2.w, r0, r3
mul r3.w, r0.y, r0.y
cmp r0.w, r6, c25.z, c25.y
dp3 r0.y, r6, r4
mad r0.x, r0, r0, r3.w
max r3.w, r0.y, c23.x
mad r0.y, r0.z, r0.z, r0.x
mov r0.x, c6
mul r4.w, r0, r2
add r0.z, -c5.x, -r0.x
rsq r0.y, r0.y
rcp r0.x, r0.y
add r0.y, r0.z, c21.x
mul r0.x, r0, c7
mul r0.y, r0.x, r0
mul r0.x, r3.w, r3.w
mul r0.x, r0, r0.y
mad r0.z, -r4.w, c21.x, r2.w
mul r0.x, r0, r0.y
mad r0.y, r0.w, c26.z, r0.z
mul r2.w, r0.x, c21
mad r4.x, r0.y, c27, c27.y
pow r0, c24.z, -r2.w
frc r0.y, r4.x
mad r0.y, r0, c22.x, c22
sincos r5.xy, r0.y
mad r5.w, -r0.x, c25.x, c25.y
mul r3.w, r3, r5
mul r0.x, r9.y, r9.y
mul r8.w, r5.x, r5.x
mad r4.x, r9, r9, r0
add_sat r2.w, -r3, c25.y
pow r0, r2.w, c18.x
mad r0.y, r9.z, r9.z, r4.x
rsq r0.y, r0.y
mov r0.z, r0.x
rcp r0.w, r0.y
add r0.xy, r9, -r2
mul r0.w, r1, r0
mul r0.xy, r0, c6.x
mul r0.xy, r0, r0.w
mad r0.xy, -r0, c8.x, v0
texld r4, r0, s9
rcp r0.w, v3.w
mad r10.xy, v3, r0.w, c21.w
texld r0.w, r10, s6
dp3 r0.x, v3, v3
cmp r0.y, -v3.z, c25.z, c25
mul_pp r0.y, r0, r0.w
texld r0.x, r0.x, s7
mul_pp r2.w, r0.y, r0.x
mul r0.z, r0, c19.x
mul r0.x, r0.z, r4.w
dp3 r4.w, r9, r2
mul_sat r0.w, r0.x, r2
mul r0.xyz, r0.w, r4
mul r10.xyz, r7, c5.x
mul r7.w, c10.x, c10.x
mad r3.y, r3.z, r3.z, r3
mul_sat r4.w, r4, c9.x
mul_pp r4.xyz, r4, c0
mul r4.xyz, r4.w, r4
add r4.w, -r4, c25.y
mad r4.xyz, r4.w, c0, r4
add r0.w, -r0, c25.y
mul r0.xyz, r0, c20
mad r0.xyz, r0.w, r4, r0
texld r4, v0, s0
mul_pp r4.xyz, r4, c2
mul_pp r5.xyz, r4, r0
mul r0.w, r8, c10.x
mul r0.w, r0, c10.x
add r0.x, -r8.w, c25.y
rcp r0.y, r0.w
mul r4.x, r0, r0.y
pow r0, c24.z, -r4.x
mul r0.y, r8.w, r7.w
mul r0.y, r8.w, r0
mov r4.y, r0.x
mul r0.x, r0.y, c26.w
add r4.z, -r6.w, c25.y
rcp r4.x, r0.x
pow r0, r4.z, c27.z
mov_pp r0.y, c3.x
add_pp r0.y, c25, -r0
mad r0.y, r0.x, c3.x, r0
mul r0.x, r4.y, r4
mul r0.x, r0, r0.y
dp3_pp r0.y, r6, r1
dp3_pp r0.w, r8, r1
mul r0.x, r4.w, r0
rcp r0.z, r0.y
mul_sat r9.x, r0, r0.z
mul r0.x, r6.w, r0.y
rcp r0.z, r0.w
mul r0.x, r0, r0.z
dp3_pp r0.y, r6, r2
mul r9.y, r0.x, c21.x
mul r0.x, r6.w, r0.y
mul r0.x, r0.z, r0
mul r9.z, r0.x, c21.x
add r6.xyz, r2, -r10
texld r0.yw, v0.zwzw, s10
mad_pp r4.xy, r0.wyzw, c21.x, c21.y
dp3 r0.x, r6, r6
rsq r0.x, r0.x
mul r7.xyz, r0.x, r6
add r0.xyz, r1, r7
dp3 r4.z, r0, r0
mul_pp r0.w, r4.y, r4.y
mad_pp r0.w, -r4.x, r4.x, -r0
rsq r4.z, r4.z
add_pp r0.w, r0, c25.y
mul r8.xyz, r4.z, r0
rsq_pp r0.w, r0.w
rcp_pp r4.z, r0.w
dp3 r8.w, r4, r8
abs r0.x, r8.w
dp3 r3.x, r4, r7
min_sat r9.y, r9, r9.z
max r7.x, r3, c23
rsq r3.x, r3.y
rcp r3.z, r3.x
dp3_pp r8.x, r1, r8
add r0.z, -r0.x, c25.y
mad r0.y, r0.x, c26.x, c26
mad r0.y, r0, r0.x, c24.w
rsq r0.z, r0.z
mov r3.x, c5
mad r0.x, r0.y, r0, c25.w
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r9.z, r8.w, c25, c25.y
mul r0.z, r9, r0.y
mov_pp r0.x, c3
mul r3.y, r7.x, r7.x
max r6.w, r6, c23.x
mad r10.z, -r0, c21.x, r0.y
mul_pp r9.w, c27, r0.x
pow r0, r6.w, r9.w
mad r0.y, r9.z, c26.z, r10.z
mul r0.x, r4.w, r0
mad r0.y, r0, c27.x, c27
frc r0.y, r0
mad r6.w, r0.y, c22.x, c22.y
mul r4.w, r0.x, c21
sincos r0.xy, r6.w
mad r0.y, r9.x, r9, r4.w
mul r4.w, r0.x, r0.x
mul_sat r0.w, r5, r0.y
mov_pp r0.xyz, c0
mul_pp r0.xyz, c4, r0
mul r0.xyz, r0, r0.w
mad r5.xyz, r5, r3.w, r0
mul r5.w, r4, c10.x
mul r0.w, r5, c10.x
mul_pp r5.w, r2, c21.x
add r0.x, -r4.w, c25.y
rcp r0.y, r0.w
mul r3.w, r0.x, r0.y
pow r0, c24.z, -r3.w
mul r0.y, r7.w, r4.w
mov r6.w, r0.x
mul r0.x, r4.w, r0.y
mul r3.w, r0.x, c26
add r4.w, -r8, c25.y
pow r0, r4.w, c27.z
rcp r0.y, r3.w
mul r0.z, r6.w, r0.y
mov r3.w, r0.x
texld r0.yw, v0.zwzw, s3
mad_pp r9.xy, r0.wyzw, c21.x, c21.y
mul_pp r0.y, r9, r9
mad_pp r4.w, -r9.x, r9.x, -r0.y
add_pp r4.w, r4, c25.y
rsq_pp r6.w, r4.w
dp3_pp r4.w, r1, r4
rcp_pp r9.z, r6.w
mov_pp r0.x, c12
add_pp r0.x, c25.y, -r0
mad r0.x, r3.w, c12, r0
mul r3.w, r0.z, r0.x
texld r0, v0, s2
mul_pp r0.xyz, r0, c15
mul r3.w, r3, r0
rcp r4.w, r4.w
mul_sat r7.w, r3, r4
dp3_pp r6.w, r2, r9
dp3_pp r4.w, r1, r9
mul r3.w, r8, r6
rcp r8.x, r8.x
mul r4.w, r8, r4
mul r4.w, r4, r8.x
mul r8.x, r8, r3.w
mul r3.w, r4, c21.x
mul r4.w, r8.x, c21.x
min_sat r8.y, r3.w, r4.w
mov_pp r3.w, c12.x
mul_pp r4.z, c27.w, r3.w
max r4.w, r8, c23.x
mul r3.z, r3, c7.x
add r3.x, c25.y, -r3
mul r4.x, r3.z, r3
mul r4.y, r3, r4.x
pow r3, r4.w, r4.z
mul r3.y, r4, r4.x
mul r4.x, r3.y, c21.w
mov r7.y, r3.x
pow r3, c24.z, -r4.x
texld r4, v0, s4
mul r7.z, r4.w, r7.y
mad r4.w, -r3.x, c25.x, c25.y
mul r8.x, r7, r4.w
mul r3.y, r6, r6
mad r3.y, r6.x, r6.x, r3
mad r3.x, r6.z, r6.z, r3.y
rsq r3.x, r3.x
rcp r7.y, r3.x
add_sat r7.x, -r8, c25.y
pow r3, r7.x, c18.x
mul r1.w, r1, r7.y
mul r3.zw, -r10.xyxy, c5.x
mul r3.zw, r3, r1.w
mov r1.w, r3.x
mad r7.xy, -r3.zwzw, c8.x, v0
texld r3, r7, s9
mul r1.w, r1, c19.x
mul r1.w, r1, r3
mul_sat r2.w, r2, r1
mul r3.w, r7.z, c21
mul r7.xyz, r2.w, r3
mad r1.w, r7, r8.y, r3
dp3 r3.w, r2, r6
add_pp r2.xyz, r2, r1
mov_pp r1.xyz, c0
mul_sat r3.w, r3, c9.x
mul_pp r3.xyz, r3, c0
mul r3.xyz, r3.w, r3
add r3.w, -r3, c25.y
add r2.w, -r2, c25.y
mul_sat r1.w, r4, r1
mul_pp r1.xyz, c13, r1
mul r1.xyz, r1, r1.w
mul r5.xyz, r5, r5.w
mad r3.xyz, r3.w, c0, r3
mul r6.xyz, r7, c20
mad r3.xyz, r2.w, r3, r6
dp3_pp r2.w, r2, r2
rsq_pp r1.w, r2.w
mul_pp r2.xyz, r1.w, r2
dp3_pp r1.w, r9, r2
mul_pp r4.xyz, r4, c11
mul_pp r3.xyz, r4, r3
mad r1.xyz, r3, r8.x, r1
max_pp r3.x, r1.w, c23
mov_pp r2.x, c16
mul_pp r3.y, c27.w, r2.x
pow r2, r3.x, r3.y
texld r1.w, v0, s5
mul r1.xyz, r5.w, r1
add_sat r1.w, r1, c14.x
mul_pp r3.xyz, r1.w, r1
add_pp r1.x, -r1.w, c25.y
mov r1.w, r2.x
mov_pp r2.xyz, c0
mul_sat r0.w, r0, r1
mul_pp r2.xyz, c1, r2
mul r2.xyz, r2, r0.w
max_pp r0.w, r6, c23.x
mul_pp r0.xyz, r0, c0
mad r0.xyz, r0, r0.w, r2
mul r2.xyz, r5.w, r0
texld r0.w, v0, s1
add_sat r0.x, r0.w, c17
mul_pp r2.xyz, r0.x, r2
mad_pp r1.xyz, r1.x, r5, r3
add_pp r0.x, -r0, c25.y
mad_pp oC0.xyz, r0.x, r1, r2
mov_pp oC0.w, c23.x
"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color3]
Float 3 [_Shininess3]
Vector 4 [_SpecColor3]
Float 5 [_Layer1Thickness]
Float 6 [_Layer2Thickness]
Float 7 [_GVar]
Float 8 [_ExitColorMultiplier]
Float 9 [_ExitColorRadius]
Float 10 [_SpecSmoothing]
Vector 11 [_Color2]
Float 12 [_Shininess2]
Vector 13 [_SpecColor2]
Float 14 [_BlendAdjust2]
Vector 15 [_Color]
Float 16 [_Shininess]
Float 17 [_BlendAdjust1]
Float 18 [_DDXP]
Float 19 [_DDXM]
Vector 20 [_SSSC]
SetTexture 0 [_MainTex3] 2D
SetTexture 1 [_ScatterMap] 2D
SetTexture 2 [_MainTex] 2D
SetTexture 3 [_BumpMap] 2D
SetTexture 4 [_MainTex2] 2D
SetTexture 5 [_ScatterMap2] 2D
SetTexture 6 [_LightTextureB0] 2D
SetTexture 7 [_LightTexture0] CUBE
SetTexture 8 [_BumpMap3] 2D
SetTexture 9 [_ExitColorMap] 2D
SetTexture 10 [_BumpMap2] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 324 ALU, 12 TEX
PARAM c[26] = { program.local[0..20],
		{ 0, 1, 2, 0.73550957 },
		{ -0.73550957, 0, -1, 0.99270076 },
		{ -0.99270076, 2.718282, 0.5, 0.39894229 },
		{ 3.141593, -0.018729299, 0.074261002, 0.21211439 },
		{ 1.570729, 3.1415927, 5, 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEMP R7;
TEMP R8;
TEMP R9;
TEMP R10;
TEX R5.yw, fragment.texcoord[0].zwzw, texture[8], 2D;
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.x, R0.x;
MUL R3.xyz, R0.x, fragment.texcoord[1];
MUL R0.x, R3.y, R3.y;
MAD R0.x, R3, R3, R0;
MAD R0.x, R3.z, R3.z, R0;
RSQ R4.w, R0.x;
MUL R0.y, R4.w, -R3.z;
MUL R0.x, R0.y, c[21].w;
COS R0.z, R0.x;
MAD R0.y, R0, c[22].x, R0.z;
DP3 R0.x, R3, R3;
MAD R5.xy, R5.wyzw, c[21].z, -c[21].y;
MUL R1.xy, R0.y, c[22].yzzw;
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, R3;
MAD R0.xyz, R0, c[21].w, R1.xxyw;
MUL R0.w, R0.y, R0.y;
MAD R0.w, R0.x, R0.x, R0;
MAD R0.w, R0.z, R0.z, R0;
RSQ R0.w, R0.w;
MUL R1.x, R0.w, -R0.z;
MUL R0.w, R1.x, c[22];
COS R1.y, R0.w;
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R6.xyz, R0.w, R0;
MAD R1.x, R1, c[23], R1.y;
MUL R1.xy, R1.x, c[22].yzzw;
MAD R2.xyz, R6, c[22].w, R1.xxyw;
DP3 R0.w, R2, R2;
RSQ R0.w, R0.w;
MUL R1.xyz, R0.w, R2;
ADD R2.xyz, -R2, R3;
MAD R4.xyz, -R6, c[5].x, R3;
MAD R1.xyz, -R1, c[6].x, R4;
DP3 R0.w, R1, R1;
RSQ R0.w, R0.w;
MUL R8.xyz, R0.w, R1;
MUL R2.w, R2.y, R2.y;
DP3 R0.w, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.w, R0.w;
MUL R4.xyz, R0.w, fragment.texcoord[2];
ADD R7.xyz, R8, R4;
MUL R0.w, R5.y, R5.y;
MAD R0.w, -R5.x, R5.x, -R0;
DP3 R1.w, R7, R7;
RSQ R1.w, R1.w;
ADD R0.w, R0, c[21].y;
RSQ R0.w, R0.w;
RCP R5.z, R0.w;
MUL R7.xyz, R1.w, R7;
DP3 R8.w, R5, R7;
ABS R1.w, R8;
MAD R0.w, R1, c[24].y, c[24].z;
MAD R0.w, R0, R1, -c[24];
MAD R0.w, R0, R1, c[25].x;
DP3 R2.y, R5, R8;
MAD R2.w, R2.x, R2.x, R2;
MAX R2.x, R2.y, c[21];
MAD R2.y, R2.z, R2.z, R2.w;
ADD R1.w, -R1, c[21].y;
MOV R2.z, c[5].x;
RSQ R2.y, R2.y;
ADD R2.z, -R2, -c[6].x;
RCP R2.y, R2.y;
MUL R10.xyz, R6, c[5].x;
RSQ R2.w, R1.w;
DP3 R9.x, R1, R3;
MUL R2.y, R2, c[7].x;
ADD R2.z, R2, c[21];
MUL R2.z, R2.y, R2;
MUL R2.y, R2.x, R2.x;
MUL R2.y, R2, R2.z;
MUL R1.w, R2.y, R2.z;
RCP R2.y, R2.w;
MUL R5.w, R0, R2.y;
MUL R1.w, R1, c[23].z;
POW R0.w, c[23].y, -R1.w;
MUL R1.w, R1.y, R1.y;
MUL R0.w, -R0, c[23];
ADD R7.w, R0, c[21].y;
MUL R6.w, R2.x, R7;
MAD R1.w, R1.x, R1.x, R1;
MAD R0.w, R1.z, R1.z, R1;
RSQ R1.w, R0.w;
ADD_SAT R0.w, -R6, c[21].y;
ADD R2.xy, R1, -R3;
POW R0.w, R0.w, c[18].x;
MUL R8.x, R0.w, c[19];
RCP R1.w, R1.w;
MUL R1.w, R4, R1;
MUL R2.xy, R2, c[6].x;
MUL R2.xy, R2, R1.w;
MAD R2.xy, -R2, c[8].x, fragment.texcoord[0];
TEX R2, R2, texture[9], 2D;
DP3 R1.w, fragment.texcoord[3], fragment.texcoord[3];
MUL R1.xyz, R2, c[0];
TEX R0.w, fragment.texcoord[3], texture[7], CUBE;
TEX R1.w, R1.w, texture[6], 2D;
MUL R3.w, R1, R0;
MUL R0.w, R8.x, R2;
MUL_SAT R2.w, R0, R3;
MUL R8.xyz, R2.w, R2;
SLT R0.w, R8, c[21].x;
MUL_SAT R2.x, R9, c[9];
MUL R1.xyz, R2.x, R1;
ADD R2.x, -R2, c[21].y;
MAD R1.xyz, R2.x, c[0], R1;
MUL R1.w, R0, R5;
MUL R2.xyz, R8, c[20];
ADD R2.w, -R2, c[21].y;
MAD R2.xyz, R2.w, R1, R2;
MAD R2.w, -R1, c[21].z, R5;
MAD R0.w, R0, c[24].x, R2;
TEX R1, fragment.texcoord[0], texture[0], 2D;
MUL R1.xyz, R1, c[2];
COS R0.w, R0.w;
MUL R1.xyz, R1, R2;
MUL R0.w, R0, R0;
MUL R2.w, c[10].x, c[10].x;
MUL R2.y, R0.w, R2.w;
MUL R2.x, R0.w, c[10];
MUL R2.y, R0.w, R2;
MUL R2.x, R2, c[10];
MOV R5.w, c[25];
MUL R2.y, R2, c[25];
RCP R2.x, R2.x;
ADD R0.w, -R0, c[21].y;
MUL R0.w, R0, R2.x;
RCP R2.x, R2.y;
POW R0.w, c[23].y, -R0.w;
MUL R2.x, R0.w, R2;
MOV R0.w, c[21].y;
ADD R2.z, R0.w, -c[3].x;
ADD R2.y, -R8.w, c[21];
POW R2.y, R2.y, c[25].z;
MAD R2.y, R2, c[3].x, R2.z;
MUL R2.x, R2, R2.y;
DP3 R2.z, R5, R4;
RCP R2.y, R2.z;
MUL R2.x, R1.w, R2;
MUL_SAT R9.w, R2.x, R2.y;
DP3 R2.y, R5, R3;
DP3 R2.x, R7, R4;
MUL R5.x, R8.w, R2.y;
RCP R2.y, R2.x;
MUL R2.x, R8.w, R2.z;
MUL R2.x, R2, R2.y;
MUL R2.y, R2, R5.x;
ADD R7.xyz, R3, -R10;
MUL R2.x, R2, c[21].z;
MUL R2.y, R2, c[21].z;
MIN_SAT R10.w, R2.x, R2.y;
MAX R2.x, R8.w, c[21];
MUL R2.y, R5.w, c[3].x;
POW R2.x, R2.x, R2.y;
MUL R1.w, R1, R2.x;
DP3 R2.x, R7, R7;
MUL R1.w, R1, c[23].z;
MAD R1.w, R9, R10, R1;
MUL_SAT R6.y, R7.w, R1.w;
TEX R8.yw, fragment.texcoord[0].zwzw, texture[10], 2D;
RSQ R2.z, R2.x;
MAD R2.xy, R8.wyzw, c[21].z, -c[21].y;
MUL R8.xyz, R2.z, R7;
ADD R5.xyz, R4, R8;
DP3 R6.x, R5, R5;
MUL R2.z, R2.y, R2.y;
MAD R2.z, -R2.x, R2.x, -R2;
RSQ R6.x, R6.x;
ADD R2.z, R2, c[21].y;
RSQ R2.z, R2.z;
MUL R9.xyz, R6.x, R5;
RCP R2.z, R2.z;
DP3 R8.w, R2, R9;
ABS R5.x, R8.w;
DP3 R9.x, R4, R9;
ADD R5.y, -R5.x, c[21];
MAD R1.w, R5.x, c[24].y, c[24].z;
MAD R1.w, R1, R5.x, -c[24];
RSQ R5.y, R5.y;
MAD R1.w, R1, R5.x, c[25].x;
RCP R5.y, R5.y;
MUL R6.x, R1.w, R5.y;
SLT R1.w, R8, c[21].x;
MUL R6.z, R1.w, R6.x;
MAD R6.x, -R6.z, c[21].z, R6;
MAD R1.w, R1, c[24].x, R6.x;
MOV R5.xyz, c[4];
MUL R5.xyz, R5, c[0];
MUL R5.xyz, R5, R6.y;
MAD R1.xyz, R1, R6.w, R5;
MUL R6.w, R3, c[21].z;
COS R1.w, R1.w;
MUL R1.w, R1, R1;
MUL R6.xyz, R1, R6.w;
MUL R1.y, R2.w, R1.w;
MUL R1.x, R1.w, c[10];
MUL R1.z, R1.w, R1.y;
MUL R1.x, R1, c[10];
RCP R1.y, R1.x;
ADD R1.x, -R1.w, c[21].y;
MUL R1.x, R1, R1.y;
MUL R1.y, R1.z, c[25];
ADD R1.z, -R8.w, c[21].y;
RCP R9.x, R9.x;
RCP R1.y, R1.y;
POW R1.x, c[23].y, -R1.x;
MUL R1.x, R1, R1.y;
TEX R1.yw, fragment.texcoord[0].zwzw, texture[3], 2D;
MAD R5.xy, R1.wyzw, c[21].z, -c[21].y;
MUL R1.y, R5, R5;
MAD R2.w, -R5.x, R5.x, -R1.y;
ADD R2.w, R2, c[21].y;
RSQ R5.z, R2.w;
DP3 R2.w, R4, R2;
DP3 R2.x, R2, R8;
RCP R5.z, R5.z;
MOV R2.z, c[21].y;
MOV R8.xyz, c[13];
MAX R2.x, R2, c[21];
POW R1.z, R1.z, c[25].z;
ADD R0.w, R0, -c[12].x;
MAD R0.w, R1.z, c[12].x, R0;
MUL R0.w, R1.x, R0;
TEX R1, fragment.texcoord[0], texture[2], 2D;
MUL R1.xyz, R1, c[15];
MUL R0.w, R0, R1;
RCP R2.w, R2.w;
DP3 R7.w, R4, R5;
MUL_SAT R2.w, R0, R2;
MUL R0.w, R8, R7;
MUL R0.w, R0, R9.x;
DP3 R7.w, R3, R5;
MUL R9.y, R8.w, R7.w;
MUL R9.y, R9.x, R9;
MUL R9.x, R9.y, c[21].z;
MUL R0.w, R0, c[21].z;
MIN_SAT R9.w, R0, R9.x;
MAX R0.w, R8, c[21].x;
MUL R9.x, R5.w, c[12];
POW R8.w, R0.w, R9.x;
ADD R9.xyz, -R0, R3;
TEX R0, fragment.texcoord[0], texture[4], 2D;
MUL R0.w, R0, R8;
MUL R8.w, R9.y, R9.y;
MAD R8.w, R9.x, R9.x, R8;
MAD R2.y, R9.z, R9.z, R8.w;
MUL R0.w, R0, c[23].z;
RSQ R2.y, R2.y;
RCP R2.y, R2.y;
MAD R2.w, R2, R9, R0;
MUL R2.y, R2, c[7].x;
ADD R2.z, R2, -c[5].x;
MUL R2.z, R2.y, R2;
MUL R2.y, R2.x, R2.x;
MUL R2.y, R2, R2.z;
MUL R0.w, R2.y, R2.z;
MUL R2.y, R7, R7;
MAD R2.y, R7.x, R7.x, R2;
MAD R2.y, R7.z, R7.z, R2;
MUL R0.w, R0, c[23].z;
POW R0.w, c[23].y, -R0.w;
MUL R0.w, -R0, c[23];
ADD R0.w, R0, c[21].y;
MUL_SAT R8.w, R0, R2;
MUL R8.xyz, R8, c[0];
RSQ R2.y, R2.y;
RCP R2.y, R2.y;
MUL R0.w, R2.x, R0;
MUL R2.z, R4.w, R2.y;
MUL R2.xy, -R10, c[5].x;
MUL R2.xy, R2, R2.z;
ADD_SAT R2.z, -R0.w, c[21].y;
POW R4.w, R2.z, c[18].x;
MAD R2.xy, -R2, c[8].x, fragment.texcoord[0];
TEX R2, R2, texture[9], 2D;
MUL R4.w, R4, c[19].x;
MUL R2.w, R4, R2;
MUL_SAT R2.w, R3, R2;
MUL R9.xyz, R8, R8.w;
MUL R8.xyz, R2.w, R2;
DP3 R3.w, R3, R7;
MUL_SAT R3.w, R3, c[9].x;
MUL R2.xyz, R2, c[0];
MUL R2.xyz, R3.w, R2;
ADD R3.w, -R3, c[21].y;
ADD R2.w, -R2, c[21].y;
MAD R2.xyz, R3.w, c[0], R2;
MUL R7.xyz, R8, c[20];
MAD R2.xyz, R2.w, R2, R7;
MUL R0.xyz, R0, c[11];
MUL R0.xyz, R0, R2;
MAD R0.xyz, R0, R0.w, R9;
ADD R2.xyz, R3, R4;
DP3 R2.w, R2, R2;
TEX R0.w, fragment.texcoord[0], texture[5], 2D;
RSQ R2.w, R2.w;
MUL R2.xyz, R2.w, R2;
ADD_SAT R0.w, R0, c[14].x;
MUL R0.xyz, R6.w, R0;
MUL R0.xyz, R0.w, R0;
ADD R0.w, -R0, c[21].y;
MAD R0.xyz, R0.w, R6, R0;
DP3 R0.w, R5, R2;
MUL R2.x, R5.w, c[16];
MAX R0.w, R0, c[21].x;
POW R0.w, R0.w, R2.x;
MOV R2.xyz, c[1];
MUL_SAT R0.w, R1, R0;
MUL R2.xyz, R2, c[0];
MUL R2.xyz, R2, R0.w;
MAX R0.w, R7, c[21].x;
MUL R1.xyz, R1, c[0];
MAD R1.xyz, R1, R0.w, R2;
TEX R0.w, fragment.texcoord[0], texture[1], 2D;
ADD_SAT R0.w, R0, c[17].x;
MUL R1.xyz, R6.w, R1;
MUL R1.xyz, R0.w, R1;
ADD R0.w, -R0, c[21].y;
MAD result.color.xyz, R0.w, R0, R1;
MOV result.color.w, c[21].x;
END
# 324 instructions, 11 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color3]
Float 3 [_Shininess3]
Vector 4 [_SpecColor3]
Float 5 [_Layer1Thickness]
Float 6 [_Layer2Thickness]
Float 7 [_GVar]
Float 8 [_ExitColorMultiplier]
Float 9 [_ExitColorRadius]
Float 10 [_SpecSmoothing]
Vector 11 [_Color2]
Float 12 [_Shininess2]
Vector 13 [_SpecColor2]
Float 14 [_BlendAdjust2]
Vector 15 [_Color]
Float 16 [_Shininess]
Float 17 [_BlendAdjust1]
Float 18 [_DDXP]
Float 19 [_DDXM]
Vector 20 [_SSSC]
SetTexture 0 [_MainTex3] 2D
SetTexture 1 [_ScatterMap] 2D
SetTexture 2 [_MainTex] 2D
SetTexture 3 [_BumpMap] 2D
SetTexture 4 [_MainTex2] 2D
SetTexture 5 [_ScatterMap2] 2D
SetTexture 6 [_LightTextureB0] 2D
SetTexture 7 [_LightTexture0] CUBE
SetTexture 8 [_BumpMap3] 2D
SetTexture 9 [_ExitColorMap] 2D
SetTexture 10 [_BumpMap2] 2D
"ps_3_0
; 380 ALU, 12 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
dcl_cube s7
dcl_2d s8
dcl_2d s9
dcl_2d s10
def c21, 2.00000000, -1.00000000, 0.11705996, 0.50000000
def c22, 6.28318501, -3.14159298, -0.73550957, 0.73550957
def c23, 0.00000000, -1.00000000, 0.15799320, 0.50000000
def c24, -0.99270076, 0.99270076, 2.71828198, -0.21211439
def c25, 0.39894229, 1.00000000, 0.00000000, 1.57072902
def c26, -0.01872930, 0.07426100, 3.14159298, 3.14159274
def c27, 0.15915491, 0.50000000, 5.00000000, 128.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
texld r5.yw, v0.zwzw, s8
dp3_pp r0.x, v1, v1
rsq_pp r0.x, r0.x
mul_pp r2.xyz, r0.x, v1
mul r0.x, r2.y, r2.y
mad r0.x, r2, r2, r0
mad r0.x, r2.z, r2.z, r0
rsq r1.w, r0.x
mul r1.x, r1.w, -r2.z
mad r0.x, r1, c21.z, c21.w
frc r0.x, r0
mad r1.y, r0.x, c22.x, c22
sincos r0.xy, r1.y
mad r0.z, r1.x, c22, r0.x
dp3 r0.y, r2, r2
mad_pp r6.xy, r5.wyzw, c21.x, c21.y
mul r1.xy, r0.z, c23
rsq r0.x, r0.y
mul r0.xyz, r0.x, r2
mad r3.xyz, r0, c22.w, r1.xxyw
mul r0.x, r3.y, r3.y
mad r0.x, r3, r3, r0
mad r0.x, r3.z, r3.z, r0
rsq r0.x, r0.x
mul r1.x, r0, -r3.z
mad r0.x, r1, c23.z, c23.w
frc r0.x, r0
mad r1.y, r0.x, c22.x, c22
sincos r0.xy, r1.y
mad r0.z, r1.x, c24.x, r0.x
dp3 r0.y, r3, r3
rsq r0.x, r0.y
mul r7.xyz, r0.x, r3
add r3.xyz, -r3, r2
mul r0.zw, r0.z, c23.xyxy
mad r0.xyz, r7, c24.y, r0.zzww
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, r0
mad r4.xyz, -r7, c5.x, r2
mad r9.xyz, -r1, c6.x, r4
dp3 r0.w, r9, r9
rsq r0.w, r0.w
mul r4.xyz, r0.w, r9
dp3_pp r0.w, v2, v2
rsq_pp r0.w, r0.w
mul_pp r1.xyz, r0.w, v2
add r5.xyz, r4, r1
mul_pp r0.w, r6.y, r6.y
mad_pp r0.w, -r6.x, r6.x, -r0
dp3 r2.w, r5, r5
rsq r2.w, r2.w
add_pp r0.w, r0, c25.y
rsq_pp r0.w, r0.w
mul r3.y, r3, r3
mad r3.y, r3.x, r3.x, r3
add r0.xyz, -r0, r2
rcp_pp r6.z, r0.w
mul r8.xyz, r2.w, r5
dp3 r6.w, r6, r8
abs r0.w, r6
add r3.w, -r0, c25.y
mad r2.w, r0, c26.x, c26.y
mad r2.w, r2, r0, c24
rsq r3.w, r3.w
mul r10.xyz, r7, c5.x
mad r0.w, r2, r0, c25
rcp r3.w, r3.w
mul r2.w, r0, r3
cmp r0.w, r6, c25.z, c25.y
mul r3.w, r0, r2
mad r3.w, -r3, c21.x, r2
mul r2.w, r0.y, r0.y
dp3 r0.y, r6, r4
mad r0.x, r0, r0, r2.w
max r2.w, r0.y, c23.x
mad r0.y, r0.z, r0.z, r0.x
mov r0.x, c6
add r0.z, -c5.x, -r0.x
rsq r0.y, r0.y
rcp r0.x, r0.y
add r0.y, r0.z, c21.x
mul r0.x, r0, c7
mul r0.y, r0.x, r0
mul r0.x, r2.w, r2.w
mul r0.x, r0, r0.y
mad r0.z, r0.w, c26, r3.w
mul r0.x, r0, r0.y
mad r0.y, r0.z, c27.x, c27
mul r3.w, r0.x, c21
frc r4.x, r0.y
pow r0, c24.z, -r3.w
mad r0.y, r4.x, c22.x, c22
sincos r5.xy, r0.y
mad r5.w, -r0.x, c25.x, c25.y
mul r3.w, r2, r5
mul r0.x, r9.y, r9.y
mad r0.x, r9, r9, r0
mul r8.w, r5.x, r5.x
mad r4.x, r9.z, r9.z, r0
add_sat r2.w, -r3, c25.y
pow r0, r2.w, c18.x
rsq r0.y, r4.x
add r0.zw, r9.xyxy, -r2.xyxy
rcp r0.y, r0.y
mul r0.y, r1.w, r0
mul r0.zw, r0, c6.x
mul r0.zw, r0, r0.y
mov r2.w, r0.x
mad r0.xy, -r0.zwzw, c8.x, v0
texld r4, r0, s9
dp3 r0.x, v3, v3
mul r0.z, r2.w, c19.x
mul r7.w, c10.x, c10.x
mad r3.y, r3.z, r3.z, r3
texld r0.w, v3, s7
texld r0.x, r0.x, s6
mul r2.w, r0.x, r0
mul r0.x, r0.z, r4.w
dp3 r4.w, r9, r2
mul_sat r0.w, r0.x, r2
mul r0.xyz, r0.w, r4
mul_sat r4.w, r4, c9.x
mul_pp r4.xyz, r4, c0
mul r4.xyz, r4.w, r4
add r4.w, -r4, c25.y
mad r4.xyz, r4.w, c0, r4
add r0.w, -r0, c25.y
mul r0.xyz, r0, c20
mad r0.xyz, r0.w, r4, r0
texld r4, v0, s0
mul_pp r4.xyz, r4, c2
mul_pp r5.xyz, r4, r0
mul r0.w, r8, c10.x
mul r0.w, r0, c10.x
add r0.x, -r8.w, c25.y
rcp r0.y, r0.w
mul r4.x, r0, r0.y
pow r0, c24.z, -r4.x
mul r0.y, r8.w, r7.w
mul r0.y, r8.w, r0
mov r4.y, r0.x
mul r0.x, r0.y, c26.w
add r4.z, -r6.w, c25.y
rcp r4.x, r0.x
pow r0, r4.z, c27.z
mov_pp r0.y, c3.x
add_pp r0.y, c25, -r0
mad r0.y, r0.x, c3.x, r0
mul r0.x, r4.y, r4
mul r0.x, r0, r0.y
dp3_pp r0.y, r6, r1
dp3_pp r0.w, r8, r1
mul r0.x, r4.w, r0
rcp r0.z, r0.y
mul_sat r9.x, r0, r0.z
mul r0.x, r6.w, r0.y
rcp r0.z, r0.w
mul r0.x, r0, r0.z
dp3_pp r0.y, r6, r2
mul r9.y, r0.x, c21.x
mul r0.x, r6.w, r0.y
mul r0.x, r0.z, r0
mul r9.z, r0.x, c21.x
add r6.xyz, r2, -r10
texld r0.yw, v0.zwzw, s10
mad_pp r4.xy, r0.wyzw, c21.x, c21.y
dp3 r0.x, r6, r6
rsq r0.x, r0.x
mul r7.xyz, r0.x, r6
add r0.xyz, r1, r7
dp3 r4.z, r0, r0
mul_pp r0.w, r4.y, r4.y
mad_pp r0.w, -r4.x, r4.x, -r0
rsq r4.z, r4.z
add_pp r0.w, r0, c25.y
mul r8.xyz, r4.z, r0
rsq_pp r0.w, r0.w
rcp_pp r4.z, r0.w
dp3 r8.w, r4, r8
abs r0.x, r8.w
dp3 r3.x, r4, r7
min_sat r9.y, r9, r9.z
max r7.x, r3, c23
rsq r3.x, r3.y
rcp r3.z, r3.x
dp3_pp r8.x, r1, r8
add r0.z, -r0.x, c25.y
mad r0.y, r0.x, c26.x, c26
mad r0.y, r0, r0.x, c24.w
rsq r0.z, r0.z
mov r3.x, c5
mad r0.x, r0.y, r0, c25.w
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r9.z, r8.w, c25, c25.y
mul r0.z, r9, r0.y
mov_pp r0.x, c3
mul r3.y, r7.x, r7.x
max r6.w, r6, c23.x
mad r10.z, -r0, c21.x, r0.y
mul_pp r9.w, c27, r0.x
pow r0, r6.w, r9.w
mad r0.y, r9.z, c26.z, r10.z
mul r0.x, r4.w, r0
mad r0.y, r0, c27.x, c27
frc r0.y, r0
mad r6.w, r0.y, c22.x, c22.y
mul r4.w, r0.x, c21
sincos r0.xy, r6.w
mad r0.y, r9.x, r9, r4.w
mul r4.w, r0.x, r0.x
mul_sat r0.w, r5, r0.y
mov_pp r0.xyz, c0
mul_pp r0.xyz, c4, r0
mul r0.xyz, r0, r0.w
mad r5.xyz, r5, r3.w, r0
mul r5.w, r4, c10.x
mul r0.w, r5, c10.x
mul_pp r5.w, r2, c21.x
add r0.x, -r4.w, c25.y
rcp r0.y, r0.w
mul r3.w, r0.x, r0.y
pow r0, c24.z, -r3.w
mul r0.y, r7.w, r4.w
mov r6.w, r0.x
mul r0.x, r4.w, r0.y
mul r3.w, r0.x, c26
add r4.w, -r8, c25.y
pow r0, r4.w, c27.z
rcp r0.y, r3.w
mul r0.z, r6.w, r0.y
mov r3.w, r0.x
texld r0.yw, v0.zwzw, s3
mad_pp r9.xy, r0.wyzw, c21.x, c21.y
mul_pp r0.y, r9, r9
mad_pp r4.w, -r9.x, r9.x, -r0.y
add_pp r4.w, r4, c25.y
rsq_pp r6.w, r4.w
dp3_pp r4.w, r1, r4
rcp_pp r9.z, r6.w
mov_pp r0.x, c12
add_pp r0.x, c25.y, -r0
mad r0.x, r3.w, c12, r0
mul r3.w, r0.z, r0.x
texld r0, v0, s2
mul_pp r0.xyz, r0, c15
mul r3.w, r3, r0
rcp r4.w, r4.w
mul_sat r7.w, r3, r4
dp3_pp r6.w, r2, r9
dp3_pp r4.w, r1, r9
mul r3.w, r8, r6
rcp r8.x, r8.x
mul r4.w, r8, r4
mul r4.w, r4, r8.x
mul r8.x, r8, r3.w
mul r3.w, r4, c21.x
mul r4.w, r8.x, c21.x
min_sat r8.y, r3.w, r4.w
mov_pp r3.w, c12.x
mul_pp r4.z, c27.w, r3.w
max r4.w, r8, c23.x
mul r3.z, r3, c7.x
add r3.x, c25.y, -r3
mul r4.x, r3.z, r3
mul r4.y, r3, r4.x
pow r3, r4.w, r4.z
mul r3.y, r4, r4.x
mul r4.x, r3.y, c21.w
mov r7.y, r3.x
pow r3, c24.z, -r4.x
texld r4, v0, s4
mul r7.z, r4.w, r7.y
mad r4.w, -r3.x, c25.x, c25.y
mul r8.x, r7, r4.w
mul r3.y, r6, r6
mad r3.y, r6.x, r6.x, r3
mad r3.x, r6.z, r6.z, r3.y
rsq r3.x, r3.x
rcp r7.y, r3.x
add_sat r7.x, -r8, c25.y
pow r3, r7.x, c18.x
mul r1.w, r1, r7.y
mul r3.zw, -r10.xyxy, c5.x
mul r3.zw, r3, r1.w
mov r1.w, r3.x
mad r7.xy, -r3.zwzw, c8.x, v0
texld r3, r7, s9
mul r1.w, r1, c19.x
mul r1.w, r1, r3
mul_sat r2.w, r2, r1
mul r3.w, r7.z, c21
mul r7.xyz, r2.w, r3
mad r1.w, r7, r8.y, r3
dp3 r3.w, r2, r6
add_pp r2.xyz, r2, r1
mov_pp r1.xyz, c0
mul_sat r3.w, r3, c9.x
mul_pp r3.xyz, r3, c0
mul r3.xyz, r3.w, r3
add r3.w, -r3, c25.y
add r2.w, -r2, c25.y
mul_sat r1.w, r4, r1
mul_pp r1.xyz, c13, r1
mul r1.xyz, r1, r1.w
mul r5.xyz, r5, r5.w
mad r3.xyz, r3.w, c0, r3
mul r6.xyz, r7, c20
mad r3.xyz, r2.w, r3, r6
dp3_pp r2.w, r2, r2
rsq_pp r1.w, r2.w
mul_pp r2.xyz, r1.w, r2
dp3_pp r1.w, r9, r2
mul_pp r4.xyz, r4, c11
mul_pp r3.xyz, r4, r3
mad r1.xyz, r3, r8.x, r1
max_pp r3.x, r1.w, c23
mov_pp r2.x, c16
mul_pp r3.y, c27.w, r2.x
pow r2, r3.x, r3.y
texld r1.w, v0, s5
mul r1.xyz, r5.w, r1
add_sat r1.w, r1, c14.x
mul_pp r3.xyz, r1.w, r1
add_pp r1.x, -r1.w, c25.y
mov r1.w, r2.x
mov_pp r2.xyz, c0
mul_sat r0.w, r0, r1
mul_pp r2.xyz, c1, r2
mul r2.xyz, r2, r0.w
max_pp r0.w, r6, c23.x
mul_pp r0.xyz, r0, c0
mad r0.xyz, r0, r0.w, r2
mul r2.xyz, r5.w, r0
texld r0.w, v0, s1
add_sat r0.x, r0.w, c17
mul_pp r2.xyz, r0.x, r2
mad_pp r1.xyz, r1.x, r5, r3
add_pp r0.x, -r0, c25.y
mad_pp oC0.xyz, r0.x, r1, r2
mov_pp oC0.w, c23.x
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color3]
Float 3 [_Shininess3]
Vector 4 [_SpecColor3]
Float 5 [_Layer1Thickness]
Float 6 [_Layer2Thickness]
Float 7 [_GVar]
Float 8 [_ExitColorMultiplier]
Float 9 [_ExitColorRadius]
Float 10 [_SpecSmoothing]
Vector 11 [_Color2]
Float 12 [_Shininess2]
Vector 13 [_SpecColor2]
Float 14 [_BlendAdjust2]
Vector 15 [_Color]
Float 16 [_Shininess]
Float 17 [_BlendAdjust1]
Float 18 [_DDXP]
Float 19 [_DDXM]
Vector 20 [_SSSC]
SetTexture 0 [_MainTex3] 2D
SetTexture 1 [_ScatterMap] 2D
SetTexture 2 [_MainTex] 2D
SetTexture 3 [_BumpMap] 2D
SetTexture 4 [_MainTex2] 2D
SetTexture 5 [_ScatterMap2] 2D
SetTexture 6 [_LightTexture0] 2D
SetTexture 7 [_BumpMap3] 2D
SetTexture 8 [_ExitColorMap] 2D
SetTexture 9 [_BumpMap2] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 318 ALU, 11 TEX
PARAM c[26] = { program.local[0..20],
		{ 0, 1, 2, 0.73550957 },
		{ -0.73550957, 0, -1, 0.99270076 },
		{ -0.99270076, 2.718282, 0.5, 0.39894229 },
		{ 3.141593, -0.018729299, 0.074261002, 0.21211439 },
		{ 1.570729, 3.1415927, 5, 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEMP R7;
TEMP R8;
MUL R0.x, fragment.texcoord[1].y, fragment.texcoord[1].y;
MAD R0.x, fragment.texcoord[1], fragment.texcoord[1], R0;
MAD R0.x, fragment.texcoord[1].z, fragment.texcoord[1].z, R0;
RSQ R1.w, R0.x;
MUL R0.y, R1.w, -fragment.texcoord[1].z;
MUL R0.x, R0.y, c[21].w;
COS R0.z, R0.x;
MAD R0.y, R0, c[22].x, R0.z;
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
MOV R3.w, c[21].y;
MUL R1.xy, R0.y, c[22].yzzw;
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, fragment.texcoord[1];
MAD R1.xyz, R0, c[21].w, R1.xxyw;
MUL R0.x, R1.y, R1.y;
MAD R0.x, R1, R1, R0;
MAD R0.x, R1.z, R1.z, R0;
RSQ R0.x, R0.x;
MUL R0.y, R0.x, -R1.z;
MUL R0.x, R0.y, c[22].w;
COS R0.z, R0.x;
MAD R0.y, R0, c[23].x, R0.z;
DP3 R0.x, R1, R1;
RSQ R0.x, R0.x;
MUL R2.xyz, R0.x, R1;
ADD R1.xyz, -R1, fragment.texcoord[1];
MUL R0.zw, R0.y, c[22].xyyz;
MAD R6.xyz, R2, c[22].w, R0.zzww;
DP3 R0.x, R6, R6;
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, R6;
ADD R6.xyz, -R6, fragment.texcoord[1];
MAD R3.xyz, -R2, c[5].x, fragment.texcoord[1];
MAD R3.xyz, -R0, c[6].x, R3;
TEX R0.yw, fragment.texcoord[0].zwzw, texture[7], 2D;
MAD R5.xy, R0.wyzw, c[21].z, -c[21].y;
DP3 R0.x, R3, R3;
RSQ R0.x, R0.x;
MUL R7.xyz, R0.x, R3;
MUL R0.w, R5.y, R5.y;
MAD R0.w, -R5.x, R5.x, -R0;
DP3 R0.x, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.x, R0.x;
MUL R4.xyz, R0.x, fragment.texcoord[2];
ADD R0.xyz, R7, R4;
DP3 R2.w, R0, R0;
RSQ R2.w, R2.w;
MUL R8.xyz, R2.w, R0;
ADD R0.w, R0, c[21].y;
RSQ R0.w, R0.w;
RCP R5.z, R0.w;
DP3 R4.w, R5, R8;
ABS R0.x, R4.w;
DP3 R5.w, R5, R4;
ADD R0.z, -R0.x, c[21].y;
MAD R0.y, R0.x, c[24], c[24].z;
MAD R0.y, R0, R0.x, -c[24].w;
RCP R7.w, R5.w;
RSQ R0.z, R0.z;
MUL R1.y, R1, R1;
MAD R1.y, R1.x, R1.x, R1;
MAD R1.y, R1.z, R1.z, R1;
RSQ R1.y, R1.y;
MOV R1.z, c[21].y;
RCP R1.y, R1.y;
DP3 R8.w, R5, fragment.texcoord[1];
MAD R0.x, R0.y, R0, c[25];
RCP R0.z, R0.z;
MUL R0.y, R0.x, R0.z;
SLT R0.x, R4.w, c[21];
MUL R0.z, R0.x, R0.y;
MAD R0.y, -R0.z, c[21].z, R0;
MAD R0.x, R0, c[24], R0.y;
COS R0.x, R0.x;
MUL R0.x, R0, R0;
MUL R2.w, c[10].x, c[10].x;
MUL R0.z, R0.x, R2.w;
MUL R0.y, R0.x, c[10].x;
MUL R0.z, R0.x, R0;
MUL R0.y, R0, c[10].x;
MUL R0.z, R0, c[25].y;
RCP R0.y, R0.y;
ADD R0.x, -R0, c[21].y;
MUL R0.x, R0, R0.y;
RCP R0.y, R0.z;
POW R0.x, c[23].y, -R0.x;
MUL R0.x, R0, R0.y;
ADD R0.y, -R4.w, c[21];
ADD R0.z, R3.w, -c[3].x;
POW R0.y, R0.y, c[25].z;
MAD R0.y, R0, c[3].x, R0.z;
MUL R6.w, R0.x, R0.y;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R6.w, R0, R6;
MUL_SAT R7.w, R6, R7;
DP3 R6.w, R8, R4;
RCP R6.w, R6.w;
MUL R5.w, R4, R5;
MUL R5.w, R5, R6;
MUL R8.x, R4.w, R8.w;
MUL R8.x, R6.w, R8;
MUL R6.w, R8.x, c[21].z;
MUL R5.w, R5, c[21].z;
MIN_SAT R8.x, R5.w, R6.w;
MAX R5.w, R4, c[21].x;
DP3 R4.w, R5, R7;
MUL R6.y, R6, R6;
MAD R5.y, R6.x, R6.x, R6;
MAX R5.x, R4.w, c[21];
MAD R4.w, R6.z, R6.z, R5.y;
MOV R5.z, c[5].x;
ADD R6.x, -R5.z, -c[6];
RSQ R4.w, R4.w;
RCP R4.w, R4.w;
MUL R5.z, R4.w, c[7].x;
ADD R6.x, R6, c[21].z;
MUL R5.z, R5, R6.x;
MOV R4.w, c[25];
MUL R5.y, R5.x, R5.x;
MUL R5.y, R5, R5.z;
MUL R6.x, R4.w, c[3];
POW R5.w, R5.w, R6.x;
MUL R5.y, R5, R5.z;
MUL R5.z, R0.w, R5.w;
MUL R0.w, R5.y, c[23].z;
MUL R5.y, R3, R3;
POW R0.w, c[23].y, -R0.w;
MUL R0.w, -R0, c[23];
ADD R7.x, R0.w, c[21].y;
MAD R5.y, R3.x, R3.x, R5;
MUL R6.w, R5.x, R7.x;
MAD R0.w, R3.z, R3.z, R5.y;
RSQ R5.x, R0.w;
MUL R6.x, R5.z, c[23].z;
RCP R5.z, R5.x;
ADD_SAT R0.w, -R6, c[21].y;
ADD R5.xy, R3, -fragment.texcoord[1];
POW R0.w, R0.w, c[18].x;
MUL R6.y, R0.w, c[19].x;
TEX R0.w, fragment.texcoord[3], texture[6], 2D;
MUL R5.z, R1.w, R5;
MUL R5.xy, R5, c[6].x;
MUL R5.xy, R5, R5.z;
MAD R5.xy, -R5, c[8].x, fragment.texcoord[0];
TEX R5, R5, texture[8], 2D;
MUL R5.w, R6.y, R5;
MUL_SAT R7.y, R5.w, R0.w;
MAD R5.w, R7, R8.x, R6.x;
DP3 R7.z, R3, fragment.texcoord[1];
MUL R6.xyz, R7.y, R5;
MUL R3.xyz, R5, c[0];
MUL_SAT R5.x, R7.z, c[9];
MUL R3.xyz, R5.x, R3;
ADD R5.x, -R5, c[21].y;
MAD R3.xyz, R5.x, c[0], R3;
MUL R5.xyz, R6, c[20];
ADD R6.x, -R7.y, c[21].y;
MAD R3.xyz, R6.x, R3, R5;
MUL_SAT R5.x, R7, R5.w;
MUL R0.xyz, R0, c[2];
MUL R0.xyz, R0, R3;
MUL R7.xyz, R2, c[5].x;
MOV R3.xyz, c[4];
MUL R2.xyz, R3, c[0];
MUL R2.xyz, R2, R5.x;
ADD R3.xyz, fragment.texcoord[1], -R7;
MAD R0.xyz, R0, R6.w, R2;
DP3 R2.x, R3, R3;
RSQ R2.z, R2.x;
TEX R5.yw, fragment.texcoord[0].zwzw, texture[9], 2D;
MAD R2.xy, R5.wyzw, c[21].z, -c[21].y;
MUL R6.xyz, R2.z, R3;
ADD R5.xyz, R4, R6;
MUL R2.z, R2.y, R2.y;
MAD R2.z, -R2.x, R2.x, -R2;
DP3 R5.w, R5, R5;
RSQ R5.w, R5.w;
MUL R5.xyz, R5.w, R5;
MUL R5.w, R0, c[21].z;
ADD R2.z, R2, c[21].y;
RSQ R2.z, R2.z;
RCP R2.z, R2.z;
DP3 R6.w, R2, R5;
DP3 R1.x, R2, R6;
ABS R7.z, R6.w;
DP3 R2.x, R4, R2;
MAD R7.w, R7.z, c[24].y, c[24].z;
ADD R8.x, -R7.z, c[21].y;
MAD R7.w, R7, R7.z, -c[24];
MAD R7.z, R7.w, R7, c[25].x;
RSQ R8.x, R8.x;
RCP R7.w, R8.x;
MUL R8.x, R7.z, R7.w;
SLT R8.y, R6.w, c[21].x;
MUL R6.x, R8.y, R8;
MAX R1.x, R1, c[21];
MUL R1.y, R1, c[7].x;
ADD R1.z, R1, -c[5].x;
MUL R1.z, R1.y, R1;
MUL R1.y, R1.x, R1.x;
MUL R1.y, R1, R1.z;
MUL R1.y, R1, R1.z;
MUL R1.z, R3.y, R3.y;
MAD R1.z, R3.x, R3.x, R1;
DP3 R3.x, fragment.texcoord[1], R3;
MAD R1.z, R3, R3, R1;
MUL R1.y, R1, c[23].z;
POW R1.y, c[23].y, -R1.y;
MUL R1.y, -R1, c[23].w;
ADD R7.z, R1.y, c[21].y;
RSQ R1.z, R1.z;
RCP R1.y, R1.z;
MUL R1.z, R1.w, R1.y;
MUL R7.w, R1.x, R7.z;
MUL R1.xy, -R7, c[5].x;
MUL R1.xy, R1, R1.z;
ADD_SAT R1.z, -R7.w, c[21].y;
POW R6.y, R1.z, c[18].x;
MAD R1.xy, -R1, c[8].x, fragment.texcoord[0];
TEX R1, R1, texture[8], 2D;
MUL R6.y, R6, c[19].x;
MUL R1.w, R6.y, R1;
MUL_SAT R1.w, R0, R1;
MAD R6.x, -R6, c[21].z, R8;
MAD R0.w, R8.y, c[24].x, R6.x;
MUL R6.xyz, R1.w, R1;
COS R0.w, R0.w;
MUL R0.w, R0, R0;
MUL_SAT R3.x, R3, c[9];
MUL R1.xyz, R1, c[0];
MUL R1.xyz, R3.x, R1;
ADD R3.x, -R3, c[21].y;
MAD R1.xyz, R3.x, c[0], R1;
MUL R3.xyz, R6, c[20];
ADD R1.w, -R1, c[21].y;
MAD R3.xyz, R1.w, R1, R3;
TEX R1, fragment.texcoord[0], texture[4], 2D;
MUL R1.xyz, R1, c[11];
MUL R1.xyz, R1, R3;
MUL R3.x, R2.w, R0.w;
MUL R2.w, R0, c[10].x;
MUL R3.x, R0.w, R3;
MUL R2.w, R2, c[10].x;
MUL R3.x, R3, c[25].y;
RCP R2.w, R2.w;
ADD R0.w, -R0, c[21].y;
MUL R0.w, R0, R2;
RCP R2.w, R3.x;
ADD R3.x, R3.w, -c[12];
TEX R3.yw, fragment.texcoord[0].zwzw, texture[3], 2D;
POW R0.w, c[23].y, -R0.w;
MUL R0.w, R0, R2;
ADD R2.w, -R6, c[21].y;
POW R2.w, R2.w, c[25].z;
MAD R2.w, R2, c[12].x, R3.x;
MAD R6.xy, R3.wyzw, c[21].z, -c[21].y;
MUL R0.w, R0, R2;
TEX R3, fragment.texcoord[0], texture[2], 2D;
MUL R2.w, R6.y, R6.y;
MAD R2.w, -R6.x, R6.x, -R2;
ADD R2.y, R2.w, c[21];
RSQ R2.y, R2.y;
RCP R6.z, R2.y;
DP3 R2.y, R4, R5;
DP3 R2.w, fragment.texcoord[1], R6;
RCP R2.x, R2.x;
MUL R0.w, R0, R3;
MUL_SAT R0.w, R0, R2.x;
DP3 R2.x, R4, R6;
RCP R2.y, R2.y;
MUL R2.x, R6.w, R2;
MUL R2.x, R2, R2.y;
MUL R2.z, R6.w, R2.w;
MUL R2.y, R2, R2.z;
MUL R2.x, R2, c[21].z;
ADD R4.xyz, fragment.texcoord[1], R4;
MUL R0.xyz, R0, R5.w;
MUL R5.y, R4.w, c[12].x;
MAX R5.x, R6.w, c[21];
POW R5.x, R5.x, R5.y;
MUL R2.z, R1.w, R5.x;
MUL R1.w, R2.y, c[21].z;
MIN_SAT R1.w, R2.x, R1;
MUL R2.y, R2.z, c[23].z;
MAD R0.w, R0, R1, R2.y;
MOV R2.xyz, c[13];
MUL_SAT R0.w, R7.z, R0;
MUL R2.xyz, R2, c[0];
MUL R2.xyz, R2, R0.w;
MAD R1.xyz, R1, R7.w, R2;
DP3 R0.w, R4, R4;
RSQ R1.w, R0.w;
MUL R2.xyz, R1.w, R4;
DP3 R1.w, R6, R2;
TEX R0.w, fragment.texcoord[0], texture[5], 2D;
ADD_SAT R0.w, R0, c[14].x;
MUL R1.xyz, R5.w, R1;
MUL R1.xyz, R0.w, R1;
ADD R0.w, -R0, c[21].y;
MAD R0.xyz, R0.w, R0, R1;
MOV R1.xyz, c[1];
MUL R2.x, R4.w, c[16];
MAX R1.w, R1, c[21].x;
POW R1.w, R1.w, R2.x;
MUL R2.xyz, R3, c[15];
MUL_SAT R0.w, R3, R1;
MUL R1.xyz, R1, c[0];
MUL R1.xyz, R1, R0.w;
MAX R0.w, R2, c[21].x;
MUL R2.xyz, R2, c[0];
MAD R1.xyz, R2, R0.w, R1;
TEX R0.w, fragment.texcoord[0], texture[1], 2D;
ADD_SAT R0.w, R0, c[17].x;
MUL R1.xyz, R5.w, R1;
MUL R1.xyz, R0.w, R1;
ADD R0.w, -R0, c[21].y;
MAD result.color.xyz, R0.w, R0, R1;
MOV result.color.w, c[21].x;
END
# 318 instructions, 9 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color3]
Float 3 [_Shininess3]
Vector 4 [_SpecColor3]
Float 5 [_Layer1Thickness]
Float 6 [_Layer2Thickness]
Float 7 [_GVar]
Float 8 [_ExitColorMultiplier]
Float 9 [_ExitColorRadius]
Float 10 [_SpecSmoothing]
Vector 11 [_Color2]
Float 12 [_Shininess2]
Vector 13 [_SpecColor2]
Float 14 [_BlendAdjust2]
Vector 15 [_Color]
Float 16 [_Shininess]
Float 17 [_BlendAdjust1]
Float 18 [_DDXP]
Float 19 [_DDXM]
Vector 20 [_SSSC]
SetTexture 0 [_MainTex3] 2D
SetTexture 1 [_ScatterMap] 2D
SetTexture 2 [_MainTex] 2D
SetTexture 3 [_BumpMap] 2D
SetTexture 4 [_MainTex2] 2D
SetTexture 5 [_ScatterMap2] 2D
SetTexture 6 [_LightTexture0] 2D
SetTexture 7 [_BumpMap3] 2D
SetTexture 8 [_ExitColorMap] 2D
SetTexture 9 [_BumpMap2] 2D
"ps_3_0
; 376 ALU, 11 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
dcl_2d s7
dcl_2d s8
dcl_2d s9
def c21, 2.00000000, -1.00000000, 0.11705996, 0.50000000
def c22, 6.28318501, -3.14159298, -0.73550957, 0.73550957
def c23, 0.00000000, -1.00000000, 0.15799320, 0.50000000
def c24, -0.99270076, 0.99270076, 2.71828198, -0.21211439
def c25, 0.39894229, 1.00000000, 0.00000000, 1.57072902
def c26, -0.01872930, 0.07426100, 3.14159298, 3.14159274
def c27, 0.15915491, 0.50000000, 5.00000000, 128.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xy
mul r0.x, v1.y, v1.y
mad r0.x, v1, v1, r0
mad r0.x, v1.z, v1.z, r0
rsq r4.w, r0.x
mul r1.x, r4.w, -v1.z
mad r0.x, r1, c21.z, c21.w
frc r0.x, r0
mad r1.y, r0.x, c22.x, c22
sincos r0.xy, r1.y
mad r0.z, r1.x, c22, r0.x
dp3 r0.y, v1, v1
mul r1.xy, r0.z, c23
rsq r0.x, r0.y
mul r0.xyz, r0.x, v1
mad r3.xyz, r0, c22.w, r1.xxyw
mul r0.x, r3.y, r3.y
mad r0.x, r3, r3, r0
mad r0.x, r3.z, r3.z, r0
rsq r0.x, r0.x
mul r1.x, r0, -r3.z
mad r0.x, r1, c23.z, c23.w
frc r0.x, r0
mad r1.y, r0.x, c22.x, c22
sincos r0.xy, r1.y
mad r0.z, r1.x, c24.x, r0.x
dp3 r0.y, r3, r3
rsq r0.x, r0.y
mul r6.xyz, r0.x, r3
mul r0.zw, r0.z, c23.xyxy
mad r1.xyz, r6, c24.y, r0.zzww
dp3 r0.x, r1, r1
rsq r0.w, r0.x
mul r2.xyz, r0.w, r1
mad r0.xyz, -r6, c5.x, v1
mad r4.xyz, -r2, c6.x, r0
texld r0.yw, v0.zwzw, s7
mad_pp r5.xy, r0.wyzw, c21.x, c21.y
dp3 r0.x, r4, r4
rsq r0.x, r0.x
mul r2.xyz, r0.x, r4
mul_pp r0.w, r5.y, r5.y
mad_pp r0.w, -r5.x, r5.x, -r0
dp3_pp r0.x, v2, v2
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, v2
add r7.xyz, r2, r0
dp3 r1.w, r7, r7
rsq r1.w, r1.w
add_pp r0.w, r0, c25.y
rsq_pp r0.w, r0.w
add r3.xyz, -r3, v1
add r1.xyz, -r1, v1
rcp_pp r5.z, r0.w
mul r7.xyz, r1.w, r7
dp3 r7.w, r5, r7
abs r0.w, r7
add r2.w, -r0, c25.y
mad r1.w, r0, c26.x, c26.y
mad r1.w, r1, r0, c24
rsq r2.w, r2.w
mul r9.xyz, r6, c5.x
mad r0.w, r1, r0, c25
rcp r2.w, r2.w
mul r1.w, r0, r2
cmp r0.w, r7, c25.z, c25.y
mul r2.w, r0, r1
mad r1.w, -r2, c21.x, r1
mul r2.w, r1.y, r1.y
dp3 r1.y, r5, r2
mad r1.x, r1, r1, r2.w
max r3.w, r1.y, c23.x
mad r1.y, r1.z, r1.z, r1.x
mov r1.x, c6
add r1.z, -c5.x, -r1.x
rsq r1.y, r1.y
rcp r1.x, r1.y
add r1.y, r1.z, c21.x
mul r1.x, r1, c7
mul r1.y, r1.x, r1
mul r1.x, r3.w, r3.w
mul r1.x, r1, r1.y
mad r1.z, r0.w, c26, r1.w
mul r0.w, r1.x, r1.y
mad r1.x, r1.z, c27, c27.y
frc r2.x, r1
mul r0.w, r0, c21
pow r1, c24.z, -r0.w
mad r0.w, r2.x, c22.x, c22.y
sincos r2.xy, r0.w
mov r0.w, r1.x
mad r6.w, -r0, c25.x, c25.y
mul r0.w, r4.y, r4.y
mad r1.x, r4, r4, r0.w
mul r3.w, r3, r6
dp3 r2.w, r4, v1
mul r8.x, r2, r2
mad r2.y, r4.z, r4.z, r1.x
add_sat r0.w, -r3, c25.y
pow r1, r0.w, c18.x
rsq r0.w, r2.y
add r1.zw, r4.xyxy, -v1.xyxy
rcp r0.w, r0.w
mul r0.w, r4, r0
mul r1.zw, r1, c6.x
mul r1.zw, r1, r0.w
mov r0.w, r1.x
mul r2.y, r0.w, c19.x
mad r1.xy, -r1.zwzw, c8.x, v0
texld r1, r1, s8
texld r0.w, v3, s6
mul r1.w, r2.y, r1
mul_sat r1.w, r1, r0
mul r2.xyz, r1.w, r1
mul r5.w, c10.x, c10.x
mul_sat r2.w, r2, c9.x
mul_pp r1.xyz, r1, c0
mul r1.xyz, r2.w, r1
add r2.w, -r2, c25.y
mad r1.xyz, r2.w, c0, r1
mul r2.xyz, r2, c20
add r1.w, -r1, c25.y
mad r1.xyz, r1.w, r1, r2
texld r2, v0, s0
mul_pp r2.xyz, r2, c2
mul_pp r4.xyz, r2, r1
mul r1.w, r8.x, c10.x
mul r1.w, r1, c10.x
add r1.x, -r8, c25.y
rcp r1.y, r1.w
mul r2.x, r1, r1.y
pow r1, c24.z, -r2.x
mul r1.y, r8.x, r5.w
mul r1.y, r8.x, r1
mov r2.y, r1.x
mul r1.x, r1.y, c26.w
add r2.z, -r7.w, c25.y
rcp r2.x, r1.x
pow r1, r2.z, c27.z
mov_pp r1.y, c3.x
add_pp r1.y, c25, -r1
mad r1.y, r1.x, c3.x, r1
mul r1.x, r2.y, r2
mul r1.x, r1, r1.y
dp3_pp r1.y, r5, r0
dp3_pp r1.w, r7, r0
mul r1.x, r2.w, r1
rcp r1.z, r1.y
mul_sat r8.x, r1, r1.z
mul r1.x, r7.w, r1.y
rcp r1.z, r1.w
mul r1.x, r1, r1.z
dp3_pp r1.y, r5, v1
mul r8.y, r1.x, c21.x
mul r1.x, r7.w, r1.y
mul r1.x, r1.z, r1
mul r8.z, r1.x, c21.x
add r5.xyz, v1, -r9
texld r1.yw, v0.zwzw, s9
mad_pp r2.xy, r1.wyzw, c21.x, c21.y
dp3 r1.x, r5, r5
rsq r1.x, r1.x
mul r6.xyz, r1.x, r5
add r1.xyz, r0, r6
dp3 r2.z, r1, r1
mul_pp r1.w, r2.y, r2.y
mad_pp r1.w, -r2.x, r2.x, -r1
rsq r2.z, r2.z
add_pp r1.w, r1, c25.y
mul r7.xyz, r2.z, r1
rsq_pp r1.w, r1.w
rcp_pp r2.z, r1.w
dp3 r8.w, r2, r7
abs r1.x, r8.w
min_sat r8.y, r8, r8.z
dp3_pp r7.x, r0, r7
add r1.z, -r1.x, c25.y
mad r1.y, r1.x, c26.x, c26
mad r1.y, r1, r1.x, c24.w
rsq r1.z, r1.z
mad r1.x, r1.y, r1, c25.w
rcp r1.z, r1.z
mul r1.y, r1.x, r1.z
cmp r8.z, r8.w, c25, c25.y
mul r1.z, r8, r1.y
mov_pp r1.x, c3
max r7.w, r7, c23.x
mad r9.w, -r1.z, c21.x, r1.y
mul_pp r9.z, c27.w, r1.x
pow r1, r7.w, r9.z
mad r1.y, r8.z, c26.z, r9.w
mul r1.x, r2.w, r1
mad r1.y, r1, c27.x, c27
frc r1.y, r1
mad r7.w, r1.y, c22.x, c22.y
mul r2.w, r1.x, c21
sincos r1.xy, r7.w
mad r1.y, r8.x, r8, r2.w
mul r2.w, r1.x, r1.x
mul_sat r1.w, r6, r1.y
mov_pp r1.xyz, c0
mul_pp r1.xyz, c4, r1
mul r1.xyz, r1, r1.w
mad r4.xyz, r4, r3.w, r1
mul r6.w, r2, c10.x
mul r1.w, r6, c10.x
mul_pp r6.w, r0, c21.x
add r1.x, -r2.w, c25.y
rcp r1.y, r1.w
mul r3.w, r1.x, r1.y
pow r1, c24.z, -r3.w
mul r1.y, r5.w, r2.w
mov r3.w, r1.x
mul r1.x, r2.w, r1.y
mul r2.w, r1.x, c26
add r5.w, -r8, c25.y
pow r1, r5.w, c27.z
rcp r1.y, r2.w
mul r1.z, r3.w, r1.y
mov r2.w, r1.x
texld r1.yw, v0.zwzw, s3
mad_pp r8.xy, r1.wyzw, c21.x, c21.y
mul_pp r1.y, r8, r8
mad_pp r3.w, -r8.x, r8.x, -r1.y
add_pp r3.w, r3, c25.y
rsq_pp r5.w, r3.w
dp3_pp r3.w, r0, r2
dp3 r2.x, r2, r6
rcp_pp r8.z, r5.w
mov_pp r1.x, c12
add_pp r1.x, c25.y, -r1
mad r1.x, r2.w, c12, r1
mul r2.w, r1.z, r1.x
texld r1, v0, s2
mul_pp r1.xyz, r1, c15
max r6.x, r2, c23
mul r2.w, r2, r1
rcp r3.w, r3.w
mul_sat r7.w, r2, r3
dp3_pp r3.w, r0, r8
dp3_pp r5.w, v1, r8
mul r2.w, r8, r5
rcp r7.x, r7.x
mul r3.w, r8, r3
mul r3.w, r3, r7.x
mul r7.x, r7, r2.w
mul r2.w, r3, c21.x
mul r3.w, r7.x, c21.x
min_sat r7.y, r2.w, r3.w
mul r2.w, r3.y, r3.y
mad r2.w, r3.x, r3.x, r2
mad r2.y, r3.z, r3.z, r2.w
rsq r2.x, r2.y
rcp r2.z, r2.x
mov_pp r2.w, c12.x
mov r2.x, c5
mul r2.y, r6.x, r6.x
mul_pp r3.w, c27, r2
max r3.y, r8.w, c23.x
mul r2.z, r2, c7.x
add r2.x, c25.y, -r2
mul r3.x, r2.z, r2
mul r3.z, r2.y, r3.x
pow r2, r3.y, r3.w
mul r2.y, r3.z, r3.x
mul r3.x, r2.y, c21.w
mov r6.y, r2.x
pow r2, c24.z, -r3.x
texld r3, v0, s4
mul r6.z, r3.w, r6.y
mad r3.w, -r2.x, c25.x, c25.y
mul r7.x, r6, r3.w
mul r2.y, r5, r5
mad r2.y, r5.x, r5.x, r2
mad r2.x, r5.z, r5.z, r2.y
rsq r2.x, r2.x
rcp r6.y, r2.x
add_sat r6.x, -r7, c25.y
pow r2, r6.x, c18.x
mul r2.y, r4.w, r6
mul r2.zw, -r9.xyxy, c5.x
mul r2.zw, r2, r2.y
mov r4.w, r2.x
mad r6.xy, -r2.zwzw, c8.x, v0
texld r2, r6, s8
mul r4.w, r4, c19.x
mul r2.w, r4, r2
mul r4.w, r6.z, c21
mul_sat r2.w, r0, r2
mul r6.xyz, r2.w, r2
mad r0.w, r7, r7.y, r4
dp3 r4.w, v1, r5
mul_sat r4.w, r4, c9.x
mul_pp r2.xyz, r2, c0
mul r2.xyz, r4.w, r2
add r4.w, -r4, c25.y
add r2.w, -r2, c25.y
mul_pp r3.xyz, r3, c11
mul_sat r0.w, r3, r0
add_pp r0.xyz, v1, r0
mul r4.xyz, r4, r6.w
mad r2.xyz, r4.w, c0, r2
mul r5.xyz, r6, c20
mad r2.xyz, r2.w, r2, r5
mul_pp r2.xyz, r3, r2
mov_pp r3.xyz, c0
mul_pp r3.xyz, c13, r3
mul r3.xyz, r3, r0.w
mad r2.xyz, r2, r7.x, r3
dp3_pp r0.w, r0, r0
rsq_pp r0.w, r0.w
mul_pp r0.xyz, r0.w, r0
mov_pp r0.w, c16.x
dp3_pp r0.x, r8, r0
mul r2.xyz, r6.w, r2
mul_pp r3.x, c27.w, r0.w
max_pp r2.w, r0.x, c23.x
pow r0, r2.w, r3.x
texld r0.w, v0, s5
add_sat r0.y, r0.w, c14.x
mov r0.w, r0.x
mul_pp r2.xyz, r0.y, r2
add_pp r0.x, -r0.y, c25.y
mad_pp r0.xyz, r0.x, r4, r2
mov_pp r2.xyz, c0
mul_sat r0.w, r1, r0
mul_pp r2.xyz, c1, r2
mul r2.xyz, r2, r0.w
max_pp r0.w, r5, c23.x
mul_pp r1.xyz, r1, c0
mad r1.xyz, r1, r0.w, r2
texld r0.w, v0, s1
add_sat r0.w, r0, c17.x
mul r1.xyz, r6.w, r1
mul_pp r1.xyz, r0.w, r1
add_pp r0.w, -r0, c25.y
mad_pp oC0.xyz, r0.w, r0, r1
mov_pp oC0.w, c23.x
"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_LightShadowData]
Vector 3 [_Color3]
Float 4 [_Shininess3]
Vector 5 [_SpecColor3]
Float 6 [_Layer1Thickness]
Float 7 [_Layer2Thickness]
Float 8 [_GVar]
Float 9 [_ExitColorMultiplier]
Float 10 [_ExitColorRadius]
Float 11 [_SpecSmoothing]
Vector 12 [_Color2]
Float 13 [_Shininess2]
Vector 14 [_SpecColor2]
Float 15 [_BlendAdjust2]
Vector 16 [_Color]
Float 17 [_Shininess]
Float 18 [_BlendAdjust1]
Float 19 [_DDXP]
Float 20 [_DDXM]
Vector 21 [_SSSC]
SetTexture 0 [_MainTex3] 2D
SetTexture 1 [_ScatterMap] 2D
SetTexture 2 [_MainTex] 2D
SetTexture 3 [_BumpMap] 2D
SetTexture 4 [_MainTex2] 2D
SetTexture 5 [_ScatterMap2] 2D
SetTexture 6 [_LightTexture0] 2D
SetTexture 7 [_LightTextureB0] 2D
SetTexture 8 [_ShadowMapTexture] 2D
SetTexture 9 [_BumpMap3] 2D
SetTexture 10 [_ExitColorMap] 2D
SetTexture 11 [_BumpMap2] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 333 ALU, 13 TEX
PARAM c[27] = { program.local[0..21],
		{ 0, 1, 2, 0.73550957 },
		{ -0.73550957, 0, -1, 0.99270076 },
		{ -0.99270076, 2.718282, 0.5, 0.39894229 },
		{ 3.141593, -0.018729299, 0.074261002, 0.21211439 },
		{ 1.570729, 3.1415927, 5, 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEMP R7;
TEMP R8;
TEMP R9;
TEMP R10;
TEX R5.yw, fragment.texcoord[0].zwzw, texture[9], 2D;
MAD R5.xy, R5.wyzw, c[22].z, -c[22].y;
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.x, R0.x;
MUL R2.xyz, R0.x, fragment.texcoord[1];
MUL R0.x, R2.y, R2.y;
MAD R0.x, R2, R2, R0;
MAD R0.x, R2.z, R2.z, R0;
RSQ R4.w, R0.x;
MUL R0.y, R4.w, -R2.z;
MUL R0.x, R0.y, c[22].w;
COS R0.z, R0.x;
DP3 R0.x, R2, R2;
MAD R0.y, R0, c[23].x, R0.z;
MUL R1.xy, R0.y, c[23].yzzw;
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, R2;
MAD R9.xyz, R0, c[22].w, R1.xxyw;
MUL R0.x, R9.y, R9.y;
MAD R0.x, R9, R9, R0;
MAD R0.x, R9.z, R9.z, R0;
RSQ R0.x, R0.x;
MUL R0.y, R0.x, -R9.z;
MUL R0.x, R0.y, c[23].w;
COS R0.z, R0.x;
MAD R0.y, R0, c[24].x, R0.z;
DP3 R0.x, R9, R9;
RSQ R0.x, R0.x;
MUL R6.xyz, R0.x, R9;
ADD R9.xyz, -R9, R2;
MUL R0.zw, R0.y, c[23].xyyz;
MAD R0.xyz, R6, c[23].w, R0.zzww;
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R1.xyz, R0.w, R0;
ADD R0.xyz, -R0, R2;
MAD R3.xyz, -R6, c[6].x, R2;
MAD R1.xyz, -R1, c[7].x, R3;
DP3 R0.w, R1, R1;
RSQ R0.w, R0.w;
MUL R3.xyz, R0.w, R1;
MUL R2.w, R0.y, R0.y;
MUL R9.y, R9, R9;
MAD R9.x, R9, R9, R9.y;
DP3 R0.w, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.w, R0.w;
MUL R4.xyz, R0.w, fragment.texcoord[2];
ADD R7.xyz, R3, R4;
MUL R0.w, R5.y, R5.y;
MAD R0.w, -R5.x, R5.x, -R0;
DP3 R1.w, R7, R7;
RSQ R1.w, R1.w;
ADD R0.w, R0, c[22].y;
RSQ R0.w, R0.w;
RCP R5.z, R0.w;
MUL R7.xyz, R1.w, R7;
DP3 R8.x, R5, R7;
ABS R1.w, R8.x;
MAD R0.w, R1, c[25].y, c[25].z;
MAD R0.w, R0, R1, -c[25];
MAD R0.w, R0, R1, c[26].x;
ADD R1.w, -R1, c[22].y;
DP3 R0.y, R5, R3;
MAD R2.w, R0.x, R0.x, R2;
MAX R0.x, R0.y, c[22];
MAD R0.y, R0.z, R0.z, R2.w;
MOV R0.z, c[6].x;
RSQ R0.y, R0.y;
ADD R0.z, -R0, -c[7].x;
RCP R0.y, R0.y;
MUL R10.xyz, R6, c[6].x;
DP3 R8.y, R1, R2;
MOV R5.w, c[22].y;
MUL R0.y, R0, c[8].x;
ADD R0.z, R0, c[22];
MUL R0.z, R0.y, R0;
MUL R0.y, R0.x, R0.x;
MUL R0.y, R0, R0.z;
MUL R0.y, R0, R0.z;
RSQ R1.w, R1.w;
RCP R0.z, R1.w;
MUL R6.w, R0, R0.z;
MUL R0.z, R1.y, R1.y;
MUL R0.y, R0, c[24].z;
POW R0.y, c[24].y, -R0.y;
MUL R0.y, -R0, c[24].w;
ADD R8.w, R0.y, c[22].y;
MAD R0.z, R1.x, R1.x, R0;
DP3 R1.w, fragment.texcoord[3], fragment.texcoord[3];
MUL R7.w, R0.x, R8;
MAD R0.y, R1.z, R1.z, R0.z;
RSQ R0.x, R0.y;
RCP R0.w, R0.x;
ADD R0.xy, R1, -R2;
ADD_SAT R0.z, -R7.w, c[22].y;
POW R0.z, R0.z, c[19].x;
MUL R0.w, R4, R0;
MUL R0.xy, R0, c[7].x;
MUL R0.xy, R0, R0.w;
MAD R0.xy, -R0, c[9].x, fragment.texcoord[0];
TEX R3, R0, texture[10], 2D;
MUL R1.xyz, R3, c[0];
MUL R0.z, R0, c[20].x;
TXP R0.x, fragment.texcoord[4], texture[8], 2D;
RCP R0.y, fragment.texcoord[4].w;
MAD R0.y, -fragment.texcoord[4].z, R0, R0.x;
CMP R2.w, R0.y, c[2].x, R5;
RCP R0.x, fragment.texcoord[3].w;
MAD R0.xy, fragment.texcoord[3], R0.x, c[24].z;
TEX R0.w, R0, texture[6], 2D;
SLT R0.x, c[22], fragment.texcoord[3].z;
MUL R0.x, R0, R0.w;
TEX R1.w, R1.w, texture[7], 2D;
MUL R0.x, R0, R1.w;
MUL R2.w, R0.x, R2;
MUL R0.x, R0.z, R3.w;
MUL_SAT R3.w, R0.x, R2;
MUL R0.xyz, R3.w, R3;
SLT R1.w, R8.x, c[22].x;
MUL_SAT R3.x, R8.y, c[10];
MUL R1.xyz, R3.x, R1;
ADD R3.x, -R3, c[22].y;
MAD R1.xyz, R3.x, c[0], R1;
ADD R3.x, -R3.w, c[22].y;
MUL R0.xyz, R0, c[21];
MUL R0.w, R1, R6;
MAD R1.xyz, R3.x, R1, R0;
MAD R3.x, -R0.w, c[22].z, R6.w;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0.xyz, R0, c[3];
MAD R1.w, R1, c[25].x, R3.x;
MUL R1.xyz, R0, R1;
COS R0.x, R1.w;
MUL R0.x, R0, R0;
MUL R1.w, c[11].x, c[11].x;
MUL R0.z, R0.x, R1.w;
MUL R0.y, R0.x, c[11].x;
MUL R0.z, R0.x, R0;
MUL R0.y, R0, c[11].x;
MOV R6.w, c[26];
MUL R0.z, R0, c[26].y;
RCP R0.y, R0.y;
ADD R0.x, -R0, c[22].y;
MUL R0.x, R0, R0.y;
RCP R0.y, R0.z;
MOV R3.w, c[22].y;
ADD R0.z, R3.w, -c[4].x;
POW R0.x, c[24].y, -R0.x;
MUL R0.x, R0, R0.y;
ADD R0.y, -R8.x, c[22];
POW R0.y, R0.y, c[26].z;
MAD R0.y, R0, c[4].x, R0.z;
MUL R0.x, R0, R0.y;
DP3 R0.z, R5, R4;
RCP R0.y, R0.z;
MUL R0.x, R0.w, R0;
MUL_SAT R9.w, R0.x, R0.y;
DP3 R0.y, R5, R2;
DP3 R0.x, R7, R4;
MUL R3.x, R8, R0.y;
RCP R0.y, R0.x;
MUL R0.x, R8, R0.z;
MUL R0.x, R0, R0.y;
MUL R0.y, R0, R3.x;
ADD R7.xyz, R2, -R10;
MUL R0.x, R0, c[22].z;
MUL R0.y, R0, c[22].z;
MIN_SAT R5.x, R0, R0.y;
MUL R0.y, R6.w, c[4].x;
MAX R0.x, R8, c[22];
POW R0.x, R0.x, R0.y;
MUL R0.x, R0.w, R0;
MUL R5.y, R0.x, c[24].z;
MAD R5.x, R9.w, R5, R5.y;
TEX R0.yw, fragment.texcoord[0].zwzw, texture[11], 2D;
MAD R3.xy, R0.wyzw, c[22].z, -c[22].y;
DP3 R0.x, R7, R7;
RSQ R0.x, R0.x;
MUL R8.xyz, R0.x, R7;
ADD R0.xyz, R4, R8;
MUL R0.w, R3.y, R3.y;
MAD R0.w, -R3.x, R3.x, -R0;
DP3 R3.z, R0, R0;
RSQ R3.z, R3.z;
ADD R0.w, R0, c[22].y;
MUL R0.xyz, R3.z, R0;
RSQ R0.w, R0.w;
RCP R3.z, R0.w;
DP3 R0.w, R3, R0;
ABS R5.y, R0.w;
MUL_SAT R6.z, R8.w, R5.x;
DP3 R0.x, R4, R0;
ADD R5.z, -R5.y, c[22].y;
MAD R5.x, R5.y, c[25].y, c[25].z;
MAD R5.x, R5, R5.y, -c[25].w;
RSQ R5.z, R5.z;
SLT R6.x, R0.w, c[22];
RCP R5.z, R5.z;
MAD R5.x, R5, R5.y, c[26];
MUL R6.y, R5.x, R5.z;
MUL R8.w, R6.x, R6.y;
MAD R6.y, -R8.w, c[22].z, R6;
DP3 R8.w, R4, R3;
DP3 R3.x, R3, R8;
MAD R9.x, R9.z, R9.z, R9;
RSQ R3.y, R9.x;
MOV R5.xyz, c[5];
MUL R5.xyz, R5, c[0];
MUL R5.xyz, R5, R6.z;
MAD R1.xyz, R1, R7.w, R5;
MAD R6.x, R6, c[25], R6.y;
COS R5.x, R6.x;
MUL R7.w, R2, c[22].z;
RCP R3.y, R3.y;
MOV R8.xyz, c[14];
MUL R5.x, R5, R5;
MUL R6.xyz, R1, R7.w;
MUL R1.y, R1.w, R5.x;
MUL R1.x, R5, c[11];
MUL R1.z, R5.x, R1.y;
MUL R1.x, R1, c[11];
RCP R1.y, R1.x;
ADD R1.x, -R5, c[22].y;
MUL R1.x, R1, R1.y;
MUL R1.y, R1.z, c[26];
ADD R1.z, -R0.w, c[22].y;
MAX R3.x, R3, c[22];
RCP R1.y, R1.y;
POW R1.x, c[24].y, -R1.x;
MUL R1.x, R1, R1.y;
TEX R1.yw, fragment.texcoord[0].zwzw, texture[3], 2D;
MAD R5.xy, R1.wyzw, c[22].z, -c[22].y;
POW R1.z, R1.z, c[26].z;
ADD R3.w, R3, -c[13].x;
MAD R1.y, R1.z, c[13].x, R3.w;
MUL R1.z, R5.y, R5.y;
MAD R5.z, -R5.x, R5.x, -R1;
MUL R3.w, R1.x, R1.y;
TEX R1, fragment.texcoord[0], texture[2], 2D;
ADD R5.z, R5, c[22].y;
RSQ R5.z, R5.z;
RCP R5.z, R5.z;
DP3 R9.w, R4, R5;
MUL R1.xyz, R1, c[16];
MUL R9.w, R0, R9;
RCP R8.w, R8.w;
MUL R3.w, R3, R1;
MUL_SAT R3.w, R3, R8;
DP3 R8.w, R2, R5;
MUL R0.y, R0.w, R8.w;
RCP R0.x, R0.x;
MUL R0.y, R0.x, R0;
MUL R0.x, R9.w, R0;
MUL R0.y, R0, c[22].z;
MUL R0.x, R0, c[22].z;
MIN_SAT R9.w, R0.x, R0.y;
MAX R0.x, R0.w, c[22];
MUL R0.y, R6.w, c[13].x;
POW R10.z, R0.x, R0.y;
TEX R0, fragment.texcoord[0], texture[4], 2D;
MUL R0.w, R0, R10.z;
MUL R0.w, R0, c[24].z;
MAD R3.w, R3, R9, R0;
ADD R3.z, R5.w, -c[6].x;
MUL R3.y, R3, c[8].x;
MUL R3.z, R3.y, R3;
MUL R3.y, R3.x, R3.x;
MUL R3.y, R3, R3.z;
MUL R0.w, R3.y, R3.z;
MUL R3.y, R7, R7;
MAD R3.y, R7.x, R7.x, R3;
MAD R3.y, R7.z, R7.z, R3;
MUL R0.w, R0, c[24].z;
POW R0.w, c[24].y, -R0.w;
MUL R0.w, -R0, c[24];
ADD R0.w, R0, c[22].y;
MUL_SAT R5.w, R0, R3;
MUL R8.xyz, R8, c[0];
RSQ R3.y, R3.y;
RCP R3.y, R3.y;
MUL R0.w, R3.x, R0;
MUL R3.z, R4.w, R3.y;
MUL R3.xy, -R10, c[6].x;
MUL R3.xy, R3, R3.z;
ADD_SAT R3.z, -R0.w, c[22].y;
POW R4.w, R3.z, c[19].x;
MAD R3.xy, -R3, c[9].x, fragment.texcoord[0];
TEX R3, R3, texture[10], 2D;
MUL R4.w, R4, c[20].x;
MUL R3.w, R4, R3;
MUL_SAT R2.w, R2, R3;
DP3 R3.w, R2, R7;
MUL R9.xyz, R8, R5.w;
MUL R8.xyz, R2.w, R3;
MUL_SAT R3.w, R3, c[10].x;
MUL R3.xyz, R3, c[0];
MUL R3.xyz, R3.w, R3;
ADD R3.w, -R3, c[22].y;
ADD R2.w, -R2, c[22].y;
ADD R2.xyz, R2, R4;
MAD R3.xyz, R3.w, c[0], R3;
MUL R7.xyz, R8, c[21];
MAD R3.xyz, R2.w, R3, R7;
DP3 R2.w, R2, R2;
MUL R0.xyz, R0, c[12];
MUL R0.xyz, R0, R3;
MAD R0.xyz, R0, R0.w, R9;
TEX R0.w, fragment.texcoord[0], texture[5], 2D;
RSQ R2.w, R2.w;
MUL R2.xyz, R2.w, R2;
ADD_SAT R0.w, R0, c[15].x;
MUL R0.xyz, R7.w, R0;
MUL R0.xyz, R0.w, R0;
ADD R0.w, -R0, c[22].y;
MAD R0.xyz, R0.w, R6, R0;
DP3 R0.w, R5, R2;
MUL R2.x, R6.w, c[17];
MAX R0.w, R0, c[22].x;
POW R0.w, R0.w, R2.x;
MOV R2.xyz, c[1];
MUL_SAT R0.w, R1, R0;
MUL R2.xyz, R2, c[0];
MUL R2.xyz, R2, R0.w;
MAX R0.w, R8, c[22].x;
MUL R1.xyz, R1, c[0];
MAD R1.xyz, R1, R0.w, R2;
TEX R0.w, fragment.texcoord[0], texture[1], 2D;
ADD_SAT R0.w, R0, c[18].x;
MUL R1.xyz, R7.w, R1;
MUL R1.xyz, R0.w, R1;
ADD R0.w, -R0, c[22].y;
MAD result.color.xyz, R0.w, R0, R1;
MOV result.color.w, c[22].x;
END
# 333 instructions, 11 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_LightShadowData]
Vector 3 [_Color3]
Float 4 [_Shininess3]
Vector 5 [_SpecColor3]
Float 6 [_Layer1Thickness]
Float 7 [_Layer2Thickness]
Float 8 [_GVar]
Float 9 [_ExitColorMultiplier]
Float 10 [_ExitColorRadius]
Float 11 [_SpecSmoothing]
Vector 12 [_Color2]
Float 13 [_Shininess2]
Vector 14 [_SpecColor2]
Float 15 [_BlendAdjust2]
Vector 16 [_Color]
Float 17 [_Shininess]
Float 18 [_BlendAdjust1]
Float 19 [_DDXP]
Float 20 [_DDXM]
Vector 21 [_SSSC]
SetTexture 0 [_MainTex3] 2D
SetTexture 1 [_ScatterMap] 2D
SetTexture 2 [_MainTex] 2D
SetTexture 3 [_BumpMap] 2D
SetTexture 4 [_MainTex2] 2D
SetTexture 5 [_ScatterMap2] 2D
SetTexture 6 [_LightTexture0] 2D
SetTexture 7 [_LightTextureB0] 2D
SetTexture 8 [_ShadowMapTexture] 2D
SetTexture 9 [_BumpMap3] 2D
SetTexture 10 [_ExitColorMap] 2D
SetTexture 11 [_BumpMap2] 2D
"ps_3_0
; 389 ALU, 13 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
dcl_2d s7
dcl_2d s8
dcl_2d s9
dcl_2d s10
dcl_2d s11
def c22, 2.00000000, -1.00000000, 0.11705996, 0.50000000
def c23, 6.28318501, -3.14159298, -0.73550957, 0.73550957
def c24, 0.00000000, -1.00000000, 0.15799320, 0.50000000
def c25, -0.99270076, 0.99270076, 2.71828198, -0.21211439
def c26, 0.39894229, 1.00000000, 0.00000000, 1.57072902
def c27, -0.01872930, 0.07426100, 3.14159298, 3.14159274
def c28, 0.15915491, 0.50000000, 5.00000000, 128.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3
dcl_texcoord4 v4
texld r5.yw, v0.zwzw, s9
dp3_pp r0.x, v1, v1
rsq_pp r0.x, r0.x
mul_pp r2.xyz, r0.x, v1
mul r0.x, r2.y, r2.y
mad r0.x, r2, r2, r0
mad r0.x, r2.z, r2.z, r0
rsq r1.w, r0.x
mul r1.x, r1.w, -r2.z
mad r0.x, r1, c22.z, c22.w
frc r0.x, r0
mad r1.y, r0.x, c23.x, c23
sincos r0.xy, r1.y
mad r0.z, r1.x, c23, r0.x
dp3 r0.y, r2, r2
mad_pp r6.xy, r5.wyzw, c22.x, c22.y
mul r1.xy, r0.z, c24
rsq r0.x, r0.y
mul r0.xyz, r0.x, r2
mad r3.xyz, r0, c23.w, r1.xxyw
mul r0.x, r3.y, r3.y
mad r0.x, r3, r3, r0
mad r0.x, r3.z, r3.z, r0
rsq r0.x, r0.x
mul r1.x, r0, -r3.z
mad r0.x, r1, c24.z, c24.w
frc r0.x, r0
mad r1.y, r0.x, c23.x, c23
sincos r0.xy, r1.y
mad r0.z, r1.x, c25.x, r0.x
dp3 r0.y, r3, r3
rsq r0.x, r0.y
mul r7.xyz, r0.x, r3
add r3.xyz, -r3, r2
mul r0.zw, r0.z, c24.xyxy
mad r0.xyz, r7, c25.y, r0.zzww
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, r0
mad r4.xyz, -r7, c6.x, r2
mad r9.xyz, -r1, c7.x, r4
dp3 r0.w, r9, r9
rsq r0.w, r0.w
mul r4.xyz, r0.w, r9
dp3_pp r0.w, v2, v2
rsq_pp r0.w, r0.w
mul_pp r1.xyz, r0.w, v2
add r5.xyz, r4, r1
mul_pp r0.w, r6.y, r6.y
mad_pp r0.w, -r6.x, r6.x, -r0
dp3 r2.w, r5, r5
rsq r2.w, r2.w
add_pp r0.w, r0, c26.y
rsq_pp r0.w, r0.w
mul r3.y, r3, r3
mad r3.y, r3.x, r3.x, r3
add r0.xyz, -r0, r2
rcp_pp r6.z, r0.w
mul r8.xyz, r2.w, r5
dp3 r6.w, r6, r8
abs r0.w, r6
add r3.w, -r0, c26.y
mad r2.w, r0, c27.x, c27.y
mad r2.w, r2, r0, c25
rsq r3.w, r3.w
mad r0.w, r2, r0, c26
rcp r3.w, r3.w
mul r2.w, r0, r3
cmp r0.w, r6, c26.z, c26.y
mul r3.w, r0, r2
mad r3.w, -r3, c22.x, r2
mul r2.w, r0.y, r0.y
dp3 r0.y, r6, r4
mad r0.x, r0, r0, r2.w
max r2.w, r0.y, c24.x
mad r0.y, r0.z, r0.z, r0.x
mov r0.x, c7
add r0.z, -c6.x, -r0.x
rsq r0.y, r0.y
rcp r0.x, r0.y
add r0.y, r0.z, c22.x
mul r0.x, r0, c8
mul r0.y, r0.x, r0
mul r0.x, r2.w, r2.w
mul r0.x, r0, r0.y
mad r0.z, r0.w, c27, r3.w
mul r0.x, r0, r0.y
mad r0.y, r0.z, c28.x, c28
mul r3.w, r0.x, c22
frc r4.x, r0.y
pow r0, c25.z, -r3.w
mad r0.y, r4.x, c23.x, c23
sincos r5.xy, r0.y
mad r5.w, -r0.x, c26.x, c26.y
mul r3.w, r2, r5
mul r0.x, r9.y, r9.y
mad r0.x, r9, r9, r0
mul r8.w, r5.x, r5.x
mad r4.x, r9.z, r9.z, r0
add_sat r2.w, -r3, c26.y
pow r0, r2.w, c19.x
rsq r0.y, r4.x
add r0.zw, r9.xyxy, -r2.xyxy
rcp r0.y, r0.y
mul r0.y, r1.w, r0
mul r0.zw, r0, c7.x
mul r0.zw, r0, r0.y
mov r2.w, r0.x
mad r0.xy, -r0.zwzw, c9.x, v0
texld r4, r0, s10
mul r0.z, r2.w, c20.x
mul r7.w, c11.x, c11.x
mad r3.y, r3.z, r3.z, r3
texldp r0.x, v4, s8
rcp r0.y, v4.w
mad r0.y, -v4.z, r0, r0.x
mov r0.w, c2.x
cmp r2.w, r0.y, c26.y, r0
rcp r0.x, v3.w
mad r10.xy, v3, r0.x, c22.w
texld r0.w, r10, s6
dp3 r0.x, v3, v3
cmp r0.y, -v3.z, c26.z, c26
mul_pp r0.y, r0, r0.w
texld r0.x, r0.x, s7
mul_pp r0.x, r0.y, r0
mul_pp r2.w, r0.x, r2
mul r0.x, r0.z, r4.w
dp3 r4.w, r9, r2
mul_sat r0.w, r0.x, r2
mul r0.xyz, r0.w, r4
mul r10.xyz, r7, c6.x
mul_sat r4.w, r4, c10.x
mul_pp r4.xyz, r4, c0
mul r4.xyz, r4.w, r4
add r4.w, -r4, c26.y
mad r4.xyz, r4.w, c0, r4
add r0.w, -r0, c26.y
mul r0.xyz, r0, c21
mad r0.xyz, r0.w, r4, r0
texld r4, v0, s0
mul_pp r4.xyz, r4, c3
mul_pp r5.xyz, r4, r0
mul r0.w, r8, c11.x
mul r0.w, r0, c11.x
add r0.x, -r8.w, c26.y
rcp r0.y, r0.w
mul r4.x, r0, r0.y
pow r0, c25.z, -r4.x
mul r0.y, r8.w, r7.w
mul r0.y, r8.w, r0
mov r4.y, r0.x
mul r0.x, r0.y, c27.w
add r4.z, -r6.w, c26.y
rcp r4.x, r0.x
pow r0, r4.z, c28.z
mov_pp r0.y, c4.x
add_pp r0.y, c26, -r0
mad r0.y, r0.x, c4.x, r0
mul r0.x, r4.y, r4
mul r0.x, r0, r0.y
dp3_pp r0.y, r6, r1
dp3_pp r0.w, r8, r1
mul r0.x, r4.w, r0
rcp r0.z, r0.y
mul_sat r9.x, r0, r0.z
mul r0.x, r6.w, r0.y
rcp r0.z, r0.w
mul r0.x, r0, r0.z
dp3_pp r0.y, r6, r2
mul r9.y, r0.x, c22.x
mul r0.x, r6.w, r0.y
mul r0.x, r0.z, r0
mul r9.z, r0.x, c22.x
add r6.xyz, r2, -r10
texld r0.yw, v0.zwzw, s11
mad_pp r4.xy, r0.wyzw, c22.x, c22.y
dp3 r0.x, r6, r6
rsq r0.x, r0.x
mul r7.xyz, r0.x, r6
add r0.xyz, r1, r7
dp3 r4.z, r0, r0
mul_pp r0.w, r4.y, r4.y
mad_pp r0.w, -r4.x, r4.x, -r0
rsq r4.z, r4.z
add_pp r0.w, r0, c26.y
mul r8.xyz, r4.z, r0
rsq_pp r0.w, r0.w
rcp_pp r4.z, r0.w
dp3 r8.w, r4, r8
abs r0.x, r8.w
dp3 r3.x, r4, r7
min_sat r9.y, r9, r9.z
max r7.x, r3, c24
rsq r3.x, r3.y
rcp r3.z, r3.x
dp3_pp r8.x, r1, r8
add r0.z, -r0.x, c26.y
mad r0.y, r0.x, c27.x, c27
mad r0.y, r0, r0.x, c25.w
rsq r0.z, r0.z
mov r3.x, c6
mad r0.x, r0.y, r0, c26.w
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r9.z, r8.w, c26, c26.y
mul r0.z, r9, r0.y
mov_pp r0.x, c4
mul r3.y, r7.x, r7.x
max r6.w, r6, c24.x
mad r10.z, -r0, c22.x, r0.y
mul_pp r9.w, c28, r0.x
pow r0, r6.w, r9.w
mad r0.y, r9.z, c27.z, r10.z
mul r0.x, r4.w, r0
mad r0.y, r0, c28.x, c28
frc r0.y, r0
mad r6.w, r0.y, c23.x, c23.y
mul r4.w, r0.x, c22
sincos r0.xy, r6.w
mad r0.y, r9.x, r9, r4.w
mul r4.w, r0.x, r0.x
mul_sat r0.w, r5, r0.y
mov_pp r0.xyz, c0
mul_pp r0.xyz, c5, r0
mul r0.xyz, r0, r0.w
mad r5.xyz, r5, r3.w, r0
mul r5.w, r4, c11.x
mul r0.w, r5, c11.x
mul_pp r5.w, r2, c22.x
add r0.x, -r4.w, c26.y
rcp r0.y, r0.w
mul r3.w, r0.x, r0.y
pow r0, c25.z, -r3.w
mul r0.y, r7.w, r4.w
mov r6.w, r0.x
mul r0.x, r4.w, r0.y
mul r3.w, r0.x, c27
add r4.w, -r8, c26.y
pow r0, r4.w, c28.z
rcp r0.y, r3.w
mul r0.z, r6.w, r0.y
mov r3.w, r0.x
texld r0.yw, v0.zwzw, s3
mad_pp r9.xy, r0.wyzw, c22.x, c22.y
mul_pp r0.y, r9, r9
mad_pp r4.w, -r9.x, r9.x, -r0.y
add_pp r4.w, r4, c26.y
rsq_pp r6.w, r4.w
dp3_pp r4.w, r1, r4
rcp_pp r9.z, r6.w
mov_pp r0.x, c13
add_pp r0.x, c26.y, -r0
mad r0.x, r3.w, c13, r0
mul r3.w, r0.z, r0.x
texld r0, v0, s2
mul_pp r0.xyz, r0, c16
mul r3.w, r3, r0
rcp r4.w, r4.w
mul_sat r7.w, r3, r4
dp3_pp r6.w, r2, r9
dp3_pp r4.w, r1, r9
mul r3.w, r8, r6
rcp r8.x, r8.x
mul r4.w, r8, r4
mul r4.w, r4, r8.x
mul r8.x, r8, r3.w
mul r3.w, r4, c22.x
mul r4.w, r8.x, c22.x
min_sat r8.y, r3.w, r4.w
mov_pp r3.w, c13.x
mul_pp r4.z, c28.w, r3.w
max r4.w, r8, c24.x
mul r3.z, r3, c8.x
add r3.x, c26.y, -r3
mul r4.x, r3.z, r3
mul r4.y, r3, r4.x
pow r3, r4.w, r4.z
mul r3.y, r4, r4.x
mul r4.x, r3.y, c22.w
mov r7.y, r3.x
pow r3, c25.z, -r4.x
texld r4, v0, s4
mul r7.z, r4.w, r7.y
mad r4.w, -r3.x, c26.x, c26.y
mul r8.x, r7, r4.w
mul r3.y, r6, r6
mad r3.y, r6.x, r6.x, r3
mad r3.x, r6.z, r6.z, r3.y
rsq r3.x, r3.x
rcp r7.y, r3.x
add_sat r7.x, -r8, c26.y
pow r3, r7.x, c19.x
mul r1.w, r1, r7.y
mul r3.zw, -r10.xyxy, c6.x
mul r3.zw, r3, r1.w
mov r1.w, r3.x
mad r7.xy, -r3.zwzw, c9.x, v0
texld r3, r7, s10
mul r1.w, r1, c20.x
mul r1.w, r1, r3
mul_sat r2.w, r2, r1
mul r3.w, r7.z, c22
mul r7.xyz, r2.w, r3
mad r1.w, r7, r8.y, r3
dp3 r3.w, r2, r6
add_pp r2.xyz, r2, r1
mov_pp r1.xyz, c0
mul_sat r3.w, r3, c10.x
mul_pp r3.xyz, r3, c0
mul r3.xyz, r3.w, r3
add r3.w, -r3, c26.y
add r2.w, -r2, c26.y
mul_sat r1.w, r4, r1
mul_pp r1.xyz, c14, r1
mul r1.xyz, r1, r1.w
mul r5.xyz, r5, r5.w
mad r3.xyz, r3.w, c0, r3
mul r6.xyz, r7, c21
mad r3.xyz, r2.w, r3, r6
dp3_pp r2.w, r2, r2
rsq_pp r1.w, r2.w
mul_pp r2.xyz, r1.w, r2
dp3_pp r1.w, r9, r2
mul_pp r4.xyz, r4, c12
mul_pp r3.xyz, r4, r3
mad r1.xyz, r3, r8.x, r1
max_pp r3.x, r1.w, c24
mov_pp r2.x, c17
mul_pp r3.y, c28.w, r2.x
pow r2, r3.x, r3.y
texld r1.w, v0, s5
mul r1.xyz, r5.w, r1
add_sat r1.w, r1, c15.x
mul_pp r3.xyz, r1.w, r1
add_pp r1.x, -r1.w, c26.y
mov r1.w, r2.x
mov_pp r2.xyz, c0
mul_sat r0.w, r0, r1
mul_pp r2.xyz, c1, r2
mul r2.xyz, r2, r0.w
max_pp r0.w, r6, c24.x
mul_pp r0.xyz, r0, c0
mad r0.xyz, r0, r0.w, r2
mul r2.xyz, r5.w, r0
texld r0.w, v0, s1
add_sat r0.x, r0.w, c18
mul_pp r2.xyz, r0.x, r2
mad_pp r1.xyz, r1.x, r5, r3
add_pp r0.x, -r0, c26.y
mad_pp oC0.xyz, r0.x, r1, r2
mov_pp oC0.w, c24.x
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_LightShadowData]
Vector 3 [_Color3]
Float 4 [_Shininess3]
Vector 5 [_SpecColor3]
Float 6 [_Layer1Thickness]
Float 7 [_Layer2Thickness]
Float 8 [_GVar]
Float 9 [_ExitColorMultiplier]
Float 10 [_ExitColorRadius]
Float 11 [_SpecSmoothing]
Vector 12 [_Color2]
Float 13 [_Shininess2]
Vector 14 [_SpecColor2]
Float 15 [_BlendAdjust2]
Vector 16 [_Color]
Float 17 [_Shininess]
Float 18 [_BlendAdjust1]
Float 19 [_DDXP]
Float 20 [_DDXM]
Vector 21 [_SSSC]
SetTexture 0 [_MainTex3] 2D
SetTexture 1 [_ScatterMap] 2D
SetTexture 2 [_MainTex] 2D
SetTexture 3 [_BumpMap] 2D
SetTexture 4 [_MainTex2] 2D
SetTexture 5 [_ScatterMap2] 2D
SetTexture 6 [_LightTexture0] 2D
SetTexture 7 [_LightTextureB0] 2D
SetTexture 8 [_ShadowMapTexture] 2D
SetTexture 9 [_BumpMap3] 2D
SetTexture 10 [_ExitColorMap] 2D
SetTexture 11 [_BumpMap2] 2D
"ps_3_0
; 388 ALU, 13 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
dcl_2d s7
dcl_2d s8
dcl_2d s9
dcl_2d s10
dcl_2d s11
def c22, 2.00000000, -1.00000000, 0.11705996, 0.50000000
def c23, 6.28318501, -3.14159298, -0.73550957, 0.73550957
def c24, 0.00000000, -1.00000000, 0.15799320, 0.50000000
def c25, -0.99270076, 0.99270076, 2.71828198, 1.00000000
def c26, 0.39894229, 1.00000000, 0.00000000, -0.21211439
def c27, -0.01872930, 0.07426100, 1.57072902, 3.14159298
def c28, 0.15915491, 0.50000000, 3.14159274, 5.00000000
def c29, 128.00000000, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3
dcl_texcoord4 v4
texld r5.yw, v0.zwzw, s9
dp3_pp r0.x, v1, v1
rsq_pp r0.x, r0.x
mul_pp r2.xyz, r0.x, v1
mul r0.x, r2.y, r2.y
mad r0.x, r2, r2, r0
mad r0.x, r2.z, r2.z, r0
rsq r1.w, r0.x
mul r1.x, r1.w, -r2.z
mad r0.x, r1, c22.z, c22.w
frc r0.x, r0
mad r1.y, r0.x, c23.x, c23
sincos r0.xy, r1.y
mad r0.z, r1.x, c23, r0.x
dp3 r0.y, r2, r2
mad_pp r6.xy, r5.wyzw, c22.x, c22.y
mul r1.xy, r0.z, c24
rsq r0.x, r0.y
mul r0.xyz, r0.x, r2
mad r3.xyz, r0, c23.w, r1.xxyw
mul r0.x, r3.y, r3.y
mad r0.x, r3, r3, r0
mad r0.x, r3.z, r3.z, r0
rsq r0.x, r0.x
mul r1.x, r0, -r3.z
mad r0.x, r1, c24.z, c24.w
frc r0.x, r0
mad r1.y, r0.x, c23.x, c23
sincos r0.xy, r1.y
mad r0.z, r1.x, c25.x, r0.x
dp3 r0.y, r3, r3
rsq r0.x, r0.y
mul r7.xyz, r0.x, r3
add r3.xyz, -r3, r2
mul r0.zw, r0.z, c24.xyxy
mad r0.xyz, r7, c25.y, r0.zzww
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, r0
mad r4.xyz, -r7, c6.x, r2
mad r9.xyz, -r1, c7.x, r4
dp3 r0.w, r9, r9
rsq r0.w, r0.w
mul r4.xyz, r0.w, r9
dp3_pp r0.w, v2, v2
rsq_pp r0.w, r0.w
mul_pp r1.xyz, r0.w, v2
add r5.xyz, r4, r1
mul_pp r0.w, r6.y, r6.y
mad_pp r0.w, -r6.x, r6.x, -r0
dp3 r2.w, r5, r5
rsq r2.w, r2.w
add_pp r0.w, r0, c25
rsq_pp r0.w, r0.w
mul r3.y, r3, r3
mad r3.y, r3.x, r3.x, r3
add r0.xyz, -r0, r2
rcp_pp r6.z, r0.w
mul r8.xyz, r2.w, r5
dp3 r6.w, r6, r8
abs r0.w, r6
add r3.w, -r0, c25
mad r2.w, r0, c27.x, c27.y
mad r2.w, r2, r0, c26
rsq r3.w, r3.w
mad r0.w, r2, r0, c27.z
rcp r3.w, r3.w
mul r2.w, r0, r3
cmp r0.w, r6, c26.z, c26.y
mul r3.w, r0, r2
mad r3.w, -r3, c22.x, r2
mul r2.w, r0.y, r0.y
dp3 r0.y, r6, r4
mad r0.x, r0, r0, r2.w
max r2.w, r0.y, c24.x
mad r0.y, r0.z, r0.z, r0.x
mov r0.x, c7
add r0.z, -c6.x, -r0.x
rsq r0.y, r0.y
rcp r0.x, r0.y
add r0.y, r0.z, c22.x
mul r0.x, r0, c8
mul r0.y, r0.x, r0
mul r0.x, r2.w, r2.w
mul r0.x, r0, r0.y
mad r0.z, r0.w, c27.w, r3.w
mul r0.x, r0, r0.y
mad r0.y, r0.z, c28.x, c28
mul r3.w, r0.x, c22
frc r4.x, r0.y
pow r0, c25.z, -r3.w
mad r0.y, r4.x, c23.x, c23
sincos r5.xy, r0.y
mad r5.w, -r0.x, c26.x, c26.y
mul r3.w, r2, r5
mul r0.x, r9.y, r9.y
mad r0.x, r9, r9, r0
mul r8.w, r5.x, r5.x
mad r4.x, r9.z, r9.z, r0
add_sat r2.w, -r3, c25
pow r0, r2.w, c19.x
rsq r0.y, r4.x
add r0.zw, r9.xyxy, -r2.xyxy
rcp r0.y, r0.y
mul r0.y, r1.w, r0
mul r0.zw, r0, c7.x
mul r0.zw, r0, r0.y
mov r2.w, r0.x
mad r0.xy, -r0.zwzw, c9.x, v0
texld r4, r0, s10
mov r0.x, c2
add r0.w, c25, -r0.x
rcp r0.y, v3.w
mad r10.xy, v3, r0.y, c22.w
mul r0.z, r2.w, c20.x
texldp r0.x, v4, s8
mad r2.w, r0.x, r0, c2.x
texld r0.w, r10, s6
dp3 r0.x, v3, v3
cmp r0.y, -v3.z, c26.z, c26
mul_pp r0.y, r0, r0.w
texld r0.x, r0.x, s7
mul_pp r0.x, r0.y, r0
mul_pp r2.w, r0.x, r2
mul r0.x, r0.z, r4.w
dp3 r4.w, r9, r2
mul_sat r0.w, r0.x, r2
mul r0.xyz, r0.w, r4
mul r10.xyz, r7, c6.x
mul r7.w, c11.x, c11.x
mad r3.y, r3.z, r3.z, r3
mul_sat r4.w, r4, c10.x
mul_pp r4.xyz, r4, c0
mul r4.xyz, r4.w, r4
add r4.w, -r4, c25
mad r4.xyz, r4.w, c0, r4
add r0.w, -r0, c25
mul r0.xyz, r0, c21
mad r0.xyz, r0.w, r4, r0
texld r4, v0, s0
mul_pp r4.xyz, r4, c3
mul_pp r5.xyz, r4, r0
mul r0.w, r8, c11.x
mul r0.w, r0, c11.x
add r0.x, -r8.w, c25.w
rcp r0.y, r0.w
mul r4.x, r0, r0.y
pow r0, c25.z, -r4.x
mul r0.y, r8.w, r7.w
mul r0.y, r8.w, r0
mov r4.y, r0.x
mul r0.x, r0.y, c28.z
add r4.z, -r6.w, c25.w
rcp r4.x, r0.x
pow r0, r4.z, c28.w
mov_pp r0.y, c4.x
add_pp r0.y, c25.w, -r0
mad r0.y, r0.x, c4.x, r0
mul r0.x, r4.y, r4
mul r0.x, r0, r0.y
dp3_pp r0.y, r6, r1
dp3_pp r0.w, r8, r1
mul r0.x, r4.w, r0
rcp r0.z, r0.y
mul_sat r9.x, r0, r0.z
mul r0.x, r6.w, r0.y
rcp r0.z, r0.w
mul r0.x, r0, r0.z
dp3_pp r0.y, r6, r2
mul r9.y, r0.x, c22.x
mul r0.x, r6.w, r0.y
mul r0.x, r0.z, r0
mul r9.z, r0.x, c22.x
add r6.xyz, r2, -r10
texld r0.yw, v0.zwzw, s11
mad_pp r4.xy, r0.wyzw, c22.x, c22.y
dp3 r0.x, r6, r6
rsq r0.x, r0.x
mul r7.xyz, r0.x, r6
add r0.xyz, r1, r7
dp3 r4.z, r0, r0
mul_pp r0.w, r4.y, r4.y
mad_pp r0.w, -r4.x, r4.x, -r0
rsq r4.z, r4.z
add_pp r0.w, r0, c25
mul r8.xyz, r4.z, r0
rsq_pp r0.w, r0.w
rcp_pp r4.z, r0.w
dp3 r8.w, r4, r8
abs r0.x, r8.w
dp3 r3.x, r4, r7
min_sat r9.y, r9, r9.z
max r7.x, r3, c24
rsq r3.x, r3.y
rcp r3.z, r3.x
dp3_pp r8.x, r1, r8
add r0.z, -r0.x, c25.w
mad r0.y, r0.x, c27.x, c27
mad r0.y, r0, r0.x, c26.w
rsq r0.z, r0.z
mov r3.x, c6
mad r0.x, r0.y, r0, c27.z
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r9.z, r8.w, c26, c26.y
mul r0.z, r9, r0.y
mov_pp r0.x, c4
mul r3.y, r7.x, r7.x
max r6.w, r6, c24.x
mad r10.z, -r0, c22.x, r0.y
mul_pp r9.w, c29.x, r0.x
pow r0, r6.w, r9.w
mad r0.y, r9.z, c27.w, r10.z
mul r0.x, r4.w, r0
mad r0.y, r0, c28.x, c28
frc r0.y, r0
mad r6.w, r0.y, c23.x, c23.y
mul r4.w, r0.x, c22
sincos r0.xy, r6.w
mad r0.y, r9.x, r9, r4.w
mul r4.w, r0.x, r0.x
mul_sat r0.w, r5, r0.y
mov_pp r0.xyz, c0
mul_pp r0.xyz, c5, r0
mul r0.xyz, r0, r0.w
mad r5.xyz, r5, r3.w, r0
mul r5.w, r4, c11.x
mul r0.w, r5, c11.x
mul_pp r5.w, r2, c22.x
add r0.x, -r4.w, c25.w
rcp r0.y, r0.w
mul r3.w, r0.x, r0.y
pow r0, c25.z, -r3.w
mul r0.y, r7.w, r4.w
mov r6.w, r0.x
mul r0.x, r4.w, r0.y
mul r3.w, r0.x, c28.z
add r4.w, -r8, c25
pow r0, r4.w, c28.w
rcp r0.y, r3.w
mul r0.z, r6.w, r0.y
mov r3.w, r0.x
texld r0.yw, v0.zwzw, s3
mad_pp r9.xy, r0.wyzw, c22.x, c22.y
mul_pp r0.y, r9, r9
mad_pp r4.w, -r9.x, r9.x, -r0.y
add_pp r4.w, r4, c25
rsq_pp r6.w, r4.w
dp3_pp r4.w, r1, r4
rcp_pp r9.z, r6.w
mov_pp r0.x, c13
add_pp r0.x, c25.w, -r0
mad r0.x, r3.w, c13, r0
mul r3.w, r0.z, r0.x
texld r0, v0, s2
mul_pp r0.xyz, r0, c16
mul r3.w, r3, r0
rcp r4.w, r4.w
mul_sat r7.w, r3, r4
dp3_pp r6.w, r2, r9
dp3_pp r4.w, r1, r9
mul r3.w, r8, r6
rcp r8.x, r8.x
mul r4.w, r8, r4
mul r4.w, r4, r8.x
mul r8.x, r8, r3.w
mul r3.w, r4, c22.x
mul r4.w, r8.x, c22.x
min_sat r8.y, r3.w, r4.w
mov_pp r3.w, c13.x
mul_pp r4.z, c29.x, r3.w
max r4.w, r8, c24.x
mul r3.z, r3, c8.x
add r3.x, c25.w, -r3
mul r4.x, r3.z, r3
mul r4.y, r3, r4.x
pow r3, r4.w, r4.z
mul r3.y, r4, r4.x
mul r4.x, r3.y, c22.w
mov r7.y, r3.x
pow r3, c25.z, -r4.x
texld r4, v0, s4
mul r7.z, r4.w, r7.y
mad r4.w, -r3.x, c26.x, c26.y
mul r8.x, r7, r4.w
mul r3.y, r6, r6
mad r3.y, r6.x, r6.x, r3
mad r3.x, r6.z, r6.z, r3.y
rsq r3.x, r3.x
rcp r7.y, r3.x
add_sat r7.x, -r8, c25.w
pow r3, r7.x, c19.x
mul r1.w, r1, r7.y
mul r3.zw, -r10.xyxy, c6.x
mul r3.zw, r3, r1.w
mov r1.w, r3.x
mad r7.xy, -r3.zwzw, c9.x, v0
texld r3, r7, s10
mul r1.w, r1, c20.x
mul r1.w, r1, r3
mul_sat r2.w, r2, r1
mul r3.w, r7.z, c22
mul r7.xyz, r2.w, r3
mad r1.w, r7, r8.y, r3
dp3 r3.w, r2, r6
add_pp r2.xyz, r2, r1
mov_pp r1.xyz, c0
mul_sat r3.w, r3, c10.x
mul_pp r3.xyz, r3, c0
mul r3.xyz, r3.w, r3
add r3.w, -r3, c25
add r2.w, -r2, c25
mul_sat r1.w, r4, r1
mul_pp r1.xyz, c14, r1
mul r1.xyz, r1, r1.w
mul r5.xyz, r5, r5.w
mad r3.xyz, r3.w, c0, r3
mul r6.xyz, r7, c21
mad r3.xyz, r2.w, r3, r6
dp3_pp r2.w, r2, r2
rsq_pp r1.w, r2.w
mul_pp r2.xyz, r1.w, r2
dp3_pp r1.w, r9, r2
mul_pp r4.xyz, r4, c12
mul_pp r3.xyz, r4, r3
mad r1.xyz, r3, r8.x, r1
max_pp r3.x, r1.w, c24
mov_pp r2.x, c17
mul_pp r3.y, c29.x, r2.x
pow r2, r3.x, r3.y
texld r1.w, v0, s5
mul r1.xyz, r5.w, r1
add_sat r1.w, r1, c15.x
mul_pp r3.xyz, r1.w, r1
add_pp r1.x, -r1.w, c25.w
mov r1.w, r2.x
mov_pp r2.xyz, c0
mul_sat r0.w, r0, r1
mul_pp r2.xyz, c1, r2
mul r2.xyz, r2, r0.w
max_pp r0.w, r6, c24.x
mul_pp r0.xyz, r0, c0
mad r0.xyz, r0, r0.w, r2
mul r2.xyz, r5.w, r0
texld r0.w, v0, s1
add_sat r0.x, r0.w, c18
mul_pp r2.xyz, r0.x, r2
mad_pp r1.xyz, r1.x, r5, r3
add_pp r0.x, -r0, c25.w
mad_pp oC0.xyz, r0.x, r1, r2
mov_pp oC0.w, c24.x
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color3]
Float 3 [_Shininess3]
Vector 4 [_SpecColor3]
Float 5 [_Layer1Thickness]
Float 6 [_Layer2Thickness]
Float 7 [_GVar]
Float 8 [_ExitColorMultiplier]
Float 9 [_ExitColorRadius]
Float 10 [_SpecSmoothing]
Vector 11 [_Color2]
Float 12 [_Shininess2]
Vector 13 [_SpecColor2]
Float 14 [_BlendAdjust2]
Vector 15 [_Color]
Float 16 [_Shininess]
Float 17 [_BlendAdjust1]
Float 18 [_DDXP]
Float 19 [_DDXM]
Vector 20 [_SSSC]
SetTexture 0 [_MainTex3] 2D
SetTexture 1 [_ScatterMap] 2D
SetTexture 2 [_MainTex] 2D
SetTexture 3 [_BumpMap] 2D
SetTexture 4 [_MainTex2] 2D
SetTexture 5 [_ScatterMap2] 2D
SetTexture 6 [_ShadowMapTexture] 2D
SetTexture 7 [_BumpMap3] 2D
SetTexture 8 [_ExitColorMap] 2D
SetTexture 9 [_BumpMap2] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 318 ALU, 11 TEX
PARAM c[26] = { program.local[0..20],
		{ 0, 1, 2, 0.73550957 },
		{ -0.73550957, 0, -1, 0.99270076 },
		{ -0.99270076, 2.718282, 0.5, 0.39894229 },
		{ 3.141593, -0.018729299, 0.074261002, 0.21211439 },
		{ 1.570729, 3.1415927, 5, 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEMP R7;
TEMP R8;
MUL R0.x, fragment.texcoord[1].y, fragment.texcoord[1].y;
MAD R0.x, fragment.texcoord[1], fragment.texcoord[1], R0;
MAD R0.x, fragment.texcoord[1].z, fragment.texcoord[1].z, R0;
RSQ R2.w, R0.x;
MUL R0.y, R2.w, -fragment.texcoord[1].z;
MUL R0.x, R0.y, c[21].w;
COS R0.z, R0.x;
MAD R0.y, R0, c[22].x, R0.z;
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
MUL R1.xy, R0.y, c[22].yzzw;
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, fragment.texcoord[1];
MAD R2.xyz, R0, c[21].w, R1.xxyw;
MUL R0.x, R2.y, R2.y;
MAD R0.x, R2, R2, R0;
MAD R0.x, R2.z, R2.z, R0;
RSQ R0.x, R0.x;
MUL R0.y, R0.x, -R2.z;
MUL R0.x, R0.y, c[22].w;
COS R0.z, R0.x;
MAD R0.y, R0, c[23].x, R0.z;
DP3 R0.x, R2, R2;
RSQ R0.x, R0.x;
MUL R3.xyz, R0.x, R2;
ADD R2.xyz, -R2, fragment.texcoord[1];
MUL R0.zw, R0.y, c[22].xyyz;
MAD R6.xyz, R3, c[22].w, R0.zzww;
DP3 R0.x, R6, R6;
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, R6;
ADD R6.xyz, -R6, fragment.texcoord[1];
MAD R1.xyz, -R3, c[5].x, fragment.texcoord[1];
MAD R4.xyz, -R0, c[6].x, R1;
DP3 R0.x, R4, R4;
RSQ R0.x, R0.x;
MUL R7.xyz, R0.x, R4;
DP3 R0.x, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.z, R0.x;
MUL R5.xyz, R0.z, fragment.texcoord[2];
TEX R0.yw, fragment.texcoord[0].zwzw, texture[7], 2D;
MAD R0.xy, R0.wyzw, c[21].z, -c[21].y;
ADD R1.xyz, R7, R5;
DP3 R0.w, R1, R1;
MUL R0.z, R0.y, R0.y;
MAD R0.z, -R0.x, R0.x, -R0;
RSQ R0.w, R0.w;
ADD R0.z, R0, c[21].y;
RSQ R0.z, R0.z;
RCP R0.z, R0.z;
MUL R8.xyz, R0.w, R1;
DP3 R6.w, R0, R8;
ABS R0.w, R6;
DP3 R5.w, R0, R5;
DP3 R8.w, R0, fragment.texcoord[1];
DP3 R0.x, R0, R7;
RCP R7.w, R5.w;
MAX R0.x, R0, c[21];
ADD R1.y, -R0.w, c[21];
MAD R1.x, R0.w, c[24].y, c[24].z;
MAD R1.x, R1, R0.w, -c[24].w;
MUL R6.y, R6, R6;
MAD R0.y, R6.x, R6.x, R6;
MAD R0.y, R6.z, R6.z, R0;
MOV R6.x, c[5];
ADD R6.y, -R6.x, -c[6].x;
RSQ R1.y, R1.y;
RSQ R0.y, R0.y;
RCP R0.y, R0.y;
MUL R6.x, R0.y, c[7];
ADD R6.y, R6, c[21].z;
MUL R2.y, R2, R2;
MAD R2.y, R2.x, R2.x, R2;
MAD R2.y, R2.z, R2.z, R2;
RSQ R2.y, R2.y;
MOV R2.z, c[21].y;
RCP R2.y, R2.y;
MUL R6.x, R6, R6.y;
MOV R0.y, c[25].w;
MUL R0.z, R0.x, R0.x;
MUL R0.z, R0, R6.x;
MUL R0.z, R0, R6.x;
MUL R0.z, R0, c[23];
POW R0.z, c[23].y, -R0.z;
MAD R0.w, R1.x, R0, c[25].x;
RCP R1.y, R1.y;
MUL R1.x, R0.w, R1.y;
SLT R0.w, R6, c[21].x;
MUL R1.y, R0.w, R1.x;
MAD R1.x, -R1.y, c[21].z, R1;
MAD R0.w, R0, c[24].x, R1.x;
COS R1.x, R0.w;
MUL R1.x, R1, R1;
MUL R0.w, c[10].x, c[10].x;
MUL R1.z, R1.x, R0.w;
MUL R1.y, R1.x, c[10].x;
MUL R1.z, R1.x, R1;
MUL R1.y, R1, c[10].x;
MUL R1.z, R1, c[25].y;
RCP R1.y, R1.y;
ADD R1.x, -R1, c[21].y;
MUL R1.x, R1, R1.y;
RCP R1.y, R1.z;
MOV R3.w, c[21].y;
ADD R1.z, R3.w, -c[3].x;
POW R1.x, c[23].y, -R1.x;
MUL R1.x, R1, R1.y;
ADD R1.y, -R6.w, c[21];
POW R1.y, R1.y, c[25].z;
MAD R1.y, R1, c[3].x, R1.z;
MUL R4.w, R1.x, R1.y;
TEX R1, fragment.texcoord[0], texture[0], 2D;
MUL R4.w, R1, R4;
MUL_SAT R4.w, R4, R7;
DP3 R7.w, R8, R5;
RCP R7.w, R7.w;
MUL R5.w, R6, R5;
MUL R8.x, R6.w, R8.w;
MUL R5.w, R5, R7;
MUL R8.x, R7.w, R8;
MUL R7.w, R8.x, c[21].z;
MUL R5.w, R5, c[21].z;
MIN_SAT R5.w, R5, R7;
MUL R8.xyz, R3, c[5].x;
MAX R6.w, R6, c[21].x;
MUL R6.y, R0, c[3].x;
POW R6.y, R6.w, R6.y;
MUL R1.w, R1, R6.y;
MUL R7.x, R1.w, c[23].z;
MAD R4.w, R4, R5, R7.x;
MUL R1.w, R4.y, R4.y;
MAD R6.x, R4, R4, R1.w;
MUL R0.z, -R0, c[23].w;
ADD R1.w, R0.z, c[21].y;
MUL R0.z, R0.x, R1.w;
MAD R6.x, R4.z, R4.z, R6;
RSQ R6.x, R6.x;
RCP R6.z, R6.x;
ADD_SAT R0.x, -R0.z, c[21].y;
ADD R6.xy, R4, -fragment.texcoord[1];
POW R0.x, R0.x, c[18].x;
MUL R7.y, R0.x, c[19].x;
DP3 R5.w, R4, fragment.texcoord[1];
TXP R0.x, fragment.texcoord[3], texture[6], 2D;
MUL_SAT R1.w, R1, R4;
MUL R6.z, R2.w, R6;
MUL R6.xy, R6, c[6].x;
MUL R6.xy, R6, R6.z;
MAD R6.xy, -R6, c[8].x, fragment.texcoord[0];
TEX R6, R6, texture[8], 2D;
MUL R6.w, R7.y, R6;
MUL_SAT R6.w, R6, R0.x;
MUL R7.xyz, R6.w, R6;
MUL R4.xyz, R6, c[0];
MUL_SAT R5.w, R5, c[9].x;
MUL R4.xyz, R5.w, R4;
ADD R5.w, -R5, c[21].y;
MAD R4.xyz, R5.w, c[0], R4;
MUL R6.xyz, R7, c[20];
ADD R5.w, -R6, c[21].y;
MAD R4.xyz, R5.w, R4, R6;
MUL R1.xyz, R1, c[2];
MUL R1.xyz, R1, R4;
MOV R4.xyz, c[4];
MUL R3.xyz, R4, c[0];
MUL R3.xyz, R3, R1.w;
ADD R4.xyz, fragment.texcoord[1], -R8;
MAD R1.xyz, R1, R0.z, R3;
DP3 R0.z, R4, R4;
TEX R6.yw, fragment.texcoord[0].zwzw, texture[9], 2D;
RSQ R0.z, R0.z;
MAD R3.xy, R6.wyzw, c[21].z, -c[21].y;
MUL R7.xyz, R0.z, R4;
ADD R6.xyz, R5, R7;
MUL R0.z, R3.y, R3.y;
MAD R0.z, -R3.x, R3.x, -R0;
DP3 R1.w, R6, R6;
RSQ R1.w, R1.w;
ADD R0.z, R0, c[21].y;
RSQ R0.z, R0.z;
RCP R3.z, R0.z;
DP3 R2.x, R3, R7;
MUL R0.z, R0.x, c[21];
MUL R6.xyz, R1.w, R6;
DP3 R1.w, R3, R6;
ABS R4.w, R1;
MAD R5.w, R4, c[24].y, c[24].z;
ADD R6.w, -R4, c[21].y;
MAD R5.w, R5, R4, -c[24];
SLT R7.w, R1, c[21].x;
MAX R2.x, R2, c[21];
RSQ R6.w, R6.w;
MAD R4.w, R5, R4, c[25].x;
RCP R5.w, R6.w;
MUL R4.w, R4, R5;
MUL R7.x, R7.w, R4.w;
MAD R4.w, -R7.x, c[21].z, R4;
MUL R2.y, R2, c[7].x;
ADD R2.z, R2, -c[5].x;
MUL R2.z, R2.y, R2;
MUL R2.y, R2.x, R2.x;
MUL R2.y, R2, R2.z;
MUL R2.y, R2, R2.z;
MUL R2.z, R4.y, R4.y;
MAD R2.z, R4.x, R4.x, R2;
DP3 R4.x, fragment.texcoord[1], R4;
MAD R2.z, R4, R4, R2;
MUL R2.y, R2, c[23].z;
POW R2.y, c[23].y, -R2.y;
MUL R2.y, -R2, c[23].w;
ADD R5.w, R2.y, c[21].y;
RSQ R2.z, R2.z;
RCP R2.y, R2.z;
MUL R2.z, R2.w, R2.y;
MUL R6.w, R2.x, R5;
MUL R2.xy, -R8, c[5].x;
MUL R2.xy, R2, R2.z;
ADD_SAT R2.z, -R6.w, c[21].y;
POW R7.y, R2.z, c[18].x;
MAD R2.xy, -R2, c[8].x, fragment.texcoord[0];
TEX R2, R2, texture[8], 2D;
MUL R7.y, R7, c[19].x;
MUL R2.w, R7.y, R2;
MUL_SAT R2.w, R0.x, R2;
MUL R7.xyz, R2.w, R2;
MAD R0.x, R7.w, c[24], R4.w;
COS R0.x, R0.x;
MUL R0.x, R0, R0;
MUL_SAT R4.x, R4, c[9];
MUL R2.xyz, R2, c[0];
MUL R2.xyz, R4.x, R2;
ADD R4.x, -R4, c[21].y;
MAD R2.xyz, R4.x, c[0], R2;
MUL R4.xyz, R7, c[20];
ADD R2.w, -R2, c[21].y;
MAD R4.xyz, R2.w, R2, R4;
TEX R2, fragment.texcoord[0], texture[4], 2D;
MUL R2.xyz, R2, c[11];
MUL R2.xyz, R2, R4;
MUL R4.x, R0.w, R0;
MUL R0.w, R0.x, c[10].x;
MUL R4.x, R0, R4;
TEX R4.yw, fragment.texcoord[0].zwzw, texture[3], 2D;
MUL R0.w, R0, c[10].x;
MAD R7.xy, R4.wyzw, c[21].z, -c[21].y;
MUL R4.x, R4, c[25].y;
RCP R0.w, R0.w;
ADD R0.x, -R0, c[21].y;
MUL R0.x, R0, R0.w;
RCP R0.w, R4.x;
POW R0.x, c[23].y, -R0.x;
MUL R0.x, R0, R0.w;
ADD R0.w, -R1, c[21].y;
TEX R4, fragment.texcoord[0], texture[2], 2D;
ADD R3.w, R3, -c[12].x;
POW R0.w, R0.w, c[25].z;
MAD R0.w, R0, c[12].x, R3;
MUL R0.x, R0, R0.w;
MUL R0.w, R7.y, R7.y;
MAD R3.w, -R7.x, R7.x, -R0;
DP3 R0.w, R5, R3;
ADD R3.x, R3.w, c[21].y;
RSQ R3.x, R3.x;
RCP R7.z, R3.x;
DP3 R3.x, R5, R6;
RCP R3.x, R3.x;
MUL R0.x, R0, R4.w;
RCP R0.w, R0.w;
MUL_SAT R0.w, R0.x, R0;
DP3 R0.x, R5, R7;
MUL R0.x, R1.w, R0;
MUL R3.y, R0.x, R3.x;
DP3 R0.x, fragment.texcoord[1], R7;
MUL R3.z, R1.w, R0.x;
MUL R3.y, R3, c[21].z;
MUL R3.w, R0.y, c[12].x;
MAX R1.w, R1, c[21].x;
POW R3.w, R1.w, R3.w;
MUL R1.w, R3.x, R3.z;
MUL R2.w, R2, R3;
MUL R1.w, R1, c[21].z;
MIN_SAT R1.w, R3.y, R1;
MUL R2.w, R2, c[23].z;
MAD R0.w, R0, R1, R2;
MOV R3.xyz, c[13];
MUL_SAT R0.w, R5, R0;
MUL R3.xyz, R3, c[0];
MUL R3.xyz, R3, R0.w;
MAD R2.xyz, R2, R6.w, R3;
ADD R5.xyz, fragment.texcoord[1], R5;
DP3 R0.w, R5, R5;
RSQ R1.w, R0.w;
MUL R3.xyz, R1.w, R5;
DP3 R1.w, R7, R3;
MUL R2.w, R0.y, c[16].x;
MAX R0.y, R1.w, c[21].x;
TEX R0.w, fragment.texcoord[0], texture[5], 2D;
MUL R3.xyz, R4, c[15];
ADD_SAT R0.w, R0, c[14].x;
POW R1.w, R0.y, R2.w;
MUL R2.xyz, R0.z, R2;
MUL R2.xyz, R0.w, R2;
ADD R0.y, -R0.w, c[21];
MUL R1.xyz, R1, R0.z;
MAD R1.xyz, R0.y, R1, R2;
MOV R2.xyz, c[1];
MAX R0.x, R0, c[21];
MUL_SAT R0.y, R4.w, R1.w;
MUL R2.xyz, R2, c[0];
MUL R2.xyz, R2, R0.y;
MUL R3.xyz, R3, c[0];
MAD R2.xyz, R3, R0.x, R2;
TEX R0.w, fragment.texcoord[0], texture[1], 2D;
ADD_SAT R0.x, R0.w, c[17];
MUL R2.xyz, R0.z, R2;
MUL R2.xyz, R0.x, R2;
ADD R0.x, -R0, c[21].y;
MAD result.color.xyz, R0.x, R1, R2;
MOV result.color.w, c[21].x;
END
# 318 instructions, 9 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color3]
Float 3 [_Shininess3]
Vector 4 [_SpecColor3]
Float 5 [_Layer1Thickness]
Float 6 [_Layer2Thickness]
Float 7 [_GVar]
Float 8 [_ExitColorMultiplier]
Float 9 [_ExitColorRadius]
Float 10 [_SpecSmoothing]
Vector 11 [_Color2]
Float 12 [_Shininess2]
Vector 13 [_SpecColor2]
Float 14 [_BlendAdjust2]
Vector 15 [_Color]
Float 16 [_Shininess]
Float 17 [_BlendAdjust1]
Float 18 [_DDXP]
Float 19 [_DDXM]
Vector 20 [_SSSC]
SetTexture 0 [_MainTex3] 2D
SetTexture 1 [_ScatterMap] 2D
SetTexture 2 [_MainTex] 2D
SetTexture 3 [_BumpMap] 2D
SetTexture 4 [_MainTex2] 2D
SetTexture 5 [_ScatterMap2] 2D
SetTexture 6 [_ShadowMapTexture] 2D
SetTexture 7 [_BumpMap3] 2D
SetTexture 8 [_ExitColorMap] 2D
SetTexture 9 [_BumpMap2] 2D
"ps_3_0
; 375 ALU, 11 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
dcl_2d s7
dcl_2d s8
dcl_2d s9
def c21, 2.00000000, -1.00000000, 0.11705996, 0.50000000
def c22, 6.28318501, -3.14159298, -0.73550957, 0.73550957
def c23, 0.00000000, -1.00000000, 0.15799320, 0.50000000
def c24, -0.99270076, 0.99270076, 2.71828198, -0.21211439
def c25, 0.39894229, 1.00000000, 0.00000000, 1.57072902
def c26, -0.01872930, 0.07426100, 3.14159298, 3.14159274
def c27, 0.15915491, 0.50000000, 5.00000000, 128.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3
texld r3.yw, v0.zwzw, s7
mul r0.x, v1.y, v1.y
mad r0.x, v1, v1, r0
mad r0.x, v1.z, v1.z, r0
rsq r2.w, r0.x
mul r1.x, r2.w, -v1.z
mad r0.x, r1, c21.z, c21.w
frc r0.x, r0
mad r1.y, r0.x, c22.x, c22
sincos r0.xy, r1.y
mad r0.z, r1.x, c22, r0.x
dp3 r0.y, v1, v1
mad_pp r6.xy, r3.wyzw, c21.x, c21.y
mul r1.xy, r0.z, c23
rsq r0.x, r0.y
mul r0.xyz, r0.x, v1
mad r4.xyz, r0, c22.w, r1.xxyw
mul r0.x, r4.y, r4.y
mad r0.x, r4, r4, r0
mad r0.x, r4.z, r4.z, r0
rsq r0.x, r0.x
mul r1.x, r0, -r4.z
mad r0.x, r1, c23.z, c23.w
frc r0.x, r0
mad r1.y, r0.x, c22.x, c22
sincos r0.xy, r1.y
mad r0.z, r1.x, c24.x, r0.x
dp3 r0.y, r4, r4
rsq r0.x, r0.y
mul r7.xyz, r0.x, r4
mul r0.zw, r0.z, c23.xyxy
mad r0.xyz, r7, c24.y, r0.zzww
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r2.xyz, r0.w, r0
mad r1.xyz, -r7, c5.x, v1
mad r5.xyz, -r2, c6.x, r1
dp3 r0.w, r5, r5
rsq r0.w, r0.w
mul r1.xyz, r0.w, r5
dp3_pp r0.w, v2, v2
rsq_pp r0.w, r0.w
mul_pp r2.xyz, r0.w, v2
add r3.xyz, r1, r2
dp3 r1.w, r3, r3
mul_pp r0.w, r6.y, r6.y
mad_pp r0.w, -r6.x, r6.x, -r0
rsq r1.w, r1.w
add_pp r0.w, r0, c25.y
rsq_pp r0.w, r0.w
add r0.xyz, -r0, v1
add r4.xyz, -r4, v1
mul r8.xyz, r1.w, r3
rcp_pp r6.z, r0.w
dp3 r7.w, r6, r8
abs r0.w, r7
add r3.x, -r0.w, c25.y
mad r1.w, r0, c26.x, c26.y
mad r1.w, r1, r0, c24
rsq r3.x, r3.x
mad r0.w, r1, r0, c25
rcp r3.x, r3.x
mul r1.w, r0, r3.x
cmp r0.w, r7, c25.z, c25.y
mul r3.x, r0.w, r1.w
mad r1.w, -r3.x, c21.x, r1
mul r3.x, r0.y, r0.y
dp3 r0.y, r6, r1
mad r0.x, r0, r0, r3
max r1.x, r0.y, c23
mad r0.y, r0.z, r0.z, r0.x
mov r0.x, c6
add r0.z, -c5.x, -r0.x
rsq r0.y, r0.y
rcp r0.x, r0.y
add r0.y, r0.z, c21.x
mul r0.x, r0, c7
mul r0.y, r0.x, r0
mul r0.x, r1, r1
mul r0.x, r0, r0.y
mul r0.x, r0, r0.y
mad r0.z, r0.w, c26, r1.w
mad r0.y, r0.z, c27.x, c27
mul r1.y, r0.x, c21.w
frc r1.z, r0.y
pow r0, c24.z, -r1.y
mad r0.y, r1.z, c22.x, c22
mad r6.w, -r0.x, c25.x, c25.y
mul r4.w, r1.x, r6
sincos r3.xy, r0.y
mul r0.x, r5.y, r5.y
mad r0.x, r5, r5, r0
mad r1.y, r5.z, r5.z, r0.x
add_sat r1.x, -r4.w, c25.y
pow r0, r1.x, c18.x
rsq r0.y, r1.y
add r0.zw, r5.xyxy, -v1.xyxy
rcp r0.y, r0.y
mul r0.y, r2.w, r0
mul r0.zw, r0, c6.x
mul r0.zw, r0, r0.y
mov r1.x, r0
mad r0.xy, -r0.zwzw, c8.x, v0
mul r0.z, r1.x, c19.x
texld r1, r0, s8
dp3 r0.w, r5, v1
texldp r0.x, v3, s6
mul r0.y, r0.z, r1.w
mul_sat r0.z, r0.y, r0.x
mul r0.y, r3.x, r3.x
mul r3.xyz, r0.z, r1
mul r5.w, c10.x, c10.x
mul_sat r0.w, r0, c9.x
mul_pp r1.xyz, r1, c0
mul r1.xyz, r0.w, r1
add r0.w, -r0, c25.y
mad r1.xyz, r0.w, c0, r1
mul r3.xyz, r3, c20
add r0.z, -r0, c25.y
mad r1.xyz, r0.z, r1, r3
texld r3, v0, s0
mul_pp r3.xyz, r3, c2
mul r0.z, r0.y, c10.x
mul r0.z, r0, c10.x
rcp r0.w, r0.z
add r0.z, -r0.y, c25.y
mul r0.z, r0, r0.w
mul_pp r5.xyz, r3, r1
pow r1, c24.z, -r0.z
mul r0.z, r0.y, r5.w
mul r0.y, r0, r0.z
mul r0.y, r0, c26.w
mov r0.z, r1.x
add r0.w, -r7, c25.y
pow r1, r0.w, c27.z
rcp r0.y, r0.y
mul r0.y, r0.z, r0
mov_pp r0.w, c3.x
add_pp r0.w, c25.y, -r0
mad r0.w, r1.x, c3.x, r0
mul r0.y, r0, r0.w
dp3_pp r0.z, r6, r2
dp3_pp r1.x, r8, r2
mul r0.y, r3.w, r0
rcp r0.w, r0.z
mul_sat r8.w, r0.y, r0
mul r0.y, r7.w, r0.z
dp3_pp r0.z, r6, v1
mul r1.y, r7.w, r0.z
rcp r1.x, r1.x
mul r0.y, r0, r1.x
mul r1.x, r1, r1.y
texld r1.yw, v0.zwzw, s9
mul r9.x, r0.y, c21
mul r0.yzw, r7.xxyz, c5.x
add r6.xyz, v1, -r0.yzww
mul r9.y, r1.x, c21.x
dp3 r0.w, r6, r6
rsq r0.w, r0.w
mad_pp r3.xy, r1.wyzw, c21.x, c21.y
mul r7.xyz, r0.w, r6
add r1.xyz, r2, r7
dp3 r1.w, r1, r1
mul_pp r0.w, r3.y, r3.y
mad_pp r0.w, -r3.x, r3.x, -r0
rsq r1.w, r1.w
add_pp r0.w, r0, c25.y
rsq_pp r0.w, r0.w
mul r8.xyz, r1.w, r1
rcp_pp r3.z, r0.w
dp3 r0.w, r3, r8
abs r1.x, r0.w
min_sat r9.x, r9, r9.y
add r1.z, -r1.x, c25.y
mad r1.y, r1.x, c26.x, c26
mad r1.y, r1, r1.x, c24.w
dp3_pp r8.x, r2, r8
rsq r1.z, r1.z
cmp r9.y, r0.w, c25.z, c25
mad r1.x, r1.y, r1, c25.w
rcp r1.z, r1.z
mul r1.y, r1.x, r1.z
mul r1.z, r9.y, r1.y
mov_pp r1.x, c3
mul_pp r9.z, c27.w, r1.x
max r7.w, r7, c23.x
mad r9.w, -r1.z, c21.x, r1.y
pow r1, r7.w, r9.z
mad r1.y, r9, c26.z, r9.w
mul r1.x, r3.w, r1
mad r1.y, r1, c27.x, c27
frc r1.y, r1
mad r7.w, r1.y, c22.x, c22.y
mul r3.w, r1.x, c21
sincos r1.xy, r7.w
mad r1.y, r8.w, r9.x, r3.w
mul r3.w, r1.x, r1.x
mul_sat r1.w, r6, r1.y
mov_pp r1.xyz, c0
mul_pp r1.xyz, c4, r1
mul r1.xyz, r1, r1.w
mad r5.xyz, r5, r4.w, r1
mul r6.w, r3, c10.x
mul r1.w, r6, c10.x
mul_pp r6.w, r0.x, c21.x
add r1.x, -r3.w, c25.y
rcp r1.y, r1.w
mul r4.w, r1.x, r1.y
pow r1, c24.z, -r4.w
mul r1.y, r5.w, r3.w
mov r4.w, r1.x
mul r1.x, r3.w, r1.y
add r5.w, -r0, c25.y
mul r3.w, r1.x, c26
pow r1, r5.w, c27.z
rcp r1.y, r3.w
mul r1.z, r4.w, r1.y
mov r3.w, r1.x
texld r1.yw, v0.zwzw, s3
mad_pp r9.xy, r1.wyzw, c21.x, c21.y
mul_pp r1.y, r9, r9
mad_pp r4.w, -r9.x, r9.x, -r1.y
add_pp r4.w, r4, c25.y
rsq_pp r5.w, r4.w
dp3_pp r4.w, r2, r3
dp3 r3.x, r3, r7
rcp_pp r9.z, r5.w
mov_pp r1.x, c12
add_pp r1.x, c25.y, -r1
mad r1.x, r3.w, c12, r1
mul r3.w, r1.z, r1.x
texld r1, v0, s2
mul_pp r1.xyz, r1, c15
max r7.x, r3, c23
mul r3.w, r3, r1
rcp r4.w, r4.w
mul_sat r7.w, r3, r4
dp3_pp r4.w, r2, r9
dp3_pp r5.w, v1, r9
mul r3.w, r0, r5
mul r4.w, r0, r4
rcp r8.x, r8.x
mul r4.w, r4, r8.x
mul r8.x, r8, r3.w
mul r3.w, r4, c21.x
mul r4.w, r8.x, c21.x
min_sat r8.x, r3.w, r4.w
mul r3.w, r4.y, r4.y
mad r3.w, r4.x, r4.x, r3
mad r3.y, r4.z, r4.z, r3.w
rsq r3.x, r3.y
rcp r3.z, r3.x
mov_pp r3.w, c12.x
mov r3.x, c5
mul r3.y, r7.x, r7.x
mul_pp r4.z, c27.w, r3.w
max r0.w, r0, c23.x
mul r3.z, r3, c7.x
add r3.x, c25.y, -r3
mul r4.x, r3.z, r3
mul r4.y, r3, r4.x
pow r3, r0.w, r4.z
mul r0.w, r4.y, r4.x
mov r7.y, r3.x
texld r4, v0, s4
mul r0.w, r0, c21
pow r3, c24.z, -r0.w
mov r0.w, r3.x
mul r3.y, r6, r6
mad r3.x, r6, r6, r3.y
mad r3.x, r6.z, r6.z, r3
dp3 r6.x, v1, r6
mul r7.z, r4.w, r7.y
mad r0.w, -r0, c25.x, c25.y
mul r4.w, r7.x, r0
rsq r3.x, r3.x
rcp r7.y, r3.x
add_sat r7.x, -r4.w, c25.y
pow r3, r7.x, c18.x
mul r3.zw, -r0.xyyz, c5.x
mul r2.w, r2, r7.y
mul r3.zw, r3, r2.w
mov r0.y, r3.x
mul r0.z, r7, c21.w
mad r2.w, r7, r8.x, r0.z
mul_sat r0.w, r0, r2
mad r7.xy, -r3.zwzw, c8.x, v0
texld r3, r7, s8
mul r0.y, r0, c19.x
mul r0.y, r0, r3.w
mul_sat r3.w, r0.x, r0.y
mul r0.xyz, r3.w, r3
mul_sat r6.x, r6, c9
mul_pp r3.xyz, r3, c0
mul r3.xyz, r6.x, r3
add r6.x, -r6, c25.y
mad r3.xyz, r6.x, c0, r3
add_pp r2.xyz, v1, r2
mov_pp r2.w, c16.x
mul r5.xyz, r5, r6.w
mul r0.xyz, r0, c20
add r3.w, -r3, c25.y
mad r0.xyz, r3.w, r3, r0
mul_pp r3.xyz, r4, c11
mul_pp r0.xyz, r3, r0
mov_pp r3.xyz, c0
mul_pp r3.xyz, c13, r3
mul r3.xyz, r3, r0.w
mad r0.xyz, r0, r4.w, r3
dp3_pp r0.w, r2, r2
rsq_pp r0.w, r0.w
mul_pp r2.xyz, r0.w, r2
dp3_pp r0.w, r9, r2
mul r0.xyz, r6.w, r0
mul_pp r3.x, c27.w, r2.w
max_pp r0.w, r0, c23.x
pow r2, r0.w, r3.x
texld r0.w, v0, s5
add_sat r0.w, r0, c14.x
mul_pp r3.xyz, r0.w, r0
add_pp r0.x, -r0.w, c25.y
mul_sat r0.w, r1, r2.x
mov_pp r2.xyz, c0
mul_pp r2.xyz, c1, r2
mul r2.xyz, r2, r0.w
max_pp r0.w, r5, c23.x
mul_pp r1.xyz, r1, c0
mad r1.xyz, r1, r0.w, r2
texld r0.w, v0, s1
add_sat r0.w, r0, c17.x
mul r1.xyz, r6.w, r1
mul_pp r1.xyz, r0.w, r1
mad_pp r0.xyz, r0.x, r5, r3
add_pp r0.w, -r0, c25.y
mad_pp oC0.xyz, r0.w, r0, r1
mov_pp oC0.w, c23.x
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color3]
Float 3 [_Shininess3]
Vector 4 [_SpecColor3]
Float 5 [_Layer1Thickness]
Float 6 [_Layer2Thickness]
Float 7 [_GVar]
Float 8 [_ExitColorMultiplier]
Float 9 [_ExitColorRadius]
Float 10 [_SpecSmoothing]
Vector 11 [_Color2]
Float 12 [_Shininess2]
Vector 13 [_SpecColor2]
Float 14 [_BlendAdjust2]
Vector 15 [_Color]
Float 16 [_Shininess]
Float 17 [_BlendAdjust1]
Float 18 [_DDXP]
Float 19 [_DDXM]
Vector 20 [_SSSC]
SetTexture 0 [_MainTex3] 2D
SetTexture 1 [_ScatterMap] 2D
SetTexture 2 [_MainTex] 2D
SetTexture 3 [_BumpMap] 2D
SetTexture 4 [_MainTex2] 2D
SetTexture 5 [_ScatterMap2] 2D
SetTexture 6 [_ShadowMapTexture] 2D
SetTexture 7 [_LightTexture0] 2D
SetTexture 8 [_BumpMap3] 2D
SetTexture 9 [_ExitColorMap] 2D
SetTexture 10 [_BumpMap2] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 320 ALU, 12 TEX
PARAM c[26] = { program.local[0..20],
		{ 0, 1, 2, 0.73550957 },
		{ -0.73550957, 0, -1, 0.99270076 },
		{ -0.99270076, 2.718282, 0.5, 0.39894229 },
		{ 3.141593, -0.018729299, 0.074261002, 0.21211439 },
		{ 1.570729, 3.1415927, 5, 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEMP R7;
TEMP R8;
MUL R0.x, fragment.texcoord[1].y, fragment.texcoord[1].y;
MAD R0.x, fragment.texcoord[1], fragment.texcoord[1], R0;
MAD R0.x, fragment.texcoord[1].z, fragment.texcoord[1].z, R0;
RSQ R4.w, R0.x;
MUL R0.y, R4.w, -fragment.texcoord[1].z;
MUL R0.x, R0.y, c[21].w;
COS R0.z, R0.x;
MAD R0.y, R0, c[22].x, R0.z;
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
MUL R1.xy, R0.y, c[22].yzzw;
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, fragment.texcoord[1];
MAD R2.xyz, R0, c[21].w, R1.xxyw;
MUL R0.x, R2.y, R2.y;
MAD R0.x, R2, R2, R0;
MAD R0.x, R2.z, R2.z, R0;
RSQ R0.x, R0.x;
MUL R0.y, R0.x, -R2.z;
MUL R0.x, R0.y, c[22].w;
COS R0.z, R0.x;
MAD R0.y, R0, c[23].x, R0.z;
DP3 R0.x, R2, R2;
RSQ R0.x, R0.x;
MUL R3.xyz, R0.x, R2;
MUL R0.zw, R0.y, c[22].xyyz;
MAD R6.xyz, R3, c[22].w, R0.zzww;
DP3 R0.x, R6, R6;
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, R6;
MAD R1.xyz, -R3, c[5].x, fragment.texcoord[1];
MAD R4.xyz, -R0, c[6].x, R1;
DP3 R0.x, R4, R4;
RSQ R0.x, R0.x;
MUL R7.xyz, R0.x, R4;
DP3 R0.x, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.z, R0.x;
MUL R5.xyz, R0.z, fragment.texcoord[2];
TEX R0.yw, fragment.texcoord[0].zwzw, texture[8], 2D;
MAD R0.xy, R0.wyzw, c[21].z, -c[21].y;
ADD R1.xyz, R7, R5;
DP3 R0.w, R1, R1;
MUL R0.z, R0.y, R0.y;
MAD R0.z, -R0.x, R0.x, -R0;
RSQ R0.w, R0.w;
ADD R0.z, R0, c[21].y;
RSQ R0.z, R0.z;
RCP R0.z, R0.z;
MUL R8.xyz, R0.w, R1;
DP3 R0.w, R0, R8;
ABS R1.x, R0.w;
DP3 R5.w, R0, R5;
DP3 R8.w, R0, fragment.texcoord[1];
DP3 R0.x, R0, R7;
ADD R1.z, -R1.x, c[21].y;
MAD R1.y, R1.x, c[24], c[24].z;
MAD R1.y, R1, R1.x, -c[24].w;
RCP R7.w, R5.w;
RSQ R1.z, R1.z;
ADD R2.xyz, -R2, fragment.texcoord[1];
ADD R6.xyz, -R6, fragment.texcoord[1];
MAD R1.x, R1.y, R1, c[25];
RCP R1.z, R1.z;
MUL R1.y, R1.x, R1.z;
SLT R1.x, R0.w, c[21];
MUL R1.z, R1.x, R1.y;
MAD R1.y, -R1.z, c[21].z, R1;
MAD R1.x, R1, c[24], R1.y;
COS R1.x, R1.x;
MUL R1.x, R1, R1;
MUL R2.w, c[10].x, c[10].x;
MUL R1.z, R1.x, R2.w;
MUL R1.y, R1.x, c[10].x;
MUL R1.z, R1.x, R1;
MUL R1.y, R1, c[10].x;
MOV R3.w, c[21].y;
MAX R0.x, R0, c[21];
MUL R1.z, R1, c[25].y;
RCP R1.y, R1.y;
ADD R1.x, -R1, c[21].y;
MUL R1.x, R1, R1.y;
RCP R1.y, R1.z;
POW R1.x, c[23].y, -R1.x;
MUL R1.x, R1, R1.y;
ADD R1.y, -R0.w, c[21];
ADD R1.z, R3.w, -c[3].x;
POW R1.y, R1.y, c[25].z;
MAD R1.y, R1, c[3].x, R1.z;
MUL R6.w, R1.x, R1.y;
TEX R1, fragment.texcoord[0], texture[0], 2D;
MUL R6.w, R1, R6;
MUL_SAT R7.w, R6, R7;
DP3 R6.w, R8, R5;
RCP R6.w, R6.w;
MUL R5.w, R0, R5;
MUL R8.x, R0.w, R8.w;
MUL R5.w, R5, R6;
MUL R8.x, R6.w, R8;
MUL R6.w, R8.x, c[21].z;
MUL R5.w, R5, c[21].z;
MIN_SAT R8.y, R5.w, R6.w;
MUL R5.w, R6.y, R6.y;
MAD R0.y, R6.x, R6.x, R5.w;
MAD R0.z, R6, R6, R0.y;
RSQ R0.z, R0.z;
MOV R5.w, c[5].x;
ADD R5.w, -R5, -c[6].x;
ADD R6.x, R5.w, c[21].z;
RCP R0.z, R0.z;
MUL R0.z, R0, c[7].x;
MUL R0.z, R0, R6.x;
MOV R5.w, c[25];
MUL R0.y, R0.x, R0.x;
MUL R0.y, R0, R0.z;
MUL R0.y, R0, R0.z;
MUL R0.y, R0, c[23].z;
POW R0.y, c[23].y, -R0.y;
MUL R0.y, -R0, c[23].w;
ADD R7.x, R0.y, c[21].y;
MUL R6.x, R5.w, c[3];
MAX R0.w, R0, c[21].x;
POW R0.w, R0.w, R6.x;
MUL R0.z, R1.w, R0.w;
MUL R0.w, R4.y, R4.y;
MAD R0.w, R4.x, R4.x, R0;
MUL R1.w, R0.x, R7.x;
MAD R0.y, R4.z, R4.z, R0.w;
RSQ R0.x, R0.y;
RCP R6.x, R0.x;
ADD_SAT R0.w, -R1, c[21].y;
ADD R0.xy, R4, -fragment.texcoord[1];
POW R0.w, R0.w, c[18].x;
MUL R7.y, R0.w, c[19].x;
MUL R6.x, R4.w, R6;
MUL R0.xy, R0, c[6].x;
MUL R0.xy, R0, R6.x;
MAD R0.xy, -R0, c[8].x, fragment.texcoord[0];
TEX R6, R0, texture[9], 2D;
MUL R0.z, R0, c[23];
TXP R0.x, fragment.texcoord[4], texture[6], 2D;
TEX R0.w, fragment.texcoord[3], texture[7], 2D;
MUL R8.x, R0.w, R0;
MUL R0.x, R7.y, R6.w;
MAD R0.w, R7, R8.y, R0.z;
MUL_SAT R6.w, R0.x, R8.x;
MUL R0.xyz, R6.w, R6;
DP3 R7.y, R4, fragment.texcoord[1];
MUL R4.xyz, R6, c[0];
MUL_SAT R6.x, R7.y, c[9];
MUL_SAT R0.w, R7.x, R0;
MUL R4.xyz, R6.x, R4;
ADD R6.x, -R6, c[21].y;
MAD R4.xyz, R6.x, c[0], R4;
MUL R7.xyz, R3, c[5].x;
ADD R6.x, -R6.w, c[21].y;
MUL R0.xyz, R0, c[20];
MAD R0.xyz, R6.x, R4, R0;
MUL R1.xyz, R1, c[2];
MUL R0.xyz, R1, R0;
MOV R1.xyz, c[4];
MUL R1.xyz, R1, c[0];
MUL R1.xyz, R1, R0.w;
MAD R1.xyz, R0, R1.w, R1;
ADD R4.xyz, fragment.texcoord[1], -R7;
DP3 R0.x, R4, R4;
TEX R0.yw, fragment.texcoord[0].zwzw, texture[10], 2D;
MAD R3.xy, R0.wyzw, c[21].z, -c[21].y;
MUL R0.w, R3.y, R3.y;
MAD R0.w, -R3.x, R3.x, -R0;
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, R4;
ADD R6.xyz, R5, R0;
DP3 R1.w, R6, R6;
RSQ R1.w, R1.w;
MUL R6.xyz, R1.w, R6;
MUL R1.w, R8.x, c[21].z;
ADD R0.w, R0, c[21].y;
RSQ R0.w, R0.w;
RCP R3.z, R0.w;
DP3 R0.x, R3, R0;
DP3 R6.w, R3, R6;
ABS R0.w, R6;
DP3 R3.x, R5, R3;
DP3 R3.z, R5, R6;
MAD R7.z, R0.w, c[24].y, c[24];
ADD R7.w, -R0, c[21].y;
MAD R7.z, R7, R0.w, -c[24].w;
MOV R0.z, c[21].y;
MAD R0.w, R7.z, R0, c[25].x;
RSQ R7.w, R7.w;
RCP R7.z, R7.w;
MUL R8.y, R0.w, R7.z;
MUL R0.w, R2.y, R2.y;
MAD R0.w, R2.x, R2.x, R0;
SLT R2.y, R6.w, c[21].x;
MAD R0.y, R2.z, R2.z, R0.w;
MUL R2.x, R2.y, R8.y;
RSQ R0.y, R0.y;
RCP R0.y, R0.y;
MAX R0.x, R0, c[21];
MUL R1.xyz, R1, R1.w;
MUL R0.y, R0, c[7].x;
ADD R0.z, R0, -c[5].x;
MUL R0.z, R0.y, R0;
MUL R0.y, R0.x, R0.x;
MUL R0.y, R0, R0.z;
MUL R0.y, R0, R0.z;
MUL R0.z, R4.y, R4.y;
MAD R0.z, R4.x, R4.x, R0;
DP3 R4.x, fragment.texcoord[1], R4;
MAD R0.z, R4, R4, R0;
MUL R0.y, R0, c[23].z;
POW R0.y, c[23].y, -R0.y;
MUL R0.y, -R0, c[23].w;
ADD R7.z, R0.y, c[21].y;
RSQ R0.z, R0.z;
RCP R0.y, R0.z;
MUL R0.z, R4.w, R0.y;
MUL R7.w, R0.x, R7.z;
MUL R0.xy, -R7, c[5].x;
MUL R0.xy, R0, R0.z;
ADD_SAT R0.z, -R7.w, c[21].y;
POW R2.z, R0.z, c[18].x;
MAD R0.xy, -R0, c[8].x, fragment.texcoord[0];
TEX R0, R0, texture[9], 2D;
MUL R2.z, R2, c[19].x;
MUL R0.w, R2.z, R0;
MUL_SAT R4.w, R8.x, R0;
MAD R2.x, -R2, c[21].z, R8.y;
MAD R0.w, R2.y, c[24].x, R2.x;
MUL R2.xyz, R4.w, R0;
MUL_SAT R4.x, R4, c[9];
MUL R0.xyz, R0, c[0];
MUL R0.xyz, R4.x, R0;
ADD R4.x, -R4, c[21].y;
MAD R0.xyz, R4.x, c[0], R0;
ADD R4.x, -R4.w, c[21].y;
MUL R2.xyz, R2, c[20];
MAD R2.xyz, R4.x, R0, R2;
COS R4.x, R0.w;
TEX R0, fragment.texcoord[0], texture[4], 2D;
MUL R0.xyz, R0, c[11];
MUL R4.x, R4, R4;
MUL R0.xyz, R0, R2;
MUL R2.y, R2.w, R4.x;
MUL R2.y, R4.x, R2;
MUL R2.x, R4, c[10];
MUL R2.z, R2.y, c[25].y;
MUL R2.x, R2, c[10];
RCP R2.y, R2.x;
ADD R2.x, -R4, c[21].y;
MUL R2.x, R2, R2.y;
RCP R2.y, R2.z;
POW R2.x, c[23].y, -R2.x;
MUL R2.x, R2, R2.y;
ADD R2.y, -R6.w, c[21];
ADD R2.z, R3.w, -c[12].x;
POW R2.y, R2.y, c[25].z;
MAD R2.z, R2.y, c[12].x, R2;
TEX R2.yw, fragment.texcoord[0].zwzw, texture[3], 2D;
MAD R4.xy, R2.wyzw, c[21].z, -c[21].y;
MUL R3.w, R2.x, R2.z;
TEX R2, fragment.texcoord[0], texture[2], 2D;
MUL R4.z, R4.y, R4.y;
MAD R4.z, -R4.x, R4.x, -R4;
ADD R3.y, R4.z, c[21];
RSQ R3.y, R3.y;
RCP R4.z, R3.y;
DP3 R3.y, R5, R4;
MUL R2.xyz, R2, c[15];
MUL R3.w, R3, R2;
RCP R3.x, R3.x;
MUL_SAT R3.x, R3.w, R3;
DP3 R3.w, fragment.texcoord[1], R4;
RCP R3.z, R3.z;
MUL R3.y, R6.w, R3;
MUL R3.y, R3, R3.z;
MUL R4.w, R6, R3;
MUL R3.z, R3, R4.w;
MUL R3.y, R3, c[21].z;
ADD R5.xyz, fragment.texcoord[1], R5;
MUL R6.y, R5.w, c[12].x;
MAX R6.x, R6.w, c[21];
POW R6.x, R6.x, R6.y;
MUL R4.w, R0, R6.x;
MUL R0.w, R3.z, c[21].z;
MUL R3.z, R4.w, c[23];
MIN_SAT R0.w, R3.y, R0;
MAD R0.w, R3.x, R0, R3.z;
MOV R3.xyz, c[13];
MUL_SAT R0.w, R7.z, R0;
MUL R3.xyz, R3, c[0];
MUL R3.xyz, R3, R0.w;
MAD R0.xyz, R0, R7.w, R3;
DP3 R0.w, R5, R5;
RSQ R3.x, R0.w;
MUL R3.xyz, R3.x, R5;
DP3 R3.x, R4, R3;
TEX R0.w, fragment.texcoord[0], texture[5], 2D;
ADD_SAT R0.w, R0, c[14].x;
MUL R0.xyz, R1.w, R0;
MUL R0.xyz, R0.w, R0;
ADD R0.w, -R0, c[21].y;
MAD R0.xyz, R0.w, R1, R0;
MOV R1.xyz, c[1];
MUL R3.y, R5.w, c[16].x;
MAX R3.x, R3, c[21];
POW R3.x, R3.x, R3.y;
MUL_SAT R0.w, R2, R3.x;
MUL R1.xyz, R1, c[0];
MUL R1.xyz, R1, R0.w;
MAX R0.w, R3, c[21].x;
MUL R2.xyz, R2, c[0];
MAD R1.xyz, R2, R0.w, R1;
TEX R0.w, fragment.texcoord[0], texture[1], 2D;
ADD_SAT R0.w, R0, c[17].x;
MUL R1.xyz, R1.w, R1;
MUL R1.xyz, R0.w, R1;
ADD R0.w, -R0, c[21].y;
MAD result.color.xyz, R0.w, R0, R1;
MOV result.color.w, c[21].x;
END
# 320 instructions, 9 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color3]
Float 3 [_Shininess3]
Vector 4 [_SpecColor3]
Float 5 [_Layer1Thickness]
Float 6 [_Layer2Thickness]
Float 7 [_GVar]
Float 8 [_ExitColorMultiplier]
Float 9 [_ExitColorRadius]
Float 10 [_SpecSmoothing]
Vector 11 [_Color2]
Float 12 [_Shininess2]
Vector 13 [_SpecColor2]
Float 14 [_BlendAdjust2]
Vector 15 [_Color]
Float 16 [_Shininess]
Float 17 [_BlendAdjust1]
Float 18 [_DDXP]
Float 19 [_DDXM]
Vector 20 [_SSSC]
SetTexture 0 [_MainTex3] 2D
SetTexture 1 [_ScatterMap] 2D
SetTexture 2 [_MainTex] 2D
SetTexture 3 [_BumpMap] 2D
SetTexture 4 [_MainTex2] 2D
SetTexture 5 [_ScatterMap2] 2D
SetTexture 6 [_ShadowMapTexture] 2D
SetTexture 7 [_LightTexture0] 2D
SetTexture 8 [_BumpMap3] 2D
SetTexture 9 [_ExitColorMap] 2D
SetTexture 10 [_BumpMap2] 2D
"ps_3_0
; 376 ALU, 12 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
dcl_2d s7
dcl_2d s8
dcl_2d s9
dcl_2d s10
def c21, 2.00000000, -1.00000000, 0.11705996, 0.50000000
def c22, 6.28318501, -3.14159298, -0.73550957, 0.73550957
def c23, 0.00000000, -1.00000000, 0.15799320, 0.50000000
def c24, -0.99270076, 0.99270076, 2.71828198, -0.21211439
def c25, 0.39894229, 1.00000000, 0.00000000, 1.57072902
def c26, -0.01872930, 0.07426100, 3.14159298, 3.14159274
def c27, 0.15915491, 0.50000000, 5.00000000, 128.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xy
dcl_texcoord4 v4
texld r4.yw, v0.zwzw, s8
mul r0.x, v1.y, v1.y
mad r0.x, v1, v1, r0
mad r0.x, v1.z, v1.z, r0
rsq r1.w, r0.x
mul r1.x, r1.w, -v1.z
mad r0.x, r1, c21.z, c21.w
frc r0.x, r0
mad r1.y, r0.x, c22.x, c22
sincos r0.xy, r1.y
mad r0.z, r1.x, c22, r0.x
dp3 r0.y, v1, v1
mad_pp r5.xy, r4.wyzw, c21.x, c21.y
mul r1.xy, r0.z, c23
rsq r0.x, r0.y
mul r0.xyz, r0.x, v1
mad r3.xyz, r0, c22.w, r1.xxyw
mul r0.x, r3.y, r3.y
mad r0.x, r3, r3, r0
mad r0.x, r3.z, r3.z, r0
rsq r0.x, r0.x
mul r1.x, r0, -r3.z
mad r0.x, r1, c23.z, c23.w
frc r0.x, r0
mad r1.y, r0.x, c22.x, c22
sincos r0.xy, r1.y
mad r0.z, r1.x, c24.x, r0.x
dp3 r0.y, r3, r3
rsq r0.x, r0.y
mul r6.xyz, r0.x, r3
mul r0.zw, r0.z, c23.xyxy
mad r0.xyz, r6, c24.y, r0.zzww
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r2.xyz, r0.w, r0
mad r1.xyz, -r6, c5.x, v1
mad r8.xyz, -r2, c6.x, r1
dp3 r0.w, r8, r8
rsq r0.w, r0.w
mul r2.xyz, r0.w, r8
dp3_pp r0.w, v2, v2
rsq_pp r0.w, r0.w
mul_pp r1.xyz, r0.w, v2
add r4.xyz, r2, r1
mul_pp r0.w, r5.y, r5.y
mad_pp r0.w, -r5.x, r5.x, -r0
dp3 r2.w, r4, r4
rsq r2.w, r2.w
add_pp r0.w, r0, c25.y
rsq_pp r0.w, r0.w
add r3.xyz, -r3, v1
add r0.xyz, -r0, v1
rcp_pp r5.z, r0.w
mul r7.xyz, r2.w, r4
dp3 r6.w, r5, r7
abs r0.w, r6
add r3.w, -r0, c25.y
mad r2.w, r0, c26.x, c26.y
mad r2.w, r2, r0, c24
rsq r3.w, r3.w
mul r9.xyz, r6, c5.x
mad r0.w, r2, r0, c25
rcp r3.w, r3.w
mul r2.w, r0, r3
cmp r0.w, r6, c25.z, c25.y
mul r3.w, r0, r2
mad r2.w, -r3, c21.x, r2
mul r3.w, r0.y, r0.y
dp3 r0.y, r5, r2
mad r0.x, r0, r0, r3.w
max r2.x, r0.y, c23
mad r0.y, r0.z, r0.z, r0.x
mov r0.x, c6
add r0.z, -c5.x, -r0.x
rsq r0.y, r0.y
rcp r0.x, r0.y
add r0.y, r0.z, c21.x
mul r0.x, r0, c7
mul r0.y, r0.x, r0
mul r0.x, r2, r2
mul r0.x, r0, r0.y
mul r0.x, r0, r0.y
mad r0.z, r0.w, c26, r2.w
mad r0.y, r0.z, c27.x, c27
mul r2.y, r0.x, c21.w
frc r2.z, r0.y
pow r0, c24.z, -r2.y
mad r0.y, r2.z, c22.x, c22
mad r5.w, -r0.x, c25.x, c25.y
mul r3.w, r2.x, r5
sincos r4.xy, r0.y
mul r0.x, r8.y, r8.y
mad r0.x, r8, r8, r0
mul r8.w, r4.x, r4.x
mad r2.y, r8.z, r8.z, r0.x
add_sat r2.x, -r3.w, c25.y
pow r0, r2.x, c18.x
rsq r0.y, r2.y
add r0.zw, r8.xyxy, -v1.xyxy
rcp r0.y, r0.y
mul r0.y, r1.w, r0
mul r0.zw, r0, c6.x
mul r0.zw, r0, r0.y
mov r2.x, r0
mad r0.xy, -r0.zwzw, c8.x, v0
mul r0.z, r2.x, c19.x
texld r2, r0, s9
mul r7.w, c10.x, c10.x
texldp r0.x, v4, s6
texld r0.w, v3, s7
mul r4.w, r0, r0.x
mul r0.x, r0.z, r2.w
mul_sat r0.w, r0.x, r4
mul r0.xyz, r0.w, r2
dp3 r2.w, r8, v1
mul_sat r2.w, r2, c9.x
mul_pp r2.xyz, r2, c0
mul r2.xyz, r2.w, r2
add r2.w, -r2, c25.y
mad r2.xyz, r2.w, c0, r2
add r0.w, -r0, c25.y
mul r0.xyz, r0, c20
mad r0.xyz, r0.w, r2, r0
texld r2, v0, s0
mul_pp r2.xyz, r2, c2
mul_pp r4.xyz, r2, r0
mul r0.w, r8, c10.x
mul r0.w, r0, c10.x
add r0.x, -r8.w, c25.y
rcp r0.y, r0.w
mul r2.x, r0, r0.y
pow r0, c24.z, -r2.x
mul r0.y, r8.w, r7.w
mul r0.y, r8.w, r0
mov r2.y, r0.x
mul r0.x, r0.y, c26.w
add r2.z, -r6.w, c25.y
rcp r2.x, r0.x
pow r0, r2.z, c27.z
mov_pp r0.y, c3.x
add_pp r0.y, c25, -r0
mad r0.y, r0.x, c3.x, r0
mul r0.x, r2.y, r2
mul r0.x, r0, r0.y
dp3_pp r0.y, r5, r1
dp3_pp r0.w, r7, r1
mul r0.x, r2.w, r0
rcp r0.z, r0.y
mul_sat r8.x, r0, r0.z
mul r0.x, r6.w, r0.y
rcp r0.z, r0.w
mul r0.x, r0, r0.z
dp3_pp r0.y, r5, v1
mul r8.y, r0.x, c21.x
mul r0.x, r6.w, r0.y
mul r0.x, r0.z, r0
mul r8.z, r0.x, c21.x
add r5.xyz, v1, -r9
texld r0.yw, v0.zwzw, s10
mad_pp r2.xy, r0.wyzw, c21.x, c21.y
dp3 r0.x, r5, r5
rsq r0.x, r0.x
mul r6.xyz, r0.x, r5
add r0.xyz, r1, r6
dp3 r2.z, r0, r0
mul_pp r0.w, r2.y, r2.y
mad_pp r0.w, -r2.x, r2.x, -r0
rsq r2.z, r2.z
add_pp r0.w, r0, c25.y
mul r7.xyz, r2.z, r0
rsq_pp r0.w, r0.w
rcp_pp r2.z, r0.w
dp3 r8.w, r2, r7
abs r0.x, r8.w
min_sat r8.y, r8, r8.z
dp3_pp r7.x, r1, r7
add r0.z, -r0.x, c25.y
mad r0.y, r0.x, c26.x, c26
mad r0.y, r0, r0.x, c24.w
rsq r0.z, r0.z
mad r0.x, r0.y, r0, c25.w
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r8.z, r8.w, c25, c25.y
mul r0.z, r8, r0.y
mov_pp r0.x, c3
max r6.w, r6, c23.x
mad r9.w, -r0.z, c21.x, r0.y
mul_pp r9.z, c27.w, r0.x
pow r0, r6.w, r9.z
mad r0.y, r8.z, c26.z, r9.w
mul r0.x, r2.w, r0
mad r0.y, r0, c27.x, c27
frc r0.y, r0
mad r6.w, r0.y, c22.x, c22.y
mul r2.w, r0.x, c21
sincos r0.xy, r6.w
mad r0.y, r8.x, r8, r2.w
mul r2.w, r0.x, r0.x
mul_sat r0.w, r5, r0.y
mov_pp r0.xyz, c0
mul_pp r0.xyz, c4, r0
mul r0.xyz, r0, r0.w
mad r4.xyz, r4, r3.w, r0
mul r5.w, r2, c10.x
mul r0.w, r5, c10.x
mul_pp r5.w, r4, c21.x
add r0.x, -r2.w, c25.y
rcp r0.y, r0.w
mul r3.w, r0.x, r0.y
pow r0, c24.z, -r3.w
mul r0.y, r7.w, r2.w
mov r3.w, r0.x
mul r0.x, r2.w, r0.y
mul r2.w, r0.x, c26
add r6.w, -r8, c25.y
pow r0, r6.w, c27.z
rcp r0.y, r2.w
mul r0.z, r3.w, r0.y
mov r2.w, r0.x
texld r0.yw, v0.zwzw, s3
mad_pp r8.xy, r0.wyzw, c21.x, c21.y
mul_pp r0.y, r8, r8
mad_pp r3.w, -r8.x, r8.x, -r0.y
add_pp r3.w, r3, c25.y
rsq_pp r6.w, r3.w
dp3_pp r3.w, r1, r2
dp3 r2.x, r2, r6
rcp_pp r8.z, r6.w
mov_pp r0.x, c12
add_pp r0.x, c25.y, -r0
mad r0.x, r2.w, c12, r0
mul r2.w, r0.z, r0.x
texld r0, v0, s2
mul_pp r0.xyz, r0, c15
mul r2.w, r2, r0
rcp r3.w, r3.w
mul_sat r7.w, r2, r3
dp3_pp r3.w, r1, r8
dp3_pp r6.w, v1, r8
max r6.x, r2, c23
mul r2.w, r8, r6
rcp r7.x, r7.x
mul r3.w, r8, r3
mul r3.w, r3, r7.x
mul r7.x, r7, r2.w
mul r2.w, r3, c21.x
mul r3.w, r7.x, c21.x
min_sat r7.y, r2.w, r3.w
mul r2.w, r3.y, r3.y
mad r2.w, r3.x, r3.x, r2
mad r2.y, r3.z, r3.z, r2.w
rsq r2.x, r2.y
rcp r2.z, r2.x
mov_pp r2.w, c12.x
mov r2.x, c5
mul r2.y, r6.x, r6.x
mul_pp r3.w, c27, r2
max r3.y, r8.w, c23.x
mul r2.z, r2, c7.x
add r2.x, c25.y, -r2
mul r3.x, r2.z, r2
mul r3.z, r2.y, r3.x
pow r2, r3.y, r3.w
mul r2.y, r3.z, r3.x
mul r3.x, r2.y, c21.w
mov r6.y, r2.x
pow r2, c24.z, -r3.x
texld r3, v0, s4
mul r6.z, r3.w, r6.y
mad r3.w, -r2.x, c25.x, c25.y
mul r7.x, r6, r3.w
mul r2.y, r5, r5
mad r2.y, r5.x, r5.x, r2
mad r2.x, r5.z, r5.z, r2.y
rsq r2.x, r2.x
rcp r6.y, r2.x
add_sat r6.x, -r7, c25.y
pow r2, r6.x, c18.x
mul r1.w, r1, r6.y
mul r2.zw, -r9.xyxy, c5.x
mul r2.zw, r2, r1.w
mov r1.w, r2.x
mad r6.xy, -r2.zwzw, c8.x, v0
texld r2, r6, s9
mul r1.w, r1, c19.x
mul r1.w, r1, r2
mul_sat r2.w, r4, r1
mul r6.x, r6.z, c21.w
mad r1.w, r7, r7.y, r6.x
mul r6.xyz, r2.w, r2
dp3 r4.w, v1, r5
mul_sat r4.w, r4, c9.x
mul_pp r2.xyz, r2, c0
mul r2.xyz, r4.w, r2
add r4.w, -r4, c25.y
add r2.w, -r2, c25.y
mul_pp r3.xyz, r3, c11
mul_sat r1.w, r3, r1
add_pp r1.xyz, v1, r1
mul r4.xyz, r4, r5.w
mad r2.xyz, r4.w, c0, r2
mul r5.xyz, r6, c20
mad r2.xyz, r2.w, r2, r5
mul_pp r2.xyz, r3, r2
mov_pp r3.xyz, c0
mul_pp r3.xyz, c13, r3
mul r3.xyz, r3, r1.w
mad r2.xyz, r2, r7.x, r3
dp3_pp r1.w, r1, r1
rsq_pp r1.w, r1.w
mul_pp r1.xyz, r1.w, r1
mov_pp r1.w, c16.x
dp3_pp r1.x, r8, r1
mul r2.xyz, r5.w, r2
mul_pp r3.x, c27.w, r1.w
max_pp r2.w, r1.x, c23.x
pow r1, r2.w, r3.x
texld r1.w, v0, s5
add_sat r1.y, r1.w, c14.x
mov r1.w, r1.x
mul_pp r2.xyz, r1.y, r2
add_pp r1.x, -r1.y, c25.y
mad_pp r1.xyz, r1.x, r4, r2
mov_pp r2.xyz, c0
mul_sat r0.w, r0, r1
mul_pp r2.xyz, c1, r2
mul r2.xyz, r2, r0.w
max_pp r0.w, r6, c23.x
mul_pp r0.xyz, r0, c0
mad r0.xyz, r0, r0.w, r2
mul r2.xyz, r5.w, r0
texld r0.w, v0, s1
add_sat r0.x, r0.w, c17
mul_pp r2.xyz, r0.x, r2
add_pp r0.x, -r0, c25.y
mad_pp oC0.xyz, r0.x, r1, r2
mov_pp oC0.w, c23.x
"
}
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_CUBE" }
Vector 0 [_LightPositionRange]
Vector 1 [_LightColor0]
Vector 2 [_SpecColor]
Vector 3 [_LightShadowData]
Vector 4 [_Color3]
Float 5 [_Shininess3]
Vector 6 [_SpecColor3]
Float 7 [_Layer1Thickness]
Float 8 [_Layer2Thickness]
Float 9 [_GVar]
Float 10 [_ExitColorMultiplier]
Float 11 [_ExitColorRadius]
Float 12 [_SpecSmoothing]
Vector 13 [_Color2]
Float 14 [_Shininess2]
Vector 15 [_SpecColor2]
Float 16 [_BlendAdjust2]
Vector 17 [_Color]
Float 18 [_Shininess]
Float 19 [_BlendAdjust1]
Float 20 [_DDXP]
Float 21 [_DDXM]
Vector 22 [_SSSC]
SetTexture 0 [_MainTex3] 2D
SetTexture 1 [_ScatterMap] 2D
SetTexture 2 [_MainTex] 2D
SetTexture 3 [_BumpMap] 2D
SetTexture 4 [_MainTex2] 2D
SetTexture 5 [_ScatterMap2] 2D
SetTexture 6 [_ShadowMapTexture] CUBE
SetTexture 7 [_LightTexture0] 2D
SetTexture 8 [_BumpMap3] 2D
SetTexture 9 [_ExitColorMap] 2D
SetTexture 10 [_BumpMap2] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 331 ALU, 12 TEX
PARAM c[30] = { program.local[0..22],
		{ 0, 1, 2, 0.73550957 },
		{ -0.73550957, 0, -1, 0.99270076 },
		{ -0.99270076, 2.718282, 0.5, 0.39894229 },
		{ 0.97000003, 3.141593, -0.018729299, 0.074261002 },
		{ 1, 0.0039215689, 1.53787e-005, 6.2273724e-009 },
		{ 0.21211439, 1.570729, 3.1415927, 5 },
		{ 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEMP R7;
TEMP R8;
TEMP R9;
TEMP R10;
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.x, R0.x;
MUL R2.xyz, R0.x, fragment.texcoord[1];
MUL R0.x, R2.y, R2.y;
MAD R0.x, R2, R2, R0;
MAD R0.x, R2.z, R2.z, R0;
RSQ R1.w, R0.x;
MUL R0.y, R1.w, -R2.z;
MUL R0.x, R0.y, c[23].w;
DP3 R0.z, R2, R2;
RSQ R0.z, R0.z;
COS R0.x, R0.x;
MAD R0.x, R0.y, c[24], R0;
MUL R0.xy, R0.x, c[24].yzzw;
MUL R1.xyz, R0.z, R2;
MAD R3.xyz, R1, c[23].w, R0.xxyw;
MUL R0.x, R3.y, R3.y;
MAD R0.x, R3, R3, R0;
MAD R0.x, R3.z, R3.z, R0;
RSQ R0.x, R0.x;
MUL R0.y, R0.x, -R3.z;
MUL R0.x, R0.y, c[24].w;
DP3 R0.z, R3, R3;
RSQ R0.z, R0.z;
COS R0.x, R0.x;
MAD R0.x, R0.y, c[25], R0;
MUL R4.xyz, R0.z, R3;
MUL R0.xy, R0.x, c[24].yzzw;
MAD R7.xyz, R4, c[24].w, R0.xxyw;
DP3 R0.x, R7, R7;
RSQ R0.w, R0.x;
MUL R1.xyz, R0.w, R7;
MAD R0.xyz, -R4, c[7].x, R2;
MAD R6.xyz, -R1, c[8].x, R0;
DP3 R0.x, R6, R6;
RSQ R0.x, R0.x;
MUL R9.xyz, R0.x, R6;
DP3 R0.x, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.z, R0.x;
MUL R1.xyz, R0.z, fragment.texcoord[2];
TEX R0.yw, fragment.texcoord[0].zwzw, texture[8], 2D;
MAD R0.xy, R0.wyzw, c[23].z, -c[23].y;
MUL R0.z, R0.y, R0.y;
MAD R0.w, -R0.x, R0.x, -R0.z;
ADD R5.xyz, R9, R1;
DP3 R0.z, R5, R5;
RSQ R0.z, R0.z;
ADD R0.w, R0, c[23].y;
MUL R5.xyz, R0.z, R5;
RSQ R0.w, R0.w;
RCP R0.z, R0.w;
DP3 R8.x, R0, R5;
DP3 R5.w, R0, R9;
ABS R3.w, R8.x;
MAD R0.w, R3, c[26].z, c[26];
MAD R0.w, R0, R3, -c[28].x;
MAD R2.w, R0, R3, c[28].y;
ADD R7.xyz, -R7, R2;
MUL R0.w, R7.y, R7.y;
MAD R4.w, R7.x, R7.x, R0;
MAX R0.w, R5, c[23].x;
MAD R5.w, R7.z, R7.z, R4;
ADD R7.xy, R6, -R2;
MOV R4.w, c[7].x;
RSQ R5.w, R5.w;
ADD R4.w, -R4, -c[8].x;
RCP R5.w, R5.w;
ADD R3.w, -R3, c[23].y;
RSQ R3.w, R3.w;
TEX R9, fragment.texcoord[4], texture[6], CUBE;
MUL R8.w, c[12].x, c[12].x;
ADD R4.w, R4, c[23].z;
MUL R5.w, R5, c[9].x;
MUL R5.w, R5, R4;
MUL R4.w, R0, R0;
MUL R4.w, R4, R5;
MUL R4.w, R4, R5;
MUL R4.w, R4, c[25].z;
POW R5.w, c[25].y, -R4.w;
RCP R3.w, R3.w;
MUL R4.w, R2, R3;
MUL R3.w, -R5, c[25];
ADD R3.w, R3, c[23].y;
MUL R0.w, R0, R3;
MUL R2.w, R6.y, R6.y;
MAD R2.w, R6.x, R6.x, R2;
MAD R2.w, R6.z, R6.z, R2;
ADD_SAT R5.w, -R0, c[23].y;
POW R5.w, R5.w, c[20].x;
RSQ R2.w, R2.w;
RCP R2.w, R2.w;
MUL R2.w, R1, R2;
MUL R7.xy, R7, c[8].x;
MUL R7.xy, R7, R2.w;
MAD R7.xy, -R7, c[10].x, fragment.texcoord[0];
DP3 R2.w, fragment.texcoord[4], fragment.texcoord[4];
TEX R7, R7, texture[9], 2D;
MUL R6.w, R5, c[21].x;
MUL R6.w, R6, R7;
RSQ R2.w, R2.w;
RCP R5.w, R2.w;
SLT R7.w, R8.x, c[23].x;
DP4 R2.w, R9, c[27];
MUL R5.w, R5, c[0];
MAD R2.w, -R5, c[26].x, R2;
MOV R5.w, c[23].y;
CMP R8.y, R2.w, c[3].x, R5.w;
DP3 R8.z, fragment.texcoord[3], fragment.texcoord[3];
TEX R2.w, R8.z, texture[7], 2D;
MUL R2.w, R2, R8.y;
MUL_SAT R8.y, R6.w, R2.w;
MUL R9.xyz, R8.y, R7;
MUL R6.w, R7, R4;
DP3 R8.z, R6, R2;
MUL R6.xyz, R7, c[1];
MUL_SAT R7.x, R8.z, c[11];
MUL R6.xyz, R7.x, R6;
ADD R7.x, -R7, c[23].y;
MAD R6.xyz, R7.x, c[1], R6;
MUL R7.xyz, R9, c[22];
MUL R9.xyz, R4, c[7].x;
ADD R8.y, -R8, c[23];
MAD R4.w, -R6, c[23].z, R4;
MAD R4.w, R7, c[26].y, R4;
MAD R7.xyz, R8.y, R6, R7;
TEX R6, fragment.texcoord[0], texture[0], 2D;
MUL R6.xyz, R6, c[4];
ADD R4.xyz, R2, -R9;
MUL R6.xyz, R6, R7;
COS R4.w, R4.w;
MUL R7.y, R4.w, R4.w;
MUL R4.w, R7.y, R8;
MUL R7.x, R7.y, c[12];
MUL R4.w, R7.y, R4;
MUL R7.x, R7, c[12];
MUL R4.w, R4, c[28].z;
MOV R7.w, c[23].y;
ADD R7.y, -R7, c[23];
RCP R7.x, R7.x;
MUL R7.x, R7.y, R7;
RCP R4.w, R4.w;
POW R7.x, c[25].y, -R7.x;
MUL R7.y, R7.x, R4.w;
ADD R7.x, -R8, c[23].y;
ADD R4.w, R7, -c[5].x;
POW R7.x, R7.x, c[28].w;
MAD R4.w, R7.x, c[5].x, R4;
DP3 R7.x, R0, R1;
DP3 R0.x, R0, R2;
MUL R7.y, R7, R4.w;
DP3 R0.y, R5, R1;
RCP R0.z, R0.y;
MUL R0.y, R8.x, R7.x;
MUL R0.y, R0, R0.z;
MUL R0.x, R8, R0;
MUL R0.x, R0.z, R0;
RCP R4.w, R7.x;
MUL R7.y, R6.w, R7;
MUL_SAT R9.w, R7.y, R4;
MOV R4.w, c[29].x;
MUL R0.y, R0, c[23].z;
MUL R0.x, R0, c[23].z;
MIN_SAT R5.x, R0.y, R0;
MAX R0.y, R8.x, c[23].x;
TEX R10.yw, fragment.texcoord[0].zwzw, texture[10], 2D;
MAD R8.xy, R10.wyzw, c[23].z, -c[23].y;
MUL R0.x, R4.w, c[5];
POW R0.x, R0.y, R0.x;
MUL R0.x, R6.w, R0;
MUL R5.y, R0.x, c[25].z;
MUL R5.z, R8.y, R8.y;
MAD R6.w, -R8.x, R8.x, -R5.z;
DP3 R0.x, R4, R4;
RSQ R0.x, R0.x;
MUL R7.xyz, R0.x, R4;
ADD R0.xyz, R1, R7;
DP3 R5.z, R0, R0;
RSQ R5.z, R5.z;
MUL R10.xyz, R5.z, R0;
MAD R0.x, R9.w, R5, R5.y;
ADD R6.w, R6, c[23].y;
RSQ R6.w, R6.w;
RCP R8.z, R6.w;
DP3 R9.z, R8, R10;
ABS R0.z, R9;
MUL_SAT R5.y, R3.w, R0.x;
DP3 R10.x, R1, R10;
ADD R0.x, -R0.z, c[23].y;
MAD R0.y, R0.z, c[26].z, c[26].w;
MAD R0.y, R0, R0.z, -c[28].x;
RSQ R0.x, R0.x;
DP3 R7.y, R8, R7;
MUL R6.w, R2, c[23].z;
SLT R3.w, R9.z, c[23].x;
RCP R0.x, R0.x;
MAD R0.y, R0, R0.z, c[28];
MUL R5.z, R0.y, R0.x;
MUL R5.x, R3.w, R5.z;
MAD R5.x, -R5, c[23].z, R5.z;
MOV R0.xyz, c[6];
MUL R0.xyz, R0, c[1];
MUL R0.xyz, R0, R5.y;
MAD R0.xyz, R6, R0.w, R0;
MAD R3.w, R3, c[26].y, R5.x;
COS R0.w, R3.w;
MUL R0.w, R0, R0;
MUL R5.xyz, R0, R6.w;
MUL R0.x, R8.w, R0.w;
MUL R0.y, R0.w, c[12].x;
MUL R0.x, R0.w, R0;
MUL R0.y, R0, c[12].x;
ADD R0.z, -R0.w, c[23].y;
RCP R0.y, R0.y;
MUL R0.y, R0.z, R0;
POW R0.z, c[25].y, -R0.y;
MUL R0.x, R0, c[28].z;
RCP R0.y, R0.x;
MUL R3.w, R0.z, R0.y;
ADD R0.x, -R9.z, c[23].y;
POW R0.z, R0.x, c[28].w;
TEX R0.yw, fragment.texcoord[0].zwzw, texture[3], 2D;
MAD R6.xy, R0.wyzw, c[23].z, -c[23].y;
ADD R0.x, R7.w, -c[14];
MAD R0.y, R0.z, c[14].x, R0.x;
MUL R7.w, R3, R0.y;
MUL R0.x, R6.y, R6.y;
MAD R3.w, -R6.x, R6.x, -R0.x;
ADD R6.z, R3.w, c[23].y;
TEX R0, fragment.texcoord[0], texture[2], 2D;
MUL R3.w, R7, R0;
DP3 R7.w, R1, R8;
RCP R8.w, R7.w;
RSQ R6.z, R6.z;
RCP R6.z, R6.z;
DP3 R7.w, R1, R6;
MUL_SAT R8.w, R3, R8;
MUL R3.w, R9.z, R7;
DP3 R7.w, R2, R6;
MUL R9.w, R9.z, R7;
RCP R10.x, R10.x;
MUL R9.w, R10.x, R9;
MUL R10.x, R3.w, R10;
MUL R3.w, R9, c[23].z;
MUL R9.w, R10.x, c[23].z;
ADD R10.xyz, -R3, R2;
MIN_SAT R9.w, R9, R3;
MUL R10.y, R10, R10;
ADD R1.xyz, R2, R1;
MUL R3.w, R4, c[14].x;
MAX R9.z, R9, c[23].x;
POW R9.z, R9.z, R3.w;
TEX R3, fragment.texcoord[0], texture[4], 2D;
MUL R3.w, R3, R9.z;
MUL R9.z, R3.w, c[25];
MAD R10.x, R10, R10, R10.y;
MAD R3.w, R10.z, R10.z, R10.x;
RSQ R7.x, R3.w;
RCP R7.x, R7.x;
MAX R3.w, R7.y, c[23].x;
ADD R5.w, R5, -c[7].x;
MUL R7.x, R7, c[9];
MUL R7.y, R7.x, R5.w;
MUL R5.w, R3, R3;
MUL R7.x, R5.w, R7.y;
MUL R7.y, R7.x, R7;
MUL R7.x, R4.y, R4.y;
MAD R7.x, R4, R4, R7;
MAD R7.x, R4.z, R4.z, R7;
MUL R7.y, R7, c[25].z;
POW R7.y, c[25].y, -R7.y;
MUL R7.y, -R7, c[25].w;
ADD R7.y, R7, c[23];
MAD R5.w, R8, R9, R9.z;
RSQ R7.x, R7.x;
RCP R7.x, R7.x;
MUL R1.w, R1, R7.x;
MUL R3.w, R3, R7.y;
MUL_SAT R5.w, R7.y, R5;
MUL R7.xy, -R9, c[7].x;
MUL R7.xy, R7, R1.w;
MAD R7.xy, -R7, c[10].x, fragment.texcoord[0];
TEX R8, R7, texture[9], 2D;
ADD_SAT R1.w, -R3, c[23].y;
POW R1.w, R1.w, c[20].x;
MUL R1.w, R1, c[21].x;
MUL R1.w, R1, R8;
MUL_SAT R1.w, R2, R1;
DP3 R2.w, R2, R4;
MUL R9.xyz, R1.w, R8;
MUL R4.xyz, R8, c[1];
MUL_SAT R2.w, R2, c[11].x;
MUL R4.xyz, R2.w, R4;
ADD R2.w, -R2, c[23].y;
MAD R4.xyz, R2.w, c[1], R4;
DP3 R2.w, R1, R1;
MOV R7.xyz, c[15];
MUL R7.xyz, R7, c[1];
RSQ R2.w, R2.w;
MUL R1.xyz, R2.w, R1;
DP3 R1.y, R6, R1;
ADD R1.w, -R1, c[23].y;
MUL R8.xyz, R9, c[22];
MAD R4.xyz, R1.w, R4, R8;
MUL R3.xyz, R3, c[13];
TEX R1.w, fragment.texcoord[0], texture[5], 2D;
ADD_SAT R1.w, R1, c[16].x;
MAX R1.y, R1, c[23].x;
MUL R1.x, R4.w, c[18];
POW R1.x, R1.y, R1.x;
MUL_SAT R0.w, R0, R1.x;
MUL R7.xyz, R7, R5.w;
MUL R3.xyz, R3, R4;
MAD R3.xyz, R3, R3.w, R7;
MUL R2.xyz, R6.w, R3;
MUL R2.xyz, R1.w, R2;
MOV R3.xyz, c[2];
MUL R1.xyz, R3, c[1];
MUL R3.xyz, R0, c[17];
MUL R1.xyz, R1, R0.w;
ADD R1.w, -R1, c[23].y;
TEX R0.w, fragment.texcoord[0], texture[1], 2D;
ADD_SAT R0.w, R0, c[19].x;
MAD R2.xyz, R1.w, R5, R2;
MAX R0.x, R7.w, c[23];
MUL R3.xyz, R3, c[1];
MAD R0.xyz, R3, R0.x, R1;
MUL R0.xyz, R6.w, R0;
MUL R0.xyz, R0.w, R0;
ADD R0.w, -R0, c[23].y;
MAD result.color.xyz, R0.w, R2, R0;
MOV result.color.w, c[23].x;
END
# 331 instructions, 11 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_CUBE" }
Vector 0 [_LightPositionRange]
Vector 1 [_LightColor0]
Vector 2 [_SpecColor]
Vector 3 [_LightShadowData]
Vector 4 [_Color3]
Float 5 [_Shininess3]
Vector 6 [_SpecColor3]
Float 7 [_Layer1Thickness]
Float 8 [_Layer2Thickness]
Float 9 [_GVar]
Float 10 [_ExitColorMultiplier]
Float 11 [_ExitColorRadius]
Float 12 [_SpecSmoothing]
Vector 13 [_Color2]
Float 14 [_Shininess2]
Vector 15 [_SpecColor2]
Float 16 [_BlendAdjust2]
Vector 17 [_Color]
Float 18 [_Shininess]
Float 19 [_BlendAdjust1]
Float 20 [_DDXP]
Float 21 [_DDXM]
Vector 22 [_SSSC]
SetTexture 0 [_MainTex3] 2D
SetTexture 1 [_ScatterMap] 2D
SetTexture 2 [_MainTex] 2D
SetTexture 3 [_BumpMap] 2D
SetTexture 4 [_MainTex2] 2D
SetTexture 5 [_ScatterMap2] 2D
SetTexture 6 [_ShadowMapTexture] CUBE
SetTexture 7 [_LightTexture0] 2D
SetTexture 8 [_BumpMap3] 2D
SetTexture 9 [_ExitColorMap] 2D
SetTexture 10 [_BumpMap2] 2D
"ps_3_0
; 388 ALU, 12 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_cube s6
dcl_2d s7
dcl_2d s8
dcl_2d s9
dcl_2d s10
def c23, 2.00000000, -1.00000000, 0.11705996, 0.50000000
def c24, 6.28318501, -3.14159298, -0.73550957, 0.73550957
def c25, 0.00000000, -1.00000000, 0.15799320, 0.50000000
def c26, -0.99270076, 0.99270076, 2.71828198, 0.97000003
def c27, 0.39894229, 1.00000000, 0.00000000, -0.21211439
def c28, 1.00000000, 0.00392157, 0.00001538, 0.00000001
def c29, -0.01872930, 0.07426100, 1.57072902, 3.14159298
def c30, 0.15915491, 0.50000000, 3.14159274, 5.00000000
def c31, 128.00000000, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
texld r5.yw, v0.zwzw, s8
dp3_pp r0.x, v1, v1
rsq_pp r0.x, r0.x
mul_pp r2.xyz, r0.x, v1
mul r0.x, r2.y, r2.y
mad r0.x, r2, r2, r0
mad r0.x, r2.z, r2.z, r0
rsq r1.w, r0.x
mul r1.x, r1.w, -r2.z
mad r0.x, r1, c23.z, c23.w
frc r0.x, r0
mad r1.y, r0.x, c24.x, c24
sincos r0.xy, r1.y
mad r0.z, r1.x, c24, r0.x
dp3 r0.y, r2, r2
mad_pp r6.xy, r5.wyzw, c23.x, c23.y
mul r1.xy, r0.z, c25
rsq r0.x, r0.y
mul r0.xyz, r0.x, r2
mad r3.xyz, r0, c24.w, r1.xxyw
mul r0.x, r3.y, r3.y
mad r0.x, r3, r3, r0
mad r0.x, r3.z, r3.z, r0
rsq r0.x, r0.x
mul r1.x, r0, -r3.z
mad r0.x, r1, c25.z, c25.w
frc r0.x, r0
mad r1.y, r0.x, c24.x, c24
sincos r0.xy, r1.y
mad r0.z, r1.x, c26.x, r0.x
dp3 r0.y, r3, r3
rsq r0.x, r0.y
mul r7.xyz, r0.x, r3
add r3.xyz, -r3, r2
mul r0.zw, r0.z, c25.xyxy
mad r0.xyz, r7, c26.y, r0.zzww
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, r0
mad r4.xyz, -r7, c7.x, r2
mad r9.xyz, -r1, c8.x, r4
dp3 r0.w, r9, r9
rsq r0.w, r0.w
mul r4.xyz, r0.w, r9
dp3_pp r0.w, v2, v2
rsq_pp r0.w, r0.w
mul_pp r1.xyz, r0.w, v2
add r5.xyz, r4, r1
mul_pp r0.w, r6.y, r6.y
mad_pp r0.w, -r6.x, r6.x, -r0
dp3 r2.w, r5, r5
rsq r2.w, r2.w
add_pp r0.w, r0, c27.y
rsq_pp r0.w, r0.w
mul r3.y, r3, r3
mad r3.y, r3.x, r3.x, r3
add r0.xyz, -r0, r2
rcp_pp r6.z, r0.w
mul r8.xyz, r2.w, r5
dp3 r6.w, r6, r8
abs r0.w, r6
add r3.w, -r0, c27.y
mad r2.w, r0, c29.x, c29.y
mad r2.w, r2, r0, c27
rsq r3.w, r3.w
mul r10.xyz, r7, c7.x
mad r0.w, r2, r0, c29.z
rcp r3.w, r3.w
mul r2.w, r0, r3
mul r3.w, r0.y, r0.y
cmp r0.w, r6, c27.z, c27.y
dp3 r0.y, r6, r4
mad r0.x, r0, r0, r3.w
max r3.w, r0.y, c25.x
mad r0.y, r0.z, r0.z, r0.x
mov r0.x, c8
mul r4.w, r0, r2
add r0.z, -c7.x, -r0.x
rsq r0.y, r0.y
rcp r0.x, r0.y
add r0.y, r0.z, c23.x
mul r0.x, r0, c9
mul r0.y, r0.x, r0
mul r0.x, r3.w, r3.w
mul r0.x, r0, r0.y
mad r0.z, -r4.w, c23.x, r2.w
mul r0.x, r0, r0.y
mad r0.y, r0.w, c29.w, r0.z
mul r2.w, r0.x, c23
mad r4.x, r0.y, c30, c30.y
pow r0, c26.z, -r2.w
frc r0.y, r4.x
mad r0.y, r0, c24.x, c24
sincos r5.xy, r0.y
mad r5.w, -r0.x, c27.x, c27.y
mul r3.w, r3, r5
mul r0.x, r9.y, r9.y
mul r8.w, r5.x, r5.x
mad r4.x, r9, r9, r0
add_sat r2.w, -r3, c27.y
pow r0, r2.w, c20.x
mad r0.y, r9.z, r9.z, r4.x
mov r0.z, r0.x
mul r5.y, r0.z, c21.x
rsq r0.y, r0.y
rcp r0.w, r0.y
add r0.xy, r9, -r2
dp3 r0.z, v4, v4
rsq r2.w, r0.z
mul r0.w, r1, r0
mul r0.xy, r0, c8.x
mul r0.xy, r0, r0.w
mad r0.xy, -r0, c10.x, v0
texld r4, r0, s9
texld r0, v4, s6
dp4 r0.y, r0, c28
rcp r2.w, r2.w
mul r0.x, r2.w, c0.w
mad r0.y, -r0.x, c26.w, r0
mov r0.z, c3.x
dp3 r0.x, v3, v3
mul r7.w, c12.x, c12.x
mad r3.y, r3.z, r3.z, r3
cmp r0.y, r0, c27, r0.z
texld r0.x, r0.x, s7
mul r2.w, r0.x, r0.y
mul r0.x, r5.y, r4.w
dp3 r4.w, r9, r2
mul_sat r0.w, r0.x, r2
mul r0.xyz, r0.w, r4
mul_sat r4.w, r4, c11.x
mul_pp r4.xyz, r4, c1
mul r4.xyz, r4.w, r4
add r4.w, -r4, c27.y
mad r4.xyz, r4.w, c1, r4
add r0.w, -r0, c27.y
mul r0.xyz, r0, c22
mad r0.xyz, r0.w, r4, r0
texld r4, v0, s0
mul_pp r4.xyz, r4, c4
mul_pp r5.xyz, r4, r0
mul r0.w, r8, c12.x
mul r0.w, r0, c12.x
add r0.x, -r8.w, c27.y
rcp r0.y, r0.w
mul r4.x, r0, r0.y
pow r0, c26.z, -r4.x
mul r0.y, r8.w, r7.w
mul r0.y, r8.w, r0
mov r4.y, r0.x
mul r0.x, r0.y, c30.z
add r4.z, -r6.w, c27.y
rcp r4.x, r0.x
pow r0, r4.z, c30.w
mov_pp r0.y, c5.x
add_pp r0.y, c27, -r0
mad r0.y, r0.x, c5.x, r0
mul r0.x, r4.y, r4
mul r0.x, r0, r0.y
dp3_pp r0.y, r6, r1
dp3_pp r0.w, r8, r1
mul r0.x, r4.w, r0
rcp r0.z, r0.y
mul_sat r9.x, r0, r0.z
mul r0.x, r6.w, r0.y
rcp r0.z, r0.w
mul r0.x, r0, r0.z
dp3_pp r0.y, r6, r2
mul r9.y, r0.x, c23.x
mul r0.x, r6.w, r0.y
mul r0.x, r0.z, r0
mul r9.z, r0.x, c23.x
add r6.xyz, r2, -r10
texld r0.yw, v0.zwzw, s10
mad_pp r4.xy, r0.wyzw, c23.x, c23.y
dp3 r0.x, r6, r6
rsq r0.x, r0.x
mul r7.xyz, r0.x, r6
add r0.xyz, r1, r7
dp3 r4.z, r0, r0
mul_pp r0.w, r4.y, r4.y
mad_pp r0.w, -r4.x, r4.x, -r0
rsq r4.z, r4.z
add_pp r0.w, r0, c27.y
mul r8.xyz, r4.z, r0
rsq_pp r0.w, r0.w
rcp_pp r4.z, r0.w
dp3 r8.w, r4, r8
abs r0.x, r8.w
dp3 r3.x, r4, r7
min_sat r9.y, r9, r9.z
max r7.x, r3, c25
rsq r3.x, r3.y
rcp r3.z, r3.x
dp3_pp r8.x, r1, r8
add r0.z, -r0.x, c27.y
mad r0.y, r0.x, c29.x, c29
mad r0.y, r0, r0.x, c27.w
rsq r0.z, r0.z
mov r3.x, c7
mad r0.x, r0.y, r0, c29.z
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r9.z, r8.w, c27, c27.y
mul r0.z, r9, r0.y
mov_pp r0.x, c5
mul r3.y, r7.x, r7.x
max r6.w, r6, c25.x
mad r10.z, -r0, c23.x, r0.y
mul_pp r9.w, c31.x, r0.x
pow r0, r6.w, r9.w
mad r0.y, r9.z, c29.w, r10.z
mul r0.x, r4.w, r0
mad r0.y, r0, c30.x, c30
frc r0.y, r0
mad r6.w, r0.y, c24.x, c24.y
mul r4.w, r0.x, c23
sincos r0.xy, r6.w
mad r0.y, r9.x, r9, r4.w
mul r4.w, r0.x, r0.x
mul_sat r0.w, r5, r0.y
mov_pp r0.xyz, c1
mul_pp r0.xyz, c6, r0
mul r0.xyz, r0, r0.w
mad r5.xyz, r5, r3.w, r0
mul r5.w, r4, c12.x
mul r0.w, r5, c12.x
mul_pp r5.w, r2, c23.x
add r0.x, -r4.w, c27.y
rcp r0.y, r0.w
mul r3.w, r0.x, r0.y
pow r0, c26.z, -r3.w
mul r0.y, r7.w, r4.w
mov r6.w, r0.x
mul r0.x, r4.w, r0.y
mul r3.w, r0.x, c30.z
add r4.w, -r8, c27.y
pow r0, r4.w, c30.w
rcp r0.y, r3.w
mul r0.z, r6.w, r0.y
mov r3.w, r0.x
texld r0.yw, v0.zwzw, s3
mad_pp r9.xy, r0.wyzw, c23.x, c23.y
mul_pp r0.y, r9, r9
mad_pp r4.w, -r9.x, r9.x, -r0.y
add_pp r4.w, r4, c27.y
rsq_pp r6.w, r4.w
dp3_pp r4.w, r1, r4
rcp_pp r9.z, r6.w
mov_pp r0.x, c14
add_pp r0.x, c27.y, -r0
mad r0.x, r3.w, c14, r0
mul r3.w, r0.z, r0.x
texld r0, v0, s2
mul_pp r0.xyz, r0, c17
mul r3.w, r3, r0
rcp r4.w, r4.w
mul_sat r7.w, r3, r4
dp3_pp r6.w, r2, r9
dp3_pp r4.w, r1, r9
mul r3.w, r8, r6
rcp r8.x, r8.x
mul r4.w, r8, r4
mul r4.w, r4, r8.x
mul r8.x, r8, r3.w
mul r3.w, r4, c23.x
mul r4.w, r8.x, c23.x
min_sat r8.y, r3.w, r4.w
mov_pp r3.w, c14.x
mul_pp r4.z, c31.x, r3.w
max r4.w, r8, c25.x
mul r3.z, r3, c9.x
add r3.x, c27.y, -r3
mul r4.x, r3.z, r3
mul r4.y, r3, r4.x
pow r3, r4.w, r4.z
mul r3.y, r4, r4.x
mul r4.x, r3.y, c23.w
mov r7.y, r3.x
pow r3, c26.z, -r4.x
texld r4, v0, s4
mul r7.z, r4.w, r7.y
mad r4.w, -r3.x, c27.x, c27.y
mul r8.x, r7, r4.w
mul r3.y, r6, r6
mad r3.y, r6.x, r6.x, r3
mad r3.x, r6.z, r6.z, r3.y
rsq r3.x, r3.x
rcp r7.y, r3.x
add_sat r7.x, -r8, c27.y
pow r3, r7.x, c20.x
mul r1.w, r1, r7.y
mul r3.zw, -r10.xyxy, c7.x
mul r3.zw, r3, r1.w
mov r1.w, r3.x
mad r7.xy, -r3.zwzw, c10.x, v0
texld r3, r7, s9
mul r1.w, r1, c21.x
mul r1.w, r1, r3
mul_sat r2.w, r2, r1
mul r3.w, r7.z, c23
mul r7.xyz, r2.w, r3
mad r1.w, r7, r8.y, r3
dp3 r3.w, r2, r6
add_pp r2.xyz, r2, r1
mov_pp r1.xyz, c1
mul_sat r3.w, r3, c11.x
mul_pp r3.xyz, r3, c1
mul r3.xyz, r3.w, r3
add r3.w, -r3, c27.y
add r2.w, -r2, c27.y
mul_sat r1.w, r4, r1
mul_pp r1.xyz, c15, r1
mul r1.xyz, r1, r1.w
mul r5.xyz, r5, r5.w
mad r3.xyz, r3.w, c1, r3
mul r6.xyz, r7, c22
mad r3.xyz, r2.w, r3, r6
dp3_pp r2.w, r2, r2
rsq_pp r1.w, r2.w
mul_pp r2.xyz, r1.w, r2
dp3_pp r1.w, r9, r2
mul_pp r4.xyz, r4, c13
mul_pp r3.xyz, r4, r3
mad r1.xyz, r3, r8.x, r1
max_pp r3.x, r1.w, c25
mov_pp r2.x, c18
mul_pp r3.y, c31.x, r2.x
pow r2, r3.x, r3.y
texld r1.w, v0, s5
mul r1.xyz, r5.w, r1
add_sat r1.w, r1, c16.x
mul_pp r3.xyz, r1.w, r1
add_pp r1.x, -r1.w, c27.y
mov r1.w, r2.x
mov_pp r2.xyz, c1
mul_sat r0.w, r0, r1
mul_pp r2.xyz, c2, r2
mul r2.xyz, r2, r0.w
max_pp r0.w, r6, c25.x
mul_pp r0.xyz, r0, c1
mad r0.xyz, r0, r0.w, r2
mul r2.xyz, r5.w, r0
texld r0.w, v0, s1
add_sat r0.x, r0.w, c19
mul_pp r2.xyz, r0.x, r2
mad_pp r1.xyz, r1.x, r5, r3
add_pp r0.x, -r0, c27.y
mad_pp oC0.xyz, r0.x, r1, r2
mov_pp oC0.w, c25.x
"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Vector 0 [_LightPositionRange]
Vector 1 [_LightColor0]
Vector 2 [_SpecColor]
Vector 3 [_LightShadowData]
Vector 4 [_Color3]
Float 5 [_Shininess3]
Vector 6 [_SpecColor3]
Float 7 [_Layer1Thickness]
Float 8 [_Layer2Thickness]
Float 9 [_GVar]
Float 10 [_ExitColorMultiplier]
Float 11 [_ExitColorRadius]
Float 12 [_SpecSmoothing]
Vector 13 [_Color2]
Float 14 [_Shininess2]
Vector 15 [_SpecColor2]
Float 16 [_BlendAdjust2]
Vector 17 [_Color]
Float 18 [_Shininess]
Float 19 [_BlendAdjust1]
Float 20 [_DDXP]
Float 21 [_DDXM]
Vector 22 [_SSSC]
SetTexture 0 [_MainTex3] 2D
SetTexture 1 [_ScatterMap] 2D
SetTexture 2 [_MainTex] 2D
SetTexture 3 [_BumpMap] 2D
SetTexture 4 [_MainTex2] 2D
SetTexture 5 [_ScatterMap2] 2D
SetTexture 6 [_ShadowMapTexture] CUBE
SetTexture 7 [_LightTextureB0] 2D
SetTexture 8 [_LightTexture0] CUBE
SetTexture 9 [_BumpMap3] 2D
SetTexture 10 [_ExitColorMap] 2D
SetTexture 11 [_BumpMap2] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 333 ALU, 13 TEX
PARAM c[30] = { program.local[0..22],
		{ 0, 1, 2, 0.73550957 },
		{ -0.73550957, 0, -1, 0.99270076 },
		{ -0.99270076, 2.718282, 0.5, 0.39894229 },
		{ 0.97000003, 3.141593, -0.018729299, 0.074261002 },
		{ 1, 0.0039215689, 1.53787e-005, 6.2273724e-009 },
		{ 0.21211439, 1.570729, 3.1415927, 5 },
		{ 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEMP R7;
TEMP R8;
TEMP R9;
TEMP R10;
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.x, R0.x;
MUL R2.xyz, R0.x, fragment.texcoord[1];
MUL R0.x, R2.y, R2.y;
MAD R0.x, R2, R2, R0;
MAD R0.x, R2.z, R2.z, R0;
RSQ R1.w, R0.x;
MUL R0.y, R1.w, -R2.z;
MUL R0.x, R0.y, c[23].w;
DP3 R0.z, R2, R2;
RSQ R0.z, R0.z;
COS R0.x, R0.x;
MAD R0.x, R0.y, c[24], R0;
MUL R0.xy, R0.x, c[24].yzzw;
MUL R1.xyz, R0.z, R2;
MAD R3.xyz, R1, c[23].w, R0.xxyw;
MUL R0.x, R3.y, R3.y;
MAD R0.x, R3, R3, R0;
MAD R0.x, R3.z, R3.z, R0;
RSQ R0.x, R0.x;
MUL R0.y, R0.x, -R3.z;
MUL R0.x, R0.y, c[24].w;
DP3 R0.z, R3, R3;
RSQ R0.z, R0.z;
COS R0.x, R0.x;
MAD R0.x, R0.y, c[25], R0;
MUL R4.xyz, R0.z, R3;
MUL R0.xy, R0.x, c[24].yzzw;
MAD R7.xyz, R4, c[24].w, R0.xxyw;
DP3 R0.x, R7, R7;
RSQ R0.w, R0.x;
MUL R1.xyz, R0.w, R7;
MAD R0.xyz, -R4, c[7].x, R2;
MAD R6.xyz, -R1, c[8].x, R0;
DP3 R0.x, R6, R6;
RSQ R0.x, R0.x;
MUL R9.xyz, R0.x, R6;
DP3 R0.x, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.z, R0.x;
MUL R1.xyz, R0.z, fragment.texcoord[2];
TEX R0.yw, fragment.texcoord[0].zwzw, texture[9], 2D;
MAD R0.xy, R0.wyzw, c[23].z, -c[23].y;
MUL R0.z, R0.y, R0.y;
MAD R0.w, -R0.x, R0.x, -R0.z;
ADD R5.xyz, R9, R1;
DP3 R0.z, R5, R5;
RSQ R0.z, R0.z;
ADD R0.w, R0, c[23].y;
MUL R5.xyz, R0.z, R5;
RSQ R0.w, R0.w;
RCP R0.z, R0.w;
DP3 R8.x, R0, R5;
ABS R2.w, R8.x;
DP3 R5.w, R0, R9;
MAD R0.w, R2, c[26].z, c[26];
MAD R0.w, R0, R2, -c[28].x;
ADD R3.w, -R2, c[23].y;
RSQ R3.w, R3.w;
ADD R7.xyz, -R7, R2;
MAD R0.w, R0, R2, c[28].y;
MUL R2.w, R7.y, R7.y;
MAD R4.w, R7.x, R7.x, R2;
MAX R2.w, R5, c[23].x;
MAD R5.w, R7.z, R7.z, R4;
ADD R7.xy, R6, -R2;
RCP R3.w, R3.w;
MUL R6.w, R0, R3;
MUL R0.w, R6.y, R6.y;
MOV R4.w, c[7].x;
RSQ R5.w, R5.w;
ADD R4.w, -R4, -c[8].x;
RCP R5.w, R5.w;
MAD R0.w, R6.x, R6.x, R0;
TEX R9, fragment.texcoord[4], texture[6], CUBE;
MUL R8.w, c[12].x, c[12].x;
ADD R4.w, R4, c[23].z;
MUL R5.w, R5, c[9].x;
MUL R5.w, R5, R4;
MUL R4.w, R2, R2;
MUL R4.w, R4, R5;
MUL R4.w, R4, R5;
MUL R4.w, R4, c[25].z;
POW R3.w, c[25].y, -R4.w;
MUL R3.w, -R3, c[25];
MAD R4.w, R6.z, R6.z, R0;
ADD R3.w, R3, c[23].y;
MUL R0.w, R2, R3;
RSQ R2.w, R4.w;
RCP R2.w, R2.w;
ADD_SAT R4.w, -R0, c[23].y;
MUL R2.w, R1, R2;
MUL R7.xy, R7, c[8].x;
MUL R7.xy, R7, R2.w;
POW R2.w, R4.w, c[20].x;
MUL R8.y, R2.w, c[21].x;
DP3 R2.w, fragment.texcoord[4], fragment.texcoord[4];
RSQ R4.w, R2.w;
MAD R7.xy, -R7, c[10].x, fragment.texcoord[0];
RCP R4.w, R4.w;
TEX R7, R7, texture[10], 2D;
DP4 R2.w, R9, c[27];
MUL R4.w, R4, c[0];
MAD R2.w, -R4, c[26].x, R2;
MOV R5.w, c[23].y;
CMP R8.z, R2.w, c[3].x, R5.w;
DP3 R4.w, fragment.texcoord[3], fragment.texcoord[3];
TEX R4.w, R4.w, texture[7], 2D;
TEX R2.w, fragment.texcoord[3], texture[8], CUBE;
MUL R2.w, R4, R2;
MUL R2.w, R2, R8.z;
MUL R4.w, R8.y, R7;
MUL_SAT R8.y, R4.w, R2.w;
MUL R9.xyz, R8.y, R7;
DP3 R8.z, R6, R2;
SLT R4.w, R8.x, c[23].x;
MUL R7.w, R4, R6;
MAD R7.w, -R7, c[23].z, R6;
MAD R4.w, R4, c[26].y, R7;
MUL R6.xyz, R7, c[1];
MUL_SAT R7.x, R8.z, c[11];
MUL R6.xyz, R7.x, R6;
ADD R7.x, -R7, c[23].y;
MAD R6.xyz, R7.x, c[1], R6;
MUL R7.xyz, R9, c[22];
MUL R9.xyz, R4, c[7].x;
ADD R8.y, -R8, c[23];
MAD R7.xyz, R8.y, R6, R7;
TEX R6, fragment.texcoord[0], texture[0], 2D;
MUL R6.xyz, R6, c[4];
ADD R4.xyz, R2, -R9;
MUL R6.xyz, R6, R7;
COS R4.w, R4.w;
MUL R7.y, R4.w, R4.w;
MUL R4.w, R7.y, R8;
MUL R7.x, R7.y, c[12];
MUL R4.w, R7.y, R4;
MUL R7.x, R7, c[12];
MUL R4.w, R4, c[28].z;
MOV R7.w, c[23].y;
ADD R7.y, -R7, c[23];
RCP R7.x, R7.x;
MUL R7.x, R7.y, R7;
RCP R4.w, R4.w;
POW R7.x, c[25].y, -R7.x;
MUL R7.y, R7.x, R4.w;
ADD R7.x, -R8, c[23].y;
ADD R4.w, R7, -c[5].x;
POW R7.x, R7.x, c[28].w;
MAD R4.w, R7.x, c[5].x, R4;
DP3 R7.x, R0, R1;
DP3 R0.x, R0, R2;
MUL R7.y, R7, R4.w;
DP3 R0.y, R5, R1;
RCP R0.z, R0.y;
MUL R0.y, R8.x, R7.x;
MUL R0.y, R0, R0.z;
MUL R0.x, R8, R0;
MUL R0.x, R0.z, R0;
RCP R4.w, R7.x;
MUL R7.y, R6.w, R7;
MUL_SAT R9.w, R7.y, R4;
MOV R4.w, c[29].x;
MUL R0.y, R0, c[23].z;
MUL R0.x, R0, c[23].z;
MIN_SAT R5.x, R0.y, R0;
MAX R0.y, R8.x, c[23].x;
TEX R10.yw, fragment.texcoord[0].zwzw, texture[11], 2D;
MAD R8.xy, R10.wyzw, c[23].z, -c[23].y;
MUL R0.x, R4.w, c[5];
POW R0.x, R0.y, R0.x;
MUL R0.x, R6.w, R0;
MUL R5.y, R0.x, c[25].z;
MUL R5.z, R8.y, R8.y;
MAD R6.w, -R8.x, R8.x, -R5.z;
DP3 R0.x, R4, R4;
RSQ R0.x, R0.x;
MUL R7.xyz, R0.x, R4;
ADD R0.xyz, R1, R7;
DP3 R5.z, R0, R0;
RSQ R5.z, R5.z;
MUL R10.xyz, R5.z, R0;
MAD R0.x, R9.w, R5, R5.y;
ADD R6.w, R6, c[23].y;
RSQ R6.w, R6.w;
RCP R8.z, R6.w;
DP3 R9.z, R8, R10;
ABS R0.z, R9;
MUL_SAT R5.y, R3.w, R0.x;
DP3 R10.x, R1, R10;
ADD R0.x, -R0.z, c[23].y;
MAD R0.y, R0.z, c[26].z, c[26].w;
MAD R0.y, R0, R0.z, -c[28].x;
RSQ R0.x, R0.x;
DP3 R7.y, R8, R7;
MUL R6.w, R2, c[23].z;
SLT R3.w, R9.z, c[23].x;
RCP R0.x, R0.x;
MAD R0.y, R0, R0.z, c[28];
MUL R5.z, R0.y, R0.x;
MUL R5.x, R3.w, R5.z;
MAD R5.x, -R5, c[23].z, R5.z;
MOV R0.xyz, c[6];
MUL R0.xyz, R0, c[1];
MUL R0.xyz, R0, R5.y;
MAD R0.xyz, R6, R0.w, R0;
MAD R3.w, R3, c[26].y, R5.x;
COS R0.w, R3.w;
MUL R0.w, R0, R0;
MUL R5.xyz, R0, R6.w;
MUL R0.x, R8.w, R0.w;
MUL R0.y, R0.w, c[12].x;
MUL R0.x, R0.w, R0;
MUL R0.y, R0, c[12].x;
ADD R0.z, -R0.w, c[23].y;
RCP R0.y, R0.y;
MUL R0.y, R0.z, R0;
POW R0.z, c[25].y, -R0.y;
MUL R0.x, R0, c[28].z;
RCP R0.y, R0.x;
MUL R3.w, R0.z, R0.y;
ADD R0.x, -R9.z, c[23].y;
POW R0.z, R0.x, c[28].w;
TEX R0.yw, fragment.texcoord[0].zwzw, texture[3], 2D;
MAD R6.xy, R0.wyzw, c[23].z, -c[23].y;
ADD R0.x, R7.w, -c[14];
MAD R0.y, R0.z, c[14].x, R0.x;
MUL R7.w, R3, R0.y;
MUL R0.x, R6.y, R6.y;
MAD R3.w, -R6.x, R6.x, -R0.x;
ADD R6.z, R3.w, c[23].y;
TEX R0, fragment.texcoord[0], texture[2], 2D;
MUL R3.w, R7, R0;
DP3 R7.w, R1, R8;
RCP R8.w, R7.w;
RSQ R6.z, R6.z;
RCP R6.z, R6.z;
DP3 R7.w, R1, R6;
MUL_SAT R8.w, R3, R8;
MUL R3.w, R9.z, R7;
DP3 R7.w, R2, R6;
MUL R9.w, R9.z, R7;
RCP R10.x, R10.x;
MUL R9.w, R10.x, R9;
MUL R10.x, R3.w, R10;
MUL R3.w, R9, c[23].z;
MUL R9.w, R10.x, c[23].z;
ADD R10.xyz, -R3, R2;
MIN_SAT R9.w, R9, R3;
MUL R10.y, R10, R10;
ADD R1.xyz, R2, R1;
MUL R3.w, R4, c[14].x;
MAX R9.z, R9, c[23].x;
POW R9.z, R9.z, R3.w;
TEX R3, fragment.texcoord[0], texture[4], 2D;
MUL R3.w, R3, R9.z;
MUL R9.z, R3.w, c[25];
MAD R10.x, R10, R10, R10.y;
MAD R3.w, R10.z, R10.z, R10.x;
RSQ R7.x, R3.w;
RCP R7.x, R7.x;
MAX R3.w, R7.y, c[23].x;
ADD R5.w, R5, -c[7].x;
MUL R7.x, R7, c[9];
MUL R7.y, R7.x, R5.w;
MUL R5.w, R3, R3;
MUL R7.x, R5.w, R7.y;
MUL R7.y, R7.x, R7;
MUL R7.x, R4.y, R4.y;
MAD R7.x, R4, R4, R7;
MAD R7.x, R4.z, R4.z, R7;
MUL R7.y, R7, c[25].z;
POW R7.y, c[25].y, -R7.y;
MUL R7.y, -R7, c[25].w;
ADD R7.y, R7, c[23];
MAD R5.w, R8, R9, R9.z;
RSQ R7.x, R7.x;
RCP R7.x, R7.x;
MUL R1.w, R1, R7.x;
MUL R3.w, R3, R7.y;
MUL_SAT R5.w, R7.y, R5;
MUL R7.xy, -R9, c[7].x;
MUL R7.xy, R7, R1.w;
MAD R7.xy, -R7, c[10].x, fragment.texcoord[0];
TEX R8, R7, texture[10], 2D;
ADD_SAT R1.w, -R3, c[23].y;
POW R1.w, R1.w, c[20].x;
MUL R1.w, R1, c[21].x;
MUL R1.w, R1, R8;
MUL_SAT R1.w, R2, R1;
DP3 R2.w, R2, R4;
MUL R9.xyz, R1.w, R8;
MUL R4.xyz, R8, c[1];
MUL_SAT R2.w, R2, c[11].x;
MUL R4.xyz, R2.w, R4;
ADD R2.w, -R2, c[23].y;
MAD R4.xyz, R2.w, c[1], R4;
DP3 R2.w, R1, R1;
MOV R7.xyz, c[15];
MUL R7.xyz, R7, c[1];
RSQ R2.w, R2.w;
MUL R1.xyz, R2.w, R1;
DP3 R1.y, R6, R1;
ADD R1.w, -R1, c[23].y;
MUL R8.xyz, R9, c[22];
MAD R4.xyz, R1.w, R4, R8;
MUL R3.xyz, R3, c[13];
TEX R1.w, fragment.texcoord[0], texture[5], 2D;
ADD_SAT R1.w, R1, c[16].x;
MAX R1.y, R1, c[23].x;
MUL R1.x, R4.w, c[18];
POW R1.x, R1.y, R1.x;
MUL_SAT R0.w, R0, R1.x;
MUL R7.xyz, R7, R5.w;
MUL R3.xyz, R3, R4;
MAD R3.xyz, R3, R3.w, R7;
MUL R2.xyz, R6.w, R3;
MUL R2.xyz, R1.w, R2;
MOV R3.xyz, c[2];
MUL R1.xyz, R3, c[1];
MUL R3.xyz, R0, c[17];
MUL R1.xyz, R1, R0.w;
ADD R1.w, -R1, c[23].y;
TEX R0.w, fragment.texcoord[0], texture[1], 2D;
ADD_SAT R0.w, R0, c[19].x;
MAD R2.xyz, R1.w, R5, R2;
MAX R0.x, R7.w, c[23];
MUL R3.xyz, R3, c[1];
MAD R0.xyz, R3, R0.x, R1;
MUL R0.xyz, R6.w, R0;
MUL R0.xyz, R0.w, R0;
ADD R0.w, -R0, c[23].y;
MAD result.color.xyz, R0.w, R2, R0;
MOV result.color.w, c[23].x;
END
# 333 instructions, 11 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Vector 0 [_LightPositionRange]
Vector 1 [_LightColor0]
Vector 2 [_SpecColor]
Vector 3 [_LightShadowData]
Vector 4 [_Color3]
Float 5 [_Shininess3]
Vector 6 [_SpecColor3]
Float 7 [_Layer1Thickness]
Float 8 [_Layer2Thickness]
Float 9 [_GVar]
Float 10 [_ExitColorMultiplier]
Float 11 [_ExitColorRadius]
Float 12 [_SpecSmoothing]
Vector 13 [_Color2]
Float 14 [_Shininess2]
Vector 15 [_SpecColor2]
Float 16 [_BlendAdjust2]
Vector 17 [_Color]
Float 18 [_Shininess]
Float 19 [_BlendAdjust1]
Float 20 [_DDXP]
Float 21 [_DDXM]
Vector 22 [_SSSC]
SetTexture 0 [_MainTex3] 2D
SetTexture 1 [_ScatterMap] 2D
SetTexture 2 [_MainTex] 2D
SetTexture 3 [_BumpMap] 2D
SetTexture 4 [_MainTex2] 2D
SetTexture 5 [_ScatterMap2] 2D
SetTexture 6 [_ShadowMapTexture] CUBE
SetTexture 7 [_LightTextureB0] 2D
SetTexture 8 [_LightTexture0] CUBE
SetTexture 9 [_BumpMap3] 2D
SetTexture 10 [_ExitColorMap] 2D
SetTexture 11 [_BumpMap2] 2D
"ps_3_0
; 389 ALU, 13 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_cube s6
dcl_2d s7
dcl_cube s8
dcl_2d s9
dcl_2d s10
dcl_2d s11
def c23, 2.00000000, -1.00000000, 0.11705996, 0.50000000
def c24, 6.28318501, -3.14159298, -0.73550957, 0.73550957
def c25, 0.00000000, -1.00000000, 0.15799320, 0.50000000
def c26, -0.99270076, 0.99270076, 2.71828198, 0.97000003
def c27, 0.39894229, 1.00000000, 0.00000000, -0.21211439
def c28, 1.00000000, 0.00392157, 0.00001538, 0.00000001
def c29, -0.01872930, 0.07426100, 1.57072902, 3.14159298
def c30, 0.15915491, 0.50000000, 3.14159274, 5.00000000
def c31, 128.00000000, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
texld r5.yw, v0.zwzw, s9
dp3_pp r0.x, v1, v1
rsq_pp r0.x, r0.x
mul_pp r2.xyz, r0.x, v1
mul r0.x, r2.y, r2.y
mad r0.x, r2, r2, r0
mad r0.x, r2.z, r2.z, r0
rsq r1.w, r0.x
mul r1.x, r1.w, -r2.z
mad r0.x, r1, c23.z, c23.w
frc r0.x, r0
mad r1.y, r0.x, c24.x, c24
sincos r0.xy, r1.y
mad r0.z, r1.x, c24, r0.x
dp3 r0.y, r2, r2
mad_pp r6.xy, r5.wyzw, c23.x, c23.y
mul r1.xy, r0.z, c25
rsq r0.x, r0.y
mul r0.xyz, r0.x, r2
mad r3.xyz, r0, c24.w, r1.xxyw
mul r0.x, r3.y, r3.y
mad r0.x, r3, r3, r0
mad r0.x, r3.z, r3.z, r0
rsq r0.x, r0.x
mul r1.x, r0, -r3.z
mad r0.x, r1, c25.z, c25.w
frc r0.x, r0
mad r1.y, r0.x, c24.x, c24
sincos r0.xy, r1.y
mad r0.z, r1.x, c26.x, r0.x
dp3 r0.y, r3, r3
rsq r0.x, r0.y
mul r7.xyz, r0.x, r3
add r3.xyz, -r3, r2
mul r0.zw, r0.z, c25.xyxy
mad r0.xyz, r7, c26.y, r0.zzww
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, r0
mad r4.xyz, -r7, c7.x, r2
mad r9.xyz, -r1, c8.x, r4
dp3 r0.w, r9, r9
rsq r0.w, r0.w
mul r4.xyz, r0.w, r9
dp3_pp r0.w, v2, v2
rsq_pp r0.w, r0.w
mul_pp r1.xyz, r0.w, v2
add r5.xyz, r4, r1
mul_pp r0.w, r6.y, r6.y
mad_pp r0.w, -r6.x, r6.x, -r0
dp3 r2.w, r5, r5
rsq r2.w, r2.w
add_pp r0.w, r0, c27.y
rsq_pp r0.w, r0.w
mul r3.y, r3, r3
mad r3.y, r3.x, r3.x, r3
add r0.xyz, -r0, r2
rcp_pp r6.z, r0.w
mul r8.xyz, r2.w, r5
dp3 r6.w, r6, r8
abs r0.w, r6
add r3.w, -r0, c27.y
mad r2.w, r0, c29.x, c29.y
mad r2.w, r2, r0, c27
rsq r3.w, r3.w
mul r10.xyz, r7, c7.x
mad r0.w, r2, r0, c29.z
rcp r3.w, r3.w
mul r2.w, r0, r3
cmp r0.w, r6, c27.z, c27.y
mul r3.w, r0, r2
mad r3.w, -r3, c23.x, r2
mul r2.w, r0.y, r0.y
dp3 r0.y, r6, r4
mad r0.x, r0, r0, r2.w
max r2.w, r0.y, c25.x
mad r0.y, r0.z, r0.z, r0.x
mov r0.x, c8
add r0.z, -c7.x, -r0.x
rsq r0.y, r0.y
rcp r0.x, r0.y
add r0.y, r0.z, c23.x
mul r0.x, r0, c9
mul r0.y, r0.x, r0
mul r0.x, r2.w, r2.w
mul r0.x, r0, r0.y
mad r0.z, r0.w, c29.w, r3.w
mul r0.x, r0, r0.y
mad r0.y, r0.z, c30.x, c30
mul r3.w, r0.x, c23
frc r4.x, r0.y
pow r0, c26.z, -r3.w
mad r0.y, r4.x, c24.x, c24
sincos r5.xy, r0.y
mad r5.w, -r0.x, c27.x, c27.y
mul r3.w, r2, r5
mul r0.x, r9.y, r9.y
mad r0.x, r9, r9, r0
mul r8.w, r5.x, r5.x
mad r4.x, r9.z, r9.z, r0
add_sat r2.w, -r3, c27.y
pow r0, r2.w, c20.x
rsq r0.y, r4.x
add r0.zw, r9.xyxy, -r2.xyxy
mov r2.w, r0.x
mul r5.y, r2.w, c21.x
rcp r0.y, r0.y
dp3 r2.w, v4, v4
mul r0.y, r1.w, r0
mul r0.zw, r0, c8.x
mul r0.zw, r0, r0.y
mad r0.xy, -r0.zwzw, c10.x, v0
texld r4, r0, s10
texld r0, v4, s6
dp4 r0.y, r0, c28
rsq r2.w, r2.w
rcp r0.x, r2.w
mul r0.x, r0, c0.w
mad r0.x, -r0, c26.w, r0.y
mov r0.z, c3.x
cmp r0.y, r0.x, c27, r0.z
dp3 r0.x, v3, v3
mul r7.w, c12.x, c12.x
mad r3.y, r3.z, r3.z, r3
texld r0.w, v3, s8
texld r0.x, r0.x, s7
mul r0.x, r0, r0.w
mul r2.w, r0.x, r0.y
mul r0.x, r5.y, r4.w
dp3 r4.w, r9, r2
mul_sat r0.w, r0.x, r2
mul r0.xyz, r0.w, r4
mul_sat r4.w, r4, c11.x
mul_pp r4.xyz, r4, c1
mul r4.xyz, r4.w, r4
add r4.w, -r4, c27.y
mad r4.xyz, r4.w, c1, r4
add r0.w, -r0, c27.y
mul r0.xyz, r0, c22
mad r0.xyz, r0.w, r4, r0
texld r4, v0, s0
mul_pp r4.xyz, r4, c4
mul_pp r5.xyz, r4, r0
mul r0.w, r8, c12.x
mul r0.w, r0, c12.x
add r0.x, -r8.w, c27.y
rcp r0.y, r0.w
mul r4.x, r0, r0.y
pow r0, c26.z, -r4.x
mul r0.y, r8.w, r7.w
mul r0.y, r8.w, r0
mov r4.y, r0.x
mul r0.x, r0.y, c30.z
add r4.z, -r6.w, c27.y
rcp r4.x, r0.x
pow r0, r4.z, c30.w
mov_pp r0.y, c5.x
add_pp r0.y, c27, -r0
mad r0.y, r0.x, c5.x, r0
mul r0.x, r4.y, r4
mul r0.x, r0, r0.y
dp3_pp r0.y, r6, r1
dp3_pp r0.w, r8, r1
mul r0.x, r4.w, r0
rcp r0.z, r0.y
mul_sat r9.x, r0, r0.z
mul r0.x, r6.w, r0.y
rcp r0.z, r0.w
mul r0.x, r0, r0.z
dp3_pp r0.y, r6, r2
mul r9.y, r0.x, c23.x
mul r0.x, r6.w, r0.y
mul r0.x, r0.z, r0
mul r9.z, r0.x, c23.x
add r6.xyz, r2, -r10
texld r0.yw, v0.zwzw, s11
mad_pp r4.xy, r0.wyzw, c23.x, c23.y
dp3 r0.x, r6, r6
rsq r0.x, r0.x
mul r7.xyz, r0.x, r6
add r0.xyz, r1, r7
dp3 r4.z, r0, r0
mul_pp r0.w, r4.y, r4.y
mad_pp r0.w, -r4.x, r4.x, -r0
rsq r4.z, r4.z
add_pp r0.w, r0, c27.y
mul r8.xyz, r4.z, r0
rsq_pp r0.w, r0.w
rcp_pp r4.z, r0.w
dp3 r8.w, r4, r8
abs r0.x, r8.w
dp3 r3.x, r4, r7
min_sat r9.y, r9, r9.z
max r7.x, r3, c25
rsq r3.x, r3.y
rcp r3.z, r3.x
dp3_pp r8.x, r1, r8
add r0.z, -r0.x, c27.y
mad r0.y, r0.x, c29.x, c29
mad r0.y, r0, r0.x, c27.w
rsq r0.z, r0.z
mov r3.x, c7
mad r0.x, r0.y, r0, c29.z
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r9.z, r8.w, c27, c27.y
mul r0.z, r9, r0.y
mov_pp r0.x, c5
mul r3.y, r7.x, r7.x
max r6.w, r6, c25.x
mad r10.z, -r0, c23.x, r0.y
mul_pp r9.w, c31.x, r0.x
pow r0, r6.w, r9.w
mad r0.y, r9.z, c29.w, r10.z
mul r0.x, r4.w, r0
mad r0.y, r0, c30.x, c30
frc r0.y, r0
mad r6.w, r0.y, c24.x, c24.y
mul r4.w, r0.x, c23
sincos r0.xy, r6.w
mad r0.y, r9.x, r9, r4.w
mul r4.w, r0.x, r0.x
mul_sat r0.w, r5, r0.y
mov_pp r0.xyz, c1
mul_pp r0.xyz, c6, r0
mul r0.xyz, r0, r0.w
mad r5.xyz, r5, r3.w, r0
mul r5.w, r4, c12.x
mul r0.w, r5, c12.x
mul_pp r5.w, r2, c23.x
add r0.x, -r4.w, c27.y
rcp r0.y, r0.w
mul r3.w, r0.x, r0.y
pow r0, c26.z, -r3.w
mul r0.y, r7.w, r4.w
mov r6.w, r0.x
mul r0.x, r4.w, r0.y
mul r3.w, r0.x, c30.z
add r4.w, -r8, c27.y
pow r0, r4.w, c30.w
rcp r0.y, r3.w
mul r0.z, r6.w, r0.y
mov r3.w, r0.x
texld r0.yw, v0.zwzw, s3
mad_pp r9.xy, r0.wyzw, c23.x, c23.y
mul_pp r0.y, r9, r9
mad_pp r4.w, -r9.x, r9.x, -r0.y
add_pp r4.w, r4, c27.y
rsq_pp r6.w, r4.w
dp3_pp r4.w, r1, r4
rcp_pp r9.z, r6.w
mov_pp r0.x, c14
add_pp r0.x, c27.y, -r0
mad r0.x, r3.w, c14, r0
mul r3.w, r0.z, r0.x
texld r0, v0, s2
mul_pp r0.xyz, r0, c17
mul r3.w, r3, r0
rcp r4.w, r4.w
mul_sat r7.w, r3, r4
dp3_pp r6.w, r2, r9
dp3_pp r4.w, r1, r9
mul r3.w, r8, r6
rcp r8.x, r8.x
mul r4.w, r8, r4
mul r4.w, r4, r8.x
mul r8.x, r8, r3.w
mul r3.w, r4, c23.x
mul r4.w, r8.x, c23.x
min_sat r8.y, r3.w, r4.w
mov_pp r3.w, c14.x
mul_pp r4.z, c31.x, r3.w
max r4.w, r8, c25.x
mul r3.z, r3, c9.x
add r3.x, c27.y, -r3
mul r4.x, r3.z, r3
mul r4.y, r3, r4.x
pow r3, r4.w, r4.z
mul r3.y, r4, r4.x
mul r4.x, r3.y, c23.w
mov r7.y, r3.x
pow r3, c26.z, -r4.x
texld r4, v0, s4
mul r7.z, r4.w, r7.y
mad r4.w, -r3.x, c27.x, c27.y
mul r8.x, r7, r4.w
mul r3.y, r6, r6
mad r3.y, r6.x, r6.x, r3
mad r3.x, r6.z, r6.z, r3.y
rsq r3.x, r3.x
rcp r7.y, r3.x
add_sat r7.x, -r8, c27.y
pow r3, r7.x, c20.x
mul r1.w, r1, r7.y
mul r3.zw, -r10.xyxy, c7.x
mul r3.zw, r3, r1.w
mov r1.w, r3.x
mad r7.xy, -r3.zwzw, c10.x, v0
texld r3, r7, s10
mul r1.w, r1, c21.x
mul r1.w, r1, r3
mul_sat r2.w, r2, r1
mul r3.w, r7.z, c23
mul r7.xyz, r2.w, r3
mad r1.w, r7, r8.y, r3
dp3 r3.w, r2, r6
add_pp r2.xyz, r2, r1
mov_pp r1.xyz, c1
mul_sat r3.w, r3, c11.x
mul_pp r3.xyz, r3, c1
mul r3.xyz, r3.w, r3
add r3.w, -r3, c27.y
add r2.w, -r2, c27.y
mul_sat r1.w, r4, r1
mul_pp r1.xyz, c15, r1
mul r1.xyz, r1, r1.w
mul r5.xyz, r5, r5.w
mad r3.xyz, r3.w, c1, r3
mul r6.xyz, r7, c22
mad r3.xyz, r2.w, r3, r6
dp3_pp r2.w, r2, r2
rsq_pp r1.w, r2.w
mul_pp r2.xyz, r1.w, r2
dp3_pp r1.w, r9, r2
mul_pp r4.xyz, r4, c13
mul_pp r3.xyz, r4, r3
mad r1.xyz, r3, r8.x, r1
max_pp r3.x, r1.w, c25
mov_pp r2.x, c18
mul_pp r3.y, c31.x, r2.x
pow r2, r3.x, r3.y
texld r1.w, v0, s5
mul r1.xyz, r5.w, r1
add_sat r1.w, r1, c16.x
mul_pp r3.xyz, r1.w, r1
add_pp r1.x, -r1.w, c27.y
mov r1.w, r2.x
mov_pp r2.xyz, c1
mul_sat r0.w, r0, r1
mul_pp r2.xyz, c2, r2
mul r2.xyz, r2, r0.w
max_pp r0.w, r6, c25.x
mul_pp r0.xyz, r0, c1
mad r0.xyz, r0, r0.w, r2
mul r2.xyz, r5.w, r0
texld r0.w, v0, s1
add_sat r0.x, r0.w, c19
mul_pp r2.xyz, r0.x, r2
mad_pp r1.xyz, r1.x, r5, r3
add_pp r0.x, -r0, c27.y
mad_pp oC0.xyz, r0.x, r1, r2
mov_pp oC0.w, c25.x
"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_LightShadowData]
Vector 3 [_ShadowOffsets0]
Vector 4 [_ShadowOffsets1]
Vector 5 [_ShadowOffsets2]
Vector 6 [_ShadowOffsets3]
Vector 7 [_Color3]
Float 8 [_Shininess3]
Vector 9 [_SpecColor3]
Float 10 [_Layer1Thickness]
Float 11 [_Layer2Thickness]
Float 12 [_GVar]
Float 13 [_ExitColorMultiplier]
Float 14 [_ExitColorRadius]
Float 15 [_SpecSmoothing]
Vector 16 [_Color2]
Float 17 [_Shininess2]
Vector 18 [_SpecColor2]
Float 19 [_BlendAdjust2]
Vector 20 [_Color]
Float 21 [_Shininess]
Float 22 [_BlendAdjust1]
Float 23 [_DDXP]
Float 24 [_DDXM]
Vector 25 [_SSSC]
SetTexture 0 [_MainTex3] 2D
SetTexture 1 [_ScatterMap] 2D
SetTexture 2 [_MainTex] 2D
SetTexture 3 [_BumpMap] 2D
SetTexture 4 [_MainTex2] 2D
SetTexture 5 [_ScatterMap2] 2D
SetTexture 6 [_LightTexture0] 2D
SetTexture 7 [_LightTextureB0] 2D
SetTexture 8 [_ShadowMapTexture] 2D
SetTexture 9 [_BumpMap3] 2D
SetTexture 10 [_ExitColorMap] 2D
SetTexture 11 [_BumpMap2] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 344 ALU, 16 TEX
PARAM c[32] = { program.local[0..25],
		{ 0, 1, 2, 0.73550957 },
		{ -0.73550957, 0, -1, 0.99270076 },
		{ -0.99270076, 2.718282, 0.5, 0.39894229 },
		{ 0.25, 3.141593, -0.018729299, 0.074261002 },
		{ 0.21211439, 1.570729, 3.1415927, 5 },
		{ 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEMP R7;
TEMP R8;
TEMP R9;
TEMP R10;
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.x, R0.x;
MUL R3.xyz, R0.x, fragment.texcoord[1];
MUL R0.x, R3.y, R3.y;
MAD R0.x, R3, R3, R0;
MAD R0.x, R3.z, R3.z, R0;
RSQ R3.w, R0.x;
MUL R0.y, R3.w, -R3.z;
MUL R0.x, R0.y, c[26].w;
COS R0.z, R0.x;
MAD R0.y, R0, c[27].x, R0.z;
DP3 R0.x, R3, R3;
MUL R1.xy, R0.y, c[27].yzzw;
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, R3;
MAD R4.xyz, R0, c[26].w, R1.xxyw;
MUL R0.x, R4.y, R4.y;
MAD R0.x, R4, R4, R0;
MAD R0.x, R4.z, R4.z, R0;
RSQ R0.x, R0.x;
MUL R0.y, R0.x, -R4.z;
MUL R0.x, R0.y, c[27].w;
COS R0.z, R0.x;
MAD R0.y, R0, c[28].x, R0.z;
DP3 R0.x, R4, R4;
RSQ R0.x, R0.x;
MUL R5.xyz, R0.x, R4;
ADD R4.xyz, -R4, R3;
MUL R0.zw, R0.y, c[27].xyyz;
MAD R0.xyz, R5, c[27].w, R0.zzww;
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R1.xyz, R0.w, R0;
ADD R0.xyz, -R0, R3;
MAD R2.xyz, -R5, c[10].x, R3;
MAD R6.xyz, -R1, c[11].x, R2;
DP3 R0.w, R6, R6;
RSQ R0.w, R0.w;
MUL R2.xyz, R0.w, R6;
TEX R1.yw, fragment.texcoord[0].zwzw, texture[9], 2D;
MUL R4.y, R4, R4;
MAD R4.x, R4, R4, R4.y;
DP3 R0.w, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.w, R0.w;
MUL R7.xyz, R0.w, fragment.texcoord[2];
MAD R1.xy, R1.wyzw, c[26].z, -c[26].y;
ADD R8.xyz, R2, R7;
MUL R0.w, R1.y, R1.y;
MAD R0.w, -R1.x, R1.x, -R0;
DP3 R1.z, R8, R8;
RSQ R1.z, R1.z;
ADD R0.w, R0, c[26].y;
MUL R10.xyz, R5, c[10].x;
MUL R8.xyz, R1.z, R8;
RSQ R0.w, R0.w;
RCP R1.z, R0.w;
DP3 R9.x, R1, R8;
ABS R0.w, R9.x;
MUL R2.w, R0.y, R0.y;
DP3 R0.y, R1, R2;
MAD R2.x, R0, R0, R2.w;
MAX R0.x, R0.y, c[26];
MAD R0.y, R0.z, R0.z, R2.x;
MAD R1.w, R0, c[29].z, c[29];
MAD R1.w, R1, R0, -c[30].x;
MOV R0.z, c[10].x;
RSQ R0.y, R0.y;
ADD R0.z, -R0, -c[11].x;
RCP R0.y, R0.y;
MAD R1.w, R1, R0, c[30].y;
MOV R4.w, c[26].y;
MUL R0.y, R0, c[12].x;
ADD R0.z, R0, c[26];
MUL R0.z, R0.y, R0;
MUL R0.y, R0.x, R0.x;
MUL R0.y, R0, R0.z;
MUL R0.y, R0, R0.z;
ADD R0.z, -R0.w, c[26].y;
MUL R0.y, R0, c[28].z;
RSQ R0.z, R0.z;
RCP R0.z, R0.z;
MUL R8.w, R1, R0.z;
RCP R1.w, fragment.texcoord[4].w;
POW R0.y, c[28].y, -R0.y;
MUL R0.y, -R0, c[28].w;
ADD R7.w, R0.y, c[26].y;
MUL R6.w, R0.x, R7;
MUL R0.y, R6, R6;
MAD R0.y, R6.x, R6.x, R0;
ADD_SAT R0.x, -R6.w, c[26].y;
MAD R0.y, R6.z, R6.z, R0;
POW R0.x, R0.x, c[23].x;
RSQ R0.y, R0.y;
RCP R0.z, R0.y;
MUL R9.y, R0.x, c[24].x;
ADD R0.xy, R6, -R3;
DP3 R6.x, R6, R3;
MUL R0.z, R3.w, R0;
MUL R0.xy, R0, c[11].x;
MUL R0.xy, R0, R0.z;
MAD R0.zw, -R0.xyxy, c[13].x, fragment.texcoord[0].xyxy;
MAD R0.xy, fragment.texcoord[4], R1.w, c[6];
TEX R2, R0.zwzw, texture[10], 2D;
TEX R0.x, R0, texture[8], 2D;
MAD R9.zw, fragment.texcoord[4].xyxy, R1.w, c[5].xyxy;
MOV R0.w, R0.x;
TEX R0.x, R9.zwzw, texture[8], 2D;
MAD R9.zw, fragment.texcoord[4].xyxy, R1.w, c[4].xyxy;
MOV R0.z, R0.x;
TEX R0.x, R9.zwzw, texture[8], 2D;
MAD R9.zw, fragment.texcoord[4].xyxy, R1.w, c[3].xyxy;
MOV R0.y, R0.x;
TEX R0.x, R9.zwzw, texture[8], 2D;
MAD R0, -fragment.texcoord[4].z, R1.w, R0;
CMP R0, R0, c[2].x, R4.w;
DP4 R5.w, R0, c[29].x;
RCP R1.w, fragment.texcoord[3].w;
MAD R0.xy, fragment.texcoord[3], R1.w, c[28].z;
TEX R0.w, R0, texture[6], 2D;
DP3 R0.z, fragment.texcoord[3], fragment.texcoord[3];
SLT R0.x, c[26], fragment.texcoord[3].z;
TEX R1.w, R0.z, texture[7], 2D;
MUL R0.x, R0, R0.w;
MUL R0.x, R0, R1.w;
MUL R5.w, R0.x, R5;
MUL R0.x, R9.y, R2.w;
MUL_SAT R2.w, R0.x, R5;
MUL R0.xyz, R2.w, R2;
SLT R1.w, R9.x, c[26].x;
MUL R0.w, R1, R8;
TEX R9.yw, fragment.texcoord[0].zwzw, texture[11], 2D;
MUL_SAT R6.x, R6, c[14];
MUL R2.xyz, R2, c[0];
MUL R2.xyz, R6.x, R2;
ADD R6.x, -R6, c[26].y;
MAD R2.xyz, R6.x, c[0], R2;
MUL R0.xyz, R0, c[25];
ADD R2.w, -R2, c[26].y;
MAD R2.xyz, R2.w, R2, R0;
MAD R2.w, -R0, c[26].z, R8;
MAD R1.w, R1, c[29].y, R2;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0.xyz, R0, c[7];
COS R1.w, R1.w;
MUL R0.xyz, R0, R2;
MUL R1.w, R1, R1;
MUL R2.w, c[15].x, c[15].x;
MUL R2.y, R1.w, R2.w;
MUL R2.x, R1.w, c[15];
MUL R2.y, R1.w, R2;
MUL R2.x, R2, c[15];
MOV R8.w, c[31].x;
MUL R2.y, R2, c[30].z;
RCP R2.x, R2.x;
ADD R1.w, -R1, c[26].y;
MUL R1.w, R1, R2.x;
RCP R2.x, R2.y;
POW R1.w, c[28].y, -R1.w;
MUL R2.x, R1.w, R2;
MOV R1.w, c[26].y;
ADD R2.z, R1.w, -c[8].x;
ADD R2.y, -R9.x, c[26];
POW R2.y, R2.y, c[30].w;
MAD R2.y, R2, c[8].x, R2.z;
DP3 R2.z, R1, R7;
DP3 R1.y, R1, R3;
MUL R2.x, R2, R2.y;
DP3 R1.x, R8, R7;
MUL R1.z, R9.x, R1.y;
RCP R1.y, R1.x;
MUL R1.x, R9, R2.z;
MUL R1.x, R1, R1.y;
MUL R1.y, R1, R1.z;
ADD R8.xyz, R3, -R10;
RCP R2.y, R2.z;
MUL R2.x, R0.w, R2;
MUL_SAT R6.x, R2, R2.y;
MAD R2.xy, R9.wyzw, c[26].z, -c[26].y;
MUL R2.z, R2.y, R2.y;
MAD R2.z, -R2.x, R2.x, -R2;
ADD R2.z, R2, c[26].y;
RSQ R2.z, R2.z;
RCP R2.z, R2.z;
MUL R1.x, R1, c[26].z;
MUL R1.y, R1, c[26].z;
MIN_SAT R6.y, R1.x, R1;
MUL R1.y, R8.w, c[8].x;
MAX R1.x, R9, c[26];
POW R1.x, R1.x, R1.y;
MUL R0.w, R0, R1.x;
MUL R0.w, R0, c[28].z;
MAD R0.w, R6.x, R6.y, R0;
DP3 R1.x, R8, R8;
RSQ R1.x, R1.x;
MUL R9.xyz, R1.x, R8;
ADD R1.xyz, R7, R9;
DP3 R5.x, R1, R1;
RSQ R5.x, R5.x;
MUL R1.xyz, R5.x, R1;
DP3 R9.w, R2, R1;
ABS R5.x, R9.w;
MUL_SAT R6.y, R7.w, R0.w;
DP3 R1.x, R7, R1;
ADD R5.y, -R5.x, c[26];
MAD R0.w, R5.x, c[29].z, c[29];
MAD R0.w, R0, R5.x, -c[30].x;
RSQ R5.y, R5.y;
MAD R0.w, R0, R5.x, c[30].y;
RCP R5.y, R5.y;
MUL R6.x, R0.w, R5.y;
SLT R0.w, R9, c[26].x;
MUL R6.z, R0.w, R6.x;
MAD R6.x, -R6.z, c[26].z, R6;
MAD R0.w, R0, c[29].y, R6.x;
MOV R5.xyz, c[9];
MUL R5.xyz, R5, c[0];
MUL R5.xyz, R5, R6.y;
MAD R0.xyz, R0, R6.w, R5;
MUL R6.w, R5, c[26].z;
COS R0.w, R0.w;
MUL R0.w, R0, R0;
MUL R6.xyz, R0, R6.w;
MUL R0.y, R2.w, R0.w;
MUL R0.x, R0.w, c[15];
MUL R0.z, R0.w, R0.y;
MUL R0.x, R0, c[15];
RCP R0.y, R0.x;
ADD R0.x, -R0.w, c[26].y;
MUL R0.x, R0, R0.y;
MUL R0.y, R0.z, c[30].z;
ADD R0.z, -R9.w, c[26].y;
RCP R0.y, R0.y;
POW R0.x, c[28].y, -R0.x;
MUL R0.x, R0, R0.y;
TEX R0.yw, fragment.texcoord[0].zwzw, texture[3], 2D;
MAD R5.xy, R0.wyzw, c[26].z, -c[26].y;
POW R0.z, R0.z, c[30].w;
ADD R1.w, R1, -c[17].x;
MAD R0.y, R0.z, c[17].x, R1.w;
MUL R0.z, R5.y, R5.y;
MAD R2.w, -R5.x, R5.x, -R0.z;
MUL R1.w, R0.x, R0.y;
TEX R0, fragment.texcoord[0], texture[2], 2D;
ADD R2.w, R2, c[26].y;
RSQ R5.z, R2.w;
DP3 R2.w, R7, R2;
DP3 R2.x, R2, R9;
RCP R5.z, R5.z;
MAD R4.x, R4.z, R4.z, R4;
RSQ R2.y, R4.x;
RCP R2.y, R2.y;
MOV R4.xyz, c[18];
MUL R0.xyz, R0, c[20];
MUL R1.w, R1, R0;
RCP R2.w, R2.w;
MAX R2.x, R2, c[26];
DP3 R7.w, R7, R5;
MUL_SAT R2.w, R1, R2;
MUL R1.w, R9, R7;
DP3 R7.w, R3, R5;
MUL R1.y, R9.w, R7.w;
RCP R1.x, R1.x;
MUL R1.y, R1.x, R1;
MUL R1.x, R1.w, R1;
MUL R1.y, R1, c[26].z;
MUL R1.x, R1, c[26].z;
MIN_SAT R10.z, R1.x, R1.y;
MAX R1.x, R9.w, c[26];
MUL R1.y, R8.w, c[17].x;
POW R9.w, R1.x, R1.y;
TEX R1, fragment.texcoord[0], texture[4], 2D;
MUL R1.w, R1, R9;
MUL R1.w, R1, c[28].z;
MAD R2.w, R2, R10.z, R1;
ADD R2.z, R4.w, -c[10].x;
MUL R2.y, R2, c[12].x;
MUL R2.z, R2.y, R2;
MUL R2.y, R2.x, R2.x;
MUL R2.y, R2, R2.z;
MUL R1.w, R2.y, R2.z;
MUL R2.y, R8, R8;
MUL R1.w, R1, c[28].z;
MAD R2.y, R8.x, R8.x, R2;
POW R1.w, c[28].y, -R1.w;
MAD R2.y, R8.z, R8.z, R2;
MUL R1.w, -R1, c[28];
ADD R1.w, R1, c[26].y;
MUL_SAT R4.w, R1, R2;
MUL R4.xyz, R4, c[0];
RSQ R2.y, R2.y;
RCP R2.y, R2.y;
MUL R1.w, R2.x, R1;
MUL R2.z, R3.w, R2.y;
MUL R2.xy, -R10, c[10].x;
MUL R2.xy, R2, R2.z;
ADD_SAT R2.z, -R1.w, c[26].y;
POW R3.w, R2.z, c[23].x;
MAD R2.xy, -R2, c[13].x, fragment.texcoord[0];
TEX R2, R2, texture[10], 2D;
MUL R3.w, R3, c[24].x;
MUL R2.w, R3, R2;
DP3 R3.w, R3, R8;
MUL_SAT R2.w, R5, R2;
MUL R9.xyz, R4, R4.w;
MUL R4.xyz, R2.w, R2;
MUL_SAT R3.w, R3, c[14].x;
MUL R2.xyz, R2, c[0];
MUL R2.xyz, R3.w, R2;
ADD R3.w, -R3, c[26].y;
ADD R2.w, -R2, c[26].y;
MAD R2.xyz, R3.w, c[0], R2;
MUL R4.xyz, R4, c[25];
MAD R2.xyz, R2.w, R2, R4;
MUL R1.xyz, R1, c[16];
MUL R1.xyz, R1, R2;
MAD R1.xyz, R1, R1.w, R9;
ADD R2.xyz, R3, R7;
DP3 R2.w, R2, R2;
TEX R1.w, fragment.texcoord[0], texture[5], 2D;
RSQ R2.w, R2.w;
MUL R2.xyz, R2.w, R2;
ADD_SAT R1.w, R1, c[19].x;
MUL R1.xyz, R6.w, R1;
MUL R1.xyz, R1.w, R1;
ADD R1.w, -R1, c[26].y;
MAD R1.xyz, R1.w, R6, R1;
DP3 R1.w, R5, R2;
MUL R2.x, R8.w, c[21];
MAX R1.w, R1, c[26].x;
POW R1.w, R1.w, R2.x;
MOV R2.xyz, c[1];
MUL_SAT R0.w, R0, R1;
MUL R2.xyz, R2, c[0];
MUL R2.xyz, R2, R0.w;
MAX R0.w, R7, c[26].x;
MUL R0.xyz, R0, c[0];
MAD R0.xyz, R0, R0.w, R2;
MUL R2.xyz, R6.w, R0;
TEX R0.w, fragment.texcoord[0], texture[1], 2D;
ADD_SAT R0.x, R0.w, c[22];
MUL R2.xyz, R0.x, R2;
ADD R0.x, -R0, c[26].y;
MAD result.color.xyz, R0.x, R1, R2;
MOV result.color.w, c[26].x;
END
# 344 instructions, 11 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_LightShadowData]
Vector 3 [_ShadowOffsets0]
Vector 4 [_ShadowOffsets1]
Vector 5 [_ShadowOffsets2]
Vector 6 [_ShadowOffsets3]
Vector 7 [_Color3]
Float 8 [_Shininess3]
Vector 9 [_SpecColor3]
Float 10 [_Layer1Thickness]
Float 11 [_Layer2Thickness]
Float 12 [_GVar]
Float 13 [_ExitColorMultiplier]
Float 14 [_ExitColorRadius]
Float 15 [_SpecSmoothing]
Vector 16 [_Color2]
Float 17 [_Shininess2]
Vector 18 [_SpecColor2]
Float 19 [_BlendAdjust2]
Vector 20 [_Color]
Float 21 [_Shininess]
Float 22 [_BlendAdjust1]
Float 23 [_DDXP]
Float 24 [_DDXM]
Vector 25 [_SSSC]
SetTexture 0 [_MainTex3] 2D
SetTexture 1 [_ScatterMap] 2D
SetTexture 2 [_MainTex] 2D
SetTexture 3 [_BumpMap] 2D
SetTexture 4 [_MainTex2] 2D
SetTexture 5 [_ScatterMap2] 2D
SetTexture 6 [_LightTexture0] 2D
SetTexture 7 [_LightTextureB0] 2D
SetTexture 8 [_ShadowMapTexture] 2D
SetTexture 9 [_BumpMap3] 2D
SetTexture 10 [_ExitColorMap] 2D
SetTexture 11 [_BumpMap2] 2D
"ps_3_0
; 396 ALU, 16 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
dcl_2d s7
dcl_2d s8
dcl_2d s9
dcl_2d s10
dcl_2d s11
def c26, 2.00000000, -1.00000000, 0.11705996, 0.50000000
def c27, 6.28318501, -3.14159298, -0.73550957, 0.73550957
def c28, 0.00000000, -1.00000000, 0.15799320, 0.50000000
def c29, -0.99270076, 0.99270076, 2.71828198, 0.25000000
def c30, 0.39894229, 1.00000000, 0.00000000, -0.21211439
def c31, -0.01872930, 0.07426100, 1.57072902, 3.14159298
def c32, 0.15915491, 0.50000000, 3.14159274, 5.00000000
def c33, 128.00000000, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3
dcl_texcoord4 v4
rcp r5.w, v4.w
dp3_pp r0.x, v1, v1
rsq_pp r0.x, r0.x
mul_pp r3.xyz, r0.x, v1
mul r0.x, r3.y, r3.y
mad r0.x, r3, r3, r0
mad r0.x, r3.z, r3.z, r0
rsq r3.w, r0.x
mul r1.x, r3.w, -r3.z
mad r0.x, r1, c26.z, c26.w
frc r0.x, r0
mad r1.y, r0.x, c27.x, c27
sincos r0.xy, r1.y
mad r0.z, r1.x, c27, r0.x
dp3 r0.y, r3, r3
mul r1.xy, r0.z, c28
rsq r0.x, r0.y
mul r0.xyz, r0.x, r3
mad r4.xyz, r0, c27.w, r1.xxyw
mul r0.x, r4.y, r4.y
mad r0.x, r4, r4, r0
mad r0.x, r4.z, r4.z, r0
rsq r0.x, r0.x
mul r1.x, r0, -r4.z
mad r0.x, r1, c28.z, c28.w
frc r0.x, r0
mad r1.y, r0.x, c27.x, c27
sincos r0.xy, r1.y
mad r0.z, r1.x, c29.x, r0.x
dp3 r0.y, r4, r4
rsq r0.x, r0.y
mul r5.xyz, r0.x, r4
mul r0.zw, r0.z, c28.xyxy
mad r0.xyz, r5, c29.y, r0.zzww
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, r0
mad r2.xyz, -r5, c10.x, r3
mad r6.xyz, -r1, c11.x, r2
dp3 r0.w, r6, r6
rsq r0.w, r0.w
mul r1.xyz, r0.w, r6
texld r2.yw, v0.zwzw, s9
dp3_pp r0.w, v2, v2
rsq_pp r0.w, r0.w
mul_pp r7.xyz, r0.w, v2
mad_pp r2.xy, r2.wyzw, c26.x, c26.y
add r8.xyz, r1, r7
mul_pp r0.w, r2.y, r2.y
mad_pp r0.w, -r2.x, r2.x, -r0
dp3 r1.w, r8, r8
rsq r1.w, r1.w
add_pp r0.w, r0, c30.y
rsq_pp r0.w, r0.w
add r4.xyz, -r4, r3
add r0.xyz, -r0, r3
rcp_pp r2.z, r0.w
mul r8.xyz, r1.w, r8
dp3 r6.w, r2, r8
abs r0.w, r6
add r2.w, -r0, c30.y
mad r1.w, r0, c31.x, c31.y
mad r1.w, r1, r0, c30
mad r0.w, r1, r0, c31.z
rsq r2.w, r2.w
rcp r2.w, r2.w
mul r0.w, r0, r2
mul r2.w, r0.y, r0.y
dp3 r0.y, r2, r1
cmp r1.w, r6, c30.z, c30.y
mad r0.x, r0, r0, r2.w
max r1.x, r0.y, c28
mad r0.y, r0.z, r0.z, r0.x
mov r0.x, c11
add r0.z, -c10.x, -r0.x
rsq r0.y, r0.y
rcp r0.x, r0.y
add r0.y, r0.z, c26.x
mul r0.x, r0, c12
mul r0.y, r0.x, r0
mul r0.x, r1, r1
mul r0.x, r0, r0.y
mul r0.x, r0, r0.y
mul r0.z, r1.w, r0.w
mad r0.y, -r0.z, c26.x, r0.w
mad r1.z, r1.w, c31.w, r0.y
mul r1.y, r0.x, c26.w
pow r0, c29.z, -r1.y
mad r0.y, r1.z, c32.x, c32
mad r2.w, -r0.x, c30.x, c30.y
mul r4.w, r1.x, r2
frc r0.y, r0
mad r0.y, r0, c27.x, c27
sincos r9.xy, r0.y
add_sat r1.x, -r4.w, c30.y
pow r0, r1.x, c23.x
mul r1.y, r6, r6
mad r0.y, r6.x, r6.x, r1
mad r0.y, r6.z, r6.z, r0
rsq r0.y, r0.y
rcp r0.z, r0.y
mul r7.w, r0.x, c24.x
add r0.xy, r6, -r3
mul r0.z, r3.w, r0
mul r0.xy, r0, c11.x
mul r0.xy, r0, r0.z
mad r1.xy, -r0, c13.x, v0
mad r0.xy, v4, r5.w, c6
texld r0.x, r0, s8
texld r1, r1, s10
mad r10.xy, v4, r5.w, c5
mov r0.w, r0.x
texld r0.x, r10, s8
mad r10.xy, v4, r5.w, c4
mov r0.z, r0.x
texld r0.x, r10, s8
mad r10.xy, v4, r5.w, c3
mov r0.y, r0.x
texld r0.x, r10, s8
mad r0, -v4.z, r5.w, r0
mov r8.w, c2.x
cmp r0, r0, c30.y, r8.w
dp4_pp r0.z, r0, c29.w
mul r8.w, r9.x, r9.x
mul r9.xyz, r5, c10.x
rcp r5.w, v3.w
mad r10.xy, v3, r5.w, c26.w
dp3 r0.x, v3, v3
add r5.xyz, r3, -r9
texld r0.w, r10, s6
cmp r0.y, -v3.z, c30.z, c30
mul_pp r0.y, r0, r0.w
texld r0.x, r0.x, s7
mul_pp r0.x, r0.y, r0
mul_pp r5.w, r0.x, r0.z
mul r0.x, r7.w, r1.w
dp3 r1.w, r6, r3
mul_sat r0.w, r0.x, r5
mul r0.xyz, r0.w, r1
mul r7.w, c15.x, c15.x
add r6.z, -r6.w, c30.y
mul_sat r1.w, r1, c14.x
mul_pp r1.xyz, r1, c0
mul r1.xyz, r1.w, r1
add r1.w, -r1, c30.y
mad r1.xyz, r1.w, c0, r1
mul r1.w, r8, c15.x
mul r0.xyz, r0, c25
add r0.w, -r0, c30.y
mad r1.xyz, r0.w, r1, r0
texld r0, v0, s0
mul_pp r0.xyz, r0, c7
mul_pp r0.xyz, r0, r1
mul r1.w, r1, c15.x
add r1.x, -r8.w, c30.y
rcp r1.y, r1.w
mul r6.x, r1, r1.y
pow r1, c29.z, -r6.x
mul r1.y, r8.w, r7.w
mul r1.y, r8.w, r1
mov r6.y, r1.x
mul r1.x, r1.y, c32.z
rcp r6.x, r1.x
pow r1, r6.z, c32.w
mov_pp r1.y, c8.x
add_pp r1.y, c30, -r1
mad r1.y, r1.x, c8.x, r1
mul r1.x, r6.y, r6
mul r1.x, r1, r1.y
dp3_pp r1.y, r2, r7
mul r1.x, r0.w, r1
rcp r1.z, r1.y
mul_sat r9.w, r1.x, r1.z
dp3_pp r1.w, r8, r7
mul r1.x, r6.w, r1.y
rcp r1.z, r1.w
mul r1.x, r1, r1.z
dp3_pp r1.y, r2, r3
mul r10.x, r1, c26
mul r1.x, r6.w, r1.y
mul r1.x, r1.z, r1
mul r9.z, r1.x, c26.x
dp3 r1.x, r5, r5
texld r1.yw, v0.zwzw, s11
mad_pp r2.xy, r1.wyzw, c26.x, c26.y
rsq r1.x, r1.x
mul r6.xyz, r1.x, r5
add r1.xyz, r7, r6
dp3 r2.z, r1, r1
mul_pp r1.w, r2.y, r2.y
mad_pp r1.w, -r2.x, r2.x, -r1
rsq r2.z, r2.z
add_pp r1.w, r1, c30.y
mul r8.xyz, r2.z, r1
rsq_pp r1.w, r1.w
rcp_pp r2.z, r1.w
dp3 r8.w, r2, r8
abs r1.x, r8.w
min_sat r9.z, r10.x, r9
add r1.z, -r1.x, c30.y
mad r1.y, r1.x, c31.x, c31
mad r1.y, r1, r1.x, c30.w
dp3_pp r8.x, r7, r8
rsq r1.z, r1.z
mad r1.x, r1.y, r1, c31.z
rcp r1.z, r1.z
mul r1.y, r1.x, r1.z
cmp r10.x, r8.w, c30.z, c30.y
mul r1.z, r10.x, r1.y
mov_pp r1.x, c8
mul_pp r10.y, c33.x, r1.x
mad r10.z, -r1, c26.x, r1.y
max r6.w, r6, c28.x
pow r1, r6.w, r10.y
mad r1.y, r10.x, c31.w, r10.z
mul r0.w, r0, r1.x
mad r1.y, r1, c32.x, c32
frc r1.y, r1
mad r6.w, r1.y, c27.x, c27.y
sincos r1.xy, r6.w
mul r0.w, r0, c26
mad r0.w, r9, r9.z, r0
mul_sat r0.w, r2, r0
mul r2.w, r1.x, r1.x
mov_pp r1.xyz, c0
mul_pp r1.xyz, c9, r1
mul r1.xyz, r1, r0.w
mad r1.xyz, r0, r4.w, r1
mul r1.w, r2, c15.x
mul r0.w, r1, c15.x
mul_pp r1.w, r5, c26.x
add r0.x, -r2.w, c30.y
rcp r0.y, r0.w
mul r4.w, r0.x, r0.y
pow r0, c29.z, -r4.w
mul r0.y, r7.w, r2.w
mov r4.w, r0.x
mul r0.x, r2.w, r0.y
mul r2.w, r0.x, c32.z
add r6.w, -r8, c30.y
pow r0, r6.w, c32.w
rcp r0.y, r2.w
mul r0.z, r4.w, r0.y
mov r2.w, r0.x
texld r0.yw, v0.zwzw, s3
mad_pp r10.xy, r0.wyzw, c26.x, c26.y
mul_pp r0.y, r10, r10
mad_pp r4.w, -r10.x, r10.x, -r0.y
add_pp r4.w, r4, c30.y
rsq_pp r6.w, r4.w
dp3_pp r4.w, r7, r2
dp3 r2.x, r2, r6
rcp_pp r10.z, r6.w
mov_pp r0.x, c17
add_pp r0.x, c30.y, -r0
mad r0.x, r2.w, c17, r0
mul r2.w, r0.z, r0.x
texld r0, v0, s2
mul_pp r0.xyz, r0, c20
mul r2.w, r2, r0
rcp r4.w, r4.w
mul_sat r7.w, r2, r4
dp3_pp r6.w, r3, r10
dp3_pp r4.w, r7, r10
max r6.x, r2, c28
mul r2.w, r8, r6
rcp r8.x, r8.x
mul r4.w, r8, r4
mul r4.w, r4, r8.x
mul r8.x, r8, r2.w
mul r2.w, r4, c26.x
mul r4.w, r8.x, c26.x
min_sat r8.y, r2.w, r4.w
mul r2.w, r4.y, r4.y
mad r2.w, r4.x, r4.x, r2
mad r2.y, r4.z, r4.z, r2.w
rsq r2.x, r2.y
rcp r2.z, r2.x
mov_pp r2.w, c17.x
mov r2.x, c10
mul r2.y, r6.x, r6.x
mul_pp r4.w, c33.x, r2
max r4.y, r8.w, c28.x
mul r2.z, r2, c12.x
add r2.x, c30.y, -r2
mul r4.x, r2.z, r2
mul r4.z, r2.y, r4.x
pow r2, r4.y, r4.w
mul r2.y, r4.z, r4.x
mul r4.x, r2.y, c26.w
mov r6.y, r2.x
pow r2, c29.z, -r4.x
texld r4, v0, s4
mul r6.z, r4.w, r6.y
mad r4.w, -r2.x, c30.x, c30.y
mul r8.x, r6, r4.w
mul r2.y, r5, r5
mad r2.y, r5.x, r5.x, r2
dp3 r5.x, r3, r5
mad r2.x, r5.z, r5.z, r2.y
rsq r2.x, r2.x
rcp r6.y, r2.x
add_sat r6.x, -r8, c30.y
pow r2, r6.x, c23.x
mul r2.y, r3.w, r6
mul r2.zw, -r9.xyxy, c10.x
mul r2.zw, r2, r2.y
mov r3.w, r2.x
mad r6.xy, -r2.zwzw, c13.x, v0
texld r2, r6, s10
mul r3.w, r3, c24.x
mul r2.w, r3, r2
mul_sat r3.w, r5, r2
mul r6.x, r6.z, c26.w
mad r2.w, r7, r8.y, r6.x
mul r6.xyz, r3.w, r2
mul_sat r5.x, r5, c14
mul_pp r2.xyz, r2, c0
mul r2.xyz, r5.x, r2
add r5.x, -r5, c30.y
mad r2.xyz, r5.x, c0, r2
add r3.w, -r3, c30.y
mul r5.xyz, r6, c25
mad r2.xyz, r3.w, r2, r5
mul_pp r4.xyz, r4, c16
mul_pp r2.xyz, r4, r2
add_pp r4.xyz, r3, r7
mov_pp r3.xyz, c0
dp3_pp r3.w, r4, r4
mul_sat r2.w, r4, r2
mul_pp r3.xyz, c18, r3
mul r3.xyz, r3, r2.w
mad r2.xyz, r2, r8.x, r3
rsq_pp r2.w, r3.w
mul_pp r3.xyz, r2.w, r4
dp3_pp r2.w, r10, r3
max_pp r4.x, r2.w, c28
mov_pp r3.x, c21
mul_pp r4.y, c33.x, r3.x
pow r3, r4.x, r4.y
texld r2.w, v0, s5
mul r2.xyz, r1.w, r2
add_sat r2.w, r2, c19.x
mul_pp r4.xyz, r2.w, r2
add_pp r2.x, -r2.w, c30.y
mul r1.xyz, r1, r1.w
mad_pp r1.xyz, r2.x, r1, r4
mov r2.w, r3.x
mov_pp r2.xyz, c0
mul_sat r0.w, r0, r2
mul_pp r2.xyz, c1, r2
mul r2.xyz, r2, r0.w
max_pp r0.w, r6, c28.x
mul_pp r0.xyz, r0, c0
mad r0.xyz, r0, r0.w, r2
mul r2.xyz, r1.w, r0
texld r0.w, v0, s1
add_sat r0.x, r0.w, c22
mul_pp r2.xyz, r0.x, r2
add_pp r0.x, -r0, c30.y
mad_pp oC0.xyz, r0.x, r1, r2
mov_pp oC0.w, c28.x
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_LightShadowData]
Vector 3 [_ShadowOffsets0]
Vector 4 [_ShadowOffsets1]
Vector 5 [_ShadowOffsets2]
Vector 6 [_ShadowOffsets3]
Vector 7 [_Color3]
Float 8 [_Shininess3]
Vector 9 [_SpecColor3]
Float 10 [_Layer1Thickness]
Float 11 [_Layer2Thickness]
Float 12 [_GVar]
Float 13 [_ExitColorMultiplier]
Float 14 [_ExitColorRadius]
Float 15 [_SpecSmoothing]
Vector 16 [_Color2]
Float 17 [_Shininess2]
Vector 18 [_SpecColor2]
Float 19 [_BlendAdjust2]
Vector 20 [_Color]
Float 21 [_Shininess]
Float 22 [_BlendAdjust1]
Float 23 [_DDXP]
Float 24 [_DDXM]
Vector 25 [_SSSC]
SetTexture 0 [_MainTex3] 2D
SetTexture 1 [_ScatterMap] 2D
SetTexture 2 [_MainTex] 2D
SetTexture 3 [_BumpMap] 2D
SetTexture 4 [_MainTex2] 2D
SetTexture 5 [_ScatterMap2] 2D
SetTexture 6 [_LightTexture0] 2D
SetTexture 7 [_LightTextureB0] 2D
SetTexture 8 [_ShadowMapTexture] 2D
SetTexture 9 [_BumpMap3] 2D
SetTexture 10 [_ExitColorMap] 2D
SetTexture 11 [_BumpMap2] 2D
"ps_3_0
; 396 ALU, 16 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
dcl_2d s7
dcl_2d s8
dcl_2d s9
dcl_2d s10
dcl_2d s11
def c26, 2.00000000, -1.00000000, 0.11705996, 0.50000000
def c27, 6.28318501, -3.14159298, -0.73550957, 0.73550957
def c28, 0.00000000, -1.00000000, 0.15799320, 0.50000000
def c29, -0.99270076, 0.99270076, 2.71828198, 1.00000000
def c30, 0.39894229, 1.00000000, 0.00000000, 0.25000000
def c31, -0.01872930, 0.07426100, -0.21211439, 1.57072902
def c32, 3.14159298, 0.15915491, 0.50000000, 3.14159274
def c33, 5.00000000, 128.00000000, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3
dcl_texcoord4 v4
dp3_pp r0.x, v1, v1
rsq_pp r0.x, r0.x
mul_pp r4.xyz, r0.x, v1
mul r0.x, r4.y, r4.y
mad r0.x, r4, r4, r0
mad r0.x, r4.z, r4.z, r0
rsq r3.w, r0.x
mul r1.x, r3.w, -r4.z
mad r0.x, r1, c26.z, c26.w
frc r0.x, r0
mad r1.y, r0.x, c27.x, c27
sincos r0.xy, r1.y
mad r0.z, r1.x, c27, r0.x
dp3 r0.y, r4, r4
rcp r4.w, v4.w
mul r1.xy, r0.z, c28
rsq r0.x, r0.y
mul r0.xyz, r0.x, r4
mad r5.xyz, r0, c27.w, r1.xxyw
mul r0.x, r5.y, r5.y
mad r0.x, r5, r5, r0
mad r0.x, r5.z, r5.z, r0
rsq r0.x, r0.x
mul r1.x, r0, -r5.z
mad r0.x, r1, c28.z, c28.w
frc r0.x, r0
mad r1.y, r0.x, c27.x, c27
sincos r0.xy, r1.y
mad r0.z, r1.x, c29.x, r0.x
dp3 r0.y, r5, r5
rsq r0.x, r0.y
mul r6.xyz, r0.x, r5
mul r0.zw, r0.z, c28.xyxy
mad r0.xyz, r6, c29.y, r0.zzww
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, r0
mad r2.xyz, -r6, c10.x, r4
mad r7.xyz, -r1, c11.x, r2
texld r2.yw, v0.zwzw, s9
dp3 r0.w, r7, r7
rsq r0.w, r0.w
mul r1.xyz, r0.w, r7
dp3_pp r0.w, v2, v2
rsq_pp r0.w, r0.w
add r5.xyz, -r5, r4
mad_pp r3.xy, r2.wyzw, c26.x, c26.y
mul_pp r8.xyz, r0.w, v2
add r2.xyz, r1, r8
dp3 r1.w, r2, r2
mul_pp r0.w, r3.y, r3.y
mad_pp r0.w, -r3.x, r3.x, -r0
rsq r1.w, r1.w
add_pp r0.w, r0, c29
rsq_pp r0.w, r0.w
add r0.xyz, -r0, r4
mul r9.xyz, r1.w, r2
rcp_pp r3.z, r0.w
dp3 r7.w, r3, r9
abs r0.w, r7
add r2.x, -r0.w, c29.w
mad r1.w, r0, c31.x, c31.y
mad r1.w, r1, r0, c31.z
mad r0.w, r1, r0, c31
rsq r2.x, r2.x
rcp r2.x, r2.x
mul r0.w, r0, r2.x
mul r2.x, r0.y, r0.y
dp3 r0.y, r3, r1
cmp r1.w, r7, c30.z, c30.y
mad r0.x, r0, r0, r2
max r1.x, r0.y, c28
mad r0.y, r0.z, r0.z, r0.x
mov r0.x, c11
add r0.z, -c10.x, -r0.x
rsq r0.y, r0.y
rcp r0.x, r0.y
add r0.y, r0.z, c26.x
mul r0.x, r0, c12
mul r0.y, r0.x, r0
mul r0.x, r1, r1
mul r0.x, r0, r0.y
mul r0.x, r0, r0.y
mul r0.z, r1.w, r0.w
mad r0.y, -r0.z, c26.x, r0.w
mad r1.z, r1.w, c32.x, r0.y
mul r1.y, r0.x, c26.w
pow r0, c29.z, -r1.y
mad r0.y, r1.z, c32, c32.z
mad r5.w, -r0.x, c30.x, c30.y
mul r6.w, r1.x, r5
frc r0.y, r0
mad r0.y, r0, c27.x, c27
sincos r10.xy, r0.y
add_sat r1.x, -r6.w, c29.w
mul r8.w, r10.x, r10.x
pow r0, r1.x, c23.x
mul r1.y, r7, r7
mad r0.y, r7.x, r7.x, r1
mad r0.y, r7.z, r7.z, r0
rsq r0.y, r0.y
rcp r0.z, r0.y
mul r1.w, r0.x, c24.x
add r0.xy, r7, -r4
mul r0.z, r3.w, r0
mul r0.xy, r0, c11.x
mul r1.xy, r0, r0.z
mad r0.xyz, v4, r4.w, c6
mad r1.xy, -r1, c13.x, v0
texld r2, r1, s10
mad r1.xyz, v4, r4.w, c4
texld r0.x, r0, s8
mov_pp r0.w, r0.x
mad r0.xyz, v4, r4.w, c5
texld r0.x, r0, s8
texld r1.x, r1, s8
mov_pp r0.z, r0.x
mov_pp r0.y, r1.x
mad r1.xyz, v4, r4.w, c3
mov r0.x, c2
add r4.w, c29, -r0.x
texld r0.x, r1, s8
mad r0, r0, r4.w, c2.x
dp4_pp r0.z, r0, c30.w
rcp r1.x, v3.w
mad r1.xy, v3, r1.x, c26.w
texld r0.w, r1, s6
dp3 r0.x, v3, v3
cmp r0.y, -v3.z, c30.z, c30
mul_pp r0.y, r0, r0.w
texld r0.x, r0.x, s7
mul_pp r0.x, r0.y, r0
mul_pp r4.w, r0.x, r0.z
mul r0.x, r1.w, r2.w
mul_sat r0.w, r0.x, r4
mul r0.xyz, r0.w, r2
mul_pp r1.xyz, r2, c0
dp3 r1.w, r7, r4
mul_sat r1.w, r1, c14.x
mul r1.xyz, r1.w, r1
add r1.w, -r1, c29
mad r1.xyz, r1.w, c0, r1
mul r1.w, r8, c15.x
mul r2.w, c15.x, c15.x
add r2.z, -r7.w, c29.w
mul r0.xyz, r0, c25
add r0.w, -r0, c29
mad r1.xyz, r0.w, r1, r0
texld r0, v0, s0
mul_pp r0.xyz, r0, c7
mul_pp r0.xyz, r0, r1
mul r1.w, r1, c15.x
add r1.x, -r8.w, c29.w
rcp r1.y, r1.w
mul r2.x, r1, r1.y
pow r1, c29.z, -r2.x
mul r1.y, r8.w, r2.w
mul r1.y, r8.w, r1
mov r2.y, r1.x
mul r1.x, r1.y, c32.w
rcp r2.x, r1.x
pow r1, r2.z, c33.x
mov_pp r1.y, c8.x
dp3_pp r1.w, r9, r8
add_pp r1.y, c29.w, -r1
mad r1.y, r1.x, c8.x, r1
mul r1.x, r2.y, r2
mul r1.x, r1, r1.y
dp3_pp r1.y, r3, r8
mul r9.xyz, r6, c10.x
mul r1.x, r0.w, r1
rcp r1.z, r1.y
mul_sat r9.w, r1.x, r1.z
mul r1.x, r7.w, r1.y
rcp r1.z, r1.w
mul r1.x, r1, r1.z
dp3_pp r1.y, r3, r4
mul r10.x, r1, c26
mul r1.x, r7.w, r1.y
texld r1.yw, v0.zwzw, s11
mad_pp r2.xy, r1.wyzw, c26.x, c26.y
mul_pp r1.w, r2.y, r2.y
mad_pp r1.w, -r2.x, r2.x, -r1
add_pp r1.w, r1, c29
add r3.xyz, r4, -r9
mul r1.x, r1.z, r1
mul r9.z, r1.x, c26.x
dp3 r1.x, r3, r3
rsq r1.x, r1.x
mul r6.xyz, r1.x, r3
add r1.xyz, r8, r6
dp3 r2.z, r1, r1
rsq r2.z, r2.z
mul r7.xyz, r2.z, r1
rsq_pp r1.w, r1.w
rcp_pp r2.z, r1.w
dp3 r8.w, r2, r7
abs r1.x, r8.w
min_sat r9.z, r10.x, r9
add r1.z, -r1.x, c29.w
mad r1.y, r1.x, c31.x, c31
mad r1.y, r1, r1.x, c31.z
dp3_pp r7.x, r8, r7
rsq r1.z, r1.z
mad r1.x, r1.y, r1, c31.w
rcp r1.z, r1.z
mul r1.y, r1.x, r1.z
cmp r10.x, r8.w, c30.z, c30.y
mul r1.z, r10.x, r1.y
mov_pp r1.x, c8
mul_pp r10.y, c33, r1.x
mad r10.z, -r1, c26.x, r1.y
max r7.w, r7, c28.x
pow r1, r7.w, r10.y
mad r1.y, r10.x, c32.x, r10.z
mul r0.w, r0, r1.x
mad r1.y, r1, c32, c32.z
frc r1.y, r1
mad r7.w, r1.y, c27.x, c27.y
sincos r1.xy, r7.w
mul r0.w, r0, c26
mad r0.w, r9, r9.z, r0
mul_sat r0.w, r5, r0
mul r5.w, r1.x, r1.x
mov_pp r1.xyz, c0
mul_pp r1.xyz, c9, r1
mul r1.xyz, r1, r0.w
mad r1.xyz, r0, r6.w, r1
mul r1.w, r5, c15.x
mul r0.w, r1, c15.x
mul_pp r1.w, r4, c26.x
add r0.x, -r5.w, c29.w
rcp r0.y, r0.w
mul r6.w, r0.x, r0.y
pow r0, c29.z, -r6.w
mul r0.y, r2.w, r5.w
mov r6.w, r0.x
mul r0.x, r5.w, r0.y
mul r2.w, r0.x, c32
add r5.w, -r8, c29
pow r0, r5.w, c33.x
rcp r0.y, r2.w
mul r0.z, r6.w, r0.y
mov r2.w, r0.x
texld r0.yw, v0.zwzw, s3
mad_pp r10.xy, r0.wyzw, c26.x, c26.y
mul_pp r0.y, r10, r10
mad_pp r5.w, -r10.x, r10.x, -r0.y
add_pp r5.w, r5, c29
rsq_pp r6.w, r5.w
dp3_pp r5.w, r8, r2
dp3 r2.x, r2, r6
rcp_pp r10.z, r6.w
mov_pp r0.x, c17
add_pp r0.x, c29.w, -r0
mad r0.x, r2.w, c17, r0
mul r2.w, r0.z, r0.x
texld r0, v0, s2
mul_pp r0.xyz, r0, c20
mul r2.w, r2, r0
rcp r5.w, r5.w
mul_sat r7.w, r2, r5
dp3_pp r6.w, r4, r10
dp3_pp r5.w, r8, r10
max r6.x, r2, c28
mul r2.w, r8, r6
rcp r7.x, r7.x
mul r5.w, r8, r5
mul r5.w, r5, r7.x
mul r7.x, r7, r2.w
mul r2.w, r5, c26.x
mul r5.w, r7.x, c26.x
min_sat r7.y, r2.w, r5.w
mul r2.w, r5.y, r5.y
mad r2.w, r5.x, r5.x, r2
mad r2.y, r5.z, r5.z, r2.w
rsq r2.x, r2.y
rcp r2.z, r2.x
mov_pp r2.w, c17.x
mov r2.x, c10
mul r2.y, r6.x, r6.x
mul_pp r5.w, c33.y, r2
max r5.y, r8.w, c28.x
mul r2.z, r2, c12.x
add r2.x, c29.w, -r2
mul r5.x, r2.z, r2
mul r5.z, r2.y, r5.x
pow r2, r5.y, r5.w
mul r2.y, r5.z, r5.x
mul r5.x, r2.y, c26.w
mov r6.y, r2.x
pow r2, c29.z, -r5.x
texld r5, v0, s4
mul r6.z, r5.w, r6.y
mad r5.w, -r2.x, c30.x, c30.y
mul r7.x, r6, r5.w
mul r2.y, r3, r3
mad r2.y, r3.x, r3.x, r2
dp3 r3.x, r4, r3
mad r2.x, r3.z, r3.z, r2.y
rsq r2.x, r2.x
add_pp r4.xyz, r4, r8
rcp r6.y, r2.x
add_sat r6.x, -r7, c29.w
pow r2, r6.x, c23.x
mul r2.y, r3.w, r6
mul r2.zw, -r9.xyxy, c10.x
mul r2.zw, r2, r2.y
mov r3.w, r2.x
mad r6.xy, -r2.zwzw, c13.x, v0
texld r2, r6, s10
mul r3.w, r3, c24.x
mul r2.w, r3, r2
mul_sat r3.w, r4, r2
mul r6.x, r6.z, c26.w
mad r2.w, r7, r7.y, r6.x
mul r6.xyz, r3.w, r2
mul_sat r3.x, r3, c14
mul_pp r2.xyz, r2, c0
mul r2.xyz, r3.x, r2
add r3.x, -r3, c29.w
mad r2.xyz, r3.x, c0, r2
mul r3.xyz, r6, c25
add r3.w, -r3, c29
mad r2.xyz, r3.w, r2, r3
mul_pp r3.xyz, r5, c16
mul_pp r2.xyz, r3, r2
mov_pp r3.xyz, c0
dp3_pp r3.w, r4, r4
mul_sat r2.w, r5, r2
mul_pp r3.xyz, c18, r3
mul r3.xyz, r3, r2.w
mad r2.xyz, r2, r7.x, r3
rsq_pp r2.w, r3.w
mul_pp r3.xyz, r2.w, r4
dp3_pp r2.w, r10, r3
max_pp r4.x, r2.w, c28
mov_pp r3.x, c21
mul_pp r4.y, c33, r3.x
pow r3, r4.x, r4.y
texld r2.w, v0, s5
mul r2.xyz, r1.w, r2
add_sat r2.w, r2, c19.x
mul_pp r4.xyz, r2.w, r2
add_pp r2.x, -r2.w, c29.w
mul r1.xyz, r1, r1.w
mad_pp r1.xyz, r2.x, r1, r4
mov r2.w, r3.x
mov_pp r2.xyz, c0
mul_sat r0.w, r0, r2
mul_pp r2.xyz, c1, r2
mul r2.xyz, r2, r0.w
max_pp r0.w, r6, c28.x
mul_pp r0.xyz, r0, c0
mad r0.xyz, r0, r0.w, r2
mul r2.xyz, r1.w, r0
texld r0.w, v0, s1
add_sat r0.x, r0.w, c22
mul_pp r2.xyz, r0.x, r2
add_pp r0.x, -r0, c29.w
mad_pp oC0.xyz, r0.x, r1, r2
mov_pp oC0.w, c28.x
"
}
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Vector 0 [_LightPositionRange]
Vector 1 [_LightColor0]
Vector 2 [_SpecColor]
Vector 3 [_LightShadowData]
Vector 4 [_Color3]
Float 5 [_Shininess3]
Vector 6 [_SpecColor3]
Float 7 [_Layer1Thickness]
Float 8 [_Layer2Thickness]
Float 9 [_GVar]
Float 10 [_ExitColorMultiplier]
Float 11 [_ExitColorRadius]
Float 12 [_SpecSmoothing]
Vector 13 [_Color2]
Float 14 [_Shininess2]
Vector 15 [_SpecColor2]
Float 16 [_BlendAdjust2]
Vector 17 [_Color]
Float 18 [_Shininess]
Float 19 [_BlendAdjust1]
Float 20 [_DDXP]
Float 21 [_DDXM]
Vector 22 [_SSSC]
SetTexture 0 [_MainTex3] 2D
SetTexture 1 [_ScatterMap] 2D
SetTexture 2 [_MainTex] 2D
SetTexture 3 [_BumpMap] 2D
SetTexture 4 [_MainTex2] 2D
SetTexture 5 [_ScatterMap2] 2D
SetTexture 6 [_ShadowMapTexture] CUBE
SetTexture 7 [_LightTexture0] 2D
SetTexture 8 [_BumpMap3] 2D
SetTexture 9 [_ExitColorMap] 2D
SetTexture 10 [_BumpMap2] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 342 ALU, 15 TEX
PARAM c[30] = { program.local[0..22],
		{ 0, 1, 2, 0.73550957 },
		{ -0.73550957, 0, -1, 0.99270076 },
		{ -0.99270076, 2.718282, 0.5, 0.39894229 },
		{ 0.97000003, 0.0078125, -0.0078125, 0.25 },
		{ 1, 0.0039215689, 1.53787e-005, 6.2273724e-009 },
		{ 3.141593, -0.018729299, 0.074261002, 0.21211439 },
		{ 1.570729, 3.1415927, 5, 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEMP R7;
TEMP R8;
TEMP R9;
TEMP R10;
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.x, R0.x;
MUL R4.xyz, R0.x, fragment.texcoord[1];
MUL R0.x, R4.y, R4.y;
MAD R0.x, R4, R4, R0;
MAD R0.x, R4.z, R4.z, R0;
RSQ R3.w, R0.x;
MUL R0.y, R3.w, -R4.z;
MUL R0.x, R0.y, c[23].w;
COS R0.z, R0.x;
MAD R0.y, R0, c[24].x, R0.z;
DP3 R0.x, R4, R4;
MUL R1.xy, R0.y, c[24].yzzw;
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, R4;
MAD R5.xyz, R0, c[23].w, R1.xxyw;
MUL R0.x, R5.y, R5.y;
MAD R0.x, R5, R5, R0;
MAD R0.x, R5.z, R5.z, R0;
RSQ R0.x, R0.x;
MUL R0.y, R0.x, -R5.z;
MUL R0.x, R0.y, c[24].w;
COS R0.z, R0.x;
MAD R0.y, R0, c[25].x, R0.z;
DP3 R0.x, R5, R5;
RSQ R0.x, R0.x;
MUL R6.xyz, R0.x, R5;
ADD R5.xyz, -R5, R4;
MUL R0.zw, R0.y, c[24].xyyz;
MAD R0.xyz, R6, c[24].w, R0.zzww;
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R1.xyz, R0.w, R0;
MAD R2.xyz, -R6, c[7].x, R4;
MAD R8.xyz, -R1, c[8].x, R2;
DP3 R0.w, R8, R8;
TEX R2.yw, fragment.texcoord[0].zwzw, texture[8], 2D;
RSQ R0.w, R0.w;
MUL R1.xyz, R0.w, R8;
MUL R5.y, R5, R5;
MAD R5.x, R5, R5, R5.y;
DP3 R0.w, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.w, R0.w;
MAD R3.xy, R2.wyzw, c[23].z, -c[23].y;
MUL R9.xyz, R0.w, fragment.texcoord[2];
ADD R2.xyz, R1, R9;
DP3 R1.w, R2, R2;
MUL R0.w, R3.y, R3.y;
MAD R0.w, -R3.x, R3.x, -R0;
RSQ R1.w, R1.w;
ADD R0.w, R0, c[23].y;
RSQ R0.w, R0.w;
ADD R0.xyz, -R0, R4;
MUL R10.xyz, R1.w, R2;
RCP R3.z, R0.w;
DP3 R8.w, R3, R10;
ABS R0.w, R8;
MUL R2.x, R0.y, R0.y;
DP3 R0.y, R3, R1;
MAD R1.x, R0, R0, R2;
MAX R0.x, R0.y, c[23];
MAD R0.y, R0.z, R0.z, R1.x;
MAD R1.w, R0, c[28].y, c[28].z;
MAD R1.w, R1, R0, -c[28];
MOV R0.z, c[7].x;
RSQ R0.y, R0.y;
ADD R0.z, -R0, -c[8].x;
RCP R0.y, R0.y;
ADD R2.xyz, fragment.texcoord[4], c[26].zzyw;
TEX R2, R2, texture[6], CUBE;
DP4 R7.y, R2, c[27];
DP3 R2.y, R8, R4;
DP3 R2.x, fragment.texcoord[4], fragment.texcoord[4];
MAD R1.x, R1.w, R0.w, c[29];
MOV R2.w, c[23].y;
MUL R0.y, R0, c[9].x;
ADD R0.z, R0, c[23];
MUL R0.z, R0.y, R0;
MUL R0.y, R0.x, R0.x;
MUL R0.y, R0, R0.z;
MUL R0.y, R0, R0.z;
ADD R0.z, -R0.w, c[23].y;
MUL R0.y, R0, c[25].z;
RSQ R0.z, R0.z;
RCP R0.z, R0.z;
POW R0.y, c[25].y, -R0.y;
MUL R0.y, -R0, c[25].w;
ADD R4.w, R0.y, c[23].y;
MUL R5.w, R0.x, R4;
MUL R0.y, R8, R8;
MAD R0.y, R8.x, R8.x, R0;
ADD_SAT R0.x, -R5.w, c[23].y;
MAD R0.y, R8.z, R8.z, R0;
POW R0.x, R0.x, c[20].x;
MUL R9.w, R1.x, R0.z;
RSQ R0.y, R0.y;
RCP R0.z, R0.y;
MUL R10.w, R0.x, c[21].x;
ADD R0.xy, R8, -R4;
MUL R0.z, R3.w, R0;
MUL R0.xy, R0, c[8].x;
MUL R1.xy, R0, R0.z;
ADD R0.xyz, fragment.texcoord[4], c[26].yzzw;
TEX R0, R0, texture[6], CUBE;
DP4 R7.w, R0, c[27];
MAD R1.xy, -R1, c[10].x, fragment.texcoord[0];
ADD R0.xyz, fragment.texcoord[4], c[26].zyzw;
TEX R0, R0, texture[6], CUBE;
DP4 R7.z, R0, c[27];
ADD R0.xyz, fragment.texcoord[4], c[26].y;
TEX R0, R0, texture[6], CUBE;
TEX R1, R1, texture[9], 2D;
DP4 R7.x, R0, c[27];
RSQ R2.x, R2.x;
RCP R0.x, R2.x;
MUL R0.x, R0, c[0].w;
MAD R0, -R0.x, c[26].x, R7;
CMP R0, R0, c[3].x, R2.w;
DP4 R0.x, R0, c[26].w;
DP3 R2.x, fragment.texcoord[3], fragment.texcoord[3];
TEX R0.w, R2.x, texture[7], 2D;
MUL R6.w, R0, R0.x;
MUL R0.x, R10.w, R1.w;
MUL_SAT R2.x, R0, R6.w;
MUL R0.xyz, R2.x, R1;
SLT R1.w, R8, c[23].x;
MUL R0.w, R1, R9;
MOV R7.w, c[29];
MUL_SAT R2.y, R2, c[11].x;
MUL R1.xyz, R1, c[1];
MUL R1.xyz, R2.y, R1;
ADD R2.y, -R2, c[23];
MAD R1.xyz, R2.y, c[1], R1;
MUL R0.xyz, R0, c[22];
ADD R2.x, -R2, c[23].y;
MAD R1.xyz, R2.x, R1, R0;
MAD R2.x, -R0.w, c[23].z, R9.w;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0.xyz, R0, c[4];
MUL R0.xyz, R0, R1;
MAD R1.w, R1, c[28].x, R2.x;
COS R1.x, R1.w;
MUL R1.x, R1, R1;
MUL R9.w, c[12].x, c[12].x;
MUL R1.z, R1.x, R9.w;
MUL R1.y, R1.x, c[12].x;
MUL R1.z, R1.x, R1;
MUL R1.y, R1, c[12].x;
MUL R1.z, R1, c[29].y;
RCP R1.y, R1.y;
ADD R1.x, -R1, c[23].y;
MUL R1.x, R1, R1.y;
RCP R1.y, R1.z;
MOV R1.w, c[23].y;
ADD R1.z, R1.w, -c[5].x;
POW R1.x, c[25].y, -R1.x;
MUL R1.x, R1, R1.y;
ADD R1.y, -R8.w, c[23];
POW R1.y, R1.y, c[29].z;
MAD R1.y, R1, c[5].x, R1.z;
MUL R1.x, R1, R1.y;
DP3 R1.z, R3, R9;
RCP R1.y, R1.z;
MUL R1.x, R0.w, R1;
MUL_SAT R2.x, R1, R1.y;
DP3 R1.y, R3, R4;
DP3 R1.x, R10, R9;
MUL R10.xyz, R6, c[7].x;
MUL R2.y, R8.w, R1;
RCP R1.y, R1.x;
MUL R1.x, R8.w, R1.z;
MUL R1.x, R1, R1.y;
MUL R1.y, R1, R2;
ADD R7.xyz, R4, -R10;
MUL R1.x, R1, c[23].z;
MUL R1.y, R1, c[23].z;
MIN_SAT R2.y, R1.x, R1;
MAX R1.x, R8.w, c[23];
TEX R8.yw, fragment.texcoord[0].zwzw, texture[10], 2D;
MAD R3.xy, R8.wyzw, c[23].z, -c[23].y;
MUL R1.y, R7.w, c[5].x;
POW R1.x, R1.x, R1.y;
MUL R0.w, R0, R1.x;
MUL R2.z, R3.y, R3.y;
MAD R2.z, -R3.x, R3.x, -R2;
MUL R0.w, R0, c[25].z;
MAD R0.w, R2.x, R2.y, R0;
DP3 R1.x, R7, R7;
RSQ R1.x, R1.x;
MUL R8.xyz, R1.x, R7;
ADD R1.xyz, R9, R8;
DP3 R3.z, R1, R1;
RSQ R3.z, R3.z;
ADD R2.z, R2, c[23].y;
MUL R1.xyz, R3.z, R1;
RSQ R2.z, R2.z;
RCP R3.z, R2.z;
DP3 R8.w, R3, R1;
ABS R2.x, R8.w;
MUL_SAT R6.x, R4.w, R0.w;
DP3 R1.x, R9, R1;
ADD R2.y, -R2.x, c[23];
MAD R0.w, R2.x, c[28].y, c[28].z;
MAD R0.w, R0, R2.x, -c[28];
RSQ R2.y, R2.y;
MAD R0.w, R0, R2.x, c[29].x;
RCP R2.y, R2.y;
MUL R4.w, R0, R2.y;
SLT R0.w, R8, c[23].x;
MUL R6.y, R0.w, R4.w;
MAD R4.w, -R6.y, c[23].z, R4;
MAD R0.w, R0, c[28].x, R4;
MOV R2.xyz, c[6];
MUL R2.xyz, R2, c[1];
MUL R2.xyz, R2, R6.x;
MAD R0.xyz, R0, R5.w, R2;
DP3 R5.w, R9, R3;
DP3 R3.x, R3, R8;
MUL R4.w, R6, c[23].z;
MAD R5.x, R5.z, R5.z, R5;
RSQ R3.y, R5.x;
COS R0.w, R0.w;
MOV R5.xyz, c[15];
MUL R0.w, R0, R0;
MUL R6.xyz, R0, R4.w;
MUL R0.y, R9.w, R0.w;
MUL R0.x, R0.w, c[12];
MUL R0.z, R0.w, R0.y;
MUL R0.x, R0, c[12];
RCP R0.y, R0.x;
ADD R0.x, -R0.w, c[23].y;
MUL R0.x, R0, R0.y;
MUL R0.y, R0.z, c[29];
ADD R0.z, -R8.w, c[23].y;
MAX R3.x, R3, c[23];
ADD R3.z, R2.w, -c[7].x;
RCP R3.y, R3.y;
MUL R2.w, R3.y, c[9].x;
MUL R3.y, R2.w, R3.z;
MUL R2.w, R3.x, R3.x;
MUL R2.w, R2, R3.y;
RCP R0.y, R0.y;
POW R0.x, c[25].y, -R0.x;
MUL R0.x, R0, R0.y;
TEX R0.yw, fragment.texcoord[0].zwzw, texture[3], 2D;
MAD R2.xy, R0.wyzw, c[23].z, -c[23].y;
POW R0.z, R0.z, c[29].z;
ADD R1.w, R1, -c[14].x;
MAD R0.y, R0.z, c[14].x, R1.w;
MUL R0.z, R2.y, R2.y;
MAD R2.z, -R2.x, R2.x, -R0;
MUL R1.w, R0.x, R0.y;
TEX R0, fragment.texcoord[0], texture[2], 2D;
ADD R2.z, R2, c[23].y;
RSQ R2.z, R2.z;
RCP R2.z, R2.z;
MUL R0.xyz, R0, c[17];
MUL R1.w, R1, R0;
RCP R5.w, R5.w;
MUL_SAT R9.w, R1, R5;
DP3 R10.z, R9, R2;
DP3 R5.w, R4, R2;
MUL R1.w, R8, R10.z;
MUL R1.y, R8.w, R5.w;
RCP R1.x, R1.x;
MUL R1.y, R1.x, R1;
MUL R1.x, R1.w, R1;
MUL R1.y, R1, c[23].z;
MUL R1.x, R1, c[23].z;
MIN_SAT R10.z, R1.x, R1.y;
MAX R1.x, R8.w, c[23];
MUL R1.y, R7.w, c[14].x;
POW R8.w, R1.x, R1.y;
TEX R1, fragment.texcoord[0], texture[4], 2D;
MUL R1.w, R1, R8;
MUL R1.w, R1, c[25].z;
MAD R3.z, R9.w, R10, R1.w;
MUL R1.w, R2, R3.y;
MUL R2.w, R7.y, R7.y;
MUL R1.w, R1, c[25].z;
MAD R2.w, R7.x, R7.x, R2;
POW R1.w, c[25].y, -R1.w;
MAD R2.w, R7.z, R7.z, R2;
MUL R1.w, -R1, c[25];
ADD R1.w, R1, c[23].y;
MUL_SAT R8.x, R1.w, R3.z;
MUL R1.w, R3.x, R1;
MUL R5.xyz, R5, c[1];
RSQ R2.w, R2.w;
RCP R2.w, R2.w;
MUL R2.w, R3, R2;
MUL R3.xy, -R10, c[7].x;
MUL R3.xy, R3, R2.w;
ADD_SAT R2.w, -R1, c[23].y;
MAD R3.xy, -R3, c[10].x, fragment.texcoord[0];
POW R2.w, R2.w, c[20].x;
TEX R3, R3, texture[9], 2D;
MUL R2.w, R2, c[21].x;
MUL R2.w, R2, R3;
DP3 R3.w, R4, R7;
MUL_SAT R2.w, R6, R2;
MUL R8.xyz, R5, R8.x;
MUL R5.xyz, R2.w, R3;
MUL_SAT R3.w, R3, c[11].x;
MUL R3.xyz, R3, c[1];
MUL R3.xyz, R3.w, R3;
ADD R3.w, -R3, c[23].y;
ADD R2.w, -R2, c[23].y;
MAD R3.xyz, R3.w, c[1], R3;
MUL R5.xyz, R5, c[22];
MAD R3.xyz, R2.w, R3, R5;
MUL R1.xyz, R1, c[13];
MUL R1.xyz, R1, R3;
MAD R1.xyz, R1, R1.w, R8;
ADD R3.xyz, R4, R9;
DP3 R2.w, R3, R3;
TEX R1.w, fragment.texcoord[0], texture[5], 2D;
RSQ R2.w, R2.w;
ADD_SAT R1.w, R1, c[16].x;
MUL R1.xyz, R4.w, R1;
MUL R1.xyz, R1.w, R1;
ADD R1.w, -R1, c[23].y;
MAD R1.xyz, R1.w, R6, R1;
MUL R3.xyz, R2.w, R3;
DP3 R1.w, R2, R3;
MUL R2.x, R7.w, c[18];
MAX R1.w, R1, c[23].x;
POW R1.w, R1.w, R2.x;
MOV R2.xyz, c[2];
MUL_SAT R0.w, R0, R1;
MUL R2.xyz, R2, c[1];
MUL R2.xyz, R2, R0.w;
MAX R0.w, R5, c[23].x;
MUL R0.xyz, R0, c[1];
MAD R0.xyz, R0, R0.w, R2;
MUL R2.xyz, R4.w, R0;
TEX R0.w, fragment.texcoord[0], texture[1], 2D;
ADD_SAT R0.x, R0.w, c[19];
MUL R2.xyz, R0.x, R2;
ADD R0.x, -R0, c[23].y;
MAD result.color.xyz, R0.x, R1, R2;
MOV result.color.w, c[23].x;
END
# 342 instructions, 11 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Vector 0 [_LightPositionRange]
Vector 1 [_LightColor0]
Vector 2 [_SpecColor]
Vector 3 [_LightShadowData]
Vector 4 [_Color3]
Float 5 [_Shininess3]
Vector 6 [_SpecColor3]
Float 7 [_Layer1Thickness]
Float 8 [_Layer2Thickness]
Float 9 [_GVar]
Float 10 [_ExitColorMultiplier]
Float 11 [_ExitColorRadius]
Float 12 [_SpecSmoothing]
Vector 13 [_Color2]
Float 14 [_Shininess2]
Vector 15 [_SpecColor2]
Float 16 [_BlendAdjust2]
Vector 17 [_Color]
Float 18 [_Shininess]
Float 19 [_BlendAdjust1]
Float 20 [_DDXP]
Float 21 [_DDXM]
Vector 22 [_SSSC]
SetTexture 0 [_MainTex3] 2D
SetTexture 1 [_ScatterMap] 2D
SetTexture 2 [_MainTex] 2D
SetTexture 3 [_BumpMap] 2D
SetTexture 4 [_MainTex2] 2D
SetTexture 5 [_ScatterMap2] 2D
SetTexture 6 [_ShadowMapTexture] CUBE
SetTexture 7 [_LightTexture0] 2D
SetTexture 8 [_BumpMap3] 2D
SetTexture 9 [_ExitColorMap] 2D
SetTexture 10 [_BumpMap2] 2D
"ps_3_0
; 395 ALU, 15 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_cube s6
dcl_2d s7
dcl_2d s8
dcl_2d s9
dcl_2d s10
def c23, 2.00000000, -1.00000000, 0.11705996, 0.50000000
def c24, 6.28318501, -3.14159298, -0.73550957, 0.73550957
def c25, 0.00000000, -1.00000000, 0.15799320, 0.50000000
def c26, -0.99270076, 0.99270076, 2.71828198, 0.00781250
def c27, 0.39894229, 1.00000000, 0.00781250, -0.00781250
def c28, 1.00000000, 0.00392157, 0.00001538, 0.00000001
def c29, 0.97000003, 0.25000000, 0.00000000, 1.00000000
def c30, -0.01872930, 0.07426100, -0.21211439, 1.57072902
def c31, 3.14159298, 0.15915491, 0.50000000, 3.14159274
def c32, 5.00000000, 128.00000000, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dp3_pp r0.x, v1, v1
rsq_pp r0.x, r0.x
mul_pp r4.xyz, r0.x, v1
mul r0.x, r4.y, r4.y
mad r0.x, r4, r4, r0
mad r0.x, r4.z, r4.z, r0
rsq r3.w, r0.x
mul r1.x, r3.w, -r4.z
mad r0.x, r1, c23.z, c23.w
frc r0.x, r0
mad r1.y, r0.x, c24.x, c24
sincos r0.xy, r1.y
mad r0.z, r1.x, c24, r0.x
dp3 r0.y, r4, r4
mul r1.xy, r0.z, c25
rsq r0.x, r0.y
mul r0.xyz, r0.x, r4
mad r5.xyz, r0, c24.w, r1.xxyw
mul r0.x, r5.y, r5.y
mad r0.x, r5, r5, r0
mad r0.x, r5.z, r5.z, r0
rsq r0.x, r0.x
mul r1.x, r0, -r5.z
mad r0.x, r1, c25.z, c25.w
frc r0.x, r0
mad r1.y, r0.x, c24.x, c24
sincos r0.xy, r1.y
mad r0.z, r1.x, c26.x, r0.x
dp3 r0.y, r5, r5
rsq r0.x, r0.y
mul r6.xyz, r0.x, r5
mul r0.zw, r0.z, c25.xyxy
mad r0.xyz, r6, c26.y, r0.zzww
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, r0
mad r2.xyz, -r6, c7.x, r4
mad r7.xyz, -r1, c8.x, r2
texld r2.yw, v0.zwzw, s8
dp3 r0.w, r7, r7
rsq r0.w, r0.w
mul r1.xyz, r0.w, r7
dp3_pp r0.w, v2, v2
rsq_pp r0.w, r0.w
add r5.xyz, -r5, r4
mad_pp r3.xy, r2.wyzw, c23.x, c23.y
mul_pp r9.xyz, r0.w, v2
add r2.xyz, r1, r9
dp3 r1.w, r2, r2
mul_pp r0.w, r3.y, r3.y
mad_pp r0.w, -r3.x, r3.x, -r0
rsq r1.w, r1.w
add_pp r0.w, r0, c27.y
rsq_pp r0.w, r0.w
add r0.xyz, -r0, r4
mul r10.xyz, r1.w, r2
rcp_pp r3.z, r0.w
dp3 r6.w, r3, r10
abs r0.w, r6
add r2.x, -r0.w, c27.y
mad r1.w, r0, c30.x, c30.y
mad r1.w, r1, r0, c30.z
mad r0.w, r1, r0, c30
rsq r2.x, r2.x
rcp r2.x, r2.x
mul r0.w, r0, r2.x
mul r2.x, r0.y, r0.y
dp3 r0.y, r3, r1
mad r0.x, r0, r0, r2
max r1.x, r0.y, c25
mad r0.y, r0.z, r0.z, r0.x
mov r0.x, c8
add r2.xyz, v4, c27.wwzw
texld r2, r2, s6
dp4 r8.y, r2, c28
dp3 r2.x, v4, v4
cmp r1.w, r6, c29.z, c29
add r0.z, -c7.x, -r0.x
rsq r0.y, r0.y
rcp r0.x, r0.y
add r0.y, r0.z, c23.x
mul r0.x, r0, c9
mul r0.y, r0.x, r0
mul r0.x, r1, r1
mul r0.x, r0, r0.y
mul r0.x, r0, r0.y
mul r0.z, r1.w, r0.w
mad r0.y, -r0.z, c23.x, r0.w
mad r1.z, r1.w, c31.x, r0.y
mul r1.y, r0.x, c23.w
pow r0, c26.z, -r1.y
mad r0.y, r1.z, c31, c31.z
mad r4.w, -r0.x, c27.x, c27.y
mul r5.w, r1.x, r4
frc r0.y, r0
mad r0.y, r0, c24.x, c24
sincos r11.xy, r0.y
add_sat r1.x, -r5.w, c27.y
pow r0, r1.x, c20.x
mul r1.y, r7, r7
mad r0.y, r7.x, r7.x, r1
mad r0.y, r7.z, r7.z, r0
rsq r0.y, r0.y
rcp r0.z, r0.y
mul r9.w, r0.x, c21.x
add r0.xy, r7, -r4
mul r0.z, r3.w, r0
mul r0.xy, r0, c8.x
mul r1.xy, r0, r0.z
add r0.xyz, v4, c27.zwww
texld r0, r0, s6
dp4 r8.w, r0, c28
mad r1.xy, -r1, c10.x, v0
add r0.xyz, v4, c27.wzww
texld r0, r0, s6
dp4 r8.z, r0, c28
add r0.xyz, v4, c26.w
texld r0, r0, s6
texld r1, r1, s9
dp4 r8.x, r0, c28
rsq r2.x, r2.x
rcp r0.x, r2.x
mul r0.x, r0, c0.w
mad r0, -r0.x, c29.x, r8
mov r2.x, c3
cmp r2, r0, c27.y, r2.x
dp4_pp r0.y, r2, c29.y
dp3 r0.x, v3, v3
texld r0.x, r0.x, s7
mul r7.w, r0.x, r0.y
mul r0.x, r9.w, r1.w
mul_sat r0.w, r0.x, r7
mul r0.xyz, r0.w, r1
dp3 r1.w, r7, r4
mul r2.x, r11, r11
mul r8.xyz, r6, c7.x
mul r2.w, c12.x, c12.x
add r2.z, -r6.w, c27.y
mul_sat r1.w, r1, c11.x
mul_pp r1.xyz, r1, c1
mul r1.xyz, r1.w, r1
add r1.w, -r1, c27.y
mad r1.xyz, r1.w, c1, r1
mul r1.w, r2.x, c12.x
mul r0.xyz, r0, c22
add r0.w, -r0, c27.y
mad r1.xyz, r0.w, r1, r0
texld r0, v0, s0
mul_pp r0.xyz, r0, c4
mul_pp r0.xyz, r0, r1
mul r1.w, r1, c12.x
add r1.x, -r2, c27.y
rcp r1.y, r1.w
mul r2.y, r1.x, r1
pow r1, c26.z, -r2.y
mul r1.y, r2.x, r2.w
mul r1.y, r2.x, r1
mov r2.y, r1.x
mul r1.x, r1.y, c31.w
rcp r2.x, r1.x
pow r1, r2.z, c32.x
mov_pp r1.y, c5.x
add_pp r1.y, c27, -r1
mad r1.y, r1.x, c5.x, r1
mul r1.x, r2.y, r2
mul r1.x, r1, r1.y
dp3_pp r1.y, r3, r9
dp3_pp r1.w, r10, r9
mul r1.x, r0.w, r1
rcp r1.z, r1.y
mul_sat r8.w, r1.x, r1.z
mul r1.x, r6.w, r1.y
rcp r1.z, r1.w
mul r1.x, r1, r1.z
dp3_pp r1.y, r3, r4
mul r9.w, r1.x, c23.x
mul r1.x, r6.w, r1.y
mul r1.x, r1.z, r1
mul r10.x, r1, c23
add r3.xyz, r4, -r8
dp3 r1.x, r3, r3
texld r1.yw, v0.zwzw, s10
mad_pp r2.xy, r1.wyzw, c23.x, c23.y
rsq r1.x, r1.x
mul r6.xyz, r1.x, r3
add r1.xyz, r9, r6
dp3 r2.z, r1, r1
mul_pp r1.w, r2.y, r2.y
mad_pp r1.w, -r2.x, r2.x, -r1
rsq r2.z, r2.z
add_pp r1.w, r1, c27.y
mul r7.xyz, r2.z, r1
rsq_pp r1.w, r1.w
rcp_pp r2.z, r1.w
dp3 r8.z, r2, r7
abs r1.x, r8.z
min_sat r9.w, r9, r10.x
add r1.z, -r1.x, c27.y
mad r1.y, r1.x, c30.x, c30
mad r1.y, r1, r1.x, c30.z
dp3_pp r7.x, r9, r7
rsq r1.z, r1.z
mad r1.x, r1.y, r1, c30.w
rcp r1.z, r1.z
mul r1.y, r1.x, r1.z
cmp r10.x, r8.z, c29.z, c29.w
mul r1.z, r10.x, r1.y
mov_pp r1.x, c5
mul_pp r10.y, c32, r1.x
mad r10.z, -r1, c23.x, r1.y
max r6.w, r6, c25.x
pow r1, r6.w, r10.y
mad r1.y, r10.x, c31.x, r10.z
mul r0.w, r0, r1.x
mad r1.y, r1, c31, c31.z
frc r1.y, r1
mad r6.w, r1.y, c24.x, c24.y
sincos r1.xy, r6.w
mul r0.w, r0, c23
mad r0.w, r8, r9, r0
mul_sat r0.w, r4, r0
mul r4.w, r1.x, r1.x
mov_pp r1.xyz, c1
mul_pp r1.xyz, c6, r1
mul r1.xyz, r1, r0.w
mad r1.xyz, r0, r5.w, r1
mul r1.w, r4, c12.x
mul r0.w, r1, c12.x
mul_pp r1.w, r7, c23.x
add r0.x, -r4.w, c27.y
rcp r0.y, r0.w
mul r5.w, r0.x, r0.y
pow r0, c26.z, -r5.w
mul r0.y, r2.w, r4.w
mov r5.w, r0.x
mul r0.x, r4.w, r0.y
mul r2.w, r0.x, c31
add r4.w, -r8.z, c27.y
pow r0, r4.w, c32.x
rcp r0.y, r2.w
mul r0.z, r5.w, r0.y
mov r2.w, r0.x
texld r0.yw, v0.zwzw, s3
mad_pp r10.xy, r0.wyzw, c23.x, c23.y
mul_pp r0.y, r10, r10
mad_pp r4.w, -r10.x, r10.x, -r0.y
add_pp r4.w, r4, c27.y
rsq_pp r5.w, r4.w
dp3_pp r4.w, r9, r2
dp3 r2.x, r2, r6
rcp_pp r10.z, r5.w
rcp r5.w, r4.w
mov_pp r0.x, c14
add_pp r0.x, c27.y, -r0
mad r0.x, r2.w, c14, r0
mul r2.w, r0.z, r0.x
texld r0, v0, s2
mul r2.w, r2, r0
mul_sat r6.w, r2, r5
dp3_pp r4.w, r4, r10
dp3_pp r5.w, r9, r10
mul_pp r0.xyz, r0, c17
max r6.x, r2, c25
mul r2.w, r8.z, r4
rcp r7.x, r7.x
mul r5.w, r8.z, r5
mul r5.w, r5, r7.x
mul r7.x, r7, r2.w
mul r2.w, r5, c23.x
mul r5.w, r7.x, c23.x
min_sat r7.y, r2.w, r5.w
mul r2.w, r5.y, r5.y
mad r2.w, r5.x, r5.x, r2
mad r2.y, r5.z, r5.z, r2.w
rsq r2.x, r2.y
rcp r2.z, r2.x
mov_pp r2.w, c14.x
mov r2.x, c7
mul r2.y, r6.x, r6.x
mul_pp r5.w, c32.y, r2
max r5.y, r8.z, c25.x
mul r2.z, r2, c9.x
add r2.x, c27.y, -r2
mul r5.x, r2.z, r2
mul r5.z, r2.y, r5.x
pow r2, r5.y, r5.w
mul r2.y, r5.z, r5.x
mul r5.x, r2.y, c23.w
mov r6.y, r2.x
pow r2, c26.z, -r5.x
texld r5, v0, s4
mul r6.z, r5.w, r6.y
mad r5.w, -r2.x, c27.x, c27.y
mul r7.x, r6, r5.w
mul r2.y, r3, r3
mad r2.y, r3.x, r3.x, r2
dp3 r3.x, r4, r3
mad r2.x, r3.z, r3.z, r2.y
rsq r2.x, r2.x
add_pp r4.xyz, r4, r9
rcp r6.y, r2.x
add_sat r6.x, -r7, c27.y
pow r2, r6.x, c20.x
mul r2.y, r3.w, r6
mul r2.zw, -r8.xyxy, c7.x
mul r2.zw, r2, r2.y
mov r3.w, r2.x
mad r6.xy, -r2.zwzw, c10.x, v0
texld r2, r6, s9
mul r3.w, r3, c21.x
mul r2.w, r3, r2
mul_sat r3.w, r7, r2
mul r6.x, r6.z, c23.w
mad r2.w, r6, r7.y, r6.x
mul r6.xyz, r3.w, r2
mul_sat r3.x, r3, c11
mul_pp r2.xyz, r2, c1
mul r2.xyz, r3.x, r2
add r3.x, -r3, c27.y
mad r2.xyz, r3.x, c1, r2
mul r3.xyz, r6, c22
add r3.w, -r3, c27.y
mad r2.xyz, r3.w, r2, r3
mul_pp r3.xyz, r5, c13
mul_pp r2.xyz, r3, r2
mov_pp r3.xyz, c1
dp3_pp r3.w, r4, r4
mul_sat r2.w, r5, r2
mul_pp r3.xyz, c15, r3
mul r3.xyz, r3, r2.w
mad r2.xyz, r2, r7.x, r3
rsq_pp r2.w, r3.w
mul_pp r3.xyz, r2.w, r4
dp3_pp r2.w, r10, r3
max_pp r4.x, r2.w, c25
mov_pp r3.x, c18
mul_pp r4.y, c32, r3.x
pow r3, r4.x, r4.y
texld r2.w, v0, s5
mul r2.xyz, r1.w, r2
add_sat r2.w, r2, c16.x
mul_pp r4.xyz, r2.w, r2
add_pp r2.x, -r2.w, c27.y
mul r1.xyz, r1, r1.w
mad_pp r1.xyz, r2.x, r1, r4
mov r2.w, r3.x
mov_pp r2.xyz, c1
mul_sat r0.w, r0, r2
mul_pp r2.xyz, c2, r2
mul r2.xyz, r2, r0.w
max_pp r0.w, r4, c25.x
mul_pp r0.xyz, r0, c1
mad r0.xyz, r0, r0.w, r2
mul r2.xyz, r1.w, r0
texld r0.w, v0, s1
add_sat r0.x, r0.w, c19
mul_pp r2.xyz, r0.x, r2
add_pp r0.x, -r0, c27.y
mad_pp oC0.xyz, r0.x, r1, r2
mov_pp oC0.w, c25.x
"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Vector 0 [_LightPositionRange]
Vector 1 [_LightColor0]
Vector 2 [_SpecColor]
Vector 3 [_LightShadowData]
Vector 4 [_Color3]
Float 5 [_Shininess3]
Vector 6 [_SpecColor3]
Float 7 [_Layer1Thickness]
Float 8 [_Layer2Thickness]
Float 9 [_GVar]
Float 10 [_ExitColorMultiplier]
Float 11 [_ExitColorRadius]
Float 12 [_SpecSmoothing]
Vector 13 [_Color2]
Float 14 [_Shininess2]
Vector 15 [_SpecColor2]
Float 16 [_BlendAdjust2]
Vector 17 [_Color]
Float 18 [_Shininess]
Float 19 [_BlendAdjust1]
Float 20 [_DDXP]
Float 21 [_DDXM]
Vector 22 [_SSSC]
SetTexture 0 [_MainTex3] 2D
SetTexture 1 [_ScatterMap] 2D
SetTexture 2 [_MainTex] 2D
SetTexture 3 [_BumpMap] 2D
SetTexture 4 [_MainTex2] 2D
SetTexture 5 [_ScatterMap2] 2D
SetTexture 6 [_ShadowMapTexture] CUBE
SetTexture 7 [_LightTextureB0] 2D
SetTexture 8 [_LightTexture0] CUBE
SetTexture 9 [_BumpMap3] 2D
SetTexture 10 [_ExitColorMap] 2D
SetTexture 11 [_BumpMap2] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 344 ALU, 16 TEX
PARAM c[30] = { program.local[0..22],
		{ 0, 1, 2, 0.73550957 },
		{ -0.73550957, 0, -1, 0.99270076 },
		{ -0.99270076, 2.718282, 0.5, 0.39894229 },
		{ 0.97000003, 0.0078125, -0.0078125, 0.25 },
		{ 1, 0.0039215689, 1.53787e-005, 6.2273724e-009 },
		{ 3.141593, -0.018729299, 0.074261002, 0.21211439 },
		{ 1.570729, 3.1415927, 5, 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEMP R7;
TEMP R8;
TEMP R9;
TEMP R10;
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.x, R0.x;
MUL R2.xyz, R0.x, fragment.texcoord[1];
MUL R0.x, R2.y, R2.y;
MAD R0.x, R2, R2, R0;
MAD R0.x, R2.z, R2.z, R0;
RSQ R1.w, R0.x;
MUL R0.y, R1.w, -R2.z;
MUL R0.x, R0.y, c[23].w;
DP3 R0.z, R2, R2;
RSQ R0.z, R0.z;
COS R0.x, R0.x;
MAD R0.x, R0.y, c[24], R0;
MUL R0.xy, R0.x, c[24].yzzw;
MUL R1.xyz, R0.z, R2;
MAD R1.xyz, R1, c[23].w, R0.xxyw;
MUL R0.x, R1.y, R1.y;
MAD R0.x, R1, R1, R0;
MAD R0.x, R1.z, R1.z, R0;
RSQ R0.x, R0.x;
MUL R0.y, R0.x, -R1.z;
MUL R0.x, R0.y, c[24].w;
DP3 R0.z, R1, R1;
RSQ R0.z, R0.z;
MUL R4.xyz, R0.z, R1;
COS R0.x, R0.x;
MAD R0.x, R0.y, c[25], R0;
MUL R0.xy, R0.x, c[24].yzzw;
MAD R7.xyz, R4, c[24].w, R0.xxyw;
DP3 R0.x, R7, R7;
RSQ R0.w, R0.x;
MUL R3.xyz, R0.w, R7;
MAD R0.xyz, -R4, c[7].x, R2;
MAD R6.xyz, -R3, c[8].x, R0;
DP3 R0.x, R6, R6;
RSQ R0.x, R0.x;
MUL R9.xyz, R0.x, R6;
DP3 R0.x, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.z, R0.x;
MUL R3.xyz, R0.z, fragment.texcoord[2];
TEX R0.yw, fragment.texcoord[0].zwzw, texture[9], 2D;
MAD R0.xy, R0.wyzw, c[23].z, -c[23].y;
MUL R0.z, R0.y, R0.y;
MAD R0.w, -R0.x, R0.x, -R0.z;
ADD R5.xyz, R9, R3;
DP3 R0.z, R5, R5;
RSQ R0.z, R0.z;
ADD R0.w, R0, c[23].y;
ADD R1.xyz, -R1, R2;
MUL R5.xyz, R0.z, R5;
RSQ R0.w, R0.w;
RCP R0.z, R0.w;
DP3 R8.x, R0, R5;
DP3 R5.w, R0, R9;
ABS R2.w, R8.x;
MAD R0.w, R2, c[28].y, c[28].z;
MAD R3.w, R0, R2, -c[28];
ADD R7.xyz, -R7, R2;
MAD R3.w, R3, R2, c[29].x;
MUL R0.w, R7.y, R7.y;
MAD R4.w, R7.x, R7.x, R0;
ADD R7.xy, R6, -R2;
MAX R0.w, R5, c[23].x;
MAD R5.w, R7.z, R7.z, R4;
MUL R8.zw, R7.xyxy, c[8].x;
MOV R4.w, c[7].x;
RSQ R5.w, R5.w;
ADD R4.w, -R4, -c[8].x;
RCP R5.w, R5.w;
ADD R2.w, -R2, c[23].y;
RSQ R2.w, R2.w;
RCP R2.w, R2.w;
MUL R6.w, R3, R2;
MUL R2.w, R6.y, R6.y;
MAD R2.w, R6.x, R6.x, R2;
MAD R2.w, R6.z, R6.z, R2;
RSQ R2.w, R2.w;
RCP R2.w, R2.w;
MUL R2.w, R1, R2;
MUL R8.zw, R8, R2.w;
ADD R7.xyz, fragment.texcoord[4], c[26].yzzw;
TEX R7, R7, texture[6], CUBE;
DP4 R7.w, R7, c[27];
ADD R7.xyz, fragment.texcoord[4], c[26].zzyw;
TEX R10, R7, texture[6], CUBE;
DP4 R7.y, R10, c[27];
MUL R10.xyz, R4, c[7].x;
ADD R9.xyz, fragment.texcoord[4], c[26].zyzw;
TEX R9, R9, texture[6], CUBE;
DP4 R7.z, R9, c[27];
ADD R9.xyz, fragment.texcoord[4], c[26].y;
TEX R9, R9, texture[6], CUBE;
DP3 R2.w, fragment.texcoord[4], fragment.texcoord[4];
RSQ R2.w, R2.w;
RCP R2.w, R2.w;
ADD R4.xyz, R2, -R10;
MAD R8.zw, -R8, c[10].x, fragment.texcoord[0].xyxy;
ADD R4.w, R4, c[23].z;
MUL R5.w, R5, c[9].x;
MUL R5.w, R5, R4;
MUL R4.w, R0, R0;
MUL R4.w, R4, R5;
MUL R4.w, R4, R5;
MUL R4.w, R4, c[25].z;
POW R4.w, c[25].y, -R4.w;
MUL R4.w, -R4, c[25];
ADD R5.w, R4, c[23].y;
MUL R0.w, R0, R5;
ADD_SAT R3.w, -R0, c[23].y;
POW R3.w, R3.w, c[20].x;
MUL R8.y, R3.w, c[21].x;
DP3 R4.w, fragment.texcoord[3], fragment.texcoord[3];
MOV R3.w, c[23].y;
DP4 R7.x, R9, c[27];
MUL R2.w, R2, c[0];
MAD R7, -R2.w, c[26].x, R7;
CMP R9, R7, c[3].x, R3.w;
TEX R7, R8.zwzw, texture[10], 2D;
DP4 R8.z, R9, c[26].w;
MUL R8.w, c[12].x, c[12].x;
TEX R4.w, R4.w, texture[7], 2D;
TEX R2.w, fragment.texcoord[3], texture[8], CUBE;
MUL R2.w, R4, R2;
MUL R2.w, R2, R8.z;
MUL R4.w, R8.y, R7;
MUL_SAT R8.y, R4.w, R2.w;
MUL R9.xyz, R8.y, R7;
DP3 R8.z, R6, R2;
SLT R4.w, R8.x, c[23].x;
MUL R7.w, R4, R6;
MAD R7.w, -R7, c[23].z, R6;
MAD R4.w, R4, c[28].x, R7;
MUL R6.xyz, R7, c[1];
MUL_SAT R7.x, R8.z, c[11];
MUL R6.xyz, R7.x, R6;
ADD R7.x, -R7, c[23].y;
MAD R6.xyz, R7.x, c[1], R6;
MUL R7.xyz, R9, c[22];
ADD R8.y, -R8, c[23];
MAD R7.xyz, R8.y, R6, R7;
TEX R6, fragment.texcoord[0], texture[0], 2D;
MUL R6.xyz, R6, c[4];
MUL R6.xyz, R6, R7;
COS R4.w, R4.w;
MUL R7.y, R4.w, R4.w;
MUL R4.w, R7.y, R8;
MUL R7.x, R7.y, c[12];
MUL R4.w, R7.y, R4;
MUL R7.x, R7, c[12];
MUL R4.w, R4, c[29].y;
MOV R7.w, c[23].y;
TEX R9.yw, fragment.texcoord[0].zwzw, texture[11], 2D;
ADD R7.y, -R7, c[23];
RCP R7.x, R7.x;
MUL R7.x, R7.y, R7;
RCP R4.w, R4.w;
POW R7.x, c[25].y, -R7.x;
MUL R7.y, R7.x, R4.w;
ADD R7.x, -R8, c[23].y;
ADD R4.w, R7, -c[5].x;
POW R7.x, R7.x, c[29].z;
MAD R4.w, R7.x, c[5].x, R4;
DP3 R7.x, R0, R3;
DP3 R0.x, R0, R2;
MUL R7.y, R7, R4.w;
DP3 R0.y, R5, R3;
RCP R0.z, R0.y;
MUL R0.y, R8.x, R7.x;
MUL R0.y, R0, R0.z;
MUL R0.x, R8, R0;
MUL R0.x, R0.z, R0;
RCP R4.w, R7.x;
MUL R7.y, R6.w, R7;
MUL_SAT R10.w, R7.y, R4;
MOV R4.w, c[29];
MUL R0.y, R0, c[23].z;
MUL R0.x, R0, c[23].z;
MIN_SAT R5.x, R0.y, R0;
MAX R0.y, R8.x, c[23].x;
MAD R8.xy, R9.wyzw, c[23].z, -c[23].y;
MUL R0.x, R4.w, c[5];
POW R0.x, R0.y, R0.x;
MUL R0.x, R6.w, R0;
MUL R5.y, R0.x, c[25].z;
MUL R5.z, R8.y, R8.y;
MAD R6.w, -R8.x, R8.x, -R5.z;
DP3 R0.x, R4, R4;
RSQ R0.x, R0.x;
MUL R7.xyz, R0.x, R4;
ADD R0.xyz, R3, R7;
DP3 R5.z, R0, R0;
RSQ R5.z, R5.z;
MUL R9.xyz, R5.z, R0;
MAD R0.x, R10.w, R5, R5.y;
MUL R10.w, R1.y, R1.y;
ADD R6.w, R6, c[23].y;
RSQ R6.w, R6.w;
RCP R8.z, R6.w;
DP3 R9.w, R8, R9;
ABS R0.z, R9.w;
DP3 R9.y, R3, R9;
MUL_SAT R5.z, R5.w, R0.x;
ADD R0.x, -R0.z, c[23].y;
MAD R0.y, R0.z, c[28], c[28].z;
MAD R0.y, R0, R0.z, -c[28].w;
RSQ R0.x, R0.x;
MAD R1.x, R1, R1, R10.w;
MAD R1.x, R1.z, R1.z, R1;
DP3 R7.x, R8, R7;
RSQ R1.z, R1.x;
MAX R1.x, R7, c[23];
RCP R7.x, R1.z;
ADD R1.z, R3.w, -c[7].x;
MUL R3.w, R7.x, c[9].x;
MUL R3.w, R3, R1.z;
MUL R1.z, R1.x, R1.x;
MUL R1.z, R1, R3.w;
MUL R3.w, R1.z, R3;
MUL R1.z, R4.y, R4.y;
MAD R1.z, R4.x, R4.x, R1;
MAD R1.z, R4, R4, R1;
MUL R3.w, R3, c[25].z;
POW R3.w, c[25].y, -R3.w;
MUL R3.w, -R3, c[25];
SLT R5.x, R9.w, c[23];
RCP R0.x, R0.x;
MAD R0.y, R0, R0.z, c[29].x;
MUL R5.w, R0.y, R0.x;
MUL R5.y, R5.x, R5.w;
MAD R5.y, -R5, c[23].z, R5.w;
MOV R0.xyz, c[6];
MUL R0.xyz, R0, c[1];
MUL R0.xyz, R0, R5.z;
MAD R0.xyz, R6, R0.w, R0;
MAD R5.x, R5, c[28], R5.y;
COS R0.w, R5.x;
MUL R5.w, R2, c[23].z;
MUL R0.w, R0, R0;
MUL R5.xyz, R0, R5.w;
MUL R0.x, R8.w, R0.w;
MUL R0.y, R0.w, c[12].x;
MUL R0.x, R0.w, R0;
MUL R0.y, R0, c[12].x;
ADD R0.z, -R0.w, c[23].y;
RCP R0.y, R0.y;
MUL R0.y, R0.z, R0;
POW R0.z, c[25].y, -R0.y;
MUL R0.x, R0, c[29].y;
RCP R0.y, R0.x;
MUL R6.z, R0, R0.y;
ADD R0.x, -R9.w, c[23].y;
POW R0.z, R0.x, c[29].z;
TEX R0.yw, fragment.texcoord[0].zwzw, texture[3], 2D;
ADD R0.x, R7.w, -c[14];
MAD R6.xy, R0.wyzw, c[23].z, -c[23].y;
MAD R0.y, R0.z, c[14].x, R0.x;
DP3 R7.w, R3, R8;
MUL R6.w, R6.z, R0.y;
MUL R0.x, R6.y, R6.y;
MAD R6.z, -R6.x, R6.x, -R0.x;
TEX R0, fragment.texcoord[0], texture[2], 2D;
ADD R6.z, R6, c[23].y;
RSQ R6.z, R6.z;
RCP R6.z, R6.z;
DP3 R8.w, R3, R6;
MUL R6.w, R6, R0;
RCP R7.w, R7.w;
MUL_SAT R7.w, R6, R7;
DP3 R6.w, R2, R6;
MUL R8.w, R9, R8;
MUL R9.x, R9.w, R6.w;
RCP R9.y, R9.y;
MUL R9.x, R9.y, R9;
MUL R9.y, R8.w, R9;
MUL R8.w, R9.x, c[23].z;
MUL R9.x, R9.y, c[23].z;
MIN_SAT R8.w, R9.x, R8;
MAX R9.y, R9.w, c[23].x;
MUL R9.x, R4.w, c[14];
POW R10.z, R9.y, R9.x;
TEX R9, fragment.texcoord[0], texture[4], 2D;
MUL R1.y, R9.w, R10.z;
MUL R1.y, R1, c[25].z;
MAD R1.y, R7.w, R8.w, R1;
ADD R3.w, R3, c[23].y;
MUL_SAT R8.x, R3.w, R1.y;
RSQ R1.z, R1.z;
RCP R1.y, R1.z;
MUL R1.z, R1.w, R1.y;
MUL R3.w, R1.x, R3;
MUL R1.xy, -R10, c[7].x;
MUL R1.xy, R1, R1.z;
MAD R1.xy, -R1, c[10].x, fragment.texcoord[0];
ADD_SAT R1.z, -R3.w, c[23].y;
TEX R7, R1, texture[10], 2D;
POW R1.z, R1.z, c[20].x;
MUL R1.x, R1.z, c[21];
MUL R1.w, R1.x, R7;
MUL_SAT R1.w, R2, R1;
DP3 R2.w, R2, R4;
MOV R1.xyz, c[15];
MUL R1.xyz, R1, c[1];
MUL R1.xyz, R1, R8.x;
MUL R8.xyz, R1.w, R7;
MUL R4.xyz, R7, c[1];
MUL_SAT R2.w, R2, c[11].x;
MUL R4.xyz, R2.w, R4;
ADD R2.w, -R2, c[23].y;
MAD R4.xyz, R2.w, c[1], R4;
MUL R7.xyz, R8, c[22];
ADD R1.w, -R1, c[23].y;
MAD R4.xyz, R1.w, R4, R7;
MUL R7.xyz, R9, c[13];
MUL R4.xyz, R7, R4;
MAD R4.xyz, R4, R3.w, R1;
ADD R1.xyz, R2, R3;
DP3 R2.w, R1, R1;
TEX R1.w, fragment.texcoord[0], texture[5], 2D;
RSQ R2.w, R2.w;
MUL R1.xyz, R2.w, R1;
DP3 R1.y, R6, R1;
ADD_SAT R1.w, R1, c[16].x;
MUL R2.xyz, R5.w, R4;
MUL R2.xyz, R1.w, R2;
ADD R1.w, -R1, c[23].y;
MAX R1.y, R1, c[23].x;
MUL R1.x, R4.w, c[18];
POW R1.x, R1.y, R1.x;
MUL_SAT R0.w, R0, R1.x;
MOV R3.xyz, c[2];
MUL R1.xyz, R3, c[1];
MUL R3.xyz, R0, c[17];
MUL R1.xyz, R1, R0.w;
TEX R0.w, fragment.texcoord[0], texture[1], 2D;
ADD_SAT R0.w, R0, c[19].x;
MAD R2.xyz, R1.w, R5, R2;
MAX R0.x, R6.w, c[23];
MUL R3.xyz, R3, c[1];
MAD R0.xyz, R3, R0.x, R1;
MUL R0.xyz, R5.w, R0;
MUL R0.xyz, R0.w, R0;
ADD R0.w, -R0, c[23].y;
MAD result.color.xyz, R0.w, R2, R0;
MOV result.color.w, c[23].x;
END
# 344 instructions, 11 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Vector 0 [_LightPositionRange]
Vector 1 [_LightColor0]
Vector 2 [_SpecColor]
Vector 3 [_LightShadowData]
Vector 4 [_Color3]
Float 5 [_Shininess3]
Vector 6 [_SpecColor3]
Float 7 [_Layer1Thickness]
Float 8 [_Layer2Thickness]
Float 9 [_GVar]
Float 10 [_ExitColorMultiplier]
Float 11 [_ExitColorRadius]
Float 12 [_SpecSmoothing]
Vector 13 [_Color2]
Float 14 [_Shininess2]
Vector 15 [_SpecColor2]
Float 16 [_BlendAdjust2]
Vector 17 [_Color]
Float 18 [_Shininess]
Float 19 [_BlendAdjust1]
Float 20 [_DDXP]
Float 21 [_DDXM]
Vector 22 [_SSSC]
SetTexture 0 [_MainTex3] 2D
SetTexture 1 [_ScatterMap] 2D
SetTexture 2 [_MainTex] 2D
SetTexture 3 [_BumpMap] 2D
SetTexture 4 [_MainTex2] 2D
SetTexture 5 [_ScatterMap2] 2D
SetTexture 6 [_ShadowMapTexture] CUBE
SetTexture 7 [_LightTextureB0] 2D
SetTexture 8 [_LightTexture0] CUBE
SetTexture 9 [_BumpMap3] 2D
SetTexture 10 [_ExitColorMap] 2D
SetTexture 11 [_BumpMap2] 2D
"ps_3_0
; 396 ALU, 16 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_cube s6
dcl_2d s7
dcl_cube s8
dcl_2d s9
dcl_2d s10
dcl_2d s11
def c23, 2.00000000, -1.00000000, 0.11705996, 0.50000000
def c24, 6.28318501, -3.14159298, -0.73550957, 0.73550957
def c25, 0.00000000, -1.00000000, 0.15799320, 0.50000000
def c26, -0.99270076, 0.99270076, 2.71828198, 0.00781250
def c27, 0.39894229, 1.00000000, 0.00781250, -0.00781250
def c28, 1.00000000, 0.00392157, 0.00001538, 0.00000001
def c29, 0.97000003, 0.25000000, 0.00000000, 1.00000000
def c30, -0.01872930, 0.07426100, -0.21211439, 1.57072902
def c31, 3.14159298, 0.15915491, 0.50000000, 3.14159274
def c32, 5.00000000, 128.00000000, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dp3_pp r0.x, v1, v1
rsq_pp r0.x, r0.x
mul_pp r3.xyz, r0.x, v1
mul r0.x, r3.y, r3.y
mad r0.x, r3, r3, r0
mad r0.x, r3.z, r3.z, r0
rsq r3.w, r0.x
mul r1.x, r3.w, -r3.z
mad r0.x, r1, c23.z, c23.w
frc r0.x, r0
mad r1.y, r0.x, c24.x, c24
sincos r0.xy, r1.y
mad r0.z, r1.x, c24, r0.x
dp3 r0.y, r3, r3
mul r1.xy, r0.z, c25
rsq r0.x, r0.y
mul r0.xyz, r0.x, r3
mad r4.xyz, r0, c24.w, r1.xxyw
mul r0.x, r4.y, r4.y
mad r0.x, r4, r4, r0
mad r0.x, r4.z, r4.z, r0
rsq r0.x, r0.x
mul r1.x, r0, -r4.z
mad r0.x, r1, c25.z, c25.w
frc r0.x, r0
mad r1.y, r0.x, c24.x, c24
sincos r0.xy, r1.y
mad r0.z, r1.x, c26.x, r0.x
dp3 r0.y, r4, r4
rsq r0.x, r0.y
mul r5.xyz, r0.x, r4
mul r0.zw, r0.z, c25.xyxy
mad r0.xyz, r5, c26.y, r0.zzww
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, r0
mad r2.xyz, -r5, c7.x, r3
mad r6.xyz, -r1, c8.x, r2
dp3 r0.w, r6, r6
rsq r0.w, r0.w
mul r1.xyz, r0.w, r6
texld r2.yw, v0.zwzw, s9
dp3_pp r0.w, v2, v2
rsq_pp r0.w, r0.w
mul_pp r7.xyz, r0.w, v2
mad_pp r2.xy, r2.wyzw, c23.x, c23.y
add r8.xyz, r1, r7
mul_pp r0.w, r2.y, r2.y
mad_pp r0.w, -r2.x, r2.x, -r0
dp3 r1.w, r8, r8
rsq r1.w, r1.w
add_pp r0.w, r0, c27.y
rsq_pp r0.w, r0.w
add r4.xyz, -r4, r3
add r0.xyz, -r0, r3
rcp_pp r2.z, r0.w
mul r8.xyz, r1.w, r8
dp3 r5.w, r2, r8
abs r0.w, r5
add r2.w, -r0, c27.y
mad r1.w, r0, c30.x, c30.y
mad r1.w, r1, r0, c30.z
mad r0.w, r1, r0, c30
rsq r2.w, r2.w
rcp r2.w, r2.w
mul r0.w, r0, r2
mul r2.w, r0.y, r0.y
dp3 r0.y, r2, r1
cmp r1.w, r5, c29.z, c29
mad r0.x, r0, r0, r2.w
max r1.x, r0.y, c25
mad r0.y, r0.z, r0.z, r0.x
mov r0.x, c8
add r0.z, -c7.x, -r0.x
rsq r0.y, r0.y
rcp r0.x, r0.y
add r0.y, r0.z, c23.x
mul r0.x, r0, c9
mul r0.y, r0.x, r0
mul r0.x, r1, r1
mul r0.x, r0, r0.y
mul r0.x, r0, r0.y
mul r0.z, r1.w, r0.w
mad r0.y, -r0.z, c23.x, r0.w
mad r1.z, r1.w, c31.x, r0.y
mul r1.y, r0.x, c23.w
pow r0, c26.z, -r1.y
mad r0.y, r1.z, c31, c31.z
mad r2.w, -r0.x, c27.x, c27.y
mul r4.w, r1.x, r2
frc r0.y, r0
mad r0.y, r0, c24.x, c24
sincos r9.xy, r0.y
mul r8.w, r9.x, r9.x
mul r9.xyz, r5, c7.x
add_sat r1.x, -r4.w, c27.y
add r5.xyz, r3, -r9
pow r0, r1.x, c20.x
mul r1.y, r6, r6
mad r0.y, r6.x, r6.x, r1
mad r0.y, r6.z, r6.z, r0
rsq r0.y, r0.y
rcp r0.z, r0.y
mul r7.w, r0.x, c21.x
add r0.xy, r6, -r3
mul r0.w, r3, r0.z
mul r1.xy, r0, c8.x
mul r1.xy, r1, r0.w
mad r11.xy, -r1, c10.x, v0
add r0.xyz, v4, c27.zwww
texld r0, r0, s6
dp4 r10.w, r0, c28
add r0.xyz, v4, c27.wzww
texld r0, r0, s6
dp4 r10.z, r0, c28
add r1.xyz, v4, c27.wwzw
texld r1, r1, s6
dp4 r10.y, r1, c28
add r0.xyz, v4, c26.w
texld r0, r0, s6
dp3 r1.x, v4, v4
dp4 r10.x, r0, c28
rsq r1.x, r1.x
rcp r0.x, r1.x
mul r0.x, r0, c0.w
mad r0, -r0.x, c29.x, r10
mov r1.x, c3
cmp r0, r0, c27.y, r1.x
dp4_pp r0.y, r0, c29.y
dp3 r0.x, v3, v3
texld r1, r11, s10
texld r0.w, v3, s8
texld r0.x, r0.x, s7
mul r0.x, r0, r0.w
mul r6.w, r0.x, r0.y
mul r0.x, r7.w, r1.w
dp3 r1.w, r6, r3
mul_sat r0.w, r0.x, r6
mul r0.xyz, r0.w, r1
mul r7.w, c12.x, c12.x
add r6.z, -r5.w, c27.y
mul_sat r1.w, r1, c11.x
mul_pp r1.xyz, r1, c1
mul r1.xyz, r1.w, r1
add r1.w, -r1, c27.y
mad r1.xyz, r1.w, c1, r1
mul r1.w, r8, c12.x
mul r0.xyz, r0, c22
add r0.w, -r0, c27.y
mad r1.xyz, r0.w, r1, r0
texld r0, v0, s0
mul_pp r0.xyz, r0, c4
mul_pp r0.xyz, r0, r1
mul r1.w, r1, c12.x
add r1.x, -r8.w, c27.y
rcp r1.y, r1.w
mul r6.x, r1, r1.y
pow r1, c26.z, -r6.x
mul r1.y, r8.w, r7.w
mul r1.y, r8.w, r1
mov r6.y, r1.x
mul r1.x, r1.y, c31.w
rcp r6.x, r1.x
pow r1, r6.z, c32.x
mov_pp r1.y, c5.x
add_pp r1.y, c27, -r1
mad r1.y, r1.x, c5.x, r1
mul r1.x, r6.y, r6
mul r1.x, r1, r1.y
dp3_pp r1.y, r2, r7
mul r1.x, r0.w, r1
rcp r1.z, r1.y
mul_sat r9.w, r1.x, r1.z
dp3_pp r1.w, r8, r7
mul r1.x, r5.w, r1.y
rcp r1.z, r1.w
mul r1.x, r1, r1.z
dp3_pp r1.y, r2, r3
mul r10.x, r1, c23
mul r1.x, r5.w, r1.y
mul r1.x, r1.z, r1
mul r9.z, r1.x, c23.x
dp3 r1.x, r5, r5
texld r1.yw, v0.zwzw, s11
mad_pp r2.xy, r1.wyzw, c23.x, c23.y
rsq r1.x, r1.x
mul r6.xyz, r1.x, r5
add r1.xyz, r7, r6
dp3 r2.z, r1, r1
mul_pp r1.w, r2.y, r2.y
mad_pp r1.w, -r2.x, r2.x, -r1
rsq r2.z, r2.z
add_pp r1.w, r1, c27.y
mul r8.xyz, r2.z, r1
rsq_pp r1.w, r1.w
rcp_pp r2.z, r1.w
dp3 r8.w, r2, r8
abs r1.x, r8.w
min_sat r9.z, r10.x, r9
add r1.z, -r1.x, c27.y
mad r1.y, r1.x, c30.x, c30
mad r1.y, r1, r1.x, c30.z
dp3_pp r8.x, r7, r8
rsq r1.z, r1.z
mad r1.x, r1.y, r1, c30.w
rcp r1.z, r1.z
mul r1.y, r1.x, r1.z
cmp r10.x, r8.w, c29.z, c29.w
mul r1.z, r10.x, r1.y
mov_pp r1.x, c5
mul_pp r10.y, c32, r1.x
mad r10.z, -r1, c23.x, r1.y
max r5.w, r5, c25.x
pow r1, r5.w, r10.y
mad r1.y, r10.x, c31.x, r10.z
mul r0.w, r0, r1.x
mad r1.y, r1, c31, c31.z
frc r1.y, r1
mad r5.w, r1.y, c24.x, c24.y
sincos r1.xy, r5.w
mul r0.w, r0, c23
mad r0.w, r9, r9.z, r0
mul_sat r0.w, r2, r0
mul r2.w, r1.x, r1.x
mov_pp r1.xyz, c1
mul_pp r1.xyz, c6, r1
mul r1.xyz, r1, r0.w
mad r1.xyz, r0, r4.w, r1
mul r1.w, r2, c12.x
mul r0.w, r1, c12.x
mul_pp r1.w, r6, c23.x
add r0.x, -r2.w, c27.y
rcp r0.y, r0.w
mul r4.w, r0.x, r0.y
pow r0, c26.z, -r4.w
mul r0.y, r7.w, r2.w
mov r4.w, r0.x
mul r0.x, r2.w, r0.y
mul r2.w, r0.x, c31
add r5.w, -r8, c27.y
pow r0, r5.w, c32.x
rcp r0.y, r2.w
mul r0.z, r4.w, r0.y
mov r2.w, r0.x
texld r0.yw, v0.zwzw, s3
mad_pp r10.xy, r0.wyzw, c23.x, c23.y
mul_pp r0.y, r10, r10
mad_pp r4.w, -r10.x, r10.x, -r0.y
add_pp r4.w, r4, c27.y
rsq_pp r5.w, r4.w
dp3_pp r4.w, r7, r2
dp3 r2.x, r2, r6
rcp_pp r10.z, r5.w
mov_pp r0.x, c14
add_pp r0.x, c27.y, -r0
mad r0.x, r2.w, c14, r0
mul r2.w, r0.z, r0.x
texld r0, v0, s2
mul_pp r0.xyz, r0, c17
mul r2.w, r2, r0
rcp r4.w, r4.w
mul_sat r7.w, r2, r4
dp3_pp r5.w, r3, r10
dp3_pp r4.w, r7, r10
max r6.x, r2, c25
mul r2.w, r8, r5
rcp r8.x, r8.x
mul r4.w, r8, r4
mul r4.w, r4, r8.x
mul r8.x, r8, r2.w
mul r2.w, r4, c23.x
mul r4.w, r8.x, c23.x
min_sat r8.y, r2.w, r4.w
mul r2.w, r4.y, r4.y
mad r2.w, r4.x, r4.x, r2
mad r2.y, r4.z, r4.z, r2.w
rsq r2.x, r2.y
rcp r2.z, r2.x
mov_pp r2.w, c14.x
mov r2.x, c7
mul r2.y, r6.x, r6.x
mul_pp r4.w, c32.y, r2
max r4.y, r8.w, c25.x
mul r2.z, r2, c9.x
add r2.x, c27.y, -r2
mul r4.x, r2.z, r2
mul r4.z, r2.y, r4.x
pow r2, r4.y, r4.w
mul r2.y, r4.z, r4.x
mul r4.x, r2.y, c23.w
mov r6.y, r2.x
pow r2, c26.z, -r4.x
texld r4, v0, s4
mul r6.z, r4.w, r6.y
mad r4.w, -r2.x, c27.x, c27.y
mul r8.x, r6, r4.w
mul r2.y, r5, r5
mad r2.y, r5.x, r5.x, r2
dp3 r5.x, r3, r5
mad r2.x, r5.z, r5.z, r2.y
rsq r2.x, r2.x
rcp r6.y, r2.x
add_sat r6.x, -r8, c27.y
pow r2, r6.x, c20.x
mul r2.y, r3.w, r6
mul r2.zw, -r9.xyxy, c7.x
mul r2.zw, r2, r2.y
mov r3.w, r2.x
mad r6.xy, -r2.zwzw, c10.x, v0
texld r2, r6, s10
mul r3.w, r3, c21.x
mul r2.w, r3, r2
mul_sat r3.w, r6, r2
mul r6.x, r6.z, c23.w
mad r2.w, r7, r8.y, r6.x
mul r6.xyz, r3.w, r2
mul_sat r5.x, r5, c11
mul_pp r2.xyz, r2, c1
mul r2.xyz, r5.x, r2
add r5.x, -r5, c27.y
mad r2.xyz, r5.x, c1, r2
add r3.w, -r3, c27.y
mul r5.xyz, r6, c22
mad r2.xyz, r3.w, r2, r5
mul_pp r4.xyz, r4, c13
mul_pp r2.xyz, r4, r2
add_pp r4.xyz, r3, r7
mov_pp r3.xyz, c1
dp3_pp r3.w, r4, r4
mul_sat r2.w, r4, r2
mul_pp r3.xyz, c15, r3
mul r3.xyz, r3, r2.w
mad r2.xyz, r2, r8.x, r3
rsq_pp r2.w, r3.w
mul_pp r3.xyz, r2.w, r4
dp3_pp r2.w, r10, r3
max_pp r4.x, r2.w, c25
mov_pp r3.x, c18
mul_pp r4.y, c32, r3.x
pow r3, r4.x, r4.y
texld r2.w, v0, s5
mul r2.xyz, r1.w, r2
add_sat r2.w, r2, c16.x
mul_pp r4.xyz, r2.w, r2
add_pp r2.x, -r2.w, c27.y
mul r1.xyz, r1, r1.w
mad_pp r1.xyz, r2.x, r1, r4
mov r2.w, r3.x
mov_pp r2.xyz, c1
mul_sat r0.w, r0, r2
mul_pp r2.xyz, c2, r2
mul r2.xyz, r2, r0.w
max_pp r0.w, r5, c25.x
mul_pp r0.xyz, r0, c1
mad r0.xyz, r0, r0.w, r2
mul r2.xyz, r1.w, r0
texld r0.w, v0, s1
add_sat r0.x, r0.w, c19
mul_pp r2.xyz, r0.x, r2
add_pp r0.x, -r0, c27.y
mad_pp oC0.xyz, r0.x, r1, r2
mov_pp oC0.w, c25.x
"
}
}
 }
}
Fallback "Chickenlord/FastSkin"
}