package com.goisan.table.controller;

import com.goisan.table.bean.Programme;
import com.goisan.table.service.ProgrammeService;
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
public class ProgrammeController {

    @Resource
    private ProgrammeService programmeService;

    @RequestMapping("/Programme/toProgrammeList")
    public String toProgrammeList() {
        return "/business/table/programme/programmeList";
    }

    @ResponseBody
    @RequestMapping("/Programme/getProgrammeList")
    public Map<String,Object> getProgrammeList(Programme programme,int draw, int start, int length) {
         PageHelper.startPage(start / length + 1, length);
         Map<String, Object> map = new HashMap(16);
         List<BaseBean> list =  programmeService.getProgrammeList(programme);
         PageInfo<List<BaseBean>> info = new PageInfo(list);
         map.put("draw", draw);
         map.put("recordsTotal", info.getTotal());
         map.put("recordsFiltered", info.getTotal());
         map.put("data", list);
        return map;
    }

    @RequestMapping("/Programme/toProgrammeAdd")
    public String toAddProgramme(Model model) {
        model.addAttribute("head", "新增");
        return "/business/table/programme/programmeEdit";
    }

    @ResponseBody
    @RequestMapping("/Programme/saveProgramme")
    public Message saveProgramme(Programme programme) {
        if (null != programme.getId() && !"".equals(programme.getId())) {
           CommonUtil.update(programme);
            programmeService.updateProgramme(programme);
            return new Message(0, "修改成功！", null);
        } else {
            CommonUtil.save(programme);
            programmeService.saveProgramme(programme);
            return new Message(0, "添加成功！", null);
        }
    }

    @RequestMapping("/Programme/toProgrammeEdit")
    public String toEditProgramme(String id, Model model) {
        Programme programme = programmeService.getProgrammeById(id);
        programme.setRatifydateStr(new SimpleDateFormat("yyyy-MM-dd").format(programme.getRatifydate()));

        model.addAttribute("data", programme);
        model.addAttribute("head", "修改");
        return "/business/table/programme/programmeEdit";
    }

    @ResponseBody
    @RequestMapping("/Programme/delProgramme")
    public Message delProgramme(String id) {
        programmeService.delProgramme(id);
        return new Message(0, "删除成功！", null);
    }

}
