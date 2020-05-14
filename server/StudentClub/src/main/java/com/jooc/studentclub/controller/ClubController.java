package com.jooc.studentclub.controller;

import com.jooc.studentclub.mapper.ClubMapper;
import com.jooc.studentclub.model.ClubModel;
import com.jooc.studentclub.model.DBModel.DBClubModel;
import com.jooc.studentclub.service.ClubService;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;

@RestController
@RequestMapping("/club")
public class ClubController {

    @Autowired
    private ClubService clubService;

    @Autowired
    private ClubMapper clubMapper;

    @Autowired
    public ClubController(ClubService clubService){
        this.clubService = clubService;
    }

    @GetMapping("/getAllClub")
    public Object getAllClub(){
        return clubService.getAllClub();
    }

    @GetMapping("/getByCode")
    public Object getClubByCode(int code){
        return clubService.getByCode(code);
    }

    @GetMapping("/getByRegisterCode")
    public Object getClubByRegisterCode(String registerCode){
        return clubService.getClubByRegisterCode(registerCode);
    }

    @GetMapping("/getRegisterCodeByClubCode")
    public Object getRegisterCodeByClubCode(int clubCode){
        return clubService.getRegisterCodeByClubCode(clubCode);
    }

    @GetMapping("/getClubNameByRegisterCode")
    public Object getClubNameByRegisterCode(String registerCode){
        return clubService.getClubNameByRegisterCode(registerCode);
    }

    @PostMapping("/add")
    public Object addClub(@RequestBody HashMap<String, Object> req){
        return clubService.add(req);
    }

    @PostMapping("remove")
    public Object removeClub(@RequestBody HashMap<String, Object> req){
        return clubService.remove(req);
    }

    @PostMapping("/editDescription")
    public Object editDescription(@RequestBody HashMap<String, Object> req){
        return clubService.editDescription(req);
    }

    @PostMapping("/addMember")
    public Object addMember(@RequestBody HashMap<String, Object> req){
        return clubService.addMember(req);
    }

    @PostMapping("/removeMember")
    public Object removeMember(@RequestBody HashMap<String, Object> req){
        return clubService.removeMember(req);
    }

    @PostMapping("/setAdvisor")
    public Object setAdvisor(@RequestBody HashMap<String, Object> req){
        return clubService.setAdvisor(req);
    }

    @PostMapping("/setManager")
    public Object setManager(@RequestBody HashMap<String, Object> req){
        return clubService.setManager(req);
    }

    @PostMapping("/resetRegisterCode")
    public Object resetRegisterCode(@RequestBody HashMap<String, Object> req){
        return clubService.resetRegisterCode(req);
    }

}
