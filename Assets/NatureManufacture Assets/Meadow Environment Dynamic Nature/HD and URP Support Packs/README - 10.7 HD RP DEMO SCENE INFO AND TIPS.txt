About scene:
We set all plants and objects manualy as at moment that we made this scene unity HD SRP doesn't support terrain foliage systems. It support at 2021.2 and we will add grass to all scenes at this versions.
There are 2 demo scenes
- converted scene with unity terrain but without grass (we wait for unity grass system at hd rp)
- scene without terrain data but very pretty and small
No grass system affect the performance. That's why number of saved by baching is so huge but...performance at scene should be good anyway. 
We will change this as soon unity will support terrain or something that we could use to buiuld proper scene. (It should be very soon)

BEFORE YOU START:
- you need Unity 2020.3
- you need HD SRP pipline 10.7, if you use higher it support most higher versions.
Be patient this tech is so fluid... we coudn't fallow every preview version


Step 1 - Setup Shadows and other render setups. Find File "HDRPMediumQuality" in project settings or "HDRPHighQuality" depends what unity use i your projectas default
    - Change shadow atlas width and height to 2048 or 4096, Rather this first one.
Step 2  !!!! IMPORTANT !!!! Default Diffusion Profile Assets at project Settings -> HDRP default settings--> bottom of the page and drag and 
        drop our SSS settings diffusion profilesfor foliage into Diffusion profile list:
		  NM_SSSSettings_Skin_Foliage
		  NM_SSSSettings_Skin_NM Foliage
		  NM_SSSSettings_Skin_NM Foliage Trees

	Without this foliage, water materials will not become affected by scattering and they will look wrong.
	Open "HDRPMediumQuality" in project settings or "HDRPHighQuality" depends what unity use i your projectas default and:
	- Check if you got Deferred only in Lit Shader mode.
	- Check if contact shadows are turned on
	- LOD Bias to = 2 or 1.5
	- Check i you got screen space occlusion turned on
    - Check i you got screen space global ilumination turned on
	- Check i you got screen reflection and ts transparent turned on

Step 3 Go to project settings and quality and set:
	- Set VSync to don't sync

Setp 4 Find HD SRP Demo Small and open it.

Step 5 - HIT PLAY!:)

Play with it give us feedback and lern about hd srp power.

