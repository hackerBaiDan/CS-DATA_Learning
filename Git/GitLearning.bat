%   Author:BaiDan 2021.01.18   %
% GitHub & Git Simple Learning %

% GitHub 链接 Git %
echo 创建SSH
ssh-keygen -t rsa -C "youremail@example.com"

% 基本信息设置 %
git config --global user.name '用户名'
git config --global user.email '邮箱'

% 克隆仓库 %
git clone 克隆地址

% 新建仓库并初始化 %
mkdir 新文件名
cd 新文件名
git init

% 上传文件 %
echo 文件提交暂存区
git add  ***
git status
echo 暂存区提交仓库
git commit -m '提交注释'   # 暂存区提交仓库
git commit -am  '提交注释' # 提交跟踪过的文件
git status

