
//POV-Ray Robot
                
/*
----------------------------------------
Robot malfunctioning                   *
after trying to get a soccer ball out  *
of the water at the beach              *    
---------------------------------------- 
*/

#version 3.7;
global_settings { assumed_gamma 1.2 } 


#include "shapes3.inc"  
#include "colors.inc"
#include "textures.inc"
#include "glass.inc"
#include "metals.inc"
#include "golds.inc"
#include "stones.inc"
#include "woods.inc"
#include "shapes.inc"
#include "shapes2.inc"
#include "functions.inc"
#include "math.inc"
#include "transforms.inc"

 
/* 
camera {
   location <1, 10, -15>
   angle 45 // direction <0, 0,  1.7>
   right x*image_width/image_height
   look_at <0,0,0>
} 
*/  

/*
// ultra_wide_angle lens for wide, rectangular field of view
camera {
  ultra_wide_angle
  location <30, 35, 30>       //5,15,25  //-6,50,-7   // position  left,up,back
  look_at  <0, 0, 0>                // view
  right x*image_width/image_height  // aspect
  angle 45                          // field
} 
*/
 

camera {
        perspective //keyword is facultative in this case
        location <5,10,35>   //front
        //location <-15,8,22>    
        //location <-65,5,10>    //side
        right    x*image_width/image_height
        look_at  <0,10,0>
        angle    50
        } 

 
// Uncomment the area lights only if you've got lots of time.
#declare Dist=80.0;
light_source {< -50, 25, -50> color White
     fade_distance Dist fade_power 2
//   area_light <-40, 0, -40>, <40, 0, 40>, 3, 3
//   adaptive 1
//   jitter
}
light_source {< 50, 10,  -4> color Gray30
     fade_distance Dist fade_power 2
//   area_light <-20, 0, -20>, <20, 0, 20>, 3, 3
//   adaptive 1
//   jitter
}
light_source {< 0, 100,  0> color Gray30
     fade_distance Dist fade_power 2
//   area_light <-30, 0, -30>, <30, 0, 30>, 3, 3
//   adaptive 1
//   jitter
}
 
// create a point "spotlight" (conical directed) light source
light_source {
  <0,0,0>                 // light's position (translated below)
  color rgb <1,1,1>       // light's color
  spotlight               // this kind of light source
  translate <40, 80, -40> // <x y z> position of light
  point_at <0, 0, 0>      // direction of spotlight
  radius 5                // hotspot (inner, in degrees)
  tightness 50            // tightness of falloff (1...100) lower is softer, higher is tighter
  falloff 8               // intensity falloff radius (outer, in degrees)
}
 
 
 
sky_sphere {
    pigment {
        gradient y
        color_map {
            [0, 1  color Gray50 color Gray80]
        }
    }
}     



#version 3.7;
global_settings{ assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 }} 

// camera ------------------------------------------------------------------
#declare Camera_0 = camera {/*ultra_wide_angle*/ angle 75      // front view
                            location  <10.0 , 15.0 ,40>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
#declare Camera_1 = camera {/*ultra_wide_angle*/ angle 90   // diagonal view
                            location  <2.0 , 2.5 ,-3.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
#declare Camera_2 = camera {/*ultra_wide_angle*/ angle 90 // right side view
                            location  <3.0 , 1.0 , 0.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
#declare Camera_3 = camera {/*ultra_wide_angle*/ angle 90        // top view
                            location  <0.0 , 10.0 ,-0.001>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
camera{Camera_0}
// sun ---------------------------------------------------------------------
light_source{<-1500,2000,-2500> color White}


// sky -------------------------------------------------------------- 
plane{<0,1,0>,1 hollow  
       texture{ pigment{ bozo turbulence 0.92
                         color_map { [0.00 rgb <0.20, 0.20, 1.0>*0.9]
                                     [0.50 rgb <0.20, 0.20, 1.0>*0.9]
                                     [0.70 rgb <1,1,1>]
                                     [0.85 rgb <0.25,0.25,0.25>]
                                     [1.0 rgb <0.5,0.5,0.5>]}
                        scale<1,1,1.5>*2.5  translate< 0,0,0>
                       }
                finish {ambient 1 diffuse 0} }      
       scale 10000} 


