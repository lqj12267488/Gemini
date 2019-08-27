package com.goisan.type.controller;

import com.goisan.system.bean.BaseBean;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import com.goisan.type.bean.ResourceTypeCourse;
import com.goisan.type.service.ResourceExcellectTypeService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Controller
public class ResourceExcellectTypeController {

    /*
    *  add by yang  liu
    */

    /**
     * 资源所属课程类型表  typeCourse
     */
    @Resource
    private ResourceExcellectTypeService jpkResourceTypeService;

    @RequestMapping("/resourceLibrary/JPK/JPKResourceTypeShip")
    public String toJPKResourceList() {
        return "/resourcelibrary/excellect/excellectResourceTypeList";
    }

    @ResponseBody
    @RequestMapping("/resourceLibrary/JPK/getJPKResourceTypeList")
    public Map getListCourse(ResourceTypeCourse resourceTypeCourse) {
        List<BaseBean> list = jpkResourceTypeService.getJPKResourceTypeList(resourceTypeCourse);
        return CommonUtil.tableMap(jpkResourceTypeService.getJPKResourceTypeList(resourceTypeCourse));
    }
    @RequestMapping("/resourceLibrary/JPK/JPKResourceTypeAddSkip")
    public String toAddCourse(Model model) {
        model.addAttribute("head", "新增");
        return "/resourcelibrary/excellect/excellectResourceTypeEdit";
    }

    @ResponseBody
    @RequestMapping("/resourceLibrary/JPK/saveJPKResourceType")
    public Message saveJPKResourceType(ResourceTypeCourse resourceTypeCourse) {
        if ("".equals(resourceTypeCourse.getId())) {
            CommonUtil.save(resourceTypeCourse);
            jpkResourceTypeService.saveJPKResourceType(resourceTypeCourse);
            return new Message(0, "添加成功！", "success");
        } else {
            CommonUtil.update(resourceTypeCourse);
            jpkResourceTypeService.updateJPKResourceType(resourceTypeCourse);
            return new Message(0, "修改成功！", "success");
        }

    }

    @RequestMapping("/resourceLibrary/JPK/JPKResourceTypeEditSkip")
    public String toEditCourse(String id, Model model) {
        BaseBean data = jpkResourceTypeService.getJPKResourceTypeById(id);
        model.addAttribute("data", jpkResourceTypeService.getJPKResourceTypeById(id));
        model.addAttribute("head", "修改");
        return "/resourcelibrary/excellect/excellectResourceTypeEdit";
    }

    @ResponseBody
    @RequestMapping("/resourceLibrary/JPK/delJPKResourceType")
    public Message delCourse(String id) {
        String count = jpkResourceTypeService.checkType(id);
        if(null == count || count.equals("0")|| count.equals("")){
            jpkResourceTypeService.delJPKResourceType(id);
            return new Message(1, "删除成功！", "success");
        }else{
            return new Message(0, "此资源类型下有数据，目前不能删除", "error");
        }
    }
    /*
    *  add by liu  end
    * */

    /*
    *  add by yang  start
    * */

    /*
    *  add by yang  end
    * */

    /*
    *  add by zhou  start
    * */

    /*
    *  add by zhou  end
    * */



}
