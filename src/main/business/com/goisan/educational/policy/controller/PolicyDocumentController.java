package com.goisan.educational.policy.controller;

import com.goisan.educational.policy.bean.PolicyDocument;
import com.goisan.educational.policy.service.PolicyDocumentService;
import com.goisan.system.bean.Files;
import com.goisan.system.bean.RoleEmpDeptRelation;
import com.goisan.system.service.FilesService;
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

@Controller
public class PolicyDocumentController {
    @Resource
    PolicyDocumentService policyDocumentService;
    @Resource
    FilesService filesService;
    /**
     * 国家文件页面跳转
     * @return
     */
    @RequestMapping("/nationalDocuments")
    public ModelAndView policyDocumentList() {
        ModelAndView mv = new ModelAndView();
        List<RoleEmpDeptRelation> list = policyDocumentService.getRoleByPersonId(CommonUtil.getPersonId());
        if(list.size()>0){
            mv.setViewName("/business/educational/policy/policyDocument");
        }else{
            mv.setViewName("/business/educational/policy/policyDocument1");
        }
        return mv;
    }

    /**
     * 省市文件页面跳转
     * @return
     */
    @RequestMapping("/provincialDocuments")
    public ModelAndView provincialDocumentsList() {
        ModelAndView mv = new ModelAndView();
        List<RoleEmpDeptRelation> list = policyDocumentService.getRoleByPersonId(CommonUtil.getPersonId());
        if(list.size()>0){
            mv.setViewName("/business/educational/policy/provincialDocument");
        }else{
            mv.setViewName("/business/educational/policy/provincialDocument1");
        }
        return mv;
    }

    /**
     * 学院文件页面跳转
     * @return
     */
    @RequestMapping("/collegeDocument")
    public ModelAndView collegeDocumentList() {
        ModelAndView mv = new ModelAndView();
        List<RoleEmpDeptRelation> list = policyDocumentService.getRoleByPersonId(CommonUtil.getPersonId());
        if(list.size()>0){
            mv.setViewName("/business/educational/policy/collegeDocument");
        }else{
            mv.setViewName("/business/educational/policy/collegeDocument1");
        }
        return mv;
    }

    /**
     * 国家文件首页数据查询
     * @param policyDocument
     * @return
     */
    @ResponseBody
    @RequestMapping("/policyDocument/policyDocumentAction")
    public Map<String, List<PolicyDocument>> getPolicyDocumentList(PolicyDocument policyDocument){
        Map<String, List<PolicyDocument>> policyDocumentMap = new HashMap<String, List<PolicyDocument>>();
        policyDocumentMap.put("data", policyDocumentService.policyDocumentAction(policyDocument));
        return policyDocumentMap;
    }

    /**
     * 省市文件首页数据查询
     * @param policyDocument
     * @return
     */
    @ResponseBody
    @RequestMapping("/policyDocument/provincialDocumentAction")
    public Map<String, List<PolicyDocument>> getProvincialDocumentActionList(PolicyDocument policyDocument){
        Map<String, List<PolicyDocument>> policyDocumentMap = new HashMap<String, List<PolicyDocument>>();
        policyDocumentMap.put("data", policyDocumentService.provincialDocumentAction(policyDocument));
        return policyDocumentMap;
    }
    /**
     * 学院文件首页数据查询
     * @param policyDocument
     * @return
     */
    @ResponseBody
    @RequestMapping("/policyDocument/collegeDocumentAction")
    public Map<String, List<PolicyDocument>> getCollegeDocumentActionList(PolicyDocument policyDocument){
        Map<String, List<PolicyDocument>> policyDocumentMap = new HashMap<String, List<PolicyDocument>>();
        policyDocumentMap.put("data", policyDocumentService.collegeDocumentAction(policyDocument));
        return policyDocumentMap;
    }
    @ResponseBody
    @RequestMapping("/policyDocument/addPolicyDocument")
    public ModelAndView addPolicyDocument(String id , String type) {
        ModelAndView mv = new ModelAndView("/business/educational/policy/addPolicyDocument");
        if(id==""||id==null){
            SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
            String date = formatDate.format(new Date());
            String time = formatTime.format(new Date());
            String datetime = date+'T'+time;
            PolicyDocument policyDocument =new PolicyDocument();
            policyDocument.setTime(datetime);
            mv.addObject("head", "新增");
            mv.addObject("policyDocument", policyDocument);
            if("1".equals(type)){
                mv.addObject("documentSign", "1");
            }else if("2".equals(type)){
                mv.addObject("documentSign", "2");
            }else{
                mv.addObject("documentSign", "3");
            }
        }else{
            mv.addObject("head", "修改");
            PolicyDocument policyDocument= policyDocumentService.getPolicyDocumentById(id);
            mv.addObject("policyDocument",policyDocument);
            if("1".equals(type)){
                mv.addObject("documentSign", "1");
            }else if("2".equals(type)){
                mv.addObject("documentSign", "2");
            }else{
                mv.addObject("documentSign", "3");
            }
            /*if(flag!=null) {
                if (flag.equals("1") || flag == "1") {
                    mv.addObject("head", "详情信息");
                    mv.addObject("flag", flag);
                    mv.addObject("policyDocument", policyDocumentService.getPolicyDocumentById(id));
                }
            }*/
        }
        return mv;
    }

