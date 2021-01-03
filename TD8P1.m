clear all;
close all;
N=200;
a=1.2;% -0.8 , 0.8 , 0.95 ou 1.2
ech=1:1:N
% dirac en 0
x1=1:1:200;
Ind=find(x1>1);
x1(Ind)=0;

% r�ponse y1
y1=zeros(1,N);
y1(1)=(1-a)*x1(1)
for n =2:N
   y1(n)=a*y1(n-1) + (1-a)*x1(n)
end
figure(1)
plot(ech,x1,ech,y1);
title('Repr�sentation y(n)et x(n)')
legend('x1(n)','y1(n)')
xlabel('n')
ylabel('amplitude')
grid on
zoom on


% r�ponse y2
x2=ones(1,N);% peigne de dirac
y2=zeros(1,N);
y2(1)=(1-a)*x2(1)
for n =2:N
   y2(n)=a*y2(n-1) + (1-a)*x2(n)
end
% figure �chantillon
figure(2)
plot(ech,x2,ech,y2);
title('Repr�sentation y2(n)et x2(n)')
legend('x2(n)','y2(n)')
xlabel('n')
ylabel('amplitude')
grid on
zoom on


% H(F)
Fe=1;
Freq=-Fe/2:Fe/199:Fe/2;% 200 points
Te=1/Fe;
f=-Fe/2:Fe/N:Fe/2;
z=exp(1j*2*pi*Freq*Te);
H = (1-a)./(1-a*z.^-1);


%x3(n)
n=0:1:199
Fe=1;
Te=1/Fe;
temp=n*Te % vecteur temp
fs=0.1;
x3=sin(2*pi*fs*n*Te)

y3=zeros(1,N);
y3(1)=(1-a)*x3(1)
for n =2:N
   y3(n)=a*y3(n-1) + (1-a)*x3(n)
end

%repr�sentation x3 et y3
figure(3)
plot(ech,x3,ech,y3);
title('Repr�sentation y3(n)et x3(n)')
legend('x3(n)','y3(n)')
xlabel('n')
ylabel('amplitude')
grid on
zoom on

%affiche le module de H(f) en dB avec une �chelle 
%logarithmique sur l'axe des fr�quence
figure(4)
semilogy(Freq,H);
legend('Spectre H dB')
xlabel('Fr�quence f en Hz')
ylabel('|H(f)| en dB')
grid on
zoom on
title('Passe Bas')

%affiche � nouveau le module de H(f) en dB avec
%une �chelle logarithmique sur l'axe des 
%fr�quences � partir de la r�ponse 
%impulsionnelle y1
figure(5)
FFTy1 = (1/Fe)*abs(fftshift(fft(y1)));
semilogy(Freq,FFTy1);
title('Repr�sentation fr�quencielle FFTy1')
xlabel('Fr�quence en Hz')
ylabel('Amplitude')
grid on
zoom on

%affiche les p�les et les z�ros de la 
%fonction de transfert
num=[(1-a),0]
de=[1,-a]
sys=tf(num,de,Te)
figure(6)
pzplot(sys)



