// --------------------------Synchronized-------------------------- //

//    Memory 1    //    Memory 2    //
// cw0            // cw1            //
// cw1            // cw2            //
// cw2            // cw3            //
// cw3            // cw4            //
// cw4            // cw5            //
// cw5            // Speed          //
// Speed          // Delta          //
// Delta          // Stabilization  //
// Stabilization  // FlushReceivers //
// FlushReceivers // cw-            //

// Scheduler Start - Start
:cw0=0 goto1

// Scheduler Stop - cw0
:cw0=-1 goto1

// Flush Receivers - FlushReceivers
:TargetFrequency=2 :TargetFrequency=1 goto1

// Stabilization - Stabilization
:O1=:O :F1=:F :U1=:U :O2=:P :F2=:G :U2=:V :O3=:Q :F3=:H :U3=:W goto1

// Trilateration Delta - Delta
O=241868 P=14625000000 Q=128996 R=145121 M=1000000 T=9425000000 h=0.5
N=M-:O3 E=M-:O1 W=M-:O2 N*=N E*=E W*=W :DX=X-A :DY=Y-B :DZ=Z-C
A=X B=Y C=Z X=(E-W+P)/O Y=(E-N+T-Q*X)/R Z=:ZSg*(E-X^2-Y^2)^h goto2

// Speed - Speed
:vf=X*:fi+Y*:fj+Z*:fk :vu=X*:ui+Y*:uj+Z*:uk :vr=X*:ri+Y*:rj+Z*:rk 
d=0.6 X=:DX/d Y=:DY/d Z=:DZ/d goto1

// --------------------------Synchronized-------------------------- //

// --------------------------Asynchronized------------------------- //

// Signal Stability Indicator
t=2.5^2 A=:F1-:O1 B=:U1-:O1 C=:F2-:O2 D=:U2-:O2 E=:F3-:O3 F=:U3-:O3
:Nav=(A^2<t)*(B^2<t)*(C^2<t)*(D^2<t)*(E^2<t)*(F^2<t) goto1

// Coordinate Stability Indicator
A=abs(:D4) B=abs(:D) C=abs(:D5) D=abs(:D2) E=abs(:D6) F=abs(:D3) 
t=2.5 :Cord=(A<t)*(B<t)*(C<t)*(D<t)*(E<t)*(F<t)

// Orientation Stability Indicator
:Ori=abs(:ui*:fi+:uj*:fj+:uk*:fk)<0.087 goto1

// Trilateration - U
O=241868 P=14625000000 Q=128996 R=145121 M=1000000 T=9425000000 h=0.5
N=M-:U3 S=M-:BS E=M-:U1 W=M-:U2 N*=N S*=S E*=E W*=W K=:ZSg
:UX=(E-W+P)/O :UY=(E-N+T-Q*:UX)/R :UZ=K*(E-:UX^2-:UY^2)^h 
goto2

// Trilateration - F
O=241868 P=14625000000 Q=128996 R=145121 M=1000000 T=9425000000 h=0.5
N=M-:F3 S=M-:BS E=M-:F1 W=M-:F2 N*=N S*=S E*=E W*=W K=:ZSg
:FX=(E-W+P)/O :FY=(E-N+T-Q*:FX)/R :FZ=K*(E-:FX^2-:FY^2)^h
goto2

// Trilateration - O
O=241868 P=14625000000 Q=128996 R=145121 M=1000000 T=9425000000 h=0.5
N=M-:O3 S=M-:BS E=M-:O1 W=M-:O2 N*=N S*=S E*=E W*=W K=:ZSg
:X=(E-W+P)/O :Y=(E-N+T-Q*:X)/R :Z=K*(E-:X^2-:Y^2)^h 
:D=:UX-:X :D2=:UY-:Y :D3=:UZ-:Z :D4=:FX-:X :D5=:FY-:Y :D6=:FZ-:Z goto2

// Trilateration - Reflection
G=(66359-:X)^2+(-37279-:Y)^2 R=(1000000-:BS) n=71111 :ZSg=1/(:ZSg==0)
A=abs(R-(G+(n-abs(:Z))^2)^.5) B=abs(R-(G+(n+abs(:Z))^2)^.5)
:ZSg = B>A - A>B goto1 

