using UnityEngine;
using System.Collections;
using UnityEditor;
using System.IO;

[CustomEditor(typeof(TerrainMeshBlend))]
public class TerrainMeshBlendEditor : Editor
{
    static bool PaintTextureVal = true;
    static bool PaintNormalVal = true;
    static float TextureValue = 0f;
    static float NormalValue = 0f;
    static float Strength = 0.5f;
    static float Radius = 1f;
    static float MaxRadius = 10f;


    [System.NonSerialized]
    public TerrainMeshBlendWindow PainterWindow;
    Vector2 _SceneTextPos;
    Vector2 _LastMousePos;
    bool _StrengthHotkeyDown;
    bool _RadiusHotkeyDown;
    bool _TexValHotkeyDown;
    bool _NormalValHotkeyDown;
    public TerrainMeshBlend Canvas
    {
        get
        {
            return (target as TerrainMeshBlend);
        }
    }

    void OnEnable()
    {
        EditorWindow.FocusWindowIfItsOpen<TerrainMeshBlendWindow>();
        if (EditorWindow.focusedWindow is TerrainMeshBlendWindow)
        {
            PainterWindow = (EditorWindow.focusedWindow as TerrainMeshBlendWindow);
            PainterWindow.BlendEditor = this;
            PainterWindow.Repaint();
        }
    }
    void OnDisable()
    {
        if (!Canvas.SuppressDisable)
            UnlockObject();
    }


