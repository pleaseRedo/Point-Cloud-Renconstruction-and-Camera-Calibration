function [h] = AhisZero_solve(A)
%AHISZERO_SOLVE Summary of this function goes here
%   Detailed explanation goes here
    [u,s,vh] = svd(A);
    h = vh(:,end);


end

