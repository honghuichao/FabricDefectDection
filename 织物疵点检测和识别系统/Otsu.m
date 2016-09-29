%Oust方法得到图像分割的阈值
function t=Otsu(I)
[m,n]=size(I);
I=double(I);
count=zeros(256,1); %用于存放各个灰度值的个数
pcount=zeros(256,1); %各个像素的百分率
%得到各个灰度值的个数
for i=1:m
    for j=1:n
        pixel=I(i,j);
        count(pixel+1)=count(pixel+1)+1;
    end
end
dw=0;
%得到各个灰度值的概率
for i=0:255
    pcount(i+1)=count(i+1)/(m*n);
    dw=dw+i*pcount(i+1); %平均灰度
end
%中间变量
threshold=0;
thresholdbest=0;
dfc=0;
dfcmax=0;
%求得otsu阈值
while (threshold>=0 & threshold<=255)
    dp1=0;
    dw1=0;
    for i=0:threshold
        dp1=dp1+pcount(i+1);
        dw1=dw1+i*pcount(i+1);
    end
    if dp1>0
        dw1=dw1/dp1;
    end
    dp2=0;
    dw2=0;
    for i=threshold+1:255
        dp2=dp2+pcount(i+1);
        dw2=dw2+i*pcount(i+1);
    end
    if dp2>0
        dw2=dw2/dp2;
    end
    dfc=dp1*(dw1-dw)*(dw1-dw)+dp2*(dw2-dw)*(dw2-dw);
    if dfc>=dfcmax
        dfcmax=dfc;
        thresholdbest=threshold;
    end
    threshold=threshold+1;
end
t=thresholdbest; %返回最佳阈值