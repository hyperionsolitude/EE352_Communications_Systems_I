close all;
clc;
clear all;
%% 2.1.a
fs=2000;
t=0:1/fs:0.5;
fm=10;
m=sawtooth(2*pi*fm*t+pi/2,0.5);
%% 2.1.b
fc=100;
kf=[80];
c=cos(2*pi*fc*t);
sfm=@(kf) cos(2*pi*fc*t+(2*pi*kf*cumsum(m)*(1/fs)));
%% 2.1.c
kp=[2*pi,3*pi,4*pi];
spm=@(kp) cos((2*pi*fc*t+kp*m));
%% 2.1.d
figure;
subplot(311);
plot(t,m);
title('Message signal m(t)');
xlabel('Time in seconds');
ylabel('Amplitude');
subplot(312);
plot(t,sfm(kf(1)));
title('Frequency Modulated signal sfm(t)');
xlabel('Time in seconds');
ylabel('Amplitude');
subplot(313);
plot(t,spm(kp(1)));
title('Phase Modulated signal spm(t)');
xlabel('Time in seconds');
ylabel('Amplitude');
%% 2.1.f
figure;
subplot(311);
plot(t,spm(kp(1)));
title('Phase Modulated signal spm(t)');
xlabel('Time in seconds');
ylabel('Amplitude');
subplot(312);
plot(t,spm(kp(2)));
title('Phase Modulated signal spm2(t)');
xlabel('Time in seconds');
ylabel('Amplitude');
subplot(313);
plot(t,spm(kp(3)));
title('Phase Modulated signal spm3(t)');
xlabel('Time in seconds');
ylabel('Amplitude');
%% 2.2.b
xpm=hilbert(spm(kp(1)));
%% 2.2.c
n=length(t);
f=linspace(-fs/2,fs/2,n);
figure;
subplot(311);
plot(f,fftshift(abs(fft(m)/n)));
title('Message Signal m');
xlabel('Frequency in Hertz');
ylabel('Magnitude');
subplot(312);
plot(f,fftshift(abs(fft(spm(kp(1))/n))));
title('Modulated Signal spm');
xlabel('Frequency in Hertz');
ylabel('Magnitude');
subplot(313);
plot(f,fftshift(abs(fft(xpm)/n)));
title('Modulated Signal xpm');
xlabel('Frequency in Hertz');
ylabel('Magnitude');
%% 2.2.d
inst_phase1 = unwrap(angle(xpm));%same as phase(xpm) function 2*pi*fc*t+kp*m
carrier = 2*pi*fc*t;
spm1=inst_phase1-carrier;
%% 2.2.e
xpm3=hilbert(spm(kp(3)));
inst_phase3 = unwrap(angle(xpm3));%same as phase(xpm3) function
spm3=inst_phase3-carrier;
%% 2.2.f
figure;
plot(t,m,'b');
title('Modulating and demodulated signals');
xlabel('Time in seconds');
ylabel('Amplitude');
hold on;
plot(t,spm1/kp(1),'r');
hold on;
plot(t,spm3/kp(3),'g');
legend('m','spm1','spm3');
hold off;
