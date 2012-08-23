using UnityEngine;
using System.Collections;
using UnityEditor;

public class TerrainMeshBlendUtility : MonoBehaviour
{
    public static bool IsMeshSaved(Mesh mesh)
    {
        bool hasSaveLabel = false;
        string meshPath = AssetDatabase.GetAssetPath(mesh);
        if (!string.IsNullOrEmpty(meshPath))
        {
            string[] labels = AssetDatabase.GetLabels(mesh);
            for (int i = 0; i < labels.Length; i++)
            {
                if (labels[i] == "MeshBlendPainted")
                {
                    hasSaveLabel = true;
                    break;
                }
            }

        }
        return hasSaveLabel;
    }

    public static void Generate()
    {
        foreach (Object terrainObj in GameObject.FindSceneObjectsOfType(typeof(Terrain)))
        {
            Terrain terrain = terrainObj as Terrain;
            TerrainSettings terrainScript = terrain.GetComponent<TerrainSettings>();
            if (terrainScript == null)
                terrainScript = terrain.gameObject.AddComponent<TerrainSettings>();
            terrainScript.SetSettings();
        }
        TerrainMeshBlend[] blendObjects = GameObject.FindSceneObjectsOfType(typeof(TerrainMeshBlend)) as TerrainMeshBlend[];
        foreach (var item in blendObjects)
        {
            if (item.Terrain == null || item.Terrain.terrainData == null)
            {
                item.Terrain = FindClosestTerrain(item);
            }
            UpdateProperties(item);
        }
    }

    public static Terrain FindClosestTerrain(TerrainMeshBlend comp)
    {
        Terrain[] terrains = GameObject.FindObjectsOfType(typeof(Terrain)) as Terrain[];
        Terrain closestTerrain = null;
        foreach (var terrain in terrains)
        {
            if (closestTerrain == null ||
                (Vector3.Distance(closestTerrain.transform.position, comp.transform.position) >
                Vector3.Distance(terrain.transform.position, comp.transform.position)))
            {
                closestTerrain = terrain;
            }
        }
        return closestTerrain;
    }

    public static void UpdateProperties(TerrainMeshBlend comp)
    {
        GameObject activeObject;
        Terrain terrain;
        TerrainData data;
        TerrainSettings terrainScript;

        activeObject = comp.gameObject;
        terrain = comp.Terrain;
        if (terrain == null)
        {
            Debug.LogError("No Terrain component assigned for TerrainMeshBlend component on object " + comp.gameObject);
            return;
        }
        data = terrain.terrainData;
        terrainScript = terrain.GetComponent<TerrainSettings>();




        if (activeObject.renderer.sharedMaterial == null)
        {
            Debug.LogError("Could not find shared material for \"" + activeObject.name);
        }
        else
        {
            CheckShaderMatch(activeObject);
            Texture2D splatAlphaTexture = GetTerrainSplatTexture(comp);


            activeObject.renderer.sharedMaterial.SetTexture("_Control", splatAlphaTexture);




            activeObject.renderer.sharedMaterial.SetVector("_TerrainCoords", new Vector4(terrain.gameObject.transform.position.x, terrain.gameObject.transform.position.z, data.size.x, data.size.z));

            if (activeObject.renderer.sharedMaterial.shader.name.Contains("Single"))
            {
                if (activeObject.renderer.sharedMaterial.GetTexture("_Tex0") != null)
                {

                    SetSingleShaderProperties(comp, terrainScript);
                }
            }
            else if (terrainScript != null)
            {
                activeObject.renderer.sharedMaterial.SetTexture("_BumpMap0", terrainScript.Bump0);
                activeObject.renderer.sharedMaterial.SetTexture("_BumpMap1", terrainScript.Bump1);
                activeObject.renderer.sharedMaterial.SetTexture("_BumpMap2", terrainScript.Bump2);
                activeObject.renderer.sharedMaterial.SetTexture("_BumpMap3", terrainScript.Bump3);
            }

            if (!comp.HasSingleShader())
            {
                if (activeObject.renderer.sharedMaterial.HasProperty("_TileSize"))
                {
                    var tileVector = activeObject.renderer.sharedMaterial.GetVector("_TileSize");
                    for (int i = 0; i < data.splatPrototypes.Length; i++)
                    {
                        activeObject.renderer.sharedMaterial.SetTexture("_Tex" + i, data.splatPrototypes[i].texture);
                        float tileValue = data.splatPrototypes[i].tileSize.x;
                        switch (i)
                        {
                            case 0:
                                tileVector.x = tileValue;
                                break;
                            case 1:
                                tileVector.y = tileValue;
                                break;
                            case 2:
                                tileVector.z = tileValue;
                                break;
                            case 3:
                                tileVector.w = tileValue;
                                break;
                            default:
                                break;
                        }

                    }
                    activeObject.renderer.sharedMaterial.SetVector("_TileSize", tileVector);
                }
            }
            else
            {
                var activeSingleTexture = activeObject.renderer.sharedMaterial.GetTexture("_Tex0");
                for (int i = 0; i < data.splatPrototypes.Length; i++)
                {
                    if (data.splatPrototypes[i].texture == activeSingleTexture)
                    {
                        var tileVector = activeObject.renderer.sharedMaterial.GetVector("_TileSize");
                        tileVector.x = data.splatPrototypes[i].tileSize.x;
                        activeObject.renderer.sharedMaterial.SetVector("_TileSize", tileVector);
                        break;
                    }
                }

            }
        }
    }

