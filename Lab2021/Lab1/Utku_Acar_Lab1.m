close all;
clc;
clear;
%% 2.1.a
Fs=500;
dt=1/Fs;
t=0:dt:4;
x=zeros(1,2001);
x2=zeros(1,2001);
x11(1:find(t==1))=0;%501 elements (0,1 included)
x12(1:((find(t==2)/2)-1/2))=1;%500 elements (1 excluded 2 included)
x13(1:(find(t==3)/3)-1/3)=-2;%500 elements (2 excluded 3 included)
x14(1:(find(t==4)/4)-1/4)=0;%500 elements (3 excluded 4 included)
x=[x11 x12 x13 x14];% concentenation
%% 2.1.b
figure();
plot(t,x);
xlabel('time in seconds');
ylabel('x(t)');
title('x(t) wrt time');% wrt: with respect to
%% 2.1.c
x2=cos(2*pi*50*t);
y1=x.*x2;
%% 2.1.d
figure();
plot(t,y1);
xlabel('time in seconds');
ylabel('y1(t)');
title('y1(t) wrt time');
%% 2.2.a
x_f=fft(x,2*length(x)-1);
y1_f=fft(y1,2*length(y1)-1);
N=length(y1); % it could be y,x,y2 all of them has 2001 elements
f=linspace(-Fs/2,Fs/2,2*N-1);
M_x_f=abs(x_f)./N;
M_y1_f=abs(y1_f)./N;% normalization
figure();
subplot(211);
plot(f,fftshift(M_x_f));
title('|X| wrt f');
ylabel('|X|');
xlabel('Frequency in Hz');
subplot(212);
plot(f,fftshift(M_y1_f));
title('|Y1| wrt f');
ylabel('|Y1|');
xlabel('Frequency in Hz');
%% 2.2.b
Y2=fft(x,2*length(x)-1).*fft(x2,2*length(x2)-1); %multiplication on freqs same as conv in time
figure();
plot(f,abs(fftshift(Y2))./N);% normalization
title('|Y2| wrt f');
ylabel('|Y2|');
xlabel('Frequency in Hz');
%% 2.2.c
y2=ifft(Y2,4001);
figure();
t2=0:dt:8;
plot(t2,y2);
title('y2(t) wrt t');
xlabel('time in seconds');
ylabel('y2(t)');
%% 2.2d
y2=conv(x,x2);
t2=0:dt:8;
figure();
plot(t2,y2);
title('y2(t) wrt t');
xlabel('time in seconds');
ylabel('y2(t)');
y21=y2(find(t2==1):find(t2==3));
y22=y2(find(t2==5):find(t2==7));
if(y21==y22)
    print('Lol');
end