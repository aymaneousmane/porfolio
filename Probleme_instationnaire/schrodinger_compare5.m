%% SCRIPT MAÎTRE : Comparaison de Méthodes Numériques pour Schrödinger 2D
%  Solution de référence : Crank-Nicolson
%  Sorties : 3 graphiques essentiels + 1 tableau récapitulatif + vidéos
clear; close all; clc;

%% ========================================================================
%  0. PARAMÈTRES PHYSIQUES ET NUMÉRIQUES
%  ========================================================================
Lx = 20; Ly = 20; Nx = 150; Ny = 150;
x = linspace(-Lx/2, Lx/2, Nx);
y = linspace(-Ly/2, Ly/2, Ny);
dx = x(2)-x(1); dy = y(2)-y(1);
[X, Y] = meshgrid(x, y);

% Potentiel et opérateurs
w = 2;
V = 0.5*w*w*(X.^2 + Y.^2); V_vec = V(:);
e_x = ones(Nx,1); e_y = ones(Ny,1);
Dxx = spdiags([e_x -2*e_x e_x], [-1 0 1], Nx, Nx) / dx^2;
Dyy = spdiags([e_y -2*e_y e_y], [-1 0 1], Ny, Ny) / dy^2;
Ix = speye(Nx); Iy = speye(Ny);
Lap = kron(Dyy, Ix) + kron(Iy, Dxx);
H_func = @(psi) -Lap * psi + V_vec.*psi;

% Condition initiale
%x0 = -3; y0 = 0; k0x = 3; k0y = 0; sigma = 1.0;
x0 = -3; y0 = -3; k0x = 3; k0y = 3; sigma = 2.0;
psi0 = exp(-((X-x0).^2 + (Y-y0).^2)/(2*sigma^2)) .* exp(1i*(k0x*X + k0y*Y));
norm0 = sqrt(sum(sum(abs(psi0).^2)) * dx * dy);
psi0 = psi0 / norm0;
psi0_vec = psi0(:);

% Paramètres temporels
T_final = 4*pi;
dt_save = 0.1;
dt_video = 0.05;
dt = 0.002;
Nt = round(T_final / dt);
t_save = 0:dt_save:T_final;
N_save = length(t_save);
t_video = 0:dt_video:T_final;
N_video = length(t_video);

fprintf('=== Configuration ===\n');
fprintf('Grille: %dx%d | T_final=%.2f | dt=%.4f | Pas total: %d\n', ...
        Nx, Ny, T_final, dt, Nt);

%% ========================================================================
%  1. MATRICES COMMUNES
%  ========================================================================
H_mat = -Lap + spdiags(V_vec, 0, Nx*Ny, Nx*Ny);
I_mat = speye(Nx*Ny);
A_CN = I_mat + 1i * (dt/2) * H_mat;
B_CN = I_mat - 1i * (dt/2) * H_mat;
A_EI = I_mat + 1i * dt * H_mat;
A_AM2 = I_mat + 1i * (dt/2) * H_mat;
B_AM2 = I_mat - 1i * (dt/2) * H_mat;

%% ========================================================================
%  2. SIMULATION DE RÉFÉRENCE : CRANK-NICOLSON
%  ========================================================================
fprintf('\n--- Crank-Nicolson (Référence) ---\n');
tic;

norm_CN = zeros(N_save, 1);
energy_CN = zeros(N_save, 1);
x_mean_CN = zeros(N_save, 1);
psi_CN_snapshots = cell(1, N_save);
psi_CN_video = cell(1, N_video);

psi = psi0_vec;
save_idx = 1; video_idx = 1;
norm_CN(1) = norm_L2(psi, dx, dy);
energy_CN(1) = energy_total(psi, Lap, V_vec, dx, dy);
x_mean_CN(1) = mean_x(psi, X, dx, dy);
psi_CN_snapshots{1} = reshape(psi, Ny, Nx);
psi_CN_video{1} = reshape(psi, Ny, Nx);

for n = 1:Nt
    t = n * dt;
    psi = A_CN \ (B_CN * psi);
    
    if save_idx < N_save && abs(t - t_save(save_idx+1)) < dt/2
        save_idx = save_idx + 1;
        norm_CN(save_idx) = norm_L2(psi, dx, dy);
        energy_CN(save_idx) = energy_total(psi, Lap, V_vec, dx, dy);
        x_mean_CN(save_idx) = mean_x(psi, X, dx, dy);
        psi_CN_snapshots{save_idx} = reshape(psi, Ny, Nx);
    end
    if video_idx < N_video && abs(t - t_video(video_idx+1)) < dt/2
        video_idx = video_idx + 1;
        psi_CN_video{video_idx} = reshape(psi, Ny, Nx);
    end
