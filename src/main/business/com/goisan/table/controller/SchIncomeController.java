package com.goisan.table.controller;

import com.goisan.table.bean.SchIncome;
import com.goisan.table.service.SchIncomeService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.system.bean.BaseBean;

import javax.annotation.Resource;
import java.util.*;

@Controller
public class SchIncomeController {

    @Resource
    private SchIncomeService schIncomeService;

    @RequestMapping("/SchIncome/toSchIncomeList")
    public String toSchIncomeList() {
        return "/business/table/schincome/schIncomeList";
    }

    @ResponseBody
    @RequestMapping("/SchIncome/getSchIncomeList")
    public Map<String,Object> getSchIncomeList(SchIncome schIncome,int draw, int start, int length) {
         PageHelper.startPage(start / length + 1, length);
         Map<String, Object> map = new HashMap(16);
         List<BaseBean> list =  schIncomeService.getSchIncomeList(schIncome);
         PageInfo<List<BaseBean>> info = new PageInfo(list);
         map.put("draw", draw);
         map.put("recordsTotal", info.getTotal());
         map.put("recordsFiltered", info.getTotal());
         map.put("data", list);
        return map;
    }

    @RequestMapping("/SchIncome/toSchIncomeAdd")
    public String toAddSchIncome(Model model) {
        model.addAttribute("head", "新增");
        return "/business/table/schincome/schIncomeEdit";
    }

    @ResponseBody
    @RequestMapping("/SchIncome/saveSchIncome")
    public Message saveSchIncome(SchIncome schIncome) {
        if (null != schIncome.getId() && !"".equals(schIncome.getId())) {
           CommonUtil.update(schIncome);
            schIncomeService.updateSchIncome(schIncome);
            return new Message(0, "修改成功！", null);
        } else {
            CommonUtil.save(schIncome);
            schIncomeService.saveSchIncome(schIncome);
            return new Message(0, "添加成功！", null);
        }
    }

    @RequestMapping("/SchIncome/toSchIncomeEdit")
    public String toEditSchIncome(String id, String seeFlag, Model model) {
        model.addAttribute("data", schIncomeService.getSchIncomeById(id));
        if (StringUtils.isEmpty(seeFlag)){
            model.addAttribute("head", "修改");
        }else {
            model.addAttribute("head", "详情");
        }
        model.addAttribute("seeFlag", seeFlag);
        return "/business/table/schincome/schIncomeEdit";
    }

    @ResponseBody
    @RequestMapping("/SchIncome/delSchIncome")
    public Message delSchIncome(String id) {
        schIncomeService.delSchIncome(id);
        return new Message(0, "删除成功！", null);
    }

}
