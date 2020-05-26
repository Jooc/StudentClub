package com.jooc.studentclub.mapper;

import com.jooc.studentclub.model.DBModel.DBBlogModel;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface BlogMapper {

    @Select("select Blog.id, post_time, url, publisher_id, User.name, User.avatar, User.privilege as publisher_privilege, Blog.privilege, tags from Blog join User on (Blog.publisher_id=User.id) order by post_time desc;")
    List<DBBlogModel> getAllBlog();

    @Select("select Blog.id, post_time, url, publisher_id, User.name, User.avatar, User.privilege as publisher_privilege, Blog.privilege, tags from Blog join User on (Blog.publisher_id=User.id) where Blog.id = #{id};")
    DBBlogModel getById(int id);

    @Select("select Blog.id, post_time, url, publisher_id, User.name, User.avatar, User.privilege as publisher_privilege, Blog.privilege, tags from Blog join User on (Blog.publisher_id=User.id) where Blog.privilege <= #{privilege} order by post_time desc;")
    List<DBBlogModel> getByPrivilege(int privilege);

    @Select("select Blog.id, post_time, url, publisher_id, User.name, User.avatar, User.privilege as publisher_privilege, Blog.privilege, tags from  Blog join User on (Blog.publisher_id=User.id) where publisher_id = #{user_id} order by post_time desc;")
    List<DBBlogModel> getByUserId(int user_id);

    @Select("select max(id) from Blog")
    int getMaxId();

    @Insert("insert into Blog(id, post_time, url, publisher_id, privilege, tags) values(#{db.id}, #{db.post_time}, #{db.url}, #{db.publisher_id}, #{db.privilege}, #{db.tags}); ")
    void insertBlog(@Param("db") DBBlogModel db);

    @Delete("delete from Blog where id = #{id}")
    void deleteById(int id);

}
