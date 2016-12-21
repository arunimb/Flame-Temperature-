clc
clear all
close all

phi=1.1;
x=7;
y=16;
a=x+y/4;
a=a/phi;
f=3.76*a;
b=0.0001;
cb=0.00001;

Tavg=1000;

for i=1:10
    clc
    Kp=CF(Tavg,'Kp','O');
    berror=1;
    b=0.00001;
    while abs(berror)>=0.001 && b<=7
        c=x-b;
        d=2*a-x-b;
        e=2*x-2*a+b+1;
        berror=Kp-(b*e/(d*c));
        b=b+cb;
    end
    if b>=7
        sprintf('Error')
        break;
    end
        
    
    z=b*CF(Tavg,'Cp','CO2')+c*CF(Tavg,'Cp','CO')+d*CF(Tavg,'Cp','H2O')+e*CF(Tavg,'Cp','H2')+f*CF(Tavg,'Cp','N2');
    
    zz=b*(-393546)+c*(-110541)+d*(-241845)+187820;
    zz=-1*zz;
    
    Tf=(zz+298*z)/z;
    Tavg=(Tf+298)/2;
%     pause
end
tm=b+c+d+e+f;
disp(sprintf('Adiabatic Flame Temperature is %0.1f K',Tf));
disp(sprintf('Mole Fraction:-'));
disp(sprintf('CO2 %0.4f,CO %d,H2O %0.4f,H2 %0.4f \nN2 %0.4f',b/tm,c/tm,d/tm,e/tm,f/tm));
