xof 0303txt 0032

// DirectX 9.0 file
// Creator: Ultimate Unwrap3D Pro v3.22
// Website: http://www.unwrap3d.com
// Time: Fri Mar 12 16:57:10 2010

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

Frame rock_008_LOD2 {
   FrameTransformMatrix {
    1.000000, 0.000000, 0.000000, 0.000000,
    0.000000, 1.000000, 0.000000, 0.000000,
    0.000000, 0.000000, 1.000000, 0.000000,
    0.000000, 0.000000, 0.000000, 1.000000;;
   }

   Mesh rock_008_LOD2 {
    44;
    -0.714114; 0.000000; 1.775319;,
    -0.109602; 0.000000; 2.589013;,
    -0.290499; 0.510774; 2.590900;,
    -1.430183; 0.627111; 3.098529;,
    0.671725; 0.719240; 2.933876;,
    -0.353711; 1.006363; 3.314642;,
    0.552127; 1.128621; -2.617750;,
    -2.040595; 1.910144; -2.162100;,
    0.659966; 0.859376; -1.835877;,
    -1.428270; 0.000000; -1.957735;,
    -1.741531; 1.235126; -3.516452;,
    -0.311572; 0.776735; -2.611482;,
    0.798524; 0.000000; -2.615867;,
    3.336891; 0.000000; -0.168660;,
    2.737306; 0.608462; -0.209299;,
    2.564425; 0.628106; 0.688710;,
    2.162677; 0.889278; 1.666695;,
    2.260512; 0.000000; 1.940791;,
    -2.111336; 0.612065; -2.871570;,
    -1.428270; 0.000000; -1.957735;,
    -2.307914; 1.090993; -1.622549;,
    -0.714114; 0.000000; 1.775319;,
    -1.940973; 0.594559; 2.292222;,
    -2.344394; 1.606166; 0.141445;,
    -2.010175; 2.140285; 0.424988;,
    -1.879938; 1.921535; 2.598358;,
    1.209277; 0.955278; 1.445844;,
    -1.940973; 0.594559; 2.292222;,
    -2.111336; 0.612065; -2.871570;,
    -1.727424; 1.333304; 3.398165;,
    -2.214699; 1.367982; 2.605148;,
    -2.756200; 1.387516; -1.705896;,
    -2.680333; 1.529125; -3.196947;,
    -0.594028; 1.341884; -3.237491;,
    0.602761; 1.056593; -3.286999;,
    -1.857985; 1.908279; -3.319526;,
    -2.767576; 1.931571; -1.947854;,
    -2.680333; 1.529125; -3.196947;,
    1.087260; 0.846312; 0.421600;,
    1.649253; 0.673266; -2.056940;,
    1.849716; 0.615543; 2.253286;,
    2.355374; 0.000000; -2.342043;,
    2.260512; 0.000000; 1.940791;,
    -2.214699; 1.367982; 2.605148;;
    65;
    3;0, 1, 2;,
    3;0, 2, 3;,
    3;3, 4, 5;,
    3;6, 7, 8;,
    3;9, 10, 11;,
    3;9, 11, 12;,
    3;13, 14, 15;,
    3;15, 16, 17;,
    3;18, 19, 20;,
    3;19, 21, 20;,
    3;21, 22, 23;,
    3;24, 25, 5;,
    3;24, 5, 26;,
    3;0, 3, 27;,
    3;28, 10, 9;,
    3;5, 29, 3;,
    3;30, 3, 29;,
    3;20, 23, 31;,
    3;31, 32, 20;,
    3;33, 34, 12;,
    3;33, 10, 35;,
    3;24, 23, 25;,
    3;31, 36, 32;,
    3;37, 35, 10;,
    3;25, 30, 29;,
    3;5, 4, 26;,
    3;7, 36, 24;,
    3;15, 14, 38;,
    3;15, 38, 16;,
    3;33, 35, 7;,
    3;33, 7, 6;,
    3;39, 34, 6;,
    3;29, 5, 25;,
    3;6, 8, 39;,
    3;4, 40, 16;,
    3;34, 39, 41;,
    3;26, 4, 16;,
    3;6, 34, 33;,
    3;38, 24, 26;,
    3;38, 39, 8;,
    3;14, 13, 41;,
    3;14, 41, 39;,
    3;23, 24, 36;,
    3;23, 36, 31;,
    3;38, 14, 39;,
    3;38, 26, 16;,
    3;17, 13, 15;,
    3;35, 36, 7;,
    3;35, 37, 36;,
    3;8, 7, 24;,
    3;8, 24, 38;,
    3;1, 42, 40;,
    3;33, 12, 11;,
    3;11, 10, 33;,
    3;37, 10, 28;,
    3;20, 32, 18;,
    3;20, 21, 23;,
    3;43, 23, 22;,
    3;27, 3, 30;,
    3;2, 1, 4;,
    3;2, 4, 3;,
    3;40, 4, 1;,
    3;41, 12, 34;,
    3;25, 23, 43;,
    3;17, 16, 40;;

   MeshTextureCoords {
    44;
    -0.000624; 0.528676;,
    0.074951; 0.605570;,
    0.111219; 0.573760;,
    0.129326; 0.459055;,
    0.185510; 0.665761;,
    0.183871; 0.542969;,
    0.749243; 0.651184;,
    0.730703; 0.371828;,
    0.678011; 0.661010;,
    0.988357; 0.525688;,
    0.855543; 0.432975;,
    0.877512; 0.590542;,
    0.864674; 0.706046;,
    0.489620; 1.011286;,
    0.499993; 0.902883;,
    0.397104; 0.895955;,
    0.290059; 0.850977;,
    0.238490; 0.941527;,
    0.774801; 0.093282;,
    0.653204; 0.013165;,
    0.648229; 0.170597;,
    0.260995; 0.044958;,
    0.218826; 0.209997;,
    0.472513; 0.260201;,
    0.457962; 0.336524;,
    0.241270; 0.373553;,
    0.321937; 0.731778;,
    0.081431; 0.376991;,
    0.941273; 0.419574;,
    0.182185; 0.422652;,
    0.159558; 0.349561;,
    0.668382; 0.237951;,
    0.822973; 0.233406;,
    0.815220; 0.548255;,
    0.802106; 0.649342;,
    0.818948; 0.410679;,
    0.718492; 0.282724;,
    0.865567; 0.339910;,
    0.456161; 0.730377;,
    0.716152; 0.774666;,
    0.217143; 0.822199;,
    0.776236; 0.854756;,
    0.160551; 0.892462;,
    0.219426; 0.291764;;
   }

   MeshMaterialList {
    1;
    65;
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

    Material lambert19SG {
     1.000000; 1.000000; 1.000000; 1.000000;;
     128.000000;
     0.050000; 0.050000; 0.050000;;
     0.000000; 0.000000; 0.000000;;

     TextureFilename {
      "rock_008_c.tga";
     }
    }

   }
  }
}
