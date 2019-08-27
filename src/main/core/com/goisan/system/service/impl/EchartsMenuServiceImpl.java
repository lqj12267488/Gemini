package com.goisan.system.service.impl;

import com.goisan.system.bean.EchartsMenu;
import com.goisan.system.bean.LoginUser;
import com.goisan.system.bean.Select2;
import com.goisan.system.bean.TableDict;
import com.goisan.system.dao.CommonDao;
import com.goisan.system.dao.EchartsMenuDao;
import com.goisan.system.service.EchartsMenuService;
import com.goisan.system.tools.CommonUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/8/9.
 */
@Service
public class EchartsMenuServiceImpl implements EchartsMenuService {
    @Resource
    EchartsMenuDao echartsMenuDao;

    @Resource
    private CommonDao commonDao;

    public List<EchartsMenu> getrsglEcharts() {
        return echartsMenuDao.getrsglEcharts();
    }

    public List<EchartsMenu> getxtbgEcharts() {
        return echartsMenuDao.getxtbgEcharts();
    }

    public List<EchartsMenu> getjwglEcharts() {
        return echartsMenuDao.getjwglEcharts();
    }

    public List<EchartsMenu> getxsgzEcharts() {
        return echartsMenuDao.getxsgzEcharts();
    }

    public List<EchartsMenu> getCountDeptMajorEcharts(){
        return echartsMenuDao.getCountDeptMajorEcharts();
    }

    public List<EchartsMenu> getkhglEcharts() {
        return echartsMenuDao.getkhglEcharts();
    }

    public List<EchartsMenu> getzwglEcharts() {
        return echartsMenuDao.getzwglEcharts();
    }

    public List<EchartsMenu> getdtglEcharts() {
        return echartsMenuDao.getdtglEcharts();
    }

    public List<EchartsMenu> getjsgrkjEcharts(String person) {
        return echartsMenuDao.getjsgrkjEcharts(person);
    }

    public List<EchartsMenu> getzykEcharts() {
        return echartsMenuDao.getzykEcharts();
    }

    public List<EchartsMenu> gettestEcharts(){ return echartsMenuDao.gettestEcharts(); };

    public EchartsMenu getSjydEcharts(EchartsMenu echartsMenu){return echartsMenuDao.getSjydEcharts(echartsMenu);}

    public List<EchartsMenu> getxjydByYearEcharts(EchartsMenu echartsMenu){ return echartsMenuDao.getxjydByYearEcharts(echartsMenu);}

    public Map getxjydxxtjEcharts(EchartsMenu echartsMenu){
        Map map = new HashMap();
        EchartsMenu sjyd=echartsMenuDao.getSjydEcharts(echartsMenu);
        map.put("sjydEcharts",sjyd);
        List<EchartsMenu> xjydtj=echartsMenuDao.getxjydByYearEcharts(echartsMenu);
        map.put("xjydtjEcharts",xjydtj);
        return map;
    }

    public Map getSxrsEcharts() {
        Map map = new HashMap();
        EchartsMenu sxrsEcharts = echartsMenuDao.getSxrsEcharts();
        map.put("sxrsEcharts",sxrsEcharts);
        List<EchartsMenu> sxlEcharts = echartsMenuDao.getSxlEcharts();
        map.put("sxlEcharts",sxlEcharts);
        String id =CommonUtil.getPersonId();
        String deptid =CommonUtil.getLoginUser().getDefaultDeptId();
        if("sa".equals(CommonUtil.getLoginUser().getUserAccount())) {
            id ="";
            deptid ="";
        }
        String achievement = echartsMenuDao.getAchievementEcharts(id,"","");
        map.put("achievement",achievement);
        List<Select2> eChartSel = echartsMenuDao.getEChartSel(id);
        map.put("eChartSel",eChartSel);
        List<EchartsMenu> taskScore = echartsMenuDao.getTaskScore(id,deptid);
        map.put("taskScore",taskScore);
        return map;
    }

    public String getAchievementEcharts(String id,String classId,String couseId) {
        return echartsMenuDao.getAchievementEcharts(id,classId,couseId);
    }

    public Map getLeaderEcharts() {
        Map map = new HashMap();
        EchartsMenu sxrsEcharts = echartsMenuDao.getSxrsEcharts();
        map.put("sxrsEcharts",sxrsEcharts);

        List<EchartsMenu> studentNumber = echartsMenuDao.getStudentNumber("","");
        map.put("studentNumber",studentNumber);
        List<EchartsMenu> getGraduationNumberByYear = echartsMenuDao.getGraduationNumberByYear("","");
        map.put("getGraduationNumberByYear",getGraduationNumberByYear);
        List<EchartsMenu> getgraduatioByDept = echartsMenuDao.getgraduatioByDept("","");
        map.put("getgraduatioByDept",getgraduatioByDept);

        List<EchartsMenu> getTeacherProportion = echartsMenuDao.getTeacherProportion("","");
        map.put("teacherProportion",getTeacherProportion);

        TableDict tableDict = new TableDict();
        tableDict.setId(" parent_dept_id ");
        tableDict.setText(" dept_name ");
        tableDict.setTableName(" T_SYS_DEPT ");
        tableDict.setWhere(" WHERE dept_type = 8 ");
        List<Select2> tableList = commonDao.getTableDict(tableDict);
        List list = new ArrayList();
        for(Select2 select :tableList){
            list.add(select.getText());
        }
        map.put("deptList",list);


        return map;
    }

    public Map getStudentEcharts() {
        Map map = new HashMap();
        LoginUser LoginUser = CommonUtil.getLoginUser();
        String id = LoginUser.getPersonId();
        String deptid =LoginUser.getDefaultDeptId();

        if("sa".equals(CommonUtil.getLoginUser().getUserAccount())) {
            id ="";
            deptid ="";
        }else if(LoginUser.getUserType().equals("2")){
            id = LoginUser.getDefaultDeptId();
            TableDict tableDict = new TableDict();
            tableDict.setId(" user_id ");
            tableDict.setText(" default_dept ");
            tableDict.setTableName(" t_sys_user ");
            tableDict.setWhere(" WHERE user_id = '"+id+"' ");
            List<Select2> tableList = commonDao.getTableDict(tableDict);
            if(null != tableList.get(0).getText()){
                deptid = tableList.get(0).getText();
            }else{
                tableDict.setId(" student_id ");
                tableDict.setText(" class_id ");
                tableDict.setTableName(" T_XG_STUDENT_CLASS ");
                tableDict.setWhere(" WHERE student_id = '" + id + "' ");
                tableList = commonDao.getTableDict(tableDict);
                deptid = tableList.get(0).getText();
            }
        }


        List<EchartsMenu> getStudentScore = echartsMenuDao.getStudentScore(id,deptid);
        map.put("studentScore",getStudentScore);

        List<EchartsMenu> graduatingByMajorECharts = echartsMenuDao.getGraduatingByMajorECharts("",deptid);
        map.put("graduatingByMajorECharts",graduatingByMajorECharts);

        List<EchartsMenu> getClassAvgScoreECharts = echartsMenuDao.getClassAvgScoreECharts("",deptid);
        map.put("classAvgScoreECharts",getClassAvgScoreECharts);

        return map;
    }



}
