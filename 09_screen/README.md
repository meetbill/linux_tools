# 开启screen 状态栏

* [适用系统](#适用系统)
* [使用说明](#使用说明)
	* [安装](#安装)
	* [screen 使用](#screen-使用)

## 适用系统

> * Linux

## 使用说明  

### 安装

```
#curl -o screen.sh https://raw.githubusercontent.com/BillWang139967/linux_tools/master/09_screen/screen.sh
#bash screen.sh
```
### screen 使用 

> * C-a c      创建一个新的运行shell的窗口并切换到该窗口
> * C-a C-a    切换到之前显示的窗口
> * C-a n      切换到下一个窗口
> * C-a p      切换到前一个窗口
> * C-a d      断开所有 screen 终端，返回 screen 执行前状态，但 screen 内所有终端的任务都在执行