/*
 #include "stars.inc" //------------------------

sphere{ <0,0,0>, 1
        texture{ Starfield1 } //  1, 2, ... , 6
        scale 10000
      } //end of sphere -----------------------
//---------------------------------------------

 */



      
       
       
// fog on the ground -------------------------------------------------
fog { fog_type   2
      distance   50
      color      White  
      fog_offset 0.1
      fog_alt    1.5
      turbulence 1.8
    }

// ground ------------------------------------------------------------
plane { <0,1,0>, 0 
        texture{ pigment{ color rgb<0.35,0.65,0.0>*0.72 }
             normal { bumps 0.75 scale 0.015 }
                 finish { phong 0.1 }
               } // end of texture
      } // end of plane




#declare Bone =
cylinder{<0,.33,0><0,5.33,0>.25  
        texture {T_Chrome_5E}  
        } 

#declare BoneSleeve =
    cylinder{<0,1.33,0><0,4.33,0>.35  
        texture { pigment {Sapphire_Agate}} 
        finish { phong 2 } 
        }


 #declare Socket=
 sphere{<0,5.33,0>.33 
 texture {T_Chrome_5E}  
        }
           
 #declare Rod=
 union {  object{Bone}
          object{Socket} 
          object{Socket translate<0,-5,0> }  
          object{BoneSleeve}
          }  
          
   
        
  #declare Shoulder =
        sphere{<.5,5.5,.5>.7 
                       texture{
                              pigment {Sapphire_Agate}
                              }
                       } 
                         
  #declare Joint =  
            sphere {<.5,2,.5>.7   
                       texture{
                              pigment {Sapphire_Agate}
                              }
                      }

             
                      
#declare Arm1=   
union {
    object{Shoulder}
    object {Rod}   
    object{Rod rotate<70,0,0> scale .9
           }              
   
} 

#declare Arm2=   
union {
    object{Shoulder translate<-1,0,0>}
    object {Rod rotate<0,0,10>}   
    object{Rod rotate<1000,0,0> scale .9 
           }              
} 

#declare Leg1=  
union { 
        object { Joint translate <3.5,5.1,-0.5> scale <0,0,2.5>}
        object {//Round_Cone( point A, radius A, point B, radius B, rounding radius, merge on) 
         Round_Cone( <0,0,0>, 0.70    , <0,1.2,0>, 0.40 , 0.15, 0)  
         
         texture{ pigment{White}
                //normal { radial sine_wave frequency 30}
                  finish { phong 1 }
                  scale .25 
                } // end of texture
         scale<2.1,5.6,5>  rotate<0,0,0> translate<4,0.0,0>
       } // ----------------------------------------------------------- end Round_Cone 


} 

#declare Leg2=  
union { 
        object { Joint translate <6.5,5.1,-0.5> scale <0,0,2.5>}
        object {//Round_Cone( point A, radius A, point B, radius B, rounding radius, merge on) 
         Round_Cone( <0,0,0>, 0.70    , <0,1.2,0>, 0.40 , 0.15, 0)  
         
         texture{ pigment{White}
                //normal { radial sine_wave frequency 30}
                  finish { phong 1 }
                  scale .25 
                } // end of texture
         scale<2.1,5.6,5>  rotate<0,0,0> translate<7,0.0,0>
       } // ----------------------------------------------------------- end Round_Cone 


}
                
 /*
         object { EYE
                  torus { 0.35,0.15 
        texture { pigment{ color rgb<1,1,1>*0.15 }
                  finish { phong 0.4 }
                } // end of texture
        scale <1,1,1> rotate<90,0,0> translate<0,0.50,0>
      } // end of torus  -------------------------------              
     
         }  */
     
          
