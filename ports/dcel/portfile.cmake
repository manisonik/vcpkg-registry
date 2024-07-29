vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

# where to get the package sources from
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO manisonik/dcel
    REF "${VERSION}"
    SHA512 5304e8d8387efebce85854f2fd080e75d3cb30b8b045c68a773a5d295e2c2192676dcd8c518306735d4feffeb91ad71e2375b65df662e6c8a6dc2b039c971ef6
    HEAD_REF master
)

# how to configure the project
vcpkg_cmake_configure(
	# where CMakeLists.txt is (found on root level of the project)
	SOURCE_PATH ${SOURCE_PATH} 
	# CMake configuration options, just regular -D stuff
#	OPTIONS
#		-DGLFW_BUILD_EXAMPLES=0
#		-DGLFW_BUILD_TESTS=0
#		-DGLFW_BUILD_DOCS=0
)

# this one actually builds and installs the project
vcpkg_cmake_install()

# this will (try to) fix possible problems with imported targets
vcpkg_cmake_config_fixup(
	PACKAGE_NAME "dcel"
	# where project's CMake configs are installed by default
    CONFIG_PATH "cmake"
)

# this one you just need to have, and sometimes you'll need to delete even more things
# feels like a crutch, but okay
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

# vcpkg expects license information to be contained in the file named "copyright"
file(
	INSTALL "${SOURCE_PATH}/LICENSE" 
	DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" 
	RENAME copyright
)

# copy the usage file
configure_file("${CMAKE_CURRENT_LIST_DIR}/usage" "${CURRENT_PACKAGES_DIR}/share/${PORT}/usage" COPYONLY)