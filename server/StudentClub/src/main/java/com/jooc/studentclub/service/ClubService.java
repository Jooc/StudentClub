package com.jooc.studentclub.service;


import com.alibaba.fastjson.JSONArray;
import com.jooc.studentclub.mapper.ClubMapper;
import com.jooc.studentclub.mapper.UserMapper;
import com.jooc.studentclub.model.ClubModel;
import com.jooc.studentclub.model.DBModel.DBClubModel;
import com.jooc.studentclub.model.UserInfoModel;
import com.jooc.studentclub.service.interfaces.ClubServiceInterface;
import org.apache.http.annotation.Obsolete;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Random;

@Service
public class ClubService implements ClubServiceInterface {
    @Autowired
    private ClubMapper clubMapper;

    @Autowired
    private UserMapper userMapper;

    @Override
    public Object getAllClub(){
        HashMap<String, Object> res = new HashMap<>();
        try{
            List<DBClubModel> list = clubMapper.getAllClub();
            ArrayList<Object> clubList = new ArrayList<>();

            for (DBClubModel db: list){
                clubList.add(transfer(db));
            }
            res.put("code", 0);
            res.put("msg", "查询成功");
            res.put("clubs", clubList);
            return res;
        }catch (Exception e){
            res.put("code", -1);
            res.put("msg", "查询失败" + e);
            return res;
        }
    }

    @Override
    public Object getByCode(int code){
        HashMap<String, Object> res = new HashMap<>();
        try{
            ClubModel club = transfer(clubMapper.getByCode(code));
            res.put("code", 0);
            res.put("msg", "查询成功");
            res.put("club", club);
            return res;
        }catch (Exception e){
            res.put("code", -1);
            res.put("msg", "无 " + e);
            return res;
        }
    }

    @Override
    public Object getClubByRegisterCode(String registerCode){
        HashMap<String, Object> res = new HashMap<>();
        try{
            int clubCode = Integer.parseInt(clubMapper.getClubCodeByRegisterCode(registerCode));
            return getByCode(clubCode);
        }catch (Exception e){
            res.put("code", -1);
            res.put("msg", "注册码无效");
            return res;
        }
    }

    @Override
    public Object getRegisterCodeByClubCode(int clubCode){
        HashMap<String, Object> res = new HashMap<>();
        try{
            String registerCode = clubMapper.getRegisterCodeByClubCode(clubCode);
            res.put("code", 0);
            res.put("msg", "查询成功");
            res.put("registerCode", registerCode);
        }catch (Exception e){
            res.put("code", -1);
            res.put("msg", "错误 " + e);
        }
        return res;
    }

    @Override
    public Object getClubNameByRegisterCode(String registerCode){
        HashMap<String, Object> res = new HashMap<>();
        String clubCode = clubMapper.getClubCodeByRegisterCode(registerCode);

        if (clubCode==null){
            res.put("code", -1);
            res.put("msg", "无结果");
        }else{
            DBClubModel db = clubMapper.getByCode(Integer.parseInt(clubCode));
            res.put("code", 0);
            res.put("msg", "查询成功");
            res.put("clubName", db.name);
        }
        return res;
    }

    @Override
    public Object add(HashMap<String, Object> req) {
        HashMap<String, Object> res = new HashMap<>();

        String name = (String)req.get("clubName");
        String clubDuplicationCheck = clubMapper.getClubCodeByName(name);
        if (clubDuplicationCheck!=null){
            res.put("code", -1);
            res.put("msg", "俱乐部已存在");
            return res;
        }

        try {
            // TODO: generate Club code
            int code = Integer.parseInt(req.get("code").toString());

            String icon = (String) req.get("icon");
            String description = (String) req.get("description");
            int advisor_id = Integer.parseInt(req.get("advisor_id").toString());
            int manager_id = Integer.parseInt(req.get("manager_id").toString());

            // 暂不在App端内部开通添加俱乐部功能，因此暂不设成员id整合步骤
            String members_id = req.get("members_id").toString();

            DBClubModel db = new DBClubModel(code, name, icon, description, advisor_id, manager_id, members_id);
            clubMapper.insert(db);

            String registerCode = generateRandomCode();
            clubMapper.insertRegisterCode(code, registerCode);

            res.put("code", 0);
            res.put("msg", "添加成功");
            res.put("club", transfer(clubMapper.getByCode(code)));
            res.put("registerCode", clubMapper.getRegisterCodeByClubCode(code));
            return res;
        }catch (Exception e){
            res.put("code", -1);
            res.put("msg", "添加失败" + e);
            return res;
        }
    }

    @Override
    public Object remove(HashMap<String, Object> req) {
        HashMap<String, Object> res = new HashMap<>();

        int clubCode = Integer.parseInt(req.get("code").toString());
        DBClubModel db = clubMapper.getByCode(clubCode);
        if (db==null){
            res.put("code", -1);
            res.put("msg", "俱乐部不存在");
            return res;
        }
        try{
            clubMapper.delete(clubCode);
            clubMapper.deleteRegisterCodeByClubCode(clubCode);
            res.put("code", 0);
            res.put("msg", "删除成功");
        }catch (Exception e){
            res.put("code", -1);
            res.put("msg", "删除失败" + e);
        }
        return res;
    }

