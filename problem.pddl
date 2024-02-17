(define (problem testing)
    (:domain problem1)

    (:objects
        loc1 loc2 - location
        rob1 - robot
        box1 - box
        wor1 wor2_1 wor2_2 - workstation
        tool valve bolt - content
    )

    (:init
        (adjacent central_warehouse loc1)
        (adjacent loc1 central_warehouse)
        (adjacent loc1 loc2)
        (adjacent loc2 loc1)

        (robot_at_location rob1 central_warehouse)
        (box_at_location box1 central_warehouse)

        (content_at_cw tool)
        (content_at_cw valve)
        (content_at_cw bolt)

        (workstation_at_location wor1 loc1)
        (workstation_at_location wor2_1 loc2)
        (workstation_at_location wor2_2 loc2)
    )

    (:goal
        (and
            (box_at_location box1 central_warehouse)
            (content_at_workstation_at_location tool wor1 loc1)
            (content_at_workstation_at_location tool wor2_1 loc2)
            (content_at_workstation_at_location valve wor2_2 loc2)
        )
    )
)
