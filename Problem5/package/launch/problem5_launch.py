import os
from ament_index_python.packages import get_package_share_directory
from launch import LaunchDescription
from launch.actions import DeclareLaunchArgument, IncludeLaunchDescription
from launch.launch_description_sources import PythonLaunchDescriptionSource
from launch.substitutions import LaunchConfiguration
from launch_ros.actions import Node


def generate_launch_description():
    # modified here
    example_dir = get_package_share_directory('problem5')
    # -----------
    namespace = LaunchConfiguration('namespace')

    declare_namespace_cmd = DeclareLaunchArgument(
        'namespace',
        default_value='',
        description='Namespace')

    plansys2_cmd = IncludeLaunchDescription(
        PythonLaunchDescriptionSource(os.path.join(
            get_package_share_directory('plansys2_bringup'),
            'launch',
            'plansys2_bringup_launch_monolithic.py')),
        launch_arguments={
          # modified here
          'model_file': example_dir + '/pddl/domain.pddl',
          # -----------
          'namespace': namespace
          }.items())

    # modified here
    move_walking_cmd = Node(
        package='problem5',
        executable='move_walking_action_node',
        name='move_walking_action_node',
        namespace=namespace,
        output='screen',
        parameters=[])
    move_flying_cmd = Node(
        package='problem5',
        executable='move_flying_action_node',
        name='move_flying_action_node',
        namespace=namespace,
        output='screen',
        parameters=[])
    move_jumping_cmd = Node(
        package='problem5',
        executable='move_jumping_action_node',
        name='move_jumping_action_node',
        namespace=namespace,
        output='screen',
        parameters=[])
    robot_attach_carrier_cmd = Node(
        package='problem5',
        executable='robot_attach_carrier_action_node',
        name='robot_attach_carrier_action_node',
        namespace=namespace,
        output='screen',
        parameters=[])
    robot_detach_carrier_cmd = Node(
        package='problem5',
        executable='robot_detach_carrier_action_node',
        name='robot_detach_carrier_action_node',
        namespace=namespace,
        output='screen',
        parameters=[])
    robot_load_box_cmd = Node(
        package='problem5',
        executable='robot_load_box_action_node',
        name='robot_load_box_action_node',
        namespace=namespace,
        output='screen',
        parameters=[])
    robot_unload_box_cmd = Node(
        package='problem5',
        executable='robot_unload_box_action_node',
        name='robot_unload_box_action_node',
        namespace=namespace,
        output='screen',
        parameters=[])
    pick_up_content_at_cw_cmd = Node(
        package='problem5',
        executable='pick_up_content_at_cw_action_node',
        name='pick_up_content_at_cw_action_node',
        namespace=namespace,
        output='screen',
        parameters=[])
    put_down_content_at_cw_cmd = Node(
        package='problem5',
        executable='put_down_content_at_cw_action_node',
        name='put_down_content_at_cw_action_node',
        namespace=namespace,
        output='screen',
        parameters=[])
    pick_up_content_cmd = Node(
        package='problem5',
        executable='pick_up_content_action_node',
        name='pick_up_content_action_node',
        namespace=namespace,
        output='screen',
        parameters=[])
    put_down_content_cmd = Node(
        package='problem5',
        executable='put_down_content_action_node',
        name='put_down_content_action_node',
        namespace=namespace,
        output='screen',
        parameters=[])
    # -----------

    ld = LaunchDescription()

    ld.add_action(declare_namespace_cmd)
    
    ld.add_action(plansys2_cmd)

    # modified here
    ld.add_action(move_walking_cmd)
    ld.add_action(move_flying_cmd)
    ld.add_action(move_jumping_cmd)
    ld.add_action(robot_attach_carrier_cmd)
    ld.add_action(robot_detach_carrier_cmd)
    ld.add_action(robot_load_box_cmd)
    ld.add_action(robot_unload_box_cmd)
    ld.add_action(pick_up_content_at_cw_cmd)
    ld.add_action(put_down_content_at_cw_cmd)
    ld.add_action(pick_up_content_cmd)
    ld.add_action(put_down_content_cmd)
    # -----------

    return ld
