function retval = Apply_Padding (array)
  %Function for applying circular padding over a matrix
  %INPUT - 
  %1. array - Matrix 
  %OUTPUT - 
  %   retval - Padded matrix with Circular padding
  
  retval = pdarray(array, [int32(length(array)/3), int32(length(array)/3)], 'circular') ;
endfunction
