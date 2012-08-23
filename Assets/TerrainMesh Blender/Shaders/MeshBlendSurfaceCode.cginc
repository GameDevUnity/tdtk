#ifndef MESH_BLEND_SURFACE_CODE
#define MESH_BLEND_SURFACE_CODE
struct Input { 
	float4 color : COLOR;
	float2 uv_MainTex : TEXCOORD0;
	float3 worldPos : TEXCOORD2;
	float3 viewDir;
};


sampler2D _MainTex;
sampler2D _BumpMap;
#ifndef SINGLE_TERRAIN_TEXTURE
sampler2D _Control; 
#endif
sampler2D _BumpMap0;
#ifndef SINGLE_TERRAIN_TEXTURE
sampler2D _BumpMap1, _BumpMap2, _BumpMap3;
#endif
sampler2D _Tex0;
#ifndef SINGLE_TERRAIN_TEXTURE
sampler2D _Tex1, _Tex2, _Tex3;
#endif
float4 _TerrainCoords;
float4 _TileSize;
float4 _TerrainSpec;
float4 _Color;
float _MeshSpec;

// Supply the shader with tangents for the terrain
void vert (inout appdata_full v, out Input o) {
	o.worldPos = mul(_Object2World, v.vertex);
	
	
	
	o.color = v.color;
}



void surf (Input IN, inout SurfaceOutput o) {


	float texBlendMod = saturate(IN.color.r);
	float2 terrain_size = _TerrainCoords.ba;
	float terrain_scaleBias = 0.04;
	
	float2 targetUV = IN.worldPos.xz - _TerrainCoords.rg;
	float2 splatCoords = targetUV / terrain_size;
		 
		 
	#ifndef SINGLE_TERRAIN_TEXTURE
	float4 terrain_splat_control = TerrainSplatControl(_Control, splatCoords);
	#endif

	half3 uv = float3(splatCoords.x * (terrain_size.x/_TileSize.x), splatCoords.y * (terrain_size.y/_TileSize.x), 0);
			 
	float4 terrain_specular = float4(0,0,0,0);
	
	half3 terrain_color = TerrainCalc(o, uv,
#ifdef SINGLE_TERRAIN_TEXTURE
	1,
#else
	terrain_splat_control.r,
#endif
	_Tex0,
	_BumpMap0, 
	_TerrainSpec.x, 
	terrain_specular.x);
#ifndef SINGLE_TERRAIN_TEXTURE
	uv = float3(splatCoords.x * (terrain_size.x/_TileSize.y), splatCoords.y * (terrain_size.y/_TileSize.y), 0);
	
	terrain_color += TerrainCalc(o, uv,
	terrain_splat_control.g,
	_Tex1,
	_BumpMap1, 
	_TerrainSpec.y, 
	terrain_specular.y);
	
	uv = float3(splatCoords.x * (terrain_size.x/_TileSize.z), splatCoords.y * (terrain_size.y/_TileSize.z), 0);
	terrain_color += TerrainCalc(o, uv,
	terrain_splat_control.b,
	_Tex2,
	_BumpMap2, 
	_TerrainSpec.z, 
	terrain_specular.z);
	
	uv = float3(splatCoords.x * (terrain_size.x/_TileSize.w), splatCoords.y * (terrain_size.y/_TileSize.w), 0);
	terrain_color += TerrainCalc(o, uv,
	terrain_splat_control.a,
	_Tex3, 
	_BumpMap3, 
	_TerrainSpec.w, 
	terrain_specular.w); 
	
	#endif
	#ifndef NO_TERRAIN_BUMP
	o.Normal = normalize(o.Normal);
	#endif
	half4 texColor = tex2D(_MainTex,  IN.uv_MainTex.xy) * _Color;	
	half3 terrainTexColor = (terrain_color * texBlendMod).rgb;
		
		 
	#ifndef NO_TERRAIN_BUMP
	o.Gloss = terrain_specular.x + terrain_specular.y + terrain_specular.z + terrain_specular.w;
		
	o.Gloss = o.Gloss * texBlendMod + texColor.a * (1 - texBlendMod);
	o.Specular = o.Specular * texBlendMod + (_MeshSpec * (1 - texBlendMod));
	#endif
		


	     
	o.Albedo = terrainTexColor + (texColor.rgb * (1 - texBlendMod)); 
}
#endif

