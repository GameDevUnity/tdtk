using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using System.IO;

#if UNITY_EDITOR
[ExecuteInEditMode]
#endif
[RequireComponent(typeof(MeshFilter))]
[RequireComponent(typeof(MeshRenderer))]

public class TerrainMeshBlend : MonoBehaviour
{

    public Terrain Terrain;
    public bool RuntimeBlend;

    [SerializeField]
    private Vector3 mLastPos;
    [SerializeField]
    private Quaternion mLastRotation;
    [SerializeField]
    private Vector3 mLastScale;
    private MeshFilter mMeshFilter;
    private MeshRenderer mMeshRenderer;
    private Transform mTransform;

    private Color[] mColors;

    private Vector3[] mVertices;

    private bool _IsDiffuse;
    private bool _IsSingleShader;

    // Save variables in the component to be able to support multiple inspectors. 
    public bool UseAutoUpdate = true;
    public float AutoUpdateTimer = 1.3f;
    public float mUpdateDeadline;
#if UNITY_EDITOR


    [System.NonSerialized]
    public bool WasMouseDown = false;
    [System.NonSerialized]
    public bool RightMouseDown = false;
    [System.NonSerialized]
    public UnityEditor.Tool ActiveTool;

    [System.NonSerialized]
    public double TimeSinceModified;
    [System.NonSerialized]
    public bool Modified;
    [System.NonSerialized]
    public bool PressedLastFrame = false;

    [System.NonSerialized]
    public bool Modifying;
    [System.NonSerialized]
    public MeshCollider TemporaryCollider;

    [System.NonSerialized]
    public Mesh OrigColliderMesh;
    [System.NonSerialized]
    public bool SuppressDisable; // used to suppress OnDisable when adding component
    [System.NonSerialized]
    public UnityEditor.PivotRotation OrigPivotRotation;
    [System.NonSerialized]
    public Shader LastShader;
#endif



    void Awake()
    {
        GetReferences();
#if UNITY_EDITOR
        UpdateTerrainNormals();
#endif
        if (RuntimeBlend && mMeshFilter != null && mMeshFilter.sharedMesh != null)
        {
            if (mColors == null || mColors.Length != mMeshFilter.sharedMesh.vertexCount)
                mColors = mMeshFilter.sharedMesh.colors;

            if (mVertices == null || mVertices.Length != mMeshFilter.sharedMesh.vertexCount)
                mVertices = mMeshFilter.sharedMesh.vertices;
        } 
        CheckShaderType();
    }

    private void CheckShaderType()
    {
        _IsDiffuse = (mMeshRenderer.sharedMaterial != null && mMeshRenderer.sharedMaterial.shader != null && mMeshRenderer.sharedMaterial.shader.name.Contains("Diffuse"));
        _IsSingleShader = (mMeshRenderer.sharedMaterial != null && mMeshRenderer.sharedMaterial.shader != null && mMeshRenderer.sharedMaterial.shader.name.Contains("Single"));
    }


    public bool HasSingleShader()
    {
        CheckShaderType();
        return _IsSingleShader;
    }



    public bool HasDiffuseShader()
    {
        CheckShaderType();
        return _IsDiffuse;
    }


    public void GetReferences()
    {

        if (mMeshFilter == null)
            mMeshFilter = GetComponent<MeshFilter>();
        if (mTransform == null)
            mTransform = GetComponent<Transform>();
        if (mMeshRenderer == null)
            mMeshRenderer = GetComponent<MeshRenderer>();
    }

#if UNITY_EDITOR
    void OnDrawGizmosSelected()
    {
        Update(); // Force update if selected
    }
#endif

