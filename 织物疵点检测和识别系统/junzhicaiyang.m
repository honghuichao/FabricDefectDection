% 进行均值下采样
% I为被处理图像
% M为图像宽度
% N为图像高度
% a为分块的大小
function J=junzhicaiyang(I,M,N,a)
k=1;h=1;temp=0;
%均值下采样，用于削弱图像周期纹理
for i=1:a:M-a+1
    for j=1:a:N-a+1
        %每一个小块的均值作为新的图像像素值
        temp=0;
        for m=i:1:i+a-1 
            for n=j:1:j+a-1
                temp=temp+I(m,n);
            end
        end
        J(h,k)=temp/(a*a); %计算均值，作为新的图像像素值
        k=k+1;
    end
    h=h+1;
    k=1; %每次必须进行重置
end