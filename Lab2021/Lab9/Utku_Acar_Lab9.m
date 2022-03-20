close all;
clc;
clear all;
%% 9.1.a
x=load('gong');
%% 9.1.b
Am=1;
%Am=0.1;
%fmmax=4096;
mt=x.y;%message signal from struct x
mt=mt';%row column transition
fs=x.Fs;% Accessing sampling frequency from struct x
%% 9.1.c
t = 0:(1/fs):(numel(mt) - 1)/fs;
%% 9.1.d
Ac=1;
fc=2000;
ct=cos(2*pi*fc*t);
%% 9.2.a
kf=10000;
%kf=1000;
n=length(mt);
xfm=Ac*(cos(2*pi*fc*t+(2*pi*kf*cumsum(mt)/n)));
%xfm=Ac*(cos(2*pi*fc*t+(2*pi*kf*Am*cumsum(mt)/fs)));
%xfm=fmmod(mt,fc,fs,Am*kf);
%% 9.2.b
out= @(snr) awgn(xfm,snr,'measured');%% snr in dB
xfm0db=out(0);
xfm5db=out(5);
xfm10db=out(10);
xfm20db=out(20);
%% 9.3.a
xfm0dbdemod=Am*fmdemod(xfm0db,fc,fs,Am*kf);
xfm5dbdemod=Am*fmdemod(xfm5db,fc,fs,Am*kf);
xfm10dbdemod=Am*fmdemod(xfm10db,fc,fs,Am*kf);
xfm20dbdemod=Am*fmdemod(xfm20db,fc,fs,Am*kf);
%% 9.3.b
[b,a]=butter(10,(fc)/(fs/2),'low');
xfm0dbdemodf= filter(b,a,xfm0dbdemod);% zero crossing ???
xfm5dbdemodf= filter(b,a,xfm5dbdemod);
xfm10dbdemodf= filter(b,a,xfm10dbdemod);
xfm20dbdemodf= filter(b,a,xfm20dbdemod);
%% 9.3.c
%sound(mt);
%sound(xfm0dbdemodf);% these can be also multiplied by 5 for increasing the volume
%sound(xfm5dbdemodf);
%sound(xfm10dbdemodf);
%sound(xfm20dbdemodf);
%% 9.4.a
MSE1=MSE_Utku_Acar(mt,xfm0dbdemodf);
MSE2=MSE_Utku_Acar(mt,xfm5dbdemodf);
MSE3=MSE_Utku_Acar(mt,xfm10dbdemodf);
MSE4=MSE_Utku_Acar(mt,xfm20dbdemodf);
%% 9.4.b
figure;
MSE_array=[MSE1 MSE2 MSE3 MSE4];
plot([0,5,10,20],MSE_array);
title('Mean Square Error');
xlabel('SNR Values(dB)');
ylabel('Corresponding value of error');
%% extra
f=linspace(-fs/2,fs/2,n);
figure;
plot(f,fftshift(abs(fft(xfm0dbdemod))));
figure;
plot(f,fftshift(abs(fft(xfm20dbdemod)))/(8192));
figure;
plot(f,fftshift(abs(fft(mt)/8192)));
title('message');
figure;
plot(t,mt);
hold on ;
plot(t,xfm0dbdemodf);
hold on ;
plot(t,xfm5dbdemodf);
hold on ;
plot(t,xfm10dbdemodf);
hold on ;
plot(t,xfm20dbdemodf);