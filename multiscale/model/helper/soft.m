function Y=soft(A,a)
Y=(A-a).*(A>a)+(A+a).*(A<-a);
end