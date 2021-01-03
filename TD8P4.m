clc;
clear all;
close all;
%1)
load signal.mat;
Fe=100000;
Te=1/Fe;
s=signal;
N=length(s); %longueur du signal
temp=0:Te:(N-1)*Te; % vecteur temps
f1=40000;
f2=20000;
figure(1)
plot(s)
title('Repr�sentation de signal')

%2)
figure(2)
Freq = (-N/2:(N/2-1))*Fe/N;
FFTsignal = (1/Fe)*abs(fftshift(fft(s)));
plot(Freq,FFTsignal);
title('Repr�sentation fr�quencielle')
xlabel('Fr�quence en Hz')
ylabel('Amplitude')
grid on
zoom on
% on a bien 2 fr�quences de coupure : 20 kHZ et 40 kHz


%3)
r=0.9;
f40=40000;
f20=20000;
num=[1,0,0];
de40=[1,-2*r*cos(2*pi*f40*Te),r.^(2)];
de20=[1,-2*r*cos(2*pi*f20*Te),r.^(2)];
y40=filter(num,de40,s);
y20=filter(num,de20,s);

FFTy40 =(1/Fe)*abs(fftshift(fft(y40)));
FFTy20 =(1/Fe)*abs(fftshift(fft(y20)));

figure(3)
plot(Freq,FFTy40);
title('Repr�sentation fr�quencielle FFTy40')
xlabel('Fr�quence en Hz')
ylabel('Amplitude')
grid on
zoom on

figure(4)
plot(Freq,FFTy20);
title('Repr�sentation fr�quencielle FFTy20')
xlabel('Fr�quence en Hz')
ylabel('Amplitude')
grid on
zoom on

%4)
figure(5)
plot(temp,s,temp,y20,temp,y40);
title('Repr�sentation signal filtr�')
xlabel('n')
legend('s(t)','y(20)','y(r=40)')
ylabel('amplitude')
grid on
zoom on

%s�quence
binaire=zeros(1,900);
Ind=find(y20>y40);
binaire(Ind)=1;
plot(binaire)
title('sequence 0-1 du signal')



% � lancer s�par�ment

%5)
load('signal2.mat');
s2=signal;
Fe=100000;
Te=1/Fe;
N=length(s2); %longueur du signal
temp2=0:Te:(N-1)*Te; % vecteur temps
f1=35000;
f2=40000;
figure(1)
plot(s2)
title('Repr�sentation de signal')

figure(2)
Freq = (-N/2:(N/2-1))*Fe/N;
FFTsignal = (1/Fe)*abs(fftshift(fft(s2)));
plot(Freq,FFTsignal);
title('Repr�sentation fr�quencielle')
xlabel('Fr�quence en Hz')
ylabel('Amplitude')
grid on
zoom on
% on a bien 2 fr�quences de coupure : 35 kHZ et 40 kHz

r=0.9;
f40=40000;
f35=35000;
num=[1,0,0];
de40=[1,-2*r*cos(2*pi*f40*Te),r.^(2)];
de35=[1,-2*r*cos(2*pi*f35*Te),r.^(2)];
y40=filter(num,de40,s2);
y35=filter(num,de35,s2);

FFTy40 =(1/Fe)*abs(fftshift(fft(y40)));
FFTy35 =(1/Fe)*abs(fftshift(fft(y35)));

figure(3)
plot(Freq,FFTy40);
title('Repr�sentation fr�quencielle FFTy40')
xlabel('Fr�quence en Hz')
ylabel('Amplitude')
grid on
zoom on

figure(4)
plot(Freq,FFTy35);
title('Repr�sentation fr�quencielle FFTy35')
xlabel('Fr�quence en Hz')
ylabel('Amplitude')
grid on
zoom on

figure(5)
plot(temp2,s2,temp2,y35,temp2,y40);
title('Repr�sentation signal filtr�')
xlabel('n')
legend('s2(t)','y(35)','y(40)')
ylabel('amplitude')
grid on
zoom on

%s�quence
binaire=zeros(1,900);
Ind=find(y35>y40);
binaire(Ind)=1;
plot(binaire)
title('sequence 0-1 du signal')



