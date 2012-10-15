Shader "Chickenlord/Skin/Fast SM2 Skinshader" {
Properties {
 _Color ("Main Color", Color) = (1,1,1,1)
 _Shininess ("Shininess", Range(0.01,1)) = 0.078125
 _MainTex ("Base (RGB) Gloss (A)", 2D) = "white" {}
 _BumpMap ("Normalmap", 2D) = "bump" {}
 _ExitColorMap ("Exit Color Map (RGB) Scattering (A)", 2D) = "ecm" {}
 _SSSC ("SSSC", Color) = (1,1,1,1)
 _Layer1Thickness ("Layer 1 Thickness", Range(0,1)) = 0.1
 _Layer2Thickness ("Layer 2 Thickness", Range(0,1)) = 0.1
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
"!!ARBvp1.0
# 35 ALU
PARAM c[24] = { { 1 },
		state.matrix.mvp,
		program.local[5..23] };
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
DP4 R2.z, R0, c[17];
DP4 R2.y, R0, c[16];
DP4 R2.x, R0, c[15];
MUL R0.y, R2.w, R2.w;
DP4 R3.z, R1, c[20];
DP4 R3.y, R1, c[19];
DP4 R3.x, R1, c[18];
MOV R1.xyz, vertex.attrib[14];
ADD R3.xyz, R2, R3;
MAD R0.x, R0, R0, -R0.y;
MUL R2.xyz, R0.x, c[21];
MUL R0.xyz, vertex.normal.zxyw, R1.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R1.zxyw, -R0;
ADD result.texcoord[2].xyz, R3, R2;
MOV R1, c[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MUL R0.xyz, R0, vertex.attrib[14].w;
DP3 result.texcoord[1].y, R2, R0;
DP3 result.texcoord[1].z, vertex.normal, R2;
DP3 result.texcoord[1].x, R2, vertex.attrib[14];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[23].xyxy, c[23];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[22], c[22].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 35 instructions, 4 R-regs
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
Vector 13 [_WorldSpaceLightPos0]
Vector 14 [unity_SHAr]
Vector 15 [unity_SHAg]
Vector 16 [unity_SHAb]
Vector 17 [unity_SHBr]
Vector 18 [unity_SHBg]
Vector 19 [unity_SHBb]
Vector 20 [unity_SHC]
Vector 21 [_MainTex_ST]
Vector 22 [_BumpMap_ST]
"vs_2_0
; 38 ALU
def c23, 1.00000000, 0, 0, 0
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
mov r0.w, c23.x
dp4 r2.z, r0, c16
dp4 r2.y, r0, c15
dp4 r2.x, r0, c14
mul r0.y, r2.w, r2.w
dp4 r3.z, r1, c19
dp4 r3.y, r1, c18
dp4 r3.x, r1, c17
mad r0.x, r0, r0, -r0.y
mul r1.xyz, r0.x, c20
add r2.xyz, r2, r3
mov r0.xyz, v1
add oT2.xyz, r2, r1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mov r0, c10
dp4 r3.z, c13, r0
mul r2.xyz, r1, v1.w
mov r0, c9
mov r1, c8
dp4 r3.y, c13, r0
dp4 r3.x, c13, r1
dp3 oT1.y, r3, r2
dp3 oT1.z, v2, r3
dp3 oT1.x, r3, v1
mad oT0.zw, v3.xyxy, c22.xyxy, c22
mad oT0.xy, v3, c21, c21.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 14 [unity_LightmapST]
Vector 15 [_MainTex_ST]
Vector 16 [_BumpMap_ST]
"!!ARBvp1.0
# 7 ALU
PARAM c[17] = { program.local[0],
		state.matrix.mvp,
		program.local[5..16] };
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[16].xyxy, c[16];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[15], c[15].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[1], c[14], c[14].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 7 instructions, 0 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 12 [unity_LightmapST]
Vector 13 [_MainTex_ST]
Vector 14 [_BumpMap_ST]
"vs_2_0
; 7 ALU
dcl_position0 v0
dcl_texcoord0 v3
dcl_texcoord1 v4
mad oT0.zw, v3.xyxy, c14.xyxy, c14
mad oT0.xy, v3, c13, c13.zwzw
mad oT1.xy, v4, c12, c12.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
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
"!!ARBvp1.0
# 40 ALU
PARAM c[25] = { { 1, 0.5 },
		state.matrix.mvp,
		program.local[5..24] };
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
DP4 R2.z, R0, c[18];
DP4 R2.y, R0, c[17];
DP4 R2.x, R0, c[16];
MUL R0.y, R2.w, R2.w;
DP4 R3.z, R1, c[21];
DP4 R3.y, R1, c[20];
DP4 R3.x, R1, c[19];
MOV R1.xyz, vertex.attrib[14];
DP4 R0.w, vertex.position, c[4];
ADD R3.xyz, R2, R3;
MAD R0.x, R0, R0, -R0.y;
MUL R2.xyz, R0.x, c[22];
MUL R0.xyz, vertex.normal.zxyw, R1.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R1.zxyw, -R0;
MUL R0.xyz, R0, vertex.attrib[14].w;
MOV R1, c[15];
ADD result.texcoord[2].xyz, R3, R2;
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
DP3 result.texcoord[1].y, R2, R0;
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[13].x;
DP3 result.texcoord[1].z, vertex.normal, R2;
DP3 result.texcoord[1].x, R2, vertex.attrib[14];
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[3].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[24].xyxy, c[24];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[23], c[23].zwzw;
END
# 40 instructions, 4 R-regs
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
"vs_2_0
; 43 ALU
def c25, 1.00000000, 0.50000000, 0, 0
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
mov r0.w, c25.x
dp4 r2.z, r0, c18
dp4 r2.y, r0, c17
dp4 r2.x, r0, c16
mul r0.y, r2.w, r2.w
dp4 r3.z, r1, c21
dp4 r3.y, r1, c20
dp4 r3.x, r1, c19
mad r0.x, r0, r0, -r0.y
mul r1.xyz, r0.x, c22
add r2.xyz, r2, r3
mov r0.xyz, v1
add oT2.xyz, r2, r1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mov r0, c10
dp4 r3.z, c15, r0
mov r0, c9
dp4 r3.y, c15, r0
mul r2.xyz, r1, v1.w
mov r1, c8
dp4 r3.x, c15, r1
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c25.y
mul r1.y, r1, c12.x
dp3 oT1.y, r3, r2
dp3 oT1.z, v2, r3
dp3 oT1.x, r3, v1
mad oT3.xy, r1.z, c13.zwzw, r1
mov oPos, r0
mov oT3.zw, r0
mad oT0.zw, v3.xyxy, c24.xyxy, c24
mad oT0.xy, v3, c23, c23.zwzw
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 13 [_ProjectionParams]
Vector 15 [unity_LightmapST]
Vector 16 [_MainTex_ST]
Vector 17 [_BumpMap_ST]
"!!ARBvp1.0
# 12 ALU
PARAM c[18] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..17] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[13].x;
ADD result.texcoord[2].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[2].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[17].xyxy, c[17];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[16], c[16].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[1], c[15], c[15].zwzw;
END
# 12 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_ProjectionParams]
Vector 13 [_ScreenParams]
Vector 14 [unity_LightmapST]
Vector 15 [_MainTex_ST]
Vector 16 [_BumpMap_ST]
"vs_2_0
; 12 ALU
def c17, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v3
dcl_texcoord1 v4
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c17.x
mul r1.y, r1, c12.x
mad oT2.xy, r1.z, c13.zwzw, r1
mov oPos, r0
mov oT2.zw, r0
mad oT0.zw, v3.xyxy, c16.xyxy, c16
mad oT0.xy, v3, c15, c15.zwzw
mad oT1.xy, v4, c14, c14.zwzw
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
"!!ARBvp1.0
# 66 ALU
PARAM c[32] = { { 1, 0 },
		state.matrix.mvp,
		program.local[5..31] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MUL R3.xyz, vertex.normal, c[13].w;
DP4 R0.x, vertex.position, c[6];
ADD R1, -R0.x, c[16];
DP3 R3.w, R3, c[6];
DP3 R4.x, R3, c[5];
DP3 R3.x, R3, c[7];
MUL R2, R3.w, R1;
DP4 R0.x, vertex.position, c[5];
ADD R0, -R0.x, c[15];
MUL R1, R1, R1;
MOV R4.z, R3.x;
MAD R2, R4.x, R0, R2;
MOV R4.w, c[0].x;
DP4 R4.y, vertex.position, c[7];
MAD R1, R0, R0, R1;
ADD R0, -R4.y, c[17];
MAD R1, R0, R0, R1;
MAD R0, R3.x, R0, R2;
MUL R2, R1, c[18];
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
MUL R1.xyz, R0.y, c[20];
MAD R1.xyz, R0.x, c[19], R1;
MAD R0.xyz, R0.z, c[21], R1;
MAD R1.xyz, R0.w, c[22], R0;
MUL R0, R4.xyzz, R4.yzzx;
DP4 R3.z, R0, c[28];
DP4 R3.y, R0, c[27];
DP4 R3.x, R0, c[26];
MUL R1.w, R3, R3;
MAD R0.x, R4, R4, -R1.w;
DP4 R2.z, R4, c[25];
DP4 R2.y, R4, c[24];
DP4 R2.x, R4, c[23];
ADD R2.xyz, R2, R3;
MUL R3.xyz, R0.x, c[29];
ADD R3.xyz, R2, R3;
MOV R0.xyz, vertex.attrib[14];
MUL R2.xyz, vertex.normal.zxyw, R0.yzxw;
ADD result.texcoord[2].xyz, R3, R1;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R2;
MOV R0, c[14];
DP4 R2.z, R0, c[11];
DP4 R2.y, R0, c[10];
DP4 R2.x, R0, c[9];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP3 result.texcoord[1].y, R2, R1;
DP3 result.texcoord[1].z, vertex.normal, R2;
DP3 result.texcoord[1].x, R2, vertex.attrib[14];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[31].xyxy, c[31];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[30], c[30].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 66 instructions, 5 R-regs
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
Vector 13 [_WorldSpaceLightPos0]
Vector 14 [unity_4LightPosX0]
Vector 15 [unity_4LightPosY0]
Vector 16 [unity_4LightPosZ0]
Vector 17 [unity_4LightAtten0]
Vector 18 [unity_LightColor0]
Vector 19 [unity_LightColor1]
Vector 20 [unity_LightColor2]
Vector 21 [unity_LightColor3]
Vector 22 [unity_SHAr]
Vector 23 [unity_SHAg]
Vector 24 [unity_SHAb]
Vector 25 [unity_SHBr]
Vector 26 [unity_SHBg]
Vector 27 [unity_SHBb]
Vector 28 [unity_SHC]
Vector 29 [_MainTex_ST]
Vector 30 [_BumpMap_ST]
"vs_2_0
; 69 ALU
def c31, 1.00000000, 0.00000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r3.xyz, v2, c12.w
dp4 r0.x, v0, c5
add r1, -r0.x, c15
dp3 r3.w, r3, c5
dp3 r4.x, r3, c4
dp3 r3.x, r3, c6
mul r2, r3.w, r1
dp4 r0.x, v0, c4
add r0, -r0.x, c14
mul r1, r1, r1
mov r4.z, r3.x
mad r2, r4.x, r0, r2
mov r4.w, c31.x
dp4 r4.y, v0, c6
mad r1, r0, r0, r1
add r0, -r4.y, c16
mad r1, r0, r0, r1
mad r0, r3.x, r0, r2
mul r2, r1, c17
mov r4.y, r3.w
rsq r1.x, r1.x
rsq r1.y, r1.y
rsq r1.w, r1.w
rsq r1.z, r1.z
mul r0, r0, r1
add r1, r2, c31.x
rcp r1.x, r1.x
rcp r1.y, r1.y
rcp r1.w, r1.w
rcp r1.z, r1.z
max r0, r0, c31.y
mul r0, r0, r1
mul r1.xyz, r0.y, c19
mad r1.xyz, r0.x, c18, r1
mad r0.xyz, r0.z, c20, r1
mad r1.xyz, r0.w, c21, r0
mul r0, r4.xyzz, r4.yzzx
mul r1.w, r3, r3
dp4 r3.z, r0, c27
dp4 r3.y, r0, c26
dp4 r3.x, r0, c25
mad r1.w, r4.x, r4.x, -r1
mul r0.xyz, r1.w, c28
dp4 r2.z, r4, c24
dp4 r2.y, r4, c23
dp4 r2.x, r4, c22
add r2.xyz, r2, r3
add r2.xyz, r2, r0
mov r0.xyz, v1
add oT2.xyz, r2, r1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mov r0, c10
dp4 r3.z, c13, r0
mul r2.xyz, r1, v1.w
mov r1, c9
mov r0, c8
dp4 r3.y, c13, r1
dp4 r3.x, c13, r0
dp3 oT1.y, r3, r2
dp3 oT1.z, v2, r3
dp3 oT1.x, r3, v1
mad oT0.zw, v3.xyxy, c30.xyxy, c30
mad oT0.xy, v3, c29, c29.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
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
"!!ARBvp1.0
# 71 ALU
PARAM c[33] = { { 1, 0, 0.5 },
		state.matrix.mvp,
		program.local[5..32] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MUL R3.xyz, vertex.normal, c[14].w;
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
DP4 R2.z, R4, c[26];
DP4 R2.y, R4, c[25];
DP4 R2.x, R4, c[24];
ADD R2.xyz, R2, R3;
MUL R3.xyz, R0.x, c[30];
ADD R3.xyz, R2, R3;
MOV R0.xyz, vertex.attrib[14];
MUL R2.xyz, vertex.normal.zxyw, R0.yzxw;
ADD result.texcoord[2].xyz, R3, R1;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R2;
MOV R0, c[15];
DP4 R2.z, R0, c[11];
DP4 R2.y, R0, c[10];
DP4 R2.x, R0, c[9];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
DP3 result.texcoord[1].y, R2, R1;
MUL R1.xyz, R0.xyww, c[0].z;
MUL R1.y, R1, c[13].x;
DP3 result.texcoord[1].z, vertex.normal, R2;
DP3 result.texcoord[1].x, R2, vertex.attrib[14];
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[3].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[32].xyxy, c[32];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[31], c[31].zwzw;
END
# 71 instructions, 5 R-regs
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
"vs_2_0
; 74 ALU
def c33, 1.00000000, 0.00000000, 0.50000000, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r3.xyz, v2, c14.w
dp4 r0.x, v0, c5
add r1, -r0.x, c17
dp3 r3.w, r3, c5
dp3 r4.x, r3, c4
dp3 r3.x, r3, c6
mul r2, r3.w, r1
dp4 r0.x, v0, c4
add r0, -r0.x, c16
mul r1, r1, r1
mov r4.z, r3.x
mad r2, r4.x, r0, r2
mov r4.w, c33.x
dp4 r4.y, v0, c6
mad r1, r0, r0, r1
add r0, -r4.y, c18
mad r1, r0, r0, r1
mad r0, r3.x, r0, r2
mul r2, r1, c19
mov r4.y, r3.w
rsq r1.x, r1.x
rsq r1.y, r1.y
rsq r1.w, r1.w
rsq r1.z, r1.z
mul r0, r0, r1
add r1, r2, c33.x
rcp r1.x, r1.x
rcp r1.y, r1.y
rcp r1.w, r1.w
rcp r1.z, r1.z
max r0, r0, c33.y
mul r0, r0, r1
mul r1.xyz, r0.y, c21
mad r1.xyz, r0.x, c20, r1
mad r0.xyz, r0.z, c22, r1
mad r1.xyz, r0.w, c23, r0
mul r0, r4.xyzz, r4.yzzx
mul r1.w, r3, r3
dp4 r3.z, r0, c29
dp4 r3.y, r0, c28
dp4 r3.x, r0, c27
mad r1.w, r4.x, r4.x, -r1
mul r0.xyz, r1.w, c30
dp4 r2.z, r4, c26
dp4 r2.y, r4, c25
dp4 r2.x, r4, c24
add r2.xyz, r2, r3
add r2.xyz, r2, r0
mov r0.xyz, v1
add oT2.xyz, r2, r1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mov r0, c10
dp4 r3.z, c15, r0
mov r0, c8
dp4 r3.x, c15, r0
mul r2.xyz, r1, v1.w
mov r1, c9
dp4 r3.y, c15, r1
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c33.z
mul r1.y, r1, c12.x
dp3 oT1.y, r3, r2
dp3 oT1.z, v2, r3
dp3 oT1.x, r3, v1
mad oT3.xy, r1.z, c13.zwzw, r1
mov oPos, r0
mov oT3.zw, r0
mad oT0.zw, v3.xyxy, c32.xyxy, c32
mad oT0.xy, v3, c31, c31.zwzw
"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_SSSC]
Float 3 [_Layer1Thickness]
Float 4 [_Layer2Thickness]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_ExitColorMap] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 34 ALU, 3 TEX
PARAM c[6] = { program.local[0..4],
		{ 2, 1, 0, 3 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R2.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
TEX R1.xyz, fragment.texcoord[0], texture[0], 2D;
TEX R0, fragment.texcoord[0], texture[2], 2D;
MAD R2.xy, R2.wyzw, c[5].x, -c[5].y;
MUL R1.w, R2.y, R2.y;
MAD R1.w, -R2.x, R2.x, -R1;
ADD R1.w, R1, c[5].y;
RSQ R1.w, R1.w;
RCP R2.z, R1.w;
DP3 R1.w, R2, fragment.texcoord[1];
MAX R1.w, R1, c[5].z;
MOV R2.w, c[4].x;
ADD R2.y, R2.w, c[3].x;
ADD R2.z, R2.y, c[5].y;
MOV_SAT R2.x, R1.w;
RCP R2.z, R2.z;
ADD R2.y, R1.w, R2;
MUL_SAT R2.y, R2, R2.z;
MAD R2.z, -R2.x, c[5].x, c[5].w;
MUL R2.x, R2, R2;
MUL R2.z, R2.x, R2;
MUL R2.x, R2.y, R2.y;
MAD R2.y, -R2, c[5].x, c[5].w;
MAD R2.x, R2, R2.y, -R2.z;
MAX R2.x, R2, c[5].z;
MUL R0.w, R2.x, R0;
MUL R1.xyz, R1, c[1];
MUL R3.xyz, R1.w, c[0];
MUL R2.xyz, R0.w, c[2];
MAD R0.xyz, R2, R0, R3;
MUL R0.xyz, R1, R0;
MUL R0.xyz, R0, c[5].x;
MAD result.color.xyz, R1, fragment.texcoord[2], R0;
MOV result.color.w, c[5].z;
END
# 34 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_SSSC]
Float 3 [_Layer1Thickness]
Float 4 [_Layer2Thickness]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_ExitColorMap] 2D
"ps_2_0
; 35 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c5, 2.00000000, -1.00000000, 1.00000000, 0.00000000
def c6, 2.00000000, 3.00000000, 0, 0
dcl t0
dcl t1.xyz
dcl t2.xyz
texld r5, t0, s0
texld r4, t0, s2
mov r0.y, t0.w
mov r0.x, t0.z
texld r0, r0, s1
mov r0.x, r0.w
mad_pp r1.xy, r0, c5.x, c5.y
mul_pp r0.x, r1.y, r1.y
mad_pp r0.x, -r1, r1, -r0
add_pp r0.x, r0, c5.z
rsq_pp r0.x, r0.x
rcp_pp r1.z, r0.x
mov r0.x, c3
add r2.x, c4, r0
dp3_pp r1.x, r1, t1
max_pp r0.x, r1, c5.w
add r3.x, r2, c5.z
mov_pp_sat r1.x, r0
add r2.x, r0, r2
rcp r3.x, r3.x
mul_sat r2.x, r2, r3
mad_pp r3.x, -r1, c6, c6.y
mul_pp r1.x, r1, r1
mul_pp r3.x, r1, r3
mul r1.x, r2, r2
mad r2.x, -r2, c6, c6.y
mad r1.x, r1, r2, -r3
max r1.x, r1, c5.w
mul r1.x, r1, r4.w
mul r1.xyz, r1.x, c2
mul_pp r0.xyz, r0.x, c0
mad r0.xyz, r1, r4, r0
mul_pp r1.xyz, r5, c1
mul r0.xyz, r1, r0
mul r0.xyz, r0, c5.x
mov_pp r0.w, c5
mad_pp r0.xyz, r1, t2, r0
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" }
Vector 0 [_Color]
SetTexture 0 [_MainTex] 2D
SetTexture 2 [unity_Lightmap] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 7 ALU, 2 TEX
PARAM c[2] = { program.local[0],
		{ 0, 8 } };
TEMP R0;
TEMP R1;
TEX R1.xyz, fragment.texcoord[0], texture[0], 2D;
TEX R0, fragment.texcoord[1], texture[2], 2D;
MUL R1.xyz, R1, c[0];
MUL R0.xyz, R0.w, R0;
MUL R0.xyz, R0, R1;
MUL result.color.xyz, R0, c[1].y;
MOV result.color.w, c[1].x;
END
# 7 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" }
Vector 0 [_Color]
SetTexture 0 [_MainTex] 2D
SetTexture 2 [unity_Lightmap] 2D
"ps_2_0
; 6 ALU, 2 TEX
dcl_2d s0
dcl_2d s2
def c1, 8.00000000, 0.00000000, 0, 0
dcl t0.xy
dcl t1.xy
texld r1, t0, s0
texld r0, t1, s2
mul_pp r0.xyz, r0.w, r0
mul_pp r1.xyz, r1, c0
mul_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c1.x
mov_pp r0.w, c1.y
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_SSSC]
Float 3 [_Layer1Thickness]
Float 4 [_Layer2Thickness]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_ShadowMapTexture] 2D
SetTexture 3 [_ExitColorMap] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 36 ALU, 4 TEX
PARAM c[6] = { program.local[0..4],
		{ 2, 1, 0, 3 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R2.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
TEX R1.xyz, fragment.texcoord[0], texture[0], 2D;
TEX R0, fragment.texcoord[0], texture[3], 2D;
TXP R2.x, fragment.texcoord[3], texture[2], 2D;
MAD R3.xy, R2.wyzw, c[5].x, -c[5].y;
MUL R1.w, R3.y, R3.y;
MAD R1.w, -R3.x, R3.x, -R1;
ADD R1.w, R1, c[5].y;
RSQ R1.w, R1.w;
RCP R3.z, R1.w;
MOV R1.w, c[4].x;
DP3 R2.y, R3, fragment.texcoord[1];
ADD R2.w, R1, c[3].x;
MAX R1.w, R2.y, c[5].z;
ADD R2.y, R2.w, c[5];
MOV_SAT R2.z, R1.w;
RCP R2.y, R2.y;
ADD R2.w, R1, R2;
MUL_SAT R3.x, R2.w, R2.y;
MAD R2.y, -R2.z, c[5].x, c[5].w;
MUL R2.z, R2, R2;
MUL R2.y, R2.z, R2;
MUL R2.w, R3.x, R3.x;
MAD R2.z, -R3.x, c[5].x, c[5].w;
MAD R2.y, R2.w, R2.z, -R2;
MAX R2.y, R2, c[5].z;
MUL R0.w, R2.y, R0;
MUL R2.yzw, R0.w, c[2].xxyz;
MUL R3.xyz, R1.w, c[0];
MUL R1.xyz, R1, c[1];
MAD R0.xyz, R2.yzww, R0, R3;
MUL R0.w, R2.x, c[5].x;
MUL R0.xyz, R1, R0;
MUL R0.xyz, R0, R0.w;
MAD result.color.xyz, R1, fragment.texcoord[2], R0;
MOV result.color.w, c[5].z;
END
# 36 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_SSSC]
Float 3 [_Layer1Thickness]
Float 4 [_Layer2Thickness]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_ShadowMapTexture] 2D
SetTexture 3 [_ExitColorMap] 2D
"ps_2_0
; 36 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c5, 2.00000000, -1.00000000, 1.00000000, 0.00000000
def c6, 2.00000000, 3.00000000, 0, 0
dcl t0
dcl t1.xyz
dcl t2.xyz
dcl t3
texld r5, t0, s0
texldp r6, t3, s2
texld r4, t0, s3
mov r0.y, t0.w
mov r0.x, t0.z
texld r0, r0, s1
mov r0.x, r0.w
mad_pp r1.xy, r0, c5.x, c5.y
mul_pp r0.x, r1.y, r1.y
mad_pp r0.x, -r1, r1, -r0
add_pp r0.x, r0, c5.z
rsq_pp r0.x, r0.x
rcp_pp r1.z, r0.x
mov r0.x, c3
add r2.x, c4, r0
dp3_pp r1.x, r1, t1
max_pp r0.x, r1, c5.w
add r3.x, r2, c5.z
mov_pp_sat r1.x, r0
add r2.x, r0, r2
rcp r3.x, r3.x
mul_sat r2.x, r2, r3
mad_pp r3.x, -r1, c6, c6.y
mul_pp r1.x, r1, r1
mul_pp r3.x, r1, r3
mul r1.x, r2, r2
mad r2.x, -r2, c6, c6.y
mad r1.x, r1, r2, -r3
max r1.x, r1, c5.w
mul r1.x, r1, r4.w
mul_pp r0.xyz, r0.x, c0
mul r1.xyz, r1.x, c2
mad r1.xyz, r1, r4, r0
mul_pp r2.xyz, r5, c1
mul_pp r0.x, r6, c5
mul r1.xyz, r2, r1
mul r0.xyz, r1, r0.x
mov_pp r0.w, c5
mad_pp r0.xyz, r2, t2, r0
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" }
Vector 0 [_Color]
SetTexture 0 [_MainTex] 2D
SetTexture 2 [_ShadowMapTexture] 2D
SetTexture 3 [unity_Lightmap] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 13 ALU, 3 TEX
PARAM c[2] = { program.local[0],
		{ 0, 8, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R2, fragment.texcoord[1], texture[3], 2D;
TEX R0.xyz, fragment.texcoord[0], texture[0], 2D;
TXP R3.x, fragment.texcoord[2], texture[2], 2D;
MUL R1.xyz, R2.w, R2;
MUL R2.xyz, R2, R3.x;
MUL R1.xyz, R1, c[1].y;
MUL R3.xyz, R1, R3.x;
MUL R2.xyz, R2, c[1].z;
MIN R1.xyz, R1, R2;
MAX R1.xyz, R1, R3;
MUL R0.xyz, R0, c[0];
MUL result.color.xyz, R0, R1;
MOV result.color.w, c[1].x;
END
# 13 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" }
Vector 0 [_Color]
SetTexture 0 [_MainTex] 2D
SetTexture 2 [_ShadowMapTexture] 2D
SetTexture 3 [unity_Lightmap] 2D
"ps_2_0
; 11 ALU, 3 TEX
dcl_2d s0
dcl_2d s2
dcl_2d s3
def c1, 8.00000000, 2.00000000, 0.00000000, 0
dcl t0.xy
dcl t1.xy
dcl t2
texld r1, t0, s0
texldp r3, t2, s2
texld r0, t1, s3
mul_pp r2.xyz, r0, r3.x
mul_pp r0.xyz, r0.w, r0
mul_pp r0.xyz, r0, c1.x
mul_pp r2.xyz, r2, c1.y
min_pp r2.xyz, r0, r2
mul_pp r0.xyz, r0, r3.x
max_pp r0.xyz, r2, r0
mul_pp r1.xyz, r1, c0
mul_pp r0.xyz, r1, r0
mov_pp r0.w, c1.z
mov_pp oC0, r0
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
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [unity_Scale]
Vector 18 [_WorldSpaceLightPos0]
Vector 19 [_MainTex_ST]
Vector 20 [_BumpMap_ST]
"!!ARBvp1.0
# 25 ALU
PARAM c[21] = { program.local[0],
		state.matrix.mvp,
		program.local[5..20] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[18];
DP4 R2.z, R0, c[11];
DP4 R2.x, R0, c[9];
DP4 R2.y, R0, c[10];
MAD R0.xyz, R2, c[17].w, -vertex.position;
MUL R1.xyz, R1, vertex.attrib[14].w;
DP3 result.texcoord[1].y, R0, R1;
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP4 result.texcoord[2].z, R0, c[15];
DP4 result.texcoord[2].y, R0, c[14];
DP4 result.texcoord[2].x, R0, c[13];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[20].xyxy, c[20];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[19], c[19].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 25 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [unity_Scale]
Vector 17 [_WorldSpaceLightPos0]
Vector 18 [_MainTex_ST]
Vector 19 [_BumpMap_ST]
"vs_2_0
; 28 ALU
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mov r0, c10
mul r2.xyz, r1, v1.w
dp4 r3.z, c17, r0
mov r0, c9
dp4 r3.y, c17, r0
mov r1, c8
dp4 r3.x, c17, r1
mad r0.xyz, r3, c16.w, -v0
dp3 oT1.y, r0, r2
dp3 oT1.z, v2, r0
dp3 oT1.x, r0, v1
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 oT2.z, r0, c14
dp4 oT2.y, r0, c13
dp4 oT2.x, r0, c12
mad oT0.zw, v3.xyxy, c19.xyxy, c19
mad oT0.xy, v3, c18, c18.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_World2Object]
Vector 9 [_WorldSpaceLightPos0]
Vector 10 [_MainTex_ST]
Vector 11 [_BumpMap_ST]
"!!ARBvp1.0
# 17 ALU
PARAM c[12] = { program.local[0],
		state.matrix.mvp,
		program.local[5..11] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R1, c[9];
DP4 R2.z, R1, c[7];
DP4 R2.y, R1, c[6];
DP4 R2.x, R1, c[5];
MUL R0.xyz, R0, vertex.attrib[14].w;
DP3 result.texcoord[1].y, R2, R0;
DP3 result.texcoord[1].z, vertex.normal, R2;
DP3 result.texcoord[1].x, R2, vertex.attrib[14];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[11].xyxy, c[11];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 17 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_World2Object]
Vector 8 [_WorldSpaceLightPos0]
Vector 9 [_MainTex_ST]
Vector 10 [_BumpMap_ST]
"vs_2_0
; 20 ALU
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mov r0, c6
dp4 r3.z, c8, r0
mul r2.xyz, r1, v1.w
mov r0, c5
mov r1, c4
dp4 r3.y, c8, r0
dp4 r3.x, c8, r1
dp3 oT1.y, r3, r2
dp3 oT1.z, v2, r3
dp3 oT1.x, r3, v1
mad oT0.zw, v3.xyxy, c10.xyxy, c10
mad oT0.xy, v3, c9, c9.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "opengl " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [unity_Scale]
Vector 18 [_WorldSpaceLightPos0]
Vector 19 [_MainTex_ST]
Vector 20 [_BumpMap_ST]
"!!ARBvp1.0
# 26 ALU
PARAM c[21] = { program.local[0],
		state.matrix.mvp,
		program.local[5..20] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[18];
DP4 R2.z, R0, c[11];
DP4 R2.x, R0, c[9];
DP4 R2.y, R0, c[10];
MAD R0.xyz, R2, c[17].w, -vertex.position;
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R0.w, vertex.position, c[8];
DP3 result.texcoord[1].y, R0, R1;
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP4 result.texcoord[2].w, R0, c[16];
DP4 result.texcoord[2].z, R0, c[15];
DP4 result.texcoord[2].y, R0, c[14];
DP4 result.texcoord[2].x, R0, c[13];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[20].xyxy, c[20];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[19], c[19].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 26 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [unity_Scale]
Vector 17 [_WorldSpaceLightPos0]
Vector 18 [_MainTex_ST]
Vector 19 [_BumpMap_ST]
"vs_2_0
; 29 ALU
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mov r0, c10
mul r2.xyz, r1, v1.w
dp4 r3.z, c17, r0
mov r0, c9
dp4 r3.y, c17, r0
mov r1, c8
dp4 r3.x, c17, r1
mad r0.xyz, r3, c16.w, -v0
dp4 r0.w, v0, c7
dp3 oT1.y, r0, r2
dp3 oT1.z, v2, r0
dp3 oT1.x, r0, v1
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 oT2.w, r0, c15
dp4 oT2.z, r0, c14
dp4 oT2.y, r0, c13
dp4 oT2.x, r0, c12
mad oT0.zw, v3.xyxy, c19.xyxy, c19
mad oT0.xy, v3, c18, c18.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [unity_Scale]
Vector 18 [_WorldSpaceLightPos0]
Vector 19 [_MainTex_ST]
Vector 20 [_BumpMap_ST]
"!!ARBvp1.0
# 25 ALU
PARAM c[21] = { program.local[0],
		state.matrix.mvp,
		program.local[5..20] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[18];
DP4 R2.z, R0, c[11];
DP4 R2.x, R0, c[9];
DP4 R2.y, R0, c[10];
MAD R0.xyz, R2, c[17].w, -vertex.position;
MUL R1.xyz, R1, vertex.attrib[14].w;
DP3 result.texcoord[1].y, R0, R1;
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP4 result.texcoord[2].z, R0, c[15];
DP4 result.texcoord[2].y, R0, c[14];
DP4 result.texcoord[2].x, R0, c[13];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[20].xyxy, c[20];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[19], c[19].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 25 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [unity_Scale]
Vector 17 [_WorldSpaceLightPos0]
Vector 18 [_MainTex_ST]
Vector 19 [_BumpMap_ST]
"vs_2_0
; 28 ALU
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mov r0, c10
mul r2.xyz, r1, v1.w
dp4 r3.z, c17, r0
mov r0, c9
dp4 r3.y, c17, r0
mov r1, c8
dp4 r3.x, c17, r1
mad r0.xyz, r3, c16.w, -v0
dp3 oT1.y, r0, r2
dp3 oT1.z, v2, r0
dp3 oT1.x, r0, v1
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 oT2.z, r0, c14
dp4 oT2.y, r0, c13
dp4 oT2.x, r0, c12
mad oT0.zw, v3.xyxy, c19.xyxy, c19
mad oT0.xy, v3, c18, c18.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [_WorldSpaceLightPos0]
Vector 18 [_MainTex_ST]
Vector 19 [_BumpMap_ST]
"!!ARBvp1.0
# 23 ALU
PARAM c[20] = { program.local[0],
		state.matrix.mvp,
		program.local[5..19] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R1, c[17];
MUL R0.xyz, R0, vertex.attrib[14].w;
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
DP3 result.texcoord[1].y, R2, R0;
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 result.texcoord[1].z, vertex.normal, R2;
DP3 result.texcoord[1].x, R2, vertex.attrib[14];
DP4 result.texcoord[2].y, R0, c[14];
DP4 result.texcoord[2].x, R0, c[13];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[19].xyxy, c[19];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[18], c[18].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 23 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [_WorldSpaceLightPos0]
Vector 17 [_MainTex_ST]
Vector 18 [_BumpMap_ST]
"vs_2_0
; 26 ALU
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mov r0, c10
dp4 r3.z, c16, r0
mov r0, c9
dp4 r3.y, c16, r0
mul r2.xyz, r1, v1.w
mov r1, c8
dp4 r3.x, c16, r1
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 oT1.y, r3, r2
dp3 oT1.z, v2, r3
dp3 oT1.x, r3, v1
dp4 oT2.y, r0, c13
dp4 oT2.x, r0, c12
mad oT0.zw, v3.xyxy, c18.xyxy, c18
mad oT0.xy, v3, c17, c17.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "POINT" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_SSSC]
Float 3 [_Layer1Thickness]
Float 4 [_Layer2Thickness]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_LightTexture0] 2D
SetTexture 3 [_ExitColorMap] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 39 ALU, 4 TEX
PARAM c[6] = { program.local[0..4],
		{ 0, 2, 1, 3 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R2.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
TEX R1.xyz, fragment.texcoord[0], texture[0], 2D;
TEX R0, fragment.texcoord[0], texture[3], 2D;
MAD R2.xy, R2.wyzw, c[5].y, -c[5].z;
MUL R2.z, R2.y, R2.y;
MAD R2.z, -R2.x, R2.x, -R2;
DP3 R1.w, fragment.texcoord[2], fragment.texcoord[2];
ADD R2.z, R2, c[5];
DP3 R2.w, fragment.texcoord[1], fragment.texcoord[1];
RSQ R2.w, R2.w;
MUL R3.xyz, R2.w, fragment.texcoord[1];
RSQ R2.z, R2.z;
RCP R2.z, R2.z;
DP3 R2.x, R2, R3;
MOV R2.w, c[4].x;
ADD R2.y, R2.w, c[3].x;
MAX R2.x, R2, c[5];
ADD R2.z, R2.y, c[5];
MOV_SAT R2.w, R2.x;
MAD R3.x, -R2.w, c[5].y, c[5].w;
RCP R2.z, R2.z;
ADD R2.y, R2.x, R2;
MUL_SAT R2.y, R2, R2.z;
MUL R2.z, R2.w, R2.w;
MUL R2.w, R2.z, R3.x;
MUL R2.z, R2.y, R2.y;
MAD R2.y, -R2, c[5], c[5].w;
MAD R2.y, R2.z, R2, -R2.w;
MAX R2.y, R2, c[5].x;
MUL R0.w, R2.y, R0;
MUL R3.xyz, R2.x, c[0];
MUL R2.xyz, R0.w, c[2];
MAD R0.xyz, R2, R0, R3;
MUL R1.xyz, R1, c[1];
MUL R0.xyz, R1, R0;
MOV result.color.w, c[5].x;
TEX R1.w, R1.w, texture[2], 2D;
MUL R0.w, R1, c[5].y;
MUL result.color.xyz, R0, R0.w;
END
# 39 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_SSSC]
Float 3 [_Layer1Thickness]
Float 4 [_Layer2Thickness]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_LightTexture0] 2D
SetTexture 3 [_ExitColorMap] 2D
"ps_2_0
; 40 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c5, 2.00000000, -1.00000000, 1.00000000, 0.00000000
def c6, 2.00000000, 3.00000000, 0, 0
dcl t0
dcl t1.xyz
dcl t2.xyz
texld r5, t0, s0
texld r4, t0, s3
dp3 r1.x, t2, t2
mov r1.xy, r1.x
mov r0.y, t0.w
mov r0.x, t0.z
texld r6, r1, s2
texld r0, r0, s1
mov r0.x, r0.w
mad_pp r2.xy, r0, c5.x, c5.y
mul_pp r0.x, r2.y, r2.y
mad_pp r0.x, -r2, r2, -r0
add_pp r0.x, r0, c5.z
rsq_pp r0.x, r0.x
rcp_pp r2.z, r0.x
dp3_pp r1.x, t1, t1
rsq_pp r1.x, r1.x
mul_pp r1.xyz, r1.x, t1
dp3_pp r1.x, r2, r1
mov r0.x, c3
add r2.x, c4, r0
max_pp r0.x, r1, c5.w
add r3.x, r2, c5.z
mov_pp_sat r1.x, r0
add r2.x, r0, r2
rcp r3.x, r3.x
mul_sat r2.x, r2, r3
mad_pp r3.x, -r1, c6, c6.y
mul_pp r1.x, r1, r1
mul_pp r3.x, r1, r3
mul r1.x, r2, r2
mad r2.x, -r2, c6, c6.y
mad r1.x, r1, r2, -r3
max r1.x, r1, c5.w
mul r1.x, r1, r4.w
mul_pp r0.xyz, r0.x, c0
mul r1.xyz, r1.x, c2
mad r1.xyz, r1, r4, r0
mul_pp r2.xyz, r5, c1
mul_pp r0.x, r6, c5
mul r1.xyz, r2, r1
mul r0.xyz, r1, r0.x
mov_pp r0.w, c5
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_SSSC]
Float 3 [_Layer1Thickness]
Float 4 [_Layer2Thickness]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_ExitColorMap] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 33 ALU, 3 TEX
PARAM c[6] = { program.local[0..4],
		{ 0, 2, 1, 3 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R2.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
TEX R1.xyz, fragment.texcoord[0], texture[0], 2D;
TEX R0, fragment.texcoord[0], texture[2], 2D;
MAD R2.xy, R2.wyzw, c[5].y, -c[5].z;
MUL R1.w, R2.y, R2.y;
MAD R1.w, -R2.x, R2.x, -R1;
ADD R1.w, R1, c[5].z;
RSQ R1.w, R1.w;
RCP R2.z, R1.w;
DP3 R1.w, R2, fragment.texcoord[1];
MAX R1.w, R1, c[5].x;
MOV R2.w, c[4].x;
ADD R2.y, R2.w, c[3].x;
ADD R2.z, R2.y, c[5];
MOV_SAT R2.x, R1.w;
RCP R2.z, R2.z;
ADD R2.y, R1.w, R2;
MUL_SAT R2.y, R2, R2.z;
MAD R2.z, -R2.x, c[5].y, c[5].w;
MUL R2.x, R2, R2;
MUL R2.z, R2.x, R2;
MUL R2.x, R2.y, R2.y;
MAD R2.y, -R2, c[5], c[5].w;
MAD R2.x, R2, R2.y, -R2.z;
MAX R2.x, R2, c[5];
MUL R0.w, R2.x, R0;
MUL R3.xyz, R1.w, c[0];
MUL R2.xyz, R0.w, c[2];
MAD R0.xyz, R2, R0, R3;
MUL R1.xyz, R1, c[1];
MUL R0.xyz, R1, R0;
MUL result.color.xyz, R0, c[5].y;
MOV result.color.w, c[5].x;
END
# 33 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_SSSC]
Float 3 [_Layer1Thickness]
Float 4 [_Layer2Thickness]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_ExitColorMap] 2D
"ps_2_0
; 34 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c5, 2.00000000, -1.00000000, 1.00000000, 0.00000000
def c6, 2.00000000, 3.00000000, 0, 0
dcl t0
dcl t1.xyz
texld r5, t0, s0
texld r4, t0, s2
mov r0.y, t0.w
mov r0.x, t0.z
texld r0, r0, s1
mov r0.x, r0.w
mad_pp r1.xy, r0, c5.x, c5.y
mul_pp r0.x, r1.y, r1.y
mad_pp r0.x, -r1, r1, -r0
add_pp r0.x, r0, c5.z
rsq_pp r0.x, r0.x
rcp_pp r1.z, r0.x
mov r0.x, c3
add r2.x, c4, r0
dp3_pp r1.x, r1, t1
max_pp r0.x, r1, c5.w
add r3.x, r2, c5.z
mov_pp_sat r1.x, r0
add r2.x, r0, r2
rcp r3.x, r3.x
mul_sat r2.x, r2, r3
mad_pp r3.x, -r1, c6, c6.y
mul_pp r1.x, r1, r1
mul_pp r3.x, r1, r3
mul r1.x, r2, r2
mad r2.x, -r2, c6, c6.y
mad r1.x, r1, r2, -r3
max r1.x, r1, c5.w
mul r1.x, r1, r4.w
mul r1.xyz, r1.x, c2
mul_pp r0.xyz, r0.x, c0
mad r0.xyz, r1, r4, r0
mul_pp r1.xyz, r5, c1
mul r0.xyz, r1, r0
mul r0.xyz, r0, c5.x
mov_pp r0.w, c5
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "SPOT" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_SSSC]
Float 3 [_Layer1Thickness]
Float 4 [_Layer2Thickness]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_LightTexture0] 2D
SetTexture 3 [_LightTextureB0] 2D
SetTexture 4 [_ExitColorMap] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 45 ALU, 5 TEX
PARAM c[7] = { program.local[0..4],
		{ 0, 2, 1, 3 },
		{ 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R2, fragment.texcoord[0], texture[4], 2D;
TEX R3.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
RCP R0.x, fragment.texcoord[2].w;
MAD R1.xy, fragment.texcoord[2], R0.x, c[6].x;
DP3 R1.z, fragment.texcoord[2], fragment.texcoord[2];
DP3 R3.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R3.x, R3.x;
MOV result.color.w, c[5].x;
TEX R0.w, R1, texture[2], 2D;
TEX R0.xyz, fragment.texcoord[0], texture[0], 2D;
TEX R1.w, R1.z, texture[3], 2D;
MAD R1.xy, R3.wyzw, c[5].y, -c[5].z;
MUL R1.z, R1.y, R1.y;
MAD R1.z, -R1.x, R1.x, -R1;
ADD R1.z, R1, c[5];
RSQ R1.z, R1.z;
MUL R3.xyz, R3.x, fragment.texcoord[1];
RCP R1.z, R1.z;
DP3 R1.x, R1, R3;
MAX R1.x, R1, c[5];
MOV R3.w, c[4].x;
ADD R1.z, R3.w, c[3].x;
ADD R3.x, R1.z, c[5].z;
MOV_SAT R1.y, R1.x;
RCP R3.x, R3.x;
ADD R1.z, R1.x, R1;
MUL_SAT R1.z, R1, R3.x;
MAD R3.x, -R1.y, c[5].y, c[5].w;
MUL R1.y, R1, R1;
MUL R3.x, R1.y, R3;
MUL R1.y, R1.z, R1.z;
MAD R1.z, -R1, c[5].y, c[5].w;
MAD R1.y, R1, R1.z, -R3.x;
MAX R1.y, R1, c[5].x;
MUL R3.xyz, R1.x, c[0];
MUL R1.y, R1, R2.w;
MUL R1.xyz, R1.y, c[2];
MAD R1.xyz, R1, R2, R3;
SLT R2.x, c[5], fragment.texcoord[2].z;
MUL R0.w, R2.x, R0;
MUL R0.w, R0, R1;
MUL R0.xyz, R0, c[1];
MUL R0.w, R0, c[5].y;
MUL R0.xyz, R0, R1;
MUL result.color.xyz, R0, R0.w;
END
# 45 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_SSSC]
Float 3 [_Layer1Thickness]
Float 4 [_Layer2Thickness]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_LightTexture0] 2D
SetTexture 3 [_LightTextureB0] 2D
SetTexture 4 [_ExitColorMap] 2D
"ps_2_0
; 47 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c5, 2.00000000, -1.00000000, 1.00000000, 0.00000000
def c6, 2.00000000, 3.00000000, 0.50000000, 0
dcl t0
dcl t1.xyz
dcl t2
texld r5, t0, s0
texld r4, t0, s4
dp3 r2.x, t2, t2
mov r2.xy, r2.x
mov r0.y, t0.w
mov r0.x, t0.z
mov r1.xy, r0
rcp r0.x, t2.w
mad r0.xy, t2, r0.x, c6.z
texld r1, r1, s1
texld r6, r2, s3
texld r0, r0, s2
dp3_pp r1.x, t1, t1
mov r0.y, r1
mov r0.x, r1.w
mad_pp r2.xy, r0, c5.x, c5.y
mul_pp r0.x, r2.y, r2.y
mad_pp r0.x, -r2, r2, -r0
add_pp r0.x, r0, c5.z
rsq_pp r0.x, r0.x
rcp_pp r2.z, r0.x
rsq_pp r1.x, r1.x
mul_pp r1.xyz, r1.x, t1
dp3_pp r1.x, r2, r1
mov r0.x, c3
add r2.x, c4, r0
max_pp r0.x, r1, c5.w
add r3.x, r2, c5.z
mov_pp_sat r1.x, r0
add r2.x, r0, r2
mul_pp r0.xyz, r0.x, c0
rcp r3.x, r3.x
mul_sat r2.x, r2, r3
mad_pp r3.x, -r1, c6, c6.y
mul_pp r1.x, r1, r1
mul_pp r3.x, r1, r3
mul r1.x, r2, r2
mad r2.x, -r2, c6, c6.y
mad r1.x, r1, r2, -r3
max r1.x, r1, c5.w
mul r1.x, r1, r4.w
mul r1.xyz, r1.x, c2
mad r1.xyz, r1, r4, r0
cmp r0.x, -t2.z, c5.w, c5.z
mul_pp r0.x, r0, r0.w
mul_pp r0.x, r0, r6
mul_pp r2.xyz, r5, c1
mul_pp r0.x, r0, c5
mul r1.xyz, r2, r1
mul r0.xyz, r1, r0.x
mov_pp r0.w, c5
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_SSSC]
Float 3 [_Layer1Thickness]
Float 4 [_Layer2Thickness]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_LightTextureB0] 2D
SetTexture 3 [_LightTexture0] CUBE
SetTexture 4 [_ExitColorMap] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 41 ALU, 5 TEX
PARAM c[6] = { program.local[0..4],
		{ 0, 2, 1, 3 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R3.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
TEX R0.xyz, fragment.texcoord[0], texture[0], 2D;
TEX R2, fragment.texcoord[0], texture[4], 2D;
TEX R1.w, fragment.texcoord[2], texture[3], CUBE;
MAD R1.xy, R3.wyzw, c[5].y, -c[5].z;
MUL R1.z, R1.y, R1.y;
MAD R1.z, -R1.x, R1.x, -R1;
DP3 R0.w, fragment.texcoord[2], fragment.texcoord[2];
ADD R1.z, R1, c[5];
DP3 R3.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R1.z, R1.z;
RSQ R3.x, R3.x;
MUL R3.xyz, R3.x, fragment.texcoord[1];
RCP R1.z, R1.z;
DP3 R1.x, R1, R3;
MAX R1.x, R1, c[5];
MOV R3.w, c[4].x;
ADD R1.z, R3.w, c[3].x;
ADD R3.x, R1.z, c[5].z;
MOV_SAT R1.y, R1.x;
RCP R3.x, R3.x;
ADD R1.z, R1.x, R1;
MUL_SAT R1.z, R1, R3.x;
MAD R3.x, -R1.y, c[5].y, c[5].w;
MUL R1.y, R1, R1;
MUL R3.x, R1.y, R3;
MUL R1.y, R1.z, R1.z;
MAD R1.z, -R1, c[5].y, c[5].w;
MAD R1.y, R1, R1.z, -R3.x;
MAX R1.y, R1, c[5].x;
MUL R3.xyz, R1.x, c[0];
MUL R1.y, R1, R2.w;
MUL R1.xyz, R1.y, c[2];
MAD R1.xyz, R1, R2, R3;
MUL R0.xyz, R0, c[1];
MUL R0.xyz, R0, R1;
MOV result.color.w, c[5].x;
TEX R0.w, R0.w, texture[2], 2D;
MUL R0.w, R0, R1;
MUL R0.w, R0, c[5].y;
MUL result.color.xyz, R0, R0.w;
END
# 41 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_SSSC]
Float 3 [_Layer1Thickness]
Float 4 [_Layer2Thickness]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_LightTextureB0] 2D
SetTexture 3 [_LightTexture0] CUBE
SetTexture 4 [_ExitColorMap] 2D
"ps_2_0
; 42 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_cube s3
dcl_2d s4
def c5, 2.00000000, -1.00000000, 1.00000000, 0.00000000
def c6, 2.00000000, 3.00000000, 0, 0
dcl t0
dcl t1.xyz
dcl t2.xyz
texld r5, t0, s0
texld r4, t0, s4
dp3 r0.x, t2, t2
mov r0.xy, r0.x
mov r1.y, t0.w
mov r1.x, t0.z
texld r6, r0, s2
texld r1, r1, s1
texld r0, t2, s3
dp3_pp r1.x, t1, t1
mov r0.y, r1
mov r0.x, r1.w
mad_pp r2.xy, r0, c5.x, c5.y
mul_pp r0.x, r2.y, r2.y
mad_pp r0.x, -r2, r2, -r0
add_pp r0.x, r0, c5.z
rsq_pp r0.x, r0.x
rcp_pp r2.z, r0.x
rsq_pp r1.x, r1.x
mul_pp r1.xyz, r1.x, t1
dp3_pp r1.x, r2, r1
mov r0.x, c3
add r2.x, c4, r0
max_pp r0.x, r1, c5.w
add r3.x, r2, c5.z
mov_pp_sat r1.x, r0
add r2.x, r0, r2
mul_pp r0.xyz, r0.x, c0
rcp r3.x, r3.x
mul_sat r2.x, r2, r3
mad_pp r3.x, -r1, c6, c6.y
mul_pp r1.x, r1, r1
mul_pp r3.x, r1, r3
mul r1.x, r2, r2
mad r2.x, -r2, c6, c6.y
mad r1.x, r1, r2, -r3
max r1.x, r1, c5.w
mul r1.x, r1, r4.w
mul r1.xyz, r1.x, c2
mad r1.xyz, r1, r4, r0
mul_pp r2.xyz, r5, c1
mul r0.x, r6, r0.w
mul_pp r0.x, r0, c5
mul r1.xyz, r2, r1
mul r0.xyz, r1, r0.x
mov_pp r0.w, c5
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_SSSC]
Float 3 [_Layer1Thickness]
Float 4 [_Layer2Thickness]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_LightTexture0] 2D
SetTexture 3 [_ExitColorMap] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 35 ALU, 4 TEX
PARAM c[6] = { program.local[0..4],
		{ 0, 2, 1, 3 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R2.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
TEX R1.xyz, fragment.texcoord[0], texture[0], 2D;
TEX R0, fragment.texcoord[0], texture[3], 2D;
TEX R1.w, fragment.texcoord[2], texture[2], 2D;
MAD R2.xy, R2.wyzw, c[5].y, -c[5].z;
MUL R2.z, R2.y, R2.y;
MAD R2.z, -R2.x, R2.x, -R2;
ADD R2.z, R2, c[5];
RSQ R2.z, R2.z;
RCP R2.z, R2.z;
DP3 R2.x, R2, fragment.texcoord[1];
MOV R2.w, c[4].x;
ADD R2.y, R2.w, c[3].x;
MAX R2.x, R2, c[5];
ADD R2.z, R2.y, c[5];
MOV_SAT R2.w, R2.x;
MAD R3.x, -R2.w, c[5].y, c[5].w;
RCP R2.z, R2.z;
ADD R2.y, R2.x, R2;
MUL_SAT R2.y, R2, R2.z;
MUL R2.z, R2.w, R2.w;
MUL R2.w, R2.z, R3.x;
MUL R2.z, R2.y, R2.y;
MAD R2.y, -R2, c[5], c[5].w;
MAD R2.y, R2.z, R2, -R2.w;
MAX R2.y, R2, c[5].x;
MUL R0.w, R2.y, R0;
MUL R3.xyz, R2.x, c[0];
MUL R2.xyz, R0.w, c[2];
MAD R0.xyz, R2, R0, R3;
MUL R1.xyz, R1, c[1];
MUL R0.w, R1, c[5].y;
MUL R0.xyz, R1, R0;
MUL result.color.xyz, R0, R0.w;
MOV result.color.w, c[5].x;
END
# 35 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_SSSC]
Float 3 [_Layer1Thickness]
Float 4 [_Layer2Thickness]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_LightTexture0] 2D
SetTexture 3 [_ExitColorMap] 2D
"ps_2_0
; 37 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c5, 2.00000000, -1.00000000, 1.00000000, 0.00000000
def c6, 2.00000000, 3.00000000, 0, 0
dcl t0
dcl t1.xyz
dcl t2.xy
texld r5, t0, s0
texld r4, t0, s3
mov r0.y, t0.w
mov r0.x, t0.z
mov r1.xy, r0
texld r1, r1, s1
texld r0, t2, s2
mov r0.y, r1
mov r0.x, r1.w
mad_pp r1.xy, r0, c5.x, c5.y
mul_pp r0.x, r1.y, r1.y
mad_pp r0.x, -r1, r1, -r0
add_pp r0.x, r0, c5.z
rsq_pp r0.x, r0.x
rcp_pp r1.z, r0.x
mov r0.x, c3
add r2.x, c4, r0
dp3_pp r1.x, r1, t1
max_pp r0.x, r1, c5.w
add r3.x, r2, c5.z
mov_pp_sat r1.x, r0
add r2.x, r0, r2
mul_pp r0.xyz, r0.x, c0
rcp r3.x, r3.x
mul_sat r2.x, r2, r3
mad_pp r3.x, -r1, c6, c6.y
mul_pp r1.x, r1, r1
mul_pp r3.x, r1, r3
mul r1.x, r2, r2
mad r2.x, -r2, c6, c6.y
mad r1.x, r1, r2, -r3
max r1.x, r1, c5.w
mul r1.x, r1, r4.w
mul r1.xyz, r1.x, c2
mad r1.xyz, r1, r4, r0
mul_pp r0.x, r0.w, c5
mul_pp r2.xyz, r5, c1
mul r1.xyz, r2, r1
mul r0.xyz, r1, r0.x
mov_pp r0.w, c5
mov_pp oC0, r0
"
}
}
 }
}
Fallback "VertexLit"
}