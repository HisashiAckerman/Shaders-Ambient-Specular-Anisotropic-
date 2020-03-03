﻿Shader "Custom/ToonPractice"
{
    Properties
    {
        
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
		_RampTexture("Ram[ Texture", 2D) = "white"{}

        
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf ToonRamp 

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;
		sampler2D _RampTexture;

        struct Input
        {
            float2 uv_MainTex;
        };

        

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

		fixed4 LightingToonRamp(SurfaceOutput s, fixed3 lightDir, fixed atten)
		{
			half NdotL = dot(s.Normal, lightDir);
			NdotL = tex2D(_RampTexture, fixed2(NdotL, 0));
			half4 color;
			color.rgb = s.Albedo * _LightColor0 * NdotL * atten;
			color.a = s.Alpha;
			return color;
		}

        void surf (Input IN, inout SurfaceOutput o)
        {
            // Albedo comes from a texture tinted by color
            o.Albedo = tex2D (_MainTex, IN.uv_MainTex).rgb;
           
        }
        ENDCG
    }
    FallBack "Diffuse"
}
