## 使用 truncate 安全地删除大文件
> 代码
```
#!/bin/bash

###每次递减10G进行删除###
# 假设文件有 200G 以上
for i in `seq 200 -10 10`
do
   echo "truncate $i G......"
   truncate -s ${i}G /data/aaa.log
   sleep 3
done
```
> 注意：
```
truncate必须是文件，不能对目录做truncate操作
```
> 参数
```
-s
KB 1000, K 1024, MB 1000*1000, M 1024*1024, and so on for G, T, P, E, Z, Y.
```
