model = 'battery_convertidor_ac_dc_p_2';  % Reemplaza con el nombre real de tu modelo

open_system(model);

fprintf('--- Bloques que envían datos al Workspace ---\n');

% 1. To Workspace blocks
toWS = find_system(model, 'BlockType', 'ToWorkspace');
for i = 1:length(toWS)
    fprintf('To Workspace: %s\n', toWS{i});
end

% 2. Scopes con DataLogging activado
scopes = find_system(model, 'BlockType', 'Scope');
for i = 1:length(scopes)
    if strcmp(get_param(scopes{i}, 'DataLogging'), 'on')
        fprintf('Scope con logging: %s\n', scopes{i});
    end
end

% 3. Outports (si están configurados para guardar)
outports = find_system(model, 'BlockType', 'Outport');
for i = 1:length(outports)
    fprintf('Outport: %s (verifica si está habilitada la opción de guardar en Config)\n', outports{i});
end

% 4. Logging de señales activado
loggedSignals = find_system(model, 'FindAll', 'on', ...
    'Type', 'Line', 'SignalLogging', 'on');
for i = 1:length(loggedSignals)
    parent = get_param(get_param(loggedSignals(i), 'Parent'), 'Name');
    fprintf('Signal logging activado en línea del sistema: %s\n', parent);
end



