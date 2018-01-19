## trap_err

默认的 trap 处理，包括 trap ERR 是不继承到子 shell 里的

> * 子 shell
> * ssh 远程命令的状态

如果想要让 trap ERR 在子 shell 中生效，则需要在执行脚本的时候，使用 -E 参数执行脚本

即

`bash -E trap_err.sh`
