(define (problem problem_1)
    (:domain problem2)

    (:objects
        loc1 loc2 loc3 loc4 loc5 loc6 loc7 loc8 - location
        wor1_1 wor6_1 wor8_1 - workstation
        walker jumper - robot
        carrier1 carrier2 - carrier
        box1 box2 box3 - box
        tool bolt valve - content
    )

    (:init
        (walks walker)
        (jumps jumper)

        (adjacent central_warehouse loc1)
        (adjacent loc1 central_warehouse)
        (adjacent loc1 loc2)
        (adjacent loc2 loc1)
        (adjacent loc2 loc3)
        (adjacent loc3 loc2)
        (adjacent loc3 loc4)
        (adjacent loc4 loc3)
        (adjacent loc4 loc5)
        (adjacent loc5 loc4)
        (adjacent loc5 loc6)
        (adjacent loc6 loc5)
        (adjacent loc6 loc7)
        (adjacent loc7 loc6)
        (adjacent loc7 loc8)
        (adjacent loc8 loc7)

        (workstation_at_location wor1_1 loc1)
        (workstation_at_location wor6_1 loc6)
        (workstation_at_location wor8_1 loc8)

        (robot_at_location walker central_warehouse)
        (robot_at_location jumper central_warehouse)

        (carrier_capacity carrier1 one)
        (carrier_capacity carrier2 two)
        (carrier_at_location carrier1 central_warehouse)
        (carrier_at_location carrier2 central_warehouse)

        (box_at_location box1 central_warehouse)
        (box_at_location box2 central_warehouse)
        (box_at_location box3 central_warehouse)

        (content_at_cw tool)
        (content_at_cw bolt)
        (content_at_cw valve)

        (increase_capacity zero one)
        (increase_capacity one two)
        (increase_capacity two three)
        (increase_capacity three four)
        (increase_capacity four five)
        (increase_capacity five six)
        (increase_capacity six seven)
        (increase_capacity seven eight)
        (increase_capacity eight nine)
        (increase_capacity nine ten)
        (decrease_capacity one zero)
        (decrease_capacity two one)
        (decrease_capacity three two)
        (decrease_capacity four three)
        (decrease_capacity five four)
        (decrease_capacity six five)
        (decrease_capacity seven six)
        (decrease_capacity eight seven)
        (decrease_capacity nine eight)
        (decrease_capacity ten nine)
    )
    
    (:goal
        (and
            (content_at_location_at_workstation valve loc1 wor1_1)
            (content_at_location_at_workstation tool loc6 wor6_1)
            (content_at_location_at_workstation tool loc8 wor8_1)
        )
    )
)
