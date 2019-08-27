package com.goisan.synergy.workflow.colltroller;

import com.goisan.synergy.workflow.bean.Hallsoundroom;
import com.goisan.synergy.workflow.service.HallsoundroomService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.service.EmpService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
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
 * Created by Administrator on 2017/5/6.
 */
@Controller
public class HallsoundroomController {
    @Resource
    private HallsoundroomService hallsoundroomService;
    @Resource
    private EmpService empService;
    /*
    RequestMapping 是数据库中的resource_url字段的数据
    mav.setViewName 是存放jsp路径的。
     */
    @RequestMapping("/hallsoundroom/request")
    public ModelAndView hallsoundroomList(){
        ModelAndView mv= new ModelAndView();
        mv.setViewName("/business/synergy/workflow/hallsoundroom/hallsoundroom");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/hallsoundroom/getHallsoundroomList")
    public Map<String,List<Hallsoundroom>> getHallsoundroomList(Hallsoundroom hallsoundroom) {
        Map<String, List<Hallsoundroom>> hallsoundroomMap = new HashMap<String, List<Hallsoundroom>>();
        hallsoundroom.setCreator(CommonUtil.getPersonId());
        hallsoundroom.setCreateDept(CommonUtil.getDefaultDept());
        hallsoundroomMap.put("data",hallsoundroomService.hallsoundroomAction(hallsoundroom));
        return hallsoundroomMap;
    }
    /*
   礼堂音控室新增页
    */
    @RequestMapping("/hallsoundroom/addHallsoundroom")
    public ModelAndView addHallsoundroom() {
        ModelAndView mv = new ModelAndView("business/synergy/workflow/hallsoundroom/editHallsoundroom");
        mv.addObject("head", "新增申请");
        Hallsoundroom hallsoundroom = new Hallsoundroom();
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");//设置日期格式
        SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
        String date = formatDate.format(new Date());
        String time = formatTime.format(new Date());
        String datetime = date+"T"+time;
        String personName = empService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = empService.getDeptNameById(CommonUtil.getDefaultDept());
        hallsoundroom.setRequestdept(deptName);
        hallsoundroom.setRequester(personName);
        hallsoundroom.setRequestdate(datetime);
        mv.addObject("hallsoundroom", hallsoundroom);
        mv.addObject("head", "礼堂音控室新增");
        return mv;
    }
    /*
    新增保存
     */
    @ResponseBody
    @RequestMapping("/hallsoundroom/insertHallsoundroom")
    public Message insertHallsoundroom(Hallsoundroom hallsoundroom){
        Date date = new Date(new Date().getTime());
        hallsoundroom.setCreator(CommonUtil.getPersonId());
        hallsoundroom.setCreateDept(CommonUtil.getDefaultDept());
        hallsoundroom.setCreateTime(CommonUtil.getDate());
        hallsoundroom.setId(CommonUtil.getUUID());
        hallsoundroomService.insertHallsoundroom(hallsoundroom);
        return new Message(1, "新增成功！", null);
    }

    @ResponseBody
    @RequestMapping("/hallsoundroom/saveHallsoundroom")
    public Message saveHallsoundroom(Hallsoundroom hallsoundroom){
        Date date = new Date(new Date().getTime());
        hallsoundroom.setCreateTime(CommonUtil.getDate());
        if(hallsoundroom.getId()==null || hallsoundroom.getId().equals("")){
            hallsoundroom.setCreator(CommonUtil.getPersonId());
            hallsoundroom.setCreateDept(CommonUtil.getDefaultDept());
            hallsoundroom.setRequester(CommonUtil.getPersonId());
            hallsoundroom.setRequestdept(CommonUtil.getDefaultDept());
            hallsoundroom.setId(CommonUtil.getUUID());
            hallsoundroomService.insertHallsoundroom(hallsoundroom);
            return new Message(1, "新增成功！", null);
        }else{
            hallsoundroom.setRequester(CommonUtil.getPersonId());
            hallsoundroom.setRequestdept(CommonUtil.getDefaultDept());
            hallsoundroom.setChanger(CommonUtil.getPersonId());
            hallsoundroom.setChangeDept(CommonUtil.getDefaultDept());
            hallsoundroomService.updateHallsoundroom(hallsoundroom);
            return new Message(1, "修改成功！", null);
        }
    }
    /*
    修改页面
     */
    @ResponseBody
    @RequestMapping("/hallsoundroom/getHallsoundroomById")
    public ModelAndView getHallsoundroomById(String id) {
        ModelAndView mv = new ModelAndView("business/synergy/workflow/hallsoundroom/editHallsoundroom");
        Hallsoundroom hallsoundroom = hallsoundroomService.getHallsoundroomById(id);
        mv.addObject("head", "礼堂音控室修改");
        mv.addObject("hallsoundroom", hallsoundroom);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/hallsoundroom/updateHallsoundroom")
    public Message updateHallsoundroom(Hallsoundroom hallsoundroom) {
        Date date = new Date(new Date().getTime());
        hallsoundroom.setChanger(CommonUtil.getPersonId());
        hallsoundroom.setChangeDept(CommonUtil.getDefaultDept());
        hallsoundroom.setChangeTime(CommonUtil.getDate());
        hallsoundroomService.updateHallsoundroom(hallsoundroom);
        return new Message(1, "修改成功！", null);
    }

    @ResponseBody
    @RequestMapping("/hallsoundroom/deleteHallsoundroomById")
    public Message deleteDeptById(String id) {
        hallsoundroomService.deleteHallsoundroomById(id);
        //菜单,按钮权限删除
        return new Message(1, "删除成功！", null);
    }
    /*
    申请页面查询
     */
    @ResponseBody
    @RequestMapping("/hallsoundroom/searchhallsoundroom")
    public Map<String, List<Hallsoundroom>> searchhallsoundroom(Hallsoundroom hallsoundroom) {
        Map<String, List<Hallsoundroom>> softMap = new HashMap<String, List<Hallsoundroom>>();
        hallsoundroom.setCreator(CommonUtil.getPersonId());
        hallsoundroom.setCreateDept(CommonUtil.getDefaultDept());
        softMap.put("data", hallsoundroomService.searchhallsoundroom(hallsoundroom));
        return softMap;
    }
    /*
    自动完成部门框
     */
    @ResponseBody
    @RequestMapping("/hallsoundroom/getDept")
    public List<AutoComplete> getDept() {
        return hallsoundroomService.selectDept();
    }
    /*
    自动完成人员框
    */
    @ResponseBody
    @RequestMapping("/hallsoundroom/getPerson")
    public List<AutoComplete> getPerson() {
        return hallsoundroomService.selectPerson();
    }

    /*
    待办业务
     */
    @RequestMapping("/hallsoundroom/process")
    public ModelAndView HallsoundroomProcessList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/hallsoundroom/hallsoundroomProcess");
        return mv;
    }
    /*待办页面初始化*/
    @ResponseBody
    @RequestMapping("/hallsoundroom/getProcessList")
    public Map<String, List<Hallsoundroom>> getProcessList(Hallsoundroom hallsoundroom) {
        Map<String, List<Hallsoundroom>> hallsoundroomMap = new HashMap<String, List<Hallsoundroom>>();
        hallsoundroom.setCreator(CommonUtil.getPersonId());
        hallsoundroom.setCreateDept(CommonUtil.getDefaultDept());
        hallsoundroom.setChanger(CommonUtil.getPersonId());
        hallsoundroom.setChangeDept(CommonUtil.getDefaultDept());
        hallsoundroomMap.put("data", hallsoundroomService.getProcessHallsoundroomList(hallsoundroom));
        return hallsoundroomMap;
    }
    @ResponseBody
    @RequestMapping("/hallsoundroom/auditHallsoundroomById")
    public ModelAndView waitRoleById(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/hallsoundroom/addHallsoundroomProcess");
        Hallsoundroom hallsoundroom = hallsoundroomService.getHallsoundroomById(id);
        mv.addObject("head", "审批");
        mv.addObject("hallsoundroom", hallsoundroom);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/process/hallsoundroom/searchHallsoundroom")
    public Map<String, List<Hallsoundroom>> processSearchHallsoundroomInstall(Hallsoundroom hallsoundroom) {
        Map<String, List<Hallsoundroom>> softMap = new HashMap<String, List<Hallsoundroom>>();
        hallsoundroom.setCreator(CommonUtil.getPersonId());
        softMap.put("data", hallsoundroomService.getProcessHallsoundroomList(hallsoundroom));
        return softMap;
    }
    /*
    已办事项
     */
    @RequestMapping("/hallsoundroom/complete")
    public ModelAndView HallsoundroomCompleteList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/hallsoundroom/hallsoundroomComplete");
        return mv;
    }
    /*已办页面初始化*/
    @ResponseBody
    @RequestMapping("/complete/hallsoundroom/searchHallsoundroom")
    public Map<String, List<Hallsoundroom>> completeSearchHallsoundroom(Hallsoundroom hallsoundroom) {
        Map<String, List<Hallsoundroom>> softMap = new HashMap<String, List<Hallsoundroom>>();
        hallsoundroom.setCreator(CommonUtil.getPersonId());
        hallsoundroom.setChanger(CommonUtil.getPersonId());
        hallsoundroom.setCreateDept(CommonUtil.getDefaultDept());
        hallsoundroom.setChangeDept(CommonUtil.getDefaultDept());
        softMap.put("data", hallsoundroomService.getCompleteHallsoundroomList(hallsoundroom));
        return softMap;
    }

    /*
   待办修改按钮
    */
    @ResponseBody
    @RequestMapping("/hallsoundroom/HallsoundroomUpdateById")
    public ModelAndView updateHallsoundroomById(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/hallsoundroom/editHallsoundroomProcess");
        Hallsoundroom hallsoundroom = hallsoundroomService.getHallsoundroomById(id);
        mv.addObject("head", "修改");
        mv.addObject("hallsoundroom", hallsoundroom);
        return mv;
    }

}
