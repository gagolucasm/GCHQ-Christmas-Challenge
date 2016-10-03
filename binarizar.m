function [ resu ] = binarizar( filas,comb )
%BINARIZAR Summary of this function goes here
%   Detailed explanation goes here

for i=1:size(comb,1)
    act=comb(i,:);
    mer(1:2:(length(filas)*2+1))=act;
    mer(2:2:(length(filas)*2+1))=filas;
    bw=cumsum(mer);
    a=ones(1,25);
    for j=1:2:length(filas)*2+1-1;
        a(bw(j)+1:bw(j+1))=0;
    end
    
    resu{i}=a;
    
end

end

