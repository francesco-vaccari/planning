import os
from ament_index_python.packages import get_package_share_directory
from launch import LaunchDescription
from launch.actions import DeclareLaunchArgument, IncludeLaunchDescription
from launch.launch_description_sources import PythonLaunchDescriptionSource
from launch.substitutions import LaunchConfiguration
from launch_ros.actions import Node


def generate_launch_description():
    # modify here
    example_dir = get_package_share_directory('plansys2_template')
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
          # modify here
          'model_file': example_dir + '/pddl/domain.pddl',
          # -----------
          'namespace': namespace
          }.items())

    # modify here
    template_cmd = Node(
        package='plansys2_template',
        executable='template_action_node',
        name='template_action_node',
        namespace=namespace,
        output='screen',
        parameters=[])
    # -----------

    ld = LaunchDescription()

    ld.add_action(declare_namespace_cmd)
    
    ld.add_action(plansys2_cmd)

    # modify here
    ld.add_action(template_cmd)
    # -----------

    return ld
