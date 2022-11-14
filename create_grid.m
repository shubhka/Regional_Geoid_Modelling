function [X, Y, grid] = create_grid(mat, spacing, lat, lon)
  %Function for vector into a grid
  %INPUT - 
  %1. mat - input vector 
  %2. spacing - spacing in the resulting grid
  %3. lat - latitude data for the data point of input vector
  %4. lon - longitude data for the data point of input vector
  %OUTPUT - 
  %   X - grid containing longitude of the corresponding to the output grid
  %   Y - grid containing latitude of the corresponding to the output grid
  %   grid - output converted grid of the input vector 

  xmin = floor(min(lon)/0.1)*0.1;
  xmax = ceil(max(lon)/0.1)*0.1;
  ymin = floor(min(lat)/0.1)*0.1;
  ymax = ceil(max(lat)/0.1)*0.1;

  gridx = [xmin:spacing:xmax]; % longitude grid spacing
  gridy = [ymin:spacing:ymax]; % latitude grid spacing
  [X, Y] = meshgrid(gridx, gridy);
  grid = griddata (lon,lat,mat,X,Y, 'v4');
endfunction
