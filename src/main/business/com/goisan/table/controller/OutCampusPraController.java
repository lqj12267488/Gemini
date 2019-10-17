package com.goisan.table.controller;

import com.goisan.table.bean.OutCampusPra;
import com.goisan.table.service.OutCampusPraService;
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
public class OutCampusPraController {

    @Resource
    private OutCampusPraService outCampusPraService;

    @RequestMapping("/OutCampusPra/toOutCampusPraList")
    public String toOutCampusPraList() {
        return "/business/table/outcampuspra/outCampusPraList";
    }

    @ResponseBody
    @RequestMapping("/OutCampusPra/getOutCampusPraList")
    public Map<String,Object> getOutCampusPraList(OutCampusPra outCampusPra,int draw, int start, int length) {
         PageHelper.startPage(start / length + 1, length);
         Map<String, Object> map = new HashMap(16);
         List<BaseBean> list =  outCampusPraService.getOutCampusPraList(outCampusPra);
         PageInfo<List<BaseBean>> info = new PageInfo(list);
         map.put("draw", draw);
         map.put("recordsTotal", info.getTotal());
         map.put("recordsFiltered", info.getTotal());
         map.put("data", list);
        return map;
    }

    @RequestMapping("/OutCampusPra/toOutCampusPraAdd")
    public String toAddOutCampusPra(Model model) {
        model.addAttribute("head", "新增");
        return "/business/table/outcampuspra/outCampusPraEdit";
    }

    @ResponseBody
    @RequestMapping("/OutCampusPra/saveOutCampusPra")
    public Message saveOutCampusPra(OutCampusPra outCampusPra) {
        if (null != outCampusPra.getId() && !"".equals(outCampusPra.getId())) {
           CommonUtil.update(outCampusPra);
            outCampusPraService.updateOutCampusPra(outCampusPra);
            return new Message(0, "修改成功！", null);
        } else {
            CommonUtil.save(outCampusPra);
            outCampusPraService.saveOutCampusPra(outCampusPra);
            return new Message(0, "添加成功！", null);
        }
    }

    @RequestMapping("/OutCampusPra/toOutCampusPraEdit")
    public String toEditOutCampusPra(String id,String seeFlag, Model model) {
        model.addAttribute("data", outCampusPraService.getOutCampusPraById(id));
        if (StringUtils.isEmpty(seeFlag)){
            model.addAttribute("head", "修改");
        }else {
            model.addAttribute("head", "详情");
        }
        model.addAttribute("seeFlag", seeFlag);
        return "/business/table/outcampuspra/outCampusPraEdit";
    }

    @ResponseBody
    @RequestMapping("/OutCampusPra/delOutCampusPra")
    public Message delOutCampusPra(String id) {
        outCampusPraService.delOutCampusPra(id);
        return new Message(0, "删除成功！", null);
    }

}
