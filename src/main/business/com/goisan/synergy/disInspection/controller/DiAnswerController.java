package com.goisan.synergy.disInspection.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.studentwork.maintenance.bean.MtType;
import com.goisan.synergy.disInspection.bean.DiAnswer;
import com.goisan.synergy.disInspection.bean.DiRemark;
import com.goisan.synergy.disInspection.service.DiAnswerService;
import com.goisan.system.bean.Files;
import com.goisan.system.service.FilesService;
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
 * Created  By hanjie ON 2019/9/5
 */
@Controller
public class DiAnswerController {

    @Autowired
    private DiAnswerService diAnswerService;

    @Autowired
    private FilesService filesService;


    @RequestMapping("/diAnswer/diAnswerList")
    public ModelAndView diAnswerList(){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("/business/synergy/disInspection/diAnswerList");
        return modelAndView;
    }


    @ResponseBody
    @RequestMapping("/diAnswer/getDiAnswerList")
    public Map<String,Object> getDiAnswerList(DiAnswer diAnswer, int draw, int start, int length){
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> map = new HashMap();
        List<DiAnswer> list = diAnswerService.getDiAnswerList(diAnswer);
        PageInfo<List<MtType>> info = new PageInfo(list);
        map.put("draw", draw);
        map.put("recordsTotal", info.getTotal());
        map.put("recordsFiltered", info.getTotal());
        map.put("data", list);
        return map;
    }

    @RequestMapping("/diAnswer/editDiAnswer")
    public ModelAndView editDiAnswer(DiAnswer diAnswer,String flag){
        ModelAndView modelAndView = new ModelAndView();
        DiAnswer diAnswerEdit;
        if ("1".equals(flag)) {
            diAnswerEdit = diAnswerService.getDiAnswerByAnswerId(diAnswer);
        }else {
            diAnswerEdit = diAnswerService.getDiAnswerByRemarkId(diAnswer);
        }
        modelAndView.addObject("head", "回复");
        modelAndView.addObject("diAnswerEdit", diAnswerEdit);
        modelAndView.setViewName("/business/synergy/disInspection/editDiAnswer");
        return modelAndView;
    }

    @ResponseBody
    @RequestMapping("/diAnswer/saveDiAnswer")
    public Message saveDiAnswer(DiAnswer diAnswer){
        diAnswerService.insertDiAnswer(diAnswer);
        return  new Message(1,"回复成功",null);
    }

    @RequestMapping("/diAnswer/seefile")
    public ModelAndView filesUpload(String businessId, String tableName, String businessType) {
        ModelAndView mv = new ModelAndView("/business/synergy/disInspection/seeFile");
        List<Files> files = filesService.getFilesByBusinessId(businessId);
        mv.addObject("head", "查看附件");
        mv.addObject("businessId", businessId);
        mv.addObject("tableName", tableName);
        mv.addObject("businessType", businessType);
        mv.addObject("files", files);
        return mv;
    }



}
