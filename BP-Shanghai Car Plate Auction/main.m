%主函数
%完成神经网络初始值设定
net=feedforwardnet(10,'trainbr');
net.trainParam.epochs=800;
net.trainParam.goal=0.00001;
net.divideParam.testRatio=0.15;
net.divideParam.trainRatio=0.7;
net.divideParam.valRatio=0.15;
net.trainParam.mu=0.000001;
net.trainParam.mu_dec=0.1;
net.trainParam.mu_inc=10;

filename = 'License Plate.xlsx';%定义数据文件位置
amount=xlsread(filename,'D2:D173');%获取数量
[input,output,test]=inputSet(amount);
[input,PS] = mapminmax(input);%归一化
[output,TS] = mapminmax(output);%归一化
test = mapminmax('apply',test,PS);%归一化
%神经网络训练
net=train(net,input,output);

%完成对测试数据和实际数据的绘制,对比
NormTestOutput=sim(net,test);
NormTestOutput=mapminmax('reverse',NormTestOutput,TS);
testop=NormTestOutput;
newamount=amount(149:172);

%绘制图形
x=1:24;
y1=testop(x);
y2=newamount(x);


figure(1)
plot(x,y1,'r',x,y2,'g--');
title('仿真与实际数值比较')
ylabel('平均成交价格')

%预测下个月的数值
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