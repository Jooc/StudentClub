package com.jooc.studentclub.model.DBModel;

import com.mysql.cj.xdevapi.JsonArray;

public class DBClubModel {

    public int code;
    public String name;
    public String icon;
    public String description;

    public int advisor_id;
    public int manager_id;

    public String members_id;

    public DBClubModel(int code, String name, String icon, String description, int advisor_id, int manager_id, String members_id) {
        this.code = code;
        this.name = name;
        this.icon = icon;
        this.description = description;
        this.advisor_id = advisor_id;
        this.manager_id = manager_id;
        this.members_id = members_id;
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

    public int getAdvisor_id() {
        return advisor_id;
    }

    public void setAdvisor_id(int advisor_id) {
        this.advisor_id = advisor_id;
    }

    public int getManager_id() {
        return manager_id;
    }

    public void setManager_id(int manager_id) {
        this.manager_id = manager_id;
    }

    public String getMembers_id() {
        return members_id;
    }

    public void setMembers_id(String members_id) {
        this.members_id = members_id;
    }
}
