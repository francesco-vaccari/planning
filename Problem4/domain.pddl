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
        :duration (= ?duration 5)
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
            ?r - robot
            ?c - carrier
            ?l - location
        )
        :duration (= ?duration 1)
        :condition (and
            (over all (robot_at_location ?r ?l))
            (over all (carrier_at_location ?c ?l))
            (at start (robot_is_not_attached ?r))
            (at start (carrier_is_not_attached ?c))
        )
        :effect (and
            (at end (robot_has_carrier ?r ?c))
            (at end (robot_is_attached ?r))
            (at end (not (robot_is_not_attached ?r)))
            (at end (carrier_is_attached ?c))
            (at end (not (carrier_is_not_attached ?c)))
            (at end (not (carrier_at_location ?c ?l)))
        )
    )
        
    (:durative-action robot_detach_carrier
        :parameters (
            ?r - robot
            ?c - carrier
            ?l - location
        )
        :duration (= ?duration 1)
        :condition (and
            (over all (robot_at_location ?r ?l))
            (over all (robot_has_carrier ?r ?c))
            (at start (robot_is_attached ?r))
            (at start (carrier_is_attached ?c))
        )
        :effect (and
            (at end (not (robot_has_carrier ?r ?c)))
            (at end (not (robot_is_attached ?r)))
            (at end (robot_is_not_attached ?r))
            (at end (not (carrier_is_attached ?c)))
            (at end (carrier_is_not_attached ?c))
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
        :duration (= ?duration 0.5)
        :condition (and 
            (over all (robot_at_location ?r ?l))
            (over all (robot_has_carrier ?r ?c))
            (over all (carrier_is_attached ?c))
            (over all (box_at_location ?b ?l))
            (at start (box_is_not_loaded ?b))
            (at start (> (carrier_capacity ?c) 0))
        )
        :effect (and 
            (at end (box_is_loaded ?b))
            (at end (not (box_is_not_loaded ?b)))
            (at end (carrier_has_box ?c ?b))
            (at end (not (box_at_location ?b ?l)))
            (at end (decrease (carrier_capacity ?c) 1))
        )
    )

    (:durative-action robot_unload_box
        :parameters (
            ?r - robot
            ?c - carrier
            ?b - box
            ?l - location
        )
        :duration (= ?duration 0.5)
        :condition (and 
            (over all (robot_at_location ?r ?l))
            (over all (robot_has_carrier ?r ?c))
            (over all (carrier_is_attached ?c))
            (at start (box_is_loaded ?b))
            (at start (carrier_has_box ?c ?b))
        )
        :effect (and 
            (at end (not (box_is_loaded ?b)))
            (at end (box_is_not_loaded ?b))
            (at end (not (carrier_has_box ?c ?b)))
            (at end (box_at_location ?b ?l))
            (at end (increase (carrier_capacity ?c) 1))
        )
    )

    (:durative-action pick_up_content_at_cw
        :parameters (
            ?r - robot
            ?con - content
            ?car - carrier
            ?b - box
        )
        :duration (= ?duration 0.3)
        :condition (and 
            (over all (robot_at_location ?r central_warehouse))
            (over all (content_at_cw ?con))
            (over all (robot_has_carrier ?r ?car))
            (over all (carrier_is_attached ?car))
            (over all (carrier_has_box ?car ?b))
            (over all (box_is_loaded ?b))
            (at start (box_is_not_full ?b))
        )
        :effect (and 
            (at end (box_has_content ?b ?con))
            (at end (box_is_full ?b))
            (at end (not (box_is_not_full ?b)))
        )
    )

    (:durative-action put_down_content_at_cw
        :parameters (
            ?r - robot
            ?con - content
            ?car - carrier
            ?b - box
        )
        :duration (= ?duration 0.3)
        :condition (and 
            (over all (robot_at_location ?r central_warehouse))
            (over all (content_at_cw ?con))
            (over all (robot_has_carrier ?r ?car))
            (over all (carrier_is_attached ?car))
            (over all (carrier_has_box ?car ?b))
            (over all (box_is_loaded ?b))
            (at start (box_has_content ?b ?con))
            (at start (box_is_full ?b))
        )
        :effect (and 
            (at end (not (box_has_content ?b ?con)))
            (at end (not (box_is_full ?b)))
            (at end (box_is_not_full ?b))
        )
    )

    (:durative-action pick_up_content
        :parameters (
            ?r - robot
            ?car - carrier
            ?b - box
            ?con - content
            ?l - location
            ?w - workstation
        )
        :duration (= ?duration 0.3)
        :condition (and
            (over all (robot_at_location ?r ?l))
            (over all (workstation_at_location ?w ?l))
            (over all (robot_has_carrier ?r ?car))
            (over all (robot_is_attached ?r))
            (over all (carrier_is_attached ?car))
            (over all (carrier_has_box ?car ?b))
            (over all (box_is_loaded ?b))
            (at start (box_is_not_full ?b))
            (at start (content_at_location_at_workstation ?con ?l ?w))
        )
        :effect (and
            (at end (box_has_content ?b ?con))
            (at end (box_is_full ?b))
            (at end (not (box_is_not_full ?b)))
            (at end (not (content_at_location_at_workstation ?con ?l ?w)))
        )
    )

    (:durative-action put_down_content
        :parameters (
            ?r - robot
            ?car - carrier
            ?b - box
            ?con - content
            ?l - location
            ?w - workstation
        )
        :duration (= ?duration 0.3)
        :condition (and
            (over all (robot_at_location ?r ?l))
            (over all (workstation_at_location ?w ?l))
            (over all (robot_has_carrier ?r ?car))
            (over all (robot_is_attached ?r))
            (over all (carrier_is_attached ?car))
            (over all (carrier_has_box ?car ?b))
            (over all (box_is_loaded ?b))
            (at start (box_has_content ?b ?con))
            (at start (box_is_full ?b))
        )
        :effect (and
            (at end (not (box_has_content ?b ?con)))
            (at end (not (box_is_full ?b)))
            (at end (box_is_not_full ?b))
            (at end (content_at_location_at_workstation ?con ?l ?w))
        )
    )
)