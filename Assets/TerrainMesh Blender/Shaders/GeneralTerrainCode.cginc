#ifndef GENERAL_TERRAIN_CODE
#define GENERAL_TERRAIN_CODE

inline float4 TerrainSplatControl(sampler2D controlTex, float2 controlUV) 
{
	return tex2D (controlTex, controlUV);
}

inline half3 TerrainCalc(inout SurfaceOutput o, float2 uv,
float terrain_splat_control,
sampler2D terrain_texture,
sampler2D terrain_normalMap,
float terrain_gloss,
out float terrain_specular)
{
	
	half3 terrain_color;
	float4 texColor = tex2D (terrain_texture, uv.xy);
	terrain_color  = terrain_splat_control * texColor.rgb;

				
	float3 normalFix;
	#ifdef LIGHTMAP_ON
	normalFix = float3(1, 1, -1);
	#else
	normalFix = float3(1,-1, 1);
	#endif		

	terrain_specular = terrain_splat_control* texColor.a;
	#ifndef NO_TERRAIN_BUMP
	o.Normal += terrain_splat_control * (normalFix * UnpackNormal(tex2D(terrain_normalMap, uv.xy)));
	o.Specular += terrain_splat_control * terrain_gloss;
	#endif
	return terrain_color;

}

#endif