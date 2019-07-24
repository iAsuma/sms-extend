#!/bin/bash
echo '拷贝源文件至tp extend目录'
cp -r sms-extend/aliyun extend/
cp sms-extend/README.md extend/aliyun/sms.md
echo '删除源文件'
rm -r sms-extend/
echo '执行成功'