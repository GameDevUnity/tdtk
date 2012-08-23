using UnityEngine;
using UnityEditor;
using System.Runtime.InteropServices;

public class TerrainMeshBlendWindow : EditorWindow
{
    public TerrainMeshBlendEditor BlendEditor;
    void OnGUI()
    {
        if (BlendEditor != null)
        {
            BlendEditor.OnInspectorGUI();
        }
        else
        {
            EditorGUILayout.BeginVertical();
            GUILayout.Label("Select an object with a TerrainMeshBlend component on it to start editing");
            EditorGUILayout.EndVertical();
        }
    }

    void OnDestroy()
    {
        if (BlendEditor != null && BlendEditor.PainterWindow == this)
            BlendEditor.PainterWindow = null;
    }


    void OnSelectionChange()
    {
        Repaint();
    }
}