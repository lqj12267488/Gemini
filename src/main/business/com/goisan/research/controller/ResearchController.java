package com.goisan.research.controller;

import com.goisan.research.bean.Research;
import com.goisan.research.service.ResearchService;
import com.goisan.staff.service.StaffService;
import com.goisan.system.bean.AutoComplete;
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
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
public class ResearchController {

    @Resource
    private ResearchService researchService;

    @Resource
    private StaffService staffService;

    @RequestMapping("/Research/toResearchList")
    public String toResearchList() {
        return "/business/research/researchList";
    }

    @ResponseBody
    @RequestMapping("/Research/getResearchList")
    public Map<String,Object> getResearchList(Research research,int draw, int start, int length) {
         PageHelper.startPage(start / length + 1, length);
         Map<String, Object> map = new HashMap(16);
         List<Research> list =  researchService.getResearchList(research);
         PageInfo<List<BaseBean>> info = new PageInfo(list);
        for (Research res : list) {
           res.setHorizontaltopic("0".equals(res.getHorizontaltopic())?"否":"是");
        }
         map.put("draw", draw);
         map.put("recordsTotal", info.getTotal());
         map.put("recordsFiltered", info.getTotal());
         map.put("data", list);
        return map;
    }

    @RequestMapping("/Research/toResearchAdd")
    public String toAddResearch(Model model) {
        model.addAttribute("head", "新增");
        return "/business/research/researchEdit";
    }

    @ResponseBody
    @RequestMapping("/Research/saveResearch")
    public Message saveResearch(Research research) {
        if (null != research.getId() && !"".equals(research.getId())) {
           CommonUtil.update(research);
            researchService.updateResearch(research);
            return new Message(0, "修改成功！", null);
        } else {
            CommonUtil.save(research);
            research.setPersonid(research.getPersonidvalue());
            researchService.saveResearch(research);
            return new Message(0, "添加成功！", null);
        }
    }

    @RequestMapping("/Research/toResearchEdit")
    public String toEditResearch(String id, Model model) {
        Research research =  researchService.selectResearchById(id);
        AutoComplete autoComplete =  staffService.getPersonDept(research.getPersonid());
        research.setPerson(autoComplete.getLabel());
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        String getDateStr = simpleDateFormat.format(research.getGetdate());
        String projectDateStr = simpleDateFormat.format(research.getProjectdate());
        research.setGetDateStr(getDateStr);
        research.setProjectDateStr(projectDateStr);
        model.addAttribute("data", research);
        model.addAttribute("head", "修改");
        return "/business/research/researchEdit";
    }

    @ResponseBody
    @RequestMapping("/Research/delResearch")
    public Message delResearch(String id) {
        researchService.delResearch(id);
        return new Message(0, "删除成功！", null);
    }

}