#declare Torso =  superellipsoid{ <0.25,0.25> 

     texture{ pigment{White}
              finish { phong 4 }
            } // end of texture
     scale <2.5,4,3> 
     rotate<0,0,0> 
     translate<5.5,11.5,0>  //right, up, back
   } // -------------- end superellipsoid

#declare Button =   superellipsoid{ <1.00,0.25> 

     texture{ pigment{ Sapphire_Agate }
              finish { phong 3 }
     } // end of texture
     scale <0.3,0.3,0.1> 
     rotate<0,0,0> 
     translate<0,3,3>
   } // ----------------- end superellipsoid
             
    
#declare Body=
union {
         object {Torso} 
         object {Button translate <4,6,0>} 
         object {Button translate <4,8,0>} 
         object {Button translate <4,10,0>} 
         object {Button translate <4,11.5,0>} 
         object {Button translate <7,6,0>}    
         object {Button translate <7,8,0>}
         object {Button translate <7,10,0>}   
         object {Button translate <7,11.5,0>}
        
}

#declare Neck =  //    Column_N(  N, Radius, Height )
object{ Column_N( 10,    0.7,   1.00 )
        texture{ pigment{ Sapphire_Agate } 
                 normal { bumps 0.25 scale 0.005 } 
                 finish { phong 3}
               } // end texture
        scale <1.5,0.5,1.8> rotate<0,0,0> translate<5.5,15.9,0>
      } // end of object -----------------------------------------------------


 #declare Eye =   superellipsoid{ <1.00,0.25> 

     texture{ pigment{ color Orange }
              finish { phong 4 }
     } // end of texture
     scale <0.6,0.6,0.1> 
     rotate<0,0,0> 
     translate<6.5,18.75,3>
   } // ----------------- end superellipsoid
             
 
#declare Antenna = cone { <0,0,0>,0.75,<0,1.50,0>,0 

       texture { pigment{Sapphire_Agate}
                 finish { phong 3 reflection{ 0.00 metallic 0.00} } 
               } // end of texture

       scale <0.4,2.5,0.5> rotate<0,0,0> translate<5.5,20.5,0>         
     } // end of cone -------------------------------------



#declare Head = 
union {
        object {Neck} 
        //-------------------------------------------------------------------------- 
        object{ //Spheroid(  CenterVector,   RadiusVector Rx,Ry,Rz )  
             Spheroid(<-1.50,2.00,-2.00>,       <2.0,1.2,2.5> )
         
            texture{ pigment{ White }
                    finish { phong 4 }
                } // end of texture
             scale<1.6,1.8,1>  rotate<0,0,0> translate<8,15,2>
           } 
          //-------------------------------------------------------------------------- 
         object{ superellipsoid{ <1.00,0.25>              //Face

          texture{ pigment{color rgb< 1, 1, 1>*0.00  }
              finish { phong 5 }
            } // end of texture
           scale <2.3,1.6,.5> 
         rotate<10,-10,3> 
         translate<5.2,18.2,2.4>
            } // ----------------- end superellipsoid   
          }
          // ----------------------------------------------------------------
         object {                                           //Mouth
                  torus { 0.35,0.15 
               texture { pigment{ color White }
                  finish { phong 0.4 }
                } // end of texture
               scale <1,1,1> rotate<90,0,0> translate<5,17.5,3>
             } // end of torus  -------------------------------              
          
            }
                  
