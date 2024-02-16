(define (problem testing)
    (:domain problem1)

    (:objects
        loc1 loc2 loc3 loc4 loc5 loc6 loc7 - location
        wor1 wor2_1 wor2_2 wor3 wor4_1 wor4_2 wor4_3 wor5 wor6_1 wor6_2 wor7 - workstation
        box1 box2 - box
        rob1 rob2 - robot
        tool1 tool2 valve1 valve2 bolt1 bolt2 - content
    )

    (:init
        (wor_at_loc central_warehouse_contents central_warehouse)
        (adjacent central_warehouse loc1)
        (adjacent loc1 central_warehouse)
        (adjacent loc1 loc2)
        (adjacent loc2 loc1)
        (adjacent loc1 loc3)
        (adjacent loc3 loc1)
        (adjacent loc2 loc4)
        (adjacent loc4 loc2)
        (adjacent loc2 loc5)
        (adjacent loc5 loc2)
        (adjacent loc3 loc6)
        (adjacent loc6 loc3)
        (adjacent loc3 loc7)
        (adjacent loc7 loc3)

        (wor_at_loc wor1 loc1)
        (wor_at_loc wor2_1 loc2)
        (wor_at_loc wor2_2 loc2)
        (wor_at_loc wor3 loc3)
        (wor_at_loc wor4_1 loc4)
        (wor_at_loc wor4_2 loc4)
        (wor_at_loc wor4_3 loc4)
        (wor_at_loc wor5 loc5)
        (wor_at_loc wor6_1 loc6)
        (wor_at_loc wor6_2 loc6)
        (wor_at_loc wor7 loc7)

        (box_at_loc box1 central_warehouse)
        (box_at_loc box2 central_warehouse)

        (rob_at_loc rob1 central_warehouse)
        (rob_at_loc rob2 central_warehouse)

        (con_at_loc_wor tool1 central_warehouse central_warehouse_contents)
        (con_at_loc_wor tool2 central_warehouse central_warehouse_contents)
        (con_at_loc_wor valve1 central_warehouse central_warehouse_contents)
        (con_at_loc_wor valve2 central_warehouse central_warehouse_contents)
        (con_at_loc_wor bolt1 central_warehouse central_warehouse_contents)
        (con_at_loc_wor bolt2 central_warehouse central_warehouse_contents)
    )

    (:goal
        (and
            (con_at_loc_wor tool2 loc2 wor2_1)
            (con_at_loc_wor tool1 loc4 wor4_2)
            (con_at_loc_wor valve1 loc4 wor4_2)
            (con_at_loc_wor valve2 loc4 wor4_3)
            (con_at_loc_wor bolt1 loc7 wor7)
            (con_at_loc_wor bolt2 loc5 wor5)
        )
    )
)
