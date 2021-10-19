1.对于s3_model1.m和s3_model4.m直接运行可以打印测试数据的预测输出，对应输出的predicted值，对应的是ADMET
性质的第一（CaCo-2）和第四列（HOB）
2.对于s3_model2.m（CYP3A4），s3_model3.m（hERG），s3_model5.m（MN），先运行m代码，再根据论文各个模型的参数修改
SVM的超参数，运行SVM.py文件，会在工作目录保存模型的预测结果。