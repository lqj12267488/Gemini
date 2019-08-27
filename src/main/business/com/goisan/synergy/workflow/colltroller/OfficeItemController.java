package com.goisan.synergy.workflow.colltroller;

import com.goisan.synergy.workflow.bean.OfficeItem;
import com.goisan.synergy.workflow.service.OfficeItemService;
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
 * Created by Administrator on 2017/5/6 0006.
 */
@Controller
public class OfficeItemController {
    @Resource
    private OfficeItemService officeItemService;
    @Resource
    private EmpService empService;
    @Resource
    private WorkflowService workflowService;
    @Resource
    private StampService stampService;
    //办公物资申请跳转
    @RequestMapping("/officeItem/request")
    public ModelAndView officeItemList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/officeitem/officeItem");
        return mv;
    }
    //办公物资URL
    @ResponseBody
    @RequestMapping("/officeItem/getOfficeItemList")
    public Map<String, List<OfficeItem>> officeItemAction(OfficeItem officeItem ) {
        Map<String, List<OfficeItem>> officeItemMap = new HashMap<String, List<OfficeItem>>();
        officeItem.setCreator(CommonUtil.getPersonId());
        officeItem.setCreateDept(CommonUtil.getDefaultDept());
        officeItemMap.put("data", officeItemService.officeItemAction(officeItem));
        return officeItemMap;
    }
    //代办业务跳转
    @RequestMapping("/officeItem/process")
    public ModelAndView officeItemListDb() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/officeitem/officeItemProcess");
        return mv;
    }
    //代办业务初始化
    @ResponseBody
    @RequestMapping("/officeItem/getOfficeItemListProcess")
    public Map<String, List<OfficeItem>> officeItemProcess(OfficeItem officeItem ) {
        Map<String, List<OfficeItem>> officeItemMap = new HashMap<String, List<OfficeItem>>();
        officeItem.setCreator(CommonUtil.getPersonId());
        officeItem.setCreateDept(CommonUtil.getDefaultDept());
        List<OfficeItem> r = officeItemService.officeItemProcess(officeItem);
        officeItemMap.put("data", r);
        return officeItemMap;
    }
    //已办业务跳转
    @RequestMapping("/officeItem/complete")
    public ModelAndView officeItemListYb() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/officeitem/officeItemComplete");
        return mv;
    }
    //已办页面初始化
    @ResponseBody
    @RequestMapping("/officeItem/getOfficeItemListComplete")
    public Map<String, List<OfficeItem>> officeItemComplete(OfficeItem officeItem ) {
        Map<String, List<OfficeItem>> officeItemMap = new HashMap<String, List<OfficeItem>>();
        officeItem.setCreator(CommonUtil.getPersonId());
        officeItem.setCreateDept(CommonUtil.getDefaultDept());
        officeItem.setChanger(CommonUtil.getPersonId());
        officeItem.setChangeDept(CommonUtil.getDefaultDept());
        List<OfficeItem> r = officeItemService.officeItemComplete(officeItem);
        officeItemMap.put("data", r);
        return officeItemMap;
    }

    @ResponseBody
    @RequestMapping("/officeItem/search")
    public Map<String, List<OfficeItem>> search(OfficeItem officeItem){
        Map<String, List<OfficeItem>>  officeItemMap = new HashMap<String, List<OfficeItem>>();
        officeItem.setCreator(CommonUtil.getPersonId());
        officeItem.setCreateDept(CommonUtil.getDefaultDept());
        List<OfficeItem> r = officeItemService.officeItemAction(officeItem);
        officeItemMap.put("data", r);
        return officeItemMap;
    }
    //办公物资修改
    @ResponseBody
    @RequestMapping("/officeItem/getOfficeItemById")
    public ModelAndView getOfficeItemById(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/officeitem/editOfficeItem");
        OfficeItem officeItem = officeItemService.getOfficeItemById(id);

        String personName = empService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = empService.getDeptNameById(CommonUtil.getDefaultDept());
        mv.addObject("head", "修改申请");
        mv.addObject("officeItem", officeItem);
        mv.addObject("personName",personName);
        mv.addObject("deptName", deptName);

        return mv;
    }
    //办公物资新增
    @ResponseBody
    @RequestMapping("/officeItem/addOfficeItem")
    public ModelAndView addOfficeItem() {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/officeitem/editOfficeItem");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String datetime = date+'T'+time;
        String personName = empService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = empService.getDeptNameById(CommonUtil.getDefaultDept());
        OfficeItem officeItem = new OfficeItem();
        officeItem.setRequestDate(datetime);
        mv.addObject("head", "新增申请");
        mv.addObject("officeItem", officeItem);
        mv.addObject("personName",personName);
        mv.addObject("deptName", deptName);

        return mv;
    }
    //删除办公物资
    @ResponseBody
    @RequestMapping("/officeItem/deleteOfficeItemById")
    public Message deleteOfficeItemById(String id) {
        officeItemService.deleteById(id);
        return new Message(1, "删除成功！", null);
    }
    //保存办公物资
    @ResponseBody
    @RequestMapping("/officeItem/saveOfficeItem")
    public Message saveOfficeItem(OfficeItem officeItem){
        officeItem.setRequester(CommonUtil.getPersonId());
        officeItem.setRequestDept(CommonUtil.getDefaultDept());
        if(officeItem.getId()==null || officeItem.getId().equals("")){
            officeItem.setCreator(CommonUtil.getPersonId());
            officeItem.setCreateDept(CommonUtil.getDefaultDept());
            officeItem.setId(CommonUtil.getUUID());
            officeItem.setRequestFlag("0");
            officeItem.setRequestDept(CommonUtil.getDefaultDept());
            officeItem.setRequester(CommonUtil.getPersonId());
            officeItemService.insertOfficeItem(officeItem);
            return new Message(1, "新增成功！", null);
        }else{
            officeItem.setChanger(CommonUtil.getPersonId());
            officeItem.setChangeDept(CommonUtil.getDefaultDept());
            officeItemService.updateOfficeItem(officeItem);
            return new Message(1, "修改成功！", null);
        }
    }

    @ResponseBody
    @RequestMapping("/officeItem/getDept")
    public List<AutoComplete> getDept() {
        return officeItemService.selectDept();
    }

    @ResponseBody
    @RequestMapping("/officeItem/getPerson")
    public List<AutoComplete> getPerson() {
        return officeItemService.selectPerson();
    }
    //查看流程轨迹
    @ResponseBody
    @RequestMapping("/officeItem/auditOfficeItemById")
    public ModelAndView waitOfficeItemById(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/officeitem/addOfficeItemProcess");
        OfficeItem officeItem = officeItemService.getOfficeItemById(id);
        mv.addObject("head", "审批");
        mv.addObject("officeItem", officeItem);
        return mv;
    }
    //待办修改
    @ResponseBody
    @RequestMapping("/officeItem/auditOfficeItemEdit")
    public ModelAndView auditStampEdit(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/officeitem/editOfficeItemProcess");
        OfficeItem officeItem = officeItemService.getOfficeItemById(id);
        mv.addObject("head", "修改");
        mv.addObject("officeItem", officeItem);
        return mv;
    }
    @ResponseBody
    @RequestMapping("/officeItem/printOfficeItem")
    public ModelAndView printOfficeItem(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/officeitem/printOfficeItem");
        OfficeItem officeItem = officeItemService.getOfficeItemById(id);
        String workflowName = workflowService.getWorkflowNameByWorkflowCode("T_BG_OFFICEITEM_WF01");
        String requestDate = officeItem.getRequestDate().replace("T", " ");
        String state = stampService.getStateById(id);
        List<Handle> list= stampService.getHandlebyId(id);
        int size=list.size();
        mv.addObject("handleList", list);
        mv.addObject("size",size);
        mv.addObject("state",state);
        mv.addObject("requestDate", requestDate);
        mv.addObject("officeItem", officeItem);
        mv.addObject("workflowName", workflowName);
        return mv;
    }
}
