% GGM Model
fid = fopen ("GGM05C_MS01_h.gdf", "r");
ggm = textscan (fid,'%f%f%f\n','Delimiter',' ','MultipleDelimsAsOne',1, 'HeaderLines',36);
lon_ggm = [ggm(1){:}]-360;
lat_ggm = [ggm(2){:}];
anomaly_gg = [ggm(3){:}]; % meters

% Histogram of height anomaly values
hist(anomaly_gg);
title('height anomaly (m)');
print -djpg heightanomaly.jpg

% Writing GGM values to CSV file for use in QGIS
csvwrite('GGM05C_MS01_ga.txt', [lat_ggm, lon_ggm, anomaly_gg]);

fid = fopen ("GGM05C_gravityanomaly.gdf", "r");
ggm = textscan (fid,'%f%f%f\n','Delimiter',' ','MultipleDelimsAsOne',1, 'HeaderLines',36);
lon_ggm = [ggm(1){:}]-360;
lat_ggm = [ggm(2){:}];
anomaly_gg = [ggm(3){:}]; % meters

% Histogram of height anomaly values
hist(anomaly_gg);
title('gravity anomaly (m)');
print -djpg anomaly.jpg

% Writing GGM values to CSV file for use in QGIS
csvwrite('GGM05C_AN01_GA.txt', [lat_ggm, lon_ggm, anomaly_gg]);


