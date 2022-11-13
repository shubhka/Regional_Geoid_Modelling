## Copyright (C) 2022 Omen
##
## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <https://www.gnu.org/licenses/>.

## -*- texinfo -*-
## @deftypefn {} {@var{retval} =} Get_Data_Points (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Omen <Omen@LAPTOP-PSMR0IUC>
## Created: 2022-11-10

function [lat, lon, elevation, obs_grav] = Get_Data_Points (lat1, lon1)
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
