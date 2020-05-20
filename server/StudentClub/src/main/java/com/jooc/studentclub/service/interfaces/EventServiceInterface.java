package com.jooc.studentclub.service.interfaces;

import java.util.HashMap;

public interface EventServiceInterface {

    Object getAllEvent();
    Object getById(int id);
    Object getByUserId(int userId);

    Object addEvent(HashMap<String, Object> req);
//    Object addParticipant(HashMap<String, Object> req);

    Object participateEvent(HashMap<String, Object> req);
    Object quitEvent(HashMap<String, Object> req);
}
