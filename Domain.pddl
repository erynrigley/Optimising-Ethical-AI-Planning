(define (domain autonomous_driver_domain)

(:requirements :typing :durative-actions :fluents :numeric-fluents)
    (:types
        locatable location lane - object
        driver others people - locatable
    )
    
    (:predicates
        (ground_connected ?from ?to - location
        (at ?l - location ?o - locatable)
        (on ?l - lane ?o - locatable)
        (not_on ?l - lane ?o - locatable)
        (driving ?c - driver)
        (no_crash ?wp - location)
        (clear ?via - location ?l - lane)
        
        ;;hard constraints
        (none_killed)
        (anyone_saved)
        (none_let_die)
        (none_as_means)
    )
    
    (:functions
        (distance ?from ?to - location)
        (speed ?c - driver)
        
        ;;soft constraints
        (any_killed)
        (any_let_die)
        (any_saved)
        (dead)
        (crash ?o - others ?l - lane)
        
        (young_killed ?o - others)
        (how_many_young_killed)
        
        (family_killed ?o - others)
        (how_many_family_killed)
    )
    
    (:durative-action drive
      :parameters (?c - driver ?from ?to ?via - location ?l - lane)
      :duration (= ?duration (/ (distance ?from ?to) (speed ?c)))
      :condition (and
        (at start (at ?from ?c))
        (over all (and 
        (ground_connected ?from ?via) (ground_connected ?via ?to)
        (no_crash ?via) (on ?l ?c)
        ))
      )
      :effect (and
        (at start (not (at ?from ?c)))
        (at end (at ?to ?c))
        )
    )
    
    (:durative-action hit
      :parameters (?c1 - driver ?o1 ?o2 - others ?from ?to ?via - location ?l1 ?l2 - lane)
      :duration (= ?duration (/(distance ?from ?to) (speed ?c1)))
      :condition (and
        (at start (at ?from ?c1))
        (at start (on ?l1 ?c1))
        (over all (and 
        (ground_connected ?from ?via) (ground_connected ?via ?to) 
        (on ?l2 ?o2) (on ?l1 ?o1)
        (at ?via ?o2) (at ?via ?o1)
        ))
      )
      :effect (and
        (at start (not (at ?from ?c1)))
        (at start (on ?l2 ?c1))
        (at end (not (on ?l1 ?c1)))
        (at end (at ?to ?c1))
        
        ;;soft constraints
        (at end (increase (any_killed) (crash ?o2 ?l2)))
        (at end (increase (dead) (crash ?o2 ?l2)))
        (at end (increase (any_saved) (crash ?o1 ?l1)))
        (at end (increase (how_many_young_killed) (young_killed ?o2)))
        (at end (increase (how_many_family_killed) (family_killed ?o2)))
        
        ;;hard constraints - someone is killed, people are saved, people are used as a means
        (at end (not (none_killed)))
        (at end (anyone_saved))
        (at end (not (none_as_means)))
        
        )
    )
    
    (:durative-action avoid
      :parameters (?c1 - driver ?o1 - others ?from ?to ?via - location ?l1 ?l2 - lane)
      :duration (= ?duration (/(distance ?from ?to) (speed ?c1)))
      :condition (and
        (at start (at ?from ?c1))
        (at start (on ?l1 ?c1))
        (at start (not_on ?l2 ?c1))
        (over all (and 
        (ground_connected ?from ?via) (ground_connected ?via ?to) 
        (at ?via ?o1) 
        (on ?l1 ?o1) 
        (not_on ?l2 ?o1)
        (clear ?via ?l2)
        ))
      )
      :effect (and
        (at start (not (at ?from ?c1)))
        (at start (on ?l2 ?c1))
        (at end (not (on ?l1 ?c1)))
        (at end (not_on ?l1 ?c1))
        (at end (at ?to ?c1))
        
        ;;soft constraints
        (at end (increase (any_saved) (crash ?o1 ?l1)))
        
        ;;hard constrains - someone is saved
        (at end (anyone_saved))
        
        )
    )
    
    (:durative-action do_nothing
      :parameters (?c1 - driver ?o1 - others ?from ?to ?via - location ?l1 - lane)
      :duration (= ?duration (/(distance ?from ?to) (speed ?c1)))
      :condition (and
        (at start (at ?from ?c1))
        (at start (on ?l1 ?c1))
        (over all (and 
        (ground_connected ?from ?via) (ground_connected ?via ?to) (at ?via ?o1) (on ?l1 ?o1)
        ))
      )
      :effect (and
        (at start (not (at ?from ?c1)))
        (at start (at ?to ?c1))
        
        ;;soft constraints
        (at end (increase (any_let_die) (crash ?o1 ?l1)))
        (at end (increase (dead) (crash ?o1 ?l1)))
        (at end (increase (how_many_young_killed) (young_killed ?o1)))
        (at end (increase (how_many_family_killed) (family_killed ?o1)))
        )
    )
    
    
)
  