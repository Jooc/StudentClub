package com.jooc.studentclub.service;

import com.alibaba.fastjson.JSONArray;
import com.jooc.studentclub.mapper.ClubMapper;
import com.jooc.studentclub.mapper.EventMapper;
import com.jooc.studentclub.mapper.UserMapper;
import com.jooc.studentclub.model.DBModel.DBClubModel;
import com.jooc.studentclub.model.DBModel.DBEventModel;
import com.jooc.studentclub.model.DBModel.DBUserModel;
import com.jooc.studentclub.model.EventModel;
import com.jooc.studentclub.service.interfaces.EventServiceInterface;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Service
public class EventService implements EventServiceInterface {

    @Autowired
    EventMapper eventMapper;

    @Autowired
    UserMapper userMapper;

    @Autowired
    ClubMapper clubMapper;

    @Override
    public Object getAllEvent() {
        HashMap<String, Object> res = new HashMap<>();
        try {
            List<DBEventModel> list = eventMapper.getAllEvent();
            ArrayList<EventModel> resultList = new ArrayList<>();
            for (DBEventModel db : list) {
                resultList.add(new EventModel((db)));
            }
            res.put("code", 0);
            res.put("msg", "查询成功");
            res.put("events", resultList);
        } catch (Exception e) {
            res.put("code", -1);
            res.put("msg", "读取数据失败" + e.getMessage());
        }
        return res;
    }

    @Override
    public Object getById(int id) {
        HashMap<String, Object> res = new HashMap<>();
        try {
            DBEventModel db = eventMapper.getById(id);
            res.put("code", 0);
            res.put("msg", "查询成功");
            res.put("event", new EventModel((db)));
        } catch (Exception e) {
            res.put("code", -1);
            res.put("msg", "查询失败" + e.getMessage());
        }
        return res;
    }

    @Override
    public Object getByUserId(int userId) {
        HashMap<String, Object> res = new HashMap<>();

        int userClubCode = -1;
        ArrayList<EventModel> resultList = new ArrayList<>();
        try {
            DBUserModel DBUser = userMapper.getUserById(userId);
            userClubCode = DBUser.club_code;
        } catch (Exception e) {
            res.put("code", -1);
            res.put("msg", "用户不存在");
            return res;
        }

        List<DBEventModel> eventList = eventMapper.getAllEvent();
        for (DBEventModel e : eventList) {
            if (e.club_code == userClubCode) {
                resultList.add(new EventModel(e));
            } else {
                if (e.open_or_not == 1) {
                    resultList.add(new EventModel(e));
                }
            }
        }
        res.put("code", 0);
        res.put("msg", "查询成功");
        res.put("events", resultList);
        return res;
    }

    @Override
    public Object addEvent(HashMap<String, Object> req) {
        HashMap<String, Object> res = new HashMap<>();

        int id = eventMapper.getMaxId() + 1;
        String title = (String) req.get("title");
        String location = (String) req.get("location");
        String start_date = (String) req.get("startDate");
        String end_date = (String) req.get("endDate");
        String url = (String) req.get("url");
        String notes = (String) req.get("notes");
        int initiator_id = Integer.parseInt(req.get("initiatorId").toString());

        DBUserModel dbUser = userMapper.getUserById(initiator_id);
        int club_code = (dbUser.club_code);

        //TODO: 默认本俱乐部成员全部参加
        DBClubModel dbClub = clubMapper.getByCode(club_code);
        JSONArray memberList = JSONArray.parseArray(dbClub.members_id);
        JSONArray participantList = new JSONArray();
        for (Object memberId : memberList) {
            participantList.add(memberId);
        }
        String participant = JSONArray.toJSONString(participantList);

        int open_or_not = Integer.parseInt(req.get("openOrNot").toString());

        DBEventModel db = new DBEventModel(id, title, location, start_date, end_date, url, notes, club_code, participant, open_or_not);

        try {
            eventMapper.insertEvent(db);
            res.put("code", 0);
            res.put("msg", "成功");
            res.put("event", new EventModel(eventMapper.getById(id)));
        } catch (Exception e) {
            res.put("code", -1);
            res.put("msg", "插入失败" + e.getMessage());
        }
        return res;
    }

    @Override
    public Object participateEvent(HashMap<String, Object> req) {
        HashMap<String, Object> res = new HashMap<>();
        int id = -1;

        try {
            id = Integer.parseInt(req.get("eventId").toString());
        } catch (Exception e) {
            res.put("code", -1);
            res.put("msg", "event_id 无效" + e.getMessage());
            return res;
        }

        int newParticipantId = Integer.parseInt(req.get("userId").toString());

        DBEventModel db = eventMapper.getById(id);
        JSONArray participantArray = JSONArray.parseArray(db.participant);
        if (participantArray.contains(newParticipantId)) {
            res.put("code", -1);
            res.put("msg", "该成员已参加");
            return res;
        }
        participantArray.add(newParticipantId);
        String newParticipants = JSONArray.toJSONString(participantArray);

        try {
            eventMapper.updateParticipant(id, newParticipants);
            res.put("code", 0);
            res.put("msg", "成功参加");
            res.put("event", new EventModel(eventMapper.getById(id)));
        } catch (Exception e) {
            res.put("code", -1);
            res.put("msg", "更新数据失败");
        }

        return res;
    }

    @Override
    public Object quitEvent(HashMap<String, Object> req) {
        HashMap<String, Object> res = new HashMap<>();

        int eventId = Integer.parseInt(req.get("eventId").toString());
        int newParticipantId = Integer.parseInt(req.get("userId").toString());

        DBEventModel db = eventMapper.getById(eventId);
        JSONArray participantArray = JSONArray.parseArray(db.participant);
        if (!participantArray.contains(newParticipantId)){
            res.put("code", -1);
            res.put("msg", "用户未参加");
            return res;
        }
        participantArray.remove(participantArray.indexOf(newParticipantId));
        String newParticipants = JSONArray.toJSONString(participantArray);

        try{
            eventMapper.updateParticipant(eventId, newParticipants);
            res.put("code", 0);
            res.put("msg", "成功退出");
            res.put("event", new EventModel(eventMapper.getById(eventId)));
        }catch (Exception e){
            res.put("code", -1);
            res.put("msg", "数据更新失败" + e.getMessage());
        }
        return res;
    }
}
