close all
cell_load = {0,751,12,"Times New Roman",...
            Vdc,"DC Bus Voltage","Voltage [V]",...
            Idc,"DC Load Current","Current [A]",... 
            Pdc,"DC Load Power","Power [KW]"};
        
cell_load3 = {0,751,12,"Times New Roman",...
            Vload3,"AC Load Voltage ","Voltage rms [V]",...
            Iload3,"AC Load Current","Current rms [A]",... 
            Pload3,"AC Load Power","Power [KW]"};
 
cell_2 = {0,751,12,"Times New Roman",...
            P_CONS,"Total Power consumied","Power [KW]",... 
            Pdc,"Power load DC","Power [KW]",...
            Pload3,"Power load AC","Power [KW]"};

cell_ref = {0,751,12,"Times New Roman",...
            P_SU,"Total Power Supplied","Power [KW]",... 
            Pbat,"Power Battery 1 Gen","Power [KW]",...
            Psour,"Power Grid ","Power [KW]",...
            Pcap ,"Power Capacitor","Power [KW]",...
            PBAT2 ,"Power Battery 2 Abs","Power [KW]"};




    
    
Represent_var_Elec(cell_load);
print('BAT_FC_SMES_UCb1.png', '-dpng', '-r300');

Represent_var_Elec_2(cell_2);
print('BAT_FC_SMES_UC_2b1.png', '-dpng', '-r300');

Represent_var_Elec_4(cell_load3);
print('BAT_FC_SMES_UC_4b1.png', '-dpng', '-r300');

Represent_var_Elec_3(cell_ref);
print('Power_suppliedb1.png', '-dpng', '-r300');


time = Pbat.Time;  % Tiempo común
dataTable = table( ...
    time, ...
    Pbat.Data, ...
    Psour.Data, ...
    Pcap.Data, ...
    PBAT2.Data, ...
    Pload3.Data,...
    SOC_B.Data,...
    'VariableNames', {'Time', 'Pbat1', 'Pgrid', 'Pultracap','PBat2', ...
    'P-load3','SOC_BAT1'
    });

writetable(dataTable, 'datos_simulacion.csv');


  
function Represent_var_Elec (cell)
    


init = cell{1};
endt = cell{2};
tamano = cell{3};
type_text = cell{4};

Vdc = cell{5};
Vdc_Title = cell{6};
Vdc_string = cell{7};

Idc = cell{8};
Idc_Title = cell{9};
Idc_string = cell{10};

Pdc = cell{11};
Pdc_Title = cell{12};
Pdc_string = cell{13};


f0 = figure;
f0.Position = [0 0 900 800];


s = subplot(3,1,1);
p = plot(Vdc, 'Color', [1 0 0]); % Rojo
%p.YData = p.YData/1000;
grid minor;
s.Title.String = Vdc_Title;
s.XLabel.String =" ";
s.YLabel.String = Vdc_string;
s.XLabel.String = " ";
s.FontName = type_text;
s.FontSize = tamano;
s.XLim = [init, endt];

margen = 0.10 * (max(Vdc) - min(Vdc));         % 10% del rango como margen
s.YLim = [min(Vdc) - margen-100, max(Vdc) + margen+100];

s = subplot(3,1,2);
p = plot(Idc);
%p.YData = p.YData/1000;
grid minor;
s.Title.String =Idc_Title;
s.XLabel.String =" ";
s.YLabel.String = Idc_string;
s.FontName = type_text;
s.FontSize = tamano;
s.XLim = [init, endt];
s.YLim = [s.YLim(1)*1.1, max((Idc.Data(:,1)))*1.2];

margen1 = 0.10 * (max(Idc) - min(Idc));         % 10% del rango como margen
s.YLim = [min(Idc) - margen1-100, max(Idc) + margen1+100];


s = subplot(3,1,3);
p = plot(Pdc, 'Color', [0 0.5 0], 'LineWidth', 2); % Verde oscuro
p.YData = p.YData/1000;
grid minor;
s.Title.String = Pdc_Title;
s.XLabel.String ="Time [s]";
s.YLabel.String = Pdc_string;
s.FontName = type_text;
s.FontSize = tamano;
s.XLim = [init, endt];
s.YLim = [-1000, 3000];

margen2 = 0.10 * (max(Pdc/1000) - min(Pdc/1000));         % 10% del rango como margen
s.YLim = [min(Pdc/1000) - margen2-1000, max(Pdc/1000) + margen2+1000];


end

function Represent_var_Elec_2 (cell)
    


init = cell{1};
endt = cell{2};
tamano = cell{3};
type_text = cell{4};

P_CONSU = cell{5};
P_CONSU_Title = cell{6};
P_CONSU_string = cell{7};


Pdc = cell{8};
Pdc_Title = cell{9};
Pdc_string = cell{10};

