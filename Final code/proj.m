fid = fopen ("NGS_GRAVD_Block_MS01_Gravity_Data_BETA1.txt", "r");
% Reading header files into a vector of strings
%header = textscan (fid,'%s', 21, 'Delimiter','\n');
%header = [header{:}];
%header_comb = char(header);
%disp(header);

% Reading data into a matrix
data = textscan (fid,'MS01%d%d%f%f%f%f\n','Delimiter',' ','MultipleDelimsAsOne',1, 'CommentStyle', '/');
lines = [data(1){:}];
datas = cell2mat(cellfun(@double, data(2:end), 'uni', false));
datas = datas(datas(:,2) >= 32.5, :);
datas = datas(datas(:,2) <= 33.5, :);
datas = datas(datas(:,3) >= -106, :);
datas = datas(datas(:,3) <= -105, :);
lat = datas(:,2);
lon = datas(:,3);
elevation = datas(:,4); % meters
obs_grav = datas(:,5); %mGal

% GGM Model for height anomalies and gravity anomalies
fid = fopen ("GGM05C1.dat", "r");
ggm = textscan (fid,'%f%f%f%f%f%f%f%f%f%f%f\n','Delimiter',' ','MultipleDelimsAsOne',1, 'HeaderLines',42);
lon_ggm = [ggm(2){:}];
lat_ggm = [ggm(3){:}];
height_anomaly_gg = [ggm(6){:}]; % meters
gravity_anomaly_gg = [ggm(11){:}]; % mGal

% Interpolate GGM lat-lon to GRAV-D lat-lon for height anomaly
height_anomaly_ggm = griddata (lon_ggm,lat_ggm,height_anomaly_gg,lon,lat, 'v4');

% Calculating Normal Gravity
normal_grav = compute_normal_grav(lat, 'WGS84'); %mGal

% Calculating Free-air Gravity Anomaly
ortho_height = elevation + height_anomaly_ggm;
FAA = compute_free_air_anomaly(obs_grav, lat, ortho_height, 'WGS84'); %mGal

% Interpolate GGM lat-lon to GRAV-D lat-lon
gravity_anomaly_ggm = griddata (lon_ggm,lat_ggm,gravity_anomaly_gg,lon,lat, 'v4');

anomaly_smw = FAA - gravity_anomaly_ggm;
atm_correction = compute_atm_correction(ortho_height);
anomaly_smw_atm = anomaly_smw - atm_correction;

#plot3(lon,lat,anomaly_ggm_corr,'mo')
figure;
scatter(lon,lat,25,FAA,'filled')
xlim([min(lon) max(lon)]);
daspect ([1 1]);
colorbar;

figure;
scatter(lon_ggm,lat_ggm,25,gravity_anomaly_gg,'filled')
xlim([min(lon) max(lon)]);
daspect ([1 1]);
colorbar;

%% 6)
% Creating a grid
[X, Y, anomaly_grid] = create_grid(anomaly_smw_atm, 0.05, lat, lon);
mesh(X, Y, anomaly_grid);
%mesh(lon,lat,anomaly_ggm_corr)
%surf(lon,lat,anomaly_ggm_corr);

pkg load mapping
[A1, R1] = rasterread('srtm_16_06.tif');
[A2, R2] = rasterread('srtm_15_06.tif');
Heights = [A1.data, A2.data];

