package com.goisan.synergy.notice.controller;

import com.goisan.synergy.notice.bean.Notice;
import com.goisan.synergy.notice.service.CasNoticeService;
import com.goisan.synergy.notice.service.NoticeService;
import com.goisan.system.tools.AESUtil;
import com.goisan.system.tools.CommonUtil;
import com.goisan.workflow.bean.IndexUnAudti;
import com.goisan.workflow.service.WorkflowService;
import org.json.HTTP;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

@Controller
public class CasNoticeController {

    @Autowired
    private CasNoticeService casNoticeService;

    @Resource
    private NoticeService noticeService;

    @Resource
    private WorkflowService workflowService;

    @ResponseBody
    @RequestMapping("/CasNoticeListIndexNotice")
    public List<Notice>  CasNoticeListIndexNotice(String userName, HttpServletResponse response, HttpServletRequest request) {

        //cors解决跨域请求
        response.setHeader("Access-Control-Allow-Origin", request.getHeader("Origin"));
        response.setHeader("Access-Control-Allow-Credentials", "true");
        response.setHeader("P3P", "CP=CAO PSA OUR");
        if (request.getHeader("Access-Control-Request-Method") != null && "OPTIONS".equals(request.getMethod())) {
            response.addHeader("Access-Control-Allow-Methods", "POST,GET,TRACE,OPTIONS");
            response.addHeader("Access-Control-Allow-Headers", "Content-Type,Origin,Accept");
            response.addHeader("Access-Control-Max-Age", "120");
        }

        //解密
        byte[] bytes = AESUtil.parseHexStr2Byte(userName);
        byte[] decrypt1 = AESUtil.decrypt(bytes, "12345");
        String s = new String(decrypt1);
        //获取loginID
        String loginID =  casNoticeService.selectUserAccount(s);
        //获取deptId
        String deptId = casNoticeService.selectDeptId(s);
        //获取level
        String level = casNoticeService.selectLevel(s);
        List<Notice>  list =  casNoticeService.CasNoticeListIndexNotice(loginID,deptId,level);
        return list;
    }

    @ResponseBody
    @RequestMapping("/casToIndexAudit")
    public List<IndexUnAudti> casToIndexAudit(String userName, HttpServletResponse response, HttpServletRequest request) {
        //cors解决跨域请求
        response.setHeader("Access-Control-Allow-Origin", request.getHeader("Origin"));
        response.setHeader("Access-Control-Allow-Credentials", "true");
        response.setHeader("P3P", "CP=CAO PSA OUR");
        if (request.getHeader("Access-Control-Request-Method") != null && "OPTIONS".equals(request.getMethod())) {
            response.addHeader("Access-Control-Allow-Methods", "POST,GET,TRACE,OPTIONS");
            response.addHeader("Access-Control-Allow-Headers", "Content-Type,Origin,Accept");
            response.addHeader("Access-Control-Max-Age", "120");
        }
        //解密
        byte[] bytes = AESUtil.parseHexStr2Byte(userName);
        byte[] decrypt1 = AESUtil.decrypt(bytes, "12345");
        String s = new String(decrypt1);
        //获取personId
       String personId =  casNoticeService.selectPersonId(s);
       return casNoticeService.selectIndexUnAudtiList(personId);
    }
    @ResponseBody
    @RequestMapping("/getList")
    public List<String> getList(String userName,HttpServletRequest request,HttpServletResponse response) {

        //cors解决跨域请求
        response.setHeader("Access-Control-Allow-Origin", request.getHeader("Origin"));
        response.setHeader("Access-Control-Allow-Credentials", "true");
        response.setHeader("P3P", "CP=CAO PSA OUR");
        if (request.getHeader("Access-Control-Request-Method") != null && "OPTIONS".equals(request.getMethod())) {
            response.addHeader("Access-Control-Allow-Methods", "POST,GET,TRACE,OPTIONS");
            response.addHeader("Access-Control-Allow-Headers", "Content-Type,Origin,Accept");
            response.addHeader("Access-Control-Max-Age", "120");
        }
        //解密
        byte[] bytes = AESUtil.parseHexStr2Byte(userName);
        byte[] decrypt1 = AESUtil.decrypt(bytes, "12345");
        String s = new String(decrypt1);
        String deptId = casNoticeService.selectDeptId(s);
        String personId = casNoticeService.selectPersonId(s);
        String level = casNoticeService.selectLevel(s);
        //首页未读通知公告
        List<Notice> noticeList = noticeService.getNoticeMoreList(personId, deptId,level);
        //待办已办
        List<IndexUnAudti> indexAudtiMoreList = workflowService.getIndexAudtiMoreList(personId);
        //待办未办
        List<IndexUnAudti> indexUnAudtiMoreList = workflowService.getIndexUnAudtiMoreList(personId);
        ArrayList<String> list = new ArrayList<>();
        list.add("通知任务,u69.png,title-innerRed");
        list.add(noticeList.size()+"");
        list.add("待办任务,u72.png,title-innerOrange");
        list.add(indexUnAudtiMoreList.size()+"");
        list.add("已办任务,u75.png,title-innerPurple");
        list.add(indexAudtiMoreList.size()+"");

        return list;

    }
}
