function [ cuenta ] = contar( asdf )
%CONTAR Summary of this function goes here
%   Detailed explanation goes here
cuenta=0;
for i=1:25
    x=asdf{i};
    cuenta=cuenta+length(x);
end


end

