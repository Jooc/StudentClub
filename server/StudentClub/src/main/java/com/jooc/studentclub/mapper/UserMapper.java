package com.jooc.studentclub.mapper;

import com.jooc.studentclub.model.UserInfoModel;
import com.jooc.studentclub.model.UserModel;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface UserMapper {
    @Select("select password from user where login_email=#{email}")
    String getPassword(String email);

    @Select("select id, User.name, User.avatar, gender, User.description, club_code, Club.name as club_name, Club.icon as club_avatar, privilege, login_email, password, contact_email, phone_number " +
            "from User join Club on (User.club_code=Club.code) where id=#{id}")
    UserModel getUserById(int id);

    @Select("select id from user where login_email=#{email}")
    int getIdByEmail(String email);

    @Insert({"insert into user(id, name, club_code, club_name, club_avatar, privilege, login_email, password)" +
            "values(#{id}, #{name}, #{club_code}, #{club_name}, #{club_avatar}, #{privilege}, #{login_email}, #{password})"})
    void insertUser(@Param("id") int id,
                    @Param("name") String user_name,
                    @Param("club_code") int club_code,
                    @Param("club_name") String club_name,
                    @Param("club_avatar") String club_avatar,
                    @Param("privilege") int privilege,
                    @Param("login_email") String login_email,
                    @Param("password") String password);

    @Select("select id,name,avatar from user where id=#{id}")
    UserInfoModel getUserInfoById(int id);


    @Select("select club_code from User where id=#{id}")
    int getClubCodeByUserId(int user_id);
}