function modu = modu_mapping(datain,modu_map)
% program for modulation
% Input parameters description:
% datain:       Input data in matrix-wise for modulation
% modu_map:     Modulation constellation
% Output parameters description:
% modu:         Output data after modulation
for i=1:size(datain,1)
    modu(i) = modu_map(bi2de(datain(i,:),'left-msb')+1);
end