Shader "Chickenlord/Parallax Shaded Specular" {
Properties {
 _Color ("Main Color", Color) = (1,1,1,1)
 _SpecColor ("Specular Color", Color) = (0.5,0.5,0.5,1)
 _Shininess ("Shininess", Range(0.01,1)) = 0.078125
 _Parallax ("Height", Range(0.005,0.08)) = 0.02
 _MainTex ("Base (RGB) Gloss (A)", 2D) = "white" {}
 _BumpMap ("Normalmap", 2D) = "bump" {}
 _ParallaxMap ("Heightmap (A)", 2D) = "black" {}
 _ShadeRange ("Shading Range", Float) = 0.02
 _ShadingStrength ("Shading Strength", Range(0,1)) = 1
}
SubShader { 
 LOD 600
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
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" ATTR14
Matrix 9 [_World2Object]
Vector 13 [unity_Scale]
Vector 14 [_WorldSpaceCameraPos]
Vector 16 [unity_LightmapST]
Vector 17 [_MainTex_ST]
Vector 18 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 20 ALU
PARAM c[19] = { { 1 },
		state.matrix.mvp,
		program.local[5..18] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R1.xyz, R0, vertex.attrib[14].w;
MOV R0.xyz, c[14];
MOV R0.w, c[0].x;
DP4 R2.z, R0, c[11];
DP4 R2.x, R0, c[9];
DP4 R2.y, R0, c[10];
MAD R0.xyz, R2, c[13].w, -vertex.position;
DP3 result.texcoord[1].y, R0, R1;
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[18].xyxy, c[18];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[17], c[17].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[1], c[16], c[16].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 20 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 8 [_World2Object]
Vector 12 [unity_Scale]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [unity_LightmapST]
Vector 15 [_MainTex_ST]
Vector 16 [_BumpMap_ST]
"vs_3_0
; 21 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
def c17, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r1.xyz, r0, v1.w
mov r0.xyz, c13
mov r0.w, c17.x
dp4 r2.z, r0, c10
dp4 r2.x, r0, c8
dp4 r2.y, r0, c9
mad r0.xyz, r2, c12.w, -v0
dp3 o2.y, r0, r1
dp3 o2.z, v2, r0
dp3 o2.x, r0, v1
mad o1.zw, v3.xyxy, c16.xyxy, c16
mad o1.xy, v3, c15, c15.zwzw
mad o3.xy, v4, c14, c14.zwzw
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
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" ATTR14
Matrix 9 [_World2Object]
Vector 13 [_ProjectionParams]
Vector 14 [unity_Scale]
Vector 15 [_WorldSpaceCameraPos]
Vector 17 [unity_LightmapST]
Vector 18 [_MainTex_ST]
Vector 19 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 25 ALU
PARAM c[20] = { { 1, 0.5 },
		state.matrix.mvp,
		program.local[5..19] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R0.xyz, R0, vertex.attrib[14].w;
MOV R1.xyz, c[15];
MOV R1.w, c[0].x;
DP4 R0.w, vertex.position, c[4];
DP4 R2.z, R1, c[11];
DP4 R2.x, R1, c[9];
DP4 R2.y, R1, c[10];
MAD R2.xyz, R2, c[14].w, -vertex.position;
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
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[19].xyxy, c[19];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[18], c[18].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[1], c[17], c[17].zwzw;
END
# 25 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 8 [_World2Object]
Vector 12 [_ProjectionParams]
Vector 13 [_ScreenParams]
Vector 14 [unity_Scale]
Vector 15 [_WorldSpaceCameraPos]
Vector 16 [unity_LightmapST]
Vector 17 [_MainTex_ST]
Vector 18 [_BumpMap_ST]
"vs_3_0
; 26 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c19, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r0.xyz, r0, v1.w
mov r1.xyz, c15
mov r1.w, c19.x
dp4 r0.w, v0, c3
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c14.w, -v0
dp3 o2.y, r2, r0
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c19.y
mul r1.y, r1, c12.x
dp3 o2.z, v2, r2
dp3 o2.x, r2, v1
mad o4.xy, r1.z, c13.zwzw, r1
mov o0, r0
mov o4.zw, r0
mad o1.zw, v3.xyxy, c18.xyxy, c18
mad o1.xy, v3, c17, c17.zwzw
mad o3.xy, v4, c16, c16.zwzw
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
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_Parallax]
Float 5 [_ShadingStrength]
Float 6 [_ShadeRange]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_BumpMap] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 115 ALU, 10 TEX
PARAM c[9] = { program.local[0..6],
		{ 0.5, 0.41999999, 2, 1 },
		{ 0.14285715, 0, 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.x, c[4];
ADD R0.x, R0, c[6];
MUL R0.xyz, -fragment.texcoord[2], R0.x;
MAD R2.xy, -R0, c[8].x, fragment.texcoord[0].zwzw;
MAD R2.zw, -R0.xyxy, c[8].x, R2.xyxy;
MAD R1.xy, -R0, c[8].x, R2.zwzw;
TEX R2.w, R2.zwzw, texture[0], 2D;
TEX R1.w, R1, texture[0], 2D;
TEX R0.w, fragment.texcoord[0].zwzw, texture[0], 2D;
TEX R3.w, R2, texture[0], 2D;
ADD R2.x, -R0.w, R3.w;
ADD R2.y, -R2.x, c[7].w;
ADD R1.z, R0, R2.w;
ADD R2.x, R0.z, R3.w;
MAD R1.xy, -R0, c[8].x, R1;
SLT R2.x, R0.w, R2;
SLT R2.z, R2.y, c[7].w;
MUL R2.z, R2.x, R2;
CMP R2.z, -R2, R2.y, c[7].w;
ADD R2.x, -R0.w, R2.w;
ADD R2.y, -R2.x, c[7].w;
SLT R2.x, R2.y, R2.z;
SLT R1.z, R0.w, R1;
MUL R1.z, R1, R2.x;
CMP R1.z, -R1, R2.y, R2;
ADD R2.x, -R0.w, R1.w;
ADD R2.y, R0.z, R1.w;
TEX R1.w, R1, texture[0], 2D;
ADD R2.x, -R2, c[7].w;
MAD R1.xy, -R0, c[8].x, R1;
SLT R2.z, R2.x, R1;
SLT R2.y, R0.w, R2;
MUL R2.z, R2.y, R2;
ADD R2.y, -R0.w, R1.w;
CMP R1.z, -R2, R2.x, R1;
ADD R2.x, -R2.y, c[7].w;
ADD R2.y, R0.z, R1.w;
TEX R1.w, R1, texture[0], 2D;
MAD R1.xy, -R0, c[8].x, R1;
SLT R2.z, R2.x, R1;
SLT R2.y, R0.w, R2;
MUL R2.z, R2.y, R2;
ADD R2.y, -R0.w, R1.w;
CMP R1.z, -R2, R2.x, R1;
ADD R2.x, -R2.y, c[7].w;
ADD R1.w, R0.z, R1;
SLT R2.y, R2.x, R1.z;
SLT R1.w, R0, R1;
MUL R2.y, R1.w, R2;
TEX R1.w, R1, texture[0], 2D;
CMP R2.y, -R2, R2.x, R1.z;
MAD R1.xy, -R0, c[8].x, R1;
ADD R1.z, R0, R1.w;
ADD R2.x, -R0.w, R1.w;
ADD R1.w, -R2.x, c[7];
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R2.w, R0.x;
SLT R2.x, R1.w, R2.y;
SLT R1.z, R0.w, R1;
MUL R1.z, R1, R2.x;
CMP R1.z, -R1, R1.w, R2.y;
TEX R1.w, R1, texture[0], 2D;
MUL R2.xyz, R2.w, fragment.texcoord[1];
ADD R0.x, -R0.w, R1.w;
ADD R3.z, -R0.x, c[7].w;
ADD R0.y, R2.z, c[7];
MOV R0.x, c[4];
MUL R1.x, R0, c[7];
RCP R0.y, R0.y;
MUL R0.xy, R2, R0.y;
MAD R3.x, R0.w, c[4], -R1;
MAD R1.xy, R3.x, R0, fragment.texcoord[0].zwzw;
TEX R3.yw, R1, texture[2], 2D;
ADD R0.z, R1.w, R0;
MAD R1.xy, R3.wyzw, c[7].z, -c[7].w;
SLT R0.w, R0, R0.z;
SLT R2.x, R3.z, R1.z;
MUL R0.w, R0, R2.x;
MUL R0.z, R1.y, R1.y;
MOV R2.xyz, fragment.texcoord[2];
MAD R2.xyz, R2.w, fragment.texcoord[1], R2;
DP3 R2.w, R2, R2;
RSQ R2.w, R2.w;
CMP R1.z, -R0.w, R3, R1;
MAD R0.z, -R1.x, R1.x, -R0;
ADD R0.w, R0.z, c[7];
MOV R0.z, c[7].w;
ADD R0.z, R0, -c[5].x;
MAD R1.w, R0.z, R1.z, c[5].x;
RSQ R0.w, R0.w;
RCP R0.z, R0.w;
MUL R1.z, R0, R1.w;
DP3 R0.z, R1, fragment.texcoord[2];
MAX R0.z, R0, c[8].y;
MUL R2.xyz, R2.w, R2;
DP3 R1.x, R1, R2;
MUL R1.w, R1, R0.z;
MAD R0.xy, R3.x, R0, fragment.texcoord[0];
TEX R0, R0, texture[1], 2D;
MUL R0.xyz, R0, c[2];
MUL R3.xyz, R0, c[0];
MUL R3.xyz, R3, R1.w;
MOV R1.w, c[8].z;
MUL R1.y, R1.w, c[3].x;
MAX R1.x, R1, c[8].y;
POW R2.x, R1.x, R1.y;
MOV R1, c[1];
MUL R2.x, R0.w, R2;
MUL R1.xyz, R1, c[0];
MAD R1.xyz, R1, R2.x, R3;
MUL R1.xyz, R1, c[7].z;
MAD result.color.xyz, R0, fragment.texcoord[3], R1;
MUL R0.y, R0.w, c[2].w;
MUL R0.x, R1.w, c[0].w;
MAD result.color.w, R2.x, R0.x, R0.y;
END
# 115 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_Parallax]
Float 5 [_ShadingStrength]
Float 6 [_ShadeRange]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_BumpMap] 2D
"ps_3_0
; 122 ALU, 10 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c7, 0.50000000, 0.41999999, 2.00000000, -1.00000000
def c8, 1.00000000, 0.14285715, 0.00000000, 128.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
mov r0.x, c6
add r0.x, c4, r0
mul r0.xyz, -v2, r0.x
mad r2.xy, -r0, c8.y, v0.zwzw
mad r3.xy, -r0, c8.y, r2
mad r1.xy, -r0, c8.y, r3
texld r3.w, r3, s0
texld r1.w, r1, s0
texld r0.w, v0.zwzw, s0
texld r2.w, r2, s0
add r2.x, r0.z, r2.w
add r2.y, -r0.w, r3.w
add r2.w, -r0, r2
cmp r3.x, -r2.w, c8.z, c8
add r2.x, r0.w, -r2
cmp r2.x, r2, c8.z, c8
add r1.z, -r0.w, r1.w
add r2.z, r0, r3.w
mul_pp r2.x, r2, r3
add r2.w, -r2, c8.x
cmp r2.w, -r2.x, c8.x, r2
add r2.x, r0.w, -r2.z
add r2.y, -r2, c8.x
add r3.x, -r2.w, r2.y
mad r1.xy, -r0, c8.y, r1
cmp r2.x, r2, c8.z, c8
cmp r2.z, r3.x, c8, c8.x
mul_pp r2.z, r2.x, r2
cmp r2.y, -r2.z, r2.w, r2
add r2.z, r0, r1.w
texld r1.w, r1, s0
add r2.x, -r1.z, c8
add r1.z, -r2.y, r2.x
add r2.z, r0.w, -r2
add r2.w, -r0, r1
mad r1.xy, -r0, c8.y, r1
cmp r1.z, r1, c8, c8.x
cmp r2.z, r2, c8, c8.x
mul_pp r2.z, r2, r1
cmp r2.y, -r2.z, r2, r2.x
add r2.z, r0, r1.w
add r1.z, -r2.w, c8.x
texld r1.w, r1, s0
mad r1.xy, -r0, c8.y, r1
add r2.x, -r2.y, r1.z
add r2.z, r0.w, -r2
mad r0.xy, -r0, c8.y, r1
add r2.w, -r0, r1
cmp r2.x, r2, c8.z, c8
cmp r2.z, r2, c8, c8.x
mul_pp r2.z, r2, r2.x
cmp r2.y, -r2.z, r2, r1.z
add r2.z, r0, r1.w
texld r1.w, r1, s0
add r2.x, -r2.w, c8
add r1.z, -r2.y, r2.x
add r2.z, r0.w, -r2
add r2.w, -r0, r1
add r1.x, r0.z, r1.w
texld r1.w, r0, s0
add r0.x, r0.w, -r1
add r0.y, -r0.w, r1.w
add r1.x, r1.w, r0.z
add r1.w, r0, -r1.x
cmp r1.z, r1, c8, c8.x
cmp r2.z, r2, c8, c8.x
mul_pp r2.z, r2, r1
cmp r2.y, -r2.z, r2, r2.x
add r1.z, -r2.w, c8.x
add r2.x, -r2.y, r1.z
cmp r2.x, r2, c8.z, c8
cmp r0.x, r0, c8.z, c8
mul_pp r0.x, r0, r2
cmp r1.z, -r0.x, r2.y, r1
add r2.x, -r0.y, c8
add r0.y, -r1.z, r2.x
dp3_pp r0.x, v1, v1
rsq_pp r2.w, r0.x
cmp r2.y, r0, c8.z, c8.x
mul_pp r0.xyz, r2.w, v1
add r1.x, r0.z, c7.y
mov_pp r0.z, c7.x
mul_pp r0.z, c4.x, r0
mad_pp r0.w, r0, c4.x, -r0.z
cmp r0.z, r1.w, c8, c8.x
mul_pp r0.z, r0, r2.y
cmp r1.w, -r0.z, r1.z, r2.x
rcp r1.x, r1.x
mul r1.xy, r0, r1.x
mad r0.xy, r0.w, r1, v0.zwzw
texld r3.yw, r0, s2
mad_pp r0.xy, r3.wyzw, c7.z, c7.w
mul_pp r0.z, r0.y, r0.y
mad_pp r0.z, -r0.x, r0.x, -r0
mov r1.z, c5.x
add r1.z, c8.x, -r1
add_pp r0.z, r0, c8.x
mov_pp r2.xyz, v2
rsq_pp r0.z, r0.z
mad r1.z, r1, r1.w, c5.x
mad_pp r2.xyz, r2.w, v1, r2
dp3_pp r1.w, r2, r2
rsq_pp r1.w, r1.w
rcp_pp r0.z, r0.z
mul r0.z, r0, r1
mul_pp r2.xyz, r1.w, r2
dp3 r2.w, r0, v2
dp3 r0.x, r0, r2
max r1.w, r2, c8.z
max r2.x, r0, c8.z
mov_pp r0.z, c3.x
mad r0.xy, r0.w, r1, v0
mul r2.w, r1.z, r1
texld r1, r0, s1
mul_pp r2.y, c8.w, r0.z
pow r0, r2.x, r2.y
mov r0.w, r0.x
mul_pp r1.xyz, r1, c2
mul_pp r2.xyz, r1, c0
mov_pp r0.xyz, c0
mul r0.w, r1, r0
mul_pp r2.xyz, r2, r2.w
mul_pp r0.xyz, c1, r0
mad r0.xyz, r0, r0.w, r2
mul r0.xyz, r0, c7.z
mad_pp oC0.xyz, r1, v3, r0
mov_pp r0.x, c0.w
mul_pp r0.y, r1.w, c2.w
mul_pp r0.x, c1.w, r0
mad oC0.w, r0, r0.x, r0.y
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" }
Vector 0 [_Color]
Float 1 [_Parallax]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 3 [unity_Lightmap] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 18 ALU, 3 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.5, 0.41999999, 8 } };
TEMP R0;
TEMP R1;
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, fragment.texcoord[1];
ADD R0.z, R0, c[2].y;
RCP R0.w, R0.z;
MUL R0.xy, R0, R0.w;
MOV R0.z, c[1].x;
TEX R1, fragment.texcoord[2], texture[3], 2D;
TEX R0.w, fragment.texcoord[0].zwzw, texture[0], 2D;
MUL R0.z, R0, c[2].x;
MAD R0.z, R0.w, c[1].x, -R0;
MAD R0.xy, R0.z, R0, fragment.texcoord[0];
TEX R0, R0, texture[1], 2D;
MUL R0, R0, c[0];
MUL R1.xyz, R1.w, R1;
MUL R0.xyz, R1, R0;
MUL result.color.xyz, R0, c[2].z;
MOV result.color.w, R0;
END
# 18 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" }
Vector 0 [_Color]
Float 1 [_Parallax]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 3 [unity_Lightmap] 2D
"ps_3_0
; 15 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s3
def c2, 0.50000000, 0.41999999, 8.00000000, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xy
dp3_pp r0.x, v1, v1
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, v1
add r0.z, r0, c2.y
rcp r0.w, r0.z
mul r0.xy, r0, r0.w
mov_pp r0.z, c2.x
texld r1, v2, s3
texld r0.w, v0.zwzw, s0
mul_pp r0.z, c1.x, r0
mad_pp r0.z, r0.w, c1.x, -r0
mad r0.xy, r0.z, r0, v0
texld r0, r0, s1
mul_pp r0, r0, c0
mul_pp r1.xyz, r1.w, r1
mul_pp r0.xyz, r1, r0
mul_pp oC0.xyz, r0, c2.z
mov_pp oC0.w, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_Parallax]
Float 5 [_ShadingStrength]
Float 6 [_ShadeRange]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_ShadowMapTexture] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 118 ALU, 11 TEX
PARAM c[9] = { program.local[0..6],
		{ 0.5, 0.41999999, 2, 1 },
		{ 0.14285715, 0, 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.x, c[4];
ADD R0.x, R0, c[6];
MUL R0.xyz, -fragment.texcoord[2], R0.x;
MAD R2.xy, -R0, c[8].x, fragment.texcoord[0].zwzw;
MAD R2.zw, -R0.xyxy, c[8].x, R2.xyxy;
MAD R1.xy, -R0, c[8].x, R2.zwzw;
TEX R1.w, R1, texture[0], 2D;
TEX R2.w, R2.zwzw, texture[0], 2D;
TEX R0.w, fragment.texcoord[0].zwzw, texture[0], 2D;
TEX R3.w, R2, texture[0], 2D;
ADD R2.x, -R0.w, R3.w;
ADD R2.y, -R2.x, c[7].w;
ADD R1.z, R0, R2.w;
ADD R2.x, R0.z, R3.w;
SLT R2.x, R0.w, R2;
SLT R2.z, R2.y, c[7].w;
MUL R2.z, R2.x, R2;
CMP R2.z, -R2, R2.y, c[7].w;
ADD R2.x, -R0.w, R2.w;
ADD R2.y, -R2.x, c[7].w;
SLT R2.x, R2.y, R2.z;
SLT R1.z, R0.w, R1;
MUL R1.z, R1, R2.x;
CMP R1.z, -R1, R2.y, R2;
ADD R2.x, -R0.w, R1.w;
ADD R2.x, -R2, c[7].w;
ADD R2.y, R0.z, R1.w;
MAD R1.xy, -R0, c[8].x, R1;
TEX R1.w, R1, texture[0], 2D;
SLT R2.z, R2.x, R1;
SLT R2.y, R0.w, R2;
MUL R2.z, R2.y, R2;
ADD R2.y, -R0.w, R1.w;
CMP R1.z, -R2, R2.x, R1;
ADD R2.x, -R2.y, c[7].w;
ADD R2.y, R0.z, R1.w;
MAD R1.xy, -R0, c[8].x, R1;
TEX R1.w, R1, texture[0], 2D;
MAD R1.xy, -R0, c[8].x, R1;
MAD R0.xy, -R0, c[8].x, R1;
SLT R2.z, R2.x, R1;
SLT R2.y, R0.w, R2;
MUL R2.z, R2.y, R2;
ADD R2.y, -R0.w, R1.w;
CMP R1.z, -R2, R2.x, R1;
ADD R2.x, -R2.y, c[7].w;
ADD R2.y, R0.z, R1.w;
TEX R1.w, R1, texture[0], 2D;
SLT R2.z, R2.x, R1;
SLT R2.y, R0.w, R2;
MUL R2.z, R2.y, R2;
ADD R2.y, -R0.w, R1.w;
CMP R1.z, -R2, R2.x, R1;
ADD R2.x, -R2.y, c[7].w;
ADD R1.w, R0.z, R1;
SLT R1.x, R0.w, R1.w;
TEX R1.w, R0, texture[0], 2D;
SLT R2.y, R2.x, R1.z;
MUL R1.x, R1, R2.y;
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R2.w, R0.x;
CMP R2.y, -R1.x, R2.x, R1.z;
ADD R0.y, -R0.w, R1.w;
ADD R2.x, -R0.y, c[7].w;
MUL R1.xyz, R2.w, fragment.texcoord[1];
ADD R0.z, R1.w, R0;
ADD R0.y, R1.z, c[7];
RCP R0.y, R0.y;
MOV R0.x, c[4];
MUL R0.x, R0, c[7];
MUL R1.xy, R1, R0.y;
MAD R1.z, R0.w, c[4].x, -R0.x;
MAD R0.xy, R1.z, R1, fragment.texcoord[0].zwzw;
SLT R0.z, R0.w, R0;
SLT R2.z, R2.x, R2.y;
MUL R0.z, R0, R2;
TEX R0.yw, R0, texture[2], 2D;
MAD R0.xy, R0.wyzw, c[7].z, -c[7].w;
CMP R2.x, -R0.z, R2, R2.y;
MUL R0.w, R0.y, R0.y;
MOV R0.z, c[7].w;
MAD R1.w, -R0.x, R0.x, -R0;
ADD R0.z, R0, -c[5].x;
MAD R0.w, R0.z, R2.x, c[5].x;
ADD R0.z, R1.w, c[7].w;
MOV R2.xyz, fragment.texcoord[2];
MAD R2.xyz, R2.w, fragment.texcoord[1], R2;
DP3 R1.w, R2, R2;
RSQ R1.w, R1.w;
RSQ R0.z, R0.z;
RCP R0.z, R0.z;
MUL R0.z, R0, R0.w;
DP3 R2.w, R0, fragment.texcoord[2];
MUL R2.xyz, R1.w, R2;
MAX R1.w, R2, c[8].y;
DP3 R0.x, R0, R2;
MAX R2.w, R0.x, c[8].y;
MAD R0.xy, R1.z, R1, fragment.texcoord[0];
MUL R1.w, R0, R1;
TEX R0, R0, texture[1], 2D;
MUL R2.xyz, R0, c[2];
MUL R0.xyz, R2, c[0];
MUL R3.xyz, R0, R1.w;
TXP R0.x, fragment.texcoord[4], texture[3], 2D;
MOV R1.x, c[8].z;
MUL R1.x, R1, c[3];
POW R1.x, R2.w, R1.x;
MUL R0.y, R0.w, R1.x;
MOV R1, c[1];
MUL R1.xyz, R1, c[0];
MAD R1.xyz, R1, R0.y, R3;
MUL R0.z, R0.x, c[7];
MUL R1.xyz, R1, R0.z;
MUL R0.z, R1.w, c[0].w;
MUL R0.w, R0, c[2];
MUL R0.y, R0, R0.z;
MAD result.color.xyz, R2, fragment.texcoord[3], R1;
MAD result.color.w, R0.x, R0.y, R0;
END
# 118 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_Parallax]
Float 5 [_ShadingStrength]
Float 6 [_ShadeRange]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_ShadowMapTexture] 2D
"ps_3_0
; 124 ALU, 11 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c7, 0.50000000, 0.41999999, 2.00000000, -1.00000000
def c8, 1.00000000, 0.14285715, 0.00000000, 128.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4
mov r0.x, c6
add r0.x, c4, r0
mul r0.xyz, -v2, r0.x
mad r2.xy, -r0, c8.y, v0.zwzw
mad r3.xy, -r0, c8.y, r2
mad r1.xy, -r0, c8.y, r3
texld r3.w, r3, s0
texld r1.w, r1, s0
texld r0.w, v0.zwzw, s0
texld r2.w, r2, s0
add r2.x, r0.z, r2.w
add r2.y, -r0.w, r3.w
add r2.w, -r0, r2
cmp r3.x, -r2.w, c8.z, c8
add r2.x, r0.w, -r2
cmp r2.x, r2, c8.z, c8
add r1.z, -r0.w, r1.w
add r2.z, r0, r3.w
mul_pp r2.x, r2, r3
add r2.w, -r2, c8.x
cmp r2.w, -r2.x, c8.x, r2
add r2.x, r0.w, -r2.z
add r2.y, -r2, c8.x
add r3.x, -r2.w, r2.y
mad r1.xy, -r0, c8.y, r1
cmp r2.z, r3.x, c8, c8.x
cmp r2.x, r2, c8.z, c8
mul_pp r2.z, r2.x, r2
cmp r2.y, -r2.z, r2.w, r2
add r2.z, r0, r1.w
texld r1.w, r1, s0
add r2.x, -r1.z, c8
add r1.z, -r2.y, r2.x
add r2.z, r0.w, -r2
add r2.w, -r0, r1
mad r1.xy, -r0, c8.y, r1
cmp r1.z, r1, c8, c8.x
cmp r2.z, r2, c8, c8.x
mul_pp r2.z, r2, r1
cmp r2.y, -r2.z, r2, r2.x
add r2.z, r0, r1.w
add r1.z, -r2.w, c8.x
texld r1.w, r1, s0
mad r1.xy, -r0, c8.y, r1
add r2.x, -r2.y, r1.z
add r2.z, r0.w, -r2
mad r0.xy, -r0, c8.y, r1
add r2.w, -r0, r1
cmp r2.x, r2, c8.z, c8
cmp r2.z, r2, c8, c8.x
mul_pp r2.z, r2, r2.x
cmp r2.y, -r2.z, r2, r1.z
add r2.z, r0, r1.w
add r2.x, -r2.w, c8
texld r1.w, r1, s0
add r2.w, -r0, r1
add r1.z, -r2.y, r2.x
add r1.w, r0.z, r1
add r1.x, r0.w, -r1.w
texld r1.w, r0, s0
add r2.z, r0.w, -r2
add r0.z, r1.w, r0
add r0.z, r0.w, -r0
add r0.y, -r0.w, r1.w
cmp r1.z, r1, c8, c8.x
cmp r2.z, r2, c8, c8.x
mul_pp r2.z, r2, r1
cmp r2.x, -r2.z, r2.y, r2
add r1.z, -r2.w, c8.x
add r2.y, -r2.x, r1.z
cmp r2.y, r2, c8.z, c8.x
cmp r0.x, r1, c8.z, c8
mul_pp r0.x, r0, r2.y
cmp r2.y, -r0.x, r2.x, r1.z
add r2.x, -r0.y, c8
add r0.y, -r2, r2.x
dp3_pp r0.x, v1, v1
rsq_pp r2.w, r0.x
mov_pp r0.x, c7
mul_pp r1.xyz, r2.w, v1
cmp r2.z, r0.y, c8, c8.x
add r0.y, r1.z, c7
rcp r0.y, r0.y
mul_pp r0.x, c4, r0
mul r1.xy, r1, r0.y
mad_pp r1.z, r0.w, c4.x, -r0.x
mad r0.xy, r1.z, r1, v0.zwzw
texld r0.yw, r0, s2
mad_pp r0.xy, r0.wyzw, c7.z, c7.w
cmp r0.z, r0, c8, c8.x
mul_pp r0.w, r0.z, r2.z
cmp r1.w, -r0, r2.y, r2.x
mul_pp r0.z, r0.y, r0.y
mad_pp r0.z, -r0.x, r0.x, -r0
mov r0.w, c5.x
add_pp r0.z, r0, c8.x
add r0.w, c8.x, -r0
rsq_pp r0.z, r0.z
mov_pp r2.xyz, v2
mad r0.w, r0, r1, c5.x
mad_pp r2.xyz, r2.w, v1, r2
dp3_pp r1.w, r2, r2
rsq_pp r1.w, r1.w
rcp_pp r0.z, r0.z
mul r0.z, r0, r0.w
dp3 r2.w, r0, v2
mul_pp r2.xyz, r1.w, r2
dp3 r0.x, r0, r2
max r2.w, r2, c8.z
max r0.z, r0.x, c8
mul r1.w, r0, r2
mov_pp r0.y, c3.x
mul_pp r0.w, c8, r0.y
pow r3, r0.z, r0.w
mad r0.xy, r1.z, r1, v0
texld r0, r0, s1
mul_pp r2.xyz, r0, c2
mul_pp r0.xyz, r2, c0
mov r1.x, r3
mul_pp r3.xyz, r0, r1.w
mul r0.y, r0.w, r1.x
texldp r0.x, v4, s3
mov_pp r1.xyz, c0
mul_pp r1.xyz, c1, r1
mad r1.xyz, r1, r0.y, r3
mul_pp r0.z, r0.x, c7
mul r1.xyz, r1, r0.z
mov_pp r0.z, c0.w
mul_pp r0.z, c1.w, r0
mul_pp r0.w, r0, c2
mul r0.y, r0, r0.z
mad_pp oC0.xyz, r2, v3, r1
mad oC0.w, r0.x, r0.y, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" }
Vector 0 [_Color]
Float 1 [_Parallax]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 3 [_ShadowMapTexture] 2D
SetTexture 4 [unity_Lightmap] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 24 ALU, 4 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.5, 0.41999999, 8, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R2, fragment.texcoord[2], texture[4], 2D;
MUL R0.xyz, R2.w, R2;
MUL R1.xyz, R0, c[2].z;
TXP R0.x, fragment.texcoord[3], texture[3], 2D;
MUL R2.xyz, R2, R0.x;
DP3 R0.y, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.y, R0.y;
MUL R0.yzw, R0.y, fragment.texcoord[1].xxyz;
ADD R0.w, R0, c[2].y;
RCP R1.w, R0.w;
MUL R2.xyz, R2, c[2].w;
MIN R2.xyz, R1, R2;
MUL R1.xyz, R1, R0.x;
MUL R0.yz, R0, R1.w;
MOV R0.w, c[1].x;
MUL R1.w, R0, c[2].x;
TEX R0.w, fragment.texcoord[0].zwzw, texture[0], 2D;
MAD R0.w, R0, c[1].x, -R1;
MAD R0.zw, R0.w, R0.xyyz, fragment.texcoord[0].xyxy;
TEX R0, R0.zwzw, texture[1], 2D;
MUL R0, R0, c[0];
MAX R1.xyz, R2, R1;
MUL result.color.xyz, R0, R1;
MOV result.color.w, R0;
END
# 24 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" }
Vector 0 [_Color]
Float 1 [_Parallax]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 3 [_ShadowMapTexture] 2D
SetTexture 4 [unity_Lightmap] 2D
"ps_3_0
; 20 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s3
dcl_2d s4
def c2, 0.50000000, 0.41999999, 8.00000000, 2.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xy
dcl_texcoord3 v3
texld r0, v2, s4
mul_pp r1.xyz, r0.w, r0
mul_pp r1.yzw, r1.xxyz, c2.z
texldp r1.x, v3, s3
mul_pp r2.xyz, r0, r1.x
dp3_pp r0.w, v1, v1
rsq_pp r0.w, r0.w
mul_pp r0.xyz, r0.w, v1
add r0.z, r0, c2.y
rcp r0.w, r0.z
mul r0.xy, r0, r0.w
mul_pp r2.xyz, r2, c2.w
min_pp r2.xyz, r1.yzww, r2
mov_pp r0.z, c2.x
mul_pp r1.xyz, r1.yzww, r1.x
texld r0.w, v0.zwzw, s0
mul_pp r0.z, c1.x, r0
mad_pp r0.z, r0.w, c1.x, -r0
mad r0.xy, r0.z, r0, v0
texld r0, r0, s1
mul_pp r0, r0, c0
max_pp r1.xyz, r2, r1
mul_pp oC0.xyz, r0, r1
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
MOV R0.xyz, vertex.attrib[14];
MUL R2.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R2;
MOV R1, c[19];
MOV R0.w, c[0].x;
DP4 R2.z, R1, c[11];
DP4 R2.x, R1, c[9];
DP4 R2.y, R1, c[10];
MAD R2.xyz, R2, c[17].w, -vertex.position;
MUL R1.xyz, R0, vertex.attrib[14].w;
MOV R0.xyz, c[18];
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
mov r1.xyz, v1
mov r0, c10
dp4 r3.z, c18, r0
mov r0, c9
dp4 r3.y, c18, r0
mul r2.xyz, v2.zxyw, r1.yzxw
mov r1.xyz, v1
mad r2.xyz, v2.yzxw, r1.zxyw, -r2
mov r1, c8
dp4 r3.x, c18, r1
mad r0.xyz, r3, c16.w, -v0
mul r2.xyz, r2, v1.w
mov r1.xyz, c17
mov r1.w, c21.x
dp3 o3.y, r2, r0
dp3 o3.z, v2, r0
dp3 o3.x, v1, r0
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r3.z, r1, c10
dp4 r3.x, r1, c8
dp4 r3.y, r1, c9
mad r1.xyz, r3, c16.w, -v0
dp3 o2.y, r1, r2
dp3 o2.z, v2, r1
dp3 o2.x, r1, v1
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
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0.xyz, c[10];
MOV R0.w, c[0].x;
DP4 R2.z, R0, c[7];
DP4 R2.x, R0, c[5];
DP4 R2.y, R0, c[6];
MAD R0.xyz, R2, c[9].w, -vertex.position;
MUL R2.xyz, R1, vertex.attrib[14].w;
MOV R1, c[11];
DP4 R3.z, R1, c[7];
DP4 R3.x, R1, c[5];
DP4 R3.y, R1, c[6];
DP3 result.texcoord[1].y, R0, R2;
DP3 result.texcoord[2].y, R2, R3;
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
DP3 result.texcoord[2].z, vertex.normal, R3;
DP3 result.texcoord[2].x, vertex.attrib[14], R3;
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
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r3.xyz, r0, v1.w
mov r0, c6
dp4 r4.z, c10, r0
mov r0, c5
mov r1.w, c13.x
mov r1.xyz, c9
dp4 r4.y, c10, r0
dp4 r2.z, r1, c6
dp4 r2.x, r1, c4
dp4 r2.y, r1, c5
mad r2.xyz, r2, c8.w, -v0
mov r1, c4
dp4 r4.x, c10, r1
dp3 o2.y, r2, r3
dp3 o3.y, r3, r4
dp3 o2.z, v2, r2
dp3 o2.x, r2, v1
dp3 o3.z, v2, r4
dp3 o3.x, v1, r4
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
MOV R0.xyz, vertex.attrib[14];
MUL R2.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R2;
MOV R1, c[19];
MOV R0.w, c[0].x;
DP4 R2.z, R1, c[11];
DP4 R2.x, R1, c[9];
DP4 R2.y, R1, c[10];
MAD R2.xyz, R2, c[17].w, -vertex.position;
MUL R1.xyz, R0, vertex.attrib[14].w;
MOV R0.xyz, c[18];
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
mov r1.xyz, v1
mov r0, c10
dp4 r3.z, c18, r0
mov r0, c9
dp4 r3.y, c18, r0
mul r2.xyz, v2.zxyw, r1.yzxw
mov r1.xyz, v1
mad r2.xyz, v2.yzxw, r1.zxyw, -r2
mov r1, c8
dp4 r3.x, c18, r1
mad r0.xyz, r3, c16.w, -v0
mul r2.xyz, r2, v1.w
mov r1.xyz, c17
mov r1.w, c21.x
dp4 r0.w, v0, c7
dp3 o3.y, r2, r0
dp3 o3.z, v2, r0
dp3 o3.x, v1, r0
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r3.z, r1, c10
dp4 r3.x, r1, c8
dp4 r3.y, r1, c9
mad r1.xyz, r3, c16.w, -v0
dp3 o2.y, r1, r2
dp3 o2.z, v2, r1
dp3 o2.x, r1, v1
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
MOV R0.xyz, vertex.attrib[14];
MUL R2.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R2;
MOV R1, c[19];
MOV R0.w, c[0].x;
DP4 R2.z, R1, c[11];
DP4 R2.x, R1, c[9];
DP4 R2.y, R1, c[10];
MAD R2.xyz, R2, c[17].w, -vertex.position;
MUL R1.xyz, R0, vertex.attrib[14].w;
MOV R0.xyz, c[18];
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
mov r1.xyz, v1
mov r0, c10
dp4 r3.z, c18, r0
mov r0, c9
dp4 r3.y, c18, r0
mul r2.xyz, v2.zxyw, r1.yzxw
mov r1.xyz, v1
mad r2.xyz, v2.yzxw, r1.zxyw, -r2
mov r1, c8
dp4 r3.x, c18, r1
mad r0.xyz, r3, c16.w, -v0
mul r2.xyz, r2, v1.w
mov r1.xyz, c17
mov r1.w, c21.x
dp3 o3.y, r2, r0
dp3 o3.z, v2, r0
dp3 o3.x, v1, r0
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r3.z, r1, c10
dp4 r3.x, r1, c8
dp4 r3.y, r1, c9
mad r1.xyz, r3, c16.w, -v0
dp3 o2.y, r1, r2
dp3 o2.z, v2, r1
dp3 o2.x, r1, v1
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
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0.w, c[0].x;
MOV R0.xyz, c[18];
DP4 R2.z, R0, c[11];
DP4 R2.x, R0, c[9];
DP4 R2.y, R0, c[10];
MAD R0.xyz, R2, c[17].w, -vertex.position;
MUL R2.xyz, R1, vertex.attrib[14].w;
MOV R1, c[19];
DP3 result.texcoord[1].y, R0, R2;
DP4 R3.z, R1, c[11];
DP4 R3.x, R1, c[9];
DP4 R3.y, R1, c[10];
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 result.texcoord[2].y, R2, R3;
DP3 result.texcoord[2].z, vertex.normal, R3;
DP3 result.texcoord[2].x, vertex.attrib[14], R3;
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
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r3.xyz, r0, v1.w
mov r0, c10
dp4 r4.z, c18, r0
mov r0, c9
dp4 r4.y, c18, r0
mov r1.w, c21.x
mov r1.xyz, c17
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c16.w, -v0
mov r1, c8
dp4 r4.x, c18, r1
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 o2.y, r2, r3
dp3 o3.y, r3, r4
dp3 o2.z, v2, r2
dp3 o2.x, r2, v1
dp3 o3.z, v2, r4
dp3 o3.x, v1, r4
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
MOV R0.xyz, vertex.attrib[14];
MUL R2.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R2;
MOV R1, c[23];
MOV R0.w, c[0].x;
DP4 R2.z, R1, c[11];
DP4 R2.x, R1, c[9];
DP4 R2.y, R1, c[10];
MAD R2.xyz, R2, c[21].w, -vertex.position;
MUL R1.xyz, R0, vertex.attrib[14].w;
MOV R0.xyz, c[22];
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
mov r1.xyz, v1
mov r0, c10
dp4 r3.z, c22, r0
mov r0, c9
dp4 r3.y, c22, r0
mul r2.xyz, v2.zxyw, r1.yzxw
mov r1.xyz, v1
mad r2.xyz, v2.yzxw, r1.zxyw, -r2
mov r1, c8
dp4 r3.x, c22, r1
mad r0.xyz, r3, c20.w, -v0
mul r2.xyz, r2, v1.w
dp4 r0.w, v0, c7
mov r1.xyz, c21
mov r1.w, c25.x
dp3 o3.y, r2, r0
dp3 o3.z, v2, r0
dp3 o3.x, v1, r0
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r3.z, r1, c10
dp4 r3.x, r1, c8
dp4 r3.y, r1, c9
mad r1.xyz, r3, c20.w, -v0
dp3 o2.y, r1, r2
dp3 o2.z, v2, r1
dp3 o2.x, r1, v1
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
mov r1.xyz, v1
mov r0, c10
dp4 r3.z, c22, r0
mov r0, c9
dp4 r3.y, c22, r0
mul r2.xyz, v2.zxyw, r1.yzxw
mov r1.xyz, v1
mad r2.xyz, v2.yzxw, r1.zxyw, -r2
mov r1, c8
dp4 r3.x, c22, r1
mad r0.xyz, r3, c20.w, -v0
mul r2.xyz, r2, v1.w
dp4 r0.w, v0, c7
mov r1.xyz, c21
mov r1.w, c25.x
dp3 o3.y, r2, r0
dp3 o3.z, v2, r0
dp3 o3.x, v1, r0
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r3.z, r1, c10
dp4 r3.x, r1, c8
dp4 r3.y, r1, c9
mad r1.xyz, r3, c20.w, -v0
dp3 o2.y, r1, r2
dp3 o2.z, v2, r1
dp3 o2.x, r1, v1
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
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0.w, c[0].x;
MOV R0.xyz, c[11];
DP4 R2.z, R0, c[7];
DP4 R2.x, R0, c[5];
DP4 R2.y, R0, c[6];
MAD R0.xyz, R2, c[10].w, -vertex.position;
MUL R2.xyz, R1, vertex.attrib[14].w;
MOV R1, c[12];
DP4 R3.z, R1, c[7];
DP4 R3.x, R1, c[5];
DP4 R3.y, R1, c[6];
DP3 result.texcoord[1].y, R0, R2;
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[9].x;
DP3 result.texcoord[2].y, R2, R3;
DP3 result.texcoord[2].z, vertex.normal, R3;
DP3 result.texcoord[2].x, vertex.attrib[14], R3;
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
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r3.xyz, r0, v1.w
mov r0, c6
dp4 r4.z, c12, r0
mov r0, c5
dp4 r4.y, c12, r0
mov r1.w, c15.x
mov r1.xyz, c11
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r2.z, r1, c6
dp4 r2.x, r1, c4
dp4 r2.y, r1, c5
mad r2.xyz, r2, c10.w, -v0
mov r1, c4
dp4 r4.x, c12, r1
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c15.y
mul r1.y, r1, c8.x
dp3 o2.y, r2, r3
dp3 o3.y, r3, r4
dp3 o2.z, v2, r2
dp3 o2.x, r2, v1
dp3 o3.z, v2, r4
dp3 o3.x, v1, r4
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
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0.w, c[0].x;
MOV R0.xyz, c[19];
DP4 R2.z, R0, c[11];
DP4 R2.x, R0, c[9];
DP4 R2.y, R0, c[10];
MAD R0.xyz, R2, c[18].w, -vertex.position;
MUL R2.xyz, R1, vertex.attrib[14].w;
MOV R1, c[20];
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
MUL R1.y, R1, c[17].x;
ADD result.texcoord[4].xy, R1, R1.z;
DP4 R1.w, vertex.position, c[8];
DP4 R1.z, vertex.position, c[7];
DP4 R1.x, vertex.position, c[5];
DP4 R1.y, vertex.position, c[6];
DP3 result.texcoord[2].y, R2, R3;
DP3 result.texcoord[2].z, vertex.normal, R3;
DP3 result.texcoord[2].x, vertex.attrib[14], R3;
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
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r3.xyz, r0, v1.w
mov r0, c10
dp4 r4.z, c20, r0
mov r0, c9
dp4 r4.y, c20, r0
mov r1.w, c23.x
mov r1.xyz, c19
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c18.w, -v0
mov r1, c8
dp4 r4.x, c20, r1
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c23.y
mul r1.y, r1, c16.x
mad o5.xy, r1.z, c17.zwzw, r1
dp4 r1.w, v0, c7
dp4 r1.z, v0, c6
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
dp3 o2.y, r2, r3
dp3 o3.y, r3, r4
dp3 o2.z, v2, r2
dp3 o2.x, r2, v1
dp3 o3.z, v2, r4
dp3 o3.x, v1, r4
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
MOV R0.xyz, vertex.attrib[14];
MUL R2.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R2;
MOV R1, c[19];
MOV R0.w, c[0].x;
DP4 R2.z, R1, c[11];
DP4 R2.x, R1, c[9];
DP4 R2.y, R1, c[10];
MAD R2.xyz, R2, c[17].w, -vertex.position;
MUL R1.xyz, R0, vertex.attrib[14].w;
MOV R0.xyz, c[18];
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
mov r1.xyz, v1
mov r0, c10
dp4 r3.z, c18, r0
mov r0, c9
dp4 r3.y, c18, r0
mul r2.xyz, v2.zxyw, r1.yzxw
mov r1.xyz, v1
mad r2.xyz, v2.yzxw, r1.zxyw, -r2
mov r1, c8
dp4 r3.x, c18, r1
mad r0.xyz, r3, c16.w, -v0
mul r2.xyz, r2, v1.w
mov r1.xyz, c17
mov r1.w, c22.x
dp3 o3.y, r2, r0
dp3 o3.z, v2, r0
dp3 o3.x, v1, r0
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
dp4 r3.z, r1, c10
dp4 r3.x, r1, c8
dp4 r3.y, r1, c9
mad r1.xyz, r3, c16.w, -v0
dp3 o2.y, r1, r2
dp3 o2.z, v2, r1
dp3 o2.x, r1, v1
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
MOV R0.xyz, vertex.attrib[14];
MUL R2.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R2;
MOV R1, c[19];
MOV R0.w, c[0].x;
DP4 R2.z, R1, c[11];
DP4 R2.x, R1, c[9];
DP4 R2.y, R1, c[10];
MAD R2.xyz, R2, c[17].w, -vertex.position;
MUL R1.xyz, R0, vertex.attrib[14].w;
MOV R0.xyz, c[18];
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
mov r1.xyz, v1
mov r0, c10
dp4 r3.z, c18, r0
mov r0, c9
dp4 r3.y, c18, r0
mul r2.xyz, v2.zxyw, r1.yzxw
mov r1.xyz, v1
mad r2.xyz, v2.yzxw, r1.zxyw, -r2
mov r1, c8
dp4 r3.x, c18, r1
mad r0.xyz, r3, c16.w, -v0
mul r2.xyz, r2, v1.w
mov r1.xyz, c17
mov r1.w, c22.x
dp3 o3.y, r2, r0
dp3 o3.z, v2, r0
dp3 o3.x, v1, r0
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
dp4 r3.z, r1, c10
dp4 r3.x, r1, c8
dp4 r3.y, r1, c9
mad r1.xyz, r3, c16.w, -v0
dp3 o2.y, r1, r2
dp3 o2.z, v2, r1
dp3 o2.x, r1, v1
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
MOV R0.xyz, vertex.attrib[14];
MUL R2.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R2;
MOV R1, c[23];
MOV R0.w, c[0].x;
DP4 R2.z, R1, c[11];
DP4 R2.x, R1, c[9];
DP4 R2.y, R1, c[10];
MAD R2.xyz, R2, c[21].w, -vertex.position;
MUL R1.xyz, R0, vertex.attrib[14].w;
MOV R0.xyz, c[22];
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
mov r1.xyz, v1
mov r0, c10
dp4 r3.z, c22, r0
mov r0, c9
dp4 r3.y, c22, r0
mul r2.xyz, v2.zxyw, r1.yzxw
mov r1.xyz, v1
mad r2.xyz, v2.yzxw, r1.zxyw, -r2
mov r1, c8
dp4 r3.x, c22, r1
mad r0.xyz, r3, c20.w, -v0
mul r2.xyz, r2, v1.w
dp4 r0.w, v0, c7
mov r1.xyz, c21
mov r1.w, c25.x
dp3 o3.y, r2, r0
dp3 o3.z, v2, r0
dp3 o3.x, v1, r0
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r3.z, r1, c10
dp4 r3.x, r1, c8
dp4 r3.y, r1, c9
mad r1.xyz, r3, c20.w, -v0
dp3 o2.y, r1, r2
dp3 o2.z, v2, r1
dp3 o2.x, r1, v1
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
mov r1.xyz, v1
mov r0, c10
dp4 r3.z, c22, r0
mov r0, c9
dp4 r3.y, c22, r0
mul r2.xyz, v2.zxyw, r1.yzxw
mov r1.xyz, v1
mad r2.xyz, v2.yzxw, r1.zxyw, -r2
mov r1, c8
dp4 r3.x, c22, r1
mad r0.xyz, r3, c20.w, -v0
mul r2.xyz, r2, v1.w
dp4 r0.w, v0, c7
mov r1.xyz, c21
mov r1.w, c25.x
dp3 o3.y, r2, r0
dp3 o3.z, v2, r0
dp3 o3.x, v1, r0
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r3.z, r1, c10
dp4 r3.x, r1, c8
dp4 r3.y, r1, c9
mad r1.xyz, r3, c20.w, -v0
dp3 o2.y, r1, r2
dp3 o2.z, v2, r1
dp3 o2.x, r1, v1
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
MOV R0.xyz, vertex.attrib[14];
MUL R2.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R2;
MOV R1, c[19];
MOV R0.w, c[0].x;
DP4 R2.z, R1, c[11];
DP4 R2.x, R1, c[9];
DP4 R2.y, R1, c[10];
MAD R2.xyz, R2, c[17].w, -vertex.position;
MUL R1.xyz, R0, vertex.attrib[14].w;
MOV R0.xyz, c[18];
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
mov r1.xyz, v1
mov r0, c10
dp4 r3.z, c18, r0
mov r0, c9
dp4 r3.y, c18, r0
mul r2.xyz, v2.zxyw, r1.yzxw
mov r1.xyz, v1
mad r2.xyz, v2.yzxw, r1.zxyw, -r2
mov r1, c8
dp4 r3.x, c18, r1
mad r0.xyz, r3, c16.w, -v0
mul r2.xyz, r2, v1.w
mov r1.xyz, c17
mov r1.w, c22.x
dp3 o3.y, r2, r0
dp3 o3.z, v2, r0
dp3 o3.x, v1, r0
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
dp4 r3.z, r1, c10
dp4 r3.x, r1, c8
dp4 r3.y, r1, c9
mad r1.xyz, r3, c16.w, -v0
dp3 o2.y, r1, r2
dp3 o2.z, v2, r1
dp3 o2.x, r1, v1
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
MOV R0.xyz, vertex.attrib[14];
MUL R2.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R2;
MOV R1, c[19];
MOV R0.w, c[0].x;
DP4 R2.z, R1, c[11];
DP4 R2.x, R1, c[9];
DP4 R2.y, R1, c[10];
MAD R2.xyz, R2, c[17].w, -vertex.position;
MUL R1.xyz, R0, vertex.attrib[14].w;
MOV R0.xyz, c[18];
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
mov r1.xyz, v1
mov r0, c10
dp4 r3.z, c18, r0
mov r0, c9
dp4 r3.y, c18, r0
mul r2.xyz, v2.zxyw, r1.yzxw
mov r1.xyz, v1
mad r2.xyz, v2.yzxw, r1.zxyw, -r2
mov r1, c8
dp4 r3.x, c18, r1
mad r0.xyz, r3, c16.w, -v0
mul r2.xyz, r2, v1.w
mov r1.xyz, c17
mov r1.w, c22.x
dp3 o3.y, r2, r0
dp3 o3.z, v2, r0
dp3 o3.x, v1, r0
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
dp4 r3.z, r1, c10
dp4 r3.x, r1, c8
dp4 r3.y, r1, c9
mad r1.xyz, r3, c16.w, -v0
dp3 o2.y, r1, r2
dp3 o2.z, v2, r1
dp3 o2.x, r1, v1
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
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_Parallax]
Float 5 [_ShadingStrength]
Float 6 [_ShadeRange]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_LightTexture0] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 117 ALU, 11 TEX
PARAM c[9] = { program.local[0..6],
		{ 0, 0.5, 0.41999999, 2 },
		{ 1, 0.14285715, 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MOV R0.x, c[4];
DP3 R0.y, fragment.texcoord[2], fragment.texcoord[2];
ADD R0.w, R0.x, c[6].x;
RSQ R0.y, R0.y;
MUL R0.xyz, R0.y, fragment.texcoord[2];
MUL R1.xyz, -R0, R0.w;
MAD R3.xy, -R1, c[8].y, fragment.texcoord[0].zwzw;
MAD R2.zw, -R1.xyxy, c[8].y, R3.xyxy;
MAD R2.xy, -R1, c[8].y, R2.zwzw;
TEX R3.w, R3, texture[0], 2D;
TEX R0.w, fragment.texcoord[0].zwzw, texture[0], 2D;
TEX R1.w, R2, texture[0], 2D;
TEX R2.w, R2.zwzw, texture[0], 2D;
ADD R3.x, -R0.w, R3.w;
ADD R2.z, R1, R2.w;
ADD R3.x, -R3, c[8];
ADD R3.y, R1.z, R3.w;
SLT R3.y, R0.w, R3;
SLT R3.z, R3.x, c[8].x;
MUL R3.z, R3.y, R3;
ADD R3.y, -R0.w, R2.w;
CMP R2.w, -R3.z, R3.x, c[8].x;
ADD R3.x, -R3.y, c[8];
SLT R3.y, R3.x, R2.w;
SLT R2.z, R0.w, R2;
MUL R3.y, R2.z, R3;
CMP R2.w, -R3.y, R3.x, R2;
ADD R2.z, -R0.w, R1.w;
ADD R2.z, -R2, c[8].x;
ADD R3.y, R1.z, R1.w;
MAD R2.xy, -R1, c[8].y, R2;
TEX R1.w, R2, texture[0], 2D;
SLT R3.x, R2.z, R2.w;
SLT R3.y, R0.w, R3;
MUL R3.y, R3, R3.x;
CMP R2.w, -R3.y, R2.z, R2;
ADD R3.x, -R0.w, R1.w;
ADD R2.z, -R3.x, c[8].x;
ADD R3.y, R1.z, R1.w;
MAD R2.xy, -R1, c[8].y, R2;
TEX R1.w, R2, texture[0], 2D;
MAD R2.xy, -R1, c[8].y, R2;
MAD R1.xy, -R1, c[8].y, R2;
SLT R3.x, R2.z, R2.w;
SLT R3.y, R0.w, R3;
MUL R3.y, R3, R3.x;
CMP R2.w, -R3.y, R2.z, R2;
ADD R3.x, -R0.w, R1.w;
ADD R3.y, R1.z, R1.w;
ADD R2.z, -R3.x, c[8].x;
SLT R3.x, R2.z, R2.w;
SLT R3.y, R0.w, R3;
MUL R3.y, R3, R3.x;
TEX R1.w, R2, texture[0], 2D;
ADD R3.x, -R0.w, R1.w;
CMP R2.w, -R3.y, R2.z, R2;
ADD R2.z, -R3.x, c[8].x;
ADD R1.w, R1.z, R1;
SLT R3.x, R2.z, R2.w;
SLT R1.w, R0, R1;
MUL R2.x, R1.w, R3;
TEX R1.w, R1, texture[0], 2D;
ADD R1.y, -R0.w, R1.w;
DP3 R1.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R3.z, R1.x;
CMP R4.x, -R2, R2.z, R2.w;
ADD R3.w, -R1.y, c[8].x;
MUL R2.xyz, R3.z, fragment.texcoord[1];
ADD R4.w, R1, R1.z;
ADD R1.y, R2.z, c[7].z;
RCP R1.y, R1.y;
MOV R1.x, c[4];
MUL R1.x, R1, c[7].y;
MUL R3.xy, R2, R1.y;
MAD R4.z, R0.w, c[4].x, -R1.x;
MAD R1.xy, R4.z, R3, fragment.texcoord[0].zwzw;
MOV R1.zw, c[8].xyxz;
TEX R2.yw, R1, texture[2], 2D;
MAD R1.xy, R2.wyzw, c[7].w, -R1.z;
SLT R1.z, R0.w, R4.w;
MUL R0.w, R1.y, R1.y;
SLT R4.y, R3.w, R4.x;
MUL R1.z, R1, R4.y;
MAD R0.w, -R1.x, R1.x, -R0;
CMP R2.x, -R1.z, R3.w, R4;
ADD R1.z, R0.w, c[8].x;
MOV R0.w, c[8].x;
RSQ R1.z, R1.z;
ADD R0.w, R0, -c[5].x;
MAD R0.w, R0, R2.x, c[5].x;
MAD R2.xyz, R3.z, fragment.texcoord[1], R0;
RCP R1.z, R1.z;
MUL R1.z, R1, R0.w;
DP3 R0.y, R1, R0;
DP3 R2.w, R2, R2;
RSQ R0.x, R2.w;
MAX R2.w, R0.y, c[7].x;
MUL R0.xyz, R0.x, R2;
DP3 R0.x, R1, R0;
MUL R2.x, R0.w, R2.w;
MUL R1.y, R1.w, c[3].x;
MAX R1.x, R0, c[7];
MAD R0.zw, R4.z, R3.xyxy, fragment.texcoord[0].xyxy;
TEX R0, R0.zwzw, texture[1], 2D;
POW R1.x, R1.x, R1.y;
MUL R1.w, R1.x, R0;
MUL R0.xyz, R0, c[2];
MUL R0.xyz, R0, c[0];
DP3 R0.w, fragment.texcoord[3], fragment.texcoord[3];
MOV R1.xyz, c[1];
TEX R0.w, R0.w, texture[3], 2D;
MUL R0.xyz, R0, R2.x;
MUL R1.xyz, R1, c[0];
MUL R0.w, R0, c[7];
MAD R0.xyz, R1, R1.w, R0;
MUL result.color.xyz, R0, R0.w;
MOV result.color.w, c[7].x;
END
# 117 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_Parallax]
Float 5 [_ShadingStrength]
Float 6 [_ShadeRange]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_LightTexture0] 2D
"ps_3_0
; 121 ALU, 11 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c7, 0.50000000, 0.41999999, 2.00000000, -1.00000000
def c8, 1.00000000, 0.14285715, 0.00000000, 128.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
mov r0.y, c6.x
dp3_pp r0.x, v2, v2
add r0.w, c4.x, r0.y
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, v2
mul r1.xyz, -r0, r0.w
mad r3.xy, -r1, c8.y, v0.zwzw
mad r4.xy, -r1, c8.y, r3
mad r2.xy, -r1, c8.y, r4
texld r3.w, r4, s0
texld r2.w, r3, s0
texld r0.w, v0.zwzw, s0
texld r1.w, r2, s0
add r2.z, r1, r3.w
add r3.x, -r0.w, r3.w
add r3.y, r1.z, r2.w
add r2.z, r0.w, -r2
add r3.z, -r0.w, r1.w
add r3.w, -r0, r2
add r3.y, r0.w, -r3
cmp r2.w, r3.y, c8.z, c8.x
cmp r3.y, -r3.w, c8.z, c8.x
mul_pp r2.w, r2, r3.y
add r3.w, -r3, c8.x
cmp r2.w, -r2, c8.x, r3
add r3.x, -r3, c8
add r3.y, -r2.w, r3.x
mad r2.xy, -r1, c8.y, r2
cmp r2.z, r2, c8, c8.x
cmp r3.y, r3, c8.z, c8.x
mul_pp r3.y, r2.z, r3
cmp r3.x, -r3.y, r2.w, r3
add r2.z, -r3, c8.x
add r3.y, r1.z, r1.w
texld r1.w, r2, s0
add r3.z, r0.w, -r3.y
add r2.w, -r3.x, r2.z
add r3.y, -r0.w, r1.w
mad r2.xy, -r1, c8.y, r2
cmp r2.w, r2, c8.z, c8.x
cmp r3.z, r3, c8, c8.x
mul_pp r3.z, r3, r2.w
add r2.w, -r3.y, c8.x
cmp r3.x, -r3.z, r3, r2.z
add r3.y, r1.z, r1.w
texld r1.w, r2, s0
add r3.z, r0.w, -r3.y
mad r2.xy, -r1, c8.y, r2
add r2.z, -r3.x, r2.w
mad r1.xy, -r1, c8.y, r2
add r3.y, -r0.w, r1.w
cmp r2.z, r2, c8, c8.x
cmp r3.z, r3, c8, c8.x
mul_pp r3.z, r3, r2
add r2.z, -r3.y, c8.x
cmp r2.w, -r3.z, r3.x, r2
add r3.y, r1.z, r1.w
add r3.x, -r2.w, r2.z
add r3.z, r0.w, -r3.y
texld r1.w, r2, s0
add r3.y, -r0.w, r1.w
cmp r3.x, r3, c8.z, c8
cmp r3.z, r3, c8, c8.x
mul_pp r3.z, r3, r3.x
cmp r2.z, -r3, r2.w, r2
add r3.x, -r3.y, c8
add r2.w, r1.z, r1
add r3.y, -r2.z, r3.x
add r2.w, r0, -r2
cmp r1.w, r3.y, c8.z, c8.x
cmp r2.x, r2.w, c8.z, c8
mul_pp r2.x, r2, r1.w
texld r1.w, r1, s0
add r1.y, -r0.w, r1.w
add r1.z, r1.w, r1
cmp r3.z, -r2.x, r2, r3.x
dp3_pp r1.x, v1, v1
rsq_pp r3.x, r1.x
add r4.x, -r1.y, c8
mul_pp r2.xyz, r3.x, v1
add r1.x, -r3.z, r4
cmp r4.y, r1.x, c8.z, c8.x
add r1.y, r2.z, c7
mov_pp r1.x, c7
mul_pp r2.z, c4.x, r1.x
mad_pp r2.w, r0, c4.x, -r2.z
add r0.w, r0, -r1.z
cmp r1.z, r0.w, c8, c8.x
mul_pp r1.z, r1, r4.y
rcp r1.y, r1.y
mul r1.xy, r2, r1.y
mad r2.xy, r2.w, r1, v0.zwzw
texld r3.yw, r2, s2
mad_pp r2.xy, r3.wyzw, c7.z, c7.w
cmp r2.z, -r1, r3, r4.x
mul_pp r0.w, r2.y, r2.y
mad_pp r0.w, -r2.x, r2.x, -r0
add_pp r0.w, r0, c8.x
rsq_pp r1.z, r0.w
mov r1.w, c5.x
add r0.w, c8.x, -r1
mad r0.w, r0, r2.z, c5.x
rcp_pp r1.z, r1.z
mul r2.z, r1, r0.w
mad_pp r3.xyz, r3.x, v1, r0
dp3 r0.y, r2, r0
dp3_pp r1.z, r3, r3
rsq_pp r0.x, r1.z
max r1.z, r0.y, c8
mul_pp r0.xyz, r0.x, r3
dp3 r0.x, r2, r0
mov_pp r0.y, c3.x
mul_pp r2.x, c8.w, r0.y
mad r1.xy, r2.w, r1, v0
mul r1.z, r0.w, r1
max r1.w, r0.x, c8.z
pow r0, r1.w, r2.x
texld r2, r1, s1
mul r0.y, r0.x, r2.w
mul_pp r2.xyz, r2, c2
mul_pp r2.xyz, r2, c0
mul_pp r1.xyz, r2, r1.z
dp3 r0.x, v3, v3
texld r0.x, r0.x, s3
mov_pp r2.xyz, c0
mul_pp r0.w, r0.x, c7.z
mul_pp r2.xyz, c1, r2
mad r0.xyz, r2, r0.y, r1
mul oC0.xyz, r0, r0.w
mov_pp oC0.w, c8.z
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_Parallax]
Float 5 [_ShadingStrength]
Float 6 [_ShadeRange]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_BumpMap] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 112 ALU, 10 TEX
PARAM c[9] = { program.local[0..6],
		{ 0, 0.5, 0.41999999, 2 },
		{ 1, 0.14285715, 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.x, c[4];
ADD R0.x, R0, c[6];
MUL R0.xyz, -fragment.texcoord[2], R0.x;
MAD R2.xy, -R0, c[8].y, fragment.texcoord[0].zwzw;
MAD R2.zw, -R0.xyxy, c[8].y, R2.xyxy;
MAD R1.xy, -R0, c[8].y, R2.zwzw;
TEX R2.w, R2.zwzw, texture[0], 2D;
TEX R1.w, R1, texture[0], 2D;
TEX R0.w, fragment.texcoord[0].zwzw, texture[0], 2D;
TEX R3.w, R2, texture[0], 2D;
ADD R2.x, -R0.w, R3.w;
ADD R2.y, -R2.x, c[8].x;
ADD R1.z, R0, R2.w;
ADD R2.x, R0.z, R3.w;
SLT R2.x, R0.w, R2;
SLT R2.z, R2.y, c[8].x;
MUL R2.z, R2.x, R2;
CMP R2.z, -R2, R2.y, c[8].x;
ADD R2.x, -R0.w, R2.w;
ADD R2.y, -R2.x, c[8].x;
SLT R2.x, R2.y, R2.z;
SLT R1.z, R0.w, R1;
MUL R1.z, R1, R2.x;
CMP R1.z, -R1, R2.y, R2;
ADD R2.x, -R0.w, R1.w;
ADD R2.x, -R2, c[8];
ADD R2.y, R0.z, R1.w;
MAD R1.xy, -R0, c[8].y, R1;
TEX R1.w, R1, texture[0], 2D;
SLT R2.z, R2.x, R1;
SLT R2.y, R0.w, R2;
MUL R2.z, R2.y, R2;
ADD R2.y, -R0.w, R1.w;
CMP R1.z, -R2, R2.x, R1;
ADD R2.x, -R2.y, c[8];
ADD R2.y, R0.z, R1.w;
MAD R1.xy, -R0, c[8].y, R1;
TEX R1.w, R1, texture[0], 2D;
MAD R1.xy, -R0, c[8].y, R1;
MAD R0.xy, -R0, c[8].y, R1;
SLT R2.z, R2.x, R1;
SLT R2.y, R0.w, R2;
MUL R2.z, R2.y, R2;
ADD R2.y, -R0.w, R1.w;
CMP R1.z, -R2, R2.x, R1;
ADD R2.x, -R2.y, c[8];
ADD R2.y, R0.z, R1.w;
TEX R1.w, R1, texture[0], 2D;
SLT R2.z, R2.x, R1;
SLT R2.y, R0.w, R2;
MUL R2.z, R2.y, R2;
ADD R2.y, -R0.w, R1.w;
CMP R1.z, -R2, R2.x, R1;
ADD R2.x, -R2.y, c[8];
ADD R1.w, R0.z, R1;
SLT R1.x, R0.w, R1.w;
TEX R1.w, R0, texture[0], 2D;
SLT R2.y, R2.x, R1.z;
MUL R1.x, R1, R2.y;
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R3.x, R0.x;
CMP R2.z, -R1.x, R2.x, R1;
ADD R0.y, -R0.w, R1.w;
ADD R2.x, -R0.y, c[8];
MUL R1.xyz, R3.x, fragment.texcoord[1];
ADD R0.y, R1.z, c[7].z;
ADD R3.z, R1.w, R0;
MOV R0.x, c[4];
MUL R0.z, R0.x, c[7].y;
RCP R0.y, R0.y;
MAD R0.z, R0.w, c[4].x, -R0;
MUL R0.xy, R1, R0.y;
MAD R1.xy, R0.z, R0, fragment.texcoord[0].zwzw;
MOV R1.zw, c[8].xyxz;
TEX R2.yw, R1, texture[2], 2D;
MAD R1.xy, R2.wyzw, c[7].w, -R1.z;
SLT R1.z, R0.w, R3;
SLT R3.y, R2.x, R2.z;
MUL R0.w, R1.y, R1.y;
MUL R1.z, R1, R3.y;
MAD R0.w, -R1.x, R1.x, -R0;
CMP R2.x, -R1.z, R2, R2.z;
ADD R1.z, R0.w, c[8].x;
MOV R0.w, c[8].x;
ADD R0.w, R0, -c[5].x;
MAD R2.w, R0, R2.x, c[5].x;
RSQ R1.z, R1.z;
RCP R0.w, R1.z;
MUL R1.z, R0.w, R2.w;
DP3 R0.w, R1, fragment.texcoord[2];
MAX R0.w, R0, c[7].x;
MOV R2.xyz, fragment.texcoord[2];
MAD R2.xyz, R3.x, fragment.texcoord[1], R2;
DP3 R3.x, R2, R2;
RSQ R3.x, R3.x;
MUL R2.xyz, R3.x, R2;
DP3 R1.x, R1, R2;
MUL R1.y, R1.w, c[3].x;
MAX R1.x, R1, c[7];
POW R1.w, R1.x, R1.y;
MOV R1.xyz, c[1];
MUL R2.w, R2, R0;
MAD R0.xy, R0.z, R0, fragment.texcoord[0];
TEX R0, R0, texture[1], 2D;
MUL R0.xyz, R0, c[2];
MUL R0.xyz, R0, c[0];
MUL R0.xyz, R0, R2.w;
MUL R0.w, R1, R0;
MUL R1.xyz, R1, c[0];
MAD R0.xyz, R1, R0.w, R0;
MUL result.color.xyz, R0, c[7].w;
MOV result.color.w, c[7].x;
END
# 112 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_Parallax]
Float 5 [_ShadingStrength]
Float 6 [_ShadeRange]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_BumpMap] 2D
"ps_3_0
; 118 ALU, 10 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c7, 0.50000000, 0.41999999, 2.00000000, -1.00000000
def c8, 1.00000000, 0.14285715, 0.00000000, 128.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
mov r0.x, c6
add r0.x, c4, r0
mul r0.xyz, -v2, r0.x
mad r2.xy, -r0, c8.y, v0.zwzw
mad r3.xy, -r0, c8.y, r2
mad r1.xy, -r0, c8.y, r3
texld r3.w, r3, s0
texld r1.w, r1, s0
texld r0.w, v0.zwzw, s0
texld r2.w, r2, s0
add r2.x, r0.z, r2.w
add r2.y, -r0.w, r3.w
add r2.w, -r0, r2
cmp r3.x, -r2.w, c8.z, c8
add r2.x, r0.w, -r2
cmp r2.x, r2, c8.z, c8
add r1.z, -r0.w, r1.w
add r2.z, r0, r3.w
mul_pp r2.x, r2, r3
add r2.w, -r2, c8.x
cmp r2.w, -r2.x, c8.x, r2
add r2.x, r0.w, -r2.z
add r2.y, -r2, c8.x
add r3.x, -r2.w, r2.y
mad r1.xy, -r0, c8.y, r1
cmp r2.x, r2, c8.z, c8
cmp r2.z, r3.x, c8, c8.x
mul_pp r2.z, r2.x, r2
cmp r2.y, -r2.z, r2.w, r2
add r2.z, r0, r1.w
texld r1.w, r1, s0
add r2.x, -r1.z, c8
add r1.z, -r2.y, r2.x
add r2.z, r0.w, -r2
add r2.w, -r0, r1
mad r1.xy, -r0, c8.y, r1
cmp r1.z, r1, c8, c8.x
cmp r2.z, r2, c8, c8.x
mul_pp r2.z, r2, r1
cmp r2.y, -r2.z, r2, r2.x
add r2.z, r0, r1.w
add r1.z, -r2.w, c8.x
texld r1.w, r1, s0
mad r1.xy, -r0, c8.y, r1
add r2.x, -r2.y, r1.z
add r2.z, r0.w, -r2
mad r0.xy, -r0, c8.y, r1
add r2.w, -r0, r1
cmp r2.x, r2, c8.z, c8
cmp r2.z, r2, c8, c8.x
mul_pp r2.z, r2, r2.x
cmp r2.y, -r2.z, r2, r1.z
add r2.z, r0, r1.w
texld r1.w, r1, s0
add r2.x, -r2.w, c8
add r1.z, -r2.y, r2.x
add r2.z, r0.w, -r2
add r2.w, -r0, r1
add r1.x, r0.z, r1.w
texld r1.w, r0, s0
add r0.x, r0.w, -r1
add r0.y, -r0.w, r1.w
add r1.x, r1.w, r0.z
add r1.w, r0, -r1.x
cmp r1.z, r1, c8, c8.x
cmp r2.z, r2, c8, c8.x
mul_pp r2.z, r2, r1
cmp r2.y, -r2.z, r2, r2.x
add r1.z, -r2.w, c8.x
add r2.x, -r2.y, r1.z
cmp r2.x, r2, c8.z, c8
cmp r0.x, r0, c8.z, c8
mul_pp r0.x, r0, r2
cmp r1.z, -r0.x, r2.y, r1
add r2.x, -r0.y, c8
add r0.y, -r1.z, r2.x
dp3_pp r0.x, v1, v1
rsq_pp r2.w, r0.x
cmp r2.y, r0, c8.z, c8.x
mul_pp r0.xyz, r2.w, v1
add r1.x, r0.z, c7.y
mov_pp r0.z, c7.x
mul_pp r0.z, c4.x, r0
mad_pp r0.w, r0, c4.x, -r0.z
cmp r0.z, r1.w, c8, c8.x
mul_pp r0.z, r0, r2.y
cmp r1.w, -r0.z, r1.z, r2.x
rcp r1.x, r1.x
mul r1.xy, r0, r1.x
mad r0.xy, r0.w, r1, v0.zwzw
texld r3.yw, r0, s2
mad_pp r0.xy, r3.wyzw, c7.z, c7.w
mul_pp r0.z, r0.y, r0.y
mad_pp r0.z, -r0.x, r0.x, -r0
mov r1.z, c5.x
add r1.z, c8.x, -r1
add_pp r0.z, r0, c8.x
mov_pp r2.xyz, v2
rsq_pp r0.z, r0.z
mad r1.z, r1, r1.w, c5.x
mad_pp r2.xyz, r2.w, v1, r2
dp3_pp r1.w, r2, r2
rsq_pp r1.w, r1.w
rcp_pp r0.z, r0.z
mul r0.z, r0, r1
mul_pp r2.xyz, r1.w, r2
dp3 r2.w, r0, v2
dp3 r0.x, r0, r2
max r1.w, r2, c8.z
max r2.y, r0.x, c8.z
mov_pp r0.z, c3.x
mad r0.xy, r0.w, r1, v0
mul r2.x, r1.z, r1.w
texld r1, r0, s1
mul_pp r2.z, c8.w, r0
pow r0, r2.y, r2.z
mov r0.w, r0.x
mul_pp r1.xyz, r1, c2
mul_pp r1.xyz, r1, c0
mov_pp r0.xyz, c0
mul_pp r1.xyz, r1, r2.x
mul r0.w, r0, r1
mul_pp r0.xyz, c1, r0
mad r0.xyz, r0, r0.w, r1
mul oC0.xyz, r0, c7.z
mov_pp oC0.w, c8.z
"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_Parallax]
Float 5 [_ShadingStrength]
Float 6 [_ShadeRange]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_LightTexture0] 2D
SetTexture 4 [_LightTextureB0] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 123 ALU, 12 TEX
PARAM c[9] = { program.local[0..6],
		{ 0, 0.5, 0.41999999, 2 },
		{ 1, 0.14285715, 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MOV R0.x, c[4];
DP3 R0.y, fragment.texcoord[2], fragment.texcoord[2];
ADD R0.w, R0.x, c[6].x;
RSQ R0.y, R0.y;
MUL R0.xyz, R0.y, fragment.texcoord[2];
MUL R1.xyz, -R0, R0.w;
MAD R3.xy, -R1, c[8].y, fragment.texcoord[0].zwzw;
MAD R2.zw, -R1.xyxy, c[8].y, R3.xyxy;
MAD R2.xy, -R1, c[8].y, R2.zwzw;
TEX R3.w, R3, texture[0], 2D;
TEX R0.w, fragment.texcoord[0].zwzw, texture[0], 2D;
TEX R1.w, R2, texture[0], 2D;
TEX R2.w, R2.zwzw, texture[0], 2D;
ADD R3.x, -R0.w, R3.w;
ADD R2.z, R1, R2.w;
ADD R3.x, -R3, c[8];
ADD R3.y, R1.z, R3.w;
SLT R3.y, R0.w, R3;
SLT R3.z, R3.x, c[8].x;
MUL R3.z, R3.y, R3;
ADD R3.y, -R0.w, R2.w;
CMP R2.w, -R3.z, R3.x, c[8].x;
ADD R3.x, -R3.y, c[8];
SLT R3.y, R3.x, R2.w;
SLT R2.z, R0.w, R2;
MUL R3.y, R2.z, R3;
CMP R2.w, -R3.y, R3.x, R2;
ADD R2.z, -R0.w, R1.w;
ADD R2.z, -R2, c[8].x;
ADD R3.y, R1.z, R1.w;
MAD R2.xy, -R1, c[8].y, R2;
TEX R1.w, R2, texture[0], 2D;
SLT R3.x, R2.z, R2.w;
SLT R3.y, R0.w, R3;
MUL R3.y, R3, R3.x;
CMP R2.w, -R3.y, R2.z, R2;
ADD R3.x, -R0.w, R1.w;
ADD R2.z, -R3.x, c[8].x;
ADD R3.y, R1.z, R1.w;
MAD R2.xy, -R1, c[8].y, R2;
TEX R1.w, R2, texture[0], 2D;
MAD R2.xy, -R1, c[8].y, R2;
MAD R1.xy, -R1, c[8].y, R2;
SLT R3.x, R2.z, R2.w;
SLT R3.y, R0.w, R3;
MUL R3.y, R3, R3.x;
CMP R2.w, -R3.y, R2.z, R2;
ADD R3.x, -R0.w, R1.w;
ADD R3.y, R1.z, R1.w;
ADD R2.z, -R3.x, c[8].x;
SLT R3.x, R2.z, R2.w;
SLT R3.y, R0.w, R3;
MUL R3.y, R3, R3.x;
TEX R1.w, R2, texture[0], 2D;
ADD R3.x, -R0.w, R1.w;
CMP R2.w, -R3.y, R2.z, R2;
ADD R2.z, -R3.x, c[8].x;
ADD R1.w, R1.z, R1;
SLT R3.x, R2.z, R2.w;
SLT R1.w, R0, R1;
MUL R2.x, R1.w, R3;
TEX R1.w, R1, texture[0], 2D;
ADD R1.y, -R0.w, R1.w;
DP3 R1.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R3.z, R1.x;
CMP R4.x, -R2, R2.z, R2.w;
ADD R3.w, -R1.y, c[8].x;
MUL R2.xyz, R3.z, fragment.texcoord[1];
ADD R4.w, R1, R1.z;
ADD R1.y, R2.z, c[7].z;
RCP R1.y, R1.y;
MOV R1.x, c[4];
MUL R1.x, R1, c[7].y;
MUL R3.xy, R2, R1.y;
MAD R4.z, R0.w, c[4].x, -R1.x;
MAD R1.xy, R4.z, R3, fragment.texcoord[0].zwzw;
MOV R1.zw, c[8].xyxz;
TEX R2.yw, R1, texture[2], 2D;
MAD R1.xy, R2.wyzw, c[7].w, -R1.z;
SLT R1.z, R0.w, R4.w;
MUL R0.w, R1.y, R1.y;
SLT R4.y, R3.w, R4.x;
MUL R1.z, R1, R4.y;
MAD R0.w, -R1.x, R1.x, -R0;
CMP R2.x, -R1.z, R3.w, R4;
ADD R1.z, R0.w, c[8].x;
MOV R0.w, c[8].x;
RSQ R1.z, R1.z;
ADD R0.w, R0, -c[5].x;
MAD R0.w, R0, R2.x, c[5].x;
MAD R2.xyz, R3.z, fragment.texcoord[1], R0;
RCP R1.z, R1.z;
MUL R1.z, R1, R0.w;
DP3 R2.w, R2, R2;
DP3 R0.y, R1, R0;
RSQ R0.x, R2.w;
MAX R2.w, R0.y, c[7].x;
MUL R0.xyz, R0.x, R2;
DP3 R0.x, R1, R0;
MUL R2.x, R0.w, R2.w;
MUL R1.y, R1.w, c[3].x;
MAX R1.x, R0, c[7];
MAD R0.zw, R4.z, R3.xyxy, fragment.texcoord[0].xyxy;
TEX R0, R0.zwzw, texture[1], 2D;
MUL R0.xyz, R0, c[2];
MUL R0.xyz, R0, c[0];
DP3 R1.w, fragment.texcoord[3], fragment.texcoord[3];
MUL R0.xyz, R0, R2.x;
POW R1.x, R1.x, R1.y;
MUL R2.x, R1, R0.w;
RCP R0.w, fragment.texcoord[3].w;
MOV R1.xyz, c[1];
MAD R2.zw, fragment.texcoord[3].xyxy, R0.w, c[7].y;
MUL R1.xyz, R1, c[0];
TEX R0.w, R2.zwzw, texture[3], 2D;
SLT R2.y, c[7].x, fragment.texcoord[3].z;
TEX R1.w, R1.w, texture[4], 2D;
MUL R0.w, R2.y, R0;
MUL R0.w, R0, R1;
MUL R0.w, R0, c[7];
MAD R0.xyz, R1, R2.x, R0;
MUL result.color.xyz, R0, R0.w;
MOV result.color.w, c[7].x;
END
# 123 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_Parallax]
Float 5 [_ShadingStrength]
Float 6 [_ShadeRange]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_LightTexture0] 2D
SetTexture 4 [_LightTextureB0] 2D
"ps_3_0
; 127 ALU, 12 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c7, 0.50000000, 0.41999999, 2.00000000, -1.00000000
def c8, 1.00000000, 0.14285715, 0.00000000, 128.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3
mov r0.y, c6.x
dp3_pp r0.x, v2, v2
add r0.w, c4.x, r0.y
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, v2
mul r1.xyz, -r0, r0.w
mad r3.xy, -r1, c8.y, v0.zwzw
mad r4.xy, -r1, c8.y, r3
mad r2.xy, -r1, c8.y, r4
texld r3.w, r4, s0
texld r2.w, r3, s0
texld r0.w, v0.zwzw, s0
texld r1.w, r2, s0
add r2.z, r1, r3.w
add r3.x, -r0.w, r3.w
add r3.y, r1.z, r2.w
add r2.z, r0.w, -r2
add r3.z, -r0.w, r1.w
add r3.w, -r0, r2
add r3.y, r0.w, -r3
cmp r2.w, r3.y, c8.z, c8.x
cmp r3.y, -r3.w, c8.z, c8.x
mul_pp r2.w, r2, r3.y
add r3.w, -r3, c8.x
cmp r2.w, -r2, c8.x, r3
add r3.x, -r3, c8
add r3.y, -r2.w, r3.x
mad r2.xy, -r1, c8.y, r2
cmp r2.z, r2, c8, c8.x
cmp r3.y, r3, c8.z, c8.x
mul_pp r3.y, r2.z, r3
cmp r3.x, -r3.y, r2.w, r3
add r2.z, -r3, c8.x
add r3.y, r1.z, r1.w
texld r1.w, r2, s0
add r3.z, r0.w, -r3.y
add r2.w, -r3.x, r2.z
add r3.y, -r0.w, r1.w
mad r2.xy, -r1, c8.y, r2
cmp r2.w, r2, c8.z, c8.x
cmp r3.z, r3, c8, c8.x
mul_pp r3.z, r3, r2.w
add r2.w, -r3.y, c8.x
cmp r3.x, -r3.z, r3, r2.z
add r3.y, r1.z, r1.w
texld r1.w, r2, s0
add r3.z, r0.w, -r3.y
mad r2.xy, -r1, c8.y, r2
add r2.z, -r3.x, r2.w
mad r1.xy, -r1, c8.y, r2
add r3.y, -r0.w, r1.w
cmp r2.z, r2, c8, c8.x
cmp r3.z, r3, c8, c8.x
mul_pp r3.z, r3, r2
add r2.z, -r3.y, c8.x
cmp r2.w, -r3.z, r3.x, r2
add r3.y, r1.z, r1.w
add r3.x, -r2.w, r2.z
add r3.z, r0.w, -r3.y
texld r1.w, r2, s0
add r3.y, -r0.w, r1.w
cmp r3.x, r3, c8.z, c8
cmp r3.z, r3, c8, c8.x
mul_pp r3.z, r3, r3.x
cmp r2.z, -r3, r2.w, r2
add r3.x, -r3.y, c8
add r2.w, r1.z, r1
add r3.y, -r2.z, r3.x
add r2.w, r0, -r2
cmp r1.w, r3.y, c8.z, c8.x
cmp r2.x, r2.w, c8.z, c8
mul_pp r2.x, r2, r1.w
texld r1.w, r1, s0
add r1.y, -r0.w, r1.w
add r1.z, r1.w, r1
cmp r3.z, -r2.x, r2, r3.x
dp3_pp r1.x, v1, v1
rsq_pp r3.x, r1.x
add r4.x, -r1.y, c8
mul_pp r2.xyz, r3.x, v1
add r1.x, -r3.z, r4
cmp r4.y, r1.x, c8.z, c8.x
add r1.y, r2.z, c7
mov_pp r1.x, c7
mul_pp r2.z, c4.x, r1.x
mad_pp r2.w, r0, c4.x, -r2.z
add r0.w, r0, -r1.z
cmp r1.z, r0.w, c8, c8.x
mul_pp r1.z, r1, r4.y
rcp r1.y, r1.y
mul r1.xy, r2, r1.y
mad r2.xy, r2.w, r1, v0.zwzw
texld r3.yw, r2, s2
mad_pp r2.xy, r3.wyzw, c7.z, c7.w
cmp r2.z, -r1, r3, r4.x
mul_pp r0.w, r2.y, r2.y
mad_pp r0.w, -r2.x, r2.x, -r0
add_pp r0.w, r0, c8.x
rsq_pp r1.z, r0.w
mov r1.w, c5.x
add r0.w, c8.x, -r1
mad_pp r3.xyz, r3.x, v1, r0
mad r0.w, r0, r2.z, c5.x
rcp_pp r1.z, r1.z
mul r2.z, r1, r0.w
dp3 r0.y, r2, r0
dp3_pp r1.z, r3, r3
rsq_pp r0.x, r1.z
max r1.z, r0.y, c8
mul_pp r0.xyz, r0.x, r3
dp3 r0.x, r2, r0
mul r1.z, r0.w, r1
mov_pp r0.y, c3.x
max r0.z, r0.x, c8
mul_pp r0.w, c8, r0.y
mad r0.xy, r2.w, r1, v0
pow r2, r0.z, r0.w
texld r0, r0, s1
mul_pp r3.xyz, r0, c2
mov r0.x, r2
mul r0.y, r0.x, r0.w
mul_pp r2.xyz, r3, c0
mul_pp r2.xyz, r2, r1.z
rcp r0.x, v3.w
mad r3.xy, v3, r0.x, c7.x
mov_pp r1.xyz, c0
dp3 r0.x, v3, v3
texld r0.w, r3, s3
cmp r0.z, -v3, c8, c8.x
mul_pp r0.z, r0, r0.w
texld r0.x, r0.x, s4
mul_pp r0.x, r0.z, r0
mul_pp r0.w, r0.x, c7.z
mul_pp r1.xyz, c1, r1
mad r0.xyz, r1, r0.y, r2
mul oC0.xyz, r0, r0.w
mov_pp oC0.w, c8.z
"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_Parallax]
Float 5 [_ShadingStrength]
Float 6 [_ShadeRange]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_LightTextureB0] 2D
SetTexture 4 [_LightTexture0] CUBE
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 119 ALU, 12 TEX
PARAM c[9] = { program.local[0..6],
		{ 0, 0.5, 0.41999999, 2 },
		{ 1, 0.14285715, 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MOV R0.x, c[4];
DP3 R0.y, fragment.texcoord[2], fragment.texcoord[2];
ADD R0.w, R0.x, c[6].x;
RSQ R0.y, R0.y;
MUL R0.xyz, R0.y, fragment.texcoord[2];
MUL R1.xyz, -R0, R0.w;
MAD R3.xy, -R1, c[8].y, fragment.texcoord[0].zwzw;
MAD R2.zw, -R1.xyxy, c[8].y, R3.xyxy;
MAD R2.xy, -R1, c[8].y, R2.zwzw;
TEX R3.w, R3, texture[0], 2D;
TEX R0.w, fragment.texcoord[0].zwzw, texture[0], 2D;
TEX R1.w, R2, texture[0], 2D;
TEX R2.w, R2.zwzw, texture[0], 2D;
ADD R3.x, -R0.w, R3.w;
ADD R2.z, R1, R2.w;
ADD R3.x, -R3, c[8];
ADD R3.y, R1.z, R3.w;
SLT R3.y, R0.w, R3;
SLT R3.z, R3.x, c[8].x;
MUL R3.z, R3.y, R3;
ADD R3.y, -R0.w, R2.w;
CMP R2.w, -R3.z, R3.x, c[8].x;
ADD R3.x, -R3.y, c[8];
SLT R3.y, R3.x, R2.w;
SLT R2.z, R0.w, R2;
MUL R3.y, R2.z, R3;
CMP R2.w, -R3.y, R3.x, R2;
ADD R2.z, -R0.w, R1.w;
ADD R2.z, -R2, c[8].x;
ADD R3.y, R1.z, R1.w;
MAD R2.xy, -R1, c[8].y, R2;
TEX R1.w, R2, texture[0], 2D;
SLT R3.x, R2.z, R2.w;
SLT R3.y, R0.w, R3;
MUL R3.y, R3, R3.x;
CMP R2.w, -R3.y, R2.z, R2;
ADD R3.x, -R0.w, R1.w;
ADD R2.z, -R3.x, c[8].x;
ADD R3.y, R1.z, R1.w;
MAD R2.xy, -R1, c[8].y, R2;
TEX R1.w, R2, texture[0], 2D;
MAD R2.xy, -R1, c[8].y, R2;
MAD R1.xy, -R1, c[8].y, R2;
SLT R3.x, R2.z, R2.w;
SLT R3.y, R0.w, R3;
MUL R3.y, R3, R3.x;
CMP R2.w, -R3.y, R2.z, R2;
ADD R3.x, -R0.w, R1.w;
ADD R3.y, R1.z, R1.w;
ADD R2.z, -R3.x, c[8].x;
SLT R3.x, R2.z, R2.w;
SLT R3.y, R0.w, R3;
MUL R3.y, R3, R3.x;
TEX R1.w, R2, texture[0], 2D;
ADD R3.x, -R0.w, R1.w;
CMP R2.w, -R3.y, R2.z, R2;
ADD R2.z, -R3.x, c[8].x;
ADD R1.w, R1.z, R1;
SLT R3.x, R2.z, R2.w;
SLT R1.w, R0, R1;
MUL R2.x, R1.w, R3;
TEX R1.w, R1, texture[0], 2D;
ADD R1.y, -R0.w, R1.w;
DP3 R1.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R3.z, R1.x;
CMP R4.x, -R2, R2.z, R2.w;
ADD R3.w, -R1.y, c[8].x;
MUL R2.xyz, R3.z, fragment.texcoord[1];
ADD R4.w, R1, R1.z;
ADD R1.y, R2.z, c[7].z;
RCP R1.y, R1.y;
MOV R1.x, c[4];
MUL R1.x, R1, c[7].y;
MUL R3.xy, R2, R1.y;
MAD R4.z, R0.w, c[4].x, -R1.x;
MAD R1.xy, R4.z, R3, fragment.texcoord[0].zwzw;
MOV R1.zw, c[8].xyxz;
TEX R2.yw, R1, texture[2], 2D;
MAD R1.xy, R2.wyzw, c[7].w, -R1.z;
SLT R1.z, R0.w, R4.w;
MUL R0.w, R1.y, R1.y;
SLT R4.y, R3.w, R4.x;
MUL R1.z, R1, R4.y;
MAD R0.w, -R1.x, R1.x, -R0;
CMP R2.x, -R1.z, R3.w, R4;
ADD R1.z, R0.w, c[8].x;
MOV R0.w, c[8].x;
RSQ R1.z, R1.z;
ADD R0.w, R0, -c[5].x;
MAD R0.w, R0, R2.x, c[5].x;
MAD R2.xyz, R3.z, fragment.texcoord[1], R0;
RCP R1.z, R1.z;
MUL R1.z, R1, R0.w;
DP3 R0.y, R1, R0;
DP3 R2.w, R2, R2;
RSQ R0.x, R2.w;
MAX R2.w, R0.y, c[7].x;
MUL R0.xyz, R0.x, R2;
DP3 R0.x, R1, R0;
MUL R2.x, R0.w, R2.w;
MUL R1.y, R1.w, c[3].x;
MAX R1.x, R0, c[7];
MAD R0.zw, R4.z, R3.xyxy, fragment.texcoord[0].xyxy;
TEX R0, R0.zwzw, texture[1], 2D;
MUL R0.xyz, R0, c[2];
MUL R0.xyz, R0, c[0];
DP3 R1.w, fragment.texcoord[3], fragment.texcoord[3];
MUL R0.xyz, R0, R2.x;
POW R1.x, R1.x, R1.y;
MUL R2.x, R1, R0.w;
MOV R1.xyz, c[1];
MUL R1.xyz, R1, c[0];
TEX R0.w, fragment.texcoord[3], texture[4], CUBE;
TEX R1.w, R1.w, texture[3], 2D;
MUL R0.w, R1, R0;
MUL R0.w, R0, c[7];
MAD R0.xyz, R1, R2.x, R0;
MUL result.color.xyz, R0, R0.w;
MOV result.color.w, c[7].x;
END
# 119 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_Parallax]
Float 5 [_ShadingStrength]
Float 6 [_ShadeRange]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_LightTextureB0] 2D
SetTexture 4 [_LightTexture0] CUBE
"ps_3_0
; 123 ALU, 12 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_cube s4
def c7, 0.50000000, 0.41999999, 2.00000000, -1.00000000
def c8, 1.00000000, 0.14285715, 0.00000000, 128.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
mov r0.y, c6.x
dp3_pp r0.x, v2, v2
add r0.w, c4.x, r0.y
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, v2
mul r1.xyz, -r0, r0.w
mad r3.xy, -r1, c8.y, v0.zwzw
mad r4.xy, -r1, c8.y, r3
mad r2.xy, -r1, c8.y, r4
texld r3.w, r4, s0
texld r2.w, r3, s0
texld r0.w, v0.zwzw, s0
texld r1.w, r2, s0
add r2.z, r1, r3.w
add r3.x, -r0.w, r3.w
add r3.y, r1.z, r2.w
add r2.z, r0.w, -r2
add r3.z, -r0.w, r1.w
add r3.w, -r0, r2
add r3.y, r0.w, -r3
cmp r2.w, r3.y, c8.z, c8.x
cmp r3.y, -r3.w, c8.z, c8.x
mul_pp r2.w, r2, r3.y
add r3.w, -r3, c8.x
cmp r2.w, -r2, c8.x, r3
add r3.x, -r3, c8
add r3.y, -r2.w, r3.x
mad r2.xy, -r1, c8.y, r2
cmp r2.z, r2, c8, c8.x
cmp r3.y, r3, c8.z, c8.x
mul_pp r3.y, r2.z, r3
cmp r3.x, -r3.y, r2.w, r3
add r2.z, -r3, c8.x
add r3.y, r1.z, r1.w
texld r1.w, r2, s0
add r3.z, r0.w, -r3.y
add r2.w, -r3.x, r2.z
add r3.y, -r0.w, r1.w
mad r2.xy, -r1, c8.y, r2
cmp r2.w, r2, c8.z, c8.x
cmp r3.z, r3, c8, c8.x
mul_pp r3.z, r3, r2.w
add r2.w, -r3.y, c8.x
cmp r3.x, -r3.z, r3, r2.z
add r3.y, r1.z, r1.w
texld r1.w, r2, s0
add r3.z, r0.w, -r3.y
mad r2.xy, -r1, c8.y, r2
add r2.z, -r3.x, r2.w
mad r1.xy, -r1, c8.y, r2
add r3.y, -r0.w, r1.w
cmp r2.z, r2, c8, c8.x
cmp r3.z, r3, c8, c8.x
mul_pp r3.z, r3, r2
add r2.z, -r3.y, c8.x
cmp r2.w, -r3.z, r3.x, r2
add r3.y, r1.z, r1.w
add r3.x, -r2.w, r2.z
add r3.z, r0.w, -r3.y
texld r1.w, r2, s0
add r3.y, -r0.w, r1.w
cmp r3.x, r3, c8.z, c8
cmp r3.z, r3, c8, c8.x
mul_pp r3.z, r3, r3.x
cmp r2.z, -r3, r2.w, r2
add r3.x, -r3.y, c8
add r2.w, r1.z, r1
add r3.y, -r2.z, r3.x
add r2.w, r0, -r2
cmp r1.w, r3.y, c8.z, c8.x
cmp r2.x, r2.w, c8.z, c8
mul_pp r2.x, r2, r1.w
texld r1.w, r1, s0
add r1.y, -r0.w, r1.w
add r1.z, r1.w, r1
cmp r3.z, -r2.x, r2, r3.x
dp3_pp r1.x, v1, v1
rsq_pp r3.x, r1.x
add r4.x, -r1.y, c8
mul_pp r2.xyz, r3.x, v1
add r1.x, -r3.z, r4
cmp r4.y, r1.x, c8.z, c8.x
add r1.y, r2.z, c7
mov_pp r1.x, c7
mul_pp r2.z, c4.x, r1.x
mad_pp r2.w, r0, c4.x, -r2.z
add r0.w, r0, -r1.z
cmp r1.z, r0.w, c8, c8.x
mul_pp r1.z, r1, r4.y
rcp r1.y, r1.y
mul r1.xy, r2, r1.y
mad r2.xy, r2.w, r1, v0.zwzw
texld r3.yw, r2, s2
mad_pp r2.xy, r3.wyzw, c7.z, c7.w
cmp r2.z, -r1, r3, r4.x
mul_pp r0.w, r2.y, r2.y
mad_pp r0.w, -r2.x, r2.x, -r0
add_pp r0.w, r0, c8.x
rsq_pp r1.z, r0.w
mov r1.w, c5.x
add r0.w, c8.x, -r1
mad_pp r3.xyz, r3.x, v1, r0
mad r0.w, r0, r2.z, c5.x
rcp_pp r1.z, r1.z
mul r2.z, r1, r0.w
dp3 r0.y, r2, r0
dp3_pp r1.z, r3, r3
rsq_pp r0.x, r1.z
max r1.z, r0.y, c8
mul_pp r0.xyz, r0.x, r3
dp3 r0.x, r2, r0
mul r1.z, r0.w, r1
mov_pp r0.y, c3.x
max r0.z, r0.x, c8
mul_pp r0.w, c8, r0.y
mad r0.xy, r2.w, r1, v0
pow r2, r0.z, r0.w
texld r0, r0, s1
mul_pp r3.xyz, r0, c2
mov r0.x, r2
mul r1.w, r0.x, r0
mul_pp r2.xyz, r3, c0
mul_pp r2.xyz, r2, r1.z
dp3 r0.x, v3, v3
texld r0.x, r0.x, s3
texld r0.w, v3, s4
mul r0.w, r0.x, r0
mov_pp r1.xyz, c0
mul_pp r0.xyz, c1, r1
mul_pp r0.w, r0, c7.z
mad r0.xyz, r0, r1.w, r2
mul oC0.xyz, r0, r0.w
mov_pp oC0.w, c8.z
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_Parallax]
Float 5 [_ShadingStrength]
Float 6 [_ShadeRange]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_LightTexture0] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 114 ALU, 11 TEX
PARAM c[9] = { program.local[0..6],
		{ 0, 0.5, 0.41999999, 2 },
		{ 1, 0.14285715, 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.x, c[4];
ADD R0.x, R0, c[6];
MUL R0.xyz, -fragment.texcoord[2], R0.x;
MAD R2.xy, -R0, c[8].y, fragment.texcoord[0].zwzw;
MAD R2.zw, -R0.xyxy, c[8].y, R2.xyxy;
MAD R1.xy, -R0, c[8].y, R2.zwzw;
TEX R2.w, R2.zwzw, texture[0], 2D;
TEX R1.w, R1, texture[0], 2D;
TEX R0.w, fragment.texcoord[0].zwzw, texture[0], 2D;
TEX R3.w, R2, texture[0], 2D;
ADD R2.x, -R0.w, R3.w;
ADD R2.y, -R2.x, c[8].x;
ADD R1.z, R0, R2.w;
ADD R2.x, R0.z, R3.w;
SLT R2.x, R0.w, R2;
SLT R2.z, R2.y, c[8].x;
MUL R2.z, R2.x, R2;
CMP R2.z, -R2, R2.y, c[8].x;
ADD R2.x, -R0.w, R2.w;
ADD R2.y, -R2.x, c[8].x;
SLT R2.x, R2.y, R2.z;
SLT R1.z, R0.w, R1;
MUL R1.z, R1, R2.x;
CMP R1.z, -R1, R2.y, R2;
ADD R2.x, -R0.w, R1.w;
ADD R2.x, -R2, c[8];
ADD R2.y, R0.z, R1.w;
MAD R1.xy, -R0, c[8].y, R1;
TEX R1.w, R1, texture[0], 2D;
SLT R2.z, R2.x, R1;
SLT R2.y, R0.w, R2;
MUL R2.z, R2.y, R2;
ADD R2.y, -R0.w, R1.w;
CMP R1.z, -R2, R2.x, R1;
ADD R2.x, -R2.y, c[8];
ADD R2.y, R0.z, R1.w;
MAD R1.xy, -R0, c[8].y, R1;
TEX R1.w, R1, texture[0], 2D;
MAD R1.xy, -R0, c[8].y, R1;
MAD R0.xy, -R0, c[8].y, R1;
SLT R2.z, R2.x, R1;
SLT R2.y, R0.w, R2;
MUL R2.z, R2.y, R2;
ADD R2.y, -R0.w, R1.w;
CMP R1.z, -R2, R2.x, R1;
ADD R2.x, -R2.y, c[8];
ADD R2.y, R0.z, R1.w;
TEX R1.w, R1, texture[0], 2D;
ADD R1.x, R0.z, R1.w;
SLT R2.z, R2.x, R1;
SLT R2.y, R0.w, R2;
MUL R2.z, R2.y, R2;
ADD R2.y, -R0.w, R1.w;
CMP R1.z, -R2, R2.x, R1;
TEX R1.w, R0, texture[0], 2D;
ADD R2.x, -R2.y, c[8];
SLT R0.x, R0.w, R1;
SLT R2.y, R2.x, R1.z;
MUL R0.y, R0.x, R2;
ADD R1.x, R1.w, R0.z;
CMP R2.z, -R0.y, R2.x, R1;
ADD R0.x, -R0.w, R1.w;
ADD R2.x, -R0, c[8];
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R1.z, R0.x;
SLT R3.x, R2, R2.z;
MUL R0.xyz, R1.z, fragment.texcoord[1];
SLT R3.y, R0.w, R1.x;
ADD R1.x, R0.z, c[7].z;
RCP R1.x, R1.x;
MOV R0.z, c[4].x;
MUL R0.z, R0, c[7].y;
MAD R1.w, R0, c[4].x, -R0.z;
MUL R0.xy, R0, R1.x;
MAD R1.xy, R1.w, R0, fragment.texcoord[0].zwzw;
MOV R0.zw, c[8].xyxz;
TEX R2.yw, R1, texture[2], 2D;
MAD R1.xy, R2.wyzw, c[7].w, -R0.z;
MUL R2.y, R3, R3.x;
CMP R2.y, -R2, R2.x, R2.z;
MUL R0.z, R1.y, R1.y;
MAD R2.x, -R1, R1, -R0.z;
ADD R2.x, R2, c[8];
RSQ R2.w, R2.x;
MOV R0.z, c[8].x;
ADD R0.z, R0, -c[5].x;
MAD R0.z, R0, R2.y, c[5].x;
MOV R2.xyz, fragment.texcoord[2];
MAD R2.xyz, R1.z, fragment.texcoord[1], R2;
RCP R2.w, R2.w;
MUL R1.z, R2.w, R0;
DP3 R3.x, R1, fragment.texcoord[2];
DP3 R2.w, R2, R2;
RSQ R2.w, R2.w;
MAX R3.x, R3, c[7];
MUL R2.xyz, R2.w, R2;
DP3 R1.x, R1, R2;
MAD R1.zw, R1.w, R0.xyxy, fragment.texcoord[0].xyxy;
MAX R0.x, R1, c[7];
TEX R1, R1.zwzw, texture[1], 2D;
MUL R0.y, R0.w, c[3].x;
POW R0.w, R0.x, R0.y;
MUL R1.w, R0, R1;
MUL R1.xyz, R1, c[2];
TEX R0.w, fragment.texcoord[3], texture[3], 2D;
MUL R1.xyz, R1, c[0];
MUL R0.z, R0, R3.x;
MUL R0.xyz, R1, R0.z;
MOV R1.xyz, c[1];
MUL R1.xyz, R1, c[0];
MUL R0.w, R0, c[7];
MAD R0.xyz, R1, R1.w, R0;
MUL result.color.xyz, R0, R0.w;
MOV result.color.w, c[7].x;
END
# 114 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_Parallax]
Float 5 [_ShadingStrength]
Float 6 [_ShadeRange]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_LightTexture0] 2D
"ps_3_0
; 119 ALU, 11 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c7, 0.50000000, 0.41999999, 2.00000000, -1.00000000
def c8, 1.00000000, 0.14285715, 0.00000000, 128.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xy
mov r0.x, c6
add r0.x, c4, r0
mul r0.xyz, -v2, r0.x
mad r2.xy, -r0, c8.y, v0.zwzw
mad r3.xy, -r0, c8.y, r2
mad r1.xy, -r0, c8.y, r3
texld r1.w, r1, s0
texld r0.w, v0.zwzw, s0
texld r2.w, r2, s0
texld r3.w, r3, s0
add r2.x, r0.z, r2.w
add r2.w, -r0, r2
cmp r3.x, -r2.w, c8.z, c8
add r2.y, -r0.w, r3.w
add r2.x, r0.w, -r2
cmp r2.x, r2, c8.z, c8
add r1.z, -r0.w, r1.w
mul_pp r2.x, r2, r3
add r2.w, -r2, c8.x
cmp r2.w, -r2.x, c8.x, r2
add r2.z, r0, r3.w
add r2.x, r0.w, -r2.z
add r2.y, -r2, c8.x
add r3.x, -r2.w, r2.y
mad r1.xy, -r0, c8.y, r1
cmp r2.x, r2, c8.z, c8
cmp r2.z, r3.x, c8, c8.x
mul_pp r2.z, r2.x, r2
cmp r2.y, -r2.z, r2.w, r2
add r2.z, r0, r1.w
texld r1.w, r1, s0
add r2.x, -r1.z, c8
add r1.z, -r2.y, r2.x
add r2.z, r0.w, -r2
add r2.w, -r0, r1
mad r1.xy, -r0, c8.y, r1
cmp r1.z, r1, c8, c8.x
cmp r2.z, r2, c8, c8.x
mul_pp r2.z, r2, r1
cmp r2.y, -r2.z, r2, r2.x
add r2.z, r0, r1.w
add r1.z, -r2.w, c8.x
texld r1.w, r1, s0
mad r1.xy, -r0, c8.y, r1
add r2.x, -r2.y, r1.z
add r2.z, r0.w, -r2
mad r0.xy, -r0, c8.y, r1
add r2.w, -r0, r1
cmp r2.x, r2, c8.z, c8
cmp r2.z, r2, c8, c8.x
mul_pp r2.z, r2, r2.x
cmp r2.y, -r2.z, r2, r1.z
add r2.z, r0, r1.w
add r2.x, -r2.w, c8
texld r1.w, r1, s0
add r2.w, -r0, r1
add r1.z, -r2.y, r2.x
add r1.w, r0.z, r1
add r1.x, r0.w, -r1.w
texld r1.w, r0, s0
add r2.z, r0.w, -r2
add r0.z, r1.w, r0
add r0.z, r0.w, -r0
add r0.y, -r0.w, r1.w
cmp r1.z, r1, c8, c8.x
cmp r2.z, r2, c8, c8.x
mul_pp r2.z, r2, r1
cmp r2.x, -r2.z, r2.y, r2
add r1.z, -r2.w, c8.x
add r2.y, -r2.x, r1.z
cmp r2.y, r2, c8.z, c8.x
cmp r0.x, r1, c8.z, c8
mul_pp r0.x, r0, r2.y
cmp r2.y, -r0.x, r2.x, r1.z
add r2.x, -r0.y, c8
add r0.y, -r2, r2.x
dp3_pp r0.x, v1, v1
rsq_pp r2.w, r0.x
mov_pp r0.x, c7
mul_pp r1.xyz, r2.w, v1
cmp r2.z, r0.y, c8, c8.x
add r0.y, r1.z, c7
rcp r0.y, r0.y
mul_pp r0.x, c4, r0
mad_pp r1.z, r0.w, c4.x, -r0.x
mul r1.xy, r1, r0.y
mad r0.xy, r1.z, r1, v0.zwzw
texld r0.yw, r0, s2
mad_pp r0.xy, r0.wyzw, c7.z, c7.w
cmp r0.z, r0, c8, c8.x
mul_pp r0.w, r0.z, r2.z
cmp r1.w, -r0, r2.y, r2.x
mul_pp r0.z, r0.y, r0.y
mad_pp r0.z, -r0.x, r0.x, -r0
mov r0.w, c5.x
add_pp r0.z, r0, c8.x
add r0.w, c8.x, -r0
rsq_pp r0.z, r0.z
mov_pp r2.xyz, v2
mad r0.w, r0, r1, c5.x
mad_pp r2.xyz, r2.w, v1, r2
dp3_pp r1.w, r2, r2
rsq_pp r1.w, r1.w
rcp_pp r0.z, r0.z
mul r0.z, r0, r0.w
dp3 r2.w, r0, v2
mul_pp r2.xyz, r1.w, r2
dp3 r0.x, r0, r2
max r2.w, r2, c8.z
mov_pp r0.y, c3.x
mul r1.w, r0, r2
max r2.x, r0, c8.z
mul_pp r2.y, c8.w, r0
pow r0, r2.x, r2.y
mad r1.xy, r1.z, r1, v0
texld r2, r1, s1
mov r0.w, r0.x
mul_pp r1.xyz, r2, c2
mul_pp r0.xyz, r1, c0
mul_pp r0.xyz, r0, r1.w
mul r1.w, r0, r2
mov_pp r1.xyz, c0
texld r0.w, v3, s3
mul_pp r1.xyz, c1, r1
mul_pp r0.w, r0, c7.z
mad r0.xyz, r1, r1.w, r0
mul oC0.xyz, r0, r0.w
mov_pp oC0.w, c8.z
"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_LightShadowData]
Vector 3 [_Color]
Float 4 [_Shininess]
Float 5 [_Parallax]
Float 6 [_ShadingStrength]
Float 7 [_ShadeRange]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_LightTexture0] 2D
SetTexture 4 [_LightTextureB0] 2D
SetTexture 5 [_ShadowMapTexture] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 128 ALU, 13 TEX
PARAM c[10] = { program.local[0..7],
		{ 0, 0.5, 0.41999999, 2 },
		{ 1, 0.14285715, 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MOV R0.x, c[5];
DP3 R0.y, fragment.texcoord[2], fragment.texcoord[2];
ADD R0.w, R0.x, c[7].x;
RSQ R0.y, R0.y;
MUL R0.xyz, R0.y, fragment.texcoord[2];
MUL R1.xyz, -R0, R0.w;
MAD R3.xy, -R1, c[9].y, fragment.texcoord[0].zwzw;
MAD R2.zw, -R1.xyxy, c[9].y, R3.xyxy;
MAD R2.xy, -R1, c[9].y, R2.zwzw;
TEX R3.w, R3, texture[0], 2D;
TEX R0.w, fragment.texcoord[0].zwzw, texture[0], 2D;
TEX R1.w, R2, texture[0], 2D;
TEX R2.w, R2.zwzw, texture[0], 2D;
ADD R3.x, -R0.w, R3.w;
ADD R2.z, R1, R2.w;
ADD R3.x, -R3, c[9];
ADD R3.y, R1.z, R3.w;
SLT R3.y, R0.w, R3;
SLT R3.z, R3.x, c[9].x;
MUL R3.z, R3.y, R3;
ADD R3.y, -R0.w, R2.w;
CMP R2.w, -R3.z, R3.x, c[9].x;
ADD R3.x, -R3.y, c[9];
SLT R3.y, R3.x, R2.w;
SLT R2.z, R0.w, R2;
MUL R3.y, R2.z, R3;
CMP R2.w, -R3.y, R3.x, R2;
ADD R2.z, -R0.w, R1.w;
ADD R2.z, -R2, c[9].x;
ADD R3.y, R1.z, R1.w;
MAD R2.xy, -R1, c[9].y, R2;
TEX R1.w, R2, texture[0], 2D;
SLT R3.x, R2.z, R2.w;
SLT R3.y, R0.w, R3;
MUL R3.y, R3, R3.x;
CMP R2.w, -R3.y, R2.z, R2;
ADD R3.x, -R0.w, R1.w;
ADD R2.z, -R3.x, c[9].x;
ADD R3.y, R1.z, R1.w;
MAD R2.xy, -R1, c[9].y, R2;
TEX R1.w, R2, texture[0], 2D;
MAD R2.xy, -R1, c[9].y, R2;
MAD R1.xy, -R1, c[9].y, R2;
SLT R3.x, R2.z, R2.w;
SLT R3.y, R0.w, R3;
MUL R3.y, R3, R3.x;
CMP R2.w, -R3.y, R2.z, R2;
ADD R3.x, -R0.w, R1.w;
ADD R3.y, R1.z, R1.w;
ADD R2.z, -R3.x, c[9].x;
SLT R3.x, R2.z, R2.w;
SLT R3.y, R0.w, R3;
MUL R3.y, R3, R3.x;
TEX R1.w, R2, texture[0], 2D;
ADD R3.x, -R0.w, R1.w;
CMP R2.w, -R3.y, R2.z, R2;
ADD R2.z, -R3.x, c[9].x;
ADD R1.w, R1.z, R1;
SLT R3.x, R2.z, R2.w;
SLT R1.w, R0, R1;
MUL R2.x, R1.w, R3;
TEX R1.w, R1, texture[0], 2D;
ADD R1.y, -R0.w, R1.w;
DP3 R1.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R3.z, R1.x;
CMP R4.x, -R2, R2.z, R2.w;
ADD R3.w, -R1.y, c[9].x;
MUL R2.xyz, R3.z, fragment.texcoord[1];
ADD R4.w, R1, R1.z;
ADD R1.y, R2.z, c[8].z;
RCP R1.y, R1.y;
MOV R1.x, c[5];
MUL R1.x, R1, c[8].y;
MUL R3.xy, R2, R1.y;
MAD R4.z, R0.w, c[5].x, -R1.x;
MAD R1.xy, R4.z, R3, fragment.texcoord[0].zwzw;
MOV R1.zw, c[9].xyxz;
TEX R2.yw, R1, texture[2], 2D;
MAD R1.xy, R2.wyzw, c[8].w, -R1.z;
SLT R1.z, R0.w, R4.w;
MUL R0.w, R1.y, R1.y;
SLT R4.y, R3.w, R4.x;
MUL R1.z, R1, R4.y;
MAD R0.w, -R1.x, R1.x, -R0;
CMP R2.y, -R1.z, R3.w, R4.x;
ADD R1.z, R0.w, c[9].x;
MOV R0.w, c[9].x;
ADD R2.x, R0.w, -c[6];
MAD R2.w, R2.x, R2.y, c[6].x;
MAD R2.xyz, R3.z, fragment.texcoord[1], R0;
RSQ R1.z, R1.z;
RCP R1.z, R1.z;
MUL R1.z, R1, R2.w;
DP3 R3.z, R2, R2;
DP3 R0.y, R1, R0;
RSQ R0.x, R3.z;
MAX R3.z, R0.y, c[8].x;
MUL R0.xyz, R0.x, R2;
DP3 R0.x, R1, R0;
MAX R1.x, R0, c[8];
MUL R1.y, R1.w, c[4].x;
POW R1.w, R1.x, R1.y;
MUL R3.z, R2.w, R3;
MAD R2.xy, R4.z, R3, fragment.texcoord[0];
TEX R2, R2, texture[1], 2D;
MUL R0.xyz, R2, c[3];
MUL R0.xyz, R0, c[0];
MUL R1.xyz, R0, R3.z;
MUL R0.y, R1.w, R2.w;
TXP R0.x, fragment.texcoord[4], texture[5], 2D;
RCP R0.z, fragment.texcoord[4].w;
MAD R0.z, -fragment.texcoord[4], R0, R0.x;
CMP R2.x, R0.z, c[2], R0.w;
RCP R0.x, fragment.texcoord[3].w;
MAD R0.zw, fragment.texcoord[3].xyxy, R0.x, c[8].y;
DP3 R0.x, fragment.texcoord[3], fragment.texcoord[3];
TEX R1.w, R0.x, texture[4], 2D;
TEX R0.w, R0.zwzw, texture[3], 2D;
SLT R0.x, c[8], fragment.texcoord[3].z;
MUL R0.x, R0, R0.w;
MUL R0.x, R0, R1.w;
MUL R0.x, R0, R2;
MOV R2.xyz, c[1];
MUL R0.w, R0.x, c[8];
MUL R2.xyz, R2, c[0];
MAD R0.xyz, R2, R0.y, R1;
MUL result.color.xyz, R0, R0.w;
MOV result.color.w, c[8].x;
END
# 128 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_LightShadowData]
Vector 3 [_Color]
Float 4 [_Shininess]
Float 5 [_Parallax]
Float 6 [_ShadingStrength]
Float 7 [_ShadeRange]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_LightTexture0] 2D
SetTexture 4 [_LightTextureB0] 2D
SetTexture 5 [_ShadowMapTexture] 2D
"ps_3_0
; 131 ALU, 13 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
def c8, 0.50000000, 0.41999999, 2.00000000, -1.00000000
def c9, 1.00000000, 0.14285715, 0.00000000, 128.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3
dcl_texcoord4 v4
mov r0.y, c7.x
dp3_pp r0.x, v2, v2
add r0.w, c5.x, r0.y
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, v2
mul r1.xyz, -r0, r0.w
mad r3.xy, -r1, c9.y, v0.zwzw
mad r4.xy, -r1, c9.y, r3
mad r2.xy, -r1, c9.y, r4
texld r3.w, r4, s0
texld r2.w, r3, s0
texld r0.w, v0.zwzw, s0
texld r1.w, r2, s0
add r2.z, r1, r3.w
add r3.x, -r0.w, r3.w
add r3.y, r1.z, r2.w
add r2.z, r0.w, -r2
add r3.z, -r0.w, r1.w
add r3.w, -r0, r2
add r3.y, r0.w, -r3
cmp r2.w, r3.y, c9.z, c9.x
cmp r3.y, -r3.w, c9.z, c9.x
mul_pp r2.w, r2, r3.y
add r3.w, -r3, c9.x
cmp r2.w, -r2, c9.x, r3
add r3.x, -r3, c9
add r3.y, -r2.w, r3.x
mad r2.xy, -r1, c9.y, r2
cmp r2.z, r2, c9, c9.x
cmp r3.y, r3, c9.z, c9.x
mul_pp r3.y, r2.z, r3
cmp r3.x, -r3.y, r2.w, r3
add r2.z, -r3, c9.x
add r3.y, r1.z, r1.w
texld r1.w, r2, s0
add r3.z, r0.w, -r3.y
add r2.w, -r3.x, r2.z
add r3.y, -r0.w, r1.w
mad r2.xy, -r1, c9.y, r2
cmp r2.w, r2, c9.z, c9.x
cmp r3.z, r3, c9, c9.x
mul_pp r3.z, r3, r2.w
add r2.w, -r3.y, c9.x
cmp r3.x, -r3.z, r3, r2.z
add r3.y, r1.z, r1.w
texld r1.w, r2, s0
add r3.z, r0.w, -r3.y
mad r2.xy, -r1, c9.y, r2
add r2.z, -r3.x, r2.w
mad r1.xy, -r1, c9.y, r2
add r3.y, -r0.w, r1.w
cmp r2.z, r2, c9, c9.x
cmp r3.z, r3, c9, c9.x
mul_pp r3.z, r3, r2
add r2.z, -r3.y, c9.x
cmp r2.w, -r3.z, r3.x, r2
add r3.y, r1.z, r1.w
add r3.x, -r2.w, r2.z
add r3.z, r0.w, -r3.y
texld r1.w, r2, s0
add r3.y, -r0.w, r1.w
cmp r3.x, r3, c9.z, c9
cmp r3.z, r3, c9, c9.x
mul_pp r3.z, r3, r3.x
cmp r2.z, -r3, r2.w, r2
add r3.x, -r3.y, c9
add r2.w, r1.z, r1
add r3.y, -r2.z, r3.x
add r2.w, r0, -r2
cmp r1.w, r3.y, c9.z, c9.x
cmp r2.x, r2.w, c9.z, c9
mul_pp r2.x, r2, r1.w
texld r1.w, r1, s0
add r1.y, -r0.w, r1.w
add r1.z, r1.w, r1
cmp r3.z, -r2.x, r2, r3.x
dp3_pp r1.x, v1, v1
rsq_pp r3.x, r1.x
add r4.x, -r1.y, c9
mul_pp r2.xyz, r3.x, v1
add r1.x, -r3.z, r4
cmp r4.y, r1.x, c9.z, c9.x
add r1.y, r2.z, c8
mov_pp r1.x, c8
mul_pp r2.z, c5.x, r1.x
mad_pp r2.w, r0, c5.x, -r2.z
add r0.w, r0, -r1.z
cmp r1.z, r0.w, c9, c9.x
mul_pp r1.z, r1, r4.y
rcp r1.y, r1.y
mul r1.xy, r2, r1.y
mad r2.xy, r2.w, r1, v0.zwzw
texld r3.yw, r2, s2
mad_pp r2.xy, r3.wyzw, c8.z, c8.w
cmp r2.z, -r1, r3, r4.x
mul_pp r0.w, r2.y, r2.y
mad_pp r0.w, -r2.x, r2.x, -r0
add_pp r0.w, r0, c9.x
rsq_pp r1.z, r0.w
mov r1.w, c6.x
add r0.w, c9.x, -r1
mad r0.w, r0, r2.z, c6.x
rcp_pp r1.z, r1.z
mul r2.z, r1, r0.w
mad_pp r3.xyz, r3.x, v1, r0
dp3 r0.y, r2, r0
dp3_pp r1.z, r3, r3
rsq_pp r0.x, r1.z
max r1.z, r0.y, c9
mul_pp r0.xyz, r0.x, r3
dp3 r0.x, r2, r0
mov_pp r0.y, c4.x
max r1.w, r0.x, c9.z
mul_pp r2.x, c9.w, r0.y
mul r1.z, r0.w, r1
pow r0, r1.w, r2.x
mad r1.xy, r2.w, r1, v0
texld r2, r1, s1
mul r0.y, r0.x, r2.w
mul_pp r2.xyz, r2, c3
mul_pp r2.xyz, r2, c0
mul_pp r1.xyz, r2, r1.z
texldp r0.x, v4, s5
rcp r0.z, v4.w
mad r0.z, -v4, r0, r0.x
mov r0.w, c2.x
cmp r1.w, r0.z, c9.x, r0
rcp r0.x, v3.w
mad r2.xy, v3, r0.x, c8.x
texld r0.w, r2, s3
dp3 r0.x, v3, v3
cmp r0.z, -v3, c9, c9.x
mov_pp r2.xyz, c0
mul_pp r0.z, r0, r0.w
texld r0.x, r0.x, s4
mul_pp r0.x, r0.z, r0
mul_pp r0.x, r0, r1.w
mul_pp r0.w, r0.x, c8.z
mul_pp r2.xyz, c1, r2
mad r0.xyz, r2, r0.y, r1
mul oC0.xyz, r0, r0.w
mov_pp oC0.w, c9.z
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_LightShadowData]
Vector 3 [_Color]
Float 4 [_Shininess]
Float 5 [_Parallax]
Float 6 [_ShadingStrength]
Float 7 [_ShadeRange]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_LightTexture0] 2D
SetTexture 4 [_LightTextureB0] 2D
SetTexture 5 [_ShadowMapTexture] 2D
"ps_3_0
; 130 ALU, 13 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
def c8, 0.50000000, 0.41999999, 2.00000000, -1.00000000
def c9, 1.00000000, 0.14285715, 0.00000000, 128.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3
dcl_texcoord4 v4
mov r0.y, c7.x
dp3_pp r0.x, v2, v2
add r0.w, c5.x, r0.y
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, v2
mul r1.xyz, -r0, r0.w
mad r3.xy, -r1, c9.y, v0.zwzw
mad r4.xy, -r1, c9.y, r3
mad r2.xy, -r1, c9.y, r4
texld r3.w, r4, s0
texld r2.w, r3, s0
texld r0.w, v0.zwzw, s0
texld r1.w, r2, s0
add r2.z, r1, r3.w
add r3.x, -r0.w, r3.w
add r3.y, r1.z, r2.w
add r2.z, r0.w, -r2
add r3.z, -r0.w, r1.w
add r3.w, -r0, r2
add r3.y, r0.w, -r3
cmp r2.w, r3.y, c9.z, c9.x
cmp r3.y, -r3.w, c9.z, c9.x
mul_pp r2.w, r2, r3.y
add r3.w, -r3, c9.x
cmp r2.w, -r2, c9.x, r3
add r3.x, -r3, c9
add r3.y, -r2.w, r3.x
mad r2.xy, -r1, c9.y, r2
cmp r2.z, r2, c9, c9.x
cmp r3.y, r3, c9.z, c9.x
mul_pp r3.y, r2.z, r3
cmp r3.x, -r3.y, r2.w, r3
add r2.z, -r3, c9.x
add r3.y, r1.z, r1.w
texld r1.w, r2, s0
add r3.z, r0.w, -r3.y
add r2.w, -r3.x, r2.z
add r3.y, -r0.w, r1.w
mad r2.xy, -r1, c9.y, r2
cmp r2.w, r2, c9.z, c9.x
cmp r3.z, r3, c9, c9.x
mul_pp r3.z, r3, r2.w
add r2.w, -r3.y, c9.x
cmp r3.x, -r3.z, r3, r2.z
add r3.y, r1.z, r1.w
texld r1.w, r2, s0
add r3.z, r0.w, -r3.y
mad r2.xy, -r1, c9.y, r2
add r2.z, -r3.x, r2.w
mad r1.xy, -r1, c9.y, r2
add r3.y, -r0.w, r1.w
cmp r2.z, r2, c9, c9.x
cmp r3.z, r3, c9, c9.x
mul_pp r3.z, r3, r2
add r2.z, -r3.y, c9.x
cmp r2.w, -r3.z, r3.x, r2
add r3.y, r1.z, r1.w
add r3.x, -r2.w, r2.z
add r3.z, r0.w, -r3.y
texld r1.w, r2, s0
add r3.y, -r0.w, r1.w
cmp r3.x, r3, c9.z, c9
cmp r3.z, r3, c9, c9.x
mul_pp r3.z, r3, r3.x
cmp r2.z, -r3, r2.w, r2
add r3.x, -r3.y, c9
add r2.w, r1.z, r1
add r3.y, -r2.z, r3.x
add r2.w, r0, -r2
cmp r1.w, r3.y, c9.z, c9.x
cmp r2.x, r2.w, c9.z, c9
mul_pp r2.x, r2, r1.w
texld r1.w, r1, s0
add r1.y, -r0.w, r1.w
add r1.z, r1.w, r1
cmp r3.z, -r2.x, r2, r3.x
dp3_pp r1.x, v1, v1
rsq_pp r3.x, r1.x
add r4.x, -r1.y, c9
mul_pp r2.xyz, r3.x, v1
add r1.x, -r3.z, r4
cmp r4.y, r1.x, c9.z, c9.x
add r1.y, r2.z, c8
mov_pp r1.x, c8
mul_pp r2.z, c5.x, r1.x
mad_pp r2.w, r0, c5.x, -r2.z
add r0.w, r0, -r1.z
cmp r1.z, r0.w, c9, c9.x
mul_pp r1.z, r1, r4.y
rcp r1.y, r1.y
mul r1.xy, r2, r1.y
mad r2.xy, r2.w, r1, v0.zwzw
texld r3.yw, r2, s2
mad_pp r2.xy, r3.wyzw, c8.z, c8.w
cmp r2.z, -r1, r3, r4.x
mul_pp r0.w, r2.y, r2.y
mad_pp r0.w, -r2.x, r2.x, -r0
add_pp r0.w, r0, c9.x
rsq_pp r1.z, r0.w
mov r1.w, c6.x
add r0.w, c9.x, -r1
mad r0.w, r0, r2.z, c6.x
rcp_pp r1.z, r1.z
mul r2.z, r1, r0.w
mad_pp r3.xyz, r3.x, v1, r0
dp3 r0.y, r2, r0
dp3_pp r1.z, r3, r3
rsq_pp r0.x, r1.z
max r1.z, r0.y, c9
mul_pp r0.xyz, r0.x, r3
dp3 r0.x, r2, r0
mov_pp r0.y, c4.x
max r1.w, r0.x, c9.z
mul_pp r2.x, c9.w, r0.y
mul r1.z, r0.w, r1
pow r0, r1.w, r2.x
mad r1.xy, r2.w, r1, v0
texld r2, r1, s1
mul r0.y, r0.x, r2.w
mov r0.x, c2
add r0.w, c9.x, -r0.x
texldp r0.x, v4, s5
mad r1.w, r0.x, r0, c2.x
mul_pp r2.xyz, r2, c3
mul_pp r2.xyz, r2, c0
dp3 r0.x, v3, v3
mul_pp r1.xyz, r2, r1.z
rcp r0.z, v3.w
mad r2.xy, v3, r0.z, c8.x
texld r0.w, r2, s3
cmp r0.z, -v3, c9, c9.x
mov_pp r2.xyz, c0
mul_pp r0.z, r0, r0.w
texld r0.x, r0.x, s4
mul_pp r0.x, r0.z, r0
mul_pp r0.x, r0, r1.w
mul_pp r0.w, r0.x, c8.z
mul_pp r2.xyz, c1, r2
mad r0.xyz, r2, r0.y, r1
mul oC0.xyz, r0, r0.w
mov_pp oC0.w, c9.z
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_Parallax]
Float 5 [_ShadingStrength]
Float 6 [_ShadeRange]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_ShadowMapTexture] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 114 ALU, 11 TEX
PARAM c[9] = { program.local[0..6],
		{ 0, 0.5, 0.41999999, 2 },
		{ 1, 0.14285715, 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.x, c[4];
ADD R0.x, R0, c[6];
MUL R0.xyz, -fragment.texcoord[2], R0.x;
MAD R2.xy, -R0, c[8].y, fragment.texcoord[0].zwzw;
MAD R2.zw, -R0.xyxy, c[8].y, R2.xyxy;
MAD R1.xy, -R0, c[8].y, R2.zwzw;
TEX R2.w, R2.zwzw, texture[0], 2D;
TEX R1.w, R1, texture[0], 2D;
TEX R0.w, fragment.texcoord[0].zwzw, texture[0], 2D;
TEX R3.w, R2, texture[0], 2D;
ADD R2.x, -R0.w, R3.w;
ADD R2.y, -R2.x, c[8].x;
ADD R1.z, R0, R2.w;
ADD R2.x, R0.z, R3.w;
SLT R2.x, R0.w, R2;
SLT R2.z, R2.y, c[8].x;
MUL R2.z, R2.x, R2;
CMP R2.z, -R2, R2.y, c[8].x;
ADD R2.x, -R0.w, R2.w;
ADD R2.y, -R2.x, c[8].x;
SLT R2.x, R2.y, R2.z;
SLT R1.z, R0.w, R1;
MUL R1.z, R1, R2.x;
CMP R1.z, -R1, R2.y, R2;
ADD R2.x, -R0.w, R1.w;
ADD R2.x, -R2, c[8];
ADD R2.y, R0.z, R1.w;
MAD R1.xy, -R0, c[8].y, R1;
TEX R1.w, R1, texture[0], 2D;
SLT R2.z, R2.x, R1;
SLT R2.y, R0.w, R2;
MUL R2.z, R2.y, R2;
ADD R2.y, -R0.w, R1.w;
CMP R1.z, -R2, R2.x, R1;
ADD R2.x, -R2.y, c[8];
ADD R2.y, R0.z, R1.w;
MAD R1.xy, -R0, c[8].y, R1;
TEX R1.w, R1, texture[0], 2D;
MAD R1.xy, -R0, c[8].y, R1;
MAD R0.xy, -R0, c[8].y, R1;
SLT R2.z, R2.x, R1;
SLT R2.y, R0.w, R2;
MUL R2.z, R2.y, R2;
ADD R2.y, -R0.w, R1.w;
CMP R1.z, -R2, R2.x, R1;
ADD R2.x, -R2.y, c[8];
ADD R2.y, R0.z, R1.w;
TEX R1.w, R1, texture[0], 2D;
ADD R1.x, R0.z, R1.w;
SLT R2.z, R2.x, R1;
SLT R2.y, R0.w, R2;
MUL R2.z, R2.y, R2;
ADD R2.y, -R0.w, R1.w;
CMP R1.z, -R2, R2.x, R1;
TEX R1.w, R0, texture[0], 2D;
ADD R2.x, -R2.y, c[8];
SLT R0.x, R0.w, R1;
SLT R2.y, R2.x, R1.z;
MUL R0.y, R0.x, R2;
ADD R1.x, R1.w, R0.z;
CMP R2.z, -R0.y, R2.x, R1;
ADD R0.x, -R0.w, R1.w;
ADD R2.x, -R0, c[8];
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R1.z, R0.x;
SLT R3.x, R2, R2.z;
MUL R0.xyz, R1.z, fragment.texcoord[1];
SLT R3.y, R0.w, R1.x;
ADD R1.x, R0.z, c[7].z;
RCP R1.x, R1.x;
MOV R0.z, c[4].x;
MUL R0.z, R0, c[7].y;
MAD R1.w, R0, c[4].x, -R0.z;
MUL R0.xy, R0, R1.x;
MAD R1.xy, R1.w, R0, fragment.texcoord[0].zwzw;
MOV R0.zw, c[8].xyxz;
TEX R2.yw, R1, texture[2], 2D;
MAD R1.xy, R2.wyzw, c[7].w, -R0.z;
MUL R2.y, R3, R3.x;
CMP R2.y, -R2, R2.x, R2.z;
MUL R0.z, R1.y, R1.y;
MAD R2.x, -R1, R1, -R0.z;
ADD R2.x, R2, c[8];
RSQ R2.w, R2.x;
MOV R0.z, c[8].x;
ADD R0.z, R0, -c[5].x;
MAD R0.z, R0, R2.y, c[5].x;
MOV R2.xyz, fragment.texcoord[2];
MAD R2.xyz, R1.z, fragment.texcoord[1], R2;
RCP R2.w, R2.w;
MUL R1.z, R2.w, R0;
DP3 R3.x, R1, fragment.texcoord[2];
DP3 R2.w, R2, R2;
RSQ R2.w, R2.w;
MUL R2.xyz, R2.w, R2;
DP3 R1.x, R1, R2;
MAD R1.zw, R1.w, R0.xyxy, fragment.texcoord[0].xyxy;
MAX R0.x, R1, c[7];
TEX R1, R1.zwzw, texture[1], 2D;
MUL R0.y, R0.w, c[3].x;
POW R0.x, R0.x, R0.y;
MUL R0.y, R0.x, R1.w;
TXP R0.x, fragment.texcoord[3], texture[3], 2D;
MAX R3.x, R3, c[7];
MUL R1.xyz, R1, c[2];
MOV R2.xyz, c[1];
MUL R0.z, R0, R3.x;
MUL R1.xyz, R1, c[0];
MUL R0.w, R0.x, c[7];
MUL R1.xyz, R1, R0.z;
MUL R2.xyz, R2, c[0];
MAD R0.xyz, R2, R0.y, R1;
MUL result.color.xyz, R0, R0.w;
MOV result.color.w, c[7].x;
END
# 114 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_Parallax]
Float 5 [_ShadingStrength]
Float 6 [_ShadeRange]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_ShadowMapTexture] 2D
"ps_3_0
; 118 ALU, 11 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c7, 0.50000000, 0.41999999, 2.00000000, -1.00000000
def c8, 1.00000000, 0.14285715, 0.00000000, 128.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3
mov r0.x, c6
add r0.x, c4, r0
mul r0.xyz, -v2, r0.x
mad r2.xy, -r0, c8.y, v0.zwzw
mad r3.xy, -r0, c8.y, r2
mad r1.xy, -r0, c8.y, r3
texld r1.w, r1, s0
texld r0.w, v0.zwzw, s0
texld r2.w, r2, s0
texld r3.w, r3, s0
add r2.x, r0.z, r2.w
add r2.w, -r0, r2
cmp r3.x, -r2.w, c8.z, c8
add r2.y, -r0.w, r3.w
add r2.x, r0.w, -r2
cmp r2.x, r2, c8.z, c8
add r1.z, -r0.w, r1.w
mul_pp r2.x, r2, r3
add r2.w, -r2, c8.x
cmp r2.w, -r2.x, c8.x, r2
add r2.z, r0, r3.w
add r2.x, r0.w, -r2.z
add r2.y, -r2, c8.x
add r3.x, -r2.w, r2.y
mad r1.xy, -r0, c8.y, r1
cmp r2.x, r2, c8.z, c8
cmp r2.z, r3.x, c8, c8.x
mul_pp r2.z, r2.x, r2
cmp r2.y, -r2.z, r2.w, r2
add r2.z, r0, r1.w
texld r1.w, r1, s0
add r2.x, -r1.z, c8
add r1.z, -r2.y, r2.x
add r2.z, r0.w, -r2
add r2.w, -r0, r1
mad r1.xy, -r0, c8.y, r1
cmp r1.z, r1, c8, c8.x
cmp r2.z, r2, c8, c8.x
mul_pp r2.z, r2, r1
cmp r2.y, -r2.z, r2, r2.x
add r2.z, r0, r1.w
add r1.z, -r2.w, c8.x
texld r1.w, r1, s0
mad r1.xy, -r0, c8.y, r1
add r2.x, -r2.y, r1.z
add r2.z, r0.w, -r2
mad r0.xy, -r0, c8.y, r1
add r2.w, -r0, r1
cmp r2.x, r2, c8.z, c8
cmp r2.z, r2, c8, c8.x
mul_pp r2.z, r2, r2.x
cmp r2.y, -r2.z, r2, r1.z
add r2.z, r0, r1.w
add r2.x, -r2.w, c8
texld r1.w, r1, s0
add r2.w, -r0, r1
add r1.z, -r2.y, r2.x
add r1.w, r0.z, r1
add r1.x, r0.w, -r1.w
texld r1.w, r0, s0
add r2.z, r0.w, -r2
add r0.z, r1.w, r0
add r0.z, r0.w, -r0
add r0.y, -r0.w, r1.w
cmp r1.z, r1, c8, c8.x
cmp r2.z, r2, c8, c8.x
mul_pp r2.z, r2, r1
cmp r2.x, -r2.z, r2.y, r2
add r1.z, -r2.w, c8.x
add r2.y, -r2.x, r1.z
cmp r2.y, r2, c8.z, c8.x
cmp r0.x, r1, c8.z, c8
mul_pp r0.x, r0, r2.y
cmp r2.y, -r0.x, r2.x, r1.z
add r2.x, -r0.y, c8
add r0.y, -r2, r2.x
dp3_pp r0.x, v1, v1
rsq_pp r2.w, r0.x
mov_pp r0.x, c7
mul_pp r1.xyz, r2.w, v1
cmp r2.z, r0.y, c8, c8.x
add r0.y, r1.z, c7
rcp r0.y, r0.y
mul_pp r0.x, c4, r0
mad_pp r1.z, r0.w, c4.x, -r0.x
mul r1.xy, r1, r0.y
mad r0.xy, r1.z, r1, v0.zwzw
texld r0.yw, r0, s2
mad_pp r0.xy, r0.wyzw, c7.z, c7.w
cmp r0.z, r0, c8, c8.x
mul_pp r0.w, r0.z, r2.z
cmp r1.w, -r0, r2.y, r2.x
mul_pp r0.z, r0.y, r0.y
mad_pp r0.z, -r0.x, r0.x, -r0
mov r0.w, c5.x
add_pp r0.z, r0, c8.x
add r0.w, c8.x, -r0
rsq_pp r0.z, r0.z
mov_pp r2.xyz, v2
mad r0.w, r0, r1, c5.x
mad_pp r2.xyz, r2.w, v1, r2
dp3_pp r1.w, r2, r2
rsq_pp r1.w, r1.w
rcp_pp r0.z, r0.z
mul r0.z, r0, r0.w
dp3 r2.w, r0, v2
mul_pp r2.xyz, r1.w, r2
dp3 r0.x, r0, r2
max r2.w, r2, c8.z
mov_pp r0.y, c3.x
mul r1.w, r0, r2
max r2.x, r0, c8.z
mul_pp r2.y, c8.w, r0
pow r0, r2.x, r2.y
mad r1.xy, r1.z, r1, v0
texld r2, r1, s1
mul_pp r1.xyz, r2, c2
mul r0.y, r0.x, r2.w
texldp r0.x, v3, s3
mul_pp r1.xyz, r1, c0
mov_pp r2.xyz, c0
mul_pp r0.w, r0.x, c7.z
mul_pp r1.xyz, r1, r1.w
mul_pp r2.xyz, c1, r2
mad r0.xyz, r2, r0.y, r1
mul oC0.xyz, r0, r0.w
mov_pp oC0.w, c8.z
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_Parallax]
Float 5 [_ShadingStrength]
Float 6 [_ShadeRange]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_ShadowMapTexture] 2D
SetTexture 4 [_LightTexture0] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 116 ALU, 12 TEX
PARAM c[9] = { program.local[0..6],
		{ 0, 0.5, 0.41999999, 2 },
		{ 1, 0.14285715, 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.x, c[4];
ADD R0.x, R0, c[6];
MUL R0.xyz, -fragment.texcoord[2], R0.x;
MAD R2.xy, -R0, c[8].y, fragment.texcoord[0].zwzw;
MAD R2.zw, -R0.xyxy, c[8].y, R2.xyxy;
MAD R1.xy, -R0, c[8].y, R2.zwzw;
TEX R2.w, R2.zwzw, texture[0], 2D;
TEX R1.w, R1, texture[0], 2D;
TEX R0.w, fragment.texcoord[0].zwzw, texture[0], 2D;
TEX R3.w, R2, texture[0], 2D;
ADD R2.x, -R0.w, R3.w;
ADD R2.y, -R2.x, c[8].x;
ADD R1.z, R0, R2.w;
ADD R2.x, R0.z, R3.w;
SLT R2.x, R0.w, R2;
SLT R2.z, R2.y, c[8].x;
MUL R2.z, R2.x, R2;
CMP R2.z, -R2, R2.y, c[8].x;
ADD R2.x, -R0.w, R2.w;
ADD R2.y, -R2.x, c[8].x;
SLT R2.x, R2.y, R2.z;
SLT R1.z, R0.w, R1;
MUL R1.z, R1, R2.x;
CMP R1.z, -R1, R2.y, R2;
ADD R2.x, -R0.w, R1.w;
ADD R2.x, -R2, c[8];
ADD R2.y, R0.z, R1.w;
MAD R1.xy, -R0, c[8].y, R1;
TEX R1.w, R1, texture[0], 2D;
SLT R2.z, R2.x, R1;
SLT R2.y, R0.w, R2;
MUL R2.z, R2.y, R2;
ADD R2.y, -R0.w, R1.w;
CMP R1.z, -R2, R2.x, R1;
ADD R2.x, -R2.y, c[8];
ADD R2.y, R0.z, R1.w;
MAD R1.xy, -R0, c[8].y, R1;
TEX R1.w, R1, texture[0], 2D;
MAD R1.xy, -R0, c[8].y, R1;
MAD R0.xy, -R0, c[8].y, R1;
SLT R2.z, R2.x, R1;
SLT R2.y, R0.w, R2;
MUL R2.z, R2.y, R2;
ADD R2.y, -R0.w, R1.w;
CMP R1.z, -R2, R2.x, R1;
ADD R2.x, -R2.y, c[8];
ADD R2.y, R0.z, R1.w;
TEX R1.w, R1, texture[0], 2D;
ADD R1.x, R0.z, R1.w;
SLT R2.z, R2.x, R1;
SLT R2.y, R0.w, R2;
MUL R2.z, R2.y, R2;
ADD R2.y, -R0.w, R1.w;
CMP R1.z, -R2, R2.x, R1;
TEX R1.w, R0, texture[0], 2D;
ADD R2.x, -R2.y, c[8];
SLT R0.x, R0.w, R1;
SLT R2.y, R2.x, R1.z;
MUL R0.y, R0.x, R2;
ADD R1.x, R1.w, R0.z;
CMP R2.z, -R0.y, R2.x, R1;
ADD R0.x, -R0.w, R1.w;
ADD R2.x, -R0, c[8];
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R1.z, R0.x;
SLT R3.x, R2, R2.z;
MUL R0.xyz, R1.z, fragment.texcoord[1];
SLT R3.y, R0.w, R1.x;
ADD R1.x, R0.z, c[7].z;
RCP R1.x, R1.x;
MOV R0.z, c[4].x;
MUL R0.z, R0, c[7].y;
MAD R1.w, R0, c[4].x, -R0.z;
MUL R0.xy, R0, R1.x;
MAD R1.xy, R1.w, R0, fragment.texcoord[0].zwzw;
MOV R0.zw, c[8].xyxz;
TEX R2.yw, R1, texture[2], 2D;
MAD R1.xy, R2.wyzw, c[7].w, -R0.z;
MUL R2.y, R3, R3.x;
CMP R2.y, -R2, R2.x, R2.z;
MUL R0.z, R1.y, R1.y;
MAD R2.x, -R1, R1, -R0.z;
ADD R2.x, R2, c[8];
RSQ R2.w, R2.x;
MOV R0.z, c[8].x;
ADD R0.z, R0, -c[5].x;
MAD R0.z, R0, R2.y, c[5].x;
MOV R2.xyz, fragment.texcoord[2];
MAD R2.xyz, R1.z, fragment.texcoord[1], R2;
RCP R2.w, R2.w;
MUL R1.z, R2.w, R0;
DP3 R3.x, R1, fragment.texcoord[2];
DP3 R2.w, R2, R2;
RSQ R2.w, R2.w;
MUL R2.xyz, R2.w, R2;
DP3 R1.x, R1, R2;
MAD R1.zw, R1.w, R0.xyxy, fragment.texcoord[0].xyxy;
MUL R0.y, R0.w, c[3].x;
MAX R0.x, R1, c[7];
TEX R1, R1.zwzw, texture[1], 2D;
POW R0.x, R0.x, R0.y;
MUL R1.w, R0.x, R1;
MAX R3.x, R3, c[7];
MUL R1.xyz, R1, c[2];
MUL R0.z, R0, R3.x;
MUL R1.xyz, R1, c[0];
MUL R1.xyz, R1, R0.z;
TXP R0.x, fragment.texcoord[4], texture[3], 2D;
TEX R0.w, fragment.texcoord[3], texture[4], 2D;
MUL R0.w, R0, R0.x;
MOV R2.xyz, c[1];
MUL R0.xyz, R2, c[0];
MUL R0.w, R0, c[7];
MAD R0.xyz, R0, R1.w, R1;
MUL result.color.xyz, R0, R0.w;
MOV result.color.w, c[7].x;
END
# 116 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_Parallax]
Float 5 [_ShadingStrength]
Float 6 [_ShadeRange]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_ShadowMapTexture] 2D
SetTexture 4 [_LightTexture0] 2D
"ps_3_0
; 119 ALU, 12 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c7, 0.50000000, 0.41999999, 2.00000000, -1.00000000
def c8, 1.00000000, 0.14285715, 0.00000000, 128.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xy
dcl_texcoord4 v4
mov r0.x, c6
add r0.x, c4, r0
mul r0.xyz, -v2, r0.x
mad r2.xy, -r0, c8.y, v0.zwzw
mad r3.xy, -r0, c8.y, r2
mad r1.xy, -r0, c8.y, r3
texld r1.w, r1, s0
texld r0.w, v0.zwzw, s0
texld r2.w, r2, s0
texld r3.w, r3, s0
add r2.x, r0.z, r2.w
add r2.w, -r0, r2
cmp r3.x, -r2.w, c8.z, c8
add r2.y, -r0.w, r3.w
add r2.x, r0.w, -r2
cmp r2.x, r2, c8.z, c8
add r1.z, -r0.w, r1.w
mul_pp r2.x, r2, r3
add r2.w, -r2, c8.x
cmp r2.w, -r2.x, c8.x, r2
add r2.z, r0, r3.w
add r2.x, r0.w, -r2.z
add r2.y, -r2, c8.x
add r3.x, -r2.w, r2.y
mad r1.xy, -r0, c8.y, r1
cmp r2.x, r2, c8.z, c8
cmp r2.z, r3.x, c8, c8.x
mul_pp r2.z, r2.x, r2
cmp r2.y, -r2.z, r2.w, r2
add r2.z, r0, r1.w
texld r1.w, r1, s0
add r2.x, -r1.z, c8
add r1.z, -r2.y, r2.x
add r2.z, r0.w, -r2
add r2.w, -r0, r1
mad r1.xy, -r0, c8.y, r1
cmp r1.z, r1, c8, c8.x
cmp r2.z, r2, c8, c8.x
mul_pp r2.z, r2, r1
cmp r2.y, -r2.z, r2, r2.x
add r2.z, r0, r1.w
add r1.z, -r2.w, c8.x
texld r1.w, r1, s0
mad r1.xy, -r0, c8.y, r1
add r2.x, -r2.y, r1.z
add r2.z, r0.w, -r2
mad r0.xy, -r0, c8.y, r1
add r2.w, -r0, r1
cmp r2.x, r2, c8.z, c8
cmp r2.z, r2, c8, c8.x
mul_pp r2.z, r2, r2.x
cmp r2.y, -r2.z, r2, r1.z
add r2.z, r0, r1.w
add r2.x, -r2.w, c8
texld r1.w, r1, s0
add r2.w, -r0, r1
add r1.z, -r2.y, r2.x
add r1.w, r0.z, r1
add r1.x, r0.w, -r1.w
texld r1.w, r0, s0
add r2.z, r0.w, -r2
add r0.z, r1.w, r0
add r0.z, r0.w, -r0
add r0.y, -r0.w, r1.w
cmp r1.z, r1, c8, c8.x
cmp r2.z, r2, c8, c8.x
mul_pp r2.z, r2, r1
cmp r2.x, -r2.z, r2.y, r2
add r1.z, -r2.w, c8.x
add r2.y, -r2.x, r1.z
cmp r2.y, r2, c8.z, c8.x
cmp r0.x, r1, c8.z, c8
mul_pp r0.x, r0, r2.y
cmp r2.y, -r0.x, r2.x, r1.z
add r2.x, -r0.y, c8
add r0.y, -r2, r2.x
dp3_pp r0.x, v1, v1
rsq_pp r2.w, r0.x
mov_pp r0.x, c7
mul_pp r1.xyz, r2.w, v1
cmp r2.z, r0.y, c8, c8.x
add r0.y, r1.z, c7
rcp r0.y, r0.y
mul_pp r0.x, c4, r0
mad_pp r1.z, r0.w, c4.x, -r0.x
mul r1.xy, r1, r0.y
mad r0.xy, r1.z, r1, v0.zwzw
texld r0.yw, r0, s2
mad_pp r0.xy, r0.wyzw, c7.z, c7.w
cmp r0.z, r0, c8, c8.x
mul_pp r0.w, r0.z, r2.z
cmp r1.w, -r0, r2.y, r2.x
mul_pp r0.z, r0.y, r0.y
mad_pp r0.z, -r0.x, r0.x, -r0
mov r0.w, c5.x
add_pp r0.z, r0, c8.x
add r0.w, c8.x, -r0
rsq_pp r0.z, r0.z
mov_pp r2.xyz, v2
mad r0.w, r0, r1, c5.x
mad_pp r2.xyz, r2.w, v1, r2
dp3_pp r1.w, r2, r2
rsq_pp r1.w, r1.w
rcp_pp r0.z, r0.z
mul r0.z, r0, r0.w
dp3 r2.w, r0, v2
mul_pp r2.xyz, r1.w, r2
dp3 r0.x, r0, r2
max r2.w, r2, c8.z
mov_pp r0.y, c3.x
mul r1.w, r0, r2
max r2.x, r0, c8.z
mul_pp r2.y, c8.w, r0
pow r0, r2.x, r2.y
mad r1.xy, r1.z, r1, v0
texld r2, r1, s1
mul_pp r1.xyz, r2, c2
mul_pp r1.xyz, r1, c0
mul_pp r1.xyz, r1, r1.w
mul r1.w, r0.x, r2
texldp r0.x, v4, s3
texld r0.w, v3, s4
mul r0.w, r0, r0.x
mov_pp r2.xyz, c0
mul_pp r0.xyz, c1, r2
mul_pp r0.w, r0, c7.z
mad r0.xyz, r0, r1.w, r1
mul oC0.xyz, r0, r0.w
mov_pp oC0.w, c8.z
"
}
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_CUBE" }
Vector 0 [_LightPositionRange]
Vector 1 [_LightColor0]
Vector 2 [_SpecColor]
Vector 3 [_LightShadowData]
Vector 4 [_Color]
Float 5 [_Shininess]
Float 6 [_Parallax]
Float 7 [_ShadingStrength]
Float 8 [_ShadeRange]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_ShadowMapTexture] CUBE
SetTexture 4 [_LightTexture0] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 126 ALU, 12 TEX
PARAM c[12] = { program.local[0..8],
		{ 0, 0.5, 0.41999999, 2 },
		{ 1, 0.14285715, 128, 0.97000003 },
		{ 1, 0.0039215689, 1.53787e-005, 6.2273724e-009 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MOV R0.x, c[6];
DP3 R0.y, fragment.texcoord[2], fragment.texcoord[2];
ADD R0.w, R0.x, c[8].x;
RSQ R0.y, R0.y;
MUL R0.xyz, R0.y, fragment.texcoord[2];
MUL R1.xyz, -R0, R0.w;
MAD R3.xy, -R1, c[10].y, fragment.texcoord[0].zwzw;
MAD R2.zw, -R1.xyxy, c[10].y, R3.xyxy;
MAD R2.xy, -R1, c[10].y, R2.zwzw;
TEX R3.w, R3, texture[0], 2D;
TEX R0.w, fragment.texcoord[0].zwzw, texture[0], 2D;
TEX R1.w, R2, texture[0], 2D;
TEX R2.w, R2.zwzw, texture[0], 2D;
ADD R3.x, -R0.w, R3.w;
ADD R2.z, R1, R2.w;
ADD R3.x, -R3, c[10];
ADD R3.y, R1.z, R3.w;
SLT R3.y, R0.w, R3;
SLT R3.z, R3.x, c[10].x;
MUL R3.z, R3.y, R3;
ADD R3.y, -R0.w, R2.w;
CMP R2.w, -R3.z, R3.x, c[10].x;
ADD R3.x, -R3.y, c[10];
SLT R3.y, R3.x, R2.w;
SLT R2.z, R0.w, R2;
MUL R3.y, R2.z, R3;
CMP R2.w, -R3.y, R3.x, R2;
ADD R2.z, -R0.w, R1.w;
ADD R2.z, -R2, c[10].x;
ADD R3.y, R1.z, R1.w;
MAD R2.xy, -R1, c[10].y, R2;
TEX R1.w, R2, texture[0], 2D;
SLT R3.x, R2.z, R2.w;
SLT R3.y, R0.w, R3;
MUL R3.y, R3, R3.x;
CMP R2.w, -R3.y, R2.z, R2;
ADD R3.x, -R0.w, R1.w;
ADD R2.z, -R3.x, c[10].x;
ADD R3.y, R1.z, R1.w;
MAD R2.xy, -R1, c[10].y, R2;
TEX R1.w, R2, texture[0], 2D;
MAD R2.xy, -R1, c[10].y, R2;
MAD R1.xy, -R1, c[10].y, R2;
SLT R3.x, R2.z, R2.w;
SLT R3.y, R0.w, R3;
MUL R3.y, R3, R3.x;
CMP R2.w, -R3.y, R2.z, R2;
ADD R3.x, -R0.w, R1.w;
ADD R3.y, R1.z, R1.w;
ADD R2.z, -R3.x, c[10].x;
SLT R3.x, R2.z, R2.w;
SLT R3.y, R0.w, R3;
MUL R3.y, R3, R3.x;
TEX R1.w, R2, texture[0], 2D;
ADD R3.x, -R0.w, R1.w;
CMP R2.w, -R3.y, R2.z, R2;
ADD R2.z, -R3.x, c[10].x;
ADD R1.w, R1.z, R1;
SLT R3.x, R2.z, R2.w;
SLT R1.w, R0, R1;
MUL R2.x, R1.w, R3;
TEX R1.w, R1, texture[0], 2D;
ADD R1.y, -R0.w, R1.w;
DP3 R1.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R3.w, R1.x;
CMP R4.y, -R2.x, R2.z, R2.w;
ADD R3.z, -R1.y, c[10].x;
MUL R2.xyz, R3.w, fragment.texcoord[1];
ADD R4.w, R1, R1.z;
ADD R1.y, R2.z, c[9].z;
RCP R1.y, R1.y;
MOV R1.x, c[6];
MUL R1.x, R1, c[9].y;
MUL R3.xy, R2, R1.y;
MAD R4.x, R0.w, c[6], -R1;
MAD R1.xy, R4.x, R3, fragment.texcoord[0].zwzw;
MOV R1.zw, c[10].xyxz;
TEX R2.yw, R1, texture[2], 2D;
MAD R1.xy, R2.wyzw, c[9].w, -R1.z;
SLT R1.z, R0.w, R4.w;
SLT R4.z, R3, R4.y;
MUL R0.w, R1.y, R1.y;
MUL R1.z, R1, R4;
MAD R0.w, -R1.x, R1.x, -R0;
CMP R2.x, -R1.z, R3.z, R4.y;
ADD R0.w, R0, c[10].x;
RSQ R1.z, R0.w;
MOV R2.w, c[10].x;
ADD R0.w, R2, -c[7].x;
MAD R0.w, R0, R2.x, c[7].x;
RCP R1.z, R1.z;
MUL R1.z, R1, R0.w;
DP3 R2.x, R1, R0;
MAX R2.x, R2, c[9];
MUL R3.z, R0.w, R2.x;
MAD R2.xyz, R3.w, fragment.texcoord[1], R0;
MAD R0.xy, R4.x, R3, fragment.texcoord[0];
TEX R0, R0, texture[1], 2D;
DP3 R3.x, R2, R2;
RSQ R3.x, R3.x;
MUL R2.xyz, R3.x, R2;
DP3 R1.x, R1, R2;
MUL R0.xyz, R0, c[4];
MUL R0.xyz, R0, c[1];
MUL R1.y, R1.w, c[5].x;
MAX R1.x, R1, c[9];
POW R1.x, R1.x, R1.y;
MUL R2.x, R1, R0.w;
DP3 R1.y, fragment.texcoord[4], fragment.texcoord[4];
RSQ R0.w, R1.y;
TEX R1, fragment.texcoord[4], texture[3], CUBE;
RCP R0.w, R0.w;
DP4 R1.x, R1, c[11];
MUL R0.w, R0, c[0];
MAD R1.x, -R0.w, c[10].w, R1;
DP3 R0.w, fragment.texcoord[3], fragment.texcoord[3];
CMP R1.x, R1, c[3], R2.w;
TEX R0.w, R0.w, texture[4], 2D;
MUL R0.w, R0, R1.x;
MOV R1.xyz, c[2];
MUL R0.xyz, R0, R3.z;
MUL R1.xyz, R1, c[1];
MUL R0.w, R0, c[9];
MAD R0.xyz, R1, R2.x, R0;
MUL result.color.xyz, R0, R0.w;
MOV result.color.w, c[9].x;
END
# 126 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_CUBE" }
Vector 0 [_LightPositionRange]
Vector 1 [_LightColor0]
Vector 2 [_SpecColor]
Vector 3 [_LightShadowData]
Vector 4 [_Color]
Float 5 [_Shininess]
Float 6 [_Parallax]
Float 7 [_ShadingStrength]
Float 8 [_ShadeRange]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_ShadowMapTexture] CUBE
SetTexture 4 [_LightTexture0] 2D
"ps_3_0
; 130 ALU, 12 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_cube s3
dcl_2d s4
def c9, 0.50000000, 0.41999999, 2.00000000, -1.00000000
def c10, 1.00000000, 0.14285715, 0.00000000, 128.00000000
def c11, 1.00000000, 0.00392157, 0.00001538, 0.00000001
def c12, 0.97000003, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
mov r0.y, c8.x
dp3_pp r0.x, v2, v2
add r0.w, c6.x, r0.y
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, v2
mul r1.xyz, -r0, r0.w
mad r3.xy, -r1, c10.y, v0.zwzw
mad r4.xy, -r1, c10.y, r3
mad r2.xy, -r1, c10.y, r4
texld r3.w, r4, s0
texld r2.w, r3, s0
texld r0.w, v0.zwzw, s0
texld r1.w, r2, s0
add r2.z, r1, r3.w
add r3.x, -r0.w, r3.w
add r3.y, r1.z, r2.w
add r2.z, r0.w, -r2
add r3.z, -r0.w, r1.w
add r3.w, -r0, r2
add r3.y, r0.w, -r3
cmp r2.w, r3.y, c10.z, c10.x
cmp r3.y, -r3.w, c10.z, c10.x
mul_pp r2.w, r2, r3.y
add r3.w, -r3, c10.x
cmp r2.w, -r2, c10.x, r3
add r3.x, -r3, c10
add r3.y, -r2.w, r3.x
mad r2.xy, -r1, c10.y, r2
cmp r2.z, r2, c10, c10.x
cmp r3.y, r3, c10.z, c10.x
mul_pp r3.y, r2.z, r3
cmp r3.x, -r3.y, r2.w, r3
add r2.z, -r3, c10.x
add r3.y, r1.z, r1.w
texld r1.w, r2, s0
add r3.z, r0.w, -r3.y
add r2.w, -r3.x, r2.z
add r3.y, -r0.w, r1.w
mad r2.xy, -r1, c10.y, r2
cmp r2.w, r2, c10.z, c10.x
cmp r3.z, r3, c10, c10.x
mul_pp r3.z, r3, r2.w
add r2.w, -r3.y, c10.x
cmp r3.x, -r3.z, r3, r2.z
add r3.y, r1.z, r1.w
texld r1.w, r2, s0
add r3.z, r0.w, -r3.y
mad r2.xy, -r1, c10.y, r2
add r2.z, -r3.x, r2.w
mad r1.xy, -r1, c10.y, r2
add r3.y, -r0.w, r1.w
cmp r2.z, r2, c10, c10.x
cmp r3.z, r3, c10, c10.x
mul_pp r3.z, r3, r2
add r2.z, -r3.y, c10.x
cmp r2.w, -r3.z, r3.x, r2
add r3.y, r1.z, r1.w
add r3.x, -r2.w, r2.z
add r3.z, r0.w, -r3.y
texld r1.w, r2, s0
add r3.y, -r0.w, r1.w
add r1.w, r1.z, r1
add r2.x, r0.w, -r1.w
texld r1.w, r1, s0
add r1.y, -r0.w, r1.w
add r3.w, -r1.y, c10.x
add r1.z, r1.w, r1
cmp r3.x, r3, c10.z, c10
cmp r3.z, r3, c10, c10.x
mul_pp r3.z, r3, r3.x
cmp r2.z, -r3, r2.w, r2
add r3.x, -r3.y, c10
add r2.w, -r2.z, r3.x
cmp r2.w, r2, c10.z, c10.x
cmp r1.x, r2, c10.z, c10
mul_pp r1.x, r1, r2.w
cmp r3.z, -r1.x, r2, r3.x
dp3_pp r1.x, v1, v1
rsq_pp r2.w, r1.x
add r1.y, -r3.z, r3.w
mov_pp r1.x, c9
mul_pp r1.x, c6, r1
mad_pp r4.y, r0.w, c6.x, -r1.x
add r0.w, r0, -r1.z
mul_pp r2.xyz, r2.w, v1
cmp r4.x, r1.y, c10.z, c10
add r1.y, r2.z, c9
rcp r1.y, r1.y
mul r3.xy, r2, r1.y
mad r1.xy, r4.y, r3, v0.zwzw
texld r1.yw, r1, s2
mad_pp r1.xy, r1.wyzw, c9.z, c9.w
cmp r0.w, r0, c10.z, c10.x
mul_pp r1.z, r0.w, r4.x
mul_pp r0.w, r1.y, r1.y
cmp r2.x, -r1.z, r3.z, r3.w
mad_pp r0.w, -r1.x, r1.x, -r0
add_pp r1.z, r0.w, c10.x
mov r1.w, c7.x
add r0.w, c10.x, -r1
mad r0.w, r0, r2.x, c7.x
mad_pp r2.xyz, r2.w, v1, r0
dp3_pp r1.w, r2, r2
rsq_pp r1.z, r1.z
rcp_pp r1.z, r1.z
mul r1.z, r1, r0.w
dp3 r2.w, r1, r0
rsq_pp r1.w, r1.w
mul_pp r0.xyz, r1.w, r2
dp3 r0.x, r1, r0
max r1.w, r2, c10.z
max r2.y, r0.x, c10.z
mov_pp r0.z, c5.x
mul r2.x, r0.w, r1.w
mad r0.xy, r4.y, r3, v0
texld r1, r0, s1
mul_pp r2.z, c10.w, r0
pow r0, r2.y, r2.z
mul_pp r1.xyz, r1, c4
mul_pp r1.xyz, r1, c1
mul_pp r1.xyz, r1, r2.x
dp3 r0.y, v4, v4
rsq r2.x, r0.y
mul r1.w, r0.x, r1
texld r0, v4, s3
dp4 r0.y, r0, c11
rcp r2.x, r2.x
mul r0.x, r2, c0.w
mad r0.y, -r0.x, c12.x, r0
mov r0.z, c3.x
dp3 r0.x, v3, v3
cmp r0.y, r0, c10.x, r0.z
texld r0.x, r0.x, s4
mul r0.w, r0.x, r0.y
mov_pp r0.xyz, c1
mul_pp r0.xyz, c2, r0
mul_pp r0.w, r0, c9.z
mad r0.xyz, r0, r1.w, r1
mul oC0.xyz, r0, r0.w
mov_pp oC0.w, c10.z
"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Vector 0 [_LightPositionRange]
Vector 1 [_LightColor0]
Vector 2 [_SpecColor]
Vector 3 [_LightShadowData]
Vector 4 [_Color]
Float 5 [_Shininess]
Float 6 [_Parallax]
Float 7 [_ShadingStrength]
Float 8 [_ShadeRange]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_ShadowMapTexture] CUBE
SetTexture 4 [_LightTextureB0] 2D
SetTexture 5 [_LightTexture0] CUBE
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 128 ALU, 13 TEX
PARAM c[12] = { program.local[0..8],
		{ 0, 0.5, 0.41999999, 2 },
		{ 1, 0.14285715, 128, 0.97000003 },
		{ 1, 0.0039215689, 1.53787e-005, 6.2273724e-009 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MOV R0.x, c[6];
DP3 R0.y, fragment.texcoord[2], fragment.texcoord[2];
ADD R0.w, R0.x, c[8].x;
RSQ R0.y, R0.y;
MUL R0.xyz, R0.y, fragment.texcoord[2];
MUL R1.xyz, -R0, R0.w;
MAD R3.xy, -R1, c[10].y, fragment.texcoord[0].zwzw;
MAD R2.zw, -R1.xyxy, c[10].y, R3.xyxy;
MAD R2.xy, -R1, c[10].y, R2.zwzw;
TEX R3.w, R3, texture[0], 2D;
TEX R0.w, fragment.texcoord[0].zwzw, texture[0], 2D;
TEX R1.w, R2, texture[0], 2D;
TEX R2.w, R2.zwzw, texture[0], 2D;
ADD R3.x, -R0.w, R3.w;
ADD R2.z, R1, R2.w;
ADD R3.x, -R3, c[10];
ADD R3.y, R1.z, R3.w;
SLT R3.y, R0.w, R3;
SLT R3.z, R3.x, c[10].x;
MUL R3.z, R3.y, R3;
ADD R3.y, -R0.w, R2.w;
CMP R2.w, -R3.z, R3.x, c[10].x;
ADD R3.x, -R3.y, c[10];
SLT R3.y, R3.x, R2.w;
SLT R2.z, R0.w, R2;
MUL R3.y, R2.z, R3;
CMP R2.w, -R3.y, R3.x, R2;
ADD R2.z, -R0.w, R1.w;
ADD R2.z, -R2, c[10].x;
ADD R3.y, R1.z, R1.w;
MAD R2.xy, -R1, c[10].y, R2;
TEX R1.w, R2, texture[0], 2D;
SLT R3.x, R2.z, R2.w;
SLT R3.y, R0.w, R3;
MUL R3.y, R3, R3.x;
CMP R2.w, -R3.y, R2.z, R2;
ADD R3.x, -R0.w, R1.w;
ADD R2.z, -R3.x, c[10].x;
ADD R3.y, R1.z, R1.w;
MAD R2.xy, -R1, c[10].y, R2;
TEX R1.w, R2, texture[0], 2D;
MAD R2.xy, -R1, c[10].y, R2;
MAD R1.xy, -R1, c[10].y, R2;
SLT R3.x, R2.z, R2.w;
SLT R3.y, R0.w, R3;
MUL R3.y, R3, R3.x;
CMP R2.w, -R3.y, R2.z, R2;
ADD R3.x, -R0.w, R1.w;
ADD R3.y, R1.z, R1.w;
ADD R2.z, -R3.x, c[10].x;
SLT R3.x, R2.z, R2.w;
SLT R3.y, R0.w, R3;
MUL R3.y, R3, R3.x;
TEX R1.w, R2, texture[0], 2D;
ADD R3.x, -R0.w, R1.w;
CMP R2.w, -R3.y, R2.z, R2;
ADD R2.z, -R3.x, c[10].x;
ADD R1.w, R1.z, R1;
SLT R3.x, R2.z, R2.w;
SLT R1.w, R0, R1;
MUL R2.x, R1.w, R3;
TEX R1.w, R1, texture[0], 2D;
ADD R1.y, -R0.w, R1.w;
DP3 R1.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R3.z, R1.x;
CMP R4.y, -R2.x, R2.z, R2.w;
ADD R4.x, -R1.y, c[10];
MUL R2.xyz, R3.z, fragment.texcoord[1];
ADD R4.w, R1, R1.z;
ADD R1.y, R2.z, c[9].z;
RCP R1.y, R1.y;
MOV R1.x, c[6];
MUL R1.x, R1, c[9].y;
MUL R3.xy, R2, R1.y;
MAD R3.w, R0, c[6].x, -R1.x;
MAD R1.xy, R3.w, R3, fragment.texcoord[0].zwzw;
MOV R1.zw, c[10].xyxz;
TEX R2.yw, R1, texture[2], 2D;
MAD R1.xy, R2.wyzw, c[9].w, -R1.z;
SLT R1.z, R0.w, R4.w;
SLT R4.z, R4.x, R4.y;
MUL R0.w, R1.y, R1.y;
MUL R1.z, R1, R4;
MAD R0.w, -R1.x, R1.x, -R0;
CMP R2.x, -R1.z, R4, R4.y;
ADD R0.w, R0, c[10].x;
RSQ R1.z, R0.w;
MOV R2.w, c[10].x;
ADD R0.w, R2, -c[7].x;
MAD R0.w, R0, R2.x, c[7].x;
RCP R1.z, R1.z;
MUL R1.z, R1, R0.w;
DP3 R2.x, R1, R0;
MAX R4.x, R2, c[9];
MAD R2.xyz, R3.z, fragment.texcoord[1], R0;
DP3 R0.z, R2, R2;
MAD R0.xy, R3.w, R3, fragment.texcoord[0];
RSQ R3.x, R0.z;
MUL R2.xyz, R3.x, R2;
DP3 R1.x, R1, R2;
MUL R3.z, R0.w, R4.x;
TEX R0, R0, texture[1], 2D;
DP3 R1.z, fragment.texcoord[4], fragment.texcoord[4];
RSQ R2.y, R1.z;
MUL R0.xyz, R0, c[4];
MUL R0.xyz, R0, c[1];
MAX R1.x, R1, c[9];
MUL R1.y, R1.w, c[5].x;
POW R2.x, R1.x, R1.y;
TEX R1, fragment.texcoord[4], texture[3], CUBE;
DP4 R1.y, R1, c[11];
RCP R2.y, R2.y;
MUL R1.x, R2.y, c[0].w;
MAD R1.y, -R1.x, c[10].w, R1;
MUL R1.x, R2, R0.w;
CMP R1.z, R1.y, c[3].x, R2.w;
DP3 R1.y, fragment.texcoord[3], fragment.texcoord[3];
MOV R2.xyz, c[2];
MUL R0.xyz, R0, R3.z;
MUL R2.xyz, R2, c[1];
TEX R0.w, fragment.texcoord[3], texture[5], CUBE;
TEX R1.w, R1.y, texture[4], 2D;
MUL R0.w, R1, R0;
MUL R0.w, R0, R1.z;
MUL R0.w, R0, c[9];
MAD R0.xyz, R2, R1.x, R0;
MUL result.color.xyz, R0, R0.w;
MOV result.color.w, c[9].x;
END
# 128 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Vector 0 [_LightPositionRange]
Vector 1 [_LightColor0]
Vector 2 [_SpecColor]
Vector 3 [_LightShadowData]
Vector 4 [_Color]
Float 5 [_Shininess]
Float 6 [_Parallax]
Float 7 [_ShadingStrength]
Float 8 [_ShadeRange]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_ShadowMapTexture] CUBE
SetTexture 4 [_LightTextureB0] 2D
SetTexture 5 [_LightTexture0] CUBE
"ps_3_0
; 132 ALU, 13 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_cube s3
dcl_2d s4
dcl_cube s5
def c9, 0.50000000, 0.41999999, 2.00000000, -1.00000000
def c10, 1.00000000, 0.14285715, 0.00000000, 128.00000000
def c11, 1.00000000, 0.00392157, 0.00001538, 0.00000001
def c12, 0.97000003, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
mov r0.y, c8.x
dp3_pp r0.x, v2, v2
add r0.w, c6.x, r0.y
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, v2
mul r1.xyz, -r0, r0.w
mad r3.xy, -r1, c10.y, v0.zwzw
mad r4.xy, -r1, c10.y, r3
mad r2.xy, -r1, c10.y, r4
texld r3.w, r4, s0
texld r2.w, r3, s0
texld r0.w, v0.zwzw, s0
texld r1.w, r2, s0
add r2.z, r1, r3.w
add r3.x, -r0.w, r3.w
add r3.y, r1.z, r2.w
add r2.z, r0.w, -r2
add r3.z, -r0.w, r1.w
add r3.w, -r0, r2
add r3.y, r0.w, -r3
cmp r2.w, r3.y, c10.z, c10.x
cmp r3.y, -r3.w, c10.z, c10.x
mul_pp r2.w, r2, r3.y
add r3.w, -r3, c10.x
cmp r2.w, -r2, c10.x, r3
add r3.x, -r3, c10
add r3.y, -r2.w, r3.x
mad r2.xy, -r1, c10.y, r2
cmp r2.z, r2, c10, c10.x
cmp r3.y, r3, c10.z, c10.x
mul_pp r3.y, r2.z, r3
cmp r3.x, -r3.y, r2.w, r3
add r2.z, -r3, c10.x
add r3.y, r1.z, r1.w
texld r1.w, r2, s0
add r3.z, r0.w, -r3.y
add r2.w, -r3.x, r2.z
add r3.y, -r0.w, r1.w
mad r2.xy, -r1, c10.y, r2
cmp r2.w, r2, c10.z, c10.x
cmp r3.z, r3, c10, c10.x
mul_pp r3.z, r3, r2.w
add r2.w, -r3.y, c10.x
cmp r3.x, -r3.z, r3, r2.z
add r3.y, r1.z, r1.w
texld r1.w, r2, s0
add r3.z, r0.w, -r3.y
mad r2.xy, -r1, c10.y, r2
add r2.z, -r3.x, r2.w
mad r1.xy, -r1, c10.y, r2
add r3.y, -r0.w, r1.w
cmp r2.z, r2, c10, c10.x
cmp r3.z, r3, c10, c10.x
mul_pp r3.z, r3, r2
add r2.z, -r3.y, c10.x
cmp r2.w, -r3.z, r3.x, r2
add r3.y, r1.z, r1.w
add r3.x, -r2.w, r2.z
add r3.z, r0.w, -r3.y
texld r1.w, r2, s0
add r3.y, -r0.w, r1.w
cmp r3.x, r3, c10.z, c10
cmp r3.z, r3, c10, c10.x
mul_pp r3.z, r3, r3.x
cmp r2.z, -r3, r2.w, r2
add r3.x, -r3.y, c10
add r2.w, r1.z, r1
add r3.y, -r2.z, r3.x
add r2.w, r0, -r2
cmp r1.w, r3.y, c10.z, c10.x
cmp r2.x, r2.w, c10.z, c10
mul_pp r2.x, r2, r1.w
texld r1.w, r1, s0
add r1.y, -r0.w, r1.w
add r1.z, r1.w, r1
cmp r3.z, -r2.x, r2, r3.x
dp3_pp r1.x, v1, v1
rsq_pp r3.x, r1.x
add r4.x, -r1.y, c10
mul_pp r2.xyz, r3.x, v1
add r1.x, -r3.z, r4
cmp r4.y, r1.x, c10.z, c10.x
add r1.y, r2.z, c9
mov_pp r1.x, c9
mul_pp r2.z, c6.x, r1.x
mad_pp r2.w, r0, c6.x, -r2.z
add r0.w, r0, -r1.z
cmp r1.z, r0.w, c10, c10.x
mul_pp r1.z, r1, r4.y
rcp r1.y, r1.y
mul r1.xy, r2, r1.y
mad r2.xy, r2.w, r1, v0.zwzw
texld r3.yw, r2, s2
mad_pp r2.xy, r3.wyzw, c9.z, c9.w
cmp r2.z, -r1, r3, r4.x
mul_pp r0.w, r2.y, r2.y
mad_pp r0.w, -r2.x, r2.x, -r0
add_pp r0.w, r0, c10.x
rsq_pp r1.z, r0.w
mov r1.w, c7.x
add r0.w, c10.x, -r1
mad_pp r3.xyz, r3.x, v1, r0
mad r0.w, r0, r2.z, c7.x
rcp_pp r1.z, r1.z
mul r2.z, r1, r0.w
dp3 r0.y, r2, r0
dp3_pp r1.z, r3, r3
rsq_pp r0.x, r1.z
max r1.z, r0.y, c10
mul_pp r0.xyz, r0.x, r3
dp3 r0.x, r2, r0
max r0.z, r0.x, c10
mul r1.z, r0.w, r1
mov_pp r0.y, c5.x
mul_pp r0.w, c10, r0.y
mad r0.xy, r2.w, r1, v0
pow r2, r0.z, r0.w
texld r0, r0, s1
mul_pp r3.xyz, r0, c4
mov r0.x, r2
mul_pp r2.xyz, r3, c1
mul_pp r1.xyz, r2, r1.z
mul r1.w, r0.x, r0
texld r0, v4, s3
dp4 r0.y, r0, c11
dp3 r2.x, v4, v4
rsq r2.x, r2.x
rcp r0.x, r2.x
mul r0.x, r0, c0.w
mad r0.x, -r0, c12, r0.y
mov r0.z, c3.x
cmp r0.y, r0.x, c10.x, r0.z
dp3 r0.x, v3, v3
texld r0.w, v3, s5
texld r0.x, r0.x, s4
mul r0.x, r0, r0.w
mul r0.w, r0.x, r0.y
mov_pp r0.xyz, c1
mul_pp r0.xyz, c2, r0
mul_pp r0.w, r0, c9.z
mad r0.xyz, r0, r1.w, r1
mul oC0.xyz, r0, r0.w
mov_pp oC0.w, c10.z
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
Vector 7 [_Color]
Float 8 [_Shininess]
Float 9 [_Parallax]
Float 10 [_ShadingStrength]
Float 11 [_ShadeRange]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_LightTexture0] 2D
SetTexture 4 [_LightTextureB0] 2D
SetTexture 5 [_ShadowMapTexture] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 139 ALU, 16 TEX
PARAM c[14] = { program.local[0..11],
		{ 0, 0.5, 0.41999999, 2 },
		{ 1, 0.14285715, 128, 0.25 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MOV R0.x, c[9];
DP3 R0.y, fragment.texcoord[2], fragment.texcoord[2];
ADD R0.w, R0.x, c[11].x;
RSQ R0.y, R0.y;
MUL R0.xyz, R0.y, fragment.texcoord[2];
MUL R1.xyz, -R0, R0.w;
MAD R3.xy, -R1, c[13].y, fragment.texcoord[0].zwzw;
MAD R2.zw, -R1.xyxy, c[13].y, R3.xyxy;
MAD R2.xy, -R1, c[13].y, R2.zwzw;
TEX R2.w, R2.zwzw, texture[0], 2D;
TEX R3.w, R3, texture[0], 2D;
TEX R0.w, fragment.texcoord[0].zwzw, texture[0], 2D;
TEX R1.w, R2, texture[0], 2D;
ADD R3.x, -R0.w, R3.w;
ADD R2.z, R1, R2.w;
ADD R3.x, -R3, c[13];
ADD R3.y, R1.z, R3.w;
SLT R3.y, R0.w, R3;
SLT R3.z, R3.x, c[13].x;
MUL R3.z, R3.y, R3;
ADD R3.y, -R0.w, R2.w;
CMP R2.w, -R3.z, R3.x, c[13].x;
ADD R3.x, -R3.y, c[13];
SLT R3.y, R3.x, R2.w;
SLT R2.z, R0.w, R2;
MUL R3.y, R2.z, R3;
CMP R2.w, -R3.y, R3.x, R2;
ADD R2.z, -R0.w, R1.w;
ADD R2.z, -R2, c[13].x;
ADD R3.y, R1.z, R1.w;
MAD R2.xy, -R1, c[13].y, R2;
TEX R1.w, R2, texture[0], 2D;
SLT R3.x, R2.z, R2.w;
SLT R3.y, R0.w, R3;
MUL R3.y, R3, R3.x;
CMP R2.w, -R3.y, R2.z, R2;
ADD R3.x, -R0.w, R1.w;
ADD R2.z, -R3.x, c[13].x;
ADD R3.y, R1.z, R1.w;
MAD R2.xy, -R1, c[13].y, R2;
TEX R1.w, R2, texture[0], 2D;
MAD R2.xy, -R1, c[13].y, R2;
MAD R1.xy, -R1, c[13].y, R2;
SLT R3.x, R2.z, R2.w;
SLT R3.y, R0.w, R3;
MUL R3.y, R3, R3.x;
CMP R2.w, -R3.y, R2.z, R2;
ADD R3.x, -R0.w, R1.w;
ADD R3.y, R1.z, R1.w;
ADD R2.z, -R3.x, c[13].x;
SLT R3.x, R2.z, R2.w;
SLT R3.y, R0.w, R3;
MUL R3.y, R3, R3.x;
TEX R1.w, R2, texture[0], 2D;
ADD R3.x, -R0.w, R1.w;
CMP R2.w, -R3.y, R2.z, R2;
ADD R2.z, -R3.x, c[13].x;
ADD R1.w, R1.z, R1;
SLT R3.x, R2.z, R2.w;
SLT R1.w, R0, R1;
MUL R2.x, R1.w, R3;
TEX R1.w, R1, texture[0], 2D;
ADD R1.y, -R0.w, R1.w;
DP3 R1.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R3.z, R1.x;
CMP R4.y, -R2.x, R2.z, R2.w;
ADD R4.x, -R1.y, c[13];
MUL R2.xyz, R3.z, fragment.texcoord[1];
ADD R4.w, R1, R1.z;
ADD R1.y, R2.z, c[12].z;
RCP R1.y, R1.y;
MOV R1.x, c[9];
MUL R1.x, R1, c[12].y;
MUL R3.xy, R2, R1.y;
MAD R3.w, R0, c[9].x, -R1.x;
MAD R1.xy, R3.w, R3, fragment.texcoord[0].zwzw;
MOV R1.zw, c[13].xyxz;
TEX R2.yw, R1, texture[2], 2D;
MAD R1.xy, R2.wyzw, c[12].w, -R1.z;
SLT R1.z, R0.w, R4.w;
SLT R4.z, R4.x, R4.y;
MUL R0.w, R1.y, R1.y;
MUL R1.z, R1, R4;
MAD R0.w, -R1.x, R1.x, -R0;
CMP R2.x, -R1.z, R4, R4.y;
ADD R0.w, R0, c[13].x;
RSQ R1.z, R0.w;
MOV R2.w, c[13].x;
ADD R0.w, R2, -c[10].x;
MAD R0.w, R0, R2.x, c[10].x;
RCP R1.z, R1.z;
MUL R1.z, R1, R0.w;
DP3 R2.x, R1, R0;
MAX R4.x, R2, c[12];
MAD R2.xyz, R3.z, fragment.texcoord[1], R0;
DP3 R0.z, R2, R2;
MAD R0.xy, R3.w, R3, fragment.texcoord[0];
RSQ R3.x, R0.z;
MUL R2.xyz, R3.x, R2;
MUL R3.z, R0.w, R4.x;
TEX R0, R0, texture[1], 2D;
MUL R0.xyz, R0, c[7];
MUL R0.xyz, R0, c[0];
DP3 R1.x, R1, R2;
MUL R2.xyz, R0, R3.z;
RCP R0.z, fragment.texcoord[4].w;
MAX R0.x, R1, c[12];
MUL R0.y, R1.w, c[8].x;
MAD R1.xy, fragment.texcoord[4], R0.z, c[5];
MAD R1.zw, fragment.texcoord[4].xyxy, R0.z, c[6].xyxy;
POW R0.y, R0.x, R0.y;
TEX R0.x, R1.zwzw, texture[5], 2D;
TEX R1.x, R1, texture[5], 2D;
MOV R1.z, R1.x;
MAD R1.xy, fragment.texcoord[4], R0.z, c[3];
MAD R3.xy, fragment.texcoord[4], R0.z, c[4];
MOV R1.w, R0.x;
TEX R0.x, R3, texture[5], 2D;
TEX R1.x, R1, texture[5], 2D;
MOV R1.y, R0.x;
MAD R1, -fragment.texcoord[4].z, R0.z, R1;
MUL R3.x, R0.y, R0.w;
CMP R0, R1, c[2].x, R2.w;
DP4 R1.y, R0, c[13].w;
DP3 R0.z, fragment.texcoord[3], fragment.texcoord[3];
RCP R1.x, fragment.texcoord[3].w;
MAD R0.xy, fragment.texcoord[3], R1.x, c[12].y;
TEX R0.w, R0, texture[3], 2D;
SLT R0.x, c[12], fragment.texcoord[3].z;
MUL R0.x, R0, R0.w;
TEX R1.w, R0.z, texture[4], 2D;
MUL R0.x, R0, R1.w;
MUL R0.w, R0.x, R1.y;
MOV R0.xyz, c[1];
MUL R0.xyz, R0, c[0];
MUL R0.w, R0, c[12];
MAD R0.xyz, R0, R3.x, R2;
MUL result.color.xyz, R0, R0.w;
MOV result.color.w, c[12].x;
END
# 139 instructions, 5 R-regs
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
Vector 7 [_Color]
Float 8 [_Shininess]
Float 9 [_Parallax]
Float 10 [_ShadingStrength]
Float 11 [_ShadeRange]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_LightTexture0] 2D
SetTexture 4 [_LightTextureB0] 2D
SetTexture 5 [_ShadowMapTexture] 2D
"ps_3_0
; 140 ALU, 16 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
def c12, 0.50000000, 0.41999999, 2.00000000, -1.00000000
def c13, 1.00000000, 0.14285715, 0.00000000, 128.00000000
def c14, 0.25000000, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3
dcl_texcoord4 v4
mov r0.y, c11.x
dp3_pp r0.x, v2, v2
add r0.w, c9.x, r0.y
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, v2
mul r1.xyz, -r0, r0.w
mad r3.xy, -r1, c13.y, v0.zwzw
mad r4.xy, -r1, c13.y, r3
mad r2.xy, -r1, c13.y, r4
texld r3.w, r4, s0
texld r2.w, r3, s0
texld r0.w, v0.zwzw, s0
texld r1.w, r2, s0
add r2.z, r1, r3.w
add r3.x, -r0.w, r3.w
add r3.y, r1.z, r2.w
add r2.z, r0.w, -r2
add r3.z, -r0.w, r1.w
add r3.w, -r0, r2
add r3.y, r0.w, -r3
cmp r2.w, r3.y, c13.z, c13.x
cmp r3.y, -r3.w, c13.z, c13.x
mul_pp r2.w, r2, r3.y
add r3.w, -r3, c13.x
cmp r2.w, -r2, c13.x, r3
add r3.x, -r3, c13
add r3.y, -r2.w, r3.x
mad r2.xy, -r1, c13.y, r2
cmp r2.z, r2, c13, c13.x
cmp r3.y, r3, c13.z, c13.x
mul_pp r3.y, r2.z, r3
cmp r3.x, -r3.y, r2.w, r3
add r2.z, -r3, c13.x
add r3.y, r1.z, r1.w
texld r1.w, r2, s0
add r3.z, r0.w, -r3.y
add r2.w, -r3.x, r2.z
add r3.y, -r0.w, r1.w
mad r2.xy, -r1, c13.y, r2
cmp r2.w, r2, c13.z, c13.x
cmp r3.z, r3, c13, c13.x
mul_pp r3.z, r3, r2.w
add r2.w, -r3.y, c13.x
cmp r3.x, -r3.z, r3, r2.z
add r3.y, r1.z, r1.w
texld r1.w, r2, s0
add r3.z, r0.w, -r3.y
mad r2.xy, -r1, c13.y, r2
add r2.z, -r3.x, r2.w
mad r1.xy, -r1, c13.y, r2
add r3.y, -r0.w, r1.w
cmp r2.z, r2, c13, c13.x
cmp r3.z, r3, c13, c13.x
mul_pp r3.z, r3, r2
add r2.z, -r3.y, c13.x
cmp r2.w, -r3.z, r3.x, r2
add r3.y, r1.z, r1.w
add r3.x, -r2.w, r2.z
add r3.z, r0.w, -r3.y
texld r1.w, r2, s0
add r3.y, -r0.w, r1.w
add r1.w, r1.z, r1
add r2.x, r0.w, -r1.w
texld r1.w, r1, s0
add r1.y, -r0.w, r1.w
add r3.w, -r1.y, c13.x
add r1.z, r1.w, r1
cmp r3.x, r3, c13.z, c13
cmp r3.z, r3, c13, c13.x
mul_pp r3.z, r3, r3.x
cmp r2.z, -r3, r2.w, r2
add r3.x, -r3.y, c13
add r2.w, -r2.z, r3.x
cmp r2.w, r2, c13.z, c13.x
cmp r1.x, r2, c13.z, c13
mul_pp r1.x, r1, r2.w
cmp r3.z, -r1.x, r2, r3.x
dp3_pp r1.x, v1, v1
rsq_pp r2.w, r1.x
add r1.y, -r3.z, r3.w
mov_pp r1.x, c12
mul_pp r1.x, c9, r1
mad_pp r4.y, r0.w, c9.x, -r1.x
add r0.w, r0, -r1.z
mul_pp r2.xyz, r2.w, v1
cmp r4.x, r1.y, c13.z, c13
add r1.y, r2.z, c12
rcp r1.y, r1.y
mul r3.xy, r2, r1.y
mad r1.xy, r4.y, r3, v0.zwzw
texld r1.yw, r1, s2
mad_pp r1.xy, r1.wyzw, c12.z, c12.w
cmp r0.w, r0, c13.z, c13.x
mul_pp r1.z, r0.w, r4.x
mul_pp r0.w, r1.y, r1.y
cmp r2.x, -r1.z, r3.z, r3.w
mad_pp r0.w, -r1.x, r1.x, -r0
add_pp r1.z, r0.w, c13.x
mov r1.w, c10.x
add r0.w, c13.x, -r1
mad r0.w, r0, r2.x, c10.x
mad_pp r2.xyz, r2.w, v1, r0
dp3_pp r1.w, r2, r2
rsq_pp r1.z, r1.z
rcp_pp r1.z, r1.z
mul r1.z, r1, r0.w
dp3 r2.w, r1, r0
rsq_pp r1.w, r1.w
mul_pp r0.xyz, r1.w, r2
dp3 r0.x, r1, r0
max r1.w, r2, c13.z
max r1.x, r0, c13.z
mov_pp r1.z, c8.x
mul_pp r1.z, c13.w, r1
pow r2, r1.x, r1.z
rcp r2.z, v4.w
mul r1.y, r0.w, r1.w
mad r0.xy, r4.y, r3, v0
texld r0, r0, s1
mul_pp r0.xyz, r0, c7
mul_pp r0.xyz, r0, c0
mul_pp r1.xyz, r0, r1.y
mov r0.z, r2.x
mad r0.xy, v4, r2.z, c6
mul r1.w, r0.z, r0
texld r0.x, r0, s5
mad r2.xy, v4, r2.z, c5
mov r0.w, r0.x
texld r0.x, r2, s5
mad r2.xy, v4, r2.z, c4
mov r0.z, r0.x
texld r0.x, r2, s5
mad r2.xy, v4, r2.z, c3
mov r0.y, r0.x
texld r0.x, r2, s5
mov r2.x, c2
mad r0, -v4.z, r2.z, r0
cmp r0, r0, c13.x, r2.x
dp4_pp r0.z, r0, c14.x
rcp r2.x, v3.w
mad r2.xy, v3, r2.x, c12.x
dp3 r0.x, v3, v3
texld r0.w, r2, s3
cmp r0.y, -v3.z, c13.z, c13.x
mul_pp r0.y, r0, r0.w
texld r0.x, r0.x, s4
mul_pp r0.x, r0.y, r0
mul_pp r0.w, r0.x, r0.z
mov_pp r0.xyz, c0
mul_pp r0.xyz, c1, r0
mul_pp r0.w, r0, c12.z
mad r0.xyz, r0, r1.w, r1
mul oC0.xyz, r0, r0.w
mov_pp oC0.w, c13.z
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
Vector 7 [_Color]
Float 8 [_Shininess]
Float 9 [_Parallax]
Float 10 [_ShadingStrength]
Float 11 [_ShadeRange]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_LightTexture0] 2D
SetTexture 4 [_LightTextureB0] 2D
SetTexture 5 [_ShadowMapTexture] 2D
"ps_3_0
; 139 ALU, 16 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
def c12, 0.50000000, 0.41999999, 2.00000000, -1.00000000
def c13, 1.00000000, 0.14285715, 0.00000000, 128.00000000
def c14, 0.25000000, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3
dcl_texcoord4 v4
mov r0.y, c11.x
dp3_pp r0.x, v2, v2
add r0.w, c9.x, r0.y
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, v2
mul r1.xyz, -r0, r0.w
mad r3.xy, -r1, c13.y, v0.zwzw
mad r4.xy, -r1, c13.y, r3
texld r2.w, r3, s0
mad r2.xy, -r1, c13.y, r4
texld r1.w, r2, s0
texld r0.w, v0.zwzw, s0
texld r3.w, r4, s0
add r2.z, r1, r3.w
add r3.x, -r0.w, r3.w
add r3.y, r1.z, r2.w
add r2.z, r0.w, -r2
add r3.z, -r0.w, r1.w
add r3.w, -r0, r2
add r3.y, r0.w, -r3
cmp r2.w, r3.y, c13.z, c13.x
cmp r3.y, -r3.w, c13.z, c13.x
mul_pp r2.w, r2, r3.y
add r3.w, -r3, c13.x
cmp r2.w, -r2, c13.x, r3
add r3.x, -r3, c13
add r3.y, -r2.w, r3.x
mad r2.xy, -r1, c13.y, r2
cmp r2.z, r2, c13, c13.x
cmp r3.y, r3, c13.z, c13.x
mul_pp r3.y, r2.z, r3
cmp r3.x, -r3.y, r2.w, r3
add r2.z, -r3, c13.x
add r3.y, r1.z, r1.w
texld r1.w, r2, s0
add r3.z, r0.w, -r3.y
add r2.w, -r3.x, r2.z
add r3.y, -r0.w, r1.w
mad r2.xy, -r1, c13.y, r2
cmp r2.w, r2, c13.z, c13.x
cmp r3.z, r3, c13, c13.x
mul_pp r3.z, r3, r2.w
add r2.w, -r3.y, c13.x
cmp r3.x, -r3.z, r3, r2.z
add r3.y, r1.z, r1.w
texld r1.w, r2, s0
add r3.z, r0.w, -r3.y
mad r2.xy, -r1, c13.y, r2
add r2.z, -r3.x, r2.w
mad r1.xy, -r1, c13.y, r2
add r3.y, -r0.w, r1.w
cmp r2.z, r2, c13, c13.x
cmp r3.z, r3, c13, c13.x
mul_pp r3.z, r3, r2
add r2.z, -r3.y, c13.x
cmp r2.w, -r3.z, r3.x, r2
add r3.y, r1.z, r1.w
add r3.x, -r2.w, r2.z
add r3.z, r0.w, -r3.y
texld r1.w, r2, s0
add r3.y, -r0.w, r1.w
cmp r3.x, r3, c13.z, c13
cmp r3.z, r3, c13, c13.x
mul_pp r3.z, r3, r3.x
cmp r2.z, -r3, r2.w, r2
add r3.x, -r3.y, c13
add r2.w, r1.z, r1
add r3.y, -r2.z, r3.x
add r2.w, r0, -r2
cmp r1.w, r3.y, c13.z, c13.x
cmp r2.x, r2.w, c13.z, c13
mul_pp r2.x, r2, r1.w
texld r1.w, r1, s0
add r1.y, -r0.w, r1.w
dp3_pp r1.x, v1, v1
cmp r3.x, -r2, r2.z, r3
rsq_pp r2.w, r1.x
add r3.y, -r1, c13.x
mul_pp r2.xyz, r2.w, v1
add r1.x, -r3, r3.y
cmp r3.z, r1.x, c13, c13.x
add r1.y, r2.z, c12
rcp r1.y, r1.y
mov_pp r1.x, c12
mul_pp r1.x, c9, r1
mul r2.xy, r2, r1.y
mad_pp r2.z, r0.w, c9.x, -r1.x
add r1.z, r1.w, r1
add r0.w, r0, -r1.z
mad r1.xy, r2.z, r2, v0.zwzw
texld r1.yw, r1, s2
cmp r1.z, r0.w, c13, c13.x
mad_pp r1.xy, r1.wyzw, c12.z, c12.w
mul_pp r1.z, r1, r3
cmp r1.w, -r1.z, r3.x, r3.y
mad r3.xy, r2.z, r2, v0
mad_pp r2.xyz, r2.w, v1, r0
mul_pp r0.w, r1.y, r1.y
mad_pp r0.w, -r1.x, r1.x, -r0
dp3_pp r2.w, r2, r2
add_pp r0.w, r0, c13.x
mov r1.z, c10.x
add r1.z, c13.x, -r1
rsq_pp r0.w, r0.w
mad r1.w, r1.z, r1, c10.x
rcp_pp r0.w, r0.w
mul r1.z, r0.w, r1.w
dp3 r0.w, r1, r0
max r0.w, r0, c13.z
mul r1.w, r1, r0
texld r0, r3, s1
mul_pp r0.xyz, r0, c7
mul_pp r0.xyz, r0, c0
mul_pp r3.xyz, r0, r1.w
rsq_pp r2.w, r2.w
mul_pp r0.xyz, r2.w, r2
dp3 r0.x, r1, r0
mov_pp r1.w, c8.x
rcp r2.x, v4.w
mul_pp r0.y, c13.w, r1.w
max r0.x, r0, c13.z
pow r1, r0.x, r0.y
mad r0.xyz, v4, r2.x, c6
mul r1.w, r1.x, r0
mad r1.xyz, v4, r2.x, c4
texld r0.x, r0, s5
mov_pp r0.w, r0.x
mad r0.xyz, v4, r2.x, c5
texld r0.x, r0, s5
texld r1.x, r1, s5
mov_pp r0.z, r0.x
mov_pp r0.y, r1.x
mad r1.xyz, v4, r2.x, c3
mov r0.x, c2
add r2.x, c13, -r0
texld r0.x, r1, s5
mad r0, r0, r2.x, c2.x
dp4_pp r0.z, r0, c14.x
rcp r1.x, v3.w
mad r1.xy, v3, r1.x, c12.x
dp3 r0.x, v3, v3
texld r0.w, r1, s3
cmp r0.y, -v3.z, c13.z, c13.x
mul_pp r0.y, r0, r0.w
texld r0.x, r0.x, s4
mul_pp r0.x, r0.y, r0
mul_pp r0.w, r0.x, r0.z
mov_pp r0.xyz, c0
mul_pp r0.xyz, c1, r0
mul_pp r0.w, r0, c12.z
mad r0.xyz, r0, r1.w, r3
mul oC0.xyz, r0, r0.w
mov_pp oC0.w, c13.z
"
}
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Vector 0 [_LightPositionRange]
Vector 1 [_LightColor0]
Vector 2 [_SpecColor]
Vector 3 [_LightShadowData]
Vector 4 [_Color]
Float 5 [_Shininess]
Float 6 [_Parallax]
Float 7 [_ShadingStrength]
Float 8 [_ShadeRange]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_ShadowMapTexture] CUBE
SetTexture 4 [_LightTexture0] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 137 ALU, 15 TEX
PARAM c[13] = { program.local[0..8],
		{ 0, 0.5, 0.41999999, 2 },
		{ 1, 0.14285715, 128, 0.97000003 },
		{ 0.0078125, -0.0078125, 0.25 },
		{ 1, 0.0039215689, 1.53787e-005, 6.2273724e-009 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MOV R0.x, c[6];
DP3 R0.y, fragment.texcoord[2], fragment.texcoord[2];
ADD R0.w, R0.x, c[8].x;
RSQ R0.y, R0.y;
MUL R0.xyz, R0.y, fragment.texcoord[2];
MUL R1.xyz, -R0, R0.w;
MAD R3.xy, -R1, c[10].y, fragment.texcoord[0].zwzw;
MAD R2.zw, -R1.xyxy, c[10].y, R3.xyxy;
MAD R2.xy, -R1, c[10].y, R2.zwzw;
TEX R3.w, R3, texture[0], 2D;
TEX R0.w, fragment.texcoord[0].zwzw, texture[0], 2D;
TEX R1.w, R2, texture[0], 2D;
TEX R2.w, R2.zwzw, texture[0], 2D;
ADD R3.x, -R0.w, R3.w;
ADD R2.z, R1, R2.w;
ADD R3.x, -R3, c[10];
ADD R3.y, R1.z, R3.w;
SLT R3.y, R0.w, R3;
SLT R3.z, R3.x, c[10].x;
MUL R3.z, R3.y, R3;
ADD R3.y, -R0.w, R2.w;
CMP R2.w, -R3.z, R3.x, c[10].x;
ADD R3.x, -R3.y, c[10];
SLT R3.y, R3.x, R2.w;
SLT R2.z, R0.w, R2;
MUL R3.y, R2.z, R3;
CMP R2.w, -R3.y, R3.x, R2;
ADD R2.z, -R0.w, R1.w;
ADD R2.z, -R2, c[10].x;
ADD R3.y, R1.z, R1.w;
MAD R2.xy, -R1, c[10].y, R2;
TEX R1.w, R2, texture[0], 2D;
SLT R3.x, R2.z, R2.w;
SLT R3.y, R0.w, R3;
MUL R3.y, R3, R3.x;
CMP R2.w, -R3.y, R2.z, R2;
ADD R3.x, -R0.w, R1.w;
ADD R2.z, -R3.x, c[10].x;
ADD R3.y, R1.z, R1.w;
MAD R2.xy, -R1, c[10].y, R2;
TEX R1.w, R2, texture[0], 2D;
MAD R2.xy, -R1, c[10].y, R2;
MAD R1.xy, -R1, c[10].y, R2;
SLT R3.x, R2.z, R2.w;
SLT R3.y, R0.w, R3;
MUL R3.y, R3, R3.x;
CMP R2.w, -R3.y, R2.z, R2;
ADD R3.x, -R0.w, R1.w;
ADD R3.y, R1.z, R1.w;
ADD R2.z, -R3.x, c[10].x;
SLT R3.x, R2.z, R2.w;
SLT R3.y, R0.w, R3;
MUL R3.y, R3, R3.x;
TEX R1.w, R2, texture[0], 2D;
ADD R3.x, -R0.w, R1.w;
CMP R2.w, -R3.y, R2.z, R2;
ADD R2.z, -R3.x, c[10].x;
ADD R1.w, R1.z, R1;
SLT R3.x, R2.z, R2.w;
SLT R1.w, R0, R1;
MUL R2.x, R1.w, R3;
TEX R1.w, R1, texture[0], 2D;
ADD R1.y, -R0.w, R1.w;
ADD R4.y, R1.w, R1.z;
CMP R3.z, -R2.x, R2, R2.w;
ADD R3.x, -R1.y, c[10];
DP3 R1.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R2.w, R1.x;
MUL R2.xyz, R2.w, fragment.texcoord[1];
ADD R1.y, R2.z, c[9].z;
RCP R1.y, R1.y;
MOV R1.x, c[6];
MUL R1.x, R1, c[9].y;
MAD R2.z, R0.w, c[6].x, -R1.x;
MUL R2.xy, R2, R1.y;
MAD R1.xy, R2.z, R2, fragment.texcoord[0].zwzw;
SLT R4.x, R3, R3.z;
MOV R1.zw, c[10].xyxz;
TEX R3.yw, R1, texture[2], 2D;
MAD R1.xy, R3.wyzw, c[9].w, -R1.z;
SLT R1.z, R0.w, R4.y;
MUL R1.z, R1, R4.x;
MUL R0.w, R1.y, R1.y;
MAD R0.w, -R1.x, R1.x, -R0;
CMP R3.x, -R1.z, R3, R3.z;
ADD R0.w, R0, c[10].x;
RSQ R1.z, R0.w;
MOV R4.x, c[10];
ADD R0.w, R4.x, -c[7].x;
MAD R0.w, R0, R3.x, c[7].x;
RCP R1.z, R1.z;
MUL R1.z, R1, R0.w;
DP3 R3.x, R1, R0;
MAD R0.xyz, R2.w, fragment.texcoord[1], R0;
MAX R3.x, R3, c[9];
MUL R0.w, R0, R3.x;
DP3 R2.w, R0, R0;
RSQ R3.x, R2.w;
MUL R0.xyz, R3.x, R0;
MAD R2.xy, R2.z, R2, fragment.texcoord[0];
TEX R2, R2, texture[1], 2D;
DP3 R0.x, R1, R0;
MUL R2.xyz, R2, c[4];
MUL R1.xyz, R2, c[1];
MUL R2.xyz, R1, R0.w;
MAX R1.x, R0, c[9];
MUL R1.y, R1.w, c[5].x;
POW R4.y, R1.x, R1.y;
ADD R0.xyz, fragment.texcoord[4], c[11].xyyw;
TEX R0, R0, texture[3], CUBE;
DP4 R3.w, R0, c[12];
ADD R0.xyz, fragment.texcoord[4], c[11].yxyw;
TEX R0, R0, texture[3], CUBE;
DP4 R3.z, R0, c[12];
ADD R1.xyz, fragment.texcoord[4], c[11].yyxw;
TEX R1, R1, texture[3], CUBE;
DP4 R3.y, R1, c[12];
DP3 R0.w, fragment.texcoord[4], fragment.texcoord[4];
RSQ R1.x, R0.w;
ADD R0.xyz, fragment.texcoord[4], c[11].x;
TEX R0, R0, texture[3], CUBE;
RCP R1.x, R1.x;
DP4 R3.x, R0, c[12];
MUL R0.x, R1, c[0].w;
MAD R0, -R0.x, c[10].w, R3;
CMP R0, R0, c[3].x, R4.x;
DP4 R0.x, R0, c[11].z;
DP3 R1.y, fragment.texcoord[3], fragment.texcoord[3];
TEX R0.w, R1.y, texture[4], 2D;
MUL R0.w, R0, R0.x;
MOV R0.xyz, c[2];
MUL R1.x, R4.y, R2.w;
MUL R0.xyz, R0, c[1];
MUL R0.w, R0, c[9];
MAD R0.xyz, R0, R1.x, R2;
MUL result.color.xyz, R0, R0.w;
MOV result.color.w, c[9].x;
END
# 137 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Vector 0 [_LightPositionRange]
Vector 1 [_LightColor0]
Vector 2 [_SpecColor]
Vector 3 [_LightShadowData]
Vector 4 [_Color]
Float 5 [_Shininess]
Float 6 [_Parallax]
Float 7 [_ShadingStrength]
Float 8 [_ShadeRange]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_ShadowMapTexture] CUBE
SetTexture 4 [_LightTexture0] 2D
"ps_3_0
; 139 ALU, 15 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_cube s3
dcl_2d s4
def c9, 0.50000000, 0.41999999, 2.00000000, -1.00000000
def c10, 1.00000000, 0.14285715, 0.00000000, 128.00000000
def c11, 0.00781250, -0.00781250, 0.97000003, 0.25000000
def c12, 1.00000000, 0.00392157, 0.00001538, 0.00000001
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
mov r0.y, c8.x
dp3_pp r0.x, v2, v2
add r0.w, c6.x, r0.y
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, v2
mul r1.xyz, -r0, r0.w
mad r3.xy, -r1, c10.y, v0.zwzw
mad r4.xy, -r1, c10.y, r3
mad r2.xy, -r1, c10.y, r4
texld r3.w, r4, s0
texld r2.w, r3, s0
texld r0.w, v0.zwzw, s0
texld r1.w, r2, s0
add r2.z, r1, r3.w
add r3.x, -r0.w, r3.w
add r3.y, r1.z, r2.w
add r2.z, r0.w, -r2
add r3.z, -r0.w, r1.w
add r3.w, -r0, r2
add r3.y, r0.w, -r3
cmp r2.w, r3.y, c10.z, c10.x
cmp r3.y, -r3.w, c10.z, c10.x
mul_pp r2.w, r2, r3.y
add r3.w, -r3, c10.x
cmp r2.w, -r2, c10.x, r3
add r3.x, -r3, c10
add r3.y, -r2.w, r3.x
mad r2.xy, -r1, c10.y, r2
cmp r2.z, r2, c10, c10.x
cmp r3.y, r3, c10.z, c10.x
mul_pp r3.y, r2.z, r3
cmp r3.x, -r3.y, r2.w, r3
add r2.z, -r3, c10.x
add r3.y, r1.z, r1.w
texld r1.w, r2, s0
add r3.z, r0.w, -r3.y
add r2.w, -r3.x, r2.z
add r3.y, -r0.w, r1.w
mad r2.xy, -r1, c10.y, r2
cmp r2.w, r2, c10.z, c10.x
cmp r3.z, r3, c10, c10.x
mul_pp r3.z, r3, r2.w
add r2.w, -r3.y, c10.x
cmp r3.x, -r3.z, r3, r2.z
add r3.y, r1.z, r1.w
texld r1.w, r2, s0
add r3.z, r0.w, -r3.y
mad r2.xy, -r1, c10.y, r2
add r2.z, -r3.x, r2.w
mad r1.xy, -r1, c10.y, r2
add r3.y, -r0.w, r1.w
cmp r2.z, r2, c10, c10.x
cmp r3.z, r3, c10, c10.x
mul_pp r3.z, r3, r2
add r2.z, -r3.y, c10.x
cmp r2.w, -r3.z, r3.x, r2
add r3.y, r1.z, r1.w
add r3.x, -r2.w, r2.z
add r3.z, r0.w, -r3.y
texld r1.w, r2, s0
add r3.y, -r0.w, r1.w
add r1.w, r1.z, r1
add r2.x, r0.w, -r1.w
texld r1.w, r1, s0
add r1.y, -r0.w, r1.w
add r3.w, -r1.y, c10.x
add r1.z, r1.w, r1
cmp r3.x, r3, c10.z, c10
cmp r3.z, r3, c10, c10.x
mul_pp r3.z, r3, r3.x
cmp r2.z, -r3, r2.w, r2
add r3.x, -r3.y, c10
add r2.w, -r2.z, r3.x
cmp r2.w, r2, c10.z, c10.x
cmp r1.x, r2, c10.z, c10
mul_pp r1.x, r1, r2.w
cmp r3.z, -r1.x, r2, r3.x
add r1.y, -r3.z, r3.w
dp3_pp r1.x, v1, v1
rsq_pp r2.w, r1.x
mov_pp r1.x, c9
mul_pp r1.x, c6, r1
mad_pp r4.y, r0.w, c6.x, -r1.x
add r0.w, r0, -r1.z
mul_pp r2.xyz, r2.w, v1
cmp r4.x, r1.y, c10.z, c10
add r1.y, r2.z, c9
rcp r1.y, r1.y
mul r3.xy, r2, r1.y
mad r1.xy, r4.y, r3, v0.zwzw
texld r1.yw, r1, s2
mad_pp r1.xy, r1.wyzw, c9.z, c9.w
cmp r0.w, r0, c10.z, c10.x
mul_pp r1.z, r0.w, r4.x
mul_pp r0.w, r1.y, r1.y
cmp r2.x, -r1.z, r3.z, r3.w
mad_pp r0.w, -r1.x, r1.x, -r0
add_pp r1.z, r0.w, c10.x
mov r1.w, c7.x
add r0.w, c10.x, -r1
mad r0.w, r0, r2.x, c7.x
mad_pp r2.xyz, r2.w, v1, r0
dp3_pp r1.w, r2, r2
rsq_pp r1.z, r1.z
rcp_pp r1.z, r1.z
mul r1.z, r1, r0.w
dp3 r2.w, r1, r0
rsq_pp r1.w, r1.w
mul_pp r0.xyz, r1.w, r2
dp3 r0.x, r1, r0
max r1.w, r2, c10.z
mul r2.x, r0.w, r1.w
max r0.w, r0.x, c10.z
mad r0.xy, r4.y, r3, v0
mov_pp r0.z, c5.x
mul_pp r2.y, c10.w, r0.z
texld r1, r0, s1
pow r3, r0.w, r2.y
mul_pp r0.xyz, r1, c4
mov r1.x, r3
mul r2.w, r1.x, r1
mul_pp r0.xyz, r0, c1
mul_pp r2.xyz, r0, r2.x
add r0.xyz, v4, c11.xyyw
texld r0, r0, s3
dp4 r3.w, r0, c12
add r0.xyz, v4, c11.yxyw
texld r0, r0, s3
dp4 r3.z, r0, c12
add r1.xyz, v4, c11.yyxw
texld r1, r1, s3
dp4 r3.y, r1, c12
add r0.xyz, v4, c11.x
texld r0, r0, s3
dp3 r1.x, v4, v4
rsq r1.x, r1.x
dp4 r3.x, r0, c12
rcp r0.x, r1.x
mul r0.x, r0, c0.w
mad r0, -r0.x, c11.z, r3
mov r1.x, c3
cmp r1, r0, c10.x, r1.x
dp3 r0.x, v3, v3
dp4_pp r0.y, r1, c11.w
texld r0.x, r0.x, s4
mul r0.w, r0.x, r0.y
mov_pp r0.xyz, c1
mul_pp r0.xyz, c2, r0
mul_pp r0.w, r0, c9.z
mad r0.xyz, r0, r2.w, r2
mul oC0.xyz, r0, r0.w
mov_pp oC0.w, c10.z
"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Vector 0 [_LightPositionRange]
Vector 1 [_LightColor0]
Vector 2 [_SpecColor]
Vector 3 [_LightShadowData]
Vector 4 [_Color]
Float 5 [_Shininess]
Float 6 [_Parallax]
Float 7 [_ShadingStrength]
Float 8 [_ShadeRange]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_ShadowMapTexture] CUBE
SetTexture 4 [_LightTextureB0] 2D
SetTexture 5 [_LightTexture0] CUBE
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 139 ALU, 16 TEX
PARAM c[13] = { program.local[0..8],
		{ 0, 0.5, 0.41999999, 2 },
		{ 1, 0.14285715, 128, 0.97000003 },
		{ 0.0078125, -0.0078125, 0.25 },
		{ 1, 0.0039215689, 1.53787e-005, 6.2273724e-009 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MOV R0.x, c[6];
DP3 R0.y, fragment.texcoord[2], fragment.texcoord[2];
ADD R0.w, R0.x, c[8].x;
RSQ R0.y, R0.y;
MUL R0.xyz, R0.y, fragment.texcoord[2];
MUL R1.xyz, -R0, R0.w;
MAD R3.xy, -R1, c[10].y, fragment.texcoord[0].zwzw;
MAD R2.zw, -R1.xyxy, c[10].y, R3.xyxy;
MAD R2.xy, -R1, c[10].y, R2.zwzw;
TEX R3.w, R3, texture[0], 2D;
TEX R0.w, fragment.texcoord[0].zwzw, texture[0], 2D;
TEX R1.w, R2, texture[0], 2D;
TEX R2.w, R2.zwzw, texture[0], 2D;
ADD R3.x, -R0.w, R3.w;
ADD R2.z, R1, R2.w;
ADD R3.x, -R3, c[10];
ADD R3.y, R1.z, R3.w;
SLT R3.y, R0.w, R3;
SLT R3.z, R3.x, c[10].x;
MUL R3.z, R3.y, R3;
ADD R3.y, -R0.w, R2.w;
CMP R2.w, -R3.z, R3.x, c[10].x;
ADD R3.x, -R3.y, c[10];
SLT R3.y, R3.x, R2.w;
SLT R2.z, R0.w, R2;
MUL R3.y, R2.z, R3;
CMP R2.w, -R3.y, R3.x, R2;
ADD R2.z, -R0.w, R1.w;
ADD R2.z, -R2, c[10].x;
ADD R3.y, R1.z, R1.w;
MAD R2.xy, -R1, c[10].y, R2;
TEX R1.w, R2, texture[0], 2D;
SLT R3.x, R2.z, R2.w;
SLT R3.y, R0.w, R3;
MUL R3.y, R3, R3.x;
CMP R2.w, -R3.y, R2.z, R2;
ADD R3.x, -R0.w, R1.w;
ADD R2.z, -R3.x, c[10].x;
ADD R3.y, R1.z, R1.w;
MAD R2.xy, -R1, c[10].y, R2;
TEX R1.w, R2, texture[0], 2D;
MAD R2.xy, -R1, c[10].y, R2;
MAD R1.xy, -R1, c[10].y, R2;
SLT R3.x, R2.z, R2.w;
SLT R3.y, R0.w, R3;
MUL R3.y, R3, R3.x;
CMP R2.w, -R3.y, R2.z, R2;
ADD R3.x, -R0.w, R1.w;
ADD R3.y, R1.z, R1.w;
ADD R2.z, -R3.x, c[10].x;
SLT R3.x, R2.z, R2.w;
SLT R3.y, R0.w, R3;
MUL R3.y, R3, R3.x;
TEX R1.w, R2, texture[0], 2D;
ADD R3.x, -R0.w, R1.w;
CMP R2.w, -R3.y, R2.z, R2;
ADD R2.z, -R3.x, c[10].x;
ADD R1.w, R1.z, R1;
SLT R3.x, R2.z, R2.w;
SLT R1.w, R0, R1;
MUL R2.x, R1.w, R3;
TEX R1.w, R1, texture[0], 2D;
ADD R1.y, -R0.w, R1.w;
ADD R1.z, R1.w, R1;
CMP R3.y, -R2.x, R2.z, R2.w;
ADD R3.x, -R1.y, c[10];
DP3 R1.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R2.w, R1.x;
MUL R2.xyz, R2.w, fragment.texcoord[1];
ADD R1.y, R2.z, c[9].z;
RCP R1.y, R1.y;
MOV R1.x, c[6];
MUL R1.x, R1, c[9].y;
MAD R2.z, R0.w, c[6].x, -R1.x;
MUL R2.xy, R2, R1.y;
MAD R1.xy, R2.z, R2, fragment.texcoord[0].zwzw;
MOV R4.xy, c[10].xzzw;
TEX R1.yw, R1, texture[2], 2D;
MAD R1.xy, R1.wyzw, c[9].w, -R4.x;
SLT R1.z, R0.w, R1;
SLT R3.z, R3.x, R3.y;
MUL R1.z, R1, R3;
CMP R1.w, -R1.z, R3.x, R3.y;
MUL R0.w, R1.y, R1.y;
MAD R0.w, -R1.x, R1.x, -R0;
ADD R0.w, R0, c[10].x;
RSQ R1.z, R0.w;
MOV R4.x, c[10];
ADD R0.w, R4.x, -c[7].x;
MAD R0.w, R0, R1, c[7].x;
RCP R1.z, R1.z;
MUL R1.z, R1, R0.w;
DP3 R1.w, R1, R0;
MAX R1.w, R1, c[9].x;
MUL R0.w, R0, R1;
MAD R0.xyz, R2.w, fragment.texcoord[1], R0;
DP3 R1.w, R0, R0;
RSQ R1.w, R1.w;
MUL R0.xyz, R1.w, R0;
DP3 R1.x, R1, R0;
MAX R4.z, R1.x, c[9].x;
MAD R2.xy, R2.z, R2, fragment.texcoord[0];
TEX R2, R2, texture[1], 2D;
MUL R2.xyz, R2, c[4];
MUL R2.xyz, R2, c[1];
ADD R1.xyz, fragment.texcoord[4], c[11].yyxw;
ADD R3.xyz, fragment.texcoord[4], c[11].xyyw;
MUL R2.xyz, R2, R0.w;
TEX R0, R3, texture[3], CUBE;
TEX R1, R1, texture[3], CUBE;
DP4 R3.w, R0, c[12];
DP4 R3.y, R1, c[12];
ADD R0.xyz, fragment.texcoord[4], c[11].yxyw;
TEX R0, R0, texture[3], CUBE;
DP4 R3.z, R0, c[12];
ADD R0.xyz, fragment.texcoord[4], c[11].x;
TEX R0, R0, texture[3], CUBE;
DP3 R1.x, fragment.texcoord[4], fragment.texcoord[4];
RSQ R1.x, R1.x;
DP4 R3.x, R0, c[12];
RCP R0.x, R1.x;
MUL R1.x, R4.y, c[5];
MUL R0.x, R0, c[0].w;
MAD R0, -R0.x, c[10].w, R3;
CMP R0, R0, c[3].x, R4.x;
DP4 R0.y, R0, c[11].z;
DP3 R0.x, fragment.texcoord[3], fragment.texcoord[3];
POW R1.x, R4.z, R1.x;
TEX R0.w, fragment.texcoord[3], texture[5], CUBE;
TEX R1.w, R0.x, texture[4], 2D;
MUL R0.x, R1.w, R0.w;
MUL R0.w, R0.x, R0.y;
MOV R0.xyz, c[2];
MUL R1.x, R1, R2.w;
MUL R0.xyz, R0, c[1];
MUL R0.w, R0, c[9];
MAD R0.xyz, R0, R1.x, R2;
MUL result.color.xyz, R0, R0.w;
MOV result.color.w, c[9].x;
END
# 139 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Vector 0 [_LightPositionRange]
Vector 1 [_LightColor0]
Vector 2 [_SpecColor]
Vector 3 [_LightShadowData]
Vector 4 [_Color]
Float 5 [_Shininess]
Float 6 [_Parallax]
Float 7 [_ShadingStrength]
Float 8 [_ShadeRange]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_ShadowMapTexture] CUBE
SetTexture 4 [_LightTextureB0] 2D
SetTexture 5 [_LightTexture0] CUBE
"ps_3_0
; 140 ALU, 16 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_cube s3
dcl_2d s4
dcl_cube s5
def c9, 0.50000000, 0.41999999, 2.00000000, -1.00000000
def c10, 1.00000000, 0.14285715, 0.00000000, 128.00000000
def c11, 0.00781250, -0.00781250, 0.97000003, 0.25000000
def c12, 1.00000000, 0.00392157, 0.00001538, 0.00000001
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
mov r0.y, c8.x
dp3_pp r0.x, v2, v2
add r0.w, c6.x, r0.y
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, v2
mul r1.xyz, -r0, r0.w
mad r3.xy, -r1, c10.y, v0.zwzw
mad r4.xy, -r1, c10.y, r3
texld r2.w, r3, s0
mad r2.xy, -r1, c10.y, r4
texld r3.w, r4, s0
texld r0.w, v0.zwzw, s0
texld r1.w, r2, s0
add r2.z, r1, r3.w
add r3.x, -r0.w, r3.w
add r3.y, r1.z, r2.w
add r2.z, r0.w, -r2
add r3.z, -r0.w, r1.w
add r3.w, -r0, r2
add r3.y, r0.w, -r3
cmp r2.w, r3.y, c10.z, c10.x
cmp r3.y, -r3.w, c10.z, c10.x
mul_pp r2.w, r2, r3.y
add r3.w, -r3, c10.x
cmp r2.w, -r2, c10.x, r3
add r3.x, -r3, c10
add r3.y, -r2.w, r3.x
mad r2.xy, -r1, c10.y, r2
cmp r2.z, r2, c10, c10.x
cmp r3.y, r3, c10.z, c10.x
mul_pp r3.y, r2.z, r3
cmp r3.x, -r3.y, r2.w, r3
add r2.z, -r3, c10.x
add r3.y, r1.z, r1.w
texld r1.w, r2, s0
add r3.z, r0.w, -r3.y
add r2.w, -r3.x, r2.z
add r3.y, -r0.w, r1.w
mad r2.xy, -r1, c10.y, r2
cmp r2.w, r2, c10.z, c10.x
cmp r3.z, r3, c10, c10.x
mul_pp r3.z, r3, r2.w
add r2.w, -r3.y, c10.x
cmp r3.x, -r3.z, r3, r2.z
add r3.y, r1.z, r1.w
texld r1.w, r2, s0
add r3.z, r0.w, -r3.y
mad r2.xy, -r1, c10.y, r2
add r2.z, -r3.x, r2.w
mad r1.xy, -r1, c10.y, r2
add r3.y, -r0.w, r1.w
cmp r2.z, r2, c10, c10.x
cmp r3.z, r3, c10, c10.x
mul_pp r3.z, r3, r2
add r2.z, -r3.y, c10.x
cmp r2.w, -r3.z, r3.x, r2
add r3.y, r1.z, r1.w
add r3.x, -r2.w, r2.z
add r3.z, r0.w, -r3.y
texld r1.w, r2, s0
add r3.y, -r0.w, r1.w
cmp r3.x, r3, c10.z, c10
cmp r3.z, r3, c10, c10.x
mul_pp r3.z, r3, r3.x
cmp r2.z, -r3, r2.w, r2
add r3.x, -r3.y, c10
add r2.w, r1.z, r1
add r3.y, -r2.z, r3.x
add r2.w, r0, -r2
cmp r1.w, r3.y, c10.z, c10.x
cmp r2.x, r2.w, c10.z, c10
mul_pp r2.x, r2, r1.w
texld r1.w, r1, s0
add r1.y, -r0.w, r1.w
dp3_pp r1.x, v1, v1
cmp r3.x, -r2, r2.z, r3
rsq_pp r2.w, r1.x
add r3.y, -r1, c10.x
add r1.x, -r3, r3.y
mul_pp r2.xyz, r2.w, v1
cmp r3.z, r1.x, c10, c10.x
add r1.y, r2.z, c9
rcp r1.y, r1.y
mov_pp r1.x, c9
mul_pp r1.x, c6, r1
mad_pp r2.z, r0.w, c6.x, -r1.x
mul r2.xy, r2, r1.y
mad r1.xy, r2.z, r2, v0.zwzw
add r1.z, r1.w, r1
add r0.w, r0, -r1.z
texld r1.yw, r1, s2
cmp r1.z, r0.w, c10, c10.x
mad_pp r1.xy, r1.wyzw, c9.z, c9.w
mul_pp r1.z, r1, r3
cmp r1.w, -r1.z, r3.x, r3.y
mul_pp r0.w, r1.y, r1.y
mad_pp r0.w, -r1.x, r1.x, -r0
add_pp r0.w, r0, c10.x
mov r1.z, c7.x
add r1.z, c10.x, -r1
rsq_pp r0.w, r0.w
mad r1.w, r1.z, r1, c7.x
rcp_pp r0.w, r0.w
mul r1.z, r0.w, r1.w
dp3 r0.w, r1, r0
max r0.w, r0, c10.z
mul r0.w, r1, r0
mad_pp r0.xyz, r2.w, v1, r0
dp3_pp r1.w, r0, r0
rsq_pp r1.w, r1.w
mul_pp r0.xyz, r1.w, r0
dp3 r0.x, r1, r0
mad r2.xy, r2.z, r2, v0
texld r2, r2, s1
mul_pp r2.xyz, r2, c4
mul_pp r2.xyz, r2, c1
mul_pp r2.xyz, r2, r0.w
mov_pp r0.w, c5.x
mul_pp r0.y, c10.w, r0.w
max r0.x, r0, c10.z
pow r1, r0.x, r0.y
mov r4.x, r1
add r0.xyz, v4, c11.xyyw
texld r0, r0, s3
dp4 r3.w, r0, c12
add r0.xyz, v4, c11.yxyw
texld r0, r0, s3
dp4 r3.z, r0, c12
add r1.xyz, v4, c11.yyxw
texld r1, r1, s3
dp4 r3.y, r1, c12
add r0.xyz, v4, c11.x
texld r0, r0, s3
dp3 r1.x, v4, v4
rsq r1.x, r1.x
dp4 r3.x, r0, c12
rcp r0.x, r1.x
mul r0.x, r0, c0.w
mov r1.x, c3
mad r0, -r0.x, c11.z, r3
cmp r0, r0, c10.x, r1.x
dp4_pp r0.y, r0, c11.w
dp3 r0.x, v3, v3
texld r0.w, v3, s5
texld r0.x, r0.x, s4
mul r0.x, r0, r0.w
mul r0.w, r0.x, r0.y
mov_pp r0.xyz, c1
mul r1.x, r4, r2.w
mul_pp r0.xyz, c2, r0
mul_pp r0.w, r0, c9.z
mad r0.xyz, r0, r1.x, r2
mul oC0.xyz, r0, r0.w
mov_pp oC0.w, c10.z
"
}
}
 }
}
Fallback "Parallax Specular"
}