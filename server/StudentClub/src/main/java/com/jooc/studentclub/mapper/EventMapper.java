package com.jooc.studentclub.mapper;

import com.jooc.studentclub.model.DBModel.DBEventModel;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface EventMapper {

    @Select("select * from Event;")
    List<DBEventModel> getAllEvent();

    @Select("select * from Event where id=#{id};")
    DBEventModel getById(int id);

    @Select("select max(id) from Event;")
    int getMaxId();

    @Insert("insert into Event(id, title, location, start_date, end_date, url, notes, club_code, participant, open_or_not)" +
        "values(#{e.id}, #{e.title}, #{e.location}, #{e.start_date}, #{e.end_date}, #{e.url}, #{e.notes}, #{e.club_code} ,#{e.participant}, #{e.open_or_not});")
    void insertEvent(@Param("e") DBEventModel e);

    @Update("update Event set participant = #{participant} where id=#{id};")
    void updateParticipant(int id, String participant);
}
