// Stabilization - East
FD=abs(:F1S-:O1S) UD=abs(:U1S-:O1S) i=(FD<2.5)*(UD<2.5) :Chk1=i
if :Chk1*:Chk2*:Chk3 then :O1=:O1S :F1=:F1S :U1=:U1S end goto1

// Stabilization - West
FD=abs(:F2S-:O2S) UD=abs(:U2S-:O2S) i=(FD<2.5)*(UD<2.5) :Chk2=i 
if :Chk1*:Chk2*:Chk3 then :O2=:O2S :F2=:F2S :U2=:U2S end goto1

// Stabilization - North
FD=abs(:F3S-:O3S) UD=abs(:U3S-:O3S) i=(FD<2.5)*(UD<2.5) :Chk3=i
if :Chk1*:Chk2*:Chk3 then :O3=:O3S :F3=:F3S :U3=:U3S end goto1

// Stabilization - Origin Synchronization 
:Nav=:Chk1*:Chk2*:Chk3 goto1

// Trilateration - O
O=241868 P=14625000000 Q=128996 R=145121 M=1000000 T=9425000000 h=0.5
A=M-:O3 B=M-:BS C=M-:O1 D=M-:O2 N=A*A S=B*B E=C*C W=D*D K=:ZSg
:OX=(E-W+P)/O :OY=(E-N+T-Q*:OX)/R :OZ=K*(E-:OX^2-:OY^2)^h goto(3-:Nav)

// Trilateration - F
O=241868 P=14625000000 Q=128996 R=145121 M=1000000 T=9425000000 h=0.5
A=M-:F3 B=M-:BS C=M-:F1 D=M-:F2 N=A*A S=B*B E=C*C W=D*D K=:ZSg
:FX=(E-W+P)/O :FY=(E-N+T-Q*:FX)/R :FZ=K*(E-:FX^2-:FY^2)^h goto(3-:Nav)

// Trilateration - U
O=241868 P=14625000000 Q=128996 R=145121 M=1000000 T=9425000000 h=0.5
A=M-:U3 B=M-:BS C=M-:U1 D=M-:U2 N=A*A S=B*B E=C*C W=D*D K=:ZSg
:UX=(E-W+P)/O :UY=(E-N+T-Q*:UX)/R :UZ=K*(E-:UX^2-:UY^2)^h goto(3-:Nav)

// Trilateration - Reflection
G=(66359-:X)^2+(-37279-:Y)^2 R=(1000000-:BS) n=71111 :ZSg=1/(:ZSg==0)
A=abs(R-(G+(n-abs(:Z))^2)^.5) B=abs(R-(G+(n+abs(:Z))^2)^.5)
:ZSg = B>A - A>B goto1 

// Stabilization - X
FD=abs(:FX-:OX) UD=abs(:UX-:OX) i=(FD<2.5)*(UD<2.5) :Ch1=i goto1

// Stabilization - Y
FD=abs(:FY-:OY) UD=abs(:UY-:OY) i=(FD<2.5)*(UD<2.5) :Ch2=i goto1

// Stabilization - Z
FD=abs(:FZ-:OZ) UD=abs(:UZ-:OZ) i=(FD<2.5)*(UD<2.5) :Ch3=i goto1

// Stabilization - Coordinate Synchronization 
:Nav2=:Ch1*:Ch2*:Ch3 if :Nav2 then :X=:OX :Y=:OY :Z=:OZ end goto1

// Normalization - U
X=:UX-:OX Y=:UY-:OY Z=:UZ-:OZ c=(X<2)*(Y<2)*(Z<2) N=(X^2+Y^2+Z^2)^.5
if c then :ui=X/N :uj=Y/N :uk=Z/N end goto1

// Normalization - F
X=:FX-:OX Y=:FY-:OY Z=:FZ-:OZ c=(X<2)*(Y<2)*(Z<2) N=(X^2+Y^2+Z^2)^.5
if c then :fi=X/N :fj=Y/N :fk=Z/N end goto1

// Normalization - R
:ri=:fj*:uk-:fk*:uj :rj=:fk*:ui-:fi*:uk :rk=:fi*:uj-:fj*:ui goto1