    void OnSceneGUI()
    {
        if (Event.current.type == EventType.ValidateCommand && Event.current.commandName == "UndoRedoPerformed")
        {
            Mesh mesh = Canvas.GetComponent<MeshFilter>().sharedMesh;
            Color[] colors = mesh.colors;
            mesh.colors = colors; // force the mesh to repaint by setting colors
            Canvas.UpdateTerrainNormals();
        }
        if (Canvas.Modifying)
        {
            if (Tools.current != Tool.None)
            {
                Canvas.ActiveTool = Tools.current;
                Tools.current = Tool.None;
            }
            bool newMouseDown = false;
            bool repaint = false;

            bool showSlideArrow = false;
            Event e = Event.current;
            if (e.type == EventType.MouseDown && e.button == 0)
            {

                if (!Canvas.WasMouseDown)
                {
                    newMouseDown = true;
                }
                Canvas.WasMouseDown = true;
                repaint = true;
            }
            else if (e.type == EventType.mouseDown && e.button == 1)
            {
                Canvas.RightMouseDown = true;
                repaint = true;
            }
            else if (e.type == EventType.mouseUp && e.button == 0)
            {
                Canvas.WasMouseDown = false;
                repaint = true;
            }
            else if (e.type == EventType.mouseUp && e.button == 1)
            {
                Canvas.RightMouseDown = false;
                repaint = true;
            }

            if (e.isKey && e.type == EventType.KeyDown)
            {
                bool consume = false;
                bool hotkeyDown = true;
                if (e.keyCode == KeyCode.Escape)
                    UnlockObject();
                else if (e.keyCode == KeyCode.B)
                    _RadiusHotkeyDown = true;
                else if (e.keyCode == KeyCode.A)
                    _StrengthHotkeyDown = true;
                else if (e.keyCode == KeyCode.S)
                    _TexValHotkeyDown = true;
                else if (e.keyCode == KeyCode.D)
                    _NormalValHotkeyDown = true;
                else if (e.keyCode == KeyCode.X)
                {
                    TextureValue = Mathf.Abs(TextureValue - 1);
                    NormalValue = Mathf.Abs(NormalValue - 1);
                    consume = true;
                }
                else
                    hotkeyDown = false;
                if (hotkeyDown)
                    repaint = true;
                if (consume)
                    Event.current.Use();
            }
            else if (e.isKey && e.type == EventType.keyUp)
            {
                bool hotkeyUp = true;
                if (e.keyCode == KeyCode.B)
                    _RadiusHotkeyDown = false;
                else if (e.keyCode == KeyCode.A)
                    _StrengthHotkeyDown = false;
                else if (e.keyCode == KeyCode.S)
                    _TexValHotkeyDown = false;
                else if (e.keyCode == KeyCode.D)
                    _NormalValHotkeyDown = false;
                else if (e.keyCode == KeyCode.X)
                    Event.current.Use();
                else
                    hotkeyUp = false;

                if (hotkeyUp)
                    repaint = true;
            }
            if (e.isMouse)
            {
                _LastMousePos = e.mousePosition;
            }
            if (newMouseDown)
            {
                this._SceneTextPos = e.mousePosition;
            }
            if (!Canvas.RightMouseDown)
            {
                if (_StrengthHotkeyDown)
                {
                    showSlideArrow = true;
                    HotkeyHUD(newMouseDown, e, "Strength: " + Strength.ToString("N2"),
                        (evt, sceneTextPos) =>
                        {
                            if (Canvas.WasMouseDown)
                                Strength = Mathf.Clamp01(Strength + (e.delta.x / 350));
                        });
                }
                else if (_RadiusHotkeyDown)
                {
                    showSlideArrow = true;
                    if (e.type == EventType.Repaint)
                    {
                        Ray ray;
                        RaycastHit hitInfo;
                        DrawBrush(Canvas.WasMouseDown ? this._SceneTextPos : e.mousePosition, out ray, out hitInfo);
                    }
                    HotkeyHUD(newMouseDown, e, "Radius: " + Radius.ToString("N2"),
                        (evt, sceneTextPos) =>
                        {
                            if (Canvas.WasMouseDown)
                                Radius = Mathf.Clamp(Radius + (e.delta.x * MaxRadius / 350), 0, MaxRadius);
                        });

                }
                else if (_TexValHotkeyDown)
                {
                    showSlideArrow = true;
                    HotkeyHUD(newMouseDown, e, "Texture Blend: " + TextureValue.ToString("N2"),
                        (evt, sceneTextPost) =>
                        {
                            if (Canvas.WasMouseDown)
                                TextureValue = Mathf.Clamp01(TextureValue + (e.delta.x / 350));
                        });

                }
                else if (_NormalValHotkeyDown)
                {
                    showSlideArrow = true;
                    HotkeyHUD(newMouseDown, e, "Normal Blend: " + NormalValue.ToString("N2"),
                        (evt, sceneTextPos) =>
                        {
                            if (Canvas.WasMouseDown)
                                NormalValue = Mathf.Clamp01(NormalValue + (e.delta.x / 350));
                        });

                }
                else
                {
                    Ray ray;
                    RaycastHit hitInfo;

                    if (DrawBrush(e.mousePosition, out ray, out hitInfo))
                    {
                        if (Canvas.WasMouseDown && !e.shift && !e.alt && !e.control)
                        {
                            if (Tools.current != Tool.None)
                            {
                                Tools.current = Tool.None;
                            }
                            Paint(Canvas, ray, hitInfo);
                        }
                    }
                    repaint = true;
                }
                if (showSlideArrow)
                {

                    Vector2 pos = EditorGUIUtility.ScreenToGUIPoint(new Vector2(SceneView.currentDrawingSceneView.position.xMin, SceneView.currentDrawingSceneView.position.yMin));
                    Vector2 maxPos = EditorGUIUtility.ScreenToGUIPoint(new Vector2(SceneView.currentDrawingSceneView.position.xMax, SceneView.currentDrawingSceneView.position.yMax));
                    EditorGUIUtility.AddCursorRect(new Rect(pos.x, pos.y, maxPos.x - pos.x, maxPos.y - pos.y), MouseCursor.SlideArrow);
                    repaint = true;
                }
                if (e.type == EventType.mouseMove)
                {
                    repaint = true;
                }
                if (repaint)
                {
                    HandleUtility.Repaint();
                    Repaint();
                }
            }
            HandleUtility.AddDefaultControl(GUIUtility.GetControlID(FocusType.Passive));
        }
    }

    private void HotkeyHUD(bool newMouseDown, Event e, string text, System.Action<Event, Vector2> valueModAction)
    {
        if (newMouseDown)
        {
            _SceneTextPos = _LastMousePos;
        }
        Vector2 pos = _LastMousePos + new Vector2(15, 10);
        if (Canvas.WasMouseDown)
            pos = _SceneTextPos + new Vector2(15, 10);
        Ray guiRay = HandleUtility.GUIPointToWorldRay(pos);
        var labelStyle = EditorStyles.label;
        Color oldColor = labelStyle.normal.textColor;
        labelStyle.normal.textColor = Color.white;
        int oldSize = labelStyle.fontSize;
        labelStyle.fontSize = 25;
        Handles.Label(guiRay.origin + guiRay.direction * 1f, new GUIContent(text), labelStyle);
        labelStyle.fontSize = oldSize;
        labelStyle.normal.textColor = oldColor;
        valueModAction(e, _SceneTextPos);
    }


