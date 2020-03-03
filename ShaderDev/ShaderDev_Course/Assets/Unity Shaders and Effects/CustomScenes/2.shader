﻿Shader "Custom/2"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0
		_NormalMap("Normal Map", 2D) = "bump" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard fullforwardshadows

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;
		sampler2D _NormalMap;

        struct Input
        {
            float2 uv_MainTex;
			float2 uv_NormalTex;
        };

        half _Glossiness;
        half _Metallic;
        fixed4 _Color;

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            // Albedo comes from a texture tinted by color
			o.Albedo = _Color;

			// Get the normal data out of the normal map texture 
			// using the UnpackNormal function 
			float3 normalMap = UnpackNormal(tex2D(_NormalMap,
				IN.uv_NormalTex));

			//normalMap.x *= _NormalMapIntensity;
			//normalMap.y *= _NormalMapIntensity;

			// Apply the new normal to the lighting model 
			//o.Normal = normalize(normalMap.rgb); 
			//o.Normal = normalMap.rgb;
            
          
			o.Normal = normalMap.rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}