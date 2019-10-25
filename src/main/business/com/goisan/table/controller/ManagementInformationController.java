package com.goisan.table.controller;

import com.goisan.table.bean.MachineClassroom;
import com.goisan.table.bean.ManagementInformation;
import com.goisan.table.service.ManagementInformationService;
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
public class ManagementInformationController {

    @Resource
    private ManagementInformationService managementInformationService;

    @RequestMapping("/managementinformation/toManagementInformationList")
    public String toManagementInformationList() {
        return "/business/table/managementinformation/managementInformationList";
    }

    @ResponseBody
    @RequestMapping("/managementinformation/getManagementInformationList")
    public Map<String,Object> getManagementInformationList(ManagementInformation managementInformation,int draw, int start, int length) {
         PageHelper.startPage(start / length + 1, length);
         Map<String, Object> map = new HashMap(16);
         List<BaseBean> list =  managementInformationService.getManagementInformationList(managementInformation);
         PageInfo<List<BaseBean>> info = new PageInfo(list);
         map.put("draw", draw);
         map.put("recordsTotal", info.getTotal());
         map.put("recordsFiltered", info.getTotal());
         map.put("data", list);
        return map;
    }

    @RequestMapping("/managementinformation/toManagementInformationAdd")
    public String toAddManagementInformation(Model model) {
        model.addAttribute("head", "新增");
        return "/business/table/managementinformation/managementInformationEdit";
    }

    @ResponseBody
    @RequestMapping("/managementinformation/saveManagementInformation")
    public Message saveManagementInformation(ManagementInformation managementInformation) {
        if (null != managementInformation.getId() && !"".equals(managementInformation.getId())) {
           CommonUtil.update(managementInformation);
            managementInformationService.updateManagementInformation(managementInformation);
            return new Message(0, "修改成功！", null);
        } else {
            CommonUtil.save(managementInformation);
            managementInformationService.saveManagementInformation(managementInformation);
            return new Message(0, "添加成功！", null);
        }
    }

    @RequestMapping("/managementinformation/toManagementInformationEdit")
    public String toEditManagementInformation(String id, Model model) {
        model.addAttribute("data", managementInformationService.getManagementInformationById(id));
        model.addAttribute("head", "修改");
        return "/business/table/managementinformation/managementInformationEdit";
    }

    @ResponseBody
    @RequestMapping("/managementinformation/delManagementInformation")
    public Message delManagementInformation(String id) {
        managementInformationService.delManagementInformation(id);
        return new Message(0, "删除成功！", null);
    }
    @ResponseBody
    @RequestMapping("/managementinformation/checkYear")
    public Message managementinformationCheckYear(ManagementInformation managementInformation){
        List size = managementInformationService.checkYear(managementInformation);
        if(size.size()>0){
            return new Message(1, "年份重复，请重新选择！", null);
        }else{
            return new Message(0, "", null);
        }
    }
}
