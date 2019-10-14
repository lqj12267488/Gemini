package com.goisan.table.controller;

import com.goisan.table.bean.SchAward;
import com.goisan.table.service.SchAwardService;
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
public class SchAwardController {

    @Resource
    private SchAwardService schAwardService;

    @RequestMapping("/SchAward/toSchAwardList")
    public String toSchAwardList() {
        return "/business/table/schaward/schAwardList";
    }

    @ResponseBody
    @RequestMapping("/SchAward/getSchAwardList")
    public Map<String,Object> getSchAwardList(SchAward schAward,int draw, int start, int length) {
         PageHelper.startPage(start / length + 1, length);
         Map<String, Object> map = new HashMap(16);
         List<BaseBean> list =  schAwardService.getSchAwardList(schAward);
         PageInfo<List<BaseBean>> info = new PageInfo(list);
         map.put("draw", draw);
         map.put("recordsTotal", info.getTotal());
         map.put("recordsFiltered", info.getTotal());
         map.put("data", list);
        return map;
    }

    @RequestMapping("/SchAward/toSchAwardAdd")
    public String toAddSchAward(Model model) {
        model.addAttribute("head", "新增");
        return "/business/table/schaward/schAwardEdit";
    }

    @ResponseBody
    @RequestMapping("/SchAward/saveSchAward")
    public Message saveSchAward(SchAward schAward) {
        if (null != schAward.getId() && !"".equals(schAward.getId())) {
           CommonUtil.update(schAward);
            schAwardService.updateSchAward(schAward);
            return new Message(0, "修改成功！", null);
        } else {
            CommonUtil.save(schAward);
            schAwardService.saveSchAward(schAward);
            return new Message(0, "添加成功！", null);
        }
    }

    @RequestMapping("/SchAward/toSchAwardEdit")
    public String toEditSchAward(String id, Model model) {
        model.addAttribute("data", schAwardService.getSchAwardById(id));
        model.addAttribute("head", "修改");
        return "/business/table/schaward/schAwardEdit";
    }

    @ResponseBody
    @RequestMapping("/SchAward/delSchAward")
    public Message delSchAward(String id) {
        schAwardService.delSchAward(id);
        return new Message(0, "删除成功！", null);
    }

}
