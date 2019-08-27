package com.goisan.synergy.workflow.colltroller;

import com.goisan.synergy.workflow.bean.DraftPaper;
import com.goisan.synergy.workflow.service.DraftPaperService;
import com.goisan.synergy.workflow.service.StampService;
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
 * Created by znw on 2017/7/17.
 */
@Controller
public class DraftPaperController {
    @Resource
    private DraftPaperService draftPaperService;
    @Resource
    private WorkflowService workflowService;
    @Resource
    private StampService stampService;

    /**
     拟文申请跳转
     */
    @RequestMapping("/draftPaper")
    public ModelAndView draftPaperList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/draftpaper/draftPaperList");
        return mv;
    }
    /**
     *拟文申请URL
     */
     @ResponseBody
     @RequestMapping("/draftPaper/getDraftPaperList")
     public Map<String, List<DraftPaper>> getDraftPaperList(DraftPaper draftPaper) {
     Map<String, List<DraftPaper>> draftPaperMap = new HashMap<String, List<DraftPaper>>();
     draftPaper.setCreator(CommonUtil.getPersonId());
     draftPaper.setCreateDept(CommonUtil.getDefaultDept());
     draftPaperMap.put("data", draftPaperService.getDraftPaperList(draftPaper));
     return draftPaperMap;
     }
    /**
     * 新增
     */
    @RequestMapping("/draftPaper/editDraftPaper")
    public ModelAndView addDraftPaper() {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/draftpaper/editDraftPaper");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        String date = formatDate.format(new Date());
        DraftPaper draftPaper=new DraftPaper();
        mv.addObject("head", "拟文稿纸新增");
        String personName = draftPaperService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = draftPaperService.getDeptNameById(CommonUtil.getDefaultDept());
        draftPaper.setDraftDate(date);
        draftPaper.setDraftDept(deptName);
        draftPaper.setDrafter(personName);
        mv.addObject("draftPaper", draftPaper);
        return mv;
    }
    /**
     * 修改
     */
    @ResponseBody
    @RequestMapping("/draftPaper/getDraftPaperById")
    public ModelAndView getDraftPaperById(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/draftpaper/editDraftPaper");
        DraftPaper draftPaper = draftPaperService.getDraftPaperById(id);
        mv.addObject("head", "拟文稿纸修改");
        mv.addObject("draftPaper", draftPaper);
        return mv;
    }
    //保存
    @ResponseBody
    @RequestMapping("/draftPaper/saveDraftPaper")
    public Message saveDraftPaper(DraftPaper draftPaper){
        if(draftPaper.getId()==null || draftPaper.getId().equals("")){
            draftPaper.setCreator(CommonUtil.getPersonId());
            draftPaper.setCreateDept(CommonUtil.getDefaultDept());
            draftPaper.setDrafter(CommonUtil.getPersonId());
            draftPaper.setDraftDept(CommonUtil.getDefaultDept());
            draftPaper.setId(CommonUtil.getUUID());
            draftPaperService.insertDraftPaper(draftPaper);
            return new Message(1, "新增成功！", null);
        }else{
            draftPaper.setDrafter(CommonUtil.getPersonId());
            draftPaper.setDraftDept(CommonUtil.getDefaultDept());
            draftPaper.setChanger(CommonUtil.getPersonId());
            draftPaper.setChangeDept(CommonUtil.getDefaultDept());
            draftPaperService.updateDraftPaperById(draftPaper);
            return new Message(1, "修改成功！", null);
        }
    }
    /**
     * 删除
     */
    @ResponseBody
    @RequestMapping("/draftPaper/deleteDraftPaperById")
    public Message deleteDraftPaperById(String id) {
        draftPaperService.deleteDraftPaperById(id);
        return new Message(1, "删除成功！", null);
    }
    /**
     * 代办业务跳转
     */
    @RequestMapping("/draftPaper/process")
    public ModelAndView draftPaperProcess() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/draftpaper/draftPaperProcess");
        return mv;
    }
    /**
     * 代办页面初始化
     */
    @ResponseBody
    @RequestMapping("/draftPaper/getProcessList")
    public Map<String, List<DraftPaper>> getProcessList(DraftPaper draftPaper) {
        Map<String, List<DraftPaper>> draftPaperMap = new HashMap<String, List<DraftPaper>>();
        draftPaper.setCreator(CommonUtil.getPersonId());
        draftPaper.setCreateDept(CommonUtil.getDefaultDept());
        draftPaper.setChanger(CommonUtil.getPersonId());
        draftPaper.setChangeDept(CommonUtil.getDefaultDept());
        draftPaperMap.put("data", draftPaperService.getProcessList(draftPaper));
        return draftPaperMap;
    }
    /**
     * 已办业务跳转
     */
    @RequestMapping("/draftPaper/complete")
    public ModelAndView draftPaperComplete() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/draftpaper/draftPaperComplete");
        return mv;
    }
    /**
     * 已办页面初始化
     */
    @ResponseBody
    @RequestMapping("/draftPaper/getCompleteList")
    public Map<String, List<DraftPaper>> getCompleteList(DraftPaper draftPaper) {
        Map<String, List<DraftPaper>> draftPaperMap = new HashMap<String, List<DraftPaper>>();
        draftPaper.setCreator(CommonUtil.getPersonId());
        draftPaper.setCreateDept(CommonUtil.getDefaultDept());
        draftPaper.setChanger(CommonUtil.getPersonId());
        draftPaper.setChangeDept(CommonUtil.getDefaultDept());
        draftPaperMap.put("data", draftPaperService.getCompleteList(draftPaper));
        return draftPaperMap;
    }
    /**
     *  查看流程轨迹
     */
    @ResponseBody
    @RequestMapping("/draftPaper/auditDraftPaperById")
    public ModelAndView waitRoleById(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/draftpaper/addDraftPaperProcess");
        DraftPaper draftPaper = draftPaperService.getDraftPaperById(id);
        mv.addObject("head", "审批");
        mv.addObject("draftPaper", draftPaper);
        return mv;
    }
    //待办修改
    @ResponseBody
    @RequestMapping("/draftPaper/auditDraftPaperEdit")
    public ModelAndView auditStampEdit(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/draftpaper/editDraftPaperProcess");
        DraftPaper draftPaper = draftPaperService.getDraftPaperById(id);
        mv.addObject("head", "修改");
        mv.addObject("draftPaper", draftPaper);
        return mv;
    }
    /**PC端打印*/
    @ResponseBody
    @RequestMapping("/draftPaper/printDraftPaper")
    public ModelAndView printHallUse(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/draftpaper/printDraftPaper");
        String workflowName = workflowService.getWorkflowNameByWorkflowCode("T_BG_DRAFTPAPER_WF01");
        String state = stampService.getStateById(id);
        List<Handle> list= stampService.getHandlebyId(id);
        int size=list.size();
        mv.addObject("handleList", list);
        mv.addObject("size",size);
        mv.addObject("state",state);
        DraftPaper draftPaper = draftPaperService.getDraftPaperById(id);
        mv.addObject("data", draftPaper);
        mv.addObject("workflowName", workflowName);
        return mv;
    }
}
