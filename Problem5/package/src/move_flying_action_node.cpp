#include <memory>
#include <algorithm>
#include "plansys2_executor/ActionExecutorClient.hpp"
#include "rclcpp/rclcpp.hpp"
#include "rclcpp_action/rclcpp_action.hpp"

using namespace std::chrono_literals;

class MoveFlying : public plansys2::ActionExecutorClient { //modified here
public:
    MoveFlying() : plansys2::ActionExecutorClient("move_flying", 7000ms) { //modified here
        progress_ = 0.0;
    }

private:
    void do_work() {
        if (progress_ < 1.0) {
            progress_ += 0.1; //modified here
            send_feedback(progress_, "MoveFlying running"); //modified here
        }
        else {
            finish(true, 1.0, "MoveFlying completed"); //modified here
            progress_ = 0.0; //modified here
            std::cout << std::endl;
        }
        std::cout << "\r\e[K" << std::flush;
        std::cout << "MoveFlying executed ... [" << std::min(100.0, progress_ * 100.0) << "%]  " << std::flush; //modified here
    }
    float progress_;
};

int main(int argc, char **argv) {
    rclcpp::init(argc, argv);
    auto node = std::make_shared<MoveFlying>(); //modified here

    node->set_parameter(rclcpp::Parameter("action_name", "move_flying")); //modified here
    node->trigger_transition(lifecycle_msgs::msg::Transition::TRANSITION_CONFIGURE);

    rclcpp::spin(node->get_node_base_interface());

    rclcpp::shutdown();

    return 0;
}
