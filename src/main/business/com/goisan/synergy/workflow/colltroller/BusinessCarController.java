package com.goisan.synergy.workflow.colltroller;

import com.goisan.synergy.workflow.bean.BusinessCar;
import com.goisan.synergy.workflow.service.BusinessCarService;
import com.goisan.synergy.workflow.service.StampService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.bean.RoleEmpDeptRelation;
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
 * Created by hanyu on 2017/6/27.
 */
@Controller
public class BusinessCarController {
        @Resource
        private BusinessCarService businessCarService;
        @Resource
        private EmpService empService;
        @Resource
        private StampService stampService;
        @Resource
        private WorkflowService workflowService;
    /**
         * 公务用车申请跳转
         * request by hanyue
         * modify by hanyue
         * @return
         */
        @RequestMapping("/businessCar/request")
        public ModelAndView businessCarServiceList() {
            ModelAndView mv = new ModelAndView();
            mv.setViewName("/business/synergy/workflow/businessCar/businessCar");
            return mv;
        }
        /**
         * 公务用车URL
         *  url by hanyue
         *  modify by hanyue
         * @param businessCar
         * @return
         */
        @ResponseBody
        @RequestMapping("/businessCar/getBusinessCarList")
        public Map<String, List<BusinessCar>> businessCarAction(BusinessCar businessCar ) {
            Map<String, List<BusinessCar>> businessCarMap = new HashMap<String, List<BusinessCar>>();
            businessCar.setCreator(CommonUtil.getPersonId());
            businessCar.setCreateDept(CommonUtil.getDefaultDept());
            businessCarMap.put("data", businessCarService.businessCarAction(businessCar));
            return businessCarMap;
        }
        /**
         * 代办业务跳转
         * agency business by hanyue
         * modify by hanyue
         * @return
         */
        @RequestMapping("/businessCar/process")
        public ModelAndView businessCarListDb() {
            ModelAndView mv = new ModelAndView();
            mv.setViewName("/business/synergy/workflow/businessCar/businessCarProcess");
            return mv;
        }
        /**
         * 代办业务初始化
         * agency business initialize by hanyue
         * modify by hanyue
         * @param businessCar
         * @return
         */
        @ResponseBody
        @RequestMapping("/businessCar/getProcessList")
        public Map<String, List<BusinessCar>> getProcessList(BusinessCar businessCar ) {
            Map<String, List<BusinessCar>> businessCarMap = new HashMap<String, List<BusinessCar>>();
            businessCar.setCreator(CommonUtil.getPersonId());
            businessCar.setCreateDept(CommonUtil.getDefaultDept());
            /*businessCar.setChanger(CommonUtil.getPersonId());
            businessCar.setChangeDept(CommonUtil.getDefaultDept());*/
            List<BusinessCar> r = businessCarService.getProcessList(businessCar);
            businessCarMap.put("data", r);
            return businessCarMap;
        }
        /**
         * 已办业务跳转
         * already done business by hanyue
         * modify by hanyue
         * @return
         */
        @RequestMapping("/businessCar/complete")
        public ModelAndView businessCarListYb() {
            ModelAndView mv = new ModelAndView();
            mv.setViewName("/business/synergy/workflow/businessCar/businessCarComplete");
            return mv;
        }
        /**
         * 已办页面初始化
         * already done business initialize by hanyue
         * modify by hanyue
         * @param businessCar
         * @return
         */
        @ResponseBody
        @RequestMapping("/businessCar/getCompleteList")
        public Map<String, List<BusinessCar>> getCompleteList(BusinessCar businessCar ) {
            Map<String, List<BusinessCar>> businessCarMap = new HashMap<String, List<BusinessCar>>();
            businessCar.setCreator(CommonUtil.getPersonId());
            businessCar.setCreateDept(CommonUtil.getDefaultDept());
            businessCar.setChanger(CommonUtil.getPersonId());
            businessCar.setChangeDept(CommonUtil.getDefaultDept());
            List<BusinessCar> r = businessCarService.getCompleteList(businessCar);
            businessCarMap.put("data", r);
            return businessCarMap;
        }

