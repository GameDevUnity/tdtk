Shader "Chickenlord/Relief Mapping Shaded Specular" {
Properties {
 _Color ("Main Color", Color) = (1,1,1,1)
 _SpecColor ("Specular Color", Color) = (0.5,0.5,0.5,1)
 _Shininess ("Shininess", Range(0.01,1)) = 0.078125
 _Parallax ("Height", Range(0.005,0.18)) = 0.02
 _MainTex ("Base (RGB) Gloss (A)", 2D) = "white" {}
 _BumpMap ("Normalmap", 2D) = "bump" {}
 _ParallaxMap ("Heightmap (A)", 2D) = "black" {}
 _ShadeRange ("Shading Range", Float) = 0.02
 _ShadingStrength ("Shading Strength", Range(0,1)) = 1
 _AlphaCutRange ("Alpha Cut Range", Float) = 1
 _UseAlpha ("Use Alpha", Range(0,1)) = 1
}
SubShader { 
 LOD 600
 Tags { "QUEUE"="Transparent-15" "IGNOREPROJECTOR"="True" "RenderType"="Transparent" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "QUEUE"="Transparent-15" "IGNOREPROJECTOR"="True" "RenderType"="Transparent" }
  ZWrite Off
  Blend SrcAlpha OneMinusSrcAlpha
  AlphaTest Greater 0
  ColorMask RGB
Program "vp" {
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" }
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
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "VERTEXLIGHT_ON" }
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
}
Program "fp" {
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_Parallax]
Float 5 [_ShadingStrength]
Float 6 [_ShadeRange]
Float 7 [_AlphaCutRange]
Float 8 [_UseAlpha]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_BumpMap] 2D
"ps_3_0
; 147 ALU, 11 TEX, 10 FLOW
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c9, 1.00000000, 40.00000000, 0.00000000, 0.50000000
defi i0, 40, 0, 1, 0
def c10, 2.00000000, -1.00000000, 0.06250000, 128.00000000
defi i1, 15, 1, 1, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dp3 r0.x, v1, v1
rsq r0.x, r0.x
mul r0.xyz, r0.x, v1
dp3 r1.y, -r0, -r0
add r0.w, -r0.z, c9.x
mul r1.x, r0.w, r0.w
mad r0.w, -r1.x, r0, c9.x
mul r1.x, r0.z, c9.y
rsq r1.y, r1.y
mul r0.xy, r1.y, -r0
mul r0.w, r0, c4.x
mul r0.xy, r0, r0.w
abs r0.z, r0
rcp r0.w, r1.x
mul r1.xyz, r0, r0.w
mov r0.xy, v0.zwzw
mov r0.z, c9
loop aL, i0
texld r0.w, r0, s0
add r2.xyz, r0, r1
add r0.w, r0.z, -r0
cmp r0.xyz, r0.w, r0, r2
endloop
mul r1.xyz, r1, c9.w
add r3.xyz, r0, r1
add r2.xyz, r0, -r1
texld r0.w, r0, s0
add_pp r0.x, r0.z, -r0.w
cmp r0.xyz, r0.x, r2, r3
texld r0.w, r0, s0
add r1.w, r0.z, -r0
mul r1.xyz, r1, c9.w
add r2.xyz, r0, r1
add r0.w, r0.z, -r0
cmp r0.xyz, r0.w, r0, r2
add r2.xyz, r0, -r1
cmp r0.w, r1, c9.z, c9.x
abs_pp r0.w, r0
cmp r0.xyz, -r0.w, r2, r0
texld r0.w, r0, s0
add r1.w, r0.z, -r0
mul r1.xyz, r1, c9.w
add r2.xyz, r0, r1
add r0.w, r0.z, -r0
cmp r0.xyz, r0.w, r0, r2
add r2.xyz, r0, -r1
cmp r0.w, r1, c9.z, c9.x
abs_pp r0.w, r0
cmp r0.xyz, -r0.w, r2, r0
texld r0.w, r0, s0
add r1.w, r0.z, -r0
mul r1.xyz, r1, c9.w
add r2.xyz, r0, r1
add r0.w, r0.z, -r0
cmp r0.xyz, r0.w, r0, r2
add r2.xyz, r0, -r1
cmp r0.w, r1, c9.z, c9.x
abs_pp r0.w, r0
cmp r0.xyz, -r0.w, r2, r0
mul r1.xyz, r1, c9.w
texld r0.w, r0, s0
add r1.w, r0.z, -r0
add r2.xyz, r0, r1
add r0.w, r0.z, -r0
cmp r0.xyz, r0.w, r0, r2
cmp r0.w, r1, c9.z, c9.x
add r2.xyz, r0, -r1
abs_pp r0.w, r0
cmp r0.xyz, -r0.w, r2, r0
texld r0.w, r0, s0
add r1.z, r0, -r0.w
mad r2.xy, r1, c9.w, r0
add r0.z, r0, -r0.w
cmp r0.zw, r0.z, r0.xyxy, r2.xyxy
cmp r0.x, r1.z, c9.z, c9
mad r1.xy, -r1, c9.w, r0.zwzw
abs_pp r0.x, r0
cmp r4.xy, -r0.x, r1, r0.zwzw
add r0.xy, -v0.zwzw, r4
add r0.xy, v0, r0
rcp r0.z, c7.x
mul r0.w, r0.x, r0.z
cmp r1.y, r0.w, c9.z, c9.x
mad r1.x, -r0.y, r0.z, c9
mad r0.w, -r0.x, r0.z, c9.x
mul r0.z, r0.y, r0
cmp r1.x, r1, c9.z, c9
cmp r0.w, r0, c9.z, c9.x
add_pp_sat r0.w, r0, r1.x
add_pp_sat r0.w, r0, r1.y
texld r1.yw, r4, s2
mad_pp r1.xy, r1.wyzw, c10.x, c10.y
mov r1.w, c6.x
add r2.x, c4, r1.w
cmp r0.z, r0, c9, c9.x
add_pp_sat r0.z, r0.w, r0
mul_pp r0.w, r1.y, r1.y
abs_pp r0.z, r0
cmp_pp r0.z, -r0, c9.x, c9
mad_pp r0.w, -r1.x, r1.x, -r0
add_pp r0.w, r0, c9.x
rsq_pp r1.z, r0.w
add_pp r3.w, r0.z, c8.x
texld r0, r0, s1
mov_pp r2.w, r0
texld r0.w, r4, s0
mul r2.xyz, -v2, r2.x
mul r2.xyz, r0.w, r2
dp3_pp r3.x, v1, v1
add r1.w, -r0, c9.x
rsq_pp r0.w, r3.x
mul r3.xyz, r2, c10.z
rcp_pp r1.z, r1.z
mul_pp r0.xyz, r0, c2
mul_pp r2.xyz, r0.w, v1
mov_pp r4.z, c9.x
mov r4.w, c9.x
loop aL, i1
add r4.xy, r4, -r3
texld r0.w, r4, s0
add r5.x, -r0.w, c9
add_pp r0.w, r5.x, -r1
mad r5.x, r3.z, r4.w, r5
add_pp r0.w, -r0, c9.x
add_pp r5.y, -r4.z, r0.w
add r5.x, r5, -r1.w
cmp_pp r5.y, r5, c9.z, c9.x
cmp r5.x, r5, c9, c9.z
mul_pp r5.x, r5, r5.y
cmp_pp r4.z, -r5.x, r4, r0.w
add r4.w, r4, c9.x
endloop
add r2.xyz, v2, r2
dp3 r1.w, r2, r2
rsq r1.w, r1.w
mul r3.xyz, r1.w, r2
mov r2.xy, r1
mov r0.w, c5.x
add r0.w, c9.x, -r0
mad r0.w, r0, r4.z, c5.x
mul r2.z, r0.w, r1
dp3 r1.x, r2, r3
mov_pp r1.y, c3.x
mul_pp r3.y, c10.w, r1
max r3.x, r1, c9.z
pow r1, r3.x, r3.y
dp3 r1.y, r2, v2
mul r1.x, r0.w, r1
mul r1.w, r1.x, r2
max r1.y, r1, c9.z
mul r2.w, r0, r1.y
mov_pp r1.xyz, c0
mul_pp r2.xyz, r0, c0
mul_pp r2.xyz, r2, r2.w
mul_pp r1.xyz, c1, r1
mad r1.xyz, r1, r1.w, r2
mul r1.xyz, r0.w, r1
mul r1.xyz, r1, c10.x
mad_pp oC0.xyz, r0, v3, r1
mov_pp oC0.w, r3
"
}
}
 }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardAdd" "QUEUE"="Transparent-15" "IGNOREPROJECTOR"="True" "RenderType"="Transparent" }
  ZWrite Off
  Fog {
   Color (0,0,0,0)
  }
  Blend SrcAlpha One
  AlphaTest Greater 0
  ColorMask RGB
