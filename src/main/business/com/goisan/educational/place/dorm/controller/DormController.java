package com.goisan.educational.place.dorm.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goisan.educational.place.dorm.bean.Dorm;
import com.goisan.educational.place.dorm.service.DormService;
import com.goisan.system.bean.AutoComplete;
import com.goisan.system.tools.CommonUtil;
import com.goisan.system.tools.Message;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**寝室场地维护
 * Created by wq on 2017/7/15.
 */
@Controller
public class DormController {
    @Resource
    private DormService dormService;

    /*跳转到寝室场地维护JSP*/
    @RequestMapping("/dorm/request")
    public ModelAndView dormAction() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("business/educational/place/dorm/dormList");
        return mv;
    }

    /*管理页列表显示和查询*/
    @ResponseBody
    @RequestMapping("/dorm/getDormList")
    public Map<String, Object> getDormList(Dorm dorm, int draw, int start, int length) {
        PageHelper.startPage(start / length + 1, length);
        Map<String, Object> dorms = new HashMap<>();
        dorm.setCreator(CommonUtil.getPersonId());
        dorm.setChangeDept(CommonUtil.getDefaultDept());
        if(dorm.getDormName() != null && !"".equals(dorm.getDormName())){
            dorm.setDormName("%"+ dorm.getDormName() +"%");
        }
        List<Dorm> list = dormService.getDormList(dorm);
        PageInfo<List<Dorm>> info = new PageInfo(list);
        dorms.put("draw", draw);
        dorms.put("recordsTotal", info.getTotal());
        dorms.put("recordsFiltered", info.getTotal());
        dorms.put("data", list);
        return dorms;
    }

    /***
     * 功能：跳转到教室场地编辑界面进行新增(包括教室名称，楼宇ID，容纳人数，所在楼层，使用状态，备注)
     * modify by wq
     * @return mv界面
     */
    @ResponseBody
    @RequestMapping("/dorm/insertDorm")
    public ModelAndView insertDorm() {
        ModelAndView mv = new ModelAndView("business/educational/place/dorm/editDorm");
        mv.addObject("head", "新增");
        return mv;
    }

    /**
     * 功能：跳转到教室场地编辑界面进行修改（回显原教室场地信息）
     * modify by wq
     * @return mv界面
     */
    @ResponseBody
    @RequestMapping("/dorm/updateDorm")
    public ModelAndView updateDorm(String id) {
        ModelAndView mv = new ModelAndView("business/educational/place/dorm/addDorm");
        Dorm dorm = dormService.getDormById(id);
        mv.addObject("head", "修改");
        mv.addObject("dorm", dorm);
        return mv;
    }

    /**
     * 功能：申请信息保存（包括通过申请id是否存在选择新增或修改申请信息）
     * modify by wq
     *
     * @return 弹窗提示
     */
    @ResponseBody
    @RequestMapping("/dorm/saveDorm")
    public Message saveDorm(Dorm dorm) {
        if (dorm.getId() == null || dorm.getId().equals("")) {
            dorm.setId(CommonUtil.getUUID());
            dorm.setCreator(CommonUtil.getPersonId());
            dorm.setCreateDept(CommonUtil.getDefaultDept());
            dormService.insertDorm(dorm);
            return new Message(1, "新增成功！", null);
        } else {
            dorm.setChanger(CommonUtil.getPersonId());
            dorm.setChangeDept(CommonUtil.getDefaultDept());
            dormService.updateDorm(dorm);
            return new Message(1, "修改成功！", null);
        }
    }

    /**
     * 功能：申请信息删除（通过申请id删除申请信息）
     * modify by wq
     * @return 弹窗提示
     */
    @ResponseBody
    @RequestMapping("/dorm/deleteDorm")
    public Message deleteDorm(String id) {
        Message message=new Message();
        List<String> list = dormService.checkApplyStudent(id);
        if(list.size() > 0){
            message.setStatus(0);
            message.setMsg("当前寝室下有学生信息，不能删除！");
            message.setResult("info");
        }else {
            dormService.deleteDorm(id);
            message.setStatus(1);
            message.setMsg("删除成功！");
            message.setResult("success");
        }
        return message;
    }

    /*名称查重*/
    @ResponseBody
    @RequestMapping("/dorm/checkName")
    public Message checkName(Dorm dorm) {
        List size = dormService.checkName(dorm);
        if (size.size() > 0) {
            return new Message(1, "寝室名称重复，请重新填写！", null);
        } else {
            return new Message(0, "", null);
        }
    }
    /*查询条件--寝室名称模糊查询*/
    @ResponseBody
    @RequestMapping("/dorm/selectDormName")
    public List<AutoComplete> selectDormName() {
        return dormService.selectDormName();
    }
}
