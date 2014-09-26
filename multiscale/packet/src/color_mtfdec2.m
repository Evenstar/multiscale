function st=color_mtfdec2(img,Dict,L,boundary_condition)
m=size(Dict,2)/3;
dict=Dict(:,1:m);

temp=mtfdec2(img(:,:,1),dict,L,boundary_condition);
st.R=temp;

dict=Dict(:,m+1:2*m);
temp=mtfdec2(img(:,:,2),dict,L,boundary_condition);
st.G=temp;

dict=Dict(:,2*m+1:3*m);
temp=mtfdec2(img(:,:,3),dict,L,boundary_condition);
st.B=temp;
end