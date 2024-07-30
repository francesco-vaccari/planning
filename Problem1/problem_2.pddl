(define (problem problem_2)
    (:domain problem1)

    (:objects
        loc1 loc2 loc3 loc4 loc5 - location
        rob1 - robot
        box1 box2 - box
        wor1_1 wor2_1 wor2_2 wor3_1 wor4_1 wor5_1 wor5_2 - workstation
        tool valve bolt - content
    )

    (:init
        ; loc1 is adjacent to all locations
        ; all other locations are adjacent only to loc1
        (adjacent central_warehouse loc1)
        (adjacent loc1 central_warehouse)
        (adjacent loc1 loc2)
        (adjacent loc2 loc1)
        (adjacent loc1 loc3)
        (adjacent loc3 loc1)
        (adjacent loc1 loc4)
        (adjacent loc4 loc1)
        (adjacent loc1 loc5)
        (adjacent loc5 loc1)

        (robot_at_location rob1 central_warehouse)
        (box_at_location box1 central_warehouse)
        (box_at_location box2 central_warehouse)

        (content_at_cw tool)
        (content_at_cw valve)
        (content_at_cw bolt)

        (workstation_at_location wor1_1 loc1)
        (workstation_at_location wor2_1 loc2)
        (workstation_at_location wor2_2 loc2)
        (workstation_at_location wor3_1 loc3)
        (workstation_at_location wor4_1 loc4)
        (workstation_at_location wor5_1 loc5)
        (workstation_at_location wor5_2 loc5)
    )

    (:goal
        (and
            (content_at_workstation_at_location tool wor1_1 loc1)
            (content_at_workstation_at_location bolt wor2_2 loc2)
            (content_at_workstation_at_location tool wor5_1 loc5)
            (content_at_workstation_at_location valve wor5_1 loc5)
        )
    )
)
