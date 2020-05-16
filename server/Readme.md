## 设计规范

1. User_id 范围身份对应： 

   - 【一位】0 - 9：预留
     - 0：游客账户
     - 1：开发 @Jooc
   - 【两位】10 - 99：管理员
   - 【三位】100 - 999：指导老师
   - 【四位】1000 - 9999：俱乐部经理&普通成员

   

2. OSS 文件归属:

   - [/UserAvatar] 用户头像
   - [/ClubIcon] 俱乐部图标
   - [/NewsImage] News附带图片
   - [/test] 测试用例

   

3. OSS 图片命名：

   - UserAvatar - UserId
   - ClubIcon - ClubCode
   - NewsImage - 时间戳

   

4. privilege 系统

   - 游客 - 普通用户 - 俱乐部经理 - 指导老师 - 系统管理员/运维 - 开发
     - 0 - 1 - 2 - 3 - 4 - 5
   - privilege >= 2 即可对俱乐部成员进行增删改
   - privilege >= 3 可更换俱乐部经理
   - privilege >= 4 可更换俱乐部指导老师
   - 权限更高的用户可以删除权限低用户发布的News 或 Blog 或Event



