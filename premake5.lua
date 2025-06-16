workspace "Engine1"
    architecture "x64"
    startproject "Sandbox"

    configurations
    {
        "Debug",
        "Release",
        "Dist"
    }

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

project "Engine1"
    location "Engine1"
    kind "SharedLib"
    language "C++"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    files
    {
        "%{prj.name}/src/**.h",
        "%{prj.name}/src/**.cpp"
    }

    includedirs
    {
        "%{prj.name}/vendor/spdlog/include"
    }

    buildoptions {"/utf-8"}

    filter "system:windows"
        cppdialect "C++17"
        staticruntime "On"
        systemversion "latest"

        defines
        {
            "ENGINE_PLATFORM_WINDOWS",
            "ENGINE_BUILD_DLL"
        }

        postbuildcommands
        {
            ("{COPY} %{cfg.buildtarget.relpath} ../bin/" .. outputdir .. "/Sandbox")
        }

    filter "configurations:Debug"
        defines "ENGINE_DEBUG"
        symbols "On"

    filter "configurations:Release"
        defines "ENGINE_RELEASE"
        optimize "On"

    filter "configurations:Dist"
        defines "ENGINE_DIST"
        optimize "On"

    filter "action:vs*"
        buildoptions {"/utf-8"}

project "Sandbox"
    location "Sandbox"
    kind "ConsoleApp"
    language "C++"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    files
    {
        "%{prj.name}/src/**.h",
        "%{prj.name}/src/**.cpp"
    }

    includedirs
    {
        "Engine1/vendor/spdlog/include",
        "Engine1/src"
    }

    links
    {
        "Engine1"
    }

    buildoptions {"/utf-8"}

    filter "system:windows"
        cppdialect "C++17"
        staticruntime "On"
        systemversion "latest"

        defines
        {
            "ENGINE_PLATFORM_WINDOWS"
        }

    filter "configurations:Debug"
        defines "ENGINE_DEBUG"
        symbols "On"

    filter "configurations:Release"
        defines "ENGINE_RELEASE"
        optimize "On"

    filter "configurations:Dist"
        defines "ENGINE_DIST"
        optimize "On"
        