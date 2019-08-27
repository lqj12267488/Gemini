package com.goisan.system.service;

import com.goisan.system.bean.EchartsMenu;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/8/9.
 */
public interface EchartsMenuService {
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
    List<EchartsMenu> gettestEcharts();

    @Transactional
    Map getxjydxxtjEcharts(EchartsMenu echartsMenu);
    EchartsMenu getSjydEcharts(EchartsMenu echartsMenu);
    List<EchartsMenu> getxjydByYearEcharts(EchartsMenu echartsMenu);
    @Transactional
    Map getSxrsEcharts();
    String getAchievementEcharts(String id,String classId,String couseId);

    @Transactional
    Map getLeaderEcharts();

    @Transactional
    Map getStudentEcharts();




}
