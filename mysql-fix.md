# MySQL installation notes


### Link in case MySQL doesn't work properly with Passenger

```
sudo install_name_tool -change libmysqlclient.18.dylib /usr/local/mysql/lib/libmysqlclient.18.dylib /usr/local/lib/ruby/gems/1.9.1/gems/mysql2-0.2.7/lib/mysql2/mysql2.bundle
```
