Shader "Chickenlord/Skin/Simple SSS Skinshader" {
Properties {
 _Color ("Color", Color) = (1,1,1,1)
 _SpecColor ("Specular Color", Color) = (0.5,0.5,0.5,1)
 _Shininess ("Shininess", Range(0.01,1)) = 0.078125
 _MainTex ("Diffuse (RGB) Gloss (A)", 2D) = "white" {}
 _BumpMap ("Normalmap", 2D) = "bump" {}
 _ScatterMap ("Blend Map (A)", 2D) = "white" {}
 _BlendAdjust1 ("Blend Adjust", Range(-1,1)) = 0
 _ExitColorMap ("Exit Color Map (RGB) Scattering (A)", 2D) = "ecm" {}
 _GVar ("Gauss Variance (Brightness)", Range(0,10)) = 1
 _SSSC ("SSSC", Color) = (1,1,1,1)
 _Smoothness ("Smoothness", Range(0,1)) = 1
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
Float 2 [_GVar]
Vector 3 [_Color]
Float 4 [_Shininess]
Float 5 [_BlendAdjust1]
Vector 6 [_SSSC]
Float 7 [_Smoothness]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_ScatterMap] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_ExitColorMap] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 285 ALU, 5 TEX
PARAM c[15] = { program.local[0..7],
		{ 1, 2, 0.1, 0.73550957 },
		{ -0.73550957, 0, -1, 0.99270076 },
		{ -0.99270076, 0.44999999, 2.718282, 0.5 },
		{ 2, 0, 0.39894229, 3.5 },
		{ 0.001, 7, 3.141593, -0.018729299 },
		{ 0.074261002, 0.21211439, 1.570729, 1.3 },
		{ 0.69999999, 3.1415927, 5, 128 } };
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
MOV R1.w, c[10].y;
MUL R0.x, fragment.texcoord[2].y, fragment.texcoord[2].y;
MAD R0.x, fragment.texcoord[2], fragment.texcoord[2], R0;
MAD R0.x, fragment.texcoord[2].z, fragment.texcoord[2].z, R0;
RSQ R3.w, R0.x;
MUL R0.y, R3.w, -fragment.texcoord[2].z;
MUL R0.x, R0.y, c[8].w;
COS R0.z, R0.x;
MAD R0.y, R0, c[9].x, R0.z;
DP3 R0.x, fragment.texcoord[2], fragment.texcoord[2];
MUL R5.w, R1, c[7].x;
MUL R1.xy, R0.y, c[9].yzzw;
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, fragment.texcoord[2];
MAD R3.xyz, R0, c[8].w, R1.xxyw;
MUL R0.x, R3.y, R3.y;
MAD R0.x, R3, R3, R0;
MAD R0.x, R3.z, R3.z, R0;
RSQ R0.x, R0.x;
MUL R0.y, R0.x, -R3.z;
MUL R0.x, R0.y, c[9].w;
COS R0.z, R0.x;
MAD R0.y, R0, c[10].x, R0.z;
DP3 R0.x, R3, R3;
RSQ R0.x, R0.x;
MUL R6.xyz, R0.x, R3;
MUL R0.zw, R0.y, c[9].xyyz;
MAD R0.xyz, R6, c[9].w, R0.zzww;
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R1.xyz, R0.w, R0;
ADD R0.xyz, -R0, fragment.texcoord[2];
MOV R0.w, c[8].z;
ADD R3.xyz, -R3, fragment.texcoord[2];
MAD R2.xyz, R6, -R5.w, fragment.texcoord[2];
MUL R9.xyz, R6, R5.w;
MUL R0.w, R0, c[7].x;
MAD R1.xyz, -R0.w, R1, R2;
TEX R2.yw, fragment.texcoord[0].zwzw, texture[2], 2D;
MAD R4.xy, R2.wyzw, c[8].y, -c[8].x;
MUL R1.w, R1.y, R1.y;
MAD R1.w, R1.x, R1.x, R1;
MAD R1.w, R1.z, R1.z, R1;
DP3 R2.x, R1, R1;
MUL R2.w, R4.y, R4.y;
MAD R2.w, -R4.x, R4.x, -R2;
DP3 R4.w, R1, fragment.texcoord[2];
RSQ R2.x, R2.x;
RSQ R1.w, R1.w;
RCP R1.w, R1.w;
ADD R6.xyz, fragment.texcoord[2], -R9;
MUL R2.xyz, R2.x, R1;
MUL R4.z, R0.y, R0.y;
ADD R2.w, R2, c[8].x;
RSQ R0.y, R2.w;
MAD R2.w, R0.x, R0.x, R4.z;
RCP R4.z, R0.y;
DP3 R0.x, R4, R2;
MAD R0.y, R0.z, R0.z, R2.w;
MAX R2.w, R0.x, c[9].y;
RSQ R0.x, R0.y;
ADD R0.y, -R0.w, -R5.w;
RCP R0.x, R0.x;
MUL R1.w, R3, R1;
MUL R0.x, R0, c[2];
ADD R0.y, R0, c[11].x;
MUL R0.y, R0.x, R0;
MUL R0.x, R2.w, R2.w;
MUL R0.x, R0, R0.y;
MUL R0.z, R0.x, R0.y;
ADD R0.xy, R1, -fragment.texcoord[2];
MUL R0.xy, R0.w, R0;
MUL R5.xy, R0, R1.w;
MUL R0.x, R0.z, c[10].w;
POW R1.w, c[10].z, -R0.x;
MAD R0.zw, -R5.xyxy, c[12].x, fragment.texcoord[0].xyxy;
TEX R0, R0.zwzw, texture[3], 2D;
MUL R1.w, -R1, c[11].z;
ADD R7.w, R1, c[8].x;
MUL R6.w, R2, R7;
DP3 R1.w, fragment.texcoord[1], fragment.texcoord[1];
RSQ R2.w, R1.w;
MUL R5.xyz, R2.w, fragment.texcoord[1];
ADD_SAT R1.w, -R6, c[8].x;
POW R1.w, R1.w, c[11].w;
MUL R0.w, R1, R0;
ADD R2.xyz, R2, R5;
DP3 R1.w, R2, R2;
MUL_SAT R0.w, R0, c[12].y;
MUL R7.xyz, R0.w, R0;
MUL R1.xyz, R0, c[0];
MUL_SAT R4.w, R4, c[7].x;
MUL R1.xyz, R4.w, R1;
ADD R4.w, -R4, c[8].x;
RSQ R1.w, R1.w;
MUL R0.xyz, R1.w, R2;
MAD R1.xyz, R4.w, c[0], R1;
MUL R2.xyz, R7, c[6];
ADD R0.w, -R0, c[8].x;
MAD R7.xyz, R0.w, R1, R2;
DP3 R0.w, R4, R0;
DP3 R0.x, R0, R5;
TEX R1, fragment.texcoord[0], texture[0], 2D;
ABS R2.w, R0;
MUL R2.xyz, R1, c[3];
MUL R1.xyz, R2, R7;
MUL R4.w, R2, c[12];
ADD R7.x, -R2.w, c[8];
DP3 R0.y, R6, R6;
ADD R4.w, R4, c[13].x;
MAD R4.w, R4, R2, -c[13].y;
RSQ R7.x, R7.x;
MAD R2.w, R4, R2, c[13].z;
RCP R7.x, R7.x;
MUL R4.w, R2, R7.x;
SLT R2.w, R0, c[9].y;
MUL R7.x, R2.w, R4.w;
MAD R4.w, -R7.x, c[8].y, R4;
MAD R2.w, R2, c[12].z, R4;
MOV R7.y, c[13].w;
MUL R7.x, R7.y, c[7];
ADD R8.x, R7, c[14];
COS R2.w, R2.w;
MUL R2.w, R2, R2;
MUL R9.w, R8.x, R8.x;
MUL R7.x, R2.w, R9.w;
MUL R4.w, R2, R8.x;
MUL R7.x, R2.w, R7;
MUL R4.w, R4, R8.x;
RCP R8.z, R0.x;
MUL R7.x, R7, c[14].y;
RCP R4.w, R4.w;
ADD R2.w, -R2, c[8].x;
MUL R2.w, R2, R4;
RCP R4.w, R7.x;
MOV R7.x, c[8];
ADD R10.x, R7, -c[4];
DP3 R7.x, R4, R5;
POW R2.w, c[10].z, -R2.w;
MUL R2.w, R2, R4;
ADD R4.w, -R0, c[8].x;
POW R4.w, R4.w, c[14].z;
MAD R4.w, R4, c[4].x, R10.x;
MUL R2.w, R2, R4;
RCP R8.w, R7.x;
MUL R2.w, R1, R2;
MUL_SAT R8.y, R2.w, R8.w;
MUL R2.w, R0, R7.x;
MUL R0.x, R2.w, R8.z;
DP3 R2.w, R4, fragment.texcoord[2];
MUL R9.z, R0.w, R2.w;
MUL R8.z, R8, R9;
RSQ R0.y, R0.y;
MUL R7.xyz, R0.y, R6;
MUL R4.w, R0.x, c[8].y;
ADD R0.xyz, R5, R7;
DP3 R10.y, R0, R0;
RSQ R10.y, R10.y;
MUL R0.xyz, R10.y, R0;
DP3 R10.y, R4, R0;
ABS R0.y, R10;
MUL R8.z, R8, c[8].y;
MAX R0.x, R0.w, c[9].y;
MUL R0.z, R0.y, c[12].w;
ADD R0.w, -R0.y, c[8].x;
ADD R0.z, R0, c[13].x;
MAD R0.z, R0, R0.y, -c[13].y;
MAD R0.y, R0.z, R0, c[13].z;
RSQ R0.w, R0.w;
RCP R0.w, R0.w;
MUL R0.w, R0.y, R0;
MIN_SAT R9.z, R4.w, R8;
MOV R0.z, c[14].w;
MUL R4.w, R0.z, c[4].x;
POW R0.x, R0.x, R4.w;
SLT R0.y, R10, c[9];
MUL R0.z, R0.y, R0.w;
MAD R0.z, -R0, c[8].y, R0.w;
MAD R0.y, R0, c[12].z, R0.z;
MUL R0.x, R1.w, R0;
COS R0.y, R0.y;
MUL R10.z, R0.y, R0.y;
MUL R9.w, R9, R10.z;
MUL R9.w, R10.z, R9;
MUL R0.x, R0, c[10].w;
MAD R0.x, R8.y, R9.z, R0;
MUL_SAT R8.y, R7.w, R0.x;
MUL R7.w, R8.x, R10.z;
MOV R0, c[1];
MUL R7.w, R8.x, R7;
MUL R0.xyz, R0, c[0];
MUL R8.xyz, R0, R8.y;
MAD R1.xyz, R1, R6.w, R8;
RCP R10.w, R7.w;
ADD R7.w, -R10.z, c[8].x;
MUL R7.w, R7, R10;
ADD R10.z, -R10.y, c[8].x;
MUL R9.w, R9, c[14].y;
POW R10.z, R10.z, c[14].z;
MUL R8.x, R3.y, R3.y;
ADD R5.xyz, fragment.texcoord[2], R5;
POW R7.w, c[10].z, -R7.w;
RCP R9.w, R9.w;
MAD R10.x, R10.z, c[4], R10;
MUL R7.w, R7, R9;
MUL R7.w, R7, R10.x;
MUL R6.w, R1, R7;
MAX R7.w, R10.y, c[9].y;
POW R7.w, R7.w, R4.w;
MUL R3.y, R1.w, R7.w;
MAD R7.w, R3.x, R3.x, R8.x;
MAD R3.z, R3, R3, R7.w;
MUL R3.x, R3.y, c[10].w;
DP3 R3.y, R4, R7;
RSQ R7.x, R3.z;
MAX R3.z, R3.y, c[9].y;
RCP R3.y, R7.x;
MUL_SAT R6.w, R8, R6;
MAD R3.x, R9.z, R6.w, R3;
MUL R6.w, R6.y, R6.y;
MAD R6.w, R6.x, R6.x, R6;
MAD R6.w, R6.z, R6.z, R6;
DP3 R7.w, fragment.texcoord[2], R6;
ADD R7.x, -R5.w, c[8];
MUL R3.y, R3, c[2].x;
MUL R7.x, R3.y, R7;
MUL R3.y, R3.z, R3.z;
MUL R3.y, R3, R7.x;
MUL R3.y, R3, R7.x;
MUL R3.y, R3, c[10].w;
POW R3.y, c[10].z, -R3.y;
MUL R3.y, -R3, c[11].z;
ADD R7.x, R3.y, c[8];
RSQ R6.w, R6.w;
RCP R3.y, R6.w;
MUL_SAT R6.w, R3.x, R7.x;
MUL R3.w, R3, R3.y;
MUL R3.xy, R5.w, -R9;
MUL R5.w, R7.x, R3.z;
MUL R3.xy, R3, R3.w;
MAD R3.xy, -R3, c[12].x, fragment.texcoord[0];
TEX R3, R3, texture[3], 2D;
ADD_SAT R7.x, -R5.w, c[8];
POW R7.x, R7.x, c[11].w;
MUL R3.w, R7.x, R3;
MUL_SAT R3.w, R3, c[12].y;
MUL R6.xyz, R3, c[0];
MUL_SAT R7.w, R7, c[7].x;
MUL R6.xyz, R7.w, R6;
ADD R7.w, -R7, c[8].x;
MAD R6.xyz, R7.w, c[0], R6;
MUL R3.xyz, R3.w, R3;
ADD R7.w, -R3, c[8].x;
DP3 R3.w, R5, R5;
RSQ R3.w, R3.w;
MUL R5.xyz, R3.w, R5;
DP3 R3.w, R4, R5;
MAX R3.w, R3, c[9].y;
POW R4.x, R3.w, R4.w;
MUL_SAT R5.x, R1.w, R4;
MUL R4.w, R0, c[0];
TEX R3.w, fragment.texcoord[0], texture[1], 2D;
ADD_SAT R1.w, R3, c[5].x;
MAX R0.w, R2, c[9].y;
MUL R3.xyz, R3, c[6];
MAD R3.xyz, R7.w, R6, R3;
MAD R3.w, R4, R6, R1;
ADD R2.w, -R1, c[8].x;
MUL R7.xyz, R0, R6.w;
MUL R4.xyz, R0, R5.x;
MUL R0.xyz, R2, c[0];
MUL R3.xyz, R2, R3;
MAD R3.xyz, R3, R5.w, R7;
MUL R3.xyz, R3, c[8].y;
MAD R4.xyz, R0, R0.w, R4;
MUL R0, R1.w, R3;
MAD R3.w, R4, R5.x, R1;
MUL R3.xyz, R4, c[8].y;
MUL R3, R1.w, R3;
MUL R1.xyz, R1, c[8].y;
MOV R1.w, c[8].x;
MAD R0, R2.w, R1, R0;
MAD R0, R0, R2.w, R3;
MAD result.color.xyz, R2, fragment.texcoord[3], R0;
MOV result.color.w, R0;
END
# 285 instructions, 11 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Float 2 [_GVar]
Vector 3 [_Color]
Float 4 [_Shininess]
Float 5 [_BlendAdjust1]
Vector 6 [_SSSC]
Float 7 [_Smoothness]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_ScatterMap] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_ExitColorMap] 2D
"ps_3_0
; 342 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c8, 2.00000000, -1.00000000, 0.10000000, -0.73550957
def c9, 0.11705996, 0.50000000, 6.28318501, -3.14159298
def c10, 0.00000000, -1.00000000, 0.73550957, -0.99270076
def c11, 0.15799320, 0.50000000, 0.99270076, 0.44999999
def c12, 2.71828198, 0.39894229, 1.00000000, 3.50000000
def c13, 0.00100000, 7.00000000, 0.00000000, 1.00000000
def c14, -0.01872930, 0.07426100, -0.21211439, 1.57072902
def c15, 3.14159298, 0.15915491, 0.50000000, 3.14159274
def c16, 1.29999995, 0.69999999, 5.00000000, 128.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
mul r0.x, v2.y, v2.y
mad r0.x, v2, v2, r0
mad r0.x, v2.z, v2.z, r0
rsq r3.w, r0.x
mul r1.x, r3.w, -v2.z
mad r0.x, r1, c9, c9.y
frc r0.x, r0
mad r1.y, r0.x, c9.z, c9.w
sincos r0.xy, r1.y
mad r0.z, r1.x, c8.w, r0.x
dp3 r0.y, v2, v2
mul r1.xy, r0.z, c10
rsq r0.x, r0.y
mul r0.xyz, r0.x, v2
mad r4.xyz, r0, c10.z, r1.xxyw
mul r0.x, r4.y, r4.y
mad r0.x, r4, r4, r0
mad r0.x, r4.z, r4.z, r0
rsq r0.x, r0.x
mul r1.x, r0, -r4.z
mad r0.x, r1, c11, c11.y
frc r0.x, r0
mad r1.y, r0.x, c9.z, c9.w
sincos r0.xy, r1.y
mad r0.z, r1.x, c10.w, r0.x
dp3 r0.y, r4, r4
rsq r0.x, r0.y
mul r1.xyz, r0.x, r4
mul r0.zw, r0.z, c10.xyxy
mad r8.xyz, r1, c11.z, r0.zzww
dp3 r0.x, r8, r8
mov r0.w, c7.x
mul r4.w, c11, r0
mov r0.w, c7.x
rsq r0.x, r0.x
mul r0.xyz, r0.x, r8
mad r2.xyz, r1, -r4.w, v2
mul r7.w, c8.z, r0
mad r5.xyz, -r7.w, r0, r2
dp3 r0.x, r5, r5
texld r0.yw, v0.zwzw, s2
mad_pp r3.xy, r0.wyzw, c8.x, c8.y
rsq r0.x, r0.x
mul r7.xyz, r0.x, r5
mul_pp r0.w, r3.y, r3.y
mad_pp r0.w, -r3.x, r3.x, -r0
dp3_pp r0.x, v1, v1
rsq_pp r0.x, r0.x
mul_pp r6.xyz, r0.x, v1
add r0.xyz, r7, r6
dp3 r1.w, r0, r0
rsq r1.w, r1.w
add_pp r0.w, r0, c12.z
rsq_pp r0.w, r0.w
rcp_pp r3.z, r0.w
mul r0.xyz, r1.w, r0
dp3 r0.w, r3, r0
abs r1.w, r0
add r2.y, -r1.w, c12.z
mad r2.x, r1.w, c14, c14.y
mad r2.x, r2, r1.w, c14.z
rsq r2.y, r2.y
add r4.xyz, -r4, v2
mul r9.xyz, r1, r4.w
add r8.xyz, -r8, v2
mad r1.w, r2.x, r1, c14
rcp r2.y, r2.y
mul r2.x, r1.w, r2.y
cmp r1.w, r0, c13.z, c13
mul r2.y, r1.w, r2.x
mad r2.x, -r2.y, c8, r2
mad r1.w, r1, c15.x, r2.x
mad r1.w, r1, c15.y, c15.z
frc r1.w, r1
mad r1.w, r1, c9.z, c9
sincos r2.xy, r1.w
mov r1.w, c7.x
mad r8.w, r1, c16.x, c16.y
mul r1.w, r2.x, r2.x
mul r2.x, r1.w, r8.w
mul r2.x, r2, r8.w
mul r5.w, r8, r8
rcp r2.y, r2.x
add r2.x, -r1.w, c12.z
mul r2.z, r1.w, r5.w
mul r1.w, r1, r2.z
mul r6.w, r2.x, r2.y
pow r2, c12.x, -r6.w
mul r1.w, r1, c15
add r6.w, -r0, c12.z
rcp r1.w, r1.w
mul r1.w, r2.x, r1
pow r2, r6.w, c16.z
mul r2.y, r8, r8
mad r2.z, r8.x, r8.x, r2.y
dp3 r2.y, r3, r7
max r7.x, r2.y, c10
mad r2.z, r8, r8, r2
rsq r2.y, r2.z
add r2.z, -r7.w, -r4.w
rcp r2.y, r2.y
mov r7.z, r2.x
mul r2.y, r2, c2.x
add r2.z, r2, c8.x
mul r2.z, r2.y, r2
mul r2.y, r7.x, r7.x
mul r2.y, r2, r2.z
mul r2.x, r2.y, r2.z
mov_pp r2.y, c4.x
add_pp r6.w, c12.z, -r2.y
mul r7.y, r2.x, c9
pow r2, c12.x, -r7.y
mad r10.x, -r2, c12.y, c12.z
mad r8.x, r7.z, c4, r6.w
mul r9.w, r7.x, r10.x
mul r2.y, r5, r5
mad r2.y, r5.x, r5.x, r2
mad r2.x, r5.z, r5.z, r2.y
rsq r2.x, r2.x
rcp r2.z, r2.x
add r2.xy, r5, -v2
dp3 r5.x, r5, v2
add_sat r7.z, -r9.w, c12
mul r2.z, r3.w, r2
mul r2.xy, r7.w, r2
mul r7.xy, r2, r2.z
pow r2, r7.z, c12.w
mad r7.xy, -r7, c13.x, v0
texld r7, r7, s3
mul r2.x, r2, r7.w
mul_sat r2.w, r2.x, c13.y
mul r1.w, r1, r8.x
add r7.w, -r2, c12.z
mul_pp r2.xyz, r7, c0
mul_sat r5.x, r5, c7
mul r2.xyz, r5.x, r2
add r5.x, -r5, c12.z
mad r5.xyz, r5.x, c0, r2
mul r2.xyz, r2.w, r7
mul r7.xyz, r2, c6
texld r2, v0, s0
mad r5.xyz, r7.w, r5, r7
dp3_pp r7.w, r3, r6
add r7.xyz, v2, -r9
mul_pp r2.xyz, r2, c3
dp3 r1.x, r7, r7
rsq r1.x, r1.x
mul r8.xyz, r1.x, r7
dp3_pp r0.x, r0, r6
rcp r1.x, r0.x
mul r1.y, r0.w, r7.w
rcp r10.w, r7.w
mul r1.w, r2, r1
add r0.xyz, r6, r8
mul r1.y, r1, r1.x
dp3 r1.z, r0, r0
rsq r1.z, r1.z
mul r0.xyz, r1.z, r0
dp3 r11.y, r3, r0
abs r0.y, r11
dp3_pp r7.w, r3, v2
mul r1.z, r0.w, r7.w
mul r0.x, r1, r1.z
add r1.x, -r0.y, c12.z
mad r0.z, r0.y, c14.x, c14.y
mad r0.z, r0, r0.y, c14
mad r0.y, r0.z, r0, c14.w
rsq r1.x, r1.x
rcp r1.x, r1.x
mul r0.y, r0, r1.x
cmp r0.z, r11.y, c13, c13.w
mul r1.x, r0.z, r0.y
mul_sat r10.y, r1.w, r10.w
mul r1.y, r1, c8.x
mul r0.x, r0, c8
min_sat r11.x, r1.y, r0
mad r0.x, -r1, c8, r0.y
mad r0.z, r0, c15.x, r0.x
mov_pp r0.x, c4
mul_pp r9.z, c16.w, r0.x
max r0.y, r0.w, c10.x
mad r0.z, r0, c15.y, c15
pow r1, r0.y, r9.z
frc r0.x, r0.z
mad r1.y, r0.x, c9.z, c9.w
sincos r0.xy, r1.y
mov r0.y, r1.x
mul r1.w, r0.x, r0.x
mul r0.y, r2.w, r0
mul r0.x, r0.y, c9.y
mul r0.y, r8.w, r1.w
mul r0.y, r8.w, r0
mad r0.x, r10.y, r11, r0
mul_sat r8.w, r10.x, r0.x
mov_pp r1.xyz, c0
mul_pp r1.xyz, c1, r1
mul r5.w, r5, r1
add r0.x, -r1.w, c12.z
rcp r0.y, r0.y
mul r10.x, r0, r0.y
pow r0, c12.x, -r10.x
mul r10.xyz, r1, r8.w
mul_pp r5.xyz, r2, r5
mad r5.xyz, r5, r9.w, r10
mov r8.w, r0.x
add r9.w, -r11.y, c12.z
pow r0, r9.w, c16.z
mul r0.y, r1.w, r5.w
mov r0.z, r0.x
mul r0.y, r0, c15.w
rcp r0.x, r0.y
mad r0.y, r0.z, c4.x, r6.w
mul r0.x, r8.w, r0
mul r0.x, r0, r0.y
mul r0.x, r2.w, r0
mul_sat r1.w, r10, r0.x
mul r0.x, r4.y, r4.y
mad r4.x, r4, r4, r0
max r4.y, r11, c10.x
pow r0, r4.y, r9.z
mad r0.z, r4, r4, r4.x
dp3 r0.y, r3, r8
max r4.x, r0.y, c10
rsq r0.z, r0.z
rcp r0.y, r0.z
add r0.z, -r4.w, c12
mul r0.y, r0, c2.x
mul r0.z, r0.y, r0
mul r0.y, r4.x, r4.x
mul r0.y, r0, r0.z
mul r0.y, r0, r0.z
mul r4.y, r2.w, r0.x
mul r4.z, r0.y, c9.y
pow r0, c12.x, -r4.z
mul r0.y, r4, c9
mad r0.x, -r0, c12.y, c12.z
mul r5.w, r0.x, r4.x
mad r0.y, r11.x, r1.w, r0
mul_sat r1.w, r0.y, r0.x
mul r0.z, r7.y, r7.y
mad r0.z, r7.x, r7.x, r0
mad r0.y, r7.z, r7.z, r0.z
rsq r0.y, r0.y
rcp r0.x, r0.y
mul r0.z, r3.w, r0.x
mul r0.xy, r4.w, -r9
mul r4.xy, r0, r0.z
add_sat r4.z, -r5.w, c12
pow r0, r4.z, c12.w
dp3 r0.y, v2, r7
mad r4.xy, -r4, c13.x, v0
texld r4, r4, s3
mov r0.w, r0.x
mul r0.w, r0, r4
mul r8.xyz, r1, r1.w
mul_sat r0.w, r0, c13.y
mul_pp r7.xyz, r4, c0
mul_sat r0.y, r0, c7.x
mul r7.xyz, r0.y, r7
add r0.y, -r0, c12.z
mad r7.xyz, r0.y, c0, r7
add_pp r0.xyz, v2, r6
dp3_pp r3.w, r0, r0
rsq_pp r4.w, r3.w
add r3.w, -r0, c12.z
mul r4.xyz, r0.w, r4
mul_pp r0.xyz, r4.w, r0
dp3_pp r0.w, r3, r0
mul r0.xyz, r4, c6
mad r3.xyz, r3.w, r7, r0
max_pp r4.x, r0.w, c10
pow r0, r4.x, r9.z
mov r0.w, r0.x
mul_sat r4.x, r2.w, r0.w
texld r0.w, v0, s1
mul_pp r3.xyz, r2, r3
mad r3.xyz, r3, r5.w, r8
mul r0.xyz, r3, c8.x
mov_pp r3.x, c0.w
mul_pp r3.w, c1, r3.x
add_sat r2.w, r0, c5.x
mad r0.w, r3, r1, r2
mul r3.xyz, r1, r4.x
max_pp r1.w, r7, c10.x
mul_pp r1.xyz, r2, c0
mad r1.xyz, r1, r1.w, r3
mul_pp r0, r2.w, r0
mad r1.w, r3, r4.x, r2
mul r1.xyz, r1, c8.x
mul_pp r1, r2.w, r1
add_pp r2.w, -r2, c12.z
mul r5.xyz, r5, c8.x
mov_pp r5.w, c12.z
mad_pp r0, r2.w, r5, r0
mad_pp r0, r0, r2.w, r1
mad_pp oC0.xyz, r2, v3, r0
mov_pp oC0.w, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Float 2 [_GVar]
Vector 3 [_Color]
Float 4 [_Shininess]
Float 5 [_BlendAdjust1]
Vector 6 [_SSSC]
Float 7 [_Smoothness]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_ScatterMap] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_ShadowMapTexture] 2D
SetTexture 4 [_ExitColorMap] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 291 ALU, 6 TEX
PARAM c[15] = { program.local[0..7],
		{ 1, 2, 0.1, 0.73550957 },
		{ -0.73550957, 0, -1, 0.99270076 },
		{ -0.99270076, 0.44999999, 2.718282, 0.5 },
		{ 2, 0, 0.39894229, 3.5 },
		{ 0.001, 7, 3.141593, -0.018729299 },
		{ 0.074261002, 0.21211439, 1.570729, 1.3 },
		{ 0.69999999, 3.1415927, 5, 128 } };
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
TEMP R11;
MUL R0.x, fragment.texcoord[2].y, fragment.texcoord[2].y;
MAD R0.x, fragment.texcoord[2], fragment.texcoord[2], R0;
MAD R0.x, fragment.texcoord[2].z, fragment.texcoord[2].z, R0;
RSQ R0.z, R0.x;
MUL R0.y, R0.z, -fragment.texcoord[2].z;
MUL R0.x, R0.y, c[8].w;
COS R0.w, R0.x;
MAD R0.y, R0, c[9].x, R0.w;
DP3 R0.x, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.x, R0.x;
MUL R2.xy, R0.y, c[9].yzzw;
MUL R1.xyz, R0.x, fragment.texcoord[2];
MAD R4.xyz, R1, c[8].w, R2.xxyw;
MUL R0.x, R4.y, R4.y;
MAD R0.x, R4, R4, R0;
MAD R0.x, R4.z, R4.z, R0;
RSQ R0.x, R0.x;
MUL R0.y, R0.x, -R4.z;
MUL R0.x, R0.y, c[9].w;
COS R0.w, R0.x;
MAD R0.y, R0, c[10].x, R0.w;
DP3 R0.x, R4, R4;
RSQ R0.x, R0.x;
MUL R1.xyz, R0.x, R4;
MUL R2.xy, R0.y, c[9].yzzw;
MAD R2.xyz, R1, c[9].w, R2.xxyw;
DP3 R0.x, R2, R2;
RSQ R0.x, R0.x;
MUL R3.xyz, R0.x, R2;
MOV R0.y, c[10];
MUL R0.w, R0.y, c[7].x;
MOV R0.x, c[8].z;
ADD R2.xyz, -R2, fragment.texcoord[2];
MAD R5.xyz, R1, -R0.w, fragment.texcoord[2];
MUL R0.x, R0, c[7];
MAD R3.xyz, -R0.x, R3, R5;
DP3 R0.y, R3, R3;
RSQ R1.w, R0.y;
MUL R7.xyz, R1.w, R3;
MUL R1.w, R2.y, R2.y;
MAD R1.w, R2.x, R2.x, R1;
ADD R2.x, -R0, -R0.w;
TEX R5.yw, fragment.texcoord[0].zwzw, texture[2], 2D;
MAD R5.xy, R5.wyzw, c[8].y, -c[8].x;
MUL R0.y, R5, R5;
MAD R0.y, -R5.x, R5.x, -R0;
MAD R1.w, R2.z, R2.z, R1;
ADD R0.y, R0, c[8].x;
RSQ R0.y, R0.y;
RCP R5.z, R0.y;
DP3 R0.y, R5, R7;
RSQ R1.w, R1.w;
RCP R1.w, R1.w;
ADD R4.xyz, -R4, fragment.texcoord[2];
MUL R10.xyz, R1, R0.w;
MAX R0.y, R0, c[9];
MUL R2.y, R3, R3;
MUL R1.w, R1, c[2].x;
ADD R2.x, R2, c[11];
MUL R2.x, R1.w, R2;
MUL R1.w, R0.y, R0.y;
MUL R1.w, R1, R2.x;
MUL R1.w, R1, R2.x;
MAD R2.x, R3, R3, R2.y;
MAD R2.x, R3.z, R3.z, R2;
RSQ R2.x, R2.x;
RCP R2.z, R2.x;
ADD R2.xy, R3, -fragment.texcoord[2];
MUL R2.xy, R0.x, R2;
MUL R2.z, R0, R2;
MUL R2.xy, R2, R2.z;
DP3 R0.x, R3, fragment.texcoord[2];
MUL R1.w, R1, c[10];
POW R1.w, c[10].z, -R1.w;
MUL R1.w, -R1, c[11].z;
ADD R1.w, R1, c[8].x;
MUL R4.w, R0.y, R1;
DP3 R0.y, fragment.texcoord[1], fragment.texcoord[1];
RSQ R3.w, R0.y;
MUL R6.xyz, R3.w, fragment.texcoord[1];
MAD R2.xy, -R2, c[12].x, fragment.texcoord[0];
TEX R2, R2, texture[4], 2D;
ADD R7.xyz, R7, R6;
MUL R3.xyz, R2, c[0];
MUL_SAT R0.x, R0, c[7];
MUL R3.xyz, R0.x, R3;
ADD R0.x, -R0, c[8];
MAD R3.xyz, R0.x, c[0], R3;
ADD_SAT R0.x, -R4.w, c[8];
POW R0.x, R0.x, c[11].w;
MUL R0.y, R0.x, R2.w;
TXP R0.x, fragment.texcoord[4], texture[3], 2D;
MUL R0.y, R0, R0.x;
DP3 R2.w, R7, R7;
MUL_SAT R0.y, R0, c[12];
MUL R2.xyz, R0.y, R2;
RSQ R2.w, R2.w;
MUL R7.xyz, R2.w, R7;
DP3 R3.w, R5, R7;
DP3 R7.x, R7, R6;
MUL R2.xyz, R2, c[6];
ADD R0.y, -R0, c[8].x;
MAD R8.xyz, R0.y, R3, R2;
ABS R0.y, R3.w;
TEX R2, fragment.texcoord[0], texture[0], 2D;
MUL R3.xyz, R2, c[3];
MUL R5.w, R0.y, c[12];
ADD R6.w, -R0.y, c[8].x;
ADD R5.w, R5, c[13].x;
MAD R5.w, R5, R0.y, -c[13].y;
RSQ R6.w, R6.w;
MAD R0.y, R5.w, R0, c[13].z;
RCP R6.w, R6.w;
MUL R5.w, R0.y, R6;
SLT R0.y, R3.w, c[9];
MUL R6.w, R0.y, R5;
MAD R5.w, -R6, c[8].y, R5;
MAD R0.y, R0, c[12].z, R5.w;
MOV R7.w, c[13];
MUL R6.w, R7, c[7].x;
ADD R9.w, R6, c[14].x;
COS R0.y, R0.y;
MUL R0.y, R0, R0;
MUL R5.w, R9, R9;
MUL R7.w, R0.y, R5;
MUL R6.w, R0.y, R9;
MUL R7.w, R0.y, R7;
MUL R6.w, R6, R9;
MUL R2.xyz, R3, R8;
MUL R7.w, R7, c[14].y;
RCP R6.w, R6.w;
ADD R0.y, -R0, c[8].x;
MUL R0.y, R0, R6.w;
RCP R6.w, R7.w;
MOV R7.w, c[8].x;
ADD R8.w, R7, -c[4].x;
POW R0.y, c[10].z, -R0.y;
MUL R0.y, R0, R6.w;
ADD R6.w, -R3, c[8].x;
POW R6.w, R6.w, c[14].z;
MAD R6.w, R6, c[4].x, R8;
MUL R0.y, R0, R6.w;
DP3 R7.w, R5, R6;
RCP R6.w, R7.w;
MUL R0.y, R2.w, R0;
MUL_SAT R9.x, R0.y, R6.w;
MUL R0.y, R3.w, R7.w;
RCP R7.w, R7.x;
ADD R7.xyz, fragment.texcoord[2], -R10;
MUL R0.y, R0, R7.w;
MUL R9.y, R0, c[8];
DP3 R1.x, R7, R7;
RSQ R1.y, R1.x;
DP3 R0.y, R5, fragment.texcoord[2];
MUL R1.x, R3.w, R0.y;
MUL R7.w, R7, R1.x;
MUL R8.xyz, R1.y, R7;
ADD R1.xyz, R6, R8;
DP3 R9.z, R1, R1;
RSQ R9.z, R9.z;
MUL R1.xyz, R9.z, R1;
DP3 R10.z, R5, R1;
ABS R1.y, R10.z;
MUL R1.z, R1.y, c[12].w;
MUL R7.w, R7, c[8].y;
MIN_SAT R7.w, R9.y, R7;
MAX R9.y, R3.w, c[9];
MOV R3.w, c[14];
MUL R3.w, R3, c[4].x;
POW R1.x, R9.y, R3.w;
ADD R9.y, -R1, c[8].x;
MUL R1.x, R2.w, R1;
ADD R1.z, R1, c[13].x;
MAD R1.z, R1, R1.y, -c[13].y;
RSQ R9.y, R9.y;
MUL R1.x, R1, c[10].w;
MAD R1.x, R9, R7.w, R1;
MAD R1.y, R1.z, R1, c[13].z;
RCP R9.y, R9.y;
MUL R1.z, R1.y, R9.y;
SLT R1.y, R10.z, c[9];
MUL R9.y, R1, R1.z;
MAD R1.z, -R9.y, c[8].y, R1;
MAD R1.y, R1, c[12].z, R1.z;
COS R1.y, R1.y;
MUL R10.w, R1.y, R1.y;
MUL_SAT R9.x, R1.w, R1;
MOV R1, c[1];
MUL R1.xyz, R1, c[0];
MUL R9.xyz, R1, R9.x;
MAD R2.xyz, R2, R4.w, R9;
MUL R11.x, R9.w, R10.w;
MUL R9.w, R9, R11.x;
MUL R5.w, R5, R10;
MUL R5.w, R10, R5;
MUL R5.w, R5, c[14].y;
MUL R1.w, R1, c[0];
RCP R9.x, R9.w;
ADD R4.w, -R10, c[8].x;
MUL R4.w, R4, R9.x;
ADD R9.x, -R10.z, c[8];
POW R9.x, R9.x, c[14].z;
RCP R5.w, R5.w;
POW R4.w, c[10].z, -R4.w;
MUL R4.w, R4, R5;
MUL R5.w, R0.x, c[8].y;
MAD R8.w, R9.x, c[4].x, R8;
MUL R4.w, R4, R8;
MUL R4.w, R2, R4;
MUL_SAT R6.w, R6, R4;
MUL R8.w, R4.y, R4.y;
MAX R4.w, R10.z, c[9].y;
POW R4.y, R4.w, R3.w;
MAD R4.x, R4, R4, R8.w;
MUL R8.w, R2, R4.y;
MAD R4.y, R4.z, R4.z, R4.x;
DP3 R4.x, R5, R8;
MAX R4.z, R4.x, c[9].y;
RSQ R4.y, R4.y;
RCP R4.x, R4.y;
MUL R4.w, R7.y, R7.y;
ADD R4.y, -R0.w, c[8].x;
MUL R4.x, R4, c[2];
MUL R4.y, R4.x, R4;
MUL R4.x, R4.z, R4.z;
MUL R4.x, R4, R4.y;
MUL R4.x, R4, R4.y;
MAD R4.y, R7.x, R7.x, R4.w;
MAD R4.y, R7.z, R7.z, R4;
MUL R4.x, R4, c[10].w;
POW R4.x, c[10].z, -R4.x;
MUL R4.x, -R4, c[11].z;
RSQ R4.y, R4.y;
ADD R8.x, R4, c[8];
RCP R4.y, R4.y;
MUL R4.x, R0.z, R4.y;
MUL R0.zw, R0.w, -R10.xyxy;
MUL R4.xy, R0.zwzw, R4.x;
MUL R0.w, R8.x, R4.z;
ADD_SAT R0.z, -R0.w, c[8].x;
MAD R4.xy, -R4, c[12].x, fragment.texcoord[0];
TEX R4, R4, texture[4], 2D;
POW R0.z, R0.z, c[11].w;
MUL R4.w, R0.z, R4;
MUL R4.w, R0.x, R4;
MUL R0.z, R8.w, c[10].w;
MAD R0.z, R7.w, R6.w, R0;
DP3 R6.w, fragment.texcoord[2], R7;
MUL_SAT R0.z, R0, R8.x;
MUL_SAT R4.w, R4, c[12].y;
MUL R8.xyz, R4.w, R4;
MUL_SAT R6.w, R6, c[7].x;
MUL R4.xyz, R4, c[0];
MUL R4.xyz, R6.w, R4;
ADD R6.w, -R6, c[8].x;
MUL R7.xyz, R8, c[6];
ADD R4.w, -R4, c[8].x;
MAD R4.xyz, R6.w, c[0], R4;
MAD R4.xyz, R4.w, R4, R7;
MUL R7.xyz, R1, R0.z;
MUL R4.xyz, R3, R4;
MAD R4.xyz, R4, R0.w, R7;
ADD R6.xyz, fragment.texcoord[2], R6;
DP3 R0.w, R6, R6;
RSQ R0.w, R0.w;
MUL R6.xyz, R0.w, R6;
DP3 R4.w, R5, R6;
TEX R0.w, fragment.texcoord[0], texture[1], 2D;
ADD_SAT R6.x, R0.w, c[5];
MAX R4.w, R4, c[9].y;
MUL R0.z, R1.w, R0;
POW R0.w, R4.w, R3.w;
MAD R4.w, R0.x, R0.z, R6.x;
MUL_SAT R0.z, R2.w, R0.w;
MUL R5.xyz, R1, R0.z;
MUL R4.xyz, R5.w, R4;
MAX R0.y, R0, c[9];
MUL R1.xyz, R3, c[0];
MAD R1.xyz, R1, R0.y, R5;
MUL R0.y, R1.w, R0.z;
MUL R1.xyz, R5.w, R1;
MAD R1.w, R0.x, R0.y, R6.x;
MUL R0, R6.x, R1;
ADD R1.x, -R6, c[8];
MUL R2.xyz, R2, R5.w;
MUL R4, R6.x, R4;
MOV R2.w, c[8].x;
MAD R2, R1.x, R2, R4;
MAD R0, R2, R1.x, R0;
MAD result.color.xyz, R3, fragment.texcoord[3], R0;
MOV result.color.w, R0;
END
# 291 instructions, 12 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Float 2 [_GVar]
Vector 3 [_Color]
Float 4 [_Shininess]
Float 5 [_BlendAdjust1]
Vector 6 [_SSSC]
Float 7 [_Smoothness]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_ScatterMap] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_ShadowMapTexture] 2D
SetTexture 4 [_ExitColorMap] 2D
"ps_3_0
; 347 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c8, 2.00000000, -1.00000000, 0.10000000, -0.73550957
def c9, 0.11705996, 0.50000000, 6.28318501, -3.14159298
def c10, 0.00000000, -1.00000000, 0.73550957, -0.99270076
def c11, 0.15799320, 0.50000000, 0.99270076, 0.44999999
def c12, 2.71828198, 0.39894229, 1.00000000, 3.50000000
def c13, 0.00100000, 7.00000000, 0.00000000, 1.00000000
def c14, -0.01872930, 0.07426100, -0.21211439, 1.57072902
def c15, 3.14159298, 0.15915491, 0.50000000, 3.14159274
def c16, 1.29999995, 0.69999999, 5.00000000, 128.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4
mul r0.x, v2.y, v2.y
mad r0.x, v2, v2, r0
mad r0.x, v2.z, v2.z, r0
rsq r4.w, r0.x
mul r1.x, r4.w, -v2.z
mad r0.x, r1, c9, c9.y
frc r0.x, r0
mad r1.y, r0.x, c9.z, c9.w
sincos r0.xy, r1.y
mad r0.z, r1.x, c8.w, r0.x
dp3 r0.y, v2, v2
mul r1.xy, r0.z, c10
rsq r0.x, r0.y
mul r0.xyz, r0.x, v2
mad r5.xyz, r0, c10.z, r1.xxyw
mul r0.x, r5.y, r5.y
mad r0.x, r5, r5, r0
mad r0.x, r5.z, r5.z, r0
rsq r0.x, r0.x
mul r1.x, r0, -r5.z
mad r0.x, r1, c11, c11.y
frc r0.x, r0
mad r1.y, r0.x, c9.z, c9.w
sincos r0.xy, r1.y
mad r0.z, r1.x, c10.w, r0.x
dp3 r0.y, r5, r5
rsq r0.x, r0.y
mul r2.xyz, r0.x, r5
add r5.xyz, -r5, v2
mul r0.zw, r0.z, c10.xyxy
mad r8.xyz, r2, c11.z, r0.zzww
dp3 r0.x, r8, r8
mov r0.w, c7.x
mul r5.w, c11, r0
mov r0.w, c7.x
rsq r0.x, r0.x
mul r0.xyz, r0.x, r8
mad r1.xyz, r2, -r5.w, v2
mul r2.w, c8.z, r0
mad r3.xyz, -r2.w, r0, r1
texld r0.yw, v0.zwzw, s2
mad_pp r4.xy, r0.wyzw, c8.x, c8.y
dp3 r0.x, r3, r3
rsq r0.x, r0.x
mul r6.xyz, r0.x, r3
mul_pp r0.w, r4.y, r4.y
mad_pp r0.w, -r4.x, r4.x, -r0
dp3_pp r0.x, v1, v1
rsq_pp r0.x, r0.x
mul_pp r7.xyz, r0.x, v1
add r0.xyz, r6, r7
dp3 r1.x, r0, r0
add_pp r0.w, r0, c12.z
rsq_pp r0.w, r0.w
rsq r1.x, r1.x
rcp_pp r4.z, r0.w
mul r1.xyz, r1.x, r0
dp3 r1.w, r4, r1
abs r0.x, r1.w
add r0.z, -r0.x, c12
mad r0.y, r0.x, c14.x, c14
mad r0.y, r0, r0.x, c14.z
rsq r0.z, r0.z
add r8.xyz, -r8, v2
mul r10.xyz, r2, r5.w
mad r0.x, r0.y, r0, c14.w
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r0.x, r1.w, c13.z, c13.w
mul r0.z, r0.x, r0.y
mad r0.y, -r0.z, c8.x, r0
mad r0.x, r0, c15, r0.y
mad r0.x, r0, c15.y, c15.z
frc r0.x, r0
mad r3.w, r0.x, c9.z, c9
sincos r0.xy, r3.w
mov r0.y, c7.x
mad r9.w, r0.y, c16.x, c16.y
mul r0.x, r0, r0
mul r0.y, r0.x, r9.w
mul r0.y, r0, r9.w
mul r7.w, r9, r9
mul r0.w, r0.x, r7
rcp r0.z, r0.y
add r0.y, -r0.x, c12.z
mul r3.w, r0.y, r0.z
mul r6.w, r0.x, r0
pow r0, c12.x, -r3.w
mul r0.y, r6.w, c15.w
rcp r0.y, r0.y
mul r3.w, r0.x, r0.y
add r8.w, -r1, c12.z
pow r0, r8.w, c16.z
dp3 r0.y, r4, r6
mul r6.w, r8.y, r8.y
mad r0.z, r8.x, r8.x, r6.w
mov_pp r6.z, c4.x
max r6.x, r0.y, c10
mad r0.z, r8, r8, r0
rsq r0.y, r0.z
add r0.z, -r2.w, -r5.w
rcp r0.y, r0.y
add_pp r8.w, c12.z, -r6.z
mul r0.y, r0, c2.x
add r0.z, r0, c8.x
mul r0.z, r0.y, r0
mul r0.y, r6.x, r6.x
mul r0.y, r0, r0.z
mov r6.w, r0.x
mul r0.y, r0, r0.z
mul r6.y, r0, c9
pow r0, c12.x, -r6.y
mad r11.x, -r0, c12.y, c12.z
mul r10.w, r6.x, r11.x
mul r0.y, r3, r3
mad r0.x, r3, r3, r0.y
mad r0.x, r3.z, r3.z, r0
mad r8.x, r6.w, c4, r8.w
add_sat r6.x, -r10.w, c12.z
rsq r6.y, r0.x
pow r0, r6.x, c12.w
rcp r0.y, r6.y
add r0.zw, r3.xyxy, -v2.xyxy
mul r0.y, r4.w, r0
mul r0.zw, r2.w, r0
mul r0.zw, r0, r0.y
mad r6.xy, -r0.zwzw, c13.x, v0
mov r0.y, r0.x
texld r6, r6, s4
dp3 r0.w, r3, v2
texldp r0.x, v4, s3
mul r0.y, r0, r6.w
mul r0.z, r0.y, r0.x
mul r0.y, r3.w, r8.x
mul_sat r0.z, r0, c13.y
mul_pp r3.xyz, r6, c0
mul_sat r0.w, r0, c7.x
mul r3.xyz, r0.w, r3
add r0.w, -r0, c12.z
mad r8.xyz, r0.w, c0, r3
mul r3.xyz, r0.z, r6
mul r6.xyz, r3, c6
texld r3, v0, s0
add r0.z, -r0, c12
mad r6.xyz, r0.z, r8, r6
add r8.xyz, v2, -r10
dp3_pp r0.z, r4, r7
mul_pp r3.xyz, r3, c3
dp3 r0.w, r8, r8
rsq r0.w, r0.w
mul r9.xyz, r0.w, r8
rcp r6.w, r0.z
mul r0.y, r3.w, r0
mul_sat r11.y, r0, r6.w
mul r0.y, r1.w, r0.z
dp3_pp r0.z, r1, r7
add r1.xyz, r7, r9
rcp r0.w, r0.z
mul r0.y, r0, r0.w
dp3 r2.x, r1, r1
mul r0.z, r0.y, c8.x
rsq r2.x, r2.x
mul r1.xyz, r2.x, r1
dp3 r10.z, r4, r1
abs r1.x, r10.z
dp3_pp r0.y, r4, v2
mul r2.x, r1.w, r0.y
mul r0.w, r0, r2.x
mul r0.w, r0, c8.x
add r1.z, -r1.x, c12
mad r1.y, r1.x, c14.x, c14
mad r1.y, r1, r1.x, c14.z
mad r1.x, r1.y, r1, c14.w
rsq r1.z, r1.z
rcp r1.z, r1.z
mul r1.x, r1, r1.z
cmp r1.y, r10.z, c13.z, c13.w
mul r1.z, r1.y, r1.x
min_sat r0.z, r0, r0.w
mad r0.w, -r1.z, c8.x, r1.x
mad r1.y, r1, c15.x, r0.w
mov_pp r0.w, c4.x
mad r1.y, r1, c15, c15.z
mul_pp r0.w, c16, r0
max r1.x, r1.w, c10
pow r2, r1.x, r0.w
frc r1.y, r1
mad r2.y, r1, c9.z, c9.w
sincos r1.xy, r2.y
mov r1.y, r2.x
mul r2.w, r1.x, r1.x
mul r1.y, r3.w, r1
mul r1.x, r1.y, c9.y
mul r1.y, r9.w, r2.w
mul r1.y, r9.w, r1
mad r1.x, r11.y, r0.z, r1
mul_sat r9.w, r11.x, r1.x
mov_pp r2.xyz, c0
mul_pp r2.xyz, c1, r2
mul r7.w, r7, r2
add r1.x, -r2.w, c12.z
rcp r1.y, r1.y
mul r11.x, r1, r1.y
pow r1, c12.x, -r11.x
mul r11.xyz, r2, r9.w
mul_pp r6.xyz, r3, r6
mad r6.xyz, r6, r10.w, r11
mov r9.w, r1.x
add r10.w, -r10.z, c12.z
pow r1, r10.w, c16.z
mul r1.y, r2.w, r7.w
mul_pp r2.w, r0.x, c8.x
mov r1.z, r1.x
mul r1.y, r1, c15.w
rcp r1.x, r1.y
mad r1.y, r1.z, c4.x, r8.w
mul r1.x, r9.w, r1
mul r1.x, r1, r1.y
mul r1.x, r3.w, r1
mul_sat r7.w, r6, r1.x
max r6.w, r10.z, c10.x
pow r1, r6.w, r0.w
mul r5.y, r5, r5
mad r1.y, r5.x, r5.x, r5
mad r1.z, r5, r5, r1.y
dp3 r1.y, r4, r9
mul r1.x, r3.w, r1
mul r8.w, r1.x, c9.y
max r5.x, r1.y, c10
rsq r1.z, r1.z
rcp r1.y, r1.z
mul r6.xyz, r6, r2.w
add r1.z, -r5.w, c12
mul r1.y, r1, c2.x
mul r1.z, r1.y, r1
mul r1.y, r5.x, r5.x
mul r1.y, r1, r1.z
mul r1.y, r1, r1.z
mul r5.y, r1, c9
pow r1, c12.x, -r5.y
mul r1.y, r8, r8
mad r9.x, -r1, c12.y, c12.z
mul r6.w, r9.x, r5.x
mad r1.y, r8.x, r8.x, r1
mad r1.y, r8.z, r8.z, r1
rsq r1.x, r1.y
rcp r1.x, r1.x
mul r1.z, r4.w, r1.x
mul r1.xy, r5.w, -r10
mul r5.xy, r1, r1.z
add_sat r5.z, -r6.w, c12
pow r1, r5.z, c12.w
mad r5.xy, -r5, c13.x, v0
mad r0.z, r0, r7.w, r8.w
mul_sat r0.z, r0, r9.x
dp3 r4.w, v2, r8
texld r5, r5, s4
mul r1.x, r1, r5.w
mul r1.x, r0, r1
mul_sat r1.w, r1.x, c13.y
mul r1.xyz, r1.w, r5
mul r9.xyz, r2, r0.z
mul_sat r4.w, r4, c7.x
mul_pp r5.xyz, r5, c0
mul r5.xyz, r4.w, r5
add r4.w, -r4, c12.z
mad r5.xyz, r4.w, c0, r5
add r1.w, -r1, c12.z
mul r1.xyz, r1, c6
mad r1.xyz, r1.w, r5, r1
add_pp r5.xyz, v2, r7
dp3_pp r1.w, r5, r5
rsq_pp r1.w, r1.w
mul_pp r5.xyz, r1.w, r5
mul_pp r1.xyz, r3, r1
mad r1.xyz, r1, r6.w, r9
dp3_pp r4.x, r4, r5
mov_pp r1.w, c0
mul_pp r5.x, c1.w, r1.w
max_pp r1.w, r4.x, c10.x
pow r4, r1.w, r0.w
texld r0.w, v0, s1
add_sat r4.w, r0, c5.x
mul r0.z, r5.x, r0
mov r0.w, r4.x
mad r1.w, r0.x, r0.z, r4
mul_sat r0.z, r3.w, r0.w
mul r4.xyz, r2, r0.z
mul r1.xyz, r2.w, r1
max_pp r0.y, r0, c10.x
mul_pp r2.xyz, r3, c0
mad r2.xyz, r2, r0.y, r4
mul r2.xyz, r2.w, r2
mul r0.y, r5.x, r0.z
mad r2.w, r0.x, r0.y, r4
mul_pp r0, r4.w, r2
add_pp r2.x, -r4.w, c12.z
mul_pp r1, r4.w, r1
mov_pp r6.w, c12.z
mad_pp r1, r2.x, r6, r1
mad_pp r0, r1, r2.x, r0
mad_pp oC0.xyz, r3, v3, r0
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
Float 2 [_GVar]
Vector 3 [_Color]
Float 4 [_Shininess]
Float 5 [_BlendAdjust1]
Vector 6 [_SSSC]
Float 7 [_Smoothness]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_ScatterMap] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_LightTexture0] 2D
SetTexture 4 [_ExitColorMap] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 285 ALU, 6 TEX
PARAM c[15] = { program.local[0..7],
		{ 0, 1, 2, 0.1 },
		{ 0.73550957, -0.73550957, 0, -1 },
		{ 0.99270076, -0.99270076, 0.44999999, 2.718282 },
		{ 0.5, 0.39894229, 3.5, 0.001 },
		{ 7, 3.141593, -0.018729299, 0.074261002 },
		{ 0.21211439, 1.570729, 1.3, 0.69999999 },
		{ 3.1415927, 5, 128 } };
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
TEMP R11;
MOV R2.w, c[10].z;
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.x, R0.x;
MUL R3.xyz, R0.x, fragment.texcoord[1];
MUL R0.x, R3.y, R3.y;
MAD R0.x, R3, R3, R0;
MAD R0.x, R3.z, R3.z, R0;
RSQ R1.w, R0.x;
MUL R0.y, R1.w, -R3.z;
MUL R0.x, R0.y, c[9];
COS R0.z, R0.x;
DP3 R0.x, R3, R3;
MAD R0.y, R0, c[9], R0.z;
MUL R3.w, R2, c[7].x;
MUL R1.xy, R0.y, c[9].zwzw;
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, R3;
MAD R1.xyz, R0, c[9].x, R1.xxyw;
MUL R0.x, R1.y, R1.y;
MAD R0.x, R1, R1, R0;
MAD R0.x, R1.z, R1.z, R0;
RSQ R0.x, R0.x;
MUL R0.y, R0.x, -R1.z;
MUL R0.x, R0.y, c[10];
COS R0.z, R0.x;
DP3 R0.x, R1, R1;
MAD R0.y, R0, c[10], R0.z;
MUL R2.xy, R0.y, c[9].zwzw;
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, R1;
ADD R1.xyz, -R1, R3;
MAD R2.xyz, R0, c[10].x, R2.xxyw;
DP3 R0.w, R2, R2;
RSQ R0.w, R0.w;
MUL R4.xyz, R0.w, R2;
MUL R1.y, R1, R1;
MAD R1.x, R1, R1, R1.y;
MAD R1.y, R1.z, R1.z, R1.x;
MOV R0.w, c[8];
ADD R2.xyz, -R2, R3;
MUL R10.xyz, R0, R3.w;
MAD R5.xyz, R0, -R3.w, R3;
MUL R0.w, R0, c[7].x;
MAD R5.xyz, -R0.w, R4, R5;
DP3 R5.w, R5, R3;
MUL R2.w, R5.y, R5.y;
TEX R4.yw, fragment.texcoord[0].zwzw, texture[2], 2D;
MAD R4.xy, R4.wyzw, c[8].z, -c[8].y;
DP3 R4.z, R5, R5;
RSQ R4.w, R4.z;
MUL R7.xyz, R4.w, R5;
MUL R4.w, R2.y, R2.y;
MUL R4.z, R4.y, R4.y;
MAD R4.z, -R4.x, R4.x, -R4;
ADD R4.z, R4, c[8].y;
RSQ R2.y, R4.z;
RCP R4.z, R2.y;
MAD R4.w, R2.x, R2.x, R4;
MAD R2.y, R2.z, R2.z, R4.w;
MAD R2.w, R5.x, R5.x, R2;
DP3 R2.x, R4, R7;
MAX R4.w, R2.x, c[8].x;
RSQ R2.x, R2.y;
ADD R2.y, -R0.w, -R3.w;
RCP R2.x, R2.x;
MAD R2.z, R5, R5, R2.w;
MUL_SAT R5.w, R5, c[7].x;
MUL R2.x, R2, c[2];
ADD R2.y, R2, c[8].z;
MUL R2.y, R2.x, R2;
MUL R2.x, R4.w, R4.w;
MUL R2.x, R2, R2.y;
MUL R2.x, R2, R2.y;
RSQ R2.y, R2.z;
RCP R2.w, R2.y;
MUL R2.z, R2.x, c[11].x;
ADD R2.xy, R5, -R3;
MUL R2.xy, R0.w, R2;
MUL R2.w, R1, R2;
MUL R2.xy, R2, R2.w;
POW R0.w, c[10].w, -R2.z;
MUL R0.w, -R0, c[11].y;
ADD R7.w, R0, c[8].y;
MAD R2.xy, -R2, c[11].w, fragment.texcoord[0];
TEX R2, R2, texture[4], 2D;
MUL R5.xyz, R2, c[0];
MUL R5.xyz, R5.w, R5;
ADD R0.w, -R5, c[8].y;
MAD R6.xyz, R0.w, c[0], R5;
MUL R4.w, R4, R7;
ADD_SAT R0.w, -R4, c[8].y;
POW R0.w, R0.w, c[11].z;
MUL R2.w, R0, R2;
DP3 R5.x, fragment.texcoord[2], fragment.texcoord[2];
RSQ R5.x, R5.x;
MUL R5.xyz, R5.x, fragment.texcoord[2];
ADD R7.xyz, R7, R5;
DP3 R5.w, R7, R7;
RSQ R5.w, R5.w;
MUL R7.xyz, R5.w, R7;
DP3 R6.w, R4, R7;
DP3 R7.x, R7, R5;
RCP R9.y, R7.x;
DP3 R0.w, fragment.texcoord[3], fragment.texcoord[3];
TEX R0.w, R0.w, texture[3], 2D;
MUL R2.w, R2, R0;
MUL_SAT R2.w, R2, c[12].x;
MUL R2.xyz, R2.w, R2;
ADD R7.xyz, R3, -R10;
ABS R5.w, R6;
MUL R2.xyz, R2, c[6];
ADD R2.w, -R2, c[8].y;
MAD R6.xyz, R2.w, R6, R2;
ADD R2.y, -R5.w, c[8];
MAD R2.x, R5.w, c[12].z, c[12].w;
MAD R2.x, R2, R5.w, -c[13];
MAD R2.x, R2, R5.w, c[13].y;
RSQ R2.y, R2.y;
RCP R2.y, R2.y;
MUL R8.x, R2, R2.y;
TEX R2, fragment.texcoord[0], texture[0], 2D;
MUL R2.xyz, R2, c[3];
SLT R5.w, R6, c[8].x;
MUL R8.y, R5.w, R8.x;
MAD R8.x, -R8.y, c[8].z, R8;
MAD R5.w, R5, c[12].y, R8.x;
MOV R8.y, c[7].x;
MAD R11.x, R8.y, c[13].z, c[13].w;
COS R5.w, R5.w;
MUL R5.w, R5, R5;
MUL R9.w, R11.x, R11.x;
MUL R8.x, R5.w, R11;
MUL R8.x, R8, R11;
MUL R8.y, R5.w, R9.w;
MUL R8.y, R5.w, R8;
MUL R6.xyz, R2, R6;
MUL R8.y, R8, c[14].x;
RCP R8.x, R8.x;
ADD R5.w, -R5, c[8].y;
MUL R5.w, R5, R8.x;
RCP R8.x, R8.y;
MOV R8.y, c[8];
ADD R10.w, R8.y, -c[4].x;
DP3 R8.y, R4, R5;
POW R5.w, c[10].w, -R5.w;
MUL R5.w, R5, R8.x;
ADD R8.x, -R6.w, c[8].y;
POW R8.x, R8.x, c[14].y;
MAD R8.x, R8, c[4], R10.w;
MUL R5.w, R5, R8.x;
RCP R8.w, R8.y;
MUL R5.w, R2, R5;
MUL_SAT R9.x, R5.w, R8.w;
MUL R5.w, R6, R8.y;
MUL R0.x, R5.w, R9.y;
MUL R9.z, R0.x, c[8];
DP3 R0.x, R7, R7;
RSQ R0.y, R0.x;
MUL R8.xyz, R0.y, R7;
DP3 R1.x, R4, R8;
DP3 R5.w, R4, R3;
MUL R0.x, R6.w, R5.w;
MUL R9.y, R9, R0.x;
ADD R0.xyz, R5, R8;
MUL R9.y, R9, c[8].z;
MIN_SAT R10.z, R9, R9.y;
DP3 R11.y, R0, R0;
RSQ R9.z, R11.y;
MUL R0.xyz, R9.z, R0;
DP3 R11.y, R4, R0;
ABS R0.y, R11;
MAX R9.y, R6.w, c[8].x;
MAD R0.z, R0.y, c[12], c[12].w;
MOV R6.w, c[14].z;
MUL R6.w, R6, c[4].x;
POW R0.x, R9.y, R6.w;
ADD R9.y, -R0, c[8];
MAD R0.z, R0, R0.y, -c[13].x;
RSQ R9.y, R9.y;
MUL R0.x, R2.w, R0;
MUL R0.x, R0, c[11];
MAD R0.x, R9, R10.z, R0;
MAX R1.z, R1.x, c[8].x;
RSQ R1.y, R1.y;
RCP R1.x, R1.y;
MAD R0.y, R0.z, R0, c[13];
RCP R9.y, R9.y;
MUL R0.z, R0.y, R9.y;
SLT R0.y, R11, c[8].x;
MUL R9.y, R0, R0.z;
MAD R0.z, -R9.y, c[8], R0;
MAD R0.y, R0, c[12], R0.z;
MUL_SAT R9.x, R7.w, R0;
COS R0.y, R0.y;
MUL R7.w, R0.y, R0.y;
MUL R11.z, R11.x, R7.w;
MOV R0.xyz, c[1];
MUL R0.xyz, R0, c[0];
MUL R9.xyz, R0, R9.x;
MAD R6.xyz, R6, R4.w, R9;
MUL R11.x, R11, R11.z;
RCP R9.x, R11.x;
ADD R4.w, -R7, c[8].y;
MUL R4.w, R4, R9.x;
MUL R9.x, R9.w, R7.w;
MUL R7.w, R7, R9.x;
ADD R9.x, -R11.y, c[8].y;
MUL R7.w, R7, c[14].x;
POW R9.x, R9.x, c[14].y;
RCP R7.w, R7.w;
POW R4.w, c[10].w, -R4.w;
MUL R4.w, R4, R7;
MAD R9.x, R9, c[4], R10.w;
MUL R7.w, R4, R9.x;
MUL R4.w, R0, c[8].z;
MUL R7.w, R2, R7;
MUL_SAT R7.w, R8, R7;
MAX R8.w, R11.y, c[8].x;
POW R8.w, R8.w, R6.w;
MUL R8.w, R2, R8;
MUL R8.w, R8, c[11].x;
ADD R1.y, -R3.w, c[8];
MUL R1.x, R1, c[2];
MUL R1.y, R1.x, R1;
MUL R1.x, R1.z, R1.z;
MUL R1.x, R1, R1.y;
MUL R1.x, R1, R1.y;
MUL R1.y, R7, R7;
MAD R1.y, R7.x, R7.x, R1;
MAD R1.y, R7.z, R7.z, R1;
MUL R1.x, R1, c[11];
POW R1.x, c[10].w, -R1.x;
MAD R8.x, R10.z, R7.w, R8.w;
MUL R1.x, -R1, c[11].y;
ADD R7.w, R1.x, c[8].y;
RSQ R1.y, R1.y;
MUL_SAT R8.x, R7.w, R8;
RCP R1.x, R1.y;
MUL R1.w, R1, R1.x;
MUL R1.xy, R3.w, -R10;
MUL R3.w, R1.z, R7;
MUL R1.xy, R1, R1.w;
MAD R1.xy, -R1, c[11].w, fragment.texcoord[0];
ADD_SAT R7.w, -R3, c[8].y;
TEX R1, R1, texture[4], 2D;
POW R7.w, R7.w, c[11].z;
MUL R1.w, R7, R1;
DP3 R7.w, R3, R7;
ADD R3.xyz, R3, R5;
MUL R0.w, R0, R1;
MUL_SAT R0.w, R0, c[12].x;
MUL R7.xyz, R1, c[0];
MUL_SAT R7.w, R7, c[7].x;
MUL R7.xyz, R7.w, R7;
DP3 R5.x, R3, R3;
MUL R1.xyz, R0.w, R1;
ADD R7.w, -R7, c[8].y;
RSQ R5.x, R5.x;
MUL R8.xyz, R0, R8.x;
ADD R1.w, -R0, c[8].y;
MUL R3.xyz, R5.x, R3;
DP3 R0.w, R4, R3;
MAX R0.w, R0, c[8].x;
POW R0.w, R0.w, R6.w;
MUL_SAT R0.w, R2, R0;
MUL R3.xyz, R0, R0.w;
MAX R0.w, R5, c[8].x;
MUL R0.xyz, R2, c[0];
MAD R0.xyz, R0, R0.w, R3;
MUL R6.xyz, R6, R4.w;
MAD R7.xyz, R7.w, c[0], R7;
MUL R1.xyz, R1, c[6];
MAD R1.xyz, R1.w, R7, R1;
MUL R1.xyz, R2, R1;
MAD R1.xyz, R1, R3.w, R8;
MUL R2.xyz, R4.w, R0;
TEX R0.w, fragment.texcoord[0], texture[1], 2D;
ADD_SAT R0.x, R0.w, c[5];
MUL R1.xyz, R4.w, R1;
MUL R1.xyz, R0.x, R1;
MUL R2.xyz, R0.x, R2;
ADD R0.x, -R0, c[8].y;
MAD R1.xyz, R0.x, R6, R1;
MAD result.color.xyz, R1, R0.x, R2;
MOV result.color.w, c[8].x;
END
# 285 instructions, 12 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Float 2 [_GVar]
Vector 3 [_Color]
Float 4 [_Shininess]
Float 5 [_BlendAdjust1]
Vector 6 [_SSSC]
Float 7 [_Smoothness]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_ScatterMap] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_LightTexture0] 2D
SetTexture 4 [_ExitColorMap] 2D
"ps_3_0
; 347 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c8, 2.00000000, -1.00000000, 0.10000000, -0.73550957
def c9, 0.11705996, 0.50000000, 6.28318501, -3.14159298
def c10, 0.00000000, -1.00000000, 0.73550957, -0.99270076
def c11, 0.15799320, 0.50000000, 0.99270076, 0.44999999
def c12, 2.71828198, 0.39894229, 1.00000000, 3.50000000
def c13, 0.00100000, 7.00000000, 0.00000000, 1.00000000
def c14, -0.01872930, 0.07426100, -0.21211439, 1.57072902
def c15, 3.14159298, 0.15915491, 0.50000000, 3.14159274
def c16, 1.29999995, 0.69999999, 5.00000000, 128.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dp3_pp r0.x, v1, v1
rsq_pp r0.x, r0.x
mul_pp r4.xyz, r0.x, v1
mul r0.x, r4.y, r4.y
mad r0.x, r4, r4, r0
mad r0.x, r4.z, r4.z, r0
rsq r3.w, r0.x
mul r1.x, r3.w, -r4.z
mad r0.x, r1, c9, c9.y
frc r0.x, r0
mad r1.y, r0.x, c9.z, c9.w
sincos r0.xy, r1.y
mad r0.z, r1.x, c8.w, r0.x
dp3 r0.y, r4, r4
mul r1.xy, r0.z, c10
rsq r0.x, r0.y
mul r0.xyz, r0.x, r4
mad r5.xyz, r0, c10.z, r1.xxyw
mul r0.x, r5.y, r5.y
mad r0.x, r5, r5, r0
mad r0.x, r5.z, r5.z, r0
rsq r0.x, r0.x
mul r1.x, r0, -r5.z
mad r0.x, r1, c11, c11.y
frc r0.x, r0
mad r1.y, r0.x, c9.z, c9.w
sincos r0.xy, r1.y
mad r0.z, r1.x, c10.w, r0.x
dp3 r0.y, r5, r5
rsq r0.x, r0.y
mul r2.xyz, r0.x, r5
add r5.xyz, -r5, r4
mul r0.zw, r0.z, c10.xyxy
mad r8.xyz, r2, c11.z, r0.zzww
dp3 r0.x, r8, r8
mov r0.w, c7.x
mul r4.w, c11, r0
mov r0.w, c7.x
rsq r0.x, r0.x
mul r0.xyz, r0.x, r8
mad r1.xyz, r2, -r4.w, r4
mul r2.w, c8.z, r0
mad r7.xyz, -r2.w, r0, r1
texld r0.yw, v0.zwzw, s2
mad_pp r3.xy, r0.wyzw, c8.x, c8.y
dp3 r0.x, r7, r7
rsq r0.x, r0.x
mul r9.xyz, r0.x, r7
mul_pp r0.w, r3.y, r3.y
mad_pp r0.w, -r3.x, r3.x, -r0
dp3_pp r0.x, v2, v2
rsq_pp r0.x, r0.x
mul_pp r6.xyz, r0.x, v2
add r0.xyz, r9, r6
dp3 r1.x, r0, r0
add_pp r0.w, r0, c12.z
rsq_pp r0.w, r0.w
rsq r1.x, r1.x
rcp_pp r3.z, r0.w
mul r1.xyz, r1.x, r0
dp3 r1.w, r3, r1
abs r0.x, r1.w
add r0.z, -r0.x, c12
mad r0.y, r0.x, c14.x, c14
mad r0.y, r0, r0.x, c14.z
rsq r0.z, r0.z
mul r11.xyz, r2, r4.w
mad r0.x, r0.y, r0, c14.w
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r0.x, r1.w, c13.z, c13.w
mul r0.z, r0.x, r0.y
mad r0.y, -r0.z, c8.x, r0
mad r0.x, r0, c15, r0.y
mad r0.x, r0, c15.y, c15.z
frc r0.x, r0
mad r5.w, r0.x, c9.z, c9
sincos r0.xy, r5.w
mov r0.y, c7.x
mad r9.w, r0.y, c16.x, c16.y
mul r6.w, r0.x, r0.x
mul r0.x, r6.w, r9.w
mul r0.y, r0.x, r9.w
mul r5.w, r9, r9
mul r8.w, r6, r5
add r0.x, -r6.w, c12.z
rcp r0.y, r0.y
mul r7.w, r0.x, r0.y
pow r0, c12.x, -r7.w
mul r0.y, r6.w, r8.w
mul r0.y, r0, c15.w
mov r6.w, r0.x
rcp r0.w, r0.y
add r0.xyz, -r8, r4
mul r0.y, r0, r0
mad r0.y, r0.x, r0.x, r0
dp3 r0.x, r3, r9
mul r7.w, r6, r0
max r8.x, r0, c10
mad r0.y, r0.z, r0.z, r0
rsq r0.x, r0.y
add r0.y, -r2.w, -r4.w
rcp r0.x, r0.x
add r8.z, -r1.w, c12
add r0.y, r0, c8.x
mul r0.x, r0, c2
mul r6.w, r0.x, r0.y
mul r0.x, r8, r8
mul r8.y, r0.x, r6.w
pow r0, r8.z, c16.z
mul r0.y, r8, r6.w
mul r6.w, r0.y, c9.y
mov r8.y, r0.x
pow r0, c12.x, -r6.w
mov_pp r0.y, c4.x
mad r11.w, -r0.x, c12.y, c12.z
mul r10.w, r8.x, r11
add_pp r6.w, c12.z, -r0.y
mul r0.x, r7.y, r7.y
mad r9.x, r8.y, c4, r6.w
mad r0.x, r7, r7, r0
mad r8.y, r7.z, r7.z, r0.x
add_sat r8.x, -r10.w, c12.z
pow r0, r8.x, c12.w
rsq r0.y, r8.y
add r0.zw, r7.xyxy, -r4.xyxy
rcp r0.y, r0.y
mul r0.y, r3.w, r0
mul r0.zw, r2.w, r0
mul r0.zw, r0, r0.y
mad r8.xy, -r0.zwzw, c13.x, v0
mov r0.y, r0.x
texld r8, r8, s4
dp3 r0.w, r7, r4
dp3 r0.x, v3, v3
mul r0.y, r0, r8.w
texld r0.x, r0.x, s3
mul r0.z, r0.y, r0.x
mul r0.y, r7.w, r9.x
mul_sat r0.z, r0, c13.y
mul_pp r7.xyz, r8, c0
mul_sat r0.w, r0, c7.x
mul r7.xyz, r0.w, r7
add r0.w, -r0, c12.z
mad r9.xyz, r0.w, c0, r7
mul r7.xyz, r0.z, r8
mul r8.xyz, r7, c6
texld r7, v0, s0
add r0.z, -r0, c12
mad r8.xyz, r0.z, r9, r8
add r9.xyz, r4, -r11
dp3_pp r0.z, r3, r6
mul_pp r7.xyz, r7, c3
dp3 r0.w, r9, r9
rsq r0.w, r0.w
mul r10.xyz, r0.w, r9
rcp r8.w, r0.z
mul r0.y, r7.w, r0
mul_sat r12.x, r0.y, r8.w
mul r0.y, r1.w, r0.z
dp3_pp r0.z, r1, r6
add r1.xyz, r6, r10
rcp r0.z, r0.z
mul r0.y, r0, r0.z
dp3 r2.x, r1, r1
mul r0.w, r0.y, c8.x
rsq r2.x, r2.x
mul r1.xyz, r2.x, r1
dp3 r11.z, r3, r1
abs r1.x, r11.z
dp3_pp r0.y, r3, r4
mul r2.x, r1.w, r0.y
mul r0.z, r0, r2.x
mul r0.z, r0, c8.x
add r1.z, -r1.x, c12
mad r1.y, r1.x, c14.x, c14
mad r1.y, r1, r1.x, c14.z
mad r1.x, r1.y, r1, c14.w
rsq r1.z, r1.z
rcp r1.z, r1.z
mul r1.x, r1, r1.z
cmp r1.y, r11.z, c13.z, c13.w
min_sat r0.w, r0, r0.z
mul r1.z, r1.y, r1.x
mad r0.z, -r1, c8.x, r1.x
mad r1.y, r1, c15.x, r0.z
mov_pp r0.z, c4.x
mad r1.y, r1, c15, c15.z
mul_pp r0.z, c16.w, r0
max r1.x, r1.w, c10
pow r2, r1.x, r0.z
frc r1.y, r1
mad r2.y, r1, c9.z, c9.w
sincos r1.xy, r2.y
mov r1.y, r2.x
mul r2.w, r1.x, r1.x
mul r1.y, r7.w, r1
mul r1.x, r1.y, c9.y
mul r1.y, r9.w, r2.w
mul r1.y, r9.w, r1
mad r1.x, r12, r0.w, r1
mul_sat r9.w, r11, r1.x
mov_pp r2.xyz, c0
mul_pp r2.xyz, c1, r2
mul r5.w, r5, r2
add r1.x, -r2.w, c12.z
rcp r1.y, r1.y
mul r11.w, r1.x, r1.y
pow r1, c12.x, -r11.w
mul r12.xyz, r2, r9.w
mul_pp r8.xyz, r7, r8
mad r8.xyz, r8, r10.w, r12
mov r9.w, r1.x
add r10.w, -r11.z, c12.z
pow r1, r10.w, c16.z
mul r1.y, r2.w, r5.w
mul_pp r2.w, r0.x, c8.x
mov r1.z, r1.x
mul r1.y, r1, c15.w
rcp r1.x, r1.y
mad r1.y, r1.z, c4.x, r6.w
mul r1.x, r9.w, r1
mul r1.x, r1, r1.y
mul r1.x, r7.w, r1
mul_sat r5.w, r8, r1.x
max r6.w, r11.z, c10.x
pow r1, r6.w, r0.z
mul r5.y, r5, r5
mad r1.y, r5.x, r5.x, r5
mad r1.z, r5, r5, r1.y
dp3 r1.y, r3, r10
max r5.x, r1.y, c10
rsq r1.z, r1.z
rcp r1.y, r1.z
mov r1.w, r1.x
mul r1.y, r1, c2.x
add r1.z, -r4.w, c12
mul r1.z, r1.y, r1
mul r1.y, r5.x, r5.x
mul r1.y, r1, r1.z
mul r1.x, r1.y, r1.z
mul r1.y, r7.w, r1.w
mul r5.y, r1.x, c9
mul r5.z, r1.y, c9.y
pow r1, c12.x, -r5.y
mad r1.z, r0.w, r5.w, r5
mov r0.w, r1.x
mul r1.y, r9, r9
mad r1.x, r9, r9, r1.y
mad r0.w, -r0, c12.y, c12.z
mul_sat r1.y, r0.w, r1.z
mul r0.w, r5.x, r0
mad r1.x, r9.z, r9.z, r1
rsq r1.x, r1.x
rcp r1.x, r1.x
mul r1.z, r3.w, r1.x
mul r10.xyz, r2, r1.y
mul r1.xy, r4.w, -r11
mul r5.xy, r1, r1.z
add_sat r5.z, -r0.w, c12
pow r1, r5.z, c12.w
dp3 r1.y, r4, r9
mad r5.xy, -r5, c13.x, v0
texld r5, r5, s4
mov r1.w, r1.x
mul r1.w, r1, r5
mul r0.x, r0, r1.w
mul_sat r0.x, r0, c13.y
mul_sat r1.y, r1, c7.x
mul_pp r9.xyz, r5, c0
mul r9.xyz, r1.y, r9
add r1.y, -r1, c12.z
mad r9.xyz, r1.y, c0, r9
add_pp r1.xyz, r4, r6
dp3_pp r3.w, r1, r1
rsq_pp r1.w, r3.w
mul_pp r1.xyz, r1.w, r1
dp3_pp r1.w, r3, r1
mul r1.xyz, r0.x, r5
add r3.w, -r0.x, c12.z
mul r3.xyz, r1, c6
max_pp r0.x, r1.w, c10
pow r1, r0.x, r0.z
mov r0.x, r1
mul_sat r0.x, r7.w, r0
mad r3.xyz, r3.w, r9, r3
mul_pp r3.xyz, r7, r3
mad r1.xyz, r3, r0.w, r10
mul r2.xyz, r2, r0.x
max_pp r0.w, r0.y, c10.x
mul_pp r0.xyz, r7, c0
mad r0.xyz, r0, r0.w, r2
mul r2.xyz, r2.w, r0
texld r0.w, v0, s1
add_sat r0.x, r0.w, c5
mul r1.xyz, r2.w, r1
mul_pp r1.xyz, r0.x, r1
mul_pp r2.xyz, r0.x, r2
add_pp r0.x, -r0, c12.z
mul r8.xyz, r8, r2.w
mad_pp r1.xyz, r0.x, r8, r1
mad_pp oC0.xyz, r1, r0.x, r2
mov_pp oC0.w, c10.x
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Float 2 [_GVar]
Vector 3 [_Color]
Float 4 [_Shininess]
Float 5 [_BlendAdjust1]
Vector 6 [_SSSC]
Float 7 [_Smoothness]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_ScatterMap] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_ExitColorMap] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 277 ALU, 5 TEX
PARAM c[15] = { program.local[0..7],
		{ 0, 1, 2, 0.1 },
		{ 0.73550957, -0.73550957, 0, -1 },
		{ 0.99270076, -0.99270076, 0.44999999, 2.718282 },
		{ 0.5, 0.39894229, 3.5, 0.001 },
		{ 7, 3.141593, -0.018729299, 0.074261002 },
		{ 0.21211439, 1.570729, 1.3, 0.69999999 },
		{ 3.1415927, 5, 128 } };
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
MOV R2.w, c[10].z;
MUL R0.x, fragment.texcoord[1].y, fragment.texcoord[1].y;
MAD R0.x, fragment.texcoord[1], fragment.texcoord[1], R0;
MAD R0.x, fragment.texcoord[1].z, fragment.texcoord[1].z, R0;
RSQ R0.w, R0.x;
MUL R0.y, R0.w, -fragment.texcoord[1].z;
MUL R0.x, R0.y, c[9];
COS R0.z, R0.x;
MAD R0.y, R0, c[9], R0.z;
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
MUL R4.w, R2, c[7].x;
MUL R1.xy, R0.y, c[9].zwzw;
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, fragment.texcoord[1];
MAD R0.xyz, R0, c[9].x, R1.xxyw;
MUL R1.x, R0.y, R0.y;
MAD R1.x, R0, R0, R1;
MAD R1.x, R0.z, R0.z, R1;
RSQ R1.x, R1.x;
MUL R1.y, R1.x, -R0.z;
MUL R1.x, R1.y, c[10];
COS R1.z, R1.x;
MAD R1.y, R1, c[10], R1.z;
DP3 R1.x, R0, R0;
RSQ R1.x, R1.x;
MUL R6.xyz, R1.x, R0;
ADD R0.xyz, -R0, fragment.texcoord[1];
MUL R1.zw, R1.y, c[9];
MAD R1.xyz, R6, c[10].x, R1.zzww;
DP3 R1.w, R1, R1;
RSQ R1.w, R1.w;
MUL R2.xyz, R1.w, R1;
ADD R1.xyz, -R1, fragment.texcoord[1];
MUL R0.y, R0, R0;
MAD R0.x, R0, R0, R0.y;
MAD R0.y, R0.z, R0.z, R0.x;
MOV R1.w, c[8];
RSQ R0.y, R0.y;
RCP R0.y, R0.y;
MUL R9.xyz, R6, R4.w;
MAD R3.xyz, R6, -R4.w, fragment.texcoord[1];
MUL R1.w, R1, c[7].x;
MAD R3.xyz, -R1.w, R2, R3;
MUL R2.x, R3.y, R3.y;
MAD R2.x, R3, R3, R2;
MAD R2.x, R3.z, R3.z, R2;
RSQ R2.x, R2.x;
RCP R2.z, R2.x;
ADD R2.xy, R3, -fragment.texcoord[1];
ADD R6.xyz, fragment.texcoord[1], -R9;
MUL R2.xy, R1.w, R2;
MUL R2.z, R0.w, R2;
MUL R5.xy, R2, R2.z;
TEX R2.yw, fragment.texcoord[0].zwzw, texture[2], 2D;
MAD R4.xy, R2.wyzw, c[8].z, -c[8].y;
DP3 R2.x, R3, R3;
RSQ R2.x, R2.x;
MUL R2.w, R4.y, R4.y;
MAD R2.w, -R4.x, R4.x, -R2;
MUL R2.xyz, R2.x, R3;
MUL R3.w, R1.y, R1.y;
ADD R2.w, R2, c[8].y;
RSQ R1.y, R2.w;
RCP R4.z, R1.y;
MAD R2.w, R1.x, R1.x, R3;
MAD R1.y, R1.z, R1.z, R2.w;
DP3 R1.x, R4, R2;
MAX R2.w, R1.x, c[8].x;
RSQ R1.x, R1.y;
ADD R1.y, -R1.w, -R4.w;
MAD R1.zw, -R5.xyxy, c[11].w, fragment.texcoord[0].xyxy;
DP3 R5.x, R3, fragment.texcoord[1];
RCP R1.x, R1.x;
MUL R1.x, R1, c[2];
ADD R1.y, R1, c[8].z;
MUL R1.y, R1.x, R1;
MUL R1.x, R2.w, R2.w;
MUL R1.x, R1, R1.y;
MUL R3.w, R1.x, R1.y;
TEX R1, R1.zwzw, texture[3], 2D;
MUL R3.xyz, R1, c[0];
MUL_SAT R5.x, R5, c[7];
MUL R3.xyz, R5.x, R3;
ADD R5.x, -R5, c[8].y;
MAD R5.xyz, R5.x, c[0], R3;
MUL R3.w, R3, c[11].x;
POW R3.x, c[10].w, -R3.w;
MUL R3.x, -R3, c[11].y;
ADD R6.w, R3.x, c[8].y;
MUL R5.w, R2, R6;
ADD_SAT R2.w, -R5, c[8].y;
POW R2.w, R2.w, c[11].z;
MUL R1.w, R2, R1;
MUL_SAT R1.w, R1, c[12].x;
MUL R1.xyz, R1.w, R1;
DP3 R3.y, fragment.texcoord[2], fragment.texcoord[2];
RSQ R3.y, R3.y;
MUL R3.xyz, R3.y, fragment.texcoord[2];
ADD R2.xyz, R2, R3;
DP3 R3.w, R2, R2;
RSQ R3.w, R3.w;
MUL R2.xyz, R3.w, R2;
DP3 R3.w, R4, R2;
DP3 R2.x, R2, R3;
DP3 R2.y, R6, R6;
ABS R2.w, R3;
MUL R1.xyz, R1, c[6];
ADD R1.w, -R1, c[8].y;
MAD R5.xyz, R1.w, R5, R1;
ADD R1.y, -R2.w, c[8];
MAD R1.x, R2.w, c[12].z, c[12].w;
MAD R1.x, R1, R2.w, -c[13];
MAD R1.x, R1, R2.w, c[13].y;
RSQ R1.y, R1.y;
RCP R1.y, R1.y;
MUL R7.x, R1, R1.y;
TEX R1, fragment.texcoord[0], texture[0], 2D;
SLT R2.w, R3, c[8].x;
MUL R7.y, R2.w, R7.x;
MAD R7.x, -R7.y, c[8].z, R7;
MUL R1.xyz, R1, c[3];
MAD R2.w, R2, c[12].y, R7.x;
MOV R7.y, c[7].x;
MAD R8.x, R7.y, c[13].z, c[13].w;
COS R2.w, R2.w;
MUL R2.w, R2, R2;
MUL R8.w, R8.x, R8.x;
MUL R7.y, R2.w, R8.w;
MUL R7.x, R2.w, R8;
MUL R7.y, R2.w, R7;
MUL R7.x, R7, R8;
RCP R9.z, R2.x;
MUL R5.xyz, R1, R5;
MUL R7.y, R7, c[14].x;
RCP R7.x, R7.x;
ADD R2.w, -R2, c[8].y;
MUL R2.w, R2, R7.x;
RCP R7.x, R7.y;
MOV R7.y, c[8];
ADD R9.w, R7.y, -c[4].x;
DP3 R7.y, R4, R3;
POW R2.w, c[10].w, -R2.w;
MUL R2.w, R2, R7.x;
ADD R7.x, -R3.w, c[8].y;
POW R7.x, R7.x, c[14].y;
MAD R7.x, R7, c[4], R9.w;
MUL R2.w, R2, R7.x;
RCP R7.w, R7.y;
MUL R2.w, R1, R2;
MUL_SAT R8.y, R2.w, R7.w;
MUL R2.w, R3, R7.y;
MUL R2.x, R2.w, R9.z;
RSQ R2.y, R2.y;
MUL R7.xyz, R2.y, R6;
MUL R8.z, R2.x, c[8];
ADD R2.xyz, R3, R7;
DP3 R2.w, R4, fragment.texcoord[1];
MUL R10.x, R3.w, R2.w;
MUL R9.z, R9, R10.x;
DP3 R10.y, R2, R2;
RSQ R10.y, R10.y;
MUL R2.xyz, R10.y, R2;
DP3 R10.x, R4, R2;
ABS R2.y, R10.x;
MAX R2.x, R3.w, c[8];
ADD R3.w, -R2.y, c[8].y;
MAD R2.z, R2.y, c[12], c[12].w;
MAD R2.z, R2, R2.y, -c[13].x;
MAD R2.y, R2.z, R2, c[13];
DP3 R0.x, R4, R7;
MUL R9.z, R9, c[8];
RSQ R3.w, R3.w;
MIN_SAT R9.z, R8, R9;
RCP R3.w, R3.w;
MUL R8.z, R2.y, R3.w;
MOV R2.z, c[14];
MUL R3.w, R2.z, c[4].x;
SLT R2.y, R10.x, c[8].x;
MUL R2.z, R2.y, R8;
MAD R2.z, -R2, c[8], R8;
MAD R2.y, R2, c[12], R2.z;
COS R2.y, R2.y;
MUL R10.y, R2, R2;
MUL R8.w, R8, R10.y;
MUL R8.w, R10.y, R8;
POW R2.x, R2.x, R3.w;
MUL R2.x, R1.w, R2;
MUL R2.x, R2, c[11];
MAD R2.x, R8.y, R9.z, R2;
MUL_SAT R8.y, R6.w, R2.x;
MUL R6.w, R8.x, R10.y;
MUL R6.w, R8.x, R6;
RCP R10.z, R6.w;
ADD R6.w, -R10.y, c[8].y;
MOV R2.xyz, c[1];
MUL R2.xyz, R2, c[0];
MUL R8.xyz, R2, R8.y;
MAD R5.xyz, R5, R5.w, R8;
MUL R6.w, R6, R10.z;
ADD R10.y, -R10.x, c[8];
MUL R8.w, R8, c[14].x;
POW R10.y, R10.y, c[14].y;
MAX R0.x, R0, c[8];
ADD R0.z, -R4.w, c[8].y;
MUL R0.y, R0, c[2].x;
MUL R0.z, R0.y, R0;
MUL R0.y, R0.x, R0.x;
MUL R0.y, R0, R0.z;
MUL R0.y, R0, R0.z;
MUL R0.z, R6.y, R6.y;
MAD R0.z, R6.x, R6.x, R0;
MAD R0.z, R6, R6, R0;
MUL R0.y, R0, c[11].x;
POW R0.y, c[10].w, -R0.y;
MUL R0.y, -R0, c[11];
RSQ R0.z, R0.z;
RCP R0.z, R0.z;
ADD R0.y, R0, c[8];
MUL R0.z, R0.w, R0;
ADD R3.xyz, fragment.texcoord[1], R3;
POW R6.w, c[10].w, -R6.w;
RCP R8.w, R8.w;
MAD R9.w, R10.y, c[4].x, R9;
MUL R6.w, R6, R8;
MUL R6.w, R6, R9;
MUL R5.w, R1, R6;
MAX R6.w, R10.x, c[8].x;
POW R6.w, R6.w, R3.w;
MUL R6.w, R1, R6;
MUL R6.w, R6, c[11].x;
MUL_SAT R5.w, R7, R5;
MAD R5.w, R9.z, R5, R6;
MUL_SAT R5.w, R0.y, R5;
MUL R7.xyz, R2, R5.w;
MUL R5.w, R0.x, R0.y;
MUL R0.xy, R4.w, -R9;
MUL R0.xy, R0, R0.z;
ADD_SAT R0.z, -R5.w, c[8].y;
DP3 R6.w, fragment.texcoord[1], R6;
POW R4.w, R0.z, c[11].z;
MAD R0.xy, -R0, c[11].w, fragment.texcoord[0];
TEX R0, R0, texture[3], 2D;
MUL R0.w, R4, R0;
MUL_SAT R0.w, R0, c[12].x;
MUL R6.xyz, R0, c[0];
MUL_SAT R6.w, R6, c[7].x;
MUL R6.xyz, R6.w, R6;
ADD R6.w, -R6, c[8].y;
MAD R6.xyz, R6.w, c[0], R6;
DP3 R6.w, R3, R3;
MUL R0.xyz, R0.w, R0;
RSQ R6.w, R6.w;
ADD R4.w, -R0, c[8].y;
MUL R3.xyz, R6.w, R3;
MUL R0.xyz, R0, c[6];
DP3 R0.w, R4, R3;
MAD R0.xyz, R4.w, R6, R0;
MUL R0.xyz, R1, R0;
MAX R0.w, R0, c[8].x;
POW R0.w, R0.w, R3.w;
MUL_SAT R0.w, R1, R0;
MUL R2.xyz, R2, R0.w;
MAD R0.xyz, R0, R5.w, R7;
MUL R0.xyz, R0, c[8].z;
MAX R0.w, R2, c[8].x;
MUL R1.xyz, R1, c[0];
MAD R1.xyz, R1, R0.w, R2;
TEX R0.w, fragment.texcoord[0], texture[1], 2D;
ADD_SAT R0.w, R0, c[5].x;
MUL R2.xyz, R1, c[8].z;
MUL R1.xyz, R0.w, R0;
ADD R0.x, -R0.w, c[8].y;
MUL R5.xyz, R5, c[8].z;
MUL R2.xyz, R0.w, R2;
MAD R1.xyz, R0.x, R5, R1;
MAD result.color.xyz, R1, R0.x, R2;
MOV result.color.w, c[8].x;
END
# 277 instructions, 11 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Float 2 [_GVar]
Vector 3 [_Color]
Float 4 [_Shininess]
Float 5 [_BlendAdjust1]
Vector 6 [_SSSC]
Float 7 [_Smoothness]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_ScatterMap] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_ExitColorMap] 2D
"ps_3_0
; 336 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c8, 2.00000000, -1.00000000, 0.10000000, -0.73550957
def c9, 0.11705996, 0.50000000, 6.28318501, -3.14159298
def c10, 0.00000000, -1.00000000, 0.73550957, -0.99270076
def c11, 0.15799320, 0.50000000, 0.99270076, 0.44999999
def c12, 2.71828198, 0.39894229, 1.00000000, 3.50000000
def c13, 0.00100000, 7.00000000, 0.00000000, 1.00000000
def c14, -0.01872930, 0.07426100, -0.21211439, 1.57072902
def c15, 3.14159298, 0.15915491, 0.50000000, 3.14159274
def c16, 1.29999995, 0.69999999, 5.00000000, 128.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
mul r0.x, v1.y, v1.y
mad r0.x, v1, v1, r0
mad r0.x, v1.z, v1.z, r0
rsq r3.w, r0.x
mul r1.x, r3.w, -v1.z
mad r0.x, r1, c9, c9.y
frc r0.x, r0
mad r1.y, r0.x, c9.z, c9.w
sincos r0.xy, r1.y
mad r0.z, r1.x, c8.w, r0.x
dp3 r0.y, v1, v1
mul r1.xy, r0.z, c10
rsq r0.x, r0.y
mul r0.xyz, r0.x, v1
mad r3.xyz, r0, c10.z, r1.xxyw
mul r0.x, r3.y, r3.y
mad r0.x, r3, r3, r0
mad r0.x, r3.z, r3.z, r0
rsq r0.x, r0.x
mul r1.x, r0, -r3.z
mad r0.x, r1, c11, c11.y
frc r0.x, r0
mad r1.y, r0.x, c9.z, c9.w
sincos r0.xy, r1.y
mad r0.z, r1.x, c10.w, r0.x
dp3 r0.y, r3, r3
rsq r0.x, r0.y
mul r1.xyz, r0.x, r3
mul r0.zw, r0.z, c10.xyxy
mad r8.xyz, r1, c11.z, r0.zzww
dp3 r0.x, r8, r8
mov r0.w, c7.x
mul r4.w, c11, r0
mov r0.w, c7.x
rsq r0.x, r0.x
mul r0.xyz, r0.x, r8
add r3.xyz, -r3, v1
mad r2.xyz, r1, -r4.w, v1
mul r7.w, c8.z, r0
mad r5.xyz, -r7.w, r0, r2
dp3 r0.x, r5, r5
texld r0.yw, v0.zwzw, s2
mad_pp r4.xy, r0.wyzw, c8.x, c8.y
rsq r0.x, r0.x
mul r7.xyz, r0.x, r5
dp3_pp r0.x, v2, v2
rsq_pp r0.x, r0.x
mul_pp r6.xyz, r0.x, v2
add r0.xyz, r7, r6
dp3 r1.w, r0, r0
rsq r1.w, r1.w
mul_pp r0.w, r4.y, r4.y
mad_pp r0.w, -r4.x, r4.x, -r0
add_pp r0.w, r0, c12.z
rsq_pp r0.w, r0.w
rcp_pp r4.z, r0.w
mul r9.xyz, r1, r4.w
dp3_pp r1.x, r4, r6
mul r0.xyz, r1.w, r0
dp3 r0.w, r4, r0
abs r1.w, r0
add r2.y, -r1.w, c12.z
mad r2.x, r1.w, c14, c14.y
mad r2.x, r2, r1.w, c14.z
rsq r2.y, r2.y
add r8.xyz, -r8, v1
mad r1.w, r2.x, r1, c14
rcp r2.y, r2.y
mul r2.x, r1.w, r2.y
cmp r1.w, r0, c13.z, c13
mul r2.y, r1.w, r2.x
mad r2.x, -r2.y, c8, r2
mad r1.w, r1, c15.x, r2.x
mad r1.w, r1, c15.y, c15.z
frc r1.w, r1
mad r1.w, r1, c9.z, c9
sincos r2.xy, r1.w
mov r1.w, c7.x
mad r6.w, r1, c16.x, c16.y
mul r1.w, r2.x, r2.x
mul r2.x, r1.w, r6.w
mul r2.x, r2, r6.w
mul r5.w, r6, r6
rcp r2.y, r2.x
add r2.x, -r1.w, c12.z
mul r2.z, r1.w, r5.w
mul r1.w, r1, r2.z
mul r8.w, r2.x, r2.y
pow r2, c12.x, -r8.w
mul r1.w, r1, c15
add r8.w, -r0, c12.z
rcp r10.w, r1.x
rcp r1.w, r1.w
mul r1.w, r2.x, r1
pow r2, r8.w, c16.z
mul r2.y, r8, r8
mad r2.z, r8.x, r8.x, r2.y
dp3 r2.y, r4, r7
max r7.x, r2.y, c10
mad r2.z, r8, r8, r2
rsq r2.y, r2.z
add r2.z, -r7.w, -r4.w
rcp r2.y, r2.y
mov r7.z, r2.x
mul r2.y, r2, c2.x
add r2.z, r2, c8.x
mul r2.z, r2.y, r2
mul r2.y, r7.x, r7.x
mul r2.y, r2, r2.z
mul r2.x, r2.y, r2.z
mov_pp r2.y, c4.x
add_pp r8.w, c12.z, -r2.y
mul r7.y, r2.x, c9
pow r2, c12.x, -r7.y
mad r10.x, -r2, c12.y, c12.z
mad r8.x, r7.z, c4, r8.w
mul r9.w, r7.x, r10.x
mul r2.y, r5, r5
mad r2.y, r5.x, r5.x, r2
mad r2.x, r5.z, r5.z, r2.y
rsq r2.x, r2.x
rcp r2.z, r2.x
add r2.xy, r5, -v1
dp3 r5.x, r5, v1
mul r2.z, r3.w, r2
mul r2.xy, r7.w, r2
mul r7.xy, r2, r2.z
add_sat r7.z, -r9.w, c12
pow r2, r7.z, c12.w
mad r7.xy, -r7, c13.x, v0
texld r7, r7, s3
mul r2.x, r2, r7.w
mul_sat r2.w, r2.x, c13.y
mul r1.w, r1, r8.x
add r7.w, -r2, c12.z
mul_pp r2.xyz, r7, c0
mul_sat r5.x, r5, c7
mul r2.xyz, r5.x, r2
add r5.x, -r5, c12.z
mad r5.xyz, r5.x, c0, r2
mul r2.xyz, r2.w, r7
mul r7.xyz, r2, c6
texld r2, v0, s0
mad r5.xyz, r7.w, r5, r7
add r7.xyz, v1, -r9
mul_pp r2.xyz, r2, c3
dp3 r1.y, r7, r7
rsq r1.z, r1.y
mul r1.y, r0.w, r1.x
dp3_pp r1.x, r0, r6
mul r8.xyz, r1.z, r7
add r0.xyz, r6, r8
rcp r1.x, r1.x
mul r1.y, r1, r1.x
mul r1.w, r2, r1
dp3 r1.z, r0, r0
rsq r1.z, r1.z
mul r0.xyz, r1.z, r0
dp3 r11.y, r4, r0
abs r0.y, r11
dp3_pp r7.w, r4, v1
mul r0.x, r0.w, r7.w
mul r0.x, r1, r0
add r1.x, -r0.y, c12.z
mad r0.z, r0.y, c14.x, c14.y
mad r0.z, r0, r0.y, c14
rsq r1.x, r1.x
mul_pp r5.xyz, r2, r5
mul_sat r10.y, r1.w, r10.w
mad r0.y, r0.z, r0, c14.w
rcp r1.x, r1.x
mul r0.z, r0.y, r1.x
cmp r0.y, r11, c13.z, c13.w
mul r1.x, r0.y, r0.z
mad r0.z, -r1.x, c8.x, r0
mul r1.y, r1, c8.x
mul r0.x, r0, c8
min_sat r11.x, r1.y, r0
mad r0.x, r0.y, c15, r0.z
mad r0.z, r0.x, c15.y, c15
mov_pp r0.x, c4
frc r0.z, r0
mul_pp r9.z, c16.w, r0.x
max r0.y, r0.w, c10.x
pow r1, r0.y, r9.z
mad r10.z, r0, c9, c9.w
sincos r0.xy, r10.z
mul r1.w, r0.x, r0.x
mov r0.y, r1.x
mul r0.x, r2.w, r0.y
mul r0.y, r6.w, r1.w
mul r0.y, r6.w, r0
rcp r0.z, r0.y
add r0.y, -r1.w, c12.z
mul r0.x, r0, c9.y
mad r0.x, r10.y, r11, r0
mul_sat r6.w, r10.x, r0.x
mul r1.x, r0.y, r0.z
pow r0, c12.x, -r1.x
mov_pp r1.xyz, c0
mul_pp r1.xyz, c1, r1
mul r5.w, r5, r1
mul r10.xyz, r1, r6.w
mov r6.w, r0.x
add r11.z, -r11.y, c12
pow r0, r11.z, c16.z
mul r0.y, r1.w, r5.w
mov r0.z, r0.x
mul r0.y, r0, c15.w
rcp r0.x, r0.y
mad r0.y, r0.z, c4.x, r8.w
mul r0.x, r6.w, r0
mul r0.w, r0.x, r0.y
mad r0.xyz, r5, r9.w, r10
mul r0.w, r2, r0
mul r5.xyz, r0, c8.x
mul_sat r1.w, r10, r0
max r5.w, r11.y, c10.x
pow r0, r5.w, r9.z
mul r0.y, r3, r3
mov r0.z, r0.x
mad r0.y, r3.x, r3.x, r0
dp3 r0.x, r4, r8
mad r0.y, r3.z, r3.z, r0
max r3.x, r0, c10
rsq r0.y, r0.y
rcp r0.x, r0.y
mul r0.x, r0, c2
add r0.y, -r4.w, c12.z
mul r0.y, r0.x, r0
mul r0.x, r3, r3
mul r0.x, r0, r0.y
mul r0.x, r0, r0.y
mul r0.z, r2.w, r0
mul r0.y, r0.z, c9
mad r1.w, r11.x, r1, r0.y
mul r3.y, r0.x, c9
pow r0, c12.x, -r3.y
mul r0.y, r7, r7
mad r0.x, -r0, c12.y, c12.z
mul_sat r0.z, r0.x, r1.w
mul r1.w, r3.x, r0.x
mad r0.y, r7.x, r7.x, r0
mad r0.y, r7.z, r7.z, r0
rsq r0.y, r0.y
mul r8.xyz, r1, r0.z
rcp r0.y, r0.y
mul r0.z, r3.w, r0.y
mul r0.xy, r4.w, -r9
mul r0.xy, r0, r0.z
add_sat r3.z, -r1.w, c12
mad r3.xy, -r0, c13.x, v0
pow r0, r3.z, c12.w
dp3 r0.y, v1, r7
texld r3, r3, s3
mul_pp r7.xyz, r3, c0
mul_sat r0.y, r0, c7.x
mul r7.xyz, r0.y, r7
add r0.y, -r0, c12.z
mul r0.x, r0, r3.w
mul_sat r0.w, r0.x, c13.y
mad r7.xyz, r0.y, c0, r7
add_pp r6.xyz, v1, r6
dp3_pp r0.y, r6, r6
rsq_pp r0.y, r0.y
mul_pp r0.xyz, r0.y, r6
dp3_pp r4.x, r4, r0
mul r0.xyz, r0.w, r3
add r3.w, -r0, c12.z
mul r3.xyz, r0, c6
max_pp r4.x, r4, c10
pow r0, r4.x, r9.z
mov r0.w, r0.x
mad r3.xyz, r3.w, r7, r3
mul_pp r3.xyz, r2, r3
mad r0.xyz, r3, r1.w, r8
mul_sat r0.w, r2, r0
mul r3.xyz, r1, r0.w
mul r0.xyz, r0, c8.x
mul_pp r1.xyz, r2, c0
max_pp r0.w, r7, c10.x
mad r1.xyz, r1, r0.w, r3
texld r0.w, v0, s1
add_sat r0.w, r0, c5.x
mul r2.xyz, r1, c8.x
mul_pp r1.xyz, r0.w, r0
add_pp r0.x, -r0.w, c12.z
mul_pp r2.xyz, r0.w, r2
mad_pp r1.xyz, r0.x, r5, r1
mad_pp oC0.xyz, r1, r0.x, r2
mov_pp oC0.w, c10.x
"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Float 2 [_GVar]
Vector 3 [_Color]
Float 4 [_Shininess]
Float 5 [_BlendAdjust1]
Vector 6 [_SSSC]
Float 7 [_Smoothness]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_ScatterMap] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_LightTexture0] 2D
SetTexture 4 [_LightTextureB0] 2D
SetTexture 5 [_ExitColorMap] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 291 ALU, 7 TEX
PARAM c[15] = { program.local[0..7],
		{ 0, 1, 2, 0.1 },
		{ 0.73550957, -0.73550957, 0, -1 },
		{ 0.99270076, -0.99270076, 0.44999999, 2.718282 },
		{ 0.5, 0.39894229, 3.5, 0.001 },
		{ 7, 3.141593, -0.018729299, 0.074261002 },
		{ 0.21211439, 1.570729, 1.3, 0.69999999 },
		{ 3.1415927, 5, 128 } };
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
TEMP R11;
MOV R1.w, c[10].z;
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.x, R0.x;
MUL R3.xyz, R0.x, fragment.texcoord[1];
MUL R0.x, R3.y, R3.y;
MAD R0.x, R3, R3, R0;
MAD R0.x, R3.z, R3.z, R0;
RSQ R3.w, R0.x;
MUL R0.y, R3.w, -R3.z;
MUL R0.x, R0.y, c[9];
COS R0.z, R0.x;
DP3 R0.x, R3, R3;
MAD R0.y, R0, c[9], R0.z;
MUL R4.w, R1, c[7].x;
MUL R1.xy, R0.y, c[9].zwzw;
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, R3;
MAD R0.xyz, R0, c[9].x, R1.xxyw;
MUL R0.w, R0.y, R0.y;
MAD R0.w, R0.x, R0.x, R0;
MAD R0.w, R0.z, R0.z, R0;
RSQ R0.w, R0.w;
MUL R1.x, R0.w, -R0.z;
MUL R0.w, R1.x, c[10].x;
COS R1.y, R0.w;
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R5.xyz, R0.w, R0;
ADD R0.xyz, -R0, R3;
MUL R0.y, R0, R0;
MAD R0.x, R0, R0, R0.y;
MAD R0.y, R0.z, R0.z, R0.x;
MAD R1.x, R1, c[10].y, R1.y;
MUL R1.xy, R1.x, c[9].zwzw;
MAD R1.xyz, R5, c[10].x, R1.xxyw;
DP3 R0.w, R1, R1;
RSQ R0.w, R0.w;
MUL R2.xyz, R0.w, R1;
MOV R0.w, c[8];
ADD R1.xyz, -R1, R3;
MUL R10.xyz, R5, R4.w;
MAD R4.xyz, R5, -R4.w, R3;
MUL R0.w, R0, c[7].x;
MAD R4.xyz, -R0.w, R2, R4;
DP3 R5.w, R4, R3;
MUL R1.w, R4.y, R4.y;
TEX R2.yw, fragment.texcoord[0].zwzw, texture[2], 2D;
MAD R2.xy, R2.wyzw, c[8].z, -c[8].y;
DP3 R2.z, R4, R4;
RSQ R2.w, R2.z;
MUL R7.xyz, R2.w, R4;
MUL R2.z, R2.y, R2.y;
MAD R2.z, -R2.x, R2.x, -R2;
MUL R2.w, R1.y, R1.y;
ADD R2.z, R2, c[8].y;
RSQ R1.y, R2.z;
RCP R2.z, R1.y;
MAD R2.w, R1.x, R1.x, R2;
DP3 R1.x, R2, R7;
MAD R1.y, R1.z, R1.z, R2.w;
MAX R2.w, R1.x, c[8].x;
RSQ R1.x, R1.y;
MAD R1.w, R4.x, R4.x, R1;
ADD R1.y, -R0.w, -R4.w;
RCP R1.x, R1.x;
MAD R1.z, R4, R4, R1.w;
MUL_SAT R5.w, R5, c[7].x;
MUL R1.x, R1, c[2];
ADD R1.y, R1, c[8].z;
MUL R1.y, R1.x, R1;
MUL R1.x, R2.w, R2.w;
MUL R1.x, R1, R1.y;
MUL R1.x, R1, R1.y;
RSQ R1.y, R1.z;
RCP R1.w, R1.y;
MUL R1.z, R1.x, c[11].x;
ADD R1.xy, R4, -R3;
MUL R1.xy, R0.w, R1;
MUL R1.w, R3, R1;
MUL R1.xy, R1, R1.w;
POW R0.w, c[10].w, -R1.z;
MUL R0.w, -R0, c[11].y;
ADD R6.w, R0, c[8].y;
MAD R1.xy, -R1, c[11].w, fragment.texcoord[0];
TEX R1, R1, texture[5], 2D;
MUL R4.xyz, R1, c[0];
MUL R4.xyz, R5.w, R4;
ADD R0.w, -R5, c[8].y;
MUL R5.w, R2, R6;
MAD R6.xyz, R0.w, c[0], R4;
ADD_SAT R0.w, -R5, c[8].y;
POW R0.w, R0.w, c[11].z;
MUL R7.w, R0, R1;
RCP R0.w, fragment.texcoord[3].w;
MAD R8.xy, fragment.texcoord[3], R0.w, c[11].x;
DP3 R2.w, fragment.texcoord[2], fragment.texcoord[2];
RSQ R2.w, R2.w;
MUL R4.xyz, R2.w, fragment.texcoord[2];
ADD R7.xyz, R7, R4;
DP3 R1.w, fragment.texcoord[3], fragment.texcoord[3];
DP3 R8.z, R7, R7;
TEX R0.w, R8, texture[3], 2D;
SLT R2.w, c[8].x, fragment.texcoord[3].z;
MUL R0.w, R2, R0;
TEX R1.w, R1.w, texture[4], 2D;
MUL R2.w, R0, R1;
RSQ R1.w, R8.z;
MUL R7.xyz, R1.w, R7;
DP3 R8.w, R2, R7;
DP3 R7.y, R7, R4;
MUL R0.w, R7, R2;
MUL_SAT R0.w, R0, c[12].x;
MUL R1.xyz, R0.w, R1;
ABS R1.w, R8;
MUL R1.xyz, R1, c[6];
ADD R0.w, -R0, c[8].y;
MAD R6.xyz, R0.w, R6, R1;
ADD R1.x, -R1.w, c[8].y;
MAD R0.w, R1, c[12].z, c[12];
MAD R0.w, R0, R1, -c[13].x;
RSQ R1.x, R1.x;
MAD R0.w, R0, R1, c[13].y;
RCP R1.x, R1.x;
MUL R7.w, R0, R1.x;
TEX R1, fragment.texcoord[0], texture[0], 2D;
SLT R0.w, R8, c[8].x;
MUL R8.x, R0.w, R7.w;
MAD R7.w, -R8.x, c[8].z, R7;
MUL R1.xyz, R1, c[3];
MAD R0.w, R0, c[12].y, R7;
MOV R8.x, c[7];
MAD R11.x, R8, c[13].z, c[13].w;
COS R0.w, R0.w;
MUL R0.w, R0, R0;
MUL R9.w, R11.x, R11.x;
MUL R7.w, R0, R11.x;
MUL R7.w, R7, R11.x;
MUL R8.x, R0.w, R9.w;
MUL R8.x, R0.w, R8;
RCP R9.y, R7.y;
MUL R6.xyz, R1, R6;
MUL R8.x, R8, c[14];
RCP R7.w, R7.w;
ADD R0.w, -R0, c[8].y;
MUL R0.w, R0, R7;
RCP R7.w, R8.x;
MOV R8.x, c[8].y;
ADD R10.w, R8.x, -c[4].x;
DP3 R8.x, R2, R4;
MUL R7.x, R8.w, R8;
MUL R5.x, R7, R9.y;
POW R0.w, c[10].w, -R0.w;
MUL R0.w, R0, R7;
ADD R7.w, -R8, c[8].y;
POW R7.w, R7.w, c[14].y;
MAD R7.w, R7, c[4].x, R10;
MUL R7.w, R0, R7;
ADD R7.xyz, R3, -R10;
MUL R9.z, R5.x, c[8];
DP3 R5.x, R7, R7;
RCP R0.w, R8.x;
RSQ R5.y, R5.x;
MUL R8.xyz, R5.y, R7;
DP3 R0.x, R2, R8;
MUL R7.w, R1, R7;
MUL_SAT R9.x, R7.w, R0.w;
DP3 R7.w, R2, R3;
MUL R5.x, R8.w, R7.w;
MUL R9.y, R9, R5.x;
ADD R5.xyz, R4, R8;
MUL R9.y, R9, c[8].z;
MIN_SAT R10.z, R9, R9.y;
DP3 R11.y, R5, R5;
RSQ R9.z, R11.y;
MUL R5.xyz, R9.z, R5;
DP3 R11.y, R2, R5;
ABS R5.y, R11;
MAX R9.y, R8.w, c[8].x;
MAD R5.z, R5.y, c[12], c[12].w;
MOV R8.w, c[14].z;
MUL R8.w, R8, c[4].x;
POW R5.x, R9.y, R8.w;
ADD R9.y, -R5, c[8];
MAD R5.z, R5, R5.y, -c[13].x;
RSQ R9.y, R9.y;
MUL R5.x, R1.w, R5;
MUL R5.x, R5, c[11];
MAD R5.x, R9, R10.z, R5;
MAX R0.z, R0.x, c[8].x;
RSQ R0.y, R0.y;
RCP R0.x, R0.y;
MAD R5.y, R5.z, R5, c[13];
RCP R9.y, R9.y;
MUL R5.z, R5.y, R9.y;
SLT R5.y, R11, c[8].x;
MUL R9.y, R5, R5.z;
MAD R5.z, -R9.y, c[8], R5;
MAD R5.y, R5, c[12], R5.z;
MUL_SAT R9.x, R6.w, R5;
COS R5.y, R5.y;
MUL R6.w, R5.y, R5.y;
MUL R11.z, R11.x, R6.w;
MOV R5.xyz, c[1];
MUL R5.xyz, R5, c[0];
MUL R9.xyz, R5, R9.x;
MAD R6.xyz, R6, R5.w, R9;
MUL R11.x, R11, R11.z;
RCP R9.x, R11.x;
ADD R5.w, -R6, c[8].y;
MUL R5.w, R5, R9.x;
MUL R9.x, R9.w, R6.w;
MUL R6.w, R6, R9.x;
ADD R9.x, -R11.y, c[8].y;
MUL R6.w, R6, c[14].x;
POW R9.x, R9.x, c[14].y;
RCP R6.w, R6.w;
POW R5.w, c[10].w, -R5.w;
MUL R5.w, R5, R6;
MAD R9.x, R9, c[4], R10.w;
MUL R6.w, R5, R9.x;
MUL R5.w, R2, c[8].z;
MUL R6.w, R1, R6;
MUL_SAT R0.w, R0, R6;
MAX R6.w, R11.y, c[8].x;
POW R6.w, R6.w, R8.w;
MUL R6.w, R1, R6;
MUL R6.w, R6, c[11].x;
ADD R0.y, -R4.w, c[8];
MUL R0.x, R0, c[2];
MUL R0.y, R0.x, R0;
MUL R0.x, R0.z, R0.z;
MUL R0.x, R0, R0.y;
MUL R0.x, R0, R0.y;
MUL R0.y, R7, R7;
MAD R0.y, R7.x, R7.x, R0;
MAD R0.y, R7.z, R7.z, R0;
MUL R0.x, R0, c[11];
POW R0.x, c[10].w, -R0.x;
MAD R6.w, R10.z, R0, R6;
MUL R0.x, -R0, c[11].y;
ADD R0.w, R0.x, c[8].y;
RSQ R0.y, R0.y;
MUL_SAT R6.w, R0, R6;
RCP R0.x, R0.y;
MUL R3.w, R3, R0.x;
MUL R0.xy, R4.w, -R10;
MUL R0.xy, R0, R3.w;
MUL R3.w, R0.z, R0;
MAD R0.xy, -R0, c[11].w, fragment.texcoord[0];
ADD_SAT R4.w, -R3, c[8].y;
TEX R0, R0, texture[5], 2D;
POW R4.w, R4.w, c[11].z;
MUL R0.w, R4, R0;
DP3 R4.w, R3, R7;
ADD R3.xyz, R3, R4;
MUL R0.w, R2, R0;
MUL_SAT R0.w, R0, c[12].x;
MUL R7.xyz, R0, c[0];
MUL_SAT R4.w, R4, c[7].x;
MUL R7.xyz, R4.w, R7;
DP3 R4.x, R3, R3;
MUL R0.xyz, R0.w, R0;
ADD R4.w, -R4, c[8].y;
RSQ R4.x, R4.x;
ADD R2.w, -R0, c[8].y;
MUL R3.xyz, R4.x, R3;
DP3 R0.w, R2, R3;
MAX R0.w, R0, c[8].x;
POW R0.w, R0.w, R8.w;
MUL_SAT R0.w, R1, R0;
MUL R2.xyz, R5, R0.w;
MAX R0.w, R7, c[8].x;
MUL R6.xyz, R6, R5.w;
MUL R8.xyz, R5, R6.w;
MAD R7.xyz, R4.w, c[0], R7;
MUL R0.xyz, R0, c[6];
MAD R0.xyz, R2.w, R7, R0;
MUL R0.xyz, R1, R0;
MAD R0.xyz, R0, R3.w, R8;
MUL R1.xyz, R1, c[0];
MAD R1.xyz, R1, R0.w, R2;
TEX R0.w, fragment.texcoord[0], texture[1], 2D;
ADD_SAT R0.w, R0, c[5].x;
MUL R2.xyz, R5.w, R1;
MUL R0.xyz, R5.w, R0;
MUL R1.xyz, R0.w, R0;
ADD R0.x, -R0.w, c[8].y;
MUL R2.xyz, R0.w, R2;
MAD R1.xyz, R0.x, R6, R1;
MAD result.color.xyz, R1, R0.x, R2;
MOV result.color.w, c[8].x;
END
# 291 instructions, 12 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Float 2 [_GVar]
Vector 3 [_Color]
Float 4 [_Shininess]
Float 5 [_BlendAdjust1]
Vector 6 [_SSSC]
Float 7 [_Smoothness]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_ScatterMap] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_LightTexture0] 2D
SetTexture 4 [_LightTextureB0] 2D
SetTexture 5 [_ExitColorMap] 2D
"ps_3_0
; 351 ALU, 7 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
def c8, 2.00000000, -1.00000000, 0.10000000, -0.73550957
def c9, 0.11705996, 0.50000000, 6.28318501, -3.14159298
def c10, 0.00000000, -1.00000000, 0.73550957, -0.99270076
def c11, 0.15799320, 0.50000000, 0.99270076, 0.44999999
def c12, 2.71828198, 0.39894229, 1.00000000, 3.50000000
def c13, 0.00100000, 0.00000000, 1.00000000, 7.00000000
def c14, -0.01872930, 0.07426100, -0.21211439, 1.57072902
def c15, 3.14159298, 0.15915491, 0.50000000, 3.14159274
def c16, 1.29999995, 0.69999999, 5.00000000, 128.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3
dp3_pp r0.x, v1, v1
rsq_pp r0.x, r0.x
mul_pp r2.xyz, r0.x, v1
mul r0.x, r2.y, r2.y
mad r0.x, r2, r2, r0
mad r0.x, r2.z, r2.z, r0
rsq r1.w, r0.x
mul r1.x, r1.w, -r2.z
mad r0.x, r1, c9, c9.y
frc r0.x, r0
mad r1.y, r0.x, c9.z, c9.w
sincos r0.xy, r1.y
mad r0.z, r1.x, c8.w, r0.x
dp3 r0.y, r2, r2
mul r1.xy, r0.z, c10
rsq r0.x, r0.y
mul r0.xyz, r0.x, r2
mad r3.xyz, r0, c10.z, r1.xxyw
mul r0.x, r3.y, r3.y
mad r0.x, r3, r3, r0
mad r0.x, r3.z, r3.z, r0
rsq r0.x, r0.x
mul r1.x, r0, -r3.z
mad r0.x, r1, c11, c11.y
frc r0.x, r0
mad r1.y, r0.x, c9.z, c9.w
sincos r0.xy, r1.y
mad r0.z, r1.x, c10.w, r0.x
dp3 r0.y, r3, r3
rsq r0.x, r0.y
mul r8.xyz, r0.x, r3
add r3.xyz, -r3, r2
mul r0.zw, r0.z, c10.xyxy
mad r6.xyz, r8, c11.z, r0.zzww
dp3 r0.x, r6, r6
mov r0.w, c7.x
mul r2.w, c11, r0
mov r0.w, c7.x
rsq r0.x, r0.x
mul r0.xyz, r0.x, r6
mad r1.xyz, r8, -r2.w, r2
mul r4.w, c8.z, r0
mad r7.xyz, -r4.w, r0, r1
dp3 r0.x, r7, r7
texld r0.yw, v0.zwzw, s2
mad_pp r1.xy, r0.wyzw, c8.x, c8.y
rsq r0.x, r0.x
mul r9.xyz, r0.x, r7
mul_pp r0.w, r1.y, r1.y
mad_pp r0.w, -r1.x, r1.x, -r0
dp3_pp r0.x, v2, v2
rsq_pp r0.x, r0.x
mul_pp r4.xyz, r0.x, v2
add r0.xyz, r9, r4
dp3 r1.z, r0, r0
rsq r1.z, r1.z
add_pp r0.w, r0, c12.z
mul r5.xyz, r1.z, r0
rsq_pp r0.w, r0.w
rcp_pp r1.z, r0.w
dp3 r5.w, r1, r5
abs r0.x, r5.w
add r0.z, -r0.x, c12
mad r0.y, r0.x, c14.x, c14
mad r0.y, r0, r0.x, c14.z
rsq r0.z, r0.z
mad r0.x, r0.y, r0, c14.w
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r0.x, r5.w, c13.y, c13.z
mul r0.z, r0.x, r0.y
mad r0.y, -r0.z, c8.x, r0
mad r0.x, r0, c15, r0.y
mad r0.x, r0, c15.y, c15.z
frc r0.x, r0
mad r3.w, r0.x, c9.z, c9
sincos r0.xy, r3.w
mov r0.y, c7.x
mad r8.w, r0.y, c16.x, c16.y
mul r6.w, r0.x, r0.x
mul r0.x, r6.w, r8.w
mul r0.y, r0.x, r8.w
mul r3.w, r8, r8
mul r9.w, r6, r3
add r0.x, -r6.w, c12.z
rcp r0.y, r0.y
mul r7.w, r0.x, r0.y
pow r0, c12.x, -r7.w
mul r0.y, r6.w, r9.w
mul r0.y, r0, c15.w
mov r6.w, r0.x
rcp r0.w, r0.y
add r0.xyz, -r6, r2
mul r10.x, r6.w, r0.w
mul r0.y, r0, r0
mad r0.y, r0.x, r0.x, r0
dp3 r0.x, r1, r9
max r6.x, r0, c10
mad r0.y, r0.z, r0.z, r0
rsq r0.x, r0.y
add r0.y, -r4.w, -r2.w
rcp r0.x, r0.x
add r6.w, -r5, c12.z
add r0.y, r0, c8.x
mul r0.x, r0, c2
mul r6.y, r0.x, r0
mul r0.x, r6, r6
mul r6.z, r0.x, r6.y
pow r0, r6.w, c16.z
mul r0.y, r6.z, r6
mul r6.y, r0, c9
mov r6.z, r0.x
pow r0, c12.x, -r6.y
mov_pp r0.y, c4.x
mad r10.w, -r0.x, c12.y, c12.z
mul r9.w, r6.x, r10
add_pp r7.w, c12.z, -r0.y
mul r0.x, r7.y, r7.y
mad r0.x, r7, r7, r0
mad r9.z, r6, c4.x, r7.w
mad r6.y, r7.z, r7.z, r0.x
add_sat r6.x, -r9.w, c12.z
pow r0, r6.x, c12.w
rsq r0.y, r6.y
add r0.zw, r7.xyxy, -r2.xyxy
dp3 r7.x, r7, r2
rcp r0.y, r0.y
mul r0.y, r1.w, r0
mul r0.zw, r4.w, r0
mul r0.zw, r0, r0.y
mov r10.y, r0.x
mad r0.xy, -r0.zwzw, c13.x, v0
texld r6, r0, s5
rcp r0.z, v3.w
mad r9.xy, v3, r0.z, c9.y
dp3 r0.x, v3, v3
texld r0.w, r9, s3
cmp r0.y, -v3.z, c13, c13.z
mul_pp r0.y, r0, r0.w
texld r0.x, r0.x, s4
mul_pp r4.w, r0.y, r0.x
mul r0.x, r10.y, r6.w
mul r0.w, r10.x, r9.z
mul r10.xyz, r8, r2.w
mul r0.x, r0, r4.w
mul_sat r6.w, r0.x, c13
mul_pp r0.xyz, r6, c0
mul_sat r7.x, r7, c7
mul r0.xyz, r7.x, r0
add r7.x, -r7, c12.z
add r8.xyz, r2, -r10
add r9.x, -r6.w, c12.z
mad r0.xyz, r7.x, c0, r0
mul r6.xyz, r6.w, r6
mul r7.xyz, r6, c6
texld r6, v0, s0
mad r0.xyz, r9.x, r0, r7
mul_pp r6.xyz, r6, c3
mul_pp r7.xyz, r6, r0
dp3_pp r0.y, r1, r4
mul r10.z, r5.w, r0.y
mul r0.x, r6.w, r0.w
rcp r12.y, r0.y
mul_sat r11.x, r0, r12.y
dp3 r0.x, r8, r8
rsq r0.y, r0.x
dp3_pp r0.x, r5, r4
rcp r0.w, r0.x
mul r5.x, r10.z, r0.w
mul r9.xyz, r0.y, r8
add r0.xyz, r4, r9
dp3 r5.y, r0, r0
rsq r5.y, r5.y
mul r0.xyz, r5.y, r0
dp3 r12.z, r1, r0
dp3_pp r10.z, r1, r2
abs r0.y, r12.z
mul r5.y, r5.w, r10.z
mul r0.x, r0.w, r5.y
add r0.w, -r0.y, c12.z
mad r0.z, r0.y, c14.x, c14.y
mad r0.z, r0, r0.y, c14
mad r0.y, r0.z, r0, c14.w
rsq r0.w, r0.w
rcp r0.w, r0.w
mul r0.y, r0, r0.w
cmp r0.z, r12, c13.y, c13
mul r0.w, r0.z, r0.y
mul r5.x, r5, c8
mul r0.x, r0, c8
min_sat r12.x, r5, r0
mad r0.x, -r0.w, c8, r0.y
mad r0.z, r0, c15.x, r0.x
mov_pp r0.x, c4
mul_pp r11.w, c16, r0.x
max r0.y, r5.w, c10.x
mad r0.z, r0, c15.y, c15
pow r5, r0.y, r11.w
frc r0.x, r0.z
mad r5.y, r0.x, c9.z, c9.w
sincos r0.xy, r5.y
mov r0.y, r5.x
mul r5.w, r0.x, r0.x
mul r0.y, r6.w, r0
mul r0.x, r0.y, c9.y
mul r0.y, r8.w, r5.w
mul r0.y, r8.w, r0
mad r0.x, r11, r12, r0
mul_sat r8.w, r10, r0.x
mov_pp r5.xyz, c0
mul_pp r5.xyz, c1, r5
mul r11.xyz, r5, r8.w
mad r7.xyz, r7, r9.w, r11
mul r3.w, r3, r5
add r0.x, -r5.w, c12.z
rcp r0.y, r0.y
mul r10.w, r0.x, r0.y
pow r0, c12.x, -r10.w
mov r8.w, r0.x
add r9.w, -r12.z, c12.z
pow r0, r9.w, c16.z
mul r0.y, r5.w, r3.w
mul_pp r5.w, r4, c8.x
mov r0.z, r0.x
mul r0.y, r0, c15.w
rcp r0.x, r0.y
mad r0.y, r0.z, c4.x, r7.w
mul r0.x, r8.w, r0
mul r0.x, r0, r0.y
mul r0.x, r6.w, r0
mul_sat r3.w, r12.y, r0.x
max r7.w, r12.z, c10.x
pow r0, r7.w, r11.w
mul r3.y, r3, r3
mad r0.y, r3.x, r3.x, r3
mad r0.z, r3, r3, r0.y
dp3 r0.y, r1, r9
max r3.x, r0.y, c10
rsq r0.z, r0.z
rcp r0.y, r0.z
mov r0.w, r0.x
mul r0.y, r0, c2.x
add r0.z, -r2.w, c12
mul r0.z, r0.y, r0
mul r0.y, r3.x, r3.x
mul r0.y, r0, r0.z
mul r0.x, r0.y, r0.z
mul r0.y, r6.w, r0.w
mul r3.y, r0.x, c9
mul r3.z, r0.y, c9.y
pow r0, c12.x, -r3.y
mad r0.z, r12.x, r3.w, r3
mad r0.x, -r0, c12.y, c12.z
mul r7.w, r3.x, r0.x
mul_sat r0.z, r0.x, r0
mul r0.y, r8, r8
mad r0.y, r8.x, r8.x, r0
mad r0.y, r8.z, r8.z, r0
rsq r0.y, r0.y
mul r9.xyz, r5, r0.z
rcp r0.x, r0.y
mul r0.z, r1.w, r0.x
mul r0.xy, r2.w, -r10
mul r3.xy, r0, r0.z
add_sat r3.z, -r7.w, c12
pow r0, r3.z, c12.w
dp3 r0.y, r2, r8
mad r3.xy, -r3, c13.x, v0
texld r3, r3, s5
mov r0.w, r0.x
mul r0.w, r0, r3
mul r0.w, r4, r0
mul_sat r0.w, r0, c13
mul_sat r0.y, r0, c7.x
mul_pp r8.xyz, r3, c0
mul r8.xyz, r0.y, r8
add r0.y, -r0, c12.z
mad r8.xyz, r0.y, c0, r8
add_pp r0.xyz, r2, r4
dp3_pp r1.w, r0, r0
rsq_pp r1.w, r1.w
mul_pp r0.xyz, r1.w, r0
dp3_pp r1.x, r1, r0
max_pp r2.x, r1, c10
mul r0.xyz, r0.w, r3
add r1.w, -r0, c12.z
mul r1.xyz, r0, c6
pow r0, r2.x, r11.w
mov r0.w, r0.x
mul_sat r0.w, r6, r0
mul r2.xyz, r5, r0.w
mad r1.xyz, r1.w, r8, r1
mul_pp r1.xyz, r6, r1
mad r0.xyz, r1, r7.w, r9
mul r0.xyz, r5.w, r0
max_pp r0.w, r10.z, c10.x
mul_pp r1.xyz, r6, c0
mad r1.xyz, r1, r0.w, r2
texld r0.w, v0, s1
add_sat r0.w, r0, c5.x
mul r2.xyz, r5.w, r1
mul_pp r1.xyz, r0.w, r0
add_pp r0.x, -r0.w, c12.z
mul r7.xyz, r7, r5.w
mul_pp r2.xyz, r0.w, r2
mad_pp r1.xyz, r0.x, r7, r1
mad_pp oC0.xyz, r1, r0.x, r2
mov_pp oC0.w, c10.x
"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Float 2 [_GVar]
Vector 3 [_Color]
Float 4 [_Shininess]
Float 5 [_BlendAdjust1]
Vector 6 [_SSSC]
Float 7 [_Smoothness]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_ScatterMap] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_LightTextureB0] 2D
SetTexture 4 [_LightTexture0] CUBE
SetTexture 5 [_ExitColorMap] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 287 ALU, 7 TEX
PARAM c[15] = { program.local[0..7],
		{ 0, 1, 2, 0.1 },
		{ 0.73550957, -0.73550957, 0, -1 },
		{ 0.99270076, -0.99270076, 0.44999999, 2.718282 },
		{ 0.5, 0.39894229, 3.5, 0.001 },
		{ 7, 3.141593, -0.018729299, 0.074261002 },
		{ 0.21211439, 1.570729, 1.3, 0.69999999 },
		{ 3.1415927, 5, 128 } };
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
TEMP R11;
MOV R1.w, c[10].z;
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.x, R0.x;
MUL R3.xyz, R0.x, fragment.texcoord[1];
MUL R0.x, R3.y, R3.y;
MAD R0.x, R3, R3, R0;
MAD R0.x, R3.z, R3.z, R0;
RSQ R3.w, R0.x;
MUL R0.y, R3.w, -R3.z;
MUL R0.x, R0.y, c[9];
COS R0.z, R0.x;
DP3 R0.x, R3, R3;
MAD R0.y, R0, c[9], R0.z;
MUL R4.w, R1, c[7].x;
MUL R1.xy, R0.y, c[9].zwzw;
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, R3;
MAD R0.xyz, R0, c[9].x, R1.xxyw;
MUL R0.w, R0.y, R0.y;
MAD R0.w, R0.x, R0.x, R0;
MAD R0.w, R0.z, R0.z, R0;
RSQ R0.w, R0.w;
MUL R1.x, R0.w, -R0.z;
MUL R0.w, R1.x, c[10].x;
COS R1.y, R0.w;
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R5.xyz, R0.w, R0;
ADD R0.xyz, -R0, R3;
MUL R0.y, R0, R0;
MAD R0.x, R0, R0, R0.y;
MAD R0.y, R0.z, R0.z, R0.x;
MAD R1.x, R1, c[10].y, R1.y;
MUL R1.xy, R1.x, c[9].zwzw;
MAD R1.xyz, R5, c[10].x, R1.xxyw;
DP3 R0.w, R1, R1;
RSQ R0.w, R0.w;
MUL R2.xyz, R0.w, R1;
MOV R0.w, c[8];
ADD R1.xyz, -R1, R3;
MUL R10.xyz, R5, R4.w;
MAD R4.xyz, R5, -R4.w, R3;
MUL R0.w, R0, c[7].x;
MAD R4.xyz, -R0.w, R2, R4;
DP3 R5.w, R4, R3;
MUL R1.w, R4.y, R4.y;
MAD R1.w, R4.x, R4.x, R1;
MAD R1.w, R4.z, R4.z, R1;
TEX R2.yw, fragment.texcoord[0].zwzw, texture[2], 2D;
RSQ R1.w, R1.w;
RCP R1.w, R1.w;
MAD R2.xy, R2.wyzw, c[8].z, -c[8].y;
DP3 R2.z, R4, R4;
RSQ R2.w, R2.z;
MUL R7.xyz, R2.w, R4;
MUL R2.z, R2.y, R2.y;
MAD R2.z, -R2.x, R2.x, -R2;
MUL R2.w, R1.y, R1.y;
ADD R2.z, R2, c[8].y;
RSQ R1.y, R2.z;
RCP R2.z, R1.y;
MAD R2.w, R1.x, R1.x, R2;
DP3 R1.x, R2, R7;
MAD R1.y, R1.z, R1.z, R2.w;
MAX R2.w, R1.x, c[8].x;
RSQ R1.x, R1.y;
ADD R1.y, -R0.w, -R4.w;
RCP R1.x, R1.x;
MUL R1.w, R3, R1;
MUL R1.x, R1, c[2];
ADD R1.y, R1, c[8].z;
MUL R1.y, R1.x, R1;
MUL R1.x, R2.w, R2.w;
MUL R1.x, R1, R1.y;
MUL R1.z, R1.x, R1.y;
ADD R1.xy, R4, -R3;
MUL R1.xy, R0.w, R1;
MUL R1.xy, R1, R1.w;
MUL R0.w, R1.z, c[11].x;
MAD R1.xy, -R1, c[11].w, fragment.texcoord[0];
TEX R1, R1, texture[5], 2D;
POW R0.w, c[10].w, -R0.w;
MUL R0.w, -R0, c[11].y;
ADD R6.w, R0, c[8].y;
MUL R4.xyz, R1, c[0];
MUL_SAT R5.w, R5, c[7].x;
MUL R4.xyz, R5.w, R4;
ADD R5.w, -R5, c[8].y;
MAD R6.xyz, R5.w, c[0], R4;
MUL R5.w, R2, R6;
DP3 R0.w, fragment.texcoord[2], fragment.texcoord[2];
RSQ R2.w, R0.w;
MUL R4.xyz, R2.w, fragment.texcoord[2];
ADD R7.xyz, R7, R4;
ADD_SAT R0.w, -R5, c[8].y;
POW R0.w, R0.w, c[11].z;
MUL R7.w, R0, R1;
DP3 R1.w, fragment.texcoord[3], fragment.texcoord[3];
DP3 R8.x, R7, R7;
TEX R0.w, fragment.texcoord[3], texture[4], CUBE;
TEX R1.w, R1.w, texture[3], 2D;
MUL R2.w, R1, R0;
RSQ R1.w, R8.x;
MUL R7.xyz, R1.w, R7;
DP3 R8.w, R2, R7;
DP3 R7.y, R7, R4;
MUL R0.w, R7, R2;
MUL_SAT R0.w, R0, c[12].x;
MUL R1.xyz, R0.w, R1;
ABS R1.w, R8;
MUL R1.xyz, R1, c[6];
ADD R0.w, -R0, c[8].y;
MAD R6.xyz, R0.w, R6, R1;
ADD R1.x, -R1.w, c[8].y;
MAD R0.w, R1, c[12].z, c[12];
MAD R0.w, R0, R1, -c[13].x;
RSQ R1.x, R1.x;
MAD R0.w, R0, R1, c[13].y;
RCP R1.x, R1.x;
MUL R7.w, R0, R1.x;
TEX R1, fragment.texcoord[0], texture[0], 2D;
SLT R0.w, R8, c[8].x;
MUL R8.x, R0.w, R7.w;
MAD R7.w, -R8.x, c[8].z, R7;
MUL R1.xyz, R1, c[3];
MAD R0.w, R0, c[12].y, R7;
MOV R8.x, c[7];
MAD R11.x, R8, c[13].z, c[13].w;
COS R0.w, R0.w;
MUL R0.w, R0, R0;
MUL R9.w, R11.x, R11.x;
MUL R7.w, R0, R11.x;
MUL R7.w, R7, R11.x;
MUL R8.x, R0.w, R9.w;
MUL R8.x, R0.w, R8;
RCP R9.y, R7.y;
MUL R6.xyz, R1, R6;
MUL R8.x, R8, c[14];
RCP R7.w, R7.w;
ADD R0.w, -R0, c[8].y;
MUL R0.w, R0, R7;
RCP R7.w, R8.x;
MOV R8.x, c[8].y;
ADD R10.w, R8.x, -c[4].x;
DP3 R8.x, R2, R4;
MUL R7.x, R8.w, R8;
MUL R5.x, R7, R9.y;
POW R0.w, c[10].w, -R0.w;
MUL R0.w, R0, R7;
ADD R7.w, -R8, c[8].y;
POW R7.w, R7.w, c[14].y;
MAD R7.w, R7, c[4].x, R10;
MUL R7.w, R0, R7;
ADD R7.xyz, R3, -R10;
MUL R9.z, R5.x, c[8];
DP3 R5.x, R7, R7;
RCP R0.w, R8.x;
RSQ R5.y, R5.x;
MUL R8.xyz, R5.y, R7;
DP3 R0.x, R2, R8;
MUL R7.w, R1, R7;
MUL_SAT R9.x, R7.w, R0.w;
DP3 R7.w, R2, R3;
MUL R5.x, R8.w, R7.w;
MUL R9.y, R9, R5.x;
ADD R5.xyz, R4, R8;
MUL R9.y, R9, c[8].z;
MIN_SAT R10.z, R9, R9.y;
DP3 R11.y, R5, R5;
RSQ R9.z, R11.y;
MUL R5.xyz, R9.z, R5;
DP3 R11.y, R2, R5;
ABS R5.y, R11;
MAX R9.y, R8.w, c[8].x;
MAD R5.z, R5.y, c[12], c[12].w;
MOV R8.w, c[14].z;
MUL R8.w, R8, c[4].x;
POW R5.x, R9.y, R8.w;
ADD R9.y, -R5, c[8];
MAD R5.z, R5, R5.y, -c[13].x;
RSQ R9.y, R9.y;
MUL R5.x, R1.w, R5;
MUL R5.x, R5, c[11];
MAD R5.x, R9, R10.z, R5;
MAX R0.z, R0.x, c[8].x;
RSQ R0.y, R0.y;
RCP R0.x, R0.y;
MAD R5.y, R5.z, R5, c[13];
RCP R9.y, R9.y;
MUL R5.z, R5.y, R9.y;
SLT R5.y, R11, c[8].x;
MUL R9.y, R5, R5.z;
MAD R5.z, -R9.y, c[8], R5;
MAD R5.y, R5, c[12], R5.z;
MUL_SAT R9.x, R6.w, R5;
COS R5.y, R5.y;
MUL R6.w, R5.y, R5.y;
MUL R11.z, R11.x, R6.w;
MOV R5.xyz, c[1];
MUL R5.xyz, R5, c[0];
MUL R9.xyz, R5, R9.x;
MAD R6.xyz, R6, R5.w, R9;
MUL R11.x, R11, R11.z;
RCP R9.x, R11.x;
ADD R5.w, -R6, c[8].y;
MUL R5.w, R5, R9.x;
MUL R9.x, R9.w, R6.w;
MUL R6.w, R6, R9.x;
ADD R9.x, -R11.y, c[8].y;
MUL R6.w, R6, c[14].x;
POW R9.x, R9.x, c[14].y;
RCP R6.w, R6.w;
POW R5.w, c[10].w, -R5.w;
MUL R5.w, R5, R6;
MAD R9.x, R9, c[4], R10.w;
MUL R6.w, R5, R9.x;
MUL R5.w, R2, c[8].z;
MUL R6.w, R1, R6;
MUL_SAT R0.w, R0, R6;
MAX R6.w, R11.y, c[8].x;
POW R6.w, R6.w, R8.w;
MUL R6.w, R1, R6;
MUL R6.w, R6, c[11].x;
ADD R0.y, -R4.w, c[8];
MUL R0.x, R0, c[2];
MUL R0.y, R0.x, R0;
MUL R0.x, R0.z, R0.z;
MUL R0.x, R0, R0.y;
MUL R0.x, R0, R0.y;
MUL R0.y, R7, R7;
MAD R0.y, R7.x, R7.x, R0;
MAD R0.y, R7.z, R7.z, R0;
MUL R0.x, R0, c[11];
POW R0.x, c[10].w, -R0.x;
MAD R6.w, R10.z, R0, R6;
MUL R0.x, -R0, c[11].y;
ADD R0.w, R0.x, c[8].y;
RSQ R0.y, R0.y;
MUL_SAT R6.w, R0, R6;
RCP R0.x, R0.y;
MUL R3.w, R3, R0.x;
MUL R0.xy, R4.w, -R10;
MUL R0.xy, R0, R3.w;
MUL R3.w, R0.z, R0;
MAD R0.xy, -R0, c[11].w, fragment.texcoord[0];
ADD_SAT R4.w, -R3, c[8].y;
TEX R0, R0, texture[5], 2D;
POW R4.w, R4.w, c[11].z;
MUL R0.w, R4, R0;
DP3 R4.w, R3, R7;
ADD R3.xyz, R3, R4;
MUL R0.w, R2, R0;
MUL_SAT R0.w, R0, c[12].x;
MUL R7.xyz, R0, c[0];
MUL_SAT R4.w, R4, c[7].x;
MUL R7.xyz, R4.w, R7;
DP3 R4.x, R3, R3;
MUL R0.xyz, R0.w, R0;
ADD R4.w, -R4, c[8].y;
RSQ R4.x, R4.x;
ADD R2.w, -R0, c[8].y;
MUL R3.xyz, R4.x, R3;
DP3 R0.w, R2, R3;
MAX R0.w, R0, c[8].x;
POW R0.w, R0.w, R8.w;
MUL_SAT R0.w, R1, R0;
MUL R2.xyz, R5, R0.w;
MAX R0.w, R7, c[8].x;
MUL R6.xyz, R6, R5.w;
MUL R8.xyz, R5, R6.w;
MAD R7.xyz, R4.w, c[0], R7;
MUL R0.xyz, R0, c[6];
MAD R0.xyz, R2.w, R7, R0;
MUL R0.xyz, R1, R0;
MAD R0.xyz, R0, R3.w, R8;
MUL R1.xyz, R1, c[0];
MAD R1.xyz, R1, R0.w, R2;
TEX R0.w, fragment.texcoord[0], texture[1], 2D;
ADD_SAT R0.w, R0, c[5].x;
MUL R2.xyz, R5.w, R1;
MUL R0.xyz, R5.w, R0;
MUL R1.xyz, R0.w, R0;
ADD R0.x, -R0.w, c[8].y;
MUL R2.xyz, R0.w, R2;
MAD R1.xyz, R0.x, R6, R1;
MAD result.color.xyz, R1, R0.x, R2;
MOV result.color.w, c[8].x;
END
# 287 instructions, 12 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Float 2 [_GVar]
Vector 3 [_Color]
Float 4 [_Shininess]
Float 5 [_BlendAdjust1]
Vector 6 [_SSSC]
Float 7 [_Smoothness]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_ScatterMap] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_LightTextureB0] 2D
SetTexture 4 [_LightTexture0] CUBE
SetTexture 5 [_ExitColorMap] 2D
"ps_3_0
; 346 ALU, 7 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_cube s4
dcl_2d s5
def c8, 2.00000000, -1.00000000, 0.10000000, -0.73550957
def c9, 0.11705996, 0.50000000, 6.28318501, -3.14159298
def c10, 0.00000000, -1.00000000, 0.73550957, -0.99270076
def c11, 0.15799320, 0.50000000, 0.99270076, 0.44999999
def c12, 2.71828198, 0.39894229, 1.00000000, 3.50000000
def c13, 0.00100000, 7.00000000, 0.00000000, 1.00000000
def c14, -0.01872930, 0.07426100, -0.21211439, 1.57072902
def c15, 3.14159298, 0.15915491, 0.50000000, 3.14159274
def c16, 1.29999995, 0.69999999, 5.00000000, 128.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dp3_pp r0.x, v1, v1
rsq_pp r0.x, r0.x
mul_pp r2.xyz, r0.x, v1
mul r0.x, r2.y, r2.y
mad r0.x, r2, r2, r0
mad r0.x, r2.z, r2.z, r0
rsq r1.w, r0.x
mul r1.x, r1.w, -r2.z
mad r0.x, r1, c9, c9.y
frc r0.x, r0
mad r1.y, r0.x, c9.z, c9.w
sincos r0.xy, r1.y
mad r0.z, r1.x, c8.w, r0.x
dp3 r0.y, r2, r2
mul r1.xy, r0.z, c10
rsq r0.x, r0.y
mul r0.xyz, r0.x, r2
mad r3.xyz, r0, c10.z, r1.xxyw
mul r0.x, r3.y, r3.y
mad r0.x, r3, r3, r0
mad r0.x, r3.z, r3.z, r0
rsq r0.x, r0.x
mul r1.x, r0, -r3.z
mad r0.x, r1, c11, c11.y
frc r0.x, r0
mad r1.y, r0.x, c9.z, c9.w
sincos r0.xy, r1.y
mad r0.z, r1.x, c10.w, r0.x
dp3 r0.y, r3, r3
rsq r0.x, r0.y
mul r8.xyz, r0.x, r3
add r3.xyz, -r3, r2
mul r0.zw, r0.z, c10.xyxy
mad r9.xyz, r8, c11.z, r0.zzww
dp3 r0.x, r9, r9
mov r0.w, c7.x
mul r2.w, c11, r0
mov r0.w, c7.x
rsq r0.x, r0.x
mul r0.xyz, r0.x, r9
add r9.xyz, -r9, r2
mad r1.xyz, r8, -r2.w, r2
mul r4.w, c8.z, r0
mad r7.xyz, -r4.w, r0, r1
dp3 r0.x, r7, r7
texld r0.yw, v0.zwzw, s2
mad_pp r1.xy, r0.wyzw, c8.x, c8.y
rsq r0.x, r0.x
mul r6.xyz, r0.x, r7
mul_pp r0.w, r1.y, r1.y
mad_pp r0.w, -r1.x, r1.x, -r0
dp3_pp r0.x, v2, v2
rsq_pp r0.x, r0.x
mul_pp r4.xyz, r0.x, v2
add r0.xyz, r6, r4
dp3 r1.z, r0, r0
rsq r1.z, r1.z
add_pp r0.w, r0, c12.z
mul r5.xyz, r1.z, r0
rsq_pp r0.w, r0.w
rcp_pp r1.z, r0.w
dp3 r5.w, r1, r5
abs r0.x, r5.w
add r0.z, -r0.x, c12
mad r0.y, r0.x, c14.x, c14
mad r0.y, r0, r0.x, c14.z
rsq r0.z, r0.z
mad r0.x, r0.y, r0, c14.w
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r0.x, r5.w, c13.z, c13.w
mul r0.z, r0.x, r0.y
mad r0.y, -r0.z, c8.x, r0
mad r0.x, r0, c15, r0.y
mad r0.x, r0, c15.y, c15.z
frc r0.x, r0
mad r3.w, r0.x, c9.z, c9
sincos r0.xy, r3.w
mov r0.y, c7.x
mad r8.w, r0.y, c16.x, c16.y
mul r0.x, r0, r0
mul r0.y, r0.x, r8.w
mul r0.y, r0, r8.w
mul r3.w, r8, r8
mul r0.w, r0.x, r3
rcp r0.z, r0.y
add r0.y, -r0.x, c12.z
mul r6.w, r0.y, r0.z
mul r7.w, r0.x, r0
pow r0, c12.x, -r6.w
mul r0.y, r7.w, c15.w
rcp r0.y, r0.y
mul r10.x, r0, r0.y
add r7.w, -r5, c12.z
pow r0, r7.w, c16.z
dp3 r0.y, r1, r6
mul r6.w, r9.y, r9.y
mad r0.z, r9.x, r9.x, r6.w
mov_pp r6.z, c4.x
max r6.x, r0.y, c10
mad r0.z, r9, r9, r0
rsq r0.y, r0.z
add r0.z, -r4.w, -r2.w
rcp r0.y, r0.y
add_pp r7.w, c12.z, -r6.z
mul r0.y, r0, c2.x
add r0.z, r0, c8.x
mul r0.z, r0.y, r0
mul r0.y, r6.x, r6.x
mul r0.y, r0, r0.z
mov r6.w, r0.x
mul r0.y, r0, r0.z
mul r6.y, r0, c9
pow r0, c12.x, -r6.y
mad r10.w, -r0.x, c12.y, c12.z
mul r9.w, r6.x, r10
mul r0.y, r7, r7
mad r0.x, r7, r7, r0.y
mad r0.x, r7.z, r7.z, r0
mad r9.x, r6.w, c4, r7.w
add_sat r6.x, -r9.w, c12.z
rsq r6.y, r0.x
pow r0, r6.x, c12.w
add r0.zw, r7.xyxy, -r2.xyxy
dp3 r7.x, r7, r2
rcp r0.y, r6.y
mul r0.y, r1.w, r0
mul r0.zw, r4.w, r0
mul r0.zw, r0, r0.y
mad r6.xy, -r0.zwzw, c13.x, v0
mov r0.y, r0.x
dp3 r0.x, v3, v3
texld r6, r6, s5
texld r0.w, v3, s4
texld r0.x, r0.x, s3
mul r4.w, r0.x, r0
mul r0.w, r10.x, r9.x
mul r10.xyz, r8, r2.w
mul r0.x, r0.y, r6.w
mul r0.x, r0, r4.w
mul_sat r6.w, r0.x, c13.y
mul_pp r0.xyz, r6, c0
mul_sat r7.x, r7, c7
mul r0.xyz, r7.x, r0
add r7.x, -r7, c12.z
add r8.xyz, r2, -r10
add r9.x, -r6.w, c12.z
mad r0.xyz, r7.x, c0, r0
mul r6.xyz, r6.w, r6
mul r7.xyz, r6, c6
texld r6, v0, s0
mad r0.xyz, r9.x, r0, r7
mul_pp r6.xyz, r6, c3
mul_pp r7.xyz, r6, r0
dp3_pp r0.y, r1, r4
mul r10.z, r5.w, r0.y
mul r0.x, r6.w, r0.w
rcp r12.y, r0.y
mul_sat r11.x, r0, r12.y
dp3 r0.x, r8, r8
rsq r0.y, r0.x
dp3_pp r0.x, r5, r4
rcp r0.w, r0.x
mul r5.x, r10.z, r0.w
mul r9.xyz, r0.y, r8
add r0.xyz, r4, r9
dp3 r5.y, r0, r0
rsq r5.y, r5.y
mul r0.xyz, r5.y, r0
dp3 r12.z, r1, r0
dp3_pp r10.z, r1, r2
abs r0.y, r12.z
mul r5.y, r5.w, r10.z
mul r0.x, r0.w, r5.y
add r0.w, -r0.y, c12.z
mad r0.z, r0.y, c14.x, c14.y
mad r0.z, r0, r0.y, c14
mad r0.y, r0.z, r0, c14.w
rsq r0.w, r0.w
rcp r0.w, r0.w
mul r0.y, r0, r0.w
cmp r0.z, r12, c13, c13.w
mul r0.w, r0.z, r0.y
mul r5.x, r5, c8
mul r0.x, r0, c8
min_sat r12.x, r5, r0
mad r0.x, -r0.w, c8, r0.y
mad r0.z, r0, c15.x, r0.x
mov_pp r0.x, c4
mul_pp r11.w, c16, r0.x
max r0.y, r5.w, c10.x
mad r0.z, r0, c15.y, c15
pow r5, r0.y, r11.w
frc r0.x, r0.z
mad r5.y, r0.x, c9.z, c9.w
sincos r0.xy, r5.y
mov r0.y, r5.x
mul r5.w, r0.x, r0.x
mul r0.y, r6.w, r0
mul r0.x, r0.y, c9.y
mul r0.y, r8.w, r5.w
mul r0.y, r8.w, r0
mad r0.x, r11, r12, r0
mul_sat r8.w, r10, r0.x
mov_pp r5.xyz, c0
mul_pp r5.xyz, c1, r5
mul r11.xyz, r5, r8.w
mad r7.xyz, r7, r9.w, r11
mul r3.w, r3, r5
add r0.x, -r5.w, c12.z
rcp r0.y, r0.y
mul r10.w, r0.x, r0.y
pow r0, c12.x, -r10.w
mov r8.w, r0.x
add r9.w, -r12.z, c12.z
pow r0, r9.w, c16.z
mul r0.y, r5.w, r3.w
mul_pp r5.w, r4, c8.x
mov r0.z, r0.x
mul r0.y, r0, c15.w
rcp r0.x, r0.y
mad r0.y, r0.z, c4.x, r7.w
mul r0.x, r8.w, r0
mul r0.x, r0, r0.y
mul r0.x, r6.w, r0
mul_sat r3.w, r12.y, r0.x
max r7.w, r12.z, c10.x
pow r0, r7.w, r11.w
mul r3.y, r3, r3
mad r0.y, r3.x, r3.x, r3
mad r0.z, r3, r3, r0.y
dp3 r0.y, r1, r9
max r3.x, r0.y, c10
rsq r0.z, r0.z
rcp r0.y, r0.z
mov r0.w, r0.x
mul r0.y, r0, c2.x
add r0.z, -r2.w, c12
mul r0.z, r0.y, r0
mul r0.y, r3.x, r3.x
mul r0.y, r0, r0.z
mul r0.x, r0.y, r0.z
mul r0.y, r6.w, r0.w
mul r3.y, r0.x, c9
mul r3.z, r0.y, c9.y
pow r0, c12.x, -r3.y
mad r0.z, r12.x, r3.w, r3
mad r0.x, -r0, c12.y, c12.z
mul r7.w, r3.x, r0.x
mul_sat r0.z, r0.x, r0
mul r0.y, r8, r8
mad r0.y, r8.x, r8.x, r0
mad r0.y, r8.z, r8.z, r0
rsq r0.y, r0.y
mul r9.xyz, r5, r0.z
rcp r0.x, r0.y
mul r0.z, r1.w, r0.x
mul r0.xy, r2.w, -r10
mul r3.xy, r0, r0.z
add_sat r3.z, -r7.w, c12
pow r0, r3.z, c12.w
dp3 r0.y, r2, r8
mad r3.xy, -r3, c13.x, v0
texld r3, r3, s5
mov r0.w, r0.x
mul r0.w, r0, r3
mul r0.w, r4, r0
mul_sat r0.w, r0, c13.y
mul_sat r0.y, r0, c7.x
mul_pp r8.xyz, r3, c0
mul r8.xyz, r0.y, r8
add r0.y, -r0, c12.z
mad r8.xyz, r0.y, c0, r8
add_pp r0.xyz, r2, r4
dp3_pp r1.w, r0, r0
rsq_pp r1.w, r1.w
mul_pp r0.xyz, r1.w, r0
dp3_pp r1.x, r1, r0
max_pp r2.x, r1, c10
mul r0.xyz, r0.w, r3
add r1.w, -r0, c12.z
mul r1.xyz, r0, c6
pow r0, r2.x, r11.w
mov r0.w, r0.x
mul_sat r0.w, r6, r0
mul r2.xyz, r5, r0.w
mad r1.xyz, r1.w, r8, r1
mul_pp r1.xyz, r6, r1
mad r0.xyz, r1, r7.w, r9
mul r0.xyz, r5.w, r0
max_pp r0.w, r10.z, c10.x
mul_pp r1.xyz, r6, c0
mad r1.xyz, r1, r0.w, r2
texld r0.w, v0, s1
add_sat r0.w, r0, c5.x
mul r2.xyz, r5.w, r1
mul_pp r1.xyz, r0.w, r0
add_pp r0.x, -r0.w, c12.z
mul r7.xyz, r7, r5.w
mul_pp r2.xyz, r0.w, r2
mad_pp r1.xyz, r0.x, r7, r1
mad_pp oC0.xyz, r1, r0.x, r2
mov_pp oC0.w, c10.x
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Float 2 [_GVar]
Vector 3 [_Color]
Float 4 [_Shininess]
Float 5 [_BlendAdjust1]
Vector 6 [_SSSC]
Float 7 [_Smoothness]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_ScatterMap] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_LightTexture0] 2D
SetTexture 4 [_ExitColorMap] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 281 ALU, 6 TEX
PARAM c[15] = { program.local[0..7],
		{ 0, 1, 2, 0.1 },
		{ 0.73550957, -0.73550957, 0, -1 },
		{ 0.99270076, -0.99270076, 0.44999999, 2.718282 },
		{ 0.5, 0.39894229, 3.5, 0.001 },
		{ 7, 3.141593, -0.018729299, 0.074261002 },
		{ 0.21211439, 1.570729, 1.3, 0.69999999 },
		{ 3.1415927, 5, 128 } };
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
MOV R2.w, c[10].z;
TEX R4.yw, fragment.texcoord[0].zwzw, texture[2], 2D;
MUL R0.x, fragment.texcoord[1].y, fragment.texcoord[1].y;
MAD R0.x, fragment.texcoord[1], fragment.texcoord[1], R0;
MAD R0.x, fragment.texcoord[1].z, fragment.texcoord[1].z, R0;
RSQ R1.w, R0.x;
MUL R0.y, R1.w, -fragment.texcoord[1].z;
MUL R0.x, R0.y, c[9];
COS R0.z, R0.x;
MAD R0.y, R0, c[9], R0.z;
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
MAD R4.xy, R4.wyzw, c[8].z, -c[8].y;
MUL R3.w, R2, c[7].x;
MUL R1.xy, R0.y, c[9].zwzw;
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, fragment.texcoord[1];
MAD R1.xyz, R0, c[9].x, R1.xxyw;
MUL R0.x, R1.y, R1.y;
MAD R0.x, R1, R1, R0;
MAD R0.x, R1.z, R1.z, R0;
RSQ R0.x, R0.x;
MUL R0.y, R0.x, -R1.z;
MUL R0.x, R0.y, c[10];
COS R0.z, R0.x;
MAD R0.y, R0, c[10], R0.z;
DP3 R0.x, R1, R1;
RSQ R0.x, R0.x;
MUL R6.xyz, R0.x, R1;
ADD R1.xyz, -R1, fragment.texcoord[1];
MUL R0.zw, R0.y, c[9];
MAD R0.xyz, R6, c[10].x, R0.zzww;
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R2.xyz, R0.w, R0;
MOV R0.w, c[8];
MUL R1.y, R1, R1;
MAD R1.y, R1.x, R1.x, R1;
ADD R0.xyz, -R0, fragment.texcoord[1];
MAD R3.xyz, R6, -R3.w, fragment.texcoord[1];
MUL R9.xyz, R6, R3.w;
MUL R0.w, R0, c[7].x;
MAD R2.xyz, -R0.w, R2, R3;
DP3 R3.x, R2, R2;
RSQ R3.y, R3.x;
MUL R5.xyz, R3.y, R2;
MUL R2.w, R2.y, R2.y;
MAD R2.w, R2.x, R2.x, R2;
MAD R2.w, R2.z, R2.z, R2;
MUL R3.x, R4.y, R4.y;
MAD R3.x, -R4, R4, -R3;
RSQ R2.w, R2.w;
RCP R2.w, R2.w;
ADD R6.xyz, fragment.texcoord[1], -R9;
MAD R1.z, R1, R1, R1.y;
MUL R3.y, R0, R0;
ADD R3.x, R3, c[8].y;
RSQ R0.y, R3.x;
MAD R3.x, R0, R0, R3.y;
RCP R4.z, R0.y;
DP3 R3.y, R2, fragment.texcoord[1];
MAD R0.y, R0.z, R0.z, R3.x;
DP3 R0.x, R4, R5;
MAX R3.x, R0, c[8];
RSQ R0.x, R0.y;
ADD R0.y, -R0.w, -R3.w;
RCP R0.x, R0.x;
MUL R2.w, R1, R2;
MUL R0.x, R0, c[2];
ADD R0.y, R0, c[8].z;
MUL R0.y, R0.x, R0;
MUL R0.x, R3, R3;
MUL R0.x, R0, R0.y;
MUL R0.z, R0.x, R0.y;
ADD R0.xy, R2, -fragment.texcoord[1];
MUL R0.xy, R0.w, R0;
MUL R7.xy, R0, R2.w;
MUL R0.x, R0.z, c[11];
POW R2.w, c[10].w, -R0.x;
MAD R0.zw, -R7.xyxy, c[11].w, fragment.texcoord[0].xyxy;
TEX R0, R0.zwzw, texture[4], 2D;
MUL R2.w, -R2, c[11].y;
ADD R7.w, R2, c[8].y;
MUL R6.w, R3.x, R7;
DP3 R2.w, fragment.texcoord[2], fragment.texcoord[2];
RSQ R3.x, R2.w;
ADD_SAT R2.w, -R6, c[8].y;
POW R2.w, R2.w, c[11].z;
MUL R2.w, R2, R0;
TEX R0.w, fragment.texcoord[3], texture[3], 2D;
MUL R2.w, R2, R0;
MUL R2.xyz, R0, c[0];
MUL_SAT R3.y, R3, c[7].x;
MUL R2.xyz, R3.y, R2;
ADD R3.y, -R3, c[8];
MAD R2.xyz, R3.y, c[0], R2;
MUL R3.xyz, R3.x, fragment.texcoord[2];
ADD R5.xyz, R5, R3;
DP3 R4.w, R5, R5;
RSQ R4.w, R4.w;
MUL R7.xyz, R4.w, R5;
DP3 R5.w, R4, R7;
MUL_SAT R2.w, R2, c[12].x;
MUL R0.xyz, R2.w, R0;
ABS R4.w, R5;
MUL R0.xyz, R0, c[6];
ADD R2.w, -R2, c[8].y;
MAD R5.xyz, R2.w, R2, R0;
ADD R0.y, -R4.w, c[8];
MAD R0.x, R4.w, c[12].z, c[12].w;
MAD R0.x, R0, R4.w, -c[13];
MAD R0.x, R0, R4.w, c[13].y;
RSQ R0.y, R0.y;
RCP R0.y, R0.y;
TEX R2, fragment.texcoord[0], texture[0], 2D;
MUL R8.x, R0, R0.y;
MUL R0.xyz, R2, c[3];
SLT R4.w, R5, c[8].x;
MUL R8.y, R4.w, R8.x;
MAD R2.x, -R8.y, c[8].z, R8;
MAD R2.x, R4.w, c[12].y, R2;
MOV R2.y, c[7].x;
MAD R10.y, R2, c[13].z, c[13].w;
COS R2.x, R2.x;
MUL R2.x, R2, R2;
MUL R9.w, R10.y, R10.y;
MUL R2.y, R2.x, R10;
MUL R2.y, R2, R10;
MUL R2.z, R2.x, R9.w;
MUL R2.z, R2.x, R2;
MUL R5.xyz, R0, R5;
MUL R2.z, R2, c[14].x;
RCP R2.y, R2.y;
ADD R2.x, -R2, c[8].y;
MUL R2.x, R2, R2.y;
RCP R2.y, R2.z;
MOV R2.z, c[8].y;
ADD R10.x, R2.z, -c[4];
DP3 R2.z, R4, R3;
POW R2.x, c[10].w, -R2.x;
MUL R2.x, R2, R2.y;
ADD R2.y, -R5.w, c[8];
POW R2.y, R2.y, c[14].y;
MAD R2.y, R2, c[4].x, R10.x;
MUL R2.x, R2, R2.y;
RCP R8.w, R2.z;
MUL R2.x, R2.w, R2;
MUL_SAT R8.x, R2, R8.w;
DP3 R2.x, R7, R3;
MUL R2.y, R5.w, R2.z;
RCP R2.x, R2.x;
MUL R2.y, R2, R2.x;
MUL R8.y, R2, c[8].z;
DP3 R2.y, R6, R6;
RSQ R2.z, R2.y;
MUL R7.xyz, R2.z, R6;
DP3 R4.w, R4, fragment.texcoord[1];
MUL R2.y, R5.w, R4.w;
MUL R8.z, R2.x, R2.y;
ADD R2.xyz, R3, R7;
DP3 R1.y, R4, R7;
RSQ R7.x, R1.z;
MAX R1.z, R1.y, c[8].x;
RCP R1.y, R7.x;
MUL R8.z, R8, c[8];
MIN_SAT R9.z, R8.y, R8;
DP3 R10.z, R2, R2;
RSQ R8.z, R10.z;
MUL R2.xyz, R8.z, R2;
DP3 R10.z, R4, R2;
ABS R2.y, R10.z;
MAX R8.y, R5.w, c[8].x;
MAD R2.z, R2.y, c[12], c[12].w;
MOV R5.w, c[14].z;
MUL R5.w, R5, c[4].x;
POW R2.x, R8.y, R5.w;
ADD R8.y, -R2, c[8];
MAD R2.z, R2, R2.y, -c[13].x;
RSQ R8.y, R8.y;
MUL R2.x, R2.w, R2;
MUL R2.x, R2, c[11];
MAD R2.x, R8, R9.z, R2;
MAD R2.y, R2.z, R2, c[13];
RCP R8.y, R8.y;
MUL R2.z, R2.y, R8.y;
SLT R2.y, R10.z, c[8].x;
MUL R8.y, R2, R2.z;
MAD R2.z, -R8.y, c[8], R2;
MAD R2.y, R2, c[12], R2.z;
MUL_SAT R8.x, R7.w, R2;
COS R2.y, R2.y;
MUL R7.w, R2.y, R2.y;
MUL R10.w, R10.y, R7;
MOV R2.xyz, c[1];
MUL R2.xyz, R2, c[0];
MUL R8.xyz, R2, R8.x;
MAD R5.xyz, R5, R6.w, R8;
MUL R10.y, R10, R10.w;
RCP R8.x, R10.y;
ADD R6.w, -R7, c[8].y;
MUL R6.w, R6, R8.x;
MUL R8.x, R9.w, R7.w;
MUL R7.w, R7, R8.x;
ADD R8.x, -R10.z, c[8].y;
MUL R7.w, R7, c[14].x;
POW R8.x, R8.x, c[14].y;
RCP R7.w, R7.w;
POW R6.w, c[10].w, -R6.w;
MUL R6.w, R6, R7;
MAD R8.x, R8, c[4], R10;
MUL R7.w, R6, R8.x;
MUL R6.w, R0, c[8].z;
MUL R7.w, R2, R7;
MAX R8.x, R10.z, c[8];
POW R8.x, R8.x, R5.w;
MUL R8.x, R2.w, R8;
MUL_SAT R7.w, R8, R7;
MUL R1.x, R8, c[11];
MAD R7.y, R9.z, R7.w, R1.x;
ADD R7.x, -R3.w, c[8].y;
MUL R1.y, R1, c[2].x;
MUL R7.x, R1.y, R7;
MUL R1.y, R1.z, R1.z;
MUL R1.y, R1, R7.x;
MUL R1.x, R1.y, R7;
MUL R1.y, R6, R6;
MAD R1.y, R6.x, R6.x, R1;
MAD R1.y, R6.z, R6.z, R1;
MUL R1.x, R1, c[11];
POW R1.x, c[10].w, -R1.x;
MUL R1.x, -R1, c[11].y;
ADD R7.w, R1.x, c[8].y;
RSQ R1.y, R1.y;
MUL_SAT R7.x, R7.w, R7.y;
RCP R1.x, R1.y;
MUL R1.w, R1, R1.x;
MUL R1.xy, R3.w, -R9;
MUL R3.w, R1.z, R7;
MUL R1.xy, R1, R1.w;
MAD R1.xy, -R1, c[11].w, fragment.texcoord[0];
ADD_SAT R7.w, -R3, c[8].y;
TEX R1, R1, texture[4], 2D;
POW R7.w, R7.w, c[11].z;
MUL R1.w, R7, R1;
DP3 R7.w, fragment.texcoord[1], R6;
MUL R0.w, R0, R1;
MUL_SAT R0.w, R0, c[12].x;
MUL R6.xyz, R1, c[0];
MUL_SAT R7.w, R7, c[7].x;
MUL R6.xyz, R7.w, R6;
ADD R7.w, -R7, c[8].y;
MUL R1.xyz, R0.w, R1;
MUL R7.xyz, R2, R7.x;
MAD R6.xyz, R7.w, c[0], R6;
ADD R3.xyz, fragment.texcoord[1], R3;
DP3 R7.w, R3, R3;
RSQ R7.w, R7.w;
ADD R1.w, -R0, c[8].y;
MUL R3.xyz, R7.w, R3;
MUL R1.xyz, R1, c[6];
DP3 R0.w, R4, R3;
MAD R1.xyz, R1.w, R6, R1;
MUL R1.xyz, R0, R1;
MAX R0.w, R0, c[8].x;
POW R0.w, R0.w, R5.w;
MUL_SAT R0.w, R2, R0;
MUL R2.xyz, R2, R0.w;
MAD R1.xyz, R1, R3.w, R7;
MAX R0.w, R4, c[8].x;
MUL R0.xyz, R0, c[0];
MAD R0.xyz, R0, R0.w, R2;
MUL R2.xyz, R6.w, R0;
TEX R0.w, fragment.texcoord[0], texture[1], 2D;
ADD_SAT R0.x, R0.w, c[5];
MUL R1.xyz, R6.w, R1;
MUL R1.xyz, R0.x, R1;
MUL R2.xyz, R0.x, R2;
ADD R0.x, -R0, c[8].y;
MUL R5.xyz, R5, R6.w;
MAD R1.xyz, R0.x, R5, R1;
MAD result.color.xyz, R1, R0.x, R2;
MOV result.color.w, c[8].x;
END
# 281 instructions, 11 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Float 2 [_GVar]
Vector 3 [_Color]
Float 4 [_Shininess]
Float 5 [_BlendAdjust1]
Vector 6 [_SSSC]
Float 7 [_Smoothness]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_ScatterMap] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_LightTexture0] 2D
SetTexture 4 [_ExitColorMap] 2D
"ps_3_0
; 340 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c8, 2.00000000, -1.00000000, 0.10000000, -0.73550957
def c9, 0.11705996, 0.50000000, 6.28318501, -3.14159298
def c10, 0.00000000, -1.00000000, 0.73550957, -0.99270076
def c11, 0.15799320, 0.50000000, 0.99270076, 0.44999999
def c12, 2.71828198, 0.39894229, 1.00000000, 3.50000000
def c13, 0.00100000, 7.00000000, 0.00000000, 1.00000000
def c14, -0.01872930, 0.07426100, -0.21211439, 1.57072902
def c15, 3.14159298, 0.15915491, 0.50000000, 3.14159274
def c16, 1.29999995, 0.69999999, 5.00000000, 128.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xy
mul r0.x, v1.y, v1.y
mad r0.x, v1, v1, r0
mad r0.x, v1.z, v1.z, r0
rsq r3.w, r0.x
mul r1.x, r3.w, -v1.z
mad r0.x, r1, c9, c9.y
frc r0.x, r0
mad r1.y, r0.x, c9.z, c9.w
sincos r0.xy, r1.y
mad r0.z, r1.x, c8.w, r0.x
dp3 r0.y, v1, v1
mul r1.xy, r0.z, c10
rsq r0.x, r0.y
mul r0.xyz, r0.x, v1
mad r4.xyz, r0, c10.z, r1.xxyw
mul r0.x, r4.y, r4.y
mad r0.x, r4, r4, r0
mad r0.x, r4.z, r4.z, r0
rsq r0.x, r0.x
mul r1.x, r0, -r4.z
mad r0.x, r1, c11, c11.y
frc r0.x, r0
mad r1.y, r0.x, c9.z, c9.w
sincos r0.xy, r1.y
mad r0.z, r1.x, c10.w, r0.x
dp3 r0.y, r4, r4
rsq r0.x, r0.y
mul r2.xyz, r0.x, r4
add r4.xyz, -r4, v1
mul r0.zw, r0.z, c10.xyxy
mad r8.xyz, r2, c11.z, r0.zzww
dp3 r0.x, r8, r8
mov r0.w, c7.x
mul r4.w, c11, r0
mov r0.w, c7.x
rsq r0.x, r0.x
mul r0.xyz, r0.x, r8
mad r1.xyz, r2, -r4.w, v1
mul r2.w, c8.z, r0
mad r5.xyz, -r2.w, r0, r1
dp3 r0.x, r5, r5
texld r0.yw, v0.zwzw, s2
mad_pp r3.xy, r0.wyzw, c8.x, c8.y
rsq r0.x, r0.x
mul r7.xyz, r0.x, r5
mul_pp r0.w, r3.y, r3.y
mad_pp r0.w, -r3.x, r3.x, -r0
dp3_pp r0.x, v2, v2
rsq_pp r0.x, r0.x
mul_pp r6.xyz, r0.x, v2
add r0.xyz, r7, r6
dp3 r1.x, r0, r0
add_pp r0.w, r0, c12.z
rsq_pp r0.w, r0.w
rsq r1.x, r1.x
rcp_pp r3.z, r0.w
mul r1.xyz, r1.x, r0
dp3 r1.w, r3, r1
abs r0.x, r1.w
add r0.z, -r0.x, c12
mad r0.y, r0.x, c14.x, c14
mad r0.y, r0, r0.x, c14.z
rsq r0.z, r0.z
mul r9.xyz, r2, r4.w
add r8.xyz, -r8, v1
mad r0.x, r0.y, r0, c14.w
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r0.x, r1.w, c13.z, c13.w
mul r0.z, r0.x, r0.y
mad r0.y, -r0.z, c8.x, r0
mad r0.x, r0, c15, r0.y
mad r0.x, r0, c15.y, c15.z
frc r0.x, r0
mad r5.w, r0.x, c9.z, c9
sincos r0.xy, r5.w
mov r0.y, c7.x
mad r9.w, r0.y, c16.x, c16.y
mul r0.x, r0, r0
mul r0.y, r0.x, r9.w
mul r0.y, r0, r9.w
mul r6.w, r9, r9
mul r0.w, r0.x, r6
rcp r0.z, r0.y
add r0.y, -r0.x, c12.z
mul r5.w, r0.y, r0.z
mul r7.w, r0.x, r0
pow r0, c12.x, -r5.w
mul r0.y, r7.w, c15.w
rcp r0.y, r0.y
mul r5.w, r0.x, r0.y
add r8.w, -r1, c12.z
pow r0, r8.w, c16.z
dp3 r0.y, r3, r7
mul r7.w, r8.y, r8.y
mad r0.z, r8.x, r8.x, r7.w
mov_pp r7.z, c4.x
max r7.x, r0.y, c10
mad r0.z, r8, r8, r0
rsq r0.y, r0.z
add r0.z, -r2.w, -r4.w
rcp r0.y, r0.y
add_pp r8.w, c12.z, -r7.z
mul r0.y, r0, c2.x
add r0.z, r0, c8.x
mul r0.z, r0.y, r0
mul r0.y, r7.x, r7.x
mul r0.y, r0, r0.z
mov r7.w, r0.x
mul r0.y, r0, r0.z
mul r7.y, r0, c9
pow r0, c12.x, -r7.y
mad r10.x, -r0, c12.y, c12.z
mul r10.w, r7.x, r10.x
mul r0.y, r5, r5
mad r0.x, r5, r5, r0.y
mad r0.x, r5.z, r5.z, r0
mad r8.x, r7.w, c4, r8.w
rsq r7.y, r0.x
add_sat r7.x, -r10.w, c12.z
pow r0, r7.x, c12.w
add r0.zw, r5.xyxy, -v1.xyxy
dp3 r5.x, r5, v1
rcp r0.y, r7.y
mul r0.zw, r2.w, r0
mul r0.y, r3.w, r0
mul r0.zw, r0, r0.y
mad r7.xy, -r0.zwzw, c13.x, v0
texld r7, r7, s4
texld r0.w, v3, s3
mul r0.x, r0, r7.w
mul r0.x, r0, r0.w
mul r2.w, r5, r8.x
mul_sat r5.w, r0.x, c13.y
add r7.w, -r5, c12.z
mul_pp r0.xyz, r7, c0
mul_sat r5.x, r5, c7
mul r0.xyz, r5.x, r0
add r5.x, -r5, c12.z
mad r0.xyz, r5.x, c0, r0
mul r5.xyz, r5.w, r7
mul r7.xyz, r5, c6
texld r5, v0, s0
mad r7.xyz, r7.w, r0, r7
dp3_pp r7.w, r3, r6
mul_pp r0.xyz, r5, c3
mul_pp r5.xyz, r0, r7
add r7.xyz, v1, -r9
dp3 r2.y, r7, r7
rsq r2.y, r2.y
mul r8.xyz, r2.y, r7
dp3_pp r1.x, r1, r6
rcp r2.y, r1.x
mul r2.x, r1.w, r7.w
rcp r11.y, r7.w
add r1.xyz, r6, r8
mul r2.x, r2, r2.y
mul r2.w, r5, r2
dp3 r2.z, r1, r1
rsq r2.z, r2.z
mul r1.xyz, r2.z, r1
dp3 r11.z, r3, r1
abs r1.y, r11.z
dp3_pp r7.w, r3, v1
mul r2.z, r1.w, r7.w
mul r1.x, r2.y, r2.z
add r2.y, -r1, c12.z
mad r1.z, r1.y, c14.x, c14.y
mad r1.z, r1, r1.y, c14
rsq r2.y, r2.y
mul_sat r10.y, r2.w, r11
mad r1.y, r1.z, r1, c14.w
rcp r2.y, r2.y
mul r1.z, r1.y, r2.y
cmp r1.y, r11.z, c13.z, c13.w
mul r2.y, r1, r1.z
mad r1.z, -r2.y, c8.x, r1
mad r1.z, r1.y, c15.x, r1
mov_pp r1.y, c4.x
mul_pp r9.z, c16.w, r1.y
mad r1.z, r1, c15.y, c15
mul r2.x, r2, c8
mul r1.x, r1, c8
min_sat r11.x, r2, r1
max r1.x, r1.w, c10
pow r2, r1.x, r9.z
frc r1.y, r1.z
mad r2.y, r1, c9.z, c9.w
sincos r1.xy, r2.y
mov r1.y, r2.x
mul r2.w, r1.x, r1.x
mul r1.y, r5.w, r1
mul r1.x, r1.y, c9.y
mul r1.y, r9.w, r2.w
mul r1.y, r9.w, r1
mad r1.x, r10.y, r11, r1
mul_sat r9.w, r10.x, r1.x
mov_pp r2.xyz, c0
mul r6.w, r6, r2
add r1.x, -r2.w, c12.z
rcp r1.y, r1.y
mul r10.x, r1, r1.y
pow r1, c12.x, -r10.x
mul_pp r2.xyz, c1, r2
mul r10.xyz, r2, r9.w
mad r5.xyz, r5, r10.w, r10
mov r9.w, r1.x
add r10.x, -r11.z, c12.z
pow r1, r10.x, c16.z
mul r1.y, r2.w, r6.w
mul_pp r2.w, r0, c8.x
mov r1.z, r1.x
mul r1.y, r1, c15.w
rcp r1.x, r1.y
mad r1.y, r1.z, c4.x, r8.w
mul r1.x, r9.w, r1
mul r1.x, r1, r1.y
mul r1.x, r5.w, r1
mul_sat r6.w, r11.y, r1.x
max r8.w, r11.z, c10.x
pow r1, r8.w, r9.z
mul r4.y, r4, r4
mad r1.y, r4.x, r4.x, r4
mad r1.z, r4, r4, r1.y
dp3 r1.y, r3, r8
max r4.x, r1.y, c10
rsq r1.z, r1.z
rcp r1.y, r1.z
mov r1.w, r1.x
add r1.z, -r4.w, c12
mul r1.y, r1, c2.x
mul r1.z, r1.y, r1
mul r1.y, r4.x, r4.x
mul r1.y, r1, r1.z
mul r1.x, r1.y, r1.z
mul r1.y, r5.w, r1.w
mul r4.y, r1.x, c9
mul r4.z, r1.y, c9.y
pow r1, c12.x, -r4.y
mad r1.z, r11.x, r6.w, r4
mad r1.x, -r1, c12.y, c12.z
mul r6.w, r4.x, r1.x
mul_sat r1.z, r1.x, r1
mul r1.y, r7, r7
mad r1.y, r7.x, r7.x, r1
mad r1.y, r7.z, r7.z, r1
rsq r1.y, r1.y
mul r8.xyz, r2, r1.z
rcp r1.x, r1.y
mul r1.z, r3.w, r1.x
mul r1.xy, r4.w, -r9
mul r4.xy, r1, r1.z
add_sat r4.z, -r6.w, c12
pow r1, r4.z, c12.w
dp3 r1.y, v1, r7
mad r4.xy, -r4, c13.x, v0
texld r4, r4, s4
mov r1.w, r1.x
mul r1.w, r1, r4
mul r0.w, r0, r1
mul_sat r0.w, r0, c13.y
mul_sat r1.y, r1, c7.x
mul_pp r7.xyz, r4, c0
mul r7.xyz, r1.y, r7
add r1.y, -r1, c12.z
mad r7.xyz, r1.y, c0, r7
add_pp r1.xyz, v1, r6
dp3_pp r3.w, r1, r1
rsq_pp r1.w, r3.w
mul_pp r1.xyz, r1.w, r1
dp3_pp r1.w, r3, r1
mul r1.xyz, r0.w, r4
add r3.w, -r0, c12.z
mul r3.xyz, r1, c6
max_pp r0.w, r1, c10.x
pow r1, r0.w, r9.z
mov r0.w, r1.x
mul_sat r0.w, r5, r0
mul r2.xyz, r2, r0.w
mad r3.xyz, r3.w, r7, r3
mul_pp r3.xyz, r0, r3
mad r1.xyz, r3, r6.w, r8
max_pp r0.w, r7, c10.x
mul_pp r0.xyz, r0, c0
mad r0.xyz, r0, r0.w, r2
mul r2.xyz, r2.w, r0
texld r0.w, v0, s1
add_sat r0.x, r0.w, c5
mul r1.xyz, r2.w, r1
mul_pp r1.xyz, r0.x, r1
mul_pp r2.xyz, r0.x, r2
add_pp r0.x, -r0, c12.z
mul r5.xyz, r5, r2.w
mad_pp r1.xyz, r0.x, r5, r1
mad_pp oC0.xyz, r1, r0.x, r2
mov_pp oC0.w, c10.x
"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_LightShadowData]
Float 3 [_GVar]
Vector 4 [_Color]
Float 5 [_Shininess]
Float 6 [_BlendAdjust1]
Vector 7 [_SSSC]
Float 8 [_Smoothness]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_ScatterMap] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_LightTexture0] 2D
SetTexture 4 [_LightTextureB0] 2D
SetTexture 5 [_ShadowMapTexture] 2D
SetTexture 6 [_ExitColorMap] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 296 ALU, 8 TEX
PARAM c[16] = { program.local[0..8],
		{ 0, 1, 2, 0.1 },
		{ 0.73550957, -0.73550957, 0, -1 },
		{ 0.99270076, -0.99270076, 0.44999999, 2.718282 },
		{ 0.5, 0.39894229, 3.5, 0.001 },
		{ 7, 3.141593, -0.018729299, 0.074261002 },
		{ 0.21211439, 1.570729, 1.3, 0.69999999 },
		{ 3.1415927, 5, 128 } };
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
TEMP R11;
MOV R9.xy, c[9].ywzw;
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.x, R0.x;
MUL R2.xyz, R0.x, fragment.texcoord[1];
MUL R0.x, R2.y, R2.y;
MAD R0.x, R2, R2, R0;
MAD R0.x, R2.z, R2.z, R0;
RSQ R2.w, R0.x;
MUL R0.y, R2.w, -R2.z;
MUL R0.x, R0.y, c[10];
COS R0.z, R0.x;
DP3 R0.x, R2, R2;
MAD R0.y, R0, c[10], R0.z;
MUL R1.w, R9.y, c[8].x;
MUL R1.xy, R0.y, c[10].zwzw;
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, R2;
MAD R8.xyz, R0, c[10].x, R1.xxyw;
MUL R0.x, R8.y, R8.y;
MAD R0.x, R8, R8, R0;
MAD R0.x, R8.z, R8.z, R0;
RSQ R0.x, R0.x;
MUL R0.y, R0.x, -R8.z;
MUL R0.x, R0.y, c[11];
COS R0.z, R0.x;
MAD R0.y, R0, c[11], R0.z;
DP3 R0.x, R8, R8;
RSQ R0.x, R0.x;
MUL R5.xyz, R0.x, R8;
MUL R0.zw, R0.y, c[10];
MAD R4.xyz, R5, c[11].x, R0.zzww;
DP3 R0.x, R4, R4;
MOV R0.w, c[11].z;
MUL R3.w, R0, c[8].x;
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, R4;
MAD R1.xyz, R5, -R3.w, R2;
MAD R3.xyz, -R1.w, R0, R1;
ADD R4.xyz, -R4, R2;
MUL R1.z, R4.y, R4.y;
TEX R0.yw, fragment.texcoord[0].zwzw, texture[2], 2D;
MAD R1.xy, R0.wyzw, c[9].z, -c[9].y;
MAD R4.x, R4, R4, R1.z;
ADD R4.y, -R1.w, -R3.w;
DP3 R5.w, R3, R2;
MUL R0.x, R3.y, R3.y;
MAD R0.x, R3, R3, R0;
MAD R4.w, R3.z, R3.z, R0.x;
DP3 R0.x, R3, R3;
MUL R0.w, R1.y, R1.y;
MAD R0.w, -R1.x, R1.x, -R0;
MAD R4.x, R4.z, R4.z, R4;
RSQ R0.x, R0.x;
ADD R0.w, R0, c[9].y;
RSQ R0.w, R0.w;
RSQ R4.x, R4.x;
RCP R4.x, R4.x;
RSQ R4.w, R4.w;
RCP R4.w, R4.w;
ADD R8.xyz, -R8, R2;
RCP R1.z, R0.w;
MUL R0.xyz, R0.x, R3;
DP3 R0.w, R1, R0;
MUL R10.xyz, R5, R3.w;
MAX R0.w, R0, c[9].x;
MUL R4.w, R2, R4;
MUL R4.x, R4, c[3];
ADD R4.y, R4, c[9].z;
MUL R4.y, R4.x, R4;
MUL R4.x, R0.w, R0.w;
MUL R4.x, R4, R4.y;
MUL R4.z, R4.x, R4.y;
ADD R4.xy, R3, -R2;
MUL R4.xy, R1.w, R4;
MUL R4.xy, R4, R4.w;
MUL R1.w, R4.z, c[12].x;
MAD R4.xy, -R4, c[12].w, fragment.texcoord[0];
TEX R4, R4, texture[6], 2D;
POW R1.w, c[11].w, -R1.w;
MUL R1.w, -R1, c[12].y;
ADD R6.w, R1, c[9].y;
DP3 R1.w, fragment.texcoord[2], fragment.texcoord[2];
MUL R3.xyz, R4, c[0];
MUL_SAT R5.w, R5, c[8].x;
MUL R3.xyz, R5.w, R3;
ADD R5.w, -R5, c[9].y;
MAD R6.xyz, R5.w, c[0], R3;
MUL R5.w, R0, R6;
RSQ R1.w, R1.w;
MUL R3.xyz, R1.w, fragment.texcoord[2];
ADD R7.xyz, R0, R3;
ADD_SAT R0.w, -R5, c[9].y;
POW R0.w, R0.w, c[12].z;
DP3 R1.w, fragment.texcoord[3], fragment.texcoord[3];
DP3 R7.w, R7, R7;
MUL R0.z, R0.w, R4.w;
TXP R0.x, fragment.texcoord[4], texture[5], 2D;
RCP R0.y, fragment.texcoord[4].w;
MAD R0.y, -fragment.texcoord[4].z, R0, R0.x;
CMP R4.w, R0.y, c[2].x, R9.x;
RCP R0.x, fragment.texcoord[3].w;
MAD R0.xy, fragment.texcoord[3], R0.x, c[12].x;
TEX R0.w, R0, texture[3], 2D;
SLT R0.x, c[9], fragment.texcoord[3].z;
MUL R0.x, R0, R0.w;
TEX R1.w, R1.w, texture[4], 2D;
MUL R0.x, R0, R1.w;
MUL R1.w, R0.x, R4;
MUL R0.w, R0.z, R1;
RSQ R0.x, R7.w;
MUL R0.xyz, R0.x, R7;
DP3 R8.w, R1, R0;
DP3 R0.y, R0, R3;
DP3 R7.w, R1, R2;
MUL_SAT R0.w, R0, c[13].x;
MUL R4.xyz, R0.w, R4;
ABS R4.w, R8;
MUL R4.xyz, R4, c[7];
ADD R0.w, -R0, c[9].y;
MAD R6.xyz, R0.w, R6, R4;
ADD R4.x, -R4.w, c[9].y;
MAD R0.w, R4, c[13].z, c[13];
MAD R0.w, R0, R4, -c[14].x;
RSQ R4.x, R4.x;
MAD R0.w, R0, R4, c[14].y;
RCP R4.x, R4.x;
MUL R7.x, R0.w, R4;
TEX R4, fragment.texcoord[0], texture[0], 2D;
SLT R0.w, R8, c[9].x;
MUL R7.y, R0.w, R7.x;
MAD R7.x, -R7.y, c[9].z, R7;
MUL R4.xyz, R4, c[4];
MAD R0.w, R0, c[13].y, R7.x;
MOV R7.y, c[8].x;
MAD R11.x, R7.y, c[14].z, c[14].w;
COS R0.w, R0.w;
MUL R0.w, R0, R0;
MUL R9.w, R11.x, R11.x;
MUL R7.x, R0.w, R11;
MUL R7.x, R7, R11;
MUL R7.y, R0.w, R9.w;
MUL R7.y, R0.w, R7;
RCP R9.y, R0.y;
MUL R5.x, R8.w, R7.w;
MUL R7.y, R7, c[15].x;
RCP R7.x, R7.x;
ADD R0.w, -R0, c[9].y;
MUL R0.w, R0, R7.x;
RCP R7.x, R7.y;
MOV R7.y, c[9];
ADD R10.w, R7.y, -c[5].x;
DP3 R7.y, R1, R3;
MUL R0.x, R8.w, R7.y;
MUL R0.x, R0, R9.y;
MUL R9.y, R9, R5.x;
POW R0.w, c[11].w, -R0.w;
MUL R0.w, R0, R7.x;
ADD R7.x, -R8.w, c[9].y;
POW R7.x, R7.x, c[15].y;
MAD R7.x, R7, c[5], R10.w;
MUL R7.x, R0.w, R7;
RCP R0.w, R7.y;
MUL R7.x, R4.w, R7;
MUL_SAT R9.x, R7, R0.w;
ADD R7.xyz, R2, -R10;
MUL R9.z, R0.x, c[9];
DP3 R0.x, R7, R7;
MUL R9.y, R9, c[9].z;
MIN_SAT R10.z, R9, R9.y;
MAX R9.y, R8.w, c[9].x;
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, R7;
ADD R5.xyz, R3, R0;
DP3 R0.x, R1, R0;
DP3 R11.y, R5, R5;
RSQ R9.z, R11.y;
MUL R5.xyz, R9.z, R5;
DP3 R11.y, R1, R5;
ABS R5.y, R11;
MAD R5.z, R5.y, c[13], c[13].w;
MOV R8.w, c[15].z;
MUL R8.w, R8, c[5].x;
POW R5.x, R9.y, R8.w;
ADD R9.y, -R5, c[9];
MAD R5.z, R5, R5.y, -c[14].x;
RSQ R9.y, R9.y;
MUL R5.x, R4.w, R5;
MUL R5.x, R5, c[12];
MAD R5.x, R9, R10.z, R5;
MAX R0.z, R0.x, c[9].x;
MAD R5.y, R5.z, R5, c[14];
RCP R9.y, R9.y;
MUL R5.z, R5.y, R9.y;
SLT R5.y, R11, c[9].x;
MUL R9.y, R5, R5.z;
MAD R5.z, -R9.y, c[9], R5;
MAD R5.y, R5, c[13], R5.z;
MUL_SAT R9.x, R6.w, R5;
COS R5.y, R5.y;
MUL R6.w, R5.y, R5.y;
MUL R11.z, R11.x, R6.w;
MOV R5.xyz, c[1];
MUL R5.xyz, R5, c[0];
MUL R9.xyz, R5, R9.x;
MUL R6.xyz, R4, R6;
MAD R6.xyz, R6, R5.w, R9;
MUL R11.x, R11, R11.z;
RCP R9.x, R11.x;
ADD R5.w, -R6, c[9].y;
MUL R5.w, R5, R9.x;
MUL R9.x, R9.w, R6.w;
MUL R6.w, R6, R9.x;
ADD R9.x, -R11.y, c[9].y;
MUL R6.w, R6, c[15].x;
POW R9.x, R9.x, c[15].y;
RCP R6.w, R6.w;
POW R5.w, c[11].w, -R5.w;
MUL R5.w, R5, R6;
MAD R9.x, R9, c[5], R10.w;
MUL R6.w, R5, R9.x;
MUL R5.w, R1, c[9].z;
MUL R6.w, R4, R6;
MUL_SAT R0.w, R0, R6;
MAX R6.w, R11.y, c[9].x;
POW R9.x, R6.w, R8.w;
MUL R6.w, R8.y, R8.y;
MAD R6.w, R8.x, R8.x, R6;
MAD R6.w, R8.z, R8.z, R6;
RSQ R0.y, R6.w;
RCP R0.x, R0.y;
MUL R8.y, R4.w, R9.x;
MUL R8.x, R8.y, c[12];
MAD R6.w, R10.z, R0, R8.x;
ADD R0.y, -R3.w, c[9];
MUL R0.x, R0, c[3];
MUL R0.y, R0.x, R0;
MUL R0.x, R0.z, R0.z;
MUL R0.x, R0, R0.y;
MUL R0.x, R0, R0.y;
MUL R0.y, R7, R7;
MAD R0.y, R7.x, R7.x, R0;
MAD R0.y, R7.z, R7.z, R0;
MUL R0.x, R0, c[12];
POW R0.x, c[11].w, -R0.x;
MUL R0.x, -R0, c[12].y;
ADD R0.w, R0.x, c[9].y;
RSQ R0.y, R0.y;
MUL_SAT R6.w, R0, R6;
RCP R0.x, R0.y;
MUL R2.w, R2, R0.x;
MUL R0.xy, R3.w, -R10;
MUL R0.xy, R0, R2.w;
MUL R2.w, R0.z, R0;
MAD R0.xy, -R0, c[12].w, fragment.texcoord[0];
ADD_SAT R3.w, -R2, c[9].y;
TEX R0, R0, texture[6], 2D;
POW R3.w, R3.w, c[12].z;
MUL R0.w, R3, R0;
DP3 R3.w, R2, R7;
ADD R2.xyz, R2, R3;
MUL R0.w, R1, R0;
MUL_SAT R0.w, R0, c[13].x;
MUL R7.xyz, R0, c[0];
MUL_SAT R3.w, R3, c[8].x;
MUL R7.xyz, R3.w, R7;
DP3 R3.x, R2, R2;
MUL R0.xyz, R0.w, R0;
ADD R3.w, -R3, c[9].y;
RSQ R3.x, R3.x;
ADD R1.w, -R0, c[9].y;
MUL R2.xyz, R3.x, R2;
DP3 R0.w, R1, R2;
MAX R0.w, R0, c[9].x;
POW R0.w, R0.w, R8.w;
MUL_SAT R0.w, R4, R0;
MUL R2.xyz, R5, R0.w;
MAX R0.w, R7, c[9].x;
MUL R1.xyz, R4, c[0];
MAD R1.xyz, R1, R0.w, R2;
TEX R0.w, fragment.texcoord[0], texture[1], 2D;
ADD_SAT R0.w, R0, c[6].x;
MUL R2.xyz, R5.w, R1;
MUL R6.xyz, R6, R5.w;
MUL R8.xyz, R5, R6.w;
MAD R7.xyz, R3.w, c[0], R7;
MUL R0.xyz, R0, c[7];
MAD R0.xyz, R1.w, R7, R0;
MUL R0.xyz, R4, R0;
MAD R0.xyz, R0, R2.w, R8;
MUL R0.xyz, R5.w, R0;
MUL R1.xyz, R0.w, R0;
ADD R0.x, -R0.w, c[9].y;
MUL R2.xyz, R0.w, R2;
MAD R1.xyz, R0.x, R6, R1;
MAD result.color.xyz, R1, R0.x, R2;
MOV result.color.w, c[9].x;
END
# 296 instructions, 12 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_LightShadowData]
Float 3 [_GVar]
Vector 4 [_Color]
Float 5 [_Shininess]
Float 6 [_BlendAdjust1]
Vector 7 [_SSSC]
Float 8 [_Smoothness]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_ScatterMap] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_LightTexture0] 2D
SetTexture 4 [_LightTextureB0] 2D
SetTexture 5 [_ShadowMapTexture] 2D
SetTexture 6 [_ExitColorMap] 2D
"ps_3_0
; 355 ALU, 8 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
def c9, 2.00000000, -1.00000000, 0.10000000, -0.73550957
def c10, 0.11705996, 0.50000000, 6.28318501, -3.14159298
def c11, 0.00000000, -1.00000000, 0.73550957, -0.99270076
def c12, 0.15799320, 0.50000000, 0.99270076, 0.44999999
def c13, 2.71828198, 0.39894229, 1.00000000, 3.50000000
def c14, 0.00100000, 0.00000000, 1.00000000, 7.00000000
def c15, -0.01872930, 0.07426100, -0.21211439, 1.57072902
def c16, 3.14159298, 0.15915491, 0.50000000, 3.14159274
def c17, 1.29999995, 0.69999999, 5.00000000, 128.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3
dcl_texcoord4 v4
dp3_pp r0.x, v1, v1
rsq_pp r0.x, r0.x
mul_pp r2.xyz, r0.x, v1
mul r0.x, r2.y, r2.y
mad r0.x, r2, r2, r0
mad r0.x, r2.z, r2.z, r0
rsq r1.w, r0.x
mul r1.x, r1.w, -r2.z
mad r0.x, r1, c10, c10.y
frc r0.x, r0
mad r1.y, r0.x, c10.z, c10.w
sincos r0.xy, r1.y
mad r0.z, r1.x, c9.w, r0.x
dp3 r0.y, r2, r2
mul r1.xy, r0.z, c11
rsq r0.x, r0.y
mul r0.xyz, r0.x, r2
mad r3.xyz, r0, c11.z, r1.xxyw
mul r0.x, r3.y, r3.y
mad r0.x, r3, r3, r0
mad r0.x, r3.z, r3.z, r0
rsq r0.x, r0.x
mul r1.x, r0, -r3.z
mad r0.x, r1, c12, c12.y
frc r0.x, r0
mad r1.y, r0.x, c10.z, c10.w
sincos r0.xy, r1.y
mad r0.z, r1.x, c11.w, r0.x
dp3 r0.y, r3, r3
rsq r0.x, r0.y
mul r8.xyz, r0.x, r3
add r3.xyz, -r3, r2
mul r0.zw, r0.z, c11.xyxy
mad r9.xyz, r8, c12.z, r0.zzww
dp3 r0.x, r9, r9
mov r0.w, c8.x
mul r2.w, c12, r0
mov r0.w, c8.x
rsq r0.x, r0.x
mul r0.xyz, r0.x, r9
add r9.xyz, -r9, r2
mad r1.xyz, r8, -r2.w, r2
mul r4.w, c9.z, r0
mad r7.xyz, -r4.w, r0, r1
dp3 r0.x, r7, r7
texld r0.yw, v0.zwzw, s2
mad_pp r1.xy, r0.wyzw, c9.x, c9.y
rsq r0.x, r0.x
mul r6.xyz, r0.x, r7
mul_pp r0.w, r1.y, r1.y
mad_pp r0.w, -r1.x, r1.x, -r0
dp3_pp r0.x, v2, v2
rsq_pp r0.x, r0.x
mul_pp r4.xyz, r0.x, v2
add r0.xyz, r6, r4
dp3 r1.z, r0, r0
rsq r1.z, r1.z
add_pp r0.w, r0, c13.z
mul r5.xyz, r1.z, r0
rsq_pp r0.w, r0.w
rcp_pp r1.z, r0.w
dp3 r5.w, r1, r5
abs r0.x, r5.w
add r0.z, -r0.x, c13
mad r0.y, r0.x, c15.x, c15
mad r0.y, r0, r0.x, c15.z
rsq r0.z, r0.z
mad r0.x, r0.y, r0, c15.w
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r0.x, r5.w, c14.y, c14.z
mul r0.z, r0.x, r0.y
mad r0.y, -r0.z, c9.x, r0
mad r0.x, r0, c16, r0.y
mad r0.x, r0, c16.y, c16.z
frc r0.x, r0
mad r3.w, r0.x, c10.z, c10
sincos r0.xy, r3.w
mov r0.y, c8.x
mad r8.w, r0.y, c17.x, c17.y
mul r0.x, r0, r0
mul r0.y, r0.x, r8.w
mul r0.y, r0, r8.w
mul r3.w, r8, r8
mul r0.w, r0.x, r3
rcp r0.z, r0.y
add r0.y, -r0.x, c13.z
mul r6.w, r0.y, r0.z
mul r7.w, r0.x, r0
pow r0, c13.x, -r6.w
mul r0.y, r7.w, c16.w
rcp r0.y, r0.y
mul r10.x, r0, r0.y
add r7.w, -r5, c13.z
pow r0, r7.w, c17.z
dp3 r0.y, r1, r6
mul r6.w, r9.y, r9.y
mad r0.z, r9.x, r9.x, r6.w
mov_pp r6.z, c5.x
max r6.x, r0.y, c11
mad r0.z, r9, r9, r0
rsq r0.y, r0.z
add r0.z, -r4.w, -r2.w
rcp r0.y, r0.y
add_pp r7.w, c13.z, -r6.z
mul r0.y, r0, c3.x
add r0.z, r0, c9.x
mul r0.z, r0.y, r0
mul r0.y, r6.x, r6.x
mul r0.y, r0, r0.z
mov r6.w, r0.x
mul r0.y, r0, r0.z
mul r6.y, r0, c10
pow r0, c13.x, -r6.y
mad r10.w, -r0.x, c13.y, c13.z
mul r9.w, r6.x, r10
mul r0.y, r7, r7
mad r0.x, r7, r7, r0.y
mad r0.x, r7.z, r7.z, r0
mad r9.z, r6.w, c5.x, r7.w
add_sat r6.x, -r9.w, c13.z
rsq r6.y, r0.x
pow r0, r6.x, c13.w
add r0.zw, r7.xyxy, -r2.xyxy
dp3 r7.x, r7, r2
rcp r0.y, r6.y
mul r0.y, r1.w, r0
mul r0.zw, r4.w, r0
mul r0.zw, r0, r0.y
mad r6.xy, -r0.zwzw, c14.x, v0
mov r0.y, r0.x
texld r6, r6, s6
texldp r0.x, v4, s5
rcp r0.z, v4.w
mad r0.z, -v4, r0, r0.x
mov r0.w, c2.x
cmp r4.w, r0.z, c13.z, r0
rcp r0.x, v3.w
mad r9.xy, v3, r0.x, c10.y
dp3 r0.x, v3, v3
texld r0.w, r9, s3
cmp r0.z, -v3, c14.y, c14
mul_pp r0.z, r0, r0.w
mul r0.w, r10.x, r9.z
mul r10.xyz, r8, r2.w
texld r0.x, r0.x, s4
mul_pp r0.x, r0.z, r0
mul_pp r4.w, r0.x, r4
mul r0.x, r0.y, r6.w
mul r0.x, r0, r4.w
mul_sat r6.w, r0.x, c14
mul_pp r0.xyz, r6, c0
mul_sat r7.x, r7, c8
mul r0.xyz, r7.x, r0
add r7.x, -r7, c13.z
add r8.xyz, r2, -r10
add r9.x, -r6.w, c13.z
mad r0.xyz, r7.x, c0, r0
mul r6.xyz, r6.w, r6
mul r7.xyz, r6, c7
texld r6, v0, s0
mad r0.xyz, r9.x, r0, r7
mul_pp r6.xyz, r6, c4
mul_pp r7.xyz, r6, r0
dp3_pp r0.y, r1, r4
mul r10.z, r5.w, r0.y
mul r0.x, r6.w, r0.w
rcp r12.y, r0.y
mul_sat r11.x, r0, r12.y
dp3 r0.x, r8, r8
rsq r0.y, r0.x
dp3_pp r0.x, r5, r4
rcp r0.w, r0.x
mul r5.x, r10.z, r0.w
mul r9.xyz, r0.y, r8
add r0.xyz, r4, r9
dp3 r5.y, r0, r0
rsq r5.y, r5.y
mul r0.xyz, r5.y, r0
dp3 r12.z, r1, r0
dp3_pp r10.z, r1, r2
abs r0.y, r12.z
mul r5.y, r5.w, r10.z
mul r0.x, r0.w, r5.y
add r0.w, -r0.y, c13.z
mad r0.z, r0.y, c15.x, c15.y
mad r0.z, r0, r0.y, c15
mad r0.y, r0.z, r0, c15.w
rsq r0.w, r0.w
rcp r0.w, r0.w
mul r0.y, r0, r0.w
cmp r0.z, r12, c14.y, c14
mul r0.w, r0.z, r0.y
mul r5.x, r5, c9
mul r0.x, r0, c9
min_sat r12.x, r5, r0
mad r0.x, -r0.w, c9, r0.y
mad r0.z, r0, c16.x, r0.x
mov_pp r0.x, c5
mul_pp r11.w, c17, r0.x
max r0.y, r5.w, c11.x
mad r0.z, r0, c16.y, c16
pow r5, r0.y, r11.w
frc r0.x, r0.z
mad r5.y, r0.x, c10.z, c10.w
sincos r0.xy, r5.y
mov r0.y, r5.x
mul r5.w, r0.x, r0.x
mul r0.y, r6.w, r0
mul r0.x, r0.y, c10.y
mul r0.y, r8.w, r5.w
mul r0.y, r8.w, r0
mad r0.x, r11, r12, r0
mul_sat r8.w, r10, r0.x
mov_pp r5.xyz, c0
mul_pp r5.xyz, c1, r5
mul r11.xyz, r5, r8.w
mad r7.xyz, r7, r9.w, r11
mul r3.w, r3, r5
add r0.x, -r5.w, c13.z
rcp r0.y, r0.y
mul r10.w, r0.x, r0.y
pow r0, c13.x, -r10.w
mov r8.w, r0.x
add r9.w, -r12.z, c13.z
pow r0, r9.w, c17.z
mul r0.y, r5.w, r3.w
mul_pp r5.w, r4, c9.x
mov r0.z, r0.x
mul r0.y, r0, c16.w
rcp r0.x, r0.y
mad r0.y, r0.z, c5.x, r7.w
mul r0.x, r8.w, r0
mul r0.x, r0, r0.y
mul r0.x, r6.w, r0
mul_sat r3.w, r12.y, r0.x
max r7.w, r12.z, c11.x
pow r0, r7.w, r11.w
mul r3.y, r3, r3
mad r0.y, r3.x, r3.x, r3
mad r0.z, r3, r3, r0.y
dp3 r0.y, r1, r9
max r3.x, r0.y, c11
rsq r0.z, r0.z
rcp r0.y, r0.z
mov r0.w, r0.x
mul r0.y, r0, c3.x
add r0.z, -r2.w, c13
mul r0.z, r0.y, r0
mul r0.y, r3.x, r3.x
mul r0.y, r0, r0.z
mul r0.x, r0.y, r0.z
mul r0.y, r6.w, r0.w
mul r3.y, r0.x, c10
mul r3.z, r0.y, c10.y
pow r0, c13.x, -r3.y
mad r0.z, r12.x, r3.w, r3
mad r0.x, -r0, c13.y, c13.z
mul r7.w, r3.x, r0.x
mul_sat r0.z, r0.x, r0
mul r0.y, r8, r8
mad r0.y, r8.x, r8.x, r0
mad r0.y, r8.z, r8.z, r0
rsq r0.y, r0.y
mul r9.xyz, r5, r0.z
rcp r0.x, r0.y
mul r0.z, r1.w, r0.x
mul r0.xy, r2.w, -r10
mul r3.xy, r0, r0.z
add_sat r3.z, -r7.w, c13
pow r0, r3.z, c13.w
dp3 r0.y, r2, r8
mad r3.xy, -r3, c14.x, v0
texld r3, r3, s6
mov r0.w, r0.x
mul r0.w, r0, r3
mul r0.w, r4, r0
mul_sat r0.w, r0, c14
mul_sat r0.y, r0, c8.x
mul_pp r8.xyz, r3, c0
mul r8.xyz, r0.y, r8
add r0.y, -r0, c13.z
mad r8.xyz, r0.y, c0, r8
add_pp r0.xyz, r2, r4
dp3_pp r1.w, r0, r0
rsq_pp r1.w, r1.w
mul_pp r0.xyz, r1.w, r0
dp3_pp r1.x, r1, r0
max_pp r2.x, r1, c11
mul r0.xyz, r0.w, r3
add r1.w, -r0, c13.z
mul r1.xyz, r0, c7
pow r0, r2.x, r11.w
mov r0.w, r0.x
mul_sat r0.w, r6, r0
mul r2.xyz, r5, r0.w
mad r1.xyz, r1.w, r8, r1
mul_pp r1.xyz, r6, r1
mad r0.xyz, r1, r7.w, r9
mul r0.xyz, r5.w, r0
max_pp r0.w, r10.z, c11.x
mul_pp r1.xyz, r6, c0
mad r1.xyz, r1, r0.w, r2
texld r0.w, v0, s1
add_sat r0.w, r0, c6.x
mul r2.xyz, r5.w, r1
mul_pp r1.xyz, r0.w, r0
add_pp r0.x, -r0.w, c13.z
mul r7.xyz, r7, r5.w
mul_pp r2.xyz, r0.w, r2
mad_pp r1.xyz, r0.x, r7, r1
mad_pp oC0.xyz, r1, r0.x, r2
mov_pp oC0.w, c11.x
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_LightShadowData]
Float 3 [_GVar]
Vector 4 [_Color]
Float 5 [_Shininess]
Float 6 [_BlendAdjust1]
Vector 7 [_SSSC]
Float 8 [_Smoothness]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_ScatterMap] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_LightTexture0] 2D
SetTexture 4 [_LightTextureB0] 2D
SetTexture 5 [_ShadowMapTexture] 2D
SetTexture 6 [_ExitColorMap] 2D
"ps_3_0
; 354 ALU, 8 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
def c9, 2.00000000, -1.00000000, 0.10000000, -0.73550957
def c10, 0.11705996, 0.50000000, 6.28318501, -3.14159298
def c11, 0.00000000, -1.00000000, 0.73550957, -0.99270076
def c12, 0.15799320, 0.50000000, 0.99270076, 0.44999999
def c13, 2.71828198, 0.39894229, 1.00000000, 3.50000000
def c14, 0.00100000, 0.00000000, 1.00000000, 7.00000000
def c15, -0.01872930, 0.07426100, -0.21211439, 1.57072902
def c16, 3.14159298, 0.15915491, 0.50000000, 3.14159274
def c17, 1.29999995, 0.69999999, 5.00000000, 128.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3
dcl_texcoord4 v4
dp3_pp r0.x, v1, v1
rsq_pp r0.x, r0.x
mul_pp r2.xyz, r0.x, v1
mul r0.x, r2.y, r2.y
mad r0.x, r2, r2, r0
mad r0.x, r2.z, r2.z, r0
rsq r1.w, r0.x
mul r1.x, r1.w, -r2.z
mad r0.x, r1, c10, c10.y
frc r0.x, r0
mad r1.y, r0.x, c10.z, c10.w
sincos r0.xy, r1.y
mad r0.z, r1.x, c9.w, r0.x
dp3 r0.y, r2, r2
mul r1.xy, r0.z, c11
rsq r0.x, r0.y
mul r0.xyz, r0.x, r2
mad r3.xyz, r0, c11.z, r1.xxyw
mul r0.x, r3.y, r3.y
mad r0.x, r3, r3, r0
mad r0.x, r3.z, r3.z, r0
rsq r0.x, r0.x
mul r1.x, r0, -r3.z
mad r0.x, r1, c12, c12.y
frc r0.x, r0
mad r1.y, r0.x, c10.z, c10.w
sincos r0.xy, r1.y
mad r0.z, r1.x, c11.w, r0.x
dp3 r0.y, r3, r3
rsq r0.x, r0.y
mul r8.xyz, r0.x, r3
add r3.xyz, -r3, r2
mul r0.zw, r0.z, c11.xyxy
mad r9.xyz, r8, c12.z, r0.zzww
dp3 r0.x, r9, r9
mov r0.w, c8.x
mul r2.w, c12, r0
mov r0.w, c8.x
rsq r0.x, r0.x
mul r0.xyz, r0.x, r9
add r9.xyz, -r9, r2
mad r1.xyz, r8, -r2.w, r2
mul r4.w, c9.z, r0
mad r7.xyz, -r4.w, r0, r1
dp3 r0.x, r7, r7
texld r0.yw, v0.zwzw, s2
mad_pp r1.xy, r0.wyzw, c9.x, c9.y
rsq r0.x, r0.x
mul r6.xyz, r0.x, r7
mul_pp r0.w, r1.y, r1.y
mad_pp r0.w, -r1.x, r1.x, -r0
dp3_pp r0.x, v2, v2
rsq_pp r0.x, r0.x
mul_pp r4.xyz, r0.x, v2
add r0.xyz, r6, r4
dp3 r1.z, r0, r0
rsq r1.z, r1.z
add_pp r0.w, r0, c13.z
mul r5.xyz, r1.z, r0
rsq_pp r0.w, r0.w
rcp_pp r1.z, r0.w
dp3 r5.w, r1, r5
abs r0.x, r5.w
add r0.z, -r0.x, c13
mad r0.y, r0.x, c15.x, c15
mad r0.y, r0, r0.x, c15.z
rsq r0.z, r0.z
mad r0.x, r0.y, r0, c15.w
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r0.x, r5.w, c14.y, c14.z
mul r0.z, r0.x, r0.y
mad r0.y, -r0.z, c9.x, r0
mad r0.x, r0, c16, r0.y
mad r0.x, r0, c16.y, c16.z
frc r0.x, r0
mad r3.w, r0.x, c10.z, c10
sincos r0.xy, r3.w
mov r0.y, c8.x
mad r8.w, r0.y, c17.x, c17.y
mul r0.x, r0, r0
mul r0.y, r0.x, r8.w
mul r0.y, r0, r8.w
mul r3.w, r8, r8
mul r0.w, r0.x, r3
rcp r0.z, r0.y
add r0.y, -r0.x, c13.z
mul r6.w, r0.y, r0.z
mul r7.w, r0.x, r0
pow r0, c13.x, -r6.w
mul r0.y, r7.w, c16.w
rcp r0.y, r0.y
mul r10.x, r0, r0.y
add r7.w, -r5, c13.z
pow r0, r7.w, c17.z
dp3 r0.y, r1, r6
mul r6.w, r9.y, r9.y
mad r0.z, r9.x, r9.x, r6.w
mov_pp r6.z, c5.x
max r6.x, r0.y, c11
mad r0.z, r9, r9, r0
rsq r0.y, r0.z
add r0.z, -r4.w, -r2.w
rcp r0.y, r0.y
add_pp r7.w, c13.z, -r6.z
mul r0.y, r0, c3.x
add r0.z, r0, c9.x
mul r0.z, r0.y, r0
mul r0.y, r6.x, r6.x
mul r0.y, r0, r0.z
mov r6.w, r0.x
mul r0.y, r0, r0.z
mul r6.y, r0, c10
pow r0, c13.x, -r6.y
mad r10.w, -r0.x, c13.y, c13.z
mul r9.w, r6.x, r10
mul r0.y, r7, r7
mad r0.x, r7, r7, r0.y
mad r0.x, r7.z, r7.z, r0
mad r9.z, r6.w, c5.x, r7.w
add_sat r6.x, -r9.w, c13.z
rsq r6.y, r0.x
pow r0, r6.x, c13.w
add r0.zw, r7.xyxy, -r2.xyxy
dp3 r7.x, r7, r2
rcp r0.y, r6.y
mul r0.y, r1.w, r0
mul r0.zw, r4.w, r0
mul r0.zw, r0, r0.y
mad r6.xy, -r0.zwzw, c14.x, v0
mov r0.y, r0.x
mov r0.x, c2
add r0.w, c13.z, -r0.x
rcp r0.z, v3.w
mad r9.xy, v3, r0.z, c10.y
texldp r0.x, v4, s5
mad r4.w, r0.x, r0, c2.x
dp3 r0.x, v3, v3
texld r6, r6, s6
texld r0.w, r9, s3
cmp r0.z, -v3, c14.y, c14
mul_pp r0.z, r0, r0.w
mul r0.w, r10.x, r9.z
mul r10.xyz, r8, r2.w
texld r0.x, r0.x, s4
mul_pp r0.x, r0.z, r0
mul_pp r4.w, r0.x, r4
mul r0.x, r0.y, r6.w
mul r0.x, r0, r4.w
mul_sat r6.w, r0.x, c14
mul_pp r0.xyz, r6, c0
mul_sat r7.x, r7, c8
mul r0.xyz, r7.x, r0
add r7.x, -r7, c13.z
add r8.xyz, r2, -r10
add r9.x, -r6.w, c13.z
mad r0.xyz, r7.x, c0, r0
mul r6.xyz, r6.w, r6
mul r7.xyz, r6, c7
texld r6, v0, s0
mad r0.xyz, r9.x, r0, r7
mul_pp r6.xyz, r6, c4
mul_pp r7.xyz, r6, r0
dp3_pp r0.y, r1, r4
mul r10.z, r5.w, r0.y
mul r0.x, r6.w, r0.w
rcp r12.y, r0.y
mul_sat r11.x, r0, r12.y
dp3 r0.x, r8, r8
rsq r0.y, r0.x
dp3_pp r0.x, r5, r4
rcp r0.w, r0.x
mul r5.x, r10.z, r0.w
mul r9.xyz, r0.y, r8
add r0.xyz, r4, r9
dp3 r5.y, r0, r0
rsq r5.y, r5.y
mul r0.xyz, r5.y, r0
dp3 r12.z, r1, r0
dp3_pp r10.z, r1, r2
abs r0.y, r12.z
mul r5.y, r5.w, r10.z
mul r0.x, r0.w, r5.y
add r0.w, -r0.y, c13.z
mad r0.z, r0.y, c15.x, c15.y
mad r0.z, r0, r0.y, c15
mad r0.y, r0.z, r0, c15.w
rsq r0.w, r0.w
rcp r0.w, r0.w
mul r0.y, r0, r0.w
cmp r0.z, r12, c14.y, c14
mul r0.w, r0.z, r0.y
mul r5.x, r5, c9
mul r0.x, r0, c9
min_sat r12.x, r5, r0
mad r0.x, -r0.w, c9, r0.y
mad r0.z, r0, c16.x, r0.x
mov_pp r0.x, c5
mul_pp r11.w, c17, r0.x
max r0.y, r5.w, c11.x
mad r0.z, r0, c16.y, c16
pow r5, r0.y, r11.w
frc r0.x, r0.z
mad r5.y, r0.x, c10.z, c10.w
sincos r0.xy, r5.y
mov r0.y, r5.x
mul r5.w, r0.x, r0.x
mul r0.y, r6.w, r0
mul r0.x, r0.y, c10.y
mul r0.y, r8.w, r5.w
mul r0.y, r8.w, r0
mad r0.x, r11, r12, r0
mul_sat r8.w, r10, r0.x
mov_pp r5.xyz, c0
mul_pp r5.xyz, c1, r5
mul r11.xyz, r5, r8.w
mad r7.xyz, r7, r9.w, r11
mul r3.w, r3, r5
add r0.x, -r5.w, c13.z
rcp r0.y, r0.y
mul r10.w, r0.x, r0.y
pow r0, c13.x, -r10.w
mov r8.w, r0.x
add r9.w, -r12.z, c13.z
pow r0, r9.w, c17.z
mul r0.y, r5.w, r3.w
mul_pp r5.w, r4, c9.x
mov r0.z, r0.x
mul r0.y, r0, c16.w
rcp r0.x, r0.y
mad r0.y, r0.z, c5.x, r7.w
mul r0.x, r8.w, r0
mul r0.x, r0, r0.y
mul r0.x, r6.w, r0
mul_sat r3.w, r12.y, r0.x
max r7.w, r12.z, c11.x
pow r0, r7.w, r11.w
mul r3.y, r3, r3
mad r0.y, r3.x, r3.x, r3
mad r0.z, r3, r3, r0.y
dp3 r0.y, r1, r9
max r3.x, r0.y, c11
rsq r0.z, r0.z
rcp r0.y, r0.z
mov r0.w, r0.x
mul r0.y, r0, c3.x
add r0.z, -r2.w, c13
mul r0.z, r0.y, r0
mul r0.y, r3.x, r3.x
mul r0.y, r0, r0.z
mul r0.x, r0.y, r0.z
mul r0.y, r6.w, r0.w
mul r3.y, r0.x, c10
mul r3.z, r0.y, c10.y
pow r0, c13.x, -r3.y
mad r0.z, r12.x, r3.w, r3
mad r0.x, -r0, c13.y, c13.z
mul r7.w, r3.x, r0.x
mul_sat r0.z, r0.x, r0
mul r0.y, r8, r8
mad r0.y, r8.x, r8.x, r0
mad r0.y, r8.z, r8.z, r0
rsq r0.y, r0.y
mul r9.xyz, r5, r0.z
rcp r0.x, r0.y
mul r0.z, r1.w, r0.x
mul r0.xy, r2.w, -r10
mul r3.xy, r0, r0.z
add_sat r3.z, -r7.w, c13
pow r0, r3.z, c13.w
dp3 r0.y, r2, r8
mad r3.xy, -r3, c14.x, v0
texld r3, r3, s6
mov r0.w, r0.x
mul r0.w, r0, r3
mul r0.w, r4, r0
mul_sat r0.w, r0, c14
mul_sat r0.y, r0, c8.x
mul_pp r8.xyz, r3, c0
mul r8.xyz, r0.y, r8
add r0.y, -r0, c13.z
mad r8.xyz, r0.y, c0, r8
add_pp r0.xyz, r2, r4
dp3_pp r1.w, r0, r0
rsq_pp r1.w, r1.w
mul_pp r0.xyz, r1.w, r0
dp3_pp r1.x, r1, r0
max_pp r2.x, r1, c11
mul r0.xyz, r0.w, r3
add r1.w, -r0, c13.z
mul r1.xyz, r0, c7
pow r0, r2.x, r11.w
mov r0.w, r0.x
mul_sat r0.w, r6, r0
mul r2.xyz, r5, r0.w
mad r1.xyz, r1.w, r8, r1
mul_pp r1.xyz, r6, r1
mad r0.xyz, r1, r7.w, r9
mul r0.xyz, r5.w, r0
max_pp r0.w, r10.z, c11.x
mul_pp r1.xyz, r6, c0
mad r1.xyz, r1, r0.w, r2
texld r0.w, v0, s1
add_sat r0.w, r0, c6.x
mul r2.xyz, r5.w, r1
mul_pp r1.xyz, r0.w, r0
add_pp r0.x, -r0.w, c13.z
mul r7.xyz, r7, r5.w
mul_pp r2.xyz, r0.w, r2
mad_pp r1.xyz, r0.x, r7, r1
mad_pp oC0.xyz, r1, r0.x, r2
mov_pp oC0.w, c11.x
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Float 2 [_GVar]
Vector 3 [_Color]
Float 4 [_Shininess]
Float 5 [_BlendAdjust1]
Vector 6 [_SSSC]
Float 7 [_Smoothness]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_ScatterMap] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_ShadowMapTexture] 2D
SetTexture 4 [_ExitColorMap] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 281 ALU, 6 TEX
PARAM c[15] = { program.local[0..7],
		{ 0, 1, 2, 0.1 },
		{ 0.73550957, -0.73550957, 0, -1 },
		{ 0.99270076, -0.99270076, 0.44999999, 2.718282 },
		{ 0.5, 0.39894229, 3.5, 0.001 },
		{ 7, 3.141593, -0.018729299, 0.074261002 },
		{ 0.21211439, 1.570729, 1.3, 0.69999999 },
		{ 3.1415927, 5, 128 } };
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
MUL R0.x, fragment.texcoord[1].y, fragment.texcoord[1].y;
MAD R0.x, fragment.texcoord[1], fragment.texcoord[1], R0;
MAD R0.x, fragment.texcoord[1].z, fragment.texcoord[1].z, R0;
RSQ R0.y, R0.x;
MUL R0.z, R0.y, -fragment.texcoord[1];
MUL R0.x, R0.z, c[9];
COS R0.w, R0.x;
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.x, R0.x;
MAD R0.z, R0, c[9].y, R0.w;
MUL R0.zw, R0.z, c[9];
MUL R1.xyz, R0.x, fragment.texcoord[1];
MAD R1.xyz, R1, c[9].x, R0.zzww;
MUL R0.x, R1.y, R1.y;
MAD R0.x, R1, R1, R0;
MAD R0.x, R1.z, R1.z, R0;
RSQ R0.x, R0.x;
MUL R0.z, R0.x, -R1;
MUL R0.x, R0.z, c[10];
COS R0.w, R0.x;
DP3 R0.x, R1, R1;
RSQ R0.x, R0.x;
MUL R3.xyz, R0.x, R1;
ADD R1.xyz, -R1, fragment.texcoord[1];
MAD R0.z, R0, c[10].y, R0.w;
MUL R0.zw, R0.z, c[9];
MAD R2.xyz, R3, c[10].x, R0.zzww;
DP3 R0.x, R2, R2;
RSQ R0.x, R0.x;
MUL R4.xyz, R0.x, R2;
ADD R2.xyz, -R2, fragment.texcoord[1];
MUL R2.y, R2, R2;
MAD R2.x, R2, R2, R2.y;
MAD R2.x, R2.z, R2.z, R2;
MOV R0.z, c[10];
MUL R0.z, R0, c[7].x;
MOV R0.x, c[8].w;
MUL R0.x, R0, c[7];
MAD R5.xyz, R3, -R0.z, fragment.texcoord[1];
MAD R4.xyz, -R0.x, R4, R5;
DP3 R1.w, R4, R4;
RSQ R2.w, R1.w;
ADD R2.y, -R0.x, -R0.z;
MUL R0.w, R4.y, R4.y;
MAD R0.w, R4.x, R4.x, R0;
MAD R0.w, R4.z, R4.z, R0;
TEX R5.yw, fragment.texcoord[0].zwzw, texture[2], 2D;
MAD R5.xy, R5.wyzw, c[8].z, -c[8].y;
RSQ R2.z, R0.w;
MUL R1.w, R5.y, R5.y;
MAD R1.w, -R5.x, R5.x, -R1;
ADD R1.w, R1, c[8].y;
RSQ R1.w, R1.w;
RSQ R2.x, R2.x;
RCP R2.x, R2.x;
RCP R2.z, R2.z;
MUL R1.y, R1, R1;
MAD R1.y, R1.x, R1.x, R1;
RCP R5.z, R1.w;
MUL R7.xyz, R2.w, R4;
DP3 R1.w, R5, R7;
MUL R10.xyz, R3, R0.z;
MAD R1.z, R1, R1, R1.y;
MUL R2.z, R0.y, R2;
MAX R1.w, R1, c[8].x;
MUL R2.x, R2, c[2];
ADD R2.y, R2, c[8].z;
MUL R2.y, R2.x, R2;
MUL R2.x, R1.w, R1.w;
MUL R2.x, R2, R2.y;
MUL R0.w, R2.x, R2.y;
ADD R2.xy, R4, -fragment.texcoord[1];
MUL R2.xy, R0.x, R2;
MUL R0.x, R0.w, c[11];
MUL R2.xy, R2, R2.z;
DP3 R0.w, R4, fragment.texcoord[1];
MAD R2.xy, -R2, c[11].w, fragment.texcoord[0];
TEX R2, R2, texture[4], 2D;
POW R0.x, c[10].w, -R0.x;
MUL R0.x, -R0, c[11].y;
ADD R4.w, R0.x, c[8].y;
MUL R1.w, R1, R4;
MUL R4.xyz, R2, c[0];
MUL_SAT R0.w, R0, c[7].x;
MUL R4.xyz, R0.w, R4;
ADD R0.w, -R0, c[8].y;
MAD R6.xyz, R0.w, c[0], R4;
DP3 R0.x, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.w, R0.x;
MUL R4.xyz, R0.w, fragment.texcoord[2];
ADD_SAT R0.x, -R1.w, c[8].y;
POW R0.x, R0.x, c[11].z;
MUL R0.w, R0.x, R2;
ADD R7.xyz, R7, R4;
TXP R0.x, fragment.texcoord[3], texture[3], 2D;
MUL R0.w, R0, R0.x;
DP3 R2.w, R7, R7;
RSQ R2.w, R2.w;
MUL R7.xyz, R2.w, R7;
DP3 R3.w, R5, R7;
DP3 R7.x, R7, R4;
RCP R8.w, R7.x;
ADD R7.xyz, fragment.texcoord[1], -R10;
DP3 R3.x, R7, R7;
MUL_SAT R0.w, R0, c[12].x;
MUL R2.xyz, R0.w, R2;
ABS R2.w, R3;
DP3 R8.x, R5, R4;
MUL R2.xyz, R2, c[6];
ADD R0.w, -R0, c[8].y;
MAD R6.xyz, R0.w, R6, R2;
ADD R2.x, -R2.w, c[8].y;
MAD R0.w, R2, c[12].z, c[12];
MAD R0.w, R0, R2, -c[13].x;
RSQ R2.x, R2.x;
MAD R0.w, R0, R2, c[13].y;
RCP R2.x, R2.x;
MUL R5.w, R0, R2.x;
TEX R2, fragment.texcoord[0], texture[0], 2D;
SLT R0.w, R3, c[8].x;
MUL R6.w, R0, R5;
MAD R5.w, -R6, c[8].z, R5;
MUL R2.xyz, R2, c[3];
MAD R0.w, R0, c[12].y, R5;
MOV R6.w, c[7].x;
MAD R9.w, R6, c[13].z, c[13];
COS R0.w, R0.w;
MUL R0.w, R0, R0;
MUL R6.w, R9, R9;
MUL R7.w, R0, R6;
MUL R5.w, R0, R9;
MUL R7.w, R0, R7;
MUL R5.w, R5, R9;
RSQ R3.y, R3.x;
MUL R6.xyz, R2, R6;
MUL R7.w, R7, c[14].x;
RCP R5.w, R5.w;
ADD R0.w, -R0, c[8].y;
MUL R0.w, R0, R5;
RCP R5.w, R7.w;
POW R0.w, c[10].w, -R0.w;
MUL R0.w, R0, R5;
ADD R5.w, -R3, c[8].y;
MOV R7.w, c[8].y;
ADD R7.w, R7, -c[4].x;
POW R5.w, R5.w, c[14].y;
MAD R5.w, R5, c[4].x, R7;
MUL R0.w, R0, R5;
RCP R5.w, R8.x;
MUL R0.w, R2, R0;
MUL_SAT R9.x, R0.w, R5.w;
MUL R0.w, R3, R8.x;
MUL R8.xyz, R3.y, R7;
MUL R0.w, R0, R8;
MUL R9.y, R0.w, c[8].z;
DP3 R0.w, R5, fragment.texcoord[1];
MUL R3.x, R3.w, R0.w;
MUL R8.w, R8, R3.x;
ADD R3.xyz, R4, R8;
DP3 R9.z, R3, R3;
RSQ R9.z, R9.z;
MUL R3.xyz, R9.z, R3;
DP3 R10.z, R5, R3;
ABS R3.y, R10.z;
MAD R3.z, R3.y, c[12], c[12].w;
MUL R8.w, R8, c[8].z;
MIN_SAT R8.w, R9.y, R8;
MAX R9.y, R3.w, c[8].x;
MOV R3.w, c[14].z;
MUL R3.w, R3, c[4].x;
POW R3.x, R9.y, R3.w;
ADD R9.y, -R3, c[8];
MAD R3.z, R3, R3.y, -c[13].x;
RSQ R9.y, R9.y;
MUL R3.x, R2.w, R3;
MUL R3.x, R3, c[11];
MAD R3.x, R9, R8.w, R3;
MAD R3.y, R3.z, R3, c[13];
RCP R9.y, R9.y;
MUL R3.z, R3.y, R9.y;
SLT R3.y, R10.z, c[8].x;
MUL R9.y, R3, R3.z;
MAD R3.z, -R9.y, c[8], R3;
MAD R3.y, R3, c[12], R3.z;
MUL_SAT R9.x, R4.w, R3;
COS R3.y, R3.y;
MUL R4.w, R3.y, R3.y;
MUL R10.w, R9, R4;
MOV R3.xyz, c[1];
MUL R3.xyz, R3, c[0];
MUL R9.xyz, R3, R9.x;
MAD R6.xyz, R6, R1.w, R9;
MUL R9.w, R9, R10;
MUL R6.w, R6, R4;
ADD R1.w, -R4, c[8].y;
MUL R4.w, R4, R6;
RCP R9.x, R9.w;
MUL R1.w, R1, R9.x;
ADD R6.w, -R10.z, c[8].y;
MUL R4.w, R4, c[14].x;
POW R6.w, R6.w, c[14].y;
DP3 R1.y, R5, R8;
RCP R4.w, R4.w;
POW R1.w, c[10].w, -R1.w;
MUL R1.w, R1, R4;
MUL R4.w, R0.x, c[8].z;
MAD R6.w, R6, c[4].x, R7;
MUL R1.w, R1, R6;
MUL R1.w, R2, R1;
MUL_SAT R1.w, R5, R1;
MAX R5.w, R10.z, c[8].x;
POW R5.w, R5.w, R3.w;
MUL R5.w, R2, R5;
MUL R1.x, R5.w, c[11];
RSQ R5.w, R1.z;
MAX R1.z, R1.y, c[8].x;
RCP R1.y, R5.w;
MAD R6.w, R8, R1, R1.x;
ADD R5.w, -R0.z, c[8].y;
MUL R1.y, R1, c[2].x;
MUL R5.w, R1.y, R5;
MUL R1.y, R1.z, R1.z;
MUL R1.y, R1, R5.w;
MUL R1.x, R1.y, R5.w;
MUL R1.y, R7, R7;
MAD R1.y, R7.x, R7.x, R1;
MAD R1.y, R7.z, R7.z, R1;
MUL R1.x, R1, c[11];
POW R1.x, c[10].w, -R1.x;
MUL R1.x, -R1, c[11].y;
ADD R1.w, R1.x, c[8].y;
MUL_SAT R5.w, R1, R6;
RSQ R1.y, R1.y;
RCP R1.x, R1.y;
MUL R0.y, R0, R1.x;
MUL R1.xy, R0.z, -R10;
MUL R1.xy, R1, R0.y;
MUL R8.xyz, R3, R5.w;
MUL R5.w, R1.z, R1;
DP3 R0.z, fragment.texcoord[1], R7;
MAD R1.xy, -R1, c[11].w, fragment.texcoord[0];
TEX R1, R1, texture[4], 2D;
ADD_SAT R0.y, -R5.w, c[8];
POW R0.y, R0.y, c[11].z;
MUL R0.y, R0, R1.w;
MUL R1.w, R0.x, R0.y;
MUL_SAT R1.w, R1, c[12].x;
MUL R7.xyz, R1, c[0];
MUL_SAT R0.z, R0, c[7].x;
MUL R7.xyz, R0.z, R7;
ADD R0.z, -R0, c[8].y;
MAD R7.xyz, R0.z, c[0], R7;
ADD R0.xyz, fragment.texcoord[1], R4;
DP3 R4.y, R0, R0;
MUL R1.xyz, R1.w, R1;
RSQ R4.y, R4.y;
MUL R1.xyz, R1, c[6];
ADD R4.x, -R1.w, c[8].y;
MUL R0.xyz, R4.y, R0;
DP3 R1.w, R5, R0;
MAD R0.xyz, R4.x, R7, R1;
MUL R0.xyz, R2, R0;
MAX R1.x, R1.w, c[8];
POW R1.x, R1.x, R3.w;
MAD R0.xyz, R0, R5.w, R8;
MUL_SAT R1.x, R2.w, R1;
MUL R0.xyz, R4.w, R0;
MUL R2.xyz, R2, c[0];
MAX R0.w, R0, c[8].x;
MUL R1.xyz, R3, R1.x;
MAD R1.xyz, R2, R0.w, R1;
TEX R0.w, fragment.texcoord[0], texture[1], 2D;
ADD_SAT R0.w, R0, c[5].x;
MUL R2.xyz, R4.w, R1;
MUL R1.xyz, R0.w, R0;
ADD R0.x, -R0.w, c[8].y;
MUL R6.xyz, R6, R4.w;
MUL R2.xyz, R0.w, R2;
MAD R1.xyz, R0.x, R6, R1;
MAD result.color.xyz, R1, R0.x, R2;
MOV result.color.w, c[8].x;
END
# 281 instructions, 11 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Float 2 [_GVar]
Vector 3 [_Color]
Float 4 [_Shininess]
Float 5 [_BlendAdjust1]
Vector 6 [_SSSC]
Float 7 [_Smoothness]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_ScatterMap] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_ShadowMapTexture] 2D
SetTexture 4 [_ExitColorMap] 2D
"ps_3_0
; 342 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c8, 2.00000000, -1.00000000, 0.10000000, -0.73550957
def c9, 0.11705996, 0.50000000, 6.28318501, -3.14159298
def c10, 0.00000000, -1.00000000, 0.73550957, -0.99270076
def c11, 0.15799320, 0.50000000, 0.99270076, 0.44999999
def c12, 2.71828198, 0.39894229, 1.00000000, 3.50000000
def c13, 0.00100000, 7.00000000, 0.00000000, 1.00000000
def c14, -0.01872930, 0.07426100, -0.21211439, 1.57072902
def c15, 3.14159298, 0.15915491, 0.50000000, 3.14159274
def c16, 1.29999995, 0.69999999, 5.00000000, 128.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3
mul r0.x, v1.y, v1.y
mad r0.x, v1, v1, r0
mad r0.x, v1.z, v1.z, r0
rsq r4.w, r0.x
mul r1.x, r4.w, -v1.z
mad r0.x, r1, c9, c9.y
frc r0.x, r0
mad r1.y, r0.x, c9.z, c9.w
sincos r0.xy, r1.y
mad r0.z, r1.x, c8.w, r0.x
dp3 r0.y, v1, v1
mul r1.xy, r0.z, c10
rsq r0.x, r0.y
mul r0.xyz, r0.x, v1
mad r5.xyz, r0, c10.z, r1.xxyw
mul r0.x, r5.y, r5.y
mad r0.x, r5, r5, r0
mad r0.x, r5.z, r5.z, r0
rsq r0.x, r0.x
mul r1.x, r0, -r5.z
mad r0.x, r1, c11, c11.y
frc r0.x, r0
mad r1.y, r0.x, c9.z, c9.w
sincos r0.xy, r1.y
mad r0.z, r1.x, c10.w, r0.x
dp3 r0.y, r5, r5
rsq r0.x, r0.y
mul r2.xyz, r0.x, r5
add r5.xyz, -r5, v1
mul r0.zw, r0.z, c10.xyxy
mad r8.xyz, r2, c11.z, r0.zzww
dp3 r0.x, r8, r8
mov r0.w, c7.x
mul r5.w, c11, r0
mov r0.w, c7.x
rsq r0.x, r0.x
mul r0.xyz, r0.x, r8
mad r1.xyz, r2, -r5.w, v1
mul r2.w, c8.z, r0
mad r3.xyz, -r2.w, r0, r1
texld r0.yw, v0.zwzw, s2
mad_pp r4.xy, r0.wyzw, c8.x, c8.y
dp3 r0.x, r3, r3
rsq r0.x, r0.x
mul r6.xyz, r0.x, r3
mul_pp r0.w, r4.y, r4.y
mad_pp r0.w, -r4.x, r4.x, -r0
dp3_pp r0.x, v2, v2
rsq_pp r0.x, r0.x
mul_pp r7.xyz, r0.x, v2
add r0.xyz, r6, r7
dp3 r1.x, r0, r0
add_pp r0.w, r0, c12.z
rsq_pp r0.w, r0.w
rsq r1.x, r1.x
rcp_pp r4.z, r0.w
mul r1.xyz, r1.x, r0
dp3 r1.w, r4, r1
abs r0.x, r1.w
add r0.z, -r0.x, c12
mad r0.y, r0.x, c14.x, c14
mad r0.y, r0, r0.x, c14.z
rsq r0.z, r0.z
add r8.xyz, -r8, v1
mul r10.xyz, r2, r5.w
mad r0.x, r0.y, r0, c14.w
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r0.x, r1.w, c13.z, c13.w
mul r0.z, r0.x, r0.y
mad r0.y, -r0.z, c8.x, r0
mad r0.x, r0, c15, r0.y
mad r0.x, r0, c15.y, c15.z
frc r0.x, r0
mad r3.w, r0.x, c9.z, c9
sincos r0.xy, r3.w
mov r0.y, c7.x
mad r9.w, r0.y, c16.x, c16.y
mul r0.x, r0, r0
mul r0.y, r0.x, r9.w
mul r0.y, r0, r9.w
mul r7.w, r9, r9
mul r0.w, r0.x, r7
rcp r0.z, r0.y
add r0.y, -r0.x, c12.z
mul r3.w, r0.y, r0.z
mul r6.w, r0.x, r0
pow r0, c12.x, -r3.w
mul r0.y, r6.w, c15.w
rcp r0.y, r0.y
mul r3.w, r0.x, r0.y
add r8.w, -r1, c12.z
pow r0, r8.w, c16.z
dp3 r0.y, r4, r6
mul r6.w, r8.y, r8.y
mad r0.z, r8.x, r8.x, r6.w
mov_pp r6.z, c4.x
max r6.x, r0.y, c10
mad r0.z, r8, r8, r0
rsq r0.y, r0.z
add r0.z, -r2.w, -r5.w
rcp r0.y, r0.y
add_pp r8.w, c12.z, -r6.z
mul r0.y, r0, c2.x
add r0.z, r0, c8.x
mul r0.z, r0.y, r0
mul r0.y, r6.x, r6.x
mul r0.y, r0, r0.z
mov r6.w, r0.x
mul r0.y, r0, r0.z
mul r6.y, r0, c9
pow r0, c12.x, -r6.y
mad r11.x, -r0, c12.y, c12.z
mul r10.w, r6.x, r11.x
mul r0.y, r3, r3
mad r0.x, r3, r3, r0.y
mad r0.x, r3.z, r3.z, r0
mad r8.x, r6.w, c4, r8.w
add_sat r6.x, -r10.w, c12.z
rsq r6.y, r0.x
pow r0, r6.x, c12.w
rcp r0.y, r6.y
add r0.zw, r3.xyxy, -v1.xyxy
mul r0.y, r4.w, r0
mul r0.zw, r2.w, r0
mul r0.zw, r0, r0.y
mad r6.xy, -r0.zwzw, c13.x, v0
mov r0.y, r0.x
texld r6, r6, s4
dp3 r0.w, r3, v1
mul r0.y, r0, r6.w
texldp r0.x, v3, s3
mul r0.z, r0.y, r0.x
mul r0.y, r3.w, r8.x
mul_sat r0.z, r0, c13.y
mul_pp r3.xyz, r6, c0
mul_sat r0.w, r0, c7.x
mul r3.xyz, r0.w, r3
add r0.w, -r0, c12.z
mad r8.xyz, r0.w, c0, r3
mul r3.xyz, r0.z, r6
mul r6.xyz, r3, c6
texld r3, v0, s0
add r0.z, -r0, c12
mad r6.xyz, r0.z, r8, r6
add r8.xyz, v1, -r10
dp3_pp r0.z, r4, r7
mul_pp r3.xyz, r3, c3
dp3 r0.w, r8, r8
rsq r0.w, r0.w
mul r9.xyz, r0.w, r8
rcp r6.w, r0.z
mul r0.y, r3.w, r0
mul_sat r11.y, r0, r6.w
mul r0.y, r1.w, r0.z
dp3_pp r0.z, r1, r7
rcp r0.w, r0.z
mul r0.y, r0, r0.w
add r1.xyz, r7, r9
mul r0.z, r0.y, c8.x
dp3 r2.x, r1, r1
rsq r2.x, r2.x
mul r1.xyz, r2.x, r1
dp3 r10.z, r4, r1
abs r1.x, r10.z
dp3_pp r0.y, r4, v1
mul r2.x, r1.w, r0.y
mul r0.w, r0, r2.x
add r1.z, -r1.x, c12
mad r1.y, r1.x, c14.x, c14
mad r1.y, r1, r1.x, c14.z
mad r1.x, r1.y, r1, c14.w
mul r0.w, r0, c8.x
rsq r1.z, r1.z
rcp r1.z, r1.z
mul r1.x, r1, r1.z
cmp r1.y, r10.z, c13.z, c13.w
mul r1.z, r1.y, r1.x
min_sat r0.w, r0.z, r0
mad r0.z, -r1, c8.x, r1.x
mad r1.y, r1, c15.x, r0.z
mov_pp r0.z, c4.x
mad r1.y, r1, c15, c15.z
mul_pp r0.z, c16.w, r0
max r1.x, r1.w, c10
pow r2, r1.x, r0.z
frc r1.y, r1
mad r2.y, r1, c9.z, c9.w
sincos r1.xy, r2.y
mov r1.y, r2.x
mul r2.w, r1.x, r1.x
mul r1.y, r3.w, r1
mul r1.x, r1.y, c9.y
mul r1.y, r9.w, r2.w
mul r1.y, r9.w, r1
mad r1.x, r11.y, r0.w, r1
mul_sat r9.w, r11.x, r1.x
mov_pp r2.xyz, c0
mul_pp r2.xyz, c1, r2
mul r7.w, r7, r2
add r1.x, -r2.w, c12.z
rcp r1.y, r1.y
mul r11.x, r1, r1.y
pow r1, c12.x, -r11.x
mul r11.xyz, r2, r9.w
mul_pp r6.xyz, r3, r6
mad r6.xyz, r6, r10.w, r11
mov r9.w, r1.x
add r10.w, -r10.z, c12.z
pow r1, r10.w, c16.z
mul r1.y, r2.w, r7.w
mul_pp r2.w, r0.x, c8.x
mov r1.z, r1.x
mul r1.y, r1, c15.w
rcp r1.x, r1.y
mad r1.y, r1.z, c4.x, r8.w
mul r1.x, r9.w, r1
mul r1.x, r1, r1.y
mul r1.x, r3.w, r1
mul_sat r6.w, r6, r1.x
max r7.w, r10.z, c10.x
pow r1, r7.w, r0.z
mul r5.y, r5, r5
mad r1.y, r5.x, r5.x, r5
mad r1.z, r5, r5, r1.y
dp3 r1.y, r4, r9
max r5.x, r1.y, c10
rsq r1.z, r1.z
rcp r1.y, r1.z
mov r1.w, r1.x
add r1.z, -r5.w, c12
mul r1.y, r1, c2.x
mul r1.z, r1.y, r1
mul r1.y, r5.x, r5.x
mul r1.y, r1, r1.z
mul r1.x, r1.y, r1.z
mul r1.y, r3.w, r1.w
mul r5.y, r1.x, c9
mul r5.z, r1.y, c9.y
pow r1, c12.x, -r5.y
mad r1.z, r0.w, r6.w, r5
mov r0.w, r1.x
mul r1.y, r8, r8
mad r1.x, r8, r8, r1.y
mad r0.w, -r0, c12.y, c12.z
mul_sat r1.y, r0.w, r1.z
mul r0.w, r5.x, r0
mad r1.x, r8.z, r8.z, r1
rsq r1.x, r1.x
rcp r1.x, r1.x
mul r1.z, r4.w, r1.x
mul r9.xyz, r2, r1.y
mul r1.xy, r5.w, -r10
mul r5.xy, r1, r1.z
add_sat r5.z, -r0.w, c12
pow r1, r5.z, c12.w
dp3 r1.y, v1, r8
mad r5.xy, -r5, c13.x, v0
texld r5, r5, s4
mov r1.w, r1.x
mul r1.w, r1, r5
mul r0.x, r0, r1.w
mul_sat r0.x, r0, c13.y
mul_sat r1.y, r1, c7.x
mul_pp r8.xyz, r5, c0
mul r8.xyz, r1.y, r8
add r1.y, -r1, c12.z
mad r8.xyz, r1.y, c0, r8
add_pp r1.xyz, v1, r7
dp3_pp r4.w, r1, r1
rsq_pp r1.w, r4.w
mul_pp r1.xyz, r1.w, r1
dp3_pp r1.w, r4, r1
mul r1.xyz, r0.x, r5
add r4.w, -r0.x, c12.z
mul r4.xyz, r1, c6
max_pp r0.x, r1.w, c10
pow r1, r0.x, r0.z
mov r0.x, r1
mad r4.xyz, r4.w, r8, r4
mul_pp r4.xyz, r3, r4
mad r1.xyz, r4, r0.w, r9
mul_sat r0.x, r3.w, r0
mul r4.xyz, r2, r0.x
mul_pp r2.xyz, r3, c0
max_pp r0.x, r0.y, c10
mad r0.xyz, r2, r0.x, r4
mul r2.xyz, r2.w, r0
texld r0.w, v0, s1
add_sat r0.x, r0.w, c5
mul r1.xyz, r2.w, r1
mul_pp r1.xyz, r0.x, r1
mul_pp r2.xyz, r0.x, r2
add_pp r0.x, -r0, c12.z
mul r6.xyz, r6, r2.w
mad_pp r1.xyz, r0.x, r6, r1
mad_pp oC0.xyz, r1, r0.x, r2
mov_pp oC0.w, c10.x
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Float 2 [_GVar]
Vector 3 [_Color]
Float 4 [_Shininess]
Float 5 [_BlendAdjust1]
Vector 6 [_SSSC]
Float 7 [_Smoothness]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_ScatterMap] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_ShadowMapTexture] 2D
SetTexture 4 [_LightTexture0] 2D
SetTexture 5 [_ExitColorMap] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 283 ALU, 7 TEX
PARAM c[15] = { program.local[0..7],
		{ 0, 1, 2, 0.1 },
		{ 0.73550957, -0.73550957, 0, -1 },
		{ 0.99270076, -0.99270076, 0.44999999, 2.718282 },
		{ 0.5, 0.39894229, 3.5, 0.001 },
		{ 7, 3.141593, -0.018729299, 0.074261002 },
		{ 0.21211439, 1.570729, 1.3, 0.69999999 },
		{ 3.1415927, 5, 128 } };
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
MUL R0.x, fragment.texcoord[1].y, fragment.texcoord[1].y;
MAD R0.x, fragment.texcoord[1], fragment.texcoord[1], R0;
MAD R0.x, fragment.texcoord[1].z, fragment.texcoord[1].z, R0;
RSQ R2.w, R0.x;
MUL R0.y, R2.w, -fragment.texcoord[1].z;
MUL R0.x, R0.y, c[9];
COS R0.z, R0.x;
MAD R0.y, R0, c[9], R0.z;
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
MUL R1.xy, R0.y, c[9].zwzw;
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, fragment.texcoord[1];
MAD R7.xyz, R0, c[9].x, R1.xxyw;
MUL R0.x, R7.y, R7.y;
MAD R0.x, R7, R7, R0;
MAD R0.x, R7.z, R7.z, R0;
RSQ R0.x, R0.x;
MUL R0.y, R0.x, -R7.z;
MUL R0.x, R0.y, c[10];
COS R0.z, R0.x;
MAD R0.y, R0, c[10], R0.z;
DP3 R0.x, R7, R7;
RSQ R0.x, R0.x;
MUL R4.xyz, R0.x, R7;
ADD R7.xyz, -R7, fragment.texcoord[1];
MUL R0.zw, R0.y, c[9];
MAD R3.xyz, R4, c[10].x, R0.zzww;
DP3 R0.x, R3, R3;
MOV R0.w, c[10].z;
MUL R4.w, R0, c[7].x;
MOV R0.w, c[8];
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, R3;
MUL R7.y, R7, R7;
MAD R7.y, R7.x, R7.x, R7;
ADD R3.xyz, -R3, fragment.texcoord[1];
MAD R1.xyz, R4, -R4.w, fragment.texcoord[1];
MUL R1.w, R0, c[7].x;
MAD R2.xyz, -R1.w, R0, R1;
MUL R1.z, R3.y, R3.y;
TEX R0.yw, fragment.texcoord[0].zwzw, texture[2], 2D;
MAD R1.xy, R0.wyzw, c[8].z, -c[8].y;
MAD R3.x, R3, R3, R1.z;
ADD R3.y, -R1.w, -R4.w;
MUL R0.x, R2.y, R2.y;
MAD R0.x, R2, R2, R0;
MAD R3.w, R2.z, R2.z, R0.x;
DP3 R0.x, R2, R2;
MUL R0.w, R1.y, R1.y;
MAD R0.w, -R1.x, R1.x, -R0;
MAD R3.x, R3.z, R3.z, R3;
DP3 R5.x, R2, fragment.texcoord[1];
RSQ R0.x, R0.x;
ADD R0.w, R0, c[8].y;
RSQ R0.w, R0.w;
RSQ R3.x, R3.x;
RCP R3.x, R3.x;
RSQ R3.w, R3.w;
RCP R3.w, R3.w;
RCP R1.z, R0.w;
MUL R0.xyz, R0.x, R2;
DP3 R0.w, R1, R0;
MUL R9.xyz, R4, R4.w;
MAX R0.w, R0, c[8].x;
MUL R3.w, R2, R3;
MUL R3.x, R3, c[2];
ADD R3.y, R3, c[8].z;
MUL R3.y, R3.x, R3;
MUL R3.x, R0.w, R0.w;
MUL R3.x, R3, R3.y;
MUL R3.z, R3.x, R3.y;
ADD R3.xy, R2, -fragment.texcoord[1];
MUL R3.xy, R1.w, R3;
MUL R3.xy, R3, R3.w;
MUL R1.w, R3.z, c[11].x;
MAD R3.xy, -R3, c[11].w, fragment.texcoord[0];
TEX R3, R3, texture[5], 2D;
POW R1.w, c[10].w, -R1.w;
MUL R1.w, -R1, c[11].y;
ADD R8.x, R1.w, c[8].y;
MUL R7.w, R0, R8.x;
ADD_SAT R0.w, -R7, c[8].y;
DP3 R1.w, fragment.texcoord[2], fragment.texcoord[2];
MUL R2.xyz, R3, c[0];
MUL_SAT R5.x, R5, c[7];
MUL R2.xyz, R5.x, R2;
ADD R5.x, -R5, c[8].y;
MAD R5.xyz, R5.x, c[0], R2;
RSQ R1.w, R1.w;
MUL R2.xyz, R1.w, fragment.texcoord[2];
ADD R6.xyz, R0, R2;
POW R0.w, R0.w, c[11].z;
MUL R0.y, R0.w, R3.w;
DP3 R0.z, R6, R6;
TXP R0.x, fragment.texcoord[4], texture[3], 2D;
TEX R0.w, fragment.texcoord[3], texture[4], 2D;
MUL R1.w, R0, R0.x;
MUL R0.w, R0.y, R1;
MUL_SAT R0.w, R0, c[12].x;
MUL R3.xyz, R0.w, R3;
RSQ R0.x, R0.z;
MUL R0.xyz, R0.x, R6;
DP3 R6.w, R1, R0;
DP3 R0.y, R0, R2;
ABS R3.w, R6;
MUL R3.xyz, R3, c[6];
ADD R0.w, -R0, c[8].y;
MAD R5.xyz, R0.w, R5, R3;
ADD R3.x, -R3.w, c[8].y;
MAD R0.w, R3, c[12].z, c[12];
MAD R0.w, R0, R3, -c[13].x;
RSQ R3.x, R3.x;
MAD R0.w, R0, R3, c[13].y;
RCP R3.x, R3.x;
MUL R5.w, R0, R3.x;
TEX R3, fragment.texcoord[0], texture[0], 2D;
SLT R0.w, R6, c[8].x;
MUL R6.x, R0.w, R5.w;
MAD R5.w, -R6.x, c[8].z, R5;
MUL R3.xyz, R3, c[3];
MAD R0.w, R0, c[12].y, R5;
MOV R6.x, c[7];
MAD R10.x, R6, c[13].z, c[13].w;
COS R0.w, R0.w;
MUL R0.w, R0, R0;
MUL R8.w, R10.x, R10.x;
MUL R5.w, R0, R10.x;
MUL R5.w, R5, R10.x;
MUL R6.x, R0.w, R8.w;
MUL R6.x, R0.w, R6;
RCP R8.z, R0.y;
MUL R6.x, R6, c[14];
RCP R5.w, R5.w;
ADD R0.w, -R0, c[8].y;
MUL R0.w, R0, R5;
RCP R5.w, R6.x;
MOV R6.x, c[8].y;
ADD R9.w, R6.x, -c[4].x;
DP3 R6.x, R1, R2;
MUL R0.x, R6.w, R6;
POW R0.w, c[10].w, -R0.w;
MUL R0.w, R0, R5;
ADD R5.w, -R6, c[8].y;
POW R5.w, R5.w, c[14].y;
MAD R5.w, R5, c[4].x, R9;
MUL R5.w, R0, R5;
RCP R0.w, R6.x;
MUL R5.w, R3, R5;
MUL_SAT R8.y, R5.w, R0.w;
DP3 R5.w, R1, fragment.texcoord[1];
ADD R6.xyz, fragment.texcoord[1], -R9;
MUL R0.x, R0, R8.z;
MUL R4.x, R6.w, R5.w;
MUL R8.z, R8, R4.x;
MUL R9.z, R0.x, c[8];
DP3 R0.x, R6, R6;
MUL R8.z, R8, c[8];
MIN_SAT R9.z, R9, R8;
MAX R8.z, R6.w, c[8].x;
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, R6;
ADD R4.xyz, R2, R0;
DP3 R0.x, R1, R0;
DP3 R10.y, R4, R4;
RSQ R10.y, R10.y;
MUL R4.xyz, R10.y, R4;
DP3 R10.y, R1, R4;
ABS R4.y, R10;
MAD R4.z, R4.y, c[12], c[12].w;
MAD R7.y, R7.z, R7.z, R7;
MOV R6.w, c[14].z;
MUL R6.w, R6, c[4].x;
POW R4.x, R8.z, R6.w;
ADD R8.z, -R4.y, c[8].y;
MAD R4.z, R4, R4.y, -c[13].x;
RSQ R8.z, R8.z;
MUL R4.x, R3.w, R4;
MUL R4.x, R4, c[11];
MAD R4.x, R8.y, R9.z, R4;
MAX R0.z, R0.x, c[8].x;
RSQ R0.y, R7.y;
RCP R0.x, R0.y;
MAD R4.y, R4.z, R4, c[13];
RCP R8.z, R8.z;
MUL R4.z, R4.y, R8;
SLT R4.y, R10, c[8].x;
MUL R8.z, R4.y, R4;
MAD R4.z, -R8, c[8], R4;
MAD R4.y, R4, c[12], R4.z;
COS R4.y, R4.y;
MUL R10.z, R4.y, R4.y;
MUL_SAT R8.x, R8, R4;
MOV R4.xyz, c[1];
MUL R4.xyz, R4, c[0];
MUL R10.w, R10.x, R10.z;
MUL R8.xyz, R4, R8.x;
MUL R5.xyz, R3, R5;
MAD R5.xyz, R5, R7.w, R8;
MUL R10.x, R10, R10.w;
ADD R8.y, -R10, c[8];
POW R8.y, R8.y, c[14].y;
RCP R8.x, R10.x;
ADD R7.w, -R10.z, c[8].y;
MUL R7.w, R7, R8.x;
MUL R8.x, R8.w, R10.z;
MUL R8.x, R10.z, R8;
MUL R8.x, R8, c[14];
RCP R8.x, R8.x;
POW R7.w, c[10].w, -R7.w;
MUL R7.w, R7, R8.x;
MAD R8.y, R8, c[4].x, R9.w;
MUL R8.x, R7.w, R8.y;
MUL R7.w, R1, c[8].z;
MUL R8.x, R3.w, R8;
MUL_SAT R0.w, R0, R8.x;
MAX R8.x, R10.y, c[8];
POW R8.x, R8.x, R6.w;
MUL R8.x, R3.w, R8;
MUL R7.x, R8, c[11];
ADD R0.y, -R4.w, c[8];
MUL R0.x, R0, c[2];
MUL R0.y, R0.x, R0;
MUL R0.x, R0.z, R0.z;
MUL R0.x, R0, R0.y;
MUL R0.x, R0, R0.y;
MUL R0.y, R6, R6;
MAD R0.y, R6.x, R6.x, R0;
MAD R0.y, R6.z, R6.z, R0;
MUL R0.x, R0, c[11];
POW R0.x, c[10].w, -R0.x;
MAD R7.x, R9.z, R0.w, R7;
MUL R0.x, -R0, c[11].y;
ADD R0.w, R0.x, c[8].y;
RSQ R0.y, R0.y;
MUL_SAT R7.x, R0.w, R7;
RCP R0.x, R0.y;
MUL R2.w, R2, R0.x;
MUL R0.xy, R4.w, -R9;
MUL R0.xy, R0, R2.w;
MUL R2.w, R0.z, R0;
MAD R0.xy, -R0, c[11].w, fragment.texcoord[0];
ADD_SAT R4.w, -R2, c[8].y;
TEX R0, R0, texture[5], 2D;
POW R4.w, R4.w, c[11].z;
MUL R0.w, R4, R0;
DP3 R4.w, fragment.texcoord[1], R6;
MUL R0.w, R1, R0;
MUL_SAT R0.w, R0, c[12].x;
MUL R6.xyz, R0, c[0];
MUL_SAT R4.w, R4, c[7].x;
MUL R6.xyz, R4.w, R6;
ADD R4.w, -R4, c[8].y;
MUL R0.xyz, R0.w, R0;
MAD R6.xyz, R4.w, c[0], R6;
ADD R2.xyz, fragment.texcoord[1], R2;
DP3 R4.w, R2, R2;
RSQ R4.w, R4.w;
ADD R1.w, -R0, c[8].y;
MUL R2.xyz, R4.w, R2;
DP3 R0.w, R1, R2;
MUL R0.xyz, R0, c[6];
MAD R0.xyz, R1.w, R6, R0;
MAX R0.w, R0, c[8].x;
POW R0.w, R0.w, R6.w;
MUL_SAT R0.w, R3, R0;
MUL R1.xyz, R4, R0.w;
MUL R2.xyz, R3, c[0];
MAX R0.w, R5, c[8].x;
MAD R1.xyz, R2, R0.w, R1;
TEX R0.w, fragment.texcoord[0], texture[1], 2D;
ADD_SAT R0.w, R0, c[5].x;
MUL R2.xyz, R7.w, R1;
MUL R5.xyz, R5, R7.w;
MUL R7.xyz, R4, R7.x;
MUL R0.xyz, R3, R0;
MAD R0.xyz, R0, R2.w, R7;
MUL R0.xyz, R7.w, R0;
MUL R1.xyz, R0.w, R0;
ADD R0.x, -R0.w, c[8].y;
MUL R2.xyz, R0.w, R2;
MAD R1.xyz, R0.x, R5, R1;
MAD result.color.xyz, R1, R0.x, R2;
MOV result.color.w, c[8].x;
END
# 283 instructions, 11 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Float 2 [_GVar]
Vector 3 [_Color]
Float 4 [_Shininess]
Float 5 [_BlendAdjust1]
Vector 6 [_SSSC]
Float 7 [_Smoothness]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_ScatterMap] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_ShadowMapTexture] 2D
SetTexture 4 [_LightTexture0] 2D
SetTexture 5 [_ExitColorMap] 2D
"ps_3_0
; 342 ALU, 7 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
def c8, 2.00000000, -1.00000000, 0.10000000, -0.73550957
def c9, 0.11705996, 0.50000000, 6.28318501, -3.14159298
def c10, 0.00000000, -1.00000000, 0.73550957, -0.99270076
def c11, 0.15799320, 0.50000000, 0.99270076, 0.44999999
def c12, 2.71828198, 0.39894229, 1.00000000, 3.50000000
def c13, 0.00100000, 7.00000000, 0.00000000, 1.00000000
def c14, -0.01872930, 0.07426100, -0.21211439, 1.57072902
def c15, 3.14159298, 0.15915491, 0.50000000, 3.14159274
def c16, 1.29999995, 0.69999999, 5.00000000, 128.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xy
dcl_texcoord4 v4
mul r0.x, v1.y, v1.y
mad r0.x, v1, v1, r0
mad r0.x, v1.z, v1.z, r0
rsq r1.w, r0.x
mul r1.x, r1.w, -v1.z
mad r0.x, r1, c9, c9.y
frc r0.x, r0
mad r1.y, r0.x, c9.z, c9.w
sincos r0.xy, r1.y
mad r0.z, r1.x, c8.w, r0.x
dp3 r0.y, v1, v1
mul r1.xy, r0.z, c10
rsq r0.x, r0.y
mul r0.xyz, r0.x, v1
mad r2.xyz, r0, c10.z, r1.xxyw
mul r0.x, r2.y, r2.y
mad r0.x, r2, r2, r0
mad r0.x, r2.z, r2.z, r0
rsq r0.x, r0.x
mul r1.x, r0, -r2.z
mad r0.x, r1, c11, c11.y
frc r0.x, r0
mad r1.y, r0.x, c9.z, c9.w
sincos r0.xy, r1.y
mad r0.z, r1.x, c10.w, r0.x
dp3 r0.y, r2, r2
rsq r0.x, r0.y
mul r7.xyz, r0.x, r2
add r2.xyz, -r2, v1
mul r0.zw, r0.z, c10.xyxy
mad r8.xyz, r7, c11.z, r0.zzww
dp3 r0.x, r8, r8
mov r0.w, c7.x
mul r2.w, c11, r0
mov r0.w, c7.x
rsq r0.x, r0.x
mul r0.xyz, r0.x, r8
add r8.xyz, -r8, v1
mad r1.xyz, r7, -r2.w, v1
mul r3.w, c8.z, r0
mad r5.xyz, -r3.w, r0, r1
dp3 r0.x, r5, r5
mul r9.xyz, r7, r2.w
texld r0.yw, v0.zwzw, s2
mad_pp r1.xy, r0.wyzw, c8.x, c8.y
rsq r0.x, r0.x
mul r6.xyz, r0.x, r5
mul_pp r0.w, r1.y, r1.y
mad_pp r0.w, -r1.x, r1.x, -r0
dp3_pp r0.x, v2, v2
rsq_pp r0.x, r0.x
mul_pp r3.xyz, r0.x, v2
add r0.xyz, r6, r3
dp3 r1.z, r0, r0
rsq r1.z, r1.z
add_pp r0.w, r0, c12.z
mul r4.xyz, r1.z, r0
rsq_pp r0.w, r0.w
rcp_pp r1.z, r0.w
dp3 r4.w, r1, r4
abs r0.x, r4.w
add r0.z, -r0.x, c12
mad r0.y, r0.x, c14.x, c14
mad r0.y, r0, r0.x, c14.z
rsq r0.z, r0.z
add r7.xyz, v1, -r9
mad r0.x, r0.y, r0, c14.w
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r0.x, r4.w, c13.z, c13.w
mul r0.z, r0.x, r0.y
mad r0.y, -r0.z, c8.x, r0
mad r0.x, r0, c15, r0.y
mad r0.x, r0, c15.y, c15.z
frc r0.x, r0
mad r5.w, r0.x, c9.z, c9
sincos r0.xy, r5.w
mov r0.y, c7.x
mad r9.w, r0.y, c16.x, c16.y
mul r0.x, r0, r0
mul r0.y, r0.x, r9.w
mul r0.y, r0, r9.w
mul r7.w, r9, r9
mul r0.w, r0.x, r7
rcp r0.z, r0.y
add r0.y, -r0.x, c12.z
mul r5.w, r0.y, r0.z
mul r6.w, r0.x, r0
pow r0, c12.x, -r5.w
mul r0.y, r6.w, c15.w
rcp r0.y, r0.y
mul r5.w, r0.x, r0.y
add r8.w, -r4, c12.z
pow r0, r8.w, c16.z
dp3 r0.y, r1, r6
mul r6.w, r8.y, r8.y
mad r0.z, r8.x, r8.x, r6.w
mov_pp r6.z, c4.x
max r6.x, r0.y, c10
mad r0.z, r8, r8, r0
rsq r0.y, r0.z
add r0.z, -r3.w, -r2.w
rcp r0.y, r0.y
add_pp r8.w, c12.z, -r6.z
mul r0.y, r0, c2.x
add r0.z, r0, c8.x
mul r0.z, r0.y, r0
mul r0.y, r6.x, r6.x
mul r0.y, r0, r0.z
mov r6.w, r0.x
mul r0.y, r0, r0.z
mul r6.y, r0, c9
pow r0, c12.x, -r6.y
mad r10.x, -r0, c12.y, c12.z
mul r10.w, r6.x, r10.x
mul r0.y, r5, r5
mad r0.x, r5, r5, r0.y
mad r0.x, r5.z, r5.z, r0
mad r8.x, r6.w, c4, r8.w
rsq r6.y, r0.x
add_sat r6.x, -r10.w, c12.z
pow r0, r6.x, c12.w
add r0.zw, r5.xyxy, -v1.xyxy
dp3 r5.x, r5, v1
rcp r0.y, r6.y
mul r0.y, r1.w, r0
mul r0.zw, r3.w, r0
mul r0.zw, r0, r0.y
mad r6.xy, -r0.zwzw, c13.x, v0
mov r0.y, r0.x
texld r6, r6, s5
texldp r0.x, v4, s3
texld r0.w, v3, s4
mul r3.w, r0, r0.x
mul r0.x, r0.y, r6.w
mul r0.w, r5, r8.x
mul r0.x, r0, r3.w
mul_sat r5.w, r0.x, c13.y
add r6.w, -r5, c12.z
mul_pp r0.xyz, r6, c0
mul_sat r5.x, r5, c7
mul r0.xyz, r5.x, r0
add r5.x, -r5, c12.z
mad r0.xyz, r5.x, c0, r0
mul r5.xyz, r5.w, r6
mul r6.xyz, r5, c6
mad r0.xyz, r6.w, r0, r6
texld r5, v0, s0
mul_pp r5.xyz, r5, c3
mul_pp r6.xyz, r5, r0
dp3_pp r0.y, r1, r3
mul r0.x, r5.w, r0.w
rcp r11.y, r0.y
mul_sat r10.y, r0.x, r11
dp3_pp r6.w, r1, v1
dp3 r0.x, r7, r7
mul r0.w, r4, r0.y
rsq r0.y, r0.x
dp3_pp r0.x, r4, r3
rcp r4.x, r0.x
mul r8.xyz, r0.y, r7
add r0.xyz, r3, r8
mul r0.w, r0, r4.x
dp3 r4.y, r0, r0
rsq r4.y, r4.y
mul r0.xyz, r4.y, r0
dp3 r11.z, r1, r0
abs r0.y, r11.z
mul r4.y, r4.w, r6.w
mul r0.x, r4, r4.y
add r4.x, -r0.y, c12.z
mad r0.z, r0.y, c14.x, c14.y
mad r0.z, r0, r0.y, c14
rsq r4.x, r4.x
mad r0.y, r0.z, r0, c14.w
rcp r4.x, r4.x
mul r0.z, r0.y, r4.x
cmp r0.y, r11.z, c13.z, c13.w
mul r4.x, r0.y, r0.z
mad r0.z, -r4.x, c8.x, r0
mad r0.z, r0.y, c15.x, r0
mov_pp r0.y, c4.x
mul_pp r9.z, c16.w, r0.y
mad r0.z, r0, c15.y, c15
mul r0.w, r0, c8.x
mul r0.x, r0, c8
min_sat r11.x, r0.w, r0
max r0.x, r4.w, c10
pow r4, r0.x, r9.z
frc r0.y, r0.z
mad r4.y, r0, c9.z, c9.w
sincos r0.xy, r4.y
mov r0.y, r4.x
mul r4.w, r0.x, r0.x
mul r0.y, r5.w, r0
mul r0.x, r0.y, c9.y
mul r0.y, r9.w, r4.w
mul r0.y, r9.w, r0
mad r0.x, r10.y, r11, r0
mul_sat r9.w, r10.x, r0.x
mov_pp r4.xyz, c0
mul r7.w, r7, r4
add r0.x, -r4.w, c12.z
rcp r0.y, r0.y
mul r10.x, r0, r0.y
pow r0, c12.x, -r10.x
mul_pp r4.xyz, c1, r4
mul r10.xyz, r4, r9.w
mad r6.xyz, r6, r10.w, r10
mov r9.w, r0.x
add r10.x, -r11.z, c12.z
pow r0, r10.x, c16.z
mul r0.y, r4.w, r7.w
mul_pp r4.w, r3, c8.x
mov r0.z, r0.x
mul r0.y, r0, c15.w
rcp r0.x, r0.y
mad r0.y, r0.z, c4.x, r8.w
mul r0.x, r9.w, r0
mul r0.x, r0, r0.y
mul r0.x, r5.w, r0
mul_sat r7.w, r11.y, r0.x
max r8.w, r11.z, c10.x
pow r0, r8.w, r9.z
mul r2.y, r2, r2
mad r0.y, r2.x, r2.x, r2
mad r0.z, r2, r2, r0.y
dp3 r0.y, r1, r8
max r2.x, r0.y, c10
rsq r0.z, r0.z
rcp r0.y, r0.z
mov r0.w, r0.x
add r0.z, -r2.w, c12
mul r0.y, r0, c2.x
mul r0.z, r0.y, r0
mul r0.y, r2.x, r2.x
mul r0.y, r0, r0.z
mul r0.x, r0.y, r0.z
mul r0.y, r5.w, r0.w
mul r2.y, r0.x, c9
mul r2.z, r0.y, c9.y
pow r0, c12.x, -r2.y
mad r0.z, r11.x, r7.w, r2
mad r0.x, -r0, c12.y, c12.z
mul r7.w, r2.x, r0.x
mul_sat r0.z, r0.x, r0
mul r0.y, r7, r7
mad r0.y, r7.x, r7.x, r0
mad r0.y, r7.z, r7.z, r0
rsq r0.y, r0.y
mul r8.xyz, r4, r0.z
rcp r0.x, r0.y
mul r0.z, r1.w, r0.x
mul r0.xy, r2.w, -r9
mul r2.xy, r0, r0.z
add_sat r2.z, -r7.w, c12
pow r0, r2.z, c12.w
dp3 r0.y, v1, r7
mad r2.xy, -r2, c13.x, v0
texld r2, r2, s5
mov r0.w, r0.x
mul r0.w, r0, r2
mul r0.w, r3, r0
mul_pp r7.xyz, r2, c0
mul_sat r0.y, r0, c7.x
mul r7.xyz, r0.y, r7
add r0.y, -r0, c12.z
mad r7.xyz, r0.y, c0, r7
add_pp r0.xyz, v1, r3
dp3_pp r1.w, r0, r0
rsq_pp r1.w, r1.w
mul_pp r0.xyz, r1.w, r0
mul_sat r0.w, r0, c13.y
dp3_pp r1.x, r1, r0
mul r0.xyz, r0.w, r2
max_pp r2.x, r1, c10
add r1.w, -r0, c12.z
mul r1.xyz, r0, c6
pow r0, r2.x, r9.z
mov r0.w, r0.x
mul_sat r0.w, r5, r0
mul r2.xyz, r4, r0.w
mad r1.xyz, r1.w, r7, r1
mul_pp r1.xyz, r5, r1
mad r0.xyz, r1, r7.w, r8
mul r0.xyz, r4.w, r0
max_pp r0.w, r6, c10.x
mul_pp r1.xyz, r5, c0
mad r1.xyz, r1, r0.w, r2
texld r0.w, v0, s1
add_sat r0.w, r0, c5.x
mul r2.xyz, r4.w, r1
mul_pp r1.xyz, r0.w, r0
add_pp r0.x, -r0.w, c12.z
mul r6.xyz, r6, r4.w
mul_pp r2.xyz, r0.w, r2
mad_pp r1.xyz, r0.x, r6, r1
mad_pp oC0.xyz, r1, r0.x, r2
mov_pp oC0.w, c10.x
"
}
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_CUBE" }
Vector 0 [_LightPositionRange]
Vector 1 [_LightColor0]
Vector 2 [_SpecColor]
Vector 3 [_LightShadowData]
Float 4 [_GVar]
Vector 5 [_Color]
Float 6 [_Shininess]
Float 7 [_BlendAdjust1]
Vector 8 [_SSSC]
Float 9 [_Smoothness]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_ScatterMap] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_ShadowMapTexture] CUBE
SetTexture 4 [_LightTexture0] 2D
SetTexture 5 [_ExitColorMap] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 297 ALU, 7 TEX
PARAM c[18] = { program.local[0..9],
		{ 0, 1, 2, 0.1 },
		{ 0.73550957, -0.73550957, 0, -1 },
		{ 0.99270076, -0.99270076, 0.44999999, 2.718282 },
		{ 0.5, 0.39894229, 3.5, 0.001 },
		{ 0.97000003, 7, 3.141593, -0.018729299 },
		{ 1, 0.0039215689, 1.53787e-005, 6.2273724e-009 },
		{ 0.074261002, 0.21211439, 1.570729, 1.3 },
		{ 0.69999999, 3.1415927, 5, 128 } };
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
TEMP R11;
MOV R1.w, c[12].z;
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.x, R0.x;
MUL R3.xyz, R0.x, fragment.texcoord[1];
MUL R0.x, R3.y, R3.y;
MAD R0.x, R3, R3, R0;
MAD R0.x, R3.z, R3.z, R0;
RSQ R2.w, R0.x;
MUL R0.y, R2.w, -R3.z;
MUL R0.x, R0.y, c[11];
COS R0.z, R0.x;
DP3 R0.x, R3, R3;
MAD R0.y, R0, c[11], R0.z;
MUL R3.w, R1, c[9].x;
MUL R1.xy, R0.y, c[11].zwzw;
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, R3;
MAD R0.xyz, R0, c[11].x, R1.xxyw;
MUL R0.w, R0.y, R0.y;
MAD R0.w, R0.x, R0.x, R0;
MAD R0.w, R0.z, R0.z, R0;
RSQ R0.w, R0.w;
MUL R1.x, R0.w, -R0.z;
MUL R0.w, R1.x, c[12].x;
COS R1.y, R0.w;
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R5.xyz, R0.w, R0;
ADD R0.xyz, -R0, R3;
MUL R0.y, R0, R0;
MAD R0.x, R0, R0, R0.y;
MAD R0.y, R0.z, R0.z, R0.x;
MAD R1.x, R1, c[12].y, R1.y;
MUL R1.xy, R1.x, c[11].zwzw;
MAD R1.xyz, R5, c[12].x, R1.xxyw;
DP3 R0.w, R1, R1;
RSQ R0.w, R0.w;
MUL R2.xyz, R0.w, R1;
MOV R8.xy, c[10].ywzw;
MUL R0.w, R8.y, c[9].x;
MAD R4.xyz, R5, -R3.w, R3;
MAD R4.xyz, -R0.w, R2, R4;
TEX R6.yw, fragment.texcoord[0].zwzw, texture[2], 2D;
DP3 R1.w, R4, R4;
RSQ R2.z, R1.w;
MAD R2.xy, R6.wyzw, c[10].z, -c[10].y;
DP3 R4.w, R4, R3;
MUL R1.w, R2.y, R2.y;
MAD R1.w, -R2.x, R2.x, -R1;
ADD R1.xyz, -R1, R3;
MUL R7.xyz, R2.z, R4;
MUL R10.xyz, R5, R3.w;
MUL R2.z, R1.y, R1.y;
ADD R1.w, R1, c[10].y;
RSQ R1.y, R1.w;
MAD R1.w, R1.x, R1.x, R2.z;
RCP R2.z, R1.y;
DP3 R1.x, R2, R7;
MAD R1.y, R1.z, R1.z, R1.w;
MAX R1.z, R1.x, c[10].x;
RSQ R1.x, R1.y;
ADD R1.y, -R0.w, -R3.w;
RCP R1.x, R1.x;
MUL R1.x, R1, c[4];
ADD R1.y, R1, c[10].z;
MUL R1.y, R1.x, R1;
MUL R1.x, R1.z, R1.z;
MUL R1.x, R1, R1.y;
MUL R1.x, R1, R1.y;
MUL R1.y, R4, R4;
MAD R1.y, R4.x, R4.x, R1;
MAD R1.y, R4.z, R4.z, R1;
RSQ R1.y, R1.y;
RCP R1.w, R1.y;
MUL R1.x, R1, c[13];
POW R1.x, c[12].w, -R1.x;
MUL R1.x, -R1, c[13].y;
ADD R6.w, R1.x, c[10].y;
ADD R1.xy, R4, -R3;
MUL R5.w, R1.z, R6;
MUL R1.xy, R0.w, R1;
MUL R1.w, R2, R1;
MUL R1.xy, R1, R1.w;
ADD_SAT R0.w, -R5, c[10].y;
MAD R1.xy, -R1, c[13].w, fragment.texcoord[0];
TEX R1, R1, texture[5], 2D;
POW R0.w, R0.w, c[13].z;
MUL R1.w, R0, R1;
MUL R4.xyz, R1, c[1];
MUL_SAT R4.w, R4, c[9].x;
MUL R4.xyz, R4.w, R4;
ADD R4.w, -R4, c[10].y;
MAD R6.xyz, R4.w, c[1], R4;
DP3 R4.x, fragment.texcoord[4], fragment.texcoord[4];
RSQ R0.w, R4.x;
TEX R4, fragment.texcoord[4], texture[3], CUBE;
RCP R0.w, R0.w;
DP4 R4.x, R4, c[15];
MUL R0.w, R0, c[0];
MAD R0.w, -R0, c[14].x, R4.x;
CMP R4.w, R0, c[3].x, R8.x;
DP3 R4.x, fragment.texcoord[2], fragment.texcoord[2];
RSQ R4.x, R4.x;
MUL R4.xyz, R4.x, fragment.texcoord[2];
DP3 R0.w, fragment.texcoord[3], fragment.texcoord[3];
TEX R0.w, R0.w, texture[4], 2D;
MUL R4.w, R0, R4;
MUL R0.w, R1, R4;
ADD R7.xyz, R7, R4;
DP3 R1.w, R7, R7;
MUL_SAT R0.w, R0, c[14].y;
MUL R1.xyz, R0.w, R1;
RSQ R1.w, R1.w;
MUL R7.xyz, R1.w, R7;
DP3 R8.w, R2, R7;
DP3 R7.y, R7, R4;
RCP R9.y, R7.y;
MUL R1.xyz, R1, c[8];
ADD R0.w, -R0, c[10].y;
MAD R6.xyz, R0.w, R6, R1;
ABS R0.w, R8;
TEX R1, fragment.texcoord[0], texture[0], 2D;
MUL R1.xyz, R1, c[5];
MUL R7.w, R0, c[14];
ADD R8.x, -R0.w, c[10].y;
ADD R7.w, R7, c[16].x;
MAD R7.w, R7, R0, -c[16].y;
RSQ R8.x, R8.x;
MAD R0.w, R7, R0, c[16].z;
RCP R8.x, R8.x;
MUL R7.w, R0, R8.x;
SLT R0.w, R8, c[10].x;
MUL R8.x, R0.w, R7.w;
MAD R7.w, -R8.x, c[10].z, R7;
MAD R0.w, R0, c[14].z, R7;
MOV R8.y, c[16].w;
MUL R8.x, R8.y, c[9];
ADD R11.x, R8, c[17];
COS R0.w, R0.w;
MUL R0.w, R0, R0;
MUL R9.w, R11.x, R11.x;
MUL R7.w, R0, R11.x;
MUL R7.w, R7, R11.x;
MUL R8.x, R0.w, R9.w;
MUL R8.x, R0.w, R8;
MUL R6.xyz, R1, R6;
MUL R8.x, R8, c[17].y;
RCP R7.w, R7.w;
ADD R0.w, -R0, c[10].y;
MUL R0.w, R0, R7;
RCP R7.w, R8.x;
MOV R8.x, c[10].y;
ADD R10.w, R8.x, -c[6].x;
DP3 R8.x, R2, R4;
MUL R7.x, R8.w, R8;
MUL R5.x, R7, R9.y;
POW R0.w, c[12].w, -R0.w;
MUL R0.w, R0, R7;
ADD R7.w, -R8, c[10].y;
POW R7.w, R7.w, c[17].z;
MAD R7.w, R7, c[6].x, R10;
MUL R7.w, R0, R7;
ADD R7.xyz, R3, -R10;
MUL R9.z, R5.x, c[10];
DP3 R5.x, R7, R7;
RCP R0.w, R8.x;
RSQ R5.y, R5.x;
MUL R8.xyz, R5.y, R7;
DP3 R0.x, R2, R8;
MUL R7.w, R1, R7;
MUL_SAT R9.x, R7.w, R0.w;
DP3 R7.w, R2, R3;
MUL R5.x, R8.w, R7.w;
MUL R9.y, R9, R5.x;
ADD R5.xyz, R4, R8;
MUL R9.y, R9, c[10].z;
MIN_SAT R10.z, R9, R9.y;
DP3 R11.y, R5, R5;
RSQ R9.z, R11.y;
MUL R5.xyz, R9.z, R5;
DP3 R11.y, R2, R5;
ABS R5.y, R11;
MAX R9.y, R8.w, c[10].x;
MUL R5.z, R5.y, c[14].w;
MOV R8.w, c[17];
MUL R8.w, R8, c[6].x;
POW R5.x, R9.y, R8.w;
ADD R9.y, -R5, c[10];
ADD R5.z, R5, c[16].x;
MAD R5.z, R5, R5.y, -c[16].y;
RSQ R9.y, R9.y;
MUL R5.x, R1.w, R5;
MUL R5.x, R5, c[13];
MAD R5.x, R9, R10.z, R5;
MAX R0.z, R0.x, c[10].x;
RSQ R0.y, R0.y;
RCP R0.x, R0.y;
MAD R5.y, R5.z, R5, c[16].z;
RCP R9.y, R9.y;
MUL R5.z, R5.y, R9.y;
SLT R5.y, R11, c[10].x;
MUL R9.y, R5, R5.z;
MAD R5.z, -R9.y, c[10], R5;
MAD R5.y, R5, c[14].z, R5.z;
MUL_SAT R9.x, R6.w, R5;
COS R5.y, R5.y;
MUL R6.w, R5.y, R5.y;
MUL R11.z, R11.x, R6.w;
MOV R5.xyz, c[2];
MUL R5.xyz, R5, c[1];
MUL R9.xyz, R5, R9.x;
MAD R6.xyz, R6, R5.w, R9;
MUL R11.x, R11, R11.z;
RCP R9.x, R11.x;
ADD R5.w, -R6, c[10].y;
MUL R5.w, R5, R9.x;
MUL R9.x, R9.w, R6.w;
MUL R6.w, R6, R9.x;
ADD R9.x, -R11.y, c[10].y;
MUL R6.w, R6, c[17].y;
POW R9.x, R9.x, c[17].z;
RCP R6.w, R6.w;
POW R5.w, c[12].w, -R5.w;
MUL R5.w, R5, R6;
MAD R9.x, R9, c[6], R10.w;
MUL R6.w, R5, R9.x;
MUL R5.w, R4, c[10].z;
MUL R6.w, R1, R6;
MUL_SAT R0.w, R0, R6;
MAX R6.w, R11.y, c[10].x;
POW R6.w, R6.w, R8.w;
MUL R6.w, R1, R6;
MUL R6.w, R6, c[13].x;
ADD R0.y, -R3.w, c[10];
MUL R0.x, R0, c[4];
MUL R0.y, R0.x, R0;
MUL R0.x, R0.z, R0.z;
MUL R0.x, R0, R0.y;
MUL R0.x, R0, R0.y;
MUL R0.y, R7, R7;
MAD R0.y, R7.x, R7.x, R0;
MAD R0.y, R7.z, R7.z, R0;
MUL R0.x, R0, c[13];
POW R0.x, c[12].w, -R0.x;
MAD R6.w, R10.z, R0, R6;
MUL R0.x, -R0, c[13].y;
ADD R0.w, R0.x, c[10].y;
RSQ R0.y, R0.y;
MUL_SAT R6.w, R0, R6;
RCP R0.x, R0.y;
MUL R2.w, R2, R0.x;
MUL R0.xy, R3.w, -R10;
MUL R0.xy, R0, R2.w;
MUL R2.w, R0.z, R0;
MAD R0.xy, -R0, c[13].w, fragment.texcoord[0];
ADD_SAT R3.w, -R2, c[10].y;
TEX R0, R0, texture[5], 2D;
POW R3.w, R3.w, c[13].z;
MUL R0.w, R3, R0;
DP3 R3.w, R3, R7;
ADD R3.xyz, R3, R4;
DP3 R4.x, R3, R3;
MUL R0.w, R4, R0;
RSQ R4.x, R4.x;
MUL_SAT R0.w, R0, c[14].y;
MUL R7.xyz, R0, c[1];
MUL_SAT R3.w, R3, c[9].x;
MUL R7.xyz, R3.w, R7;
ADD R3.w, -R3, c[10].y;
MAD R7.xyz, R3.w, c[1], R7;
MUL R0.xyz, R0.w, R0;
ADD R3.w, -R0, c[10].y;
MUL R3.xyz, R4.x, R3;
DP3 R0.w, R2, R3;
MUL R0.xyz, R0, c[8];
MAD R0.xyz, R3.w, R7, R0;
MUL R0.xyz, R1, R0;
MUL R8.xyz, R5, R6.w;
MAX R0.w, R0, c[10].x;
POW R0.w, R0.w, R8.w;
MUL_SAT R0.w, R1, R0;
MUL R2.xyz, R5, R0.w;
MAD R0.xyz, R0, R2.w, R8;
MUL R0.xyz, R5.w, R0;
MAX R0.w, R7, c[10].x;
MUL R1.xyz, R1, c[1];
MAD R1.xyz, R1, R0.w, R2;
TEX R0.w, fragment.texcoord[0], texture[1], 2D;
ADD_SAT R0.w, R0, c[7].x;
MUL R2.xyz, R5.w, R1;
MUL R1.xyz, R0.w, R0;
ADD R0.x, -R0.w, c[10].y;
MUL R6.xyz, R6, R5.w;
MUL R2.xyz, R0.w, R2;
MAD R1.xyz, R0.x, R6, R1;
MAD result.color.xyz, R1, R0.x, R2;
MOV result.color.w, c[10].x;
END
# 297 instructions, 12 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_CUBE" }
Vector 0 [_LightPositionRange]
Vector 1 [_LightColor0]
Vector 2 [_SpecColor]
Vector 3 [_LightShadowData]
Float 4 [_GVar]
Vector 5 [_Color]
Float 6 [_Shininess]
Float 7 [_BlendAdjust1]
Vector 8 [_SSSC]
Float 9 [_Smoothness]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_ScatterMap] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_ShadowMapTexture] CUBE
SetTexture 4 [_LightTexture0] 2D
SetTexture 5 [_ExitColorMap] 2D
"ps_3_0
; 355 ALU, 7 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_cube s3
dcl_2d s4
dcl_2d s5
def c10, 2.00000000, -1.00000000, 0.10000000, -0.73550957
def c11, 0.11705996, 0.50000000, 6.28318501, -3.14159298
def c12, 0.00000000, -1.00000000, 0.73550957, -0.99270076
def c13, 0.15799320, 0.50000000, 0.99270076, 0.44999999
def c14, 2.71828198, 0.39894229, 1.00000000, 3.50000000
def c15, 0.00100000, 0.97000003, 7.00000000, -0.21211439
def c16, 1.00000000, 0.00392157, 0.00001538, 0.00000001
def c17, 0.00000000, 1.00000000, -0.01872930, 0.07426100
def c18, 1.57072902, 3.14159298, 0.15915491, 0.50000000
def c19, 1.29999995, 0.69999999, 3.14159274, 5.00000000
def c20, 128.00000000, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dp3_pp r0.x, v1, v1
rsq_pp r0.x, r0.x
mul_pp r2.xyz, r0.x, v1
mul r0.x, r2.y, r2.y
mad r0.x, r2, r2, r0
mad r0.x, r2.z, r2.z, r0
rsq r1.w, r0.x
mul r1.x, r1.w, -r2.z
mad r0.x, r1, c11, c11.y
frc r0.x, r0
mad r1.y, r0.x, c11.z, c11.w
sincos r0.xy, r1.y
mad r0.z, r1.x, c10.w, r0.x
dp3 r0.y, r2, r2
mul r1.xy, r0.z, c12
rsq r0.x, r0.y
mul r0.xyz, r0.x, r2
mad r3.xyz, r0, c12.z, r1.xxyw
mul r0.x, r3.y, r3.y
mad r0.x, r3, r3, r0
mad r0.x, r3.z, r3.z, r0
rsq r0.x, r0.x
mul r1.x, r0, -r3.z
mad r0.x, r1, c13, c13.y
frc r0.x, r0
mad r1.y, r0.x, c11.z, c11.w
sincos r0.xy, r1.y
mad r0.z, r1.x, c12.w, r0.x
dp3 r0.y, r3, r3
rsq r0.x, r0.y
mul r8.xyz, r0.x, r3
add r3.xyz, -r3, r2
mul r0.zw, r0.z, c12.xyxy
mad r6.xyz, r8, c13.z, r0.zzww
dp3 r0.x, r6, r6
mov r0.w, c9.x
mul r2.w, c13, r0
mov r0.w, c9.x
rsq r0.x, r0.x
mul r0.xyz, r0.x, r6
mad r1.xyz, r8, -r2.w, r2
mul r4.w, c10.z, r0
mad r7.xyz, -r4.w, r0, r1
dp3 r0.x, r7, r7
texld r0.yw, v0.zwzw, s2
mad_pp r1.xy, r0.wyzw, c10.x, c10.y
rsq r0.x, r0.x
mul r9.xyz, r0.x, r7
mul_pp r0.w, r1.y, r1.y
mad_pp r0.w, -r1.x, r1.x, -r0
dp3_pp r0.x, v2, v2
rsq_pp r0.x, r0.x
mul_pp r4.xyz, r0.x, v2
add r0.xyz, r9, r4
dp3 r1.z, r0, r0
rsq r1.z, r1.z
add_pp r0.w, r0, c14.z
mul r5.xyz, r1.z, r0
rsq_pp r0.w, r0.w
rcp_pp r1.z, r0.w
dp3 r5.w, r1, r5
abs r0.x, r5.w
add r0.z, -r0.x, c14
mad r0.y, r0.x, c17.z, c17.w
mad r0.y, r0, r0.x, c15.w
rsq r0.z, r0.z
mad r0.x, r0.y, r0, c18
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r0.x, r5.w, c17, c17.y
mul r0.z, r0.x, r0.y
mad r0.y, -r0.z, c10.x, r0
mad r0.x, r0, c18.y, r0.y
mad r0.x, r0, c18.z, c18.w
frc r0.x, r0
mad r3.w, r0.x, c11.z, c11
sincos r0.xy, r3.w
mov r0.y, c9.x
mad r8.w, r0.y, c19.x, c19.y
mul r6.w, r0.x, r0.x
mul r0.x, r6.w, r8.w
mul r0.y, r0.x, r8.w
mul r3.w, r8, r8
mul r9.w, r6, r3
add r0.x, -r6.w, c14.z
rcp r0.y, r0.y
mul r7.w, r0.x, r0.y
pow r0, c14.x, -r7.w
mul r0.y, r6.w, r9.w
mul r0.y, r0, c19.z
mov r6.w, r0.x
rcp r0.w, r0.y
add r0.xyz, -r6, r2
mul r10.x, r6.w, r0.w
mul r0.y, r0, r0
mad r0.y, r0.x, r0.x, r0
dp3 r0.x, r1, r9
max r6.x, r0, c12
mad r0.y, r0.z, r0.z, r0
rsq r0.x, r0.y
add r0.y, -r4.w, -r2.w
rcp r0.x, r0.x
add r6.w, -r5, c14.z
add r0.y, r0, c10.x
mul r0.x, r0, c4
mul r6.y, r0.x, r0
mul r0.x, r6, r6
mul r6.z, r0.x, r6.y
pow r0, r6.w, c19.w
mul r0.y, r6.z, r6
mul r6.y, r0, c11
mov r6.z, r0.x
pow r0, c14.x, -r6.y
mov_pp r0.y, c6.x
mad r10.w, -r0.x, c14.y, c14.z
mul r9.w, r6.x, r10
add_pp r7.w, c14.z, -r0.y
mul r0.x, r7.y, r7.y
mad r0.x, r7, r7, r0
mad r9.x, r6.z, c6, r7.w
mad r6.y, r7.z, r7.z, r0.x
add_sat r6.x, -r9.w, c14.z
pow r0, r6.x, c14.w
rsq r0.y, r6.y
add r0.zw, r7.xyxy, -r2.xyxy
dp3 r7.x, r7, r2
rcp r0.y, r0.y
mul r0.y, r1.w, r0
mul r0.zw, r4.w, r0
mul r0.zw, r0, r0.y
mov r9.y, r0.x
mad r0.xy, -r0.zwzw, c15.x, v0
dp3 r0.z, v4, v4
rsq r4.w, r0.z
texld r6, r0, s5
texld r0, v4, s3
dp4 r0.y, r0, c16
mul r0.w, r10.x, r9.x
mul r10.xyz, r8, r2.w
rcp r4.w, r4.w
mul r0.x, r4.w, c0.w
mad r0.y, -r0.x, c15, r0
mov r0.z, c3.x
dp3 r0.x, v3, v3
add r8.xyz, r2, -r10
cmp r0.y, r0, c14.z, r0.z
texld r0.x, r0.x, s4
mul r4.w, r0.x, r0.y
mul r0.x, r9.y, r6.w
mul r0.x, r0, r4.w
mul_sat r6.w, r0.x, c15.z
mul_pp r0.xyz, r6, c1
mul_sat r7.x, r7, c9
mul r0.xyz, r7.x, r0
add r7.x, -r7, c14.z
add r9.x, -r6.w, c14.z
mad r0.xyz, r7.x, c1, r0
mul r6.xyz, r6.w, r6
mul r7.xyz, r6, c8
texld r6, v0, s0
mad r0.xyz, r9.x, r0, r7
mul_pp r6.xyz, r6, c5
mul_pp r7.xyz, r6, r0
dp3_pp r0.y, r1, r4
mul r10.z, r5.w, r0.y
mul r0.x, r6.w, r0.w
rcp r12.y, r0.y
mul_sat r11.x, r0, r12.y
dp3 r0.x, r8, r8
rsq r0.y, r0.x
dp3_pp r0.x, r5, r4
rcp r0.w, r0.x
mul r5.x, r10.z, r0.w
mul r9.xyz, r0.y, r8
add r0.xyz, r4, r9
dp3 r5.y, r0, r0
rsq r5.y, r5.y
mul r0.xyz, r5.y, r0
dp3 r12.z, r1, r0
dp3_pp r10.z, r1, r2
abs r0.y, r12.z
mul r5.y, r5.w, r10.z
mul r0.x, r0.w, r5.y
add r0.w, -r0.y, c14.z
mad r0.z, r0.y, c17, c17.w
mad r0.z, r0, r0.y, c15.w
mad r0.y, r0.z, r0, c18.x
rsq r0.w, r0.w
rcp r0.w, r0.w
mul r0.y, r0, r0.w
cmp r0.z, r12, c17.x, c17.y
mul r0.w, r0.z, r0.y
mul r5.x, r5, c10
mul r0.x, r0, c10
min_sat r12.x, r5, r0
mad r0.x, -r0.w, c10, r0.y
mad r0.z, r0, c18.y, r0.x
mov_pp r0.x, c6
mul_pp r11.w, c20.x, r0.x
max r0.y, r5.w, c12.x
mad r0.z, r0, c18, c18.w
pow r5, r0.y, r11.w
frc r0.x, r0.z
mad r5.y, r0.x, c11.z, c11.w
sincos r0.xy, r5.y
mov r0.y, r5.x
mul r5.w, r0.x, r0.x
mul r0.y, r6.w, r0
mul r0.x, r0.y, c11.y
mul r0.y, r8.w, r5.w
mul r0.y, r8.w, r0
mad r0.x, r11, r12, r0
mul_sat r8.w, r10, r0.x
mov_pp r5.xyz, c1
mul_pp r5.xyz, c2, r5
mul r11.xyz, r5, r8.w
mad r7.xyz, r7, r9.w, r11
mul r3.w, r3, r5
add r0.x, -r5.w, c14.z
rcp r0.y, r0.y
mul r10.w, r0.x, r0.y
pow r0, c14.x, -r10.w
mov r8.w, r0.x
add r9.w, -r12.z, c14.z
pow r0, r9.w, c19.w
mul r0.y, r5.w, r3.w
mul_pp r5.w, r4, c10.x
mov r0.z, r0.x
mul r0.y, r0, c19.z
rcp r0.x, r0.y
mad r0.y, r0.z, c6.x, r7.w
mul r0.x, r8.w, r0
mul r0.x, r0, r0.y
mul r0.x, r6.w, r0
mul_sat r3.w, r12.y, r0.x
max r7.w, r12.z, c12.x
pow r0, r7.w, r11.w
mul r3.y, r3, r3
mad r0.y, r3.x, r3.x, r3
mad r0.z, r3, r3, r0.y
dp3 r0.y, r1, r9
max r3.x, r0.y, c12
rsq r0.z, r0.z
rcp r0.y, r0.z
mov r0.w, r0.x
mul r0.y, r0, c4.x
add r0.z, -r2.w, c14
mul r0.z, r0.y, r0
mul r0.y, r3.x, r3.x
mul r0.y, r0, r0.z
mul r0.x, r0.y, r0.z
mul r0.y, r6.w, r0.w
mul r3.y, r0.x, c11
mul r3.z, r0.y, c11.y
pow r0, c14.x, -r3.y
mad r0.z, r12.x, r3.w, r3
mad r0.x, -r0, c14.y, c14.z
mul r7.w, r3.x, r0.x
mul_sat r0.z, r0.x, r0
mul r0.y, r8, r8
mad r0.y, r8.x, r8.x, r0
mad r0.y, r8.z, r8.z, r0
rsq r0.y, r0.y
mul r9.xyz, r5, r0.z
rcp r0.x, r0.y
mul r0.z, r1.w, r0.x
mul r0.xy, r2.w, -r10
mul r3.xy, r0, r0.z
add_sat r3.z, -r7.w, c14
pow r0, r3.z, c14.w
dp3 r0.y, r2, r8
mad r3.xy, -r3, c15.x, v0
texld r3, r3, s5
mov r0.w, r0.x
mul r0.w, r0, r3
mul r0.w, r4, r0
mul_sat r0.w, r0, c15.z
mul_sat r0.y, r0, c9.x
mul_pp r8.xyz, r3, c1
mul r8.xyz, r0.y, r8
add r0.y, -r0, c14.z
mad r8.xyz, r0.y, c1, r8
add_pp r0.xyz, r2, r4
dp3_pp r1.w, r0, r0
rsq_pp r1.w, r1.w
mul_pp r0.xyz, r1.w, r0
dp3_pp r1.x, r1, r0
max_pp r2.x, r1, c12
mul r0.xyz, r0.w, r3
add r1.w, -r0, c14.z
mul r1.xyz, r0, c8
pow r0, r2.x, r11.w
mov r0.w, r0.x
mul_sat r0.w, r6, r0
mul r2.xyz, r5, r0.w
mad r1.xyz, r1.w, r8, r1
mul_pp r1.xyz, r6, r1
mad r0.xyz, r1, r7.w, r9
mul r0.xyz, r5.w, r0
max_pp r0.w, r10.z, c12.x
mul_pp r1.xyz, r6, c1
mad r1.xyz, r1, r0.w, r2
texld r0.w, v0, s1
add_sat r0.w, r0, c7.x
mul r2.xyz, r5.w, r1
mul_pp r1.xyz, r0.w, r0
add_pp r0.x, -r0.w, c14.z
mul r7.xyz, r7, r5.w
mul_pp r2.xyz, r0.w, r2
mad_pp r1.xyz, r0.x, r7, r1
mad_pp oC0.xyz, r1, r0.x, r2
mov_pp oC0.w, c12.x
"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Vector 0 [_LightPositionRange]
Vector 1 [_LightColor0]
Vector 2 [_SpecColor]
Vector 3 [_LightShadowData]
Float 4 [_GVar]
Vector 5 [_Color]
Float 6 [_Shininess]
Float 7 [_BlendAdjust1]
Vector 8 [_SSSC]
Float 9 [_Smoothness]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_ScatterMap] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_ShadowMapTexture] CUBE
SetTexture 4 [_LightTextureB0] 2D
SetTexture 5 [_LightTexture0] CUBE
SetTexture 6 [_ExitColorMap] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 299 ALU, 8 TEX
PARAM c[18] = { program.local[0..9],
		{ 0, 1, 2, 0.1 },
		{ 0.73550957, -0.73550957, 0, -1 },
		{ 0.99270076, -0.99270076, 0.44999999, 2.718282 },
		{ 0.5, 0.39894229, 3.5, 0.001 },
		{ 0.97000003, 7, 3.141593, -0.018729299 },
		{ 1, 0.0039215689, 1.53787e-005, 6.2273724e-009 },
		{ 0.074261002, 0.21211439, 1.570729, 1.3 },
		{ 0.69999999, 3.1415927, 5, 128 } };
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
TEMP R11;
MOV R1.w, c[12].z;
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.x, R0.x;
MUL R3.xyz, R0.x, fragment.texcoord[1];
MUL R0.x, R3.y, R3.y;
MAD R0.x, R3, R3, R0;
MAD R0.x, R3.z, R3.z, R0;
RSQ R2.w, R0.x;
MUL R0.y, R2.w, -R3.z;
MUL R0.x, R0.y, c[11];
COS R0.z, R0.x;
DP3 R0.x, R3, R3;
MAD R0.y, R0, c[11], R0.z;
MUL R3.w, R1, c[9].x;
MUL R1.xy, R0.y, c[11].zwzw;
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, R3;
MAD R0.xyz, R0, c[11].x, R1.xxyw;
MUL R0.w, R0.y, R0.y;
MAD R0.w, R0.x, R0.x, R0;
MAD R0.w, R0.z, R0.z, R0;
RSQ R0.w, R0.w;
MUL R1.x, R0.w, -R0.z;
MUL R0.w, R1.x, c[12].x;
COS R1.y, R0.w;
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R5.xyz, R0.w, R0;
ADD R0.xyz, -R0, R3;
MUL R0.y, R0, R0;
MAD R0.x, R0, R0, R0.y;
MAD R0.y, R0.z, R0.z, R0.x;
MAD R1.x, R1, c[12].y, R1.y;
MUL R1.xy, R1.x, c[11].zwzw;
MAD R1.xyz, R5, c[12].x, R1.xxyw;
DP3 R0.w, R1, R1;
RSQ R0.w, R0.w;
MUL R2.xyz, R0.w, R1;
MOV R8.xy, c[10].ywzw;
ADD R1.xyz, -R1, R3;
MUL R10.xyz, R5, R3.w;
MAD R4.xyz, R5, -R3.w, R3;
MUL R0.w, R8.y, c[9].x;
MAD R4.xyz, -R0.w, R2, R4;
TEX R6.yw, fragment.texcoord[0].zwzw, texture[2], 2D;
DP3 R1.w, R4, R4;
DP3 R4.w, R4, R3;
MAD R2.xy, R6.wyzw, c[10].z, -c[10].y;
RSQ R2.z, R1.w;
MUL R6.xyz, R2.z, R4;
MUL R1.w, R2.y, R2.y;
MAD R1.w, -R2.x, R2.x, -R1;
MUL R2.z, R1.y, R1.y;
ADD R1.w, R1, c[10].y;
RSQ R1.y, R1.w;
MAD R1.w, R1.x, R1.x, R2.z;
RCP R2.z, R1.y;
MAD R1.y, R1.z, R1.z, R1.w;
DP3 R1.x, R2, R6;
ADD R1.z, -R0.w, -R3.w;
RSQ R1.y, R1.y;
RCP R1.y, R1.y;
MAX R1.x, R1, c[10];
MUL R1.y, R1, c[4].x;
ADD R1.z, R1, c[10];
MUL R1.z, R1.y, R1;
MUL R1.y, R1.x, R1.x;
MUL R1.y, R1, R1.z;
MUL R1.y, R1, R1.z;
MUL R1.z, R4.y, R4.y;
MAD R1.z, R4.x, R4.x, R1;
MUL R1.y, R1, c[13].x;
POW R1.y, c[12].w, -R1.y;
MUL R1.y, -R1, c[13];
ADD R6.w, R1.y, c[10].y;
MAD R1.z, R4, R4, R1;
RSQ R1.y, R1.z;
RCP R1.z, R1.y;
MUL R5.w, R1.x, R6;
ADD R1.xy, R4, -R3;
MUL R1.xy, R0.w, R1;
MUL R1.z, R2.w, R1;
MUL R1.xy, R1, R1.z;
ADD_SAT R0.w, -R5, c[10].y;
MAD R1.xy, -R1, c[13].w, fragment.texcoord[0];
TEX R1, R1, texture[6], 2D;
POW R0.w, R0.w, c[13].z;
MUL R7.w, R0, R1;
DP3 R0.w, fragment.texcoord[4], fragment.texcoord[4];
RSQ R0.w, R0.w;
RCP R0.w, R0.w;
MUL R4.xyz, R1, c[1];
MUL_SAT R4.w, R4, c[9].x;
MUL R4.xyz, R4.w, R4;
ADD R4.w, -R4, c[10].y;
MAD R7.xyz, R4.w, c[1], R4;
TEX R4, fragment.texcoord[4], texture[3], CUBE;
DP4 R1.w, R4, c[15];
MUL R0.w, R0, c[0];
MAD R0.w, -R0, c[14].x, R1;
CMP R4.w, R0, c[3].x, R8.x;
DP3 R4.x, fragment.texcoord[2], fragment.texcoord[2];
RSQ R1.w, R4.x;
MUL R4.xyz, R1.w, fragment.texcoord[2];
DP3 R1.w, fragment.texcoord[3], fragment.texcoord[3];
ADD R6.xyz, R6, R4;
TEX R1.w, R1.w, texture[4], 2D;
TEX R0.w, fragment.texcoord[3], texture[5], CUBE;
MUL R0.w, R1, R0;
MUL R4.w, R0, R4;
MUL R0.w, R7, R4;
DP3 R1.w, R6, R6;
MUL_SAT R0.w, R0, c[14].y;
MUL R1.xyz, R0.w, R1;
RSQ R1.w, R1.w;
MUL R8.xyz, R1.w, R6;
DP3 R8.w, R2, R8;
DP3 R7.w, R2, R3;
MUL R1.xyz, R1, c[8];
ADD R0.w, -R0, c[10].y;
MAD R6.xyz, R0.w, R7, R1;
ABS R0.w, R8;
TEX R1, fragment.texcoord[0], texture[0], 2D;
MUL R1.xyz, R1, c[5];
MUL R7.x, R0.w, c[14].w;
ADD R7.y, -R0.w, c[10];
ADD R7.x, R7, c[16];
MAD R7.x, R7, R0.w, -c[16].y;
RSQ R7.y, R7.y;
MAD R0.w, R7.x, R0, c[16].z;
RCP R7.y, R7.y;
MUL R7.x, R0.w, R7.y;
SLT R0.w, R8, c[10].x;
MUL R7.y, R0.w, R7.x;
MAD R7.x, -R7.y, c[10].z, R7;
MAD R0.w, R0, c[14].z, R7.x;
MOV R7.z, c[16].w;
MUL R7.y, R7.z, c[9].x;
ADD R11.x, R7.y, c[17];
DP3 R7.z, R8, R4;
COS R0.w, R0.w;
MUL R0.w, R0, R0;
MUL R9.w, R11.x, R11.x;
MUL R7.x, R0.w, R11;
MUL R7.x, R7, R11;
MUL R7.y, R0.w, R9.w;
MUL R7.y, R0.w, R7;
RCP R9.y, R7.z;
MUL R6.xyz, R1, R6;
MUL R7.y, R7, c[17];
RCP R7.x, R7.x;
ADD R0.w, -R0, c[10].y;
MUL R0.w, R0, R7.x;
RCP R7.x, R7.y;
MOV R7.y, c[10];
ADD R10.w, R7.y, -c[6].x;
POW R0.w, c[12].w, -R0.w;
MUL R0.w, R0, R7.x;
ADD R7.x, -R8.w, c[10].y;
POW R7.x, R7.x, c[17].z;
MAD R7.x, R7, c[6], R10.w;
MUL R7.x, R0.w, R7;
DP3 R7.y, R2, R4;
RCP R0.w, R7.y;
MUL R7.x, R1.w, R7;
MUL_SAT R9.x, R7, R0.w;
MUL R7.x, R8.w, R7.y;
MUL R5.x, R7, R9.y;
ADD R7.xyz, R3, -R10;
MUL R9.z, R5.x, c[10];
DP3 R5.x, R7, R7;
RSQ R5.y, R5.x;
MUL R8.xyz, R5.y, R7;
DP3 R0.x, R2, R8;
MUL R5.x, R8.w, R7.w;
MUL R9.y, R9, R5.x;
ADD R5.xyz, R4, R8;
MUL R9.y, R9, c[10].z;
MIN_SAT R10.z, R9, R9.y;
DP3 R11.y, R5, R5;
RSQ R9.z, R11.y;
MUL R5.xyz, R9.z, R5;
DP3 R11.y, R2, R5;
ABS R5.y, R11;
MAX R9.y, R8.w, c[10].x;
MUL R5.z, R5.y, c[14].w;
MOV R8.w, c[17];
MUL R8.w, R8, c[6].x;
POW R5.x, R9.y, R8.w;
ADD R9.y, -R5, c[10];
ADD R5.z, R5, c[16].x;
MAD R5.z, R5, R5.y, -c[16].y;
RSQ R9.y, R9.y;
MUL R5.x, R1.w, R5;
MUL R5.x, R5, c[13];
MAD R5.x, R9, R10.z, R5;
MAX R0.z, R0.x, c[10].x;
RSQ R0.y, R0.y;
RCP R0.x, R0.y;
MAD R5.y, R5.z, R5, c[16].z;
RCP R9.y, R9.y;
MUL R5.z, R5.y, R9.y;
SLT R5.y, R11, c[10].x;
MUL R9.y, R5, R5.z;
MAD R5.z, -R9.y, c[10], R5;
MAD R5.y, R5, c[14].z, R5.z;
MUL_SAT R9.x, R6.w, R5;
COS R5.y, R5.y;
MUL R6.w, R5.y, R5.y;
MUL R11.z, R11.x, R6.w;
MOV R5.xyz, c[2];
MUL R5.xyz, R5, c[1];
MUL R9.xyz, R5, R9.x;
MAD R6.xyz, R6, R5.w, R9;
MUL R11.x, R11, R11.z;
RCP R9.x, R11.x;
ADD R5.w, -R6, c[10].y;
MUL R5.w, R5, R9.x;
MUL R9.x, R9.w, R6.w;
MUL R6.w, R6, R9.x;
ADD R9.x, -R11.y, c[10].y;
MUL R6.w, R6, c[17].y;
POW R9.x, R9.x, c[17].z;
RCP R6.w, R6.w;
POW R5.w, c[12].w, -R5.w;
MUL R5.w, R5, R6;
MAD R9.x, R9, c[6], R10.w;
MUL R6.w, R5, R9.x;
MUL R5.w, R4, c[10].z;
MUL R6.w, R1, R6;
MUL_SAT R0.w, R0, R6;
MAX R6.w, R11.y, c[10].x;
POW R6.w, R6.w, R8.w;
MUL R6.w, R1, R6;
MUL R6.w, R6, c[13].x;
ADD R0.y, -R3.w, c[10];
MUL R0.x, R0, c[4];
MUL R0.y, R0.x, R0;
MUL R0.x, R0.z, R0.z;
MUL R0.x, R0, R0.y;
MUL R0.x, R0, R0.y;
MUL R0.y, R7, R7;
MAD R0.y, R7.x, R7.x, R0;
MAD R0.y, R7.z, R7.z, R0;
MUL R0.x, R0, c[13];
POW R0.x, c[12].w, -R0.x;
MAD R6.w, R10.z, R0, R6;
MUL R0.x, -R0, c[13].y;
ADD R0.w, R0.x, c[10].y;
RSQ R0.y, R0.y;
MUL_SAT R6.w, R0, R6;
RCP R0.x, R0.y;
MUL R2.w, R2, R0.x;
MUL R0.xy, R3.w, -R10;
MUL R0.xy, R0, R2.w;
MUL R2.w, R0.z, R0;
MAD R0.xy, -R0, c[13].w, fragment.texcoord[0];
ADD_SAT R3.w, -R2, c[10].y;
TEX R0, R0, texture[6], 2D;
POW R3.w, R3.w, c[13].z;
MUL R0.w, R3, R0;
DP3 R3.w, R3, R7;
ADD R3.xyz, R3, R4;
DP3 R4.x, R3, R3;
MUL R0.w, R4, R0;
RSQ R4.x, R4.x;
MUL_SAT R0.w, R0, c[14].y;
MUL R7.xyz, R0, c[1];
MUL_SAT R3.w, R3, c[9].x;
MUL R7.xyz, R3.w, R7;
ADD R3.w, -R3, c[10].y;
MAD R7.xyz, R3.w, c[1], R7;
MUL R0.xyz, R0.w, R0;
ADD R3.w, -R0, c[10].y;
MUL R3.xyz, R4.x, R3;
DP3 R0.w, R2, R3;
MUL R0.xyz, R0, c[8];
MAD R0.xyz, R3.w, R7, R0;
MUL R0.xyz, R1, R0;
MUL R8.xyz, R5, R6.w;
MAX R0.w, R0, c[10].x;
POW R0.w, R0.w, R8.w;
MUL_SAT R0.w, R1, R0;
MUL R2.xyz, R5, R0.w;
MAD R0.xyz, R0, R2.w, R8;
MUL R0.xyz, R5.w, R0;
MAX R0.w, R7, c[10].x;
MUL R1.xyz, R1, c[1];
MAD R1.xyz, R1, R0.w, R2;
TEX R0.w, fragment.texcoord[0], texture[1], 2D;
ADD_SAT R0.w, R0, c[7].x;
MUL R2.xyz, R5.w, R1;
MUL R1.xyz, R0.w, R0;
ADD R0.x, -R0.w, c[10].y;
MUL R6.xyz, R6, R5.w;
MUL R2.xyz, R0.w, R2;
MAD R1.xyz, R0.x, R6, R1;
MAD result.color.xyz, R1, R0.x, R2;
MOV result.color.w, c[10].x;
END
# 299 instructions, 12 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Vector 0 [_LightPositionRange]
Vector 1 [_LightColor0]
Vector 2 [_SpecColor]
Vector 3 [_LightShadowData]
Float 4 [_GVar]
Vector 5 [_Color]
Float 6 [_Shininess]
Float 7 [_BlendAdjust1]
Vector 8 [_SSSC]
Float 9 [_Smoothness]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_ScatterMap] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_ShadowMapTexture] CUBE
SetTexture 4 [_LightTextureB0] 2D
SetTexture 5 [_LightTexture0] CUBE
SetTexture 6 [_ExitColorMap] 2D
"ps_3_0
; 355 ALU, 8 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_cube s3
dcl_2d s4
dcl_cube s5
dcl_2d s6
def c10, 2.00000000, -1.00000000, 0.10000000, -0.73550957
def c11, 0.11705996, 0.50000000, 6.28318501, -3.14159298
def c12, 0.00000000, -1.00000000, 0.73550957, -0.99270076
def c13, 0.15799320, 0.50000000, 0.99270076, 0.44999999
def c14, 2.71828198, 0.39894229, 1.00000000, 3.50000000
def c15, 0.00100000, 0.97000003, 7.00000000, -0.21211439
def c16, 1.00000000, 0.00392157, 0.00001538, 0.00000001
def c17, 0.00000000, 1.00000000, -0.01872930, 0.07426100
def c18, 1.57072902, 3.14159298, 0.15915491, 0.50000000
def c19, 1.29999995, 0.69999999, 3.14159274, 5.00000000
def c20, 128.00000000, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dp3_pp r0.x, v1, v1
rsq_pp r0.x, r0.x
mul_pp r2.xyz, r0.x, v1
mul r0.x, r2.y, r2.y
mad r0.x, r2, r2, r0
mad r0.x, r2.z, r2.z, r0
rsq r1.w, r0.x
mul r1.x, r1.w, -r2.z
mad r0.x, r1, c11, c11.y
frc r0.x, r0
mad r1.y, r0.x, c11.z, c11.w
sincos r0.xy, r1.y
mad r0.z, r1.x, c10.w, r0.x
dp3 r0.y, r2, r2
mul r1.xy, r0.z, c12
rsq r0.x, r0.y
mul r0.xyz, r0.x, r2
mad r3.xyz, r0, c12.z, r1.xxyw
mul r0.x, r3.y, r3.y
mad r0.x, r3, r3, r0
mad r0.x, r3.z, r3.z, r0
rsq r0.x, r0.x
mul r1.x, r0, -r3.z
mad r0.x, r1, c13, c13.y
frc r0.x, r0
mad r1.y, r0.x, c11.z, c11.w
sincos r0.xy, r1.y
mad r0.z, r1.x, c12.w, r0.x
dp3 r0.y, r3, r3
rsq r0.x, r0.y
mul r8.xyz, r0.x, r3
add r3.xyz, -r3, r2
mul r0.zw, r0.z, c12.xyxy
mad r9.xyz, r8, c13.z, r0.zzww
dp3 r0.x, r9, r9
mov r0.w, c9.x
mul r2.w, c13, r0
mov r0.w, c9.x
rsq r0.x, r0.x
mul r0.xyz, r0.x, r9
add r9.xyz, -r9, r2
mad r1.xyz, r8, -r2.w, r2
mul r4.w, c10.z, r0
mad r7.xyz, -r4.w, r0, r1
dp3 r0.x, r7, r7
texld r0.yw, v0.zwzw, s2
mad_pp r1.xy, r0.wyzw, c10.x, c10.y
rsq r0.x, r0.x
mul r6.xyz, r0.x, r7
mul_pp r0.w, r1.y, r1.y
mad_pp r0.w, -r1.x, r1.x, -r0
dp3_pp r0.x, v2, v2
rsq_pp r0.x, r0.x
mul_pp r4.xyz, r0.x, v2
add r0.xyz, r6, r4
dp3 r1.z, r0, r0
rsq r1.z, r1.z
add_pp r0.w, r0, c14.z
mul r5.xyz, r1.z, r0
rsq_pp r0.w, r0.w
rcp_pp r1.z, r0.w
dp3 r5.w, r1, r5
abs r0.x, r5.w
add r0.z, -r0.x, c14
mad r0.y, r0.x, c17.z, c17.w
mad r0.y, r0, r0.x, c15.w
rsq r0.z, r0.z
mad r0.x, r0.y, r0, c18
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r0.x, r5.w, c17, c17.y
mul r0.z, r0.x, r0.y
mad r0.y, -r0.z, c10.x, r0
mad r0.x, r0, c18.y, r0.y
mad r0.x, r0, c18.z, c18.w
frc r0.x, r0
mad r3.w, r0.x, c11.z, c11
sincos r0.xy, r3.w
mov r0.y, c9.x
mad r8.w, r0.y, c19.x, c19.y
mul r0.x, r0, r0
mul r0.y, r0.x, r8.w
mul r0.y, r0, r8.w
mul r3.w, r8, r8
mul r0.w, r0.x, r3
rcp r0.z, r0.y
add r0.y, -r0.x, c14.z
mul r6.w, r0.y, r0.z
mul r7.w, r0.x, r0
pow r0, c14.x, -r6.w
mul r0.y, r7.w, c19.z
rcp r0.y, r0.y
mul r10.x, r0, r0.y
add r7.w, -r5, c14.z
pow r0, r7.w, c19.w
dp3 r0.y, r1, r6
mul r6.w, r9.y, r9.y
mad r0.z, r9.x, r9.x, r6.w
mov_pp r6.z, c6.x
max r6.x, r0.y, c12
mad r0.z, r9, r9, r0
rsq r0.y, r0.z
add r0.z, -r4.w, -r2.w
rcp r0.y, r0.y
add_pp r7.w, c14.z, -r6.z
mul r0.y, r0, c4.x
add r0.z, r0, c10.x
mul r0.z, r0.y, r0
mul r0.y, r6.x, r6.x
mul r0.y, r0, r0.z
mov r6.w, r0.x
mul r0.y, r0, r0.z
mul r6.y, r0, c11
pow r0, c14.x, -r6.y
mad r10.w, -r0.x, c14.y, c14.z
mul r9.w, r6.x, r10
mul r0.y, r7, r7
mad r0.x, r7, r7, r0.y
mad r0.x, r7.z, r7.z, r0
mad r9.x, r6.w, c6, r7.w
add_sat r6.x, -r9.w, c14.z
rsq r6.y, r0.x
pow r0, r6.x, c14.w
add r0.zw, r7.xyxy, -r2.xyxy
dp3 r7.x, r7, r2
rcp r0.y, r6.y
mul r0.zw, r4.w, r0
mul r0.y, r1.w, r0
mul r0.zw, r0, r0.y
mad r6.xy, -r0.zwzw, c15.x, v0
mov r9.y, r0.x
texld r0, v4, s3
dp4 r0.y, r0, c16
dp3 r4.w, v4, v4
rsq r4.w, r4.w
rcp r0.x, r4.w
mul r0.x, r0, c0.w
texld r6, r6, s6
mad r0.x, -r0, c15.y, r0.y
mov r0.z, c3.x
cmp r0.y, r0.x, c14.z, r0.z
dp3 r0.x, v3, v3
texld r0.w, v3, s5
texld r0.x, r0.x, s4
mul r0.x, r0, r0.w
mul r4.w, r0.x, r0.y
mul r0.w, r10.x, r9.x
mul r10.xyz, r8, r2.w
mul r0.x, r9.y, r6.w
mul r0.x, r0, r4.w
mul_sat r6.w, r0.x, c15.z
mul_pp r0.xyz, r6, c1
mul_sat r7.x, r7, c9
mul r0.xyz, r7.x, r0
add r7.x, -r7, c14.z
add r8.xyz, r2, -r10
add r9.x, -r6.w, c14.z
mad r0.xyz, r7.x, c1, r0
mul r6.xyz, r6.w, r6
mul r7.xyz, r6, c8
texld r6, v0, s0
mad r0.xyz, r9.x, r0, r7
mul_pp r6.xyz, r6, c5
mul_pp r7.xyz, r6, r0
dp3_pp r0.y, r1, r4
mul r10.z, r5.w, r0.y
mul r0.x, r6.w, r0.w
rcp r12.y, r0.y
mul_sat r11.x, r0, r12.y
dp3 r0.x, r8, r8
rsq r0.y, r0.x
dp3_pp r0.x, r5, r4
rcp r0.w, r0.x
mul r5.x, r10.z, r0.w
mul r9.xyz, r0.y, r8
add r0.xyz, r4, r9
dp3 r5.y, r0, r0
rsq r5.y, r5.y
mul r0.xyz, r5.y, r0
dp3 r12.z, r1, r0
dp3_pp r10.z, r1, r2
abs r0.y, r12.z
mul r5.y, r5.w, r10.z
mul r0.x, r0.w, r5.y
add r0.w, -r0.y, c14.z
mad r0.z, r0.y, c17, c17.w
mad r0.z, r0, r0.y, c15.w
mad r0.y, r0.z, r0, c18.x
rsq r0.w, r0.w
rcp r0.w, r0.w
mul r0.y, r0, r0.w
cmp r0.z, r12, c17.x, c17.y
mul r0.w, r0.z, r0.y
mul r5.x, r5, c10
mul r0.x, r0, c10
min_sat r12.x, r5, r0
mad r0.x, -r0.w, c10, r0.y
mad r0.z, r0, c18.y, r0.x
mov_pp r0.x, c6
mul_pp r11.w, c20.x, r0.x
max r0.y, r5.w, c12.x
mad r0.z, r0, c18, c18.w
pow r5, r0.y, r11.w
frc r0.x, r0.z
mad r5.y, r0.x, c11.z, c11.w
sincos r0.xy, r5.y
mov r0.y, r5.x
mul r5.w, r0.x, r0.x
mul r0.y, r6.w, r0
mul r0.x, r0.y, c11.y
mul r0.y, r8.w, r5.w
mul r0.y, r8.w, r0
mad r0.x, r11, r12, r0
mul_sat r8.w, r10, r0.x
mov_pp r5.xyz, c1
mul_pp r5.xyz, c2, r5
mul r11.xyz, r5, r8.w
mad r7.xyz, r7, r9.w, r11
mul r3.w, r3, r5
add r0.x, -r5.w, c14.z
rcp r0.y, r0.y
mul r10.w, r0.x, r0.y
pow r0, c14.x, -r10.w
mov r8.w, r0.x
add r9.w, -r12.z, c14.z
pow r0, r9.w, c19.w
mul r0.y, r5.w, r3.w
mul_pp r5.w, r4, c10.x
mov r0.z, r0.x
mul r0.y, r0, c19.z
rcp r0.x, r0.y
mad r0.y, r0.z, c6.x, r7.w
mul r0.x, r8.w, r0
mul r0.x, r0, r0.y
mul r0.x, r6.w, r0
mul_sat r3.w, r12.y, r0.x
max r7.w, r12.z, c12.x
pow r0, r7.w, r11.w
mul r3.y, r3, r3
mad r0.y, r3.x, r3.x, r3
mad r0.z, r3, r3, r0.y
dp3 r0.y, r1, r9
max r3.x, r0.y, c12
rsq r0.z, r0.z
rcp r0.y, r0.z
mov r0.w, r0.x
mul r0.y, r0, c4.x
add r0.z, -r2.w, c14
mul r0.z, r0.y, r0
mul r0.y, r3.x, r3.x
mul r0.y, r0, r0.z
mul r0.x, r0.y, r0.z
mul r0.y, r6.w, r0.w
mul r3.y, r0.x, c11
mul r3.z, r0.y, c11.y
pow r0, c14.x, -r3.y
mad r0.z, r12.x, r3.w, r3
mad r0.x, -r0, c14.y, c14.z
mul r7.w, r3.x, r0.x
mul_sat r0.z, r0.x, r0
mul r0.y, r8, r8
mad r0.y, r8.x, r8.x, r0
mad r0.y, r8.z, r8.z, r0
rsq r0.y, r0.y
mul r9.xyz, r5, r0.z
rcp r0.x, r0.y
mul r0.z, r1.w, r0.x
mul r0.xy, r2.w, -r10
mul r3.xy, r0, r0.z
add_sat r3.z, -r7.w, c14
pow r0, r3.z, c14.w
dp3 r0.y, r2, r8
mad r3.xy, -r3, c15.x, v0
texld r3, r3, s6
mov r0.w, r0.x
mul r0.w, r0, r3
mul r0.w, r4, r0
mul_sat r0.w, r0, c15.z
mul_sat r0.y, r0, c9.x
mul_pp r8.xyz, r3, c1
mul r8.xyz, r0.y, r8
add r0.y, -r0, c14.z
mad r8.xyz, r0.y, c1, r8
add_pp r0.xyz, r2, r4
dp3_pp r1.w, r0, r0
rsq_pp r1.w, r1.w
mul_pp r0.xyz, r1.w, r0
dp3_pp r1.x, r1, r0
max_pp r2.x, r1, c12
mul r0.xyz, r0.w, r3
add r1.w, -r0, c14.z
mul r1.xyz, r0, c8
pow r0, r2.x, r11.w
mov r0.w, r0.x
mul_sat r0.w, r6, r0
mul r2.xyz, r5, r0.w
mad r1.xyz, r1.w, r8, r1
mul_pp r1.xyz, r6, r1
mad r0.xyz, r1, r7.w, r9
mul r0.xyz, r5.w, r0
max_pp r0.w, r10.z, c12.x
mul_pp r1.xyz, r6, c1
mad r1.xyz, r1, r0.w, r2
texld r0.w, v0, s1
add_sat r0.w, r0, c7.x
mul r2.xyz, r5.w, r1
mul_pp r1.xyz, r0.w, r0
add_pp r0.x, -r0.w, c14.z
mul r7.xyz, r7, r5.w
mul_pp r2.xyz, r0.w, r2
mad_pp r1.xyz, r0.x, r7, r1
mad_pp oC0.xyz, r1, r0.x, r2
mov_pp oC0.w, c12.x
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
Float 7 [_GVar]
Vector 8 [_Color]
Float 9 [_Shininess]
Float 10 [_BlendAdjust1]
Vector 11 [_SSSC]
Float 12 [_Smoothness]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_ScatterMap] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_LightTexture0] 2D
SetTexture 4 [_LightTextureB0] 2D
SetTexture 5 [_ShadowMapTexture] 2D
SetTexture 6 [_ExitColorMap] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 310 ALU, 11 TEX
PARAM c[20] = { program.local[0..12],
		{ 0, 1, 2, 0.1 },
		{ 0.73550957, -0.73550957, 0, -1 },
		{ 0.99270076, -0.99270076, 0.44999999, 2.718282 },
		{ 0.5, 0.39894229, 3.5, 0.001 },
		{ 0.25, 7, 3.141593, -0.018729299 },
		{ 0.074261002, 0.21211439, 1.570729, 1.3 },
		{ 0.69999999, 3.1415927, 5, 128 } };
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
TEMP R11;
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.x, R0.x;
MUL R4.xyz, R0.x, fragment.texcoord[1];
MUL R0.x, R4.y, R4.y;
MAD R0.x, R4, R4, R0;
MAD R0.x, R4.z, R4.z, R0;
RSQ R3.w, R0.x;
MUL R0.y, R3.w, -R4.z;
MUL R0.x, R0.y, c[14];
COS R0.z, R0.x;
DP3 R0.x, R4, R4;
MAD R0.y, R0, c[14], R0.z;
RCP R8.w, fragment.texcoord[4].w;
MUL R1.xy, R0.y, c[14].zwzw;
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, R4;
MAD R5.xyz, R0, c[14].x, R1.xxyw;
MUL R0.x, R5.y, R5.y;
MAD R0.x, R5, R5, R0;
MAD R0.x, R5.z, R5.z, R0;
RSQ R0.x, R0.x;
MUL R0.y, R0.x, -R5.z;
MUL R0.x, R0.y, c[15];
COS R0.z, R0.x;
DP3 R0.x, R5, R5;
MAD R0.y, R0, c[15], R0.z;
RSQ R0.x, R0.x;
MUL R6.xyz, R0.x, R5;
MUL R0.zw, R0.y, c[14];
MAD R1.xyz, R6, c[15].x, R0.zzww;
DP3 R0.x, R1, R1;
MOV R0.w, c[15].z;
MUL R4.w, R0, c[12].x;
MOV R9.xy, c[13].ywzw;
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, R1;
ADD R1.xyz, -R1, R4;
MAD R2.xyz, R6, -R4.w, R4;
MUL R0.w, R9.y, c[12].x;
MAD R0.xyz, -R0.w, R0, R2;
DP3 R1.w, R0, R0;
RSQ R2.x, R1.w;
MUL R7.xyz, R2.x, R0;
TEX R2.yw, fragment.texcoord[0].zwzw, texture[2], 2D;
MAD R3.xy, R2.wyzw, c[13].z, -c[13].y;
MUL R1.w, R3.y, R3.y;
MAD R1.w, -R3.x, R3.x, -R1;
MUL R10.xyz, R6, R4.w;
MUL R2.x, R1.y, R1.y;
ADD R1.w, R1, c[13].y;
RSQ R1.y, R1.w;
RCP R3.z, R1.y;
MAD R1.w, R1.x, R1.x, R2.x;
MAD R1.y, R1.z, R1.z, R1.w;
DP3 R1.x, R3, R7;
MAX R1.z, R1.x, c[13].x;
RSQ R1.x, R1.y;
ADD R1.y, -R0.w, -R4.w;
RCP R1.x, R1.x;
MUL R1.w, R0.y, R0.y;
MUL R1.x, R1, c[7];
ADD R1.y, R1, c[13].z;
MUL R1.y, R1.x, R1;
MUL R1.x, R1.z, R1.z;
MUL R1.x, R1, R1.y;
MUL R1.x, R1, R1.y;
MAD R1.y, R0.x, R0.x, R1.w;
MAD R1.y, R0.z, R0.z, R1;
RSQ R1.y, R1.y;
RCP R2.x, R1.y;
MUL R1.x, R1, c[16];
POW R1.x, c[15].w, -R1.x;
MUL R1.w, -R1.x, c[16].y;
ADD R6.w, R1, c[13].y;
ADD R1.xy, R0, -R4;
MUL R1.xy, R0.w, R1;
MUL R2.x, R3.w, R2;
MUL R1.xy, R1, R2.x;
MAD R1.xy, -R1, c[16].w, fragment.texcoord[0];
DP3 R0.w, R0, R4;
TEX R2, R1, texture[6], 2D;
MUL R5.w, R1.z, R6;
MUL R0.xyz, R2, c[0];
MUL_SAT R0.w, R0, c[12].x;
MUL R0.xyz, R0.w, R0;
ADD R0.w, -R0, c[13].y;
MAD R8.xyz, R0.w, c[0], R0;
ADD_SAT R0.x, -R5.w, c[13].y;
POW R7.w, R0.x, c[16].z;
MAD R0.xy, fragment.texcoord[4], R8.w, c[6];
MAD R0.zw, fragment.texcoord[4].xyxy, R8.w, c[5].xyxy;
TEX R1.x, R0.zwzw, texture[5], 2D;
TEX R0.x, R0, texture[5], 2D;
MOV R1.w, R0.x;
MAD R0.xy, fragment.texcoord[4], R8.w, c[4];
TEX R0.x, R0, texture[5], 2D;
MOV R1.z, R1.x;
MAD R0.zw, fragment.texcoord[4].xyxy, R8.w, c[3].xyxy;
TEX R1.x, R0.zwzw, texture[5], 2D;
MOV R1.y, R0.x;
MAD R0, -fragment.texcoord[4].z, R8.w, R1;
DP3 R1.w, fragment.texcoord[3], fragment.texcoord[3];
CMP R0, R0, c[2].x, R9.x;
MUL R1.z, R7.w, R2.w;
DP4 R2.w, R0, c[17].x;
DP3 R1.x, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.x, R1.x;
MUL R0.xyz, R0.x, fragment.texcoord[2];
RCP R0.w, fragment.texcoord[3].w;
MAD R1.xy, fragment.texcoord[3], R0.w, c[16].x;
TEX R0.w, R1, texture[3], 2D;
ADD R7.xyz, R7, R0;
SLT R1.x, c[13], fragment.texcoord[3].z;
DP3 R1.y, R7, R7;
TEX R1.w, R1.w, texture[4], 2D;
MUL R0.w, R1.x, R0;
MUL R0.w, R0, R1;
MUL R0.w, R0, R2;
MUL R1.x, R1.z, R0.w;
RSQ R2.w, R1.y;
MUL R7.xyz, R2.w, R7;
DP3 R8.w, R3, R7;
ABS R2.w, R8;
DP3 R7.x, R7, R0;
MUL_SAT R1.w, R1.x, c[17].y;
MUL R1.xyz, R1.w, R2;
MUL R7.w, R2, c[17];
ADD R7.w, R7, c[18].x;
MAD R7.w, R7, R2, -c[18].y;
MUL R1.xyz, R1, c[11];
ADD R1.w, -R1, c[13].y;
MAD R2.xyz, R1.w, R8, R1;
ADD R8.x, -R2.w, c[13].y;
TEX R1, fragment.texcoord[0], texture[0], 2D;
MUL R1.xyz, R1, c[8];
RSQ R8.x, R8.x;
MAD R2.w, R7, R2, c[18].z;
RCP R8.x, R8.x;
MUL R7.w, R2, R8.x;
SLT R2.w, R8, c[13].x;
MUL R8.x, R2.w, R7.w;
MAD R7.w, -R8.x, c[13].z, R7;
MAD R2.w, R2, c[17].z, R7;
MOV R8.y, c[18].w;
MUL R8.x, R8.y, c[12];
ADD R11.x, R8, c[19];
COS R2.w, R2.w;
MUL R2.w, R2, R2;
MUL R9.w, R11.x, R11.x;
MUL R7.w, R2, R11.x;
MUL R7.w, R7, R11.x;
MUL R8.x, R2.w, R9.w;
MUL R8.x, R2.w, R8;
MUL R2.xyz, R1, R2;
MUL R8.x, R8, c[19].y;
RCP R7.w, R7.w;
ADD R2.w, -R2, c[13].y;
MUL R2.w, R2, R7;
RCP R7.w, R8.x;
MOV R8.x, c[13].y;
ADD R10.w, R8.x, -c[9].x;
DP3 R8.x, R3, R0;
POW R2.w, c[15].w, -R2.w;
MUL R2.w, R2, R7;
ADD R7.w, -R8, c[13].y;
POW R7.w, R7.w, c[19].z;
MAD R7.w, R7, c[9].x, R10;
MUL R7.w, R2, R7;
MUL R7.y, R8.w, R8.x;
RCP R2.w, R8.x;
MUL R7.w, R1, R7;
MUL_SAT R11.z, R7.w, R2.w;
RCP R7.x, R7.x;
MUL R6.x, R7.y, R7;
ADD R8.xyz, R4, -R10;
MUL R7.y, R6.x, c[13].z;
DP3 R6.x, R8, R8;
RSQ R6.y, R6.x;
DP3 R7.w, R3, R4;
MUL R6.x, R8.w, R7.w;
MUL R7.x, R7, R6;
MUL R9.xyz, R6.y, R8;
ADD R6.xyz, R0, R9;
MUL R7.x, R7, c[13].z;
MIN_SAT R10.z, R7.y, R7.x;
DP3 R7.z, R6, R6;
RSQ R7.y, R7.z;
MUL R6.xyz, R7.y, R6;
DP3 R11.y, R3, R6;
ABS R6.y, R11;
MUL R6.z, R6.y, c[17].w;
ADD R6.z, R6, c[18].x;
MAD R6.z, R6, R6.y, -c[18].y;
MAX R7.x, R8.w, c[13];
MOV R7.y, c[19].w;
MUL R8.w, R7.y, c[9].x;
POW R6.x, R7.x, R8.w;
ADD R7.x, -R6.y, c[13].y;
RSQ R7.x, R7.x;
MUL R6.x, R1.w, R6;
MUL R6.x, R6, c[16];
MAD R6.y, R6.z, R6, c[18].z;
RCP R7.x, R7.x;
MUL R6.z, R6.y, R7.x;
SLT R6.y, R11, c[13].x;
MUL R7.x, R6.y, R6.z;
MAD R6.z, -R7.x, c[13], R6;
MAD R6.y, R6, c[17].z, R6.z;
MAD R6.x, R11.z, R10.z, R6;
MUL_SAT R7.x, R6.w, R6;
COS R6.y, R6.y;
MUL R6.w, R6.y, R6.y;
MUL R11.z, R11.x, R6.w;
MOV R6.xyz, c[1];
MUL R6.xyz, R6, c[0];
MUL R7.xyz, R6, R7.x;
MAD R2.xyz, R2, R5.w, R7;
MUL R11.x, R11, R11.z;
ADD R0.xyz, R4, R0;
RCP R7.x, R11.x;
ADD R5.w, -R6, c[13].y;
MUL R5.w, R5, R7.x;
MUL R7.x, R9.w, R6.w;
MUL R6.w, R6, R7.x;
ADD R7.x, -R11.y, c[13].y;
MUL R6.w, R6, c[19].y;
POW R7.x, R7.x, c[19].z;
RCP R6.w, R6.w;
POW R5.w, c[15].w, -R5.w;
MUL R5.w, R5, R6;
MAD R7.x, R7, c[9], R10.w;
MUL R6.w, R5, R7.x;
MUL R5.w, R0, c[13].z;
MUL R6.w, R1, R6;
MUL_SAT R2.w, R2, R6;
MUL R7.xyz, R2, R5.w;
ADD R2.xyz, -R5, R4;
MUL R2.y, R2, R2;
MAD R2.x, R2, R2, R2.y;
MAD R2.y, R2.z, R2.z, R2.x;
DP3 R2.x, R3, R9;
MAX R6.w, R11.y, c[13].x;
POW R5.x, R6.w, R8.w;
MUL R5.x, R1.w, R5;
MUL R5.x, R5, c[16];
MAX R2.z, R2.x, c[13].x;
RSQ R2.y, R2.y;
RCP R2.x, R2.y;
ADD R2.y, -R4.w, c[13];
MUL R2.x, R2, c[7];
MUL R2.y, R2.x, R2;
MUL R2.x, R2.z, R2.z;
MUL R2.x, R2, R2.y;
MUL R2.x, R2, R2.y;
MUL R2.y, R8, R8;
MAD R2.y, R8.x, R8.x, R2;
MAD R2.y, R8.z, R8.z, R2;
MUL R2.x, R2, c[16];
POW R2.x, c[15].w, -R2.x;
MAD R5.x, R10.z, R2.w, R5;
MUL R2.x, -R2, c[16].y;
ADD R2.w, R2.x, c[13].y;
RSQ R2.y, R2.y;
MUL_SAT R5.x, R2.w, R5;
RCP R2.x, R2.y;
MUL R3.w, R3, R2.x;
MUL R2.xy, R4.w, -R10;
MUL R2.xy, R2, R3.w;
MUL R3.w, R2.z, R2;
MAD R2.xy, -R2, c[16].w, fragment.texcoord[0];
ADD_SAT R4.w, -R3, c[13].y;
TEX R2, R2, texture[6], 2D;
POW R4.w, R4.w, c[16].z;
MUL R2.w, R4, R2;
DP3 R4.w, R4, R8;
MUL R0.w, R0, R2;
MUL_SAT R0.w, R0, c[17].y;
MUL R8.xyz, R2, c[0];
MUL_SAT R4.w, R4, c[12].x;
MUL R8.xyz, R4.w, R8;
DP3 R4.x, R0, R0;
MUL R2.xyz, R0.w, R2;
ADD R4.w, -R4, c[13].y;
RSQ R4.x, R4.x;
ADD R2.w, -R0, c[13].y;
MUL R0.xyz, R4.x, R0;
DP3 R0.w, R3, R0;
MAX R0.w, R0, c[13].x;
POW R0.w, R0.w, R8.w;
MUL R2.xyz, R2, c[11];
MAD R8.xyz, R4.w, c[0], R8;
MAD R0.xyz, R2.w, R8, R2;
MUL R0.xyz, R1, R0;
MUL_SAT R0.w, R1, R0;
MUL R2.xyz, R6, R0.w;
MUL R5.xyz, R6, R5.x;
MAD R0.xyz, R0, R3.w, R5;
MUL R0.xyz, R5.w, R0;
MAX R0.w, R7, c[13].x;
MUL R1.xyz, R1, c[0];
MAD R1.xyz, R1, R0.w, R2;
TEX R0.w, fragment.texcoord[0], texture[1], 2D;
ADD_SAT R0.w, R0, c[10].x;
MUL R2.xyz, R5.w, R1;
MUL R1.xyz, R0.w, R0;
ADD R0.x, -R0.w, c[13].y;
MUL R2.xyz, R0.w, R2;
MAD R1.xyz, R0.x, R7, R1;
MAD result.color.xyz, R1, R0.x, R2;
MOV result.color.w, c[13].x;
END
# 310 instructions, 12 R-regs
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
Float 7 [_GVar]
Vector 8 [_Color]
Float 9 [_Shininess]
Float 10 [_BlendAdjust1]
Vector 11 [_SSSC]
Float 12 [_Smoothness]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_ScatterMap] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_LightTexture0] 2D
SetTexture 4 [_LightTextureB0] 2D
SetTexture 5 [_ShadowMapTexture] 2D
SetTexture 6 [_ExitColorMap] 2D
"ps_3_0
; 365 ALU, 11 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
def c13, 2.00000000, -1.00000000, 0.10000000, -0.73550957
def c14, 0.11705996, 0.50000000, 6.28318501, -3.14159298
def c15, 0.00000000, -1.00000000, 0.73550957, -0.99270076
def c16, 0.15799320, 0.50000000, 0.99270076, 0.44999999
def c17, 2.71828198, 0.39894229, 1.00000000, 3.50000000
def c18, 0.00100000, 0.00000000, 1.00000000, 0.25000000
def c19, 7.00000000, -0.01872930, 0.07426100, -0.21211439
def c20, 1.57072902, 3.14159298, 0.15915491, 0.50000000
def c21, 1.29999995, 0.69999999, 3.14159274, 5.00000000
def c22, 128.00000000, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3
dcl_texcoord4 v4
dp3_pp r0.x, v1, v1
rsq_pp r0.x, r0.x
mul_pp r2.xyz, r0.x, v1
mul r0.x, r2.y, r2.y
mad r0.x, r2, r2, r0
mad r0.x, r2.z, r2.z, r0
rsq r1.w, r0.x
mul r1.x, r1.w, -r2.z
mad r0.x, r1, c14, c14.y
frc r0.x, r0
mad r1.y, r0.x, c14.z, c14.w
sincos r0.xy, r1.y
mad r0.z, r1.x, c13.w, r0.x
dp3 r0.y, r2, r2
mul r1.xy, r0.z, c15
rsq r0.x, r0.y
mul r0.xyz, r0.x, r2
mad r3.xyz, r0, c15.z, r1.xxyw
mul r0.x, r3.y, r3.y
mad r0.x, r3, r3, r0
mad r0.x, r3.z, r3.z, r0
rsq r0.x, r0.x
mul r1.x, r0, -r3.z
mad r0.x, r1, c16, c16.y
frc r0.x, r0
mad r1.y, r0.x, c14.z, c14.w
sincos r0.xy, r1.y
mad r0.z, r1.x, c15.w, r0.x
dp3 r0.y, r3, r3
rsq r0.x, r0.y
mul r8.xyz, r0.x, r3
add r3.xyz, -r3, r2
mul r0.zw, r0.z, c15.xyxy
mad r6.xyz, r8, c16.z, r0.zzww
dp3 r0.x, r6, r6
mov r0.w, c12.x
mul r2.w, c16, r0
mov r0.w, c12.x
rsq r0.x, r0.x
mul r0.xyz, r0.x, r6
mad r1.xyz, r8, -r2.w, r2
mul r4.w, c13.z, r0
mad r7.xyz, -r4.w, r0, r1
dp3 r0.x, r7, r7
texld r0.yw, v0.zwzw, s2
mad_pp r1.xy, r0.wyzw, c13.x, c13.y
rsq r0.x, r0.x
mul r9.xyz, r0.x, r7
mul_pp r0.w, r1.y, r1.y
mad_pp r0.w, -r1.x, r1.x, -r0
dp3_pp r0.x, v2, v2
rsq_pp r0.x, r0.x
mul_pp r4.xyz, r0.x, v2
add r0.xyz, r9, r4
dp3 r1.z, r0, r0
rsq r1.z, r1.z
add_pp r0.w, r0, c17.z
mul r5.xyz, r1.z, r0
rsq_pp r0.w, r0.w
rcp_pp r1.z, r0.w
dp3 r5.w, r1, r5
abs r0.x, r5.w
add r0.z, -r0.x, c17
mad r0.y, r0.x, c19, c19.z
mad r0.y, r0, r0.x, c19.w
rsq r0.z, r0.z
mad r0.x, r0.y, r0, c20
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r0.x, r5.w, c18.y, c18.z
mul r0.z, r0.x, r0.y
mad r0.y, -r0.z, c13.x, r0
mad r0.x, r0, c20.y, r0.y
mad r0.x, r0, c20.z, c20.w
frc r0.x, r0
mad r3.w, r0.x, c14.z, c14
sincos r0.xy, r3.w
mov r0.y, c12.x
mad r8.w, r0.y, c21.x, c21.y
mul r6.w, r0.x, r0.x
mul r0.x, r6.w, r8.w
mul r0.x, r0, r8.w
rcp r0.y, r0.x
add r0.x, -r6.w, c17.z
mul r7.w, r0.x, r0.y
pow r0, c17.x, -r7.w
mul r3.w, r8, r8
mul r0.y, r6.w, r3.w
mul r0.y, r6.w, r0
mul r0.w, r0.y, c21.z
mov r6.w, r0.x
add r0.xyz, -r6, r2
rcp r0.w, r0.w
mul r0.y, r0, r0
mad r0.y, r0.x, r0.x, r0
dp3 r0.x, r1, r9
mul r10.x, r6.w, r0.w
max r9.x, r0, c15
mad r0.y, r0.z, r0.z, r0
rsq r0.x, r0.y
add r0.y, -r4.w, -r2.w
rcp r0.x, r0.x
add r6.y, -r5.w, c17.z
mul r0.x, r0, c7
add r0.y, r0, c13.x
mul r0.y, r0.x, r0
mul r0.x, r9, r9
mul r0.x, r0, r0.y
mul r6.x, r0, r0.y
pow r0, r6.y, c21.w
mul r0.y, r6.x, c14
pow r6, c17.x, -r0.y
mov_pp r0.y, c9.x
mov r0.z, r0.x
add_pp r7.w, c17.z, -r0.y
mov r0.x, r6
mad r10.w, -r0.x, c17.y, c17.z
mul r9.w, r9.x, r10
mul r0.x, r7.y, r7.y
mad r9.z, r0, c9.x, r7.w
mad r6.y, r7.x, r7.x, r0.x
add_sat r6.x, -r9.w, c17.z
pow r0, r6.x, c17.w
mad r0.y, r7.z, r7.z, r6
rsq r0.y, r0.y
rcp r0.z, r0.y
mov r10.y, r0.x
add r0.xy, r7, -r2
dp3 r7.x, r7, r2
mul r0.xy, r4.w, r0
rcp r4.w, v4.w
mul r0.z, r1.w, r0
mul r0.xy, r0, r0.z
mad r6.xy, -r0, c18.x, v0
mad r0.xy, v4, r4.w, c6
texld r0.x, r0, s5
texld r6, r6, s6
mad r9.xy, v4, r4.w, c5
mov r0.w, r0.x
texld r0.x, r9, s5
mad r9.xy, v4, r4.w, c4
mov r0.z, r0.x
texld r0.x, r9, s5
mad r9.xy, v4, r4.w, c3
mov r0.y, r0.x
texld r0.x, r9, s5
mad r0, -v4.z, r4.w, r0
mov r9.x, c2
cmp r0, r0, c17.z, r9.x
dp4_pp r0.z, r0, c18.w
rcp r4.w, v3.w
mad r9.xy, v3, r4.w, c14.y
dp3 r0.x, v3, v3
texld r0.w, r9, s3
cmp r0.y, -v3.z, c18, c18.z
mul_pp r0.y, r0, r0.w
texld r0.x, r0.x, s4
mul_pp r0.x, r0.y, r0
mul_pp r4.w, r0.x, r0.z
mul r0.x, r10.y, r6.w
mul r0.w, r10.x, r9.z
mul r10.xyz, r8, r2.w
mul r0.x, r0, r4.w
mul_sat r6.w, r0.x, c19.x
mul_pp r0.xyz, r6, c0
mul_sat r7.x, r7, c12
mul r0.xyz, r7.x, r0
add r7.x, -r7, c17.z
add r8.xyz, r2, -r10
add r9.x, -r6.w, c17.z
mad r0.xyz, r7.x, c0, r0
mul r6.xyz, r6.w, r6
mul r7.xyz, r6, c11
texld r6, v0, s0
mad r0.xyz, r9.x, r0, r7
mul_pp r6.xyz, r6, c8
mul_pp r7.xyz, r6, r0
dp3_pp r0.y, r1, r4
mul r10.z, r5.w, r0.y
mul r0.x, r6.w, r0.w
rcp r12.y, r0.y
mul_sat r11.x, r0, r12.y
dp3 r0.x, r8, r8
rsq r0.y, r0.x
dp3_pp r0.x, r5, r4
rcp r0.w, r0.x
mul r5.x, r10.z, r0.w
mul r9.xyz, r0.y, r8
add r0.xyz, r4, r9
dp3 r5.y, r0, r0
rsq r5.y, r5.y
mul r0.xyz, r5.y, r0
dp3 r12.z, r1, r0
dp3_pp r10.z, r1, r2
abs r0.y, r12.z
mul r5.y, r5.w, r10.z
mul r0.x, r0.w, r5.y
add r0.w, -r0.y, c17.z
mad r0.z, r0.y, c19.y, c19
mad r0.z, r0, r0.y, c19.w
mad r0.y, r0.z, r0, c20.x
rsq r0.w, r0.w
rcp r0.w, r0.w
mul r0.y, r0, r0.w
cmp r0.z, r12, c18.y, c18
mul r0.w, r0.z, r0.y
mul r5.x, r5, c13
mul r0.x, r0, c13
min_sat r12.x, r5, r0
mad r0.x, -r0.w, c13, r0.y
mad r0.z, r0, c20.y, r0.x
mov_pp r0.x, c9
mul_pp r11.w, c22.x, r0.x
max r0.y, r5.w, c15.x
mad r0.z, r0, c20, c20.w
pow r5, r0.y, r11.w
frc r0.x, r0.z
mad r5.y, r0.x, c14.z, c14.w
sincos r0.xy, r5.y
mov r0.y, r5.x
mul r5.w, r0.x, r0.x
mul r0.y, r6.w, r0
mul r0.x, r0.y, c14.y
mul r0.y, r8.w, r5.w
mul r0.y, r8.w, r0
mad r0.x, r11, r12, r0
mul_sat r8.w, r10, r0.x
mov_pp r5.xyz, c0
mul_pp r5.xyz, c1, r5
mul r11.xyz, r5, r8.w
mad r7.xyz, r7, r9.w, r11
mul r3.w, r3, r5
add r0.x, -r5.w, c17.z
rcp r0.y, r0.y
mul r10.w, r0.x, r0.y
pow r0, c17.x, -r10.w
mov r8.w, r0.x
add r9.w, -r12.z, c17.z
pow r0, r9.w, c21.w
mul r0.y, r5.w, r3.w
mul_pp r5.w, r4, c13.x
mov r0.z, r0.x
mul r0.y, r0, c21.z
rcp r0.x, r0.y
mad r0.y, r0.z, c9.x, r7.w
mul r0.x, r8.w, r0
mul r0.x, r0, r0.y
mul r0.x, r6.w, r0
mul_sat r3.w, r12.y, r0.x
max r7.w, r12.z, c15.x
pow r0, r7.w, r11.w
mul r3.y, r3, r3
mad r0.y, r3.x, r3.x, r3
mad r0.z, r3, r3, r0.y
dp3 r0.y, r1, r9
max r3.x, r0.y, c15
rsq r0.z, r0.z
rcp r0.y, r0.z
mov r0.w, r0.x
mul r0.y, r0, c7.x
add r0.z, -r2.w, c17
mul r0.z, r0.y, r0
mul r0.y, r3.x, r3.x
mul r0.y, r0, r0.z
mul r0.x, r0.y, r0.z
mul r0.y, r6.w, r0.w
mul r3.y, r0.x, c14
mul r3.z, r0.y, c14.y
pow r0, c17.x, -r3.y
mad r0.z, r12.x, r3.w, r3
mad r0.x, -r0, c17.y, c17.z
mul r7.w, r3.x, r0.x
mul_sat r0.z, r0.x, r0
mul r0.y, r8, r8
mad r0.y, r8.x, r8.x, r0
mad r0.y, r8.z, r8.z, r0
rsq r0.y, r0.y
mul r9.xyz, r5, r0.z
rcp r0.x, r0.y
mul r0.z, r1.w, r0.x
mul r0.xy, r2.w, -r10
mul r3.xy, r0, r0.z
add_sat r3.z, -r7.w, c17
pow r0, r3.z, c17.w
dp3 r0.y, r2, r8
mad r3.xy, -r3, c18.x, v0
texld r3, r3, s6
mov r0.w, r0.x
mul r0.w, r0, r3
mul r0.w, r4, r0
mul_sat r0.w, r0, c19.x
mul_sat r0.y, r0, c12.x
mul_pp r8.xyz, r3, c0
mul r8.xyz, r0.y, r8
add r0.y, -r0, c17.z
mad r8.xyz, r0.y, c0, r8
add_pp r0.xyz, r2, r4
dp3_pp r1.w, r0, r0
rsq_pp r1.w, r1.w
mul_pp r0.xyz, r1.w, r0
dp3_pp r1.x, r1, r0
max_pp r2.x, r1, c15
mul r0.xyz, r0.w, r3
add r1.w, -r0, c17.z
mul r1.xyz, r0, c11
pow r0, r2.x, r11.w
mov r0.w, r0.x
mul_sat r0.w, r6, r0
mul r2.xyz, r5, r0.w
mad r1.xyz, r1.w, r8, r1
mul_pp r1.xyz, r6, r1
mad r0.xyz, r1, r7.w, r9
mul r0.xyz, r5.w, r0
max_pp r0.w, r10.z, c15.x
mul_pp r1.xyz, r6, c0
mad r1.xyz, r1, r0.w, r2
texld r0.w, v0, s1
add_sat r0.w, r0, c10.x
mul r2.xyz, r5.w, r1
mul_pp r1.xyz, r0.w, r0
add_pp r0.x, -r0.w, c17.z
mul r7.xyz, r7, r5.w
mul_pp r2.xyz, r0.w, r2
mad_pp r1.xyz, r0.x, r7, r1
mad_pp oC0.xyz, r1, r0.x, r2
mov_pp oC0.w, c15.x
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
Float 7 [_GVar]
Vector 8 [_Color]
Float 9 [_Shininess]
Float 10 [_BlendAdjust1]
Vector 11 [_SSSC]
Float 12 [_Smoothness]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_ScatterMap] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_LightTexture0] 2D
SetTexture 4 [_LightTextureB0] 2D
SetTexture 5 [_ShadowMapTexture] 2D
SetTexture 6 [_ExitColorMap] 2D
"ps_3_0
; 365 ALU, 11 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
def c13, 2.00000000, -1.00000000, 0.10000000, -0.73550957
def c14, 0.11705996, 0.50000000, 6.28318501, -3.14159298
def c15, 0.00000000, -1.00000000, 0.73550957, -0.99270076
def c16, 0.15799320, 0.50000000, 0.99270076, 0.44999999
def c17, 2.71828198, 0.39894229, 1.00000000, 3.50000000
def c18, 0.00100000, 0.00000000, 1.00000000, 0.25000000
def c19, 7.00000000, -0.01872930, 0.07426100, -0.21211439
def c20, 1.57072902, 3.14159298, 0.15915491, 0.50000000
def c21, 1.29999995, 0.69999999, 3.14159274, 5.00000000
def c22, 128.00000000, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3
dcl_texcoord4 v4
dp3_pp r0.x, v1, v1
rsq_pp r0.x, r0.x
mul_pp r3.xyz, r0.x, v1
mul r0.x, r3.y, r3.y
mad r0.x, r3, r3, r0
mad r0.x, r3.z, r3.z, r0
rsq r2.w, r0.x
mul r1.x, r2.w, -r3.z
mad r0.x, r1, c14, c14.y
frc r0.x, r0
mad r1.y, r0.x, c14.z, c14.w
sincos r0.xy, r1.y
mad r0.z, r1.x, c13.w, r0.x
dp3 r0.y, r3, r3
rcp r10.z, v4.w
mul r1.xy, r0.z, c15
rsq r0.x, r0.y
mul r0.xyz, r0.x, r3
mad r4.xyz, r0, c15.z, r1.xxyw
mul r0.x, r4.y, r4.y
mad r0.x, r4, r4, r0
mad r0.x, r4.z, r4.z, r0
rsq r0.x, r0.x
mul r1.x, r0, -r4.z
mad r0.x, r1, c16, c16.y
frc r0.x, r0
mad r1.y, r0.x, c14.z, c14.w
sincos r0.xy, r1.y
mad r0.z, r1.x, c15.w, r0.x
dp3 r0.y, r4, r4
rsq r0.x, r0.y
mul r8.xyz, r0.x, r4
add r4.xyz, -r4, r3
mul r0.zw, r0.z, c15.xyxy
mad r1.xyz, r8, c16.z, r0.zzww
dp3 r0.x, r1, r1
mov r0.w, c12.x
mul r3.w, c16, r0
mov r0.w, c12.x
rsq r0.x, r0.x
mul r0.xyz, r0.x, r1
mad r2.xyz, r8, -r3.w, r3
mul r6.w, c13.z, r0
mad r7.xyz, -r6.w, r0, r2
texld r0.yw, v0.zwzw, s2
mad_pp r2.xy, r0.wyzw, c13.x, c13.y
dp3 r0.x, r7, r7
rsq r0.x, r0.x
mul r6.xyz, r0.x, r7
mul_pp r0.w, r2.y, r2.y
mad_pp r0.w, -r2.x, r2.x, -r0
dp3_pp r0.x, v2, v2
rsq_pp r0.x, r0.x
mul_pp r5.xyz, r0.x, v2
add r0.xyz, r6, r5
dp3 r1.w, r0, r0
rsq r1.w, r1.w
add_pp r0.w, r0, c17.z
rsq_pp r0.w, r0.w
rcp_pp r2.z, r0.w
mul r9.xyz, r1.w, r0
dp3 r8.w, r2, r9
abs r0.x, r8.w
add r0.z, -r0.x, c17
mad r0.y, r0.x, c19, c19.z
mad r0.y, r0, r0.x, c19.w
rsq r0.z, r0.z
mad r0.x, r0.y, r0, c20
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r0.x, r8.w, c18.y, c18.z
mul r0.z, r0.x, r0.y
mad r0.y, -r0.z, c13.x, r0
mad r0.x, r0, c20.y, r0.y
mad r0.x, r0, c20.z, c20.w
frc r0.x, r0
mad r1.w, r0.x, c14.z, c14
sincos r0.xy, r1.w
mov r0.y, c12.x
mad r7.w, r0.y, c21.x, c21.y
mul r1.w, r0.x, r0.x
mul r0.x, r1.w, r7.w
mul r0.x, r0, r7.w
rcp r0.y, r0.x
add r0.x, -r1.w, c17.z
mul r5.w, r0.x, r0.y
pow r0, c17.x, -r5.w
mul r4.w, r7, r7
mul r0.y, r1.w, r4.w
mul r0.y, r1.w, r0
mul r0.w, r0.y, c21.z
mov r1.w, r0.x
add r0.xyz, -r1, r3
rcp r0.w, r0.w
mul r0.y, r0, r0
mad r0.y, r0.x, r0.x, r0
dp3 r0.x, r2, r6
mul r10.x, r1.w, r0.w
max r6.x, r0, c15
mad r0.y, r0.z, r0.z, r0
rsq r0.x, r0.y
add r0.y, -r6.w, -r3.w
rcp r0.x, r0.x
add r1.y, -r8.w, c17.z
mul r0.x, r0, c7
add r0.y, r0, c13.x
mul r0.y, r0.x, r0
mul r0.x, r6, r6
mul r0.x, r0, r0.y
mul r1.x, r0, r0.y
pow r0, r1.y, c21.w
mul r0.y, r1.x, c14
pow r1, c17.x, -r0.y
mov_pp r0.y, c9.x
mov r0.z, r0.x
add_pp r5.w, c17.z, -r0.y
mov r0.x, r1
mad r11.x, -r0, c17.y, c17.z
mul r9.w, r6.x, r11.x
mul r0.x, r7.y, r7.y
mad r1.w, r0.z, c9.x, r5
mad r1.y, r7.x, r7.x, r0.x
add_sat r1.x, -r9.w, c17.z
pow r0, r1.x, c17.w
mad r0.y, r7.z, r7.z, r1
rsq r0.y, r0.y
rcp r0.z, r0.y
mov r10.y, r0.x
add r0.xy, r7, -r3
mul r0.z, r2.w, r0
mul r0.xy, r6.w, r0
mul r1.xy, r0, r0.z
mad r0.xyz, v4, r10.z, c6
mad r1.xy, -r1, c18.x, v0
texld r6, r1, s6
mad r1.xyz, v4, r10.z, c4
texld r0.x, r0, s5
mov_pp r0.w, r0.x
mad r0.xyz, v4, r10.z, c5
texld r0.x, r0, s5
texld r1.x, r1, s5
mov_pp r0.z, r0.x
mov_pp r0.y, r1.x
mad r1.xyz, v4, r10.z, c3
mov r0.x, c2
add r10.z, c17, -r0.x
texld r0.x, r1, s5
mad r0, r0, r10.z, c2.x
dp4_pp r0.z, r0, c18.w
rcp r1.x, v3.w
mad r1.xy, v3, r1.x, c14.y
texld r0.w, r1, s3
dp3 r1.x, r7, r3
dp3 r0.x, v3, v3
cmp r0.y, -v3.z, c18, c18.z
mul_pp r0.y, r0, r0.w
texld r0.x, r0.x, s4
mul_pp r0.x, r0.y, r0
mul_pp r10.w, r0.x, r0.z
mul r0.x, r10.y, r6.w
mul r0.w, r10.x, r1
mul r10.xyz, r8, r3.w
add r8.xyz, r3, -r10
mul r0.x, r0, r10.w
mul_sat r1.w, r0.x, c19.x
dp3_pp r10.z, r2, r3
mul_pp r0.xyz, r6, c0
mul_sat r1.x, r1, c12
mul r0.xyz, r1.x, r0
add r1.x, -r1, c17.z
mad r0.xyz, r1.x, c0, r0
mul r1.xyz, r1.w, r6
texld r6, v0, s0
mul r1.xyz, r1, c11
add r1.w, -r1, c17.z
mad r0.xyz, r1.w, r0, r1
mul_pp r6.xyz, r6, c8
mul_pp r7.xyz, r6, r0
dp3_pp r0.y, r2, r5
mul r0.x, r6.w, r0.w
rcp r12.x, r0.y
mul_sat r11.y, r0.x, r12.x
dp3 r0.x, r8, r8
mul r1.x, r8.w, r0.y
rsq r0.y, r0.x
dp3_pp r0.x, r9, r5
rcp r0.w, r0.x
mul r9.xyz, r0.y, r8
add r0.xyz, r5, r9
mul r1.x, r1, r0.w
dp3 r1.y, r0, r0
rsq r1.y, r1.y
mul r0.xyz, r1.y, r0
dp3 r12.y, r2, r0
abs r0.y, r12
mul r1.y, r8.w, r10.z
mul r0.x, r0.w, r1.y
add r0.w, -r0.y, c17.z
mad r0.z, r0.y, c19.y, c19
mad r0.z, r0, r0.y, c19.w
mad r0.y, r0.z, r0, c20.x
rsq r0.w, r0.w
rcp r0.w, r0.w
mul r0.y, r0, r0.w
cmp r0.z, r12.y, c18.y, c18
mul r0.w, r0.z, r0.y
mul r1.x, r1, c13
mul r0.x, r0, c13
min_sat r11.w, r1.x, r0.x
mad r0.x, -r0.w, c13, r0.y
mad r0.z, r0, c20.y, r0.x
max r0.y, r8.w, c15.x
mov_pp r0.x, c9
mul_pp r8.w, c22.x, r0.x
mad r0.z, r0, c20, c20.w
pow r1, r0.y, r8.w
frc r0.x, r0.z
mad r1.y, r0.x, c14.z, c14.w
sincos r0.xy, r1.y
mov r0.y, r1.x
mul r1.w, r0.x, r0.x
mul r0.y, r6.w, r0
mul r0.x, r0.y, c14.y
mul r0.y, r7.w, r1.w
mul r0.y, r7.w, r0
mad r0.x, r11.y, r11.w, r0
mul_sat r7.w, r11.x, r0.x
mov_pp r1.xyz, c0
mul_pp r1.xyz, c1, r1
mul r4.w, r4, r1
add r0.x, -r1.w, c17.z
rcp r0.y, r0.y
mul r11.x, r0, r0.y
pow r0, c17.x, -r11.x
mul r11.xyz, r1, r7.w
mad r7.xyz, r7, r9.w, r11
mov r7.w, r0.x
add r9.w, -r12.y, c17.z
pow r0, r9.w, c21.w
mul r0.y, r1.w, r4.w
mul_pp r1.w, r10, c13.x
mov r0.z, r0.x
mul r0.y, r0, c21.z
rcp r0.x, r0.y
mad r0.y, r0.z, c9.x, r5.w
mul r0.x, r7.w, r0
mul r0.x, r0, r0.y
mul r0.x, r6.w, r0
mul_sat r4.w, r12.x, r0.x
max r5.w, r12.y, c15.x
pow r0, r5.w, r8.w
mul r4.y, r4, r4
mad r0.y, r4.x, r4.x, r4
mad r0.z, r4, r4, r0.y
dp3 r0.y, r2, r9
max r4.x, r0.y, c15
rsq r0.z, r0.z
rcp r0.y, r0.z
mov r0.w, r0.x
mul r0.y, r0, c7.x
add r0.z, -r3.w, c17
mul r0.z, r0.y, r0
mul r0.y, r4.x, r4.x
mul r0.y, r0, r0.z
mul r0.x, r0.y, r0.z
mul r0.y, r6.w, r0.w
mul r4.y, r0.x, c14
mul r4.z, r0.y, c14.y
pow r0, c17.x, -r4.y
mad r0.z, r11.w, r4.w, r4
mad r0.x, -r0, c17.y, c17.z
mul r5.w, r4.x, r0.x
mul_sat r0.z, r0.x, r0
mul r0.y, r8, r8
mad r0.y, r8.x, r8.x, r0
mad r0.y, r8.z, r8.z, r0
rsq r0.y, r0.y
mul r9.xyz, r1, r0.z
rcp r0.x, r0.y
mul r0.z, r2.w, r0.x
mul r0.xy, r3.w, -r10
mul r4.xy, r0, r0.z
add_sat r4.z, -r5.w, c17
pow r0, r4.z, c17.w
dp3 r0.y, r3, r8
mad r4.xy, -r4, c18.x, v0
texld r4, r4, s6
mov r0.w, r0.x
mul r0.w, r0, r4
mul r0.w, r10, r0
mul_sat r0.w, r0, c19.x
mul_sat r0.y, r0, c12.x
mul_pp r8.xyz, r4, c0
mul r8.xyz, r0.y, r8
add r0.y, -r0, c17.z
mad r8.xyz, r0.y, c0, r8
add_pp r0.xyz, r3, r5
dp3_pp r2.w, r0, r0
rsq_pp r2.w, r2.w
mul_pp r0.xyz, r2.w, r0
dp3_pp r2.x, r2, r0
add r2.w, -r0, c17.z
mul r0.xyz, r0.w, r4
max_pp r3.x, r2, c15
mul r2.xyz, r0, c11
pow r0, r3.x, r8.w
mov r0.w, r0.x
mad r2.xyz, r2.w, r8, r2
mul_pp r2.xyz, r6, r2
mad r0.xyz, r2, r5.w, r9
mul_sat r0.w, r6, r0
mul r2.xyz, r1, r0.w
mul r0.xyz, r1.w, r0
max_pp r0.w, r10.z, c15.x
mul_pp r1.xyz, r6, c0
mad r1.xyz, r1, r0.w, r2
texld r0.w, v0, s1
add_sat r0.w, r0, c10.x
mul r2.xyz, r1.w, r1
mul_pp r1.xyz, r0.w, r0
add_pp r0.x, -r0.w, c17.z
mul r7.xyz, r7, r1.w
mul_pp r2.xyz, r0.w, r2
mad_pp r1.xyz, r0.x, r7, r1
mad_pp oC0.xyz, r1, r0.x, r2
mov_pp oC0.w, c15.x
"
}
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Vector 0 [_LightPositionRange]
Vector 1 [_LightColor0]
Vector 2 [_SpecColor]
Vector 3 [_LightShadowData]
Float 4 [_GVar]
Vector 5 [_Color]
Float 6 [_Shininess]
Float 7 [_BlendAdjust1]
Vector 8 [_SSSC]
Float 9 [_Smoothness]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_ScatterMap] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_ShadowMapTexture] CUBE
SetTexture 4 [_LightTexture0] 2D
SetTexture 5 [_ExitColorMap] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 305 ALU, 10 TEX
PARAM c[19] = { program.local[0..9],
		{ 0, 1, 2, 0.1 },
		{ 0.73550957, -0.73550957, 0, -1 },
		{ 0.99270076, -0.99270076, 0.44999999, 2.718282 },
		{ 0.5, 0.39894229, 3.5, 0.001 },
		{ 0.97000003, 0.0078125, -0.0078125, 0.25 },
		{ 1, 0.0039215689, 1.53787e-005, 6.2273724e-009 },
		{ 7, 3.141593, -0.018729299, 0.074261002 },
		{ 0.21211439, 1.570729, 1.3, 0.69999999 },
		{ 3.1415927, 5, 128 } };
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
TEMP R11;
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.x, R0.x;
MUL R4.xyz, R0.x, fragment.texcoord[1];
MUL R0.x, R4.y, R4.y;
MAD R0.x, R4, R4, R0;
MAD R0.x, R4.z, R4.z, R0;
RSQ R3.w, R0.x;
MUL R0.y, R3.w, -R4.z;
MUL R0.x, R0.y, c[11];
COS R0.z, R0.x;
DP3 R0.x, R4, R4;
MAD R0.y, R0, c[11], R0.z;
MOV R11.xy, c[10].ywzw;
MUL R1.xy, R0.y, c[11].zwzw;
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, R4;
MAD R5.xyz, R0, c[11].x, R1.xxyw;
MUL R0.x, R5.y, R5.y;
MAD R0.x, R5, R5, R0;
MAD R0.x, R5.z, R5.z, R0;
RSQ R0.x, R0.x;
MUL R0.y, R0.x, -R5.z;
MUL R0.x, R0.y, c[12];
COS R0.z, R0.x;
MAD R0.y, R0, c[12], R0.z;
DP3 R0.x, R5, R5;
RSQ R0.x, R0.x;
MUL R6.xyz, R0.x, R5;
ADD R5.xyz, -R5, R4;
MUL R0.zw, R0.y, c[11];
MAD R2.xyz, R6, c[12].x, R0.zzww;
DP3 R0.x, R2, R2;
MOV R0.w, c[12].z;
MUL R4.w, R0, c[9].x;
MUL R5.y, R5, R5;
MAD R5.x, R5, R5, R5.y;
MAD R5.y, R5.z, R5.z, R5.x;
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, R2;
ADD R2.xyz, -R2, R4;
MUL R2.y, R2, R2;
MAD R2.x, R2, R2, R2.y;
MUL R0.w, R11.y, c[9].x;
MAD R1.xyz, R6, -R4.w, R4;
MAD R0.xyz, -R0.w, R0, R1;
TEX R1.yw, fragment.texcoord[0].zwzw, texture[2], 2D;
MAD R3.xy, R1.wyzw, c[10].z, -c[10].y;
ADD R2.y, -R0.w, -R4.w;
DP3 R1.x, R0, R0;
MUL R1.w, R3.y, R3.y;
MAD R1.w, -R3.x, R3.x, -R1;
MAD R2.x, R2.z, R2.z, R2;
RSQ R1.x, R1.x;
ADD R1.w, R1, c[10].y;
RSQ R1.w, R1.w;
RSQ R2.x, R2.x;
RCP R2.x, R2.x;
RCP R3.z, R1.w;
MUL R1.xyz, R1.x, R0;
DP3 R1.w, R3, R1;
MAX R1.w, R1, c[10].x;
MUL R2.x, R2, c[4];
ADD R2.y, R2, c[10].z;
MUL R2.y, R2.x, R2;
MUL R2.x, R1.w, R1.w;
MUL R2.x, R2, R2.y;
MUL R2.x, R2, R2.y;
MUL R2.y, R0, R0;
MAD R2.y, R0.x, R0.x, R2;
MAD R2.y, R0.z, R0.z, R2;
RSQ R2.y, R2.y;
RCP R2.z, R2.y;
MUL R2.x, R2, c[13];
POW R2.x, c[12].w, -R2.x;
MUL R2.x, -R2, c[13].y;
ADD R6.w, R2.x, c[10].y;
MUL R5.w, R1, R6;
ADD R2.xy, R0, -R4;
DP3 R1.w, R0, R4;
MUL R2.xy, R0.w, R2;
MUL R2.z, R3.w, R2;
MUL R2.xy, R2, R2.z;
MAD R2.xy, -R2, c[13].w, fragment.texcoord[0];
TEX R2, R2, texture[5], 2D;
ADD_SAT R0.w, -R5, c[10].y;
MUL R0.xyz, R2, c[1];
MUL_SAT R1.w, R1, c[9].x;
MUL R0.xyz, R1.w, R0;
ADD R1.w, -R1, c[10].y;
MAD R7.xyz, R1.w, c[1], R0;
POW R0.x, R0.w, c[13].z;
DP3 R0.y, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.w, R0.y;
MUL R9.xyz, R0.w, fragment.texcoord[2];
ADD R10.xyz, R1, R9;
MUL R2.w, R0.x, R2;
ADD R0.xyz, fragment.texcoord[4], c[14].yzzw;
TEX R0, R0, texture[3], CUBE;
DP4 R8.w, R0, c[15];
ADD R0.xyz, fragment.texcoord[4], c[14].zyzw;
TEX R0, R0, texture[3], CUBE;
DP4 R8.z, R0, c[15];
ADD R1.xyz, fragment.texcoord[4], c[14].zzyw;
TEX R1, R1, texture[3], CUBE;
DP4 R8.y, R1, c[15];
DP3 R0.w, fragment.texcoord[4], fragment.texcoord[4];
RSQ R1.x, R0.w;
ADD R0.xyz, fragment.texcoord[4], c[14].y;
TEX R0, R0, texture[3], CUBE;
DP4 R8.x, R0, c[15];
RCP R1.x, R1.x;
MUL R0.x, R1, c[0].w;
MAD R0, -R0.x, c[14].x, R8;
CMP R0, R0, c[3].x, R11.x;
DP4 R0.x, R0, c[14].w;
DP3 R1.y, R10, R10;
DP3 R1.x, fragment.texcoord[3], fragment.texcoord[3];
TEX R0.w, R1.x, texture[4], 2D;
MUL R1.w, R0, R0.x;
MUL R0.x, R2.w, R1.w;
RSQ R0.y, R1.y;
MUL R1.xyz, R0.y, R10;
DP3 R7.w, R3, R1;
MUL_SAT R0.w, R0.x, c[16].x;
MUL R0.xyz, R0.w, R2;
DP3 R1.x, R1, R9;
MUL R10.xyz, R6, R4.w;
ABS R2.w, R7;
MUL R0.xyz, R0, c[8];
ADD R0.w, -R0, c[10].y;
MAD R2.xyz, R0.w, R7, R0;
ADD R0.y, -R2.w, c[10];
MAD R0.x, R2.w, c[16].z, c[16].w;
MAD R0.x, R0, R2.w, -c[17];
MAD R0.x, R0, R2.w, c[17].y;
RSQ R0.y, R0.y;
RCP R0.y, R0.y;
MUL R7.x, R0, R0.y;
TEX R0, fragment.texcoord[0], texture[0], 2D;
SLT R2.w, R7, c[10].x;
MUL R7.y, R2.w, R7.x;
MAD R7.x, -R7.y, c[10].z, R7;
MUL R0.xyz, R0, c[5];
MAD R2.w, R2, c[16].y, R7.x;
MOV R7.y, c[9].x;
MAD R11.x, R7.y, c[17].z, c[17].w;
COS R2.w, R2.w;
MUL R2.w, R2, R2;
MUL R9.w, R11.x, R11.x;
MUL R7.x, R2.w, R11;
MUL R7.x, R7, R11;
MUL R7.y, R2.w, R9.w;
MUL R7.y, R2.w, R7;
RCP R1.x, R1.x;
MUL R2.xyz, R0, R2;
MUL R7.y, R7, c[18].x;
RCP R7.x, R7.x;
ADD R2.w, -R2, c[10].y;
MUL R2.w, R2, R7.x;
RCP R7.x, R7.y;
MOV R7.y, c[10];
ADD R10.w, R7.y, -c[6].x;
DP3 R7.y, R3, R9;
MUL R1.y, R7.w, R7;
MUL R1.y, R1, R1.x;
POW R2.w, c[12].w, -R2.w;
MUL R2.w, R2, R7.x;
ADD R7.x, -R7.w, c[10].y;
POW R7.x, R7.x, c[18].y;
MAD R7.x, R7, c[6], R10.w;
MUL R2.w, R2, R7.x;
RCP R8.w, R7.y;
MUL R2.w, R0, R2;
MUL_SAT R11.z, R2.w, R8.w;
ADD R7.xyz, R4, -R10;
MUL R6.x, R1.y, c[10].z;
DP3 R1.y, R7, R7;
RSQ R1.z, R1.y;
DP3 R2.w, R3, R4;
MUL R8.xyz, R1.z, R7;
MUL R1.y, R7.w, R2.w;
MUL R6.y, R1.x, R1;
DP3 R5.x, R3, R8;
ADD R1.xyz, R9, R8;
MUL R6.y, R6, c[10].z;
MIN_SAT R10.z, R6.x, R6.y;
DP3 R6.z, R1, R1;
RSQ R6.y, R6.z;
MUL R1.xyz, R6.y, R1;
DP3 R11.y, R3, R1;
ABS R1.y, R11;
MAD R1.z, R1.y, c[16], c[16].w;
MAD R1.z, R1, R1.y, -c[17].x;
MAX R5.z, R5.x, c[10].x;
RSQ R5.y, R5.y;
RCP R5.x, R5.y;
MAX R6.x, R7.w, c[10];
MOV R6.y, c[18].z;
MUL R7.w, R6.y, c[6].x;
POW R1.x, R6.x, R7.w;
ADD R6.x, -R1.y, c[10].y;
MUL R1.x, R0.w, R1;
RSQ R6.x, R6.x;
MUL R1.x, R1, c[13];
MAD R1.y, R1.z, R1, c[17];
RCP R6.x, R6.x;
MUL R1.z, R1.y, R6.x;
SLT R1.y, R11, c[10].x;
MUL R6.x, R1.y, R1.z;
MAD R1.z, -R6.x, c[10], R1;
MAD R1.y, R1, c[16], R1.z;
MAD R1.x, R11.z, R10.z, R1;
MUL_SAT R6.x, R6.w, R1;
COS R1.y, R1.y;
MUL R6.w, R1.y, R1.y;
MUL R11.z, R11.x, R6.w;
MOV R1.xyz, c[2];
MUL R1.xyz, R1, c[1];
MUL R6.xyz, R1, R6.x;
MAD R2.xyz, R2, R5.w, R6;
MUL R11.x, R11, R11.z;
ADD R6.y, -R11, c[10];
POW R6.y, R6.y, c[18].y;
RCP R6.x, R11.x;
ADD R5.w, -R6, c[10].y;
MUL R5.w, R5, R6.x;
MUL R6.x, R9.w, R6.w;
MUL R6.x, R6.w, R6;
MUL R6.w, R1, c[10].z;
MUL R6.x, R6, c[18];
RCP R6.x, R6.x;
POW R5.w, c[12].w, -R5.w;
MUL R5.w, R5, R6.x;
MAD R6.y, R6, c[6].x, R10.w;
MUL R5.w, R5, R6.y;
MUL R5.w, R0, R5;
MAX R6.x, R11.y, c[10];
POW R6.x, R6.x, R7.w;
MUL R6.x, R0.w, R6;
MUL_SAT R5.w, R8, R5;
MUL R6.x, R6, c[13];
ADD R5.y, -R4.w, c[10];
MUL R5.x, R5, c[4];
MUL R5.y, R5.x, R5;
MUL R5.x, R5.z, R5.z;
MUL R5.x, R5, R5.y;
MUL R5.x, R5, R5.y;
MUL R5.y, R7, R7;
MAD R5.y, R7.x, R7.x, R5;
MAD R5.y, R7.z, R7.z, R5;
MUL R5.x, R5, c[13];
POW R5.x, c[12].w, -R5.x;
MAD R6.x, R10.z, R5.w, R6;
MUL R5.x, -R5, c[13].y;
ADD R5.w, R5.x, c[10].y;
RSQ R5.y, R5.y;
MUL_SAT R6.x, R5.w, R6;
RCP R5.x, R5.y;
MUL R3.w, R3, R5.x;
MUL R5.xy, R4.w, -R10;
MUL R5.xy, R5, R3.w;
MUL R3.w, R5.z, R5;
MAD R5.xy, -R5, c[13].w, fragment.texcoord[0];
ADD_SAT R4.w, -R3, c[10].y;
TEX R5, R5, texture[5], 2D;
POW R4.w, R4.w, c[13].z;
MUL R4.w, R4, R5;
DP3 R5.w, R4, R7;
MUL R1.w, R1, R4;
MUL_SAT R1.w, R1, c[16].x;
MUL R7.xyz, R5, c[1];
MUL_SAT R5.w, R5, c[9].x;
MUL R7.xyz, R5.w, R7;
ADD R5.w, -R5, c[10].y;
MUL R5.xyz, R1.w, R5;
MUL R6.xyz, R1, R6.x;
MAD R7.xyz, R5.w, c[1], R7;
ADD R4.xyz, R4, R9;
DP3 R5.w, R4, R4;
RSQ R5.w, R5.w;
ADD R4.w, -R1, c[10].y;
MUL R4.xyz, R5.w, R4;
DP3 R1.w, R3, R4;
MUL R5.xyz, R5, c[8];
MAD R3.xyz, R4.w, R7, R5;
MUL R3.xyz, R0, R3;
MAX R1.w, R1, c[10].x;
POW R1.w, R1.w, R7.w;
MUL_SAT R0.w, R0, R1;
MUL R1.xyz, R1, R0.w;
MAD R3.xyz, R3, R3.w, R6;
MUL R3.xyz, R6.w, R3;
MAX R0.w, R2, c[10].x;
MUL R0.xyz, R0, c[1];
MAD R0.xyz, R0, R0.w, R1;
MUL R4.xyz, R6.w, R0;
TEX R0.w, fragment.texcoord[0], texture[1], 2D;
ADD_SAT R0.x, R0.w, c[7];
MUL R1.xyz, R0.x, R3;
MUL R3.xyz, R0.x, R4;
ADD R0.x, -R0, c[10].y;
MUL R2.xyz, R2, R6.w;
MAD R1.xyz, R0.x, R2, R1;
MAD result.color.xyz, R1, R0.x, R3;
MOV result.color.w, c[10].x;
END
# 305 instructions, 12 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Vector 0 [_LightPositionRange]
Vector 1 [_LightColor0]
Vector 2 [_SpecColor]
Vector 3 [_LightShadowData]
Float 4 [_GVar]
Vector 5 [_Color]
Float 6 [_Shininess]
Float 7 [_BlendAdjust1]
Vector 8 [_SSSC]
Float 9 [_Smoothness]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_ScatterMap] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_ShadowMapTexture] CUBE
SetTexture 4 [_LightTexture0] 2D
SetTexture 5 [_ExitColorMap] 2D
"ps_3_0
; 364 ALU, 10 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_cube s3
dcl_2d s4
dcl_2d s5
def c10, 2.00000000, -1.00000000, 0.10000000, -0.73550957
def c11, 0.11705996, 0.50000000, 6.28318501, -3.14159298
def c12, 0.00000000, -1.00000000, 0.73550957, -0.99270076
def c13, 0.15799320, 0.50000000, 0.99270076, 0.44999999
def c14, 2.71828198, 0.39894229, 1.00000000, 3.50000000
def c15, 0.00100000, 0.00781250, -0.00781250, 0.97000003
def c16, 1.00000000, 0.00392157, 0.00001538, 0.00000001
def c17, 0.25000000, 7.00000000, 0.00000000, 1.00000000
def c18, -0.01872930, 0.07426100, -0.21211439, 1.57072902
def c19, 3.14159298, 0.15915491, 0.50000000, 3.14159274
def c20, 1.29999995, 0.69999999, 5.00000000, 128.00000000
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
mad r0.x, r1, c11, c11.y
frc r0.x, r0
mad r1.y, r0.x, c11.z, c11.w
sincos r0.xy, r1.y
mad r0.z, r1.x, c10.w, r0.x
dp3 r0.y, r4, r4
mul r1.xy, r0.z, c12
rsq r0.x, r0.y
mul r0.xyz, r0.x, r4
mad r5.xyz, r0, c12.z, r1.xxyw
mul r0.x, r5.y, r5.y
mad r0.x, r5, r5, r0
mad r0.x, r5.z, r5.z, r0
rsq r0.x, r0.x
mul r1.x, r0, -r5.z
mad r0.x, r1, c13, c13.y
frc r0.x, r0
mad r1.y, r0.x, c11.z, c11.w
sincos r0.xy, r1.y
mad r0.z, r1.x, c12.w, r0.x
dp3 r0.y, r5, r5
rsq r0.x, r0.y
mul r6.xyz, r0.x, r5
add r5.xyz, -r5, r4
mul r0.zw, r0.z, c12.xyxy
mad r1.xyz, r6, c13.z, r0.zzww
dp3 r0.x, r1, r1
mov r0.w, c9.x
mul r4.w, c13, r0
mov r0.w, c9.x
rsq r0.x, r0.x
mul r0.xyz, r0.x, r1
mad r2.xyz, r6, -r4.w, r4
mul r2.w, c10.z, r0
mad r7.xyz, -r2.w, r0, r2
dp3 r0.x, r7, r7
texld r0.yw, v0.zwzw, s2
mad_pp r3.xy, r0.wyzw, c10.x, c10.y
rsq r0.x, r0.x
mul r2.xyz, r0.x, r7
mul_pp r0.w, r3.y, r3.y
mad_pp r0.w, -r3.x, r3.x, -r0
dp3_pp r0.x, v2, v2
rsq_pp r0.x, r0.x
mul_pp r9.xyz, r0.x, v2
add r0.xyz, r2, r9
dp3 r1.w, r0, r0
rsq r1.w, r1.w
add_pp r0.w, r0, c14.z
rsq_pp r0.w, r0.w
rcp_pp r3.z, r0.w
mul r10.xyz, r1.w, r0
dp3 r6.w, r3, r10
abs r0.x, r6.w
add r0.z, -r0.x, c14
mad r0.y, r0.x, c18.x, c18
mad r0.y, r0, r0.x, c18.z
rsq r0.z, r0.z
mad r0.x, r0.y, r0, c18.w
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r0.x, r6.w, c17.z, c17.w
mul r0.z, r0.x, r0.y
mad r0.y, -r0.z, c10.x, r0
mad r0.x, r0, c19, r0.y
mad r0.x, r0, c19.y, c19.z
frc r0.x, r0
mad r1.w, r0.x, c11.z, c11
sincos r0.xy, r1.w
mov r0.y, c9.x
mad r7.w, r0.y, c20.x, c20.y
mul r1.w, r0.x, r0.x
mul r0.x, r1.w, r7.w
mul r0.x, r0, r7.w
rcp r0.y, r0.x
add r0.x, -r1.w, c14.z
mul r8.x, r0, r0.y
pow r0, c14.x, -r8.x
mul r5.w, r7, r7
mul r0.y, r1.w, r5.w
mul r0.y, r1.w, r0
mul r0.w, r0.y, c19
mov r1.w, r0.x
add r0.xyz, -r1, r4
rcp r0.w, r0.w
mul r0.y, r0, r0
mad r0.y, r0.x, r0.x, r0
dp3 r0.x, r3, r2
mul r11.x, r1.w, r0.w
max r2.x, r0, c12
mad r0.y, r0.z, r0.z, r0
rsq r0.x, r0.y
add r0.y, -r2.w, -r4.w
rcp r0.x, r0.x
add r1.y, -r6.w, c14.z
mul r0.x, r0, c4
add r0.y, r0, c10.x
mul r0.y, r0.x, r0
mul r0.x, r2, r2
mul r0.x, r0, r0.y
mul r1.x, r0, r0.y
pow r0, r1.y, c20.z
mul r0.y, r1.x, c11
pow r1, c14.x, -r0.y
mov_pp r0.y, c6.x
mov r0.z, r0.x
mov r0.x, r1
mad r11.w, -r0.x, c14.y, c14.z
mul r10.w, r2.x, r11
add_pp r9.w, c14.z, -r0.y
mul r0.x, r7.y, r7.y
mad r1.y, r7.x, r7.x, r0.x
mad r11.y, r0.z, c6.x, r9.w
add_sat r1.x, -r10.w, c14.z
pow r0, r1.x, c14.w
mad r0.y, r7.z, r7.z, r1
rsq r0.y, r0.y
rcp r0.z, r0.y
mov r11.z, r0.x
add r0.xy, r7, -r4
mul r0.z, r3.w, r0
mul r0.xy, r2.w, r0
mul r1.xy, r0, r0.z
add r0.xyz, v4, c15.yzzw
texld r0, r0, s3
dp4 r8.w, r0, c16
mad r1.xy, -r1, c15.x, v0
add r0.xyz, v4, c15.zyzw
texld r0, r0, s3
dp4 r8.z, r0, c16
add r2.xyz, v4, c15.zzyw
texld r2, r2, s3
dp4 r8.y, r2, c16
add r0.xyz, v4, c15.y
texld r0, r0, s3
dp3 r2.x, v4, v4
texld r1, r1, s5
dp4 r8.x, r0, c16
rsq r2.x, r2.x
rcp r0.x, r2.x
mul r0.x, r0, c0.w
mad r0, -r0.x, c15.w, r8
mov r2.x, c3
cmp r2, r0, c14.z, r2.x
dp4_pp r0.y, r2, c17.x
dp3 r2.x, r7, r4
dp3 r0.x, v3, v3
texld r0.x, r0.x, s4
mul r2.w, r0.x, r0.y
mul r0.x, r11.z, r1.w
mul r0.x, r0, r2.w
mul_sat r0.w, r0.x, c17.y
mul r1.w, r11.x, r11.y
mul r11.xyz, r6, r4.w
dp3_pp r8.w, r3, r4
add r7.x, -r0.w, c14.z
mul_pp r0.xyz, r1, c1
mul_sat r2.x, r2, c9
mul r0.xyz, r2.x, r0
add r2.x, -r2, c14.z
mad r2.xyz, r2.x, c1, r0
mul r0.xyz, r0.w, r1
mul r1.xyz, r0, c8
mad r1.xyz, r7.x, r2, r1
texld r0, v0, s0
mul_pp r0.xyz, r0, c5
mul_pp r2.xyz, r0, r1
dp3_pp r1.y, r3, r9
add r7.xyz, r4, -r11
mul r1.x, r0.w, r1.w
rcp r12.y, r1.y
mul_sat r12.w, r1.x, r12.y
dp3 r1.x, r7, r7
mul r6.x, r6.w, r1.y
rsq r1.y, r1.x
dp3_pp r1.x, r10, r9
rcp r1.w, r1.x
mul r8.xyz, r1.y, r7
add r1.xyz, r9, r8
mul r6.x, r6, r1.w
dp3 r6.y, r1, r1
rsq r6.y, r6.y
mul r1.xyz, r6.y, r1
dp3 r12.z, r3, r1
abs r1.y, r12.z
mul r6.y, r6.w, r8.w
mul r1.x, r1.w, r6.y
add r1.w, -r1.y, c14.z
mad r1.z, r1.y, c18.x, c18.y
mad r1.z, r1, r1.y, c18
mad r1.y, r1.z, r1, c18.w
rsq r1.w, r1.w
rcp r1.w, r1.w
mul r1.y, r1, r1.w
cmp r1.z, r12, c17, c17.w
mul r1.w, r1.z, r1.y
mul r6.x, r6, c10
mul r1.x, r1, c10
min_sat r12.x, r6, r1
mad r1.x, -r1.w, c10, r1.y
mad r1.z, r1, c19.x, r1.x
mov_pp r1.x, c6
mul_pp r11.z, c20.w, r1.x
max r1.y, r6.w, c12.x
mad r1.z, r1, c19.y, c19
pow r6, r1.y, r11.z
frc r1.x, r1.z
mad r6.y, r1.x, c11.z, c11.w
sincos r1.xy, r6.y
mov r1.y, r6.x
mul r6.w, r1.x, r1.x
mul r1.y, r0.w, r1
mul r1.x, r1.y, c11.y
mul r1.y, r7.w, r6.w
mul r1.y, r7.w, r1
mad r1.x, r12.w, r12, r1
mul_sat r7.w, r11, r1.x
mov_pp r6.xyz, c1
mul r5.w, r5, r6
add r1.x, -r6.w, c14.z
rcp r1.y, r1.y
mul r10.x, r1, r1.y
pow r1, c14.x, -r10.x
mul_pp r6.xyz, c2, r6
mul r10.xyz, r6, r7.w
mad r2.xyz, r2, r10.w, r10
mov r7.w, r1.x
add r10.x, -r12.z, c14.z
pow r1, r10.x, c20.z
mul r1.y, r6.w, r5.w
mul_pp r6.w, r2, c10.x
mov r1.z, r1.x
mul r1.y, r1, c19.w
rcp r1.x, r1.y
mul r1.x, r7.w, r1
mad r1.y, r1.z, c6.x, r9.w
mul r1.x, r1, r1.y
mul r1.x, r0.w, r1
mul_sat r5.w, r12.y, r1.x
max r7.w, r12.z, c12.x
pow r1, r7.w, r11.z
mul r5.y, r5, r5
mad r1.y, r5.x, r5.x, r5
mad r1.z, r5, r5, r1.y
dp3 r1.y, r3, r8
max r5.x, r1.y, c12
rsq r1.z, r1.z
rcp r1.y, r1.z
mov r1.w, r1.x
mul r1.y, r1, c4.x
add r1.z, -r4.w, c14
mul r1.z, r1.y, r1
mul r1.y, r5.x, r5.x
mul r1.y, r1, r1.z
mul r1.x, r1.y, r1.z
mul r1.y, r0.w, r1.w
mul r5.y, r1.x, c11
mul r5.z, r1.y, c11.y
pow r1, c14.x, -r5.y
mad r1.z, r12.x, r5.w, r5
mad r1.x, -r1, c14.y, c14.z
mul r7.w, r5.x, r1.x
mul_sat r1.z, r1.x, r1
mul r1.y, r7, r7
mad r1.y, r7.x, r7.x, r1
mad r1.y, r7.z, r7.z, r1
rsq r1.y, r1.y
mul r8.xyz, r6, r1.z
rcp r1.x, r1.y
mul r1.z, r3.w, r1.x
mul r1.xy, r4.w, -r11
mul r5.xy, r1, r1.z
add_sat r5.z, -r7.w, c14
pow r1, r5.z, c14.w
dp3 r1.y, r4, r7
mad r5.xy, -r5, c15.x, v0
texld r5, r5, s5
mov r1.w, r1.x
mul r1.w, r1, r5
mul r1.w, r2, r1
mul_sat r1.w, r1, c17.y
mul_sat r1.y, r1, c9.x
mul_pp r7.xyz, r5, c1
mul r7.xyz, r1.y, r7
add r1.y, -r1, c14.z
mad r7.xyz, r1.y, c1, r7
add_pp r1.xyz, r4, r9
dp3_pp r3.w, r1, r1
rsq_pp r2.w, r3.w
mul_pp r1.xyz, r2.w, r1
dp3_pp r3.x, r3, r1
add r2.w, -r1, c14.z
mul r1.xyz, r1.w, r5
max_pp r3.w, r3.x, c12.x
mul r3.xyz, r1, c8
pow r1, r3.w, r11.z
mov r1.w, r1.x
mad r3.xyz, r2.w, r7, r3
mul_pp r3.xyz, r0, r3
mad r1.xyz, r3, r7.w, r8
mul_sat r0.w, r0, r1
mul r3.xyz, r6, r0.w
max_pp r0.w, r8, c12.x
mul_pp r0.xyz, r0, c1
mad r0.xyz, r0, r0.w, r3
mul r3.xyz, r6.w, r0
texld r0.w, v0, s1
add_sat r0.x, r0.w, c7
mul r1.xyz, r6.w, r1
mul_pp r1.xyz, r0.x, r1
mul_pp r3.xyz, r0.x, r3
add_pp r0.x, -r0, c14.z
mul r2.xyz, r2, r6.w
mad_pp r1.xyz, r0.x, r2, r1
mad_pp oC0.xyz, r1, r0.x, r3
mov_pp oC0.w, c12.x
"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Vector 0 [_LightPositionRange]
Vector 1 [_LightColor0]
Vector 2 [_SpecColor]
Vector 3 [_LightShadowData]
Float 4 [_GVar]
Vector 5 [_Color]
Float 6 [_Shininess]
Float 7 [_BlendAdjust1]
Vector 8 [_SSSC]
Float 9 [_Smoothness]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_ScatterMap] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_ShadowMapTexture] CUBE
SetTexture 4 [_LightTextureB0] 2D
SetTexture 5 [_LightTexture0] CUBE
SetTexture 6 [_ExitColorMap] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 307 ALU, 11 TEX
PARAM c[19] = { program.local[0..9],
		{ 0, 1, 2, 0.1 },
		{ 0.73550957, -0.73550957, 0, -1 },
		{ 0.99270076, -0.99270076, 0.44999999, 2.718282 },
		{ 0.5, 0.39894229, 3.5, 0.001 },
		{ 0.97000003, 0.0078125, -0.0078125, 0.25 },
		{ 1, 0.0039215689, 1.53787e-005, 6.2273724e-009 },
		{ 7, 3.141593, -0.018729299, 0.074261002 },
		{ 0.21211439, 1.570729, 1.3, 0.69999999 },
		{ 3.1415927, 5, 128 } };
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
TEMP R11;
MOV R1.w, c[12].z;
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.x, R0.x;
MUL R4.xyz, R0.x, fragment.texcoord[1];
MUL R0.x, R4.y, R4.y;
MAD R0.x, R4, R4, R0;
MAD R0.x, R4.z, R4.z, R0;
RSQ R3.w, R0.x;
MUL R0.y, R3.w, -R4.z;
MUL R0.x, R0.y, c[11];
COS R0.z, R0.x;
DP3 R0.x, R4, R4;
MAD R0.y, R0, c[11], R0.z;
MUL R4.w, R1, c[9].x;
MUL R1.xy, R0.y, c[11].zwzw;
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, R4;
MAD R5.xyz, R0, c[11].x, R1.xxyw;
MUL R0.x, R5.y, R5.y;
MAD R0.x, R5, R5, R0;
MAD R0.x, R5.z, R5.z, R0;
RSQ R0.x, R0.x;
MUL R0.y, R0.x, -R5.z;
MUL R0.x, R0.y, c[12];
COS R0.z, R0.x;
MAD R0.y, R0, c[12], R0.z;
DP3 R0.x, R5, R5;
RSQ R0.x, R0.x;
MUL R6.xyz, R0.x, R5;
ADD R5.xyz, -R5, R4;
MUL R0.zw, R0.y, c[11];
MAD R0.xyz, R6, c[12].x, R0.zzww;
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R1.xyz, R0.w, R0;
MOV R10.xy, c[10].ywzw;
MUL R5.y, R5, R5;
MAD R5.x, R5, R5, R5.y;
MAD R5.y, R5.z, R5.z, R5.x;
ADD R0.xyz, -R0, R4;
MAD R2.xyz, R6, -R4.w, R4;
MUL R0.w, R10.y, c[9].x;
MAD R1.xyz, -R0.w, R1, R2;
TEX R2.yw, fragment.texcoord[0].zwzw, texture[2], 2D;
DP3 R1.w, R1, R1;
RSQ R2.x, R1.w;
MAD R3.xy, R2.wyzw, c[10].z, -c[10].y;
MUL R9.xyz, R2.x, R1;
MUL R1.w, R3.y, R3.y;
MAD R1.w, -R3.x, R3.x, -R1;
MUL R2.x, R0.y, R0.y;
ADD R1.w, R1, c[10].y;
RSQ R0.y, R1.w;
MAD R1.w, R0.x, R0.x, R2.x;
RCP R3.z, R0.y;
MAD R0.y, R0.z, R0.z, R1.w;
DP3 R2.x, R1, R4;
DP3 R0.x, R3, R9;
ADD R0.z, -R0.w, -R4.w;
RSQ R0.y, R0.y;
RCP R0.y, R0.y;
MAX R0.x, R0, c[10];
MUL R0.y, R0, c[4].x;
ADD R0.z, R0, c[10];
MUL R0.z, R0.y, R0;
MUL R0.y, R0.x, R0.x;
MUL R0.y, R0, R0.z;
MUL R0.y, R0, R0.z;
MUL R0.z, R1.y, R1.y;
MAD R0.z, R1.x, R1.x, R0;
MUL R0.y, R0, c[13].x;
POW R0.y, c[12].w, -R0.y;
MUL R0.y, -R0, c[13];
ADD R6.w, R0.y, c[10].y;
MAD R0.z, R1, R1, R0;
RSQ R0.y, R0.z;
RCP R0.z, R0.y;
MUL R5.w, R0.x, R6;
ADD R0.xy, R1, -R4;
MUL R0.z, R3.w, R0;
MUL R0.xy, R0.w, R0;
MUL R0.xy, R0, R0.z;
ADD_SAT R0.z, -R5.w, c[10].y;
POW R1.w, R0.z, c[13].z;
MAD R0.xy, -R0, c[13].w, fragment.texcoord[0];
TEX R0, R0, texture[6], 2D;
MUL R8.w, R1, R0;
DP3 R0.w, fragment.texcoord[4], fragment.texcoord[4];
RSQ R0.w, R0.w;
RCP R0.w, R0.w;
MUL R1.xyz, R0, c[1];
MUL_SAT R2.x, R2, c[9];
MUL R1.xyz, R2.x, R1;
ADD R2.x, -R2, c[10].y;
MAD R8.xyz, R2.x, c[1], R1;
ADD R2.xyz, fragment.texcoord[4], c[14].yzzw;
TEX R2, R2, texture[3], CUBE;
DP4 R7.w, R2, c[15];
ADD R1.xyz, fragment.texcoord[4], c[14].zyzw;
TEX R1, R1, texture[3], CUBE;
DP4 R7.z, R1, c[15];
ADD R1.xyz, fragment.texcoord[4], c[14].zzyw;
TEX R1, R1, texture[3], CUBE;
DP4 R7.y, R1, c[15];
ADD R2.xyz, fragment.texcoord[4], c[14].y;
TEX R2, R2, texture[3], CUBE;
DP3 R1.x, fragment.texcoord[2], fragment.texcoord[2];
DP4 R7.x, R2, c[15];
RSQ R1.x, R1.x;
MUL R2.xyz, R1.x, fragment.texcoord[2];
MUL R0.w, R0, c[0];
MAD R1, -R0.w, c[14].x, R7;
CMP R1, R1, c[3].x, R10.x;
ADD R7.xyz, R9, R2;
DP4 R1.y, R1, c[14].w;
DP3 R1.x, fragment.texcoord[3], fragment.texcoord[3];
MUL R10.xyz, R6, R4.w;
DP3 R2.w, R7, R7;
TEX R1.w, R1.x, texture[4], 2D;
TEX R0.w, fragment.texcoord[3], texture[5], CUBE;
MUL R0.w, R1, R0;
MUL R1.w, R0, R1.y;
MUL R0.w, R8, R1;
RSQ R1.x, R2.w;
MUL R1.xyz, R1.x, R7;
DP3 R7.w, R3, R1;
DP3 R1.x, R1, R2;
MUL_SAT R0.w, R0, c[16].x;
MUL R0.xyz, R0.w, R0;
ABS R2.w, R7;
MUL R0.xyz, R0, c[8];
ADD R0.w, -R0, c[10].y;
MAD R7.xyz, R0.w, R8, R0;
ADD R0.y, -R2.w, c[10];
MAD R0.x, R2.w, c[16].z, c[16].w;
MAD R0.x, R0, R2.w, -c[17];
MAD R0.x, R0, R2.w, c[17].y;
RSQ R0.y, R0.y;
RCP R0.y, R0.y;
MUL R8.x, R0, R0.y;
TEX R0, fragment.texcoord[0], texture[0], 2D;
SLT R2.w, R7, c[10].x;
MUL R8.y, R2.w, R8.x;
MAD R8.x, -R8.y, c[10].z, R8;
MUL R0.xyz, R0, c[5];
MAD R2.w, R2, c[16].y, R8.x;
MOV R8.y, c[9].x;
MAD R11.x, R8.y, c[17].z, c[17].w;
COS R2.w, R2.w;
MUL R2.w, R2, R2;
MUL R9.w, R11.x, R11.x;
MUL R8.x, R2.w, R11;
MUL R8.x, R8, R11;
MUL R8.y, R2.w, R9.w;
MUL R8.y, R2.w, R8;
MUL R7.xyz, R0, R7;
RCP R1.x, R1.x;
MUL R8.y, R8, c[18].x;
RCP R8.x, R8.x;
ADD R2.w, -R2, c[10].y;
MUL R2.w, R2, R8.x;
RCP R8.x, R8.y;
MOV R8.y, c[10];
ADD R10.w, R8.y, -c[6].x;
DP3 R8.y, R3, R2;
MUL R1.y, R7.w, R8;
MUL R1.y, R1, R1.x;
POW R2.w, c[12].w, -R2.w;
MUL R2.w, R2, R8.x;
ADD R8.x, -R7.w, c[10].y;
POW R8.x, R8.x, c[18].y;
MAD R8.x, R8, c[6], R10.w;
MUL R2.w, R2, R8.x;
RCP R8.w, R8.y;
MUL R2.w, R0, R2;
MUL_SAT R11.z, R2.w, R8.w;
ADD R8.xyz, R4, -R10;
MUL R6.x, R1.y, c[10].z;
DP3 R1.y, R8, R8;
RSQ R1.z, R1.y;
DP3 R2.w, R3, R4;
MUL R9.xyz, R1.z, R8;
MUL R1.y, R7.w, R2.w;
MUL R6.y, R1.x, R1;
ADD R1.xyz, R2, R9;
DP3 R5.x, R3, R9;
MUL R6.y, R6, c[10].z;
MIN_SAT R10.z, R6.x, R6.y;
DP3 R6.z, R1, R1;
RSQ R6.y, R6.z;
MUL R1.xyz, R6.y, R1;
DP3 R11.y, R3, R1;
ABS R1.y, R11;
MAD R1.z, R1.y, c[16], c[16].w;
MAD R1.z, R1, R1.y, -c[17].x;
MAX R5.z, R5.x, c[10].x;
RSQ R5.y, R5.y;
RCP R5.x, R5.y;
ADD R2.xyz, R4, R2;
MAX R6.x, R7.w, c[10];
MOV R6.y, c[18].z;
MUL R7.w, R6.y, c[6].x;
POW R1.x, R6.x, R7.w;
ADD R6.x, -R1.y, c[10].y;
MUL R1.x, R0.w, R1;
RSQ R6.x, R6.x;
MUL R1.x, R1, c[13];
MAD R1.y, R1.z, R1, c[17];
RCP R6.x, R6.x;
MUL R1.z, R1.y, R6.x;
SLT R1.y, R11, c[10].x;
MUL R6.x, R1.y, R1.z;
MAD R1.z, -R6.x, c[10], R1;
MAD R1.y, R1, c[16], R1.z;
MAD R1.x, R11.z, R10.z, R1;
MUL_SAT R6.x, R6.w, R1;
COS R1.y, R1.y;
MUL R6.w, R1.y, R1.y;
MUL R11.z, R11.x, R6.w;
MOV R1.xyz, c[2];
MUL R1.xyz, R1, c[1];
MUL R6.xyz, R1, R6.x;
MAD R6.xyz, R7, R5.w, R6;
MUL R11.x, R11, R11.z;
RCP R7.x, R11.x;
ADD R5.w, -R6, c[10].y;
MUL R5.w, R5, R7.x;
MUL R7.x, R9.w, R6.w;
MUL R6.w, R6, R7.x;
ADD R7.x, -R11.y, c[10].y;
MUL R6.w, R6, c[18].x;
POW R7.x, R7.x, c[18].y;
RCP R6.w, R6.w;
POW R5.w, c[12].w, -R5.w;
MUL R5.w, R5, R6;
MUL R6.w, R1, c[10].z;
MAD R7.x, R7, c[6], R10.w;
MUL R5.w, R5, R7.x;
MUL R5.w, R0, R5;
MAX R7.x, R11.y, c[10];
POW R7.x, R7.x, R7.w;
MUL R7.x, R0.w, R7;
MUL_SAT R5.w, R8, R5;
MUL R7.x, R7, c[13];
ADD R5.y, -R4.w, c[10];
MUL R5.x, R5, c[4];
MUL R5.y, R5.x, R5;
MUL R5.x, R5.z, R5.z;
MUL R5.x, R5, R5.y;
MUL R5.x, R5, R5.y;
MUL R5.y, R8, R8;
MAD R5.y, R8.x, R8.x, R5;
MAD R5.y, R8.z, R8.z, R5;
MUL R5.x, R5, c[13];
POW R5.x, c[12].w, -R5.x;
MAD R7.x, R10.z, R5.w, R7;
MUL R5.x, -R5, c[13].y;
ADD R5.w, R5.x, c[10].y;
RSQ R5.y, R5.y;
MUL_SAT R7.x, R5.w, R7;
RCP R5.x, R5.y;
MUL R3.w, R3, R5.x;
MUL R5.xy, R4.w, -R10;
MUL R5.xy, R5, R3.w;
MUL R3.w, R5.z, R5;
MAD R5.xy, -R5, c[13].w, fragment.texcoord[0];
ADD_SAT R4.w, -R3, c[10].y;
TEX R5, R5, texture[6], 2D;
POW R4.w, R4.w, c[13].z;
MUL R4.w, R4, R5;
DP3 R5.w, R4, R8;
MUL R1.w, R1, R4;
MUL_SAT R1.w, R1, c[16].x;
DP3 R4.x, R2, R2;
MUL R7.xyz, R1, R7.x;
MUL_SAT R5.w, R5, c[9].x;
MUL R8.xyz, R5, c[1];
MUL R8.xyz, R5.w, R8;
ADD R5.w, -R5, c[10].y;
MAD R8.xyz, R5.w, c[1], R8;
RSQ R5.w, R4.x;
MUL R4.xyz, R1.w, R5;
ADD R4.w, -R1, c[10].y;
MUL R2.xyz, R5.w, R2;
DP3 R1.w, R3, R2;
MUL R4.xyz, R4, c[8];
MAD R2.xyz, R4.w, R8, R4;
MUL R2.xyz, R0, R2;
MAX R1.w, R1, c[10].x;
POW R1.w, R1.w, R7.w;
MUL_SAT R0.w, R0, R1;
MUL R1.xyz, R1, R0.w;
MAD R2.xyz, R2, R3.w, R7;
MUL R2.xyz, R6.w, R2;
MAX R0.w, R2, c[10].x;
MUL R0.xyz, R0, c[1];
MAD R0.xyz, R0, R0.w, R1;
MUL R3.xyz, R6.w, R0;
TEX R0.w, fragment.texcoord[0], texture[1], 2D;
ADD_SAT R0.x, R0.w, c[7];
MUL R1.xyz, R0.x, R2;
MUL R2.xyz, R0.x, R3;
ADD R0.x, -R0, c[10].y;
MUL R6.xyz, R6, R6.w;
MAD R1.xyz, R0.x, R6, R1;
MAD result.color.xyz, R1, R0.x, R2;
MOV result.color.w, c[10].x;
END
# 307 instructions, 12 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Vector 0 [_LightPositionRange]
Vector 1 [_LightColor0]
Vector 2 [_SpecColor]
Vector 3 [_LightShadowData]
Float 4 [_GVar]
Vector 5 [_Color]
Float 6 [_Shininess]
Float 7 [_BlendAdjust1]
Vector 8 [_SSSC]
Float 9 [_Smoothness]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_ScatterMap] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_ShadowMapTexture] CUBE
SetTexture 4 [_LightTextureB0] 2D
SetTexture 5 [_LightTexture0] CUBE
SetTexture 6 [_ExitColorMap] 2D
"ps_3_0
; 365 ALU, 11 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_cube s3
dcl_2d s4
dcl_cube s5
dcl_2d s6
def c10, 2.00000000, -1.00000000, 0.10000000, -0.73550957
def c11, 0.11705996, 0.50000000, 6.28318501, -3.14159298
def c12, 0.00000000, -1.00000000, 0.73550957, -0.99270076
def c13, 0.15799320, 0.50000000, 0.99270076, 0.44999999
def c14, 2.71828198, 0.39894229, 1.00000000, 3.50000000
def c15, 0.00100000, 0.00781250, -0.00781250, 0.97000003
def c16, 1.00000000, 0.00392157, 0.00001538, 0.00000001
def c17, 0.25000000, 7.00000000, 0.00000000, 1.00000000
def c18, -0.01872930, 0.07426100, -0.21211439, 1.57072902
def c19, 3.14159298, 0.15915491, 0.50000000, 3.14159274
def c20, 1.29999995, 0.69999999, 5.00000000, 128.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dp3_pp r0.x, v1, v1
rsq_pp r0.x, r0.x
mul_pp r2.xyz, r0.x, v1
mul r0.x, r2.y, r2.y
mad r0.x, r2, r2, r0
mad r0.x, r2.z, r2.z, r0
rsq r1.w, r0.x
mul r1.x, r1.w, -r2.z
mad r0.x, r1, c11, c11.y
frc r0.x, r0
mad r1.y, r0.x, c11.z, c11.w
sincos r0.xy, r1.y
mad r0.z, r1.x, c10.w, r0.x
dp3 r0.y, r2, r2
mul r1.xy, r0.z, c12
rsq r0.x, r0.y
mul r0.xyz, r0.x, r2
mad r3.xyz, r0, c12.z, r1.xxyw
mul r0.x, r3.y, r3.y
mad r0.x, r3, r3, r0
mad r0.x, r3.z, r3.z, r0
rsq r0.x, r0.x
mul r1.x, r0, -r3.z
mad r0.x, r1, c13, c13.y
frc r0.x, r0
mad r1.y, r0.x, c11.z, c11.w
sincos r0.xy, r1.y
mad r0.z, r1.x, c12.w, r0.x
dp3 r0.y, r3, r3
rsq r0.x, r0.y
mul r8.xyz, r0.x, r3
add r3.xyz, -r3, r2
mul r0.zw, r0.z, c12.xyxy
mad r6.xyz, r8, c13.z, r0.zzww
dp3 r0.x, r6, r6
mov r0.w, c9.x
mul r2.w, c13, r0
mov r0.w, c9.x
rsq r0.x, r0.x
mul r0.xyz, r0.x, r6
mad r1.xyz, r8, -r2.w, r2
mul r9.w, c10.z, r0
mad r7.xyz, -r9.w, r0, r1
dp3 r0.x, r7, r7
texld r0.yw, v0.zwzw, s2
mad_pp r1.xy, r0.wyzw, c10.x, c10.y
rsq r0.x, r0.x
mul r9.xyz, r0.x, r7
mul_pp r0.w, r1.y, r1.y
mad_pp r0.w, -r1.x, r1.x, -r0
dp3_pp r0.x, v2, v2
rsq_pp r0.x, r0.x
mul_pp r4.xyz, r0.x, v2
add r0.xyz, r9, r4
dp3 r1.z, r0, r0
rsq r1.z, r1.z
add_pp r0.w, r0, c14.z
mul r5.xyz, r1.z, r0
rsq_pp r0.w, r0.w
rcp_pp r1.z, r0.w
dp3 r5.w, r1, r5
abs r0.x, r5.w
add r0.z, -r0.x, c14
mad r0.y, r0.x, c18.x, c18
mad r0.y, r0, r0.x, c18.z
rsq r0.z, r0.z
mad r0.x, r0.y, r0, c18.w
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r0.x, r5.w, c17.z, c17.w
mul r0.z, r0.x, r0.y
mad r0.y, -r0.z, c10.x, r0
mad r0.x, r0, c19, r0.y
mad r0.x, r0, c19.y, c19.z
frc r0.x, r0
mad r3.w, r0.x, c11.z, c11
sincos r0.xy, r3.w
mov r0.y, c9.x
mad r4.w, r0.y, c20.x, c20.y
mul r6.w, r0.x, r0.x
mul r0.x, r6.w, r4.w
mul r0.x, r0, r4.w
rcp r0.y, r0.x
add r0.x, -r6.w, c14.z
mul r7.w, r0.x, r0.y
pow r0, c14.x, -r7.w
mul r3.w, r4, r4
mul r0.y, r6.w, r3.w
mul r0.y, r6.w, r0
mul r0.w, r0.y, c19
mov r6.w, r0.x
add r0.xyz, -r6, r2
rcp r0.w, r0.w
mul r0.y, r0, r0
mad r0.y, r0.x, r0.x, r0
dp3 r0.x, r1, r9
mul r10.z, r6.w, r0.w
mad r0.y, r0.z, r0.z, r0
max r8.w, r0.x, c12.x
rsq r0.x, r0.y
add r0.y, -r9.w, -r2.w
rcp r0.x, r0.x
add r6.y, -r5.w, c14.z
mul r0.x, r0, c4
add r0.y, r0, c10.x
mul r0.y, r0.x, r0
mul r0.x, r8.w, r8.w
mul r0.x, r0, r0.y
mul r6.x, r0, r0.y
pow r0, r6.y, c20.z
mul r0.y, r6.x, c11
pow r6, c14.x, -r0.y
mov_pp r0.y, c6.x
mov r0.z, r0.x
mov r0.x, r6
mad r10.w, -r0.x, c14.y, c14.z
mul r8.w, r8, r10
add_pp r7.w, c14.z, -r0.y
mul r0.x, r7.y, r7.y
mad r6.y, r7.x, r7.x, r0.x
mad r11.x, r0.z, c6, r7.w
add_sat r6.x, -r8.w, c14.z
pow r0, r6.x, c14.w
mad r0.y, r7.z, r7.z, r6
rsq r0.y, r0.y
rcp r0.z, r0.y
mov r11.y, r0.x
add r0.xy, r7, -r2
dp3 r7.x, r7, r2
mul r0.w, r1, r0.z
mul r6.xy, r9.w, r0
mul r6.xy, r6, r0.w
mad r10.xy, -r6, c15.x, v0
add r0.xyz, v4, c15.yzzw
texld r0, r0, s3
dp4 r9.w, r0, c16
add r0.xyz, v4, c15.zyzw
texld r0, r0, s3
dp4 r9.z, r0, c16
add r6.xyz, v4, c15.zzyw
texld r6, r6, s3
dp4 r9.y, r6, c16
add r0.xyz, v4, c15.y
texld r0, r0, s3
dp3 r6.x, v4, v4
dp4 r9.x, r0, c16
rsq r6.x, r6.x
rcp r0.x, r6.x
mul r0.x, r0, c0.w
mad r0, -r0.x, c15.w, r9
mov r6.x, c3
cmp r0, r0, c14.z, r6.x
dp4_pp r0.y, r0, c17.x
dp3 r0.x, v3, v3
texld r6, r10, s6
texld r0.w, v3, s5
texld r0.x, r0.x, s4
mul r0.x, r0, r0.w
mul r9.w, r0.x, r0.y
mul r0.w, r10.z, r11.x
mul r10.xyz, r8, r2.w
mul r0.x, r11.y, r6.w
mul r0.x, r0, r9.w
mul_sat r6.w, r0.x, c17.y
mul_pp r0.xyz, r6, c1
mul_sat r7.x, r7, c9
mul r0.xyz, r7.x, r0
add r7.x, -r7, c14.z
add r8.xyz, r2, -r10
add r9.x, -r6.w, c14.z
mad r0.xyz, r7.x, c1, r0
mul r6.xyz, r6.w, r6
mul r7.xyz, r6, c8
texld r6, v0, s0
mad r0.xyz, r9.x, r0, r7
mul_pp r6.xyz, r6, c5
mul_pp r7.xyz, r6, r0
dp3_pp r0.y, r1, r4
mul r10.z, r5.w, r0.y
mul r0.x, r6.w, r0.w
rcp r12.y, r0.y
mul_sat r11.x, r0, r12.y
dp3 r0.x, r8, r8
rsq r0.y, r0.x
dp3_pp r0.x, r5, r4
rcp r0.w, r0.x
mul r5.x, r10.z, r0.w
mul r9.xyz, r0.y, r8
add r0.xyz, r4, r9
dp3 r5.y, r0, r0
rsq r5.y, r5.y
mul r0.xyz, r5.y, r0
dp3 r12.z, r1, r0
dp3_pp r10.z, r1, r2
abs r0.y, r12.z
mul r5.y, r5.w, r10.z
mul r0.x, r0.w, r5.y
add r0.w, -r0.y, c14.z
mad r0.z, r0.y, c18.x, c18.y
mad r0.z, r0, r0.y, c18
mad r0.y, r0.z, r0, c18.w
rsq r0.w, r0.w
rcp r0.w, r0.w
mul r0.y, r0, r0.w
cmp r0.z, r12, c17, c17.w
mul r0.w, r0.z, r0.y
mul r5.x, r5, c10
mul r0.x, r0, c10
min_sat r12.x, r5, r0
mad r0.x, -r0.w, c10, r0.y
mad r0.z, r0, c19.x, r0.x
mov_pp r0.x, c6
mul_pp r11.w, c20, r0.x
max r0.y, r5.w, c12.x
mad r0.z, r0, c19.y, c19
pow r5, r0.y, r11.w
frc r0.x, r0.z
mad r5.y, r0.x, c11.z, c11.w
sincos r0.xy, r5.y
mov r0.y, r5.x
mul r5.w, r0.x, r0.x
mul r0.y, r6.w, r0
mul r0.x, r0.y, c11.y
mul r0.y, r4.w, r5.w
mul r0.y, r4.w, r0
mad r0.x, r11, r12, r0
mul_sat r4.w, r10, r0.x
mov_pp r5.xyz, c1
mul_pp r5.xyz, c2, r5
mul r11.xyz, r5, r4.w
mad r7.xyz, r7, r8.w, r11
mul r3.w, r3, r5
add r0.x, -r5.w, c14.z
rcp r0.y, r0.y
mul r10.w, r0.x, r0.y
pow r0, c14.x, -r10.w
mov r4.w, r0.x
add r8.w, -r12.z, c14.z
pow r0, r8.w, c20.z
mul r0.y, r5.w, r3.w
mov r0.z, r0.x
mul r0.y, r0, c19.w
rcp r0.x, r0.y
mul r0.x, r4.w, r0
mul_pp r4.w, r9, c10.x
mad r0.y, r0.z, c6.x, r7.w
mul r0.x, r0, r0.y
mul r0.x, r6.w, r0
mul_sat r3.w, r12.y, r0.x
max r5.w, r12.z, c12.x
pow r0, r5.w, r11.w
mul r3.y, r3, r3
mad r0.y, r3.x, r3.x, r3
mad r0.z, r3, r3, r0.y
dp3 r0.y, r1, r9
max r3.x, r0.y, c12
rsq r0.z, r0.z
rcp r0.y, r0.z
mov r0.w, r0.x
mul r0.y, r0, c4.x
add r0.z, -r2.w, c14
mul r0.z, r0.y, r0
mul r0.y, r3.x, r3.x
mul r0.y, r0, r0.z
mul r0.x, r0.y, r0.z
mul r0.y, r6.w, r0.w
mul r3.y, r0.x, c11
mul r3.z, r0.y, c11.y
pow r0, c14.x, -r3.y
mad r0.z, r12.x, r3.w, r3
mad r0.x, -r0, c14.y, c14.z
mul r5.w, r3.x, r0.x
mul_sat r0.z, r0.x, r0
mul r0.y, r8, r8
mad r0.y, r8.x, r8.x, r0
mad r0.y, r8.z, r8.z, r0
rsq r0.y, r0.y
mul r9.xyz, r5, r0.z
rcp r0.x, r0.y
mul r0.z, r1.w, r0.x
mul r0.xy, r2.w, -r10
mul r3.xy, r0, r0.z
add_sat r3.z, -r5.w, c14
pow r0, r3.z, c14.w
dp3 r0.y, r2, r8
mad r3.xy, -r3, c15.x, v0
texld r3, r3, s6
mov r0.w, r0.x
mul r0.w, r0, r3
mul r0.w, r9, r0
mul_sat r0.w, r0, c17.y
mul_sat r0.y, r0, c9.x
mul_pp r8.xyz, r3, c1
mul r8.xyz, r0.y, r8
add r0.y, -r0, c14.z
mad r8.xyz, r0.y, c1, r8
add_pp r0.xyz, r2, r4
dp3_pp r1.w, r0, r0
rsq_pp r1.w, r1.w
mul_pp r0.xyz, r1.w, r0
dp3_pp r1.x, r1, r0
max_pp r2.x, r1, c12
mul r0.xyz, r0.w, r3
add r1.w, -r0, c14.z
mul r1.xyz, r0, c8
pow r0, r2.x, r11.w
mov r0.w, r0.x
mul_sat r0.w, r6, r0
mul r2.xyz, r5, r0.w
mad r1.xyz, r1.w, r8, r1
mul_pp r1.xyz, r6, r1
mad r0.xyz, r1, r5.w, r9
mul r0.xyz, r4.w, r0
max_pp r0.w, r10.z, c12.x
mul_pp r1.xyz, r6, c1
mad r1.xyz, r1, r0.w, r2
texld r0.w, v0, s1
add_sat r0.w, r0, c7.x
mul r2.xyz, r4.w, r1
mul_pp r1.xyz, r0.w, r0
add_pp r0.x, -r0.w, c14.z
mul r7.xyz, r7, r4.w
mul_pp r2.xyz, r0.w, r2
mad_pp r1.xyz, r0.x, r7, r1
mad_pp oC0.xyz, r1, r0.x, r2
mov_pp oC0.w, c12.x
"
}
}
 }
}
Fallback "Chickenlord/FastSkin"
}