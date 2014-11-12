function [ recImg ] = color_mtfrec2( st )
%UNTITLED12 Summary of this function goes here
%   Detailed explanation goes here
recImg=zeros([st.R.imgSize,3]);
r=mtfrec2(st.R);
g=mtfrec2(st.G);
b=mtfrec2(st.B);
recImg(:,:,1)=r;
recImg(:,:,2)=g;
recImg(:,:,3)=b;



end

