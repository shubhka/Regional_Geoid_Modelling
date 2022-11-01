% Creating Files for QGIS

% Reading data into a matrix
fid = fopen ("NGS_GRAVD_Block_AN01_Gravity_Data_BETA1.txt", "r");
data = textscan (fid,'AN01%d%d%f%f%f%f\n','Delimiter',' ','MultipleDelimsAsOne',1, 'CommentStyle', '/');
lines = [data(1){:}];
datas = cell2mat(cellfun(@double, data(2:end), 'uni', false));
lat = [data(3){:}];
lon = [data(4){:}] + 360;
elevation = [data(5){:}];
obs_grav = [data(6){:}];

csvwrite('data.txt', [lat, lon, elevation, obs_grav]);

