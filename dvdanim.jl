#using Revise
using Javis
using Animations

video = Video(500, 500)
svgtext = read("dvdlogo.svg", String)

bottomright = Point(250 - 125, 250 - 60)
topleft = Point(-250, -250)
topright = Point(+250-125, -250)
bottomleft = Point(-250, 250-60)
middleright = Point(250-125,0)
middleleft = Point(-250,0)
#startpos = topleft
startpos = topleft
#startpos = (bottomright + topleft) / 2

#d1 = distance(startpos,bottomright)
#diag = distance(topleft,bottomright)
#d2 = distance(topleft,startpos)
d1 = distance(startpos, topright)
d2 = distance(topright, startpos)

d3 = distance(startpos, topleft)
d4 = distance(topleft, startpos)

d5 = distance(startpos, bottomleft)
d6 = distance(bottomleft, startpos)

d7 = distance(startpos, bottomright)
d8 = distance(bottomright, startpos)

#keyf = cumsum([0, d1, d2, d3, d4, d5, d6, d7, d8])

positions = [
  startpos,         
  middleright,
  bottomleft,
  topright,
  middleleft,
  bottomright,
  topleft,
]
p=positions
ds = [distance(p[i],p[i+1]) for i in 1:(length(positions)-1)]
keyf = cumsum( vcat([0,], ds))
keyf = keyf/ keyf[end]

function drawdvd(hue = "red")
  move(startpos)
  sethue(hue)
  scale(1.5)
  Javis.pathsvg(svgtext)
  fillstroke()
end

function colordvd(frame)
  #if frame<keyf[2]*nframes
  colorlist = ["red","blue","yellow","green"]
  frameposs=nframes.*keyf
  #findx = length(frameposs)-1 
  findx =1 
  for (i,fnum) in enumerate(frameposs)
      if frame>fnum 
          findx = i
      end
  end
  drawdvd(colorlist[mod1(findx,4)])
end

#nframes = 500
#Background(1:nframes, (_, _, _) -> background("black"))
#dvdlogo = Object(1:nframes, (_, _, frame) -> colordvd(frame))
#tanimfin = Animation(keyf, positions)
#act!(dvdlogo, Action(1:nframes, tanimfin, translate()))
#
#render(video, pathname = "dvd.gif")

nframes = 500
Background(1:nframes, (_, _, _) -> background("black"))
dvdlogo = Object(1:nframes, (_, _, frame) -> colordvd(frame))
tanimfin = Animation(keyf, positions)
act!(dvdlogo, Action(1:nframes, tanimfin, translate()))

render(video, pathname = "dvd.gif")
