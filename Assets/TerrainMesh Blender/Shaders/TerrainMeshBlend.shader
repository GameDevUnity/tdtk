// Upgrade NOTE: commented out 'float4 unity_ShadowFadeCenterAndType', a built-in variable

Shader "Terrain-Mesh Blend/Terrain-Mesh Blend" {
Properties {
	_Color ("Main Color", Color) = (1,1,1,1)
	_SpecColor ("Specular Color", Color) = (0.5,0.5,0.5,1)
	_MeshSpec ("Shininess", Range (0.03, 1)) = 0.078125
	_MainTex ("BaseMap (RGBA)", 2D) = "white" {}
	_BumpMap ("Normal Map", 2D) = "normal" {}
	_Tex0 ("Internal Data", 2D) = "black" {}
	_Tex1 ("Internal Data", 2D) = "black" {}
	_Tex2 ("Internal Data", 2D) = "black" {}
	_Tex3 ("Internal Data", 2D) = "black" {}
	_BumpMap0 ("Internal Data", 2D) = "normal" {}
	_BumpMap1 ("Internal Data", 2D) = "normal" {}
	_BumpMap2 ("Internal Data", 2D) = "normal" {}
	_BumpMap3 ("Internal Data", 2D) = "normal" {}
	_Control ("Internal Data", 2D) = "black" {}
	_TileSize ("Internal Data", Vector) = (1,1,1,1)
	_TerrainCoords ("Internal Data", Vector) = (0,0,0,0)
	_TerrainSpec ("Internal Data", Vector) = (1,1,1,1)
}
	
SubShader {
	Tags {
		"SplatCount" = "4"
		"Queue" = "Geometry"
		"RenderType" = "Opaque"
	}	

	
	Pass {
		Name "FORWARD"
		Tags { "LightMode" = "ForwardBase" }

CGPROGRAM
#pragma vertex vert_surf
#pragma fragment frag_surf
#pragma target 3.0
#pragma fragmentoption ARB_precision_hint_fastest
#pragma multi_compile_fwdbase
#include "HLSLSupport.cginc"
#define UNITY_PASS_FORWARDBASE
#include "UnityCG.cginc"
#include "Lighting.cginc"
#include "AutoLight.cginc"

#define INTERNAL_DATA
#define WorldReflectionVector(data,normal) data.worldRefl
#define WorldNormalVector(data,normal) normal

#include "GeneralTerrainCode.cginc"
#include "MeshBlendSurfaceCode.cginc"

//#pragma surface surf BlinnPhong



sampler2D _Splat0,_Splat1,_Splat2,_Splat3;


#ifdef LIGHTMAP_OFF
struct v2f_surf {
  float4 pos : SV_POSITION;
  float3 terrainNormal : COLOR;
  float4 uv_MainTex : TEXCOORD0;
  float3 worldPos : TEXCOORD1;
  float4 viewDir : TEXCOORD2;
  fixed3 lightDir : TEXCOORD3;
  fixed3 vlight : TEXCOORD4;
  float3 normal : TEXCOORD5;
  float4 tangent : TEXCOORD6;
  LIGHTING_COORDS(7,8)
};
#endif
#ifndef LIGHTMAP_OFF
struct v2f_surf {
  float4 pos : SV_POSITION;
  float3 terrainNormal : COLOR;
  float4 uv_MainTex : TEXCOORD0;
  float3 worldPos : TEXCOORD1;
  float4 viewDir : TEXCOORD2;
  float2 lmap : TEXCOORD3;
  float3 normal : TEXCOORD4;
  float4 tangent : TEXCOORD5;
  LIGHTING_COORDS(6,7)  
};
#endif
#ifndef LIGHTMAP_OFF
float4 unity_LightmapST;
// float4 unity_ShadowFadeCenterAndType;
#endif
float4 _Control_ST;
float4 _MainTex_ST;
float4 _Splat0_ST;
float4 _Splat1_ST;
float4 _Splat2_ST;
float4 _Splat3_ST;
half3 decode (half2 enc)
{
    half2 fenc = enc*4-2;
    half f = dot(fenc,fenc);
    half g = sqrt(1-f/4);
    half3 n;
    n.xy = fenc*g;
    n.z = 1-f/2;
    return n;
}
v2f_surf vert_surf (appdata_full v) {
  v2f_surf o;
  Input customInputData;
  o.normal = v.normal;
  o.tangent = v.tangent;
  vert (v, customInputData);	
  o.worldPos = customInputData.worldPos;
  o.pos = mul (UNITY_MATRIX_MVP, v.vertex);
  o.uv_MainTex.xy = TRANSFORM_TEX(v.texcoord, _MainTex);
  o.uv_MainTex.zw = v.color.rg;
  o.viewDir.a = 1;
  #ifndef LIGHTMAP_OFF
  o.lmap.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
  #endif
  o.normal = mul((float3x3)_Object2World, SCALED_NORMAL);
  TANGENT_SPACE_ROTATION;
  float3 lightDir = WorldSpaceLightDir(v.vertex);
  #ifdef LIGHTMAP_OFF
  o.lightDir = lightDir;
  #if !VERTEXLIGHT_ON
  o.viewDir.a = 0;
  #endif
  #endif
  #if defined (LIGHTMAP_OFF) || !defined (DIRLIGHTMAP_OFF)
  float3 viewDirForLight = WorldSpaceViewDir(v.vertex);
  o.viewDir.xyz = viewDirForLight;
  #endif
  o.normal = v.normal;
  o.terrainNormal = decode(v.color.ba);
  TRANSFER_VERTEX_TO_FRAGMENT(o);
  return o;
}
#ifndef LIGHTMAP_OFF
sampler2D unity_Lightmap;
#ifndef DIRLIGHTMAP_OFF
sampler2D unity_LightmapInd;
#endif
#endif
fixed4 frag_surf (v2f_surf IN) : COLOR {
   Input surfIN;
  surfIN.uv_MainTex = IN.uv_MainTex.xy;
  surfIN.viewDir = IN.viewDir;
  surfIN.worldPos = IN.worldPos;
  surfIN.color.rg = IN.uv_MainTex.zw;
  
  SurfaceOutput o;
  o.Albedo = 0.0;
  o.Emission = 0.0;
  o.Specular = 0.0; 
  o.Alpha = 0.0;
  o.Gloss = 0.0;
  
  float3 OtoW0 = ((float3x3)_Object2World)[0].xyz * unity_Scale.w;
  float3 OtoW1 = ((float3x3)_Object2World)[1].xyz * unity_Scale.w;
  float3 OtoW2 = ((float3x3)_Object2World)[2].xyz * unity_Scale.w;
  
  float3 binormal = normalize(cross( IN.normal, IN.tangent.xyz ) * IN.tangent.w);
  float3x3 rotation = float3x3( IN.tangent.xyz, binormal, IN.normal );
	
  
  float3 meshTtoW0 = mul(rotation, OtoW0);
  float3 meshTtoW1 = mul(rotation, OtoW1);
  float3 meshTtoW2 = mul(rotation, OtoW2);
   
  float blendMod = saturate( IN.uv_MainTex.w);
  float2 terrain_size = _TerrainCoords.ba;
  float2 targetUV = surfIN.worldPos.xz - _TerrainCoords.rg;
  float2 splatCoords = targetUV / terrain_size;
  float3 terrainNormal = IN.terrainNormal;
  
  
  float3 terrainTangent = float3(-1,0,0);
  float3 terrainBinormal = cross(terrainNormal, terrainTangent);
	
  terrainTangent = normalize(cross(terrainNormal, terrainBinormal));
  
  rotation = float3x3( terrainTangent.xyz, -terrainBinormal, terrainNormal );
  
  rotation = transpose(rotation);
  float3 terrainTtoW0 = rotation[0].xyz;
  float3 terrainTtoW1 = rotation[1].xyz;
  float3 terrainTtoW2 = rotation[2].xyz;
  
  
  o.Normal = 0;
  surf (surfIN, o);
  float3 terrainBlendNormal = o.Normal;

  float3 worldTerrainBlendNormal;
  worldTerrainBlendNormal.x = dot(terrainTtoW0, terrainBlendNormal);
  worldTerrainBlendNormal.y = dot(terrainTtoW1, terrainBlendNormal);
  worldTerrainBlendNormal.z = dot(terrainTtoW2, terrainBlendNormal);

  
  float3 meshNormalMap = UnpackNormal(tex2D(_BumpMap, IN.uv_MainTex.xy)).xyz;
  float3 worldNormalMapNormal;
  worldNormalMapNormal.x = dot(meshTtoW0, meshNormalMap);
  worldNormalMapNormal.y = dot(meshTtoW1, meshNormalMap);
  worldNormalMapNormal.z = dot(meshTtoW2, meshNormalMap);
  
  o.Normal = normalize(lerp(worldNormalMapNormal, worldTerrainBlendNormal, blendMod));

  fixed atten = LIGHT_ATTENUATION(IN);
  fixed4 c = 0;
  #ifdef LIGHTMAP_OFF

  c = LightingBlinnPhong (o, normalize(IN.lightDir), normalize(IN.viewDir), atten);
  //float3 shlight = ShadeSH9 (float4(o.Normal,1.0));
  //IN.vlight = shlight;
  IN.vlight = UNITY_LIGHTMODEL_AMBIENT.xyz * 2; // replace ShadeSH9 because what it actually only does is apply ambient light times 2 :<

  c.rgb += o.Albedo * IN.vlight;
  #endif // LIGHTMAP_OFF
  #ifndef LIGHTMAP_OFF
  #ifdef DIRLIGHTMAP_OFF
  fixed4 lmtex = tex2D(unity_Lightmap, IN.lmap.xy);
  fixed3 lm = DecodeLightmap (lmtex);
  #else
  half3 specColor;
  fixed4 lmtex = tex2D(unity_Lightmap, IN.lmap.xy);
  fixed4 lmIndTex = tex2D(unity_LightmapInd, IN.lmap.xy);
  half3 lm = LightingBlinnPhong_DirLightmap(o, lmtex, lmIndTex, normalize(half3(IN.viewDir)), 1, specColor).rgb;
  c.rgb += specColor;
  #endif
  #ifdef SHADOWS_SCREEN
  #if defined(SHADER_API_GLES) && defined(SHADER_API_MOBILE)
  c.rgb += o.Albedo * min(lm, atten*2);
  #else
  c.rgb += o.Albedo * max(min(lm,(atten*2)*lmtex.rgb), lm*atten);
  #endif
  #else // SHADOWS_SCREEN
  c.rgb += o.Albedo * lm;
  #endif // SHADOWS_SCREEN
  c.a = o.Alpha;
#endif // LIGHTMAP_OFF

  return c;
}

ENDCG
}

	
	Pass {
		Name "FORWARD"
		Tags { "LightMode" = "ForwardAdd" }
		ZWrite Off Blend One One Fog { Color (0,0,0,0) }

CGPROGRAM
#pragma vertex vert_surf
#pragma fragment frag_surf
#pragma target 3.0
#pragma fragmentoption ARB_precision_hint_fastest
#pragma multi_compile_fwdadd
#include "HLSLSupport.cginc"
#define UNITY_PASS_FORWARDADD
#include "UnityCG.cginc"
#include "Lighting.cginc"
#include "AutoLight.cginc"

#define INTERNAL_DATA
#define WorldReflectionVector(data,normal) data.worldRefl
#define WorldNormalVector(data,normal) normal

#include "GeneralTerrainCode.cginc"
#include "MeshBlendSurfaceCode.cginc"

sampler2D _Splat0,_Splat1,_Splat2,_Splat3;

struct v2f_surf {
  float4 pos : SV_POSITION;
  float3 terrainNormal : COLOR;
  float4 uv_MainTex : TEXCOORD0;
  float3 worldPos : TEXCOORD1;
  float4 viewDir : TEXCOORD2;
  fixed3 lightDir : TEXCOORD3;
  float3 normal : TEXCOORD4;
  float4 tangent : TEXCOORD5;
  LIGHTING_COORDS(6,7)
};

float4 _Control_ST;
float4 _MainTex_ST;
float4 _Splat0_ST;
float4 _Splat1_ST;
float4 _Splat2_ST;
float4 _Splat3_ST;
half3 decode (half2 enc)
{
    half2 fenc = enc*4-2;
    half f = dot(fenc,fenc);
    half g = sqrt(1-f/4);
    half3 n;
    n.xy = fenc*g;
    n.z = 1-f/2;
    return n;
}
v2f_surf vert_surf (appdata_full v) {
  v2f_surf o;
  Input customInputData;
  o.normal = v.normal;
  o.tangent = v.tangent;
  vert (v, customInputData);	
  o.worldPos = customInputData.worldPos;
  o.pos = mul (UNITY_MATRIX_MVP, v.vertex);
  o.uv_MainTex.xy = TRANSFORM_TEX(v.texcoord, _MainTex);
  o.uv_MainTex.zw = v.color.rg;
  o.viewDir.a = 1;
  o.normal = mul((float3x3)_Object2World, SCALED_NORMAL);
  TANGENT_SPACE_ROTATION;
  float3 lightDir = WorldSpaceLightDir(v.vertex);
  o.lightDir = lightDir;
  #if !VERTEXLIGHT_ON
  o.viewDir.a = 0;
  #endif
  
  float3 viewDirForLight = WorldSpaceViewDir(v.vertex);
  o.viewDir.xyz = viewDirForLight;
  
  o.normal = v.normal;
  o.terrainNormal = decode(v.color.ba);
  TRANSFER_VERTEX_TO_FRAGMENT(o);
  return o;
}
#ifndef LIGHTMAP_OFF
sampler2D unity_Lightmap;
#ifndef DIRLIGHTMAP_OFF
sampler2D unity_LightmapInd;
#endif
#endif
fixed4 frag_surf (v2f_surf IN) : COLOR {
   Input surfIN;
  surfIN.uv_MainTex = IN.uv_MainTex.xy;
  surfIN.viewDir = IN.viewDir;
  surfIN.worldPos = IN.worldPos;
  surfIN.color.rg = IN.uv_MainTex.zw;
  
  SurfaceOutput o;
  o.Albedo = 0.0;
  o.Emission = 0.0;
  o.Specular = 0.0; 
  o.Alpha = 0.0;
  o.Gloss = 0.0;
  
  float3 OtoW0 = ((float3x3)_Object2World)[0].xyz * unity_Scale.w;
  float3 OtoW1 = ((float3x3)_Object2World)[1].xyz * unity_Scale.w;
  float3 OtoW2 = ((float3x3)_Object2World)[2].xyz * unity_Scale.w;
  
  float3 binormal = normalize(cross( IN.normal, IN.tangent.xyz ) * IN.tangent.w);
  float3x3 rotation = float3x3( IN.tangent.xyz, binormal, IN.normal );
	
  
  float3 meshTtoW0 = mul(rotation, OtoW0);
  float3 meshTtoW1 = mul(rotation, OtoW1);
  float3 meshTtoW2 = mul(rotation, OtoW2);
   
  float blendMod = saturate( IN.uv_MainTex.w);
  float2 terrain_size = _TerrainCoords.ba;
  float2 targetUV = surfIN.worldPos.xz - _TerrainCoords.rg;
  float2 splatCoords = targetUV / terrain_size;
  float3 terrainNormal = IN.terrainNormal;
  
  
  float3 terrainTangent = float3(-1,0,0);
  float3 terrainBinormal = cross(terrainNormal, terrainTangent);
	
  terrainTangent = normalize(cross(terrainNormal, terrainBinormal));
  
  rotation = float3x3( terrainTangent.xyz, -terrainBinormal, terrainNormal );
  
  rotation = transpose(rotation);
  float3 terrainTtoW0 = rotation[0].xyz;
  float3 terrainTtoW1 = rotation[1].xyz;
  float3 terrainTtoW2 = rotation[2].xyz;
  
  
  o.Normal = 0;
  surf (surfIN, o);
  float3 terrainBlendNormal = o.Normal;

  float3 worldTerrainBlendNormal;
  worldTerrainBlendNormal.x = dot(terrainTtoW0, terrainBlendNormal);
  worldTerrainBlendNormal.y = dot(terrainTtoW1, terrainBlendNormal);
  worldTerrainBlendNormal.z = dot(terrainTtoW2, terrainBlendNormal);

  
  float3 meshNormalMap = UnpackNormal(tex2D(_BumpMap, IN.uv_MainTex.xy)).xyz;
  float3 worldNormalMapNormal;
  worldNormalMapNormal.x = dot(meshTtoW0, meshNormalMap);
  worldNormalMapNormal.y = dot(meshTtoW1, meshNormalMap);
  worldNormalMapNormal.z = dot(meshTtoW2, meshNormalMap);
  
  o.Normal = normalize(lerp(worldNormalMapNormal, worldTerrainBlendNormal, blendMod));
  fixed atten = LIGHT_ATTENUATION(IN);
  fixed4 c = 0;
  c = LightingBlinnPhong (o, normalize(IN.lightDir), normalize(IN.viewDir), atten);  

  return c;
}

ENDCG
}


Pass {
		Name "PREPASS"
		Tags { "LightMode" = "PrePassBase" }
		Fog {Mode Off}

CGPROGRAM
#pragma vertex vert_surf
#pragma fragment frag_surf
#pragma fragmentoption ARB_precision_hint_fastest

#include "HLSLSupport.cginc"
#define UNITY_PASS_PREPASSBASE
#include "UnityCG.cginc"
#include "Lighting.cginc"
#include "GeneralTerrainCode.cginc"
#include "MeshBlendSurfaceCode.cginc"

#define INTERNAL_DATA
#define WorldReflectionVector(data,normal) data.worldRefl
#define WorldNormalVector(data,normal) normal


//#pragma surface surf BlinnPhong
#pragma target 3.0

sampler2D _Splat0,_Splat1,_Splat2,_Splat3;


float4 _MainTex_ST;
struct v2f_surf {
  float4 pos : SV_POSITION;
  float3 terrainNormal : COLOR;
  float4 uv_MainTex : TEXCOORD0;
  float3 cust_eye : TEXCOORD1;
  float3 worldPos : TEXCOORD2;
  float3 OtoW0 : TEXCOORD3;
  float3 OtoW1 : TEXCOORD4;
  float3 OtoW2 : TEXCOORD5;
  float3 normal : TEXCOORD6;
  float4 tangent : TEXCOORD7;
};
half3 decode (half2 enc)
{
    half2 fenc = enc*4-2;
    half f = dot(fenc,fenc);
    half g = sqrt(1-f/4);
    half3 n;
    n.xy = fenc*g;
    n.z = 1-f/2;
    return n;
}
v2f_surf vert_surf (appdata_full v) {
  v2f_surf o;
  Input customInputData;
  vert (v, customInputData);
  o.cust_eye = customInputData.viewDir;

  o.worldPos = customInputData.worldPos;
  o.pos = mul (UNITY_MATRIX_MVP, v.vertex);
  o.uv_MainTex.xy = TRANSFORM_TEX(v.texcoord, _MainTex);
  o.uv_MainTex.zw = v.color.rg;
  o.OtoW0 = ((float3x3)_Object2World)[0].xyz * unity_Scale.w;
  o.OtoW1 = ((float3x3)_Object2World)[1].xyz * unity_Scale.w;
  o.OtoW2 = ((float3x3)_Object2World)[2].xyz * unity_Scale.w;
  o.normal = v.normal;
  o.tangent = v.tangent;
  o.terrainNormal = decode(v.color.ba);

  return o;
}
fixed4 frag_surf (v2f_surf IN) : COLOR {
   Input surfIN;
  surfIN.uv_MainTex = IN.uv_MainTex.xy;
  surfIN.viewDir = IN.cust_eye;
  surfIN.worldPos = IN.worldPos;
  surfIN.color.rg = IN.uv_MainTex.zw;
  SurfaceOutput o;
  o.Albedo = 0.0;
  o.Emission = 0.0;
  o.Specular = 0.0; 
  o.Alpha = 0.0;
  o.Gloss = 0.0;
  float3 OtoW0 = IN.OtoW0;
  float3 OtoW1 = IN.OtoW1;
  float3 OtoW2 = IN.OtoW2;
  
  float3 binormal = cross( IN.normal, IN.tangent.xyz ) * IN.tangent.w; 
  float3x3 rotation = float3x3( IN.tangent.xyz, binormal, IN.normal );
	
  
  float3 meshTtoW0 = mul(rotation, OtoW0);
  float3 meshTtoW1 = mul(rotation, OtoW1);
  float3 meshTtoW2 = mul(rotation, OtoW2);
  

  
  float blendMod = saturate( IN.uv_MainTex.w);
  float2 terrain_size = _TerrainCoords.ba;
  float2 targetUV = surfIN.worldPos.xz - _TerrainCoords.rg;
  float2 splatCoords = targetUV / terrain_size;
  float3 terrainNormal = IN.terrainNormal;
  
  
  
  float3 terrainTangent = float3(-1,0,0);
  float3 terrainBinormal = cross(terrainNormal, terrainTangent);
	
  terrainTangent = cross(terrainNormal, terrainBinormal);
  
  rotation = float3x3( terrainTangent.xyz, -terrainBinormal, terrainNormal );
  
  rotation = transpose(rotation);
  float3 terrainTtoW0 = rotation[0].xyz;
  float3 terrainTtoW1 = rotation[1].xyz;
  float3 terrainTtoW2 = rotation[2].xyz;
  
  
  float3 meshNormalMap = UnpackNormal(tex2D(_BumpMap, IN.uv_MainTex.xy)).xyz;
  o.Normal = 0;
  surf (surfIN, o);
  float3 terrainBlendNormal = o.Normal;
  
  float3 worldTerrainBlendNormal;
  worldTerrainBlendNormal.x = dot(terrainTtoW0, terrainBlendNormal);
  worldTerrainBlendNormal.y = dot(terrainTtoW1, terrainBlendNormal);
  worldTerrainBlendNormal.z = dot(terrainTtoW2, terrainBlendNormal);
  
  float3 worldNormalMapNormal;
  worldNormalMapNormal.x = dot(meshTtoW0, meshNormalMap);
  worldNormalMapNormal.y = dot(meshTtoW1, meshNormalMap);
  worldNormalMapNormal.z = dot(meshTtoW2, meshNormalMap);


  o.Normal = lerp(worldNormalMapNormal, worldTerrainBlendNormal, blendMod);
  
  fixed4 res;
  res.rgb = o.Normal * 0.5 + 0.5; 
  res.a = o.Specular;
  return res;
}

ENDCG

}

Pass {
		Name "PREPASS"
		Tags { "LightMode" = "PrePassFinal" }
		ZWrite Off

CGPROGRAM
#pragma vertex vert_surf
#pragma fragment frag_surf
#pragma fragmentoption ARB_precision_hint_fastest
#pragma multi_compile_prepassfinal
#include "HLSLSupport.cginc"
#define UNITY_PASS_PREPASSFINAL
#include "UnityCG.cginc"
#include "Lighting.cginc"
#pragma target 3.0

#define INTERNAL_DATA
#define WorldReflectionVector(data,normal) data.worldRefl
#define WorldNormalVector(data,normal) normal

#include "GeneralTerrainCode.cginc"
#include "MeshBlendSurfaceCode.cginc"



struct v2f_surf {
  float4 pos : SV_POSITION;
  float4 color : TEXCOORD0;
  float2 uv_MainTex : TEXCOORD1;
  float3 viewDir : TEXCOORD2;
  float3 worldPos : TEXCOORD3;
  float4 screen : TEXCOORD4;
#ifndef LIGHTMAP_OFF
  float2 lmap : TEXCOORD6;
  float4 lmapFadePos : TEXCOORD7;
#else
  float3 vLight : TEXCOORD5;
  float3 normal : TEXCOORD6;
#endif
};
#ifndef LIGHTMAP_OFF
float4 unity_LightmapST;
#ifdef DIRLIGHTMAP_OFF
// float4 unity_ShadowFadeCenterAndType;
#endif
#endif
float4 _Control_ST;
float4 _Splat0_ST;
float4 _Splat1_ST;
float4 _Splat2_ST;
float4 _Splat3_ST;
float4 _MainTex_ST;
v2f_surf vert_surf (appdata_full v) {
  v2f_surf o;
  Input customInputData;
  vert (v, customInputData);
  o.viewDir = customInputData.viewDir;
  o.worldPos = customInputData.worldPos;
  o.color = customInputData.color;
  o.pos = mul (UNITY_MATRIX_MVP, v.vertex); 
  o.uv_MainTex.xy = TRANSFORM_TEX(v.texcoord, _MainTex);
  o.screen = ComputeScreenPos (o.pos);
  
#ifndef LIGHTMAP_OFF
  o.lmap.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
  #ifdef DIRLIGHTMAP_OFF
    o.lmapFadePos.xyz = (mul(_Object2World, v.vertex).xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w;
    o.lmapFadePos.w = (-mul(UNITY_MATRIX_MV, v.vertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w);
  #endif
#else
	o.vLight = ShadeSH9 (float4(float3(0,1,0),1.0)); // ambient color. UNITY_LIGHTMODEL_AMBIENT doesnt seems to work in deferred
#endif
  return o;
}
sampler2D _LightBuffer;
#if defined (SHADER_API_XBOX360) && defined (HDR_LIGHT_PREPASS_ON)
sampler2D _LightSpecBuffer;
#endif
#ifndef LIGHTMAP_OFF
sampler2D unity_Lightmap;
sampler2D unity_LightmapInd;
float4 unity_LightmapFade;
#endif
fixed4 unity_Ambient;
fixed4 frag_surf (v2f_surf IN) : COLOR {
  Input surfIN;
  surfIN.viewDir = IN.viewDir;
  surfIN.color = IN.color;
  surfIN.worldPos = IN.worldPos;
  surfIN.uv_MainTex = IN.uv_MainTex.xy;
  SurfaceOutput o;
  o.Albedo = 0.0;
  o.Emission = 0.0;
  o.Specular = 0.0;
  o.Alpha = 0.0;
  o.Gloss = 0.0;
  surf (surfIN, o);	
  half4 light = tex2Dproj (_LightBuffer, UNITY_PROJ_COORD(IN.screen));
#if defined (SHADER_API_GLES)
  light = max(light, half4(0.001)); 
#endif
#ifndef HDR_LIGHT_PREPASS_ON
  light = -log2(light);
#endif
#if defined (SHADER_API_XBOX360) && defined (HDR_LIGHT_PREPASS_ON)
  light.w = tex2Dproj (_LightSpecBuffer, UNITY_PROJ_COORD(IN.screen)).r;
#endif
#ifndef LIGHTMAP_OFF
#ifdef DIRLIGHTMAP_OFF
  half3 lmFull = DecodeLightmap (tex2D(unity_Lightmap, IN.lmap.xy));
  half3 lmIndirect = DecodeLightmap (tex2D(unity_LightmapInd, IN.lmap.xy));
  float lmFade = length (IN.lmapFadePos) * unity_LightmapFade.z + unity_LightmapFade.w;
  half3 lm = lerp (lmIndirect, lmFull, saturate(lmFade));
  light.rgb += lm;
#else
  fixed4 lmtex = tex2D(unity_Lightmap, IN.lmap.xy);
  fixed4 lmIndTex = tex2D(unity_LightmapInd, IN.lmap.xy);
  half3 specColor;
  half3 lm = LightingBlinnPhong_DirLightmap(o, lmtex, lmIndTex, normalize(half3(IN.viewDir)), 1, specColor).rgb;
  light.rgb += lm;
  light.a += specColor;
#endif
#else 
  light.rgb += IN.vLight;
#endif
  half4 c = LightingBlinnPhong_PrePass (o, light);
  return c;

}

ENDCG
}
}
FallBack "Diffuse"
}