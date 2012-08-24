xof 0303txt 0032

// DirectX 9.0 file
// Creator: Ultimate Unwrap3D Pro v3.22
// Website: http://www.unwrap3d.com
// Time: Fri Mar 12 17:02:00 2010

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

Frame rock_010_LOD1 {
   FrameTransformMatrix {
    1.000000, 0.000000, 0.000000, 0.000000,
    0.000000, 1.000000, 0.000000, 0.000000,
    0.000000, 0.000000, 1.000000, 0.000000,
    0.000000, 0.000000, 0.000000, 1.000000;;
   }

   Mesh rock_010_LOD1 {
    54;
    -0.198096; 1.994036; 0.501517;,
    0.189263; 1.925521; 0.761842;,
    -0.092792; 2.043315; 0.132400;,
    -0.689182; 0.098830; 0.867535;,
    -0.044052; -0.167123; -0.024867;,
    0.218875; 0.010757; 1.262642;,
    0.779464; 0.133539; 1.109640;,
    1.173336; -0.000076; -0.655251;,
    1.303610; 0.617841; 0.767330;,
    -0.689182; 0.098830; 0.867535;,
    -0.965482; 0.578887; 1.098813;,
    -1.295076; 0.361368; 0.013404;,
    -1.019264; 0.929337; 0.499474;,
    -0.691119; 1.469813; 0.851037;,
    -0.528429; 1.103500; 1.465257;,
    0.232611; 1.098827; 1.466504;,
    -1.002403; 1.660634; -0.996210;,
    -1.327858; 1.026156; -0.041371;,
    -0.988516; 1.780368; -0.022910;,
    -1.221868; 0.828942; -1.125858;,
    -0.828527; 0.179554; -0.990406;,
    -1.071930; 0.000000; -0.024867;,
    -0.828527; 0.179554; -0.990406;,
    -0.044052; 0.000000; -1.207888;,
    -1.071930; 0.000000; -0.024867;,
    1.042533; 1.272320; 0.440246;,
    1.038464; 0.878803; -0.942111;,
    0.700847; 1.523066; -0.759208;,
    -0.046474; 1.847765; -0.294724;,
    0.861401; 1.790844; 0.207804;,
    -0.044052; 0.000000; -1.207888;,
    -0.123265; 0.584057; -1.442021;,
    0.680208; -0.006116; -0.742652;,
    0.680208; -0.006116; -0.742652;,
    0.576202; 1.493596; 0.989386;,
    -0.047370; 1.282584; -1.433560;,
    0.466547; 1.254958; -1.018612;,
    1.349830; 0.541144; -0.255067;,
    0.779464; 0.133539; 1.109640;,
    0.878573; 1.125533; 1.152309;,
    -0.965482; 0.578887; 1.098813;,
    -0.689182; 0.098830; 0.867535;,
    -0.661858; 0.481172; 1.562626;,
    0.878573; 1.125533; 1.152309;,
    -0.912602; 0.665949; -1.403422;,
    -0.912602; 0.665949; -1.403422;,
    -0.561540; 1.257626; -1.257662;,
    -0.828527; 0.179554; -0.990406;,
    -0.011039; 1.790772; -0.860377;,
    -0.883074; 1.460720; -1.310953;,
    0.218875; 0.010757; 1.262642;,
    1.038464; 0.878803; -0.942111;,
    0.576202; 1.493596; 0.989386;,
    -0.883074; 1.460720; -1.310953;;
    74;
    3;0, 1, 2;,
    3;3, 4, 5;,
    3;6, 7, 8;,
    3;9, 10, 11;,
    3;12, 10, 13;,
    3;14, 15, 1;,
    3;16, 17, 18;,
    3;19, 20, 11;,
    3;20, 21, 11;,
    3;22, 23, 24;,
    3;25, 26, 27;,
    3;27, 28, 29;,
    3;30, 31, 32;,
    3;4, 23, 33;,
    3;6, 5, 7;,
    3;5, 4, 7;,
    3;1, 15, 34;,
    3;31, 35, 36;,
    3;7, 26, 37;,
    3;38, 39, 15;,
    3;40, 14, 13;,
    3;41, 42, 40;,
    3;8, 43, 6;,
    3;8, 7, 37;,
    3;37, 25, 8;,
    3;19, 44, 20;,
    3;31, 45, 35;,
    3;45, 46, 35;,
    3;30, 47, 31;,
    3;47, 45, 31;,
    3;16, 48, 49;,
    3;11, 17, 19;,
    3;10, 12, 11;,
    3;15, 42, 50;,
    3;33, 26, 7;,
    3;26, 25, 37;,
    3;48, 28, 27;,
    3;1, 29, 2;,
    3;29, 28, 2;,
    3;2, 28, 0;,
    3;28, 18, 0;,
    3;18, 13, 0;,
    3;0, 14, 1;,
    3;16, 49, 19;,
    3;19, 17, 16;,
    3;13, 14, 0;,
    3;49, 48, 46;,
    3;35, 46, 48;,
    3;27, 36, 48;,
    3;36, 35, 48;,
    3;29, 25, 27;,
    3;34, 29, 1;,
    3;25, 29, 34;,
    3;8, 25, 43;,
    3;51, 36, 27;,
    3;31, 36, 51;,
    3;32, 31, 51;,
    3;4, 33, 7;,
    3;18, 28, 16;,
    3;28, 48, 16;,
    3;18, 17, 13;,
    3;17, 12, 13;,
    3;11, 12, 17;,
    3;21, 9, 11;,
    3;24, 4, 3;,
    3;52, 15, 39;,
    3;15, 14, 42;,
    3;14, 40, 42;,
    3;38, 15, 50;,
    3;24, 23, 4;,
    3;49, 44, 19;,
    3;45, 53, 46;,
    3;41, 50, 42;,
    3;43, 25, 34;;

   MeshTextureCoords {
    54;
    0.393227; 0.363774;,
    0.349405; 0.432039;,
    0.452158; 0.380411;,
    0.464224; 0.967012;,
    0.541980; 0.860490;,
    0.378132; 0.847617;,
    0.371278; 0.741059;,
    0.556223; 0.715668;,
    0.422730; 0.663275;,
    0.364664; 0.008865;,
    0.302484; 0.106657;,
    0.439111; 0.074309;,
    0.394909; 0.143949;,
    0.362282; 0.304257;,
    0.206989; 0.327178;,
    0.184358; 0.432370;,
    0.584149; 0.259561;,
    0.479372; 0.148553;,
    0.478999; 0.256269;,
    0.619134; 0.144860;,
    0.618901; 0.029950;,
    0.478672; 0.015473;,
    0.684999; 0.946623;,
    0.694654; 0.837660;,
    0.561056; 0.993588;,
    0.446107; 0.582028;,
    0.623032; 0.631232;,
    0.567691; 0.480288;,
    0.507232; 0.409277;,
    0.441228; 0.481987;,
    0.852570; 0.455395;,
    0.758725; 0.460794;,
    0.823151; 0.571308;,
    0.630285; 0.757975;,
    0.356738; 0.485636;,
    0.675601; 0.393697;,
    0.649437; 0.478901;,
    0.528594; 0.662537;,
    0.069828; 0.552873;,
    0.216618; 0.531539;,
    0.155881; 0.229287;,
    0.010252; 0.264302;,
    0.120471; 0.308612;,
    0.333485; 0.609457;,
    0.679944; 0.124475;,
    0.779502; 0.305545;,
    0.686125; 0.324886;,
    0.887924; 0.336491;,
    0.590298; 0.371476;,
    0.654467; 0.248188;,
    0.055803; 0.434947;,
    0.691064; 0.560083;,
    0.317064; 0.496211;,
    0.673600; 0.274740;;
   }

   MeshMaterialList {
    1;
    74;
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

    Material lambert18SG_Smoothing {
     1.000000; 1.000000; 1.000000; 1.000000;;
     128.000000;
     0.050000; 0.050000; 0.050000;;
     0.000000; 0.000000; 0.000000;;

     TextureFilename {
      "rock_010_c.tga";
     }
    }

   }
  }
}
