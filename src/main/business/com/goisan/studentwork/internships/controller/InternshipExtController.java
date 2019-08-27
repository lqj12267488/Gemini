package com.goisan.studentwork.internships.controller;

import com.goisan.studentwork.internships.bean.InternshipExt;
import com.goisan.studentwork.internships.bean.Internships;
import com.goisan.studentwork.internships.service.InternshipExtService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
/*import com.sun.org.apache.xpath.internal.operations.Mod;*/
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by hanyu on 2017/8/1.
 */
@Controller
public class InternshipExtController {

    @Resource
    private InternshipExtService internshipExtService;
    @RequestMapping("/internshipExt/internshipsList")
    public ModelAndView internshipExt(){
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/studentwork/internships/internshipsList");
        return mv;
    }
    @RequestMapping("/internshipExt/internshipsList1")
    public String internshipExt1(Model model) {
        return "/business/studentwork/internships/internshipsList";
    }

   /**
     * 实习单位维护URL
     *  url by hanyue
     *  modify by hanyue
     * @param
     * @return
     */
    @ResponseBody
    @RequestMapping("/internshipExt/internshipExtActionById")
    public Map<String, List<InternshipExt>> internshipExtActionById(InternshipExt internshipExt) {
        Map<String, List<InternshipExt>> internshipExtMap = new HashMap<String, List<InternshipExt>>();
        internshipExtMap.put("data", internshipExtService.internshipExtActionById(internshipExt));
        return internshipExtMap;
    }
    @ResponseBody
    @RequestMapping("/internshipExt/InternshipExtAction")
    public Map<String, List<InternshipExt>> InternshipExtAction(InternshipExt internshipExt) {
        Map<String, List<InternshipExt>> internshipExtMap = new HashMap<String, List<InternshipExt>>();
        internshipExtMap.put("data", internshipExtService.InternshipExtAction(internshipExt));
        return internshipExtMap;
    }

    /**
     * 实习单位维护修改
     * update by hanyue
     * modify by hanyue
     * @param id
     * @return
     */

    @ResponseBody
    @RequestMapping("/internshipExt/getInternshipExtById")
    public ModelAndView getInternshipExtById(String id) {
        InternshipExt internshipExt = internshipExtService.getInternshipExtById(id);
        ModelAndView mv = new ModelAndView();
        mv.addObject("head", "修改");
        mv.addObject("internshipExt", internshipExt);
        mv.setViewName("/business/studentwork/internships/editInternshipExt");
        return mv;
    }
    @ResponseBody
    @RequestMapping("/internshipExt/getInternshipExtId")
    public ModelAndView getInternshipExtId(String id) {
        ModelAndView mv = new ModelAndView("/business/studentwork/internships/addInternshipExt");
        InternshipExt internshipExt = internshipExtService.getInternshipExtId(id);
        mv.addObject("head", "查看详情");
        mv.addObject("internshipExt", internshipExt);
        return mv;
    }
    /**
     * 实习单位维护新增
     * add by hanyue
     * modify by hanyue
     * @return
     */

    @ResponseBody
    @RequestMapping("/internshipExt/addInternshipExt")
    public ModelAndView addInternshipExt(String internshipUnitId) {
        InternshipExt internshipExt=internshipExtService.selectId(internshipUnitId);
        ModelAndView mv = new ModelAndView();
        mv.addObject("head", "新增申请");
        mv.addObject("internshipExt",internshipExt);
        mv.setViewName("/business/studentwork/internships/editInternshipExt");

        return mv;
    }
    /**
     * 删除实习单位
     * delete by hanyue
     * modify by hanyue
     * @param id
     * @return
     */

    @ResponseBody
    @RequestMapping("/internshipExt/deleteInternshipExtById")
    public Message deleteInternshipExtById(String id) {
        internshipExtService.deleteInternshipExtById(id);
        return new Message(1, "删除成功！", null);
    }
    /**
     * 保存实习单位
     * save by hanyue
     * modify by hanyue
     * @param internshipExt
     * @return
     */

    @ResponseBody
    @RequestMapping("/internshipExt/saveInternshipExt")
    public Message saveInternshipExt(InternshipExt internshipExt){
        if(internshipExt.getId()==null || internshipExt.getId().equals("")){
            internshipExt.setCreator(CommonUtil.getPersonId());
            internshipExt.setCreateDept(CommonUtil.getDefaultDept());
            internshipExtService.insertInternshipExt(internshipExt);
            return new Message(1, "新增成功！", null);
        }else{
            internshipExt.setChanger(CommonUtil.getPersonId());
            internshipExt.setChangeDept(CommonUtil.getDefaultDept());
            internshipExtService.updateInternshipExtById(internshipExt);
            return new Message(1, "修改成功！", null);
        }
    }
}
