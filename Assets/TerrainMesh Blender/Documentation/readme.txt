Terrain-Mesh Blend editor extension for Unity 3D


How do I use it?
--------------------------
Make sure you have a Unity Terrain object in your scene, then select a GameObject that you want to blend the terrain onto.
The selected object will need a valid mesh and material.
Add the TerrainMeshBlend component from the Component menu.
Looking at the inspector window, you should now see the TerrainMeshBlend component on the object.
To start painting terrain onto the object, click the "Modify New Instance" button and save a copy of your mesh at a path of your choice. If you have not chosen a Terrain-Mesh Blend shader for your material, a dialog window will ask you to switch shader.
Once saved, you will be in Modifiy Mode. You should now see a circle around your mouse when hovering your mouse over the object in the Scene View. This is your paint brush. If the brush is not visible, try adjusting the Radius slider along with the Max value for the slider in the Inspector Window.
While in Modify Mode, left-clicking on the mesh will paint terrain blend weights according to the settings in the Inspector.

A value of 1 for the Texture Blend & Normal Blend values will render the terrain while a value of 0 will render the original mesh texture & normals. Painting of these can be toggled with the corresponding checkboxes.
The "Fill With Current Settings" floods the mesh and covers it fully with the settings active in the Inspector.
"Flip Blend Values" will flip the Terrain Blend & Normal Blend values.
The Terrain object that is being blended with can be changed by modifying the Terrain Blend Target property. This is useful when having multiple Terrain objects.
The "Blend Update Timer" is the timer for how often the normals of the terrain will be baked into the mesh when moving the object around in the scene. This is an editor performance feature only and can usually be set to 0 depending on the complexity of your mesh.
The "Runtime Normal Update" checkbox toggles whether the TerrainMeshBlend component should bake normals if the object moves during runtime. This is useful for moving objects that need to blended with the terrain.

There are multiple variants of the Terrain-Mesh Blend shader with different performance characteristics.
Single shaders can only blend one terrain texture at a time, but render much faster.
Diffuse shaders lack normal (bump) maps and thus, render faster.

Video: http://youtu.be/pv8wjMGGGDM?hd=1