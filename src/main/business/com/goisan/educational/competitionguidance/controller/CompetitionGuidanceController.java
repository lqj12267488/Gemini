package com.goisan.educational.competitionguidance.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.educational.competitionguidance.bean.CompetitionGuidance;
import com.goisan.educational.competitionguidance.dao.CompetitionGuidanceDao;
import com.goisan.educational.textbook.bean.TextBookLog;
import com.goisan.system.bean.Files;
import com.goisan.system.service.FilesService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class CompetitionGuidanceController {

    @Autowired
    CompetitionGuidanceDao competitionGuidanceDao;
    @Resource
    private FilesService filesService;
    //跳转方法
    @RequestMapping("/competitionGuidance/toCompetitionGuidance")
    public ModelAndView toCompetitionGuidance() {
        return new ModelAndView("/business/educational/competitionguidance/competitionguidanceList");
    }


    //弹出 编辑页面
    @RequestMapping("/competitionGuidance/toCompetitionGuidanceAdd")
    public ModelAndView toCompetitionGuidanceAdd() {
        ModelAndView mv = new ModelAndView("/business/educational/competitionguidance/addCompetitionguidance");
        mv.addObject("head", "竞赛辅导添加");
        mv.addObject("id", CommonUtil.getUUID());
        return mv;
    }

    @RequestMapping("/competitionGuidance/toCompetitionGuidanceEdit")
    public ModelAndView toCompetitionGuidanceEdit(String id) {
        List<Files> files=filesService.getFilesByBusinessId(id);
        StringBuffer filesName=new StringBuffer();
        for(Files file:files){
            filesName.append("<a href='/files/downloadFiles?id=").append(file.getFileId()).append("'>").append(file.getFileName()).append("<br/>");
        }
        if("".equals(filesName)){
            filesName.append("无");
        }
        ModelAndView mv = new ModelAndView("/business/educational/competitionguidance/editCompetitionguidance");
        CompetitionGuidance competitionGuidance = competitionGuidanceDao.getCompetitionGuidanceById(id);
        mv.addObject("head", "竞赛辅导修改");
        mv.addObject("competitionGuidance", competitionGuidance);
        mv.addObject("filesName", filesName);
        return mv;
    }

    //获取列表'
    @ResponseBody
    @RequestMapping("/competitionGuidance/getCompetitionGuidanceList")
    public Map<String, Object> getCompetitionGuidanceList(CompetitionGuidance guidance,int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> guidanceList = new HashMap<String, Object>();
        List<CompetitionGuidance> list = competitionGuidanceDao.getCompetitionGuidanceList(guidance);
        PageInfo<List<CompetitionGuidance>> info = new PageInfo(list);
        guidanceList.put("draw", draw);
        guidanceList.put("recordsTotal", info.getTotal());
        guidanceList.put("recordsFiltered", info.getTotal());
        guidanceList.put("data", list);
        return guidanceList;
    }


    //获取列表 BY ID
    @ResponseBody
    @RequestMapping("/competitionGuidance/getCompetitionGuidanceById")
    public CompetitionGuidance getCompetitionGuidanceById(String id) {
        return competitionGuidanceDao.getCompetitionGuidanceById(id);
    }

    //添加
    @ResponseBody
    @RequestMapping("/competitionGuidance/competitionGuidanceAdd")
    public Message competitionGuidanceAdd(CompetitionGuidance guidance) {
        guidance.setCreator(CommonUtil.getPersonId());
        guidance.setCreateDept(CommonUtil.getDefaultDept());
//        guidance.setId(CommonUtil.getUUID());
        competitionGuidanceDao.addCompetitionGuidance(guidance);
        return new Message(1, "添加成功！", null);
    }

    //添加
    @ResponseBody
    @RequestMapping("/competitionGuidance/competitionGuidanceEdit")
    public Message competitionGuidanceEdit(CompetitionGuidance guidance) {
        guidance.setChanger(CommonUtil.getPersonId());
        guidance.setChangeDept(CommonUtil.getDefaultDept());
        competitionGuidanceDao.updateCompetitionGuidance(guidance);
        return new Message(1, "修改成功！", null);
    }

    //删除
    @ResponseBody
    @RequestMapping("/competitionGuidance/competitionGuidanceDel")
    public Message competitionGuidanceDel(String id) {
        competitionGuidanceDao.delCompetitionGuidance(id);
        return new Message(1, "删除成功！", null);
    }

    //修改
    @ResponseBody
    @RequestMapping("/competitionGuidance/competitionGuidanceUpdate")
    public void competitionGuidanceUpdate(CompetitionGuidance guidance) {
        competitionGuidanceDao.updateCompetitionGuidance(guidance);
    }

}
