package com.jooc.studentclub.mapper;

import com.jooc.studentclub.model.DBModel.DBNewsModel;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface NewsMapper {

    @Select("select News.id, post_time, title, content, images, publisher_id, User.name as publisher_name, User.avatar as publisher_avatar, News.privilege, tags from News join User on (News.publisher_id = User.id) order by post_time desc")
    List<DBNewsModel> getAllNews();

    @Select("select News.id, post_time, title, content, images, publisher_id, User.name as publisher_name, User.avatar as publisher_avatar, News.privilege, tags from News join User on (News.publisher_id = User.id) where News.id = #{id}")
    DBNewsModel getNewsById(int id);

    @Select("select News.id, post_time, title, content, images, publisher_id, User.name as publisher_name, User.avatar as publisher_avatar, News.privilege, tags from News join User on (News.publisher_id = User.id) where News.privilege <= #{privilege} order by post_time desc;")
    List<DBNewsModel> getNewsByPrivilege(int privilege);

    @Select("select News.id, post_time, title, content, images, publisher_id, User.name as publisher_name, User.avatar as publisher_avatar, News.privilege, tags from News join User on (News.publisher_id = User.id) where publisher_id = #{user_id} order by post_time desc")
    List<DBNewsModel> getNewsByUserId(int user_id);

    @Insert("insert into news(id, post_time, title, content, images, publisher_id, publisher_name, publisher_avatar, privilege) " +
            "values(#{news.id}, #{news.post_time}, #{news.title}, #{news.content}, #{news.images}, #{news.publisher_id}, #{news.publisher_name}, #{news.publisher_avatar}, #{news.privilege})")
    void insertNews(@Param("news")DBNewsModel news);

    @Delete("delete from news where id=#{id}")
    void deleteById(int id);

}
