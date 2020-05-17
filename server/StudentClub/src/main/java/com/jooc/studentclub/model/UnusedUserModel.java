//package com.jooc.studentclub.model.DBModel;
//
//import com.jooc.studentclub.model.ClubInfoModel;
//
//public class UserModel {
//    public int id;
//    public String name;
//    public String avatar;
//    public String gender;
//    public String description;
//
//    public ClubInfoModel clubInfo;
//
//    public int privilege;
//    public String login_email;
//    public String password;
//    public String contact_email;
//    public String phone_number;
//
//    UserModel(DBUserModel db){
//        this.id = db.id;
//        this.name = db.name;
//        this.avatar = db.avatar;
//        this.gender = db.gender;
//        this.description = db.description;
//        this.clubInfo = new ClubInfoModel(db.club_code, db.club_name, db.club_avatar);
//        this.privilege = db.privilege;
//        this.login_email = db.login_email;
//        this.password = db.password;
//        this.contact_email = db.contact_email;
//        this.phone_number = db.phone_number;
//    }
//
//    public int getId() {
//        return id;
//    }
//
//    public void setId(int id) {
//        this.id = id;
//    }
//
//    public String getName() {
//        return name;
//    }
//
//    public void setName(String name) {
//        this.name = name;
//    }
//
//    public String getAvatar() {
//        return avatar;
//    }
//
//    public void setAvatar(String avatar) {
//        this.avatar = avatar;
//    }
//
//    public String getGender() {
//        return gender;
//    }
//
//    public void setGender(String gender) {
//        this.gender = gender;
//    }
//
//    public String getDescription() {
//        return description;
//    }
//
//    public void setDescription(String description) {
//        this.description = description;
//    }
//
//    public int getPrivilege() {
//        return privilege;
//    }
//
//    public void setPrivilege(int privilege) {
//        this.privilege = privilege;
//    }
//
//    public String getLogin_email() {
//        return login_email;
//    }
//
//    public void setLogin_email(String login_email) {
//        this.login_email = login_email;
//    }
//
//    public String getPassword() {
//        return password;
//    }
//
//    public void setPassword(String password) {
//        this.password = password;
//    }
//
//    public String getContact_email() {
//        return contact_email;
//    }
//
//    public void setContact_email(String contact_email) {
//        this.contact_email = contact_email;
//    }
//
//    public String getPhone_number() {
//        return phone_number;
//    }
//
//    public void setPhone_number(String phone_number) {
//        this.phone_number = phone_number;
//    }
//}
