package com.goisan.table.controller;

import com.goisan.table.bean.SchExpend;
import com.goisan.table.service.SchExpendService;
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
public class SchExpendController {

    @Resource
    private SchExpendService schExpendService;

    @RequestMapping("/SchExpend/toSchExpendList")
    public String toSchExpendList() {
        return "/business/table/schexpend/schExpendList";
    }

    @ResponseBody
    @RequestMapping("/SchExpend/getSchExpendList")
    public Map<String,Object> getSchExpendList(SchExpend schExpend,int draw, int start, int length) {
         PageHelper.startPage(start / length + 1, length);
         Map<String, Object> map = new HashMap(16);
         List<BaseBean> list =  schExpendService.getSchExpendList(schExpend);
         PageInfo<List<BaseBean>> info = new PageInfo(list);
         map.put("draw", draw);
         map.put("recordsTotal", info.getTotal());
         map.put("recordsFiltered", info.getTotal());
         map.put("data", list);
        return map;
    }

    @RequestMapping("/SchExpend/toSchExpendAdd")
    public String toAddSchExpend(Model model) {
        model.addAttribute("head", "新增");
        return "/business/table/schexpend/schExpendEdit";
    }

    @ResponseBody
    @RequestMapping("/SchExpend/saveSchExpend")
    public Message saveSchExpend(SchExpend schExpend) {
        if (null != schExpend.getId() && !"".equals(schExpend.getId())) {
           CommonUtil.update(schExpend);
            schExpendService.updateSchExpend(schExpend);
            return new Message(0, "修改成功！", null);
        } else {
            CommonUtil.save(schExpend);
            schExpendService.saveSchExpend(schExpend);
            return new Message(0, "添加成功！", null);
        }
    }

    @RequestMapping("/SchExpend/toSchExpendEdit")
    public String toEditSchExpend(String id, Model model) {
        model.addAttribute("data", schExpendService.getSchExpendById(id));
        model.addAttribute("head", "修改");
        return "/business/table/schexpend/schExpendEdit";
    }

    @ResponseBody
    @RequestMapping("/SchExpend/delSchExpend")
    public Message delSchExpend(String id) {
        schExpendService.delSchExpend(id);
        return new Message(0, "删除成功！", null);
    }

}