        /**
         * 筛选
         * search by hanyue
         * modify by hanyue
         * @param businessCar
         * @return
         */
        @ResponseBody
        @RequestMapping("/businessCar/search")
        public Map<String, List<BusinessCar>> search(BusinessCar businessCar){
            Map<String, List<BusinessCar>>  businessCarMap = new HashMap<String, List<BusinessCar>>();
            businessCar.setCreator(CommonUtil.getPersonId());
            businessCar.setCreateDept(CommonUtil.getDefaultDept());
            List<BusinessCar> r = businessCarService.businessCarAction(businessCar);
            businessCarMap.put("data", r);
            return businessCarMap;
        }
        /**
         * 公务用车修改
         * update by hanyue
         * modify by hanyue
         * @param id
         * @return
         */
        @ResponseBody
        @RequestMapping("/businessCar/getBusinessCarById")
        public ModelAndView getBusinessCarById(String id) {
            ModelAndView mv = new ModelAndView("/business/synergy/workflow/businessCar/editBusinessCar");
            BusinessCar businessCar = businessCarService.getBusinessCarById(id);
            String personName = empService.getPersonNameById(CommonUtil.getPersonId());
            String deptName = empService.getDeptNameById(CommonUtil.getDefaultDept());
            businessCar.setRequester(personName);
            businessCar.setRequestDept(deptName);
            mv.addObject("head", "修改");
            mv.addObject("businessCar", businessCar);
            return mv;
        }

        /**
         * 公务用车新增
         * add by hanyue
         * modify by hanyue
         * @return
         */
        @ResponseBody
        @RequestMapping("/businessCar/addBusinessCar")
        public ModelAndView addBusinessCar() {
            ModelAndView mv = new ModelAndView("/business/synergy/workflow/businessCar/editBusinessCar");
            SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
            String date = formatDate.format(new Date());
            String time = formatTime.format(new Date());
            String datetime = date+'T'+time;
            String personName = empService.getPersonNameById(CommonUtil.getPersonId());
            String deptName = empService.getDeptNameById(CommonUtil.getDefaultDept());
            BusinessCar businessCar = new BusinessCar();
            businessCar.setRequestDate(datetime);
            businessCar.setStartTime(datetime);
            businessCar.setEndTime(datetime);
            businessCar.setRequester(personName);
            businessCar.setRequestDept(deptName);
            mv.addObject("head", "新增申请");
            mv.addObject("businessCar",businessCar);
            mv.addObject("personName",personName);
            mv.addObject("deptName", deptName);
            return mv;
        }
        /**
         * 删除公务用车
         * delete by hanyue
         * modify by hanyue
         * @param id
         * @return
         */
        @ResponseBody
        @RequestMapping("/businessCar/deleteBusinessCarById")
        public Message deleteBusinessCarById(String id) {
            businessCarService.deleteBusinessCarById(id);
            return new Message(1, "删除成功！", null);
        }


        /**
         * 保存公务用车
         * save by hanyue
         * modify by hanyue
         * @param businessCar
         * @return
         */
        @ResponseBody
        @RequestMapping("/businessCar/saveBusinessCar")
        public Message saveBusinessCar(BusinessCar businessCar){
            businessCar.setRequester(CommonUtil.getPersonId());
            businessCar.setRequestDept(CommonUtil.getDefaultDept());
            if(businessCar.getId()==null || businessCar.getId().equals("")){
                businessCar.setCreator(CommonUtil.getPersonId());
                businessCar.setCreateDept(CommonUtil.getDefaultDept());
                businessCar.setId(CommonUtil.getUUID());
                businessCar.setRequestFlag("0");
                businessCar.setRequestDept(CommonUtil.getDefaultDept());
                businessCar.setRequester(CommonUtil.getPersonId());
                businessCarService.insertBusinessCar(businessCar);
                return new Message(1, "新增成功！", null);
            }else{
                businessCar.setRequester(CommonUtil.getPersonId());
                businessCar.setRequestDept(CommonUtil.getDefaultDept());
                businessCar.setChanger(CommonUtil.getPersonId());
                businessCar.setChangeDept(CommonUtil.getDefaultDept());
                businessCarService.updateBusinessCarById(businessCar);
                return new Message(1, "修改成功！", null);
            }
        }

