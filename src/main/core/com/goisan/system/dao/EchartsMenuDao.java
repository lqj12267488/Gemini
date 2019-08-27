package com.goisan.system.dao;

import com.goisan.system.bean.EchartsMenu;
import com.goisan.system.bean.Select2;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/8/9.
 */
@Repository
public interface EchartsMenuDao {
    List<EchartsMenu> getrsglEcharts();
    List<EchartsMenu> getxtbgEcharts();
    List<EchartsMenu> getjwglEcharts();
    List<EchartsMenu> getxsgzEcharts();
    List<EchartsMenu> getCountDeptMajorEcharts();
    List<EchartsMenu> getkhglEcharts();
    List<EchartsMenu> getzwglEcharts();
    List<EchartsMenu> getdtglEcharts();
    List<EchartsMenu> getjsgrkjEcharts(String person);
    List<EchartsMenu> getzykEcharts();
    EchartsMenu getSxrsEcharts();
    List<EchartsMenu> gettestEcharts(); //test数据
    List<EchartsMenu> getSxlEcharts();
    Map getxjydxxtjEcharts(EchartsMenu echartsMenu);
    EchartsMenu getSjydEcharts(EchartsMenu echartsMenu);
    List<EchartsMenu> getxjydByYearEcharts(EchartsMenu echartsMenu);
    String getAchievementEcharts(@Param("id")String id,@Param("classId")String classId, @Param("couseId")String couseId);
    List<Select2> getEChartSel(@Param("id")String id);
    List<EchartsMenu> getTaskScore(@Param("id")String id,@Param("deptId")String deptId);
    List<EchartsMenu> getStudentNumber(@Param("id")String id,@Param("deptId")String deptId);
    List<EchartsMenu> getGraduationNumberByYear(@Param("id")String id,@Param("deptId")String deptId);
    List<EchartsMenu> getgraduatioByDept(@Param("id")String id,@Param("deptId")String deptId);
    List<EchartsMenu> getTeacherProportion(@Param("id")String id,@Param("deptId")String deptId);
    List<EchartsMenu> getStudentScore(@Param("id")String id,@Param("deptId")String deptId);
    List<EchartsMenu> getGraduatingByMajorECharts(@Param("id")String id,@Param("deptId")String deptId);
    List<EchartsMenu> getClassAvgScoreECharts(@Param("id")String id,@Param("deptId")String deptId);
}
