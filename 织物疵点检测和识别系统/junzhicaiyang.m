% ���о�ֵ�²���
% IΪ������ͼ��
% MΪͼ����
% NΪͼ��߶�
% aΪ�ֿ�Ĵ�С
function J=junzhicaiyang(I,M,N,a)
k=1;h=1;temp=0;
%��ֵ�²�������������ͼ����������
for i=1:a:M-a+1
    for j=1:a:N-a+1
        %ÿһ��С��ľ�ֵ��Ϊ�µ�ͼ������ֵ
        temp=0;
        for m=i:1:i+a-1 
            for n=j:1:j+a-1
                temp=temp+I(m,n);
            end
        end
        J(h,k)=temp/(a*a); %�����ֵ����Ϊ�µ�ͼ������ֵ
        k=k+1;
    end
    h=h+1;
    k=1; %ÿ�α����������
end