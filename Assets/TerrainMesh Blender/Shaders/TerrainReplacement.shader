Shader "Hidden/TerrainEngine/Splatmap/Lightmap-FirstPass" {
Properties {
	_Control ("Control (RGBA)", 2D) = "red" {}
	_Splat3 ("Layer 3 (A)", 2D) = "white" {}
	_Splat2 ("Layer 2 (B)", 2D) = "white" {}
	_Splat1 ("Layer 1 (G)", 2D) = "white" {}
	_Splat0 ("Layer 0 (R)", 2D) = "white" {}
	_TerrainBumpMap3 ("Layer 3 (A)", 2D) = "normal" {}
	_TerrainBumpMap2 ("Layer 2 (B)", 2D) = "normal" {}
	_TerrainBumpMap1 ("Layer 1 (G)", 2D) = "normal" {}
	_TerrainBumpMap0 ("Layer 0 (R)", 2D) = "normal" {}
	_TerrainSpec ("Gloss (A)", Float) = (0,0,0,0)
	// used in fallback on old cards
	_MainTex ("BaseMap (RGB)", 2D) = "white" {}
	_Color ("Main Color", Color) = (1,1,1,1)
}
	
SubShader {
	Tags {
		"SplatCount" = "4"
		"Queue" = "Geometry-100"
		"RenderType" = "Opaque"
	}
CGPROGRAM
#pragma surface surf BlinnPhong vertex:vert
#include "GeneralTerrainCode.cginc"
#pragma target 3.0
#pragma debug

struct Input {
	float2 uv_Control : TEXCOORD0;
	float4 pack0 : TEXCOORD0;
	float4 pack1 : TEXCOORD1;
	float2 pack2 : TEXCOORD2;
	float3 viewDir : TEXCOORD3;
	float4 tangent : TEXCOORD4;
};


sampler2D _Control;
sampler2D _Splat0,_Splat1,_Splat2,_Splat3;
float4 _Control_ST;
float4 _Splat0_ST;
float4 _Splat1_ST;
float4 _Splat2_ST;
float4 _Splat3_ST;

sampler2D _TerrainBumpMap0, _TerrainBumpMap1, _TerrainBumpMap2, _TerrainBumpMap3;
float4 _TerrainSpec;

sampler2D _Parallax0, _Parallax1, _Parallax2, _Parallax3;

void vert (inout appdata_full v, out Input o) {

  o.viewDir = WorldSpaceViewDir(v.vertex);
	float3 tangenten = float3(-1,0,0);
	float3 binormalen = cross(v.normal, tangenten);
	tangenten = cross(v.normal, binormalen);
	
	v.tangent.xyz = normalize(tangenten);
	v.tangent.w = 1;
	 o.tangent = v.tangent;
  o.pack0.xy = TRANSFORM_TEX(v.texcoord, _Control);
  o.pack0.zw = TRANSFORM_TEX(v.texcoord, _Splat0);
  o.pack1.xy = TRANSFORM_TEX(v.texcoord, _Splat1);
  o.pack1.zw = TRANSFORM_TEX(v.texcoord, _Splat2);
  o.pack2.xy = TRANSFORM_TEX(v.texcoord, _Splat3);
}

void surf (Input IN, inout SurfaceOutput o) {

	float4 terrain_splat_control = tex2D(_Control, IN.pack0.xy);
	o.Normal = 0;

	float4 terrain_specular;
	
	half3 terrain_color = TerrainCalc(o, IN.pack0.zw,
	terrain_splat_control.r,
	_Splat0,
	_TerrainBumpMap0, 
	_TerrainSpec.x, 
	terrain_specular.x);

	
	terrain_color += TerrainCalc(o, IN.pack1.xy,
	terrain_splat_control.g,
	_Splat1,
	_TerrainBumpMap1, 
	_TerrainSpec.y, 
	terrain_specular.y); 
	
	terrain_color += TerrainCalc(o, IN.pack1.zw,
	terrain_splat_control.b,
	_Splat2,
	_TerrainBumpMap2, 
	_TerrainSpec.z, 
	terrain_specular.z);
	
	terrain_color += TerrainCalc(o, IN.pack2.xy,
	terrain_splat_control.a,
	_Splat3, 
	_TerrainBumpMap3, 
	_TerrainSpec.w, 
	terrain_specular.w);
	
	o.Normal = normalize(o.Normal);

	o.Gloss = terrain_specular.x + terrain_specular.y + terrain_specular.z + terrain_specular.w;
	
	o.Albedo = terrain_color;
	o.Specular = _TerrainSpec.x * terrain_splat_control.r + _TerrainSpec.y * terrain_splat_control.g + _TerrainSpec.z * terrain_splat_control.b + _TerrainSpec.w * terrain_splat_control.a;
	
}
ENDCG  
}

// Fallback to Diffuse
Fallback "Diffuse"
}
