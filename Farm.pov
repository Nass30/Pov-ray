#include "colors.inc"
#include "skies.inc"
#include "woods.inc"
#include "textures.inc"
#include "stones.inc"
#include "functions.inc"


#declare Camera = 6;
#declare Random = seed(12312);
#declare Random2 = seed(34253);
#declare Pi = 3.141592;

#switch (Camera)
  	#case (1) // Sud
		camera {
			location <40,10,5>
			look_at <0,10,4>
			sky <0,0,1>
			right <-image_width/image_height,0,0>
		}
		#break

  	#case (2) // Est
  		camera {
			location <-5,70,2>
			look_at <-5,10,2>
			sky <0,0,1>
			right <-image_width/image_height,0,0>
		}
   		#break
   	#case (3) // Nord
  		camera {
			location <-55,10,5>
			look_at <0,10,4>
			sky <0,0,1>
			right <-image_width/image_height,0,0>
		}
   		#break
   	#case (4) // Ouest
  		camera {
			location <-5,-40,5>
			look_at <-5,0,5>
			sky <0,0,1>
			right <-image_width/image_height,0,0>
		}
   		#break			
   	#case (5) // Vue d'en Haut
  		camera {
			location <0,0,150>
			look_at <0,0,0>
			sky <0,0,1>
			right <-image_width/image_height,0,0>
		}
   		#break	
   	#case (6) // Vue d'ensemble 1 
  		camera {
			location < 30 , 30 , 15 >
			look_at <5,5,3>
			sky <0,0,1>
			right <-image_width/image_height,0,0>
		}
   		#break			
  	#case (7) // Vue d'ensemble 2
  		camera {
			location < 15 , -15 , 10 >
			look_at <0,0,3>
			sky <0,0,1>
			right <-image_width/image_height,0,0>
		}
   		#break
   	#case (8) // Poulailler
		camera {
			location <8,3,2>
			look_at <15,2,2>
			sky <0,0,1>
			right <-image_width/image_height,0,0>
		}
		#break
	#case (9 ) // Etabli
		camera {
			location <0,20,5>
			look_at <-10,5,3>
			sky <0,0,1>
			right <-image_width/image_height,0,0>
		}
		#break	
	#case (10) // Maison
		camera {
			location <-5,5,10>
			look_at <-13,16,4>
			sky <0,0,1>
			right <-image_width/image_height,0,0>
		}
		#break

  	#else // Vue d'en Haut
  		camera {
			location <0,0,150>
			look_at <0,0,0>
			sky <0,0,1>
			right <-image_width/image_height,0,0>
		}	
#end


light_source {
	<50, 100 , 100>
	color White
}

background {
	White
}


sky_sphere {
	S_Cloud5
	//pigment {White}
	rotate <90,0.051,1>
}

plane {
	<0,0,1>, 0.1
	pigment{ color rgb <0.75,1,0>}
	normal { bumps 0.50 scale 0.10}
}

#macro pieceDeBase(coor,tr,ro,l,sca,te)
	union {
		box {
			< 0 , 0 , 0.125 >
			< l , 0.5 , 0.375 >
		}
		union {
			union {
				box {
					< 0 , 0 , 0 >
					< 0.5 , 0.5 , 0.5 >	
				}
				box {
					< 1 , 0 , 0 >
					< l-1 , 0.5 , 0.5 >

				}
			}

			box {
				< l-0.5 , 0 , 0 >
				< l , 0.5 , 0.5 >

			}


		}
		texture {
			te
		}
		rotate ro
		translate tr
		scale sca
		translate coor

	}
#end
#macro pieceDeBaseMoitie(coor,tr,ro,l,sca,te)
	union {
		box {
			< 0 , 0 , 0.125 >
			< l , 0.5 , 0.375 >
		}
		union {
			union {
				box {
					< 0 , 0 , 0 >
					< 0.5 , 0.5 , 0.25 >	
				}
				box {
					< 1 , 0 , 0 >
					< l-1 , 0.5 , 0.25 >

				}
			}

			box {
				< l-0.5 , 0 , 0 >
				< l , 0.5 , 0.25 >

			}


		}
		texture {
			te
		}
		rotate ro
		translate tr
		scale sca
		translate coor

	}
#end
#macro contour(coor,long,larg,sca,te)
	pieceDeBase( coor , < 0 , 0 , 0 > , 0 , larg ,sca,te)
	pieceDeBase( coor , < 1 , -0.5 , 0.375 > , 90 * z , long ,sca,te)
	pieceDeBase( coor , < 0 , long - 1.5 , 0 > , 0 , larg ,sca,te)
	pieceDeBase( coor , < larg - 0.5 , - 0.5 , 0.375 > , 90 * z , long ,sca,te)
