package com.jooc.studentclub.service;

import com.alibaba.fastjson.JSONArray;
import com.jooc.studentclub.mapper.ClubMapper;
import com.jooc.studentclub.mapper.UserMapper;
import com.jooc.studentclub.model.DBModel.DBClubModel;
import com.jooc.studentclub.model.UserInfoModel;
import com.jooc.studentclub.model.DBModel.DBUserModel;
import com.jooc.studentclub.service.interfaces.UserServiceInterface;


import com.jooc.studentclub.utils.Common;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;

@Service
public class UserService implements UserServiceInterface {

    @Autowired
    private UserMapper userMapper;
    @Autowired
    private ClubMapper clubMapper;

    public Object getUserById(int id){
        DBUserModel DBUserModel = userMapper.getUserById(id);
        return packUser(DBUserModel);
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
            int id = userMapper.getMaxId()+1;

            String login_email = (String) req.get("login_email");
            String emailDuplicationCheck = userMapper.getPassword(login_email);
            if (emailDuplicationCheck != null){
                res.put("code", -1);
                res.put("msg", "邮箱已被注册");
                return res;
            }
            String password = (String) req.get("password");

            String user_name = (String) req.get("name");
            String avatar = "/UserAvatar/defaultAvatar.png";
            String gender = "undefined";
            String description = "";

            //TODO: get club_info by register code
            String registerCode = (String) req.get("registerCode");
            int clubCode = Integer.parseInt(clubMapper.getClubCodeByRegisterCode(registerCode));

            // 从这个入口注册的都是普通成员
            int privilege = Common.level1;
            String contact_email = "";
            String phone_number = "";

            userMapper.insertUser(id, user_name, avatar, gender, description, clubCode, privilege, login_email, password, contact_email, phone_number);

            DBClubModel db = clubMapper.getByCode(clubCode);
            JSONArray membersArray = JSONArray.parseArray(db.members_id);
            membersArray.add(id);
            String newMembers = JSONArray.toJSONString(membersArray);
            clubMapper.updateMembers(newMembers, clubCode);

            res.put("user", getUserById(id));
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

    @Override
    public Object editUserName(HashMap<String, Object> req) {
        HashMap<String, Object> res = new HashMap<>();

        int id = Integer.parseInt(req.get("id").toString());
        String newName = (String) req.get("newName");

        try{
            userMapper.updateUserName(id, newName);
            res.put("code", 0);
            res.put("msg", "成功");
            res.put("user", getUserById(id));
        }catch (Exception e){
            res.put("code", -1);
            res.put("msg", "更新数据失败");
        }
        return res;
    }

    @Override
    public Object editGender(HashMap<String, Object> req) {
        HashMap<String, Object> res = new HashMap<>();

        int id = Integer.parseInt(req.get("id").toString());
        String newGender = (String) req.get("newGender");

        try{
            userMapper.updateGender(id, newGender);
            res.put("code", 0);
            res.put("msg", "成功");
            res.put("user", getUserById(id));
        }catch (Exception e){
            res.put("code", -1);
            res.put("msg", "更新数据失败");
        }
        return res;
    }

    @Override
    public Object editPhoneNumber(HashMap<String, Object> req) {
        HashMap<String, Object> res = new HashMap<>();

        int id = Integer.parseInt(req.get("id").toString());
        String newPhoneNumber = (String) req.get("newPhoneNumber");

        try{
            userMapper.updatePhoneNumber(id, newPhoneNumber);
            res.put("code", 0);
            res.put("msg", "成功");
            res.put("user", getUserById(id));
        }catch (Exception e){
            res.put("code", -1);
            res.put("msg", "更新数据失败");
        }
        return res;
    }

    @Override
    public Object editContactEmail(HashMap<String, Object> req) {
        HashMap<String, Object> res = new HashMap<>();

        int id = Integer.parseInt(req.get("id").toString());
        String newContactEmail = (String) req.get("newContactEmail");

        try{
            userMapper.updateContactEmail(id, newContactEmail);
            res.put("code", 0);
            res.put("msg", "成功");
            res.put("user", getUserById(id));
        }catch (Exception e){
            res.put("code", -1);
            res.put("msg", "更新数据失败");
        }
        return res;
    }


    public static HashMap<String, Object> packUser(DBUserModel DBUserModel){
        HashMap<String, Object> user = new HashMap<>();
        HashMap<String, Object> club = new HashMap<>();

        club.put("clubCode", DBUserModel.club_code);
        club.put("clubName", DBUserModel.club_name);
        club.put("clubAvatar", DBUserModel.club_avatar);

        user.put("id", DBUserModel.id);
        user.put("name", DBUserModel.name);
        user.put("avatar", DBUserModel.avatar);
        user.put("gender", DBUserModel.gender);
        user.put("description", DBUserModel.description);
        user.put("clubInfo", club);
        user.put("userPrivilege", DBUserModel.privilege);
        user.put("loginEmail", DBUserModel.login_email);
        user.put("password", "***");
        user.put("contactEmail", DBUserModel.contact_email);
        user.put("phoneNumber", DBUserModel.phone_number);

        return user;
    }

}