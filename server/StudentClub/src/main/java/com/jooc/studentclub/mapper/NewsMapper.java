package com.jooc.studentclub.mapper;

import com.jooc.studentclub.model.DBNewsModel;
import com.jooc.studentclub.model.NewsModel;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface NewsMapper {

    @Select("select * from news order by post_time desc")
    List<DBNewsModel> getAllNews();

    @Select("select * from news where id = #{id}")
    DBNewsModel getNewsById(int id);

    @Select("select * from news where privilege <= #{privilege} order by post_time desc")
    List<DBNewsModel> getNewsByPrivilege(int privilege);

    @Select("select * from news where publisher_id = #{user_id} order by post_time desc")
    List<DBNewsModel> getNewsByUserId(int user_id);


    @Insert("insert into news(id, post_time, title, content, images, publisher_id, publisher_name, publisher_avatar, privilege) " +
            "values(#{news.id}, #{news.post_time}, #{news.title}, #{news.content}, #{news.images}, #{news.publisher_id}, #{news.publisher_name}, #{news.publisher_avatar}, #{news.privilege})")
    void insertNews(@Param("news")DBNewsModel news);

    @Delete("delete from news where id=#{id}")
    void deleteById(int id);

}
