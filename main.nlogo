breed [buyers buyer]
breed [sellers seller]

globals [ repIncreaseFactor repDecreaseFactor ]
sellers-own [ rep wealth salesCount ] ; seller variables

to setup
    ca ; clear-all

    ; set up sellers
    create-sellers numberOfSellers [
      set wealth (random 10) + 1
      set rep 50
      set salesCount 0
      set color blue
      setxy random-xcor random-ycor
    ]  

    draw-circles ; Drawing circles with around each turtle
  
    ; visualise the number of goods each vendor has
    ask sellers  [ set label wealth ] 
    ; update-display
    reset-ticks
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

to move

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