Pload3 = cell{11};
Pload3_Title = cell{12};
Pload3_string = cell{13};


f0 = figure;
f0.Position = [0 0 900 800];

s = subplot(3,1,1);
p = plot(Pload3);
p.YData = p.YData/1000;
grid minor;
s.Title.String = Pload3_Title;
s.XLabel.String =" ";
s.YLabel.String = Pload3_string;
s.FontName = type_text;
s.FontSize = tamano;
s.XLim = [init, endt];
s.YLim = [0, max(Pload3.Data(:,1)/1000)*1.2];

s = subplot(3,1,2);
p = plot(Pdc);
p.YData = p.YData/1000;
grid minor;
s.Title.String = Pdc_Title;
s.XLabel.String =" ";
s.YLabel.String = Pdc_string;
s.FontName = type_text;
s.FontSize = tamano;
s.XLim = [init, endt];
s.YLim = [s.YLim(1), max(Pdc.Data/1000)*1.2];
hold off;

s = subplot(3,1,3);
p = plot(P_CONSU);
p.LineWidth = 2;
grid minor;
s.Title.String = P_CONSU_Title;
s.XLabel.String ="Time [s]";
s.YLabel.String = P_CONSU_string;
s.FontName = type_text;
s.FontSize = tamano;
s.XLim = [init, endt];
%s.YLim = [min(V.Data)*0.90, max(V.Data)*1.1];
s.YLim = [0, max(P_CONSU.Data)*1.1];
hold off;


end


function Represent_var_Elec_3 (cell)
    


init = cell{1};
endt = cell{2};
tamano = cell{3};
type_text = cell{4};

Psup = cell{5};
Psup_Title = cell{6};
Psup_string = cell{7};

Pbat = cell{8};
Pbat_Title = cell{9};
Pbat_string = cell{10};

Psour = cell{11};
Psour_Title = cell{12};
Psour_string = cell{13};

Pcap = cell{14};
Pcap_Title = cell{15};
Pcap_string = cell{16};

Psmes = cell{17};
Psmes_Title = cell{18};
Psmes_string = cell{19};


f0 = figure;
f0.Position = [0 0 900 800];


s = subplot(2,1,1);
p = plot(Pbat);
p.YData = p.YData/1000;
grid minor;
s.Title.String = Pbat_Title;
s.XLabel.String =" ";
s.YLabel.String = Pbat_string;
s.FontName = type_text;
s.FontSize = tamano;
s.XLim = [init, endt];
s.YLim = [s.YLim(1)*1.1, max((Pbat.Data(:,1))/1000)*1.2];


s = subplot(2,1,2);
p = plot(Psour);
p.YData = p.YData/1000;
grid minor;
s.Title.String = Psour_Title;
s.XLabel.String =" ";
s.YLabel.String = Psour_string;
s.FontName = type_text;
s.FontSize = tamano;
s.XLim = [init, endt];
s.YLim = [-45000/1000, -5000/1000];

print('BAT_FC_SMES_UC_6.png', '-dpng', '-r300');

f1 = figure;
f1.Position = [0 0 900 800];

s = subplot(3,1,1);
p = plot(Pcap);
p.YData = p.YData/1000;
grid minor;
s.Title.String = Pcap_Title;
s.XLabel.String =" ";
s.YLabel.String = Pcap_string;
s.FontName = type_text;
s.FontSize = tamano;
s.XLim = [init, endt];
s.YLim = [s.YLim(1)-5, max(Pcap.Data(:,1)/1000)*1.1];

s = subplot(3,1,2);
p = plot(Psmes);
p.YData = p.YData/1000;
grid minor;
s.Title.String = Psmes_Title;
s.XLabel.String =" ";
s.YLabel.String = Psmes_string;
s.FontName = type_text;
s.FontSize = tamano;
s.XLim = [init, endt];
s.YLim = [s.YLim(1)*1.1, max(Psmes.Data(:,1)/1000)*1.2];

s = subplot(3,1,3);
p = plot(Psup, 'Color', [0 0.5 0], 'LineWidth', 2); % Verde oscuro
p.YData = p.YData/1000;
grid minor;
s.Title.String = Psup_Title;
s.XLabel.String ="Time [s]";
s.YLabel.String = Psup_string;
s.FontName = type_text;
s.FontSize = tamano;
s.XLim = [init, endt];
s.YLim = [s.YLim(1)*1.1, max(Psup.Data(:,1)/1000)*1.2];


end

function Represent_var_Elec_4 (cell)
    

init = cell{1};
endt = cell{2};
tamano = cell{3};
type_text = cell{4};

Vload3 = cell{5};
Vload3_Title = cell{6};
Vload3_string = cell{7};

Iload3 = cell{8};
Iload3_Title = cell{9};
Iload3_string = cell{10};

