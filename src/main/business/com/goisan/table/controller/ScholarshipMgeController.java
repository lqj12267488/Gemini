package com.goisan.table.controller;

import com.goisan.table.bean.ScholarshipMge;
import com.goisan.table.service.ScholarshipMgeService;
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
public class ScholarshipMgeController {

    @Resource
    private ScholarshipMgeService scholarshipMgeService;

    @RequestMapping("/ScholarshipMge/toScholarshipMgeList")
    public String toScholarshipMgeList() {
        return "/business/table/scholarshipmge/scholarshipMgeList";
    }

    @ResponseBody
    @RequestMapping("/ScholarshipMge/getScholarshipMgeList")
    public Map<String,Object> getScholarshipMgeList(ScholarshipMge scholarshipMge,int draw, int start, int length) {
         PageHelper.startPage(start / length + 1, length);
         Map<String, Object> map = new HashMap(16);
         List<BaseBean> list =  scholarshipMgeService.getScholarshipMgeList(scholarshipMge);
         PageInfo<List<BaseBean>> info = new PageInfo(list);
         map.put("draw", draw);
         map.put("recordsTotal", info.getTotal());
         map.put("recordsFiltered", info.getTotal());
         map.put("data", list);
        return map;
    }

    @RequestMapping("/ScholarshipMge/toScholarshipMgeAdd")
    public String toAddScholarshipMge(Model model) {
        model.addAttribute("head", "新增");
        return "/business/table/scholarshipmge/scholarshipMgeEdit";
    }

    @ResponseBody
    @RequestMapping("/ScholarshipMge/saveScholarshipMge")
    public Message saveScholarshipMge(ScholarshipMge scholarshipMge) {
        if (null != scholarshipMge.getId() && !"".equals(scholarshipMge.getId())) {
           CommonUtil.update(scholarshipMge);
            scholarshipMgeService.updateScholarshipMge(scholarshipMge);
            return new Message(0, "修改成功！", null);
        } else {
            CommonUtil.save(scholarshipMge);
            scholarshipMgeService.saveScholarshipMge(scholarshipMge);
            return new Message(0, "添加成功！", null);
        }
    }

    @RequestMapping("/ScholarshipMge/toScholarshipMgeEdit")
    public String toEditScholarshipMge(String id, Model model) {
        model.addAttribute("data", scholarshipMgeService.getScholarshipMgeById(id));
        model.addAttribute("head", "修改");
        return "/business/table/scholarshipmge/scholarshipMgeEdit";
    }

    @ResponseBody
    @RequestMapping("/ScholarshipMge/delScholarshipMge")
    public Message delScholarshipMge(String id) {
        scholarshipMgeService.delScholarshipMge(id);
        return new Message(0, "删除成功！", null);
    }

}
