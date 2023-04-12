s	 = DefineNumber[ 1e-3, 		Name "Parameters/s" ];		//size factor (mm)
x	 = DefineNumber[ 5*s, 		Name "Parameters/x" ];		//width
y	 = DefineNumber[ 5*s, 		Name "Parameters/y" ];		//height
xb	 = DefineNumber[ 0.8*s, 	Name "Parameters/xb" ];		//box width
yb	 = DefineNumber[ 1.6*s,	 	Name "Parameters/yb" ];		//box height
xb2	 = DefineNumber[ 0.5*s, 	Name "Parameters/xb2" ];	//lower box width
yb2	 = DefineNumber[ 0.5*s,	 	Name "Parameters/yb2" ];	//lower box height
w 	 = DefineNumber[ 0.0975*s, 	Name "Parameters/w" ];		//upper canal width
w2 	 = DefineNumber[ 0.0975*s, 	Name "Parameters/w2" ];		//lower canal width
l 	 = DefineNumber[ 0.17*s,	Name "Parameters/l" ];		//canal length
b 	 = DefineNumber[ 0.02*s, 	Name "Parameters/b" ];		//boundary layer width
res1	 = DefineNumber[ 0.1*s, 	Name "Parameters/res1" ];	//resolution far from the bubble
res2	 = DefineNumber[ 0.0025*s,  	Name "Parameters/res2" ];	//resolution close to the bubble
xc	 = DefineNumber[ (1-Sqrt(2)/2),	Name "Parameters/xc" ]; 	//circle coord
yc	 = DefineNumber[ (1-Sqrt(2)/2),	Name "Parameters/yc" ]; 	//circle coord

Point (1)  = { 0, 	y,	0, res1 };
Point (2)  = { x, 	y,	0, res1 };
Point (3)  = { 0, 	yb,	0, res2 };
Point (4)  = { xb, 	yb, 	0, res2 };
Point (5)  = { 0,	w,	0, res2 };
Point (6)  = { w+b,	w,	0, res2 };
Point (7)  = { xb,	w,	0, res2 };
Point (8)  = { w+b,	0,	0, res2 };
Point (9)  = { xb,	0,	0, res2 };
Point (10) = { x,	0,	0, res1 };
Point (11) = { w+xc*b, 	-yc*b,	0, res2 };
Point (12) = { 0, 	-b,	0, res2 };
Point (13) = { w,	-b,	0, res2 };
Point (14) = { w+b,	-b,	0, res2 };
Point (15) = { 0,	b-l, 	0, res2 };
Point (16) = { w2,	b-l, 	0, res2 };
Point (17) = { w2+b,	b-l,	0, res2 };
Point (18) = { w2+xc*b,	yc*b-l, 0, res2 };
Point (19) = { w2+b,	-l,	0, res2 };
Point (20) = { xb2,	-l, 	0, res2 };
Point (21) = { x,	-l,	0, res1 };
Point (22) = { 0,	-l-w2,	0, res2 };
Point (23) = { w2+b,	-l-w2,	0, res2 };
Point (24) = { xb2,	-l-w2,	0, res2 };
Point (25) = { 0,	-l-y, 	0, res1 };
Point (26) = { x,	-l-y,	0, res1 };
Point (27) = { w+b,	yb,	0, res2 };
Point (28) = { 0,	-l-yb2,	0, res2 };
Point (29) = { w2+b,	-l-yb2,	0, res2 };
Point (30) = { xb2,	-l-yb2,	0, res2 };

allPoints[] = Point "*" ;
Rotate {{0, 1, 0}, {-res2/10, 0, 0}, 2.5e-3} { Point{ allPoints[] } ; }

