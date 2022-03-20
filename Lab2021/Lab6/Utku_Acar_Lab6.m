close all;
clc;
clear all;
%% 2.1.a
fs=2000;
t=0:1/fs:0.2;
%% 2.1.b
Ac=1;
fc=200;
c=Ac*cos(2*pi*fc*t);
%% 2.1.c
Am=2;
fm=50;
m=Am*cos(2*pi*fm*t);
%% 2.1.d
kf=[5,25,50];
s=@(kf) Ac*(cos(2*pi*fc*t+(2*pi*kf*cumsum(m)/fs)));
s1=s(kf(1));
s2=s(kf(2));
s3=s(kf(3));
% s1=fmmod(m,fc,fs,Am*kf(1)); %for correction 
% s2=fmmod(m,fc,fs,Am*kf(2)); %for correction   
% s3=fmmod(m,fc,fs,Am*kf(3)); %for correction 
%% 2.1.e
figure;
subplot(411);
plot(t,m);
title('Message signal m(t)');
xlabel('Time in seconds');
ylabel('Amplitude');
subplot(412);
plot(t,s1);
title('Modulated signal s1(t)');
xlabel('Time in seconds');
ylabel('Amplitude');
subplot(413);
plot(t,s2);
title('Modulated signal s2(t)');
xlabel('Time in seconds');
ylabel('Amplitude');
subplot(414);
plot(t,s3);
title('Modulated signal s3(t)');
xlabel('Time in seconds');
ylabel('Amplitude');
%% 2.2.a
n=length(t);
f=linspace(-fs/2,fs/2,n);
m_f=fft(m,n);
c_f=fft(c,n);
s1_f=fft(s1,n);
s2_f=fft(s2,n);
s3_f=fft(s3,n);
%% 2.2.b
figure;
subplot(211);
plot(f,fftshift(abs(m_f/n)));
title('Message Signal');
xlabel('Frequency in Hertz');
ylabel('Magnitude');
subplot(212);
plot(f,fftshift(abs(c_f/n)));
title('Carrier Signal');
xlabel('Frequency in Hertz');
ylabel('Magnitude');
%% 2.2.c
figure;
subplot(311);
plot(f,fftshift(abs(s1_f/n)));
title('Modulated Signal s1');
xlabel('Frequency in Hertz');
ylabel('Magnitude');
subplot(312);
plot(f,fftshift(abs(s2_f/n)));
title('Modulated Signal s2');
xlabel('Frequency in Hertz');
ylabel('Magnitude');
subplot(313);
plot(f,fftshift(abs(s3_f/n)));
title('Modulated Signal s3');
xlabel('Frequency in Hertz');
ylabel('Magnitude');
%% 2.3.a
s1_demod=Am*fmdemod(s1,fc,fs,Am*kf(1));
s2_demod=Am*fmdemod(s2,fc,fs,Am*kf(2));
s3_demod=Am*fmdemod(s3,fc,fs,Am*kf(3));
%% 2.3.b
figure;
subplot(311);
plot(t,m);
title('Blue is m(t) and orange is our demodulated signal s1demod(t)');
xlabel('Time in seconds');
ylabel('Amplitude');
hold on;
plot(t,s1_demod);
hold off;
subplot(312);
plot(t,m);
title('Blue is m(t) and orange is our demodulated signal s2demod(t)');
xlabel('Time in seconds');
ylabel('Amplitude');
hold on;
plot(t,s2_demod);
hold off;
subplot(313);
plot(t,m);
title('Blue is m(t) and orange is our demodulated signal s3demod(t)');
xlabel('Time in seconds');
ylabel('Amplitude');
hold on;
plot(t,s3_demod);
hold off;