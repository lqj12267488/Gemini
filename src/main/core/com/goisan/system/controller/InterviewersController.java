package com.goisan.system.controller;

import com.goisan.system.bean.Interviewers;
import com.goisan.system.service.InterviewersService;
import com.goisan.system.service.ParameterService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class InterviewersController {
    @Resource
    private InterviewersService interviewersService;
    @Resource
    private ParameterService parameterService;
    /**
     * 面试人员首页跳转
     * @return
     */
    @RequestMapping("/interviewers/interviewersList")
    public ModelAndView interviewersList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/core/interviewers/interviewersList");
        return mv;
    }

    /**
     * 面试人员首页查询数据
     * @param interviewers
     * @return
     */
    @ResponseBody
    @RequestMapping("/interviewers/getInterviewersList")
    public Map<String, List<Interviewers>> getInterviewersList(Interviewers interviewers) {
        Map<String, List<Interviewers>> softInstallMap = new HashMap<String, List<Interviewers>>();
        softInstallMap.put("data", interviewersService.interviewersAction(interviewers));
        return softInstallMap;
    }

    /**
     * 新增面试人员
     * @return
     */
    @ResponseBody
    @RequestMapping("/interviewers/addInterviewers")
    public ModelAndView addInterviewersInstall() {
        ModelAndView mv = new ModelAndView("/core/interviewers/editInterviewers");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        String date = formatDate.format(new Date());
        Interviewers interviewers=new Interviewers();
        interviewers.setTerm(parameterService.getParameterValue());
        mv.addObject("head", "新增面试人员");
        mv.addObject("interviewers",interviewers);
        return mv;
    }

    /**
     * 面试人员修改跳转
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/interviewers/getInterviewersById")
    public ModelAndView getInterviewersById(String id) {
        ModelAndView mv = new ModelAndView("/core/interviewers/editInterviewers");
        Interviewers interviewers = interviewersService.getInterviewersById(id);
        mv.addObject("head", "面试人员修改");
        mv.addObject("interviewers", interviewers);
        return mv;
    }

    /**
     * 新增和修改保存
     * @param interviewers
     * @return
     */
    @ResponseBody
    @RequestMapping("/interviewers/saveInterviewers")
    public Message saveinterviewers(Interviewers interviewers){
        if(null == interviewers.getId() || "".equals(interviewers.getId())){
            interviewers.setCreator(CommonUtil.getPersonId());
            interviewers.setCreateDept(CommonUtil.getDefaultDept());
            interviewersService.insertInterviewers(interviewers);
            return new Message(1, "新增成功！", null);
        }else{
            interviewers.setChanger(CommonUtil.getPersonId());
            interviewers.setChangeDept(CommonUtil.getDefaultDept());
            interviewersService.updateInterviewersById(interviewers);
            return new Message(1, "修改成功！", null);
        }
    }

    /**
     * 删除
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/interviewers/deleteInterviewersById")
    public Message deleteInterviewersById(String id) {
        interviewersService.deleteInterviewersById(id);
        return new Message(1, "删除成功！", null);
    }


    /**
     * 面试人员查看
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/interviewers/searchDetils")
    public ModelAndView searchDetils(String id) {
        ModelAndView mv = new ModelAndView("/core/interviewers/searchDetils");
        Interviewers interviewers = interviewersService.getInterviewersById(id);
        mv.addObject("head", "查看");
        mv.addObject("interviewers", interviewers);
        return mv;
    }
}
