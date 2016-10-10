

- Vapor 是一个使用`Swift`开发的`服务器网络框架`，它可以运行在`macOS`和`Ubuntu`上面，[官网](http://vapor.codes)

> 环境搭建

- 首先系统的Swift版本必须升级到3.0, 可以使用命令查看

```shell
swift --version
```

- 安装Vapor工具箱,使用`Homebrew`安装

```shell
brew install vapor/tap/toolbox
```

- 安装好后 输入 vapor 回车 会看到相应的提示

### Install MySQL

> macOS

```shell
brew install mysql
brew link mysql
mysql.server start
```

> Linux

```shell
sudo apt-get update
sudo apt-get install -y mysql-server libmysqlclient-dev
sudo mysql_install_db
sudo service mysql start
```

#### MySQL Script

```shell
source <project path>/Script/weather_mysql_script.sql
```

- 打开 `DBConfig.swift`将 USER PWD 改为你自己的 

> 如何运行本工程

- 打开`terminal` 进入到工程根目录
- 修改脚本 执行权限

```shell
chmod +x ./run.sh
```

- 运行

```shell
./run.sh run
```

- 启动成功后 可以打开浏览器 访问 API

```http
// 注册 userNmae pwd 必填
http://118.178.90.225/v1/registered.json

// 登录 userNmae pwd 必填 登录成功 返回 token 后续每个接口都要带上
http://118.178.90.225/v1/login.json

// 城市列表
http://118.178.90.225/v1/cityList.json 

// 根据城市 查询 具体天气
// 需要参数 city 城市 必填 province 省份 可填
http://118.178.90.225/v1/query.json

// 查询天气 类型
http://118.178.90.225/v1/type.json

```