end
t_CN = toc;
fprintf('  Temps CPU: %.2f s\n', t_CN);

%% ========================================================================
%  3. EXÉCUTION DE TOUTES LES MÉTHODES
%  ========================================================================
method_names = {'Euler Explicite', 'Euler Implicite', 'RK4', ...
                'Adams-Bashforth 2', 'Adams-Moulton 2'};
n_methods = length(method_names);

% Tableau des résultats
Results_Table = table();
Results_Table.Methode = method_names';
Results_Table.Ordre = [1; 1; 4; 2; 2];
Results_Table.Type = {'Explicite 1 pas'; 'Implicite 1 pas'; 'Explicite 1 pas'; ...
                      'Explicite 2 pas'; 'Implicite 2 pas'};
Results_Table.Temps_CPU = zeros(n_methods, 1);
Results_Table.Erreur_Norme_Max = zeros(n_methods, 1);
Results_Table.Erreur_Energie_Max = zeros(n_methods, 1);
Results_Table.Erreur_Psi_Max = zeros(n_methods, 1);
Results_Table.Erreur_Psi_Finale = zeros(n_methods, 1);
Results_Table.Norme_Finale = zeros(n_methods, 1);
Results_Table.Energie_Derive = zeros(n_methods, 1);

all_err_psi = zeros(N_save, n_methods);
all_norm = zeros(N_save, n_methods);
all_energy = zeros(N_save, n_methods);
all_video = cell(n_methods, 1);

for m = 1:n_methods
    fprintf('\n--- %s ---\n', method_names{m});
    tic;
    
    [norm_sim, energy_sim, ~, psi_snapshots, psi_video] = ...
        run_simulation(method_names{m}, psi0_vec, Nt, dt, t_save, N_save, ...
                       t_video, N_video, dx, dy, Lap, V_vec, X, H_func, ...
                       I_mat, H_mat, A_EI, A_AM2, B_AM2);
    
    t_cpu = toc;
    all_video{m} = psi_video;
    all_norm(:,m) = norm_sim;
    all_energy(:,m) = energy_sim;
    
    % Calcul des erreurs
    err_norm = abs(norm_sim - norm_CN);
    err_energy = abs(energy_sim - energy_CN);
    err_psi = zeros(N_save, 1);
    for k = 1:N_save
        delta = psi_snapshots{k}(:) - psi_CN_snapshots{k}(:);
        err_psi(k) = norm_L2(delta, dx, dy) / max(norm_L2(psi_CN_snapshots{k}(:), dx, dy), 1e-15);
    end
    all_err_psi(:,m) = err_psi;
    
    % Remplissage du tableau
    Results_Table.Temps_CPU(m) = t_cpu;
    Results_Table.Erreur_Norme_Max(m) = max(err_norm);
    Results_Table.Erreur_Energie_Max(m) = max(err_energy);
    Results_Table.Erreur_Psi_Max(m) = max(err_psi);
    Results_Table.Erreur_Psi_Finale(m) = err_psi(end);
    Results_Table.Norme_Finale(m) = norm_sim(end);
    Results_Table.Energie_Derive(m) = abs(energy_sim(end) - energy_sim(1));
    
    fprintf('  Temps CPU: %.2f s | Err Psi max: %.2e | Err Psi final: %.2e\n', ...
            t_cpu, max(err_psi), err_psi(end));
end

%% ========================================================================
%  4. AFFICHAGE DU TABLEAU RÉCAPITULATIF
%  ========================================================================
fprintf('\n============================================================\n');
fprintf('  TABLEAU RÉCAPITULATIF DES PERFORMANCES\n');
fprintf('  Référence : Crank-Nicolson (ordre 2, implicite, t_CPU=%.2f s)\n', t_CN);
fprintf('============================================================\n\n');
disp(Results_Table);

% Sauvegarde du tableau en fichier CSV
writetable(Results_Table, 'resultats_comparaison.csv');
fprintf('\nTableau sauvegardé dans : resultats_comparaison.csv\n');

%% ========================================================================
%  5. GRAPHIQUES ESSENTIELS (3 seulement)
%  ========================================================================

% --- GRAPHIQUE 1 : Erreur sur Psi (toutes méthodes) ---
figure('Name', 'Erreur sur Psi', 'Position', [100 100 900 550]);
colors = lines(n_methods);
h = zeros(n_methods,1);
for m = 1:n_methods
    h(m) = semilogy(t_save, all_err_psi(:,m), 'Color', colors(m,:), 'LineWidth', 2);
    hold on;
