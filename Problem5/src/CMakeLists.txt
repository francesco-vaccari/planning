cmake_minimum_required(VERSION 3.5)
#[[ modify here ]]
project(plansys2_template)
#[[ ----------- ]]


find_package(ament_cmake REQUIRED)
find_package(rclcpp REQUIRED)
find_package(plansys2_msgs REQUIRED)
find_package(plansys2_executor REQUIRED)

set(CMAKE_CXX_STANDARD 17)

set(dependencies
    rclcpp
    plansys2_msgs
    plansys2_executor
)

#[[ modify here ]]
add_executable(template_action_node src/template_action_node.cpp)
ament_target_dependencies(template_action_node ${dependencies})
#[[ ----------- ]]

install(DIRECTORY launch pddl DESTINATION share/${PROJECT_NAME})

install(TARGETS
  #[[ modify here ]]
  template_action_node
  #[[ ----------- ]]
  ARCHIVE DESTINATION lib
  LIBRARY DESTINATION lib
  RUNTIME DESTINATION lib/${PROJECT_NAME}
)

if(BUILD_TESTING)
  find_package(ament_lint_auto REQUIRED)
  ament_lint_auto_find_test_dependencies()

  find_package(ament_cmake_gtest REQUIRED)
endif()

ament_export_dependencies(${dependencies})

ament_package()