Shader "Terrain-Mesh Blend/Terrain-Mesh Blend Diffuse" {
Properties {
	_Color ("Main Color", Color) = (1,1,1,1)
	_MainTex ("BaseMap (RGBA)", 2D) = "white" {}
	_Tex0 ("Internal Data", 2D) = "black" {}
	_Tex1 ("Internal Data", 2D) = "black" {}
	_Tex2 ("Internal Data", 2D) = "black" {}
	_Tex3 ("Internal Data", 2D) = "black" {}
	_Control ("Internal Data", 2D) = "black" {}
	_TileSize ("Internal Data", Vector) = (1,1,1,1)
	_TerrainCoords ("Internal Data", Vector) = (0,0,0,0)
	_TerrainSpec ("Internal Data", Vector) = (1,1,1,1)
}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf BlinnPhong vertex:vert_dif
		#pragma target 3.0
		#define NO_TERRAIN_BUMP
		#include "GeneralTerrainCode.cginc"
		#include "MeshBlendSurfaceCode.cginc"

		
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
		void vert_dif(inout appdata_full v) {
			half3 terrainNormal = decode(v.color.ba);
			v.normal = lerp(v.normal, terrainNormal, v.color.g);	
			float4 tangenten = float4(-1,0,0,1);
			float3 binormalen = cross(terrainNormal, tangenten.xyz);
			tangenten.xyz = cross(terrainNormal, binormalen);
	
			tangenten.xyz = normalize(tangenten);
			v.tangent = lerp(v.tangent, tangenten, v.color.g);
		}
		
		ENDCG
	} 
	FallBack "Diffuse"
}
