﻿Shader "NatureManufacture/URP/Road/Transparent Road Cover"
{
    Properties
    {
        _AlphaCutoff("Alpha Cutoff", Range(0, 1)) = 0
        _BaseColor("Base Color", Color) = (1, 1, 1, 1)
        [NoScaleOffset]_BaseColorMap("Base Map(RGB) Alpha(A)", 2D) = "white" {}
        [ToggleUI]_BaseUsePlanarUV("Base Use Planar UV", Float) = 0
        _BaseTilingOffset("Base Tiling and Offset", Vector) = (1, 1, 0, 0)
        [NoScaleOffset]_BaseNormalMap("Base Normal Map", 2D) = "bump" {}
        _BaseNormalScale("Base Normal Scale", Range(0, 8)) = 1
        [NoScaleOffset]_BaseMaskMap("Base Mask Map MT(R) AO(G) H(B) SM(A)", 2D) = "white" {}
        _BaseMetallic("Base Metallic", Range(0, 1)) = 1
        _BaseAORemapMin("Base AO Remap Min", Range(0, 1)) = 0
        _BaseAORemapMax("Base AO Remap Max", Range(0, 1)) = 1
        _BaseSmoothnessRemapMin("Base Smoothness Remap Min", Range(0, 1)) = 0
        _BaseSmoothnessRemapMax("Base Smoothness Remap Max", Range(0, 1)) = 1
        [NoScaleOffset]_LayerMask("Layer Mask (R)", 2D) = "black" {}
        [ToggleUI]_Invert_Layer_Mask("Invert Layer Mask", Float) = 0
        _Height_Transition("Height Blend Transition", Range(0.001, 1)) = 1
        _HeightMin("Height Min", Float) = 0
        _HeightMax("Height Max", Float) = 1
        _HeightOffset("Height Offset", Float) = 0
        _HeightMin2("Height 2 Min", Float) = 0
        _HeightMax2("Height 2 Max", Float) = 1
        _HeightOffset2("Height 2 Offset", Float) = 0
        [ToggleUI]IgnoreBase2Alpha("Ignore Base 2 Alpha", Float) = 0
        _Base2Color("Base 2 Color", Color) = (1, 1, 1, 1)
        [NoScaleOffset]_Base2ColorMap("Base 2 Map", 2D) = "white" {}
        _Base2TilingOffset("Base 2 Tiling and Offset", Vector) = (1, 1, 0, 0)
        [ToggleUI]_Base2UsePlanarUV("Base 2 Use Planar UV", Float) = 0
        [NoScaleOffset]_Base2NormalMap("Base 2 Normal Map", 2D) = "bump" {}
        _Base2NormalScale("Base 2 Normal Scale", Range(0, 8)) = 1
        [NoScaleOffset]_Base2MaskMap("Base 2 Mask Map MT(R) AO(G) H(B) SM(A)", 2D) = "white" {}
        _Base2Metallic("Base 2 Metallic", Range(0, 1)) = 1
        _Base2SmoothnessRemapMin("Base 2 Smoothness Remap Min", Range(0, 1)) = 0
        _Base2SmoothnessRemapMax("Base 2 Smoothness Remap Max", Range(0, 1)) = 1
        _Base2AORemapMin("Base 2 AO Remap Min", Range(0, 1)) = 0
        _Base2AORemapMax("Base 2 AO Remap Max", Range(0, 1)) = 1
        [NoScaleOffset]_CoverMaskA("Cover Mask (A)", 2D) = "white" {}
        _CoverMaskPower("Cover Mask Power", Range(0, 10)) = 1
        _Cover_Amount("Cover Amount", Range(0, 2)) = 0
        _Cover_Amount_Grow_Speed("Cover Amount Grow Speed", Range(0, 3)) = 3
        _Cover_Max_Angle("Cover Max Angle", Range(0.001, 90)) = 35
        _Cover_Min_Height("Cover Min Height", Float) = -10000
        _Cover_Min_Height_Blending("Cover Min Height Blending", Range(0, 500)) = 1
        _CoverBaseColor("Cover Base Color", Color) = (1, 1, 1, 0)
        [NoScaleOffset]_CoverBaseColorMap("Cover Base Map", 2D) = "white" {}
        _CoverTilingOffset("Cover Tiling Offset", Vector) = (1, 1, 0, 0)
        [ToggleUI]_CoverUsePlanarUV("Cover Use Planar UV", Float) = 0
        [NoScaleOffset]_CoverNormalMap("Cover Normal Map", 2D) = "bump" {}
        _CoverNormalScale("Cover Normal Scale", Range(0, 8)) = 1
        _CoverNormalBlendHardness("Cover Normal Blend Hardness", Range(0, 8)) = 1
        _CoverHardness("Cover Hardness", Range(0, 10)) = 5
        _CoverHeightMapMin("Cover Height Map Min", Float) = 0
        _CoverHeightMapMax("Cover Height Map Max", Float) = 1
        _CoverHeightMapOffset("Cover Height Map Offset", Float) = 0
        [NoScaleOffset]_CoverMaskMap("Cover Mask Map MT(R) AO(G) H(B) SM(A)", 2D) = "white" {}
        _CoverMetallic("Cover Metallic", Range(0, 1)) = 1
        _CoverAORemapMin("Cover AO Remap Min", Range(0, 1)) = 0
        _CoverAORemapMax("Cover AO Remap Max", Range(0, 1)) = 1
        _CoverSmoothnessRemapMin("Cover Smoothness Remap Min", Range(0, 1)) = 0
        _CoverSmoothnessRemapMax("Cover Smoothness Remap Max", Range(0, 1)) = 1
        [HideInInspector][NoScaleOffset]unity_Lightmaps("unity_Lightmaps", 2DArray) = "" {}
        [HideInInspector][NoScaleOffset]unity_LightmapsInd("unity_LightmapsInd", 2DArray) = "" {}
        [HideInInspector][NoScaleOffset]unity_ShadowMasks("unity_ShadowMasks", 2DArray) = "" {}
        [Toggle]_USEDYNAMICCOVERTSTATICMASKF("Use Dynamic Cover (T) Static Mask (F)", Float) = 1
    }
    SubShader
    {
        Tags
        {
            "RenderPipeline"="UniversalPipeline"
            "RenderType"="Transparent"
            "UniversalMaterialType" = "Lit"
            "Queue"="Transparent"
        }
        Pass
        {
            Name "Universal Forward"
            Tags
            {
                "LightMode" = "UniversalForward"
            }

            // Render State
            Cull Back
        Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
        ZTest LEqual
       ZWrite On

            // Debug
            // <None>

            // --------------------------------------------------
            // Pass

            HLSLPROGRAM

            // Pragmas
            #pragma target 4.5
        #pragma exclude_renderers gles gles3 glcore
        #pragma multi_compile_instancing
        #pragma multi_compile_fog
        #pragma multi_compile _ DOTS_INSTANCING_ON
        #pragma vertex vert
        #pragma fragment frag

            // DotsInstancingOptions: <None>
            // HybridV1InjectedBuiltinProperties: <None>

            // Keywords
            #pragma multi_compile _ _SCREEN_SPACE_OCCLUSION
        #pragma multi_compile _ LIGHTMAP_ON
        #pragma multi_compile _ DIRLIGHTMAP_COMBINED
        #pragma multi_compile _ _MAIN_LIGHT_SHADOWS
        #pragma multi_compile _ _MAIN_LIGHT_SHADOWS_CASCADE
        #pragma multi_compile _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS _ADDITIONAL_OFF
        #pragma multi_compile _ _ADDITIONAL_LIGHT_SHADOWS
        #pragma multi_compile _ _SHADOWS_SOFT
        #pragma multi_compile _ LIGHTMAP_SHADOW_MIXING
        #pragma multi_compile _ SHADOWS_SHADOWMASK
            #pragma shader_feature_local _ _USEDYNAMICCOVERTSTATICMASKF_ON

        #if defined(_USEDYNAMICCOVERTSTATICMASKF_ON)
            #define KEYWORD_PERMUTATION_0
        #else
            #define KEYWORD_PERMUTATION_1
        #endif


            // Defines
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _SURFACE_TYPE_TRANSPARENT 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _AlphaClip 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMALMAP 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMAL_DROPOFF_TS 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_NORMAL
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TANGENT
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TEXCOORD0
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TEXCOORD1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_COLOR
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_POSITION_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_NORMAL_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TANGENT_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TEXCOORD0
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_COLOR
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_VIEWDIRECTION_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
        #endif

            #define FEATURES_GRAPH_VERTEX
            /* WARNING: $splice Could not find named fragment 'PassInstancing' */
            #define SHADERPASS SHADERPASS_FORWARD
            /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */

            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

            // --------------------------------------------------
            // Structs and Packing

            struct Attributes
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 positionOS : POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 normalOS : NORMAL;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 tangentOS : TANGENT;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 uv0 : TEXCOORD0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 uv1 : TEXCOORD1;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 color : COLOR;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : INSTANCEID_SEMANTIC;
            #endif
            #endif
        };
        struct Varyings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 positionWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 normalWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 tangentWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 texCoord0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 color;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 viewDirectionWS;
            #endif
            #if defined(LIGHTMAP_ON)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 lightmapUV;
            #endif
            #endif
            #if !defined(LIGHTMAP_ON)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 sh;
            #endif
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 fogFactorAndVertexLight;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 shadowCoord;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };
        struct SurfaceDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 TangentSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceBiTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 AbsoluteWorldSpacePosition;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 uv0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 VertexColor;
            #endif
        };
        struct VertexDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpacePosition;
            #endif
        };
        struct PackedVaryings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp0 : TEXCOORD0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp1 : TEXCOORD1;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 interp2 : TEXCOORD2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 interp3 : TEXCOORD3;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 interp4 : TEXCOORD4;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp5 : TEXCOORD5;
            #endif
            #if defined(LIGHTMAP_ON)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 interp6 : TEXCOORD6;
            #endif
            #endif
            #if !defined(LIGHTMAP_ON)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp7 : TEXCOORD7;
            #endif
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 interp8 : TEXCOORD8;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 interp9 : TEXCOORD9;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };

            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            output.positionCS = input.positionCS;
            output.interp0.xyz =  input.positionWS;
            output.interp1.xyz =  input.normalWS;
            output.interp2.xyzw =  input.tangentWS;
            output.interp3.xyzw =  input.texCoord0;
            output.interp4.xyzw =  input.color;
            output.interp5.xyz =  input.viewDirectionWS;
            #if defined(LIGHTMAP_ON)
            output.interp6.xy =  input.lightmapUV;
            #endif
            #if !defined(LIGHTMAP_ON)
            output.interp7.xyz =  input.sh;
            #endif
            output.interp8.xyzw =  input.fogFactorAndVertexLight;
            output.interp9.xyzw =  input.shadowCoord;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.positionWS = input.interp0.xyz;
            output.normalWS = input.interp1.xyz;
            output.tangentWS = input.interp2.xyzw;
            output.texCoord0 = input.interp3.xyzw;
            output.color = input.interp4.xyzw;
            output.viewDirectionWS = input.interp5.xyz;
            #if defined(LIGHTMAP_ON)
            output.lightmapUV = input.interp6.xy;
            #endif
            #if !defined(LIGHTMAP_ON)
            output.sh = input.interp7.xyz;
            #endif
            output.fogFactorAndVertexLight = input.interp8.xyzw;
            output.shadowCoord = input.interp9.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        #endif

            // --------------------------------------------------
            // Graph

            // Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float _AlphaCutoff;
        float4 _BaseColor;
        float4 _BaseColorMap_TexelSize;
        float _BaseUsePlanarUV;
        float4 _BaseTilingOffset;
        float4 _BaseNormalMap_TexelSize;
        float _BaseNormalScale;
        float4 _BaseMaskMap_TexelSize;
        float _BaseMetallic;
        float _BaseAORemapMin;
        float _BaseAORemapMax;
        float _BaseSmoothnessRemapMin;
        float _BaseSmoothnessRemapMax;
        float4 _LayerMask_TexelSize;
        float _Invert_Layer_Mask;
        float _Height_Transition;
        float _HeightMin;
        float _HeightMax;
        float _HeightOffset;
        float _HeightMin2;
        float _HeightMax2;
        float _HeightOffset2;
        float IgnoreBase2Alpha;
        float4 _Base2Color;
        float4 _Base2ColorMap_TexelSize;
        float4 _Base2TilingOffset;
        float _Base2UsePlanarUV;
        float4 _Base2NormalMap_TexelSize;
        float _Base2NormalScale;
        float4 _Base2MaskMap_TexelSize;
        float _Base2Metallic;
        float _Base2SmoothnessRemapMin;
        float _Base2SmoothnessRemapMax;
        float _Base2AORemapMin;
        float _Base2AORemapMax;
        float4 _CoverMaskA_TexelSize;
        float _CoverMaskPower;
        float _Cover_Amount;
        float _Cover_Amount_Grow_Speed;
        float _Cover_Max_Angle;
        float _Cover_Min_Height;
        float _Cover_Min_Height_Blending;
        float4 _CoverBaseColor;
        float4 _CoverBaseColorMap_TexelSize;
        float4 _CoverTilingOffset;
        float _CoverUsePlanarUV;
        float4 _CoverNormalMap_TexelSize;
        float _CoverNormalScale;
        float _CoverNormalBlendHardness;
        float _CoverHardness;
        float _CoverHeightMapMin;
        float _CoverHeightMapMax;
        float _CoverHeightMapOffset;
        float4 _CoverMaskMap_TexelSize;
        float _CoverMetallic;
        float _CoverAORemapMin;
        float _CoverAORemapMax;
        float _CoverSmoothnessRemapMin;
        float _CoverSmoothnessRemapMax;
        CBUFFER_END

        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_BaseColorMap);
        SAMPLER(sampler_BaseColorMap);
        TEXTURE2D(_BaseNormalMap);
        SAMPLER(sampler_BaseNormalMap);
        TEXTURE2D(_BaseMaskMap);
        SAMPLER(sampler_BaseMaskMap);
        TEXTURE2D(_LayerMask);
        SAMPLER(sampler_LayerMask);
        TEXTURE2D(_Base2ColorMap);
        SAMPLER(sampler_Base2ColorMap);
        TEXTURE2D(_Base2NormalMap);
        SAMPLER(sampler_Base2NormalMap);
        TEXTURE2D(_Base2MaskMap);
        SAMPLER(sampler_Base2MaskMap);
        TEXTURE2D(_CoverMaskA);
        SAMPLER(sampler_CoverMaskA);
        TEXTURE2D(_CoverBaseColorMap);
        SAMPLER(sampler_CoverBaseColorMap);
        TEXTURE2D(_CoverNormalMap);
        SAMPLER(sampler_CoverNormalMap);
        TEXTURE2D(_CoverMaskMap);
        SAMPLER(sampler_CoverMaskMap);

            // Graph Functions
            
        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }

        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }

        void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }

        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }

        void Unity_Branch_float2(float Predicate, float2 True, float2 False, out float2 Out)
        {
            Out = Predicate ? True : False;
        }

        struct Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6
        {
            float3 AbsoluteWorldSpacePosition;
            half4 uv0;
        };

        void SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(UnityTexture2D Texture2D_80A3D28F, float4 Vector4_2EBA7A3B, float Boolean_7ABB9909, Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 IN, out float4 XZ_2)
        {
            UnityTexture2D _Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0 = Texture2D_80A3D28F;
            float _Property_30834f691775a0898a45b1c868520436_Out_0 = Boolean_7ABB9909;
            float _Split_89ed63cb625cb3878c183d0b71c03400_R_1 = IN.AbsoluteWorldSpacePosition[0];
            float _Split_89ed63cb625cb3878c183d0b71c03400_G_2 = IN.AbsoluteWorldSpacePosition[1];
            float _Split_89ed63cb625cb3878c183d0b71c03400_B_3 = IN.AbsoluteWorldSpacePosition[2];
            float _Split_89ed63cb625cb3878c183d0b71c03400_A_4 = 0;
            float4 _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4;
            float3 _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5;
            float2 _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6;
            Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_B_3, 0, 0, _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5, _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6);
            float4 _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0 = Vector4_2EBA7A3B;
            float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[0];
            float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_G_2 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[1];
            float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_B_3 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[2];
            float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_A_4 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[3];
            float _Divide_e64179199923c58289b6aa94ea6c9178_Out_2;
            Unity_Divide_float(1, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1, _Divide_e64179199923c58289b6aa94ea6c9178_Out_2);
            float4 _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2;
            Unity_Multiply_float(_Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, (_Divide_e64179199923c58289b6aa94ea6c9178_Out_2.xxxx), _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2);
            float2 _Vector2_16c15d3bbdd14b85bd48e3a6cb318af7_Out_0 = float2(_Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_G_2);
            float2 _Vector2_f8d75f54e7705083bbec539a60185577_Out_0 = float2(_Split_2f0f52f6ef8c0e81af0da6476402bc1f_B_3, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_A_4);
            float2 _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_16c15d3bbdd14b85bd48e3a6cb318af7_Out_0, _Vector2_f8d75f54e7705083bbec539a60185577_Out_0, _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3);
            float2 _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3;
            Unity_Branch_float2(_Property_30834f691775a0898a45b1c868520436_Out_0, (_Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2.xy), _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3, _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3);
            float4 _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0 = SAMPLE_TEXTURE2D(_Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0.tex, _Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0.samplerstate, _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3);
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.r;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.g;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.b;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_A_7 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.a;
            XZ_2 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0;
        }

        void Unity_Add_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A + B;
        }

        void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
        {
            Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
        }

        void Unity_OneMinus_float(float In, out float Out)
        {
            Out = 1 - In;
        }

        void Unity_Branch_float(float Predicate, float True, float False, out float Out)
        {
            Out = Predicate ? True : False;
        }

        void Unity_Multiply_float(float A, float B, out float Out)
        {
            Out = A * B;
        }

        void Unity_Maximum_float(float A, float B, out float Out)
        {
            Out = max(A, B);
        }

        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }

        void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }

        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }

        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }

        void Unity_Divide_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A / B;
        }

        struct Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135
        {
        };

        void SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135(float3 Vector3_88EEBB5E, float Vector1_DA0A37FA, float3 Vector3_79AA92F, float Vector1_F7E83F1E, float Vector1_1C9222A6, Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 IN, out float3 OutVector4_1)
        {
            float3 _Property_dd1c841a04c03f8c85e7b00eb025ecda_Out_0 = Vector3_88EEBB5E;
            float _Property_14119cc7eaf4128f991283d47cf72d85_Out_0 = Vector1_DA0A37FA;
            float _Property_48af0ad45e3f7f82932b938695d21391_Out_0 = Vector1_DA0A37FA;
            float _Property_8a30b3ca12ff518fa473ccd686c7d503_Out_0 = Vector1_F7E83F1E;
            float _Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2;
            Unity_Maximum_float(_Property_48af0ad45e3f7f82932b938695d21391_Out_0, _Property_8a30b3ca12ff518fa473ccd686c7d503_Out_0, _Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2);
            float _Property_ee8d5fc69475d181be60c57e04ea8708_Out_0 = Vector1_1C9222A6;
            float _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2;
            Unity_Subtract_float(_Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2, _Property_ee8d5fc69475d181be60c57e04ea8708_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2);
            float _Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2;
            Unity_Subtract_float(_Property_14119cc7eaf4128f991283d47cf72d85_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2, _Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2);
            float _Maximum_d02e48d92038448cb0345e5cf3779071_Out_2;
            Unity_Maximum_float(_Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2, 0, _Maximum_d02e48d92038448cb0345e5cf3779071_Out_2);
            float3 _Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2;
            Unity_Multiply_float(_Property_dd1c841a04c03f8c85e7b00eb025ecda_Out_0, (_Maximum_d02e48d92038448cb0345e5cf3779071_Out_2.xxx), _Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2);
            float3 _Property_c7292b3b08585f8c8670172b9a220bf0_Out_0 = Vector3_79AA92F;
            float _Property_5e920479576fad83ba1947728dcceab4_Out_0 = Vector1_F7E83F1E;
            float _Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2;
            Unity_Subtract_float(_Property_5e920479576fad83ba1947728dcceab4_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2, _Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2);
            float _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2;
            Unity_Maximum_float(_Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2, 0, _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2);
            float3 _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2;
            Unity_Multiply_float(_Property_c7292b3b08585f8c8670172b9a220bf0_Out_0, (_Maximum_216777d30802328eab607c8fe68ba3a1_Out_2.xxx), _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2);
            float3 _Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2;
            Unity_Add_float3(_Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2, _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2, _Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2);
            float _Add_356384b52728f583bd6e694bc1fc3738_Out_2;
            Unity_Add_float(_Maximum_d02e48d92038448cb0345e5cf3779071_Out_2, _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2, _Add_356384b52728f583bd6e694bc1fc3738_Out_2);
            float _Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2;
            Unity_Maximum_float(_Add_356384b52728f583bd6e694bc1fc3738_Out_2, 1E-05, _Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2);
            float3 _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2;
            Unity_Divide_float3(_Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2, (_Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2.xxx), _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2);
            OutVector4_1 = _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2;
        }

        void Unity_Clamp_float(float In, float Min, float Max, out float Out)
        {
            Out = clamp(In, Min, Max);
        }

        void Unity_Sign_float3(float3 In, out float3 Out)
        {
            Out = sign(In);
        }

        void Unity_Multiply_float(float2 A, float2 B, out float2 Out)
        {
            Out = A * B;
        }

        void Unity_Normalize_float3(float3 In, out float3 Out)
        {
            Out = normalize(In);
        }

        void Unity_Branch_float3(float Predicate, float3 True, float3 False, out float3 Out)
        {
            Out = Predicate ? True : False;
        }

        struct Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8
        {
            float3 WorldSpaceNormal;
            float3 WorldSpaceTangent;
            float3 WorldSpaceBiTangent;
            float3 AbsoluteWorldSpacePosition;
            half4 uv0;
        };

        void SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(UnityTexture2D Texture2D_80A3D28F, float4 Vector4_82674548, float Boolean_9FF42DF6, Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 IN, out float4 XZ_2)
        {
            float _Property_1ef12cf3201a938993fe6a7951b0e754_Out_0 = Boolean_9FF42DF6;
            UnityTexture2D _Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0 = Texture2D_80A3D28F;
            float _Split_89ed63cb625cb3878c183d0b71c03400_R_1 = IN.AbsoluteWorldSpacePosition[0];
            float _Split_89ed63cb625cb3878c183d0b71c03400_G_2 = IN.AbsoluteWorldSpacePosition[1];
            float _Split_89ed63cb625cb3878c183d0b71c03400_B_3 = IN.AbsoluteWorldSpacePosition[2];
            float _Split_89ed63cb625cb3878c183d0b71c03400_A_4 = 0;
            float4 _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4;
            float3 _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5;
            float2 _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6;
            Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_B_3, 0, 0, _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5, _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6);
            float4 _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0 = Vector4_82674548;
            float _Split_a2e12fa5931da084b2949343a539dfd8_R_1 = _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0[0];
            float _Split_a2e12fa5931da084b2949343a539dfd8_G_2 = _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0[1];
            float _Split_a2e12fa5931da084b2949343a539dfd8_B_3 = _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0[2];
            float _Split_a2e12fa5931da084b2949343a539dfd8_A_4 = _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0[3];
            float _Divide_c36b770dfaa0bb8f85ab27da5fd794f0_Out_2;
            Unity_Divide_float(1, _Split_a2e12fa5931da084b2949343a539dfd8_R_1, _Divide_c36b770dfaa0bb8f85ab27da5fd794f0_Out_2);
            float4 _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2;
            Unity_Multiply_float(_Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, (_Divide_c36b770dfaa0bb8f85ab27da5fd794f0_Out_2.xxxx), _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2);
            float2 _Vector2_6845d21872714d889783b0cb707df3e9_Out_0 = float2(_Split_a2e12fa5931da084b2949343a539dfd8_R_1, _Split_a2e12fa5931da084b2949343a539dfd8_G_2);
            float2 _Vector2_e2e2263627c6098e96a5b5d29350ad03_Out_0 = float2(_Split_a2e12fa5931da084b2949343a539dfd8_B_3, _Split_a2e12fa5931da084b2949343a539dfd8_A_4);
            float2 _TilingAndOffset_17582d056c0b8a8dab1017d37497fe59_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_6845d21872714d889783b0cb707df3e9_Out_0, _Vector2_e2e2263627c6098e96a5b5d29350ad03_Out_0, _TilingAndOffset_17582d056c0b8a8dab1017d37497fe59_Out_3);
            float2 _Branch_1e152f3aac57448f8518bf2852c000c3_Out_3;
            Unity_Branch_float2(_Property_1ef12cf3201a938993fe6a7951b0e754_Out_0, (_Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2.xy), _TilingAndOffset_17582d056c0b8a8dab1017d37497fe59_Out_3, _Branch_1e152f3aac57448f8518bf2852c000c3_Out_3);
            float4 _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0 = SAMPLE_TEXTURE2D(_Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0.tex, _Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0.samplerstate, _Branch_1e152f3aac57448f8518bf2852c000c3_Out_3);
            _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0);
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.r;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.g;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.b;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_A_7 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.a;
            float2 _Vector2_ad6bd100e273d78fa409a30a77bfa2cc_Out_0 = float2(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4, _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5);
            float3 _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1;
            Unity_Sign_float3(IN.WorldSpaceNormal, _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1);
            float _Split_6299d4ddcc4c74828aea40a46fdb896e_R_1 = _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1[0];
            float _Split_6299d4ddcc4c74828aea40a46fdb896e_G_2 = _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1[1];
            float _Split_6299d4ddcc4c74828aea40a46fdb896e_B_3 = _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1[2];
            float _Split_6299d4ddcc4c74828aea40a46fdb896e_A_4 = 0;
            float2 _Vector2_b76cb1842101e58b9e636d49b075c612_Out_0 = float2(_Split_6299d4ddcc4c74828aea40a46fdb896e_G_2, 1);
            float2 _Multiply_31e8db88ee20c985a9850d1a58f3282b_Out_2;
            Unity_Multiply_float(_Vector2_ad6bd100e273d78fa409a30a77bfa2cc_Out_0, _Vector2_b76cb1842101e58b9e636d49b075c612_Out_0, _Multiply_31e8db88ee20c985a9850d1a58f3282b_Out_2);
            float _Split_5ed44bf2eca0868f81eb18100f49d1fa_R_1 = IN.WorldSpaceNormal[0];
            float _Split_5ed44bf2eca0868f81eb18100f49d1fa_G_2 = IN.WorldSpaceNormal[1];
            float _Split_5ed44bf2eca0868f81eb18100f49d1fa_B_3 = IN.WorldSpaceNormal[2];
            float _Split_5ed44bf2eca0868f81eb18100f49d1fa_A_4 = 0;
            float2 _Vector2_70e5837843f28b8b9d64cada3697bd5a_Out_0 = float2(_Split_5ed44bf2eca0868f81eb18100f49d1fa_R_1, _Split_5ed44bf2eca0868f81eb18100f49d1fa_B_3);
            float2 _Add_1145b2f896593d80aa864a34e6702562_Out_2;
            Unity_Add_float2(_Multiply_31e8db88ee20c985a9850d1a58f3282b_Out_2, _Vector2_70e5837843f28b8b9d64cada3697bd5a_Out_0, _Add_1145b2f896593d80aa864a34e6702562_Out_2);
            float _Split_2bc77ca2d17bd78cb2383770ce50b179_R_1 = _Add_1145b2f896593d80aa864a34e6702562_Out_2[0];
            float _Split_2bc77ca2d17bd78cb2383770ce50b179_G_2 = _Add_1145b2f896593d80aa864a34e6702562_Out_2[1];
            float _Split_2bc77ca2d17bd78cb2383770ce50b179_B_3 = 0;
            float _Split_2bc77ca2d17bd78cb2383770ce50b179_A_4 = 0;
            float _Multiply_ab12aea87465a78eaf7fc66c2598d266_Out_2;
            Unity_Multiply_float(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6, _Split_5ed44bf2eca0868f81eb18100f49d1fa_G_2, _Multiply_ab12aea87465a78eaf7fc66c2598d266_Out_2);
            float3 _Vector3_433840b555db308b97e9b14b6a957195_Out_0 = float3(_Split_2bc77ca2d17bd78cb2383770ce50b179_R_1, _Multiply_ab12aea87465a78eaf7fc66c2598d266_Out_2, _Split_2bc77ca2d17bd78cb2383770ce50b179_G_2);
            float3x3 Transform_c7914cc45a011c89b3f53c55afb51673_tangentTransform_World = float3x3(IN.WorldSpaceTangent, IN.WorldSpaceBiTangent, IN.WorldSpaceNormal);
            float3 _Transform_c7914cc45a011c89b3f53c55afb51673_Out_1 = TransformWorldToTangent(_Vector3_433840b555db308b97e9b14b6a957195_Out_0.xyz, Transform_c7914cc45a011c89b3f53c55afb51673_tangentTransform_World);
            float3 _Normalize_09bf8a2bd0a4d38e8b97d5c674f79b44_Out_1;
            Unity_Normalize_float3(_Transform_c7914cc45a011c89b3f53c55afb51673_Out_1, _Normalize_09bf8a2bd0a4d38e8b97d5c674f79b44_Out_1);
            float3 _Branch_9eadf909a90f2f80880f8c56ecc2a91f_Out_3;
            Unity_Branch_float3(_Property_1ef12cf3201a938993fe6a7951b0e754_Out_0, _Normalize_09bf8a2bd0a4d38e8b97d5c674f79b44_Out_1, (_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.xyz), _Branch_9eadf909a90f2f80880f8c56ecc2a91f_Out_3);
            XZ_2 = (float4(_Branch_9eadf909a90f2f80880f8c56ecc2a91f_Out_3, 1.0));
        }

        void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
        {
            Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
        }

        void Unity_Absolute_float(float In, out float Out)
        {
            Out = abs(In);
        }

        void Unity_Power_float(float A, float B, out float Out)
        {
            Out = pow(A, B);
        }

        void Unity_Saturate_float(float In, out float Out)
        {
            Out = saturate(In);
        }

        void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
        {
            Out = lerp(A, B, T);
        }

        void Unity_Lerp_float(float A, float B, float T, out float Out)
        {
            Out = lerp(A, B, T);
        }

            // Graph Vertex
            struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };

        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }

            // Graph Pixel
            struct SurfaceDescription
        {
            float3 BaseColor;
            float3 NormalTS;
            float3 Emission;
            float Metallic;
            float Smoothness;
            float Occlusion;
            float Alpha;
            float AlphaClipThreshold;
        };

        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_07d75b1d2628da808a2efb93a1d6219e_Out_0 = UnityBuildTexture2DStructNoScale(_BaseColorMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0 = _BaseTilingOffset;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_7f998178363b4188ba2f07298ef869c1_Out_0 = _BaseUsePlanarUV;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e;
            _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e.uv0 = IN.uv0;
            float4 _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2;
            SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(_Property_07d75b1d2628da808a2efb93a1d6219e_Out_0, _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0, _Property_7f998178363b4188ba2f07298ef869c1_Out_0, _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e, _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_b83097c58639858680bf43881a95b0af_Out_0 = _BaseColor;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2;
            Unity_Multiply_float(_PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2, _Property_b83097c58639858680bf43881a95b0af_Out_0, _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_1e449ff9f8e8ec828507233e8240eb11_Out_0 = UnityBuildTexture2DStructNoScale(_BaseMaskMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_4245c3b264047180b5c90a697d6cb278;
            _PlanarNM_4245c3b264047180b5c90a697d6cb278.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNM_4245c3b264047180b5c90a697d6cb278.uv0 = IN.uv0;
            float4 _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2;
            SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(_Property_1e449ff9f8e8ec828507233e8240eb11_Out_0, _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0, _Property_7f998178363b4188ba2f07298ef869c1_Out_0, _PlanarNM_4245c3b264047180b5c90a697d6cb278, _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_91a015dea8acd38b904ba0935328a5bc_R_1 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[0];
            float _Split_91a015dea8acd38b904ba0935328a5bc_G_2 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[1];
            float _Split_91a015dea8acd38b904ba0935328a5bc_B_3 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[2];
            float _Split_91a015dea8acd38b904ba0935328a5bc_A_4 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_fbcff1469ebf488394a8a89ddaf0eb2a_Out_0 = _HeightMin;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_9df7a44c8225168683743ac60c0c3c34_Out_0 = _HeightMax;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_9b1e95888c28bc8893f28c02b87fa448_Out_0 = float2(_Property_fbcff1469ebf488394a8a89ddaf0eb2a_Out_0, _Property_9df7a44c8225168683743ac60c0c3c34_Out_0);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_29ca14fd0b712983a38d63d2dd326e96_Out_0 = _HeightOffset;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Add_cb503f8a09720d84bb03cbd89e37b80c_Out_2;
            Unity_Add_float2(_Vector2_9b1e95888c28bc8893f28c02b87fa448_Out_0, (_Property_29ca14fd0b712983a38d63d2dd326e96_Out_0.xx), _Add_cb503f8a09720d84bb03cbd89e37b80c_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3;
            Unity_Remap_float(_Split_91a015dea8acd38b904ba0935328a5bc_B_3, float2 (0, 1), _Add_cb503f8a09720d84bb03cbd89e37b80c_Out_2, _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_ba3a5f4cba7d0a8fa288ffc8267d6c0e_Out_0 = UnityBuildTexture2DStructNoScale(_Base2ColorMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_86a4657df480d48e8d3ad3b036731380_Out_0 = _Base2TilingOffset;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0 = _Base2UsePlanarUV;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4;
            _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4.uv0 = IN.uv0;
            float4 _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4_XZ_2;
            SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(_Property_ba3a5f4cba7d0a8fa288ffc8267d6c0e_Out_0, _Property_86a4657df480d48e8d3ad3b036731380_Out_0, _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0, _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4, _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_3561b11b899bda8e855826445cf628aa_Out_0 = _Base2Color;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2;
            Unity_Multiply_float(_PlanarNM_5aeab444ca6fd78ea56a01215880a5a4_XZ_2, _Property_3561b11b899bda8e855826445cf628aa_Out_0, _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_c34b73d933404283983f9c8bdb5365d3_R_1 = IN.VertexColor[0];
            float _Split_c34b73d933404283983f9c8bdb5365d3_G_2 = IN.VertexColor[1];
            float _Split_c34b73d933404283983f9c8bdb5365d3_B_3 = IN.VertexColor[2];
            float _Split_c34b73d933404283983f9c8bdb5365d3_A_4 = IN.VertexColor[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_df2df7bb5cfc3381beee7ec454da7542_Out_0 = _Invert_Layer_Mask;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_c7b1e2df9f9b0e8eace9b2274924e69c_Out_0 = UnityBuildTexture2DStructNoScale(_LayerMask);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0 = SAMPLE_TEXTURE2D(_Property_c7b1e2df9f9b0e8eace9b2274924e69c_Out_0.tex, _Property_c7b1e2df9f9b0e8eace9b2274924e69c_Out_0.samplerstate, IN.uv0.xy);
            float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.r;
            float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_G_5 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.g;
            float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_B_6 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.b;
            float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_A_7 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1;
            Unity_OneMinus_float(_SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4, _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Branch_af0c5e511241ce8eae748ae487df50fa_Out_3;
            Unity_Branch_float(_Property_df2df7bb5cfc3381beee7ec454da7542_Out_0, _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1, _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4, _Branch_af0c5e511241ce8eae748ae487df50fa_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_de4f6eb48a629285a664dad7fb06438f_Out_0 = UnityBuildTexture2DStructNoScale(_Base2MaskMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_d5657f470f05ef839e4c257a20ace8cb;
            _PlanarNM_d5657f470f05ef839e4c257a20ace8cb.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNM_d5657f470f05ef839e4c257a20ace8cb.uv0 = IN.uv0;
            float4 _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2;
            SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(_Property_de4f6eb48a629285a664dad7fb06438f_Out_0, _Property_86a4657df480d48e8d3ad3b036731380_Out_0, _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0, _PlanarNM_d5657f470f05ef839e4c257a20ace8cb, _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_83ec66b648ab6c84848b42686c256cd7_R_1 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[0];
            float _Split_83ec66b648ab6c84848b42686c256cd7_G_2 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[1];
            float _Split_83ec66b648ab6c84848b42686c256cd7_B_3 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[2];
            float _Split_83ec66b648ab6c84848b42686c256cd7_A_4 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_ce1750e5c69e97818667b412fc3f9f2c_Out_0 = _HeightMin2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_8e0f2ea54d8ede89bbabdf31a9bafd57_Out_0 = _HeightMax2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_fb6c6dd7e70e768ba686e8e94153bb96_Out_0 = float2(_Property_ce1750e5c69e97818667b412fc3f9f2c_Out_0, _Property_8e0f2ea54d8ede89bbabdf31a9bafd57_Out_0);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_151ae2702b614585af2000f0a812960f_Out_0 = _HeightOffset2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2;
            Unity_Add_float2(_Vector2_fb6c6dd7e70e768ba686e8e94153bb96_Out_0, (_Property_151ae2702b614585af2000f0a812960f_Out_0.xx), _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3;
            Unity_Remap_float(_Split_83ec66b648ab6c84848b42686c256cd7_B_3, float2 (0, 1), _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2, _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2;
            Unity_Multiply_float(_Branch_af0c5e511241ce8eae748ae487df50fa_Out_3, _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3, _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2;
            Unity_Multiply_float(_Split_c34b73d933404283983f9c8bdb5365d3_R_1, _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2, _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_818c8af4b930138e81034c886614171d_Out_0 = _Height_Transition;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 _HeightBlend_7501025b3a60738a9a9d362e35a9ab48;
            float3 _HeightBlend_7501025b3a60738a9a9d362e35a9ab48_OutVector4_1;
            SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135((_Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2.xyz), _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3, (_Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2.xyz), _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2, _Property_818c8af4b930138e81034c886614171d_Out_0, _HeightBlend_7501025b3a60738a9a9d362e35a9ab48, _HeightBlend_7501025b3a60738a9a9d362e35a9ab48_OutVector4_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_c0ebdab0f71ace8aabaa865fd7293599_Out_0 = UnityBuildTexture2DStructNoScale(_CoverBaseColorMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_822489d2e6d3e08590c64f085ffd9b2e_Out_0 = _CoverTilingOffset;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_2ae4a163bd21d98789af282d6e469175_Out_0 = _CoverUsePlanarUV;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_8bb420494d19b28e9ccdff489802dc81;
            _PlanarNM_8bb420494d19b28e9ccdff489802dc81.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNM_8bb420494d19b28e9ccdff489802dc81.uv0 = IN.uv0;
            float4 _PlanarNM_8bb420494d19b28e9ccdff489802dc81_XZ_2;
            SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(_Property_c0ebdab0f71ace8aabaa865fd7293599_Out_0, _Property_822489d2e6d3e08590c64f085ffd9b2e_Out_0, _Property_2ae4a163bd21d98789af282d6e469175_Out_0, _PlanarNM_8bb420494d19b28e9ccdff489802dc81, _PlanarNM_8bb420494d19b28e9ccdff489802dc81_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_55e7941fa7ac5f8387aa9bb633b08883_Out_0 = _CoverBaseColor;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Multiply_a38ba695a2660c8691763f0bd7fe159c_Out_2;
            Unity_Multiply_float(_PlanarNM_8bb420494d19b28e9ccdff489802dc81_XZ_2, _Property_55e7941fa7ac5f8387aa9bb633b08883_Out_0, _Multiply_a38ba695a2660c8691763f0bd7fe159c_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_c0d223db25424a8ab0cee2de2bbf58ce_Out_0 = UnityBuildTexture2DStructNoScale(_CoverMaskA);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _UV_5352c8dd0add178ba83a5421c2c0b3f0_Out_0 = IN.uv0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _SampleTexture2D_024ba490c015248988a12a9d670014ea_RGBA_0 = SAMPLE_TEXTURE2D(_Property_c0d223db25424a8ab0cee2de2bbf58ce_Out_0.tex, _Property_c0d223db25424a8ab0cee2de2bbf58ce_Out_0.samplerstate, (_UV_5352c8dd0add178ba83a5421c2c0b3f0_Out_0.xy));
            float _SampleTexture2D_024ba490c015248988a12a9d670014ea_R_4 = _SampleTexture2D_024ba490c015248988a12a9d670014ea_RGBA_0.r;
            float _SampleTexture2D_024ba490c015248988a12a9d670014ea_G_5 = _SampleTexture2D_024ba490c015248988a12a9d670014ea_RGBA_0.g;
            float _SampleTexture2D_024ba490c015248988a12a9d670014ea_B_6 = _SampleTexture2D_024ba490c015248988a12a9d670014ea_RGBA_0.b;
            float _SampleTexture2D_024ba490c015248988a12a9d670014ea_A_7 = _SampleTexture2D_024ba490c015248988a12a9d670014ea_RGBA_0.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_b80e7b96604b7c82bbf9bff4981fad76_Out_0 = _CoverMaskPower;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_abe410d256783480b1b58468bf78a882_Out_2;
            Unity_Multiply_float(_SampleTexture2D_024ba490c015248988a12a9d670014ea_A_7, _Property_b80e7b96604b7c82bbf9bff4981fad76_Out_0, _Multiply_abe410d256783480b1b58468bf78a882_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_a78f6f28770afd869adb9d12cd47370b_Out_3;
            Unity_Clamp_float(_Multiply_abe410d256783480b1b58468bf78a882_Out_2, 0, 1, _Clamp_a78f6f28770afd869adb9d12cd47370b_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_7c7049e15fdff386b535790d8666f609_Out_0 = UnityBuildTexture2DStructNoScale(_BaseNormalMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8;
            _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.WorldSpaceNormal = IN.WorldSpaceNormal;
            _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.WorldSpaceTangent = IN.WorldSpaceTangent;
            _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
            _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.uv0 = IN.uv0;
            float4 _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8_XZ_2;
            SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(_Property_7c7049e15fdff386b535790d8666f609_Out_0, _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0, _Property_7f998178363b4188ba2f07298ef869c1_Out_0, _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8, _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_d4b0759cf4647e81be065ec1465ce2b4_Out_0 = _BaseNormalScale;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _NormalStrength_f66a9108ea294886acc61513b41cc5e4_Out_2;
            Unity_NormalStrength_float((_PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8_XZ_2.xyz), _Property_d4b0759cf4647e81be065ec1465ce2b4_Out_0, _NormalStrength_f66a9108ea294886acc61513b41cc5e4_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_fa9f7890b20ad481a92543c04b237bde_Out_0 = UnityBuildTexture2DStructNoScale(_Base2NormalMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf;
            _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.WorldSpaceNormal = IN.WorldSpaceNormal;
            _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.WorldSpaceTangent = IN.WorldSpaceTangent;
            _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
            _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.uv0 = IN.uv0;
            float4 _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf_XZ_2;
            SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(_Property_fa9f7890b20ad481a92543c04b237bde_Out_0, _Property_86a4657df480d48e8d3ad3b036731380_Out_0, _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0, _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf, _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_8c31443b776727819a663c7ddce79064_Out_0 = _Base2NormalScale;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _NormalStrength_0fb86880ab8e368dac6d01b830e20ed8_Out_2;
            Unity_NormalStrength_float((_PlanarNMn_d7b3ec528088a085a5102e025a1b45cf_XZ_2.xyz), _Property_8c31443b776727819a663c7ddce79064_Out_0, _NormalStrength_0fb86880ab8e368dac6d01b830e20ed8_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 _HeightBlend_7c09d97625efce898e21b66cd039be8b;
            float3 _HeightBlend_7c09d97625efce898e21b66cd039be8b_OutVector4_1;
            SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135(_NormalStrength_f66a9108ea294886acc61513b41cc5e4_Out_2, _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3, _NormalStrength_0fb86880ab8e368dac6d01b830e20ed8_Out_2, _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2, _Property_818c8af4b930138e81034c886614171d_Out_0, _HeightBlend_7c09d97625efce898e21b66cd039be8b, _HeightBlend_7c09d97625efce898e21b66cd039be8b_OutVector4_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_65f7dd6fe6c29b83913af586c597a1ef_Out_0 = UnityBuildTexture2DStructNoScale(_CoverNormalMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3;
            _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3.WorldSpaceNormal = IN.WorldSpaceNormal;
            _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3.WorldSpaceTangent = IN.WorldSpaceTangent;
            _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
            _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3.uv0 = IN.uv0;
            float4 _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3_XZ_2;
            SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(_Property_65f7dd6fe6c29b83913af586c597a1ef_Out_0, _Property_822489d2e6d3e08590c64f085ffd9b2e_Out_0, _Property_2ae4a163bd21d98789af282d6e469175_Out_0, _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3, _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_19f92cae42737480a95820c51d4ba124_Out_0 = _CoverNormalBlendHardness;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _NormalStrength_2c3488591b8345869feb25a3dee06c3f_Out_2;
            Unity_NormalStrength_float((_PlanarNMn_248bc5b7421d3f828d166902c73ca6c3_XZ_2.xyz), _Property_19f92cae42737480a95820c51d4ba124_Out_0, _NormalStrength_2c3488591b8345869feb25a3dee06c3f_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_96bfe9cb80ad308385c191d094b3d071_R_1 = IN.WorldSpaceNormal[0];
            float _Split_96bfe9cb80ad308385c191d094b3d071_G_2 = IN.WorldSpaceNormal[1];
            float _Split_96bfe9cb80ad308385c191d094b3d071_B_3 = IN.WorldSpaceNormal[2];
            float _Split_96bfe9cb80ad308385c191d094b3d071_A_4 = 0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_0dd796aae8cd9f878bef13ceac4fe3ec_Out_0 = _Cover_Amount;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_67285cdc688aa38d83f62d5bb095d597_Out_0 = _Cover_Amount_Grow_Speed;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Subtract_fcefec675e7536888eccf5574d921972_Out_2;
            Unity_Subtract_float(4, _Property_67285cdc688aa38d83f62d5bb095d597_Out_0, _Subtract_fcefec675e7536888eccf5574d921972_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Divide_1e25465528e612839a4ce1faedd89e7d_Out_2;
            Unity_Divide_float(_Property_0dd796aae8cd9f878bef13ceac4fe3ec_Out_0, _Subtract_fcefec675e7536888eccf5574d921972_Out_2, _Divide_1e25465528e612839a4ce1faedd89e7d_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Absolute_d20b810ffdec828ab74dd6692d82f01b_Out_1;
            Unity_Absolute_float(_Divide_1e25465528e612839a4ce1faedd89e7d_Out_2, _Absolute_d20b810ffdec828ab74dd6692d82f01b_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Power_181fbf47cfdb258da1fe0b72a450986f_Out_2;
            Unity_Power_float(_Absolute_d20b810ffdec828ab74dd6692d82f01b_Out_1, _Subtract_fcefec675e7536888eccf5574d921972_Out_2, _Power_181fbf47cfdb258da1fe0b72a450986f_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_11f62dba01f1a38c9e0a9972ccd19246_Out_3;
            Unity_Clamp_float(_Power_181fbf47cfdb258da1fe0b72a450986f_Out_2, 0, 2, _Clamp_11f62dba01f1a38c9e0a9972ccd19246_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_9810f6d76275cd8fbe5e3a02360b98a7_Out_2;
            Unity_Multiply_float(_Split_96bfe9cb80ad308385c191d094b3d071_G_2, _Clamp_11f62dba01f1a38c9e0a9972ccd19246_Out_3, _Multiply_9810f6d76275cd8fbe5e3a02360b98a7_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Saturate_a007c5f214685c87bf6ca3e64c06b488_Out_1;
            Unity_Saturate_float(_Multiply_9810f6d76275cd8fbe5e3a02360b98a7_Out_2, _Saturate_a007c5f214685c87bf6ca3e64c06b488_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_1b2b25b617fc508b9835f0309136fd00_Out_3;
            Unity_Clamp_float(_Split_96bfe9cb80ad308385c191d094b3d071_G_2, 0, 0.9999, _Clamp_1b2b25b617fc508b9835f0309136fd00_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_7b12276ea7a4538db6804507b30a830c_Out_0 = _Cover_Max_Angle;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Divide_54c523ff4b7acb858e9e368fd1e4d34a_Out_2;
            Unity_Divide_float(_Property_7b12276ea7a4538db6804507b30a830c_Out_0, 45, _Divide_54c523ff4b7acb858e9e368fd1e4d34a_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _OneMinus_6cf431985b651e8e9546ae6cb2d4d668_Out_1;
            Unity_OneMinus_float(_Divide_54c523ff4b7acb858e9e368fd1e4d34a_Out_2, _OneMinus_6cf431985b651e8e9546ae6cb2d4d668_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Subtract_4ef7b60aeab8d589bf2d2423737642bc_Out_2;
            Unity_Subtract_float(_Clamp_1b2b25b617fc508b9835f0309136fd00_Out_3, _OneMinus_6cf431985b651e8e9546ae6cb2d4d668_Out_1, _Subtract_4ef7b60aeab8d589bf2d2423737642bc_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_a4b51894ea17818c9a27bb533a2ebe74_Out_3;
            Unity_Clamp_float(_Subtract_4ef7b60aeab8d589bf2d2423737642bc_Out_2, 0, 2, _Clamp_a4b51894ea17818c9a27bb533a2ebe74_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Divide_c4196d4f02190b89ba827ccd4ae8a74d_Out_2;
            Unity_Divide_float(1, _Divide_54c523ff4b7acb858e9e368fd1e4d34a_Out_2, _Divide_c4196d4f02190b89ba827ccd4ae8a74d_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_ffc22433163d1184846ede424b44bcb2_Out_2;
            Unity_Multiply_float(_Clamp_a4b51894ea17818c9a27bb533a2ebe74_Out_3, _Divide_c4196d4f02190b89ba827ccd4ae8a74d_Out_2, _Multiply_ffc22433163d1184846ede424b44bcb2_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Absolute_c2e5757082de5d878d4c023806fb2108_Out_1;
            Unity_Absolute_float(_Multiply_ffc22433163d1184846ede424b44bcb2_Out_2, _Absolute_c2e5757082de5d878d4c023806fb2108_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_849d9f217c95f38c9d49ab251578d8d5_Out_0 = _CoverHardness;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Power_578546d66d69a5829b745ebba1279adf_Out_2;
            Unity_Power_float(_Absolute_c2e5757082de5d878d4c023806fb2108_Out_1, _Property_849d9f217c95f38c9d49ab251578d8d5_Out_0, _Power_578546d66d69a5829b745ebba1279adf_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_34d2d3aff4814e8e83d2894b3512c6c8_Out_0 = _Cover_Min_Height;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _OneMinus_474df64227f004849b34c68fe8df93f2_Out_1;
            Unity_OneMinus_float(_Property_34d2d3aff4814e8e83d2894b3512c6c8_Out_0, _OneMinus_474df64227f004849b34c68fe8df93f2_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_ee4d9dc934b3508397d5a3dece110ab0_R_1 = IN.AbsoluteWorldSpacePosition[0];
            float _Split_ee4d9dc934b3508397d5a3dece110ab0_G_2 = IN.AbsoluteWorldSpacePosition[1];
            float _Split_ee4d9dc934b3508397d5a3dece110ab0_B_3 = IN.AbsoluteWorldSpacePosition[2];
            float _Split_ee4d9dc934b3508397d5a3dece110ab0_A_4 = 0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Add_d6bc513aa82d918ea24e279f4353d971_Out_2;
            Unity_Add_float(_OneMinus_474df64227f004849b34c68fe8df93f2_Out_1, _Split_ee4d9dc934b3508397d5a3dece110ab0_G_2, _Add_d6bc513aa82d918ea24e279f4353d971_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Add_a6a61cb12180108c9e1364b90d2673e2_Out_2;
            Unity_Add_float(_Add_d6bc513aa82d918ea24e279f4353d971_Out_2, 1, _Add_a6a61cb12180108c9e1364b90d2673e2_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_1874fdd00cb9aa839d93ab8536e2414d_Out_3;
            Unity_Clamp_float(_Add_a6a61cb12180108c9e1364b90d2673e2_Out_2, 0, 1, _Clamp_1874fdd00cb9aa839d93ab8536e2414d_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_7b91fd6e21b46c85816c7b681307cbe4_Out_0 = _Cover_Min_Height_Blending;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Add_6dca9453f6a35e8185c4b8e9782db0a9_Out_2;
            Unity_Add_float(_Add_d6bc513aa82d918ea24e279f4353d971_Out_2, _Property_7b91fd6e21b46c85816c7b681307cbe4_Out_0, _Add_6dca9453f6a35e8185c4b8e9782db0a9_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Divide_83415a319ecfba83af914cbc5487b546_Out_2;
            Unity_Divide_float(_Add_6dca9453f6a35e8185c4b8e9782db0a9_Out_2, _Add_d6bc513aa82d918ea24e279f4353d971_Out_2, _Divide_83415a319ecfba83af914cbc5487b546_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _OneMinus_bf150b22fcad5a87b7c825c9c6cf1687_Out_1;
            Unity_OneMinus_float(_Divide_83415a319ecfba83af914cbc5487b546_Out_2, _OneMinus_bf150b22fcad5a87b7c825c9c6cf1687_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Add_86ff9fa850efbe8c80705d8266609dab_Out_2;
            Unity_Add_float(_OneMinus_bf150b22fcad5a87b7c825c9c6cf1687_Out_1, -0.5, _Add_86ff9fa850efbe8c80705d8266609dab_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_906e140f01222d8ba61252ec6ec9d6a4_Out_3;
            Unity_Clamp_float(_Add_86ff9fa850efbe8c80705d8266609dab_Out_2, 0, 1, _Clamp_906e140f01222d8ba61252ec6ec9d6a4_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Add_c1ec5849bf72f585a30b3e11a91ada52_Out_2;
            Unity_Add_float(_Clamp_1874fdd00cb9aa839d93ab8536e2414d_Out_3, _Clamp_906e140f01222d8ba61252ec6ec9d6a4_Out_3, _Add_c1ec5849bf72f585a30b3e11a91ada52_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_17a8a0cf209a038b9e9c7f5681cdd1fb_Out_3;
            Unity_Clamp_float(_Add_c1ec5849bf72f585a30b3e11a91ada52_Out_2, 0, 1, _Clamp_17a8a0cf209a038b9e9c7f5681cdd1fb_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_8c2759ac24a9b289b1e9610cfd161bb0_Out_2;
            Unity_Multiply_float(_Power_578546d66d69a5829b745ebba1279adf_Out_2, _Clamp_17a8a0cf209a038b9e9c7f5681cdd1fb_Out_3, _Multiply_8c2759ac24a9b289b1e9610cfd161bb0_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_1a723f136ec7fa8c957b5d29e03d3051_Out_2;
            Unity_Multiply_float(_Saturate_a007c5f214685c87bf6ca3e64c06b488_Out_1, _Multiply_8c2759ac24a9b289b1e9610cfd161bb0_Out_2, _Multiply_1a723f136ec7fa8c957b5d29e03d3051_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Lerp_d1c72e47b283948584479177786ae8d5_Out_3;
            Unity_Lerp_float3(_HeightBlend_7c09d97625efce898e21b66cd039be8b_OutVector4_1, _NormalStrength_2c3488591b8345869feb25a3dee06c3f_Out_2, (_Multiply_1a723f136ec7fa8c957b5d29e03d3051_Out_2.xxx), _Lerp_d1c72e47b283948584479177786ae8d5_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3x3 Transform_180fb403b53f318db002e8eba7616644_transposeTangent = transpose(float3x3(IN.WorldSpaceTangent, IN.WorldSpaceBiTangent, IN.WorldSpaceNormal));
            float3 _Transform_180fb403b53f318db002e8eba7616644_Out_1 = normalize(mul(Transform_180fb403b53f318db002e8eba7616644_transposeTangent, _Lerp_d1c72e47b283948584479177786ae8d5_Out_3.xyz).xyz);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_c9a2b4fb4f688b8ebfc1436535cd5ba4_R_1 = _Transform_180fb403b53f318db002e8eba7616644_Out_1[0];
            float _Split_c9a2b4fb4f688b8ebfc1436535cd5ba4_G_2 = _Transform_180fb403b53f318db002e8eba7616644_Out_1[1];
            float _Split_c9a2b4fb4f688b8ebfc1436535cd5ba4_B_3 = _Transform_180fb403b53f318db002e8eba7616644_Out_1[2];
            float _Split_c9a2b4fb4f688b8ebfc1436535cd5ba4_A_4 = 0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_4c7631d0688102819e6d388d624855a1_Out_2;
            Unity_Multiply_float(_Split_c9a2b4fb4f688b8ebfc1436535cd5ba4_G_2, _Clamp_11f62dba01f1a38c9e0a9972ccd19246_Out_3, _Multiply_4c7631d0688102819e6d388d624855a1_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_f2887eb409f6bb81ae4caad2b01b17f1_Out_2;
            Unity_Multiply_float(_Clamp_11f62dba01f1a38c9e0a9972ccd19246_Out_3, _Property_849d9f217c95f38c9d49ab251578d8d5_Out_0, _Multiply_f2887eb409f6bb81ae4caad2b01b17f1_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_2e348ed31331e78791b2b3130a009f30_Out_2;
            Unity_Multiply_float(_Multiply_f2887eb409f6bb81ae4caad2b01b17f1_Out_2, _Multiply_8c2759ac24a9b289b1e9610cfd161bb0_Out_2, _Multiply_2e348ed31331e78791b2b3130a009f30_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_622e54e9a77b08839c0954ce5715ad1c_Out_2;
            Unity_Multiply_float(_Multiply_4c7631d0688102819e6d388d624855a1_Out_2, _Multiply_2e348ed31331e78791b2b3130a009f30_Out_2, _Multiply_622e54e9a77b08839c0954ce5715ad1c_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_608db04fab7d768d9a8b5fb9cf0768e1_Out_0 = UnityBuildTexture2DStructNoScale(_CoverMaskMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e;
            _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e.uv0 = IN.uv0;
            float4 _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e_XZ_2;
            SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(_Property_608db04fab7d768d9a8b5fb9cf0768e1_Out_0, _Property_822489d2e6d3e08590c64f085ffd9b2e_Out_0, _Property_2ae4a163bd21d98789af282d6e469175_Out_0, _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e, _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_86ec1aefda4f9e8e82b79c6195b397b0_R_1 = _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e_XZ_2[0];
            float _Split_86ec1aefda4f9e8e82b79c6195b397b0_G_2 = _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e_XZ_2[1];
            float _Split_86ec1aefda4f9e8e82b79c6195b397b0_B_3 = _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e_XZ_2[2];
            float _Split_86ec1aefda4f9e8e82b79c6195b397b0_A_4 = _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e_XZ_2[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_c9c6897e00458b8f8aa07df49fa519bc_Out_0 = _CoverHeightMapMin;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_ab94650b8edd82828661fe99e3c0e849_Out_0 = _CoverHeightMapMax;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_fe489f7321f6568686816b9eecbc16d1_Out_0 = float2(_Property_c9c6897e00458b8f8aa07df49fa519bc_Out_0, _Property_ab94650b8edd82828661fe99e3c0e849_Out_0);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_c1ab40024cb83b87960e4327efbd997f_Out_0 = _CoverHeightMapOffset;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Add_4a359522fc231c83b55ef23f341b6fb3_Out_2;
            Unity_Add_float2(_Vector2_fe489f7321f6568686816b9eecbc16d1_Out_0, (_Property_c1ab40024cb83b87960e4327efbd997f_Out_0.xx), _Add_4a359522fc231c83b55ef23f341b6fb3_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Remap_5aee5b64d41562858dc7c42d8b748894_Out_3;
            Unity_Remap_float(_Split_86ec1aefda4f9e8e82b79c6195b397b0_B_3, float2 (0, 1), _Add_4a359522fc231c83b55ef23f341b6fb3_Out_2, _Remap_5aee5b64d41562858dc7c42d8b748894_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_f0228e1cfd9c858dbb36367f551733c4_Out_2;
            Unity_Multiply_float(_Multiply_622e54e9a77b08839c0954ce5715ad1c_Out_2, _Remap_5aee5b64d41562858dc7c42d8b748894_Out_3, _Multiply_f0228e1cfd9c858dbb36367f551733c4_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_bb4d60728db93b8a9af9635fa1d69891_Out_2;
            Unity_Multiply_float(_Split_c34b73d933404283983f9c8bdb5365d3_G_2, _Multiply_f0228e1cfd9c858dbb36367f551733c4_Out_2, _Multiply_bb4d60728db93b8a9af9635fa1d69891_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Saturate_9b052a9bb99eff89bb11bdc387a0c2fd_Out_1;
            Unity_Saturate_float(_Multiply_bb4d60728db93b8a9af9635fa1d69891_Out_2, _Saturate_9b052a9bb99eff89bb11bdc387a0c2fd_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_22fb8c1cfd28b687a991e101aa13ff5b_Out_2;
            Unity_Multiply_float(_Clamp_a78f6f28770afd869adb9d12cd47370b_Out_3, _Saturate_9b052a9bb99eff89bb11bdc387a0c2fd_Out_1, _Multiply_22fb8c1cfd28b687a991e101aa13ff5b_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #if defined(_USEDYNAMICCOVERTSTATICMASKF_ON)
            float _UseDynamicCoverTStaticMaskF_20dcbac2f16cf78ebd6fd1debcd7f281_Out_0 = _Multiply_22fb8c1cfd28b687a991e101aa13ff5b_Out_2;
            #else
            float _UseDynamicCoverTStaticMaskF_20dcbac2f16cf78ebd6fd1debcd7f281_Out_0 = _Clamp_a78f6f28770afd869adb9d12cd47370b_Out_3;
            #endif
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Lerp_e5620b57c917728fa1416e2ffce9b0db_Out_3;
            Unity_Lerp_float3(_HeightBlend_7501025b3a60738a9a9d362e35a9ab48_OutVector4_1, (_Multiply_a38ba695a2660c8691763f0bd7fe159c_Out_2.xyz), (_UseDynamicCoverTStaticMaskF_20dcbac2f16cf78ebd6fd1debcd7f281_Out_0.xxx), _Lerp_e5620b57c917728fa1416e2ffce9b0db_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_7b9efcab84158389b4a4ea1e24b5601a_Out_0 = _CoverNormalScale;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _NormalStrength_8f42544d1b3ae08092fb1812b8119cfa_Out_2;
            Unity_NormalStrength_float((_PlanarNMn_248bc5b7421d3f828d166902c73ca6c3_XZ_2.xyz), _Property_7b9efcab84158389b4a4ea1e24b5601a_Out_0, _NormalStrength_8f42544d1b3ae08092fb1812b8119cfa_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Lerp_18ca18da5861e688a3fb637172636eda_Out_3;
            Unity_Lerp_float3(_HeightBlend_7c09d97625efce898e21b66cd039be8b_OutVector4_1, _NormalStrength_8f42544d1b3ae08092fb1812b8119cfa_Out_2, (_UseDynamicCoverTStaticMaskF_20dcbac2f16cf78ebd6fd1debcd7f281_Out_0.xxx), _Lerp_18ca18da5861e688a3fb637172636eda_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_afd0f3561038ef8487e614f350d364dd_Out_0 = _BaseMetallic;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_154e0f89b19c8e86926222afb13691e3_Out_2;
            Unity_Multiply_float(_Split_91a015dea8acd38b904ba0935328a5bc_R_1, _Property_afd0f3561038ef8487e614f350d364dd_Out_0, _Multiply_154e0f89b19c8e86926222afb13691e3_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_b82ce26778f44c8fa3510d1a8ed92d0d_Out_0 = _BaseAORemapMin;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_9d07c7a09a85da809f1d4661406e0888_Out_0 = _BaseAORemapMax;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_10162c774de2a7838426399cfe98be82_Out_0 = float2(_Property_b82ce26778f44c8fa3510d1a8ed92d0d_Out_0, _Property_9d07c7a09a85da809f1d4661406e0888_Out_0);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Remap_c45fda31db668c81a9e89e11297ec993_Out_3;
            Unity_Remap_float(_Split_91a015dea8acd38b904ba0935328a5bc_G_2, float2 (0, 1), _Vector2_10162c774de2a7838426399cfe98be82_Out_0, _Remap_c45fda31db668c81a9e89e11297ec993_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_04a7bb2753456b8293b3e46e346b646e_Out_0 = _BaseSmoothnessRemapMin;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_75c8631fc908bb8ba8542d2e70d18cbf_Out_0 = _BaseSmoothnessRemapMax;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_b2e1a3c487cdf88f9b5992b831ba24d6_Out_0 = float2(_Property_04a7bb2753456b8293b3e46e346b646e_Out_0, _Property_75c8631fc908bb8ba8542d2e70d18cbf_Out_0);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Remap_65ca5af95590f88da70777476b6efd40_Out_3;
            Unity_Remap_float(_Split_91a015dea8acd38b904ba0935328a5bc_A_4, float2 (0, 1), _Vector2_b2e1a3c487cdf88f9b5992b831ba24d6_Out_0, _Remap_65ca5af95590f88da70777476b6efd40_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Vector3_28c1e2dadb10138a9799d970043db9b0_Out_0 = float3(_Multiply_154e0f89b19c8e86926222afb13691e3_Out_2, _Remap_c45fda31db668c81a9e89e11297ec993_Out_3, _Remap_65ca5af95590f88da70777476b6efd40_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_4ead43cc6d37b68eb268dd80c3a561e9_Out_0 = _Base2Metallic;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_eef7838a4634498b9cf12d1bee89d853_Out_2;
            Unity_Multiply_float(_Split_83ec66b648ab6c84848b42686c256cd7_R_1, _Property_4ead43cc6d37b68eb268dd80c3a561e9_Out_0, _Multiply_eef7838a4634498b9cf12d1bee89d853_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_e1ed9fe432388887abb17b07dcc5ca6b_Out_0 = _Base2AORemapMin;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_cb0cf7882dcbcf88989a12f73fb7c917_Out_0 = _Base2AORemapMax;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_2d74d82ae79d5681a097c2e3ce20c913_Out_0 = float2(_Property_e1ed9fe432388887abb17b07dcc5ca6b_Out_0, _Property_cb0cf7882dcbcf88989a12f73fb7c917_Out_0);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Remap_dcd2e2871e334281a15cdd1da6103c7f_Out_3;
            Unity_Remap_float(_Split_83ec66b648ab6c84848b42686c256cd7_G_2, float2 (0, 1), _Vector2_2d74d82ae79d5681a097c2e3ce20c913_Out_0, _Remap_dcd2e2871e334281a15cdd1da6103c7f_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_159cd47513de4f85a992da1f43f77c51_Out_0 = _Base2SmoothnessRemapMin;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_b1f3c7061cf84380b1a0ffc2c5f770db_Out_0 = _Base2SmoothnessRemapMax;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_eb0fcc98def54d83abe1cfec60457b78_Out_0 = float2(_Property_159cd47513de4f85a992da1f43f77c51_Out_0, _Property_b1f3c7061cf84380b1a0ffc2c5f770db_Out_0);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Remap_1214803bb0f7c387adc088fb938f7971_Out_3;
            Unity_Remap_float(_Split_83ec66b648ab6c84848b42686c256cd7_A_4, float2 (0, 1), _Vector2_eb0fcc98def54d83abe1cfec60457b78_Out_0, _Remap_1214803bb0f7c387adc088fb938f7971_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Vector3_ddb5452f73a0dc819b57dbe981a5f4e7_Out_0 = float3(_Multiply_eef7838a4634498b9cf12d1bee89d853_Out_2, _Remap_dcd2e2871e334281a15cdd1da6103c7f_Out_3, _Remap_1214803bb0f7c387adc088fb938f7971_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 _HeightBlend_3ef23bc9c463ea8f91d2c1bc27c32dff;
            float3 _HeightBlend_3ef23bc9c463ea8f91d2c1bc27c32dff_OutVector4_1;
            SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135(_Vector3_28c1e2dadb10138a9799d970043db9b0_Out_0, _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3, _Vector3_ddb5452f73a0dc819b57dbe981a5f4e7_Out_0, _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2, _Property_818c8af4b930138e81034c886614171d_Out_0, _HeightBlend_3ef23bc9c463ea8f91d2c1bc27c32dff, _HeightBlend_3ef23bc9c463ea8f91d2c1bc27c32dff_OutVector4_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_6dbb3498614f2088a1315529ed864ea3_Out_0 = _CoverMetallic;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_7a0f3f362f18fd86b9191e28255508f8_Out_2;
            Unity_Multiply_float(_Split_86ec1aefda4f9e8e82b79c6195b397b0_R_1, _Property_6dbb3498614f2088a1315529ed864ea3_Out_0, _Multiply_7a0f3f362f18fd86b9191e28255508f8_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_840e5ecb6a2ddb83abffd7be403ecd68_Out_0 = _CoverAORemapMin;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_92176ee70059d28abbfcad689b580f1a_Out_0 = _CoverAORemapMax;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_2b0ddb771cc86988a6f70ca3c4d0145b_Out_0 = float2(_Property_840e5ecb6a2ddb83abffd7be403ecd68_Out_0, _Property_92176ee70059d28abbfcad689b580f1a_Out_0);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Remap_1091f204ac00858d804a3785be14a17e_Out_3;
            Unity_Remap_float(_Split_86ec1aefda4f9e8e82b79c6195b397b0_G_2, float2 (0, 1), _Vector2_2b0ddb771cc86988a6f70ca3c4d0145b_Out_0, _Remap_1091f204ac00858d804a3785be14a17e_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_4cd4964a0372a3858a89e499b8d810a1_Out_0 = _CoverSmoothnessRemapMin;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_f7e67cf191e5c38388370531311427cf_Out_0 = _CoverSmoothnessRemapMax;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_60ae45a9f680358085440c61ca0118da_Out_0 = float2(_Property_4cd4964a0372a3858a89e499b8d810a1_Out_0, _Property_f7e67cf191e5c38388370531311427cf_Out_0);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Remap_e88a1283399b2187be29c818a3fc3543_Out_3;
            Unity_Remap_float(_Split_86ec1aefda4f9e8e82b79c6195b397b0_A_4, float2 (0, 1), _Vector2_60ae45a9f680358085440c61ca0118da_Out_0, _Remap_e88a1283399b2187be29c818a3fc3543_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Vector3_83d0f92fd33a1d8799fdafb5ae407cb7_Out_0 = float3(_Multiply_7a0f3f362f18fd86b9191e28255508f8_Out_2, _Remap_1091f204ac00858d804a3785be14a17e_Out_3, _Remap_e88a1283399b2187be29c818a3fc3543_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Lerp_afcfe197cbc3818eb5aaaa1cf503c7d4_Out_3;
            Unity_Lerp_float3(_HeightBlend_3ef23bc9c463ea8f91d2c1bc27c32dff_OutVector4_1, _Vector3_83d0f92fd33a1d8799fdafb5ae407cb7_Out_0, (_UseDynamicCoverTStaticMaskF_20dcbac2f16cf78ebd6fd1debcd7f281_Out_0.xxx), _Lerp_afcfe197cbc3818eb5aaaa1cf503c7d4_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_93a6a2f8a95a1b80bea53b3c9628de7b_R_1 = _Lerp_afcfe197cbc3818eb5aaaa1cf503c7d4_Out_3[0];
            float _Split_93a6a2f8a95a1b80bea53b3c9628de7b_G_2 = _Lerp_afcfe197cbc3818eb5aaaa1cf503c7d4_Out_3[1];
            float _Split_93a6a2f8a95a1b80bea53b3c9628de7b_B_3 = _Lerp_afcfe197cbc3818eb5aaaa1cf503c7d4_Out_3[2];
            float _Split_93a6a2f8a95a1b80bea53b3c9628de7b_A_4 = 0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_c7a719bf7da79a8ea38d7311fd844f92_R_1 = _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2[0];
            float _Split_c7a719bf7da79a8ea38d7311fd844f92_G_2 = _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2[1];
            float _Split_c7a719bf7da79a8ea38d7311fd844f92_B_3 = _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2[2];
            float _Split_c7a719bf7da79a8ea38d7311fd844f92_A_4 = _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_7c5dae9b46c9e686b49e58fa996a104a_Out_0 = IgnoreBase2Alpha;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_e9060f5c0433ec889696d3e462f3229b_R_1 = _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2[0];
            float _Split_e9060f5c0433ec889696d3e462f3229b_G_2 = _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2[1];
            float _Split_e9060f5c0433ec889696d3e462f3229b_B_3 = _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2[2];
            float _Split_e9060f5c0433ec889696d3e462f3229b_A_4 = _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Branch_a7d7aece30fd9b8eb456d191fdd37a06_Out_3;
            Unity_Branch_float(_Property_7c5dae9b46c9e686b49e58fa996a104a_Out_0, _Split_c7a719bf7da79a8ea38d7311fd844f92_A_4, _Split_e9060f5c0433ec889696d3e462f3229b_A_4, _Branch_a7d7aece30fd9b8eb456d191fdd37a06_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Lerp_8692ca93f568998fbc97130b6dbc4556_Out_3;
            Unity_Lerp_float(_Split_c7a719bf7da79a8ea38d7311fd844f92_A_4, _Branch_a7d7aece30fd9b8eb456d191fdd37a06_Out_3, _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2, _Lerp_8692ca93f568998fbc97130b6dbc4556_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_0c8b7b55b9f82588ab2dcff09ee7a16d_Out_3;
            Unity_Clamp_float(_Lerp_8692ca93f568998fbc97130b6dbc4556_Out_3, 0, 1, _Clamp_0c8b7b55b9f82588ab2dcff09ee7a16d_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_6333dc4a6348088bb7281602ce6bff5f_Out_2;
            Unity_Multiply_float(_Clamp_0c8b7b55b9f82588ab2dcff09ee7a16d_Out_3, _Split_c34b73d933404283983f9c8bdb5365d3_A_4, _Multiply_6333dc4a6348088bb7281602ce6bff5f_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_9642b8fb7e32b18a91da1888c9bc375b_Out_3;
            Unity_Clamp_float(_Multiply_6333dc4a6348088bb7281602ce6bff5f_Out_2, 0, 1, _Clamp_9642b8fb7e32b18a91da1888c9bc375b_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_8bc98dd454a5508b9864a6ba09772356_Out_0 = _AlphaCutoff;
            #endif
            surface.BaseColor = _Lerp_e5620b57c917728fa1416e2ffce9b0db_Out_3;
            surface.NormalTS = _Lerp_18ca18da5861e688a3fb637172636eda_Out_3;
            surface.Emission = float3(0, 0, 0);
            surface.Metallic = _Split_93a6a2f8a95a1b80bea53b3c9628de7b_R_1;
            surface.Smoothness = _Split_93a6a2f8a95a1b80bea53b3c9628de7b_B_3;
            surface.Occlusion = _Split_93a6a2f8a95a1b80bea53b3c9628de7b_G_2;
            surface.Alpha = _Clamp_9642b8fb7e32b18a91da1888c9bc375b_Out_3;
            surface.AlphaClipThreshold = _Property_8bc98dd454a5508b9864a6ba09772356_Out_0;
            return surface;
        }

            // --------------------------------------------------
            // Build Graph Inputs

            VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceNormal =           input.normalOS;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceTangent =          input.tangentOS.xyz;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpacePosition =         input.positionOS;
        #endif


            return output;
        }
            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 unnormalizedNormalWS = input.normalWS;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        const float renormFactor = 1.0 / length(unnormalizedNormalWS);
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // use bitangent on the fly like in hdrp
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // IMPORTANT! If we ever support Flip on double sided materials ensure bitangent and tangent are NOT flipped.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float crossSign = (input.tangentWS.w > 0.0 ? 1.0 : -1.0) * GetOddNegativeScale();
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 bitang = crossSign * cross(input.normalWS.xyz, input.tangentWS.xyz);
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceNormal =            renormFactor*input.normalWS.xyz;		// we want a unit length Normal Vector node in shader graph
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // to preserve mikktspace compliance we use same scale renormFactor as was used on the normal.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // This is explained in section 2.2 in "surface gradient based bump mapping framework"
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceTangent =           renormFactor*input.tangentWS.xyz;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceBiTangent =         renormFactor*bitang;
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(input.positionWS);
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.uv0 =                         input.texCoord0;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.VertexColor =                 input.color;
        #endif

        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

            return output;
        }

            // --------------------------------------------------
            // Main

            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/PBRForwardPass.hlsl"

            ENDHLSL
        }
        Pass
        {
            Name "GBuffer"
            Tags
            {
                "LightMode" = "UniversalGBuffer"
            }

            // Render State
            Cull Back
        Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
        ZTest LEqual
       ZWrite On

            // Debug
            // <None>

            // --------------------------------------------------
            // Pass

            HLSLPROGRAM

            // Pragmas
            #pragma target 4.5
        #pragma exclude_renderers gles gles3 glcore
        #pragma multi_compile_instancing
        #pragma multi_compile_fog
        #pragma multi_compile _ DOTS_INSTANCING_ON
        #pragma vertex vert
        #pragma fragment frag

            // DotsInstancingOptions: <None>
            // HybridV1InjectedBuiltinProperties: <None>

            // Keywords
            #pragma multi_compile _ LIGHTMAP_ON
        #pragma multi_compile _ DIRLIGHTMAP_COMBINED
        #pragma multi_compile _ _MAIN_LIGHT_SHADOWS
        #pragma multi_compile _ _MAIN_LIGHT_SHADOWS_CASCADE
        #pragma multi_compile _ _SHADOWS_SOFT
        #pragma multi_compile _ _MIXED_LIGHTING_SUBTRACTIVE
        #pragma multi_compile _ _GBUFFER_NORMALS_OCT
            #pragma shader_feature_local _ _USEDYNAMICCOVERTSTATICMASKF_ON

        #if defined(_USEDYNAMICCOVERTSTATICMASKF_ON)
            #define KEYWORD_PERMUTATION_0
        #else
            #define KEYWORD_PERMUTATION_1
        #endif


            // Defines
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _SURFACE_TYPE_TRANSPARENT 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _AlphaClip 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMALMAP 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMAL_DROPOFF_TS 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_NORMAL
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TANGENT
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TEXCOORD0
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TEXCOORD1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_COLOR
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_POSITION_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_NORMAL_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TANGENT_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TEXCOORD0
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_COLOR
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_VIEWDIRECTION_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
        #endif

            #define FEATURES_GRAPH_VERTEX
            /* WARNING: $splice Could not find named fragment 'PassInstancing' */
            #define SHADERPASS SHADERPASS_GBUFFER
            /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */

            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

            // --------------------------------------------------
            // Structs and Packing

            struct Attributes
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 positionOS : POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 normalOS : NORMAL;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 tangentOS : TANGENT;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 uv0 : TEXCOORD0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 uv1 : TEXCOORD1;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 color : COLOR;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : INSTANCEID_SEMANTIC;
            #endif
            #endif
        };
        struct Varyings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 positionWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 normalWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 tangentWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 texCoord0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 color;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 viewDirectionWS;
            #endif
            #if defined(LIGHTMAP_ON)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 lightmapUV;
            #endif
            #endif
            #if !defined(LIGHTMAP_ON)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 sh;
            #endif
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 fogFactorAndVertexLight;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 shadowCoord;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };
        struct SurfaceDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 TangentSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceBiTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 AbsoluteWorldSpacePosition;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 uv0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 VertexColor;
            #endif
        };
        struct VertexDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpacePosition;
            #endif
        };
        struct PackedVaryings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp0 : TEXCOORD0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp1 : TEXCOORD1;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 interp2 : TEXCOORD2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 interp3 : TEXCOORD3;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 interp4 : TEXCOORD4;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp5 : TEXCOORD5;
            #endif
            #if defined(LIGHTMAP_ON)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 interp6 : TEXCOORD6;
            #endif
            #endif
            #if !defined(LIGHTMAP_ON)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp7 : TEXCOORD7;
            #endif
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 interp8 : TEXCOORD8;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 interp9 : TEXCOORD9;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };

            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            output.positionCS = input.positionCS;
            output.interp0.xyz =  input.positionWS;
            output.interp1.xyz =  input.normalWS;
            output.interp2.xyzw =  input.tangentWS;
            output.interp3.xyzw =  input.texCoord0;
            output.interp4.xyzw =  input.color;
            output.interp5.xyz =  input.viewDirectionWS;
            #if defined(LIGHTMAP_ON)
            output.interp6.xy =  input.lightmapUV;
            #endif
            #if !defined(LIGHTMAP_ON)
            output.interp7.xyz =  input.sh;
            #endif
            output.interp8.xyzw =  input.fogFactorAndVertexLight;
            output.interp9.xyzw =  input.shadowCoord;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.positionWS = input.interp0.xyz;
            output.normalWS = input.interp1.xyz;
            output.tangentWS = input.interp2.xyzw;
            output.texCoord0 = input.interp3.xyzw;
            output.color = input.interp4.xyzw;
            output.viewDirectionWS = input.interp5.xyz;
            #if defined(LIGHTMAP_ON)
            output.lightmapUV = input.interp6.xy;
            #endif
            #if !defined(LIGHTMAP_ON)
            output.sh = input.interp7.xyz;
            #endif
            output.fogFactorAndVertexLight = input.interp8.xyzw;
            output.shadowCoord = input.interp9.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        #endif

            // --------------------------------------------------
            // Graph

            // Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float _AlphaCutoff;
        float4 _BaseColor;
        float4 _BaseColorMap_TexelSize;
        float _BaseUsePlanarUV;
        float4 _BaseTilingOffset;
        float4 _BaseNormalMap_TexelSize;
        float _BaseNormalScale;
        float4 _BaseMaskMap_TexelSize;
        float _BaseMetallic;
        float _BaseAORemapMin;
        float _BaseAORemapMax;
        float _BaseSmoothnessRemapMin;
        float _BaseSmoothnessRemapMax;
        float4 _LayerMask_TexelSize;
        float _Invert_Layer_Mask;
        float _Height_Transition;
        float _HeightMin;
        float _HeightMax;
        float _HeightOffset;
        float _HeightMin2;
        float _HeightMax2;
        float _HeightOffset2;
        float IgnoreBase2Alpha;
        float4 _Base2Color;
        float4 _Base2ColorMap_TexelSize;
        float4 _Base2TilingOffset;
        float _Base2UsePlanarUV;
        float4 _Base2NormalMap_TexelSize;
        float _Base2NormalScale;
        float4 _Base2MaskMap_TexelSize;
        float _Base2Metallic;
        float _Base2SmoothnessRemapMin;
        float _Base2SmoothnessRemapMax;
        float _Base2AORemapMin;
        float _Base2AORemapMax;
        float4 _CoverMaskA_TexelSize;
        float _CoverMaskPower;
        float _Cover_Amount;
        float _Cover_Amount_Grow_Speed;
        float _Cover_Max_Angle;
        float _Cover_Min_Height;
        float _Cover_Min_Height_Blending;
        float4 _CoverBaseColor;
        float4 _CoverBaseColorMap_TexelSize;
        float4 _CoverTilingOffset;
        float _CoverUsePlanarUV;
        float4 _CoverNormalMap_TexelSize;
        float _CoverNormalScale;
        float _CoverNormalBlendHardness;
        float _CoverHardness;
        float _CoverHeightMapMin;
        float _CoverHeightMapMax;
        float _CoverHeightMapOffset;
        float4 _CoverMaskMap_TexelSize;
        float _CoverMetallic;
        float _CoverAORemapMin;
        float _CoverAORemapMax;
        float _CoverSmoothnessRemapMin;
        float _CoverSmoothnessRemapMax;
        CBUFFER_END

        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_BaseColorMap);
        SAMPLER(sampler_BaseColorMap);
        TEXTURE2D(_BaseNormalMap);
        SAMPLER(sampler_BaseNormalMap);
        TEXTURE2D(_BaseMaskMap);
        SAMPLER(sampler_BaseMaskMap);
        TEXTURE2D(_LayerMask);
        SAMPLER(sampler_LayerMask);
        TEXTURE2D(_Base2ColorMap);
        SAMPLER(sampler_Base2ColorMap);
        TEXTURE2D(_Base2NormalMap);
        SAMPLER(sampler_Base2NormalMap);
        TEXTURE2D(_Base2MaskMap);
        SAMPLER(sampler_Base2MaskMap);
        TEXTURE2D(_CoverMaskA);
        SAMPLER(sampler_CoverMaskA);
        TEXTURE2D(_CoverBaseColorMap);
        SAMPLER(sampler_CoverBaseColorMap);
        TEXTURE2D(_CoverNormalMap);
        SAMPLER(sampler_CoverNormalMap);
        TEXTURE2D(_CoverMaskMap);
        SAMPLER(sampler_CoverMaskMap);

            // Graph Functions
            
        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }

        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }

        void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }

        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }

        void Unity_Branch_float2(float Predicate, float2 True, float2 False, out float2 Out)
        {
            Out = Predicate ? True : False;
        }

        struct Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6
        {
            float3 AbsoluteWorldSpacePosition;
            half4 uv0;
        };

        void SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(UnityTexture2D Texture2D_80A3D28F, float4 Vector4_2EBA7A3B, float Boolean_7ABB9909, Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 IN, out float4 XZ_2)
        {
            UnityTexture2D _Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0 = Texture2D_80A3D28F;
            float _Property_30834f691775a0898a45b1c868520436_Out_0 = Boolean_7ABB9909;
            float _Split_89ed63cb625cb3878c183d0b71c03400_R_1 = IN.AbsoluteWorldSpacePosition[0];
            float _Split_89ed63cb625cb3878c183d0b71c03400_G_2 = IN.AbsoluteWorldSpacePosition[1];
            float _Split_89ed63cb625cb3878c183d0b71c03400_B_3 = IN.AbsoluteWorldSpacePosition[2];
            float _Split_89ed63cb625cb3878c183d0b71c03400_A_4 = 0;
            float4 _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4;
            float3 _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5;
            float2 _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6;
            Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_B_3, 0, 0, _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5, _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6);
            float4 _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0 = Vector4_2EBA7A3B;
            float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[0];
            float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_G_2 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[1];
            float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_B_3 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[2];
            float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_A_4 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[3];
            float _Divide_e64179199923c58289b6aa94ea6c9178_Out_2;
            Unity_Divide_float(1, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1, _Divide_e64179199923c58289b6aa94ea6c9178_Out_2);
            float4 _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2;
            Unity_Multiply_float(_Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, (_Divide_e64179199923c58289b6aa94ea6c9178_Out_2.xxxx), _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2);
            float2 _Vector2_16c15d3bbdd14b85bd48e3a6cb318af7_Out_0 = float2(_Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_G_2);
            float2 _Vector2_f8d75f54e7705083bbec539a60185577_Out_0 = float2(_Split_2f0f52f6ef8c0e81af0da6476402bc1f_B_3, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_A_4);
            float2 _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_16c15d3bbdd14b85bd48e3a6cb318af7_Out_0, _Vector2_f8d75f54e7705083bbec539a60185577_Out_0, _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3);
            float2 _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3;
            Unity_Branch_float2(_Property_30834f691775a0898a45b1c868520436_Out_0, (_Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2.xy), _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3, _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3);
            float4 _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0 = SAMPLE_TEXTURE2D(_Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0.tex, _Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0.samplerstate, _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3);
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.r;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.g;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.b;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_A_7 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.a;
            XZ_2 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0;
        }

        void Unity_Add_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A + B;
        }

        void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
        {
            Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
        }

        void Unity_OneMinus_float(float In, out float Out)
        {
            Out = 1 - In;
        }

        void Unity_Branch_float(float Predicate, float True, float False, out float Out)
        {
            Out = Predicate ? True : False;
        }

        void Unity_Multiply_float(float A, float B, out float Out)
        {
            Out = A * B;
        }

        void Unity_Maximum_float(float A, float B, out float Out)
        {
            Out = max(A, B);
        }

        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }

        void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }

        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }

        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }

        void Unity_Divide_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A / B;
        }

        struct Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135
        {
        };

        void SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135(float3 Vector3_88EEBB5E, float Vector1_DA0A37FA, float3 Vector3_79AA92F, float Vector1_F7E83F1E, float Vector1_1C9222A6, Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 IN, out float3 OutVector4_1)
        {
            float3 _Property_dd1c841a04c03f8c85e7b00eb025ecda_Out_0 = Vector3_88EEBB5E;
            float _Property_14119cc7eaf4128f991283d47cf72d85_Out_0 = Vector1_DA0A37FA;
            float _Property_48af0ad45e3f7f82932b938695d21391_Out_0 = Vector1_DA0A37FA;
            float _Property_8a30b3ca12ff518fa473ccd686c7d503_Out_0 = Vector1_F7E83F1E;
            float _Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2;
            Unity_Maximum_float(_Property_48af0ad45e3f7f82932b938695d21391_Out_0, _Property_8a30b3ca12ff518fa473ccd686c7d503_Out_0, _Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2);
            float _Property_ee8d5fc69475d181be60c57e04ea8708_Out_0 = Vector1_1C9222A6;
            float _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2;
            Unity_Subtract_float(_Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2, _Property_ee8d5fc69475d181be60c57e04ea8708_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2);
            float _Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2;
            Unity_Subtract_float(_Property_14119cc7eaf4128f991283d47cf72d85_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2, _Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2);
            float _Maximum_d02e48d92038448cb0345e5cf3779071_Out_2;
            Unity_Maximum_float(_Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2, 0, _Maximum_d02e48d92038448cb0345e5cf3779071_Out_2);
            float3 _Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2;
            Unity_Multiply_float(_Property_dd1c841a04c03f8c85e7b00eb025ecda_Out_0, (_Maximum_d02e48d92038448cb0345e5cf3779071_Out_2.xxx), _Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2);
            float3 _Property_c7292b3b08585f8c8670172b9a220bf0_Out_0 = Vector3_79AA92F;
            float _Property_5e920479576fad83ba1947728dcceab4_Out_0 = Vector1_F7E83F1E;
            float _Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2;
            Unity_Subtract_float(_Property_5e920479576fad83ba1947728dcceab4_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2, _Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2);
            float _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2;
            Unity_Maximum_float(_Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2, 0, _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2);
            float3 _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2;
            Unity_Multiply_float(_Property_c7292b3b08585f8c8670172b9a220bf0_Out_0, (_Maximum_216777d30802328eab607c8fe68ba3a1_Out_2.xxx), _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2);
            float3 _Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2;
            Unity_Add_float3(_Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2, _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2, _Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2);
            float _Add_356384b52728f583bd6e694bc1fc3738_Out_2;
            Unity_Add_float(_Maximum_d02e48d92038448cb0345e5cf3779071_Out_2, _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2, _Add_356384b52728f583bd6e694bc1fc3738_Out_2);
            float _Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2;
            Unity_Maximum_float(_Add_356384b52728f583bd6e694bc1fc3738_Out_2, 1E-05, _Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2);
            float3 _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2;
            Unity_Divide_float3(_Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2, (_Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2.xxx), _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2);
            OutVector4_1 = _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2;
        }

        void Unity_Clamp_float(float In, float Min, float Max, out float Out)
        {
            Out = clamp(In, Min, Max);
        }

        void Unity_Sign_float3(float3 In, out float3 Out)
        {
            Out = sign(In);
        }

        void Unity_Multiply_float(float2 A, float2 B, out float2 Out)
        {
            Out = A * B;
        }

        void Unity_Normalize_float3(float3 In, out float3 Out)
        {
            Out = normalize(In);
        }

        void Unity_Branch_float3(float Predicate, float3 True, float3 False, out float3 Out)
        {
            Out = Predicate ? True : False;
        }

        struct Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8
        {
            float3 WorldSpaceNormal;
            float3 WorldSpaceTangent;
            float3 WorldSpaceBiTangent;
            float3 AbsoluteWorldSpacePosition;
            half4 uv0;
        };

        void SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(UnityTexture2D Texture2D_80A3D28F, float4 Vector4_82674548, float Boolean_9FF42DF6, Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 IN, out float4 XZ_2)
        {
            float _Property_1ef12cf3201a938993fe6a7951b0e754_Out_0 = Boolean_9FF42DF6;
            UnityTexture2D _Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0 = Texture2D_80A3D28F;
            float _Split_89ed63cb625cb3878c183d0b71c03400_R_1 = IN.AbsoluteWorldSpacePosition[0];
            float _Split_89ed63cb625cb3878c183d0b71c03400_G_2 = IN.AbsoluteWorldSpacePosition[1];
            float _Split_89ed63cb625cb3878c183d0b71c03400_B_3 = IN.AbsoluteWorldSpacePosition[2];
            float _Split_89ed63cb625cb3878c183d0b71c03400_A_4 = 0;
            float4 _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4;
            float3 _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5;
            float2 _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6;
            Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_B_3, 0, 0, _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5, _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6);
            float4 _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0 = Vector4_82674548;
            float _Split_a2e12fa5931da084b2949343a539dfd8_R_1 = _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0[0];
            float _Split_a2e12fa5931da084b2949343a539dfd8_G_2 = _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0[1];
            float _Split_a2e12fa5931da084b2949343a539dfd8_B_3 = _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0[2];
            float _Split_a2e12fa5931da084b2949343a539dfd8_A_4 = _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0[3];
            float _Divide_c36b770dfaa0bb8f85ab27da5fd794f0_Out_2;
            Unity_Divide_float(1, _Split_a2e12fa5931da084b2949343a539dfd8_R_1, _Divide_c36b770dfaa0bb8f85ab27da5fd794f0_Out_2);
            float4 _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2;
            Unity_Multiply_float(_Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, (_Divide_c36b770dfaa0bb8f85ab27da5fd794f0_Out_2.xxxx), _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2);
            float2 _Vector2_6845d21872714d889783b0cb707df3e9_Out_0 = float2(_Split_a2e12fa5931da084b2949343a539dfd8_R_1, _Split_a2e12fa5931da084b2949343a539dfd8_G_2);
            float2 _Vector2_e2e2263627c6098e96a5b5d29350ad03_Out_0 = float2(_Split_a2e12fa5931da084b2949343a539dfd8_B_3, _Split_a2e12fa5931da084b2949343a539dfd8_A_4);
            float2 _TilingAndOffset_17582d056c0b8a8dab1017d37497fe59_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_6845d21872714d889783b0cb707df3e9_Out_0, _Vector2_e2e2263627c6098e96a5b5d29350ad03_Out_0, _TilingAndOffset_17582d056c0b8a8dab1017d37497fe59_Out_3);
            float2 _Branch_1e152f3aac57448f8518bf2852c000c3_Out_3;
            Unity_Branch_float2(_Property_1ef12cf3201a938993fe6a7951b0e754_Out_0, (_Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2.xy), _TilingAndOffset_17582d056c0b8a8dab1017d37497fe59_Out_3, _Branch_1e152f3aac57448f8518bf2852c000c3_Out_3);
            float4 _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0 = SAMPLE_TEXTURE2D(_Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0.tex, _Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0.samplerstate, _Branch_1e152f3aac57448f8518bf2852c000c3_Out_3);
            _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0);
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.r;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.g;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.b;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_A_7 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.a;
            float2 _Vector2_ad6bd100e273d78fa409a30a77bfa2cc_Out_0 = float2(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4, _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5);
            float3 _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1;
            Unity_Sign_float3(IN.WorldSpaceNormal, _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1);
            float _Split_6299d4ddcc4c74828aea40a46fdb896e_R_1 = _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1[0];
            float _Split_6299d4ddcc4c74828aea40a46fdb896e_G_2 = _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1[1];
            float _Split_6299d4ddcc4c74828aea40a46fdb896e_B_3 = _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1[2];
            float _Split_6299d4ddcc4c74828aea40a46fdb896e_A_4 = 0;
            float2 _Vector2_b76cb1842101e58b9e636d49b075c612_Out_0 = float2(_Split_6299d4ddcc4c74828aea40a46fdb896e_G_2, 1);
            float2 _Multiply_31e8db88ee20c985a9850d1a58f3282b_Out_2;
            Unity_Multiply_float(_Vector2_ad6bd100e273d78fa409a30a77bfa2cc_Out_0, _Vector2_b76cb1842101e58b9e636d49b075c612_Out_0, _Multiply_31e8db88ee20c985a9850d1a58f3282b_Out_2);
            float _Split_5ed44bf2eca0868f81eb18100f49d1fa_R_1 = IN.WorldSpaceNormal[0];
            float _Split_5ed44bf2eca0868f81eb18100f49d1fa_G_2 = IN.WorldSpaceNormal[1];
            float _Split_5ed44bf2eca0868f81eb18100f49d1fa_B_3 = IN.WorldSpaceNormal[2];
            float _Split_5ed44bf2eca0868f81eb18100f49d1fa_A_4 = 0;
            float2 _Vector2_70e5837843f28b8b9d64cada3697bd5a_Out_0 = float2(_Split_5ed44bf2eca0868f81eb18100f49d1fa_R_1, _Split_5ed44bf2eca0868f81eb18100f49d1fa_B_3);
            float2 _Add_1145b2f896593d80aa864a34e6702562_Out_2;
            Unity_Add_float2(_Multiply_31e8db88ee20c985a9850d1a58f3282b_Out_2, _Vector2_70e5837843f28b8b9d64cada3697bd5a_Out_0, _Add_1145b2f896593d80aa864a34e6702562_Out_2);
            float _Split_2bc77ca2d17bd78cb2383770ce50b179_R_1 = _Add_1145b2f896593d80aa864a34e6702562_Out_2[0];
            float _Split_2bc77ca2d17bd78cb2383770ce50b179_G_2 = _Add_1145b2f896593d80aa864a34e6702562_Out_2[1];
            float _Split_2bc77ca2d17bd78cb2383770ce50b179_B_3 = 0;
            float _Split_2bc77ca2d17bd78cb2383770ce50b179_A_4 = 0;
            float _Multiply_ab12aea87465a78eaf7fc66c2598d266_Out_2;
            Unity_Multiply_float(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6, _Split_5ed44bf2eca0868f81eb18100f49d1fa_G_2, _Multiply_ab12aea87465a78eaf7fc66c2598d266_Out_2);
            float3 _Vector3_433840b555db308b97e9b14b6a957195_Out_0 = float3(_Split_2bc77ca2d17bd78cb2383770ce50b179_R_1, _Multiply_ab12aea87465a78eaf7fc66c2598d266_Out_2, _Split_2bc77ca2d17bd78cb2383770ce50b179_G_2);
            float3x3 Transform_c7914cc45a011c89b3f53c55afb51673_tangentTransform_World = float3x3(IN.WorldSpaceTangent, IN.WorldSpaceBiTangent, IN.WorldSpaceNormal);
            float3 _Transform_c7914cc45a011c89b3f53c55afb51673_Out_1 = TransformWorldToTangent(_Vector3_433840b555db308b97e9b14b6a957195_Out_0.xyz, Transform_c7914cc45a011c89b3f53c55afb51673_tangentTransform_World);
            float3 _Normalize_09bf8a2bd0a4d38e8b97d5c674f79b44_Out_1;
            Unity_Normalize_float3(_Transform_c7914cc45a011c89b3f53c55afb51673_Out_1, _Normalize_09bf8a2bd0a4d38e8b97d5c674f79b44_Out_1);
            float3 _Branch_9eadf909a90f2f80880f8c56ecc2a91f_Out_3;
            Unity_Branch_float3(_Property_1ef12cf3201a938993fe6a7951b0e754_Out_0, _Normalize_09bf8a2bd0a4d38e8b97d5c674f79b44_Out_1, (_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.xyz), _Branch_9eadf909a90f2f80880f8c56ecc2a91f_Out_3);
            XZ_2 = (float4(_Branch_9eadf909a90f2f80880f8c56ecc2a91f_Out_3, 1.0));
        }

        void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
        {
            Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
        }

        void Unity_Absolute_float(float In, out float Out)
        {
            Out = abs(In);
        }

        void Unity_Power_float(float A, float B, out float Out)
        {
            Out = pow(A, B);
        }

        void Unity_Saturate_float(float In, out float Out)
        {
            Out = saturate(In);
        }

        void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
        {
            Out = lerp(A, B, T);
        }

        void Unity_Lerp_float(float A, float B, float T, out float Out)
        {
            Out = lerp(A, B, T);
        }

            // Graph Vertex
            struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };

        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }

            // Graph Pixel
            struct SurfaceDescription
        {
            float3 BaseColor;
            float3 NormalTS;
            float3 Emission;
            float Metallic;
            float Smoothness;
            float Occlusion;
            float Alpha;
            float AlphaClipThreshold;
        };

        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_07d75b1d2628da808a2efb93a1d6219e_Out_0 = UnityBuildTexture2DStructNoScale(_BaseColorMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0 = _BaseTilingOffset;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_7f998178363b4188ba2f07298ef869c1_Out_0 = _BaseUsePlanarUV;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e;
            _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e.uv0 = IN.uv0;
            float4 _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2;
            SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(_Property_07d75b1d2628da808a2efb93a1d6219e_Out_0, _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0, _Property_7f998178363b4188ba2f07298ef869c1_Out_0, _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e, _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_b83097c58639858680bf43881a95b0af_Out_0 = _BaseColor;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2;
            Unity_Multiply_float(_PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2, _Property_b83097c58639858680bf43881a95b0af_Out_0, _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_1e449ff9f8e8ec828507233e8240eb11_Out_0 = UnityBuildTexture2DStructNoScale(_BaseMaskMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_4245c3b264047180b5c90a697d6cb278;
            _PlanarNM_4245c3b264047180b5c90a697d6cb278.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNM_4245c3b264047180b5c90a697d6cb278.uv0 = IN.uv0;
            float4 _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2;
            SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(_Property_1e449ff9f8e8ec828507233e8240eb11_Out_0, _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0, _Property_7f998178363b4188ba2f07298ef869c1_Out_0, _PlanarNM_4245c3b264047180b5c90a697d6cb278, _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_91a015dea8acd38b904ba0935328a5bc_R_1 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[0];
            float _Split_91a015dea8acd38b904ba0935328a5bc_G_2 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[1];
            float _Split_91a015dea8acd38b904ba0935328a5bc_B_3 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[2];
            float _Split_91a015dea8acd38b904ba0935328a5bc_A_4 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_fbcff1469ebf488394a8a89ddaf0eb2a_Out_0 = _HeightMin;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_9df7a44c8225168683743ac60c0c3c34_Out_0 = _HeightMax;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_9b1e95888c28bc8893f28c02b87fa448_Out_0 = float2(_Property_fbcff1469ebf488394a8a89ddaf0eb2a_Out_0, _Property_9df7a44c8225168683743ac60c0c3c34_Out_0);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_29ca14fd0b712983a38d63d2dd326e96_Out_0 = _HeightOffset;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Add_cb503f8a09720d84bb03cbd89e37b80c_Out_2;
            Unity_Add_float2(_Vector2_9b1e95888c28bc8893f28c02b87fa448_Out_0, (_Property_29ca14fd0b712983a38d63d2dd326e96_Out_0.xx), _Add_cb503f8a09720d84bb03cbd89e37b80c_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3;
            Unity_Remap_float(_Split_91a015dea8acd38b904ba0935328a5bc_B_3, float2 (0, 1), _Add_cb503f8a09720d84bb03cbd89e37b80c_Out_2, _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_ba3a5f4cba7d0a8fa288ffc8267d6c0e_Out_0 = UnityBuildTexture2DStructNoScale(_Base2ColorMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_86a4657df480d48e8d3ad3b036731380_Out_0 = _Base2TilingOffset;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0 = _Base2UsePlanarUV;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4;
            _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4.uv0 = IN.uv0;
            float4 _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4_XZ_2;
            SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(_Property_ba3a5f4cba7d0a8fa288ffc8267d6c0e_Out_0, _Property_86a4657df480d48e8d3ad3b036731380_Out_0, _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0, _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4, _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_3561b11b899bda8e855826445cf628aa_Out_0 = _Base2Color;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2;
            Unity_Multiply_float(_PlanarNM_5aeab444ca6fd78ea56a01215880a5a4_XZ_2, _Property_3561b11b899bda8e855826445cf628aa_Out_0, _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_c34b73d933404283983f9c8bdb5365d3_R_1 = IN.VertexColor[0];
            float _Split_c34b73d933404283983f9c8bdb5365d3_G_2 = IN.VertexColor[1];
            float _Split_c34b73d933404283983f9c8bdb5365d3_B_3 = IN.VertexColor[2];
            float _Split_c34b73d933404283983f9c8bdb5365d3_A_4 = IN.VertexColor[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_df2df7bb5cfc3381beee7ec454da7542_Out_0 = _Invert_Layer_Mask;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_c7b1e2df9f9b0e8eace9b2274924e69c_Out_0 = UnityBuildTexture2DStructNoScale(_LayerMask);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0 = SAMPLE_TEXTURE2D(_Property_c7b1e2df9f9b0e8eace9b2274924e69c_Out_0.tex, _Property_c7b1e2df9f9b0e8eace9b2274924e69c_Out_0.samplerstate, IN.uv0.xy);
            float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.r;
            float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_G_5 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.g;
            float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_B_6 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.b;
            float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_A_7 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1;
            Unity_OneMinus_float(_SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4, _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Branch_af0c5e511241ce8eae748ae487df50fa_Out_3;
            Unity_Branch_float(_Property_df2df7bb5cfc3381beee7ec454da7542_Out_0, _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1, _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4, _Branch_af0c5e511241ce8eae748ae487df50fa_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_de4f6eb48a629285a664dad7fb06438f_Out_0 = UnityBuildTexture2DStructNoScale(_Base2MaskMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_d5657f470f05ef839e4c257a20ace8cb;
            _PlanarNM_d5657f470f05ef839e4c257a20ace8cb.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNM_d5657f470f05ef839e4c257a20ace8cb.uv0 = IN.uv0;
            float4 _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2;
            SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(_Property_de4f6eb48a629285a664dad7fb06438f_Out_0, _Property_86a4657df480d48e8d3ad3b036731380_Out_0, _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0, _PlanarNM_d5657f470f05ef839e4c257a20ace8cb, _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_83ec66b648ab6c84848b42686c256cd7_R_1 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[0];
            float _Split_83ec66b648ab6c84848b42686c256cd7_G_2 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[1];
            float _Split_83ec66b648ab6c84848b42686c256cd7_B_3 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[2];
            float _Split_83ec66b648ab6c84848b42686c256cd7_A_4 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_ce1750e5c69e97818667b412fc3f9f2c_Out_0 = _HeightMin2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_8e0f2ea54d8ede89bbabdf31a9bafd57_Out_0 = _HeightMax2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_fb6c6dd7e70e768ba686e8e94153bb96_Out_0 = float2(_Property_ce1750e5c69e97818667b412fc3f9f2c_Out_0, _Property_8e0f2ea54d8ede89bbabdf31a9bafd57_Out_0);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_151ae2702b614585af2000f0a812960f_Out_0 = _HeightOffset2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2;
            Unity_Add_float2(_Vector2_fb6c6dd7e70e768ba686e8e94153bb96_Out_0, (_Property_151ae2702b614585af2000f0a812960f_Out_0.xx), _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3;
            Unity_Remap_float(_Split_83ec66b648ab6c84848b42686c256cd7_B_3, float2 (0, 1), _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2, _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2;
            Unity_Multiply_float(_Branch_af0c5e511241ce8eae748ae487df50fa_Out_3, _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3, _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2;
            Unity_Multiply_float(_Split_c34b73d933404283983f9c8bdb5365d3_R_1, _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2, _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_818c8af4b930138e81034c886614171d_Out_0 = _Height_Transition;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 _HeightBlend_7501025b3a60738a9a9d362e35a9ab48;
            float3 _HeightBlend_7501025b3a60738a9a9d362e35a9ab48_OutVector4_1;
            SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135((_Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2.xyz), _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3, (_Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2.xyz), _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2, _Property_818c8af4b930138e81034c886614171d_Out_0, _HeightBlend_7501025b3a60738a9a9d362e35a9ab48, _HeightBlend_7501025b3a60738a9a9d362e35a9ab48_OutVector4_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_c0ebdab0f71ace8aabaa865fd7293599_Out_0 = UnityBuildTexture2DStructNoScale(_CoverBaseColorMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_822489d2e6d3e08590c64f085ffd9b2e_Out_0 = _CoverTilingOffset;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_2ae4a163bd21d98789af282d6e469175_Out_0 = _CoverUsePlanarUV;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_8bb420494d19b28e9ccdff489802dc81;
            _PlanarNM_8bb420494d19b28e9ccdff489802dc81.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNM_8bb420494d19b28e9ccdff489802dc81.uv0 = IN.uv0;
            float4 _PlanarNM_8bb420494d19b28e9ccdff489802dc81_XZ_2;
            SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(_Property_c0ebdab0f71ace8aabaa865fd7293599_Out_0, _Property_822489d2e6d3e08590c64f085ffd9b2e_Out_0, _Property_2ae4a163bd21d98789af282d6e469175_Out_0, _PlanarNM_8bb420494d19b28e9ccdff489802dc81, _PlanarNM_8bb420494d19b28e9ccdff489802dc81_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_55e7941fa7ac5f8387aa9bb633b08883_Out_0 = _CoverBaseColor;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Multiply_a38ba695a2660c8691763f0bd7fe159c_Out_2;
            Unity_Multiply_float(_PlanarNM_8bb420494d19b28e9ccdff489802dc81_XZ_2, _Property_55e7941fa7ac5f8387aa9bb633b08883_Out_0, _Multiply_a38ba695a2660c8691763f0bd7fe159c_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_c0d223db25424a8ab0cee2de2bbf58ce_Out_0 = UnityBuildTexture2DStructNoScale(_CoverMaskA);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _UV_5352c8dd0add178ba83a5421c2c0b3f0_Out_0 = IN.uv0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _SampleTexture2D_024ba490c015248988a12a9d670014ea_RGBA_0 = SAMPLE_TEXTURE2D(_Property_c0d223db25424a8ab0cee2de2bbf58ce_Out_0.tex, _Property_c0d223db25424a8ab0cee2de2bbf58ce_Out_0.samplerstate, (_UV_5352c8dd0add178ba83a5421c2c0b3f0_Out_0.xy));
            float _SampleTexture2D_024ba490c015248988a12a9d670014ea_R_4 = _SampleTexture2D_024ba490c015248988a12a9d670014ea_RGBA_0.r;
            float _SampleTexture2D_024ba490c015248988a12a9d670014ea_G_5 = _SampleTexture2D_024ba490c015248988a12a9d670014ea_RGBA_0.g;
            float _SampleTexture2D_024ba490c015248988a12a9d670014ea_B_6 = _SampleTexture2D_024ba490c015248988a12a9d670014ea_RGBA_0.b;
            float _SampleTexture2D_024ba490c015248988a12a9d670014ea_A_7 = _SampleTexture2D_024ba490c015248988a12a9d670014ea_RGBA_0.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_b80e7b96604b7c82bbf9bff4981fad76_Out_0 = _CoverMaskPower;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_abe410d256783480b1b58468bf78a882_Out_2;
            Unity_Multiply_float(_SampleTexture2D_024ba490c015248988a12a9d670014ea_A_7, _Property_b80e7b96604b7c82bbf9bff4981fad76_Out_0, _Multiply_abe410d256783480b1b58468bf78a882_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_a78f6f28770afd869adb9d12cd47370b_Out_3;
            Unity_Clamp_float(_Multiply_abe410d256783480b1b58468bf78a882_Out_2, 0, 1, _Clamp_a78f6f28770afd869adb9d12cd47370b_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_7c7049e15fdff386b535790d8666f609_Out_0 = UnityBuildTexture2DStructNoScale(_BaseNormalMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8;
            _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.WorldSpaceNormal = IN.WorldSpaceNormal;
            _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.WorldSpaceTangent = IN.WorldSpaceTangent;
            _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
            _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.uv0 = IN.uv0;
            float4 _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8_XZ_2;
            SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(_Property_7c7049e15fdff386b535790d8666f609_Out_0, _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0, _Property_7f998178363b4188ba2f07298ef869c1_Out_0, _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8, _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_d4b0759cf4647e81be065ec1465ce2b4_Out_0 = _BaseNormalScale;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _NormalStrength_f66a9108ea294886acc61513b41cc5e4_Out_2;
            Unity_NormalStrength_float((_PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8_XZ_2.xyz), _Property_d4b0759cf4647e81be065ec1465ce2b4_Out_0, _NormalStrength_f66a9108ea294886acc61513b41cc5e4_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_fa9f7890b20ad481a92543c04b237bde_Out_0 = UnityBuildTexture2DStructNoScale(_Base2NormalMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf;
            _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.WorldSpaceNormal = IN.WorldSpaceNormal;
            _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.WorldSpaceTangent = IN.WorldSpaceTangent;
            _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
            _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.uv0 = IN.uv0;
            float4 _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf_XZ_2;
            SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(_Property_fa9f7890b20ad481a92543c04b237bde_Out_0, _Property_86a4657df480d48e8d3ad3b036731380_Out_0, _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0, _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf, _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_8c31443b776727819a663c7ddce79064_Out_0 = _Base2NormalScale;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _NormalStrength_0fb86880ab8e368dac6d01b830e20ed8_Out_2;
            Unity_NormalStrength_float((_PlanarNMn_d7b3ec528088a085a5102e025a1b45cf_XZ_2.xyz), _Property_8c31443b776727819a663c7ddce79064_Out_0, _NormalStrength_0fb86880ab8e368dac6d01b830e20ed8_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 _HeightBlend_7c09d97625efce898e21b66cd039be8b;
            float3 _HeightBlend_7c09d97625efce898e21b66cd039be8b_OutVector4_1;
            SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135(_NormalStrength_f66a9108ea294886acc61513b41cc5e4_Out_2, _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3, _NormalStrength_0fb86880ab8e368dac6d01b830e20ed8_Out_2, _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2, _Property_818c8af4b930138e81034c886614171d_Out_0, _HeightBlend_7c09d97625efce898e21b66cd039be8b, _HeightBlend_7c09d97625efce898e21b66cd039be8b_OutVector4_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_65f7dd6fe6c29b83913af586c597a1ef_Out_0 = UnityBuildTexture2DStructNoScale(_CoverNormalMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3;
            _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3.WorldSpaceNormal = IN.WorldSpaceNormal;
            _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3.WorldSpaceTangent = IN.WorldSpaceTangent;
            _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
            _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3.uv0 = IN.uv0;
            float4 _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3_XZ_2;
            SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(_Property_65f7dd6fe6c29b83913af586c597a1ef_Out_0, _Property_822489d2e6d3e08590c64f085ffd9b2e_Out_0, _Property_2ae4a163bd21d98789af282d6e469175_Out_0, _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3, _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_19f92cae42737480a95820c51d4ba124_Out_0 = _CoverNormalBlendHardness;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _NormalStrength_2c3488591b8345869feb25a3dee06c3f_Out_2;
            Unity_NormalStrength_float((_PlanarNMn_248bc5b7421d3f828d166902c73ca6c3_XZ_2.xyz), _Property_19f92cae42737480a95820c51d4ba124_Out_0, _NormalStrength_2c3488591b8345869feb25a3dee06c3f_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_96bfe9cb80ad308385c191d094b3d071_R_1 = IN.WorldSpaceNormal[0];
            float _Split_96bfe9cb80ad308385c191d094b3d071_G_2 = IN.WorldSpaceNormal[1];
            float _Split_96bfe9cb80ad308385c191d094b3d071_B_3 = IN.WorldSpaceNormal[2];
            float _Split_96bfe9cb80ad308385c191d094b3d071_A_4 = 0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_0dd796aae8cd9f878bef13ceac4fe3ec_Out_0 = _Cover_Amount;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_67285cdc688aa38d83f62d5bb095d597_Out_0 = _Cover_Amount_Grow_Speed;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Subtract_fcefec675e7536888eccf5574d921972_Out_2;
            Unity_Subtract_float(4, _Property_67285cdc688aa38d83f62d5bb095d597_Out_0, _Subtract_fcefec675e7536888eccf5574d921972_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Divide_1e25465528e612839a4ce1faedd89e7d_Out_2;
            Unity_Divide_float(_Property_0dd796aae8cd9f878bef13ceac4fe3ec_Out_0, _Subtract_fcefec675e7536888eccf5574d921972_Out_2, _Divide_1e25465528e612839a4ce1faedd89e7d_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Absolute_d20b810ffdec828ab74dd6692d82f01b_Out_1;
            Unity_Absolute_float(_Divide_1e25465528e612839a4ce1faedd89e7d_Out_2, _Absolute_d20b810ffdec828ab74dd6692d82f01b_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Power_181fbf47cfdb258da1fe0b72a450986f_Out_2;
            Unity_Power_float(_Absolute_d20b810ffdec828ab74dd6692d82f01b_Out_1, _Subtract_fcefec675e7536888eccf5574d921972_Out_2, _Power_181fbf47cfdb258da1fe0b72a450986f_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_11f62dba01f1a38c9e0a9972ccd19246_Out_3;
            Unity_Clamp_float(_Power_181fbf47cfdb258da1fe0b72a450986f_Out_2, 0, 2, _Clamp_11f62dba01f1a38c9e0a9972ccd19246_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_9810f6d76275cd8fbe5e3a02360b98a7_Out_2;
            Unity_Multiply_float(_Split_96bfe9cb80ad308385c191d094b3d071_G_2, _Clamp_11f62dba01f1a38c9e0a9972ccd19246_Out_3, _Multiply_9810f6d76275cd8fbe5e3a02360b98a7_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Saturate_a007c5f214685c87bf6ca3e64c06b488_Out_1;
            Unity_Saturate_float(_Multiply_9810f6d76275cd8fbe5e3a02360b98a7_Out_2, _Saturate_a007c5f214685c87bf6ca3e64c06b488_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_1b2b25b617fc508b9835f0309136fd00_Out_3;
            Unity_Clamp_float(_Split_96bfe9cb80ad308385c191d094b3d071_G_2, 0, 0.9999, _Clamp_1b2b25b617fc508b9835f0309136fd00_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_7b12276ea7a4538db6804507b30a830c_Out_0 = _Cover_Max_Angle;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Divide_54c523ff4b7acb858e9e368fd1e4d34a_Out_2;
            Unity_Divide_float(_Property_7b12276ea7a4538db6804507b30a830c_Out_0, 45, _Divide_54c523ff4b7acb858e9e368fd1e4d34a_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _OneMinus_6cf431985b651e8e9546ae6cb2d4d668_Out_1;
            Unity_OneMinus_float(_Divide_54c523ff4b7acb858e9e368fd1e4d34a_Out_2, _OneMinus_6cf431985b651e8e9546ae6cb2d4d668_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Subtract_4ef7b60aeab8d589bf2d2423737642bc_Out_2;
            Unity_Subtract_float(_Clamp_1b2b25b617fc508b9835f0309136fd00_Out_3, _OneMinus_6cf431985b651e8e9546ae6cb2d4d668_Out_1, _Subtract_4ef7b60aeab8d589bf2d2423737642bc_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_a4b51894ea17818c9a27bb533a2ebe74_Out_3;
            Unity_Clamp_float(_Subtract_4ef7b60aeab8d589bf2d2423737642bc_Out_2, 0, 2, _Clamp_a4b51894ea17818c9a27bb533a2ebe74_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Divide_c4196d4f02190b89ba827ccd4ae8a74d_Out_2;
            Unity_Divide_float(1, _Divide_54c523ff4b7acb858e9e368fd1e4d34a_Out_2, _Divide_c4196d4f02190b89ba827ccd4ae8a74d_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_ffc22433163d1184846ede424b44bcb2_Out_2;
            Unity_Multiply_float(_Clamp_a4b51894ea17818c9a27bb533a2ebe74_Out_3, _Divide_c4196d4f02190b89ba827ccd4ae8a74d_Out_2, _Multiply_ffc22433163d1184846ede424b44bcb2_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Absolute_c2e5757082de5d878d4c023806fb2108_Out_1;
            Unity_Absolute_float(_Multiply_ffc22433163d1184846ede424b44bcb2_Out_2, _Absolute_c2e5757082de5d878d4c023806fb2108_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_849d9f217c95f38c9d49ab251578d8d5_Out_0 = _CoverHardness;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Power_578546d66d69a5829b745ebba1279adf_Out_2;
            Unity_Power_float(_Absolute_c2e5757082de5d878d4c023806fb2108_Out_1, _Property_849d9f217c95f38c9d49ab251578d8d5_Out_0, _Power_578546d66d69a5829b745ebba1279adf_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_34d2d3aff4814e8e83d2894b3512c6c8_Out_0 = _Cover_Min_Height;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _OneMinus_474df64227f004849b34c68fe8df93f2_Out_1;
            Unity_OneMinus_float(_Property_34d2d3aff4814e8e83d2894b3512c6c8_Out_0, _OneMinus_474df64227f004849b34c68fe8df93f2_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_ee4d9dc934b3508397d5a3dece110ab0_R_1 = IN.AbsoluteWorldSpacePosition[0];
            float _Split_ee4d9dc934b3508397d5a3dece110ab0_G_2 = IN.AbsoluteWorldSpacePosition[1];
            float _Split_ee4d9dc934b3508397d5a3dece110ab0_B_3 = IN.AbsoluteWorldSpacePosition[2];
            float _Split_ee4d9dc934b3508397d5a3dece110ab0_A_4 = 0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Add_d6bc513aa82d918ea24e279f4353d971_Out_2;
            Unity_Add_float(_OneMinus_474df64227f004849b34c68fe8df93f2_Out_1, _Split_ee4d9dc934b3508397d5a3dece110ab0_G_2, _Add_d6bc513aa82d918ea24e279f4353d971_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Add_a6a61cb12180108c9e1364b90d2673e2_Out_2;
            Unity_Add_float(_Add_d6bc513aa82d918ea24e279f4353d971_Out_2, 1, _Add_a6a61cb12180108c9e1364b90d2673e2_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_1874fdd00cb9aa839d93ab8536e2414d_Out_3;
            Unity_Clamp_float(_Add_a6a61cb12180108c9e1364b90d2673e2_Out_2, 0, 1, _Clamp_1874fdd00cb9aa839d93ab8536e2414d_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_7b91fd6e21b46c85816c7b681307cbe4_Out_0 = _Cover_Min_Height_Blending;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Add_6dca9453f6a35e8185c4b8e9782db0a9_Out_2;
            Unity_Add_float(_Add_d6bc513aa82d918ea24e279f4353d971_Out_2, _Property_7b91fd6e21b46c85816c7b681307cbe4_Out_0, _Add_6dca9453f6a35e8185c4b8e9782db0a9_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Divide_83415a319ecfba83af914cbc5487b546_Out_2;
            Unity_Divide_float(_Add_6dca9453f6a35e8185c4b8e9782db0a9_Out_2, _Add_d6bc513aa82d918ea24e279f4353d971_Out_2, _Divide_83415a319ecfba83af914cbc5487b546_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _OneMinus_bf150b22fcad5a87b7c825c9c6cf1687_Out_1;
            Unity_OneMinus_float(_Divide_83415a319ecfba83af914cbc5487b546_Out_2, _OneMinus_bf150b22fcad5a87b7c825c9c6cf1687_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Add_86ff9fa850efbe8c80705d8266609dab_Out_2;
            Unity_Add_float(_OneMinus_bf150b22fcad5a87b7c825c9c6cf1687_Out_1, -0.5, _Add_86ff9fa850efbe8c80705d8266609dab_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_906e140f01222d8ba61252ec6ec9d6a4_Out_3;
            Unity_Clamp_float(_Add_86ff9fa850efbe8c80705d8266609dab_Out_2, 0, 1, _Clamp_906e140f01222d8ba61252ec6ec9d6a4_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Add_c1ec5849bf72f585a30b3e11a91ada52_Out_2;
            Unity_Add_float(_Clamp_1874fdd00cb9aa839d93ab8536e2414d_Out_3, _Clamp_906e140f01222d8ba61252ec6ec9d6a4_Out_3, _Add_c1ec5849bf72f585a30b3e11a91ada52_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_17a8a0cf209a038b9e9c7f5681cdd1fb_Out_3;
            Unity_Clamp_float(_Add_c1ec5849bf72f585a30b3e11a91ada52_Out_2, 0, 1, _Clamp_17a8a0cf209a038b9e9c7f5681cdd1fb_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_8c2759ac24a9b289b1e9610cfd161bb0_Out_2;
            Unity_Multiply_float(_Power_578546d66d69a5829b745ebba1279adf_Out_2, _Clamp_17a8a0cf209a038b9e9c7f5681cdd1fb_Out_3, _Multiply_8c2759ac24a9b289b1e9610cfd161bb0_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_1a723f136ec7fa8c957b5d29e03d3051_Out_2;
            Unity_Multiply_float(_Saturate_a007c5f214685c87bf6ca3e64c06b488_Out_1, _Multiply_8c2759ac24a9b289b1e9610cfd161bb0_Out_2, _Multiply_1a723f136ec7fa8c957b5d29e03d3051_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Lerp_d1c72e47b283948584479177786ae8d5_Out_3;
            Unity_Lerp_float3(_HeightBlend_7c09d97625efce898e21b66cd039be8b_OutVector4_1, _NormalStrength_2c3488591b8345869feb25a3dee06c3f_Out_2, (_Multiply_1a723f136ec7fa8c957b5d29e03d3051_Out_2.xxx), _Lerp_d1c72e47b283948584479177786ae8d5_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3x3 Transform_180fb403b53f318db002e8eba7616644_transposeTangent = transpose(float3x3(IN.WorldSpaceTangent, IN.WorldSpaceBiTangent, IN.WorldSpaceNormal));
            float3 _Transform_180fb403b53f318db002e8eba7616644_Out_1 = normalize(mul(Transform_180fb403b53f318db002e8eba7616644_transposeTangent, _Lerp_d1c72e47b283948584479177786ae8d5_Out_3.xyz).xyz);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_c9a2b4fb4f688b8ebfc1436535cd5ba4_R_1 = _Transform_180fb403b53f318db002e8eba7616644_Out_1[0];
            float _Split_c9a2b4fb4f688b8ebfc1436535cd5ba4_G_2 = _Transform_180fb403b53f318db002e8eba7616644_Out_1[1];
            float _Split_c9a2b4fb4f688b8ebfc1436535cd5ba4_B_3 = _Transform_180fb403b53f318db002e8eba7616644_Out_1[2];
            float _Split_c9a2b4fb4f688b8ebfc1436535cd5ba4_A_4 = 0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_4c7631d0688102819e6d388d624855a1_Out_2;
            Unity_Multiply_float(_Split_c9a2b4fb4f688b8ebfc1436535cd5ba4_G_2, _Clamp_11f62dba01f1a38c9e0a9972ccd19246_Out_3, _Multiply_4c7631d0688102819e6d388d624855a1_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_f2887eb409f6bb81ae4caad2b01b17f1_Out_2;
            Unity_Multiply_float(_Clamp_11f62dba01f1a38c9e0a9972ccd19246_Out_3, _Property_849d9f217c95f38c9d49ab251578d8d5_Out_0, _Multiply_f2887eb409f6bb81ae4caad2b01b17f1_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_2e348ed31331e78791b2b3130a009f30_Out_2;
            Unity_Multiply_float(_Multiply_f2887eb409f6bb81ae4caad2b01b17f1_Out_2, _Multiply_8c2759ac24a9b289b1e9610cfd161bb0_Out_2, _Multiply_2e348ed31331e78791b2b3130a009f30_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_622e54e9a77b08839c0954ce5715ad1c_Out_2;
            Unity_Multiply_float(_Multiply_4c7631d0688102819e6d388d624855a1_Out_2, _Multiply_2e348ed31331e78791b2b3130a009f30_Out_2, _Multiply_622e54e9a77b08839c0954ce5715ad1c_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_608db04fab7d768d9a8b5fb9cf0768e1_Out_0 = UnityBuildTexture2DStructNoScale(_CoverMaskMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e;
            _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e.uv0 = IN.uv0;
            float4 _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e_XZ_2;
            SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(_Property_608db04fab7d768d9a8b5fb9cf0768e1_Out_0, _Property_822489d2e6d3e08590c64f085ffd9b2e_Out_0, _Property_2ae4a163bd21d98789af282d6e469175_Out_0, _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e, _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_86ec1aefda4f9e8e82b79c6195b397b0_R_1 = _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e_XZ_2[0];
            float _Split_86ec1aefda4f9e8e82b79c6195b397b0_G_2 = _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e_XZ_2[1];
            float _Split_86ec1aefda4f9e8e82b79c6195b397b0_B_3 = _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e_XZ_2[2];
            float _Split_86ec1aefda4f9e8e82b79c6195b397b0_A_4 = _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e_XZ_2[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_c9c6897e00458b8f8aa07df49fa519bc_Out_0 = _CoverHeightMapMin;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_ab94650b8edd82828661fe99e3c0e849_Out_0 = _CoverHeightMapMax;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_fe489f7321f6568686816b9eecbc16d1_Out_0 = float2(_Property_c9c6897e00458b8f8aa07df49fa519bc_Out_0, _Property_ab94650b8edd82828661fe99e3c0e849_Out_0);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_c1ab40024cb83b87960e4327efbd997f_Out_0 = _CoverHeightMapOffset;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Add_4a359522fc231c83b55ef23f341b6fb3_Out_2;
            Unity_Add_float2(_Vector2_fe489f7321f6568686816b9eecbc16d1_Out_0, (_Property_c1ab40024cb83b87960e4327efbd997f_Out_0.xx), _Add_4a359522fc231c83b55ef23f341b6fb3_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Remap_5aee5b64d41562858dc7c42d8b748894_Out_3;
            Unity_Remap_float(_Split_86ec1aefda4f9e8e82b79c6195b397b0_B_3, float2 (0, 1), _Add_4a359522fc231c83b55ef23f341b6fb3_Out_2, _Remap_5aee5b64d41562858dc7c42d8b748894_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_f0228e1cfd9c858dbb36367f551733c4_Out_2;
            Unity_Multiply_float(_Multiply_622e54e9a77b08839c0954ce5715ad1c_Out_2, _Remap_5aee5b64d41562858dc7c42d8b748894_Out_3, _Multiply_f0228e1cfd9c858dbb36367f551733c4_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_bb4d60728db93b8a9af9635fa1d69891_Out_2;
            Unity_Multiply_float(_Split_c34b73d933404283983f9c8bdb5365d3_G_2, _Multiply_f0228e1cfd9c858dbb36367f551733c4_Out_2, _Multiply_bb4d60728db93b8a9af9635fa1d69891_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Saturate_9b052a9bb99eff89bb11bdc387a0c2fd_Out_1;
            Unity_Saturate_float(_Multiply_bb4d60728db93b8a9af9635fa1d69891_Out_2, _Saturate_9b052a9bb99eff89bb11bdc387a0c2fd_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_22fb8c1cfd28b687a991e101aa13ff5b_Out_2;
            Unity_Multiply_float(_Clamp_a78f6f28770afd869adb9d12cd47370b_Out_3, _Saturate_9b052a9bb99eff89bb11bdc387a0c2fd_Out_1, _Multiply_22fb8c1cfd28b687a991e101aa13ff5b_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #if defined(_USEDYNAMICCOVERTSTATICMASKF_ON)
            float _UseDynamicCoverTStaticMaskF_20dcbac2f16cf78ebd6fd1debcd7f281_Out_0 = _Multiply_22fb8c1cfd28b687a991e101aa13ff5b_Out_2;
            #else
            float _UseDynamicCoverTStaticMaskF_20dcbac2f16cf78ebd6fd1debcd7f281_Out_0 = _Clamp_a78f6f28770afd869adb9d12cd47370b_Out_3;
            #endif
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Lerp_e5620b57c917728fa1416e2ffce9b0db_Out_3;
            Unity_Lerp_float3(_HeightBlend_7501025b3a60738a9a9d362e35a9ab48_OutVector4_1, (_Multiply_a38ba695a2660c8691763f0bd7fe159c_Out_2.xyz), (_UseDynamicCoverTStaticMaskF_20dcbac2f16cf78ebd6fd1debcd7f281_Out_0.xxx), _Lerp_e5620b57c917728fa1416e2ffce9b0db_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_7b9efcab84158389b4a4ea1e24b5601a_Out_0 = _CoverNormalScale;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _NormalStrength_8f42544d1b3ae08092fb1812b8119cfa_Out_2;
            Unity_NormalStrength_float((_PlanarNMn_248bc5b7421d3f828d166902c73ca6c3_XZ_2.xyz), _Property_7b9efcab84158389b4a4ea1e24b5601a_Out_0, _NormalStrength_8f42544d1b3ae08092fb1812b8119cfa_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Lerp_18ca18da5861e688a3fb637172636eda_Out_3;
            Unity_Lerp_float3(_HeightBlend_7c09d97625efce898e21b66cd039be8b_OutVector4_1, _NormalStrength_8f42544d1b3ae08092fb1812b8119cfa_Out_2, (_UseDynamicCoverTStaticMaskF_20dcbac2f16cf78ebd6fd1debcd7f281_Out_0.xxx), _Lerp_18ca18da5861e688a3fb637172636eda_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_afd0f3561038ef8487e614f350d364dd_Out_0 = _BaseMetallic;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_154e0f89b19c8e86926222afb13691e3_Out_2;
            Unity_Multiply_float(_Split_91a015dea8acd38b904ba0935328a5bc_R_1, _Property_afd0f3561038ef8487e614f350d364dd_Out_0, _Multiply_154e0f89b19c8e86926222afb13691e3_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_b82ce26778f44c8fa3510d1a8ed92d0d_Out_0 = _BaseAORemapMin;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_9d07c7a09a85da809f1d4661406e0888_Out_0 = _BaseAORemapMax;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_10162c774de2a7838426399cfe98be82_Out_0 = float2(_Property_b82ce26778f44c8fa3510d1a8ed92d0d_Out_0, _Property_9d07c7a09a85da809f1d4661406e0888_Out_0);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Remap_c45fda31db668c81a9e89e11297ec993_Out_3;
            Unity_Remap_float(_Split_91a015dea8acd38b904ba0935328a5bc_G_2, float2 (0, 1), _Vector2_10162c774de2a7838426399cfe98be82_Out_0, _Remap_c45fda31db668c81a9e89e11297ec993_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_04a7bb2753456b8293b3e46e346b646e_Out_0 = _BaseSmoothnessRemapMin;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_75c8631fc908bb8ba8542d2e70d18cbf_Out_0 = _BaseSmoothnessRemapMax;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_b2e1a3c487cdf88f9b5992b831ba24d6_Out_0 = float2(_Property_04a7bb2753456b8293b3e46e346b646e_Out_0, _Property_75c8631fc908bb8ba8542d2e70d18cbf_Out_0);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Remap_65ca5af95590f88da70777476b6efd40_Out_3;
            Unity_Remap_float(_Split_91a015dea8acd38b904ba0935328a5bc_A_4, float2 (0, 1), _Vector2_b2e1a3c487cdf88f9b5992b831ba24d6_Out_0, _Remap_65ca5af95590f88da70777476b6efd40_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Vector3_28c1e2dadb10138a9799d970043db9b0_Out_0 = float3(_Multiply_154e0f89b19c8e86926222afb13691e3_Out_2, _Remap_c45fda31db668c81a9e89e11297ec993_Out_3, _Remap_65ca5af95590f88da70777476b6efd40_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_4ead43cc6d37b68eb268dd80c3a561e9_Out_0 = _Base2Metallic;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_eef7838a4634498b9cf12d1bee89d853_Out_2;
            Unity_Multiply_float(_Split_83ec66b648ab6c84848b42686c256cd7_R_1, _Property_4ead43cc6d37b68eb268dd80c3a561e9_Out_0, _Multiply_eef7838a4634498b9cf12d1bee89d853_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_e1ed9fe432388887abb17b07dcc5ca6b_Out_0 = _Base2AORemapMin;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_cb0cf7882dcbcf88989a12f73fb7c917_Out_0 = _Base2AORemapMax;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_2d74d82ae79d5681a097c2e3ce20c913_Out_0 = float2(_Property_e1ed9fe432388887abb17b07dcc5ca6b_Out_0, _Property_cb0cf7882dcbcf88989a12f73fb7c917_Out_0);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Remap_dcd2e2871e334281a15cdd1da6103c7f_Out_3;
            Unity_Remap_float(_Split_83ec66b648ab6c84848b42686c256cd7_G_2, float2 (0, 1), _Vector2_2d74d82ae79d5681a097c2e3ce20c913_Out_0, _Remap_dcd2e2871e334281a15cdd1da6103c7f_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_159cd47513de4f85a992da1f43f77c51_Out_0 = _Base2SmoothnessRemapMin;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_b1f3c7061cf84380b1a0ffc2c5f770db_Out_0 = _Base2SmoothnessRemapMax;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_eb0fcc98def54d83abe1cfec60457b78_Out_0 = float2(_Property_159cd47513de4f85a992da1f43f77c51_Out_0, _Property_b1f3c7061cf84380b1a0ffc2c5f770db_Out_0);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Remap_1214803bb0f7c387adc088fb938f7971_Out_3;
            Unity_Remap_float(_Split_83ec66b648ab6c84848b42686c256cd7_A_4, float2 (0, 1), _Vector2_eb0fcc98def54d83abe1cfec60457b78_Out_0, _Remap_1214803bb0f7c387adc088fb938f7971_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Vector3_ddb5452f73a0dc819b57dbe981a5f4e7_Out_0 = float3(_Multiply_eef7838a4634498b9cf12d1bee89d853_Out_2, _Remap_dcd2e2871e334281a15cdd1da6103c7f_Out_3, _Remap_1214803bb0f7c387adc088fb938f7971_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 _HeightBlend_3ef23bc9c463ea8f91d2c1bc27c32dff;
            float3 _HeightBlend_3ef23bc9c463ea8f91d2c1bc27c32dff_OutVector4_1;
            SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135(_Vector3_28c1e2dadb10138a9799d970043db9b0_Out_0, _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3, _Vector3_ddb5452f73a0dc819b57dbe981a5f4e7_Out_0, _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2, _Property_818c8af4b930138e81034c886614171d_Out_0, _HeightBlend_3ef23bc9c463ea8f91d2c1bc27c32dff, _HeightBlend_3ef23bc9c463ea8f91d2c1bc27c32dff_OutVector4_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_6dbb3498614f2088a1315529ed864ea3_Out_0 = _CoverMetallic;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_7a0f3f362f18fd86b9191e28255508f8_Out_2;
            Unity_Multiply_float(_Split_86ec1aefda4f9e8e82b79c6195b397b0_R_1, _Property_6dbb3498614f2088a1315529ed864ea3_Out_0, _Multiply_7a0f3f362f18fd86b9191e28255508f8_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_840e5ecb6a2ddb83abffd7be403ecd68_Out_0 = _CoverAORemapMin;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_92176ee70059d28abbfcad689b580f1a_Out_0 = _CoverAORemapMax;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_2b0ddb771cc86988a6f70ca3c4d0145b_Out_0 = float2(_Property_840e5ecb6a2ddb83abffd7be403ecd68_Out_0, _Property_92176ee70059d28abbfcad689b580f1a_Out_0);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Remap_1091f204ac00858d804a3785be14a17e_Out_3;
            Unity_Remap_float(_Split_86ec1aefda4f9e8e82b79c6195b397b0_G_2, float2 (0, 1), _Vector2_2b0ddb771cc86988a6f70ca3c4d0145b_Out_0, _Remap_1091f204ac00858d804a3785be14a17e_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_4cd4964a0372a3858a89e499b8d810a1_Out_0 = _CoverSmoothnessRemapMin;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_f7e67cf191e5c38388370531311427cf_Out_0 = _CoverSmoothnessRemapMax;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_60ae45a9f680358085440c61ca0118da_Out_0 = float2(_Property_4cd4964a0372a3858a89e499b8d810a1_Out_0, _Property_f7e67cf191e5c38388370531311427cf_Out_0);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Remap_e88a1283399b2187be29c818a3fc3543_Out_3;
            Unity_Remap_float(_Split_86ec1aefda4f9e8e82b79c6195b397b0_A_4, float2 (0, 1), _Vector2_60ae45a9f680358085440c61ca0118da_Out_0, _Remap_e88a1283399b2187be29c818a3fc3543_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Vector3_83d0f92fd33a1d8799fdafb5ae407cb7_Out_0 = float3(_Multiply_7a0f3f362f18fd86b9191e28255508f8_Out_2, _Remap_1091f204ac00858d804a3785be14a17e_Out_3, _Remap_e88a1283399b2187be29c818a3fc3543_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Lerp_afcfe197cbc3818eb5aaaa1cf503c7d4_Out_3;
            Unity_Lerp_float3(_HeightBlend_3ef23bc9c463ea8f91d2c1bc27c32dff_OutVector4_1, _Vector3_83d0f92fd33a1d8799fdafb5ae407cb7_Out_0, (_UseDynamicCoverTStaticMaskF_20dcbac2f16cf78ebd6fd1debcd7f281_Out_0.xxx), _Lerp_afcfe197cbc3818eb5aaaa1cf503c7d4_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_93a6a2f8a95a1b80bea53b3c9628de7b_R_1 = _Lerp_afcfe197cbc3818eb5aaaa1cf503c7d4_Out_3[0];
            float _Split_93a6a2f8a95a1b80bea53b3c9628de7b_G_2 = _Lerp_afcfe197cbc3818eb5aaaa1cf503c7d4_Out_3[1];
            float _Split_93a6a2f8a95a1b80bea53b3c9628de7b_B_3 = _Lerp_afcfe197cbc3818eb5aaaa1cf503c7d4_Out_3[2];
            float _Split_93a6a2f8a95a1b80bea53b3c9628de7b_A_4 = 0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_c7a719bf7da79a8ea38d7311fd844f92_R_1 = _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2[0];
            float _Split_c7a719bf7da79a8ea38d7311fd844f92_G_2 = _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2[1];
            float _Split_c7a719bf7da79a8ea38d7311fd844f92_B_3 = _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2[2];
            float _Split_c7a719bf7da79a8ea38d7311fd844f92_A_4 = _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_7c5dae9b46c9e686b49e58fa996a104a_Out_0 = IgnoreBase2Alpha;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_e9060f5c0433ec889696d3e462f3229b_R_1 = _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2[0];
            float _Split_e9060f5c0433ec889696d3e462f3229b_G_2 = _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2[1];
            float _Split_e9060f5c0433ec889696d3e462f3229b_B_3 = _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2[2];
            float _Split_e9060f5c0433ec889696d3e462f3229b_A_4 = _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Branch_a7d7aece30fd9b8eb456d191fdd37a06_Out_3;
            Unity_Branch_float(_Property_7c5dae9b46c9e686b49e58fa996a104a_Out_0, _Split_c7a719bf7da79a8ea38d7311fd844f92_A_4, _Split_e9060f5c0433ec889696d3e462f3229b_A_4, _Branch_a7d7aece30fd9b8eb456d191fdd37a06_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Lerp_8692ca93f568998fbc97130b6dbc4556_Out_3;
            Unity_Lerp_float(_Split_c7a719bf7da79a8ea38d7311fd844f92_A_4, _Branch_a7d7aece30fd9b8eb456d191fdd37a06_Out_3, _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2, _Lerp_8692ca93f568998fbc97130b6dbc4556_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_0c8b7b55b9f82588ab2dcff09ee7a16d_Out_3;
            Unity_Clamp_float(_Lerp_8692ca93f568998fbc97130b6dbc4556_Out_3, 0, 1, _Clamp_0c8b7b55b9f82588ab2dcff09ee7a16d_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_6333dc4a6348088bb7281602ce6bff5f_Out_2;
            Unity_Multiply_float(_Clamp_0c8b7b55b9f82588ab2dcff09ee7a16d_Out_3, _Split_c34b73d933404283983f9c8bdb5365d3_A_4, _Multiply_6333dc4a6348088bb7281602ce6bff5f_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_9642b8fb7e32b18a91da1888c9bc375b_Out_3;
            Unity_Clamp_float(_Multiply_6333dc4a6348088bb7281602ce6bff5f_Out_2, 0, 1, _Clamp_9642b8fb7e32b18a91da1888c9bc375b_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_8bc98dd454a5508b9864a6ba09772356_Out_0 = _AlphaCutoff;
            #endif
            surface.BaseColor = _Lerp_e5620b57c917728fa1416e2ffce9b0db_Out_3;
            surface.NormalTS = _Lerp_18ca18da5861e688a3fb637172636eda_Out_3;
            surface.Emission = float3(0, 0, 0);
            surface.Metallic = _Split_93a6a2f8a95a1b80bea53b3c9628de7b_R_1;
            surface.Smoothness = _Split_93a6a2f8a95a1b80bea53b3c9628de7b_B_3;
            surface.Occlusion = _Split_93a6a2f8a95a1b80bea53b3c9628de7b_G_2;
            surface.Alpha = _Clamp_9642b8fb7e32b18a91da1888c9bc375b_Out_3;
            surface.AlphaClipThreshold = _Property_8bc98dd454a5508b9864a6ba09772356_Out_0;
            return surface;
        }

            // --------------------------------------------------
            // Build Graph Inputs

            VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceNormal =           input.normalOS;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceTangent =          input.tangentOS.xyz;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpacePosition =         input.positionOS;
        #endif


            return output;
        }
            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 unnormalizedNormalWS = input.normalWS;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        const float renormFactor = 1.0 / length(unnormalizedNormalWS);
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // use bitangent on the fly like in hdrp
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // IMPORTANT! If we ever support Flip on double sided materials ensure bitangent and tangent are NOT flipped.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float crossSign = (input.tangentWS.w > 0.0 ? 1.0 : -1.0) * GetOddNegativeScale();
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 bitang = crossSign * cross(input.normalWS.xyz, input.tangentWS.xyz);
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceNormal =            renormFactor*input.normalWS.xyz;		// we want a unit length Normal Vector node in shader graph
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // to preserve mikktspace compliance we use same scale renormFactor as was used on the normal.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // This is explained in section 2.2 in "surface gradient based bump mapping framework"
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceTangent =           renormFactor*input.tangentWS.xyz;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceBiTangent =         renormFactor*bitang;
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(input.positionWS);
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.uv0 =                         input.texCoord0;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.VertexColor =                 input.color;
        #endif

        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

            return output;
        }

            // --------------------------------------------------
            // Main

            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/UnityGBuffer.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/PBRGBufferPass.hlsl"

            ENDHLSL
        }
        Pass
        {
            Name "ShadowCaster"
            Tags
            {
                "LightMode" = "ShadowCaster"
            }

            // Render State
            Cull Back
        Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
        ZTest LEqual
        ZWrite On
        ColorMask 0

            // Debug
            // <None>

            // --------------------------------------------------
            // Pass

            HLSLPROGRAM

            // Pragmas
            #pragma target 4.5
        #pragma exclude_renderers gles gles3 glcore
        #pragma multi_compile_instancing
        #pragma multi_compile _ DOTS_INSTANCING_ON
        #pragma vertex vert
        #pragma fragment frag

            // DotsInstancingOptions: <None>
            // HybridV1InjectedBuiltinProperties: <None>

            // Keywords
            // PassKeywords: <None>
            #pragma shader_feature_local _ _USEDYNAMICCOVERTSTATICMASKF_ON

        #if defined(_USEDYNAMICCOVERTSTATICMASKF_ON)
            #define KEYWORD_PERMUTATION_0
        #else
            #define KEYWORD_PERMUTATION_1
        #endif


            // Defines
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _SURFACE_TYPE_TRANSPARENT 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _AlphaClip 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMALMAP 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMAL_DROPOFF_TS 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_NORMAL
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TANGENT
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TEXCOORD0
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_COLOR
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_POSITION_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TEXCOORD0
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_COLOR
        #endif

            #define FEATURES_GRAPH_VERTEX
            /* WARNING: $splice Could not find named fragment 'PassInstancing' */
            #define SHADERPASS SHADERPASS_SHADOWCASTER
            /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */

            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

            // --------------------------------------------------
            // Structs and Packing

            struct Attributes
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 positionOS : POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 normalOS : NORMAL;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 tangentOS : TANGENT;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 uv0 : TEXCOORD0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 color : COLOR;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : INSTANCEID_SEMANTIC;
            #endif
            #endif
        };
        struct Varyings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 positionWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 texCoord0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 color;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };
        struct SurfaceDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 AbsoluteWorldSpacePosition;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 uv0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 VertexColor;
            #endif
        };
        struct VertexDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpacePosition;
            #endif
        };
        struct PackedVaryings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp0 : TEXCOORD0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 interp1 : TEXCOORD1;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 interp2 : TEXCOORD2;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };

            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            output.positionCS = input.positionCS;
            output.interp0.xyz =  input.positionWS;
            output.interp1.xyzw =  input.texCoord0;
            output.interp2.xyzw =  input.color;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.positionWS = input.interp0.xyz;
            output.texCoord0 = input.interp1.xyzw;
            output.color = input.interp2.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        #endif

            // --------------------------------------------------
            // Graph

            // Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float _AlphaCutoff;
        float4 _BaseColor;
        float4 _BaseColorMap_TexelSize;
        float _BaseUsePlanarUV;
        float4 _BaseTilingOffset;
        float4 _BaseNormalMap_TexelSize;
        float _BaseNormalScale;
        float4 _BaseMaskMap_TexelSize;
        float _BaseMetallic;
        float _BaseAORemapMin;
        float _BaseAORemapMax;
        float _BaseSmoothnessRemapMin;
        float _BaseSmoothnessRemapMax;
        float4 _LayerMask_TexelSize;
        float _Invert_Layer_Mask;
        float _Height_Transition;
        float _HeightMin;
        float _HeightMax;
        float _HeightOffset;
        float _HeightMin2;
        float _HeightMax2;
        float _HeightOffset2;
        float IgnoreBase2Alpha;
        float4 _Base2Color;
        float4 _Base2ColorMap_TexelSize;
        float4 _Base2TilingOffset;
        float _Base2UsePlanarUV;
        float4 _Base2NormalMap_TexelSize;
        float _Base2NormalScale;
        float4 _Base2MaskMap_TexelSize;
        float _Base2Metallic;
        float _Base2SmoothnessRemapMin;
        float _Base2SmoothnessRemapMax;
        float _Base2AORemapMin;
        float _Base2AORemapMax;
        float4 _CoverMaskA_TexelSize;
        float _CoverMaskPower;
        float _Cover_Amount;
        float _Cover_Amount_Grow_Speed;
        float _Cover_Max_Angle;
        float _Cover_Min_Height;
        float _Cover_Min_Height_Blending;
        float4 _CoverBaseColor;
        float4 _CoverBaseColorMap_TexelSize;
        float4 _CoverTilingOffset;
        float _CoverUsePlanarUV;
        float4 _CoverNormalMap_TexelSize;
        float _CoverNormalScale;
        float _CoverNormalBlendHardness;
        float _CoverHardness;
        float _CoverHeightMapMin;
        float _CoverHeightMapMax;
        float _CoverHeightMapOffset;
        float4 _CoverMaskMap_TexelSize;
        float _CoverMetallic;
        float _CoverAORemapMin;
        float _CoverAORemapMax;
        float _CoverSmoothnessRemapMin;
        float _CoverSmoothnessRemapMax;
        CBUFFER_END

        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_BaseColorMap);
        SAMPLER(sampler_BaseColorMap);
        TEXTURE2D(_BaseNormalMap);
        SAMPLER(sampler_BaseNormalMap);
        TEXTURE2D(_BaseMaskMap);
        SAMPLER(sampler_BaseMaskMap);
        TEXTURE2D(_LayerMask);
        SAMPLER(sampler_LayerMask);
        TEXTURE2D(_Base2ColorMap);
        SAMPLER(sampler_Base2ColorMap);
        TEXTURE2D(_Base2NormalMap);
        SAMPLER(sampler_Base2NormalMap);
        TEXTURE2D(_Base2MaskMap);
        SAMPLER(sampler_Base2MaskMap);
        TEXTURE2D(_CoverMaskA);
        SAMPLER(sampler_CoverMaskA);
        TEXTURE2D(_CoverBaseColorMap);
        SAMPLER(sampler_CoverBaseColorMap);
        TEXTURE2D(_CoverNormalMap);
        SAMPLER(sampler_CoverNormalMap);
        TEXTURE2D(_CoverMaskMap);
        SAMPLER(sampler_CoverMaskMap);

            // Graph Functions
            
        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }

        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }

        void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }

        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }

        void Unity_Branch_float2(float Predicate, float2 True, float2 False, out float2 Out)
        {
            Out = Predicate ? True : False;
        }

        struct Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6
        {
            float3 AbsoluteWorldSpacePosition;
            half4 uv0;
        };

        void SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(UnityTexture2D Texture2D_80A3D28F, float4 Vector4_2EBA7A3B, float Boolean_7ABB9909, Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 IN, out float4 XZ_2)
        {
            UnityTexture2D _Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0 = Texture2D_80A3D28F;
            float _Property_30834f691775a0898a45b1c868520436_Out_0 = Boolean_7ABB9909;
            float _Split_89ed63cb625cb3878c183d0b71c03400_R_1 = IN.AbsoluteWorldSpacePosition[0];
            float _Split_89ed63cb625cb3878c183d0b71c03400_G_2 = IN.AbsoluteWorldSpacePosition[1];
            float _Split_89ed63cb625cb3878c183d0b71c03400_B_3 = IN.AbsoluteWorldSpacePosition[2];
            float _Split_89ed63cb625cb3878c183d0b71c03400_A_4 = 0;
            float4 _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4;
            float3 _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5;
            float2 _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6;
            Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_B_3, 0, 0, _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5, _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6);
            float4 _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0 = Vector4_2EBA7A3B;
            float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[0];
            float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_G_2 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[1];
            float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_B_3 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[2];
            float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_A_4 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[3];
            float _Divide_e64179199923c58289b6aa94ea6c9178_Out_2;
            Unity_Divide_float(1, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1, _Divide_e64179199923c58289b6aa94ea6c9178_Out_2);
            float4 _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2;
            Unity_Multiply_float(_Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, (_Divide_e64179199923c58289b6aa94ea6c9178_Out_2.xxxx), _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2);
            float2 _Vector2_16c15d3bbdd14b85bd48e3a6cb318af7_Out_0 = float2(_Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_G_2);
            float2 _Vector2_f8d75f54e7705083bbec539a60185577_Out_0 = float2(_Split_2f0f52f6ef8c0e81af0da6476402bc1f_B_3, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_A_4);
            float2 _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_16c15d3bbdd14b85bd48e3a6cb318af7_Out_0, _Vector2_f8d75f54e7705083bbec539a60185577_Out_0, _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3);
            float2 _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3;
            Unity_Branch_float2(_Property_30834f691775a0898a45b1c868520436_Out_0, (_Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2.xy), _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3, _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3);
            float4 _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0 = SAMPLE_TEXTURE2D(_Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0.tex, _Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0.samplerstate, _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3);
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.r;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.g;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.b;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_A_7 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.a;
            XZ_2 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0;
        }

        void Unity_Branch_float(float Predicate, float True, float False, out float Out)
        {
            Out = Predicate ? True : False;
        }

        void Unity_OneMinus_float(float In, out float Out)
        {
            Out = 1 - In;
        }

        void Unity_Add_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A + B;
        }

        void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
        {
            Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
        }

        void Unity_Multiply_float(float A, float B, out float Out)
        {
            Out = A * B;
        }

        void Unity_Lerp_float(float A, float B, float T, out float Out)
        {
            Out = lerp(A, B, T);
        }

        void Unity_Clamp_float(float In, float Min, float Max, out float Out)
        {
            Out = clamp(In, Min, Max);
        }

            // Graph Vertex
            struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };

        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }

            // Graph Pixel
            struct SurfaceDescription
        {
            float Alpha;
            float AlphaClipThreshold;
        };

        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_07d75b1d2628da808a2efb93a1d6219e_Out_0 = UnityBuildTexture2DStructNoScale(_BaseColorMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0 = _BaseTilingOffset;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_7f998178363b4188ba2f07298ef869c1_Out_0 = _BaseUsePlanarUV;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e;
            _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e.uv0 = IN.uv0;
            float4 _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2;
            SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(_Property_07d75b1d2628da808a2efb93a1d6219e_Out_0, _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0, _Property_7f998178363b4188ba2f07298ef869c1_Out_0, _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e, _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_b83097c58639858680bf43881a95b0af_Out_0 = _BaseColor;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2;
            Unity_Multiply_float(_PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2, _Property_b83097c58639858680bf43881a95b0af_Out_0, _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_c7a719bf7da79a8ea38d7311fd844f92_R_1 = _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2[0];
            float _Split_c7a719bf7da79a8ea38d7311fd844f92_G_2 = _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2[1];
            float _Split_c7a719bf7da79a8ea38d7311fd844f92_B_3 = _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2[2];
            float _Split_c7a719bf7da79a8ea38d7311fd844f92_A_4 = _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_7c5dae9b46c9e686b49e58fa996a104a_Out_0 = IgnoreBase2Alpha;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_ba3a5f4cba7d0a8fa288ffc8267d6c0e_Out_0 = UnityBuildTexture2DStructNoScale(_Base2ColorMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_86a4657df480d48e8d3ad3b036731380_Out_0 = _Base2TilingOffset;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0 = _Base2UsePlanarUV;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4;
            _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4.uv0 = IN.uv0;
            float4 _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4_XZ_2;
            SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(_Property_ba3a5f4cba7d0a8fa288ffc8267d6c0e_Out_0, _Property_86a4657df480d48e8d3ad3b036731380_Out_0, _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0, _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4, _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_3561b11b899bda8e855826445cf628aa_Out_0 = _Base2Color;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2;
            Unity_Multiply_float(_PlanarNM_5aeab444ca6fd78ea56a01215880a5a4_XZ_2, _Property_3561b11b899bda8e855826445cf628aa_Out_0, _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_e9060f5c0433ec889696d3e462f3229b_R_1 = _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2[0];
            float _Split_e9060f5c0433ec889696d3e462f3229b_G_2 = _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2[1];
            float _Split_e9060f5c0433ec889696d3e462f3229b_B_3 = _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2[2];
            float _Split_e9060f5c0433ec889696d3e462f3229b_A_4 = _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Branch_a7d7aece30fd9b8eb456d191fdd37a06_Out_3;
            Unity_Branch_float(_Property_7c5dae9b46c9e686b49e58fa996a104a_Out_0, _Split_c7a719bf7da79a8ea38d7311fd844f92_A_4, _Split_e9060f5c0433ec889696d3e462f3229b_A_4, _Branch_a7d7aece30fd9b8eb456d191fdd37a06_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_c34b73d933404283983f9c8bdb5365d3_R_1 = IN.VertexColor[0];
            float _Split_c34b73d933404283983f9c8bdb5365d3_G_2 = IN.VertexColor[1];
            float _Split_c34b73d933404283983f9c8bdb5365d3_B_3 = IN.VertexColor[2];
            float _Split_c34b73d933404283983f9c8bdb5365d3_A_4 = IN.VertexColor[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_df2df7bb5cfc3381beee7ec454da7542_Out_0 = _Invert_Layer_Mask;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_c7b1e2df9f9b0e8eace9b2274924e69c_Out_0 = UnityBuildTexture2DStructNoScale(_LayerMask);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0 = SAMPLE_TEXTURE2D(_Property_c7b1e2df9f9b0e8eace9b2274924e69c_Out_0.tex, _Property_c7b1e2df9f9b0e8eace9b2274924e69c_Out_0.samplerstate, IN.uv0.xy);
            float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.r;
            float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_G_5 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.g;
            float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_B_6 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.b;
            float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_A_7 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1;
            Unity_OneMinus_float(_SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4, _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Branch_af0c5e511241ce8eae748ae487df50fa_Out_3;
            Unity_Branch_float(_Property_df2df7bb5cfc3381beee7ec454da7542_Out_0, _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1, _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4, _Branch_af0c5e511241ce8eae748ae487df50fa_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_de4f6eb48a629285a664dad7fb06438f_Out_0 = UnityBuildTexture2DStructNoScale(_Base2MaskMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_d5657f470f05ef839e4c257a20ace8cb;
            _PlanarNM_d5657f470f05ef839e4c257a20ace8cb.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNM_d5657f470f05ef839e4c257a20ace8cb.uv0 = IN.uv0;
            float4 _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2;
            SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(_Property_de4f6eb48a629285a664dad7fb06438f_Out_0, _Property_86a4657df480d48e8d3ad3b036731380_Out_0, _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0, _PlanarNM_d5657f470f05ef839e4c257a20ace8cb, _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_83ec66b648ab6c84848b42686c256cd7_R_1 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[0];
            float _Split_83ec66b648ab6c84848b42686c256cd7_G_2 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[1];
            float _Split_83ec66b648ab6c84848b42686c256cd7_B_3 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[2];
            float _Split_83ec66b648ab6c84848b42686c256cd7_A_4 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_ce1750e5c69e97818667b412fc3f9f2c_Out_0 = _HeightMin2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_8e0f2ea54d8ede89bbabdf31a9bafd57_Out_0 = _HeightMax2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_fb6c6dd7e70e768ba686e8e94153bb96_Out_0 = float2(_Property_ce1750e5c69e97818667b412fc3f9f2c_Out_0, _Property_8e0f2ea54d8ede89bbabdf31a9bafd57_Out_0);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_151ae2702b614585af2000f0a812960f_Out_0 = _HeightOffset2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2;
            Unity_Add_float2(_Vector2_fb6c6dd7e70e768ba686e8e94153bb96_Out_0, (_Property_151ae2702b614585af2000f0a812960f_Out_0.xx), _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3;
            Unity_Remap_float(_Split_83ec66b648ab6c84848b42686c256cd7_B_3, float2 (0, 1), _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2, _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2;
            Unity_Multiply_float(_Branch_af0c5e511241ce8eae748ae487df50fa_Out_3, _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3, _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2;
            Unity_Multiply_float(_Split_c34b73d933404283983f9c8bdb5365d3_R_1, _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2, _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Lerp_8692ca93f568998fbc97130b6dbc4556_Out_3;
            Unity_Lerp_float(_Split_c7a719bf7da79a8ea38d7311fd844f92_A_4, _Branch_a7d7aece30fd9b8eb456d191fdd37a06_Out_3, _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2, _Lerp_8692ca93f568998fbc97130b6dbc4556_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_0c8b7b55b9f82588ab2dcff09ee7a16d_Out_3;
            Unity_Clamp_float(_Lerp_8692ca93f568998fbc97130b6dbc4556_Out_3, 0, 1, _Clamp_0c8b7b55b9f82588ab2dcff09ee7a16d_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_6333dc4a6348088bb7281602ce6bff5f_Out_2;
            Unity_Multiply_float(_Clamp_0c8b7b55b9f82588ab2dcff09ee7a16d_Out_3, _Split_c34b73d933404283983f9c8bdb5365d3_A_4, _Multiply_6333dc4a6348088bb7281602ce6bff5f_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_9642b8fb7e32b18a91da1888c9bc375b_Out_3;
            Unity_Clamp_float(_Multiply_6333dc4a6348088bb7281602ce6bff5f_Out_2, 0, 1, _Clamp_9642b8fb7e32b18a91da1888c9bc375b_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_8bc98dd454a5508b9864a6ba09772356_Out_0 = _AlphaCutoff;
            #endif
            surface.Alpha = _Clamp_9642b8fb7e32b18a91da1888c9bc375b_Out_3;
            surface.AlphaClipThreshold = _Property_8bc98dd454a5508b9864a6ba09772356_Out_0;
            return surface;
        }

            // --------------------------------------------------
            // Build Graph Inputs

            VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceNormal =           input.normalOS;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceTangent =          input.tangentOS.xyz;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpacePosition =         input.positionOS;
        #endif


            return output;
        }
            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);





        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(input.positionWS);
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.uv0 =                         input.texCoord0;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.VertexColor =                 input.color;
        #endif

        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

            return output;
        }

            // --------------------------------------------------
            // Main

            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShadowCasterPass.hlsl"

            ENDHLSL
        }
        Pass
        {
            Name "DepthOnly"
            Tags
            {
                "LightMode" = "DepthOnly"
            }

            // Render State
            Cull Back
        Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
        ZTest LEqual
        ZWrite On
        ColorMask 0

            // Debug
            // <None>

            // --------------------------------------------------
            // Pass

            HLSLPROGRAM

            // Pragmas
            #pragma target 4.5
        #pragma exclude_renderers gles gles3 glcore
        #pragma multi_compile_instancing
        #pragma multi_compile _ DOTS_INSTANCING_ON
        #pragma vertex vert
        #pragma fragment frag

            // DotsInstancingOptions: <None>
            // HybridV1InjectedBuiltinProperties: <None>

            // Keywords
            // PassKeywords: <None>
            #pragma shader_feature_local _ _USEDYNAMICCOVERTSTATICMASKF_ON

        #if defined(_USEDYNAMICCOVERTSTATICMASKF_ON)
            #define KEYWORD_PERMUTATION_0
        #else
            #define KEYWORD_PERMUTATION_1
        #endif


            // Defines
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _SURFACE_TYPE_TRANSPARENT 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _AlphaClip 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMALMAP 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMAL_DROPOFF_TS 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_NORMAL
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TANGENT
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TEXCOORD0
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_COLOR
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_POSITION_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TEXCOORD0
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_COLOR
        #endif

            #define FEATURES_GRAPH_VERTEX
            /* WARNING: $splice Could not find named fragment 'PassInstancing' */
            #define SHADERPASS SHADERPASS_DEPTHONLY
            /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */

            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

            // --------------------------------------------------
            // Structs and Packing

            struct Attributes
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 positionOS : POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 normalOS : NORMAL;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 tangentOS : TANGENT;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 uv0 : TEXCOORD0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 color : COLOR;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : INSTANCEID_SEMANTIC;
            #endif
            #endif
        };
        struct Varyings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 positionWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 texCoord0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 color;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };
        struct SurfaceDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 AbsoluteWorldSpacePosition;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 uv0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 VertexColor;
            #endif
        };
        struct VertexDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpacePosition;
            #endif
        };
        struct PackedVaryings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp0 : TEXCOORD0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 interp1 : TEXCOORD1;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 interp2 : TEXCOORD2;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };

            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            output.positionCS = input.positionCS;
            output.interp0.xyz =  input.positionWS;
            output.interp1.xyzw =  input.texCoord0;
            output.interp2.xyzw =  input.color;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.positionWS = input.interp0.xyz;
            output.texCoord0 = input.interp1.xyzw;
            output.color = input.interp2.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        #endif

            // --------------------------------------------------
            // Graph

            // Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float _AlphaCutoff;
        float4 _BaseColor;
        float4 _BaseColorMap_TexelSize;
        float _BaseUsePlanarUV;
        float4 _BaseTilingOffset;
        float4 _BaseNormalMap_TexelSize;
        float _BaseNormalScale;
        float4 _BaseMaskMap_TexelSize;
        float _BaseMetallic;
        float _BaseAORemapMin;
        float _BaseAORemapMax;
        float _BaseSmoothnessRemapMin;
        float _BaseSmoothnessRemapMax;
        float4 _LayerMask_TexelSize;
        float _Invert_Layer_Mask;
        float _Height_Transition;
        float _HeightMin;
        float _HeightMax;
        float _HeightOffset;
        float _HeightMin2;
        float _HeightMax2;
        float _HeightOffset2;
        float IgnoreBase2Alpha;
        float4 _Base2Color;
        float4 _Base2ColorMap_TexelSize;
        float4 _Base2TilingOffset;
        float _Base2UsePlanarUV;
        float4 _Base2NormalMap_TexelSize;
        float _Base2NormalScale;
        float4 _Base2MaskMap_TexelSize;
        float _Base2Metallic;
        float _Base2SmoothnessRemapMin;
        float _Base2SmoothnessRemapMax;
        float _Base2AORemapMin;
        float _Base2AORemapMax;
        float4 _CoverMaskA_TexelSize;
        float _CoverMaskPower;
        float _Cover_Amount;
        float _Cover_Amount_Grow_Speed;
        float _Cover_Max_Angle;
        float _Cover_Min_Height;
        float _Cover_Min_Height_Blending;
        float4 _CoverBaseColor;
        float4 _CoverBaseColorMap_TexelSize;
        float4 _CoverTilingOffset;
        float _CoverUsePlanarUV;
        float4 _CoverNormalMap_TexelSize;
        float _CoverNormalScale;
        float _CoverNormalBlendHardness;
        float _CoverHardness;
        float _CoverHeightMapMin;
        float _CoverHeightMapMax;
        float _CoverHeightMapOffset;
        float4 _CoverMaskMap_TexelSize;
        float _CoverMetallic;
        float _CoverAORemapMin;
        float _CoverAORemapMax;
        float _CoverSmoothnessRemapMin;
        float _CoverSmoothnessRemapMax;
        CBUFFER_END

        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_BaseColorMap);
        SAMPLER(sampler_BaseColorMap);
        TEXTURE2D(_BaseNormalMap);
        SAMPLER(sampler_BaseNormalMap);
        TEXTURE2D(_BaseMaskMap);
        SAMPLER(sampler_BaseMaskMap);
        TEXTURE2D(_LayerMask);
        SAMPLER(sampler_LayerMask);
        TEXTURE2D(_Base2ColorMap);
        SAMPLER(sampler_Base2ColorMap);
        TEXTURE2D(_Base2NormalMap);
        SAMPLER(sampler_Base2NormalMap);
        TEXTURE2D(_Base2MaskMap);
        SAMPLER(sampler_Base2MaskMap);
        TEXTURE2D(_CoverMaskA);
        SAMPLER(sampler_CoverMaskA);
        TEXTURE2D(_CoverBaseColorMap);
        SAMPLER(sampler_CoverBaseColorMap);
        TEXTURE2D(_CoverNormalMap);
        SAMPLER(sampler_CoverNormalMap);
        TEXTURE2D(_CoverMaskMap);
        SAMPLER(sampler_CoverMaskMap);

            // Graph Functions
            
        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }

        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }

        void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }

        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }

        void Unity_Branch_float2(float Predicate, float2 True, float2 False, out float2 Out)
        {
            Out = Predicate ? True : False;
        }

        struct Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6
        {
            float3 AbsoluteWorldSpacePosition;
            half4 uv0;
        };

        void SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(UnityTexture2D Texture2D_80A3D28F, float4 Vector4_2EBA7A3B, float Boolean_7ABB9909, Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 IN, out float4 XZ_2)
        {
            UnityTexture2D _Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0 = Texture2D_80A3D28F;
            float _Property_30834f691775a0898a45b1c868520436_Out_0 = Boolean_7ABB9909;
            float _Split_89ed63cb625cb3878c183d0b71c03400_R_1 = IN.AbsoluteWorldSpacePosition[0];
            float _Split_89ed63cb625cb3878c183d0b71c03400_G_2 = IN.AbsoluteWorldSpacePosition[1];
            float _Split_89ed63cb625cb3878c183d0b71c03400_B_3 = IN.AbsoluteWorldSpacePosition[2];
            float _Split_89ed63cb625cb3878c183d0b71c03400_A_4 = 0;
            float4 _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4;
            float3 _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5;
            float2 _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6;
            Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_B_3, 0, 0, _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5, _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6);
            float4 _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0 = Vector4_2EBA7A3B;
            float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[0];
            float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_G_2 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[1];
            float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_B_3 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[2];
            float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_A_4 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[3];
            float _Divide_e64179199923c58289b6aa94ea6c9178_Out_2;
            Unity_Divide_float(1, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1, _Divide_e64179199923c58289b6aa94ea6c9178_Out_2);
            float4 _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2;
            Unity_Multiply_float(_Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, (_Divide_e64179199923c58289b6aa94ea6c9178_Out_2.xxxx), _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2);
            float2 _Vector2_16c15d3bbdd14b85bd48e3a6cb318af7_Out_0 = float2(_Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_G_2);
            float2 _Vector2_f8d75f54e7705083bbec539a60185577_Out_0 = float2(_Split_2f0f52f6ef8c0e81af0da6476402bc1f_B_3, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_A_4);
            float2 _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_16c15d3bbdd14b85bd48e3a6cb318af7_Out_0, _Vector2_f8d75f54e7705083bbec539a60185577_Out_0, _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3);
            float2 _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3;
            Unity_Branch_float2(_Property_30834f691775a0898a45b1c868520436_Out_0, (_Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2.xy), _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3, _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3);
            float4 _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0 = SAMPLE_TEXTURE2D(_Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0.tex, _Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0.samplerstate, _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3);
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.r;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.g;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.b;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_A_7 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.a;
            XZ_2 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0;
        }

        void Unity_Branch_float(float Predicate, float True, float False, out float Out)
        {
            Out = Predicate ? True : False;
        }

        void Unity_OneMinus_float(float In, out float Out)
        {
            Out = 1 - In;
        }

        void Unity_Add_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A + B;
        }

        void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
        {
            Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
        }

        void Unity_Multiply_float(float A, float B, out float Out)
        {
            Out = A * B;
        }

        void Unity_Lerp_float(float A, float B, float T, out float Out)
        {
            Out = lerp(A, B, T);
        }

        void Unity_Clamp_float(float In, float Min, float Max, out float Out)
        {
            Out = clamp(In, Min, Max);
        }

            // Graph Vertex
            struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };

        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }

            // Graph Pixel
            struct SurfaceDescription
        {
            float Alpha;
            float AlphaClipThreshold;
        };

        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_07d75b1d2628da808a2efb93a1d6219e_Out_0 = UnityBuildTexture2DStructNoScale(_BaseColorMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0 = _BaseTilingOffset;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_7f998178363b4188ba2f07298ef869c1_Out_0 = _BaseUsePlanarUV;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e;
            _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e.uv0 = IN.uv0;
            float4 _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2;
            SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(_Property_07d75b1d2628da808a2efb93a1d6219e_Out_0, _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0, _Property_7f998178363b4188ba2f07298ef869c1_Out_0, _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e, _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_b83097c58639858680bf43881a95b0af_Out_0 = _BaseColor;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2;
            Unity_Multiply_float(_PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2, _Property_b83097c58639858680bf43881a95b0af_Out_0, _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_c7a719bf7da79a8ea38d7311fd844f92_R_1 = _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2[0];
            float _Split_c7a719bf7da79a8ea38d7311fd844f92_G_2 = _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2[1];
            float _Split_c7a719bf7da79a8ea38d7311fd844f92_B_3 = _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2[2];
            float _Split_c7a719bf7da79a8ea38d7311fd844f92_A_4 = _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_7c5dae9b46c9e686b49e58fa996a104a_Out_0 = IgnoreBase2Alpha;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_ba3a5f4cba7d0a8fa288ffc8267d6c0e_Out_0 = UnityBuildTexture2DStructNoScale(_Base2ColorMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_86a4657df480d48e8d3ad3b036731380_Out_0 = _Base2TilingOffset;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0 = _Base2UsePlanarUV;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4;
            _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4.uv0 = IN.uv0;
            float4 _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4_XZ_2;
            SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(_Property_ba3a5f4cba7d0a8fa288ffc8267d6c0e_Out_0, _Property_86a4657df480d48e8d3ad3b036731380_Out_0, _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0, _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4, _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_3561b11b899bda8e855826445cf628aa_Out_0 = _Base2Color;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2;
            Unity_Multiply_float(_PlanarNM_5aeab444ca6fd78ea56a01215880a5a4_XZ_2, _Property_3561b11b899bda8e855826445cf628aa_Out_0, _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_e9060f5c0433ec889696d3e462f3229b_R_1 = _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2[0];
            float _Split_e9060f5c0433ec889696d3e462f3229b_G_2 = _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2[1];
            float _Split_e9060f5c0433ec889696d3e462f3229b_B_3 = _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2[2];
            float _Split_e9060f5c0433ec889696d3e462f3229b_A_4 = _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Branch_a7d7aece30fd9b8eb456d191fdd37a06_Out_3;
            Unity_Branch_float(_Property_7c5dae9b46c9e686b49e58fa996a104a_Out_0, _Split_c7a719bf7da79a8ea38d7311fd844f92_A_4, _Split_e9060f5c0433ec889696d3e462f3229b_A_4, _Branch_a7d7aece30fd9b8eb456d191fdd37a06_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_c34b73d933404283983f9c8bdb5365d3_R_1 = IN.VertexColor[0];
            float _Split_c34b73d933404283983f9c8bdb5365d3_G_2 = IN.VertexColor[1];
            float _Split_c34b73d933404283983f9c8bdb5365d3_B_3 = IN.VertexColor[2];
            float _Split_c34b73d933404283983f9c8bdb5365d3_A_4 = IN.VertexColor[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_df2df7bb5cfc3381beee7ec454da7542_Out_0 = _Invert_Layer_Mask;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_c7b1e2df9f9b0e8eace9b2274924e69c_Out_0 = UnityBuildTexture2DStructNoScale(_LayerMask);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0 = SAMPLE_TEXTURE2D(_Property_c7b1e2df9f9b0e8eace9b2274924e69c_Out_0.tex, _Property_c7b1e2df9f9b0e8eace9b2274924e69c_Out_0.samplerstate, IN.uv0.xy);
            float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.r;
            float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_G_5 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.g;
            float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_B_6 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.b;
            float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_A_7 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1;
            Unity_OneMinus_float(_SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4, _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Branch_af0c5e511241ce8eae748ae487df50fa_Out_3;
            Unity_Branch_float(_Property_df2df7bb5cfc3381beee7ec454da7542_Out_0, _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1, _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4, _Branch_af0c5e511241ce8eae748ae487df50fa_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_de4f6eb48a629285a664dad7fb06438f_Out_0 = UnityBuildTexture2DStructNoScale(_Base2MaskMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_d5657f470f05ef839e4c257a20ace8cb;
            _PlanarNM_d5657f470f05ef839e4c257a20ace8cb.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNM_d5657f470f05ef839e4c257a20ace8cb.uv0 = IN.uv0;
            float4 _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2;
            SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(_Property_de4f6eb48a629285a664dad7fb06438f_Out_0, _Property_86a4657df480d48e8d3ad3b036731380_Out_0, _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0, _PlanarNM_d5657f470f05ef839e4c257a20ace8cb, _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_83ec66b648ab6c84848b42686c256cd7_R_1 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[0];
            float _Split_83ec66b648ab6c84848b42686c256cd7_G_2 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[1];
            float _Split_83ec66b648ab6c84848b42686c256cd7_B_3 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[2];
            float _Split_83ec66b648ab6c84848b42686c256cd7_A_4 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_ce1750e5c69e97818667b412fc3f9f2c_Out_0 = _HeightMin2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_8e0f2ea54d8ede89bbabdf31a9bafd57_Out_0 = _HeightMax2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_fb6c6dd7e70e768ba686e8e94153bb96_Out_0 = float2(_Property_ce1750e5c69e97818667b412fc3f9f2c_Out_0, _Property_8e0f2ea54d8ede89bbabdf31a9bafd57_Out_0);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_151ae2702b614585af2000f0a812960f_Out_0 = _HeightOffset2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2;
            Unity_Add_float2(_Vector2_fb6c6dd7e70e768ba686e8e94153bb96_Out_0, (_Property_151ae2702b614585af2000f0a812960f_Out_0.xx), _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3;
            Unity_Remap_float(_Split_83ec66b648ab6c84848b42686c256cd7_B_3, float2 (0, 1), _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2, _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2;
            Unity_Multiply_float(_Branch_af0c5e511241ce8eae748ae487df50fa_Out_3, _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3, _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2;
            Unity_Multiply_float(_Split_c34b73d933404283983f9c8bdb5365d3_R_1, _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2, _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Lerp_8692ca93f568998fbc97130b6dbc4556_Out_3;
            Unity_Lerp_float(_Split_c7a719bf7da79a8ea38d7311fd844f92_A_4, _Branch_a7d7aece30fd9b8eb456d191fdd37a06_Out_3, _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2, _Lerp_8692ca93f568998fbc97130b6dbc4556_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_0c8b7b55b9f82588ab2dcff09ee7a16d_Out_3;
            Unity_Clamp_float(_Lerp_8692ca93f568998fbc97130b6dbc4556_Out_3, 0, 1, _Clamp_0c8b7b55b9f82588ab2dcff09ee7a16d_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_6333dc4a6348088bb7281602ce6bff5f_Out_2;
            Unity_Multiply_float(_Clamp_0c8b7b55b9f82588ab2dcff09ee7a16d_Out_3, _Split_c34b73d933404283983f9c8bdb5365d3_A_4, _Multiply_6333dc4a6348088bb7281602ce6bff5f_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_9642b8fb7e32b18a91da1888c9bc375b_Out_3;
            Unity_Clamp_float(_Multiply_6333dc4a6348088bb7281602ce6bff5f_Out_2, 0, 1, _Clamp_9642b8fb7e32b18a91da1888c9bc375b_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_8bc98dd454a5508b9864a6ba09772356_Out_0 = _AlphaCutoff;
            #endif
            surface.Alpha = _Clamp_9642b8fb7e32b18a91da1888c9bc375b_Out_3;
            surface.AlphaClipThreshold = _Property_8bc98dd454a5508b9864a6ba09772356_Out_0;
            return surface;
        }

            // --------------------------------------------------
            // Build Graph Inputs

            VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceNormal =           input.normalOS;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceTangent =          input.tangentOS.xyz;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpacePosition =         input.positionOS;
        #endif


            return output;
        }
            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);





        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(input.positionWS);
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.uv0 =                         input.texCoord0;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.VertexColor =                 input.color;
        #endif

        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

            return output;
        }

            // --------------------------------------------------
            // Main

            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/DepthOnlyPass.hlsl"

            ENDHLSL
        }
        Pass
        {
            Name "DepthNormals"
            Tags
            {
                "LightMode" = "DepthNormals"
            }

            // Render State
            Cull Back
        Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
        ZTest LEqual
        ZWrite On

            // Debug
            // <None>

            // --------------------------------------------------
            // Pass

            HLSLPROGRAM

            // Pragmas
            #pragma target 4.5
        #pragma exclude_renderers gles gles3 glcore
        #pragma multi_compile_instancing
        #pragma multi_compile _ DOTS_INSTANCING_ON
        #pragma vertex vert
        #pragma fragment frag

            // DotsInstancingOptions: <None>
            // HybridV1InjectedBuiltinProperties: <None>

            // Keywords
            // PassKeywords: <None>
            #pragma shader_feature_local _ _USEDYNAMICCOVERTSTATICMASKF_ON

        #if defined(_USEDYNAMICCOVERTSTATICMASKF_ON)
            #define KEYWORD_PERMUTATION_0
        #else
            #define KEYWORD_PERMUTATION_1
        #endif


            // Defines
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _SURFACE_TYPE_TRANSPARENT 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _AlphaClip 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMALMAP 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMAL_DROPOFF_TS 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_NORMAL
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TANGENT
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TEXCOORD0
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TEXCOORD1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_COLOR
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_POSITION_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_NORMAL_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TANGENT_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TEXCOORD0
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_COLOR
        #endif

            #define FEATURES_GRAPH_VERTEX
            /* WARNING: $splice Could not find named fragment 'PassInstancing' */
            #define SHADERPASS SHADERPASS_DEPTHNORMALSONLY
            /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */

            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

            // --------------------------------------------------
            // Structs and Packing

            struct Attributes
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 positionOS : POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 normalOS : NORMAL;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 tangentOS : TANGENT;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 uv0 : TEXCOORD0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 uv1 : TEXCOORD1;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 color : COLOR;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : INSTANCEID_SEMANTIC;
            #endif
            #endif
        };
        struct Varyings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 positionWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 normalWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 tangentWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 texCoord0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 color;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };
        struct SurfaceDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 TangentSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceBiTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 AbsoluteWorldSpacePosition;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 uv0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 VertexColor;
            #endif
        };
        struct VertexDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpacePosition;
            #endif
        };
        struct PackedVaryings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp0 : TEXCOORD0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp1 : TEXCOORD1;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 interp2 : TEXCOORD2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 interp3 : TEXCOORD3;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 interp4 : TEXCOORD4;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };

            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            output.positionCS = input.positionCS;
            output.interp0.xyz =  input.positionWS;
            output.interp1.xyz =  input.normalWS;
            output.interp2.xyzw =  input.tangentWS;
            output.interp3.xyzw =  input.texCoord0;
            output.interp4.xyzw =  input.color;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.positionWS = input.interp0.xyz;
            output.normalWS = input.interp1.xyz;
            output.tangentWS = input.interp2.xyzw;
            output.texCoord0 = input.interp3.xyzw;
            output.color = input.interp4.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        #endif

            // --------------------------------------------------
            // Graph

            // Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float _AlphaCutoff;
        float4 _BaseColor;
        float4 _BaseColorMap_TexelSize;
        float _BaseUsePlanarUV;
        float4 _BaseTilingOffset;
        float4 _BaseNormalMap_TexelSize;
        float _BaseNormalScale;
        float4 _BaseMaskMap_TexelSize;
        float _BaseMetallic;
        float _BaseAORemapMin;
        float _BaseAORemapMax;
        float _BaseSmoothnessRemapMin;
        float _BaseSmoothnessRemapMax;
        float4 _LayerMask_TexelSize;
        float _Invert_Layer_Mask;
        float _Height_Transition;
        float _HeightMin;
        float _HeightMax;
        float _HeightOffset;
        float _HeightMin2;
        float _HeightMax2;
        float _HeightOffset2;
        float IgnoreBase2Alpha;
        float4 _Base2Color;
        float4 _Base2ColorMap_TexelSize;
        float4 _Base2TilingOffset;
        float _Base2UsePlanarUV;
        float4 _Base2NormalMap_TexelSize;
        float _Base2NormalScale;
        float4 _Base2MaskMap_TexelSize;
        float _Base2Metallic;
        float _Base2SmoothnessRemapMin;
        float _Base2SmoothnessRemapMax;
        float _Base2AORemapMin;
        float _Base2AORemapMax;
        float4 _CoverMaskA_TexelSize;
        float _CoverMaskPower;
        float _Cover_Amount;
        float _Cover_Amount_Grow_Speed;
        float _Cover_Max_Angle;
        float _Cover_Min_Height;
        float _Cover_Min_Height_Blending;
        float4 _CoverBaseColor;
        float4 _CoverBaseColorMap_TexelSize;
        float4 _CoverTilingOffset;
        float _CoverUsePlanarUV;
        float4 _CoverNormalMap_TexelSize;
        float _CoverNormalScale;
        float _CoverNormalBlendHardness;
        float _CoverHardness;
        float _CoverHeightMapMin;
        float _CoverHeightMapMax;
        float _CoverHeightMapOffset;
        float4 _CoverMaskMap_TexelSize;
        float _CoverMetallic;
        float _CoverAORemapMin;
        float _CoverAORemapMax;
        float _CoverSmoothnessRemapMin;
        float _CoverSmoothnessRemapMax;
        CBUFFER_END

        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_BaseColorMap);
        SAMPLER(sampler_BaseColorMap);
        TEXTURE2D(_BaseNormalMap);
        SAMPLER(sampler_BaseNormalMap);
        TEXTURE2D(_BaseMaskMap);
        SAMPLER(sampler_BaseMaskMap);
        TEXTURE2D(_LayerMask);
        SAMPLER(sampler_LayerMask);
        TEXTURE2D(_Base2ColorMap);
        SAMPLER(sampler_Base2ColorMap);
        TEXTURE2D(_Base2NormalMap);
        SAMPLER(sampler_Base2NormalMap);
        TEXTURE2D(_Base2MaskMap);
        SAMPLER(sampler_Base2MaskMap);
        TEXTURE2D(_CoverMaskA);
        SAMPLER(sampler_CoverMaskA);
        TEXTURE2D(_CoverBaseColorMap);
        SAMPLER(sampler_CoverBaseColorMap);
        TEXTURE2D(_CoverNormalMap);
        SAMPLER(sampler_CoverNormalMap);
        TEXTURE2D(_CoverMaskMap);
        SAMPLER(sampler_CoverMaskMap);

            // Graph Functions
            
        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }

        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }

        void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }

        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }

        void Unity_Branch_float2(float Predicate, float2 True, float2 False, out float2 Out)
        {
            Out = Predicate ? True : False;
        }

        void Unity_Sign_float3(float3 In, out float3 Out)
        {
            Out = sign(In);
        }

        void Unity_Multiply_float(float2 A, float2 B, out float2 Out)
        {
            Out = A * B;
        }

        void Unity_Add_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A + B;
        }

        void Unity_Multiply_float(float A, float B, out float Out)
        {
            Out = A * B;
        }

        void Unity_Normalize_float3(float3 In, out float3 Out)
        {
            Out = normalize(In);
        }

        void Unity_Branch_float3(float Predicate, float3 True, float3 False, out float3 Out)
        {
            Out = Predicate ? True : False;
        }

        struct Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8
        {
            float3 WorldSpaceNormal;
            float3 WorldSpaceTangent;
            float3 WorldSpaceBiTangent;
            float3 AbsoluteWorldSpacePosition;
            half4 uv0;
        };

        void SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(UnityTexture2D Texture2D_80A3D28F, float4 Vector4_82674548, float Boolean_9FF42DF6, Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 IN, out float4 XZ_2)
        {
            float _Property_1ef12cf3201a938993fe6a7951b0e754_Out_0 = Boolean_9FF42DF6;
            UnityTexture2D _Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0 = Texture2D_80A3D28F;
            float _Split_89ed63cb625cb3878c183d0b71c03400_R_1 = IN.AbsoluteWorldSpacePosition[0];
            float _Split_89ed63cb625cb3878c183d0b71c03400_G_2 = IN.AbsoluteWorldSpacePosition[1];
            float _Split_89ed63cb625cb3878c183d0b71c03400_B_3 = IN.AbsoluteWorldSpacePosition[2];
            float _Split_89ed63cb625cb3878c183d0b71c03400_A_4 = 0;
            float4 _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4;
            float3 _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5;
            float2 _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6;
            Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_B_3, 0, 0, _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5, _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6);
            float4 _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0 = Vector4_82674548;
            float _Split_a2e12fa5931da084b2949343a539dfd8_R_1 = _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0[0];
            float _Split_a2e12fa5931da084b2949343a539dfd8_G_2 = _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0[1];
            float _Split_a2e12fa5931da084b2949343a539dfd8_B_3 = _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0[2];
            float _Split_a2e12fa5931da084b2949343a539dfd8_A_4 = _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0[3];
            float _Divide_c36b770dfaa0bb8f85ab27da5fd794f0_Out_2;
            Unity_Divide_float(1, _Split_a2e12fa5931da084b2949343a539dfd8_R_1, _Divide_c36b770dfaa0bb8f85ab27da5fd794f0_Out_2);
            float4 _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2;
            Unity_Multiply_float(_Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, (_Divide_c36b770dfaa0bb8f85ab27da5fd794f0_Out_2.xxxx), _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2);
            float2 _Vector2_6845d21872714d889783b0cb707df3e9_Out_0 = float2(_Split_a2e12fa5931da084b2949343a539dfd8_R_1, _Split_a2e12fa5931da084b2949343a539dfd8_G_2);
            float2 _Vector2_e2e2263627c6098e96a5b5d29350ad03_Out_0 = float2(_Split_a2e12fa5931da084b2949343a539dfd8_B_3, _Split_a2e12fa5931da084b2949343a539dfd8_A_4);
            float2 _TilingAndOffset_17582d056c0b8a8dab1017d37497fe59_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_6845d21872714d889783b0cb707df3e9_Out_0, _Vector2_e2e2263627c6098e96a5b5d29350ad03_Out_0, _TilingAndOffset_17582d056c0b8a8dab1017d37497fe59_Out_3);
            float2 _Branch_1e152f3aac57448f8518bf2852c000c3_Out_3;
            Unity_Branch_float2(_Property_1ef12cf3201a938993fe6a7951b0e754_Out_0, (_Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2.xy), _TilingAndOffset_17582d056c0b8a8dab1017d37497fe59_Out_3, _Branch_1e152f3aac57448f8518bf2852c000c3_Out_3);
            float4 _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0 = SAMPLE_TEXTURE2D(_Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0.tex, _Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0.samplerstate, _Branch_1e152f3aac57448f8518bf2852c000c3_Out_3);
            _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0);
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.r;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.g;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.b;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_A_7 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.a;
            float2 _Vector2_ad6bd100e273d78fa409a30a77bfa2cc_Out_0 = float2(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4, _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5);
            float3 _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1;
            Unity_Sign_float3(IN.WorldSpaceNormal, _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1);
            float _Split_6299d4ddcc4c74828aea40a46fdb896e_R_1 = _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1[0];
            float _Split_6299d4ddcc4c74828aea40a46fdb896e_G_2 = _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1[1];
            float _Split_6299d4ddcc4c74828aea40a46fdb896e_B_3 = _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1[2];
            float _Split_6299d4ddcc4c74828aea40a46fdb896e_A_4 = 0;
            float2 _Vector2_b76cb1842101e58b9e636d49b075c612_Out_0 = float2(_Split_6299d4ddcc4c74828aea40a46fdb896e_G_2, 1);
            float2 _Multiply_31e8db88ee20c985a9850d1a58f3282b_Out_2;
            Unity_Multiply_float(_Vector2_ad6bd100e273d78fa409a30a77bfa2cc_Out_0, _Vector2_b76cb1842101e58b9e636d49b075c612_Out_0, _Multiply_31e8db88ee20c985a9850d1a58f3282b_Out_2);
            float _Split_5ed44bf2eca0868f81eb18100f49d1fa_R_1 = IN.WorldSpaceNormal[0];
            float _Split_5ed44bf2eca0868f81eb18100f49d1fa_G_2 = IN.WorldSpaceNormal[1];
            float _Split_5ed44bf2eca0868f81eb18100f49d1fa_B_3 = IN.WorldSpaceNormal[2];
            float _Split_5ed44bf2eca0868f81eb18100f49d1fa_A_4 = 0;
            float2 _Vector2_70e5837843f28b8b9d64cada3697bd5a_Out_0 = float2(_Split_5ed44bf2eca0868f81eb18100f49d1fa_R_1, _Split_5ed44bf2eca0868f81eb18100f49d1fa_B_3);
            float2 _Add_1145b2f896593d80aa864a34e6702562_Out_2;
            Unity_Add_float2(_Multiply_31e8db88ee20c985a9850d1a58f3282b_Out_2, _Vector2_70e5837843f28b8b9d64cada3697bd5a_Out_0, _Add_1145b2f896593d80aa864a34e6702562_Out_2);
            float _Split_2bc77ca2d17bd78cb2383770ce50b179_R_1 = _Add_1145b2f896593d80aa864a34e6702562_Out_2[0];
            float _Split_2bc77ca2d17bd78cb2383770ce50b179_G_2 = _Add_1145b2f896593d80aa864a34e6702562_Out_2[1];
            float _Split_2bc77ca2d17bd78cb2383770ce50b179_B_3 = 0;
            float _Split_2bc77ca2d17bd78cb2383770ce50b179_A_4 = 0;
            float _Multiply_ab12aea87465a78eaf7fc66c2598d266_Out_2;
            Unity_Multiply_float(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6, _Split_5ed44bf2eca0868f81eb18100f49d1fa_G_2, _Multiply_ab12aea87465a78eaf7fc66c2598d266_Out_2);
            float3 _Vector3_433840b555db308b97e9b14b6a957195_Out_0 = float3(_Split_2bc77ca2d17bd78cb2383770ce50b179_R_1, _Multiply_ab12aea87465a78eaf7fc66c2598d266_Out_2, _Split_2bc77ca2d17bd78cb2383770ce50b179_G_2);
            float3x3 Transform_c7914cc45a011c89b3f53c55afb51673_tangentTransform_World = float3x3(IN.WorldSpaceTangent, IN.WorldSpaceBiTangent, IN.WorldSpaceNormal);
            float3 _Transform_c7914cc45a011c89b3f53c55afb51673_Out_1 = TransformWorldToTangent(_Vector3_433840b555db308b97e9b14b6a957195_Out_0.xyz, Transform_c7914cc45a011c89b3f53c55afb51673_tangentTransform_World);
            float3 _Normalize_09bf8a2bd0a4d38e8b97d5c674f79b44_Out_1;
            Unity_Normalize_float3(_Transform_c7914cc45a011c89b3f53c55afb51673_Out_1, _Normalize_09bf8a2bd0a4d38e8b97d5c674f79b44_Out_1);
            float3 _Branch_9eadf909a90f2f80880f8c56ecc2a91f_Out_3;
            Unity_Branch_float3(_Property_1ef12cf3201a938993fe6a7951b0e754_Out_0, _Normalize_09bf8a2bd0a4d38e8b97d5c674f79b44_Out_1, (_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.xyz), _Branch_9eadf909a90f2f80880f8c56ecc2a91f_Out_3);
            XZ_2 = (float4(_Branch_9eadf909a90f2f80880f8c56ecc2a91f_Out_3, 1.0));
        }

        void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
        {
            Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
        }

        struct Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6
        {
            float3 AbsoluteWorldSpacePosition;
            half4 uv0;
        };

        void SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(UnityTexture2D Texture2D_80A3D28F, float4 Vector4_2EBA7A3B, float Boolean_7ABB9909, Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 IN, out float4 XZ_2)
        {
            UnityTexture2D _Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0 = Texture2D_80A3D28F;
            float _Property_30834f691775a0898a45b1c868520436_Out_0 = Boolean_7ABB9909;
            float _Split_89ed63cb625cb3878c183d0b71c03400_R_1 = IN.AbsoluteWorldSpacePosition[0];
            float _Split_89ed63cb625cb3878c183d0b71c03400_G_2 = IN.AbsoluteWorldSpacePosition[1];
            float _Split_89ed63cb625cb3878c183d0b71c03400_B_3 = IN.AbsoluteWorldSpacePosition[2];
            float _Split_89ed63cb625cb3878c183d0b71c03400_A_4 = 0;
            float4 _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4;
            float3 _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5;
            float2 _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6;
            Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_B_3, 0, 0, _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5, _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6);
            float4 _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0 = Vector4_2EBA7A3B;
            float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[0];
            float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_G_2 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[1];
            float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_B_3 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[2];
            float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_A_4 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[3];
            float _Divide_e64179199923c58289b6aa94ea6c9178_Out_2;
            Unity_Divide_float(1, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1, _Divide_e64179199923c58289b6aa94ea6c9178_Out_2);
            float4 _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2;
            Unity_Multiply_float(_Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, (_Divide_e64179199923c58289b6aa94ea6c9178_Out_2.xxxx), _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2);
            float2 _Vector2_16c15d3bbdd14b85bd48e3a6cb318af7_Out_0 = float2(_Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_G_2);
            float2 _Vector2_f8d75f54e7705083bbec539a60185577_Out_0 = float2(_Split_2f0f52f6ef8c0e81af0da6476402bc1f_B_3, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_A_4);
            float2 _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_16c15d3bbdd14b85bd48e3a6cb318af7_Out_0, _Vector2_f8d75f54e7705083bbec539a60185577_Out_0, _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3);
            float2 _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3;
            Unity_Branch_float2(_Property_30834f691775a0898a45b1c868520436_Out_0, (_Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2.xy), _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3, _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3);
            float4 _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0 = SAMPLE_TEXTURE2D(_Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0.tex, _Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0.samplerstate, _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3);
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.r;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.g;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.b;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_A_7 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.a;
            XZ_2 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0;
        }

        void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
        {
            Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
        }

        void Unity_OneMinus_float(float In, out float Out)
        {
            Out = 1 - In;
        }

        void Unity_Branch_float(float Predicate, float True, float False, out float Out)
        {
            Out = Predicate ? True : False;
        }

        void Unity_Maximum_float(float A, float B, out float Out)
        {
            Out = max(A, B);
        }

        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }

        void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }

        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }

        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }

        void Unity_Divide_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A / B;
        }

        struct Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135
        {
        };

        void SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135(float3 Vector3_88EEBB5E, float Vector1_DA0A37FA, float3 Vector3_79AA92F, float Vector1_F7E83F1E, float Vector1_1C9222A6, Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 IN, out float3 OutVector4_1)
        {
            float3 _Property_dd1c841a04c03f8c85e7b00eb025ecda_Out_0 = Vector3_88EEBB5E;
            float _Property_14119cc7eaf4128f991283d47cf72d85_Out_0 = Vector1_DA0A37FA;
            float _Property_48af0ad45e3f7f82932b938695d21391_Out_0 = Vector1_DA0A37FA;
            float _Property_8a30b3ca12ff518fa473ccd686c7d503_Out_0 = Vector1_F7E83F1E;
            float _Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2;
            Unity_Maximum_float(_Property_48af0ad45e3f7f82932b938695d21391_Out_0, _Property_8a30b3ca12ff518fa473ccd686c7d503_Out_0, _Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2);
            float _Property_ee8d5fc69475d181be60c57e04ea8708_Out_0 = Vector1_1C9222A6;
            float _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2;
            Unity_Subtract_float(_Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2, _Property_ee8d5fc69475d181be60c57e04ea8708_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2);
            float _Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2;
            Unity_Subtract_float(_Property_14119cc7eaf4128f991283d47cf72d85_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2, _Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2);
            float _Maximum_d02e48d92038448cb0345e5cf3779071_Out_2;
            Unity_Maximum_float(_Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2, 0, _Maximum_d02e48d92038448cb0345e5cf3779071_Out_2);
            float3 _Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2;
            Unity_Multiply_float(_Property_dd1c841a04c03f8c85e7b00eb025ecda_Out_0, (_Maximum_d02e48d92038448cb0345e5cf3779071_Out_2.xxx), _Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2);
            float3 _Property_c7292b3b08585f8c8670172b9a220bf0_Out_0 = Vector3_79AA92F;
            float _Property_5e920479576fad83ba1947728dcceab4_Out_0 = Vector1_F7E83F1E;
            float _Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2;
            Unity_Subtract_float(_Property_5e920479576fad83ba1947728dcceab4_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2, _Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2);
            float _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2;
            Unity_Maximum_float(_Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2, 0, _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2);
            float3 _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2;
            Unity_Multiply_float(_Property_c7292b3b08585f8c8670172b9a220bf0_Out_0, (_Maximum_216777d30802328eab607c8fe68ba3a1_Out_2.xxx), _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2);
            float3 _Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2;
            Unity_Add_float3(_Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2, _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2, _Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2);
            float _Add_356384b52728f583bd6e694bc1fc3738_Out_2;
            Unity_Add_float(_Maximum_d02e48d92038448cb0345e5cf3779071_Out_2, _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2, _Add_356384b52728f583bd6e694bc1fc3738_Out_2);
            float _Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2;
            Unity_Maximum_float(_Add_356384b52728f583bd6e694bc1fc3738_Out_2, 1E-05, _Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2);
            float3 _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2;
            Unity_Divide_float3(_Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2, (_Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2.xxx), _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2);
            OutVector4_1 = _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2;
        }

        void Unity_Clamp_float(float In, float Min, float Max, out float Out)
        {
            Out = clamp(In, Min, Max);
        }

        void Unity_Absolute_float(float In, out float Out)
        {
            Out = abs(In);
        }

        void Unity_Power_float(float A, float B, out float Out)
        {
            Out = pow(A, B);
        }

        void Unity_Saturate_float(float In, out float Out)
        {
            Out = saturate(In);
        }

        void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
        {
            Out = lerp(A, B, T);
        }

        void Unity_Lerp_float(float A, float B, float T, out float Out)
        {
            Out = lerp(A, B, T);
        }

            // Graph Vertex
            struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };

        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }

            // Graph Pixel
            struct SurfaceDescription
        {
            float3 NormalTS;
            float Alpha;
            float AlphaClipThreshold;
        };

        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_7c7049e15fdff386b535790d8666f609_Out_0 = UnityBuildTexture2DStructNoScale(_BaseNormalMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0 = _BaseTilingOffset;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_7f998178363b4188ba2f07298ef869c1_Out_0 = _BaseUsePlanarUV;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8;
            _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.WorldSpaceNormal = IN.WorldSpaceNormal;
            _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.WorldSpaceTangent = IN.WorldSpaceTangent;
            _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
            _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.uv0 = IN.uv0;
            float4 _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8_XZ_2;
            SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(_Property_7c7049e15fdff386b535790d8666f609_Out_0, _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0, _Property_7f998178363b4188ba2f07298ef869c1_Out_0, _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8, _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_d4b0759cf4647e81be065ec1465ce2b4_Out_0 = _BaseNormalScale;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _NormalStrength_f66a9108ea294886acc61513b41cc5e4_Out_2;
            Unity_NormalStrength_float((_PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8_XZ_2.xyz), _Property_d4b0759cf4647e81be065ec1465ce2b4_Out_0, _NormalStrength_f66a9108ea294886acc61513b41cc5e4_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_1e449ff9f8e8ec828507233e8240eb11_Out_0 = UnityBuildTexture2DStructNoScale(_BaseMaskMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_4245c3b264047180b5c90a697d6cb278;
            _PlanarNM_4245c3b264047180b5c90a697d6cb278.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNM_4245c3b264047180b5c90a697d6cb278.uv0 = IN.uv0;
            float4 _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2;
            SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(_Property_1e449ff9f8e8ec828507233e8240eb11_Out_0, _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0, _Property_7f998178363b4188ba2f07298ef869c1_Out_0, _PlanarNM_4245c3b264047180b5c90a697d6cb278, _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_91a015dea8acd38b904ba0935328a5bc_R_1 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[0];
            float _Split_91a015dea8acd38b904ba0935328a5bc_G_2 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[1];
            float _Split_91a015dea8acd38b904ba0935328a5bc_B_3 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[2];
            float _Split_91a015dea8acd38b904ba0935328a5bc_A_4 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_fbcff1469ebf488394a8a89ddaf0eb2a_Out_0 = _HeightMin;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_9df7a44c8225168683743ac60c0c3c34_Out_0 = _HeightMax;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_9b1e95888c28bc8893f28c02b87fa448_Out_0 = float2(_Property_fbcff1469ebf488394a8a89ddaf0eb2a_Out_0, _Property_9df7a44c8225168683743ac60c0c3c34_Out_0);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_29ca14fd0b712983a38d63d2dd326e96_Out_0 = _HeightOffset;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Add_cb503f8a09720d84bb03cbd89e37b80c_Out_2;
            Unity_Add_float2(_Vector2_9b1e95888c28bc8893f28c02b87fa448_Out_0, (_Property_29ca14fd0b712983a38d63d2dd326e96_Out_0.xx), _Add_cb503f8a09720d84bb03cbd89e37b80c_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3;
            Unity_Remap_float(_Split_91a015dea8acd38b904ba0935328a5bc_B_3, float2 (0, 1), _Add_cb503f8a09720d84bb03cbd89e37b80c_Out_2, _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_fa9f7890b20ad481a92543c04b237bde_Out_0 = UnityBuildTexture2DStructNoScale(_Base2NormalMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_86a4657df480d48e8d3ad3b036731380_Out_0 = _Base2TilingOffset;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0 = _Base2UsePlanarUV;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf;
            _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.WorldSpaceNormal = IN.WorldSpaceNormal;
            _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.WorldSpaceTangent = IN.WorldSpaceTangent;
            _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
            _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.uv0 = IN.uv0;
            float4 _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf_XZ_2;
            SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(_Property_fa9f7890b20ad481a92543c04b237bde_Out_0, _Property_86a4657df480d48e8d3ad3b036731380_Out_0, _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0, _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf, _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_8c31443b776727819a663c7ddce79064_Out_0 = _Base2NormalScale;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _NormalStrength_0fb86880ab8e368dac6d01b830e20ed8_Out_2;
            Unity_NormalStrength_float((_PlanarNMn_d7b3ec528088a085a5102e025a1b45cf_XZ_2.xyz), _Property_8c31443b776727819a663c7ddce79064_Out_0, _NormalStrength_0fb86880ab8e368dac6d01b830e20ed8_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_c34b73d933404283983f9c8bdb5365d3_R_1 = IN.VertexColor[0];
            float _Split_c34b73d933404283983f9c8bdb5365d3_G_2 = IN.VertexColor[1];
            float _Split_c34b73d933404283983f9c8bdb5365d3_B_3 = IN.VertexColor[2];
            float _Split_c34b73d933404283983f9c8bdb5365d3_A_4 = IN.VertexColor[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_df2df7bb5cfc3381beee7ec454da7542_Out_0 = _Invert_Layer_Mask;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_c7b1e2df9f9b0e8eace9b2274924e69c_Out_0 = UnityBuildTexture2DStructNoScale(_LayerMask);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0 = SAMPLE_TEXTURE2D(_Property_c7b1e2df9f9b0e8eace9b2274924e69c_Out_0.tex, _Property_c7b1e2df9f9b0e8eace9b2274924e69c_Out_0.samplerstate, IN.uv0.xy);
            float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.r;
            float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_G_5 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.g;
            float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_B_6 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.b;
            float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_A_7 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1;
            Unity_OneMinus_float(_SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4, _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Branch_af0c5e511241ce8eae748ae487df50fa_Out_3;
            Unity_Branch_float(_Property_df2df7bb5cfc3381beee7ec454da7542_Out_0, _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1, _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4, _Branch_af0c5e511241ce8eae748ae487df50fa_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_de4f6eb48a629285a664dad7fb06438f_Out_0 = UnityBuildTexture2DStructNoScale(_Base2MaskMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_d5657f470f05ef839e4c257a20ace8cb;
            _PlanarNM_d5657f470f05ef839e4c257a20ace8cb.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNM_d5657f470f05ef839e4c257a20ace8cb.uv0 = IN.uv0;
            float4 _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2;
            SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(_Property_de4f6eb48a629285a664dad7fb06438f_Out_0, _Property_86a4657df480d48e8d3ad3b036731380_Out_0, _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0, _PlanarNM_d5657f470f05ef839e4c257a20ace8cb, _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_83ec66b648ab6c84848b42686c256cd7_R_1 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[0];
            float _Split_83ec66b648ab6c84848b42686c256cd7_G_2 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[1];
            float _Split_83ec66b648ab6c84848b42686c256cd7_B_3 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[2];
            float _Split_83ec66b648ab6c84848b42686c256cd7_A_4 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_ce1750e5c69e97818667b412fc3f9f2c_Out_0 = _HeightMin2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_8e0f2ea54d8ede89bbabdf31a9bafd57_Out_0 = _HeightMax2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_fb6c6dd7e70e768ba686e8e94153bb96_Out_0 = float2(_Property_ce1750e5c69e97818667b412fc3f9f2c_Out_0, _Property_8e0f2ea54d8ede89bbabdf31a9bafd57_Out_0);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_151ae2702b614585af2000f0a812960f_Out_0 = _HeightOffset2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2;
            Unity_Add_float2(_Vector2_fb6c6dd7e70e768ba686e8e94153bb96_Out_0, (_Property_151ae2702b614585af2000f0a812960f_Out_0.xx), _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3;
            Unity_Remap_float(_Split_83ec66b648ab6c84848b42686c256cd7_B_3, float2 (0, 1), _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2, _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2;
            Unity_Multiply_float(_Branch_af0c5e511241ce8eae748ae487df50fa_Out_3, _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3, _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2;
            Unity_Multiply_float(_Split_c34b73d933404283983f9c8bdb5365d3_R_1, _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2, _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_818c8af4b930138e81034c886614171d_Out_0 = _Height_Transition;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 _HeightBlend_7c09d97625efce898e21b66cd039be8b;
            float3 _HeightBlend_7c09d97625efce898e21b66cd039be8b_OutVector4_1;
            SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135(_NormalStrength_f66a9108ea294886acc61513b41cc5e4_Out_2, _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3, _NormalStrength_0fb86880ab8e368dac6d01b830e20ed8_Out_2, _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2, _Property_818c8af4b930138e81034c886614171d_Out_0, _HeightBlend_7c09d97625efce898e21b66cd039be8b, _HeightBlend_7c09d97625efce898e21b66cd039be8b_OutVector4_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_65f7dd6fe6c29b83913af586c597a1ef_Out_0 = UnityBuildTexture2DStructNoScale(_CoverNormalMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_822489d2e6d3e08590c64f085ffd9b2e_Out_0 = _CoverTilingOffset;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_2ae4a163bd21d98789af282d6e469175_Out_0 = _CoverUsePlanarUV;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3;
            _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3.WorldSpaceNormal = IN.WorldSpaceNormal;
            _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3.WorldSpaceTangent = IN.WorldSpaceTangent;
            _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
            _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3.uv0 = IN.uv0;
            float4 _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3_XZ_2;
            SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(_Property_65f7dd6fe6c29b83913af586c597a1ef_Out_0, _Property_822489d2e6d3e08590c64f085ffd9b2e_Out_0, _Property_2ae4a163bd21d98789af282d6e469175_Out_0, _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3, _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_7b9efcab84158389b4a4ea1e24b5601a_Out_0 = _CoverNormalScale;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _NormalStrength_8f42544d1b3ae08092fb1812b8119cfa_Out_2;
            Unity_NormalStrength_float((_PlanarNMn_248bc5b7421d3f828d166902c73ca6c3_XZ_2.xyz), _Property_7b9efcab84158389b4a4ea1e24b5601a_Out_0, _NormalStrength_8f42544d1b3ae08092fb1812b8119cfa_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_c0d223db25424a8ab0cee2de2bbf58ce_Out_0 = UnityBuildTexture2DStructNoScale(_CoverMaskA);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _UV_5352c8dd0add178ba83a5421c2c0b3f0_Out_0 = IN.uv0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _SampleTexture2D_024ba490c015248988a12a9d670014ea_RGBA_0 = SAMPLE_TEXTURE2D(_Property_c0d223db25424a8ab0cee2de2bbf58ce_Out_0.tex, _Property_c0d223db25424a8ab0cee2de2bbf58ce_Out_0.samplerstate, (_UV_5352c8dd0add178ba83a5421c2c0b3f0_Out_0.xy));
            float _SampleTexture2D_024ba490c015248988a12a9d670014ea_R_4 = _SampleTexture2D_024ba490c015248988a12a9d670014ea_RGBA_0.r;
            float _SampleTexture2D_024ba490c015248988a12a9d670014ea_G_5 = _SampleTexture2D_024ba490c015248988a12a9d670014ea_RGBA_0.g;
            float _SampleTexture2D_024ba490c015248988a12a9d670014ea_B_6 = _SampleTexture2D_024ba490c015248988a12a9d670014ea_RGBA_0.b;
            float _SampleTexture2D_024ba490c015248988a12a9d670014ea_A_7 = _SampleTexture2D_024ba490c015248988a12a9d670014ea_RGBA_0.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_b80e7b96604b7c82bbf9bff4981fad76_Out_0 = _CoverMaskPower;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_abe410d256783480b1b58468bf78a882_Out_2;
            Unity_Multiply_float(_SampleTexture2D_024ba490c015248988a12a9d670014ea_A_7, _Property_b80e7b96604b7c82bbf9bff4981fad76_Out_0, _Multiply_abe410d256783480b1b58468bf78a882_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_a78f6f28770afd869adb9d12cd47370b_Out_3;
            Unity_Clamp_float(_Multiply_abe410d256783480b1b58468bf78a882_Out_2, 0, 1, _Clamp_a78f6f28770afd869adb9d12cd47370b_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_19f92cae42737480a95820c51d4ba124_Out_0 = _CoverNormalBlendHardness;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _NormalStrength_2c3488591b8345869feb25a3dee06c3f_Out_2;
            Unity_NormalStrength_float((_PlanarNMn_248bc5b7421d3f828d166902c73ca6c3_XZ_2.xyz), _Property_19f92cae42737480a95820c51d4ba124_Out_0, _NormalStrength_2c3488591b8345869feb25a3dee06c3f_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_96bfe9cb80ad308385c191d094b3d071_R_1 = IN.WorldSpaceNormal[0];
            float _Split_96bfe9cb80ad308385c191d094b3d071_G_2 = IN.WorldSpaceNormal[1];
            float _Split_96bfe9cb80ad308385c191d094b3d071_B_3 = IN.WorldSpaceNormal[2];
            float _Split_96bfe9cb80ad308385c191d094b3d071_A_4 = 0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_0dd796aae8cd9f878bef13ceac4fe3ec_Out_0 = _Cover_Amount;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_67285cdc688aa38d83f62d5bb095d597_Out_0 = _Cover_Amount_Grow_Speed;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Subtract_fcefec675e7536888eccf5574d921972_Out_2;
            Unity_Subtract_float(4, _Property_67285cdc688aa38d83f62d5bb095d597_Out_0, _Subtract_fcefec675e7536888eccf5574d921972_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Divide_1e25465528e612839a4ce1faedd89e7d_Out_2;
            Unity_Divide_float(_Property_0dd796aae8cd9f878bef13ceac4fe3ec_Out_0, _Subtract_fcefec675e7536888eccf5574d921972_Out_2, _Divide_1e25465528e612839a4ce1faedd89e7d_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Absolute_d20b810ffdec828ab74dd6692d82f01b_Out_1;
            Unity_Absolute_float(_Divide_1e25465528e612839a4ce1faedd89e7d_Out_2, _Absolute_d20b810ffdec828ab74dd6692d82f01b_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Power_181fbf47cfdb258da1fe0b72a450986f_Out_2;
            Unity_Power_float(_Absolute_d20b810ffdec828ab74dd6692d82f01b_Out_1, _Subtract_fcefec675e7536888eccf5574d921972_Out_2, _Power_181fbf47cfdb258da1fe0b72a450986f_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_11f62dba01f1a38c9e0a9972ccd19246_Out_3;
            Unity_Clamp_float(_Power_181fbf47cfdb258da1fe0b72a450986f_Out_2, 0, 2, _Clamp_11f62dba01f1a38c9e0a9972ccd19246_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_9810f6d76275cd8fbe5e3a02360b98a7_Out_2;
            Unity_Multiply_float(_Split_96bfe9cb80ad308385c191d094b3d071_G_2, _Clamp_11f62dba01f1a38c9e0a9972ccd19246_Out_3, _Multiply_9810f6d76275cd8fbe5e3a02360b98a7_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Saturate_a007c5f214685c87bf6ca3e64c06b488_Out_1;
            Unity_Saturate_float(_Multiply_9810f6d76275cd8fbe5e3a02360b98a7_Out_2, _Saturate_a007c5f214685c87bf6ca3e64c06b488_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_1b2b25b617fc508b9835f0309136fd00_Out_3;
            Unity_Clamp_float(_Split_96bfe9cb80ad308385c191d094b3d071_G_2, 0, 0.9999, _Clamp_1b2b25b617fc508b9835f0309136fd00_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_7b12276ea7a4538db6804507b30a830c_Out_0 = _Cover_Max_Angle;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Divide_54c523ff4b7acb858e9e368fd1e4d34a_Out_2;
            Unity_Divide_float(_Property_7b12276ea7a4538db6804507b30a830c_Out_0, 45, _Divide_54c523ff4b7acb858e9e368fd1e4d34a_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _OneMinus_6cf431985b651e8e9546ae6cb2d4d668_Out_1;
            Unity_OneMinus_float(_Divide_54c523ff4b7acb858e9e368fd1e4d34a_Out_2, _OneMinus_6cf431985b651e8e9546ae6cb2d4d668_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Subtract_4ef7b60aeab8d589bf2d2423737642bc_Out_2;
            Unity_Subtract_float(_Clamp_1b2b25b617fc508b9835f0309136fd00_Out_3, _OneMinus_6cf431985b651e8e9546ae6cb2d4d668_Out_1, _Subtract_4ef7b60aeab8d589bf2d2423737642bc_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_a4b51894ea17818c9a27bb533a2ebe74_Out_3;
            Unity_Clamp_float(_Subtract_4ef7b60aeab8d589bf2d2423737642bc_Out_2, 0, 2, _Clamp_a4b51894ea17818c9a27bb533a2ebe74_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Divide_c4196d4f02190b89ba827ccd4ae8a74d_Out_2;
            Unity_Divide_float(1, _Divide_54c523ff4b7acb858e9e368fd1e4d34a_Out_2, _Divide_c4196d4f02190b89ba827ccd4ae8a74d_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_ffc22433163d1184846ede424b44bcb2_Out_2;
            Unity_Multiply_float(_Clamp_a4b51894ea17818c9a27bb533a2ebe74_Out_3, _Divide_c4196d4f02190b89ba827ccd4ae8a74d_Out_2, _Multiply_ffc22433163d1184846ede424b44bcb2_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Absolute_c2e5757082de5d878d4c023806fb2108_Out_1;
            Unity_Absolute_float(_Multiply_ffc22433163d1184846ede424b44bcb2_Out_2, _Absolute_c2e5757082de5d878d4c023806fb2108_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_849d9f217c95f38c9d49ab251578d8d5_Out_0 = _CoverHardness;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Power_578546d66d69a5829b745ebba1279adf_Out_2;
            Unity_Power_float(_Absolute_c2e5757082de5d878d4c023806fb2108_Out_1, _Property_849d9f217c95f38c9d49ab251578d8d5_Out_0, _Power_578546d66d69a5829b745ebba1279adf_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_34d2d3aff4814e8e83d2894b3512c6c8_Out_0 = _Cover_Min_Height;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _OneMinus_474df64227f004849b34c68fe8df93f2_Out_1;
            Unity_OneMinus_float(_Property_34d2d3aff4814e8e83d2894b3512c6c8_Out_0, _OneMinus_474df64227f004849b34c68fe8df93f2_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_ee4d9dc934b3508397d5a3dece110ab0_R_1 = IN.AbsoluteWorldSpacePosition[0];
            float _Split_ee4d9dc934b3508397d5a3dece110ab0_G_2 = IN.AbsoluteWorldSpacePosition[1];
            float _Split_ee4d9dc934b3508397d5a3dece110ab0_B_3 = IN.AbsoluteWorldSpacePosition[2];
            float _Split_ee4d9dc934b3508397d5a3dece110ab0_A_4 = 0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Add_d6bc513aa82d918ea24e279f4353d971_Out_2;
            Unity_Add_float(_OneMinus_474df64227f004849b34c68fe8df93f2_Out_1, _Split_ee4d9dc934b3508397d5a3dece110ab0_G_2, _Add_d6bc513aa82d918ea24e279f4353d971_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Add_a6a61cb12180108c9e1364b90d2673e2_Out_2;
            Unity_Add_float(_Add_d6bc513aa82d918ea24e279f4353d971_Out_2, 1, _Add_a6a61cb12180108c9e1364b90d2673e2_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_1874fdd00cb9aa839d93ab8536e2414d_Out_3;
            Unity_Clamp_float(_Add_a6a61cb12180108c9e1364b90d2673e2_Out_2, 0, 1, _Clamp_1874fdd00cb9aa839d93ab8536e2414d_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_7b91fd6e21b46c85816c7b681307cbe4_Out_0 = _Cover_Min_Height_Blending;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Add_6dca9453f6a35e8185c4b8e9782db0a9_Out_2;
            Unity_Add_float(_Add_d6bc513aa82d918ea24e279f4353d971_Out_2, _Property_7b91fd6e21b46c85816c7b681307cbe4_Out_0, _Add_6dca9453f6a35e8185c4b8e9782db0a9_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Divide_83415a319ecfba83af914cbc5487b546_Out_2;
            Unity_Divide_float(_Add_6dca9453f6a35e8185c4b8e9782db0a9_Out_2, _Add_d6bc513aa82d918ea24e279f4353d971_Out_2, _Divide_83415a319ecfba83af914cbc5487b546_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _OneMinus_bf150b22fcad5a87b7c825c9c6cf1687_Out_1;
            Unity_OneMinus_float(_Divide_83415a319ecfba83af914cbc5487b546_Out_2, _OneMinus_bf150b22fcad5a87b7c825c9c6cf1687_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Add_86ff9fa850efbe8c80705d8266609dab_Out_2;
            Unity_Add_float(_OneMinus_bf150b22fcad5a87b7c825c9c6cf1687_Out_1, -0.5, _Add_86ff9fa850efbe8c80705d8266609dab_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_906e140f01222d8ba61252ec6ec9d6a4_Out_3;
            Unity_Clamp_float(_Add_86ff9fa850efbe8c80705d8266609dab_Out_2, 0, 1, _Clamp_906e140f01222d8ba61252ec6ec9d6a4_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Add_c1ec5849bf72f585a30b3e11a91ada52_Out_2;
            Unity_Add_float(_Clamp_1874fdd00cb9aa839d93ab8536e2414d_Out_3, _Clamp_906e140f01222d8ba61252ec6ec9d6a4_Out_3, _Add_c1ec5849bf72f585a30b3e11a91ada52_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_17a8a0cf209a038b9e9c7f5681cdd1fb_Out_3;
            Unity_Clamp_float(_Add_c1ec5849bf72f585a30b3e11a91ada52_Out_2, 0, 1, _Clamp_17a8a0cf209a038b9e9c7f5681cdd1fb_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_8c2759ac24a9b289b1e9610cfd161bb0_Out_2;
            Unity_Multiply_float(_Power_578546d66d69a5829b745ebba1279adf_Out_2, _Clamp_17a8a0cf209a038b9e9c7f5681cdd1fb_Out_3, _Multiply_8c2759ac24a9b289b1e9610cfd161bb0_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_1a723f136ec7fa8c957b5d29e03d3051_Out_2;
            Unity_Multiply_float(_Saturate_a007c5f214685c87bf6ca3e64c06b488_Out_1, _Multiply_8c2759ac24a9b289b1e9610cfd161bb0_Out_2, _Multiply_1a723f136ec7fa8c957b5d29e03d3051_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Lerp_d1c72e47b283948584479177786ae8d5_Out_3;
            Unity_Lerp_float3(_HeightBlend_7c09d97625efce898e21b66cd039be8b_OutVector4_1, _NormalStrength_2c3488591b8345869feb25a3dee06c3f_Out_2, (_Multiply_1a723f136ec7fa8c957b5d29e03d3051_Out_2.xxx), _Lerp_d1c72e47b283948584479177786ae8d5_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3x3 Transform_180fb403b53f318db002e8eba7616644_transposeTangent = transpose(float3x3(IN.WorldSpaceTangent, IN.WorldSpaceBiTangent, IN.WorldSpaceNormal));
            float3 _Transform_180fb403b53f318db002e8eba7616644_Out_1 = normalize(mul(Transform_180fb403b53f318db002e8eba7616644_transposeTangent, _Lerp_d1c72e47b283948584479177786ae8d5_Out_3.xyz).xyz);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_c9a2b4fb4f688b8ebfc1436535cd5ba4_R_1 = _Transform_180fb403b53f318db002e8eba7616644_Out_1[0];
            float _Split_c9a2b4fb4f688b8ebfc1436535cd5ba4_G_2 = _Transform_180fb403b53f318db002e8eba7616644_Out_1[1];
            float _Split_c9a2b4fb4f688b8ebfc1436535cd5ba4_B_3 = _Transform_180fb403b53f318db002e8eba7616644_Out_1[2];
            float _Split_c9a2b4fb4f688b8ebfc1436535cd5ba4_A_4 = 0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_4c7631d0688102819e6d388d624855a1_Out_2;
            Unity_Multiply_float(_Split_c9a2b4fb4f688b8ebfc1436535cd5ba4_G_2, _Clamp_11f62dba01f1a38c9e0a9972ccd19246_Out_3, _Multiply_4c7631d0688102819e6d388d624855a1_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_f2887eb409f6bb81ae4caad2b01b17f1_Out_2;
            Unity_Multiply_float(_Clamp_11f62dba01f1a38c9e0a9972ccd19246_Out_3, _Property_849d9f217c95f38c9d49ab251578d8d5_Out_0, _Multiply_f2887eb409f6bb81ae4caad2b01b17f1_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_2e348ed31331e78791b2b3130a009f30_Out_2;
            Unity_Multiply_float(_Multiply_f2887eb409f6bb81ae4caad2b01b17f1_Out_2, _Multiply_8c2759ac24a9b289b1e9610cfd161bb0_Out_2, _Multiply_2e348ed31331e78791b2b3130a009f30_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_622e54e9a77b08839c0954ce5715ad1c_Out_2;
            Unity_Multiply_float(_Multiply_4c7631d0688102819e6d388d624855a1_Out_2, _Multiply_2e348ed31331e78791b2b3130a009f30_Out_2, _Multiply_622e54e9a77b08839c0954ce5715ad1c_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_608db04fab7d768d9a8b5fb9cf0768e1_Out_0 = UnityBuildTexture2DStructNoScale(_CoverMaskMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e;
            _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e.uv0 = IN.uv0;
            float4 _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e_XZ_2;
            SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(_Property_608db04fab7d768d9a8b5fb9cf0768e1_Out_0, _Property_822489d2e6d3e08590c64f085ffd9b2e_Out_0, _Property_2ae4a163bd21d98789af282d6e469175_Out_0, _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e, _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_86ec1aefda4f9e8e82b79c6195b397b0_R_1 = _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e_XZ_2[0];
            float _Split_86ec1aefda4f9e8e82b79c6195b397b0_G_2 = _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e_XZ_2[1];
            float _Split_86ec1aefda4f9e8e82b79c6195b397b0_B_3 = _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e_XZ_2[2];
            float _Split_86ec1aefda4f9e8e82b79c6195b397b0_A_4 = _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e_XZ_2[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_c9c6897e00458b8f8aa07df49fa519bc_Out_0 = _CoverHeightMapMin;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_ab94650b8edd82828661fe99e3c0e849_Out_0 = _CoverHeightMapMax;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_fe489f7321f6568686816b9eecbc16d1_Out_0 = float2(_Property_c9c6897e00458b8f8aa07df49fa519bc_Out_0, _Property_ab94650b8edd82828661fe99e3c0e849_Out_0);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_c1ab40024cb83b87960e4327efbd997f_Out_0 = _CoverHeightMapOffset;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Add_4a359522fc231c83b55ef23f341b6fb3_Out_2;
            Unity_Add_float2(_Vector2_fe489f7321f6568686816b9eecbc16d1_Out_0, (_Property_c1ab40024cb83b87960e4327efbd997f_Out_0.xx), _Add_4a359522fc231c83b55ef23f341b6fb3_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Remap_5aee5b64d41562858dc7c42d8b748894_Out_3;
            Unity_Remap_float(_Split_86ec1aefda4f9e8e82b79c6195b397b0_B_3, float2 (0, 1), _Add_4a359522fc231c83b55ef23f341b6fb3_Out_2, _Remap_5aee5b64d41562858dc7c42d8b748894_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_f0228e1cfd9c858dbb36367f551733c4_Out_2;
            Unity_Multiply_float(_Multiply_622e54e9a77b08839c0954ce5715ad1c_Out_2, _Remap_5aee5b64d41562858dc7c42d8b748894_Out_3, _Multiply_f0228e1cfd9c858dbb36367f551733c4_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_bb4d60728db93b8a9af9635fa1d69891_Out_2;
            Unity_Multiply_float(_Split_c34b73d933404283983f9c8bdb5365d3_G_2, _Multiply_f0228e1cfd9c858dbb36367f551733c4_Out_2, _Multiply_bb4d60728db93b8a9af9635fa1d69891_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Saturate_9b052a9bb99eff89bb11bdc387a0c2fd_Out_1;
            Unity_Saturate_float(_Multiply_bb4d60728db93b8a9af9635fa1d69891_Out_2, _Saturate_9b052a9bb99eff89bb11bdc387a0c2fd_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_22fb8c1cfd28b687a991e101aa13ff5b_Out_2;
            Unity_Multiply_float(_Clamp_a78f6f28770afd869adb9d12cd47370b_Out_3, _Saturate_9b052a9bb99eff89bb11bdc387a0c2fd_Out_1, _Multiply_22fb8c1cfd28b687a991e101aa13ff5b_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #if defined(_USEDYNAMICCOVERTSTATICMASKF_ON)
            float _UseDynamicCoverTStaticMaskF_20dcbac2f16cf78ebd6fd1debcd7f281_Out_0 = _Multiply_22fb8c1cfd28b687a991e101aa13ff5b_Out_2;
            #else
            float _UseDynamicCoverTStaticMaskF_20dcbac2f16cf78ebd6fd1debcd7f281_Out_0 = _Clamp_a78f6f28770afd869adb9d12cd47370b_Out_3;
            #endif
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Lerp_18ca18da5861e688a3fb637172636eda_Out_3;
            Unity_Lerp_float3(_HeightBlend_7c09d97625efce898e21b66cd039be8b_OutVector4_1, _NormalStrength_8f42544d1b3ae08092fb1812b8119cfa_Out_2, (_UseDynamicCoverTStaticMaskF_20dcbac2f16cf78ebd6fd1debcd7f281_Out_0.xxx), _Lerp_18ca18da5861e688a3fb637172636eda_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_07d75b1d2628da808a2efb93a1d6219e_Out_0 = UnityBuildTexture2DStructNoScale(_BaseColorMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e;
            _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e.uv0 = IN.uv0;
            float4 _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2;
            SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(_Property_07d75b1d2628da808a2efb93a1d6219e_Out_0, _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0, _Property_7f998178363b4188ba2f07298ef869c1_Out_0, _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e, _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_b83097c58639858680bf43881a95b0af_Out_0 = _BaseColor;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2;
            Unity_Multiply_float(_PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2, _Property_b83097c58639858680bf43881a95b0af_Out_0, _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_c7a719bf7da79a8ea38d7311fd844f92_R_1 = _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2[0];
            float _Split_c7a719bf7da79a8ea38d7311fd844f92_G_2 = _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2[1];
            float _Split_c7a719bf7da79a8ea38d7311fd844f92_B_3 = _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2[2];
            float _Split_c7a719bf7da79a8ea38d7311fd844f92_A_4 = _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_7c5dae9b46c9e686b49e58fa996a104a_Out_0 = IgnoreBase2Alpha;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_ba3a5f4cba7d0a8fa288ffc8267d6c0e_Out_0 = UnityBuildTexture2DStructNoScale(_Base2ColorMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4;
            _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4.uv0 = IN.uv0;
            float4 _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4_XZ_2;
            SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(_Property_ba3a5f4cba7d0a8fa288ffc8267d6c0e_Out_0, _Property_86a4657df480d48e8d3ad3b036731380_Out_0, _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0, _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4, _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_3561b11b899bda8e855826445cf628aa_Out_0 = _Base2Color;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2;
            Unity_Multiply_float(_PlanarNM_5aeab444ca6fd78ea56a01215880a5a4_XZ_2, _Property_3561b11b899bda8e855826445cf628aa_Out_0, _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_e9060f5c0433ec889696d3e462f3229b_R_1 = _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2[0];
            float _Split_e9060f5c0433ec889696d3e462f3229b_G_2 = _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2[1];
            float _Split_e9060f5c0433ec889696d3e462f3229b_B_3 = _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2[2];
            float _Split_e9060f5c0433ec889696d3e462f3229b_A_4 = _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Branch_a7d7aece30fd9b8eb456d191fdd37a06_Out_3;
            Unity_Branch_float(_Property_7c5dae9b46c9e686b49e58fa996a104a_Out_0, _Split_c7a719bf7da79a8ea38d7311fd844f92_A_4, _Split_e9060f5c0433ec889696d3e462f3229b_A_4, _Branch_a7d7aece30fd9b8eb456d191fdd37a06_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Lerp_8692ca93f568998fbc97130b6dbc4556_Out_3;
            Unity_Lerp_float(_Split_c7a719bf7da79a8ea38d7311fd844f92_A_4, _Branch_a7d7aece30fd9b8eb456d191fdd37a06_Out_3, _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2, _Lerp_8692ca93f568998fbc97130b6dbc4556_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_0c8b7b55b9f82588ab2dcff09ee7a16d_Out_3;
            Unity_Clamp_float(_Lerp_8692ca93f568998fbc97130b6dbc4556_Out_3, 0, 1, _Clamp_0c8b7b55b9f82588ab2dcff09ee7a16d_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_6333dc4a6348088bb7281602ce6bff5f_Out_2;
            Unity_Multiply_float(_Clamp_0c8b7b55b9f82588ab2dcff09ee7a16d_Out_3, _Split_c34b73d933404283983f9c8bdb5365d3_A_4, _Multiply_6333dc4a6348088bb7281602ce6bff5f_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_9642b8fb7e32b18a91da1888c9bc375b_Out_3;
            Unity_Clamp_float(_Multiply_6333dc4a6348088bb7281602ce6bff5f_Out_2, 0, 1, _Clamp_9642b8fb7e32b18a91da1888c9bc375b_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_8bc98dd454a5508b9864a6ba09772356_Out_0 = _AlphaCutoff;
            #endif
            surface.NormalTS = _Lerp_18ca18da5861e688a3fb637172636eda_Out_3;
            surface.Alpha = _Clamp_9642b8fb7e32b18a91da1888c9bc375b_Out_3;
            surface.AlphaClipThreshold = _Property_8bc98dd454a5508b9864a6ba09772356_Out_0;
            return surface;
        }

            // --------------------------------------------------
            // Build Graph Inputs

            VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceNormal =           input.normalOS;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceTangent =          input.tangentOS.xyz;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpacePosition =         input.positionOS;
        #endif


            return output;
        }
            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 unnormalizedNormalWS = input.normalWS;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        const float renormFactor = 1.0 / length(unnormalizedNormalWS);
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // use bitangent on the fly like in hdrp
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // IMPORTANT! If we ever support Flip on double sided materials ensure bitangent and tangent are NOT flipped.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float crossSign = (input.tangentWS.w > 0.0 ? 1.0 : -1.0) * GetOddNegativeScale();
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 bitang = crossSign * cross(input.normalWS.xyz, input.tangentWS.xyz);
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceNormal =            renormFactor*input.normalWS.xyz;		// we want a unit length Normal Vector node in shader graph
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // to preserve mikktspace compliance we use same scale renormFactor as was used on the normal.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // This is explained in section 2.2 in "surface gradient based bump mapping framework"
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceTangent =           renormFactor*input.tangentWS.xyz;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceBiTangent =         renormFactor*bitang;
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(input.positionWS);
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.uv0 =                         input.texCoord0;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.VertexColor =                 input.color;
        #endif

        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

            return output;
        }

            // --------------------------------------------------
            // Main

            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/DepthNormalsOnlyPass.hlsl"

            ENDHLSL
        }
        Pass
        {
            Name "Meta"
            Tags
            {
                "LightMode" = "Meta"
            }

            // Render State
            Cull Off

            // Debug
            // <None>

            // --------------------------------------------------
            // Pass

            HLSLPROGRAM

            // Pragmas
            #pragma target 4.5
        #pragma exclude_renderers gles gles3 glcore
        #pragma vertex vert
        #pragma fragment frag

            // DotsInstancingOptions: <None>
            // HybridV1InjectedBuiltinProperties: <None>

            // Keywords
            #pragma shader_feature _ _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A
            #pragma shader_feature_local _ _USEDYNAMICCOVERTSTATICMASKF_ON

        #if defined(_USEDYNAMICCOVERTSTATICMASKF_ON)
            #define KEYWORD_PERMUTATION_0
        #else
            #define KEYWORD_PERMUTATION_1
        #endif


            // Defines
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _SURFACE_TYPE_TRANSPARENT 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _AlphaClip 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMALMAP 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMAL_DROPOFF_TS 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_NORMAL
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TANGENT
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TEXCOORD0
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TEXCOORD1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TEXCOORD2
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_COLOR
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_POSITION_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_NORMAL_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TANGENT_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TEXCOORD0
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_COLOR
        #endif

            #define FEATURES_GRAPH_VERTEX
            /* WARNING: $splice Could not find named fragment 'PassInstancing' */
            #define SHADERPASS SHADERPASS_META
            /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */

            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/MetaInput.hlsl"

            // --------------------------------------------------
            // Structs and Packing

            struct Attributes
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 positionOS : POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 normalOS : NORMAL;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 tangentOS : TANGENT;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 uv0 : TEXCOORD0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 uv1 : TEXCOORD1;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 uv2 : TEXCOORD2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 color : COLOR;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : INSTANCEID_SEMANTIC;
            #endif
            #endif
        };
        struct Varyings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 positionWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 normalWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 tangentWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 texCoord0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 color;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };
        struct SurfaceDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceBiTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 AbsoluteWorldSpacePosition;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 uv0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 VertexColor;
            #endif
        };
        struct VertexDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpacePosition;
            #endif
        };
        struct PackedVaryings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp0 : TEXCOORD0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp1 : TEXCOORD1;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 interp2 : TEXCOORD2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 interp3 : TEXCOORD3;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 interp4 : TEXCOORD4;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };

            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            output.positionCS = input.positionCS;
            output.interp0.xyz =  input.positionWS;
            output.interp1.xyz =  input.normalWS;
            output.interp2.xyzw =  input.tangentWS;
            output.interp3.xyzw =  input.texCoord0;
            output.interp4.xyzw =  input.color;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.positionWS = input.interp0.xyz;
            output.normalWS = input.interp1.xyz;
            output.tangentWS = input.interp2.xyzw;
            output.texCoord0 = input.interp3.xyzw;
            output.color = input.interp4.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        #endif

            // --------------------------------------------------
            // Graph

            // Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float _AlphaCutoff;
        float4 _BaseColor;
        float4 _BaseColorMap_TexelSize;
        float _BaseUsePlanarUV;
        float4 _BaseTilingOffset;
        float4 _BaseNormalMap_TexelSize;
        float _BaseNormalScale;
        float4 _BaseMaskMap_TexelSize;
        float _BaseMetallic;
        float _BaseAORemapMin;
        float _BaseAORemapMax;
        float _BaseSmoothnessRemapMin;
        float _BaseSmoothnessRemapMax;
        float4 _LayerMask_TexelSize;
        float _Invert_Layer_Mask;
        float _Height_Transition;
        float _HeightMin;
        float _HeightMax;
        float _HeightOffset;
        float _HeightMin2;
        float _HeightMax2;
        float _HeightOffset2;
        float IgnoreBase2Alpha;
        float4 _Base2Color;
        float4 _Base2ColorMap_TexelSize;
        float4 _Base2TilingOffset;
        float _Base2UsePlanarUV;
        float4 _Base2NormalMap_TexelSize;
        float _Base2NormalScale;
        float4 _Base2MaskMap_TexelSize;
        float _Base2Metallic;
        float _Base2SmoothnessRemapMin;
        float _Base2SmoothnessRemapMax;
        float _Base2AORemapMin;
        float _Base2AORemapMax;
        float4 _CoverMaskA_TexelSize;
        float _CoverMaskPower;
        float _Cover_Amount;
        float _Cover_Amount_Grow_Speed;
        float _Cover_Max_Angle;
        float _Cover_Min_Height;
        float _Cover_Min_Height_Blending;
        float4 _CoverBaseColor;
        float4 _CoverBaseColorMap_TexelSize;
        float4 _CoverTilingOffset;
        float _CoverUsePlanarUV;
        float4 _CoverNormalMap_TexelSize;
        float _CoverNormalScale;
        float _CoverNormalBlendHardness;
        float _CoverHardness;
        float _CoverHeightMapMin;
        float _CoverHeightMapMax;
        float _CoverHeightMapOffset;
        float4 _CoverMaskMap_TexelSize;
        float _CoverMetallic;
        float _CoverAORemapMin;
        float _CoverAORemapMax;
        float _CoverSmoothnessRemapMin;
        float _CoverSmoothnessRemapMax;
        CBUFFER_END

        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_BaseColorMap);
        SAMPLER(sampler_BaseColorMap);
        TEXTURE2D(_BaseNormalMap);
        SAMPLER(sampler_BaseNormalMap);
        TEXTURE2D(_BaseMaskMap);
        SAMPLER(sampler_BaseMaskMap);
        TEXTURE2D(_LayerMask);
        SAMPLER(sampler_LayerMask);
        TEXTURE2D(_Base2ColorMap);
        SAMPLER(sampler_Base2ColorMap);
        TEXTURE2D(_Base2NormalMap);
        SAMPLER(sampler_Base2NormalMap);
        TEXTURE2D(_Base2MaskMap);
        SAMPLER(sampler_Base2MaskMap);
        TEXTURE2D(_CoverMaskA);
        SAMPLER(sampler_CoverMaskA);
        TEXTURE2D(_CoverBaseColorMap);
        SAMPLER(sampler_CoverBaseColorMap);
        TEXTURE2D(_CoverNormalMap);
        SAMPLER(sampler_CoverNormalMap);
        TEXTURE2D(_CoverMaskMap);
        SAMPLER(sampler_CoverMaskMap);

            // Graph Functions
            
        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }

        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }

        void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }

        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }

        void Unity_Branch_float2(float Predicate, float2 True, float2 False, out float2 Out)
        {
            Out = Predicate ? True : False;
        }

        struct Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6
        {
            float3 AbsoluteWorldSpacePosition;
            half4 uv0;
        };

        void SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(UnityTexture2D Texture2D_80A3D28F, float4 Vector4_2EBA7A3B, float Boolean_7ABB9909, Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 IN, out float4 XZ_2)
        {
            UnityTexture2D _Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0 = Texture2D_80A3D28F;
            float _Property_30834f691775a0898a45b1c868520436_Out_0 = Boolean_7ABB9909;
            float _Split_89ed63cb625cb3878c183d0b71c03400_R_1 = IN.AbsoluteWorldSpacePosition[0];
            float _Split_89ed63cb625cb3878c183d0b71c03400_G_2 = IN.AbsoluteWorldSpacePosition[1];
            float _Split_89ed63cb625cb3878c183d0b71c03400_B_3 = IN.AbsoluteWorldSpacePosition[2];
            float _Split_89ed63cb625cb3878c183d0b71c03400_A_4 = 0;
            float4 _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4;
            float3 _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5;
            float2 _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6;
            Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_B_3, 0, 0, _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5, _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6);
            float4 _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0 = Vector4_2EBA7A3B;
            float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[0];
            float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_G_2 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[1];
            float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_B_3 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[2];
            float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_A_4 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[3];
            float _Divide_e64179199923c58289b6aa94ea6c9178_Out_2;
            Unity_Divide_float(1, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1, _Divide_e64179199923c58289b6aa94ea6c9178_Out_2);
            float4 _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2;
            Unity_Multiply_float(_Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, (_Divide_e64179199923c58289b6aa94ea6c9178_Out_2.xxxx), _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2);
            float2 _Vector2_16c15d3bbdd14b85bd48e3a6cb318af7_Out_0 = float2(_Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_G_2);
            float2 _Vector2_f8d75f54e7705083bbec539a60185577_Out_0 = float2(_Split_2f0f52f6ef8c0e81af0da6476402bc1f_B_3, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_A_4);
            float2 _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_16c15d3bbdd14b85bd48e3a6cb318af7_Out_0, _Vector2_f8d75f54e7705083bbec539a60185577_Out_0, _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3);
            float2 _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3;
            Unity_Branch_float2(_Property_30834f691775a0898a45b1c868520436_Out_0, (_Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2.xy), _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3, _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3);
            float4 _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0 = SAMPLE_TEXTURE2D(_Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0.tex, _Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0.samplerstate, _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3);
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.r;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.g;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.b;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_A_7 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.a;
            XZ_2 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0;
        }

        void Unity_Add_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A + B;
        }

        void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
        {
            Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
        }

        void Unity_OneMinus_float(float In, out float Out)
        {
            Out = 1 - In;
        }

        void Unity_Branch_float(float Predicate, float True, float False, out float Out)
        {
            Out = Predicate ? True : False;
        }

        void Unity_Multiply_float(float A, float B, out float Out)
        {
            Out = A * B;
        }

        void Unity_Maximum_float(float A, float B, out float Out)
        {
            Out = max(A, B);
        }

        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }

        void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }

        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }

        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }

        void Unity_Divide_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A / B;
        }

        struct Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135
        {
        };

        void SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135(float3 Vector3_88EEBB5E, float Vector1_DA0A37FA, float3 Vector3_79AA92F, float Vector1_F7E83F1E, float Vector1_1C9222A6, Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 IN, out float3 OutVector4_1)
        {
            float3 _Property_dd1c841a04c03f8c85e7b00eb025ecda_Out_0 = Vector3_88EEBB5E;
            float _Property_14119cc7eaf4128f991283d47cf72d85_Out_0 = Vector1_DA0A37FA;
            float _Property_48af0ad45e3f7f82932b938695d21391_Out_0 = Vector1_DA0A37FA;
            float _Property_8a30b3ca12ff518fa473ccd686c7d503_Out_0 = Vector1_F7E83F1E;
            float _Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2;
            Unity_Maximum_float(_Property_48af0ad45e3f7f82932b938695d21391_Out_0, _Property_8a30b3ca12ff518fa473ccd686c7d503_Out_0, _Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2);
            float _Property_ee8d5fc69475d181be60c57e04ea8708_Out_0 = Vector1_1C9222A6;
            float _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2;
            Unity_Subtract_float(_Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2, _Property_ee8d5fc69475d181be60c57e04ea8708_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2);
            float _Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2;
            Unity_Subtract_float(_Property_14119cc7eaf4128f991283d47cf72d85_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2, _Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2);
            float _Maximum_d02e48d92038448cb0345e5cf3779071_Out_2;
            Unity_Maximum_float(_Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2, 0, _Maximum_d02e48d92038448cb0345e5cf3779071_Out_2);
            float3 _Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2;
            Unity_Multiply_float(_Property_dd1c841a04c03f8c85e7b00eb025ecda_Out_0, (_Maximum_d02e48d92038448cb0345e5cf3779071_Out_2.xxx), _Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2);
            float3 _Property_c7292b3b08585f8c8670172b9a220bf0_Out_0 = Vector3_79AA92F;
            float _Property_5e920479576fad83ba1947728dcceab4_Out_0 = Vector1_F7E83F1E;
            float _Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2;
            Unity_Subtract_float(_Property_5e920479576fad83ba1947728dcceab4_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2, _Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2);
            float _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2;
            Unity_Maximum_float(_Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2, 0, _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2);
            float3 _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2;
            Unity_Multiply_float(_Property_c7292b3b08585f8c8670172b9a220bf0_Out_0, (_Maximum_216777d30802328eab607c8fe68ba3a1_Out_2.xxx), _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2);
            float3 _Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2;
            Unity_Add_float3(_Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2, _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2, _Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2);
            float _Add_356384b52728f583bd6e694bc1fc3738_Out_2;
            Unity_Add_float(_Maximum_d02e48d92038448cb0345e5cf3779071_Out_2, _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2, _Add_356384b52728f583bd6e694bc1fc3738_Out_2);
            float _Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2;
            Unity_Maximum_float(_Add_356384b52728f583bd6e694bc1fc3738_Out_2, 1E-05, _Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2);
            float3 _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2;
            Unity_Divide_float3(_Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2, (_Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2.xxx), _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2);
            OutVector4_1 = _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2;
        }

        void Unity_Clamp_float(float In, float Min, float Max, out float Out)
        {
            Out = clamp(In, Min, Max);
        }

        void Unity_Sign_float3(float3 In, out float3 Out)
        {
            Out = sign(In);
        }

        void Unity_Multiply_float(float2 A, float2 B, out float2 Out)
        {
            Out = A * B;
        }

        void Unity_Normalize_float3(float3 In, out float3 Out)
        {
            Out = normalize(In);
        }

        void Unity_Branch_float3(float Predicate, float3 True, float3 False, out float3 Out)
        {
            Out = Predicate ? True : False;
        }

        struct Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8
        {
            float3 WorldSpaceNormal;
            float3 WorldSpaceTangent;
            float3 WorldSpaceBiTangent;
            float3 AbsoluteWorldSpacePosition;
            half4 uv0;
        };

        void SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(UnityTexture2D Texture2D_80A3D28F, float4 Vector4_82674548, float Boolean_9FF42DF6, Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 IN, out float4 XZ_2)
        {
            float _Property_1ef12cf3201a938993fe6a7951b0e754_Out_0 = Boolean_9FF42DF6;
            UnityTexture2D _Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0 = Texture2D_80A3D28F;
            float _Split_89ed63cb625cb3878c183d0b71c03400_R_1 = IN.AbsoluteWorldSpacePosition[0];
            float _Split_89ed63cb625cb3878c183d0b71c03400_G_2 = IN.AbsoluteWorldSpacePosition[1];
            float _Split_89ed63cb625cb3878c183d0b71c03400_B_3 = IN.AbsoluteWorldSpacePosition[2];
            float _Split_89ed63cb625cb3878c183d0b71c03400_A_4 = 0;
            float4 _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4;
            float3 _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5;
            float2 _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6;
            Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_B_3, 0, 0, _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5, _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6);
            float4 _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0 = Vector4_82674548;
            float _Split_a2e12fa5931da084b2949343a539dfd8_R_1 = _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0[0];
            float _Split_a2e12fa5931da084b2949343a539dfd8_G_2 = _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0[1];
            float _Split_a2e12fa5931da084b2949343a539dfd8_B_3 = _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0[2];
            float _Split_a2e12fa5931da084b2949343a539dfd8_A_4 = _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0[3];
            float _Divide_c36b770dfaa0bb8f85ab27da5fd794f0_Out_2;
            Unity_Divide_float(1, _Split_a2e12fa5931da084b2949343a539dfd8_R_1, _Divide_c36b770dfaa0bb8f85ab27da5fd794f0_Out_2);
            float4 _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2;
            Unity_Multiply_float(_Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, (_Divide_c36b770dfaa0bb8f85ab27da5fd794f0_Out_2.xxxx), _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2);
            float2 _Vector2_6845d21872714d889783b0cb707df3e9_Out_0 = float2(_Split_a2e12fa5931da084b2949343a539dfd8_R_1, _Split_a2e12fa5931da084b2949343a539dfd8_G_2);
            float2 _Vector2_e2e2263627c6098e96a5b5d29350ad03_Out_0 = float2(_Split_a2e12fa5931da084b2949343a539dfd8_B_3, _Split_a2e12fa5931da084b2949343a539dfd8_A_4);
            float2 _TilingAndOffset_17582d056c0b8a8dab1017d37497fe59_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_6845d21872714d889783b0cb707df3e9_Out_0, _Vector2_e2e2263627c6098e96a5b5d29350ad03_Out_0, _TilingAndOffset_17582d056c0b8a8dab1017d37497fe59_Out_3);
            float2 _Branch_1e152f3aac57448f8518bf2852c000c3_Out_3;
            Unity_Branch_float2(_Property_1ef12cf3201a938993fe6a7951b0e754_Out_0, (_Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2.xy), _TilingAndOffset_17582d056c0b8a8dab1017d37497fe59_Out_3, _Branch_1e152f3aac57448f8518bf2852c000c3_Out_3);
            float4 _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0 = SAMPLE_TEXTURE2D(_Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0.tex, _Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0.samplerstate, _Branch_1e152f3aac57448f8518bf2852c000c3_Out_3);
            _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0);
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.r;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.g;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.b;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_A_7 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.a;
            float2 _Vector2_ad6bd100e273d78fa409a30a77bfa2cc_Out_0 = float2(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4, _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5);
            float3 _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1;
            Unity_Sign_float3(IN.WorldSpaceNormal, _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1);
            float _Split_6299d4ddcc4c74828aea40a46fdb896e_R_1 = _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1[0];
            float _Split_6299d4ddcc4c74828aea40a46fdb896e_G_2 = _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1[1];
            float _Split_6299d4ddcc4c74828aea40a46fdb896e_B_3 = _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1[2];
            float _Split_6299d4ddcc4c74828aea40a46fdb896e_A_4 = 0;
            float2 _Vector2_b76cb1842101e58b9e636d49b075c612_Out_0 = float2(_Split_6299d4ddcc4c74828aea40a46fdb896e_G_2, 1);
            float2 _Multiply_31e8db88ee20c985a9850d1a58f3282b_Out_2;
            Unity_Multiply_float(_Vector2_ad6bd100e273d78fa409a30a77bfa2cc_Out_0, _Vector2_b76cb1842101e58b9e636d49b075c612_Out_0, _Multiply_31e8db88ee20c985a9850d1a58f3282b_Out_2);
            float _Split_5ed44bf2eca0868f81eb18100f49d1fa_R_1 = IN.WorldSpaceNormal[0];
            float _Split_5ed44bf2eca0868f81eb18100f49d1fa_G_2 = IN.WorldSpaceNormal[1];
            float _Split_5ed44bf2eca0868f81eb18100f49d1fa_B_3 = IN.WorldSpaceNormal[2];
            float _Split_5ed44bf2eca0868f81eb18100f49d1fa_A_4 = 0;
            float2 _Vector2_70e5837843f28b8b9d64cada3697bd5a_Out_0 = float2(_Split_5ed44bf2eca0868f81eb18100f49d1fa_R_1, _Split_5ed44bf2eca0868f81eb18100f49d1fa_B_3);
            float2 _Add_1145b2f896593d80aa864a34e6702562_Out_2;
            Unity_Add_float2(_Multiply_31e8db88ee20c985a9850d1a58f3282b_Out_2, _Vector2_70e5837843f28b8b9d64cada3697bd5a_Out_0, _Add_1145b2f896593d80aa864a34e6702562_Out_2);
            float _Split_2bc77ca2d17bd78cb2383770ce50b179_R_1 = _Add_1145b2f896593d80aa864a34e6702562_Out_2[0];
            float _Split_2bc77ca2d17bd78cb2383770ce50b179_G_2 = _Add_1145b2f896593d80aa864a34e6702562_Out_2[1];
            float _Split_2bc77ca2d17bd78cb2383770ce50b179_B_3 = 0;
            float _Split_2bc77ca2d17bd78cb2383770ce50b179_A_4 = 0;
            float _Multiply_ab12aea87465a78eaf7fc66c2598d266_Out_2;
            Unity_Multiply_float(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6, _Split_5ed44bf2eca0868f81eb18100f49d1fa_G_2, _Multiply_ab12aea87465a78eaf7fc66c2598d266_Out_2);
            float3 _Vector3_433840b555db308b97e9b14b6a957195_Out_0 = float3(_Split_2bc77ca2d17bd78cb2383770ce50b179_R_1, _Multiply_ab12aea87465a78eaf7fc66c2598d266_Out_2, _Split_2bc77ca2d17bd78cb2383770ce50b179_G_2);
            float3x3 Transform_c7914cc45a011c89b3f53c55afb51673_tangentTransform_World = float3x3(IN.WorldSpaceTangent, IN.WorldSpaceBiTangent, IN.WorldSpaceNormal);
            float3 _Transform_c7914cc45a011c89b3f53c55afb51673_Out_1 = TransformWorldToTangent(_Vector3_433840b555db308b97e9b14b6a957195_Out_0.xyz, Transform_c7914cc45a011c89b3f53c55afb51673_tangentTransform_World);
            float3 _Normalize_09bf8a2bd0a4d38e8b97d5c674f79b44_Out_1;
            Unity_Normalize_float3(_Transform_c7914cc45a011c89b3f53c55afb51673_Out_1, _Normalize_09bf8a2bd0a4d38e8b97d5c674f79b44_Out_1);
            float3 _Branch_9eadf909a90f2f80880f8c56ecc2a91f_Out_3;
            Unity_Branch_float3(_Property_1ef12cf3201a938993fe6a7951b0e754_Out_0, _Normalize_09bf8a2bd0a4d38e8b97d5c674f79b44_Out_1, (_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.xyz), _Branch_9eadf909a90f2f80880f8c56ecc2a91f_Out_3);
            XZ_2 = (float4(_Branch_9eadf909a90f2f80880f8c56ecc2a91f_Out_3, 1.0));
        }

        void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
        {
            Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
        }

        void Unity_Absolute_float(float In, out float Out)
        {
            Out = abs(In);
        }

        void Unity_Power_float(float A, float B, out float Out)
        {
            Out = pow(A, B);
        }

        void Unity_Saturate_float(float In, out float Out)
        {
            Out = saturate(In);
        }

        void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
        {
            Out = lerp(A, B, T);
        }

        void Unity_Lerp_float(float A, float B, float T, out float Out)
        {
            Out = lerp(A, B, T);
        }

            // Graph Vertex
            struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };

        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }

            // Graph Pixel
            struct SurfaceDescription
        {
            float3 BaseColor;
            float3 Emission;
            float Alpha;
            float AlphaClipThreshold;
        };

        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_07d75b1d2628da808a2efb93a1d6219e_Out_0 = UnityBuildTexture2DStructNoScale(_BaseColorMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0 = _BaseTilingOffset;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_7f998178363b4188ba2f07298ef869c1_Out_0 = _BaseUsePlanarUV;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e;
            _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e.uv0 = IN.uv0;
            float4 _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2;
            SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(_Property_07d75b1d2628da808a2efb93a1d6219e_Out_0, _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0, _Property_7f998178363b4188ba2f07298ef869c1_Out_0, _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e, _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_b83097c58639858680bf43881a95b0af_Out_0 = _BaseColor;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2;
            Unity_Multiply_float(_PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2, _Property_b83097c58639858680bf43881a95b0af_Out_0, _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_1e449ff9f8e8ec828507233e8240eb11_Out_0 = UnityBuildTexture2DStructNoScale(_BaseMaskMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_4245c3b264047180b5c90a697d6cb278;
            _PlanarNM_4245c3b264047180b5c90a697d6cb278.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNM_4245c3b264047180b5c90a697d6cb278.uv0 = IN.uv0;
            float4 _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2;
            SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(_Property_1e449ff9f8e8ec828507233e8240eb11_Out_0, _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0, _Property_7f998178363b4188ba2f07298ef869c1_Out_0, _PlanarNM_4245c3b264047180b5c90a697d6cb278, _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_91a015dea8acd38b904ba0935328a5bc_R_1 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[0];
            float _Split_91a015dea8acd38b904ba0935328a5bc_G_2 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[1];
            float _Split_91a015dea8acd38b904ba0935328a5bc_B_3 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[2];
            float _Split_91a015dea8acd38b904ba0935328a5bc_A_4 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_fbcff1469ebf488394a8a89ddaf0eb2a_Out_0 = _HeightMin;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_9df7a44c8225168683743ac60c0c3c34_Out_0 = _HeightMax;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_9b1e95888c28bc8893f28c02b87fa448_Out_0 = float2(_Property_fbcff1469ebf488394a8a89ddaf0eb2a_Out_0, _Property_9df7a44c8225168683743ac60c0c3c34_Out_0);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_29ca14fd0b712983a38d63d2dd326e96_Out_0 = _HeightOffset;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Add_cb503f8a09720d84bb03cbd89e37b80c_Out_2;
            Unity_Add_float2(_Vector2_9b1e95888c28bc8893f28c02b87fa448_Out_0, (_Property_29ca14fd0b712983a38d63d2dd326e96_Out_0.xx), _Add_cb503f8a09720d84bb03cbd89e37b80c_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3;
            Unity_Remap_float(_Split_91a015dea8acd38b904ba0935328a5bc_B_3, float2 (0, 1), _Add_cb503f8a09720d84bb03cbd89e37b80c_Out_2, _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_ba3a5f4cba7d0a8fa288ffc8267d6c0e_Out_0 = UnityBuildTexture2DStructNoScale(_Base2ColorMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_86a4657df480d48e8d3ad3b036731380_Out_0 = _Base2TilingOffset;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0 = _Base2UsePlanarUV;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4;
            _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4.uv0 = IN.uv0;
            float4 _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4_XZ_2;
            SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(_Property_ba3a5f4cba7d0a8fa288ffc8267d6c0e_Out_0, _Property_86a4657df480d48e8d3ad3b036731380_Out_0, _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0, _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4, _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_3561b11b899bda8e855826445cf628aa_Out_0 = _Base2Color;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2;
            Unity_Multiply_float(_PlanarNM_5aeab444ca6fd78ea56a01215880a5a4_XZ_2, _Property_3561b11b899bda8e855826445cf628aa_Out_0, _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_c34b73d933404283983f9c8bdb5365d3_R_1 = IN.VertexColor[0];
            float _Split_c34b73d933404283983f9c8bdb5365d3_G_2 = IN.VertexColor[1];
            float _Split_c34b73d933404283983f9c8bdb5365d3_B_3 = IN.VertexColor[2];
            float _Split_c34b73d933404283983f9c8bdb5365d3_A_4 = IN.VertexColor[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_df2df7bb5cfc3381beee7ec454da7542_Out_0 = _Invert_Layer_Mask;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_c7b1e2df9f9b0e8eace9b2274924e69c_Out_0 = UnityBuildTexture2DStructNoScale(_LayerMask);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0 = SAMPLE_TEXTURE2D(_Property_c7b1e2df9f9b0e8eace9b2274924e69c_Out_0.tex, _Property_c7b1e2df9f9b0e8eace9b2274924e69c_Out_0.samplerstate, IN.uv0.xy);
            float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.r;
            float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_G_5 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.g;
            float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_B_6 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.b;
            float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_A_7 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1;
            Unity_OneMinus_float(_SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4, _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Branch_af0c5e511241ce8eae748ae487df50fa_Out_3;
            Unity_Branch_float(_Property_df2df7bb5cfc3381beee7ec454da7542_Out_0, _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1, _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4, _Branch_af0c5e511241ce8eae748ae487df50fa_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_de4f6eb48a629285a664dad7fb06438f_Out_0 = UnityBuildTexture2DStructNoScale(_Base2MaskMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_d5657f470f05ef839e4c257a20ace8cb;
            _PlanarNM_d5657f470f05ef839e4c257a20ace8cb.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNM_d5657f470f05ef839e4c257a20ace8cb.uv0 = IN.uv0;
            float4 _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2;
            SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(_Property_de4f6eb48a629285a664dad7fb06438f_Out_0, _Property_86a4657df480d48e8d3ad3b036731380_Out_0, _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0, _PlanarNM_d5657f470f05ef839e4c257a20ace8cb, _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_83ec66b648ab6c84848b42686c256cd7_R_1 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[0];
            float _Split_83ec66b648ab6c84848b42686c256cd7_G_2 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[1];
            float _Split_83ec66b648ab6c84848b42686c256cd7_B_3 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[2];
            float _Split_83ec66b648ab6c84848b42686c256cd7_A_4 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_ce1750e5c69e97818667b412fc3f9f2c_Out_0 = _HeightMin2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_8e0f2ea54d8ede89bbabdf31a9bafd57_Out_0 = _HeightMax2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_fb6c6dd7e70e768ba686e8e94153bb96_Out_0 = float2(_Property_ce1750e5c69e97818667b412fc3f9f2c_Out_0, _Property_8e0f2ea54d8ede89bbabdf31a9bafd57_Out_0);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_151ae2702b614585af2000f0a812960f_Out_0 = _HeightOffset2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2;
            Unity_Add_float2(_Vector2_fb6c6dd7e70e768ba686e8e94153bb96_Out_0, (_Property_151ae2702b614585af2000f0a812960f_Out_0.xx), _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3;
            Unity_Remap_float(_Split_83ec66b648ab6c84848b42686c256cd7_B_3, float2 (0, 1), _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2, _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2;
            Unity_Multiply_float(_Branch_af0c5e511241ce8eae748ae487df50fa_Out_3, _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3, _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2;
            Unity_Multiply_float(_Split_c34b73d933404283983f9c8bdb5365d3_R_1, _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2, _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_818c8af4b930138e81034c886614171d_Out_0 = _Height_Transition;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 _HeightBlend_7501025b3a60738a9a9d362e35a9ab48;
            float3 _HeightBlend_7501025b3a60738a9a9d362e35a9ab48_OutVector4_1;
            SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135((_Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2.xyz), _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3, (_Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2.xyz), _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2, _Property_818c8af4b930138e81034c886614171d_Out_0, _HeightBlend_7501025b3a60738a9a9d362e35a9ab48, _HeightBlend_7501025b3a60738a9a9d362e35a9ab48_OutVector4_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_c0ebdab0f71ace8aabaa865fd7293599_Out_0 = UnityBuildTexture2DStructNoScale(_CoverBaseColorMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_822489d2e6d3e08590c64f085ffd9b2e_Out_0 = _CoverTilingOffset;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_2ae4a163bd21d98789af282d6e469175_Out_0 = _CoverUsePlanarUV;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_8bb420494d19b28e9ccdff489802dc81;
            _PlanarNM_8bb420494d19b28e9ccdff489802dc81.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNM_8bb420494d19b28e9ccdff489802dc81.uv0 = IN.uv0;
            float4 _PlanarNM_8bb420494d19b28e9ccdff489802dc81_XZ_2;
            SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(_Property_c0ebdab0f71ace8aabaa865fd7293599_Out_0, _Property_822489d2e6d3e08590c64f085ffd9b2e_Out_0, _Property_2ae4a163bd21d98789af282d6e469175_Out_0, _PlanarNM_8bb420494d19b28e9ccdff489802dc81, _PlanarNM_8bb420494d19b28e9ccdff489802dc81_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_55e7941fa7ac5f8387aa9bb633b08883_Out_0 = _CoverBaseColor;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Multiply_a38ba695a2660c8691763f0bd7fe159c_Out_2;
            Unity_Multiply_float(_PlanarNM_8bb420494d19b28e9ccdff489802dc81_XZ_2, _Property_55e7941fa7ac5f8387aa9bb633b08883_Out_0, _Multiply_a38ba695a2660c8691763f0bd7fe159c_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_c0d223db25424a8ab0cee2de2bbf58ce_Out_0 = UnityBuildTexture2DStructNoScale(_CoverMaskA);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _UV_5352c8dd0add178ba83a5421c2c0b3f0_Out_0 = IN.uv0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _SampleTexture2D_024ba490c015248988a12a9d670014ea_RGBA_0 = SAMPLE_TEXTURE2D(_Property_c0d223db25424a8ab0cee2de2bbf58ce_Out_0.tex, _Property_c0d223db25424a8ab0cee2de2bbf58ce_Out_0.samplerstate, (_UV_5352c8dd0add178ba83a5421c2c0b3f0_Out_0.xy));
            float _SampleTexture2D_024ba490c015248988a12a9d670014ea_R_4 = _SampleTexture2D_024ba490c015248988a12a9d670014ea_RGBA_0.r;
            float _SampleTexture2D_024ba490c015248988a12a9d670014ea_G_5 = _SampleTexture2D_024ba490c015248988a12a9d670014ea_RGBA_0.g;
            float _SampleTexture2D_024ba490c015248988a12a9d670014ea_B_6 = _SampleTexture2D_024ba490c015248988a12a9d670014ea_RGBA_0.b;
            float _SampleTexture2D_024ba490c015248988a12a9d670014ea_A_7 = _SampleTexture2D_024ba490c015248988a12a9d670014ea_RGBA_0.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_b80e7b96604b7c82bbf9bff4981fad76_Out_0 = _CoverMaskPower;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_abe410d256783480b1b58468bf78a882_Out_2;
            Unity_Multiply_float(_SampleTexture2D_024ba490c015248988a12a9d670014ea_A_7, _Property_b80e7b96604b7c82bbf9bff4981fad76_Out_0, _Multiply_abe410d256783480b1b58468bf78a882_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_a78f6f28770afd869adb9d12cd47370b_Out_3;
            Unity_Clamp_float(_Multiply_abe410d256783480b1b58468bf78a882_Out_2, 0, 1, _Clamp_a78f6f28770afd869adb9d12cd47370b_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_7c7049e15fdff386b535790d8666f609_Out_0 = UnityBuildTexture2DStructNoScale(_BaseNormalMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8;
            _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.WorldSpaceNormal = IN.WorldSpaceNormal;
            _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.WorldSpaceTangent = IN.WorldSpaceTangent;
            _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
            _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.uv0 = IN.uv0;
            float4 _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8_XZ_2;
            SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(_Property_7c7049e15fdff386b535790d8666f609_Out_0, _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0, _Property_7f998178363b4188ba2f07298ef869c1_Out_0, _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8, _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_d4b0759cf4647e81be065ec1465ce2b4_Out_0 = _BaseNormalScale;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _NormalStrength_f66a9108ea294886acc61513b41cc5e4_Out_2;
            Unity_NormalStrength_float((_PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8_XZ_2.xyz), _Property_d4b0759cf4647e81be065ec1465ce2b4_Out_0, _NormalStrength_f66a9108ea294886acc61513b41cc5e4_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_fa9f7890b20ad481a92543c04b237bde_Out_0 = UnityBuildTexture2DStructNoScale(_Base2NormalMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf;
            _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.WorldSpaceNormal = IN.WorldSpaceNormal;
            _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.WorldSpaceTangent = IN.WorldSpaceTangent;
            _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
            _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.uv0 = IN.uv0;
            float4 _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf_XZ_2;
            SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(_Property_fa9f7890b20ad481a92543c04b237bde_Out_0, _Property_86a4657df480d48e8d3ad3b036731380_Out_0, _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0, _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf, _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_8c31443b776727819a663c7ddce79064_Out_0 = _Base2NormalScale;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _NormalStrength_0fb86880ab8e368dac6d01b830e20ed8_Out_2;
            Unity_NormalStrength_float((_PlanarNMn_d7b3ec528088a085a5102e025a1b45cf_XZ_2.xyz), _Property_8c31443b776727819a663c7ddce79064_Out_0, _NormalStrength_0fb86880ab8e368dac6d01b830e20ed8_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 _HeightBlend_7c09d97625efce898e21b66cd039be8b;
            float3 _HeightBlend_7c09d97625efce898e21b66cd039be8b_OutVector4_1;
            SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135(_NormalStrength_f66a9108ea294886acc61513b41cc5e4_Out_2, _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3, _NormalStrength_0fb86880ab8e368dac6d01b830e20ed8_Out_2, _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2, _Property_818c8af4b930138e81034c886614171d_Out_0, _HeightBlend_7c09d97625efce898e21b66cd039be8b, _HeightBlend_7c09d97625efce898e21b66cd039be8b_OutVector4_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_65f7dd6fe6c29b83913af586c597a1ef_Out_0 = UnityBuildTexture2DStructNoScale(_CoverNormalMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3;
            _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3.WorldSpaceNormal = IN.WorldSpaceNormal;
            _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3.WorldSpaceTangent = IN.WorldSpaceTangent;
            _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
            _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3.uv0 = IN.uv0;
            float4 _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3_XZ_2;
            SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(_Property_65f7dd6fe6c29b83913af586c597a1ef_Out_0, _Property_822489d2e6d3e08590c64f085ffd9b2e_Out_0, _Property_2ae4a163bd21d98789af282d6e469175_Out_0, _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3, _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_19f92cae42737480a95820c51d4ba124_Out_0 = _CoverNormalBlendHardness;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _NormalStrength_2c3488591b8345869feb25a3dee06c3f_Out_2;
            Unity_NormalStrength_float((_PlanarNMn_248bc5b7421d3f828d166902c73ca6c3_XZ_2.xyz), _Property_19f92cae42737480a95820c51d4ba124_Out_0, _NormalStrength_2c3488591b8345869feb25a3dee06c3f_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_96bfe9cb80ad308385c191d094b3d071_R_1 = IN.WorldSpaceNormal[0];
            float _Split_96bfe9cb80ad308385c191d094b3d071_G_2 = IN.WorldSpaceNormal[1];
            float _Split_96bfe9cb80ad308385c191d094b3d071_B_3 = IN.WorldSpaceNormal[2];
            float _Split_96bfe9cb80ad308385c191d094b3d071_A_4 = 0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_0dd796aae8cd9f878bef13ceac4fe3ec_Out_0 = _Cover_Amount;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_67285cdc688aa38d83f62d5bb095d597_Out_0 = _Cover_Amount_Grow_Speed;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Subtract_fcefec675e7536888eccf5574d921972_Out_2;
            Unity_Subtract_float(4, _Property_67285cdc688aa38d83f62d5bb095d597_Out_0, _Subtract_fcefec675e7536888eccf5574d921972_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Divide_1e25465528e612839a4ce1faedd89e7d_Out_2;
            Unity_Divide_float(_Property_0dd796aae8cd9f878bef13ceac4fe3ec_Out_0, _Subtract_fcefec675e7536888eccf5574d921972_Out_2, _Divide_1e25465528e612839a4ce1faedd89e7d_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Absolute_d20b810ffdec828ab74dd6692d82f01b_Out_1;
            Unity_Absolute_float(_Divide_1e25465528e612839a4ce1faedd89e7d_Out_2, _Absolute_d20b810ffdec828ab74dd6692d82f01b_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Power_181fbf47cfdb258da1fe0b72a450986f_Out_2;
            Unity_Power_float(_Absolute_d20b810ffdec828ab74dd6692d82f01b_Out_1, _Subtract_fcefec675e7536888eccf5574d921972_Out_2, _Power_181fbf47cfdb258da1fe0b72a450986f_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_11f62dba01f1a38c9e0a9972ccd19246_Out_3;
            Unity_Clamp_float(_Power_181fbf47cfdb258da1fe0b72a450986f_Out_2, 0, 2, _Clamp_11f62dba01f1a38c9e0a9972ccd19246_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_9810f6d76275cd8fbe5e3a02360b98a7_Out_2;
            Unity_Multiply_float(_Split_96bfe9cb80ad308385c191d094b3d071_G_2, _Clamp_11f62dba01f1a38c9e0a9972ccd19246_Out_3, _Multiply_9810f6d76275cd8fbe5e3a02360b98a7_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Saturate_a007c5f214685c87bf6ca3e64c06b488_Out_1;
            Unity_Saturate_float(_Multiply_9810f6d76275cd8fbe5e3a02360b98a7_Out_2, _Saturate_a007c5f214685c87bf6ca3e64c06b488_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_1b2b25b617fc508b9835f0309136fd00_Out_3;
            Unity_Clamp_float(_Split_96bfe9cb80ad308385c191d094b3d071_G_2, 0, 0.9999, _Clamp_1b2b25b617fc508b9835f0309136fd00_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_7b12276ea7a4538db6804507b30a830c_Out_0 = _Cover_Max_Angle;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Divide_54c523ff4b7acb858e9e368fd1e4d34a_Out_2;
            Unity_Divide_float(_Property_7b12276ea7a4538db6804507b30a830c_Out_0, 45, _Divide_54c523ff4b7acb858e9e368fd1e4d34a_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _OneMinus_6cf431985b651e8e9546ae6cb2d4d668_Out_1;
            Unity_OneMinus_float(_Divide_54c523ff4b7acb858e9e368fd1e4d34a_Out_2, _OneMinus_6cf431985b651e8e9546ae6cb2d4d668_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Subtract_4ef7b60aeab8d589bf2d2423737642bc_Out_2;
            Unity_Subtract_float(_Clamp_1b2b25b617fc508b9835f0309136fd00_Out_3, _OneMinus_6cf431985b651e8e9546ae6cb2d4d668_Out_1, _Subtract_4ef7b60aeab8d589bf2d2423737642bc_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_a4b51894ea17818c9a27bb533a2ebe74_Out_3;
            Unity_Clamp_float(_Subtract_4ef7b60aeab8d589bf2d2423737642bc_Out_2, 0, 2, _Clamp_a4b51894ea17818c9a27bb533a2ebe74_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Divide_c4196d4f02190b89ba827ccd4ae8a74d_Out_2;
            Unity_Divide_float(1, _Divide_54c523ff4b7acb858e9e368fd1e4d34a_Out_2, _Divide_c4196d4f02190b89ba827ccd4ae8a74d_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_ffc22433163d1184846ede424b44bcb2_Out_2;
            Unity_Multiply_float(_Clamp_a4b51894ea17818c9a27bb533a2ebe74_Out_3, _Divide_c4196d4f02190b89ba827ccd4ae8a74d_Out_2, _Multiply_ffc22433163d1184846ede424b44bcb2_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Absolute_c2e5757082de5d878d4c023806fb2108_Out_1;
            Unity_Absolute_float(_Multiply_ffc22433163d1184846ede424b44bcb2_Out_2, _Absolute_c2e5757082de5d878d4c023806fb2108_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_849d9f217c95f38c9d49ab251578d8d5_Out_0 = _CoverHardness;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Power_578546d66d69a5829b745ebba1279adf_Out_2;
            Unity_Power_float(_Absolute_c2e5757082de5d878d4c023806fb2108_Out_1, _Property_849d9f217c95f38c9d49ab251578d8d5_Out_0, _Power_578546d66d69a5829b745ebba1279adf_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_34d2d3aff4814e8e83d2894b3512c6c8_Out_0 = _Cover_Min_Height;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _OneMinus_474df64227f004849b34c68fe8df93f2_Out_1;
            Unity_OneMinus_float(_Property_34d2d3aff4814e8e83d2894b3512c6c8_Out_0, _OneMinus_474df64227f004849b34c68fe8df93f2_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_ee4d9dc934b3508397d5a3dece110ab0_R_1 = IN.AbsoluteWorldSpacePosition[0];
            float _Split_ee4d9dc934b3508397d5a3dece110ab0_G_2 = IN.AbsoluteWorldSpacePosition[1];
            float _Split_ee4d9dc934b3508397d5a3dece110ab0_B_3 = IN.AbsoluteWorldSpacePosition[2];
            float _Split_ee4d9dc934b3508397d5a3dece110ab0_A_4 = 0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Add_d6bc513aa82d918ea24e279f4353d971_Out_2;
            Unity_Add_float(_OneMinus_474df64227f004849b34c68fe8df93f2_Out_1, _Split_ee4d9dc934b3508397d5a3dece110ab0_G_2, _Add_d6bc513aa82d918ea24e279f4353d971_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Add_a6a61cb12180108c9e1364b90d2673e2_Out_2;
            Unity_Add_float(_Add_d6bc513aa82d918ea24e279f4353d971_Out_2, 1, _Add_a6a61cb12180108c9e1364b90d2673e2_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_1874fdd00cb9aa839d93ab8536e2414d_Out_3;
            Unity_Clamp_float(_Add_a6a61cb12180108c9e1364b90d2673e2_Out_2, 0, 1, _Clamp_1874fdd00cb9aa839d93ab8536e2414d_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_7b91fd6e21b46c85816c7b681307cbe4_Out_0 = _Cover_Min_Height_Blending;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Add_6dca9453f6a35e8185c4b8e9782db0a9_Out_2;
            Unity_Add_float(_Add_d6bc513aa82d918ea24e279f4353d971_Out_2, _Property_7b91fd6e21b46c85816c7b681307cbe4_Out_0, _Add_6dca9453f6a35e8185c4b8e9782db0a9_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Divide_83415a319ecfba83af914cbc5487b546_Out_2;
            Unity_Divide_float(_Add_6dca9453f6a35e8185c4b8e9782db0a9_Out_2, _Add_d6bc513aa82d918ea24e279f4353d971_Out_2, _Divide_83415a319ecfba83af914cbc5487b546_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _OneMinus_bf150b22fcad5a87b7c825c9c6cf1687_Out_1;
            Unity_OneMinus_float(_Divide_83415a319ecfba83af914cbc5487b546_Out_2, _OneMinus_bf150b22fcad5a87b7c825c9c6cf1687_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Add_86ff9fa850efbe8c80705d8266609dab_Out_2;
            Unity_Add_float(_OneMinus_bf150b22fcad5a87b7c825c9c6cf1687_Out_1, -0.5, _Add_86ff9fa850efbe8c80705d8266609dab_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_906e140f01222d8ba61252ec6ec9d6a4_Out_3;
            Unity_Clamp_float(_Add_86ff9fa850efbe8c80705d8266609dab_Out_2, 0, 1, _Clamp_906e140f01222d8ba61252ec6ec9d6a4_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Add_c1ec5849bf72f585a30b3e11a91ada52_Out_2;
            Unity_Add_float(_Clamp_1874fdd00cb9aa839d93ab8536e2414d_Out_3, _Clamp_906e140f01222d8ba61252ec6ec9d6a4_Out_3, _Add_c1ec5849bf72f585a30b3e11a91ada52_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_17a8a0cf209a038b9e9c7f5681cdd1fb_Out_3;
            Unity_Clamp_float(_Add_c1ec5849bf72f585a30b3e11a91ada52_Out_2, 0, 1, _Clamp_17a8a0cf209a038b9e9c7f5681cdd1fb_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_8c2759ac24a9b289b1e9610cfd161bb0_Out_2;
            Unity_Multiply_float(_Power_578546d66d69a5829b745ebba1279adf_Out_2, _Clamp_17a8a0cf209a038b9e9c7f5681cdd1fb_Out_3, _Multiply_8c2759ac24a9b289b1e9610cfd161bb0_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_1a723f136ec7fa8c957b5d29e03d3051_Out_2;
            Unity_Multiply_float(_Saturate_a007c5f214685c87bf6ca3e64c06b488_Out_1, _Multiply_8c2759ac24a9b289b1e9610cfd161bb0_Out_2, _Multiply_1a723f136ec7fa8c957b5d29e03d3051_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Lerp_d1c72e47b283948584479177786ae8d5_Out_3;
            Unity_Lerp_float3(_HeightBlend_7c09d97625efce898e21b66cd039be8b_OutVector4_1, _NormalStrength_2c3488591b8345869feb25a3dee06c3f_Out_2, (_Multiply_1a723f136ec7fa8c957b5d29e03d3051_Out_2.xxx), _Lerp_d1c72e47b283948584479177786ae8d5_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3x3 Transform_180fb403b53f318db002e8eba7616644_transposeTangent = transpose(float3x3(IN.WorldSpaceTangent, IN.WorldSpaceBiTangent, IN.WorldSpaceNormal));
            float3 _Transform_180fb403b53f318db002e8eba7616644_Out_1 = normalize(mul(Transform_180fb403b53f318db002e8eba7616644_transposeTangent, _Lerp_d1c72e47b283948584479177786ae8d5_Out_3.xyz).xyz);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_c9a2b4fb4f688b8ebfc1436535cd5ba4_R_1 = _Transform_180fb403b53f318db002e8eba7616644_Out_1[0];
            float _Split_c9a2b4fb4f688b8ebfc1436535cd5ba4_G_2 = _Transform_180fb403b53f318db002e8eba7616644_Out_1[1];
            float _Split_c9a2b4fb4f688b8ebfc1436535cd5ba4_B_3 = _Transform_180fb403b53f318db002e8eba7616644_Out_1[2];
            float _Split_c9a2b4fb4f688b8ebfc1436535cd5ba4_A_4 = 0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_4c7631d0688102819e6d388d624855a1_Out_2;
            Unity_Multiply_float(_Split_c9a2b4fb4f688b8ebfc1436535cd5ba4_G_2, _Clamp_11f62dba01f1a38c9e0a9972ccd19246_Out_3, _Multiply_4c7631d0688102819e6d388d624855a1_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_f2887eb409f6bb81ae4caad2b01b17f1_Out_2;
            Unity_Multiply_float(_Clamp_11f62dba01f1a38c9e0a9972ccd19246_Out_3, _Property_849d9f217c95f38c9d49ab251578d8d5_Out_0, _Multiply_f2887eb409f6bb81ae4caad2b01b17f1_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_2e348ed31331e78791b2b3130a009f30_Out_2;
            Unity_Multiply_float(_Multiply_f2887eb409f6bb81ae4caad2b01b17f1_Out_2, _Multiply_8c2759ac24a9b289b1e9610cfd161bb0_Out_2, _Multiply_2e348ed31331e78791b2b3130a009f30_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_622e54e9a77b08839c0954ce5715ad1c_Out_2;
            Unity_Multiply_float(_Multiply_4c7631d0688102819e6d388d624855a1_Out_2, _Multiply_2e348ed31331e78791b2b3130a009f30_Out_2, _Multiply_622e54e9a77b08839c0954ce5715ad1c_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_608db04fab7d768d9a8b5fb9cf0768e1_Out_0 = UnityBuildTexture2DStructNoScale(_CoverMaskMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e;
            _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e.uv0 = IN.uv0;
            float4 _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e_XZ_2;
            SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(_Property_608db04fab7d768d9a8b5fb9cf0768e1_Out_0, _Property_822489d2e6d3e08590c64f085ffd9b2e_Out_0, _Property_2ae4a163bd21d98789af282d6e469175_Out_0, _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e, _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_86ec1aefda4f9e8e82b79c6195b397b0_R_1 = _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e_XZ_2[0];
            float _Split_86ec1aefda4f9e8e82b79c6195b397b0_G_2 = _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e_XZ_2[1];
            float _Split_86ec1aefda4f9e8e82b79c6195b397b0_B_3 = _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e_XZ_2[2];
            float _Split_86ec1aefda4f9e8e82b79c6195b397b0_A_4 = _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e_XZ_2[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_c9c6897e00458b8f8aa07df49fa519bc_Out_0 = _CoverHeightMapMin;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_ab94650b8edd82828661fe99e3c0e849_Out_0 = _CoverHeightMapMax;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_fe489f7321f6568686816b9eecbc16d1_Out_0 = float2(_Property_c9c6897e00458b8f8aa07df49fa519bc_Out_0, _Property_ab94650b8edd82828661fe99e3c0e849_Out_0);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_c1ab40024cb83b87960e4327efbd997f_Out_0 = _CoverHeightMapOffset;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Add_4a359522fc231c83b55ef23f341b6fb3_Out_2;
            Unity_Add_float2(_Vector2_fe489f7321f6568686816b9eecbc16d1_Out_0, (_Property_c1ab40024cb83b87960e4327efbd997f_Out_0.xx), _Add_4a359522fc231c83b55ef23f341b6fb3_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Remap_5aee5b64d41562858dc7c42d8b748894_Out_3;
            Unity_Remap_float(_Split_86ec1aefda4f9e8e82b79c6195b397b0_B_3, float2 (0, 1), _Add_4a359522fc231c83b55ef23f341b6fb3_Out_2, _Remap_5aee5b64d41562858dc7c42d8b748894_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_f0228e1cfd9c858dbb36367f551733c4_Out_2;
            Unity_Multiply_float(_Multiply_622e54e9a77b08839c0954ce5715ad1c_Out_2, _Remap_5aee5b64d41562858dc7c42d8b748894_Out_3, _Multiply_f0228e1cfd9c858dbb36367f551733c4_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_bb4d60728db93b8a9af9635fa1d69891_Out_2;
            Unity_Multiply_float(_Split_c34b73d933404283983f9c8bdb5365d3_G_2, _Multiply_f0228e1cfd9c858dbb36367f551733c4_Out_2, _Multiply_bb4d60728db93b8a9af9635fa1d69891_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Saturate_9b052a9bb99eff89bb11bdc387a0c2fd_Out_1;
            Unity_Saturate_float(_Multiply_bb4d60728db93b8a9af9635fa1d69891_Out_2, _Saturate_9b052a9bb99eff89bb11bdc387a0c2fd_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_22fb8c1cfd28b687a991e101aa13ff5b_Out_2;
            Unity_Multiply_float(_Clamp_a78f6f28770afd869adb9d12cd47370b_Out_3, _Saturate_9b052a9bb99eff89bb11bdc387a0c2fd_Out_1, _Multiply_22fb8c1cfd28b687a991e101aa13ff5b_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #if defined(_USEDYNAMICCOVERTSTATICMASKF_ON)
            float _UseDynamicCoverTStaticMaskF_20dcbac2f16cf78ebd6fd1debcd7f281_Out_0 = _Multiply_22fb8c1cfd28b687a991e101aa13ff5b_Out_2;
            #else
            float _UseDynamicCoverTStaticMaskF_20dcbac2f16cf78ebd6fd1debcd7f281_Out_0 = _Clamp_a78f6f28770afd869adb9d12cd47370b_Out_3;
            #endif
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Lerp_e5620b57c917728fa1416e2ffce9b0db_Out_3;
            Unity_Lerp_float3(_HeightBlend_7501025b3a60738a9a9d362e35a9ab48_OutVector4_1, (_Multiply_a38ba695a2660c8691763f0bd7fe159c_Out_2.xyz), (_UseDynamicCoverTStaticMaskF_20dcbac2f16cf78ebd6fd1debcd7f281_Out_0.xxx), _Lerp_e5620b57c917728fa1416e2ffce9b0db_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_c7a719bf7da79a8ea38d7311fd844f92_R_1 = _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2[0];
            float _Split_c7a719bf7da79a8ea38d7311fd844f92_G_2 = _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2[1];
            float _Split_c7a719bf7da79a8ea38d7311fd844f92_B_3 = _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2[2];
            float _Split_c7a719bf7da79a8ea38d7311fd844f92_A_4 = _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_7c5dae9b46c9e686b49e58fa996a104a_Out_0 = IgnoreBase2Alpha;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_e9060f5c0433ec889696d3e462f3229b_R_1 = _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2[0];
            float _Split_e9060f5c0433ec889696d3e462f3229b_G_2 = _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2[1];
            float _Split_e9060f5c0433ec889696d3e462f3229b_B_3 = _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2[2];
            float _Split_e9060f5c0433ec889696d3e462f3229b_A_4 = _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Branch_a7d7aece30fd9b8eb456d191fdd37a06_Out_3;
            Unity_Branch_float(_Property_7c5dae9b46c9e686b49e58fa996a104a_Out_0, _Split_c7a719bf7da79a8ea38d7311fd844f92_A_4, _Split_e9060f5c0433ec889696d3e462f3229b_A_4, _Branch_a7d7aece30fd9b8eb456d191fdd37a06_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Lerp_8692ca93f568998fbc97130b6dbc4556_Out_3;
            Unity_Lerp_float(_Split_c7a719bf7da79a8ea38d7311fd844f92_A_4, _Branch_a7d7aece30fd9b8eb456d191fdd37a06_Out_3, _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2, _Lerp_8692ca93f568998fbc97130b6dbc4556_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_0c8b7b55b9f82588ab2dcff09ee7a16d_Out_3;
            Unity_Clamp_float(_Lerp_8692ca93f568998fbc97130b6dbc4556_Out_3, 0, 1, _Clamp_0c8b7b55b9f82588ab2dcff09ee7a16d_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_6333dc4a6348088bb7281602ce6bff5f_Out_2;
            Unity_Multiply_float(_Clamp_0c8b7b55b9f82588ab2dcff09ee7a16d_Out_3, _Split_c34b73d933404283983f9c8bdb5365d3_A_4, _Multiply_6333dc4a6348088bb7281602ce6bff5f_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_9642b8fb7e32b18a91da1888c9bc375b_Out_3;
            Unity_Clamp_float(_Multiply_6333dc4a6348088bb7281602ce6bff5f_Out_2, 0, 1, _Clamp_9642b8fb7e32b18a91da1888c9bc375b_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_8bc98dd454a5508b9864a6ba09772356_Out_0 = _AlphaCutoff;
            #endif
            surface.BaseColor = _Lerp_e5620b57c917728fa1416e2ffce9b0db_Out_3;
            surface.Emission = float3(0, 0, 0);
            surface.Alpha = _Clamp_9642b8fb7e32b18a91da1888c9bc375b_Out_3;
            surface.AlphaClipThreshold = _Property_8bc98dd454a5508b9864a6ba09772356_Out_0;
            return surface;
        }

            // --------------------------------------------------
            // Build Graph Inputs

            VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceNormal =           input.normalOS;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceTangent =          input.tangentOS.xyz;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpacePosition =         input.positionOS;
        #endif


            return output;
        }
            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 unnormalizedNormalWS = input.normalWS;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        const float renormFactor = 1.0 / length(unnormalizedNormalWS);
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // use bitangent on the fly like in hdrp
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // IMPORTANT! If we ever support Flip on double sided materials ensure bitangent and tangent are NOT flipped.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float crossSign = (input.tangentWS.w > 0.0 ? 1.0 : -1.0) * GetOddNegativeScale();
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 bitang = crossSign * cross(input.normalWS.xyz, input.tangentWS.xyz);
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceNormal =            renormFactor*input.normalWS.xyz;		// we want a unit length Normal Vector node in shader graph
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // to preserve mikktspace compliance we use same scale renormFactor as was used on the normal.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // This is explained in section 2.2 in "surface gradient based bump mapping framework"
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceTangent =           renormFactor*input.tangentWS.xyz;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceBiTangent =         renormFactor*bitang;
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(input.positionWS);
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.uv0 =                         input.texCoord0;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.VertexColor =                 input.color;
        #endif

        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

            return output;
        }

            // --------------------------------------------------
            // Main

            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/LightingMetaPass.hlsl"

            ENDHLSL
        }
        Pass
        {
            // Name: <None>
            Tags
            {
                "LightMode" = "Universal2D"
            }

            // Render State
            Cull Back
        Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
        ZTest LEqual
       ZWrite On

            // Debug
            // <None>

            // --------------------------------------------------
            // Pass

            HLSLPROGRAM

            // Pragmas
            #pragma target 4.5
        #pragma exclude_renderers gles gles3 glcore
        #pragma vertex vert
        #pragma fragment frag

            // DotsInstancingOptions: <None>
            // HybridV1InjectedBuiltinProperties: <None>

            // Keywords
            // PassKeywords: <None>
            #pragma shader_feature_local _ _USEDYNAMICCOVERTSTATICMASKF_ON

        #if defined(_USEDYNAMICCOVERTSTATICMASKF_ON)
            #define KEYWORD_PERMUTATION_0
        #else
            #define KEYWORD_PERMUTATION_1
        #endif


            // Defines
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _SURFACE_TYPE_TRANSPARENT 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _AlphaClip 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMALMAP 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMAL_DROPOFF_TS 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_NORMAL
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TANGENT
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TEXCOORD0
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_COLOR
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_POSITION_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_NORMAL_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TANGENT_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TEXCOORD0
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_COLOR
        #endif

            #define FEATURES_GRAPH_VERTEX
            /* WARNING: $splice Could not find named fragment 'PassInstancing' */
            #define SHADERPASS SHADERPASS_2D
            /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */

            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

            // --------------------------------------------------
            // Structs and Packing

            struct Attributes
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 positionOS : POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 normalOS : NORMAL;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 tangentOS : TANGENT;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 uv0 : TEXCOORD0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 color : COLOR;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : INSTANCEID_SEMANTIC;
            #endif
            #endif
        };
        struct Varyings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 positionWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 normalWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 tangentWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 texCoord0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 color;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };
        struct SurfaceDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceBiTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 AbsoluteWorldSpacePosition;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 uv0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 VertexColor;
            #endif
        };
        struct VertexDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpacePosition;
            #endif
        };
        struct PackedVaryings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp0 : TEXCOORD0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp1 : TEXCOORD1;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 interp2 : TEXCOORD2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 interp3 : TEXCOORD3;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 interp4 : TEXCOORD4;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };

            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            output.positionCS = input.positionCS;
            output.interp0.xyz =  input.positionWS;
            output.interp1.xyz =  input.normalWS;
            output.interp2.xyzw =  input.tangentWS;
            output.interp3.xyzw =  input.texCoord0;
            output.interp4.xyzw =  input.color;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.positionWS = input.interp0.xyz;
            output.normalWS = input.interp1.xyz;
            output.tangentWS = input.interp2.xyzw;
            output.texCoord0 = input.interp3.xyzw;
            output.color = input.interp4.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        #endif

            // --------------------------------------------------
            // Graph

            // Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float _AlphaCutoff;
        float4 _BaseColor;
        float4 _BaseColorMap_TexelSize;
        float _BaseUsePlanarUV;
        float4 _BaseTilingOffset;
        float4 _BaseNormalMap_TexelSize;
        float _BaseNormalScale;
        float4 _BaseMaskMap_TexelSize;
        float _BaseMetallic;
        float _BaseAORemapMin;
        float _BaseAORemapMax;
        float _BaseSmoothnessRemapMin;
        float _BaseSmoothnessRemapMax;
        float4 _LayerMask_TexelSize;
        float _Invert_Layer_Mask;
        float _Height_Transition;
        float _HeightMin;
        float _HeightMax;
        float _HeightOffset;
        float _HeightMin2;
        float _HeightMax2;
        float _HeightOffset2;
        float IgnoreBase2Alpha;
        float4 _Base2Color;
        float4 _Base2ColorMap_TexelSize;
        float4 _Base2TilingOffset;
        float _Base2UsePlanarUV;
        float4 _Base2NormalMap_TexelSize;
        float _Base2NormalScale;
        float4 _Base2MaskMap_TexelSize;
        float _Base2Metallic;
        float _Base2SmoothnessRemapMin;
        float _Base2SmoothnessRemapMax;
        float _Base2AORemapMin;
        float _Base2AORemapMax;
        float4 _CoverMaskA_TexelSize;
        float _CoverMaskPower;
        float _Cover_Amount;
        float _Cover_Amount_Grow_Speed;
        float _Cover_Max_Angle;
        float _Cover_Min_Height;
        float _Cover_Min_Height_Blending;
        float4 _CoverBaseColor;
        float4 _CoverBaseColorMap_TexelSize;
        float4 _CoverTilingOffset;
        float _CoverUsePlanarUV;
        float4 _CoverNormalMap_TexelSize;
        float _CoverNormalScale;
        float _CoverNormalBlendHardness;
        float _CoverHardness;
        float _CoverHeightMapMin;
        float _CoverHeightMapMax;
        float _CoverHeightMapOffset;
        float4 _CoverMaskMap_TexelSize;
        float _CoverMetallic;
        float _CoverAORemapMin;
        float _CoverAORemapMax;
        float _CoverSmoothnessRemapMin;
        float _CoverSmoothnessRemapMax;
        CBUFFER_END

        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_BaseColorMap);
        SAMPLER(sampler_BaseColorMap);
        TEXTURE2D(_BaseNormalMap);
        SAMPLER(sampler_BaseNormalMap);
        TEXTURE2D(_BaseMaskMap);
        SAMPLER(sampler_BaseMaskMap);
        TEXTURE2D(_LayerMask);
        SAMPLER(sampler_LayerMask);
        TEXTURE2D(_Base2ColorMap);
        SAMPLER(sampler_Base2ColorMap);
        TEXTURE2D(_Base2NormalMap);
        SAMPLER(sampler_Base2NormalMap);
        TEXTURE2D(_Base2MaskMap);
        SAMPLER(sampler_Base2MaskMap);
        TEXTURE2D(_CoverMaskA);
        SAMPLER(sampler_CoverMaskA);
        TEXTURE2D(_CoverBaseColorMap);
        SAMPLER(sampler_CoverBaseColorMap);
        TEXTURE2D(_CoverNormalMap);
        SAMPLER(sampler_CoverNormalMap);
        TEXTURE2D(_CoverMaskMap);
        SAMPLER(sampler_CoverMaskMap);

            // Graph Functions
            
        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }

        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }

        void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }

        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }

        void Unity_Branch_float2(float Predicate, float2 True, float2 False, out float2 Out)
        {
            Out = Predicate ? True : False;
        }

        struct Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6
        {
            float3 AbsoluteWorldSpacePosition;
            half4 uv0;
        };

        void SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(UnityTexture2D Texture2D_80A3D28F, float4 Vector4_2EBA7A3B, float Boolean_7ABB9909, Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 IN, out float4 XZ_2)
        {
            UnityTexture2D _Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0 = Texture2D_80A3D28F;
            float _Property_30834f691775a0898a45b1c868520436_Out_0 = Boolean_7ABB9909;
            float _Split_89ed63cb625cb3878c183d0b71c03400_R_1 = IN.AbsoluteWorldSpacePosition[0];
            float _Split_89ed63cb625cb3878c183d0b71c03400_G_2 = IN.AbsoluteWorldSpacePosition[1];
            float _Split_89ed63cb625cb3878c183d0b71c03400_B_3 = IN.AbsoluteWorldSpacePosition[2];
            float _Split_89ed63cb625cb3878c183d0b71c03400_A_4 = 0;
            float4 _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4;
            float3 _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5;
            float2 _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6;
            Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_B_3, 0, 0, _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5, _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6);
            float4 _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0 = Vector4_2EBA7A3B;
            float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[0];
            float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_G_2 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[1];
            float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_B_3 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[2];
            float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_A_4 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[3];
            float _Divide_e64179199923c58289b6aa94ea6c9178_Out_2;
            Unity_Divide_float(1, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1, _Divide_e64179199923c58289b6aa94ea6c9178_Out_2);
            float4 _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2;
            Unity_Multiply_float(_Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, (_Divide_e64179199923c58289b6aa94ea6c9178_Out_2.xxxx), _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2);
            float2 _Vector2_16c15d3bbdd14b85bd48e3a6cb318af7_Out_0 = float2(_Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_G_2);
            float2 _Vector2_f8d75f54e7705083bbec539a60185577_Out_0 = float2(_Split_2f0f52f6ef8c0e81af0da6476402bc1f_B_3, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_A_4);
            float2 _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_16c15d3bbdd14b85bd48e3a6cb318af7_Out_0, _Vector2_f8d75f54e7705083bbec539a60185577_Out_0, _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3);
            float2 _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3;
            Unity_Branch_float2(_Property_30834f691775a0898a45b1c868520436_Out_0, (_Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2.xy), _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3, _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3);
            float4 _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0 = SAMPLE_TEXTURE2D(_Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0.tex, _Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0.samplerstate, _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3);
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.r;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.g;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.b;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_A_7 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.a;
            XZ_2 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0;
        }

        void Unity_Add_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A + B;
        }

        void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
        {
            Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
        }

        void Unity_OneMinus_float(float In, out float Out)
        {
            Out = 1 - In;
        }

        void Unity_Branch_float(float Predicate, float True, float False, out float Out)
        {
            Out = Predicate ? True : False;
        }

        void Unity_Multiply_float(float A, float B, out float Out)
        {
            Out = A * B;
        }

        void Unity_Maximum_float(float A, float B, out float Out)
        {
            Out = max(A, B);
        }

        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }

        void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }

        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }

        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }

        void Unity_Divide_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A / B;
        }

        struct Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135
        {
        };

        void SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135(float3 Vector3_88EEBB5E, float Vector1_DA0A37FA, float3 Vector3_79AA92F, float Vector1_F7E83F1E, float Vector1_1C9222A6, Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 IN, out float3 OutVector4_1)
        {
            float3 _Property_dd1c841a04c03f8c85e7b00eb025ecda_Out_0 = Vector3_88EEBB5E;
            float _Property_14119cc7eaf4128f991283d47cf72d85_Out_0 = Vector1_DA0A37FA;
            float _Property_48af0ad45e3f7f82932b938695d21391_Out_0 = Vector1_DA0A37FA;
            float _Property_8a30b3ca12ff518fa473ccd686c7d503_Out_0 = Vector1_F7E83F1E;
            float _Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2;
            Unity_Maximum_float(_Property_48af0ad45e3f7f82932b938695d21391_Out_0, _Property_8a30b3ca12ff518fa473ccd686c7d503_Out_0, _Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2);
            float _Property_ee8d5fc69475d181be60c57e04ea8708_Out_0 = Vector1_1C9222A6;
            float _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2;
            Unity_Subtract_float(_Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2, _Property_ee8d5fc69475d181be60c57e04ea8708_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2);
            float _Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2;
            Unity_Subtract_float(_Property_14119cc7eaf4128f991283d47cf72d85_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2, _Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2);
            float _Maximum_d02e48d92038448cb0345e5cf3779071_Out_2;
            Unity_Maximum_float(_Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2, 0, _Maximum_d02e48d92038448cb0345e5cf3779071_Out_2);
            float3 _Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2;
            Unity_Multiply_float(_Property_dd1c841a04c03f8c85e7b00eb025ecda_Out_0, (_Maximum_d02e48d92038448cb0345e5cf3779071_Out_2.xxx), _Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2);
            float3 _Property_c7292b3b08585f8c8670172b9a220bf0_Out_0 = Vector3_79AA92F;
            float _Property_5e920479576fad83ba1947728dcceab4_Out_0 = Vector1_F7E83F1E;
            float _Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2;
            Unity_Subtract_float(_Property_5e920479576fad83ba1947728dcceab4_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2, _Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2);
            float _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2;
            Unity_Maximum_float(_Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2, 0, _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2);
            float3 _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2;
            Unity_Multiply_float(_Property_c7292b3b08585f8c8670172b9a220bf0_Out_0, (_Maximum_216777d30802328eab607c8fe68ba3a1_Out_2.xxx), _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2);
            float3 _Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2;
            Unity_Add_float3(_Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2, _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2, _Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2);
            float _Add_356384b52728f583bd6e694bc1fc3738_Out_2;
            Unity_Add_float(_Maximum_d02e48d92038448cb0345e5cf3779071_Out_2, _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2, _Add_356384b52728f583bd6e694bc1fc3738_Out_2);
            float _Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2;
            Unity_Maximum_float(_Add_356384b52728f583bd6e694bc1fc3738_Out_2, 1E-05, _Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2);
            float3 _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2;
            Unity_Divide_float3(_Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2, (_Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2.xxx), _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2);
            OutVector4_1 = _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2;
        }

        void Unity_Clamp_float(float In, float Min, float Max, out float Out)
        {
            Out = clamp(In, Min, Max);
        }

        void Unity_Sign_float3(float3 In, out float3 Out)
        {
            Out = sign(In);
        }

        void Unity_Multiply_float(float2 A, float2 B, out float2 Out)
        {
            Out = A * B;
        }

        void Unity_Normalize_float3(float3 In, out float3 Out)
        {
            Out = normalize(In);
        }

        void Unity_Branch_float3(float Predicate, float3 True, float3 False, out float3 Out)
        {
            Out = Predicate ? True : False;
        }

        struct Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8
        {
            float3 WorldSpaceNormal;
            float3 WorldSpaceTangent;
            float3 WorldSpaceBiTangent;
            float3 AbsoluteWorldSpacePosition;
            half4 uv0;
        };

        void SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(UnityTexture2D Texture2D_80A3D28F, float4 Vector4_82674548, float Boolean_9FF42DF6, Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 IN, out float4 XZ_2)
        {
            float _Property_1ef12cf3201a938993fe6a7951b0e754_Out_0 = Boolean_9FF42DF6;
            UnityTexture2D _Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0 = Texture2D_80A3D28F;
            float _Split_89ed63cb625cb3878c183d0b71c03400_R_1 = IN.AbsoluteWorldSpacePosition[0];
            float _Split_89ed63cb625cb3878c183d0b71c03400_G_2 = IN.AbsoluteWorldSpacePosition[1];
            float _Split_89ed63cb625cb3878c183d0b71c03400_B_3 = IN.AbsoluteWorldSpacePosition[2];
            float _Split_89ed63cb625cb3878c183d0b71c03400_A_4 = 0;
            float4 _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4;
            float3 _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5;
            float2 _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6;
            Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_B_3, 0, 0, _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5, _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6);
            float4 _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0 = Vector4_82674548;
            float _Split_a2e12fa5931da084b2949343a539dfd8_R_1 = _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0[0];
            float _Split_a2e12fa5931da084b2949343a539dfd8_G_2 = _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0[1];
            float _Split_a2e12fa5931da084b2949343a539dfd8_B_3 = _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0[2];
            float _Split_a2e12fa5931da084b2949343a539dfd8_A_4 = _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0[3];
            float _Divide_c36b770dfaa0bb8f85ab27da5fd794f0_Out_2;
            Unity_Divide_float(1, _Split_a2e12fa5931da084b2949343a539dfd8_R_1, _Divide_c36b770dfaa0bb8f85ab27da5fd794f0_Out_2);
            float4 _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2;
            Unity_Multiply_float(_Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, (_Divide_c36b770dfaa0bb8f85ab27da5fd794f0_Out_2.xxxx), _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2);
            float2 _Vector2_6845d21872714d889783b0cb707df3e9_Out_0 = float2(_Split_a2e12fa5931da084b2949343a539dfd8_R_1, _Split_a2e12fa5931da084b2949343a539dfd8_G_2);
            float2 _Vector2_e2e2263627c6098e96a5b5d29350ad03_Out_0 = float2(_Split_a2e12fa5931da084b2949343a539dfd8_B_3, _Split_a2e12fa5931da084b2949343a539dfd8_A_4);
            float2 _TilingAndOffset_17582d056c0b8a8dab1017d37497fe59_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_6845d21872714d889783b0cb707df3e9_Out_0, _Vector2_e2e2263627c6098e96a5b5d29350ad03_Out_0, _TilingAndOffset_17582d056c0b8a8dab1017d37497fe59_Out_3);
            float2 _Branch_1e152f3aac57448f8518bf2852c000c3_Out_3;
            Unity_Branch_float2(_Property_1ef12cf3201a938993fe6a7951b0e754_Out_0, (_Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2.xy), _TilingAndOffset_17582d056c0b8a8dab1017d37497fe59_Out_3, _Branch_1e152f3aac57448f8518bf2852c000c3_Out_3);
            float4 _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0 = SAMPLE_TEXTURE2D(_Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0.tex, _Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0.samplerstate, _Branch_1e152f3aac57448f8518bf2852c000c3_Out_3);
            _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0);
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.r;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.g;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.b;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_A_7 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.a;
            float2 _Vector2_ad6bd100e273d78fa409a30a77bfa2cc_Out_0 = float2(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4, _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5);
            float3 _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1;
            Unity_Sign_float3(IN.WorldSpaceNormal, _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1);
            float _Split_6299d4ddcc4c74828aea40a46fdb896e_R_1 = _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1[0];
            float _Split_6299d4ddcc4c74828aea40a46fdb896e_G_2 = _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1[1];
            float _Split_6299d4ddcc4c74828aea40a46fdb896e_B_3 = _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1[2];
            float _Split_6299d4ddcc4c74828aea40a46fdb896e_A_4 = 0;
            float2 _Vector2_b76cb1842101e58b9e636d49b075c612_Out_0 = float2(_Split_6299d4ddcc4c74828aea40a46fdb896e_G_2, 1);
            float2 _Multiply_31e8db88ee20c985a9850d1a58f3282b_Out_2;
            Unity_Multiply_float(_Vector2_ad6bd100e273d78fa409a30a77bfa2cc_Out_0, _Vector2_b76cb1842101e58b9e636d49b075c612_Out_0, _Multiply_31e8db88ee20c985a9850d1a58f3282b_Out_2);
            float _Split_5ed44bf2eca0868f81eb18100f49d1fa_R_1 = IN.WorldSpaceNormal[0];
            float _Split_5ed44bf2eca0868f81eb18100f49d1fa_G_2 = IN.WorldSpaceNormal[1];
            float _Split_5ed44bf2eca0868f81eb18100f49d1fa_B_3 = IN.WorldSpaceNormal[2];
            float _Split_5ed44bf2eca0868f81eb18100f49d1fa_A_4 = 0;
            float2 _Vector2_70e5837843f28b8b9d64cada3697bd5a_Out_0 = float2(_Split_5ed44bf2eca0868f81eb18100f49d1fa_R_1, _Split_5ed44bf2eca0868f81eb18100f49d1fa_B_3);
            float2 _Add_1145b2f896593d80aa864a34e6702562_Out_2;
            Unity_Add_float2(_Multiply_31e8db88ee20c985a9850d1a58f3282b_Out_2, _Vector2_70e5837843f28b8b9d64cada3697bd5a_Out_0, _Add_1145b2f896593d80aa864a34e6702562_Out_2);
            float _Split_2bc77ca2d17bd78cb2383770ce50b179_R_1 = _Add_1145b2f896593d80aa864a34e6702562_Out_2[0];
            float _Split_2bc77ca2d17bd78cb2383770ce50b179_G_2 = _Add_1145b2f896593d80aa864a34e6702562_Out_2[1];
            float _Split_2bc77ca2d17bd78cb2383770ce50b179_B_3 = 0;
            float _Split_2bc77ca2d17bd78cb2383770ce50b179_A_4 = 0;
            float _Multiply_ab12aea87465a78eaf7fc66c2598d266_Out_2;
            Unity_Multiply_float(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6, _Split_5ed44bf2eca0868f81eb18100f49d1fa_G_2, _Multiply_ab12aea87465a78eaf7fc66c2598d266_Out_2);
            float3 _Vector3_433840b555db308b97e9b14b6a957195_Out_0 = float3(_Split_2bc77ca2d17bd78cb2383770ce50b179_R_1, _Multiply_ab12aea87465a78eaf7fc66c2598d266_Out_2, _Split_2bc77ca2d17bd78cb2383770ce50b179_G_2);
            float3x3 Transform_c7914cc45a011c89b3f53c55afb51673_tangentTransform_World = float3x3(IN.WorldSpaceTangent, IN.WorldSpaceBiTangent, IN.WorldSpaceNormal);
            float3 _Transform_c7914cc45a011c89b3f53c55afb51673_Out_1 = TransformWorldToTangent(_Vector3_433840b555db308b97e9b14b6a957195_Out_0.xyz, Transform_c7914cc45a011c89b3f53c55afb51673_tangentTransform_World);
            float3 _Normalize_09bf8a2bd0a4d38e8b97d5c674f79b44_Out_1;
            Unity_Normalize_float3(_Transform_c7914cc45a011c89b3f53c55afb51673_Out_1, _Normalize_09bf8a2bd0a4d38e8b97d5c674f79b44_Out_1);
            float3 _Branch_9eadf909a90f2f80880f8c56ecc2a91f_Out_3;
            Unity_Branch_float3(_Property_1ef12cf3201a938993fe6a7951b0e754_Out_0, _Normalize_09bf8a2bd0a4d38e8b97d5c674f79b44_Out_1, (_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.xyz), _Branch_9eadf909a90f2f80880f8c56ecc2a91f_Out_3);
            XZ_2 = (float4(_Branch_9eadf909a90f2f80880f8c56ecc2a91f_Out_3, 1.0));
        }

        void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
        {
            Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
        }

        void Unity_Absolute_float(float In, out float Out)
        {
            Out = abs(In);
        }

        void Unity_Power_float(float A, float B, out float Out)
        {
            Out = pow(A, B);
        }

        void Unity_Saturate_float(float In, out float Out)
        {
            Out = saturate(In);
        }

        void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
        {
            Out = lerp(A, B, T);
        }

        void Unity_Lerp_float(float A, float B, float T, out float Out)
        {
            Out = lerp(A, B, T);
        }

            // Graph Vertex
            struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };

        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }

            // Graph Pixel
            struct SurfaceDescription
        {
            float3 BaseColor;
            float Alpha;
            float AlphaClipThreshold;
        };

        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_07d75b1d2628da808a2efb93a1d6219e_Out_0 = UnityBuildTexture2DStructNoScale(_BaseColorMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0 = _BaseTilingOffset;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_7f998178363b4188ba2f07298ef869c1_Out_0 = _BaseUsePlanarUV;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e;
            _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e.uv0 = IN.uv0;
            float4 _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2;
            SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(_Property_07d75b1d2628da808a2efb93a1d6219e_Out_0, _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0, _Property_7f998178363b4188ba2f07298ef869c1_Out_0, _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e, _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_b83097c58639858680bf43881a95b0af_Out_0 = _BaseColor;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2;
            Unity_Multiply_float(_PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2, _Property_b83097c58639858680bf43881a95b0af_Out_0, _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_1e449ff9f8e8ec828507233e8240eb11_Out_0 = UnityBuildTexture2DStructNoScale(_BaseMaskMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_4245c3b264047180b5c90a697d6cb278;
            _PlanarNM_4245c3b264047180b5c90a697d6cb278.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNM_4245c3b264047180b5c90a697d6cb278.uv0 = IN.uv0;
            float4 _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2;
            SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(_Property_1e449ff9f8e8ec828507233e8240eb11_Out_0, _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0, _Property_7f998178363b4188ba2f07298ef869c1_Out_0, _PlanarNM_4245c3b264047180b5c90a697d6cb278, _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_91a015dea8acd38b904ba0935328a5bc_R_1 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[0];
            float _Split_91a015dea8acd38b904ba0935328a5bc_G_2 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[1];
            float _Split_91a015dea8acd38b904ba0935328a5bc_B_3 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[2];
            float _Split_91a015dea8acd38b904ba0935328a5bc_A_4 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_fbcff1469ebf488394a8a89ddaf0eb2a_Out_0 = _HeightMin;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_9df7a44c8225168683743ac60c0c3c34_Out_0 = _HeightMax;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_9b1e95888c28bc8893f28c02b87fa448_Out_0 = float2(_Property_fbcff1469ebf488394a8a89ddaf0eb2a_Out_0, _Property_9df7a44c8225168683743ac60c0c3c34_Out_0);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_29ca14fd0b712983a38d63d2dd326e96_Out_0 = _HeightOffset;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Add_cb503f8a09720d84bb03cbd89e37b80c_Out_2;
            Unity_Add_float2(_Vector2_9b1e95888c28bc8893f28c02b87fa448_Out_0, (_Property_29ca14fd0b712983a38d63d2dd326e96_Out_0.xx), _Add_cb503f8a09720d84bb03cbd89e37b80c_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3;
            Unity_Remap_float(_Split_91a015dea8acd38b904ba0935328a5bc_B_3, float2 (0, 1), _Add_cb503f8a09720d84bb03cbd89e37b80c_Out_2, _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_ba3a5f4cba7d0a8fa288ffc8267d6c0e_Out_0 = UnityBuildTexture2DStructNoScale(_Base2ColorMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_86a4657df480d48e8d3ad3b036731380_Out_0 = _Base2TilingOffset;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0 = _Base2UsePlanarUV;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4;
            _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4.uv0 = IN.uv0;
            float4 _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4_XZ_2;
            SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(_Property_ba3a5f4cba7d0a8fa288ffc8267d6c0e_Out_0, _Property_86a4657df480d48e8d3ad3b036731380_Out_0, _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0, _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4, _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_3561b11b899bda8e855826445cf628aa_Out_0 = _Base2Color;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2;
            Unity_Multiply_float(_PlanarNM_5aeab444ca6fd78ea56a01215880a5a4_XZ_2, _Property_3561b11b899bda8e855826445cf628aa_Out_0, _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_c34b73d933404283983f9c8bdb5365d3_R_1 = IN.VertexColor[0];
            float _Split_c34b73d933404283983f9c8bdb5365d3_G_2 = IN.VertexColor[1];
            float _Split_c34b73d933404283983f9c8bdb5365d3_B_3 = IN.VertexColor[2];
            float _Split_c34b73d933404283983f9c8bdb5365d3_A_4 = IN.VertexColor[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_df2df7bb5cfc3381beee7ec454da7542_Out_0 = _Invert_Layer_Mask;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_c7b1e2df9f9b0e8eace9b2274924e69c_Out_0 = UnityBuildTexture2DStructNoScale(_LayerMask);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0 = SAMPLE_TEXTURE2D(_Property_c7b1e2df9f9b0e8eace9b2274924e69c_Out_0.tex, _Property_c7b1e2df9f9b0e8eace9b2274924e69c_Out_0.samplerstate, IN.uv0.xy);
            float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.r;
            float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_G_5 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.g;
            float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_B_6 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.b;
            float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_A_7 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1;
            Unity_OneMinus_float(_SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4, _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Branch_af0c5e511241ce8eae748ae487df50fa_Out_3;
            Unity_Branch_float(_Property_df2df7bb5cfc3381beee7ec454da7542_Out_0, _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1, _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4, _Branch_af0c5e511241ce8eae748ae487df50fa_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_de4f6eb48a629285a664dad7fb06438f_Out_0 = UnityBuildTexture2DStructNoScale(_Base2MaskMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_d5657f470f05ef839e4c257a20ace8cb;
            _PlanarNM_d5657f470f05ef839e4c257a20ace8cb.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNM_d5657f470f05ef839e4c257a20ace8cb.uv0 = IN.uv0;
            float4 _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2;
            SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(_Property_de4f6eb48a629285a664dad7fb06438f_Out_0, _Property_86a4657df480d48e8d3ad3b036731380_Out_0, _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0, _PlanarNM_d5657f470f05ef839e4c257a20ace8cb, _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_83ec66b648ab6c84848b42686c256cd7_R_1 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[0];
            float _Split_83ec66b648ab6c84848b42686c256cd7_G_2 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[1];
            float _Split_83ec66b648ab6c84848b42686c256cd7_B_3 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[2];
            float _Split_83ec66b648ab6c84848b42686c256cd7_A_4 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_ce1750e5c69e97818667b412fc3f9f2c_Out_0 = _HeightMin2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_8e0f2ea54d8ede89bbabdf31a9bafd57_Out_0 = _HeightMax2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_fb6c6dd7e70e768ba686e8e94153bb96_Out_0 = float2(_Property_ce1750e5c69e97818667b412fc3f9f2c_Out_0, _Property_8e0f2ea54d8ede89bbabdf31a9bafd57_Out_0);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_151ae2702b614585af2000f0a812960f_Out_0 = _HeightOffset2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2;
            Unity_Add_float2(_Vector2_fb6c6dd7e70e768ba686e8e94153bb96_Out_0, (_Property_151ae2702b614585af2000f0a812960f_Out_0.xx), _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3;
            Unity_Remap_float(_Split_83ec66b648ab6c84848b42686c256cd7_B_3, float2 (0, 1), _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2, _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2;
            Unity_Multiply_float(_Branch_af0c5e511241ce8eae748ae487df50fa_Out_3, _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3, _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2;
            Unity_Multiply_float(_Split_c34b73d933404283983f9c8bdb5365d3_R_1, _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2, _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_818c8af4b930138e81034c886614171d_Out_0 = _Height_Transition;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 _HeightBlend_7501025b3a60738a9a9d362e35a9ab48;
            float3 _HeightBlend_7501025b3a60738a9a9d362e35a9ab48_OutVector4_1;
            SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135((_Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2.xyz), _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3, (_Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2.xyz), _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2, _Property_818c8af4b930138e81034c886614171d_Out_0, _HeightBlend_7501025b3a60738a9a9d362e35a9ab48, _HeightBlend_7501025b3a60738a9a9d362e35a9ab48_OutVector4_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_c0ebdab0f71ace8aabaa865fd7293599_Out_0 = UnityBuildTexture2DStructNoScale(_CoverBaseColorMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_822489d2e6d3e08590c64f085ffd9b2e_Out_0 = _CoverTilingOffset;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_2ae4a163bd21d98789af282d6e469175_Out_0 = _CoverUsePlanarUV;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_8bb420494d19b28e9ccdff489802dc81;
            _PlanarNM_8bb420494d19b28e9ccdff489802dc81.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNM_8bb420494d19b28e9ccdff489802dc81.uv0 = IN.uv0;
            float4 _PlanarNM_8bb420494d19b28e9ccdff489802dc81_XZ_2;
            SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(_Property_c0ebdab0f71ace8aabaa865fd7293599_Out_0, _Property_822489d2e6d3e08590c64f085ffd9b2e_Out_0, _Property_2ae4a163bd21d98789af282d6e469175_Out_0, _PlanarNM_8bb420494d19b28e9ccdff489802dc81, _PlanarNM_8bb420494d19b28e9ccdff489802dc81_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_55e7941fa7ac5f8387aa9bb633b08883_Out_0 = _CoverBaseColor;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Multiply_a38ba695a2660c8691763f0bd7fe159c_Out_2;
            Unity_Multiply_float(_PlanarNM_8bb420494d19b28e9ccdff489802dc81_XZ_2, _Property_55e7941fa7ac5f8387aa9bb633b08883_Out_0, _Multiply_a38ba695a2660c8691763f0bd7fe159c_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_c0d223db25424a8ab0cee2de2bbf58ce_Out_0 = UnityBuildTexture2DStructNoScale(_CoverMaskA);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _UV_5352c8dd0add178ba83a5421c2c0b3f0_Out_0 = IN.uv0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _SampleTexture2D_024ba490c015248988a12a9d670014ea_RGBA_0 = SAMPLE_TEXTURE2D(_Property_c0d223db25424a8ab0cee2de2bbf58ce_Out_0.tex, _Property_c0d223db25424a8ab0cee2de2bbf58ce_Out_0.samplerstate, (_UV_5352c8dd0add178ba83a5421c2c0b3f0_Out_0.xy));
            float _SampleTexture2D_024ba490c015248988a12a9d670014ea_R_4 = _SampleTexture2D_024ba490c015248988a12a9d670014ea_RGBA_0.r;
            float _SampleTexture2D_024ba490c015248988a12a9d670014ea_G_5 = _SampleTexture2D_024ba490c015248988a12a9d670014ea_RGBA_0.g;
            float _SampleTexture2D_024ba490c015248988a12a9d670014ea_B_6 = _SampleTexture2D_024ba490c015248988a12a9d670014ea_RGBA_0.b;
            float _SampleTexture2D_024ba490c015248988a12a9d670014ea_A_7 = _SampleTexture2D_024ba490c015248988a12a9d670014ea_RGBA_0.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_b80e7b96604b7c82bbf9bff4981fad76_Out_0 = _CoverMaskPower;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_abe410d256783480b1b58468bf78a882_Out_2;
            Unity_Multiply_float(_SampleTexture2D_024ba490c015248988a12a9d670014ea_A_7, _Property_b80e7b96604b7c82bbf9bff4981fad76_Out_0, _Multiply_abe410d256783480b1b58468bf78a882_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_a78f6f28770afd869adb9d12cd47370b_Out_3;
            Unity_Clamp_float(_Multiply_abe410d256783480b1b58468bf78a882_Out_2, 0, 1, _Clamp_a78f6f28770afd869adb9d12cd47370b_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_7c7049e15fdff386b535790d8666f609_Out_0 = UnityBuildTexture2DStructNoScale(_BaseNormalMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8;
            _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.WorldSpaceNormal = IN.WorldSpaceNormal;
            _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.WorldSpaceTangent = IN.WorldSpaceTangent;
            _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
            _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.uv0 = IN.uv0;
            float4 _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8_XZ_2;
            SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(_Property_7c7049e15fdff386b535790d8666f609_Out_0, _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0, _Property_7f998178363b4188ba2f07298ef869c1_Out_0, _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8, _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_d4b0759cf4647e81be065ec1465ce2b4_Out_0 = _BaseNormalScale;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _NormalStrength_f66a9108ea294886acc61513b41cc5e4_Out_2;
            Unity_NormalStrength_float((_PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8_XZ_2.xyz), _Property_d4b0759cf4647e81be065ec1465ce2b4_Out_0, _NormalStrength_f66a9108ea294886acc61513b41cc5e4_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_fa9f7890b20ad481a92543c04b237bde_Out_0 = UnityBuildTexture2DStructNoScale(_Base2NormalMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf;
            _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.WorldSpaceNormal = IN.WorldSpaceNormal;
            _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.WorldSpaceTangent = IN.WorldSpaceTangent;
            _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
            _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.uv0 = IN.uv0;
            float4 _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf_XZ_2;
            SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(_Property_fa9f7890b20ad481a92543c04b237bde_Out_0, _Property_86a4657df480d48e8d3ad3b036731380_Out_0, _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0, _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf, _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_8c31443b776727819a663c7ddce79064_Out_0 = _Base2NormalScale;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _NormalStrength_0fb86880ab8e368dac6d01b830e20ed8_Out_2;
            Unity_NormalStrength_float((_PlanarNMn_d7b3ec528088a085a5102e025a1b45cf_XZ_2.xyz), _Property_8c31443b776727819a663c7ddce79064_Out_0, _NormalStrength_0fb86880ab8e368dac6d01b830e20ed8_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 _HeightBlend_7c09d97625efce898e21b66cd039be8b;
            float3 _HeightBlend_7c09d97625efce898e21b66cd039be8b_OutVector4_1;
            SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135(_NormalStrength_f66a9108ea294886acc61513b41cc5e4_Out_2, _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3, _NormalStrength_0fb86880ab8e368dac6d01b830e20ed8_Out_2, _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2, _Property_818c8af4b930138e81034c886614171d_Out_0, _HeightBlend_7c09d97625efce898e21b66cd039be8b, _HeightBlend_7c09d97625efce898e21b66cd039be8b_OutVector4_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_65f7dd6fe6c29b83913af586c597a1ef_Out_0 = UnityBuildTexture2DStructNoScale(_CoverNormalMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3;
            _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3.WorldSpaceNormal = IN.WorldSpaceNormal;
            _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3.WorldSpaceTangent = IN.WorldSpaceTangent;
            _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
            _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3.uv0 = IN.uv0;
            float4 _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3_XZ_2;
            SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(_Property_65f7dd6fe6c29b83913af586c597a1ef_Out_0, _Property_822489d2e6d3e08590c64f085ffd9b2e_Out_0, _Property_2ae4a163bd21d98789af282d6e469175_Out_0, _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3, _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_19f92cae42737480a95820c51d4ba124_Out_0 = _CoverNormalBlendHardness;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _NormalStrength_2c3488591b8345869feb25a3dee06c3f_Out_2;
            Unity_NormalStrength_float((_PlanarNMn_248bc5b7421d3f828d166902c73ca6c3_XZ_2.xyz), _Property_19f92cae42737480a95820c51d4ba124_Out_0, _NormalStrength_2c3488591b8345869feb25a3dee06c3f_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_96bfe9cb80ad308385c191d094b3d071_R_1 = IN.WorldSpaceNormal[0];
            float _Split_96bfe9cb80ad308385c191d094b3d071_G_2 = IN.WorldSpaceNormal[1];
            float _Split_96bfe9cb80ad308385c191d094b3d071_B_3 = IN.WorldSpaceNormal[2];
            float _Split_96bfe9cb80ad308385c191d094b3d071_A_4 = 0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_0dd796aae8cd9f878bef13ceac4fe3ec_Out_0 = _Cover_Amount;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_67285cdc688aa38d83f62d5bb095d597_Out_0 = _Cover_Amount_Grow_Speed;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Subtract_fcefec675e7536888eccf5574d921972_Out_2;
            Unity_Subtract_float(4, _Property_67285cdc688aa38d83f62d5bb095d597_Out_0, _Subtract_fcefec675e7536888eccf5574d921972_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Divide_1e25465528e612839a4ce1faedd89e7d_Out_2;
            Unity_Divide_float(_Property_0dd796aae8cd9f878bef13ceac4fe3ec_Out_0, _Subtract_fcefec675e7536888eccf5574d921972_Out_2, _Divide_1e25465528e612839a4ce1faedd89e7d_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Absolute_d20b810ffdec828ab74dd6692d82f01b_Out_1;
            Unity_Absolute_float(_Divide_1e25465528e612839a4ce1faedd89e7d_Out_2, _Absolute_d20b810ffdec828ab74dd6692d82f01b_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Power_181fbf47cfdb258da1fe0b72a450986f_Out_2;
            Unity_Power_float(_Absolute_d20b810ffdec828ab74dd6692d82f01b_Out_1, _Subtract_fcefec675e7536888eccf5574d921972_Out_2, _Power_181fbf47cfdb258da1fe0b72a450986f_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_11f62dba01f1a38c9e0a9972ccd19246_Out_3;
            Unity_Clamp_float(_Power_181fbf47cfdb258da1fe0b72a450986f_Out_2, 0, 2, _Clamp_11f62dba01f1a38c9e0a9972ccd19246_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_9810f6d76275cd8fbe5e3a02360b98a7_Out_2;
            Unity_Multiply_float(_Split_96bfe9cb80ad308385c191d094b3d071_G_2, _Clamp_11f62dba01f1a38c9e0a9972ccd19246_Out_3, _Multiply_9810f6d76275cd8fbe5e3a02360b98a7_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Saturate_a007c5f214685c87bf6ca3e64c06b488_Out_1;
            Unity_Saturate_float(_Multiply_9810f6d76275cd8fbe5e3a02360b98a7_Out_2, _Saturate_a007c5f214685c87bf6ca3e64c06b488_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_1b2b25b617fc508b9835f0309136fd00_Out_3;
            Unity_Clamp_float(_Split_96bfe9cb80ad308385c191d094b3d071_G_2, 0, 0.9999, _Clamp_1b2b25b617fc508b9835f0309136fd00_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_7b12276ea7a4538db6804507b30a830c_Out_0 = _Cover_Max_Angle;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Divide_54c523ff4b7acb858e9e368fd1e4d34a_Out_2;
            Unity_Divide_float(_Property_7b12276ea7a4538db6804507b30a830c_Out_0, 45, _Divide_54c523ff4b7acb858e9e368fd1e4d34a_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _OneMinus_6cf431985b651e8e9546ae6cb2d4d668_Out_1;
            Unity_OneMinus_float(_Divide_54c523ff4b7acb858e9e368fd1e4d34a_Out_2, _OneMinus_6cf431985b651e8e9546ae6cb2d4d668_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Subtract_4ef7b60aeab8d589bf2d2423737642bc_Out_2;
            Unity_Subtract_float(_Clamp_1b2b25b617fc508b9835f0309136fd00_Out_3, _OneMinus_6cf431985b651e8e9546ae6cb2d4d668_Out_1, _Subtract_4ef7b60aeab8d589bf2d2423737642bc_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_a4b51894ea17818c9a27bb533a2ebe74_Out_3;
            Unity_Clamp_float(_Subtract_4ef7b60aeab8d589bf2d2423737642bc_Out_2, 0, 2, _Clamp_a4b51894ea17818c9a27bb533a2ebe74_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Divide_c4196d4f02190b89ba827ccd4ae8a74d_Out_2;
            Unity_Divide_float(1, _Divide_54c523ff4b7acb858e9e368fd1e4d34a_Out_2, _Divide_c4196d4f02190b89ba827ccd4ae8a74d_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_ffc22433163d1184846ede424b44bcb2_Out_2;
            Unity_Multiply_float(_Clamp_a4b51894ea17818c9a27bb533a2ebe74_Out_3, _Divide_c4196d4f02190b89ba827ccd4ae8a74d_Out_2, _Multiply_ffc22433163d1184846ede424b44bcb2_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Absolute_c2e5757082de5d878d4c023806fb2108_Out_1;
            Unity_Absolute_float(_Multiply_ffc22433163d1184846ede424b44bcb2_Out_2, _Absolute_c2e5757082de5d878d4c023806fb2108_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_849d9f217c95f38c9d49ab251578d8d5_Out_0 = _CoverHardness;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Power_578546d66d69a5829b745ebba1279adf_Out_2;
            Unity_Power_float(_Absolute_c2e5757082de5d878d4c023806fb2108_Out_1, _Property_849d9f217c95f38c9d49ab251578d8d5_Out_0, _Power_578546d66d69a5829b745ebba1279adf_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_34d2d3aff4814e8e83d2894b3512c6c8_Out_0 = _Cover_Min_Height;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _OneMinus_474df64227f004849b34c68fe8df93f2_Out_1;
            Unity_OneMinus_float(_Property_34d2d3aff4814e8e83d2894b3512c6c8_Out_0, _OneMinus_474df64227f004849b34c68fe8df93f2_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_ee4d9dc934b3508397d5a3dece110ab0_R_1 = IN.AbsoluteWorldSpacePosition[0];
            float _Split_ee4d9dc934b3508397d5a3dece110ab0_G_2 = IN.AbsoluteWorldSpacePosition[1];
            float _Split_ee4d9dc934b3508397d5a3dece110ab0_B_3 = IN.AbsoluteWorldSpacePosition[2];
            float _Split_ee4d9dc934b3508397d5a3dece110ab0_A_4 = 0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Add_d6bc513aa82d918ea24e279f4353d971_Out_2;
            Unity_Add_float(_OneMinus_474df64227f004849b34c68fe8df93f2_Out_1, _Split_ee4d9dc934b3508397d5a3dece110ab0_G_2, _Add_d6bc513aa82d918ea24e279f4353d971_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Add_a6a61cb12180108c9e1364b90d2673e2_Out_2;
            Unity_Add_float(_Add_d6bc513aa82d918ea24e279f4353d971_Out_2, 1, _Add_a6a61cb12180108c9e1364b90d2673e2_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_1874fdd00cb9aa839d93ab8536e2414d_Out_3;
            Unity_Clamp_float(_Add_a6a61cb12180108c9e1364b90d2673e2_Out_2, 0, 1, _Clamp_1874fdd00cb9aa839d93ab8536e2414d_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_7b91fd6e21b46c85816c7b681307cbe4_Out_0 = _Cover_Min_Height_Blending;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Add_6dca9453f6a35e8185c4b8e9782db0a9_Out_2;
            Unity_Add_float(_Add_d6bc513aa82d918ea24e279f4353d971_Out_2, _Property_7b91fd6e21b46c85816c7b681307cbe4_Out_0, _Add_6dca9453f6a35e8185c4b8e9782db0a9_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Divide_83415a319ecfba83af914cbc5487b546_Out_2;
            Unity_Divide_float(_Add_6dca9453f6a35e8185c4b8e9782db0a9_Out_2, _Add_d6bc513aa82d918ea24e279f4353d971_Out_2, _Divide_83415a319ecfba83af914cbc5487b546_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _OneMinus_bf150b22fcad5a87b7c825c9c6cf1687_Out_1;
            Unity_OneMinus_float(_Divide_83415a319ecfba83af914cbc5487b546_Out_2, _OneMinus_bf150b22fcad5a87b7c825c9c6cf1687_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Add_86ff9fa850efbe8c80705d8266609dab_Out_2;
            Unity_Add_float(_OneMinus_bf150b22fcad5a87b7c825c9c6cf1687_Out_1, -0.5, _Add_86ff9fa850efbe8c80705d8266609dab_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_906e140f01222d8ba61252ec6ec9d6a4_Out_3;
            Unity_Clamp_float(_Add_86ff9fa850efbe8c80705d8266609dab_Out_2, 0, 1, _Clamp_906e140f01222d8ba61252ec6ec9d6a4_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Add_c1ec5849bf72f585a30b3e11a91ada52_Out_2;
            Unity_Add_float(_Clamp_1874fdd00cb9aa839d93ab8536e2414d_Out_3, _Clamp_906e140f01222d8ba61252ec6ec9d6a4_Out_3, _Add_c1ec5849bf72f585a30b3e11a91ada52_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_17a8a0cf209a038b9e9c7f5681cdd1fb_Out_3;
            Unity_Clamp_float(_Add_c1ec5849bf72f585a30b3e11a91ada52_Out_2, 0, 1, _Clamp_17a8a0cf209a038b9e9c7f5681cdd1fb_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_8c2759ac24a9b289b1e9610cfd161bb0_Out_2;
            Unity_Multiply_float(_Power_578546d66d69a5829b745ebba1279adf_Out_2, _Clamp_17a8a0cf209a038b9e9c7f5681cdd1fb_Out_3, _Multiply_8c2759ac24a9b289b1e9610cfd161bb0_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_1a723f136ec7fa8c957b5d29e03d3051_Out_2;
            Unity_Multiply_float(_Saturate_a007c5f214685c87bf6ca3e64c06b488_Out_1, _Multiply_8c2759ac24a9b289b1e9610cfd161bb0_Out_2, _Multiply_1a723f136ec7fa8c957b5d29e03d3051_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Lerp_d1c72e47b283948584479177786ae8d5_Out_3;
            Unity_Lerp_float3(_HeightBlend_7c09d97625efce898e21b66cd039be8b_OutVector4_1, _NormalStrength_2c3488591b8345869feb25a3dee06c3f_Out_2, (_Multiply_1a723f136ec7fa8c957b5d29e03d3051_Out_2.xxx), _Lerp_d1c72e47b283948584479177786ae8d5_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3x3 Transform_180fb403b53f318db002e8eba7616644_transposeTangent = transpose(float3x3(IN.WorldSpaceTangent, IN.WorldSpaceBiTangent, IN.WorldSpaceNormal));
            float3 _Transform_180fb403b53f318db002e8eba7616644_Out_1 = normalize(mul(Transform_180fb403b53f318db002e8eba7616644_transposeTangent, _Lerp_d1c72e47b283948584479177786ae8d5_Out_3.xyz).xyz);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_c9a2b4fb4f688b8ebfc1436535cd5ba4_R_1 = _Transform_180fb403b53f318db002e8eba7616644_Out_1[0];
            float _Split_c9a2b4fb4f688b8ebfc1436535cd5ba4_G_2 = _Transform_180fb403b53f318db002e8eba7616644_Out_1[1];
            float _Split_c9a2b4fb4f688b8ebfc1436535cd5ba4_B_3 = _Transform_180fb403b53f318db002e8eba7616644_Out_1[2];
            float _Split_c9a2b4fb4f688b8ebfc1436535cd5ba4_A_4 = 0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_4c7631d0688102819e6d388d624855a1_Out_2;
            Unity_Multiply_float(_Split_c9a2b4fb4f688b8ebfc1436535cd5ba4_G_2, _Clamp_11f62dba01f1a38c9e0a9972ccd19246_Out_3, _Multiply_4c7631d0688102819e6d388d624855a1_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_f2887eb409f6bb81ae4caad2b01b17f1_Out_2;
            Unity_Multiply_float(_Clamp_11f62dba01f1a38c9e0a9972ccd19246_Out_3, _Property_849d9f217c95f38c9d49ab251578d8d5_Out_0, _Multiply_f2887eb409f6bb81ae4caad2b01b17f1_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_2e348ed31331e78791b2b3130a009f30_Out_2;
            Unity_Multiply_float(_Multiply_f2887eb409f6bb81ae4caad2b01b17f1_Out_2, _Multiply_8c2759ac24a9b289b1e9610cfd161bb0_Out_2, _Multiply_2e348ed31331e78791b2b3130a009f30_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_622e54e9a77b08839c0954ce5715ad1c_Out_2;
            Unity_Multiply_float(_Multiply_4c7631d0688102819e6d388d624855a1_Out_2, _Multiply_2e348ed31331e78791b2b3130a009f30_Out_2, _Multiply_622e54e9a77b08839c0954ce5715ad1c_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_608db04fab7d768d9a8b5fb9cf0768e1_Out_0 = UnityBuildTexture2DStructNoScale(_CoverMaskMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e;
            _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e.uv0 = IN.uv0;
            float4 _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e_XZ_2;
            SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(_Property_608db04fab7d768d9a8b5fb9cf0768e1_Out_0, _Property_822489d2e6d3e08590c64f085ffd9b2e_Out_0, _Property_2ae4a163bd21d98789af282d6e469175_Out_0, _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e, _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_86ec1aefda4f9e8e82b79c6195b397b0_R_1 = _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e_XZ_2[0];
            float _Split_86ec1aefda4f9e8e82b79c6195b397b0_G_2 = _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e_XZ_2[1];
            float _Split_86ec1aefda4f9e8e82b79c6195b397b0_B_3 = _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e_XZ_2[2];
            float _Split_86ec1aefda4f9e8e82b79c6195b397b0_A_4 = _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e_XZ_2[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_c9c6897e00458b8f8aa07df49fa519bc_Out_0 = _CoverHeightMapMin;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_ab94650b8edd82828661fe99e3c0e849_Out_0 = _CoverHeightMapMax;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_fe489f7321f6568686816b9eecbc16d1_Out_0 = float2(_Property_c9c6897e00458b8f8aa07df49fa519bc_Out_0, _Property_ab94650b8edd82828661fe99e3c0e849_Out_0);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_c1ab40024cb83b87960e4327efbd997f_Out_0 = _CoverHeightMapOffset;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Add_4a359522fc231c83b55ef23f341b6fb3_Out_2;
            Unity_Add_float2(_Vector2_fe489f7321f6568686816b9eecbc16d1_Out_0, (_Property_c1ab40024cb83b87960e4327efbd997f_Out_0.xx), _Add_4a359522fc231c83b55ef23f341b6fb3_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Remap_5aee5b64d41562858dc7c42d8b748894_Out_3;
            Unity_Remap_float(_Split_86ec1aefda4f9e8e82b79c6195b397b0_B_3, float2 (0, 1), _Add_4a359522fc231c83b55ef23f341b6fb3_Out_2, _Remap_5aee5b64d41562858dc7c42d8b748894_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_f0228e1cfd9c858dbb36367f551733c4_Out_2;
            Unity_Multiply_float(_Multiply_622e54e9a77b08839c0954ce5715ad1c_Out_2, _Remap_5aee5b64d41562858dc7c42d8b748894_Out_3, _Multiply_f0228e1cfd9c858dbb36367f551733c4_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_bb4d60728db93b8a9af9635fa1d69891_Out_2;
            Unity_Multiply_float(_Split_c34b73d933404283983f9c8bdb5365d3_G_2, _Multiply_f0228e1cfd9c858dbb36367f551733c4_Out_2, _Multiply_bb4d60728db93b8a9af9635fa1d69891_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Saturate_9b052a9bb99eff89bb11bdc387a0c2fd_Out_1;
            Unity_Saturate_float(_Multiply_bb4d60728db93b8a9af9635fa1d69891_Out_2, _Saturate_9b052a9bb99eff89bb11bdc387a0c2fd_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_22fb8c1cfd28b687a991e101aa13ff5b_Out_2;
            Unity_Multiply_float(_Clamp_a78f6f28770afd869adb9d12cd47370b_Out_3, _Saturate_9b052a9bb99eff89bb11bdc387a0c2fd_Out_1, _Multiply_22fb8c1cfd28b687a991e101aa13ff5b_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #if defined(_USEDYNAMICCOVERTSTATICMASKF_ON)
            float _UseDynamicCoverTStaticMaskF_20dcbac2f16cf78ebd6fd1debcd7f281_Out_0 = _Multiply_22fb8c1cfd28b687a991e101aa13ff5b_Out_2;
            #else
            float _UseDynamicCoverTStaticMaskF_20dcbac2f16cf78ebd6fd1debcd7f281_Out_0 = _Clamp_a78f6f28770afd869adb9d12cd47370b_Out_3;
            #endif
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Lerp_e5620b57c917728fa1416e2ffce9b0db_Out_3;
            Unity_Lerp_float3(_HeightBlend_7501025b3a60738a9a9d362e35a9ab48_OutVector4_1, (_Multiply_a38ba695a2660c8691763f0bd7fe159c_Out_2.xyz), (_UseDynamicCoverTStaticMaskF_20dcbac2f16cf78ebd6fd1debcd7f281_Out_0.xxx), _Lerp_e5620b57c917728fa1416e2ffce9b0db_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_c7a719bf7da79a8ea38d7311fd844f92_R_1 = _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2[0];
            float _Split_c7a719bf7da79a8ea38d7311fd844f92_G_2 = _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2[1];
            float _Split_c7a719bf7da79a8ea38d7311fd844f92_B_3 = _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2[2];
            float _Split_c7a719bf7da79a8ea38d7311fd844f92_A_4 = _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_7c5dae9b46c9e686b49e58fa996a104a_Out_0 = IgnoreBase2Alpha;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_e9060f5c0433ec889696d3e462f3229b_R_1 = _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2[0];
            float _Split_e9060f5c0433ec889696d3e462f3229b_G_2 = _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2[1];
            float _Split_e9060f5c0433ec889696d3e462f3229b_B_3 = _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2[2];
            float _Split_e9060f5c0433ec889696d3e462f3229b_A_4 = _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Branch_a7d7aece30fd9b8eb456d191fdd37a06_Out_3;
            Unity_Branch_float(_Property_7c5dae9b46c9e686b49e58fa996a104a_Out_0, _Split_c7a719bf7da79a8ea38d7311fd844f92_A_4, _Split_e9060f5c0433ec889696d3e462f3229b_A_4, _Branch_a7d7aece30fd9b8eb456d191fdd37a06_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Lerp_8692ca93f568998fbc97130b6dbc4556_Out_3;
            Unity_Lerp_float(_Split_c7a719bf7da79a8ea38d7311fd844f92_A_4, _Branch_a7d7aece30fd9b8eb456d191fdd37a06_Out_3, _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2, _Lerp_8692ca93f568998fbc97130b6dbc4556_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_0c8b7b55b9f82588ab2dcff09ee7a16d_Out_3;
            Unity_Clamp_float(_Lerp_8692ca93f568998fbc97130b6dbc4556_Out_3, 0, 1, _Clamp_0c8b7b55b9f82588ab2dcff09ee7a16d_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_6333dc4a6348088bb7281602ce6bff5f_Out_2;
            Unity_Multiply_float(_Clamp_0c8b7b55b9f82588ab2dcff09ee7a16d_Out_3, _Split_c34b73d933404283983f9c8bdb5365d3_A_4, _Multiply_6333dc4a6348088bb7281602ce6bff5f_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_9642b8fb7e32b18a91da1888c9bc375b_Out_3;
            Unity_Clamp_float(_Multiply_6333dc4a6348088bb7281602ce6bff5f_Out_2, 0, 1, _Clamp_9642b8fb7e32b18a91da1888c9bc375b_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_8bc98dd454a5508b9864a6ba09772356_Out_0 = _AlphaCutoff;
            #endif
            surface.BaseColor = _Lerp_e5620b57c917728fa1416e2ffce9b0db_Out_3;
            surface.Alpha = _Clamp_9642b8fb7e32b18a91da1888c9bc375b_Out_3;
            surface.AlphaClipThreshold = _Property_8bc98dd454a5508b9864a6ba09772356_Out_0;
            return surface;
        }

            // --------------------------------------------------
            // Build Graph Inputs

            VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceNormal =           input.normalOS;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceTangent =          input.tangentOS.xyz;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpacePosition =         input.positionOS;
        #endif


            return output;
        }
            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 unnormalizedNormalWS = input.normalWS;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        const float renormFactor = 1.0 / length(unnormalizedNormalWS);
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // use bitangent on the fly like in hdrp
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // IMPORTANT! If we ever support Flip on double sided materials ensure bitangent and tangent are NOT flipped.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float crossSign = (input.tangentWS.w > 0.0 ? 1.0 : -1.0) * GetOddNegativeScale();
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 bitang = crossSign * cross(input.normalWS.xyz, input.tangentWS.xyz);
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceNormal =            renormFactor*input.normalWS.xyz;		// we want a unit length Normal Vector node in shader graph
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // to preserve mikktspace compliance we use same scale renormFactor as was used on the normal.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // This is explained in section 2.2 in "surface gradient based bump mapping framework"
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceTangent =           renormFactor*input.tangentWS.xyz;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceBiTangent =         renormFactor*bitang;
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(input.positionWS);
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.uv0 =                         input.texCoord0;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.VertexColor =                 input.color;
        #endif

        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

            return output;
        }

            // --------------------------------------------------
            // Main

            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/PBR2DPass.hlsl"

            ENDHLSL
        }
    }
    SubShader
    {
        Tags
        {
            "RenderPipeline"="UniversalPipeline"
            "RenderType"="Transparent"
            "UniversalMaterialType" = "Lit"
            "Queue"="Transparent"
        }
        Pass
        {
            Name "Universal Forward"
            Tags
            {
                "LightMode" = "UniversalForward"
            }

            // Render State
            Cull Back
        Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
        ZTest LEqual
       ZWrite On

            // Debug
            // <None>

            // --------------------------------------------------
            // Pass

            HLSLPROGRAM

            // Pragmas
            #pragma target 2.0
        #pragma only_renderers gles gles3 glcore d3d11
        #pragma multi_compile_instancing
        #pragma multi_compile_fog
        #pragma vertex vert
        #pragma fragment frag

            // DotsInstancingOptions: <None>
            // HybridV1InjectedBuiltinProperties: <None>

            // Keywords
            #pragma multi_compile _ _SCREEN_SPACE_OCCLUSION
        #pragma multi_compile _ LIGHTMAP_ON
        #pragma multi_compile _ DIRLIGHTMAP_COMBINED
        #pragma multi_compile _ _MAIN_LIGHT_SHADOWS
        #pragma multi_compile _ _MAIN_LIGHT_SHADOWS_CASCADE
        #pragma multi_compile _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS _ADDITIONAL_OFF
        #pragma multi_compile _ _ADDITIONAL_LIGHT_SHADOWS
        #pragma multi_compile _ _SHADOWS_SOFT
        #pragma multi_compile _ LIGHTMAP_SHADOW_MIXING
        #pragma multi_compile _ SHADOWS_SHADOWMASK
            #pragma shader_feature_local _ _USEDYNAMICCOVERTSTATICMASKF_ON

        #if defined(_USEDYNAMICCOVERTSTATICMASKF_ON)
            #define KEYWORD_PERMUTATION_0
        #else
            #define KEYWORD_PERMUTATION_1
        #endif


            // Defines
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _SURFACE_TYPE_TRANSPARENT 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _AlphaClip 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMALMAP 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMAL_DROPOFF_TS 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_NORMAL
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TANGENT
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TEXCOORD0
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TEXCOORD1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_COLOR
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_POSITION_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_NORMAL_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TANGENT_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TEXCOORD0
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_COLOR
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_VIEWDIRECTION_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
        #endif

            #define FEATURES_GRAPH_VERTEX
            /* WARNING: $splice Could not find named fragment 'PassInstancing' */
            #define SHADERPASS SHADERPASS_FORWARD
            /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */

            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

            // --------------------------------------------------
            // Structs and Packing

            struct Attributes
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 positionOS : POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 normalOS : NORMAL;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 tangentOS : TANGENT;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 uv0 : TEXCOORD0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 uv1 : TEXCOORD1;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 color : COLOR;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : INSTANCEID_SEMANTIC;
            #endif
            #endif
        };
        struct Varyings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 positionWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 normalWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 tangentWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 texCoord0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 color;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 viewDirectionWS;
            #endif
            #if defined(LIGHTMAP_ON)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 lightmapUV;
            #endif
            #endif
            #if !defined(LIGHTMAP_ON)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 sh;
            #endif
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 fogFactorAndVertexLight;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 shadowCoord;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };
        struct SurfaceDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 TangentSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceBiTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 AbsoluteWorldSpacePosition;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 uv0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 VertexColor;
            #endif
        };
        struct VertexDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpacePosition;
            #endif
        };
        struct PackedVaryings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp0 : TEXCOORD0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp1 : TEXCOORD1;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 interp2 : TEXCOORD2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 interp3 : TEXCOORD3;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 interp4 : TEXCOORD4;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp5 : TEXCOORD5;
            #endif
            #if defined(LIGHTMAP_ON)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 interp6 : TEXCOORD6;
            #endif
            #endif
            #if !defined(LIGHTMAP_ON)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp7 : TEXCOORD7;
            #endif
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 interp8 : TEXCOORD8;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 interp9 : TEXCOORD9;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };

            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            output.positionCS = input.positionCS;
            output.interp0.xyz =  input.positionWS;
            output.interp1.xyz =  input.normalWS;
            output.interp2.xyzw =  input.tangentWS;
            output.interp3.xyzw =  input.texCoord0;
            output.interp4.xyzw =  input.color;
            output.interp5.xyz =  input.viewDirectionWS;
            #if defined(LIGHTMAP_ON)
            output.interp6.xy =  input.lightmapUV;
            #endif
            #if !defined(LIGHTMAP_ON)
            output.interp7.xyz =  input.sh;
            #endif
            output.interp8.xyzw =  input.fogFactorAndVertexLight;
            output.interp9.xyzw =  input.shadowCoord;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.positionWS = input.interp0.xyz;
            output.normalWS = input.interp1.xyz;
            output.tangentWS = input.interp2.xyzw;
            output.texCoord0 = input.interp3.xyzw;
            output.color = input.interp4.xyzw;
            output.viewDirectionWS = input.interp5.xyz;
            #if defined(LIGHTMAP_ON)
            output.lightmapUV = input.interp6.xy;
            #endif
            #if !defined(LIGHTMAP_ON)
            output.sh = input.interp7.xyz;
            #endif
            output.fogFactorAndVertexLight = input.interp8.xyzw;
            output.shadowCoord = input.interp9.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        #endif

            // --------------------------------------------------
            // Graph

            // Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float _AlphaCutoff;
        float4 _BaseColor;
        float4 _BaseColorMap_TexelSize;
        float _BaseUsePlanarUV;
        float4 _BaseTilingOffset;
        float4 _BaseNormalMap_TexelSize;
        float _BaseNormalScale;
        float4 _BaseMaskMap_TexelSize;
        float _BaseMetallic;
        float _BaseAORemapMin;
        float _BaseAORemapMax;
        float _BaseSmoothnessRemapMin;
        float _BaseSmoothnessRemapMax;
        float4 _LayerMask_TexelSize;
        float _Invert_Layer_Mask;
        float _Height_Transition;
        float _HeightMin;
        float _HeightMax;
        float _HeightOffset;
        float _HeightMin2;
        float _HeightMax2;
        float _HeightOffset2;
        float IgnoreBase2Alpha;
        float4 _Base2Color;
        float4 _Base2ColorMap_TexelSize;
        float4 _Base2TilingOffset;
        float _Base2UsePlanarUV;
        float4 _Base2NormalMap_TexelSize;
        float _Base2NormalScale;
        float4 _Base2MaskMap_TexelSize;
        float _Base2Metallic;
        float _Base2SmoothnessRemapMin;
        float _Base2SmoothnessRemapMax;
        float _Base2AORemapMin;
        float _Base2AORemapMax;
        float4 _CoverMaskA_TexelSize;
        float _CoverMaskPower;
        float _Cover_Amount;
        float _Cover_Amount_Grow_Speed;
        float _Cover_Max_Angle;
        float _Cover_Min_Height;
        float _Cover_Min_Height_Blending;
        float4 _CoverBaseColor;
        float4 _CoverBaseColorMap_TexelSize;
        float4 _CoverTilingOffset;
        float _CoverUsePlanarUV;
        float4 _CoverNormalMap_TexelSize;
        float _CoverNormalScale;
        float _CoverNormalBlendHardness;
        float _CoverHardness;
        float _CoverHeightMapMin;
        float _CoverHeightMapMax;
        float _CoverHeightMapOffset;
        float4 _CoverMaskMap_TexelSize;
        float _CoverMetallic;
        float _CoverAORemapMin;
        float _CoverAORemapMax;
        float _CoverSmoothnessRemapMin;
        float _CoverSmoothnessRemapMax;
        CBUFFER_END

        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_BaseColorMap);
        SAMPLER(sampler_BaseColorMap);
        TEXTURE2D(_BaseNormalMap);
        SAMPLER(sampler_BaseNormalMap);
        TEXTURE2D(_BaseMaskMap);
        SAMPLER(sampler_BaseMaskMap);
        TEXTURE2D(_LayerMask);
        SAMPLER(sampler_LayerMask);
        TEXTURE2D(_Base2ColorMap);
        SAMPLER(sampler_Base2ColorMap);
        TEXTURE2D(_Base2NormalMap);
        SAMPLER(sampler_Base2NormalMap);
        TEXTURE2D(_Base2MaskMap);
        SAMPLER(sampler_Base2MaskMap);
        TEXTURE2D(_CoverMaskA);
        SAMPLER(sampler_CoverMaskA);
        TEXTURE2D(_CoverBaseColorMap);
        SAMPLER(sampler_CoverBaseColorMap);
        TEXTURE2D(_CoverNormalMap);
        SAMPLER(sampler_CoverNormalMap);
        TEXTURE2D(_CoverMaskMap);
        SAMPLER(sampler_CoverMaskMap);

            // Graph Functions
            
        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }

        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }

        void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }

        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }

        void Unity_Branch_float2(float Predicate, float2 True, float2 False, out float2 Out)
        {
            Out = Predicate ? True : False;
        }

        struct Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6
        {
            float3 AbsoluteWorldSpacePosition;
            half4 uv0;
        };

        void SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(UnityTexture2D Texture2D_80A3D28F, float4 Vector4_2EBA7A3B, float Boolean_7ABB9909, Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 IN, out float4 XZ_2)
        {
            UnityTexture2D _Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0 = Texture2D_80A3D28F;
            float _Property_30834f691775a0898a45b1c868520436_Out_0 = Boolean_7ABB9909;
            float _Split_89ed63cb625cb3878c183d0b71c03400_R_1 = IN.AbsoluteWorldSpacePosition[0];
            float _Split_89ed63cb625cb3878c183d0b71c03400_G_2 = IN.AbsoluteWorldSpacePosition[1];
            float _Split_89ed63cb625cb3878c183d0b71c03400_B_3 = IN.AbsoluteWorldSpacePosition[2];
            float _Split_89ed63cb625cb3878c183d0b71c03400_A_4 = 0;
            float4 _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4;
            float3 _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5;
            float2 _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6;
            Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_B_3, 0, 0, _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5, _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6);
            float4 _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0 = Vector4_2EBA7A3B;
            float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[0];
            float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_G_2 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[1];
            float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_B_3 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[2];
            float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_A_4 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[3];
            float _Divide_e64179199923c58289b6aa94ea6c9178_Out_2;
            Unity_Divide_float(1, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1, _Divide_e64179199923c58289b6aa94ea6c9178_Out_2);
            float4 _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2;
            Unity_Multiply_float(_Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, (_Divide_e64179199923c58289b6aa94ea6c9178_Out_2.xxxx), _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2);
            float2 _Vector2_16c15d3bbdd14b85bd48e3a6cb318af7_Out_0 = float2(_Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_G_2);
            float2 _Vector2_f8d75f54e7705083bbec539a60185577_Out_0 = float2(_Split_2f0f52f6ef8c0e81af0da6476402bc1f_B_3, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_A_4);
            float2 _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_16c15d3bbdd14b85bd48e3a6cb318af7_Out_0, _Vector2_f8d75f54e7705083bbec539a60185577_Out_0, _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3);
            float2 _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3;
            Unity_Branch_float2(_Property_30834f691775a0898a45b1c868520436_Out_0, (_Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2.xy), _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3, _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3);
            float4 _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0 = SAMPLE_TEXTURE2D(_Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0.tex, _Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0.samplerstate, _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3);
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.r;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.g;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.b;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_A_7 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.a;
            XZ_2 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0;
        }

        void Unity_Add_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A + B;
        }

        void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
        {
            Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
        }

        void Unity_OneMinus_float(float In, out float Out)
        {
            Out = 1 - In;
        }

        void Unity_Branch_float(float Predicate, float True, float False, out float Out)
        {
            Out = Predicate ? True : False;
        }

        void Unity_Multiply_float(float A, float B, out float Out)
        {
            Out = A * B;
        }

        void Unity_Maximum_float(float A, float B, out float Out)
        {
            Out = max(A, B);
        }

        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }

        void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }

        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }

        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }

        void Unity_Divide_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A / B;
        }

        struct Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135
        {
        };

        void SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135(float3 Vector3_88EEBB5E, float Vector1_DA0A37FA, float3 Vector3_79AA92F, float Vector1_F7E83F1E, float Vector1_1C9222A6, Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 IN, out float3 OutVector4_1)
        {
            float3 _Property_dd1c841a04c03f8c85e7b00eb025ecda_Out_0 = Vector3_88EEBB5E;
            float _Property_14119cc7eaf4128f991283d47cf72d85_Out_0 = Vector1_DA0A37FA;
            float _Property_48af0ad45e3f7f82932b938695d21391_Out_0 = Vector1_DA0A37FA;
            float _Property_8a30b3ca12ff518fa473ccd686c7d503_Out_0 = Vector1_F7E83F1E;
            float _Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2;
            Unity_Maximum_float(_Property_48af0ad45e3f7f82932b938695d21391_Out_0, _Property_8a30b3ca12ff518fa473ccd686c7d503_Out_0, _Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2);
            float _Property_ee8d5fc69475d181be60c57e04ea8708_Out_0 = Vector1_1C9222A6;
            float _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2;
            Unity_Subtract_float(_Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2, _Property_ee8d5fc69475d181be60c57e04ea8708_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2);
            float _Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2;
            Unity_Subtract_float(_Property_14119cc7eaf4128f991283d47cf72d85_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2, _Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2);
            float _Maximum_d02e48d92038448cb0345e5cf3779071_Out_2;
            Unity_Maximum_float(_Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2, 0, _Maximum_d02e48d92038448cb0345e5cf3779071_Out_2);
            float3 _Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2;
            Unity_Multiply_float(_Property_dd1c841a04c03f8c85e7b00eb025ecda_Out_0, (_Maximum_d02e48d92038448cb0345e5cf3779071_Out_2.xxx), _Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2);
            float3 _Property_c7292b3b08585f8c8670172b9a220bf0_Out_0 = Vector3_79AA92F;
            float _Property_5e920479576fad83ba1947728dcceab4_Out_0 = Vector1_F7E83F1E;
            float _Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2;
            Unity_Subtract_float(_Property_5e920479576fad83ba1947728dcceab4_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2, _Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2);
            float _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2;
            Unity_Maximum_float(_Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2, 0, _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2);
            float3 _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2;
            Unity_Multiply_float(_Property_c7292b3b08585f8c8670172b9a220bf0_Out_0, (_Maximum_216777d30802328eab607c8fe68ba3a1_Out_2.xxx), _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2);
            float3 _Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2;
            Unity_Add_float3(_Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2, _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2, _Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2);
            float _Add_356384b52728f583bd6e694bc1fc3738_Out_2;
            Unity_Add_float(_Maximum_d02e48d92038448cb0345e5cf3779071_Out_2, _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2, _Add_356384b52728f583bd6e694bc1fc3738_Out_2);
            float _Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2;
            Unity_Maximum_float(_Add_356384b52728f583bd6e694bc1fc3738_Out_2, 1E-05, _Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2);
            float3 _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2;
            Unity_Divide_float3(_Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2, (_Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2.xxx), _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2);
            OutVector4_1 = _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2;
        }

        void Unity_Clamp_float(float In, float Min, float Max, out float Out)
        {
            Out = clamp(In, Min, Max);
        }

        void Unity_Sign_float3(float3 In, out float3 Out)
        {
            Out = sign(In);
        }

        void Unity_Multiply_float(float2 A, float2 B, out float2 Out)
        {
            Out = A * B;
        }

        void Unity_Normalize_float3(float3 In, out float3 Out)
        {
            Out = normalize(In);
        }

        void Unity_Branch_float3(float Predicate, float3 True, float3 False, out float3 Out)
        {
            Out = Predicate ? True : False;
        }

        struct Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8
        {
            float3 WorldSpaceNormal;
            float3 WorldSpaceTangent;
            float3 WorldSpaceBiTangent;
            float3 AbsoluteWorldSpacePosition;
            half4 uv0;
        };

        void SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(UnityTexture2D Texture2D_80A3D28F, float4 Vector4_82674548, float Boolean_9FF42DF6, Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 IN, out float4 XZ_2)
        {
            float _Property_1ef12cf3201a938993fe6a7951b0e754_Out_0 = Boolean_9FF42DF6;
            UnityTexture2D _Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0 = Texture2D_80A3D28F;
            float _Split_89ed63cb625cb3878c183d0b71c03400_R_1 = IN.AbsoluteWorldSpacePosition[0];
            float _Split_89ed63cb625cb3878c183d0b71c03400_G_2 = IN.AbsoluteWorldSpacePosition[1];
            float _Split_89ed63cb625cb3878c183d0b71c03400_B_3 = IN.AbsoluteWorldSpacePosition[2];
            float _Split_89ed63cb625cb3878c183d0b71c03400_A_4 = 0;
            float4 _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4;
            float3 _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5;
            float2 _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6;
            Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_B_3, 0, 0, _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5, _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6);
            float4 _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0 = Vector4_82674548;
            float _Split_a2e12fa5931da084b2949343a539dfd8_R_1 = _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0[0];
            float _Split_a2e12fa5931da084b2949343a539dfd8_G_2 = _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0[1];
            float _Split_a2e12fa5931da084b2949343a539dfd8_B_3 = _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0[2];
            float _Split_a2e12fa5931da084b2949343a539dfd8_A_4 = _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0[3];
            float _Divide_c36b770dfaa0bb8f85ab27da5fd794f0_Out_2;
            Unity_Divide_float(1, _Split_a2e12fa5931da084b2949343a539dfd8_R_1, _Divide_c36b770dfaa0bb8f85ab27da5fd794f0_Out_2);
            float4 _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2;
            Unity_Multiply_float(_Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, (_Divide_c36b770dfaa0bb8f85ab27da5fd794f0_Out_2.xxxx), _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2);
            float2 _Vector2_6845d21872714d889783b0cb707df3e9_Out_0 = float2(_Split_a2e12fa5931da084b2949343a539dfd8_R_1, _Split_a2e12fa5931da084b2949343a539dfd8_G_2);
            float2 _Vector2_e2e2263627c6098e96a5b5d29350ad03_Out_0 = float2(_Split_a2e12fa5931da084b2949343a539dfd8_B_3, _Split_a2e12fa5931da084b2949343a539dfd8_A_4);
            float2 _TilingAndOffset_17582d056c0b8a8dab1017d37497fe59_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_6845d21872714d889783b0cb707df3e9_Out_0, _Vector2_e2e2263627c6098e96a5b5d29350ad03_Out_0, _TilingAndOffset_17582d056c0b8a8dab1017d37497fe59_Out_3);
            float2 _Branch_1e152f3aac57448f8518bf2852c000c3_Out_3;
            Unity_Branch_float2(_Property_1ef12cf3201a938993fe6a7951b0e754_Out_0, (_Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2.xy), _TilingAndOffset_17582d056c0b8a8dab1017d37497fe59_Out_3, _Branch_1e152f3aac57448f8518bf2852c000c3_Out_3);
            float4 _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0 = SAMPLE_TEXTURE2D(_Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0.tex, _Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0.samplerstate, _Branch_1e152f3aac57448f8518bf2852c000c3_Out_3);
            _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0);
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.r;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.g;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.b;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_A_7 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.a;
            float2 _Vector2_ad6bd100e273d78fa409a30a77bfa2cc_Out_0 = float2(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4, _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5);
            float3 _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1;
            Unity_Sign_float3(IN.WorldSpaceNormal, _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1);
            float _Split_6299d4ddcc4c74828aea40a46fdb896e_R_1 = _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1[0];
            float _Split_6299d4ddcc4c74828aea40a46fdb896e_G_2 = _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1[1];
            float _Split_6299d4ddcc4c74828aea40a46fdb896e_B_3 = _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1[2];
            float _Split_6299d4ddcc4c74828aea40a46fdb896e_A_4 = 0;
            float2 _Vector2_b76cb1842101e58b9e636d49b075c612_Out_0 = float2(_Split_6299d4ddcc4c74828aea40a46fdb896e_G_2, 1);
            float2 _Multiply_31e8db88ee20c985a9850d1a58f3282b_Out_2;
            Unity_Multiply_float(_Vector2_ad6bd100e273d78fa409a30a77bfa2cc_Out_0, _Vector2_b76cb1842101e58b9e636d49b075c612_Out_0, _Multiply_31e8db88ee20c985a9850d1a58f3282b_Out_2);
            float _Split_5ed44bf2eca0868f81eb18100f49d1fa_R_1 = IN.WorldSpaceNormal[0];
            float _Split_5ed44bf2eca0868f81eb18100f49d1fa_G_2 = IN.WorldSpaceNormal[1];
            float _Split_5ed44bf2eca0868f81eb18100f49d1fa_B_3 = IN.WorldSpaceNormal[2];
            float _Split_5ed44bf2eca0868f81eb18100f49d1fa_A_4 = 0;
            float2 _Vector2_70e5837843f28b8b9d64cada3697bd5a_Out_0 = float2(_Split_5ed44bf2eca0868f81eb18100f49d1fa_R_1, _Split_5ed44bf2eca0868f81eb18100f49d1fa_B_3);
            float2 _Add_1145b2f896593d80aa864a34e6702562_Out_2;
            Unity_Add_float2(_Multiply_31e8db88ee20c985a9850d1a58f3282b_Out_2, _Vector2_70e5837843f28b8b9d64cada3697bd5a_Out_0, _Add_1145b2f896593d80aa864a34e6702562_Out_2);
            float _Split_2bc77ca2d17bd78cb2383770ce50b179_R_1 = _Add_1145b2f896593d80aa864a34e6702562_Out_2[0];
            float _Split_2bc77ca2d17bd78cb2383770ce50b179_G_2 = _Add_1145b2f896593d80aa864a34e6702562_Out_2[1];
            float _Split_2bc77ca2d17bd78cb2383770ce50b179_B_3 = 0;
            float _Split_2bc77ca2d17bd78cb2383770ce50b179_A_4 = 0;
            float _Multiply_ab12aea87465a78eaf7fc66c2598d266_Out_2;
            Unity_Multiply_float(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6, _Split_5ed44bf2eca0868f81eb18100f49d1fa_G_2, _Multiply_ab12aea87465a78eaf7fc66c2598d266_Out_2);
            float3 _Vector3_433840b555db308b97e9b14b6a957195_Out_0 = float3(_Split_2bc77ca2d17bd78cb2383770ce50b179_R_1, _Multiply_ab12aea87465a78eaf7fc66c2598d266_Out_2, _Split_2bc77ca2d17bd78cb2383770ce50b179_G_2);
            float3x3 Transform_c7914cc45a011c89b3f53c55afb51673_tangentTransform_World = float3x3(IN.WorldSpaceTangent, IN.WorldSpaceBiTangent, IN.WorldSpaceNormal);
            float3 _Transform_c7914cc45a011c89b3f53c55afb51673_Out_1 = TransformWorldToTangent(_Vector3_433840b555db308b97e9b14b6a957195_Out_0.xyz, Transform_c7914cc45a011c89b3f53c55afb51673_tangentTransform_World);
            float3 _Normalize_09bf8a2bd0a4d38e8b97d5c674f79b44_Out_1;
            Unity_Normalize_float3(_Transform_c7914cc45a011c89b3f53c55afb51673_Out_1, _Normalize_09bf8a2bd0a4d38e8b97d5c674f79b44_Out_1);
            float3 _Branch_9eadf909a90f2f80880f8c56ecc2a91f_Out_3;
            Unity_Branch_float3(_Property_1ef12cf3201a938993fe6a7951b0e754_Out_0, _Normalize_09bf8a2bd0a4d38e8b97d5c674f79b44_Out_1, (_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.xyz), _Branch_9eadf909a90f2f80880f8c56ecc2a91f_Out_3);
            XZ_2 = (float4(_Branch_9eadf909a90f2f80880f8c56ecc2a91f_Out_3, 1.0));
        }

        void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
        {
            Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
        }

        void Unity_Absolute_float(float In, out float Out)
        {
            Out = abs(In);
        }

        void Unity_Power_float(float A, float B, out float Out)
        {
            Out = pow(A, B);
        }

        void Unity_Saturate_float(float In, out float Out)
        {
            Out = saturate(In);
        }

        void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
        {
            Out = lerp(A, B, T);
        }

        void Unity_Lerp_float(float A, float B, float T, out float Out)
        {
            Out = lerp(A, B, T);
        }

            // Graph Vertex
            struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };

        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }

            // Graph Pixel
            struct SurfaceDescription
        {
            float3 BaseColor;
            float3 NormalTS;
            float3 Emission;
            float Metallic;
            float Smoothness;
            float Occlusion;
            float Alpha;
            float AlphaClipThreshold;
        };

        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_07d75b1d2628da808a2efb93a1d6219e_Out_0 = UnityBuildTexture2DStructNoScale(_BaseColorMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0 = _BaseTilingOffset;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_7f998178363b4188ba2f07298ef869c1_Out_0 = _BaseUsePlanarUV;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e;
            _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e.uv0 = IN.uv0;
            float4 _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2;
            SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(_Property_07d75b1d2628da808a2efb93a1d6219e_Out_0, _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0, _Property_7f998178363b4188ba2f07298ef869c1_Out_0, _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e, _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_b83097c58639858680bf43881a95b0af_Out_0 = _BaseColor;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2;
            Unity_Multiply_float(_PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2, _Property_b83097c58639858680bf43881a95b0af_Out_0, _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_1e449ff9f8e8ec828507233e8240eb11_Out_0 = UnityBuildTexture2DStructNoScale(_BaseMaskMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_4245c3b264047180b5c90a697d6cb278;
            _PlanarNM_4245c3b264047180b5c90a697d6cb278.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNM_4245c3b264047180b5c90a697d6cb278.uv0 = IN.uv0;
            float4 _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2;
            SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(_Property_1e449ff9f8e8ec828507233e8240eb11_Out_0, _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0, _Property_7f998178363b4188ba2f07298ef869c1_Out_0, _PlanarNM_4245c3b264047180b5c90a697d6cb278, _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_91a015dea8acd38b904ba0935328a5bc_R_1 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[0];
            float _Split_91a015dea8acd38b904ba0935328a5bc_G_2 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[1];
            float _Split_91a015dea8acd38b904ba0935328a5bc_B_3 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[2];
            float _Split_91a015dea8acd38b904ba0935328a5bc_A_4 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_fbcff1469ebf488394a8a89ddaf0eb2a_Out_0 = _HeightMin;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_9df7a44c8225168683743ac60c0c3c34_Out_0 = _HeightMax;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_9b1e95888c28bc8893f28c02b87fa448_Out_0 = float2(_Property_fbcff1469ebf488394a8a89ddaf0eb2a_Out_0, _Property_9df7a44c8225168683743ac60c0c3c34_Out_0);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_29ca14fd0b712983a38d63d2dd326e96_Out_0 = _HeightOffset;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Add_cb503f8a09720d84bb03cbd89e37b80c_Out_2;
            Unity_Add_float2(_Vector2_9b1e95888c28bc8893f28c02b87fa448_Out_0, (_Property_29ca14fd0b712983a38d63d2dd326e96_Out_0.xx), _Add_cb503f8a09720d84bb03cbd89e37b80c_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3;
            Unity_Remap_float(_Split_91a015dea8acd38b904ba0935328a5bc_B_3, float2 (0, 1), _Add_cb503f8a09720d84bb03cbd89e37b80c_Out_2, _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_ba3a5f4cba7d0a8fa288ffc8267d6c0e_Out_0 = UnityBuildTexture2DStructNoScale(_Base2ColorMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_86a4657df480d48e8d3ad3b036731380_Out_0 = _Base2TilingOffset;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0 = _Base2UsePlanarUV;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4;
            _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4.uv0 = IN.uv0;
            float4 _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4_XZ_2;
            SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(_Property_ba3a5f4cba7d0a8fa288ffc8267d6c0e_Out_0, _Property_86a4657df480d48e8d3ad3b036731380_Out_0, _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0, _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4, _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_3561b11b899bda8e855826445cf628aa_Out_0 = _Base2Color;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2;
            Unity_Multiply_float(_PlanarNM_5aeab444ca6fd78ea56a01215880a5a4_XZ_2, _Property_3561b11b899bda8e855826445cf628aa_Out_0, _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_c34b73d933404283983f9c8bdb5365d3_R_1 = IN.VertexColor[0];
            float _Split_c34b73d933404283983f9c8bdb5365d3_G_2 = IN.VertexColor[1];
            float _Split_c34b73d933404283983f9c8bdb5365d3_B_3 = IN.VertexColor[2];
            float _Split_c34b73d933404283983f9c8bdb5365d3_A_4 = IN.VertexColor[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_df2df7bb5cfc3381beee7ec454da7542_Out_0 = _Invert_Layer_Mask;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_c7b1e2df9f9b0e8eace9b2274924e69c_Out_0 = UnityBuildTexture2DStructNoScale(_LayerMask);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0 = SAMPLE_TEXTURE2D(_Property_c7b1e2df9f9b0e8eace9b2274924e69c_Out_0.tex, _Property_c7b1e2df9f9b0e8eace9b2274924e69c_Out_0.samplerstate, IN.uv0.xy);
            float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.r;
            float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_G_5 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.g;
            float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_B_6 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.b;
            float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_A_7 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1;
            Unity_OneMinus_float(_SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4, _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Branch_af0c5e511241ce8eae748ae487df50fa_Out_3;
            Unity_Branch_float(_Property_df2df7bb5cfc3381beee7ec454da7542_Out_0, _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1, _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4, _Branch_af0c5e511241ce8eae748ae487df50fa_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_de4f6eb48a629285a664dad7fb06438f_Out_0 = UnityBuildTexture2DStructNoScale(_Base2MaskMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_d5657f470f05ef839e4c257a20ace8cb;
            _PlanarNM_d5657f470f05ef839e4c257a20ace8cb.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNM_d5657f470f05ef839e4c257a20ace8cb.uv0 = IN.uv0;
            float4 _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2;
            SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(_Property_de4f6eb48a629285a664dad7fb06438f_Out_0, _Property_86a4657df480d48e8d3ad3b036731380_Out_0, _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0, _PlanarNM_d5657f470f05ef839e4c257a20ace8cb, _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_83ec66b648ab6c84848b42686c256cd7_R_1 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[0];
            float _Split_83ec66b648ab6c84848b42686c256cd7_G_2 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[1];
            float _Split_83ec66b648ab6c84848b42686c256cd7_B_3 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[2];
            float _Split_83ec66b648ab6c84848b42686c256cd7_A_4 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_ce1750e5c69e97818667b412fc3f9f2c_Out_0 = _HeightMin2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_8e0f2ea54d8ede89bbabdf31a9bafd57_Out_0 = _HeightMax2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_fb6c6dd7e70e768ba686e8e94153bb96_Out_0 = float2(_Property_ce1750e5c69e97818667b412fc3f9f2c_Out_0, _Property_8e0f2ea54d8ede89bbabdf31a9bafd57_Out_0);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_151ae2702b614585af2000f0a812960f_Out_0 = _HeightOffset2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2;
            Unity_Add_float2(_Vector2_fb6c6dd7e70e768ba686e8e94153bb96_Out_0, (_Property_151ae2702b614585af2000f0a812960f_Out_0.xx), _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3;
            Unity_Remap_float(_Split_83ec66b648ab6c84848b42686c256cd7_B_3, float2 (0, 1), _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2, _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2;
            Unity_Multiply_float(_Branch_af0c5e511241ce8eae748ae487df50fa_Out_3, _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3, _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2;
            Unity_Multiply_float(_Split_c34b73d933404283983f9c8bdb5365d3_R_1, _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2, _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_818c8af4b930138e81034c886614171d_Out_0 = _Height_Transition;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 _HeightBlend_7501025b3a60738a9a9d362e35a9ab48;
            float3 _HeightBlend_7501025b3a60738a9a9d362e35a9ab48_OutVector4_1;
            SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135((_Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2.xyz), _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3, (_Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2.xyz), _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2, _Property_818c8af4b930138e81034c886614171d_Out_0, _HeightBlend_7501025b3a60738a9a9d362e35a9ab48, _HeightBlend_7501025b3a60738a9a9d362e35a9ab48_OutVector4_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_c0ebdab0f71ace8aabaa865fd7293599_Out_0 = UnityBuildTexture2DStructNoScale(_CoverBaseColorMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_822489d2e6d3e08590c64f085ffd9b2e_Out_0 = _CoverTilingOffset;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_2ae4a163bd21d98789af282d6e469175_Out_0 = _CoverUsePlanarUV;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_8bb420494d19b28e9ccdff489802dc81;
            _PlanarNM_8bb420494d19b28e9ccdff489802dc81.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNM_8bb420494d19b28e9ccdff489802dc81.uv0 = IN.uv0;
            float4 _PlanarNM_8bb420494d19b28e9ccdff489802dc81_XZ_2;
            SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(_Property_c0ebdab0f71ace8aabaa865fd7293599_Out_0, _Property_822489d2e6d3e08590c64f085ffd9b2e_Out_0, _Property_2ae4a163bd21d98789af282d6e469175_Out_0, _PlanarNM_8bb420494d19b28e9ccdff489802dc81, _PlanarNM_8bb420494d19b28e9ccdff489802dc81_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_55e7941fa7ac5f8387aa9bb633b08883_Out_0 = _CoverBaseColor;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Multiply_a38ba695a2660c8691763f0bd7fe159c_Out_2;
            Unity_Multiply_float(_PlanarNM_8bb420494d19b28e9ccdff489802dc81_XZ_2, _Property_55e7941fa7ac5f8387aa9bb633b08883_Out_0, _Multiply_a38ba695a2660c8691763f0bd7fe159c_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_c0d223db25424a8ab0cee2de2bbf58ce_Out_0 = UnityBuildTexture2DStructNoScale(_CoverMaskA);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _UV_5352c8dd0add178ba83a5421c2c0b3f0_Out_0 = IN.uv0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _SampleTexture2D_024ba490c015248988a12a9d670014ea_RGBA_0 = SAMPLE_TEXTURE2D(_Property_c0d223db25424a8ab0cee2de2bbf58ce_Out_0.tex, _Property_c0d223db25424a8ab0cee2de2bbf58ce_Out_0.samplerstate, (_UV_5352c8dd0add178ba83a5421c2c0b3f0_Out_0.xy));
            float _SampleTexture2D_024ba490c015248988a12a9d670014ea_R_4 = _SampleTexture2D_024ba490c015248988a12a9d670014ea_RGBA_0.r;
            float _SampleTexture2D_024ba490c015248988a12a9d670014ea_G_5 = _SampleTexture2D_024ba490c015248988a12a9d670014ea_RGBA_0.g;
            float _SampleTexture2D_024ba490c015248988a12a9d670014ea_B_6 = _SampleTexture2D_024ba490c015248988a12a9d670014ea_RGBA_0.b;
            float _SampleTexture2D_024ba490c015248988a12a9d670014ea_A_7 = _SampleTexture2D_024ba490c015248988a12a9d670014ea_RGBA_0.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_b80e7b96604b7c82bbf9bff4981fad76_Out_0 = _CoverMaskPower;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_abe410d256783480b1b58468bf78a882_Out_2;
            Unity_Multiply_float(_SampleTexture2D_024ba490c015248988a12a9d670014ea_A_7, _Property_b80e7b96604b7c82bbf9bff4981fad76_Out_0, _Multiply_abe410d256783480b1b58468bf78a882_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_a78f6f28770afd869adb9d12cd47370b_Out_3;
            Unity_Clamp_float(_Multiply_abe410d256783480b1b58468bf78a882_Out_2, 0, 1, _Clamp_a78f6f28770afd869adb9d12cd47370b_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_7c7049e15fdff386b535790d8666f609_Out_0 = UnityBuildTexture2DStructNoScale(_BaseNormalMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8;
            _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.WorldSpaceNormal = IN.WorldSpaceNormal;
            _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.WorldSpaceTangent = IN.WorldSpaceTangent;
            _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
            _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.uv0 = IN.uv0;
            float4 _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8_XZ_2;
            SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(_Property_7c7049e15fdff386b535790d8666f609_Out_0, _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0, _Property_7f998178363b4188ba2f07298ef869c1_Out_0, _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8, _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_d4b0759cf4647e81be065ec1465ce2b4_Out_0 = _BaseNormalScale;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _NormalStrength_f66a9108ea294886acc61513b41cc5e4_Out_2;
            Unity_NormalStrength_float((_PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8_XZ_2.xyz), _Property_d4b0759cf4647e81be065ec1465ce2b4_Out_0, _NormalStrength_f66a9108ea294886acc61513b41cc5e4_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_fa9f7890b20ad481a92543c04b237bde_Out_0 = UnityBuildTexture2DStructNoScale(_Base2NormalMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf;
            _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.WorldSpaceNormal = IN.WorldSpaceNormal;
            _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.WorldSpaceTangent = IN.WorldSpaceTangent;
            _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
            _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.uv0 = IN.uv0;
            float4 _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf_XZ_2;
            SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(_Property_fa9f7890b20ad481a92543c04b237bde_Out_0, _Property_86a4657df480d48e8d3ad3b036731380_Out_0, _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0, _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf, _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_8c31443b776727819a663c7ddce79064_Out_0 = _Base2NormalScale;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _NormalStrength_0fb86880ab8e368dac6d01b830e20ed8_Out_2;
            Unity_NormalStrength_float((_PlanarNMn_d7b3ec528088a085a5102e025a1b45cf_XZ_2.xyz), _Property_8c31443b776727819a663c7ddce79064_Out_0, _NormalStrength_0fb86880ab8e368dac6d01b830e20ed8_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 _HeightBlend_7c09d97625efce898e21b66cd039be8b;
            float3 _HeightBlend_7c09d97625efce898e21b66cd039be8b_OutVector4_1;
            SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135(_NormalStrength_f66a9108ea294886acc61513b41cc5e4_Out_2, _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3, _NormalStrength_0fb86880ab8e368dac6d01b830e20ed8_Out_2, _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2, _Property_818c8af4b930138e81034c886614171d_Out_0, _HeightBlend_7c09d97625efce898e21b66cd039be8b, _HeightBlend_7c09d97625efce898e21b66cd039be8b_OutVector4_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_65f7dd6fe6c29b83913af586c597a1ef_Out_0 = UnityBuildTexture2DStructNoScale(_CoverNormalMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3;
            _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3.WorldSpaceNormal = IN.WorldSpaceNormal;
            _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3.WorldSpaceTangent = IN.WorldSpaceTangent;
            _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
            _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3.uv0 = IN.uv0;
            float4 _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3_XZ_2;
            SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(_Property_65f7dd6fe6c29b83913af586c597a1ef_Out_0, _Property_822489d2e6d3e08590c64f085ffd9b2e_Out_0, _Property_2ae4a163bd21d98789af282d6e469175_Out_0, _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3, _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_19f92cae42737480a95820c51d4ba124_Out_0 = _CoverNormalBlendHardness;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _NormalStrength_2c3488591b8345869feb25a3dee06c3f_Out_2;
            Unity_NormalStrength_float((_PlanarNMn_248bc5b7421d3f828d166902c73ca6c3_XZ_2.xyz), _Property_19f92cae42737480a95820c51d4ba124_Out_0, _NormalStrength_2c3488591b8345869feb25a3dee06c3f_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_96bfe9cb80ad308385c191d094b3d071_R_1 = IN.WorldSpaceNormal[0];
            float _Split_96bfe9cb80ad308385c191d094b3d071_G_2 = IN.WorldSpaceNormal[1];
            float _Split_96bfe9cb80ad308385c191d094b3d071_B_3 = IN.WorldSpaceNormal[2];
            float _Split_96bfe9cb80ad308385c191d094b3d071_A_4 = 0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_0dd796aae8cd9f878bef13ceac4fe3ec_Out_0 = _Cover_Amount;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_67285cdc688aa38d83f62d5bb095d597_Out_0 = _Cover_Amount_Grow_Speed;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Subtract_fcefec675e7536888eccf5574d921972_Out_2;
            Unity_Subtract_float(4, _Property_67285cdc688aa38d83f62d5bb095d597_Out_0, _Subtract_fcefec675e7536888eccf5574d921972_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Divide_1e25465528e612839a4ce1faedd89e7d_Out_2;
            Unity_Divide_float(_Property_0dd796aae8cd9f878bef13ceac4fe3ec_Out_0, _Subtract_fcefec675e7536888eccf5574d921972_Out_2, _Divide_1e25465528e612839a4ce1faedd89e7d_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Absolute_d20b810ffdec828ab74dd6692d82f01b_Out_1;
            Unity_Absolute_float(_Divide_1e25465528e612839a4ce1faedd89e7d_Out_2, _Absolute_d20b810ffdec828ab74dd6692d82f01b_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Power_181fbf47cfdb258da1fe0b72a450986f_Out_2;
            Unity_Power_float(_Absolute_d20b810ffdec828ab74dd6692d82f01b_Out_1, _Subtract_fcefec675e7536888eccf5574d921972_Out_2, _Power_181fbf47cfdb258da1fe0b72a450986f_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_11f62dba01f1a38c9e0a9972ccd19246_Out_3;
            Unity_Clamp_float(_Power_181fbf47cfdb258da1fe0b72a450986f_Out_2, 0, 2, _Clamp_11f62dba01f1a38c9e0a9972ccd19246_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_9810f6d76275cd8fbe5e3a02360b98a7_Out_2;
            Unity_Multiply_float(_Split_96bfe9cb80ad308385c191d094b3d071_G_2, _Clamp_11f62dba01f1a38c9e0a9972ccd19246_Out_3, _Multiply_9810f6d76275cd8fbe5e3a02360b98a7_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Saturate_a007c5f214685c87bf6ca3e64c06b488_Out_1;
            Unity_Saturate_float(_Multiply_9810f6d76275cd8fbe5e3a02360b98a7_Out_2, _Saturate_a007c5f214685c87bf6ca3e64c06b488_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_1b2b25b617fc508b9835f0309136fd00_Out_3;
            Unity_Clamp_float(_Split_96bfe9cb80ad308385c191d094b3d071_G_2, 0, 0.9999, _Clamp_1b2b25b617fc508b9835f0309136fd00_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_7b12276ea7a4538db6804507b30a830c_Out_0 = _Cover_Max_Angle;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Divide_54c523ff4b7acb858e9e368fd1e4d34a_Out_2;
            Unity_Divide_float(_Property_7b12276ea7a4538db6804507b30a830c_Out_0, 45, _Divide_54c523ff4b7acb858e9e368fd1e4d34a_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _OneMinus_6cf431985b651e8e9546ae6cb2d4d668_Out_1;
            Unity_OneMinus_float(_Divide_54c523ff4b7acb858e9e368fd1e4d34a_Out_2, _OneMinus_6cf431985b651e8e9546ae6cb2d4d668_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Subtract_4ef7b60aeab8d589bf2d2423737642bc_Out_2;
            Unity_Subtract_float(_Clamp_1b2b25b617fc508b9835f0309136fd00_Out_3, _OneMinus_6cf431985b651e8e9546ae6cb2d4d668_Out_1, _Subtract_4ef7b60aeab8d589bf2d2423737642bc_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_a4b51894ea17818c9a27bb533a2ebe74_Out_3;
            Unity_Clamp_float(_Subtract_4ef7b60aeab8d589bf2d2423737642bc_Out_2, 0, 2, _Clamp_a4b51894ea17818c9a27bb533a2ebe74_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Divide_c4196d4f02190b89ba827ccd4ae8a74d_Out_2;
            Unity_Divide_float(1, _Divide_54c523ff4b7acb858e9e368fd1e4d34a_Out_2, _Divide_c4196d4f02190b89ba827ccd4ae8a74d_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_ffc22433163d1184846ede424b44bcb2_Out_2;
            Unity_Multiply_float(_Clamp_a4b51894ea17818c9a27bb533a2ebe74_Out_3, _Divide_c4196d4f02190b89ba827ccd4ae8a74d_Out_2, _Multiply_ffc22433163d1184846ede424b44bcb2_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Absolute_c2e5757082de5d878d4c023806fb2108_Out_1;
            Unity_Absolute_float(_Multiply_ffc22433163d1184846ede424b44bcb2_Out_2, _Absolute_c2e5757082de5d878d4c023806fb2108_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_849d9f217c95f38c9d49ab251578d8d5_Out_0 = _CoverHardness;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Power_578546d66d69a5829b745ebba1279adf_Out_2;
            Unity_Power_float(_Absolute_c2e5757082de5d878d4c023806fb2108_Out_1, _Property_849d9f217c95f38c9d49ab251578d8d5_Out_0, _Power_578546d66d69a5829b745ebba1279adf_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_34d2d3aff4814e8e83d2894b3512c6c8_Out_0 = _Cover_Min_Height;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _OneMinus_474df64227f004849b34c68fe8df93f2_Out_1;
            Unity_OneMinus_float(_Property_34d2d3aff4814e8e83d2894b3512c6c8_Out_0, _OneMinus_474df64227f004849b34c68fe8df93f2_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_ee4d9dc934b3508397d5a3dece110ab0_R_1 = IN.AbsoluteWorldSpacePosition[0];
            float _Split_ee4d9dc934b3508397d5a3dece110ab0_G_2 = IN.AbsoluteWorldSpacePosition[1];
            float _Split_ee4d9dc934b3508397d5a3dece110ab0_B_3 = IN.AbsoluteWorldSpacePosition[2];
            float _Split_ee4d9dc934b3508397d5a3dece110ab0_A_4 = 0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Add_d6bc513aa82d918ea24e279f4353d971_Out_2;
            Unity_Add_float(_OneMinus_474df64227f004849b34c68fe8df93f2_Out_1, _Split_ee4d9dc934b3508397d5a3dece110ab0_G_2, _Add_d6bc513aa82d918ea24e279f4353d971_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Add_a6a61cb12180108c9e1364b90d2673e2_Out_2;
            Unity_Add_float(_Add_d6bc513aa82d918ea24e279f4353d971_Out_2, 1, _Add_a6a61cb12180108c9e1364b90d2673e2_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_1874fdd00cb9aa839d93ab8536e2414d_Out_3;
            Unity_Clamp_float(_Add_a6a61cb12180108c9e1364b90d2673e2_Out_2, 0, 1, _Clamp_1874fdd00cb9aa839d93ab8536e2414d_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_7b91fd6e21b46c85816c7b681307cbe4_Out_0 = _Cover_Min_Height_Blending;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Add_6dca9453f6a35e8185c4b8e9782db0a9_Out_2;
            Unity_Add_float(_Add_d6bc513aa82d918ea24e279f4353d971_Out_2, _Property_7b91fd6e21b46c85816c7b681307cbe4_Out_0, _Add_6dca9453f6a35e8185c4b8e9782db0a9_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Divide_83415a319ecfba83af914cbc5487b546_Out_2;
            Unity_Divide_float(_Add_6dca9453f6a35e8185c4b8e9782db0a9_Out_2, _Add_d6bc513aa82d918ea24e279f4353d971_Out_2, _Divide_83415a319ecfba83af914cbc5487b546_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _OneMinus_bf150b22fcad5a87b7c825c9c6cf1687_Out_1;
            Unity_OneMinus_float(_Divide_83415a319ecfba83af914cbc5487b546_Out_2, _OneMinus_bf150b22fcad5a87b7c825c9c6cf1687_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Add_86ff9fa850efbe8c80705d8266609dab_Out_2;
            Unity_Add_float(_OneMinus_bf150b22fcad5a87b7c825c9c6cf1687_Out_1, -0.5, _Add_86ff9fa850efbe8c80705d8266609dab_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_906e140f01222d8ba61252ec6ec9d6a4_Out_3;
            Unity_Clamp_float(_Add_86ff9fa850efbe8c80705d8266609dab_Out_2, 0, 1, _Clamp_906e140f01222d8ba61252ec6ec9d6a4_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Add_c1ec5849bf72f585a30b3e11a91ada52_Out_2;
            Unity_Add_float(_Clamp_1874fdd00cb9aa839d93ab8536e2414d_Out_3, _Clamp_906e140f01222d8ba61252ec6ec9d6a4_Out_3, _Add_c1ec5849bf72f585a30b3e11a91ada52_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_17a8a0cf209a038b9e9c7f5681cdd1fb_Out_3;
            Unity_Clamp_float(_Add_c1ec5849bf72f585a30b3e11a91ada52_Out_2, 0, 1, _Clamp_17a8a0cf209a038b9e9c7f5681cdd1fb_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_8c2759ac24a9b289b1e9610cfd161bb0_Out_2;
            Unity_Multiply_float(_Power_578546d66d69a5829b745ebba1279adf_Out_2, _Clamp_17a8a0cf209a038b9e9c7f5681cdd1fb_Out_3, _Multiply_8c2759ac24a9b289b1e9610cfd161bb0_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_1a723f136ec7fa8c957b5d29e03d3051_Out_2;
            Unity_Multiply_float(_Saturate_a007c5f214685c87bf6ca3e64c06b488_Out_1, _Multiply_8c2759ac24a9b289b1e9610cfd161bb0_Out_2, _Multiply_1a723f136ec7fa8c957b5d29e03d3051_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Lerp_d1c72e47b283948584479177786ae8d5_Out_3;
            Unity_Lerp_float3(_HeightBlend_7c09d97625efce898e21b66cd039be8b_OutVector4_1, _NormalStrength_2c3488591b8345869feb25a3dee06c3f_Out_2, (_Multiply_1a723f136ec7fa8c957b5d29e03d3051_Out_2.xxx), _Lerp_d1c72e47b283948584479177786ae8d5_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3x3 Transform_180fb403b53f318db002e8eba7616644_transposeTangent = transpose(float3x3(IN.WorldSpaceTangent, IN.WorldSpaceBiTangent, IN.WorldSpaceNormal));
            float3 _Transform_180fb403b53f318db002e8eba7616644_Out_1 = normalize(mul(Transform_180fb403b53f318db002e8eba7616644_transposeTangent, _Lerp_d1c72e47b283948584479177786ae8d5_Out_3.xyz).xyz);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_c9a2b4fb4f688b8ebfc1436535cd5ba4_R_1 = _Transform_180fb403b53f318db002e8eba7616644_Out_1[0];
            float _Split_c9a2b4fb4f688b8ebfc1436535cd5ba4_G_2 = _Transform_180fb403b53f318db002e8eba7616644_Out_1[1];
            float _Split_c9a2b4fb4f688b8ebfc1436535cd5ba4_B_3 = _Transform_180fb403b53f318db002e8eba7616644_Out_1[2];
            float _Split_c9a2b4fb4f688b8ebfc1436535cd5ba4_A_4 = 0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_4c7631d0688102819e6d388d624855a1_Out_2;
            Unity_Multiply_float(_Split_c9a2b4fb4f688b8ebfc1436535cd5ba4_G_2, _Clamp_11f62dba01f1a38c9e0a9972ccd19246_Out_3, _Multiply_4c7631d0688102819e6d388d624855a1_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_f2887eb409f6bb81ae4caad2b01b17f1_Out_2;
            Unity_Multiply_float(_Clamp_11f62dba01f1a38c9e0a9972ccd19246_Out_3, _Property_849d9f217c95f38c9d49ab251578d8d5_Out_0, _Multiply_f2887eb409f6bb81ae4caad2b01b17f1_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_2e348ed31331e78791b2b3130a009f30_Out_2;
            Unity_Multiply_float(_Multiply_f2887eb409f6bb81ae4caad2b01b17f1_Out_2, _Multiply_8c2759ac24a9b289b1e9610cfd161bb0_Out_2, _Multiply_2e348ed31331e78791b2b3130a009f30_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_622e54e9a77b08839c0954ce5715ad1c_Out_2;
            Unity_Multiply_float(_Multiply_4c7631d0688102819e6d388d624855a1_Out_2, _Multiply_2e348ed31331e78791b2b3130a009f30_Out_2, _Multiply_622e54e9a77b08839c0954ce5715ad1c_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_608db04fab7d768d9a8b5fb9cf0768e1_Out_0 = UnityBuildTexture2DStructNoScale(_CoverMaskMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e;
            _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e.uv0 = IN.uv0;
            float4 _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e_XZ_2;
            SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(_Property_608db04fab7d768d9a8b5fb9cf0768e1_Out_0, _Property_822489d2e6d3e08590c64f085ffd9b2e_Out_0, _Property_2ae4a163bd21d98789af282d6e469175_Out_0, _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e, _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_86ec1aefda4f9e8e82b79c6195b397b0_R_1 = _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e_XZ_2[0];
            float _Split_86ec1aefda4f9e8e82b79c6195b397b0_G_2 = _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e_XZ_2[1];
            float _Split_86ec1aefda4f9e8e82b79c6195b397b0_B_3 = _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e_XZ_2[2];
            float _Split_86ec1aefda4f9e8e82b79c6195b397b0_A_4 = _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e_XZ_2[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_c9c6897e00458b8f8aa07df49fa519bc_Out_0 = _CoverHeightMapMin;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_ab94650b8edd82828661fe99e3c0e849_Out_0 = _CoverHeightMapMax;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_fe489f7321f6568686816b9eecbc16d1_Out_0 = float2(_Property_c9c6897e00458b8f8aa07df49fa519bc_Out_0, _Property_ab94650b8edd82828661fe99e3c0e849_Out_0);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_c1ab40024cb83b87960e4327efbd997f_Out_0 = _CoverHeightMapOffset;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Add_4a359522fc231c83b55ef23f341b6fb3_Out_2;
            Unity_Add_float2(_Vector2_fe489f7321f6568686816b9eecbc16d1_Out_0, (_Property_c1ab40024cb83b87960e4327efbd997f_Out_0.xx), _Add_4a359522fc231c83b55ef23f341b6fb3_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Remap_5aee5b64d41562858dc7c42d8b748894_Out_3;
            Unity_Remap_float(_Split_86ec1aefda4f9e8e82b79c6195b397b0_B_3, float2 (0, 1), _Add_4a359522fc231c83b55ef23f341b6fb3_Out_2, _Remap_5aee5b64d41562858dc7c42d8b748894_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_f0228e1cfd9c858dbb36367f551733c4_Out_2;
            Unity_Multiply_float(_Multiply_622e54e9a77b08839c0954ce5715ad1c_Out_2, _Remap_5aee5b64d41562858dc7c42d8b748894_Out_3, _Multiply_f0228e1cfd9c858dbb36367f551733c4_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_bb4d60728db93b8a9af9635fa1d69891_Out_2;
            Unity_Multiply_float(_Split_c34b73d933404283983f9c8bdb5365d3_G_2, _Multiply_f0228e1cfd9c858dbb36367f551733c4_Out_2, _Multiply_bb4d60728db93b8a9af9635fa1d69891_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Saturate_9b052a9bb99eff89bb11bdc387a0c2fd_Out_1;
            Unity_Saturate_float(_Multiply_bb4d60728db93b8a9af9635fa1d69891_Out_2, _Saturate_9b052a9bb99eff89bb11bdc387a0c2fd_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_22fb8c1cfd28b687a991e101aa13ff5b_Out_2;
            Unity_Multiply_float(_Clamp_a78f6f28770afd869adb9d12cd47370b_Out_3, _Saturate_9b052a9bb99eff89bb11bdc387a0c2fd_Out_1, _Multiply_22fb8c1cfd28b687a991e101aa13ff5b_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #if defined(_USEDYNAMICCOVERTSTATICMASKF_ON)
            float _UseDynamicCoverTStaticMaskF_20dcbac2f16cf78ebd6fd1debcd7f281_Out_0 = _Multiply_22fb8c1cfd28b687a991e101aa13ff5b_Out_2;
            #else
            float _UseDynamicCoverTStaticMaskF_20dcbac2f16cf78ebd6fd1debcd7f281_Out_0 = _Clamp_a78f6f28770afd869adb9d12cd47370b_Out_3;
            #endif
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Lerp_e5620b57c917728fa1416e2ffce9b0db_Out_3;
            Unity_Lerp_float3(_HeightBlend_7501025b3a60738a9a9d362e35a9ab48_OutVector4_1, (_Multiply_a38ba695a2660c8691763f0bd7fe159c_Out_2.xyz), (_UseDynamicCoverTStaticMaskF_20dcbac2f16cf78ebd6fd1debcd7f281_Out_0.xxx), _Lerp_e5620b57c917728fa1416e2ffce9b0db_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_7b9efcab84158389b4a4ea1e24b5601a_Out_0 = _CoverNormalScale;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _NormalStrength_8f42544d1b3ae08092fb1812b8119cfa_Out_2;
            Unity_NormalStrength_float((_PlanarNMn_248bc5b7421d3f828d166902c73ca6c3_XZ_2.xyz), _Property_7b9efcab84158389b4a4ea1e24b5601a_Out_0, _NormalStrength_8f42544d1b3ae08092fb1812b8119cfa_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Lerp_18ca18da5861e688a3fb637172636eda_Out_3;
            Unity_Lerp_float3(_HeightBlend_7c09d97625efce898e21b66cd039be8b_OutVector4_1, _NormalStrength_8f42544d1b3ae08092fb1812b8119cfa_Out_2, (_UseDynamicCoverTStaticMaskF_20dcbac2f16cf78ebd6fd1debcd7f281_Out_0.xxx), _Lerp_18ca18da5861e688a3fb637172636eda_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_afd0f3561038ef8487e614f350d364dd_Out_0 = _BaseMetallic;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_154e0f89b19c8e86926222afb13691e3_Out_2;
            Unity_Multiply_float(_Split_91a015dea8acd38b904ba0935328a5bc_R_1, _Property_afd0f3561038ef8487e614f350d364dd_Out_0, _Multiply_154e0f89b19c8e86926222afb13691e3_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_b82ce26778f44c8fa3510d1a8ed92d0d_Out_0 = _BaseAORemapMin;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_9d07c7a09a85da809f1d4661406e0888_Out_0 = _BaseAORemapMax;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_10162c774de2a7838426399cfe98be82_Out_0 = float2(_Property_b82ce26778f44c8fa3510d1a8ed92d0d_Out_0, _Property_9d07c7a09a85da809f1d4661406e0888_Out_0);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Remap_c45fda31db668c81a9e89e11297ec993_Out_3;
            Unity_Remap_float(_Split_91a015dea8acd38b904ba0935328a5bc_G_2, float2 (0, 1), _Vector2_10162c774de2a7838426399cfe98be82_Out_0, _Remap_c45fda31db668c81a9e89e11297ec993_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_04a7bb2753456b8293b3e46e346b646e_Out_0 = _BaseSmoothnessRemapMin;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_75c8631fc908bb8ba8542d2e70d18cbf_Out_0 = _BaseSmoothnessRemapMax;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_b2e1a3c487cdf88f9b5992b831ba24d6_Out_0 = float2(_Property_04a7bb2753456b8293b3e46e346b646e_Out_0, _Property_75c8631fc908bb8ba8542d2e70d18cbf_Out_0);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Remap_65ca5af95590f88da70777476b6efd40_Out_3;
            Unity_Remap_float(_Split_91a015dea8acd38b904ba0935328a5bc_A_4, float2 (0, 1), _Vector2_b2e1a3c487cdf88f9b5992b831ba24d6_Out_0, _Remap_65ca5af95590f88da70777476b6efd40_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Vector3_28c1e2dadb10138a9799d970043db9b0_Out_0 = float3(_Multiply_154e0f89b19c8e86926222afb13691e3_Out_2, _Remap_c45fda31db668c81a9e89e11297ec993_Out_3, _Remap_65ca5af95590f88da70777476b6efd40_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_4ead43cc6d37b68eb268dd80c3a561e9_Out_0 = _Base2Metallic;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_eef7838a4634498b9cf12d1bee89d853_Out_2;
            Unity_Multiply_float(_Split_83ec66b648ab6c84848b42686c256cd7_R_1, _Property_4ead43cc6d37b68eb268dd80c3a561e9_Out_0, _Multiply_eef7838a4634498b9cf12d1bee89d853_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_e1ed9fe432388887abb17b07dcc5ca6b_Out_0 = _Base2AORemapMin;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_cb0cf7882dcbcf88989a12f73fb7c917_Out_0 = _Base2AORemapMax;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_2d74d82ae79d5681a097c2e3ce20c913_Out_0 = float2(_Property_e1ed9fe432388887abb17b07dcc5ca6b_Out_0, _Property_cb0cf7882dcbcf88989a12f73fb7c917_Out_0);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Remap_dcd2e2871e334281a15cdd1da6103c7f_Out_3;
            Unity_Remap_float(_Split_83ec66b648ab6c84848b42686c256cd7_G_2, float2 (0, 1), _Vector2_2d74d82ae79d5681a097c2e3ce20c913_Out_0, _Remap_dcd2e2871e334281a15cdd1da6103c7f_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_159cd47513de4f85a992da1f43f77c51_Out_0 = _Base2SmoothnessRemapMin;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_b1f3c7061cf84380b1a0ffc2c5f770db_Out_0 = _Base2SmoothnessRemapMax;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_eb0fcc98def54d83abe1cfec60457b78_Out_0 = float2(_Property_159cd47513de4f85a992da1f43f77c51_Out_0, _Property_b1f3c7061cf84380b1a0ffc2c5f770db_Out_0);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Remap_1214803bb0f7c387adc088fb938f7971_Out_3;
            Unity_Remap_float(_Split_83ec66b648ab6c84848b42686c256cd7_A_4, float2 (0, 1), _Vector2_eb0fcc98def54d83abe1cfec60457b78_Out_0, _Remap_1214803bb0f7c387adc088fb938f7971_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Vector3_ddb5452f73a0dc819b57dbe981a5f4e7_Out_0 = float3(_Multiply_eef7838a4634498b9cf12d1bee89d853_Out_2, _Remap_dcd2e2871e334281a15cdd1da6103c7f_Out_3, _Remap_1214803bb0f7c387adc088fb938f7971_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 _HeightBlend_3ef23bc9c463ea8f91d2c1bc27c32dff;
            float3 _HeightBlend_3ef23bc9c463ea8f91d2c1bc27c32dff_OutVector4_1;
            SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135(_Vector3_28c1e2dadb10138a9799d970043db9b0_Out_0, _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3, _Vector3_ddb5452f73a0dc819b57dbe981a5f4e7_Out_0, _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2, _Property_818c8af4b930138e81034c886614171d_Out_0, _HeightBlend_3ef23bc9c463ea8f91d2c1bc27c32dff, _HeightBlend_3ef23bc9c463ea8f91d2c1bc27c32dff_OutVector4_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_6dbb3498614f2088a1315529ed864ea3_Out_0 = _CoverMetallic;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_7a0f3f362f18fd86b9191e28255508f8_Out_2;
            Unity_Multiply_float(_Split_86ec1aefda4f9e8e82b79c6195b397b0_R_1, _Property_6dbb3498614f2088a1315529ed864ea3_Out_0, _Multiply_7a0f3f362f18fd86b9191e28255508f8_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_840e5ecb6a2ddb83abffd7be403ecd68_Out_0 = _CoverAORemapMin;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_92176ee70059d28abbfcad689b580f1a_Out_0 = _CoverAORemapMax;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_2b0ddb771cc86988a6f70ca3c4d0145b_Out_0 = float2(_Property_840e5ecb6a2ddb83abffd7be403ecd68_Out_0, _Property_92176ee70059d28abbfcad689b580f1a_Out_0);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Remap_1091f204ac00858d804a3785be14a17e_Out_3;
            Unity_Remap_float(_Split_86ec1aefda4f9e8e82b79c6195b397b0_G_2, float2 (0, 1), _Vector2_2b0ddb771cc86988a6f70ca3c4d0145b_Out_0, _Remap_1091f204ac00858d804a3785be14a17e_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_4cd4964a0372a3858a89e499b8d810a1_Out_0 = _CoverSmoothnessRemapMin;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_f7e67cf191e5c38388370531311427cf_Out_0 = _CoverSmoothnessRemapMax;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_60ae45a9f680358085440c61ca0118da_Out_0 = float2(_Property_4cd4964a0372a3858a89e499b8d810a1_Out_0, _Property_f7e67cf191e5c38388370531311427cf_Out_0);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Remap_e88a1283399b2187be29c818a3fc3543_Out_3;
            Unity_Remap_float(_Split_86ec1aefda4f9e8e82b79c6195b397b0_A_4, float2 (0, 1), _Vector2_60ae45a9f680358085440c61ca0118da_Out_0, _Remap_e88a1283399b2187be29c818a3fc3543_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Vector3_83d0f92fd33a1d8799fdafb5ae407cb7_Out_0 = float3(_Multiply_7a0f3f362f18fd86b9191e28255508f8_Out_2, _Remap_1091f204ac00858d804a3785be14a17e_Out_3, _Remap_e88a1283399b2187be29c818a3fc3543_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Lerp_afcfe197cbc3818eb5aaaa1cf503c7d4_Out_3;
            Unity_Lerp_float3(_HeightBlend_3ef23bc9c463ea8f91d2c1bc27c32dff_OutVector4_1, _Vector3_83d0f92fd33a1d8799fdafb5ae407cb7_Out_0, (_UseDynamicCoverTStaticMaskF_20dcbac2f16cf78ebd6fd1debcd7f281_Out_0.xxx), _Lerp_afcfe197cbc3818eb5aaaa1cf503c7d4_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_93a6a2f8a95a1b80bea53b3c9628de7b_R_1 = _Lerp_afcfe197cbc3818eb5aaaa1cf503c7d4_Out_3[0];
            float _Split_93a6a2f8a95a1b80bea53b3c9628de7b_G_2 = _Lerp_afcfe197cbc3818eb5aaaa1cf503c7d4_Out_3[1];
            float _Split_93a6a2f8a95a1b80bea53b3c9628de7b_B_3 = _Lerp_afcfe197cbc3818eb5aaaa1cf503c7d4_Out_3[2];
            float _Split_93a6a2f8a95a1b80bea53b3c9628de7b_A_4 = 0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_c7a719bf7da79a8ea38d7311fd844f92_R_1 = _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2[0];
            float _Split_c7a719bf7da79a8ea38d7311fd844f92_G_2 = _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2[1];
            float _Split_c7a719bf7da79a8ea38d7311fd844f92_B_3 = _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2[2];
            float _Split_c7a719bf7da79a8ea38d7311fd844f92_A_4 = _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_7c5dae9b46c9e686b49e58fa996a104a_Out_0 = IgnoreBase2Alpha;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_e9060f5c0433ec889696d3e462f3229b_R_1 = _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2[0];
            float _Split_e9060f5c0433ec889696d3e462f3229b_G_2 = _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2[1];
            float _Split_e9060f5c0433ec889696d3e462f3229b_B_3 = _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2[2];
            float _Split_e9060f5c0433ec889696d3e462f3229b_A_4 = _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Branch_a7d7aece30fd9b8eb456d191fdd37a06_Out_3;
            Unity_Branch_float(_Property_7c5dae9b46c9e686b49e58fa996a104a_Out_0, _Split_c7a719bf7da79a8ea38d7311fd844f92_A_4, _Split_e9060f5c0433ec889696d3e462f3229b_A_4, _Branch_a7d7aece30fd9b8eb456d191fdd37a06_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Lerp_8692ca93f568998fbc97130b6dbc4556_Out_3;
            Unity_Lerp_float(_Split_c7a719bf7da79a8ea38d7311fd844f92_A_4, _Branch_a7d7aece30fd9b8eb456d191fdd37a06_Out_3, _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2, _Lerp_8692ca93f568998fbc97130b6dbc4556_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_0c8b7b55b9f82588ab2dcff09ee7a16d_Out_3;
            Unity_Clamp_float(_Lerp_8692ca93f568998fbc97130b6dbc4556_Out_3, 0, 1, _Clamp_0c8b7b55b9f82588ab2dcff09ee7a16d_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_6333dc4a6348088bb7281602ce6bff5f_Out_2;
            Unity_Multiply_float(_Clamp_0c8b7b55b9f82588ab2dcff09ee7a16d_Out_3, _Split_c34b73d933404283983f9c8bdb5365d3_A_4, _Multiply_6333dc4a6348088bb7281602ce6bff5f_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_9642b8fb7e32b18a91da1888c9bc375b_Out_3;
            Unity_Clamp_float(_Multiply_6333dc4a6348088bb7281602ce6bff5f_Out_2, 0, 1, _Clamp_9642b8fb7e32b18a91da1888c9bc375b_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_8bc98dd454a5508b9864a6ba09772356_Out_0 = _AlphaCutoff;
            #endif
            surface.BaseColor = _Lerp_e5620b57c917728fa1416e2ffce9b0db_Out_3;
            surface.NormalTS = _Lerp_18ca18da5861e688a3fb637172636eda_Out_3;
            surface.Emission = float3(0, 0, 0);
            surface.Metallic = _Split_93a6a2f8a95a1b80bea53b3c9628de7b_R_1;
            surface.Smoothness = _Split_93a6a2f8a95a1b80bea53b3c9628de7b_B_3;
            surface.Occlusion = _Split_93a6a2f8a95a1b80bea53b3c9628de7b_G_2;
            surface.Alpha = _Clamp_9642b8fb7e32b18a91da1888c9bc375b_Out_3;
            surface.AlphaClipThreshold = _Property_8bc98dd454a5508b9864a6ba09772356_Out_0;
            return surface;
        }

            // --------------------------------------------------
            // Build Graph Inputs

            VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceNormal =           input.normalOS;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceTangent =          input.tangentOS.xyz;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpacePosition =         input.positionOS;
        #endif


            return output;
        }
            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 unnormalizedNormalWS = input.normalWS;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        const float renormFactor = 1.0 / length(unnormalizedNormalWS);
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // use bitangent on the fly like in hdrp
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // IMPORTANT! If we ever support Flip on double sided materials ensure bitangent and tangent are NOT flipped.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float crossSign = (input.tangentWS.w > 0.0 ? 1.0 : -1.0) * GetOddNegativeScale();
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 bitang = crossSign * cross(input.normalWS.xyz, input.tangentWS.xyz);
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceNormal =            renormFactor*input.normalWS.xyz;		// we want a unit length Normal Vector node in shader graph
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // to preserve mikktspace compliance we use same scale renormFactor as was used on the normal.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // This is explained in section 2.2 in "surface gradient based bump mapping framework"
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceTangent =           renormFactor*input.tangentWS.xyz;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceBiTangent =         renormFactor*bitang;
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(input.positionWS);
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.uv0 =                         input.texCoord0;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.VertexColor =                 input.color;
        #endif

        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

            return output;
        }

            // --------------------------------------------------
            // Main

            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/PBRForwardPass.hlsl"

            ENDHLSL
        }
        Pass
        {
            Name "ShadowCaster"
            Tags
            {
                "LightMode" = "ShadowCaster"
            }

            // Render State
            Cull Back
        Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
        ZTest LEqual
        ZWrite On
        ColorMask 0

            // Debug
            // <None>

            // --------------------------------------------------
            // Pass

            HLSLPROGRAM

            // Pragmas
            #pragma target 2.0
        #pragma only_renderers gles gles3 glcore d3d11
        #pragma multi_compile_instancing
        #pragma vertex vert
        #pragma fragment frag

            // DotsInstancingOptions: <None>
            // HybridV1InjectedBuiltinProperties: <None>

            // Keywords
            // PassKeywords: <None>
            #pragma shader_feature_local _ _USEDYNAMICCOVERTSTATICMASKF_ON

        #if defined(_USEDYNAMICCOVERTSTATICMASKF_ON)
            #define KEYWORD_PERMUTATION_0
        #else
            #define KEYWORD_PERMUTATION_1
        #endif


            // Defines
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _SURFACE_TYPE_TRANSPARENT 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _AlphaClip 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMALMAP 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMAL_DROPOFF_TS 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_NORMAL
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TANGENT
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TEXCOORD0
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_COLOR
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_POSITION_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TEXCOORD0
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_COLOR
        #endif

            #define FEATURES_GRAPH_VERTEX
            /* WARNING: $splice Could not find named fragment 'PassInstancing' */
            #define SHADERPASS SHADERPASS_SHADOWCASTER
            /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */

            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

            // --------------------------------------------------
            // Structs and Packing

            struct Attributes
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 positionOS : POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 normalOS : NORMAL;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 tangentOS : TANGENT;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 uv0 : TEXCOORD0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 color : COLOR;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : INSTANCEID_SEMANTIC;
            #endif
            #endif
        };
        struct Varyings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 positionWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 texCoord0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 color;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };
        struct SurfaceDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 AbsoluteWorldSpacePosition;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 uv0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 VertexColor;
            #endif
        };
        struct VertexDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpacePosition;
            #endif
        };
        struct PackedVaryings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp0 : TEXCOORD0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 interp1 : TEXCOORD1;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 interp2 : TEXCOORD2;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };

            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            output.positionCS = input.positionCS;
            output.interp0.xyz =  input.positionWS;
            output.interp1.xyzw =  input.texCoord0;
            output.interp2.xyzw =  input.color;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.positionWS = input.interp0.xyz;
            output.texCoord0 = input.interp1.xyzw;
            output.color = input.interp2.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        #endif

            // --------------------------------------------------
            // Graph

            // Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float _AlphaCutoff;
        float4 _BaseColor;
        float4 _BaseColorMap_TexelSize;
        float _BaseUsePlanarUV;
        float4 _BaseTilingOffset;
        float4 _BaseNormalMap_TexelSize;
        float _BaseNormalScale;
        float4 _BaseMaskMap_TexelSize;
        float _BaseMetallic;
        float _BaseAORemapMin;
        float _BaseAORemapMax;
        float _BaseSmoothnessRemapMin;
        float _BaseSmoothnessRemapMax;
        float4 _LayerMask_TexelSize;
        float _Invert_Layer_Mask;
        float _Height_Transition;
        float _HeightMin;
        float _HeightMax;
        float _HeightOffset;
        float _HeightMin2;
        float _HeightMax2;
        float _HeightOffset2;
        float IgnoreBase2Alpha;
        float4 _Base2Color;
        float4 _Base2ColorMap_TexelSize;
        float4 _Base2TilingOffset;
        float _Base2UsePlanarUV;
        float4 _Base2NormalMap_TexelSize;
        float _Base2NormalScale;
        float4 _Base2MaskMap_TexelSize;
        float _Base2Metallic;
        float _Base2SmoothnessRemapMin;
        float _Base2SmoothnessRemapMax;
        float _Base2AORemapMin;
        float _Base2AORemapMax;
        float4 _CoverMaskA_TexelSize;
        float _CoverMaskPower;
        float _Cover_Amount;
        float _Cover_Amount_Grow_Speed;
        float _Cover_Max_Angle;
        float _Cover_Min_Height;
        float _Cover_Min_Height_Blending;
        float4 _CoverBaseColor;
        float4 _CoverBaseColorMap_TexelSize;
        float4 _CoverTilingOffset;
        float _CoverUsePlanarUV;
        float4 _CoverNormalMap_TexelSize;
        float _CoverNormalScale;
        float _CoverNormalBlendHardness;
        float _CoverHardness;
        float _CoverHeightMapMin;
        float _CoverHeightMapMax;
        float _CoverHeightMapOffset;
        float4 _CoverMaskMap_TexelSize;
        float _CoverMetallic;
        float _CoverAORemapMin;
        float _CoverAORemapMax;
        float _CoverSmoothnessRemapMin;
        float _CoverSmoothnessRemapMax;
        CBUFFER_END

        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_BaseColorMap);
        SAMPLER(sampler_BaseColorMap);
        TEXTURE2D(_BaseNormalMap);
        SAMPLER(sampler_BaseNormalMap);
        TEXTURE2D(_BaseMaskMap);
        SAMPLER(sampler_BaseMaskMap);
        TEXTURE2D(_LayerMask);
        SAMPLER(sampler_LayerMask);
        TEXTURE2D(_Base2ColorMap);
        SAMPLER(sampler_Base2ColorMap);
        TEXTURE2D(_Base2NormalMap);
        SAMPLER(sampler_Base2NormalMap);
        TEXTURE2D(_Base2MaskMap);
        SAMPLER(sampler_Base2MaskMap);
        TEXTURE2D(_CoverMaskA);
        SAMPLER(sampler_CoverMaskA);
        TEXTURE2D(_CoverBaseColorMap);
        SAMPLER(sampler_CoverBaseColorMap);
        TEXTURE2D(_CoverNormalMap);
        SAMPLER(sampler_CoverNormalMap);
        TEXTURE2D(_CoverMaskMap);
        SAMPLER(sampler_CoverMaskMap);

            // Graph Functions
            
        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }

        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }

        void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }

        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }

        void Unity_Branch_float2(float Predicate, float2 True, float2 False, out float2 Out)
        {
            Out = Predicate ? True : False;
        }

        struct Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6
        {
            float3 AbsoluteWorldSpacePosition;
            half4 uv0;
        };

        void SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(UnityTexture2D Texture2D_80A3D28F, float4 Vector4_2EBA7A3B, float Boolean_7ABB9909, Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 IN, out float4 XZ_2)
        {
            UnityTexture2D _Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0 = Texture2D_80A3D28F;
            float _Property_30834f691775a0898a45b1c868520436_Out_0 = Boolean_7ABB9909;
            float _Split_89ed63cb625cb3878c183d0b71c03400_R_1 = IN.AbsoluteWorldSpacePosition[0];
            float _Split_89ed63cb625cb3878c183d0b71c03400_G_2 = IN.AbsoluteWorldSpacePosition[1];
            float _Split_89ed63cb625cb3878c183d0b71c03400_B_3 = IN.AbsoluteWorldSpacePosition[2];
            float _Split_89ed63cb625cb3878c183d0b71c03400_A_4 = 0;
            float4 _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4;
            float3 _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5;
            float2 _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6;
            Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_B_3, 0, 0, _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5, _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6);
            float4 _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0 = Vector4_2EBA7A3B;
            float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[0];
            float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_G_2 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[1];
            float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_B_3 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[2];
            float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_A_4 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[3];
            float _Divide_e64179199923c58289b6aa94ea6c9178_Out_2;
            Unity_Divide_float(1, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1, _Divide_e64179199923c58289b6aa94ea6c9178_Out_2);
            float4 _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2;
            Unity_Multiply_float(_Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, (_Divide_e64179199923c58289b6aa94ea6c9178_Out_2.xxxx), _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2);
            float2 _Vector2_16c15d3bbdd14b85bd48e3a6cb318af7_Out_0 = float2(_Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_G_2);
            float2 _Vector2_f8d75f54e7705083bbec539a60185577_Out_0 = float2(_Split_2f0f52f6ef8c0e81af0da6476402bc1f_B_3, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_A_4);
            float2 _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_16c15d3bbdd14b85bd48e3a6cb318af7_Out_0, _Vector2_f8d75f54e7705083bbec539a60185577_Out_0, _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3);
            float2 _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3;
            Unity_Branch_float2(_Property_30834f691775a0898a45b1c868520436_Out_0, (_Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2.xy), _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3, _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3);
            float4 _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0 = SAMPLE_TEXTURE2D(_Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0.tex, _Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0.samplerstate, _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3);
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.r;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.g;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.b;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_A_7 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.a;
            XZ_2 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0;
        }

        void Unity_Branch_float(float Predicate, float True, float False, out float Out)
        {
            Out = Predicate ? True : False;
        }

        void Unity_OneMinus_float(float In, out float Out)
        {
            Out = 1 - In;
        }

        void Unity_Add_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A + B;
        }

        void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
        {
            Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
        }

        void Unity_Multiply_float(float A, float B, out float Out)
        {
            Out = A * B;
        }

        void Unity_Lerp_float(float A, float B, float T, out float Out)
        {
            Out = lerp(A, B, T);
        }

        void Unity_Clamp_float(float In, float Min, float Max, out float Out)
        {
            Out = clamp(In, Min, Max);
        }

            // Graph Vertex
            struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };

        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }

            // Graph Pixel
            struct SurfaceDescription
        {
            float Alpha;
            float AlphaClipThreshold;
        };

        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_07d75b1d2628da808a2efb93a1d6219e_Out_0 = UnityBuildTexture2DStructNoScale(_BaseColorMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0 = _BaseTilingOffset;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_7f998178363b4188ba2f07298ef869c1_Out_0 = _BaseUsePlanarUV;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e;
            _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e.uv0 = IN.uv0;
            float4 _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2;
            SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(_Property_07d75b1d2628da808a2efb93a1d6219e_Out_0, _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0, _Property_7f998178363b4188ba2f07298ef869c1_Out_0, _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e, _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_b83097c58639858680bf43881a95b0af_Out_0 = _BaseColor;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2;
            Unity_Multiply_float(_PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2, _Property_b83097c58639858680bf43881a95b0af_Out_0, _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_c7a719bf7da79a8ea38d7311fd844f92_R_1 = _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2[0];
            float _Split_c7a719bf7da79a8ea38d7311fd844f92_G_2 = _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2[1];
            float _Split_c7a719bf7da79a8ea38d7311fd844f92_B_3 = _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2[2];
            float _Split_c7a719bf7da79a8ea38d7311fd844f92_A_4 = _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_7c5dae9b46c9e686b49e58fa996a104a_Out_0 = IgnoreBase2Alpha;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_ba3a5f4cba7d0a8fa288ffc8267d6c0e_Out_0 = UnityBuildTexture2DStructNoScale(_Base2ColorMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_86a4657df480d48e8d3ad3b036731380_Out_0 = _Base2TilingOffset;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0 = _Base2UsePlanarUV;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4;
            _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4.uv0 = IN.uv0;
            float4 _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4_XZ_2;
            SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(_Property_ba3a5f4cba7d0a8fa288ffc8267d6c0e_Out_0, _Property_86a4657df480d48e8d3ad3b036731380_Out_0, _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0, _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4, _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_3561b11b899bda8e855826445cf628aa_Out_0 = _Base2Color;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2;
            Unity_Multiply_float(_PlanarNM_5aeab444ca6fd78ea56a01215880a5a4_XZ_2, _Property_3561b11b899bda8e855826445cf628aa_Out_0, _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_e9060f5c0433ec889696d3e462f3229b_R_1 = _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2[0];
            float _Split_e9060f5c0433ec889696d3e462f3229b_G_2 = _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2[1];
            float _Split_e9060f5c0433ec889696d3e462f3229b_B_3 = _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2[2];
            float _Split_e9060f5c0433ec889696d3e462f3229b_A_4 = _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Branch_a7d7aece30fd9b8eb456d191fdd37a06_Out_3;
            Unity_Branch_float(_Property_7c5dae9b46c9e686b49e58fa996a104a_Out_0, _Split_c7a719bf7da79a8ea38d7311fd844f92_A_4, _Split_e9060f5c0433ec889696d3e462f3229b_A_4, _Branch_a7d7aece30fd9b8eb456d191fdd37a06_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_c34b73d933404283983f9c8bdb5365d3_R_1 = IN.VertexColor[0];
            float _Split_c34b73d933404283983f9c8bdb5365d3_G_2 = IN.VertexColor[1];
            float _Split_c34b73d933404283983f9c8bdb5365d3_B_3 = IN.VertexColor[2];
            float _Split_c34b73d933404283983f9c8bdb5365d3_A_4 = IN.VertexColor[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_df2df7bb5cfc3381beee7ec454da7542_Out_0 = _Invert_Layer_Mask;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_c7b1e2df9f9b0e8eace9b2274924e69c_Out_0 = UnityBuildTexture2DStructNoScale(_LayerMask);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0 = SAMPLE_TEXTURE2D(_Property_c7b1e2df9f9b0e8eace9b2274924e69c_Out_0.tex, _Property_c7b1e2df9f9b0e8eace9b2274924e69c_Out_0.samplerstate, IN.uv0.xy);
            float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.r;
            float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_G_5 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.g;
            float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_B_6 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.b;
            float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_A_7 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1;
            Unity_OneMinus_float(_SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4, _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Branch_af0c5e511241ce8eae748ae487df50fa_Out_3;
            Unity_Branch_float(_Property_df2df7bb5cfc3381beee7ec454da7542_Out_0, _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1, _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4, _Branch_af0c5e511241ce8eae748ae487df50fa_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_de4f6eb48a629285a664dad7fb06438f_Out_0 = UnityBuildTexture2DStructNoScale(_Base2MaskMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_d5657f470f05ef839e4c257a20ace8cb;
            _PlanarNM_d5657f470f05ef839e4c257a20ace8cb.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNM_d5657f470f05ef839e4c257a20ace8cb.uv0 = IN.uv0;
            float4 _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2;
            SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(_Property_de4f6eb48a629285a664dad7fb06438f_Out_0, _Property_86a4657df480d48e8d3ad3b036731380_Out_0, _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0, _PlanarNM_d5657f470f05ef839e4c257a20ace8cb, _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_83ec66b648ab6c84848b42686c256cd7_R_1 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[0];
            float _Split_83ec66b648ab6c84848b42686c256cd7_G_2 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[1];
            float _Split_83ec66b648ab6c84848b42686c256cd7_B_3 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[2];
            float _Split_83ec66b648ab6c84848b42686c256cd7_A_4 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_ce1750e5c69e97818667b412fc3f9f2c_Out_0 = _HeightMin2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_8e0f2ea54d8ede89bbabdf31a9bafd57_Out_0 = _HeightMax2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_fb6c6dd7e70e768ba686e8e94153bb96_Out_0 = float2(_Property_ce1750e5c69e97818667b412fc3f9f2c_Out_0, _Property_8e0f2ea54d8ede89bbabdf31a9bafd57_Out_0);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_151ae2702b614585af2000f0a812960f_Out_0 = _HeightOffset2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2;
            Unity_Add_float2(_Vector2_fb6c6dd7e70e768ba686e8e94153bb96_Out_0, (_Property_151ae2702b614585af2000f0a812960f_Out_0.xx), _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3;
            Unity_Remap_float(_Split_83ec66b648ab6c84848b42686c256cd7_B_3, float2 (0, 1), _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2, _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2;
            Unity_Multiply_float(_Branch_af0c5e511241ce8eae748ae487df50fa_Out_3, _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3, _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2;
            Unity_Multiply_float(_Split_c34b73d933404283983f9c8bdb5365d3_R_1, _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2, _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Lerp_8692ca93f568998fbc97130b6dbc4556_Out_3;
            Unity_Lerp_float(_Split_c7a719bf7da79a8ea38d7311fd844f92_A_4, _Branch_a7d7aece30fd9b8eb456d191fdd37a06_Out_3, _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2, _Lerp_8692ca93f568998fbc97130b6dbc4556_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_0c8b7b55b9f82588ab2dcff09ee7a16d_Out_3;
            Unity_Clamp_float(_Lerp_8692ca93f568998fbc97130b6dbc4556_Out_3, 0, 1, _Clamp_0c8b7b55b9f82588ab2dcff09ee7a16d_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_6333dc4a6348088bb7281602ce6bff5f_Out_2;
            Unity_Multiply_float(_Clamp_0c8b7b55b9f82588ab2dcff09ee7a16d_Out_3, _Split_c34b73d933404283983f9c8bdb5365d3_A_4, _Multiply_6333dc4a6348088bb7281602ce6bff5f_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_9642b8fb7e32b18a91da1888c9bc375b_Out_3;
            Unity_Clamp_float(_Multiply_6333dc4a6348088bb7281602ce6bff5f_Out_2, 0, 1, _Clamp_9642b8fb7e32b18a91da1888c9bc375b_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_8bc98dd454a5508b9864a6ba09772356_Out_0 = _AlphaCutoff;
            #endif
            surface.Alpha = _Clamp_9642b8fb7e32b18a91da1888c9bc375b_Out_3;
            surface.AlphaClipThreshold = _Property_8bc98dd454a5508b9864a6ba09772356_Out_0;
            return surface;
        }

            // --------------------------------------------------
            // Build Graph Inputs

            VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceNormal =           input.normalOS;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceTangent =          input.tangentOS.xyz;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpacePosition =         input.positionOS;
        #endif


            return output;
        }
            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);





        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(input.positionWS);
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.uv0 =                         input.texCoord0;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.VertexColor =                 input.color;
        #endif

        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

            return output;
        }

            // --------------------------------------------------
            // Main

            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShadowCasterPass.hlsl"

            ENDHLSL
        }
        Pass
        {
            Name "DepthOnly"
            Tags
            {
                "LightMode" = "DepthOnly"
            }

            // Render State
            Cull Back
        Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
        ZTest LEqual
        ZWrite On
        ColorMask 0

            // Debug
            // <None>

            // --------------------------------------------------
            // Pass

            HLSLPROGRAM

            // Pragmas
            #pragma target 2.0
        #pragma only_renderers gles gles3 glcore d3d11
        #pragma multi_compile_instancing
        #pragma vertex vert
        #pragma fragment frag

            // DotsInstancingOptions: <None>
            // HybridV1InjectedBuiltinProperties: <None>

            // Keywords
            // PassKeywords: <None>
            #pragma shader_feature_local _ _USEDYNAMICCOVERTSTATICMASKF_ON

        #if defined(_USEDYNAMICCOVERTSTATICMASKF_ON)
            #define KEYWORD_PERMUTATION_0
        #else
            #define KEYWORD_PERMUTATION_1
        #endif


            // Defines
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _SURFACE_TYPE_TRANSPARENT 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _AlphaClip 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMALMAP 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMAL_DROPOFF_TS 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_NORMAL
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TANGENT
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TEXCOORD0
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_COLOR
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_POSITION_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TEXCOORD0
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_COLOR
        #endif

            #define FEATURES_GRAPH_VERTEX
            /* WARNING: $splice Could not find named fragment 'PassInstancing' */
            #define SHADERPASS SHADERPASS_DEPTHONLY
            /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */

            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

            // --------------------------------------------------
            // Structs and Packing

            struct Attributes
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 positionOS : POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 normalOS : NORMAL;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 tangentOS : TANGENT;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 uv0 : TEXCOORD0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 color : COLOR;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : INSTANCEID_SEMANTIC;
            #endif
            #endif
        };
        struct Varyings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 positionWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 texCoord0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 color;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };
        struct SurfaceDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 AbsoluteWorldSpacePosition;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 uv0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 VertexColor;
            #endif
        };
        struct VertexDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpacePosition;
            #endif
        };
        struct PackedVaryings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp0 : TEXCOORD0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 interp1 : TEXCOORD1;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 interp2 : TEXCOORD2;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };

            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            output.positionCS = input.positionCS;
            output.interp0.xyz =  input.positionWS;
            output.interp1.xyzw =  input.texCoord0;
            output.interp2.xyzw =  input.color;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.positionWS = input.interp0.xyz;
            output.texCoord0 = input.interp1.xyzw;
            output.color = input.interp2.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        #endif

            // --------------------------------------------------
            // Graph

            // Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float _AlphaCutoff;
        float4 _BaseColor;
        float4 _BaseColorMap_TexelSize;
        float _BaseUsePlanarUV;
        float4 _BaseTilingOffset;
        float4 _BaseNormalMap_TexelSize;
        float _BaseNormalScale;
        float4 _BaseMaskMap_TexelSize;
        float _BaseMetallic;
        float _BaseAORemapMin;
        float _BaseAORemapMax;
        float _BaseSmoothnessRemapMin;
        float _BaseSmoothnessRemapMax;
        float4 _LayerMask_TexelSize;
        float _Invert_Layer_Mask;
        float _Height_Transition;
        float _HeightMin;
        float _HeightMax;
        float _HeightOffset;
        float _HeightMin2;
        float _HeightMax2;
        float _HeightOffset2;
        float IgnoreBase2Alpha;
        float4 _Base2Color;
        float4 _Base2ColorMap_TexelSize;
        float4 _Base2TilingOffset;
        float _Base2UsePlanarUV;
        float4 _Base2NormalMap_TexelSize;
        float _Base2NormalScale;
        float4 _Base2MaskMap_TexelSize;
        float _Base2Metallic;
        float _Base2SmoothnessRemapMin;
        float _Base2SmoothnessRemapMax;
        float _Base2AORemapMin;
        float _Base2AORemapMax;
        float4 _CoverMaskA_TexelSize;
        float _CoverMaskPower;
        float _Cover_Amount;
        float _Cover_Amount_Grow_Speed;
        float _Cover_Max_Angle;
        float _Cover_Min_Height;
        float _Cover_Min_Height_Blending;
        float4 _CoverBaseColor;
        float4 _CoverBaseColorMap_TexelSize;
        float4 _CoverTilingOffset;
        float _CoverUsePlanarUV;
        float4 _CoverNormalMap_TexelSize;
        float _CoverNormalScale;
        float _CoverNormalBlendHardness;
        float _CoverHardness;
        float _CoverHeightMapMin;
        float _CoverHeightMapMax;
        float _CoverHeightMapOffset;
        float4 _CoverMaskMap_TexelSize;
        float _CoverMetallic;
        float _CoverAORemapMin;
        float _CoverAORemapMax;
        float _CoverSmoothnessRemapMin;
        float _CoverSmoothnessRemapMax;
        CBUFFER_END

        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_BaseColorMap);
        SAMPLER(sampler_BaseColorMap);
        TEXTURE2D(_BaseNormalMap);
        SAMPLER(sampler_BaseNormalMap);
        TEXTURE2D(_BaseMaskMap);
        SAMPLER(sampler_BaseMaskMap);
        TEXTURE2D(_LayerMask);
        SAMPLER(sampler_LayerMask);
        TEXTURE2D(_Base2ColorMap);
        SAMPLER(sampler_Base2ColorMap);
        TEXTURE2D(_Base2NormalMap);
        SAMPLER(sampler_Base2NormalMap);
        TEXTURE2D(_Base2MaskMap);
        SAMPLER(sampler_Base2MaskMap);
        TEXTURE2D(_CoverMaskA);
        SAMPLER(sampler_CoverMaskA);
        TEXTURE2D(_CoverBaseColorMap);
        SAMPLER(sampler_CoverBaseColorMap);
        TEXTURE2D(_CoverNormalMap);
        SAMPLER(sampler_CoverNormalMap);
        TEXTURE2D(_CoverMaskMap);
        SAMPLER(sampler_CoverMaskMap);

            // Graph Functions
            
        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }

        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }

        void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }

        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }

        void Unity_Branch_float2(float Predicate, float2 True, float2 False, out float2 Out)
        {
            Out = Predicate ? True : False;
        }

        struct Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6
        {
            float3 AbsoluteWorldSpacePosition;
            half4 uv0;
        };

        void SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(UnityTexture2D Texture2D_80A3D28F, float4 Vector4_2EBA7A3B, float Boolean_7ABB9909, Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 IN, out float4 XZ_2)
        {
            UnityTexture2D _Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0 = Texture2D_80A3D28F;
            float _Property_30834f691775a0898a45b1c868520436_Out_0 = Boolean_7ABB9909;
            float _Split_89ed63cb625cb3878c183d0b71c03400_R_1 = IN.AbsoluteWorldSpacePosition[0];
            float _Split_89ed63cb625cb3878c183d0b71c03400_G_2 = IN.AbsoluteWorldSpacePosition[1];
            float _Split_89ed63cb625cb3878c183d0b71c03400_B_3 = IN.AbsoluteWorldSpacePosition[2];
            float _Split_89ed63cb625cb3878c183d0b71c03400_A_4 = 0;
            float4 _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4;
            float3 _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5;
            float2 _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6;
            Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_B_3, 0, 0, _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5, _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6);
            float4 _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0 = Vector4_2EBA7A3B;
            float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[0];
            float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_G_2 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[1];
            float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_B_3 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[2];
            float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_A_4 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[3];
            float _Divide_e64179199923c58289b6aa94ea6c9178_Out_2;
            Unity_Divide_float(1, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1, _Divide_e64179199923c58289b6aa94ea6c9178_Out_2);
            float4 _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2;
            Unity_Multiply_float(_Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, (_Divide_e64179199923c58289b6aa94ea6c9178_Out_2.xxxx), _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2);
            float2 _Vector2_16c15d3bbdd14b85bd48e3a6cb318af7_Out_0 = float2(_Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_G_2);
            float2 _Vector2_f8d75f54e7705083bbec539a60185577_Out_0 = float2(_Split_2f0f52f6ef8c0e81af0da6476402bc1f_B_3, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_A_4);
            float2 _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_16c15d3bbdd14b85bd48e3a6cb318af7_Out_0, _Vector2_f8d75f54e7705083bbec539a60185577_Out_0, _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3);
            float2 _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3;
            Unity_Branch_float2(_Property_30834f691775a0898a45b1c868520436_Out_0, (_Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2.xy), _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3, _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3);
            float4 _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0 = SAMPLE_TEXTURE2D(_Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0.tex, _Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0.samplerstate, _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3);
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.r;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.g;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.b;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_A_7 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.a;
            XZ_2 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0;
        }

        void Unity_Branch_float(float Predicate, float True, float False, out float Out)
        {
            Out = Predicate ? True : False;
        }

        void Unity_OneMinus_float(float In, out float Out)
        {
            Out = 1 - In;
        }

        void Unity_Add_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A + B;
        }

        void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
        {
            Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
        }

        void Unity_Multiply_float(float A, float B, out float Out)
        {
            Out = A * B;
        }

        void Unity_Lerp_float(float A, float B, float T, out float Out)
        {
            Out = lerp(A, B, T);
        }

        void Unity_Clamp_float(float In, float Min, float Max, out float Out)
        {
            Out = clamp(In, Min, Max);
        }

            // Graph Vertex
            struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };

        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }

            // Graph Pixel
            struct SurfaceDescription
        {
            float Alpha;
            float AlphaClipThreshold;
        };

        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_07d75b1d2628da808a2efb93a1d6219e_Out_0 = UnityBuildTexture2DStructNoScale(_BaseColorMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0 = _BaseTilingOffset;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_7f998178363b4188ba2f07298ef869c1_Out_0 = _BaseUsePlanarUV;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e;
            _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e.uv0 = IN.uv0;
            float4 _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2;
            SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(_Property_07d75b1d2628da808a2efb93a1d6219e_Out_0, _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0, _Property_7f998178363b4188ba2f07298ef869c1_Out_0, _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e, _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_b83097c58639858680bf43881a95b0af_Out_0 = _BaseColor;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2;
            Unity_Multiply_float(_PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2, _Property_b83097c58639858680bf43881a95b0af_Out_0, _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_c7a719bf7da79a8ea38d7311fd844f92_R_1 = _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2[0];
            float _Split_c7a719bf7da79a8ea38d7311fd844f92_G_2 = _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2[1];
            float _Split_c7a719bf7da79a8ea38d7311fd844f92_B_3 = _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2[2];
            float _Split_c7a719bf7da79a8ea38d7311fd844f92_A_4 = _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_7c5dae9b46c9e686b49e58fa996a104a_Out_0 = IgnoreBase2Alpha;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_ba3a5f4cba7d0a8fa288ffc8267d6c0e_Out_0 = UnityBuildTexture2DStructNoScale(_Base2ColorMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_86a4657df480d48e8d3ad3b036731380_Out_0 = _Base2TilingOffset;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0 = _Base2UsePlanarUV;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4;
            _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4.uv0 = IN.uv0;
            float4 _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4_XZ_2;
            SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(_Property_ba3a5f4cba7d0a8fa288ffc8267d6c0e_Out_0, _Property_86a4657df480d48e8d3ad3b036731380_Out_0, _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0, _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4, _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_3561b11b899bda8e855826445cf628aa_Out_0 = _Base2Color;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2;
            Unity_Multiply_float(_PlanarNM_5aeab444ca6fd78ea56a01215880a5a4_XZ_2, _Property_3561b11b899bda8e855826445cf628aa_Out_0, _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_e9060f5c0433ec889696d3e462f3229b_R_1 = _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2[0];
            float _Split_e9060f5c0433ec889696d3e462f3229b_G_2 = _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2[1];
            float _Split_e9060f5c0433ec889696d3e462f3229b_B_3 = _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2[2];
            float _Split_e9060f5c0433ec889696d3e462f3229b_A_4 = _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Branch_a7d7aece30fd9b8eb456d191fdd37a06_Out_3;
            Unity_Branch_float(_Property_7c5dae9b46c9e686b49e58fa996a104a_Out_0, _Split_c7a719bf7da79a8ea38d7311fd844f92_A_4, _Split_e9060f5c0433ec889696d3e462f3229b_A_4, _Branch_a7d7aece30fd9b8eb456d191fdd37a06_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_c34b73d933404283983f9c8bdb5365d3_R_1 = IN.VertexColor[0];
            float _Split_c34b73d933404283983f9c8bdb5365d3_G_2 = IN.VertexColor[1];
            float _Split_c34b73d933404283983f9c8bdb5365d3_B_3 = IN.VertexColor[2];
            float _Split_c34b73d933404283983f9c8bdb5365d3_A_4 = IN.VertexColor[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_df2df7bb5cfc3381beee7ec454da7542_Out_0 = _Invert_Layer_Mask;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_c7b1e2df9f9b0e8eace9b2274924e69c_Out_0 = UnityBuildTexture2DStructNoScale(_LayerMask);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0 = SAMPLE_TEXTURE2D(_Property_c7b1e2df9f9b0e8eace9b2274924e69c_Out_0.tex, _Property_c7b1e2df9f9b0e8eace9b2274924e69c_Out_0.samplerstate, IN.uv0.xy);
            float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.r;
            float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_G_5 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.g;
            float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_B_6 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.b;
            float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_A_7 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1;
            Unity_OneMinus_float(_SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4, _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Branch_af0c5e511241ce8eae748ae487df50fa_Out_3;
            Unity_Branch_float(_Property_df2df7bb5cfc3381beee7ec454da7542_Out_0, _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1, _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4, _Branch_af0c5e511241ce8eae748ae487df50fa_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_de4f6eb48a629285a664dad7fb06438f_Out_0 = UnityBuildTexture2DStructNoScale(_Base2MaskMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_d5657f470f05ef839e4c257a20ace8cb;
            _PlanarNM_d5657f470f05ef839e4c257a20ace8cb.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNM_d5657f470f05ef839e4c257a20ace8cb.uv0 = IN.uv0;
            float4 _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2;
            SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(_Property_de4f6eb48a629285a664dad7fb06438f_Out_0, _Property_86a4657df480d48e8d3ad3b036731380_Out_0, _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0, _PlanarNM_d5657f470f05ef839e4c257a20ace8cb, _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_83ec66b648ab6c84848b42686c256cd7_R_1 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[0];
            float _Split_83ec66b648ab6c84848b42686c256cd7_G_2 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[1];
            float _Split_83ec66b648ab6c84848b42686c256cd7_B_3 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[2];
            float _Split_83ec66b648ab6c84848b42686c256cd7_A_4 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_ce1750e5c69e97818667b412fc3f9f2c_Out_0 = _HeightMin2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_8e0f2ea54d8ede89bbabdf31a9bafd57_Out_0 = _HeightMax2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_fb6c6dd7e70e768ba686e8e94153bb96_Out_0 = float2(_Property_ce1750e5c69e97818667b412fc3f9f2c_Out_0, _Property_8e0f2ea54d8ede89bbabdf31a9bafd57_Out_0);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_151ae2702b614585af2000f0a812960f_Out_0 = _HeightOffset2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2;
            Unity_Add_float2(_Vector2_fb6c6dd7e70e768ba686e8e94153bb96_Out_0, (_Property_151ae2702b614585af2000f0a812960f_Out_0.xx), _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3;
            Unity_Remap_float(_Split_83ec66b648ab6c84848b42686c256cd7_B_3, float2 (0, 1), _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2, _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2;
            Unity_Multiply_float(_Branch_af0c5e511241ce8eae748ae487df50fa_Out_3, _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3, _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2;
            Unity_Multiply_float(_Split_c34b73d933404283983f9c8bdb5365d3_R_1, _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2, _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Lerp_8692ca93f568998fbc97130b6dbc4556_Out_3;
            Unity_Lerp_float(_Split_c7a719bf7da79a8ea38d7311fd844f92_A_4, _Branch_a7d7aece30fd9b8eb456d191fdd37a06_Out_3, _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2, _Lerp_8692ca93f568998fbc97130b6dbc4556_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_0c8b7b55b9f82588ab2dcff09ee7a16d_Out_3;
            Unity_Clamp_float(_Lerp_8692ca93f568998fbc97130b6dbc4556_Out_3, 0, 1, _Clamp_0c8b7b55b9f82588ab2dcff09ee7a16d_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_6333dc4a6348088bb7281602ce6bff5f_Out_2;
            Unity_Multiply_float(_Clamp_0c8b7b55b9f82588ab2dcff09ee7a16d_Out_3, _Split_c34b73d933404283983f9c8bdb5365d3_A_4, _Multiply_6333dc4a6348088bb7281602ce6bff5f_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_9642b8fb7e32b18a91da1888c9bc375b_Out_3;
            Unity_Clamp_float(_Multiply_6333dc4a6348088bb7281602ce6bff5f_Out_2, 0, 1, _Clamp_9642b8fb7e32b18a91da1888c9bc375b_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_8bc98dd454a5508b9864a6ba09772356_Out_0 = _AlphaCutoff;
            #endif
            surface.Alpha = _Clamp_9642b8fb7e32b18a91da1888c9bc375b_Out_3;
            surface.AlphaClipThreshold = _Property_8bc98dd454a5508b9864a6ba09772356_Out_0;
            return surface;
        }

            // --------------------------------------------------
            // Build Graph Inputs

            VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceNormal =           input.normalOS;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceTangent =          input.tangentOS.xyz;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpacePosition =         input.positionOS;
        #endif


            return output;
        }
            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);





        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(input.positionWS);
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.uv0 =                         input.texCoord0;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.VertexColor =                 input.color;
        #endif

        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

            return output;
        }

            // --------------------------------------------------
            // Main

            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/DepthOnlyPass.hlsl"

            ENDHLSL
        }
        Pass
        {
            Name "DepthNormals"
            Tags
            {
                "LightMode" = "DepthNormals"
            }

            // Render State
            Cull Back
        Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
        ZTest LEqual
        ZWrite On

            // Debug
            // <None>

            // --------------------------------------------------
            // Pass

            HLSLPROGRAM

            // Pragmas
            #pragma target 2.0
        #pragma only_renderers gles gles3 glcore d3d11
        #pragma multi_compile_instancing
        #pragma vertex vert
        #pragma fragment frag

            // DotsInstancingOptions: <None>
            // HybridV1InjectedBuiltinProperties: <None>

            // Keywords
            // PassKeywords: <None>
            #pragma shader_feature_local _ _USEDYNAMICCOVERTSTATICMASKF_ON

        #if defined(_USEDYNAMICCOVERTSTATICMASKF_ON)
            #define KEYWORD_PERMUTATION_0
        #else
            #define KEYWORD_PERMUTATION_1
        #endif


            // Defines
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _SURFACE_TYPE_TRANSPARENT 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _AlphaClip 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMALMAP 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMAL_DROPOFF_TS 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_NORMAL
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TANGENT
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TEXCOORD0
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TEXCOORD1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_COLOR
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_POSITION_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_NORMAL_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TANGENT_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TEXCOORD0
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_COLOR
        #endif

            #define FEATURES_GRAPH_VERTEX
            /* WARNING: $splice Could not find named fragment 'PassInstancing' */
            #define SHADERPASS SHADERPASS_DEPTHNORMALSONLY
            /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */

            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

            // --------------------------------------------------
            // Structs and Packing

            struct Attributes
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 positionOS : POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 normalOS : NORMAL;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 tangentOS : TANGENT;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 uv0 : TEXCOORD0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 uv1 : TEXCOORD1;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 color : COLOR;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : INSTANCEID_SEMANTIC;
            #endif
            #endif
        };
        struct Varyings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 positionWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 normalWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 tangentWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 texCoord0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 color;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };
        struct SurfaceDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 TangentSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceBiTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 AbsoluteWorldSpacePosition;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 uv0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 VertexColor;
            #endif
        };
        struct VertexDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpacePosition;
            #endif
        };
        struct PackedVaryings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp0 : TEXCOORD0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp1 : TEXCOORD1;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 interp2 : TEXCOORD2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 interp3 : TEXCOORD3;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 interp4 : TEXCOORD4;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };

            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            output.positionCS = input.positionCS;
            output.interp0.xyz =  input.positionWS;
            output.interp1.xyz =  input.normalWS;
            output.interp2.xyzw =  input.tangentWS;
            output.interp3.xyzw =  input.texCoord0;
            output.interp4.xyzw =  input.color;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.positionWS = input.interp0.xyz;
            output.normalWS = input.interp1.xyz;
            output.tangentWS = input.interp2.xyzw;
            output.texCoord0 = input.interp3.xyzw;
            output.color = input.interp4.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        #endif

            // --------------------------------------------------
            // Graph

            // Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float _AlphaCutoff;
        float4 _BaseColor;
        float4 _BaseColorMap_TexelSize;
        float _BaseUsePlanarUV;
        float4 _BaseTilingOffset;
        float4 _BaseNormalMap_TexelSize;
        float _BaseNormalScale;
        float4 _BaseMaskMap_TexelSize;
        float _BaseMetallic;
        float _BaseAORemapMin;
        float _BaseAORemapMax;
        float _BaseSmoothnessRemapMin;
        float _BaseSmoothnessRemapMax;
        float4 _LayerMask_TexelSize;
        float _Invert_Layer_Mask;
        float _Height_Transition;
        float _HeightMin;
        float _HeightMax;
        float _HeightOffset;
        float _HeightMin2;
        float _HeightMax2;
        float _HeightOffset2;
        float IgnoreBase2Alpha;
        float4 _Base2Color;
        float4 _Base2ColorMap_TexelSize;
        float4 _Base2TilingOffset;
        float _Base2UsePlanarUV;
        float4 _Base2NormalMap_TexelSize;
        float _Base2NormalScale;
        float4 _Base2MaskMap_TexelSize;
        float _Base2Metallic;
        float _Base2SmoothnessRemapMin;
        float _Base2SmoothnessRemapMax;
        float _Base2AORemapMin;
        float _Base2AORemapMax;
        float4 _CoverMaskA_TexelSize;
        float _CoverMaskPower;
        float _Cover_Amount;
        float _Cover_Amount_Grow_Speed;
        float _Cover_Max_Angle;
        float _Cover_Min_Height;
        float _Cover_Min_Height_Blending;
        float4 _CoverBaseColor;
        float4 _CoverBaseColorMap_TexelSize;
        float4 _CoverTilingOffset;
        float _CoverUsePlanarUV;
        float4 _CoverNormalMap_TexelSize;
        float _CoverNormalScale;
        float _CoverNormalBlendHardness;
        float _CoverHardness;
        float _CoverHeightMapMin;
        float _CoverHeightMapMax;
        float _CoverHeightMapOffset;
        float4 _CoverMaskMap_TexelSize;
        float _CoverMetallic;
        float _CoverAORemapMin;
        float _CoverAORemapMax;
        float _CoverSmoothnessRemapMin;
        float _CoverSmoothnessRemapMax;
        CBUFFER_END

        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_BaseColorMap);
        SAMPLER(sampler_BaseColorMap);
        TEXTURE2D(_BaseNormalMap);
        SAMPLER(sampler_BaseNormalMap);
        TEXTURE2D(_BaseMaskMap);
        SAMPLER(sampler_BaseMaskMap);
        TEXTURE2D(_LayerMask);
        SAMPLER(sampler_LayerMask);
        TEXTURE2D(_Base2ColorMap);
        SAMPLER(sampler_Base2ColorMap);
        TEXTURE2D(_Base2NormalMap);
        SAMPLER(sampler_Base2NormalMap);
        TEXTURE2D(_Base2MaskMap);
        SAMPLER(sampler_Base2MaskMap);
        TEXTURE2D(_CoverMaskA);
        SAMPLER(sampler_CoverMaskA);
        TEXTURE2D(_CoverBaseColorMap);
        SAMPLER(sampler_CoverBaseColorMap);
        TEXTURE2D(_CoverNormalMap);
        SAMPLER(sampler_CoverNormalMap);
        TEXTURE2D(_CoverMaskMap);
        SAMPLER(sampler_CoverMaskMap);

            // Graph Functions
            
        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }

        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }

        void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }

        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }

        void Unity_Branch_float2(float Predicate, float2 True, float2 False, out float2 Out)
        {
            Out = Predicate ? True : False;
        }

        void Unity_Sign_float3(float3 In, out float3 Out)
        {
            Out = sign(In);
        }

        void Unity_Multiply_float(float2 A, float2 B, out float2 Out)
        {
            Out = A * B;
        }

        void Unity_Add_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A + B;
        }

        void Unity_Multiply_float(float A, float B, out float Out)
        {
            Out = A * B;
        }

        void Unity_Normalize_float3(float3 In, out float3 Out)
        {
            Out = normalize(In);
        }

        void Unity_Branch_float3(float Predicate, float3 True, float3 False, out float3 Out)
        {
            Out = Predicate ? True : False;
        }

        struct Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8
        {
            float3 WorldSpaceNormal;
            float3 WorldSpaceTangent;
            float3 WorldSpaceBiTangent;
            float3 AbsoluteWorldSpacePosition;
            half4 uv0;
        };

        void SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(UnityTexture2D Texture2D_80A3D28F, float4 Vector4_82674548, float Boolean_9FF42DF6, Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 IN, out float4 XZ_2)
        {
            float _Property_1ef12cf3201a938993fe6a7951b0e754_Out_0 = Boolean_9FF42DF6;
            UnityTexture2D _Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0 = Texture2D_80A3D28F;
            float _Split_89ed63cb625cb3878c183d0b71c03400_R_1 = IN.AbsoluteWorldSpacePosition[0];
            float _Split_89ed63cb625cb3878c183d0b71c03400_G_2 = IN.AbsoluteWorldSpacePosition[1];
            float _Split_89ed63cb625cb3878c183d0b71c03400_B_3 = IN.AbsoluteWorldSpacePosition[2];
            float _Split_89ed63cb625cb3878c183d0b71c03400_A_4 = 0;
            float4 _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4;
            float3 _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5;
            float2 _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6;
            Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_B_3, 0, 0, _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5, _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6);
            float4 _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0 = Vector4_82674548;
            float _Split_a2e12fa5931da084b2949343a539dfd8_R_1 = _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0[0];
            float _Split_a2e12fa5931da084b2949343a539dfd8_G_2 = _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0[1];
            float _Split_a2e12fa5931da084b2949343a539dfd8_B_3 = _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0[2];
            float _Split_a2e12fa5931da084b2949343a539dfd8_A_4 = _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0[3];
            float _Divide_c36b770dfaa0bb8f85ab27da5fd794f0_Out_2;
            Unity_Divide_float(1, _Split_a2e12fa5931da084b2949343a539dfd8_R_1, _Divide_c36b770dfaa0bb8f85ab27da5fd794f0_Out_2);
            float4 _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2;
            Unity_Multiply_float(_Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, (_Divide_c36b770dfaa0bb8f85ab27da5fd794f0_Out_2.xxxx), _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2);
            float2 _Vector2_6845d21872714d889783b0cb707df3e9_Out_0 = float2(_Split_a2e12fa5931da084b2949343a539dfd8_R_1, _Split_a2e12fa5931da084b2949343a539dfd8_G_2);
            float2 _Vector2_e2e2263627c6098e96a5b5d29350ad03_Out_0 = float2(_Split_a2e12fa5931da084b2949343a539dfd8_B_3, _Split_a2e12fa5931da084b2949343a539dfd8_A_4);
            float2 _TilingAndOffset_17582d056c0b8a8dab1017d37497fe59_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_6845d21872714d889783b0cb707df3e9_Out_0, _Vector2_e2e2263627c6098e96a5b5d29350ad03_Out_0, _TilingAndOffset_17582d056c0b8a8dab1017d37497fe59_Out_3);
            float2 _Branch_1e152f3aac57448f8518bf2852c000c3_Out_3;
            Unity_Branch_float2(_Property_1ef12cf3201a938993fe6a7951b0e754_Out_0, (_Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2.xy), _TilingAndOffset_17582d056c0b8a8dab1017d37497fe59_Out_3, _Branch_1e152f3aac57448f8518bf2852c000c3_Out_3);
            float4 _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0 = SAMPLE_TEXTURE2D(_Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0.tex, _Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0.samplerstate, _Branch_1e152f3aac57448f8518bf2852c000c3_Out_3);
            _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0);
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.r;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.g;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.b;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_A_7 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.a;
            float2 _Vector2_ad6bd100e273d78fa409a30a77bfa2cc_Out_0 = float2(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4, _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5);
            float3 _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1;
            Unity_Sign_float3(IN.WorldSpaceNormal, _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1);
            float _Split_6299d4ddcc4c74828aea40a46fdb896e_R_1 = _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1[0];
            float _Split_6299d4ddcc4c74828aea40a46fdb896e_G_2 = _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1[1];
            float _Split_6299d4ddcc4c74828aea40a46fdb896e_B_3 = _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1[2];
            float _Split_6299d4ddcc4c74828aea40a46fdb896e_A_4 = 0;
            float2 _Vector2_b76cb1842101e58b9e636d49b075c612_Out_0 = float2(_Split_6299d4ddcc4c74828aea40a46fdb896e_G_2, 1);
            float2 _Multiply_31e8db88ee20c985a9850d1a58f3282b_Out_2;
            Unity_Multiply_float(_Vector2_ad6bd100e273d78fa409a30a77bfa2cc_Out_0, _Vector2_b76cb1842101e58b9e636d49b075c612_Out_0, _Multiply_31e8db88ee20c985a9850d1a58f3282b_Out_2);
            float _Split_5ed44bf2eca0868f81eb18100f49d1fa_R_1 = IN.WorldSpaceNormal[0];
            float _Split_5ed44bf2eca0868f81eb18100f49d1fa_G_2 = IN.WorldSpaceNormal[1];
            float _Split_5ed44bf2eca0868f81eb18100f49d1fa_B_3 = IN.WorldSpaceNormal[2];
            float _Split_5ed44bf2eca0868f81eb18100f49d1fa_A_4 = 0;
            float2 _Vector2_70e5837843f28b8b9d64cada3697bd5a_Out_0 = float2(_Split_5ed44bf2eca0868f81eb18100f49d1fa_R_1, _Split_5ed44bf2eca0868f81eb18100f49d1fa_B_3);
            float2 _Add_1145b2f896593d80aa864a34e6702562_Out_2;
            Unity_Add_float2(_Multiply_31e8db88ee20c985a9850d1a58f3282b_Out_2, _Vector2_70e5837843f28b8b9d64cada3697bd5a_Out_0, _Add_1145b2f896593d80aa864a34e6702562_Out_2);
            float _Split_2bc77ca2d17bd78cb2383770ce50b179_R_1 = _Add_1145b2f896593d80aa864a34e6702562_Out_2[0];
            float _Split_2bc77ca2d17bd78cb2383770ce50b179_G_2 = _Add_1145b2f896593d80aa864a34e6702562_Out_2[1];
            float _Split_2bc77ca2d17bd78cb2383770ce50b179_B_3 = 0;
            float _Split_2bc77ca2d17bd78cb2383770ce50b179_A_4 = 0;
            float _Multiply_ab12aea87465a78eaf7fc66c2598d266_Out_2;
            Unity_Multiply_float(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6, _Split_5ed44bf2eca0868f81eb18100f49d1fa_G_2, _Multiply_ab12aea87465a78eaf7fc66c2598d266_Out_2);
            float3 _Vector3_433840b555db308b97e9b14b6a957195_Out_0 = float3(_Split_2bc77ca2d17bd78cb2383770ce50b179_R_1, _Multiply_ab12aea87465a78eaf7fc66c2598d266_Out_2, _Split_2bc77ca2d17bd78cb2383770ce50b179_G_2);
            float3x3 Transform_c7914cc45a011c89b3f53c55afb51673_tangentTransform_World = float3x3(IN.WorldSpaceTangent, IN.WorldSpaceBiTangent, IN.WorldSpaceNormal);
            float3 _Transform_c7914cc45a011c89b3f53c55afb51673_Out_1 = TransformWorldToTangent(_Vector3_433840b555db308b97e9b14b6a957195_Out_0.xyz, Transform_c7914cc45a011c89b3f53c55afb51673_tangentTransform_World);
            float3 _Normalize_09bf8a2bd0a4d38e8b97d5c674f79b44_Out_1;
            Unity_Normalize_float3(_Transform_c7914cc45a011c89b3f53c55afb51673_Out_1, _Normalize_09bf8a2bd0a4d38e8b97d5c674f79b44_Out_1);
            float3 _Branch_9eadf909a90f2f80880f8c56ecc2a91f_Out_3;
            Unity_Branch_float3(_Property_1ef12cf3201a938993fe6a7951b0e754_Out_0, _Normalize_09bf8a2bd0a4d38e8b97d5c674f79b44_Out_1, (_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.xyz), _Branch_9eadf909a90f2f80880f8c56ecc2a91f_Out_3);
            XZ_2 = (float4(_Branch_9eadf909a90f2f80880f8c56ecc2a91f_Out_3, 1.0));
        }

        void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
        {
            Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
        }

        struct Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6
        {
            float3 AbsoluteWorldSpacePosition;
            half4 uv0;
        };

        void SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(UnityTexture2D Texture2D_80A3D28F, float4 Vector4_2EBA7A3B, float Boolean_7ABB9909, Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 IN, out float4 XZ_2)
        {
            UnityTexture2D _Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0 = Texture2D_80A3D28F;
            float _Property_30834f691775a0898a45b1c868520436_Out_0 = Boolean_7ABB9909;
            float _Split_89ed63cb625cb3878c183d0b71c03400_R_1 = IN.AbsoluteWorldSpacePosition[0];
            float _Split_89ed63cb625cb3878c183d0b71c03400_G_2 = IN.AbsoluteWorldSpacePosition[1];
            float _Split_89ed63cb625cb3878c183d0b71c03400_B_3 = IN.AbsoluteWorldSpacePosition[2];
            float _Split_89ed63cb625cb3878c183d0b71c03400_A_4 = 0;
            float4 _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4;
            float3 _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5;
            float2 _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6;
            Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_B_3, 0, 0, _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5, _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6);
            float4 _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0 = Vector4_2EBA7A3B;
            float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[0];
            float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_G_2 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[1];
            float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_B_3 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[2];
            float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_A_4 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[3];
            float _Divide_e64179199923c58289b6aa94ea6c9178_Out_2;
            Unity_Divide_float(1, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1, _Divide_e64179199923c58289b6aa94ea6c9178_Out_2);
            float4 _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2;
            Unity_Multiply_float(_Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, (_Divide_e64179199923c58289b6aa94ea6c9178_Out_2.xxxx), _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2);
            float2 _Vector2_16c15d3bbdd14b85bd48e3a6cb318af7_Out_0 = float2(_Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_G_2);
            float2 _Vector2_f8d75f54e7705083bbec539a60185577_Out_0 = float2(_Split_2f0f52f6ef8c0e81af0da6476402bc1f_B_3, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_A_4);
            float2 _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_16c15d3bbdd14b85bd48e3a6cb318af7_Out_0, _Vector2_f8d75f54e7705083bbec539a60185577_Out_0, _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3);
            float2 _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3;
            Unity_Branch_float2(_Property_30834f691775a0898a45b1c868520436_Out_0, (_Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2.xy), _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3, _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3);
            float4 _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0 = SAMPLE_TEXTURE2D(_Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0.tex, _Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0.samplerstate, _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3);
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.r;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.g;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.b;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_A_7 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.a;
            XZ_2 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0;
        }

        void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
        {
            Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
        }

        void Unity_OneMinus_float(float In, out float Out)
        {
            Out = 1 - In;
        }

        void Unity_Branch_float(float Predicate, float True, float False, out float Out)
        {
            Out = Predicate ? True : False;
        }

        void Unity_Maximum_float(float A, float B, out float Out)
        {
            Out = max(A, B);
        }

        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }

        void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }

        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }

        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }

        void Unity_Divide_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A / B;
        }

        struct Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135
        {
        };

        void SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135(float3 Vector3_88EEBB5E, float Vector1_DA0A37FA, float3 Vector3_79AA92F, float Vector1_F7E83F1E, float Vector1_1C9222A6, Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 IN, out float3 OutVector4_1)
        {
            float3 _Property_dd1c841a04c03f8c85e7b00eb025ecda_Out_0 = Vector3_88EEBB5E;
            float _Property_14119cc7eaf4128f991283d47cf72d85_Out_0 = Vector1_DA0A37FA;
            float _Property_48af0ad45e3f7f82932b938695d21391_Out_0 = Vector1_DA0A37FA;
            float _Property_8a30b3ca12ff518fa473ccd686c7d503_Out_0 = Vector1_F7E83F1E;
            float _Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2;
            Unity_Maximum_float(_Property_48af0ad45e3f7f82932b938695d21391_Out_0, _Property_8a30b3ca12ff518fa473ccd686c7d503_Out_0, _Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2);
            float _Property_ee8d5fc69475d181be60c57e04ea8708_Out_0 = Vector1_1C9222A6;
            float _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2;
            Unity_Subtract_float(_Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2, _Property_ee8d5fc69475d181be60c57e04ea8708_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2);
            float _Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2;
            Unity_Subtract_float(_Property_14119cc7eaf4128f991283d47cf72d85_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2, _Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2);
            float _Maximum_d02e48d92038448cb0345e5cf3779071_Out_2;
            Unity_Maximum_float(_Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2, 0, _Maximum_d02e48d92038448cb0345e5cf3779071_Out_2);
            float3 _Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2;
            Unity_Multiply_float(_Property_dd1c841a04c03f8c85e7b00eb025ecda_Out_0, (_Maximum_d02e48d92038448cb0345e5cf3779071_Out_2.xxx), _Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2);
            float3 _Property_c7292b3b08585f8c8670172b9a220bf0_Out_0 = Vector3_79AA92F;
            float _Property_5e920479576fad83ba1947728dcceab4_Out_0 = Vector1_F7E83F1E;
            float _Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2;
            Unity_Subtract_float(_Property_5e920479576fad83ba1947728dcceab4_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2, _Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2);
            float _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2;
            Unity_Maximum_float(_Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2, 0, _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2);
            float3 _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2;
            Unity_Multiply_float(_Property_c7292b3b08585f8c8670172b9a220bf0_Out_0, (_Maximum_216777d30802328eab607c8fe68ba3a1_Out_2.xxx), _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2);
            float3 _Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2;
            Unity_Add_float3(_Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2, _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2, _Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2);
            float _Add_356384b52728f583bd6e694bc1fc3738_Out_2;
            Unity_Add_float(_Maximum_d02e48d92038448cb0345e5cf3779071_Out_2, _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2, _Add_356384b52728f583bd6e694bc1fc3738_Out_2);
            float _Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2;
            Unity_Maximum_float(_Add_356384b52728f583bd6e694bc1fc3738_Out_2, 1E-05, _Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2);
            float3 _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2;
            Unity_Divide_float3(_Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2, (_Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2.xxx), _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2);
            OutVector4_1 = _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2;
        }

        void Unity_Clamp_float(float In, float Min, float Max, out float Out)
        {
            Out = clamp(In, Min, Max);
        }

        void Unity_Absolute_float(float In, out float Out)
        {
            Out = abs(In);
        }

        void Unity_Power_float(float A, float B, out float Out)
        {
            Out = pow(A, B);
        }

        void Unity_Saturate_float(float In, out float Out)
        {
            Out = saturate(In);
        }

        void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
        {
            Out = lerp(A, B, T);
        }

        void Unity_Lerp_float(float A, float B, float T, out float Out)
        {
            Out = lerp(A, B, T);
        }

            // Graph Vertex
            struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };

        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }

            // Graph Pixel
            struct SurfaceDescription
        {
            float3 NormalTS;
            float Alpha;
            float AlphaClipThreshold;
        };

        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_7c7049e15fdff386b535790d8666f609_Out_0 = UnityBuildTexture2DStructNoScale(_BaseNormalMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0 = _BaseTilingOffset;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_7f998178363b4188ba2f07298ef869c1_Out_0 = _BaseUsePlanarUV;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8;
            _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.WorldSpaceNormal = IN.WorldSpaceNormal;
            _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.WorldSpaceTangent = IN.WorldSpaceTangent;
            _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
            _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.uv0 = IN.uv0;
            float4 _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8_XZ_2;
            SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(_Property_7c7049e15fdff386b535790d8666f609_Out_0, _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0, _Property_7f998178363b4188ba2f07298ef869c1_Out_0, _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8, _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_d4b0759cf4647e81be065ec1465ce2b4_Out_0 = _BaseNormalScale;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _NormalStrength_f66a9108ea294886acc61513b41cc5e4_Out_2;
            Unity_NormalStrength_float((_PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8_XZ_2.xyz), _Property_d4b0759cf4647e81be065ec1465ce2b4_Out_0, _NormalStrength_f66a9108ea294886acc61513b41cc5e4_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_1e449ff9f8e8ec828507233e8240eb11_Out_0 = UnityBuildTexture2DStructNoScale(_BaseMaskMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_4245c3b264047180b5c90a697d6cb278;
            _PlanarNM_4245c3b264047180b5c90a697d6cb278.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNM_4245c3b264047180b5c90a697d6cb278.uv0 = IN.uv0;
            float4 _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2;
            SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(_Property_1e449ff9f8e8ec828507233e8240eb11_Out_0, _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0, _Property_7f998178363b4188ba2f07298ef869c1_Out_0, _PlanarNM_4245c3b264047180b5c90a697d6cb278, _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_91a015dea8acd38b904ba0935328a5bc_R_1 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[0];
            float _Split_91a015dea8acd38b904ba0935328a5bc_G_2 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[1];
            float _Split_91a015dea8acd38b904ba0935328a5bc_B_3 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[2];
            float _Split_91a015dea8acd38b904ba0935328a5bc_A_4 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_fbcff1469ebf488394a8a89ddaf0eb2a_Out_0 = _HeightMin;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_9df7a44c8225168683743ac60c0c3c34_Out_0 = _HeightMax;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_9b1e95888c28bc8893f28c02b87fa448_Out_0 = float2(_Property_fbcff1469ebf488394a8a89ddaf0eb2a_Out_0, _Property_9df7a44c8225168683743ac60c0c3c34_Out_0);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_29ca14fd0b712983a38d63d2dd326e96_Out_0 = _HeightOffset;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Add_cb503f8a09720d84bb03cbd89e37b80c_Out_2;
            Unity_Add_float2(_Vector2_9b1e95888c28bc8893f28c02b87fa448_Out_0, (_Property_29ca14fd0b712983a38d63d2dd326e96_Out_0.xx), _Add_cb503f8a09720d84bb03cbd89e37b80c_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3;
            Unity_Remap_float(_Split_91a015dea8acd38b904ba0935328a5bc_B_3, float2 (0, 1), _Add_cb503f8a09720d84bb03cbd89e37b80c_Out_2, _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_fa9f7890b20ad481a92543c04b237bde_Out_0 = UnityBuildTexture2DStructNoScale(_Base2NormalMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_86a4657df480d48e8d3ad3b036731380_Out_0 = _Base2TilingOffset;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0 = _Base2UsePlanarUV;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf;
            _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.WorldSpaceNormal = IN.WorldSpaceNormal;
            _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.WorldSpaceTangent = IN.WorldSpaceTangent;
            _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
            _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.uv0 = IN.uv0;
            float4 _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf_XZ_2;
            SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(_Property_fa9f7890b20ad481a92543c04b237bde_Out_0, _Property_86a4657df480d48e8d3ad3b036731380_Out_0, _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0, _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf, _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_8c31443b776727819a663c7ddce79064_Out_0 = _Base2NormalScale;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _NormalStrength_0fb86880ab8e368dac6d01b830e20ed8_Out_2;
            Unity_NormalStrength_float((_PlanarNMn_d7b3ec528088a085a5102e025a1b45cf_XZ_2.xyz), _Property_8c31443b776727819a663c7ddce79064_Out_0, _NormalStrength_0fb86880ab8e368dac6d01b830e20ed8_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_c34b73d933404283983f9c8bdb5365d3_R_1 = IN.VertexColor[0];
            float _Split_c34b73d933404283983f9c8bdb5365d3_G_2 = IN.VertexColor[1];
            float _Split_c34b73d933404283983f9c8bdb5365d3_B_3 = IN.VertexColor[2];
            float _Split_c34b73d933404283983f9c8bdb5365d3_A_4 = IN.VertexColor[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_df2df7bb5cfc3381beee7ec454da7542_Out_0 = _Invert_Layer_Mask;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_c7b1e2df9f9b0e8eace9b2274924e69c_Out_0 = UnityBuildTexture2DStructNoScale(_LayerMask);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0 = SAMPLE_TEXTURE2D(_Property_c7b1e2df9f9b0e8eace9b2274924e69c_Out_0.tex, _Property_c7b1e2df9f9b0e8eace9b2274924e69c_Out_0.samplerstate, IN.uv0.xy);
            float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.r;
            float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_G_5 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.g;
            float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_B_6 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.b;
            float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_A_7 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1;
            Unity_OneMinus_float(_SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4, _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Branch_af0c5e511241ce8eae748ae487df50fa_Out_3;
            Unity_Branch_float(_Property_df2df7bb5cfc3381beee7ec454da7542_Out_0, _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1, _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4, _Branch_af0c5e511241ce8eae748ae487df50fa_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_de4f6eb48a629285a664dad7fb06438f_Out_0 = UnityBuildTexture2DStructNoScale(_Base2MaskMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_d5657f470f05ef839e4c257a20ace8cb;
            _PlanarNM_d5657f470f05ef839e4c257a20ace8cb.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNM_d5657f470f05ef839e4c257a20ace8cb.uv0 = IN.uv0;
            float4 _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2;
            SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(_Property_de4f6eb48a629285a664dad7fb06438f_Out_0, _Property_86a4657df480d48e8d3ad3b036731380_Out_0, _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0, _PlanarNM_d5657f470f05ef839e4c257a20ace8cb, _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_83ec66b648ab6c84848b42686c256cd7_R_1 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[0];
            float _Split_83ec66b648ab6c84848b42686c256cd7_G_2 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[1];
            float _Split_83ec66b648ab6c84848b42686c256cd7_B_3 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[2];
            float _Split_83ec66b648ab6c84848b42686c256cd7_A_4 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_ce1750e5c69e97818667b412fc3f9f2c_Out_0 = _HeightMin2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_8e0f2ea54d8ede89bbabdf31a9bafd57_Out_0 = _HeightMax2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_fb6c6dd7e70e768ba686e8e94153bb96_Out_0 = float2(_Property_ce1750e5c69e97818667b412fc3f9f2c_Out_0, _Property_8e0f2ea54d8ede89bbabdf31a9bafd57_Out_0);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_151ae2702b614585af2000f0a812960f_Out_0 = _HeightOffset2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2;
            Unity_Add_float2(_Vector2_fb6c6dd7e70e768ba686e8e94153bb96_Out_0, (_Property_151ae2702b614585af2000f0a812960f_Out_0.xx), _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3;
            Unity_Remap_float(_Split_83ec66b648ab6c84848b42686c256cd7_B_3, float2 (0, 1), _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2, _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2;
            Unity_Multiply_float(_Branch_af0c5e511241ce8eae748ae487df50fa_Out_3, _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3, _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2;
            Unity_Multiply_float(_Split_c34b73d933404283983f9c8bdb5365d3_R_1, _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2, _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_818c8af4b930138e81034c886614171d_Out_0 = _Height_Transition;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 _HeightBlend_7c09d97625efce898e21b66cd039be8b;
            float3 _HeightBlend_7c09d97625efce898e21b66cd039be8b_OutVector4_1;
            SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135(_NormalStrength_f66a9108ea294886acc61513b41cc5e4_Out_2, _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3, _NormalStrength_0fb86880ab8e368dac6d01b830e20ed8_Out_2, _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2, _Property_818c8af4b930138e81034c886614171d_Out_0, _HeightBlend_7c09d97625efce898e21b66cd039be8b, _HeightBlend_7c09d97625efce898e21b66cd039be8b_OutVector4_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_65f7dd6fe6c29b83913af586c597a1ef_Out_0 = UnityBuildTexture2DStructNoScale(_CoverNormalMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_822489d2e6d3e08590c64f085ffd9b2e_Out_0 = _CoverTilingOffset;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_2ae4a163bd21d98789af282d6e469175_Out_0 = _CoverUsePlanarUV;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3;
            _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3.WorldSpaceNormal = IN.WorldSpaceNormal;
            _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3.WorldSpaceTangent = IN.WorldSpaceTangent;
            _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
            _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3.uv0 = IN.uv0;
            float4 _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3_XZ_2;
            SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(_Property_65f7dd6fe6c29b83913af586c597a1ef_Out_0, _Property_822489d2e6d3e08590c64f085ffd9b2e_Out_0, _Property_2ae4a163bd21d98789af282d6e469175_Out_0, _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3, _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_7b9efcab84158389b4a4ea1e24b5601a_Out_0 = _CoverNormalScale;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _NormalStrength_8f42544d1b3ae08092fb1812b8119cfa_Out_2;
            Unity_NormalStrength_float((_PlanarNMn_248bc5b7421d3f828d166902c73ca6c3_XZ_2.xyz), _Property_7b9efcab84158389b4a4ea1e24b5601a_Out_0, _NormalStrength_8f42544d1b3ae08092fb1812b8119cfa_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_c0d223db25424a8ab0cee2de2bbf58ce_Out_0 = UnityBuildTexture2DStructNoScale(_CoverMaskA);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _UV_5352c8dd0add178ba83a5421c2c0b3f0_Out_0 = IN.uv0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _SampleTexture2D_024ba490c015248988a12a9d670014ea_RGBA_0 = SAMPLE_TEXTURE2D(_Property_c0d223db25424a8ab0cee2de2bbf58ce_Out_0.tex, _Property_c0d223db25424a8ab0cee2de2bbf58ce_Out_0.samplerstate, (_UV_5352c8dd0add178ba83a5421c2c0b3f0_Out_0.xy));
            float _SampleTexture2D_024ba490c015248988a12a9d670014ea_R_4 = _SampleTexture2D_024ba490c015248988a12a9d670014ea_RGBA_0.r;
            float _SampleTexture2D_024ba490c015248988a12a9d670014ea_G_5 = _SampleTexture2D_024ba490c015248988a12a9d670014ea_RGBA_0.g;
            float _SampleTexture2D_024ba490c015248988a12a9d670014ea_B_6 = _SampleTexture2D_024ba490c015248988a12a9d670014ea_RGBA_0.b;
            float _SampleTexture2D_024ba490c015248988a12a9d670014ea_A_7 = _SampleTexture2D_024ba490c015248988a12a9d670014ea_RGBA_0.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_b80e7b96604b7c82bbf9bff4981fad76_Out_0 = _CoverMaskPower;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_abe410d256783480b1b58468bf78a882_Out_2;
            Unity_Multiply_float(_SampleTexture2D_024ba490c015248988a12a9d670014ea_A_7, _Property_b80e7b96604b7c82bbf9bff4981fad76_Out_0, _Multiply_abe410d256783480b1b58468bf78a882_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_a78f6f28770afd869adb9d12cd47370b_Out_3;
            Unity_Clamp_float(_Multiply_abe410d256783480b1b58468bf78a882_Out_2, 0, 1, _Clamp_a78f6f28770afd869adb9d12cd47370b_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_19f92cae42737480a95820c51d4ba124_Out_0 = _CoverNormalBlendHardness;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _NormalStrength_2c3488591b8345869feb25a3dee06c3f_Out_2;
            Unity_NormalStrength_float((_PlanarNMn_248bc5b7421d3f828d166902c73ca6c3_XZ_2.xyz), _Property_19f92cae42737480a95820c51d4ba124_Out_0, _NormalStrength_2c3488591b8345869feb25a3dee06c3f_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_96bfe9cb80ad308385c191d094b3d071_R_1 = IN.WorldSpaceNormal[0];
            float _Split_96bfe9cb80ad308385c191d094b3d071_G_2 = IN.WorldSpaceNormal[1];
            float _Split_96bfe9cb80ad308385c191d094b3d071_B_3 = IN.WorldSpaceNormal[2];
            float _Split_96bfe9cb80ad308385c191d094b3d071_A_4 = 0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_0dd796aae8cd9f878bef13ceac4fe3ec_Out_0 = _Cover_Amount;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_67285cdc688aa38d83f62d5bb095d597_Out_0 = _Cover_Amount_Grow_Speed;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Subtract_fcefec675e7536888eccf5574d921972_Out_2;
            Unity_Subtract_float(4, _Property_67285cdc688aa38d83f62d5bb095d597_Out_0, _Subtract_fcefec675e7536888eccf5574d921972_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Divide_1e25465528e612839a4ce1faedd89e7d_Out_2;
            Unity_Divide_float(_Property_0dd796aae8cd9f878bef13ceac4fe3ec_Out_0, _Subtract_fcefec675e7536888eccf5574d921972_Out_2, _Divide_1e25465528e612839a4ce1faedd89e7d_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Absolute_d20b810ffdec828ab74dd6692d82f01b_Out_1;
            Unity_Absolute_float(_Divide_1e25465528e612839a4ce1faedd89e7d_Out_2, _Absolute_d20b810ffdec828ab74dd6692d82f01b_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Power_181fbf47cfdb258da1fe0b72a450986f_Out_2;
            Unity_Power_float(_Absolute_d20b810ffdec828ab74dd6692d82f01b_Out_1, _Subtract_fcefec675e7536888eccf5574d921972_Out_2, _Power_181fbf47cfdb258da1fe0b72a450986f_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_11f62dba01f1a38c9e0a9972ccd19246_Out_3;
            Unity_Clamp_float(_Power_181fbf47cfdb258da1fe0b72a450986f_Out_2, 0, 2, _Clamp_11f62dba01f1a38c9e0a9972ccd19246_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_9810f6d76275cd8fbe5e3a02360b98a7_Out_2;
            Unity_Multiply_float(_Split_96bfe9cb80ad308385c191d094b3d071_G_2, _Clamp_11f62dba01f1a38c9e0a9972ccd19246_Out_3, _Multiply_9810f6d76275cd8fbe5e3a02360b98a7_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Saturate_a007c5f214685c87bf6ca3e64c06b488_Out_1;
            Unity_Saturate_float(_Multiply_9810f6d76275cd8fbe5e3a02360b98a7_Out_2, _Saturate_a007c5f214685c87bf6ca3e64c06b488_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_1b2b25b617fc508b9835f0309136fd00_Out_3;
            Unity_Clamp_float(_Split_96bfe9cb80ad308385c191d094b3d071_G_2, 0, 0.9999, _Clamp_1b2b25b617fc508b9835f0309136fd00_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_7b12276ea7a4538db6804507b30a830c_Out_0 = _Cover_Max_Angle;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Divide_54c523ff4b7acb858e9e368fd1e4d34a_Out_2;
            Unity_Divide_float(_Property_7b12276ea7a4538db6804507b30a830c_Out_0, 45, _Divide_54c523ff4b7acb858e9e368fd1e4d34a_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _OneMinus_6cf431985b651e8e9546ae6cb2d4d668_Out_1;
            Unity_OneMinus_float(_Divide_54c523ff4b7acb858e9e368fd1e4d34a_Out_2, _OneMinus_6cf431985b651e8e9546ae6cb2d4d668_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Subtract_4ef7b60aeab8d589bf2d2423737642bc_Out_2;
            Unity_Subtract_float(_Clamp_1b2b25b617fc508b9835f0309136fd00_Out_3, _OneMinus_6cf431985b651e8e9546ae6cb2d4d668_Out_1, _Subtract_4ef7b60aeab8d589bf2d2423737642bc_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_a4b51894ea17818c9a27bb533a2ebe74_Out_3;
            Unity_Clamp_float(_Subtract_4ef7b60aeab8d589bf2d2423737642bc_Out_2, 0, 2, _Clamp_a4b51894ea17818c9a27bb533a2ebe74_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Divide_c4196d4f02190b89ba827ccd4ae8a74d_Out_2;
            Unity_Divide_float(1, _Divide_54c523ff4b7acb858e9e368fd1e4d34a_Out_2, _Divide_c4196d4f02190b89ba827ccd4ae8a74d_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_ffc22433163d1184846ede424b44bcb2_Out_2;
            Unity_Multiply_float(_Clamp_a4b51894ea17818c9a27bb533a2ebe74_Out_3, _Divide_c4196d4f02190b89ba827ccd4ae8a74d_Out_2, _Multiply_ffc22433163d1184846ede424b44bcb2_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Absolute_c2e5757082de5d878d4c023806fb2108_Out_1;
            Unity_Absolute_float(_Multiply_ffc22433163d1184846ede424b44bcb2_Out_2, _Absolute_c2e5757082de5d878d4c023806fb2108_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_849d9f217c95f38c9d49ab251578d8d5_Out_0 = _CoverHardness;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Power_578546d66d69a5829b745ebba1279adf_Out_2;
            Unity_Power_float(_Absolute_c2e5757082de5d878d4c023806fb2108_Out_1, _Property_849d9f217c95f38c9d49ab251578d8d5_Out_0, _Power_578546d66d69a5829b745ebba1279adf_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_34d2d3aff4814e8e83d2894b3512c6c8_Out_0 = _Cover_Min_Height;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _OneMinus_474df64227f004849b34c68fe8df93f2_Out_1;
            Unity_OneMinus_float(_Property_34d2d3aff4814e8e83d2894b3512c6c8_Out_0, _OneMinus_474df64227f004849b34c68fe8df93f2_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_ee4d9dc934b3508397d5a3dece110ab0_R_1 = IN.AbsoluteWorldSpacePosition[0];
            float _Split_ee4d9dc934b3508397d5a3dece110ab0_G_2 = IN.AbsoluteWorldSpacePosition[1];
            float _Split_ee4d9dc934b3508397d5a3dece110ab0_B_3 = IN.AbsoluteWorldSpacePosition[2];
            float _Split_ee4d9dc934b3508397d5a3dece110ab0_A_4 = 0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Add_d6bc513aa82d918ea24e279f4353d971_Out_2;
            Unity_Add_float(_OneMinus_474df64227f004849b34c68fe8df93f2_Out_1, _Split_ee4d9dc934b3508397d5a3dece110ab0_G_2, _Add_d6bc513aa82d918ea24e279f4353d971_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Add_a6a61cb12180108c9e1364b90d2673e2_Out_2;
            Unity_Add_float(_Add_d6bc513aa82d918ea24e279f4353d971_Out_2, 1, _Add_a6a61cb12180108c9e1364b90d2673e2_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_1874fdd00cb9aa839d93ab8536e2414d_Out_3;
            Unity_Clamp_float(_Add_a6a61cb12180108c9e1364b90d2673e2_Out_2, 0, 1, _Clamp_1874fdd00cb9aa839d93ab8536e2414d_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_7b91fd6e21b46c85816c7b681307cbe4_Out_0 = _Cover_Min_Height_Blending;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Add_6dca9453f6a35e8185c4b8e9782db0a9_Out_2;
            Unity_Add_float(_Add_d6bc513aa82d918ea24e279f4353d971_Out_2, _Property_7b91fd6e21b46c85816c7b681307cbe4_Out_0, _Add_6dca9453f6a35e8185c4b8e9782db0a9_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Divide_83415a319ecfba83af914cbc5487b546_Out_2;
            Unity_Divide_float(_Add_6dca9453f6a35e8185c4b8e9782db0a9_Out_2, _Add_d6bc513aa82d918ea24e279f4353d971_Out_2, _Divide_83415a319ecfba83af914cbc5487b546_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _OneMinus_bf150b22fcad5a87b7c825c9c6cf1687_Out_1;
            Unity_OneMinus_float(_Divide_83415a319ecfba83af914cbc5487b546_Out_2, _OneMinus_bf150b22fcad5a87b7c825c9c6cf1687_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Add_86ff9fa850efbe8c80705d8266609dab_Out_2;
            Unity_Add_float(_OneMinus_bf150b22fcad5a87b7c825c9c6cf1687_Out_1, -0.5, _Add_86ff9fa850efbe8c80705d8266609dab_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_906e140f01222d8ba61252ec6ec9d6a4_Out_3;
            Unity_Clamp_float(_Add_86ff9fa850efbe8c80705d8266609dab_Out_2, 0, 1, _Clamp_906e140f01222d8ba61252ec6ec9d6a4_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Add_c1ec5849bf72f585a30b3e11a91ada52_Out_2;
            Unity_Add_float(_Clamp_1874fdd00cb9aa839d93ab8536e2414d_Out_3, _Clamp_906e140f01222d8ba61252ec6ec9d6a4_Out_3, _Add_c1ec5849bf72f585a30b3e11a91ada52_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_17a8a0cf209a038b9e9c7f5681cdd1fb_Out_3;
            Unity_Clamp_float(_Add_c1ec5849bf72f585a30b3e11a91ada52_Out_2, 0, 1, _Clamp_17a8a0cf209a038b9e9c7f5681cdd1fb_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_8c2759ac24a9b289b1e9610cfd161bb0_Out_2;
            Unity_Multiply_float(_Power_578546d66d69a5829b745ebba1279adf_Out_2, _Clamp_17a8a0cf209a038b9e9c7f5681cdd1fb_Out_3, _Multiply_8c2759ac24a9b289b1e9610cfd161bb0_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_1a723f136ec7fa8c957b5d29e03d3051_Out_2;
            Unity_Multiply_float(_Saturate_a007c5f214685c87bf6ca3e64c06b488_Out_1, _Multiply_8c2759ac24a9b289b1e9610cfd161bb0_Out_2, _Multiply_1a723f136ec7fa8c957b5d29e03d3051_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Lerp_d1c72e47b283948584479177786ae8d5_Out_3;
            Unity_Lerp_float3(_HeightBlend_7c09d97625efce898e21b66cd039be8b_OutVector4_1, _NormalStrength_2c3488591b8345869feb25a3dee06c3f_Out_2, (_Multiply_1a723f136ec7fa8c957b5d29e03d3051_Out_2.xxx), _Lerp_d1c72e47b283948584479177786ae8d5_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3x3 Transform_180fb403b53f318db002e8eba7616644_transposeTangent = transpose(float3x3(IN.WorldSpaceTangent, IN.WorldSpaceBiTangent, IN.WorldSpaceNormal));
            float3 _Transform_180fb403b53f318db002e8eba7616644_Out_1 = normalize(mul(Transform_180fb403b53f318db002e8eba7616644_transposeTangent, _Lerp_d1c72e47b283948584479177786ae8d5_Out_3.xyz).xyz);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_c9a2b4fb4f688b8ebfc1436535cd5ba4_R_1 = _Transform_180fb403b53f318db002e8eba7616644_Out_1[0];
            float _Split_c9a2b4fb4f688b8ebfc1436535cd5ba4_G_2 = _Transform_180fb403b53f318db002e8eba7616644_Out_1[1];
            float _Split_c9a2b4fb4f688b8ebfc1436535cd5ba4_B_3 = _Transform_180fb403b53f318db002e8eba7616644_Out_1[2];
            float _Split_c9a2b4fb4f688b8ebfc1436535cd5ba4_A_4 = 0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_4c7631d0688102819e6d388d624855a1_Out_2;
            Unity_Multiply_float(_Split_c9a2b4fb4f688b8ebfc1436535cd5ba4_G_2, _Clamp_11f62dba01f1a38c9e0a9972ccd19246_Out_3, _Multiply_4c7631d0688102819e6d388d624855a1_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_f2887eb409f6bb81ae4caad2b01b17f1_Out_2;
            Unity_Multiply_float(_Clamp_11f62dba01f1a38c9e0a9972ccd19246_Out_3, _Property_849d9f217c95f38c9d49ab251578d8d5_Out_0, _Multiply_f2887eb409f6bb81ae4caad2b01b17f1_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_2e348ed31331e78791b2b3130a009f30_Out_2;
            Unity_Multiply_float(_Multiply_f2887eb409f6bb81ae4caad2b01b17f1_Out_2, _Multiply_8c2759ac24a9b289b1e9610cfd161bb0_Out_2, _Multiply_2e348ed31331e78791b2b3130a009f30_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_622e54e9a77b08839c0954ce5715ad1c_Out_2;
            Unity_Multiply_float(_Multiply_4c7631d0688102819e6d388d624855a1_Out_2, _Multiply_2e348ed31331e78791b2b3130a009f30_Out_2, _Multiply_622e54e9a77b08839c0954ce5715ad1c_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_608db04fab7d768d9a8b5fb9cf0768e1_Out_0 = UnityBuildTexture2DStructNoScale(_CoverMaskMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e;
            _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e.uv0 = IN.uv0;
            float4 _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e_XZ_2;
            SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(_Property_608db04fab7d768d9a8b5fb9cf0768e1_Out_0, _Property_822489d2e6d3e08590c64f085ffd9b2e_Out_0, _Property_2ae4a163bd21d98789af282d6e469175_Out_0, _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e, _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_86ec1aefda4f9e8e82b79c6195b397b0_R_1 = _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e_XZ_2[0];
            float _Split_86ec1aefda4f9e8e82b79c6195b397b0_G_2 = _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e_XZ_2[1];
            float _Split_86ec1aefda4f9e8e82b79c6195b397b0_B_3 = _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e_XZ_2[2];
            float _Split_86ec1aefda4f9e8e82b79c6195b397b0_A_4 = _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e_XZ_2[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_c9c6897e00458b8f8aa07df49fa519bc_Out_0 = _CoverHeightMapMin;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_ab94650b8edd82828661fe99e3c0e849_Out_0 = _CoverHeightMapMax;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_fe489f7321f6568686816b9eecbc16d1_Out_0 = float2(_Property_c9c6897e00458b8f8aa07df49fa519bc_Out_0, _Property_ab94650b8edd82828661fe99e3c0e849_Out_0);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_c1ab40024cb83b87960e4327efbd997f_Out_0 = _CoverHeightMapOffset;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Add_4a359522fc231c83b55ef23f341b6fb3_Out_2;
            Unity_Add_float2(_Vector2_fe489f7321f6568686816b9eecbc16d1_Out_0, (_Property_c1ab40024cb83b87960e4327efbd997f_Out_0.xx), _Add_4a359522fc231c83b55ef23f341b6fb3_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Remap_5aee5b64d41562858dc7c42d8b748894_Out_3;
            Unity_Remap_float(_Split_86ec1aefda4f9e8e82b79c6195b397b0_B_3, float2 (0, 1), _Add_4a359522fc231c83b55ef23f341b6fb3_Out_2, _Remap_5aee5b64d41562858dc7c42d8b748894_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_f0228e1cfd9c858dbb36367f551733c4_Out_2;
            Unity_Multiply_float(_Multiply_622e54e9a77b08839c0954ce5715ad1c_Out_2, _Remap_5aee5b64d41562858dc7c42d8b748894_Out_3, _Multiply_f0228e1cfd9c858dbb36367f551733c4_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_bb4d60728db93b8a9af9635fa1d69891_Out_2;
            Unity_Multiply_float(_Split_c34b73d933404283983f9c8bdb5365d3_G_2, _Multiply_f0228e1cfd9c858dbb36367f551733c4_Out_2, _Multiply_bb4d60728db93b8a9af9635fa1d69891_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Saturate_9b052a9bb99eff89bb11bdc387a0c2fd_Out_1;
            Unity_Saturate_float(_Multiply_bb4d60728db93b8a9af9635fa1d69891_Out_2, _Saturate_9b052a9bb99eff89bb11bdc387a0c2fd_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_22fb8c1cfd28b687a991e101aa13ff5b_Out_2;
            Unity_Multiply_float(_Clamp_a78f6f28770afd869adb9d12cd47370b_Out_3, _Saturate_9b052a9bb99eff89bb11bdc387a0c2fd_Out_1, _Multiply_22fb8c1cfd28b687a991e101aa13ff5b_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #if defined(_USEDYNAMICCOVERTSTATICMASKF_ON)
            float _UseDynamicCoverTStaticMaskF_20dcbac2f16cf78ebd6fd1debcd7f281_Out_0 = _Multiply_22fb8c1cfd28b687a991e101aa13ff5b_Out_2;
            #else
            float _UseDynamicCoverTStaticMaskF_20dcbac2f16cf78ebd6fd1debcd7f281_Out_0 = _Clamp_a78f6f28770afd869adb9d12cd47370b_Out_3;
            #endif
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Lerp_18ca18da5861e688a3fb637172636eda_Out_3;
            Unity_Lerp_float3(_HeightBlend_7c09d97625efce898e21b66cd039be8b_OutVector4_1, _NormalStrength_8f42544d1b3ae08092fb1812b8119cfa_Out_2, (_UseDynamicCoverTStaticMaskF_20dcbac2f16cf78ebd6fd1debcd7f281_Out_0.xxx), _Lerp_18ca18da5861e688a3fb637172636eda_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_07d75b1d2628da808a2efb93a1d6219e_Out_0 = UnityBuildTexture2DStructNoScale(_BaseColorMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e;
            _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e.uv0 = IN.uv0;
            float4 _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2;
            SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(_Property_07d75b1d2628da808a2efb93a1d6219e_Out_0, _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0, _Property_7f998178363b4188ba2f07298ef869c1_Out_0, _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e, _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_b83097c58639858680bf43881a95b0af_Out_0 = _BaseColor;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2;
            Unity_Multiply_float(_PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2, _Property_b83097c58639858680bf43881a95b0af_Out_0, _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_c7a719bf7da79a8ea38d7311fd844f92_R_1 = _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2[0];
            float _Split_c7a719bf7da79a8ea38d7311fd844f92_G_2 = _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2[1];
            float _Split_c7a719bf7da79a8ea38d7311fd844f92_B_3 = _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2[2];
            float _Split_c7a719bf7da79a8ea38d7311fd844f92_A_4 = _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_7c5dae9b46c9e686b49e58fa996a104a_Out_0 = IgnoreBase2Alpha;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_ba3a5f4cba7d0a8fa288ffc8267d6c0e_Out_0 = UnityBuildTexture2DStructNoScale(_Base2ColorMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4;
            _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4.uv0 = IN.uv0;
            float4 _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4_XZ_2;
            SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(_Property_ba3a5f4cba7d0a8fa288ffc8267d6c0e_Out_0, _Property_86a4657df480d48e8d3ad3b036731380_Out_0, _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0, _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4, _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_3561b11b899bda8e855826445cf628aa_Out_0 = _Base2Color;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2;
            Unity_Multiply_float(_PlanarNM_5aeab444ca6fd78ea56a01215880a5a4_XZ_2, _Property_3561b11b899bda8e855826445cf628aa_Out_0, _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_e9060f5c0433ec889696d3e462f3229b_R_1 = _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2[0];
            float _Split_e9060f5c0433ec889696d3e462f3229b_G_2 = _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2[1];
            float _Split_e9060f5c0433ec889696d3e462f3229b_B_3 = _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2[2];
            float _Split_e9060f5c0433ec889696d3e462f3229b_A_4 = _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Branch_a7d7aece30fd9b8eb456d191fdd37a06_Out_3;
            Unity_Branch_float(_Property_7c5dae9b46c9e686b49e58fa996a104a_Out_0, _Split_c7a719bf7da79a8ea38d7311fd844f92_A_4, _Split_e9060f5c0433ec889696d3e462f3229b_A_4, _Branch_a7d7aece30fd9b8eb456d191fdd37a06_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Lerp_8692ca93f568998fbc97130b6dbc4556_Out_3;
            Unity_Lerp_float(_Split_c7a719bf7da79a8ea38d7311fd844f92_A_4, _Branch_a7d7aece30fd9b8eb456d191fdd37a06_Out_3, _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2, _Lerp_8692ca93f568998fbc97130b6dbc4556_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_0c8b7b55b9f82588ab2dcff09ee7a16d_Out_3;
            Unity_Clamp_float(_Lerp_8692ca93f568998fbc97130b6dbc4556_Out_3, 0, 1, _Clamp_0c8b7b55b9f82588ab2dcff09ee7a16d_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_6333dc4a6348088bb7281602ce6bff5f_Out_2;
            Unity_Multiply_float(_Clamp_0c8b7b55b9f82588ab2dcff09ee7a16d_Out_3, _Split_c34b73d933404283983f9c8bdb5365d3_A_4, _Multiply_6333dc4a6348088bb7281602ce6bff5f_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_9642b8fb7e32b18a91da1888c9bc375b_Out_3;
            Unity_Clamp_float(_Multiply_6333dc4a6348088bb7281602ce6bff5f_Out_2, 0, 1, _Clamp_9642b8fb7e32b18a91da1888c9bc375b_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_8bc98dd454a5508b9864a6ba09772356_Out_0 = _AlphaCutoff;
            #endif
            surface.NormalTS = _Lerp_18ca18da5861e688a3fb637172636eda_Out_3;
            surface.Alpha = _Clamp_9642b8fb7e32b18a91da1888c9bc375b_Out_3;
            surface.AlphaClipThreshold = _Property_8bc98dd454a5508b9864a6ba09772356_Out_0;
            return surface;
        }

            // --------------------------------------------------
            // Build Graph Inputs

            VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceNormal =           input.normalOS;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceTangent =          input.tangentOS.xyz;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpacePosition =         input.positionOS;
        #endif


            return output;
        }
            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 unnormalizedNormalWS = input.normalWS;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        const float renormFactor = 1.0 / length(unnormalizedNormalWS);
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // use bitangent on the fly like in hdrp
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // IMPORTANT! If we ever support Flip on double sided materials ensure bitangent and tangent are NOT flipped.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float crossSign = (input.tangentWS.w > 0.0 ? 1.0 : -1.0) * GetOddNegativeScale();
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 bitang = crossSign * cross(input.normalWS.xyz, input.tangentWS.xyz);
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceNormal =            renormFactor*input.normalWS.xyz;		// we want a unit length Normal Vector node in shader graph
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // to preserve mikktspace compliance we use same scale renormFactor as was used on the normal.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // This is explained in section 2.2 in "surface gradient based bump mapping framework"
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceTangent =           renormFactor*input.tangentWS.xyz;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceBiTangent =         renormFactor*bitang;
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(input.positionWS);
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.uv0 =                         input.texCoord0;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.VertexColor =                 input.color;
        #endif

        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

            return output;
        }

            // --------------------------------------------------
            // Main

            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/DepthNormalsOnlyPass.hlsl"

            ENDHLSL
        }
        Pass
        {
            Name "Meta"
            Tags
            {
                "LightMode" = "Meta"
            }

            // Render State
            Cull Off

            // Debug
            // <None>

            // --------------------------------------------------
            // Pass

            HLSLPROGRAM

            // Pragmas
            #pragma target 2.0
        #pragma only_renderers gles gles3 glcore d3d11
        #pragma vertex vert
        #pragma fragment frag

            // DotsInstancingOptions: <None>
            // HybridV1InjectedBuiltinProperties: <None>

            // Keywords
            #pragma shader_feature _ _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A
            #pragma shader_feature_local _ _USEDYNAMICCOVERTSTATICMASKF_ON

        #if defined(_USEDYNAMICCOVERTSTATICMASKF_ON)
            #define KEYWORD_PERMUTATION_0
        #else
            #define KEYWORD_PERMUTATION_1
        #endif


            // Defines
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _SURFACE_TYPE_TRANSPARENT 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _AlphaClip 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMALMAP 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMAL_DROPOFF_TS 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_NORMAL
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TANGENT
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TEXCOORD0
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TEXCOORD1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TEXCOORD2
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_COLOR
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_POSITION_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_NORMAL_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TANGENT_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TEXCOORD0
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_COLOR
        #endif

            #define FEATURES_GRAPH_VERTEX
            /* WARNING: $splice Could not find named fragment 'PassInstancing' */
            #define SHADERPASS SHADERPASS_META
            /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */

            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/MetaInput.hlsl"

            // --------------------------------------------------
            // Structs and Packing

            struct Attributes
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 positionOS : POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 normalOS : NORMAL;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 tangentOS : TANGENT;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 uv0 : TEXCOORD0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 uv1 : TEXCOORD1;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 uv2 : TEXCOORD2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 color : COLOR;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : INSTANCEID_SEMANTIC;
            #endif
            #endif
        };
        struct Varyings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 positionWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 normalWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 tangentWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 texCoord0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 color;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };
        struct SurfaceDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceBiTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 AbsoluteWorldSpacePosition;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 uv0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 VertexColor;
            #endif
        };
        struct VertexDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpacePosition;
            #endif
        };
        struct PackedVaryings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp0 : TEXCOORD0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp1 : TEXCOORD1;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 interp2 : TEXCOORD2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 interp3 : TEXCOORD3;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 interp4 : TEXCOORD4;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };

            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            output.positionCS = input.positionCS;
            output.interp0.xyz =  input.positionWS;
            output.interp1.xyz =  input.normalWS;
            output.interp2.xyzw =  input.tangentWS;
            output.interp3.xyzw =  input.texCoord0;
            output.interp4.xyzw =  input.color;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.positionWS = input.interp0.xyz;
            output.normalWS = input.interp1.xyz;
            output.tangentWS = input.interp2.xyzw;
            output.texCoord0 = input.interp3.xyzw;
            output.color = input.interp4.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        #endif

            // --------------------------------------------------
            // Graph

            // Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float _AlphaCutoff;
        float4 _BaseColor;
        float4 _BaseColorMap_TexelSize;
        float _BaseUsePlanarUV;
        float4 _BaseTilingOffset;
        float4 _BaseNormalMap_TexelSize;
        float _BaseNormalScale;
        float4 _BaseMaskMap_TexelSize;
        float _BaseMetallic;
        float _BaseAORemapMin;
        float _BaseAORemapMax;
        float _BaseSmoothnessRemapMin;
        float _BaseSmoothnessRemapMax;
        float4 _LayerMask_TexelSize;
        float _Invert_Layer_Mask;
        float _Height_Transition;
        float _HeightMin;
        float _HeightMax;
        float _HeightOffset;
        float _HeightMin2;
        float _HeightMax2;
        float _HeightOffset2;
        float IgnoreBase2Alpha;
        float4 _Base2Color;
        float4 _Base2ColorMap_TexelSize;
        float4 _Base2TilingOffset;
        float _Base2UsePlanarUV;
        float4 _Base2NormalMap_TexelSize;
        float _Base2NormalScale;
        float4 _Base2MaskMap_TexelSize;
        float _Base2Metallic;
        float _Base2SmoothnessRemapMin;
        float _Base2SmoothnessRemapMax;
        float _Base2AORemapMin;
        float _Base2AORemapMax;
        float4 _CoverMaskA_TexelSize;
        float _CoverMaskPower;
        float _Cover_Amount;
        float _Cover_Amount_Grow_Speed;
        float _Cover_Max_Angle;
        float _Cover_Min_Height;
        float _Cover_Min_Height_Blending;
        float4 _CoverBaseColor;
        float4 _CoverBaseColorMap_TexelSize;
        float4 _CoverTilingOffset;
        float _CoverUsePlanarUV;
        float4 _CoverNormalMap_TexelSize;
        float _CoverNormalScale;
        float _CoverNormalBlendHardness;
        float _CoverHardness;
        float _CoverHeightMapMin;
        float _CoverHeightMapMax;
        float _CoverHeightMapOffset;
        float4 _CoverMaskMap_TexelSize;
        float _CoverMetallic;
        float _CoverAORemapMin;
        float _CoverAORemapMax;
        float _CoverSmoothnessRemapMin;
        float _CoverSmoothnessRemapMax;
        CBUFFER_END

        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_BaseColorMap);
        SAMPLER(sampler_BaseColorMap);
        TEXTURE2D(_BaseNormalMap);
        SAMPLER(sampler_BaseNormalMap);
        TEXTURE2D(_BaseMaskMap);
        SAMPLER(sampler_BaseMaskMap);
        TEXTURE2D(_LayerMask);
        SAMPLER(sampler_LayerMask);
        TEXTURE2D(_Base2ColorMap);
        SAMPLER(sampler_Base2ColorMap);
        TEXTURE2D(_Base2NormalMap);
        SAMPLER(sampler_Base2NormalMap);
        TEXTURE2D(_Base2MaskMap);
        SAMPLER(sampler_Base2MaskMap);
        TEXTURE2D(_CoverMaskA);
        SAMPLER(sampler_CoverMaskA);
        TEXTURE2D(_CoverBaseColorMap);
        SAMPLER(sampler_CoverBaseColorMap);
        TEXTURE2D(_CoverNormalMap);
        SAMPLER(sampler_CoverNormalMap);
        TEXTURE2D(_CoverMaskMap);
        SAMPLER(sampler_CoverMaskMap);

            // Graph Functions
            
        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }

        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }

        void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }

        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }

        void Unity_Branch_float2(float Predicate, float2 True, float2 False, out float2 Out)
        {
            Out = Predicate ? True : False;
        }

        struct Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6
        {
            float3 AbsoluteWorldSpacePosition;
            half4 uv0;
        };

        void SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(UnityTexture2D Texture2D_80A3D28F, float4 Vector4_2EBA7A3B, float Boolean_7ABB9909, Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 IN, out float4 XZ_2)
        {
            UnityTexture2D _Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0 = Texture2D_80A3D28F;
            float _Property_30834f691775a0898a45b1c868520436_Out_0 = Boolean_7ABB9909;
            float _Split_89ed63cb625cb3878c183d0b71c03400_R_1 = IN.AbsoluteWorldSpacePosition[0];
            float _Split_89ed63cb625cb3878c183d0b71c03400_G_2 = IN.AbsoluteWorldSpacePosition[1];
            float _Split_89ed63cb625cb3878c183d0b71c03400_B_3 = IN.AbsoluteWorldSpacePosition[2];
            float _Split_89ed63cb625cb3878c183d0b71c03400_A_4 = 0;
            float4 _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4;
            float3 _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5;
            float2 _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6;
            Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_B_3, 0, 0, _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5, _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6);
            float4 _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0 = Vector4_2EBA7A3B;
            float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[0];
            float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_G_2 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[1];
            float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_B_3 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[2];
            float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_A_4 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[3];
            float _Divide_e64179199923c58289b6aa94ea6c9178_Out_2;
            Unity_Divide_float(1, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1, _Divide_e64179199923c58289b6aa94ea6c9178_Out_2);
            float4 _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2;
            Unity_Multiply_float(_Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, (_Divide_e64179199923c58289b6aa94ea6c9178_Out_2.xxxx), _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2);
            float2 _Vector2_16c15d3bbdd14b85bd48e3a6cb318af7_Out_0 = float2(_Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_G_2);
            float2 _Vector2_f8d75f54e7705083bbec539a60185577_Out_0 = float2(_Split_2f0f52f6ef8c0e81af0da6476402bc1f_B_3, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_A_4);
            float2 _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_16c15d3bbdd14b85bd48e3a6cb318af7_Out_0, _Vector2_f8d75f54e7705083bbec539a60185577_Out_0, _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3);
            float2 _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3;
            Unity_Branch_float2(_Property_30834f691775a0898a45b1c868520436_Out_0, (_Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2.xy), _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3, _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3);
            float4 _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0 = SAMPLE_TEXTURE2D(_Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0.tex, _Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0.samplerstate, _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3);
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.r;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.g;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.b;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_A_7 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.a;
            XZ_2 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0;
        }

        void Unity_Add_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A + B;
        }

        void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
        {
            Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
        }

        void Unity_OneMinus_float(float In, out float Out)
        {
            Out = 1 - In;
        }

        void Unity_Branch_float(float Predicate, float True, float False, out float Out)
        {
            Out = Predicate ? True : False;
        }

        void Unity_Multiply_float(float A, float B, out float Out)
        {
            Out = A * B;
        }

        void Unity_Maximum_float(float A, float B, out float Out)
        {
            Out = max(A, B);
        }

        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }

        void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }

        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }

        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }

        void Unity_Divide_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A / B;
        }

        struct Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135
        {
        };

        void SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135(float3 Vector3_88EEBB5E, float Vector1_DA0A37FA, float3 Vector3_79AA92F, float Vector1_F7E83F1E, float Vector1_1C9222A6, Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 IN, out float3 OutVector4_1)
        {
            float3 _Property_dd1c841a04c03f8c85e7b00eb025ecda_Out_0 = Vector3_88EEBB5E;
            float _Property_14119cc7eaf4128f991283d47cf72d85_Out_0 = Vector1_DA0A37FA;
            float _Property_48af0ad45e3f7f82932b938695d21391_Out_0 = Vector1_DA0A37FA;
            float _Property_8a30b3ca12ff518fa473ccd686c7d503_Out_0 = Vector1_F7E83F1E;
            float _Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2;
            Unity_Maximum_float(_Property_48af0ad45e3f7f82932b938695d21391_Out_0, _Property_8a30b3ca12ff518fa473ccd686c7d503_Out_0, _Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2);
            float _Property_ee8d5fc69475d181be60c57e04ea8708_Out_0 = Vector1_1C9222A6;
            float _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2;
            Unity_Subtract_float(_Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2, _Property_ee8d5fc69475d181be60c57e04ea8708_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2);
            float _Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2;
            Unity_Subtract_float(_Property_14119cc7eaf4128f991283d47cf72d85_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2, _Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2);
            float _Maximum_d02e48d92038448cb0345e5cf3779071_Out_2;
            Unity_Maximum_float(_Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2, 0, _Maximum_d02e48d92038448cb0345e5cf3779071_Out_2);
            float3 _Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2;
            Unity_Multiply_float(_Property_dd1c841a04c03f8c85e7b00eb025ecda_Out_0, (_Maximum_d02e48d92038448cb0345e5cf3779071_Out_2.xxx), _Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2);
            float3 _Property_c7292b3b08585f8c8670172b9a220bf0_Out_0 = Vector3_79AA92F;
            float _Property_5e920479576fad83ba1947728dcceab4_Out_0 = Vector1_F7E83F1E;
            float _Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2;
            Unity_Subtract_float(_Property_5e920479576fad83ba1947728dcceab4_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2, _Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2);
            float _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2;
            Unity_Maximum_float(_Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2, 0, _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2);
            float3 _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2;
            Unity_Multiply_float(_Property_c7292b3b08585f8c8670172b9a220bf0_Out_0, (_Maximum_216777d30802328eab607c8fe68ba3a1_Out_2.xxx), _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2);
            float3 _Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2;
            Unity_Add_float3(_Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2, _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2, _Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2);
            float _Add_356384b52728f583bd6e694bc1fc3738_Out_2;
            Unity_Add_float(_Maximum_d02e48d92038448cb0345e5cf3779071_Out_2, _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2, _Add_356384b52728f583bd6e694bc1fc3738_Out_2);
            float _Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2;
            Unity_Maximum_float(_Add_356384b52728f583bd6e694bc1fc3738_Out_2, 1E-05, _Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2);
            float3 _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2;
            Unity_Divide_float3(_Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2, (_Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2.xxx), _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2);
            OutVector4_1 = _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2;
        }

        void Unity_Clamp_float(float In, float Min, float Max, out float Out)
        {
            Out = clamp(In, Min, Max);
        }

        void Unity_Sign_float3(float3 In, out float3 Out)
        {
            Out = sign(In);
        }

        void Unity_Multiply_float(float2 A, float2 B, out float2 Out)
        {
            Out = A * B;
        }

        void Unity_Normalize_float3(float3 In, out float3 Out)
        {
            Out = normalize(In);
        }

        void Unity_Branch_float3(float Predicate, float3 True, float3 False, out float3 Out)
        {
            Out = Predicate ? True : False;
        }

        struct Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8
        {
            float3 WorldSpaceNormal;
            float3 WorldSpaceTangent;
            float3 WorldSpaceBiTangent;
            float3 AbsoluteWorldSpacePosition;
            half4 uv0;
        };

        void SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(UnityTexture2D Texture2D_80A3D28F, float4 Vector4_82674548, float Boolean_9FF42DF6, Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 IN, out float4 XZ_2)
        {
            float _Property_1ef12cf3201a938993fe6a7951b0e754_Out_0 = Boolean_9FF42DF6;
            UnityTexture2D _Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0 = Texture2D_80A3D28F;
            float _Split_89ed63cb625cb3878c183d0b71c03400_R_1 = IN.AbsoluteWorldSpacePosition[0];
            float _Split_89ed63cb625cb3878c183d0b71c03400_G_2 = IN.AbsoluteWorldSpacePosition[1];
            float _Split_89ed63cb625cb3878c183d0b71c03400_B_3 = IN.AbsoluteWorldSpacePosition[2];
            float _Split_89ed63cb625cb3878c183d0b71c03400_A_4 = 0;
            float4 _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4;
            float3 _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5;
            float2 _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6;
            Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_B_3, 0, 0, _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5, _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6);
            float4 _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0 = Vector4_82674548;
            float _Split_a2e12fa5931da084b2949343a539dfd8_R_1 = _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0[0];
            float _Split_a2e12fa5931da084b2949343a539dfd8_G_2 = _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0[1];
            float _Split_a2e12fa5931da084b2949343a539dfd8_B_3 = _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0[2];
            float _Split_a2e12fa5931da084b2949343a539dfd8_A_4 = _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0[3];
            float _Divide_c36b770dfaa0bb8f85ab27da5fd794f0_Out_2;
            Unity_Divide_float(1, _Split_a2e12fa5931da084b2949343a539dfd8_R_1, _Divide_c36b770dfaa0bb8f85ab27da5fd794f0_Out_2);
            float4 _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2;
            Unity_Multiply_float(_Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, (_Divide_c36b770dfaa0bb8f85ab27da5fd794f0_Out_2.xxxx), _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2);
            float2 _Vector2_6845d21872714d889783b0cb707df3e9_Out_0 = float2(_Split_a2e12fa5931da084b2949343a539dfd8_R_1, _Split_a2e12fa5931da084b2949343a539dfd8_G_2);
            float2 _Vector2_e2e2263627c6098e96a5b5d29350ad03_Out_0 = float2(_Split_a2e12fa5931da084b2949343a539dfd8_B_3, _Split_a2e12fa5931da084b2949343a539dfd8_A_4);
            float2 _TilingAndOffset_17582d056c0b8a8dab1017d37497fe59_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_6845d21872714d889783b0cb707df3e9_Out_0, _Vector2_e2e2263627c6098e96a5b5d29350ad03_Out_0, _TilingAndOffset_17582d056c0b8a8dab1017d37497fe59_Out_3);
            float2 _Branch_1e152f3aac57448f8518bf2852c000c3_Out_3;
            Unity_Branch_float2(_Property_1ef12cf3201a938993fe6a7951b0e754_Out_0, (_Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2.xy), _TilingAndOffset_17582d056c0b8a8dab1017d37497fe59_Out_3, _Branch_1e152f3aac57448f8518bf2852c000c3_Out_3);
            float4 _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0 = SAMPLE_TEXTURE2D(_Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0.tex, _Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0.samplerstate, _Branch_1e152f3aac57448f8518bf2852c000c3_Out_3);
            _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0);
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.r;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.g;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.b;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_A_7 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.a;
            float2 _Vector2_ad6bd100e273d78fa409a30a77bfa2cc_Out_0 = float2(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4, _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5);
            float3 _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1;
            Unity_Sign_float3(IN.WorldSpaceNormal, _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1);
            float _Split_6299d4ddcc4c74828aea40a46fdb896e_R_1 = _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1[0];
            float _Split_6299d4ddcc4c74828aea40a46fdb896e_G_2 = _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1[1];
            float _Split_6299d4ddcc4c74828aea40a46fdb896e_B_3 = _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1[2];
            float _Split_6299d4ddcc4c74828aea40a46fdb896e_A_4 = 0;
            float2 _Vector2_b76cb1842101e58b9e636d49b075c612_Out_0 = float2(_Split_6299d4ddcc4c74828aea40a46fdb896e_G_2, 1);
            float2 _Multiply_31e8db88ee20c985a9850d1a58f3282b_Out_2;
            Unity_Multiply_float(_Vector2_ad6bd100e273d78fa409a30a77bfa2cc_Out_0, _Vector2_b76cb1842101e58b9e636d49b075c612_Out_0, _Multiply_31e8db88ee20c985a9850d1a58f3282b_Out_2);
            float _Split_5ed44bf2eca0868f81eb18100f49d1fa_R_1 = IN.WorldSpaceNormal[0];
            float _Split_5ed44bf2eca0868f81eb18100f49d1fa_G_2 = IN.WorldSpaceNormal[1];
            float _Split_5ed44bf2eca0868f81eb18100f49d1fa_B_3 = IN.WorldSpaceNormal[2];
            float _Split_5ed44bf2eca0868f81eb18100f49d1fa_A_4 = 0;
            float2 _Vector2_70e5837843f28b8b9d64cada3697bd5a_Out_0 = float2(_Split_5ed44bf2eca0868f81eb18100f49d1fa_R_1, _Split_5ed44bf2eca0868f81eb18100f49d1fa_B_3);
            float2 _Add_1145b2f896593d80aa864a34e6702562_Out_2;
            Unity_Add_float2(_Multiply_31e8db88ee20c985a9850d1a58f3282b_Out_2, _Vector2_70e5837843f28b8b9d64cada3697bd5a_Out_0, _Add_1145b2f896593d80aa864a34e6702562_Out_2);
            float _Split_2bc77ca2d17bd78cb2383770ce50b179_R_1 = _Add_1145b2f896593d80aa864a34e6702562_Out_2[0];
            float _Split_2bc77ca2d17bd78cb2383770ce50b179_G_2 = _Add_1145b2f896593d80aa864a34e6702562_Out_2[1];
            float _Split_2bc77ca2d17bd78cb2383770ce50b179_B_3 = 0;
            float _Split_2bc77ca2d17bd78cb2383770ce50b179_A_4 = 0;
            float _Multiply_ab12aea87465a78eaf7fc66c2598d266_Out_2;
            Unity_Multiply_float(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6, _Split_5ed44bf2eca0868f81eb18100f49d1fa_G_2, _Multiply_ab12aea87465a78eaf7fc66c2598d266_Out_2);
            float3 _Vector3_433840b555db308b97e9b14b6a957195_Out_0 = float3(_Split_2bc77ca2d17bd78cb2383770ce50b179_R_1, _Multiply_ab12aea87465a78eaf7fc66c2598d266_Out_2, _Split_2bc77ca2d17bd78cb2383770ce50b179_G_2);
            float3x3 Transform_c7914cc45a011c89b3f53c55afb51673_tangentTransform_World = float3x3(IN.WorldSpaceTangent, IN.WorldSpaceBiTangent, IN.WorldSpaceNormal);
            float3 _Transform_c7914cc45a011c89b3f53c55afb51673_Out_1 = TransformWorldToTangent(_Vector3_433840b555db308b97e9b14b6a957195_Out_0.xyz, Transform_c7914cc45a011c89b3f53c55afb51673_tangentTransform_World);
            float3 _Normalize_09bf8a2bd0a4d38e8b97d5c674f79b44_Out_1;
            Unity_Normalize_float3(_Transform_c7914cc45a011c89b3f53c55afb51673_Out_1, _Normalize_09bf8a2bd0a4d38e8b97d5c674f79b44_Out_1);
            float3 _Branch_9eadf909a90f2f80880f8c56ecc2a91f_Out_3;
            Unity_Branch_float3(_Property_1ef12cf3201a938993fe6a7951b0e754_Out_0, _Normalize_09bf8a2bd0a4d38e8b97d5c674f79b44_Out_1, (_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.xyz), _Branch_9eadf909a90f2f80880f8c56ecc2a91f_Out_3);
            XZ_2 = (float4(_Branch_9eadf909a90f2f80880f8c56ecc2a91f_Out_3, 1.0));
        }

        void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
        {
            Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
        }

        void Unity_Absolute_float(float In, out float Out)
        {
            Out = abs(In);
        }

        void Unity_Power_float(float A, float B, out float Out)
        {
            Out = pow(A, B);
        }

        void Unity_Saturate_float(float In, out float Out)
        {
            Out = saturate(In);
        }

        void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
        {
            Out = lerp(A, B, T);
        }

        void Unity_Lerp_float(float A, float B, float T, out float Out)
        {
            Out = lerp(A, B, T);
        }

            // Graph Vertex
            struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };

        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }

            // Graph Pixel
            struct SurfaceDescription
        {
            float3 BaseColor;
            float3 Emission;
            float Alpha;
            float AlphaClipThreshold;
        };

        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_07d75b1d2628da808a2efb93a1d6219e_Out_0 = UnityBuildTexture2DStructNoScale(_BaseColorMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0 = _BaseTilingOffset;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_7f998178363b4188ba2f07298ef869c1_Out_0 = _BaseUsePlanarUV;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e;
            _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e.uv0 = IN.uv0;
            float4 _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2;
            SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(_Property_07d75b1d2628da808a2efb93a1d6219e_Out_0, _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0, _Property_7f998178363b4188ba2f07298ef869c1_Out_0, _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e, _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_b83097c58639858680bf43881a95b0af_Out_0 = _BaseColor;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2;
            Unity_Multiply_float(_PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2, _Property_b83097c58639858680bf43881a95b0af_Out_0, _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_1e449ff9f8e8ec828507233e8240eb11_Out_0 = UnityBuildTexture2DStructNoScale(_BaseMaskMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_4245c3b264047180b5c90a697d6cb278;
            _PlanarNM_4245c3b264047180b5c90a697d6cb278.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNM_4245c3b264047180b5c90a697d6cb278.uv0 = IN.uv0;
            float4 _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2;
            SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(_Property_1e449ff9f8e8ec828507233e8240eb11_Out_0, _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0, _Property_7f998178363b4188ba2f07298ef869c1_Out_0, _PlanarNM_4245c3b264047180b5c90a697d6cb278, _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_91a015dea8acd38b904ba0935328a5bc_R_1 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[0];
            float _Split_91a015dea8acd38b904ba0935328a5bc_G_2 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[1];
            float _Split_91a015dea8acd38b904ba0935328a5bc_B_3 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[2];
            float _Split_91a015dea8acd38b904ba0935328a5bc_A_4 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_fbcff1469ebf488394a8a89ddaf0eb2a_Out_0 = _HeightMin;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_9df7a44c8225168683743ac60c0c3c34_Out_0 = _HeightMax;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_9b1e95888c28bc8893f28c02b87fa448_Out_0 = float2(_Property_fbcff1469ebf488394a8a89ddaf0eb2a_Out_0, _Property_9df7a44c8225168683743ac60c0c3c34_Out_0);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_29ca14fd0b712983a38d63d2dd326e96_Out_0 = _HeightOffset;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Add_cb503f8a09720d84bb03cbd89e37b80c_Out_2;
            Unity_Add_float2(_Vector2_9b1e95888c28bc8893f28c02b87fa448_Out_0, (_Property_29ca14fd0b712983a38d63d2dd326e96_Out_0.xx), _Add_cb503f8a09720d84bb03cbd89e37b80c_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3;
            Unity_Remap_float(_Split_91a015dea8acd38b904ba0935328a5bc_B_3, float2 (0, 1), _Add_cb503f8a09720d84bb03cbd89e37b80c_Out_2, _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_ba3a5f4cba7d0a8fa288ffc8267d6c0e_Out_0 = UnityBuildTexture2DStructNoScale(_Base2ColorMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_86a4657df480d48e8d3ad3b036731380_Out_0 = _Base2TilingOffset;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0 = _Base2UsePlanarUV;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4;
            _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4.uv0 = IN.uv0;
            float4 _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4_XZ_2;
            SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(_Property_ba3a5f4cba7d0a8fa288ffc8267d6c0e_Out_0, _Property_86a4657df480d48e8d3ad3b036731380_Out_0, _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0, _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4, _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_3561b11b899bda8e855826445cf628aa_Out_0 = _Base2Color;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2;
            Unity_Multiply_float(_PlanarNM_5aeab444ca6fd78ea56a01215880a5a4_XZ_2, _Property_3561b11b899bda8e855826445cf628aa_Out_0, _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_c34b73d933404283983f9c8bdb5365d3_R_1 = IN.VertexColor[0];
            float _Split_c34b73d933404283983f9c8bdb5365d3_G_2 = IN.VertexColor[1];
            float _Split_c34b73d933404283983f9c8bdb5365d3_B_3 = IN.VertexColor[2];
            float _Split_c34b73d933404283983f9c8bdb5365d3_A_4 = IN.VertexColor[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_df2df7bb5cfc3381beee7ec454da7542_Out_0 = _Invert_Layer_Mask;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_c7b1e2df9f9b0e8eace9b2274924e69c_Out_0 = UnityBuildTexture2DStructNoScale(_LayerMask);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0 = SAMPLE_TEXTURE2D(_Property_c7b1e2df9f9b0e8eace9b2274924e69c_Out_0.tex, _Property_c7b1e2df9f9b0e8eace9b2274924e69c_Out_0.samplerstate, IN.uv0.xy);
            float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.r;
            float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_G_5 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.g;
            float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_B_6 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.b;
            float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_A_7 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1;
            Unity_OneMinus_float(_SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4, _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Branch_af0c5e511241ce8eae748ae487df50fa_Out_3;
            Unity_Branch_float(_Property_df2df7bb5cfc3381beee7ec454da7542_Out_0, _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1, _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4, _Branch_af0c5e511241ce8eae748ae487df50fa_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_de4f6eb48a629285a664dad7fb06438f_Out_0 = UnityBuildTexture2DStructNoScale(_Base2MaskMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_d5657f470f05ef839e4c257a20ace8cb;
            _PlanarNM_d5657f470f05ef839e4c257a20ace8cb.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNM_d5657f470f05ef839e4c257a20ace8cb.uv0 = IN.uv0;
            float4 _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2;
            SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(_Property_de4f6eb48a629285a664dad7fb06438f_Out_0, _Property_86a4657df480d48e8d3ad3b036731380_Out_0, _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0, _PlanarNM_d5657f470f05ef839e4c257a20ace8cb, _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_83ec66b648ab6c84848b42686c256cd7_R_1 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[0];
            float _Split_83ec66b648ab6c84848b42686c256cd7_G_2 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[1];
            float _Split_83ec66b648ab6c84848b42686c256cd7_B_3 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[2];
            float _Split_83ec66b648ab6c84848b42686c256cd7_A_4 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_ce1750e5c69e97818667b412fc3f9f2c_Out_0 = _HeightMin2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_8e0f2ea54d8ede89bbabdf31a9bafd57_Out_0 = _HeightMax2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_fb6c6dd7e70e768ba686e8e94153bb96_Out_0 = float2(_Property_ce1750e5c69e97818667b412fc3f9f2c_Out_0, _Property_8e0f2ea54d8ede89bbabdf31a9bafd57_Out_0);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_151ae2702b614585af2000f0a812960f_Out_0 = _HeightOffset2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2;
            Unity_Add_float2(_Vector2_fb6c6dd7e70e768ba686e8e94153bb96_Out_0, (_Property_151ae2702b614585af2000f0a812960f_Out_0.xx), _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3;
            Unity_Remap_float(_Split_83ec66b648ab6c84848b42686c256cd7_B_3, float2 (0, 1), _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2, _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2;
            Unity_Multiply_float(_Branch_af0c5e511241ce8eae748ae487df50fa_Out_3, _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3, _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2;
            Unity_Multiply_float(_Split_c34b73d933404283983f9c8bdb5365d3_R_1, _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2, _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_818c8af4b930138e81034c886614171d_Out_0 = _Height_Transition;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 _HeightBlend_7501025b3a60738a9a9d362e35a9ab48;
            float3 _HeightBlend_7501025b3a60738a9a9d362e35a9ab48_OutVector4_1;
            SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135((_Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2.xyz), _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3, (_Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2.xyz), _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2, _Property_818c8af4b930138e81034c886614171d_Out_0, _HeightBlend_7501025b3a60738a9a9d362e35a9ab48, _HeightBlend_7501025b3a60738a9a9d362e35a9ab48_OutVector4_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_c0ebdab0f71ace8aabaa865fd7293599_Out_0 = UnityBuildTexture2DStructNoScale(_CoverBaseColorMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_822489d2e6d3e08590c64f085ffd9b2e_Out_0 = _CoverTilingOffset;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_2ae4a163bd21d98789af282d6e469175_Out_0 = _CoverUsePlanarUV;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_8bb420494d19b28e9ccdff489802dc81;
            _PlanarNM_8bb420494d19b28e9ccdff489802dc81.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNM_8bb420494d19b28e9ccdff489802dc81.uv0 = IN.uv0;
            float4 _PlanarNM_8bb420494d19b28e9ccdff489802dc81_XZ_2;
            SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(_Property_c0ebdab0f71ace8aabaa865fd7293599_Out_0, _Property_822489d2e6d3e08590c64f085ffd9b2e_Out_0, _Property_2ae4a163bd21d98789af282d6e469175_Out_0, _PlanarNM_8bb420494d19b28e9ccdff489802dc81, _PlanarNM_8bb420494d19b28e9ccdff489802dc81_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_55e7941fa7ac5f8387aa9bb633b08883_Out_0 = _CoverBaseColor;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Multiply_a38ba695a2660c8691763f0bd7fe159c_Out_2;
            Unity_Multiply_float(_PlanarNM_8bb420494d19b28e9ccdff489802dc81_XZ_2, _Property_55e7941fa7ac5f8387aa9bb633b08883_Out_0, _Multiply_a38ba695a2660c8691763f0bd7fe159c_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_c0d223db25424a8ab0cee2de2bbf58ce_Out_0 = UnityBuildTexture2DStructNoScale(_CoverMaskA);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _UV_5352c8dd0add178ba83a5421c2c0b3f0_Out_0 = IN.uv0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _SampleTexture2D_024ba490c015248988a12a9d670014ea_RGBA_0 = SAMPLE_TEXTURE2D(_Property_c0d223db25424a8ab0cee2de2bbf58ce_Out_0.tex, _Property_c0d223db25424a8ab0cee2de2bbf58ce_Out_0.samplerstate, (_UV_5352c8dd0add178ba83a5421c2c0b3f0_Out_0.xy));
            float _SampleTexture2D_024ba490c015248988a12a9d670014ea_R_4 = _SampleTexture2D_024ba490c015248988a12a9d670014ea_RGBA_0.r;
            float _SampleTexture2D_024ba490c015248988a12a9d670014ea_G_5 = _SampleTexture2D_024ba490c015248988a12a9d670014ea_RGBA_0.g;
            float _SampleTexture2D_024ba490c015248988a12a9d670014ea_B_6 = _SampleTexture2D_024ba490c015248988a12a9d670014ea_RGBA_0.b;
            float _SampleTexture2D_024ba490c015248988a12a9d670014ea_A_7 = _SampleTexture2D_024ba490c015248988a12a9d670014ea_RGBA_0.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_b80e7b96604b7c82bbf9bff4981fad76_Out_0 = _CoverMaskPower;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_abe410d256783480b1b58468bf78a882_Out_2;
            Unity_Multiply_float(_SampleTexture2D_024ba490c015248988a12a9d670014ea_A_7, _Property_b80e7b96604b7c82bbf9bff4981fad76_Out_0, _Multiply_abe410d256783480b1b58468bf78a882_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_a78f6f28770afd869adb9d12cd47370b_Out_3;
            Unity_Clamp_float(_Multiply_abe410d256783480b1b58468bf78a882_Out_2, 0, 1, _Clamp_a78f6f28770afd869adb9d12cd47370b_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_7c7049e15fdff386b535790d8666f609_Out_0 = UnityBuildTexture2DStructNoScale(_BaseNormalMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8;
            _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.WorldSpaceNormal = IN.WorldSpaceNormal;
            _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.WorldSpaceTangent = IN.WorldSpaceTangent;
            _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
            _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.uv0 = IN.uv0;
            float4 _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8_XZ_2;
            SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(_Property_7c7049e15fdff386b535790d8666f609_Out_0, _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0, _Property_7f998178363b4188ba2f07298ef869c1_Out_0, _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8, _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_d4b0759cf4647e81be065ec1465ce2b4_Out_0 = _BaseNormalScale;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _NormalStrength_f66a9108ea294886acc61513b41cc5e4_Out_2;
            Unity_NormalStrength_float((_PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8_XZ_2.xyz), _Property_d4b0759cf4647e81be065ec1465ce2b4_Out_0, _NormalStrength_f66a9108ea294886acc61513b41cc5e4_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_fa9f7890b20ad481a92543c04b237bde_Out_0 = UnityBuildTexture2DStructNoScale(_Base2NormalMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf;
            _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.WorldSpaceNormal = IN.WorldSpaceNormal;
            _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.WorldSpaceTangent = IN.WorldSpaceTangent;
            _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
            _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.uv0 = IN.uv0;
            float4 _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf_XZ_2;
            SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(_Property_fa9f7890b20ad481a92543c04b237bde_Out_0, _Property_86a4657df480d48e8d3ad3b036731380_Out_0, _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0, _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf, _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_8c31443b776727819a663c7ddce79064_Out_0 = _Base2NormalScale;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _NormalStrength_0fb86880ab8e368dac6d01b830e20ed8_Out_2;
            Unity_NormalStrength_float((_PlanarNMn_d7b3ec528088a085a5102e025a1b45cf_XZ_2.xyz), _Property_8c31443b776727819a663c7ddce79064_Out_0, _NormalStrength_0fb86880ab8e368dac6d01b830e20ed8_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 _HeightBlend_7c09d97625efce898e21b66cd039be8b;
            float3 _HeightBlend_7c09d97625efce898e21b66cd039be8b_OutVector4_1;
            SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135(_NormalStrength_f66a9108ea294886acc61513b41cc5e4_Out_2, _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3, _NormalStrength_0fb86880ab8e368dac6d01b830e20ed8_Out_2, _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2, _Property_818c8af4b930138e81034c886614171d_Out_0, _HeightBlend_7c09d97625efce898e21b66cd039be8b, _HeightBlend_7c09d97625efce898e21b66cd039be8b_OutVector4_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_65f7dd6fe6c29b83913af586c597a1ef_Out_0 = UnityBuildTexture2DStructNoScale(_CoverNormalMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3;
            _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3.WorldSpaceNormal = IN.WorldSpaceNormal;
            _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3.WorldSpaceTangent = IN.WorldSpaceTangent;
            _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
            _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3.uv0 = IN.uv0;
            float4 _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3_XZ_2;
            SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(_Property_65f7dd6fe6c29b83913af586c597a1ef_Out_0, _Property_822489d2e6d3e08590c64f085ffd9b2e_Out_0, _Property_2ae4a163bd21d98789af282d6e469175_Out_0, _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3, _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_19f92cae42737480a95820c51d4ba124_Out_0 = _CoverNormalBlendHardness;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _NormalStrength_2c3488591b8345869feb25a3dee06c3f_Out_2;
            Unity_NormalStrength_float((_PlanarNMn_248bc5b7421d3f828d166902c73ca6c3_XZ_2.xyz), _Property_19f92cae42737480a95820c51d4ba124_Out_0, _NormalStrength_2c3488591b8345869feb25a3dee06c3f_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_96bfe9cb80ad308385c191d094b3d071_R_1 = IN.WorldSpaceNormal[0];
            float _Split_96bfe9cb80ad308385c191d094b3d071_G_2 = IN.WorldSpaceNormal[1];
            float _Split_96bfe9cb80ad308385c191d094b3d071_B_3 = IN.WorldSpaceNormal[2];
            float _Split_96bfe9cb80ad308385c191d094b3d071_A_4 = 0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_0dd796aae8cd9f878bef13ceac4fe3ec_Out_0 = _Cover_Amount;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_67285cdc688aa38d83f62d5bb095d597_Out_0 = _Cover_Amount_Grow_Speed;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Subtract_fcefec675e7536888eccf5574d921972_Out_2;
            Unity_Subtract_float(4, _Property_67285cdc688aa38d83f62d5bb095d597_Out_0, _Subtract_fcefec675e7536888eccf5574d921972_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Divide_1e25465528e612839a4ce1faedd89e7d_Out_2;
            Unity_Divide_float(_Property_0dd796aae8cd9f878bef13ceac4fe3ec_Out_0, _Subtract_fcefec675e7536888eccf5574d921972_Out_2, _Divide_1e25465528e612839a4ce1faedd89e7d_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Absolute_d20b810ffdec828ab74dd6692d82f01b_Out_1;
            Unity_Absolute_float(_Divide_1e25465528e612839a4ce1faedd89e7d_Out_2, _Absolute_d20b810ffdec828ab74dd6692d82f01b_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Power_181fbf47cfdb258da1fe0b72a450986f_Out_2;
            Unity_Power_float(_Absolute_d20b810ffdec828ab74dd6692d82f01b_Out_1, _Subtract_fcefec675e7536888eccf5574d921972_Out_2, _Power_181fbf47cfdb258da1fe0b72a450986f_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_11f62dba01f1a38c9e0a9972ccd19246_Out_3;
            Unity_Clamp_float(_Power_181fbf47cfdb258da1fe0b72a450986f_Out_2, 0, 2, _Clamp_11f62dba01f1a38c9e0a9972ccd19246_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_9810f6d76275cd8fbe5e3a02360b98a7_Out_2;
            Unity_Multiply_float(_Split_96bfe9cb80ad308385c191d094b3d071_G_2, _Clamp_11f62dba01f1a38c9e0a9972ccd19246_Out_3, _Multiply_9810f6d76275cd8fbe5e3a02360b98a7_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Saturate_a007c5f214685c87bf6ca3e64c06b488_Out_1;
            Unity_Saturate_float(_Multiply_9810f6d76275cd8fbe5e3a02360b98a7_Out_2, _Saturate_a007c5f214685c87bf6ca3e64c06b488_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_1b2b25b617fc508b9835f0309136fd00_Out_3;
            Unity_Clamp_float(_Split_96bfe9cb80ad308385c191d094b3d071_G_2, 0, 0.9999, _Clamp_1b2b25b617fc508b9835f0309136fd00_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_7b12276ea7a4538db6804507b30a830c_Out_0 = _Cover_Max_Angle;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Divide_54c523ff4b7acb858e9e368fd1e4d34a_Out_2;
            Unity_Divide_float(_Property_7b12276ea7a4538db6804507b30a830c_Out_0, 45, _Divide_54c523ff4b7acb858e9e368fd1e4d34a_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _OneMinus_6cf431985b651e8e9546ae6cb2d4d668_Out_1;
            Unity_OneMinus_float(_Divide_54c523ff4b7acb858e9e368fd1e4d34a_Out_2, _OneMinus_6cf431985b651e8e9546ae6cb2d4d668_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Subtract_4ef7b60aeab8d589bf2d2423737642bc_Out_2;
            Unity_Subtract_float(_Clamp_1b2b25b617fc508b9835f0309136fd00_Out_3, _OneMinus_6cf431985b651e8e9546ae6cb2d4d668_Out_1, _Subtract_4ef7b60aeab8d589bf2d2423737642bc_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_a4b51894ea17818c9a27bb533a2ebe74_Out_3;
            Unity_Clamp_float(_Subtract_4ef7b60aeab8d589bf2d2423737642bc_Out_2, 0, 2, _Clamp_a4b51894ea17818c9a27bb533a2ebe74_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Divide_c4196d4f02190b89ba827ccd4ae8a74d_Out_2;
            Unity_Divide_float(1, _Divide_54c523ff4b7acb858e9e368fd1e4d34a_Out_2, _Divide_c4196d4f02190b89ba827ccd4ae8a74d_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_ffc22433163d1184846ede424b44bcb2_Out_2;
            Unity_Multiply_float(_Clamp_a4b51894ea17818c9a27bb533a2ebe74_Out_3, _Divide_c4196d4f02190b89ba827ccd4ae8a74d_Out_2, _Multiply_ffc22433163d1184846ede424b44bcb2_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Absolute_c2e5757082de5d878d4c023806fb2108_Out_1;
            Unity_Absolute_float(_Multiply_ffc22433163d1184846ede424b44bcb2_Out_2, _Absolute_c2e5757082de5d878d4c023806fb2108_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_849d9f217c95f38c9d49ab251578d8d5_Out_0 = _CoverHardness;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Power_578546d66d69a5829b745ebba1279adf_Out_2;
            Unity_Power_float(_Absolute_c2e5757082de5d878d4c023806fb2108_Out_1, _Property_849d9f217c95f38c9d49ab251578d8d5_Out_0, _Power_578546d66d69a5829b745ebba1279adf_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_34d2d3aff4814e8e83d2894b3512c6c8_Out_0 = _Cover_Min_Height;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _OneMinus_474df64227f004849b34c68fe8df93f2_Out_1;
            Unity_OneMinus_float(_Property_34d2d3aff4814e8e83d2894b3512c6c8_Out_0, _OneMinus_474df64227f004849b34c68fe8df93f2_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_ee4d9dc934b3508397d5a3dece110ab0_R_1 = IN.AbsoluteWorldSpacePosition[0];
            float _Split_ee4d9dc934b3508397d5a3dece110ab0_G_2 = IN.AbsoluteWorldSpacePosition[1];
            float _Split_ee4d9dc934b3508397d5a3dece110ab0_B_3 = IN.AbsoluteWorldSpacePosition[2];
            float _Split_ee4d9dc934b3508397d5a3dece110ab0_A_4 = 0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Add_d6bc513aa82d918ea24e279f4353d971_Out_2;
            Unity_Add_float(_OneMinus_474df64227f004849b34c68fe8df93f2_Out_1, _Split_ee4d9dc934b3508397d5a3dece110ab0_G_2, _Add_d6bc513aa82d918ea24e279f4353d971_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Add_a6a61cb12180108c9e1364b90d2673e2_Out_2;
            Unity_Add_float(_Add_d6bc513aa82d918ea24e279f4353d971_Out_2, 1, _Add_a6a61cb12180108c9e1364b90d2673e2_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_1874fdd00cb9aa839d93ab8536e2414d_Out_3;
            Unity_Clamp_float(_Add_a6a61cb12180108c9e1364b90d2673e2_Out_2, 0, 1, _Clamp_1874fdd00cb9aa839d93ab8536e2414d_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_7b91fd6e21b46c85816c7b681307cbe4_Out_0 = _Cover_Min_Height_Blending;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Add_6dca9453f6a35e8185c4b8e9782db0a9_Out_2;
            Unity_Add_float(_Add_d6bc513aa82d918ea24e279f4353d971_Out_2, _Property_7b91fd6e21b46c85816c7b681307cbe4_Out_0, _Add_6dca9453f6a35e8185c4b8e9782db0a9_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Divide_83415a319ecfba83af914cbc5487b546_Out_2;
            Unity_Divide_float(_Add_6dca9453f6a35e8185c4b8e9782db0a9_Out_2, _Add_d6bc513aa82d918ea24e279f4353d971_Out_2, _Divide_83415a319ecfba83af914cbc5487b546_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _OneMinus_bf150b22fcad5a87b7c825c9c6cf1687_Out_1;
            Unity_OneMinus_float(_Divide_83415a319ecfba83af914cbc5487b546_Out_2, _OneMinus_bf150b22fcad5a87b7c825c9c6cf1687_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Add_86ff9fa850efbe8c80705d8266609dab_Out_2;
            Unity_Add_float(_OneMinus_bf150b22fcad5a87b7c825c9c6cf1687_Out_1, -0.5, _Add_86ff9fa850efbe8c80705d8266609dab_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_906e140f01222d8ba61252ec6ec9d6a4_Out_3;
            Unity_Clamp_float(_Add_86ff9fa850efbe8c80705d8266609dab_Out_2, 0, 1, _Clamp_906e140f01222d8ba61252ec6ec9d6a4_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Add_c1ec5849bf72f585a30b3e11a91ada52_Out_2;
            Unity_Add_float(_Clamp_1874fdd00cb9aa839d93ab8536e2414d_Out_3, _Clamp_906e140f01222d8ba61252ec6ec9d6a4_Out_3, _Add_c1ec5849bf72f585a30b3e11a91ada52_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_17a8a0cf209a038b9e9c7f5681cdd1fb_Out_3;
            Unity_Clamp_float(_Add_c1ec5849bf72f585a30b3e11a91ada52_Out_2, 0, 1, _Clamp_17a8a0cf209a038b9e9c7f5681cdd1fb_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_8c2759ac24a9b289b1e9610cfd161bb0_Out_2;
            Unity_Multiply_float(_Power_578546d66d69a5829b745ebba1279adf_Out_2, _Clamp_17a8a0cf209a038b9e9c7f5681cdd1fb_Out_3, _Multiply_8c2759ac24a9b289b1e9610cfd161bb0_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_1a723f136ec7fa8c957b5d29e03d3051_Out_2;
            Unity_Multiply_float(_Saturate_a007c5f214685c87bf6ca3e64c06b488_Out_1, _Multiply_8c2759ac24a9b289b1e9610cfd161bb0_Out_2, _Multiply_1a723f136ec7fa8c957b5d29e03d3051_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Lerp_d1c72e47b283948584479177786ae8d5_Out_3;
            Unity_Lerp_float3(_HeightBlend_7c09d97625efce898e21b66cd039be8b_OutVector4_1, _NormalStrength_2c3488591b8345869feb25a3dee06c3f_Out_2, (_Multiply_1a723f136ec7fa8c957b5d29e03d3051_Out_2.xxx), _Lerp_d1c72e47b283948584479177786ae8d5_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3x3 Transform_180fb403b53f318db002e8eba7616644_transposeTangent = transpose(float3x3(IN.WorldSpaceTangent, IN.WorldSpaceBiTangent, IN.WorldSpaceNormal));
            float3 _Transform_180fb403b53f318db002e8eba7616644_Out_1 = normalize(mul(Transform_180fb403b53f318db002e8eba7616644_transposeTangent, _Lerp_d1c72e47b283948584479177786ae8d5_Out_3.xyz).xyz);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_c9a2b4fb4f688b8ebfc1436535cd5ba4_R_1 = _Transform_180fb403b53f318db002e8eba7616644_Out_1[0];
            float _Split_c9a2b4fb4f688b8ebfc1436535cd5ba4_G_2 = _Transform_180fb403b53f318db002e8eba7616644_Out_1[1];
            float _Split_c9a2b4fb4f688b8ebfc1436535cd5ba4_B_3 = _Transform_180fb403b53f318db002e8eba7616644_Out_1[2];
            float _Split_c9a2b4fb4f688b8ebfc1436535cd5ba4_A_4 = 0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_4c7631d0688102819e6d388d624855a1_Out_2;
            Unity_Multiply_float(_Split_c9a2b4fb4f688b8ebfc1436535cd5ba4_G_2, _Clamp_11f62dba01f1a38c9e0a9972ccd19246_Out_3, _Multiply_4c7631d0688102819e6d388d624855a1_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_f2887eb409f6bb81ae4caad2b01b17f1_Out_2;
            Unity_Multiply_float(_Clamp_11f62dba01f1a38c9e0a9972ccd19246_Out_3, _Property_849d9f217c95f38c9d49ab251578d8d5_Out_0, _Multiply_f2887eb409f6bb81ae4caad2b01b17f1_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_2e348ed31331e78791b2b3130a009f30_Out_2;
            Unity_Multiply_float(_Multiply_f2887eb409f6bb81ae4caad2b01b17f1_Out_2, _Multiply_8c2759ac24a9b289b1e9610cfd161bb0_Out_2, _Multiply_2e348ed31331e78791b2b3130a009f30_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_622e54e9a77b08839c0954ce5715ad1c_Out_2;
            Unity_Multiply_float(_Multiply_4c7631d0688102819e6d388d624855a1_Out_2, _Multiply_2e348ed31331e78791b2b3130a009f30_Out_2, _Multiply_622e54e9a77b08839c0954ce5715ad1c_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_608db04fab7d768d9a8b5fb9cf0768e1_Out_0 = UnityBuildTexture2DStructNoScale(_CoverMaskMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e;
            _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e.uv0 = IN.uv0;
            float4 _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e_XZ_2;
            SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(_Property_608db04fab7d768d9a8b5fb9cf0768e1_Out_0, _Property_822489d2e6d3e08590c64f085ffd9b2e_Out_0, _Property_2ae4a163bd21d98789af282d6e469175_Out_0, _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e, _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_86ec1aefda4f9e8e82b79c6195b397b0_R_1 = _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e_XZ_2[0];
            float _Split_86ec1aefda4f9e8e82b79c6195b397b0_G_2 = _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e_XZ_2[1];
            float _Split_86ec1aefda4f9e8e82b79c6195b397b0_B_3 = _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e_XZ_2[2];
            float _Split_86ec1aefda4f9e8e82b79c6195b397b0_A_4 = _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e_XZ_2[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_c9c6897e00458b8f8aa07df49fa519bc_Out_0 = _CoverHeightMapMin;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_ab94650b8edd82828661fe99e3c0e849_Out_0 = _CoverHeightMapMax;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_fe489f7321f6568686816b9eecbc16d1_Out_0 = float2(_Property_c9c6897e00458b8f8aa07df49fa519bc_Out_0, _Property_ab94650b8edd82828661fe99e3c0e849_Out_0);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_c1ab40024cb83b87960e4327efbd997f_Out_0 = _CoverHeightMapOffset;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Add_4a359522fc231c83b55ef23f341b6fb3_Out_2;
            Unity_Add_float2(_Vector2_fe489f7321f6568686816b9eecbc16d1_Out_0, (_Property_c1ab40024cb83b87960e4327efbd997f_Out_0.xx), _Add_4a359522fc231c83b55ef23f341b6fb3_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Remap_5aee5b64d41562858dc7c42d8b748894_Out_3;
            Unity_Remap_float(_Split_86ec1aefda4f9e8e82b79c6195b397b0_B_3, float2 (0, 1), _Add_4a359522fc231c83b55ef23f341b6fb3_Out_2, _Remap_5aee5b64d41562858dc7c42d8b748894_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_f0228e1cfd9c858dbb36367f551733c4_Out_2;
            Unity_Multiply_float(_Multiply_622e54e9a77b08839c0954ce5715ad1c_Out_2, _Remap_5aee5b64d41562858dc7c42d8b748894_Out_3, _Multiply_f0228e1cfd9c858dbb36367f551733c4_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_bb4d60728db93b8a9af9635fa1d69891_Out_2;
            Unity_Multiply_float(_Split_c34b73d933404283983f9c8bdb5365d3_G_2, _Multiply_f0228e1cfd9c858dbb36367f551733c4_Out_2, _Multiply_bb4d60728db93b8a9af9635fa1d69891_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Saturate_9b052a9bb99eff89bb11bdc387a0c2fd_Out_1;
            Unity_Saturate_float(_Multiply_bb4d60728db93b8a9af9635fa1d69891_Out_2, _Saturate_9b052a9bb99eff89bb11bdc387a0c2fd_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_22fb8c1cfd28b687a991e101aa13ff5b_Out_2;
            Unity_Multiply_float(_Clamp_a78f6f28770afd869adb9d12cd47370b_Out_3, _Saturate_9b052a9bb99eff89bb11bdc387a0c2fd_Out_1, _Multiply_22fb8c1cfd28b687a991e101aa13ff5b_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #if defined(_USEDYNAMICCOVERTSTATICMASKF_ON)
            float _UseDynamicCoverTStaticMaskF_20dcbac2f16cf78ebd6fd1debcd7f281_Out_0 = _Multiply_22fb8c1cfd28b687a991e101aa13ff5b_Out_2;
            #else
            float _UseDynamicCoverTStaticMaskF_20dcbac2f16cf78ebd6fd1debcd7f281_Out_0 = _Clamp_a78f6f28770afd869adb9d12cd47370b_Out_3;
            #endif
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Lerp_e5620b57c917728fa1416e2ffce9b0db_Out_3;
            Unity_Lerp_float3(_HeightBlend_7501025b3a60738a9a9d362e35a9ab48_OutVector4_1, (_Multiply_a38ba695a2660c8691763f0bd7fe159c_Out_2.xyz), (_UseDynamicCoverTStaticMaskF_20dcbac2f16cf78ebd6fd1debcd7f281_Out_0.xxx), _Lerp_e5620b57c917728fa1416e2ffce9b0db_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_c7a719bf7da79a8ea38d7311fd844f92_R_1 = _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2[0];
            float _Split_c7a719bf7da79a8ea38d7311fd844f92_G_2 = _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2[1];
            float _Split_c7a719bf7da79a8ea38d7311fd844f92_B_3 = _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2[2];
            float _Split_c7a719bf7da79a8ea38d7311fd844f92_A_4 = _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_7c5dae9b46c9e686b49e58fa996a104a_Out_0 = IgnoreBase2Alpha;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_e9060f5c0433ec889696d3e462f3229b_R_1 = _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2[0];
            float _Split_e9060f5c0433ec889696d3e462f3229b_G_2 = _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2[1];
            float _Split_e9060f5c0433ec889696d3e462f3229b_B_3 = _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2[2];
            float _Split_e9060f5c0433ec889696d3e462f3229b_A_4 = _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Branch_a7d7aece30fd9b8eb456d191fdd37a06_Out_3;
            Unity_Branch_float(_Property_7c5dae9b46c9e686b49e58fa996a104a_Out_0, _Split_c7a719bf7da79a8ea38d7311fd844f92_A_4, _Split_e9060f5c0433ec889696d3e462f3229b_A_4, _Branch_a7d7aece30fd9b8eb456d191fdd37a06_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Lerp_8692ca93f568998fbc97130b6dbc4556_Out_3;
            Unity_Lerp_float(_Split_c7a719bf7da79a8ea38d7311fd844f92_A_4, _Branch_a7d7aece30fd9b8eb456d191fdd37a06_Out_3, _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2, _Lerp_8692ca93f568998fbc97130b6dbc4556_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_0c8b7b55b9f82588ab2dcff09ee7a16d_Out_3;
            Unity_Clamp_float(_Lerp_8692ca93f568998fbc97130b6dbc4556_Out_3, 0, 1, _Clamp_0c8b7b55b9f82588ab2dcff09ee7a16d_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_6333dc4a6348088bb7281602ce6bff5f_Out_2;
            Unity_Multiply_float(_Clamp_0c8b7b55b9f82588ab2dcff09ee7a16d_Out_3, _Split_c34b73d933404283983f9c8bdb5365d3_A_4, _Multiply_6333dc4a6348088bb7281602ce6bff5f_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_9642b8fb7e32b18a91da1888c9bc375b_Out_3;
            Unity_Clamp_float(_Multiply_6333dc4a6348088bb7281602ce6bff5f_Out_2, 0, 1, _Clamp_9642b8fb7e32b18a91da1888c9bc375b_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_8bc98dd454a5508b9864a6ba09772356_Out_0 = _AlphaCutoff;
            #endif
            surface.BaseColor = _Lerp_e5620b57c917728fa1416e2ffce9b0db_Out_3;
            surface.Emission = float3(0, 0, 0);
            surface.Alpha = _Clamp_9642b8fb7e32b18a91da1888c9bc375b_Out_3;
            surface.AlphaClipThreshold = _Property_8bc98dd454a5508b9864a6ba09772356_Out_0;
            return surface;
        }

            // --------------------------------------------------
            // Build Graph Inputs

            VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceNormal =           input.normalOS;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceTangent =          input.tangentOS.xyz;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpacePosition =         input.positionOS;
        #endif


            return output;
        }
            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 unnormalizedNormalWS = input.normalWS;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        const float renormFactor = 1.0 / length(unnormalizedNormalWS);
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // use bitangent on the fly like in hdrp
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // IMPORTANT! If we ever support Flip on double sided materials ensure bitangent and tangent are NOT flipped.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float crossSign = (input.tangentWS.w > 0.0 ? 1.0 : -1.0) * GetOddNegativeScale();
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 bitang = crossSign * cross(input.normalWS.xyz, input.tangentWS.xyz);
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceNormal =            renormFactor*input.normalWS.xyz;		// we want a unit length Normal Vector node in shader graph
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // to preserve mikktspace compliance we use same scale renormFactor as was used on the normal.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // This is explained in section 2.2 in "surface gradient based bump mapping framework"
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceTangent =           renormFactor*input.tangentWS.xyz;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceBiTangent =         renormFactor*bitang;
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(input.positionWS);
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.uv0 =                         input.texCoord0;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.VertexColor =                 input.color;
        #endif

        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

            return output;
        }

            // --------------------------------------------------
            // Main

            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/LightingMetaPass.hlsl"

            ENDHLSL
        }
        Pass
        {
            // Name: <None>
            Tags
            {
                "LightMode" = "Universal2D"
            }

            // Render State
            Cull Back
        Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
        ZTest LEqual
       ZWrite On

            // Debug
            // <None>

            // --------------------------------------------------
            // Pass

            HLSLPROGRAM

            // Pragmas
            #pragma target 2.0
        #pragma only_renderers gles gles3 glcore d3d11
        #pragma multi_compile_instancing
        #pragma vertex vert
        #pragma fragment frag

            // DotsInstancingOptions: <None>
            // HybridV1InjectedBuiltinProperties: <None>

            // Keywords
            // PassKeywords: <None>
            #pragma shader_feature_local _ _USEDYNAMICCOVERTSTATICMASKF_ON

        #if defined(_USEDYNAMICCOVERTSTATICMASKF_ON)
            #define KEYWORD_PERMUTATION_0
        #else
            #define KEYWORD_PERMUTATION_1
        #endif


            // Defines
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _SURFACE_TYPE_TRANSPARENT 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _AlphaClip 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMALMAP 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMAL_DROPOFF_TS 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_NORMAL
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TANGENT
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TEXCOORD0
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_COLOR
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_POSITION_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_NORMAL_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TANGENT_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TEXCOORD0
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_COLOR
        #endif

            #define FEATURES_GRAPH_VERTEX
            /* WARNING: $splice Could not find named fragment 'PassInstancing' */
            #define SHADERPASS SHADERPASS_2D
            /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */

            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

            // --------------------------------------------------
            // Structs and Packing

            struct Attributes
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 positionOS : POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 normalOS : NORMAL;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 tangentOS : TANGENT;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 uv0 : TEXCOORD0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 color : COLOR;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : INSTANCEID_SEMANTIC;
            #endif
            #endif
        };
        struct Varyings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 positionWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 normalWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 tangentWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 texCoord0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 color;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };
        struct SurfaceDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceBiTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 AbsoluteWorldSpacePosition;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 uv0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 VertexColor;
            #endif
        };
        struct VertexDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpacePosition;
            #endif
        };
        struct PackedVaryings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp0 : TEXCOORD0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp1 : TEXCOORD1;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 interp2 : TEXCOORD2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 interp3 : TEXCOORD3;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 interp4 : TEXCOORD4;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };

            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            output.positionCS = input.positionCS;
            output.interp0.xyz =  input.positionWS;
            output.interp1.xyz =  input.normalWS;
            output.interp2.xyzw =  input.tangentWS;
            output.interp3.xyzw =  input.texCoord0;
            output.interp4.xyzw =  input.color;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.positionWS = input.interp0.xyz;
            output.normalWS = input.interp1.xyz;
            output.tangentWS = input.interp2.xyzw;
            output.texCoord0 = input.interp3.xyzw;
            output.color = input.interp4.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        #endif

            // --------------------------------------------------
            // Graph

            // Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float _AlphaCutoff;
        float4 _BaseColor;
        float4 _BaseColorMap_TexelSize;
        float _BaseUsePlanarUV;
        float4 _BaseTilingOffset;
        float4 _BaseNormalMap_TexelSize;
        float _BaseNormalScale;
        float4 _BaseMaskMap_TexelSize;
        float _BaseMetallic;
        float _BaseAORemapMin;
        float _BaseAORemapMax;
        float _BaseSmoothnessRemapMin;
        float _BaseSmoothnessRemapMax;
        float4 _LayerMask_TexelSize;
        float _Invert_Layer_Mask;
        float _Height_Transition;
        float _HeightMin;
        float _HeightMax;
        float _HeightOffset;
        float _HeightMin2;
        float _HeightMax2;
        float _HeightOffset2;
        float IgnoreBase2Alpha;
        float4 _Base2Color;
        float4 _Base2ColorMap_TexelSize;
        float4 _Base2TilingOffset;
        float _Base2UsePlanarUV;
        float4 _Base2NormalMap_TexelSize;
        float _Base2NormalScale;
        float4 _Base2MaskMap_TexelSize;
        float _Base2Metallic;
        float _Base2SmoothnessRemapMin;
        float _Base2SmoothnessRemapMax;
        float _Base2AORemapMin;
        float _Base2AORemapMax;
        float4 _CoverMaskA_TexelSize;
        float _CoverMaskPower;
        float _Cover_Amount;
        float _Cover_Amount_Grow_Speed;
        float _Cover_Max_Angle;
        float _Cover_Min_Height;
        float _Cover_Min_Height_Blending;
        float4 _CoverBaseColor;
        float4 _CoverBaseColorMap_TexelSize;
        float4 _CoverTilingOffset;
        float _CoverUsePlanarUV;
        float4 _CoverNormalMap_TexelSize;
        float _CoverNormalScale;
        float _CoverNormalBlendHardness;
        float _CoverHardness;
        float _CoverHeightMapMin;
        float _CoverHeightMapMax;
        float _CoverHeightMapOffset;
        float4 _CoverMaskMap_TexelSize;
        float _CoverMetallic;
        float _CoverAORemapMin;
        float _CoverAORemapMax;
        float _CoverSmoothnessRemapMin;
        float _CoverSmoothnessRemapMax;
        CBUFFER_END

        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_BaseColorMap);
        SAMPLER(sampler_BaseColorMap);
        TEXTURE2D(_BaseNormalMap);
        SAMPLER(sampler_BaseNormalMap);
        TEXTURE2D(_BaseMaskMap);
        SAMPLER(sampler_BaseMaskMap);
        TEXTURE2D(_LayerMask);
        SAMPLER(sampler_LayerMask);
        TEXTURE2D(_Base2ColorMap);
        SAMPLER(sampler_Base2ColorMap);
        TEXTURE2D(_Base2NormalMap);
        SAMPLER(sampler_Base2NormalMap);
        TEXTURE2D(_Base2MaskMap);
        SAMPLER(sampler_Base2MaskMap);
        TEXTURE2D(_CoverMaskA);
        SAMPLER(sampler_CoverMaskA);
        TEXTURE2D(_CoverBaseColorMap);
        SAMPLER(sampler_CoverBaseColorMap);
        TEXTURE2D(_CoverNormalMap);
        SAMPLER(sampler_CoverNormalMap);
        TEXTURE2D(_CoverMaskMap);
        SAMPLER(sampler_CoverMaskMap);

            // Graph Functions
            
        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }

        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }

        void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }

        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }

        void Unity_Branch_float2(float Predicate, float2 True, float2 False, out float2 Out)
        {
            Out = Predicate ? True : False;
        }

        struct Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6
        {
            float3 AbsoluteWorldSpacePosition;
            half4 uv0;
        };

        void SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(UnityTexture2D Texture2D_80A3D28F, float4 Vector4_2EBA7A3B, float Boolean_7ABB9909, Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 IN, out float4 XZ_2)
        {
            UnityTexture2D _Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0 = Texture2D_80A3D28F;
            float _Property_30834f691775a0898a45b1c868520436_Out_0 = Boolean_7ABB9909;
            float _Split_89ed63cb625cb3878c183d0b71c03400_R_1 = IN.AbsoluteWorldSpacePosition[0];
            float _Split_89ed63cb625cb3878c183d0b71c03400_G_2 = IN.AbsoluteWorldSpacePosition[1];
            float _Split_89ed63cb625cb3878c183d0b71c03400_B_3 = IN.AbsoluteWorldSpacePosition[2];
            float _Split_89ed63cb625cb3878c183d0b71c03400_A_4 = 0;
            float4 _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4;
            float3 _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5;
            float2 _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6;
            Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_B_3, 0, 0, _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5, _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6);
            float4 _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0 = Vector4_2EBA7A3B;
            float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[0];
            float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_G_2 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[1];
            float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_B_3 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[2];
            float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_A_4 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[3];
            float _Divide_e64179199923c58289b6aa94ea6c9178_Out_2;
            Unity_Divide_float(1, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1, _Divide_e64179199923c58289b6aa94ea6c9178_Out_2);
            float4 _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2;
            Unity_Multiply_float(_Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, (_Divide_e64179199923c58289b6aa94ea6c9178_Out_2.xxxx), _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2);
            float2 _Vector2_16c15d3bbdd14b85bd48e3a6cb318af7_Out_0 = float2(_Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_G_2);
            float2 _Vector2_f8d75f54e7705083bbec539a60185577_Out_0 = float2(_Split_2f0f52f6ef8c0e81af0da6476402bc1f_B_3, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_A_4);
            float2 _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_16c15d3bbdd14b85bd48e3a6cb318af7_Out_0, _Vector2_f8d75f54e7705083bbec539a60185577_Out_0, _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3);
            float2 _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3;
            Unity_Branch_float2(_Property_30834f691775a0898a45b1c868520436_Out_0, (_Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2.xy), _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3, _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3);
            float4 _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0 = SAMPLE_TEXTURE2D(_Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0.tex, _Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0.samplerstate, _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3);
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.r;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.g;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.b;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_A_7 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.a;
            XZ_2 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0;
        }

        void Unity_Add_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A + B;
        }

        void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
        {
            Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
        }

        void Unity_OneMinus_float(float In, out float Out)
        {
            Out = 1 - In;
        }

        void Unity_Branch_float(float Predicate, float True, float False, out float Out)
        {
            Out = Predicate ? True : False;
        }

        void Unity_Multiply_float(float A, float B, out float Out)
        {
            Out = A * B;
        }

        void Unity_Maximum_float(float A, float B, out float Out)
        {
            Out = max(A, B);
        }

        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }

        void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }

        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }

        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }

        void Unity_Divide_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A / B;
        }

        struct Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135
        {
        };

        void SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135(float3 Vector3_88EEBB5E, float Vector1_DA0A37FA, float3 Vector3_79AA92F, float Vector1_F7E83F1E, float Vector1_1C9222A6, Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 IN, out float3 OutVector4_1)
        {
            float3 _Property_dd1c841a04c03f8c85e7b00eb025ecda_Out_0 = Vector3_88EEBB5E;
            float _Property_14119cc7eaf4128f991283d47cf72d85_Out_0 = Vector1_DA0A37FA;
            float _Property_48af0ad45e3f7f82932b938695d21391_Out_0 = Vector1_DA0A37FA;
            float _Property_8a30b3ca12ff518fa473ccd686c7d503_Out_0 = Vector1_F7E83F1E;
            float _Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2;
            Unity_Maximum_float(_Property_48af0ad45e3f7f82932b938695d21391_Out_0, _Property_8a30b3ca12ff518fa473ccd686c7d503_Out_0, _Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2);
            float _Property_ee8d5fc69475d181be60c57e04ea8708_Out_0 = Vector1_1C9222A6;
            float _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2;
            Unity_Subtract_float(_Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2, _Property_ee8d5fc69475d181be60c57e04ea8708_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2);
            float _Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2;
            Unity_Subtract_float(_Property_14119cc7eaf4128f991283d47cf72d85_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2, _Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2);
            float _Maximum_d02e48d92038448cb0345e5cf3779071_Out_2;
            Unity_Maximum_float(_Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2, 0, _Maximum_d02e48d92038448cb0345e5cf3779071_Out_2);
            float3 _Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2;
            Unity_Multiply_float(_Property_dd1c841a04c03f8c85e7b00eb025ecda_Out_0, (_Maximum_d02e48d92038448cb0345e5cf3779071_Out_2.xxx), _Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2);
            float3 _Property_c7292b3b08585f8c8670172b9a220bf0_Out_0 = Vector3_79AA92F;
            float _Property_5e920479576fad83ba1947728dcceab4_Out_0 = Vector1_F7E83F1E;
            float _Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2;
            Unity_Subtract_float(_Property_5e920479576fad83ba1947728dcceab4_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2, _Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2);
            float _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2;
            Unity_Maximum_float(_Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2, 0, _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2);
            float3 _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2;
            Unity_Multiply_float(_Property_c7292b3b08585f8c8670172b9a220bf0_Out_0, (_Maximum_216777d30802328eab607c8fe68ba3a1_Out_2.xxx), _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2);
            float3 _Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2;
            Unity_Add_float3(_Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2, _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2, _Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2);
            float _Add_356384b52728f583bd6e694bc1fc3738_Out_2;
            Unity_Add_float(_Maximum_d02e48d92038448cb0345e5cf3779071_Out_2, _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2, _Add_356384b52728f583bd6e694bc1fc3738_Out_2);
            float _Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2;
            Unity_Maximum_float(_Add_356384b52728f583bd6e694bc1fc3738_Out_2, 1E-05, _Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2);
            float3 _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2;
            Unity_Divide_float3(_Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2, (_Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2.xxx), _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2);
            OutVector4_1 = _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2;
        }

        void Unity_Clamp_float(float In, float Min, float Max, out float Out)
        {
            Out = clamp(In, Min, Max);
        }

        void Unity_Sign_float3(float3 In, out float3 Out)
        {
            Out = sign(In);
        }

        void Unity_Multiply_float(float2 A, float2 B, out float2 Out)
        {
            Out = A * B;
        }

        void Unity_Normalize_float3(float3 In, out float3 Out)
        {
            Out = normalize(In);
        }

        void Unity_Branch_float3(float Predicate, float3 True, float3 False, out float3 Out)
        {
            Out = Predicate ? True : False;
        }

        struct Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8
        {
            float3 WorldSpaceNormal;
            float3 WorldSpaceTangent;
            float3 WorldSpaceBiTangent;
            float3 AbsoluteWorldSpacePosition;
            half4 uv0;
        };

        void SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(UnityTexture2D Texture2D_80A3D28F, float4 Vector4_82674548, float Boolean_9FF42DF6, Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 IN, out float4 XZ_2)
        {
            float _Property_1ef12cf3201a938993fe6a7951b0e754_Out_0 = Boolean_9FF42DF6;
            UnityTexture2D _Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0 = Texture2D_80A3D28F;
            float _Split_89ed63cb625cb3878c183d0b71c03400_R_1 = IN.AbsoluteWorldSpacePosition[0];
            float _Split_89ed63cb625cb3878c183d0b71c03400_G_2 = IN.AbsoluteWorldSpacePosition[1];
            float _Split_89ed63cb625cb3878c183d0b71c03400_B_3 = IN.AbsoluteWorldSpacePosition[2];
            float _Split_89ed63cb625cb3878c183d0b71c03400_A_4 = 0;
            float4 _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4;
            float3 _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5;
            float2 _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6;
            Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_B_3, 0, 0, _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5, _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6);
            float4 _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0 = Vector4_82674548;
            float _Split_a2e12fa5931da084b2949343a539dfd8_R_1 = _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0[0];
            float _Split_a2e12fa5931da084b2949343a539dfd8_G_2 = _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0[1];
            float _Split_a2e12fa5931da084b2949343a539dfd8_B_3 = _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0[2];
            float _Split_a2e12fa5931da084b2949343a539dfd8_A_4 = _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0[3];
            float _Divide_c36b770dfaa0bb8f85ab27da5fd794f0_Out_2;
            Unity_Divide_float(1, _Split_a2e12fa5931da084b2949343a539dfd8_R_1, _Divide_c36b770dfaa0bb8f85ab27da5fd794f0_Out_2);
            float4 _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2;
            Unity_Multiply_float(_Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, (_Divide_c36b770dfaa0bb8f85ab27da5fd794f0_Out_2.xxxx), _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2);
            float2 _Vector2_6845d21872714d889783b0cb707df3e9_Out_0 = float2(_Split_a2e12fa5931da084b2949343a539dfd8_R_1, _Split_a2e12fa5931da084b2949343a539dfd8_G_2);
            float2 _Vector2_e2e2263627c6098e96a5b5d29350ad03_Out_0 = float2(_Split_a2e12fa5931da084b2949343a539dfd8_B_3, _Split_a2e12fa5931da084b2949343a539dfd8_A_4);
            float2 _TilingAndOffset_17582d056c0b8a8dab1017d37497fe59_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_6845d21872714d889783b0cb707df3e9_Out_0, _Vector2_e2e2263627c6098e96a5b5d29350ad03_Out_0, _TilingAndOffset_17582d056c0b8a8dab1017d37497fe59_Out_3);
            float2 _Branch_1e152f3aac57448f8518bf2852c000c3_Out_3;
            Unity_Branch_float2(_Property_1ef12cf3201a938993fe6a7951b0e754_Out_0, (_Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2.xy), _TilingAndOffset_17582d056c0b8a8dab1017d37497fe59_Out_3, _Branch_1e152f3aac57448f8518bf2852c000c3_Out_3);
            float4 _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0 = SAMPLE_TEXTURE2D(_Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0.tex, _Property_3e01b4d2fc68d48ba3acbba9d5881e59_Out_0.samplerstate, _Branch_1e152f3aac57448f8518bf2852c000c3_Out_3);
            _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0);
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.r;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.g;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.b;
            float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_A_7 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.a;
            float2 _Vector2_ad6bd100e273d78fa409a30a77bfa2cc_Out_0 = float2(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4, _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5);
            float3 _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1;
            Unity_Sign_float3(IN.WorldSpaceNormal, _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1);
            float _Split_6299d4ddcc4c74828aea40a46fdb896e_R_1 = _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1[0];
            float _Split_6299d4ddcc4c74828aea40a46fdb896e_G_2 = _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1[1];
            float _Split_6299d4ddcc4c74828aea40a46fdb896e_B_3 = _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1[2];
            float _Split_6299d4ddcc4c74828aea40a46fdb896e_A_4 = 0;
            float2 _Vector2_b76cb1842101e58b9e636d49b075c612_Out_0 = float2(_Split_6299d4ddcc4c74828aea40a46fdb896e_G_2, 1);
            float2 _Multiply_31e8db88ee20c985a9850d1a58f3282b_Out_2;
            Unity_Multiply_float(_Vector2_ad6bd100e273d78fa409a30a77bfa2cc_Out_0, _Vector2_b76cb1842101e58b9e636d49b075c612_Out_0, _Multiply_31e8db88ee20c985a9850d1a58f3282b_Out_2);
            float _Split_5ed44bf2eca0868f81eb18100f49d1fa_R_1 = IN.WorldSpaceNormal[0];
            float _Split_5ed44bf2eca0868f81eb18100f49d1fa_G_2 = IN.WorldSpaceNormal[1];
            float _Split_5ed44bf2eca0868f81eb18100f49d1fa_B_3 = IN.WorldSpaceNormal[2];
            float _Split_5ed44bf2eca0868f81eb18100f49d1fa_A_4 = 0;
            float2 _Vector2_70e5837843f28b8b9d64cada3697bd5a_Out_0 = float2(_Split_5ed44bf2eca0868f81eb18100f49d1fa_R_1, _Split_5ed44bf2eca0868f81eb18100f49d1fa_B_3);
            float2 _Add_1145b2f896593d80aa864a34e6702562_Out_2;
            Unity_Add_float2(_Multiply_31e8db88ee20c985a9850d1a58f3282b_Out_2, _Vector2_70e5837843f28b8b9d64cada3697bd5a_Out_0, _Add_1145b2f896593d80aa864a34e6702562_Out_2);
            float _Split_2bc77ca2d17bd78cb2383770ce50b179_R_1 = _Add_1145b2f896593d80aa864a34e6702562_Out_2[0];
            float _Split_2bc77ca2d17bd78cb2383770ce50b179_G_2 = _Add_1145b2f896593d80aa864a34e6702562_Out_2[1];
            float _Split_2bc77ca2d17bd78cb2383770ce50b179_B_3 = 0;
            float _Split_2bc77ca2d17bd78cb2383770ce50b179_A_4 = 0;
            float _Multiply_ab12aea87465a78eaf7fc66c2598d266_Out_2;
            Unity_Multiply_float(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6, _Split_5ed44bf2eca0868f81eb18100f49d1fa_G_2, _Multiply_ab12aea87465a78eaf7fc66c2598d266_Out_2);
            float3 _Vector3_433840b555db308b97e9b14b6a957195_Out_0 = float3(_Split_2bc77ca2d17bd78cb2383770ce50b179_R_1, _Multiply_ab12aea87465a78eaf7fc66c2598d266_Out_2, _Split_2bc77ca2d17bd78cb2383770ce50b179_G_2);
            float3x3 Transform_c7914cc45a011c89b3f53c55afb51673_tangentTransform_World = float3x3(IN.WorldSpaceTangent, IN.WorldSpaceBiTangent, IN.WorldSpaceNormal);
            float3 _Transform_c7914cc45a011c89b3f53c55afb51673_Out_1 = TransformWorldToTangent(_Vector3_433840b555db308b97e9b14b6a957195_Out_0.xyz, Transform_c7914cc45a011c89b3f53c55afb51673_tangentTransform_World);
            float3 _Normalize_09bf8a2bd0a4d38e8b97d5c674f79b44_Out_1;
            Unity_Normalize_float3(_Transform_c7914cc45a011c89b3f53c55afb51673_Out_1, _Normalize_09bf8a2bd0a4d38e8b97d5c674f79b44_Out_1);
            float3 _Branch_9eadf909a90f2f80880f8c56ecc2a91f_Out_3;
            Unity_Branch_float3(_Property_1ef12cf3201a938993fe6a7951b0e754_Out_0, _Normalize_09bf8a2bd0a4d38e8b97d5c674f79b44_Out_1, (_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.xyz), _Branch_9eadf909a90f2f80880f8c56ecc2a91f_Out_3);
            XZ_2 = (float4(_Branch_9eadf909a90f2f80880f8c56ecc2a91f_Out_3, 1.0));
        }

        void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
        {
            Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
        }

        void Unity_Absolute_float(float In, out float Out)
        {
            Out = abs(In);
        }

        void Unity_Power_float(float A, float B, out float Out)
        {
            Out = pow(A, B);
        }

        void Unity_Saturate_float(float In, out float Out)
        {
            Out = saturate(In);
        }

        void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
        {
            Out = lerp(A, B, T);
        }

        void Unity_Lerp_float(float A, float B, float T, out float Out)
        {
            Out = lerp(A, B, T);
        }

            // Graph Vertex
            struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };

        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }

            // Graph Pixel
            struct SurfaceDescription
        {
            float3 BaseColor;
            float Alpha;
            float AlphaClipThreshold;
        };

        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_07d75b1d2628da808a2efb93a1d6219e_Out_0 = UnityBuildTexture2DStructNoScale(_BaseColorMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0 = _BaseTilingOffset;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_7f998178363b4188ba2f07298ef869c1_Out_0 = _BaseUsePlanarUV;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e;
            _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e.uv0 = IN.uv0;
            float4 _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2;
            SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(_Property_07d75b1d2628da808a2efb93a1d6219e_Out_0, _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0, _Property_7f998178363b4188ba2f07298ef869c1_Out_0, _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e, _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_b83097c58639858680bf43881a95b0af_Out_0 = _BaseColor;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2;
            Unity_Multiply_float(_PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2, _Property_b83097c58639858680bf43881a95b0af_Out_0, _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_1e449ff9f8e8ec828507233e8240eb11_Out_0 = UnityBuildTexture2DStructNoScale(_BaseMaskMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_4245c3b264047180b5c90a697d6cb278;
            _PlanarNM_4245c3b264047180b5c90a697d6cb278.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNM_4245c3b264047180b5c90a697d6cb278.uv0 = IN.uv0;
            float4 _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2;
            SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(_Property_1e449ff9f8e8ec828507233e8240eb11_Out_0, _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0, _Property_7f998178363b4188ba2f07298ef869c1_Out_0, _PlanarNM_4245c3b264047180b5c90a697d6cb278, _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_91a015dea8acd38b904ba0935328a5bc_R_1 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[0];
            float _Split_91a015dea8acd38b904ba0935328a5bc_G_2 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[1];
            float _Split_91a015dea8acd38b904ba0935328a5bc_B_3 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[2];
            float _Split_91a015dea8acd38b904ba0935328a5bc_A_4 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_fbcff1469ebf488394a8a89ddaf0eb2a_Out_0 = _HeightMin;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_9df7a44c8225168683743ac60c0c3c34_Out_0 = _HeightMax;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_9b1e95888c28bc8893f28c02b87fa448_Out_0 = float2(_Property_fbcff1469ebf488394a8a89ddaf0eb2a_Out_0, _Property_9df7a44c8225168683743ac60c0c3c34_Out_0);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_29ca14fd0b712983a38d63d2dd326e96_Out_0 = _HeightOffset;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Add_cb503f8a09720d84bb03cbd89e37b80c_Out_2;
            Unity_Add_float2(_Vector2_9b1e95888c28bc8893f28c02b87fa448_Out_0, (_Property_29ca14fd0b712983a38d63d2dd326e96_Out_0.xx), _Add_cb503f8a09720d84bb03cbd89e37b80c_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3;
            Unity_Remap_float(_Split_91a015dea8acd38b904ba0935328a5bc_B_3, float2 (0, 1), _Add_cb503f8a09720d84bb03cbd89e37b80c_Out_2, _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_ba3a5f4cba7d0a8fa288ffc8267d6c0e_Out_0 = UnityBuildTexture2DStructNoScale(_Base2ColorMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_86a4657df480d48e8d3ad3b036731380_Out_0 = _Base2TilingOffset;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0 = _Base2UsePlanarUV;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4;
            _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4.uv0 = IN.uv0;
            float4 _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4_XZ_2;
            SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(_Property_ba3a5f4cba7d0a8fa288ffc8267d6c0e_Out_0, _Property_86a4657df480d48e8d3ad3b036731380_Out_0, _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0, _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4, _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_3561b11b899bda8e855826445cf628aa_Out_0 = _Base2Color;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2;
            Unity_Multiply_float(_PlanarNM_5aeab444ca6fd78ea56a01215880a5a4_XZ_2, _Property_3561b11b899bda8e855826445cf628aa_Out_0, _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_c34b73d933404283983f9c8bdb5365d3_R_1 = IN.VertexColor[0];
            float _Split_c34b73d933404283983f9c8bdb5365d3_G_2 = IN.VertexColor[1];
            float _Split_c34b73d933404283983f9c8bdb5365d3_B_3 = IN.VertexColor[2];
            float _Split_c34b73d933404283983f9c8bdb5365d3_A_4 = IN.VertexColor[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_df2df7bb5cfc3381beee7ec454da7542_Out_0 = _Invert_Layer_Mask;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_c7b1e2df9f9b0e8eace9b2274924e69c_Out_0 = UnityBuildTexture2DStructNoScale(_LayerMask);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0 = SAMPLE_TEXTURE2D(_Property_c7b1e2df9f9b0e8eace9b2274924e69c_Out_0.tex, _Property_c7b1e2df9f9b0e8eace9b2274924e69c_Out_0.samplerstate, IN.uv0.xy);
            float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.r;
            float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_G_5 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.g;
            float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_B_6 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.b;
            float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_A_7 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1;
            Unity_OneMinus_float(_SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4, _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Branch_af0c5e511241ce8eae748ae487df50fa_Out_3;
            Unity_Branch_float(_Property_df2df7bb5cfc3381beee7ec454da7542_Out_0, _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1, _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4, _Branch_af0c5e511241ce8eae748ae487df50fa_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_de4f6eb48a629285a664dad7fb06438f_Out_0 = UnityBuildTexture2DStructNoScale(_Base2MaskMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_d5657f470f05ef839e4c257a20ace8cb;
            _PlanarNM_d5657f470f05ef839e4c257a20ace8cb.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNM_d5657f470f05ef839e4c257a20ace8cb.uv0 = IN.uv0;
            float4 _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2;
            SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(_Property_de4f6eb48a629285a664dad7fb06438f_Out_0, _Property_86a4657df480d48e8d3ad3b036731380_Out_0, _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0, _PlanarNM_d5657f470f05ef839e4c257a20ace8cb, _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_83ec66b648ab6c84848b42686c256cd7_R_1 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[0];
            float _Split_83ec66b648ab6c84848b42686c256cd7_G_2 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[1];
            float _Split_83ec66b648ab6c84848b42686c256cd7_B_3 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[2];
            float _Split_83ec66b648ab6c84848b42686c256cd7_A_4 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_ce1750e5c69e97818667b412fc3f9f2c_Out_0 = _HeightMin2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_8e0f2ea54d8ede89bbabdf31a9bafd57_Out_0 = _HeightMax2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_fb6c6dd7e70e768ba686e8e94153bb96_Out_0 = float2(_Property_ce1750e5c69e97818667b412fc3f9f2c_Out_0, _Property_8e0f2ea54d8ede89bbabdf31a9bafd57_Out_0);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_151ae2702b614585af2000f0a812960f_Out_0 = _HeightOffset2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2;
            Unity_Add_float2(_Vector2_fb6c6dd7e70e768ba686e8e94153bb96_Out_0, (_Property_151ae2702b614585af2000f0a812960f_Out_0.xx), _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3;
            Unity_Remap_float(_Split_83ec66b648ab6c84848b42686c256cd7_B_3, float2 (0, 1), _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2, _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2;
            Unity_Multiply_float(_Branch_af0c5e511241ce8eae748ae487df50fa_Out_3, _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3, _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2;
            Unity_Multiply_float(_Split_c34b73d933404283983f9c8bdb5365d3_R_1, _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2, _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_818c8af4b930138e81034c886614171d_Out_0 = _Height_Transition;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 _HeightBlend_7501025b3a60738a9a9d362e35a9ab48;
            float3 _HeightBlend_7501025b3a60738a9a9d362e35a9ab48_OutVector4_1;
            SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135((_Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2.xyz), _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3, (_Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2.xyz), _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2, _Property_818c8af4b930138e81034c886614171d_Out_0, _HeightBlend_7501025b3a60738a9a9d362e35a9ab48, _HeightBlend_7501025b3a60738a9a9d362e35a9ab48_OutVector4_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_c0ebdab0f71ace8aabaa865fd7293599_Out_0 = UnityBuildTexture2DStructNoScale(_CoverBaseColorMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_822489d2e6d3e08590c64f085ffd9b2e_Out_0 = _CoverTilingOffset;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_2ae4a163bd21d98789af282d6e469175_Out_0 = _CoverUsePlanarUV;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_8bb420494d19b28e9ccdff489802dc81;
            _PlanarNM_8bb420494d19b28e9ccdff489802dc81.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNM_8bb420494d19b28e9ccdff489802dc81.uv0 = IN.uv0;
            float4 _PlanarNM_8bb420494d19b28e9ccdff489802dc81_XZ_2;
            SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(_Property_c0ebdab0f71ace8aabaa865fd7293599_Out_0, _Property_822489d2e6d3e08590c64f085ffd9b2e_Out_0, _Property_2ae4a163bd21d98789af282d6e469175_Out_0, _PlanarNM_8bb420494d19b28e9ccdff489802dc81, _PlanarNM_8bb420494d19b28e9ccdff489802dc81_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_55e7941fa7ac5f8387aa9bb633b08883_Out_0 = _CoverBaseColor;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Multiply_a38ba695a2660c8691763f0bd7fe159c_Out_2;
            Unity_Multiply_float(_PlanarNM_8bb420494d19b28e9ccdff489802dc81_XZ_2, _Property_55e7941fa7ac5f8387aa9bb633b08883_Out_0, _Multiply_a38ba695a2660c8691763f0bd7fe159c_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_c0d223db25424a8ab0cee2de2bbf58ce_Out_0 = UnityBuildTexture2DStructNoScale(_CoverMaskA);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _UV_5352c8dd0add178ba83a5421c2c0b3f0_Out_0 = IN.uv0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _SampleTexture2D_024ba490c015248988a12a9d670014ea_RGBA_0 = SAMPLE_TEXTURE2D(_Property_c0d223db25424a8ab0cee2de2bbf58ce_Out_0.tex, _Property_c0d223db25424a8ab0cee2de2bbf58ce_Out_0.samplerstate, (_UV_5352c8dd0add178ba83a5421c2c0b3f0_Out_0.xy));
            float _SampleTexture2D_024ba490c015248988a12a9d670014ea_R_4 = _SampleTexture2D_024ba490c015248988a12a9d670014ea_RGBA_0.r;
            float _SampleTexture2D_024ba490c015248988a12a9d670014ea_G_5 = _SampleTexture2D_024ba490c015248988a12a9d670014ea_RGBA_0.g;
            float _SampleTexture2D_024ba490c015248988a12a9d670014ea_B_6 = _SampleTexture2D_024ba490c015248988a12a9d670014ea_RGBA_0.b;
            float _SampleTexture2D_024ba490c015248988a12a9d670014ea_A_7 = _SampleTexture2D_024ba490c015248988a12a9d670014ea_RGBA_0.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_b80e7b96604b7c82bbf9bff4981fad76_Out_0 = _CoverMaskPower;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_abe410d256783480b1b58468bf78a882_Out_2;
            Unity_Multiply_float(_SampleTexture2D_024ba490c015248988a12a9d670014ea_A_7, _Property_b80e7b96604b7c82bbf9bff4981fad76_Out_0, _Multiply_abe410d256783480b1b58468bf78a882_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_a78f6f28770afd869adb9d12cd47370b_Out_3;
            Unity_Clamp_float(_Multiply_abe410d256783480b1b58468bf78a882_Out_2, 0, 1, _Clamp_a78f6f28770afd869adb9d12cd47370b_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_7c7049e15fdff386b535790d8666f609_Out_0 = UnityBuildTexture2DStructNoScale(_BaseNormalMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8;
            _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.WorldSpaceNormal = IN.WorldSpaceNormal;
            _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.WorldSpaceTangent = IN.WorldSpaceTangent;
            _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
            _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.uv0 = IN.uv0;
            float4 _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8_XZ_2;
            SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(_Property_7c7049e15fdff386b535790d8666f609_Out_0, _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0, _Property_7f998178363b4188ba2f07298ef869c1_Out_0, _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8, _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_d4b0759cf4647e81be065ec1465ce2b4_Out_0 = _BaseNormalScale;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _NormalStrength_f66a9108ea294886acc61513b41cc5e4_Out_2;
            Unity_NormalStrength_float((_PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8_XZ_2.xyz), _Property_d4b0759cf4647e81be065ec1465ce2b4_Out_0, _NormalStrength_f66a9108ea294886acc61513b41cc5e4_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_fa9f7890b20ad481a92543c04b237bde_Out_0 = UnityBuildTexture2DStructNoScale(_Base2NormalMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf;
            _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.WorldSpaceNormal = IN.WorldSpaceNormal;
            _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.WorldSpaceTangent = IN.WorldSpaceTangent;
            _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
            _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.uv0 = IN.uv0;
            float4 _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf_XZ_2;
            SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(_Property_fa9f7890b20ad481a92543c04b237bde_Out_0, _Property_86a4657df480d48e8d3ad3b036731380_Out_0, _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0, _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf, _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_8c31443b776727819a663c7ddce79064_Out_0 = _Base2NormalScale;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _NormalStrength_0fb86880ab8e368dac6d01b830e20ed8_Out_2;
            Unity_NormalStrength_float((_PlanarNMn_d7b3ec528088a085a5102e025a1b45cf_XZ_2.xyz), _Property_8c31443b776727819a663c7ddce79064_Out_0, _NormalStrength_0fb86880ab8e368dac6d01b830e20ed8_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 _HeightBlend_7c09d97625efce898e21b66cd039be8b;
            float3 _HeightBlend_7c09d97625efce898e21b66cd039be8b_OutVector4_1;
            SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135(_NormalStrength_f66a9108ea294886acc61513b41cc5e4_Out_2, _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3, _NormalStrength_0fb86880ab8e368dac6d01b830e20ed8_Out_2, _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2, _Property_818c8af4b930138e81034c886614171d_Out_0, _HeightBlend_7c09d97625efce898e21b66cd039be8b, _HeightBlend_7c09d97625efce898e21b66cd039be8b_OutVector4_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_65f7dd6fe6c29b83913af586c597a1ef_Out_0 = UnityBuildTexture2DStructNoScale(_CoverNormalMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3;
            _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3.WorldSpaceNormal = IN.WorldSpaceNormal;
            _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3.WorldSpaceTangent = IN.WorldSpaceTangent;
            _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
            _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3.uv0 = IN.uv0;
            float4 _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3_XZ_2;
            SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(_Property_65f7dd6fe6c29b83913af586c597a1ef_Out_0, _Property_822489d2e6d3e08590c64f085ffd9b2e_Out_0, _Property_2ae4a163bd21d98789af282d6e469175_Out_0, _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3, _PlanarNMn_248bc5b7421d3f828d166902c73ca6c3_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_19f92cae42737480a95820c51d4ba124_Out_0 = _CoverNormalBlendHardness;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _NormalStrength_2c3488591b8345869feb25a3dee06c3f_Out_2;
            Unity_NormalStrength_float((_PlanarNMn_248bc5b7421d3f828d166902c73ca6c3_XZ_2.xyz), _Property_19f92cae42737480a95820c51d4ba124_Out_0, _NormalStrength_2c3488591b8345869feb25a3dee06c3f_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_96bfe9cb80ad308385c191d094b3d071_R_1 = IN.WorldSpaceNormal[0];
            float _Split_96bfe9cb80ad308385c191d094b3d071_G_2 = IN.WorldSpaceNormal[1];
            float _Split_96bfe9cb80ad308385c191d094b3d071_B_3 = IN.WorldSpaceNormal[2];
            float _Split_96bfe9cb80ad308385c191d094b3d071_A_4 = 0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_0dd796aae8cd9f878bef13ceac4fe3ec_Out_0 = _Cover_Amount;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_67285cdc688aa38d83f62d5bb095d597_Out_0 = _Cover_Amount_Grow_Speed;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Subtract_fcefec675e7536888eccf5574d921972_Out_2;
            Unity_Subtract_float(4, _Property_67285cdc688aa38d83f62d5bb095d597_Out_0, _Subtract_fcefec675e7536888eccf5574d921972_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Divide_1e25465528e612839a4ce1faedd89e7d_Out_2;
            Unity_Divide_float(_Property_0dd796aae8cd9f878bef13ceac4fe3ec_Out_0, _Subtract_fcefec675e7536888eccf5574d921972_Out_2, _Divide_1e25465528e612839a4ce1faedd89e7d_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Absolute_d20b810ffdec828ab74dd6692d82f01b_Out_1;
            Unity_Absolute_float(_Divide_1e25465528e612839a4ce1faedd89e7d_Out_2, _Absolute_d20b810ffdec828ab74dd6692d82f01b_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Power_181fbf47cfdb258da1fe0b72a450986f_Out_2;
            Unity_Power_float(_Absolute_d20b810ffdec828ab74dd6692d82f01b_Out_1, _Subtract_fcefec675e7536888eccf5574d921972_Out_2, _Power_181fbf47cfdb258da1fe0b72a450986f_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_11f62dba01f1a38c9e0a9972ccd19246_Out_3;
            Unity_Clamp_float(_Power_181fbf47cfdb258da1fe0b72a450986f_Out_2, 0, 2, _Clamp_11f62dba01f1a38c9e0a9972ccd19246_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_9810f6d76275cd8fbe5e3a02360b98a7_Out_2;
            Unity_Multiply_float(_Split_96bfe9cb80ad308385c191d094b3d071_G_2, _Clamp_11f62dba01f1a38c9e0a9972ccd19246_Out_3, _Multiply_9810f6d76275cd8fbe5e3a02360b98a7_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Saturate_a007c5f214685c87bf6ca3e64c06b488_Out_1;
            Unity_Saturate_float(_Multiply_9810f6d76275cd8fbe5e3a02360b98a7_Out_2, _Saturate_a007c5f214685c87bf6ca3e64c06b488_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_1b2b25b617fc508b9835f0309136fd00_Out_3;
            Unity_Clamp_float(_Split_96bfe9cb80ad308385c191d094b3d071_G_2, 0, 0.9999, _Clamp_1b2b25b617fc508b9835f0309136fd00_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_7b12276ea7a4538db6804507b30a830c_Out_0 = _Cover_Max_Angle;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Divide_54c523ff4b7acb858e9e368fd1e4d34a_Out_2;
            Unity_Divide_float(_Property_7b12276ea7a4538db6804507b30a830c_Out_0, 45, _Divide_54c523ff4b7acb858e9e368fd1e4d34a_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _OneMinus_6cf431985b651e8e9546ae6cb2d4d668_Out_1;
            Unity_OneMinus_float(_Divide_54c523ff4b7acb858e9e368fd1e4d34a_Out_2, _OneMinus_6cf431985b651e8e9546ae6cb2d4d668_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Subtract_4ef7b60aeab8d589bf2d2423737642bc_Out_2;
            Unity_Subtract_float(_Clamp_1b2b25b617fc508b9835f0309136fd00_Out_3, _OneMinus_6cf431985b651e8e9546ae6cb2d4d668_Out_1, _Subtract_4ef7b60aeab8d589bf2d2423737642bc_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_a4b51894ea17818c9a27bb533a2ebe74_Out_3;
            Unity_Clamp_float(_Subtract_4ef7b60aeab8d589bf2d2423737642bc_Out_2, 0, 2, _Clamp_a4b51894ea17818c9a27bb533a2ebe74_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Divide_c4196d4f02190b89ba827ccd4ae8a74d_Out_2;
            Unity_Divide_float(1, _Divide_54c523ff4b7acb858e9e368fd1e4d34a_Out_2, _Divide_c4196d4f02190b89ba827ccd4ae8a74d_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_ffc22433163d1184846ede424b44bcb2_Out_2;
            Unity_Multiply_float(_Clamp_a4b51894ea17818c9a27bb533a2ebe74_Out_3, _Divide_c4196d4f02190b89ba827ccd4ae8a74d_Out_2, _Multiply_ffc22433163d1184846ede424b44bcb2_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Absolute_c2e5757082de5d878d4c023806fb2108_Out_1;
            Unity_Absolute_float(_Multiply_ffc22433163d1184846ede424b44bcb2_Out_2, _Absolute_c2e5757082de5d878d4c023806fb2108_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_849d9f217c95f38c9d49ab251578d8d5_Out_0 = _CoverHardness;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Power_578546d66d69a5829b745ebba1279adf_Out_2;
            Unity_Power_float(_Absolute_c2e5757082de5d878d4c023806fb2108_Out_1, _Property_849d9f217c95f38c9d49ab251578d8d5_Out_0, _Power_578546d66d69a5829b745ebba1279adf_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_34d2d3aff4814e8e83d2894b3512c6c8_Out_0 = _Cover_Min_Height;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _OneMinus_474df64227f004849b34c68fe8df93f2_Out_1;
            Unity_OneMinus_float(_Property_34d2d3aff4814e8e83d2894b3512c6c8_Out_0, _OneMinus_474df64227f004849b34c68fe8df93f2_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_ee4d9dc934b3508397d5a3dece110ab0_R_1 = IN.AbsoluteWorldSpacePosition[0];
            float _Split_ee4d9dc934b3508397d5a3dece110ab0_G_2 = IN.AbsoluteWorldSpacePosition[1];
            float _Split_ee4d9dc934b3508397d5a3dece110ab0_B_3 = IN.AbsoluteWorldSpacePosition[2];
            float _Split_ee4d9dc934b3508397d5a3dece110ab0_A_4 = 0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Add_d6bc513aa82d918ea24e279f4353d971_Out_2;
            Unity_Add_float(_OneMinus_474df64227f004849b34c68fe8df93f2_Out_1, _Split_ee4d9dc934b3508397d5a3dece110ab0_G_2, _Add_d6bc513aa82d918ea24e279f4353d971_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Add_a6a61cb12180108c9e1364b90d2673e2_Out_2;
            Unity_Add_float(_Add_d6bc513aa82d918ea24e279f4353d971_Out_2, 1, _Add_a6a61cb12180108c9e1364b90d2673e2_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_1874fdd00cb9aa839d93ab8536e2414d_Out_3;
            Unity_Clamp_float(_Add_a6a61cb12180108c9e1364b90d2673e2_Out_2, 0, 1, _Clamp_1874fdd00cb9aa839d93ab8536e2414d_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_7b91fd6e21b46c85816c7b681307cbe4_Out_0 = _Cover_Min_Height_Blending;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Add_6dca9453f6a35e8185c4b8e9782db0a9_Out_2;
            Unity_Add_float(_Add_d6bc513aa82d918ea24e279f4353d971_Out_2, _Property_7b91fd6e21b46c85816c7b681307cbe4_Out_0, _Add_6dca9453f6a35e8185c4b8e9782db0a9_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Divide_83415a319ecfba83af914cbc5487b546_Out_2;
            Unity_Divide_float(_Add_6dca9453f6a35e8185c4b8e9782db0a9_Out_2, _Add_d6bc513aa82d918ea24e279f4353d971_Out_2, _Divide_83415a319ecfba83af914cbc5487b546_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _OneMinus_bf150b22fcad5a87b7c825c9c6cf1687_Out_1;
            Unity_OneMinus_float(_Divide_83415a319ecfba83af914cbc5487b546_Out_2, _OneMinus_bf150b22fcad5a87b7c825c9c6cf1687_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Add_86ff9fa850efbe8c80705d8266609dab_Out_2;
            Unity_Add_float(_OneMinus_bf150b22fcad5a87b7c825c9c6cf1687_Out_1, -0.5, _Add_86ff9fa850efbe8c80705d8266609dab_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_906e140f01222d8ba61252ec6ec9d6a4_Out_3;
            Unity_Clamp_float(_Add_86ff9fa850efbe8c80705d8266609dab_Out_2, 0, 1, _Clamp_906e140f01222d8ba61252ec6ec9d6a4_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Add_c1ec5849bf72f585a30b3e11a91ada52_Out_2;
            Unity_Add_float(_Clamp_1874fdd00cb9aa839d93ab8536e2414d_Out_3, _Clamp_906e140f01222d8ba61252ec6ec9d6a4_Out_3, _Add_c1ec5849bf72f585a30b3e11a91ada52_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_17a8a0cf209a038b9e9c7f5681cdd1fb_Out_3;
            Unity_Clamp_float(_Add_c1ec5849bf72f585a30b3e11a91ada52_Out_2, 0, 1, _Clamp_17a8a0cf209a038b9e9c7f5681cdd1fb_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_8c2759ac24a9b289b1e9610cfd161bb0_Out_2;
            Unity_Multiply_float(_Power_578546d66d69a5829b745ebba1279adf_Out_2, _Clamp_17a8a0cf209a038b9e9c7f5681cdd1fb_Out_3, _Multiply_8c2759ac24a9b289b1e9610cfd161bb0_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_1a723f136ec7fa8c957b5d29e03d3051_Out_2;
            Unity_Multiply_float(_Saturate_a007c5f214685c87bf6ca3e64c06b488_Out_1, _Multiply_8c2759ac24a9b289b1e9610cfd161bb0_Out_2, _Multiply_1a723f136ec7fa8c957b5d29e03d3051_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Lerp_d1c72e47b283948584479177786ae8d5_Out_3;
            Unity_Lerp_float3(_HeightBlend_7c09d97625efce898e21b66cd039be8b_OutVector4_1, _NormalStrength_2c3488591b8345869feb25a3dee06c3f_Out_2, (_Multiply_1a723f136ec7fa8c957b5d29e03d3051_Out_2.xxx), _Lerp_d1c72e47b283948584479177786ae8d5_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3x3 Transform_180fb403b53f318db002e8eba7616644_transposeTangent = transpose(float3x3(IN.WorldSpaceTangent, IN.WorldSpaceBiTangent, IN.WorldSpaceNormal));
            float3 _Transform_180fb403b53f318db002e8eba7616644_Out_1 = normalize(mul(Transform_180fb403b53f318db002e8eba7616644_transposeTangent, _Lerp_d1c72e47b283948584479177786ae8d5_Out_3.xyz).xyz);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_c9a2b4fb4f688b8ebfc1436535cd5ba4_R_1 = _Transform_180fb403b53f318db002e8eba7616644_Out_1[0];
            float _Split_c9a2b4fb4f688b8ebfc1436535cd5ba4_G_2 = _Transform_180fb403b53f318db002e8eba7616644_Out_1[1];
            float _Split_c9a2b4fb4f688b8ebfc1436535cd5ba4_B_3 = _Transform_180fb403b53f318db002e8eba7616644_Out_1[2];
            float _Split_c9a2b4fb4f688b8ebfc1436535cd5ba4_A_4 = 0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_4c7631d0688102819e6d388d624855a1_Out_2;
            Unity_Multiply_float(_Split_c9a2b4fb4f688b8ebfc1436535cd5ba4_G_2, _Clamp_11f62dba01f1a38c9e0a9972ccd19246_Out_3, _Multiply_4c7631d0688102819e6d388d624855a1_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_f2887eb409f6bb81ae4caad2b01b17f1_Out_2;
            Unity_Multiply_float(_Clamp_11f62dba01f1a38c9e0a9972ccd19246_Out_3, _Property_849d9f217c95f38c9d49ab251578d8d5_Out_0, _Multiply_f2887eb409f6bb81ae4caad2b01b17f1_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_2e348ed31331e78791b2b3130a009f30_Out_2;
            Unity_Multiply_float(_Multiply_f2887eb409f6bb81ae4caad2b01b17f1_Out_2, _Multiply_8c2759ac24a9b289b1e9610cfd161bb0_Out_2, _Multiply_2e348ed31331e78791b2b3130a009f30_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_622e54e9a77b08839c0954ce5715ad1c_Out_2;
            Unity_Multiply_float(_Multiply_4c7631d0688102819e6d388d624855a1_Out_2, _Multiply_2e348ed31331e78791b2b3130a009f30_Out_2, _Multiply_622e54e9a77b08839c0954ce5715ad1c_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_608db04fab7d768d9a8b5fb9cf0768e1_Out_0 = UnityBuildTexture2DStructNoScale(_CoverMaskMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e;
            _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e.uv0 = IN.uv0;
            float4 _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e_XZ_2;
            SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(_Property_608db04fab7d768d9a8b5fb9cf0768e1_Out_0, _Property_822489d2e6d3e08590c64f085ffd9b2e_Out_0, _Property_2ae4a163bd21d98789af282d6e469175_Out_0, _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e, _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e_XZ_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_86ec1aefda4f9e8e82b79c6195b397b0_R_1 = _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e_XZ_2[0];
            float _Split_86ec1aefda4f9e8e82b79c6195b397b0_G_2 = _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e_XZ_2[1];
            float _Split_86ec1aefda4f9e8e82b79c6195b397b0_B_3 = _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e_XZ_2[2];
            float _Split_86ec1aefda4f9e8e82b79c6195b397b0_A_4 = _PlanarNM_819c993d9b62a28ea640d2bacdc62c6e_XZ_2[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_c9c6897e00458b8f8aa07df49fa519bc_Out_0 = _CoverHeightMapMin;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_ab94650b8edd82828661fe99e3c0e849_Out_0 = _CoverHeightMapMax;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_fe489f7321f6568686816b9eecbc16d1_Out_0 = float2(_Property_c9c6897e00458b8f8aa07df49fa519bc_Out_0, _Property_ab94650b8edd82828661fe99e3c0e849_Out_0);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_c1ab40024cb83b87960e4327efbd997f_Out_0 = _CoverHeightMapOffset;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Add_4a359522fc231c83b55ef23f341b6fb3_Out_2;
            Unity_Add_float2(_Vector2_fe489f7321f6568686816b9eecbc16d1_Out_0, (_Property_c1ab40024cb83b87960e4327efbd997f_Out_0.xx), _Add_4a359522fc231c83b55ef23f341b6fb3_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Remap_5aee5b64d41562858dc7c42d8b748894_Out_3;
            Unity_Remap_float(_Split_86ec1aefda4f9e8e82b79c6195b397b0_B_3, float2 (0, 1), _Add_4a359522fc231c83b55ef23f341b6fb3_Out_2, _Remap_5aee5b64d41562858dc7c42d8b748894_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_f0228e1cfd9c858dbb36367f551733c4_Out_2;
            Unity_Multiply_float(_Multiply_622e54e9a77b08839c0954ce5715ad1c_Out_2, _Remap_5aee5b64d41562858dc7c42d8b748894_Out_3, _Multiply_f0228e1cfd9c858dbb36367f551733c4_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_bb4d60728db93b8a9af9635fa1d69891_Out_2;
            Unity_Multiply_float(_Split_c34b73d933404283983f9c8bdb5365d3_G_2, _Multiply_f0228e1cfd9c858dbb36367f551733c4_Out_2, _Multiply_bb4d60728db93b8a9af9635fa1d69891_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Saturate_9b052a9bb99eff89bb11bdc387a0c2fd_Out_1;
            Unity_Saturate_float(_Multiply_bb4d60728db93b8a9af9635fa1d69891_Out_2, _Saturate_9b052a9bb99eff89bb11bdc387a0c2fd_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_22fb8c1cfd28b687a991e101aa13ff5b_Out_2;
            Unity_Multiply_float(_Clamp_a78f6f28770afd869adb9d12cd47370b_Out_3, _Saturate_9b052a9bb99eff89bb11bdc387a0c2fd_Out_1, _Multiply_22fb8c1cfd28b687a991e101aa13ff5b_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #if defined(_USEDYNAMICCOVERTSTATICMASKF_ON)
            float _UseDynamicCoverTStaticMaskF_20dcbac2f16cf78ebd6fd1debcd7f281_Out_0 = _Multiply_22fb8c1cfd28b687a991e101aa13ff5b_Out_2;
            #else
            float _UseDynamicCoverTStaticMaskF_20dcbac2f16cf78ebd6fd1debcd7f281_Out_0 = _Clamp_a78f6f28770afd869adb9d12cd47370b_Out_3;
            #endif
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Lerp_e5620b57c917728fa1416e2ffce9b0db_Out_3;
            Unity_Lerp_float3(_HeightBlend_7501025b3a60738a9a9d362e35a9ab48_OutVector4_1, (_Multiply_a38ba695a2660c8691763f0bd7fe159c_Out_2.xyz), (_UseDynamicCoverTStaticMaskF_20dcbac2f16cf78ebd6fd1debcd7f281_Out_0.xxx), _Lerp_e5620b57c917728fa1416e2ffce9b0db_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_c7a719bf7da79a8ea38d7311fd844f92_R_1 = _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2[0];
            float _Split_c7a719bf7da79a8ea38d7311fd844f92_G_2 = _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2[1];
            float _Split_c7a719bf7da79a8ea38d7311fd844f92_B_3 = _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2[2];
            float _Split_c7a719bf7da79a8ea38d7311fd844f92_A_4 = _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_7c5dae9b46c9e686b49e58fa996a104a_Out_0 = IgnoreBase2Alpha;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_e9060f5c0433ec889696d3e462f3229b_R_1 = _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2[0];
            float _Split_e9060f5c0433ec889696d3e462f3229b_G_2 = _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2[1];
            float _Split_e9060f5c0433ec889696d3e462f3229b_B_3 = _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2[2];
            float _Split_e9060f5c0433ec889696d3e462f3229b_A_4 = _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Branch_a7d7aece30fd9b8eb456d191fdd37a06_Out_3;
            Unity_Branch_float(_Property_7c5dae9b46c9e686b49e58fa996a104a_Out_0, _Split_c7a719bf7da79a8ea38d7311fd844f92_A_4, _Split_e9060f5c0433ec889696d3e462f3229b_A_4, _Branch_a7d7aece30fd9b8eb456d191fdd37a06_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Lerp_8692ca93f568998fbc97130b6dbc4556_Out_3;
            Unity_Lerp_float(_Split_c7a719bf7da79a8ea38d7311fd844f92_A_4, _Branch_a7d7aece30fd9b8eb456d191fdd37a06_Out_3, _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2, _Lerp_8692ca93f568998fbc97130b6dbc4556_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_0c8b7b55b9f82588ab2dcff09ee7a16d_Out_3;
            Unity_Clamp_float(_Lerp_8692ca93f568998fbc97130b6dbc4556_Out_3, 0, 1, _Clamp_0c8b7b55b9f82588ab2dcff09ee7a16d_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_6333dc4a6348088bb7281602ce6bff5f_Out_2;
            Unity_Multiply_float(_Clamp_0c8b7b55b9f82588ab2dcff09ee7a16d_Out_3, _Split_c34b73d933404283983f9c8bdb5365d3_A_4, _Multiply_6333dc4a6348088bb7281602ce6bff5f_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_9642b8fb7e32b18a91da1888c9bc375b_Out_3;
            Unity_Clamp_float(_Multiply_6333dc4a6348088bb7281602ce6bff5f_Out_2, 0, 1, _Clamp_9642b8fb7e32b18a91da1888c9bc375b_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_8bc98dd454a5508b9864a6ba09772356_Out_0 = _AlphaCutoff;
            #endif
            surface.BaseColor = _Lerp_e5620b57c917728fa1416e2ffce9b0db_Out_3;
            surface.Alpha = _Clamp_9642b8fb7e32b18a91da1888c9bc375b_Out_3;
            surface.AlphaClipThreshold = _Property_8bc98dd454a5508b9864a6ba09772356_Out_0;
            return surface;
        }

            // --------------------------------------------------
            // Build Graph Inputs

            VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceNormal =           input.normalOS;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceTangent =          input.tangentOS.xyz;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpacePosition =         input.positionOS;
        #endif


            return output;
        }
            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 unnormalizedNormalWS = input.normalWS;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        const float renormFactor = 1.0 / length(unnormalizedNormalWS);
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // use bitangent on the fly like in hdrp
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // IMPORTANT! If we ever support Flip on double sided materials ensure bitangent and tangent are NOT flipped.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float crossSign = (input.tangentWS.w > 0.0 ? 1.0 : -1.0) * GetOddNegativeScale();
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 bitang = crossSign * cross(input.normalWS.xyz, input.tangentWS.xyz);
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceNormal =            renormFactor*input.normalWS.xyz;		// we want a unit length Normal Vector node in shader graph
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // to preserve mikktspace compliance we use same scale renormFactor as was used on the normal.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // This is explained in section 2.2 in "surface gradient based bump mapping framework"
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceTangent =           renormFactor*input.tangentWS.xyz;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceBiTangent =         renormFactor*bitang;
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(input.positionWS);
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.uv0 =                         input.texCoord0;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.VertexColor =                 input.color;
        #endif

        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

            return output;
        }

            // --------------------------------------------------
            // Main

            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/PBR2DPass.hlsl"

            ENDHLSL
        }
    }
    CustomEditor "ShaderGraph.PBRMasterGUI"
    FallBack "Hidden/Shader Graph/FallbackError"
}