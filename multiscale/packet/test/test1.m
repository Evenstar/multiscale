dict=randn(6,6,4)/4;
A=reshape(dict,[36,4]);
aw_uep_2d_c(A')
[newdict]=proj_uep_2d_c(dict,500);

A=reshape(newdict,[36,4]);
aw_uep_2d_c(A')