// Orientation - U and F
h=.5
X=:D Y=:D2 Z=:D3 N=(X^2+Y^2+Z^2)^h A=:D4 B=:D5 C=:D6 M=(A^2+B^2+C^2)^h
:ui=X/N :uj=Y/N :uk=Z/N :fi=A/M :fj=B/M :fk=C/M goto2

// Orientation - R
:ri=:fj*:uk-:fk*:uj :rj=:fk*:ui-:fi*:uk :rk=:fi*:uj-:fj*:ui goto1

// Direction - Distance
:DWPx=:WPCX-:X :DWPy=:WPCY-:Y :DWPz=:WPCZ-:Z h=.5
:DWPD=(:DWPx^2+:DWPx^2+:DWPx^2)^h goto1

// Direction - Projection
x=:DWPx y=:DWPy z=:DWPz :WPCR=R :WPCF=F :WPCU=U
R=x*:ri+y*:rj+z*:rk F=x*:fi+y*:fj+z*:fk U=x*:ui+y*:uj+z*:uk goto1

// Direction - Yaw
h=.5 b=57.296 i=8/3 j=1/3
R=:WPCR F=:WPCF a=(F^2+R^2)^h a=F/a k=R>0-0>R
c=i*(2-(2+2*a)^h)^h-j*(2-2*a)^h :Yaw=k*c*b goto2

// Direction - Pitch
h=.5 b=57.296 i=0.281
R=:WPCR F=:WPCF U=:WPCU  t=U/(F^2+R^2)^h k=t^2>1 m=1-2*(t<0)
t^=1-2*k t*=b/(1+i*t^2) :Pit=m*k*90+(k<1-k)*t goto2

// --------------------------Asynchronized------------------------- //

// -------------------------Display Drivers------------------------ //

// Display - Location
h="Signa :1  : Trope :   : Coord :"
:1=h+"\nX:"+(:X/10*10)+"\nY:"+(:Y/10*10)+"\nZ:"+(:Z/10*10) goto1

// Display - Delta
h="Signa :2  : Trope :   : Delta :"
:2=h+"\nDX:"+(:DX/10*10)+"\nDY:"+(:DY/10*10)+"\nDZ:"+(:DZ/10*10) goto1

// Display - Speed
S="Signa :3  : Trope :   : Speed : "+"\nFB:"+:vF
:3=S+"\nRL:"+:vR+"\nUD:"+:vU+"\n    m/s" goto1

// Display - WayPoint
a=1000 h="Signa :4  : Trope :   : Dest. :"+"\nDX:"+(:DWPx/a*a)+"\nDY:"
:4=h+(:DWPy/a*a)+"\nDZ:"+(:DWPz/a*a)+"\nD:"+(:DWPD/a*a)+" m" goto1

// Display - CrossHair Horizontal
s=" " c="×"
i=(:Yaw/10)/1000*1000 if i>4 then i=4 end if i<-4 then i=-4 endgotoi+7
:horcom=c+s+s+s+s+s+s+s+s :navcentered=0 goto2
:horcom=s+c+s+s+s+s+s+s+s goto2
:horcom=s+s+c+s+s+s+s+s+s goto2
:horcom=s+s+s+c+s+s+s+s+s goto2
p=c if :verctr then p="※" end  :horcom=s+s+s+s+p+s+s+s+s goto2
:horcom=s+s+s+s+s+c+s+s+s goto2
:horcom=s+s+s+s+s+s+c+s+s goto2
:horcom=s+s+s+s+s+s+s+c+s goto2
:horcom=s+s+s+s+s+s+s+s+c goto2

// Display - CrossHair Vertical
t="  ¦   :0 " b="0:   ¦   :0 " l="            " m="-    +    - "
j=(:Pit/10)/1000*1000 if j>2 then j=2 end if j<-2 then j=-2 endgotoj+5
c=" "+:horcom+"  " :0=t+l+l+m+l+c+b :verctr=0 goto2
c=" "+:horcom+"  " :0=t+l+l+m+c+l+b :verctr=0 goto2     
c="-"+:horcom+"- " :0=t+l+l+c+l+l+b :verctr=1 goto2
c=" "+:horcom+"  " :0=t+l+c+m+l+l+b :verctr=0 goto2
c=" "+:horcom+"  " :0=t+c+l+m+l+l+b :verctr=0 goto2

// -------------------------Display Drivers------------------------ //
