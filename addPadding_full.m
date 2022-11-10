function H1 = addPadding_full(H)
    sizeH = size(H);
    zeroH = zeros(sizeH);
    H1 =  [zeroH,zeroH,zeroH;zeroH,H,zeroH;zeroH,zeroH,zeroH];
end