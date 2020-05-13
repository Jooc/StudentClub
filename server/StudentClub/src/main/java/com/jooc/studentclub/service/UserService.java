package com.jooc.studentclub.service;

import com.jooc.studentclub.mapper.UserMapper;
import com.jooc.studentclub.model.ClubInfoModel;
import com.jooc.studentclub.model.UserInfoModel;
import com.jooc.studentclub.model.UserModel;
import com.jooc.studentclub.service.interfaces.UserServiceInterface;


import com.jooc.studentclub.utils.Common;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;

@Service
public class UserService implements UserServiceInterface {

    @Autowired
    public UserMapper userMapper;

    public Object getUserById(int id){
        UserModel userModel = userMapper.getUserById(id);
        return packUser(userModel);
    }

    public Object getUserInfoById(int id){
        HashMap<String, Object> res = new HashMap<>();

        UserInfoModel userInfoModel = userMapper.getUserInfoById(id);
        if (userInfoModel == null){
            res.put("code", -1);
            res.put("msg", "用户不存在");
            res.put("userInfo", null);
        }else{
            res.put("code", 0);
            res.put("msg", "查询成功");
            res.put("userInfo", userInfoModel);
        }
        return res;
    }

    public Object getIdByEmail(String email){
        return userMapper.getIdByEmail(email);
    }

    public HashMap<String, Object> register(HashMap<String, Object> req){
        HashMap<String, Object> res = new HashMap<>();

        try{
            //TODO: Set unique id
            int id = 75148;

            String login_email = (String) req.get("login_email");
            String emailDuplicationCheck = userMapper.getPassword(login_email);
            if (emailDuplicationCheck != null){
                res.put("code", -1);
                res.put("msg", "邮箱已被注册");
                return res;
            }
            String password = (String) req.get("password");

            String user_name = (String) req.get("user_name");
            String gender = "undefined";

            //TODO: get club_info by register code
            ClubInfoModel clubInfoModel = new ClubInfoModel();
            int club_code = clubInfoModel.club_code;
            String club_name = clubInfoModel.club_name;
            String club_avatar = clubInfoModel.club_avatar;

            //TODO: get privilege Code by register code
            int privilege = Common.level0;

            userMapper.insertUser(id, user_name, club_code, club_name, club_avatar, privilege, login_email, password);
            res.put("user", userMapper.getUserById(id));
            res.put("code", 0);
            res.put("msg", "注册成功");
        }catch (Exception e){
            e.printStackTrace();
            res.put("code", 1);
            res.put("msg", "注册失败");
        }

        return res;
    }

    public HashMap<String, Object> login(HashMap<String, Object> req){
        HashMap<String, Object> res = new HashMap<>();

        String email = (String) req.get("email");
        String password = (String) req.get("password");
        String securePassword = userMapper.getPassword(email);

        if (securePassword == null){
            res.put("code", -1);
            res.put("msg", "用户不存在");
            return res;
        }

        if (password.equals(securePassword)){
            int id = userMapper.getIdByEmail(email);

            res.put("code", 0);
            res.put("msg", "登陆成功");
            res.put("user", getUserById(id));
        }else{
            res.put("code", 1);
            res.put("msg", "密码错误");
        }
        return res;
    }

    public static HashMap<String, Object> packUser(UserModel userModel){
        HashMap<String, Object> user = new HashMap<>();
        HashMap<String, Object> club = new HashMap<>();

        club.put("clubCode", userModel.club_code);
        club.put("clubName", userModel.club_name);
        club.put("clubAvatar", userModel.club_avatar);

        user.put("id", userModel.id);
        user.put("userName", userModel.user_name);
        user.put("avatar", userModel.avatar);
        user.put("gender", userModel.gender);
        user.put("description", userModel.description);
        user.put("clubInfo", club);
        user.put("userPrivilege", userModel.privilege);
        user.put("loginEmail", userModel.login_email);
        user.put("password", "***");
        user.put("contactEmail", userModel.contact_email);
        user.put("phoneNumber", userModel.phone_number);

        return user;
    }

}