package com.goisan.table.controller;

import com.goisan.table.bean.InformationPersonnel;
import com.goisan.table.service.InformationPersonnelService;
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
public class InformationPersonnelController {

    @Resource
    private InformationPersonnelService informationPersonnelService;

    @RequestMapping("/informationpersonnel/toInformationPersonnelList")
    public String toInformationPersonnelList() {
        return "/business/table/informationpersonnel/informationPersonnelList";
    }

    @ResponseBody
    @RequestMapping("/informationpersonnel/getInformationPersonnelList")
    public Map<String,Object> getInformationPersonnelList(InformationPersonnel informationPersonnel,int draw, int start, int length) {
         PageHelper.startPage(start / length + 1, length);
         Map<String, Object> map = new HashMap(16);
         List<BaseBean> list =  informationPersonnelService.getInformationPersonnelList(informationPersonnel);
         PageInfo<List<BaseBean>> info = new PageInfo(list);
         map.put("draw", draw);
         map.put("recordsTotal", info.getTotal());
         map.put("recordsFiltered", info.getTotal());
         map.put("data", list);
        return map;
    }

    @RequestMapping("/informationpersonnel/toInformationPersonnelAdd")
    public String toAddInformationPersonnel(Model model) {
        model.addAttribute("head", "新增");
        return "/business/table/informationpersonnel/informationPersonnelEdit";
    }

    @ResponseBody
    @RequestMapping("/informationpersonnel/saveInformationPersonnel")
    public Message saveInformationPersonnel(InformationPersonnel informationPersonnel) {
        if (null != informationPersonnel.getId() && !"".equals(informationPersonnel.getId())) {
           CommonUtil.update(informationPersonnel);
            informationPersonnelService.updateInformationPersonnel(informationPersonnel);
            return new Message(0, "修改成功！", null);
        } else {
            CommonUtil.save(informationPersonnel);
            informationPersonnelService.saveInformationPersonnel(informationPersonnel);
            return new Message(0, "添加成功！", null);
        }
    }

    @RequestMapping("/informationpersonnel/toInformationPersonnelEdit")
    public String toEditInformationPersonnel(String id, Model model) {
        model.addAttribute("data", informationPersonnelService.getInformationPersonnelById(id));
        model.addAttribute("head", "修改");
        return "/business/table/informationpersonnel/informationPersonnelEdit";
    }

    @ResponseBody
    @RequestMapping("/informationpersonnel/delInformationPersonnel")
    public Message delInformationPersonnel(String id) {
        informationPersonnelService.delInformationPersonnel(id);
        return new Message(0, "删除成功！", null);
    }

    @ResponseBody
    @RequestMapping("/informationpersonnel/checkYear")
    public Message informationpersonnelChecYear(InformationPersonnel informationPersonnel){
        List size = informationPersonnelService.checkYear(informationPersonnel);
        if(size.size()>0){
            return new Message(1, "年份重复，请重新选择！", null);
        }else{
            return new Message(0, "", null);
        }
    }
}
