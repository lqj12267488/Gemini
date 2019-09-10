package com.goisan.synergy.notice.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.synergy.notice.bean.Notice;
import com.goisan.synergy.notice.service.NoticeService;
import com.goisan.synergy.workflow.bean.HallUse;
import com.goisan.synergy.workflow.service.HallUseService;
import com.goisan.synergy.workflow.service.StampService;
import com.goisan.system.bean.ClassBean;
import com.goisan.system.service.ClassService;
import com.goisan.system.service.DeptService;
import com.goisan.system.service.FilesService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import com.goisan.task.bean.SysTask;
import com.goisan.workflow.bean.Handle;
import com.goisan.workflow.service.WorkflowService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by admin on 2017/5/11.
 */
@Controller
public class NoticeController {

    @Resource
    private NoticeService noticeService;
    @Resource
    private FilesService filesService;
    @Resource
    private ClassService classService;
    @Resource
    private WorkflowService workflowService;
    @Resource
    private StampService stampService;
    @Resource
    private DeptService deptService;
    @Resource
    private HallUseService hallUseService;
    @ResponseBody
    @RequestMapping("/noticeList")
    public ModelAndView noticeList() {
        ModelAndView mv = new ModelAndView("/core/notice/listNotice");
        String loginUser = CommonUtil.getPersonId();
        String loginDept = CommonUtil.getDefaultDept();
        mv.addObject("loginUser", loginUser);
        mv.addObject("loginDept", loginDept);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/getNoticeList")
    public Map<String, Object> getNoticeList(Notice notice, String listType, int draw, int start, int length) {
        List<Notice> noticeList = null;
        if (listType.equals("1")) {
            noticeList = noticeService.getNoticeList(notice);
        } else {
            noticeList = noticeService.getNoticeListes(notice);
        }
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> notices = new HashMap();

        PageInfo<List<Notice>> info = new PageInfo(noticeList);
        notices.put("draw", draw);
        notices.put("recordsTotal", info.getTotal());
        notices.put("recordsFiltered", info.getTotal());
        notices.put("data", noticeList);
        return notices;
    }

    @RequestMapping("/addNotice")
    public ModelAndView addNotice(String workflag) {
        ModelAndView mv = new ModelAndView("/core/notice/editNotice");
        mv.addObject("head", "新增");
        mv.addObject("workflag", workflag);
        String deptName =deptService.getDeptById(CommonUtil.getDefaultDept()).getDeptName();
        if(deptName.equals("教务处")){
         mv.addObject("isDean", "教务处");
        } else{
            mv.addObject("isDean", "");
        }
        return mv;
    }

    @ResponseBody
    @RequestMapping("/saveNotice")
    public Message saveNotice(Notice notice) {
        notice.setContent(notice.getContent().replaceAll("\r", ""));
        if (null == notice.getId() || notice.getId().equals("")) {
            notice.setId(CommonUtil.getUUID());
            notice.setDeptId(CommonUtil.getDefaultDept());
            notice.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
            notice.setCreator(CommonUtil.getPersonId());
            if (notice.getWorkFlowFlag().equals("0")) {
                notice.setRequestFlag("2");
            } else {
                notice.setRequestFlag("0");
            }
            noticeService.insertNotice(notice);
            return new Message(1, "新增成功！", null);
        } else {
            notice.setChanger(CommonUtil.getPersonId());
            notice.setChangeDept(CommonUtil.getLoginUser().getDefaultDeptId());
            noticeService.updateNotice(notice);
            noticeService.deleteNoticeLog(notice.getId());
            return new Message(1, "修改成功！", null);
        }
    }

    @ResponseBody
    @RequestMapping("/getNoticeById")
    public ModelAndView getNoticeById(String id) {
        ModelAndView mv = new ModelAndView("/core/notice/editNotice");
        Notice notice = noticeService.getNoticeById(id);
        mv.addObject("notice", notice);
        mv.addObject("head", "修改");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/getNoticeConcentById")
    public String getNoticeConcentById(String id) {
        return noticeService.getNoticeConcentById(id);
    }

    @ResponseBody
    @RequestMapping("/deleteNoticeById")
    public Message deleteNoticeById(String id) {
        noticeService.deleteNoticeDaoById(id);
        filesService.delFilesByBusinessId(id);
        return new Message(1, "删除成功！", null);
    }

    @ResponseBody
    @RequestMapping("/noticeListIndex")
    public ModelAndView noticeListIndex() {
        ModelAndView mv = new ModelAndView("/core/notice/indexNotice");
//        mv.setViewName();
        return mv;
    }

    @RequestMapping("/noticeListIndexNotice")
    public ModelAndView noticeListIndexNotice(String loginID, String deptId) {
        ModelAndView mv = new ModelAndView("/core/notice/indexNotice");
        deptId = CommonUtil.getDefaultDept();
        String level = CommonUtil.getLoginUser().getLevel();
        List<Notice> noticeList = noticeService.getNoticeListPerson(loginID, deptId, level);
        mv.addObject("data", noticeList);
        return mv;
    }

    @RequestMapping("/noticeListIndexNoticeParent")
    public ModelAndView noticeListIndexNoticeParent(String loginID, String deptId) {
        ModelAndView mv = new ModelAndView("/core/notice/indexNotice");
        List classlist = new ArrayList();
        deptId = CommonUtil.getDefaultDept();
        loginID = CommonUtil.getPersonId();
        List<ClassBean> classBean = classService.getClassListByStudentid(deptId);
        for (Iterator<ClassBean> it = classBean.iterator(); it.hasNext(); ) {
            ClassBean cBean = it.next();
            classlist.add(cBean.getClassId());
        }
        List<Notice> noticeList = noticeService.getNoticeListPar(loginID, deptId, classlist);
        mv.addObject("data", noticeList);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/meetingInfo")
    public ModelAndView meetingInfo(String id, String type) {
        ModelAndView mv = new ModelAndView("/core/notice/viewNotice");
        HallUse hallUse = hallUseService.getHallUseById(id);
        Notice notice = new Notice();
        notice.setId(hallUse.getId());
        notice.setRequester(CommonUtil.getPersonId());
        notice.setRequestDept(CommonUtil.getDefaultDept());
        notice.setType(type);
        notice.setContent(hallUse.getContent());
        notice.setTypeShow(hallUse.getMeetingRequestShow());
        notice.setCreator(hallUse.getRequester());
        notice.setTitle(hallUse.getTitle());
        noticeService.insertNoticeLog(notice);
        mv.addObject("notice", notice);
        mv.addObject("head", "");
        mv.addObject("type", type);
        return mv;
    }


    @ResponseBody
    @RequestMapping("/indexGetNoticeById")
    public ModelAndView indexGetNoticeById(String id, String type) {
        ModelAndView mv = new ModelAndView("/core/notice/viewNotice");
        Notice notice = noticeService.getNoticeById(id);
        notice.setRequester(CommonUtil.getPersonId());
        notice.setRequestDept(CommonUtil.getDefaultDept());
        noticeService.insertNoticeLog(notice);
        mv.addObject("notice", notice);
        mv.addObject("head", "");
        mv.addObject("type", type);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/indexGetNoticesById")
    public void indexGetNoticesById(String ids, String type) {
        ids=ids.replaceAll("'","");
        String ida[];
        ida = ids.split(",");
        for(String id:ida) {
            Notice notice = noticeService.getNoticeById(id);
            notice.setRequester(CommonUtil.getPersonId());
            notice.setRequestDept(CommonUtil.getDefaultDept());
            noticeService.insertNoticeLog(notice);
        }
    }

    /**
     * 查看已读详情
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/indexGetMoreNoticeById")
    public ModelAndView indexGetMoreNoticeById(String id) {
        ModelAndView mv = new ModelAndView("/core/notice/viewNoticeReaded");
        Notice notice = noticeService.getNoticeById(id);
        mv.addObject("notice", notice);
        mv.addObject("head", "");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/getTask")
    public SysTask getTask(String id) {
        return noticeService.getTask(id);
    }

   /* @ResponseBody
    @RequestMapping("/insertNoticeLog")
    public Message insertNoticeLog(Notice notice) {
        notice.setCreateDept(CommonUtil.getLoginUser().getDefaultDeptId());
        notice.setLoginID(CommonUtil.getLoginUser().getPersonId());
        notice.setCreator(CommonUtil.getPersonId());
        noticeService.insertNoticeLog(notice);
        return new Message(1, "操作成功，已读信息可在【协同办公——通知公告】进行查看。", null);

    }*/


    @ResponseBody
    @RequestMapping("/noticeListPerson")
    public ModelAndView noticeListPerson() {
        ModelAndView mv = new ModelAndView("/core/notice/listNoticePerson");
        return mv;
    }

    /*已读未读人员查看页面跳转*/
    @RequestMapping("/noticePersonList")
    public ModelAndView noticePersonList(String id) {
        ModelAndView mv = new ModelAndView("/core/notice/noticePersonList");
        mv.addObject("id", id);
        return mv;
    }

    /*获取已读未读人员列表*/
    @ResponseBody
    @RequestMapping("/getNoticePersonList")
    public Map<String, List> getNoticePersonList(String id, String deptId) {
        Notice notice = new Notice();
        notice.setDeptId(deptId);
        List<Notice> receiptPersonList = noticeService.getReceiptPerson(notice);
        List<Notice> readPersonList = noticeService.getReadPersonByNoticeId(id);
        for (int i = 0; i < receiptPersonList.size(); i++) {
            if (readPersonList.size() == 0) {
                receiptPersonList.get(i).setFlag("未读");
            } else {
                for (int j = 0; j < readPersonList.size(); j++) {
                    if ((receiptPersonList.get(i).getPersinId()).equals(readPersonList.get(j).getPersinId())) {
                        receiptPersonList.get(i).setFlag("已读");
                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
                        String tsStr = "";
                        try {
                            tsStr = sdf.format(readPersonList.get(j).getCreateTime());
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                        receiptPersonList.get(i).setAbc(tsStr);
                        break;
                    } else {
                        receiptPersonList.get(i).setFlag("未读");
                    }
                }
            }
        }
        Map<String, List> map = new HashMap<String, List>();
        map.put("data", receiptPersonList);
        return map;
    }

    /**
     * 公告申请
     */
    @ResponseBody
    @RequestMapping("/notice/request")
    public ModelAndView noticeRequest() {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/notice/noticeRequest");
        return mv;
    }

    /**
     * 公告申请查询
     */
    @ResponseBody
    @RequestMapping("/notice/getNoticeRequest")
    public Map<String, Object> getNoticeRequest(Notice notice, int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> notices = new HashMap();
        notice.setCreateDept(CommonUtil.getDefaultDept());
        notice.setLevel(CommonUtil.getLoginUser().getLevel());
        List<Notice> noticeList = noticeService.getNoticeRequest(notice);
        PageInfo<List<Notice>> info = new PageInfo(noticeList);
        notices.put("draw", draw);
        notices.put("recordsTotal", info.getTotal());
        notices.put("recordsFiltered", info.getTotal());
        notices.put("data", noticeList);
        return notices;
    }

    @ResponseBody
    @RequestMapping("/updatePublishFlag")
    public Message updatePublishFlag(String id) {
        noticeService.updatePublishFlag(id);
        return new Message(1, "", null);
    }

    /**
     * 公告待办
     */
    @ResponseBody
    @RequestMapping("/notice/process")
    public ModelAndView noticeProcess() {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/notice/noticeProcess");
        return mv;
    }

    /**
     * 公告待办查询
     */
    @ResponseBody
    @RequestMapping("/notice/processList")
    public Map<String, Object> processList(Notice notice, int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> notices = new HashMap();
        notice.setRequester(CommonUtil.getPersonId());
        notice.setRequestDept(CommonUtil.getDefaultDept());
        List<Notice> noticeList = noticeService.getProcessList(notice);
        PageInfo<List<Notice>> info = new PageInfo(noticeList);
        notices.put("draw", draw);
        notices.put("recordsTotal", info.getTotal());
        notices.put("recordsFiltered", info.getTotal());
        notices.put("data", noticeList);
        return notices;
    }

    /**
     * 办理界面
     */
    @ResponseBody
    @RequestMapping("/notice/auditNotice")
    public ModelAndView auditphotography(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/notice/auditNotice");
        Notice notice = noticeService.getNoticeById(id);
        mv.addObject("head", "办理");
        mv.addObject("notice", notice);
        return mv;
    }

    /**
     * 待办修改
     */
    @ResponseBody
    @RequestMapping("/notice/editNoticeProcess")
    public ModelAndView editNoticeProcess(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/notice/editNoticeProcess");
        Notice notice = noticeService.getNoticeById(id);
        mv.addObject("head", "修改");
        mv.addObject("notice", notice);
        return mv;
    }

    /**
     * 已办业务
     */
    @RequestMapping("/notice/complete")
    public ModelAndView SoftInstallCompleteList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/business/synergy/workflow/notice/noticeComplete");
        return mv;
    }

    /**
     * 已办查询
     */
    @ResponseBody
    @RequestMapping("/notice/listComplete")
    public Map<String, Object> listComplete(Notice notice, int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> notices = new HashMap();
        notice.setRequester(CommonUtil.getPersonId());
        notice.setRequestDept(CommonUtil.getDefaultDept());
        List<Notice> noticeList = noticeService.getNoticeComplete(notice);
        PageInfo<List<Notice>> info = new PageInfo(noticeList);
        notices.put("draw", draw);
        notices.put("recordsTotal", info.getTotal());
        notices.put("recordsFiltered", info.getTotal());
        notices.put("data", noticeList);
        return notices;
    }

    @RequestMapping("/loadMoreNotices")
    public ModelAndView loadMoreNotices() {
        String loginID=CommonUtil.getPersonId();
        String deptId = CommonUtil.getDefaultDept();
        ModelAndView mv = new ModelAndView("moreNotice");
        //首页未读通知公告
        List<Notice> noticeList = noticeService.getNoticeMoreList(CommonUtil.getPersonId(), deptId,CommonUtil.getLoginUser().getLevel());
            for(int i=0;i<noticeList.size();i++){
            if(noticeList.get(i).getIsDean().equals("教务处")){
                noticeList.get(i).setIsDean("《教务处》");
            }
        }
        mv.addObject("noticeList", CommonUtil.jsonUtil(noticeList));

        //首页已读通知公告
        List<Notice> noticeReaded = noticeService.getNoticeMoreReaded(CommonUtil.getPersonId(), deptId,CommonUtil.getLoginUser().getLevel());
        for(int i=0;i<noticeReaded.size();i++){
            if(noticeReaded.get(i).getIsDean().equals("教务处")){
                noticeReaded.get(i).setIsDean("《教务处》");
            }
        }

        mv.addObject("noticeReaded", CommonUtil.jsonUtil(noticeReaded));
        mv.addObject("loginID",loginID);
        return mv;
    }

    /**
     * PC端公告打印
     */
    @ResponseBody
    @RequestMapping("/notice/printNotice")
    public ModelAndView printNotice(String id) {
        ModelAndView mv = new ModelAndView("/business/synergy/workflow/notice/printNotice");
        String workflowName = workflowService.getWorkflowNameByWorkflowCode("T_SYS_NOTICE_WF");
        Notice notice = noticeService.getNoticeById(id);
        String requestDate = notice.getPublicTime().replace("T", " ");
//        mv.addObject("requestDate", requestDate);
//        mv.addObject("notice", notice);
//        mv.addObject("workflowName", workflowName);
//        return mv;
        String state = stampService.getStateById(id);
        List<Handle> list= stampService.getHandlebyId(id);
        int size=list.size();
        mv.addObject("handleList", list);
        mv.addObject("size",size);
        mv.addObject("state",state);
        mv.addObject("requestDate", requestDate);
        mv.addObject("notice", notice);
        mv.addObject("workflowName", workflowName);
        return mv;
    }

    /**
     * 发布
     */
    @ResponseBody
    @RequestMapping("/noticePublish")
    public Message noticePublish(String id) {
        noticeService.noticePublish(id);
        return new Message(1, "", null);
    }

}
