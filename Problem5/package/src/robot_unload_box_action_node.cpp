#include <memory>
#include <algorithm>
#include "plansys2_executor/ActionExecutorClient.hpp"
#include "rclcpp/rclcpp.hpp"
#include "rclcpp_action/rclcpp_action.hpp"

using namespace std::chrono_literals;

class RobotUnloadBox : public plansys2::ActionExecutorClient { //modified here
public:
    RobotUnloadBox() : plansys2::ActionExecutorClient("robot_unload_box", 200ms) { //modified here
        progress_ = 0.0;
    }

private:
    void do_work() {
        if (progress_ < 1.0) {
            progress_ += 0.1; //modified here
            send_feedback(progress_, "RobotUnloadBox running"); //modified here
        }
        else {
            finish(true, 1.0, "RobotUnloadBox completed"); //modified here
            progress_ = 0.0; //modified here
            std::cout << std::endl;
        }
        std::cout << "\r\e[K" << std::flush;
        std::cout << "RobotUnloadBox executed ... [" << std::min(100.0, progress_ * 100.0) << "%]  " << std::flush; //modified here
    }
    float progress_;
};

int main(int argc, char **argv) {
    rclcpp::init(argc, argv);
    auto node = std::make_shared<RobotUnloadBox>(); //modified here

    node->set_parameter(rclcpp::Parameter("action_name", "robot_unload_box")); //modified here
    node->trigger_transition(lifecycle_msgs::msg::Transition::TRANSITION_CONFIGURE);

    rclcpp::spin(node->get_node_base_interface());

    rclcpp::shutdown();

    return 0;
}
