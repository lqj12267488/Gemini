package com.goisan.logistics.goodspurchasing.controller;

import com.goisan.logistics.assets.bean.Assets;
import com.goisan.logistics.assets.service.AssetsService;
import com.goisan.logistics.goodspurchasing.bean.GoodsPurchasing;
import com.goisan.logistics.goodspurchasing.service.GoodsPurchasingService;
import com.goisan.synergy.workflow.service.StampService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.Tree;
import com.goisan.system.bean.UserDic;
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
import java.util.*;

/**
 * Created by Administrator on 2017/7/31.
 */
@Controller
@RequestMapping("/goodsPurchasing")
public class GoodsPurchasingController {
    @Resource
    GoodsPurchasingService goodsPurchasingService;
    @Resource
    private WorkflowService workflowService;
    @Resource
    private StampService stampService;
    @Resource
    private AssetsService assetsService;


    /**
     * 宣传稿件投递申请首页跳转
     */
    @RequestMapping("/goodsPurchasingList")
    public ModelAndView goodsPurchasingList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/logistics/goodspurchasing/goodsPurchasingList");
        return mv;
    }

    /*@ResponseBody
    @RequestMapping("/getMajorClassTree")
    public List<Tree> getMajorClassTree() {
        List<Tree> a = goodsPurchasingService.getMajorClassTree();
        return a;
    }

    @ResponseBody
    @RequestMapping("/getGoodsPurchasingTree")
    public List<Tree> getDeptAndPersonTree(String roleId) {
        List<Tree> trees = goodsPurchasingService.getGoodsPurchasingTree(roleId);
        return trees;
    }*/

    /**
     * 管理页面
     */
    @ResponseBody
    @RequestMapping("/getGoodsPurchasingList")
    public Map<String, List<GoodsPurchasing>> getGoodsPurchasingList(GoodsPurchasing goodsPurchasing) {
        Map<String, List<GoodsPurchasing>> goodsPurchasingMap = new HashMap<String, List<GoodsPurchasing>>();
        goodsPurchasing.setCreator(CommonUtil.getPersonId());
        goodsPurchasing.setCreateDept(CommonUtil.getDefaultDept());
        goodsPurchasingMap.put("data", goodsPurchasingService.goodsPurchasingAction(goodsPurchasing));
        return goodsPurchasingMap;
    }

    /**
     * 新增关联跳转页面
     * @param id
     * @param type
     * @return
     */
    @RequestMapping("/funds2/relationRequest")
    public ModelAndView toRelationFunds(String id,String type) {
        ModelAndView mv = new ModelAndView();
        String flag = workflowService.getRejectState("T_ZW_GOODSPURCHASING_WF", id, CommonUtil
                .getPersonId());
        if ("1".equals(flag)){
            flag = "1";
        }else{
            flag = "0";
        }
        if((type .equals("1")  && flag .equals("1") ) || type .equals("2") ){
            mv.setViewName("/business/logistics/goodspurchasing/relationFundsUnEdit");
        }else{
            mv.setViewName("/business/logistics/goodspurchasing/relationFunds");
        }
        mv.addObject("flag",flag);
        mv.addObject("id", id);
        mv.addObject("type",type);
        return mv;
    }

    @RequestMapping("/funds2/getWorkflowList")
    public ModelAndView getSignList(String id) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/logistics/goodspurchasing/completeList");
        mv.addObject("id", id);
        return mv;
    }

    /**
     * 新增页面
     */
    @RequestMapping("/editGoodsPurchasing")
    public ModelAndView addGoodsPurchasing() {
        ModelAndView mv = new ModelAndView("/business/logistics/goodspurchasing/editGoodsPurchasing");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String dateTime = date + 'T' + time;
        GoodsPurchasing goodsPurchasing = new GoodsPurchasing();
        goodsPurchasing.setRequestDate(dateTime);
        String personName = goodsPurchasingService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = goodsPurchasingService.getDeptNameById(CommonUtil.getDefaultDept());
        goodsPurchasing.setRequester(personName);
        goodsPurchasing.setRequestDept(deptName);
        mv.addObject("head", "新增申请");
        mv.addObject("goodsPurchasing", goodsPurchasing);
        return mv;
    }

    /**
     * 修改页面
     */
    @ResponseBody
    @RequestMapping("/getGoodsPurchasingById")
    public ModelAndView getGoodsPurchasingById(String id) {
        ModelAndView mv = new ModelAndView("/business/logistics/goodspurchasing/editGoodsPurchasing");
        GoodsPurchasing goodsPurchasing = goodsPurchasingService.getGoodsPurchasingById(id);
        mv.addObject("head", "物品采购申请修改");
        mv.addObject("goodsPurchasing", goodsPurchasing);
        return mv;
    }

    /**
     * 新增及修改
     */
    @ResponseBody
    @RequestMapping("/saveGoodsPurchasing")
    public Message saveGoodsPurchasing(GoodsPurchasing goodsPurchasing) {
        goodsPurchasing.setCreateTime(CommonUtil.getDate());
        if (goodsPurchasing.getId() == null || goodsPurchasing.getId().equals("")) {
            goodsPurchasing.setCreator(CommonUtil.getPersonId());
            goodsPurchasing.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
            goodsPurchasing.setId(CommonUtil.getUUID());
            goodsPurchasing.setRequester(CommonUtil.getPersonId());
            goodsPurchasing.setRequestDept(CommonUtil.getDefaultDept());
            goodsPurchasingService.insertGoodsPurchasing(goodsPurchasing);
            return new Message(1, "新增成功!", null);
        } else {
            goodsPurchasing.setRequester(CommonUtil.getPersonId());
            goodsPurchasing.setRequestDept(CommonUtil.getDefaultDept());
            goodsPurchasing.setChanger(CommonUtil.getPersonId());
            goodsPurchasing.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
            goodsPurchasingService.updateGoodsPurchasing(goodsPurchasing);
            return new Message(1, "修改成功!", null);
        }
    }

    /**
     * 删除方法
     */
    @ResponseBody
    @RequestMapping("/deleteGoodsPurchasingById")
    public Message deleteRoleById(String id) {
        goodsPurchasingService.deleteGoodsPurchasingById(id);
        return new Message(1, "删除成功!", null);
    }

    /**
     * 获取部门自动完成框
     */
    @ResponseBody
    @RequestMapping("/getDept")
    public List<AutoComplete> getDept() {
        return goodsPurchasingService.selectDept();
    }

    /**
     * 获取人员自动完成框
     */
    @ResponseBody
    @RequestMapping("/getPerson")
    public List<AutoComplete> getPerson() {
        return goodsPurchasingService.selectPerson();
    }

    //待办业务跳转
    @RequestMapping("/process")
    public ModelAndView goodsPurchasingListProcess() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/logistics/goodspurchasing/goodsPurchasingProcess");
        return mv;
    }

    /**
     * 待办页
     */
    @ResponseBody
    @RequestMapping("/getGoodsPurchasingListProcess")
    public Map<String, List<GoodsPurchasing>> getGoodsPurchasingListProcess(GoodsPurchasing goodsPurchasing) {
        Map<String, List<GoodsPurchasing>> goodsPurchasingMap = new HashMap<String, List<GoodsPurchasing>>();
        if ("%%".equals(goodsPurchasing.getRequestDept())) {
            goodsPurchasing.setRequestDept(null);
        }
        if ("%%".equals(goodsPurchasing.getRequester())) {
            goodsPurchasing.setRequester(null);
        }
        goodsPurchasing.setCreator(CommonUtil.getPersonId());
        goodsPurchasing.setCreateDept(CommonUtil.getDefaultDept());
        goodsPurchasing.setChanger(CommonUtil.getPersonId());
        goodsPurchasing.setChangeDept(CommonUtil.getDefaultDept());
        goodsPurchasingMap.put("data", goodsPurchasingService.getGoodsPurchasingListProcess(goodsPurchasing));
        return goodsPurchasingMap;
    }

    /**
     * 已办业务跳转*/
    @RequestMapping("/complete")
    public ModelAndView goodsPurchasingListComplete() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/logistics/goodspurchasing/goodsPurchasingComplete");
        return mv;
    }

    /**
     * 字段查重
     */
    @ResponseBody
    @RequestMapping("/checkName")
    public Message checkName(String id){
        Assets assets = assetsService.getAssetsById(id);
        if(assets != null ){
            return new Message(1, "名称重复，请重新填写！", null);
        }else{
            return new Message(0, "", null);
        }
    }

    /**
     * 已办页
     */
    @ResponseBody
    @RequestMapping("/getGoodsPurchasingListComplete")
    public Map<String, List<GoodsPurchasing>> getGoodsPurchasingListComplete(GoodsPurchasing goodsPurchasing) {
        Map<String, List<GoodsPurchasing>> goodsPurchasingMap = new HashMap<String, List<GoodsPurchasing>>();
        goodsPurchasing.setCreator(CommonUtil.getPersonId());
        goodsPurchasing.setCreateDept(CommonUtil.getDefaultDept());
        goodsPurchasing.setChanger(CommonUtil.getPersonId());
        goodsPurchasing.setChangeDept(CommonUtil.getDefaultDept());
        goodsPurchasingMap.put("data", goodsPurchasingService.getGoodsPurchasingListComplete(goodsPurchasing));
        return goodsPurchasingMap;
    }

    //待办修改
    @ResponseBody
    @RequestMapping("/auditGoodsPurchasingEdit")
    public ModelAndView auditGoodsPurchasingEdit(String id) {
        ModelAndView mv = new ModelAndView("/business/logistics/goodspurchasing/editGoodsPurchasingProcess");
        GoodsPurchasing goodsPurchasing = goodsPurchasingService.getGoodsPurchasingById(id);
        mv.addObject("head", "修改");
        mv.addObject("goodsPurchasing", goodsPurchasing);
        return mv;
    }

    //查看流程轨迹
    @ResponseBody
    @RequestMapping("/auditGoodsPurchasingById")
    public ModelAndView waitRoleById(String id) {
        ModelAndView mv = new ModelAndView("/business/logistics/goodspurchasing/auditGoodsPurchasing");
        GoodsPurchasing goodsPurchasing = goodsPurchasingService.getGoodsPurchasingById(id);
        mv.addObject("head", "审批");
        mv.addObject("goodsPurchasing", goodsPurchasing);
        return mv;
    }

    /**
     * PC端打印
     */
    @ResponseBody
    @RequestMapping("/printGoodsPurchasing")
    public ModelAndView printGoodsPurchasing(String id) {
        ModelAndView mv = new ModelAndView("/business/logistics/goodspurchasing/printGoodsPurchasing");
        GoodsPurchasing goodsPurchasing = goodsPurchasingService.getGoodsPurchasingById(id);
        String workflowName = "";
        if (0.5 > goodsPurchasing.getBudget()) {
            workflowName = workflowService.getWorkflowNameByWorkflowCode("T_ZW_GOODSPURCHASING_WF01");
        }
        if (0.5 <= goodsPurchasing.getBudget() && goodsPurchasing.getBudget() <= 2) {
            workflowName = workflowService.getWorkflowNameByWorkflowCode("T_ZW_GOODSPURCHASING_WF02");
        }
        if (2 < goodsPurchasing.getBudget() && goodsPurchasing.getBudget() <= 5) {
            workflowName = workflowService.getWorkflowNameByWorkflowCode("T_ZW_GOODSPURCHASING_WF03");
        }
        if (5 < goodsPurchasing.getBudget() && goodsPurchasing.getBudget() <= 10) {
            workflowName = workflowService.getWorkflowNameByWorkflowCode("T_ZW_GOODSPURCHASING_WF04");
        }
        if (10 < goodsPurchasing.getBudget() && goodsPurchasing.getBudget() <= 30) {
            workflowName = workflowService.getWorkflowNameByWorkflowCode("T_ZW_GOODSPURCHASING_WF05");
        }
        if (30 < goodsPurchasing.getBudget()) {
            workflowName = workflowService.getWorkflowNameByWorkflowCode("T_ZW_GOODSPURCHASING_WF06");
        }

        String state = stampService.getStateById(id);
        List<Handle> list= stampService.getHandlebyId(id);
        String requestDate = goodsPurchasing.getRequestDate().replace("T", " ");
        int size=list.size();
        mv.addObject("handleList", list);
        mv.addObject("size",size);
        mv.addObject("state",state);
        mv.addObject("requestDate", requestDate);
        mv.addObject("goodsPurchasing", goodsPurchasing);
        mv.addObject("workflowName", workflowName);
        return mv;
    }
    /**移植到资产*/
    @ResponseBody
    @RequestMapping("/backSetAssets")
    public ModelAndView backSetAssets(String id) {
        ModelAndView mv = new ModelAndView("/business/logistics/goodspurchasing/backSetAssets");
        GoodsPurchasing goodsPurchasing = goodsPurchasingService.getGoodsPurchasingById(id);
        mv.addObject("head", "物品采购申请修改");
        mv.addObject("goodsPurchasing", goodsPurchasing);
        mv.addObject("id",id);
        return mv;
    }

    /**
     * 字段查重
     */
//    @ResponseBody
//    @RequestMapping("/checkName")
//    public Message checkName(GoodsPurchasing goodsPurchasing){
//        userDic.setDictype(dt);
//        List size = userDicService.checkName(userDic);
//        if(size.size()>0){
//            return new Message(1, "名称重复，请重新填写！", null);
//        }else{
//            return new Message(0, "", null);
//        }
//    }

}
