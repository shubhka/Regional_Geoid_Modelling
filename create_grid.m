function [X, Y, grid] = create_grid(mat, spacing, lat, lon)
  xmin = floor(min(lon)/0.1)*0.1;
  xmax = ceil(max(lon)/0.1)*0.1;
  ymin = floor(min(lat)/0.1)*0.1;
  ymax = ceil(max(lat)/0.1)*0.1;
  
  gridx = [xmin:spacing:xmax]; % longitude grid spacing
  gridy = [ymin:spacing:ymax]; % latitude grid spacing
  [X, Y] = meshgrid(gridx, gridy);
  grid = griddata (lon,lat,mat,X,Y);
endfunction