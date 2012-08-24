xof 0303txt 0032

// DirectX 9.0 file
// Creator: Ultimate Unwrap3D Pro v3.22
// Website: http://www.unwrap3d.com
// Time: Fri Mar 12 17:03:18 2010

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

Frame rock_011_LOD1 {
   FrameTransformMatrix {
    1.000000, 0.000000, 0.000000, 0.000000,
    0.000000, 1.000000, 0.000000, 0.000000,
    0.000000, 0.000000, 1.000000, 0.000000,
    0.000000, 0.000000, 0.000000, 1.000000;;
   }

   Mesh rock_011_LOD1 {
    34;
    -1.686156; 1.559929; -1.411358;,
    -0.029221; 1.535038; -1.720876;,
    -1.349933; 0.338253; -1.364376;,
    -1.422689; 0.098110; 0.450209;,
    -0.925271; 0.592699; 1.511865;,
    -1.979731; 0.800333; 0.391401;,
    0.526222; 1.707184; 1.893984;,
    1.986194; 1.298034; 1.791921;,
    1.981980; 1.663787; 0.403336;,
    0.551544; 0.451869; 1.881115;,
    1.032368; 0.145755; 0.767824;,
    1.482792; 0.750828; 1.859512;,
    -2.082670; 0.335923; -0.748957;,
    -2.082670; 0.335923; -0.748957;,
    -0.261044; -0.037174; -0.817724;,
    1.603843; 0.383186; -0.355654;,
    -0.569078; 1.826171; -1.455124;,
    -2.198098; 1.760593; -0.445561;,
    -2.004537; 1.655030; 0.654846;,
    -0.605215; 1.919734; 0.065552;,
    -0.947554; 1.477929; 1.390354;,
    -2.082670; 0.335923; -0.748957;,
    1.414445; 0.602192; -1.653081;,
    -0.057126; 0.370759; -1.916884;,
    1.954559; 1.297453; -1.603399;,
    -0.057126; 0.370759; -1.916884;,
    -1.349933; 0.338253; -1.364376;,
    2.355199; 1.356730; -0.369153;,
    1.986194; 1.298034; 1.791921;,
    1.414445; 0.602192; -1.653081;,
    1.414445; 0.602192; -1.653081;,
    1.603843; 0.383186; -0.355654;,
    1.032368; 0.145755; 0.767824;,
    1.482792; 0.750828; 1.859512;;
    44;
    3;0, 1, 2;,
    3;3, 4, 5;,
    3;6, 7, 8;,
    3;9, 10, 11;,
    3;12, 3, 5;,
    3;13, 14, 3;,
    3;10, 14, 15;,
    3;6, 8, 16;,
    3;17, 18, 19;,
    3;18, 20, 19;,
    3;2, 21, 0;,
    3;22, 15, 23;,
    3;15, 14, 23;,
    3;16, 8, 24;,
    3;17, 19, 16;,
    3;4, 6, 20;,
    3;18, 5, 20;,
    3;5, 4, 20;,
    3;17, 5, 18;,
    3;2, 1, 25;,
    3;13, 26, 14;,
    3;0, 17, 16;,
    3;1, 0, 16;,
    3;24, 1, 16;,
    3;8, 27, 24;,
    3;28, 6, 11;,
    3;6, 9, 11;,
    3;4, 9, 6;,
    3;12, 5, 17;,
    3;0, 21, 17;,
    3;24, 29, 1;,
    3;29, 25, 1;,
    3;24, 27, 30;,
    3;27, 31, 30;,
    3;27, 8, 31;,
    3;8, 32, 31;,
    3;7, 33, 8;,
    3;33, 32, 8;,
    3;20, 6, 19;,
    3;6, 16, 19;,
    3;14, 26, 23;,
    3;3, 14, 10;,
    3;9, 4, 10;,
    3;4, 3, 10;;

   MeshTextureCoords {
    34;
    0.148975; 0.295587;,
    0.203277; 0.215975;,
    0.073256; 0.213757;,
    0.277041; 0.673796;,
    0.363600; 0.547465;,
    0.230164; 0.557578;,
    0.458852; 0.423294;,
    0.602219; 0.394264;,
    0.531730; 0.263623;,
    0.500676; 0.554616;,
    0.542490; 0.699076;,
    0.606070; 0.536494;,
    0.117486; 0.604987;,
    0.147924; 0.777252;,
    0.340492; 0.831963;,
    0.617202; 0.839022;,
    0.291497; 0.282870;,
    0.169489; 0.421901;,
    0.242492; 0.492586;,
    0.322703; 0.373728;,
    0.351763; 0.460736;,
    0.033488; 0.350269;,
    0.551625; 0.994844;,
    0.376405; 0.997182;,
    0.394076; 0.128144;,
    0.189282; 0.130795;,
    0.229551; 0.907536;,
    0.506421; 0.176262;,
    0.598295; 0.416750;,
    0.310507; 0.048652;,
    0.483335; 0.017676;,
    0.588880; 0.119273;,
    0.669316; 0.197217;,
    0.735197; 0.326420;;
   }

   MeshMaterialList {
    1;
    44;
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
