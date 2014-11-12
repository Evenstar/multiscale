function out=count_equations(r,M)
out=0;
for l=0:M-1
    for k=-r+1:r-1
        flag=0;
        for n=-r:r
            if M*n+k+l>=1 && M*n+k+l<=r && M*n+l>=1 && M*n+l<=r
                flag=1;
                break;
            end
        end
        if flag==1
            out=out+1;
        end
    end
end
end