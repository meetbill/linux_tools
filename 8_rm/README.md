开启linux和mac下命令行版本rm的回收站

* [适用系统](#适用系统)
* [使用说明](#使用说明)
	* [安装](#安装)
	* [使用](#使用)
* [功能说明](#功能说明)
	* [彻底删除文件](#彻底删除文件)

## 适用系统

> * Linux
> * mac

## 使用说明  

### 安装

```
#curl -o rmtrash.sh https://raw.githubusercontent.com/BillWang139967/linux_tools/master/8_rm/rmtrash.sh
#mv rmtrash.sh /bin/
#chmod +x /bin/rmtrash.sh
#/bin/rmtrash.sh  
#source ~/.bashrc  
```

如果想对全局所有用户启用回收站，需要修改bashrc全局配置文件后即可：  
echo "alias rm=/bin/rmtrash.sh" >>/etc/bashrc  

### 使用  
rm -h  
Usage: rm         file1 [file2] [dir3] [....] delete the files or dirs,and mv them to the rmtrash recycle bin  
       rm is alias to rmtrash.sh.  
options:  
	-f  mv one or more files to the rmtrash recycle bin  
	-r  mv one or more files to the rmtrash recycle bin  
	-fr mv one or more files to the rmtrash recycle bin  
	-rf mv one or more files to the rmtrash recycle bin  
	-R  Restore selected files to the originalpath from rmtrash recycle bin  
	-l  list the contens of rmtrash recycle bin  
	-i  show detailed log of the deleted file history  
	-d  delete one or more files by user's input file name from the trash  
	-e  empty the rmtrash recycle bin  
	-h  display this help menu  

## 功能说明  

### 彻底删除文件  
```
# rm -e 清空回收站  
# /bin/rm file 直接删除文件而不经过回收站  
```
