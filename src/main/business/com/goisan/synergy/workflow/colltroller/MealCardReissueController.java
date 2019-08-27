package com.goisan.synergy.workflow.colltroller;

import com.goisan.synergy.workflow.bean.MealCardReissue;
import com.goisan.synergy.workflow.service.MealCardReissueService;
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
 * Created by Administrator on 2017/10/11.
 */
@Controller
public class MealCardReissueController {
        @Resource
        private MealCardReissueService mealCardReissueService;
        @Resource
        private WorkflowService workflowService;

        /**
         * 饭卡补办申请跳转
         * request by hanyue
         * modify by hanyue
         * @return
         */
        @RequestMapping("/mealCardReissue/request")
        public ModelAndView mealCardReissueList() {
            ModelAndView mv = new ModelAndView();
            mv.setViewName("/business/synergy/workflow/mealcardreissue/mealCardReissue");
            return mv;
        }

        /**
         * 饭卡补办URL
         *  url by hanyue
         *  modify by hanyue
         * @param mealCardReissue
         * @return
         */
        @ResponseBody
        @RequestMapping("/mealCardReissue/getMealCardReissueList")
        public Map<String,List<MealCardReissue>> getMealCardReissueList(MealCardReissue mealCardReissue) {
            Map<String, List<MealCardReissue>> mealCardReissueMap = new HashMap<String, List<MealCardReissue>>();
            mealCardReissue.setCreator(CommonUtil.getPersonId());
            mealCardReissue.setCreateDept(CommonUtil.getDefaultDept());
            mealCardReissueMap.put("data", mealCardReissueService.getMealCardReissueList(mealCardReissue));
            return mealCardReissueMap;
        }
        /**
         * 饭卡补办新增
         * add by hanyue
         * modify by hanyue
         * @return
         */
        @RequestMapping("/mealCardReissue/editMealCardReissue")
        public ModelAndView addMealCardReissue() {
            ModelAndView mv = new ModelAndView("/business/synergy/workflow/mealcardreissue/editMealCardReissue");
            SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
            String date = formatDate.format(new Date());
            String time = formatTime.format(new Date());
            String datetime = date+'T'+time;
            String personName = mealCardReissueService.getPersonNameById(CommonUtil.getPersonId());
            String deptName = mealCardReissueService.getDeptNameById(CommonUtil.getDefaultDept());
            MealCardReissue mealCardReissue=new MealCardReissue();
            mealCardReissue.setTeacherId(personName);
            mealCardReissue.setReissueTime(datetime);
            mealCardReissue.setDeptId(deptName);
            mv.addObject("head", "饭卡补办新增");
            mv.addObject("mealCardReissue", mealCardReissue);
            return mv;
        }
        /**
         * 饭卡补办修改
         * update by hanyue
         * modify by hanyue
         * @param id
         * @return
         */
        @ResponseBody
        @RequestMapping("/mealCardReissue/getMealCardReissueById")
        public ModelAndView getMealCardReissueById(String id) {
            ModelAndView mv = new ModelAndView("/business/synergy/workflow/mealcardreissue/editMealCardReissue");
            MealCardReissue mealCardReissue = mealCardReissueService.getMealCardReissueById(id);
            mv.addObject("head", "饭卡补办修改");
            mv.addObject("mealCardReissue", mealCardReissue);
            return mv;
        }
        /**
         * 保存饭卡补办
         * save by hanyue
         * modify by hanyue
         * @param mealCardReissue
         * @return
         */
        @ResponseBody
        @RequestMapping("/mealCardReissue/saveMealCardReissue")
        public Message saveMealCardReissue(MealCardReissue mealCardReissue){
            if(mealCardReissue.getId()==null || mealCardReissue.getId().equals("")){
                mealCardReissue.setCreator(CommonUtil.getPersonId());
                mealCardReissue.setCreateDept(CommonUtil.getDefaultDept());
                mealCardReissue.setTeacherId(CommonUtil.getPersonId());
                mealCardReissue.setDeptId(CommonUtil.getDefaultDept());
                mealCardReissue.setId(CommonUtil.getUUID());
                mealCardReissueService.insertMealCardReissue(mealCardReissue);
                return new Message(1, "新增成功！", null);
            }else{
                mealCardReissue.setTeacherId(CommonUtil.getPersonId());
                mealCardReissue.setDeptId(CommonUtil.getDefaultDept());
                mealCardReissue.setChanger(CommonUtil.getPersonId());
                mealCardReissue.setChangeDept(CommonUtil.getDefaultDept());
                mealCardReissueService.updateMealCardReissueById(mealCardReissue);
                return new Message(1, "修改成功！", null);
            }
        }
        /**
         * 删除饭卡补办
         * delete by hanyue
         * modify by hanyue
         * @param id
         * @return
         */
        @ResponseBody
        @RequestMapping("/mealCardReissue/deleteMealCardReissueById")
        public Message deleteMealCardReissueById(String id) {
            mealCardReissueService.deleteMealCardReissueById(id);
            return new Message(1, "删除成功！", null);
        }
        /**
         * 部门自动提示框
         * dept by hanyue
         * modify by hanyue
         * @return
         */
        @ResponseBody
        @RequestMapping("/mealCardReissue/autoCompleteDept")
        public List<AutoComplete> autoCompleteDept() {
            return mealCardReissueService.autoCompleteDept();
        }
        /**
         * 人员自动提示框
         * person by hanyue
         * modify by hanyue
         * @return
         */
        @ResponseBody
        @RequestMapping("/mealCardReissue/autoCompleteEmployee")
        public List<AutoComplete> autoCompleteEmployee() {
            return mealCardReissueService.autoCompleteEmployee();
        }
        /**
         * 代办业务跳转
         * agency business by hanyue
         * modify by hanyue
         * @return
         */
        @RequestMapping("/mealCardReissue/process")
        public ModelAndView mealCardReissueProcess() {
            ModelAndView mv = new ModelAndView();
            mv.setViewName("/business/synergy/workflow/mealcardreissue/mealCardReissueProcess");
            return mv;
        }
        /**
         * 代办业务初始化
         * agency business initialize by hanyue
         * modify by hanyue
         * @param mealCardReissue
         * @return
         */
        @ResponseBody
        @RequestMapping("/mealCardReissue/getProcessList")
        public Map<String, List<MealCardReissue>> getProcessList(MealCardReissue mealCardReissue) {
            Map<String, List<MealCardReissue>> mealCardReissueMap = new HashMap<String, List<MealCardReissue>>();
            mealCardReissue.setCreator(CommonUtil.getPersonId());
            mealCardReissue.setCreateDept(CommonUtil.getDefaultDept());
            mealCardReissue.setChanger(CommonUtil.getPersonId());
            mealCardReissue.setChangeDept(CommonUtil.getDefaultDept());
            mealCardReissueMap.put("data", mealCardReissueService.getProcessList(mealCardReissue));
            return mealCardReissueMap;
        }

