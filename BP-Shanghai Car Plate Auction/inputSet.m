function [input,output,test]=inputSet(Amount)
%接收并处理原始数据，输出input ,output,test三个集合
%分割数据让其输入一组最低价和平均价，分割出数据的input ,outut 和test 测试集占约20%

%所有输入数据的处理
input=zeros(3,0);
for i=1:170
    temp=zeros(0,1);
    for j=i:i+2
    temp=[temp;Amount(j)];
    end
    input=[input temp];
end

test =input(:,146:169);
output=Amount(4:148)';
input=input(:,1:145);