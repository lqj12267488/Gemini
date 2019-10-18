package com.goisan.table.controller;

import com.goisan.table.bean.CourtyardName;
import com.goisan.table.service.CourtyardNameService;
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
public class CourtyardNameController {

    @Resource
    private CourtyardNameService courtyardNameService;

    @RequestMapping("/courtyardname/toCourtyardNameList")
    public String toCourtyardNameList(Model model) {
        List<CourtyardName> list =  courtyardNameService.getCourtyardNameList(new CourtyardName());
        CourtyardName courtyardName = new CourtyardName();
        if (list.size()>0) courtyardName = list.get(0);
        model.addAttribute("data", courtyardName);
        return "/business/table/courtyardname/courtyardNameList";
    }

    @ResponseBody
    @RequestMapping("/courtyardname/getCourtyardNameList")
    public Map<String,Object> getCourtyardNameList(CourtyardName courtyardName,int draw, int start, int length) {
         PageHelper.startPage(start / length + 1, length);
         Map<String, Object> map = new HashMap(16);
         List<CourtyardName> list =  courtyardNameService.getCourtyardNameList(courtyardName);
         PageInfo<List<BaseBean>> info = new PageInfo(list);
         map.put("draw", draw);
         map.put("recordsTotal", info.getTotal());
         map.put("recordsFiltered", info.getTotal());
         map.put("data", list);
        return map;
    }

    @RequestMapping("/courtyardname/toCourtyardNameAdd")
    public String toAddCourtyardName(Model model) {
        model.addAttribute("head", "新增");
        List<CourtyardName> list =  courtyardNameService.getCourtyardNameList(new CourtyardName());
        CourtyardName courtyardName = new CourtyardName();
        if (list.size()>0) courtyardName = list.get(0);
        model.addAttribute("data", courtyardName);
        return "/business/table/courtyardname/courtyardNameEdit";
    }

    @RequestMapping("/courtyardname/saveCourtyardName")
    public Message saveCourtyardName(CourtyardName courtyardName) {
        if (null != courtyardName.getId() && !"".equals(courtyardName.getId())) {
            CommonUtil.update(courtyardName);
            courtyardNameService.updateCourtyardName(courtyardName);
            return new Message(1, "新增成功！", null);
        }else{
            CommonUtil.save(courtyardName);
            courtyardNameService.saveCourtyardName(courtyardName);
            return new Message(1, "修改成功！", null);
        }
    }

    @RequestMapping("/courtyardname/toCourtyardNameEdit")
    public String toEditCourtyardName(String id, Model model) {
        model.addAttribute("data", courtyardNameService.getCourtyardNameById(id));
        model.addAttribute("head", "修改");
        return "/business/table/courtyardname/courtyardNameEdit";
    }

    @ResponseBody
    @RequestMapping("/courtyardname/delCourtyardName")
    public Message delCourtyardName(String id) {
        courtyardNameService.delCourtyardName(id);
        return new Message(0, "删除成功！", null);
    }

}
