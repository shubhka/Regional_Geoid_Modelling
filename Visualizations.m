% Visulalizing the orthometric height
figure;
mesh(lons, lats, N);
xlim([min(min(lons)), max(max(lons))]);
xlabel('longitude');
ylabel('latitude');
title('Long Wavelength Undulations (m)')'

figure;
[M,c] =contourf(lons, lats, N);
c.linewidth = 10;
colorbar;
xlim([min(min(lons)), max(max(lons))]);
xlabel('longitude');
ylabel('latitude');
title('Long Wavelength Undulations (m)')'

% Visulalizing the Normal Gravity
figure;
mesh(lons, lats, compute_normal_grav(lats, 'WGS84'));
xlim([min(min(lons)), max(max(lons))]);
xlabel('longitude');
ylabel('latitude');
title('Normal Gravity (mGal)')'

figure;
[M,c] =contourf(lons, lats, compute_normal_grav(lats, 'WGS84'));
c.linewidth = 10;
colorbar;
xlim([min(min(lons)), max(max(lons))]);
xlabel('longitude');
ylabel('latitude');
title('Normal Gravity (mGal)')'

% Visualizing dg_smw_atm
figure;
[M,c] =contourf(lons, lats, dg_smw_atm);
c.linewidth = 10;
colorbar;
xlim([min(min(lons)), max(max(lons))]);
xlabel('longitude');
ylabel('latitude');
title('Gravity Anomaly (mGal)')';

figure;
mesh(lons, lats, dg_smw_atm);
xlim([min(min(lons)), max(max(lons))]);
xlabel('longitude');
ylabel('latitude');
title('Gravity Anomaly(mGal)')'

% Visulaizing the TC
figure;
[M,c] =contourf(lons, lats, TC);
caxis([0,0.6]);
c.linewidth = 10;
colorbar;
xlim([min(min(lons)), max(max(lons))]);
xlabel('longitude');
ylabel('latitude');
title('Terrain Correction (mGal)')';

figure;
mesh(lons, lats, TC);
xlim([min(min(lons)), max(max(lons))]);
xlabel('longitude');
ylabel('latitude');
title('Terrain Correction(mGal)')'

% Faye Anomaly
figure;
[M,c] =contourf(lons, lats, g_faye);
c.linewidth = 10;
colorbar;
xlim([min(min(lons)), max(max(lons))]);
xlabel('longitude');
ylabel('latitude');
title('Faye Anomaly (mGal)')';

figure;
mesh(lons, lats, g_faye);
xlim([min(min(lons)), max(max(lons))]);
xlabel('longitude');
ylabel('latitude');
title('Faye Anomaly(mGal)')'

% Disturbing Potential
figure;
[M,c] =contourf(lons, lats, Tr);
c.linewidth = 10;
colorbar;
xlim([min(min(lons)), max(max(lons))]);
xlabel('longitude');
ylabel('latitude');
title('Disturbing Potential (mGal- m)')';

figure;
mesh(lons, lats, Tr);
xlim([min(min(lons)), max(max(lons))]);
xlabel('longitude');
ylabel('latitude');
title('Disturbing Potential(mGal- m)')'

% Undulation
figure;
[M,c] =contourf(lons, lats, Nr);
c.linewidth = 10;
colorbar;
xlim([min(min(lons)), max(max(lons))]);
xlabel('longitude');
ylabel('latitude');
title('Undulation (m)')';

figure;
mesh(lons, lats, Nr);
xlim([min(min(lons)), max(max(lons))]);
xlabel('longitude');
ylabel('latitude');
title('Undulation (m)')'

% DEM Heights
figure;
[M,c] =contourf(X_dem, Y_dem, H_dem);
c.linewidth = 10;
colorbar;
xlim([min(min(X_dem)), max(max(X_dem))]);
xlabel('longitude');
ylabel('latitude');
title('Heights (m)')';

figure;
mesh(X_dem, Y_dem, H_dem);
xlim([min(min(lons)), max(max(lons))]);
xlabel('longitude');
ylabel('latitude');
title('Heights (m)')'

% Co-geoid
figure;
[M,c] =contourf(lons, lats, N_cogeoid);
c.linewidth = 10;
colorbar;
xlim([min(min(X_dem)), max(max(X_dem))]);
xlabel('longitude');
ylabel('latitude');
title('Co-geoid (m)')';

figure;
mesh(lons, lats, N_cogeoid);
xlim([min(min(lons)), max(max(lons))]);
xlabel('longitude');
ylabel('latitude');
title('Co-geoid (m)')'

% Geoid
figure;
[M,c] =contourf(lons, lats, real(N_geoid'));
c.linewidth = 10;
colorbar;
xlim([min(min(X_dem)), max(max(X_dem))]);
xlabel('longitude');
ylabel('latitude');
title('geoid (m)')';

figure;
mesh(lons, lats, real(N_geoid));
xlim([min(min(lons)), max(max(lons))]);
xlabel('longitude');
ylabel('latitude');
title('geoid (m)')'

% Indirect Effect
figure;
[M,c] =contourf(lons, lats, real(dN));
c.linewidth = 10;
colorbar;
xlim([min(min(X_dem)), max(max(X_dem))]);
xlabel('longitude');
ylabel('latitude');
title('Indirect Effect (m)')';

figure;
mesh(lons, lats, real(dN));
xlim([min(min(lons)), max(max(lons))]);
xlabel('longitude');
ylabel('latitude');
title('Indirect Effect (m)')'

% FAA
g_faa = griddata(lon, lat, FAA, lons, lats, 'v4');
figure;
[M,c] =contourf(lons, lats, g_faa);
c.linewidth = 10;
colorbar;
xlim([min(min(X_dem)), max(max(X_dem))]);
xlabel('longitude');
ylabel('latitude');
title('Free Air Anomaly (mGal)')';

figure;
mesh(lons, lats, g_faa);
xlim([min(min(lons)), max(max(lons))]);
xlabel('longitude');
ylabel('latitude');
title('Free Air Anomaly (mGal)')'

