

- Vapor 是一个使用`Swift`开发的`服务器网络框架`，它可以运行在`macOS`和`Ubuntu`上面，[官网](http://vapor.codes)

> 环境搭建

- 首先系统的Swift版本必须升级到3.0, 可以使用命令查看

```shell
swift --version
```

- 安装Vapor工具箱,使用`Homebrew`安装 MacOS  Ubuntu 下载源码安装

```shell
brew install vapor/tap/toolbox
```

- 安装好后 输入 vapor 回车 会看到相应的提示


- ### Install MySQL

  > macOS

  ```scss
  brew install mysql
  brew link mysql
  mysql.server start
  ```

  > Linux 下面命令默认安装MySQL5.5 

  ```scss
  sudo apt-get update
  sudo apt-get install -y mysql-server libmysqlclient-dev
  sudo mysql_install_db
  sudo service mysql start
  ```

  > 安装5.6以上

  ```scss
   // 在官网获取MySQL的APT仓库 如果报错 请执行 sudo apt-get install wget
   wget http://repo.mysql.com//mysql-apt-config_0.6.0-1_all.deb
   
   // 安装
   dpkg -i mysql-apt-config_0.6.0-1_all.deb

   // 回车后出现如下界面：选择最新版本5.7
   // 选择5.7后，选择apply
   
   // 更新下apt-get update
   // 移除原先安装mysql 
   apt-get remove mysql-server
   apt-get remove mysql-client
   apt-get autoremove
   
   // 安装新的
   sudo apt-get install mysql-server

  // OK，5.7版本的mysql安装成功！
  // 在安装下面的 不然可能会出现 MySQL头文件找不到
  apt-get install libmysqlclient-dev 

  /**
  常用命令：
   一）、启动
   1、使用 service 启动：service mysql start
   2、使用 mysqld 脚本启动：/etc/inint.d/mysqlstart
   3、使用 safe_mysqld 启动：safe_mysql&
   二）、停止
   1、使用 service 启动：service mysqlstop
   2、使用 mysqld 脚本启动：/etc/inint.d/mysqlstop
   3、mysqladmin shutdown 
   三）、重启
   1、使用 service 启动：service mysqlrestart
   2、使用 mysqld 脚本启动：/etc/inint.d/mysqlrestart
   
   */
  ```

  ### MySQL Script

  ```scss
  source <project path>/Script/weather_mysql_script.sql
  ```

  - 打开 `DBConfig.swift`将 USER PWD 改为你自己的 

  > 如何运行本工程

  - 打开`terminal` 进入到工程根目录

  ```scss
  vapor builb // 编译
  vapor run  // 运行
  vapor run --env=development // 运行开发环境
  vapor run --env=production // 运行发布环境
  ```

  - 启动成功后 可以打开浏览器 访问 API

  ```scss
  // 注册 userNmae pwd 必填
  http://59.110.6.8/v1/registered.json

  // 登录 userNmae pwd 必填 登录成功 返回 token 后续每个接口都要带上
  http://59.110.6.8/v1/login.json

  // 城市列表
  http://59.110.6.8/v1/citylist.json

  // 根据城市 查询 具体天气
  // 需要参数 city 城市 必填 province 省份 可填
  http://59.110.6.8/v1/query.json

  // 查询天气 类型
  http://59.110.6.8/v1/type.json
  ```

