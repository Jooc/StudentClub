package com.jooc.studentclub.mapper;

import com.alibaba.fastjson.JSONArray;
import com.jooc.studentclub.model.DBModel.DBClubModel;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface ClubMapper {

    @Select("select * from Club")
    List<DBClubModel> getAllClub();

    @Select("select * from Club where code=#{code}")
    DBClubModel getByCode(int code);

    @Select("select code from Club where name=#{name}")
    String getClubCodeByName(String name);

    @Select("select register_code from RegisterCode where club_code=#{club_code};")
    String getRegisterCodeByClubCode(int club_code);

    @Select("select club_code from RegisterCode where register_code=#{register_code};")
    String getClubCodeByRegisterCode(String register_code);


    @Insert("insert into Club (code, name, icon, description, advisor_id, manager_id, members_id)" +
            " values(#{db.code}, #{db.name}, #{db.icon}, #{db.description}, #{db.advisor_id}, #{db.manager_id}, #{db.members_id});")
    void insert(@Param("db") DBClubModel db);

    @Insert("insert into RegisterCode (club_code, register_code) values(#{club_code}, #{register_code});")
    void insertRegisterCode(int club_code, String register_code);


    @Delete("delete from Club where code = #{code};")
    void delete(int code);

    @Delete("delete from RegisterCode where club_code = #{club_code};")
    void deleteRegisterCodeByClubCode(int club_code);


    @Update("update Club set description = #{description} where code = #{club_code};")
    void updateDescription(String description, int club_code);

    @Update("update Club set members_id = #{members_id} where code = #{code};")
    void updateMembers(String members_id, int code);

    @Update("update Club set advisor_id = #{advisor_id} where code = #{code};")
    void updateAdvisor(int advisor_id, int code);

    @Update("update Club set manager_id = #{manager_id} where code = #{code};")
    void updateManager(int manager_id, int code);

    @Update("update RegisterCode set register_code = #{register_code} where club_code = #{club_code};")
    void updateRegisterCode(String register_code, int club_code);

}
