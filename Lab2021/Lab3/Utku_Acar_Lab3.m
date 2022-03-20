close all;
clc;
clear all;
%% 3.2.a
fs=10000;
dt=1/fs;
t=0:dt:0.1;
N=length(t);
%% 3.2.b
fc=1000;
fm=100;
c=cos(2*pi*fc*t);
m=cos(2*pi*fm*t);
%% 3.2.c
s=@(ka)(m.*ka+1).*c;
%% 3.2.d
% figure;
% subplot(311);
% plot(t,s(0.5));%undermodulation
% title('modulated signal ka=0.5');
% xlabel('time in Seconds');
% ylabel('Magnitude');
% subplot(312);
% plot(t,s(1));% full modulation
% title('modulated signal ka=1');
% xlabel('time in Seconds');
% ylabel('Magnitude');
% subplot(313);
% plot(t,s(2));% overmodulation
% title('modulated signal ka=2');
% xlabel('time in Seconds');
% ylabel('Magnitude');
%% 3.2.f
f=linspace(-fs/2,fs/2,N);
% figure;
% subplot(311);
% plot(f,fftshift(abs(fft(m)/N)));
% title('message(modulating) signal');
% xlabel('frequency in Hz');
% ylabel('Magnitude');
% subplot(312);
% plot(f,fftshift(abs(fft(c)/N)));
% title('carrier signal');
% xlabel('frequency in Hz');
% ylabel('Magnitude');
% subplot(313);
% plot(f,fftshift(abs(fft(s(0.5))/N)));
% title('modulated signal');
% xlabel('frequency in Hz');
% ylabel('Magnitude');
%% 3.3.a
ss=s(0.9).*s(0.9);
[b,a]=butter(4,(2*fm+50)./(fs/2),'low');
ssf= filter(b,a,ss);
figure;
freqz(b,a,N);
ss=s(0.9).*s(0.9);
[b1,a1]=butter(40,(2*fm+50)./(fs/2),'low');
ssf= filter(b1,a1,ss);
figure;
freqz(b1,a1,N);
% ssfsq1=sqrt(ssf);
% ss=s(2).*s(2);
% % [b,a]=butter(6,(2*fm+50)./(fs/2),'low');
% ssf= filter(b,a,ss);
% ssfsq2=sqrt(ssf);
% figure;
% subplot(211);
% plot(t,ssfsq1);
% title('Message signal when ka =0.9');
% xlabel('time in Seconds');
% ylabel('Amplitude');
% subplot(212);
% plot(t,ssfsq2);
% title('Message signal when ka =2');
% xlabel('time in Seconds');
% ylabel('Amplitude');
