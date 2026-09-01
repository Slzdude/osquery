# osquery wrapper CMake config
# Agent 端使用: find_package(osquery_wrapper) + target_link_libraries(... osquery_wrapper)

get_filename_component(SELF_DIR "${CMAKE_CURRENT_LIST_DIR}" PATH)

# 导入 wrapper 静态库
add_library(osquery_wrapper STATIC IMPORTED)
set_target_properties(osquery_wrapper PROPERTIES
  IMPORTED_LOCATION "${SELF_DIR}/libosquery_wrapper.a"
  INTERFACE_INCLUDE_DIRECTORIES "${SELF_DIR}"
)

# 声明传递依赖（CMake 自动处理链接顺序）
# 这些是 wrapper 的 target_link_libraries 中声明的依赖
# Agent 端链接 osquery_wrapper 时会自动传递