#end

#macro porteGrange(coor, tr,ro, larg)
	union {
		box {
			<0,0,0>
			<larg/2,0.6,3.5>
			texture {
				T_Wood10
			}
		}

		difference {
			box {
				<0,0.65,0>
				<larg/2,0.75,3.5>
				texture {
					T_Wood9
				}
			}
			union{
				box {
					<0.15,0.60,0.15>
					<larg/2 - 0.15, 0.75 , 3.5 / 2 - 0.15>
				}
				box {
					<0.15,0.60,3.15 / 2 + 0.15>
					<larg/2 - 0.15, 0.75 , 3.5 - 0.15 >
				}
				texture {
					pigment{
						transmit 1
					}
				}
			}
		}
		rotate ro
		translate coor
		translate tr
	}
#end

#macro grange(coor,larg,long,nbetage)
	#for (i,0,nbetage,1)
		contour(<0,0,i/2>,long,larg,1,T_Wood7)
	#end
	pignon( coor + < 0 , 0 , nbetage / 2 + 0.5 > , 7 , 4.5 , 0,1 )
	pignon( coor + < 0 , long - 1.5 , nbetage / 2 + 0.5 > , 7 , 4.5 , 0,1 )
	pieceDeBase( coor , < 1 , -0.5 , 0 > + < larg / 2 - 1.3, 0 , 4.5 + nbetage/2 - 0.6> , 90 * z + 40 * x , long ,1,T_Wood7)
	pieceDeBase( coor , < 1 , -0.5 , 0 > + < larg / 2 - 0.65, 0 , 4.5 + nbetage/2 - 0.6> , 90 * z + 50 * x , long ,1,T_Wood7)
	porteGrange(coor, <larg/4,long - 1.5,0>,0, larg)

#end
prism {
		0.5 , 8.5 , 4
		< 0.5 , 6 >
		< 6.5 , 6 >
		< 7/2 , 9.5 >
		< 0.5 , 6 >
		pigment {
			Red
		}
}

#macro pignon(coor ,long, hauteur , ro,fenetre)
	union {
		difference {
			prism {
				0 , 0.5 , 4
				< 0 , 0 >
				< long , 0 >
				< long/2 , hauteur >
				< 0 , 0 >
				rotate ro * z
				translate coor
				texture {
					pigment {
						Yellow
					}
				}
			}
			union {
				box {
					< 0.5 , 0 , 0.125 >
					< 1 , 0.5 , 0 >
					rotate ro * z
					translate coor
				}
				box {
					< long - 0.5 , 0 , 0.125 >
					< long - 1 , 0.5 , 0 >
				rotate ro * z
					translate coor
				}
				box {
					< 0 , 0 , 0 >
					< 0.25 , 0.5 , 0.25 >
					rotate 40 * y
					translate < long / 2 - 0.65 , 0 , hauteur - 0.6>
					translate coor
				}
				box {
					< 0 , 0 , 0 >
					< 0.25 , 0.5 , 0.25 >
					rotate 50 * y
					rotate ro * z
					translate < long / 2 + 0.3 , 0 , hauteur - 0.6>
					translate coor
				}
				cylinder {
					<0,0,0>
					<0,1,0>
					1
					translate coor
					translate < long/2 , 0 , hauteur /2 >
				}

				texture {
					pigment {
						color Red
						transmit 1
					}
				}
			}
		}
		#if (fenetre)
			cylinder {
				<0,0.125,0>
				<0,0.375,0>
				1
				rotate ro * z
				translate coor
				translate < long/2 , 0 , hauteur /2 >
				texture {
					Glass3
				}
			}
		#end
	}
#end
grange( 0 , 7 , 10 , 10 )


#macro champs(coor,longueur, largeur,coul)
	box {
		< 0 , 0 , 0 >
		< longueur , largeur , 0.2 >

		pigment{ 
			color rgb coul
		}
		normal {
			agate 1.0      
	        agate_turb 1.0 
	        scale 0.5 
	    }

	    translate coor
	}
	enclos (coor,longueur,0)
	enclos (coor,largeur, 90 * z)
	enclos (coor + largeur * y,longueur,0)
	enclos (coor + longueur * x,largeur, 90 * z)
#end

#macro enclos (coor,longueur , ro)
	union {
		box {
			<0,0,0>
			<0.25,0.25,1>
		}
		box {
			<0,0,0>
			< longueur , 0.25 , 0.15 >
		}
		box {
			<0,0,0.4>
			< longueur , 0.25 , 0.6 >
		}
		box {
			<0,0,0.85>
			< longueur , 0.25 , 1 >
		}
		box {
			<longueur - 0.25,0,0>
			<longueur,0.25,1>
		}
		texture {
			pigment {
				Black
			}
		}
		rotate ro
		translate coor
	}

