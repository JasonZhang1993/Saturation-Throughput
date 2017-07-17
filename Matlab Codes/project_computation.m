%% EE597 Fall2016 Project 1 / Matlab Computation
%% Qi Lyu 4152598303
%% Jiayi Zhang 3032914272
clear;
clc;
close all;
%% parameters
SIFS = 28;
DIFS = 128;
slot_time = 50;
packet = 272 + 128 + 8184;
ACK = 112 + 128;
Ts = (packet + SIFS + ACK + DIFS)./slot_time;
Tc = (packet + DIFS)./slot_time;
%% Inputs
W = input('Minimum backoff window size: (in slot time)\n');
m = input('Maximum stage: \n');
%% Computation
throughput = [];
for n = 2:2:50
    fun = @(p) (p-1+(1-2*(1-2*p)/((1-2*p)*(W+1)+ p*W*(1-(2*p)^m)))^(n-1));
    P = fzero(fun,[0,1]);
    tao = 2*(1-2*P)./((1-2*P)*(W+1)+ P*W*(1-(2*P)^m));
    Ptr = 1-(1-tao)^n;
    Ps = n*tao*(1-tao)^(n-1)./Ptr;
    ETX = 1./(Ptr)-1;
    throughput = [throughput, Ps*(8184/50)./(ETX+Ps*Ts+(1-Ps)*Tc)];
end
plot(2:2:50,throughput,'LineWidth',1);
hold on;