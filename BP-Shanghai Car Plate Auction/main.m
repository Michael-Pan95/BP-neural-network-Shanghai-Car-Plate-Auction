%������
%����������ʼֵ�趨
net=feedforwardnet(10,'trainbr');
net.trainParam.epochs=800;
net.trainParam.goal=0.00001;
net.divideParam.testRatio=0.15;
net.divideParam.trainRatio=0.7;
net.divideParam.valRatio=0.15;
net.trainParam.mu=0.000001;
net.trainParam.mu_dec=0.1;
net.trainParam.mu_inc=10;

filename = 'License Plate.xlsx';%���������ļ�λ��
amount=xlsread(filename,'D2:D173');%��ȡ����
[input,output,test]=inputSet(amount);
[input,PS] = mapminmax(input);%��һ��
[output,TS] = mapminmax(output);%��һ��
test = mapminmax('apply',test,PS);%��һ��
%������ѵ��
net=train(net,input,output);

%��ɶԲ������ݺ�ʵ�����ݵĻ���,�Ա�
NormTestOutput=sim(net,test);
NormTestOutput=mapminmax('reverse',NormTestOutput,TS);
testop=NormTestOutput;
newamount=amount(149:172);

%����ͼ��
x=1:24;
y1=testop(x);
y2=newamount(x);


figure(1)
plot(x,y1,'r',x,y2,'g--');
title('������ʵ����ֵ�Ƚ�')
ylabel('ƽ���ɽ��۸�')

%Ԥ���¸��µ���ֵ
projection=[83148;85127;85058];
projection=mapminmax('apply',projection,PS);
projection=sim(net,projection);
projection=mapminmax('reverse',projection,TS)

%Full image
FullOutput=sim(net,[input test]);
FullOutput=mapminmax('reverse',FullOutput,TS);
x1=4:172;
y3=amount(x1);
y4=FullOutput(x1-3);
figure(2)
plot(x1,y3,'m',x1,y4,'k');