package com.goisan.table.controller;

import com.goisan.table.bean.InCampusPra;
import com.goisan.table.service.InCampusPraService;
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
public class InCampusPraController {

    @Resource
    private InCampusPraService inCampusPraService;

    @RequestMapping("/InCampusPra/toInCampusPraList")
    public String toInCampusPraList() {
        return "/business/table/incampuspra/inCampusPraList";
    }

    @ResponseBody
    @RequestMapping("/InCampusPra/getInCampusPraList")
    public Map<String,Object> getInCampusPraList(InCampusPra inCampusPra,int draw, int start, int length) {
         PageHelper.startPage(start / length + 1, length);
         Map<String, Object> map = new HashMap(16);
         List<BaseBean> list =  inCampusPraService.getInCampusPraList(inCampusPra);
         PageInfo<List<BaseBean>> info = new PageInfo(list);
         map.put("draw", draw);
         map.put("recordsTotal", info.getTotal());
         map.put("recordsFiltered", info.getTotal());
         map.put("data", list);
        return map;
    }

    @RequestMapping("/InCampusPra/toInCampusPraAdd")
    public String toAddInCampusPra(Model model) {
        model.addAttribute("head", "新增");
        return "/business/table/incampuspra/inCampusPraEdit";
    }

    @ResponseBody
    @RequestMapping("/InCampusPra/saveInCampusPra")
    public Message saveInCampusPra(InCampusPra inCampusPra) {
        if (null != inCampusPra.getId() && !"".equals(inCampusPra.getId())) {
           CommonUtil.update(inCampusPra);
            inCampusPraService.updateInCampusPra(inCampusPra);
            return new Message(0, "修改成功！", null);
        } else {
            CommonUtil.save(inCampusPra);
            inCampusPraService.saveInCampusPra(inCampusPra);
            return new Message(0, "添加成功！", null);
        }
    }

    @RequestMapping("/InCampusPra/toInCampusPraEdit")
    public String toEditInCampusPra(String id, Model model) {
        model.addAttribute("data", inCampusPraService.getInCampusPraById(id));
        model.addAttribute("head", "修改");
        return "/business/table/incampuspra/inCampusPraEdit";
    }

    @ResponseBody
    @RequestMapping("/InCampusPra/delInCampusPra")
    public Message delInCampusPra(String id) {
        inCampusPraService.delInCampusPra(id);
        return new Message(0, "删除成功！", null);
    }

}
