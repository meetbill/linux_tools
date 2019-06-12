# 简介
<!-- vim-markdown-toc GFM -->

* [使用方法举例](#使用方法举例)
    * [导入 log](#导入-log)
    * [logXXX 语句](#logxxx-语句)
    * [设置日志级别](#设置日志级别)
    * [throw 语句](#throw-语句)
    * [myEcho 与 myEchoError 语句](#myecho-与-myechoerror-语句)
    * [日志路径与日志文件滚动](#日志路径与日志文件滚动)

<!-- vim-markdown-toc -->

通过简单的封装，这个小 shell 可以提供诸如：

> * 1. logInfo，logDebug 等多级别日志输出
> * 2. 日志记录带有时间戳和日志级别
> * 3. 将日志输出到指定文件
> * 4. 日志文件按日期进行归档
> * 5. 抛出异常

您通过下面的语句，：

```
logInfo hello, world
logDebug "hello, world" # 推荐将所有的内容用双引号包围
```
输出内容举例如下：

```
2015-08-26 20:12:21 [test.sh] (INFO) hello, world
2015-08-26 20:12:21 [test.sh] (DEBUG) hello, world
```

# 使用方法举例
## 导入 log
在您的 shell 开头导入即可，可以参考 /test/test.sh 的中的用法：

```
source ./b_lib/log.sh
```

## logXXX 语句
log 提供了四个日志级别的方法，他们分别是

1. `logDebug`
2. `logInfo`
3. `logWarn`
4. `logError`

用法很简单，所有的参数都会被当做日志内容记录，比如：

```
logInfo hello, world
logDebug "hello, world" # 推荐将所有的内容用双引号包围
```
输出内容举例如下：

```
2015-08-26 20:03:18 [test.sh] (INFO) hello, this logInfo
2015-08-26 20:12:21 [test.sh] (DEBUG) hello, logDebug
2015-08-26 20:12:21 [test.sh] (INFO) hello, logInfo
2015-08-26 20:12:21 [test.sh] (WARN) hello, logWarn
2015-08-26 20:12:21 [test.sh] (ERROR) hello, logError
2015-08-26 20:12:21 [test.sh] (ECHO) hello, myEcho
2015-08-26 20:12:21 [test.sh] (ECHO_ERROR) hello, myEchoError
2015-08-26 20:13:26 [test.sh] (DEBUG) hello, logDebug
```

## 设置日志级别
log 支持 6 个日志级别，含义与 Apache 日志框架类似：

> * 1. ALL
> * 2. DEBUG
> * 3. INFO
> * 4. WARN
> * 5. ERROR
> * 6. OFF

如果要设置指定的日志级别，请在导入 log 之后，export 变量`LOG_LEVEL`，可设置为如下预置常量：

```
LOG_LEVEL_ALL
LOG_LEVEL_DEBUG
LOG_LEVEL_INFO
LOG_LEVEL_WARN
LOG_LEVEL_ERROR
LOG_LEVEL_OFF
```

## throw 语句
`throw`语句类似 java 语言中抛异常。通过使用`throw`语句，达到类似抛异常的效果。比如：

```
throw "ParamsNumberException: need 2 params"
```
使用 throw 语句，程序将在 stderr 输出上述语句，同时在日志文件以 LOG_LEVEL_ERROR 级别记录。最后程序会意退出码 1 退出。

## myEcho 与 myEchoError 语句
`myEcho`和`myEchoError`与 shell 的`echo`语句类似，但有两点增强：
1. `myEcho`和`myEchoError`不仅会输出到控制台，还会输出到日志文件。
2. `myEchoError`的输出是 stdErr

## 日志路径与日志文件滚动
默认程序的输出日志路径是`/tmp/slog`，并在此目录下面生成已当前日期命名的日志文件，类似如下：

```
-rw-r--r--  1 maoshuai  wheel  1839  8 25 23:48 log_20150825.log
-rw-r--r--  1 maoshuai  wheel  1839  8 26 20:32 log_20150826.log
```
当然，你可以通过 export 变量`SIMPLE_LOG_DIR`指定你的日志路径，替换上述默认值。比如：`export SIMPLE_LOG_DIR=/var/log`，则所有日志都打印到`/var/log`目录下面
