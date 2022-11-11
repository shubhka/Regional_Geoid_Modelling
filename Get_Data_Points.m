function [lat, lon, elevation, obs_grav] = Get_Data_Points (lat1, lon1)
  %Function for reading the observed gravity data points
  %INPUT - 
  %1. filename (string)- Path of the GRAV-D data
  %2. lat1 (double)- Latitude of the center point of study area
  %3. lon1 (double)- Longitude of the center point of study area
  %OUTPUT - 
  %   lon - Longitude of the observed gravity data points
  %   lat - Latitude of the observed gravity data points  
  %   elevation - Flight elevation of the observed gravity data points
  %   obs_grav - observed gravity of the data points
  
  % Opening the file
  fid = fopen ("NGS_GRAVD_Block_MS01_Gravity_Data_BETA1.txt", "r");

  % Reading data into a matrix
  data = textscan (fid,'MS01%d%d%f%f%f%f\n','Delimiter',' ','MultipleDelimsAsOne',1, 'CommentStyle', '/');
  fclose(fid);
  lines = [data(1){:}];
  datas = cell2mat(cellfun(@double, data(2:end), 'uni', false));

  % Filtering the Data for our study area of 1deg x 1deg
  datas = datas(datas(:,2) >= lat1, :);
  datas = datas(datas(:,2) <= lat1 + 1, :);
  datas = datas(datas(:,3) >= lon1, :);
  datas = datas(datas(:,3) <= lon1 + 1, :);

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
