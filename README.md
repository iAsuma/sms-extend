1. composer.json
~~~
"autoload": {
    "classmap":[
        "extend/aliyun"
    ]
},
~~~

2. config
~~~
//阿里云短信服务
'alisms_key' => '',
'alisms_secret' => '',
'alisms_snscode' => '',
'alisms_sign' => '',
~~~

3. function
~~~
/**
*	发送验证码
*/
public function sendMsgCode(Request $request)
{
	$phone = $request->post('phone');
	empty($phone) && exit(res_json_str('-1', '手机号不能为空'));

	try {
		$msg = rand(100000, 999999);
		$data = array(
            'keyId' => Config::get('this.alisms_key'),
            'keySecret' => Config::get('this.alisms_secret'),
            'phone' => $phone,
            'sign' => Config::get('this.alisms_sign'),
            'snscode' => Config::get('this.alisms_snscode')
        );
    	$alisms = AliSms::sendSms($data, ['code' => $msg]);	
	} catch (Exception $e) {
		exit(res_json_str('-2', '发送失败'));
	}

	if($alisms->Code == "OK"){
		Redis::set('loginCode_'.$phone, $msg, 290);
		exit(res_json_str('100', $alisms->Code));
	}

	exit(res_json_str('101', $alisms->Code));
}
~~~