Line (1)  = {1,2};
Line (2)  = {1,3};
Line (3)  = {2,10};
Line (4)  = {3,27};
Line (5)  = {3,5};
Line (6)  = {4,7};
Line (7)  = {5,6};
Line (8)  = {6,7};
Line (9)  = {5,12};
Line (10) = {5,11};
Line (11) = {6,8};
Line (12) = {7,9};
Line (13) = {8,9};
Line (14) = {9,10};
Circle(15)= {8,14,11};
Circle(16)= {11,14,13};
Line (17) = {12,13};
Line (18) = {12,15};
Line (19) = {13,16};
Line (20) = {15,16};
Line (21) = {15,22};
Circle(22)= {16,17,18};
Line (23) = {22,18};
Circle(24)= {18,17,19};
Line (25) = {19,20};
Line (26) = {20,21};
Line (27) = {19,23};
Line (28) = {20,24};
Line (29) = {21,26};
Line (30) = {22,23};
Line (31) = {23,24};
Line (32) = {28,25};
Line (33) = {25,26};
Line (34) = {27,4};
Line (35) = {27,6};
Line (36) = {23,29};
Line (37) = {24,30};
Line (38) = {28,29};
Line (39) = {29,30};
Line (40) = {22,28};

Curve Loop (1)  = {1,3,-14,-12,-6,-34,-4,-2};
Curve Loop (2)  = {4,35,-7,-5};
Curve Loop (3)  = {34,6,-8,-35};
Curve Loop (4)  = {7,11,15,-10};
Curve Loop (5)  = {8,12,-13,-11};
Curve Loop (6)  = {10,16,-17,-9};
Curve Loop (7)  = {17,19,-20,-18};
Curve Loop (8)  = {20,22,-23,-21};
Curve Loop (9)  = {24,27,-30,23};
Curve Loop (10) = {25,28,-31,-27};
Curve Loop (11) = {26,29,-33,-32,38,39,-37,-28};
Curve Loop (12) = {30,36,-38,-40};
Curve Loop (13) = {31,37,-39,-36};
Plane Surface (1)  = 1;
Plane Surface (2)  = 2;
Plane Surface (3)  = 3;
Plane Surface (4)  = 4;
Plane Surface (5)  = 5;
Plane Surface (6)  = 6;
Plane Surface (7)  = 7;
Plane Surface (8)  = 8;
Plane Surface (9)  = 9;
Plane Surface (10) = 10;
Plane Surface (11) = 11;
Plane Surface (12) = 12;
Plane Surface (13) = 13;
Recombine Surface{1};
Recombine Surface{2};
Recombine Surface{3};
Recombine Surface{4};
Recombine Surface{5};
Recombine Surface{6};
Recombine Surface{7};
Recombine Surface{8};
Recombine Surface{9};
Recombine Surface{10};
Recombine Surface{11};
Recombine Surface{12};
Recombine Surface{13};

Transfinite Curve {-12,-11,-17,-20,27,28}       	= w/res2+1	 	Using Progression 1;
Transfinite Curve {4,7} 				= (w+b)/res2+1 		Using Progression 1;
Transfinite Curve {34,8,13}				= (xb-w-b)/res2+1 	Using Progression 1;
Transfinite Curve {30,38} 				= (w2+b)/res2+1		Using Progression 1;
Transfinite Curve {25,31,39}				= (xb2-w2-b)/res2+1	Using Progression 1;
Transfinite Curve {5,35,6}				= (yb-w)/res2+1 	Using Progression 1;
Transfinite Curve {9}   				= (w2+b)/res2+1 	Using Progression 1;
Transfinite Curve {18,19}				= (l-2*b)/res2+1 	Using Progression 1;
Transfinite Curve {21}	        			= (w2+b)/res2+1		Using Progression 1;
Transfinite Curve {36,37,40}				= (yb2-w)/res2+1	Using Progression 1;
Transfinite Surface{2};
Transfinite Surface{3};
Transfinite Surface{5};
Transfinite Surface{7};
Transfinite Surface{10};
Transfinite Surface{12};
Transfinite Surface{13};

allSurfaces[] = Surface "*" ;
Extrude { {0,1,0}, {-res1/10,0,0}, -5e-3 }
{
	Surface{ allSurfaces[] };
	Layers{1};
	Recombine;
}

Physical Surface("left") 	= {81,103,191,213,235,305,343};
Physical Surface("outside") 	= {53,57,297,301};
Physical Surface("wall") 	= {61,143,165,183,205,227,245,267,293};
Physical Surface("front") 	= {1,2,3,4,5,6,7,8,9,10,11,12,13};
Physical Surface("back") 	= {82,104,126,148,170,192,214,236,258,280,322,344,366};

Physical Volume("fluid") 	= {1,2,3,4,5,6,7,8,9,10,11,12,13};
