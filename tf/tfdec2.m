function struct=tfdec2(img, dict, boundary_condition,downsample_factor)
%tfdec2 1-level 2D frame decomposition.
%tfdec2 performs frame analysis of 2D images.
%dict: specified dictionary. Each row of dict is a filter after reshaping into a
%square form.
%boundary condition: can be either of the following: ppd, sym, symh.
%downsample_factor: can be 1 or a factor of the size of the filter.
if nargin==3
    f=1;
else
    f=downsample_factor;
end

r=sqrt(size(dict,2));
coef=cell(r*r,1);
img_ext=wextend('2',boundary_condition,img,r-1);

for i=1:size(dict,1)
    a=reshape(dict(i,:),[r,r]);
    a=rot90(a,2);
    temp=conv2(img_ext,a,'valid')/r/r*f*f;;
    coef{i}=transpose(downsample(transpose(downsample(temp,f)),f));
end

struct.coef=coef;
struct.imgSize=size(img);
struct.df=f;
struct.dict=dict;
end