(define (problem problem_1)
    (:domain problem1)

    (:objects
        loc1 - location
        rob1 - robot
        box1 - box
        wor1_1 - workstation
        tool valve bolt - content
    )

    (:init
        (adjacent central_warehouse loc1)
        (adjacent loc1 central_warehouse)

        (robot_at_location rob1 central_warehouse)
        (box_at_location box1 central_warehouse)

        (content_at_cw tool)
        (content_at_cw valve)
        (content_at_cw bolt)

        (workstation_at_location wor1_1 loc1)
    )

    (:goal
        (and
            (content_at_workstation_at_location tool wor1_1 loc1)
        )
    )
)
