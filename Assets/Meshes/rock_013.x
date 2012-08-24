xof 0303txt 0032

// DirectX 9.0 file
// Creator: Ultimate Unwrap3D Pro v3.22
// Website: http://www.unwrap3d.com
// Time: Fri Mar 12 17:16:23 2010

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

Frame rock_013 {
   FrameTransformMatrix {
    1.000000, 0.000000, 0.000000, 0.000000,
    0.000000, 1.000000, 0.000000, 0.000000,
    0.000000, 0.000000, 1.000000, 0.000000,
    0.000000, 0.000000, 0.000000, 1.000000;;
   }

   Mesh rock_013 {
    36;
    0.729445; 0.789820; -0.369384;,
    1.227290; 0.706070; 0.555644;,
    1.046697; 0.000000; 0.383403;,
    0.592378; 0.000000; -0.456306;,
    0.315426; 1.339517; -0.114589;,
    -0.559208; 1.147649; 0.479069;,
    0.021922; 1.017705; 1.015338;,
    0.605753; 1.269720; 0.638806;,
    -0.006913; 0.536939; 1.122199;,
    -0.467855; 0.000000; 0.403539;,
    0.102988; 0.000000; 0.897953;,
    -0.599935; 0.551367; 0.686251;,
    -1.227290; 0.690247; -0.510420;,
    -0.844197; 0.640798; -0.932168;,
    -0.635997; 0.000000; -0.833572;,
    -0.925157; 0.000000; -0.501165;,
    0.691340; 0.602702; 1.080297;,
    -0.006913; 0.536939; 1.122199;,
    0.102988; 0.000000; 0.897953;,
    0.613619; 0.000000; 0.801312;,
    -0.300943; 1.208016; -0.662221;,
    -1.006518; 1.051662; -0.487169;,
    -1.227290; 0.690247; -0.510420;,
    -0.925157; 0.000000; -0.501165;,
    -0.184582; 0.000000; -0.990991;,
    -0.278351; 0.842547; -1.122199;,
    0.535005; 1.022305; 0.935443;,
    -0.151491; 1.004238; -0.772643;,
    -0.151491; 1.004238; -0.772643;,
    0.468289; 1.017165; -0.115209;,
    0.864533; 0.952245; 0.637619;,
    -0.278351; 0.842547; -1.122199;,
    -0.184582; 0.000000; -0.990991;,
    1.046697; 0.000000; 0.383403;,
    1.227290; 0.706070; 0.555644;,
    0.864533; 0.952245; 0.637619;;
    42;
    3;0, 1, 2;,
    3;3, 0, 2;,
    3;4, 5, 6;,
    3;7, 4, 6;,
    3;8, 9, 10;,
    3;8, 11, 9;,
    3;12, 13, 14;,
    3;12, 14, 15;,
    3;16, 17, 18;,
    3;19, 16, 18;,
    3;5, 20, 21;,
    3;4, 20, 5;,
    3;22, 23, 9;,
    3;11, 22, 9;,
    3;24, 25, 3;,
    3;25, 0, 3;,
    3;26, 7, 6;,
    3;6, 11, 8;,
    3;6, 5, 11;,
    3;5, 21, 22;,
    3;5, 22, 11;,
    3;21, 20, 27;,
    3;21, 27, 12;,
    3;20, 4, 28;,
    3;4, 29, 28;,
    3;4, 7, 29;,
    3;29, 7, 30;,
    3;26, 6, 17;,
    3;16, 26, 17;,
    3;29, 30, 1;,
    3;0, 29, 1;,
    3;25, 28, 0;,
    3;28, 29, 0;,
    3;27, 31, 13;,
    3;13, 31, 14;,
    3;31, 32, 14;,
    3;33, 34, 19;,
    3;34, 16, 19;,
    3;34, 35, 16;,
    3;35, 26, 16;,
    3;7, 26, 35;,
    3;12, 27, 13;;

   MeshTextureCoords {
    36;
    0.930276; 0.165977;,
    0.945395; 0.235037;,
    0.990850; 0.209155;,
    0.977930; 0.143021;,
    0.883399; 0.171728;,
    0.814803; 0.175366;,
    0.816970; 0.230706;,
    0.882593; 0.227497;,
    0.778577; 0.236592;,
    0.735140; 0.175320;,
    0.734843; 0.230997;,
    0.777487; 0.185595;,
    0.805820; 0.079538;,
    0.841860; 0.068494;,
    0.842204; 0.025018;,
    0.812193; 0.029268;,
    0.849327; 0.300292;,
    0.780757; 0.273446;,
    0.761911; 0.344392;,
    0.817217; 0.376196;,
    0.867678; 0.119050;,
    0.818159; 0.105512;,
    0.790075; 0.095826;,
    0.739394; 0.104566;,
    0.955434; 0.080339;,
    0.897479; 0.088639;,
    0.859127; 0.254433;,
    0.880025; 0.104958;,
    0.888408; 0.114940;,
    0.904700; 0.174319;,
    0.912525; 0.233192;,
    0.882523; 0.076297;,
    0.874775; 0.019564;,
    0.886914; 0.421595;,
    0.940390; 0.321441;,
    0.908398; 0.269061;;
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
