using UnityEngine;
using System.Collections;

public static class TerrainMeshBlendText
{  
    public static readonly string BlendUpdateTimer = "Blend Update Timer";
    public static readonly string BlendUpdateTimerTooltip = "The time (in seconds) it takes after the object has been moved before the terrain normals should be baked into the mesh, letting it blend into the terrain.";
    public static readonly string TerrainBlendTarget = "Terrain Blend Target";
    public static readonly string TerrainBlendTargetTooltip = "The terrain that the mesh will be blended with, depending on the painted blend values.";

    public static readonly string FlipBlendValues = "Flip Blend Values (X)";
    public static readonly string FlipBlendValuesTooltip = "Flips the blend values. Press X to quickly flip.";

    public static readonly string Fill = "Fill With Current Settings";
    public static readonly string FillTooltip = "Sets all blend values of the mesh to the values above.";

    public static readonly string TargetNormalBlend  = "Normal Blend (D)";
    public static readonly string TargetNormalBlendTooltip = "The target blending value for normals between the terrain and the mesh. A value of 0 will render the mesh with the original mesh normals, while a value of 1 will render mesh with the normals of the terrain under the mesh.\nPress D, click in the scene and slide the mouse horizontally to quickly change values.";

    public static readonly string TargetTextureBlend = "Texture Blend (S)";
    public static readonly string TargetTextureBlendTooltip = "The target blending value for textures between the terrain and the mesh. A value of 0 will show the mesh texture, while a value of 1 will render the terrain texture under the mesh.\nPress S, click in the scene and slide the mouse horizontally to quickly change values.";

    public static readonly string MeshRequired = "Valid mesh is required to modify";
    public static readonly string MaterialRequired = "Valid material is required to modify";

    public static readonly string Modify = "Modify";
    public static readonly string ModifyTooltip = "Enters Blend Weight Painting Mode";
    public static readonly string ModifyUnavailableTooltip = "Modifying blend weights requires saving a copy of your mesh. Click the Modify New Instance button to proceed.";
     
    public static readonly string ModifyExisting ="Modify New Instance";
    public static readonly string ModifyExistingTooltip = "Enters Blend Weight Painting Mode and copies the current mesh, saving it as a new asset. This avoids changes to the blending of existing objects in the scene.";
    public static readonly string Strength = "Strength (A)";
    public static readonly string StrengthTooltip = "Changes the strength/opacity of the paint brush in the Scene View.\nPress A, click in the scene and slide the mouse horizontally to quickly change values.";
    public static readonly string MaxRadius = "Max:";
    public static readonly string MaxRadiusTooltip = "The maximum radius for the paint brush in the Scene View.";
    public static readonly string Radius = "Radius (B)";
    public static readonly string RadiusTooltip = "Changes the Radius of the paint brush in the Scene View.\nPress B, click in the scene and slide the mouse horizontally to quickly change values.";
    public static readonly string StopModifying = "Stop Modifying (Esc)";
    public static readonly string StopModifyingTooltip = "Exit Paint Mode";
    public static readonly string ShowWindow = "Show Window";
    public static readonly string ShowWindowTooltip = "Shows a separate settings window.";
    public static readonly string RuntimeBlend = "Runtime Normal Update";
    public static readonly string RuntimeBlendTooltip = "Toggles whether or not to update the terrain normals when the object is moved while the game is playing.";
    public static readonly string SingleBlendTexture = "Blend Texture";
    public static readonly string SingleBlendTextureTooltip = "The terrain texture to blend the mesh with. Only available for Single blend shaders.";
    public static readonly string FetchClosestTexture = "Fetch Closest";
    public static readonly string FetchClosestTextureTooltip = "Tries to fetch the closest texture on the terrain and sets it as the active blending texture for Single blend shaders.";
}