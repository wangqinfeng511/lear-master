git config --global user.name 'wangqinfeng511' 全局用户名
git config --global user.email 'wangqinfeng511@163.com' 全局邮件地址 
git init 初始化本地仓库
git add . 添加本目录的所有文件到本仓库内
git diff 查看修改的内容
git log 查看log
git reflog 查看提交历史ID 
git reset --harid 'b084c01ID'//回到这个提交
git commit -m "描述信息"
github 主页创建仓库
git remote add origin https://github.com/wangqinfeng511/carrier_propject.git //为本地仓库添加添远程仓库地址 并设置名字为 origin
git remote remove origin 删除远程仓库的地址。
git remote 列出已有的地址列表。
git pull --rebase origin master 下载远程仓库文件并于本地仓库合并
git push -u origin master 提交本地仓库的master到远程仓库的master;
git checkout --. 丢弃当前目录下所有工作区中文件的修改
git rm 删除文件
-------------------------------------
git branch 查看本地分支
git branch -v 查看详细的分支信息
git branch -av 查看包括远程仓库在内的分支信息

git branch dev 创建分支dev
git checkout dev 切换分支
git checkout -b dev 新建并切换分支
git checkout master 存在则切换分支
git merge dev 合并分支到当前分支
git branch -d dev 删处分支
---------------------------------------
git clone http://......克隆
git fetch 获取远程仓库最新代码,不作合并
git pull 获取远程仓库代码自动合并，git fetch +git merge
--------------------------------------
git tag -a "tagname" -m 'comment' 'commit_id' 创建标签
-a 指定标签名，-m 添加备注, 'commit-id' 指定打标签的提交
git tag 查看本地所有标签
git show tagname 查看标签信息
git tag -d tagname 删除标签
git push origin:refs/tags/tagname 删除远程标签
git push origin --delete tagname
git push origin:tagname

git push origin tagname 推送单个标签到远程仓库
git push origin --tags 推送所有标签到仓库
------------------------------------------
临时修改
git stash list //显示临时修改
git stash apply //恢复所有保存的临时修改
git stash pop  //恢复最近一次保存的临时修改
git stash clear //丢弃所有保存的临时修改

 