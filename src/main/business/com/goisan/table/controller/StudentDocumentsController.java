package com.goisan.table.controller;

import com.goisan.table.bean.StudentDocuments;
import com.goisan.table.service.StudentDocumentsService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.system.bean.BaseBean;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
public class StudentDocumentsController {

    @Resource
    private StudentDocumentsService studentDocumentsService;

    @RequestMapping("/StudentDocuments/toStudentDocumentsList")
    public String toStudentDocumentsList() {
        return "/business/table/studentDocuments/studentDocumentsList";
    }

    @ResponseBody
    @RequestMapping("/StudentDocuments/getStudentDocumentsList")
    public Map<String,Object> getStudentDocumentsList(StudentDocuments studentDocuments,int draw, int start, int length) {
         PageHelper.startPage(start / length + 1, length);
         Map<String, Object> map = new HashMap(16);
         List<BaseBean> list =  studentDocumentsService.getStudentDocumentsList(studentDocuments);
         PageInfo<List<BaseBean>> info = new PageInfo(list);
         map.put("draw", draw);
         map.put("recordsTotal", info.getTotal());
         map.put("recordsFiltered", info.getTotal());
         map.put("data", list);
        return map;
    }

    @RequestMapping("/StudentDocuments/toStudentDocumentsAdd")
    public String toAddStudentDocuments(Model model) {
        model.addAttribute("head", "新增");
        return "/business/table/studentDocuments/studentDocumentsEdit";
    }

    @ResponseBody
    @RequestMapping("/StudentDocuments/saveStudentDocuments")
    public Message saveStudentDocuments(StudentDocuments studentDocuments) {
        if (null != studentDocuments.getId() && !"".equals(studentDocuments.getId())) {
           CommonUtil.update(studentDocuments);
            studentDocumentsService.updateStudentDocuments(studentDocuments);
            return new Message(0, "修改成功！", null);
        } else {
            CommonUtil.save(studentDocuments);
            studentDocumentsService.saveStudentDocuments(studentDocuments);
            return new Message(0, "添加成功！", null);
        }
    }

    @RequestMapping("/StudentDocuments/toStudentDocumentsEdit")
    public String toEditStudentDocuments(String id, Model model) {
        StudentDocuments studentDocuments = studentDocumentsService.getStudentDocumentsById(id);
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        studentDocuments.setAlterationdateStr(simpleDateFormat.format(studentDocuments.getAlterationdate()));
        studentDocuments.setReleasedateStr(simpleDateFormat.format(studentDocuments.getReleasedate()));
        model.addAttribute("data", studentDocuments);
        model.addAttribute("head", "修改");
        return "/business/table/studentDocuments/studentDocumentsEdit";
    }

    @ResponseBody
    @RequestMapping("/StudentDocuments/delStudentDocuments")
    public Message delStudentDocuments(String id) {
        studentDocumentsService.delStudentDocuments(id);
        return new Message(0, "删除成功！", null);
    }

}
