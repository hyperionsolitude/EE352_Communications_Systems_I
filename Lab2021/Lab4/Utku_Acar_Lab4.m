close all;
clc;
clear all;
%% 2.1.a
fm=100;
fc=1000;
fs=100000;
t=0:1/fs:0.08;
m=cos(2*pi*fm*t);
c=cos(2*pi*fc*t);
%% 2.1.b
s=m.*c;
%% 2.1.c
figure;
subplot(311);
plot(t,m);
title('Message Signal');
xlabel('Time in Seconds');
ylabel('Amplitude');
subplot(312);
plot(t,c);
title('Carrier Signal');
xlabel('Time in Seconds');
ylabel('Amplitude');
subplot(313);
plot(t,s);
title('DSB-SC Signal');
xlabel('Time in Seconds');
ylabel('Amplitude');
%% 2.1.d
N=length(t);
f=linspace(-fs/2,fs/2,N);
figure;
subplot(211);
plot(f,fftshift(abs(fft(m)/N)));
title('Message Signal');
xlabel('Frequency in Hertz');
ylabel('Magnitude');
subplot(212);
plot(f,fftshift(abs(fft(s)/N)));
title('Modulated Signal');
xlabel('Frequecy in Hertz');
ylabel('Magnitude');
%% 2.2.a
cc=2*cos(2*pi*fc*t+(0*pi));
v=s.*cc;
%% 2.2.b
figure;
plot(f,fftshift(abs(fft(v)/N)));
title('V(f) signal');
xlabel('Frequecy in Hertz');
ylabel('Magnitude');
%% 2.2.c
[b,a]=butter(9,(fc-fm-25)/(fs/2),'low');
vo= filter(b,a,v);
%% 2.2.d
figure;
subplot(211);
plot(t,vo);
title('Vo Signal');
xlabel('Time in Seconds');
ylabel('Amplitude');
subplot(212);
plot(f,fftshift(abs(fft(vo)/N)));
title('Vo Signal');
xlabel('Frequecy in Hertz');
ylabel('Magnitude');