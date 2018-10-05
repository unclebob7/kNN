function D=Euclidian_distance(data1,data2) %data:N*L

if nargin<2 %求data1数据之间的欧氏距离阵D
    length_1=sum((data1.*data1)'); % 1*N; data:N*L
    ab=data1*data1';
    D=repmat(length_1,[size(length_1,2),1]) + repmat(length_1',[1 size(length_1,2)]) -2*ab;
    D = min(D,D');
    D=sqrt(D);
    for i=1:size(D,1) D(i,i)=0; end
else %求data1和data2数据之间的欧氏距离阵D
    length_1=sum((data1.*data1)',1); % 1*N; data:N*L
    length_2=sum((data2.*data2)',1);
    ab=data1*data2';
    data1=[];data2=[];
    D=repmat(length_1',[1,size(length_2,2)]) + repmat(length_2,[size(length_1,2),1]) -2*ab;
    D=sqrt(D);
end

D=real(D);