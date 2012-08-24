xof 0303txt 0032

// DirectX 9.0 file
// Creator: Ultimate Unwrap3D Pro v3.22
// Website: http://www.unwrap3d.com
// Time: Fri Mar 12 17:23:32 2010

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

Frame rock_plants_002_LOD1 {
   FrameTransformMatrix {
    1.000000, 0.000000, 0.000000, 0.000000,
    0.000000, 1.000000, 0.000000, 0.000000,
    0.000000, 0.000000, 1.000000, 0.000000,
    0.000000, 0.000000, 0.000000, 1.000000;;
   }

   Mesh rock_plants_002_LOD1 {
    36;
    1.478926; 0.917864; -0.958135;,
    -0.776435; 0.812680; -1.150114;,
    -0.893836; -0.450039; 0.689994;,
    1.360155; -0.359890; 0.903331;,
    0.728861; 0.279303; 1.424310;,
    0.639836; 1.823388; -0.224838;,
    0.809578; 0.164951; -1.759545;,
    0.897274; -1.361281; -0.129470;,
    1.270683; 0.842672; 0.406788;,
    -0.583454; 0.371641; -0.807642;,
    1.151595; -1.209737; 1.347689;,
    -0.701331; -1.656904; 0.122590;,
    0.010025; 0.515495; -0.917668;,
    0.128388; 1.014722; 1.289441;,
    -0.071939; -1.682835; -0.395682;,
    0.047669; -1.158188; 1.805349;,
    1.197179; 0.186384; 0.513226;,
    -0.145446; 0.932047; -1.152884;,
    -0.419827; -1.264182; 1.140121;,
    -1.743843; -0.501531; -0.533039;,
    -0.975525; -0.169244; 1.428069;,
    0.080976; 1.398849; 0.188420;,
    0.984254; -0.244237; -1.083943;,
    -0.060269; -1.794160; 0.141178;,
    0.477854; 0.366310; 0.714499;,
    -0.593197; 0.707922; -1.252908;,
    -1.140903; -1.456381; -1.353082;,
    -0.076010; -1.823387; 0.612989;,
    -1.319721; 0.588280; -0.286401;,
    -0.104929; 1.370072; 1.418685;,
    0.101414; -1.160706; -0.522988;,
    1.330245; -0.369915; 1.202250;,
    -0.635992; 1.004141; -1.283615;,
    -1.592133; 1.092619; 0.734349;,
    0.903255; -0.468751; -0.511703;,
    -0.064270; -0.379459; 1.529809;;
    18;
    3;0, 1, 2;,
    3;3, 0, 2;,
    3;4, 5, 6;,
    3;4, 6, 7;,
    3;8, 9, 10;,
    3;10, 9, 11;,
    3;12, 13, 14;,
    3;13, 15, 14;,
    3;16, 17, 18;,
    3;17, 19, 18;,
    3;20, 21, 22;,
    3;20, 22, 23;,
    3;24, 25, 26;,
    3;24, 26, 27;,
    3;28, 29, 30;,
    3;29, 31, 30;,
    3;32, 33, 34;,
    3;33, 35, 34;;

   MeshTextureCoords {
    36;
    0.000000; 1.000000;,
    1.000000; 1.000000;,
    1.000000; 0.000000;,
    0.000000; 0.000000;,
    0.000000; 0.000000;,
    0.000000; 1.000000;,
    1.000000; 1.000000;,
    1.000000; 0.000000;,
    0.000000; 1.000000;,
    1.000000; 1.000000;,
    0.000000; 0.000000;,
    1.000000; 0.000000;,
    0.000000; 1.000000;,
    1.000000; 1.000000;,
    0.000000; 0.000000;,
    1.000000; 0.000000;,
    0.000000; 1.000000;,
    1.000000; 1.000000;,
    0.000000; 0.000000;,
    1.000000; 0.000000;,
    0.000000; 0.000000;,
    0.000000; 1.000000;,
    1.000000; 1.000000;,
    1.000000; 0.000000;,
    0.000000; 1.000000;,
    1.000000; 1.000000;,
    1.000000; 0.000000;,
    0.000000; 0.000000;,
    1.000000; 1.000000;,
    1.000000; 0.000000;,
    0.000000; 1.000000;,
    0.000000; 0.000000;,
    1.000000; 1.000000;,
    1.000000; 0.000000;,
    0.000000; 1.000000;,
    0.000000; 0.000000;;
   }

   MeshMaterialList {
    1;
    18;
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