          object {Eye translate <-0.2,-0.4,0.3>} 
          object {Eye translate <-2.6,-0.25,0>}  
          object {Antenna}
          
          
          
 }                                        
                     
 #declare SoccerBall = sphere { <0,0,0>, 0.5 
                                                  
     texture{
          pigment{ hexagon //a faked soccer ball
          color rgb<1,1,1>*1.0
          color rgb<1,1,1>*0.0
          color rgb<1,1,1>*0.5
          scale <0.115/pi,0.25/pi,0.075>*1.65
          warp { // see "warp mapping"
            spherical
            orientation <0,1,0>
          }// end warp        
           scale 0.175  rotate<40,0,0> }
             } // end of texture
             
          scale<5,5,5>  rotate<140,0,0>  translate<-2,2.5,0>  
       }  // end of sphere ----------------------------------- 
 
 
 // Pond ---------------------------------------------------------------------
    sphere { <0,0,0>, 1.25  
         scale<90,0.1,100>
         
        
       texture{ Polished_Chrome
                normal { waves 1.6 phase clock turbulence 3.2  }
                finish { reflection 0.60 specular .9 roughness .1 }
                scale  15
              }
         rotate<0,0,0>  translate<-80,0,-60>  
       }  // end of sphere -------------------------------------------------- 


  height_field{ png "plasma3.png" smooth double_illuminate
              // file types: 
              // gif | tga | pot | png | pgm | ppm | jpeg | tiff | sys
              // [water_level N] // truncate/clip below N (0.0 ... 1.0)
              translate<-0.5, -1,0>
              scale<60,-3, 60> 
              texture{ pigment { color rgb <0.85,0.6,0.4>}
                       normal  { bumps 0.75 scale 0.025  }
                     } // end of texture
              rotate<0,0,0>
              translate<0,-1,0>
            } // end of height_field ----------------------------------

 
 
 #declare Flame__Shape =
merge{    // egg
intersection{
   sphere{<0,0,0>,1}
   box{<-1,-1,-1>,< 1,1  ,1>}
   scale <1,2.5,1>}
intersection{
   sphere{<0,0,0>,1}
   box{<-1,-1 ,-1>,< 1,0+0.01,1>}
   }
} // end of merge

#declare Flame =
object{
 
  Flame__Shape 
 
  hollow
  pigment{ color rgbf<1,1,1,1>}// clear!
  finish { ambient 0 diffuse 0 }
  interior {
    media {    emission color rgb<1.0, 0.75, 0.1>*2.75
    intervals 3
    samples 32
    method 3
    aa_threshold 0.1 aa_level 5
    density{ crackle  turbulence 0.3
             scale 0.75 translate<0,24,0>
             color_map {
                    [0 rgb 0]
                    [0.00 rgb 0]
                    [0.07 rgb 1]
                    [0.10 rgb 1]
                    [0.12 rgb 0]
                    [1.00 rgb 0]
              } // end color_map
           } // end density
     density{ spherical
              color_map {
                    [0 rgb 0]
                    [0.7 rgb 1]
                    [1 rgb 1]
                } // end color_map
            } // end density
   scale<2,3.5,2>*0.5
   translate<0,0.01,0>
    }//end of media 
    }//end of interior
 
}//-----------------------------------   

    
 
 
 
                                         
//---------------------------------------------------   
  
   object {SoccerBall} 
 
    
   object {Arm1 rotate<30,20,0>
           translate<1,10,-3> 
           } 
    object {Body}    
    object {Arm2 rotate<10,-200,30>  //up,around, 
                translate<10.4,9,1>}  //
    object {Leg1}
    object {Leg2}   
    object {Head} 
    object {Flame translate <2,2,2>
                   scale <2,2,2>} 
                   
     object {Flame translate <3.5,2,2>
                   scale <2,2,2>} 
                   
      object {Flame translate <2,5,2>
                   scale <1,3,1>}                
//---------------------------------------------------     


    






 
 
 
 /*          
       
 //axis display 
   object {cylinder {<-100,0,0><100,0,0>.1
               texture{ 
                        pigment{
                         color rgb<1,0,0>
                         }
                       }
                     }
           }
     object {cylinder {<0,0,-100><0,0,100>.1
               texture{ 
                        pigment{
                         color rgb<0,1,0>
                         }
                       }
                     }
           }
          object {cylinder {<0,-100,0><0,100,0>.1
               texture{ 
                        pigment{
                         color rgb<0,0,1>
                         }
                       }
                     }
           }  
           
 */   