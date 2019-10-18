package com.goisan.table.controller;

import com.goisan.table.bean.Qualification;
import com.goisan.table.service.QualificationService;
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
public class QualificationController {

    @Resource
    private QualificationService qualificationService;

    @RequestMapping("/qualification/toQualificationList")
    public String toQualificationList() {
        return "/business/table/qualification/qualificationList";
    }

    @ResponseBody
    @RequestMapping("/qualification/getQualificationList")
    public Map<String,Object> getQualificationList(Qualification qualification,int draw, int start, int length) {
         PageHelper.startPage(start / length + 1, length);
         Map<String, Object> map = new HashMap(16);
         List<BaseBean> list =  qualificationService.getQualificationList(qualification);
         PageInfo<List<BaseBean>> info = new PageInfo(list);
         map.put("draw", draw);
         map.put("recordsTotal", info.getTotal());
         map.put("recordsFiltered", info.getTotal());
         map.put("data", list);
        return map;
    }

    @RequestMapping("/qualification/toQualificationAdd")
    public String toAddQualification(Model model) {
        model.addAttribute("head", "新增");
        return "/business/table/qualification/qualificationEdit";
    }

    @ResponseBody
    @RequestMapping("/qualification/saveQualification")
    public Message saveQualification(Qualification qualification) {
        if (null != qualification.getId() && !"".equals(qualification.getId())) {
           CommonUtil.update(qualification);
            qualificationService.updateQualification(qualification);
            return new Message(0, "修改成功！", null);
        } else {
            CommonUtil.save(qualification);
            qualificationService.saveQualification(qualification);
            return new Message(0, "添加成功！", null);
        }
    }

    @RequestMapping("/qualification/toQualificationEdit")
    public String toEditQualification(String id, Model model) {
        model.addAttribute("data", qualificationService.getQualificationById(id));
        model.addAttribute("head", "修改");
        return "/business/table/qualification/qualificationEdit";
    }

    @ResponseBody
    @RequestMapping("/qualification/delQualification")
    public Message delQualification(String id) {
        qualificationService.delQualification(id);
        return new Message(0, "删除成功！", null);
    }

    @ResponseBody
    @RequestMapping("/qualification/getQualificationBySelect")
    public List<Map> getQualificationBySelect() {
        List<Map> list = qualificationService.getQualificationBySelect();
        return list;
    }
}