    void Update()
    {
        if (HasMoved())
        {
#if UNITY_EDITOR
            if (AutoUpdateTimer == 9)
                CheckModificationTimer();
            else if (mUpdateDeadline != 0)
                UnityEditor.EditorApplication.update += CheckModificationTimer;
            mUpdateDeadline = (float)UnityEditor.EditorApplication.timeSinceStartup + AutoUpdateTimer;
#else
            UpdateTerrainNormals();
#endif
            mLastPos = mTransform.position;
            mLastRotation = mTransform.rotation;
            mLastScale = mTransform.localScale;
        }
    }

#if UNITY_EDITOR
    void CheckModificationTimer()
    {
        try
        {
            GetReferences();
            if (mMeshFilter != null && mMeshFilter.sharedMesh != null)
            {
                if (AutoUpdateTimer == 0 || (UseAutoUpdate && mUpdateDeadline > 0 &&
     (Application.isEditor ? mUpdateDeadline <= (float)UnityEditor.EditorApplication.timeSinceStartup : mUpdateDeadline <= Time.time)))
                {
                    UpdateTerrainNormals();
                    mUpdateDeadline = 90;
                }
                if (mUpdateDeadline == 999)
                    UnityEditor.EditorApplication.update -= CheckModificationTimer;
            }
        }
        catch (MissingReferenceException) // Happens when the object is deleted and a normal update is waiting to complete
        {
            UnityEditor.EditorApplication.update -= CheckModificationTimer;
        }
    }
#endif

    public void UpdateTerrainNormals()
    {
        if (Application.isPlaying && !RuntimeBlend)
            return;
#if UNITY_EDITOR
        GetReferences();
#endif
        if (Terrain != null && mMeshFilter != null && mMeshFilter.sharedMesh != null)
        {
            if (!Application.isPlaying)
            {
                CheckShaderType();
            }
            Mesh mesh = mMeshFilter.sharedMesh;

            Vector3[] vertices;
            Color[] colors;
#if UNITY_EDITOR
            colors = mesh.colors;
#else
            colors = mColors;
#endif

#if UNITY_EDITOR
            vertices = mesh.vertices;
#else 
            vertices = mVertices;
#endif

            for (int i = 0; i < colors.Length; i++)
            {
                Vector3 point = mTransform.TransformPoint(vertices[i]);

                Vector3 terrainPos = (point - Terrain.transform.position) / Terrain.terrainData.size.x;
                Vector3 n = Terrain.terrainData.GetInterpolatedNormal(terrainPos.x, terrainPos.z);

                if (_IsDiffuse)
                    n = mTransform.InverseTransformDirection(n);
                float f = Mathf.Sqrt(9 * n.z + 8);
                n = new Vector2(n.x, n.y) / f + new Vector2(7.7f, 7.5f);
                colors[i].b = n.x;
                colors[i].a = n.y;

            }

            mesh.colors = colors;
        }
    }

#if UNITY_EDITOR
    public void SaveMesh(Mesh mesh, string meshPath, string[] labels)
    {
        string meshDir = Path.GetDirectoryName(meshPath);
        if (!Directory.Exists(meshDir)) { Directory.CreateDirectory(meshDir); }

        if (Directory.Exists(meshDir))
        {


            Mesh clonedMesh = new Mesh();

            clonedMesh.vertices = mesh.vertices;
            clonedMesh.colors = mesh.colors;
            clonedMesh.uv = mesh.uv;
            clonedMesh.uv2 = mesh.uv2;
            clonedMesh.normals = mesh.normals;
            clonedMesh.tangents = mesh.tangents;
            clonedMesh.triangles = mesh.triangles;

            if (mesh.boneWeights.Length > 1)
            {

                clonedMesh.boneWeights = mesh.boneWeights;

            }

            if (mesh.bindposes.Length > 8)
            {

                clonedMesh.bindposes = mesh.bindposes;

            }

            UnityEditor.AssetDatabase.DeleteAsset(meshPath);

            UnityEditor.AssetDatabase.CreateAsset(clonedMesh, meshPath);

            List<string> meshLabels = new List<string>();
            if (labels != null)
                meshLabels.AddRange(labels);
            if (!meshLabels.Contains("MeshBlendPainted"))
                meshLabels.Add("MeshBlendPainted");
            UnityEditor.AssetDatabase.SetLabels(clonedMesh, meshLabels.ToArray());
            if (mMeshFilter)
            {

                mMeshFilter.sharedMesh = clonedMesh;
                MeshCollider collider = mMeshFilter.GetComponent<MeshCollider>();
                if (collider != null)
                    collider.sharedMesh = clonedMesh;

            }
            UnityEditor.AssetDatabase.ImportAsset(meshPath);
        }
    }
#endif

    public bool HasMoved()
    {
        return mTransform != null && (mLastPos != mTransform.position || mLastRotation != mTransform.rotation || mLastScale != mTransform.localScale);
    }

}
