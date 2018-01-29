## 挂载文件

> * 创建文件(truncate 可以将文件缩减或者扩展为指定大小，若文件不存在则创建)
>    * truncate -s size file_path 
> * 挂载文件
>    * mount -o loop 文件 挂载目录
