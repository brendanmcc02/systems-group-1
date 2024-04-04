; pathfinding

breed [buyers buyer]
breed [sellers seller]

globals [ repIncreaseFactor repDecreaseFactor ]
sellers-own [ rep wealth salesCount ] ; seller variables
buyers-own [ goal ] ; buyer variables

to setup
  ca

  ask patches [ set pcolor green ]

  ; set up buyers
  ; todo make numberOfBuyers a slider
  create-buyers 20 [
    setxy random-xcor random-ycor
    set goal one-of patches
    set color yellow
    set size 5
  ]

  ; set up sellers
  create-sellers 5 [
    set wealth (random 10) + 1
    set rep 50
    set salesCount 0
    set color blue
    setxy random-xcor random-ycor
  ]

  draw-circles ; Drawing circles with around each turtle

  ask sellers  [ set label wealth ]
  ; update-display
  reset-ticks
end

to go
    ask buyers [
        move
    ]

    ask sellers [
        set rep rep + 1
        checkBuyers
    ]

    if not any? sellers [ stop ]

    draw-circles

    ; update-display
    tick
end

to move
  
end

to sell
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

to checkBuyers
  let nearby-buyers buyers in-radius rep
  if any? nearby-buyers [
    ; if there is a buyer near the seller
    ask nearby-buyers [ sell ]
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


to move-buyers
  ask buyers [
    ifelse patch-here = goal [
      set goal one-of patches
    ] [
      walk-towards-goal
    ]
  ]
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


to walk-towards-goal
  ;if pcolor != gray [
  ;  ; boost the popularity of the patch we're on
  ;  ask patch-here [ become-more-popular ]
  ;]
  face best-way-to goal
  fd 1
end

to-report best-way-to [ destination ]

  ; of all the visible route patches, select the ones
  ; that would take me closer to my destination
  let visible-patches patches in-radius walker-vision-dist
  let visible-routes visible-patches with [ pcolor = gray ]
  let routes-that-take-me-closer visible-routes with [
    distance destination < [ distance destination - 1 ] of myself
  ]

  ifelse any? routes-that-take-me-closer [
    ; from those route patches, choose the one that is the closest to me
    report min-one-of routes-that-take-me-closer [ distance self ]
  ] [
    ; if there are no nearby routes to my destination
    report destination
  ]

end

to recolor-patches
  ask patches with [ pcolor != gray ] [
    set pcolor green
  ]
end


; Copyright 2015 Uri Wilensky.
; See Info tab for full copyright and license.