// Unity built-in shader source. Copyright (c) 2016 Unity Technologies. MIT license (see license.txt)

#ifndef UNITY_STANDARD_CORE_FORWARD_INCLUDED
#define UNITY_STANDARD_CORE_FORWARD_INCLUDED

#if defined(UNITY_NO_FULL_STANDARD_SHADER)
#   define UNITY_STANDARD_SIMPLE 1
#endif

#include "UnityStandardConfig.cginc"

#if UNITY_STANDARD_SIMPLE
    #include "glTFUnityStandardCoreForwardSimple.cginc"
    VertexOutputBaseSimple vertBase (VertexInput v) { return vertForwardBaseSimple(v); }
    VertexOutputForwardAddSimple vertAdd (VertexInput v) { return vertForwardAddSimple(v); }
    half4 fragBase (VertexOutputBaseSimple i) : SV_Target { return fragForwardBaseSimpleInternal(i); }
    half4 fragAdd (VertexOutputForwardAddSimple i) : SV_Target { return fragForwardAddSimpleInternal(i); }

    half4 fragBaseFacing (VertexOutputBaseSimple i, half facing : VFACE) : SV_Target
    {
#ifdef _TANGENT_TO_WORLD
        i.tangentToWorldAndPackedData[0].xyz *= facing;
        i.tangentToWorldAndPackedData[1].xyz *= facing;
#endif
        i.tangentToWorldAndPackedData[2].xyz *= facing;
        return fragBase(i);
    }
    half4 fragAddFacing (VertexOutputForwardAddSimple i, half facing : VFACE) : SV_Target {
        i.tangentSpaceEyeVec.xyz *= facing;
        return fragAdd(i);
    }
#else
    #include "glTFUnityStandardCore.cginc"
    VertexOutputForwardBase vertBase (VertexInput v) { return vertForwardBase(v); }
    VertexOutputForwardAdd vertAdd (VertexInput v) { return vertForwardAdd(v); }
    half4 fragBase (VertexOutputForwardBase i) : SV_Target { return fragForwardBaseInternal(i); }
    half4 fragAdd (VertexOutputForwardAdd i) : SV_Target { return fragForwardAddInternal(i); }

    half4 fragBaseFacing (VertexOutputForwardBase i, half facing : VFACE) : SV_Target
    {
#ifdef _TANGENT_TO_WORLD
        i.tangentToWorldAndPackedData[0].xyz *= facing;
        i.tangentToWorldAndPackedData[1].xyz *= facing;
#endif
        i.tangentToWorldAndPackedData[2].xyz *= facing;
        return fragBase(i);
    }
    half4 fragAddFacing (VertexOutputForwardAdd i, half facing : VFACE) : SV_Target {
#ifdef _TANGENT_TO_WORLD
        i.tangentToWorldAndLightDir[0].xyz *= facing;
        i.tangentToWorldAndLightDir[1].xyz *= facing;
#endif
        i.tangentToWorldAndLightDir[2].xyz *= facing;
        return fragAdd(i);
    }
#endif

#endif // UNITY_STANDARD_CORE_FORWARD_INCLUDED