        /**
         * 部门自动提示框
         * dept by hanyue
         * modify by hanyue
         * @return
         */
        @ResponseBody
        @RequestMapping("/businessCar/getDept")
        public List<AutoComplete> getDept() {
            return businessCarService.selectDept();
        }

        /**
         * 人员自动提示框
         * person by hanyue
         * modify by hanyue
         * @return
         */
        @ResponseBody
        @RequestMapping("/businessCar/getPerson")
        public List<AutoComplete> getPerson() {
            return businessCarService.selectPerson();
        }
        /**
         * 查看流程轨迹
         * process trajectory by hanyue
         * modify by hanyue
         * @param id
         * @return
         */
        @ResponseBody
        @RequestMapping("/businessCar/auditBusinessCarById")
        public ModelAndView auditBusinessCarById(String id) {
            ModelAndView mv = new ModelAndView("/business/synergy/workflow/businessCar/addBusinessCar");
            BusinessCar businessCar = businessCarService.getBusinessCarBy(id);
            mv.addObject("head", "审批");
            mv.addObject("businessCar", businessCar);
            return mv;
        }

    /**
     * PC端打印
     */
    @ResponseBody
    @RequestMapping("/businessCar/printBusinessCar")
    public ModelAndView printHallUse(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/businessCar/printBusinessCar");
        BusinessCar businessCar = businessCarService.getBusinessCarBy(id);
        String workflowName = workflowService.getWorkflowNameByWorkflowCode("T_BG_BUSINESSCAR_WF01");
        String state = stampService.getStateById(id);
        List<Handle> list= stampService.getHandlebyId(id);
        int size=list.size();
        mv.addObject("handleList", list);
        mv.addObject("size",size);
        mv.addObject("state",state);
        mv.addObject("data", businessCar);
        mv.addObject("workflowName",workflowName);
        return mv;
    }
        /**
         * 待办修改
         * agency update by hanyue
         * modify by hanyue
         * @param id
         * @return
         */
        @ResponseBody
        @RequestMapping("/businessCar/auditBusinessCarEdit")
        public ModelAndView auditBusinessCarEdit(String id) {
            ModelAndView mv = new ModelAndView("/business/synergy/workflow/businessCar/editBusinessCarProcess");
            BusinessCar businessCar = businessCarService.getBusinessCarBy(id);
            mv.addObject("head", "修改");
            mv.addObject("businessCar", businessCar);
            return mv;
        }
    /**
     * 车辆管理员检查跳转
     * already done business by hanyue
     * modify by hanyue
     * @return
     */
    @RequestMapping("/businessCar/car")
    public ModelAndView carYb() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/businessCar/businessCarCompleteCar");
        return mv;
    }
        /**
         * 车辆管理员初始化
         * car manager and requester confirm by hanyue
         * modify by hanyue
         * @param businessCar
         * @return
        */
        @ResponseBody
        @RequestMapping("/businessCar/getBusinessCarListAll")
        public Map<String, List<BusinessCar>> getBusinessCarListAll(BusinessCar businessCar ) {
            Map<String, List<BusinessCar>> businessCarMap = new HashMap<String, List<BusinessCar>>();
            List<RoleEmpDeptRelation> list=businessCarService.getPersonIdByBusinessCar(CommonUtil.getPersonId());
            if(list.size()>0){
                businessCar.setChanger(CommonUtil.getPersonId());
                businessCar.setChangeDept(CommonUtil.getDefaultDept());
                List<BusinessCar> r = businessCarService.getBusinessCarListAll(businessCar);
                businessCarMap.put("data", r);
                return businessCarMap;
            }else{
                return businessCarMap;
            }

        }
        /**
         * 申请人确认初始化
         * car manager and requester confirm by hanyue
         * modify by hanyue
         * @param businessCar
         * @return
         */
        @ResponseBody
        @RequestMapping("/businessCar/getBusinessCarListOne")
        public Map<String, List<BusinessCar>> getBusinessCarListOne(BusinessCar businessCar ) {
            Map<String, List<BusinessCar>> businessCarMap = new HashMap<String, List<BusinessCar>>();
            businessCar.setCreator(CommonUtil.getPersonId());
            businessCar.setCreateDept(CommonUtil.getDefaultDept());
            businessCar.setChanger(CommonUtil.getPersonId());
            businessCar.setChangeDept(CommonUtil.getDefaultDept());
            List<BusinessCar> r = businessCarService.getBusinessCarListOne(businessCar);
            businessCarMap.put("data", r);
            return businessCarMap;
        }
    /**
     * 保存车辆管理员填写记录
     * @param businessCar
     * @return
     */
        @ResponseBody
        @RequestMapping("/businessCar/saveBusinessCarManager")
        public Message saveBusinessCarManager(BusinessCar businessCar){
            businessCar.setRequester(CommonUtil.getPersonId());
            businessCar.setRequestDept(CommonUtil.getDefaultDept());
            if(businessCar.getId()==null || businessCar.getId().equals("")){
                businessCar.setCreator(CommonUtil.getPersonId());
                businessCar.setCreateDept(CommonUtil.getDefaultDept());
                businessCar.setId(CommonUtil.getUUID());
                businessCar.setRequestFlag("0");
                businessCar.setRequestDept(CommonUtil.getDefaultDept());
                businessCar.setRequester(CommonUtil.getPersonId());
                businessCarService.insertBusinessCarManager(businessCar);
                return new Message(1, "新增成功！", null);
            }else{
                businessCar.setChanger(CommonUtil.getPersonId());
                businessCar.setChangeDept(CommonUtil.getDefaultDept());
                businessCarService.updateBusinessCarByManager(businessCar);
                return new Message(1, "修改成功！", null);
            }
        }

    /**
     * 删除车辆管理员
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/businessCar/deleteBusinessCarByManager")
    public Message deleteBusinessCarByManager(String id) {
        businessCarService.deleteBusinessCarByManager(id);
        return new Message(1, "删除成功！", null);
    }
    /**
     * 车辆管理员记录新增
     * add by hanyue
     * modify by hanyue
     * @return
     */
    @ResponseBody
    @RequestMapping("/businessCar/addCarManager")
    public ModelAndView addCarManager() {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/businessCar/editCarManager");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String datetime = date+'T'+time;
        String personName = empService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = empService.getDeptNameById(CommonUtil.getDefaultDept());
        BusinessCar businessCar = new BusinessCar();
        businessCar.setRequestDate(datetime);
        businessCar.setRequester(personName);
        businessCar.setRequestDept(deptName);
        mv.addObject("head", "新增申请");
        mv.addObject("businessCar",businessCar);
        mv.addObject("personName",personName);
        mv.addObject("deptName", deptName);
        return mv;
    }
    /**
     * 车辆管理员记录修改
     * update by hanyue
     * modify by hanyue
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/businessCar/getBusinessCarByManager")
    public ModelAndView getBusinessCarByManager(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/businessCar/editCarManager");
        BusinessCar businessCar = businessCarService.getBusinessCarByManager(id);
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String datetime = date+'T'+time;
        String personName = empService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = empService.getDeptNameById(CommonUtil.getDefaultDept());
        businessCar.setCheckTime(datetime);
        businessCar.setRequestDate(datetime);
        businessCar.setRequester(personName);
        businessCar.setRequestDept(deptName);
        mv.addObject("head", "修改申请");
        mv.addObject("businessCar", businessCar);
        mv.addObject("personName",personName);
        mv.addObject("deptName", deptName);
        return mv;
    }
    /**
     * 申请人确认跳转
     * already done business by hanyue
     * modify by hanyue
     * @return
     */
    @RequestMapping("/businessCar/requester")
    public ModelAndView requesterYb() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/businessCar/businessCarRequester");
        return mv;
    }
    /**
     * 申请人确认反馈
     */
    @ResponseBody
    @RequestMapping("/businessCar/updateBusinessCarMessage")
    public Message updateBusinessCarMessage(String id) {
        businessCarService.updateBusinessCarMessage(id);
        return new Message(1, "确认成功！", null);
    }

}
