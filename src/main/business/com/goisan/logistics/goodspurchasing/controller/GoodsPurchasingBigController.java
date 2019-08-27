package com.goisan.logistics.goodspurchasing.controller;

import com.goisan.logistics.goodspurchasing.bean.GoodsPurchasingBig;
import com.goisan.logistics.goodspurchasing.service.GoodsPurchasingBigService;
import com.goisan.synergy.workflow.service.StampService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import com.goisan.workflow.bean.Handle;
import com.goisan.workflow.service.WorkflowService;
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

/**
 * Created by Administrator on 2017/7/31.
 */

@Controller
@RequestMapping("/goodsPurchasingBig")
public class GoodsPurchasingBigController {
    @Resource
    GoodsPurchasingBigService goodsPurchasingBigService;
    @Resource
    private WorkflowService workflowService;
    @Resource
    private StampService stampService;
    /**
     * 宣传稿件投递申请首页跳转
     */

    @RequestMapping("/goodsPurchasingBigList")
    public ModelAndView goodsPurchasingBigList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/logistics/goodspurchasingbig/goodsPurchasingBigList");
        return mv;
    }

    /**
     * 管理页面
     */

    @ResponseBody
    @RequestMapping("/getGoodsPurchasingBigList")
    public Map<String, List<GoodsPurchasingBig>> getGoodsPurchasingBigList(GoodsPurchasingBig goodsPurchasingBig) {
        Map<String, List<GoodsPurchasingBig>> goodsPurchasingBigMap = new HashMap<String, List<GoodsPurchasingBig>>();
        goodsPurchasingBig.setCreator(CommonUtil.getPersonId());
        goodsPurchasingBig.setCreateDept(CommonUtil.getDefaultDept());
        goodsPurchasingBigMap.put("data", goodsPurchasingBigService.goodsPurchasingBigAction(goodsPurchasingBig));
        return goodsPurchasingBigMap;
    }

    /**
     * 新增页面
     */

    @RequestMapping("/editGoodsPurchasingBig")
    public ModelAndView addGoodsPurchasingBig() {
        ModelAndView mv = new ModelAndView("/business/logistics/goodspurchasingbig/editGoodsPurchasingBig");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String dateTime = date + 'T' + time;
        GoodsPurchasingBig goodsPurchasingBig = new GoodsPurchasingBig();
        goodsPurchasingBig.setRequestDate(dateTime);
        String personName = goodsPurchasingBigService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = goodsPurchasingBigService.getDeptNameById(CommonUtil.getDefaultDept());
        goodsPurchasingBig.setRequester(personName);
        goodsPurchasingBig.setRequestDept(deptName);
        mv.addObject("head", "新增申请");
        mv.addObject("goodsPurchasingBig", goodsPurchasingBig);
        return mv;
    }

    /**
     * 修改页面
     */

    @ResponseBody
    @RequestMapping("/getGoodsPurchasingBigById")
    public ModelAndView getGoodsPurchasingBigById(String id) {
        ModelAndView mv = new ModelAndView("/business/logistics/goodspurchasingbig/editGoodsPurchasingBig");
        GoodsPurchasingBig goodsPurchasingBig = goodsPurchasingBigService.getGoodsPurchasingBigById(id);
        mv.addObject("head", "物品采购申请修改");
        mv.addObject("goodsPurchasingBig", goodsPurchasingBig);
        return mv;
    }

    /**
     * 新增及修改
     */

    @ResponseBody
    @RequestMapping("/saveGoodsPurchasingBig")
    public Message saveGoodsPurchasingBig(GoodsPurchasingBig goodsPurchasingBig) {
        goodsPurchasingBig.setCreateTime(CommonUtil.getDate());
        if (goodsPurchasingBig.getId() == null || goodsPurchasingBig.getId().equals("")) {
            goodsPurchasingBig.setCreator(CommonUtil.getPersonId());
            goodsPurchasingBig.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
            goodsPurchasingBig.setId(CommonUtil.getUUID());
            goodsPurchasingBig.setRequester(CommonUtil.getPersonId());
            goodsPurchasingBig.setRequestDept(CommonUtil.getDefaultDept());
            goodsPurchasingBigService.insertGoodsPurchasingBig(goodsPurchasingBig);
            return new Message(1, "新增成功!", null);
        } else {
            goodsPurchasingBig.setRequester(CommonUtil.getPersonId());
            goodsPurchasingBig.setRequestDept(CommonUtil.getDefaultDept());
            goodsPurchasingBig.setChanger(CommonUtil.getPersonId());
            goodsPurchasingBig.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
            goodsPurchasingBigService.updateGoodsPurchasingBig(goodsPurchasingBig);
            return new Message(1, "修改成功!", null);
        }
    }

    /**
     * 删除方法
     */

    @ResponseBody
    @RequestMapping("/deleteGoodsPurchasingBigById")
    public Message deleteRoleById(String id) {
        goodsPurchasingBigService.deleteGoodsPurchasingBigById(id);
        return new Message(1, "删除成功!", null);
    }

    /**
     * 获取部门自动完成框
     */

    @ResponseBody
    @RequestMapping("/getDept")
    public List<AutoComplete> getDept() {
        return goodsPurchasingBigService.selectDept();
    }

    /**
     * 获取人员自动完成框
     */

    @ResponseBody
    @RequestMapping("/getPerson")
    public List<AutoComplete> getPerson() {
        return goodsPurchasingBigService.selectPerson();
    }

    //待办业务跳转
    @RequestMapping("/process")
    public ModelAndView goodsPurchasingBigListProcess() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/logistics/goodspurchasingbig/goodsPurchasingBigProcess");
        return mv;
    }

    /**
     * 待办页
     */

    @ResponseBody
    @RequestMapping("/getGoodsPurchasingBigListProcess")
    public Map<String, List<GoodsPurchasingBig>> getGoodsPurchasingBigListProcess(GoodsPurchasingBig goodsPurchasingBig) {
        Map<String, List<GoodsPurchasingBig>> goodsPurchasingBigMap = new HashMap<String, List<GoodsPurchasingBig>>();
        if ("%%".equals(goodsPurchasingBig.getRequestDept())) {
            goodsPurchasingBig.setRequestDept(null);
        }
        if ("%%".equals(goodsPurchasingBig.getRequester())) {
            goodsPurchasingBig.setRequester(null);
        }
        goodsPurchasingBig.setCreator(CommonUtil.getPersonId());
        goodsPurchasingBig.setCreateDept(CommonUtil.getDefaultDept());
        goodsPurchasingBig.setChanger(CommonUtil.getPersonId());
        goodsPurchasingBig.setChangeDept(CommonUtil.getDefaultDept());
        goodsPurchasingBigMap.put("data", goodsPurchasingBigService.getGoodsPurchasingBigListProcess(goodsPurchasingBig));
        return goodsPurchasingBigMap;
    }

    //已办业务跳转
    @RequestMapping("/complete")
    public ModelAndView goodsPurchasingBigListComplete() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/logistics/goodspurchasingbig/goodsPurchasingBigComplete");
        return mv;
    }

    /**
     * 已办页
     */

    @ResponseBody
    @RequestMapping("/getGoodsPurchasingBigListComplete")
    public Map<String, List<GoodsPurchasingBig>> getGoodsPurchasingBigListComplete(GoodsPurchasingBig goodsPurchasingBig) {
        Map<String, List<GoodsPurchasingBig>> goodsPurchasingBigMap = new HashMap<String, List<GoodsPurchasingBig>>();
        goodsPurchasingBig.setCreator(CommonUtil.getPersonId());
        goodsPurchasingBig.setCreateDept(CommonUtil.getDefaultDept());
        goodsPurchasingBig.setChanger(CommonUtil.getPersonId());
        goodsPurchasingBig.setChangeDept(CommonUtil.getDefaultDept());
        goodsPurchasingBigMap.put("data", goodsPurchasingBigService.getGoodsPurchasingBigListComplete(goodsPurchasingBig));
        return goodsPurchasingBigMap;
    }

    //待办修改
    @ResponseBody
    @RequestMapping("/auditGoodsPurchasingBigEdit")
    public ModelAndView auditGoodsPurchasingBigEdit(String id) {
        ModelAndView mv = new ModelAndView("/business/logistics/goodspurchasingbig/editGoodsPurchasingBigProcess");
        GoodsPurchasingBig goodsPurchasingBig = goodsPurchasingBigService.getGoodsPurchasingBigById(id);
        mv.addObject("head", "修改");
        mv.addObject("goodsPurchasingBig", goodsPurchasingBig);
        return mv;
    }

    //查看流程轨迹
    @ResponseBody
    @RequestMapping("/auditGoodsPurchasingBigById")
    public ModelAndView waitRoleById(String id) {
        ModelAndView mv = new ModelAndView("/business/logistics/goodspurchasingbig/auditGoodsPurchasingBig");
        GoodsPurchasingBig goodsPurchasingBig = goodsPurchasingBigService.getGoodsPurchasingBigById(id);
        mv.addObject("head", "审批");
        mv.addObject("goodsPurchasingBig", goodsPurchasingBig);
        return mv;
    }

    /**
     * PC端打印
     */

    @ResponseBody
    @RequestMapping("/printGoodsPurchasingBig")
    public ModelAndView printGoodsPurchasingBig(String id) {
        ModelAndView mv = new ModelAndView("/business/logistics/goodspurchasingbig/printGoodsPurchasingBig");
        GoodsPurchasingBig goodsPurchasingBig = goodsPurchasingBigService.getGoodsPurchasingBigById(id);
        String workflowName = "";
        if ( goodsPurchasingBig.getBudget() < 5) {
            workflowName = workflowService.getWorkflowNameByWorkflowCode("T_ZW_GOODSPURCHASINGBIG_WF02");
        }
        if (5 < goodsPurchasingBig.getBudget()) {
            workflowName = workflowService.getWorkflowNameByWorkflowCode("T_ZW_GOODSPURCHASINGBIG_WF01");
        }
        String state = stampService.getStateById(id);
        List<Handle> list= stampService.getHandlebyId(id);
        int size=list.size();
        mv.addObject("handleList", list);
        mv.addObject("size",size);
        mv.addObject("state",state);
        String requestDate = goodsPurchasingBig.getRequestDate().replace("T", " ");
        mv.addObject("requestDate", requestDate);
        mv.addObject("goodsPurchasingBig", goodsPurchasingBig);
        mv.addObject("workflowName", workflowName);
        return mv;
    }
}
