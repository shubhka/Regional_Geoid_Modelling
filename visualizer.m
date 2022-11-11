function retval = visualizer (lat, lon, val, min_lat, min_lon, title_fig)
  lons = linspace(min_lon, min_lon+ 1, 100);
  lats = linspace(min_lat, min_lat+ 1, 100);
  [xx, yy] = meshgrid(lons, lats);
  vals = griddata(lon, lat, val, xx, yy, 'v4');
  figure;
  mesh(xx, yy, vals);
  xlim([min(lons) max(lons)]);
  daspect ([1 1]);
  colorbar;
  xlabel('longitude');
  ylabel('latitude');
  title(title_fig);
  savefig(title_fig);
endfunction