    public void Paint(TerrainMeshBlend canvas, Ray ray, RaycastHit hitInfo)
    {
        if (Canvas.Modifying)
        {

            Mesh mesh = Canvas.GetComponent<MeshFilter>().sharedMesh;
            MeshCollider meshCollider = canvas.GetComponent<MeshCollider>();
            if (meshCollider.sharedMesh != mesh)
            {
                canvas.OrigColliderMesh = meshCollider.sharedMesh;
                meshCollider.sharedMesh = mesh;
            }
            Undo.SetSnapshotTarget(mesh, "Terrain-Mesh Blend Painting");
            if (!Canvas.PressedLastFrame)
            {
                Undo.CreateSnapshot();
                Undo.RegisterSnapshot();
            }


            Vector3[] vertices = mesh.vertices;
            Vector3[] normals = mesh.normals;
            if (normals == null || normals.Length == 0)
            {
                mesh.RecalculateNormals();
                normals = mesh.normals;
            }

            Color[] colors = mesh.colors;
            if (colors == null || colors.Length == 0)
                colors = new Color[vertices.Length];
            float radius = Radius; 
            float strength = Strength;
            float textureValue = TextureValue;
            float normalValue = NormalValue;

            bool modified = false;

            for (int i = 0; i < vertices.Length; i++)
            {
                float distance = Vector3.Distance(canvas.transform.TransformPoint(vertices[i]), hitInfo.point);
                if (distance <= radius && Vector3.Dot(canvas.transform.TransformDirection(normals[i]), ray.direction) <= 0)
                {
                    float falloff = Mathf.Clamp01(Mathf.Pow(360.0f, -Mathf.Pow(distance / radius, 2.5f) - 0.1f));

                    float colorAdd = Mathf.Clamp01(falloff * Mathf.Pow(strength, 2));
                    if (PaintTextureVal)
                        colors[i].r = Mathf.Lerp(colors[i].r, textureValue, colorAdd);
                    if (PaintNormalVal)
                        colors[i].g = Mathf.Lerp(colors[i].g, normalValue, colorAdd);
                    modified = true;
                }

            }
            canvas.Modified = modified;
            if (modified)
            {
                mesh.colors = colors;
                canvas.TimeSinceModified = EditorApplication.timeSinceStartup;
            }

            canvas.PressedLastFrame = !canvas.PressedLastFrame && Canvas.WasMouseDown;
        }
    }


