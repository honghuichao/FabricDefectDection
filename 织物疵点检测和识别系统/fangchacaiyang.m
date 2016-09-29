% 方差下采样
% I为被处理图像
% M为图像宽度
% N为图像高度
% a为分块的大小
function J1=fangchacaiyang(I1,M,N,a)
k=1;h=1;
temp=zeros(a*a,1); %存放小窗口中的像素值 
for i=1:a:M-a+1
    for j=1:a:N-a+1
        l=1;
        for m=i:1:i+a-1 
            for n=j:1:j+a-1
            temp(l)=I1(m,n); 
            l=l+1;
            end
        end
        J1(h,k)=var(temp); %求得小窗口中的方差值
        k=k+1;
    end
    h=h+1;
    k=1; %每次必须进行重置
end