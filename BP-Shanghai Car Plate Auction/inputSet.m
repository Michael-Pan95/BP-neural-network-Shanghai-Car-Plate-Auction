function [input,output,test]=inputSet(Amount)
%���ղ�����ԭʼ���ݣ����input ,output,test��������
%�ָ�������������һ����ͼۺ�ƽ���ۣ��ָ�����ݵ�input ,outut ��test ���Լ�ռԼ20%

%�����������ݵĴ���
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