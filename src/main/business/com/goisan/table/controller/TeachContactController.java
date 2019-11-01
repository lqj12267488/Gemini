package com.goisan.table.controller;

import com.goisan.table.bean.TeachContact;
import com.goisan.table.service.TeachContactService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.system.bean.BaseBean;

import javax.annotation.Resource;
import java.util.*;

@Controller
public class TeachContactController {

    @Resource
    private TeachContactService teachContactService;

    @RequestMapping("/teachcontact/toTeachContactList")
    public String toTeachContactList() {
        return "/business/table/teachcontact/teachContactList";
    }

    @ResponseBody
    @RequestMapping("/teachcontact/getTeachContactList")
    public Map<String,Object> getTeachContactList(TeachContact teachContact,int draw, int start, int length) {
         PageHelper.startPage(start / length + 1, length);
         Map<String, Object> map = new HashMap(16);
         List<BaseBean> list =  teachContactService.getTeachContactList(teachContact);
         PageInfo<List<BaseBean>> info = new PageInfo(list);
         map.put("draw", draw);
         map.put("recordsTotal", info.getTotal());
         map.put("recordsFiltered", info.getTotal());
         map.put("data", list);
        return map;
    }

    @RequestMapping("/teachcontact/toTeachContactAdd")
    public String toAddTeachContact(Model model) {
        model.addAttribute("head", "新增");
        return "/business/table/teachcontact/teachContactEdit";
    }

    @ResponseBody
    @RequestMapping("/teachcontact/saveTeachContact")
    public Message saveTeachContact(TeachContact teachContact) {
        if (null != teachContact.getId() && !"".equals(teachContact.getId())) {
            CommonUtil.update(teachContact);
            teachContactService.updateTeachContact(teachContact);
            return new Message(0, "修改成功！", null);
        } else {
            teachContact.setPersonId(teachContact.getPersonId().split(",")[1]);
            CommonUtil.save(teachContact);
            teachContactService.saveTeachContact(teachContact);
            return new Message(0, "添加成功！", null);
        }
    }

    @RequestMapping("/teachcontact/toTeachContactEdit")
    public String toEditTeachContact(String id, Model model) {
        model.addAttribute("data", teachContactService.getTeachContactById(id));
        model.addAttribute("head", "修改");
        return "/business/table/teachcontact/teachContactEdit";
    }

    @ResponseBody
    @RequestMapping("/teachcontact/delTeachContact")
    public Message delTeachContact(String id) {
        teachContactService.delTeachContact(id);
        return new Message(0, "删除成功！", null);
    }

}
