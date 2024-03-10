#include <memory>
#include <algorithm>
#include "plansys2_executor/ActionExecutorClient.hpp"
#include "rclcpp/rclcpp.hpp"
#include "rclcpp_action/rclcpp_action.hpp"

using namespace std::chrono_literals;

class PickUpContentAtCw : public plansys2::ActionExecutorClient { //modify here
public:
    PickUpContentAtCw() : plansys2::ActionExecutorClient("pick_up_content_at_cw", 100ms) { //modify here
        progress_ = 0.0;
    }

private:
    void do_work() {
        if (progress_ < 1.0) {
            progress_ += 0.1; //modify here
            send_feedback(progress_, "PickUpContentAtCw running"); //modify here
        }
        else {
            finish(true, 1.0, "PickUpContentAtCw completed"); //modify here
            progress_ = 0.0; //modify here
            std::cout << std::endl;
        }
        std::cout << "\r\e[K" << std::flush;
        std::cout << "PickUpContentAtCw executed ... [" << std::min(100.0, progress_ * 100.0) << "%]  " << std::flush; //modify here
    }
    float progress_;
};

int main(int argc, char **argv) {
    rclcpp::init(argc, argv);
    auto node = std::make_shared<PickUpContentAtCw>(); //modify here

    node->set_parameter(rclcpp::Parameter("action_name", "pick_up_content_at_cw")); //modify here
    node->trigger_transition(lifecycle_msgs::msg::Transition::TRANSITION_CONFIGURE);

    rclcpp::spin(node->get_node_base_interface());

    rclcpp::shutdown();

    return 0;
}
