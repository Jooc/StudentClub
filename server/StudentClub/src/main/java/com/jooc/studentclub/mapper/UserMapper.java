package com.jooc.studentclub.mapper;

import com.jooc.studentclub.model.UserInfoModel;
import com.jooc.studentclub.model.DBModel.DBUserModel;
import org.apache.ibatis.annotations.*;

@Mapper
public interface UserMapper {
    @Select("select password from user where login_email=#{email}")
    String getPassword(String email);

    @Select("select id, User.name, User.avatar, gender, User.description, club_code, Club.name as club_name, Club.icon as club_avatar, privilege, login_email, password, contact_email, phone_number " +
            "from User join Club on (User.club_code=Club.code) where id=#{id}")
    DBUserModel getUserById(int id);

    @Select("select id from user where login_email=#{email}")
    int getIdByEmail(String email);

    @Select("select max(id) from User")
    int getMaxId();

    @Insert({"insert into user(id, name, avatar, gender, description, club_code, privilege, login_email, password, contact_email, phone_number)" +
            "values(#{id}, #{name}, #{avatar}, #{gender}, #{description}, #{club_code}, #{privilege}, #{login_email}, #{password}, #{contact_email}, #{phone_number})"})
    void insertUser(@Param("id") int id,
                    @Param("name") String name,
                    @Param("avatar") String avatar,
                    @Param("gender") String gender,
                    @Param("description") String description,
                    @Param("club_code") int club_code,
                    @Param("privilege") int privilege,
                    @Param("login_email") String login_email,
                    @Param("password") String password,
                    @Param("contact_email") String contact_email,
                    @Param("phone_number") String phone_number);

    @Select("select id,name,avatar,privilege from user where id=#{id}")
    UserInfoModel getUserInfoById(int id);

    @Select("select club_code from User where id=#{id}")
    int getClubCodeByUserId(int user_id);

    @Update("update User set name=#{newName} where id=#{id};")
    void updateUserName(int id, String newName);

    @Update("update User set gender=#{newGender} where id=#{id}")
    void updateGender(int id, String newGender);

    @Update("update User set phone_number=#{newPhoneNumber} where id=#{id}")
    void updatePhoneNumber(int id, String newPhoneNumber);

    @Update("update User set contact_email=#{newContactEmail} where id=#{id}")
    void updateContactEmail(int id, String newContactEmail);

}