package com.jooc.studentclub.mapper;

import com.jooc.studentclub.model.DBModel.DBEventModel;
import org.apache.ibatis.annotations.*;

import java.util.ArrayList;
import java.util.List;

@Mapper
public interface EventMapper {

    @Select("select * from Event order by start_date desc;")
    List<DBEventModel> getAllEvent();

    @Select("select * from Event where id=#{id};")
    DBEventModel getById(int id);

    @Select("select max(id) from Event;")
    int getMaxId();

    @Insert("insert into Event(id, title, location, start_date, end_date, url, notes, initiator_id, club_code, participant)" +
        "values(#{e.id}, #{e.title}, #{e.location}, #{e.start_date}, #{e.end_date}, #{e.url}, #{e.notes}, #{e.initiator_id}, #{e.club_code} ,#{e.participant});")
    void insertEvent(@Param("e") DBEventModel e);

    @Update("update Event set participant = #{participant} where id=#{id};")
    void updateParticipant(int id, String participant);
}
