package com.goisan.educational.lecture.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.educational.lecture.bean.Lecture;
import com.goisan.educational.lecture.service.LectureService;
import com.goisan.educational.textbook.bean.TextBookLog;
import com.goisan.system.bean.BaseBean;
import com.goisan.system.bean.Files;
import com.goisan.system.service.FilesService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
// @RequestMapping("")
public class LectureController {

    @Resource
    private LectureService lectureService;
    @Resource
    private FilesService filesService;


    @RequestMapping("/lecture/toLectureList")
    public String toList() {
        return "/business/educational/lecture/lectureList";
    }


    @ResponseBody
    @RequestMapping("/lecture/getLectureList")
    public  Map<String, Object> getList(Lecture lecture,int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> lectureList = new HashMap<String, Object>();
        List<Lecture> list = lectureService.getLectureList(lecture);
        PageInfo<List<Lecture>> info = new PageInfo(list);
        lectureList.put("draw", draw);
        lectureList.put("recordsTotal", info.getTotal());
        lectureList.put("recordsFiltered", info.getTotal());
        lectureList.put("data", list);
        return lectureList;
    }


    @RequestMapping("/lecture/toLectureAdd")
    public String toAdd(Model model) {
        model.addAttribute("head", "新增");
        model.addAttribute("id", CommonUtil.getUUID());
        return "/business/educational/lecture/lectureAdd";
    }

    @ResponseBody
    @RequestMapping("/lecture/saveLecture")
    public Message save(Lecture lecture) {
        CommonUtil.save(lecture);
        lectureService.saveLecture(lecture);
        return new Message(0, "添加成功！", null);
    }

    @ResponseBody
    @RequestMapping("/lecture/updateLecture")
    public Message update(Lecture lecture) {
        CommonUtil.update(lecture);
        lectureService.updateLecture(lecture);
        return new Message(0, "修改成功！", null);
    }

    @RequestMapping("/lecture/toLectureEdit")
    public String toEdit(String id, Model model, HttpServletRequest request) {
        List<Files> files=filesService.getFilesByBusinessId(id);
        StringBuffer filesName= new StringBuffer();
        for(Files file:files){
            filesName.append("<a href='/files/downloadFiles?id=").append(file.getFileId()).append("'>").append(file.getFileName()).append("<br/>");
        }
        if("".equals(filesName)){
            filesName.append("无");
        }
        BaseBean baseBean = lectureService.getLectureById(id);
        model.addAttribute("filesName", filesName);
        model.addAttribute("data", lectureService.getLectureById(id));
        return "/business/educational/lecture/lectureEdit";
    }

    @ResponseBody
    @RequestMapping("/lecture/delLecture")
    public Message del(String id) {
        lectureService.delLecture(id);
        return new Message(0, "删除成功！", null);
    }

}
