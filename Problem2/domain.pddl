(define (domain problem2)

    (:requirements :strips :typing :numeric-fluents)

    (:types
        robot
        location
        carrier
        box
    )

    (:constants
        central_warehouse - location
    )

    (:functions
        ; starts at N, decreases by 1 with each box loaded, full when 0
        (capacity ?c - carrier)
    )

    (:predicates
        (adjacent ?l1 - location ?l2 - location)
        
        (walks ?r - robot)
        (flies ?r - robot)
        (jumps ?r - robot)

        (robot_at_location ?r - robot ?l - location)
        (carrier_at_location ?c - carrier ?l - location)
        (box_at_location ?b - box ?l - location)


        (robot_has_carrier ?r - robot ?c - carrier)
        (carrier_has_box ?c - carrier ?b - box)

        (robot_is_attached ?r - robot)
        (carrier_is_attached ?c - carrier)
        (box_is_loaded ?b - box)
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

    (:action robot_attach_carrier
        :parameters (
            ?r - robot
            ?c - carrier
            ?l - location
        )
        :precondition(and
            (robot_at_location ?r ?l)
            (carrier_at_location ?c ?l)
            (not(robot_has_carrier ?r ?c))
            (not(robot_is_attached ?r))
            (not(carrier_is_attached ?c))
        )
        :effect(and
            (robot_has_carrier ?r ?c)
            (robot_is_attached ?r)
            (carrier_is_attached ?c)
            (not (carrier_at_location ?c ?l))
        )
    )

    (:action robot_detach_carrier
        :parameters (
            ?r - robot
            ?c - carrier
            ?l - location
        )
        :precondition(and
            (robot_at_location ?r ?l)
            (robot_has_carrier ?r ?c)
            (robot_is_attached ?r)
            (carrier_is_attached ?c)
        )
        :effect(and
            (not(robot_has_carrier ?r ?c))
            (not(robot_is_attached ?r))
            (not(carrier_is_attached ?c))
            (carrier_at_location ?c ?l)
        )
    )

    (:action robot_load_carrier
        :parameters (
            ?r - robot
            ?c - carrier
            ?l - location
            ?b - box
        )
        :precondition (and 
            (robot_at_location ?r ?l)
            (carrier_at_location ?c ?l)
            (robot_has_carrier ?r ?c)
            (robot_is_attached ?r)
            (carrier_is_attached ?c)
            (box_at_location ?b ?l)
            (not (box_is_loaded ?b))
            (> (capacity ?c) 0)
        )
        :effect(and
            (carrier_has_box ?c ?b)
            (box_is_loaded ?b)
            (decrease (capacity ?c) 1)
            (not (box_at_location ?b ?l))
        )
    )
)