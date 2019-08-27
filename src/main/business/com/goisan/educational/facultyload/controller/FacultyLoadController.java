package com.goisan.educational.facultyload.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.educational.facultyload.bean.FacultyLoad;
import com.goisan.educational.facultyload.service.FacultyLoadService;
import com.goisan.educational.textbook.bean.TextBookLog;
import com.goisan.system.tools.Message;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @function:
 * @author: ZhangHao
 * @date: 2018/11/15
 */
@Controller
public class FacultyLoadController {

    /**
     * @function: 添加教学工作量
     * @author: ZhangHao
     * @date: 2018/10/29
     */
    @ResponseBody
    @RequestMapping("/facultyLoad/saveFacultyLoad")
    private Message insertFacultyLoad(FacultyLoad facultyLoad){
        return facultyLoadService.saveOrUpdateFacultyLoad(facultyLoad);
    }

    /**
     * @function: 删除教学工作量
     * @author: ZhangHao
     * @date: 2018/10/29
     */
    @ResponseBody
    @RequestMapping("/facultyLoad/deleteFacultyLoad")
    private Message deleteFacultyLoad(String ids){
        return facultyLoadService.deleteFacultyLoadByIds(ids);
    }

    /**
     * @function: 获取数据集合
     * @author: ZhangHao
     * @date: 2018/10/29
     */
    @ResponseBody
    @RequestMapping("/facultyLoad/getFacultyLoadList")
    private Map<String, Object> getFacultyLoadList(FacultyLoad facultyLoad,int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> FacultyLoadList = new HashMap<String, Object>();
        List<FacultyLoad> list= facultyLoadService.getFacultyLoadList(facultyLoad);
        PageInfo<List<FacultyLoad>> info = new PageInfo(list);
        FacultyLoadList.put("draw", draw);
        FacultyLoadList.put("recordsTotal", info.getTotal());
        FacultyLoadList.put("recordsFiltered", info.getTotal());
        FacultyLoadList.put("data", list);
        return FacultyLoadList;
    }


    /**
     * @function: 打开教学工作量列表显示页
     * @author: ZhangHao
     * @date: 2018/10/29
     */
    @RequestMapping("/facultyLoad/facultyLoadList")
    private ModelAndView resultList() {
        return new ModelAndView("/business/educational/facultyload/facultyLoadList");
    }

    /**
     * @function: 打开教学工作量添加页
     * @author: ZhangHao
     * @date: 2018/10/29
     */
    @RequestMapping("/facultyLoad/toAdd")
    private ModelAndView toAdd(Model model) {
        model.addAttribute("head", "新增");
        return new ModelAndView("/business/educational/facultyload/toAdd");
    }

    /**
     * @function: 打开教学工作量修改页
     * @author: ZhangHao
     * @date: 2018/10/29
     */
    @RequestMapping("/facultyLoad/toEdit")
    private ModelAndView toEdit(String id, Model model) {
        model.addAttribute("toEdit", facultyLoadService.getFacultyLoadById(id));
        model.addAttribute("head", "修改");
        return new ModelAndView("/business/educational/facultyload/toAdd");
    }

    @Autowired
    private FacultyLoadService facultyLoadService;
}