// Translation - XYZ
A=:X-X B=:Y-Y C=:Z-Z X=:X Y=:Y Z=:Z d++ goto(1+((A+B+C)!=0))
d+=d%2 :vX=A/d/0.2 :vY=B/d/0.2 :vZ=C/d/0.2 d=2 :DX=A :DY=B :DZ=C goto1

// Stabilization - vF
i=3
:vF=(S1+S2+S3+S4+S5)/5000*1000 :vFv=(D1+D2+D3+D4+D5)/5000*1000 gotoi
S1=:vX*:fi+:vY*:fj+:vZ*:fk i++ D1=abs(:vF-S1) goto2
S2=:vX*:fi+:vY*:fj+:vZ*:fk i++ D2=abs(:vF-S2) goto2
S3=:vX*:fi+:vY*:fj+:vZ*:fk i++ D3=abs(:vF-S3) goto2
S4=:vX*:fi+:vY*:fj+:vZ*:fk i++ D4=abs(:vF-S4) goto2
S5=:vX*:fi+:vY*:fj+:vZ*:fk i=3 D5=abs(:vF-S5) goto2

// Stabilization - vU
i=3
:vu=(S1+S2+S3+S4+S5)/5000*1000 :vuv=(D1+D2+D3+D4+D5)/5000*1000 gotoi
S1=:vX*:ui+:vY*:uj+:vZ*:uk i++ D1=abs(:vu-S1) goto2
S2=:vX*:ui+:vY*:uj+:vZ*:uk i++ D2=abs(:vu-S2) goto2
S3=:vX*:ui+:vY*:uj+:vZ*:uk i++ D3=abs(:vu-S3) goto2
S4=:vX*:ui+:vY*:uj+:vZ*:uk i++ D4=abs(:vu-S4) goto2
S5=:vX*:ui+:vY*:uj+:vZ*:uk i=3 D5=abs(:vu-S5) goto2

// Stabilization - vR
i=3
:vr=(S1+S2+S3+S4+S5)/5000*1000 :vrv=(D1+D2+D3+D4+D5)/5000*1000 gotoi
S1=:vX*:ri+:vY*:rj+:vZ*:rk i++ D1=abs(:vr-S1) goto2
S2=:vX*:ri+:vY*:rj+:vZ*:rk i++ D2=abs(:vr-S2) goto2
S3=:vX*:ri+:vY*:rj+:vZ*:rk i++ D3=abs(:vr-S3) goto2
S4=:vX*:ri+:vY*:rj+:vZ*:rk i++ D4=abs(:vr-S4) goto2
S5=:vX*:ri+:vY*:rj+:vZ*:rk i=3 D5=abs(:vr-S5) goto2

// Stabilization - u
i=4
:uia=(A1+A2+A3)/30*10 :uja=(B1+B2+B3)/30*10 :uka=(C1+C2+C3)/30*10
:uiad=(D1+D2+D3)/3 :ujad=(E1+E2+E3)/3 :ukad=(F1+F2+F3)/3 gotoi
A1=:ui B1=:uj C1=:uk D1=:uia-A1 E1=:uja-B1 F1=:uka-C1 i++ goto2
A2=:ui B2=:uj C2=:uk D2=:uia-A2 E2=:uja-B2 F2=:uka-C2 i++ goto2
A3=:ui B3=:uj C3=:uk D3=:uia-A3 E3=:uja-B3 F3=:uka-C3 i=4 goto2

// Stabilization - f
i=4
:fia=(A1+A2+A3)/30*10 :fja=(B1+B2+B3)/30*10 :fka=(C1+C2+C3)/30*10
:fiad=(D1+D2+D3)/3 :fjad=(E1+E2+E3)/3 :fkad=(F1+F2+F3)/3 gotoi
A1=:fi B1=:fj C1=:fk D1=:fia-A1 E1=:fja-B1 F1=:fka-C1 i++ goto2
A2=:fi B2=:fj C2=:fk D2=:fia-A2 E2=:fja-B2 F2=:fka-C2 i++ goto2
A3=:fi B3=:fj C3=:fk D3=:fia-A3 E3=:fja-B3 F3=:fka-C3 i=4 goto2

