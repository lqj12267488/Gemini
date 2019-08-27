package com.goisan.synergy.workflow.colltroller;

import com.goisan.synergy.workflow.bean.AssetsScrap;
import com.goisan.synergy.workflow.service.AssetsScrapService;
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

/**资产报废管理
 * Created by wq on 2017/5/3 0003.
 */
@Controller
public class AssetsScrapController {
    @Resource
    private AssetsScrapService assetsScrapService;
    @Resource
    private EmpService empService;
    @Resource
    private WorkflowService workflowService;
    @Resource
    private StampService stampService;
    //申请页跳转
    @RequestMapping("assetsscrap/request")
    public ModelAndView AssetsScrapList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/assetsScrap/assetsScrap");
        return mv;
    }
    //申请页列表初始化
    @ResponseBody
    @RequestMapping("/assetsScrap/getAssetsList")
    public Map<String, List<AssetsScrap>> getAssetsList(AssetsScrap assetsScrap) {
        Map<String, List<AssetsScrap>> softInstallMap = new HashMap<String, List<AssetsScrap>>();
        assetsScrap.setCreator(CommonUtil.getPersonId());
        assetsScrap.setChangeDept(CommonUtil.getDefaultDept());
        softInstallMap.put("data", assetsScrapService.getAssetsList(assetsScrap));
        return softInstallMap;
    }
    //查询列表
    @ResponseBody
    @RequestMapping("/assetsScrap/searchAssetsScrap")
    public Map<String, List<AssetsScrap>> searchAssetsScrap(AssetsScrap assetsScrap) {
        Map<String, List<AssetsScrap>> softMap = new HashMap<String, List<AssetsScrap>>();
        assetsScrap.setCreator(CommonUtil.getPersonId());
        softMap.put("data", assetsScrapService.getAssetsList(assetsScrap));
        return softMap;
    }
    //申请页添加界面跳转
    @ResponseBody
    @RequestMapping("/assetsScrap/addAssetsScrap")
    public ModelAndView addAssetsInstall() {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/assetsScrap/editAssetsScrap");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String datetime = date+'T'+time;
        AssetsScrap assetsScrap=new AssetsScrap();
        assetsScrap.setRequestDate(datetime);
        String personName = assetsScrapService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = assetsScrapService.getDeptNameById(CommonUtil.getDefaultDept());
        assetsScrap.setManager(personName);
        assetsScrap.setRequestDept(deptName);
        mv.addObject("head", "新增申请");
        mv.addObject("assetsScrap",assetsScrap);
        return mv;
    }
    //申请页修改界面跳转
    @ResponseBody
    @RequestMapping("/assetsScrap/getAssetsById")
    public ModelAndView getAssetsById(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/assetsScrap/editAssetsScrap");
        AssetsScrap assetsScrap = assetsScrapService.getAssetsById(id);
        mv.addObject("head", "申请修改");
        mv.addObject("assetsScrap", assetsScrap);
        return mv;
    }
    //新增和修改保存
    @ResponseBody
    @RequestMapping("/assetsScrap/saveAssetsScrap")
    public Message saveAssetsScrap(AssetsScrap assetsScrap){
        if(assetsScrap.getId() == null || assetsScrap.equals("") || assetsScrap.getId() == ""){
            assetsScrap.setCreator(CommonUtil.getPersonId());
            assetsScrap.setCreateDept(CommonUtil.getDefaultDept());
            assetsScrap.setManager(CommonUtil.getPersonId());
            assetsScrap.setRequestDept(CommonUtil.getDefaultDept());
            assetsScrap.setId(CommonUtil.getUUID());
            assetsScrapService.insertAssets(assetsScrap);
            return new Message(1, "新增成功！", null);
        }else{
            assetsScrap.setManager(CommonUtil.getPersonId());
            assetsScrap.setRequestDept(CommonUtil.getDefaultDept());
            assetsScrap.setChanger(CommonUtil.getPersonId());
            assetsScrap.setChangeDept(CommonUtil.getDefaultDept());
            assetsScrapService.updateAssetsById(assetsScrap);
            return new Message(1, "修改成功！", null);
        }
    }
    //删除
    @ResponseBody
    @RequestMapping("/assetsScrap/deleteAssetsById")
    public Message deleteDeptById(String id) {
        assetsScrapService.deleteAssetsById(id);
        return new Message(1, "删除成功！", null);
    }
    /*查看流程轨迹页面跳转*/
    @ResponseBody
    @RequestMapping("/assetsScrap/auditAssetsById")
    public ModelAndView auditAssetsById(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/assetsScrap/auditEditAssets");
        AssetsScrap assetsScrap = assetsScrapService.getAssetsById(id);
        mv.addObject("head", "审批");
        mv.addObject("AssetsScrap", assetsScrap);
        return mv;
    }
    /*待办事项页面跳转*/
    @RequestMapping("/assetsscrap/requestProcess")
    public ModelAndView AssetsScrapListProcess() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/assetsScrap/assetsScrapProcess");
        return mv;
    }
    /*代办页列表查询*/
    @ResponseBody
    @RequestMapping("/assetsScrap/getAssetsProcessList")
    public Map<String, List<AssetsScrap>> getAssetsScrapProcessList(AssetsScrap assetsScrap) {
        Map<String, List<AssetsScrap>> assetsMap = new HashMap<String, List<AssetsScrap>>();
        assetsScrap.setCreator(CommonUtil.getPersonId());
        assetsScrap.setCreateDept(CommonUtil.getDefaultDept());
        assetsScrap.setChanger(CommonUtil.getPersonId());
        assetsScrap.setChangeDept(CommonUtil.getDefaultDept());
        assetsMap.put("data", assetsScrapService.assetsProcessAction(assetsScrap));
        return assetsMap;
    }
    /*已办事项页面跳转*/
    @RequestMapping("assetsscrap/requestComplete")
    public ModelAndView AssetsScrapListComplete() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/assetsScrap/assetsScrapComplete");
        return mv;
    }
    /*已办页列表查询*/
    @ResponseBody
    @RequestMapping("/assetsScrap/getCompleteList")
    public Map<String, List<AssetsScrap>> getCompleteList(AssetsScrap assetsScrap) {
        Map<String, List<AssetsScrap>> assetsMap = new HashMap<String, List<AssetsScrap>>();
        assetsScrap.setCreator(CommonUtil.getPersonId());
        assetsScrap.setChanger(CommonUtil.getPersonId());
        assetsScrap.setCreateDept(CommonUtil.getDefaultDept());
        assetsScrap.setChangeDept(CommonUtil.getDefaultDept());
        assetsMap.put("data", assetsScrapService.assetsCompleteAction(assetsScrap));
        return assetsMap;
    }
    //办理页面跳转
    @ResponseBody
    @RequestMapping("/assetsScrap/auditEdit")
    public ModelAndView auditEdit(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/assetsScrap/auditEditAssets");
        AssetsScrap assetsScrap = assetsScrapService.getAssetsById(id);
        mv.addObject("head", "办理");
        mv.addObject("AssetsScrap", assetsScrap);
        return mv;
    }
    //待办修改页面跳转
    @ResponseBody
    @RequestMapping("/assetsScrap/auditEditAssets")
    public ModelAndView auditEditAssets(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/assetsScrap/addAssetsScrap");
        AssetsScrap assetsScrap = assetsScrapService.getAssetsById(id);
        mv.addObject("head", "修改");
        mv.addObject("AssetsScrap", assetsScrap);
        return mv;
    }
    /**PC端打印*/
    @ResponseBody
    @RequestMapping("/AssetsScrap/printAssetsScrap")
    public ModelAndView printHallUse(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/assetsScrap/printAssetsScrap");
        AssetsScrap assetsScrap = assetsScrapService.getAssetsById(id);
        String workflowName = workflowService.getWorkflowNameByWorkflowCode("T_BG_ASSETSSCRAP_WF01");
        String state = stampService.getStateById(id);
        List<Handle> list= stampService.getHandlebyId(id);
        int size=list.size();
        mv.addObject("handleList", list);
        mv.addObject("size",size);
        mv.addObject("state",state);
        mv.addObject("data", assetsScrap);
        mv.addObject("workflowName", workflowName);
        return mv;
    }
    //模糊查询部门名称
    @ResponseBody
    @RequestMapping("/assetsScrap/selectDept")
    public List<AutoComplete> selectDept() {
        return assetsScrapService.selectDept();
    }
    //模糊查询申请人姓名
    @ResponseBody
    @RequestMapping("/assetsScrap/getPerson")
    public List<AutoComplete> getPerson() {
        return assetsScrapService.selectPerson();
    }
    /*字段查重*/
    @ResponseBody
    @RequestMapping("/assetsScrap/checkCode")
    public Message checkCode(AssetsScrap assetsScrap){
        List size = assetsScrapService.checkCode(assetsScrap);
        if(size.size()>0){
            return new Message(2, "耗材编号重复，请重新填写！", null);
        }else{
            return new Message(0, "", null);
        }
    }
    @ResponseBody
    @RequestMapping("/assetsScrap/checkName")
    public Message checkName(AssetsScrap assetsScrap){
        List size = assetsScrapService.checkName(assetsScrap);
        if(size.size()>0){
            return new Message(1, "耗材名称重复，请重新填写！", null);
        }else{
            return new Message(0, "", null);
        }
    }
}
