package com.goisan.table.controller;

import com.goisan.table.bean.GeneralConstruction;
import com.goisan.table.service.GeneralConstructionService;
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
public class GeneralConstructionController {

    @Resource
    private GeneralConstructionService generalConstructionService;

    @RequestMapping("/generalconstruction/toGeneralConstructionList")
    public String toGeneralConstructionList() {
        return "/business/table/generalconstruction/generalConstructionList";
    }

    @ResponseBody
    @RequestMapping("/generalconstruction/getGeneralConstructionList")
    public Map<String,Object> getGeneralConstructionList(GeneralConstruction generalConstruction,int draw, int start, int length) {
         PageHelper.startPage(start / length + 1, length);
         Map<String, Object> map = new HashMap(16);
         List<BaseBean> list =  generalConstructionService.getGeneralConstructionList(generalConstruction);
         PageInfo<List<BaseBean>> info = new PageInfo(list);
         map.put("draw", draw);
         map.put("recordsTotal", info.getTotal());
         map.put("recordsFiltered", info.getTotal());
         map.put("data", list);
        return map;
    }

    @RequestMapping("/generalconstruction/toGeneralConstructionAdd")
    public String toAddGeneralConstruction(Model model) {
        model.addAttribute("head", "新增");
        return "/business/table/generalconstruction/generalConstructionEdit";
    }

    @ResponseBody
    @RequestMapping("/generalconstruction/saveGeneralConstruction")
    public Message saveGeneralConstruction(GeneralConstruction generalConstruction) {
        if (null != generalConstruction.getId() && !"".equals(generalConstruction.getId())) {
           CommonUtil.update(generalConstruction);
            generalConstructionService.updateGeneralConstruction(generalConstruction);
            return new Message(0, "修改成功！", null);
        } else {
            CommonUtil.save(generalConstruction);
            generalConstructionService.saveGeneralConstruction(generalConstruction);
            return new Message(0, "添加成功！", null);
        }
    }

    @RequestMapping("/generalconstruction/toGeneralConstructionEdit")
    public String toEditGeneralConstruction(String id, Model model,String flag) {
        model.addAttribute("data", generalConstructionService.getGeneralConstructionById(id));
        model.addAttribute("head", "修改");
        if (flag!=null){
            if (flag.equals("on")||flag=="on"){
                model.addAttribute("head","详情信息");
                model.addAttribute("flag",flag);
            }
        }
        return "/business/table/generalconstruction/generalConstructionEdit";
    }

    @ResponseBody
    @RequestMapping("/generalconstruction/delGeneralConstruction")
    public Message delGeneralConstruction(String id) {
        generalConstructionService.delGeneralConstruction(id);
        return new Message(0, "删除成功！", null);
    }

}
