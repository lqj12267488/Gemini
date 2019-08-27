package com.goisan.synergy.workflow.colltroller;

import com.goisan.synergy.workflow.bean.MealCardHandle;
import com.goisan.synergy.workflow.service.MealCardHandleService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.service.EmpService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
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
 * Created by Administrator on 2017/10/10.
 */
@Controller
public class MealCardHandleController {
    @Resource
    private MealCardHandleService mealCardHandleService;
    @Resource
    private WorkflowService workflowService;

    /**
     * 饭卡办理申请跳转
     * request by hanyue
     * modify by hanyue
     * @return
     */
    @RequestMapping("/mealCardHandle/request")
    public ModelAndView mealCardHandleList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/mealcardhandle/mealCardHandle");
        return mv;
    }

    /**
     * 饭卡办理URL
     *  url by hanyue
     *  modify by hanyue
     * @param mealCardHandle
     * @return
     */
    @ResponseBody
    @RequestMapping("/mealCardHandle/getMealCardHandleList")
    public Map<String,List<MealCardHandle>> getMealCardHandleList(MealCardHandle mealCardHandle) {
        Map<String, List<MealCardHandle>> mealCardHandleMap = new HashMap<String, List<MealCardHandle>>();
        mealCardHandle.setCreator(CommonUtil.getPersonId());
        mealCardHandle.setCreateDept(CommonUtil.getDefaultDept());
        mealCardHandleMap.put("data", mealCardHandleService.getMealCardHandleList(mealCardHandle));
        return mealCardHandleMap;
    }
    /**
     * 饭卡办理新增
     * add by hanyue
     * modify by hanyue
     * @return
     */
    @RequestMapping("/mealCardHandle/editMealCardHandle")
    public ModelAndView addMealCardHandle() {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/mealcardhandle/editMealCardHandle");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String datetime = date+'T'+time;
        String personName = mealCardHandleService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = mealCardHandleService.getDeptNameById(CommonUtil.getDefaultDept());
        MealCardHandle mealCardHandle=new MealCardHandle();
        mealCardHandle.setTeacherId(personName);
        mealCardHandle.setMealCardTime(datetime);
        mealCardHandle.setDeptId(deptName);
        mv.addObject("head", "饭卡办理新增");
        mv.addObject("mealCardHandle", mealCardHandle);
        return mv;
    }
    /**
     * 饭卡办理修改
     * update by hanyue
     * modify by hanyue
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/mealCardHandle/getMealCardHandleById")
    public ModelAndView getMealCardHandleById(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/mealcardhandle/editMealCardHandle");
        MealCardHandle mealCardHandle = mealCardHandleService.getMealCardHandleById(id);
        mv.addObject("head", "饭卡办理修改");
        mv.addObject("mealCardHandle", mealCardHandle);
        return mv;
    }
    /**
     * 保存饭卡办理
     * save by hanyue
     * modify by hanyue
     * @param mealCardHandle
     * @return
     */
    @ResponseBody
    @RequestMapping("/mealCardHandle/saveMealCardHandle")
    public Message saveMealCardHandle(MealCardHandle mealCardHandle){
        if(mealCardHandle.getId()==null || mealCardHandle.getId().equals("")){
            mealCardHandle.setCreator(CommonUtil.getPersonId());
            mealCardHandle.setCreateDept(CommonUtil.getDefaultDept());
            mealCardHandle.setTeacherId(CommonUtil.getPersonId());
            mealCardHandle.setDeptId(CommonUtil.getDefaultDept());
            mealCardHandle.setId(CommonUtil.getUUID());
            mealCardHandleService.insertMealCardHandle(mealCardHandle);
            return new Message(1, "新增成功！", null);
        }else{
            mealCardHandle.setTeacherId(CommonUtil.getPersonId());
            mealCardHandle.setDeptId(CommonUtil.getDefaultDept());
            mealCardHandle.setChanger(CommonUtil.getPersonId());
            mealCardHandle.setChangeDept(CommonUtil.getDefaultDept());
            mealCardHandleService.updateMealCardHandleById(mealCardHandle);
            return new Message(1, "修改成功！", null);
        }
    }
    /**
     * 删除饭卡办理
     * delete by hanyue
     * modify by hanyue
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/mealCardHandle/deleteMealCardHandleById")
    public Message deleteMealCardHandleById(String id) {
        mealCardHandleService.deleteMealCardHandleById(id);
        return new Message(1, "删除成功！", null);
    }
    /**
     * 部门自动提示框
     * dept by hanyue
     * modify by hanyue
     * @return
     */
    @ResponseBody
    @RequestMapping("/mealCardHandle/autoCompleteDept")
    public List<AutoComplete> autoCompleteDept() {
        return mealCardHandleService.autoCompleteDept();
    }
    /**
     * 人员自动提示框
     * person by hanyue
     * modify by hanyue
     * @return
     */
    @ResponseBody
    @RequestMapping("/mealCardHandle/autoCompleteEmployee")
    public List<AutoComplete> autoCompleteEmployee() {
        return mealCardHandleService.autoCompleteEmployee();
    }
    /**
     * 代办业务跳转
     * agency business by hanyue
     * modify by hanyue
     * @return
     */
    @RequestMapping("/mealCardHandle/process")
    public ModelAndView mealCardHandleProcess() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/mealcardhandle/mealCardHandleProcess");
        return mv;
    }
    /**
     * 代办业务初始化
     * agency business initialize by hanyue
     * modify by hanyue
     * @param mealCardHandle
     * @return
     */
    @ResponseBody
    @RequestMapping("/mealCardHandle/getProcessList")
    public Map<String, List<MealCardHandle>> getProcessList(MealCardHandle mealCardHandle) {
        Map<String, List<MealCardHandle>> mealCardHandleMap = new HashMap<String, List<MealCardHandle>>();
        mealCardHandle.setCreator(CommonUtil.getPersonId());
        mealCardHandle.setCreateDept(CommonUtil.getDefaultDept());
        mealCardHandle.setChanger(CommonUtil.getPersonId());
        mealCardHandle.setChangeDept(CommonUtil.getDefaultDept());
        mealCardHandleMap.put("data", mealCardHandleService.getProcessList(mealCardHandle));
        return mealCardHandleMap;
    }

    /**
     * 已办业务跳转
     * already done business by hanyue
     * modify by hanyue
     * @return
     */
    @RequestMapping("/mealCardHandle/complete")
    public ModelAndView mealCardHandleComplete() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/mealcardhandle/mealCardHandleComplete");
        return mv;
    }
    /**
     * 已办页面初始化
     * already done business initialize by hanyue
     * modify by hanyue
     * @param mealCardHandle
     * @return
     */
    @ResponseBody
    @RequestMapping("/mealCardHandle/getCompleteList")
    public Map<String, List<MealCardHandle>> getCompleteList(MealCardHandle mealCardHandle) {
        Map<String, List<MealCardHandle>> mealCardHandleMap = new HashMap<String, List<MealCardHandle>>();
        mealCardHandle.setCreator(CommonUtil.getPersonId());
        mealCardHandle.setCreateDept(CommonUtil.getDefaultDept());
        mealCardHandle.setChanger(CommonUtil.getPersonId());
        mealCardHandle.setChangeDept(CommonUtil.getDefaultDept());
        mealCardHandleMap.put("data", mealCardHandleService.getCompleteList(mealCardHandle));
        return mealCardHandleMap;
    }

    /**
     * 待办修改
     * agency update by hanyue
     * modify by hanyue
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/mealCardHandle/auditMealCardHandleEdit")
    public ModelAndView auditMealCardHandleEdit(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/mealcardhandle/editMealCardHandleProcess");
        MealCardHandle mealCardHandle = mealCardHandleService.getMealCardHandleById(id);
        mv.addObject("head", "修改");
        mv.addObject("mealCardHandle", mealCardHandle);
        return mv;
    }
    /**
     * 查看流程轨迹
     * process trajectory by hanyue
     * modify by hanyue
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/mealCardHandle/auditMealCardHandleById")
    public ModelAndView waitRoleById(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/mealcardhandle/addMealCardHandleProcess");
        MealCardHandle mealCardHandle = mealCardHandleService.getMealCardHandleById(id);
        mv.addObject("head", "审批");
        mv.addObject("mealCardHandle", mealCardHandle);
        return mv;
    }
    /**PC端打印*/
    @Resource
    private EmpService empService;
    @ResponseBody
    @RequestMapping("/mealCardHandle/printMealCardHandle")
    public ModelAndView printHallUse(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/mealcardhandle/printMealCardHandle");
        MealCardHandle mealCardHandle = mealCardHandleService.getMealCardHandleById(id);
        String mealCardDate = mealCardHandle.getMealCardDate().substring(0,mealCardHandle.getMealCardDate().indexOf(" "));
        String nian = mealCardDate.replaceFirst("-"," 年 ");
        String yue = nian.replace("-","月 ");
        String mealCardHandle_str = yue+"日";
        mv.addObject("data", mealCardHandle);
        mv.addObject("dept", empService.getDeptNameById(CommonUtil.getDefaultDept()));
        mv.addObject("mealCardDate", mealCardHandle_str);
        return mv;
    }
}