    public static bool CheckShaderMatch(GameObject activeObject)
    {

        if (activeObject.renderer.sharedMaterial.shader == null || !activeObject.renderer.sharedMaterial.shader.name.Contains("Terrain-Mesh Blend"))
        {
            if (EditorUtility.DisplayDialog("Terrain Mesh Blend Shader Mismatch", activeObject.name + " has shader " + activeObject.renderer.sharedMaterial.shader.name + " but has a TerrainMeshBlend component attached. Do you want to set the material to Terrain Mesh Blend? This is required for viewing the blend weight changes.", "Yes", "No"))
            {
                activeObject.renderer.sharedMaterial.shader = Shader.Find("Terrain-Mesh Blend/Terrain-Mesh Blend");
                return true;
            }
            else
            {
                return false;
            }
        }
        else
        {
            return true;
        }
    }

    public static Texture2D GetTerrainSplatTexture(TerrainMeshBlend comp)
    {
        Terrain terrain = comp.Terrain;
        Texture2D splatAlphaTexture = null;
#if UNITY_EDITOR
        string terrainAssetPath = UnityEditor.AssetDatabase.GetAssetPath(comp.Terrain.terrainData);
        var assets = UnityEditor.AssetDatabase.LoadAllAssetsAtPath(terrainAssetPath);
        foreach (var asset in assets)
        {
            if (asset.GetType() == typeof(Texture2D) && asset.name.StartsWith("SplatAlpha"))
            {
                splatAlphaTexture = asset as Texture2D;
                break;
            }
        }
#endif
        if (splatAlphaTexture == null)
        {
            splatAlphaTexture = new Texture2D(terrain.terrainData.alphamapWidth, terrain.terrainData.alphamapHeight, TextureFormat.RGBA32, false);
            float[, ,] splatMaps = terrain.terrainData.GetAlphamaps(0, 0, splatAlphaTexture.width, splatAlphaTexture.height);

            for (int x = 0; x < splatAlphaTexture.width; x++)
            {
                for (int y = 0; y < splatAlphaTexture.height; y++)
                {
                    Color color = new Color(0, 0, 0, 0);
                    for (int i = 0; i < splatMaps.GetUpperBound(2); i++)
                    {
                        float alphaData = splatMaps[x, y, i];
                        switch (i)
                        {
                            case 0:
                                color.r = alphaData;
                                break;
                            case 1:
                                color.g = alphaData;
                                break;
                            case 2:
                                color.b = alphaData;
                                break;
                            case 3:
                                color.a = alphaData;
                                break;
                            default:
                                break;
                        }
                    }
                    splatAlphaTexture.SetPixel(x, y, color);
                }
            }
        }
        return splatAlphaTexture;
    }

