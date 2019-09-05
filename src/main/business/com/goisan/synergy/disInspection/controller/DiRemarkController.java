package com.goisan.synergy.disInspection.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.studentwork.maintenance.bean.MtType;
import com.goisan.synergy.disInspection.bean.DiAnswer;
import com.goisan.synergy.disInspection.bean.DiRemark;
import com.goisan.synergy.disInspection.service.DiAnswerService;
import com.goisan.synergy.disInspection.service.DiRemarkService;
import com.goisan.system.tools.Message;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created  By hanjie ON 2019/9/4
 */
@Controller
public class DiRemarkController {

    @Autowired
    private DiRemarkService diRemarkService;

    @Autowired
    private DiAnswerService diAnswerService;

    @RequestMapping("/diRemark/diRemarkList")
    public ModelAndView diRemarkList(){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("/business/synergy/disInspection/diRemarkList");
        return modelAndView;
    }

    @ResponseBody
    @RequestMapping("/diRemark/getDiRemarkList")
    public Map<String,Object> getDiRemarkList(DiRemark diRemark, int draw, int start, int length){
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> map = new HashMap();
        List<DiRemark> list = diRemarkService.getDiRemarkList(diRemark);
        PageInfo<List<MtType>> info = new PageInfo(list);
        map.put("draw", draw);
        map.put("recordsTotal", info.getTotal());
        map.put("recordsFiltered", info.getTotal());
        map.put("data", list);
        return map;
    }


    @RequestMapping("/diRemark/editDiRemark")
    public ModelAndView editDiRemark(DiRemark diRemark){
        ModelAndView modelAndView = new ModelAndView();
        if (!"".equals(diRemark.getRemarkId())&&null!=diRemark.getRemarkId()){
            DiRemark diRemarkEdit = diRemarkService.getDiRemarkById(diRemark.getRemarkId());
            modelAndView.addObject("head", "修改");
            modelAndView.addObject("diRemarkEdit", diRemarkEdit);
        }else {
            modelAndView.addObject("head", "新增");
        }
        modelAndView.setViewName("/business/synergy/disInspection/editDiRemark");
        return modelAndView;
    }


    @ResponseBody
    @RequestMapping("/diRemark/delDiRemark")
    public Message delDiRemark(DiRemark diRemark){
        diRemarkService.delDiRemarkById(diRemark);
        return new Message(1,"删除成功","success");
    }

    @ResponseBody
    @RequestMapping("/diRemark/saveDiRemark")
    public Message saveDiRemark(DiRemark diRemark){
        if (!"".equals(diRemark.getRemarkId())&&null!=diRemark.getRemarkId()){
            diRemarkService.updateArcadById(diRemark);
            return new Message(1,"修改成功",null);
        }else {
//            检查是否详情是否存在
            diRemarkService.insertDiRemark(diRemark);
            return  new Message(1,"新增成功",null);
        }
    }

    @RequestMapping("/diRemark/diReAnsList")
    public ModelAndView diReAnsList(String remarkId) {
        ModelAndView mv = new ModelAndView("/business/synergy/disInspection/diReAnsList");
        mv.addObject("remarkId",remarkId);
        return mv;
    }


    @ResponseBody
    @RequestMapping("/diRemark/getDiReAnsList")
    public Map<String,Object> getDiReAnsList(DiAnswer diAnswer, int draw, int start, int length){
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> map = new HashMap();
        List<DiAnswer> list = diAnswerService.getDiReAnsList(diAnswer);
        PageInfo<List<MtType>> info = new PageInfo(list);
        map.put("draw", draw);
        map.put("recordsTotal", info.getTotal());
        map.put("recordsFiltered", info.getTotal());
        map.put("data", list);
        return map;
    }

}
