package com.goisan.system.controller;

import com.goisan.system.bean.LoginUser;
import com.goisan.system.bean.ParentMessage;
import com.goisan.system.service.EmpService;
import com.goisan.system.service.ParentMessageService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Controller
public class ParentMessageController {

    @Resource
    private ParentMessageService parentMessageService;
    @Resource
    private EmpService empService;

    @RequestMapping("/parent/toParentMessageList")
    public ModelAndView toList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/core/xg/parent/message/parentMessageList");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/parent/getParentMessageList")
    public Map getList(ParentMessage parentMessage) {
        CommonUtil.save(parentMessage);
        return CommonUtil.tableMap(parentMessageService.getParentMessageList(parentMessage));
    }

    @RequestMapping("/parent/toParentMessageAdd")
    public ModelAndView toAdd() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/core/xg/parent/message/parentMessageEdit");
        mv.addObject("head", "新增");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/parent/saveParentMessage")
    public Message save(ParentMessage parentMessage) {
        if ("".equals(parentMessage.getMessageId())) {
            String messageId = CommonUtil.getUUID();
            parentMessage.setMessageId(messageId);
            CommonUtil.save(parentMessage);
            if(!parentMessage.getPersonId().equals("")){
                String[] person = parentMessage.getPersonId().split(",");
                parentMessage.setPersonId(person[0]);
                parentMessage.setDeptId(person[1]);
            }
            parentMessageService.saveParentMessage(parentMessage);
            parentMessageService.saveParentMessageLog(parentMessage);
            return new Message(0, "添加成功！", null);
        } else {
            CommonUtil.update(parentMessage);
            parentMessageService.updateParentMessage(parentMessage);
            return new Message(0, "修改成功！", null);
        }

    }

    @RequestMapping("/parent/toParentMessageEdit")
    public ModelAndView toEdit(String id, Model model) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/core/xg/parent/message/parentMessageEdit");
        mv.addObject("data", parentMessageService.getParentMessageById(id));
        mv.addObject("head", "修改");
        return mv;
    }

    @RequestMapping("/parent/toParentMessageView")
    public ModelAndView toMessageView(String id,String identity) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/core/xg/parent/message/parentMessageView");
        mv.addObject("id", id);
        mv.addObject("head", "详细");
        mv.addObject("identity", identity);
        if(identity.equals("parent"))
            mv.addObject("backurl", "/parent/toParentMessageList");
        else if (identity.equals("teacher"))
            mv.addObject("backurl", "/parent/toMessageListByTeacher");

        //当前登录人 头像
        LoginUser loginUser = CommonUtil.getLoginUser();
        String personId = loginUser.getPersonId();
        String myImg = "";
        if (null == loginUser.getPhotoUrl() || "".equals(loginUser.getPhotoUrl())) {
            myImg = "dmitry_b.jpg";
        }else{
            myImg = loginUser.getPhotoUrl();
        }
        ParentMessage parentMessage = (ParentMessage) parentMessageService.getParentMessageById(id);
        mv.addObject("data", parentMessage);

        // 留言人 头像
        String otherPersonId =parentMessage.getPersonId().equals(personId)
                ? parentMessage.getCreator()
                :parentMessage.getPersonId();
        String otherImg = "";
        LoginUser publicPerson = empService.getEmpByPersonId(otherPersonId);
        if (null == publicPerson.getPhotoUrl() || "".equals(publicPerson.getPhotoUrl())) {
            otherImg = "dmitry_b.jpg";
        }else{
            otherImg = publicPerson.getPhotoUrl();
        }

        parentMessage = new ParentMessage();
        parentMessage.setMessageParentId(id);
        List list = parentMessageService.getParentMessageChildById(parentMessage);
        List<ParentMessage> messageList = list;
        for (ParentMessage pMessage : messageList) {
            if(pMessage.getCreator().equals(personId)){
                pMessage.setPhotoUrl(myImg);
                pMessage.setClassView("inbox");
            }else{
                pMessage.setPhotoUrl(otherImg);
            }
        }
        mv.addObject("list", list);
        CommonUtil.update(parentMessage);
        parentMessage.setMessageId(id);
        parentMessageService.updateParentMessageLog(parentMessage);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/parent/delParentMessage")
    public Message del(String id) {
        parentMessageService.delParentMessage(id);
        parentMessageService.delParentMessageLog(id);
        parentMessageService.delParentMessageChild(id);
        return new Message(0, "删除成功！", null);
    }

    @RequestMapping("/parent/toMessageListByTeacher")
    public ModelAndView toTeacherMessageListByTeacher() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/core/xg/parent/message/teacherMessageList");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/parent/getParentMessageListByTeacher")
    public Map getListByTeacher(ParentMessage parentMessage) {
        CommonUtil.save(parentMessage);
        return CommonUtil.tableMap(parentMessageService.getParentMessageListByTeacher(parentMessage));
    }

}