    public static void SetSingleShaderProperties(TerrainMeshBlend comp, TerrainSettings terrainScript)
    {
        GameObject activeObject = comp.gameObject;
        Terrain terrain = comp.Terrain;
        //activeObject.renderer.sharedMaterial.SetTexture("_Tex0", comp.SingleTerrainTexture);
        Texture terrainTexture = activeObject.renderer.sharedMaterial.GetTexture("_Tex0");
            for (int i = 0; i < terrain.terrainData.splatPrototypes.Length; i++)
            {
                if (terrain.terrainData.splatPrototypes[i].texture == terrainTexture)
                {
                    var tileVector = activeObject.renderer.sharedMaterial.GetVector("_TileSize");
                    tileVector.x = terrain.terrainData.splatPrototypes[i].tileSize.x;
                    activeObject.renderer.sharedMaterial.SetVector("_TileSize", tileVector);
                    if (terrainScript != null && !comp.HasDiffuseShader())
                    {
                        switch (i)
                        {
                            case 0:
                                activeObject.renderer.sharedMaterial.SetTexture("_BumpMap0", terrainScript.Bump0);
                                break;
                            case 1:
                                activeObject.renderer.sharedMaterial.SetTexture("_BumpMap0", terrainScript.Bump1);
                                break;
                            case 2:
                                activeObject.renderer.sharedMaterial.SetTexture("_BumpMap0", terrainScript.Bump2);
                                break;
                            case 3:
                                activeObject.renderer.sharedMaterial.SetTexture("_BumpMap0", terrainScript.Bump3);
                                break;
                            default:
                                break;
                        }
                    }
                }
        }
    }

    public static Texture2D GetClosestSplatTexture(TerrainMeshBlend comp, Texture2D splatAlphaTexture, out Texture2D normalMap)
    {
        normalMap = null;
        Vector3 terrainLocalPos = comp.Terrain.transform.TransformPoint(comp.transform.position);
        float blendValue = 0f;
        int splatIndex = -1;
        int xCoord = (int)Mathf.Clamp((terrainLocalPos.x / comp.Terrain.terrainData.size.x) * splatAlphaTexture.width, 0, splatAlphaTexture.width);
        int yCoord = (int)Mathf.Clamp((terrainLocalPos.z / comp.Terrain.terrainData.size.y) * splatAlphaTexture.height, 0, splatAlphaTexture.height);
        Color color = splatAlphaTexture.GetPixel(xCoord, yCoord);
        if (color.r > blendValue)
        {
            splatIndex = 0;
            blendValue = color.r;
        }
        if (color.g > blendValue)
        {
            splatIndex = 1;
            blendValue = color.g;
        }
        if (color.b > blendValue)
        {
            splatIndex = 2;
            blendValue = color.b;
        }
        if (color.a > blendValue)
        {
            splatIndex = 3;
            blendValue = color.a;
        }
        if (splatIndex != -1)
        {
            TerrainSettings settings = comp.Terrain.GetComponent<TerrainSettings>();
            if (settings != null)
            {
                switch (splatIndex)
                {
                    case 0:
                        normalMap = settings.Bump0;
                        break;
                    case 1:
                        normalMap = settings.Bump1;
                        break;
                    case 2:
                        normalMap = settings.Bump2;
                        break;
                    case 3:
                        normalMap = settings.Bump3;
                        break;

                }
            }
            return comp.Terrain.terrainData.splatPrototypes[splatIndex].texture;
        }
        return null;
    }

    private static Texture2D GenerateTerrainNormalTexture(TerrainData data, int width, int height)
    {
        Texture2D normalTex = null;
#if UNITY_EDITOR
        string normalTexturePath = UnityEditor.AssetDatabase.GetAssetPath(data);
        foreach (var asset in UnityEditor.AssetDatabase.LoadAllAssetsAtPath(normalTexturePath))
        {
            if (asset.name.Contains("NormalMap"))
            {
                normalTex = asset as Texture2D;
                break;
            }
        }
#endif
        // if its null, it's not created yet
        if (normalTex == null || normalTex.width != width || normalTex.height != height)
        {
            bool overwrite = normalTex != null;
            if (!overwrite)
            {
                normalTex = new Texture2D(width, height, TextureFormat.RGBA32, false);
#if UNITY_EDITOR
                normalTex.name = "NormalMap";
                UnityEditor.AssetDatabase.AddObjectToAsset(normalTex, data);
                UnityEditor.AssetDatabase.ImportAsset(normalTexturePath);
#endif
            }
            else
            {
                normalTex.Resize(width, height);
            }


        }
        Color[] normalData = new Color[normalTex.width * normalTex.height];

        for (int x = 0; x < normalTex.width; x++)
        {
            for (int y = 0; y < normalTex.height; y++)
            {
                float xCoord = x / (float)normalTex.width;
                float yCoord = y / (float)normalTex.width;
                Vector3 normal = data.GetInterpolatedNormal(xCoord, yCoord);

                int index = x + y * normalTex.width;
                normalData[index].r = normal.x;
                normalData[index].g = normal.y;
                normalData[index].b = normal.z;


            }
        }
        normalTex.SetPixels(normalData);

        normalTex.Apply();
        return normalTex;
    }
}
