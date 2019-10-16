package com.goisan.table.controller;

import com.goisan.table.bean.RedCross;
import com.goisan.table.service.RedCrossService;
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
public class RedCrossController {

    @Resource
    private RedCrossService redCrossService;

    @RequestMapping("/redcross/toRedCrossList")
    public String toRedCrossList() {
        return "/business/table/redCross/redCrossList";
    }

    @ResponseBody
    @RequestMapping("/redcross/getRedCrossList")
    public Map<String,Object> getRedCrossList(RedCross redCross,int draw, int start, int length) {
         PageHelper.startPage(start / length + 1, length);
         Map<String, Object> map = new HashMap(16);
         List<BaseBean> list =  redCrossService.getRedCrossList(redCross);
         PageInfo<List<BaseBean>> info = new PageInfo(list);
         map.put("draw", draw);
         map.put("recordsTotal", info.getTotal());
         map.put("recordsFiltered", info.getTotal());
         map.put("data", list);
        return map;
    }

    @RequestMapping("/redcross/toRedCrossAdd")
    public String toAddRedCross(Model model) {
        model.addAttribute("head", "新增");
        return "/business/table/redCross/redCrossEdit";
    }

    @ResponseBody
    @RequestMapping("/redcross/saveRedCross")
    public Message saveRedCross(RedCross redCross) {
        if (null != redCross.getId() && !"".equals(redCross.getId())) {
           CommonUtil.update(redCross);
            redCrossService.updateRedCross(redCross);
            return new Message(0, "修改成功！", null);
        } else {
            CommonUtil.save(redCross);
            String id = redCrossService.saveRedCross(redCross);
            return new Message(0, "添加成功！", id);
        }
    }

    @RequestMapping("/redcross/toRedCrossEdit")
    public String toEditRedCross(String id, Model model) {
        model.addAttribute("data", redCrossService.getRedCrossById(id));
        model.addAttribute("head", "修改");
        return "/business/table/redCross/redCrossEdit";
    }

    @ResponseBody
    @RequestMapping("/redcross/delRedCross")
    public Message delRedCross(String id) {
        redCrossService.delRedCross(id);
        return new Message(0, "删除成功！", null);
    }


    @ResponseBody
    @RequestMapping("/redcross/selectRedCross")
    public RedCross selectRedCross(){
        RedCross redCross = redCrossService.selectRedCross();
        return redCross;
    }

}
