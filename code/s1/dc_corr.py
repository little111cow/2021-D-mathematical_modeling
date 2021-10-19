from scipy.io import loadmat, savemat

from scipy.spatial.distance import pdist, squareform
import numpy as np


def distcorr(X, Y):
	"""距离相关系数"""
	X = np.atleast_1d(X)
	Y = np.atleast_1d(Y)
	if np.prod(X.shape) == len(X):
		X = X[:, None]
	if np.prod(Y.shape) == len(Y):
		Y = Y[:, None]
	X = np.atleast_2d(X)
	Y = np.atleast_2d(Y)
	n = X.shape[0]
	if Y.shape[0] != X.shape[0]:
		raise ValueError('Number of samples must match')
	a = squareform(pdist(X))
	b = squareform(pdist(Y))
	A = a - a.mean(axis=0)[None, :] - a.mean(axis=1)[:, None] + a.mean()
	B = b - b.mean(axis=0)[None, :] - b.mean(axis=1)[:, None] + b.mean()

	dcov2_xy = (A * B).sum() / float(n * n)
	dcov2_xx = (A * A).sum() / float(n * n)
	dcov2_yy = (B * B).sum() / float(n * n)
	dcor = np.sqrt(dcov2_xy) / (np.sqrt(np.sqrt(dcov2_xx) * np.sqrt(dcov2_yy))+0)
	return dcor

if __name__ == '__main__':
	fid = loadmat('activity_norm.mat')  # 加载归一化数据
	activity = fid['activity_norm']
	# activity1 = np.array(activity)
	fid = loadmat('descriptor_training_byvar.mat')  #去除方差为0变量后的归一化数据
	descriptor_training_norm = fid['descriptor_training_byvar']

	#  计算相关系数
	coff = []
	coff1 = []
	for index, item in enumerate(descriptor_training_norm):
		coff.append(distcorr(activity[0], item))  # 与第一个活性的相关系数
		coff1.append(distcorr(activity[1], item))  # 与第二个活性的相关系数

	savemat('coff1.mat', {'coff1': coff1})
	savemat('coff.mat', {'coff': coff})


