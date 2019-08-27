package com.goisan.educational.teachingplan.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.educational.teachingplan.bean.TeachingPlan;
import com.goisan.educational.teachingplan.bean.TeachingPlanDetail;
import com.goisan.educational.teachingplan.service.TeachingPlanDetailService;
import com.goisan.educational.teachingplan.service.TeachingPlanService;
import com.goisan.synergy.workflow.bean.Stamp;
import com.goisan.synergy.workflow.service.StampService;
import com.goisan.system.bean.Select2;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import com.goisan.workflow.bean.Handle;
import com.goisan.workflow.service.WorkflowService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/teachingPlan")
public class TeachingPlanController {

    @Resource
    private TeachingPlanService teachingPlanService;
    @Resource
    private TeachingPlanDetailService teachingPlanDetailService;
    @Resource
    private StampService stampService;
    @Resource
    private WorkflowService workflowService;
    @RequestMapping("/toList")
    public String toList() {
        return "/business/educational/teachingPlan/teachingPlanList";
    }

    @RequestMapping("/teachingPlanDetail/toList")
    public String toList(String planId, String planName, Model model) {
        model.addAttribute("planId", planId);
        model.addAttribute("planName", planName);
        return "/business/educational/teachingPlan/teachingPlanDetailList1";
    }

    @RequestMapping("/teachingPlanDetail/toList2")
    public String toList2(String planId, Model model, String planName) {
        model.addAttribute("planId", planId);
        model.addAttribute("planName", planName);
        return "/business/educational/teachingPlan/teachingPlanDetailList2";
    }

    @ResponseBody
    @RequestMapping("/getList")
    public Map getList(TeachingPlan teachingPlan) {
        List<TeachingPlan> teachingPlans = teachingPlanService.selectList(teachingPlan);
        for (TeachingPlan plan : teachingPlans) {
            String classIds = plan.getClassId();
            if (classIds == null)
                break;
            classIds = "'" + classIds.replaceAll(",", "','") + "'";
            List<String> classNames = teachingPlanService.getClassNames(classIds);
            String str = "";
            for (String name : classNames) {
                str += name + ",";
            }
               plan.setClassName(str.substring(0, str.length() - 1));
            }
        return CommonUtil.tableMap(teachingPlans);
    }

    @RequestMapping("/toAdd")
    public String toAdd(Model model) {
        model.addAttribute("head", "新增");
        return "/business/educational/teachingPlan/teachingPlanEdit";
    }

    @ResponseBody
    @RequestMapping("/save")
    public Message save(TeachingPlan teachingPlan) {
        if (teachingPlan.getId() == "") {
            teachingPlan.setId(CommonUtil.getUUID());
            CommonUtil.save(teachingPlan);
            teachingPlanService.save(teachingPlan);
            return new Message(0, "添加成功！", null);
        } else {
            CommonUtil.update(teachingPlan);
            teachingPlanService.update(teachingPlan);
            return new Message(0, "修改成功！", null);
        }

    }

    @RequestMapping("/toEdit")
    public String toEdit(String id, Model model) {
        TeachingPlan teachingPlan = (TeachingPlan) teachingPlanService.selectById(id);
        String classIds = teachingPlan.getClassId();
        if (classIds != null && !classIds.equals("")) {
            classIds = "'" + classIds.replaceAll(",", "','") + "'";
            List<String> classNames = teachingPlanService.getClassNames(classIds);
            String str = "";
            for (String name : classNames) {
                str += name + ",";
            }
            teachingPlan.setClassName(str.substring(0, str.length() - 1));
        }
        model.addAttribute("data", teachingPlan);
        model.addAttribute("head", "修改");
        return "/business/educational/teachingPlan/teachingPlanEdit";
    }

    @ResponseBody
    @RequestMapping("/del")
    public Message del(String id) {
        TeachingPlanDetail teachingPlanDetail = new TeachingPlanDetail();
        teachingPlanDetail.setPlanId(id);
        List teachingPlans = teachingPlanDetailService.selectList(teachingPlanDetail);
        if(null == teachingPlans || teachingPlans.size() ==0){
            teachingPlanService.del(id);
            return new Message(1, "删除成功！", "success");
        }
        return new Message(0, "授课计划中已增加内容，无法删除！", "error");
    }

    @RequestMapping("/toEditAuditTeachingPlan")
    public String toEditAuditTeachingPlan(String id, Model model) {
        TeachingPlan teachingPlan = (TeachingPlan) teachingPlanService.selectById(id);
        String classIds = teachingPlan.getClassId();
        classIds = "'" + classIds.replaceAll(",", "','") + "'";
        List<String> classNames = teachingPlanService.getClassNames(classIds);
        String str = "";
        for (String name : classNames) {
            str += name + ",";
        }
        teachingPlan.setClassName(str.substring(0, str.length() - 1));
        model.addAttribute("head", "修改");
        model.addAttribute("data", teachingPlan);
        return "/business/educational/teachingPlan/teachingPlanEditAudit";
    }

    @RequestMapping("/toAuditTeachingPlan")
    public String toAuditTeachingPlan(String id, Model model) {
        TeachingPlan teachingPlan = (TeachingPlan) teachingPlanService.selectById(id);
        String classIds = teachingPlan.getClassId();
        classIds = "'" + classIds.replaceAll(",", "','") + "'";
        List<String> classNames = teachingPlanService.getClassNames(classIds);
        String str = "";
        for (String name : classNames) {
            str += name + ",";
        }
        teachingPlan.setClassName(str.substring(0, str.length() - 1));
        model.addAttribute("head", "审核");
        model.addAttribute("data", teachingPlan);
        return "/business/educational/teachingPlan/teachingPlanProcess";
    }

