% Parámetros editables
archivo = 'h2aps_version_final.slx';
commit_old = 'e73d3c95f4b873d2b4d7bdd73f02116be83da71f';
commit_act = 'a71a2f193ecdfef4e73309da3ea15cc0a583d32a';

% Nombres temporales
temp_old = 'temp_commit.slx';
temp_act = 'temp_act.slx';

% Extraer versiones desde Git
system(sprintf('git show %s:%s > %s', commit_old, archivo, temp_old));
system(sprintf('git show %s:%s > %s', commit_act, archivo, temp_act));
% !git show HEAD~3:h2aps_version_final.slx > temp_modelo_old.slx

% Comparar con visdiff
visdiff(temp_old, temp_act);

