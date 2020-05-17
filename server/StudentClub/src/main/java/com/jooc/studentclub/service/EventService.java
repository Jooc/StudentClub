package com.jooc.studentclub.service;

import com.alibaba.fastjson.JSONArray;
import com.jooc.studentclub.mapper.EventMapper;
import com.jooc.studentclub.model.DBModel.DBEventModel;
import com.jooc.studentclub.service.interfaces.EventServiceInterface;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@Service
public class EventService implements EventServiceInterface {

    @Autowired
    EventMapper eventMapper;

    @Override
    public Object getAllEvent() {
        HashMap<String, Object> res = new HashMap<>();
        try{
            List<DBEventModel> list = eventMapper.getAllEvent();
            res.put("code", 0);
            res.put("msg", "查询成功");
            res.put("events", list);
        }catch (Exception e){
            res.put("code", -1);
            res.put("msg", "读取数据失败" + e.getMessage());
        }
        return res;
    }

    @Override
    public Object getById(int id) {
        HashMap<String, Object> res = new HashMap<>();
        try{
            DBEventModel db = eventMapper.getById(id);
            res.put("code", 0);
            res.put("msg", "查询成功");
            res.put("event", db);
        }catch (Exception e){
            res.put("code", -1);
            res.put("msg", "查询失败" + e.getMessage());
        }
        return res;
    }

    @Override
    public Object addEvent(HashMap<String, Object> req) {
        HashMap<String, Object> res = new HashMap<>();

        //TODO: Privilege
        int id = eventMapper.getMaxId() + 1;
        String title = (String) req.get("title");
        String location = (String) req.get("location");
        String start_date = (String) req.get("start_date");
        String end_date = (String) req.get("end_date");
        String url = (String) req.get("url");
        String notes = (String) req.get("notes");
        int initiator_id = Integer.parseInt(req.get("initiator_id").toString());
        //TODO: Not necessary maybe
        int club_code = Integer.parseInt(req.get("club_code").toString());
        String participant = (String) req.get("participant");

        DBEventModel db = new DBEventModel(id, title, location, start_date, end_date, url, notes, initiator_id, club_code, participant);


        try{
            eventMapper.insertEvent(db);
            res.put("code", 0);
            res.put("msg", "成功");
            res.put("event", eventMapper.getById(id));
        }catch (Exception e){
            res.put("code", -1);
            res.put("msg", "插入失败" + e.getMessage());
        }
        return res;
    }

    @Override
    public Object addParticipant(HashMap<String, Object> req) {
        HashMap<String, Object> res = new HashMap<>();
        int id = -1;

        try{
            id = Integer.parseInt(req.get("event_id").toString());
        }catch (Exception e){
            res.put("code", -1);
            res.put("msg", "event_id 无效" + e.getMessage());
            return res;
        }

        int newParticipantId = Integer.parseInt(req.get("newParticipant_id").toString());

        DBEventModel db = eventMapper.getById(id);
        JSONArray participantArray = JSONArray.parseArray(db.participant);
        if (participantArray.contains(newParticipantId)){
            res.put("code", -1);
            res.put("msg", "该成员已参加");
            return res;
        }
        participantArray.add(newParticipantId);
        String newParticipants = JSONArray.toJSONString(participantArray);

        try{
            eventMapper.updateParticipant(id, newParticipants);
            res.put("code", 0);
            res.put("msg", "成功参加");
            res.put("event", eventMapper.getById(id));
        }catch (Exception e){
            res.put("code", -1);
            res.put("msg", "更新数据失败");
        }

        return res;
    }
}