#end

champs(<0,-25,0>,25,25,<0.6,1,0>)

#macro poulailler (coor)
	#declare i = 0;
		#while (i < 10)
			#if (i<6)
				contour(coor + <0,0,i/4>,10,5,0.5,T_Wood7)
				#declare i = i + 1;
			#else
				contour(coor + <0,0,i/4>,10,10-i+1,0.5,T_Wood7)
			 	#declare i = i + 0.5;
			#end
	#end
	union {
		cylinder {
			<0,0,0>
			<0.20,0,0>
			0.4
			translate coor
			translate < 0.246 , 1 , 1.7 >
			texture {
				pigment {
					White
				}
			}
		}
		box {
			< 0 , 0 , 0 >
			< 0.1 , 0.5 , 1.5 >
			pigment {
				White
			}
			rotate 30 * y
			translate coor
			translate < -0.50 , 0.75 , 0 >
		}

		cylinder {
			<0,0,0>
			<0.20,0,0>
			0.4
			translate coor
			translate < 0.246 , 3.5 , 1.7 >
			texture {
				pigment {
					White
				}
			}
		}
		box {
			< 0 , 0 , 0 >
			< 0.1 , 0.5 , 1.5 >
			pigment {
				White
			}
			rotate 30 * y
			translate coor
			translate < -0.50 , 3.25 , 0 >
		}
	}
	enclos (<17,4.5,0>,6,0)
	enclos (<17,4.5,0>,4.5,-90*z)
#end
poulailler(<22.5,0,0>)

#macro etable (coor)
	#for (i,0,5,1)
		contour(coor+<0,0,i/2>,6,20,1,T_Wood7)
	#end

	prism {
		0,18,4
		<0.5, 3.38>
		<5.5,3.38>
		<3,6.38>
		<0.5, 3.38>
		rotate 90 * z
		translate -6*x -0.5*y
		texture {
			T_Wood8
		}
	}
	pignon(coor+<19.5,-0.5,3.38>, 6, 3,90 * z,0)
	pignon(coor+<1,-0.5,3.38>, 6, 3,90 * z,0)
	pieceDeBase( coor , < 0 , 0 , 3 > , 0 , 20 ,1,T_Wood7)
	pieceDeBase( coor , < 0 , 4.5 , 3 > , 0 , 20 ,1,T_Wood7)
	#for (i,0,16,1)
		box {
			<2 + 1*i,4.5,2>
			<2.5 + 1*i,5.1,3>
			translate coor
			pigment {
				Black
			}
		}
	#end
	porteGrange (coor,<19, 4, 0>	,-90*z,6)
#end

etable (<-25,0,0>)


#declare chemin = object {
	union {
		box {
			<0,-100,0>
			<-6,100,0.2>
			pigment{ color rgb <1,0.35,0>}
			normal { bozo 3.00 scale 0.05}
		}
		box {
			<-26,0,0>
			<25,25,0.2>
			pigment{ color rgb <1,0.35,0>}
			normal { bozo 3.00 scale 0.05}
		}
	}
}

chemin

#macro maison (coor)
	#for (i,0,2,1)
		contour(coor+<0,0,i/2>,5.5,20,1,T_Stone17)
	#end
	#for (i,0,2,1)
		contour(coor+<0,4,i/2>,10,20,1,T_Stone17)
	#end
	#for (i,0,10,1)
		contour(coor+<0,4,(i/2)+1.5>,10,20,1,Sandalwood)
	#end
	box {
		<0.5,0,1.5>
		<19.5,4,1.9>
		texture {
			T_Stone17
		}
		translate coor
	}
	pieceDeBaseMoitie(coor,<0,4,7>,0,20,1,Sandalwood)
	pieceDeBaseMoitie(coor,<0,12.5,7>,0,20,1,Sandalwood)
	prism {
		0,19,4
		<0, 7.375>
		<9,7.375>
		<4.5,7.375+4>
		<0,7.375>
		rotate 90 * z
		translate coor
		translate <19.5,4,0>
		texture {
			pigment {
				Navy
			}
		}
	}
	box {
		<0,0,0>
		<0.5,0.5,6>
		pigment {
			White
		}
		translate coor
		translate <0.5,0,1.5>
	}
	box {
		<0,0,0>
		<0.5,0.5,6>
		pigment {
			White
		}
		translate coor
		translate <6.5,0,1.5>
	}
	box {
		<0,0,0>
		<0.5,0.5,6>
		pigment {
			White
		}
		translate coor
		translate <12.5,0,1.5>
	}
	box {
		<0,0,0>
		<0.5,0.5,6>
		pigment {
			White
		}
		translate coor
		translate < 19 , 0 , 1.5 >
	}
	box {
		<0,0,0>
		<19,4,0.3>
		translate coor
		translate < 0.5 , 0, 7 >
		pigment {
			White
			//transmit 1
		}
	}
	barriere (coor ,<1,0.25,1.5> , 90*z , 4 )
	barriere (coor ,<19.5,0.25,1.5> , 90*z , 4 )
	barriere (coor ,<1,0,1.5>,0,5.5)
	barriere (coor ,<12.5,0,1.5>,0,6.5)

	fenetre (coor,<19.28,10,3.5>,-90*z,2.5)
	fenetre (coor,<17.5,4.2,3.5>,180*z,2.5)
	fenetre (coor,<6,4.2,3.5>,180*z,2.5)
	porte (coor,<11.25,4,2>,180*z,4)


	// escalier
	union {
		box {
			<0,0,0>
			<5.5,2,0.5>
		}
		box {
			<0,0,0.5>
			<5.5,1.5,1>
		}
		box {
			<0,0,1>
			<5.5,1,1.5>
		}
		box {
			<0,0,1.5>
			<5.5,0.5,2>
		}
		texture {
			T_Stone15

		}
		rotate 180*z
		translate coor
		translate <12.5,0,0>
	}
