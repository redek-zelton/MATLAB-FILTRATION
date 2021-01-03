clc;
clear all;
close all;

Fe=1;
Te=1/Fe;
N=200;
Freq=-Fe/2:Fe/199:Fe/2;% 200 points
ech=1:1:N;
a=0.8; %on modifie ici a avec -0.8 ou 0.8
b=1;% on modifie ici b avec -1 ou 1

% x1
x1=1:1:N;
Ind=find(x1>1);
x1(Ind)=0;

% x2
x2=ones(1,N);

%partie filter
num=[1,b];
de=[1,-a];
yf1=filter(num,de,x1)
yf2=filter(num,de,x2)

%INDITIELLE
figure(1)
plot(ech,x1,ech,yf1);
title('Représentation yf1(n)et x1(n)')
legend('x1(n)','yf1(n)')
xlabel('n')
ylabel('amplitude')
grid on
zoom on
%IMPULTIONNELLE
figure(2)
plot(ech,x2,ech,yf2);
title('Représentation yf2(n)et x2(n)')
legend('x2(n)','yf2(n)')
xlabel('n')
ylabel('amplitude')
grid on
zoom on

%FREQUENTIELLE
FFTyf1 =(1/Fe)*abs(fftshift(fft(yf1)));
FFTyf2 =(1/Fe)*abs(fftshift(fft(yf2)));

figure(3)
plot(Freq,FFTyf1);
title('Représentation fréquencielle FFTy1')
legend('FFTy1')
xlabel('Fréquence en Hz')
ylabel('Amplitude')
grid on
zoom on

figure(4)
plot(Freq,FFTyf2);
title('Représentation fréquencielle FFTy2')
legend('FFTy2')
xlabel('Fréquence en Hz')
ylabel('Amplitude')
grid on
zoom on