        /**
         * 已办业务跳转
         * already done business by hanyue
         * modify by hanyue
         * @return
         */
        @RequestMapping("/mealCardReissue/complete")
        public ModelAndView mealCardReissueComplete() {
            ModelAndView mv = new ModelAndView();
            mv.setViewName("/business/synergy/workflow/mealcardreissue/mealCardReissueComplete");
            return mv;
        }
        /**
         * 已办页面初始化
         * already done business initialize by hanyue
         * modify by hanyue
         * @param mealCardReissue
         * @return
         */
        @ResponseBody
        @RequestMapping("/mealCardReissue/getCompleteList")
        public Map<String, List<MealCardReissue>> getCompleteList(MealCardReissue mealCardReissue) {
            Map<String, List<MealCardReissue>> mealCardReissueMap = new HashMap<String, List<MealCardReissue>>();
            mealCardReissue.setCreator(CommonUtil.getPersonId());
            mealCardReissue.setCreateDept(CommonUtil.getDefaultDept());
            mealCardReissue.setChanger(CommonUtil.getPersonId());
            mealCardReissue.setChangeDept(CommonUtil.getDefaultDept());
            mealCardReissueMap.put("data", mealCardReissueService.getCompleteList(mealCardReissue));
            return mealCardReissueMap;
        }

        /**
         * 待办修改
         * agency update by hanyue
         * modify by hanyue
         * @param id
         * @return
         */
        @ResponseBody
        @RequestMapping("/mealCardReissue/auditMealCardReissueEdit")
        public ModelAndView auditMealCardReissueEdit(String id) {
            ModelAndView mv = new ModelAndView("/business/synergy/workflow/mealcardreissue/editMealCardReissueProcess");
            MealCardReissue mealCardReissue = mealCardReissueService.getMealCardReissueById(id);
            mv.addObject("head", "修改");
            mv.addObject("mealCardReissue", mealCardReissue);
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
        @RequestMapping("/mealCardReissue/auditMealCardReissueById")
        public ModelAndView waitRoleById(String id) {
            ModelAndView mv = new ModelAndView("/business/synergy/workflow/mealcardreissue/addMealCardReissueProcess");
            MealCardReissue mealCardReissue = mealCardReissueService.getMealCardReissueById(id);
            mv.addObject("head", "审批");
            mv.addObject("mealCardReissue", mealCardReissue);
            return mv;
        }
    /**PC端打印*/
    @Resource
    private EmpService empService;
    @ResponseBody
    @RequestMapping("/mealCardReissue/printMealCardReissue")
    public ModelAndView printHallUse(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/mealcardreissue/printMealCardReissue");
        MealCardReissue mealCardReissue = mealCardReissueService.getMealCardReissueById(id);
        String mealCardDate = mealCardReissue.getReissueDate().substring(0,mealCardReissue.getReissueDate().indexOf(" "));
        String nian = mealCardDate.replaceFirst("-"," 年 ");
        String yue = nian.replace("-","月 ");
        String mealCardHandle_str = yue+"日";
        mv.addObject("mealCardDate", mealCardHandle_str);
        mv.addObject("dept", empService.getDeptNameById(CommonUtil.getDefaultDept()));
        mv.addObject("handleName", empService.getPersonNameById(CommonUtil.getPersonId()));
        mv.addObject("data", mealCardReissue);
        return mv;
    }
}
