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

        (robot_is_not_attached ?r - robot)
        (carrier_is_not_attached ?c - carrier)
        (box_is_not_loaded ?b - box)
        (box_is_not_full ?b - box)

        (mutex_load_box ?r - robot)
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
        :duration (= ?duration 20)
        :condition (and
            (at start (walks ?r))
            (at start(adjacent ?l1 ?l2))
            (at start (robot_at_location ?r ?l1))
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
        :duration (= ?duration 70)
        :condition (and
            (at start (flies ?r))
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
        :duration (= ?duration 30)
        :condition (and
            (at start (jumps ?r))
            (at start (adjacent ?l1 ?l2))
            (at start (adjacent ?l2 ?l3))
            (at start (robot_at_location ?r ?l1))
        )
        :effect (and
            (at start (not (robot_at_location ?r ?l1)))
            (at end (robot_at_location ?r ?l3))
        )
    )

    (:durative-action robot_attach_carrier
        :parameters (
            ?r - robot
            ?c - carrier
            ?l - location
        )
        :duration (= ?duration 3)
        :condition (and
            (at start (robot_at_location ?r ?l))
            (over all (robot_at_location ?r ?l))
            (at end (robot_at_location ?r ?l))

            (at start (carrier_at_location ?c ?l))

            (at start (robot_is_not_attached ?r))
            (at start (carrier_is_not_attached ?c))
        )
        :effect (and
            (at start (not (robot_is_not_attached ?r)))
            (at start (not (carrier_is_not_attached ?c)))

            (at end (robot_has_carrier ?r ?c))
            (at start (not (carrier_at_location ?c ?l)))
        )
    )
        
    (:durative-action robot_detach_carrier
        :parameters (
            ?r - robot
            ?c - carrier
            ?l - location
        )
        :duration (= ?duration 3)
        :condition (and
            (at start (robot_at_location ?r ?l))
            (over all (robot_at_location ?r ?l))
            (at end (robot_at_location ?r ?l))

            (at start (robot_has_carrier ?r ?c))
        )
        :effect (and
            (at end (robot_is_not_attached ?r))
            (at end (carrier_is_not_attached ?c))

            (at start (not (robot_has_carrier ?r ?c)))
            (at end (carrier_at_location ?c ?l))
        )
    )

    (:durative-action robot_load_box
        :parameters (
            ?r - robot
            ?c - carrier
            ?b - box
            ?l - location
        )
        :duration (= ?duration 2)
        :condition (and
            (at start (robot_at_location ?r ?l))
            (over all (robot_at_location ?r ?l))
            (at end (robot_at_location ?r ?l))
            
            (at start (robot_has_carrier ?r ?c))
            (over all (robot_has_carrier ?r ?c))
            (at end (robot_has_carrier ?r ?c))

            (at start (box_at_location ?b ?l))

            (at start (> (carrier_capacity ?c) 0))
            (at start (box_is_not_loaded ?b))

            (at start (mutex_load_box ?r))
        )
        :effect (and
            (at end (carrier_has_box ?c ?b))
            (at start (not (box_at_location ?b ?l)))

            (at start (decrease (carrier_capacity ?c) 1))
            (at start (not (box_is_not_loaded ?b)))

            (at start (not (mutex_load_box ?r)))
            (at end (mutex_load_box ?r))
        )
    )

    (:durative-action robot_unload_box
        :parameters (
            ?r - robot
            ?c - carrier
            ?b - box
            ?l - location
        )
        :duration (= ?duration 2)
        :condition (and
            (at start (robot_at_location ?r ?l))
            (over all (robot_at_location ?r ?l))
            (at end (robot_at_location ?r ?l))

            (at start (robot_has_carrier ?r ?c))
            (over all (robot_has_carrier ?r ?c))
            (at end (robot_has_carrier ?r ?c))

            (at start (carrier_has_box ?c ?b))

            (at start (mutex_load_box ?r))
        )
        :effect (and
            (at start (not (carrier_has_box ?c ?b)))
            (at end (box_at_location ?b ?l))

            (at end (increase (carrier_capacity ?c) 1))
            (at end (box_is_not_loaded ?b))

            (at start (not (mutex_load_box ?r)))
            (at end (mutex_load_box ?r))
        )
    )

    (:durative-action pick_up_content_at_cw
        :parameters (
            ?r - robot
            ?car - carrier
            ?b - box
            ?con - content
        )
        :duration (= ?duration 1)
        :condition (and
            (at start (robot_at_location ?r central_warehouse))
            (over all (robot_at_location ?r central_warehouse))
            (at end (robot_at_location ?r central_warehouse))

            (at start (robot_has_carrier ?r ?car))
            (over all (robot_has_carrier ?r ?car))
            (at end (robot_has_carrier ?r ?car))

            (at start (carrier_has_box ?car ?b))
            (over all (carrier_has_box ?car ?b))
            (at end (carrier_has_box ?car ?b))

            (at start (box_is_not_full ?b))

            (at start (content_at_cw ?con))
        )
        :effect (and
            (at start (not (box_is_not_full ?b)))
            (at end (box_has_content ?b ?con))
        )
    )

    (:durative-action put_down_content_at_cw
        :parameters (
            ?r - robot
            ?car - carrier
            ?b - box
            ?con - content
        )
        :duration (= ?duration 1)
        :condition (and
            (at start (robot_at_location ?r central_warehouse))
            (over all (robot_at_location ?r central_warehouse))
            (at end (robot_at_location ?r central_warehouse))

            (at start (robot_has_carrier ?r ?car))
            (over all (robot_has_carrier ?r ?car))
            (at end (robot_has_carrier ?r ?car))

            (at start (carrier_has_box ?car ?b))
            (over all (carrier_has_box ?car ?b))
            (at end (carrier_has_box ?car ?b))

            (at start (content_at_cw ?con))

            (at start (box_has_content ?b ?con))
        )
        :effect (and
            (at end (box_is_not_full ?b))
            (at start (not (box_has_content ?b ?con)))
        )
    )

    (:durative-action pick_up_content
        :parameters (
            ?r - robot
            ?car - carrier
            ?b - box
            ?l - location
            ?con - content
            ?w - workstation
        )
        :duration (= ?duration 1)
        :condition (and
            (at start (robot_at_location ?r central_warehouse))
            (over all (robot_at_location ?r central_warehouse))
            (at end (robot_at_location ?r central_warehouse))

            (at start (robot_has_carrier ?r ?car))
            (over all (robot_has_carrier ?r ?car))
            (at end (robot_has_carrier ?r ?car))

            (at start (carrier_has_box ?car ?b))
            (over all (carrier_has_box ?car ?b))
            (at end (carrier_has_box ?car ?b))

            (at start (box_is_not_full ?b))

            (at start (content_at_location_at_workstation ?con ?l ?w))
        )
        :effect (and
            (at start (not (box_is_not_full ?b)))
            (at end (box_has_content ?b ?con))
            (at start (not (content_at_location_at_workstation ?con ?l ?w)))
        )
    )

    (:durative-action put_down_content
        :parameters (
            ?r - robot
            ?car - carrier
            ?b - box
            ?l - location
            ?con - content
            ?w - workstation
        )
        :duration (= ?duration 1)
        :condition (and
            (at start (robot_at_location ?r ?l))
            (over all (robot_at_location ?r ?l))
            (at end (robot_at_location ?r ?l))

            (at start (robot_has_carrier ?r ?car))
            (over all (robot_has_carrier ?r ?car))
            (at end (robot_has_carrier ?r ?car))

            (at start (carrier_has_box ?car ?b))
            (over all (carrier_has_box ?car ?b))
            (at end (carrier_has_box ?car ?b))

            (at start (workstation_at_location ?w ?l))

            (at start (box_has_content ?b ?con))
        )
        :effect (and
            (at end (box_is_not_full ?b))
            (at start (not (box_has_content ?b ?con)))
            (at end (content_at_location_at_workstation ?con ?l ?w))
        )
    )
)