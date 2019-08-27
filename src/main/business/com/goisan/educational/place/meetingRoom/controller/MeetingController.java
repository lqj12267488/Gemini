package com.goisan.educational.place.meetingRoom.controller;

import com.goisan.educational.place.meetingRoom.bean.MeetingRoom;
import com.goisan.educational.place.meetingRoom.service.MeetingRoomService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.service.EmpService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by hanyu on 2017/7/14.
 */
@Controller
public class MeetingController {
    @Resource
    private MeetingRoomService meetingRoomService;
    @Resource
    private EmpService empService;
    /**
     * 会议场地维护跳转
     * request by hanyue
     * modify by hanyue
     * @return
     */

    @RequestMapping("/meetingRoom/request")
    public ModelAndView meetingRoomServiceList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/educational/place/meetingRoom/meetingRoom");
        return mv;
    }
    /**
     * 会议场地维护URL
     *  url by hanyue
     *  modify by hanyue
     * @param meetingRoom
     * @return
     */

    @ResponseBody
    @RequestMapping("/meetingRoom/getMeetingRoomList")
    public Map<String, List<MeetingRoom>> buildingAction(MeetingRoom meetingRoom ) {
        Map<String, List<MeetingRoom>> meetingRoomMap = new HashMap<String, List<MeetingRoom>>();
        meetingRoom.setCreator(CommonUtil.getPersonId());
        meetingRoom.setCreateDept(CommonUtil.getDefaultDept());
        meetingRoomMap.put("data", meetingRoomService.meetingRoomAction(meetingRoom));
        return meetingRoomMap;
    }


    /**
     * 筛选
     * search by hanyue
     * modify by hanyue
     * @param meetingRoom
     * @return
     */

    @ResponseBody
    @RequestMapping("meetingRoom/search")
    public Map<String, List<MeetingRoom>> search(MeetingRoom meetingRoom){
        Map<String, List<MeetingRoom>>  meetingRoomMap = new HashMap<String, List<MeetingRoom>>();
        meetingRoom.setCreator(CommonUtil.getPersonId());
        meetingRoom.setCreateDept(CommonUtil.getDefaultDept());
        List<MeetingRoom> r = meetingRoomService.meetingRoomAction(meetingRoom);
        meetingRoomMap.put("data", r);
        return meetingRoomMap;
    }
    /**
     * 会议场地维护修改
     * update by hanyue
     * modify by hanyue
     * @param id
     * @return
     */

    @ResponseBody
    @RequestMapping("/meetingRoom/getMeetingRoomById")
    public ModelAndView getmMetingRoomById(String id) {
        ModelAndView mv = new ModelAndView("/business/educational/place/meetingRoom/addMeetingRoom");
        MeetingRoom meetingRoom = meetingRoomService.getMeetingRoomById(id);
        String personName = empService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = empService.getDeptNameById(CommonUtil.getDefaultDept());
        mv.addObject("head", "修改");
        mv.addObject("meetingRoom", meetingRoom);
        return mv;
    }
    /**
     * 会议场地维护新增
     * add by hanyue
     * modify by hanyue
     * @return
     */

    @ResponseBody
    @RequestMapping("/meetingRoom/addMeetingRoom")
    public ModelAndView addMeetingRoom() {
        ModelAndView mv = new ModelAndView("/business/educational/place/meetingRoom/editMeetingRoom");
        MeetingRoom meetingRoom=new MeetingRoom();
        String personName = empService.getPersonNameById(CommonUtil.getPersonId());
        String deptName = empService.getDeptNameById(CommonUtil.getDefaultDept());
        mv.addObject("head", "新增申请");
        mv.addObject("meetingRoom",meetingRoom);
        mv.addObject("personName",personName);
        mv.addObject("deptName", deptName);
        return mv;
    }
    /**
     * 删除会议场地
     * delete by hanyue
     * modify by hanyue
     * @param id
     * @return
     */

    @ResponseBody
    @RequestMapping("/meetingRoom/deleteMeetingRoomById")
    public Message deleteMeetingRoomById(String id) {
        meetingRoomService.deleteMeetingRoomById(id);
        return new Message(1, "删除成功！", null);
    }
    /**
     * 保存会议场地
     * save by hanyue
     * modify by hanyue
     * @param meetingRoom
     * @return
     */

    @ResponseBody
    @RequestMapping("/meetingRoom/saveMeetingRoom")
    public Message saveMeetingRoom(MeetingRoom meetingRoom){
        if(meetingRoom.getId()==null || meetingRoom.getId().equals("")){
            meetingRoom.setCreator(CommonUtil.getPersonId());
            meetingRoom.setCreateDept(CommonUtil.getDefaultDept());
            meetingRoom.setId(CommonUtil.getUUID());
            meetingRoomService.insertMeetingRoom(meetingRoom);
            return new Message(1, "新增成功！", null);
        }else{
            meetingRoom.setChanger(CommonUtil.getPersonId());
            meetingRoom.setChangeDept(CommonUtil.getDefaultDept());
            meetingRoomService.updateMeetingRoomById(meetingRoom);
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
    @RequestMapping("/meetingRoom/getDept")
    public List<AutoComplete> getDept() {
        return meetingRoomService.selectDept();
    }

    /**
     * 人员自动提示框
     * person by hanyue
     * modify by hanyue
     * @return
     */

    @ResponseBody
    @RequestMapping("/meetingRoom/getPerson")
    public List<AutoComplete> getPerson() {
        return meetingRoomService.selectPerson();
    }

    /*名称查重*/
    @ResponseBody
    @RequestMapping("/meetingRoom/checkName")
    public Message checkName(MeetingRoom meetingRoom) {
        List size = meetingRoomService.checkName(meetingRoom);
        if (size.size() > 0) {
            return new Message(1, "会议室名称重复，请重新填写！", null);
        } else {
            return new Message(0, "", null);
        }
    }
}
