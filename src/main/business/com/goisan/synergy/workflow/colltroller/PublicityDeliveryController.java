package com.goisan.synergy.workflow.colltroller;

import com.goisan.synergy.workflow.bean.PublicityDelivery;
import com.goisan.synergy.workflow.service.PublicityDeliveryService;
import com.goisan.synergy.workflow.service.StampService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.service.FilesService;
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
 * Created by Administrator on 2017/7/13.
 */
@Controller
public class PublicityDeliveryController {
    @Resource
    private PublicityDeliveryService publicityDeliveryService;
    @Resource//如果不加@Resource,则不能指定到impl
    private FilesService filesService;
    @Resource
    private StampService stampService;
    @Resource
    private WorkflowService workflowService;
    /*
    RequestMapping 是数据库中的resource_url字段的数据
    mav.setViewName 是存放jsp路径的
     */

    /**
     * 宣传稿件投递申请首页跳转
     */
    @RequestMapping("/publicityDelivery/publicityDeliveryList")
    public ModelAndView publicityDeliveryList(){
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/publicityDelivery/publicityDeliveryList");
        return mv;
    }

    /**
     * 管理页面
     */
    @ResponseBody
    @RequestMapping("/publicityDelivery/getPublicityDeliveryList")
    public Map<String,List<PublicityDelivery>> getPublicityDeliveryList(PublicityDelivery publicityDelivery){
        Map<String,List<PublicityDelivery>> publicityDeliveryMap = new HashMap<String, List<PublicityDelivery>>();
        publicityDelivery.setCreator(CommonUtil.getPersonId());
        publicityDelivery.setCreateDept(CommonUtil.getDefaultDept());
        publicityDeliveryMap.put("data",publicityDeliveryService.publicityDeliveryAction(publicityDelivery));
        return publicityDeliveryMap;
    }

    /**
     * 新增页面
     */
    @RequestMapping("/publicityDelivery/editPublicityDelivery")
    public ModelAndView addPublicityDelivery(){
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/publicityDelivery/editPublicityDelivery");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String dateTime = date + 'T' + time;
        PublicityDelivery publicityDelivery = new PublicityDelivery();
        publicityDelivery.setRequestDate(dateTime);
        String personName = publicityDeliveryService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = publicityDeliveryService.getDeptNameById(CommonUtil.getDefaultDept());
        publicityDelivery.setRequester(personName);
        publicityDelivery.setRequestDept(deptName);
        mv.addObject("head","新增申请");
        mv.addObject("publicityDelivery",publicityDelivery);
        return mv;
    }

    /**
     * 修改页面
     */
    @ResponseBody
    @RequestMapping("/publicityDelivery/getPublicityDeliveryById")
    public ModelAndView getPublicityDeliveryById(String id){
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/publicityDelivery/editPublicityDelivery");
        PublicityDelivery publicityDelivery = publicityDeliveryService.getPublicityDeliveryById(id);
        mv.addObject("head","宣传稿件申请修改");
        /*add之后在jsp页就可以写EL取到值了*/
        mv.addObject("publicityDelivery",publicityDelivery);
        return mv;
    }

    /**
     * 新增及修改
     */
    @ResponseBody
    @RequestMapping("/publicityDelivery/savePublicityDelivery")
    public Message savePublicityDelivery(PublicityDelivery publicityDelivery){
        publicityDelivery.setCreateTime(CommonUtil.getDate());
        if(publicityDelivery.getId() == null || publicityDelivery.getId().equals("")){
            publicityDelivery.setCreator(CommonUtil.getPersonId());
            publicityDelivery.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
            /*在创建页面的时候就来一个UUID*/
            publicityDelivery.setId(CommonUtil.getUUID());
            publicityDelivery.setRequester(CommonUtil.getPersonId());
            publicityDelivery.setRequestDept(CommonUtil.getDefaultDept());
            publicityDeliveryService.insertPublicityDelivery(publicityDelivery);
            return new Message(1,"新增成功!",null);
        }else{
            publicityDelivery.setRequester(CommonUtil.getPersonId());
            publicityDelivery.setRequestDept(CommonUtil.getDefaultDept());
            publicityDelivery.setChanger(CommonUtil.getPersonId());
            publicityDelivery.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
            publicityDeliveryService.updatePublicityDelivery(publicityDelivery);
            return new Message(1,"修改成功!",null);
        }
    }

    /**
     * 删除方法
     */
    @ResponseBody
    @RequestMapping("/publicityDelivery/deletePublicityDeliveryById")
    public Message deleteRoleById(String id){
        publicityDeliveryService.deletePublicityDeliveryById(id);
        filesService.delFilesByBusinessId(id);
        return new Message(1,"删除成功!",null);
    }

    /**
     * 获取部门自动完成框
     */
    @ResponseBody
    @RequestMapping("/publicityDelivery/getDept")
    public List<AutoComplete> getDept(){
        return publicityDeliveryService.selectDept();
    }

