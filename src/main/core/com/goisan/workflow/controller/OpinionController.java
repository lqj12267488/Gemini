package com.goisan.workflow.controller;

import com.goisan.workflow.bean.Opinion;
import com.goisan.workflow.service.OpinionService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.Map;

@Controller
@RequestMapping("/opinion")
public class OpinionController {

    @Resource
    private OpinionService opinionService;

    @RequestMapping("/toOpinionList")
    public String toList() {
        return "/core/wf/opinionList";
    }

    @ResponseBody
    @RequestMapping("/getOpinionList")
    public Map getList(Opinion opinion) {
        opinion.setCreator(CommonUtil.getPersonId());
        return CommonUtil.tableMap(opinionService.getOpinionList(opinion));
    }

    @RequestMapping("/toOpinionAdd")
    public String toAdd(Model model) {
        model.addAttribute("head", "新增");
        return "/core/wf/opinionEdit";
    }

    @ResponseBody
    @RequestMapping("/saveOpinion")
    public Message save(Opinion opinion) {
        if ("".equals(opinion.getOpinionId())) {
            opinion.setOpinionId(CommonUtil.getUUID());
            opinion.setOpinionType("2");
            CommonUtil.save(opinion);
            opinionService.saveOpinion(opinion);
            return new Message(0, "添加成功！", null);
        } else {
            CommonUtil.update(opinion);
            opinion.setOpinionType("2");
            opinionService.updateOpinion(opinion);
            return new Message(0, "修改成功！", null);
        }

    }

    @RequestMapping("/toOpinionEdit")
    public String toEdit(String id, Model model) {
        model.addAttribute("data", opinionService.getOpinionById(id));
        model.addAttribute("head", "修改");
        return "/core/wf/opinionEdit";
    }

    @ResponseBody
    @RequestMapping("/delOpinion")
    public Message del(String id) {
        opinionService.delOpinion(id);
        return new Message(0, "删除成功！", null);
    }

}
