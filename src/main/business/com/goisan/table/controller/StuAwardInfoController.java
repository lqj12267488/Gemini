package com.goisan.table.controller;

import com.goisan.table.bean.StuAwardInfo;
import com.goisan.table.service.StuAwardInfoService;
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
public class StuAwardInfoController {

    @Resource
    private StuAwardInfoService stuAwardInfoService;

    @RequestMapping("/StuAwardInfo/toStuAwardInfoList")
    public String toStuAwardInfoList() {
        return "/business/table/stuawardinfo/stuAwardInfoList";
    }

    @ResponseBody
    @RequestMapping("/StuAwardInfo/getStuAwardInfoList")
    public Map<String,Object> getStuAwardInfoList(StuAwardInfo stuAwardInfo,int draw, int start, int length) {
         PageHelper.startPage(start / length + 1, length);
         Map<String, Object> map = new HashMap(16);
         List<BaseBean> list =  stuAwardInfoService.getStuAwardInfoList(stuAwardInfo);
         PageInfo<List<BaseBean>> info = new PageInfo(list);
         map.put("draw", draw);
         map.put("recordsTotal", info.getTotal());
         map.put("recordsFiltered", info.getTotal());
         map.put("data", list);
        return map;
    }

    @RequestMapping("/StuAwardInfo/toStuAwardInfoAdd")
    public String toAddStuAwardInfo(Model model) {
        model.addAttribute("head", "新增");
        return "/business/table/stuawardinfo/stuAwardInfoEdit";
    }

    @ResponseBody
    @RequestMapping("/StuAwardInfo/saveStuAwardInfo")
    public Message saveStuAwardInfo(StuAwardInfo stuAwardInfo) {
        if (null != stuAwardInfo.getId() && !"".equals(stuAwardInfo.getId())) {
           CommonUtil.update(stuAwardInfo);
            stuAwardInfoService.updateStuAwardInfo(stuAwardInfo);
            return new Message(0, "修改成功！", null);
        } else {
            CommonUtil.save(stuAwardInfo);
            stuAwardInfoService.saveStuAwardInfo(stuAwardInfo);
            return new Message(0, "添加成功！", null);
        }
    }

    @RequestMapping("/StuAwardInfo/toStuAwardInfoEdit")
    public String toEditStuAwardInfo(String id, Model model) {
        model.addAttribute("data", stuAwardInfoService.getStuAwardInfoById(id));
        model.addAttribute("head", "修改");
        return "/business/table/stuawardinfo/stuAwardInfoEdit";
    }

    @ResponseBody
    @RequestMapping("/StuAwardInfo/delStuAwardInfo")
    public Message delStuAwardInfo(String id) {
        stuAwardInfoService.delStuAwardInfo(id);
        return new Message(0, "删除成功！", null);
    }

}
