package com.goisan.table.controller;

import com.goisan.table.bean.ContactInformation;
import com.goisan.table.service.ContactInformationService;
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
public class ContactInformationController {

    @Resource
    private ContactInformationService contactInformationService;

    @RequestMapping("/contactinformation/toContactInformationList")
    public String toContactInformationList() {
        return "/business/table/contactinformation/contactInformationList";
    }

    @ResponseBody
    @RequestMapping("/contactinformation/getContactInformationList")
    public Map<String,Object> getContactInformationList(ContactInformation contactInformation,int draw, int start, int length) {
         PageHelper.startPage(start / length + 1, length);
         Map<String, Object> map = new HashMap(16);
         List<BaseBean> list =  contactInformationService.getContactInformationList(contactInformation);
         PageInfo<List<BaseBean>> info = new PageInfo(list);
         map.put("draw", draw);
         map.put("recordsTotal", info.getTotal());
         map.put("recordsFiltered", info.getTotal());
         map.put("data", list);
        return map;
    }

    @RequestMapping("/contactinformation/toContactInformationAdd")
    public String toAddContactInformation(Model model) {
        model.addAttribute("head", "新增");
        return "/business/table/contactinformation/contactInformationEdit";
    }

    @ResponseBody
    @RequestMapping("/contactinformation/saveContactInformation")
    public Message saveContactInformation(ContactInformation contactInformation) {
        if (null != contactInformation.getId() && !"".equals(contactInformation.getId())) {
           CommonUtil.update(contactInformation);
            contactInformationService.updateContactInformation(contactInformation);
            return new Message(0, "修改成功！", null);
        } else {
            CommonUtil.save(contactInformation);
            contactInformationService.saveContactInformation(contactInformation);
            return new Message(0, "添加成功！", null);
        }
    }

    @RequestMapping("/contactinformation/toContactInformationEdit")
    public String toEditContactInformation(String id, Model model) {
        model.addAttribute("data", contactInformationService.getContactInformationById(id));
        model.addAttribute("head", "修改");
        return "/business/table/contactinformation/contactInformationEdit";
    }

    @ResponseBody
    @RequestMapping("/contactinformation/delContactInformation")
    public Message delContactInformation(String id) {
        contactInformationService.delContactInformation(id);
        return new Message(0, "删除成功！", null);
    }

}
