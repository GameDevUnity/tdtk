xof 0303txt 0032

// DirectX 9.0 file
// Creator: Ultimate Unwrap3D Pro v3.22
// Website: http://www.unwrap3d.com
// Time: Fri Mar 12 17:03:59 2010

// Start of Templates

template VertexDuplicationIndices {
 <b8d65549-d7c9-4995-89cf-53a9a8b031e3>
 DWORD nIndices;
 DWORD nOriginalVertices;
 array DWORD indices[nIndices];
}

template FVFData {
 <b6e70a0e-8ef9-4e83-94ad-ecc8b0c04897>
 DWORD dwFVF;
 DWORD nDWords;
 array DWORD data[nDWords];
}

template Header {
 <3D82AB43-62DA-11cf-AB39-0020AF71E433>
 WORD major;
 WORD minor;
 DWORD flags;
}

template Vector {
 <3D82AB5E-62DA-11cf-AB39-0020AF71E433>
 FLOAT x;
 FLOAT y;
 FLOAT z;
}

template Coords2d {
 <F6F23F44-7686-11cf-8F52-0040333594A3>
 FLOAT u;
 FLOAT v;
}

template Matrix4x4 {
 <F6F23F45-7686-11cf-8F52-0040333594A3>
 array FLOAT matrix[16];
}

template ColorRGBA {
 <35FF44E0-6C7C-11cf-8F52-0040333594A3>
 FLOAT red;
 FLOAT green;
 FLOAT blue;
 FLOAT alpha;
}

template ColorRGB {
 <D3E16E81-7835-11cf-8F52-0040333594A3>
 FLOAT red;
 FLOAT green;
 FLOAT blue;
}

template IndexedColor {
 <1630B820-7842-11cf-8F52-0040333594A3>
 DWORD index;
 ColorRGBA indexColor;
}

template Material {
 <3D82AB4D-62DA-11cf-AB39-0020AF71E433>
 ColorRGBA faceColor;
 FLOAT power;
 ColorRGB specularColor;
 ColorRGB emissiveColor;
 [...]
}

template TextureFilename {
 <A42790E1-7810-11cf-8F52-0040333594A3>
 STRING filename;
}

template MeshFace {
 <3D82AB5F-62DA-11cf-AB39-0020AF71E433>
 DWORD nFaceVertexIndices;
 array DWORD faceVertexIndices[nFaceVertexIndices];
}

template MeshTextureCoords {
 <F6F23F40-7686-11cf-8F52-0040333594A3>
 DWORD nTextureCoords;
 array Coords2d textureCoords[nTextureCoords];
}

template MeshMaterialList {
 <F6F23F42-7686-11cf-8F52-0040333594A3>
 DWORD nMaterials;
 DWORD nFaceIndexes;
 array DWORD faceIndexes[nFaceIndexes];
 [Material]
}

template MeshNormals {
 <F6F23F43-7686-11cf-8F52-0040333594A3>
 DWORD nNormals;
 array Vector normals[nNormals];
 DWORD nFaceNormals;
 array MeshFace faceNormals[nFaceNormals];
}

template MeshVertexColors {
 <1630B821-7842-11cf-8F52-0040333594A3>
 DWORD nVertexColors;
 array IndexedColor vertexColors[nVertexColors];
}

template Mesh {
 <3D82AB44-62DA-11cf-AB39-0020AF71E433>
 DWORD nVertices;
 array Vector vertices[nVertices];
 DWORD nFaces;
 array MeshFace faces[nFaces];
 [...]
}

template FrameTransformMatrix {
 <F6F23F41-7686-11cf-8F52-0040333594A3>
 Matrix4x4 frameMatrix;
}

template Frame {
 <3D82AB46-62DA-11cf-AB39-0020AF71E433>
 [...]
}

template FloatKeys {
 <10DD46A9-775B-11cf-8F52-0040333594A3>
 DWORD nValues;
 array FLOAT values[nValues];
}

template TimedFloatKeys {
 <F406B180-7B3B-11cf-8F52-0040333594A3>
 DWORD time;
 FloatKeys tfkeys;
}

template AnimationKey {
 <10DD46A8-775B-11cf-8F52-0040333594A3>
 DWORD keyType;
 DWORD nKeys;
 array TimedFloatKeys keys[nKeys];
}

template AnimationOptions {
 <E2BF56C0-840F-11cf-8F52-0040333594A3>
 DWORD openclosed;
 DWORD positionquality;
}

template Animation {
 <3D82AB4F-62DA-11cf-AB39-0020AF71E433>
 [...]
}

template AnimationSet {
 <3D82AB50-62DA-11cf-AB39-0020AF71E433>
 [Animation]
}

template XSkinMeshHeader {
 <3CF169CE-FF7C-44ab-93C0-F78F62D172E2>
 WORD nMaxSkinWeightsPerVertex;
 WORD nMaxSkinWeightsPerFace;
 WORD nBones;
}

template SkinWeights {
 <6F0D123B-BAD2-4167-A0D0-80224F25FABB>
 STRING transformNodeName;
 DWORD nWeights;
 array DWORD vertexIndices[nWeights];
 array FLOAT weights[nWeights];
 Matrix4x4 matrixOffset;
}

template AnimTicksPerSecond {
 <9E415A43-7BA6-4a73-8743-B73D47E88476>
 DWORD AnimTicksPerSecond;
}

