% �����²���
% IΪ������ͼ��
% MΪͼ����
% NΪͼ��߶�
% aΪ�ֿ�Ĵ�С
function J1=fangchacaiyang(I1,M,N,a)
k=1;h=1;
temp=zeros(a*a,1); %���С�����е�����ֵ 
for i=1:a:M-a+1
    for j=1:a:N-a+1
        l=1;
        for m=i:1:i+a-1 
            for n=j:1:j+a-1
            temp(l)=I1(m,n); 
            l=l+1;
            end
        end
        J1(h,k)=var(temp); %���С�����еķ���ֵ
        k=k+1;
    end
    h=h+1;
    k=1; %ÿ�α����������
end