    public override void OnInspectorGUI()
    {
        Canvas.SuppressDisable = false;
        MeshFilter meshFilter = Canvas.GetComponent<MeshFilter>();
        MeshRenderer renderer = Canvas.GetComponent<MeshRenderer>();
        bool canModify = meshFilter.sharedMesh != null && renderer.sharedMaterial != null;
        if (!Canvas.Modifying)
        {

            bool meshIsSaved = false;
            if (canModify)
            {
                meshIsSaved = TerrainMeshBlendUtility.IsMeshSaved(meshFilter.sharedMesh);
            }
            else
            {
                if (meshFilter.sharedMesh == null)
                    GUILayout.Label(TerrainMeshBlendText.MeshRequired);
                if (renderer.sharedMaterial == null)
                    GUILayout.Label(TerrainMeshBlendText.MaterialRequired);
            }
            Color col = GUI.backgroundColor;
            Color contentCol = GUI.contentColor;
            GUI.backgroundColor = new Color(0.3f, 0.8f, 0.3f);
            GUI.contentColor = Color.white;
            GUILayout.BeginHorizontal();
            GUI.enabled = canModify && meshIsSaved;
            bool startModify = GUILayout.Button(new GUIContent(TerrainMeshBlendText.Modify, GUI.enabled ? TerrainMeshBlendText.ModifyTooltip : TerrainMeshBlendText.ModifyUnavailableTooltip));
            GUI.enabled = canModify;
            bool modifyAndSave = GUILayout.Button(new GUIContent(TerrainMeshBlendText.ModifyExisting, TerrainMeshBlendText.ModifyExistingTooltip));
            GUI.contentColor = contentCol;
            GUI.backgroundColor = col;
            bool showWindow = GUILayout.Button(new GUIContent(TerrainMeshBlendText.ShowWindow, TerrainMeshBlendText.ShowWindowTooltip));
            if (showWindow)
            {
                PainterWindow = EditorWindow.GetWindow<TerrainMeshBlendWindow>();
                if (PainterWindow != null)
                {

                    PainterWindow.BlendEditor = this;
                }
            }
            GUI.enabled = true;
            GUILayout.EndHorizontal();
            if (modifyAndSave)
            {
                string[] labels = null;
                string assetPath = AssetDatabase.GetAssetPath(meshFilter.sharedMesh);
                if (string.IsNullOrEmpty(assetPath))
                {
                    string baseNameDefault = "terrainblendmesh";
                    int i = 1;
                    assetPath = Path.Combine(Application.dataPath, baseNameDefault + i++);
                    while (File.Exists(assetPath + ".asset"))
                    {
                        assetPath = Path.Combine(Application.dataPath, baseNameDefault + i++);
                    }
                }
                else
                {
                    labels = AssetDatabase.GetLabels(meshFilter.sharedMesh);
                    string fileName = Path.GetFileNameWithoutExtension(assetPath);
                    if (!fileName.Contains(".mb"))
                    {
                        fileName += ".mb";
                    }
                    else
                    {
                        int numIndex = fileName.IndexOf(".mb") + ".mb".Length;
                        fileName = fileName.Remove(numIndex, fileName.Length - numIndex);
                    }
                    int i = 1;
                    string directory = Path.GetDirectoryName(assetPath);
                    assetPath = Path.Combine(directory, fileName + i++);


                    while (File.Exists(assetPath + ".asset"))
                    {
                        assetPath = Path.Combine(directory, fileName + i++);
                    }
                    assetPath = assetPath.Replace("\\", "/");
                }
                string path = EditorUtility.SaveFilePanel("Save Mesh Instance", Path.GetDirectoryName(assetPath), Path.GetFileName(assetPath), "asset");
                if (!string.IsNullOrEmpty(path))
                {
                    System.Uri pathURI = new System.Uri(path);
                    System.Uri relativeURI = new System.Uri(Application.dataPath).MakeRelativeUri(pathURI);

                    Undo.RegisterSceneUndo("Start Terrain-Mesh Blend Modify");
                    Canvas.SaveMesh(meshFilter.sharedMesh, relativeURI.ToString(), labels);
                    StartModifyingObject(Canvas);
                }
            }
            if (startModify)
            {
                Undo.RegisterSceneUndo("Start Terrain-Mesh Blend Modify");
                StartModifyingObject(Canvas);
            }
        }
        else
        {
            GUILayout.BeginHorizontal();
            Color col = GUI.backgroundColor;
            Color contentCol = GUI.contentColor;
            GUI.backgroundColor = Color.red;
            GUI.contentColor = Color.white;
            bool stopModify = GUILayout.Button(new GUIContent(TerrainMeshBlendText.StopModifying, TerrainMeshBlendText.StopModifyingTooltip));
            GUI.backgroundColor = col;
            GUI.contentColor = contentCol;
            if (stopModify)
            {
                UnlockObject();
            }
            bool showWindow = GUILayout.Button(new GUIContent(TerrainMeshBlendText.ShowWindow, TerrainMeshBlendText.ShowWindowTooltip));
            if (showWindow)
            {
                PainterWindow = EditorWindow.GetWindow<TerrainMeshBlendWindow>();
                if (PainterWindow != null)
                    PainterWindow.BlendEditor = this;
            }
            GUILayout.EndHorizontal();

            GUILayout.Label(new GUIContent(TerrainMeshBlendText.Radius, TerrainMeshBlendText.RadiusTooltip));
            EditorGUILayout.BeginHorizontal();
            Radius = EditorGUILayout.Slider(Radius, 0f, MaxRadius);
            GUILayout.Label(new GUIContent(TerrainMeshBlendText.MaxRadius, TerrainMeshBlendText.MaxRadiusTooltip));
            MaxRadius = EditorGUILayout.FloatField(MaxRadius);
            EditorGUILayout.EndHorizontal();

            GUILayout.Label(new GUIContent(TerrainMeshBlendText.Strength, TerrainMeshBlendText.StrengthTooltip));
            Strength = EditorGUILayout.Slider(Strength, 0f, 1f);

            GUILayout.BeginVertical();
            PaintTextureVal = EditorGUILayout.Toggle(new GUIContent(TerrainMeshBlendText.TargetTextureBlend, TerrainMeshBlendText.TargetTextureBlendTooltip), PaintTextureVal);
            TextureValue = EditorGUILayout.Slider(TextureValue, 0f, 1f);
            GUILayout.EndVertical();

            GUILayout.BeginVertical();
            PaintNormalVal = EditorGUILayout.Toggle(new GUIContent(TerrainMeshBlendText.TargetNormalBlend, TerrainMeshBlendText.TargetNormalBlendTooltip), PaintNormalVal);
            NormalValue = EditorGUILayout.Slider(NormalValue, 0f, 1f);
            GUILayout.EndVertical();

            EditorGUILayout.BeginHorizontal();
            if (GUILayout.Button(new GUIContent(TerrainMeshBlendText.Fill, TerrainMeshBlendText.FillTooltip)))
            {
                Fill();
            }
            if (GUILayout.Button(new GUIContent(TerrainMeshBlendText.FlipBlendValues, TerrainMeshBlendText.FlipBlendValuesTooltip)) || (Event.current.type == EventType.keyDown && Event.current.keyCode == KeyCode.X))
            {
               NormalValue = Mathf.Abs(NormalValue - 1);
               TextureValue = Mathf.Abs(TextureValue - 1);
            }
            EditorGUILayout.EndHorizontal();
            EditorGUILayout.Space();


            EditorGUILayout.BeginHorizontal();
            GUILayout.Label(new GUIContent(TerrainMeshBlendText.TerrainBlendTarget, TerrainMeshBlendText.TerrainBlendTargetTooltip));
            Canvas.Terrain = EditorGUILayout.ObjectField(new GUIContent(string.Empty, TerrainMeshBlendText.TerrainBlendTargetTooltip), Canvas.Terrain, typeof(Terrain), true) as Terrain;
            EditorGUILayout.EndHorizontal();
        }

        {
            EditorGUILayout.BeginHorizontal();
            //Canvas.UseAutoUpdate = EditorGUILayout.Toggle(new GUIContent(TerrainMeshBlendText.BlendUpdateTimer, TerrainMeshBlendText.BlendUpdateTimerTooltip), Canvas.UseAutoUpdate);
            GUI.enabled = Canvas.UseAutoUpdate;
            float autoUpdateTimer = EditorGUILayout.FloatField(new GUIContent(TerrainMeshBlendText.BlendUpdateTimer, TerrainMeshBlendText.BlendUpdateTimerTooltip), Canvas.AutoUpdateTimer);
            if (autoUpdateTimer != Canvas.AutoUpdateTimer)
            {
                Undo.RegisterUndo(Canvas, "Auto Update Timer modified");
                Canvas.AutoUpdateTimer = autoUpdateTimer;
            }
            GUI.enabled = true;
            EditorGUILayout.EndHorizontal();

            bool runtimeBlend = GUILayout.Toggle(Canvas.RuntimeBlend, new GUIContent(TerrainMeshBlendText.RuntimeBlend, TerrainMeshBlendText.RuntimeBlendTooltip));
            if (runtimeBlend != Canvas.RuntimeBlend)
            {
                Undo.RegisterUndo(Canvas, "Runtime Normal Update modified");
                Canvas.RuntimeBlend = runtimeBlend;
            }
            if (Canvas.HasSingleShader())
            {
                EditorGUILayout.BeginHorizontal();
                Texture2D singleTerrainTex = renderer.sharedMaterial.GetTexture("_Tex0") as Texture2D;
                Texture2D newTexture = (Texture2D)EditorGUILayout.ObjectField(new GUIContent(TerrainMeshBlendText.SingleBlendTexture, TerrainMeshBlendText.SingleBlendTextureTooltip), singleTerrainTex, typeof(Texture2D), false);

                renderer.sharedMaterial.SetTexture("_Tex0", newTexture);
                if (newTexture != singleTerrainTex)
                {
                    TerrainMeshBlendUtility.UpdateProperties(Canvas);
                }
                if (GUILayout.Button(new GUIContent(TerrainMeshBlendText.FetchClosestTexture, TerrainMeshBlendText.FetchClosestTextureTooltip), GUILayout.ExpandWidth(false)))
                {
                    FetchClosestSplatTexture();
                }
                GUILayout.FlexibleSpace();
                EditorGUILayout.EndHorizontal();
            }
        }

        if (Canvas.Terrain != null && renderer != null && Canvas.LastShader != renderer.sharedMaterial.shader && renderer.sharedMaterial.shader.name.Contains("Terrain-Mesh Blend"))
        {
            if (Canvas.HasSingleShader())
                FetchClosestSplatTexture();
            TerrainMeshBlendUtility.UpdateProperties(Canvas);
            Canvas.UpdateTerrainNormals();
            Canvas.LastShader = renderer.sharedMaterial.shader;
        }
        if (PainterWindow != null)
            PainterWindow.Repaint();
    }

