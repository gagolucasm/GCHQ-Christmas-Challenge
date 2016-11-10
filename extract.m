function [ x ] = extract( n,d )
 c = nchoosek(1:d+n-1,n-1);
 m = size(c,1);
 t = ones(m,d+n-1);
 t(repmat((1:m).',1,n-1)+(c-1)*m) = 0;
 u = [zeros(1,m);t.';zeros(1,m)];
 v = cumsum(u,1);
 x = diff(reshape(v(u==0),n+1,m),1).';
 
c1=any(x(:,2:end-1)==0,2);
x(c1,:)=[];


end

