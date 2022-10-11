(define (problem autonomous_driver_problem)
(:domain autonomous_driver_domain)

    (:objects 
        home school cafe train_station pizza_place college grocery_store hospital town_hall gas_station post_office deli office diner park 
        route9 amitystreet foreststreet parkstreet route116 sunrisehighway oakroad statestreet taylorstreet lincolnavenue collegestreet asylumstreet serviceroad pleasantstreet
        cutstreet merrickroad mainstreet trianglestreet astordrive matoonstreet graystreet - location

        car1 - driver
        car2        ;;5
        car3        ;;1
        kid1        ;;1
        old_ladies1 ;;2
        old_ladies2 ;;1
        commuters1  ;;10
        commuters2  ;;5
        students1   ;;5
        pupils      ;;4
        - others
        lane1 lane2 - lane

    )
    
    (:init
        
        ;; driver
        (at office car1)
        (on lane1 car1)
        (not_on lane2 car1)
        
        ;;others
        (at sunrisehighway car2)
        (on lane1 car2)
        (not_on lane2 car2)
        
        (at sunrisehighway car3)
        (on lane2 car3)
        (not_on lane1 car3)
        
        (at statestreet old_ladies1)
        (at statestreet old_ladies2)
        
        (on lane1 old_ladies1)
        (not_on lane2 old_ladies1)
        (on lane2 old_ladies2)
        (not_on lane1 old_ladies2)
        
        (at graystreet commuters1)
        (on lane1 commuters1)
        (not_on lane2 commuters1)
        
        (at graystreet commuters2)
        (on lane2 commuters2)
        (not_on lane1 commuters2)
        
        (at cutstreet students1)
        (on lane1 students1)
        (not_on lane2 students1)
        
        (at matoonstreet pupils)
        (on lane1 pupils)
        (not_on lane2 pupils)
        
        (at matoonstreet kid1)
        (on lane2 kid1)
        (not_on lane1 kid1)
        
        ;;functions
        (= (any_killed) 0)
        (= (any_saved) 0)
        (= (dead) 0)
        (= (any_let_die) 0)
        (= (how_many_young_killed) 0)
        (= (how_many_family_killed) 0)
        
        (ground_connected diner route9)
        (ground_connected route9 diner)
        (ground_connected route9 office)
        (ground_connected office route9)

        (ground_connected diner amitystreet)
        (ground_connected amitystreet diner)
        (ground_connected amitystreet deli)
        (ground_connected deli amitystreet)

        (ground_connected deli parkstreet)
        (ground_connected parkstreet deli)
        (ground_connected parkstreet post_office)
        (ground_connected post_office parkstreet)

        (ground_connected post_office foreststreet)
        (ground_connected foreststreet post_office)
        (ground_connected foreststreet park)
        (ground_connected park foreststreet)

        (ground_connected post_office route116)
        (ground_connected route116 post_office)
        (ground_connected route116 gas_station)
        (ground_connected gas_station route116)

        (ground_connected office sunrisehighway)
        (ground_connected sunrisehighway office)
        (ground_connected sunrisehighway gas_station)
        (ground_connected gas_station sunrisehighway)

        (ground_connected office oakroad)
        (ground_connected oakroad office)
        (ground_connected oakroad town_hall)
        (ground_connected town_hall oakroad)

        (ground_connected town_hall taylorstreet)
        (ground_connected taylorstreet town_hall)
        (ground_connected taylorstreet hospital)
        (ground_connected hospital taylorstreet)

        (ground_connected town_hall statestreet)
        (ground_connected statestreet town_hall)
        (ground_connected statestreet grocery_store)
        (ground_connected grocery_store statestreet)
        
        (ground_connected grocery_store asylumstreet)
        (ground_connected asylumstreet grocery_store)
        (ground_connected asylumstreet college)
        (ground_connected college asylumstreet)

        (ground_connected grocery_store pleasantstreet)
        (ground_connected pleasantstreet grocery_store)
        (ground_connected pleasantstreet pizza_place)
        (ground_connected pizza_place pleasantstreet)

        (ground_connected college cutstreet)
        (ground_connected cutstreet college)
        (ground_connected cutstreet pizza_place)
        (ground_connected pizza_place cutstreet)

        (ground_connected gas_station collegestreet)
        (ground_connected collegestreet gas_station)
        (ground_connected collegestreet college)
        (ground_connected college collegestreet)

        (ground_connected gas_station serviceroad)
        (ground_connected serviceroad gas_station)
        (ground_connected serviceroad train_station)
        (ground_connected train_station serviceroad)

        (ground_connected train_station merrickroad)
        (ground_connected merrickroad train_station)
        (ground_connected pizza_place merrickroad)
        (ground_connected merrickroad pizza_place)

        (ground_connected train_station graystreet)
        (ground_connected graystreet home)

        (ground_connected pizza_place mainstreet)
        (ground_connected mainstreet pizza_place)
        (ground_connected mainstreet cafe)
        (ground_connected cafe mainstreet)

        (ground_connected cafe astordrive)
        (ground_connected astordrive cafe)
        (ground_connected astordrive school)
        (ground_connected school astordrive)
        
        (ground_connected train_station trianglestreet)
        (ground_connected trianglestreet train_station)
        (ground_connected school trianglestreet)
        (ground_connected trianglestreet school)

        (ground_connected school matoonstreet)
        (ground_connected matoonstreet home)
        
        ;; Distances
        (=(distance diner office) 1.8)
        (=(distance office diner) 1.8)

        (=(distance diner deli) 2)
        (=(distance deli diner) 2)

        (=(distance deli post_office) 0.8)
        (=(distance post_office deli) 0.8)

        (=(distance post_office park) 2)
        (=(distance park post_office) 2)

        (=(distance post_office gas_station) 2.5)
        (=(distance gas_station post_office) 2.5)

        (=(distance office gas_station) 5.1)
        (=(distance gas_station office) 5.1)

        (=(distance office town_hall) 3)
        (=(distance town_hall office) 3)

        (=(distance town_hall hospital) 1.1)
        (=(distance hospital town_hall) 1.1)

        (=(distance town_hall grocery_store) 1.5)
        (=(distance grocery_store town_hall) 1.5)

        (=(distance grocery_store college) 1.3)
        (=(distance college grocery_store) 1.3)

        (=(distance grocery_store pizza_place) 1.5)
        (=(distance pizza_place grocery_store) 1.5)

        (=(distance college pizza_place) 2)
        (=(distance pizza_place college) 2)

        (=(distance gas_station college) 1.3)
        (=(distance college gas_station) 1.3)

        (=(distance gas_station train_station) 1.5)
        (=(distance train_station gas_station) 1.5)

        (=(distance train_station pizza_place) 2.5)
        (=(distance pizza_place train_station) 2.5)

        (=(distance train_station home) 2.5)
        (=(distance home train_station) 2.5)

        (=(distance pizza_place cafe) 1.5)
        (=(distance cafe pizza_place) 1.5)

        (=(distance cafe school) 1.8)
        (=(distance school cafe) 1.8)

        (=(distance school train_station) 2.7)

        (=(distance school home) 1)
        
        ;;Speeds
        (= (speed car1) 50)
        
        ;;hazards
        (no_crash route9)
        (no_crash amitystreet)
        (no_crash parkstreet)
        (no_crash foreststreet)
        (no_crash route116)
        (no_crash oakroad)
        (no_crash taylorstreet)
        (no_crash lincolnavenue)
        (no_crash serviceroad)
        (no_crash asylumstreet)
        (no_crash pleasantstreet)
        (no_crash mainstreet)
        (no_crash astordrive)
        (no_crash trianglestreet)
        (no_crash merrickroad)
        (no_crash collegestreet)
        
        (clear route9 lane1)
        (clear route9 lane2)
        (clear amitystreet lane1)
        (clear amitystreet lane2)
        (clear parkstreet lane1)
        (clear parkstreet lane2)
        (clear foreststreet lane1)
        (clear foreststreet lane2)
        (clear route116 lane1)
        (clear route116 lane2)
        (clear oakroad lane1)
        (clear oakroad lane2)
        (clear taylorstreet lane1)
        (clear taylorstreet lane2)
        (clear lincolnavenue lane1)
        (clear lincolnavenue lane2)
        (clear serviceroad lane1)
        (clear serviceroad lane2)
        (clear asylumstreet lane1)
        (clear asylumstreet lane2)
        (clear pleasantstreet lane1)
        (clear pleasantstreet lane2)
        (clear mainstreet lane1)
        (clear mainstreet lane2)
        (clear astordrive lane1)
        (clear astordrive lane2)
        (clear trianglestreet lane1)
        (clear trianglestreet lane2)
        (clear merrickroad lane1)
        (clear merrickroad lane2)
        (clear collegestreet lane1)
        (clear collegestreet lane2)
        (clear cutstreet lane2)
        
        (none_killed)
        (none_as_means)
        
        (= (crash car2 lane1) 5)
        (= (young_killed car2) 1)
        (= (family_killed car2) 1)
        
        (= (crash car3 lane2) 1)
        (= (young_killed car3) 0)
        (= (family_killed car3) 0)
        
        (= (crash old_ladies1 lane1) 2)
        (= (young_killed old_ladies1) 0)
        (= (family_killed old_ladies1) 0)
        
        (= (crash old_ladies2 lane2) 1)
        (= (young_killed old_ladies2) 0)
        (= (family_killed old_ladies2) 0)
        
        (= (crash commuters1 lane1) 10)
        (= (young_killed commuters1) 0)
        (= (family_killed commuters1) 0)
        
        (= (crash students1 lane1) 5)
        (= (young_killed students1) 1)
        (= (family_killed students1) 0)
        
        (= (crash pupils lane1) 4)
        (= (young_killed pupils) 1)
        (= (family_killed pupils) 0)
        
        (= (crash commuters2 lane2) 3)
        (= (young_killed commuters2) 0)
        (= (family_killed commuters2) 0)
        
        (= (crash kid1 lane2) 1)
        (= (young_killed kid1) 1)
        (= (family_killed kid1) 0)
    )
  
        
    (:goal (and 
        ;; home
        (at home car1)))
    
)
        