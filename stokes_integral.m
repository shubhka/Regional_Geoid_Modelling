function [retval] = stokes_integral (lon, lat, g_faye, ref_ellipsoid, res)
  %calculates gravimetric terrain reduction TC over given Latitude,Longitude grid with a given resolution
  %INPUT - 
  %1. lon (double) -(degrees) Latitude grid used for gfaye
  %2. lat (double) -(degrees) Longitude grid used for gfaye
  %3. g_faye (double) -(meter) Faye gravity anomaly
  %4. ref_ellipsoid(string) - reference ellipsoid either 'WGS84' or 'GRS80' 
  %5. res (double) -(degrees) Grid resolution 
  %OUTPUT - 
  %   retval (double) - (meter) gravimetric disturbing potential

  lat_c = (max(max(lat)) + min(min(lat)))/2;
  lon_c = (max(max(lon)) + min(min(lon)))/2;

  x = (lon - lon_c).*cosd(lat);
  y = lat - lat_c;

  sin_2_shi = (sind(y/2).^2) + (sind(x/2).^2).*cosd(lat).*cos(lat_c);
  sin_2_shi(sin_2_shi < 0.00001) = 0.00001;
  sin_shi = real(sin_2_shi.^(1/2));
  shi = real(2.*asind(sin_shi));
  d = log(sin_shi + sin_2_shi);
  cos_shi = cosd(shi);
  K = (1./sin_shi) -4  - 6.*sin_shi - 5.*cos_shi - 3.*cos_shi.*log(d);
  K = (1./sin_shi) - 4 + 6*sin_shi + 10*sin_2_shi - (3 - 6*sin_2_shi) - d;
  
  
  %p = x.^2 + y.^2;
  %p(p < 0.000001) = 0.000001;
  %K = real(2./(p.^(1/2)));
  
  ellipsoid = choose_Ellipsoid(ref_ellipsoid);
  R = ellipsoid.a;
  F1 = fft2(fftshift(K));
  F2 = fft2(g_faye);
  F3 = ifft2(F2.*F1);
  retval = real((R/4*pi).*F3.*((res*(pi/180))^2));
endfunction
