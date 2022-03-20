close all;
clc;
clear all;
%% 2.1.a
fs=1000;
dt=1/fs;
t=0:dt:2;
N=length(t);
x2=cos(120*pi*t)+sin(500*pi*t);
X2=fft(x2,N);
%% 2.1.b
f=linspace(-fs/2,fs/2,N);
X=zeros(1,N);
Y1=zeros(1,N);
X((find(f==-50):find(f==50)))=triang(201);
%% 2.1.c
X2=abs(fftshift(X2))/length(X2);
Y1=X+X2;
%% 2.1.d
figure;
subplot(311);
plot(f,X);
xlabel('frequency in Hz');
ylabel('Magnitude of X');
title('|X|');
subplot(312);
plot(f,X2);
xlabel('frequency in Hz');
ylabel('Magnitude of X2');
title('|X2|');
subplot(313);
plot(f,Y1);
xlabel('frequency in Hz');
ylabel('Magnitude of Y1');
title('|Y1|');
%% 2.2a
lp= zeros(1,N);
Y2= zeros(1,N);
lp(abs(f)<=50)=1;
Y2=lp.*Y1;
%% 2.2.b
figure;
subplot(211);
plot(f,lp);
xlabel('frequency in Hz');
ylabel('Magnitude of H1');
title('|H1|');
subplot(212);
plot(f,Y2);
xlabel('frequency in Hz');
ylabel('Magnitude of Y2');
title('Magnitude of low pass filtered signal |Y2|');
%% 2.2.c
Y3=zeros(1,N);
bp= zeros(1,N);
bp(abs(f)<=300)=1;
bp(abs(f)<200)=0;
Y3=bp.*Y1;
%% 2.2.d
figure;
subplot(211);
plot(f,bp);
xlabel('frequency in Hz');
ylabel('Magnitude of H2');
title('|H2|');
subplot(212);
plot(f,Y3);
xlabel('frequency in Hz');
ylabel('Magnitude of Y3');
title('Magnitude of band pass filtered signal |Y3|');
%% 2.2.e
[b,a]=butter(10, [200 300]./(fs/2),'bandpass');
Ybpf= filter(b,a,x2);
Ybpf=abs(fftshift(fft(Ybpf)))/N;
%% 2.2.f
[h,w]=freqz(b,a,fs);
%Hbpf=(Ybpf./X2)/N;
h=h';
h=[h,h,0];
figure;
subplot(211);
plot(f,abs(h));
%plot(f,Hbpf);
xlabel('frequency in Hz');
ylabel('Magnitude of Hbpf');
title('|Hbpf|');
subplot(212);
plot(f,Ybpf);
xlabel('frequency in Hz');
ylabel('Magnitude of Ybpf');
title('Magnitude of signal |Ybpf|');