package com.goisan.synergy.workflow.colltroller;

import com.goisan.attendance.attendance.bean.AttendanceInfo;
import com.goisan.attendance.attendance.service.AttendanceService;
import com.goisan.logistics.goodspurchasing.bean.GoodsPurchasing;
import com.goisan.logistics.goodspurchasing.service.GoodsPurchasingService;
import com.goisan.logistics.repair.bean.Repair;
import com.goisan.logistics.repair.service.RepairService;
import com.goisan.personnel.leave.bean.Leave;
import com.goisan.personnel.leave.bean.LeaveCancel;
import com.goisan.personnel.leave.service.LeaveCancelService;
import com.goisan.personnel.leave.service.LeaveService;
import com.goisan.personnel.salary.bean.Salary;
import com.goisan.personnel.salary.service.SalaryService;
import com.goisan.personnel.training.bean.Training;
import com.goisan.personnel.training.service.TrainingService;
import com.goisan.studentwork.studentleave.bean.StudentLeave;
import com.goisan.studentwork.studentleave.service.StudentLeaveService;
import com.goisan.synergy.message.bean.Message;
import com.goisan.synergy.message.service.MessageService;
import com.goisan.synergy.notice.bean.Notice;
import com.goisan.synergy.notice.service.NoticeService;
import com.goisan.synergy.workflow.bean.*;
import com.goisan.synergy.workflow.service.*;
import com.goisan.system.bean.Emp;
import com.goisan.system.bean.LoginUser;
import com.goisan.system.bean.Select2;
import com.goisan.system.bean.Tree;
import com.goisan.system.service.CommonService;
import com.goisan.system.service.EmpService;
import com.goisan.system.service.UserDicService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.task.bean.SysTask;
import com.goisan.task.service.TaskService;
import com.goisan.workflow.bean.*;
import com.goisan.workflow.service.DefinitionService;
import com.goisan.workflow.service.WorkflowService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * Created by Admin on 2017/9/8.
 */
@Controller
public class UnDoByAppController {

    @Resource
    public EmpService empService;

    @Resource
    public WorkflowService workflowService;

    @Resource
    public DefinitionService definitionService;
    @Resource
    private TaskService taskService;
    @Resource
    private TrainingService trainingService;
    @Resource
    private ReimbursementService reimbursementService;
    @Resource
    private AttendanceService attendanceService;
    @Resource
    private NoticeService noticeService;
    @Resource
    public CommonService commonService;
    @Resource
    private UserDicService userDicService;

    @RequestMapping("/workflowApp/result/listUnDo")
    public ModelAndView listUnDo(String type) {
        ModelAndView mv = null;
        if ("0" .equals(type) ){
            mv =  new ModelAndView("/app/synergy/workflow/commonjsp/unDoWorkFlowList");
            String emJson = listTaskDownRefresh(1,"",type);
            mv.addObject("emJson", emJson);
            mv.addObject("type", type);
            mv.addObject("typeName", "待办事项");
            mv.addObject("workFlowName", "");
        }else{
            mv = new ModelAndView("/app/synergy/workflow/commonjsp/unDoList");
            String emJson = getWorkFlowNameDownRefresh(1,type);
            mv.addObject("emJson", emJson);
            mv.addObject("type", type);
            mv.addObject("typeName", "已办事项");
        }
        return mv;
    }

    @ResponseBody
    @RequestMapping("/workflowApp/result/getWorkFlowNameDownRefresh")
    public String getWorkFlowNameDownRefresh(int page ,String type) {
        LoginUser loginUser = CommonUtil.getLoginUser();
        String personId = "";
        List<Workflow> workFlow = null;
        if(!loginUser.getPersonId().equals("sa")){
            personId = '%'+ CommonUtil.getPersonId() +'%';
        }
        workFlow = workflowService.getlistWorkFlowNameApp(personId);
        return getJsonTaskList(workFlow,page);
    }

    @ResponseBody
    @RequestMapping("/workflowApp/result/getWorkFlowNameUpRefresh")
    public String getWorkFlowNameUpRefresh(int page,String type) {
        LoginUser loginUser = CommonUtil.getLoginUser();
        String personId = "";
        List<Workflow> workFlow = null;
        if(!loginUser.getPersonId().equals("sa")){
            personId = '%'+ CommonUtil.getPersonId() +'%';
        }
        workFlow = workflowService.getlistWorkFlowNameApp(personId);
        return getJsonTaskList(workFlow,page);
    }

    public String getJsonTaskList(List<Workflow> WorkFlowList, int page){

        int from = ( page - 1 ) * 10 ;
        int end  = page * 10 ;
        int len = WorkFlowList.size();
        // 如果 开始序号 > 列表长度  那么不返回数据
        from = from > len ? len+10 :from ;
        // 如果 结束序号 > 列表长度  那么以列表长度 为结束序号
        end = end > len ? len :end ;

        String str ="";
        boolean b =true;
        for(int i=from;i< end;i++ ){
            Workflow workflow = WorkFlowList.get(i);
            String workFlowName = workflow.getWorkflowName();
            try {
                //workFlowName =java.net.URLEncoder.encode(workFlowName,"UTF-8");
                workFlowName =java.net.URLEncoder.encode(workFlowName,"UTF-8");
            } catch (UnsupportedEncodingException e1) {
                // TODO Auto-generated catch block
                e1.printStackTrace();
            }

            String obj = "{\"workFlowName\":\"" +workFlowName+"\"}" ;

            if(b){
                str =obj;
                b = false;
            }
            else{
                str = str +","+ obj;
            }
        }
        return "["+str+"]";
    }


    @RequestMapping("/workFlowApp/result/listUnDoMenmbers")
    public ModelAndView listMenmbers(String workFlowName,String type) {
        ModelAndView mv = null;
        mv =  new ModelAndView("/app/synergy/workflow/commonjsp/unDoWorkFlowList");
        String emJson = listTaskDownRefresh(1,workFlowName,type);
        mv.addObject("emJson", emJson);
        mv.addObject("workFlowName", workFlowName);
        mv.addObject("type", type);
        if ("0".equals(type)){
            mv.addObject("typeName", "待办事项");
        }else{
            mv.addObject("typeName", "已办事项");
        }

        return mv;
    }

