function [HD] = hammingdistance(ref, query)
%
% calculates the bit-wise Hamming Distance of two iriscodes
%
HD = 0.00;

bitMatch = xor(ref,query);

HD  = sum(bitMatch) / size(bitMatch,2);