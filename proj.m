fid = fopen ("NGS_GRAVD_Block_PN02_Gravity_Data_BETA1.txt", "r");
% Reading header files into a vector of strings
%header = textscan (fid,'%s', 21, 'Delimiter','\n');
%header = [header{:}];
%header_comb = char(header);
%disp(header);

% Reading data into a matrix
data = textscan (fid,'PN02%d%d%f%f%f%f\n','Delimiter',' ','MultipleDelimsAsOne',1, 'CommentStyle', '/');
lines = [data(1){:}];
datas = cell2mat(cellfun(@double, data(2:end), 'uni', false));
lat = [data(3){:}];
lon = [data(4){:}];
elevation = [data(5){:}];
obs_grav = [data(6){:}];

normal_grav = compute_normal_grav(lat, 'WGS84');
FAA = compute_free_air_anomaly(obs_grav, lat, elevation, 'WGS84');

%% 4)
fid = fopen ("GGM05S.gdf", "r");
ggm = textscan (fid,'%f%f%f\n','Delimiter',' ','MultipleDelimsAsOne',1, 'HeaderLines',36);
lon_ggm = [ggm(1){:}]-360;
lat_ggm = [ggm(2){:}];
anomaly_gg = [ggm(3){:}];

% Interpolate GGM lat-lon to GRAV-D lat-lon
anomaly_ggm = griddata (lon_ggm,lat_ggm,anomaly_gg,lon,lat);
anomaly_smw = FAA - anomaly_ggm;
atm_correction = compute_atm_correction(elevation);
anomaly_ggm_corr = anomaly_ggm - atm_correction;

#plot3(lon,lat,anomaly_ggm_corr,'mo')
figure;
scatter(lon,lat,25,anomaly_ggm,'filled')
xlim([min(lon) max(lon)]);
daspect ([1 1]);
colorbar;

figure;
scatter(lon_ggm,lat_ggm,25,anomaly_gg,'filled')
xlim([min(lon) max(lon)]);
daspect ([1 1]);
colorbar;

%% 6)
% Creating a grid
[X, Y, anomaly_grid] = create_grid(anomaly_ggm_corr, 0.05, lat, lon);
mesh(X, Y, anomaly_grid);
%mesh(lon,lat,anomaly_ggm_corr)
%surf(lon,lat,anomaly_ggm_corr);