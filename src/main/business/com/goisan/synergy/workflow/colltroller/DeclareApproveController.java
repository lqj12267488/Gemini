package com.goisan.synergy.workflow.colltroller;

import com.goisan.synergy.workflow.bean.Declare;
import com.goisan.synergy.workflow.bean.DeclareApprove;
import com.goisan.synergy.workflow.service.DeclareApproveService;
import com.goisan.synergy.workflow.service.DeclareService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class DeclareApproveController {
    @Resource
    private DeclareApproveService declareApproveService;


    /**
     * 审批申请跳转
     * request by hanyue
     * modify by hanyue
     *
     * @return
     */
    @RequestMapping("/declareApprove/request")
    public ModelAndView declareApproveList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/declareApprove/declareApprove");
        return mv;
    }

    /**
     * 审批申请URL
     * url by hanyue
     * modify by hanyue
     *
     * @param declareApprove
     * @return
     */
    @ResponseBody
    @RequestMapping("/declareApprove/getDeclareApproveList")
    public Map<String, List<DeclareApprove>> getDeclareApproveList(DeclareApprove declareApprove) {
        Map<String, List<DeclareApprove>> declareApproveMap = new HashMap<String, List<DeclareApprove>>();
        declareApprove.setCreator(CommonUtil.getPersonId());
        declareApprove.setCreateDept(CommonUtil.getDefaultDept());
        declareApproveMap.put("data", declareApproveService.getDeclareApproveList(declareApprove));
        return declareApproveMap;
    }

    /**
     * 查看申报详情
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/declareApprove/auditLeaveById")
    public ModelAndView waitById(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/declareApprove/selectDeclare");
        DeclareApprove declareApprove = declareApproveService.getLeaveById(id);
        mv.addObject("head", "查看详情");
        mv.addObject("declareApprove", declareApprove);
        return mv;
    }



//待办跳转
    @RequestMapping("/declareApprove/process")
    public ModelAndView declareApproveProcess() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/declareApprove/declareApproveProcess");
        return mv;
    }

//待办初始化
    @ResponseBody
    @RequestMapping("/declareApprove/getProcessList")
    public Map<String, List<DeclareApprove>> getProcessList(DeclareApprove declareApprove) {
        Map<String, List<DeclareApprove>> declareApproveMap = new HashMap<String, List<DeclareApprove>>();
        declareApprove.setCreator(CommonUtil.getPersonId());
        declareApprove.setCreateDept(CommonUtil.getDefaultDept());
        declareApprove.setChanger(CommonUtil.getPersonId());
        declareApprove.setChangeDept(CommonUtil.getDefaultDept());
        declareApproveMap.put("data", declareApproveService.getProcessList(declareApprove));
        return declareApproveMap;
    }
//已办页面跳转
    @RequestMapping("/declareApprove/complete")
    public ModelAndView declareApproveComplete() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/declareApprove/declareApproveComplete");
        return mv;
    }
//已办初始化
    @ResponseBody
    @RequestMapping("/declareApprove/getCompleteList")
    public Map<String, List<DeclareApprove>> getCompleteList(DeclareApprove declareApprove) {
        Map<String, List<DeclareApprove>> declareApproveMap = new HashMap<String, List<DeclareApprove>>();
        declareApprove.setCreator(CommonUtil.getPersonId());
        declareApprove.setCreateDept(CommonUtil.getDefaultDept());
        declareApprove.setChanger(CommonUtil.getPersonId());
        declareApprove.setChangeDept(CommonUtil.getDefaultDept());
        declareApproveMap.put("data", declareApproveService.getCompleteList(declareApprove));
        return declareApproveMap;
    }
//查看流程轨迹
    @ResponseBody
    @RequestMapping("/declareApprove/auditDeclareApproveById")
    public ModelAndView waitRoleById(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/declareApprove/addDeclareApproveProcess");
        DeclareApprove declareApprove = declareApproveService.getCancelById(id);
        mv.addObject("head", "审批");
        mv.addObject("declareApprove", declareApprove);
        return mv;
    }

}
























