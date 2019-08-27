package com.goisan.educational.teachingplan.controller;

import com.goisan.educational.teachingplan.bean.TeachingPlanDetail;
import com.goisan.educational.teachingplan.service.TeachingPlanDetailService;
import com.goisan.educational.teachingplan.service.TeachingPlanService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.Map;

@Controller
@RequestMapping("/teachingPlanDetail")
public class TeachingPlanDetailController {

    @Resource
    private TeachingPlanDetailService teachingPlanDetailService;
    @Resource
    private TeachingPlanService teachingPlanService;

    @RequestMapping("/toList")
    public String toList(String planId, Model model, String planName) {
        model.addAttribute("planId", planId);
        model.addAttribute("planName",planName);
        return "/business/educational/teachingPlan/teachingPlanDetailList";
    }

    @ResponseBody
    @RequestMapping("/getList")
    public Map getList(TeachingPlanDetail teachingPlanDetail) {
        return CommonUtil.tableMap(teachingPlanDetailService.selectList(teachingPlanDetail));
    }

    @RequestMapping("/toAdd")
    public String toAdd(String planId, Model model) {
        model.addAttribute("head", "新增");
        model.addAttribute("data", teachingPlanDetailService.getPlanName(planId));
        return "/business/educational/teachingPlan/teachingPlanDetailEdit";
    }

    @ResponseBody
    @RequestMapping("/save")
    public Message save(TeachingPlanDetail teachingPlanDetail) {
        if (teachingPlanDetail.getId() == "") {
            teachingPlanDetail.setId(CommonUtil.getUUID());
            CommonUtil.save(teachingPlanDetail);
            teachingPlanDetailService.save(teachingPlanDetail);
            return new Message(0, "添加成功！", null);
        } else {
            CommonUtil.update(teachingPlanDetail);
            teachingPlanDetailService.update(teachingPlanDetail);
            return new Message(0, "修改成功！", null);
        }

    }

    @RequestMapping("/toEdit")
    public String toEdit(String id, Model model) {
        model.addAttribute("data", teachingPlanDetailService.selectById(id));
        model.addAttribute("head", "修改");
        return "/business/educational/teachingPlan/teachingPlanDetailEdit";
    }

    @ResponseBody
    @RequestMapping("/del")
    public Message del(String id) {
        teachingPlanDetailService.del(id);
        return new Message(0, "删除成功！", null);
    }

}
