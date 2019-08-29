package com.goisan.studentwork.onlineregister.controller;

import com.goisan.studentwork.onlineregister.bean.OnlineRegister;
import com.goisan.studentwork.onlineregister.service.OnlineRegisterService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.Map;

@Controller
public class OnlineRegisterController {

    @Resource
    private OnlineRegisterService onlineRegisterService;

    @RequestMapping("/onlineregister/toOnlineRegisterList")
    public String toList() {
        return "/business/studentwork/onlineregister/onlineRegisterList";
    }

    @ResponseBody
    @RequestMapping("/onlineregister/getOnlineRegisterList")
    public Map getList(OnlineRegister onlineRegister) {
        return CommonUtil.tableMap(onlineRegisterService.getOnlineRegisterList(onlineRegister));
    }

    @RequestMapping("/onlineregister/signUp")
    public String toAdd(Model model) {
        return "/business/studentwork/onlineregister/signUp";
    }

    @ResponseBody
    @RequestMapping("/onlineregister/saveOnlineRegister")
    public Message save(OnlineRegister onlineRegister) {
        if ("".equals(onlineRegister.getId())) {
            onlineRegister.setId(CommonUtil.getUUID());
            CommonUtil.save(onlineRegister);
            onlineRegisterService.saveOnlineRegister(onlineRegister);
            return new Message(0, "添加成功！", null);
        } else {
            CommonUtil.update(onlineRegister);
            onlineRegisterService.updateOnlineRegister(onlineRegister);
            return new Message(0, "修改成功！", null);
        }

    }

    @RequestMapping("/onlineregister/toOnlineRegisterEdit")
    public String toEdit(String id, Model model) {
        model.addAttribute("data", onlineRegisterService.getOnlineRegisterById(id));
        model.addAttribute("head", "修改");
        return "/business/studentwork/onlineregister/onlineRegisterEdit";
    }

    @ResponseBody
    @RequestMapping("/onlineregister/delOnlineRegister")
    public Message del(String id) {
        onlineRegisterService.delOnlineRegister(id);
        return new Message(0, "删除成功！", null);
    }

}
