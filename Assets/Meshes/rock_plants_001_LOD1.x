xof 0303txt 0032

// DirectX 9.0 file
// Creator: Ultimate Unwrap3D Pro v3.22
// Website: http://www.unwrap3d.com
// Time: Fri Mar 12 17:22:10 2010

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

Frame rock_plants_001_LOD1 {
   FrameTransformMatrix {
    1.000000, 0.000000, 0.000000, 0.000000,
    0.000000, 1.000000, 0.000000, 0.000000,
    0.000000, 0.000000, 1.000000, 0.000000,
    0.000000, 0.000000, 0.000000, 1.000000;;
   }

   Mesh rock_plants_001_LOD1 {
    52;
    1.106115; 2.161338; 1.628496;,
    -0.928426; 2.168233; -0.449297;,
    1.414000; -0.702981; 1.281924;,
    -0.624363; -0.663003; -0.791582;,
    -0.420040; 2.165749; -0.089873;,
    -1.429714; 2.163289; -1.966035;,
    -0.060542; -0.454547; -0.312891;,
    -1.074674; -0.426743; -2.186289;,
    1.919828; 2.158153; 1.611035;,
    -0.270997; 2.173385; 0.495020;,
    -0.107847; -1.014430; 0.065781;,
    2.085043; -1.066909; 1.176426;,
    -0.077488; 1.850137; 1.748584;,
    0.495657; 2.247452; -0.264648;,
    0.887875; -0.311732; -0.688408;,
    0.319670; -0.738967; 1.319951;,
    0.791338; 1.889266; 2.160889;,
    1.770869; 1.981649; 0.450889;,
    1.875643; -0.916991; 0.323652;,
    0.897637; -1.043282; 2.032314;,
    -0.019885; 2.282423; -1.036689;,
    -2.010732; 1.528633; -1.124746;,
    0.897749; -0.200511; -1.231416;,
    -1.103700; -0.925592; -1.316855;,
    -0.564329; 1.816129; 0.761201;,
    0.182614; 1.918117; -1.231562;,
    0.883691; -0.607898; -1.128721;,
    0.145285; -0.739361; 0.865342;,
    1.475751; 0.478234; 2.006465;,
    0.468252; 0.768120; 0.345068;,
    1.705872; -2.042771; 1.398623;,
    0.695456; -1.723788; -0.255576;,
    1.472969; 0.788088; 0.831807;,
    -0.287801; 0.422681; 1.622695;,
    1.513492; -1.154976; 0.083994;,
    -0.247594; -1.497983; 0.883779;,
    0.891381; 0.022989; 1.649189;,
    1.397418; -0.455506; -0.187734;,
    1.540966; -2.438982; 0.343086;,
    1.036916; -1.983682; 2.186289;,
    -0.195026; 1.527415; 1.992324;,
    0.646171; 2.438981; 0.319658;,
    1.056754; 0.663203; -0.413389;,
    0.225017; -0.237800; 1.239766;,
    -0.799680; 1.948907; -0.198857;,
    0.086779; 1.604066; -1.478506;,
    -1.183857; 0.204249; -2.008242;,
    -2.085043; 0.532520; -0.734668;,
    0.391246; 1.684222; -0.717305;,
    -0.930272; 1.000569; -1.290410;,
    -1.428172; 0.402042; 0.511943;,
    -0.112361; 1.078451; 1.106104;;
    26;
    3;0, 1, 2;,
    3;1, 3, 2;,
    3;4, 5, 6;,
    3;5, 7, 6;,
    3;8, 9, 10;,
    3;8, 10, 11;,
    3;12, 13, 14;,
    3;12, 14, 15;,
    3;16, 17, 18;,
    3;16, 18, 19;,
    3;20, 21, 22;,
    3;22, 21, 23;,
    3;24, 25, 26;,
    3;24, 26, 27;,
    3;28, 29, 30;,
    3;29, 31, 30;,
    3;32, 33, 34;,
    3;34, 33, 35;,
    3;36, 37, 38;,
    3;39, 36, 38;,
    3;40, 41, 42;,
    3;40, 42, 43;,
    3;44, 45, 46;,
    3;47, 44, 46;,
    3;48, 49, 50;,
    3;51, 48, 50;;

   MeshTextureCoords {
    52;
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
    1.000000; 0.000000;,
    0.000000; 0.000000;,
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
    0.000000; 0.000000;,
    1.000000; 0.000000;,
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
    1.000000; 0.000000;,
    0.000000; 0.000000;,
    0.000000; 1.000000;,
    1.000000; 1.000000;,
    1.000000; 0.000000;,
    0.000000; 0.000000;;
   }

   MeshMaterialList {
    1;
    26;
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
