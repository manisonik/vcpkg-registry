# where to get the package sources from
vcpkg_from_git(
    OUT_SOURCE_PATH SOURCE_PATH
    URL https://github.com/xioTechnologies/Fusion.git
	REF 18a2c920e1036717fb2ab2a13520039ff3b930bd
    HEAD_REF main
	PATCHES
		fix_build.patch
)

file(COPY "${CMAKE_CURRENT_LIST_DIR}/Config.cmake.in" DESTINATION "${SOURCE_PATH}")

# how to configure the project
vcpkg_cmake_configure(
	# where CMakeLists.txt is (found on root level of the project)
	SOURCE_PATH ${SOURCE_PATH} 
	# CMake configuration options, just regular -D stuff
#	OPTIONS
#		-DFUSION_BUILD_TESTS=0
)

# this one actually builds and installs the project
vcpkg_cmake_install()
vcpkg_copy_pdbs()

# this will (try to) fix possible problems with imported targets
vcpkg_cmake_config_fixup(
	PACKAGE_NAME "fusion"
	# where project's CMake configs are installed by default
    CONFIG_PATH "cmake"
)

# this one you just need to have, and sometimes you'll need to delete even more things
# feels like a crutch, but okay
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

# vcpkg expects license information to be contained in the file named "copyright"
file(
	INSTALL "${SOURCE_PATH}/LICENSE.md" 
	DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" 
	RENAME copyright
)

# copy the usage file
configure_file("${CMAKE_CURRENT_LIST_DIR}/usage" "${CURRENT_PACKAGES_DIR}/share/${PORT}/usage" COPYONLY)