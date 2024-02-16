(define (domain problem1)

    (:requirements :strips :typing :disjunctive-preconditions :equality :quantified-preconditions :conditional-effects)

    (:types
        robot - object
        box - object
        location - object
        workstation - object
        content - object
    )

    (:constants
        central_warehouse - location
        central_warehouse_contents - workstation
    )

    (:predicates
        (rob_at_loc ?r - robot ?l - location)
        (box_at_loc ?b - box ?l - location)
        (wor_at_loc ?w - workstation ?l - location)
        (con_at_loc_wor ?c - content ?l - location ?w - workstation)
        (adjacent ?l1 - location ?l2 - location)
        (carries ?r - robot ?b - box)
        (contains ?b - box ?c - content)
        (is_being_carried ?b - box)
        (is_carrying ?r - robot)
        (is_full ?b - box)
        (is_in_box ?c - content)
    )

    (:action pick_up
        :parameters (
            ?r - robot
            ?b - box
            ?l - location
        )
        :precondition (and
            (rob_at_loc ?r ?l)
            (box_at_loc ?b ?l)
            (not (is_being_carried ?b))
            (not (is_carrying ?r))
        )
        :effect (and
            (carries ?r ?b)
            (is_being_carried ?b)
            (is_carrying ?r)
            (not (box_at_loc ?b ?l))
        )
    )

    (:action put_down
        :parameters (
            ?r - robot
            ?b - box
            ?l - location
        )
        :precondition (and
            (rob_at_loc ?r ?l)
            (carries ?r ?b)
            (is_carrying ?r)
        )
        :effect (and
            (not (carries ?r ?b))
            (not (is_being_carried ?b))
            (not (is_carrying ?r))
            (box_at_loc ?b ?l)
        )
    )

    (:action move
        :parameters (
            ?r - robot
            ?l1 - location
            ?l2 - location
        )
        :precondition (and
            (rob_at_loc ?r ?l1)
            (adjacent ?l1 ?l2)
        )
        :effect (and
            (rob_at_loc ?r ?l2)
            (not (rob_at_loc ?r ?l1))
        )
    )

    (:action fill_box
        :parameters (
            ?r - robot
            ?b - box
            ?c - content
            ?l - location
            ?w - workstation
        )
        :precondition (and
            (rob_at_loc ?r ?l)
            (wor_at_loc ?w ?l)
            (con_at_loc_wor ?c ?l ?w)
            (carries ?r ?b)
            (is_carrying ?r)
            (is_being_carried ?b)
            (not (is_full ?b))
            (not (is_in_box ?c))
        )
        :effect (and
            (contains ?b ?c)
            (is_full ?b)
            (is_in_box ?c)
            (not (con_at_loc_wor ?c ?l ?w))
        )
    )

    (:action empty_box
        :parameters (
            ?r - robot
            ?b - box
            ?c - content
            ?l - location
            ?w - workstation
        )
        :precondition (and
            (rob_at_loc ?r ?l)
            (wor_at_loc ?w ?l)
            (carries ?r ?b)
            (is_carrying ?r)
            (is_being_carried ?b)
            (contains ?b ?c)
            (is_in_box ?c)
        )
        :effect (and
            (not (is_full ?b))
            (not (contains ?b ?c))
            (not (is_in_box ?c))
            (con_at_loc_wor ?c ?l ?w)
        )
    )
)