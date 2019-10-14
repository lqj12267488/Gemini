package com.goisan.table.controller;

import com.goisan.table.bean.ProEvaAgency;
import com.goisan.table.service.ProEvaAgencyService;
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
public class ProEvaAgencyController {

    @Resource
    private ProEvaAgencyService proEvaAgencyService;

    @RequestMapping("/ProEvaAgency/toProEvaAgencyList")
    public String toProEvaAgencyList() {
        return "/business/table/proevaagency/proEvaAgencyList";
    }

    @ResponseBody
    @RequestMapping("/ProEvaAgency/getProEvaAgencyList")
    public Map<String,Object> getProEvaAgencyList(ProEvaAgency proEvaAgency,int draw, int start, int length) {
         PageHelper.startPage(start / length + 1, length);
         Map<String, Object> map = new HashMap(16);
         List<BaseBean> list =  proEvaAgencyService.getProEvaAgencyList(proEvaAgency);
         PageInfo<List<BaseBean>> info = new PageInfo(list);
         map.put("draw", draw);
         map.put("recordsTotal", info.getTotal());
         map.put("recordsFiltered", info.getTotal());
         map.put("data", list);
        return map;
    }

    @RequestMapping("/ProEvaAgency/toProEvaAgencyAdd")
    public String toAddProEvaAgency(Model model) {
        model.addAttribute("head", "新增");
        return "/business/table/proevaagency/proEvaAgencyEdit";
    }

    @ResponseBody
    @RequestMapping("/ProEvaAgency/saveProEvaAgency")
    public Message saveProEvaAgency(ProEvaAgency proEvaAgency) {
        if (null != proEvaAgency.getId() && !"".equals(proEvaAgency.getId())) {
           CommonUtil.update(proEvaAgency);
            proEvaAgencyService.updateProEvaAgency(proEvaAgency);
            return new Message(0, "修改成功！", null);
        } else {
            CommonUtil.save(proEvaAgency);
            proEvaAgencyService.saveProEvaAgency(proEvaAgency);
            return new Message(0, "添加成功！", null);
        }
    }

    @RequestMapping("/ProEvaAgency/toProEvaAgencyEdit")
    public String toEditProEvaAgency(String id, Model model) {
        model.addAttribute("data", proEvaAgencyService.getProEvaAgencyById(id));
        model.addAttribute("head", "修改");
        return "/business/table/proevaagency/proEvaAgencyEdit";
    }

    @ResponseBody
    @RequestMapping("/ProEvaAgency/delProEvaAgency")
    public Message delProEvaAgency(String id) {
        proEvaAgencyService.delProEvaAgency(id);
        return new Message(0, "删除成功！", null);
    }

}
