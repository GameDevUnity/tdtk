using UnityEngine;
using System.Collections;
using UnityEditor;

[CustomEditor(typeof(TerrainSettings))]
public class TerrainSettingsEditor : Editor
{

    TerrainSettings Settings
    {
        get
        {
            return target as TerrainSettings;
        }
    }
    public override void OnInspectorGUI()
    {
        Settings.Bump0 = (Texture2D)EditorGUILayout.ObjectField("Normal Map 0 ", Settings.Bump0, typeof(Texture2D), false);
        Settings.Bump1 = (Texture2D)EditorGUILayout.ObjectField("Normal Map 1 ", Settings.Bump1, typeof(Texture2D), false);
        Settings.Bump2 = (Texture2D)EditorGUILayout.ObjectField("Normal Map 2 ", Settings.Bump2, typeof(Texture2D), false);
        Settings.Bump3 = (Texture2D)EditorGUILayout.ObjectField("Normal Map 3 ", Settings.Bump3, typeof(Texture2D), false);
        Settings.Gloss0 = EditorGUILayout.FloatField("Gloss 0", Settings.Gloss0);
        Settings.Gloss1 = EditorGUILayout.FloatField("Gloss 1", Settings.Gloss1);
        Settings.Gloss2 = EditorGUILayout.FloatField("Gloss 2", Settings.Gloss2);
        Settings.Gloss3 = EditorGUILayout.FloatField("Gloss 3", Settings.Gloss3);
        if (GUILayout.Button("Update Settings") || GUI.changed)
        {
            EditorUtility.SetDirty(target);
            Settings.SetSettings();
            TerrainMeshBlend[] objs = GameObject.FindObjectsOfType(typeof(TerrainMeshBlend)) as TerrainMeshBlend[];
            foreach (var item in objs)
            {
                if (item.Terrain == Settings.GetComponent<Terrain>())
                    TerrainMeshBlendUtility.UpdateProperties(item);
            }


        }
    }
}