Program "vp" {
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
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" }
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
}
Program "fp" {
SubProgram "d3d9 " {
Keywords { "POINT" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_Parallax]
Float 5 [_ShadingStrength]
Float 6 [_ShadeRange]
Float 7 [_AlphaCutRange]
Float 8 [_UseAlpha]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_LightTexture0] 2D
"ps_3_0
; 151 ALU, 12 TEX, 10 FLOW
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c9, 1.00000000, 40.00000000, 0.00000000, 0.50000000
defi i0, 40, 0, 1, 0
def c10, 2.00000000, -1.00000000, 0.06250000, 128.00000000
defi i1, 15, 1, 1, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dp3 r0.x, v1, v1
rsq r0.x, r0.x
mul r0.xyz, r0.x, v1
dp3 r1.y, -r0, -r0
add r0.w, -r0.z, c9.x
mul r1.x, r0.w, r0.w
mad r0.w, -r1.x, r0, c9.x
mul r1.x, r0.z, c9.y
rsq r1.y, r1.y
mul r0.xy, r1.y, -r0
mul r0.w, r0, c4.x
mul r0.xy, r0, r0.w
abs r0.z, r0
rcp r0.w, r1.x
mul r1.xyz, r0, r0.w
mov r0.xy, v0.zwzw
mov r0.z, c9
loop aL, i0
texld r0.w, r0, s0
add r2.xyz, r0, r1
add r0.w, r0.z, -r0
cmp r0.xyz, r0.w, r0, r2
endloop
mul r1.xyz, r1, c9.w
add r2.xyz, r0, -r1
add r3.xyz, r0, r1
texld r0.w, r0, s0
add_pp r0.x, r0.z, -r0.w
cmp r0.xyz, r0.x, r2, r3
texld r0.w, r0, s0
add r1.w, r0.z, -r0
mul r1.xyz, r1, c9.w
add r2.xyz, r0, r1
add r0.w, r0.z, -r0
cmp r2.xyz, r0.w, r0, r2
add r3.xyz, r2, -r1
cmp r0.x, r1.w, c9.z, c9
abs_pp r0.x, r0
cmp r0.xyz, -r0.x, r3, r2
texld r0.w, r0, s0
add r1.w, r0.z, -r0
mul r1.xyz, r1, c9.w
add r2.xyz, r0, r1
add r0.w, r0.z, -r0
cmp r2.xyz, r0.w, r0, r2
add r3.xyz, r2, -r1
cmp r0.x, r1.w, c9.z, c9
abs_pp r0.x, r0
cmp r0.xyz, -r0.x, r3, r2
texld r0.w, r0, s0
add r1.w, r0.z, -r0
mul r1.xyz, r1, c9.w
add r2.xyz, r0, r1
add r0.w, r0.z, -r0
cmp r2.xyz, r0.w, r0, r2
add r3.xyz, r2, -r1
cmp r0.x, r1.w, c9.z, c9
abs_pp r0.x, r0
cmp r0.xyz, -r0.x, r3, r2
mul r1.xyz, r1, c9.w
texld r0.w, r0, s0
add r1.w, r0.z, -r0
add r2.xyz, r0, r1
add r0.w, r0.z, -r0
cmp r2.xyz, r0.w, r0, r2
cmp r0.x, r1.w, c9.z, c9
add r3.xyz, r2, -r1
abs_pp r0.x, r0
cmp r0.xyz, -r0.x, r3, r2
texld r0.w, r0, s0
add r1.z, r0, -r0.w
mad r2.xy, r1, c9.w, r0
add r0.z, r0, -r0.w
cmp r0.zw, r0.z, r0.xyxy, r2.xyxy
cmp r0.x, r1.z, c9.z, c9
mad r1.xy, -r1, c9.w, r0.zwzw
abs_pp r0.x, r0
cmp r6.xy, -r0.x, r1, r0.zwzw
add r0.xy, -v0.zwzw, r6
add r0.xy, v0, r0
rcp r0.z, c7.x
mul r0.w, r0.x, r0.z
cmp r1.y, r0.w, c9.z, c9.x
mad r1.x, -r0.y, r0.z, c9
mad r0.w, -r0.x, r0.z, c9.x
mul r0.z, r0.y, r0
cmp r1.x, r1, c9.z, c9
cmp r0.w, r0, c9.z, c9.x
add_pp_sat r0.w, r0, r1.x
add_pp_sat r0.w, r0, r1.y
texld r1.yw, r6, s2
cmp r0.z, r0, c9, c9.x
add_pp_sat r0.z, r0.w, r0
mad_pp r2.xy, r1.wyzw, c10.x, c10.y
mul_pp r0.w, r2.y, r2.y
abs_pp r0.z, r0
cmp_pp r0.z, -r0, c9.x, c9
mad_pp r0.w, -r2.x, r2.x, -r0
add_pp r0.w, r0, c9.x
rsq_pp r1.x, r0.w
add_pp r2.w, r0.z, c8.x
texld r0, r0, s1
rcp_pp r2.z, r1.x
mul_pp r1.xyz, r0, c2
mov_pp r1.w, r0
texld r0.w, r6, s0
dp3_pp r0.x, v2, v2
rsq_pp r0.x, r0.x
mov r0.y, c6.x
add r0.y, c4.x, r0
mul_pp r3.xyz, r0.x, v2
mul r0.xyz, -r3, r0.y
mul r0.xyz, r0.w, r0
mul r4.xyz, r0, c10.z
dp3_pp r0.y, v1, v1
dp3 r0.x, v3, v3
texld r0.x, r0.x, s3
rsq_pp r0.y, r0.y
mov_pp r3.w, r0.x
add r4.w, -r0, c9.x
mul_pp r5.xyz, r0.y, v1
mov_pp r5.w, c9.x
mov r0.x, c9
loop aL, i1
add r6.xy, r6, -r4
texld r0.w, r6, s0
add r0.z, -r0.w, c9.x
add_pp r0.y, r0.z, -r4.w
mad r0.z, r4, r0.x, r0
add_pp r0.y, -r0, c9.x
add_pp r0.w, -r5, r0.y
add r0.z, r0, -r4.w
cmp_pp r0.w, r0, c9.z, c9.x
cmp r0.z, r0, c9.x, c9
mul_pp r0.z, r0, r0.w
cmp_pp r5.w, -r0.z, r5, r0.y
add r0.x, r0, c9
endloop
add r0.xyz, r3, r5
dp3 r4.x, r0, r0
rsq r4.y, r4.x
mov r0.w, c5.x
add r0.w, c9.x, -r0
mad r4.x, r0.w, r5.w, c5
mov_pp r0.w, c3.x
mul r0.xyz, r4.y, r0
mul r2.z, r4.x, r2
dp3 r0.x, r2, r0
mul_pp r4.z, c10.w, r0.w
max r4.y, r0.x, c9.z
pow r0, r4.y, r4.z
mul r0.x, r4, r0
dp3 r0.y, r2, r3
mul r0.w, r0.x, r1
max r0.y, r0, c9.z
mul r1.w, r4.x, r0.y
mov_pp r0.xyz, c0
mul_pp r1.xyz, r1, c0
mul_pp r1.xyz, r1, r1.w
mul_pp r0.xyz, c1, r0
mad r0.xyz, r0, r0.w, r1
mul_pp r0.w, r3, c10.x
mul r0.xyz, r4.x, r0
mul oC0.xyz, r0, r0.w
mov_pp oC0.w, r2
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_Parallax]
Float 5 [_ShadingStrength]
Float 6 [_ShadeRange]
Float 7 [_AlphaCutRange]
Float 8 [_UseAlpha]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_BumpMap] 2D
"ps_3_0
; 146 ALU, 11 TEX, 10 FLOW
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c9, 1.00000000, 40.00000000, 0.00000000, 0.50000000
defi i0, 40, 0, 1, 0
def c10, 2.00000000, -1.00000000, 0.06250000, 128.00000000
defi i1, 15, 1, 1, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dp3 r0.x, v1, v1
rsq r0.x, r0.x
mul r0.xyz, r0.x, v1
dp3 r1.y, -r0, -r0
add r0.w, -r0.z, c9.x
mul r1.x, r0.w, r0.w
mad r0.w, -r1.x, r0, c9.x
mul r1.x, r0.z, c9.y
rsq r1.y, r1.y
mul r0.xy, r1.y, -r0
mul r0.w, r0, c4.x
mul r0.xy, r0, r0.w
abs r0.z, r0
rcp r0.w, r1.x
mul r1.xyz, r0, r0.w
mov r0.xy, v0.zwzw
mov r0.z, c9
loop aL, i0
texld r0.w, r0, s0
add r2.xyz, r0, r1
add r0.w, r0.z, -r0
cmp r0.xyz, r0.w, r0, r2
endloop
mul r1.xyz, r1, c9.w
add r3.xyz, r0, r1
add r2.xyz, r0, -r1
texld r0.w, r0, s0
add_pp r0.x, r0.z, -r0.w
cmp r0.xyz, r0.x, r2, r3
texld r0.w, r0, s0
add r1.w, r0.z, -r0
mul r1.xyz, r1, c9.w
add r2.xyz, r0, r1
add r0.w, r0.z, -r0
cmp r0.xyz, r0.w, r0, r2
add r2.xyz, r0, -r1
cmp r0.w, r1, c9.z, c9.x
abs_pp r0.w, r0
cmp r0.xyz, -r0.w, r2, r0
texld r0.w, r0, s0
add r1.w, r0.z, -r0
mul r1.xyz, r1, c9.w
add r2.xyz, r0, r1
add r0.w, r0.z, -r0
cmp r0.xyz, r0.w, r0, r2
add r2.xyz, r0, -r1
cmp r0.w, r1, c9.z, c9.x
abs_pp r0.w, r0
cmp r0.xyz, -r0.w, r2, r0
texld r0.w, r0, s0
add r1.w, r0.z, -r0
mul r1.xyz, r1, c9.w
add r2.xyz, r0, r1
add r0.w, r0.z, -r0
cmp r0.xyz, r0.w, r0, r2
add r2.xyz, r0, -r1
cmp r0.w, r1, c9.z, c9.x
abs_pp r0.w, r0
cmp r0.xyz, -r0.w, r2, r0
mul r1.xyz, r1, c9.w
texld r0.w, r0, s0
add r1.w, r0.z, -r0
add r2.xyz, r0, r1
add r0.w, r0.z, -r0
cmp r0.xyz, r0.w, r0, r2
cmp r0.w, r1, c9.z, c9.x
add r2.xyz, r0, -r1
abs_pp r0.w, r0
cmp r0.xyz, -r0.w, r2, r0
texld r0.w, r0, s0
add r1.z, r0, -r0.w
mad r2.xy, r1, c9.w, r0
add r0.z, r0, -r0.w
cmp r0.zw, r0.z, r0.xyxy, r2.xyxy
cmp r0.x, r1.z, c9.z, c9
mad r1.xy, -r1, c9.w, r0.zwzw
abs_pp r0.x, r0
cmp r4.xy, -r0.x, r1, r0.zwzw
add r0.xy, -v0.zwzw, r4
add r0.xy, v0, r0
rcp r0.z, c7.x
mul r0.w, r0.x, r0.z
cmp r1.y, r0.w, c9.z, c9.x
mad r1.x, -r0.y, r0.z, c9
mad r0.w, -r0.x, r0.z, c9.x
mul r0.z, r0.y, r0
cmp r1.x, r1, c9.z, c9
cmp r0.w, r0, c9.z, c9.x
add_pp_sat r0.w, r0, r1.x
add_pp_sat r0.w, r0, r1.y
texld r1.yw, r4, s2
mad_pp r1.xy, r1.wyzw, c10.x, c10.y
mov r1.w, c6.x
add r2.x, c4, r1.w
cmp r0.z, r0, c9, c9.x
add_pp_sat r0.z, r0.w, r0
mul_pp r0.w, r1.y, r1.y
abs_pp r0.z, r0
cmp_pp r0.z, -r0, c9.x, c9
mad_pp r0.w, -r1.x, r1.x, -r0
add_pp r0.w, r0, c9.x
rsq_pp r1.z, r0.w
add_pp r3.w, r0.z, c8.x
texld r0, r0, s1
mov_pp r2.w, r0
texld r0.w, r4, s0
mul r2.xyz, -v2, r2.x
mul r2.xyz, r0.w, r2
dp3_pp r3.x, v1, v1
add r1.w, -r0, c9.x
rsq_pp r0.w, r3.x
mul r3.xyz, r2, c10.z
rcp_pp r1.z, r1.z
mul_pp r0.xyz, r0, c2
mul_pp r2.xyz, r0.w, v1
mov_pp r4.z, c9.x
mov r4.w, c9.x
loop aL, i1
add r4.xy, r4, -r3
texld r0.w, r4, s0
add r5.x, -r0.w, c9
add_pp r0.w, r5.x, -r1
mad r5.x, r3.z, r4.w, r5
add_pp r0.w, -r0, c9.x
add_pp r5.y, -r4.z, r0.w
add r5.x, r5, -r1.w
cmp_pp r5.y, r5, c9.z, c9.x
cmp r5.x, r5, c9, c9.z
mul_pp r5.x, r5, r5.y
cmp_pp r4.z, -r5.x, r4, r0.w
add r4.w, r4, c9.x
endloop
add r2.xyz, v2, r2
dp3 r1.w, r2, r2
rsq r1.w, r1.w
mul r3.xyz, r1.w, r2
mov r2.xy, r1
mov r0.w, c5.x
add r0.w, c9.x, -r0
mad r0.w, r0, r4.z, c5.x
mul r2.z, r0.w, r1
dp3 r1.x, r2, r3
mov_pp r1.y, c3.x
mul_pp r3.y, c10.w, r1
max r3.x, r1, c9.z
pow r1, r3.x, r3.y
dp3 r1.y, r2, v2
mul r1.x, r0.w, r1
max r1.y, r1, c9.z
mul r1.w, r1.x, r2
mul r2.x, r0.w, r1.y
mov_pp r1.xyz, c0
mul_pp r0.xyz, r0, c0
mul_pp r0.xyz, r0, r2.x
mul_pp r1.xyz, c1, r1
mad r0.xyz, r1, r1.w, r0
mul r0.xyz, r0.w, r0
mul oC0.xyz, r0, c10.x
mov_pp oC0.w, r3
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_Parallax]
Float 5 [_ShadingStrength]
Float 6 [_ShadeRange]
Float 7 [_AlphaCutRange]
Float 8 [_UseAlpha]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_LightTexture0] 2D
SetTexture 4 [_LightTextureB0] 2D
"ps_3_0
; 155 ALU, 13 TEX, 10 FLOW
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c9, 1.00000000, 40.00000000, 0.00000000, 0.50000000
defi i0, 40, 0, 1, 0
def c10, 2.00000000, -1.00000000, 0.06250000, 128.00000000
defi i1, 15, 1, 1, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3
dp3 r0.x, v1, v1
rsq r0.x, r0.x
mul r0.xyz, r0.x, v1
dp3 r1.y, -r0, -r0
add r0.w, -r0.z, c9.x
mul r1.x, r0.w, r0.w
mad r0.w, -r1.x, r0, c9.x
mul r1.x, r0.z, c9.y
rsq r1.y, r1.y
mul r0.xy, r1.y, -r0
mul r0.w, r0, c4.x
mul r0.xy, r0, r0.w
abs r0.z, r0
rcp r0.w, r1.x
mul r1.xyz, r0, r0.w
mov r0.xy, v0.zwzw
mov r0.z, c9
loop aL, i0
texld r0.w, r0, s0
add r2.xyz, r0, r1
add r0.w, r0.z, -r0
cmp r0.xyz, r0.w, r0, r2
endloop
mul r1.xyz, r1, c9.w
add r2.xyz, r0, -r1
add r3.xyz, r0, r1
texld r0.w, r0, s0
add_pp r0.x, r0.z, -r0.w
cmp r0.xyz, r0.x, r2, r3
texld r0.w, r0, s0
add r1.w, r0.z, -r0
mul r1.xyz, r1, c9.w
add r2.xyz, r0, r1
add r0.w, r0.z, -r0
cmp r2.xyz, r0.w, r0, r2
add r3.xyz, r2, -r1
cmp r0.x, r1.w, c9.z, c9
abs_pp r0.x, r0
cmp r0.xyz, -r0.x, r3, r2
texld r0.w, r0, s0
add r1.w, r0.z, -r0
mul r1.xyz, r1, c9.w
add r2.xyz, r0, r1
add r0.w, r0.z, -r0
cmp r2.xyz, r0.w, r0, r2
add r3.xyz, r2, -r1
cmp r0.x, r1.w, c9.z, c9
abs_pp r0.x, r0
cmp r0.xyz, -r0.x, r3, r2
texld r0.w, r0, s0
add r1.w, r0.z, -r0
mul r1.xyz, r1, c9.w
add r2.xyz, r0, r1
add r0.w, r0.z, -r0
cmp r2.xyz, r0.w, r0, r2
add r3.xyz, r2, -r1
cmp r0.x, r1.w, c9.z, c9
abs_pp r0.x, r0
cmp r0.xyz, -r0.x, r3, r2
mul r1.xyz, r1, c9.w
texld r0.w, r0, s0
add r1.w, r0.z, -r0
add r2.xyz, r0, r1
add r0.w, r0.z, -r0
cmp r2.xyz, r0.w, r0, r2
cmp r0.x, r1.w, c9.z, c9
add r3.xyz, r2, -r1
abs_pp r0.x, r0
cmp r0.xyz, -r0.x, r3, r2
texld r0.w, r0, s0
add r1.z, r0, -r0.w
mad r2.xy, r1, c9.w, r0
add r0.z, r0, -r0.w
cmp r0.zw, r0.z, r0.xyxy, r2.xyxy
cmp r0.x, r1.z, c9.z, c9
mad r1.xy, -r1, c9.w, r0.zwzw
abs_pp r0.x, r0
cmp r6.xy, -r0.x, r1, r0.zwzw
add r0.xy, -v0.zwzw, r6
add r0.xy, v0, r0
rcp r0.z, c7.x
mul r0.w, r0.x, r0.z
cmp r1.y, r0.w, c9.z, c9.x
mad r1.x, -r0.y, r0.z, c9
mad r0.w, -r0.x, r0.z, c9.x
mul r0.z, r0.y, r0
cmp r1.x, r1, c9.z, c9
cmp r0.w, r0, c9.z, c9.x
add_pp_sat r0.w, r0, r1.x
add_pp_sat r0.w, r0, r1.y
texld r1.yw, r6, s2
cmp r0.z, r0, c9, c9.x
add_pp_sat r0.z, r0.w, r0
mad_pp r2.xy, r1.wyzw, c10.x, c10.y
mul_pp r0.w, r2.y, r2.y
abs_pp r0.z, r0
cmp_pp r0.z, -r0, c9.x, c9
mad_pp r0.w, -r2.x, r2.x, -r0
add_pp r0.w, r0, c9.x
rsq_pp r1.x, r0.w
add_pp r2.w, r0.z, c8.x
texld r0, r0, s1
rcp_pp r2.z, r1.x
mul_pp r1.xyz, r0, c2
mov_pp r1.w, r0
texld r0.w, r6, s0
dp3_pp r0.x, v2, v2
rsq_pp r0.x, r0.x
mov r0.y, c6.x
add r0.y, c4.x, r0
mul_pp r3.xyz, r0.x, v2
mul r0.xyz, -r3, r0.y
mul r0.xyz, r0.w, r0
mul r5.xyz, r0, c10.z
rcp r0.y, v3.w
mad r7.xy, v3, r0.y, c9.w
add r4.w, -r0, c9.x
dp3_pp r0.w, v1, v1
rsq_pp r0.x, r0.w
mul_pp r4.xyz, r0.x, v1
dp3 r0.x, v3, v3
texld r0.x, r0.x, s4
texld r0.w, r7, s3
cmp r0.y, -v3.z, c9.z, c9.x
mul_pp r0.y, r0, r0.w
mul_pp r3.w, r0.y, r0.x
mov_pp r5.w, c9.x
mov r0.x, c9
loop aL, i1
add r6.xy, r6, -r5
texld r0.w, r6, s0
add r0.z, -r0.w, c9.x
add_pp r0.y, r0.z, -r4.w
mad r0.z, r5, r0.x, r0
add_pp r0.y, -r0, c9.x
add_pp r0.w, -r5, r0.y
add r0.z, r0, -r4.w
cmp_pp r0.w, r0, c9.z, c9.x
cmp r0.z, r0, c9.x, c9
mul_pp r0.z, r0, r0.w
cmp_pp r5.w, -r0.z, r5, r0.y
add r0.x, r0, c9
endloop
add r0.xyz, r3, r4
dp3 r4.x, r0, r0
rsq r4.y, r4.x
mov r0.w, c5.x
add r0.w, c9.x, -r0
mad r4.x, r0.w, r5.w, c5
mov_pp r0.w, c3.x
mul r0.xyz, r4.y, r0
mul r2.z, r4.x, r2
dp3 r0.x, r2, r0
mul_pp r4.z, c10.w, r0.w
max r4.y, r0.x, c9.z
pow r0, r4.y, r4.z
mul r0.x, r4, r0
dp3 r0.y, r2, r3
mul r0.w, r0.x, r1
max r0.y, r0, c9.z
mul r1.w, r4.x, r0.y
mov_pp r0.xyz, c0
mul_pp r1.xyz, r1, c0
mul_pp r1.xyz, r1, r1.w
mul_pp r0.xyz, c1, r0
mad r0.xyz, r0, r0.w, r1
mul_pp r0.w, r3, c10.x
mul r0.xyz, r4.x, r0
mul oC0.xyz, r0, r0.w
mov_pp oC0.w, r2
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_Parallax]
Float 5 [_ShadingStrength]
Float 6 [_ShadeRange]
Float 7 [_AlphaCutRange]
Float 8 [_UseAlpha]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_LightTextureB0] 2D
SetTexture 4 [_LightTexture0] CUBE
"ps_3_0
; 151 ALU, 13 TEX, 10 FLOW
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_cube s4
def c9, 1.00000000, 40.00000000, 0.00000000, 0.50000000
defi i0, 40, 0, 1, 0
def c10, 2.00000000, -1.00000000, 0.06250000, 128.00000000
defi i1, 15, 1, 1, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dp3 r0.x, v1, v1
rsq r0.x, r0.x
mul r0.xyz, r0.x, v1
dp3 r1.y, -r0, -r0
add r0.w, -r0.z, c9.x
mul r1.x, r0.w, r0.w
mad r0.w, -r1.x, r0, c9.x
mul r1.x, r0.z, c9.y
rsq r1.y, r1.y
mul r0.xy, r1.y, -r0
mul r0.w, r0, c4.x
mul r0.xy, r0, r0.w
abs r0.z, r0
rcp r0.w, r1.x
mul r1.xyz, r0, r0.w
mov r0.xy, v0.zwzw
mov r0.z, c9
loop aL, i0
texld r0.w, r0, s0
add r2.xyz, r0, r1
add r0.w, r0.z, -r0
cmp r0.xyz, r0.w, r0, r2
endloop
mul r1.xyz, r1, c9.w
add r2.xyz, r0, -r1
add r3.xyz, r0, r1
texld r0.w, r0, s0
add_pp r0.x, r0.z, -r0.w
cmp r0.xyz, r0.x, r2, r3
texld r0.w, r0, s0
add r1.w, r0.z, -r0
mul r1.xyz, r1, c9.w
add r2.xyz, r0, r1
add r0.w, r0.z, -r0
cmp r2.xyz, r0.w, r0, r2
add r3.xyz, r2, -r1
cmp r0.x, r1.w, c9.z, c9
abs_pp r0.x, r0
cmp r0.xyz, -r0.x, r3, r2
texld r0.w, r0, s0
add r1.w, r0.z, -r0
mul r1.xyz, r1, c9.w
add r2.xyz, r0, r1
add r0.w, r0.z, -r0
cmp r2.xyz, r0.w, r0, r2
add r3.xyz, r2, -r1
cmp r0.x, r1.w, c9.z, c9
abs_pp r0.x, r0
cmp r0.xyz, -r0.x, r3, r2
texld r0.w, r0, s0
add r1.w, r0.z, -r0
mul r1.xyz, r1, c9.w
add r2.xyz, r0, r1
add r0.w, r0.z, -r0
cmp r2.xyz, r0.w, r0, r2
add r3.xyz, r2, -r1
cmp r0.x, r1.w, c9.z, c9
abs_pp r0.x, r0
cmp r0.xyz, -r0.x, r3, r2
mul r1.xyz, r1, c9.w
texld r0.w, r0, s0
add r1.w, r0.z, -r0
add r2.xyz, r0, r1
add r0.w, r0.z, -r0
cmp r2.xyz, r0.w, r0, r2
cmp r0.x, r1.w, c9.z, c9
add r3.xyz, r2, -r1
abs_pp r0.x, r0
cmp r0.xyz, -r0.x, r3, r2
texld r0.w, r0, s0
add r1.z, r0, -r0.w
mad r2.xy, r1, c9.w, r0
add r0.z, r0, -r0.w
cmp r0.zw, r0.z, r0.xyxy, r2.xyxy
cmp r0.x, r1.z, c9.z, c9
mad r1.xy, -r1, c9.w, r0.zwzw
abs_pp r0.x, r0
cmp r6.xy, -r0.x, r1, r0.zwzw
add r0.xy, -v0.zwzw, r6
add r0.xy, v0, r0
rcp r0.z, c7.x
mul r0.w, r0.x, r0.z
cmp r1.y, r0.w, c9.z, c9.x
mad r1.x, -r0.y, r0.z, c9
mad r0.w, -r0.x, r0.z, c9.x
mul r0.z, r0.y, r0
cmp r1.x, r1, c9.z, c9
cmp r0.w, r0, c9.z, c9.x
add_pp_sat r0.w, r0, r1.x
add_pp_sat r0.w, r0, r1.y
texld r1.yw, r6, s2
cmp r0.z, r0, c9, c9.x
add_pp_sat r0.z, r0.w, r0
mad_pp r2.xy, r1.wyzw, c10.x, c10.y
mul_pp r0.w, r2.y, r2.y
abs_pp r0.z, r0
cmp_pp r0.z, -r0, c9.x, c9
mad_pp r0.w, -r2.x, r2.x, -r0
add_pp r0.w, r0, c9.x
rsq_pp r1.x, r0.w
add_pp r2.w, r0.z, c8.x
texld r0, r0, s1
rcp_pp r2.z, r1.x
mul_pp r1.xyz, r0, c2
mov_pp r1.w, r0
texld r0.w, r6, s0
dp3_pp r0.x, v2, v2
rsq_pp r0.x, r0.x
mov r0.y, c6.x
dp3_pp r3.w, v1, v1
add r4.w, -r0, c9.x
add r0.y, c4.x, r0
mul_pp r3.xyz, r0.x, v2
mul r0.xyz, -r3, r0.y
mul r0.xyz, r0.w, r0
rsq_pp r0.w, r3.w
mul r5.xyz, r0, c10.z
mul_pp r4.xyz, r0.w, v1
dp3 r0.x, v3, v3
texld r0.x, r0.x, s3
texld r0.w, v3, s4
mul r3.w, r0.x, r0
mov_pp r5.w, c9.x
mov r0.x, c9
loop aL, i1
add r6.xy, r6, -r5
texld r0.w, r6, s0
add r0.z, -r0.w, c9.x
add_pp r0.y, r0.z, -r4.w
mad r0.z, r5, r0.x, r0
add_pp r0.y, -r0, c9.x
add_pp r0.w, -r5, r0.y
add r0.z, r0, -r4.w
cmp_pp r0.w, r0, c9.z, c9.x
cmp r0.z, r0, c9.x, c9
mul_pp r0.z, r0, r0.w
cmp_pp r5.w, -r0.z, r5, r0.y
add r0.x, r0, c9
endloop
add r0.xyz, r3, r4
dp3 r4.x, r0, r0
rsq r4.y, r4.x
mov r0.w, c5.x
add r0.w, c9.x, -r0
mad r4.x, r0.w, r5.w, c5
mov_pp r0.w, c3.x
mul r0.xyz, r4.y, r0
mul r2.z, r4.x, r2
dp3 r0.x, r2, r0
mul_pp r4.z, c10.w, r0.w
max r4.y, r0.x, c9.z
pow r0, r4.y, r4.z
mul r0.x, r4, r0
dp3 r0.y, r2, r3
mul r0.w, r0.x, r1
max r0.y, r0, c9.z
mul r1.w, r4.x, r0.y
mov_pp r0.xyz, c0
mul_pp r1.xyz, r1, c0
mul_pp r1.xyz, r1, r1.w
mul_pp r0.xyz, c1, r0
mad r0.xyz, r0, r0.w, r1
mul_pp r0.w, r3, c10.x
mul r0.xyz, r4.x, r0
mul oC0.xyz, r0, r0.w
mov_pp oC0.w, r2
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_Parallax]
Float 5 [_ShadingStrength]
Float 6 [_ShadeRange]
Float 7 [_AlphaCutRange]
Float 8 [_UseAlpha]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_LightTexture0] 2D
"ps_3_0
; 147 ALU, 12 TEX, 10 FLOW
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c9, 1.00000000, 40.00000000, 0.00000000, 0.50000000
defi i0, 40, 0, 1, 0
def c10, 2.00000000, -1.00000000, 0.06250000, 128.00000000
defi i1, 15, 1, 1, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xy
dp3 r0.x, v1, v1
rsq r0.x, r0.x
mul r0.xyz, r0.x, v1
dp3 r1.y, -r0, -r0
add r0.w, -r0.z, c9.x
mul r1.x, r0.w, r0.w
mad r0.w, -r1.x, r0, c9.x
mul r1.x, r0.z, c9.y
rsq r1.y, r1.y
mul r0.xy, r1.y, -r0
mul r0.w, r0, c4.x
mul r0.xy, r0, r0.w
abs r0.z, r0
rcp r0.w, r1.x
mul r1.xyz, r0, r0.w
mov r0.xy, v0.zwzw
mov r0.z, c9
loop aL, i0
texld r0.w, r0, s0
add r2.xyz, r0, r1
add r0.w, r0.z, -r0
cmp r0.xyz, r0.w, r0, r2
endloop
mul r1.xyz, r1, c9.w
add r2.xyz, r0, -r1
add r3.xyz, r0, r1
texld r0.w, r0, s0
add_pp r0.x, r0.z, -r0.w
cmp r0.xyz, r0.x, r2, r3
texld r0.w, r0, s0
add r1.w, r0.z, -r0
mul r1.xyz, r1, c9.w
add r2.xyz, r0, r1
add r0.w, r0.z, -r0
cmp r0.xyz, r0.w, r0, r2
add r2.xyz, r0, -r1
cmp r0.w, r1, c9.z, c9.x
abs_pp r0.w, r0
cmp r0.xyz, -r0.w, r2, r0
texld r0.w, r0, s0
add r1.w, r0.z, -r0
mul r1.xyz, r1, c9.w
add r2.xyz, r0, r1
add r0.w, r0.z, -r0
cmp r0.xyz, r0.w, r0, r2
add r2.xyz, r0, -r1
cmp r0.w, r1, c9.z, c9.x
abs_pp r0.w, r0
cmp r0.xyz, -r0.w, r2, r0
texld r0.w, r0, s0
add r1.w, r0.z, -r0
mul r1.xyz, r1, c9.w
add r2.xyz, r0, r1
add r0.w, r0.z, -r0
cmp r0.xyz, r0.w, r0, r2
add r2.xyz, r0, -r1
cmp r0.w, r1, c9.z, c9.x
abs_pp r0.w, r0
cmp r0.xyz, -r0.w, r2, r0
mul r1.xyz, r1, c9.w
texld r0.w, r0, s0
add r1.w, r0.z, -r0
add r2.xyz, r0, r1
add r0.w, r0.z, -r0
cmp r0.xyz, r0.w, r0, r2
cmp r0.w, r1, c9.z, c9.x
add r2.xyz, r0, -r1
abs_pp r0.w, r0
cmp r0.xyz, -r0.w, r2, r0
texld r0.w, r0, s0
add r1.z, r0, -r0.w
mad r2.xy, r1, c9.w, r0
add r0.z, r0, -r0.w
cmp r0.zw, r0.z, r0.xyxy, r2.xyxy
cmp r0.x, r1.z, c9.z, c9
mad r1.xy, -r1, c9.w, r0.zwzw
abs_pp r0.x, r0
cmp r4.xy, -r0.x, r1, r0.zwzw
add r0.xy, -v0.zwzw, r4
add r0.xy, v0, r0
rcp r0.z, c7.x
mul r0.w, r0.x, r0.z
cmp r1.y, r0.w, c9.z, c9.x
mad r1.x, -r0.y, r0.z, c9
mad r0.w, -r0.x, r0.z, c9.x
mul r0.z, r0.y, r0
cmp r1.x, r1, c9.z, c9
cmp r0.w, r0, c9.z, c9.x
add_pp_sat r0.w, r0, r1.x
add_pp_sat r0.w, r0, r1.y
texld r1.yw, r4, s2
cmp r0.z, r0, c9, c9.x
add_pp_sat r0.z, r0.w, r0
mad_pp r1.xy, r1.wyzw, c10.x, c10.y
mul_pp r0.w, r1.y, r1.y
abs_pp r0.z, r0
cmp_pp r0.z, -r0, c9.x, c9
mad_pp r0.w, -r1.x, r1.x, -r0
add_pp r0.w, r0, c9.x
rsq_pp r1.z, r0.w
add_pp r3.w, r0.z, c8.x
texld r0, r0, s1
mov_pp r1.w, r0
mov r0.w, c6.x
add r2.x, c4, r0.w
texld r0.w, r4, s0
mul r2.xyz, -v2, r2.x
mul r2.xyz, r0.w, r2
add r2.w, -r0, c9.x
dp3_pp r0.w, v1, v1
mul r3.xyz, r2, c10.z
rsq_pp r2.x, r0.w
texld r0.w, v3, s3
rcp_pp r1.z, r1.z
mul_pp r0.xyz, r0, c2
mul_pp r2.xyz, r2.x, v1
mov_pp r4.z, r0.w
mov_pp r4.w, c9.x
mov r5.x, c9
loop aL, i1
add r4.xy, r4, -r3
texld r0.w, r4, s0
add r5.y, -r0.w, c9.x
add_pp r0.w, r5.y, -r2
mad r5.y, r3.z, r5.x, r5
add_pp r0.w, -r0, c9.x
add_pp r5.z, -r4.w, r0.w
add r5.y, r5, -r2.w
cmp_pp r5.z, r5, c9, c9.x
cmp r5.y, r5, c9.x, c9.z
mul_pp r5.y, r5, r5.z
cmp_pp r4.w, -r5.y, r4, r0
add r5.x, r5, c9
endloop
add r2.xyz, v2, r2
dp3 r2.w, r2, r2
rsq r2.w, r2.w
mul r2.xyz, r2.w, r2
mov_pp r2.w, c3.x
mov r0.w, c5.x
add r0.w, c9.x, -r0
mad r0.w, r0, r4, c5.x
mul r1.z, r0.w, r1
dp3 r2.x, r1, r2
dp3 r1.y, r1, v2
max r1.y, r1, c9.z
mul_pp r3.y, c10.w, r2.w
max r3.x, r2, c9.z
pow r2, r3.x, r3.y
mul r1.x, r0.w, r2
mul r1.w, r1.x, r1
mul r2.x, r0.w, r1.y
mov_pp r1.xyz, c0
mul_pp r0.xyz, r0, c0
mul_pp r1.xyz, c1, r1
mul_pp r0.xyz, r0, r2.x
mad r0.xyz, r1, r1.w, r0
mul_pp r1.x, r4.z, c10
mul r0.xyz, r0.w, r0
mul oC0.xyz, r0, r1.x
mov_pp oC0.w, r3
"
}
}
 }
}
Fallback "Bumped Specular"
}