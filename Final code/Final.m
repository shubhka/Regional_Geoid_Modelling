% Extracting Grid for study area
[lat, lon, elevation, obs_grav] = Get_Data_Points(32.5, -106);

% Getting Values from the GGM05C Model
array = ['points1_GGM.dat'; 'point10001_GGM.dat'; 'point20001_GGM.dat'];
[lon_ggm, lat_ggm, height_anomaly_ggm, gravity_anomaly_ggm] = GGM_Data (array);

% Calulating Normal Gravity
normal_grav = compute_normal_grav(lat, 'WGS84'); %mGal

% Estimating Orthometric heights
ortho_height = elevation + height_anomaly_ggm';

% Calculating Free Air Anomaly
FAA = compute_free_air_anomaly(obs_grav, lat, ortho_height, 'WGS84'); %mGal

% Removing GGM
anomaly_smw = FAA - gravity_anomaly_ggm';

% Removing effect of atmosphere
atm_correction = compute_atm_correction(ortho_height);
anomaly_smw_atm = anomaly_smw - atm_correction;

% Creating a grid with 0.01 degree resolution
[lons, lats, dg_smw_atm] = create_grid(anomaly_smw_atm, 0.01, lat, lon);

% Loading Heights from DEM
Heights = imread('srtm_15_06.tif');

lat_dem = linspace(32.45, 33.55, 1320);
lon_dem = linspace(-106.1, -105, 1320);
[X_dem, Y_dem] = meshgrid(lon_dem, lat_dem);

H_dem = double(Heights(6000-1319:6000,2941:4260));

% Terrain Correction Computation
TC = Terrain_Correction(X_dem, Y_dem, H_dem);
TC = TC(1:12:1320,1:12:1320);
TC = TC(1:101,5:105);
mean_dN = mean(TC(:));
std_dN = std(TC(:));
CI = mean_dN + 3*std_dN;
CN = mean_dN - 3*std_dN;
TC(TC > CI) = mean_dN;
TC(TC < CN) = mean_dN;

g_faye = dg_smw_atm - TC;

% Calculating Disturbing potential
Tr = stokes_integral (lons, lats, g_faye, 'WGS84', 0.01);

% Calculating Undulation
Nr = Tr./compute_normal_grav(lats, 'WGS84');

% Restoring the Undulation
%[lons, lats, N] = create_grid(height_anomaly_ggm, 0.01, lat, lon);
fid = fopen ('GGM05C_0.01.gdf', "r");
ggm = textscan (fid,'%f%f%f', 'Delimiter',' ','MultipleDelimsAsOne',1, 'HeaderLines',36);
fclose(fid);
lon_gg = [ggm(1){:}] - 360; % longitude in degrees
lat_gg = [ggm(2){:}]; % latitude in degrees
height_anomaly_gg = [ggm(3){:}]; % meters
N = reshape(height_anomaly_gg, [101,101])';
N_cogeoid = Nr + N;

% Adding the indirect effect
dN = compute_indirect_undulation(H_dem, 1/1200, X_dem, Y_dem, 'WGS84');
dN = dN(1:12:1320,1:12:1320);
dN = dN(1:101,5:105);
% Removing Outliers
mean_dN = mean(dN(:));
std_dN = std(dN(:));
CI = mean_dN + 3*std_dN;
CN = mean_dN - 3*std_dN;
dN(dN > CI) = mean_dN;
dN(dN < CN) = mean_dN;
N_geoid = N_cogeoid + dN;
