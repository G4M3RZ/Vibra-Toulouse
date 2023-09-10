Shader "Unlit/AlphaShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        [NoScaleOffset] _NormalMap("Normals", 2D) = "bump" {}
        [NoScaleOffset] _HeightMap("Heights", 2D) = "gray" {}
    }
    SubShader
    {
        Tags { "Queue" = "Transparent" "IgnoreProjector" = "True" "RenderType"="Transparent" }
        
        /*ZWrite Off*/
        Blend SrcAlpha OneMinusSrcAlpha

        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float4 color : COLOR;

                float2 uv : TEXCOORD0;
                /*float3 normal : TEXCOORD1;*/
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float4 color : COLOR;

                float2 uv : TEXCOORD0;
                /*half3 worldNormal : TEXCOORD1;*/
                float4 worldSpacePos : TEXCOORD2;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            sampler2D _NormalMap;

            v2f vert (appdata v)
            {
                v2f o;
                
                o.vertex = UnityObjectToClipPos(v.vertex);
                
                //normal
                /*v.normal.xy = tex2D(_NormalMap, v.uv).wy * 2 - 1;
                v.normal.z = sqrt(1 - saturate(dot(v.normal.xy, v.normal.xy)));
                v.normal = v.normal.xzy;*/

                //color
                o.color = v.color;

                o.worldSpacePos = mul(unity_ObjectToWorld, v.vertex);

                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                fixed4 col = tex2D(_MainTex, i.uv);

                float height = normalize(i.worldSpacePos.z);
                float math = abs(height + i.color.x);
                float alpha = step(math, 0.5f);

                col.a = alpha;

                return col;
            }
            ENDCG
        }
    }
}