    @Override
    public Object editDescription(HashMap<String, Object> req) {
        HashMap<String, Object> res = new HashMap<>();

        try{
            String newDescription = (String)req.get("newDescription");
            int clubCode = Integer.parseInt(req.get("clubCode").toString());
            clubMapper.updateDescription(newDescription, clubCode);

            res.put("code", 0);
            res.put("msg", "修改成功");
            res.put("club", transfer(clubMapper.getByCode(clubCode)));
        }catch (Exception e){
            res.put("code", -1);
            res.put("msg", "未知错误" + e);
        }
        return res;
    }

    @Override
    public Object addMember(HashMap<String, Object> req) {
        HashMap<String, Object> res = new HashMap<>();

        try{
            int clubCode = Integer.parseInt(req.get("clubCode").toString());
            int newMemberId = Integer.parseInt(req.get("newMemberId").toString());

            DBClubModel db = clubMapper.getByCode(clubCode);

            JSONArray membersArray = JSONArray.parseArray(db.members_id);
            membersArray.add(newMemberId);
            String newMembers = JSONArray.toJSONString(membersArray);

            clubMapper.updateMembers(newMembers, clubCode);

            res.put("code", 0);
            res.put("msg", "添加成功");
            res.put("newMemberList", transfer(clubMapper.getByCode(clubCode)));
        }catch (Exception e){
            res.put("code", -1);
            res.put("msg", "添加失败" + e);
        }
        return res;
    }

    @Override
    public Object removeMember(HashMap<String, Object> req) {
        HashMap<String, Object> res = new HashMap<>();

        try{
            int clubCode = Integer.parseInt(req.get("clubCode").toString());
            int targetMemberId = Integer.parseInt(req.get("targetMemberId").toString());

            DBClubModel db = clubMapper.getByCode(clubCode);

            JSONArray membersArray = JSONArray.parseArray(db.members_id);
            membersArray.remove(targetMemberId);
            String membersAfterRemove = JSONArray.toJSONString(membersArray);

            clubMapper.updateMembers(membersAfterRemove, clubCode);

            res.put("code", 0);
            res.put("msg", "移除成功");
            res.put("newMemberList", transfer(clubMapper.getByCode(clubCode)));
        }catch (Exception e){
            res.put("code", -1);
            res.put("msg", "移除失败" + e);
        }
        return res;
    }

    @Override
    public Object setAdvisor(HashMap<String, Object> req) {
        HashMap<String, Object> res = new HashMap<>();
        try{
            int clubCode = Integer.parseInt(req.get("clubCode").toString());
            int newAdvisorID = Integer.parseInt(req.get("newAdvisorID").toString());

            clubMapper.updateAdvisor(newAdvisorID, clubCode);
            res.put("code", 0);
            res.put("msg", "修改成功");
            res.put("club", transfer(clubMapper.getByCode(clubCode)));
        }catch (Exception e){
            res.put("code", -1);
            res.put("msg", "修改失败");
        }
        return res;
    }

    @Override
    public Object setManager(HashMap<String, Object> req) {
        HashMap<String, Object> res = new HashMap<>();
        try{
            int clubCode = Integer.parseInt(req.get("clubCode").toString());
            int newManagerId = Integer.parseInt(req.get("newManagerId").toString());

            clubMapper.updateManager(newManagerId, clubCode);
            res.put("code", 0);
            res.put("msg", "修改成功");
            res.put("club", transfer(clubMapper.getByCode(clubCode)));
        }catch (Exception e){
            res.put("code", -1);
            res.put("msg", "修改失败");
        }
        return res;
    }

    @Override
    public Object resetRegisterCode(HashMap<String, Object> req){
        HashMap<String, Object> res = new HashMap<>();

        try{
            int clubCode = Integer.parseInt(req.get("clubCode").toString());
            String newResisterCode = generateRandomCode();
            clubMapper.updateRegisterCode(newResisterCode, clubCode);

            res.put("code", 0);
            res.put("msg", "重设成功");
            res.put("newRegisterCode", clubMapper.getRegisterCodeByClubCode(clubCode));
        }catch (Exception e){
            res.put("code", -1);
            res.put("msg", "重设异常");
        }
        return res;
    }


    private ClubModel transfer(DBClubModel db){
        UserInfoModel advisor = userMapper.getUserInfoById(db.advisor_id);
        UserInfoModel manager = userMapper.getUserInfoById(db.manager_id);

        String[] members_id_str = db.members_id.substring(1,db.members_id.length()-1).split(",");
        ArrayList<UserInfoModel> members = new ArrayList<>();

        if (members_id_str.length == 1&&members_id_str[0].equals("")) { }
        else {
            for (String str : members_id_str){
                members.add(userMapper.getUserInfoById(Integer.parseInt(str.trim())));
            }
        }

        return new ClubModel(db, advisor, manager, members);
    }

    private String generateRandomCode(){
        String str="ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        String str1;

        while (true) {
            Long trueRandomBeginIndex = System.currentTimeMillis() % 35;
            Random random1 = new Random(trueRandomBeginIndex);

            //指定字符串长度，拼接字符并toString
            StringBuffer sb = new StringBuffer();
            for (int i = 0; i < 10; i++) {
                int number = random1.nextInt(str.length());
                char charAt = str.charAt(number);
                sb.append(charAt);
            }

            str1 = sb.toString();
            String clubCode = clubMapper.getClubCodeByRegisterCode(str1);

            if (clubCode == null){
                break;
            }
        }

        return str1;
    }

}
