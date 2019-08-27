package com.goisan.synergy.workflow.colltroller;

import com.goisan.synergy.message.bean.Message;
import com.goisan.synergy.message.service.MessageService;
import com.goisan.synergy.notice.bean.Notice;
import com.goisan.synergy.workflow.colltroller.FundsController;
import com.goisan.synergy.notice.service.NoticeService;
import com.goisan.synergy.workflow.service.FundsService;
import com.goisan.system.bean.Dept;
import com.goisan.system.bean.Emp;
import com.goisan.system.bean.LoginUser;
import com.goisan.system.bean.Tree;
import com.goisan.system.service.DeptService;
import com.goisan.system.service.EmpService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.workflow.bean.Handle;
import com.goisan.workflow.bean.Node;
import com.goisan.workflow.bean.Start;
import com.goisan.workflow.service.DefinitionService;
import com.goisan.workflow.service.WorkflowService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class NoticeAppController {
    @Resource
    private NoticeService noticeService;
    @Resource
    private MessageService messageService;
    @Resource
    private FundsService fundsService;
    @Resource
    private EmpService empService;
    @Resource
    private WorkflowService workflowService;
    @Resource
    public DefinitionService definitionService;
    @Resource
    public DeptService deptService;
    /**查通知*/
    @RequestMapping("/notice/noticeApp")
    public ModelAndView listNotice(){
        ModelAndView mv=new ModelAndView("/app/synergy/notice/noticeList");
        String emJson = getNoticeName(1);
        mv.addObject("emJson", emJson);
        return mv;
    }
    /**
     * 列出通知列表*/
    @ResponseBody
    @RequestMapping("/notice/getNoticeName")
    public String getNoticeName(int page) {
        LoginUser loginUser = CommonUtil.getLoginUser();
        String personId = "";
        if(!loginUser.getPersonId().equals("sa")){
            personId = CommonUtil.getPersonId();
        }
        List<Notice> workFlow = noticeService.getBulletinAppList(personId);
        return getJsonTaskList(workFlow,page);
    }
    /**通知-向前台jsp传数据*/
    public String getJsonTaskList(List<Notice> NoticeList, int page){

        int from = ( page - 1 ) * 10 ;
        int end  = page * 10 ;
        int len = NoticeList.size();
        // 如果 开始序号 > 列表长度  那么不返回数据
        from = from > len ? len+10 :from ;
        // 如果 结束序号 > 列表长度  那么以列表长度 为结束序号
        end = end > len ? len :end ;

        String str ="";
        boolean b =true;
        for(int i=from;i< end;i++ ){
            Notice notice = NoticeList.get(i);
            String title = notice.getTitle();
            String flag=notice.getFlag();
            try {
                title =java.net.URLEncoder.encode(title,"UTF-8");
                title =java.net.URLEncoder.encode(title,"UTF-8");
                title =java.net.URLEncoder.encode(title,"UTF-8");
                flag =java.net.URLEncoder.encode(flag,"UTF-8");
                flag =java.net.URLEncoder.encode(flag,"UTF-8");
                flag =java.net.URLEncoder.encode(flag,"UTF-8");
            } catch (UnsupportedEncodingException e1) {
                // TODO Auto-generated catch block
                e1.printStackTrace();
            }

            String obj = "{\"title\":\"" +title+"\", \"id\":\"" +notice.getId()+"\",\"publicTime\":\"" +notice.getPublicTime()+"\"," +
                    "\"createTime\":\""+notice.getCreateTime()+"\",\"flag\":\"" +flag+"\",\"type\":\"" +notice.getType()+"\",\"businessId\":\"" + notice.getTypeShow()+"\"}";

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
    /**查通知*/
    @RequestMapping("/notice/messageApp")
    public ModelAndView listMessage(){
        ModelAndView mv=new ModelAndView("/app/synergy/notice/messageList");
        String emJson = getMessageName(1);
        mv.addObject("emJson", emJson);
        return mv;
    }
    /**
     * 列出通知列表*/
    @ResponseBody
    @RequestMapping("/notice/getMessageName")
    public String getMessageName(int page) {
        LoginUser loginUser = CommonUtil.getLoginUser();
        String personId = "";
        String deptId=CommonUtil.getDefaultDept();
        if(!loginUser.getPersonId().equals("sa")){
            personId = CommonUtil.getPersonId();
        }
        List<Message> workFlow = noticeService.getNoticeAppList(personId,deptId);
        return getJsonMessageList(workFlow,page);
    }
    /**通知-向前台jsp传数据*/
    public String getJsonMessageList(List<Message> MessageList, int page){

        int from = ( page - 1 ) * 10 ;
        int end  = page * 10 ;
        int len = MessageList.size();
        // 如果 开始序号 > 列表长度  那么不返回数据
        from = from > len ? len+10 :from ;
        // 如果 结束序号 > 列表长度  那么以列表长度 为结束序号
        end = end > len ? len :end ;

        String str ="";
        boolean b =true;
        for(int i=from;i< end;i++ ){
            Message message = MessageList.get(i);
            String title = message.getTitle();
            String flag=message.getFlag();
            try {
                title =java.net.URLEncoder.encode(title,"UTF-8");
                title =java.net.URLEncoder.encode(title,"UTF-8");
                title =java.net.URLEncoder.encode(title,"UTF-8");
                flag =java.net.URLEncoder.encode(flag,"UTF-8");
                flag =java.net.URLEncoder.encode(flag,"UTF-8");
                flag =java.net.URLEncoder.encode(flag,"UTF-8");
            } catch (UnsupportedEncodingException e1) {
                // TODO Auto-generated catch block
                e1.printStackTrace();
            }

            String obj = "{\"title\":\"" +title+"\", \"id\":\"" +message.getId()+"\",\"publicTime\":\"" +message.getPublicTime()+"\"," +
                    "\"createTime\":\""+message.getCreateTime()+"\",\"flag\":\"" +flag+"\",\"type\":\"" +message.getType()+"\",\"businessId\":\"" + message.getTypeShow()+"\"}";

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
     *
     */
    @RequestMapping("/notice/messageInfo")
    public ModelAndView listMenmbers(String title,String id,String flag,String type,String businessId) {
        ModelAndView mv = null;
            mv = new ModelAndView("/app/synergy/notice/messageApp");
            Message message=messageService.getMessageById(id);
            message.setCreator(CommonUtil.getPersonId());
            message.setCreateDept(CommonUtil.getDefaultDept());
            if(flag.equals("0")){
                messageService.insertMessageLog(message);
            }
            /*notice.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
            notice.setCreator(CommonUtil.getPersonId());
            notice.setNoticeID(id);*/
            mv.addObject("title", title);
            mv.addObject("message", message);
            mv.addObject("flag", flag);
        return mv;
    }


    /**查公告*/
    @RequestMapping("/notice/bulletinApp")
    public ModelAndView listBulletin(){
        ModelAndView mv=new ModelAndView("/app/synergy/notice/bulletinList");
        String emJson = getBulletinName(1);
        mv.addObject("emJson", emJson);
        return mv;
    }
    /**
     * 列出公告列表*/
    @ResponseBody
    @RequestMapping("/notice/getBulletinName")
    public String getBulletinName(int page) {
        LoginUser loginUser = CommonUtil.getLoginUser();
        String personId = "";
        if(!loginUser.getPersonId().equals("sa")){
            personId =CommonUtil.getPersonId();
        }
        List<Notice> workFlow = noticeService.getBulletinAppList(personId);
        return getJsonTaskList(workFlow,page);
    }

    /**
     * 单个公告详情*/
    @RequestMapping("/notice/bulletinInfo")
    public ModelAndView listMens(String title,String id,String flag) {
        ModelAndView mv =  new ModelAndView("/app/synergy/notice/bulletinInfo");
        Notice notice=noticeService.getNoticeById(id);
        notice.setRequester(CommonUtil.getPersonId());
        notice.setRequestDept(CommonUtil.getDefaultDept());
        if(flag.equals("0")) {
            noticeService.insertNoticeLog(notice);
        }
        notice.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
        notice.setCreator(CommonUtil.getPersonId());
        notice.setNoticeID(id);
        /*noticeService.insertNoticeLog(notice);*/
        mv.addObject("title", title);
        mv.addObject("notice", notice);
        mv.addObject("flag", flag);
        return mv;
    }
    /**刷新通知*/
    @RequestMapping("/notice/listNoticenmbers")
    public ModelAndView listRepairnmbers() {
        ModelAndView mv=new ModelAndView("/app/synergy/notice/noticeList");
        String emJson = getNoticeName(1);
        mv.addObject("emJson", emJson);
        return mv;
    }
    /**刷新公告*/
    @RequestMapping("/notice/listBulletinnmbers")
    public ModelAndView listBulletinnmbers() {
        ModelAndView mv=new ModelAndView("/app/synergy/notice/bulletinList");
        String emJson = getNoticeName(1);
        mv.addObject("emJson", emJson);
        return mv;
    }
    /**发通知页*/
    @RequestMapping("/notice/addNotice")
    public ModelAndView addNotice() {
        String id = CommonUtil.getUUID();
        List<Tree> list = deptService.getDeptTree();
        Message message = new Message();
        message.setCreateDept(CommonUtil.getDefaultDept());
        message.setCreator(CommonUtil.getPersonId());
        message.setId(id);
        messageService.insertMessage(message);
        messageService.deleteNullMessage(id);
        ModelAndView mv=new ModelAndView("/app/synergy/notice/addNotice");
        mv.addObject("id",id);
        mv.addObject("list",list);
        return mv;
    }

    /**选择部门页*/
    @ResponseBody
    @RequestMapping("/notice/addDept")
    public List addDept() {
        List<Tree> list = deptService.getDeptTree();
        return list;
    }

    /**选择部门人员页*/
    @ResponseBody
    @RequestMapping("/notice/addEmp")
    public List addEmp(String id) {
        id = id.replaceAll(",","','");
        List<Emp> list = noticeService.getEmpByDeptIds(id);
        Map<String, List> map = new HashMap<String, List>();
        map.put("data",list);
        return list;
    }
}
