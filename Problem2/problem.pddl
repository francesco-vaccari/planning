(define (problem testing)
    (:domain problem2)

    (:objects
        loc1 loc2 - location
        wor1_1 wor1_2 wor2_1 wor2_2 wor2_3 - workstation
        walker drone jumper - robot
        carrier1 carrier2 carrier3 - carrier
        box1 box2 box3 box4 - box
        tool bolt valve parts - content
    )

    (:init
        (walks walker)
        (flies drone)
        (jumps jumper)

        (adjacent central_warehouse loc1)
        (adjacent loc1 central_warehouse)
        (adjacent loc1 loc2)
        (adjacent loc2 loc1)

        (workstation_at_location wor1_1 loc1)
        (workstation_at_location wor1_2 loc1)
        (workstation_at_location wor2_1 loc2)
        (workstation_at_location wor2_2 loc2)
        (workstation_at_location wor2_3 loc2)

        (robot_at_location walker central_warehouse)
        (robot_at_location drone central_warehouse)
        (robot_at_location jumper central_warehouse)

        (carrier_capacity carrier1 one)
        (carrier_capacity carrier2 two)
        (carrier_capacity carrier3 three)
        (carrier_at_location carrier1 central_warehouse)
        (carrier_at_location carrier2 central_warehouse)
        (carrier_at_location carrier3 central_warehouse)

        (box_at_location box1 central_warehouse)
        (box_at_location box2 central_warehouse)
        (box_at_location box3 central_warehouse)
        (box_at_location box4 central_warehouse)

        (content_at_cw tool)
        (content_at_cw bolt)
        (content_at_cw valve)
        (content_at_cw parts)

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
            (content_at_location_at_workstation valve loc2 wor2_2)
            (content_at_location_at_workstation valve loc1 wor1_1)
            (content_at_location_at_workstation parts loc1 wor1_1)
        )
    )
)
