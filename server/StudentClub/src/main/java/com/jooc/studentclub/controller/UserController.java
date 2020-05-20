package com.jooc.studentclub.controller;

import com.jooc.studentclub.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;

@RestController
@RequestMapping("/user")
public class UserController {

    private UserService userService;

    @Autowired
    public UserController(UserService userService){
        this.userService = userService;
    }

    @GetMapping("/getUserById")
    public Object getUserById(int id){
        return userService.getUserById(id);
    }

    @GetMapping("/getUserInfoById")
    public Object getUserInfoById(int id){
        return userService.getUserInfoById(id);
    }

    @PostMapping("/login")
    public Object login(@RequestBody HashMap<String, Object> req) throws InterruptedException{
        Date d = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        System.out.println("" + sdf.format(d) + " [Request]: login for" + req.get("email"));

        return userService.login(req);
    }

    @PostMapping("/register")
    public Object register(@RequestBody HashMap<String, Object> req) throws InterruptedException{
        return userService.register(req);
    }

    @PostMapping("/editUserName")
    public Object editUserName(@RequestBody HashMap<String, Object> req){
        return userService.editUserName(req);
    }

    @PostMapping("/editGender")
    public Object editGender(@RequestBody HashMap<String, Object> req){
        return userService.editGender(req);
    }

    @PostMapping("/editPhoneNumber")
    public Object editPhoneNumber(@RequestBody HashMap<String, Object> req){
        return userService.editPhoneNumber(req);
    }

    @PostMapping("/editContactEmail")
    public Object editContactEmail(@RequestBody HashMap<String, Object> req){
        return userService.editContactEmail(req);
    }

    @GetMapping("/test")
    public Object test(){
        return "OK";
    }
}
