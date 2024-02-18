(define (problem testing)
    (:domain problem2)

    (:objects
        walker drone jumper - robot
        loc1 loc2 - location
        carrier1 carrier2 carrier3 - carrier
        box1 box2 box3 box4 box5 box6 - box
    )

    (:init
        (walks walker)
        (flies drone)
        (jumps jumper)

        (adjacent central_warehouse loc1)
        (adjacent loc1 central_warehouse)
        (adjacent loc1 loc2)
        (adjacent loc2 loc1)

        (robot_at_location walker central_warehouse)
        (robot_at_location drone central_warehouse)
        (robot_at_location jumper central_warehouse)

        (= (capacity carrier1) 1)
        (= (capacity carrier2) 2)
        (= (capacity carrier3) 3)
        (carrier_at_location carrier1 central_warehouse)
        (carrier_at_location carrier2 central_warehouse)
        (carrier_at_location carrier3 central_warehouse)

        (box_at_location box1 central_warehouse)
        (box_at_location box2 central_warehouse)
        (box_at_location box3 central_warehouse)
        (box_at_location box4 central_warehouse)
        (box_at_location box5 central_warehouse)
        (box_at_location box6 central_warehouse)
    )
    
    (:goal
        (and
            ; (robot_at_location walker loc2)
            ; (robot_at_location drone loc2)
            ; (robot_at_location jumper loc2)
            (carrier_at_location carrier1 loc2)
            ; (carrier_at_location carrier2 loc1)
            ; (carrier_at_location carrier3 loc2)
            (carrier_has_box carrier1 box1)
        )
    )
)
