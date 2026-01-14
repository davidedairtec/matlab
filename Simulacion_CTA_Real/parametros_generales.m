clc 
clear all
%VALORES INICIALES 
%%%%%%%%%%%%%%%%%%%%%%%%%%% CAPACITOR %%%%%%%%%%%%%%%%%%%%%%%%%%
rated_capacitance =62.5/8;
equivalent_dc_series=12.5e-3*8;
rated_voltage=144*8;

initial_voltage = 144*8; % el valor deseado
%initial_voltage.StorageClass = 'SimulinkGlobal';
temp=20;
%%%%% CONVERTER  %%%%%%%
%L_converter=10e-3;
L_converter=20e-3;
%%%%% CONTROL PID DISCHARGE %%%%%
P_control=0.01;
I_control=1;
sample_time_control=4e-4;
%%%%% FILTER     %%%%%%%
R=0.5;
C1_filter=20e-6;
R_filter=0.5;
%%%%% VOLTAGE SOURCE DC %%%%%%%
voltage_dc_source=1000;
%%%%%  RESISTER LOAD DC   %%%%%%
load_dc=1000*1000/5;
%%%%%%%% POWER REFERENCE

%%%%%%%%%%%%%%%%%%%%%%%%%%% SMES %%%%%%%%%%%%%%%%%%%%%%%%%%
Current_Inductor=2500;
%%%%% CONTROL PID DISCHARGE %%%%%
P_control_smes=0.008;
I_control_smes=3.5;
%%%%% FILTER     %%%%%%%
R1_filter=10;
R2_filter=0.0001;
C2_filter=1400e-6;

%%%%%%%%%%%%%%%%%%%%%%%%%%% BATERIA %%%%%%%%%%%%%%%%%%%%%%%%%%
Nominal_voltage=512;
Rated_capacity=(102400/512)*5;
initial_state_of_charge=70;
battery_time=30;
%%%%% CONVERTER  %%%%%%%
Lbat_converter=1e-5;
%%%%% CONTROL PID DISCHARGE %%%%%
P_control_bat=0.7;
I_control_bat=5;

%%%%%%%%%%%%%%%%%%%%%%%%%%% PERFILES DE POTENCOA  %%%%%%%%%%%%%%%%%%%%%%%%%%
%%configuracion general de archivo
data = readmatrix('P3.xlsx');%%Leer el fichero 
time = data(3:end, 1);  % Desde la fila 3 hasta el final, columna 1

%%referencia de bateria 1 que genera 
ref_bat1 =1000* (data(3:end, 4));% se multiplica porque es en kilovatios 
p_bat1 = timeseries(ref_bat1, time);

%%referencia de bateria 2 que absorbe
ref_bat2 =1000* (data(3:end, 10));% se multiplica porque es en kilovatios 
p_bat2 = timeseries(ref_bat2, time);
%%referencia de ultracapacitor
ref_cap=1000*(data(3:end, 6)-data(3:end, 12));
p_cap = timeseries(ref_cap, time);
%%referencia de red
ref_red =1000*( data(3:end, 7));
p_grid = timeseries(ref_red, time);

%%referencia de carga
ref_red =1000*( data(3:end, 8));
p_load_ac = timeseries(ref_red, time);

%vector = randi([-20000, 30000], 101, 1);

%new_time = (0 : 1e-3 : 100)';
%p_new = timeseries(vector, new_time);