package com.goisan.system.controller;

import com.goisan.system.bean.ClassCadre;
import com.goisan.system.bean.Select2;
import com.goisan.system.bean.TableDict;
import com.goisan.system.service.ClassCadreService;
import com.goisan.system.service.CommonService;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Controller
public class ClassCadreController {

    @Resource
    private ClassCadreService classCadreService;
    @Resource
    private CommonService commonService;


    @RequestMapping("/classCadre/toClassCadreList")
    public ModelAndView toClassList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/core/xg/classcadre/classCadreList");
        return mv;
    }

    @ResponseBody
    @RequestMapping("/classCadre/getClassCadreList")
    public Map getList(ClassCadre classCadre) {
        return CommonUtil.tableMap(classCadreService.getClassCadreList(classCadre));
    }

    @ResponseBody
    @RequestMapping("/classCadre/checkClass")
    public Message checkClass(String classId) {
        TableDict tableDict = new TableDict();
        tableDict.setId("class_id");
        tableDict.setText("class_name");
        tableDict.setTableName(" T_XG_CLASS ");
        tableDict.setWhere(" where class_id  ='"+classId+"' ");
        List<Select2> className = commonService.getTableDict(tableDict);
        if(null == className || className.size() == 0){
            return new Message(0, "请在左侧树中选择班级", "info");
        } else {
            return new Message(1, "", "success");
        }
    }

    @RequestMapping("/classCadre/toClassCadreAdd")
    public ModelAndView toAdd(ClassCadre classCadre) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/core/xg/classcadre/classCadreEdit");
        mv.addObject("head", "新增");
        mv.addObject("classCadre", classCadre);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/classCadre/saveClassCadre")
    public Message save(ClassCadre classCadre) {
        if (null == classCadre.getId() || "".equals(classCadre.getId())) {
            classCadre.setId(CommonUtil.getUUID());
            List result = classCadreService.getClassCadreList(classCadre);
            if( null == result || result.size() == 0) {
                CommonUtil.save(classCadre);
                classCadreService.saveClassCadre(classCadre);
                return new Message(1, "添加成功！", "success");
            } else {
                return new Message(0, "添加失败,该同学已经添加此岗位的信息了！", "error");
            }
        } else {
            CommonUtil.update(classCadre);
            classCadreService.updateClassCadre(classCadre);
            return new Message(1, "修改成功！", "success");
        }
    }

    @RequestMapping("/classCadre/toClassCadreEdit")
    public String toEdit(String id, Model model) {
        model.addAttribute("data", classCadreService.getClassCadreById(id));
        model.addAttribute("head", "修改");
        return "/core/xg/classcadre/classCadreEdit";
    }

    @ResponseBody
    @RequestMapping("/classCadre/delClassCadre")
    public Message del(String id) {
        classCadreService.delClassCadre(id);
        return new Message(0, "删除成功！", "success");
    }

}
