xof 0303txt 0032

// DirectX 9.0 file
// Creator: Ultimate Unwrap3D Pro v3.22
// Website: http://www.unwrap3d.com
// Time: Fri Mar 12 17:25:36 2010

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

Frame rock_plants_003_LOD1 {
   FrameTransformMatrix {
    1.000000, 0.000000, 0.000000, 0.000000,
    0.000000, 1.000000, 0.000000, 0.000000,
    0.000000, 0.000000, 1.000000, 0.000000,
    0.000000, 0.000000, 0.000000, 1.000000;;
   }

   Mesh rock_plants_003_LOD1 {
    32;
    1.755721; 1.489098; 0.685743;,
    0.078555; 1.620535; -1.686277;,
    0.125579; -0.692830; 1.686277;,
    -1.532945; -0.535892; -0.697130;,
    1.637191; 1.136203; -1.048518;,
    -0.524468; 2.634005; 0.192628;,
    -1.910992; 0.193520; 0.781782;,
    0.234236; -1.332821; -0.452804;,
    0.436304; 0.278538; 1.632951;,
    0.952188; 0.392042; -1.139168;,
    -0.174099; -2.458784; 1.382147;,
    0.348484; -2.313520; -1.387102;,
    1.898154; -0.053818; 0.660908;,
    -0.476933; 1.033584; -0.406882;,
    -1.380212; -1.516783; -1.059343;,
    0.984451; -2.634005; 0.000457;,
    0.680823; 2.097755; 1.051564;,
    1.561639; 1.039999; -1.510062;,
    -0.999904; -0.240150; 1.410157;,
    -0.099939; -1.270663; -1.155792;,
    1.642989; 0.449908; 0.143051;,
    -1.170832; 0.432433; -0.070863;,
    -1.148587; -2.323311; -0.459927;,
    1.665503; -2.338045; -0.250945;,
    1.437126; 1.161802; 0.723395;,
    -0.092004; 1.057290; -1.308741;,
    -0.686027; -1.693596; -0.756232;,
    0.836439; -1.621399; 1.282137;,
    1.808308; 0.891739; -0.092419;,
    -1.096308; 0.763644; -0.151017;,
    1.910992; -2.008004; -0.105703;,
    -0.994800; -2.102546; -0.163751;;
    16;
    3;0, 1, 2;,
    3;1, 3, 2;,
    3;4, 5, 6;,
    3;4, 6, 7;,
    3;8, 9, 10;,
    3;9, 11, 10;,
    3;12, 13, 14;,
    3;12, 14, 15;,
    3;16, 17, 18;,
    3;18, 17, 19;,
    3;20, 21, 22;,
    3;20, 22, 23;,
    3;24, 25, 26;,
    3;27, 24, 26;,
    3;28, 29, 30;,
    3;30, 29, 31;;

   MeshTextureCoords {
    32;
    0.000000; 1.000000;,
    1.000000; 1.000000;,
    0.000000; 0.000000;,
    1.000000; 0.000000;,
    0.000000; 1.000000;,
    1.000000; 1.000000;,
    1.000000; 0.000000;,
    0.000000; 0.000000;,
    0.000000; 1.000000;,
    1.000000; 1.000000;,
    0.000000; 0.000000;,
    1.000000; 0.000000;,
    0.000000; 1.000000;,
    1.000000; 1.000000;,
    1.000000; 0.000000;,
    0.000000; 0.000000;,
    0.000000; 1.000000;,
    1.000000; 1.000000;,
    0.000000; 0.000000;,
    1.000000; 0.000000;,
    0.000000; 1.000000;,
    1.000000; 1.000000;,
    1.000000; 0.000000;,
    0.000000; 0.000000;,
    0.000000; 1.000000;,
    1.000000; 1.000000;,
    1.000000; 0.000000;,
    0.000000; 0.000000;,
    0.000000; 1.000000;,
    1.000000; 1.000000;,
    0.000000; 0.000000;,
    1.000000; 0.000000;;
   }

   MeshMaterialList {
    1;
    16;
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

    Material lambert20SG {
     1.000000; 1.000000; 1.000000; 1.000000;;
     128.000000;
     0.000000; 0.000000; 0.000000;;
     0.000000; 0.000000; 0.000000;;

     TextureFilename {
      "brunches_02_c.tga";
     }
    }

   }
  }
}
