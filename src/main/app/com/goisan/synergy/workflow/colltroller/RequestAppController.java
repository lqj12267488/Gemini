package com.goisan.synergy.workflow.colltroller;

import com.goisan.personnel.leave.bean.Leave;
import com.goisan.personnel.leave.service.LeaveService;
import com.goisan.synergy.notice.bean.Notice;
import com.goisan.synergy.notice.service.NoticeService;
import com.goisan.synergy.workflow.bean.*;
import com.goisan.synergy.workflow.service.*;
import com.goisan.system.service.EmpService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import com.goisan.system.tools.UpperMoney;
import com.goisan.workflow.bean.Workflow;
import com.goisan.workflow.service.WorkflowService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;

@Controller
public class RequestAppController {
    @Resource
    private EmpService empService;
    @Resource
    private HallUseService hallUseService;
    @Resource
    private FundsService fundsService;
    @Resource
    private ITDeviceRepaiService itDeviceRepaiService;
    @Resource
    private ITSuppliesRepairService itSuppliesRepairService;
    @Resource
    private StampService stampService;
    @Resource
    private LeaveService leaveService;
    @Resource
    private WorkflowService workflowService;
    @Resource
    private NoticeService noticeService;
    @Resource
    private Funds1Service funds1Service;
    @Resource
    private Funds2Service funds2Service;
    @Resource
    private Funds3Service funds3Service;
    /**
     * 礼堂使用申请
     */
    @RequestMapping("/app/workflow/hallUseAppRequest")
    public ModelAndView hallUseAppRequest(String businessId) {
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/apprequestworkflow/hallUseAppRequest");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        HallUse hallUse = new HallUse();
        String date = formatDate.format(new java.util.Date());
        String personName = empService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = empService.getDeptNameById(CommonUtil.getDefaultDept());
        hallUse.setRequestDept(deptName);
        hallUse.setRequester(personName);
        hallUse.setRequestDate(date);
        mv.addObject("id",businessId);
        Standard standard=new Standard();
        standard.setLevel(CommonUtil.getLoginUser().getLevel());
        standard.setCreateDept(CommonUtil.getDefaultDept());
        standard.setStandardType("1");
        standard = hallUseService.getHallUseStandard(standard);
        mv.addObject("standard", standard);
        mv.addObject("hallUse", hallUse);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/hallUse/saveHallUseAPP")
    public Message saveHallUse(HallUse hallUse) {
        hallUse.setId(hallUse.getId());
        hallUse.setCreator(CommonUtil.getPersonId());
        hallUse.setCreateDept(CommonUtil.getDefaultDept());
        hallUse.setRequester(CommonUtil.getPersonId());
        hallUse.setRequestDept(CommonUtil.getDefaultDept());
        hallUse.setLeaderDept(CommonUtil.getDefaultDept());
        hallUseService.updateHallUseAPP(hallUse);
        return new Message(1, "提交成功！", null);
    }

    /**
     * 款项申请
     */
    @RequestMapping("/app/workflow/fundsAppRequest")
    public ModelAndView fundsAppRequest(String businessId) {
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/apprequestworkflow/fundsAppRequest");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        Funds funds = new Funds();
        String date = formatDate.format(new java.util.Date());
        String personName = empService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = empService.getDeptNameById(CommonUtil.getDefaultDept());
        funds.setRequestDept(deptName);
        funds.setManager(personName);
        funds.setRequestDate(date);
        mv.addObject("id",businessId);
        mv.addObject("funds", funds);
        return mv;
    }
    @ResponseBody
    @RequestMapping("/funds/saveFundsAPP")
    public Message saveFunds(Funds funds) {
        funds.setRequestDept(CommonUtil.getLoginUser().getDefaultDeptId());
        funds.setManager(CommonUtil.getPersonId());
        funds.setCreator(CommonUtil.getPersonId());
        funds.setCreateDept(CommonUtil.getDefaultDept());
        funds.setId(funds.getId());
        String upper = UpperMoney.change(Double.parseDouble(funds.getAmount()));
        funds.setAmountUpper(upper);
        fundsService.updateAppFunds(funds);
        return new Message(1, "提交成功！", null);
    }

    /**
     * 请款一申请
     */
    @RequestMapping("/app/workflow/funds1AppRequest")
    public ModelAndView funds1AppRequest(String businessId) {
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/apprequestworkflow/funds1AppRequest");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        Funds1 funds1 = new Funds1();
        String date = formatDate.format(new java.util.Date());
        String personName = empService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = empService.getDeptNameById(CommonUtil.getDefaultDept());
        funds1.setRequestDept(deptName);
        funds1.setManager(personName);
        funds1.setRequestDate(date);
        mv.addObject("id",businessId);
        mv.addObject("funds", funds1);
        return mv;
    }
    @ResponseBody
    @RequestMapping("/funds1/saveFundsAPP")
    public Message saveFunds(Funds1 funds1) {
        funds1.setRequestDept(CommonUtil.getLoginUser().getDefaultDeptId());
        funds1.setManager(CommonUtil.getPersonId());
        funds1.setCreator(CommonUtil.getPersonId());
        funds1.setCreateDept(CommonUtil.getDefaultDept());
        funds1.setId(funds1.getId());
        String upper = UpperMoney.change(Double.parseDouble(funds1.getAmount()));
        funds1.setAmountUpper(upper);
        funds1Service.updateAppFunds(funds1);
        return new Message(1, "提交成功！", null);
    }
    /**
     * 请款二申请
     */
    @RequestMapping("/app/workflow/funds2AppRequest")
    public ModelAndView funds2AppRequest(String businessId) {
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/apprequestworkflow/funds2AppRequest");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        Funds2 funds2 = new Funds2();
        String date = formatDate.format(new java.util.Date());
        String personName = empService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = empService.getDeptNameById(CommonUtil.getDefaultDept());
        funds2.setRequestDept(deptName);
        funds2.setManager(personName);
        funds2.setRequestDate(date);
        mv.addObject("id",businessId);
        mv.addObject("funds", funds2);
        return mv;
    }
    @ResponseBody
    @RequestMapping("/funds2/saveFundsAPP")
    public Message saveFunds(Funds2 funds2) {
        funds2.setRequestDept(CommonUtil.getLoginUser().getDefaultDeptId());
        funds2.setManager(CommonUtil.getPersonId());
        funds2.setCreator(CommonUtil.getPersonId());
        funds2.setCreateDept(CommonUtil.getDefaultDept());
        funds2.setId(funds2.getId());
        String upper = UpperMoney.change(Double.parseDouble(funds2.getAmount()));
        funds2.setAmountUpper(upper);
        funds2Service.updateAppFunds(funds2);
        return new Message(1, "提交成功！", null);
    }

    /**
     * 请款三申请
     */
    @RequestMapping("/app/workflow/funds3AppRequest")
    public ModelAndView funds3AppRequest(String businessId) {
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/apprequestworkflow/funds3AppRequest");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        Funds3 funds3 = new Funds3();
        String date = formatDate.format(new java.util.Date());
        String personName = empService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = empService.getDeptNameById(CommonUtil.getDefaultDept());
        funds3.setRequestDept(deptName);
        funds3.setManager(personName);
        funds3.setRequestDate(date);
        mv.addObject("id",businessId);
        mv.addObject("funds", funds3);
        return mv;
    }
    @ResponseBody
    @RequestMapping("/funds3/saveFundsAPP")
    public Message saveFunds(Funds3 funds3) {
        funds3.setRequestDept(CommonUtil.getLoginUser().getDefaultDeptId());
        funds3.setManager(CommonUtil.getPersonId());
        funds3.setCreator(CommonUtil.getPersonId());
        funds3.setCreateDept(CommonUtil.getDefaultDept());
        funds3.setId(funds3.getId());
        String upper = UpperMoney.change(Double.parseDouble(funds3.getAmount()));
        funds3.setAmountUpper(upper);
        funds3Service.updateAppFunds(funds3);
        return new Message(1, "提交成功！", null);
    }
    /**
     * IT设备报修申请
     */
    @RequestMapping("/app/workflow/ITDeviceAppRequest")
    public ModelAndView ITDeviceAppRequest(String businessId) {
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/apprequestworkflow/ITDeviceAppRequest");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        ITDeviceRepai itDeviceRepai = new ITDeviceRepai();
        String date = formatDate.format(new java.util.Date());
        String personName = empService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = empService.getDeptNameById(CommonUtil.getDefaultDept());
        itDeviceRepai.setRequestDept(deptName);
        itDeviceRepai.setRequester(personName);
        itDeviceRepai.setRequestDate(date);
        mv.addObject("id",businessId);
        mv.addObject("itDeviceRepai", itDeviceRepai);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/itdevicerepai/updateITDeviceRepaiAPP")
    public Message updateITDeviceAPP(ITDeviceRepai itDeviceRepai) {
        itDeviceRepai.setId(itDeviceRepai.getId());
        itDeviceRepai.setCreator(CommonUtil.getPersonId());
        itDeviceRepai.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
        itDeviceRepai.setRequestDept(CommonUtil.getLoginUser().getDefaultDeptId());
        itDeviceRepai.setRequester(CommonUtil.getPersonId());
        itDeviceRepaiService.updateITDeviceAPP(itDeviceRepai);
        return new Message(1, "提交成功！", null);
    }

    /**
     * IT耗材申报及设备维修申请
     */
    @RequestMapping("/app/workflow/ITSuppliesAppRequest")
    public ModelAndView ITSuppliesAppRequest(String businessId) {
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/apprequestworkflow/ITSuppliesRepairAppRequest");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        ITSuppliesRepair itSuppliesRepair = new ITSuppliesRepair();
        String date = formatDate.format(new java.util.Date());
        String personName = empService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = empService.getDeptNameById(CommonUtil.getDefaultDept());
        itSuppliesRepair.setRequestDept(deptName);
        itSuppliesRepair.setManager(personName);
        itSuppliesRepair.setRequestDate(date);
        mv.addObject("id",businessId);
        mv.addObject("itSuppliesRepair", itSuppliesRepair);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/ITSuppliesRepair/updateITSuppliesRepairAPP")
    public Message updateITSuppliesRepairById(ITSuppliesRepair ITSuppliesRepair) {
        ITSuppliesRepair.setId(ITSuppliesRepair.getId());
        ITSuppliesRepair.setCreator(CommonUtil.getPersonId());
        ITSuppliesRepair.setCreateDept(CommonUtil.getDefaultDept());
        ITSuppliesRepair.setManager(CommonUtil.getPersonId());
        ITSuppliesRepair.setRequestDept(CommonUtil.getDefaultDept());
        itSuppliesRepairService.updateITSuppliesRepairAPP(ITSuppliesRepair);
        return new Message(1, "提交成功！", null);
    }

    /**
     * 请假申请
     */
    @RequestMapping("/app/workflow/leaveAppRequest")
    public ModelAndView leaveAppRequest(String businessId) {
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/apprequestworkflow/leaveAppRequest");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        Leave leave = new Leave();
        String date = formatDate.format(new java.util.Date());
        String personName = empService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = empService.getDeptNameById(CommonUtil.getDefaultDept());
        leave.setRequestDept(deptName);
        leave.setRequester(personName);
        leave.setRequestDate(date);
        mv.addObject("id",businessId);
        mv.addObject("leave", leave);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/leave/saveLeaveAPP")
    public Message saveLeave(Leave leave) {
        leave.setId(leave.getId());
        leave.setCreator(CommonUtil.getPersonId());
        leave.setCreateDept(CommonUtil.getDefaultDept());
        leave.setRequester(CommonUtil.getPersonId());
        leave.setRequestDept(CommonUtil.getDefaultDept());
        leaveService.updateLeaveAPP(leave);
        return new Message(1, "提交成功！", null);
    }
    /**
     * 通知申请
     */
    @RequestMapping("/app/workflow/noticeAppRequest")
    public ModelAndView noticeAppRequest(String businessId) {
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/apprequestworkflow/noticeAppRequest");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        Notice notice = new Notice();
        String date = formatDate.format(new java.util.Date());
        String personName = empService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = empService.getDeptNameById(CommonUtil.getDefaultDept());
        notice.setRequestDept(deptName);
        notice.setRequester(personName);
        notice.setPublicTime(date);
        mv.addObject("id",businessId);
        mv.addObject("notice", notice);
        return mv;
    }
    @ResponseBody
    @RequestMapping("/notice/saveNoticeAPP")
    public Message saveLeave(Notice notice) {
        notice.setId(notice.getId());
        notice.setCreator(CommonUtil.getPersonId());
        notice.setCreateDept(CommonUtil.getDefaultDept());
        notice.setRequester(CommonUtil.getPersonId());
        notice.setRequestDept(CommonUtil.getDefaultDept());
        noticeService.updateNoticeAPP(notice);
        return new Message(1, "提交成功！", null);
    }

    /**
     * 印章申请
     */
    @RequestMapping("/app/workflow/stampAppRequest")
    public ModelAndView stampAppRequest(String type,String businessId) {
        ModelAndView mv = null;
        if ("2".equals(type)) {
            mv = new ModelAndView("/app/synergy/workflow/apprequestworkflow/stampAppRequest2");
        } else {
            mv = new ModelAndView("/app/synergy/workflow/apprequestworkflow/stampAppRequest");
        }
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        Stamp stamp = new Stamp();
        String date = formatDate.format(new java.util.Date());
        String personName = empService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = empService.getDeptNameById(CommonUtil.getDefaultDept());
        stamp.setRequestDept(deptName);
        stamp.setManager(personName);
        stamp.setRequestDate(date);
        //mv.addObject("id", CommonUtil.getUUID());
        mv.addObject("id",businessId);
        mv.addObject("stamp", stamp);
        return mv;
    }
    @ResponseBody
    @RequestMapping("/stamp/saveStampAPP")
    public Message saveStamp(Stamp stamp) {
        stamp.setId(stamp.getId());
        stamp.setCreator(CommonUtil.getPersonId());
        stamp.setCreateDept(CommonUtil.getDefaultDept());
        stamp.setManager(CommonUtil.getPersonId());
        stamp.setRequestDept(CommonUtil.getDefaultDept());
        stampService.updateStampAPP(stamp);
        return new Message(1, "提交成功！", null);
    }
    /**
     * 团委款项申请
     */
    @RequestMapping("/leagues/workflow/leaguesAppRequest")
    public ModelAndView leaguesAppRequest(String businessId) {
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/apprequestworkflow/leaguesAppRequest");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        Leagues leagues = new Leagues();
        String date = formatDate.format(new java.util.Date());
        String personName = empService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = empService.getDeptNameById(CommonUtil.getDefaultDept());
        leagues.setRequestDept(deptName);
        leagues.setManager(personName);
        leagues.setRequestDate(date);
        mv.addObject("id",businessId);
        mv.addObject("leagues", leagues);
        return mv;
    }
    @Resource
    private LeaguesService leaguesService;
    @ResponseBody
    @RequestMapping("/leagues/saveLeaguesAPP")
    public Message saveLeaguesAPP(Leagues leagues) {
        leagues.setRequestDept(CommonUtil.getLoginUser().getDefaultDeptId());
        leagues.setManager(CommonUtil.getPersonId());
        leagues.setCreator(CommonUtil.getPersonId());
        leagues.setCreateDept(CommonUtil.getDefaultDept());
        leagues.setId(leagues.getId());
        String upper = UpperMoney.change(Double.parseDouble(leagues.getAmount()));
        leagues.setAmountUpper(upper);
        leaguesService.updateAppLeagues(leagues);
        return new Message(1, "提交成功！", null);
    }
    /**
     * 跳转APP数据列表页*/
    @RequestMapping("/app/workflow/appRequestList")
    public ModelAndView appRequestList(String tableName,String type,String workflowId){
        ModelAndView mv=new ModelAndView("/app/synergy/workflow/apprequestworkflow/requestAppInfo");
        String businessId=CommonUtil.getUUID();
        String deptId=CommonUtil.getDefaultDept();
        workflowService.insertBusiness(tableName,businessId,deptId);
        Workflow workFlow = workflowService.editAppInfoList(tableName,workflowId);
        mv.addObject("workFlow", workFlow);
        mv.addObject("tableName",tableName);
        mv.addObject("workflowId",workflowId);
        mv.addObject("businessId",businessId);
        mv.addObject("typeName", "申请列表");
        return mv;
    }
}
