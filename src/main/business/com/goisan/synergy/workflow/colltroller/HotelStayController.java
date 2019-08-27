package com.goisan.synergy.workflow.colltroller;

import com.goisan.synergy.workflow.bean.HotelStay;
import com.goisan.synergy.workflow.service.HotelStayService;
import com.goisan.synergy.workflow.service.StampService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.service.EmpService;
import com.goisan.system.service.FilesService;
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

/**学校商友酒店住宿管理
 * Created and modify by wq on 2017/6/20.
 */
@Controller
public class HotelStayController {
    @Resource
    private HotelStayService hotelStayService;
    @Resource
    private EmpService empService;
    @Resource
    private FilesService filesService;
    @Resource
    private WorkflowService workflowService;
    @Resource
    private StampService stampService;
    /**功能：跳转到申请页面
     * modify by wq
     * @return mv页面
     */
    @RequestMapping("/hotelStay/requet")
    public ModelAndView hotelStayList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/hotelStay/hotelStay");
        return mv;
    }
    /**功能：申请页申请信息查询
     * modify by wq
     * @return hotelStayMap
     */
    @ResponseBody
    @RequestMapping("/hotelStay/getHotelStayList")
    public Map<String, List<HotelStay>> getAssetsList(HotelStay hotelStay) {
        Map<String, List<HotelStay>> hotelStayMap = new HashMap<String, List<HotelStay>>();
        hotelStay.setCreator(CommonUtil.getPersonId());
        hotelStay.setChangeDept(CommonUtil.getDefaultDept());
        hotelStayMap.put("data", hotelStayService.getHotelStayList(hotelStay));
        return hotelStayMap;
    }
    /***
     * 功能：跳转到申请新增界面(包括申请部门，人员，时间显示)
     * modify by wq
     * @return mv界面
     */
    @ResponseBody
    @RequestMapping("/hotelStay/addHotelStay")
    public ModelAndView addHotelStay() {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/hotelStay/addHotelStay");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String datetime = date+'T'+time;
        HotelStay hotelStay=new HotelStay();
        hotelStay.setRequestDate(datetime);
        hotelStay.setCheckInTime(datetime);
        hotelStay.setCheckOutTime(datetime);
        String personName = hotelStayService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = hotelStayService.getDeptNameById(CommonUtil.getDefaultDept());
        hotelStay.setRequester(personName);
        hotelStay.setRequestDept(deptName);
        mv.addObject("head", "新增申请");
        mv.addObject("hotelStay",hotelStay);
        return mv;
    }
    /**功能：跳转到申请修改界面（回显原申请信息）
     * modify by wq
     * @return mv界面
     */
    @ResponseBody
    @RequestMapping("/hotelStay/getHotelStayById")
    public ModelAndView getHotelStayById(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/hotelStay/addHotelStay");
        HotelStay hotelStay = hotelStayService.getHotelStayById(id);
        mv.addObject("head", "申请修改");
        mv.addObject("hotelStay", hotelStay);
        return mv;
    }
    /**功能：申请信息保存（包括通过申请id是否存在选择新增或修改申请信息）
     * modify by wq
     * @return 弹窗提示
     */
    @ResponseBody
    @RequestMapping("/hotelStay/saveHotelStay")
    public Message saveHotelStay(HotelStay hotelStay){
        if(hotelStay.getId()==null || hotelStay.getId().equals("")){
            hotelStay.setCreator(CommonUtil.getPersonId());
            hotelStay.setCreateDept(CommonUtil.getDefaultDept());
            hotelStay.setRequester(CommonUtil.getPersonId());
            hotelStay.setRequestDept(CommonUtil.getDefaultDept());
            hotelStay.setId(CommonUtil.getUUID());
            hotelStayService.insertHotelStay(hotelStay);
            return new Message(1, "新增成功！", null);
        }else{
            hotelStay.setRequester(CommonUtil.getPersonId());
            hotelStay.setRequestDept(CommonUtil.getDefaultDept());
            hotelStay.setChanger(CommonUtil.getPersonId());
            hotelStay.setChangeDept(CommonUtil.getDefaultDept());
            hotelStayService.updateHotelStayById(hotelStay);
            return new Message(1, "修改成功！", null);
        }
    }
    /**功能：申请信息删除（通过申请id删除申请信息）
     * modify by wq
     * @return 弹窗提示
     */
    @ResponseBody
    @RequestMapping("/hotelStay/deleteHotelStayById")
    public Message deleteHotelStayById(String id) {
        hotelStayService.deleteHotelStayById(id);
        filesService.delFilesByBusinessId(id);
        return new Message(1, "删除成功！", null);
    }
    /**功能：待办页面跳转
     * modify by wq
     * @return mv界面
     */
    @RequestMapping("/hotelStay/process")
    public ModelAndView AssetsScrapListProcess() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/hotelStay/hotelStayProcess");
        return mv;
    }
    /**功能：待办页需处理的申请信息查询
     * modify by wq
     * @return hotelStayMap
     */
    @ResponseBody
    @RequestMapping("/hotelStay/getHotelStayListProcess")
    public Map<String, List<HotelStay>> getHotelStayListProcess(HotelStay hotelStay) {
        Map<String, List<HotelStay>> hotelStayMap = new HashMap<String, List<HotelStay>>();
        hotelStay.setCreator(CommonUtil.getPersonId());
        hotelStay.setCreateDept(CommonUtil.getDefaultDept());
        hotelStay.setChanger(CommonUtil.getPersonId());
        hotelStay.setChangeDept(CommonUtil.getDefaultDept());
        hotelStayMap.put("data", hotelStayService.getHotelStayListProcess(hotelStay));
        return hotelStayMap;
    }
    /**功能：被驳回申请的信息修改（因为界面形式不同，不能使用申请页的添加和修改方法）
     * modify by wq
     * @return mv界面
     */
    @ResponseBody
    @RequestMapping("/hotelStay/editHotelStayProcess")
    public ModelAndView auditEditAssets(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/hotelStay/editHotelStayProcess");
        HotelStay hotelStay = hotelStayService.getHotelStayById(id);
        mv.addObject("head", "修改");
        mv.addObject("hotelStay", hotelStay);
        return mv;
    }
    /**功能：已办页面跳转
     * modify by wq
     * @return mv界面
     */
    @RequestMapping("/hotelStay/complete")
    public ModelAndView AssetsScrapListComplete() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/hotelStay/hotelStayComplete");
        return mv;
    }
    /**功能：已办页已处理的申请信息查询
     * modify by wq
     * @return hotelStayMap
     */
    @ResponseBody
    @RequestMapping("/hotelStay/getHotelStayListComplete")
    public Map<String, List<HotelStay>> getHotelStayListComplete(HotelStay hotelStay) {
        Map<String, List<HotelStay>> hotelStayMap = new HashMap<String, List<HotelStay>>();
        hotelStay.setCreator(CommonUtil.getPersonId());
        hotelStay.setChanger(CommonUtil.getPersonId());
        hotelStay.setCreateDept(CommonUtil.getDefaultDept());
        hotelStay.setChangeDept(CommonUtil.getDefaultDept());
        hotelStayMap.put("data", hotelStayService.getHotelStayListComplete(hotelStay));
        return hotelStayMap;
    }
    /**功能：查看申请信息及办理流程
     * modify by wq
     * @return mv界面
     */
    @ResponseBody
    @RequestMapping("/hotelStay/auditHotelStayById")
    public ModelAndView auditAssetsById(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/hotelStay/auditHotelStay");
        HotelStay hotelStay = hotelStayService.getHotelStayById(id);
        mv.addObject("head", "审批");
        mv.addObject("hotelStay", hotelStay);
        return mv;
    }
    /**功能：办理申请
     * modify by wq
     * @return mv界面
     */
    @ResponseBody
    @RequestMapping("/hotelStay/auditHotelStay")
    public ModelAndView audithotelStay(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/hotelStay/auditHotelStay");
        HotelStay hotelStay = hotelStayService.getHotelStayById(id);
        mv.addObject("head", "办理");
        mv.addObject("hotelStay", hotelStay);
        return mv;
    }
    /**PC端打印*/
    @ResponseBody
    @RequestMapping("/hotelStay/printHotelStay")
    public ModelAndView printHallUse(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/hotelStay/printHotelStay");
        HotelStay hotelStay = hotelStayService.getHotelStayById(id);
        String workflowName = workflowService.getWorkflowNameByWorkflowCode("T_BG_HOTELSTAY_WF01");
        String state = stampService.getStateById(id);
        List<Handle> list= stampService.getHandlebyId(id);
        int size=list.size();
        mv.addObject("handleList", list);
        mv.addObject("size",size);
        mv.addObject("state",state);
        mv.addObject("data", hotelStay);
        mv.addObject("workflowName", workflowName);
        return mv;
    }
    //获取所有部门id和名称
    @ResponseBody
    @RequestMapping("/hotelStay/getDept")
    public List<AutoComplete> selectDept() {
        return hotelStayService.selectDept();
    }
    //获取所有人员id和姓名
    @ResponseBody
    @RequestMapping("/hotelStay/getPerson")
    public List<AutoComplete> getPerson() {
        return hotelStayService.selectPerson();
    }
}
