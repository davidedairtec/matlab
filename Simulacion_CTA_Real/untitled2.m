% Nombre de tu modelo
modelName = 'battery_convertidor_ac_dc_p_2';  % Cambia 'tu_modelo' por el nombre real

% Abre el modelo si no está abierto
if ~bdIsLoaded(modelName)
    load_system(modelName);
end

% Encuentra todos los bloques Scope en el modelo (tipo 'Scope')
scopes = find_system(modelName, 'BlockType', 'Scope');

% Itera sobre cada Scope
for i = 1:length(scopes)
    scopeBlock = scopes{i};
    
    % Accede a las propiedades del Scope
    % Para versiones recientes de MATLAB (ejemplo 2024), se usa get_param y set_param
    % La propiedad relevante para "Limit data points to last" es:
    % 'LimitDataPoints' y 'MaxDataPoints' (a veces varía según versión)
    
    % Primero activa "Limit data points to last"
    set_param(scopeBlock, 'LimitDataPoints', 'on');
    
    % Ahora configura el número máximo de puntos a guardar
    set_param(scopeBlock, 'MaxDataPoints', '5000');
    
    fprintf('Scope "%s" configurado con LimitDataPoints = on y MaxDataPoints = 5000\n', scopeBlock);
end

% Guarda el modelo con los cambios
save_system(modelName);