end
xlabel('Temps t', 'FontSize', 12);
ylabel('Erreur relative L^2 sur \Psi', 'FontSize', 12);
title('Erreur sur la fonction d''onde (référence : Crank-Nicolson)', 'FontSize', 13);
legend(h, method_names, 'Location', 'northwest', 'FontSize', 10);
grid on; box on;

% --- GRAPHIQUE 2 : Conservation de la norme ---
figure('Name', 'Norme L^2', 'Position', [150 150 900 550]);
plot(t_save, norm_CN, 'k-', 'LineWidth', 2.5); hold on;
for m = 1:n_methods
    plot(t_save, all_norm(:,m), 'Color', colors(m,:), 'LineWidth', 1.5);
end
yline(1.0, 'r:', 'LineWidth', 1.5);
xlabel('Temps t', 'FontSize', 12);
ylabel('Norme L^2', 'FontSize', 12);
title('Conservation de la probabilité totale', 'FontSize', 13);
legend(['CN (Réf.)', method_names], 'Location', 'best', 'FontSize', 9);
grid on; box on;

% --- GRAPHIQUE 3 : Snapshots de la solution de référence (CN) ---
snap_times_idx = [1, round(N_save/4), round(N_save/2), round(3*N_save/4), N_save];
figure('Name', 'Évolution CN (Référence)', 'Position', [200 200 1300 280]);
for i = 1:5
    subplot(1,5,i);
    idx = snap_times_idx(i);
    imagesc(x, y, abs(psi_CN_snapshots{idx}).^2);
    axis equal tight; colorbar;
    xlabel('x'); ylabel('y');
    title(sprintf('t = %.2f', t_save(idx)));
    colormap(gca, 'hot');
end
sgtitle('Évolution de |\Psi|^2 - Crank-Nicolson (Référence)', 'FontSize', 13);

%% ========================================================================
%  6. GÉNÉRATION DES VIDÉOS
%  ========================================================================
%% ========================================================================
%  6. GÉNÉRATION DES VIDÉOS
%  ========================================================================
fprintf('\n=== Génération des vidéos ===\n');

if ~exist('videos', 'dir')
    mkdir('videos');
end

% Maximum global pour la colormap
max_dens = 0;
for v = 1:N_video
    max_dens = max(max_dens, max(max(abs(psi_CN_video{v}).^2)));
end
for m = 1:n_methods
    for v = 1:N_video
        max_dens = max(max_dens, max(max(abs(all_video{m}{v}).^2)));
    end
end

