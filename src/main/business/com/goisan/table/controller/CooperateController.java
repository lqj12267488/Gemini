package com.goisan.table.controller;

import com.goisan.table.bean.Cooperate;
import com.goisan.table.service.CooperateService;
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
public class CooperateController {

    @Resource
    private CooperateService cooperateService;

    @RequestMapping("/cooperate/toCooperateList")
    public String toCooperateList() {
        return "/business/table/cooperate/cooperateList";
    }

    @ResponseBody
    @RequestMapping("/cooperate/getCooperateList")
    public Map<String,Object> getCooperateList(Cooperate cooperate,int draw, int start, int length) {
         PageHelper.startPage(start / length + 1, length);
         Map<String, Object> map = new HashMap(16);
         List<BaseBean> list =  cooperateService.getCooperateList(cooperate);
         PageInfo<List<BaseBean>> info = new PageInfo(list);
         map.put("draw", draw);
         map.put("recordsTotal", info.getTotal());
         map.put("recordsFiltered", info.getTotal());
         map.put("data", list);
        return map;
    }

    @RequestMapping("/cooperate/toCooperateAdd")
    public String toAddCooperate(Model model) {
        model.addAttribute("head", "新增");
        return "/business/table/cooperate/cooperateEdit";
    }

    @ResponseBody
    @RequestMapping("/cooperate/saveCooperate")
    public Message saveCooperate(Cooperate cooperate) {
        if (null != cooperate.getId() && !"".equals(cooperate.getId())) {
           CommonUtil.update(cooperate);
            cooperateService.updateCooperate(cooperate);
            return new Message(0, "修改成功！", null);
        } else {
            CommonUtil.save(cooperate);
            cooperateService.saveCooperate(cooperate);
            return new Message(0, "添加成功！", null);
        }
    }

    @RequestMapping("/cooperate/toCooperateEdit")
    public String toEditCooperate(String id, Model model) {
        Cooperate cooperate = cooperateService.getCooperateById(id);
        cooperate.setBusiness1starttimeStr(new SimpleDateFormat("yyyy-MM-dd").format(cooperate.getBusiness1starttime()));
        cooperate.setBusiness2starttimeStr(new SimpleDateFormat("yyyy-MM-dd").format(cooperate.getBusiness2starttime()));
        cooperate.setBusiness3starttimeStr(new SimpleDateFormat("yyyy-MM-dd").format(cooperate.getBusiness3starttime()));
        cooperate.setBusiness4starttimeStr(new SimpleDateFormat("yyyy-MM-dd").format(cooperate.getBusiness4starttime()));
        cooperate.setBusiness5starttimeStr(new SimpleDateFormat("yyyy-MM-dd").format(cooperate.getBusiness5starttime()));
        model.addAttribute("data", cooperate);
        model.addAttribute("head", "修改");
        return "/business/table/cooperate/cooperateEdit";
    }

    @ResponseBody
    @RequestMapping("/cooperate/delCooperate")
    public Message delCooperate(String id) {
        cooperateService.delCooperate(id);
        return new Message(0, "删除成功！", null);
    }


    @RequestMapping("/cooperate/selectMajorName")
    @ResponseBody
    public List<String> selectMajorName(){
       return cooperateService.selectMajorName();
    }

}
