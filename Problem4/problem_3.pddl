(define (problem testing) 
    (:domain problem4)

    (:objects
        loc1 loc2 loc3 loc4 loc5 loc6 loc7 loc8 loc9 - location
        wor1 wor2 wor3 wor4 wor5 wor6 wor7 wor8 wor9 - workstation
        walker jumper drone - robot
        carrier1 carrier2 carrier3 - carrier
        box1 box2 box3 box4 box5 box6 - box
        tool valve bolt - content
    )

    (:init
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
        (adjacent loc8 loc9)
        (adjacent loc9 loc8)

        (workstation_at_location wor1 loc1)
        (workstation_at_location wor2 loc2)
        (workstation_at_location wor3 loc3)
        (workstation_at_location wor4 loc4)
        (workstation_at_location wor5 loc5)
        (workstation_at_location wor6 loc6)
        (workstation_at_location wor7 loc7)
        (workstation_at_location wor8 loc8)
        (workstation_at_location wor9 loc9)

        (walks walker)
        (jumps jumper)
        (flies drone)

        (mutex_load_box walker)
        (mutex_load_box jumper)
        (mutex_load_box drone)

        (robot_at_location walker central_warehouse)
        (robot_at_location jumper central_warehouse)
        (robot_at_location drone central_warehouse)

        (carrier_at_location carrier1 central_warehouse)
        (carrier_at_location carrier2 central_warehouse)
        (carrier_at_location carrier3 central_warehouse)

        (= (carrier_capacity carrier1) 2)
        (= (carrier_capacity carrier2) 2)
        (= (carrier_capacity carrier3) 2)

        (box_at_location box1 central_warehouse)
        (box_at_location box2 central_warehouse)
        (box_at_location box3 central_warehouse)
        (box_at_location box4 central_warehouse)
        (box_at_location box5 central_warehouse)
        (box_at_location box6 central_warehouse)

        (robot_is_not_attached walker)
        (robot_is_not_attached jumper)
        (robot_is_not_attached drone)

        (carrier_is_not_attached carrier1)
        (carrier_is_not_attached carrier2)
        (carrier_is_not_attached carrier3)

        (box_is_not_loaded box1)
        (box_is_not_loaded box2)
        (box_is_not_loaded box3)
        (box_is_not_loaded box4)
        (box_is_not_loaded box5)
        (box_is_not_loaded box6)

        (box_is_not_full box1)
        (box_is_not_full box2)
        (box_is_not_full box3)
        (box_is_not_full box4)
        (box_is_not_full box5)
        (box_is_not_full box6)

        (content_at_cw tool)
        (content_at_cw valve)
        (content_at_cw bolt)
    )

    (:goal (and
        (content_at_location_at_workstation tool loc1 wor1)
        (content_at_location_at_workstation valve loc2 wor2)
        (content_at_location_at_workstation bolt loc3 wor3)
        (content_at_location_at_workstation tool loc4 wor4)
        (content_at_location_at_workstation valve loc5 wor5)
        (content_at_location_at_workstation bolt loc6 wor6)
    ))

    (:metric minimize (total-time))
)
