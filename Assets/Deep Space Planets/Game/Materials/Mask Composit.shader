Shader "XenitShaders/Lerp" {
	Properties {
		_Color ("Main Color", Color) = (1,1,1) 
		_ColorSecond ("Second Color", Color) = (1,1,1) 
	   	_SpecularColor ("Specular Color", Color) = (1,1,1) 
	   	_Shininess ("Shininess", Range (0.01, 1)) = 0.7 
		_Mask ("Mask", RECT) = "" {}
	}
	SubShader {
		Lighting On 
		SeparateSpecular On 
		    
		Material { 
		      Ambient [_Color] 
		      Diffuse [_Color] 
		      Specular [_SpecularColor] 
		      Shininess [_Shininess] 
		   } 
    
		
		Pass{
           
            SetTexture [_Mask] {
            	constantColor [_ColorSecond]
                combine  primary Lerp(texture)constant
            }
		}
	}
	Fallback Off
}