    @ResponseBody
    @RequestMapping("/workFlowApp/result/listUnDoDownRefresh")
    public String listTaskDownRefresh(int page,String workFlowName,String type) {
        LoginUser loginUser = CommonUtil.getLoginUser();
        String personId = "";
        List<Start> workFlowAppList = null;
        if(!loginUser.getPersonId().equals("sa")){
            personId = "%"+ CommonUtil.getPersonId()+"%";
        }
        if ("0".equals(type)) {
            workFlowAppList = workflowService.getlistUnDoWorkFlowNameAppByType(personId);
           /* if(workFlowAppList.size()>0){
                for(int i=0;i<workFlowAppList.size();i++){
                   *//* if(workFlowAppList.get(i).getAbc().equals("3")){
                        String abc=workFlowAppList.get(i).getAbc();
                        return getJsonCompleteList(workFlowAppList,page,type,abc);
                    }
                    else {*//*
                        if("T_RS_TRAINING_WF".equals(workFlowAppList.get(i).getTableName())){
                            return getJsonTrainingList(workFlowAppList,page,type);
                        }else{
                            return getJsonEMList(workFlowAppList,page,type);
                        }
                    //}

                }
            }*/
        }else{
            workFlowAppList = workflowService.getlistWorkFlowNameAppByType(loginUser.getName(),workFlowName);
        }
        return getJsonEMList(workFlowAppList, page, type);
    }

    @ResponseBody
    @RequestMapping("/workFlowApp/result/listUnDoUpRefresh")
    public String listTaskUpRefresh(int page,String workFlowName,String type) {
        LoginUser loginUser = CommonUtil.getLoginUser();
        String personId = "";
        List<Start> workFlowAppList = null;
        if(!loginUser.getPersonId().equals("sa")){
            personId = '%'+ CommonUtil.getPersonId() +'%';
        }
        if ("0".equals(type)) {
            workFlowAppList = workflowService.getlistUnDoWorkFlowNameAppByType(personId);
        }else{
            workFlowAppList = workflowService.getlistWorkFlowNameAppByType(loginUser.getName(),workFlowName);
        }
        return getJsonEMList(workFlowAppList,page,type);
    }

    public String getJsonEMList(List<Start> workFlowAppList, int page, String type){

        int from = ( page - 1 ) * 10 ;
        int end  = page * 10 ;
        int len = workFlowAppList.size();
        // 如果 开始序号 > 列表长度  那么不返回数据
        from = from > len ? len+10 :from ;
        // 如果 结束序号 > 列表长度  那么以列表长度 为结束序号
        end = end > len ? len :end ;

        String str ="";
        String time = "";
        boolean b =true;
        for(int i=from;i< end;i++ ){
            Start start = workFlowAppList.get(i);
            String personID = start.getCreator();
            String id = start.getBusinessId();
            String personName = empService.getPersonNameById(personID);
            String workFlowId = start.getWorkflowId();
            String taskId = start.getTaskId();
            String editUrl = workflowService.getEditAppUrlByWorkFlowId(workFlowId);
            String workFlowName="";
            if(workFlowId==null || workFlowId==""){
                workFlowName =start.getWorkflowName();
            }
            else {
                workFlowName = workflowService.getWorkflowById(workFlowId).getWorkflowName();
            }
            if (workFlowName.indexOf("申请")!=-1 && ("1".equals(start.getAbc()) || start.getAbc()==null)){
                workFlowName = workFlowName.substring(0,workFlowName.length()-2);
            }/*if("1".equals(type)){
                workFlowName = "";
            }*/if("3".equals(start.getAbc())){
                workFlowName = "【已审核】"+workFlowName;
            }
            if( "4".equals(start.getAbc())){
                workFlowName = "【被驳回】"+workFlowName;
            }
            if( "T_ZW_REPAIR".equals(start.getTableName())){
                workFlowName = "【报修】"+workFlowName;
            }
            if("1".equals(start.getAbc()) || "1".equals(type)){
                workFlowName = personName + "的" + workFlowName + "申请";
            }
            if(("1".equals(start.getAbc()) || "1".equals(type)) && "4".equals(start.getState())){
                workFlowName ="【流程关闭】" + workFlowName;
            }
            if ( !"".equals(personName)){
                try {
                    personName =java.net.URLEncoder.encode(personName,"UTF-8");
                    workFlowName =java.net.URLEncoder.encode(workFlowName,"UTF-8");

                } catch (UnsupportedEncodingException e1) {
                    // TODO Auto-generated catch block
                    e1.printStackTrace();
                }
            }

            /*SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            java.util.Date date = format1.parse(fillTime);
            SimpleDateFormat format2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String sdate=format2.format(date);
            Timestamp fTimestamp=Timestamp.valueOf(sdate);*/
            time = start.getCreateTime().toString();
            time = time.split(" ")[0];
            String obj = "{\"startId\":\"" +start.getStartId()+"\"," +
                    "\"id\":\"" +id+"\"," +
                    "\"taskId\":\"" +taskId+"\"," +
                    "\"personName\":\""+personName+"\","+
                    "\"workFlowName\":\""+workFlowName+"\","+
                    "\"abc\":\""+start.getAbc()+"\","+
                    "\"tableName\":\""+start.getTableName()+"\","+
                    "\"createTime\":\""+time+"\"}";
            if(b){
                str =obj;
                b = false;
            }
            else{
                str = str +","+ obj;
            }
        }
        return "["+str+"]";
    }

