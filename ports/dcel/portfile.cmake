vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO manisonik/dcel
    REF v1.0.1
    SHA512 0
    HEAD_REF master
)

vcpkg_cmake_configure(SOURCE_PATH ${SOURCE_PATH})
vcpkg_cmake_install()