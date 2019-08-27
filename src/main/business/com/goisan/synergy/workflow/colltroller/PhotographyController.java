package com.goisan.synergy.workflow.colltroller;

import com.goisan.synergy.workflow.bean.Photography;
import com.goisan.synergy.workflow.service.PhotographyService;
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

/**
 * Created by Administrator on 2017/7/26.
 */
@Controller
public class PhotographyController {

    @Resource
    private PhotographyService photographyService;
    @Resource
    private EmpService empService;
    @Resource
    private StampService stampService;
    @Resource
    private WorkflowService workflowService;
    //跳转页面
    @RequestMapping("/photography/request1")
    public ModelAndView ITDeviceList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/photography/photograp");//跳转到这个路径下的jsp
       // mv.setViewName("/business/synergy/workflow/camera/camera");
        return mv;
    }
    //查询符合条件的数据
    @ResponseBody
    @RequestMapping("/photography/search")
    public Map<String, List<Photography>> search(Photography photography){
        Map<String, List<Photography>> photographyMap = new HashMap<String, List<Photography>>();
        photographyMap.put("data", photographyService.getPhotographyList(photography));
        return photographyMap;
    }
    //获取表中所有数据
    @ResponseBody
    @RequestMapping("/photography/getPhotographyList")
    public Map<String, List<Photography>> PhotographyAction(Photography photography) {
        Map<String, List<Photography>> photographyMap = new HashMap<String, List<Photography>>();//创建一个map集合
        photography.setCreator(com.goisan.system.tools.CommonUtil.getPersonId());
        photography.setCreateDept(com.goisan.system.tools.CommonUtil.getDefaultDept());
        List<Photography>li=photographyService.getPhotographyList(photography);
        photographyMap.put("data", photographyService.getPhotographyList(photography));
        //通过.xml中的XuZheAction方法查询数据库中的数据
        return photographyMap;//返回一个map集合
    }

    //跳转修改页面
    @ResponseBody
    @RequestMapping("/photography/updatePhotographyById")
    public ModelAndView getPhotographyList(String id) {
        ModelAndView mv = new ModelAndView("business/synergy/workflow/photography/editPhotography");
        Photography photography = photographyService.getPhotographyById(id);
        //.xml中的getXuZheById方法,通过id查询数据库中的一条数据
        mv.addObject("head", "修改"); //修改页面头部 显示的文字
        mv.addObject("photography", photography);//通过XuZhe.字段名查询字段
        return mv;
    }
    //删除一个数据
    @ResponseBody
    @RequestMapping("/photography/deletePhotographyById")
    public Message deleteDeptById(String id) {
        photographyService.deletePhotographyById(id);//.xml中的deleteXuZheById方法,通过id删除数据库中的一条数据
        return new Message(1, "删除成功！", null);
    }
    @ResponseBody
    @RequestMapping("/photography/searchPhotography")
    public Map<String, List<Photography>> searchPhotography(Photography photography) {
        Map<String, List<Photography>> photographyMap = new HashMap<String, List<Photography>>();
        photography.setCreator(com.goisan.system.tools.CommonUtil.getPersonId());
        photography.setCreateDept(com.goisan.system.tools.CommonUtil.getDefaultDept());
        photographyMap.put("data", photographyService.getPhotographyList(photography));
        return photographyMap;
    }

    //跳转新增页面
    @ResponseBody
    @RequestMapping("/photography/addPhotography")
    public ModelAndView addPhotography() {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/photography/editPhotography");//跳转到这个路径下的jsp
        Photography photography = new Photography();
        //转换控件中可以转换的显示的格式
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String datetime = date+'T'+time;
        String personName = photographyService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = photographyService.getDeptNameById(CommonUtil.getDefaultDept());
        photography.setRequestDate(datetime);//设置存入数据库的时间
        photography.setRequester(personName);
        photography.setRequestDept(deptName);
        mv.addObject("head", "新增申请");//新增页面头部 显示的文字
        mv.addObject("photography",photography);//通过XuZhe.字段名查询字段
        return mv;
    }
    //把数据存到数据库中
    @ResponseBody
    @RequestMapping("/photography/savePhotography")
    public Message savePhotography(Photography photography){
        photography.setRequestDept(CommonUtil.getDefaultDept());
        photography.setRequester(CommonUtil.getPersonId());
        if(photography.getId()==null || photography.getId().equals("")){
            photography.setCreateDept(CommonUtil.getDefaultDept());
            photography.setCreator(CommonUtil.getPersonId());
            photography.setId(CommonUtil.getUUID());
            photography.setRequestFlag("0");
            photographyService.insertPhotography(photography);
            //通过.xml中的insertXuZhe方法存储数据到数据库中
            return new Message(1, "新增成功！", null);
        }else{
            //photography.setId(CommonUtil.getUUID());
            photography.setChanger(CommonUtil.getPersonId());
            photography.setChangeDept(CommonUtil.getDefaultDept());
            photographyService.updatePhotographyById(photography);
            //通过.xml中的updateXuZheById方法修改数据库中的数据
            return new Message(1, "修改成功！", null);
        }
    }
    /**功能：待办页需处理的申请信息查看
     */
    @ResponseBody
    @RequestMapping("/photography/getPhotographyListProcess")
    public Map<String, List<Photography>> getPhotographyListProcess(Photography photography) {
        Map<String, List<Photography>> photographyMap = new HashMap<String, List<Photography>>();
        photography.setCreator(CommonUtil.getPersonId());
        photography.setCreateDept(CommonUtil.getDefaultDept());
        photography.setChanger(CommonUtil.getPersonId());
        photography.setChangeDept(CommonUtil.getDefaultDept());
        photographyMap.put("data", photographyService.getPhotographyListProcess(photography));
        return photographyMap;
    }
    /**功能：待办页面跳转
     * modify by wq
     * @return mv界面
     */
    @RequestMapping("/photography/process")
    public ModelAndView photographyListProcess() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/photography/photographyProcess");
        return mv;
    }
    /**功能：被驳回申请的信息修改（因为界面形式不同，不能使用申请页的添加和修改方法）
     * modify by wq
     * @return mv界面
     */
    @ResponseBody
    @RequestMapping("/photography/editPhotographyProcess")
    public ModelAndView auditEditAssets(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/photography/editPhotographyProcess");
        Photography photography = photographyService.getPhotographyById(id);
        mv.addObject("head", "修改");
        mv.addObject("photography", photography);
        return mv;
    }
    /**功能：已办页面跳转
     * modify by wq
     * @return mv界面
     */
    @RequestMapping("/photography/complete")
    public ModelAndView AssetsScrapListComplete() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/photography/photographyComplete");
        return mv;
    }
    /**功能：已办页已处理的申请信息查询
     * modify by wq
     * @return photographyMap
     */
    @ResponseBody
    @RequestMapping("/photography/getPhotographyListComplete")
    public Map<String, List<Photography>> getPhotographyListComplete(Photography photography) {
        Map<String, List<Photography>> photographyMap = new HashMap<String, List<Photography>>();
        photography.setCreator(CommonUtil.getPersonId());
        photography.setChanger(CommonUtil.getPersonId());
        photography.setCreateDept(CommonUtil.getDefaultDept());
        photography.setChangeDept(CommonUtil.getDefaultDept());
        photographyMap.put("data", photographyService.getPhotographyListComplete(photography));
        return photographyMap;
    }

    /**功能：查看申请信息及办理流程
     * modify by wq
     * @return mv界面
     */
    @ResponseBody
    @RequestMapping("/photography/auditPhotographyById")
    public ModelAndView auditAssetsById(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/photography/auditPhotography");
        Photography photography = photographyService.getPhotographyById(id);
        mv.addObject("head", "审批");
        mv.addObject("photography", photography);
        return mv;
    }
    /**功能：办理申请
     * modify by wq
     * @return mv界面
     */
    @ResponseBody
    @RequestMapping("/photography/auditPhotography")
    public ModelAndView auditphotography(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/photography/auditPhotography");
        Photography photography = photographyService.getPhotographyById(id);
        mv.addObject("head", "办理");
        mv.addObject("photography", photography);
        return mv;
    }
    /**PC端打印*/
    @ResponseBody
    @RequestMapping("/photography/printPhotography")
    public ModelAndView printHallUse(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/photography/printPhotography");
        Photography photography = photographyService.getPhotographyById(id);
        String workflowName =  workflowService.getWorkflowNameByWorkflowCode("T_BG_PHOTOGRAPHY_WF01");
        String state = stampService.getStateById(id);
        List<Handle> list= stampService.getHandlebyId(id);
        int size=list.size();
        mv.addObject("handleList", list);
        mv.addObject("size",size);
        mv.addObject("state",state);
        mv.addObject("data", photography);
        mv.addObject("workflowName",workflowName);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/photography/getDept")
    public List<AutoComplete> selectDept() {
        return photographyService.selectDept();
    }

    @ResponseBody
    @RequestMapping("/photography/getPerson")
    public List<AutoComplete> getPerson() {
        return photographyService.selectPerson();
    }
}

