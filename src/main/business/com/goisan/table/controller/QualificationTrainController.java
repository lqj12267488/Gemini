package com.goisan.table.controller;

import com.goisan.table.bean.QualificationTrain;
import com.goisan.table.service.QualificationTrainService;
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
public class QualificationTrainController {

    @Resource
    private QualificationTrainService qualificationTrainService;

    @RequestMapping("/qualificationtrain/toQualificationTrainList")
    public String toQualificationTrainList() {
        return "/business/table/qualificationtrain/qualificationTrainList";
    }

    @ResponseBody
    @RequestMapping("/qualificationtrain/getQualificationTrainList")
    public Map<String,Object> getQualificationTrainList(QualificationTrain qualificationTrain,int draw, int start, int length) {
         PageHelper.startPage(start / length + 1, length);
         Map<String, Object> map = new HashMap(16);
         List<BaseBean> list =  qualificationTrainService.getQualificationTrainList(qualificationTrain);
         PageInfo<List<BaseBean>> info = new PageInfo(list);
         map.put("draw", draw);
         map.put("recordsTotal", info.getTotal());
         map.put("recordsFiltered", info.getTotal());
         map.put("data", list);
        return map;
    }

    @RequestMapping("/qualificationtrain/toQualificationTrainAdd")
    public String toAddQualificationTrain(Model model) {
        model.addAttribute("head", "新增");
        return "/business/table/qualificationtrain/qualificationTrainEdit";
    }

    @ResponseBody
    @RequestMapping("/qualificationtrain/saveQualificationTrain")
    public Message saveQualificationTrain(QualificationTrain qualificationTrain) {
        if (null != qualificationTrain.getId() && !"".equals(qualificationTrain.getId())) {
           CommonUtil.update(qualificationTrain);
            qualificationTrainService.updateQualificationTrain(qualificationTrain);
            return new Message(0, "修改成功！", null);
        } else {
            CommonUtil.save(qualificationTrain);
            qualificationTrainService.saveQualificationTrain(qualificationTrain);
            return new Message(0, "添加成功！", null);
        }
    }

    @RequestMapping("/qualificationtrain/toQualificationTrainEdit")
    public String toEditQualificationTrain(String id, Model model) {
        model.addAttribute("data", qualificationTrainService.getQualificationTrainById(id));
        model.addAttribute("head", "修改");
        return "/business/table/qualificationtrain/qualificationTrainEdit";
    }

    @ResponseBody
    @RequestMapping("/qualificationtrain/delQualificationTrain")
    public Message delQualificationTrain(String id) {
        qualificationTrainService.delQualificationTrain(id);
        return new Message(0, "删除成功！", null);
    }

}
