(define (domain problem2)

    (:requirements :typing :numeric-fluents)

    (:types
        location
        workstation
        robot
        carrier
        box
        content
    )

    (:constants
        central_warehouse - location
    )

    (:predicates
        (adjacent ?l1 - location ?l2 - location)

        (walks ?r - robot)
        (jumps ?r - robot)
        (flies ?r - robot)

        (workstation_at_location ?w - workstation ?l - location)
        (robot_at_location ?r - robot ?l - location)
        (carrier_at_location ?c - carrier ?l - location)
        (box_at_location ?b - box ?l - location)
        (content_at_location_at_workstation ?c - content ?l - location ?w - workstation)
        (content_at_cw ?c - content)

        (robot_has_carrier ?r - robot ?c - carrier)
        (carrier_has_box ?c - carrier ?b - box)
        (box_has_content ?b - box ?c - content)

        (robot_is_not_attached ?r - robot)
        (carrier_is_not_attached ?c - carrier)
        (box_is_not_loaded ?b - box)
        (box_is_not_full ?b - box)
    )

    (:functions
        (carrier_capacity ?c - carrier)
    )

    (:action move_walking
        :parameters (
            ?r - robot
            ?l1 - location
            ?l2 - location
        )
        :precondition (and
            (walks ?r)
            (robot_at_location ?r ?l1)
            (adjacent ?l1 ?l2)
        )
        :effect (and
            (not (robot_at_location ?r ?l1))
            (robot_at_location ?r ?l2)
        )
    )

    (:action move_flying
        :parameters (
            ?r - robot
            ?l1 - location
            ?l2 - location
        )
        :precondition (and
            (flies ?r)
            (robot_at_location ?r ?l1)
        )
        :effect (and
            (not (robot_at_location ?r ?l1))
            (robot_at_location ?r ?l2)
        )
    )

    (:action move_jumping
        :parameters (
            ?r - robot
            ?l1 - location
            ?l2 - location
            ?l3 - location
        )
        :precondition (and
            (jumps ?r)
            (robot_at_location ?r ?l1)
            (adjacent ?l1 ?l2)
            (adjacent ?l2 ?l3)
        )
        :effect (and
            (not (robot_at_location ?r ?l1))
            (robot_at_location ?r ?l3)
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
            (robot_is_not_attached ?r)
            (carrier_is_not_attached ?c)
        )
        :effect(and
            (robot_has_carrier ?r ?c)
            (not (robot_is_not_attached ?r))
            (not (carrier_is_not_attached ?c))
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
        )
        :effect(and
            (not(robot_has_carrier ?r ?c))
            (robot_is_not_attached ?r)
            (carrier_is_not_attached ?c)
            (carrier_at_location ?c ?l)
        )
    )

    (:action robot_load_box
        :parameters (
            ?r - robot
            ?c - carrier
            ?b - box
            ?l - location
        )
        :precondition (and 
            (robot_at_location ?r ?l)
            (robot_has_carrier ?r ?c)
            (box_at_location ?b ?l)
            (box_is_not_loaded ?b)
            (> (carrier_capacity ?c) 0)
        )
        :effect (and
            (not (box_is_not_loaded ?b))
            (carrier_has_box ?c ?b)
            (not (box_at_location ?b ?l))
            (decrease (carrier_capacity ?c) 1)
        )
    )

    (:action robot_unload_box
        :parameters (
            ?r - robot
            ?c - carrier
            ?b - box
            ?l - location
        )
        :precondition (and 
            (robot_at_location ?r ?l)
            (robot_has_carrier ?r ?c)
            (carrier_has_box ?c ?b)
        )
        :effect (and
            (box_is_not_loaded ?b)
            (not (carrier_has_box ?c ?b))
            (box_at_location ?b ?l)
            (increase (carrier_capacity ?c) 1)
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
            (carrier_has_box ?car ?b)
            (box_is_not_full ?b)
        )
        :effect (and 
            (box_has_content ?b ?con)
            (not (box_is_not_full ?b))
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
            (carrier_has_box ?car ?b)
            (box_has_content ?b ?con)
        )
        :effect (and 
            (not (box_has_content ?b ?con))
            (box_is_not_full ?b)
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
            (carrier_has_box ?car ?b)
            (box_is_not_full ?b)
            (content_at_location_at_workstation ?con ?l ?w)
        )
        :effect (and
            (box_has_content ?b ?con)
            (not (box_is_not_full ?b))
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
            (carrier_has_box ?car ?b)
            (box_has_content ?b ?con)
        )
        :effect (and
            (not (box_has_content ?b ?con))
            (box_is_not_full ?b)
            (content_at_location_at_workstation ?con ?l ?w)
        )
    )
)