/* Code provided by Chris _orris of Six Times Nothing (http://www.sixtimesnothing.com) */
/* Free to use and _odify */

using UnityEngine;
using System.Collections;

[RequireComponent(typeof(Terrain))]
[ExecuteInEditMode]
public class TerrainSettings : MonoBehaviour
{


    public Texture2D Bump0;
    public Texture2D Bump1;
    public Texture2D Bump2;
    public Texture2D Bump3;


    public float Gloss0 = 2f;
    public float Gloss1 = 2f;
    public float Gloss2 = 1f;
    public float Gloss3 = 12f;

    [SerializeField]
    private Terrain _Terrain;

    [SerializeField]
    private Texture2D _DefaultBumpMap;

    void Awake()
    {
#if UNITY_EDITOR
        SetSettings();
        GetDefaultBumpMap();
#endif
    }

    public void SetSettings()
    {
        
        if (_Terrain == null)
            _Terrain = (Terrain)GetComponent(typeof(Terrain));


        if (Bump0)
            Shader.SetGlobalTexture("_TerrainBumpMap0", Bump0);
        else if (GetDefaultBumpMap() != null)
            Shader.SetGlobalTexture("_TerrainBumpMap0", GetDefaultBumpMap());

        if (Bump1)
            Shader.SetGlobalTexture("_TerrainBumpMap1", Bump1);
        else if (GetDefaultBumpMap() != null)
            Shader.SetGlobalTexture("_TerrainBumpMap1", GetDefaultBumpMap());

        if (Bump2)
            Shader.SetGlobalTexture("_TerrainBumpMap2", Bump2);
        else if (GetDefaultBumpMap() != null)
            Shader.SetGlobalTexture("_TerrainBumpMap2", GetDefaultBumpMap());   

        if (Bump3)
            Shader.SetGlobalTexture("_TerrainBumpMap3", Bump3);
        else if (GetDefaultBumpMap() != null)
            Shader.SetGlobalTexture("_TerrainBumpMap3", GetDefaultBumpMap());



        Shader.SetGlobalVector("_TerrainSpec", new Vector4(Gloss0, Gloss1, Gloss2, Gloss3));

    }

    Texture2D GetDefaultBumpMap()
    {
#if UNITY_EDITOR
        if (_DefaultBumpMap == null)
        {
            UnityEditor.MonoScript scriptFile = UnityEditor.MonoScript.FromMonoBehaviour(this);
            if (scriptFile != null)
            {
                string assetPath = UnityEditor.AssetDatabase.GetAssetPath(scriptFile);
                if (!string.IsNullOrEmpty(assetPath))
                {
                    string directory = System.IO.Path.GetDirectoryName(assetPath);
                    if (!string.IsNullOrEmpty(directory))
                    {
                        _DefaultBumpMap = UnityEditor.AssetDatabase.LoadAssetAtPath(System.IO.Path.Combine(directory, "defaultbump.tga"), typeof(Texture2D)) as Texture2D;
                    }
                }
            }
        }
#endif
        return _DefaultBumpMap;
    }

    void Start()
    {

        SetSettings();
    }

}