    private void FetchClosestSplatTexture()
    {
        MeshRenderer renderer = Canvas.GetComponent<MeshRenderer>();
        if (renderer != null)
        {
            Texture2D splatNormals;
            Texture2D closestSplatTex = TerrainMeshBlendUtility.GetClosestSplatTexture(Canvas, TerrainMeshBlendUtility.GetTerrainSplatTexture(Canvas), out splatNormals);
            if (closestSplatTex != null)
            {
                renderer.sharedMaterial.SetTexture("_Tex0", closestSplatTex);
            }
            if (splatNormals != null)
            {
                renderer.sharedMaterial.SetTexture("_BumpMap0", splatNormals);
            }
            TerrainMeshBlendUtility.UpdateProperties(Canvas);
        }
    }

    private void Fill()
    {
        Mesh mesh = Canvas.GetComponent<MeshFilter>().sharedMesh;


        Undo.SetSnapshotTarget(mesh, "Terrain-Mesh Blend Fill");
        Undo.CreateSnapshot();
        Undo.RegisterSnapshot();


        Vector3[] vertices = mesh.vertices;
        Color[] colors = mesh.colors;
        float textureValue = TextureValue;
        float normalValue = NormalValue;

        for (int i = 0; i < vertices.Length; i++)
        {
            if (PaintTextureVal)
                colors[i].r = textureValue;
            if (PaintNormalVal)
                colors[i].g = normalValue;
        }
        Canvas.Modified = true;

        mesh.colors = colors;
        Canvas.TimeSinceModified = EditorApplication.timeSinceStartup;
    }

