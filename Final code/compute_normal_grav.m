function [normal_grav] = compute_normal_grav(lat, ref_Ellipsoid)
  ellipsoid = choose_Ellipsoid(ref_Ellipsoid);
  eq_grav = ellipsoid.gammaEquator;
  polar_grav = ellipsoid.gammaPole;
  pi2rad = pi/180;
  
  den = sqrt((ellipsoid.a.^2*cos(lat*pi2rad).^2) + (ellipsoid.b.^2*sin(lat*pi2rad).^2));
  normal_grav = ((ellipsoid.a*eq_grav.*(cos(lat*pi2rad).^2)) + (ellipsoid.b*polar_grav.*(sin(lat*pi2rad).^2)))./den;
endfunction