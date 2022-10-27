function [ellipsoid] = choose_Ellipsoid(ellipType)
  switch ellipType
    case 'WGS84'
      ellipsoid.GM = 3986004.418E8;
      ellipsoid.omega = 7.292115e-5;
      ellipsoid.gammaEquator = 978032.53359;
      ellipsoid.gammaPole = 983218.49378;
      ellipsoid.a = 6378137.0;
      ellipsoid.b = 6356752.3142;
      ellipsoid.e = 8.1819190842622.*1E-2; %first eccentricity
      ellipsoid.e2 = 6.69437999014.*1E-3; %first eccentricity squared
      ellipsoid.f = 1/298.257223563; %flattening
      %WGS84 defining parameters from NIMA (2004).
    case 'GRS80'
      ellipsoid.GM=3986005E8;
      ellipsoid.omega=7.292115e-5;
      ellipsoid.gammaEquator=978032.67715;
      ellipsoid.gammaPole = 983218.63685;
      ellipsoid.a = 6378137;
      ellipsoid.b = 6356752.3142;
      ellipsoid.e = 0.081819190842622; %first eccentricity
      ellipsoid.e2 = 0.00669437999014; %first eccentricity squared
      ellipsoid.f = 0.00335281066474; %flattening
      %GRS80 defining parameters from Moritz (2000).
    otherwise
      warning('This ellipsoid is not supported')
    return
  end
end