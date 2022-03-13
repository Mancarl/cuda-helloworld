# This is the root CMakeLists file.
cmake_minimum_required(VERSION 3.10.2 FATAL_ERROR)
if(COMMAND CMAKE_POLICY)
  cmake_policy(SET CMP0074 NEW)
endif()

# Set up project.
project(HelloWorld LANGUAGES CXX CUDA)
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CUDA_STANDARD 11)
set(CMAKE_CUDA_STANDARD_REQUIRED ON)
# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall")
# set(CMAKE_CUDA_FLAGS "${CMAKE_CUDA_FLAGS} -Xcompiler=-Wall")

include(CTest)

add_executable(a a.cu b.cu)
set_property(TARGET a PROPERTY CUDA_SEPARABLE_COMPILATION ON)
# set_property(TARGET a PROPERTY CUDA_RESOLVE_DEVICE_SYMBOLS ON)
set_property(TARGET a PROPERTY CUDA_ARCHITECTURES 75-real 75-virtual)
target_link_libraries(a PRIVATE ${CUDA_LIBRARIES})


