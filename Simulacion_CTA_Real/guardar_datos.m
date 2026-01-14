% Guardar variables del workspace en un archivo .mat

% Define un nombre para el archivo de salida
nombreArchivo = 'datos_cta_ensayos.mat';

% Listar las variables relevantes del workspace
% Suponemos que las variables de interés son de tipo timeseries
variablesInteres = {'VBAT2','IBAT2','PBAT2','VBAT1','IBAT1','Pbat', 'Psour', 'Pcap', 'Pdc','Vdc','Idc','Pload3','Iload3','Vload3','SOC_B','SOC2','SOC_UC'};

% Inicializar una estructura para guardar las variables
datos = struct();

% Iterar sobre cada variable y agregarla a la estructura
for i = 1:length(variablesInteres)
    nombreVar = variablesInteres{i};
        datos.(nombreVar) = evalin('base', nombreVar);
   
end

% Guardar las variables en un archivo .mat
save(nombreArchivo, '-struct', 'datos');

% Confirmación
fprintf('Las variables han sido guardadas en el archivo: %s\n', nombreArchivo);