// Stabilization - r
i=4
:ria=(A1+A2+A3)/30*10 :rja=(B1+B2+B3)/30*10 :rka=(C1+C2+C3)/30*10
:riad=(D1+D2+D3)/3 :rjad=(E1+E2+E3)/3 :rkad=(F1+F2+F3)/3 gotoi
A1=:ri B1=:rj C1=:rk D1=:ria-A1 E1=:rja-B1 F1=:rka-C1 i++ goto2
A2=:ri B2=:rj C2=:rk D2=:ria-A2 E2=:rja-B2 F2=:rka-C2 i++ goto2
A3=:ri B3=:rj C3=:rk D3=:ria-A3 E3=:rja-B3 F3=:rka-C3 i=4 goto2

// Synchronization - u
t=0.05
:Ori1=(abs(:uiad)<t)*(abs(:ujad)<t)*(abs(:ukad)<t) goto2

// Synchronization - f
t=0.05
:Ori2=(abs(:fiad)<t)*(abs(:fjad)<t)*(abs(:fkad)<t) goto2

// Synchronization - r
t=0.05
:Ori3=(abs(:riad)<t)*(abs(:rjad)<t)*(abs(:rkad)<t) goto2

// Synchronization - ufr
:Ori=:Ori1*:Ori2*:Ori3 goto1

// WayPoint - Distance
:DWPx=:WPCX-:X :DWPy=:WPCY-:Y :DWPz=:WPCZ-:Z h=.5
:DWPD=(:DWPx^2+:DWPx^2+:DWPx^2)^h goto1

// WayPoint - Projection
R=x*:ria+y*:rja+z*:rka F=x*:fia+y*:fja+z*:fka U=x*:uia+y*:uja+z*:uka
x=:DWPx y=:DWPy z=:DWPz if :Ori then :WPCR=R :WPCF=F :WPCU=U end goto1

// WayPoint - Yaw
k=R>0-0>R j=1/3 c=i*(2-(2+2*a)^h)^h-j*(2-2*a)^h :Yaw=k*c*b/:Ori 
R=:WPCR F=:WPCF a=(F^2+R^2)^h a=F/a h=.5 b=57.296 i=8/3 goto1  
  
// WayPoint - Pitch
k=t^2>1 m=1-2*(t<0) t^=1-2*k t*=b/(1+i*t^2) :Pit=m*k*90+(k<1-k)*t/:Ori 
R=:WPCR F=:WPCF U=:WPCU h=.5 b=57.296 i=0.281 t=U/(F^2+R^2)^h goto1

// Display - Location
h="Signa :1  : Trope :   : Coord :"
:1=h+"\nX:"+(:X/10*10)+"\nY:"+(:Y/10*10)+"\nZ:"+(:Z/10*10) goto1

// Display - Delta
h="Signa :2  : Trope :   : Delta :"
:2=h+"\nDX:"+(:DX/10*10)+"\nDY:"+(:DY/10*10)+"\nDZ:"+(:DZ/10*10) goto1

// Display - Speed
S="Signa :3  : Trope :   : Speed : "+"\nFB:"+:vF+"±"+:vFv
:3=S+"\nRL:"+:vR+"±"+:vRv+"\nUD:"+:vU+"±"+:vUv+"\n    m/s" goto1

// Display - WayPoint
a=1000 h="Signa :4  : Trope :   : Dest. :"+"\nDX:"+(:DWPx/a*a)+"\nDY:"
:4=h+(:DWPy/a*a)+"\nDZ:"+(:DWPz/a*a)+"\nD:"+(:DWPD/a*a)+" m" goto1

// Display - Compass Horizontal
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

// Display - Compass Vertical
t="  ¦   :0 " b="0:   ¦   :0 " l="            " m="-    +    - "
j=(:Pit/10)/1000*1000 if j>2 then j=2 end if j<-2 then j=-2 endgotoj+5
c=" "+:horcom+"  " :0=t+l+l+m+l+c+b :verctr=0 goto2
c=" "+:horcom+"  " :0=t+l+l+m+c+l+b :verctr=0 goto2     
c="-"+:horcom+"- " :0=t+l+l+c+l+l+b :verctr=1 goto2
c=" "+:horcom+"  " :0=t+l+c+m+l+l+b :verctr=0 goto2
c=" "+:horcom+"  " :0=t+c+l+m+l+l+b :verctr=0 goto2
