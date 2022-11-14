function [correction] = compute_free_air_correction(lat, elevation, ref_Ellipsoid)
  %calculates free air correction for data point with a given latitude and elevation 
  %INPUT - 
  %1. lat (double) - (degree) Latitudes of the data points
  %2  elevation (double) -(meter) orthometric height of the data points
  %2. ref_ellipsoid(string) - reference ellipsoid either 'WGS84' or 'GRS80'
  %OUTPUT - 
  %   normal_grav (double) - (mGal) Normal Gravity with respect to the given ellipsoid

  ellipsoid = choose_Ellipsoid(ref_Ellipsoid);
  eq_grav = ellipsoid.gammaEquator;
  polar_grav = ellipsoid.gammaPole;
  lat_rad = lat*pi/180;
  
  m = (ellipsoid.omega^2*ellipsoid.a^2*ellipsoid.b)/ellipsoid.GM;
  normal_grav = compute_normal_grav(lat, ref_Ellipsoid);
  t1_1 = (2.*normal_grav)/ellipsoid.a;
  t1_2 = (1+ellipsoid.f+m-2*ellipsoid.f.*sin(lat_rad).^2).*elevation;
  t2 = (3.*eq_grav./ellipsoid.a^2).*elevation.^2;
  
  correction = (t1_1.*t1_2) - t2;
endfunction