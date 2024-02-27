(define (problem testing) 
    (:domain problem4)

    (:objects
        loc1 loc2 loc3 - location
        wor1_1 wor1_2 wor2_1 wor2_2 wor3_1 wor3_2 - workstation
        walker drone jumper - robot
        carrier1 carrier2 carrier3 - carrier
        box1 box2 box3 - box
        tool valve bolt parts - content
    )

    (:init
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
        (workstation_at_location wor3_1 loc3)
        (workstation_at_location wor3_2 loc3)
        

        (walks walker)
        (flies drone)
        (jumps jumper)

        (robot_at_location walker central_warehouse)
        (robot_at_location drone central_warehouse)
        (robot_at_location jumper central_warehouse)

        (carrier_at_location carrier1 central_warehouse)
        (carrier_at_location carrier2 central_warehouse)
        (carrier_at_location carrier3 central_warehouse)

        (= (carrier_capacity carrier1) 1)
        (= (carrier_capacity carrier2) 2)
        (= (carrier_capacity carrier3) 3)

        (box_at_location box1 central_warehouse)
        (box_at_location box2 central_warehouse)
        (box_at_location box3 central_warehouse)

        (content_at_cw tool)
        (content_at_cw valve)
        (content_at_cw bolt)
        (content_at_cw parts)


        (robot_is_not_attached walker)
        (robot_is_not_attached drone)
        (robot_is_not_attached jumper)

        (carrier_is_not_attached carrier1)
        (carrier_is_not_attached carrier2)
        (carrier_is_not_attached carrier3)
        
        (box_is_not_loaded box1)
        (box_is_not_full box1)
        (box_is_not_loaded box2)
        (box_is_not_full box2)
        (box_is_not_loaded box3)
        (box_is_not_full box3)
    )

    (:goal (and
        (content_at_location_at_workstation tool loc3 wor3_1)

    ))

    (:metric minimize (total-time))
)
