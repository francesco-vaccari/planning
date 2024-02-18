(define (domain problem2)

    (:requirements :strips :typing)

    (:types
        location
        workstation
        robot
        carrier
        box
        content
        number
    )

    (:constants
        central_warehouse - location
        zero one two three four five six seven eight nine ten - number
    )

    (:predicates
        (adjacent ?l1 - location ?l2 - location)
        
        (walks ?r - robot)
        (flies ?r - robot)
        (jumps ?r - robot)

        (carrier_capacity ?c - carrier ?n - number)
        (increase_capacity ?n - number ?m - number)
        (decrease_capacity ?n - number ?m - number)

        (workstation_at_location ?w - workstation ?l - location)
        (robot_at_location ?r - robot ?l - location)
        (carrier_at_location ?c - carrier ?l - location)
        (box_at_location ?b - box ?l - location)
        (content_at_location_at_workstation ?c - content ?l - location ?w - workstation)
        (content_at_cw ?c - content)


        (robot_has_carrier ?r - robot ?c - carrier)
        (carrier_has_box ?c - carrier ?b - box)
        (box_has_content ?b - box ?c - content)

        (robot_is_attached ?r - robot)
        (carrier_is_attached ?c - carrier)
        (box_is_loaded ?b - box)
        (box_is_full ?b - box)
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
            ?b - box
            ?l - location
            ?n - number
            ?m - number
        )
        :precondition (and 
            (robot_at_location ?r ?l)
            (robot_has_carrier ?r ?c)
            (carrier_is_attached ?c)
            (box_at_location ?b ?l)
            (not (box_is_loaded ?b))
            (not (carrier_has_box ?c ?b))
            (carrier_capacity ?c ?n)
            (decrease_capacity ?n ?m)
        )
        :effect (and 
            (box_is_loaded ?b)
            (carrier_has_box ?c ?b)
            (not (box_at_location ?b ?l))
            (not (carrier_capacity ?c ?n))
            (carrier_capacity ?c ?m)
        )
    )

    (:action robot_unload_carrier
        :parameters (
            ?r - robot
            ?c - carrier
            ?b - box
            ?l - location
            ?n - number
            ?m - number
        )
        :precondition (and 
            (robot_at_location ?r ?l)
            (robot_has_carrier ?r ?c)
            (carrier_is_attached ?c)
            (box_is_loaded ?b)
            (carrier_has_box ?c ?b)
            (carrier_capacity ?c ?n)
            (increase_capacity ?n ?m)
        )
        :effect (and 
            (not (box_is_loaded ?b))
            (not (carrier_has_box ?c ?b))
            (box_at_location ?b ?l)
            (not (carrier_capacity ?c ?n))
            (carrier_capacity ?c ?m)
        )
    )

    (:action pick_up_content_at_cw
        :parameters (
            ?r - robot
            ?con - content
            ?car - carrier
            ?b - box
        )
        :precondition (and 
            (robot_at_location ?r central_warehouse)
            (content_at_cw ?con)
            (robot_has_carrier ?r ?car)
            (carrier_is_attached ?car)
            (carrier_has_box ?car ?b)
            (box_is_loaded ?b)
            (not (box_is_full ?b))
        )
        :effect (and 
            (box_has_content ?b ?con)
            (box_is_full ?b)
        )
    )

    (:action put_down_content_at_cw
        :parameters (
            ?r - robot
            ?con - content
            ?car - carrier
            ?b - box
        )
        :precondition (and 
            (robot_at_location ?r central_warehouse)
            (content_at_cw ?con)
            (robot_has_carrier ?r ?car)
            (carrier_is_attached ?car)
            (carrier_has_box ?car ?b)
            (box_is_loaded ?b)
            (box_has_content ?b ?con)
            (box_is_full ?b)
        )
        :effect (and 
            (not (box_has_content ?b ?con))
            (not (box_is_full ?b))
        )
    )

    (:action pick_up_content
        :parameters (
            ?r - robot
            ?car - carrier
            ?b - box
            ?con - content
            ?l - location
            ?w - workstation
        )
        :precondition (and
            (robot_at_location ?r ?l)
            (workstation_at_location ?w ?l)
            (robot_has_carrier ?r ?car)
            (robot_is_attached ?r)
            (carrier_is_attached ?car)
            (carrier_has_box ?car ?b)
            (box_is_loaded ?b)
            (not (box_is_full ?b))
            (content_at_location_at_workstation ?con ?l ?w)
        )
        :effect (and
            (box_has_content ?b ?con)
            (box_is_full ?b)
            (not (content_at_location_at_workstation ?con ?l ?w))
        )
    )

    (:action put_down_content
        :parameters (
            ?r - robot
            ?car - carrier
            ?b - box
            ?con - content
            ?l - location
            ?w - workstation
        )
        :precondition (and
            (robot_at_location ?r ?l)
            (workstation_at_location ?w ?l)
            (robot_has_carrier ?r ?car)
            (robot_is_attached ?r)
            (carrier_is_attached ?car)
            (carrier_has_box ?car ?b)
            (box_is_loaded ?b)
            (box_has_content ?b ?con)
            (box_is_full ?b)
        )
        :effect (and
            (not (box_has_content ?b ?con))
            (not (box_is_full ?b))
            (content_at_location_at_workstation ?con ?l ?w)
        )
    )
)