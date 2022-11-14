# Geoid_Modelling

This repository contains the code for Regional Geoid Modelling.

## Members
- Ayush Gupta
- Shubhi Kant

### Steps 1

1. Download the observed airborne gravity data i.e. GRAV-D from [here](https://geodesy.noaa.gov/GRAV-D/data_products.shtml).

2. Read the downloaded GRAV-D data file using [Get_Data_Points](./Get_Data_Points.m), as shown below:
```
[lat, lon, elevation, obs_grav] = Get_Data_Points('NGS_GRAVD_Block_MS01_Gravity_Data_BETA1.txt', 32.5, -106, 1.0);
```

### Step 2

1. Download the height anomaly and gravity anomaly for the GGM from [here](http://icgem.gfz-potsdam.de/calcgrid).

2. Read the GGM files downloaded using [GGM_Data](./GGM_Data.m), as shown below:
```
array = ['points1_GGM.dat'; 'point10001_GGM.dat'; 'point20001_GGM.dat'];
[lon_ggm, lat_ggm, height_anomaly_ggm, gravity_anomaly_ggm] = GGM_Data (array);
```

3. Compute orthometric height by adding flight elevation to GGM height, as shown below:
```
ortho_height = elevation + height_anomaly_ggm';
```

### Step 3

1. For computing the free air anomaly use [compute_free_air_anomaly](./compute_free_air_anomaly.m), as shown below:
```
FAA = compute_free_air_anomaly(obs_grav, lat, ortho_height, 'WGS84'); 
```

### Step 4

1. For getting the short wavelength component of gravity subtract the GGM gravity anomaly from free air anomaly, as shown below:
```
anomaly_smw = FAA - gravity_anomaly_ggm';
```

### Step 5

1. For compute the correction to remove gravity attraction due to atmosphere use [compute_atm_correction](./compute_atm_correction.m), as shown below:

```
atm_correction = compute_atm_correction(ortho_height);
anomaly_smw_atm = anomaly_smw - atm_correction;
```

### Step 6

1. To convert the gravity anomaly which is in vector for to a grid, use [create_grid](./create_grid.m), as shown below:

```
[lons, lats, dg_smw_atm] = create_grid(anomaly_smw_atm, 0.01, lat, lon);
```
### Step 7

1. Download the DEM file for your study area from [here](http://srtm.csi.cgiar.org/srtmdata/) as a GeoTIFF file, and convert it into a grid, as shown below:

```
Heights = imread('srtm_15_06.tif'); % Reading DEM file

lat_dem = linspace(32.45, 33.55, 1320);  % Defining the latitude range taking a buffer of 0.5 degree
lon_dem = linspace(-106.1, -105, 1320);  % Defining the longitude range taking a buffer of 0.5 degree
[X_dem, Y_dem] = meshgrid(lon_dem, lat_dem);
H_dem = double(Heights(6000-1319:6000,2941:4260)); 
```

2. For computing the terrain correction use [Terrain_Correction](./Terrain_Correction.m), as shown below

```
TC = Terrain_Correction(X_dem, Y_dem, H_dem);
```
3. Remove the buffer region from the resulting terrain correction matrix, and compute the Faye anomaly by subtracting the Terrain correction from short wavelength gravity anomaly grid computed in **Step 6**

### Step 8

1. For computing the disturbing potential due to reduced gravity anomaly using strokes integral use [strokes_integral](./stokes_integral.m), as shown below:

```
Tr = stokes_integral (lons, lats, g_faye, 'WGS84', 0.01);

```

### Step 9

1. Compute the undulations due to short wavelength using Bruns equation by dividing disturbing potential by normal gravity, as shown below:

```
Nr = Tr./compute_normal_grav(lats, 'WGS84');
```

### Step 10

1. Download the height anomaly for all the grid points from [here](http://icgem.gfz-potsdam.de/calcgrid).

2. Compute the cogeoid by adding the undulation due short wavelength grid to GGM height anomaly grid, as shown below:

```
N = reshape(height_anomaly_gg, [101,101])'; % Reshaping the heigth anomaly to form a grid
N_cogeoid = Nr + N;
```


### Step 11

1. Compute the indirect effect due to terrain on the undulation using [compute_indirect_undulation](./compute_indirect_undulation.m), as shown below:

```
dN = compute_indirect_undulation(H_dem, 1/1200, X_dem, Y_dem, 'WGS84');
```

2. Compute the final geoid by adding the indirect effects to the cogeoid, as shown below:
```
N_geoid = N_cogeoid + dN;
```

***Note***: For information regarding input and output to each of the function use:
```
help "function_name"
```
