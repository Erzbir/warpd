target_link_libraries(warpd PRIVATE
        "-framework Cocoa"
        "-framework Carbon"
)

file(GLOB PLATFORM_MACOS_SRC
        CONFIGURE_DEPENDS
        ${CMAKE_CURRENT_SOURCE_DIR}/*.c
        ${CMAKE_CURRENT_SOURCE_DIR}/*.m
        ${CMAKE_CURRENT_SOURCE_DIR}/*.h
)

target_sources(warpd PRIVATE ${PLATFORM_MACOS_SRC})

target_include_directories(warpd PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}
)

target_compile_definitions(warpd PRIVATE PLATFORM_MACOS)
