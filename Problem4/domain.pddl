(define (domain problem4)

    (:requirements :typing :numeric-fluents :durative-actions)

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

        (robot_is_attached ?r - robot)
        (robot_is_not_attached ?r - robot)
        (carrier_is_attached ?c - carrier)
        (carrier_is_not_attached ?c - carrier)
        (box_is_loaded ?b - box)
        (box_is_not_loaded ?b - box)
        (box_is_full ?b - box)
        (box_is_not_full ?b - box)
    )

    (:functions
        (carrier_capacity ?c - carrier)
    )
    
    (:durative-action move_walking
        :parameters (
            ?r - robot
            ?l1 - location
            ?l2 - location
        )
        :duration (= ?duration 2)
        :condition (and
            (over all (walks ?r))
            (at start (robot_at_location ?r ?l1))
            (over all (adjacent ?l1 ?l2))
        )
        :effect (and
            (at start (not (robot_at_location ?r ?l1)))
            (at end (robot_at_location ?r ?l2))
        )   
    )
        
    (:durative-action move_flying
        :parameters (
            ?r - robot
            ?l1 - location
            ?l2 - location
        )
        :duration (= ?duration 7)
        :condition (and
            (over all (flies ?r))
            (at start (robot_at_location ?r ?l1))
        )
        :effect (and
            (at start (not (robot_at_location ?r ?l1)))
            (at end (robot_at_location ?r ?l2))
        )
    )

    (:durative-action move_jumping
        :parameters (
            ?r - robot
            ?l1 - location
            ?l2 - location
            ?l3 - location
        )
        :duration (= ?duration 3)
        :condition (and
            (over all (jumps ?r))
            (at start (robot_at_location ?r ?l1))
            (over all (adjacent ?l1 ?l2))
            (over all (adjacent ?l2 ?l3))
        )
        :effect (and
            (at start (not (robot_at_location ?r ?l1)))
            (at end (robot_at_location ?r ?l3))
        )
    )

    (:durative-action robot_attach_carrier
        :parameters (
        )
        :duration (= ?duration )
        :condition (and
        )
        :effect (and
        )
    )
        
    (:durative-action robot_detach_carrier
        :parameters (
        )
        :duration (= ?duration )
        :condition (and
        )
        :effect (and
        )
    )

    (:durative-action robot_load_box
        :parameters (
        )
        :duration (= ?duration )
        :condition (and
        )
        :effect (and
        )
    )

    (:durative-action robot_unload_box
        :parameters (
        )
        :duration (= ?duration )
        :condition (and
        )
        :effect (and
        )
    )

    (:durative-action pick_up_content_at_cw
        :parameters (
        )
        :duration (= ?duration )
        :condition (and
        )
        :effect (and
        )
    )

    (:durative-action put_down_content_at_cw
        :parameters (
        )
        :duration (= ?duration )
        :condition (and
        )
        :effect (and
        )
    )

    (:durative-action pick_up_content
        :parameters (
        )
        :duration (= ?duration )
        :condition (and
        )
        :effect (and
        )
    )

    (:durative-action put_down_content
        :parameters (
        )
        :duration (= ?duration )
        :condition (and
        )
        :effect (and
        )
    )
)