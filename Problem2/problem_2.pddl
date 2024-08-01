(define (problem problem_2)
    (:domain problem2)

    (:objects
        loc1 loc2 loc3 - location
        wor1_1 wor1_2 wor2_1 wor2_2 wor2_3 wor3_1 wor3_2 - workstation
        drone - robot
        carrier1 - carrier
        box1 box2 box3 box4 box5 box6 box7 box8 - box
        tool bolt valve parts gears - content
    )

    (:init
        (flies drone)

        (adjacent central_warehouse loc1)
        (adjacent loc1 central_warehouse)
        (adjacent loc1 loc2)
        (adjacent loc2 loc1)
        (adjacent loc2 loc3)
        (adjacent loc3 loc2)

        (workstation_at_location wor1_1 loc1)
        (workstation_at_location wor1_2 loc1)
        (workstation_at_location wor2_1 loc2)
        (workstation_at_location wor2_2 loc2)
        (workstation_at_location wor2_3 loc2)
        (workstation_at_location wor3_1 loc3)
        (workstation_at_location wor3_2 loc3)

        (robot_at_location drone central_warehouse)

        (carrier_capacity carrier1 six)
        (carrier_at_location carrier1 central_warehouse)

        (box_at_location box1 central_warehouse)
        (box_at_location box2 central_warehouse)
        (box_at_location box3 central_warehouse)
        (box_at_location box4 central_warehouse)
        (box_at_location box5 central_warehouse)
        (box_at_location box6 central_warehouse)
        (box_at_location box7 central_warehouse)
        (box_at_location box8 central_warehouse)

        (content_at_cw tool)
        (content_at_cw bolt)
        (content_at_cw valve)
        (content_at_cw parts)
        (content_at_cw gears)

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
            (content_at_location_at_workstation tool loc2 wor2_1)
            (content_at_location_at_workstation bolt loc2 wor2_1)
            (content_at_location_at_workstation valve loc2 wor2_2)
            (content_at_location_at_workstation parts loc2 wor2_3)
            (content_at_location_at_workstation bolt loc3 wor3_1)
            (content_at_location_at_workstation parts loc3 wor3_1)
            (content_at_location_at_workstation gears loc3 wor3_2)
        )
    )
)
