(define (domain problem2)

    (:requirements :strips :typing)

    (:types
        robot
        location
    )

    (:constants
        central_warehouse - location
    )

    (:predicates
        (walks ?r - robot)
        (flies ?r - robot)
        (jumps ?r - robot)

        (robot_at_location ?r - robot ?l - location)

        (adjacent ?l1 - location ?l2 - location)
    )

    (:action move_walking
        :parameters(
            ?r - robot
            ?from - location
            ?to - location
        )
        :precondition(and
            (walks ?r)
            (robot_at_location ?r ?from)
            (adjacent ?from ?to)
        )
        :effect(and
            (not(robot_at_location ?r ?from))
            (robot_at_location ?r ?to)
        )
    )

    (:action move_flying
        :parameters(
            ?r - robot
            ?from - location
            ?to - location
        )
        :precondition(and
            (flies ?r)
            (robot_at_location ?r ?from)
        )
        :effect(and
            (not(robot_at_location ?r ?from))
            (robot_at_location ?r ?to)
        )
    )

    (:action move_jumping
        :parameters(
            ?r - robot
            ?from - location
            ?half - location
            ?to - location
        )
        :precondition(and
            (jumps ?r)
            (robot_at_location ?r ?from)
            (adjacent ?from ?half)
            (adjacent ?half ?to)
            (not (robot_at_location ?r ?to))
        )
        :effect(and
            (not(robot_at_location ?r ?from))
            (robot_at_location ?r ?to)
        )
    )
)