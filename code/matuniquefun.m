function [mat2,indexa1]=matuniquefun(mat1)
[n,m]=size(mat1); 
datacell=cell(n,1);
for i=1:n
    str1=num2str(mat1(i,1));
    for j=2:m
        str1=[str1,'-',num2str(mat1(i,j))];
    end
    datacell{i,1}=str1;
end
[c1,indexa1,indexc1] = unique(datacell);
mat2=mat1(indexa1,:);
