using Javis
using Animations

function hilbert(t::Turtle, level, angle, lengthstep)
    level == 0 && return

    HueShift(t, 0.3)

    Turn(t, angle)
    hilbert(t, level-1, -angle, lengthstep)

    Forward(t, lengthstep)
    Turn(t, -angle)
    hilbert(t, level-1, angle, lengthstep)

    Forward(t, lengthstep)
    hilbert(t, level-1, angle, lengthstep)

    Turn(t, -angle)
    Forward(t, lengthstep)
    hilbert(t, level-1, -angle, lengthstep)

    Turn(t, angle)
end


function hilbobj(v,o,f) 
    hilbert(Turtle(first(BoundingBox()) + (100, 100), true, 0, (1, 0, 0)),
        5,  # level
        90, # turn angle, in degrees
        13   # steplength
        )
end

video=Video(600,600)
Background(1:(800+60),(v,o,f)->background("black"))
obj = Object(1:(800+60),(v,o,f)-> hilbobj(v,o,f) )
act!(obj,Action(1:800,linear(),show_creation()))
#render(video,tempdirectory="hilbert",pathname="")
render(video,pathname="hilbert.gif")