#end
#macro barriere(coor, tr, ro,l)
	union {
		box {
			<0,0.1,3>
			<l,0.4,3.5>
		}
		#for (b,0,l,1)
			box {
				<0+1*b,0.2,0>
				<0.25+1*b,0.35,3>
				pigment {
					White
				}
			}
		#end
		texture {
			pigment {
				White
			}
		}
		rotate ro
		translate coor
		translate tr
	}

#end

#macro porte (coor, tr ,ro, hauteur)
	union {
		difference {
			box {
				<0,0,0>
				<2.3,0.2,hauteur>
				texture {
					T_Wood10
				}

			}
			union {
				box {
					<0.1,0.2,hauteur/2 - 0.1>
					<1.1,0.23,hauteur-0.1>
				}
				box {
					<1.2,0.2,hauteur/2 - 0.1>
					<2.2,0.23,hauteur-0.1>
				}
				texture {
					Glass
					finish { reflection {1} ambient 0 diffuse 0 }
				}
			}
		}
		union {
			cylinder {<0.2,0,hauteur / 2 - 0.3 >,<0.2,0.24,hauteur / 2 - 0.3>,0.07}
			cylinder {<0.2,0,hauteur / 2 - 0.3 >,<0.2,0.35,hauteur / 2 - 0.3>,0.04}
			cylinder {<0.2,0.35,hauteur / 2 - 0.3>,<0.5,0.35,hauteur / 2 - 0.3>,0.04}
			sphere {<0.5,0.35,hauteur / 2 - 0.3>,0.04}
			texture { Chrome_Metal }
		}
		rotate ro
		translate coor
		translate tr

	}

#end

#macro fenetre(coor,tr,ro,hauteur)
	union {
		box {
			<1,0,0>
			<3,0.25,hauteur>
			texture {
				pigment {
					White

				}
			}
		}
		box {
			<1.1,0.15,0.1>
			<2.9,0.26,hauteur-0.1>
			texture {
				Glass
			}
		}
		box {
			<0,0.23,0.1>
			<1,0.3,hauteur-0.1>
			pigment {
				Blue
			}
		}
		box {
			<3,0.23,0.1>
			<4,0.3,hauteur-0.1>
			pigment {
				Blue
			}
		}
		rotate ro
		translate coor
		translate tr
	}
#end

maison(<-26,12,0>)
maison(<-26,40,-1.5>)
maison(<0,40,-1.5>)

#declare sapin =
	union {
		lathe {
			linear_spline
			7,
			< 0.1, 1.5 >,
			< 1.5, 1.5 >,
			< 1, 2.5 >,
			< 1.3, 2.5 >,
			< 0.8, 3.5 >
			< 1,3.5>
			< 0,4.5>
			pigment { Green }
		        //finish {ambient .3 phong 1}
		    rotate 90*x
		    //translate 
		}
		cylinder {
			<0,0,0>
			<0,0,1.5>
			0.2
			texture {
				T_Wood10
			}
		}
	}

#for (s,0,2000,i)
#local x1 = (100*rand( Random)* (-1+2* rand( Random)));
#local y1 = (100*rand( Random2)* (-1+2* rand( Random2)));
	#if ((-27<x1)&(27>x1)&(-27<y1)&(55>y1))
	#else
		object {
			sapin
			translate <x1,y1,0>
		}

	#end
#end
champs(<-25,-25,0>,19,25,<1,1,0>)



