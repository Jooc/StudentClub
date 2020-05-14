package com.jooc.studentclub.model;

import com.jooc.studentclub.mapper.UserMapper;
import com.jooc.studentclub.model.DBModel.DBClubModel;
import com.mysql.cj.xdevapi.JsonArray;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.ArrayList;

public class ClubModel {

    @Autowired
    private UserMapper userMapper;

    public int code;
    public String name;
    public String icon;
    public String description;

    public UserInfoModel advisor;
    public UserInfoModel manager;
    public ArrayList<UserInfoModel> members;


    public ClubModel(DBClubModel db, UserInfoModel advisor, UserInfoModel manager, ArrayList<UserInfoModel> members){
        this.code = db.code;
        this.name = db.name;
        this.icon = db.icon;
        this.description = db.description;

        this.advisor = advisor;
        this.manager = manager;

        // 一般成员，不包括指导老师和俱乐部主席
        this.members = members;
    }


    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public UserInfoModel getAdvisor() {
        return advisor;
    }

    public void setAdvisor(UserInfoModel advisor) {
        this.advisor = advisor;
    }

    public UserInfoModel getManager() {
        return manager;
    }

    public void setManager(UserInfoModel manager) {
        this.manager = manager;
    }

    public ArrayList<UserInfoModel> getMembers() {
        return members;
    }

    public void setMembers(ArrayList<UserInfoModel> members) {
        this.members = members;
    }
}