AnimTicksPerSecond {
 4800;
}

// Start of Frames

Frame rock_012 {
   FrameTransformMatrix {
    1.000000, 0.000000, 0.000000, 0.000000,
    0.000000, 1.000000, 0.000000, 0.000000,
    0.000000, 0.000000, 1.000000, 0.000000,
    0.000000, 0.000000, 0.000000, 1.000000;;
   }

   Mesh rock_012 {
    36;
    -0.731355; 0.698454; 0.049536;,
    -0.779286; 0.624393; -0.878196;,
    -0.700109; 0.000000; -0.672196;,
    -0.654687; 0.000000; 0.170872;,
    -0.251031; 1.122841; -0.709503;,
    -0.304028; 1.184564; 0.002528;,
    0.358085; 0.899979; -0.789564;,
    0.619676; 1.014890; -0.141053;,
    0.248876; 0.000000; -0.726411;,
    0.730618; 0.487585; -0.291242;,
    0.518081; 0.000000; -0.115248;,
    0.421565; 0.474827; -0.864069;,
    0.779286; 0.610400; 0.902614;,
    0.313511; 0.566671; 1.094767;,
    0.541295; 0.000000; 0.780901;,
    0.184403; 0.000000; 0.937185;,
    -0.152398; 0.532982; -1.094767;,
    0.421565; 0.474827; -0.864069;,
    0.248876; 0.000000; -0.726411;,
    -0.195833; 0.000000; -0.842368;,
    -0.018572; 1.068274; 0.673456;,
    0.611622; 0.930007; 0.800498;,
    0.779286; 0.610400; 0.902614;,
    0.541295; 0.000000; 0.780901;,
    -0.210666; 0.745083; 1.032563;,
    -0.235972; 0.000000; 0.892211;,
    -0.082247; 0.904047; -0.919834;,
    -0.179806; 0.888069; 0.705167;,
    -0.426446; 0.899501; -0.054815;,
    -0.179806; 0.888069; 0.705167;,
    -0.458320; 0.842091; -0.806466;,
    -0.210666; 0.745083; 1.032563;,
    -0.235972; 0.000000; 0.892211;,
    -0.779286; 0.624393; -0.878196;,
    -0.700109; 0.000000; -0.672196;,
    -0.458320; 0.842091; -0.806466;;
    42;
    3;0, 1, 2;,
    3;0, 2, 3;,
    3;4, 5, 6;,
    3;5, 7, 6;,
    3;8, 9, 10;,
    3;11, 9, 8;,
    3;12, 13, 14;,
    3;14, 13, 15;,
    3;16, 17, 18;,
    3;19, 16, 18;,
    3;7, 20, 21;,
    3;5, 20, 7;,
    3;10, 22, 23;,
    3;9, 22, 10;,
    3;24, 0, 25;,
    3;0, 3, 25;,
    3;26, 4, 6;,
    3;6, 9, 11;,
    3;6, 7, 9;,
    3;7, 21, 9;,
    3;21, 22, 9;,
    3;21, 20, 27;,
    3;21, 27, 12;,
    3;20, 28, 29;,
    3;20, 5, 28;,
    3;5, 4, 28;,
    3;28, 4, 30;,
    3;26, 6, 17;,
    3;16, 26, 17;,
    3;28, 30, 1;,
    3;0, 28, 1;,
    3;24, 29, 0;,
    3;29, 28, 0;,
    3;27, 31, 13;,
    3;13, 31, 15;,
    3;31, 32, 15;,
    3;33, 16, 34;,
    3;16, 19, 34;,
    3;33, 35, 16;,
    3;35, 26, 16;,
    3;4, 26, 35;,
    3;12, 27, 13;;

   MeshTextureCoords {
    36;
    0.814792; 0.639853;,
    0.743010; 0.656810;,
    0.770785; 0.703782;,
    0.839567; 0.689176;,
    0.749777; 0.591206;,
    0.807964; 0.591058;,
    0.745260; 0.522812;,
    0.802951; 0.519578;,
    0.743481; 0.437190;,
    0.791611; 0.480839;,
    0.801557; 0.436480;,
    0.738441; 0.482895;,
    0.902774; 0.508543;,
    0.914917; 0.545934;,
    0.955299; 0.514327;,
    0.960250; 0.545543;,
    0.692226; 0.557882;,
    0.706578; 0.503955;,
    0.656232; 0.500033;,
    0.641603; 0.541399;,
    0.862645; 0.573731;,
    0.875895; 0.521847;,
    0.885495; 0.492363;,
    0.875459; 0.439637;,
    0.894908; 0.604275;,
    0.904596; 0.664603;,
    0.727071; 0.564358;,
    0.877550; 0.586369;,
    0.805638; 0.613324;,
    0.867303; 0.595274;,
    0.744370; 0.622504;,
    0.907488; 0.588479;,
    0.966507; 0.579404;,
    0.675721; 0.614921;,
    0.620998; 0.586885;,
    0.711424; 0.600385;;
   }

   MeshMaterialList {
    1;
    42;
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0;

    Material lambert19SG_Smoothing {
     0.000000; 0.000000; 0.000000; 1.000000;;
     128.000000;
     0.050000; 0.050000; 0.050000;;
     0.000000; 0.000000; 0.000000;;

     TextureFilename {
      "rock_011.tga";
     }
    }

   }
  }
}
