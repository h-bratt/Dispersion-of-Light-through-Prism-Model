extends Node2D

var a = deg_to_rad(45)
var i = deg_to_rad(7)
var ns = [1.513,1.516,1.517,1.519,1.522,1.524,1.529] #from graph
var ts = []
var N = 1.52
var colours = ["red","orange","yellow","green","cyan","blue","violet"]

var ll=320

var x = 0
var y = 0

@onready var n = $Node

func _ready():
	do()
func do():
	n.queue_free()
	n = Node.new()
	add_child(n)
	ts =[]
	for n in ns:
		ts.append(asin(sqrt(n**2-sin(i)**2)*sin(a)-sin(i)*cos(a)))
	var tot = 0
	for t in ts:
		tot += t
	var T = tot/len(ts)
	var delta = i + T - a
	
	x = ll*sin(a/2)
	y = ll*cos(a/2)
	$tri1.points = [Vector2(0,0),Vector2(x,y)]
	$tri2.points = [Vector2(0,0),Vector2(-x,y)]
	$tri3.points = [Vector2(x,y),Vector2(-x,y)]
	var m= x/y
	var c = (y/2) -m*(-x/2) #y=mx+c 
	$normal1.points = [Vector2(-x/2 -60 ,m*(-x/2-60)+c),Vector2(-x/2 +60,m*(-x/2+60)+c)]
	m = tan(-atan(m)+i)
	c = y/2 - m*(-x/2)
	$i.points = [Vector2(-x/2-500,m*(-x/2+500)+c),Vector2(-x/2,y/2)]
	var beta = asin(sin(i)/N)
	m = tan(atan(x/y)-beta)
	c = y/2 - m*(-x/2)
	var X = -1*c/(m-1/tan(a/2)) #intersection of mid and tri2
	var Y = m*X +c
	$mid.points = [Vector2(-x/2,y/2),Vector2(X,Y)]
	m= -x/y
	c = Y -m*(X) #y=mx+c 
	$normal2.points = [Vector2(X-60,m*(X-60)+c),Vector2(X+60,m*(X+60)+c)]
	for t in range(len(ts)): #colours in light
		m = tan(atan(-x/y)+ts[t])
		c = Y - m*(X)
		var l = Line2D.new()
		n.add_child(l)
		l.width = 1
		l.default_color = colours[t]
		l.points = [Vector2(X,Y),Vector2(X+500,m*(X+500)+c)]
func _process(delta):
	if Input.is_action_just_pressed("ui_accept") and int($ii.text) <= 90 and int($ii.text) >= 0 and int($a.text) <= 180 and int($a.text) >= 0:
		a = deg_to_rad(int($a.text))
		i = deg_to_rad(int($ii.text))
		do()
