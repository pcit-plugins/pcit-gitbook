# Changelog

### latest

* 改为基于 `Alpine Linux` 镜像
* 修改时区 `Asia/Shanghai`
* 一开始脚本出现问题，将源文件挂载到 `/tmp/gitbook` 没有 `node_modules` 而出错，将 CMD 改为执行脚本( `docker-entrypoint.sh` )，完成 `node_modules` 复制。

#### 插件列表

* "prism"
* "tbfed-pagefooter@git+https://github.com/khs1994/gitbook-plugin-tbfed-pagefooter.git"


### 1.0.0

* 基于 v0.0.1 修改，增加了插件的数量

#### 插件列表

* "-sharing"
* "-highlight"
* "-livereload"
* "toggle-chapters"
* "tbfed-pagefooter@git+https://github.com/khs1994/gitbook-plugin-tbfed-pagefooter.git"
* "prism"
* "anchor-navigation-ex"
* "favicon"
* "expandable-chapters"