    @RequestMapping("/process")
    public String process() {
        return "/business/educational/teachingPlan/teachingPlanListProcess";
    }

    @RequestMapping("/complete")
    public String complete() {
        return "/business/educational/teachingPlan/teachingPlanListComplete";
    }

    /**
     * 待办页
     */
    @ResponseBody
    @RequestMapping("/getProcessList")
    public Map<String, List<TeachingPlan>> getProcessList(TeachingPlan teachingPlan) {
        CommonUtil.save(teachingPlan);
        List<TeachingPlan> teachingPlans = teachingPlanService.getProcessList(teachingPlan);
        for (TeachingPlan plan : teachingPlans) {
            String classIds = plan.getClassId();
            if (classIds == null)
                break;
            classIds = "'" + classIds.replaceAll(",", "','") + "'";
            List<String> classNames = teachingPlanService.getClassNames(classIds);
            String str = "";
            for (String name : classNames) {
                str += name + ",";
            }
            plan.setClassName(str.substring(0, str.length() - 1));
        }
        Map<String, List<TeachingPlan>> teachingPlanMap = new HashMap<>();
        teachingPlanMap.put("data", teachingPlans);
        return teachingPlanMap;
    }

    /**
     * 已办页
     */
    @ResponseBody
    @RequestMapping("/getCompleteList")
    public Map<String, Object> getCompleteList(TeachingPlan teachingPlan, int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> teachingPlanss = new HashMap();
        CommonUtil.save(teachingPlan);
        List<TeachingPlan> teachingPlans = teachingPlanService.getCompleteList(teachingPlan);
        for (TeachingPlan plan : teachingPlans) {
            String classIds = plan.getClassId();
            if (classIds == null)
                break;
            classIds = "'" + classIds.replaceAll(",", "','") + "'";
            List<String> classNames = teachingPlanService.getClassNames(classIds);
            String str = "";
            for (String name : classNames) {
                str += name + ",";
            }
            plan.setClassName(str.substring(0, str.length() - 1));
        }
        PageInfo<List<TeachingPlan>> info = new PageInfo(teachingPlans);
        teachingPlanss.put("draw", draw);
        teachingPlanss.put("recordsTotal", info.getTotal());
        teachingPlanss.put("recordsFiltered", info.getTotal());
        teachingPlanss.put("data", teachingPlans);
        return teachingPlanss;
    }

    @ResponseBody
    @RequestMapping("/getCourseByMajor")
    public List<Select2> getCourseByMajor(String majorId) {
        return teachingPlanService.getCourseByMajor(majorId);
    }

    @ResponseBody
    @RequestMapping("/getTextbookByMajor")
    public List<Select2> getTextbookByMajor(String majorId) {
        return teachingPlanService.getTextbookByMajor(majorId);
    }

    @ResponseBody
    @RequestMapping("/printTeacherPlan")
    public ModelAndView printTeacherPlan(String id) {

//        List<TeachingPlanDetail> list1=teachingPlanDetailService.getTeachingPlanDetail(id);
//        if(list1.size()>0){
            ModelAndView mv = new ModelAndView("/business/educational/teachingPlan/printTeachingPlanDetailList1");
            TeachingPlan teachingPlan = (TeachingPlan) teachingPlanService.selectById(id);
            String classIds = teachingPlan.getClassId();
            classIds = "'" + classIds.replaceAll(",", "','") + "'";
            List<String> classNames = teachingPlanService.getClassNames(classIds);
            String str = "";
            for (String name : classNames) {
                str += name + ",";
            }
            teachingPlan.setClassName(str.substring(0, str.length() - 1));
            String state = stampService.getStateById(id);
            String workflowName = "";
            workflowName = workflowService.getWorkflowNameByWorkflowCode("T_JW_TEACHINGPLAN01");
            List<Handle> list=stampService.getHandlebyId(id);
            int size=list.size();
            mv.addObject("handleList", list);
            mv.addObject("size",size);
            mv.addObject("state",state);
            mv.addObject("startTime", teachingPlan.getStartTime());
            mv.addObject("endTime", teachingPlan.getEndTime());
            mv.addObject("teachingPlan", teachingPlan);
            mv.addObject("workflowName", workflowName);
            return mv;
//        }else{
//            ModelAndView mv = new ModelAndView("/business/educational/teachingPlan/printTeachingPlanDetailList");
//            TeachingPlan teachingPlan = teachingPlanService.getTeachingPlan(id);
//            String classIds = teachingPlan.getClassId();
//            classIds = "'" + classIds.replaceAll(",", "','") + "'";
//            List<String> classNames = teachingPlanService.getClassNames(classIds);
//            String str = "";
//            for (String name : classNames) {
//                str += name + ",";
//            }
//            teachingPlan.setClassName(str.substring(0, str.length() - 1));
//            String state = stampService.getStateById(id);
//            String workflowName = "";
//            workflowName = workflowService.getWorkflowNameByWorkflowCode("T_JW_TEACHINGPLAN01");
//            List<Handle> list=stampService.getHandlebyId(id);
//            int size=list.size();
//            mv.addObject("handleList", list);
//            mv.addObject("size",size);
//            mv.addObject("state",state);
//            mv.addObject("startTime", teachingPlan.getStartTime());
//            mv.addObject("endTime", teachingPlan.getEndTime());
//            mv.addObject("teachingPlan", teachingPlan);
//            mv.addObject("workflowName", workflowName);
//            return mv;
//        }


    }
}
