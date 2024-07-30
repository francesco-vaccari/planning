(define (problem problem_3)
    (:domain problem1)

    (:objects
        loc1 loc2 loc3 loc4 loc5 loc6 loc7 loc8 loc9 loc10 loc11 loc12 loc13 loc14 loc15 loc16 - location
        rob1 - robot
        box1 box2 - box
        wor1_1 wor2_1 wor3_1 wor4_1 wor5_1 wor6_1 wor7_1 wor8_1 wor9_1 wor10_1 wor11_1 wor12_1 wor13_1 wor14_1 wor15_1 wor16_1 - workstation
        tool valve bolt nut screw gears - content
    )

    (:init
        ; central_warehouse is adjacent to locations 1,2,3,4
        ; location 1 is adjacent to central_warehouse, 5,6,7
        ; location 2 is adjacent to central_warehouse, 8,9,10
        ; location 3 is adjacent to central_warehouse, 11,12,13
        ; location 4 is adjacent to central_warehouse, 14,15,16
        (adjacent central_warehouse loc1)
        (adjacent loc1 central_warehouse)
        (adjacent central_warehouse loc2)
        (adjacent loc2 central_warehouse)
        (adjacent central_warehouse loc3)
        (adjacent loc3 central_warehouse)
        (adjacent central_warehouse loc4)
        (adjacent loc4 central_warehouse)
        (adjacent loc1 loc5)
        (adjacent loc5 loc1)
        (adjacent loc1 loc6)
        (adjacent loc6 loc1)
        (adjacent loc1 loc7)
        (adjacent loc7 loc1)
        (adjacent loc2 loc8)
        (adjacent loc8 loc2)
        (adjacent loc2 loc9)
        (adjacent loc9 loc2)
        (adjacent loc2 loc10)
        (adjacent loc10 loc2)
        (adjacent loc3 loc11)
        (adjacent loc11 loc3)
        (adjacent loc3 loc12)
        (adjacent loc12 loc3)
        (adjacent loc3 loc13)
        (adjacent loc13 loc3)
        (adjacent loc4 loc14)
        (adjacent loc14 loc4)
        (adjacent loc4 loc15)
        (adjacent loc15 loc4)
        (adjacent loc4 loc16)
        (adjacent loc16 loc4)


        (robot_at_location rob1 central_warehouse)
        (box_at_location box1 central_warehouse)
        (box_at_location box2 central_warehouse)

        (content_at_cw tool)
        (content_at_cw valve)
        (content_at_cw bolt)
        (content_at_cw nut)
        (content_at_cw screw)
        (content_at_cw gears)

        (workstation_at_location wor1_1 loc1)
        (workstation_at_location wor2_1 loc2)
        (workstation_at_location wor3_1 loc3)
        (workstation_at_location wor4_1 loc4)
        (workstation_at_location wor5_1 loc5)
        (workstation_at_location wor6_1 loc6)
        (workstation_at_location wor7_1 loc7)
        (workstation_at_location wor8_1 loc8)
        (workstation_at_location wor9_1 loc9)
        (workstation_at_location wor10_1 loc10)
        (workstation_at_location wor11_1 loc11)
        (workstation_at_location wor12_1 loc12)
        (workstation_at_location wor13_1 loc13)
        (workstation_at_location wor14_1 loc14)
        (workstation_at_location wor15_1 loc15)
        (workstation_at_location wor16_1 loc16)
    )

    (:goal
        (and
            (content_at_workstation_at_location tool wor1_1 loc1)
            (content_at_workstation_at_location valve wor2_1 loc2)
            (content_at_workstation_at_location bolt wor3_1 loc3)
            (content_at_workstation_at_location nut wor4_1 loc4)
            (content_at_workstation_at_location screw wor5_1 loc5)
            (content_at_workstation_at_location gears wor6_1 loc6)
            (content_at_workstation_at_location tool wor7_1 loc7)
            (content_at_workstation_at_location valve wor8_1 loc8)
            (content_at_workstation_at_location bolt wor9_1 loc9)
            (content_at_workstation_at_location nut wor10_1 loc10)
            (content_at_workstation_at_location screw wor11_1 loc11)
            (content_at_workstation_at_location gears wor12_1 loc12)
            (content_at_workstation_at_location tool wor13_1 loc13)
            (content_at_workstation_at_location valve wor14_1 loc14)
            (content_at_workstation_at_location bolt wor15_1 loc15)
            (content_at_workstation_at_location nut wor16_1 loc16)
        )
    )
)
