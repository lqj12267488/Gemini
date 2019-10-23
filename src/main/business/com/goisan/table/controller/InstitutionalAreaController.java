package com.goisan.table.controller;

import com.goisan.table.bean.InstitutionalArea;
import com.goisan.table.service.InstitutionalAreaService;
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
public class InstitutionalAreaController {

    @Resource
    private InstitutionalAreaService institutionalAreaService;

    @RequestMapping("/institutionalarea/toInstitutionalAreaList")
    public String toInstitutionalAreaList() {
        return "/business/table/institutionalarea/institutionalAreaList";
    }

    @ResponseBody
    @RequestMapping("/institutionalarea/getInstitutionalAreaList")
    public Map<String,Object> getInstitutionalAreaList(InstitutionalArea institutionalArea,int draw, int start, int length) {
         PageHelper.startPage(start / length + 1, length);
         Map<String, Object> map = new HashMap(16);
         List<BaseBean> list =  institutionalAreaService.getInstitutionalAreaList(institutionalArea);
         PageInfo<List<BaseBean>> info = new PageInfo(list);
         map.put("draw", draw);
         map.put("recordsTotal", info.getTotal());
         map.put("recordsFiltered", info.getTotal());
         map.put("data", list);
        return map;
    }

    @RequestMapping("/institutionalarea/toInstitutionalAreaAdd")
    public String toAddInstitutionalArea(Model model) {
        model.addAttribute("head", "新增");
        return "/business/table/institutionalarea/institutionalAreaEdit";
    }

    @ResponseBody
    @RequestMapping("/institutionalarea/saveInstitutionalArea")
    public Message saveInstitutionalArea(InstitutionalArea institutionalArea) {
        if (null != institutionalArea.getId() && !"".equals(institutionalArea.getId())) {
           CommonUtil.update(institutionalArea);
            institutionalAreaService.updateInstitutionalArea(institutionalArea);
            return new Message(0, "修改成功！", null);
        } else {
            CommonUtil.save(institutionalArea);
            institutionalAreaService.saveInstitutionalArea(institutionalArea);
            return new Message(0, "添加成功！", null);
        }
    }

    @RequestMapping("/institutionalarea/toInstitutionalAreaEdit")
    public String toEditInstitutionalArea(String id, Model model,String flag) {
        model.addAttribute("data", institutionalAreaService.getInstitutionalAreaById(id));
        model.addAttribute("head", "修改");
        if (flag != null) {
            if (flag.equals("on") || flag == "on") {
                model.addAttribute("head", "详情信息");
                model.addAttribute("flag", flag);
            }
        }
        return "/business/table/institutionalarea/institutionalAreaEdit";
    }

    @ResponseBody
    @RequestMapping("/institutionalarea/delInstitutionalArea")
    public Message delInstitutionalArea(String id) {
        institutionalAreaService.delInstitutionalArea(id);
        return new Message(0, "删除成功！", null);
    }

}
