package com.goisan.synergy.workflow.colltroller;

import com.goisan.appmui.tools.CommonUtil;
import com.goisan.attendance.attendance.service.AttendanceService;
import com.goisan.educational.teachingplan.bean.TeachingPlan;
import com.goisan.educational.teachingplan.service.TeachingPlanService;
import com.goisan.logistics.goodspurchasing.bean.GoodsPurchasing;
import com.goisan.logistics.goodspurchasing.service.GoodsPurchasingService;
import com.goisan.personnel.leave.bean.Leave;
import com.goisan.personnel.leave.bean.LeaveCancel;
import com.goisan.personnel.leave.service.LeaveCancelService;
import com.goisan.personnel.leave.service.LeaveService;
import com.goisan.personnel.salary.service.SalaryService;
import com.goisan.personnel.training.service.TrainingService;
import com.goisan.synergy.message.service.MessageService;
import com.goisan.synergy.notice.bean.Notice;
import com.goisan.synergy.notice.service.NoticeService;
import com.goisan.synergy.workflow.bean.*;
import com.goisan.synergy.workflow.service.*;
import com.goisan.system.bean.Emp;
import com.goisan.system.service.EmpService;
import com.goisan.task.service.TaskService;
import com.goisan.workflow.bean.IndexUnAudti;
import com.goisan.workflow.service.DefinitionService;
import com.goisan.workflow.service.WorkflowService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Controller
public class ReRequestAppController {
    @Resource
    public EmpService empService;
    @Resource
    public WorkflowService workflowService;
    @Resource
    private LeaguesService leaguesService;
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
    @Resource
    private SoftInstallService softInstallService;
    @Resource
    public ComputerService computerService;
    @Resource
    private com.goisan.synergy.workflow.service.DeviceUseService DeviceUseService;
    @Resource
    private HallsoundroomService hallsoundroomService;
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
    private MessageService messageService;
    @Resource
    private TeachingPlanService teachingPlanService;
    @Resource
    private Funds1Service funds1Service;
    @Resource
    private Funds2Service funds2Service;
    @Resource
    private Funds3Service funds3Service;
    /**
     * 款项重新申请
     */
    @RequestMapping("/app/workflow/fundsAppReRequest")
    public ModelAndView fundsAppReRequest(String id) {
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/appeditworkflow/fundsAppEdit");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        Funds funds = fundsService.getFundsById(id);
        List list = (List) new ArrayList();
        List<IndexUnAudti> indexUnAudtis = workflowService.getRelationListById(com.goisan.system.tools.CommonUtil.getPersonId(), id);
        for (int i = 0; i < indexUnAudtis.size(); i++) {
            HashMap map = new HashMap();
            map.put("businessId", indexUnAudtis.get(i).getBusinessId());
            map.put("name", indexUnAudtis.get(i).getName());
            map.put("workflowName", indexUnAudtis.get(i).getWorkflowName());
            map.put("createTime", indexUnAudtis.get(i).getCreateTime());
            /*map.put("tel",emp.get(i).getTel());*/
            list.add(map);
        }
        mv.addObject("list", list);
        mv.addObject("id", id);
        mv.addObject("funds", funds);
        return mv;
    }
    /**
     * 请款一重新申请
     */
    @RequestMapping("/app/workflow/funds1AppReRequest")
    public ModelAndView funds1AppReRequest(String id) {
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/appeditworkflow/funds1AppEdit");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        Funds1 funds1 = funds1Service.getFundsById(id);
        List list = (List) new ArrayList();
        List<IndexUnAudti> indexUnAudtis = workflowService.getRelationListById(com.goisan.system.tools.CommonUtil.getPersonId(), id);
        for (int i = 0; i < indexUnAudtis.size(); i++) {
            HashMap map = new HashMap();
            map.put("businessId", indexUnAudtis.get(i).getBusinessId());
            map.put("name", indexUnAudtis.get(i).getName());
            map.put("workflowName", indexUnAudtis.get(i).getWorkflowName());
            map.put("createTime", indexUnAudtis.get(i).getCreateTime());
            /*map.put("tel",emp.get(i).getTel());*/
            list.add(map);
        }
        mv.addObject("list", list);
        mv.addObject("id", id);
        mv.addObject("funds", funds1);
        return mv;
    }
    /**
     * 请款二重新申请
     */
    @RequestMapping("/app/workflow/funds2AppReRequest")
    public ModelAndView funds2AppReRequest(String id) {
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/appeditworkflow/funds2AppEdit");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        Funds2 funds2 = funds2Service.getFundsById(id);
        List list = (List) new ArrayList();
        List<IndexUnAudti> indexUnAudtis = workflowService.getRelationListById(com.goisan.system.tools.CommonUtil.getPersonId(), id);
        for (int i = 0; i < indexUnAudtis.size(); i++) {
            HashMap map = new HashMap();
            map.put("businessId", indexUnAudtis.get(i).getBusinessId());
            map.put("name", indexUnAudtis.get(i).getName());
            map.put("workflowName", indexUnAudtis.get(i).getWorkflowName());
            map.put("createTime", indexUnAudtis.get(i).getCreateTime());
            /*map.put("tel",emp.get(i).getTel());*/
            list.add(map);
        }
        mv.addObject("list", list);
        mv.addObject("id", id);
        mv.addObject("funds", funds2);
        return mv;
    }
    /**
     * 请款三重新申请
     */
    @RequestMapping("/app/workflow/funds3AppReRequest")
    public ModelAndView funds3AppReRequest(String id) {
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/appeditworkflow/funds3AppEdit");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        Funds3 funds3 = funds3Service.getFundsById(id);
        List list = (List) new ArrayList();
        List<IndexUnAudti> indexUnAudtis = workflowService.getRelationListById(com.goisan.system.tools.CommonUtil.getPersonId(), id);
        for (int i = 0; i < indexUnAudtis.size(); i++) {
            HashMap map = new HashMap();
            map.put("businessId", indexUnAudtis.get(i).getBusinessId());
            map.put("name", indexUnAudtis.get(i).getName());
            map.put("workflowName", indexUnAudtis.get(i).getWorkflowName());
            map.put("createTime", indexUnAudtis.get(i).getCreateTime());
            /*map.put("tel",emp.get(i).getTel());*/
            list.add(map);
        }
        mv.addObject("list", list);
        mv.addObject("id", id);
        mv.addObject("funds", funds3);
        return mv;
    }
    /**
     * 礼堂使用重新申请
     */
    @RequestMapping("/app/workflow/hallUseAppReRequest")
    public ModelAndView hallUseAppReRequest(String id){
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/appeditworkflow/hallUseAppEdit");
        HallUse hallUse = hallUseService.getHallUseById(id);
        Standard standard=new Standard();
        standard.setLevel(com.goisan.system.tools.CommonUtil.getLoginUser().getLevel());
        standard.setCreateDept(com.goisan.system.tools.CommonUtil.getDefaultDept());
        standard.setStandardType("1");
        standard = hallUseService.getHallUseStandard(standard);
        mv.addObject("standard", standard);
        mv.addObject("hallUse",hallUse);
        mv.addObject("id", id);
        return mv;
    }
    /**
     * 公告重新申请
     */
    @RequestMapping("/app/workflow/noticeAppReRequest")
    public ModelAndView noticeAppReRequest(String id){
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/appeditworkflow/noticeAppEdit");
        Notice notice = noticeService.getNoticeById(id);
        mv.addObject("notice",notice);
        mv.addObject("id", id);
        return mv;
    }
    /**
     * 公务用车重新申请
     */
    @RequestMapping("/app/workflow/businessCarAppReRequest")
    public ModelAndView businessCarAppReRequest(String id){
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/appeditworkflow/businessCarAppEdit");
        BusinessCar businessCar = businessCarService.getBusinessCarById(id);
        mv.addObject("businessCar",businessCar);
        return mv;
    }
    /**
     * 摄像管理重新申请
     */
    @RequestMapping("/app/workflow/cameraAppReRequest")
    public ModelAndView cameraAppReRequest(String id){
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/appeditworkflow/cameraAppEdit");
        Camera camera = cameraService.getCameraById(id);
        mv.addObject("camera",camera);
        return mv;
    }
    /**
     * 物品采购重新申请
     */
    @RequestMapping("/app/workflow/goodsPurchasingAppReRequest")
    public ModelAndView goodsPurchasingAppReRequest(String id){
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/appeditworkflow/goodPurchasingAppEdit");
        GoodsPurchasing goodsPurchasing = goodsPurchasingService.getGoodsPurchasingById(id);
        mv.addObject("goodsPurchasing",goodsPurchasing);
        return mv;
    }
    /**
     * 宣传稿件投递重新申请
     */
    @RequestMapping("/app/workflow/publicityDeliveryAppReRequest")
    public ModelAndView publicityDeliveryAppReRequest(String id){
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/appeditworkflow/publicityDeliveryAppEdit");
        PublicityDelivery publicityDelivery = publicityDeliveryService.getPublicityDeliveryById(id);
        mv.addObject("publicityDelivery",publicityDelivery);
        return mv;
    }
    /**
     * 档案查询重新申请
     */
    @RequestMapping("/app/workflow/fileQueryAppReRequest")
    public ModelAndView fileQueryAppReRequest(String id){
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/appeditworkflow/fileQueryAppEdit");
        FileQuery fileQuery = fileQueryService.getFileQueryById(id);
        mv.addObject("fileQuery",fileQuery);
        return mv;
    }
    /**
     * 请假重新申请
     */
    @RequestMapping("/app/workflow/leaveAppReRequest")
    public ModelAndView leaveAppReRequest(String id){
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/appeditworkflow/leaveAppEdit");
        Leave leave = leaveService.getLeaveById(id);
        mv.addObject("leave",leave);
        mv.addObject("id",id);
        return mv;
    }
    /**
     * 请假重新申请
     */
    @RequestMapping("/app/workflow/draftPaperAppReRequest")
    public ModelAndView draftPaperAppReRequest(String id){
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/appeditworkflow/draftPaperAppEdit");
        DraftPaper draftPaper = draftPaperService.getDraftPaperById(id);
        List emps = new ArrayList();
        List<Emp> emp = empService.getEmpList(null);
        for (int i = 0; i < emp.size(); i++) {
            HashMap map = new HashMap();
            map.put("id", emp.get(i).getPersonId());
            map.put("name", emp.get(i).getName());
            map.put("tel", emp.get(i).getTel());
            map.put("dept", emp.get(i).getDeptId());
            map.put("deptName", emp.get(i).getDeptName());
            emps.add(map);
        }
        mv.addObject("emps", emps);
        mv.addObject("draftPaper",draftPaper);
        mv.addObject("id",id);
        return mv;
    }
    /**
     * 学校车辆外出重新申请
     */
    @RequestMapping("/app/workflow/schoolCarAppReRequest")
    public ModelAndView schoolCarAppReRequest(String id){
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/appeditworkflow/schoolCarAppEdit");
        SchoolCar schoolCar = schoolCarService.getSchoolCarById(id);
        mv.addObject("schoolCar",schoolCar);
        mv.addObject("id",id);
        return mv;
    }
    /**
     * 新闻重新申请
     */
    @RequestMapping("/app/workflow/newsDraftAppReRequest")
    public ModelAndView newsDraftAppReRequest(String id){
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/appeditworkflow/newsDraftAppEdit");
        NewsDraft newsDraft = newsDraftService.getNewsDraftById(id);
        mv.addObject("newsDraft",newsDraft);
        mv.addObject("id",id);
        return mv;
    }
    /**
     * 销假重新申请
     */
    @RequestMapping("/app/workflow/leaveCancelAppReRequest")
    public ModelAndView leaveCancelAppReRequest(String id){
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/appeditworkflow/leaveCancelAppEdit");
        String leaveId = leaveCancelService.getCancelById(id).getLeaveId();
        LeaveCancel leaveCancel = leaveCancelService.getById(leaveId);
        mv.addObject("leaveCancel",leaveCancel);
        mv.addObject("id",id);
        return mv;
    }
    /**
     * 非工作日重新申请
     */
    @RequestMapping("/app/workflow/noWorkDayPlaceAppReRequest")
    public ModelAndView noWorkDayPlaceAppReRequest(String id){
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/appeditworkflow/noWorkDayPlaceAppEdit");
        NoWorkDayPlace noWorkDayPlace = noWorkDayPlaceService.getNoWorkDayPlaceById(id);
        Standard standard = noWorkDayPlaceService.getNoWorkDayPlaceStandard("2");
        mv.addObject("standard", standard);
        mv.addObject("noWorkDayPlace",noWorkDayPlace);
        mv.addObject("id",id);
        return mv;
    }
    /**
     * 设备借用重新申请
     */
    @RequestMapping("/app/workflow/deviceBorrowAppReRequest")
    public ModelAndView deviceBorrowAppReRequest(String id){
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/appeditworkflow/deviceBorrowAppEdit");
        DeviceBorrow deviceBorrow = deviceBorrowService.getDeviceBorrowById(id);
        mv.addObject("deviceBorrow",deviceBorrow);
        mv.addObject("id",id);
        return mv;
    }
    /**
     * 合同印章重新申请
     */
    @RequestMapping("/app/workflow/stampsAppReRequest")
    public ModelAndView stampsAppReRequest(String id){
        ModelAndView mv = null;
        Stamp stamp = stampService.getStampById(id);
        String type = stamp.getStampFlag();
        if ("2".equals(type)) {
            mv = new ModelAndView("/app/synergy/workflow/appeditworkflow/stampAppEdit2");
        } else {
            mv = new ModelAndView("/app/synergy/workflow/appeditworkflow/stampAppEdit");
        }
        mv.addObject("id",id);
        mv.addObject("stamp", stamp);
        return mv;
    }
    /**
     * 办公物资重新申请
     */
    @RequestMapping("/app/workflow/officeItemAppReRequest")
    public ModelAndView officeItemAppReRequest(String id){
        OfficeItem officeItem = officeItemService.getOfficeItemById(id);
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/appeditworkflow/officeItemAppEdit");
        mv.addObject("id",id);
        mv.addObject("officeItem", officeItem);
        return mv;
    }
    /**
     * 设备调用重新申请
     */
    @RequestMapping("/app/workflow/deviceuseAppReRequest")
    public ModelAndView deviceuseAppReRequest(String id){
        DeviceUse deviceUse = DeviceUseService.getDeviceUseById(id);
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/appeditworkflow/deviceAppEdit");
        mv.addObject("id",id);
        mv.addObject("deviceUse", deviceUse);
        return mv;
    }
    /**
     * 软件安装重新申请
     */
    @RequestMapping("/app/workflow/softInstallAppReRequest")
    public ModelAndView softInstallAppReRequest(String id){
        SoftInstall softInstall = softInstallService.getSoftById(id);
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/appeditworkflow/softInstallAppEdit");
        mv.addObject("id",id);
        mv.addObject("softInstall", softInstall);
        return mv;
    }
    /**
     * 计算机耗材重新申请
     */
    @RequestMapping("/app/workflow/computerAppReRequest")
    public ModelAndView computerAppReRequest(String id){
        Computer computer = computerService.getComputerById(id);
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/appeditworkflow/computerAppEdit");
        mv.addObject("id",id);
        mv.addObject("computer", computer);
        return mv;
    }
    /**
     * 团委款项重新申请
     */
    @RequestMapping("/app/workflow/leaguesAppReRequest")
    public ModelAndView leaguesAppReRequest(String id){
        Leagues leagues = leaguesService.getLeaguesById(id);
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/appeditworkflow/leaguesAppEdit");
        mv.addObject("id",id);
        mv.addObject("leagues", leagues);
        return mv;
    }
    /**
     * IT设备维修重新申请
     */
    @RequestMapping("/app/workflow/itDeviceRepaiAppReRequest")
    public ModelAndView itDeviceRepaiAppReRequest(String id){
        ITDeviceRepai itDeviceRepai = ITDeviceRepaiService.getITDeviceById(id);
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/appeditworkflow/ITDeviceAppEdit");
        mv.addObject("id",id);
        mv.addObject("itDeviceRepai", itDeviceRepai);
        return mv;
    }
    /**
     * IT耗材/设备维修重新申请
     */
    @RequestMapping("/app/workflow/itSuppliesRepairAppReRequest")
    public ModelAndView itSuppliesRepairAppReRequest(String id){
        ITSuppliesRepair itSuppliesRepair = ITSuppliesRepairService.getITSuppliesRepairById(id);
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/appeditworkflow/ITSuppliesRepairAppEdit");
        mv.addObject("id",id);
        mv.addObject("itSuppliesRepair", itSuppliesRepair);
        return mv;
    }
    /**
     * 资产报废重新申请
     */
    @RequestMapping("/app/workflow/assetsScrapAppReRequest")
    public ModelAndView assetsScrapAppReRequest(String id){
        AssetsScrap assetsScrap = assetsScrapService.getAssetsById(id);
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/appeditworkflow/assetsScrapAppEdit");
        mv.addObject("id",id);
        mv.addObject("assetsScrap", assetsScrap);
        return mv;
    }
    /**
     * 学校商友酒店住宿重新申请
     */
    @RequestMapping("/app/workflow/hotelStayAppReRequest")
    public ModelAndView hotelStayAppReRequest(String id){
        HotelStay hotelStay = hotelStayService.getHotelStayById(id);
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/appeditworkflow/hotelStayAppEdit");
        mv.addObject("id",id);
        mv.addObject("hotelStay", hotelStay);
        return mv;
    }
    /**
     * 大屏幕使用重新申请
     */
    @RequestMapping("/app/workflow/screenUseAppReRequest")
    public ModelAndView screenUseAppReRequest(String id){
        ScreenUse screenUse = screenUseService.getScreenUseById(id);
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/appeditworkflow/screenUseAppEdit");
        mv.addObject("id",id);
        mv.addObject("screenUse", screenUse);
        return mv;
    }
    /**
     * 摄影重新申请
     */
    @RequestMapping("/app/workflow/photographyAppReRequest")
    public ModelAndView photographyAppReRequest(String id){
        Photography photography = photographyService.getPhotographyById(id);
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/appeditworkflow/photographyAppEdit");
        mv.addObject("id",id);
        mv.addObject("photography", photography);
        return mv;
    }
    /**
     * 摄影重新申请
     */
    @RequestMapping("/app/workflow/shopItemsReceiveAppReRequest")
    public ModelAndView shopItemsReceiveAppReRequest(String id){
        ShopItemsReceive shopItemsReceive = shopItemsReceiveService.getShopItemsReceiveById(id);
        ModelAndView mv = new ModelAndView("/app/synergy/workflow/appeditworkflow/shopItemsReceiveAppEdit");
        mv.addObject("id",id);
        mv.addObject("shopItemsReceive", shopItemsReceive);
        return mv;
    }
}
