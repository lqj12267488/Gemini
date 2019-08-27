package com.goisan.synergy.workflow.colltroller;

import com.goisan.synergy.workflow.bean.ShopItemsReceive;
import com.goisan.synergy.workflow.service.ShopItemsReceiveService;
import com.goisan.synergy.workflow.service.StampService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.service.EmpService;
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
 * Created by hanyu on 2017/6/19.
 */
@Controller
public class ShopItemsReceiveController{
    @Resource
    private ShopItemsReceiveService shopItemsReceiveService;
    @Resource
    private EmpService empService;
    @Resource
    private WorkflowService workflowService;
    @Resource
    private StampService stampService;
    /**
     * 超市领取申请跳转
     * request by lihanyue
     * modify by lihanyue
     * @return
     */
    @RequestMapping("/shopItemsReceive/requet")
    public ModelAndView shopItemsReceiveList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/shopItemsReceive/shopItemsReceive");
        return mv;
    }
    /**
     * 超市领取URL
     *  url by lihanyue
     *  modify by lihanyue
     * @param shopItemsReceive
     * @return
     */
    @ResponseBody
    @RequestMapping("/shopItemsReceive/getShopItemsReceiveList")
    public Map<String, List<ShopItemsReceive>> shopItemsReceiveAction(ShopItemsReceive shopItemsReceive ) {
        Map<String, List<ShopItemsReceive>> shopItemsReceiveMap = new HashMap<String, List<ShopItemsReceive>>();
        shopItemsReceive.setCreator(CommonUtil.getPersonId());
        shopItemsReceive.setCreateDept(CommonUtil.getDefaultDept());
        shopItemsReceiveMap.put("data", shopItemsReceiveService.shopItemsReceiveAction(shopItemsReceive));
        return shopItemsReceiveMap;
    }
    /**
     * 代办业务跳转
     * agency business by lihanyue
     * modify by lihanyue
     * @return
     */
    @RequestMapping("/shopItemsReceive/process")
    public ModelAndView shopItemsReceiveListDb() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/shopItemsReceive/shopItemsReceiveProcess");
        return mv;
    }
    /**
     * 代办业务初始化
     * agency business initialize by lihanyue
     * modify by lihanyue
     * @param shopItemsReceive
     * @return
     */
    @ResponseBody
    @RequestMapping("/shopItemsReceive/getProcessList")
    public Map<String, List<ShopItemsReceive>> getProcessList(ShopItemsReceive shopItemsReceive ) {
        Map<String, List<ShopItemsReceive>> shopItemsReceiveMap = new HashMap<String, List<ShopItemsReceive>>();
        shopItemsReceive.setCreator(CommonUtil.getPersonId());
        shopItemsReceive.setCreateDept(CommonUtil.getDefaultDept());
        List<ShopItemsReceive> r = shopItemsReceiveService.getProcessList(shopItemsReceive);
        shopItemsReceiveMap.put("data", r);
        return shopItemsReceiveMap;
    }
    /**
     * 已办业务跳转
     * already done business by lihanyue
     * modify by lihanyue
     * @return
     */
    @RequestMapping("/shopItemsReceive/complete")
    public ModelAndView shopItemsReceiveListYb() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/shopItemsReceive/shopItemsReceiveComplete");
        return mv;
    }
    /**
     * 已办页面初始化
     * already done business initialize by lihanyue
     * modify by lihanyue
     * @param shopItemsReceive
     * @return
     */
    @ResponseBody
    @RequestMapping("/shopItemsReceive/getCompleteList")
    public Map<String, List<ShopItemsReceive>> getCompleteList(ShopItemsReceive shopItemsReceive ) {
        Map<String, List<ShopItemsReceive>> shopItemsReceiveMap = new HashMap<String, List<ShopItemsReceive>>();
        shopItemsReceive.setCreator(CommonUtil.getPersonId());
        shopItemsReceive.setCreateDept(CommonUtil.getDefaultDept());
        shopItemsReceive.setChanger(CommonUtil.getPersonId());
        shopItemsReceive.setChangeDept(CommonUtil.getDefaultDept());
        List<ShopItemsReceive> r = shopItemsReceiveService.getCompleteList(shopItemsReceive);
        shopItemsReceiveMap.put("data", r);
        return shopItemsReceiveMap;
    }

    /**
     * 筛选
     * search by lihanyue
     * modify by lihanyue
     * @param shopItemsReceive
     * @return
     */
    @ResponseBody
    @RequestMapping("/shopItemsReceive/search")
    public Map<String, List<ShopItemsReceive>> search(ShopItemsReceive shopItemsReceive){
        Map<String, List<ShopItemsReceive>>  shopItemsReceiveMap = new HashMap<String, List<ShopItemsReceive>>();
        shopItemsReceive.setCreator(CommonUtil.getPersonId());
        shopItemsReceive.setCreateDept(CommonUtil.getDefaultDept());
        List<ShopItemsReceive> r = shopItemsReceiveService.shopItemsReceiveAction(shopItemsReceive);
        shopItemsReceiveMap.put("data", r);
        return shopItemsReceiveMap;
    }
    /**
     * 超市领取修改
     * update by lihanyue
     * modify by lihanyue
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/shopItemsReceive/getShopItemsReceiveById")
    public ModelAndView getShopItemsReceiveById(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/shopItemsReceive/editShopItemsReceive");
        ShopItemsReceive shopItemsReceive = shopItemsReceiveService.getShopItemsReceiveById(id);
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String datetime = date+"T"+time;
        String personName = empService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = empService.getDeptNameById(CommonUtil.getDefaultDept());
        shopItemsReceive.setRequestDate(datetime);
        shopItemsReceive.setRequester(personName);
        shopItemsReceive.setRequestDept(deptName);
        mv.addObject("head", "修改");
        mv.addObject("shopItemsReceive", shopItemsReceive);
        return mv;
    }
    /**
     * 超市领取新增
     * add by lihanyue
     * modify by lihanyue
     * @return
     */
    @ResponseBody
    @RequestMapping("/shopItemsReceive/addShopItemsReceive")
    public ModelAndView addShopItemsReceive() {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/shopItemsReceive/editShopItemsReceive");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String datetime = date+'T'+time;
        String personName = empService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = empService.getDeptNameById(CommonUtil.getDefaultDept());
        ShopItemsReceive shopItemsReceive = new ShopItemsReceive();
        shopItemsReceive.setRequestDate(datetime);
        shopItemsReceive.setRequester(personName);
        shopItemsReceive.setRequestDept(deptName);
        mv.addObject("head", "新增申请");
        mv.addObject("shopItemsReceive",shopItemsReceive);
        mv.addObject("personName",personName);
        mv.addObject("deptName", deptName);
        return mv;
    }
    /**
     * 删除超市领取
     * delete by lihanyue
     * modify by lihanyue
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/shopItemsReceive/deleteShopItemsReceiveById")
    public Message deleteShopItemsReceiveById(String id) {
        shopItemsReceiveService.deleteShopItemsReceiveById(id);
        return new Message(1, "删除成功！", null);
    }


    /**
     * 保存超市领取
     * save by lihanyue
     * modify by lihanyue
     * @param shopItemsReceive
     * @return
     */
    @ResponseBody
    @RequestMapping("/shopItemsReceive/saveShopItemsReceive")
    public Message saveShopItemsReceive(ShopItemsReceive shopItemsReceive){
        shopItemsReceive.setRequester(CommonUtil.getPersonId());
        shopItemsReceive.setRequestDept(CommonUtil.getDefaultDept());
        if(shopItemsReceive.getId()==null || shopItemsReceive.getId().equals("")){
            shopItemsReceive.setCreator(CommonUtil.getPersonId());
            shopItemsReceive.setCreateDept(CommonUtil.getDefaultDept());
            shopItemsReceive.setId(CommonUtil.getUUID());
            shopItemsReceive.setRequestFlag("0");
            shopItemsReceive.setRequestDept(CommonUtil.getDefaultDept());
            shopItemsReceive.setRequester(CommonUtil.getPersonId());
            shopItemsReceiveService.insertShopItemsReceive(shopItemsReceive);
            return new Message(1, "新增成功！", null);
        }else{
            shopItemsReceive.setChanger(CommonUtil.getPersonId());
            shopItemsReceive.setChangeDept(CommonUtil.getDefaultDept());
            shopItemsReceiveService.updateShopItemsReceiveById(shopItemsReceive);
            return new Message(1, "修改成功！", null);
        }
    }

    /**
     * 获取部门
     * dept by lihanyue
     * modify by lihanyue
     * @return
     */
    @ResponseBody
    @RequestMapping("/shopItemsReceive/getDept")
    public List<AutoComplete> getDept() {
        return shopItemsReceiveService.selectDept();
    }

    /**
     * 获取教职工
     * person by lihanyue
     * modify by lihanyue
     * @return
     */
    @ResponseBody
    @RequestMapping("/shopItemsReceive/getPerson")
    public List<AutoComplete> getPerson() {
        return shopItemsReceiveService.selectPerson();
    }
    /**
     * 查看流程轨迹
     * process trajectory by lihanyue
     * modify by lihanyue
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/shopItemsReceive/auditShopItemsReceiveById")
    public ModelAndView auditShopItemsReceiveById(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/shopItemsReceive/addShopItemsReceive");
        ShopItemsReceive shopItemsReceive = shopItemsReceiveService.getShopItemsReceiveById(id);
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String datetime = date+"T"+time;
        String personName = empService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = empService.getDeptNameById(CommonUtil.getDefaultDept());
        shopItemsReceive.setRequestDate(datetime);
        shopItemsReceive.setRequestDept(deptName);
        mv.addObject("name",personName);
        mv.addObject("dept",deptName);
        mv.addObject("head", "审批");
        mv.addObject("shopItemsReceive", shopItemsReceive);
        return mv;
    }
    /**
     * 待办修改
     * agency update by lihanyue
     * modify by lihanyue
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/shopItemsReceive/auditShopItemsReceiveEdit")
    public ModelAndView auditShopItemsReceiveEdit(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/shopItemsReceive/editShopItemsReceiveProcess");
        ShopItemsReceive shopItemsReceive = shopItemsReceiveService.getShopItemsReceiveById(id);
        mv.addObject("head", "修改");
        mv.addObject("shopItemsReceive", shopItemsReceive);
        return mv;
    }
    /**PC端打印*/
    @ResponseBody
    @RequestMapping("/shopItemsReceive/printShopItemsReceive")
    public ModelAndView printHallUse(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/shopItemsReceive/printShopItemsReceive");
        ShopItemsReceive shopItemsReceive = shopItemsReceiveService.getShopItemsReceiveById(id);
        String workflowName = workflowService.getWorkflowNameByWorkflowCode("T_BG_SHOPITEMSRECEIVE_WF01");
        String state = stampService.getStateById(id);
        List<Handle> list= stampService.getHandlebyId(id);
        int size=list.size();
        mv.addObject("handleList", list);
        mv.addObject("size",size);
        mv.addObject("state",state);
        mv.addObject("workflowName",workflowName);
        mv.addObject("data", shopItemsReceive);
        return mv;
    }
}
