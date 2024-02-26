(define (problem testing) 
    (:domain problem2)

    (:objects
        loc1 - location
        wor1_1 - workstation
        walker drone jumper - robot
        carrier1 - carrier
        box1 - box
        tool valve bolt parts - content
    )

    (:init
        (adjacent central_warehouse loc1)
        (adjacent loc1 central_warehouse)
        
        (workstation_at_location wor1_1 loc1)
        

        (walks walker)
        (flies drone)
        (jumps jumper)

        (robot_at_location walker central_warehouse)
        (robot_at_location drone central_warehouse)
        (robot_at_location jumper central_warehouse)

        (carrier_at_location carrier1 central_warehouse)
        (= (carrier_capacity carrier1) 1)

        (box_at_location box1 central_warehouse)

        (content_at_cw tool)
        (content_at_cw valve)
        (content_at_cw bolt)
        (content_at_cw parts)


        (robot_is_not_attached walker)
        (robot_is_not_attached drone)
        (robot_is_not_attached jumper)

        (carrier_is_not_attached carrier1)
        
        (box_is_not_loaded box1)
        (box_is_not_full box1)
    )

    (:goal (and
        (content_at_location_at_workstation tool loc1 wor1_1)
    ))
)
