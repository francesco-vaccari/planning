(define (problem testing) 
    (:domain problem5)

    (:objects
        loc1 loc2 loc3 loc4 loc5 - location
        wor1_1 wor1_2 wor2_1 wor3_1 wor4_1 wor5_1 - workstation
        ; walker jumper drone - robot
        walker - robot
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
        (adjacent loc3 loc4)
        (adjacent loc4 loc3)
        (adjacent loc4 loc5)
        (adjacent loc5 loc4)

        (workstation_at_location wor1_1 loc1)
        (workstation_at_location wor1_2 loc1)
        (workstation_at_location wor2_1 loc2)
        (workstation_at_location wor3_1 loc3)
        (workstation_at_location wor4_1 loc4)
        (workstation_at_location wor5_1 loc5)

        (walks walker)
        ; (jumps jumper)
        ; (flies drone)

        (mutex_load_box walker)
        ; (mutex_load_box jumper)
        ; (mutex_load_box drone)

        (robot_at_location walker central_warehouse)
        ; (robot_at_location jumper central_warehouse)
        ; (robot_at_location drone central_warehouse)

        (carrier_at_location carrier1 central_warehouse)
        (carrier_at_location carrier2 central_warehouse)
        (carrier_at_location carrier3 central_warehouse)
        (carrier_capacity carrier1 one)
        (carrier_capacity carrier2 two)
        (carrier_capacity carrier3 three)

        (box_at_location box1 central_warehouse)
        (box_at_location box2 central_warehouse)
        (box_at_location box3 central_warehouse)


        (robot_is_not_attached walker)
        ; (robot_is_not_attached jumper)
        ; (robot_is_not_attached drone)

        (carrier_is_not_attached carrier1)
        (carrier_is_not_attached carrier2)
        (carrier_is_not_attached carrier3)

        (box_is_not_loaded box1)
        (box_is_not_loaded box2)
        (box_is_not_loaded box3)

        (box_is_not_full box1)
        (box_is_not_full box2)
        (box_is_not_full box3)

        (content_at_cw tool)
        (content_at_cw valve)
        (content_at_cw bolt)
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

    (:goal (and
        ; (content_at_location_at_workstation tool loc2 wor2_1)
        ; (content_at_location_at_workstation valve loc2 wor2_1)
        ; (content_at_location_at_workstation bolt loc5 wor5_1)
        (box_at_location box1 loc1)
        (box_at_location box2 loc1)
        (box_at_location box3 loc1)
    ))

    (:metric minimize (total-time))
)