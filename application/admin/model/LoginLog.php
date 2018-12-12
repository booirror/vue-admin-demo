<?php

namespace app\admin\model;

use \think\Model;
use \think\Db;

/**
 * 管理员登陆日志
 */
class LoginLog extends Model
{
    /** 添加日志
     * @param $data
     */
    public function add($data)
    {
        return Db::name('login_log')->insertGetId($data);
    }


}
