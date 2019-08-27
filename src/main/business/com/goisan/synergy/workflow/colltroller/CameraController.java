package com.goisan.synergy.workflow.colltroller;

import com.goisan.synergy.workflow.bean.Camera;
import com.goisan.synergy.workflow.service.CameraService;
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
 * Created by Administrator on 2017/7/19.
 */
@Controller
public class CameraController {

    @Resource
    private CameraService cameraService;
    @Resource
    private EmpService empService;
    @Resource
    private StampService stampService;
    @Resource
    private WorkflowService workflowService;
    //跳转页面
    @RequestMapping("/camera/request")
    public ModelAndView ITDeviceList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/camera/camera");//跳转到这个路径下的jsp
        return mv;
    }
    //查询符合条件的数据
    @ResponseBody
    @RequestMapping("/camera/search")
    public Map<String, List<Camera>> search(Camera camera){
        Map<String, List<Camera>> cameraMap = new HashMap<String, List<Camera>>();
        camera.setCreator(CommonUtil.getPersonId());
        camera.setCreateDept(CommonUtil.getDefaultDept());
        cameraMap.put("data", cameraService.getCameraList(camera));
        return cameraMap;
    }
    //获取表中所有数据
    @ResponseBody
    @RequestMapping("/camera/getCameraList")
    public Map<String, List<Camera>> CameraAction(Camera camera) {
        Map<String, List<Camera>> cameraMap = new HashMap<String, List<Camera>>();//创建一个map集合
         camera.setCreator(com.goisan.system.tools.CommonUtil.getPersonId());
        camera.setCreateDept(com.goisan.system.tools.CommonUtil.getDefaultDept());
        //List<Camera>li=cameraService.getCameraList(camera);
        cameraMap.put("data", cameraService.getCameraList(camera));
        //通过.xml中的XuZheAction方法查询数据库中的数据
        return cameraMap;//返回一个map集合
    }

    //跳转修改页面
    @ResponseBody
    @RequestMapping("/camera/updateCameraById")
    public ModelAndView getCameraList(String id) {
        ModelAndView mv = new ModelAndView("business/synergy/workflow/camera/editCamera");
        Camera camera = cameraService.getCameraById(id);
        //.xml中的getXuZheById方法,通过id查询数据库中的一条数据
        mv.addObject("head", "修改"); //修改页面头部 显示的文字
        mv.addObject("camera", camera);//通过XuZhe.字段名查询字段
        return mv;
    }
    //删除一个数据
    @ResponseBody
    @RequestMapping("/camera/deleteCameraById")
    public Message deleteDeptById(String id) {
        cameraService.deleteCameraById(id);//.xml中的deleteXuZheById方法,通过id删除数据库中的一条数据
        return new Message(1, "删除成功！", null);
    }
    //查找
    @ResponseBody
    @RequestMapping("/camera/searchCamera")
    public Map<String, List<Camera>> searchCamera(Camera camera) {
        Map<String, List<Camera>> cameraMap = new HashMap<String, List<Camera>>();
        camera.setCreator(com.goisan.system.tools.CommonUtil.getPersonId());
        camera.setCreateDept(com.goisan.system.tools.CommonUtil.getDefaultDept());
        cameraMap.put("data", cameraService.getCameraList(camera));
        return cameraMap;
    }

    //跳转新增页面
    @ResponseBody
    @RequestMapping("/camera/addCamera")
    public ModelAndView addCamera() {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/camera/editCamera");//跳转到这个路径下的jsp
        Camera camera = new Camera();
        //转换控件中可以转换的显示的格式
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String datetime = date+'T'+time;
        String personName = cameraService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = cameraService.getDeptNameById(CommonUtil.getDefaultDept());
        camera.setRequestDate(datetime);//设置存入数据库的时间
        camera.setRequester(personName);
        camera.setRequestDept(deptName);
        mv.addObject("head", "新增申请");//新增页面头部 显示的文字
        mv.addObject("camera",camera);//通过XuZhe.字段名查询字段
        return mv;
    }
    //把数据存到数据库中
    @ResponseBody
    @RequestMapping("/camera/saveCamera")
    public Message saveCamera(Camera camera){
        camera.setRequestDept(CommonUtil.getDefaultDept());
        camera.setRequester(CommonUtil.getPersonId());
        if(camera.getId()==null || camera.getId().equals("")){
            camera.setCreateDept(CommonUtil.getDefaultDept());
            camera.setCreator(CommonUtil.getPersonId());
            camera.setId(CommonUtil.getUUID());
            camera.setRequestFlag("0");
            cameraService.insertCamera(camera);
            //通过.xml中的insertXuZhe方法存储数据到数据库中
            return new Message(1, "新增成功！", null);
        }else{
            //camera.setId(CommonUtil.getUUID());
            camera.setChanger(CommonUtil.getPersonId());
            camera.setChangeDept(CommonUtil.getDefaultDept());
            cameraService.updateCameraById(camera);
            //通过.xml中的updateXuZheById方法修改数据库中的数据
            return new Message(1, "修改成功！", null);
        }
    }
    /**功能：待办页需处理的申请信息查看
     */
    @ResponseBody
    @RequestMapping("/camera/getCameraListProcess")
    public Map<String, List<Camera>> getCameraListProcess(Camera camera) {
        Map<String, List<Camera>> cameraMap = new HashMap<String, List<Camera>>();
        camera.setCreator(CommonUtil.getPersonId());
        camera.setCreateDept(CommonUtil.getDefaultDept());
        camera.setChanger(CommonUtil.getPersonId());
        camera.setChangeDept(CommonUtil.getDefaultDept());
        cameraMap.put("data", cameraService.getCameraListProcess(camera));
        return cameraMap;
    }
    /**功能：待办页面跳转
     * modify by wq
     * @return mv界面
     */
    @RequestMapping("/camera/process")
    public ModelAndView cameraListProcess() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/camera/cameraProcess");
        return mv;
    }
    /**功能：被驳回申请的信息修改（因为界面形式不同，不能使用申请页的添加和修改方法）
     * modify by wq
     * @return mv界面
     */
    @ResponseBody
    @RequestMapping("/camera/editCameraProcess")
    public ModelAndView auditEditAssets(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/camera/editCameraProcess");
        Camera camera = cameraService.getCameraById(id);
        mv.addObject("head", "修改");
        mv.addObject("camera", camera);
        return mv;
    }
    /**功能：已办页面跳转
     * modify by wq
     * @return mv界面
     */
    @RequestMapping("/camera/complete")
    public ModelAndView AssetsScrapListComplete() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/camera/cameraComplete");
        return mv;
    }
    /**功能：已办页已处理的申请信息查询
     * modify by wq
     * @return cameraMap
     */
    @ResponseBody
    @RequestMapping("/camera/getCameraListComplete")
    public Map<String, List<Camera>> getCameraListComplete(Camera camera) {
        Map<String, List<Camera>> cameraMap = new HashMap<String, List<Camera>>();
        camera.setCreator(CommonUtil.getPersonId());
        camera.setChanger(CommonUtil.getPersonId());
        camera.setCreateDept(CommonUtil.getDefaultDept());
        camera.setChangeDept(CommonUtil.getDefaultDept());
        cameraMap.put("data", cameraService.getCameraListComplete(camera));
        return cameraMap;
    }

    /**功能：查看申请信息及办理流程
     * modify by wq
     * @return mv界面
     */
    @ResponseBody
    @RequestMapping("/camera/auditCameraById")
    public ModelAndView auditAssetsById(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/camera/auditCamera");
        Camera camera = cameraService.getCameraById(id);
        mv.addObject("head", "审批");
        mv.addObject("camera", camera);
        return mv;
    }
    /**功能：办理申请
     * modify by wq
     * @return mv界面
     */
    @ResponseBody
    @RequestMapping("/camera/auditCamera")
    public ModelAndView auditcamera(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/camera/auditCamera");
        Camera camera = cameraService.getCameraById(id);
        mv.addObject("head", "办理");
        mv.addObject("camera", camera);
        return mv;
    }
    /**PC端打印*/
    @ResponseBody
    @RequestMapping("/camera/printCamera")
    public ModelAndView printHallUse(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/camera/printCamera");
        String workflowName = workflowService.getWorkflowNameByWorkflowCode("T_BG_CAMERA_WF01");
        Camera camera = cameraService.getCameraById(id);
        mv.addObject("data", camera);
        String state = stampService.getStateById(id);
        List<Handle> list= stampService.getHandlebyId(id);
        int size=list.size();
        mv.addObject("handleList", list);
        mv.addObject("size",size);
        mv.addObject("state",state);
        mv.addObject("workflowName",workflowName);
        return mv;
    }
    @ResponseBody
    @RequestMapping("/camera/getDept")
    public List<AutoComplete> selectDept() {
        return cameraService.selectDept();
    }

    @ResponseBody
    @RequestMapping("/camera/getPerson")
    public List<AutoComplete> getPerson() {
        return cameraService.selectPerson();
    }
}


