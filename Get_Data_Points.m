function [lat, lon, elevation, obs_grav] = Get_Data_Points (filename, lat1, lon1, size)
  % Function for reading GGM elevation and gravity anomaly data 
  %INPUT - 
  %1. filename (string) - path to GRAV-D file containing observed graity data
  %2. lat1 (double) - (degree) latitude of bottom left corner of study area
  %2. lon1 (double) - (degree) longitude of bottom left corner of study area
  %2. size (double) - (degree) path to GRAV-D file containing observed graity data 
  %OUTPUT - 
  %   lon_ggm (double) - (degree) Longitudes of the GGM data points 
  %   lat_ggm (double) - (degree) Latitude of the GGM data points
  %   elevation (double) - (meters) Flight elevation for each data point 
  %   gravity_anomaly_ggm (double) - (mGal) Observed gravity data 

  
  % Opening the file
  fid = fopen (filename, "r");

  % Reading data into a matrix
  data = textscan (fid,'MS01%d%d%f%f%f%f\n','Delimiter',' ','MultipleDelimsAsOne',1, 'CommentStyle', '/');
  fclose(fid);
  lines = [data(1){:}];
  datas = cell2mat(cellfun(@double, data(2:end), 'uni', false));

  % Filtering the Data for our study area of size deg x size deg
  datas = datas(datas(:,2) >= lat1, :);
  datas = datas(datas(:,2) <= lat1 + size, :);
  datas = datas(datas(:,3) >= lon1, :);
  datas = datas(datas(:,3) <= lon1 + size, :);

  lat = datas(:,2);
  lon = datas(:,3);

  elevation = datas(:,4);
  obs_grav = datas(:,5);

  A = [lat lon];
  i = 1;
  while i < length(A)
    if length(A) - i >= 9999
      p = 9999;
    else
      p = length(A) - i;
    endif
    X = A(i:i+p,:);
    name = strcat("point", num2str(i), ".txt");
    save(name, "X");
    i = i+10000;
  endwhile
  save point.txt A;
  endfunction
