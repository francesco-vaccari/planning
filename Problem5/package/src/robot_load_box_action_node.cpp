#include <memory>
#include <algorithm>
#include "plansys2_executor/ActionExecutorClient.hpp"
#include "rclcpp/rclcpp.hpp"
#include "rclcpp_action/rclcpp_action.hpp"

using namespace std::chrono_literals;

class RobotLoadBox : public plansys2::ActionExecutorClient { //modify here
public:
    RobotLoadBox() : plansys2::ActionExecutorClient("robot_load_box", 1s) { //modify here
        progress_ = 0.0;
    }

private:
    void do_work() {
        if (progress_ < 1.0) {
            progress_ += 0.05; //modify here
            send_feedback(progress_, "RobotLoadBox running"); //modify here
        }
        else {
            finish(true, 1.0, "RobotLoadBox completed"); //modify here
            progress_ = 0.0; //modify here
            std::cout << std::endl;
        }
        std::cout << "\r\e[K" << std::flush;
        std::cout << "RobotLoadBox being executed ... [" << std::min(100.0, progress_ * 100.0) << "%]  " << std::flush; //modify here
    }
    float progress_;
};

int main(int argc, char **argv) {
    rclcpp::init(argc, argv);
    auto node = std::make_shared<RobotLoadBox>(); //modify here

    node->set_parameter(rclcpp::Parameter("action_name", "robot_load_box")); //modify here
    node->trigger_transition(lifecycle_msgs::msg::Transition::TRANSITION_CONFIGURE);

    rclcpp::spin(node->get_node_base_interface());

    rclcpp::shutdown();

    return 0;
}
