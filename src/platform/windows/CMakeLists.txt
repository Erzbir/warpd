file(GLOB PLATFORM_WINDOWS_SRC
        CONFIGURE_DEPENDS
        ${CMAKE_CURRENT_SOURCE_DIR}/*.c
)

target_sources(warpd PRIVATE ${PLATFORM_WINDOWS_SRC})

target_include_directories(warpd PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}
)

target_compile_definitions(warpd PRIVATE PLATFORM_WINDOWS)