Pload3 = cell{11};
Pload3_Title = cell{12};
Pload3_string = cell{13};



f0 = figure;
f0.Position = [0 0 900 800];


s = subplot(3,1,1);
p = plot(Vload3);
%p.YData = p.YData/1000;
grid minor;
s.Title.String = Vload3_Title;
s.XLabel.String =" ";
s.YLabel.String = Vload3_string;
s.XLabel.String = " ";
s.FontName = type_text;
s.FontSize = tamano;
s.XLim = [init, endt];
s.YLim = [200, max(Vload3.Data(:,1))*1.2];
hold off;


s = subplot(3,1,2);
p = plot(Iload3);
%p.YData = p.YData/1000;
grid minor;
s.Title.String = Iload3_Title;
s.XLabel.String =" ";
s.YLabel.String = Iload3_string;
s.FontName = type_text;
s.FontSize = tamano;
s.XLim = [init, endt];
s.YLim = [-20, max((Iload3.Data(:,1)))*1.01];
hold off;

s = subplot(3,1,3);
p = plot(Pload3);
p.YData = p.YData/1000;
grid minor;
s.Title.String = Pload3_Title;
s.XLabel.String ="Time [s]";
s.YLabel.String = Pload3_string;
s.FontName = type_text;
s.FontSize = tamano;
s.XLim = [init, endt];
%s.YLim = [min(Psmes.Data(:,1)/1000), max(Psmes.Data(:,1)/1000)*1.1];
s.YLim = [-5, max(Pload3.Data(:,1)/1000)*1.001];
hold off;


end
% 

% cell_bat = {0,2.05,12,"Times New Roman",...
%             SOC,"State of Charge","%",...
%             Sva3,"Power apparent S","Power[KVA]",...
%             Qvar3,"Power reactive Q","Power[KVAr]",...
%             Pw3,"Power active P","Power[KW]",...
%             P_ref,"Referent Power"};
%     
% Represent_var_Elec(cell_bat);
% print('battery_load_1000v_250kw_3.png', '-dpng', '-r300');
%   
% function Represent_var_Elec (cell)
%     
% init = cell{1};
% endt = cell{2};
% tamano = cell{3};
% type_text = cell{4};
% 
% SOC = cell{5};
% SOC_Title = cell{6};
% SOC_string = cell{7};
% 
% Sv = cell{8};
% Sv_Title = cell{9};
% Sv_string = cell{10};
% 
% Qv = cell{11};
% Qv_Title = cell{12};
% Qv_string = cell{13};
% 
% Pw = cell{14};
% Pw_Title = cell{15};
% Pw_string = cell{16};
% 
% Pref= cell{17};
% Pref_Title= cell{18};
% 
% f0 = figure;
% f0.Position = [0 0 900 800];
% 
% s = subplot(4,1,1);
% p = plot(SOC);
% p.LineWidth = 2;
% grid minor;
% s.Title.String = SOC_Title;
% s.XLabel.String =" ";
% s.YLabel.String = SOC_string;
% s.FontName = type_text;
% s.FontSize = tamano;
% s.XLim = [init, endt];
% s.YLim = [s.YLim(1), max(SOC.Data)];
% 
% s = subplot(4,1,2);
% p = plot(Sv);
% p.YData = p.YData/1000;
% p.LineWidth = 2;
% grid minor;
% s.Title.String = Sv_Title;
% s.XLabel.String =" ";
% s.YLabel.String = Sv_string;
% s.XLabel.String = " ";
% s.FontName = type_text;
% s.FontSize = tamano;
% s.XLim = [init, endt];
% s.YLim = [s.YLim(1), max(Sv.Data/1000)*1.1];
% 
% s = subplot(4,1,3);
% p = plot(Qv);
% p.YData = p.YData/1000;
% p.LineWidth = 2;
% grid minor;
% s.Title.String = Qv_Title;
% s.XLabel.String =" ";
% s.YLabel.String = Qv_string;
% s.FontName = type_text;
% s.FontSize = tamano;
% s.XLim = [init, endt];
% s.YLim = [s.YLim(1), max(Qv.Data/1000)*1.1];
% 
% s = subplot(4,1,4);
% p = plot(Pw);
% p.YData = p.YData/1000;
% p.LineWidth = 2;
% 
% hold on 
% p = plot(Pref);
% p.YData = p.YData/1000;
% p.LineStyle = "--";
% p.LineWidth = 3;
% legend(Pw_Title,Pref_Title);
% grid minor;
% s.Title.String = "Power Q";
% s.XLabel.String =" ";
% s.YLabel.String = Pw_string;
% s.XLabel.String = "Time [s]";
% s.FontName = type_text;
% s.FontSize = tamano;
% s.XLim = [init, endt];
% s.YLim = [s.YLim(1), max(Pw.Data/1000)*1.1];
% 
% end
% 
