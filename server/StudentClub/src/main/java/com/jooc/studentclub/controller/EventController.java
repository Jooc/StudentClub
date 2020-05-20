package com.jooc.studentclub.controller;


import com.jooc.studentclub.service.EventService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;

@RestController
@RequestMapping("event")
public class EventController {
    @Autowired
    private EventService eventService;

    @Autowired
    public EventController(EventService eventService){
        this.eventService = eventService;
    }

    @GetMapping("/getAllEvent")
    public Object getAllEvent(){
        return eventService.getAllEvent();
    }

    @GetMapping("/getEventById")
    public Object getById(int id){
        return eventService.getById(id);
    }

    @GetMapping("/getEventByUserId")
    public Object getEventByUserId(int userId){
        return eventService.getByUserId(userId);
    }

    @PostMapping("/publish")
    public Object addEvent(@RequestBody HashMap<String, Object> req){
        return eventService.addEvent(req);
    }

//    @PostMapping("/addParticipant")
//    public Object addParticipant(@RequestBody HashMap<String, Object> req){
//        return eventService.addParticipant(req);
//    }

    @PostMapping("/participateEvent")
    public Object participateEvent(@RequestBody HashMap<String, Object> req){
        return eventService.participateEvent(req);
    }

    @PostMapping("/quitEvent")
    public Object quitEvent(@RequestBody HashMap<String, Object> req){
        return eventService.quitEvent(req);
    }

}
