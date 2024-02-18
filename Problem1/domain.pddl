(define (domain problem1)

    (:requirements :strips :typing)

    (:types
        location
        workstation
        robot
        box
        content
    )

    (:constants
        central_warehouse - location
    )

    (:predicates
        (adjacent ?l1 - location ?l2 - location)
        (robot_at_location ?r - robot ?l - location)
        (box_at_location ?b - box ?l - location)
        (content_at_workstation_at_location ?c - content ?w - workstation ?l - location)
        (workstation_at_location ?w - workstation ?l - location)
        
        (box_has_content ?b - box ?c - content)
        (robot_has_box ?r - robot ?b - box)
        
        ; predicates for simpler preconditions and effects, and also redundancy
        (robot_is_carrying ?r - robot)
        (box_is_being_carried ?b - box)
        (box_is_full ?b - box)

        (content_at_cw ?c - content) ; to implement infinite content availability
    )

    (:action move
        :parameters (
            ?r - robot
            ?from - location
            ?to - location
        )
        :precondition (and
            (robot_at_location ?r ?from)
            (adjacent ?from ?to)
        )
        :effect (and
            (not (robot_at_location ?r ?from))
            (robot_at_location ?r ?to)
        )
    )

    (:action pick_up_box
        :parameters (
            ?r - robot
            ?b - box
            ?l - location
        )
        :precondition (and
            (robot_at_location ?r ?l)
            (box_at_location ?b ?l)
            (not (robot_is_carrying ?r))
            (not (box_is_being_carried ?b))
        )
        :effect (and
            (not (box_at_location ?b ?l))
            (robot_has_box ?r ?b)
            (box_is_being_carried ?b)
            (robot_is_carrying ?r)
        )
    )

    (:action put_down_box
        :parameters (
            ?r - robot
            ?b - box
            ?l - location
        )
        :precondition (and
            (robot_at_location ?r ?l)
            (robot_has_box ?r ?b)
            (box_is_being_carried ?b)
            (robot_is_carrying ?r)
        )
        :effect (and
            (not (robot_has_box ?r ?b))
            (box_at_location ?b ?l)
            (not (robot_is_carrying ?r))
            (not (box_is_being_carried ?b))
        )
    )

    (:action pick_up_content_at_cw
        :parameters (
            ?r - robot
            ?b - box
            ?c - content
        )
        :precondition (and
            (robot_at_location ?r central_warehouse)
            (robot_has_box ?r ?b)
            (robot_is_carrying ?r)
            (not (box_is_full ?b))
            (content_at_cw ?c)
        )
        :effect (and
            (box_has_content ?b ?c)
            (box_is_full ?b)
            ; content still remains at cw to implement infinite content availability
        )
    )

    (:action put_down_content_at_cw
        :parameters(
            ?r - robot
            ?b - box
            ?c - content
        )
        :precondition (and
            (robot_at_location ?r central_warehouse)
            (robot_has_box ?r ?b)
            (robot_is_carrying ?r)
            (box_is_full ?b)
            (box_has_content ?b ?c)
        )
        :effect (and
            (not (box_has_content ?b ?c))
            (not (box_is_full ?b))
        )
    )

    (:action pick_up_content
        :parameters (
            ?r - robot
            ?b - box
            ?c - content
            ?l - location
            ?w - workstation
        )
        :precondition (and
            (robot_at_location ?r ?l)
            (robot_has_box ?r ?b)
            (robot_is_carrying ?r)
            (not (box_is_full ?b))
            (workstation_at_location ?w ?l)
            (content_at_workstation_at_location ?c ?w ?l)
        )
        :effect (and
            (box_has_content ?b ?c)
            (box_is_full ?b)
            (not (content_at_workstation_at_location ?c ?w ?l))
        )
    )

    (:action put_down_content
        :parameters (
            ?r - robot
            ?b - box
            ?c - content
            ?l - location
            ?w - workstation
        )
        :precondition (and
            (robot_at_location ?r ?l)
            (robot_has_box ?r ?b)
            (robot_is_carrying ?r)
            (box_is_full ?b)
            (workstation_at_location ?w ?l)
            (box_has_content ?b ?c)
        )
        :effect (and
            (content_at_workstation_at_location ?c ?w ?l)
            (not (box_has_content ?b ?c))
            (not (box_is_full ?b))
        )
    )
)