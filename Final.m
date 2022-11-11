% Extracting Grid for study area
[lat, lon, elevation, obs_grav] = Get_Data_Points(32.5, -106);

% Getting Values from the GGM05C Model
array = ['points1_GGM.dat'; 'point10001_GGM.dat'; 'point20001_GGM.dat'];
[lon_ggm, lat_ggm, height_anomaly_ggm, gravity_anomaly_ggm] = GGM_Data (array);

% Calulating Free Air Gravity
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

% Loding Heights from DEM
Heights = imread('srtm_15_06.tif');

lat_dem = linspace(32.5, 33.6, 1320);
lon_dem = linspace(-106.05, -104.95, 1320);
[X_dem, Y_dem] = meshgrid(lon_dem, lat_dem);

H_dem = Heights(1:1320,2941:4260);


TC = Terrain_Correction(lon_dem, lat_dem, H_dem);