    @RequestMapping("/workFlowApp/result/listResult")
    public ModelAndView gerlistResult(String id,String startId,String type,String taskId,String abc) {
        LoginUser loginUser = CommonUtil.getLoginUser();
        String cuurentNodeId = "";
        Handle cuurent = null;
        Handle handle = new Handle();
        handle.setStartId(startId);
        handle.setId(id);
        handle.setCreator(loginUser.getName());
        Start start = workflowService.getStartByIdApp(startId);
        String state = start.getState();

        if ("0".equals(type)){
            cuurent = workflowService.getHandle(startId,loginUser.getPersonId());
        }else{
            cuurent = workflowService.getHandleListByCreator(handle);
        }
        if (cuurent==null){
            cuurentNodeId = "-1";
        }else{
            cuurentNodeId = cuurent.getCuurentNodeId();
        }
        List<Definition> definitions = null;
        if ("0".equals(type)&& "1".equals(state)){
            definitions = definitionService.getDefinitionListByNodeIdAndWorkflowId
                    (cuurent.getCuurentNodeId(), cuurent.getCuurentWorkflowId());
        }
        List<Handle> workflowLog = workflowService.getHandleList(startId);
        String url = "";
        /*if(url==)*/
        List<Node> nodes = workflowService.getNodeListByWorkflowId(start.getWorkflowId());
        ModelAndView mv = null;

        if ("4".equals(abc)){
            mv = new ModelAndView("/app/synergy/workflow/commonjsp/editBusinessApp");
            url = workflowService.getEditAppUrlByWorkFlowId(start.getWorkflowId());
        }else{
            url = workflowService.getAppUrlByWorkFlowId(start.getWorkflowId());
            if ("0".equals(type) && "1".equals(state)){
                mv = new ModelAndView("/app/synergy/workflow/commonjsp/auditApp");
            }else{
                mv = new ModelAndView("/app/synergy/workflow/commonjsp/auditDoApp");
            }
        }
        mv.addObject("type",type);
        mv.addObject("startId",startId);
        mv.addObject("definitions", definitions);
        mv.addObject("tableName", start.getTableName());
        mv.addObject("businessId", start.getBusinessId());
        mv.addObject("workflowLog", workflowLog);
        mv.addObject("cuurentNodeId", cuurentNodeId);
        mv.addObject("handleId", id);
        mv.addObject("url", url+"?id="+start.getBusinessId());
        mv.addObject("size", nodes.size());
        mv.addObject("state",state);
        mv.addObject("taskId",taskId);
        mv.addObject("nodes", nodes);
        return mv;
    }

    @RequestMapping("/loadIndexUnAuditApp")
    public ModelAndView loadIndexUnAuditApp() {
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/commonjsp/unDoList");
        return mv;
    }

    @RequestMapping("/toSelectAuditerApp")
    public ModelAndView toSelectAuditer(String businessId,String tableName,String term,String remark) {
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/commonjsp/selectAuditerApp");
        mv.addObject("tableName",tableName);
        mv.addObject("businessId",businessId);
        mv.addObject("term",term);
        mv.addObject("remark",remark);
        return mv;
    }

/**
 * Created by wq on 2017/9/9.
 start*/
    @Resource
    private CameraService cameraService;
    @Resource
    private DeviceBorrowService deviceBorrowService;
    @Resource
    private HallUseService hallUseService;
    @Resource
    private NewsDraftService newsDraftService;
    @Resource
    private NoWorkDayPlaceService noWorkDayPlaceService;
    @Resource
    private PhotographyService photographyService;
    @Resource
    private SchoolCarService schoolCarService;
    @Resource
    private AssetsScrapService assetsScrapService;
    @Resource
    private com.goisan.synergy.workflow.service.ITSuppliesRepairService ITSuppliesRepairService;
    @Resource
    private StampService stampService;
    @Resource
    private com.goisan.synergy.workflow.service.ITDeviceRepaiService ITDeviceRepaiService;
    @RequestMapping("/cameraByApp/cameraAppAudit")
    public ModelAndView cameraResult(String id){
        ModelAndView mv=new ModelAndView("/app/synergy/workflow/appworkflow/cameraAppAudit");
        Camera camera = cameraService.getCameraById(id);
        mv.addObject("camera",camera);
        return mv;
    }
    @RequestMapping("/deviceBorrowByApp/deviceBorrowAppAudit")
    public ModelAndView deviceBorrowResult(String id){
        ModelAndView mv=new ModelAndView("/app/synergy/workflow/appworkflow/deviceBorrowAppAudit");
        DeviceBorrow deviceBorrow = deviceBorrowService.getDeviceBorrowById(id);
        mv.addObject("deviceBorrow",deviceBorrow);
        return mv;
    }
    @RequestMapping("/hallUseByApp/hallUseAppAudit")
    public ModelAndView hallUseResult(String id) {
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/appworkflow/hallUseAppAudit");
        HallUse hallUse = hallUseService.getHallUseById(id);
        Standard standard=new Standard();
        standard.setLevel(CommonUtil.getLoginUser().getLevel());
        standard.setCreateDept(CommonUtil.getDefaultDept());
        standard.setStandardType("1");
        standard = hallUseService.getHallUseStandard(standard);
        mv.addObject("standard", standard);
        String leader=hallUseService.getPersonNameById(hallUse.getLeader());
        hallUse.setLeader(leader);
        mv.addObject("hallUse", hallUse);
        return mv;
    }
    @RequestMapping("/newsDraftByApp/newsDraftAppAudit")
    public ModelAndView newsDraftResult(String id) {
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/appworkflow/newsDraftAppAudit");
        NewsDraft newsDraft = newsDraftService.getNewsDraftById(id);
        String leader=newsDraftService.getPersonNameById(newsDraft.getAuditor());
        newsDraft.setAuditor(leader);
        mv.addObject("newsDraft", newsDraft);
        return mv;
    }
    @RequestMapping("/noWorkDayPlaceByApp/noWorkDayPlaceAppAudit")
    public ModelAndView noWorkDayPlaceResult(String id) {
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/appworkflow/noWorkDayPlaceAppAudit");
        NoWorkDayPlace noWorkDayPlace = noWorkDayPlaceService.getNoWorkDayPlaceById(id);
        Standard standard = noWorkDayPlaceService.getNoWorkDayPlaceStandard("2");
        mv.addObject("standard", standard);
        String leader=noWorkDayPlaceService.getPersonNameById(noWorkDayPlace.getLeader());
        noWorkDayPlace.setLeader(leader);
        mv.addObject("noWorkDayPlace", noWorkDayPlace);
        return mv;
    }
    @RequestMapping("/photographyByApp/photographyAppAudit")
    public ModelAndView photographyResult(String id) {
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/appworkflow/photographyAppAudit");
        Photography photography = photographyService.getPhotographyById(id);
        mv.addObject("photography", photography);
        return mv;
    }
    @RequestMapping("/schoolCarByApp/schoolCarAppAudit")
    public ModelAndView schoolCarResult(String id) {
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/appworkflow/schoolCarAppAudit");
        SchoolCar schoolCar = schoolCarService.getSchoolCarById(id);
        mv.addObject("schoolCar", schoolCar);
        return mv;
    }
    @RequestMapping("/ITDeviceByApp/ITDeviceAppAudit")
    public ModelAndView ITDeviceAppAudit(String id){
        ModelAndView mv=new ModelAndView("/app/synergy/workflow/appworkflow/ITDeviceAppAudit");
        ITDeviceRepai ITDeviceRepai = ITDeviceRepaiService.getITDeviceById(id);
        mv.addObject("ITDeviceRepai",ITDeviceRepai);
        return mv;
    }
    @RequestMapping("/ITSuppliesRepairByApp/ITSuppliesRepairAppAudit")
    public ModelAndView ITSuppliesRepairAppAudit(String id){
        ModelAndView mv=new ModelAndView("/app/synergy/workflow/appworkflow/ITSuppliesRepairAppAudit");
        ITSuppliesRepair ITSuppliesRepair = ITSuppliesRepairService.getITSuppliesRepairById(id);
        mv.addObject("ITSuppliesRepair",ITSuppliesRepair);
        return mv;
    }
    @RequestMapping("/stampByApp/stampAppAudit")
    public ModelAndView stampAppAudit(String id){
        ModelAndView mv=new ModelAndView("/app/synergy/workflow/appworkflow/stampAppAudit");
        Stamp stamp = stampService.getStampById(id);
        mv.addObject("stamp",stamp);
        return mv;
    }
    @RequestMapping("/assetsScrapByApp/assetsScrapAppAudit")
    public ModelAndView assetsScrapAppAudit(String id){
        ModelAndView mv=new ModelAndView("/app/synergy/workflow/appworkflow/assetsScrapAppAudit");
        AssetsScrap assetsScrap = assetsScrapService.getAssetsById(id);
        mv.addObject("assetsScrap",assetsScrap);
        return mv;
    }
    /*软件安装*/
    @Resource
    private SoftInstallService softInstallService;
    @RequestMapping("/app/workflow/softInstallApp")
    public ModelAndView softInstallResoult(String id){
        ModelAndView mv=new ModelAndView("/app/synergy/workflow/appworkflow/softInstallApp");
        SoftInstall softInstall=softInstallService.getSoftById(id);
        mv.addObject("softInstall",softInstall);
        return mv;
    }
    /*计算机耗材*/
    @Resource
    public ComputerService computerService;
    @RequestMapping("/app/workflow/computerApp")
    public ModelAndView computerResoult(String id){
        ModelAndView mv=new ModelAndView("/app/synergy/workflow/appworkflow/computerApp");
        Computer computer = computerService.getComputerById(id);
        mv.addObject("computer",computer);
        return mv;
    }
    /*设备调用*/
    @Resource
    private com.goisan.synergy.workflow.service.DeviceUseService DeviceUseService;
    @RequestMapping("/app/workflow/deviceApp")
    public ModelAndView deviceResoult(String id){
        ModelAndView mv=new ModelAndView("/app/synergy/workflow/appworkflow/deviceApp");
        DeviceUse deviceUse = DeviceUseService.getDeviceUseById(id);
        mv.addObject("deviceuse",deviceUse);
        return mv;
    }
    /*礼堂音控室申请*/
    @Resource
    private HallsoundroomService hallsoundroomService;
    @RequestMapping("/app/workflow/hallsound")
    public ModelAndView hallsoundRoomResoult(String id) {
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/appworkflow/hallsound");
        Hallsoundroom hallsoundroom=hallsoundroomService.getHallsoundroomById(id);
        mv.addObject("hallsoundroom",hallsoundroom);
        return mv;
    }
    /**
     * Created by lhy on 2017/9/9.
     start*/
    @Resource
    private BusinessCarService businessCarService;
    @Resource
    private DraftPaperService draftPaperService;
    @Resource
    private FileQueryService fileQueryService;
    @Resource
    private LeaveService leaveService;
    @Resource
    private LeaveCancelService leaveCancelService;
    @Resource
    private PublicityDeliveryService publicityDeliveryService;
    @Resource
    private ShopItemsReceiveService shopItemsReceiveService;
    @Resource
    private HotelStayService hotelStayService;
    @Resource
    private ScreenUseService screenUseService;
    @Resource
    private OfficeItemService officeItemService;
    @Resource
    private FundsService fundsService;
    @Resource
    private SalaryService salaryService;
    @Resource
    private GoodsPurchasingService goodsPurchasingService;
    @Resource
    private StudentLeaveService studentLeaveService;
    @Resource
    private Funds1Service funds1Service;
    @Resource
    private Funds2Service funds2Service;
    @Resource
    private Funds3Service funds3Service;