    @ResponseBody
    @RequestMapping("/policyDocument/updatePolicyDocumentById")
    public Message updatePolicyDocument(PolicyDocument policyDocument) {
        if (policyDocument.getId() == null || policyDocument.equals("") || policyDocument.getId() == "") {
            policyDocument.setCreator(CommonUtil.getPersonId());
            policyDocument.setCreateDept(CommonUtil.getDefaultDept());
            policyDocument.setId(CommonUtil.getUUID());
            policyDocumentService.insertPolicyDocument(policyDocument);
            if("1".equals(policyDocument.getDocumentSign())){
                return new Message(1, "新增成功！", null);
            }else if("2".equals(policyDocument.getDocumentSign())){
                return new Message(2, "新增成功！", null);
            }else{
                return new Message(3, "新增成功！", null);
            }
        } else {
            policyDocument.setChanger(CommonUtil.getPersonId());
            policyDocument.setChangeDept(CommonUtil.getDefaultDept());
            policyDocumentService.updatePolicyDocumentById(policyDocument);
            if("1".equals(policyDocument.getDocumentSign())){
                return new Message(1, "修改成功！", null);
            }else if("2".equals(policyDocument.getDocumentSign())){
                return new Message(2, "修改成功！", null);
            }else{
                return new Message(3, "修改成功！", null);
            }

        }
    }

    @ResponseBody
    @RequestMapping("/policyDocument/deletePolicyDocumentById")
    public Message deletePolicyDocumentById(String id) {
        policyDocumentService.deletePolicyDocumentById(id);
        return new Message(1, "删除成功！", null);
    }

    @ResponseBody
    @RequestMapping("/policyDocument/deleteProvincialDocumentById")
    public Message deleteProvincialDocumentById(String id) {
        policyDocumentService.deletePolicyDocumentById(id);
        return new Message(1, "删除成功！", null);
    }
    @ResponseBody
    @RequestMapping("/policyDocument/deleteCollegeDocumentById")
    public Message deleteCollegeDocumentById(String id) {
        policyDocumentService.deletePolicyDocumentById(id);
        return new Message(1, "删除成功！", null);
    }

    @ResponseBody
    @RequestMapping("/policyDocument/getRoleByPersonIds")
    public Boolean getRoleByPersonIds() {
        List<RoleEmpDeptRelation> list = policyDocumentService.getRoleByPersonId(CommonUtil.getPersonId());
        if(list.size()>0){
            return true;
        }else{
            return false;
        }
    }

    @RequestMapping("/files/filesUpload1")
    public ModelAndView filesUpload(String businessId, String tableName, String businessType) {
        ModelAndView mv = new ModelAndView("core/files/addFiles1");
        List<Files> files = filesService.getFilesByBusinessId(businessId);
        mv.addObject("head", "点击文件名下载");
        mv.addObject("businessId", businessId);
        mv.addObject("tableName", tableName);
        mv.addObject("businessType", businessType);
        mv.addObject("files", files);
        return mv;
    }
}
