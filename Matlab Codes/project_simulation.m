%% EE597 Fall2016 Project 1 / Matlab Simulation
%% Qi Lyu 4152598303
%% Jiayi Zhang 3032914272
clear;
clc;
close all;
%% Model Parameters from Biachi, G. (in MicroSec)
SIFS = 28; slot_time = 50; DIFS = 128;
payload = 8184; mac_header = 272; phy_header = 128; ack = 112;
packet = payload + mac_header + phy_header;
ACK = ack + phy_header;

%% Other initialization
W = input('Minimum backoff window size: (in slot time)\n');
m = input('Maximum stage: \n');

sim_time = 0;
throughput = [];

%% Simulation
fprintf('Simulating...\n');
for num_station = 2:2:50
    suc_pkt = 0;
    collision_pkt = 0;
    station_stage = zeros(1,num_station);
    next_tran_time = zeros(1,num_station);
    
    for i = 1:num_station % initial backoff time
        station_stage(i) = 0; 
        next_tran_time(i) = DIFS + floor(W * rand) * slot_time;
    end
   
    while suc_pkt < 100000   
        tran_time =  min(next_tran_time);
        no_tran = sum(tran_time == next_tran_time);
        
        if no_tran == 1 % sucessful reansition
            suc_pkt = suc_pkt + 1;
            for i = 1:num_station
                if next_tran_time(i) == tran_time % uniform backoff at stage 0
                    if suc_pkt == 100000
                        sim_time = next_tran_time (i)+packet+SIFS+ACK+DIFS;
                    end
                    station_stage(i) = 0;
                    next_tran_time(i) = next_tran_time(i)+packet+SIFS+ACK+DIFS+floor(W*rand)*slot_time;
                else % stop counting while the channel is busy
                    next_tran_time(i) = next_tran_time(i) + packet + SIFS+ ACK + DIFS;
                end 
            end
            
        else % collision
            collision_pkt = collision_pkt+1;
            for i = 1:num_station
                if next_tran_time(i) == tran_time % uniform backoff at next stage
                    if station_stage(i) < m
                        station_stage(i) = station_stage(i) +1;
                    end
                    next_tran_time(i)=next_tran_time(i) + packet + DIFS+ floor(2^station_stage(i)*W*rand)*slot_time;
                else
                    next_tran_time(i)=next_tran_time(i) + packet + DIFS;
                end
            end  
        end   
    end
    throughput = [throughput suc_pkt*(payload)/sim_time]; 
end
%% plot
plot(2:2:50,throughput,'LineWidth',2);
title('Saturation throughput: Matlab simulation','FontSize',18)
xlabel('Number of Stations','FontSize',15);
ylabel('Saturation Throughput','FontSize',15);
l = legend(['W=' num2str(W) ', m=' num2str(m)]);
set(l,'FontSize',18);