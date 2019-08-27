package com.goisan.system.controller;

import com.goisan.system.bean.BaseBean;
import com.goisan.system.bean.EchartsMenu;
import com.goisan.system.service.EchartsMenuService;
import com.goisan.system.tools.CommonUtil;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/8/9.
 */
@Controller
public class EchartsMenuController{
    @Resource
    private EchartsMenuService echartsMenuService;


    /**
     * 人事管理
     * @return
     */
    @ResponseBody
    @RequestMapping("/echartsMenu/getrsglEcharts")
    public List<EchartsMenu> getrsglEcharts(){
        List<EchartsMenu> rsglEcharts = echartsMenuService.getrsglEcharts();
        return rsglEcharts;
    }

    /**
     * 协同办公
     * @return
     */
    @ResponseBody
    @RequestMapping("/echartsMenu/getxtbgEcharts")
    public List<EchartsMenu> getxtbgEcharts(){
        List<EchartsMenu> xtbgEcharts = echartsMenuService.getxtbgEcharts();
        return xtbgEcharts;
    }

    /**
     * 教务管理
     * @return
     */
    @ResponseBody
    @RequestMapping("/echartsMenu/getjwglEcharts")
    public List<EchartsMenu> getjwglEcharts(){
        List<EchartsMenu> jwglEcharts = echartsMenuService.getjwglEcharts();
        return jwglEcharts;
    }


    /**
     * 教务管理 测试数据
     * @return
     */

   @ResponseBody
     @RequestMapping("/echartsMenu/getTestEcharts")
        public List<EchartsMenu> getTestEcharts() {
        List<EchartsMenu> jwglEcharts = echartsMenuService.gettestEcharts();
        return jwglEcharts;
        }


    /**
     * 学生工作
     * @return
     */
    @ResponseBody
    @RequestMapping("/echartsMenu/getxsgzEcharts")
    public List<EchartsMenu> getxsgzEcharts(){
        List<EchartsMenu> xsgzEcharts = echartsMenuService.getxsgzEcharts();
        return xsgzEcharts;
    }
    /**
     * 学生工作-校区年级人数统计
     * @return
     */
    @RequestMapping("/echartsMenu/countDeptMajorEcharts")
    public ModelAndView countDeptMajorEcharts(){
        return new ModelAndView("/business/studentwork/studentCountEcharts/countDeptMajorEcharts");
    }
    @ResponseBody
    @RequestMapping("/echartsMenu/getCountDeptMajorEcharts")
    public List<EchartsMenu> getCountDeptMajorEcharts(){
        EchartsMenu echartsMenu=new EchartsMenu();
        List<EchartsMenu> xsgzEcharts = echartsMenuService.getCountDeptMajorEcharts();
        return xsgzEcharts;
    }

    /**
     * 考核管理
     * @return
     */
    @ResponseBody
    @RequestMapping("/echartsMenu/getkhglEcharts")
    public List<EchartsMenu> getkhglEcharts(){
        List<EchartsMenu> khglEcharts = echartsMenuService.getkhglEcharts();
        return khglEcharts;
    }

    /**
     * 总务管理
     * @return
     */
    @ResponseBody
    @RequestMapping("/echartsMenu/getzwglEcharts")
    public List<EchartsMenu> getzwglEcharts(){
        List<EchartsMenu> zwglEcharts = echartsMenuService.getzwglEcharts();
        return zwglEcharts;
    }

    /**
     * 党团管理
     * @return
     */
    @ResponseBody
    @RequestMapping("/echartsMenu/getdtglEcharts")
    public List<EchartsMenu> getdtglEcharts(){
        List<EchartsMenu> dtglEcharts = echartsMenuService.getdtglEcharts();
        return dtglEcharts;
    }

    /**
     * 教师个人空间管理
     * @return
     */
    @ResponseBody
    @RequestMapping("/echartsMenu/getjsgrkjEcharts")
    public List<EchartsMenu> getjsgrkjEcharts(){
        String person = CommonUtil.getPersonId();
        System.out.println(person);
        List<EchartsMenu> jsgrkjEcharts = echartsMenuService.getjsgrkjEcharts(person);
        return jsgrkjEcharts;
    }

    /**
     * 资源库
     * @return
     */
    @ResponseBody
    @RequestMapping("/echartsMenu/getzykEcharts")
    public List<EchartsMenu> getzykEcharts(){
        List<EchartsMenu> zykEcharts = echartsMenuService.getzykEcharts();
        return zykEcharts;
    }

    /**
     * 教师首页  展示总就业人数和非就业人数
     */
    @ResponseBody
    @RequestMapping("/echartsMenu/getSxrsEcharts")
    public Map getSxrsEcharts(){
        Map map = echartsMenuService.getSxrsEcharts();
        return map;
    }

    @ResponseBody
    @RequestMapping("/echartsMenu/getAchievementEcharts")
    public String getAchievementEcharts(String classId,String couseId){
        String id =CommonUtil.getPersonId();
        if("sa".equals(CommonUtil.getLoginUser().getUserAccount())) {
            id ="";
        }
        return echartsMenuService.getAchievementEcharts( id, classId, couseId);
    }


    /**
     * 教师首页  展示总就业人数和非就业人数
     */
    @ResponseBody
    @RequestMapping("/echartsMenu/getLeaderEcharts")
    public Map getLeaderEcharts(){
        Map map = echartsMenuService.getLeaderEcharts();
        return map;
    }

    @ResponseBody
    @RequestMapping("/echartsMenu/getStudentEcharts")
    public Map getStudentEcharts(){
        Map map = echartsMenuService.getStudentEcharts();
        return map;
    }

    /**
     * 学籍异动信息统计
     * @return
     */
    @ResponseBody
    @RequestMapping("/echartsMenu/getxjydxxtjEcharts")
    public Map getxjydxxtjEcharts(String departmentsId,String majorCode,String classId){
        EchartsMenu echartsMenu =new EchartsMenu();
        echartsMenu.setDepartmentsId(departmentsId);
        echartsMenu.setMajorCode(majorCode);
        echartsMenu.setClassId(classId);
        Map map = echartsMenuService.getxjydxxtjEcharts(echartsMenu);
        return map;
    }
}
