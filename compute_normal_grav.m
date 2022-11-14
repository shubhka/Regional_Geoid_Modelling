function [normal_grav] = compute_normal_grav(lat, ref_Ellipsoid)
  %calculates Normal Gravity for data point with a given latitude 
  %INPUT - 
  %1. lat (double) - (degree) Latitudes of the data points
  %2. ref_ellipsoid(string) - reference ellipsoid either 'WGS84' or 'GRS80'
  %OUTPUT - 
  %   normal_grav (double) - (mGal) Normal Gravity with respect to the given ellipsoid

  ellipsoid = choose_Ellipsoid(ref_Ellipsoid);
  eq_grav = ellipsoid.gammaEquator;
  polar_grav = ellipsoid.gammaPole;
  pi2rad = pi/180;
  
  den = sqrt((ellipsoid.a.^2*cos(lat*pi2rad).^2) + (ellipsoid.b.^2*sin(lat*pi2rad).^2));
  normal_grav = ((ellipsoid.a*eq_grav.*(cos(lat*pi2rad).^2)) + (ellipsoid.b*polar_grav.*(sin(lat*pi2rad).^2)))./den;
endfunction