    /**
     * 获取人员自动完成框
     */
    @ResponseBody
    @RequestMapping("/publicityDelivery/getPerson")
    public List<AutoComplete> getPerson(){
        return publicityDeliveryService.selectPerson();
    }

    //待办业务跳转
    @RequestMapping("/publicityDelivery/process")
    public ModelAndView publicityDeliveryProcess() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/publicityDelivery/publicityDeliveryProcess");
        return mv;
    }
    /**
     * 待办页
     */
    @ResponseBody
    @RequestMapping("/publicityDelivery/getPublicityDeliveryProcess")
    public Map<String, List<PublicityDelivery>> getPublicityDeliveryProcess(PublicityDelivery publicityDelivery) {
        Map<String, List<PublicityDelivery>> publicityDeliveryMap = new HashMap<String, List<PublicityDelivery>>();
        if ("%%".equals(publicityDelivery.getRequestDept())){
            publicityDelivery.setRequestDept(null);
        }
        if ("%%".equals(publicityDelivery.getRequester())){
            publicityDelivery.setRequester(null);
        }
        publicityDelivery.setCreator(CommonUtil.getPersonId());
        publicityDelivery.setCreateDept(CommonUtil.getDefaultDept());
        publicityDelivery.setChanger(CommonUtil.getPersonId());
        publicityDelivery.setChangeDept(CommonUtil.getDefaultDept());
        publicityDeliveryMap.put("data", publicityDeliveryService.getPublicityDeliveryProcess(publicityDelivery));
        return publicityDeliveryMap;
    }
    //已办业务跳转
    @RequestMapping("/publicityDelivery/complete")
    public ModelAndView publicityDeliveryComplete() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/publicityDelivery/publicityDeliveryComplete");
        return mv;
    }
    /**
     * 已办页
     */
    @ResponseBody
    @RequestMapping("/publicityDelivery/getPublicityDeliveryComplete")
    public Map<String, List<PublicityDelivery>> getPublicityDeliveryComplete(PublicityDelivery publicityDelivery) {
        Map<String, List<PublicityDelivery>> publicityDeliveryMap = new HashMap<String, List<PublicityDelivery>>();
        publicityDelivery.setCreator(CommonUtil.getPersonId());
        publicityDelivery.setCreateDept(CommonUtil.getDefaultDept());
        publicityDelivery.setChanger(CommonUtil.getPersonId());
        publicityDelivery.setChangeDept(CommonUtil.getDefaultDept());
        publicityDeliveryMap.put("data", publicityDeliveryService.getPublicityDeliveryComplete(publicityDelivery));
        return publicityDeliveryMap;
    }
    //待办修改
    @ResponseBody
    @RequestMapping("/publicityDelivery/auditPublicityDeliveryEdit")
    public ModelAndView auditPublicityDeliveryEdit(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/publicityDelivery/editPublicityDeliveryProcess");
        PublicityDelivery publicityDelivery = publicityDeliveryService.getPublicityDeliveryById(id);
        mv.addObject("head", "修改");
        mv.addObject("publicityDelivery", publicityDelivery);
        return mv;
    }
    //查看流程轨迹
    @ResponseBody
    @RequestMapping("/publicityDelivery/auditPublicityDeliveryById")
    public ModelAndView waitRoleById(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/publicityDelivery/auditPublicityDelivery");
        PublicityDelivery publicityDelivery = publicityDeliveryService.getPublicityDeliveryById(id);
        mv.addObject("head", "审批");
        mv.addObject("publicityDelivery", publicityDelivery);
        return mv;
    }
    /**PC端打印*/
    @ResponseBody
    @RequestMapping("/publicityDelivery/printPublicityDelivery")
    public ModelAndView printHallUse(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/publicityDelivery/printPublicityDelivery");
        PublicityDelivery publicityDelivery = publicityDeliveryService.getPublicityDeliveryById(id);
        String state = stampService.getStateById(id);
        String  workflowName = workflowService.getWorkflowNameByWorkflowCode("T_BG_PUBLICITYDELIVERY_WF01");
        List<Handle> list= stampService.getHandlebyId(id);
        int size=list.size();
        mv.addObject("handleList", list);
        mv.addObject("size",size);
        mv.addObject("state",state);
        mv.addObject("data", publicityDelivery);
        mv.addObject("workflowName", workflowName);
        return mv;
    }
    /*
    //图片上传跳转
    @RequestMapping("/publicityDelivery/publicityDeliveryUpLoad")
    public ModelAndView publicityDeliveryUpLoad(PublicityDelivery publicityDelivery) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/publicityDelivery/publicityDeliveryUpLoad");
        *//*System.out.println(publicityDelivery.getId());//结果为null*//*
        Files uploadFiles = new Files();
        mv.addObject("head","图片上传");
        mv.addObject("uploadFiles",uploadFiles);
        return mv;
    }

    //文件修改跳转
    @RequestMapping("/publicityDelivery/publicityDeliveryUpLoadEdit")
    public ModelAndView publicityDeliveryUpLoadEdit(PublicityDelivery publicityDelivery){
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/publicityDelivery/publicityDeliveryUpLoad");
        return mv;
    }
    */
}

