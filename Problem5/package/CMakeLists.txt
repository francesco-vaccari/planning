cmake_minimum_required(VERSION 3.5)
#[[ modify here ]]
project(problem5)
#[[ ----------- ]]


find_package(ament_cmake REQUIRED)
find_package(rclcpp REQUIRED)
find_package(rclcpp_action REQUIRED)
find_package(plansys2_msgs REQUIRED)
find_package(plansys2_executor REQUIRED)

set(CMAKE_CXX_STANDARD 17)

set(dependencies
    rclcpp
    rclcpp_action
    plansys2_msgs
    plansys2_executor
)

#[[ modify here ]]
add_executable(move_walking_action_node src/move_walking_action_node.cpp)
ament_target_dependencies(move_walking_action_node ${dependencies})

add_executable(move_flying_action_node src/move_flying_action_node.cpp)
ament_target_dependencies(move_flying_action_node ${dependencies})

add_executable(move_jumping_action_node src/move_jumping_action_node.cpp)
ament_target_dependencies(move_jumping_action_node ${dependencies})

add_executable(robot_attach_carrier_action_node src/robot_attach_carrier_action_node.cpp)
ament_target_dependencies(robot_attach_carrier_action_node ${dependencies})

add_executable(robot_detach_carrier_action_node src/robot_detach_carrier_action_node.cpp)
ament_target_dependencies(robot_detach_carrier_action_node ${dependencies})

add_executable(robot_load_box_action_node src/robot_load_box_action_node.cpp)
ament_target_dependencies(robot_load_box_action_node ${dependencies})

add_executable(robot_unload_box_action_node src/robot_unload_box_action_node.cpp)
ament_target_dependencies(robot_unload_box_action_node ${dependencies})

add_executable(pick_up_content_at_cw_action_node src/pick_up_content_at_cw_action_node.cpp)
ament_target_dependencies(pick_up_content_at_cw_action_node ${dependencies})

add_executable(put_down_content_at_cw_action_node src/put_down_content_at_cw_action_node.cpp)
ament_target_dependencies(put_down_content_at_cw_action_node ${dependencies})

add_executable(pick_up_content_action_node src/pick_up_content_action_node.cpp)
ament_target_dependencies(pick_up_content_action_node ${dependencies})

add_executable(put_down_content_action_node src/put_down_content_action_node.cpp)
ament_target_dependencies(put_down_content_action_node ${dependencies})
#[[ ----------- ]]

install(DIRECTORY launch pddl DESTINATION share/${PROJECT_NAME})

install(TARGETS
  #[[ modify here ]]
  move_walking_action_node
  move_flying_action_node
  move_jumping_action_node
  robot_attach_carrier_action_node
  robot_detach_carrier_action_node
  robot_load_box_action_node
  robot_unload_box_action_node
  pick_up_content_at_cw_action_node
  put_down_content_at_cw_action_node
  pick_up_content_action_node
  put_down_content_action_node
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