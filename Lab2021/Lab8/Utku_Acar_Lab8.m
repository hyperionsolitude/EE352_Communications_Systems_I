close all;
clc;
clear all;
%% 9.1.a
image1=imread("cameraman.tif");
y=im2double(image1);
%% 9.1.b
fs=numel(y);
%% 9.1.c
y_vector=reshape(y,[1,fs]);
t = 0:(1/fs):(numel(y) - 1)/fs;
%% 9.1.d
fc=20000;
c=cos(2*pi*fc*t);
%% 9.2.a
x=c.*y_vector;
%% 9.2.b
out= @(snr) awgn(x,snr,'measured');%% snr in dB x is dsbsc_mod signal
x0 = out(0);
x5 = out(5);
x10 = out(10);
x20 = out(20);
x30 = out(30);
%% 9.3.a
cc=2.*c;
x0d = x0.*cc;
x5d = x5.*cc;
x10d = x10.*cc;
x20d = x20.*cc;
x30d = x30.*cc;
fm=length(y);
f=linspace(-fs/2,fs/2,fs);
figure;
plot(f,fftshift(abs(fft(x30d)/65536)));
[b,a]=butter(9,(fc-fm)/(fs/2),'low');
x0df= filter(b,a,x0d);
x5df= filter(b,a,x5d);
x10df= filter(b,a,x10d);
x20df= filter(b,a,x20d);
x30df= filter(b,a,x30d);
figure;
plot(f,fftshift(abs(fft(x30df)/65536)));
%% 9.3.b
x0dfr=reshape(x0df,[fm,fm]);
x5dfr=reshape(x5df,[fm,fm]);
x10dfr=reshape(x10df,[fm,fm]);
x20dfr=reshape(x20df,[fm,fm]);
x30dfr=reshape(x30df,[fm,fm]);
%% 9.4.a
figure;
subplot(321);
imshow(y);
title('original image');
subplot(322);
imshow(x0dfr);
title('image with 0 dB SNR');
subplot(323);
imshow(x5dfr);
title('image with 5 dB SNR');
subplot(324);
imshow(x10dfr);
title('image with 10 dB SNR');
subplot(325);
imshow(x20dfr);
title('image with 20 dB SNR');
subplot(326);
imshow(x30dfr);
title('image with 30 dB SNR');
%% 9.5.a
MSE1=MSE_Utku_Acar(y,x0dfr);
MSE2=MSE_Utku_Acar(y,x5dfr);
MSE3=MSE_Utku_Acar(y,x10dfr);
MSE4=MSE_Utku_Acar(y,x20dfr);
MSE5=MSE_Utku_Acar(y,x30dfr);
% MSE_matlab1=immse(y,x0dfr);to be sure that my function works or not
% MSE_matlab2=immse(y,x5dfr);
% MSE_matlab3=immse(y,x10dfr);
% MSE_matlab4=immse(y,x20dfr);
% MSE_matlab5=immse(y,x30dfr);
%% 9.5.b
figure;
MSE_array=[MSE1 MSE2 MSE3 MSE4 MSE5];
plot([0,5,10,20,30],MSE_array);
title('Mean Square Error');
xlabel('SNR Values(dB)');
ylabel('Corresponding value of error');