clear all;
close all;
% C) DEMULTIPLEXAGE FREQUENTIEL
%7)
load signalMUX.mat;
load temps.mat;
s=signalMUX;
t=temps;
Fe=176400;
fc1=20000;
fc2=35000;
figure(1);
plot(t,s);
xlabel('temps en s');
title('s(t)');
legend('s(t)')
grid on;
zoom on;

%8)
%sound(s,Fe); // bruit aigüe désagreable

%9)
N=length(t);
Freq = (-N/2:(N/2-1))*Fe/N;
FFTs = (1/Fe)*abs(fftshift(fft(s)));
figure(2);
plot(Freq,FFTs); % 2 fréquences de coupures 20kHz et 35 kHz 
xlabel('Freq en Hz');
title('Representation S(f)');
grid on;
zoom on;

%10)
%a) Extraction par une passe bande
w=5000; 
[b1,a1] = butter(3,[fc1-w, fc1+w]*2/Fe,'bandpass'); 
m1 = filter(b1,a1,s);
[b2,a2] = butter(3,[fc2-w, fc2+w]*2/Fe,'bandpass');   
m2 = filter(b2,a2,s);

%b)Démodulation
c1=cos(2*pi*fc1*t);
d1=m1.*c1;
c2=cos(2*pi*fc2*t);
d2=m2.*c2;


%C) Extraction par un passe bas
[bb1,aa1] = butter(3,fc1*2/Fe);
[bb2,aa2] = butter(3,fc2*2/Fe);
m1init=filter(bb1,aa1,d1);
m2init=filter(bb2,aa2,d2);

%D)

%E)
figure(3);
plot(t,m1init);
title('Représentation Temporelle')
xlabel('Temps en s')
ylabel('Amplitude')
grid on
zoom on

figure(4);
plot(t,m2init);
title('Représentation Temporelle')
xlabel('Temps en s')
ylabel('Amplitude')
grid on
zoom on

TFm1 = (1/Fe)*abs(fftshift(fft(m1init)));
TFm2 = (1/Fe)*abs(fftshift(fft(m2init)));
figure(5);
plot(Freq,TFm1);
xlabel('Freq en Hz');
title('Representation M1(f)');
grid on;
zoom on;

figure(6);
plot(Freq,TFm2);
xlabel('Freq en Hz');
title('Representation M2(f)');
grid on;
zoom on;

%f)
sound(m1init,Fe);% mais alors qu'est ce que tu veux, je veux . . .
sound(m2init,Fe);% ils sont partis en vacances !






