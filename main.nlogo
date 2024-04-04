breed [buyers buyer]
breed [sellers seller]

globals [ repIncreaseFactor repDecreaseFactor tickCount ]
sellers-own [ rep wealth salesCount ] ; seller variables
buyers-own [ goal ] ; buyer variables

to setup
    ca ; clear-all

    ask patches [ set pcolor green ]

    ; set up sellers
    create-sellers numberOfSellers [
      set wealth (random 10) + 1
      set rep 50
      set salesCount 0
      set color blue
      setxy random-xcor random-ycor
    ]

    ; set up buyers
    ; todo make numberOfBuyers a slider
    create-buyers numberOfBuyers [
      setxy random-xcor random-ycor
      set goal one-of patches
      set color yellow
      set size 20
    ]

    draw-circles ; Drawing circles with around each seller

    ; visualise the number of goods each vendor has
    ask sellers  [ set label wealth ]
    ; update-display
  
    set tickCount 0
  
    reset-ticks
end

to go
  move-buyers

    ask sellers [
        if tickCount = 0 [
           set salesCount 0
        ]
        ;set rep rep + 1
        checkBuyers
        set label salesCount
    ]

    if not any? sellers [ stop ]

    draw-circles

  
  
    ; update-display
    set tickCount tickCount + 1
    set tickCount tickCount mod 100 ; todo tickWindowLength
    tick
end


to draw-circles
  ask sellers [
    ask patches in-radius rep [
      set pcolor red  ; Change the color of the patches to represent the circle
    ]
    set shape "house"
    set size 25
  ]
end


to sell
  set salesCount salesCount + 1
  
    ; todo
    ; salesCount++
    ; roll for 1/x (repGoesUp = x)
    ; if x == True:
    ;   rep++
    ; roll for 1/y (repGoesDown = Y)
    ; if y == True: ; bad sale
    ;   roll for cancel (1/z)
    ;   rep * z
    ; else rep = rep
end

to move-buyers
  ask buyers [
    ifelse patch-here = goal [
      set goal one-of patches
    ] [
      walk-towards-goal
    ]
  ]
end

to walk-towards-goal
  face goal
  fd 1
end


to checkBuyers
  let nearby-buyers buyers in-radius rep
  ; if there is a buyer near the seller
  if any? nearby-buyers [
    let nearby-sellers sellers in-radius 1
    ask nearby-sellers [ sell ]
    ; ask nearby-buyers [ turnAway ] ; todo
  ]

  ; TODO checkTickCount
    ; if tickCount == tickWindowLength:
    ;   check salesCount:
    ;     logic for wealth going up/down
    ;     if wealth == 0:
    ;       die.
    ;     elif wealth >
    ;     set salesCount = 0;
    ;     tickWindowlength = 0;
end