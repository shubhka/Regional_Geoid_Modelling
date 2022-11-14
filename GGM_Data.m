function [lon_ggm, lat_ggm, height_anomaly_ggm, gravity_anomaly_ggm] = GGM_Data (array)
  % Function for reading GGM elevation and gravity anomaly data 
  %INPUT - 
  %1. array (string) - Vector containing path to all the files containing GGM data 
  %OUTPUT - 
  %   lon_ggm (double) - (degree) Longitudes of the GGM data points 
  %   lat_ggm (double) - (degree) Latitude of the GGM data points
  %   height_anomaly_ggm (double) - (meters) GGM height anomaly data 
  %   gravity_anomaly_ggm (double) - (mGal) GGM gravity anomaly data 
  
  i = 1;
  lon_ggm = [];
  lat_ggm = [];
  height_anomaly_ggm = [];
  gravity_anomaly_ggm = [];
  while i <= rows(array)
    fid = fopen (array(i,:), "r");
    ggm = textscan (fid,'%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f',10000, 'Delimiter',' ','MultipleDelimsAsOne',1, 'HeaderLines',56);
    fclose(fid);
    lon_gg = [ggm(2){:}]; % longitude in degrees
    lat_gg = [ggm(3){:}]; % latitude in degrees
    height_anomaly_gg = [ggm(6){:}]; % meters
    gravity_anomaly_gg = [ggm(11){:}]; % mGal
    lon_ggm = [lon_ggm, lon_gg'];
    lat_ggm = [lat_ggm, lat_gg'];
    height_anomaly_ggm = [height_anomaly_ggm, height_anomaly_gg'];
    gravity_anomaly_ggm = [gravity_anomaly_ggm, gravity_anomaly_gg'];
    i = i+1;
  endwhile
endfunction
