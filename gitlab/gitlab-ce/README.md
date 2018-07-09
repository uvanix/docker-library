## gitlab 配置

### 修改默认root密码
参考：[重置密码](https://docs.gitlab.com/ce/security/reset_root_password.html)
进入容器，修改密码，重启容器
```
#> docker exec -it gitlab /bin/bash
#> gitlab-rails console production
#> user = User.where(id: 1).first
#> user.password = 'secret_pass'
#> user.password_confirmation = 'secret_pass'
#> user.save!
```

### GitLab基本配置
GitLab 的相关参数配置都存在 /etc/gitlab/gitlab.rb 文件里。自 GitLab 7.6 开始的新安装包, 已经默认将所有的参数写入到 /etc/gitlab/gitlab.rb 配置文件中。
1. 配置端口
GitLab 默认使用 80 端口对外提供服务，因为 80 端口被其他服务占用，所以需要更改。打开 /etc/gitlab/gitlab.rb 配置文件，修改 external_url 'http://ip_address' 为 external_url 'http://ip_address:new-port'。
重新编译配置：
```
#> gitlab-ctl reconfigure
```
2. 邮箱配置
以下是 163 邮箱的配置参考，打开　/etc/gitlab/gitlab.rb 配置文件，添加以下内容并重新编译
```
gitlab_rails['smtp_enable'] = true
gitlab_rails['smtp_address'] = "smtp.163.com"
gitlab_rails['smtp_port'] = 25
gitlab_rails['smtp_user_name'] = "test@163.com"
gitlab_rails['smtp_password'] = "password"
gitlab_rails['smtp_authentication'] = "login"
gitlab_rails['smtp_enable_starttls_auto'] = true
gitlab_rails['gitlab_email_from'] = "test@163.com"
```
3. 头像配置
GitLab 默认使用的是 Gravatar 头像服务，不过现在貌似 Gravatar 国内好像访问不了，导致 GitLab 默认头像破裂，无法显示，可以替换为多说 Gravatar 服务器。打开 /etc/gitlab/gitlab.rb 配置文件，增加下面这一行：
```
gitlab_rails['gravatar_plain_url'] = 'http://gravatar.duoshuo.com/avatar/%{hash}?s=%{size}&d=identicon'
```
再分别执行以下命令即可
```
#> gitlab-ctl reconfigure
#> gitlab-rake cache:clear RAILS_ENV=production
```
也可以关闭 Gravatar 头像显示配置，登录 GitLab 管理员账户，进入设置界面（路径地址：http://ip:port/admin/application_settings ），取消Gravatar enabled选项即可。
4. 用户注册配置
管理员设置界面（路径地址：http://ip:port/admin/application_settings ）以下选项可以控制用户注册配置，包括是否允许登录、注册和注册邮箱验证等选项。
5. 常用命令
GitLab 服务启动、停止、状态查询、修改配置生效等命令：
```
#> gitlab-ctl start/stop/status/reconfigure  # 服务启动、停止、状态查询、修改配置生效
```
也可以查看帮助文档获取更多命令信息：
```
#> gitlab-ctl --help
```
