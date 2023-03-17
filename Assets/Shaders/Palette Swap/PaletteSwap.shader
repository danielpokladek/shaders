Shader "Unlit/PaletteSwap"
{
    Properties
    {
        _MainTex ("Base Texture", 2D) = "white" {}
        _GradientTex ("Gradient Texture", 2D) = "white" {}
        _Speed ("Speed", float) = 1
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

            float _Speed;

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

                float2 gradientUVs = float2(fmod(baseTexture + (_Time.x * _Speed), 1), 0);
                // float2 gradientUVs = float2(baseTexture, 0.5);

                fixed4 gradientTexture = tex2D(_GradientTex, gradientUVs);

                // return float4(gradientUVs.x, 0, 0, 1);
                return gradientTexture;
                // return float4(baseTexture, baseTexture, baseTexture, 1);
            }
            ENDCG
        }
    }
}
