package com.goisan.studentwork.onlineregister.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.studentwork.graduatearchivesaddress.bean.Arcad;
import com.goisan.studentwork.onlineregister.bean.OnlineRegister;
import com.goisan.studentwork.onlineregister.service.OnlineRegisterService;
import com.goisan.system.bean.Student;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class OnlineRegisterController {

    @Resource
    private OnlineRegisterService onlineRegisterService;

    @RequestMapping("/onlineregister/toOnlineRegisterList")
    public String toList(Model model, String type, String origin) {
        model.addAttribute("type", type);
        model.addAttribute("origin", origin);
        model.addAttribute("allYear", onlineRegisterService.getAllYear());
        return "/business/studentwork/onlineregister/onlineRegisterList";
    }

    @ResponseBody
    @RequestMapping("/onlineregister/getOnlineRegisterList")
    public Map<String,Object> getList(OnlineRegister onlineRegister,int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> result = new HashMap();
        List<OnlineRegister> list = onlineRegisterService.getOnlineRegisterList(onlineRegister);
        PageInfo<List<OnlineRegister>> info = new PageInfo(list);
        result.put("draw", draw);
        result.put("recordsTotal", info.getTotal());
        result.put("recordsFiltered", info.getTotal());
        result.put("data", list);
        return result;
    }

    @RequestMapping("/onlineregister/signUp")
    public String toAdd(Model model, String type) {
        model.addAttribute("type", type);
        return "/business/studentwork/onlineregister/signUp";
    }

    @ResponseBody
    @RequestMapping("/onlineregister/saveOnlineRegister")
    public Message save(OnlineRegister onlineRegister, @RequestParam(value = "file_img", required = false) MultipartFile img
            , @RequestParam(value = "file_idcardImg", required = false) MultipartFile idcardImg
            , @RequestParam(value = "file_examinationImg", required = false) MultipartFile examinationImg
            , @RequestParam(value = "file_scoreImg", required = false) MultipartFile scoreImg
            , @RequestParam(value = "file_hukouImg", required = false) MultipartFile[] hukouImg
            , @RequestParam(value = "file_graduatedImg", required = false) MultipartFile[] graduatedImg) {
        onlineRegisterService.saveOnlineRegister(onlineRegister, img, idcardImg, examinationImg, scoreImg, hukouImg, graduatedImg);
        return new Message(0, "添加成功！", null);
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

    //身份证校验
    @ResponseBody
    @RequestMapping(value = "/onlineregister/getRegisterByIDCard",produces = {"text/html;charset=utf-8"})
    public String getRegisterByIDCard(OnlineRegister onlineRegister) {
        List<OnlineRegister> list = onlineRegisterService.getRegisterByIDCard(onlineRegister);
        if (list.size() == 0) {
            return "notfound";
        } else {
            OnlineRegister or = (OnlineRegister) list.get(0);
            return or.getAuditFlag() + "-" + or.getRegisterType();
        }
    }
}
