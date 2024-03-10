#include <memory>
#include <algorithm>
#include "plansys2_executor/ActionExecutorClient.hpp"
#include "rclcpp/rclcpp.hpp"
#include "rclcpp_action/rclcpp_action.hpp"

using namespace std::chrono_literals;

class MoveFlying : public plansys2::ActionExecutorClient { //modify here
public:
    MoveFlying() : plansys2::ActionExecutorClient("move_flying", 1s) { //modify here
        progress_ = 0.0;
    }

private:
    void do_work() {
        if (progress_ < 1.0) {
            progress_ += 0.05; //modify here
            send_feedback(progress_, "MoveFlying running"); //modify here
        }
        else {
            finish(true, 1.0, "MoveFlying completed"); //modify here
            progress_ = 0.0; //modify here
            std::cout << std::endl;
        }
        std::cout << "\r\e[K" << std::flush;
        std::cout << "MoveFlying being executed ... [" << std::min(100.0, progress_ * 100.0) << "%]  " << std::flush; //modify here
    }
    float progress_;
};

int main(int argc, char **argv) {
    rclcpp::init(argc, argv);
    auto node = std::make_shared<MoveFlying>(); //modify here

    node->set_parameter(rclcpp::Parameter("action_name", "move_flying")); //modify here
    node->trigger_transition(lifecycle_msgs::msg::Transition::TRANSITION_CONFIGURE);

    rclcpp::spin(node->get_node_base_interface());

    rclcpp::shutdown();

    return 0;
}
