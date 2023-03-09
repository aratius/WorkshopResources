Shader "Unlit/LifeGauge"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Percent ("Percent", float) = 0
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue" = "Transparent" }
        Blend SrcAlpha OneMinusSrcAlpha 
        Cull off
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float _Percent;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = tex2D(_MainTex, i.uv);
                if(col.r > .5 && col.g < .4 && col.b < .4) 
                {
                    col.rgb = col.r;
                    float percent = _Percent;
                    float rangeMin = 0.14;
                    float rangeMax = .98;
                    // 0 - 1 to rangeMin - rangeMax
                    float truePercent = (rangeMax - rangeMin) / (1 - 0) * percent + (1 * rangeMin - 0 * rangeMax) / (1 - 0); 
                    fixed3 GREEN = fixed3(0, 1, 0.);
                    fixed3 RED = fixed3(1, 0, 0.);
                    fixed3 BLACK = fixed3(0, 0, 0.);
                    if(i.uv.x < truePercent) col.rgb = GREEN;
                }

                return col;
            }
            ENDCG
        }
    }
}
