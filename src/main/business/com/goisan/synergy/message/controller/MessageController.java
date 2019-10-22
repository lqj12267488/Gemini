package com.goisan.synergy.message.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.synergy.message.bean.Message;
import com.goisan.synergy.notice.bean.Notice;
import com.goisan.synergy.message.service.MessageService;
import com.goisan.synergy.notice.service.NoticeService;
import com.goisan.synergy.workflow.service.StampService;
import com.goisan.system.bean.LoginUser;
import com.goisan.system.bean.Select2;
import com.goisan.system.bean.Tree;
import com.goisan.system.service.DeptService;
import com.goisan.system.service.EmpChangeLogService;
import com.goisan.system.service.FilesService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.workflow.bean.Handle;
import com.goisan.workflow.service.WorkflowService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by admin on 2017/5/11.
 */
@Controller
public class MessageController {
    @Resource
    private NoticeService noticeService;
    @Resource
    private MessageService messageService;
    @Resource
    private FilesService filesService;
    @Resource
    private EmpChangeLogService empChangeLogService;
    @Resource
    private WorkflowService workflowService;
    @Resource
    private StampService stampService;
    @Resource
    private DeptService deptService;


    @ResponseBody
    @RequestMapping("/messageList")
    public ModelAndView noticeList() {
        ModelAndView mv = new ModelAndView("/core/message/listMessage");
        String loginUser=CommonUtil.getPersonId();
        String loginDept=CommonUtil.getDefaultDept();
        mv.addObject("loginUser",loginUser);
        mv.addObject("loginDept",loginDept);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/getMessageList")
    public Map<String, Object> getMessageList(Message message,String messageType, int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> messages = new HashMap();
        message.setLoginID(CommonUtil.getPersonId());
        message.setCreateDept(CommonUtil.getDefaultDept());
        List<Message> messageList = null;
        if(messageType.equals("1")){
            messageList = messageService.getMessageList(message);
        }
        else {
            messageList = messageService.getMessageListes(message);
        }
        PageInfo<List<Message>> info = new PageInfo(messageList);
        messages.put("draw", draw);
        messages.put("recordsTotal", info.getTotal());
        messages.put("recordsFiltered", info.getTotal());
        messages.put("data", messageList);
        return messages;
    }


    /**
     * 通知新增
     */
    @RequestMapping("/addMessage")
    public ModelAndView addMessage(String workflag) {
        ModelAndView mv = new ModelAndView("/core/message/editMessage");
        mv.addObject("head", "新增");
        mv.addObject("workflag",workflag);
        String deptName =deptService.getDeptById(CommonUtil.getDefaultDept()).getDeptName();
        if(deptName.equals("教务处")){
            mv.addObject("isDean", "教务处");
        } else{
            mv.addObject("isDean", "");
        }

        return mv;
    }
    /**通知修改*/
    @ResponseBody
    @RequestMapping("/editMessage")
    public ModelAndView editMessage(String id) {
        ModelAndView mv = new ModelAndView("/core/message/editMessage");
        Message message = messageService.getMessageById(id);
        mv.addObject("message", message);
        //mv.addObject("head", "");
        return mv;
    }

    /**
     * 多选下拉内容查询
     */
    @ResponseBody
    @RequestMapping("/message/getEmpTree")
    public List<Tree> getEmpTree() {
        List<Tree> trees = messageService.getEmpTree();
        Tree root = new Tree();
        root.setId("0");
        root.setName("组织机构");
        root.setpId("root");
        root.setOpen(true);
        trees.add(root);
        return trees;
    }

    @ResponseBody
    @RequestMapping("/saveMessageDept")
    public com.goisan.system.tools.Message saveMessageDept(Message message) {
        message.setDeptId(CommonUtil.getDefaultDept());
        message.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
        message.setCreator(CommonUtil.getPersonId());
        String[] result = message.getEmpId().split(",");
        String emp_all = "";
        for (int i = 0; i < result.length; i++) {
            String resultStr = result[i];
            if (resultStr.length() > 5) {
                String emp_f = "";
                List<Message> selectOld = messageService.getDeptPersonId(resultStr);
                if (selectOld != null) {
                    for (int j = 0; j < selectOld.size(); j++) {
                        emp_f = emp_f + selectOld.get(j).getId() + ",";
                    }

                }
                emp_all = emp_all + emp_f;
            }

        }
        message.setEmpId(emp_all);
        messageService.insertMessageLog(message);
        messageService.insertMessage(message);
        return new com.goisan.system.tools.Message(1, "新增成功！", null);
    }

    /**
     * 保存方法
     */
    @ResponseBody
    @RequestMapping("/saveMessage")
    public com.goisan.system.tools.Message saveMessage(Message message) {
        if(message.getId()==null || message.getId().equals("")) {
            message.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
            message.setCreator(CommonUtil.getPersonId());
            message.setId(CommonUtil.getUUID());
            if(message.getWorkFlowFlag().equals("1")){
                message.setRequestFlag("0");
            }
            else {
                message.setRequestFlag("2");
            }
            messageService.insertMessage(message);
            //messageService.insertMessageLog(message);
            return new com.goisan.system.tools.Message(1, "新增成功！", null);
        }
        else {
            message.setChanger(CommonUtil.getPersonId());
            message.setChangeDept(CommonUtil.getDefaultDept());
            messageService.updateMessage(message);
            messageService.deleteMessageLog(message.getId());
            //通过.xml中的updateXuZheById方法修改数据库中的数据
            return new com.goisan.system.tools.Message(1, "修改成功！", null);
        }
    }

    /**
     * 待办保存方法
     */
    @ResponseBody
    @RequestMapping("/message/saveProcessMessage")
    public com.goisan.system.tools.Message saveProcessMessage(Message message) {
        //camera.setId(CommonUtil.getUUID());
        message.setChanger(CommonUtil.getPersonId());
        message.setChangeDept(CommonUtil.getDefaultDept());
        messageService.updateMessage(message);
        //通过.xml中的updateXuZheById方法修改数据库中的数据
        return new com.goisan.system.tools.Message(1, "修改成功！", null);
    }

    /**
     * 删除
     */
    @ResponseBody
    @RequestMapping("/deleteMessage")
    public com.goisan.system.tools.Message deleteMessage(String id) {
        messageService.deleteMessageLog(id);
        messageService.deleteMessage(id);
        return new com.goisan.system.tools.Message(1, "删除成功！", null);
    }

    /**
     * 通知查看
     */
    @ResponseBody
    @RequestMapping("/messageListInfo")
    public ModelAndView messageListInfo() {
        ModelAndView mv = new ModelAndView("/core/message/messageListInfo");
        return mv;
    }

    /**
     * 查看详情
     */
    @ResponseBody
    @RequestMapping("/messageInfo")
    public ModelAndView messageInfo(String id,String type) {
        ModelAndView mv = new ModelAndView("/core/message/viewMessage");
        Message message = messageService.getMessageById(id);
        message.setCreator(CommonUtil.getPersonId());
        message.setCreateDept(CommonUtil.getDefaultDept());
        messageService.insertMessageLog(message);
        mv.addObject("message", message);
        mv.addObject("head", "");
        mv.addObject("type", type);
        return mv;
    }
    /**
     * 查看已读详情
     */
    @ResponseBody
    @RequestMapping("/moreMessageInfo")
    public ModelAndView moreMessage(String id) {
        ModelAndView mv = new ModelAndView("/core/message/viewMoreMessage");
        Message message = messageService.getMessageById(id);
        if (message==null){
             message =   messageService.selectMessage(id);
        }
        mv.addObject("message", message);
        mv.addObject("head", "");
        return mv;
    }

    /*@ResponseBody
    @RequestMapping("/updateMessageLog")
    public com.goisan.system.tools.Message updateMessageLog(Message message) {
        message.setCreator(CommonUtil.getPersonId());
        message.setCreateDept(CommonUtil.getDefaultDept());
        messageService.insertMessageLog(message);
        //messageService.updateMessageLog(id);
        return new com.goisan.system.tools.Message(1, "操作成功，已读信息可在【协同办公——通知查看】进行查看。", null);

    }*/

    /*已读未读人员查看页面跳转*/
    @RequestMapping("/messagePersonList")
    public ModelAndView messageReadPerson(String id) {
        ModelAndView mv = new ModelAndView("/core/message/messagePersonList");
        mv.addObject("id", id);
        return mv;
    }

    /*获取已读未读人员列表*/
    @ResponseBody
    @RequestMapping("/getMessagePersonList")
    public Map<String,List> getMessagePersonList(String id){
        Map<String, List> map = new HashMap<String, List>();
        map.put("data",messageService.getMessagePersonList(id));
        return map;

    }

    /**
     * 通知申请
     */
    @ResponseBody
    @RequestMapping("/message/request")
    public ModelAndView messageRequest() {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/message/messageRequest");
        return mv;
    }

    /**
     * 通知申请查询
     */
    @ResponseBody
    @RequestMapping("/message/getMessageRequest")
    public Map<String, Object> getMessageRequest(Message message, int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> messages = new HashMap();
        message.setRequester(CommonUtil.getPersonId());
        message.setRequestDept(CommonUtil.getDefaultDept());
        List<Message> messageList = messageService.getMessageRequest(message);
        Map<String, List<Message>> noti = new HashMap<String, List<Message>>();

        PageInfo<List<Message>> info = new PageInfo(messageList);
        messages.put("draw", draw);
        messages.put("recordsTotal", info.getTotal());
        messages.put("recordsFiltered", info.getTotal());
        messages.put("data", messageList);

        return messages;
    }

    @ResponseBody
    @RequestMapping("/message/updatePublishFlag")
    public com.goisan.system.tools.Message updatePublishFlag(String id) {
        messageService.updatePublishFlag(id);
        return new com.goisan.system.tools.Message(1, "", null);
    }

    /**
     * 通知待办
     */
    @ResponseBody
    @RequestMapping("/message/process")
    public ModelAndView messageProcess() {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/message/messageProcess");
        return mv;
    }

    /**
     * 通知待办查询
     */
    @ResponseBody
    @RequestMapping("/message/processList")
    public Map<String,Object> processList(Message message, int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> messages = new HashMap();
        message.setRequester(CommonUtil.getPersonId());
        message.setRequestDept(CommonUtil.getDefaultDept());
        List<Message> messageList = messageService.getProcessList(message);
        PageInfo<List<Message>> info = new PageInfo(messageList);
        messages.put("draw", draw);
        messages.put("recordsTotal", info.getTotal());
        messages.put("recordsFiltered", info.getTotal());
        messages.put("data", messageList);
        return messages;
    }

    /**
     * 办理界面
     */
    @ResponseBody
    @RequestMapping("/message/auditMessage")
    public ModelAndView auditphotography(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/message/auditMessage");
        Message message = messageService.getMessageById(id);
        mv.addObject("head", "办理");
        mv.addObject("message", message);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/message/editMessageProcess")
    public ModelAndView editNoticeProcess(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/message/editMessageProcess");
        Message message = messageService.getMessageById(id);
        mv.addObject("head", "修改");
        mv.addObject("message", message);
        return mv;
    }

    /**
     * 已办业务
     */
    @RequestMapping("/message/complete")
    public ModelAndView messageCompleteList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/message/messageComplete");
        return mv;
    }

    /**
     * 已办查询
     */
    @ResponseBody
    @RequestMapping("/message/listComplete")
    public Map<String,Object> listComplete(Message message, int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> messages = new HashMap();
        message.setRequester(CommonUtil.getPersonId());
        message.setRequestDept(CommonUtil.getDefaultDept());
        List<Message> messageList = messageService.getMessageComplete(message);
        PageInfo<List<Message>> info = new PageInfo(messageList);
        messages.put("draw", draw);
        messages.put("recordsTotal", info.getTotal());
        messages.put("recordsFiltered", info.getTotal());
        messages.put("data", messageList);
        return messages;
    }


    @RequestMapping("/loadMoreMessages")
    public ModelAndView loadMoreNotices() {
        String deptId=CommonUtil.getDefaultDept();
        ModelAndView mv = new ModelAndView("moreMessage");
        //首页未读通知
        List<Message> noticeList = messageService.getMessageMoreList(CommonUtil.getPersonId(),deptId);
        mv.addObject("messageList", CommonUtil.jsonUtil(noticeList));
        //首页已读通知
        List<Message> noticeReaded = messageService.getMessageMoreReaded(CommonUtil.getPersonId(),deptId);
        mv.addObject("messageReaded", CommonUtil.jsonUtil(noticeReaded));
        return mv;
    }
    @RequestMapping("/messageListIndexMessage")
    public ModelAndView noticeListIndexNotice(String loginID) {
        ModelAndView mv = new ModelAndView("/core/notice/indexNotice");
        String deptId=CommonUtil.getDefaultDept();
        List<Message> messageList = messageService.getMessageListPerson(loginID,deptId);


        mv.addObject("data", messageList);
        return mv;
    }
    /**
     * PC端通知打印
     */
    @ResponseBody
    @RequestMapping("/message/printMessage")
    public ModelAndView printMessage(String id) {

        ModelAndView mv = new ModelAndView("/business/synergy/workflow/message/printMessage");
        String workflowName = workflowService.getWorkflowNameByWorkflowCode("T_SYS_MESSAGE_WF");
        Message message = messageService.getMessageById(id);
        String state = stampService.getStateById(id);
        int approval = 0;// 0为正常工作流转的审批状态   1为直接发布的通知(可以隐藏审批流程)
        if(state==null){
            state = "已审批";
            approval = 1;
        }
        List<Handle> list= stampService.getHandlebyId(id);
        int size=list.size();
        mv.addObject("handleList", list);
        mv.addObject("size",size);
        mv.addObject("state",state);
        mv.addObject("message", message);
        mv.addObject("workflowName", workflowName);
        mv.addObject("approval", approval);
        return mv;
    }
    @ResponseBody
    @RequestMapping("/messagePublish")
    public com.goisan.system.tools.Message messagePublish(String id) {
        messageService.messagePublish(id);

        return new com.goisan.system.tools.Message(1, "发布成功！", null);
    }
}
