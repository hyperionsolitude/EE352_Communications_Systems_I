close all;
clc;
clear all;
%% 2.1.a
fm=450;
fc=5000;
fs=20000;
t=0:1/fs:0.03;
m=3*cos(2*pi*fm*t);
c=cos(2*pi*fc*t);
%% 2.1.b
s=m.*c;
n=2*length(t)-1;
nl=length(t);
f=linspace(-fs/2,fs/2,n);
%% 2.1.c
n1=4;
n2=40;
[b,a]=butter(n1,(fc)/(fs/2),'high');
[d,c]=butter(n2,(fc)/(fs/2),'high');
%% 2.1.d
[h1,w1]=freqz(b,a,'whole',n);
[h2,w2]=freqz(d,c,'whole',n);
figure;
plot(f,abs(fftshift(h1)));
title('butterworth filter with order n1(4) and n2(35)');
xlabel('Frequency(f)')
ylabel('Magnitude')
hold on
plot(f,abs(fftshift(h2)));
hold off
%% 2.1.e
susb1=filter(b,a,s);
susb2=filter(d,c,s);% I choose this
%% 2.1.f
figure;
subplot(311);
plot(f,fftshift(abs(fft(s,n)/nl)));
title('Modulated Signal');
xlabel('Frequency in Hertz');
ylabel('Magnitude');
subplot(312);
plot(f,fftshift(abs(fft(susb1,n)/nl)));
title('Upper side band modulated signal with order n1(4)');
xlabel('Frequency in Hertz');
ylabel('Magnitude');
subplot(313);
plot(f,fftshift(abs(fft(susb2,n)/nl)));
title('Upper side band modulated signal with order n2(35)');
xlabel('Frequency in Hertz');
ylabel('Magnitude');
%% 2.2.a
cc=4*cos(2*pi*fc*t+(0*pi));
v=susb2.*cc;
%% 2.2.b
[g,e]=butter(9,(2*fm+20)/(fs/2),'low');
%% 2.2.c
mdemodt=filter(g,e,v);
%% 2.2.d
figure;
subplot(311);
plot(f,fftshift(abs(fft(m,n)/nl)));
title('M(f)');
xlabel('Frequency in Hertz');
ylabel('Magnitude');
subplot(312);
plot(f,fftshift(abs(fft(v,n)/nl)));
title('V(f)');
xlabel('Frequency in Hertz');
ylabel('Magnitude');
subplot(313);
plot(f,fftshift(abs(fft(mdemodt,n)/nl)));
title('MDEMOD(f)');
xlabel('Frequency in Hertz');
ylabel('Magnitude');
%% 2.2.e
figure;
plot(t,m);
hold on
plot(t,mdemodt);
title('Blue is m(t) and orange is our demodulated signal mdemod(t)');
xlabel('Time in seconds');
ylabel('Amplitude');
hold off