package com.goisan.studentwork.maintenance.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.studentwork.graduatearchivesaddress.bean.Arcad;
import com.goisan.studentwork.maintenance.bean.MtType;
import com.goisan.studentwork.maintenance.service.MtTypeService;
import com.goisan.system.bean.Student;
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
 * Created  By hanjie ON 2019/9/2
 */
@Controller
public class MtTypeController {

    @Autowired
    private MtTypeService mtTypeService;

    @RequestMapping("/mtType/mtTypeList")
    public ModelAndView mtTypeList(){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("/business/studentwork/maintenance/typeList");
        return modelAndView;
    }

    @ResponseBody
    @RequestMapping("/mtType/getMtTypeList")
    public Map<String,Object> getMtTypeList(MtType mtType, int draw, int start, int length){
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> map = new HashMap();
        List<MtType> list = mtTypeService.getMtTypeList(mtType);
        PageInfo<List<MtType>> info = new PageInfo(list);
        map.put("draw", draw);
        map.put("recordsTotal", info.getTotal());
        map.put("recordsFiltered", info.getTotal());
        map.put("data", list);
        return map;
    }

    @RequestMapping("/mtType/editMtType")
    public ModelAndView editMtType(MtType mtType){
        ModelAndView modelAndView = new ModelAndView();
        if (!"".equals(mtType.getMtId())&&null!=mtType.getMtId()){
            MtType mtTypeEdit = mtTypeService.getMtTypeById(mtType);
            modelAndView.addObject("head", "修改");
            modelAndView.addObject("mtTypeEdit", mtTypeEdit);
        }else {
            modelAndView.addObject("head", "新增");
        }
        modelAndView.setViewName("/business/studentwork/maintenance/editMtType");
        return modelAndView;
    }

    @ResponseBody
    @RequestMapping("/mtType/delMtType")
    public Message delMtType(MtType mtType){
        mtTypeService.delMtTypeById(mtType);
        return new Message(1,"删除成功","success");
    }

    @ResponseBody
    @RequestMapping("/mtType/saveMtType")
    public Message saveMtType(MtType mtType){
        if (!"".equals(mtType.getMtId())&&null!=mtType.getMtId()){
            mtTypeService.updateMtTypeById(mtType);
            return new Message(1,"修改成功",null);
        }else {
//            检查是否详情是否存在
            mtTypeService.insertMtType(mtType);
            return  new Message(1,"新增成功",null);
        }
    }

}