% Vidéos pour toutes les méthodes (CN + autres)
all_methods_names = [{'Crank-Nicolson'}, method_names];
all_psi_video = [{psi_CN_video}, all_video'];  % Concaténation de cellules

for m = 1:length(all_methods_names)
    video_filename = sprintf('videos/%s.mp4', strrep(all_methods_names{m}, ' ', '_'));
    v = VideoWriter(video_filename, 'MPEG-4');
    v.FrameRate = 20;
    v.Quality = 95;
    open(v);
    
    fig = figure('Name', all_methods_names{m}, 'Position', [100 100 650 600], 'Visible', 'on');
    
    % Récupérer les données vidéo pour cette méthode
    if m == 1
        psi_frames = psi_CN_video;  % CN est dans psi_CN_video directement
    else
        psi_frames = all_video{m-1};  % Les autres sont dans all_video
    end
    
    for i = 1:N_video
        clf;
        imagesc(x, y, abs(psi_frames{i}).^2);
        axis equal tight;
        caxis([0 max_dens]);
        colorbar; colormap(gca, 'hot');
        xlabel('x', 'FontSize', 11);
        ylabel('y', 'FontSize', 11);
        title(sprintf('%s  |  t = %.2f', all_methods_names{m}, t_video(i)), 'FontSize', 13);
        
        hold on;
        xm = mean_x(psi_frames{i}(:), X, dx, dy);
        ym = mean_y(psi_frames{i}(:), Y, dx, dy);
        plot(xm, ym, 'go', 'MarkerSize', 9, 'MarkerFaceColor', 'g');
        hold off;
        
        drawnow;
        frame = getframe(fig);
        writeVideo(v, frame);
    end
    close(v);
    close(fig);
    fprintf('  %s.mp4\n', strrep(all_methods_names{m}, ' ', '_'));
end

%% ========================================================================
%  7. RÉSUMÉ FINAL
%  ========================================================================
fprintf('\n============================================================\n');
fprintf('  RÉSUMÉ FINAL\n');
fprintf('============================================================\n');
fprintf('Graphiques générés : 3\n');
fprintf('  1. Erreur relative sur Psi (toutes méthodes)\n');
fprintf('  2. Conservation de la norme L^2 (toutes méthodes)\n');
fprintf('  3. Évolution de la densité (Crank-Nicolson)\n');
fprintf('\nVidéos générées : %d\n', length(all_methods_names));
fprintf('Tableau CSV : resultats_comparaison.csv\n');
fprintf('============================================================\n');

%% ========================================================================
%  FONCTIONS AUXILIAIRES
%  ========================================================================

function [norm_sim, energy_sim, x_mean_sim, psi_snapshots, psi_video] = ...
    run_simulation(method_name, psi0_vec, Nt, dt, t_save, N_save, ...
                   t_video, N_video, dx, dy, Lap, V_vec, X, H_func, ...
                   I_mat, H_mat, A_EI, A_AM2, B_AM2)
    
    norm_sim = zeros(N_save, 1);
    energy_sim = zeros(N_save, 1);
    x_mean_sim = zeros(N_save, 1);
    psi_snapshots = cell(1, N_save);
    psi_video = cell(1, N_video);
    
    psi = psi0_vec;
    save_idx = 1; video_idx = 1;
    
    norm_sim(1) = norm_L2(psi, dx, dy);
    energy_sim(1) = energy_total(psi, Lap, V_vec, dx, dy);
    x_mean_sim(1) = mean_x(psi, X, dx, dy);
    psi_snapshots{1} = reshape(psi, sqrt(length(psi)), sqrt(length(psi)));
    psi_video{1} = reshape(psi, sqrt(length(psi)), sqrt(length(psi)));
    
    Hpsi_prev = [];
    
    for n = 1:Nt
        t = n * dt;
        
        Hpsi_current = [];
        if ismember(method_name, {'Euler Explicite', 'RK4', 'Adams-Bashforth 2'})
            Hpsi_current = H_func(psi);
        end
        
        switch method_name
            case 'Euler Explicite'
                psi = psi - 1i * dt * Hpsi_current;
            case 'Euler Implicite'
                psi = A_EI \ psi;
            case 'RK4'
                k1 = -1i * dt * Hpsi_current;
                k2 = -1i * dt * H_func(psi + k1/2);
                k3 = -1i * dt * H_func(psi + k2/2);
                k4 = -1i * dt * H_func(psi + k3);
                psi = psi + (k1 + 2*k2 + 2*k3 + k4)/6;
            case 'Adams-Bashforth 2'
                if n == 1
                    k1 = -1i * dt * Hpsi_current;
                    k2 = -1i * dt * H_func(psi + k1/2);
                    k3 = -1i * dt * H_func(psi + k2/2);
                    k4 = -1i * dt * H_func(psi + k3);
                    psi_new = psi + (k1 + 2*k2 + 2*k3 + k4)/6;
                else
                    psi_new = psi - 1i * dt * (1.5 * Hpsi_current - 0.5 * Hpsi_prev);
                end
                Hpsi_prev = Hpsi_current;
                psi = psi_new;
            case 'Adams-Moulton 2'
                psi = A_AM2 \ (B_AM2 * psi);
        end
        
        if save_idx < N_save && abs(t - t_save(save_idx+1)) < dt/2
            save_idx = save_idx + 1;
            norm_sim(save_idx) = norm_L2(psi, dx, dy);
            energy_sim(save_idx) = energy_total(psi, Lap, V_vec, dx, dy);
            x_mean_sim(save_idx) = mean_x(psi, X, dx, dy);
            psi_snapshots{save_idx} = reshape(psi, sqrt(length(psi)), sqrt(length(psi)));
        end
        if video_idx < N_video && abs(t - t_video(video_idx+1)) < dt/2
            video_idx = video_idx + 1;
            psi_video{video_idx} = reshape(psi, sqrt(length(psi)), sqrt(length(psi)));
        end
    end
end

function val = norm_L2(psi_vec, dx, dy)
    val = sqrt(sum(abs(psi_vec(:)).^2) * dx * dy);
end

function E = energy_total(psi_vec, Lap, V_vec, dx, dy)
    psi = psi_vec(:);
    E_kin = -real(psi' * (Lap * psi));
    E_pot = sum(V_vec .* abs(psi).^2);
    E = (E_kin + E_pot) * dx * dy;
end

function mx = mean_x(psi_vec, X, dx, dy)
    X_vec = X(:);
    dens = abs(psi_vec(:)).^2;
    mx = sum(X_vec .* dens) * dx * dy;
end

function my = mean_y(psi_vec, Y, dx, dy)
    Y_vec = Y(:);
    dens = abs(psi_vec(:)).^2;
    my = sum(Y_vec .* dens) * dx * dy;
end