    private void StartModifyingObject(TerrainMeshBlend canvas)
    {

        GameObject gameObject = canvas.gameObject;
        Undo.RegisterUndo(new Object[] { gameObject, this }, "Terrain-Mesh Blend Modify");
        MeshFilter meshFilter = gameObject.GetComponent<MeshFilter>();
        MeshCollider meshCollider = gameObject.GetComponent<MeshCollider>();
        if (meshCollider == null)
        {
            meshCollider = gameObject.AddComponent<MeshCollider>();
            canvas.TemporaryCollider = meshCollider;
            meshCollider.sharedMesh = meshFilter.sharedMesh;
            Canvas.SuppressDisable = true;
        }
        else if (meshCollider.sharedMesh != meshFilter.sharedMesh)
        {
            Canvas.OrigColliderMesh = meshCollider.sharedMesh;
            meshCollider.sharedMesh = meshFilter.sharedMesh;
        }

        if (canvas.Terrain == null)
            canvas.Terrain = TerrainMeshBlendUtility.FindClosestTerrain(canvas);


        TerrainMeshBlendUtility.UpdateProperties(Canvas);
        Canvas.UpdateTerrainNormals();
        Canvas.Modifying = true;
        Canvas.OrigPivotRotation = Tools.pivotRotation;

    }

    private void UnlockObject()
    {
        if (Canvas.Modifying)
        {
            if (Tools.current == Tool.None)
            {
                Tools.current = Canvas.ActiveTool;
            }
            if (Canvas.OrigColliderMesh != null)
            {
                MeshCollider collider = Canvas.GetComponent<MeshCollider>();
                collider.sharedMesh = Canvas.OrigColliderMesh;
                Canvas.OrigColliderMesh = null;
            }
            Tools.pivotRotation = Canvas.OrigPivotRotation;
        }
        if (Canvas.TemporaryCollider != null)
        {
            Object.DestroyImmediate(Canvas.TemporaryCollider);
            Canvas.TemporaryCollider = null;
        }
        Canvas.Modifying = false;

    }



    public bool DrawBrush(Vector2 mousePos, out Ray ray, out RaycastHit hitInfo)
    {
        ray = default(Ray);
        hitInfo = default(RaycastHit);

        if (Canvas.Modifying)
        {
            ray = HandleUtility.GUIPointToWorldRay(mousePos);
            if (Canvas.GetComponent<MeshCollider>().Raycast(ray, out hitInfo, float.MaxValue))
            {

                Handles.DrawWireDisc(hitInfo.point, hitInfo.normal, Radius);
                return true;
            }
        }
        return false;
    }
}