    @RequestMapping("/app/workflow/shopItemsReceiveApp")
    public ModelAndView shopItemsReceiveResult(String id) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/app/synergy/workflow/appworkflow/shopItemsReceiveProcessByApp");
        ShopItemsReceive shopItemsReceive = shopItemsReceiveService.getShopItemsReceiveById(id);
        mv.addObject("shopItemsReceive", shopItemsReceive);
        return mv;
    }
    @ResponseBody
    @RequestMapping("/app/workflow/publicityDeliveryApp")
    public ModelAndView publicityDeliveryResult(String id) {
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/appworkflow/auditPublicityDeliveryByApp");
        PublicityDelivery publicityDelivery = publicityDeliveryService.getPublicityDeliveryById(id);
        mv.addObject("publicityDelivery", publicityDelivery);
        return mv;
    }
    @ResponseBody
    @RequestMapping("/app/workflow/leaveCancelApp")
    public ModelAndView leaveCancelResult(String id) {
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/appworkflow/addLeaveCancelProcessByApp");
        LeaveCancel leaveCancel= leaveCancelService.getCancelById(id);
        mv.addObject("leaveCancel", leaveCancel);
        return mv;
    }
    @ResponseBody
    @RequestMapping("/app/workflow/leaveApp")
    public ModelAndView leaveResult(String id) {
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/appworkflow/auditLeaveById");
        Leave leave = leaveService.getLeaveBy(id);
        mv.addObject("leave", leave);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/app/workflow/studentLeaveApp")
    public ModelAndView studentLeaveResult(String id) {
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/appworkflow/auditStudentLeaveById");
        StudentLeave leave = studentLeaveService.getLeaveBy(id);
        mv.addObject("leave", leave);
        return mv;
    }


    @ResponseBody
    @RequestMapping("/app/workflow/fileQueryApp")
    public ModelAndView fileQueryResult(String id) {
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/appworkflow/addFileQueryProcessByApp");
        FileQuery fileQuery = fileQueryService.getFileQueryById(id);
        mv.addObject("fileQuery", fileQuery);
        return mv;
    }
    @RequestMapping("/app/workflow/businessCarApp")
    public ModelAndView businessCarResult(String id) {
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/appworkflow/businessCarProcessByApp");
        BusinessCar businessCar = businessCarService.getBusinessCarBy(id);
        mv.addObject("businessCar", businessCar);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/app/workflow/draftPaperApp")
    public ModelAndView draftPaperResult(String id) {
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/appworkflow/addDraftPaperProcessByApp");
        DraftPaper draftPaper = draftPaperService.getDraftPaperById(id);
        mv.addObject("draftPaper", draftPaper);
        return mv;
    }
    @ResponseBody
    @RequestMapping("/app/workflow/hotelStayApp")
    public ModelAndView hotelStayResult(String id) {
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/appworkflow/hotelStayApp");
        HotelStay hotelStay = hotelStayService.getHotelStayById(id);
        mv.addObject("hotelStay", hotelStay);
        return mv;
    }
    @ResponseBody
    @RequestMapping("/app/workflow/screenUseApp")
    public ModelAndView screenUseResult(String id) {
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/appworkflow/screenUseApp");
        ScreenUse screenUse = screenUseService.getScreenUseById(id);
        mv.addObject("screenUse", screenUse);
        return mv;
    }
    @ResponseBody
    @RequestMapping("/app/workflow/officeItemApp")
    public ModelAndView officeItemResult(String id) {
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/appworkflow/officeItemApp");
        OfficeItem officeItem = officeItemService.getOfficeItemById(id);
        mv.addObject("officeItem", officeItem);
        return mv;
    }
    @Resource
    private MessageService messageService;
    @ResponseBody
    @RequestMapping("/app/workflow/messageApp")
    public ModelAndView messageAppResult(String id) {
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/appworkflow/messageApp");
        Message message = messageService.getMessageById(id);
        mv.addObject("message", message);
        return mv;
    }
    @ResponseBody
    @RequestMapping("/app/workflow/fundsApp")
    public ModelAndView fundsResult(String id) {
        String personId = CommonUtil.getPersonId();
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/appworkflow/fundsApp");
        Funds funds = fundsService.getFundsById(id);
        List list = (List) new ArrayList();
        List<IndexUnAudti> indexUnAudtis = workflowService.getRelationListById(personId,id);
        for(int i=0;i<indexUnAudtis.size();i++){
            HashMap map = new HashMap();
            map.put("businessId",indexUnAudtis.get(i).getBusinessId());
            map.put("name",indexUnAudtis.get(i).getName());
            map.put("workflowName",indexUnAudtis.get(i).getWorkflowName());
            map.put("createTime",indexUnAudtis.get(i).getCreateTime());
            /*map.put("tel",emp.get(i).getTel());*/
            list.add(map);
        }
        mv.addObject("list",list);
        mv.addObject("funds",funds);
        return mv;
    }
    @ResponseBody
    @RequestMapping("/app/workflow/funds1App")
    public ModelAndView funds1Result(String id) {
        String personId = CommonUtil.getPersonId();
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/appworkflow/funds1App");
        Funds1 funds1 = funds1Service.getFundsById(id);
        List list = (List) new ArrayList();
        List<IndexUnAudti> indexUnAudtis = workflowService.getRelationListById(personId,id);
        for(int i=0;i<indexUnAudtis.size();i++){
            HashMap map = new HashMap();
            map.put("businessId",indexUnAudtis.get(i).getBusinessId());
            map.put("name",indexUnAudtis.get(i).getName());
            map.put("workflowName",indexUnAudtis.get(i).getWorkflowName());
            map.put("createTime",indexUnAudtis.get(i).getCreateTime());
            /*map.put("tel",emp.get(i).getTel());*/
            list.add(map);
        }
        mv.addObject("list",list);
        mv.addObject("funds",funds1);
        return mv;
    }
    @ResponseBody
    @RequestMapping("/app/workflow/funds2App")
    public ModelAndView funds2Result(String id) {
        String personId = CommonUtil.getPersonId();
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/appworkflow/funds2App");
        Funds2 funds2 = funds2Service.getFundsById(id);
        List list = (List) new ArrayList();
        List<IndexUnAudti> indexUnAudtis = workflowService.getRelationListById(personId,id);
        for(int i=0;i<indexUnAudtis.size();i++){
            HashMap map = new HashMap();
            map.put("businessId",indexUnAudtis.get(i).getBusinessId());
            map.put("name",indexUnAudtis.get(i).getName());
            map.put("workflowName",indexUnAudtis.get(i).getWorkflowName());
            map.put("createTime",indexUnAudtis.get(i).getCreateTime());
            /*map.put("tel",emp.get(i).getTel());*/
            list.add(map);
        }
        mv.addObject("list",list);
        mv.addObject("funds",funds2);
        return mv;
    }
    @ResponseBody
    @RequestMapping("/app/workflow/funds3App")
    public ModelAndView funds3Result(String id) {
        String personId = CommonUtil.getPersonId();
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/appworkflow/funds3App");
        Funds3 funds3 = funds3Service.getFundsById(id);
        List list = (List) new ArrayList();
        List<IndexUnAudti> indexUnAudtis = workflowService.getRelationListById(personId,id);
        for(int i=0;i<indexUnAudtis.size();i++){
            HashMap map = new HashMap();
            map.put("businessId",indexUnAudtis.get(i).getBusinessId());
            map.put("name",indexUnAudtis.get(i).getName());
            map.put("workflowName",indexUnAudtis.get(i).getWorkflowName());
            map.put("createTime",indexUnAudtis.get(i).getCreateTime());
            /*map.put("tel",emp.get(i).getTel());*/
            list.add(map);
        }
        mv.addObject("list",list);
        mv.addObject("funds",funds3);
        return mv;
    }
    @ResponseBody
    @RequestMapping("/app/workflow/salaryApp")
    public ModelAndView salaryResult(String id) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/app/synergy/workflow/appworkflow/salaryApp");
        Salary salary = salaryService.getSalaryById(id);
        mv.addObject("salary",salary);
        return mv;
    }
    /**报销管理*/
    @ResponseBody
    @RequestMapping("/app/workflow/reimbursementApp")
    public ModelAndView reimbursementResult(String id) {
        String personId = CommonUtil.getPersonId();
        String workflowCode="T_BG_REIMBURSEMENT_WF01";
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/app/synergy/workflow/appworkflow/reimbursementApp");
        Reimbursement reimbursement =reimbursementService.getReimbursementById(id);
        List list = (List) new ArrayList();
        String wid = reimbursementService.getWorkflowIdByWorkflowCode(workflowCode);
        List<IndexUnAudti> indexUnAudtis = reimbursementService.getRelationListById(personId,id,wid);
        for(int i=0;i<indexUnAudtis.size();i++){
            HashMap map = new HashMap();
            map.put("businessId",indexUnAudtis.get(i).getBusinessId());
            map.put("name",indexUnAudtis.get(i).getName());
            map.put("workflowName",indexUnAudtis.get(i).getWorkflowName());
            map.put("createTime",indexUnAudtis.get(i).getCreateTime());
            /*map.put("tel",emp.get(i).getTel());*/
            list.add(map);
        }
        mv.addObject("list",list);
        mv.addObject("reimbursement",reimbursement);
        return mv;
    }
    @RequestMapping("/salaryApp/result/listUnDo")
    public ModelAndView listTask(String type) {
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/commonjsp/unSalaryList");
        String emJson = listTaskDownSalaryRefresh(1,type);
        mv.addObject("emJson", emJson);
        mv.addObject("type", type);
        mv.addObject("typeName","工资单列表");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/evaluationApp/result/listTaskDownSalaryRefresh")
    public String listTaskDownSalaryRefresh(int page,String Type) {
        LoginUser login = CommonUtil.getLoginUser();
        String personid = login.getPersonId();
        Emp emp =  empService.getEmpByEmpId("",personid);
        //mv.addObject("idCard",emp.getIdCard());
        List<Salary> salaryList = salaryService.getListUnDoSalaryAppByType(emp.getIdCard());
        return getJsonEEList(salaryList,page);
    }
    /**公告待办*/
    @ResponseBody
    @RequestMapping("/app/workflow/noticeApp")
    public ModelAndView noticeApp(String id) {
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/appworkflow/noticeApp");
        Notice notice =noticeService.getNoticeById(id);
        mv.addObject("notice", notice);
        return mv;
    }
    /**物品采购待办*/
    @ResponseBody
    @RequestMapping("/app/workflow/goodsPurchasing")
    public ModelAndView goodsPurchasingApp(String id) {
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/appworkflow/goodsPurchasingApp");
        GoodsPurchasing goodsPurchasing = goodsPurchasingService.getGoodsPurchasingById(id);
        mv.addObject("goodsPurchasing", goodsPurchasing);
        return mv;
    }
    /**
     * 团委款项待办*/
    @Resource
    private LeaguesService leaguesService;
    @ResponseBody
    @RequestMapping("/app/workflow/leaguesApp")
    public ModelAndView leaguesResult(String id) {
        String personId = CommonUtil.getPersonId();
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/appworkflow/leaguesApp");
        Leagues leagues =leaguesService.getLeaguesById(id);
        String wid=workflowService.getWorkflowIdByWorkflowCode("T_BG_LEAGUE_WF01");
        List list = (List) new ArrayList();
        List<IndexUnAudti> indexUnAudtis = reimbursementService.getRelationListById(personId,wid,id);
        for(int i=0;i<indexUnAudtis.size();i++){
            HashMap map = new HashMap();
            map.put("businessId",indexUnAudtis.get(i).getBusinessId());
            map.put("name",indexUnAudtis.get(i).getName());
            map.put("workflowName",indexUnAudtis.get(i).getWorkflowName());
            map.put("createTime",indexUnAudtis.get(i).getCreateTime());
            /*map.put("tel",emp.get(i).getTel());*/
            list.add(map);
        }
        mv.addObject("list",list);
        mv.addObject("leagues",leagues);
        return mv;
    }

    public String getJsonEEList(List<Salary> salaryList, int page){

        int from = ( page - 1 ) * 10 ;
        int end  = page * 10 ;
        int len = salaryList.size();
        // 如果 开始序号 > 列表长度  那么不返回数据
        from = from > len ? len+10 :from ;
        // 如果 结束序号 > 列表长度  那么以列表长度 为结束序号
        end = end > len ? len :end ;

        String str ="";
        boolean b =true;
        for(int i=from;i< end;i++ ){
            Salary salary = salaryList.get(i);
            String name = salary.getName();
            try {
                name =java.net.URLEncoder.encode(name,"UTF-8");
                name =java.net.URLEncoder.encode(name,"UTF-8");
            } catch (UnsupportedEncodingException e1) {
                // TODO Auto-generated catch block
                e1.printStackTrace();
            }

            String obj = "{\"id\":\"" +salary.getId()+"\"," +
                    "\"year\":\""+salary.getYear()+"\","+
                    "\"month\":\""+salary.getMonth()+"\","+
                    "\"name\":\""+name+"\","+
                    "\"createTime\":\""+salary.getCreateTime()+"\"}";
            if(b){
                str =obj;
                b = false;
            }
            else{
                str = str +","+ obj;
            }
        }
        return "["+str+"]";
    }
    /**APP工作流申请列表页*/
    @RequestMapping("/workflowApp/result/listStart")
    public ModelAndView listStart(String type){
        ModelAndView mv=new ModelAndView("/app/synergy/workflow/apprequestworkflow/startList");
        String emJson = getWorkFlowNameAppList(1,type);
        mv.addObject("emJson", emJson);
        mv.addObject("type", type);
        mv.addObject("typeName", "申请");
        return mv;
    }
    /**申请列表数据查询*/
    @ResponseBody
    @RequestMapping("/workflowApp/result/getWorkFlowNameAppList")
    public String getWorkFlowNameAppList(int page ,String type) {
        List<Workflow> workFlow = null;
        workFlow = workflowService.getAppStartList();
        return getJsonRequestList(workFlow,page);
    }
    /**传参*/
    public String getJsonRequestList(List<Workflow> WorkFlowList, int page){
        int from = ( page - 1 ) * 10 ;
        int end  = page * 10 ;
        int len = WorkFlowList.size();
        // 如果 开始序号 > 列表长度  那么不返回数据
        from = from > len ? len+10 :from ;
        // 如果 结束序号 > 列表长度  那么以列表长度 为结束序号
        end = end > len ? len :end ;
        String str ="";
        boolean b =true;
        for(int i=from;i< end;i++ ){
            Workflow workflow = WorkFlowList.get(i);
            String workFlowName = workflow.getWorkflowName();
            try {
                workFlowName =java.net.URLEncoder.encode(workFlowName,"UTF-8");
            } catch (UnsupportedEncodingException e1) {
                // TODO Auto-generated catch block
                e1.printStackTrace();
            }
            String obj = "{\"workflowName\":\"" +workFlowName+"\",\"tableName\":\""+workflow.getTableName()+"\"," +
                    "\"url\":\"" +workflow.getUrl()+"\",\"workflowId\":\"" +workflow.getWorkflowId()+"\"}" ;
            if(b){
                str =obj;
                b = false;
            }
            else{
                str = str +","+ obj;
            }
        }
        return "["+str+"]";
    }
    /**单个工作流新增页*/
    @RequestMapping("/workFlowApp/result/getWorkFlowRequest")
    public ModelAndView getWorkFlowRequest(String tableName,String workflowId,String url) {
        ModelAndView mv=new ModelAndView("/app/synergy/workflow/apprequestworkflow/requestAppInfo");
        mv.addObject("workflowId",workflowId);
        mv.addObject("tableName",tableName);
        mv.addObject("url", url);
        return mv;
    }
    //手机端待办培训申请展示
    public String getJsonTrainingList(List<Start> workFlowAppList, int page, String type){
        int from = ( page - 1 ) * 10 ;
        int end  = page * 10 ;
        int len = workFlowAppList.size();
        // 如果 开始序号 > 列表长度  那么不返回数据
        from = from > len ? len+10 :from ;
        // 如果 结束序号 > 列表长度  那么以列表长度 为结束序号
        end = end > len ? len :end ;

        String str ="";
        String time = "";
        boolean b =true;
        for(int i=from;i< end;i++ ){
            Start start = workFlowAppList.get(i);
            String personID = start.getCreator();
            String id = start.getBusinessId();
            String personName = empService.getPersonNameById(personID);
            String workFlowId = start.getWorkflowId();//培训形式
            String tableName = start.getTableName();
            String workFlowName = "参加"+start.getHandleName();
          /*  if (workFlowName.indexOf("申请")!=-1){
                workFlowName = workFlowName.substring(0,workFlowName.length()-2);
            }if("1".equals(type)){
                workFlowName = "";
            }*/
            if (!"".equals(personName)){
                try {
                    personName =java.net.URLEncoder.encode(personName,"UTF-8");
                    workFlowName =java.net.URLEncoder.encode(workFlowName,"UTF-8");
                    tableName =java.net.URLEncoder.encode(tableName,"UTF-8");

                } catch (UnsupportedEncodingException e1) {
                    // TODO Auto-generated catch block
                    e1.printStackTrace();
                }
            }

            /*SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            java.util.Date date = format1.parse(fillTime);
            SimpleDateFormat format2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String sdate=format2.format(date);
            Timestamp fTimestamp=Timestamp.valueOf(sdate);*/
            time = start.getCreateTime().toString();
            time = time.split(" ")[0];
            String obj = "{\"startId\":\"" +start.getStartId()+"\"," +
                    "\"id\":\"" +id+"\"," +
                    "\"personName\":\""+personName+"\","+
                    "\"workFlowName\":\""+workFlowName+"\","+
                    "\"tableName\":\""+tableName+"\","+
                    "\"createTime\":\""+time+"\"}";
            if(b){
                str =obj;
                b = false;
            }
            else{
                str = str +","+ obj;
            }
        }
        return "["+str+"]";
    }

    //手机端待办展示培训内容详情
    @RequestMapping("/workFlowApp/result/trainResult")
    public ModelAndView listTrainResult(String id,String startId,String type) {
        ModelAndView mv=new ModelAndView();
        String taskId=id;
        SysTask sysTask = taskService.selectSysTaskByTaskId(taskId);
        id=sysTask.getTaskBusinessId();
        Training training= trainingService.getDepartmentTrainingById(id);
        mv.addObject("sysTask", sysTask);
        mv.addObject("training", training);
        mv.addObject("head", "");
        mv.setViewName("/app/synergy/workflow/commonjsp/auditTrainApp");
        return  mv;
    }

    /*手机端已办理通知显示*/

    public String getJsonCompleteList(List<Start> workFlowAppList, int page, String type, String abc){
        int from = ( page - 1 ) * 10 ;
        int end  = page * 10 ;
        int len = workFlowAppList.size();
        // 如果 开始序号 > 列表长度  那么不返回数据
        from = from > len ? len+10 :from ;
        // 如果 结束序号 > 列表长度  那么以列表长度 为结束序号
        end = end > len ? len :end ;

        String str ="";
        String time = "";
        boolean b =true;
        for(int i=from;i< end;i++ ){
            Start start = workFlowAppList.get(i);
            String personID = start.getCreator();
            String id = start.getBusinessId();
            String personName = empService.getPersonNameById(personID);
            String workFlowId = start.getWorkflowId();//培训形式
            String tableName = start.getTableName();
            String workFlowName = start.getWorkflowName();
          /*  if (workFlowName.indexOf("申请")!=-1){
                workFlowName = workFlowName.substring(0,workFlowName.length()-2);
            }if("1".equals(type)){
                workFlowName = "";
            }*/
            if (!"".equals(personName)){
                try {
                    personName =java.net.URLEncoder.encode(personName,"UTF-8");
                    workFlowName =java.net.URLEncoder.encode(workFlowName,"UTF-8");
                    tableName =java.net.URLEncoder.encode(tableName,"UTF-8");

                } catch (UnsupportedEncodingException e1) {
                    // TODO Auto-generated catch block
                    e1.printStackTrace();
                }
            }

            /*SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            java.util.Date date = format1.parse(fillTime);
            SimpleDateFormat format2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String sdate=format2.format(date);
            Timestamp fTimestamp=Timestamp.valueOf(sdate);*/
            time = start.getCreateTime().toString();
            time = time.split(" ")[0];
            String obj = "{\"startId\":\"" +start.getStartId()+"\"," +
                    "\"id\":\"" +id+"\"," +
                    "\"personName\":\""+personName+"\","+
                    "\"workFlowName\":\""+workFlowName+"\","+
                    "\"tableName\":\""+tableName+"\","+
                    "\"createTime\":\""+time+"\","+
                    "\"abc\":\""+abc+"\"}";
            if(b){
                str =obj;
                b = false;
            }
            else{
                str = str +","+ obj;
            }
        }
        return "["+str+"]";
    }
    @RequestMapping("/attendanceApp/result/listAttendance")
    public ModelAndView listAttendance(String type) {
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/commonjsp/attendanceList");
        String emJson = listTaskDownAttendanceRefresh(1,type);
        mv.addObject("emJson", emJson);
        mv.addObject("type", type);
        mv.addObject("typeName","个人考勤列表");
        return mv;
    }
    @ResponseBody
    @RequestMapping("/evaluationApp/result/listTaskDownAttendanceRefresh")
    public String listTaskDownAttendanceRefresh(int page,String type) {
        LoginUser login = CommonUtil.getLoginUser();
        String personId = login.getPersonId();
        Emp emp =  empService.getEmpByEmpId("",personId);
        //mv.addObject("idCard",emp.getIdCard());
        List<AttendanceInfo> attendanceList = attendanceService.getListUnDoAttendanceAppByType(emp.getIdCard());
        return getJsonAttendanceList(attendanceList,page);
    }
    @ResponseBody
    @RequestMapping("/app/workflow/attendanceApp")
    public ModelAndView attendanceResult(String id) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/app/synergy/workflow/appworkflow/attendanceApp");
        AttendanceInfo attendance = attendanceService.getInfoById(id);
        mv.addObject("attendance",attendance);
        return mv;
    }
    public String getJsonAttendanceList(List<AttendanceInfo> attendanceList, int page){
        int from = ( page - 1 ) * 10 ;
        int end  = page * 10 ;
        int len = attendanceList.size();
        // 如果 开始序号 > 列表长度  那么不返回数据
        from = from > len ? len+10 :from ;
        // 如果 结束序号 > 列表长度  那么以列表长度 为结束序号
        end = end > len ? len :end ;
        String str ="";
        boolean b =true;
        for(int i=from;i< end;i++ ){
            AttendanceInfo attendanceInfo = attendanceList.get(i);
            String name = attendanceInfo.getName();
            try {
                name =java.net.URLEncoder.encode(name,"UTF-8");
                name =java.net.URLEncoder.encode(name,"UTF-8");
            } catch (UnsupportedEncodingException e1) {
                // TODO Auto-generated catch block
                e1.printStackTrace();
            }
            String obj = "{\"id\":\"" +attendanceInfo.getId()+"\"," +
                    "\"year\":\""+attendanceInfo.getYear()+"\","+
                    "\"month\":\""+attendanceInfo.getMonth()+"\","+
                    "\"name\":\""+name+"\","+
                    "\"createTime\":\""+attendanceInfo.getCreateTime()+"\"}";
            if(b){
                str =obj;
                b = false;
            }
            else{
                str = str +","+ obj;
            }
        }
        return "["+str+"]";
    }
    /**
     * 移动端待办查询报修管理*/
    @Resource
    private RepairService repairService;
    @RequestMapping("/workFlowApp/result/repairInfoApp")
    public ModelAndView repairInfoApp(String id) {
        ModelAndView mv=new ModelAndView();
        Repair repair=repairService.getRepairListInfo(id);
        mv.addObject("repair", repair);
        mv.setViewName("/app/synergy/workflow/appworkflow/repairInfoApp");
        return  mv;
    }

    /**
     * 维修任务分配详情查看
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("/app/workflow/repairTaskApp")
    public ModelAndView repairTaskResult(String repairID,String id, String title, String requestFlagShow) {
        ModelAndView mv = new ModelAndView();
        Repair repair = new Repair();

        Repair salary = new Repair();
        if ("2".equals(requestFlagShow)) {
            repair.setRepairID(id);
            mv.setViewName("/app/synergy/workflow/appworkflow/repairTaskAppRead");
            salary = repairService.getRepairByRepairExecuteIdApp(repair);
        } else if ("3".equals(requestFlagShow)) {
            repair.setRepairID(id);
            mv.setViewName("/app/synergy/workflow/appworkflow/repairTaskAppReadOnly");
            salary = repairService.getRepairByRepairExecuteIdApp(repair);
        } else {
            repair.setRepairID(repairID);
            mv.setViewName("/app/synergy/workflow/appworkflow/repairTaskApp");
            salary = repairService.getRepairByRepairIdApp(repair);
        }
        String[] name_id = salary.getItemName().split(",");
        String newname = "", name="";
        for (int j = 0; j < name_id.length; j++) {
            String a = name_id[j];
            name = userDicService.getDicName(a);
            if (name != null) {
                newname = newname + name + ",";
            }
        }
        if(!"".equals(newname)) newname = newname.substring(0,newname.length()-1);
        salary.setItemNameShow(newname);
        mv.addObject("salary", salary);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/repair/FenPeiRepairPerson")
    public com.goisan.system.tools.Message FenPeiRepairPerson(String ids, String repairID) {
        Repair repair = new Repair();
        repair.setRepairID(repairID);
        repair.setCreator(CommonUtil.getPersonId());
        repair.setCreateDept(CommonUtil.getDefaultDept());
        String[] arr_id = ids.split(",");
        if (arr_id.length < 1) {
            repair.setPersonName(ids);
            repair.setDeptName(commonService.getDeptIdByPersonId(ids));
            repair.setRepairID(repairID);
        } else {
            for (int i = 0; i < arr_id.length; i++) {
                repair.setPersonName(arr_id[i]);
                repair.setDeptName(commonService.getDeptIdByPersonId(arr_id[i]));
                repair.setRepairID(repairID);
                repairService.insertRepairExecute(repair);
            }
        }
        repairService.repairFenPei(repair);
        return new com.goisan.system.tools.Message(1, "分配成功！", null);
    }

    /**
     * 获取维修人员树
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("/common/getRepairPersonTree")
    public List<Tree> getRepairPersonTree() {
        List<Select2> selectList = repairService.getRepairPersonTree();
        return getDictToRepairTree(selectList);
    }

    /**
     * 将List<Select2>转换为List<Tree>
     *
     * @param selectList
     * @return
     */
    public List<Tree> getDictToRepairTree(List<Select2> selectList) {
        List<Tree> treeList = new ArrayList<Tree>();
        for (int i = 0; i < selectList.size(); i++) {
            Select2 select = selectList.get(i);
            Tree tree = new Tree();
            tree.setId(select.getId());
            tree.setName(select.getText());
            treeList.add(tree);
        }
        return treeList;
    }
}
