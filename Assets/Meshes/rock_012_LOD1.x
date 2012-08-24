xof 0303txt 0032

// DirectX 9.0 file
// Creator: Ultimate Unwrap3D Pro v3.22
// Website: http://www.unwrap3d.com
// Time: Fri Mar 12 17:15:45 2010

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

Frame rock_012_LOD1 {
   FrameTransformMatrix {
    1.000000, 0.000000, 0.000000, 0.000000,
    0.000000, 1.000000, 0.000000, 0.000000,
    0.000000, 0.000000, 1.000000, 0.000000,
    0.000000, 0.000000, 0.000000, 1.000000;;
   }

   Mesh rock_012_LOD1 {
    24;
    -0.779286; 0.624393; -0.878196;,
    -0.700109; 0.000000; -0.672196;,
    -0.731355; 0.698454; 0.049536;,
    -0.408451; 0.000000; 0.758591;,
    -0.290063; 1.084949; -0.752532;,
    -0.253107; 1.138965; 0.059719;,
    0.454555; 1.035628; -0.638649;,
    0.421565; 0.474827; -0.864069;,
    0.668470; 0.000000; -0.266832;,
    0.136679; 0.000000; -0.809242;,
    0.136679; 0.000000; -0.809242;,
    -0.147104; 0.569094; -1.100308;,
    0.421565; 0.474827; -0.864069;,
    0.786453; 0.698832; 0.935785;,
    -0.116095; 1.014757; 0.670004;,
    0.497533; 0.000000; 0.854963;,
    -0.210666; 0.745083; 1.032563;,
    -0.116095; 1.014757; 0.670004;,
    -0.210666; 0.745083; 1.032563;,
    -0.408451; 0.000000; 0.758591;,
    0.497533; 0.000000; 0.854963;,
    -0.779286; 0.624393; -0.878196;,
    -0.700109; 0.000000; -0.672196;,
    -0.290063; 1.084949; -0.752532;;
    23;
    3;0, 1, 2;,
    3;1, 3, 2;,
    3;4, 5, 6;,
    3;7, 8, 9;,
    3;10, 11, 12;,
    3;6, 5, 13;,
    3;5, 14, 13;,
    3;8, 13, 15;,
    3;2, 3, 16;,
    3;6, 11, 4;,
    3;6, 8, 7;,
    3;13, 8, 6;,
    3;12, 11, 6;,
    3;4, 0, 5;,
    3;0, 2, 5;,
    3;16, 17, 2;,
    3;17, 5, 2;,
    3;18, 13, 14;,
    3;18, 19, 13;,
    3;19, 20, 13;,
    3;21, 11, 22;,
    3;11, 10, 22;,
    3;11, 21, 23;;

   MeshTextureCoords {
    24;
    0.743010; 0.656810;,
    0.770785; 0.703782;,
    0.814792; 0.639853;,
    0.872081; 0.676890;,
    0.747074; 0.606855;,
    0.806801; 0.602191;,
    0.774106; 0.521195;,
    0.738441; 0.482895;,
    0.796584; 0.458660;,
    0.743481; 0.437190;,
    0.648918; 0.520716;,
    0.709648; 0.561120;,
    0.706578; 0.503955;,
    0.892370; 0.524543;,
    0.870098; 0.580050;,
    0.875459; 0.439637;,
    0.894908; 0.604275;,
    0.864974; 0.584502;,
    0.907488; 0.588479;,
    0.966507; 0.579404;,
    0.957774; 0.529935;,
    0.675721; 0.614921;,
    0.620998; 0.586885;,
    0.730600; 0.595796;;
   }

   MeshMaterialList {
    1;
    23;
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
     1.000000; 1.000000; 1.000000; 1.000000;;
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
