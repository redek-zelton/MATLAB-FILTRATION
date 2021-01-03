clc;
clear all;
close all;

Fe=1;
Te=1/Fe;
N=200;
Freq=-Fe/2:Fe/199:Fe/2;% 200 points
ech=1:1:N;
f0=0; % f0 modifiable 0, 0.5, 0.25 Hz
%choix de r entre 0 et 1(exclus)
r0=0.2;
r1=0.5;
r2=0.8;

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

y11=filter(num,de0,x1);
y12=filter(num,de1,x1);
y13=filter(num,de2,x1);

y21=filter(num,de0,x2);
y22=filter(num,de1,x2);
y23=filter(num,de2,x2);

% INDITIELLE
figure(1)
plot(ech,x1,ech,y11,ech,y12,ech,y13);
title('Représentation x1(n) et y1(n) avec f0=0.25 Hz')
xlabel('n')
legend('x1(n)','y(r=0.2)','y(r=0.5)','y(r=0.8)')
ylabel('amplitude')
grid on
zoom on

% IMPULTIONNELLE
figure(2)
plot(ech,x2,ech,y21,ech,y22,ech,y23);
title('Représentation y2(n)et x2(n) avec f0=0.25 Hz')
legend('x2(n)','y(r=0.2)','y(r=0.5)','y(r=0.8)')
xlabel('n')
ylabel('amplitude')
grid on
zoom on

%FREQUENTIELLE
FFTy11 =(1/Fe)*abs(fftshift(fft(y11)));
FFTy12 =(1/Fe)*abs(fftshift(fft(y12)));
FFTy13 =(1/Fe)*abs(fftshift(fft(y13)));
FFTy21 =(1/Fe)*abs(fftshift(fft(y21)));
FFTy22 =(1/Fe)*abs(fftshift(fft(y22)));
FFTy23 =(1/Fe)*abs(fftshift(fft(y23)));

figure(3)
plot(Freq,FFTy11,Freq,FFTy12,Freq,FFTy13);
title('Représentation fréquencielle FFTy1(f)- f0=0.5 Hz')
legend('FFTy1(r=0.2)','FFTy1(r=0.5)','FFTy1(r=0.8)')
xlabel('Fréquence en Hz')
ylabel('Amplitude')
grid on
zoom on

figure(4)
plot(Freq,FFTy21,Freq,FFTy22,Freq,FFTy23);
title('Représentation fréquencielle FFTy2(f)- f0=0.5 Hz')
legend('FFTy2(r=0.2)','FFTy2(r=0.5)','FFTy2(r=0.8)')
xlabel('Fréquence en Hz')
ylabel('Amplitude')
grid on
zoom on


%) BODE ET POLE
sys0=tf(num,de0,Te);
sys1=tf(num,de1,Te);
sys2=tf(num,de2,Te);

% détermination du filtre
figure(5)
bodeplot(sys0,sys1,sys2)
legend('b(0.2)','b(0.5)','b(0.8)')

figure(6)
pzplot(sys0,sys1,sys2)
legend('p(r=0.2)','p(r=0.5)','p(r=0.8)')
