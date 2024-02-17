(define (problem testing)
    (:domain problem2)

    (:objects
        walker drone jumper - robot
        loc1 loc2 loc3 loc4 - location
    )

    (:init
        (walks walker)
        (flies drone)
        (jumps jumper)

        (adjacent central_warehouse loc1)
        (adjacent loc1 central_warehouse)
        (adjacent loc1 loc2)
        (adjacent loc2 loc1)
        (adjacent loc2 loc3)
        (adjacent loc3 loc2)
        (adjacent loc3 loc4)
        (adjacent loc4 loc3)

        (robot_at_location walker central_warehouse)
        (robot_at_location drone central_warehouse)
        (robot_at_location jumper central_warehouse)
    )

    (:goal
        (and
            (robot_at_location walker loc3)
            (robot_at_location drone loc3)
            (robot_at_location jumper loc4)
        )
    )
)
