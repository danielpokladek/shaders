Shader "Unlit/PaletteSwap"
{
    Properties
    {
        _MainTex ("Base Texture", 2D) = "white" {}
        _GradientTex ("Gradient Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            float4 _MainTex_ST;

            sampler2D _MainTex;
            sampler2D _GradientTex;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed baseTexture = tex2D(_MainTex, i.uv).r;
                fixed4 gradientTexture = tex2D(_GradientTex, float2(baseTexture, 0));

                return gradientTexture;
            }
            ENDCG
        }
    }
}
