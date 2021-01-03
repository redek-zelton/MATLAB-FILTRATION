clc;
clear all;
close all;

%On prend f0 = 0.1 Hz. Varier r entre 
%0 et 2 avec un pas de 0.5. 
%Que peut-on déduire sur la stabilité de
%ce filtre ?

Fe=1;
Te=1/Fe;
N=200;
Freq=-Fe/2:Fe/199:Fe/2;% 200 points
ech=1:1:N;
f0=0.1;
r0=0;% on aurait pu faire r=0:0.5:2
r1=0.5;
r2=1;
r3=1.5;
r4=2;

% x1
x1=1:1:N;
Ind=find(x1>1);
x1(Ind)=0;
% x2
x2=ones(1,N);

%H
num=[1,0,0];
de0=[1,-2*r0*cos(2*pi*f0*Te),r0.^(2)];
de1=[1,-2*r1*cos(2*pi*f0*Te),r1.^(2)];
de2=[1,-2*r2*cos(2*pi*f0*Te),r2.^(2)];
de3=[1,-2*r3*cos(2*pi*f0*Te),r3.^(2)];
de4=[1,-2*r4*cos(2*pi*f0*Te),r4.^(2)];

y11=filter(num,de0,x1);% y1=zeros(1:5)
y12=filter(num,de1,x1);
y13=filter(num,de2,x1);
y14=filter(num,de3,x1);
y15=filter(num,de4,x1);

y21=filter(num,de0,x2);
y22=filter(num,de1,x2);
y23=filter(num,de2,x2);
y24=filter(num,de3,x2);
y25=filter(num,de4,x2);

% INDITIELLE : sur word affichage séparé car y5 est trop grand
figure(1)
plot(ech,x1,ech,y11,ech,y12,ech,y13,ech,y14,ech,y15);
title('Représentation x1(n) et y1(n) avec f0=0.1 Hz')
xlabel('n')
legend('x1(n)','y(r=0)','y(r=0.5)','y(r=1)','y(r=1.5)','y(r=2)')
ylabel('amplitude')
grid on
zoom on

% IMPULTIONNELLE : sur word affichage séparé car y5 est trop grand
figure(2)
plot(ech,x2,ech,y21,ech,y22,ech,y23,ech,y24,ech,y25);
title('Représentation y2(n)et x2(n) avec f0=0.1 Hz')
legend('x2(n)','y(r=0)','y(r=0.5)','y(r=1)','y(r=1.5)','y(r=2)')
xlabel('n')
ylabel('amplitude')
grid on
zoom on

%FREQUENTIELLE
FFTy11 =(1/Fe)*abs(fftshift(fft(y11)));
FFTy12 =(1/Fe)*abs(fftshift(fft(y12)));
FFTy13 =(1/Fe)*abs(fftshift(fft(y13)));
FFTy14 =(1/Fe)*abs(fftshift(fft(y14)));
FFTy15 =(1/Fe)*abs(fftshift(fft(y15)));

FFTy21 =(1/Fe)*abs(fftshift(fft(y21)));
FFTy22 =(1/Fe)*abs(fftshift(fft(y22)));
FFTy23 =(1/Fe)*abs(fftshift(fft(y23)));
FFTy24 =(1/Fe)*abs(fftshift(fft(y24)));
FFTy25 =(1/Fe)*abs(fftshift(fft(y25)));

figure(3)
plot(Freq,FFTy15);
title('Représentation fréquencielle FFTy1(f)- f0=0.1 Hz')
legend('FFTy1(r=2)')
xlabel('Fréquence en Hz')
ylabel('Amplitude')
grid on
zoom on

figure(4)
plot(Freq,FFTy25);
title('Représentation fréquencielle FFTy2(f)- f0=0.1 Hz')
legend('FFTy2(r=2)')
xlabel('Fréquence en Hz')
ylabel('Amplitude')
grid on
zoom on


%) BODE ET POLE : détermination du filtre
sys0=tf(num,de0,Te);
sys1=tf(num,de1,Te);
sys2=tf(num,de2,Te);
sys3=tf(num,de3,Te);
sys4=tf(num,de4,Te);

figure(5)
bodeplot(sys0,sys1,sys2,sys3,sys4)
legend('b(0)','b(0.5)','b(1)','b(1.5)','b(2)')

figure(6)
pzplot(sys0,sys1,sys2,sys3,sys4)
legend('p(r=0)','p(r=0.5)','p(r=1)','p(r=1.5)','p(r=2)')
