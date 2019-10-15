package com.goisan.table.controller;

import com.goisan.table.bean.Associations;
import com.goisan.table.service.AssociationsService;
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
public class AssociationsController {

    @Resource
    private AssociationsService associationsService;

    @RequestMapping("/Associations/toAssociationsList")
    public String toAssociationsList() {
        return "/business/table/associations/associationsList";
    }

    @ResponseBody
    @RequestMapping("/Associations/getAssociationsList")
    public Map<String,Object> getAssociationsList(Associations associations,int draw, int start, int length) {
         PageHelper.startPage(start / length + 1, length);
         Map<String, Object> map = new HashMap(16);
         List<Associations> list =  associationsService.getAssociationsList(associations);
         PageInfo<List<BaseBean>> info = new PageInfo(list);
         map.put("draw", draw);
         map.put("recordsTotal", info.getTotal());
         map.put("recordsFiltered", info.getTotal());
         map.put("data", list);
        return map;
    }

    @RequestMapping("/Associations/toAssociationsAdd")
    public String toAddAssociations(Model model) {
        model.addAttribute("head", "新增");
        return "/business/table/associations/associationsEdit";
    }

    @ResponseBody
    @RequestMapping("/Associations/saveAssociations")
    public Message saveAssociations(Associations associations) {
        if (null != associations.getId() && !"".equals(associations.getId())) {
           CommonUtil.update(associations);
            associationsService.updateAssociations(associations);
            return new Message(0, "修改成功！", null);
        } else {
            CommonUtil.save(associations);
            associationsService.saveAssociations(associations);
            return new Message(0, "添加成功！", null);
        }
    }

    @RequestMapping("/Associations/toAssociationsEdit")
    public String toEditAssociations(String id, Model model) {
        Associations associations = associationsService.getAssociationsById(id);
        associations.setRegistrationdateStr(new SimpleDateFormat("yyyy-MM-dd").format(associations.getRegistrationdate()));
        model.addAttribute("data", associations);
        model.addAttribute("head", "修改");
        return "/business/table/associations/associationsEdit";
    }

    @ResponseBody
    @RequestMapping("/Associations/delAssociations")
    public Message delAssociations(String id) {
        associationsService.delAssociations(id);
        return new Message(0, "删除成功！", null);
    }

}
