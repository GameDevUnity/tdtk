Shader "Chickenlord/Relief Mapping Shaded Specular Low" {
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
; 219 ALU, 24 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c9, 0.00000000, 9.00000000, 0.50000000, 1.00000000
def c10, 0.14285715, 6.00000000, 5.00000000, 4.00000000
def c11, 3.00000000, 2.00000000, -1.00000000, 128.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dp3 r0.x, v1, v1
rsq r0.x, r0.x
mul r0.xyz, r0.x, v1
dp3 r0.w, -r0, -r0
add r1.x, -r0.z, c9.w
mul r1.y, r1.x, r1.x
rsq r0.w, r0.w
mad r1.x, -r1.y, r1, c9.w
mul r0.xy, r0.w, -r0
mul r0.w, r1.x, c4.x
mul r1.x, r0.z, c9.y
mul r0.xy, r0, r0.w
rcp r0.w, r1.x
abs r0.z, r0
mul r0.xyz, r0, r0.w
mov r1.xy, v0.zwzw
mov r1.z, c9.x
add r2.xyz, r1, r0
texld r0.w, v0.zwzw, s0
cmp r1.xyz, -r0.w, r1, r2
texld r0.w, r1, s0
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
texld r0.w, r1, s0
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
texld r0.w, r1, s0
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
texld r0.w, r1, s0
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
texld r0.w, r1, s0
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
texld r0.w, r1, s0
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
texld r0.w, r1, s0
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
add r2.xyz, r1, r0
texld r0.w, r1, s0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
mul r0.xyz, r0, c9.z
texld r0.w, r1, s0
add r2.xyz, r1, r0
add_pp r0.w, r1.z, -r0
add r1.xyz, r1, -r0
cmp r1.xyz, r0.w, r1, r2
texld r0.w, r1, s0
add r1.w, r1.z, -r0
mul r0.xyz, r0, c9.z
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
add r2.xyz, r1, -r0
cmp r0.w, r1, c9.x, c9
abs_pp r0.w, r0
cmp r1.xyz, -r0.w, r2, r1
texld r0.w, r1, s0
add r1.w, r1.z, -r0
mul r0.xyz, r0, c9.z
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
add r2.xyz, r1, -r0
cmp r0.w, r1, c9.x, c9
abs_pp r0.w, r0
cmp r1.xyz, -r0.w, r2, r1
texld r0.w, r1, s0
add r1.w, r1.z, -r0
mul r0.xyz, r0, c9.z
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
add r2.xyz, r1, -r0
cmp r0.w, r1, c9.x, c9
abs_pp r0.w, r0
cmp r1.xyz, -r0.w, r2, r1
mul r0.xyz, r0, c9.z
texld r0.w, r1, s0
add r1.w, r1.z, -r0
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
add r2.xyz, r1, -r0
cmp r0.w, r1, c9.x, c9
abs_pp r0.z, r0.w
cmp r1.xyz, -r0.z, r2, r1
texld r0.w, r1, s0
mad r2.xy, r0, c9.z, r1
add r0.z, r1, -r0.w
cmp r1.xy, r0.z, r1, r2
add r0.z, r1, -r0.w
mad r1.zw, -r0.xyxy, c9.z, r1.xyxy
cmp r0.x, r0.z, c9, c9.w
mov r0.y, c6.x
add r0.z, c4.x, r0.y
abs_pp r0.x, r0
cmp r0.xy, -r0.x, r1.zwzw, r1
texld r0.w, r0, s0
mul r1.xyz, -v2, r0.z
mul r1.xyz, r0.w, r1
mul r1.xyz, r1, c10.x
add r3.xy, r0, -r1
add r2.xy, -r1, r3
texld r1.w, r2, s0
texld r2.w, r3, s0
add r1.w, -r1, c9
add r0.z, -r0.w, c9.w
add r2.z, -r2.w, c9.w
add r0.w, r1.z, r2.z
add_pp r2.z, -r0, r2
cmp_pp r2.w, -r2.z, c9.x, c9
add r0.w, -r0.z, r0
cmp r0.w, r0, c9, c9.x
mul_pp r0.w, r0, r2
add_pp r2.w, -r0.z, r1
add_pp r2.z, -r2, c9.w
cmp_pp r3.x, -r0.w, c9.w, r2.z
add_pp r2.w, -r2, c9
add_pp r0.w, -r3.x, r2
mad r3.y, r1.z, c11, r1.w
add r2.xy, -r1, r2
cmp_pp r2.z, r0.w, c9.x, c9.w
texld r0.w, r2, s0
add r1.w, -r0, c9
add r0.w, -r0.z, r3.y
add_pp r3.y, -r0.z, r1.w
cmp r0.w, r0, c9, c9.x
mul_pp r0.w, r0, r2.z
cmp_pp r3.x, -r0.w, r3, r2.w
add_pp r2.z, -r3.y, c9.w
add_pp r0.w, -r3.x, r2.z
add r2.xy, -r1, r2
cmp_pp r3.y, r0.w, c9.x, c9.w
texld r0.w, r2, s0
add r2.xy, -r1, r2
add r1.xy, -r1, r2
mad r1.w, r1.z, c11.x, r1
add r2.w, -r0, c9
add r0.w, -r0.z, r1
add_pp r1.w, -r0.z, r2
mad r2.w, r1.z, c10, r2
add r2.w, -r0.z, r2
cmp r0.w, r0, c9, c9.x
mul_pp r0.w, r0, r3.y
cmp_pp r3.x, -r0.w, r3, r2.z
add_pp r1.w, -r1, c9
add_pp r0.w, -r3.x, r1
cmp_pp r2.z, r0.w, c9.x, c9.w
texld r0.w, r2, s0
add r0.w, -r0, c9
cmp r2.w, r2, c9, c9.x
mul_pp r2.w, r2, r2.z
add_pp r3.y, -r0.z, r0.w
mad r2.x, r1.z, c10.z, r0.w
texld r0.w, r1, s0
add r1.x, -r0.z, r2
add r0.w, -r0, c9
add_pp r1.y, r0.w, -r0.z
mad r0.w, r1.z, c10.y, r0
add r0.z, r0.w, -r0
cmp_pp r1.w, -r2, r3.x, r1
add_pp r2.z, -r3.y, c9.w
add_pp r2.w, -r1, r2.z
add_pp r1.y, -r1, c9.w
cmp_pp r2.w, r2, c9.x, c9
cmp r1.x, r1, c9.w, c9
mul_pp r1.x, r1, r2.w
cmp_pp r1.x, -r1, r1.w, r2.z
add_pp r1.z, -r1.x, r1.y
cmp_pp r0.w, r1.z, c9.x, c9
cmp r0.z, r0, c9.w, c9.x
mul_pp r0.z, r0, r0.w
cmp_pp r0.w, -r0.z, r1.x, r1.y
texld r1.yw, r0, s2
mov r0.z, c5.x
add r0.z, c9.w, -r0
dp3_pp r1.x, v1, v1
add r0.xy, -v0.zwzw, r0
mad_pp r2.xy, r1.wyzw, c11.y, c11.z
mad r0.z, r0, r0.w, c5.x
mul_pp r0.w, r2.y, r2.y
mad_pp r0.w, -r2.x, r2.x, -r0
rsq_pp r1.x, r1.x
mul_pp r1.xyz, r1.x, v1
add r1.xyz, v2, r1
dp3 r1.w, r1, r1
rsq r1.w, r1.w
mul r1.xyz, r1.w, r1
mov_pp r1.w, c3.x
add_pp r0.w, r0, c9
rsq_pp r0.w, r0.w
rcp_pp r0.w, r0.w
mul r2.z, r0, r0.w
dp3 r0.w, r2, r1
add r0.xy, v0, r0
mul_pp r2.w, c11, r1
max r0.w, r0, c9.x
pow r1, r0.w, r2.w
mov r0.w, r1.x
texld r1, r0, s1
mul_pp r1.xyz, r1, c2
mul r0.w, r0.z, r0
mul r0.w, r1, r0
dp3 r2.x, v2, r2
max r1.w, r2.x, c9.x
mov_pp r2.xyz, c0
mul r1.w, r0.z, r1
mul_pp r3.xyz, r1, c0
mul_pp r3.xyz, r3, r1.w
rcp r1.w, c7.x
mad r2.w, -r0.y, r1, c9
mul_pp r2.xyz, c1, r2
mad r2.xyz, r2, r0.w, r3
mad r0.w, -r0.x, r1, c9
mul r0.x, r0, r1.w
mul r0.y, r0, r1.w
mul r2.xyz, r0.z, r2
mul r2.xyz, r2, c11.y
cmp r2.w, r2, c9.x, c9
cmp r0.w, r0, c9.x, c9
add_pp_sat r0.w, r0, r2
cmp r0.x, r0, c9, c9.w
cmp r0.y, r0, c9.x, c9.w
add_pp_sat r0.x, r0.w, r0
add_pp_sat r0.x, r0, r0.y
abs_pp r0.x, r0
cmp_pp r0.x, -r0, c9.w, c9
mad_pp oC0.xyz, r1, v3, r2
add_pp oC0.w, r0.x, c8.x
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
; 222 ALU, 25 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c9, 0.00000000, 9.00000000, 0.50000000, 1.00000000
def c10, 0.14285715, 6.00000000, 5.00000000, 4.00000000
def c11, 3.00000000, 2.00000000, -1.00000000, 128.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dp3 r0.x, v1, v1
rsq r0.x, r0.x
mul r0.xyz, r0.x, v1
dp3 r0.w, -r0, -r0
add r1.x, -r0.z, c9.w
mul r1.y, r1.x, r1.x
rsq r0.w, r0.w
mad r1.x, -r1.y, r1, c9.w
mul r0.xy, r0.w, -r0
mul r0.w, r1.x, c4.x
mul r1.x, r0.z, c9.y
mul r0.xy, r0, r0.w
rcp r0.w, r1.x
abs r0.z, r0
mul r0.xyz, r0, r0.w
mov r1.xy, v0.zwzw
mov r1.z, c9.x
add r2.xyz, r1, r0
texld r0.w, v0.zwzw, s0
cmp r1.xyz, -r0.w, r1, r2
texld r0.w, r1, s0
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
texld r0.w, r1, s0
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
texld r0.w, r1, s0
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
texld r0.w, r1, s0
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
texld r0.w, r1, s0
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
texld r0.w, r1, s0
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
texld r0.w, r1, s0
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
add r2.xyz, r1, r0
texld r0.w, r1, s0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
mul r0.xyz, r0, c9.z
texld r0.w, r1, s0
add r2.xyz, r1, r0
add_pp r0.w, r1.z, -r0
add r1.xyz, r1, -r0
cmp r1.xyz, r0.w, r1, r2
texld r0.w, r1, s0
add r1.w, r1.z, -r0
mul r0.xyz, r0, c9.z
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
add r2.xyz, r1, -r0
cmp r0.w, r1, c9.x, c9
abs_pp r0.w, r0
cmp r1.xyz, -r0.w, r2, r1
texld r0.w, r1, s0
add r1.w, r1.z, -r0
mul r0.xyz, r0, c9.z
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
add r2.xyz, r1, -r0
cmp r0.w, r1, c9.x, c9
abs_pp r0.w, r0
cmp r1.xyz, -r0.w, r2, r1
texld r0.w, r1, s0
add r1.w, r1.z, -r0
mul r0.xyz, r0, c9.z
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
add r2.xyz, r1, -r0
cmp r0.w, r1, c9.x, c9
abs_pp r0.w, r0
cmp r1.xyz, -r0.w, r2, r1
mul r0.xyz, r0, c9.z
texld r0.w, r1, s0
add r1.w, r1.z, -r0
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
add r2.xyz, r1, -r0
cmp r0.w, r1, c9.x, c9
abs_pp r0.z, r0.w
cmp r1.xyz, -r0.z, r2, r1
texld r0.w, r1, s0
add r0.z, r1, -r0.w
mad r2.xy, r0, c9.z, r1
add r0.w, r1.z, -r0
cmp r1.xy, r0.w, r1, r2
mad r1.zw, -r0.xyxy, c9.z, r1.xyxy
cmp r0.z, r0, c9.x, c9.w
abs_pp r0.x, r0.z
cmp r2.xy, -r0.x, r1.zwzw, r1
mov r0.y, c6.x
dp3_pp r0.x, v2, v2
add r0.w, c4.x, r0.y
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, v2
mul r1.xyz, -r0, r0.w
texld r0.w, r2, s0
mul r1.xyz, r0.w, r1
mul r1.xyz, r1, c10.x
add r4.xy, r2, -r1
add r3.xy, -r1, r4
texld r1.w, r3, s0
add r2.z, -r1.w, c9.w
texld r2.w, r4, s0
add r1.w, -r0, c9
add r2.w, -r2, c9
add r0.w, r1.z, r2
add_pp r2.w, -r1, r2
cmp_pp r3.z, -r2.w, c9.x, c9.w
add r0.w, -r1, r0
cmp r0.w, r0, c9, c9.x
mul_pp r0.w, r0, r3.z
add_pp r3.z, -r1.w, r2
mad r4.x, r1.z, c11.y, r2.z
add_pp r3.w, -r3.z, c9
add_pp r2.w, -r2, c9
cmp_pp r3.z, -r0.w, c9.w, r2.w
add_pp r0.w, -r3.z, r3
add r3.xy, -r1, r3
cmp_pp r2.w, r0, c9.x, c9
texld r0.w, r3, s0
add r2.z, -r0.w, c9.w
add r0.w, -r1, r4.x
add_pp r4.x, -r1.w, r2.z
cmp r0.w, r0, c9, c9.x
mul_pp r0.w, r0, r2
add_pp r2.w, -r4.x, c9
cmp_pp r3.w, -r0, r3.z, r3
add_pp r0.w, -r3, r2
add r3.xy, -r1, r3
cmp_pp r4.x, r0.w, c9, c9.w
texld r0.w, r3, s0
add r3.xy, -r1, r3
add r1.xy, -r1, r3
mad r2.z, r1, c11.x, r2
add r3.z, -r0.w, c9.w
add r0.w, -r1, r2.z
add_pp r2.z, -r1.w, r3
mad r3.z, r1, c10.w, r3
add r3.z, -r1.w, r3
cmp r0.w, r0, c9, c9.x
mul_pp r0.w, r0, r4.x
cmp_pp r3.w, -r0, r3, r2
add_pp r2.z, -r2, c9.w
add_pp r0.w, -r3, r2.z
cmp_pp r2.w, r0, c9.x, c9
texld r0.w, r3, s0
add r0.w, -r0, c9
cmp r3.z, r3, c9.w, c9.x
mul_pp r3.z, r3, r2.w
add_pp r4.x, -r1.w, r0.w
mad r3.x, r1.z, c10.z, r0.w
texld r0.w, r1, s0
add r1.x, -r1.w, r3
add r0.w, -r0, c9
add_pp r1.y, r0.w, -r1.w
mad r0.w, r1.z, c10.y, r0
add r0.w, r0, -r1
cmp_pp r2.z, -r3, r3.w, r2
add_pp r2.w, -r4.x, c9
add_pp r3.z, -r2, r2.w
add_pp r1.y, -r1, c9.w
cmp_pp r3.z, r3, c9.x, c9.w
cmp r1.x, r1, c9.w, c9
mul_pp r1.x, r1, r3.z
cmp_pp r1.x, -r1, r2.z, r2.w
add_pp r1.z, -r1.x, r1.y
cmp_pp r1.z, r1, c9.x, c9.w
cmp r0.w, r0, c9, c9.x
mul_pp r0.w, r0, r1.z
cmp_pp r1.x, -r0.w, r1, r1.y
texld r1.yw, r2, s2
mad_pp r3.xy, r1.wyzw, c11.y, c11.z
mov r0.w, c5.x
add r0.w, c9, -r0
mad r0.w, r0, r1.x, c5.x
mul_pp r1.x, r3.y, r3.y
mad_pp r1.w, -r3.x, r3.x, -r1.x
dp3_pp r1.y, v1, v1
rsq_pp r1.y, r1.y
mul_pp r1.xyz, r1.y, v1
add r1.xyz, r0, r1
dp3 r2.z, r1, r1
rsq r2.z, r2.z
add_pp r1.w, r1, c9
rsq_pp r1.w, r1.w
rcp_pp r1.w, r1.w
mul r3.z, r0.w, r1.w
mul r1.xyz, r2.z, r1
mov_pp r1.w, c3.x
dp3 r1.x, r3, r1
max r2.z, r1.x, c9.x
mul_pp r2.w, c11, r1
pow r1, r2.z, r2.w
add r1.zw, -v0, r2.xyxy
add r2.xy, v0, r1.zwzw
mul r2.z, r0.w, r1.x
texld r1, r2, s1
dp3 r0.x, r0, r3
mul r1.w, r2.z, r1
max r2.z, r0.x, c9.x
mul_pp r0.xyz, r1, c2
mov_pp r1.xyz, c0
mul r2.z, r0.w, r2
mul_pp r0.xyz, r0, c0
mul_pp r0.xyz, r0, r2.z
mul_pp r1.xyz, c1, r1
mad r1.xyz, r1, r1.w, r0
rcp r0.x, c7.x
mul r1.xyz, r0.w, r1
mad r0.z, -r2.y, r0.x, c9.w
mad r0.y, -r2.x, r0.x, c9.w
mul r0.w, r2.x, r0.x
cmp r0.z, r0, c9.x, c9.w
cmp r0.y, r0, c9.x, c9.w
add_pp_sat r0.y, r0, r0.z
cmp r0.z, r0.w, c9.x, c9.w
add_pp_sat r0.y, r0, r0.z
mul r0.x, r2.y, r0
cmp r0.z, r0.x, c9.x, c9.w
add_pp_sat r0.y, r0, r0.z
dp3 r0.x, v3, v3
texld r0.x, r0.x, s3
mul_pp r0.z, r0.x, c11.y
abs_pp r0.y, r0
cmp_pp r0.x, -r0.y, c9.w, c9
mul oC0.xyz, r1, r0.z
add_pp oC0.w, r0.x, c8.x
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
; 217 ALU, 24 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c9, 0.00000000, 9.00000000, 0.50000000, 1.00000000
def c10, 0.14285715, 6.00000000, 5.00000000, 4.00000000
def c11, 3.00000000, 2.00000000, -1.00000000, 128.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dp3 r0.x, v1, v1
rsq r0.x, r0.x
mul r0.xyz, r0.x, v1
dp3 r0.w, -r0, -r0
add r1.x, -r0.z, c9.w
mul r1.y, r1.x, r1.x
rsq r0.w, r0.w
mad r1.x, -r1.y, r1, c9.w
mul r0.xy, r0.w, -r0
mul r0.w, r1.x, c4.x
mul r1.x, r0.z, c9.y
mul r0.xy, r0, r0.w
rcp r0.w, r1.x
abs r0.z, r0
mul r0.xyz, r0, r0.w
mov r1.xy, v0.zwzw
mov r1.z, c9.x
add r2.xyz, r1, r0
texld r0.w, v0.zwzw, s0
cmp r1.xyz, -r0.w, r1, r2
texld r0.w, r1, s0
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
texld r0.w, r1, s0
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
texld r0.w, r1, s0
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
texld r0.w, r1, s0
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
texld r0.w, r1, s0
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
texld r0.w, r1, s0
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
texld r0.w, r1, s0
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
add r2.xyz, r1, r0
texld r0.w, r1, s0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
mul r0.xyz, r0, c9.z
texld r0.w, r1, s0
add r2.xyz, r1, r0
add_pp r0.w, r1.z, -r0
add r1.xyz, r1, -r0
cmp r1.xyz, r0.w, r1, r2
texld r0.w, r1, s0
add r1.w, r1.z, -r0
mul r0.xyz, r0, c9.z
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
add r2.xyz, r1, -r0
cmp r0.w, r1, c9.x, c9
abs_pp r0.w, r0
cmp r1.xyz, -r0.w, r2, r1
texld r0.w, r1, s0
add r1.w, r1.z, -r0
mul r0.xyz, r0, c9.z
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
add r2.xyz, r1, -r0
cmp r0.w, r1, c9.x, c9
abs_pp r0.w, r0
cmp r1.xyz, -r0.w, r2, r1
texld r0.w, r1, s0
add r1.w, r1.z, -r0
mul r0.xyz, r0, c9.z
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
add r2.xyz, r1, -r0
cmp r0.w, r1, c9.x, c9
abs_pp r0.w, r0
cmp r1.xyz, -r0.w, r2, r1
mul r0.xyz, r0, c9.z
texld r0.w, r1, s0
add r1.w, r1.z, -r0
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
add r2.xyz, r1, -r0
cmp r0.w, r1, c9.x, c9
abs_pp r0.z, r0.w
cmp r1.xyz, -r0.z, r2, r1
texld r0.w, r1, s0
mad r2.xy, r0, c9.z, r1
add r0.z, r1, -r0.w
cmp r1.xy, r0.z, r1, r2
add r0.z, r1, -r0.w
mad r1.zw, -r0.xyxy, c9.z, r1.xyxy
cmp r0.x, r0.z, c9, c9.w
abs_pp r0.x, r0
cmp r1.xy, -r0.x, r1.zwzw, r1
texld r0.w, r1, s0
mov r0.y, c6.x
add r0.y, c4.x, r0
mul r0.xyz, -v2, r0.y
mul r0.xyz, r0.w, r0
mul r0.xyz, r0, c10.x
add r3.xy, r1, -r0
add r2.xy, -r0, r3
texld r1.w, r2, s0
texld r2.w, r3, s0
add r1.w, -r1, c9
add r1.z, -r0.w, c9.w
add r2.z, -r2.w, c9.w
add r0.w, r0.z, r2.z
add_pp r2.z, -r1, r2
cmp_pp r2.w, -r2.z, c9.x, c9
add r0.w, -r1.z, r0
cmp r0.w, r0, c9, c9.x
mul_pp r0.w, r0, r2
add_pp r2.w, -r1.z, r1
add_pp r2.z, -r2, c9.w
cmp_pp r3.x, -r0.w, c9.w, r2.z
add_pp r2.w, -r2, c9
add_pp r0.w, -r3.x, r2
mad r3.y, r0.z, c11, r1.w
add r2.xy, -r0, r2
cmp_pp r2.z, r0.w, c9.x, c9.w
texld r0.w, r2, s0
add r1.w, -r0, c9
add r0.w, -r1.z, r3.y
add_pp r3.y, -r1.z, r1.w
cmp r0.w, r0, c9, c9.x
mul_pp r0.w, r0, r2.z
cmp_pp r3.x, -r0.w, r3, r2.w
add_pp r2.z, -r3.y, c9.w
add_pp r0.w, -r3.x, r2.z
add r2.xy, -r0, r2
cmp_pp r3.y, r0.w, c9.x, c9.w
texld r0.w, r2, s0
add r2.xy, -r0, r2
add r0.xy, -r0, r2
mad r1.w, r0.z, c11.x, r1
add r2.w, -r0, c9
add r0.w, -r1.z, r1
add_pp r1.w, -r1.z, r2
mad r2.w, r0.z, c10, r2
add r2.w, -r1.z, r2
cmp r0.w, r0, c9, c9.x
mul_pp r0.w, r0, r3.y
cmp_pp r3.x, -r0.w, r3, r2.z
add_pp r1.w, -r1, c9
add_pp r0.w, -r3.x, r1
cmp_pp r2.z, r0.w, c9.x, c9.w
texld r0.w, r2, s0
add r0.w, -r0, c9
cmp r2.w, r2, c9, c9.x
mul_pp r2.w, r2, r2.z
add_pp r3.y, -r1.z, r0.w
mad r2.x, r0.z, c10.z, r0.w
texld r0.w, r0, s0
add r0.y, -r1.z, r2.x
add r0.x, -r0.w, c9.w
add_pp r0.w, r0.x, -r1.z
mad r0.x, r0.z, c10.y, r0
add r0.x, r0, -r1.z
cmp_pp r1.w, -r2, r3.x, r1
add_pp r2.z, -r3.y, c9.w
add_pp r2.w, -r1, r2.z
add_pp r0.w, -r0, c9
cmp_pp r2.w, r2, c9.x, c9
cmp r0.y, r0, c9.w, c9.x
mul_pp r0.y, r0, r2.w
cmp_pp r0.y, -r0, r1.w, r2.z
add_pp r0.z, -r0.y, r0.w
cmp_pp r0.z, r0, c9.x, c9.w
cmp r0.x, r0, c9.w, c9
mul_pp r0.x, r0, r0.z
cmp_pp r0.z, -r0.x, r0.y, r0.w
texld r0.yw, r1, s2
mad_pp r2.xy, r0.wyzw, c11.y, c11.z
mov r0.x, c5
add r0.x, c9.w, -r0
mad r1.z, r0.x, r0, c5.x
mul_pp r0.x, r2.y, r2.y
mad_pp r0.w, -r2.x, r2.x, -r0.x
dp3_pp r0.y, v1, v1
rsq_pp r0.y, r0.y
mul_pp r0.xyz, r0.y, v1
add r0.xyz, v2, r0
dp3 r1.w, r0, r0
rsq r1.w, r1.w
add_pp r0.w, r0, c9
rsq_pp r0.w, r0.w
rcp_pp r0.w, r0.w
mul r2.z, r1, r0.w
mul r0.xyz, r1.w, r0
dp3 r0.x, r2, r0
mov_pp r0.w, c3.x
dp3 r2.x, v2, r2
max r1.w, r0.x, c9.x
mul_pp r2.w, c11, r0
pow r0, r1.w, r2.w
add r0.zw, -v0, r1.xyxy
add r1.xy, v0, r0.zwzw
mul r1.w, r1.z, r0.x
texld r0, r1, s1
mul r0.w, r1, r0
max r1.w, r2.x, c9.x
mul r2.x, r1.z, r1.w
rcp r1.w, c7.x
mul r2.y, r1.x, r1.w
mul_pp r0.xyz, r0, c2
mul_pp r0.xyz, r0, c0
mul_pp r0.xyz, r0, r2.x
mad r2.x, -r1.y, r1.w, c9.w
mad r1.x, -r1, r1.w, c9.w
mul r1.y, r1, r1.w
cmp r2.x, r2, c9, c9.w
cmp r1.x, r1, c9, c9.w
add_pp_sat r1.x, r1, r2
cmp r2.x, r2.y, c9, c9.w
add_pp_sat r1.x, r1, r2
cmp r1.y, r1, c9.x, c9.w
mov_pp r2.xyz, c0
mul_pp r2.xyz, c1, r2
add_pp_sat r1.x, r1, r1.y
mad r2.xyz, r2, r0.w, r0
abs_pp r0.x, r1
mul r1.xyz, r1.z, r2
cmp_pp r0.x, -r0, c9.w, c9
mul oC0.xyz, r1, c11.y
add_pp oC0.w, r0.x, c8.x
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
; 227 ALU, 26 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c9, 0.00000000, 9.00000000, 0.50000000, 1.00000000
def c10, 0.14285715, 6.00000000, 5.00000000, 4.00000000
def c11, 3.00000000, 2.00000000, -1.00000000, 128.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3
dp3 r0.x, v1, v1
rsq r0.x, r0.x
mul r0.xyz, r0.x, v1
dp3 r0.w, -r0, -r0
add r1.x, -r0.z, c9.w
mul r1.y, r1.x, r1.x
rsq r0.w, r0.w
mad r1.x, -r1.y, r1, c9.w
mul r0.xy, r0.w, -r0
mul r0.w, r1.x, c4.x
mul r1.x, r0.z, c9.y
mul r0.xy, r0, r0.w
rcp r0.w, r1.x
abs r0.z, r0
mul r0.xyz, r0, r0.w
mov r1.xy, v0.zwzw
mov r1.z, c9.x
add r2.xyz, r1, r0
texld r0.w, v0.zwzw, s0
cmp r1.xyz, -r0.w, r1, r2
texld r0.w, r1, s0
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
texld r0.w, r1, s0
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
texld r0.w, r1, s0
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
texld r0.w, r1, s0
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
texld r0.w, r1, s0
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
texld r0.w, r1, s0
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
texld r0.w, r1, s0
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
add r2.xyz, r1, r0
texld r0.w, r1, s0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
mul r0.xyz, r0, c9.z
texld r0.w, r1, s0
add r2.xyz, r1, r0
add_pp r0.w, r1.z, -r0
add r1.xyz, r1, -r0
cmp r1.xyz, r0.w, r1, r2
texld r0.w, r1, s0
add r1.w, r1.z, -r0
mul r0.xyz, r0, c9.z
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
add r2.xyz, r1, -r0
cmp r0.w, r1, c9.x, c9
abs_pp r0.w, r0
cmp r1.xyz, -r0.w, r2, r1
texld r0.w, r1, s0
add r1.w, r1.z, -r0
mul r0.xyz, r0, c9.z
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
add r2.xyz, r1, -r0
cmp r0.w, r1, c9.x, c9
abs_pp r0.w, r0
cmp r1.xyz, -r0.w, r2, r1
texld r0.w, r1, s0
add r1.w, r1.z, -r0
mul r0.xyz, r0, c9.z
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
add r2.xyz, r1, -r0
cmp r0.w, r1, c9.x, c9
abs_pp r0.w, r0
cmp r1.xyz, -r0.w, r2, r1
mul r0.xyz, r0, c9.z
texld r0.w, r1, s0
add r1.w, r1.z, -r0
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
add r2.xyz, r1, -r0
cmp r0.w, r1, c9.x, c9
abs_pp r0.z, r0.w
cmp r1.xyz, -r0.z, r2, r1
texld r0.w, r1, s0
add r0.z, r1, -r0.w
mad r2.xy, r0, c9.z, r1
add r0.w, r1.z, -r0
cmp r1.xy, r0.w, r1, r2
mad r1.zw, -r0.xyxy, c9.z, r1.xyxy
cmp r0.z, r0, c9.x, c9.w
abs_pp r0.x, r0.z
cmp r2.xy, -r0.x, r1.zwzw, r1
mov r0.y, c6.x
dp3_pp r0.x, v2, v2
add r0.w, c4.x, r0.y
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, v2
mul r1.xyz, -r0, r0.w
texld r0.w, r2, s0
mul r1.xyz, r0.w, r1
mul r1.xyz, r1, c10.x
add r4.xy, r2, -r1
add r3.xy, -r1, r4
texld r1.w, r3, s0
add r2.z, -r1.w, c9.w
texld r2.w, r4, s0
add r1.w, -r0, c9
add r2.w, -r2, c9
add r0.w, r1.z, r2
add_pp r2.w, -r1, r2
cmp_pp r3.z, -r2.w, c9.x, c9.w
add r0.w, -r1, r0
cmp r0.w, r0, c9, c9.x
mul_pp r0.w, r0, r3.z
add_pp r3.z, -r1.w, r2
mad r4.x, r1.z, c11.y, r2.z
add_pp r3.w, -r3.z, c9
add_pp r2.w, -r2, c9
cmp_pp r3.z, -r0.w, c9.w, r2.w
add_pp r0.w, -r3.z, r3
add r3.xy, -r1, r3
cmp_pp r2.w, r0, c9.x, c9
texld r0.w, r3, s0
add r2.z, -r0.w, c9.w
add r0.w, -r1, r4.x
add_pp r4.x, -r1.w, r2.z
cmp r0.w, r0, c9, c9.x
mul_pp r0.w, r0, r2
add_pp r2.w, -r4.x, c9
cmp_pp r3.w, -r0, r3.z, r3
add_pp r0.w, -r3, r2
add r3.xy, -r1, r3
cmp_pp r4.x, r0.w, c9, c9.w
texld r0.w, r3, s0
add r3.xy, -r1, r3
add r1.xy, -r1, r3
mad r2.z, r1, c11.x, r2
add r3.z, -r0.w, c9.w
add r0.w, -r1, r2.z
add_pp r2.z, -r1.w, r3
mad r3.z, r1, c10.w, r3
add r3.z, -r1.w, r3
cmp r0.w, r0, c9, c9.x
mul_pp r0.w, r0, r4.x
cmp_pp r3.w, -r0, r3, r2
add_pp r2.z, -r2, c9.w
add_pp r0.w, -r3, r2.z
cmp_pp r2.w, r0, c9.x, c9
texld r0.w, r3, s0
add r0.w, -r0, c9
cmp r3.z, r3, c9.w, c9.x
mul_pp r3.z, r3, r2.w
add_pp r4.x, -r1.w, r0.w
mad r3.x, r1.z, c10.z, r0.w
texld r0.w, r1, s0
add r1.x, -r1.w, r3
add r0.w, -r0, c9
add_pp r1.y, r0.w, -r1.w
mad r0.w, r1.z, c10.y, r0
add r0.w, r0, -r1
cmp_pp r2.z, -r3, r3.w, r2
add_pp r2.w, -r4.x, c9
add_pp r3.z, -r2, r2.w
add_pp r1.y, -r1, c9.w
cmp_pp r3.z, r3, c9.x, c9.w
cmp r1.x, r1, c9.w, c9
mul_pp r1.x, r1, r3.z
cmp_pp r1.x, -r1, r2.z, r2.w
add_pp r1.z, -r1.x, r1.y
cmp_pp r1.z, r1, c9.x, c9.w
cmp r0.w, r0, c9, c9.x
mul_pp r0.w, r0, r1.z
cmp_pp r1.x, -r0.w, r1, r1.y
texld r1.yw, r2, s2
mad_pp r3.xy, r1.wyzw, c11.y, c11.z
mov r0.w, c5.x
add r0.w, c9, -r0
mad r0.w, r0, r1.x, c5.x
mul_pp r1.x, r3.y, r3.y
mad_pp r1.w, -r3.x, r3.x, -r1.x
dp3_pp r1.y, v1, v1
rsq_pp r1.y, r1.y
mul_pp r1.xyz, r1.y, v1
add r1.xyz, r0, r1
dp3 r2.z, r1, r1
rsq r2.z, r2.z
add_pp r1.w, r1, c9
rsq_pp r1.w, r1.w
rcp_pp r1.w, r1.w
mul r3.z, r0.w, r1.w
mul r1.xyz, r2.z, r1
mov_pp r1.w, c3.x
dp3 r1.x, r3, r1
max r2.z, r1.x, c9.x
mul_pp r2.w, c11, r1
pow r1, r2.z, r2.w
add r1.zw, -v0, r2.xyxy
add r2.xy, v0, r1.zwzw
mul r2.z, r0.w, r1.x
texld r1, r2, s1
dp3 r0.x, r0, r3
mul r1.w, r2.z, r1
max r2.z, r0.x, c9.x
mul_pp r0.xyz, r1, c2
mov_pp r1.xyz, c0
mul r2.z, r0.w, r2
mul_pp r0.xyz, r0, c0
mul_pp r0.xyz, r0, r2.z
mul_pp r1.xyz, c1, r1
mad r1.xyz, r1, r1.w, r0
rcp r0.x, c7.x
mad r0.z, -r2.y, r0.x, c9.w
mad r0.y, -r2.x, r0.x, c9.w
mul r1.xyz, r0.w, r1
mul r0.w, r2.x, r0.x
cmp r0.z, r0, c9.x, c9.w
cmp r0.y, r0, c9.x, c9.w
add_pp_sat r0.y, r0, r0.z
cmp r0.z, r0.w, c9.x, c9.w
mul r0.w, r2.y, r0.x
add_pp_sat r0.x, r0.y, r0.z
cmp r0.y, r0.w, c9.x, c9.w
add_pp_sat r0.y, r0.x, r0
rcp r0.z, v3.w
mad r2.xy, v3, r0.z, c9.z
dp3 r0.x, v3, v3
texld r0.x, r0.x, s4
texld r0.w, r2, s3
cmp r0.z, -v3, c9.x, c9.w
mul_pp r0.z, r0, r0.w
mul_pp r0.z, r0, r0.x
abs_pp r0.x, r0.y
mul_pp r0.y, r0.z, c11
cmp_pp r0.x, -r0, c9.w, c9
mul oC0.xyz, r1, r0.y
add_pp oC0.w, r0.x, c8.x
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
; 223 ALU, 26 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_cube s4
def c9, 0.00000000, 9.00000000, 0.50000000, 1.00000000
def c10, 0.14285715, 6.00000000, 5.00000000, 4.00000000
def c11, 3.00000000, 2.00000000, -1.00000000, 128.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dp3 r0.x, v1, v1
rsq r0.x, r0.x
mul r0.xyz, r0.x, v1
dp3 r0.w, -r0, -r0
add r1.x, -r0.z, c9.w
mul r1.y, r1.x, r1.x
rsq r0.w, r0.w
mad r1.x, -r1.y, r1, c9.w
mul r0.xy, r0.w, -r0
mul r0.w, r1.x, c4.x
mul r1.x, r0.z, c9.y
mul r0.xy, r0, r0.w
rcp r0.w, r1.x
abs r0.z, r0
mul r0.xyz, r0, r0.w
mov r1.xy, v0.zwzw
mov r1.z, c9.x
add r2.xyz, r1, r0
texld r0.w, v0.zwzw, s0
cmp r1.xyz, -r0.w, r1, r2
texld r0.w, r1, s0
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
texld r0.w, r1, s0
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
texld r0.w, r1, s0
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
texld r0.w, r1, s0
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
texld r0.w, r1, s0
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
texld r0.w, r1, s0
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
texld r0.w, r1, s0
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
add r2.xyz, r1, r0
texld r0.w, r1, s0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
mul r0.xyz, r0, c9.z
texld r0.w, r1, s0
add r2.xyz, r1, r0
add_pp r0.w, r1.z, -r0
add r1.xyz, r1, -r0
cmp r1.xyz, r0.w, r1, r2
texld r0.w, r1, s0
add r1.w, r1.z, -r0
mul r0.xyz, r0, c9.z
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
add r2.xyz, r1, -r0
cmp r0.w, r1, c9.x, c9
abs_pp r0.w, r0
cmp r1.xyz, -r0.w, r2, r1
texld r0.w, r1, s0
add r1.w, r1.z, -r0
mul r0.xyz, r0, c9.z
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
add r2.xyz, r1, -r0
cmp r0.w, r1, c9.x, c9
abs_pp r0.w, r0
cmp r1.xyz, -r0.w, r2, r1
texld r0.w, r1, s0
add r1.w, r1.z, -r0
mul r0.xyz, r0, c9.z
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
add r2.xyz, r1, -r0
cmp r0.w, r1, c9.x, c9
abs_pp r0.w, r0
cmp r1.xyz, -r0.w, r2, r1
mul r0.xyz, r0, c9.z
texld r0.w, r1, s0
add r1.w, r1.z, -r0
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
add r2.xyz, r1, -r0
cmp r0.w, r1, c9.x, c9
abs_pp r0.z, r0.w
cmp r1.xyz, -r0.z, r2, r1
texld r0.w, r1, s0
add r0.z, r1, -r0.w
mad r2.xy, r0, c9.z, r1
add r0.w, r1.z, -r0
cmp r1.xy, r0.w, r1, r2
mad r1.zw, -r0.xyxy, c9.z, r1.xyxy
cmp r0.z, r0, c9.x, c9.w
abs_pp r0.x, r0.z
cmp r2.xy, -r0.x, r1.zwzw, r1
mov r0.y, c6.x
dp3_pp r0.x, v2, v2
add r0.w, c4.x, r0.y
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, v2
mul r1.xyz, -r0, r0.w
texld r0.w, r2, s0
mul r1.xyz, r0.w, r1
mul r1.xyz, r1, c10.x
add r4.xy, r2, -r1
add r3.xy, -r1, r4
texld r1.w, r3, s0
add r2.z, -r1.w, c9.w
texld r2.w, r4, s0
add r1.w, -r0, c9
add r2.w, -r2, c9
add r0.w, r1.z, r2
add_pp r2.w, -r1, r2
cmp_pp r3.z, -r2.w, c9.x, c9.w
add r0.w, -r1, r0
cmp r0.w, r0, c9, c9.x
mul_pp r0.w, r0, r3.z
add_pp r3.z, -r1.w, r2
mad r4.x, r1.z, c11.y, r2.z
add_pp r3.w, -r3.z, c9
add_pp r2.w, -r2, c9
cmp_pp r3.z, -r0.w, c9.w, r2.w
add_pp r0.w, -r3.z, r3
add r3.xy, -r1, r3
cmp_pp r2.w, r0, c9.x, c9
texld r0.w, r3, s0
add r2.z, -r0.w, c9.w
add r0.w, -r1, r4.x
add_pp r4.x, -r1.w, r2.z
cmp r0.w, r0, c9, c9.x
mul_pp r0.w, r0, r2
add_pp r2.w, -r4.x, c9
cmp_pp r3.w, -r0, r3.z, r3
add_pp r0.w, -r3, r2
add r3.xy, -r1, r3
cmp_pp r4.x, r0.w, c9, c9.w
texld r0.w, r3, s0
add r3.xy, -r1, r3
add r1.xy, -r1, r3
mad r2.z, r1, c11.x, r2
add r3.z, -r0.w, c9.w
add r0.w, -r1, r2.z
add_pp r2.z, -r1.w, r3
mad r3.z, r1, c10.w, r3
add r3.z, -r1.w, r3
cmp r0.w, r0, c9, c9.x
mul_pp r0.w, r0, r4.x
cmp_pp r3.w, -r0, r3, r2
add_pp r2.z, -r2, c9.w
add_pp r0.w, -r3, r2.z
cmp_pp r2.w, r0, c9.x, c9
texld r0.w, r3, s0
add r0.w, -r0, c9
cmp r3.z, r3, c9.w, c9.x
mul_pp r3.z, r3, r2.w
add_pp r4.x, -r1.w, r0.w
mad r3.x, r1.z, c10.z, r0.w
texld r0.w, r1, s0
add r1.x, -r1.w, r3
add r0.w, -r0, c9
add_pp r1.y, r0.w, -r1.w
mad r0.w, r1.z, c10.y, r0
add r0.w, r0, -r1
cmp_pp r2.z, -r3, r3.w, r2
add_pp r2.w, -r4.x, c9
add_pp r3.z, -r2, r2.w
add_pp r1.y, -r1, c9.w
cmp_pp r3.z, r3, c9.x, c9.w
cmp r1.x, r1, c9.w, c9
mul_pp r1.x, r1, r3.z
cmp_pp r1.x, -r1, r2.z, r2.w
add_pp r1.z, -r1.x, r1.y
cmp_pp r1.z, r1, c9.x, c9.w
cmp r0.w, r0, c9, c9.x
mul_pp r0.w, r0, r1.z
cmp_pp r1.x, -r0.w, r1, r1.y
texld r1.yw, r2, s2
mad_pp r3.xy, r1.wyzw, c11.y, c11.z
mov r0.w, c5.x
add r0.w, c9, -r0
mad r0.w, r0, r1.x, c5.x
mul_pp r1.x, r3.y, r3.y
mad_pp r1.w, -r3.x, r3.x, -r1.x
dp3_pp r1.y, v1, v1
rsq_pp r1.y, r1.y
mul_pp r1.xyz, r1.y, v1
add r1.xyz, r0, r1
dp3 r2.z, r1, r1
rsq r2.z, r2.z
add_pp r1.w, r1, c9
rsq_pp r1.w, r1.w
rcp_pp r1.w, r1.w
mul r3.z, r0.w, r1.w
mul r1.xyz, r2.z, r1
mov_pp r1.w, c3.x
dp3 r1.x, r3, r1
max r2.z, r1.x, c9.x
mul_pp r2.w, c11, r1
pow r1, r2.z, r2.w
add r1.zw, -v0, r2.xyxy
add r2.xy, v0, r1.zwzw
mul r2.z, r0.w, r1.x
texld r1, r2, s1
dp3 r0.x, r0, r3
mul r1.w, r2.z, r1
max r2.z, r0.x, c9.x
mul_pp r0.xyz, r1, c2
mov_pp r1.xyz, c0
mul r2.z, r0.w, r2
mul_pp r0.xyz, r0, c0
mul_pp r0.xyz, r0, r2.z
mul_pp r1.xyz, c1, r1
mad r1.xyz, r1, r1.w, r0
rcp r0.x, c7.x
mul r1.xyz, r0.w, r1
mad r0.z, -r2.y, r0.x, c9.w
mad r0.y, -r2.x, r0.x, c9.w
mul r0.w, r2.y, r0.x
cmp r0.z, r0, c9.x, c9.w
cmp r0.y, r0, c9.x, c9.w
add_pp_sat r0.y, r0, r0.z
mul r0.z, r2.x, r0.x
cmp r0.x, r0.z, c9, c9.w
cmp r0.z, r0.w, c9.x, c9.w
add_pp_sat r0.x, r0.y, r0
add_pp_sat r0.y, r0.x, r0.z
dp3 r0.x, v3, v3
texld r0.x, r0.x, s3
texld r0.w, v3, s4
mul r0.z, r0.x, r0.w
abs_pp r0.x, r0.y
mul_pp r0.y, r0.z, c11
cmp_pp r0.x, -r0, c9.w, c9
mul oC0.xyz, r1, r0.y
add_pp oC0.w, r0.x, c8.x
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
; 218 ALU, 25 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c9, 0.00000000, 9.00000000, 0.50000000, 1.00000000
def c10, 0.14285715, 6.00000000, 5.00000000, 4.00000000
def c11, 3.00000000, 2.00000000, -1.00000000, 128.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xy
dp3 r0.x, v1, v1
rsq r0.x, r0.x
mul r0.xyz, r0.x, v1
dp3 r0.w, -r0, -r0
add r1.x, -r0.z, c9.w
mul r1.y, r1.x, r1.x
rsq r0.w, r0.w
mad r1.x, -r1.y, r1, c9.w
mul r0.xy, r0.w, -r0
mul r0.w, r1.x, c4.x
mul r1.x, r0.z, c9.y
mul r0.xy, r0, r0.w
rcp r0.w, r1.x
abs r0.z, r0
mul r0.xyz, r0, r0.w
mov r1.xy, v0.zwzw
mov r1.z, c9.x
add r2.xyz, r1, r0
texld r0.w, v0.zwzw, s0
cmp r1.xyz, -r0.w, r1, r2
texld r0.w, r1, s0
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
texld r0.w, r1, s0
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
texld r0.w, r1, s0
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
texld r0.w, r1, s0
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
texld r0.w, r1, s0
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
texld r0.w, r1, s0
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
texld r0.w, r1, s0
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
add r2.xyz, r1, r0
texld r0.w, r1, s0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
mul r0.xyz, r0, c9.z
texld r0.w, r1, s0
add r2.xyz, r1, r0
add_pp r0.w, r1.z, -r0
add r1.xyz, r1, -r0
cmp r1.xyz, r0.w, r1, r2
texld r0.w, r1, s0
add r1.w, r1.z, -r0
mul r0.xyz, r0, c9.z
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
add r2.xyz, r1, -r0
cmp r0.w, r1, c9.x, c9
abs_pp r0.w, r0
cmp r1.xyz, -r0.w, r2, r1
texld r0.w, r1, s0
add r1.w, r1.z, -r0
mul r0.xyz, r0, c9.z
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
add r2.xyz, r1, -r0
cmp r0.w, r1, c9.x, c9
abs_pp r0.w, r0
cmp r1.xyz, -r0.w, r2, r1
texld r0.w, r1, s0
add r1.w, r1.z, -r0
mul r0.xyz, r0, c9.z
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
add r2.xyz, r1, -r0
cmp r0.w, r1, c9.x, c9
abs_pp r0.w, r0
cmp r1.xyz, -r0.w, r2, r1
mul r0.xyz, r0, c9.z
texld r0.w, r1, s0
add r1.w, r1.z, -r0
add r2.xyz, r1, r0
add r0.w, r1.z, -r0
cmp r1.xyz, r0.w, r1, r2
add r2.xyz, r1, -r0
cmp r0.w, r1, c9.x, c9
abs_pp r0.z, r0.w
cmp r1.xyz, -r0.z, r2, r1
texld r0.w, r1, s0
mad r2.xy, r0, c9.z, r1
add r0.z, r1, -r0.w
cmp r1.xy, r0.z, r1, r2
add r0.z, r1, -r0.w
mad r1.zw, -r0.xyxy, c9.z, r1.xyxy
cmp r0.x, r0.z, c9, c9.w
abs_pp r0.x, r0
cmp r1.xy, -r0.x, r1.zwzw, r1
texld r0.w, r1, s0
mov r0.y, c6.x
add r0.y, c4.x, r0
mul r0.xyz, -v2, r0.y
mul r0.xyz, r0.w, r0
mul r0.xyz, r0, c10.x
add r3.xy, r1, -r0
add r2.xy, -r0, r3
texld r1.w, r2, s0
texld r2.w, r3, s0
add r1.w, -r1, c9
add r1.z, -r0.w, c9.w
add r2.z, -r2.w, c9.w
add r0.w, r0.z, r2.z
add_pp r2.z, -r1, r2
cmp_pp r2.w, -r2.z, c9.x, c9
add r0.w, -r1.z, r0
cmp r0.w, r0, c9, c9.x
mul_pp r0.w, r0, r2
add_pp r2.w, -r1.z, r1
add_pp r2.z, -r2, c9.w
cmp_pp r3.x, -r0.w, c9.w, r2.z
add_pp r2.w, -r2, c9
add_pp r0.w, -r3.x, r2
mad r3.y, r0.z, c11, r1.w
add r2.xy, -r0, r2
cmp_pp r2.z, r0.w, c9.x, c9.w
texld r0.w, r2, s0
add r1.w, -r0, c9
add r0.w, -r1.z, r3.y
add_pp r3.y, -r1.z, r1.w
cmp r0.w, r0, c9, c9.x
mul_pp r0.w, r0, r2.z
cmp_pp r3.x, -r0.w, r3, r2.w
add_pp r2.z, -r3.y, c9.w
add_pp r0.w, -r3.x, r2.z
add r2.xy, -r0, r2
cmp_pp r3.y, r0.w, c9.x, c9.w
texld r0.w, r2, s0
add r2.xy, -r0, r2
add r0.xy, -r0, r2
mad r1.w, r0.z, c11.x, r1
add r2.w, -r0, c9
add r0.w, -r1.z, r1
add_pp r1.w, -r1.z, r2
mad r2.w, r0.z, c10, r2
add r2.w, -r1.z, r2
cmp r0.w, r0, c9, c9.x
mul_pp r0.w, r0, r3.y
cmp_pp r3.x, -r0.w, r3, r2.z
add_pp r1.w, -r1, c9
add_pp r0.w, -r3.x, r1
cmp_pp r2.z, r0.w, c9.x, c9.w
texld r0.w, r2, s0
add r0.w, -r0, c9
cmp r2.w, r2, c9, c9.x
mul_pp r2.w, r2, r2.z
add_pp r3.y, -r1.z, r0.w
mad r2.x, r0.z, c10.z, r0.w
texld r0.w, r0, s0
add r0.y, -r1.z, r2.x
add r0.x, -r0.w, c9.w
add_pp r0.w, r0.x, -r1.z
mad r0.x, r0.z, c10.y, r0
add r0.x, r0, -r1.z
cmp_pp r1.w, -r2, r3.x, r1
add_pp r2.z, -r3.y, c9.w
add_pp r2.w, -r1, r2.z
add_pp r0.w, -r0, c9
cmp_pp r2.w, r2, c9.x, c9
cmp r0.y, r0, c9.w, c9.x
mul_pp r0.y, r0, r2.w
cmp_pp r0.y, -r0, r1.w, r2.z
add_pp r0.z, -r0.y, r0.w
cmp_pp r0.z, r0, c9.x, c9.w
cmp r0.x, r0, c9.w, c9
mul_pp r0.x, r0, r0.z
cmp_pp r0.z, -r0.x, r0.y, r0.w
texld r0.yw, r1, s2
mad_pp r2.xy, r0.wyzw, c11.y, c11.z
mov r0.x, c5
add r0.x, c9.w, -r0
mad r1.z, r0.x, r0, c5.x
mul_pp r0.x, r2.y, r2.y
mad_pp r0.w, -r2.x, r2.x, -r0.x
dp3_pp r0.y, v1, v1
rsq_pp r0.y, r0.y
mul_pp r0.xyz, r0.y, v1
add r0.xyz, v2, r0
dp3 r1.w, r0, r0
rsq r1.w, r1.w
add_pp r0.w, r0, c9
rsq_pp r0.w, r0.w
rcp_pp r0.w, r0.w
mul r2.z, r1, r0.w
mul r0.xyz, r1.w, r0
dp3 r0.x, r2, r0
mov_pp r0.w, c3.x
max r1.w, r0.x, c9.x
mul_pp r2.w, c11, r0
pow r0, r1.w, r2.w
add r0.zw, -v0, r1.xyxy
add r1.xy, v0, r0.zwzw
mul r1.w, r1.z, r0.x
texld r0, r1, s1
mul r0.w, r1, r0
dp3 r2.x, v2, r2
max r1.w, r2.x, c9.x
mul_pp r0.xyz, r0, c2
mul_pp r2.xyz, r0, c0
mul r1.w, r1.z, r1
mov_pp r0.xyz, c0
mul_pp r2.xyz, r2, r1.w
mul_pp r0.xyz, c1, r0
mad r0.xyz, r0, r0.w, r2
rcp r0.w, c7.x
mad r1.w, -r1.y, r0, c9
mul r0.xyz, r1.z, r0
mad r1.z, -r1.x, r0.w, c9.w
mul r1.x, r1, r0.w
mul r1.y, r1, r0.w
cmp r0.w, r1.x, c9.x, c9
cmp r1.x, r1.y, c9, c9.w
cmp r1.w, r1, c9.x, c9
cmp r1.z, r1, c9.x, c9.w
add_pp_sat r1.z, r1, r1.w
add_pp_sat r0.w, r1.z, r0
add_pp_sat r1.x, r0.w, r1
texld r0.w, v3, s3
mul_pp r1.y, r0.w, c11
abs_pp r1.x, r1
cmp_pp r0.w, -r1.x, c9, c9.x
mul oC0.xyz, r0, r1.y
add_pp oC0.w, r0, c8.x
"
}
}
 }
}
Fallback "Bumped Specular"
}